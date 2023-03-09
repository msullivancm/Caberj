#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'PARMTYPE.CH'
#INCLUDE "APWEBSRV.CH"
#INCLUDE "TBICONN.CH"

#DEFINE cEnt Chr(13)+Chr(10)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ WS002    บAutor  ณAngelo Henrique     บ Data ณ  09/12/2016 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณWebService criado para a integra็ใo MOBILE.                 บฑฑ
ฑฑบ          ณIntegra็ใo Protheus x Mobile - Boletos Bancแrios:           บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบM้todos.  ณlista_boletos: Lista os tํtulos do beneficiแrio.            บฑฑ
ฑฑบ          ณdetalhe_boleto: Retorna o detalhe dos tํtulos.              บฑฑ
ฑฑบ          ณextrato_fatura: Retorna o dados para a gera็ใo da fatura.   บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณCABERJ                                                      บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

user function WS002()

return

//------------------------------------------------------
// Inicio - Estruturas utilizadas no m้todo lista_boleto
// Para ser encaminhada no retorno
//------------------------------------------------------
	WSSTRUCT boletos

		WSDATA _cCodTit		AS STRING			//C๓digo do tํtulo - exemplo REE00012345
		WSDATA _cTitId		AS INTEGER OPTIONAL	//Id de banco de dados da tํtulo
		WSDATA _cContId 	AS INTEGER OPTIONAL	//Id do contrato do beneficiแrio
		WSDATA _dDtEmis		AS DATE				//Data de emissใo do boleto Formato: yyyy-MM-dd
		WSDATA _dDtVenc		AS DATE				//Data de vencimento do boleto Formato: yyyy-MM-dd

		//-----------------------------------------------------------
		//Situa็ใo
		//-----------------------------------------------------------
		//P=A Vencer (em aberto por้m ainda nใo estแ vencido)
		//A=Atrasado (em aberto, por้m jแ vencido)
		//B=Baixado (jแ foi pago)
		//-----------------------------------------------------------
		WSDATA _cSituac		AS STRING

		//-----------------------------------------------------------
		//Tipo de Cobran็a
		//-----------------------------------------------------------
		//C=Consigna็ใo / desconto em folha
		//B=Boleto
		//D=D้bito em conta
		//-----------------------------------------------------------
		WSDATA _cTpCobr		AS STRING
		WSDATA _nValor		AS FLOAT	//Valor total do boleto

	ENDWSSTRUCT

	WSSTRUCT oRetLista

		WSDATA  status		AS BOOLEAN
		WSDATA  cCrit		AS STRING OPTIONAL
		WSDATA  listabol  	AS ARRAY OF boletos
		WSDATA  alerta		AS STRING OPTIONAL

	ENDWSSTRUCT

//------------------------------------------------------
// Fim - Estruturas utilizadas no m้todo lista_boleto
//------------------------------------------------------

//--------------------------------------------------------
// Inicio - Estruturas utilizadas no m้todo detalhe_boleto
//--------------------------------------------------------

	WSSTRUCT instrucao

		//-----------------------------------------------------------------
		//texto da linha de observa็ใo, exemplo: Nใo Receber ap๓s
		//03/12/2015
		//-----------------------------------------------------------------
		WSDATA _cInst	 	AS STRING OPTIONAL

	ENDWSSTRUCT

	WSSTRUCT detalhes

		WSDATA _cCedCnpj	AS STRING			//CNPJ do Cedente do boleto
		WSDATA _cCedCodg	AS STRING			//C๓digo do cedente do boleto
		WSDATA _cCedNome	AS STRING			//Nome do cedente
		WSDATA _cCedEnde	AS STRING OPTIONAL	//Endere็o do cedente
		WSDATA _cCedComp	AS STRING OPTIONAL	//Complemento do endere็o do cedente
		WSDATA _cTitCont	AS STRING OPTIONAL	//C๓digo do contrato do titular
		WSDATA _cTitCPF		AS STRING OPTIONAL	//CPF do titular
		WSDATA _cTitCod		AS STRING OPTIONAL	//C๓digo / Matrํcula do titular
		WSDATA _cTitNome	AS STRING OPTIONAL	//Nome do titular
		WSDATA _cCodCart	AS STRING			//C๓digo da carteira do boleto
		WSDATA _cCodPagm	AS STRING OPTIONAL	//C๓digo do local de pagamento
		WSDATA _cLinDigi	AS STRING			//C๓digo completo da linha digitแvel do boleto(Somente n๚meros)
		WSDATA _cDtVenci	AS DATE				//Data do vencimento do tํtulo
		WSDATA _cDtPagam	AS DATE OPTIONAL	//Se o titulo jแ foi pago, enviar a data do pagamento
		WSDATA _nvalor		AS FLOAT			//Valor do tํtulo liquido do tํtulo, sem multas ou juros
		WSDATA _nMulta		AS FLOAT OPTIONAL	//Valor da multa por atraso
		WSDATA _nJuroDia	AS FLOAT OPTIONAL	//Percentual de juros a ser cobrado por dia de atraso

		//-----------------------------------------------------------------------------------------
		//S = Sim, permite a gera็ใo do boleto
		//N = Nใo. Nใo permite a gera็ใo do boleto
		//-----------------------------------------------------------------------------------------
		//Exemplos a serem considerados:
		//1 - Se o tipo de cobran็a for D้bito em Conta e o titulo NรO
		//estiver vencido, nใo deve permitir gerar o boleto. Neste caso,
		//envie “N”
		//-----------------------------------------------------------------------------------------
		//2 – Se o tipo de cobran็a for Boleto, mas a situa็ใo do titulo for
		//PAGO, nใo deve permitir gerar o boleto. Neste caso, envie “N“
		//-----------------------------------------------------------------------------------------
		//3 – Se o tipo de cobran็a for D้bito em Conta, a situa็ใo for
		//Atrasado e jแ estแ vencido a 3 dias, libera para gera็ใo do
		//Tํtulo. Neste caso, envie “S“
		//-----------------------------------------------------------------------------------------
		//Em resumo, o aplicativo irแ permitir a gera็ใo do boleto toda
		//vez que este campo vier com “S“.
		//-----------------------------------------------------------------------------------------
		WSDATA _cImpBol		AS STRING

		WSDATA _cNumNf		AS STRING OPTIONAL 	//N๚mero da nota fiscal vinculada ao tํtulo

		//---------------------------------------------------------------
		//P=A Vencer (em aberto por้m ainda nใo estแ vencido)
		//A=Atrasado (em aberto, por้m jแ vencido)
		//B=Baixado (jแ foi pago)
		//---------------------------------------------------------------
		WSDATA _cSituac		AS STRING

		//---------------------------------------------------------------
		//C=Consigna็ใo / desconto em folha
		//B=Boleto
		//D=D้bito em conta
		//---------------------------------------------------------------
		WSDATA _cTipCob		AS STRING

		WSDATA _aInst		AS ARRAY OF instrucao OPTIONAL

	ENDWSSTRUCT

	WSSTRUCT oRetDet

		WSDATA  status		AS BOOLEAN
		WSDATA  cCrit		AS STRING OPTIONAL
		WSDATA  detbol  	AS ARRAY OF detalhes
		WSDATA  alerta		AS STRING OPTIONAL

	ENDWSSTRUCT

//--------------------------------------------------------
// Fim - Estruturas utilizadas no m้todo detalhe_boleto
//--------------------------------------------------------

//--------------------------------------------------------
// Inicio - Estruturas utilizadas no m้todo extrato_fatura
//--------------------------------------------------------

	WSSTRUCT composicao

		WSDATA _cServCd	 	AS STRING
		WSDATA _cSrvDsc	 	AS STRING
		WSDATA _nQtd	 	AS FLOAT OPTIONAL
		WSDATA _nVlr	 	AS FLOAT OPTIONAL

	ENDWSSTRUCT

	WSSTRUCT extrato

		WSDATA _cMatBen 	AS STRING
		WSDATA _cNomBen 	AS STRING
		WSDATA _cGrau	 	AS STRING OPTIONAL
		WSDATA _aComp		AS ARRAY OF composicao OPTIONAL

	ENDWSSTRUCT

	WSSTRUCT oRetExt

		WSDATA  status		AS BOOLEAN
		WSDATA  cCrit		AS STRING OPTIONAL
		WSDATA  extbol  	AS ARRAY OF extrato
		WSDATA  alerta		AS STRING OPTIONAL

	ENDWSSTRUCT

//--------------------------------------------------------
// Fim - Estruturas utilizadas no m้todo detalhe_boleto
//--------------------------------------------------------

	WSSERVICE WS002 DESCRIPTION "Integra็ใo Protheus x Mobile - <b>Boletos</b>" NAMESPACE "WS002"

		//----------------------------------------------
		// Inicio - Variaveis do m้todo lista_boletos
		//----------------------------------------------

		WSDATA _cChvBenf 	AS STRING 		//Matricula do Beneficiแrio
		WSDATA _oRet 		AS oRetLista	//Retorno do Webservice

		//----------------------------------------------
		// Fim - Variaveis do m้todo lista_boletos
		//----------------------------------------------

		//----------------------------------------------
		// Inicio - Variaveis do m้todo detalhe_boletos
		//----------------------------------------------

		WSDATA _cTitCd	 	AS STRING			//Codigo do tํtulo do beneficiแrio
		WSDATA _oRetDt		AS oRetDet			//Retorno Webservice de detalhe_boleto

		//----------------------------------------------
		// Fim - Variaveis do m้todo detalhe_boletos
		//----------------------------------------------

		//----------------------------------------------
		// Inicio - Variaveis do m้todo extrato_fatura
		//----------------------------------------------

		WSDATA _cTitEt	 	AS STRING			//Codigo do tํtulo do beneficiแrio
		WSDATA _oRetEt		AS oRetExt			//Retorno Webservice de extrato_fatura

		//----------------------------------------------
		// Fim - Variaveis do m้todo extrato_fatura
		//----------------------------------------------

		WSMETHOD lista_boletos  DESCRIPTION "M้todo para listar os tํtulos do beneficiแrio."
		WSMETHOD detalhe_boleto DESCRIPTION "M้todo para retornar os detalhes do tํtulos."
		WSMETHOD extrato_fatura DESCRIPTION "M้todo para retornar o extrato do tํtulo."

	ENDWSSERVICE

/*
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Metodo para listar os boletos disponiveis                  บฑฑ
ฑฑบ          ณ atendimento.                                               บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CABERJ - WebService                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

WSMETHOD lista_boletos WSRECEIVE _cChvBenf WSSEND _oRet WSSERVICE WS002

	Local lRet          := .T.
	Local _cQuery		:= ""
	Local _cAlias1		:= ""
	Local oTemp			:= Nil
	Local _cTipPag		:= ""
	Local _nCont 		:= 0
	Local nQtdDtVenc	:= 0

	// objeto que serแ utilizado como retorno deste m้todo.
	::_oRet:listabol	:= {} // Titulos

	//------------------
	//PREPARA AMBIENTE
	//------------------
	If FindFunction("WfPrepEnv")

		//WfPrepEnv("01","01")  //caberj
		WfPrepEnv("02","01")  //integral

	Else

		PREPARE ENVIRONMENT EMPRESA "01" FILIAL "01"
		//PREPARE ENVIRONMENT EMPRESA "02" FILIAL "01"   // integral

	EndIf

	_cAlias1 := GetNextAlias()

	If Len(_cChvBenf) < 15

		_cChvBenf := u_WSXFUNC("WSMATCPF(_cChvBenf)")

	EndIf

	_cQuery := " SELECT " + cEnt
	_cQuery += "	BA1.BA1_CODINT||BA1.BA1_CODEMP||BA1.BA1_MATRIC||BA1.BA1_TIPREG||BA1.BA1_DIGITO MATRIC, " + cEnt
	_cQuery += "	TRIM(BA1.BA1_NOMUSR) NOME, " + cEnt
	_cQuery += "	SE1.E1_FILIAL, " + cEnt
	_cQuery += "	SE1.E1_PORTADO, " + cEnt
	_cQuery += "	SE1.E1_AGEDEP, 	" + cEnt
	_cQuery += "	SE1.E1_CONTA, 	" + cEnt
	_cQuery += "	SE1.E1_VALOR, 	" + cEnt
	_cQuery += "	SE1.E1_SALDO, 	" + cEnt
	_cQuery += "	SE1.E1_PREFIXO, " + cEnt
	_cQuery += "	SE1.E1_NUM, 	" + cEnt
	_cQuery += "	SE1.E1_PARCELA, " + cEnt
	_cQuery += "	SE1.E1_EMISSAO, " + cEnt
	_cQuery += "	SE1.E1_VENCREA, " + cEnt
	_cQuery += "	SE1.E1_VENCTO, 	" + cEnt
	_cQuery += "	SE1.E1_TIPO, 	" + cEnt
	_cQuery += "	SE1.E1_FORMREC 	" + cEnt
	_cQuery += " FROM 	" + cEnt
	_cQuery += "	" + RetSqlName("SE1") + " SE1 , " + cEnt
	_cQuery += "	" + RetSqlName("BA1") + " BA1 , " + cEnt
	_cQuery += "	" + RetSqlName("BA3") + " BA3 	" + cEnt
	_cQuery += " WHERE 	" + cEnt
	_cQuery += "	BA1.BA1_FILIAL 		= '" + xFilial("BA1") + "' " + cEnt
	_cQuery += "	AND BA1.BA1_CODINT||BA1.BA1_CODEMP||BA1.BA1_MATRIC||BA1.BA1_TIPREG||BA1.BA1_DIGITO = '" + AllTrim(_cChvBenf) + "' " + cEnt
	_cQuery += "	AND BA3.BA3_FILIAL 	= '" + xFilial("BA3") + "' " + cEnt
	_cQuery += "	AND BA3.BA3_CODINT 	= E1_CODINT " + cEnt
	_cQuery += "	AND BA3.BA3_CODEMP 	= E1_CODEMP " + cEnt
	_cQuery += "	AND BA3.BA3_MATRIC 	= E1_MATRIC " + cEnt
	_cQuery += "	AND BA1.BA1_DATBLO 	= ' ' " + cEnt
	_cQuery += "	AND SE1.E1_FILIAL 	= '" + xFilial("SE1") + "' " + cEnt
	_cQuery += "	AND SE1.E1_CODINT 	= BA1.BA1_CODINT 	" + cEnt
	_cQuery += "	AND SE1.E1_CODEMP 	= BA1.BA1_CODEMP	" + cEnt
	_cQuery += "	AND SE1.E1_MATRIC 	= BA1.BA1_MATRIC 	" + cEnt
	_cQuery += "	AND SE1.E1_PREFIXO 	= 'PLS' " + cEnt
	_cQuery += "	AND SE1.E1_PORTADO  = '237' " + cEnt
	_cQuery += "	AND SE1.E1_TIPO NOT IN ('PR','RA') " + cEnt
	_cQuery += "	AND SE1.E1_YTPEXP IN ('L','D') " + cEnt
	_cQuery += "	AND SE1.E1_SALDO 	> 0 " 	+ cEnt
	_cQuery += "	AND SE1.E1_NUMBCO 	<> ' '" + cEnt
	_cQuery += "	AND SE1.D_E_L_E_T_ 	= ' ' " + cEnt
	_cQuery += "	AND BA1.D_E_L_E_T_ 	= ' ' " + cEnt
	_cQuery += "	AND BA3.D_E_L_E_T_ 	= ' ' " + cEnt
	_cQuery += " ORDER BY 1, 13 " + cEnt //Ordenando por: Matricula e Data de Vencimento.
	//CONOuT(_cQuery)
	If Select(_cAlias1) > 0
		(_cAlias1)->(DbCloseArea())
	EndIf

	PLSQuery(_cQuery,_cAlias1)

	If (_cAlias1)->(EOF())

		//---------------------------------------------------------
		//Conforme informado pelos analistas da RR - Mobile
		//Deve-se smepre encaminhar a mesma estrutura
		//sem preenchimento
		//---------------------------------------------------------

		//::_oRet:status	:= .F.
		//::_oRet:cCrit	:= "Nใo existem boletos para a matricula informada."

		//---------------------------------------------------------
		//Conforme informado pelos analistas da RR - Mobile
		//Deve-se retornar o status como True, pois a critica de
		//matricula invalida ้ tratada no login do beneficiario
		//no App.
		//---------------------------------------------------------

		::_oRet:status	:= .T.

		oTemp := WsClassNew("boletos")

		oTemp:_cCodTit 	:= ""
		oTemp:_dDtEmis	:= CTOD(" / / ")
		oTemp:_dDtVenc	:= CTOD(" / / ")
		oTemp:_cSituac	:= ""
		oTemp:_cTpCobr	:= ""
		oTemp:_nValor	:= 0

		aAdd( ::_oRet:listabol , oTemp)

	EndIf

	//-------------------------------------------
	//Contador para outros titulos a pagar
	//-------------------------------------------
	_nCont := 0

	While !(_cAlias1)->(EOF())

		_nCont ++

		(_cAlias1)->(DbSkip())

	EndDo

	(_cAlias1)->(DbGoTop())

	While !(_cAlias1)->(EOF())

		::_oRet:status	:= .T.

		nQtdDtVenc :=    dDataBase - (_cAlias1)->(E1_VENCREA)

		if (nQtdDtVenc > 60 .and. _nCont == 1) .or. (nQtdDtVenc > 60 .and. _nCont > 1)
			// comentado - 07/08/2017 -
			//	::_oRet:alerta	:= "Exitem " + cValToChar(_nCont) + " d้bitos em aberto. Favor entrar em contato com a nossa Central de Atendimento"
			::_oRet:alerta	:= "Prezado(a) associado(a) consta(m) " + cValToChar(_nCont) + " boleto (s) com vencimentos em aberto. "+cEnt
			::_oRet:alerta	+= "Nesse caso o pagamento deverแ ser realizado em sua totalidade. Favor clicar em 'CONTATOS > FALE CONOSCO > FATURA UNIFICADA'"
			::_oRet:alerta	+= " para solicitar a sua fatura unificada, que serแ enviada no prazo de at้ 48h. "
		ElseIf nQtdDtVenc < 60 .and. _nCont > 1
			// comentado - 07/08/2017 -
			//	::_oRet:alerta	:= "Exitem " + cValToChar(_nCont) + " d้bitos em aberto. Favor entrar em contato com a nossa Central de Atendimento"
			::_oRet:alerta	:= "Prezado(a) associado(a) consta(m) " + cValToChar(_nCont) + " boleto (s) com vencimentos em aberto. "+cEnt
			::_oRet:alerta	+= "Favor providenciar o pagamento desse(s) boleto(s) e, ap๓s a baixa do tํtulo pelo banco no prazo de at้ 02 dias ๚teis,"
			::_oRet:alerta	+= " o boleto com vencimento posterior estarแ disponํvel para pagamento. "
		endif


		oTemp := WsClassNew("boletos")

		if (nQtdDtVenc < 60 .and. (_nCont >= 1 ))

			If (_cAlias1)->E1_FORMREC $ "01|08" //Consigna็ใo

				_cTipPag := "C"

			ElseIf (_cAlias1)->E1_FORMREC $ "04|05|09" //Boleto

				_cTipPag := "B"

			ElseIf (_cAlias1)->E1_FORMREC $ "06" //Debito

				_cTipPag := "D"

			EndIf

			oTemp:_cCodTit 	:= Alltrim((_cAlias1)->(E1_FILIAL+E1_PREFIXO+E1_NUM+E1_PARCELA+E1_TIPO)) //E1_FILIAL+E1_PREFIXO+E1_NUM+E1_PARCELA+E1_TIPO
			oTemp:_dDtEmis	:= (_cAlias1)->(E1_EMISSAO) //Data de emissใo do boleto Formato: yyyy-MM-dd
			oTemp:_dDtVenc	:= (_cAlias1)->(E1_VENCREA) //Data de vencimento do boleto Formato: yyyy-MM-dd

		/*	conout("Data de Vencimento Real: "+cvaltochar((_cAlias1)->(E1_VENCREA)))
			conout("Data de Vencimento Real: "+cvaltochar(dDatabase))
			conout(IIF((_cAlias1)->(E1_VENCREA) <= dDatabase,"P","A"))*/
			oTemp:_cSituac	:= IIF((_cAlias1)->(E1_VENCREA) >= dDatabase,"P","A") //P = A Vencer (em aberto por้m ainda nใo estแ vencido) || A = Atrasado (em aberto, por้m jแ vencido)
			oTemp:_cTpCobr	:= _cTipPag
			oTemp:_nValor	:= (_cAlias1)->(E1_VALOR)

			aAdd( ::_oRet:listabol , oTemp)

		Else

			oTemp:_cCodTit 	:= ""
			oTemp:_dDtEmis	:= CTOD(" / / ")
			oTemp:_dDtVenc	:= CTOD(" / / ")
			oTemp:_cSituac	:= ""
			oTemp:_cTpCobr	:= ""
			oTemp:_nValor	:= 0

			aAdd( ::_oRet:listabol , oTemp)


		endif

		If _nCont > 1

			Exit

		EndIf

		(_cAlias1)->(DbSkip())

	EndDo

	If Select(_cAlias1) > 0
		(_cAlias1)->(DbCloseArea())
	EndIf

Return lRet


/*
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Metodo para detalhar o boleto selecionado pelo beneficiarioบฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CABERJ - WebService                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

WSMETHOD detalhe_boleto WSRECEIVE _cTitCd WSSEND _oRetDt WSSERVICE WS002

	Local lRet          := .T.
	Local _cQuery		:= ""
	Local _cAlias1		:= ""
	Local oTemp			:= Nil
	Local _cTipPag		:= ""
	Local _aLinDig		:= {}
	Local _aTemp		:= {}
	Local _oRetDt		:= WsclassNew("oRetDet")

	// objeto que serแ utilizado como retorno deste m้todo.
	::_oRetDt:detbol		:= {} // Detalhes

	//------------------
	//PREPARA AMBIENTE
	//------------------
	If FindFunction("WfPrepEnv")

		//WfPrepEnv("01","01") // alterar para compilar na integral
		WfPrepEnv("02","01")

	Else
		//PREPARE ENVIRONMENT EMPRESA "01" FILIAL "01"
		PREPARE ENVIRONMENT EMPRESA "02" FILIAL "01"

	EndIf

	_cTitCd := AllTrim(_cTitCd)

	_cAlias1 := GetNextAlias()

	_cQuery += CRLF +  " SELECT "
	_cQuery += CRLF +  " 	BA0.BA0_CGC CNPJ_CEDENTE, "
	_cQuery += CRLF +  " 	TRIM(SA6.A6_AGENCIA)||'-'||TRIM(SA6.A6_DVAGE)||'/'||TRIM(SA6.A6_NUMCON)||'-'||TRIM(SA6.A6_DVCTA) COD_CEDENTE, "
	_cQuery += CRLF +  " 	TRIM(BA0.BA0_NOMINT) NOME_CEDENTE, 	"
	_cQuery += CRLF +  " 	TRIM(BA0.BA0_END) END_CEDENTE, 		"
	_cQuery += CRLF +  " 	TRIM(BA0.BA0_BAIRRO)||','||TRIM(BA0.BA0_CIDADE)||','||BA0.BA0_EST||' - '||'CEP: '||SUBSTR(BA0.BA0_CEP,1,5)||' - '||SUBSTR(BA0.BA0_CEP,6,3) COMP_CEDENTE, "
	_cQuery += CRLF +  " 	BA1.BA1_CPFUSR CPF, "
	_cQuery += CRLF +  " 	SE1.E1_CODINT||SE1.E1_CODEMP||SE1.E1_MATRIC MAT_TIT, "
	_cQuery += CRLF +  " 	BA1.BA1_CODINT||BA1.BA1_CODEMP||BA1.BA1_MATRIC||BA1.BA1_TIPREG||BA1.BA1_DIGITO MAT_COMP, "
	_cQuery += CRLF +  " 	TRIM(BA1.BA1_NOMUSR) NOME, 	"
	_cQuery += CRLF +  " 	SEE.EE_CODCART CARTEIRA, 	"
	_cQuery += CRLF +  " 	SE1.E1_VENCREA, 			"
	_cQuery += CRLF +  " 	SE1.E1_VALOR VALOR_TIT, 	"
	_cQuery += CRLF +  " 	SE1.E1_MULTA MULTA, 		"
	_cQuery += CRLF +  " 	SE1.E1_JUROS JUROS, 		"
	_cQuery += CRLF +  " 	SE1.E1_FILIAL||SE1.E1_PREFIXO||SE1.E1_NUM||SE1.E1_PARCELA||SE1.E1_TIPO TITULO,  "
	_cQuery += CRLF +  " 	SE1.E1_PORTADO,	"
	_cQuery += CRLF +  " 	SE1.E1_AGEDEP,	"
	_cQuery += CRLF +  " 	SE1.E1_CONTA, 	"
	_cQuery += CRLF +  " 	SE1.E1_SALDO, 	"
	_cQuery += CRLF +  " 	SE1.E1_PREFIXO, "
	_cQuery += CRLF +  " 	SE1.E1_NUM, 	"
	_cQuery += CRLF +  " 	SE1.E1_TIPO, 	"
	_cQuery += CRLF +  " 	SE1.E1_IRRF, 	"
	_cQuery += CRLF +  " 	SE1.E1_CSLL, 	"
	_cQuery += CRLF +  " 	SE1.E1_COFINS, 	"
	_cQuery += CRLF +  " 	SE1.E1_PIS, 	"
	_cQuery += CRLF +  " 	SE1.E1_ISS, 	"
	_cQuery += CRLF +  " 	SE1.E1_PARCELA, "
	_cQuery += CRLF +  " 	SE1.E1_EMISSAO, "
	_cQuery += CRLF +  " 	SE1.E1_VENCTO, 	"
	_cQuery += CRLF +  " 	SA6.A6_AGENCIA, "
	_cQuery += CRLF +  " 	SA6.A6_DVAGE, 	"
	_cQuery += CRLF +  " 	SA6.A6_NUMCON, 	"
	_cQuery += CRLF +  " 	SA6.A6_DVCTA, 	"
	_cQuery += CRLF +  " 	SE1.E1_FORMREC 	"
	_cQuery += CRLF +  " FROM 				"
	_cQuery += CRLF +  " 	" + RetSqlName("SE1") + " SE1 "
	_cQuery += CRLF +  "    "
	_cQuery += CRLF +  "     INNER JOIN "
	_cQuery += CRLF +  "         " + RetSqlName("BA1") + " BA1 "
	_cQuery += CRLF +  "     ON  "
	_cQuery += CRLF +  "         BA1.BA1_FILIAL  = '" + xFilial("BA1") + "' "
	_cQuery += CRLF +  "         AND BA1.BA1_CODINT  = E1_CODINT "
	_cQuery += CRLF +  "         AND BA1.BA1_CODEMP  = E1_CODEMP "
	_cQuery += CRLF +  "         AND BA1.BA1_MATRIC  = E1_MATRIC "
	_cQuery += CRLF +  "         AND BA1.BA1_DATBLO  = ' ' "
	_cQuery += CRLF +  "         AND BA1.D_E_L_E_T_  = ' ' "
	_cQuery += CRLF +  "     "
	_cQuery += CRLF +  "     INNER JOIN    "
	_cQuery += CRLF +  "         " + RetSqlName("BA0") + " BA0 "
	_cQuery += CRLF +  "     ON "
	_cQuery += CRLF +  "         BA0.BA0_FILIAL  = BA1.BA1_FILIAL "
	_cQuery += CRLF +  "         AND TRIM(BA0.BA0_CODIDE)||TRIM(BA0.BA0_CODINT) = SE1.E1_CODINT  "
	_cQuery += CRLF +  "         AND BA0.D_E_L_E_T_  = ' ' "
	_cQuery += CRLF +  "     "
	_cQuery += CRLF +  "     INNER JOIN "
	_cQuery += CRLF +  "         " + RetSqlName("BA3") + " BA3 "
	_cQuery += CRLF +  "     ON  "
	_cQuery += CRLF +  "         BA3.BA3_FILIAL  	 = '" + xFilial("BA3") + "' "
	_cQuery += CRLF +  "         AND BA3.BA3_CODINT  = E1_CODINT "
	_cQuery += CRLF +  "         AND BA3.BA3_CODEMP  = E1_CODEMP "
	_cQuery += CRLF +  "         AND BA3.BA3_MATRIC  = E1_MATRIC "
	_cQuery += CRLF +  "         AND BA3.D_E_L_E_T_  = ' ' 	"
	_cQuery += CRLF +  "     "
	_cQuery += CRLF +  "     INNER JOIN "
	_cQuery += CRLF +  "         " + RetSqlName("SA6") + " SA6 "
	_cQuery += CRLF +  "     ON  "
	_cQuery += CRLF +  "         SA6.A6_FILIAL       = '" + xFilial("SA6") + "' "
	_cQuery += CRLF +  "         AND SA6.A6_COD      = SE1.E1_PORTADO 	"
	_cQuery += CRLF +  "         AND SA6.A6_AGENCIA  = SE1.E1_AGEDEP	"
	_cQuery += CRLF +  "         AND SA6.A6_NUMCON   = SE1.E1_CONTA 	"
	_cQuery += CRLF +  "         AND SA6.D_E_L_E_T_  = ' ' "
	_cQuery += CRLF +  "         "
	_cQuery += CRLF +  "     INNER JOIN "
	_cQuery += CRLF +  "         " + RetSqlName("SEA") + " SEA "
	_cQuery += CRLF +  "     ON  "
	_cQuery += CRLF +  "         SEA.EA_FILIAL       = SE1.E1_FILIAL "
	_cQuery += CRLF +  "         AND SEA.EA_NUMBOR   = SE1.E1_NUMBOR "
	_cQuery += CRLF +  "         AND SEA.EA_PREFIXO  = SE1.E1_PREFIXO"
	_cQuery += CRLF +  "         AND SEA.EA_NUM      = SE1.E1_NUM 	 "
	_cQuery += CRLF +  "         AND SEA.EA_PARCELA  = SE1.E1_PARCELA"
	_cQuery += CRLF +  "         AND SEA.EA_TIPO     = SE1.E1_TIPO   "
	_cQuery += CRLF +  "         AND SEA.D_E_L_E_T_  = ' ' 			 "
	_cQuery += CRLF +  "     "
	_cQuery += CRLF +  "     INNER JOIN "
	_cQuery += CRLF +  "         " + RetSqlName("SEE") + " SEE "
	_cQuery += CRLF +  "     ON  "
	_cQuery += CRLF +  "         SEE.EE_FILIAL       = SE1.E1_FILIAL "
	_cQuery += CRLF +  "         AND SEE.EE_CODIGO   = SA6.A6_COD 	 "
	_cQuery += CRLF +  "         AND SEE.EE_AGENCIA  = SA6.A6_AGENCIA"
	_cQuery += CRLF +  "         AND SEE.EE_CONTA    = SA6.A6_NUMCON "
	_cQuery += CRLF +  "         AND SEE.EE_DVCTA    = SA6.A6_DVCTA  "
	_cQuery += CRLF +  "         AND SEE.EE_SUBCTA   = DECODE(TRIM(SEA.EA_XSUBCON),NULL,'001',EA_XSUBCON)"
	_cQuery += CRLF +  "         AND SEE.D_E_L_E_T_  = ' ' 			 "
	_cQuery += CRLF +  "     	"
	_cQuery += CRLF +  " WHERE 	"
	_cQuery += CRLF +  " 	SE1.E1_FILIAL        = '" + SUBSTR(_cTitCd,1,2)  + "' 	"
	_cQuery += CRLF +  "    AND SE1.E1_PREFIXO   = '" + SUBSTR(_cTitCd,3,3)  + "' 	"
	_cQuery += CRLF +  "    AND SE1.E1_NUM       = '" + SUBSTR(_cTitCd,6,9)  + "' 	"
	_cQuery += CRLF +  "    AND SE1.E1_PARCELA   = '" + SUBSTR(_cTitCd,15,1) + "' 	"
	_cQuery += CRLF +  "    AND SE1.E1_TIPO      = '" + SUBSTR(_cTitCd,16,2) + "' 	"
	_cQuery += CRLF +  " 	AND SE1.E1_PORTADO   = '237'"
	_cQuery += CRLF +  " 	AND SE1.E1_SALDO     > 0 	"
	_cQuery += CRLF +  " 	AND SE1.E1_NUMBCO 	 <> ' ' "
	_cQuery += CRLF +  " 	AND SE1.D_E_L_E_T_   = ' '  "

	If Select(_cAlias1) > 0
		(_cAlias1)->(DbCloseArea())
	EndIf

	PLSQuery(_cQuery,_cAlias1)

	If !(_cAlias1)->(EOF())

		If (_cAlias1)->E1_FORMREC $ "01|08" //Consigna็ใo

			_cTipPag := "C"

		ElseIf (_cAlias1)->E1_FORMREC $ "04|05|09" //Boleto

			_cTipPag := "B"

		ElseIf (_cAlias1)->E1_FORMREC $ "06" //Debito

			_cTipPag := "D"

		EndIf

		//--------------------------------
		//Calculo linha digitแvel
		//--------------------------------
		_aLinDig := LinDig((_cAlias1)->E1_PREFIXO	,;
			(_cAlias1)->E1_NUM		,;
			(_cAlias1)->E1_PARCELA	,;
			(_cAlias1)->E1_TIPO		,;
			Subs((_cAlias1)->E1_PORTADO,1,3),;
			(_cAlias1)->A6_AGENCIA	,;
			(_cAlias1)->A6_NUMCON	,;
			(_cAlias1)->A6_DVCTA	,;
			Strzero(Val(Alltrim((_cAlias1)->E1_NUM)),6) + StrZERO(Val(Alltrim((_cAlias1)->E1_PARCELA)),2) ,;
			(_cAlias1)->E1_SALDO 	,;
			(_cAlias1)->CARTEIRA	,;
			"9"	)

		::_oRetDt:status	:= .T.

		oTemp := WsClassNew("detalhes")

		oTemp:_cCedCnpj	:= (_cAlias1)->(CNPJ_CEDENTE)
		oTemp:_cCedCodg	:= (_cAlias1)->(COD_CEDENTE)
		oTemp:_cCedNome	:= (_cAlias1)->(NOME_CEDENTE)
		OTemp:_cCedEnde	:= (_cAlias1)->(END_CEDENTE)
		oTemp:_cCedComp	:= (_cAlias1)->(COMP_CEDENTE)
		oTemp:_cTitCPF	:= (_cAlias1)->(CPF)
		oTemp:_cTitCod	:= (_cAlias1)->(MAT_COMP)
		oTemp:_cTitNome	:= (_cAlias1)->(NOME)
		oTemp:_cCodCart	:= (_cAlias1)->(CARTEIRA)
		oTemp:_cLinDigi	:= AllTrim(_aLinDig[2])
		oTemp:_cDtVenci	:= (_cAlias1)->(E1_VENCREA)
		oTemp:_nvalor	:= (_cAlias1)->(VALOR_TIT)
		oTemp:_nMulta	:= (_cAlias1)->(MULTA)
		oTemp:_nJuroDia	:= (_cAlias1)->(JUROS)
		oTemp:_cImpBol	:= "S"
		oTemp:_cSituac	:= IIF((_cAlias1)->(E1_VENCREA) >= dDatabase,"P","A") //P = A Vencer (em aberto por้m ainda nใo estแ vencido) || A = Atrasado (em aberto, por้m jแ vencido)
		oTemp:_cTipCob	:= _cTipPag

		//-----------------------------------------------------------------------------
		// Inicio - Atualizando o array de instru็๕es dentro do array de retorno
		//-----------------------------------------------------------------------------
		oTemp1 := WsClassNew("instrucao")

		_cMsg := " *** VALORES EXPRESSOS EM REAIS *** " + cEnt
		_cMsg += "SR. CAIXA NรO COBRAR JUROS. APำS VENCIMENTO O MESMO SERม COBRADO NO" + cEnt
		_cMsg += "PRำXIMO BOLETO, MULTA DE 2% E JUROS DE 1% AO MสS." + cEnt
		_cMsg += "APำS VENCIMENTO, PAGมVEL SOMENTE NO BANCO BRADESCO." + cEnt
		_cMsg += "SR. CAIXA ATENวรO: DESCONTO SOMENTE QUANDO LANวADO NO DOCUMENTO." + cEnt + cEnt
		_cMsg += "NรO RECEBER APำS 30 DIAS DO VENCIMENTO."

		oTemp1:_cInst 	:= _cMsg

		aAdd( _aTemp , oTemp1)

		//-----------------------------------------------------------------------------
		// Fim - Atualizando o array de instru็๕es dentro do array de retorno
		//-----------------------------------------------------------------------------

		oTemp:_aInst	:= _aTemp

		aAdd( ::_oRetDt:detbol , oTemp)

	Else

		//SetSoapFault( ProcName() , "Nใo foi possivel encontrar os detalhes do boleto selecionado." )
		//lRet := .F.

		//---------------------------------------------------------
		//Conforme informado pelos analistas da RR - Mobile
		//Deve-se smepre encaminhar a mesma estrutura
		//sem preenchimento
		//---------------------------------------------------------

		//::_oRetDt:status	:= .F.
		//::_oRetDt:cCrit		:= "Nใo foi possivel encontrar os detalhes do boleto selecionado"

		//---------------------------------------------------------
		//Conforme informado pelos analistas da RR - Mobile
		//Deve-se retornar o status como True, pois a critica de
		//matricula invalida ้ tratada no login do beneficiario
		//no App.
		//---------------------------------------------------------

		::_oRetDt:status	:= .T.

		oTemp := WsClassNew("detalhes")

		oTemp:_cCedCnpj	:= ""
		oTemp:_cCedCodg	:= ""
		oTemp:_cCedNome	:= ""
		OTemp:_cCedEnde	:= ""
		oTemp:_cCedComp	:= ""
		oTemp:_cTitCPF	:= ""
		oTemp:_cTitCod	:= ""
		oTemp:_cTitNome	:= ""
		oTemp:_cCodCart	:= ""
		oTemp:_cLinDigi	:= ""
		oTemp:_cDtVenci	:= CTOD(" / / ")
		oTemp:_nvalor	:= 0
		oTemp:_nMulta	:= 0
		oTemp:_nJuroDia	:= 0
		oTemp:_cImpBol	:= "N"
		oTemp:_cSituac	:= ""
		oTemp:_cTipCob	:= ""

		//-----------------------------------------------------------------------------
		// Inicio - Atualizando o array de instru็๕es dentro do array de retorno
		//-----------------------------------------------------------------------------
		oTemp1 := WsClassNew("instrucao")

		_cMsg := " "

		oTemp1:_cInst 	:= _cMsg

		aAdd( _aTemp , oTemp1)

		//-----------------------------------------------------------------------------
		// Fim - Atualizando o array de instru็๕es dentro do array de retorno
		//-----------------------------------------------------------------------------

		oTemp:_aInst	:= _aTemp

		aAdd( ::_oRetDt:detbol , oTemp)

	EndIf

	If Select(_cAlias1) > 0
		(_cAlias1)->(DbCloseArea())
	EndIf

Return lRet


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFuncao    ณLinDig    บAutor  ณAngelo Henrique     บ Data ณ  13/01/2017 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRotina responsแvel pela gera็ใo da linha digitแvel, fonte   บฑฑ
ฑฑบ          ณretirado da gera็ใo de boleto fonte:BOL_BRADES              บฑฑ
ฑฑบ          ณRotina modificada, a rotina original ้ a RET_DADOS que esta บฑฑ
ฑฑบ          ณsendo chamada pela rotina Ret_cBarra, que esta no BOL_BRADESบฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ BOLETOS                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
ฑฑบ Atualiz  ณ 22/10/13 - Vitor Sbano        					          บฑฑ
ฑฑบ          ณ - retirada da Variavel cDigito para Bradesco (237)         บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
*/

Static Function LinDig(cPrefixo, cNumero, cParcela, cTipo, cBanco, cAgencia, cConta, cDacCC, cNroDoc, nValor, cCart, cMoeda)

	Local cNosso		:= ""
	Local cDigNosso		:= ""
	Local cBarra		:= ""
	Local cParte1		:= ""
	Local cDig1			:= ""
	Local cParte2		:= ""
	Local cDig2			:= ""
	Local cParte3		:= ""
	Local cDig3			:= ""
	Local cParte4		:= ""
	Local cParte5		:= ""
	Local cDigital		:= ""
	Local aRet			:= {}

	DEFAULT nValor 		:= 0

	// Banco Bradesco
	If cBanco $ '237'

		DbSelectArea("SE1")
		DbSetOrder(1) //E1_FILIAL+E1_PREFIXO+E1_NUM+E1_PARCELA+E1_TIPO
		If DbSeek(xFilial("SE1") + cPrefixo + cNumero + cParcela + cTipo)

			cAgencia:=Transform(Val(cAgencia),"9999")

			cNosso := Alltrim(SE1->E1_NUMBCO)
			cDigNosso  := u_fDigNosNum(cNosso)

			// 01 a 03
			cBarra :=  cBanco
			// 04 a 04
			cBarra +=  cMoeda
			// 06 a 09
			cBarra +=  u_FatorDat()

			cValor  := strzero(nValor*100,10)
			// 10 a 19
			cBarra +=  cValor
			/*------------------------------------------------------*
			* Campo Livre do codigo de barra do banco do Bradesco
			*-------------------------------------------------------*/
			// --------------------------------------------- TAMANHO   INICO  	FIM
			cBarra +=   cAgencia				       		// 4       // 20    //23
			cBarra +=   RIGHT(alltrim(cCart),2)            	// 2       // 24    //25
			cBarra +=   PADL(Alltrim(cNosso),11,"0")  		// 11      // 26    //36

			if len(alltrim(cConta)) > 7

				cBarra +=   Substr(Alltrim(cConta),1,7)    	// 7       // 37    //43

			Else

				cBarra +=   PADL(Alltrim(cConta),7,"0")   	// 7       // 37    //43

			EndIf

			cBarra +=   "0"                        			// 1       // 44    //44

			/*---------------------------------------------------------------------------------*
			* Configura a agencia, a conta e o Nosso numero de  acordo c/ os padroes do banco
			*---------------------------------------------------------------------------------*/
			cAgencia:= AllTrim(cAgencia)

			cConta := Alltrim(cConta) 		&&	+ "-" + cDigito

			cDVNosso := cDigNosso

			c_dig  := U_CALC_5p(cBarra)

			//Incrementa o DAC na quinta posicao do codigo ded barra
			cBarra  := substr(cBarra , 1 , 4) +c_dig  + substr(cBarra , 5 ,43 )

			/*---------------------------------------------------------------------------------*
			* Calculo da linha digitavel
			*---------------------------------------------------------------------------------*/

			/*-------------------------------------------------------*
			* Parte 1   BBBMN.NNNNN
			*-------------------------------------------------------*/
			cParte1   := substr(cBarra , 1 , 4 ) + substr ( cBarra  , 20 , 5 )
			cDig1    := U_DIGIT001( cParte1 )

			/*-------------------------------------------------------*
			* Parte 2   NNNNN.NDNNNN
			*-------------------------------------------------------*/
			cParte2   := substr(cBarra , 25 , 6 ) + substr ( cBarra  , 31 , 1 ) + substr ( cBarra  , 32 , 3 )
			cDig2    := U_DIGIT001( cParte2 )


			/*-------------------------------------------------------*
			* Parte 3  NNNNN.NNNNNN
			*-------------------------------------------------------*/
			cParte3   :=  substr(cBarra , 35 , 1 ) + substr ( cBarra  , 36 , 6 ) + substr ( cBarra  , 42 , 3 )
			cDig3    := U_DIGIT001( cParte3 )

			/*-------------------------------------------------------*
			* Parte 4  X
			*-------------------------------------------------------*/
			cParte4    := Transform(c_dig, "@E 9")

			/*-------------------------------------------------------*
			* Parte 5   DDDDVVVVVVVVVV
			*-------------------------------------------------------*/
			cParte5    := substr(cBarra , 6 , 4 )      + substr(cBarra , 10 , 10 )

			cDigital := substr(cParte1,1,5)+"."+substr(cparte1,6,4)+Transform(cDig1," @E 9")+"  "+;
			substr(cParte2,1,5)+"."+substr(cparte2,6,5)+Transform(cDig2," @E 9")+"  "+;
			substr(cParte3,1,5)+"."+substr(cparte3,6,5)+Transform(cDig3," @E 9")+"  "+;
			cParte4+" "+cParte5

			Aadd(aRet,cBarra)
			Aadd(aRet,cDigital)
			Aadd(aRet,cNosso)
			Aadd(aRet,cDVNosso)

		EndIf

	Else

		Aadd(aRet,"")
		Aadd(aRet,"")
		Aadd(aRet,"")

	EndIf

Return aRet



/*
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Metodo para detalhar o boleto selecionado pelo beneficiarioบฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CABERJ - WebService                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

WSMETHOD extrato_fatura WSRECEIVE _cTitEt WSSEND _oRetEt WSSERVICE WS002

	Local lRet          := .T.
	Local _cQuery		:= ""
	Local _cAlias1		:= ""
	Local oTemp			:= Nil
	Local _aTemp		:= {}

	// objeto que serแ utilizado como retorno deste m้todo.
	::_oRetEt:extbol		:= {} // Detalhes

	//------------------
	//PREPARA AMBIENTE
	//------------------
	If FindFunction("WfPrepEnv")

		//WfPrepEnv("01","01") // alterar para compilar na integral
		WfPrepEnv("02","01")
	Else

		//PREPARE ENVIRONMENT EMPRESA "01" FILIAL "01"
		PREPARE ENVIRONMENT EMPRESA "02" FILIAL "01"
	EndIf

	_cAlias1 := GetNextAlias()

	//colocar aqui a query

	_cQuery := " SELECT " + cEnt
	_cQuery += " 	BA1.BA1_CODINT||BA1.BA1_CODEMP||BA1.BA1_MATRIC||BA1.BA1_TIPREG||BA1.BA1_DIGITO MATRICULA,  " + cEnt
	_cQuery += " 	TRIM(BA1.BA1_NOMUSR) NOME,  " + cEnt
	_cQuery += " 	TRIM(DECODE(BA1.BA1_TIPUSU,'T','TITULAR','D','DEPENDENTE')) GRAU,  " + cEnt
	_cQuery += " 	SE1.E1_FILIAL||SE1.E1_PREFIXO||SE1.E1_NUM||SE1.E1_PARCELA||SE1.E1_TIPO TITULO, " + cEnt
	_cQuery += " 	BM1.BM1_CODTIP, " + cEnt
	_cQuery += " 	BM1.BM1_DESTIP, " + cEnt
	_cQuery += " 	BM1.BM1_VALOR " + cEnt
	_cQuery += " FROM  " + cEnt
	_cQuery += " 	" + RetSqlName("SE1") + " SE1 ,  " + cEnt
	_cQuery += " 	" + RetSqlName("BA1") + " BA1 , " + cEnt
	_cQuery += " 	" + RetSqlName("BM1") + " BM1 " + cEnt
	_cQuery += " WHERE  " + cEnt
	_cQuery += " 	SE1.E1_FILIAL||SE1.E1_PREFIXO||SE1.E1_NUM||SE1.E1_PARCELA||SE1.E1_TIPO = '" + _cTitEt + "'  " + cEnt
	_cQuery += " 	AND SE1.E1_PORTADO = '237'  " + cEnt
	_cQuery += " 	AND SE1.E1_SALDO > 0  " + cEnt
	_cQuery += " 	AND SE1.E1_NUMBCO <> ' '  " + cEnt
	_cQuery += " 	AND BA1.BA1_FILIAL = '" + xFilial("BA1") + "'  " + cEnt
	_cQuery += " 	AND BA1.BA1_CODINT = SE1.E1_CODINT  " + cEnt
	_cQuery += " 	AND BA1.BA1_CODEMP = SE1.E1_CODEMP  " + cEnt
	_cQuery += " 	AND BA1.BA1_MATRIC = SE1.E1_MATRIC  " + cEnt
	_cQuery += " 	AND BA1.BA1_DATBLO = ' '  " + cEnt
	_cQuery += " 	AND BM1.BM1_FILIAL = '" + xFilial("BM1") + "' " + cEnt
	_cQuery += " 	AND BM1.BM1_PLNUCO = SE1.E1_PLNUCOB " + cEnt
	_cQuery += " 	AND BM1.BM1_PREFIX = SE1.E1_PREFIXO " + cEnt
	_cQuery += " 	AND BM1.BM1_NUMTIT = SE1.E1_NUM  " + cEnt
	_cQuery += " 	AND BM1.BM1_PARCEL = SE1.E1_PARCELA " + cEnt
	_cQuery += " 	AND BM1.BM1_TIPTIT = SE1.E1_TIPO  " + cEnt
	_cQuery += " 	AND SE1.D_E_L_E_T_ = ' '  " + cEnt
	_cQuery += " 	AND BA1.D_E_L_E_T_ = ' ' " + cEnt
	_cQuery += " 	AND BM1.D_E_L_E_T_ = ' ' " + cEnt

	If Select(_cAlias1) > 0
		(_cAlias1)->(DbCloseArea())
	EndIf

	PLSQuery(_cQuery,_cAlias1)

	If !(_cAlias1)->(EOF())

		::_oRetEt:status	:= .T.

		oTemp := WsClassNew("extrato")

		oTemp:_cMatBen	:= (_cAlias1)->(MATRICULA)
		oTemp:_cNomBen	:= (_cAlias1)->(NOME)

		While !(_cAlias1)->(EOF())

			//-----------------------------------------------------------------------------
			// Inicio - Atualizando o array de composi็ใo dentro do array de retorno
			//-----------------------------------------------------------------------------
			oTemp1 := WsClassNew("composicao")

			oTemp1:_cServCd 	:= (_cAlias1)->(BM1_CODTIP)
			oTemp1:_cSrvDsc 	:= (_cAlias1)->(BM1_DESTIP)
			oTemp1:_nVlr 		:= (_cAlias1)->(BM1_VALOR)

			aAdd( _aTemp , oTemp1)

			//-----------------------------------------------------------------------------
			// Fim - Atualizando o array de instru็๕es dentro do array de retorno
			//-----------------------------------------------------------------------------

			oTemp:_aComp := _aTemp

			(_cAlias1)->(DbSkip())

		EndDo

		aAdd( ::_oRetEt:extbol , oTemp)

	Else

		//---------------------------------------------------------
		//Conforme informado pelos analistas da RR - Mobile
		//Deve-se smepre encaminhar a mesma estrutura
		//sem preenchimento
		//---------------------------------------------------------

		//::_oRetEt:status  	:= .F.
		//::_oRetEt:cCrit		:= "Nใo foi possivel encontrar o extrato do boleto selecionado."

		//---------------------------------------------------------
		//Conforme informado pelos analistas da RR - Mobile
		//Deve-se retornar o status como True, pois a critica de
		//matricula invalida ้ tratada no login do beneficiario
		//no App.
		//---------------------------------------------------------

		::_oRetEt:status	:= .T.

		oTemp := WsClassNew("extrato")

		oTemp:_cMatBen	:= (_cAlias1)->(MATRICULA)
		oTemp:_cNomBen	:= (_cAlias1)->(NOME)

		//-----------------------------------------------------------------------------
		// Inicio - Atualizando o array de composi็ใo dentro do array de retorno
		//-----------------------------------------------------------------------------
		oTemp1 := WsClassNew("composicao")

		oTemp1:_cServCd 	:= ""
		oTemp1:_cSrvDsc 	:= ""
		oTemp1:_nVlr 		:= 0

		aAdd( _aTemp , oTemp1)

		//-----------------------------------------------------------------------------
		// Fim - Atualizando o array de instru็๕es dentro do array de retorno
		//-----------------------------------------------------------------------------

		oTemp:_aComp := _aTemp


		aAdd( ::_oRetEt:extbol , oTemp)

	EndIf

	If Select(_cAlias1) > 0
		(_cAlias1)->(DbCloseArea())
	EndIf

Return lRet
