#INCLUDE "PROTHEUS.CH"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³CABR057  ³ Autor ³ Leonardo Portella    ³ Data ³ 24/11/2011 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Relatorio de transferencia - tela de transferencia         |±±
±±³          ³ (Crystal Report CBR057)                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ CABERJ                                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

User Function CABR057

Private cPerg		:= "CABR057"  
Private cParams		:= ""
Private cParImpr	:="1;0;1;Relatório de transferência - tela de transferência"       
Private cEmpresa	:= cEmpAnt + '0'

AjustaSX1()

If Pergunte(cPerg,.T.)
        
    cFiltroUser := If(!empty(mv_par08),'AND BQQ_XLOGIN IN ' + FormatIn(allTrim(mv_par08),';'),' ') 
	    
	cParams := cEmpresa + ';' + mv_par01 + ';' +  mv_par02 + ';' + mv_par03 + ';' + DtoS(mv_par04) + ';' + DtoS(mv_par05) + ';' + DtoS(mv_par06) ;
	           + ';' + DtoS(mv_par07) + ';' + cFiltroUser
	
	CallCrys("CBR057",cParams,cParImpr) 
	
EndIf             

Return

******************************************************************************************************************************

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡ao    ³ AjustaSX1³ Autor ³ Leonardo Portella                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Ajusta as perguntas do SX1                                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function AjustaSX1()

Local aHelp 	:= {}
Local aArea2	:= GetArea() 

aHelp := {}
aAdd(aHelp, "Informe a operadora")      
PutSX1(cPerg , "01" , "Operadora"  	   		,"","","mv_ch1","C",TamSx3('BA1_CODINT')[1]	,0,0,"G",""	,"B89PLS","","","mv_par01",""			,"","","",""		,"","",""				,"","",""		,"","","","","",aHelp,aHelp,aHelp)

aHelp := {}
aAdd(aHelp, "Informe o grupo de empresas inicial")      
PutSX1(cPerg , "02" , "Grupo empresas de" 	,"","","mv_ch2","C",TamSx3('BA1_CODEMP')[1],0,0,"G","",""	,"","","mv_par02",""		,"","","",""		,"","",""				,"","",""		,"","","","","",aHelp,aHelp,aHelp)

aHelp := {}
aAdd(aHelp, "Informe o grupo de empresas final")      
PutSX1(cPerg , "03" , "Grupo empresas até" 	,"","","mv_ch3","C",TamSx3('BA1_CODEMP')[1],0,0,"G","",""	,"","","mv_par03",""		,"","","",""		,"","",""				,"","",""		,"","","","","",aHelp,aHelp,aHelp)

aHelp := {}
aAdd(aHelp, "Informe data de digitação inicial")      
PutSX1(cPerg , "04" , "Data digitação de" 	,"","","mv_ch4","D",8						,0,0,"G","",""	,"","","mv_par04",""		,"","","",""		,"","",""				,"","",""		,"","","","","",aHelp,aHelp,aHelp)

aHelp := {}
aAdd(aHelp, "Informe data de digitação final.")      
aAdd(aHelp, "Caso este parametro na seja infor-")      
aAdd(aHelp, "mado sera desconsiderado.")      
PutSX1(cPerg , "05" , "Data digitação até" 	,"","","mv_ch5","D",8						,0,0,"G","",""	,"","","mv_par05",""		,"","","",""		,"","",""				,"","",""		,"","","","","",aHelp,aHelp,aHelp)

aHelp := {}
aAdd(aHelp, "Informe o mês de inclusão inicial")      
PutSX1(cPerg , "06" , "Data inclusão de" 	,"","","mv_ch6","D",8						,0,0,"G","",""	,"","","mv_par06",""		,"","","",""		,"","",""				,"","",""		,"","","","","",aHelp,aHelp,aHelp)

aHelp := {}
aAdd(aHelp, "Informe mês inclusão final")      
PutSX1(cPerg , "07" , "Data inclusão até" 	,"","","mv_ch7","D",8						,0,0,"G","",""	,"","","mv_par07",""		,"","","",""		,"","",""				,"","",""		,"","","","","",aHelp,aHelp,aHelp)

aHelp := {}
aAdd(aHelp, "Informe os logins desejados.") 
aAdd(aHelp, "Caso este parametro na seja infor-")      
aAdd(aHelp, "mado sera desconsiderado.")      
PutSX1(cPerg , "08" , "Logins" 	,"","","mv_ch8","C",99									,0,0,"G","","LOGIN"	,"","","mv_par08",""		,"","","",""	,"","",""				,"","",""		,"","","","","",aHelp,aHelp,aHelp)

RestArea(aArea2)

Return   

******************************************************************************************************************************