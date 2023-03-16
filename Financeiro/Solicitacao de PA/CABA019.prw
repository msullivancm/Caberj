#Include "RwMake.ch"
#Include "Topconn.ch"
#Include "TbiConn.ch"
#Include "TbiCode.ch"
#INCLUDE "PROTHEUS.CH"                                                                                                                                        
#INCLUDE "ap5mail.ch"                                  
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±   			
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABA019   º Autor ³ Marcela Coimbra    º Data ³  07/05/10   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Cadasto de SPAs                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CABERJ                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
  
User Function CABA019()

Private cCadastro	:= "Cadastro de Solicitação de PA"

Private aRotina 	:={ { "Pesquisar"	,"AxPesqui"		,0,1	} ,;
		            	{ "Visualizar"	,"u_cb19Visu"	,0,2	} ,;
		             	{ "Incluir"		,"u_cb19inclui"	,0,3	} ,;
		             	{ "Cancela"		,"u_cb19Estrona",0,7	} ,;   //	
		             	{ "Alterar"     ,"u_CABTMP"	,0,8	} ,;
		             	{ "Legenda"		,"u_c19Legend"	,0,6	} ,;// 		             		             	
		             	{ "Relatorio"   ,"u_CABR025"	,0,8	} } 
		                                                               //

Private aCores 		:={ { 'PA0_STATUS== " "', 'BR_AZUL' 	} ,; 
						{ 'PA0_STATUS== "A"', 'BR_VERDE' 	} ,;
						{ 'PA0_STATUS== "C"', 'BR_PRETO'  	} ,;
						{ 'PA0_STATUS== "R"', 'BR_VERMELHO'	} ,;
						{ 'PA0_STATUS== "E"', "BR_CINZA" 	} }


Private a_SaldoPls  := {}
Private a_VetSe2  	:= {}

dbSelectArea("PA0")
dbSetOrder(1)  


dbSelectArea("PA0")
mBrowse( 6,1,22,75,"PA0",,,,,,aCores)

 Return     

**'--------------------------------------------------------------'**
User Function cb19Visu(cAlias, nReg)
**'--------------------------------------------------------------'**

Private a_Buttons := {}
Private cCadastro := "Solicitação de PA" // 

aAdd( a_Buttons, { "BUDGET"	,{|| u_c19Posic("SCR", nReg, 3) }, "Visualisa aprovações", "Vis. Aprocação " } )       
aAdd( a_Buttons, { "RELATORIO",{|| u_c19PoRDA("PA0", nReg, 2) }, "Visualisa Status RDA", "Vis. RDA " } )

If PA0->PA0_STATUS = 'A'                                                                                

	aAdd( a_Buttons, { "SDUPROP",{|| u_c19VisTit("PA0", nReg, 2) }, "Visualisa Título", "Vis. Título" } )
    
EndIf                

nOpca := AxVisual("PA0",PA0->(Recno()),2,,,,,a_Buttons,,,,,,,,,)                                                                       

Return

**'--------------------------------------------------------------'**
User Function cb19inclui(cAlias, nReg, nOpc )                                                                                                
**'-----------------------'---------------------------------------'**      
Local c_Assunto := "Aprovação de Pagamento Antecipado"
Local a_Msg 	:= {}

Private a_Buttons := {}
Private cCadastro 	:= "Solicitação de PA" // 
Private c_Perg 		:= "CABA016YXX" // 
Private c_Alias 	:= "QRYSAL"
Private c_AnoIni	:=	""
Private c_AnoFin	:=	""
Private c_MesIni	:=	""
Private c_MesFin	:=	""                                                   
Private c_RDA		:=	""

Private  c_Fornece  := " "
Private  c_NomeFor  := " "
Private  n_Valor  	:= 0
Private  n_VlPro  	:= 0
Private  n_Perc  	:= GetNewPar('MV_YPERCPA', 80)    

Public c_PA0Naturez
Public c_TipoCon := " "

dbSelectArea("PA3")
dbSetOrder(1)
If dbSeek( xFilial("PA3") + __cUserId )

	VerSx1( c_Perg )
	
	If ! Pergunte( c_Perg )
	
		Return
	
	EndIf

	c_AnoIni	:=	MV_PAR01
	c_MesIni	:=	MV_PAR02
	c_AnoFin	:=	MV_PAR03
	c_MesFin	:=	MV_PAR04
	c_RDA		:=	MV_PAR05 

	dbselectarea("BAU")
	dbsetorder(1)
	If dbseek(xFilial("BAU")+ c_RDA )
		c_Fornece := BAU->BAU_CODSA2
		c_NomeFor := BAU->BAU_NOME
	Else
		
   		Alert("Fornecedor nao cadastrado para o RDA.")
		Return                              
	
	Endif

	dbSelectArea("SA2")
	dbSetOrder(1)
	If dbSeek(xFilial("SA2") + c_Fornece )
	     
		c_PA0Naturez := SA2->A2_NATUREZ
		c_TipoCon	 := SA2->A2_YTPTITU
	
	EndIf

	n_Perc  	:= GetNewPar('MV_YPERCPA', 80)
		
	aAdd( a_Buttons, { "RELATORIO",{|| u_c19PoRDA("PA0", nReg, 3) }, "Visualisa Status RDA", "Vis. RDA " } )
	
	nOpca := AxInclui("PA0",PA0->(Recno()), 3, , , , , .F., , a_Buttons, ,,,.T.,,,,,)      
	
	If nOpca == 1 // OK
	
		a_Banco := &(GetMv("MV_XBCOPA"))
	
		dbSelectArea('PA0')
		Reclock("PA0", .F.)
		
			PA0->PA0_DTINC   	:= DATE()
			PA0->PA0_PERINI  	:= c_AnoIni + c_MesIni
			PA0->PA0_PERFIN  	:= c_AnoFin + c_MesFin
		  	PA0->PA0_FORNECE 	:= c_Fornece
			PA0->PA0_SOLICI 	:= __cUserId                                                                 	
			PA0->PA0_PAGREA 	:= PA0->PA0_PAGSUG
			PA0->PA0_GRUPO 		:= PA3->PA3_GRUPO 
			PA0->PA0_BANCO 		:= a_Banco[1]
			PA0->PA0_AGENCIA 	:= a_Banco[2]
			PA0->PA0_CONTA 		:= a_Banco[3]  
			
			                            
		MsUnlock()

		fMontaGrade("PA0", PA0->(Recno()), nOpc  , PA3->PA3_GRUPO )          
		                
		u_cb19SE2Sal( c_Fornece )
		//u_cb19GSaldo(PA0->PA0_RDA, PA0->PA0_PERINI, PA0->PA0_PERFIN ) 

		
		u_016WFApro( a_SaldoPls,  a_VetSe2 , PA0->PA0_NUM,  PA3->PA3_GRUPO )

	EndIf

Else 
         
	Aviso("CABERJ - Usuário não esta autorizado.", "Para incluir uma solicitação de pagamento antecipado, o seu usuário deve estar cadastrado como solicitante. ", {"Ok"})

EndIf 

Return                                                              

**'--------------------------------------------------------------------------'** 
Static Function fMontaGrade(cAlias, nReg, nOpc, c_Grade)
**'--------------------------------------------------------------------------'**     

dbSelectArea("PA0")
dbGoTo(nReg)                              

if nOpc == 3 // Inclusao

	u_fAltGrade({PA0->PA0_NUM,"PA",PA0->PA0_VALOR,,,c_Grade,,1,,dDataBase},dDataBase,1)// Cria grade
                        
ElseIf nOpc == 4 // Alteração
   
	dbSelectArea("SCR")
	dbSetOrder(2)
	If dbSeek(xFilial("SCR") + "PA" + PA0->PA0_NUM+Space(Len(SCR->CR_NUM)-Len(PA0->PA0_NUM)) + __cUserId )

		u_fAltGrade({PA0->PA0_NUM,"PA"        ,PA0->PA0_VALOR,,,c_Grade,,,,dDataBase},dDataBase,6)// Bloqueia Grade

	EndIf
	
EndIf

Return

**'------------------------------------------------------------------------*-'**
User Function fAltGrade(aDocto,dDataRef,nOper, lTimeOut, l_Niv)
**'------------------------------------------------------------------------*-'**

Local cDocto	:= aDocto[1]   	
Local cTipoDoc	:= aDocto[2]
Local nValDcto	:= aDocto[3]
Local cAprov	:= If(aDocto[4]==Nil,"",aDocto[4])
Local cUsuario	:= If(aDocto[5]==Nil,"",aDocto[5])
Local nMoeDcto	:= If(Len(aDocto)>7,If(aDocto[8]==Nil, 1,aDocto[8]),1)
Local nTxMoeda	:= If(Len(aDocto)>8,If(aDocto[9]==Nil, 0,aDocto[9]),0)
Local aArea		:= GetArea()
Local aAreaSCR  := SCR->(GetArea())
Local nSaldo	:= 0
Local cGrupo	:= If(aDocto[6]==Nil,"",aDocto[6])
Local lFirstNiv:= .T.
Local cAuxNivel:= ""
Local cNextNiv := ""
Local lAchou	:= .F.
Local nRec		:= 0
Local lRetorno	:= .T.
Local aSaldo	:= {}
Local _lExcNivel := GetnewPar("MV_XEXCNIV", .F.) // Determina se um usuario pode aprovar dois niveis de uma mesma SP ou se exclui os niveis posteriores a aprovacao

dDataRef 	:= dDataBase
cDocto 		:= cDocto+Space(Len(SCR->CR_NUM)-Len(cDocto))
lTimeOut	:= IF(lTimeOut==Nil, .F. , lTimeOut)

CHKFile("SAK")                                                                  
CHKFile("SZV")
CHKFile("SZX")
CHKFile("SAL")

If Empty(cUsuario) .And. (nOper != 1 .And. nOper != 6) //nao e inclusao ou estorno de liberacao
	dbSelectArea("SAK")
	dbSetOrder(2)
	dbSeek(xFilial()+cAprov)
	cUsuario :=	AK_USER
	//nMoeDcto :=	AK_MOEDA
	//nTxMoeda	:=	0

EndIf

If nOper == 1  //Inclusao do Documento
	cGrupo := If(!Empty(aDocto[6]),aDocto[6],cGrupo)
	dbSelectArea("SAL")
	dbSetOrder(2)
	If !Empty(cGrupo) .And. dbSeek(xFilial()+cGrupo)
		While !Eof() .And. xFilial("SAL")+cGrupo == AL_FILIAL+AL_COD
		  /*	If SAL->AL_AUTOLIM == "S" //.And. !MaAlcLim(SAL->AL_APROV,nValDcto,nMoeDcto,nTxMoeda)
				dbSelectArea("SAL")
				dbSkip()
				Loop
			EndIf
		*/	
			If lFirstNiv
				cAuxNivel := SAL->AL_NIVEL
				lFirstNiv := .F.
			EndIf
			Reclock("SCR",.T.)
			SCR->CR_FILIAL	:= xFilial("SCR")
			SCR->CR_NUM		:= cDocto
			SCR->CR_TIPO	:= cTipoDoc
			SCR->CR_NIVEL	:= SAL->AL_NIVEL
			SCR->CR_USER	:= SAL->AL_USER
			SCR->CR_APROV	:= SAL->AL_APROV
			SCR->CR_STATUS	:= IIF(SAL->AL_NIVEL == cAuxNivel,"02","01")
			SCR->CR_TOTAL	:= nValDcto
			SCR->CR_EMISSAO := aDocto[10]
			SCR->CR_MOEDA	:=	nMoeDcto
			SCR->CR_TXMOEDA := nTxMoeda
			MsUnlock()
			dbSelectArea("SAL")
			dbSkip()
		EndDo
	EndIf
	lRetorno := lFirstNiv
EndIf

If nOper == 3  //exclusao do documento
	dbSelectArea("SCR")
	dbSetOrder(1)
	dbSeek(xFilial("SCR")+cTipoDoc+cDocto)
	While !Eof() .And. SCR->CR_FILIAL+SCR->CR_TIPO+SCR->CR_NUM == xFilial("SCR")+cTipoDoc+cDocto
		Reclock("SCR",.F.,.T.)
		dbDelete()
		MsUnlock()
		dbSkip()
	EndDo
EndIf

If nOper == 4 //Aprovacao do documento
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Atualiza o saldo do aprovador. 	                ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

	QOut( " :o) 1 " )
	dbSelectArea("SAK")
	dbSetOrder(2)
	dbSeek(xFilial()+cAprov)
	QOut( " :o)  APROV-->" + cAprov )
	
	
	QOut( " :o)  gRUPO-->" + cGrupo )   
	QOut( " :o)  num sp-->" + SCR->CR_NUM )
	
	dbSelectArea("SAL")
	dbSetOrder(3)
	if 	dbSeek(xFilial()+cGrupo+SAK->AK_COD)
			QOut( " :o) 2 " )
		cAuxNivel:= SAL->AL_NIVEL
	
	endIf
	QOut(cAuxNivel)
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Libera o pedido pelo aprovador.                     ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

   //	dbSelectArea("SCR")
	//dbSetOrder(1)
	//dbSeek(xFilial("SCR")+cTipoDoc+cDocto+cAuxNivel)  
	
	If !ValidNiv( SCR->CR_NUM, SCR->CR_NIVEL )  

		QOut( " EXISTEM NIVEIS INFERIORES QUE NAO FORAM APROVADOS-->" + SCR->CR_NIVEL )  
        l_Niv := .F.      
        lRetorno := .F.
		
	Else
		
	QOut( " PASSOU AKI-->" + SCR->CR_NIVEL ) 
		Reclock("SCR",.F.)
		CR_STATUS	:= "03"
		CR_OBS		:= If(Len(aDocto)>10,aDocto[11],"")
		CR_DATALIB	:= dDataBase
		CR_USERLIB	:= SAK->AK_USER
		CR_LIBAPRO	:= SAK->AK_COD
		CR_VALLIB	:= nValDcto
		CR_TIPOLIM	:= SAK->AK_TIPO
		CR_XDTLIMI  := CTOD("  /  /  ")
		CR_XHRLIMI  := "     "
		MsUnlock()
			
		nRec := SCR->(RecNo())
			QOut( " :o) loop dcr " )    
			dbSelectArea("SCR")
			dbSetOrder(1)
			dbSeek( xFilial("SCR")+ "PA" + cDocto )
	 	While !Eof() .And. xFilial("SCR")+ "PA" + cDocto+cTipoDoc == CR_FILIAL+ "PA" + CR_NUM+CR_TIPO
	 		QOut( " :o) 1 " )
			If cAuxNivel == CR_NIVEL .And. CR_STATUS != "16" .And. SAL->AL_TPLIBER$"U "
				QOut( " :o) 2 " )
				Exit
			EndIf
		QOut( " :o) 3 " )
			if _lExcNivel .and. SAK->AK_USER == SCR->CR_USER .and. SCR->CR_STATUS $ "01#02" .and. CR_NIVEL >= cAuxNivel
		QOut( " :o) 4 " )
				Reclock("SCR",.F.)
				SCR->(dbdelete())
				MsUnlock()
			endif
				QOut( " :o) 5 " )
				If __cUserId $ GetMv("MV_XAPROSB")  .AND. cAuxNivel > '01' 
				QOut( " :o) 6 " )
					Reclock("SCR",.F.)
	
						CR_STATUS	:= "05"
						CR_DATALIB	:= dDataBase
						CR_USERLIB	:= SAK->AK_USER
						CR_LIBAPRO	:= SAK->AK_COD
						//CR_APROV	:= cAprov
	
					MsUnlock()
					dbSkip()
	
				    Loop
				
				EndIf
			
				QOut( " :o) 7 " )
			if ( cAuxNivel == SCR->CR_NIVEL .And. SCR->CR_STATUS != "03" .And. SAL->AL_TPLIBER$"NP" .and. Empty( SCR->CR_DATALIB ) )
				QOut( " :o) 8 " )
				Reclock("SCR",.F.)
				CR_STATUS	:= "05"
				CR_DATALIB	:= dDataBase
				CR_USERLIB	:= SAK->AK_USER
				CR_LIBAPRO	:= SAK->AK_COD
				//CR_APROV	:= cAprov
				MsUnlock()
			EndIf
		QOut( " :o) 9" )
			If CR_NIVEL > cAuxNivel .And. CR_STATUS != "03" .And. !lAchou
		QOut( " :o) 10 " )
				lAchou 	:= .T.
				cNextNiv := CR_NIVEL
			EndIf
			
			QOut( " :o) *** " + iif(lAchou, ".t.", ".f." ) + "CR_NIVEL - " + CR_NIVEL + "; cNextNiv = " + cNextNiv + "; CR_STATUS - " + CR_STATUS )
			
			If lAchou .And. CR_NIVEL == cNextNiv .And. CR_STATUS != "03"
				QOut( " :o) 11 " )
				Reclock("SCR",.F.)
				CR_STATUS	:= "02"
				IF (SAL->AL_TPLIBER=="P" .AND. !lTimeOut  .and. Empty( SAK->AK_USER ))
					QOut( " :o) 12 " )
					CR_STATUS	:= "05"
					CR_DATALIB	:= dDataBase
					CR_USERLIB	:= SAK->AK_USER
					CR_LIBAPRO	:= SAK->AK_COD
					CR_OBS		:= "Aprovado por " + UsrRetName(SAK->AK_USER)
				ENDIF               
					QOut( " :o) 13 " )
				MsUnlock()
			Endif
			dbSkip()
		EndDo
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Reposiciona e verifica se ja esta totalmente liberado.       ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ      
			QOut( " :o) fim loop scr " )
		
		
		dbSelectArea("SCR")
		SCR->( dbGoTop() )
		dbSetOrder(2)
		dbSeek(xFilial("SCR") + cTipoDoc+ cDocto+Space(Len(cDocto)-Len(cDocto))  )
	
		While !Eof() .And. xFilial("SCR")+cTipoDoc+cDocto == CR_FILIAL+CR_TIPO+CR_NUM
			If CR_STATUS != "03" .And. CR_STATUS != "05"
				lRetorno := .F.
			EndIf
			dbSkip()
		EndDo
	EndIf

	EndIf

If nOper == 5 // Estorno da reprovacao
	
	_cQuery := " SELECT CR_FILIAL, CR_TIPO, CR_NUM, CR_NIVEL FROM " + RetSQLName("SCR")
	_cQuery += " WHERE CR_FILIAL = '" + xFilial("SCR") + "'"
	_cQuery += " AND CR_NUM = '" + cDocto + "'"
	_cQuery += " AND CR_TIPO = '" + cTipoDoc + "'"
	_cQuery += " AND CR_STATUS = '04'"
	_cQuery += " AND D_E_L_E_T_ = ' '"
	
	TcQuery _cQuery New Alias "QRYEST"
	
	QRYEST->(dbgotop())
	
	SCR->(dbsetorder(1)) //CR_FILIAL, CR_TIPO, CR_NUM, CR_NIVEL
	if SCR->(dbseek(QRYEST->(CR_FILIAL+CR_TIPO+CR_NUM+CR_NIVEL)))
		while SCR->(!EOF()) .and. SCR->(CR_FILIAL+CR_TIPO+CR_NUM) == QRYEST->(CR_FILIAL+CR_TIPO+CR_NUM)
			
			if SCR->CR_NIVEL >= QRYEST->CR_NIVEL .and. SCR->CR_STATUS $ "04/05" // Bloqueado ou bloqueado por outro nivel
				RecLock("SCR",.F.)
				if SCR->CR_STATUS == "05" // So limpa a observacao se nao for quem reprovou
					SCR->CR_OBS := ""
				endif
				SCR->CR_STATUS 	:= iif(SCR->CR_NIVEL == QRYEST->CR_NIVEL, "02", "01")
				SCR->CR_DATALIB	:= ctod("  /  /  ")
				SCR->CR_USERLIB	:= ""
				SCR->CR_WF 		:= ""
				SCR->CR_XWFID	:= ""
				SCR->CR_XNVEZ 	:= 0
				MsUnlock()
			endif
			
			SCR->(dbskip())
		enddo
		
	endif
	
	QRYEST->(dbclosearea())
	
endif

If nOper == 6  //Bloqueio manual
	
	dbSelectArea("SAK")
	dbSetOrder(1)
	dbSeek(xFilial()+cAprov)
	
	dbSelectArea("SCR")
	cAuxNivel := CR_NIVEL
	
	Reclock("SCR",.F.)
	CR_STATUS   := "04"
	CR_OBS	   	:= If(Len(aDocto)>10,aDocto[11],"Reprovaçao manual")
	CR_DATALIB  := dDataBase
	CR_USERLIB	:= SAK->AK_USER
	CR_LIBAPRO	:= SAK->AK_COD
	CR_XDTLIMI  := CTOD("  /  /  ")
	CR_XHRLIMI  := "     "
	MsUnlock()
	
	cNome		:= UsrRetName(SAK->AK_USER)
	
	dbSelectArea("SCR")
	dbSetOrder(1)
	dbSeek(xFilial("SCR")+cTipoDoc+cDocto+cAuxNivel)
	
	nRec := RecNo()
	While !Eof() .And. xFilial("SCR")+cDocto+cTipoDoc == CR_FILIAL+CR_NUM+CR_TIPO
		
		If (CR_NIVEL>=cAuxNivel .And. CR_STATUS != "04" )
			Reclock("SCR",.F.)
			CR_STATUS	:= "04"
			CR_DATALIB	:= dDataBase
			CR_USERLIB	:= SAK->AK_USER
			CR_OBS		:= "Reprovado por " + ALLTRIM(cNome)
			MsUnlock()
		EndIf
		
		dbSkip()
	EndDo
	
	lRetorno := .F.
EndIf

dbSelectArea("SCR")
RestArea(aAreaSCR)

Return(lRetorno)             


**'-----------------------------------------------------------------------'** 
User Function c19Posic(cAlias,nReg,nOpcx,cTipoDoc,lStatus)
**'-----------------------------------------------------------------------'** 

Local aArea		:= GetArea()
Local aSavCols  := {}
Local aSavHead  := {}
Local cHelpApv  := OemToAnsi("Este documento nao possui controle de aprovacao.") 
Local cAliasSCR := "TMP"
Local cComprador:= ""
Local cSituaca  := ""
Local cNumDoc   := ""
Local cStatus   := ""
Local cTitle    := ""
Local cTitDoc   := ""
Local cAddHeader:= ""

Local lBloq     := .F.
Local lQuery    := .F.

Local nSavN		:= 0
Local nX   		:= 0
Local nY        := 0

Local oDlg
Local oGet
Local oBold
Local cQuery   := ""
Local aStruSCR := {}

Private cTipoDoc := "PA"
Private lStatus  := .T.

Private aCols   := {}
Private aHeader := {}
Private N       := 1

dbSelectArea(cAlias)
dbGoto(nReg)

If !Empty(SC7->C7_APROV)
	cTitle    := OemToAnsi("Aprovacao de Solicitação de PA")  
	cTitDoc   := OemToAnsi("SPA") 
	cHelpApv  := OemToAnsi("Não foi montada grade de aprovação para essa SPA") 
	cNumDoc   := PA0->PA0_NUM
	cComprador:= UsrRetName( PA0->PA0_SOLICI )
	cStatus   := IIF(PA0->PA0_STATUS=="A",OemToAnsi("SPA Liberada"),OemToAnsi("SPA Aguardando Liberação"))
	
EndIf

If !Empty(cNumDoc) 

	aHeader:= {}
	aCols  := {}

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Faz a montagem do aHeader com os campos fixos.               ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	dbSelectArea("SX3")
	dbSetOrder(1)
	MsSeek("SCR")
	While !Eof() .And. (SX3->X3_ARQUIVO == "SCR")
		IF AllTrim(X3_CAMPO)$"CR_YOBS2/CR_NIVEL/CR_OBS/CR_DATALIB/" + cAddHeader
			AADD(aHeader,{	TRIM(X3Titulo()),;
			SX3->X3_CAMPO,;
			SX3->X3_PICTURE,;
			SX3->X3_TAMANHO,;
			SX3->X3_DECIMAL,;
			SX3->X3_VALID,;
			SX3->X3_USADO,;
			SX3->X3_TIPO,;
			SX3->X3_ARQUIVO,;
			SX3->X3_CONTEXT } )

			If AllTrim(x3_campo) == "CR_NIVEL"
				AADD(aHeader,{ OemToAnsi("Usuario"),"bCR_NOME",   "",15,0,"","","C","",""} )
				AADD(aHeader,{ OemToAnsi("Situacao"),"bCR_SITUACA","",20,0,"","","C","",""} ) 
				AADD(aHeader,{ OemToAnsi("Usuario Lib."),"bCR_NOMELIB","",15,0,"","","C","",""} ) 
			EndIf

		Endif

		dbSelectArea("SX3")		
		dbSkip()
	EndDo

ADHeadRec("SCR",aHeader)

aStruSCR := SCR->(dbStruct())
cTipoDoc := "PA"
cAliasSCR := GetNextAlias()
cQuery    := "SELECT SCR.*,SCR.R_E_C_N_O_ SCRRECNO FROM "+RetSqlName("SCR")+" SCR "
cQuery    += "WHERE SCR.CR_FILIAL='"+xFilial("SCR")+"' AND "
cQuery    += "SCR.CR_NUM = '"+Padr(PA0->PA0_NUM,Len(PA0->PA0_NUM))+"' AND "
cQuery    += "SCR.CR_TIPO = 'PA' AND "
cQuery    += "SCR.D_E_L_E_T_=' ' "
cQuery := ChangeQuery(cQuery)
dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAliasSCR)

For nX := 1 To Len(aStruSCR)
	If aStruSCR[nX][2]<>"C"
		TcSetField(cAliasSCR,aStruSCR[nX][1],aStruSCR[nX][2],aStruSCR[nX][3],aStruSCR[nX][4])
	EndIf
Next nX

dbSelectArea(cAliasSCR)

While !Eof() .And.(cAliasSCR)->CR_FILIAL+(cAliasSCR)->CR_TIPO+Substr((cAliasSCR)->CR_NUM,1,6) == xFilial("SCR") + cTipoDoc + cNumDoc
			
		aadd(aCols,Array(Len(aHeader)+1))
		nY++
		For nX := 1 to Len(aHeader)
            If IsHeadRec(aHeader[nX][2])
			    aCols[nY][nX] := IIf(lQuery , (cAliasSCR)->SCRRECNO , SCR->(Recno())  )
            ElseIf IsHeadAlias(aHeader[nX][2])
			    aCols[nY][nX] := "SCR"
			ElseIf aHeader[nX][02] == "bCR_NOME"
				aCols[nY][nX] := UsrFullName((cAliasSCR)->CR_USER)
			ElseIf aHeader[nX][02] == "bCR_SITUACA"
				Do Case
				Case (cAliasSCR)->CR_STATUS == "01"
					cSituaca := "Aguardando"
				Case (cAliasSCR)->CR_STATUS == "02"
					cSituaca := "Em Aprovacao"
				Case (cAliasSCR)->CR_STATUS == "03"
					cSituaca := "Aprovado" 
				Case (cAliasSCR)->CR_STATUS == "04"
					cSituaca := "Bloqueado"                
					
					lBloq := .T.
				Case (cAliasSCR)->CR_STATUS == "05"
					cSituaca := "Nivel Liberado "
				EndCase
				aCols[nY][nX] := cSituaca
			ElseIf aHeader[nX][02] == "bCR_NOMELIB"
				aCols[nY][nX] := UsrRetName((cAliasSCR)->CR_USERLIB)
			ElseIf ( aHeader[nX][10] != "V")
				aCols[nY][nX] := FieldGet(FieldPos(aHeader[nX][2]))
			EndIf
		Next nX
		aCols[nY][Len(aHeader)+1] := .F.
		dbSkip()
	EndDo

	If !Empty(aCols)
		If lBloq
			cStatus := "BLOQUEADO"
		EndIf	
		n:=	 IIF(n > Len(aCols), Len(aCols), n)  
		DEFINE FONT oBold NAME "Arial" SIZE 0, -12 BOLD
		DEFINE MSDIALOG oDlg TITLE cTitle From 109,095 To 400,600 OF oMainWnd PIXEL	 //"Aprovacao do Pedido de Compra // Contrato"
		@ 005,003 TO 032,250 LABEL "" OF oDlg PIXEL
		@ 015,007 SAY cTitDoc OF oDlg FONT oBold PIXEL SIZE 046,009 
		@ 014,041 MSGET cNumDoc PICTURE "" WHEN .F. PIXEL SIZE 050,009 OF oDlg FONT oBold
        If cTipoDoc <> "NF"
			@ 015,103 SAY OemToAnsi("Solicitante") OF oDlg PIXEL SIZE 033,009 FONT oBold 
			@ 014,138 MSGET cComprador PICTURE "" WHEN .F. of oDlg PIXEL SIZE 103,009 FONT oBold
        EndIF
		@ 132,008 SAY 'Situacao :' OF oDlg PIXEL SIZE 052,009 
		@ 132,038 SAY cStatus OF oDlg PIXEL SIZE 120,009 FONT oBold
		@ 132,205 BUTTON 'Fechar' SIZE 035 ,010  FONT oDlg:oFont ACTION (oDlg:End()) OF oDlg PIXEL  
		oGet:= MSGetDados():New(038,003,120,250,nOpcx,,,"")
		oGet:Refresh()
		@ 126,002 TO 127,250 LABEL "" OF oDlg PIXEL	
		ACTIVATE MSDIALOG oDlg CENTERED
	Else
		Aviso("Atencao","Este pedido nao possui controle de aprovacao.", {"Ok"}) 
	EndIf

	dbSelectArea(cAliasSCR)
	dbCloseArea()

Else
	Aviso("Atencao","Este Documento nao possui controle de aprovacao.", {"Ok"})
EndIf

dbSelectArea(cAlias)
RestArea(aArea)

Return 

**'-----------------------------------------------------------------------'**
**'--Tela de Legenda -----------------------------------------------------'**
**'-----------------------------------------------------------------------'**
User Function c19Legend()
**'-----------------------------------------------------------------------'**

BrwLegenda(cCadastro,"Legenda", { ; //Legenda
								{"BR_VERDE"		, "Totalmente aprovado"			},; 
								{"BR_AZUL" 		, "Em fase de aprovaçãos"		},; 
								{"BR_PRETO"		, "Cancelado"					},; 
								{"BR_VERMELHO"	, "Reprovado"		}}) 
							
Return(.T.)       

**'-----------------------------------------------------------'**
User Function c19PoRDA(c_Alias, n_Reg, n_Opc )                        
**'-----------------------------------------------------------
Local cAno
Local cMes
Local NomeRDA
Local oButton1
Local oButton2
Local oGroup1
Local oGroup2
Local oGroup3
Local oGroup4
Local oSay1
Local oSay2
Local oSay3           
Local nTotPg := 0.00
Local oTotPg

Local c_Fornece := " "
Local c_NomeFor := " " 
	
Private oFont2	:= TFont():New("Arial",,18,,.T.)

c_PerIni :=  MV_PAR01 + "/" + MV_PAR02
c_PerFin :=  MV_PAR03 + "/" + MV_PAR04


dbselectarea("BAU")
dbsetorder(1)
If dbseek(xFilial("BAU")+ m->PA0_RDA )
	
	c_Fornece := BAU->BAU_CODSA2
	c_NomeFor := BAU->BAU_NOME
	
EndIf

	u_cb19SE2Sal( c_Fornece )
//	u_cb19GSaldo(MV_PAR05, MV_PAR01 + MV_PAR02, MV_PAR03 +  MV_PAR04 ) 

If n_Opc != 3

	c_PerIni :=  substr(m->PA0_PERINI, 1,4) + "/" + substr(m->PA0_PERINI, 5,2)
	c_PerFin :=  substr(m->PA0_PERFIN, 1,4) + "/" + substr(m->PA0_PERFIN, 5,2)

Else


EndIf           

nTotPg := cb19TotPago( c_Fornece )   

Static oDlg

  DEFINE MSDIALOG oDlg TITLE "Resumo RDA: " + Alltrim( c_NomeFor ) FROM 000, 000  TO 350, 670 COLORS 0, 16777215 PIXEL

    @ 006, 003 GROUP oGroup1 TO 033, 328 OF oDlg COLOR 0, 16777215 PIXEL
    @ 017, 009 SAY oSay1 PROMPT "RDA: " SIZE 025, 007 FONT oFont2 OF oDlg COLORS 0, 16777215 PIXEL

    @ 017, 028 SAY NomeRDA PROMPT Alltrim( c_Fornece )  + " - " + Alltrim( c_NomeFor ) SIZE 292, 007 FONT oFont2 OF oDlg COLORS 6426895, 16777215 PIXEL

  //  @ 035, 003 GROUP oGroup2 TO 139, 328 PROMPT "Contas Médicas" OF oDlg COLOR 0, 16777215 PIXEL
  //  fWBrowse1()
  //  @ 051, 012 SAY oSay2 PROMPT "Ano/Mes inicial" SIZE 060, 007 OF oDlg COLORS 0, 16777215 PIXEL
  //  @ 051, 055 SAY cAno PROMPT c_PerIni SIZE 025, 020 OF oDlg COLORS 0, 16777215 PIXEL
  //  @ 051, 080 SAY oSay3 PROMPT "Ano/Mes final:" SIZE 060, 07 OF oDlg COLORS 0, 16777215 PIXEL
  //  @ 051, 120 SAY cMes PROMPT c_PerFin SIZE 025, 020 OF oDlg COLORS 0, 16777215 PIXEL

    @ 35, 003 GROUP oGroup3 TO 146, 328 PROMPT "Financeiro" OF oDlg COLOR 0, 16777215 PIXEL//142
    
    @ 50, 009 SAY oSay1 PROMPT "Pagamentos Antecipados do RDA não compensados" SIZE 088, 008 OF oDlg COLORS 0, 16777215 PIXEL

    fWBrowse2()                                                                                                  
    
    @ 131, 009 SAY oSay1 PROMPT "Total pago no período de um ano:" SIZE 088, 008 OF oDlg COLORS 0, 16777215 PIXEL//238
    @ 128, 097 MSGET oTotPg VAR nTotPg SIZE 073, 010 picture "@E 999,999,999,999.99" OF oDlg COLORS 0, 16777215 PIXEL//235
    
    @ 150, 003 GROUP oGroup4 TO 188, 328 OF oDlg COLOR 0, 16777215 PIXEL //257
    @ 159, 286 BUTTON oButton1 PROMPT "&Ok"       SIZE 037, 012 OF oDlg PIXEL ACTION oDlg:End() //266
//    @ 266, 240 BUTTON oButton2 PROMPT "&Imprimir" SIZE 037, 012 OF oDlg PIXEL ACTION u_CABR024( .F. ) 

  ACTIVATE MSDIALOG oDlg CENTERED

Return

**'-----------------------------------------------------------
Static Function fWBrowse1()                                   
**'-----------------------------------------------------------
//------------------------------------------------ 
Local oWBrowse1
    // Insert items here 

    @ 062, 012 LISTBOX oWBrowse1 Fields HEADER "Fase","Valor Digitado","Valor Pago","Valor Glosa","Valor Recuperado" SIZE 309, 070 OF oDlg PIXEL ColSizes 50,50
    oWBrowse1:SetArray(a_SaldoPls)
    oWBrowse1:bLine := {|| {;
      a_SaldoPls[oWBrowse1:nAt,1],;
      a_SaldoPls[oWBrowse1:nAt,2],;
      a_SaldoPls[oWBrowse1:nAt,3],;
      a_SaldoPls[oWBrowse1:nAt,4],;
      a_SaldoPls[oWBrowse1:nAt,5];
    }}
    // DoubleClick event
    oWBrowse1:bLDblClick := {|| a_SaldoPls[oWBrowse1:nAt,1] := !a_SaldoPls[oWBrowse1:nAt,1],;
      oWBrowse1:DrawSelect()}

Return

**'-----------------------------------------------------------                                                            '
Static Function fWBrowse2()                                   
**'-----------------------------------------------------------
//------------------------------------------------ 
Local oWBrowse2

    // Insert items here 

    @ 64, 013 LISTBOX oWBrowse2 Fields HEADER "Prefixo","Numero","Tipo","Emissao", "Valor","Saldo", "Mes/Ano Compensação" SIZE 309, 060 OF oDlg PIXEL ColSizes 50,50
    oWBrowse2:SetArray(a_VetSe2)
    oWBrowse2:bLine := {|| {;
      a_VetSe2[oWBrowse2:nAt,1],;
      a_VetSe2[oWBrowse2:nAt,2],;
      a_VetSe2[oWBrowse2:nAt,3],;
      a_VetSe2[oWBrowse2:nAt,4],;
      a_VetSe2[oWBrowse2:nAt,5],;
      a_VetSe2[oWBrowse2:nAt,6],;
      a_VetSe2[oWBrowse2:nAt,7];
    }} 
    
    // Aadd(a_VetSe2,{QRYSE2->E2_PREFIXO ,QRYSE2->E2_EMISSAO,QRYSE2->E2_VALOR ,  QRYSE2->E2_SALDO,  QRYSE2->MESANO })
    // DoubleClick event
    oWBrowse2:bLDblClick := {|| a_VetSe2[oWBrowse2:nAt,1] := !a_VetSe2[oWBrowse2:nAt,1],;
      oWBrowse2:DrawSelect()}

Return

**'-----------------------------------------------------------
Static Function VerSx1( c_Perg )                              
**'-----------------------------------------------------------

PutSx1( c_Perg ,"01","Ano Inicial           ","","","mv_ch1","C",04,0,0,"G","NaoVazio()                           ","      ","S","","mv_par01","        ","","","    ","           ","","","         ","","","","","","","","",{},{},{},"")
PutSx1( c_Perg ,"02","Mes Inicial           ","","","mv_ch2","C",02,0,0,"G","NaoVazio()                           ","      ","S","","mv_par02","        ","","","    ","           ","","","         ","","","","","","","","",{},{},{},"")
PutSx1( c_Perg ,"03","Ano Final             ","","","mv_ch3","C",04,0,0,"G","NaoVazio()                           ","      ","S","","mv_par03","        ","","","    ","           ","","","         ","","","","","","","","",{},{},{},"")
PutSx1( c_Perg ,"04","Mes Final             ","","","mv_ch4","C",02,0,0,"G","NaoVazio()                           ","      ","S","","mv_par04","        ","","","    ","           ","","","         ","","","","","","","","",{},{},{},"")
PutSx1( c_Perg ,"05","RDA                   ","","","mv_ch5","C",06,0,0,"G","                                     ","BAUPLS","S","","mv_par05","        ","","","    ","           ","","","         ","","","","","","","","",{},{},{},"")

Return

**'-----------------------------------------------------------
User Function cb19GSaldo(c_RDA, c_AnoMesIni, c_AnoMesFin)   
**'-----------------------------------------------------------

Local c_Qry 	:= ""
Local n_Ret 	:= 0                   
Local c_Status 	:= ""

a_SaldoPls := {} 

      
c_Qry:= " SELECT 	BD7F.BD7_FASE, ZZP_MESPAG BD6_mespag, ZZP_ANOPAG BD6_anopag, " 
c_Qry+= " 		Decode( 1, 1, b16_descri, 2, bag_descri) TipoPgto, "
c_Qry+= "		BD7_codrda bd6_codrda, BAU_NOME, ValorProt, valorpag, ValorGlo, VLRBSPAGTO Valordig "
c_Qry+= "FROM(	SELECT BD7.BD7_FASE, BD7.BD7_ANOPAG, BD7.BD7_MESPAG, BD7.BD7_CODRDA, Sum(BD7.BD7_VLRMAN) VLRBSPAGTO, Sum(BD7.BD7_VLRPAG) AS VALORPAG, Sum(BD7.BD7_VLRGLO) AS VALORGLO "
c_Qry+= "		FROM BD7010 BD7, BAU010 BAU "
c_Qry+= "		WHERE BD7.BD7_FILIAL = '" + xFilial("BD7") + "'  " 
c_Qry+= "		AND BD7.BD7_CODOPE = '0001' "
c_Qry+= "		AND BAU.BAU_FILIAL = '" + xFilial("BAU") + "'  " 
c_Qry+= "		AND BAU.BAU_CODIGO = BD7.BD7_CODRDA "
c_Qry+= "		AND BD7.BD7_ANOPAG||BD7.BD7_MESPAG  >= '" + c_AnoMesIni +  "' "
c_Qry+= "		AND BD7.BD7_ANOPAG||BD7.BD7_MESPAG  <= '" + c_AnoMesFin +  "' "
c_Qry+= "		AND BD7.BD7_SITUAC = Decode(Trim	(1),'4',BD7_SITUAC,Trim(1)) "
c_Qry+= "		AND BD7.BD7_BLOPAG <> '1' "
c_Qry+= "		AND BD7.BD7_CODRDA = '" + c_RDA + "' "
c_Qry+= "		AND BAU.D_E_L_E_T_ = ' ' "
c_Qry+= "		AND BD7.D_E_L_E_T_ = ' ' "
c_Qry+= "		GROUP BY BD7.BD7_FASE, BD7.BD7_ANOPAG, BD7.BD7_MESPAG, BD7_CODRDA "
c_Qry+= "	) BD7F, "
//c_Qry+= "	(SELECT zzp_filial, zzp_mespag, zzp_anopag, zzp_codrda, Sum(zzp_vlrtot) ValorProt " Comentado por Renato Peixoto em 06/08/12 para tratar novo campo ZZP
c_Qry+= "	(SELECT zzp_filial, zzp_mespag, zzp_anopag, zzp_codrda, SUM(ZZP_VLTGUI) ValorProt " //Alterado por Renato Peixoto em 06/08/12 para pegar o somatorio do novo campo totalizador do protocolo de remessa
//Fim Alteração Renato Peixoto.
c_Qry+= "	FROM ZZP010 ZZP "
c_Qry+= "	WHERE ZZP_FILIAL = '" + xFilial("ZZP") + "'  " 
c_Qry+= "	AND ZZP.D_E_L_E_T_ <> '*' "
c_Qry+= "	AND ZZP_ANOPAG||ZZP_MESPAG BETWEEN '" + c_AnoMesIni + "' AND '" + c_AnoMesFin + "'"
//c_Qry+= "	AND ZZP_ANOPAG BETWEEN '" + c_AnoIni + "' AND '" + c_AnoFin + "'"
c_Qry+= "	GROUP BY zzp_filial, zzp_mespag, zzp_anopag, zzp_codrda, zzp_nomrda "
c_Qry+= "	) B , " + RetSqlName("BAU")+ " BAU, " + RetSqlName("B16")+ " B16, " + RetSqlName("BAG")+ " BAG"
c_Qry+= " WHERE BD7F.BD7_codrda = b.zzp_codrda "
c_Qry+= " AND   BD7F.bd7_anopag = b.zzp_anopag "
c_Qry+= " AND   BD7F.bd7_mespag = b.zzp_mespag "
c_Qry+= " AND   BD7F.BD7_codrda = bau_codigo "
c_Qry+= " AND   BD7F.BD7_codrda = '" + c_RDA + "' "
c_Qry+= " AND   BD7F.valorpag > 0 "
c_Qry+= " AND   bau_grppag   = b16_codigo "
c_Qry+= " AND   bag_filial = '" + xFilial("BAG") + "'  " 
c_Qry+= " AND   bag_codigo = bau_tippre "
c_Qry+= " AND   BAU.D_E_L_E_T_ <> '*' "
c_Qry+= " AND   BAG.D_E_L_E_T_ <> '*' "
c_Qry+= " AND   B16.D_E_L_E_T_ <> '*' "
c_Qry+= " ORDER BY BD7F.BD7_FASE "          

memowrite("C:\qry_003.txt", c_Qry )
      
TcQuery c_Qry New Alias "QRYSAL"                                                                                      
      
If !QRYSAL->( EOF() )

	While !QRYSAL->( EOF() ) 
	            
	Do Case
		
		Case QRYSAL->BD7_FASE == '1'
						
			c_Status := "Digitacao"
		
		Case QRYSAL->BD7_FASE == '2'

			c_Status := "Conferencia"

		Case QRYSAL->BD7_FASE == '3'
		
			c_Status := "Pronta"
		
		Case QRYSAL->BD7_FASE == '4'
		
			c_Status := "Faturada"
	
	EndCase
	                                           			
		Aadd(a_SaldoPls,{c_Status,QRYSAL->Valordig ,  QRYSAL->valorpag,  QRYSAL->ValorGlo , 0 })
		
		n_Ret := QRYSAL->ValorProt
	
		QRYSAL->( dbSkip() )
		
	EndDo
Else 

	Aadd(a_SaldoPls,{' ',0,0,0,0 })
                               
EndIf	          

QRYSAL->( dbCloseArea() )           

Return n_Ret

**'-----------------------------------------------------------
User Function cb19SE2Sal( c_Fornece )                         
**'-----------------------------------------------------------

Local c_Qry := " "   

a_VetSe2:= {}                                                     	

c_Qry += " SELECT E2_NUM, E2_PREFIXO, E2_EMISSAO, E2_TIPO, E2_VALOR, E2_SALDO , E2_YMECPPA||'\'||E2_YANCPPA as MESANO"
c_Qry += " FROM " + RETSQLNAME("SE2") + " E2 "
c_Qry += " WHERE 	E2_FORNECE = '" + c_Fornece + "' "
c_Qry += " 			AND D_E_L_E_T_ <> '*' "
c_Qry += " 			AND (E2_TIPO = 'PA' OR E2_TIPO = 'NDF') "
c_Qry += " 			AND E2_SALDO > 0 "

c_Qry+= " ORDER BY E2_NUM "          

//memowrite("C:\qry_003_e2.txt", c_Qry )
      
TcQuery c_Qry New Alias "QRYSE2"                                                                                      

If !QRYSE2->( EOF() )

	While !QRYSE2->( EOF() )
	
		Aadd(a_VetSe2,{QRYSE2->E2_PREFIXO ,QRYSE2->E2_NUM , QRYSE2->E2_TIPO , DTOC(STOD( QRYSE2->E2_EMISSAO ) ), QRYSE2->E2_VALOR ,  QRYSE2->E2_SALDO,  QRYSE2->MESANO })
		
		
		QRYSE2->( dbSkip() )
		
	EndDo
Else 

	Aadd(a_VetSe2,{' ',' ',' ',' ',0,0,' ' })

EndIf	 

QRYSE2->( dbCloseArea() )                    
      
Return

**'-----------------------------------------------------------
	User Function cb19Estrona(c_Alias, n_Reg)                     
**'-----------------------------------------------------------

Private a_Buttons 	:= {}
Private a_DadosSE2 	:= {}
Private c_Assunto	:= "Cancelamento de Solicitação de Pagamento Antecipado"
Private a_Msg 		:= {}    
Private d_DtAtu		:= dDataBase   // Chamado GLPI 2751

aAdd( a_Buttons, { "BUDGET",{|| u_c19Posic("PA0", n_Reg, 3) }, "Visualisa aprovações", "Vis. Aprocação " } )       
aAdd( a_Buttons, { "RELATORIO",{|| u_c19PoRDA("PA0", n_Reg, 2) }, "Visualisa Status RDA", "Vis. RDA " } )

nOpca := AxVisual("PA0",PA0->(Recno()),2,,,,,a_Buttons,,,,,,,,,)                                                                       

dbSelectArea("PA3")
dbSetOrder(1)
If dbSeek( xFilial("PA3") + __cUserId )

	If  nOpca = 1 .and. PA0->PA0_STATUS = 'A' .AND. MsgYesNo("Confirma a exlusão da SPA já aprovada? O título financeiro gerado será excluso. ")
	
		dbSelectArea("SE2")
		dbSetOrder(1)                                    
		If dbSeek(XFILIAL('SE2') + 'SPA' + PA0->PA0_NUM + space(4)+ 'PA ' + PA0->PA0_FORNECE + '01' )
		     
			If !Empty( SE2->E2_BAIXA )
			     
				Aviso("CABERJ", "A SPA selecionada nao pode ser cancelada pois o título a ela relacionado já foi compensado. ", {"Ok"} )
			
			Else
			
				aadd(a_DadosSE2, {'E2_FILIAL'	, XFILIAL('SE2')	, NIL })
				aadd(a_DadosSE2, {'E2_PREFIXO'	, 'SPA'				, NIL })
				aadd(a_DadosSE2, {'E2_NUM'		, PA0->PA0_NUM + SPACE(3)   	, NIL })
				aadd(a_DadosSE2, {'E2_PARCELA'	, ' '				, NIL })
			  	aadd(a_DadosSE2, {'E2_YMECPPA' 	, ' '    			, NIL })
			  	aadd(a_DadosSE2, {'E2_YANCPPA' 	, ' '    			, NIL })
				aadd(a_DadosSE2, {'E2_TIPO'   	, 'PA '   			, .F. })
				aadd(a_DadosSE2, {'E2_FORNECE'	, PA0->PA0_FORNECE	, NIL })
				aadd(a_DadosSE2, {'E2_LOJA'   	, '01'    			, NIL })
				
				// QOut("Preparando exclusao"  + _cNUMSP)
				Begin Transaction
		
				dDataBase	:= SE2->E2_EMISSAO // Chamado GLPI 2751
				
				l_RetExc	:= .T.
				lMsErroAuto := .F.
				MSExecAuto({|x,y,z| Fina050(x,y,z)},a_DadosSE2,,5)
				
				IF lMsErroAuto
			
					DisarmTransaction()
					MostraErro()
					l_RetExc	:= .F.
			
				Else
			
					Reclock("PA0", .F.)
					
						PA0->PA0_DTCANC   	:= DATE()
						PA0->PA0_STATUS   	:= "C"
						
					MsUnlock() 
		
					Aviso("CABERJ", "SPA cancelada com sucesso." , {"Ok"})
				
				EndIF                 
				
				dDataBase	:= d_DtAtu// Chamado GLPI 2751
			
				END Transaction
				DbCommitAll()
					
			EndIf
		
		EndIf 
	
	ElseIf nOpca == 1 .and. Empty( PA0->PA0_STATUS )
	
		Reclock("PA0", .F.)
		
		PA0->PA0_DTCANC   	:= DATE()
		PA0->PA0_STATUS   	:= "C"
		
		MsUnlock()
        
		u_fAvisaSPA('3', PA0->PA0_NUM, __cUserId )

		u_fAltGrade({PA0->PA0_NUM,"PA"        ,PA0->PA0_VALOR,,,PA0->PA0_GRUPO,,,,dDataBase},dDataBase,3)// Bloqueia Grade
						
		Aviso("CABERJ", "SPA cancelada com sucesso." , {"Ok"})
		
	EndIf                    

Else
	
Aviso("CABERJ - Usuário não esta autorizado.", "Para incluir uma solicitação de pagamento antecipado, o seu usuário deve estar cadastrado como solicitante. ", {"Ok"})
	
EndIf
	
Return                     

**'-----------------------------------------------------------
Static Function cb19TotPago( c_Fornece )
**'-----------------------------------------------------------

Local c_Qry  := ""
Local n_Ret  := 0                        
Local c_Data := " "

c_Data := strzero(val( substr( dTOs( dDataBase ), 1, 4) ) - 1, 4) +  substr(dTOs( dDataBase ), 5, 4)      
      
c_Qry += " SELECT SUM( E2_VALOR) VALOR "
c_Qry += " FROM " + RETSQLNAME("SE2") + " "
c_Qry += " WHERE E2_FILIAL = '" + XFILIAL("SE2") + "' "
c_Qry += "       AND E2_FORNECE = '" + c_Fornece + "' "
c_Qry += " 		 AND D_E_L_E_T_ <> '*' "
c_Qry += " 		 AND E2_SALDO = 0.0 "
c_Qry += " 		 AND E2_TIPO = 'DP' "
c_Qry += " 		 AND E2_BAIXA <> ' ' "
c_Qry += " 		 AND E2_EMISSAO >= '" + c_Data + "' "
            
memowrite("C:\cb19TotPago.GER", c_Qry)

TcQuery c_Qry New Alias "QRYPAGO"

If !QRYPAGO->( EOF() )
	
	n_Ret := QRYPAGO->VALOR

EndIf          

QRYPAGO->( dbCloseArea() )

Return n_Ret

User Function c19VisTit()

dbSelectArea("SE2")
dbSetOrder(1)
IF dbSeek( xFilial("SE2") + "SPA" + PA0->PA0_NUM + SPACE(4) + "PA" )	

	nOpca := AxVisual("SE2",SE2->( Recno() ),2,,4,"",,)     

Else
	
	Alert("Título não encontrado. ")

EndIf

Return

Static Function fEscVetor( a_Vet )

Local i := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS
Local j := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

Local c_Vet := "{"      
//{c_Status,QRYSAL->Valordig ,  QRYSAL->valorpag,  QRYSAL->ValorGlo, 0 }

For i:= 1 to Len( a_Vet )

    c_Vet += "{"  
                         
	For j:= 1 to Len( a_Vet[i] )
	             
		If ValType(a_Vet[i][j]) == "N"
	
			c_vet += transform(a_Vet[i][j], "@E 999,999,999,999.99" ) 
		
		ElseIf ValType(a_Vet[i][j]) == "D"                            
		
			c_vet += dtoc(a_Vet[i][j] ) 
		
		//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS
		ElseIf ValType(a_Vet[i][j]) == "C"//ValType(a_Vet[i][j]) == "C"

			c_vet += a_Vet[i][j]
					
		EndIf
		    
	Next    
	
	c_Vet += "},"  
	
Next  

c_Vet := substr(c_Vet, 1, len(c_Vet) -1 )             

Return





*****************************************

**'--------------------------------------------------------------'**
User Function CABTMP(cAlias, nReg, nOpc )                                                                                                
**'--------------------------------------------------------------'**      
Local c_Assunto := "Aprovação de Pagamento Antecipado"
Local a_Msg 	:= {}

Private a_Buttons := {}
Private cCadastro 	:= "Solicitação de PA" // 
Private c_Perg 		:= "CABA016YXX" // 
Private c_Alias 	:= "QRYSAL"
Private c_AnoIni	:=	""
Private c_AnoFin	:=	""
Private c_MesIni	:=	""
Private c_MesFin	:=	""                                                   
Private c_RDA		:=	""

Private  c_Fornece  := " "
Private  c_NomeFor  := " "
Private  n_Valor  	:= 0
Private  n_VlPro  	:= 0
Private  n_Perc  	:= GetNewPar('MV_YPERCPA', 80)    
Private a_SaldoPls := {}
Private a_VetSe2:= {}

Public c_PA0Naturez
Public c_TipoCon := " "


//  	 u_fAltGrade({PA0->PA0_NUM,"PA"        ,PA0->PA0_VALOR,,,PA0->PA0_GRUPO,,,,dDataBase},dDataBase,3)// Bloqueia Grade
//     u_fAltGrade({PA0->PA0_NUM,"PA",       PA0->PA0_VALOR,,,PA0->PA0_GRUPO,,1,,dDataBase},dDataBase,1)// Cria grade
		
	u_016WFApro( a_SaldoPls,  a_VetSe2 , PA0->PA0_NUM,  PA0->PA0_GRUPO )   // reenvio de wf
	
//	u_fAvisaSPA('1', PA0->PA0_NUM, " ", .F. , " ")


Return                                                              


Static Function ValidNiv( c_Num, c_Nivel)   
	
	Local l_Ret := .T.
      

	_cQuery := " SELECT CR_FILIAL, CR_TIPO, CR_NUM, CR_NIVEL FROM " + RetSQLName("SCR")
	_cQuery += " WHERE CR_FILIAL = '" + xFilial("SCR") + "'"
	_cQuery += " AND CR_NUM = '" + c_Num + "'"
	_cQuery += " AND CR_TIPO = 'PA'"
	_cQuery += " AND CR_STATUS not in ( '03', '05') "   
	_cQuery += " AND CR_NIVEL < '" + c_Nivel + "' "   
	_cQuery += " AND D_E_L_E_T_ = ' '"
	
	TcQuery _cQuery New Alias "QRYEST"    
	
	If !QRYEST->( EOF() )
	     
		l_Ret := .F.
	
	EndIf       
	
	QRYEST->( dbCloseArea()  )

Return l_Ret
