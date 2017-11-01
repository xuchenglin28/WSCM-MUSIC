# WSCM-MUSIC
Weighted Spatial Covariance Matrix Estimation for MUSIC based TDOA Estimation of Speech Source

Please cite:
  Chenglin Xu, Xiong Xiao, Sining Sun, Wei Rao, Eng Siong Chng, and Haizhou Li. 
  "Weighted Spatial Covariance Matrix Estimation for MUSIC based TDOA 
  Estimation of Speech Source." Proc. Interspeech 2017 (2017): 1894-1898.
  
  How to use:
  1. Unzip the nnet/nnet.mat.7z.001 \n
     Use the command: 7z e nnet/nnet.mat.7z.001
  2. Add "SignalGraph" toolbox in the matlab path
     Clone the SignalGraph: git clone https://github.com/singaxiong/SignalGraph.git
     Change matlab workplace to SignalGraph folder and run: AddMyPath
     If you want to use gpu, run: gpuDevice()
  3. Run: [eTDOA, eDOA] = evalSCMTDOA_music('./data')
