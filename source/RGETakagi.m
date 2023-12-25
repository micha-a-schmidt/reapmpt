(* The package `REAP' is written for Mathematica 7 and is distributed under the
terms of GNU Public License http://www.gnu.org/copyleft/gpl.html *)


BeginPackage["REAP`RGETakagi`"];


ClearAll[RGETakagiDecomposition];

RGETakagiDecomposition::usage="RGETakagiDecomposition[M] performs a Takagi decomposition of M and returns in a list the unitary matrix u and the diagonalised matrix d, i.e. {u,d}.";


ClearAll[RGEEigenvalues];

RGEEigenvalues::usage="RGEEigenvalues[M] returns the eigenvalues of the complex symmetric matrix M. They are calculated using the Takagi factorization.";



 Begin["`Private`"];

ClearAll[Diag,Phase,UTakagi,UTakagiCompiled,TakagiDecompositionStep];
Diag = DiagonalMatrix;

Phase = If[Chop[#] =!= 0, #/Abs[#], 1] &;

UTakagi[A_, i_, j_, n_] := Block[{
    U = IdentityMatrix[n],
    c, t, \[CapitalDelta], D, ei\[CurlyPhi]
    },
   If[Chop[A[[i, j]]] === 0,
    Return[U];
    ];
   ei\[CurlyPhi] = 
    Phase[Conjugate[A[[i, i]]] A[[i, j]] + 
      A[[j, j]] Conjugate[A[[i, j]]]];
   \[CapitalDelta] = 
    1/2 (ei\[CurlyPhi] A[[i, i]] - Conjugate[ei\[CurlyPhi]] A[[j, j]]);
   D = Sqrt[\[CapitalDelta]^2 + A[[i, j]]^2];
   If[Abs[\[CapitalDelta] + D] < Abs[\[CapitalDelta] - D], D = -D];
   t = Re[A[[i, j]]/(\[CapitalDelta] + D)];
   c = 1/Sqrt[1 + t^2];
   U[[i, i]] = c;
   U[[i, j]] = t c ei\[CurlyPhi];
   U[[j, i]] = -t c Conjugate[ei\[CurlyPhi]];
   U[[j, j]] = c;
   Conjugate[U]
   ];

UTakagiCompiled = Compile[
  {{A, _Complex, 2}, {i, _Integer}, {j, _Integer}, {n, _Integer}},
  UTakagi[A, i, j, n]
  ];

TakagiDecompositionStep[u$_, m$_] := 
 Block[{d = Length[m$], U, u, m, subU},
  U = u$;
  m = m$;
  subU = If[
    Precision[m$] > MachinePrecision,
    UTakagi, (U = N[U]; UTakagi)
    ];
  Do[
   Do[
    u = subU[m, i, j, d];
    m = u.m.Transpose[u] // Simplify // Chop;
    U = u.U // Chop // Simplify;
    , {j, i - 1, 1, -1}
    ]
   , {i, d, 1, -1}
   ];
  {U, m}
  ];


RGETakagiDecomposition[M_] := Block[{u, d, \[CurlyPhi]},
  {u, d} = FixedPoint[
    TakagiDecompositionStep[#[[1]], #[[2]]] &,
    {IdentityMatrix[Length[M]], M},
    20(*,
    SameTest\[Rule](True&)*)
    ];
  \[CurlyPhi] = DiagonalMatrix[Exp[-(I/2) Arg[Diagonal[d]]]];
  u = \[CurlyPhi].u;
  d = \[CurlyPhi].d.\[CurlyPhi];
  If[Max[Im[Diagonal[d]]]/Max[Re[Diagonal[d]]]>10^-6,Print["Large Imaginary entries on diagonal found"];];
  {u, Re[d]}
  ];


RGEEigenvalues[pM_] := Block[{lU, lM,scale,MM},
(* returns the eigenvalues of pM  *)
   scale=Sqrt[Max[Abs[pM]]*Min[Select[Flatten[Abs[pM]], # > 0 &]]];
  MM=pM/scale;
  {lU, lM} = RGETakagiDecomposition[MM];
  lM=lM*scale;
  Return[Sort[Diagonal[lM],Greater]];
];


 End[];

 Protect[RGETakagiDecomposition,RGEEigenvalues];

 EndPackage[];
