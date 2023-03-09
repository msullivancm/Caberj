#include "PROTHEUS.CH"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³CABR052  ³ Autor ³ Leonardo Portella    ³ Data ³ 05/08/2011 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Relatorio de Entrevistas por entrevistador.                |±±
±±³          ³ (Crystal Report CBR052)                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ CABERJ                                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

User Function CABR052

Private cPerg		:= "CABR052"
Private cParams		:= ""
Private cParImpr	:="1;0;1;Relatório performance de entrevistas"
Private cEmpresa	:= cEmpAnt + '0'

AjustaSX1()

If Pergunte(cPerg,.T.)

    cFiltroUser := If(empty(mv_par03),"PAV_LOGIN LIKE '%'",'PAV_LOGIN IN' + FormatIn(allTrim(mv_par03),";"))

	cParams := cEmpresa + ';' + DtoS(mv_par01) + ';' +  DtoS(mv_par02) + ';' + cFiltroUser + ';' + cValToChar(mv_par04) + ';' + If(mv_par05 == 1, 'S', 'N')

	CallCrys("CBR052",cParams,cParImpr)

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
aAdd(aHelp, "Informe a data da entrevista inicial")          
PutSX1(cPerg , "01" , "Data entrevista de" 		,"","","mv_ch1","D",8	,0,0,"G","",""	,"","","mv_par01","","","","","","","","","","",""	,"","","","","",aHelp,aHelp,aHelp)

aHelp := {}
aAdd(aHelp, "Informe a data da entrevista final")   
PutSX1(cPerg , "02" , "Data entrevista até" 	,"","","mv_ch2","D",8	,0,0,"G","",""	,"","","mv_par02","","","","","","","","","","",""	,"","","","","",aHelp,aHelp,aHelp)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Consulta Especifica:                            ³
//³Chama a funcao u_RetLogin                       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
aHelp := {}
aAdd(aHelp, "Informe os usuarios.")
aAdd(aHelp, "Caso este parametro nao seja preenchido,")
aAdd(aHelp, "serao considerados todos os usuarios.")
PutSX1(cPerg , "03" , "Usuarios" 	 			,"","","mv_ch3","C",99	,0,0,"G",""	,"LOGIN"	,"","","mv_par03","","","","","","","","","","",""	,"","","","","",aHelp,aHelp,aHelp)

aHelp := {}
aAdd(aHelp, "Informe a meta diaria")          
PutSX1(cPerg , "04" , "Meta diaria"			   	,"","","mv_ch4","N",4	,0,0,"G","",""	,"","","mv_par04","","","","","","","","","","",""	,"","","","","",aHelp,aHelp,aHelp)

aHelp := {}
aAdd(aHelp, "Informe se deve gerar grafico")   
PutSX1(cPerg , "05" , "Gera grafico"	 		,"","","mv_ch5","N",1	,0,0,"C","",""	,"","","mv_par05","Sim","","","","Não","","","","","","","","","","","",aHelp,aHelp,aHelp)

RestArea(aArea2)                                                                           

Return   

******************************************************************************************************************************

