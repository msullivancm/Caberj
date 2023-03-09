#INCLUDE "rwmake.ch"
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณLP597001    บ Autor ณ AP6 IDE           บ Data ณ  19/07/07  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Apos De/Para das Contas Contabeis - ANS                    บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP6 IDE                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/     
User Function LP597001    
Local cConTab:= " "  
Local aArea := GetArea()
Local    cPrefP := substr (strlctpad,1,3)                       
Local    cNumP  := substr (strlctpad,4,6)                       
Local    cParcP := substr (strlctpad,10,1)                       
Local    cTpTip := substr (strlctpad,13,3)
Local    cFornP := substr (strlctpad,17,6)
Local    cLojaP := substr (strlctpad,23,2)   
If cPrefP = 'OPE'
   cConTab := '12741901202'   
ElseIf cPrefP = 'RLE'
   cConTab := '12741901202'   
ElseIf ALLTRIM(cTpTiP) == "PA"
   cConTab := POSICIONE("SED",1,XFILIAL("SED")+(POSICIONE("SE2",1,XFILIAL("SE2")+cPrefP+cNumP+cParcP+cTptiP+cFornP+cLojaP,"E2_NATUREZ")),"ED_CONTAB")
Else     
cConTab := '12741901201'                          
EndIf
RestArea(aArea)
Return cConTab