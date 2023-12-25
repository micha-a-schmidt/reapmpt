(* The package `REAP' is written for Mathematica 7 and is distributed under the
terms of GNU Public License http://www.gnu.org/copyleft/gpl.html *)




BeginPackage["REAP`RGESM0N`",{"REAP`RGESymbol`","REAP`RGESolver`","REAP`RGEParameters`","REAP`RGEUtilities`","REAP`RGETakagi`","MixingParameterTools`MPT3x3`","REAP`RGEInitial`","REAP`RGEMSSM0N`"}];

Print["SM0N: Two loop RG equation of \[Kappa] not implemented yet."];

(* register SM0N *)
RGERegisterModel["SM0N","REAP`RGESM0N`",
	`Private`GetParameters,
        `Private`SolveModel,
        {RGEM\[Nu]->`Private`GetM\[Nu],RGEYu->`Private`GetYu,RGE\[Lambda]->`Private`Get\[Lambda],RGEMd->`Private`GetMd,RGEMixingParameters->`Private`GetMixingParameters,RGEPoleMTop->`Private`GetPoleMTop,RGEAll->`Private`GetSolution,RGEM\[Nu]r->`Private`GetM\[Nu]r,RGEMe->`Private`GetMe,RGETwistingParameters->`Private`GetTwistingParameters,RGERaw->`Private`GetRawSolution,RGEYe->`Private`GetYe,RGE\[Kappa]->`Private`Get\[Kappa],RGEMu->`Private`GetMu,RGEY\[Nu]->`Private`GetY\[Nu],RGE\[Alpha]->`Private`Get\[Alpha],RGEYd->`Private`GetYd,RGECoupling->`Private`GetCoupling},
{{"MSSM",`Private`TransMSSM},{"SM",`Private`TransSM},{"SM0N",`Private`TransSM0N},{"MSSM0N",`Private`TransMSSM0N}},
        `Private`GetInitial,
        `Private`ModelSetOptions,
        `Private`ModelGetOptions
         ];


Begin["`Private`"];
Map[Needs,{"REAP`RGESymbol`","REAP`RGESolver`","REAP`RGEParameters`","REAP`RGEUtilities`","REAP`RGETakagi`","MixingParameterTools`MPT3x3`","REAP`RGEInitial`","REAP`RGEMSSM0N`"}];

ModelName="SM0N";
ModelVariants={"1Loop","2Loop"};
RGE={RGE1Loop,RGE2Loop};

ClearAll[GetRawSolution];
GetRawSolution[pScale_,pSolution_,pOpts___]:=Block[{},
(* returns all parameters of the SM *)
        Return[(ParametersFunc[pScale]/.pSolution)[[1]]];
];

(* GetRawM\[Nu]r is not a function of SM0N *)
(* GetRawY\[Nu] is not a function of SM0N *)
ClearAll[GetCoupling];
GetCoupling[pScale_,pSolution_,pOpts___]:=Block[{},
(* returns the coupling constants *)
   Return[({g1[pScale],g2[pScale],g3[pScale]}/.pSolution)[[1]]];
];

ClearAll[Get\[Alpha]];
Get\[Alpha][pScale_,pSolution_,pOpts___]:=Block[{lg},
(* returns the fine structure constants *)
    lg=({g1[pScale],g2[pScale],g3[pScale]}/.pSolution)[[1]];
    Return[lg^2/(4*Pi)];
];

ClearAll[Get\[Lambda]];
Get\[Lambda][pScale_,pSolution_,pOpts___]:=Block[{},
(* returns the coupling constants *)
   Return[(\[Lambda][pScale]/.pSolution)[[1]]];
];

(* GetM\[CapitalDelta]2 is not a function of SM0N *)
(* GetM\[CapitalDelta] is not a function of SM0N *)
ClearAll[GetYe];
GetYe[pScale_,pSolution_,pOpts___]:=Block[{},
(* returns the Yukawa coupling matrix of the charged leptons *)
    Return[(Ye[pScale]/.pSolution)[[1]]];
];

ClearAll[GetYu];
GetYu[pScale_,pSolution_,pOpts___]:=Block[{},
(* returns the Yukawa coupling matrix of the up-type quarks *)
    Return[(Yu[pScale]/.pSolution)[[1]]];
];

ClearAll[GetYd];
GetYd[pScale_,pSolution_,pOpts___]:=Block[{},
(* returns the Yukawa coupling matrix of the down-type quarks *)
    Return[(Yd[pScale]/.pSolution)[[1]]];
];

(* GetRawY\[CapitalDelta] is not a function of SM0N *)
ClearAll[GetY\[Nu]];
GetY\[Nu][pScale_,pSolution_,pOpts___]:=Block[{lY\[Nu]high,lCutoff},
(* returns the mass matrix of the heavy neutrinos *)
            lCutoff=RGEGetCutoff[Exp[pScale],1];
            lY\[Nu]high=RGEGetSolution[lCutoff,RGEY\[Nu],1];
        Return[lY\[Nu]high];
];

ClearAll[Get\[Kappa]];
Get\[Kappa][pScale_,pSolution_,pOpts___]:=Block[{l\[Kappa]},
(* returns \[Kappa] *)
	l\[Kappa]=(\[Kappa][pScale]/.pSolution)[[1]];
        Return[l\[Kappa]];
];

(* Get\[Kappa]1 is not a function of SM0N *)
(* Get\[Kappa]2 is not a function of SM0N *)
ClearAll[GetM\[Nu]r];
GetM\[Nu]r[pScale_,pSolution_,pOpts___]:=Block[{lMhigh,lCutoff},
(* returns the mass matrix of the heavy neutrinos *)
            lCutoff=RGEGetCutoff[Exp[pScale],1];
            lMhigh=RGEGetSolution[lCutoff,RGEM\[Nu]r,1];
        Return[lMhigh];
];

ClearAll[GetM\[Nu]];
GetM\[Nu][pScale_,pSolution_,pOpts___]:=Block[{l\[Kappa],lvu},
(* returns the mass matrix of the neutrinos *)
	l\[Kappa]=(\[Kappa][pScale]/.pSolution)[[1]];
	lOpts;
	Options[lOpts]=Options[RGEOptions];
	SetOptions[lOpts,RGEFilterOptions[lOpts,pOpts]];
	lvu=RGEv\[Nu]/.Options[lOpts];

	Return[-lvu^2*(1/2)^2*10^9*l\[Kappa]];
];

ClearAll[GetMu];
GetMu[pScale_,pSolution_,pOpts___]:=Block[{lMu,lvu},
(* returns the mass matrix of the up-type quarks *)
   lOpts;
   Options[lOpts]=Options[RGEOptions];
   SetOptions[lOpts,RGEFilterOptions[lOpts,pOpts]];
   lvu=RGEvu/.Options[lOpts];
   lMu=lvu/Sqrt[2]*(Yu[pScale]/.pSolution)[[1]];
   Return[lMu];
];

ClearAll[GetPoleMTop];
GetPoleMTop[pScale_,pSolution_,pOpts___]:=Block[{lMtop,lg3,lScale,lPrecision,lCount},
(* returns the mass matrix of the up-type quarks *)
   lPrecision=RGEPrecision/.pOpts/.RGETransition->6;
   lCountMax=RGEMaxNumberIterations/.pOpts/.RGEMaxNumberIterations->20;
   lScale=Exp[pScale];
   lg3=RGEGetSolution[lScale,RGECoupling][[3]];
   lMu=RGEGetSolution[lScale,RGEMu];
   lMtop=Sqrt[Max[Abs[Eigenvalues[Dagger[lMu].lMu]]]*(1+lg3^2/3/Pi)];
   lCount=0;
   While[RGEFloor[Abs[lMtop-lScale],RGEPrecision->lPrecision]>0,
	lScale=lMtop;
	lg3=RGEGetSolution[lScale,RGECoupling][[3]];
	lMu=RGEGetSolution[lScale,RGEMu];
	lMtop=Sqrt[Max[Abs[Eigenvalues[Dagger[lMu].lMu]]]*(1+lg3^2/3/Pi)];
	lCount++;
	If[lCount>lCountMax,
		Print["RGEGetsolution[pScale,RGEPoleMTop]: algorithm to search transitions does not converge. There have been ",lCount," iterations so far. Returning: ",N[Sort[lTransitions,Greater],lPrecision]];
		Return[lMtop];
            ];
	];
   Return[lMtop];
];

ClearAll[GetMd];
GetMd[pScale_,pSolution_,pOpts___]:=Block[{lMd,lvd},
(* returns the mass matrix of the down-type quarks *)
   lOpts;
   Options[lOpts]=Options[RGEOptions];
   SetOptions[lOpts,RGEFilterOptions[lOpts,pOpts]];
   lvd=RGEvd/.Options[lOpts];
   lMd=lvd/Sqrt[2]*(Yd[pScale]/.pSolution)[[1]];
   Return[lMd];
];

ClearAll[GetMe];
GetMe[pScale_,pSolution_,pOpts___]:=Block[{lMe,lvd},
(* returns the mass matrix of the charged leptons *)
   lOpts;
   Options[lOpts]=Options[RGEOptions];
   SetOptions[lOpts,RGEFilterOptions[lOpts,pOpts]];
   lvd=RGEve/.Options[lOpts];
   lMe=lvd/Sqrt[2]*(Ye[pScale]/.pSolution)[[1]];
   Return[lMe];
];

ClearAll[GetSolution];
GetSolution[pScale_,pSolution_,pOpts___]:=Block[{lg1,lg2,lg3,lYu,lYd,lYe,lM,lY\[Nu],l\[Kappa],l\[Lambda]},
(* returns all parameters of the SM *)
        {lg1,lg2,lg3,lYu,lYd,lYe,l\[Kappa],l\[Lambda]}=(ParametersFunc[pScale]/.pSolution)[[1]];
	lM=GetM\[Nu]r[pScale,pSolution,pOpts];
	lY\[Nu]=GetY\[Nu][pScale,pSolution,pOpts];
        Return[{lg1,lg2,lg3,lYu,lYd,lYe,lY\[Nu],l\[Kappa],lM,l\[Lambda]}];
];

ClearAll[GetMixingParameters];
GetMixingParameters[pScale_,pSolution_,pOpts___]:=Block[{lM,lYe},
(* returns the leptonic mixing parameters *)
   lM=GetM\[Nu][pScale,pSolution,pOpts];
   lYe=GetYe[pScale,pSolution,pOpts];
   Return[MNSParameters[lM,lYe]];
];

ClearAll[GetTwistingParameters];
GetTwistingParameters[pScale_,pSolution_,pOpts___]:=Block[{lY\[Nu],lYe},
(* returns the mixing parameters of the twisting matrix between Ye^\dagger Ye and Y\nu^\dagger Y\nu *)
   lY\[Nu]=GetY\[Nu][pScale,pSolution,pOpts];
   lYe=GetYe[pScale,pSolution,pOpts];
    Return[MNSParameters[Dagger[lY\[Nu]].lY\[Nu],Dagger[lYe].lYe]];
];

(* GetM1Tilde is not a function of SM0N *)
(* Get\[Epsilon]1Max is not a function of SM0N *)
(* Get\[Epsilon]1 is not a function of SM0N *)
(* GetGWCond is not a function of SM0N *)
(* GetGWConditions is not a function of SM0N *)
(* GetVEVratio is not a function of SM0N *)
(* GetVEVratios is not a function of SM0N *)
ClearAll[Dagger];
RGEvu:=N[RGEvEW];
RGEvd:=RGEvu;
RGEv\[Nu]:=RGEvu;
RGEve:=RGEvd;

ClearAll[Dagger];
(*shortcuts*)
Dagger[x_] := Transpose[Conjugate[x]];

ClearAll[GetParameters];
GetParameters[]:= Block[{},
(* returns the parameters of the model *)
   Return[ParameterSymbols];
];

ClearAll[ModelSetOptions];
ModelSetOptions[pOpts_]:= Block[{},
(* sets the options of the model *)
    SetOptions[RGEOptions,RGEFilterOptions[RGEOptions,pOpts]];
];

ClearAll[ModelGetOptions];
ModelGetOptions[]:= Block[{},
(* returns the options *)
   Return[Options[RGEOptions]];
];

ClearAll[GetInitial];
GetInitial[pOpts___]:=Block[{lSuggestion,lIndexSuggestion,lInitial,lParameters,lParameterRepl},
(* returns the suggested initial values *)
   lOpts;
   Options[lOpts]=Options[RGEOptions];
   SetOptions[lOpts,RGEFilterOptions[lOpts,pOpts]];
   lSuggestion=(RGESuggestion/.pOpts)/.{RGESuggestion->"*"};
   lIndexSuggestion=1;
   While[lIndexSuggestion<=Length[Initial] && !StringMatchQ[Initial[[lIndexSuggestion,1]],lSuggestion],	lIndexSuggestion++ ];
   lInitial=Initial[[ lIndexSuggestion,2 ]];
   lParameters=ParameterSymbols/.pOpts/.lInitial/.pOpts/.lInitial/.pOpts/.lInitial/.Options[lOpts];
   Return[Table[ParameterSymbols[[li]]->lParameters[[li]], {li,Length[ParameterSymbols]}]];
   ];

ClearAll[SolveModel];
SolveModel[{pUp_?NumericQ,pUpModel_,pUpOptions_},{pDown_?NumericQ,pDownModel_,pDownOptions_},pDirection_?NumericQ,pBoundary_?NumericQ,pInitial_,pNDSolveOpts_,pOpts___]:=Block[{lSolution,lInitial,lODE,lIndexModel},
(* solves the model and returns the solution, pDown and 0, because the function does not add any models*)
	lNDSolveOpts;
	Options[lNDSolveOpts]=Options[NDSolve];
	SetOptions[lNDSolveOpts,RGEFilterOptions[NDSolve,Options[RGEOptions]]];
	SetOptions[lNDSolveOpts,RGEFilterOptions[NDSolve,pOpts]];
	SetOptions[lNDSolveOpts,RGEFilterOptions[NDSolve,Sequence[pNDSolveOpts]]];

	lOpts;
        Options[lOpts]=Options[RGEOptions];
        SetOptions[lOpts,RGEFilterOptions[lOpts,pOpts]];


	lInitial=SetInitial[pBoundary,pInitial];
	lIndexModel=Flatten[ Position[ModelVariants,(RGEModelVariant/.Options[lOpts])] ][[ 1 ]];
	lODE=RGE[[lIndexModel]]/.Options[lOpts];

	lSolution=NDSolve[lODE ~Join~ lInitial, Parameters,{t,pDown,pUp}, Sequence[Options[lNDSolveOpts]]];
	Return[{lSolution,pDown,0}];
];


(* definitions for the Standard Model (SM) *)

ClearAll[RGEOptions];
RGEOptions;
Options[RGEOptions]={		  RGEModelVariant->"1Loop", (* different variation of the model *)
			  RGEAutoGenerated->False, (* used to find automatically generated entries *)
				  RGEvEW->246, (* vev for the electroweak transition *)
				  RGE\[Lambda]->0.522091, (* initial value for \[Lambda] *)
				  Method->StiffnessSwitching  (* option of NDSolve *)
};

Parameters={g1,g2,g3,Yu,Yd,Ye,\[Kappa],\[Lambda]}; 
ParameterSymbols={RGEg1,RGEg2,RGEg3,RGEYu,RGEYd,RGEYe,RGE\[Kappa],RGE\[Lambda]};


ClearAll[Initial];
Initial={
{"GUT",{
	RGEg1->0.5787925294736758,
	RGEg2->0.5214759925514961,
	RGEg3->0.5269038649895842,
	RGEYd->RGEGetYd[RGEyd,RGEys,RGEyb,RGEq\[Theta]12,RGEq\[Theta]13,RGEq\[Theta]23,RGEq\[Delta],RGEq\[Delta]e,RGEq\[Delta]\[Mu],RGEq\[Delta]\[Tau],RGEq\[CurlyPhi]1,RGEq\[CurlyPhi]2],
	RGEYu->DiagonalMatrix[{RGEyu,RGEyc,RGEyt}],
	RGEq\[Theta]12 -> 12.5216 Degree,
	RGEq\[Theta]13 -> 0.219376 Degree, 
	RGEq\[Theta]23 -> 2.48522 Degree,
	RGEq\[Delta] -> 353.681 Degree,
	RGEq\[CurlyPhi]1 -> 0 Degree,
	RGEq\[CurlyPhi]2 -> 0 Degree, 
	RGEq\[Delta]e -> 0 Degree,
	RGEq\[Delta]\[Mu] -> 0 Degree,
	RGEq\[Delta]\[Tau] -> 0 Degree,
	RGEyu -> 0.94*10^-3*Sqrt[2]/RGEvu,
	RGEyc -> 0.272*Sqrt[2]/RGEvu,
	RGEyt -> 84*Sqrt[2]/RGEvu,
	RGEyd -> 1.94*10^-3*Sqrt[2]/RGEvd,
	RGEys -> 38.7*10^-3*Sqrt[2]/RGEvd,
	RGEyb -> 1.07*Sqrt[2]/RGEvd,
	RGEye -> 0.49348567*10^-3*Sqrt[2]/RGEve,
	RGEy\[Mu] -> 104.15246*10^-3*Sqrt[2]/RGEve,
	RGEy\[Tau] -> 1.7706*Sqrt[2]/RGEve,
	RGEMassHierarchy -> "n",
	RGE\[Theta]12 -> 33 Degree,
	RGE\[Theta]13 -> 0 Degree, 
	RGE\[Theta]23 -> 45 Degree,
	RGE\[Delta] -> 0 Degree,
	RGE\[Delta]e -> 0 Degree,
	RGE\[Delta]\[Mu] -> 0 Degree,
	RGE\[Delta]\[Tau] -> 0 Degree,
	RGE\[CurlyPhi]1 -> 0 Degree,
	RGE\[CurlyPhi]2 -> 0 Degree, 
	RGEMlightest -> 0.05,
	RGE\[CapitalDelta]m2atm -> 5*10^-3, 
	RGE\[CapitalDelta]m2sol -> 2 10^-4,
	RGEYe->DiagonalMatrix[{RGEye,RGEy\[Mu],RGEy\[Tau]}],
	RGE\[Kappa] -> RGEGet\[Kappa][RGE\[Theta]12, RGE\[Theta]13, RGE\[Theta]23, RGE\[Delta], RGE\[Delta]e,RGE\[Delta]\[Mu],RGE\[Delta]\[Tau],RGE\[CurlyPhi]1,RGE\[CurlyPhi]2, RGEMlightest, RGE\[CapitalDelta]m2atm, RGE\[CapitalDelta]m2sol, RGEMassHierarchy, RGEvu], 
	RGE\[Lambda]->0.5
	}
},
{"MZ",{
	RGE\[Kappa] -> RGEGet\[Kappa][RGE\[Theta]12, RGE\[Theta]13, RGE\[Theta]23, RGE\[Delta], RGE\[Delta]e,RGE\[Delta]\[Mu],RGE\[Delta]\[Tau],RGE\[CurlyPhi]1,RGE\[CurlyPhi]2, RGEMlightest, RGE\[CapitalDelta]m2atm, RGE\[CapitalDelta]m2sol, RGEMassHierarchy, RGEvu], 
	RGEYe->DiagonalMatrix[{RGEye,RGEy\[Mu],RGEy\[Tau]}],
	RGEg1 -> RGEgMZ[1],
	RGEg2 -> RGEgMZ[2],
	RGEg3 -> RGEgMZ[3],
	RGE\[Lambda] -> 0.522091,
	RGEYd->RGEGetYd[RGEyd,RGEys,RGEyb,RGEq\[Theta]12,RGEq\[Theta]13,RGEq\[Theta]23,RGEq\[Delta],RGEq\[Delta]e,RGEq\[Delta]\[Mu],RGEq\[Delta]\[Tau],RGEq\[CurlyPhi]1,RGEq\[CurlyPhi]2],
	RGEYu->DiagonalMatrix[{RGEyu,RGEyc,RGEyt}],
	RGEq\[Theta]12 -> 0.22735, 
	RGEq\[Theta]13 -> 3.64*10^-3,
	RGEq\[Theta]23 -> 4.208*10^-2,
	RGEq\[Delta] -> 1.208,
	RGEq\[CurlyPhi]1 -> 0 Degree,
	RGEq\[CurlyPhi]2 -> 0 Degree, 
	RGEq\[Delta]e -> 0 Degree,
	RGEq\[Delta]\[Mu] -> 0 Degree,
	RGEq\[Delta]\[Tau] -> 0 Degree,
	RGEyu -> 7.4*10^-6,
	RGEyc -> 3.60*10^-3,
	RGEyt -> 0.9861,
	RGEyd -> 1.58*10^-5,
	RGEys -> 3.12*10^-4,
	RGEyb -> 1.639*10^-2,
	RGEye ->  2.794745*10^-6,
	RGEy\[Mu] -> 5.899863*10^-4,
	RGEy\[Tau] ->  1.002950*10^-2,
	RGEMassHierarchy -> "n",
	RGE\[Theta]12 -> 33.57 Degree,
	RGE\[Theta]13 -> 8.75 Degree, 
	RGE\[Theta]23 -> 41.4 Degree,
	RGE\[Delta] -> 341 Degree,
	RGE\[Delta]e -> 0 Degree,
	RGE\[Delta]\[Mu] -> 0 Degree,
	RGE\[Delta]\[Tau] -> 0 Degree,
	RGE\[CurlyPhi]1 -> 0 Degree,
	RGE\[CurlyPhi]2 -> 0 Degree, 
	RGEMlightest -> 0.05,
	RGE\[CapitalDelta]m2atm -> 2.421*10^-3, 
	RGE\[CapitalDelta]m2sol -> 7.45*10^-5
	}
}
};


ClearAll[RGE1Loop];
RGE1Loop:={	D[g1[t],t]==Betag1[g1[t],g2[t],g3[t],Yu[t],Yd[t],Ye[t],\[Kappa][t],\[Lambda][t]],
		D[g2[t],t]==Betag2[g1[t],g2[t],g3[t],Yu[t],Yd[t],Ye[t],\[Kappa][t],\[Lambda][t]],
		D[g3[t],t]==Betag3[g1[t],g2[t],g3[t],Yu[t],Yd[t],Ye[t],\[Kappa][t],\[Lambda][t]],
		D[Yu[t],t]==BetaYu[g1[t],g2[t],g3[t],Yu[t],Yd[t],Ye[t],\[Kappa][t],\[Lambda][t]],
		D[Yd[t],t]==BetaYd[g1[t],g2[t],g3[t],Yu[t],Yd[t],Ye[t],\[Kappa][t],\[Lambda][t]],
		D[Ye[t],t]==BetaYe[g1[t],g2[t],g3[t],Yu[t],Yd[t],Ye[t],\[Kappa][t],\[Lambda][t]],
		D[\[Kappa][t],t]==Beta\[Kappa][g1[t],g2[t],g3[t],Yu[t],Yd[t],Ye[t],\[Kappa][t],\[Lambda][t]],
		D[\[Lambda][t],t]==Beta\[Lambda][g1[t],g2[t],g3[t],Yu[t],Yd[t],Ye[t],\[Kappa][t],\[Lambda][t]]};


(* Beta Functions of the Standardmodel *)
ClearAll[Betag1, Betag2, Betag3, BetaYu, BetaYd, BetaYe, Beta\[Kappa], Beta\[Lambda]];


Betag1[g1_,g2_,g3_,Yu_,Yd_,Ye_,\[Kappa]_,\[Lambda]_] :=
	41/10 * 1/(16*Pi^2) * g1^3;

Betag2[g1_,g2_,g3_,Yu_,Yd_,Ye_,\[Kappa]_,\[Lambda]_] :=
	-19/6 * 1/(16*Pi^2) * g2^3;

Betag3[g1_,g2_,g3_,Yu_,Yd_,Ye_,\[Kappa]_,\[Lambda]_] :=
	-7 * 1/(16*Pi^2) * g3^3;

BetaYd[g1_,g2_,g3_,Yu_,Yd_,Ye_,\[Kappa]_,\[Lambda]_] := 1/(16*Pi^2) * (
	(3/2)*Yd.Dagger[ Yd ].Yd
	- (3/2)*Yd.Dagger[ Yu ].Yu
	+ (
	- (1/4)*g1^2
	- (9/4)*g2^2
	- 8*g3^2
	+ 3*Tr[Dagger[ Yd ].Yd ]
	+ 3*Tr[Dagger[ Yu ].Yu ]
	+ Tr[Dagger[ Ye ].Ye ])*Yd
	);

BetaYu[g1_,g2_,g3_,Yu_,Yd_,Ye_,\[Kappa]_,\[Lambda]_] :=1/(16*Pi^2) * (
       (-3/2)*Yu.Dagger[Yd].Yd
       + (3/2)*Yu.Dagger[Yu].Yu
       + (
       - (17/20)*g1^2
       - (9/4)*g2^2
       - 8*g3^2
       + Tr[Dagger[Ye].Ye]
       + 3*Tr[Dagger[Yu].Yu]
       + 3*Tr[Dagger[Yd].Yd])*Yu
       );

BetaYe[g1_,g2_,g3_,Yu_,Yd_,Ye_,\[Kappa]_,\[Lambda]_] :=1/(16*Pi^2) * (
	(3/2)*Ye.Dagger[Ye].Ye
	+ (
	- (9/4)*g1^2
	- (9/4)*g2^2
	+ 3*Tr[Dagger[ Yd ].Yd ]
	+ 3*Tr[Dagger[ Yu ].Yu ]
	+ Tr[Dagger[ Ye ].Ye ])*Ye
	);

      
Beta\[Kappa][g1_,g2_,g3_,Yu_,Yd_,Ye_,\[Kappa]_,\[Lambda]_] :=1/(16*Pi^2) * (
	(-3/2)*\[Kappa].Dagger[Ye].Ye
	- (3/2)*Transpose[Ye].Conjugate[Ye].\[Kappa]
	+ (
	- 3*g2^2
	+ 6*Tr[Dagger[Yu].Yu]
	+ 6*Tr[Dagger[Yd].Yd]
	+ 2*Tr[Dagger[Ye].Ye]
	+ \[Lambda])*\[Kappa]
	);


Beta\[Lambda][g1_,g2_,g3_,Yu_,Yd_,Ye_,\[Kappa]_,\[Lambda]_] := 1/(16*Pi^2) * (
    6*\[Lambda]^2
    - (9/5)*g1^2*\[Lambda]
    - 9*g2^2*\[Lambda]
    + (27/50)*g1^4
    + (18/10)*g1^2*g2^2
    + (9/2)*g2^4
    + 4*\[Lambda]*(
    + 3*Tr[Dagger[Yu].Yu]
    + 3*Tr[Dagger[Yd].Yd]
    + Tr[Dagger[Ye].Ye]
    )
    - 8*(
    + 3*Tr[Dagger[Yu].Yu.Dagger[Yu].Yu]
    + 3*Tr[Dagger[Yd].Yd.Dagger[Yd].Yd]
    + Tr[Dagger[Ye].Ye.Dagger[Ye].Ye]
    )
    );


ClearAll[RGE2Loop];
RGE2Loop:={	D[g1[t],t]==Betag1[g1[t],g2[t],g3[t],Yu[t],Yd[t],Ye[t],\[Kappa][t],\[Lambda][t]]+Betag12[g1[t],g2[t],g3[t],Yu[t],Yd[t],Ye[t],\[Kappa][t],\[Lambda][t]],
		D[g2[t],t]==Betag2[g1[t],g2[t],g3[t],Yu[t],Yd[t],Ye[t],\[Kappa][t],\[Lambda][t]]+Betag22[g1[t],g2[t],g3[t],Yu[t],Yd[t],Ye[t],\[Kappa][t],\[Lambda][t]],
		D[g3[t],t]==Betag3[g1[t],g2[t],g3[t],Yu[t],Yd[t],Ye[t],\[Kappa][t],\[Lambda][t]]+Betag32[g1[t],g2[t],g3[t],Yu[t],Yd[t],Ye[t],\[Kappa][t],\[Lambda][t]],
		D[Yu[t],t]==BetaYu[g1[t],g2[t],g3[t],Yu[t],Yd[t],Ye[t],\[Kappa][t],\[Lambda][t]]+BetaYu2[g1[t],g2[t],g3[t],Yu[t],Yd[t],Ye[t],\[Kappa][t],\[Lambda][t]],
		D[Yd[t],t]==BetaYd[g1[t],g2[t],g3[t],Yu[t],Yd[t],Ye[t],\[Kappa][t],\[Lambda][t]]+BetaYd2[g1[t],g2[t],g3[t],Yu[t],Yd[t],Ye[t],\[Kappa][t],\[Lambda][t]],
		D[Ye[t],t]==BetaYe[g1[t],g2[t],g3[t],Yu[t],Yd[t],Ye[t],\[Kappa][t],\[Lambda][t]]+BetaYe2[g1[t],g2[t],g3[t],Yu[t],Yd[t],Ye[t],\[Kappa][t],\[Lambda][t]],
		D[\[Kappa][t],t]==Beta\[Kappa][g1[t],g2[t],g3[t],Yu[t],Yd[t],Ye[t],\[Kappa][t],\[Lambda][t]]+Beta\[Kappa]2[g1[t],g2[t],g3[t],Yu[t],Yd[t],Ye[t],\[Kappa][t],\[Lambda][t]],
		D[\[Lambda][t],t]==Beta\[Lambda][g1[t],g2[t],g3[t],Yu[t],Yd[t],Ye[t],\[Kappa][t],\[Lambda][t]]+Beta\[Lambda]2[g1[t],g2[t],g3[t],Yu[t],Yd[t],Ye[t],\[Kappa][t],\[Lambda][t]]
}; (* renormalization group equations of the SM ( 2 Loop ) *)

(* 2 loop contributions *)

ClearAll[Betag12, Betag22, Betag32, BetaY2, BetaYd2, BetaYe2, Beta\[Kappa]2, Beta\[Lambda]2];

Betag12[g1_,g2_,g3_,Yu_,Yd_,Ye_,\[Kappa]_,\[Lambda]_] := 1/(4*Pi)^4 * With[{
       l = 1,
       g = {g1,g2,g3},
       T = { Tr[Yu.Dagger[Yu]], Tr[Yd.Dagger[Yd]], Tr[Ye.Dagger[Ye]] },
       b = {{-(199/50), -(9/10), -(11/10)}, {-(27/10), -(35/6), -(9/2)}, {-(44/5), -12, 26}}, 
       c = {{17/10, 1/2, 3/2}, {3/2, 3/2, 1/2}, {2, 2, 0}}
   },
   - Sum[ b[[k,l]] g[[k]]^2 g[[l]]^3, {k,3}] +
   - Sum[ c[[l,f]] g[[l]]^3 T[[f]], {f,3}]
];

Betag22[g1_,g2_,g3_,Yu_,Yd_,Ye_,\[Kappa]_,\[Lambda]_] := 1/(4*Pi)^4 * With[{
       l = 2,
       g = {g1,g2,g3},
       T = { Tr[Yu.Dagger[Yu]], Tr[Yd.Dagger[Yd]], Tr[Ye.Dagger[Ye]] },
       b = {{-(199/50), -(9/10), -(11/10)}, {-(27/10), -(35/6), -(9/2)}, {-(44/5), -12, 26}}, 
       c = {{17/10, 1/2, 3/2}, {3/2, 3/2, 1/2}, {2, 2, 0}}
   },
   - Sum[ b[[k,l]] g[[k]]^2 g[[l]]^3, {k,3}] +
   - Sum[ c[[l,f]] g[[l]]^3 T[[f]], {f,3}]
];

Betag32[g1_,g2_,g3_,Yu_,Yd_,Ye_,\[Kappa]_,\[Lambda]_] := 1/(4*Pi)^4 * With[{
       l = 3,
       g = {g1,g2,g3},
       T = { Tr[Yu.Dagger[Yu]], Tr[Yd.Dagger[Yd]], Tr[Ye.Dagger[Ye]] },
       b = {{-(199/50), -(9/10), -(11/10)}, {-(27/10), -(35/6), -(9/2)}, {-(44/5), -12, 26}}, 
       c = {{17/10, 1/2, 3/2}, {3/2, 3/2, 1/2}, {2, 2, 0}}
   },
   - Sum[ b[[k,l]] g[[k]]^2 g[[l]]^3, {k,3}] +
   - Sum[ c[[l,f]] g[[l]]^3 T[[f]], {f,3}]
];

BetaYu2[g1_,g2_,g3_,Yu_,Yd_,Ye_,\[Kappa]_,\[Lambda]_] := With[{
       ng = 3,
       Y2 = Tr[ 3 Dagger[Yu].Yu + 3 Dagger[Yd].Yd + Dagger[Ye].Ye ],
       H = Tr[ 3 Dagger[Yu].Yu.Dagger[Yu].Yu + 3 Dagger[Yd].Yd.Dagger[Yd].Yd + Dagger[Ye].Ye.Dagger[Ye].Ye ],
       Y4 = (17/20 g1^2 + 9/4 g2^2 + 8 g3^2) Tr[Dagger[Yu].Yu] 
           + (1/4 g1^2 + 9/4 g2^2 + 8 g3^2) Tr[Dagger[Yd].Yd]
           + 3/4 (g1^2 + g2^2) Tr[Dagger[Ye].Ye],
       \[Chi]4 = 9/4 Tr[ 3 Dagger[Yu].Yu.Dagger[Yu].Yu + 3 Dagger[Yd].Yd.Dagger[Yd].Yd + Dagger[Ye].Ye.Dagger[Ye].Ye - 1/3 Dagger[Yu].Yu.Dagger[Yd].Yd + Dagger[Yd].Yd.Dagger[Yu].Yu]
   },
   1/(4*Pi)^4 * ( 
       Yu.(
           3/2 Dagger[Yu].Yu.Dagger[Yu].Yu 
           - Dagger[Yu].Yu.Dagger[Yd].Yd 
           - 1/4 Dagger[Yd].Yd.Dagger[Yu].Yu
           + 11/4 Dagger[Yd].Yd.Dagger[Yd].Yd
           + Y2 (5/4 Dagger[Yd].Yd - 9/4 Dagger[Yu].Yu)
           - 6 \[Lambda]/2 Dagger[Yu].Yu
           + (223/80 g1^2 + 135/16 g2^2 + 16 g3^2) Dagger[Yu].Yu
           - (43/80 g1^2 - 9/16 g2^2 + 16 g3^2) Dagger[Yd].Yd
       ) +
       Yu * (
           - \[Chi]4 
           + 3/2 \[Lambda]^2/4
           + 5/2 Y4 
           + (9/200 + 29/45 ng) g1^4
           - 9/20 g1^2 g2^2 
           + 19/15 g1^2 g3^2 
           - (35/4 - ng) g2^4 
           + 9 g2^2 g3^2 
           - (404/3 - 80/9 ng) g3^4 
       )
   )
];


BetaYd2[g1_,g2_,g3_,Yu_,Yd_,Ye_,\[Kappa]_,\[Lambda]_] := With[{
       ng = 3,
       Y2 = Tr[ 3 Dagger[Yu].Yu + 3 Dagger[Yd].Yd + Dagger[Ye].Ye ],
       H = Tr[ 3 Dagger[Yu].Yu.Dagger[Yu].Yu + 3 Dagger[Yd].Yd.Dagger[Yd].Yd + Dagger[Ye].Ye.Dagger[Ye].Ye ],
       Y4 = (17/20 g1^2 + 9/4 g2^2 + 8 g3^2) Tr[Dagger[Yu].Yu] 
           + (1/4 g1^2 + 9/4 g2^2 + 8 g3^2) Tr[Dagger[Yd].Yd]
           + 3/4 (g1^2 + g2^2) Tr[Dagger[Ye].Ye],
       \[Chi]4 = 9/4 Tr[ 3 Dagger[Yu].Yu.Dagger[Yu].Yu + 3 Dagger[Yd].Yd.Dagger[Yd].Yd + Dagger[Ye].Ye.Dagger[Ye].Ye - 1/3 Dagger[Yu].Yu.Dagger[Yd].Yd + Dagger[Yd].Yd.Dagger[Yu].Yu]
   },
   1/(4*Pi)^4 * ( 
       Yd.(
           3/2 Dagger[Yd].Yd.Dagger[Yd].Yd
           - Dagger[Yd].Yd.Dagger[Yu].Yu
           - 1/4 Dagger[Yu].Yu.Dagger[Yd].Yd
           +11/4 Dagger[Yu].Yu.Dagger[Yu].Yu
           + Y2 ( 5/4 Dagger[Yu].Yu - 9/4 Dagger[Yd].Yd)
           - 6 \[Lambda]/2 Dagger[Yd].Yd
           + (187/80 g1^2 + 135/16 g2^2 + 16 g3^2 ) Dagger[Yd].Yd
           - (79/80 g1^2 - 9/16 g2^2 + 16 g3^2 ) Dagger[Yu].Yu
       ) +
       Yd * (
           -\[Chi]4
           + 3/2 \[Lambda]^2/4
           + 5/2 Y4
           - (29/200 + 1/45 ng) g1^4
           - 27/20 g1^2 g2^2
           + 31/15 g1^2 g3^2
           - (35/4 - ng) g2^4 
           + 9 g2^2 g3^2
           - (404/3 - 80/9 ng) g3^4
       )
   )
];


BetaYe2[g1_,g2_,g3_,Yu_,Yd_,Ye_,\[Kappa]_,\[Lambda]_] := With[{
       ng = 3,
       Y2 = Tr[ 3 Dagger[Yu].Yu + 3 Dagger[Yd].Yd + Dagger[Ye].Ye ],
       H = Tr[ 3 Dagger[Yu].Yu.Dagger[Yu].Yu + 3 Dagger[Yd].Yd.Dagger[Yd].Yd + Dagger[Ye].Ye.Dagger[Ye].Ye ],
       Y4 = (17/20 g1^2 + 9/4 g2^2 + 8 g3^2) Tr[Dagger[Yu].Yu] 
           + (1/4 g1^2 + 9/4 g2^2 + 8 g3^2) Tr[Dagger[Yd].Yd]
           + 3/4 (g1^2 + g2^2) Tr[Dagger[Ye].Ye],
       \[Chi]4 = 9/4 Tr[ 3 Dagger[Yu].Yu.Dagger[Yu].Yu + 3 Dagger[Yd].Yd.Dagger[Yd].Yd + Dagger[Ye].Ye.Dagger[Ye].Ye - 1/3 Dagger[Yu].Yu.Dagger[Yd].Yd + Dagger[Yd].Yd.Dagger[Yu].Yu]
   },
   1/(4*Pi)^4 * ( 
       Ye.(
           3/2 Dagger[Ye].Ye.Dagger[Ye].Ye
           - 9/4 Y2 Dagger[Ye].Ye
           - 6 \[Lambda]/2 Dagger[Ye].Ye
           + (387/80 g1^2+ 135/16 g2^2) Dagger[Ye].Ye
           
       ) +
       Ye * (
           -\[Chi]4
           + 3/2 \[Lambda]^2/4
           + 5/2 Y4
           + (51/200 + 11/5 ng) g1^4
           + 27/20 g1^2 g2^2
           - (35/4 - ng) g2^2
       )
   )
];

Beta\[Lambda]2[g1_,g2_,g3_,Yu_,Yd_,Ye_,\[Kappa]_,\[Lambda]_] := With[{
       ng = 3,
       Y2 = Tr[ 3 Dagger[Yu].Yu + 3 Dagger[Yd].Yd + Dagger[Ye].Ye ],
       H = Tr[ 3 Dagger[Yu].Yu.Dagger[Yu].Yu + 3 Dagger[Yd].Yd.Dagger[Yd].Yd + Dagger[Ye].Ye.Dagger[Ye].Ye ],
       Y4 = (17/20 g1^2 + 9/4 g2^2 + 8 g3^2) Tr[Dagger[Yu].Yu] 
           + (1/4 g1^2 + 9/4 g2^2 + 8 g3^2) Tr[Dagger[Yd].Yd]
           + 3/4 (g1^2 + g2^2) Tr[Dagger[Ye].Ye],
       \[Chi]4 = 9/4 Tr[ 3 Dagger[Yu].Yu.Dagger[Yu].Yu + 3 Dagger[Yd].Yd.Dagger[Yd].Yd + Dagger[Ye].Ye.Dagger[Ye].Ye - 1/3 Dagger[Yu].Yu.Dagger[Yd].Yd + Dagger[Yd].Yd.Dagger[Yu].Yu]
   },
   1/(4*Pi)^4 * 2 * (
       - 78 \[Lambda]^3 / 8
       + (54 g2^2 + 54/5 g1^2) \[Lambda]^2 / 4
       - ( 
           (313/8 - 10 ng) g2^4
           - 117/20 g2^2 g1^2
           - (687/200 + 2 ng) g1^4
         ) \[Lambda]/2
       + (497/8 - 8 ng) g2^6
       - (97/40 + 8/5 ng) g2^4 g1^2
       - (717/200 + 8/5 ng) g2^2 g1^4
       - (531/1000 + 24/25 ng) g1^6
       - 64 g3^2 Tr[Dagger[Yu].Yu.Dagger[Yu].Yu + Dagger[Yd].Yd.Dagger[Yd].Yd]
       - 8/5 g1^2 Tr[2 Dagger[Yu].Yu.Dagger[Yu].Yu - Dagger[Yd].Yd.Dagger[Yd].Yd + 3 Dagger[Ye].Ye.Dagger[Ye].Ye]
       - 3/2 g2^4 Y2 
       + g1^2 (
           (63/5 g2^2 - 171/50 g1^2) Tr[Dagger[Yu].Yu]
           + (27/5 g2^2 + 9/10 g1^2) Tr[Dagger[Yd].Yd]
           + (33/5 g2^2 - 9/2 g1^2) Tr[Dagger[Ye].Ye]
       )
       + 10 \[Lambda]/2 Y4
       - 24 \[Lambda]^2 / 4 Y2
       - \[Lambda] / 2 H
       - 42 \[Lambda] / 2 Tr[Dagger[Yu].Yu.Dagger[Yd].Yd]
       + 20 Tr[ 3 Dagger[Yu].Yu.Dagger[Yu].Yu.Dagger[Yu].Yu + 3 Dagger[Yd].Yd.Dagger[Yd].Yd.Dagger[Yd].Yd + Dagger[Ye].Ye.Dagger[Ye].Ye.Dagger[Ye].Ye ]
       - 12 Tr[ Dagger[Yu].Yu.(Dagger[Yu].Yu + Dagger[Yd].Yd).Dagger[Yd].Yd ]
   )
];

Beta\[Kappa]2[g1_,g2_,g3_,Yu_,Yd_,Ye_,\[Kappa]_,\[Lambda]_] := 0 \[Kappa];
   


ClearAll[TransSM0N];
TransSM0N[pScale_?NumericQ,pDirection_?NumericQ,pSolution_,pToOpts_,pFromOpts_]:=Block[{lg1,lg2,lg3,lYu,lYd,lYe,l\[Kappa],l\[Lambda]},
(* make a transition from the SM to the SM *)
(* exceptions: try to add new particles --> CanNotAddNewParticles
*)

(* calculate the new parameters *)
	{lg1,lg2,lg3,lYu,lYd,lYe,l\[Kappa],l\[Lambda]}=(ParametersFunc[ pScale ]/.pSolution)[[1]];
        Return[{RGEg1->lg1,RGEg2->lg2,RGEg3->lg3,RGEYu->lYu,RGEYd->lYd,RGEYe->lYe,RGE\[Kappa]->l\[Kappa],RGE\[Lambda]->l\[Lambda]}];
];

ClearAll[TransSM];
TransSM[pScale_?NumericQ,pDirection_?NumericQ,pSolution_,pToOpts_,pFromOpts_]:=Block[{lg1,lg2,lg3,lYu,lYd,lYe,l\[Kappa],l\[Lambda]},
(* make a transition from the SM to the SM *)
(* exceptions: try to add new particles --> CanNotAddNewParticles
*)

(* calculate the new parameters *)
	{lg1,lg2,lg3,lYu,lYd,lYe,l\[Kappa],l\[Lambda]}=(ParametersFunc[ pScale ]/.pSolution)[[1]];
        Return[{RGEg1->lg1,RGEg2->lg2,RGEg3->lg3,RGEYu->lYu,RGEYd->lYd,RGEYe->lYe,RGE\[Kappa]->l\[Kappa],RGE\[Lambda]->l\[Lambda],RGEY\[Nu]->{},RGEM\[Nu]r->{}}];
];

ClearAll[TransMSSM0N];
TransMSSM0N[pScale_?NumericQ,pDirection_?NumericQ,pSolution_,pToOpts_,pFromOpts_]:=Block[{lg1,lg2,lg3,lYu,lYd,lYe,l\[Kappa],l\[Lambda], lMS2DR, lUL,lVL},
(* make a transition from the SM to the MSSM *)
(* exceptions: try to add new particles --> CanNotAddNewParticles
*)
        lToOpts;
        Options[lToOpts]=Options[RGEGetModelOptions["MSSM0N"][[1,2]]];
        SetOptions[lToOpts,RGEFilterOptions[lToOpts,pToOpts]];

        lFromOpts;
        Options[lFromOpts]=Options[RGEOptions];
        SetOptions[lFromOpts,RGEFilterOptions[lFromOpts,pFromOpts]];

(* calculate the new parameters *)
	{lg1,lg2,lg3,lYu,lYd,lYe,l\[Kappa],l\[Lambda]}=(ParametersFunc[ pScale ]/.pSolution)[[1]];
	l\[Beta]=N[ArcTan[RGEtan\[Beta]]]/.Options[lToOpts,RGEtan\[Beta]];

   
   Switch[{RGEModelVariant == "2Loop" /. Options[lFromOpts,RGEModelVariant], RGEModelVariant == "2Loop" /. Options[lToOpts,RGEModelVariant]},
       {True, True},
       lMS2DR = {
           1,
           1/(1 - lg2^2/(48 Pi^2)),
           1/(1 - lg3^2/(32 Pi^2)),
           1/(1 + 1/(32 Pi^2) (-1/36 3/5 lg1^2 - 3/4 lg2^2 + 8/3 lg3^2)),
           1/(1 + 1/(32 Pi^2) (-13/36 3/5 lg1^2 - 3/4 lg2^2 + 8/3 lg3^2)),
           1/(1 + 1/(32 Pi^2) (3/4 3/5 lg1^2 - 3/4 lg2^2 ))
       },
       {False, False},
       lMS2DR = {1,1,1,1,1,1},
       _,
       Print["Loop level at SM/MSSM boundary not matching, no \
\!\(\*OverscriptBox[\(MS\), \(_\)]\) to \!\(\*OverscriptBox[\(DR\), \
\(_\)]\) conversion done"];
       lMS2DR = {1,1,1,1,1,1}
   ];
   
   lUL = MPT3x3MixingMatrixL[lYu];
   lVL = MPT3x3NeutrinoMixingMatrix[l\[Kappa]];
   lYu = lYu.lUL;
   lYd = lYd.lUL;
   l\[Kappa] = Transpose[lVL].l\[Kappa].lVL;
   lYe = lYe.lVL;
   
   lYd = lYd.Inverse[IdentityMatrix[3] + (RGE\[CapitalGamma]d/.Options[lToOpts,RGE\[CapitalGamma]d])];
   lYe = lYe.Inverse[IdentityMatrix[3] + (RGE\[CapitalGamma]e/.Options[lToOpts,RGE\[CapitalGamma]e])];

   Return[{
       RGEg1->lg1 lMS2DR[[1]],
       RGEg2->lg2 lMS2DR[[2]],
       RGEg3->lg3 lMS2DR[[3]],
       RGEYu->lYu/Sin[l\[Beta]] lMS2DR[[4]],
       RGEYd->lYd/Cos[l\[Beta]] lMS2DR[[5]],
       RGEYe->lYe/Cos[l\[Beta]] lMS2DR[[6]],
       RGE\[Kappa]->l\[Kappa]/Sin[l\[Beta]]^2
   }];
];


ClearAll[TransMSSM];
TransMSSM[pScale_?NumericQ,pDirection_?NumericQ,pSolution_,pToOpts_,pFromOpts_]:=Block[{lg1,lg2,lg3,lYu,lYd,lYe,l\[Kappa],l\[Lambda]},
(* make a transition from the SM to the MSSM *)
(* exceptions: try to add new particles --> CanNotAddNewParticles
*)
   Return[Join[
       TransMSSM0N[pScale,pDirection,pSolution,pToOpts,pFromOpts],
       {RGEY\[Nu]->{},RGEM\[Nu]r->{}}
   ]];
];


(* internal functions *)

ClearAll[ParametersFunc];
ParametersFunc[pScale_]:={g1[pScale],g2[pScale],g3[pScale],Yu[pScale],Yd[pScale],Ye[pScale],\[Kappa][pScale],\[Lambda][pScale]};



ClearAll[SetInitial];
SetInitial[pBoundary_?NumericQ,pInitial_]:=Block[{},
(* sets the initial values *)
   Return[		{g1[pBoundary]==RGEg1,
			g2[pBoundary]==RGEg2,
			g3[pBoundary]==RGEg3,
			Yu[pBoundary]==RGEYu,
			Yd[pBoundary]==RGEYd,
			Ye[pBoundary]==RGEYe,
			\[Kappa][pBoundary]==RGE\[Kappa],
			\[Lambda][pBoundary]==RGE\[Lambda]
			}//.pInitial
			];
];


End[]; (* end of `Private` *)


EndPackage[];
