#include "Protheus.ch"

user function MovItemX (cItem,cConta,dtIni, DtFim)
Default dtIni  := ctod("01/01/2010")
Default DtFim  := ctod("31/01/2010")     
Default cConta := "311"
Default cItem  := "0002"
cItem          := alltrim(cItem)
nTamItem := TamSX3("CTD_ITEM")[1] - len(alltrim(cItem))
cItemI   := cItem + space(nTamItem)
cItemF   := cItem + space(nTamItem)
//cItemF   := cItem + Replicate("Z",nTamItem)
cConta         := alltrim(cConta)
nTamCta  := TamSX3("CT1_CONTA")[1] - len(alltrim(cConta))
cContaI  := cConta + space(nTamCta)
cContaF  := cConta + Replicate("Z",nTamCta)
nTamCC   := TamSX3("CTT_CUSTO")[1]
cCCI     := space(nTamCC)
cCCF     := Replicate("Z",nTamCC)

//user function teste (cConta,dtIni, DtFim)
aSaldoIni := {}
aSaldoFim := {}
nRet := 0

//Sintaxe	SaldtotCT4(cItemIni,cItemFim,cCusIni,cCusFim,cContaini,cContaFim, dData,cMoeda,cTpSald)

aSaldoIni := SaldtotCT4 (cItemI,cItemF,cCCI,cCCF,cContaI,cContaF,dtIni,"01","1")
aSaldoFim := SaldtotCT4 (cItemI,cItemF,cCCI,cCCF,cContaI,cContaF,dtFim,"01","1")

nDebito		:= aSaldoFim[4] - aSaldoIni[7]
nCredito	:= aSaldoFim[5] - aSaldoIni[8]

aMovimento := {nDebito,nCredito,nCredito-nDebito,aSaldoFim[1]}

nRet := nCredito-nDebito
//Return aMovimento[nQualSaldo]

Return nRet
