#include "PROTHEUS.CH"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³CABR287  ³ Autor ³ Paulo Motta          ³ Data ³ jun/21     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Relatorio Analit. Lancamentos com CID                      |±±
±±³          ³ (Crystal Report ANACID)                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ CABERJ                                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

User Function CABR287

Private cPerg		:= "CABR287"  
Private cParams		:= ""
Private cParImpr	:="1;0;1;Relatório Analit. Lanc CID"       
Private cEmpresa	:= Substr(cEmpAnt,2,1)
Private cGrpEmp   := ""

If !(Upper(Alltrim(cusername)) $ GetNewPar("MV_YANCID","ADMINISTRADOR;ANA.DIRCE;EUGENIA.ARAUJO;EVELYN.CALLEIA"))    
  MsgAlert("Usuario "+cusername+" sem permissao de emissao LGPD !!")
  Return Nil
EndIf
  
AjustaSX1()

If Pergunte(cPerg,.T.)

  /*aceitar parametro null ou branco)*/
  If Empty(mv_par07)
    cGrpEmp := "X"
  Else
    cGrpEmp := AllTrim(mv_par07)
  EndIf  

    
	cParams := cEmpresa + ';' + mv_par01 + ';' +  dtoc(mv_par02) + ';' + dtoc(mv_par03) + ';' + mv_par04 + ';' +;
             mv_par05 + ';' + mv_par06 + ';' + cGrpEmp 

  //MsgAlert(cParams)
  
	
	CallCrys("ANACID",cParams,cParImpr) 
	
EndIf             
 
Return

******************************************************************************************************************************

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡ao    ³ AjustaSX1³ Autor ³ Paulo Motta                             ³±±
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
aAdd(aHelp, "1 entrada 2 pago")        
u_CABASX1(cPerg,"01","Tp Custo  " ,"","","MV_CH1" ,"C",1,0,0,"G","","","","","MV_PAR01","","","","","","","","","","","","","","","","",aHelp,{},{},"")

aHelp := {}
aAdd(aHelp, "Ref Inicial")        
u_CABASX1(cPerg,"02","Ref Inicial  " ,"","","MV_CH2" ,"D",8,0,0,"G","","","","","MV_PAR02","","","","","","","","","","","","","","","","",aHelp,{},{},"")

aHelp := {}
aAdd(aHelp, "Ref Final")        
u_CABASX1(cPerg,"03","Ref Final  " ,"","","MV_CH3" ,"D",8,0,0,"G","","","","","MV_PAR03","","","","","","","","","","","","","","","","",aHelp,{},{},"")

aHelp := {}
aAdd(aHelp, "Cod. Empresa")        
u_CABASX1(cPerg,"04","Cod. Emp.  " ,"","","MV_CH4" ,"C",4,0,0,"G","","","","","MV_PAR04","","","","","","","","","","","","","","","","",aHelp,{},{},"")

aHelp := {}
aAdd(aHelp, "Contrato , branco para todos")        
u_CABASX1(cPerg,"05","Contrato  " ,"","","MV_CH5" ,"C",12,0,0,"G","","","","","MV_PAR05","","","","","","","","","","","","","","","","",aHelp,{},{},"")

aHelp := {}
aAdd(aHelp, "SubContrato , branco para todos")        
u_CABASX1(cPerg,"06","SubCon  " ,"","","MV_CH6" ,"C",9,0,0,"G","","","","","MV_PAR06","","","","","","","","","","","","","","","","",aHelp,{},{},"")

aHelp := {}
aAdd(aHelp, "Grupo Empresa , branco para todos")        
u_CABASX1(cPerg,"07","Grp Empresa  " ,"","","MV_CH7" ,"C",99,0,0,"G","","","","","MV_PAR07","","","","","","","","","","","","","","","","",aHelp,{},{},"")

RestArea(aArea2)                                                                           

Return   

******************************************************************************************************************************