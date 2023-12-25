(* The package `REAP' is written for Mathematica 7 and is distributed under the
terms of GNU Public License http://www.gnu.org/copyleft/gpl.html *)




BeginPackage["REAP`RGESymbol`"]

(* symbols used in exceptions *)
ClearAll[RGEModelAlreadyRegistered,RGELessThanZero,RGEScaleTooBig,RGENotImplementedYet,RGEOutOfRange,RGEModelDoesNotExist,RGEWrongModel,RGE\[Nu]MassAboveCutoff,RGENotAValidMassHierarchy];

RGEModelAlreadyRegistered; (* the model has already been registered *)
RGELessThanZero; (* the parameter is less than zero, thus out of range *)
RGEScaleTooBig; (* the scale parameter is too big, thus out of range *)
RGENotImplementedYet; (* the transition function hasn't been implemented yet *)
RGEOutOfRange; (* the parameter is out of range *)
RGEModelDoesNotExist; (* the model name given does not exist in the list model *)
RGEWrongModel; (* model name does not correspong to the model valid at the given scale *)
RGE\[Nu]MassAboveCutoff; (* Eigenvalue of M\[Nu] above cutoff found *)
RGENotAValidMassHierarchy; (* the type of the given mass hierarchy does not exist *)

Protect[RGEModelAlreadyRegistered,RGELessThanZero,RGEScaleTooBig,RGENotImplementedYet,RGEOutOfRange,RGEModelDoesNotExist,RGEWrongModel,RGE\[Nu]MassAboveCutoff,RGENotAValidMassHierarchy];


(* Symbols used to remove automatically generated entries *)

ClearAll[RGERemoveAutoGeneratedEntries];
RGERemoveAutoGeneratedEntries;
Protect[RGERemoveAutoGeneratedEntries];


(* Symbols in RGEModelInitial.cxml *)
(* Symbols in RGEModelOptions.cxml *)
ClearAll[RGEAutoGenerated]; RGEAutoGenerated; Protect[RGEAutoGenerated];
ClearAll[RGEIntegratedOut]; RGEIntegratedOut; Protect[RGEIntegratedOut];
ClearAll[RGEM\[CapitalDelta]]; RGEM\[CapitalDelta]; Protect[RGEM\[CapitalDelta]];
ClearAll[RGEM\[CapitalDelta]2]; RGEM\[CapitalDelta]2; Protect[RGEM\[CapitalDelta]2];
ClearAll[RGEM\[Nu]r]; RGEM\[Nu]r; Protect[RGEM\[Nu]r];
ClearAll[RGEMassHierarchy]; RGEMassHierarchy; Protect[RGEMassHierarchy];
ClearAll[RGEMaxNumberIterations]; RGEMaxNumberIterations; Protect[RGEMaxNumberIterations];
ClearAll[RGEMlightest]; RGEMlightest; Protect[RGEMlightest];
ClearAll[RGEModelVariant]; RGEModelVariant; Protect[RGEModelVariant];
ClearAll[RGEPrecision]; RGEPrecision; Protect[RGEPrecision];
ClearAll[RGESearchTransition]; RGESearchTransition; Protect[RGESearchTransition];
ClearAll[RGESuggestion]; RGESuggestion; Protect[RGESuggestion];
ClearAll[RGEThresholdFactor]; RGEThresholdFactor; Protect[RGEThresholdFactor];
ClearAll[RGEY\[CapitalDelta]]; RGEY\[CapitalDelta]; Protect[RGEY\[CapitalDelta]];
ClearAll[RGEY\[Nu]]; RGEY\[Nu]; Protect[RGEY\[Nu]];
ClearAll[RGEY\[Nu]33]; RGEY\[Nu]33; Protect[RGEY\[Nu]33];
ClearAll[RGEY\[Nu]Ratio]; RGEY\[Nu]Ratio; Protect[RGEY\[Nu]Ratio];
ClearAll[RGEYd]; RGEYd; Protect[RGEYd];
ClearAll[RGEYe]; RGEYe; Protect[RGEYe];
ClearAll[RGEYu]; RGEYu; Protect[RGEYu];
ClearAll[RGE\[CapitalDelta]m2atm]; RGE\[CapitalDelta]m2atm; Protect[RGE\[CapitalDelta]m2atm];
ClearAll[RGE\[CapitalDelta]m2sol]; RGE\[CapitalDelta]m2sol; Protect[RGE\[CapitalDelta]m2sol];
ClearAll[RGE\[CapitalGamma]d]; RGE\[CapitalGamma]d; Protect[RGE\[CapitalGamma]d];
ClearAll[RGE\[CapitalGamma]e]; RGE\[CapitalGamma]e; Protect[RGE\[CapitalGamma]e];
ClearAll[RGE\[CapitalLambda]1]; RGE\[CapitalLambda]1; Protect[RGE\[CapitalLambda]1];
ClearAll[RGE\[CapitalLambda]2]; RGE\[CapitalLambda]2; Protect[RGE\[CapitalLambda]2];
ClearAll[RGE\[CapitalLambda]4]; RGE\[CapitalLambda]4; Protect[RGE\[CapitalLambda]4];
ClearAll[RGE\[CapitalLambda]5]; RGE\[CapitalLambda]5; Protect[RGE\[CapitalLambda]5];
ClearAll[RGE\[CapitalLambda]6]; RGE\[CapitalLambda]6; Protect[RGE\[CapitalLambda]6];
ClearAll[RGE\[CapitalLambda]d]; RGE\[CapitalLambda]d; Protect[RGE\[CapitalLambda]d];
ClearAll[RGE\[CapitalLambda]u]; RGE\[CapitalLambda]u; Protect[RGE\[CapitalLambda]u];
ClearAll[RGE\[CurlyPhi]1]; RGE\[CurlyPhi]1; Protect[RGE\[CurlyPhi]1];
ClearAll[RGE\[CurlyPhi]2]; RGE\[CurlyPhi]2; Protect[RGE\[CurlyPhi]2];
ClearAll[RGE\[Delta]]; RGE\[Delta]; Protect[RGE\[Delta]];
ClearAll[RGE\[Delta]\[Mu]]; RGE\[Delta]\[Mu]; Protect[RGE\[Delta]\[Mu]];
ClearAll[RGE\[Delta]\[Tau]]; RGE\[Delta]\[Tau]; Protect[RGE\[Delta]\[Tau]];
ClearAll[RGE\[Delta]e]; RGE\[Delta]e; Protect[RGE\[Delta]e];
ClearAll[RGE\[Kappa]]; RGE\[Kappa]; Protect[RGE\[Kappa]];
ClearAll[RGE\[Kappa]1]; RGE\[Kappa]1; Protect[RGE\[Kappa]1];
ClearAll[RGE\[Kappa]2]; RGE\[Kappa]2; Protect[RGE\[Kappa]2];
ClearAll[RGE\[Lambda]]; RGE\[Lambda]; Protect[RGE\[Lambda]];
ClearAll[RGE\[Lambda]1]; RGE\[Lambda]1; Protect[RGE\[Lambda]1];
ClearAll[RGE\[Lambda]2]; RGE\[Lambda]2; Protect[RGE\[Lambda]2];
ClearAll[RGE\[Lambda]3]; RGE\[Lambda]3; Protect[RGE\[Lambda]3];
ClearAll[RGE\[Lambda]4]; RGE\[Lambda]4; Protect[RGE\[Lambda]4];
ClearAll[RGE\[Lambda]5]; RGE\[Lambda]5; Protect[RGE\[Lambda]5];
ClearAll[RGE\[Theta]12]; RGE\[Theta]12; Protect[RGE\[Theta]12];
ClearAll[RGE\[Theta]13]; RGE\[Theta]13; Protect[RGE\[Theta]13];
ClearAll[RGE\[Theta]23]; RGE\[Theta]23; Protect[RGE\[Theta]23];
ClearAll[RGEg]; RGEg; Protect[RGEg];
ClearAll[RGEg1]; RGEg1; Protect[RGEg1];
ClearAll[RGEg2]; RGEg2; Protect[RGEg2];
ClearAll[RGEg3]; RGEg3; Protect[RGEg3];
ClearAll[RGEm]; RGEm; Protect[RGEm];
ClearAll[RGEq\[CurlyPhi]1]; RGEq\[CurlyPhi]1; Protect[RGEq\[CurlyPhi]1];
ClearAll[RGEq\[CurlyPhi]2]; RGEq\[CurlyPhi]2; Protect[RGEq\[CurlyPhi]2];
ClearAll[RGEq\[Delta]]; RGEq\[Delta]; Protect[RGEq\[Delta]];
ClearAll[RGEq\[Delta]\[Mu]]; RGEq\[Delta]\[Mu]; Protect[RGEq\[Delta]\[Mu]];
ClearAll[RGEq\[Delta]\[Tau]]; RGEq\[Delta]\[Tau]; Protect[RGEq\[Delta]\[Tau]];
ClearAll[RGEq\[Delta]e]; RGEq\[Delta]e; Protect[RGEq\[Delta]e];
ClearAll[RGEq\[Theta]12]; RGEq\[Theta]12; Protect[RGEq\[Theta]12];
ClearAll[RGEq\[Theta]13]; RGEq\[Theta]13; Protect[RGEq\[Theta]13];
ClearAll[RGEq\[Theta]23]; RGEq\[Theta]23; Protect[RGEq\[Theta]23];
ClearAll[RGEtan\[Beta]]; RGEtan\[Beta]; Protect[RGEtan\[Beta]];
ClearAll[RGEvEW]; RGEvEW; Protect[RGEvEW];
ClearAll[RGEy\[Mu]]; RGEy\[Mu]; Protect[RGEy\[Mu]];
ClearAll[RGEy\[Tau]]; RGEy\[Tau]; Protect[RGEy\[Tau]];
ClearAll[RGEyb]; RGEyb; Protect[RGEyb];
ClearAll[RGEyc]; RGEyc; Protect[RGEyc];
ClearAll[RGEyd]; RGEyd; Protect[RGEyd];
ClearAll[RGEye]; RGEye; Protect[RGEye];
ClearAll[RGEys]; RGEys; Protect[RGEys];
ClearAll[RGEyt]; RGEyt; Protect[RGEyt];
ClearAll[RGEyu]; RGEyu; Protect[RGEyu];
ClearAll[RGEz\[Nu]]; RGEz\[Nu]; Protect[RGEz\[Nu]];
ClearAll[RGEzd]; RGEzd; Protect[RGEzd];
ClearAll[RGEzu]; RGEzu; Protect[RGEzu];

(* Symbols used in RGEGetSolution *)

ClearAll[RGETwistingParameters, RGEMu, RGEPoleMTop, RGE\[Alpha], RGEMe, RGEAll, RGERaw,RGERawY\[CapitalDelta],
RGEM\[Nu], RGEMd, RGEMixingParameters, RGECoupling,RGE\[Epsilon]1,RGE\[Epsilon]1Max,RGE\[Epsilon],RGE\[Epsilon]Max,RGEM1Tilde,RGE\[Beta]1,RGE\[Beta]2,RGE\[Beta]3,RGEf1,RGEYqp,RGEYqm,RGEYlp,RGEYlm];

RGETwistingParameters;
RGEMu;
RGEPoleMTop;
RGE\[Alpha];
RGEMe;
RGEAll;
RGERaw;
RGERawY\[CapitalDelta];
RGEM\[Nu];
RGEMd;
RGEMixingParameters;
RGECoupling;
RGE\[Epsilon]1;
RGE\[Epsilon]1Max;
RGE\[Epsilon];
RGE\[Epsilon]Max;
RGEM1Tilde;
RGE\[Beta]1;
RGE\[Beta]2;
RGE\[Beta]3;
RGEf1;
RGEYqp;
RGEYqm;
RGEYlp;
RGEYlm;

Protect[RGETwistingParameters, RGEMu, RGEPoleMTop, RGE\[Alpha], RGEMe, RGEAll, RGERaw, REGRawY\[CapitalDelta],
RGEM\[Nu], RGEMd, RGEMixingParameters, RGECoupling,RGE\[Epsilon]1,RGE\[Epsilon]1Max,RGE\[Epsilon],RGE\[Epsilon]Max,RGEM1Tilde,RGE\[Beta]1,RGE\[Beta]2,RGE\[Beta]3,RGEf1,RGEYqp,RGEYqm,RGEYlp,RGEYlm];

(* Options used in RGEAddEFT *)
ClearAll[RGECutoff];
RGECutoff;
Protect[RGECutoff];



EndPackage[];

