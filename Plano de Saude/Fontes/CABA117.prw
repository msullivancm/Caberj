#Include "PROTHEUS.CH"
#INCLUDE "rwmake.ch"
#INCLUDE "topconn.ch"

/*------------------------------------------------------------------------
| Funcao    | CABA117  | Otavio Pinto                  | Data | 28/01/13  |
+-------------------------------------------------------------------------+
| Descricao | Protocolo de Atendimento                                    |
+-------------------------------------------------------------------------+
| Uso       | Protocolo de Atendimentos                                   |
+-------------------------------------------------------------------------+
| Alterado  |                                          | Data |   /  /    |
|           |                                                             |
+-------------------------------------------------------------------------+
| Alterado  |                                          | Data |   /  /    |
|           |                                                             |
|           |                                                             |
+------------------------------------------------------------------------*/
user function CABA117(cMattel , cNomUtel , dDtNasc , dDtInc , cDescpl , cEmail , cuser)
	
	private aRotina 		:= {}
	private cCadastro   	:= "Protocolo de Atendimento"
	private cAlias1 		:= "SZX"                    // Alias da Enchoice.
	private cAlias2 		:= "SZY"                    // Alias da GetDados.
	private xnOpc   		:= "1"
	
	private nFim    		:= 2
	PRIVATE  I      		:= 0
	private cQuery  		:= ' '
	private cAgente 		:= '1102'
	private cUsua   		:= substr(cUsuario, 7, 6 )     
	
	private cMattelb := ''         
    private cNomUtelb:= ''
    private dDtNascb := '' 
    private dDtIncb  := ''
    private cDescplb := ''
    private cEmailb  := ''
	
	private aCdCores  	:= {	{ 'BR_AMARELO'   	,'Pendente' 		},;
		{ 'BR_VERMELHO'  	,'Encerrado'		},;
		{ 'BR_VERDE'   	,'Em Andamento'	}} //Angelo Henrique - Data: 05/10/2016 - Chamado: 28286
					
	private aCores      	:= { { 'ZX_TPINTEL = "1" .And. !(U_CAB69LE1())',aCdCores[1,1] },;
		{ 'ZX_TPINTEL = "2"',aCdCores[2,1] },;
		{ 'U_CAB69LE1()'	,aCdCores[3,1] }	} //Angelo Henrique - Data: 05/10/2016 - Chamado: 28286
		//{ 'ZX_TPINTEL = "2"'	,aCdCores[3,1] }	} //Angelo Henrique - Data: 05/10/2016 - Chamado: 28286
	
	//--------------------------------------------------------------
	// INICIO Angelo Henrique - Criação de Filtro no Protocolo
	//--------------------------------------------------------------
	//Chamado 28286
	//--------------------------------------------------------------
	Private _aIndex 		:= {}
	Private _cFiltro 		:= "ZX_USDIGIT = '" + cuser + "' .AND. ZX_TPINTEL = '1' " //Expressao do Filtro         
//	Private _cFiltro 		:= "ZX_USDIGIT = '" + ALLTRIM(UsrRetName(__cUserId)) + "' .AND. ZX_TPINTEL = '1' " //Expressao do Filtro
	Private _bFiltBrw 	:= { || FilBrowse( "SZX" , @_aIndex , @_cFiltro ) } //Determina a Expressao do Filtro
	Private _lFilt 		:= .F.
	
	//--------------------------------------------------------------
	// FIM Angelo Henrique - Criação de Filtro no Protocolo
	//--------------------------------------------------------------
	
	AAdd(aRotina, {"Pesquisar" , "AxPesqui"  , 0, 1})
	AAdd(aRotina, {"Visualizar", "u_PA_Manu1", 0, 2})
	AAdd(aRotina, {"Incluir"   , "u_PA_Manu1", 0, 3})
	AAdd(aRotina, {"Alterar"   , "u_PA_Manu1", 0, 4})
	AAdd(aRotina, {"Excluir"   , "u_PA_Manu1", 0, 5})
	AAdd(aRotina, {"Legenda"   , "u_PAIMPLE1", 0, 6})
	
	dbSelectArea(cAlias1)
	dbOrderNickName("SEQ")
	dbGoTop()
	
	/*
	while nFim != 1
		
		sleep(10000)
		
		cQuery :=" select nvl(chamada2.uniqueid,999) chamar  qtda from  chamada1 , chamada2 where chamada1.uniqueid = chamada2.uniqueid(+) "
		cQuery +="    and chamada1.accountcode = "+cagente+" "
		
		TCQuery cQuery Alias "TMP1" New
		dbSelectArea("TMP1")
		TMP1->( dbGoTop() )
		If TMP->chamar == 999
			u_PA_Manut(cAlias1, 1, 3)
		EndIf
	Enddo
	*/    
	
	  if !empty(cMattel)
      cMattelb := cMattel         
      cNomUtelb:= cNomUtel
      dDtNascb := dDtNasc 
      dDtIncb  := dDtInc
      cDescplb := cDescpl
      cEmailb  := cEmail      
  Else 
      cMattelb := ''         
      cNomUtelb:= ''
      dDtNascb := '' 
      dDtIncb  := ''
      cDescplb := ''
      cEmailb  := ''    
  EndIf    
	
	//--------------------------------------------------------------------------------------
	// INICIO Angelo Henrique - Criação de Filtro no Protocolo
	//--------------------------------------------------------------------------------------
	//Chamado 28286
	//--------------------------------------------------------------------------------------
	If MSGYESNO("Deseja executar o filtro para as suas PA's pendentes? ","Atenção")
		
		Eval( _bFiltBrw ) //Efetiva o Filtro antes da Chamada a mBrowse
		_lFilt := .T.
		
	EndIf
	//--------------------------------------------------------------------------------------
	// FIM Angelo Henrique - Criação de Filtro no Protocolo
	//--------------------------------------------------------------------------------------
	
	mBrowse(,,,,cAlias1, , , , , Nil    , aCores)
	
	If _lFilt
		
	EndFilBrw( "SZX" , @_aIndex ) //Finaliza o Filtro
	
EndIf

Return Nil

//----------------------------------------------------------------------------------------------------------------//
// Modelo 3.
//----------------------------------------------------------------------------------------------------------------//
user function PA_Manu1(cAlias, nReg, nOpc)
	local i        := 0
	local cLinOK   := "AllwaysTrue"
	local cTudoOK  := "u_PA_TdOK1"
	local nOpcE    := nOpc
	local nOpcG    := nOpc
	local cFieldOK := "AllwaysTrue"
	local lVirtual := .T.
	local nLinhas  := 99
	local nFreeze  := 0
	local lRet     := .T.
	local nSizeHd  := 190 // Altura da area para os campos de header
		
	local aObjects  := {}
	local aPosObj   := {}
	local aSizeAut  := MsAdvSize()
	local nOpcA     := 0
	
	
	private aGETS   := {}
	private aTELA   := {}
	
	private aCols        := {}
	private aHeader      := {}
	private aCpoEnchoice := {}
	private aAltEnchoice := {}
	private aAlt         := {}
	private oGetDad		 := Nil //Angelo Henrique - Data: 31/10/2016
	private oDlg		 := Nil //Angelo Henrique - Data: 31/10/2016
	
	// Cria variaveis de memoria dos campos da tabela Pai.
	// 1o. parametro: Alias do arquivo --> é case-sensitive, ou seja precisa ser como está no Dic.Dados.
	// 2o. parametro: .T.              --> cria variaveis em branco, preenchendo com o inicializador-padrao.
	//                .F.              --> preenche com o conteudo dos campos.
	RegToMemory(cAlias1, (nOpc==3))
	
	// Cria variaveis de memoria dos campos da tabela Filho.
	RegToMemory(cAlias2, (nOpc==3))
	
	CriaHeader(nOpc)
	
	CriaCols(nOpc)
	xnOpc   := nOpc
	aObjects := {}
	AAdd( aObjects, { 315,  50, .T., .T. } )
	AAdd( aObjects, { 100, 25, .T., .T. } )
	
	aInfo := { aSizeAut[ 1 ], aSizeAut[ 2 ], aSizeAut[ 3 ], aSizeAut[ 4 ], 3, 3 }
	aPosObj := MsObjSize( aInfo, aObjects, .T. )
	
	DEFINE MSDIALOG oDlg TITLE cCadastro From aSizeAut[7],00 To aSizeAut[6],aSizeAut[5] OF oMainWnd PIXEL
	EnChoice( cAlias,nReg, nOpc, , , , , aPosObj[1], , 3 )
	oGetDad := MSGetDados():New (aPosObj[2,1], aPosObj[2,2], aPosObj[2,3], aPosObj[2,4], nOpc, "U_PA_TdOK1" ,"AllwaysTrue","", (nopc = 3 .or. nopc = 4))
	
	
	/// altamiro -- 02/09/14 -- estaleiro
	
	if !empty(SZX->(ZX_CODINT+ZX_CODEMP+ZX_MATRIC+ZX_TIPREG))
		U_VeSitAdv(SZX->(ZX_CODINT+ZX_CODEMP+ZX_MATRIC+ZX_TIPREG))
	EndIf    
	
	IF !EMPTY(cMattelb)  
       M->ZX_USUARIO := cMattelb         
       M->ZX_NOMUSR  := cNomUtelb
      // M->ZX_YDTNASC := dDtNascb  
      // M->ZX_YDTINC  := dDtIncb 
       M->ZX_YPLANO  := cDescplb 
       M->ZX_EMAIL   := cEmailb   
    EndIf     
	
	///// fim
	
	//ACTIVATE MSDIALOG oDlg ON INIT EnchoiceBar(oDlg,{ || IIF( OBRIGATORIO(AGETS,ATELA) .And. TudoOk() .and. ValidBA(), (nOpca := 1, oDlg:END()), nOpca := 0) }, { || oDlg:END() })  // em 08.08.2012 - OSP
	ACTIVATE MSDIALOG oDlg ON INIT EnchoiceBar(oDlg,{ || IIF( OBRIGATORIO(AGETS,ATELA) .And. TudoOk() , (nOpca := 1, oDlg:END()), nOpca := 0) }, { || oDlg:END() })
	
	If nOpca == 1
		If      nOpc == 3
			If MsgYesNo("Confirma a gravação dos dados?", cCadastro)
				Processa({||GrvDados()}, cCadastro, "Gravando os dados, aguarde...")
			EndIf
		ElseIf nOpc == 4
			IF szx->ZX_TPINTEL == "2"
				Alert("Protocolo de Atendimento encerrado... Nao pode ser Alterado!", cCadastro)
			ELSE
				If MsgYesNo("Confirma a alteração dos dados?", cCadastro)
					Processa({||AltDados()}, cCadastro, "Alterando os dados, aguarde...")
				EndIf
			Endif
		ElseIf nOpc == 5
			IF szx->ZX_TPINTEL == "2"
				Alert("Protocolo de Atendimento encerrado... Nao pode ser Excluido!", cCadastro) // EM 15.01.2013 - OSP
			Else
				If MsgYesNo("Confirma a exclusão dos dados?", cCadastro)
					Processa({||ExcDados()}, cCadastro, "Excluindo os dados, aguarde...")
				EndIf
			Endif
		EndIf
	Else
		RollBackSX8()
	EndIf
	
Return Nil

/*------------------------------------------------------------------------
| Funcao    | CriaHeader | Otavio Pinto                | Data | 28/01/13  |
+-------------------------------------------------------------------------+
| Descricao | CriaHeader                                                  |
+-------------------------------------------------------------------------+
| Uso       | Protocolo de Atendimentos                                   |
+-------------------------------------------------------------------------+
| Alterado  |                                          | Data |   /  /    |
|           |                                                             |
|           |                                                             |
+------------------------------------------------------------------------*/
static function CriaHeader(nOpc)
	
	aHeader      := {}
	aCpoEnchoice := {}
	aAltEnchoice := {}
	
	// aHeader é igual ao do Modelo2.
	
	dbSelectArea("SX3")
	dbSetOrder(1)
	dbSeek(cAlias2)
	
	While !SX3->( EOF()) .And. SX3->X3_Arquivo == cAlias2
		If X3Uso(SX3->X3_Usado)    .And.;                  // O Campo é usado.
			cNivel >= SX3->X3_Nivel ;//.And.;                  // Nivel do Usuario é maior que o Nivel do Campo.
			//Trim(SX3->X3_Campo) $ "ZY_SEQBA/ZY_SEQSERV/ZY_DTSERV/ZY_HORASV/ZY_TIPOSV/ZY_SERV/ZY_OBS/ZY_YCUSTO/ZY_USDIGIT" // Incluido ZY_YCUSTO em 15.05.2014-OSP
			AAdd(aHeader, {Trim(SX3->X3_Titulo),;
				SX3->X3_Campo       ,;
				SX3->X3_Picture     ,;
				SX3->X3_Tamanho     ,;
				SX3->X3_Decimal     ,;
				SX3->X3_Valid       ,;
				SX3->X3_Usado       ,;
				SX3->X3_Tipo        ,;
				SX3->X3_Arquivo     ,;
				SX3->X3_Context}    )
			
		EndIf
		
		
		SX3->(dbSkip())
	End
	
	// Campos da Enchoice.
	
	dbSelectArea("SX3")
	dbSetOrder(1)
	dbSeek(cAlias1)
	
	While !SX3->( EOF()) .And. SX3->X3_Arquivo == cAlias1
		If X3Uso(SX3->X3_Usado)    .And.;                  // O Campo é usado.
			cNivel >= SX3->X3_Nivel                         // Nivel do Usuario é maior que o Nivel do Campo.
			
			// Campos da Enchoice.
			AAdd(aCpoEnchoice, X3_Campo)
			
			// Campos da Enchoice que podem ser editadas.
			// Se tiver algum campo que nao deve ser editado, nao incluir aqui.
			AAdd(aAltEnchoice, X3_Campo)
		EndIf
		SX3->( dbSkip() )
	End
	
	If nOpc == 3
		M->ZX_SEQ := GetSx8Num("SZX","ZX_SEQ")
		ConfirmSx8()
	Endif
	
Return Nil

/*------------------------------------------------------------------------
| Funcao    | CriaCols  | Otavio Pinto                 | Data | 28/01/13  |
+-------------------------------------------------------------------------+
| Descricao | Cria aCols                                                  |
+-------------------------------------------------------------------------+
| Uso       | Protocolo de Atendimentos                                   |
+-------------------------------------------------------------------------+
| Alterado  |                                          | Data |   /  /    |
|           |                                                             |
|           |                                                             |
+------------------------------------------------------------------------*/
static function CriaCols(nOpc)
	
	local nQtdCpo := 0
	local i       := 0
	local nCols   := 0
	
	nQtdCpo := Len(aHeader)
	aCols   := {}
	aAlt    := {}
	
	If nOpc == 3       // Inclusao.
		
		AAdd(aCols, Array(nQtdCpo+1))
		
		For i := 1 To nQtdCpo
			aCols[1][i] := CriaVar(aHeader[i][2])
		Next
		
		aCols[1][nQtdCpo+1] := .F.
		
	Else
		
		dbSelectArea(cAlias2)
		dbOrderNickName("SEQBA")  // ZY_FILIAL+ZY_SEQBA
		dbSeek(xFilial(cAlias2) + (cAlias1)->ZX_SEQ)
		
		While  !EOF() .And. (cAlias2)->ZY_Filial == xFilial(cAlias2) .And. (cAlias2)->ZY_SEQBA == (cAlias1)->ZX_SEQ
			
			AAdd(aCols, Array(nQtdCpo+1))
			nCols++
			
			For i := 1 To nQtdCpo
				If aHeader[i][10] <> "V"
					aCols[nCols][i] := FieldGet(FieldPos(aHeader[i][2]))
				Else
					aCols[nCols][i] := CriaVar(aHeader[i][2], .T.)
				EndIf
			Next
			aCols[nCols][nQtdCpo+1] := .F.
			AAdd(aAlt, Recno())
			dbSelectArea(cAlias2)
			dbSkip()
		End
		
	EndIf
	
Return Nil

/*------------------------------------------------------------------------
| Funcao    | GrvDados  | Otavio Pinto                 | Data | 28/01/13  |
+-------------------------------------------------------------------------+
| Descricao | GrvDados                                                    |
+-------------------------------------------------------------------------+
| Uso       | Protocolo de Atendimentos                                   |
+-------------------------------------------------------------------------+
| Alterado  |                                          | Data |   /  /    |
|           |                                                             |
|           |                                                             |
+------------------------------------------------------------------------*/
static function GrvDados()
	local bCampo := {|nField| Field(nField)}
	local i      := 0
	local y      := 0
	local nItem  := 1//0
	
	ProcRegua(Len(aCols) + FCount())
	
	//+--------------------------------------------------------------------------------------------------------+
	//|Conforme Chamado 2563, uma das solicitacoes pede para nao permitir gravar com o Tipo de Servicos VAZIO. |
	//|por OSP em 18.06.2012 16:21                                                                             |
	//|                                                                                                        |
	//|Em 23.05.2014 a usuária Danielle pediu que verificasse o problema da falta do campo "Codigo de Serviço" |
	//|pois o mesmo daso nao digitado, exibia a mensagem e ao sair, perdia toda digitação.                     |
	//|                                                                                                        |
	//|                                                                                                        |
	//+--------------------------------------------------------------------------------------------------------+
	
	begin sequence
		
		For i := 1 To len(aCols)
			if empty( aCols[i][5] )
				MsgInfo("O campo TIPO SERVICO nao esta preenchido... Verifique !!!", cCadastro + " nao gravado")
				// Com a retirada do "Break", a rotina grava sem o código do Serviço, sem perda dos dados, porem
				// alestando pela falta do mesmo. Em 23.05.2014 por OSP
				
				/* break     */
			endif
		next
		
		// Grava o registro da tabela Pai, obtendo o valor de cada campo
		// a partir da var. de memoria correspondente.
		
		dbSelectArea(cAlias1)
		RecLock(cAlias1, .T.)
		For i := 1 To FCount()
			IncProc()
			//+--------------------------------------------------------------------------------------------------------+
			//|Alterei a rotina para forcar a gravacao da Data e Hora de saida do sistema (ZX_DATATE e ZX_HORATE)      |
			//|por OSP em 08.08.2012 11:46                                                                             |
			//+--------------------------------------------------------------------------------------------------------+
			do case
			case "FILIAL"  $ FieldName(i) ; FieldPut(i, xFilial(cAlias1))
			case "DATATE"  $ FieldName(i)
				if M->ZX_TPINTEL == "2"
					FieldPut(i, DATE() )
				endif
			case "HORATE"  $ FieldName(i)
				if M->ZX_TPINTEL == "2"
					FieldPut(i, SUBSTR(TIME(),1,2)+SUBSTR(TIME(),4,2) )
				endif
			case "YCUSTO"  $ FieldName(i) ; FieldPut(i, u_PegCC( AllTrim (cUserName), 1 ) )
				//case "YAGENC"  $ FieldName(i) ; FieldPut(i, u_PegaCC( AllTrim (cUserName), 2 ) ) -- Angelo Henrique - Data: 07/06/2016
			case "TPINTEL" $ FieldName(i) ; FieldPut(i, M->&(Eval(bCampo,i)))                   
			
//			case "YDTNASC" $ FieldName(i) ; FieldPut(i, substr(dDtNascb,7,4)+substr(dDtNascb,4,2)+substr(dDtNascb,1,2) ,i) 
			
//			case "YDTINC"  $ FieldName(i) ; FieldPut(i, substr(dDtIncb,7,4)+substr(dDtIncb,4,2)+substr(dDtIncb,1,2) ,i)
				
			otherwise
				FieldPut(i, M->&(Eval(bCampo,i)))
			end case
			
			// Esta era a rotina original - OSP
			*If "FILIAL" $ FieldName(i)
			*   FieldPut(i, xFilial(cAlias1))
			*Else
			*   FieldPut(i, M->&(Eval(bCampo,i)))
			*EndIf
		Next            
  /*    M->ZX_YDTNASC := dDtNascb  
        M->ZX_YDTINC  := dDtIncb 
		M->ZX_YDTNASC := substr(dDtNascb,7,4)+substr(dDtNascb,4,2)+substr(dDtNascb,1,2)  
        M->ZX_YDTINC  := substr(dDtIncb,7,4)+substr(dDtIncb,4,2)+substr(dDtIncb,1,2) 
  */
		MSUnlock()
		
		// Grava os registros da tabela Filho.
		
		dbSelectArea(cAlias2)
		dbOrderNickName("SEQBA")
		
		For i := 1 To Len(aCols)
			
			IncProc()
			
			If !aCols[i][Len(aHeader)+1]       // A linha nao esta deletada, logo, pode gravar.
				
				RecLock(cAlias2, .T.)
				
				For y := 1 To Len(aHeader)
					FieldPut(FieldPos(Trim(aHeader[y][2])), aCols[i][y])
				Next
				
				SZY->ZY_Filial := xFilial("SZY")
				SZY->ZY_SEQBA   := SZX->ZX_SEQ
				SZY->ZY_SEQSERV := StrZero(nItem, 6, 0)
				nItem++
				//SZY->ZY_SEQSERV := GetSx8Num("SZY","ZY_SEQSERV")
				//ConfirmSx8()
				
				MSUnlock()
				
			EndIf
			
		Next
		
	end sequence
	
Return Nil

/*------------------------------------------------------------------------
| Funcao    | AltDados  | Otavio Pinto                 | Data | 28/01/13  |
+-------------------------------------------------------------------------+
| Descricao | AltDados                                                    |
+-------------------------------------------------------------------------+
| Uso       | Protocolo de Atendimentos                                   |
+-------------------------------------------------------------------------+
| Alterado  |                                          | Data |   /  /    |
|           |                                                             |
|           |                                                             |
+------------------------------------------------------------------------*/
static function AltDados()
	local bCampo := {|nField| Field(nField)}
	Local i      := 0
	Local y      := 0
	Local nItem  := 0
	
	ProcRegua(Len(aCols) + FCount())
	
	//+--------------------------------------------------------------------------------------------------------+
	//|Conforme Chamado 2563, uma das solicitacoes pede para nao permitir gravar com o Tipo de Servicos VAZIO. |
	//|por OSP em 18.06.2012 16:21                                                                             |
	//|                                                                                                        |
	//|Em 23.05.2014 a usuária Danielle pediu que verificasse o problema da falta do campo "Codigo de Serviço" |
	//|pois o mesmo daso nao digitado, exibia a mensagem e ao sair, perdia toda digitação.                     |
	//|                                                                                                        |
	//|                                                                                                        |
	//+--------------------------------------------------------------------------------------------------------+
	
	begin sequence
		
		For i := 1 To len(aCols)
			if empty( aCols[i][5] )
				MsgInfo("O campo TIPO SERVICO nao esta preenchido... Verifique !!!", cCadastro + " nao gravado")
				// Com a retirada do "Break", a rotina grava sem o código do Serviço, sem perda dos dados, porem
				// alestando pela falta do mesmo. Em 23.05.2014 por OSP
				
				/* break     */
			endif
		next
		
		dbSelectArea(cAlias1)
		RecLock(cAlias1, .F.)
		
		For i := 1 To FCount()
			IncProc()
			do case
			case "FILIAL"  $ FieldName(i) ; FieldPut(i, xFilial(cAlias1))
			case "DATATE"  $ FieldName(i)
				if M->ZX_TPINTEL == "2"
					FieldPut(i, DATE() )
				endif
			case "HORATE"  $ FieldName(i)
				if M->ZX_TPINTEL == "2"
					FieldPut(i, SUBSTR(TIME(),1,2)+SUBSTR(TIME(),4,2) )
				endif
			otherwise
				FieldPut(i, M->&(Eval(bCampo,i)))
			end case
			
			*    If "FILIAL" $ FieldName(i)
			*       FieldPut(i, xFilial(cAlias1))
			*     Else
			*       FieldPut(i, M->&(fieldname(i)))
			*    EndIf
		Next
		MSUnlock()
		
		dbSelectArea(cAlias2)
		dbOrderNickName("SEQBA")
		
		nItem := Len(aAlt) + 1
		
		For i := 1 To Len(aCols)
			If i <= Len(aAlt)
				dbGoTo(aAlt[i])
				RecLock(cAlias2, .F.)
				If aCols[i][Len(aHeader)+1]
					dbDelete()
				Else
					For y := 1 To Len(aHeader)
						FieldPut(FieldPos(Trim(aHeader[y][2])), aCols[i][y])
					Next
				EndIf
				MSUnlock()
			Else
				If !aCols[i][Len(aHeader)+1]
					RecLock(cAlias2, .T.)
					For y := 1 To Len(aHeader)
						FieldPut(FieldPos(Trim(aHeader[y][2])), aCols[i][y])
					Next
					(cAlias2)->ZY_Filial  := xFilial(cAlias2)
					(cAlias2)->ZY_SEQBA   := (cAlias1)->ZX_SEQ
					(cAlias2)->ZY_SEQSERV := StrZero(nItem, 6, 0)
					MSUnlock()
					nItem++
				EndIf
			EndIf
		Next
		
	end sequence
	
Return Nil

/*------------------------------------------------------------------------
| Funcao    | ExcDados  | Otavio Pinto                 | Data | 28/01/13  |
+-------------------------------------------------------------------------+
| Descricao | ExcDados                                                    |
+-------------------------------------------------------------------------+
| Uso       | Protocolo de Atendimentos                                   |
+-------------------------------------------------------------------------+
| Alterado  |                                          | Data |   /  /    |
|           |                                                             |
|           |                                                             |
+------------------------------------------------------------------------*/
static function ExcDados()
	
	ProcRegua(Len(aCols)+1)   // +1 é por causa da exclusao do arq. de cabeçalho.
	
	dbSelectArea(cAlias2)
	dbOrderNickName("SEQBA")
	dbSeek(xFilial(cAlias2) + (cAlias1)->ZX_SEQ)
	
	While !EOF() .And. (cAlias2)->ZY_Filial == xFilial(cAlias2) .And. (cAlias2)->ZY_SEQBA == (cAlias1)->ZX_SEQ
		IncProc()
		RecLock(cAlias2, .F.)
		dbDelete()
		MSUnlock()
		dbSkip()
	End
	
	dbSelectArea(cAlias1)
	dbOrderNickName("SEQ")
	IncProc()
	RecLock(cAlias1, .F.)
	dbDelete()
	MSUnlock()
	
Return Nil

/*------------------------------------------------------------------------
| Funcao    | PA_TudOK  | Otavio Pinto                 | Data | 28/01/13  |
+-------------------------------------------------------------------------+
| Descricao | PA_TudOK                                                    |
+-------------------------------------------------------------------------+
| Uso       | Protocolo de Atendimentos                                   |
+-------------------------------------------------------------------------+
| Alterado  |                                          | Data |   /  /    |
|           |                                                             |
|           |                                                             |
+------------------------------------------------------------------------*/
user function PA_TdOK1()
	
	local lRet := .T.
	local i    := 0
	local nDel := 0
	
	For i := 1 To Len(aCols)
		If aCols[i][Len(aHeader)+1]
			nDel++
		EndIf
	Next
	
	If nDel == Len(aCols)
		MsgInfo("Para excluir todos os itens, utilize a opção EXCLUIR", cCadastro)
		lRet := .F.
	EndIf
	
Return lRet

/*------------------------------------------------------------------------
| Funcao    | ValidBA   | Otavio Pinto                 | Data | 28/01/13  |
+-------------------------------------------------------------------------+
| Descricao | ValidBA                                                     |
+-------------------------------------------------------------------------+
| Uso       | Protocolo de Atendimentos                                   |
+-------------------------------------------------------------------------+
| Alterado  |                                          | Data |   /  /    |
|           |                                                             |
|           |                                                             |
+------------------------------------------------------------------------*/
static function ValidBA()
	local lRet := .T.
	
	If (M->ZX_DATDE < M->ZX_DATATE)
		lRet := .T.
	Else
		If (M->ZX_DATDE = M->ZX_DATATE)
			If (M->ZX_HORADE <= M->ZX_HORATE)
				lRet := .T.
			Else
				lRet := .F.
			Endif
		Else
			lRet := .F.
		Endif
	Endif
	
	If !lRet
		MsgAlert("Data/Hora De posterior a Data/Hora Ate !!")
	Endif
	
Return lRet

/*------------------------------------------------------------------------
| Funcao    | PAIMPLEG  | Otavio Pinto                 | Data | 28/01/13  |
+-------------------------------------------------------------------------+
| Descricao | PAIMPLEG                                                    |
+-------------------------------------------------------------------------+
| Uso       | Protocolo de Atendimentos                                   |
+-------------------------------------------------------------------------+
| Alterado  |                                          | Data |   /  /    |
|           |                                                             |
|           |                                                             |
+------------------------------------------------------------------------*/
user function PAIMPLE1
	local aLegenda
	aLegenda := {	{ aCdCores[1,1],aCdCores[1,2] },;
		{ aCdCores[2,1],aCdCores[2,2] },;
		{ aCdCores[3,1],aCdCores[3,2] }} //Angelo Henrique - Chamado 28286 - Status Em Andamento
	
	BrwLegenda(cCadastro,"Status" ,aLegenda)
	
Return



/*
Funcao: PegaCC
Data: 20.08.2012
Objetivo: Retornar Centro de Custo e Descricao, a partir do nome do usuario (login)
para preenchimento dos campo ZX_YCUSTO e ZX_YAGENC. Estes campos estao sendo
utilizados no Relatorio de BA (Crystal)- RESBAS.RPT
Author: Otavio Salvador Pinto
Parametros: <_cUsuario> Deve ser informado o login do usuario - Utilizar o cUserName que
retorna o login corrente.
<_nRet> Se 1, retorna o Centro de Custo, do contrario retorna a Descricao
*/
user function PegCC( _cUsuario, _nRet )
	local aArea := GetArea()               
	local cAliastmp    := GetNextAlias()
	local cRet :=  cMat := cCC := " "
	_nRet := if( _nRet == Nil, 1, _nRet )
	if !Empty( _cUsuario )
		PswOrder(2)
		if PswSeek( _cUsuario, .T. )
			cMat := substr(PSWRet(1)[1][22],3,8)
			
			cQry := "SELECT RA_CC FROM SRA010 WHERE D_E_L_E_T_ = ' ' AND RA_FILIAL||RA_MAT = '"+cMat+"'"
		 //	TCQuery cQry Alias (cAliastmp) New     
			TCQuery cQry  New Alias (cAliastmp)   
			dbSelectArea(cAliastmp)
			(cAliastmp)->( dbGoTop() )
			cCC := (cAliastmp)->RA_CC
			(cAliastmp)->( dbCloseArea() )
			
			cQry := " SELECT CTT_DESC01 FROM CTT010 WHERE D_E_L_E_T_ = ' ' AND CTT_FILIAL = '01' AND CTT_CUSTO = '"+cCC+"'"
			TCQuery cQry Alias (cAliastmp) New
			dbSelectArea((cAliastmp))
			(cAliastmp)->( dbGoTop() )
			cCCDesc := (cAliastmp)->CTT_DESC01
			(cAliastmp)->( dbCloseArea() )
			
			cRet := if ( _nRet == 1, cCC, cCCDesc )
			
		endif
	endif
	RestArea(aArea)
	
return (cRet)


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CAB69LEG  ºAutor  ³Angelo Henrique     º Data ³  06/10/16   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Função responsável pela validação das legendas de em        º±±
±±º          ³andamento no protocolo de atendimento                       º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CABERJ                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function CAB69LE1()
	
	Local _aArea 	:= GetArea()
	Local _aArZX 	:= SZX->(GetArea())
	Local _aArZY 	:= SZY->(GetArea())
	Local _lRet	:= .F.
	
	If SZX->ZX_TPINTEL = "1"
		
		DbSelectArea("SZY")
		DbSetOrder(1)
		If DbSeek(xFilial("SZY") + SZX->ZX_SEQ)
			
			While !EOF() .And. SZY->ZY_SEQBA = SZX->ZX_SEQ
				
				If !Empty(AllTrim(SZY->ZY_RESPOST))
					
					_lRet := .T.
					Exit
					
				EndIf
				
				SZY->(DbSkip())
				
			EndDo
			
		EndIf
		
	EndIf
	
	RestArea(_aArZY)
	RestArea(_aArZX)
	RestArea(_aArea)
	
Return _lRet


// Fim do programa CABA069.PRW
