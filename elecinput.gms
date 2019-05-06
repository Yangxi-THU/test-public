$title elec input data calculator

$gdxin 'rebalancedIO.gdx'


set i /
agr
coal
oil
gas
roil
elec
crp
nmm
ism
ome
cns
ele
twl
teq
mine
watr
food
othr
tran
ser
dwe
labor
capital
tax
lnd
ners
lab
cap

/;

set ii(i)/
agr
coal
oil
gas
roil
elec
crp
nmm
ism
ome
cns
ele
twl
teq
mine
watr
food
othr
tran
ser
dwe

lab
cap
/;


set g/
agr
coal
oil
gas
roil
elec
crp
nmm
ism
ome
cns
ele
twl
teq
mine
watr
food
othr
tran
ser
dwe
rur
urb
g
i
wex
pex
wim
pim
/;

set f/
lab
cap
labor
capital
tax
lnd
ners
/;



set r/
bj
tj
he
sx
nm
ln
jl
hl
sh
js
zj
ah
fj
jx
sd
ha
hb
hn
gd
gx
hi
cq
sc
gz
yn
sn
gs
qh
nx
xj
/;


set fe / coal, oil, roil, gas/;

parameter sam(i,g,r) ;

$load sam=sambalanced

sam("cap","elec",r) = sam("capital","elec",r) + sam("tax","elec",r)*sam("capital","elec",r)/(sam("capital","elec",r)+sam("labor","elec",r))   ;
sam("lab","elec",r) = sam("labor","elec",r) + sam("tax","elec",r)*sam("labor","elec",r)/(sam("capital","elec",r)+sam("labor","elec",r)) ;



table eletech(*,r)

                BJ      TJ      HE      SX      NM      LN      JL      HL      SH      JS      ZJ      AH      FJ      JX      SD      HA      HB      HN      GD      GX      HI      CQ      SC      GZ      YN      SN      GS      QH      NX      XJ
total           452     773     3025    3349    4903    2042    962     1129    1022    5523    3698    2576    2365    1114    4913    3393    3042    1601    4532    1805    486     856     3975    2347    3268    1683    1576    756     1477    2251
coalelec        293     510     1860    2134    2894    1133    532     672     674     3465    1978    1668    1070    623     3067    2171    843     647     2361    554     176     365     463     922     326     1049    618     110     891     1215
oilelec         3       6       22      25      34      13      6       8       8       41      23      20      13      7       36      26      10      8       28      7       2       4       5       11      4       12      7       1       11      14
gaselec         35      60      220     252     342     134     63      79      80      410     234     197     127     74      363     257     100     76      279     66      21      43      55      109     39      124     73      13      105     144
nuclelec                                                122                             168     354             141             168                             478     156     176
hydroelec       7       0       12      33      35      43      70      22              12      203     41      417     133     6       96      1384    488     288     640     29      241     2578    739     2122    71      355     403     16      158
windelec        3       6       164     78      379     102     58      73      7       57      13      13      38      6       101     7       13      8       10      2       5       2       4       18      62      13      115     4       67      136
solarelec       0       0       6       3       25      1       0       0       1       14      3       1       1       1       2       0       1       0       1       1       2               1               3       1       40      58      26      41
otherelec       15      27      98      112     152     60      28      35      35      182     104     88      56      33      161     114     44      34      124     29      9       19      24      49      17      55      33      6       47      64
tnd             96      164     643     712     1042    434     205     240     217     1174    786     548     502     237     1009    722     647     340     963     350     66      182     845     499     695     358     335     161     314     479
;

set eletnd / coalelec, oilelec, gaselec, nuclelec, hydroelec, windelec, solarelec, otherelec , tnd /;



* due to data imbalance, for now do not use GTAP technology structure, but using simple assumptions
$ontext

parameter elecout(r);
elecout(r) = sum(i, sam(i,"elec",r))-sam("cap","elec",r) - sam("lab","elec",r) ;

parameter eleouttech(eletnd, r);
eleouttech(eletnd, r) = eletech(eletnd,r)/eletech("total",r)* elecout(r);

* elec technolgoy input structure based on GTAP database
table vfm_e(f,eletnd,*)       Endowments - Firms' purchases at market prices

                chn
LAB.tnd         16.449
LAB.nuclelec    1.144
LAB.coalelec    3.827
LAB.gaselec     0.446
LAB.windelec    0.838
LAB.hydroelec   7.3
LAB.oilelec     0.138
LAB.otherelec   0.785
LAB.solarelec   0.019
CAP.tnd         8.941
CAP.nuclelec    0.711
CAP.coalelec    10.032
CAP.gaselec     0.379
CAP.windelec    1.461
CAP.hydroelec   18.439
CAP.oilelec     0.05
CAP.otherelec   1.361
CAP.solarelec   0.105
;

table vdfm_e(i,eletnd,*)
                chn
AGR.coalelec    0.001
CNS.coalelec    0.026
COAL.coalelec   82.869
CRP.coalelec    0.134
DWE.coalelec    0.007
ELE.coalelec    0.076
FOOD.coalelec   0.107
GAS.coalelec    0.000
MINE.coalelec   0.005
NMM.coalelec    0.081
OIL.coalelec    0.000
OME.coalelec    2.518
OTHR.coalelec   0.348
ROIL.coalelec   7.998
SER.coalelec    2.781
TEQ.coalelec    0.384
TRAN.coalelec   1.270
TWL.coalelec    0.136
elec.coalelec   14.879
ism.coalelec    0.041
AGR.gaselec     0.000
CNS.gaselec     0.003
COAL.gaselec    0.000
CRP.gaselec     0.015
DWE.gaselec     0.001
ELE.gaselec     0.008
FOOD.gaselec    0.012
GAS.gaselec     0.623
MINE.gaselec    0.001
NMM.gaselec     0.009
OIL.gaselec     0.000
OME.gaselec     0.279
OTHR.gaselec    0.038
ROIL.gaselec    5.668
SER.gaselec     0.308
TEQ.gaselec     0.043
TRAN.gaselec    0.045
TWL.gaselec     0.015
elec.gaselec    0.403
ism.gaselec     0.005
AGR.hydroelec   0.002
CNS.hydroelec   0.047
CRP.hydroelec   0.243
DWE.hydroelec   0.014
ELE.hydroelec   0.138
FOOD.hydroelec  0.194
MINE.hydroelec  0.008
NMM.hydroelec   0.146
OME.hydroelec   4.569
OTHR.hydroelec  0.631
SER.hydroelec   5.047
TEQ.hydroelec   0.697
TRAN.hydroelec  0.744
TWL.hydroelec   0.246
elec.hydroelec  1.947
ism.hydroelec   0.075
AGR.nuclelec    0.000
CNS.nuclelec    0.007
CRP.nuclelec    0.036
DWE.nuclelec    0.002
ELE.nuclelec    0.021
FOOD.nuclelec   0.029
MINE.nuclelec   0.013
NMM.nuclelec    0.022
OME.nuclelec    0.684
OTHR.nuclelec   0.094
SER.nuclelec    0.756
TEQ.nuclelec    0.104
TRAN.nuclelec   0.111
TWL.nuclelec    0.037
elec.nuclelec   0.367
ism.nuclelec    0.011
AGR.oilelec     0.000
CNS.oilelec     0.001
COAL.oilelec    0.000
CRP.oilelec     0.005
DWE.oilelec     0.000
ELE.oilelec     0.003
FOOD.oilelec    0.004
GAS.oilelec     0.000
MINE.oilelec    0.000
NMM.oilelec     0.003
OIL.oilelec     0.073
OME.oilelec     0.086
OTHR.oilelec    0.012
ROIL.oilelec    1.971
SER.oilelec     0.095
TEQ.oilelec     0.013
TRAN.oilelec    0.014
TWL.oilelec     0.005
elec.oilelec    0.035
ism.oilelec     0.001
AGR.otherelec   0.000
CNS.otherelec   0.005
COAL.otherelec  0.000
CRP.otherelec   0.027
DWE.otherelec   0.002
ELE.otherelec   0.016
FOOD.otherelec  0.022
GAS.otherelec   0.000
MINE.otherelec  0.001
NMM.otherelec   0.017
OME.otherelec   0.516
OTHR.otherelec  0.071
ROIL.otherelec  1.309
SER.otherelec   0.570
TEQ.otherelec   0.079
TRAN.otherelec  0.084
TWL.otherelec   0.028
elec.otherelec  0.147
ism.otherelec   0.008
AGR.solarelec   0.000
CNS.solarelec   0.000
CRP.solarelec   0.001
DWE.solarelec   0.000
ELE.solarelec   0.000
FOOD.solarelec  0.001
MINE.solarelec  0.000
NMM.solarelec   0.000
OME.solarelec   0.014
OTHR.solarelec  0.002
SER.solarelec   0.015
TEQ.solarelec   0.002
TRAN.solarelec  0.002
TWL.solarelec   0.001
elec.solarelec  0.006
ism.solarelec   0.000
AGR.WINDELEC    0.000
CNS.WINDELEC    0.006
CRP.WINDELEC    0.030
DWE.WINDELEC    0.002
ELE.WINDELEC    0.017
FOOD.WINDELEC   0.024
MINE.WINDELEC   0.001
NMM.WINDELEC    0.018
OME.WINDELEC    0.558
OTHR.WINDELEC   0.077
SER.WINDELEC    0.616
TEQ.WINDELEC    0.085
TRAN.WINDELEC   0.091
TWL.WINDELEC    0.030
elec.windelec   0.225
ism.windelec    0.009
AGR.tnd         0.004
CNS.tnd         0.087
COAL.tnd        0.000
CRP.tnd         0.447
DWE.tnd         0.051
ELE.tnd         0.254
FOOD.tnd        0.356
GAS.tnd         0.000
MINE.tnd        0.026
NMM.tnd         0.269
OIL.tnd         0.000
OME.tnd         8.411
OTHR.tnd        1.162
ROIL.tnd        0.091
SER.tnd         14.431
TEQ.tnd         1.283
elec.tnd        2.982
ism.tnd         0.138
;

table vifm_e(i,eletnd,*)

                chn
AGR.coalelec    0.001
CNS.coalelec    0.000
COAL.coalelec   14.220
CRP.coalelec    0.038
ELE.coalelec    0.010
FOOD.coalelec   0.002
GAS.coalelec    0.000
MINE.coalelec   0.003
NMM.coalelec    0.001
OIL.coalelec    0.000
OME.coalelec    0.495
OTHR.coalelec   0.016
ROIL.coalelec   0.735
SER.coalelec    0.075
TEQ.coalelec    0.053
TRAN.coalelec   0.009
TWL.coalelec    0.004
elec.coalelec   0.014
ism.coalelec    0.005
AGR.gaselec     0.000
CNS.gaselec     0.000
COAL.gaselec    0.000
CRP.gaselec     0.004
ELE.gaselec     0.001
FOOD.gaselec    0.000
GAS.gaselec     2.099
MINE.gaselec    0.000
NMM.gaselec     0.000
OIL.gaselec     0.000
OME.gaselec     0.055
OTHR.gaselec    0.002
ROIL.gaselec    0.521
SER.gaselec     0.008
TEQ.gaselec     0.006
TRAN.gaselec    0.001
TWL.gaselec     0.000
elec.gaselec    0.000
ism.gaselec     0.001
AGR.hydroelec   0.001
CNS.hydroelec   0.000
CRP.hydroelec   0.069
ELE.hydroelec   0.019
FOOD.hydroelec  0.004
MINE.hydroelec  0.006
NMM.hydroelec   0.002
OME.hydroelec   0.897
OTHR.hydroelec  0.030
SER.hydroelec   0.136
TEQ.hydroelec   0.096
TRAN.hydroelec  0.021
TWL.hydroelec   0.007
elec.hydroelec  0.002
ism.hydroelec   0.008
AGR.nuclelec    0.000
CNS.nuclelec    0.000
CRP.nuclelec    0.010
ELE.nuclelec    0.003
FOOD.nuclelec   0.001
MINE.nuclelec   0.008
NMM.nuclelec    0.000
OME.nuclelec    0.134
OTHR.nuclelec   0.004
SER.nuclelec    0.020
TEQ.nuclelec    0.014
TRAN.nuclelec   0.003
TWL.nuclelec    0.001
elec.nuclelec   0.000
ism.nuclelec    0.001
AGR.oilelec     0.000
CNS.oilelec     0.000
COAL.oilelec    0.000
CRP.oilelec     0.001
ELE.oilelec     0.000
FOOD.oilelec    0.000
GAS.oilelec     0.000
MINE.oilelec    0.000
NMM.oilelec     0.000
OIL.oilelec     0.045
OME.oilelec     0.017
OTHR.oilelec    0.001
ROIL.oilelec    0.181
SER.oilelec     0.003
TEQ.oilelec     0.002
TRAN.oilelec    0.000
TWL.oilelec     0.000
elec.oilelec    0.000
ism.oilelec     0.000
AGR.otherelec   0.000
CNS.otherelec   0.000
COAL.otherelec  0.000
CRP.otherelec   0.008
ELE.otherelec   0.002
FOOD.otherelec  0.000
GAS.otherelec   0.000
MINE.otherelec  0.001
NMM.otherelec   0.000
OME.otherelec   0.101
OTHR.otherelec  0.003
ROIL.otherelec  0.120
SER.otherelec   0.015
TEQ.otherelec   0.011
TRAN.otherelec  0.002
TWL.otherelec   0.001
elec.otherelec  0.000
ism.otherelec   0.001
AGR.solarelec   0.000
CNS.solarelec   0.000
CRP.solarelec   0.000
ELE.solarelec   0.000
FOOD.solarelec  0.000
MINE.solarelec  0.000
NMM.solarelec   0.000
OME.solarelec   0.003
OTHR.solarelec  0.000
SER.solarelec   0.000
TEQ.solarelec   0.000
TRAN.solarelec  0.000
TWL.solarelec   0.000
elec.solarelec  0.000
ism.solarelec   0.000
AGR.windelec    0.000
CNS.windelec    0.000
CRP.windelec    0.008
ELE.windelec    0.002
FOOD.windelec   0.000
MINE.windelec   0.001
NMM.windelec    0.000
OME.windelec    0.110
OTHR.windelec   0.004
SER.windelec    0.017
TEQ.windelec    0.012
TRAN.windelec   0.003
TWL.windelec    0.001
elec.windelec   0.000
ism.windelec    0.001
AGR.tnd         0.002
CNS.tnd         0.000
COAL.tnd        0.000
CRP.tnd         0.127
ELE.tnd         0.034
FOOD.tnd        0.007
GAS.tnd         0.000
MINE.tnd        0.017
NMM.tnd         0.003
OIL.tnd         0.000
OME.tnd         1.652
OTHR.tnd        0.055
ROIL.tnd        0.008
SER.tnd         0.319
TEQ.tnd         0.177
TRAN.tnd        0.034
TWL.tnd         0.012
elec.tnd        0.004
ism.tnd         0.015
;

  vfm_e(f,eletnd,r)$(vfm_e(f,eletnd,r)<0.0001) = 0 ;
  vdfm_e(i,eletnd,r)$(vdfm_e(i,eletnd,r)<0.0001) = 0;
  vifm_e(i,eletnd,r) $( vifm_e(i,eletnd,r)<0.0001 )=  0 ;

parameter inpd1, eleout1;
  inpd1(i,eletnd) = vdfm_e(i,eletnd,"chn") + vifm_e(i,eletnd,"chn");
  eleout1(eletnd) = sum(i,inpd1(i,eletnd)) + sum(f,vfm_e(f,eletnd,"chn")) ;

parameter elestr;
  elestr(eletnd,i)$eleout1(eletnd) = inpd1(i,eletnd)/eleout1(eletnd) ;
  elestr(eletnd,"lab")$eleout1(eletnd) = vfm_e("lab",eletnd,"chn")/eleout1(eletnd) ;
  elestr(eletnd,"cap")$eleout1(eletnd) = vfm_e("cap",eletnd,"chn")/eleout1(eletnd) ;

parameter eleinput0(eletnd,i,r);
eleinput0(eletnd,i,r) = round (elestr(eletnd,i)* eleouttech(eletnd,r), 6) ;



positive variable  eleinput(eletnd,i,r) ;
variable obj ;

equation objbal, rowequal, colequal;

objbal..            obj =e= sum((eletnd,i,r)$eleinput0(eletnd,i,r), (eleinput(eletnd,i,r) - eleinput0(eletnd,i,r)));
rowequal(i,r)..     sum(eletnd, eleinput(eletnd,i,r)) =e=  sam(i,"elec",r) ;
colequal(eletnd,r)..  sum(i, eleinput(eletnd,i,r) ) =e= eleouttech(eletnd,r) ;

eleinput.l(eletnd,i,r) =  eleinput0(eletnd,i,r);
eleinput.l("coalelec","coal",r) = sam("coal","elec",r);
eleinput.l("oilelec","oil",r) = sam("oil","elec",r);
eleinput.l("gaselec","gas",r) = sam("gas","elec",r);
eleinput.l("coalelec","coal",r) = sam("coal","elec",r);


eleinput.fx(eletnd,i,r)$( eleinput0(eletnd,i,r) = 0 ) = 0 ;

model calib /all /;

calib.solprint = yes;
option lp=bdmlp;
solve calib using lp minimizing obj  ;

$offtext


* Adopting simple assumptions that all the sector input follow the same structure for all the elec tech,
* except that energy input are according to the elec tech:

parameter inpd1, eleout1;
  inpd1(i,eletnd,r) = round( (sam(i,"elec",r) * eletech(eletnd,r)/eletech("total",r)),6)  ;
  inpd1(fe,eletnd,r) = 0;
  inpd1("coal","coalelec",r) = sam("coal","elec",r);
  inpd1("oil","oilelec",r) = sam("oil","elec",r);
  inpd1("roil","oilelec",r) = sam("roil","elec",r);
  inpd1("gas","gaselec",r) = sam("gas","elec",r);

  eleout1(eletnd,r) = sum(ii,inpd1(ii,eletnd,r)) ;

execute_unload 'elecinput.gdx';






