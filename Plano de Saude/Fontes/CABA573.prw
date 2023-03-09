#INCLUDE "PROTHEUS.CH"
#INCLUDE "TOPCONN.CH" 

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABA573   ºAutor  ³                    º Data ³  10/11/15   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Projeto glosa automatica PR.                                º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³CABERJ                                                      º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

/*
PROCEDURES ENVOLVIDAS:

- DADOS_GLOSA_AUTO_PR_V2: Seleciona todos os dados de eleitos a glosa sem aplicação de filtro de usuário e grava na 
  tabela CONTROLE_GLOSA_AUTO_PR. Os filtros aplicados são os básicos e não alteráveis, como não ser convênio, etc.
  
- MARCA_GLOSA_AUTO_PR_V2: Aplica filtros nos dados da tabela CONTROLE_GLOSA_AUTO_PR conforme parâmetros. Deixa marca-
  dos os campos CONSIDERA_RDA e GLOSA_LINHA que serão verificados pela procedure GLOSA_AUTO_PR_V2.
  
- GLOSA_AUTO_PR_V2: Realiza a glosa dos itens marcados com CONSIDERA_RDA = 'S' e GLOSA_LINHA = 'S'
*/

User Function CABA573

Local lContinua 	:= .T.

Private cPerg		:= 'CAB573'
Private nVlrGloMax	:= 0
Private nVlrGlosar	:= 0

AjustaSX1()

If lUSRxPR() .and. Pergunte(cPerg,.T.)
 		
	While !( lSemaforo := LockByName("CABA573_V2.SMF",.T.,.F.) )
		
		If ( Aviso(AllTrim(SM0->M0_NOMECOM),'Existe outro usuário acessando esta rotina...',{'Aguardar','Cancelar'}) == 1 )
			Exit
		Else
			Sleep(1000)
		EndIf
		
	EndDo
	
 	If lSemaforo
	
		Processa({|| lContinua := lDadosGlosa()}, "Glosa automática PR")
		
		If lContinua		
			PCABA573()				
		EndIf
		
		UnLockByName("CABA573_V2.SMF",.T.,.F.)
 	
	Else
		MsgAlert('Processamento cancelado!',AllTrim(SM0->M0_NOMECOM))
	EndIf
	
EndIf

Return

********************************************************************************************************

Static Function lDadosGlosa

Local nI
Local c_Script		:= ''
Local cAlVerExi		:= ''
Local cQryVerExi	:= ''
Local lExisteComp	:= .F.

ProcRegua(0)

For nI := 1 to 5
	IncProc('Processando... [ Fase 1 de 4 ]')
Next

cAlVerExi	:= GetNextAlias()
	
cQryVerExi	:= "SELECT DISTINCT LOTE" 												+ CRLF
cQryVerExi	+= "FROM CONTROLE_GLOSA_AUTO_PR CONTROLE" 								+ CRLF
cQryVerExi	+= "WHERE EMPRESA = '" + If(cEmpAnt == '01','CAB','INT') + "'" 			+ CRLF
cQryVerExi	+= "  AND NOT EXISTS" 													+ CRLF 
cQryVerExi	+= "  (" 																+ CRLF 
cQryVerExi	+= "  	SELECT 1" 														+ CRLF
cQryVerExi	+= "  	FROM CONTROLE_GLOSA_AUTO_PR" 									+ CRLF
cQryVerExi	+= "  	WHERE VLR_GLOSADO > 0" 											+ CRLF 
cQryVerExi	+= "  	   AND LOTE = CONTROLE.LOTE"									+ CRLF 
cQryVerExi	+= "  )" 																+ CRLF

TcQuery cQryVerExi New Alias cAlVerExi 

lExisteComp := !cAlVerExi->(EOF())

If !lExisteComp .or. ; 
	( ;
	MsgYesNo('Existem informações de lotes gerados que não foram processados. Deseja apagar estes lotes não processados?',AllTrim(SM0->M0_NOMECOM));
	.and. ;
	MsgYesNo('Os lotes que não foram processados serão regerados. Este processo pode demorar... Confirma?',AllTrim(SM0->M0_NOMECOM));
	)
	
	While !cAlVerExi->(EOF())
	
		c_Script := "DELETE FROM CONTROLE_GLOSA_AUTO_PR" 									+ CRLF 
		c_Script += "WHERE LOTE = " + cValToChar(cAlVerExi->LOTE) 							+ CRLF
		c_Script += "   AND EMPRESA = '" + If(cEmpAnt == '01','CAB','INT') + "'" 			+ CRLF
		
		If TcSqlExec(c_Script) < 0
			MsgStop("Falha ao limpar lotes antigos [ " + TcSqlError() + " ]",AllTrim(SM0->M0_NOMECOM))
			cAlVerExi->(DbCloseArea())
			Return .F.
		EndIf
		
		cAlVerExi->(DbSkip())
		
	EndDo

	c_Script := "BEGIN" 												+ CRLF
	
	c_Script += "DADOS_GLOSA_AUTO_PR_V2"								+ CRLF
	c_Script += "(" 													+ CRLF
	c_Script += "'" + If(cEmpAnt == '01','CABERJ','INTEGRAL') + "'," 	+ CRLF 
	c_Script += "'" + StrZero(mv_par02,4) + "'," 						+ CRLF 
	c_Script += "'" + StrZero(mv_par01,2) + "'"							+ CRLF
	c_Script += ");" 													+ CRLF
	
	c_Script += "END;" 													+ CRLF
	
	If TcSqlExec(c_Script) < 0
		MsgStop("Falha na PROCEDURE DADOS_GLOSA_AUTO_PR_V2 [ " + TcSqlError() + " ]",AllTrim(SM0->M0_NOMECOM))
		Return .F.
	EndIf	
	
EndIf
		
cAlVerExi->(DbCloseArea())

Return .T.

********************************************************************************************************

Static Function PCABA573

Local nI			:= 0
Local lContinua		:= .T.

Private oOk      	:= LoadBitMap(GetResources(),"LBOK")
Private oNo      	:= LoadBitMap(GetResources(),"LBNO")
Private oGLOSA		:= LoadBitMap(GetResources(),"BR_VERDE")
Private oNAOGLOSA	:= LoadBitMap(GetResources(),"BR_VERMELHO")
Private aObjects 	:= {}
Private aSizeAut 	:= MsAdvSize(.T.)//Vai usar Enchoice 
Private aStrCpos	:= {}
Private aBrwCpos	:= {}             
Private oProcess    := Nil  
Private cAliasTmp  	:= GetNextAlias()                                   
Private oCBoxPR		:= Nil
Private cNomeBusca	:= Space(200)
Private idProtSeq	:= ''
Private cQryBas1	:= ''
Private cQryBas2	:= ''
Private oCBox1		:= Nil
Private lMarcDesm	:= .F.
Private aCampos		:= {'BAU_CODIGO','BAU_NOME'}

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³MsAdvSize()                          ³
//³-------------------------------------³
//³1 -> Linha inicial area trabalho.    ³
//³2 -> Coluna inicial area trabalho.   ³
//³3 -> Linha final area trabalho.      ³
//³4 -> Coluna final area trabalho.     ³
//³5 -> Coluna final dialog (janela).   ³
//³6 -> Linha final dialog (janela).    ³
//³7 -> Linha inicial dialog (janela).  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
          
lAjustHor	:= .T.
lAjustVert	:= .T.

aAdd( aObjects, { 100,  100, lAjustHor, lAjustVert, .T. } )

nSepHoriz 	:= 5
nSepVert	:= 5
nSepBorHor 	:= 5
nSepBorVert	:= 5
                    
aInfo  		:= { aSizeAut[1], aSizeAut[2], aSizeAut[3], aSizeAut[4], nSepHoriz, nSepVert, nSepBorHor, nSepBorVert }
aPosObj 	:= MsObjSize( aInfo, aObjects, .T. )

aAdd(aStrCpos,{'OK','C',1,0})
aAdd(aBrwCpos,{' ','OK','C',4,0,'@!'})
aAdd(aStrCpos,{'TIPO','C',10,0})
aAdd(aBrwCpos,{' ','TIPO','C',2,0,'@!'})

SX3->(DbsetOrder(2))

For nI := 1 to len(aCampos)

	If SX3->(MsSeek(aCampos[nI]))   
		aAdd(aStrCpos,{SX3->X3_CAMPO,SX3->X3_TIPO,SX3->X3_TAMANHO,SX3->X3_DECIMAL})
		aAdd(aBrwCpos,{SX3->X3_TITULO,SX3->X3_CAMPO,SX3->X3_TIPO,SX3->X3_TAMANHO,SX3->X3_DECIMAL,AllTrim(SX3->X3_PICTURE)})
	EndIf

Next

aAdd(aStrCpos,{'VLR_MAX_GL','N',12,2})
aAdd(aBrwCpos,{'Max. glosar RDA','VLR_MAX_GL','N',12,2,'@E 999.999.999.999,99'})

aAdd(aStrCpos,{'ULT_PR_RDA','C',4,2})
aAdd(aBrwCpos,{'Último PR RDA','ULT_PR_RDA','C',4,0,''})

Processa({||ExecSQL()},AllTrim(SM0->M0_NOMECOM),"Selecionando registros...")

(cAliasTmp)->(DbGoTop())

If (cAliasTmp)->(Eof())
	MsgStop("Não foram encontrados registros!",AllTrim(SM0->M0_NOMECOM))
	Return
EndIf 
	
DbSelectArea(cAliasTmp)

(cAliasTmp)->(DbGoTop())

oDlgProAt := MsDialog():New( aSizeAut[2],aSizeAut[1],aSizeAut[6],aSizeAut[5],"Projeto glosa automática PR",,,.F.,,,,,,.T.,,,.T. )

	oBrwProAt := TcBrowse():New(aPosObj[1][1]+40,aPosObj[1][2],aPosObj[1][3],aPosObj[1][4]-45,,,,oDlgProAt,,,,,,,oDlgProAt:oFont,,,,,.T.,/*cAliasTmp*/,.T.,,.F.,,,.F.)
	
	For nI := 1 To len(aBrwCpos)
	
		nTamCpo := If(nI == 1, 15, CalcFieldSize(aBrwCpos[nI,3],aBrwCpos[nI,4],aBrwCpos[nI,5],aBrwCpos[nI,6],aBrwCpos[nI,1],oDlgProAt:oFont))
		
		If nI == 1
							
			oBrwProAt:AddColumn(TcColumn():New(aBrwCpos[nI,1],;
				&("{||If(empty(" + cAliasTmp + "->OK),oNo,oOk)}");
				,,,,"LEFT",nTamCpo,.T.,.F.,,,,,))	
				
		ElseIf nI == 2
		 	
		 	oBrwProAt:AddColumn(TcColumn():New(aBrwCpos[nI,1],;
				&("{||If(AllTrim(" + cAliasTmp + "->TIPO) == 'GLOSA',oGLOSA,oNAOGLOSA)}");
				,,,,"LEFT",nTamCpo,.T.,.F.,,,,,)) 
				
		Else
		        
			oBrwProAt:AddColumn(TcColumn():New(aBrwCpos[nI,1],;
				&("{||" + cAliasTmp + "->" + aBrwCpos[nI,2] + "}");
				,,,,"LEFT",nTamCpo,(nI == 1),.F.,,,,,)) 
			
		EndIf
		
	Next
	
	oBrwProAt:bLDblClick   	:= {||MarcaDes()}
	
	oBrwProAt:bHeaderClick	:= {||Alert(oBrwProAt:ColPos)} 
	
	oGrp1      	:= TGroup():New( aPosObj[1][1],aPosObj[1][2],aPosObj[1][1] + 20,aPosObj[1][3] + 5,Nil,oDlgProAt,CLR_BLACK,CLR_WHITE,.T.,.F. )
	
	oCBox1     	:= TCheckBox():New( aPosObj[1][1] + 25,aPosObj[1][2],"Marca/Desmarca todos em exibição",{|u| If(PCount()>0,lMarcDesm:=u,lMarcDesm)},oDlgProAt,140,008,,,,,CLR_BLACK,CLR_WHITE,,.T.,"",, )
	oCBox1:bLClicked := {||U_cb573mar()}
	
	oSay2      	:= TSay():New( aPosObj[1][1] + 5,aPosObj[1][2] + 5 		,{||"Buscar"},oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,050,050)
	oGetNome   	:= TGet():New( aPosObj[1][1] + 5,aPosObj[1][2] + 30		,{|u| If(PCount()>0,(cNomeBusca:=u,FiltraBrw()),cNomeBusca)},oGrp1,220,008,'@!',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cNomeBusca",,)
	oBrwProAt:nScrollType := 1 // Scroll VCR
		
	oSay3      	:= TSay():New( aPosObj[1][1] + 5,aPosObj[1][2] + 300 	,{||"Valor máximo previsto: " + AllTrim(Transform(nVlrGloMax,'@E 999,999,999,999.99'))}	,oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,150,150)
	
	oSay4      	:= TSay():New( aPosObj[1][1] + 5,aPosObj[1][2] + 430	,{||"Valor a glosar"},oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,050,050)
	oGetVlr   	:= TGet():New( aPosObj[1][1] + 5,aPosObj[1][2] + 470	,{|u| If(PCount()>0, nVlrGlosar := u,nVlrGlosar)},oGrp1,80,008,'@E 999,999,999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","nVlrGlosar",,)
	
	FiltraBrw()
	
	bOk 	:= {||lContinua := .T.,If(MsgYesNo('Confirma a gravação dos registros?',AllTrim(SM0->M0_NOMECOM)),(Grava(),oDlgProAt:End()),)}
	bCancel := {||lContinua := .F.,oDlgProAt:End()}
		                
	aBut 	:= {{"PARAMETROS"	, {||U_CABA573Leg()}	, "Legenda"	, "Legenda"	}}
	
oDlgProAt:Activate(,,,.T.,,,EnchoiceBar(oDlgProAt,bOk,bCancel,,aBut))

If Select(cAliasTmp) <> 0
	(cAliasTmp)->(DbCloseArea())
EndIf

Return

****************************************************************************************************************************
                   
Static Function ExecSQL

Local nI := 0
            
Local nCont		:= 0
Local cQuery 	:= ''
Local cFunction	:= ''
Local cMatrPesq	:= ''
Local cProt		:= ''
Local cSelect	:= ''
Local cQryTot	:= ''
Local cAlTot	:= GetNextAlias()
Local aArea		

ProcRegua(0)

For nCont := 1 to 5
	IncProc('Selecionando registros...')             
Next 

For nI := 1 to len(aCampos)
	cSelect += aCampos[nI] + ', '
Next

cSelect := Left(cSelect,len(cSelect) - 2)
		
cQuery := "SELECT DISTINCT ' ' OK, 'NAOGLOSA' TIPO, EMPRESA, LOTE, VLR_MAX_GLOSA VLR_MAX_GL, " 				+ CRLF
cQuery += "ULTIMO_PR_RDA ULT_PR_RDA, " + cSelect															+ CRLF
cQuery += "FROM CONTROLE_GLOSA_AUTO_PR CONTROLE"															+ CRLF
cQuery += "INNER JOIN " + RetSqlName('BAU') + "	BAU ON BAU_FILIAL = '" + xFilial('BAU') + "'"				+ CRLF 
cQuery += "  AND BAU_CODIGO = RDA"																			+ CRLF  
cQuery += "  AND BAU.D_E_L_E_T_ = ' '"																		+ CRLF  
cQuery += "WHERE EMPRESA = '" + If(cEmpAnt == '01','CAB','INT') + "'"										+ CRLF 
cQuery += "  AND TABELA = 'BD6" + cEmpAnt + "0'"															+ CRLF  
cQuery += "  AND VLR_TOT >= " + cValToChar(mv_par07)														+ CRLF  
cQuery += "  AND NOT EXISTS" 																				+ CRLF 
cQuery += "  (" 																							+ CRLF 
cQuery += "  	SELECT 1" 																					+ CRLF
cQuery += "  	FROM CONTROLE_GLOSA_AUTO_PR" 																+ CRLF
cQuery += "  	WHERE VLR_GLOSADO > 0" 																		+ CRLF 
cQuery += "  	   AND LOTE = CONTROLE.LOTE"																+ CRLF 
cQuery += "  )" 																							+ CRLF
cQuery += "ORDER BY " + cSelect																				+ CRLF

If Select(cAliasTmp) <> 0
	(cAliasTmp)->(DbCloseArea())
EndIf        

DbUseArea(.T.,"TopConn",TcGenQry(,,cQuery),cAliasTmp,.T.,.T.)

COUNT TO nCont

(cAliasTmp)->(DbGoTop())

If nCont == 0
	MsgStop("Não foram encontrados dados a processar",AllTrim(SM0->M0_NOMECOM))
	Return
EndIf
	
//Limpo os registros para reutilizar
Begin Transaction

	c_Script := "UPDATE CONTROLE_GLOSA_AUTO_PR SET CONSIDERA_RDA = NULL,"						+ CRLF
	c_Script += "VLR_MAX_GLOSA = ROUND((VLR_TOT * '" + cValToChar(mv_par06) + "' /100),2),"		+ CRLF 
	c_Script += "GLOSA_LINHA = NULL, RANK = ROUND(DBMS_RANDOM.VALUE(1,QTD)),"					+ CRLF
	c_Script += "VLR_ACUM_RDA = 0, QTD_ACUM_RDA = 0"											+ CRLF
	c_Script += "WHERE LOTE = " + cValToChar((cAliasTmp)->(LOTE)) 								+ CRLF	
	c_Script += "   AND EMPRESA = '" + If(cEmpAnt == '01','CAB','INT') + "'" 					+ CRLF
	
	If TcSqlExec(c_Script) < 0
		MsgStop("Falha no script ao LIMPAR o campo CONSIDERA_RDA [ " + TcSqlError() + " ]",AllTrim(SM0->M0_NOMECOM))
		Return
	EndIf
	
	ProcRegua(0)
	
	For nI := 1 to 5 
		IncProc('[ MARCA_GLOSA_AUTO_PR_V2_1 ] [ PRÉVIA ]')
	Next

	c_Script := "BEGIN"																	+ CRLF
	c_Script += "MARCA_GLOSA_AUTO_PR_V2_1('" + If(cEmpAnt == '01','CAB','INT') + "',"
	c_Script += cValToChar((cAliasTmp)->(LOTE)) + ","																
	c_Script += cValToChar(nVlrGlosar) + ","										
	c_Script += cValToChar(mv_par05) + ","											
	c_Script += cValToChar(mv_par03) + ","											
	c_Script += cValToChar(mv_par04) + ","											
	c_Script += cValToChar(mv_par07) + ","
	c_Script += "'PREVIA');"															+ CRLF
	c_Script += "END;"																	+ CRLF
	
	If TcSqlExec(c_Script) < 0
		MsgStop("Falha ao executar a procedure MARCA_GLOSA_AUTO_PR_V2_1 [ PRÉVIA ] [ " + TcSqlError() + " ]",AllTrim(SM0->M0_NOMECOM))
		Return
	EndIf
	
End Transaction 

aArea := GetArea()
	
cQryTot	+= "SELECT SUM(VLR_PAG_SELECT) VLRMAX" 									+ CRLF
cQryTot	+= "FROM CONTROLE_GLOSA_AUTO_PR"										+ CRLF
cQryTot	+= "WHERE LOTE = " + cValToChar((cAliasTmp)->(LOTE))					+ CRLF
cQryTot	+= "	AND TABELA = 'BD6" + If(cEmpAnt == '01','010','020') + "'" 		+ CRLF
cQryTot += "	AND EMPRESA = '" + If(cEmpAnt == '01','CAB','INT') + "'" 		+ CRLF
cQryTot += "	AND CONSIDERA_RDA = 'S'"										+ CRLF  
cQryTot += "	AND GLOSA_LINHA IS NOT NULL"									+ CRLF  

TcQuery cQryTot New Alias cAlTot

If !cAlTot->(EOF())
	nVlrGloMax := cAlTot->VLRMAX
Else
	nVlrGloMax := 0
EndIf

cAlTot->(DbCloseArea())

RestArea(aArea)

//Ajusta os retornos dos tipos SQL para retorno tipo ADVPL
For nI := 1 to len(aStrCpos)
	If aStrCpos[nI,2] <> 'C'
		TCSetField(cAliasTmp, aStrCpos[nI,1], aStrCpos[nI,2],aStrCpos[nI,3],aStrCpos[nI,4])
	Endif
Next

cTmp := CriaTrab(NIL,.F.)//Preciso criar um trab para dar Reclock

Copy To &cTmp

DbCloseArea()

DbUseArea(.T.,,cTmp,cAliasTmp,.T.,.T.)

(cAliasTmp)->(DbGoTop())

Return

**************************************************************************************************************************** 

User Function cb573mar

Local aArea		:= GetArea()

DbGoTop()
                
//Filtro ja esta aplicado e quem nao esta no filtro nao eh exibido no loop abaixo
While !EOF()
              
    Reclock(cAliasTmp,.F.) 
    
	If lMarcDesm
		OK 		:= 'X'
		TIPO 	:= 'GLOSA'
	Else
		OK 		:= ' '
		TIPO 	:= 'NAOGLOSA'
	EndIf 
	
	MsUnlock()
	
	DbSkip()

EndDo

oBrwProAt:DrawSelect()

RestArea(aArea)

Return

**************************************************************************************************************************** 

Static Function FiltraBrw

Local cBusca 	:= AllTrim(Replace(cNomeBusca,"'",""))
Local nK		:= 0
Local lBuscNome	:= !empty(cBusca)
Local cExprFilt	:= ''  

If lBuscNome
	
	cExprFilt := ''

	For nK := 1 to len(aCampos)
	
		If nK > 1
			cExprFilt += " .or. "		
		EndIf
		 
		cExprFilt += "(At('" + cBusca + "',Replace(" + aCampos[nK] + "," + '"' + "'" + '"' + ",'')) > 0)"
	
	Next
	
EndIf

If ( Select() > 0 )
	SET FILTER TO &(cExprFilt)
EndIf

lMarcDesm := .F.
oCBox1:CtrlRefresh()

(cAliasTmp)->(DbGoTop())

oBrwProAt:GoBottom()
oBrwProAt:GoTop()
oBrwProAt:DrawSelect()

Return

**************************************************************************************************************************** 

Static Function Grava

If nVlrGlosar > nVlrGloMax
	MsgStop('Valor a glosar maior que o valor máximo!',AllTrim(SM0->M0_NOMECOM))
ElseIf nVlrGlosar <= 0
	MsgStop('Valor a glosar deve ser maior que zero!',AllTrim(SM0->M0_NOMECOM))
Else
	Processa({||PGrava()},AllTrim(SM0->M0_NOMECOM),"Gravando alterações...")
EndIf

Return

****************************************************************************************************************************

Static Function PGrava

Local nCont			:= 0
Local cTot			:= ''
Local cQuery2		:= ''
Local cAliasTmp2	:= GetNextAlias() 
Local aArea	
Local c_Script		:= ''
Local lProssegue 	:= .T.
Local cRDAs			:= ''
Local nI			:= 0	

(cAliasTmp)->(DbGoTop())

COUNT TO nCont

(cAliasTmp)->(DbGoTop())

ProcRegua(nCont) 

cTot := AllTrim(Transform(nCont,'@E 999,999,999'))

nCont := 0

Begin Transaction

	c_Script := "UPDATE CONTROLE_GLOSA_AUTO_PR SET CONSIDERA_RDA = NULL, GLOSA_LINHA = NULL"	+ CRLF
	c_Script += "WHERE LOTE = " + cValToChar((cAliasTmp)->(LOTE)) 								+ CRLF			
	c_Script += "   AND EMPRESA = '" + If(cEmpAnt == '01','CAB','INT') + "'" 					+ CRLF
	
	If TcSqlExec(c_Script) < 0
		MsgStop("Falha no script ao limpar o campo CONSIDERA_RDA e GLOSA_LINHA [ " + TcSqlError() + " ]",AllTrim(SM0->M0_NOMECOM))
		Return
	EndIf
	
	While !(cAliasTmp)->(EOF())
	
		IncProc('Processando ' + AllTrim(Transform(++nCont,'@E 999,999,999')) + ' de ' + cTot + ' ... [ Fase 2 de 4 ]')
	
		If !empty((cAliasTmp)->(OK))
		
			cRDAs += If(!empty(cRDAs),",",'') + cValToChar((cAliasTmp)->(BAU_CODIGO))
			
			If nCont % 100 == 0//Performance
				
				c_Script := "UPDATE CONTROLE_GLOSA_AUTO_PR SET CONSIDERA_RDA = 'S'"						+ CRLF
				c_Script += "WHERE LOTE = " + cValToChar((cAliasTmp)->(LOTE)) 							+ CRLF			
				c_Script += "   AND RDA IN " + FormatIn(cRDAs,',') 						 				+ CRLF
				c_Script += "   AND EMPRESA = '" + If(cEmpAnt == '01','CAB','INT') + "'" 				+ CRLF
				
				If TcSqlExec(c_Script) < 0
					MsgStop("Falha no script ao atualizar o campo CONSIDERA_RDA [ " + TcSqlError() + " ]",AllTrim(SM0->M0_NOMECOM))
					Return
				EndIf
				
				cRDAs := ''
				
			EndIf
			
		EndIf
		
		(cAliasTmp)->(DbSkip())
		
	EndDo
	
	(cAliasTmp)->(DbGoTop())
	
	//Ultimos RDAs - Performance
	
	If !empty(cRDAs)
	
		c_Script := "UPDATE CONTROLE_GLOSA_AUTO_PR SET CONSIDERA_RDA = 'S'"						+ CRLF
		c_Script += "WHERE LOTE = " + cValToChar((cAliasTmp)->(LOTE)) 							+ CRLF			
		c_Script += "   AND RDA IN " + FormatIn(cRDAs,',') 						 				+ CRLF
		c_Script += "   AND EMPRESA = '" + If(cEmpAnt == '01','CAB','INT') + "'" 				+ CRLF
		
		If TcSqlExec(c_Script) < 0
			MsgStop("Falha no script ao atualizar o campo CONSIDERA_RDA [ " + TcSqlError() + " ]",AllTrim(SM0->M0_NOMECOM))
			Return
		EndIf
		
	EndIf
	
	ProcRegua(0)
	
	For nI := 1 to 5 
		IncProc('[ MARCA_GLOSA_AUTO_PR_V2_1 ] [ Fase 3 de 4 ]')
	Next
	
	c_Script := "BEGIN"																	+ CRLF
	c_Script += "MARCA_GLOSA_AUTO_PR_V2_1('" + If(cEmpAnt == '01','CAB','INT') + "',"
	c_Script += cValToChar((cAliasTmp)->(LOTE)) + ","																
	c_Script += cValToChar(nVlrGlosar) + ","										
	c_Script += cValToChar(mv_par05) + ","											
	c_Script += cValToChar(mv_par03) + ","											
	c_Script += cValToChar(mv_par04) + ","											
	c_Script += cValToChar(mv_par07) + ","
	c_Script += "'MARCAR');"															+ CRLF
	c_Script += "END;"																	+ CRLF
	
	If TcSqlExec(c_Script) < 0
		MsgStop("Falha ao executar a procedure MARCA_GLOSA_AUTO_PR_V2_1 [ " + TcSqlError() + " ]",AllTrim(SM0->M0_NOMECOM))
		Return
	EndIf
	
	(cAliasTmp)->(DbGoTop())

End Transaction 

aArea := GetArea()

cQuery2	:= "SELECT SUM(VLR_PAG_SELECT) VLR"								+ CRLF
cQuery2	+= "FROM CONTROLE_GLOSA_AUTO_PR" 								+ CRLF
cQuery2	+= "WHERE LOTE = " + cValToChar((cAliasTmp)->(LOTE)) 			+ CRLF			
cQuery2 += "  AND EMPRESA = '" + If(cEmpAnt == '01','CAB','INT') + "'"	+ CRLF
cQuery2	+= "  AND TABELA = 'BD6" + cEmpAnt + "0'" 						+ CRLF
cQuery2	+= "  AND CONSIDERA_RDA = 'S'" 									+ CRLF
cQuery2	+= "  AND GLOSA_LINHA IS NOT NULL" 								+ CRLF

TcQuery cQuery2 New Alias cAliasTmp2

nCalcGlo := cAliasTmp2->VLR

cAliasTmp2->(DbCloseArea())  

RestArea(aArea)

MsgInfo('Valor a ser glosado: R$ ' + AllTrim(Transform(nCalcGlo,'@E 999,999,999,999.99')),AllTrim(SM0->M0_NOMECOM)) 

If ( nCalcGlo > 0 ) .and. MsgYesNo('Deseja glosar o valor [ R$ ' + AllTrim(Transform(nCalcGlo,'@E 999,999,999,999.99')) + ' ] ?',AllTrim(SM0->M0_NOMECOM))
	
	ProcRegua(nCont)
	
	nCont := 0

	(cAliasTmp)->(DbGoTop())
	
	While !(cAliasTmp)->(EOF())
	
		IncProc('Processando ' + AllTrim(Transform(++nCont,'@E 999,999,999')) + ' de ' + cTot + ' ... [ Fase 4 de 4 ]')
				
		If !empty((cAliasTmp)->(OK))
		
			c_Script := "BEGIN" 														+ CRLF
			
			c_Script += "GLOSA_AUTO_PR_V2" 												+ CRLF
			c_Script += "(" 															+ CRLF
			c_Script += "'" + If(cEmpAnt == '01','CAB','INT') + "'," 					+ CRLF 
			c_Script += cValToChar((cAliasTmp)->(LOTE)) + "," 							+ CRLF 
			c_Script += "'" + (cAliasTmp)->(BAU_CODIGO) + "'"							+ CRLF 
			c_Script += ");" 															+ CRLF			
			
			c_Script += "END;" 															+ CRLF
			
			If TcSqlExec(c_Script) < 0
				MsgStop("Falha na procedure GLOSA_AUTO_PR_V2 [ " + TcSqlError() + " ]",AllTrim(SM0->M0_NOMECOM))
				Return
			EndIf
			
		EndIf
		
		(cAliasTmp)->(DbSkip())
		
	EndDo
	
EndIf
	
oBrwProAt:GoBottom()
oBrwProAt:GoTop()
oBrwProAt:DrawSelect()

Return

****************************************************************************************************************************

Static Function MarcaDes

(cAliasTmp)->(Reclock(cAliasTmp,.F.))
	
(cAliasTmp)->(OK) 	:= If(empty((cAliasTmp)->(OK)),'X',' ')
(cAliasTmp)->(TIPO) := If(empty((cAliasTmp)->(OK)),'NAOGLOSA','GLOSA')
	
(cAliasTmp)->(MsUnlock())

oBrwProAt:DrawSelect() 

Return

****************************************************************************************************************************

User Function CABA573Leg

BrwLegenda('Projeto glosa automática PR', "Legenda", {	{"BR_VERDE"		, "Glosar"				},;
														{"BR_VERMELHO"	, "NÃO Glosar"			}})

Return

****************************************************************************************************************************

Static Function lUSRxPR

Local aArea    		:= GetArea()
Local lRet 			:= .F.
Local c_CodUsr		:= RetCodUsr()
Local c_UsrName		:= UsrRetName(c_CodUsr)

If Upper(Alltrim(c_UsrName)) $ Upper(GetNewPar("MV_YGLOPR","MAX.SANTOS")) 
	lRet := .T.
ElseIf c_CodUsr $ GetMV('MV_XGETIN') + '|' + GetMV('MV_XGERIN')
	lRet := .T.
EndIf
	
If !lRet
	Aviso(AllTrim(SM0->M0_NOMECOM),"ATENÇÃO:" + CRLF + "Usuário sem acesso ao projeto PR!",{ "Ok" })
Endif

RestArea(aArea) 

Return lRet

****************************************************************************************************************************

Static Function AjustaSX1

PutSx1(cPerg,"01","Mês"						,"","","mv_ch1","N",2 ,0,0,"G","","","",""	,"mv_par01","","","","","","","","","","","","","","","","",{"Informe o MES"},{""},{""})
PutSx1(cPerg,"02","Ano"						,"","","mv_ch2","N",4 ,0,0,"G","","","",""	,"mv_par02","","","","","","","","","","","","","","","","",{"Informe o ANO"},{""},{""})
PutSx1(cPerg,"03","Quant. Procs. Glosar"	,"","","mv_ch3","N",2 ,0,0,"G","","","",""	,"mv_par03","","","","","","","","","","","","","","","","",{"Informe a quantidade de procedimentos ","que devem ser glosados"},{""},{""})
PutSx1(cPerg,"04","Vlr Mín Glosar"			,"","","mv_ch4","N",2 ,0,0,"G","","","",""	,"mv_par04","","","","","","","","","","","","","","","","",{"Informe o valor mínimo do procedimento ","para que este seja considerado ","para glosa"},{""},{""})
PutSx1(cPerg,"05","Qtd Mín Real RDA"		,"","","mv_ch5","N",4 ,0,0,"G","","","",""	,"mv_par05","","","","","","","","","","","","","","","","",{"Informe a quantidade mínima de ","procedimentos realizados pelo RDA ","para que este seja considerado ","para glosa"},{""},{""})
PutSx1(cPerg,"06","Perc Max Fat RDA"		,"","","mv_ch6","N",3 ,0,0,"G","","","",""	,"mv_par06","","","","","","","","","","","","","","","","",{"Informe o percentual máximo de ","glosa do faturamento do RDA ","para que este seja considerado ","para glosa"},{""},{""})
PutSx1(cPerg,"07","Fat Mínimo RDA"			,"","","mv_ch7","N",12,0,0,"G","","","",""	,"mv_par07","","","","","","","","","","","","","","","","",{"Informe o valor de faturamento ","mínimo do RDA para ","que este seja considerado ","para glosa"},{""},{""})

Return

****************************************************************************************************************************