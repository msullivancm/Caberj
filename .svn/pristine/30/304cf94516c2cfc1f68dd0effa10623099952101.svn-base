#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'PARMTYPE.CH'
#INCLUDE "APWEBSRV.CH"
#INCLUDE "TBICONN.CH"

#DEFINE cEnt Chr(13)+Chr(10)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ WS001    บAutor  ณAngelo Henrique     บ Data ณ  03/11/2016 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณWebService criado para ser utilizado no processo de FALE    บฑฑ
ฑฑบDesc.     ณCONOSCO do protocolo de atendimento.                        บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Fabrica de Software                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function WS001()

Return

//------------------------------------------------------------------
//Estrutura de retorno utilizada para lista de protocolo Ouvidoria
//------------------------------------------------------------------
	WSSTRUCT StrOvd

		WSDATA _cPrtLst	AS String //Protocolo + Tipo de Servi็o

	ENDWSSTRUCT

//--------------------------------------------------------------
//Estrutura de retorno utilizada para lista de servi็o
//--------------------------------------------------------------
	WSSTRUCT StrRet

		WSDATA _cCodigo	AS String
		WSDATA _cDescri	AS String

	ENDWSSTRUCT

//--------------------------------------------------------------
//Estrutura de retorno utilizada para Hist๓rico Padrใo
//--------------------------------------------------------------
	WSSTRUCT StrHist

		WSDATA _cCodHst	AS String
		WSDATA _cDeCHst	AS String

	ENDWSSTRUCT

//--------------------------------------------------------------
//Estrutura de retorno utilizada para lista de protocolo
//--------------------------------------------------------------
	WSSTRUCT StrProt

		WSDATA _cProt	AS String //Protocolo
		WSDATA _cData	AS String //Data
		WSDATA _cHora	AS String //Hora
		WSDATA _cStat	AS String //Status

		WSDATA _cTpSv	AS String //Tipo de Servi็o
		WSDATA _cTpDm	AS String //Tipo de Demanda
		WSDATA _cHist	AS String //Historico Padrใo
		WSDATA _cArea	AS String //Area

	ENDWSSTRUCT

//--------------------------------------------------------------
//Estrutura de retorno utilizada para detalhe de protocolo
//--------------------------------------------------------------
	WSSTRUCT StrDetl

		WSDATA _cProt	AS String //Protocolo
		WSDATA _cData	AS String //Data
		WSDATA _cHora	AS String //Hora
		WSDATA _cStat	AS String //Status
		WSDATA _cTpDe	AS String //Demanda
		WSDATA _cDsDe	AS String //Descri็ใo Demanda

		WSDATA _aIten	AS ARRAY OF StrIten //Estrutura de Itens (SZY)

	ENDWSSTRUCT

//--------------------------------------------------------------
//Estrutura utilizada dentro do retorno do detalhe de protocolo
//Estrutura: STRDETL (StrDetl)
//--------------------------------------------------------------
	WSSTRUCT StrIten

		WSDATA _cSeqSrv	AS String //Sequencia dos Itens
		WSDATA _cDtServ	AS String //Data dos Itens
		WSDATA _cHrServ	AS String //Hora dos Itens
		WSDATA _cCodSrv	AS String //Tipo de Servi็o
		WSDATA _cDscSrv	AS String //Descri็ใo do Servi็o
		WSDATA _cCodHst	AS String //Hist๓rico Padrใo
		WSDATA _cDscHst	AS String //Descri็ใo Hist๓rico Padrใo
		WSDATA _cObserv	AS String //Observa็ใo
		WSDATA _cRespos	AS String //Resposta

	ENDWSSTRUCT

//-----------------------------------------------------------------
//Estrutura para realizar o processo de inclusใo
//-----------------------------------------------------------------
	WSSTRUCT StrInc

		//---------------------
		//Cabe็alho
		//---------------------
		WSDATA _cMatUsu	AS String OPTIONAL	//Matricula do beneficiแrio
		WSDATA _cNomUsu	AS String OPTIONAL	//Nome do beneficiแrio
		WSDATA _cEmail	AS String 			//Email do beneficiแrio
		WSDATA _cTipDm	AS String 			//Demanda (Somente o Codigo)
		WSDATA _cTel	AS String 			//Telefone para Contato
		WSDATA _cCanal	AS String 			//Canal
		WSDATA _cPtEnt	AS String 			//Porta de Entrada
		WSDATA _cRDA	AS String OPTIONAL	//RDA
		WSDATA _cTpInt	AS String 			//Tipo Atendimento (Aberto /Fechado)
		WSDATA _cRN412	AS String OPTIONAL  //Cancelamento pedido RN412

		//---------------------
		//Itens
		//---------------------
		WSDATA _cTipSv	AS String 			//Codigo do tipo de servi็o
		WSDATA _cHistr	AS String			//Codigo do Historico Padrใo
		WSDATA _cObsrv	AS String			//Obersa็ใo preenchida

	ENDWSSTRUCT

//--------------------------------------------------------------
//Estrutura de retorno utilizada para lista de demanda
//--------------------------------------------------------------
	WSSTRUCT StrDmd

		WSDATA _cCodigo	AS String
		WSDATA _cDescri	AS String

	ENDWSSTRUCT


	WSSERVICE WS001 DESCRIPTION "Protocolo de Atendimento - <b>Fale Conosco</b>" NAMESPACE "WS001"

		//-----------------------------------------------------
		//Lista das estruturas de retorno do webservice
		//-----------------------------------------------------
		WSDATA tRet 		AS Array of StrRet 	//Lista Tipos de Servi็os
		WSDATA tHst 		AS Array of StrHist //Lista Hist๓rico Padrใo
		WSDATA tPrt 		AS Array of StrProt //Lista Protocolo
		WSDATA tDtl 		AS StrDetl 			//Detalhe Protocolo
		WSDATA tDmd 		AS Array of StrDmd 	//Lista Tipos de Demanda
		WSDATA tOvd 		AS Array of StrOvd  //Lista Protocolo da Ouvidoria

		//-----------------------------------------------------
		//Lista das estruturas de recebimento do webservice
		//-----------------------------------------------------
		WSDATA tInc 		AS StrInc 	//Inclusใo de Protocolo
		WSDATA _cEmpInc		AS STRING	//Empresa para realizar login (CABERJ/INTEGRAL) - Utilizado na Inclusใo de Protocolos

		//-----------------------------------------------------
		//Lista dos parametros de recebimento
		//-----------------------------------------------------
		WSDATA _cCodServ	AS STRING 	//Codigo do Tipo de Servi็o, utilizado para o Hist๓rico Padrใo
		WSDATA _cChvBenf 	AS STRING 	//Matricula do Beneficiแrio - Utilizado no Lista Protocolos
		WSDATA _cEmpLog		AS STRING	//Empresa para realizar login (CABERJ/INTEGRAL) - Utilizado no Lista Protocolos
		WSDATA _cSeqProt	AS STRING	//Protocolo Utilizado no Detalhes Protocolos
		WSDATA _cEmpSite	AS STRING	//Diz a emnpresa para poder exibir os tipos de servi็os
		WSDATA _cMatVs 		AS STRING	//Informa 0 = VISITANTE E 1 = BENEFICIARIO, para saber quais tipo de servi็os listar
		WSDATA _cTipDem		AS STRING	//Informa o tipo de Demanda - Consulta, Elogios e etc
		WSDATA _cTipCan		AS STRING	//Informa o Canal utilizado para a WEB (Ouvidoria - 000002 || Fale Conosco - 000005)
		WSDATA _cCPFBnf 	AS STRING 	//CPF do Beneficiแrio - Utilizado no Lista Protocolos Ouvidoria

		//-----------------------------------------------------
		//Lista dos parametros de retorno
		//-----------------------------------------------------
		WSDATA _cRetProt	AS STRING 	//Retorno 1 do protocolo gerado na inclusใo - Numero do Protocolo

		//------------------------------
		//Declara็ใo dos M้todos
		//------------------------------
		WSMETHOD WS001TPS	DESCRIPTION "M้todo - Lista Tipos de Servi็os."
		WSMETHOD WS001HST	DESCRIPTION "M้todo - Lista Hist๓rico Padrใo."
		WSMETHOD WS001LST	DESCRIPTION "M้todo - Lista Protocolos."
		WSMETHOD WS001DET	DESCRIPTION "M้todo - Detalhes do Protocolo."
		WSMETHOD WS001INC	DESCRIPTION "M้todo - Inclusใo do Protocolo."
		WSMETHOD WS001DMD	DESCRIPTION "M้todo - Lista Tipos de Demanda."
		WSMETHOD WS001OVD	DESCRIPTION "M้todo - Lista Protocolo e Tipo de Servi็o para Ouvidoria."

	ENDWSSERVICE

/*
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Metodo para consulta de tipo de servi็os - protocolo de    บฑฑ
ฑฑบ          ณ atendimento.                                               บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CABERJ - WebService                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
WSMETHOD WS001TPS WSRECEIVE _cEmpSite, 	_cMatVs, _cTipDem, _cTipCan WSSEND tRet WSSERVICE WS001

	Local lRet          := .T.
	Local _cQuery		:= ""
	Local _cAlias1		:= ""
	Local oTemp			:= Nil

	//------------------
	//PREPARA AMBIENTE
	//------------------
	If FindFunction("WfPrepEnv")

		WfPrepEnv("01","01")  //caberj
		//WfPrepEnv("02","01")  //integral

	Else

		PREPARE ENVIRONMENT EMPRESA "01" FILIAL "01"
		//PREPARE ENVIRONMENT EMPRESA "02" FILIAL "01"   // integral

	EndIf

	_cAlias1 := GetNextAlias()

	//----------------------------------------------------------
	//Lista todos os Tipos de Servi็os Utilizados no PA
	//----------------------------------------------------------
	_cQuery := " SELECT " + cEnt
	_cQuery += " 	PBL.PBL_YCDSRV TP_SERVICO, " + cEnt
	_cQuery += " 	PBL.PBL_YDSSRV DESCRICAO " + cEnt
	_cQuery += " FROM " + cEnt
	_cQuery += " 	" + RetSqlName("PBL") + " PBL " + cEnt
	_cQuery += " 	INNER JOIN " + cEnt
	_cQuery += " 	" + RetSqlName("PCG") + " PCG " + cEnt
	_cQuery += " 	ON " + cEnt
	_cQuery += " 		PCG.D_E_L_E_T_ = ' ' " + cEnt
	_cQuery += " 		AND PCG.PCG_CDDEMA = '" + AllTrim(_cTipDem) + "' " + cEnt
	_cQuery += " 		AND PCG.PCG_CDPORT = '000012' " + cEnt //WEB
	_cQuery += " 		AND PCG.PCG_CDCANA = '" + AllTrim(_cTipCan) + "' " + cEnt //Canal
	_cQuery += " WHERE " + cEnt
	_cQuery += " 	PBL.D_E_L_E_T_ = ' ' " + cEnt	

	If _cEmpSite = "01" //CABERJ

		_cQuery += " 	AND PBL.PBL_SITECA = '1' " + cEnt //Site CABERJ = SIM

		If _cMatVs = '0'

			_cQuery += " 	AND PBL.PBL_VISITA = '1' " + cEnt //Visitante

		EndIf

	Else

		_cQuery += " 	AND PBL.PBL_SITEIN = '1' " + cEnt //Site INTEGRAL = SIM

		If _cMatVs = '0'

			_cQuery += " 	AND PBL.PBL_VISITA = '1' " + cEnt //Visitante

		EndIf

	EndIf

	_cQuery += " GROUP BY PBL.PBL_YCDSRV, PBL.PBL_YDSSRV " + cEnt
	_cQuery += " ORDER BY PBL.PBL_YDSSRV " + cEnt

	If Select(_cAlias1) > 0
		(_cAlias1)->(DbCloseArea())
	EndIf

	PLSQuery(_cQuery,_cAlias1)

	If (_cAlias1)->(EOF())

		SetSoapFault( ProcName() , "Nใo foi encontrado nenhum tipo de servi็o para os dados enviados." )
		lRet := .F.

	EndIf

	While !(_cAlias1)->(EOF())

		oTemp := WsClassNew("StrRet")

		oTemp:_cCodigo := Alltrim((_cAlias1)->TP_SERVICO)
		oTemp:_cDescri := Alltrim((_cAlias1)->DESCRICAO )

		aAdd( ::tRet , oTemp)

		(_cAlias1)->(DbSkip())

	EndDo

	If Select(_cAlias1) > 0
		(_cAlias1)->(DbCloseArea())
	EndIf

Return lRet

/*
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Metodo para consulta os Hist๓ricos Padr๕es apartir do      บฑฑ
ฑฑบ          ณ codigo do tipo de servi็o enviado.                         บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CABERJ - WebService                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
WSMETHOD WS001HST WSRECEIVE _cCodServ, _cEmpSite WSSEND tHst WSSERVICE WS001

	Local lRet          := .T.
	Local _cQuery		:= ""
	Local _cAlias1		:= ""
	Local oTemp			:= Nil

	//------------------
	//PREPARA AMBIENTE
	//------------------
	If FindFunction("WfPrepEnv")

		WfPrepEnv("01","01")

	Else

		PREPARE ENVIRONMENT EMPRESA "01" FILIAL "01"

	EndIf

	_cAlias1 := GetNextAlias()

	//----------------------------------------------------------
	//Lista todos os Hist๓ricos Padr๕es apartir do tipo de
	//servi็o enviado.
	//----------------------------------------------------------
	_cQuery := " SELECT " + cEnt
	_cQuery += " 	TRIM(PCE.PCE_TIPOSV) TP_SERVICO,	" + cEnt
	_cQuery += " 	TRIM(PBL.PBL_YDSSRV) DESC_SERVICO, 	" + cEnt
	_cQuery += " 	TRIM(PCE.PCE_CDHIST) HISTORICO, 	" + cEnt
	_cQuery += " 	TRIM(PCD.PCD_DESCRI) DESC_HIST		" + cEnt
	_cQuery += " FROM " + cEnt
	_cQuery += " 	" + RetSqlName("PCE") + " PCE, " + cEnt
	_cQuery += " 	" + RetSqlName("PBL") + " PBL, " + cEnt
	_cQuery += " 	" + RetSqlName("PCD") + " PCD  " + cEnt
	_cQuery += " WHERE " + cEnt
	_cQuery += " 	PCE.D_E_L_E_T_ = ' ' " + cEnt
	_cQuery += " 	AND PBL.D_E_L_E_T_ = ' ' " + cEnt
	_cQuery += " 	AND PCD.D_E_L_E_T_ = ' ' " + cEnt
	_cQuery += " 	AND TRIM(PCE.PCE_TIPOSV) = '" + AllTrim(_cCodServ) + "' " + cEnt
	_cQuery += " 	AND TRIM(PCE.PCE_TIPOSV) = PBL.PBL_YCDSRV " + cEnt
	_cQuery += " 	AND TRIM(PCE.PCE_CDHIST) = PCD.PCD_COD " + cEnt

	If _cEmpSite = "01" //CABERJ

		_cQuery += " 	AND PCE_SITECA = '1' " + cEnt //Site CABERJ = SIM

	Else

		_cQuery += " 	AND PCE_SITEIN = '1' " + cEnt //Site CABERJ = SIM

	EndIf

	_cQuery += " ORDER BY PCD.PCD_DESCRI " + cEnt

	If Select(_cAlias1) > 0
		(_cAlias1)->(DbCloseArea())
	EndIf

	PLSQuery(_cQuery,_cAlias1)

	While !(_cAlias1)->(EOF())

		oTemp := WsClassNew("StrHist")

		oTemp:_cCodHst := Alltrim((_cAlias1)->HISTORICO)
		oTemp:_cDeCHst := Alltrim((_cAlias1)->DESC_HIST)

		aAdd( ::tHst , oTemp)

		(_cAlias1)->(DbSkip())

	EndDo

	If Select(_cAlias1) > 0
		(_cAlias1)->(DbCloseArea())
	EndIf

Return lRet

/*
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Metodo para listar todos os protocolos abertos pelo        บฑฑ
ฑฑบ          ณ beneficiแrio.                                              บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CABERJ - WebService                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
WSMETHOD WS001LST WSRECEIVE _cChvBenf,_cEmpLog WSSEND tPrt WSSERVICE WS001

	Local lRet          := .T.
	Local _cQuery		:= ""
	Local _cAlias1		:= ""
	Local oTemp			:= Nil
	Local _lAchou 		:= .F.
	Local _aArea 		:= Nil
	Local _aArZX 		:= Nil
	Local _aArZY 		:= Nil
	Local _cStatus		:= ""
	Local _cTipSv 		:= ""
	Local _cHstPd		:= ""

	If Empty(AllTrim(_cEmpLog)) .OR. !(AllTrim(_cEmpLog) $ "01|02")

		SetSoapFault( ProcName() , "Nใo foi possivel realizar login no sistema de protocolos." )
		lRet := .F.

	Else

		//------------------
		//PREPARA AMBIENTE
		//------------------
		If FindFunction("WfPrepEnv")

			WfPrepEnv(_cEmpLog,"01")

		Else

			PREPARE ENVIRONMENT EMPRESA _cEmpLog FILIAL "01"

		EndIf

		_cAlias1 := GetNextAlias()

		//------------------------------------------------------------------------
		//Lista todos os protocolos criados pelo beneficiแrio at้ o momento
		//------------------------------------------------------------------------
		_cQuery := " SELECT  		" + cEnt
		_cQuery += " 	ZX_SEQ, 	" + cEnt
		_cQuery += " 	ZX_DATDE, 	" + cEnt
		_cQuery += " 	ZX_HORADE,	" + cEnt
		_cQuery += " 	ZX_TPINTEL, " + cEnt
		_cQuery += " 	ZX_TPDEM, 	" + cEnt
		_cQuery += " 	ZX_CODAREA 	" + cEnt
		_cQuery += " FROM  " + cEnt
		_cQuery += " 	" + RetSqlName("SZX") + " SZX " + cEnt
		_cQuery += " WHERE " + cEnt
		_cQuery += " 	D_E_L_E_T_ = ' ' " + cEnt
		_cQuery += " 	AND ZX_CODINT||ZX_CODEMP||ZX_MATRIC = '" + SUBSTR(_cChvBenf,1,14 )+ "' " + cEnt
		_cQuery += " ORDER BY ZX_SEQ" + cEnt

		If Select(_cAlias1) > 0
			(_cAlias1)->(DbCloseArea())
		EndIf

		PLSQuery(_cQuery,_cAlias1)

		While !(_cAlias1)->(EOF())

			_lAchou := .T.

			oTemp := WsClassNew("StrProt")

			oTemp:_cProt := AllTrim((_cAlias1)->ZX_SEQ)
			oTemp:_cData := DTOC((_cAlias1)->ZX_DATDE)
			oTemp:_cHora := SUBSTR((_cAlias1)->ZX_HORADE,1,2) + ":" + SUBSTR((_cAlias1)->ZX_HORADE,3,2)
			oTemp:_cTpDm := AllTrim(POSICIONE("SX5",1,xFilial("SX5")+"ZT"+AllTrim((_cAlias1)->ZX_TPDEM),"X5_DESCRI"))
			oTemp:_cArea := AllTrim(POSICIONE("PCF",1,xFilial("PCF")+(_cAlias1)->ZX_CODAREA,"PCF_DESCRI"))

			//----------------------------------
			//Valida็ใo da Legenda
			//----------------------------------
			_aArea 	:= GetArea()
			_aArZX 	:= SZX->(GetArea())
			_aArZY 	:= SZY->(GetArea())

			_cStatus := ""
			_cTipSv  := ""

			If (_cAlias1)->ZX_TPINTEL = "1"

				DbSelectArea("SZY")
				DbSetOrder(1)
				If DbSeek(xFilial("SZY") + (_cAlias1)->ZX_SEQ)

					While !EOF() .And. SZY->ZY_SEQBA = (_cAlias1)->ZX_SEQ

						If Empty(_cTipSv)

							_cTipSv := POSICIONE("PBL",1,xFilial("PBL")+SZY->ZY_TIPOSV ,"PBL_YDSSRV")
							_cHstPd	:= POSICIONE("PCD",1,xFilial("PCD")+SZY->ZY_HISTPAD,"PCD_DESCRI")

						EndIf


						If !Empty(AllTrim(SZY->ZY_RESPOST))

							_cStatus := "Em Andamento"
							Exit

						EndIf

						SZY->(DbSkip())

					EndDo

				EndIf

				If Empty(AlLTrim(_cStatus))

					_cStatus := "Pendente"

				EndIf

			Else

				DbSelectArea("SZY")
				DbSetOrder(1)
				If DbSeek(xFilial("SZY") + (_cAlias1)->ZX_SEQ)

					While !EOF() .And. SZY->ZY_SEQBA = (_cAlias1)->ZX_SEQ

						If Empty(_cTipSv)

							_cTipSv := POSICIONE("PBL",1,xFilial("PBL")+SZY->ZY_TIPOSV ,"PBL_YDSSRV")
							_cHstPd	:= POSICIONE("PCD",1,xFilial("PCD")+SZY->ZY_HISTPAD,"PCD_DESCRI")

						EndIf

						SZY->(DbSkip())

					EndDo

				EndIf

				_cStatus := "Encerrado"

			EndIf

			RestArea(_aArZY)
			RestArea(_aArZX)
			RestArea(_aArea)

			oTemp:_cStat := _cStatus
			oTemp:_cTpSv := _cTipSv
			oTemp:_cHist := _cHstPd

			aAdd( ::tPrt , oTemp)

			(_cAlias1)->(DbSkip())

		EndDo

		If !_lAchou

			SetSoapFault( ProcName() , "Nใo foi encontrado nenhum protocolo registrado no sistema." )
			lRet := .F.

		EndIf

		If Select(_cAlias1) > 0
			(_cAlias1)->(DbCloseArea())
		EndIf

	EndIf

Return lRet


/*
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Metodo para detalhes do protocolo de atendimento.          บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CABERJ - WebService                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
WSMETHOD WS001DET WSRECEIVE _cEmpLog, _cSeqProt WSSEND tDtl WSSERVICE WS001

	Local lRet          := .T.
	Local _cQuery		:= ""
	Local _cAlias1		:= ""
	Local oTemp			:= Nil
	Local _lAchou 		:= .F.
	Local _aArea 		:= Nil
	Local _aArZX 		:= Nil
	Local _aArZY 		:= Nil
	Local _cStatus		:= ""

	// objeto que serแ utilizado como retorno deste m้todo.
	::tDtl:_aIten	:= {} // Itens Detalhes

	If Empty(AllTrim(_cEmpLog)) .OR. !(AllTrim(_cEmpLog) $ "01|02")

		SetSoapFault( ProcName() , "Nใo foi possivel realizar login no sistema de protocolos." )
		lRet := .F.

	Else

		//------------------
		//PREPARA AMBIENTE
		//------------------
		If FindFunction("WfPrepEnv")

			WfPrepEnv(_cEmpLog,"01")

		Else

			PREPARE ENVIRONMENT EMPRESA _cEmpLog FILIAL "01"

		EndIf

		_cAlias1 := GetNextAlias()

		//------------------------------------------------------------------------
		//Lista todos os protocolos criados pelo beneficiแrio at้ o momento
		//------------------------------------------------------------------------
		_cQuery := " SELECT  		" + cEnt
		_cQuery += " 	ZX_SEQ, 	" + cEnt
		_cQuery += " 	ZX_DATDE, 	" + cEnt
		_cQuery += " 	ZX_HORADE,	" + cEnt
		_cQuery += " 	ZX_TPINTEL,	" + cEnt
		_cQuery += " 	ZX_TPDEM, 	" + cEnt
		_cQuery += " 	( 			" + cEnt
		_cQuery += " 		 SELECT " + cEnt
		_cQuery += " 		 	TRIM(SX5.X5_DESCRI) " + cEnt
		_cQuery += " 		 FROM  " + cEnt
		_cQuery += " 		 	SX5010 SX5 " + cEnt
		_cQuery += " 		 WHERE  " + cEnt
		_cQuery += " 		 	SX5.X5_TABELA = 'ZT' " + cEnt
		_cQuery += " 		 	AND TRIM(SX5.X5_CHAVE) = TRIM(SZX.ZX_TPDEM) " + cEnt
		_cQuery += " 	)DEMANDA	" + cEnt
		_cQuery += " FROM  " + cEnt
		_cQuery += " 	" + RetSqlName("SZX") + " SZX " + cEnt
		_cQuery += " WHERE " + cEnt
		_cQuery += " 	D_E_L_E_T_ = ' ' " + cEnt
		_cQuery += " 	AND ZX_SEQ = '" + _cSeqProt + "' " + cEnt
		_cQuery += " ORDER BY ZX_SEQ" + cEnt

		If Select(_cAlias1) > 0
			(_cAlias1)->(DbCloseArea())
		EndIf

		PLSQuery(_cQuery,_cAlias1)

		While !(_cAlias1)->(EOF())

			_lAchou := .T.

			::tDtl:_cProt := AllTrim((_cAlias1)->ZX_SEQ)
			::tDtl:_cData := DTOC((_cAlias1)->ZX_DATDE)
			::tDtl:_cHora := SUBSTR((_cAlias1)->ZX_HORADE,1,2) + ":" + SUBSTR((_cAlias1)->ZX_HORADE,3,2)
			::tDtl:_cTpDe := (_cAlias1)->ZX_TPDEM
			::tDtl:_cDsDe := (_cAlias1)->DEMANDA

			//----------------------------------
			//Inicio - Valida็ใo da Legenda
			//----------------------------------
			_aArea 	:= GetArea()
			_aArZX 	:= SZX->(GetArea())
			_aArZY 	:= SZY->(GetArea())

			_cStatus := ""

			DbSelectArea("SZY")
			DbSetOrder(1)
			If DbSeek(xFilial("SZY") + (_cAlias1)->ZX_SEQ)

				While !EOF() .And. SZY->ZY_SEQBA = (_cAlias1)->ZX_SEQ

					If (_cAlias1)->ZX_TPINTEL = "1"

						If !Empty(AllTrim(SZY->ZY_RESPOST))

							_cStatus := "Em Andamento"

						EndIf

					Else

						_cStatus := "Encerrado"

					EndIf

					oTemp := WsClassNew("StrIten")

					oTemp:_cSeqSrv := SZY->ZY_SEQSERV
					oTemp:_cDtServ := DTOC(SZY->ZY_DTSERV)
					oTemp:_cHrServ := SUBSTR(SZY->ZY_HORASV,1,2) + ":" + SUBSTR(SZY->ZY_HORASV,3,2)
					oTemp:_cCodSrv := SZY->ZY_TIPOSV
					oTemp:_cDscSrv := POSICIONE("PBL",1,xFilial("PBL") + SZY->ZY_TIPOSV , "PBL_YDSSRV")
					oTemp:_cCodHst := SZY->ZY_HISTPAD
					oTemp:_cDscHst := POSICIONE("PCD",1,xFilial("PCD") + SZY->ZY_HISTPAD, "PCD_DESCRI")
					oTemp:_cObserv := SZY->ZY_OBS
					oTemp:_cRespos := SZY->ZY_RESPOST

					aAdd( ::tDtl:_aIten , oTemp)

					SZY->(DbSkip())

				EndDo

			EndIf

			If Empty(AllTrim(_cStatus))

				_cStatus := "Pendente"

			EndIf

			RestArea(_aArZY)
			RestArea(_aArZX)
			RestArea(_aArea)

			::tDtl:_cStat := _cStatus

			//----------------------------------
			//Fim - Valida็ใo da Legenda
			//----------------------------------

			(_cAlias1)->(DbSkip())

		EndDo

		If !_lAchou

			SetSoapFault( ProcName() , "Nใo foi encontrado nenhum protocolo registrado no sistema." )
			lRet := .F.

		EndIf

		If Select(_cAlias1) > 0
			(_cAlias1)->(DbCloseArea())
		EndIf

	EndIf

Return lRet

/*
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Metodo para detalhes do protocolo de atendimento.          บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CABERJ - WebService                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
WSMETHOD WS001INC WSRECEIVE tInc, _cEmpInc WSSEND _cRetProt WSSERVICE WS001

	Local lRet      := .T.
	Local _aArea 	:= Nil
	Local _aArZX 	:= Nil
	Local _aArZY 	:= Nil
	Local _aArB1 	:= Nil
	Local _aArCG 	:= Nil
	Local _aArBL 	:= Nil
	Local _cMat 	:= tInc:_cMatUsu//Matricula do beneficiแrio
	Local _cNomUsu	:= tInc:_cNomUsu//Matricula do beneficiแrio
	Local _cEmail 	:= tInc:_cEmail //Email do beneficiแrio
	Local _cTpDm	:= tInc:_cTipDm //Demanda (Somente o Codigo)
	Local _cTpSv 	:= tInc:_cTipSv //Codigo do tipo de servi็o
	Local _cHst		:= tInc:_cHistr //Codigo do Historico Padrใo // COMENTADO EM 14/11/2017 - POR ORIENTAวรO DA MARIA. -- Reativado 05/03/2021
	Local _cObs		:= tInc:_cObsrv //Observa็ใo preenchida
	Local _cTel		:= tInc:_cTel 	//Telefone
	Local _cCanal	:= tInc:_cCanal //Canal
	Local _cPtEnt	:= tInc:_cPtEnt //Porta de Entrada
	Local _cRDA		:= tInc:_cRDA 	//RDA
	Local _cTipAt	:= tInc:_cTpInt //Aberto / Fechado
	Local _cRN412	:= tInc:_cRN412 //Cancelamento pedido RN412

	//----------------------------------------------------------
	//Variaveis declaradas para quando for visitante
	//----------------------------------------------------------
	Local _cNomUsr 	:= ""
	Local _cCodInt 	:= ""
	Local _cCodEmp 	:= ""
	Local _cMatric 	:= ""
	Local _cTipReg 	:= ""
	Local _cDigito 	:= ""
	Local _dDtNasc 	:= CTOD(" / / ")
	Local _cPlano	:= ""
	Local _cCPF		:= ""
	//----------------------------------------------------------

	Local _nSla 	:= 0
	Local _cSeq		:= ""
	Local _cCdAre	:= ""	
	Local _cMailTp	:= "" //Email da Area Responsแvel

	Local _lAchou	:= .F.

	If Empty(AllTrim(_cEmpInc))

		SetSoapFault( ProcName() , "Nใo foi possivel realizar login no sistema de protocolos." )
		lRet := .F.

	ElseIf !(AllTrim(_cEmpInc) $ "01|02")

		SetSoapFault( ProcName() , "Nใo foi possivel realizar login no sistema de protocolos." )
		lRet := .F.

	Else

		//------------------
		//PREPARA AMBIENTE
		//------------------
		If FindFunction("WfPrepEnv")

			WfPrepEnv(_cEmpInc,"01")

		Else

			PREPARE ENVIRONMENT EMPRESA _cEmpInc FILIAL "01"

		EndIf

		_aArea 	:= GetArea()
		_aArZX 	:= SZX->(GetArea())
		_aArZY 	:= SZY->(GetArea())
		_aArB1 	:= BA1->(GetArea())
		_aArBI 	:= BI3->(GetArea())
		_aArCG 	:= PCG->(GetArea())
		_aArBL 	:= PBL->(GetArea())

		//Valida็ใo Matricula
		If !(Empty(AllTrim(_cMat)))

			DbSelectArea("BA1")
			DbSetOrder(2)
			If DbSeek(xFilial("BA1") + _cMat)

				_cNomUsr := BA1->BA1_NOMUSR
				_cCodInt := BA1->BA1_CODINT
				_cCodEmp := BA1->BA1_CODEMP
				_cMatric := BA1->BA1_MATRIC
				_cTipReg := BA1->BA1_TIPREG
				_cDigito := BA1->BA1_DIGITO
				_dDtNasc := BA1->BA1_DATNAS
				_cPlano	 := POSICIONE("BI3",1,BA1->(BA1_FILIAL+BA1_CODINT+BA1_CODPLA+BA1_VERSAO),"BI3_CODIGO+' '+BI3_DESCRI")
				_cCPF	 := BA1->BA1_CPFUSR

			Else

				SetSoapFault( ProcName() , "Nใo foi possivel encontrar o beneficiแrio com os dados fornecidos." )
				lRet := .F.

			EndIf

		EndIf

		//--------------------------------------------------------------
		//valida็ใo  de mais dados do protocolo
		//--------------------------------------------------------------
		If WS01VLD(tInc) .And. lRet

			SetSoapFault( ProcName() , "FDO - Faltam Dados Obrigat๓rios" )
			lRet := .F.

		ElseIf lRet

			_cSeq := u_GerNumPA() // Gera็ใo de n๚mero da PA

			//------------------------------------------
			//Pegando a quantidade de SLA
			//------------------------------------------
			DbSelectArea("PCG")
			DbSetOrder(1)
			If DbSeek(xFilial("PCG") + PADR(AllTrim(_cTpDm),TAMSX3("PCG_CDDEMA")[1]) + PADR(AllTrim(_cPtEnt),TAMSX3("PCG_CDPORT")[1]) + PADR(AllTrim(_cCanal),TAMSX3("PCG_CDCANA")[1]) + PADR(AllTrim(_cTpSv),TAMSX3("PCG_CDSERV")[1]) )

				_nSla := PCG->PCG_QTDSLA

			Else

				_nSla := 0

			EndIf

			//----------------------------------------------
			//Ponterar na Tabela de PBL (Tipo de Servi็o)
			//Pegando assim a Area
			//----------------------------------------------
			DbSelectArea("PBL")
			DbSetOrder(1)
			If DbSeek(xFilial("PBL") + PADR(AllTrim(_cTpSv),TAMSX3("PBL_YCDSRV")[1]))

				_cCdAre := PBL->PBL_AREA

			EndIf

			//------------------------------------------------------------------------------
			//Inicio do Processo de leitura das informa็๕es encaminhadas para grava็ใo
			//------------------------------------------------------------------------------
			DbSelectArea("SZX")
			DbSetOrder(1)
			_lAchou := DbSeek(xFilial("SZX") + _cSeq)

			RecLock("SZX",!_lAchou)

			SZX->ZX_FILIAL 	:= xFilial("SZX")
			SZX->ZX_SEQ 	:= _cSeq
			SZX->ZX_DATDE 	:= dDataBase
			SZX->ZX_HORADE 	:= STRTRAN(TIME(),":","")

			If _cPtEnt = "000012" .OR. _cTipAt == "2" //WEB

				If _cTipAt == "2" //Se vier fechado

					SZX->ZX_DATATE 	:= dDataBase
					SZX->ZX_HORATE 	:= STRTRAN(TIME(),":","")

				EndIf

			EndIf

			SZX->ZX_NOMUSR 	:= IIF(Empty(Alltrim(_cNomUsr)),_cNomUsu, _cNomUsr)
			SZX->ZX_CODINT 	:= _cCodInt
			SZX->ZX_CODEMP 	:= _cCodEmp
			SZX->ZX_MATRIC 	:= _cMatric
			SZX->ZX_TIPREG 	:= _cTipReg
			SZX->ZX_DIGITO 	:= _cDigito
			SZX->ZX_TPINTEL	:= _cTipAt  //Status aberto/Fechado -- Se for Interna็ใo WEB serแ criado fechado
			SZX->ZX_YDTNASC	:= _dDtNasc
			SZX->ZX_EMAIL 	:= _cEmail
			SZX->ZX_RDA		:= _cRDA
			SZX->ZX_CONTATO	:= _cTel
			SZX->ZX_YPLANO 	:= _cPlano
			SZX->ZX_TPDEM	:= _cTpDm 	//Tipo de Demanda
			SZX->ZX_CANAL	:= _cCanal  //"000005" //Fale Conosco
			SZX->ZX_SLA  	:= _nSla	//SLA
			SZX->ZX_PTENT 	:= _cPtEnt  //"000002" //Porta de Entrada
			SZX->ZX_CODAREA := _cCdAre	//Codigo da Area
			SZX->ZX_VATEND	:= "3"    	//Seguindo o protocolo anterior (Novo PA nใo utiliza este campo)
			SZX->ZX_TPATEND := "1"
			SZX->ZX_YDTINC	:= dDataBase
			SZX->ZX_USDIGIT := "WEB"
			SZX->ZX_YAGENC  := POSICIONE("PBL",1,XFILIAL("PBL") + _cTpSv,"PBL_YDEPTO")
			SZX->ZX_CPFUSR	:= _cCPF
			SZX->ZX_PESQUIS := "4" //NรO AVALIADO

			If !Empty(AllTrim(_cRN412))

				SZX->ZX_RN412 := "S" //Cancelamento RN412

			EndIf

			SZX->(MsUnLock())

			//-----------------------------------
			//Itens
			//-----------------------------------
			DbSelectArea("SZY")
			DbSetOrder(1)
			_lAchou := DbSeek(xFilial("SZY") + _cSeq)

			RecLock("SZY",!_lAchou)

			SZY->ZY_FILIAL 	:= xFilial("SZY")
			SZY->ZY_SEQBA	:= _cSeq
			SZY->ZY_SEQSERV	:= "000001"
			SZY->ZY_DTSERV	:= dDataBase
			SZY->ZY_HORASV	:= STRTRAN(TIME(),":","")
			SZY->ZY_TIPOSV	:= _cTpSv
			SZY->ZY_OBS		:= _cObs
			SZY->ZY_USDIGIT	:= "WEB"
			SZY->ZY_HISTPAD	:= _cHst
			SZY->ZY_PESQUIS := "4" //NรO AVALIADO

			SZY->(MsUnLock())

			DbSelectArea("PBL")
			DbSetOrder(1)
			If DbSeek(xFilial("PBL") + PADR(AllTrim(_cTpSv),TAMSX3("PBL_YCDSRV")[1]))

				_cMailTp	:= PBL->PBL_EMAIL

			EndIf

			::_cRetProt := _cSeq + ";" + AllTrim(_cMailTp) + ";" + cValToChar(_nSla)

		EndIf

	EndIf

	RestArea(_aArBL)
	RestArea(_aArCG)
	RestArea(_aArZX)
	RestArea(_aArZY)
	RestArea(_aArB1)
	RestArea(_aArBI)
	RestArea(_aArea)

Return lRet

/*
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Metodo para consulta de tipo de demanda  - protocolo de    บฑฑ
ฑฑบ          ณ atendimento.                                               บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CABERJ - WebService                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
WSMETHOD WS001DMD WSRECEIVE NULLPARAM WSSEND tDmd WSSERVICE WS001

	Local lRet          := .T.
	Local _cQuery		:= ""
	Local _cAlias1		:= ""
	Local oTemp			:= Nil

	//------------------
	//PREPARA AMBIENTE
	//------------------
	If FindFunction("WfPrepEnv")

		WfPrepEnv("01","01")

	Else

		PREPARE ENVIRONMENT EMPRESA "01" FILIAL "01"

	EndIf

	_cAlias1 := GetNextAlias()

	//----------------------------------------------------------
	//Lista todos os Tipos de Servi็os Utilizados no PA
	//----------------------------------------------------------
	_cQuery := " SELECT 							" + cEnt
	_cQuery += " 	SX5.X5_CHAVE CHAVE, 			" + cEnt
	_cQuery += " 	SX5.X5_DESCRI DESCRICAO 		" + cEnt
	_cQuery += " FROM 								" + cEnt
	_cQuery += " 	" + RetSqlName("SX5") + " SX5 	" + cEnt
	_cQuery += " WHERE 								" + cEnt
	_cQuery += " 	SX5.D_E_L_E_T_ = ' ' 			" + cEnt
	_cQuery += " 	AND SX5.X5_TABELA = 'ZT' 		" + cEnt
	_cQuery += " ORDER BY SX5.X5_CHAVE 				" + cEnt

	If Select(_cAlias1) > 0
		(_cAlias1)->(DbCloseArea())
	EndIf

	PLSQuery(_cQuery,_cAlias1)

	If (_cAlias1)->(EOF())

		SetSoapFault( ProcName() , "Nใo foi possivel realizar login no sistema de protocolos." )
		lRet := .F.

	EndIf

	While !(_cAlias1)->(EOF())

		oTemp := WsClassNew("StrDmd")

		oTemp:_cCodigo := Alltrim((_cAlias1)->CHAVE		)
		oTemp:_cDescri := Alltrim((_cAlias1)->DESCRICAO )

		aAdd( ::tDmd , oTemp)

		(_cAlias1)->(DbSkip())

	EndDo

	If Select(_cAlias1) > 0
		(_cAlias1)->(DbCloseArea())
	EndIf

Return lRet


/*
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Metodo para listar todos os protocolos abertos pelo        บฑฑ
ฑฑบ          ณ beneficiแrio.                                              บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CABERJ - WebService                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
WSMETHOD WS001OVD WSRECEIVE _cCPFBnf, _cEmpLog WSSEND tOvd WSSERVICE WS001

	Local lRet          := .T.
	Local _cQuery		:= ""
	Local _cAlias1		:= ""
	Local oTemp			:= Nil
	Local _lAchou 		:= .F.

	If Empty(AllTrim(_cEmpLog)) .OR. !(AllTrim(_cEmpLog) $ "01|02")

		SetSoapFault( ProcName() , "Nใo foi possivel realizar login no sistema de protocolos." )
		lRet := .F.

	Else

		//------------------
		//PREPARA AMBIENTE
		//------------------
		If FindFunction("WfPrepEnv")

			WfPrepEnv(_cEmpLog,"01")

		Else

			PREPARE ENVIRONMENT EMPRESA _cEmpLog FILIAL "01"

		EndIf

		_cAlias1 := GetNextAlias()

		//------------------------------------------------------------------------
		//Lista todos os protocolos criados pelo beneficiแrio at้ o momento
		//para serem concatenados com o tipo de servi็o e ser exibido no
		//momento em que esta sendo criado o protocolo de atendimento da
		//ouvidoria
		//------------------------------------------------------------------------
		_cQuery := " SELECT 													" + cEnt
		_cQuery += " 	DISTINCT												" + cEnt
		_cQuery += " 	BA1.BA1_CPFUSR,											" + cEnt
		_cQuery += " 	BA1.BA1_NOMUSR,											" + cEnt
		_cQuery += " 	SZX.ZX_SEQ,												" + cEnt
		_cQuery += " 	SZY.ZY_TIPOSV,											" + cEnt
		_cQuery += " 	PBL.PBL_YDSSRV											" + cEnt
		_cQuery += " FROM 														" + cEnt
		_cQuery += " 	" + RetSqlName("BA1") + " BA1 							" + cEnt
		_cQuery += " 	INNER JOIN 												" + cEnt
		_cQuery += " 		" + RetSqlName("SZX") + " SZX 						" + cEnt
		_cQuery += " 	ON														" + cEnt
		_cQuery += " 		SZX.D_E_L_E_T_ = ' '								" + cEnt
		_cQuery += " 		AND SZX.ZX_CODINT = BA1.BA1_CODINT					" + cEnt
		_cQuery += " 		AND SZX.ZX_CODEMP = BA1.BA1_CODEMP					" + cEnt
		_cQuery += " 		AND SZX.ZX_MATRIC = BA1.BA1_MATRIC					" + cEnt
		_cQuery += " 		AND SZX.ZX_TIPREG = BA1.BA1_TIPREG					" + cEnt
		_cQuery += " 		AND SZX.ZX_DIGITO = BA1.BA1_DIGITO					" + cEnt
		_cQuery += " 	INNER JOIN 												" + cEnt
		_cQuery += " 		" + RetSqlName("SZY") + " SZY 						" + cEnt
		_cQuery += " 	ON														" + cEnt
		_cQuery += " 		SZY.D_E_L_E_T_ = ' '								" + cEnt
		_cQuery += " 		AND SZY.ZY_SEQBA = SZX.ZX_SEQ						" + cEnt
		_cQuery += " 		AND SZY.ZY_SEQSERV = '000001'						" + cEnt
		_cQuery += " 	INNER JOIN												" + cEnt
		_cQuery += " 		" + RetSqlName("PBL") + " PBL 						" + cEnt
		_cQuery += " 	ON														" + cEnt
		_cQuery += " 		PBL.D_E_L_E_T_ = ' '								" + cEnt
		_cQuery += " 		AND TRIM(PBL.PBL_YCDSRV) = TRIM(SZY.ZY_TIPOSV)		" + cEnt
		_cQuery += " WHERE														" + cEnt
		_cQuery += " 	BA1.D_E_L_E_T_ = ' '									" + cEnt
		_cQuery += " 	AND BA1.BA1_CPFUSR = '" + AllTrim(_cCPFBnf) + "'		" + cEnt
		_cQuery += " ORDER BY SZX.ZX_SEQ										" + cEnt

		If Select(_cAlias1) > 0
			(_cAlias1)->(DbCloseArea())
		EndIf

		PLSQuery(_cQuery,_cAlias1)

		While !(_cAlias1)->(EOF())

			_lAchou := .T.

			oTemp := WsClassNew("StrOvd")

			oTemp:_cPrtLst := AllTrim((_cAlias1)->ZX_SEQ) + " - " + AllTrim((_cAlias1)->PBL_YDSSRV)

			aAdd( ::tOvd , oTemp)

			(_cAlias1)->(DbSkip())

		EndDo

		If !_lAchou

			SetSoapFault( ProcName() , "Nใo foi encontrado nenhum protocolo registrado no sistema." )
			lRet := .F.

		EndIf

		If Select(_cAlias1) > 0
			(_cAlias1)->(DbCloseArea())
		EndIf

	EndIf

Return lRet

//-------------------------------------------------------------------
/*/{Protheus.doc} function WS01VLD
Fun็ใo para realizar a valida็ใo de alguns itens
@author  Angelo Henrique
@since   09/07/2021
@version 1.0
@type function
/*/
//-------------------------------------------------------------------
Static Function WS01VLD(_oParam)

	Local _lRet 	:= .F.
	Local _cNomUsu	:= _oParam:_cNomUsu//Nome do beneficiแrio
	Local _cEmail 	:= _oParam:_cEmail //Email do beneficiแrio
	Local _cTpDm	:= _oParam:_cTipDm //Demanda (Somente o Codigo)
	Local _cTpSv 	:= _oParam:_cTipSv //Codigo do tipo de servi็o
	Local _cHst		:= _oParam:_cHistr //Codigo do Historico Padrใo // COMENTADO EM 14/11/2017 - POR ORIENTAวรO DA MARIA. -- Reativado 05/03/2021
	Local _cObs		:= _oParam:_cObsrv //Observa็ใo preenchida
	Local _cTel		:= _oParam:_cTel   //Telefone
	Local _cCanal	:= _oParam:_cCanal //Canal
	Local _cPtEnt	:= _oParam:_cPtEnt //Porta de Entrada

	Default _oParam := Nil

	If Empty(Alltrim(_cNomUsu))
		_lRet 	:= .T.
	ElseIf Empty(Alltrim(_cEmail))
		_lRet 	:= .T.
	ElseIf Empty(Alltrim(_cTpDm))
		_lRet 	:= .T.
	ElseIf Empty(Alltrim(_cTpSv))
		_lRet 	:= .T.
	ElseIf Empty(Alltrim(_cHst))
		_lRet 	:= .T.
	ElseIf Empty(Alltrim(_cObs))
		_lRet 	:= .T.
	ElseIf Empty(Alltrim(_cTel))
		_lRet 	:= .T.
	ElseIf Empty(Alltrim(_cCanal))
		_lRet 	:= .T.
	ElseIf Empty(Alltrim(_cPtEnt))
		_lRet 	:= .T.
	EndIf

Return _lRet
