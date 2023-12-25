
**See [hepforge](https://reapmpt.hepforge.org/) for the official version of REAP-MPT.**

# REAP

REAP (Renormalization group Evolution of Angles and Phases) is a Mathematica package for solving the renormalization group equations (RGEs) of the quantities relevant to neutrino masses, for example the dimension-5 Weinberg operator, the Yukawa matrices and the gauge couplings.
- Currently the effective dimension-5 neutrino mass operator is implemented in the Standard Model (SM), the Minimal Supersymmetric Standard Model (MSSM) and the two Higgs doublet model with a Z2 symmetry (2HDM).
- The type-I seesaw scenario is implemented in the SM, MSSM and 2HDM including the contribution of the effective dimension-5 operator.
- The type-II seesaw is implemented in the SM and MSSM [0705.3841] including a possible type-I seesaw contribution and the contribution of the effective dimension-5 operator.
- Dirac neutrinos are implemented for the SM, MSSM and 2HDM.
- Minimal conformal LR symmetric model [0911.0710].
- It can also be used to predict the sparticle spectrum including SUSY threshold corrections using SusyTC [1512.06727]. The REAP model file RGEMSSMsoftbroken.m and SusyTC.m can be downloaded from [particlesandcosmology.unibas.ch/pages/SusyTC.htm](particlesandcosmology.unibas.ch/pages/SusyTC.htm).

Heavy degrees of freedom such as singlet neutrinos can be integrated out automatically at the correct mass thresholds.

# MPT
The package MixingParameterTools allows to extract the lepton masses, mixing angles and CP phases from the mass matrices of the neutrinos and the charged leptons. Thus, the running of the neutrino mass matrix calculated by REAP can be translated into the running of the mixing parameters and the mass eigenvalues. MixingParameterTools can also be useful as a stand-alone application in order to study textures without running, and it is not bound to the analysis of neutrino masses only but may be used for quark and superpartner mass matrices as well.

# Authors
REAP and MPT are maintained by

- Stefan Antusch
- Jörn Kersten
- Manfred Lindner
- Michael Ratz
- Michael A. Schmidt

If you use REAP or MPT in a scientific publication or talk, please give proper academic credit to us by citing our paper: [JHEP 0503 (2005) 024 [hep-ph/0501272]](http://arxiv.org/abs/hep-ph/0501272).

# Credits
The development of REAP and MPT has been and is financially supported by:

- Physik-Department der Technischen Universität München
- Sonderforschungsbereich 375 für Astro-Teilchenphysik der Deutschen Forschungsgemeinschaft
- Deutsches Elektronen-Synchrotron DESY, Hamburg
- University of Southampton, UK
- Physikalisches Institut der Universität Bonn, Germany
