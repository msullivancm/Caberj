#Define CRLF Chr(13)+Chr(10)
#Include "Protheus.Ch"
#Include "Colors.Ch"
#Include "TbiConn.Ch"
#Include  "FONT.CH"
#Include "TOPCONN.CH"
#INCLUDE "TCBrowse.ch"
#INCLUDE "PLSMGER.CH"

#xtranslate bSetGet(<uVar>) => {|u| If(PCount()== 0, <uVar>,<uVar> := u)}     
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCPUSXRDA  บMOTTA  ณCABERJ              บ Data ณ  out/2010   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ  CHAMA O RELATำRIO CRYSTAL USXRDA                          บฑฑ    
ฑฑบ          ณ  DEFINE A VARIAVEL DE RETORNO DA CHAMADA DO F3             บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

**********************
User Function CUSXRDA()          
**********************   

Private cCRPar    :="1;0;1;Usuarios x RDA"      
Private cParam1   := ""  
Private cPerg     := "USXRDA" 

If (SubStr(cNumEmp,1,2) == "01")
  cPerg     := "USXRDA" 
Else
  If (SubStr(cNumEmp,1,2) == "02")
    cPerg     := "USXRDI" 
  Endif   
Endif   
                                                 
 If !Pergunte(cPerg,.T.)
 	 Return
 Endif   
 
 cParam1   := mv_par01+";"+mv_par02+";"+AllTrim(mv_par03)+";"+mv_par04

/*Conjunto de op็๕es para nao mostrar a tela da SetPrint, composta por x;y;z;w, onde 
  x = vํdeo(1) ou impressora(3) 
  y = Atualiza(0) ou nใo(1) os dados
  z = N๚mero de c๓pias 
  w = Tํtulo do relatorio.
*/
 
CallCrys(cPerg,cParam1,cCRPar) 

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCPUSXRDA  บMOTTA  ณCABERJ              บ Data ณ  out/2010   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ  Consulta padrใo (check box) para Especialidades           บฑฑ    
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

**********************
User Function CPESPEC()          
**********************     

Public  cUSRXRDA   := " " 

Private oFntAri13N :=  TFont():New( "Arial"       ,,-13,,.F.,,,,,.F. )
Private oFntAri11N :=  TFont():New( "Arial"       ,,-11,,.F.,,,,,.F. )

Private cStatusAt  :=  Space(25)
Private cOrderAt   :=  Space(25)
Private cParceAt   :=  Space(1)
Private dDtBloq    :=  Ctod("")
Private nCombo     :=  " "
Private cAlias     := "BAQ"      //200
Private cCampoOk   := "XOK"  //200
Private aButtons   := {}
Private bOk        := {|| fGrpOk(),oDlgBord:End()}
Private bCancel    := {|| oDlgBord:End()}
Private cColunas   := ""
Private aCampos    := {}
Private cAliasTmp  := GetNextAlias() 
Private cAliasInd  := "i_"+cAliasTmp
Private oOk        := LoadBitMap(GetResources() , "LBOK_OCEAN" )
Private onOk       := LoadBitMap(GetResources() , "LBNO_OCEAN" )
Private cChave     := "BAQ_CODESP"  //200
Private aStruct    := {}
Private nTotReg    := 0
Private nTotVlr    := 0
Private oBrwBord
Private lactive   := .T.

Private aReturn := { "Zebrado",;	    	//[1] Reservado para Formulario
1,;		   		//[2] Reservado para Nง de Vias
"Administra็ใo",;	//[3] Destinatario
2,;			   	//[4] Formato => 1-Comprimido 2-Normal
1,;	    	   	//[5] Midia   => 1-Disco 2-Impressora
1,;			   	//[6] Porta ou Arquivo 1-LPT1... 4-COM1...
"",;			   	//[7] Expressao do Filtro
1 } 			   	//[8] Ordem a ser selecionada
//							[9]..[10]..[n]    //Campos a Processar (se houver)
Private cTipImp := 1
PRIVATE lSomTit     := .F.
PRIVATE cNomEtq
Private nPosCol := 1


Aadd(aCampos,{" ",cCampoOk,"C",1,0,})
Aadd(aStruct,{cCampoOk,"C",1,0})
Aadd(aCampos,{"Cod.","BAQ_CODESP","C",3,0,""})
Aadd(aStruct,{"BAQ_CODESP","C",3,0})
Aadd(aCampos,{"Descricao","BAQ_DESCRI","C",40,0,""})
Aadd(aStruct,{"BAQ_DESCRI","C",6,0})

If Select(cAliasTmp) <> 0
	(cAliasTmp)->(DbCloseArea())
Endif
If TcCanOpen(cAliasTmp)
	TcDelFile(cAliasTmp)
Endif
//cColunas += "D_E_L_E_T_ ,R_E_C_N_O_"
DbCreate(cAliasTmp,aStruct,"TopConn")
If Select(cAliasTmp) <> 0
	(cAliasTmp)->(DbCloseArea())
Endif
DbUseArea(.T.,"TopConn",cAliasTmp,cAliasTmp,.T.,.F.)
(cAliasTmp)->(DbCreateIndex(cAliasInd, cChave, {|| &cChave}, .F. ))
(cAliasTmp)->(DbCommit())
(cAliasTmp)->(DbClearInd())
(cAliasTmp)->(DbSetIndex(cAliasInd))

oDlgBord:=TDialog():New(000,000,500,910,"Especilidades",,,,,,,,,.T.) //200
oDlgBord:nClrPane:= RGB(255,255,254)
oDlgBord:bStart  := {||(EnchoiceBar(oDlgBord,bOk,bCancel,,aButtons))}

fBrowse() 

If Select(cAliasTmp) <> 0
	(cAliasTmp)->(DbCloseArea())
Endif
If TcCanOpen(cAliasTmp)
	TcDelFile(cAliasTmp)
Endif

Return .T.

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCPUSXRDA  บAutor  ณMicrosiga           บ Data ณ  11/28/08   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

*************************
Static Function fBrowse()
*************************

Local nIt := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

DbSelectArea(cAliasTmp)
(cAliasTmp)->(DbGoTop())

oBrwBord:=TcBrowse():New(015,005,365,200,,,,oDlgBord,,,,,,,oDlgBord:oFont,,,,,.T.,cAliasTmp,.T.,,.F.,,,.F.)

For nIt := 1 To Len(aCampos)
	c2 := If(nIt == 1," ",aCampos[nIt,1])
	c3 := If(nIt == 1,&("{|| If(Empty("+cAliasTmp+"->"+cCampoOk+"),onOk,oOk)}"),&("{||"+cAliasTmp+"->"+aCampos[nIt,2]+"  }"))
	c4 := If(nIt == 1,5,CalcFieldSize(aCampos[nIt,3],aCampos[nIt,4],aCampos[nIt,5],"",aCampos[nIt,1]))
	c5 := If(nIt == 1,"",aCampos[nIt,6])
	c6 := If(nIt == 1,.T.,.F.)
	oBrwBord:AddColumn(TCColumn():New(c2,c3,c5,,,"LEFT",c4,c6,.F.,,,,.F.))
	oBrwBord:bLDblClick   := {|| fAtuBrw(cAliasTmp,cCampoOk     )}
Next

oBrwBord:lHScroll := .T.
oBrwBord:lVScroll := .T. 

fMontaBrowse()

oBrwBord:bHeaderClick := {|| fAtuBrw(cAliasTmp,cCampoOK,,.T.)}

oDlgBord:Activate(,,,.T.)

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCPUSXRDA   บAutor  ณMicrosiga           บ Data ณ  10/31/08   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

***********************************************
Static function fMontaBrowse()
***********************************************

Local ni := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

Local lRet     := .T.
Local cQuery   := ""
Local cOrder   := ""

//Crio a tabela no banco de dados para exibi็ใo.  //200 falta montar query
cQuery += "SELECT  DISTINCT ' ' " + cCampoOk + ",BAQ_CODESP  , BAQ_DESCRI "  //Distinct incluido em 23/1/14
cQuery += "          FROM    " + RetSqlName("BAQ") + "  BAQ "  //<====
cQuery += "WHERE  BAQ_FILIAL = '  ' "
cQuery += "AND    BAQ_YUSO = '1' "
cQuery += "ORDER BY 3 "

//memowrit("C:\CPUSXRDA.SQL",cQuery)

If TcCanOpen(cAliasTmp)
	TcDelFile(cAliasTmp)
Endif

cQuery := ChangeQuery(cQuery)
If Select(cAliasTmp) <> 0 ; (cAliasTmp)->(DbCloseArea()) ; Endif
DbUseArea(.T.,"TopConn",TcGenQry(,,cQuery),cAliasTmp,.T.,.T.)

For ni := 1 to Len(aStruct)
	If aStruct[ni,2] != 'C'
		TCSetField(cAliasTmp, aStruct[ni,1], aStruct[ni,2],aStruct[ni,3],aStruct[ni,4])
	Endif
Next

cTmp2 := CriaTrab(NIL,.F.) //CriaTrab(aStruct,.T.)
Copy To &cTmp2

dbCloseArea()

dbUseArea(.T.,,cTmp2,cAliasTmp,.T.,.F.)

	//DbSelectArea(cAliasTmp)
(cAliasTmp)->(DbGoTop())

If (cAliasTmp)->(Eof())
	ApMsgInfo("Nใo foram encontrados registros com os parametros informados !")
	lRet := .F.
Else
	
	//If !lExcBord  //200
	//   oGet01:bWhen := {|| .F.} ; oGet02:bWhen := {|| .F.} ; oGet03:bWhen := {|| .F.} ; oGet04:bWhen := {|| .F.}
	//   oGet06:bWhen := {|| .F.} ; oGet05:bWhen := {|| .F.} ; oGet07:bWhen := {|| .F.} ; oCom02:bWhen := {|| .F.}//; oGet08:bWhen := {|| .F.}
	//Endif
	
	
Endif

oBrwBord:Refresh()
oDlgBord:Refresh()

Return(lRet)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCPUSXRDA  บAutor  ณMicrosiga           บ Data ณ  11/04/08   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ  fAtuBrw                                                   บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

********************************************************
Static Function fAtuBrw(cTmpAlias,cCampoOk,cGet,lTodos)
********************************************************

Local cMarca := " "//Space(TamSx3(cCampoOk)[1])

SA1->(DbSetOrder(1))
If lTodos <> Nil .And. lTodos
	(cAliasTmp)->(DbGoTop())
	cMarca := If(Empty((cAliasTmp)->&(cCampoOk)),"X","")
	While (cAliasTmp)->(!Eof())
		(cAliasTmp)->(RecLock(cAliasTmp,.F.))
		(cAliasTmp)->&(cCampoOk) := cMarca
		(cAliasTmp)->(MsUnLock())
		If Empty((cAliasTmp)->&(cCampoOk))
			nTotReg --
		Else
			nTotReg ++
		Endif
		(cAliasTmp)->(DbSkip())
	End
	(cTmpAlias)->(DbGoTop())
Else
	(cAliasTmp)->(RecLock(cAliasTmp,.F.))
	(cAliasTmp)->&(cCampoOk) := If(Empty((cAliasTmp)->&(cCampoOk)),"X","")
	(cAliasTmp)->(MsUnLock())
	If Empty((cAliasTmp)->&(cCampoOk))
		nTotReg --
	Else
		nTotReg ++
	Endif
Endif

//oGet06  :Refresh()
//oGet07  :Refresh()
oBrwBord:Refresh()
oDlgBord:Refresh()

Return(.T.)

***********************
Static Function fLimp()
***********************
Local cQuery := " "

cQuery := " DELETE FROM " + cAliasTmp
TcSqlExec(cQuery)
TcRefresh(cAliasTmp)

If Select(cAliasTmp) <> 0 ; (cAliasTmp)->(DbCloseArea()) ; Endif
If TcCanOpen(cAliasTmp)   ; TcDelFile(cAliasTmp)         ; Endif

cAliasTmp := GetNextAlias()

//Limpa Variaveis
cNumRda    := " "
cMesAnoDe  := " "
cMesAnoAte := " "
nTotReg    := 0
nTotVlr    := 0
dVencDe    := Ctod("  /  /    ")
dVencAte   := Ctod("  /  /    ")


//Habilita Campos para edi็ใo
//oGet01:bWhen := {|| .T.} ; oGet02:bWhen := {|| .T.} ; oGet03:bWhen := {|| .T.} ; oGet04:bWhen := {|| .T.} ;
//oGet06:bWhen := {|| .T.} ; oGet05:bWhen := {|| .T.} ; oGet07:bWhen := {|| .T.} ; oCom02:bWhen := {|| .T.} ;
//oCom03:bWhen := {|| .T.} ; oCom04:bWhen := {|| .T.}
//oBrwBord :Refresh()
//oDlgBord :Refresh()

Return

************************
Static Function fReset()
************************
oBrwBord:End()
oDlgBord:End()

If Select(cAliasTmp) <> 0 ; (cAliasTmp)->(DbCloseArea()) ; Endif
If TcCanOpen(cAliasTmp)   ; TcDelFile(cAliasTmp)         ; Endif

U_CPUSXRDA()

Return lActive := .F.

************************
Static Function fGrpOk()
************************ 

DbSelectArea(cAliasTmp)
DbGoTop()

While !eof()
	
	If (!Empty((cAliasTmp)->&(cCampoOk)))
		
	  cUSRXRDA := cUSRXRDA + (cAliasTmp)->BAQ_CODESP + "|"
		
	Endif
	
	DbSelectArea(cAliasTmp)
	(cAliasTmp)->(DbSkip())
Enddo       


Return 