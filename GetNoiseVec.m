function noiseEigVec = GetNoiseVec(A, Nsig)
% Author: Xu Chenglin (NTU, Singapore)
% Date: 3 Dec 2016
% Format: 1 Nov 2017

if nargin<2
    Nsig = 1;
end

a = isnan(A);
if sum(sum(a)) == 0
    
    [V,D] = eig(A);
    
    % Sort eigenvectors
    [~,indx1] = sort(diag(D),'descend');
    eigenvects = V(:,indx1);
    
    % Separate the signal and noise eigenvectors
    noiseEigVec = eigenvects(:,Nsig+1:end);
else
    tmp = zeros(size(A));
    noiseEigVec = tmp(:,Nsig+1:end);
end
end
