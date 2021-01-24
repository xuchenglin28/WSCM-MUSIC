# WSCM-MUSIC
Weighted Spatial Covariance Matrix Estimation for MUSIC based TDOA Estimation of Speech Source

Please cite:

  Chenglin Xu, Xiong Xiao, Sining Sun, Wei Rao, Eng Siong Chng, and Haizhou Li. 
  "Weighted Spatial Covariance Matrix Estimation for MUSIC based TDOA Estimation of Speech Source." 
  Proc. Interspeech 2017 (2017): 1894-1898.
  
  How to use:
  1. Unzip the nnet/nnet.mat.7z.001 
  
     Use the command: 7z e nnet/nnet.mat.7z.001
     
  2. Add "SignalGraph" toolbox in the matlab path
  
     Clone the SignalGraph: git clone https://github.com/singaxiong/SignalGraph.git
     
     Change matlab workplace to SignalGraph folder and run: AddMyPath
     
     If you want to use gpu, run: gpuDevice()
     
  3. Run: [eTDOA, eDOA] = evalSCMTDOA_music('./data')

## Licence

The code and models in this repository are licensed under the GNU General Public License Version 3.

## Citation
If you would like to cite, use this :
```BibTex
@inproceedings{xu2017weighted,
  title={Weighted Spatial Covariance Matrix Estimation for MUSIC Based TDOA Estimation of Speech Source.},
  author={Xu, Chenglin and Xiao, Xiong and Sun, Sining and Rao, Wei and Chng, Eng Siong and Li, Haizhou},
  booktitle={Proc. of INTERSPEECH},
  pages={1894--1898},
  year={2017}
}
```
