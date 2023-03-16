#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'PARMTYPE.CH'
#INCLUDE "APWEBSRV.CH"
#INCLUDE "TBICONN.CH"

#DEFINE cEnt Chr(13)+Chr(10)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ WS005    บAutor  ณAngelo Henrique     บ Data ณ  14/06/2017 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณWebService criado para a integra็ใo MOBILE.                 บฑฑ
ฑฑบ          ณIntegra็ใo Protheus x Mobile - Extrato de Reembolso         บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบM้todos.  ณextrato_reembolso: Retorna lista com todos os reembolsos.   บฑฑ
ฑฑบ          ณdetalhe_reembolso: Retorna detalhe de um reembolso          บฑฑ
ฑฑบ          ณhistorico_reembolso: historico do reembolso.                บฑฑ
ฑฑบ          ณstatus_reembolso: status dos reembolsos.                    บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณCABERJ                                                      บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function WS005()

Return

//---------------------------------------------------------------------------------------------------------------
// Inicio - Estruturas utilizadas no m้todo status_reembolso
// Para ser encaminhada no retorno
//---------------------------------------------------------------------------------------------------------------
WSSTRUCT Status

	WSDATA _cChvSta AS STRING								//chave_status
	WSDATA _cDscSta AS STRING								//descricao

ENDWSSTRUCT

WSSTRUCT oRtStat

	WSDATA _cStatus AS BOOLEAN								//status
	WSDATA _cCritic AS STRING 				OPTIONAL 		//motivo_critica
	WSDATA _aStatus AS ARRAY OF Status						//status (Array)

ENDWSSTRUCT

//---------------------------------------------------------------------------------------------------------------
// Fim - Estruturas utilizadas no m้todo status_reembolso
//---------------------------------------------------------------------------------------------------------------


//---------------------------------------------------------------------------------------------------------------
// Inicio - Estruturas utilizadas no m้todo historico_reembolso
// Para ser encaminhada no retorno
//---------------------------------------------------------------------------------------------------------------
WSSTRUCT Historico

	WSDATA  _dDtHor AS DATE 								//data_hora
	WSDATA _cStatId AS STRING 								//status_id

ENDWSSTRUCT

WSSTRUCT oRtHist

	WSDATA _cStatus AS STRING 								//status
	WSDATA _cCritic AS STRING 				OPTIONAL		//motivo_critica
	WSDATA _aHistor AS ARRAY OF Historico 					//historico

ENDWSSTRUCT
//---------------------------------------------------------------------------------------------------------------
// Fim - Estruturas utilizadas no m้todo historico_reembolso
//---------------------------------------------------------------------------------------------------------------


//---------------------------------------------------------------------------------------------------------------
// Inicio - Estruturas utilizadas no m้todo detalhe_reembolso
// Para ser encaminhada no retorno
//---------------------------------------------------------------------------------------------------------------
WSSTRUCT Documento

	WSDATA _cNmApre AS STRING OPTIONAL 						//nome_apresentacao
	WSDATA _cNmArqu AS STRING 								//nome_arquivo
	WSDATA _cCaminh AS STRING 								//caminho_arquivo

ENDWSSTRUCT

WSSTRUCT ItemReemb

	WSDATA _cItemId AS STRING 								//item_id
	WSDATA _cProced AS STRING 								//procedimento
	WSDATA _cProcDs AS STRING 								//procedimento_descricao
	WSDATA _cStatId AS STRING 								//status_id
	WSDATA _cCidade AS STRING OPTIONAL 						//cidade
	WSDATA _cEstado AS STRING OPTIONAL 						//estado
	WSDATA _dDtExec AS DATE   								//data_execucao
	WSDATA _cDocTip AS STRING OPTIONAL 						//documento_tipo
	WSDATA _cDocNum AS STRING OPTIONAL						//documento_numero
	WSDATA _nQtdExe AS FLOAT  								//quantidade_executada
	WSDATA _nVlrApr AS FLOAT  								//valor_apresentado
	WSDATA _nVlrReb AS FLOAT  OPTIONAL 						//valor_reembolsado
	WSDATA _cObserv AS STRING OPTIONAL						//observacao

ENDWSSTRUCT

WSSTRUCT oRtDtRb

	WSDATA _cStatus AS BOOLEAN								//status
	WSDATA _cMtCrit AS STRING				OPTIONAL		//motivo_critica
	WSDATA _aItens 	AS ARRAY OF ItemReemb					//itens
	WSDATA _aDocum 	AS ARRAY OF Documento	OPTIONAL		//documentos

ENDWSSTRUCT
//---------------------------------------------------------------------------------------------------------------
// Fim - Estruturas utilizadas no m้todo detalhe_reembolso
//---------------------------------------------------------------------------------------------------------------


//---------------------------------------------------------------------------------------------------------------
// Inicio - Estruturas utilizadas no m้todo extrato_reembolso
// Para ser encaminhada no retorno
//---------------------------------------------------------------------------------------------------------------
WSSTRUCT ExtBol

	WSDATA _cChvReb AS STRING 								//chave_reembolso
	WSDATA _cMatric AS STRING 								//beneficiario_matricula
	WSDATA _cBenNom AS STRING 								//beneficiario_nome
	WSDATA _nStatId AS INTEGER	 							//status_id
	WSDATA _cCidade AS STRING 	OPTIONAL					//cidade
	WSDATA _cEstado AS STRING 	OPTIONAL					//estado
	WSDATA _dDtIncl AS DATE 								//data_inclusao
	WSDATA _dDtPrev AS DATE 	OPTIONAL					//previsao_pagamento
	WSDATA _cPrestd AS STRING 	OPTIONAL					//prestador_codigo
	WSDATA _cPrNome AS STRING 								//prestador_nome
	WSDATA _cPrCnpj AS STRING 								//prestador_cpf_cnpj
	WSDATA _cTpSvId AS STRING 	OPTIONAL					//tipo_servico_id
	WSDATA _cTpSvDs AS STRING 	OPTIONAL					//tipo_servico_descricao
	WSDATA _nVlAprs AS FLOAT 								//valor_apresentado
	WSDATA _nVlReem AS FLOAT 	OPTIONAL					//valor_reembolsado
	WSDATA _cObserv AS STRING 	OPTIONAL					//observacao

ENDWSSTRUCT

WSSTRUCT oRetReemb

	WSDATA  status	AS BOOLEAN
	WSDATA  critica	AS STRING OPTIONAL
	WSDATA  extrato AS ARRAY OF ExtBol

ENDWSSTRUCT
//---------------------------------------------------------------------------------------------------------------
// Fim - Estruturas utilizadas no m้todo extrato_reembolso
//---------------------------------------------------------------------------------------------------------------

WSSERVICE WS005 DESCRIPTION "Integra็ใo Protheus x Mobile - <b>Extrato de Reembolso</b>" NAMESPACE "WS005"

	//-----------------------------------------------------
	// Inicio - Variaveis do m้todo extrato_reembolso
	//-----------------------------------------------------

	WSDATA _cChvBenf 	AS STRING 			//Matricula do Beneficiแrio
	WSDATA _dDtInic 	AS DATE OPTIONAL 	//Data Inicial do extrato de reembolso
	WSDATA _dDtFina 	AS DATE OPTIONAL	//Data Final do extrato de reembolso
	WSDATA _oRetRb 		AS oRetReemb		//Retorno do Webservice

	//-----------------------------------------------------
	// Fim - Variaveis do m้todo extrato_reembolso
	//-----------------------------------------------------

	//-----------------------------------------------------
	// Inicio - Variaveis do m้todo detalhe_reembolso
	//-----------------------------------------------------

	WSDATA _cChvRb		AS STRING			//Chave do Reembolso
	WSDATA _oRtDet		AS oRtDtRb			//Retorno do Webservice

	//-----------------------------------------------------
	// Fim - Variaveis do m้todo detalhe_reembolso
	//-----------------------------------------------------

	//-----------------------------------------------------
	// Inicio - Variaveis do m้todo historico_reembolso
	//-----------------------------------------------------

	WSDATA _cChvHt 		AS STRING			//Chave do Reembolso
	WSDATA _oRetHt		AS oRtHist			//Retorno do Webservice

	//-----------------------------------------------------
	// Fim - Variaveis do m้todo historico_reembolso
	//-----------------------------------------------------


	//-----------------------------------------------------
	// Inicio - Variaveis do m้todo status_reembolso
	//-----------------------------------------------------

	WSDATA _oRetSt		AS oRtStat			//Retorno do Webservice

	//-----------------------------------------------------
	// Fim - Variaveis do m้todo historico_reembolso
	//-----------------------------------------------------

	WSMETHOD extrato_reembolso  	DESCRIPTION "Metodo para listar os protocolos de reembolso."
	WSMETHOD detalhe_reembolso 		DESCRIPTION "Metodo para retornar os detalhes de um reembolso."
	//WSMETHOD historico_reembolso  	DESCRIPTION "Metodo para retornar o historico de alteracoes de status do reembolso."
	WSMETHOD status_reembolso  		DESCRIPTION "Metodo para retornar a tabela com os status dos reembolsos do beneficiario."

ENDWSSERVICE


/*
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Metodo para listar os protocolos de reembolso              บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CABERJ - WebService                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

WSMETHOD extrato_reembolso WSRECEIVE _cChvBenf,_dDtInic,_dDtFina WSSEND _oRetRb WSSERVICE WS005

	Local lRet          := .T.
	Local _cQuery		:= ""
	Local _cAlias1		:= ""
	Local oTemp			:= Nil
	Local cObs			:= ""
	Local cBaixa 	  	:= ''
	Local cNumBor   	:= ''
	Local cChvTitE2 	:= ''
	Local cPrefixo  	:= ''
	Local cChvTitE1 	:= ""
	Local nStatus		:= 0

	//-------------------------------------------------------------------------------------------------------------------------------------------------------------------
	// objeto que serแ utilizado como retorno deste m้todo.
	//-------------------------------------------------------------------------------------------------------------------------------------------------------------------
	::_oRetRb:extrato	:= {} // Extrato Reembolso

	//-------------------------------------------------------------------------------------------------------------------------------------------------------------------
	//PREPARA AMBIENTE
	//-------------------------------------------------------------------------------------------------------------------------------------------------------------------
	If FindFunction("WfPrepEnv")

		WfPrepEnv("01","01")  //caberj
		//WfPrepEnv("02","01")  //integral

	Else

		PREPARE ENVIRONMENT EMPRESA "01" FILIAL "01"
		//PREPARE ENVIRONMENT EMPRESA "02" FILIAL "01"   // integral

	EndIf

	If !Empty(_cChvBenf)

		//-----------------------------------------------------------------------------
		// Valida็ใo para saber se esta sendo enviado o CPF ou a pr๓pria matricula
		//-----------------------------------------------------------------------------
		If Len(_cChvBenf) < 15

			_cChvBenf := u_WSXFUNC("WSMATCPF(_cChvBenf)")

		EndIf

		_cAlias1 := GetNextAlias()

		_cQuery := "SELECT DISTINCT  																																	" + cEnt
		_cQuery += "ZZQ.ZZQ_SEQUEN CHV_RB,																															" + cEnt
		_cQuery += "    ZZQ.ZZQ_DATDIG,																															" + cEnt
		_cQuery += "    ZZQ.ZZQ_CODEMP CODEMP,																															" + cEnt
		_cQuery += "    BA1.BA1_CODINT||BA1.BA1_CODEMP||BA1.BA1_MATRIC||BA1.BA1_TIPREG||BA1.BA1_DIGITO MATRIC,																															" + cEnt
		_cQuery += "    ZZQ.ZZQ_NOMUSR BENF_NOM,																											   " + cEnt
		_cQuery += "    ZZQ.ZZQ_STATUS ZZQ_STATUS, 																											   " + cEnt
		_cQuery += "    NVL(B44_YSITUA, ' ') STATUS, 																											" + cEnt
		_cQuery += "    NVL(RETORNA_NOME_MUNICIPIO(TRIM(B44.B44_MUNATE)),' ') CIDADE, 																		   " + cEnt
		_cQuery += "    ZZQ.ZZQ_ESTEXE ESTADO,																												   " + cEnt
		_cQuery += "    TO_DATE(ZZQ.ZZQ_DATDIG,'YYYYMMDD') DT_INC,     																						   " + cEnt
		_cQuery += "    NVL(TO_CHAR(TO_DATE(SE1.E1_VENCREA,'YYYYMMDD'),'DD/MM/YYYY'),' ' ) PREV_PAG, 														   " + cEnt
		_cQuery += "    ZZQ.ZZQ_REGEXE  PREST_CD, 																											   " + cEnt
		_cQuery += "    BB0.BB0_NOME PREST_NM, 																												   " + cEnt
		_cQuery += "    ZZQ.ZZQ_CPFEXE PREST_CPF, 																											   " + cEnt
		_cQuery += "    ZZQ.ZZQ_TIPPRO TP_SERV, 																											   " + cEnt
		_cQuery += "    NVL(PCR_DESCRI,' ')      AS TP_DESC,																								   " + cEnt
		_cQuery += "    ZZQ.ZZQ_VLRTOT VL_AP, 																												   " + cEnt
		_cQuery += "     NVL(B44_PREFIX||B44_NUM||B44_PARCEL||B44_TIPO,' ' ) CHVTIT, 																		   " + cEnt
		_cQuery += "    NVL(SE1.E1_VALOR,0) VL_REEMB, 																										   " + cEnt
		_cQuery += "    NVL(SE1.E1_NUM,' ' )  E1_NUM, 																										   "+ cEnt
		_cQuery += "    NVL(SE1.E1_PARCELA,' ' )  E1_PARCELA, 																								   "+ cEnt
		_cQuery += "    NVL(SE1.E1_PREFIXO,' ' )  E1_PREFIXO, 																								   "+ cEnt
		_cQuery += "    NVL(SE1.E1_TIPO,' ' )  E1_TIPO, 																									   "+ cEnt
		_cQuery += "    NVL(  SE2.E2_NUM, ' ' )   E2_NUM 	, 																								   "+ cEnt
		_cQuery += "    NVL(  SE2.E2_BAIXA, ' ' )   E2_BAIXA 	, 																							   "+ cEnt
		_cQuery += "    NVL(  SE2.E2_NUMBOR, ' ' )   E2_NUMBOR, 																							   "+ cEnt
		_cQuery += "    NVL(  SE2.E2_PREFIXO, ' ' )   E2_PREFIXO, 																							   "+ cEnt
		_cQuery += "    NVL(  E2_PARCELA, ' ' )   E2_PARCELA, 																								   "+ cEnt
		_cQuery += "    NVL(  E2_TIPO, ' ' )   E2_TIPO 																										   "+ cEnt
		_cQuery += "FROM  																																	   "+ cEnt
		_cQuery += "	"+RetSqlName("ZZQ")+" ZZQ  																											   "+ cEnt
		_cQuery += "  LEFT JOIN "+RetSqlName("PCR")+"   PCR																							   "+ cEnt
		_cQuery += "  ON PCR.PCR_CODIGO = ZZQ_TIPPRO AND PCR.D_E_L_E_T_ = ' '																				   "+ cEnt
		_cQuery += "  INNER JOIN "+retSqlName("BA1")+" BA1 ON 	  BA1.BA1_CODINT||BA1.BA1_CODEMP||BA1.BA1_MATRIC||BA1.BA1_TIPREG||BA1.BA1_DIGITO = 	ZZQ_CODBEN "+ cEnt
		_cQuery += "  INNER JOIN "+RetSqlName("BA3")+" BA3 ON  BA3.BA3_FILIAL  = '  ' 				  														   "+ cEnt
		_cQuery += "    AND BA3.BA3_CODINT  = BA1.BA1_CODINT   																								   " + cEnt
		_cQuery += "    AND BA3.BA3_CODEMP  = BA1.BA1_CODEMP																								   " + cEnt
		_cQuery += "    AND BA3.BA3_MATRIC  = BA1.BA1_MATRIC 																								   " + cEnt

		_cQuery += "	INNER JOIN "+RetSqlName("BB0")+" BB0 ON BB0.BB0_FILIAL  = '  ' 																																																						" + cEnt
		_cQuery += "    AND BB0.D_E_L_E_T_  = ' '																												" + cEnt
		_cQuery += "    AND BB0.BB0_CGC = ZZQ.ZZQ_CPFEXE																										" + cEnt
		_cQuery += "    AND BB0.BB0_CGC <> ' '																										" + cEnt
		_cQuery += "   LEFT JOIN "+RetSqlName("B44")+" B44 ON B44.B44_FILIAL  = '  ' 																			" + cEnt
		_cQuery += "    AND B44.B44_YCDPTC  = ZZQ.ZZQ_SEQUEN 																									" + cEnt
		_cQuery += "    AND B44.B44_OPEUSR  = ZZQ.ZZQ_CODINT 																									    " + cEnt
		_cQuery += "    AND B44.B44_CODEMP  = ZZQ.ZZQ_CODEMP 																									" + cEnt
		_cQuery += "    AND B44.B44_MATRIC  = ZZQ.ZZQ_MATRIC 																									" + cEnt
		_cQuery += "    AND B44.B44_TIPREG  = ZZQ.ZZQ_TIPREG 																									" + cEnt
		_cQuery += "    AND B44.B44_CPFEXE  = BB0.BB0_CGC 	 																									" + cEnt
		_cQuery += "    AND B44.D_E_L_E_T_  = ' '																												" + cEnt
		_cQuery += "    LEFT JOIN "+RetSqlName("SE1")+" SE1 ON SE1.E1_CODINT   = BA3.BA3_CODINT																	" + cEnt
		_cQuery += "    AND SE1.E1_FILIAL       = '"+xFilial("SE1")+"'    																										" + cEnt
		_cQuery += "    AND SE1.E1_CODEMP   = BA3.BA3_CODEMP																									" + cEnt
		_cQuery += "    AND SE1.E1_MATRIC   = BA3.BA3_MATRIC																									" + cEnt
		_cQuery += "    AND SE1.E1_CODINT   = B44.B44_OPEUSR																									" + cEnt
		_cQuery += "    AND SE1.E1_CODEMP   = B44.B44_CODEMP 																									" + cEnt
		_cQuery += "    AND SE1.E1_MATRIC   = B44.B44_MATRIC																									" + cEnt
		_cQuery += "    AND SE1.E1_TIPREG   = B44.B44_TIPREG																									" + cEnt
		_cQuery += "    AND SE1.E1_PREFIXO  = B44.B44_PREFIX																									" + cEnt
		_cQuery += "    AND SE1.E1_NUM      = B44.B44_NUM 	 																									" + cEnt
		_cQuery += "    AND SE1.E1_TIPO     = B44.B44_TIPO  																									" + cEnt
		_cQuery += "    AND SE1.E1_CLIENTE  = B44.B44_CODCLI																									" + cEnt
		_cQuery += "    AND SE1.D_E_L_E_T_  = ' '																												" + cEnt
		//-------------------------------------------------------------------------------------------------------------------------------------------------------------------
		// DATA INICIAL E DATA FINAL
		//-------------------------------------------------------------------------------------------------------------------------------------------------------------------
		If !(Empty(_dDtInic)) .And. !(Empty(_dDtFina))

			_cQuery += "    AND SE1.E1_ANOBASE||SE1.E1_MESBASE||'01' BETWEEN '" + DTOS(_dDtInic) + "' AND '" + DTOS(_dDtFina) + "'								" + cEnt

		Else

			_cQuery += "    AND SE1.E1_ANOBASE||SE1.E1_MESBASE||'01' > '" + DTOS(YEARSUB(dDatabase,1)) + "' 													" + cEnt

		EndIf
		//-------------------------------------------------------------------------------------------------------------------------------------------------------------------
		//-------------------------------------------------------------------------------------------------------------------------------------------------------------------

		_cQuery += "    AND ( 																																	" + cEnt
		_cQuery += "            (SE1.E1_STATUS = 'A')  																											" + cEnt
		_cQuery += "            OR ( 																															" + cEnt
		_cQuery += "                    SE1.E1_STATUS  ='B'  																									" + cEnt
		_cQuery += "                    AND  																													" + cEnt
		_cQuery += "                    1 <>    ( 																												" + cEnt
		_cQuery += "                                SELECT  																									" + cEnt
		_cQuery += "                                    SIGN(COUNT(*)) 																							" + cEnt
		_cQuery += "                                FROM  																										" + cEnt
		_cQuery += "                                    " + RetSqlName("SE5") + " SE5 																			" + cEnt
		_cQuery += "                                WHERE  																										" + cEnt
		_cQuery += "                                    SE5.E5_FILIAL       = '" + xFilial("SE5") + "' 															" + cEnt
		_cQuery += "                                    AND SE5.E5_PREFIXO  = SE1.E1_PREFIXO 																	" + cEnt
		_cQuery += "                                    AND SE5.E5_NUMERO   = SE1.E1_NUM 																		" + cEnt
		_cQuery += "                                    AND SE5.E5_PARCELA  = SE1.E1_PARCELA 																	" + cEnt
		_cQuery += "                                    AND SE5.E5_TIPO     = SE1.E1_TIPO 																		" + cEnt
		_cQuery += "                                    AND SE5.E5_MOTBX    = 'CAN' 																			" + cEnt
		_cQuery += "                                    AND SE5.D_E_L_E_T_  = ' ' 																				" + cEnt
		_cQuery += "                            )  																												" + cEnt
		_cQuery += "                )  																															" + cEnt
		_cQuery += "        ) 																																	" + cEnt
		_cQuery += "    LEFT JOIN "+RetSqlName("SA1")+" SA1 ON A1_COD = E1_CLIENTE AND A1_LOJA = E1_LOJA AND SA1.D_E_L_E_T_ = ' ' 								" + cEnt
		_cQuery += "    LEFT JOIN "+RetSqlName("SA2")+" SA2 ON A2_CGC = A1_CGC AND SA2.D_E_L_E_T_ = ' '                                                         " + cEnt
		_cQuery += "    LEFT JOIN "+RetSqlName("SE2")+" SE2 ON 																									" + cEnt
		_cQuery += "    SE2.E2_FILIAL        = SE1.E1_FILIAL      																								" + cEnt
		_cQuery += "    AND SE2.E2_PREFIXO   = SE1.E1_PREFIXO																									" + cEnt
		_cQuery += "    AND SE2.E2_NUM       = SE1.E1_NUM 	 																									" + cEnt
		_cQuery += "    AND SE2.E2_TIPO      = 'REM'																											" + cEnt
		_cQuery += "    AND SE2.E2_FORNECE   = SA2.A2_COD																										" + cEnt
		_cQuery += "    AND SE2.E2_LOJA      = SA2.A2_LOJA																										" + cEnt
		_cQuery += "    AND SE2.D_E_L_E_T_   = ' '																												" + cEnt
		_cQuery += "    WHERE																																	" + cEnt
		_cQuery += "          ZZQ_CODBEN LIKE  '" + AllTrim(substr(_cChvBenf,1,14)) + "%'																		" + cEnt
		_cQuery += "          AND TO_DATE(ZZQ.ZZQ_DATDIG, 'YYYYMMDD') >=  SYSDATE - 360																			" + cEnt
		_cQuery += "          AND ZZQ.D_E_L_E_T_  = ' '																											" + cEnt
		_cQuery += "          AND BA3.D_E_L_E_T_  = ' '																											" + cEnt
		_cQuery += "          AND BA1.D_E_L_E_T_  = ' '																											" + cEnt

		If Select(_cAlias1) > 0
			(_cAlias1)->(DbCloseArea())
		EndIf

		PLSQuery(_cQuery,_cAlias1)

		If (_cAlias1)->(EOF())

			::_oRetRb:status	:= .F.
			::_oRetRb:critica	:= "Nใo existem reembolsos para a matricula informada."

			oTemp := WsClassNew("ExtBol")

			oTemp:_cChvReb 		:= ""
			oTemp:_cMatric 		:= ""
			oTemp:_cBenNom 		:= ""
			oTemp:_nStatId 		:= 0
			oTemp:_cCidade 		:= ""
			oTemp:_cEstado 		:= ""
			oTemp:_dDtIncl 		:= CTOD(" / / ")
			oTemp:_dDtPrev 		:= CTOD(" / / ")
			oTemp:_cPrestd 		:= ""
			oTemp:_cPrNome 		:= ""
			oTemp:_cPrCnpj 		:= ""
			oTemp:_cTpSvId 		:= ""
			oTemp:_cTpSvDs 		:= ""
			oTemp:_nVlAprs 		:= 0
			oTemp:_nVlReem 		:= 0
			oTemp:_cObserv 		:= " "

			aAdd( ::_oRetRb:extrato , oTemp)

		EndIf

		While !(_cAlias1)->(EOF())

			::_oRetRb:status	:= .T.

			oTemp := WsClassNew("ExtBol")



			oTemp:_cChvReb 		:= (_cAlias1)->(CHV_RB) 		//chave_reembolso
			oTemp:_cMatric 		:= (_cAlias1)->(MATRIC) 		//beneficiario_matricula
			oTemp:_cBenNom 		:= (_cAlias1)->(BENF_NOM) 		//beneficiario_nome



			//Fun็ใo chamada para retornar os dados da SE2
			cBaixa 	  := (_cAlias1)->E2_BAIXA
			cNumBor   := (_cAlias1)->E2_NUMBOR
			cChvTitE2 := (_cAlias1)->(E2_PREFIXO+E2_NUM+E2_PARCELA+E2_TIPO)
			cPrefixo  := (_cAlias1)->E2_PREFIXO
			cChvTitE1 := (_cAlias1)->(E1_PREFIXO+E1_NUM+E1_PARCELA+E1_TIPO)
			// valida็ใo Status
			if (_cAlias1)->ZZQ_STATUS == '1' .and. (_cAlias1)->DT_INC == dDatabase
				nStatus := 1
			elseif (_cAlias1)->ZZQ_STATUS == '1' .and. (_cAlias1)->DT_INC < dDatabase
				nStatus := 2
			elseif Empty(cBaixa) .and. !Empty(cNumBor) .and. alltrim(cPrefixo) == "RLE"
				nStatus := 3
			elseif (_cAlias1)->ZZQ_STATUS == '2'
				nStatus := 4
			elseif Empty(cChvTitE2)
				nStatus := 5
			elseif !Empty(cChvTitE2) .and. !Empty(cNumBor)  .and. !Empty(cBaixa) .and. alltrim(cPrefixo) == "RLE"
				nStatus := 6
			endif

			oTemp:_nStatId 		:= nStatus						//status_id
			oTemp:_cCidade 		:= (_cAlias1)->(CIDADE) 		//cidade
			oTemp:_cEstado 		:= (_cAlias1)->(ESTADO) 		//estado
			oTemp:_dDtIncl 		:= (_cAlias1)->(DT_INC)		 	//data_inclusao
			oTemp:_dDtPrev 		:= CTOD((_cAlias1)->(PREV_PAG))	//previsao_pagamento
			oTemp:_cPrestd 		:= (_cAlias1)->(PREST_CD) 		//prestador_codigo
			oTemp:_cPrNome 		:= (_cAlias1)->(PREST_NM) 		//prestador_nome
			oTemp:_cPrCnpj 		:= (_cAlias1)->(PREST_CPF) 		//prestador_cpf_cnpj
			oTemp:_cTpSvId 		:= (_cAlias1)->(TP_SERV) 		//tipo_servico_id
			oTemp:_cTpSvDs 		:= (_cAlias1)->(TP_DESC) 		//tipo_servico_descricao
			oTemp:_nVlAprs 		:= (_cAlias1)->(VL_AP)	 		//valor_apresentado
			oTemp:_nVlReem 		:= iif(Val((_cAlias1)->(STATUS)) == 1,0,(_cAlias1)->(VL_REEMB)) 		//valor_reembolsado


			if(nStatus == 1 .or. nStatus == 2 .or. nStatus == 5 )
				If alltrim((_cAlias1)->CODEMP) == 	'0001'
					cObs := OemToAnsi("A previsใo para libera็ใo do reembolso, ้ em at้ 20 dias ๚teis da data de solicita็ใo.")
				else
					cObs := OemToAnsi("A previsใo para libera็ใo do reembolso, ้ em at้ 30 dias ๚teis da data de solicita็ใo.")
				endif
			endif

			oTemp:_cObserv 		:= cObs //" " 	//observacao

			aAdd( ::_oRetRb:extrato , oTemp)

			(_cAlias1)->(DbSkip())

		EndDo

		If Select(_cAlias1) > 0
			(_cAlias1)->(DbCloseArea())
		EndIf

	Else


		::_oRetRb:status	:= .F.
		::_oRetRb:critica	:= "Matricula do beneficiario nใo Informada."

		oTemp := WsClassNew("ExtBol")

		oTemp:_cChvReb 		:= ""
		oTemp:_cMatric 		:= ""
		oTemp:_cBenNom 		:= ""
		oTemp:_nStatId 		:= 0
		oTemp:_cCidade 		:= ""
		oTemp:_cEstado 		:= ""
		oTemp:_dDtIncl 		:= CTOD(" / / ")
		oTemp:_dDtPrev 		:= CTOD(" / / ")
		oTemp:_cPrestd 		:= ""
		oTemp:_cPrNome 		:= ""
		oTemp:_cPrCnpj 		:= ""
		oTemp:_cTpSvId 		:= ""
		oTemp:_cTpSvDs 		:= ""
		oTemp:_nVlAprs 		:= 0
		oTemp:_nVlReem 		:= 0
		oTemp:_cObserv 		:= " "

		aAdd( ::_oRetRb:extrato , oTemp)

	EndIf

Return lRet



/*
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Metodo para detalhar  protocolo  de reembolso              บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CABERJ - WebService                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

WSMETHOD detalhe_reembolso WSRECEIVE _cChvRb WSSEND _oRtDet WSSERVICE WS005

	Local lRet          := .T.
	Local _cQuery		:= ""
	Local _cAlias1		:= ""
	Local oTemp			:= Nil
	Local cObs			:= ""
	Local cBaixa 	 	:= ""
	Local cNumBor   	:= ""
	Local cChvTitE2 	:= ""
	Local cPrefixo  	:= ""
	Local cChvTitE1		:= ""
	Local nStatus       := 0

	// objeto que serแ utilizado como retorno deste m้todo.
	::_oRtDet:_aItens	:= {} // STATUS

	//------------------
	//PREPARA AMBIENTE
	//------------------
	If FindFunction("WfPrepEnv")

		WfPrepEnv("01","01")
		//WfPrepEnv("02","01")

	Else

		PREPARE ENVIRONMENT EMPRESA "01" FILIAL "01"
		//PREPARE ENVIRONMENT EMPRESA "02" FILIAL "01"

	EndIf

	If !Empty(_cChvRb)

		_cAlias1 := GetNextAlias()

		_cQuery += "  SELECT    																											 "+cEnt
		_cQuery += "     NVL(ZZQ.ZZQ_SEQUEN,' ') ITEM_ID,																						"+cEnt
		_cQuery += "     NVL(B45.B45_CODPRO,' ') PRCDM,																							"+cEnt
		_cQuery += "     NVL(TRIM(BR8.BR8_DESCRI),' ') PROC_DESC,																				"+cEnt
		_cQuery += "    TO_DATE(ZZQ.ZZQ_DATDIG,'YYYYMMDD') DT_INC,  																			" + cEnt

		_cQuery += "     CASE "+cEnt
		_cQuery += "          WHEN ZZQ_STATUS = '1' and ZZQ.ZZQ_DATDIG = TO_CHAR(SYSDATE,'YYYYMMDD')   THEN '1'"+cEnt

		_cQuery += "          WHEN ZZQ_STATUS = '1' and ZZQ.ZZQ_DATDIG <> TO_CHAR(SYSDATE,'YYYYMMDD')  "+cEnt
		_cQuery += "          THEN '2'"+cEnt
		_cQuery += "          WHEN NVL(SE2.E2_BAIXA,' ') = ' ' and NVL(SE2.E2_NUMBOR,' ') <> ' ' and SE2.E2_PREFIXO = 'RLE'"+cEnt
		_cQuery += "          THEN '3'"+cEnt
		_cQuery += "          WHEN ZZQ_STATUS = '2'"+cEnt
		_cQuery += "          THEN '4'"+cEnt
		_cQuery += "          WHEN NVL(SE2.E2_PREFIXO,' ') = ' ' AND NVL(SE1.E1_PREFIXO,' ') <> ' ' "+cEnt
		_cQuery += "            THEN '5'"+cEnt
		_cQuery += "          WHEN NVL(SE2.E2_PREFIXO,' ') <> ' ' and NVL(SE2.E2_NUMBOR,' ') <> ' '  and NVL(SE2.E2_BAIXA, ' ') <> ' ' and SE2.E2_PREFIXO = 'RLE'"+cEnt
		_cQuery += "				    THEN  '6'"+cEnt
		_cQuery += "          END "+cEnt
		_cQuery += "		      STATUS,																							"+cEnt
		_cQuery += "    nvl( RETORNA_NOME_MUNICIPIO(TRIM(B44.B44_MUNATE)),' ' ) CIDADE,															"+cEnt
		_cQuery += "     NVL(ZZQ.ZZQ_ESTEXE,' ') ESTADO,																									"+cEnt
		_cQuery += "     NVL(ZZQ.ZZQ_CODEMP,' ') CODEMP,			 																				"+cEnt
		_cQuery += "     NVL(B44_PREFIX||B44_NUM||B44_PARCEL||B44_TIPO,' ') CHVTIT, 																"+cEnt
		_cQuery += "     NVL(B45.B45_DATPRO,' ' ) DT_EXEC,																						"+cEnt
		_cQuery += "     NVL(B45.B45_QTDPRO,0 )QTD_EXEC,																						"+cEnt
		_cQuery += "      NVL(B45.B45_VLRAPR,0) VLR_APR,																						"+cEnt
		_cQuery += "      NVL(B45.B45_VLRPAG,0) VLR_PAG,																							"+cEnt
		_cQuery += "     ZZQ.ZZQ_STATUS,"+cEnt
		_cQuery += "      NVL(SE1.E1_VALOR,0) VL_REEMB, 																																																												"+cEnt
		_cQuery += "    NVL(SE1.E1_TIPO,' ' )  E1_TIPO,"+cEnt
		_cQuery += "    NVL(SE1.E1_PARCELA,' ' )  E1_PARCELA,"+cEnt
		_cQuery += "    NVL(SE1.E1_NUM,' ' )  E1_NUM,"+cEnt
		_cQuery += "    NVL(SE1.E1_PREFIXO,' ' )  E1_PREFIXO,"+cEnt
		_cQuery += "    NVL(  SE2.E2_NUM, ' ' )   E2_NUM 	, 																															"+cEnt
		_cQuery += "    NVL(  SE2.E2_BAIXA, ' ' )   E2_BAIXA 	, 																														"+cEnt
		_cQuery += "    NVL(  SE2.E2_NUMBOR, ' ' )   E2_NUMBOR, 																														"+cEnt
		_cQuery += "    NVL(  SE2.E2_PREFIXO, ' ' )   E2_PREFIXO, 																														"+cEnt
		_cQuery += "    NVL( E2_PARCELA , ' ' ) E2_PARCELA,"+cEnt
		_cQuery += "    NVL(E2_TIPO, ' ' ) E2_TIPO 		"+cEnt
		_cQuery += " FROM "+RetSqlName("ZZQ")+" ZZQ					       																										"+cEnt

		_cQuery += "   INNER JOIN "+RetSqlName("BA1")+" BA1 ON 	BA1.BA1_CODINT = ZZQ.ZZQ_CODINT "+cEnt
		_cQuery += "    AND BA1.BA1_CODEMP = ZZQ.ZZQ_CODEMP"+cEnt
		_cQuery += "    AND BA1.BA1_MATRIC = ZZQ.ZZQ_MATRIC"+cEnt
		_cQuery += "    AND BA1.BA1_TIPREG = ZZQ.ZZQ_TIPREG"+cEnt
		_cQuery += "    AND BA1.BA1_DIGITO = 	ZZQ.ZZQ_DIGITO								"+cEnt
		_cQuery += "  AND BA1.D_E_L_E_T_ = ' '"+cEnt

		_cQuery += "  INNER JOIN  "+RetSqlName("BA3")+" BA3 ON  BA3.BA3_FILIAL  = '"+xFilial("BA3")+"' 				  																					"+cEnt
		_cQuery += "    AND BA3.BA3_CODINT  = BA1.BA1_CODINT   																															"+cEnt
		_cQuery += "    AND BA3.BA3_CODEMP  = BA1.BA1_CODEMP																															"+cEnt
		_cQuery += "    AND BA3.BA3_MATRIC  = BA1.BA1_MATRIC 	 "+cEnt
		_cQuery += "   AND BA3.D_E_L_E_T_ = ' ' "+cEnt
		_cQuery += "   LEFT JOIN "+RetSqlName("B44")+" B44 ON"+cEnt
		_cQuery += "     B44.B44_FILIAL = '"+xFilial("B44")+"'	"+cEnt
		_cQuery += "    AND  B44.B44_YCDPTC = ZZQ.ZZQ_SEQUEN    																			"+cEnt
		_cQuery += "    AND  B44.B44_OPEUSR  = ZZQ.ZZQ_CODINT   																			"+cEnt
		_cQuery += "    AND  B44.B44_CODEMP =  ZZQ.ZZQ_CODEMP  																			"+cEnt
		_cQuery += "    AND  B44.B44_MATRIC = ZZQ.ZZQ_MATRIC  																			"+cEnt
		_cQuery += "    AND  B44.B44_TIPREG  = ZZQ.ZZQ_TIPREG  "+cEnt
		_cQuery += "     AND B44.D_E_L_E_T_ = ' '        																				"+cEnt
		_cQuery += ""+cEnt
		_cQuery += "  LEFT  JOIN "+RetSqlName("B45")+" B45 ON 																					"+cEnt
		_cQuery += "     B45.B45_FILIAL = '  '	"+cEnt
		_cQuery += "     AND B45.B45_OPEMOV	 =  B44.B44_OPEMOV  "+cEnt
		_cQuery += "     AND  B45.B45_ANOAUT = 	B44.B44_ANOAUT																		 							"+cEnt
		_cQuery += "     AND B45.B45_MESAUT	 =  B44.B44_MESAUT  																								"+cEnt
		_cQuery += "     AND B45.B45_NUMAUT  =  B44.B44_NUMAUT 																									"+cEnt
		_cQuery += "     AND B45.D_E_L_E_T_ = ' '																												"+cEnt
		_cQuery += "	LEFT JOIN  																																"+cEnt
		_cQuery += "   "+RetSqlName("BR8")+" BR8 ON																												"+cEnt
		_cQuery += "     BR8.BR8_CODPSA		= B45.B45_CODPRO 																									"+cEnt
		_cQuery += "     AND BR8.BR8_CODPAD = B45.B45_CODPAD            																						"+cEnt
		_cQuery += "  	AND BR8.BR8_FILIAL = '"+xFilial("BR8")+"'		 AND BR8.D_E_L_E_T_ = ' '    																			"+cEnt
		_cQuery += " LEFT JOIN "+RetSqlName("SE1")+" SE1 ON SE1.E1_CODINT   = BA3.BA3_CODINT																	"+cEnt
		_cQuery += "    AND SE1.E1_FILIAL       = '"+xFilial("SE1")+"'    																										"+cEnt
		_cQuery += "    AND SE1.E1_CODEMP   = BA3.BA3_CODEMP																									"+cEnt
		_cQuery += "    AND SE1.E1_MATRIC   = BA3.BA3_MATRIC																									"+cEnt
		_cQuery += "    AND SE1.E1_CODINT   = B44.B44_OPEUSR																									"+cEnt
		_cQuery += "    AND SE1.E1_CODEMP   = B44.B44_CODEMP 																									"+cEnt
		_cQuery += "    AND SE1.E1_MATRIC   = B44.B44_MATRIC																									"+cEnt
		_cQuery += "    AND SE1.E1_TIPREG   = B44.B44_TIPREG																									"+cEnt
		_cQuery += "    AND SE1.E1_PREFIXO  = B44.B44_PREFIX																									"+cEnt
		_cQuery += "    AND SE1.E1_NUM      = B44.B44_NUM 	 																									"+cEnt
		_cQuery += "    AND SE1.E1_TIPO     = B44.B44_TIPO  																									"+cEnt
		_cQuery += "    AND SE1.E1_CLIENTE  = B44.B44_CODCLI																									"+cEnt
		_cQuery += "    AND SE1.D_E_L_E_T_  = ' '																												"+cEnt
		_cQuery += "    AND ( 																																	"+cEnt
		_cQuery += "            (SE1.E1_STATUS = 'A')  																											"+cEnt
		_cQuery += "            OR ( 																															"+cEnt
		_cQuery += "                    SE1.E1_STATUS  ='B'  																									"+cEnt
		_cQuery += "                    AND  																													"+cEnt
		_cQuery += "                    1 <>    ( 																												"+cEnt
		_cQuery += "                                SELECT  																									"+cEnt
		_cQuery += "                                    SIGN(COUNT(*)) 																							"+cEnt
		_cQuery += "                                FROM  																										"+cEnt
		_cQuery += "                                    "+RetSqlName("SE5")+" SE5 																							"+cEnt
		_cQuery += "                                WHERE  																										"+cEnt
		_cQuery += "                                    SE5.E5_FILIAL       = SE1.E1_FILIAL 																				"+cEnt
		_cQuery += "                                    AND SE5.E5_PREFIXO  = SE1.E1_PREFIXO 																	"+cEnt
		_cQuery += "                                    AND SE5.E5_NUMERO   = SE1.E1_NUM 																		"+cEnt
		_cQuery += "                                    AND SE5.E5_PARCELA  = SE1.E1_PARCELA 																	"+cEnt
		_cQuery += "                                    AND SE5.E5_TIPO     = SE1.E1_TIPO 																		"+cEnt
		_cQuery += "                                    AND SE5.E5_MOTBX    = 'CAN' 																			"+cEnt
		_cQuery += "                                    AND SE5.D_E_L_E_T_  = ' ' 																				"+cEnt
		_cQuery += "                            )  																												"+cEnt
		_cQuery += "                )  																															"+cEnt
		_cQuery += "        ) 																																	"+cEnt
		_cQuery += "    LEFT JOIN "+RetSqlName("SA1")+" SA1 ON A1_COD = E1_CLIENTE AND A1_LOJA = E1_LOJA AND SA1.D_E_L_E_T_ = ' ' 								"+cEnt
		_cQuery += "    LEFT JOIN "+RetSqlName("SA2")+" SA2 ON A2_CGC = A1_CGC AND SA2.D_E_L_E_T_ = ' '                                                         "+cEnt
		_cQuery += "    LEFT JOIN "+RetSqlName("SE2")+" SE2 ON 																									"+cEnt
		_cQuery += "    SE2.E2_FILIAL        = SE1.E1_FILIAL      																								"+cEnt
		_cQuery += "    AND SE2.E2_PREFIXO   = SE1.E1_PREFIXO																									"+cEnt
		_cQuery += "    AND SE2.E2_NUM       = SE1.E1_NUM 	 																									"+cEnt
		_cQuery += "    AND SE2.E2_TIPO      = 'REM'																											"+cEnt
		_cQuery += "    AND SE2.E2_FORNECE   = SA2.A2_COD																										"+cEnt
		_cQuery += "    AND SE2.E2_LOJA      = SA2.A2_LOJA																										"+cEnt
		_cQuery += "    AND SE2.D_E_L_E_T_   = ' '																												"+cEnt
		_cQuery += " WHERE																																		"+cEnt
		_cQuery += "    ZZQ.ZZQ_SEQUEN     = '"+_cChvRb+"'      																								"+cEnt
		_cQuery += "     AND ZZQ.D_E_L_E_T_ = ' '    																											"+cEnt
		_cQuery += " ORDER BY B45.B45_FILIAL,B45.B45_OPEMOV,B45.B45_ANOAUT,B45.B45_MESAUT,B45.B45_NUMAUT,B45.B45_SEQUEN											"+cEnt

		If Select(_cAlias1) > 0
			(_cAlias1)->(DbCloseArea())
		EndIf

		PLSQuery(_cQuery,_cAlias1)

		If (_cAlias1)->(EOF())

			//SetSoapFault( ProcName() , "Nใo existem reembolsos para a matricula informada." )
			//lRet := .F.

			::_oRtDet:_cStatus	:= .F.
			::_oRtDet:_cMtCrit	:= "Nใo existem reembolsos para a matricula informada."

			oTemp := WsClassNew("ItemReemb")

			oTemp:_cItemId := ""
			oTemp:_cProced := ""
			oTemp:_cProcDs := ""
			oTemp:_cStatId := ""
			oTemp:_cCidade := ""
			oTemp:_cEstado := ""
			oTemp:_dDtExec := CTOD(" / / ")
			oTemp:_nQtdExe := 0
			oTemp:_nVlrApr := 0

			aAdd( ::_oRtDet:_aItens , oTemp)

		EndIf

		While !(_cAlias1)->(EOF())

			::_oRtDet:_cStatus	:= .T.

			oTemp := WsClassNew("ItemReemb")

			oTemp:_cItemId := (_cAlias1)->(ITEM_ID) 		//item_id
			oTemp:_cProced := (_cAlias1)->(PRCDM) 			//procedimento
			oTemp:_cProcDs := (_cAlias1)->(PROC_DESC) 		//procedimento_descricao

			//Fun็ใo chamada para retornar os dados da SE2
			cBaixa 	  := RetSe2((_cAlias1)->CHVTIT, "E2_BAIXA")
			cNumBor   := RetSe2((_cAlias1)->CHVTIT, "E2_NUMBOR")
			cChvTitE2 := (_cAlias1)->(E2_PREFIXO+E2_NUM+E2_PARCELA+E2_TIPO)
			cPrefixo  := (_cAlias1)->E2_PREFIXO
			cChvTitE1 := (_cAlias1)->(E1_PREFIXO+E1_NUM+E1_PARCELA+E1_TIPO)
			// valida็ใo Status

			QOut(dtoc((_cAlias1)->DT_INC))
			QOut(dtoc(dDatabase))
			if (_cAlias1)->ZZQ_STATUS == '1' .and. dtoc((_cAlias1)->DT_INC) == dtoc(dDatabase)
				nStatus := 1

			elseif (_cAlias1)->ZZQ_STATUS == '1' .and. dtoc((_cAlias1)->DT_INC) <> dtoc(dDatabase)
				nStatus := 2
			elseif Empty(cBaixa) .and. !Empty(cNumBor) .and. alltrim(cPrefixo) == "RLE"
				nStatus := 3
			elseif (_cAlias1)->ZZQ_STATUS == '2'
				nStatus := 4
			elseif Empty(cChvTitE2) .and. !Empty(cChvTitE1)
				nStatus := 5
			elseif !Empty(cChvTitE2) .and. !Empty(cNumBor)  .and. !Empty(cBaixa) .and. alltrim(cPrefixo) == "RLE"
				nStatus := 6
			endif

			oTemp:_cStatId := (_cAlias1)->(STATUS) 			//status_id
			oTemp:_cCidade := (_cAlias1)->(CIDADE) 			//cidade
			oTemp:_cEstado := (_cAlias1)->(ESTADO) 			//estado
			oTemp:_dDtExec := STOD((_cAlias1)->(DT_EXEC))	//data_execucao
			oTemp:_nQtdExe := (_cAlias1)->(QTD_EXEC) 		//quantidade_executada
			oTemp:_nVlrApr := (_cAlias1)->(VLR_APR) 		//valor_apresentado
			oTemp:_nVlrReb := iif(Val((_cAlias1)->(STATUS)) == 1,0,(_cAlias1)->(VLR_PAG))//valor_reembolsado

			if(nStatus == 1 .or. nStatus == 2 .or. nStatus == 5 )
				If alltrim((_cAlias1)->CODEMP) == 	'0001'
					cObs := OemToAnsi("A previsใo para libera็ใo do reembolso, ้ em at้ 20 dias ๚teis da data de solicita็ใo.")
				else
					cObs := OemToAnsi("A previsใo para libera็ใo do reembolso, ้ em at้ 30 dias ๚teis da data de solicita็ใo.")
				endif
			endif

			oTemp:_cObserv 		:= cObs //" " 	//observacao


			aAdd( ::_oRtDet:_aItens , oTemp)

			(_cAlias1)->(DbSkip())

		EndDo

		If Select(_cAlias1) > 0
			(_cAlias1)->(DbCloseArea())
		EndIf

	Else

		//SetSoapFault( ProcName() , "Protocolo de Reembolso nใo Informado." )
		//lRet := .F.

		::_oRtDet:_cStatus	:= .F.
		::_oRtDet:_cMtCrit	:= "Protocolo de Reembolso nใo Informado."

		oTemp := WsClassNew("ItemReemb")

		oTemp:_cItemId := ""
		oTemp:_cProced := ""
		oTemp:_cProcDs := ""
		oTemp:_cStatId := ""
		oTemp:_cCidade := ""
		oTemp:_cEstado := ""
		oTemp:_dDtExec := CTOD(" / / ")
		oTemp:_nQtdExe := 0
		oTemp:_nVlrApr := 0

		aAdd( ::_oRtDet:_aItens , oTemp)

	EndIf

Return lRet


/*
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Metodo para detalhar  protocolo  de reembolso              บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CABERJ - WebService                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

/*WSMETHOD historico_reembolso WSRECEIVE _cChvHt WSSEND _oRetHt WSSERVICE WS005

Local lRet          := .T.

Return lRet*/


/*
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Metodo para detalhar  protocolo  de reembolso              บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CABERJ - WebService                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

WSMETHOD status_reembolso WSRECEIVE NULLPARAM WSSEND _oRetSt WSSERVICE WS005

	Local lRet          := .T.
	Local oTemp			:= Nil
	Local aStatus		:= {}
	Local nX			:= 0
	// objeto que serแ utilizado como retorno deste m้todo.
	::_oRetSt:_aStatus	:= {} // STATUS

	//------------------
	//PREPARA AMBIENTE
	//------------------
	If FindFunction("WfPrepEnv")

		WfPrepEnv("01","01")
		//WfPrepEnv("02","01")

	Else

		PREPARE ENVIRONMENT EMPRESA "01" FILIAL "01"
		//PREPARE ENVIRONMENT EMPRESA "02" FILIAL "01"

	EndIf

	::_oRetSt:_cStatus	:= .T.

	AAdd(aStatus,{"1","Recebido"                          } )
	AAdd(aStatus,{"2","Em anแlise"                        } )
	AAdd(aStatus,{"3","Liberado para pagamento"           } )
	AAdd(aStatus,{"4","Encerrado sem pagamento"           } )
	AAdd(aStatus,{"5","Aguardando pagamento"			  } )
	AAdd(aStatus,{"6","Pagamento efetuado"				  } )
	AAdd(aStatus,{"7","Nใo localizado"					  } )
	AAdd(aStatus,{"8","Aguardando informa็ใo complementar"} )

	For nX := 1 to len(aStatus)

		oTemp := WsClassNew("Status")
		oTemp:_cChvSta 	:= aStatus[nX][1]
		oTemp:_cDscSta 	:= aStatus[nX][2]

		aAdd( ::_oRetSt:_aStatus , oTemp)

	Next nX

	//---------------------------------------------------------------
	//Primeiro Status
	//---------------------------------------------------------------
	/*oTemp := WsClassNew("Status")

	oTemp:_cChvSta 	:= "1"
	oTemp:_cDscSta 	:= "Aguardando Aprovacao"

	aAdd( ::_oRetSt:_aStatus , oTemp)


	//---------------------------------------------------------------
	//Segundo Status
	//---------------------------------------------------------------
	oTemp := WsClassNew("Status")

	oTemp:_cChvSta 	:= "2"
	oTemp:_cDscSta 	:= "Aprovado"

	aAdd( ::_oRetSt:_aStatus , oTemp)


	//---------------------------------------------------------------
	//Terceiro Status
	//---------------------------------------------------------------
	oTemp := WsClassNew("Status")

	oTemp:_cChvSta 	:= "3"
	oTemp:_cDscSta 	:= "Nao Aprovado"
	*/

Return lRet


/*
Fun็ใo para retornar os dados da SE2 de acordo com os parametros passados

*/
Static Function RetSe2(cChaveSE1, cCampo)

	Local _cSQL := ""
	Local cRetorno := ""
	Local Ret

	_cSQL := " SELECT E2_NUMBOR,E2_PREFIXO, E2_NUM, E2_PARCELA, E2_TIPO, E2_EMISSAO, E2_VENCREA, E2_BAIXA,  E2_VALOR, E1_EMIS1, E1_VENCREA,   "
	_cSQL += " E1_BAIXA,E1_PREFIXO,E1_NUM,E1_PARCELA,E1_TIPO "
	_cSQL += " FROM "+RetSQLName("SE2")+" SE2, "+RetSQLName("SE1")+" SE1 "
	_cSQL += " WHERE E2_FILIAL = '"+xFilial("SE2")+"' "
	//_cSQL += " AND E2_TITORIG = '"+cChaveSE1+"' "

	_cSQL += " AND ((SubStr (E2_TITORIG,1,9) || '   '|| SubStr (E2_TITORIG,10,4)) = '"+cChaveSE1+"' "
	_cSQL += " or  (SubStr (SE2.E2_TITORIG,1,3) || '000'|| SubStr (SE2.E2_TITORIG,7,10)) = '"+cChaveSE1+"' "
	_cSQL += " or E2_TITORIG = '"+cChaveSE1+"' )"


	_cSQL += " AND E1_FILIAL = '"+xFilial("SE1")+"' "
	_cSQL += " AND E1_PREFIXO = '"+Substr(cChaveSE1,1,3)+"' "
	_cSQL += " AND E1_NUM = '"+Substr(cChaveSE1,4,9)+"'"
	_cSQL += " AND E1_PARCELA = '"+Substr(cChaveSE1,13,1)+"' "
	_cSQL += " AND E1_TIPO = '"+Substr(cChaveSE1,14,3)+"' "

	_cSQL += " AND SE2.D_E_L_E_T_ = ' ' "
	_cSQL += " AND SE1.D_E_L_E_T_ = ' ' "

	MemoWrite("\DATA\BUSPGTREE.TXT",_cSQL)
	PlsQuery(_cSQL,"TRBRBS")
	cRetorno := "TRBRBS->("+cCampo+")"
	Ret := &cRetorno

	TRBRBS->(DbCloseArea())

Return Ret
