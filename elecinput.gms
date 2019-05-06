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

parameter inpd1, eleout1;
  inpd1(i,eletnd,r) = round( (sam(i,"elec",r) * eletech(eletnd,r)/eletech("total",r)),6)  ;
  inpd1(fe,eletnd,r) = 0;
  inpd1("coal","coalelec",r) = sam("coal","elec",r);
  inpd1("oil","oilelec",r) = sam("oil","elec",r);
  inpd1("roil","oilelec",r) = sam("roil","elec",r);
  inpd1("gas","gaselec",r) = sam("gas","elec",r);

  eleout1(eletnd,r) = sum(ii,inpd1(ii,eletnd,r)) ;

execute_unload 'elecinput.gdx';






