function [eTDOA, eDOA] = evalSCMTDOA_music(wav_root)
% Given the wavfile root, this script will predict their tdoa and doa value
%
% @@prerequisites: add "SingalGraph" toolbox into the path
%                  (https://github.com/singaxiong/SignalGraph)
%
% @inputs: 
%     wav_root: wavfile directory (each channel is in one file, i.e., "*_ch1.wav")
% @outputs:
%     eTDOA: estimated TDOA
%     eDOA: estimated DOA
%
% Please cite our paper,
% Chenglin Xu, Xiong Xiao, Sining Sun, Wei Rao, Eng Siong Chng, and Haizhou Li. 
% "Weighted Spatial Covariance Matrix Estimation for MUSIC based TDOA 
% Estimation of Speech Source." Proc. Interspeech 2017 (2017): 1894-1898.
%
% Author: Xu Chenglin (NTU, Singapore)
% Date: 3 Dec 2016
% Format: 1 Nov 2017


if nargin < 1
    wav_root = './data';
end

% load the mask prediction network, the spatial covariance matrix is also
% calculated with the estimated mask in the network.
dnn = load('nnet/nnet.mat');

wavreader.name = 'wavfile';
wavreader.array = 1;
wavreader.multiArrayFiles = 1;

% Our configure (8 channels circular array with diameter 0.2m)
nCh = 8;
wlen = 512;
fbins = wlen/2+1;
fs = 16000;

wavfiles = findFiles_xcl(wav_root, 'ch1.wav');

for utt_ind=1:length(wavfiles)
    wavfile = wavfiles{utt_ind};
    
    clear wavfileArray;
    for i=1:nCh
        wavfileArray{i} = [wavfile(1:end-5) num2str(i) '.wav'];
    end
    
    [wav] = InputReader(wavfileArray, wavreader);
    wav = StoreWavInt16(wav);
    Data(1).data{1} = wav;
    output = FeatureTree2(Data, dnn.para, dnn.layer);
    output = gather(output{1}{1});
    
    covMat = reshape(output, nCh, nCh, fbins, size(output,2));
    covMat = covMat(:,:,2:end,:);
    covMatCell = num2cell(covMat, [1 2]);
    noiseEigVecCell = cellfun(@GetNoiseVec, covMatCell, 'UniformOutput', 0);
    
    % Get steering vectors for all angles from [0, 359]
    tdoa_grid = linspace(0, 359, 360);
    tau = doa2tdoa(tdoa_grid);
    f = fs/wlen*(1:wlen/2);
    Nsig = 1; % assuming only one speaker, if more, please specify.
    for f_i=1:length(f)
        freq = f(f_i);
        if isscalar(freq)
            sv = exp(-1i*2*pi*freq*tau);
        else
            freqtau = reshape(tau(:)*freq,...
                size(tau,1),size(tau,2),[]);
            sv = exp(-1i*2*pi*freqtau);
        end
        
        % Calculate the spatial spectrum. Add a small positive constant to prevent
        % division by zero.
        noise_eigenvects = noiseEigVecCell{:,:,f_i};
        D = sum(abs((sv'*noise_eigenvects)).^2,2)+eps(1); % 9.44 in [1]
        spec = sqrt(1./D).';
        
        spec_all(:,f_i) = spec;
    end
    spec = sum(spec_all,2);
    % Find DOA
    [~,locs] = findpeaks(double(spec),'SortStr','descend');
    D = min(Nsig,length(locs));
    assert(D <= Nsig);
    if D>0
        f_angles = tdoa_grid(locs(1:D));
    else
        f_angles = zeros(1,0);
    end
    eDOA{utt_ind} = f_angles;
    eTDOA{utt_ind} = trueTDOA(f_angles);
    
end

end
