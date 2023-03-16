#INCLUDE "PROTHEUS.CH"
#INCLUDE "RWMAKE.CH"
#INCLUDE "TOPCONN.CH"
#include "TOTVS.CH"
#include "PLSMGER.CH"
#INCLUDE "MSOLE.CH"
#INCLUDE "RPTDEF.CH"
#INCLUDE "FWPrintSetup.ch"
#INCLUDE "Ap5Mail.Ch"

// Alinhamento do metodo addInLayout
#DEFINE LAYOUT_ALIGN_LEFT     1
#DEFINE LAYOUT_ALIGN_RIGHT    2
#DEFINE LAYOUT_ALIGN_HCENTER  4
#DEFINE LAYOUT_ALIGN_TOP      32
#DEFINE LAYOUT_ALIGN_BOTTOM   64
#DEFINE LAYOUT_ALIGN_VCENTER  128

#DEFINE SEG20B  TFont():New("Segoe UI",,-20,.T.,.T.)
#DEFINE SEG16   TFont():New("Segoe UI",,-16,.T.,.F.)

#DEFINE CSSBTNPRIMARY "QPushButton{color:#fff; background-color:#007bff;border-color:#007bff }"
#DEFINE CSSBTNLIGHT "QPushButton{color:#212529; background-color:#f8f9fa;border-color:#f8f9fa }"

#DEFINE ARIAL18B  TFont():New("Arial",,-18,.T.,.T.)
#DEFINE ARIAL14   TFont():New("Arial",,-14,.T.,.F.)
#DEFINE ARIAL14B  TFont():New("Arial",,-14,.T.,.T.)

// Alinhamento para preenchimento dos componentes no TLinearLayout
#DEFINE LAYOUT_LINEAR_L2R 0 // LEFT TO RIGHT
#DEFINE LAYOUT_LINEAR_R2L 1 // RIGHT TO LEFT
#DEFINE LAYOUT_LINEAR_T2B 2 // TOP TO BOTTOM
#DEFINE LAYOUT_LINEAR_B2T 3 // BOTTOM TO TOP

#DEFINE c_ent CHR(13) + CHR(10)

/*------------------------------------------------------------------------|
| Funcao    | CABA069  | Otavio Pinto                  | Data | 28/01/13  |
+-------------------------------------------------------------------------+
| Descricao | Protocolo de Atendimento                                    |
+-------------------------------------------------------------------------+
| Uso       | Protocolo de Atendimentos                                   |
+-------------------------------------------------------------------------+
| Alterado  |Angelo Henrique                           | Data | 01/01/17  |
+-------------------------------------------------------------------------+
| Descricao |Alterado maior parte desta rotina para atender a versao 2.0  |
|           |Onde foram acrescentadas melhorias, RN 412.                  |
+-------------------------------------------------------------------------+
| Alterado  | Angelo Henrique                          | Data | 23/05/17  |
+-------------------------------------------------------------------------+
| Descricao |Criado dois parametros para a integracao PA x URA            |
|           |O primeiro sera a matricula do beneficiario.                 |
|           |O segundo sera a passagem a do beneficiario.                 |
+------------------------------------------------------------------------*/
User Function CABA069(_cParam1,_cParam2)

	Private aRotina 		:= {}
	Private cCadastro 		:= "Protocolo de Atendimento"
	Private cAlias1 		:= "SZX"                    // Alias da Enchoice.
	Private cAlias2 		:= "SZY"                    // Alias da GetDados.

	Private _cProt			:= Nil  //Variavel de retorno caso a rotina seja chamada pela PA x URA - Angelo Henrique - Data: 24/05/2017
	Private  I      		:= 0
	Private cQuery  		:= ' '
	Private cUsua   		:= SUBSTR(cUsuario, 7, 6 )

	Private aCdCores  		:= {{ 'BR_AMARELO' ,'Pendente' 		},;
		{ 'BR_VERMELHO'  		,'Encerrado'					},;
		{ 'BR_VERDE'   			,'Em Andamento'					},; //Angelo Henrique - Data: 05/10/2016 - Chamado: 28286
		{ 'BR_LARANJA'   		,'Encerrado em acompanhamento'	}}

	Private aCores      	:= { { 'ZX_TPINTEL = "1" ',aCdCores[1,1] },;
		{ 'ZX_TPINTEL = "2"'	,aCdCores[2,1] },;
		{ 'ZX_TPINTEL = "3"'	,aCdCores[3,1] },;
		{ 'ZX_TPINTEL = "4"'	,aCdCores[4,1] }} //Angelo Henrique - Data: 05/10/2016 - Chamado: 28286

	//--------------------------------------------------------------
	// INICIO Angelo Henrique - Criacao de Filtro no Protocolo
	//--------------------------------------------------------------
	//Chamado 28286
	//--------------------------------------------------------------
	If _cParam2 != "2"

		Private _aIndex 		:= {}
		Private _cFiltro 		:= "ZX_USDIGIT = '" + ALLTRIM(UsrRetName(__cUserId)) + "' .AND. ZX_TPINTEL $ '1|3' " //Expressao do Filtro		
		Private _bFiltBrw 		:= { || FilBrowse( "SZX" , @_aIndex , @_cFiltro ) } //Determina a Expressao do Filtro
		Private _lFilt 			:= .F.

	EndIf
	//--------------------------------------------------------------
	// FIM Angelo Henrique - Criacao de Filtro no Protocolo
	// Chamado 28286
	//--------------------------------------------------------------

	//--------------------------------------------------------------
	//INICIO - PA X URA - ANGELO HENRIQUE - DATA: 23/05/2017
	//--------------------------------------------------------------
	Default _cParam1 		:= ""
	Default _cParam2 		:= ""

	aFunPA := {}
	AAdd(aFunPA, {"Direcionar p/ Area" 						, "U_CAB69DIR", 0, 6})
	AAdd(aFunPA, {"Historico de Movimentacao do Protocolo"	, "U_CAB69HIS", 0, 6})

	AAdd(aRotina, {"Pesquisar" 								, "AxPesqui"  , 0, 1})
	AAdd(aRotina, {"Visualizar"								, "u_PA_Manut", 0, 2})
	AAdd(aRotina, {"Incluir"   								, "u_PA_Manut", 0, 3})
	AAdd(aRotina, {"Alterar"   								, "u_PA_Manut", 0, 4})
	AAdd(aRotina, {"Excluir"   								, "u_PA_Manut", 0, 5})
	AAdd(aRotina, {"Legenda"   								, "u_PAIMPLEG", 0, 6})
	AAdd(aRotina, {"Env Protc" 								, "u_CABA596" , 0, 6})
	AAdd(aRotina, {"Recibo PA" 								, "u_RelAted" , 0, 6})
	AAdd(aRotina, {"Can RN412" 								, "u_CABA595" , 0, 6})
	AAdd(aRotina, {"Arquivos Doc." 							, "u_CABA69NX", 0, 6})
	AAdd(aRotina, {"Doc Excluidos" 							, "u_CABR251" , 0, 6})
	AAdd(aRotina, {"Historico PA " 							, "u_CAB69ZZ" , 0, 6})
	AAdd(aRotina, {"Inserir / Alterar Justificativa" 		, "U_CAB69OBS", 0, 6})
	AAdd(aRotina, {"Enviar Extrato" 						, "U_CAB69EXT", 0, 6})

	dbSelectArea(cAlias1)
	dbOrderNickName("SEQ")
	dbGoTop()

	If _cParam2 != "2"
		//--------------------------------------------------------------------------------------
		// INICIO Angelo Henrique - Criacao de Filtro no Protocolo
		//--------------------------------------------------------------------------------------
		//Chamado 28286
		//--------------------------------------------------------------------------------------
		If AVISO( "Atencao", "Deseja executar o filtro para as suas PA's pendentes? ", {"Sim","Nao"}) == 1

			Eval( _bFiltBrw ) //Efetiva o Filtro antes da Chamada a mBrowse
			_lFilt := .T.
		
		EndIf
		//--------------------------------------------------------------------------------------
		// FIM Angelo Henrique - Criacao de Filtro no Protocolo
		//--------------------------------------------------------------------------------------

	EndIf

//---------------------------------------------------------------------
//Caso nao seja chamdo pela rotina de PA x URA
//Ira abrir o protocolo normalmente
//---------------------------------------------------------------------
If _cParam2 != "2"

	mBrowse(,,,,cAlias1, , , , , Nil    , aCores)

	If _lFilt

		EndFilBrw( "SZX" , @_aIndex ) //Finaliza o Filtro

	EndIf

Else

	//-------------------------------------------------------
	//No caso da PA x Ura, encaminho mais um parametrowa
	//este parÃ¢metro e a matricula do beneficiario
	//esta matricula pode ou nao vir preenchida
	//-------------------------------------------------------
	_cProt := u_PA_Manut("SZX", 1, 3,_cParam1,_cParam2)

EndIf

Return _cProt

//----------------------------------------------------------------------------------------------------------------//
// Modelo 3.
//----------------------------------------------------------------------------------------------------------------//
User Function PA_Manut(cAlias, nReg, nOpc,_cMatric, _cCham, _cProtLig)

	Local j					:= 0
	Local cAliQry			:= GetNextAlias()
	Local cQuery			:= ""
	Local aObjects  		:= {}
	Local aPosObj   		:= {}
	Local aSizeAut  		:= MsAdvSize()
	Local _cRet				:= Nil //Responsavel pelo retorno do protocolo caso a rotina seja chamada pela PA x URA
	//Local c_CodUsr			:= RetCodUsr() //Utilizado na validacao da Diretoria.
	Local _lDiret			:= .T. //Utilizado na validacao da Diretoria ou PA NIP do Regulatorio
	Local aArea				:= SZX->(GetArea())
	Local _cCnlMail			:= GetNewPar("MV_XNOTPA","000014,000033")
	Local _cAreaZX			:= ""	
	Local _cAreaPCB 		:= ""	
	Local _cAreaPCA 		:= ""	
	Local _cAreaSX5 		:= ""	
	Local _cAreaCC2 		:= ""	

	Private nOpcA   		:= 0
	Private aGETS   		:= {}
	Private aTELA   		:= {}
	Private aCols        	:= {}
	Private aHeader      	:= {}
	Private aCpoEnchoice 	:= {}
	Private aAltEnchoice 	:= {}
	Private aAlt         	:= {}
	Private oGetDad		 	:= Nil //Angelo Henrique - Data: 31/10/2016
	Private _oDlg		 	:= Nil //Angelo Henrique - Data: 31/10/2016
	Private _aBot		 	:= {}  //Angelo Henrique - Data: 31/10/2016
	Private cTudoOk 		:= "AllwaysTrue"
	Private cIniCpos 		:= ""
	Private oEnch			:= Nil
	Private nMax 			:= 999
	Private cSuperDel 		:= ""
	Private cDelOk 			:= "AllwaysTrue"
	Private nAlturaEnc		:= 350
	Private deleta 			:= .F.
	Private lCancel			:= .T.
	Private lRedirect 		:= .F.
	Private lVinc 			:= .F.
	
	Default _cMatric	 	:= ""	//Angelo Henrique - Data: 23/05/2017 - PA x URA
	Default _cCham			:= ""	//Angelo Henrique - Data: 23/05/2017 - PA x URA
	Default _cProtLig		:= ""	//Angelo Henrique - Data: 03/08/2022 - Transferência de Ligação

	Default cAlias1			:= "SZX"
	Default cAlias2			:= "SZY"

	if ddatabase <> date() .and. nOpc == 3

		alert("Não é permitido incluir protocolo com data diferente da data atual!")
		return _cRet

	endif

	//----------------------------------------------------------------------------------------------------------------------------
	//Validacao criada para os protocolos de atendimento da DIRETORIA, onde foi solicitado que o mesmo so pode ser visualizado
	//ou alterado por quem possuir acessos.
	//----------------------------------------------------------------------------------------------------------------------------
	If cValtoChar(nOpc) $ ("2,4,5")

		//---------------------------------------------------------------------------------------------------------
		//Angelo Henrique - Data: 09/02/2022 - Chamado: 83831
		//---------------------------------------------------------------------------------------------------------
		//A pedido do chamado será removido a validação de protocolos oriundos da DIRETORIA
		//Este parametro permanece no relatório CABR212.
		//---------------------------------------------------------------------------------------------------------
		//If !(Upper(AllTrim(c_CodUsr)) $ Upper(AllTrim(GetNewPar("MV_XUSUDIR","")))) .And. SZX->ZX_CANAL = "000014"

		//	Aviso("Atencao","Usuario nao permitido para alterar, visualizar ou excluir protocolos da DIRETORIA.",{"OK"})

		//	_lDiret := .F.

		//EndIf		

		U_CABG008(SZX->ZX_SEQ)

	EndIf

If _lDiret

	//-----------------------------------------------------------------------------------------------------------
	// Cria variaveis de memoria dos campos da tabela Pai.
	// 1o. parametro: Alias do arquivo --> e case-sensitive, ou seja precisa ser como esta no Dic.Dados.
	// 2o. parametro: .T.              --> cria variaveis em branco, preenchendo com o inicializador-padrao.
	//                .F.              --> preenche com o conteudo dos campos.
	//-----------------------------------------------------------------------------------------------------------
	RegToMemory(cAlias1, (nOpc==3))

	//-----------------------------------------------------------------------------------------------------------
	// Cria variaveis de memoria dos campos da tabela Filho.
	//-----------------------------------------------------------------------------------------------------------
	RegToMemory(cAlias2, (nOpc==3))

	//-----------------------------------------------------------------------------------------------------------
	//Cria o aHeader da tabela SZY
	//-----------------------------------------------------------------------------------------------------------
	CriaHeader(nOpc)

	//-----------------------------------------------------------------------------------------------------------
	//Cria o aCols da tabela SZY
	//-----------------------------------------------------------------------------------------------------------
	CriaCols(nOpc)

	aObjects := {}

	AAdd( aObjects, { 315, 50, .T., .T. } )
	AAdd( aObjects, { 100, 25, .T., .T. } )

	aInfo := { aSizeAut[ 1 ], aSizeAut[ 2 ], aSizeAut[ 3 ], aSizeAut[ 4 ], 3, 3 }
	aPosObj := MsObjSize( aInfo, aObjects, .T. )

	DEFINE MSDIALOG _oDlg TITLE cCadastro From aSizeAut[7],00 To aSizeAut[6],aSizeAut[5] OF oMainWnd PIXEL

	oEnch := EnChoice( cAlias,nReg, nOpc, , , , , aPosObj[1], , 3 )

	oGetDad := MSGetDados():New(aPosObj[2,1], aPosObj[2,2], aPosObj[2,3], aPosObj[2,4], nOpc, "AllwaysTrue", "AllwaysTrue","", (nopc = 3 .or. nopc = 4),,,)

	//-------------------------------------------------------------------------------------------
	//INICIO - Angelo Henrique - Data: 21/02/2017
	//-------------------------------------------------------------------------------------------
	//INCLUINDO A VISUALIcaO DO HISToRICO DE PA NAS AcoES RELACIONADAS.
	//-------------------------------------------------------------------------------------------
	aFunPA := {}

	aadd(_aBot,{"NG_ICO_LEGENDA", {||U_CAB69ZZ("2")				} ,"Historico PA"			,"Historico PA"									})
	aadd(_aBot,{"NG_ICO_LEGENDA", {||U_CABV028("2")				} ,"Excecoes Cont/Sub"		,"Excecoes Cont/Sub"							})
	aadd(_aBot,{"NG_ICO_LEGENDA", {||U_CABA595G(SZX->ZX_SEQ)	} ,"Imp. Cancelamento"		,"Imp. Cancelamento"							})
	aadd(_aBot,{"NG_ICO_LEGENDA", {||U_CABA69NX("2")			} ,"Arquivos Doc."			,"Arquivos Doc."								})
	aadd(_aBot,{"NG_ICO_LEGENDA", {||U_CABA69AA()				} ,"Mural Associad."		,"Mural Associad."								})
	aadd(_aBot,{"NG_ICO_LEGENDA", {||U_CAB69COB()				} ,"Cobrar area."			,"Cobrar area"									})
	aadd(_aBot,{"NG_ICO_LEGENDA", {||U_CABA69AA()				} ,"Mural Associad."		,"Mural Associad."								})
	AAdd(_aBot,{"NG_ICO_LEGENDA", {||U_CAB69DIR() 				} ,"Movimentacao interna" 	,"Direcionar p/ area" , "Movimentacao interna"	})
	AAdd(_aBot,{"NG_ICO_LEGENDA", {||U_CAB69HIS() 				} ,"Movimentacao interna"	,"Historico de Movimentacao do Protocolo"		})
	AAdd(_aBot,{"NG_ICO_LEGENDA", {||U_CAB69VI2() 				} ,"Vincular Protocolo"		,"Vincular Protocolo"							})

	//Projeto Transferência de atendimento no protocolo
	AAdd(_aBot,{"NG_ICO_LEGENDA", {||U_CAB69I() 				} ,"Ligação Transferida"	,"Ligação Transferida"							})	

	If (!INCLUI)
		AAdd(_aBot,{"NG_ICO_LEGENDA",  {|| U_ImpProt()	} ,"Impressao Atend. Presencial" ,"Impressao Atend. Presencial"		})
	EndIf

	//-------------------------------------------------------------------------------------------
	//Angelo Henrique - Data: 28/01/2022
	//-------------------------------------------------------------------------------------------
	//Melhorias criadas para atender ao chamado 82472
	//Acrescimo da chamada da rotina de dados unificados e geração de carteira
	//-------------------------------------------------------------------------------------------
	AAdd(_aBot,{"NG_ICO_LEGENDA", {||U_CRJPMOV("SZZ",,3)		} ,"Dados Unificados"		,"Dados Unificados"							})
	AAdd(_aBot,{"NG_ICO_LEGENDA", {||GERCART()  				} ,"Gerar Carteira"			,"Gerar Carteira"							})

	//-------------------------------------------------------------------------------------------
	//FIM - Angelo Henrique - Data: 21/02/2017
	//-------------------------------------------------------------------------------------------
	//Se for chamada da PA x URA ira alimentar as Variaveis da tela
	//-------------------------------------------------------------------------------------------
	If !Empty(_cMatric)

		DbSelectArea("BA1")
		DbSetOrder(2)
		If DbSeek(xFilial("BA1") + _cMatric)

			M->ZX_USUARIO 	:= _cMatric
			M->ZX_NOMUSR 	:= BA1->BA1_NOMUSR
			M->ZX_YDTNASC	:= BA1->BA1_DATNAS
			M->ZX_EMAIL 	:= BA1->BA1_EMAIL
			M->ZX_CONTATO	:= AllTrim(BA1->BA1_TELEFO) + " - " + AllTrim(BA1->BA1_YTEL2) + " - " + AllTrim(BA1->BA1_YCEL)
			M->ZX_YPLANO 	:= POSICIONE("BI3",1,BA1->(BA1_FILIAL+BA1_CODINT+BA1_CODPLA+BA1_VERSAO),"BI3_CODIGO+' '+BI3_DESCRI")
			M->ZX_YDTINC	:= BA1->BA1_DATINC
			M->ZX_NMSOCIA	:= BA1->BA1_YNMSOC
			M->ZX_CPFUSR	:= BA1->BA1_CPFUSR

			If !Empty(_cProtLig)

				_cAreaZX  := SZX->(GetArea())
				_cAreaPCB := PCB->(GetArea())
				_cAreaPCA := PCA->(GetArea())
				_cAreaSX5 := SX5->(GetArea())
				_cAreaCC2 := CC2->(GetArea())

				DbSelectArea("SZX")
				dbSetOrder(1)
				If DbSeek(xFilial("SZX") + _cProtLig)

					M->ZX_CANAL		:= SZX->ZX_CANAL
					M->ZX_DSCCANA	:= POSICIONE("PCB",1,XFILIAL("PCB")+SZX->ZX_CANAL,"PCB_DESCRI")
					M->ZX_PTENT  	:= SZX->ZX_PTENT
					M->ZX_DSCPORT	:= POSICIONE("PCA",1,XFILIAL("PCA")+SZX->ZX_PTENT,"PCA_DESCRI")
					M->ZX_TPDEM  	:= SZX->ZX_TPDEM
					M->ZX_DSCDEMA	:= POSICIONE("SX5",1,XFILIAL("SX5")+"ZT"+ALLTRIM(SZX->ZX_TPDEM),"X5_DESCRI")
					M->ZX_CONTATO 	:= SZX->ZX_CONTATO

					M->ZX_EST    	:= SZX->ZX_EST 
					M->ZX_ESTADO 	:= POSICIONE("SX5",1,XFILIAL("SX5")+"12"+SZX->ZX_EST,"X5_DESCRI")
					M->ZX_CODMUN 	:= SZX->ZX_CODMUN
					M->ZX_MUN    	:= POSICIONE("CC2",1,XFILIAL("CC2")+SZX->ZX_EST+SZX->ZX_CODMUN,"CC2_MUN")
					M->ZX_BAIRRO 	:= SZX->ZX_BAIRRO

				EndIf

				RestArea(_cAreaCC2)
				RestArea(_cAreaSX5)
				RestArea(_cAreaPCB)
				RestArea(_cAreaPCA)
				RestArea(_cAreaZX )

			EndIf

			//----------------------------------------------
			//Exibe a tela com o numero do protocolo
			//----------------------------------------------
			U_fMostraProt()

		Else

			M->ZX_USUARIO 	:= SPACE(TAMSX3("ZX_USUARIO")[1])
			M->ZX_NOMUSR 	:= ""
			M->ZX_YDTNASC	:= CTOD("")
			M->ZX_EMAIL 	:= SPACE(TAMSX3("ZX_EMAIL")[1])
			M->ZX_CONTATO	:= SPACE(TAMSX3("ZX_CONTATO")[1])
			M->ZX_YPLANO 	:= ""

		EndIf

	Else
		
		If !empty(SZX->(ZX_CODINT+ZX_CODEMP+ZX_MATRIC+ZX_TIPREG))
			U_VeSitAdv(SZX->(ZX_CODINT+ZX_CODEMP+ZX_MATRIC+ZX_TIPREG))
		EndIf

	EndIf

	ACTIVATE MSDIALOG _oDlg ON INIT EnchoiceBar(_oDlg,{ || IIf( OBRIGATORIO(AGETS,ATELA) .And. TudoOk() .And. u_PA_TudOK() , (nOpca := 1, _oDlg:END()), nOpca := 0) }, { || IIF(lCancel,_oDlg:END(),Aviso("Atencao","PA Redirecionada por favor salve a alteracao",{"OK"})) },,_aBot)

	If nOpca == 1

		If nOpc == 3

			Processa({||GrvDados()}, cCadastro, "Gravando os dados, aguarde...")

			cSql := " UPDATE "+RetSqlName("SZY")+" SET D_E_L_E_T_ = '*' WHERE ZY_SEQBA = '"+SZX->ZX_SEQ+"' AND ZY_SEQSERV = ' '     "+c_ent
			TcSqlExec(cSql)
			cSql := " COMMIT"+c_ent
			TcSqlExec(cSql)

			//--------------------------------------------------------
			//Chamada da rotina para envio do protocolo por e-mail.
			//--------------------------------------------------------
			If !(SZX->ZX_CANAL $ (_cCnlMail))

				u_CABA596()

			EndIf

			//--------------------------------------------------------
			//So pode entrar na validacao de dados unificados se estiver
			//como sim cadastrado na tabela de amarracao dos
			//usuarios x dados unificados (PCY)
			//--------------------------------------------------------
			DbSelectArea("PCY")
			DbSetOrder(1) //PCY_FILIAL+PCY_USUARI
			If DbSeek(xFilial("PCY") + RetCodUsr())

				If PCY->PCY_DADUNI == "1" //0 - nao || 1 - sim

					//--------------------------------------------------------
					//Atualizar informacoes na rotina de Dados Unificados
					//--------------------------------------------------------
					If !(Empty(AllTrim(SZX->ZX_MATRIC))) .And. !(Empty(AllTrim(SZX->ZX_EMAIL)))
						IF AVISO( "Atencao", "Deseja atualizar as informacoes nos DADOS UNIFICADOS ? ", {"Sim","Nao"}) == 1

							_aSZX := SZX->(GetArea())
							_aBA1 := BA1->(GetArea())
							_aBA3 := BA3->(GetArea())
							_aSZZ := SZZ->(GetArea())

							u_CABA605()

							RestArea(_aSZZ)
							RestArea(_aBA3)
							RestArea(_aBA1)
							RestArea(_aSZX)

						EndIf

					EndIf

				EndIf

			EndIf

			//--------------------------------------------------------
			//Chamada do relatorio do protocolo presencial
			//Se o tipo de porta de entrada for presencial
			//--------------------------------------------------------
			If SZX->ZX_PTENT == "000007"

				U_RELATED()

			EndIf

			//--------------------------------------------------------
			//Caso a rotina seja chamada pela PA x URA
			//e necessario retornar o nÃºmero do protocolo
			//--------------------------------------------------------
			If !Empty(_cMatric) .OR. _cCham = "2"

				//--------------------------------------------------------------------------
				//Reforcando a atualizacao dos dados do beneficiarios pela PA x URA
				//--------------------------------------------------------------------------
				If !Empty(_cMatric) .And. Empty(SZX->ZX_CODINT)

					RecLock("SZX", .F.)

					SZX->ZX_CODINT := SUBSTR(_cMatric,1,4 )
					SZX->ZX_CODEMP := SUBSTR(_cMatric,5,4 )
					SZX->ZX_MATRIC := SUBSTR(_cMatric,9,6 )
					SZX->ZX_TIPREG := SUBSTR(_cMatric,15,2)
					SZX->ZX_DIGITO := SUBSTR(_cMatric,17,1)

					SZX->(MsUnLock())

				EndIf

				_cRet := SZX->ZX_SEQ

			EndIf

			If lVinc

				cProtCtrl := M->ZX_SEQPRB

				aArea := GetArea()

				DbSelectArea("SZY")

				DbSetOrder(2)

				FOR j := 1 To LEN(aCols)


					DbSeek( XFilial("SZY") + cProtCtrl + aCols[j][ Ascan(aHeader,{|x| AllTrim(x[2]) == "ZY_SEQSERV" }) ] )

					If !FOUND()

						RecLock("SZY",.T.)

						SZY->ZY_SEQBA 	:= cProtCtrl
						SZY->ZY_SEQSERV := U_GetSZYSeq(cProtCtrl)
						SZY->ZY_DTSERV 	:= aCols[j][ Ascan(aHeader,{|x| AllTrim(x[2]) == "ZY_DTSERV"	}) ]
						SZY->ZY_HORASV 	:= aCols[j][ Ascan(aHeader,{|x| AllTrim(x[2]) == "ZY_HORASV"	}) ]
						SZY->ZY_TIPOSV 	:= aCols[j][ Ascan(aHeader,{|x| AllTrim(x[2]) == "ZY_TIPOSV" 	}) ]
						SZY->ZY_OBS 	:= aCols[j][ Ascan(aHeader,{|x| AllTrim(x[2]) == "ZY_OBS"		}) ]
						SZY->ZY_HISTPAD := aCols[j][ Ascan(aHeader,{|x| AllTrim(x[2]) == "ZY_HISTPAD" 	}) ]
						SZY->ZY_DTRESPO := aCols[j][ Ascan(aHeader,{|x| AllTrim(x[2]) == "ZY_DTRESPO" 	}) ]
						SZY->ZY_HRRESPO := aCols[j][ Ascan(aHeader,{|x| AllTrim(x[2]) == "ZY_HRRESPO" 	}) ]
						SZY->ZY_RESPOST := aCols[j][ Ascan(aHeader,{|x| AllTrim(x[2]) == "ZY_RESPOST" 	}) ]
						SZY->ZY_USDIGIT := aCols[j][ Ascan(aHeader,{|x| AllTrim(x[2]) == "ZY_USDIGIT" 	}) ]
						SZY->ZY_LOGRESP := aCols[j][ Ascan(aHeader,{|x| AllTrim(x[2]) == "ZY_LOGRESP"	}) ]
						SZY->ZY_SEQCTRL := aCols[j][ Ascan(aHeader,{|x| AllTrim(x[2]) == "ZY_SEQBA" 	}) ]

						MsUnlock()

					EndIf

				NEXT j

				// FRED: Gravar no PA a informação do caso filho que está sendo aberto
				RecLock("SZY",.T.)
				ZY_FILIAL	:= xFilial("SZY")
				ZY_SEQBA	:= cProtCtrl
				ZY_SEQSERV	:= U_GetSZYSeq(cProtCtrl)
				ZY_DTSERV	:= date()
				ZY_HORASV	:= StrTran(time(), ":", "")
				ZY_TIPOSV	:= aCols[len(aCols)][ Ascan(aHeader,{|x| AllTrim(x[2]) == "ZY_TIPOSV" 	}) ]
				ZY_SERV		:= aCols[len(aCols)][ Ascan(aHeader,{|x| AllTrim(x[2]) == "ZY_SERV" 	}) ]
				ZY_HISTPAD	:= aCols[len(aCols)][ Ascan(aHeader,{|x| AllTrim(x[2]) == "ZY_HISTPAD" 	}) ]
				ZY_DSCHIST	:= aCols[len(aCols)][ Ascan(aHeader,{|x| AllTrim(x[2]) == "ZY_DSCHIST" 	}) ]
				ZY_OBS		:= aCols[len(aCols)][ Ascan(aHeader,{|x| AllTrim(x[2]) == "ZY_OBS"		}) ]
				ZY_RESPOST	:= aCols[len(aCols)][ Ascan(aHeader,{|x| AllTrim(x[2]) == "ZY_RESPOST" 	}) ]
				ZY_USDIGIT	:= aCols[len(aCols)][ Ascan(aHeader,{|x| AllTrim(x[2]) == "ZY_USDIGIT" 	}) ]
				ZY_YCUSTO	:= ""
				ZY_DTRESPO	:= aCols[len(aCols)][ Ascan(aHeader,{|x| AllTrim(x[2]) == "ZY_DTRESPO" 	}) ]
				ZY_HRRESPO	:= aCols[len(aCols)][ Ascan(aHeader,{|x| AllTrim(x[2]) == "ZY_HRRESPO" 	}) ]
				ZY_LOGRESP	:= aCols[len(aCols)][ Ascan(aHeader,{|x| AllTrim(x[2]) == "ZY_LOGRESP" 	}) ]
				ZY_PESQUIS	:= aCols[len(aCols)][ Ascan(aHeader,{|x| AllTrim(x[2]) == "ZY_PESQUIS" 	}) ]
				ZY_JUSTEXP	:= ""
				ZY_SEQCTRL	:= ""
				ZY_PROTFIL	:= aCols[len(aCols)][ Ascan(aHeader,{|x| AllTrim(x[2]) == "ZY_SEQBA" 	}) ]
				MsUnlock()
				// FRED: fim da gravação do caso filho na PA principal

				RestArea(aArea)

			EndIf

			If MsgYesNo("Deseja inserir anexos ao Protocolo?", cCadastro)

				_cChvSZX := SZX->(ZX_FILIAL+ZX_SEQ+ZX_CODINT+ZX_CODEMP+ZX_MATRIC+ZX_TIPREG+ZX_DIGITO+DTOS(ZX_DATDE)+ZX_HORADE+DTOS(ZX_DATATE)+ZX_HORATE)

				DbSelectArea("SZX")
				MsDocument("SZX", SZX->(RECNO()), 4)

				//--------------------------------------------------------------------------------------------------
				//Luiz Otavio Campos - Data: 07/05/2021
				//--------------------------------------------------------------------------------------------------
				//Medida de contorno para atualizar campos da tabeça AC9
				//--------------------------------------------------------------------------------------------------
				fAtuAC9()

				//--------------------------------------------------------------------------------------------------
				//Angelo Henrique - Data: 21/02/2019
				//--------------------------------------------------------------------------------------------------
				//Rotina para transferir os docs do protocolo de atendimento para os doc no nÃ­vel do usuÃ¡rio
				//--------------------------------------------------------------------------------------------------
				TransfDoc(_cChvSZX)
				//--------------------------------------------------------------------------------------------------

			EndIf

			If MsgYesNo("Deseja duplicar este Protocolo? ")

				//--------------------------------------------------------------------------
				//Fechando a tela 
				//--------------------------------------------------------------------------
				If ValType(_oDlg) == "O"
					_oDlg:END()
				EndIf

				//Abrindo o novo PA com os dados do benefciário
				u_PA_Manut("SZX", 1, 3, SZX->(ZX_CODINT+ZX_CODEMP+ZX_MATRIC+ZX_TIPREG+ZX_DIGITO),,SZX->ZX_SEQ)

			EndIf

		ElseIf nOpc == 4

			If SZX->ZX_TPINTEL == "2"

				Alert("Protocolo de Atendimento encerrado... Nao pode ser Alterado!", cCadastro)

				// FRED: tratamento do acompanhamento de encerramento
			elseif M->ZX_TPINTEL == "4" .and. ( empty(M->ZX_CONTENC) .or. empty(M->ZX_TELEENC) .or. empty(M->ZX_DESCENC) )

				Alert("O preenchimento dos campos: Contato, Telefone e Descrição de Acompanhamento de Encerramento na aba 'Acompanhamento' são obrigatórios!", cCadastro)

			ElseIf lRedirect

				Processa({||AltDados()}, cCadastro, "Alterando os dados, aguarde...")

			Else

				If MsgYesNo("Confirma a alteracao dos dados?", cCadastro)

					Processa({||AltDados()}, cCadastro, "Alterando os dados, aguarde...")

				EndIf

			EndIf

		ElseIf nOpc == 5

			If SZX->ZX_TPINTEL $ "2|4"

				Alert("Protocolo de Atendimento encerrado... Nao pode ser Excluido!", cCadastro)

			Else

				If MsgYesNo("Confirma a exclusao dos dados?", cCadastro)

					Processa({||ExcDados()}, cCadastro, "Excluindo os dados, aguarde...")

				EndIf

			EndIf

		EndIf

	Else

		//--------------------------------------------------------
		//Caso a rotina seja chamada pela PA x URA
		//e necessario retornar o nÃºmero do protocolo
		//--------------------------------------------------------
		If !Empty(_cMatric) .OR. _cCham = "2"

			_cRet := M->ZX_SEQ

		EndIf

		DbSelectArea("SZX")
		DbSetOrder(1)
		If DbSeek( xFilial("SZX") + M->ZX_SEQ)

			If Empty(SZX->ZX_DATDE)

				//----------------------------------------------------------------------
				//update no registro do banco para nao ficar com sujeira
				//----------------------------------------------------------------------
				TCSQLEXEC(" UPDATE " + RetSqlName("SZX") + " SET D_E_L_E_T_ = '*' WHERE ZX_SEQ = '" + SZX->ZX_SEQ + "' AND ZX_DATDE = ' ' ")
				cSql := " UPDATE " + RetSqlName("SZY") + " SET D_E_L_E_T_ = '*' WHERE ZY_SEQBA = '" + SZX->ZX_SEQ + "' AND ZY_DTSERV = ' ' " + c_ent
				TcSqlExec(cSql)
				cSql := " COMMIT"+c_ent
				TcSqlExec(cSql)
				//----------------------------------------------------------------------------------------
				//Apos a exclusao perde-se o ponteramento da ultima inclusao efetuada pelo usuario
				//logo sera necessario forcar o ponteramento, pegando assim o ultimo registro
				//inclui­do
				//----------------------------------------------------------------------------------------
				cQuery := " SELECT " 																					+ c_ent
				cQuery += " 	R_E_C_N_O_ RECNO " 																		+ c_ent
				cQuery += " FROM " 																						+ c_ent
				cQuery += " 	 " + RETSQLNAME("SZX") 																	+ c_ent
				cQuery += " WHERE " 																					+ c_ent
				cQuery += " 	D_E_L_E_T_ = ' ' " 																		+ c_ent
				cQuery += " 	AND TRIM(ZX_USDIGIT) = '" + AllTrim(CUSERNAME) + "'" 									+ c_ent
				cQuery += " 	AND R_E_C_N_O_ = ( " 																	+ c_ent
				cQuery += " 						SELECT " 															+ c_ent
				cQuery += " 							MAX(ZX_1.R_E_C_N_O_)" 											+ c_ent
				cQuery += " 						FROM " 																+ c_ent
				cQuery += " 							 " + RETSQLNAME("SZX") + " ZX_1" 								+ c_ent
				cQuery += " 							WHERE " 														+ c_ent
				cQuery += " 								ZX_1.D_E_L_E_T_ = ' '" 										+ c_ent
				cQuery += " 								AND TRIM(ZX_1.ZX_USDIGIT) = '" + AllTrim(CUSERNAME) + "'" 	+ c_ent
				cQuery += " 					 )" 																	+ c_ent

				If Select(cAliQry) > 0
					(cAliQry)->(DbCloseArea())
				EndIf

				DbUseArea(.T.,"TopConn",TcGenQry(,,cQuery),cAliQry,.T.,.T.)

				DbSelectArea(cAliQry)

				If !((cAliQry)->(Eof()))

					DbSelectArea("SZX")
					DbGoTo((cAliQry)->RECNO)

				EndIf

				If Select(cAliQry)>0
					(cAliQry)->(DbCloseArea())
				EndIf

			EndIf

		EndIf

	EndIf

EndIf

RestArea(aArea)

Return _cRet

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
Static Function CriaHeader(nOpc)

	Private _cDia		:= "" //Angelo Henrique - Data06/02/2017 - Nova Regra de Sequencial do PA
	Private _cCntPA		:= "" //Angelo Henrique - Data06/02/2017 - Nova Regra de Sequencial do PA
	Private _cRegAns	:= "" //Angelo Henrique - Data06/02/2017 - Nova Regra de Sequencial do PA
	Private _cSeq		:= "" //Angelo Henrique - Data06/02/2017 - Nova Regra de Sequencial do PA
	Private _lAchou		:= "" //Angelo Henrique - Data06/02/2017 - Nova Regra de Sequencial do PA

	aHeader      		:= {}
	aCpoEnchoice 		:= {}
	aAltEnchoice 		:= {}

	// aHeader e igual ao do Modelo2.

	dbSelectArea("SX3")
	dbSetOrder(1)
	dbSeek(cAlias2)

	While !SX3->( EOF()) .And. SX3->X3_Arquivo == cAlias2

		If X3Uso(SX3->X3_Usado) .And. cNivel >= SX3->X3_Nivel

			Aadd(aHeader, {;
				SX3->X3_TITULO,;	//
				SX3->X3_CAMPO,;  	//X3_CAMPO
				SX3->X3_PICTURE,;	//X3_PICTURE
				SX3->X3_TAMANHO,;	//X3_TAMANHO
				SX3->X3_DECIMAL,;	//X3_DECIMAL
				SX3->X3_VALID,;		//X3_VALID
				SX3->X3_USADO,;		//X3_USADO
				SX3->X3_TIPO,;		//X3_TIPO
				SX3->X3_F3,; 		//X3_F3
				SX3->X3_CONTEXT,;	//X3_CONTEXT
				SX3->X3_CBOX,;		//X3_CBOX
				SX3->X3_RELACAO,;	//X3_RELACAO
				SX3->X3_WHEN})		//

		EndIf

		SX3->(dbSkip())

	EndDo

	// Campos da Enchoice.

	dbSelectArea("SX3")
	dbSetOrder(1)
	dbSeek(cAlias1)

	While !SX3->( EOF()) .And. SX3->X3_Arquivo == cAlias1

		If X3Uso(SX3->X3_Usado) .And. cNivel >= SX3->X3_Nivel

			// Campos da Enchoice.
			AAdd(aCpoEnchoice, X3_Campo)

			// Campos da Enchoice que podem ser editadas.
			// Se tiver algum campo que nao deve ser editado, nao incluir aqui.
			If (SZX->ZX_TPINTEL != '4')
				AAdd(aAltEnchoice, X3_Campo)
			EndIf

		EndIf

		SX3->( DbSkip() )

	EndDo

	If nOpc == 3

		//------------------------------------------------------------------------------------------
		//Angelo Henrique - Data: 06/12/2017
		//------------------------------------------------------------------------------------------
		//Mudanca no processo de geracao do sequencial
		//conforme RN 395 - ANS
		//Novo sequencial sera composto de:
		//------------------------------------------------------------------------------------------
		// XXXXXXAAAAMMDDNNNNNN
		//------------------------------------------------------------------------------------------
		// XXXXXX = REGISTRO DA ANS DA OPERADORA
		// AAAA = ANO
		// MM = MES
		// DD = DIA
		// NNNNNN = SEQUENCIAL QUE IDENTIfIQUE A ORDEM DE ENTRADA DA RECLAMAcaO NA OPERADORA
		//------------------------------------------------------------------------------------------

		_cSeq := U_GERNUMPA()

		M->ZX_SEQ := _cSeq

	EndIf

Return Nil

/*/{Protheus.doc} CriaCols
	Cria o acols da rotina
@type function
@version  1.0
@author angelo.cassago
@since 10/10/2022
@param nOpc, numeric, diz a opção selecionada
/*/
Static Function CriaCols(nOpc)

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
Static Function GrvDados()

	Local bCampo 	:= {|nField| Field(nField)}
	Local i      	:= 0
	Local y      	:= 0
	Local nItem  	:= 1//0
	Local _cAcmp 	:=  SZX->ZX_TPINTEL
	//Local cCodSla 	:= PADR(M->ZX_TPDEM,TAMSX3("PCG_CDDEMA")[1])+M->ZX_PTENT+M->ZX_CANAL+M->ZY_TIPOSV

	ProcRegua(Len(aCols) + FCount())

	begin sequence

		// Grava o registro da tabela Pai, obtendo o valor de cada campo
		// a partir da var. de memoria correspondente.
		DbSelectArea(cAlias1)
		DbSetOrder(1)
		_lFound := DbSeek( xFilial("SZX") + M->ZX_SEQ)

		RecLock(cAlias1, !_lFound)

		For i := 1 To FCount()

			IncProc()

			//+--------------------------------------------------------------------------------------------------------+
			//|Alterei a rotina para forcar a gravacao da Data e Hora de saida do sistema (ZX_DATATE e ZX_HORATE)      |
			//|por OSP em 08.08.2012 11:46                                                                             |
			//+--------------------------------------------------------------------------------------------------------+
			do case

				case "FILIAL"  $ FieldName(i)

					FieldPut(i, xFilial(cAlias1))

				case "DATATE"  $ FieldName(i)

					If M->ZX_TPINTEL $ "2|4"

						FieldPut(i, DATE() )

					EndIf

				case "HORATE"  $ FieldName(i)

					If M->ZX_TPINTEL $ "2|4"

						FieldPut(i, SUBSTR(TIME(),1,2)+SUBSTR(TIME(),4,2) )

					EndIf

				case "DTACOM"  $ FieldName(i)

					If _cAcmp $ "4" .AND. M->ZX_TPINTEL $ "2"

						FieldPut(i, DATE() )

					EndIf

				case "HRACOM"  $ FieldName(i)

					If _cAcmp $ "4" .AND. M->ZX_TPINTEL $ "2"

						FieldPut(i, SUBSTR(TIME(),1,2)+SUBSTR(TIME(),4,2) )

					EndIf

				case "YCUSTO"  $ FieldName(i)

					FieldPut(i, u_PegaCC( AllTrim (cUserName), 1 ) )

				case "TPINTEL" $ FieldName(i) ; FieldPut(i, M->&(Eval(bCampo,i)))

				otherwise

					FieldPut(i, M->&(Eval(bCampo,i)))

			end case

		Next

		If Inclui .And. !lVinc

			SZX->ZX_AREATU := SZX->ZX_CODAREA
			SZX->ZX_STATARE := '1'

		EndIf

		MSUnlock()

		// Grava os registros da tabela Filho.
		dbSelectArea(cAlias2)
		dbOrderNickName("SEQBA")

		For i := 1 To Len(aCols)

			IncProc()

			If !aCols[i][Len(aHeader)+1]       // A linha nao esta deletada, logo, pode gravar.

				RecLock(cAlias2, .T.)

				For y := 1 To Len(aHeader)

					If aHeader[y][10] != "V"

						FieldPut(FieldPos(Trim(aHeader[y][2])), aCols[i][y])

					EndIf

				Next

				SZY->ZY_Filial := xFilial("SZY")
				SZY->ZY_SEQBA   := M->ZX_SEQ //SZX->ZX_SEQ
				SZY->ZY_SEQSERV := StrZero(nItem, 6, 0)
				nItem++

				MSUnlock()

			EndIf

		Next

		//fGravaHist(SZX->ZX_CODAREA,"",cCodSla)

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
Static Function AltDados()

	Local bCampo := {|nField| Field(nField)}
	Local i      := 0
	Local y      := 0
	Local nItem  := 0
	Local _cAcmp :=  SZX->ZX_TPINTEL

	ProcRegua(Len(aCols) + FCount())

	//+--------------------------------------------------------------------------------------------------------+
	//|Conforme Chamado 2563, uma das solicitacoes pede para nao permitir gravar com o Tipo de Servicos VAZIO. |
	//|por OSP em 18.06.2012 16:21                                                                             |
	//|                                                                                                        |
	//|Em 23.05.2014 a usuaria Danielle pediu que verIficasse o problema da falta do campo "Codigo de Servico" |
	//|pois o mesmo daso nao digitado, exibia a mensagem e ao sair, perdia toda digitacao.                     |
	//|                                                                                                        |
	//|                                                                                                        |
	//+--------------------------------------------------------------------------------------------------------+

	begin sequence

		//-----------------------------------------------------------------------------------
		//A pedido da  Marcelle GEATE o status do pedido sempre serÃ¡ solicitado
		//ao encerrar o protocolo
		//-----------------------------------------------------------------------------------
		If M->ZX_TPINTEL $ "2|4"

			fSetStatPed()

		EndIf

		dbSelectArea(cAlias1)
		RecLock(cAlias1, .F.)

		For i := 1 To FCount()

			IncProc()

			do case

				case "FILIAL"  $ FieldName(i) ; FieldPut(i, xFilial(cAlias1))

				case "DATATE"  $ FieldName(i)

					If M->ZX_TPINTEL $ "2|4" .AND. Empty(SZX->ZX_DATATE)

						FieldPut(i, DATE() )

					EndIf

				case "HORATE"  $ FieldName(i) .AND. Empty(SZX->ZX_HORATE)

					If M->ZX_TPINTEL $ "2|4"

						FieldPut(i, SUBSTR(TIME(),1,2)+SUBSTR(TIME(),4,2) )

					EndIf

				case "DTACOM"  $ FieldName(i)

					If _cAcmp = "4" .AND. M->ZX_TPINTEL $ "2"

						FieldPut(i, DATE() )

					EndIf

				case "HRACOM"  $ FieldName(i)

					If _cAcmp = "4" .AND. M->ZX_TPINTEL $ "2"

						FieldPut(i, SUBSTR(TIME(),1,2)+SUBSTR(TIME(),4,2) )

					EndIf

				otherwise

					FieldPut(i, M->&(Eval(bCampo,i)))

			end case

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

						If aHeader[y][10] != "V"

							FieldPut(FieldPos(Trim(aHeader[y][2])), aCols[i][y])

						EndIf

					Next

				EndIf

				MSUnlock()

			Else

				If !aCols[i][Len(aHeader)+1]

					RecLock(cAlias2, .T.)

					For y := 1 To Len(aHeader)

						If aHeader[y][10] != "V"

							FieldPut(FieldPos(Trim(aHeader[y][2])), aCols[i][y])

						EndIf

					Next

					(cAlias2)->ZY_Filial  := xFilial(cAlias2)
					(cAlias2)->ZY_SEQBA   := (cAlias1)->ZX_SEQ
					(cAlias2)->ZY_SEQSERV := StrZero(nItem, 6, 0)

					MSUnlock()

					nItem++

				EndIf

			EndIf

		Next

	End sequence

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
Static Function ExcDados()

	ProcRegua(Len(aCols)+1)   // +1 e por causa da exclusao do arq. de cabecalho.

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
User Function PA_TudOK()

	Local lRet 		:= .T.
	Local i    		:= 0
	Local nDel 		:= 0
	Local _ni		:= 0
	Local _nPosTp	:= Ascan(aHeader,{|x| AllTrim(x[2]) == "ZY_TIPOSV"		})
	Local _nPosHp	:= Ascan(aHeader,{|x| AllTrim(x[2]) == "ZY_HISTPAD"		})
	Local lGepre	:= .F.

	For i := 1 To Len(aCols)

		If aCols[i][Len(aHeader)+1]

			nDel++

		EndIf

	Next

	If nDel == Len(aCols)

		MsgInfo("Para excluir todos os itens, utilize a opcao EXCLUIR", cCadastro)
		lRet := .F.

	EndIf

	//--------------------------------------------------------------------------
	//Varrendo os itens para ver se todos os campos estao preenchidos
	//Pois alguns PA's estavam sendo incluÃ­dos sem o historico padrao
	//Chamado: 40717
	//--------------------------------------------------------------------------
	For _ni := 1 To Len(aCols)

		If !aCols[_ni][LEN(aCols[_ni])] //Validar somente linha que nao esteja deletada
			If Empty(aCols[_ni][_nPosTp])

				Aviso("Atencao","Campo Tipo de Servico em Branco, favor preencher.",{"OK"})
				lRet := .F.
				Exit

			EndIf

			If Empty(aCols[_ni][_nPosHp])

				Aviso("Atencao","Campo Historico Padrao em Branco, favor preencher.",{"OK"})
				lRet := .F.
				Exit

			EndIf
			
			//-----------------------------------------------------------
			//Projetp PA x Indicação de Rede
			//-----------------------------------------------------------
			If lRet .And. !lGepre

				DbSelectArea("PBL")
				DbSetOrder(1)
				If DbSeek(xFilial("PBL")+aCols[Len(Acols)][_nPosTp])
				
					If PBL->PBL_GERED = '1'
						lGepre := .T.
					EndIf

				EndIf

			EndIf

		EndIf

	Next _ni

	//-----------------------------------------------------------------------------------------------------
	//Validando se o tipo de demanda e informacao para saber se o status do protocolo sera encerrado
	//Chamado: 51516
	//-----------------------------------------------------------------------------------------------------
	If AllTrim(M->ZX_TPDEM) == "I" .And. M->ZX_TPINTEL = "1" .And. lRet

		MsgInfo("Protocolo Informativo, favor mudar o status para encerrado para finalizar!!!", cCadastro)

		lRet := .F.

	EndIf

	If lRet

		If Type("INCLUI") == "U"

			INCLUI := .T.

		EndIf

		If Type("ALTERA") == "U"

			ALTERA := .T.

		EndIf

		If ALTERA
			//Solicitado para que quando alterar forcar o status para em andamento
			M->ZX_TPINTEL = IIF(lRedirect, '3' , M->ZX_TPINTEL)

			M->ZX_STATARE =  IIF(lRedirect , M->ZX_STATARE , '2') //Se for redirecionado nao muda o status

			If (M->ZX_TPINTEL $ '1|3') .AND. !M->ZX_PROB
				U_CAB69DIR()
			EndIf

			u_CABA69A1()

		ElseIf INCLUI

			//-----------------------------------------------------------
			//Rotina utilizada para atualizar linhas do acols
			//com a satisfacao do beneficiario
			//-----------------------------------------------------------
			u_CABA69A1()

		EndIf

	EndIf

	//-----------------------------------------------------------
	//processo de validação do tipo de serviço.
	//visualizando e são de indicação de rede
	//-----------------------------------------------------------
	//Projetp PA x Indicação de Rede
	//-----------------------------------------------------------
	If lRet .And. lGepre

		If Empty(M->ZX_EST)

			lRet := .F.

		ElseIf Empty(M->ZX_CODMUN)

			lRet := .F.

		ElseIf Empty(M->ZX_BAIRRO)

			lRet := .F.

		EndIf

		If !lRet

			Aviso("Atenção","Tipo de serviço utilizado para indicação de rede, favor preencher os campos na aba Indicação de Rede",{"OK"})

		EndIf

	EndIf

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
User Function PAIMPLEG

	Local aLegenda	:= {}

	aLegenda := {{ aCdCores[1,1]		,aCdCores[1,2] },;
		{ aCdCores[2,1]					,aCdCores[2,2] },;
		{ aCdCores[3,1]					,aCdCores[3,2] },;
		{ aCdCores[4,1]					,aCdCores[4,2] }} //Angelo Henrique - Chamado 28286 - Status Em Andamento

	BrwLegenda(cCadastro,"Status" ,aLegenda)

Return

/*
Funcao: PegaCC
Data: 20.08.2012
Objetivo: Retornar centro de Custo e Descricao, a partir do nome do usuario (login)
para preenchimento dos campo ZX_YCUSTO e ZX_YAGENC. Estes campos estao sendo
utilizados no Relatorio de BA (Crystal)- RESBAS.RPT
Author: Otavio Salvador Pinto
Parametros: <_cUsuario> Deve ser informado o login do usuario - Utilizar o cUserName que
retorna o login corrente.
<_nRet> Se 1, retorna o centro de Custo, do contrario retorna a Descricao
*/
User Function PegaCC( _cUsuario, _nRet )

	Local aArea := GetArea()
	Local cRet 	:= ""
	Local cMat 	:= ""
	Local cCC 	:= ""
	Local cQry	:= "" //Angelo Henrique -- Data: 30/05/2017

	_nRet := IIF( _nRet == Nil, 1, _nRet )

	If !Empty( _cUsuario )

		PswOrder(2)
		If PswSeek( _cUsuario, .T. )

			cMat := SUBSTR(PSWRet(1)[1][22],3,8)

			cQry := "SELECT RA_CC FROM SRA010 WHERE D_E_L_E_T_ = ' ' AND RA_FILIAL||RA_MAT = '"+cMat+"'"
			TCQuery cQry Alias "TMPCC" New
			dbSelectArea("TMPCC")
			TMPCC->( dbGoTop() )
			cCC := TMPCC->RA_CC
			TMPCC->( dbCloseArea() )

			cQry := " SELECT CTT_DESC01 FROM CTT010 WHERE D_E_L_E_T_ = ' ' AND CTT_FILIAL = '01' AND CTT_CUSTO = '"+cCC+"'"
			TCQuery cQry Alias "TMPCC" New
			dbSelectArea("TMPCC")
			TMPCC->( dbGoTop() )
			cCCDesc := TMPCC->CTT_DESC01
			TMPCC->( dbCloseArea() )

			cRet := IIF( _nRet == 1, cCC, cCCDesc )

		EndIf

	EndIf

	RestArea(aArea)

return (cRet)

//-------------------------------------------------------------------
/*/{Protheus.doc} RelAted
Rotina utilizada para chamar o relatorio de atendimento
@author  Angelo Henrique
@since   date 30/02/17
@version 1.0
@type function 
/*/
//-------------------------------------------------------------------
User Function RelAted()

	Local _aArea 	:= GetArea()
	Local _aArZX 	:= SZX->(GetArea())

	Private cParams	:= ""

	Private cParIpr	:="1;0;1;Protocolo de Atendimento Presencial"

	cParams := SUBSTR(cEmpAnt,2,1) + ";" + SZX->ZX_SEQ

	CallCrys("PROT_AT",cParams,cParIpr)

	RestArea(_aArZX)
	RestArea(_aArea)

Return

//-------------------------------------------------------------------
/*/{Protheus.doc} CABA69NX
Rotina utilizada para chamar o banco de conhecimento.
@author  Angelo Henrique
@since   date 20/04/18
@version 1.0
@type function
/*/
//-------------------------------------------------------------------

User Function CABA69NX(_cParam)

	Local _aArea 	:= GetArea()
	Local _aArAC9 	:= AC9->(GetArea())
	Local _aArACB 	:= ACB->(GetArea())
	Local cQuery	:= ""
	Local _cChvSZX	:= ""
	Local _cTpInt 	:= ""
	Local _ChvAC9 	:= ""
	Local _ChvWhl	:= ""
	Local _cDtHr	:= ""
	Local _cProto	:= ""

	Default _cParam	:= "1"

	//---------------------------------------------------------------------------------
	//Validando aqui qual e a chamada, pois caso o protocolo seja encerrado
	//e logo em seguida o usuario clique para visualizar o protocolo e por sua
	//vez visualize os documentos anexados, os mesmos nao irao aparecer
	//---------------------------------------------------------------------------------
	If _cParam	<> "2"

		_cTpInt := SZX->ZX_TPINTEL
		_ChvAC9 := SZX->(ZX_FILIAL+ZX_FILIAL+ZX_SEQ+ZX_CODINT+ZX_CODEMP+ZX_MATRIC+ZX_TIPREG+ZX_DIGITO+DTOS(ZX_DATDE)+ZX_HORADE)
		_ChvWhl := AllTrim(SZX->(ZX_FILIAL+ZX_SEQ+ZX_CODINT+ZX_CODEMP+ZX_MATRIC+ZX_TIPREG+ZX_DIGITO+DTOS(ZX_DATDE)+ZX_HORADE))
		_cDtHr	:= SZX->(DTOS(ZX_DATATE)+ZX_HORATE)
		_cProto	:= SZX->ZX_SEQ

	Else

		_cTpInt := M->ZX_TPINTEL
		_ChvAC9 := M->(ZX_FILIAL+ZX_FILIAL+ZX_SEQ+ZX_CODINT+ZX_CODEMP+ZX_MATRIC+ZX_TIPREG+ZX_DIGITO+DTOS(ZX_DATDE)+ZX_HORADE)
		_ChvWhl := AllTrim(M->(ZX_FILIAL+ZX_SEQ+ZX_CODINT+ZX_CODEMP+ZX_MATRIC+ZX_TIPREG+ZX_DIGITO+DTOS(ZX_DATDE)+ZX_HORADE))
		_cDtHr	:= M->(DTOS(ZX_DATATE)+ZX_HORATE)
		_cProto	:= M->ZX_SEQ

	EndIf

	//----------------------------------------------------------------------------
	//SE TIVER ENCERRADO O PROTOCOLO, DEVERA ATUALIZAR OS DOCUMENTOS NA AC9
	//----------------------------------------------------------------------------
	If _cTpInt $ "2|4"

		DbSelectArea("AC9")
		DbSetOrder(2) //AC9_FILIAL+AC9_ENTIDA+AC9_FILENT+AC9_CODENT+AC9_CODOBJ
		If DbSeek(xFilial("AC9") + "SZX" + _ChvAC9)

			cQuery := " UPDATE																				" + c_ent
			cQuery += " 	" + RetSqlName("AC9") + " AC9 													" + c_ent
			cQuery += " SET AC9.AC9_CODENT = '" + SZX->ZX_FILIAL + AllTrim(AC9->AC9_CODENT) + _cDtHr + "'	" + c_ent
			cQuery += " WHERE 																				" + c_ent
			cQuery += " 	AC9.D_E_L_E_T_ = ' ' 	 														" + c_ent
			cQuery += " 	AND AC9.AC9_ENTIDA = 'SZX'  													" + c_ent
			cQuery += " 	AND TRIM(AC9.AC9_CODENT) = '" + AllTrim(_ChvAC9) + "'  							" + c_ent
			cQuery += " 	AND LENGTH(TRIM(AC9.AC9_CODENT)) < 51   										" + c_ent

			TcSqlExec(cQuery)

		EndIf

	EndIf

	//--------------------------------------------------------------------
	//Apos a atualizacao da AC9 validar aqui de onde e a chamada.
	//Caso seja de dentro do protocolo sera possivel somente
	//visualizar os documentos anexados ao PA
	//--------------------------------------------------------------------
	If  _cParam	== "2"		

		//-----------------------------------------------------------------------------------------------
		//NA INCLUSÃO DO PROTOCOLO
		//-----------------------------------------------------------------------------------------------
		//NESSE MOMENTO O BANCO DE CONHECIMENTO NÃO CONSEGUE PEGAR AS INFORMAÇÕES DA MATRICULA
		//FAZENDO ESSE UPDATE CASO SEJA ADICIONADO ALGUM DOCUMENTO NESSE MOMENTO
		//RESTAURANDO ASSIM A CHAVE SEM CONTEMPLAR A MATRICULA
		//-----------------------------------------------------------------------------------------------
		_cChvSZX := SZX->(ZX_FILIAL+ZX_SEQ+ZX_CODINT+ZX_CODEMP+ZX_MATRIC+ZX_TIPREG+ZX_DIGITO+DTOS(ZX_DATDE)+ZX_HORADE+DTOS(ZX_DATATE)+ZX_HORATE)

		cQuery := " UPDATE										" + c_ent
		cQuery += " 	" + RetSqlName("AC9") + " AC9 			" + c_ent
		cQuery += " SET AC9.AC9_CODENT = '" + SZX->ZX_FILIAL + Alltrim(_cChvSZX) + "'		" + c_ent
		cQuery += " WHERE 												" + c_ent
		cQuery += " 	AC9.D_E_L_E_T_ = ' ' 	 						" + c_ent
		cQuery += " 	AND AC9.AC9_ENTIDA = 'SZX'  					" + c_ent
		cQuery += " 	AND AC9.AC9_CODENT LIKE '%" + _cProto + "%'		" + c_ent		

		TcSqlExec(cQuery)

		MsDocument("SZX", SZX->(RECNO()), 4)

		//-----------------------------------------------------------------------------------------------
		//Após a gravação do documento atualizo a chave com a matricula preenchida corretamente 	
		//Para ser visto os documentos anexados após a inclusão do protocolo
		//-----------------------------------------------------------------------------------------------
		cQuery := " UPDATE										" + c_ent
		cQuery += " 	" + RetSqlName("AC9") + " AC9 			" + c_ent
		cQuery += " SET AC9.AC9_CODENT = '" + SZX->ZX_FILIAL + Alltrim(_ChvAC9) + "'		" + c_ent
		cQuery += " WHERE 												" + c_ent
		cQuery += " 	AC9.D_E_L_E_T_ = ' ' 	 						" + c_ent
		cQuery += " 	AND AC9.AC9_ENTIDA = 'SZX'  					" + c_ent
		cQuery += " 	AND AC9.AC9_CODENT LIKE '%" + _cProto + "%'		" + c_ent		

		TcSqlExec(cQuery)		

	Else

		_cChvSZX := SZX->(ZX_FILIAL+ZX_SEQ+ZX_CODINT+ZX_CODEMP+ZX_MATRIC+ZX_TIPREG+ZX_DIGITO+DTOS(ZX_DATDE)+ZX_HORADE+DTOS(ZX_DATATE)+ZX_HORATE)

		MsDocument("SZX", SZX->(RECNO()), 4)

		//------------------------------------------------------------------------------------------------
		//Caso o usuario exclua algum registro, o mesmo sera acrescentado (usuario que deletou e a data)
		//------------------------------------------------------------------------------------------------
		cQuery := " UPDATE																" + c_ent
		cQuery += " 	" + RetSqlName("AC9") + " AC9 									" + c_ent
		cQuery += " SET AC9.AC9_XUSUDE = '" + CUSERNAME + "', 							" + c_ent
		cQuery += " 	AC9.AC9_XDTEXC = '" + DTOS(dDataBase) + "',						" + c_ent
		cQuery += " 	AC9.AC9_HREXC  = '" + STRTRAN(SUBSTR(TIME(),1,5),":","") + "' 	" + c_ent
		cQuery += " WHERE 																" + c_ent
		cQuery += " 	AC9.D_E_L_E_T_ = ' ' 	 										" + c_ent
		cQuery += " 	AND AC9.AC9_ENTIDA = 'SZX'  									" + c_ent
		cQuery += " 	AND AC9.AC9_CODENT = '" + _cChvSZX + "'  						" + c_ent
		cQuery += " 	AND AC9.AC9_XUSUDE = ' '  										" + c_ent
		cQuery += " 	AND AC9.AC9_XDTEXC = ' '  										" + c_ent

		TcSqlExec(cQuery)

	EndIf

	//--------------------------------------------------------------------------------------------------
	//Luiz Otavio Campos - Data: 07/05/2021
	//--------------------------------------------------------------------------------------------------
	//Medida de contorno para atualizar campos da tabeça AC9
	//--------------------------------------------------------------------------------------------------
	fAtuAC9()

	//--------------------------------------------------------------------------------------------------
	//Angelo Henrique - Data: 21/02/2019
	//--------------------------------------------------------------------------------------------------
	//Rotina para transferir os docs do protocolo de atendimento para os doc no nÃ­vel do usuÃ¡rio
	//--------------------------------------------------------------------------------------------------
	TransfDoc(_ChvAC9)
	//--------------------------------------------------------------------------------------------------

	RestArea(_aArea	)
	RestArea(_aArAC9)
	RestArea(_aArACB)

Return

//-------------------------------------------------------------------
/*/{Protheus.doc} CAB69ZZ
Rotina utilizada para chamar o novo historico de protocolo.
@author  Angelo Henrique
@since   date 18/05/18
@type function
@version 1.0
/*/
//-------------------------------------------------------------------
User Function CAB69ZZ(_cParam)

	Local aSize			:= MsAdvSize()
	Local _cUsu			:= ""

	//Atualização Release R27 - P12
	Private oWebEngine 	:= Nil
	Private oWebChannel := Nil
	Private nPort		:= Nil

	Default _cParam		:= "1"

	If _cParam <> "2"

		_cUsu := SZX->(ZX_CODINT + ZX_CODEMP + ZX_MATRIC + ZX_TIPREG + ZX_DIGITO)

	Else

		_cUsu := M->ZX_USUARIO

	EndIf

	DbSelectArea("BA1")
	DbSetOrder(2)
	If DbSeek(xFilial("BA1") + _cUsu)

		DEFINE DIALOG oDlg TITLE "Historico de PA" FROM aSize[7],0 To aSize[6],aSize[5] PIXEL

		// Prepara o conector WebSocket
		oWebChannel := TWebChannel():New()
		nPort := oWebChannel::connect()

		// Cria componente
		oWebEngine := TWebEngine():New(oDlg, 0,0,aSize[3],aSize[5]/3.0,, nPort)
		oWebEngine:bLoadFinished := {|self,url| QOut("Termino da carga do pagina: " + url) }
		oWebEngine:navigate("http://relatorios.caberj.com.br/Administrativo/Paineis/protocoloatend_beneficiario.asp?idCPF=" + BA1->BA1_CPFUSR + "")
		oWebEngine:Align := CONTROL_ALIGN_ALLCLIENT

		//-------------------------------------------------------------------------------------------
		//Após a Virada para a Release 27, o componente TIBrowser foi descontinuado
		//-------------------------------------------------------------------------------------------
		//oTIBrowser := TIBrowser():New(0,0,aSize[3],aSize[5]/3.0, "http://relatorios.caberj.com.br/Administrativo/Paineis/protocoloatend_beneficiario.asp?idCPF=" + BA1->BA1_CPFUSR + "",oDlg )//ajuste no posicionamento

		ACTIVATE DIALOG oDlg CENTERED

	EndIf

Return

//-------------------------------------------------------------------
/*/{Protheus.doc} CABA69AA
Rotina utilizada para chamar a tela de mural apartir do PA.
@author  Angelo Henrique
@since   date 21/05/18
@type function
@version 1.0
/*/
//-------------------------------------------------------------------
User Function CABA69AA()

	Local _aArea := GetArea()

	If !Empty(M->ZX_USUARIO)

		u_TELAMURAL("CABA069")

	Else

		Aviso("Atencao","Nao foi preenchido o beneficiario a ser consultado.",{"OK"})

	EndIf

	RestArea(_aArea)

Return

//-------------------------------------------------------------------
/*/{Protheus.doc} CABA69A1
Rotina utilizada para chamar a tela de pesquisa de satisfacao
@author  Angelo Henrique
@since   date 21/05/18
@version 1.0
@type function 
/*/
//-------------------------------------------------------------------
User Function CABA69A1()

	Local _nPosPq	:= Ascan(aHeader,{|x| AllTrim(x[2]) == "ZY_PESQUIS"		})
	Local _nPosDt	:= Ascan(aHeader,{|x| AllTrim(x[2]) == "ZY_DTSERV"		})
	Local _nOpc		:= 0
	Local oFont1	:= Nil
	Local oFont2	:= Nil
	Local oDlg1		:= Nil
	Local oGrp1		:= Nil
	Local oSay1		:= Nil
	Local oCBox1	:= Nil
	Local oBtn1		:= Nil
	Local _aOpc  	:= {" ","Satisfeito","Insatisfeito"}
	Local cBxOpc	:= _aOpc[1]
	Local _cOpBox	:= ""
	Local _ni		:= 0

	oFont1	:= TFont():New( "MS Sans Serif",0,-19,,.T.,0,,700,.F.,.F.,,,,,, )
	oFont2  := TFont():New( "MS Sans Serif",0,-16,,.F.,0,,400,.F.,.F.,,,,,, )

	oDlg1   := MSDialog():New( 092,232,279,615,"Pesquisa de Satisfacao",,,.F.,,,,,,.T.,,,.T. )
	oGrp1   := TGroup():New( 000,001,084,192,"    Pesquisa de Satisfacao    ",oDlg1,CLR_HBLUE,CLR_WHITE,.T.,.F. )
	oSay1   := TSay():New( 020,005,{||"Selecione a melhor opcao  para este atendimento"},oGrp1,,oFont2,.F.,.F.,.F.,.T.,CLR_HBLUE,CLR_WHITE,184,016)

	oCBox1  := TComboBox():New( 040,005,{|u| If(PCount()>0,cBxOpc:=u,cBxOpc)},_aOpc		,176,014,oGrp1,,{||},,CLR_BLACK,CLR_WHITE,.T.,oFont2,"",,,,,,,cBxOpc )

	oBtn1   := TButton():New( 064,129,"Confirmar",oGrp1,{||_nOpc := 1, oDlg1:End()	},051,012,,oFont2,,.T.,,"",,,,.F. )

	oDlg1:Activate(,,,.T.)

	If _nOpc = 1 .And. cBxOpc != _aOpc[1]

		//-----------------------------------------------------------
		//Validando a informacao correta apos ter sido selecionada
		//-----------------------------------------------------------
		If  cBxOpc == "Satisfeito"

			_cOpBox := "2"

		ElseIf cBxOpc == "Insatisfeito"

			_cOpBox := "3"

		EndIf

		For _ni := 1 To Len(aCols)

			//---------------------------------------------------------------------------------------------------
			//Nao deletado e a data de atualizacao e igual a data das linhas e o campo pesquisa estiver vazio
			//---------------------------------------------------------------------------------------------------
			If !aCols[_ni][Len(aHeader)+1] .And. aCols[_ni][_nPosDt] == dDatabase .And. Empty(aCols[_ni][_nPosPq])

				aCols[_ni][_nPosPq] := _cOpBox

			EndIf

		Next _ni

		//--------------------------------------------------------
		//Atualizando o cabecalho, caso seja diferente
		//--------------------------------------------------------
		If _cOpBox <> M->ZX_PESQUIS // _cOpBox <> M->ZX_PESQUIS .And. !(_cOpBox $ "1")

			M->ZX_PESQUIS := _cOpBox

		EndIf

	Else

		Aviso("Atencao","Favor preencher uma das opcoes informadas",{"OK"})

		U_CABA69A1()

	EndIf

Return

//-------------------------------------------------------------------
/*/{Protheus.doc} CAB69DIR
Rotina utilizada para direcionar o PA  aberto para outra area
@author  Wallace Rodrigues
@since   date 20/02/17
@version 1.0
@type function
/*/
//-------------------------------------------------------------------
User Function  CAB69DIR()

	Local cQuery 	:= ''
	Local oButton1	:= Nil
	Local oWBrowse1	:= Nil
	Local aWBrowse1 := {}
	Local cCodSLA 	:= ''
	Local cTpSrv  	:= ''
	Local oGroup1	:= Nil
	Local oFont12b  := TFont():New("Arial",,-12,.T.,.T.)
	Local oFont12   := TFont():New("Arial",,-12,.T.,.F.)
	Local cCssInfo 	:= "QLabel {color:#004085; background-color: #cce5ff; border-color:#b8daff; padding-top: 10px; padding-left:100px ; border-radius: 4px; }"
	Local cCssBtn 	:= "QPushButton{color:#fff; background-color:#007bff;border-color:#007bff }"

	Private nTipoSv := 0

	If(lRedirect)
		Return
	EndIf

	If SZX->ZX_TPINTEL $ '2|4'
		MSGINFO("Nao e possivel redirecionar um PA encerrado!")
		Return
	EndIf

	If !INCLUI .AND. !ALTERA

		MSGINFO("Nao e possivel redirecionar um PA pela opcao de Visualizar!")
		Return

	EndIf

	//Chama a tela pra perguntar o tipo de redirecionamento
	PERGHIST(@nTipoSv)

	If (nTipoSv = 0)
		Return
	EndIf

	cTpSrv := GetAdvFVal("SZY", "ZY_TIPOSV" , xFilial("SZY")+SZX->ZX_SEQ, 1, "" )

	cCodSla := PADR(SZX->ZX_TPDEM,TAMSX3("PCG_CDDEMA")[1])+SZX->ZX_PTENT+SZX->ZX_CANAL+cTpSrv

	If nTipoSv == 1

		cQuery += " SELECT PCF_COD,PCF_DESCRI, (SELECT PDF_QTDSLA FROM PDF010 PDF WHERE  PDF_CODSLA = '"+(cCodSla)+"' AND PDF_CODARE = PCF_COD AND PDF.D_E_L_E_T_ = ' ' AND PDF.PDF_ARERET = 'F' AND PDF.PDF_AREREC = 'F' ) PDF_QTDSLA  "
		cQuery += " FROM " + RetSqlName("PCF")
		cQuery += " WHERE  D_E_L_E_T_ = ' ' "
		cQuery += " AND PCF_COD NOT IN(SELECT PCF_COD FROM "+RetSqlName("PDF")+" PDF INNER JOIN " + RetSqlName("PCF") +" PCF ON PDF_CODARE = PCF_COD WHERE  PDF_CODSLA = '"+(cCodSla)+"' AND PDF.D_E_L_E_T_ = ' ' AND PDF.PDF_ARERET = 'T' AND PDF.PDF_AREREC = 'F' )   "
		cQuery += " AND PCF_COD NOT IN(SELECT PCF_COD FROM "+RetSqlName("PDF")+" PDF INNER JOIN " + RetSqlName("PCF") +" PCF ON PDF_CODARE = PCF_COD WHERE  PDF_CODSLA = '"+(cCodSla)+"' AND PDF.D_E_L_E_T_ = ' ' AND PDF.PDF_ARERET = 'T' AND PDF.PDF_AREREC = 'F' )   "
		cQuery += " AND PCF_TFAREA = '1' "
	Else

		cQuery += "SELECT PCF_COD,PCF_DESCRI, (SELECT PDF_QTDSLA FROM PDF010 PDF WHERE  PDF_CODSLA = '"+(cCodSla)+"' AND PDF.D_E_L_E_T_ = ' ' AND PDF.PDF_ARERET = 'T' AND PDF.PDF_AREREC = 'F' )PDF_QTDSLA                         "
		cQuery += "FROM " + RetSqlName("PCF")
		cQuery += "WHERE  D_E_L_E_T_ = ' ' "
		cQuery += "AND PCF_COD NOT IN(SELECT PCF_COD FROM "+RetSqlName("PDF")+" PDF INNER JOIN "+ RetSqlName("PCF")+" PCF ON PDF_CODARE = PCF_COD WHERE  PDF_CODSLA = '"+(cCodSla)+"' AND PDF.D_E_L_E_T_ = ' ' AND PDF.PDF_ARERET = 'T' AND PDF.PDF_AREREC = 'F' ) "
		cQuery += " AND PCF_TFAREA = '1' "
	EndIf

	cQuery := ChangeQuery(cQuery)

	cAliasQuery := MpSysOpenQuery(cQuery)

	If !(cAliasQuery)->(Eof())

		While !(cAliasQuery)->(Eof())
			aAdd( aWBrowse1, { (cAliasQuery)->PCF_COD,(cAliasQuery)->PCF_DESCRI, (cAliasQuery)->PDF_QTDSLA  } )
			(cAliasQuery)->(dbSkip())
		EndDo

	Else

		aAdd( aWBrowse1, { '','Nenhum registro encontrado!',''  } )

	EndIf

	DEFINE MSDIALOG oDlg TITLE "Direcionamento de PA" FROM 000, 000  TO 300, 450 COLORS 0, 16777215 PIXEL

	@ 026, 003 GROUP oGroup1 TO 145, 222 PROMPT "areas " OF oDlg COLOR 0, 16777215 PIXEL

	@ 039, 010 LISTBOX oWBrowse1 Fields HEADER "Codigo ","Descricao", "SLA" SIZE 207, 086  FONT oFont12  OF oDlg PIXEL ColSizes 50,50

	oWBrowse1:SetArray(aWBrowse1)
	oWBrowse1:bLine := {|| { aWBrowse1[oWBrowse1:nAt,1], aWBrowse1[oWBrowse1:nAt,2],  aWBrowse1[oWBrowse1:nAt,3] }}

	oWBrowse1:bLDblClick := {|| fRedirect(aWBrowse1[oWBrowse1:nAt,1], aWBrowse1[oWBrowse1:nAt,3]), oDlg:End() }

	@ 006, 004 SAY oSay1 PROMPT "areas disponiveis para redirecionamento" SIZE 215, 017 FONT oFont12b OF oDlg COLORS 0, 16777215 PIXEL
	@ 127, 166 BUTTON oButton1 PROMPT "Direcionar" SIZE 050, 015 FONT oFont12b  OF oDlg ACTION fRedirect(aWBrowse1[oWBrowse1:nAt,1], aWBrowse1[oWBrowse1:nAt,3]) PIXEL

	oButton1:SetCSS(cCssBtn)

	oSay1:SetCSS(cCSSinfo)

	ACTIVATE MSDIALOG oDlg CENTERED

	(cAliasQuery)->(dbCloseArea())

Return

/*/{Protheus.doc} fRedirect
	Relacionamento de PA
	@type  Function
	@author Wallace
	@since date 20/02/2017
	@version 1.0	
/*/
Static Function fRedirect(cArea,cSla)

	Local aArea 		:= GetArea()
	Local cCodSla		:= ""
	Local cDesArea 		:= ''
	Local cAreaAnterior := SZX->ZX_AREATU
	Local cTpSrv 		:= GetAdvFVal("SZY", "ZY_TIPOSV" , xFilial("SZY")+SZX->ZX_SEQ, 1, "" )

	cCodSla  := PADR(SZX->ZX_TPDEM,TAMSX3("PCG_CDDEMA")[1])+SZX->ZX_PTENT+SZX->ZX_CANAL+cTpSrv
	cDesArea := GetAdvFVal("PCF","PCF_DESCRI",xFilial("PCF")+cArea,1,"")

	If MSGYESNO( "Confirma redirecionamento da PA ?", "Confirmacao" )

		U_CABDIROBS()

		If ALTERA

			M->ZX_AREATU = cArea

			M->ZX_STATARE = '1'

		Else

			If RecLock("SZX",.F.)

				SZX->ZX_AREATU = cArea

				SZX->ZX_STATARE = '1'

				MSUNLOCK()

			EndIf

			RestArea(aArea)

		EndIf

		MsgInfo("Protocolo direcionado com sucesso!","Direcionamento")

		fGravaHist(cArea,cAreaAnterior,cCodSla)

		oDlg:End()

		lCancel := .F.

		lRedirect := .T.

	EndIf

Return

//-------------------------------------------------------------------
/*/{Protheus.doc} CAB69HIS
Exibe direcionamento
@author  Wallace
@since   date 20/06/2017
@version 1.0
@type function
/*/
//-------------------------------------------------------------------
User Function CAB69HIS(cHist)


	Local oFont     	:= TFont():New( "Arial",,-12,.T.)
	Static oDlg			:= Nil
	Local aGroups 		:= {}
	Local aSays	  		:= {}
	Local AOBJS 		:= {}
	Local cQuery 		:= ""
	Local nCont 		:= 0
	Local aSizeEsq 		:= {5,5,50}
	Local nHeight 		:= 200
	Local nY 			:= 0
	Local nCorRed 		:= 255
	Local nCorVerde 	:= 32768
	Local nCorNormal	:= 0
	Local nCor 			:= 0

	cQuery += " SELECT 										" + c_ent
	cQuery += " 	PDG_SEQ PROTOCOLO, 						" + c_ent
	cQuery += " 	PDG_AREANT ARANTERIOR, 					" + c_ent
	cQuery += " 	PDG_AREATU ARATUAL, 					" + c_ent
	cQuery += " 	PDG_DTREG DATA, 						" + c_ent
	cQuery += " 	PDG_SLAARE SLA, 						" + c_ent
	cQuery += " 	PDG_SLATOT SLATOT,						" + c_ent
	cQuery += " 	PDG_HORA HORA , 						" + c_ent
	cQuery += " 	PDG_USR USUARIO , 						" + c_ent
	cQuery += " 	PDG_QTDDIA DIAS							" + c_ent
	cQuery += " FROM 										" + c_ent
	cQuery += " 	PDG010 PDG 								" + c_ent
	cQuery += " WHERE    									" + c_ent
	cQuery += " 	PDG.D_E_L_E_T_ = ' ' 					" + c_ent
	cQuery += " 	AND PDG.PDG_SEQ  = '" + SZX->ZX_SEQ + "'" + c_ent
	cQuery += " ORDER BY R_E_C_N_O_  						" + c_ent

	cQuery := ChangeQuery(cQuery)

	cAliasQuery := MpSysOpenQuery(cQuery)

	If !(cAliasQuery)->(Eof())

		While !(cAliasQuery)->(Eof())

			nCont++

			AADD(aGroups,Nil)
			AADD(aSays,{Nil,Nil,Nil,Nil,Nil,Nil,Nil,Nil,Nil,Nil,Nil,Nil,Nil,Nil,Nil,Nil})

			cData :=  DTOC(STOD((cAliasQuery)->DATA))
			cHora := (cAliasQuery)->HORA
			cUsuario := (cAliasQuery)->USUARIO
			cAreaAnterior := GetAdvFVal("PCF", "PCF_DESCRI" , xFilial("PCF")+(cAliasQuery)->ARANTERIOR, 1, "" )
			cAreaAtual := GetAdvFVal("PCF", "PCF_DESCRI" , xFilial("PCF")+(cAliasQuery)->ARATUAL, 1, "" )
			cQtdDias :=  CVALTOCHAR((cAliasQuery)->DIAS)
			cQtdSLA := CVALTOCHAR((cAliasQuery)->SLA)
			cSaldoSLA := CVALTOCHAR((cAliasQuery)->SLATOT)

			If VAL(cQtdDias) > VAL(cQtdSLA)
				nCor := nCorRed
			ElseIf VAL(cQtdDias) == VAL(cQtdSLA)
				nCor := nCorNormal
			Else
				nCor := nCorVerde
			EndIf

			AADD(aObjs,{ cData ,;
				&('{|| "'+cHora+'"}'),;
				&('{|| "'+cAreaAnterior+'"}'),;
				&('{|| "'+cAreaAtual+'"}'),;
				&('{|| "'+cQtdDias+'"}'),;
				&('{|| "'+cQtdSLA+'"}'),;
				&('{|| "'+CVALTOCHAR(SZX->ZX_SLA)+'"}'),;
				&('{|| "'+cUsuario+'"}'),;
				nCor,;
				&('{|| "'+cSaldoSLA+'"}'),;
				&('{|| "'+SZX->ZX_YAGENC+'"}'),;
				})

			(cAliasQuery)->(DbSkip())

		Enddo
	Else

		MsgInfo("Protocolo sem informacoes de direcionamento!")

		Return

	EndIf

	nHeight := IIF (nCont > 3 , nCont * 60 ,nHeight)

	DEFINE MSDIALOG oDlg TITLE "Historico de Movimentacao  " FROM 000, 000  TO 450, 800 COLORS 0, 16777215 PIXEL
	oScroll := TScrollArea():New(oDlg,01,01,100,100)
	oScroll:Align := CONTROL_ALIGN_ALLCLIENT
	oPanel := TPanelCss():New(000,000,nil,oScroll,nil,nil,nil,nil,nil,100,nHeight,nil,nil)

	oScroll:SetFrame( oPanel )
	For nY := 1 To nCont

		aGroups[nY]:= tGroup():New(aSizeEsq[1],aSizeEsq[2], aSizeEsq[3],393,aObjs[nY][1],oPanel,0,aObjs[nY][9],.T.)

		aGroups[nY]:oFont := oFont

		aSizeEsq[1] += 10

		aSays[nY][1] := TSay():New( aSizeEsq[1] ,010, {|| "Horario:"				} 	,aGroups[nY],,oFont,.F.,.F.,.F.,.T.,aObjs[nY][9],CLR_WHITE)

		aSays[nY][2] := TSay():New( aSizeEsq[1] ,035, aObjs[nY][2]   					,aGroups[nY],,oFont,.F.,.F.,.F.,.T.,aObjs[nY][9],CLR_WHITE)

		aSays[nY][3] := TSay():New( aSizeEsq[1] ,100, {|| "Area Responsavel:"  		} 	,aGroups[nY],,oFont,.F.,.F.,.F.,.T.,aObjs[nY][9],CLR_WHITE)
		aSays[nY][4] := TSay():New( aSizeEsq[1] ,155, aObjs[nY][11]						,aGroups[nY],,oFont,.F.,.F.,.F.,.T.,aObjs[nY][9],CLR_WHITE)

		aSays[nY][3] := TSay():New( aSizeEsq[1] ,210, {|| "Area Anterior:"  		} 	,aGroups[nY],,oFont,.F.,.F.,.F.,.T.,aObjs[nY][9],CLR_WHITE)
		aSays[nY][4] := TSay():New( aSizeEsq[1] ,250, aObjs[nY][3]						,aGroups[nY],,oFont,.F.,.F.,.F.,.T.,aObjs[nY][9],CLR_WHITE)

		aSays[nY][5] := TSay():New( aSizeEsq[1] ,310, {|| "Area Atual:" 			} 	,aGroups[nY],,oFont,.F.,.F.,.F.,.T.,aObjs[nY][9],CLR_WHITE)
		aSays[nY][6] := TSay():New( aSizeEsq[1] ,340, aObjs[nY][4]						,aGroups[nY],,oFont,.F.,.F.,.F.,.T.,aObjs[nY][9],CLR_WHITE)

		aSizeEsq[1] += 10

		aSays[nY][7] := TSay():New( aSizeEsq[1] ,010, {|| "Dias na area:" 			} 	,aGroups[nY],,oFont,.F.,.F.,.F.,.T.,aObjs[nY][9],CLR_WHITE)
		aSays[nY][8] := TSay():New( aSizeEsq[1] ,055, aObjs[nY][5] 						,aGroups[nY],,oFont,.F.,.F.,.F.,.T.,aObjs[nY][9],CLR_WHITE)

		aSays[nY][9] := TSay():New( aSizeEsq[1] ,100, {|| "SLA da area:" 			} 	,aGroups[nY],,oFont,.F.,.F.,.F.,.T.,aObjs[nY][9],CLR_WHITE)
		aSays[nY][10] := TSay():New( aSizeEsq[1] ,140, aObjs[nY][6]						,aGroups[nY],,oFont,.F.,.F.,.F.,.T.,aObjs[nY][9],CLR_WHITE)

		aSays[nY][11] := TSay():New( aSizeEsq[1] ,210, {|| "SLA Total:" 			} 	,aGroups[nY],,oFont,.F.,.F.,.F.,.T.,aObjs[nY][9],CLR_WHITE)
		aSays[nY][12] := TSay():New( aSizeEsq[1] ,250, aObjs[nY][7]						,aGroups[nY],,oFont,.F.,.F.,.F.,.T.,aObjs[nY][9],CLR_WHITE)

		aSays[nY][13] := TSay():New( aSizeEsq[1] ,310, {|| "Saldo SLA:" 			} 	,aGroups[nY],,oFont,.F.,.F.,.F.,.T.,aObjs[nY][9],CLR_WHITE)
		aSays[nY][14] := TSay():New( aSizeEsq[1] ,350, aObjs[nY][10]					,aGroups[nY],,oFont,.F.,.F.,.F.,.T.,aObjs[nY][9],CLR_WHITE)

		aSizeEsq[1] += 10

		If nY == 1
			aSays[nY][15] := TSay():New( aSizeEsq[1] ,010, {|| "Direcionado por:" 	} 	,aGroups[nY],,oFont,,,,.T.,aObjs[nY][9],CLR_WHITE)
		Else
			aSays[nY][15] := TSay():New( aSizeEsq[1] ,010, {|| "Redirecionado por:"	}	,aGroups[nY],,oFont,,,,.T.,aObjs[nY][9],CLR_WHITE)
		EndIf

		aSays[nY][16] := TSay():New( aSizeEsq[1] ,070, aObjs[nY][8] ,aGroups[nY],,oFont,,,,.T.,aObjs[nY][9])

		aSizeEsq[1] += 25
		aSizeEsq[3] += 55

	Next

	ACTIVATE MSDIALOG oDlg CENTERED

Return

//-------------------------------------------------------------------
/*/{Protheus.doc} fGravaHist
Grava histórico
@author  Wallace
@since   date 20/06/2017
@version 1.0
@type function
/*/
//-------------------------------------------------------------------
Static Function fGravaHist(cArea,cAreaAnterior,cCodSla)

	Local aArea 	:= GetArea()
	Local cUpd 		:= ""
	Local cCodUser 	:= RetCodUsr()
	Local nDif 		:= 0
	Local nSaldo 	:= 0
	Local cSla 		:= GetAdvFVal("PDF","PDF_QTDSLA",xFilial("PDF")+cCodSla,1,0)
	Local cQry 		:= " SELECT * FROM "+RetSqlName("PDG")+"  WHERE PDG_SEQ  = '"+ SZX->ZX_SEQ +"' AND ROWNUM = 1 AND  D_E_L_E_T_ = ' ' ORDER BY R_E_C_N_O_  DESC  "

	cAliasPDG := MpSysOpenQuery(cQry)

	If !(cAliasPDG)->(Eof())

		cQry := "SELECT PDF_QTDSLA  FROM "+RetSqlName("PDF")+" WHERE PDF_CODSLA = '"+cCodSla+"' AND PDF_AREREC = 'F' AND PDF_ARERET = 'F' AND PDF_CODARE = '"+cArea+"' AND D_E_L_E_T_ = ' ' "

		cAliasPDF := MpSysOpenQuery(cQry)

		If !(cAliasPDF)->(Eof())
			cSla := (cAliasPDF)->PDF_QTDSLA
		EndIf

		nDif := U_zDiasUteis(	STOD((cAliasPDG)->PDG_DTREG), DATE())

		nSaldo := (cAliasPDG)->PDG_SLATOT - nDif

		cUpd += " UPDATE "+RetSqlName("PDG")+" SET PDG_QTDDIA = '"+cVALTOCHAR(nDif)+"'  WHERE R_E_C_N_O_ = '"+CVALTOCHAR((cAliasPDG)->R_E_C_N_O_)+"' "
		nStatus := TCSqlExec(cUpd)

		If (nStatus < 0)
			QOut("TCSQLError() " + TCSQLError())
		endif
	Else

		cQry := "SELECT PDF_QTDSLA  FROM "+RetSqlName("PDF")+" WHERE PDF_CODSLA = '"+cCodSla+"' AND PDF_AREREC = 'T' AND D_E_L_E_T_ = ' ' "

		cAliasPDF := MpSysOpenQuery(cQry)

		If !(cAliasPDF)->(Eof())
			cSla := (cAliasPDF)->PDF_QTDSLA
		EndIf

		nSaldo := fGetSla(cCodSla)

	EndIf

	RestArea(aArea)

	RecLock("PDG",.T.)
	PDG->PDG_SEQ  	:= SZX->ZX_SEQ
	PDG->PDG_AREANT := cAreaAnterior
	PDG->PDG_AREATU := cArea
	PDG->PDG_DTREG  := DATE()
	PDG->PDG_USR  	:= UsrRetName( cCodUser )
	PDG->PDG_HORA  	:= SUBSTR(TIME(), 1, 5)
	PDG->PDG_SLAARE := cSla
	PDG->PDG_SLATOT := nSaldo
	MSUNLOCK()

Return

//-------------------------------------------------------------------
/*/{Protheus.doc} CAB69OBS
	Rotina utilizada para gravar justificativas de atraso da PA 
	somente gestores
@author  Anderson Rangel
@since   12/12/21
@version 2.0
@type function 
/*/
//-------------------------------------------------------------------
User Function  CAB69OBS()

	Local cCodUsr 		:= RetCodUsr()
	Local cArea 		:= ""
	Local cGestor 		:= ""
	Local lSlaNegativo 	:= .F.
	Local lFind			:= .F.
	Local oMultiGe1		:= Nil
	Local cMultiGe1 	:= ""
	Local lInc 			:= Empty(cMultiGe1)
	Local cQuery 		:= ""
	Local nPos1			:= 0
	Local nPos2			:= 0
	Local aButtons 		:= {}
	Local aTpcf			:= {}
	Local aTpcftemp		:= {}

	Static oDlgObs		:= Nil

	cQuery += "SELECT PCF_COD, PCF_GESTOR FROM PCF010 WHERE D_E_L_E_T_ = ' ' ORDER BY 1"

	cAliasPCF := MpSysOpenQuery(cQuery)
	(cAliasPCF)->(DbGoTop())

	while !(cAliasPCF)->(Eof())
		aTpcftemp := StrTokArr(alltrim((cAliasPCF)->PCF_GESTOR), ";" )
		AADD(aTpcf,{(cAliasPCF)->PCF_COD, aTpcftemp })
		(cAliasPCF)->(DbSkip())
	end

	If !lFind
		For nPos1 := 1 To Len(aTpcf)
			For nPos2 := 1 To Len(aTpcftemp)
				IF alltrim(aTpcf[nPos1,2,nPos2]) == cCodUsr
					cArea 	:=  aTpcf[nPos1,1]
					cGestor	:=  alltrim(aTpcf[nPos1,2,nPos2])
					lFind	:= .T.
				EndIf
			Next
		Next
	else
		MsgInfo(OemToAnsi("Funcão só pode ser utilizada pelos gestores da área em que o Protocolo foi aberto!"))
		Return
	EndIf

	dbSelectArea("PDH")
	dbSetOrder(1)
	If dbSeek(xFilial("PDH")+(SZX->ZX_SEQ)+alltrim(cArea))
		cMultiGe1 := PDH->PDH_OBS
		lInc := .F.
	else
		lInc := .T.
	EndIf

	cQuery := "SELECT 																							"+c_ent
	cQuery += "DECODE(TRIM(ZX.ZX_SLA),NULL,'X',ZX.ZX_SLA) - 													"+c_ent
	cQuery += "(TRUNC(((N_HORAS_UTEIS_PERIODO(TO_DATE(TRIM(ZX_DATDE ||ZX_HORADE),'YYYYMMDDHH24MI'), 			"+c_ent
	cQuery += "NVL(TO_DATE(TRIM(ZX_DATATE||ZX_HORATE),'YYYYMMDDHH24MI'), SYSDATE)) /9)/60),0)) DIASEX			"+c_ent
	cQuery += "FROM "+RetSqlName("SZX")+" ZX																	"+c_ent
	cQuery += "WHERE TRIM(ZX.ZX_SEQ) = '"+SZX->ZX_SEQ+"' AND TRIM(ZX_CODAREA) = '"+cArea+"'						"+c_ent
	cQuery += "AND ZX.ZX_FILIAL = '"+xfilial("SZX")+"' AND ZX.D_E_L_E_T_ = ' '    								"+c_ent

	cAliasSZX :=  MpSysOpenQuery(cQuery)
	(cAliasSZX)->(DbGoTop())

	If !(cAliasSZX)->(Eof())
		IF (cAliasSZX)->DIASEX < 0
			MsgAlert("entrou")
			lSlaNegativo := .T.
		endIf
	EndIf

	If !(lSlaNegativo)

		oModalJust := FWDialogModal():New()
		oModalJust:SetEscClose(.F.)
		oModalJust:setTitle("Justificativa para Protocolo Expirado")

		AADD(aButtons,{,"Salvar",{|| GravaJust(cMultiGe1, cArea, lInc) }, "", ,.T.,.F.   })
		AADD(aButtons,{,"Cancelar",{|| oModalJust:OOWNER:End() }, "", ,.T.,.F.})

		//Seta a largura e altura da janela em pixel
		oModalJust:setSize(170, 210)

		oModalJust:createDialog()

		oModalJust:addButtons(aButtons)

		oContainer := TPanel():New( ,,, oModalJust:getPanelMain() )

		oContainer:Align := CONTROL_ALIGN_ALLCLIENT

		@ 015, 008 GET oMultiGe1 VAR cMultiGe1 OF oContainer MULTILINE SIZE 192, 091 COLORS 0, 16777215 HSCROLL PIXEL

		oModalJust:Activate()

	Else

		MsgAlert("Para inserir a justificativa o Protocolo deve estar com o SLA expirado!")

	EndIf

Return

/*/{Protheus.doc} GravaJust
	Grava justificativa
	@type  Function
	@author Wallace
	@since date 20/06/2017
	@version 1.0	
/*/
Static Function GravaJust(cMsg,cArea,lInc)

	Local aArea := GetArea()

	If MsgYesNo("Confirma a gravacao das informacoes ?", "Confirmacao")

		RecLock("PDH",lInc)

		PDH->PDH_SEQ := SZX->ZX_SEQ
		PDH->PDH_CODARE := cArea
		PDH->PDH_OBS := AllTrim(cMsg)
		PDH->PDH_DTHOR := dToC(date()) + Space(1) + Time()

		MsUnlock()

		MsgInfo("Justificativa gravada com sucesso!")
		oModalJust:OOWNER:End()

	EndIf

	RestArea(aArea)

Return

/*/{Protheus.doc} PERGHIST
	Redirecionamento
	@type  Function
	@author Wallace
	@since date 20/06/2017
	@version 1.0	
/*/
Static Function PERGHIST(nVal)

	Local oFont12b     := TFont():New("Arial",,-12,.T.,.T.)
	Local oFont12     := TFont():New("Arial",,-12,.T.,.F.)
	Local cCssA := "QLabel {color:#721c24; background-color: #f8d7da; border-color:#f5c6cb; padding-top: 5px; padding-left:18px ; border-radius: 4px; }"
	Local cCssC := "QLabel {color:#212529; background-color: #f8f9fa; border-color:#f8f9fa; padding-top: 5px; padding-left:18px ; border-radius: 4px; }"
	Local cCssB := "QPushButton{color:#fff; background-color:#007bff;border-color:#007bff }"
	Local oButton1
	Local nListBox1 := ''
	Local oSay


	Static oDlgPerg

	DEFINE MSDIALOG oDlgPerg TITLE "Redirecionamento" FROM 000, 000  TO 220, 320 COLORS 0, 16777215 PIXEL

	@ 008, 007 SAY oSay PROMPT "Por favor informe o tipo de redirecionamento" SIZE 146, 015 FONT oFont12b OF oDlgPerg  COLORS 0, 14342136 PIXEL
	@ 087, 106 BUTTON oButton1 PROMPT "Confirmar" SIZE 050, 015 FONT oFont12b OF oDlgPerg ACTION  { || fAltePerg(nListBox1)}  PIXEL
	@ 087, 051 BUTTON oButton2 PROMPT "Manter" SIZE 050, 015  FONT oFont12b OF oDlgPerg ACTION oDlgPerg:End() PIXEL
	@ 039, 004 LISTBOX oListBox1 VAR nListBox1 ITEMS {"Redirecionamento p/ outra area","Redirecionamento p/ Retorno/Encerramento"} SIZE 152, 036 FONT oFont12 OF oDlgPerg  COLORS 0, 16777215 PIXEL

	oSay:SetCSS(cCssA)
	oButton1:SetCSS(cCssB)
	oButton2:SetCSS(cCssC)
	oDlgPerg:lEscClose := .F.

	ACTIVATE MSDIALOG oDlgPerg CENTERED

Return

/*/{Protheus.doc} fAltePerg
	Tipo de redirecionamento
	@type  Function
	@author Wallace
	@since date 20/06/2017
	@version 1.0	
/*/
Static Function fAltePerg(cCod)

	IF( Empty(cCod) )

		MsgInfo("Favor informar o tipo do redirecionamento!!")

	Else

		nTipoSv := IIF(cCod == "Redirecionamento p/ outra area",1,2)

		oDlgPerg:End()

	EndIf

Return nil

/*/{Protheus.doc} fGetSla
	(Obter a quantidade de SLA da area)
	@type  Function
	@author Wallace
	@since date 20/06/2017	
/*/
Static Function fGetSla(cSla)

	local nQtdSla := 0
	local cQuery := ""

	cQuery := "SELECT PCG_QTDSLA SLA FROM "+RetSqlName("PCG")+" WHERE PCG_CDDEMA||PCG_CDPORT||PCG_CDCANA||PCG_CDSERV = '"+cSla+"' AND D_E_L_E_T_ = ' ' "

	cAliasPCG := MpSysOpenQuery(cQuery)

	If !(cAliasPCG)->(Eof())
		nQtdSla := (cAliasPCG)->SLA
	EndIf

Return nQtdSla

//-------------------------------------------------------------------
/*/{Protheus.doc} CAB69COB
Solicitar cobrança
@author  Wallace
@since   20/06/2017
@version 1.0
@type function 
/*/
//-------------------------------------------------------------------
User Function CAB69COB

	Local oMultiGe1	:= Nil
	Local cMultiGe1 := Space(2000)
	Local aButtons 	:= {}

	Static oDlg		:= Nil

	If !INCLUI .AND. !ALTERA

		MSGINFO("Nao e possivel cobrar um PA pela opcao de Visualizar!")
		Return

	EndIf

	oModal  := FWDialogModal():New()
	oModal:SetEscClose(.F.)
	oModal:setTitle("Solicitar Cobranca")

	AADD(aButtons,{,"Salvar",{|| fGravaCob(cMultiGe1) }, "", ,.T.,.F.   })
	AADD(aButtons,{,"Cancelar",{|| oModal:OOWNER:End() }, "", ,.T.,.F.})

	//Seta a largura e altura da janela em pixel
	oModal:setSize(170, 210)

	oModal:createDialog()

	oModal:addButtons(aButtons)

	oContainer := TPanel():New( ,,, oModal:getPanelMain() )

	oContainer:Align := CONTROL_ALIGN_ALLCLIENT

	@ 015, 008 GET oMultiGe1 VAR cMultiGe1 OF oContainer MULTILINE SIZE 192, 091 COLORS 0, 16777215 HSCROLL PIXEL

	oModal:Activate()

Return

/*/{Protheus.doc} fGravaCob
	Grava cobrança
	@type  Function
	@author Wallace
	@since 20/06/2017
	@version 1.0	
/*/
Static Function  fGravaCob(cText)

	Local cQry 	:= ""
	Local cMsg 	:= AllTrim(cText)
	Local aMsgs := {}
	Local fY	:= 0

	If MSGYESNO( "Confirma solicitacao de cobranca?", "Confirmacao" )

		DbSelectArea("SZY")

		cQry += " SELECT * FROM "+RetSqlName("SZY")+" WHERE ZY_SEQBA = '"+SZX->ZX_SEQ+"' AND ROWNUM = 1 AND  D_E_L_E_T_ = ' ' ORDER BY R_E_C_N_O_  DESC "

		cAliasZY := MpSysOpenQuery(cQry)

		If !(cAliasZY)->(Eof())

			If Len(cMsg) > 512

				AADD(aMsgs, SUBSTR(cMsg,1,511) )

				AADD(aMsgs, SUBSTR(cMsg,512,511) )

			Else

				AADD(aMsgs, cMsg)

			EndIf

			For fY := 1 To Len(aMsgs)

				RecLock("SZY",.T.)

				SZY->ZY_SEQBA 	:= SZX->ZX_SEQ
				SZY->ZY_SEQSERV :=  U_GetSZYSeq(SZX->ZX_SEQ)//  Soma1(cSeq)
				SZY->ZY_SEQCTRL := SZX->ZX_SEQ
				SZY->ZY_DTSERV 	:= DATE()
				SZY->ZY_HORASV 	:=  Replace(SUBSTR(TIME(),1,5),":","")
				SZY->ZY_TIPOSV 	:= (cAliasZY)->ZY_TIPOSV
				SZY->ZY_OBS 	:= aMsgs[fY]
				SZY->ZY_HISTPAD := '000078'
				SZY->ZY_DTRESPO := DATE()
				SZY->ZY_HRRESPO :=  Replace(SUBSTR(TIME(),1,5),":","")
				SZY->ZY_RESPOST := (cAliasZY)->ZY_RESPOST
				SZY->ZY_USDIGIT := ALLTRIM(UsrRetName(__cUserId))
				SZY->ZY_LOGRESP := ALLTRIM(UsrRetName(__cUserId))

				MsUnlock()

			Next

			fSendMailCob(SZX->ZX_AREATU,cMsg)

			CriaCols(4)

			GETDREFRESH()
			SetFocus(oGetDad:oBrowse:hWnd) // Atualizacao por linha
			oGetDad:Refresh()

			MsgInfo("Cobranca incluÃ­da com sucesso!")

			oModal:OOWNER:End()

		EndIf

	EndIf

Return

//-------------------------------------------------------------------
/*/{Protheus.doc} CABDIROBS
Observações 
@author  Wallace
@since   20/06/2017
@version 1.0
@type function 
/*/
//-------------------------------------------------------------------
User Function CABDIROBS()

	Local oMultiGe1	:= Nil
	Local cMultiGe1 := Space(1000)
	Local aButtons 	:= {}

	Static oDlg		:= Nil

	oModal  := FWDialogModal():New()
	oModal:SetEscClose(.F.)
	oModal:setTitle("Observacoes do direcionamento")

	AADD(aButtons,{,"Salvar",{|| fGravaObsDir(cMultiGe1) }, "", ,.T.,.F.   })

	//Seta a largura e altura da janela em pixel
	oModal:setSize(170, 210)

	oModal:createDialog()

	oModal:addButtons(aButtons)

	oContainer := TPanel():New( ,,, oModal:getPanelMain() )

	oContainer:Align := CONTROL_ALIGN_ALLCLIENT

	@ 015, 008 GET oMultiGe1 VAR cMultiGe1 OF oContainer MULTILINE SIZE 192, 091 COLORS 0, 16777215 HSCROLL PIXEL

	oMultiGe1:SetFocus()

	oModal:Activate()

Return

/*/{Protheus.doc} fGravaObsDir(cMsg)
	Grava observação do direcionamento
	@type  Function
	@author Wallace
	@since 20/06/2017
	@version 1.0	
/*/
Static Function fGravaObsDir(cText)

	Local cQry 	:= ""
	Local cMsg 	:= AllTrim(cText)
	Local aMsgs :={}
	Local fY	:= 0

	DbSelectArea("SZY")

	cQry += " SELECT * FROM "+RetSqlName("SZY")+" WHERE ZY_SEQBA = '"+SZX->ZX_SEQ+"' AND ROWNUM = 1 AND  D_E_L_E_T_ = ' ' ORDER BY R_E_C_N_O_  DESC "

	cAliasZY := MpSysOpenQuery(cQry)

	If !(cAliasZY)->(Eof())

		If Len(cMsg) > 512

			AADD(aMsgs, SUBSTR(cMsg,1,511) )

			AADD(aMsgs, SUBSTR(cMsg,512,511) )

		Else

			AADD(aMsgs, cMsg)

		EndIf

		For fY := 1 To Len(aMsgs)

			RecLock("SZY",.T.)

			SZY->ZY_SEQBA 	:= SZX->ZX_SEQ
			SZY->ZY_SEQCTRL := SZX->ZX_SEQ
			SZY->ZY_SEQSERV := U_GetSZYSeq(SZX->ZX_SEQ)// Soma1(cSeq)
			SZY->ZY_DTSERV 	:= DATE()
			SZY->ZY_HORASV 	:=  Replace(SUBSTR(TIME(),1,5),":","")
			SZY->ZY_TIPOSV 	:= (cAliasZY)->ZY_TIPOSV
			SZY->ZY_OBS 	:= aMsgs[fY]
			SZY->ZY_HISTPAD := '000078'
			SZY->ZY_USDIGIT := ALLTRIM(UsrRetName(__cUserId))

			MsUnlock()

		Next

		CriaCols(4)

		GETDREFRESH()
		SetFocus(oGetDad:oBrowse:hWnd) // Atualizacao por linha
		oGetDad:Refresh()

		oModal:OOWNER:End()

	EndIf

Return

/*/{Protheus.doc} fSendMailCob
	Envia email de cobrança
	@type  Function
	@author Wallace
	@since 20/06/2017
	@version 1.0	
/*/
Static Function fSendMailCob(cArea,cMsg)

	Local oServer		:= Nil
	Local oMessage		:= Nil
	Local cTo			:= ""
	Local cQry 			:= ''
	Local cAliasPCF		:= ""
	Local nErro			:= 0
	Local _cMailServer 	:= GetMv(  "MV_RELSERV" )
	Local _cMailConta  	:= GetMv( "MV_EMCONTA")
	Local _cMailSenha  	:= GetMv( "MV_EMSENHA" )
	Local cMailOp		:= AllTrim(UsrRetMail(__cUserId))		// 21/07/21 - Fred (pegar e-mail de quem fez a cobrança para colocar em copia)
	Local cHtml 		:= ""
	Local cUser 		:= ALLTRIM(UsrRetName(__cUserId))
	Local cCC			:= ""

	cQry += "SELECT PCF_EMAIL FROM PCF010 WHERE PCF_COD = '"+cArea+"' AND D_E_L_E_T_ = ' ' "

	cAliasPCF := MpSysOpenQuery(cQry)

	If !(cAliasPCF)->(Eof())
		cTo  := (cAliasPCF)->PCF_EMAIL

		// 21/07/21 - Fred: verificar se o e-mail da c?? j??est?o para (n?mandar duplicado)
		if !(Upper(cMailOp) $ Upper(cTo))
			cCC	:= cMailOp
		endif

	EndIf

	//Cria a conexao com o server STMP ( Envio de e-mail )
	oServer := TMailManager():New()
	oServer:Init("", _cMailServer, _cMailConta, _cMailSenha)

	If( (nErro := oServer:SmtpConnect()) != 0 )
		QOut( "Nao conectou.", oServer:GetErrorString( nErro ) )
		Aviso( "Nao conectou.",  oServer:GetErrorString( nErro ), { "Fechar" }, 2 )
		Return
	EndIf

	//Apos a conexao, cria o objeto da mensagem
	oMessage := TMailMessage():New()

	//Limpa o objeto
	oMessage:Clear()

	cHtml += '<html> '
	cHtml += '  <head> '
	cHtml += '  </head> '
	cHtml += '  <body> '
	cHtml += '  <div style="background-color: #fff;  border: 1px solid rgba(0, 0, 0, 0.125);  border-radius: 8px; padding:12px;font-family:Arial; font-size:16px"> '
	cHtml += cMsg
	cHtml += '  <br> '

	cHtml += '  <hr> Cobrado por : ' + cUser
	cHtml += '  </div> '
	cHtml += '  </body> '
	cHtml += '</html> '

	//Popula com os dados de envio
	oMessage:cFrom              := _cMailConta
	oMessage:cTo                := cTo
	oMessage:cCc				:= cCc
	oMessage:cSubject           := "Cobranca de Protocolo de Atendimento " + AllTrim(SZX->ZX_SEQ)
	oMessage:cBody              := cHtml

	nErro := oMessage:Send( oServer )
	If( nErro != 0 )

		QOut( "Nao enviou o e-mail.", oServer:GetErrorString( nErro ) )
		Aviso( "Nao enviou o e-mail.",  oServer:GetErrorString( nErro ), { "Fechar" }, 2 )
		Return

	else

		// FRED: gravar linha adicional nos itens do PA destacando para quem o e-mail de cobrança foi enviado
		RecLock("SZY",.T.)

		SZY->ZY_SEQBA 	:= SZX->ZX_SEQ
		SZY->ZY_SEQSERV := U_GetSZYSeq(SZX->ZX_SEQ)//  Soma1(cSeq)
		SZY->ZY_SEQCTRL := SZX->ZX_SEQ
		SZY->ZY_DTSERV 	:= DATE()
		SZY->ZY_HORASV 	:= Replace(SUBSTR(TIME(),1,5),":","")
		SZY->ZY_TIPOSV 	:= (cAliasZY)->ZY_TIPOSV
		SZY->ZY_OBS 	:= "E-mails cobrados -> Para: " + AllTrim(cTo) + iif(!empty(cCc), " - Cópia: " + AllTrim(cCc), "")
		SZY->ZY_HISTPAD := '000078'
		SZY->ZY_DTRESPO := DATE()
		SZY->ZY_HRRESPO := Replace(SUBSTR(TIME(),1,5),":","")
		SZY->ZY_RESPOST := (cAliasZY)->ZY_RESPOST
		SZY->ZY_USDIGIT := ALLTRIM(UsrRetName(__cUserId))
		SZY->ZY_LOGRESP := ALLTRIM(UsrRetName(__cUserId))

		MsUnlock()
		// FRED: fim de alteração

	EndIf

	nErro := oServer:SmtpDisconnect()
	If( nErro != 0 )
		QOut( "Nao desconectou.", oServer:GetErrorString( nErro ) )
		Aviso( "Nao desconectou.",  oServer:GetErrorString( nErro ), { "Fechar" }, 2 )
		Return
	EndIf

Return

//-------------------------------------------------------------------
/*/{Protheus.doc} CAB69VI2
Validação de vinculo
@author  Wallace
@since   20/06/2017
@version 1.0
@type function 
/*/
//-------------------------------------------------------------------
User Function CAB69VI2()

	Local oSay1		:= Nil
	Local oGroup2	:= Nil
	Local Vincular	:= Nil
	Local aWBrowse1 := {}
	Local oFont12b  := TFont():New("Arial",,-16,.T.,.T.)
	Local cCssInfo 	:= "QLabel {color:#004085; background-color: #cce5ff; border-color:#b8daff; padding-top: 15px; padding-left:108px ; border-radius: 4px; }"
	Local cCssBtn 	:= "QPushButton{color:#fff; background-color:#007bff;border-color:#007bff }"
	Local cQuery 	:= ''
	Local oOK   	:= LoadBitmap(GetResources(),"BR_VERDE"		)

	Static oDlgProb	:= Nil

	//Carregar se o beneficiario possui NIP
	fVerNIP()

	If(SZX->ZX_PROB)
		MsgInfo("Esse protocolo Mae/Problema nao pode ser vinculado")
		Return .T.
	ElseIf !Empty(SZX->ZX_SEQPRB)

		If (!MSGYESNO("PA ja esta vinculada a PA MAE "+ SZX->ZX_SEQPRB +", deseja desvincular e vincular a outra PA Mae?","Confirmar"))
			Return .T.
		EndIf

	EndIf

	cQuery := "SELECT * FROM "+RetSqlName("SZX")+" WHERE  D_E_L_E_T_  = ' '  AND ZX_TPINTEL IN ('1','3')  AND  ZX_MATRIC = '"+ SUBSTR(M->ZX_USUARIO,9,6)    +"'    ORDER BY R_E_C_N_O_ DESC "

	cAlias := MpSysOpenQuery(cQuery)

	cAliasQuery := MpSysOpenQuery(cQuery)

	If !(cAliasQuery)->(Eof())

		While !(cAliasQuery)->(Eof())

			cTipoSv :=GetAdvFVal("SZY", "ZY_TIPOSV" , xFilial("SZY")+(cAliasQuery)->ZX_SEQ, 1, "" )

			aAdd( aWBrowse1, { ;
				(cAliasQuery)->ZX_PROB,;
				(cAliasQuery)->ZX_SEQ,;
				DTOC( STOD((cAliasQuery)->ZX_DATDE)),;
				(cAliasQuery)->ZX_NOMUSR,;
				GetAdvFVal("PBL", "PBL_YDSSRV" , xFilial("PBL")+cTipoSv, 1, "" );
				} )
			(cAliasQuery)->(dbSkip())
		EndDo

	Else

		Return .T.

	EndIf

	DEFINE MSDIALOG oDlgProb TITLE "PAs Principais" FROM 000, 000  TO 500, 650 COLORS 0, 16777215 PIXEL

	@ 041, 004 GROUP oGroup2 TO 216, 321 PROMPT "" OF oDlgProb COLOR 0, 16777215 PIXEL

	@ 050, 009 LISTBOX oWBrowse1 Fields HEADER "", "Protocolo","Data","Beneficiario","Tp Servico"  SIZE 308, 162 OF oDlgProb PIXEL ColSizes 50,50

	oWBrowse1:SetArray(aWBrowse1)

	oWBrowse1:bLine := {|| {;
		oOK,;
		aWBrowse1[oWBrowse1:nAt,2],;
		aWBrowse1[oWBrowse1:nAt,3],;
		aWBrowse1[oWBrowse1:nAt,4],;
		aWBrowse1[oWBrowse1:nAt,5];
		}}

	oWBrowse1:bLDblClick := {|| MOSTRAINFO(aWBrowse1[oWBrowse1:nAt,2] ) }

	@ 229, 267 BUTTON Vincular PROMPT "Vincular" SIZE 053, 012 OF oDlgProb ACTION FGRAVVINC(aWBrowse1[oWBrowse1:nAt,2]) PIXEL
	@ 229, 207 BUTTON Vincular PROMPT "Cancelar" SIZE 053, 012 OF oDlgProb ACTION oDlgProb:End() PIXEL
	@ 006, 007 SAY oSay1 PROMPT "Protocolos disponiveis para serem vinculados" SIZE 313, 030 OF oDlgProb FONT oFont12b COLORS 0, 16777215 PIXEL

	oSay1:SetCSS(cCssInfo)
	Vincular:SetCSS(cCssBtn)

	ACTIVATE MSDIALOG oDlgProb CENTERED

Return .T.

//-------------------------------------------------------------------
/*/{Protheus.doc} FGRAVVINC
Gravar vinculo de PA
@author  Wallace
@since   20/06/2017
@version 1.0
@type function 
/*/
//-------------------------------------------------------------------
Static Function FGRAVVINC(cProt)

	Local cQueryZX 	:= ""
	Local cQueryZY 	:= ""
	Local l			:= 0

	If MsgYesNo("Deseja realizar o vi­nculo com este PA principal?", "Confirmacao")

		M->ZX_SEQPRB := cProt

		cUpd := " UPDATE "+RetSqlName("SZX")+" SET ZX_PROB = 'T'  WHERE ZX_SEQ = '"+ cProt +"' "
		nStatus := TCSqlExec(cUpd)

		If (nStatus < 0)
			QOut("TCSQLError() " + TCSQLError())
		Endif

		cQueryZX := "SELECT * FROM " +RetSqlName("SZX") + " WHERE ZX_SEQ = '"+cProt+"'  AND D_E_L_E_T_ =' ' "
		cQueryZY := "SELECT * FROM " +RetSqlName("SZY") + " WHERE ZY_SEQBA = '"+cProt+"'  AND D_E_L_E_T_ =' ' "

		/*Carregar Dados SZX */

		cAliasZX := MpSysOpenQuery(cQueryZX)

		IF !(cAliasZX)->(Eof())

			M->ZX_STATARE 	:= '2'
			M->ZX_TPINTEL 	:= '2'
			M->ZX_AREATU 	:= (cAliasZX)->ZX_AREATU
			M->ZX_CODAREA 	:= (cAliasZX)->ZX_CODAREA
			M->ZX_TPDEM 	:= (cAliasZX)->ZX_TPDEM
			M->ZX_SLA 		:= (cAliasZX)->ZX_SLA
			M->ZX_ASSIST 	:= (cAliasZX)->ZX_ASSIST
			M->ZX_STATARE	:= (cAliasZX)->ZX_STATARE

		EndIf

		cAliasZY := MpSysOpenQuery(cQueryZY)

		IF !(cAliasZY)->(Eof())

			While !(cAliasZY)->(Eof())

				aCols[n][ Ascan(aHeader,{|x| AllTrim(x[2]) == "ZY_SEQCTRL" 	}) ] := cProt
				aCols[n][ Ascan(aHeader,{|x| AllTrim(x[2]) == "ZY_SEQBA" 	}) ] := (cAliasZY)->ZY_SEQBA
				aCols[n][ Ascan(aHeader,{|x| AllTrim(x[2]) == "ZY_SEQSERV" 	}) ] := (cAliasZY)->ZY_SEQSERV
				aCols[n][ Ascan(aHeader,{|x| AllTrim(x[2]) == "ZY_OBS" 		}) ] := (cAliasZY)->ZY_OBS
				aCols[n][ Ascan(aHeader,{|x| AllTrim(x[2]) == "ZY_USDIGIT" 	}) ] := (cAliasZY)->ZY_USDIGIT
				aCols[n][ Ascan(aHeader,{|x| AllTrim(x[2]) == "ZY_HISTPAD" 	}) ] := (cAliasZY)->ZY_HISTPAD
				aCols[n][ Ascan(aHeader,{|x| AllTrim(x[2]) == "ZY_TIPOSV" 	}) ] := (cAliasZY)->ZY_TIPOSV
				aCols[n][ Ascan(aHeader,{|x| AllTrim(x[2]) == "ZY_HORASV" 	}) ] := (cAliasZY)->ZY_HORASV
				aCols[n][ Ascan(aHeader,{|x| AllTrim(x[2]) == "ZY_TIPOSV" 	}) ] := (cAliasZY)->ZY_TIPOSV
				aCols[n][ Ascan(aHeader,{|x| AllTrim(x[2]) == "ZY_SERV" 	}) ] := GetAdvFVal("PBL", "PBL_YDSSRV" , xFilial("PBL")+(cAliasZY)->ZY_TIPOSV, 1, "" )
				aCols[n][ Ascan(aHeader,{|x| AllTrim(x[2]) == "ZY_DSCHIST" 	}) ] := GetAdvFVal("PCD", "PCD_DESCRI" , xFilial("PCD")+(cAliasZY)->ZY_HISTPAD ,1, "" )
// -------------[ chamado 82627 - gus ]--------------------
				aCols[n][ Ascan(aHeader,{|x| AllTrim(x[2]) == "ZY_DTSERV" 	}) ] := stod( (cAliasZY)->ZY_DTSERV )
// --------------------------------------------------------

				oGetDad:AddLine()

				If (n == Len(aCols))

					aCols[n][ Ascan(aHeader,{|x| AllTrim(x[2]) == "ZY_SEQBA" 	}) ] :=	M->ZX_SEQ
					aCols[n][ Ascan(aHeader,{|x| AllTrim(x[2]) == "ZY_SEQSERV" 	}) ] := U_GetSZYSeq(cProt)
					aCols[n][ Ascan(aHeader,{|x| AllTrim(x[2]) == "ZY_SEQCTRL" 	}) ] := cProt
					aCols[n][ Ascan(aHeader,{|x| AllTrim(x[2]) == "ZY_TIPOSV" 	}) ] :=	(cAliasZY)->ZY_TIPOSV
					aCols[n][ Ascan(aHeader,{|x| AllTrim(x[2]) == "ZY_SERV" 	}) ] := GetAdvFVal("PBL", "PBL_YDSSRV" , xFilial("PBL")+(cAliasZY)->ZY_TIPOSV, 1, "" )

				EndIf

				GETDREFRESH()
				SetFocus(oGetDad:oBrowse:hWnd) // Atualizacao por linha
				oGetDad:Refresh()

				(cAliasZY)->(DbSkip())

			EndDo

		Endif

		M->ZX_SEQPRB := cProt

		For l := 1 to Len(_oDlg:OWND:ACONTROLS)

			_oDlg:OWND:ACONTROLS[l]:REFRESH()

		Next l

		lVinc := .T.

		MsgInfo("Alteracao confirmada, PA vinculada com sucesso!")

		oDlgProb:End()

	EndIf

Return

/*/{Protheus.doc} fVerNIP
	Valida situações adversas para ver se tem NIP
	@type  Function
	@author Wallace
	@since 20/06/2017
	@version 1.0	
/*/
Static Function fVerNIP()

	Local cQuery := ''

	cQuery += "SELECT * FROM   "+RetSqlName("BHH")+"       "
	cQuery += " WHERE  BHH_FILIAL = '  '    "
	cQuery += " AND    BHH_CODINT = '"+SUBSTR(M->ZX_USUARIO,1,4)+"'  "
	cQuery += " AND    BHH_CODEMP = '"+SUBSTR(M->ZX_USUARIO,5,4)+"'  "
	cQuery += " AND    BHH_MATRIC = '"+SUBSTR(M->ZX_USUARIO,9,6)+"' "
	cQuery += " AND    BHH_CODSAD = '011'   "
	cQuery += " AND    D_E_L_E_T_ =  ' '    "

	cAliasQuery := MpSysOpenQuery(cQuery)

	If !(cAliasQuery)->(Eof())

		M->ZX_PNIP := '1'

	Else

		M->ZX_PNIP := '2'

	EndIf

	(cAliasQuery)->(DbCloseArea())

Return

//-------------------------------------------------------------------
/*/{Protheus.doc} MOSTRAINFO
Mostrar informações
@author  Wallace
@since   20/06/2017
@version 1.0
@type function 
/*/
//-------------------------------------------------------------------
Static Function MOSTRAINFO(cProt)

	Local oFont			:= TFont():New( "Arial",,-12,.T.)
	Local oFontB    	:= TFont():New( "Arial",,-12,.t.,.t.)
	Static oDlg			:= Nil
	Local aGroups 		:= {}
	Local aSays	  		:= {}
	Local AOBJS 		:= {}
	Local aMsgs 		:= {}
	Local cQuery 		:= ""
	Local nCont 		:= 0
	Local aSizeEsq 		:= {5,5,50}
	Local nHeight 		:=200
	Local nY 			:= 0
	Local Z 			:= 0

	cQuery += " SELECT ZY_SEQSERV, ZY_DTSERV, ZY_HORASV, ZY_TIPOSV, ZY_OBS, ZY_USDIGIT, ZY_HISTPAD  "
	cQuery += " FROM "+RetSqlName("SZY")
	cQuery += " WHERE ZY_SEQBA = '"+cProt+"' AND D_E_L_E_T_ = ' ' "

	cQuery := ChangeQuery(cQuery)

	cAliasQuery := MpSysOpenQuery(cQuery)

	If !(cAliasQuery)->(Eof())

		While !(cAliasQuery)->(Eof())

			nCont++

			AADD(aGroups,Nil)
			AADD(aSays,{Nil,Nil,Nil,Nil,Nil,Nil,Nil,Nil,Nil,Nil,Nil,Nil})

			cSeq :=  (cAliasQuery)->ZY_SEQSERV
			cData :=  DTOC(STOD((cAliasQuery)->ZY_DTSERV))
			cHora := (cAliasQuery)->ZY_HORASV
			cUsuario := (cAliasQuery)->ZY_USDIGIT
			cObs := (cAliasQuery)->ZY_OBS
			cHistoric := GetAdvFVal("PCD", "PCD_DESCRI" , xFilial("PCD")+(cAliasQuery)->ZY_HISTPAD ,1, "" )
			cTipoServ :=  GetAdvFVal("PBL", "PBL_YDSSRV" , xFilial("PBL")+(cAliasQuery)->ZY_TIPOSV, 1, "" )

			AADD(aObjs,{ cData + ' ' + cHora ,;
				&('{|| "'+cSeq+'"}') ,;
				&('{|| "'+cTipoServ+'"}'),;
				&('{|| "'+cHistoric+'"}'),;
				&('{|| "'+cUsuario+'"}'),;
				&('{|| "'+AllTrim(cObs)+'"}') })

			(cAliasQuery)->(DbSkip())

		Enddo
	Else

		MsgInfo("Protocolo sem informacoes de movimentacao!")

		Return

	EndIf

	nHeight := IIF (nCont > 3 , nCont * 60 ,nHeight)

	DEFINE MSDIALOG oDlg TITLE "Andamento do Protocolo  " FROM 000, 000  TO 450, 1000 COLORS 0, 16777215 PIXEL
	oScroll := TScrollArea():New(oDlg,01,01,100,100)
	oScroll:Align := CONTROL_ALIGN_ALLCLIENT
	oPanel := TPanelCss():New(000,000,nil,oScroll,nil,nil,nil,nil,nil,100,nHeight,nil,nil)

	oScroll:SetFrame( oPanel )

	For nY := 1 To nCont

		aGroups[nY]:= tGroup():New(aSizeEsq[1],aSizeEsq[2], aSizeEsq[3],493,aObjs[nY][1],oPanel,0,0,.T.)

		aGroups[nY]:oFont := oFont

		aSizeEsq[1] += 10

		aSays[nY][1] := TSay():New( aSizeEsq[1] ,010, {|| "Sequencia :" } ,aGroups[nY],,oFontB,.F.,.F.,.F.,.T.,0,CLR_WHITE)
		aSays[nY][2] := TSay():New( aSizeEsq[1] ,045, aObjs[nY][2]   ,aGroups[nY],,oFont,.F.,.F.,.F.,.T.,0,CLR_WHITE)

		aSays[nY][3] := TSay():New( aSizeEsq[1] ,245, {|| "Tp Servico:"  } ,aGroups[nY],,oFontB,.F.,.F.,.F.,.T.,0,CLR_WHITE)
		aSays[nY][4] := TSay():New( aSizeEsq[1] ,290, aObjs[nY][3],aGroups[nY],,oFont,.F.,.F.,.F.,.T.,0,CLR_WHITE)

		aSizeEsq[1] += 10

		aSays[nY][3] := TSay():New( aSizeEsq[1] ,010, {|| "Historico:"  } ,aGroups[nY],,oFontB,.F.,.F.,.F.,.T.,0,CLR_WHITE)
		aSays[nY][4] := TSay():New( aSizeEsq[1] ,045, aObjs[nY][4],aGroups[nY],,oFont,.F.,.F.,.F.,.T.,0,CLR_WHITE)

		aSays[nY][5] := TSay():New( aSizeEsq[1] ,245, {|| "Usuario:" } ,aGroups[nY],,oFontB,.F.,.F.,.F.,.T.,0,CLR_WHITE)
		aSays[nY][6] := TSay():New( aSizeEsq[1] ,290, aObjs[nY][5],aGroups[nY],,oFont,.F.,.F.,.F.,.T.,0,CLR_WHITE)

		aSizeEsq[1] += 10

		aSays[nY][7] := TSay():New( aSizeEsq[1] ,010, {|| "Observacao:" } ,aGroups[nY],,oFontB,.F.,.F.,.F.,.T.,0,CLR_WHITE)

		nLinhasObs := Len(EVAL(aObjs[nY][6]))

		If nLinhasObs > 100

			AADD(aMsgs, SUBSTR( EVAL(aObjs[nY][6]) ,1,100) )
			AADD(aMsgs, SUBSTR( EVAL(aObjs[nY][6]) ,101,100) )

			For Z := 1 To Len(aMsgs)

				aSays[nY][8] := TSay():New( aSizeEsq[1] ,055, &("{ || '"+aMsgs[Z]+"' }") ,aGroups[nY],,oFont,.F.,.F.,.F.,.T.,0,CLR_WHITE)

				aSizeEsq[1] += 10

				aGroups[nY]:nHeight += 10

			Next

		Else

			aSays[nY][8] := TSay():New( aSizeEsq[1] ,055, aObjs[nY][6] ,aGroups[nY],,oFont,.F.,.F.,.F.,.T.,0,CLR_WHITE)

		EndIf

		aSizeEsq[1] += 25
		aSizeEsq[3] += 55

	Next

	ACTIVATE MSDIALOG oDlg CENTERED

Return

/*/{Protheus.doc}  GetSZYSeq(c)
	Grava max do seq
	@type  Function
	@author Wallace
	@since 20/06/2017
	@version v1.0	
/*/
USER Function  GetSZYSeq(cId)

	Local cRet :=''
	Local cQry := ''

	cQry :=  " SELECT MAX(ZY_SEQSERV) AS SEQ FROM "+RetSqlName("SZY")+" WHERE ZY_SEQBA = '"+cId+"'   AND D_E_L_E_T_ = ' '  "

	cALiascQry:= MpSysOpenQuery(cQry)

	If !(cALiascQry)->(Eof())

		cRet := (cALiascQry)->SEQ

		cRet := Soma1(cRet)

	EndIf

	(cALiascQry)->(DbCloseArea())

Return cRet

/*/{Protheus.doc} fMostraProt
	Mostra protocolo
	@type  Function
	@author Wallace
	@since 20/06/2017
	@version 1.0	
/*/
User Function fMostraProt()

	Local oMultiGet	:= Nil
	Local cMultiget := M->ZX_SEQ
	Local oFontB    := TFont():New( "Arial",,-42,.t.,.t.)
	Local cCssInfo 	:= "QTextEdit {color:#004085; background-color: #cce5ff; border-color:#b8daff; padding-top: 10px; padding-left:50px ; border-radius: 4px; }"
	Static oDlg		:= Nil

	DEFINE MSDIALOG oDlg TITLE "INFORME O NUMERO DO PROTOCOLO" FROM 000, 000  TO 150, 600 COLORS 0, 16777215 PIXEL

	@ 009, 006 GET oMultiGet VAR cMultiget OF oDlg FONT oFontB MULTILINE SIZE 284, 055 COLORS 0, 16777215 HSCROLL PIXEL

	oMultiGet:SetCSS(cCssInfo)

	ACTIVATE MSDIALOG oDlg

Return .T.

/*/{Protheus.doc} fSetStatPed
	Status do Pedido
	@type  Function
	@author Wallce
	@since 20/06/2017
	@version 1.0	
/*/
Static Function fSetStatPed()

	Local oButton1	:= Nil
	Local oComboBo1	:= Nil
	Local oFontB    := TFont():New( "Arial",,-12,.t.,.t.)
	Local nComboBo1 := 1
	Local oSay1		:= Nil
	Local cCssInfo 	:= "QLabel {color:#004085; background-color: #cce5ff; border-color:#b8daff; padding-top: 10px; padding-left:20px ; border-radius: 4px; }"
	Local cCssBtn 	:= "QPushButton{color:#fff; background-color:#007bff;border-color:#007bff }"

	Static oDlg		:= Nil

	DEFINE MSDIALOG oDlg TITLE "Status do Pedido" FROM 000, 000  TO 200, 300 COLORS 0, 16777215 PIXEL STYLE DS_MODALFRAME

	@ 046, 007 MSCOMBOBOX oComboBo1 VAR nComboBo1 ITEMS {"1=Indeferido","2=Resolvido","3=Parcialmente Resolvido"} SIZE 135, 010 OF oDlg COLORS 0, 16777215 PIXEL
	@ 076, 083 BUTTON oButton1 PROMPT "Confirmar" SIZE 061, 013 OF oDlg ACTION fSetStat(nComboBo1) PIXEL
	@ 006, 006 SAY oSay1 PROMPT "Por favor defina o status do pedido" SIZE 138, 017 OF oDlg FONT oFontB COLORS 0, 16777215 PIXEL
	oSay1:SetCSS(cCssInfo)
	oButton1:SetCSS(cCssBtn)
	oDlg:lEscClose     := .F.

	ACTIVATE MSDIALOG oDlg CENTERED

Return


/*/{Protheus.doc} fSetStat
	Atualiza status do pedido
	@type  Function
	@author Wallace
	@since 20/06/2017
	@version 1.0	
/*/
Static Function fSetStat(nVal)

	M->ZX_STATPED := CVALTOCHAR(nVal)

	oDlg:End()

Return

//-------------------------------------------------------------------
/*/{Protheus.doc} zDiasUteis
Quantidade de dias uteis
@author  Wallace
@since   20/06/2017
@type function 
@version 1.0
/*/
//-------------------------------------------------------------------
User Function zDiasUteis(dDtIni, dDtFin)

	Local nDias    := 0
	Local dDtAtu   := sToD("")
	Default dDtIni := dDataBase
	Default dDtFin := dDataBase

	//Enquanto a data atual for menor ou igual a data final
	dDtAtu := dDtIni
	While dDtAtu <= dDtFin
		//Se a data atual for uma data Valida
		If dDtAtu == DataValida(dDtAtu)
			nDias++
		EndIf

		dDtAtu := DaySum(dDtAtu, 1)
	EndDo

Return nDias - 1

//-------------------------------------------------------------------
/*/{Protheus.doc} ImpProt
Relatório
@author  Wallace
@since   20/06/2017
@type function 
@version 1.0
/*/
//-------------------------------------------------------------------
USER Function ImpProt()

	Local cData  			:= IIF(VAZIO(SZX->ZX_DATATE), DToC(Date())  ,DTOC(SZX->ZX_DATATE))
	Local cTitular 			:= ''
	Local cServico 			:= ''
	Local cDependente 		:= ''
	Local lAdjustToLegacy 	:= .F.
	Local lDisableSetup  	:= .T.
	Local oPrinter			:= Nil
	Local cLocal          	:= "\spool"
	Local nLinha			:= 0
	Local cMsg 				:= ''
	Local oFont11     		:= TFont():New( "Arial",0,-11,,.F.)
	Local oFont11b     		:= TFont():New( "Arial",0,-11,,.T.)
	Local nI				:= 0

	If SZX->ZX_TIPREG == "00"
		cTitular := SZX->ZX_NOMUSR
	Else

		cQry := "SELECT BA1_NOMUSR NOME FROM "+RetSqlName("BA1")+" WHERE  BA1_CODINT = '"+SZX->ZX_CODINT+"' AND  BA1_CODEMP = '"+SZX->ZX_CODEMP+"' AND BA1_MATRIC = '"+SZX->ZX_MATRIC+"' AND BA1_TIPREG = '00' AND D_E_L_E_T_ = ' ' "
		cAlias := MpSysOpenQuery(cQry)
		if !(cAlias)->(Eof())
			cTitular := (cAlias)->NOME
		endIf

		cDependente := SZX->ZX_NOMUSR

	EndIf

	cQry := " SELECT SIGA.WWW_RET_SERVICO(ZY_TIPOSV) SERVICO, ZY_OBS FROM "+RetSqlName("SZY")+" WHERE ZY_SEQBA = '"+SZX->ZX_SEQ+"' AND D_E_L_E_T_ = ' '  AND ROWNUM = 1 "
	cAliasZY := MpSysOpenQuery(cQry)
	if !(cAliasZY)->(Eof())
		cServico := (cAliasZY)->SERVICO
		cMsg := (cAliasZY)->ZY_OBS
	endIf

	oPrinter := FWMSPrinter():New("exemplo.rel", IMP_PDF, lAdjustToLegacy,cLocal, lDisableSetup, , , , , , .F., .T. )
	oPrinter:Setup()

	oPrinter:SetPaperSize(9)
	oPrinter:SetDevice(6)
	oPrinter:SetViewPDF(.T.)

	oPrinter:StartPage()

	oPrinter:SayBitMap( 50, 50, "\img\\head_caberj.jpg",500)

	nLinha += 200

	oPrinter:Say(nLinha,50,	"N. Protocolo: ",oFont11b)
	oPrinter:Say(nLinha,110,SZX->ZX_SEQ,oFont11b)

	nLinha += 10

	oPrinter:Say(nLinha,50,	"Data: ",oFont11b)
	oPrinter:Say(nLinha,75,	cData ,oFont11b)

	nLinha += 10

	oPrinter:Say(nLinha,50,	"Beneficiario(Titular): ",oFont11b)
	oPrinter:Say(nLinha,140,	cTitular,oFont11b)

	nLinha += 10

	oPrinter:Say(nLinha,50,	"Beneficiario(Dependente): ",oFont11b)
	oPrinter:Say(nLinha,160,	cDependente,oFont11b)

	nLinha += 20

	oPrinter:Say(nLinha,50,	"Assunto: ",oFont11b)
	oPrinter:Say(nLinha,90,	cServico,oFont11b)

	nLinha += 40

	aMessages := aFormatMsgProt(cData,cTitular,SZX->ZX_SEQ,cMsg)

	For nI := 1 To Len(aMessages)

		oPrinter:Say(nLinha,50,aMessages[nI],oFont11)

		nLinha+= 20

	Next

	nLinha+= 200

	oPrinter:Say(nLinha,80,"___/___/___" + Space(30) + Replicate("_",70),oFont11)

	nLinha+= 100

	oPrinter:SayBitMap( nLinha , 50, "\img\\footer_caberj.png",500)

	oPrinter:EndPage()

	oPrinter:Preview()

Return


/*/{Protheus.doc} CABA069
Rotina que ira realizar a transferÃªncia dos documentos inseridos
no protocolo de atendimento para o nÃ­vel do usuÃ¡rio.
@type function TransfDoc
@author angelo.cassago
@since 10/02/2020
@version 1.0
/*/

Static Function TransfDoc(_cParam1)

	Local _aArBA1 	:= BA1->(GetArea())
	Local cAliQry	:= GetNextAlias()
	Local nSaveSX8  := 0
	Local _cCodObj 	:= ""
	Local _cChavBA1	:= ""
	Local _aAC9Ant	:= Nil
	Local _aACBAnt  := Nil
	Local _dDtInc 	:= CTOD(" / / ")
	Local _cHrinc	:= ""
	Local _cOBjto	:= ""
	Local _cDesc	:= ""
	Local cQuery	:= ""
	Local _ChvAC9	:= ""

	Default _cParam1 := Nil

	_ChvAC9	:= _cParam1

	DbSelectArea("BA1")
	DbSetOrder(2) //BA1_FILIAL+BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG+BA1_DIGITO
	If DbSeek(xFilial("BA1") + SZX->(ZX_CODINT+ZX_CODEMP+ZX_MATRIC+ZX_TIPREG+ZX_DIGITO))

		_cChavBA1 := BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPUSU+BA1_TIPREG+BA1_DIGITO)

		DbSelectArea("AC9")
		DbSetOrder(2) //AC9_FILIAL+AC9_ENTIDA+AC9_FILENT+AC9_CODENT+AC9_CODOBJ
		If DbSeek(xFilial("AC9") + "SZX" + _ChvAC9)

			While AC9->(!(Eof())) .And. AllTrim(_ChvAC9) == AllTrim(AC9->(AC9_FILENT+AC9_CODENT))

				_aAC9Ant := AC9->(GetArea())

				_dDtInc := AC9->AC9_XDTINC
				_cHrinc	:= AC9->AC9_HRINC

				DbSelectArea("ACB")
				DbSetORder(1) //ACB_FILIAL+ACB_CODOBJ
				If DbSeek(xFilial("ACB") + AC9->AC9_CODOBJ)

					While !EOF() .And. AC9->AC9_CODOBJ = ACB->ACB_CODOBJ

						_aACBAnt := ACB->(GetArea())

						_cOBjto	:= ACB->ACB_OBJETO
						_cDesc	:= ACB->ACB_DESCRI

						//-------------------------------------------------------------------------
						//VALIDAR SE JA ESTA GRAVADO, CASO NÃƒO ESTEJA EFETUAR A GRAVAÃ‡ÃƒO
						//-------------------------------------------------------------------------
						cQuery := " SELECT                                          				" + c_ent
						cQuery += "     AC9.AC9_ENTIDA,                             				" + c_ent
						cQuery += "     AC9.AC9_CODENT,                             				" + c_ent
						cQuery += "     AC9.AC9_CODOBJ,                             				" + c_ent
						cQuery += "     AC9.AC9_XDTINC,                             				" + c_ent
						cQuery += "     TRIM(ACB.ACB_OBJETO) OBJETO,                				" + c_ent
						cQuery += "     TRIM(ACB.ACB_DESCRI) DESCRICAO              				" + c_ent
						cQuery += " FROM                                            				" + c_ent
						cQuery += "     " + RetSqlName("AC9") + " AC9               				" + c_ent
						cQuery += "                                                 				" + c_ent
						cQuery += "     INNER JOIN                                  				" + c_ent
						cQuery += "     	" + RetSqlName("ACB") + " ACB           				" + c_ent
						cQuery += "     ON                                          				" + c_ent
						cQuery += "         ACB.ACB_FILIAL      = AC9.AC9_FILIAL					" + c_ent
						cQuery += "         AND ACB.ACB_CODOBJ  = AC9.AC9_CODOBJ    				" + c_ent
						cQuery += "         AND ACB.D_E_L_E_T_  = ' '               				" + c_ent
						cQuery += "         AND ACB.ACB_OBJETO  = '" + _cOBjto + " '    			" + c_ent
						cQuery += "                                                 				" + c_ent
						cQuery += " WHERE                                           				" + c_ent
						cQuery += "     AC9.AC9_FILIAL          = '" + xFilial("AC9") + "'      	" + c_ent
						cQuery += "     AND AC9.AC9_ENTIDA      = 'BA1'             				" + c_ent
						cQuery += "     AND AC9.AC9_CODENT      = '" + _cChavBA1  + "'          	" + c_ent
						cQuery += "     AND AC9.AC9_XDTINC      = '" + DTOS(_dDtInc) + "'   		" + c_ent
						cQuery += "     AND AC9.D_E_L_E_T_      = ' '               				" + c_ent

						If Select(cAliQry) > 0
							(cAliQry)->(DbCloseArea())
						EndIf

						DbUseArea(.T.,"TopConn",TcGenQry(,,cQuery),cAliQry,.T.,.T.)

						DbSelectArea(cAliQry)

						If ((cAliQry)->(Eof()))

							nSaveSX8 := GetSX8Len()
							_cCodObj := GetSXENum( "ACB", "ACB_CODOBJ" )

							//---------------------------------------------------
							//RelaÃ§Ã£o de Objetos x Entidade
							//---------------------------------------------------
							RecLock("AC9", .T.)

							AC9->AC9_FILIAL := xFilial("AC9")
							AC9->AC9_ENTIDA	:= "BA1"
							AC9->AC9_CODENT	:= _cChavBA1
							AC9->AC9_CODOBJ	:= _cCodObj
							AC9->AC9_XUSU	:= "SISTEMA"
							AC9->AC9_XDTINC	:= _dDtInc
							AC9->AC9_HRINC	:= _cHrinc

							AC9->(MsUnLock())

							//---------------------------------------------------
							//Banco de Conhecimento
							//---------------------------------------------------
							RecLock("ACB", .T.)

							ACB->ACB_FILIAL := xFilial("ACB")
							ACB->ACB_CODOBJ := _cCodObj
							ACB->ACB_OBJETO := _cOBjto
							ACB->ACB_DESCRI := _cDesc

							ACB->(MsUnLock())

							While (GetSx8Len() > nSaveSx8)
								ConfirmSX8()
							EndDo

						EndIf

						If Select(cAliQry) > 0
							(cAliQry)->(DbCloseArea())
						EndIf

						RestArea(_aACBAnt)

						ACB->(DbSkip())

					EndDo

				EndIf

				RestArea(_aAC9Ant)

				AC9->(DbSkip())

			EndDo

		EndIf

	EndIf

	RestArea(_aArBA1)

Return

/*/{Protheus.doc} CAB69ADD
	Resposta
	@type  Function
	@author Wallace
	@since 20/06/2017
	@version 1.0	
/*/
USER Function CAB69ADD()

	Local oButton1	:= Nil
	Local oGroup1	:= Nil
	Local oGroup2	:= Nil
	Local oMultiGe1	:= Nil
	Local cObserv 	:= aCols[n][ Ascan(aHeader,{|x| AllTrim(x[2]) == "ZY_OBS" }) ]//M->ZY_OBS
	Local oMultiGe2	:= Nil
	Local cRespost 	:=  aCols[n][ Ascan(aHeader,{|x| AllTrim(x[2]) == "ZY_RESPOST" }) ]//M->ZY_RESPOST

	Static oDlg		:= Nil

	DEFINE MSDIALOG oDlg TITLE "Protocolo de Atendimento " + AllTrim(M->ZX_SEQ)  FROM 000, 000  TO 600, 650 COLORS 0, 16777215 PIXEL STYLE DS_MODALFRAME

	@ 006, 004 GROUP oGroup1 TO 131, 320 PROMPT "Observacao" OF oDlg COLOR 0, 16777215 PIXEL
	@ 138, 004 GROUP oGroup2 TO 270, 320 PROMPT "Resposta" OF oDlg COLOR 0, 16777215 PIXEL
	@ 278, 272 BUTTON oButton1 PROMPT "Confirmar" ACTION zSETLINHA(AllTrim(cObserv),AllTrim(cRespost)) SIZE 047, 014 OF oDlg PIXEL
	@ 013, 008 GET oMultiGe1 VAR cObserv OF oDlg MULTILINE SIZE 306, 108 COLORS 0, 16777215 HSCROLL PIXEL
	@ 147, 008 GET oMultiGe2 VAR cRespost OF oDlg MULTILINE SIZE 307, 117 COLORS 0, 16777215 HSCROLL PIXEL

	ACTIVATE MSDIALOG oDlg CENTERED

Return .T.

/*/{Protheus.doc} zSETLINHA
	Atualiza linha
	@type Function
	@author Wallace
	@since 20/06/2017
	@version 1.0	
/*/
Static Function zSETLINHA(cObs,cResp)

	Local lDupObs 		:= Len(cObs) > 512
	Local lTemResposta 	:= !Empty(cResp)
	Local aObs 			:= {}

	If lDupObs

		AADD(aObs, SUBSTR(cObs,1,511) )
		AADD(aObs, SUBSTR(cObs,512,511) )

		aCols[n][ Ascan(aHeader,{|x| AllTrim(x[2]) == "ZY_OBS" }) ] := aObs[1]

		oGetDad:AddLine()

		aCols[n][ Ascan(aHeader,{|x| AllTrim(x[2]) == "ZY_USDIGIT" 	}) ] := M->ZY_USDIGIT
		aCols[n][ Ascan(aHeader,{|x| AllTrim(x[2]) == "ZY_HISTPAD" 	}) ] := M->ZY_HISTPAD
		aCols[n][ Ascan(aHeader,{|x| AllTrim(x[2]) == "ZY_TIPOSV" 	}) ] := M->ZY_TIPOSV
		aCols[n][ Ascan(aHeader,{|x| AllTrim(x[2]) == "ZY_HORASV" 	}) ] := M->ZY_HORASV
		aCols[n][ Ascan(aHeader,{|x| AllTrim(x[2]) == "ZY_TIPOSV" 	}) ] := M->ZY_TIPOSV
		aCols[n][ Ascan(aHeader,{|x| AllTrim(x[2]) == "ZY_SERV" 	}) ] := GetAdvFVal("PBL", "PBL_YDSSRV" , xFilial("PBL")+M->ZY_TIPOSV, 1, "" )
		aCols[n][ Ascan(aHeader,{|x| AllTrim(x[2]) == "ZY_DSCHIST" 	}) ] := GetAdvFVal("PCD", "PCD_DESCRI" , xFilial("PCD")+ M->ZY_HISTPAD ,1, "" )
		aCols[n][ Ascan(aHeader,{|x| AllTrim(x[2]) == "ZY_OBS" 		}) ] := aObs[2]

		If lTemResposta
			aCols[n][ Ascan(aHeader,{|x| AllTrim(x[2]) == "ZY_RESPOST" }) ] := cResp
		EndIf

	Else

		aCols[n][ Ascan(aHeader,{|x| AllTrim(x[2]) == "ZY_OBS" }) ] := cObs

		If lTemResposta
			aCols[n][ Ascan(aHeader,{|x| AllTrim(x[2]) == "ZY_RESPOST" }) ] := cResp
		EndIf

	EndIf

	GETDREFRESH()
	SetFocus(oGetDad:oBrowse:hWnd) // Atualizacao por linha
	oGetDad:Refresh()

	oDlg:End()

Return .T.

//-------------------------------------------------------------------
/*/{Protheus.doc} aFormatMsgProt
Formata mensagem
@author  Wallace
@since   20/06/2017
@version 1.0
@type function 
/*/
//-------------------------------------------------------------------
Static Function aFormatMsgProt(cDate, cBenef, cProt, cMsg)

	Local aMsgs	:= {}
	Local nIni 	:= 1
	Local nX	:= 0

	nDiv := ROUND(Len(cMsg) / 4.5, 0)

	For nX := 1 To 5

		aAdd(aMsgs, SUBSTR(cMsg,nIni,nDiv)   )

		nIni += nDiv
	Next

Return aMsgs

//-------------------------------------------------------------------
/*/{Protheus.doc} fAtuAC9
Função para atualizar os campos no documento
			gravado na tabela AC9
@author  Angelo Henrique
@since   20/06/2017
@version 1.0
@type function 
/*/
//-------------------------------------------------------------------
Static Function fAtuAC9

	Local  cQuery  := ""
	Local _cChvSZX := ""

	//------------------------------------------------------------------------------------------------
	// Atualiza a data de inclusão do banco de conhecimento corretamente
	//------------------------------------------------------------------------------------------------
	// Atualizado por Luiz Otavio em 05/05/19
	//------------------------------------------------------------------------------------------------

	_cChvSZX := SZX->(ZX_FILIAL+ZX_SEQ+ZX_CODINT+ZX_CODEMP+ZX_MATRIC+ZX_TIPREG+ZX_DIGITO+DTOS(ZX_DATDE)+ZX_HORADE+DTOS(ZX_DATATE)+ZX_HORATE)

	DbSelectArea("AC9")
	DbSetOrder(2)
	If DbSeek(xFilial("AC9") + "SZX" + xFilial("AC9") + Substr(_cChvSZX,1,47)) //AC9_FILIAL+AC9_ENTIDA+AC9_FILENT+AC9_CODENT+AC9_CODOBJ

		If Empty(AC9->AC9_XUSU)

			cQuery := " UPDATE																	" + c_ent
			cQuery += " 	" + RetSqlName("AC9") + " AC9 										" + c_ent
			cQuery += " SET 																	" + c_ent
			cQuery += " 	AC9.AC9_XDTINC = '" + DTOS(dDataBase) + "',							" + c_ent
			cQuery += " 	AC9.AC9_HRINC = '" + STRTRAN(SUBSTR(TIME(),1,5),":","") + "', 		" + c_ent
			cQuery += " 	AC9.AC9_XUSU = '"+cUserName+"'								    	" + c_ent
			cQuery += " WHERE 																	" + c_ent
			cQuery += " 	AC9.D_E_L_E_T_ = ' ' 	 											" + c_ent
			cQuery += " 	AND AC9.AC9_ENTIDA = 'SZX'  										" + c_ent
			cQuery += " 	AND SUBSTR(AC9.AC9_CODENT,1,47) = '" + Substr(_cChvSZX,1,47) + "'  	" + c_ent
			cQuery += " 	AND AC9.AC9_XDTINC < '"+DTOS(SZX->ZX_DATDE)+"'						" + c_ent

			TcSqlExec(cQuery)

		EndIf

	EndIf

Return

//-------------------------------------------------------------------
/*/{Protheus.doc} EnvExtra
Rotina utilizada para enviar extrato por e-mail
@author  Angelo Henrique
@since   16/06/2021
@version 1.0
@type function 
/*/
//-------------------------------------------------------------------
User Function CAB69EXT()

	Local _cMail	:= SZX->ZX_EMAIL + SPACE(200)
	Local _cAno		:= SPACE(4)
	Local _cMes		:= SPACE(2)
	Local _nOpc 	:= 1  //Opção da Tela
	Local _cLink	:= " "
	Local c_Path	:= GetNewPar("MV_XPATEX","\PDF_EXTRATO\")
	Local _lAchou	:= .F.

	SetPrvt("oFont1","oDlg1","oGrp1","oGrp2","oSay1","oSay2","oGrp3","oSay4","oSay5","oSay6","oGet1")
	SetPrvt("oGet3","oBtn1","oBtn2")

	If cEmpAnt = "01"

		_cLink	:= GetNewPar("MV_XLKEXT","https://www.caberj.com.br/seucanal/beneficiario/painel/extratomensal/extratoemailCPF/ExtratoDigitalPDF.asp?IdMatricula=")

	Else

		//_cLink	:= GetNewPar("MV_XLKEXT","https://www.integralsaude.com.br/seucanal/beneficiario/painel/extratomensal/extratoemailCPF/ExtratoDigitalPDF.asp?IdMatricula=")
		Aviso("Atenção","Processo não habilitado para a INTEGRAL.",{"OK"})
		Return

	EndIf


	/*ÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
	±± Definicao do Dialog e todos os seus componentes.                        ±±
	Ù±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*/
	oFont1     := TFont():New( "MS Sans Serif",0,-16,,.F.,0,,400,.F.,.F.,,,,,, )

	oDlg1      := MSDialog():New( 092,230,398,899,"Envio de Extrato por Email",,,.F.,,,,,,.T.,,,.T. )

	oGrp1      := TGroup():New( 000,000,144,328,"  Tela para enviar Extrato por Email  ",oDlg1,CLR_HBLUE,CLR_WHITE,.T.,.F. )
	oGrp2      := TGroup():New( 012,004,052,324,"",oGrp1,CLR_BLACK,CLR_WHITE,.T.,.F. )
	oSay1      := TSay():New( 020,068,{||"Rotina utilizada para enviar o extrato do beneficiario"},oGrp2,,oFont1,.F.,.F.,.F.,.T.,CLR_HBLUE,CLR_WHITE,188,012)
	oSay2      := TSay():New( 032,088,{||"com base nos parametros preenchidos"},oGrp2,,oFont1,.F.,.F.,.F.,.T.,CLR_HBLUE,CLR_WHITE,144,012)
	oGrp3      := TGroup():New( 056,004,120,324,"",oGrp1,CLR_BLACK,CLR_WHITE,.T.,.F. )
	oSay4      := TSay():New( 064,012,{||"Para qual email deseja enviar o extrato:"},oGrp3,,oFont1,.F.,.F.,.F.,.T.,CLR_HBLUE,CLR_WHITE,144,012)
	oSay5      := TSay():New( 100,140,{||"Digite o Ano: "},oGrp3,,oFont1,.F.,.F.,.F.,.T.,CLR_HBLUE,CLR_WHITE,048,012)
	oSay6      := TSay():New( 100,012,{||"Digite o Mês:"},oGrp3,,oFont1,.F.,.F.,.F.,.T.,CLR_HBLUE,CLR_WHITE,052,012)
	oGet1      := TGet():New( 076,012,{|u| If( PCount() == 0, _cMail, _cMail := u )},oGrp3,304,012,'',{|| u_cabv037(_cMail) .or. Empty(_cMail)  },CLR_BLACK,CLR_WHITE,oFont1,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","",,)
	oGet2      := TGet():New( 096,192,{|u| If( PCount() == 0, _cAno, _cAno := u )},oGrp3,060,012,'',,CLR_BLACK,CLR_WHITE,oFont1,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","",,)
	oGet3      := TGet():New( 096,060,{|u| If( PCount() == 0, _cMes, _cMes := u )},oGrp3,060,012,'',,CLR_BLACK,CLR_WHITE,oFont1,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","",,)

	oBtn1      := TButton():New( 124,112,"OK"		,oGrp1,{||IIF(u_cabv037(_cMail),oDlg1:End(),.F.),_nOpc := 1},037,012,,oFont1,,.T.,,"",,,,.F. )
	oBtn2      := TButton():New( 124,184,"Cancelar"	,oGrp1,{||oDlg1:End(),_nOpc := 2},037,012,,oFont1,,.T.,,"",,,,.F. )

	oDlg1:Activate(,,,.T.)

	If _nOpc = 1

		If MsgYesNo("Confirma o envio do Extrato do Mês: " + _cMes + " e Ano: " + _cAno + ".", "Atenção" )

			_cLink += SZX->(ZX_CODINT + ZX_CODEMP + ZX_MATRIC + ZX_TIPREG + ZX_DIGITO) + "&anomes=" + _cAno + _cMes
			c_NomeArq := SZX->(ZX_CODINT + ZX_CODEMP + ZX_MATRIC + ZX_TIPREG + ZX_DIGITO) + _cAno + _cMes

			ShellExecute("Open", _cLink, "", "", 1)

			While !_lAchou

				Sleep( 5000 )

				If FILE( c_Path + c_NomeArq + '.PDF')

					_lAchou := .T.

					EnvEmail1( AllTrim(_cMail) , c_Path , c_NomeArq + '.PDF', SZX->ZX_NOMUSR , SZX->ZX_SEQ, DTOC(SZX->ZX_DATDE))

				ElseIf FILE( c_Path + c_NomeArq + 'N.PDF')

					_lAchou := .T.

					Aviso("Atenção","Email com extrato não enviado! Não existe extrato para o mês selecionado. ",{"OK"})

				EndIf

			EndDo

		Else

			Aviso("Atenção","Email com extrato não enviado!",{"OK"})

		EndIf

	EndIf

Return

//-------------------------------------------------------------------
/*/{Protheus.doc} EnvEmail1
Envia email
@author  Angelo Henrique
@since   20/06/2017
@version 1.0
@type function 
/*/
//-------------------------------------------------------------------
Static Function EnvEmail1( c_Dest, cPath,c_Caminho, c_Nome, c_Prot, c_Data )

	Local _cMailServer := GetMv( "MV_RELSERV" )
	Local _cMailConta  := GetMv( "MV_EMCONTA" )
	Local _cMailSenha  := GetMv( "MV_EMSENHA" )

	Local _cTo  	     := c_Dest//"coimbra.marcela@gmail.com"
	Local _cCC         := _cMailConta  //GetMv( "MV_WFFINA" ) //ANGELO HENRIQUE - DATA: 03/02/2021 - COLOCADO PARA SEMPRE TER CÓPIA EM OCULTA
	Local _cAssunto    := " Envio de Extrato Mensal - CABERJ "
	Local _cError      := ""
	Local l_Ok         := .T.
	Local _lSendOk     := .F.

	c_Mensagem := ' <table>'
	c_Mensagem += ' <TR><TD>'
	c_Mensagem += ' <table class="col550" align="left" border="0" cellpadding="0" cellspacing="0" style="width: 600px; " >'
	c_Mensagem += '                                                 <tr>'
	c_Mensagem += '                                                     <td height="70">'
	c_Mensagem += '                                                        <table width="100%" border="0" cellspacing="0" cellpadding="0">'

	c_Mensagem += '                                                            <tr>'
	c_Mensagem += '                                                                <td style="color:white;font-size:30px;text-align:center"   >'
	c_Mensagem += '                                                                    <img src="https://www.caberj.com.br/images/ComunicacaoClientes/Imagem_Superior.jpg"  width="100%" height="100%" >'
	c_Mensagem += '                                                                </td>'
	c_Mensagem += '                                                            </tr>'
	c_Mensagem += '                                                        </table>'
	c_Mensagem += '                                                    </td>'
	c_Mensagem += '                                                </tr>'
	c_Mensagem += '                                            </table>'
	c_Mensagem += '<TD></TR><TD>	'

	c_Mensagem +=  Chr(13) + Chr(10) + Chr(13) + Chr(10) + "Prezado(a)  " + c_Nome
	c_Mensagem +=  Chr(13) + Chr(10) + Chr(13) + Chr(10) + "Obrigado por entrar em contato conosco,  "


	If !EMpty( c_Prot )

		c_Mensagem +=  Chr(13) + Chr(13)

		c_Mensagem +=  Chr(13) + Chr(10) + Chr(13) + Chr(10) + "Em resposta a sua solicitação com número de <b> Protocolo " + c_Prot + "</b>, solicitada no dia   "+ c_Data+", enviamos em anexo  o seu extrato."

		c_Mensagem +=  Chr(13) + Chr(10) + Chr(13) + Chr(10) + "Em caso de dúvidas, favor entrar em contato com um dos nossos canais de atendimentos listados abaixo."

		c_Mensagem +=  Chr(13) + Chr(13)

	Else

		c_Mensagem +=  Chr(13) + Chr(13)

		c_Mensagem +=  Chr(13) + Chr(10) + Chr(13) + Chr(10) + "Enviamos o Extrato em anexo. "

		c_Mensagem +=  Chr(13) + Chr(13)


	EndIf

	c_Mensagem +=  Chr(13) + Chr(10) + Chr(13) + Chr(10) + "Atenciosamente,"
	c_Mensagem +=  Chr(13) + Chr(10) + Chr(13) + Chr(10) + "Gerencia de atendimento,"
	c_Mensagem +=  '<TR><TD>'
	c_Mensagem +=  '<table class="col550" align="left" border="0" cellpadding="0" cellspacing="0" style="width: 600px; " >'
	c_Mensagem +=  '                                                <tr>'
	c_Mensagem +=  '                                                    <td height="70">'
	c_Mensagem +=  '                                                        <table width="100%" border="0" cellspacing="0" cellpadding="0">'
	c_Mensagem +=  '                                                            <tr> '
	c_Mensagem +=  '                                                                <td style="color:white;font-size:30px;text-align:center"   >'
	c_Mensagem +=  '                                                                    <img src="https://www.caberj.com.br/images/ComunicacaoClientes/Imagem_inferior.jpg">'
	c_Mensagem +=  '                                                                </td>'
	c_Mensagem +=  '                                                            </tr>'
	c_Mensagem +=  '                                                        </table>'
	c_Mensagem +=  '                                                    </td> '
	c_Mensagem +=  '                                                </tr> '
	c_Mensagem +=  '												<TD></TR>'
	c_Mensagem +=  '                                            </table>'
	c_Mensagem +=  '											</TABLE> '

	If !Empty( _cMailServer ) .And. !Empty( _cMailConta  )

		CONNECT SMTP SERVER _cMailServer ACCOUNT _cMailConta PASSWORD _cMailSenha RESULT l_Ok

		If l_Ok

			SEND MAIL From _cMailConta To _cTo BCC _cCC Subject _cAssunto Body c_Mensagem  Result _lSendOk  ATTACHMENT cPath+c_Caminho

		Else

			GET MAIL ERROR _cError
			Aviso( "Erro no envio do E-Mail", _cError, { "Fechar" }, 2 )

		EndIf

		If l_Ok

			DISCONNECT SMTP SERVER

		EndIf

		If _lSendOk

			Aviso("E-mail enviado", "E-mail enviado com sucesso",{ "Fechar" })

		Else

			Alert("Erro de envio de email")

		EndIf

	EndIf

return

/*/{Protheus.doc} CABA69B
	Acompanhamento de solicitação
	@type  Function
	@author Fred Jr
	@since 02/09/2021
	Abrir tela para preencher campos de contato, telefone e descrição no encerramento sob acompanhamento
/*/
User Function CABA69B()

	Local cRet			:= M->ZX_TPINTEL
	Local oDlgFil
	Local oContat
	Local cContat		:= M->ZX_CONTENC
	Local oTelef
	Local cTelef		:= M->ZX_TELEENC
	Local oDescr
	Local cDescri		:= M->ZX_DESCENC
	Local nOpcFil		:= 0

	if M->ZX_TPINTEL == '4'

		DEFINE MSDIALOG oDlgFil TITLE "Acompanhamento de Solicitação" FROM 000,000 TO 200,410 PIXEL

		@ 015,130 SAY "IMPORTANTE: "												SIZE 300,008	PIXEL OF oDlgFil
		@ 025,100 SAY "Campos com preenchimento obrigatório!"						SIZE 300,008	PIXEL OF oDlgFil

		@ 011,008 SAY "Contato:"	 				 								SIZE 300,008	PIXEL OF oDlgFil
		@ 010,050 MSGET oContat	VAR cContat											SIZE 045,008	PIXEL OF oDlgFil

		@ 026,008 SAY "Telefone:" 				 									SIZE 300,008	PIXEL OF oDlgFil
		@ 025,050 MSGET oTelef	VAR cTelef											SIZE 045,008	PIXEL OF oDlgFil

		@ 041,008 SAY "Descrição:"		  					  						SIZE 300,008	PIXEL OF oDlgFil
		@ 040,050 MSGET oDescr	VAR cDescri											SIZE 150,008	PIXEL OF oDlgFil

		@ 056,008 SAY "* Caso precise alterar o preenchido desta tela, utilize a aba Acompanhamento."	SIZE 300,008	PIXEL OF oDlgFil

		@ 074,050 Button "OK"				 		Size 050,012		PIXEL OF oDlgFil 	Action (nOpcFil := 1, oDlgFil:End())
		@ 074,115 Button "CANCELAR"			 		Size 050,012		PIXEL OF oDlgFil 	Action (oDlgFil:End())

		ACTIVATE MSDIALOG oDlgFil CENTERED

		if nOpcFil == 1

			if !empty(cContat) .and. !empty(cTelef) .and. !empty(cDescri)

				M->ZX_CONTENC	:= cContat
				M->ZX_TELEENC	:= cTelef
				M->ZX_DESCENC	:= cDescri

			else

				Alert("O preenchimento dos campos é obrigatório!")

			endif

		endif

		if empty(M->ZX_CONTENC) .or. empty(M->ZX_TELEENC) .or. empty(M->ZX_DESCENC)

			Alert("O preenchimento dos campos de contato, telefone e descrição do acompanhamento de encerramento é obrigatório.")

		endif

	endif

Return cRet

//-------------------------------------------------------------------
/*/{Protheus.doc} GERCART
Rotina copiada do padrão que gera carteiral avulsa Rotina 
padrão PLSA261
@author  Angelo Henrique
@since   31/01/2022
@version 1.0
@type function 
/*/
//-------------------------------------------------------------------
Static Function GERCART()

	Local _nH		:= 0
	Local cExpRdm  	:= ""
	Local cCodLote 	:= ""
	Local aRet     	:= {.F.,{},{},{}}
	Local cNomCar	:= ""
	Local cProtoc	:= ""
	Local aCritica	:= {}
	Local cQuery	:= ""
	Local cAliQry	:= GetNextAlias()

	Default cMatric  	:= ""
	Default cMotivo  	:= ""
	Default cCodInt  	:= ""
	Default dDatVal  	:= ""
	Default lImp     	:= .t.
	Default Lweb	 	:= .f.   //Variavel referente ao Portal do beneficiario
	default lImpressao 	:= .f.

	cCodInt  := PlsIntPad()
	//AjustaSX1()

	If !Pergunte("PLS262")
		Return(aRet)
	EndIf

	cMatric  := MV_PAR01
	cMotivo  := MV_PAR02
	lImp     := (MV_PAR03==1)
	dDatVal  := MV_PAR04
	MV_PAR05 := Alltrim(IIF(Empty(MV_PAR05),"c:\",MV_PAR05)) //Não permite local de gravacao vazio
	cNomCar	 := StrZero(mv_par06,1)

	If Empty(cMatric) .or. Empty(cMotivo) .or. Empty(dDatVal)
		Help("",1,"OBRIGAT")
		Return(aRet)
	EndIf

	DBSELECTAREA("BDE")
	BDE->(DbSetOrder(1))

	BA1->(DbSetOrder(2))
	If ! BA1->(DbSeek(xFilial("BA1")+cMatric))
		If !Lweb
			MsgStop("Usuario não encontrado")
			Return(aRet)
		Else
			Aadd(aCritica, {"","Usuario não encontrado"})
			aRet := {.F.,{},aCritica,{}}
		Endif
	EndIf

	BA3->(DbSetOrder(1))
	If ! BA3->(DbSeek(xFilial("BA3")+BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC)))
		IF !Lweb
			MsgStop("Familia não encontrada")
			Return(aRet)
		Else
			Aadd(aCritica, {"","Familia não encontrada"})
			aRet := {.F.,{},aCritica,{}}
		Endif
	EndIf

	If GetNewPar("MV_PLSMP1V","4") == cMotivo .and. !lImpressao

		If BA1->(DbSeek(xFilial("BA1")+cMatric)) .And. BA1->BA1_VIACAR <> 0

			If !Lweb
				MsgStop("Usuário já possui cartão emitido, não é possível emitir primeira via")
				Return(aRet)
			Else
				Aadd(aCritica, {"","Usuário já possui cartão emitido, não é possível emitir primeira via"})
				aRet := {.F.,{},aCritica,{}}

				Return(aRet)
			Endif

		EndIf
	EndIf

	If GetNewPar("MV_PLSMP1V","4") <> cMotivo .And. BA1->(DbSeek(xFilial("BA1")+cMatric)) .And. BA1->BA1_VIACAR = 0
		If !Lweb
			MsgStop("Usuário não tem a primeira via emitida. Deve ser emitida a primeira via.")
			Return(aRet)
		Else
			Aadd(aCritica, {"","Usuário não tem a primeira via emitida. Deve ser emitida a primeira via."})
			aRet := {.F.,{},aCritica,{}}
			Return(aRet)
		Endif

	EndIf

	If lImp

		_nH := PLSAbreSem("PLSA262.SMF",.F.)

		If  _nH == 0
			If !Lweb
				msgalert("A rotina de geração de carteirinha esta sendo executada por outro usuáio. Inclusão nao poder ser feita neste momento.")
				Return(aRet)
			Else
				Aadd(aCritica, {"","A rotina de geração de carteirinha esta sendo executada por outro usuáio. Inclusão nao poder ser feita neste momento."})
				aRet := {.F.,{},aCritica,{}}
				Return(aRet)
			Endif

		EndIf

		PLSFechaSem(_nH,"PLSA262.SMF")

		cCodLote := PLSA262NUM(cCodInt)
	Else
		cCodLote := "AVULSA"
	EndIf

	If BDE->(FieldPos("BDE_PROTOC"))<>0
		cProtoc:= GetSxENum( "BDE", "BDE_PROTOC" )
	Endif

	If Lweb
		cCodLote := PLSA262NUM(cCodInt)
	Endif

	BA0->(DbSetOrder(1))
	If BA0->(DbSeek(xFilial("BA0")+cCodInt))

		If Empty(BA0->BA0_EXPIDE)
			cExpRdm := AllTrim(GetNewPar("MV_PLSEXPI",""))
		Else
			cExpRdm := AllTrim(BA0->BA0_EXPIDE)
		Endif

		//BEGIN TRANSACTION

		if !lImpressao
			BDE->(RecLock("BDE",.T.))
			BDE->BDE_FILIAL := xFilial("BDE")
			BDE->BDE_CODINT := cCodInt
			BDE->BDE_CODIGO := cCodLote
			If BDE->(FieldPos("BDE_PROTOC")) > 0 .and. Lweb
				BDE->BDE_PROTOC := cProtoc
			Endif
			BDE->(MsUnlock())

			M->BDE_NOMCAR := cNomCar
		endIf

		If ExistBlock(cExpRdm)
			aRet := ExecBlock(cExpRdm,.F.,.F.,{cCodLote,cMotivo,cCodInt,NIL,3,.f.,lImp,dDatVal,nil,Alltrim(MV_PAR05),Lweb,cProtoc,lImpressao})
		Else
			aRet := Plsa264({cCodLote,cMotivo,cCodInt,NIL,3,.f.,lImp,dDatVal,nil,Alltrim(MV_PAR05),,lImpressao},Lweb,cProtoc)
		EndIf

		If ValType(aRet) <> "A"
			aRet := {.F.,{0},{},{}}
		Endif

		If Lweb
			lImp   := .t.
		Endif

		if !lImpressao
			If lImp .and. aRet[1] .And. aRet[2,1]>0
				BDE->(RecLock("BDE",.F.))
				BDE->BDE_UNILOC := "1"
				BDE->BDE_TIPGRU := "3"
				BDE->BDE_STACAR := "1"
				BDE->BDE_TIPGER := "1"
				BDE->BDE_NOMCAR := cNomCar
				BDE->BDE_QTD    := 1
				BDE->(MsUnlock())
			Else
				BDE->(RecLock("BDE",.F.))
				BDE->(DbDelete())
				BDE->(MsUnlock())
			EndIf
			ConfirmSX8()
		endIf

		//END TRANSACTION

	Endif

	If aRet[1] .And. aRet[2,1]>0 .and. !Empty(BED->BED_NUMTIT)
		Plsa261Bxt()
	EndIf

	If aRet[1]
		If !lWeb

			cQuery += " SELECT              				" + c_ent
			cQuery += "     BED.BED_CODINT, 				" + c_ent
			cQuery += "     BED.BED_CODEMP, 				" + c_ent
			cQuery += "     BED.BED_MATRIC, 				" + c_ent
			cQuery += "     BED.BED_TIPREG, 				" + c_ent
			cQuery += "     BED.BED_DIGITO, 				" + c_ent
			cQuery += "     BED.BED_VIACAR, 				" + c_ent
			cQuery += "     BED.BED_NOMUSR, 				" + c_ent
			cQuery += "     BED.BED_DTSOLI, 				" + c_ent
			cQuery += "     BED.BED_CDIDEN  				" + c_ent
			cQuery += " FROM                				" + c_ent
			cQuery += "     " + RetSqlName("BED") + " BED	" + c_ent
			cQuery += " WHERE								" + c_ent
			cQuery += "     BED.BED_FILIAL = '" + xFilial("BED") + "' 	" + c_ent
			cQuery += "     AND BED.BED_CDIDEN = 'AVULSA' 				" + c_ent
			cQuery += "     AND BED.BED_DTSOLI = '" + DTOS(DDATABASE) + "' " + c_ent
			cQuery += "     AND BED_CODINT||BED_CODEMP||BED_MATRIC||BED_TIPREG||BED_DIGITO = '" + MV_PAR01 + "' " + c_ent

			If Select(cAliQry) > 0
				(cAliQry)->(DbCloseArea())
			EndIf

			DbUseArea(.T.,"TopConn",TcGenQry(,,cQuery),cAliQry,.T.,.T.)

			DbSelectArea(cAliQry)

			If ((cAliQry)->(Eof()))

				MsgAlert("Solicitação cancelada! Favor verificar com o setor responsável")

			Else

				MsgAlert("Gerada solicitação com sucesso!")

			EndIf

			If Select(cAliQry) > 0
				(cAliQry)->(DbCloseArea())
			EndIf

		Else
			aRet[3] := {"","Protocolo Numero [ "+cProtoc+ "]"}
		Endif
	EndIf

Return

/*/{Protheus.doc} CAB69I
Rotina para realizar a transferência do protocolo .
Irá encerrar o protocolo atual e abrir um novo com as informações do benefciiário
@type function
@version  1.0
@author angelo.cassago
@since 22/06/2022
/*/
User Function CAB69I() 

Local _cSeq 	:= M->ZX_SEQ
Local _cMat		:= M->ZX_USUARIO
Local _nCont	:= 1
Local _aArSZX	:= SZX->(GetArea())
Local _aArSZY	:= SZY->(GetArea())
Local _aArPBL	:= PBL->(GetArea())
Local _nRecno	:= 0
Local _cProt	:= ""
Local _cTpServ 	:= ""
Local _cHstpad 	:= ""
Local _cTpTran	:= GetNewPar("MV_XTPTRAS","1012")
Local _cAcolTp	:= aCols[1][ Ascan(aHeader,{|x| AllTrim(x[2]) == "ZY_TIPOSV" 	}) ] //Pegar da primeira linha
Local _cMsg		:= ""

If 	_cTpTran == _cAcolTp

	If MsgYesNo("Deseja realmente iniciar o processo de transferência de Setor?")

	//--------------------------------------------------------------------------
	//Fechando a tela 
	//--------------------------------------------------------------------------
	_oDlg:END()

	//Abrindo o novo PA com os dados do benefciário
	_cProt := u_PA_Manut("SZX", 1, 3,_cMat,,_cSeq)

	DbSelectArea("SZX")
	DbSetOrder(1)
	If DbSeek(xFilial("SZX") + _cProt )

		If !Empty(SZX->ZX_DATDE)

			//--------------------------------------------------------------------------
			//Atualizando o PA e Encerrando o protocolo
			//--------------------------------------------------------------------------
			DbSelectArea("SZX")
			DbSetOrder(1)
			If DbSeek(xFilial("SZX") + _cSeq)
				
				RecLock("SZX", .F.)

				SZX->ZX_TPINTEL := "2"	
				SZX->ZX_DATATE 	:= date()
				SZX->ZX_HORATE 	:= STRTRAN(TIME(),":","")
				
				SZX->(MsUnlock())

				DbSelectArea("SZY")
				DbSetOrder(1)
				If DbSeek(xFilial("SZY") + _cSeq)

					_nRecno := 	SZY->(RecNo())
					
					_cTpServ := SZY->ZY_TIPOSV
					_cHstpad := SZY->ZY_HISTPAD

					While SZY->(!EOF()) .and. _cSeq == SZY->ZY_SEQBA
					
						_nCont ++

						SZY->(DbSkip())

					ENDDO
					
					DbGoTo(_nRecno)

					RecLock("SZY", .T.)

					SZY->ZY_FILIAL	:= xFilial("SZY")
					SZY->ZY_SEQBA	:= _cSeq
					SZY->ZY_SEQSERV	:= STRZERO(_nCont,TAMSX3("ZY_SEQSERV")[1])
					SZY->ZY_DTSERV	:= date()
					SZY->ZY_HORASV	:= STRTRAN(TIME(),":","")
					SZY->ZY_TIPOSV	:= _cTpServ
					SZY->ZY_OBS  	:= "CRIACAO AUTOMATICA PELA OPCAO DE LIGACAO TRANSFERIDA"
					SZY->ZY_USDIGIT	:= "SISTEMA"		
					SZY->ZY_HISTPAD := _cHstpad
					SZY->ZY_DTRESPO := date()
					SZY->ZY_HRRESPO := STRTRAN(TIME(),":","")
					SZY->ZY_RESPOST := "PROTOCOLO ENCERRADO AUTOMATICAMENTE PELA OPCAO DE LIGACAO TRANSFERIDA"
					SZY->ZY_LOGRESP :=  "SISTEMA"
					SZY->ZY_PROTFIL := _cProt	
					
					SZY->(MsUnlock())

				EndIf

			EndIf

			EndIf

		EndIf

	EndIf

Else

	DbSelectArea("PBL")
	DbSetOrder(1)
	DbSeek(xFilial("PBL") + _cTpTran)

	_cMsg := "Tipo de Serviço selecionado não permitido para transferência de ligação,"
	_cMsg += " o correto é: " + _cTpTran + " - " + AllTrim(PBL->PBL_YCDSRV)

	Aviso("Atenção", _cMsg, {"OK"})

EndIf

RestArea(_aArPBL)
RestArea(_aArSZY)
RestArea(_aArSZX)

Return
