#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'PARMTYPE.CH'
#INCLUDE "APWEBSRV.CH"
#INCLUDE "TBICONN.CH"

#DEFINE cEnt Chr(13)+Chr(10)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ WS006    บAutor  ณAngelo Henrique     บ Data ณ  16/06/2017 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณWebService criado para a integra็ใo MOBILE.                 บฑฑ
ฑฑบ          ณIntegra็ใo Protheus x Mobile - Extrato de utiliza็ใo e      บฑฑ
ฑฑบ          ณcoparticipa็ใo                                              บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบM้todos.  ณextrato_reembolso: Retorna lista com todos os reembolsos.   บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณCABERJ                                                      บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

user function WS006()

return


//---------------------------------------------------------------------------------------------------------------
// Inicio - Estruturas utilizadas no m้todo extrato_utilizacao
// Para ser encaminhada no retorno
//---------------------------------------------------------------------------------------------------------------
	WSSTRUCT ExtrUt

		WSDATA _cCdProc	AS STRING 						//codigo_procedimento
		WSDATA _cDsProc	AS STRING 						//descri_procedimento
		WSDATA _dDtAten	AS DATE 						//data_atendimento
		WSDATA _cCdPres	AS STRING 						//codigo_prestador
		WSDATA _cNmPres	AS STRING 						//nome_prestador
		WSDATA _cCPFPre	AS STRING 						//cpf_cnpj_prestador
		WSDATA _cCdTpSv	AS STRING 						//codigo_tipo_servico
		WSDATA _cDcTpSv	AS STRING 						//descri_tipo_servico
		WSDATA _nQuanti	AS FLOAT 						//quantidade
		WSDATA _nVlServ	AS FLOAT 			OPTIONAL 	//valor_servico
		WSDATA _nVlCopa	AS FLOAT 			OPTIONAL 	//valor_coparticipacao

	ENDWSSTRUCT

	WSSTRUCT BenfUt

		WSDATA _cNome	AS STRING 						//nome
		WSDATA _cMatric	AS STRING 						//matricula
		WSDATA _nVlTtCp	AS FLOAT 			OPTIONAL 	//valor_total_copart
		WSDATA _nVlTtUt	AS FLOAT 						//valor_total_utiliz
		WSDATA _aExtrat	AS ARRAY  OF ExtrUt				//extrato

	ENDWSSTRUCT

	WSSTRUCT FamiUt

		WSDATA _cNmTitu	AS STRING 						//nome_titular
		WSDATA _cMatTit	AS STRING 						//matricula_titular
		WSDATA _cBenefi	AS ARRAY OF BenfUt 				//benefciiarios

	ENDWSSTRUCT

	WSSTRUCT EmprUt

		WSDATA _cNome	AS STRING 						//nome
		WSDATA _cCNPJ	AS STRING 						//cnpj
		WSDATA _cContra	AS STRING 						//contrato
		WSDATA _cEstipu	AS STRING 						//estipulante

	ENDWSSTRUCT

	WSSTRUCT oRetUtil

		WSDATA _cStatus AS BOOLEAN 						//status
		WSDATA _cCritic AS STRING  			OPTIONAL 	//motivo_critica
		WSDATA _aEmpres AS ARRAY Of EmprUt	OPTIONAL 	//empresa (Array)
		WSDATA _aFamili AS ARRAY OF FamiUt 				//familias (Array)

	ENDWSSTRUCT

//---------------------------------------------------------------------------------------------------------------
// Fim - Estruturas utilizadas no m้todo extrato_utilizacao
//---------------------------------------------------------------------------------------------------------------



	WSSERVICE WS006 DESCRIPTION "Integra็ใo Protheus x Mobile - <b>Extrato de Utiliza็ใo</b>" NAMESPACE "WS006"

		//-----------------------------------------------------
		// Inicio - Variaveis do m้todo extrato_utilizacao
		//-----------------------------------------------------

		WSDATA _cChvBenf 	AS STRING  	OPTIONAL	//Matricula do Beneficiแrio
		WSDATA _cChvEmpr	AS STRING 	OPTIONAL 	//Data Inicial do extrato de reembolso
		WSDATA _cAno 		AS STRING 				//Data Final do extrato de reembolso
		WSDATA _cMes 		AS STRING 				//Data Final do extrato de reembolso
		WSDATA _oRetUt 		AS oRetUtil				//Retorno do Webservice

		//-----------------------------------------------------
		// Fim - Variaveis do m้todo extrato_utilizacao
		//-----------------------------------------------------

		WSMETHOD extrato_utilizacao  	DESCRIPTION "Metodo para listar os eventos realizados pelo beneficiแrio."

	ENDWSSERVICE


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

WSMETHOD extrato_utilizacao WSRECEIVE _cChvBenf, _cChvEmpr, _cAno, _cMes  WSSEND _oRetUt WSSERVICE WS006

	Local lRet          := .T.
	Local _cQuery		:= ""
	Local _cAlias1		:= ""
	Local _cAlias2		:= ""
	Local _cAlias3		:= ""
	Local _cAlias4		:= ""
	Local oTemp1		:= Nil //Estrutura Empresa
	Local oTemp2		:= Nil //Estrutura Familia
	Local oTemp3		:= Nil //Estrutura Beneficiarios (Dentro da estrutura Familia)
	Local oTemp4		:= Nil //Estrutura Extrato (Dentro da estrutura beneficiarios)
	Local _aTemp3		:= {}
	Local _aTemp4		:= {}

	// objetos que serใo utilizados como retorno deste m้todo.
	::_oRetUt:_aEmpres		:= {} // Empresa
	::_oRetUt:_aFamili		:= {} // Familia
	

	//------------------
	//PREPARA AMBIENTE
	//------------------
	If FindFunction("WfPrepEnv")

		//WfPrepEnv("01","01")  //caberj
		WfPrepEnv("02","01")  //integral

	Else

		//PREPARE ENVIRONMENT EMPRESA "01" FILIAL "01"
		PREPARE ENVIRONMENT EMPRESA "02" FILIAL "01"   // integral

	EndIf

	If !(Empty(_cAno)) .And. !(Empty(_cMes))


		If Len(_cChvBenf) < 15

			_cChvBenf := u_WSXFUNC("WSMATCPF(_cChvBenf)")

		EndIf

		//--------------------------------------------------------------------------------
		// INICIO - Montando Informa็๕es da Empresa, caso ela nใo venha vazia
		//--------------------------------------------------------------------------------
		If !(Empty(_cChvEmpr))

			_cAlias1 := GetNextAlias()

			_cQuery := " SELECT															" + cEnt
			_cQuery += " 	BQC.BQC_NREDUZ NM_EMP,										" + cEnt
			_cQuery += " 	BQC.BQC_CNPJ CNPJ_EMP,										" + cEnt
			_cQuery += " 	BQC.BQC_NUMCON CONTRATO    									" + cEnt
			_cQuery += " FROM															" + cEnt
			_cQuery += "	 " + RetSqlName("BQC") + " BQC								" + cEnt
			_cQuery += "	 INNER JOIN													" + cEnt
			_cQuery += "	 " + RetSqlName("BA1") + " BA1								" + cEnt
			_cQuery += "	 ON															" + cEnt
			_cQuery += "	 BA1.D_E_L_E_T_ = ' '										" + cEnt
			_cQuery += "	 AND BA1.BA1_CODINT = BQC.BQC_CODINT						" + cEnt
			_cQuery += "	 AND BA1.BA1_CODEMP = BQC.BQC_CODEMP						" + cEnt
			_cQuery += "	 AND BA1.BA1_CONEMP = BQC.BQC_NUMCON						" + cEnt
			_cQuery += "	 AND BA1.BA1_SUBCON = BQC.BQC_SUBCON						" + cEnt
			_cQuery += "	 AND BA1.BA1_CODINT = SUBSTR('" + _cChvBenf + "',1,4 )		" + cEnt
			_cQuery += "	 AND BA1.BA1_CODEMP = SUBSTR('" + _cChvBenf + "',5,4 )		" + cEnt
			_cQuery += "	 AND BA1.BA1_MATRIC = SUBSTR('" + _cChvBenf + "',9,6 )		" + cEnt
			_cQuery += "	 AND BA1.BA1_TIPREG = SUBSTR('" + _cChvBenf + "',15,2)		" + cEnt
			_cQuery += "	 AND BA1.BA1_DIGITO = SUBSTR('" + _cChvBenf + "',17,1)		" + cEnt
			_cQuery += " WHERE															" + cEnt
			_cQuery += " 	BQC.D_E_L_E_T_ = ' '										" + cEnt
			_cQuery += " 	AND BQC.BQC_CODINT||BQC.BQC_CODEMP = '" + _cChvEmpr + "'	" + cEnt
			_cQuery += " 	AND BQC.BQC_DATBLO = ' '									" + cEnt

			If Select(_cAlias1) > 0
				(_cAlias1)->(DbCloseArea())
			EndIf

			PLSQuery(_cQuery,_cAlias1)

			If (_cAlias1)->(EOF())

				//---------------------------------------------------------
				//Conforme informado pelos analistas da RR - Mobile
				//Deve-se retornar o status como True, pois a critica de
				//matricula invalida ้ tratada no login do beneficiario
				//no App.
				//---------------------------------------------------------

				::_oRetUt:_cStatus	:= .T.

				oTemp1 := WsClassNew("EmprUt")

				oTemp1:_cNome 	:= ""
				oTemp1:_cCNPJ	:= ""
				oTemp1:_cContra	:= ""
				oTemp1:_cEstipu	:= ""

				aAdd( ::_oRetUt:_aEmpres , oTemp1)

				oTemp2 := WsClassNew("FamiUt")

				oTemp2:_cNmTitu	:= 	""	//nome_titular
				oTemp2:_cMatTit	:= 	""	//matricula_titular

				oTemp3 := WsClassNew("BenfUt")

				oTemp3:_cNome	:= ""	//nome
				oTemp3:_cMatric	:= ""	//matricula
				oTemp3:_nVlTtCp	:= 0	//valor_total_copart
				oTemp3:_nVlTtUt	:= 0	//valor_total_utiliz

				oTemp4 := WsClassNew("ExtrUt")

				oTemp4:_cCdProc	:= "" 				//codigo_procedimento
				oTemp4:_cDsProc	:= "" 				//descri_procedimento
				oTemp4:_dDtAten	:= CTOD(" / / ") 	//data_atendimento
				oTemp4:_cCdPres	:= "" 				//codigo_prestador
				oTemp4:_cNmPres	:= "" 				//nome_prestador
				oTemp4:_cCPFPre	:= "" 				//cpf_cnpj_prestador
				oTemp4:_cCdTpSv	:= "" 				//codigo_tipo_servico
				oTemp4:_cDcTpSv	:= "" 				//descri_tipo_servico
				oTemp4:_nQuanti	:= 0 				//quantidade
				oTemp4:_nVlServ	:= 0 				//valor_servico
				oTemp4:_nVlCopa	:= 0 				//valor_coparticipacao

				aAdd( _aTemp4 , oTemp4)

				If Len(_aTemp4) > 0

					oTemp3:_aExtrat	:= _aTemp4

				EndIf

				aAdd( _aTemp3 , oTemp3)

				If Len(_aTemp3) > 0

					oTemp2:_cBenefi	:= _aTemp3

				EndIf

				aAdd( ::_oRetUt:_aFamili , oTemp2)

			EndIf

			If !(_cAlias1)->(EOF())

				oTemp1 := WsClassNew("EmprUt")

				oTemp1:_cNome 	:= (_cAlias1)->(NM_EMP	)	//nome
				oTemp1:_cCNPJ	:= (_cAlias1)->(CNPJ_EMP)	//cnpj
				oTemp1:_cContra	:= (_cAlias1)->(CONTRATO)	//contrato
				oTemp1:_cEstipu	:= (_cAlias1)->(NM_EMP	)	//estipulante

				aAdd( ::_oRetUt:_aEmpres , oTemp1)

			EndIf

			If Select(_cAlias1) > 0
				(_cAlias1)->(DbCloseArea())
			EndIf

		EndIf
		//--------------------------------------------------------------------------------
		// FIM - Montando Informa็๕es da Empresa, caso ela nใo venha vazia
		//--------------------------------------------------------------------------------

		//--------------------------------------------------------------------------------
		// INICIO - Montando Informa็๕es da familia, caso ela nใo venha vazia
		//--------------------------------------------------------------------------------
		If !(Empty(_cChvBenf))

			::_oRetUt:_cStatus	:= .T.

			_cAlias2 := GetNextAlias()

			//--------------------------------------------------------------------------------
			//-- Defini็ใo da estrutura da familia
			//--------------------------------------------------------------------------------
			_cQuery := " SELECT 																					" + cEnt
			_cQuery += " 	BA1.BA1_NOMUSR NM_TIT, 																	" + cEnt
			_cQuery += " 	BA1.BA1_CODINT||BA1.BA1_CODEMP||BA1.BA1_MATRIC||BA1.BA1_TIPREG||BA1.BA1_DIGITO MAT_TIT, " + cEnt
			_cQuery += " 	BA1.BA1_CODINT ,																		" + cEnt
			_cQuery += "	BA1.BA1_CODEMP ,																		" + cEnt
			_cQuery += " 	BA1.BA1_MATRIC ,																		" + cEnt
			_cQuery += " 	BA1.BA1_TIPREG ,																		" + cEnt
			_cQuery += " 	BA1.BA1_DIGITO 																			" + cEnt
			_cQuery += " FROM 																						" + cEnt
			_cQuery += "	 " + RetSqlName("BA1") + " BA1 															" + cEnt
			_cQuery += " WHERE 																						" + cEnt
			_cQuery += " 	BA1.D_E_L_E_T_	= ' '																	" + cEnt
			_cQuery += " 	AND BA1.BA1_FILIAL	= '" + xFilial("BA1") + " '											" + cEnt
			_cQuery += "	AND BA1.BA1_CODINT = SUBSTR('" + _cChvBenf + "',1,4 )									" + cEnt
			_cQuery += "	AND BA1.BA1_CODEMP = SUBSTR('" + _cChvBenf + "',5,4 )									" + cEnt
			_cQuery += "	AND BA1.BA1_MATRIC = SUBSTR('" + _cChvBenf + "',9,6 )									" + cEnt
			_cQuery += "	AND BA1.BA1_TIPREG = SUBSTR('" + _cChvBenf + "',15,2)									" + cEnt
			_cQuery += "	AND BA1.BA1_DIGITO = SUBSTR('" + _cChvBenf + "',17,1)									" + cEnt

			//QOut(_cQuery)

			If Select(_cAlias2) > 0
				(_cAlias2)->(DbCloseArea())
			EndIf

			PLSQuery(_cQuery,_cAlias2)

			If (_cAlias2)->(EOF())

				//---------------------------------------------------------
				//Conforme informado pelos analistas da RR - Mobile
				//Deve-se retornar o status como True, pois a critica de
				//matricula invalida ้ tratada no login do beneficiario
				//no App.
				//---------------------------------------------------------

				::_oRetUt:_cStatus	:= .T.

				oTemp1 := WsClassNew("EmprUt")

				oTemp1:_cNome 	:= ""
				oTemp1:_cCNPJ	:= ""
				oTemp1:_cContra	:= ""
				oTemp1:_cEstipu	:= ""

				aAdd( ::_oRetUt:_aEmpres , oTemp1)

				oTemp2 := WsClassNew("FamiUt")

				oTemp2:_cNmTitu	:= 	""	//nome_titular
				oTemp2:_cMatTit	:= 	""	//matricula_titular

				oTemp3 := WsClassNew("BenfUt")

				oTemp3:_cNome	:= ""	//nome
				oTemp3:_cMatric	:= ""	//matricula
				oTemp3:_nVlTtCp	:= 0	//valor_total_copart
				oTemp3:_nVlTtUt	:= 0	//valor_total_utiliz

				oTemp4 := WsClassNew("ExtrUt")

				oTemp4:_cCdProc	:= "" 				//codigo_procedimento
				oTemp4:_cDsProc	:= "" 				//descri_procedimento
				oTemp4:_dDtAten	:= CTOD(" / / ") 	//data_atendimento
				oTemp4:_cCdPres	:= "" 				//codigo_prestador
				oTemp4:_cNmPres	:= "" 				//nome_prestador
				oTemp4:_cCPFPre	:= "" 				//cpf_cnpj_prestador
				oTemp4:_cCdTpSv	:= "" 				//codigo_tipo_servico
				oTemp4:_cDcTpSv	:= "" 				//descri_tipo_servico
				oTemp4:_nQuanti	:= 0 				//quantidade
				oTemp4:_nVlServ	:= 0 				//valor_servico
				oTemp4:_nVlCopa	:= 0 				//valor_coparticipacao

				aAdd( _aTemp4 , oTemp4)

				If Len(_aTemp4) > 0

					oTemp3:_aExtrat	:= _aTemp4

				EndIf

				aAdd( _aTemp3 , oTemp3)

				If Len(_aTemp3) > 0

					oTemp2:_cBenefi	:= _aTemp3

				EndIf

				aAdd( ::_oRetUt:_aFamili , oTemp2)

			Else

				oTemp2 := WsClassNew("FamiUt")

				oTemp2:_cNmTitu	:= 	(_cAlias2)->(NM_TIT)//nome_titular
				oTemp2:_cMatTit	:= 	(_cAlias2)->(MAT_TIT)//matricula_titular

				//--------------------------------------------------------------------------------
				//-- Defini็ใo da estrutura beneficแrio
				//--------------------------------------------------------------------------------

				_cAlias3 := GetNextAlias()


				_cQuery := " SELECT 																															" + cEnt
				_cQuery += " 	NVL(TRIM(BD6.BD6_NOMUSR),BA1T.BA1_NOMUSR) NM_BENF ,																				" + cEnt
				_cQuery += " 	BD6.BD6_OPEUSR||BD6.BD6_CODEMP||BD6.BD6_MATRIC||BD6.BD6_TIPREG||BD6.BD6_DIGITO MAT_BENF,										" + cEnt
				_cQuery += " 	SUM(BD6.BD6_VLRBPF) VLTOTUT,																									" + cEnt
				_cQuery += " 	SUM(BD6.BD6_VLRTPF) VLTOTCOP																									" + cEnt
				_cQuery += " FROM 																																" + cEnt
				_cQuery += "	 " + RetSqlName("BD6") + " BD6 ,																								" + cEnt
				_cQuery += "	 " + RetSqlName("BA1") + " BA1T, 																								" + cEnt
				_cQuery += "	 " + RetSqlName("SE1") + " SE1T, 																								" + cEnt
				_cQuery += "	 " + RetSqlName("BAU") + " BAU																									" + cEnt
				_cQuery += " WHERE 																																" + cEnt
				_cQuery += " 	BA1T.BA1_FILIAL 	= '" + xFilial("BA1") + "'																					" + cEnt
				_cQuery += " 	AND BD6.BD6_FILIAL 	= '" + xFilial("BD6") + "'																					" + cEnt
				_cQuery += " 	AND BAU.BAU_FILIAL 	= '" + xFilial("BAU") + "'																					" + cEnt
				_cQuery += " 	AND SE1T.E1_FILIAL 	= '" + xFilial("SE1") + "'																					" + cEnt
				_cQuery += " 	AND SE1T.E1_PREFIXO	= BD6.BD6_PREFIX																							" + cEnt
				_cQuery += " 	AND SE1T.E1_NUM		= BD6.BD6_NUMTIT																							" + cEnt
				_cQuery += " 	AND SE1T.E1_PARCELA	= BD6.BD6_PARCEL																							" + cEnt
				_cQuery += " 	AND SE1T.E1_TIPO 	= BD6.BD6_TIPTIT																							" + cEnt

				//----------------------------------------------
				//Valida็ใo para saber se ้ colaborador
				//----------------------------------------------
				If SUBSTR(_cChvBenf,5,4) <> '0003'

					_cQuery += " 	AND(																															" + cEnt
					_cQuery += " 		SE1T.E1_NUMBOR <> ' ' 																										" + cEnt
					_cQuery += "		OR 																															" + cEnt
					_cQuery += "		EXISTS (																													" + cEnt
					_cQuery += "				SELECT ZZ5_NUMTIT																									" + cEnt
					_cQuery += " 				FROM 																												" + cEnt
					_cQuery += "	 				" + RetSqlName("ZZ5") + " ZZ5																					" + cEnt
					_cQuery += " 				WHERE 																												" + cEnt
					_cQuery += " 					ZZ5.ZZ5_FILIAL 		= '" + xFilial("ZZ5") + "'																	" + cEnt
					_cQuery += " 					AND ZZ5.ZZ5_PRETIT	= SE1T.E1_PREFIXO																			" + cEnt
					_cQuery += " 					AND ZZ5.ZZ5_NUMTIT	= SE1T.E1_NUM																				" + cEnt
					_cQuery += " 					AND ZZ5.ZZ5_PARTIT	= SE1T.E1_PARCELA																			" + cEnt
					_cQuery += " 					AND ZZ5.ZZ5_TIPTIT	= SE1T.E1_TIPO																				" + cEnt
					_cQuery += " 					AND ZZ5.D_E_L_E_T_ 	= ' ' )																						" + cEnt
					_cQuery += " 		OR 																															" + cEnt
					_cQuery += " 		SE1T.E1_FORMREC IN ('01','05','08')																							" + cEnt
					_cQuery += "		) 																															" + cEnt

				EndIf

				_cQuery += " 	AND BA1T.BA1_CODINT = '" + (_cAlias2)->(BA1_CODINT) + "' 																		" + cEnt
				_cQuery += " 	AND BA1T.BA1_CODEMP = '" + (_cAlias2)->(BA1_CODEMP) + "' 																		" + cEnt
				_cQuery += " 	AND BA1T.BA1_MATRIC = '" + (_cAlias2)->(BA1_MATRIC) + "' 																		" + cEnt
				_cQuery += " 	AND BA1T.BA1_TIPREG = '" + (_cAlias2)->(BA1_TIPREG) + "' 																		" + cEnt
				_cQuery += " 	AND SE1T.E1_ANOBASE||SE1T.E1_MESBASE||'01' = '" + _cAno + _cMes + "01' 															" + cEnt
				_cQuery += " 	AND BA1T.BA1_CODINT = BD6.BD6_OPEUSR																							" + cEnt
				_cQuery += " 	AND BA1T.BA1_CODEMP = BD6.BD6_CODEMP																							" + cEnt
				_cQuery += " 	AND BA1T.BA1_MATRIC = BD6.BD6_MATRIC																							" + cEnt
				_cQuery += " 	AND BD6.BD6_CODRDA 	= BAU.BAU_CODIGO																							" + cEnt
				_cQuery += " 	AND BD6.BD6_VLRBPF 	> 0																											" + cEnt
				_cQuery += " 	AND BD6.BD6_VLRTPF 	> 0																											" + cEnt
				_cQuery += " 	AND BD6.D_E_L_E_T_ 	= ' '																										" + cEnt
				_cQuery += " 	AND BA1T.D_E_L_E_T_ = ' '																										" + cEnt
				_cQuery += " 	AND SE1T.D_E_L_E_T_ = ' '																										" + cEnt
				_cQuery += " 	AND BAU.D_E_L_E_T_ 	= ' '																										" + cEnt
				_cQuery += " GROUP BY BD6.BD6_OPEUSR||BD6.BD6_CODEMP||BD6.BD6_MATRIC||BD6.BD6_TIPREG||BD6.BD6_DIGITO , NVL(TRIM(BD6.BD6_NOMUSR),BA1_NOMUSR)		" + cEnt

				//QOut(_cQuery)

				If Select(_cAlias3) > 0
					(_cAlias3)->(DbCloseArea())
				EndIf

				PLSQuery(_cQuery,_cAlias3)

				If (_cAlias3)->(EOF())

					//---------------------------------------------------------
					//Conforme informado pelos analistas da RR - Mobile
					//Deve-se retornar o status como True, pois a critica de
					//matricula invalida ้ tratada no login do beneficiario
					//no App.
					//---------------------------------------------------------

					::_oRetUt:_cStatus	:= .T.

					oTemp3 := WsClassNew("BenfUt")

					oTemp3:_cNome	:= ""	//nome
					oTemp3:_cMatric	:= ""	//matricula
					oTemp3:_nVlTtCp	:= 0	//valor_total_copart
					oTemp3:_nVlTtUt	:= 0	//valor_total_utiliz

					oTemp4 := WsClassNew("ExtrUt")

					oTemp4:_cCdProc	:= "" 				//codigo_procedimento
					oTemp4:_cDsProc	:= "" 				//descri_procedimento
					oTemp4:_dDtAten	:= CTOD(" / / ") 	//data_atendimento
					oTemp4:_cCdPres	:= "" 				//codigo_prestador
					oTemp4:_cNmPres	:= "" 				//nome_prestador
					oTemp4:_cCPFPre	:= "" 				//cpf_cnpj_prestador
					oTemp4:_cCdTpSv	:= "" 				//codigo_tipo_servico
					oTemp4:_cDcTpSv	:= "" 				//descri_tipo_servico
					oTemp4:_nQuanti	:= 0 				//quantidade
					oTemp4:_nVlServ	:= 0 				//valor_servico
					oTemp4:_nVlCopa	:= 0 				//valor_coparticipacao

					aAdd( _aTemp4 , oTemp4)

					If Len(_aTemp4) > 0

						oTemp3:_aExtrat	:= _aTemp4

					EndIf

					aAdd( _aTemp3 , oTemp3)

					If Len(_aTemp3) > 0

						oTemp2:_cBenefi	:= _aTemp3

					EndIf

					aAdd( ::_oRetUt:_aFamili , oTemp2)

				Else

					While !(_cAlias3)->(EOF())

						oTemp3 := WsClassNew("BenfUt")

						oTemp3:_cNome	:= (_cAlias3)->(NM_BENF ) //nome
						oTemp3:_cMatric	:= (_cAlias3)->(MAT_BENF) //matricula
						oTemp3:_nVlTtCp	:= (_cAlias3)->(VLTOTUT ) //valor_total_copart
						oTemp3:_nVlTtUt	:= (_cAlias3)->(VLTOTCOP) //valor_total_utiliz

						//--------------------------------------------------------------------------------
						//-- Defini็ใo da estrutura extrato
						//--------------------------------------------------------------------------------

						_cAlias4 := GetNextAlias()

						_cQuery := " SELECT																															 	" + cEnt
						_cQuery += " 	BD6.BD6_CODPRO COD_PROC,																										" + cEnt
						_cQuery += " 	BD6.BD6_DESPRO DSC_PROC,																										" + cEnt
						_cQuery += " 	FORMATA_DATA_MS(BD6.BD6_DATPRO) DT_EXEC,																						" + cEnt
						_cQuery += " 	BAU.BAU_CODIGO CD_PREST,																										" + cEnt
						_cQuery += " 	NVL(TRIM(BAU.BAU_NFANTA),BAU.BAU_NOME) NM_PREST,																				" + cEnt
						_cQuery += " 	BAU.BAU_CPFCGC CNPJPREST,																										" + cEnt
						_cQuery += " 	ZZT.ZZT_CODEV CDTPSERV,																											" + cEnt
						_cQuery += " 	ZZT.ZZT_EVENTO DSCTPSV,																											" + cEnt
						_cQuery += " 	(BD6.BD6_QTDPRO) QUANT,																											" + cEnt
						_cQuery += " 	(BD6.BD6_VLRBPF) VL_SERV,																										" + cEnt
						_cQuery += " 	(BD6.BD6_VLRTPF) VL_COP																											" + cEnt
						_cQuery += " FROM																																" + cEnt
						_cQuery += " 	" + RetSqlName("BD6") + " BD6 , 																								" + cEnt
						_cQuery += " 	" + RetSqlName("BA1") + " BA1T,																									" + cEnt
						_cQuery += " 	" + RetSqlName("SE1") + " SE1T,																									" + cEnt
						_cQuery += " 	" + RetSqlName("BAU") + " BAU ,																									" + cEnt
						_cQuery += " 	" + RetSqlName("ZZT") + " ZZT																									" + cEnt
						_cQuery += " WHERE																																" + cEnt
						_cQuery += " 	BA1T.BA1_FILIAL 	= '" + xFilial("BA1") + "'																					" + cEnt
						_cQuery += " 	AND BD6.BD6_FILIAL 	= '" + xFilial("BD6") + "'																					" + cEnt
						_cQuery += " 	AND BAU.BAU_FILIAL 	= '" + xFilial("BAU") + "'																					" + cEnt
						_cQuery += " 	AND ZZT.ZZT_FILIAL 	= '" + xFilial("ZZT") + "'																					" + cEnt
						_cQuery += " 	AND SE1T.E1_FILIAL 	= '" + xFilial("SE1") + "'																					" + cEnt
						_cQuery += " 	AND SE1T.E1_PREFIXO	= BD6.BD6_PREFIX																							" + cEnt
						_cQuery += " 	AND SE1T.E1_NUM		= BD6.BD6_NUMTIT																							" + cEnt
						_cQuery += " 	AND SE1T.E1_PARCELA	= BD6.BD6_PARCEL																							" + cEnt
						_cQuery += " 	AND SE1T.E1_TIPO 	= BD6.BD6_TIPTIT																							" + cEnt

						//----------------------------------------------
						//Valida็ใo para saber se ้ colaborador
						//----------------------------------------------
						If SUBSTR(_cChvBenf,5,4) <> '0003'

							_cQuery += " 	AND	(																															" + cEnt
							_cQuery += " 			SE1T.E1_NUMBOR <> ' '																									" + cEnt
							_cQuery += " 			OR																														" + cEnt
							_cQuery += " 			EXISTS (																												" + cEnt
							_cQuery += " 					SELECT																											" + cEnt
							_cQuery += " 						ZZ5.ZZ5_NUMTIT																								" + cEnt
							_cQuery += " 					FROM																											" + cEnt
							_cQuery += " 						" + RetSqlName("ZZ5") + " ZZ5																				" + cEnt
							_cQuery += " 					WHERE																											" + cEnt
							_cQuery += " 						ZZ5.ZZ5_FILIAL = '" + xFilial("ZZ5") + "'																	" + cEnt
							_cQuery += " 						AND ZZ5.ZZ5_PRETIT = SE1T.E1_PREFIXO																		" + cEnt
							_cQuery += " 						AND ZZ5.ZZ5_NUMTIT = SE1T.E1_NUM																			" + cEnt
							_cQuery += " 						AND ZZ5.ZZ5_PARTIT = SE1T.E1_PARCELA																		" + cEnt
							_cQuery += " 						AND ZZ5.ZZ5_TIPTIT = SE1T.E1_TIPO																			" + cEnt
							_cQuery += " 						AND ZZ5.D_E_L_E_T_ = ' '																					" + cEnt
							_cQuery += " 					)																												" + cEnt
							_cQuery += " 			OR																														" + cEnt
							_cQuery += " 			SE1T.E1_FORMREC IN ('01','05','08')																						" + cEnt
							_cQuery += " 		 )																															" + cEnt

						EndIf

						_cQuery += " 	AND BA1T.BA1_CODINT = '" + (_cAlias2)->(BA1_CODINT) + "'																		" + cEnt
						_cQuery += " 	AND BA1T.BA1_CODEMP = '" + (_cAlias2)->(BA1_CODEMP) + "'																		" + cEnt
						_cQuery += " 	AND BA1T.BA1_MATRIC = '" + (_cAlias2)->(BA1_MATRIC) + "'																		" + cEnt
						_cQuery += " 	AND BA1T.BA1_TIPREG = '" + (_cAlias2)->(BA1_TIPREG) + "'																		" + cEnt
						_cQuery += " 	AND SE1T.E1_ANOBASE||SE1T.E1_MESBASE||'01' = '" + _cAno + _cMes + "01' 															" + cEnt
						_cQuery += " 	AND BA1T.BA1_CODINT = BD6.BD6_OPEUSR																							" + cEnt
						_cQuery += " 	AND BA1T.BA1_CODEMP = BD6.BD6_CODEMP																							" + cEnt
						_cQuery += " 	AND BA1T.BA1_MATRIC = BD6.BD6_MATRIC																							" + cEnt
						_cQuery += " 	AND BD6.BD6_CODRDA 	= BAU.BAU_CODIGO																							" + cEnt
						_cQuery += " 	AND BD6.BD6_VLRBPF 	> 0																											" + cEnt
						_cQuery += " 	AND BD6.BD6_VLRTPF 	> 0																											" + cEnt
						_cQuery += " 	AND BD6.BD6_YNEVEN 	= ZZT.ZZT_CODEV																								" + cEnt
						_cQuery += "	AND BD6.BD6_TIPREG = SUBSTR('" + (_cAlias3)->(MAT_BENF) + "',15,2)																" + cEnt
						_cQuery += "	AND BD6.BD6_DIGITO = SUBSTR('" + (_cAlias3)->(MAT_BENF) + "',17,1)																" + cEnt
						_cQuery += " 	AND BD6.D_E_L_E_T_ 	= ' '																										" + cEnt
						_cQuery += " 	AND BA1T.D_E_L_E_T_ = ' '																										" + cEnt
						_cQuery += " 	AND SE1T.D_E_L_E_T_ = ' '																										" + cEnt
						_cQuery += " 	AND BAU.D_E_L_E_T_  = ' '																										" + cEnt
						_cQuery += " 	AND ZZT.D_E_L_E_T_  = ' '																										" + cEnt

						//QOut(_cQuery)

						If Select(_cAlias4) > 0
							(_cAlias4)->(DbCloseArea())
						EndIf

						PLSQuery(_cQuery,_cAlias4)

						While !(_cAlias4)->(EOF())

							oTemp4 := WsClassNew("ExtrUt")

							oTemp4:_cCdProc	:= (_cAlias4)->(COD_PROC ) //codigo_procedimento
							oTemp4:_cDsProc	:= (_cAlias4)->(DSC_PROC ) //descri_procedimento
							oTemp4:_dDtAten	:= CTOD((_cAlias4)->(DT_EXEC  )) //data_atendimento
							oTemp4:_cCdPres	:= (_cAlias4)->(CD_PREST ) //codigo_prestador
							oTemp4:_cNmPres	:= (_cAlias4)->(NM_PREST ) //nome_prestador
							oTemp4:_cCPFPre	:= (_cAlias4)->(CNPJPREST) //cpf_cnpj_prestador
							oTemp4:_cCdTpSv	:= cValToChar((_cAlias4)->(CDTPSERV )) //codigo_tipo_servico
							oTemp4:_cDcTpSv	:= (_cAlias4)->(DSCTPSV  ) //descri_tipo_servico
							oTemp4:_nQuanti	:= (_cAlias4)->(QUANT	 ) //quantidade
							oTemp4:_nVlServ	:= (_cAlias4)->(VL_SERV  ) //valor_servico
							oTemp4:_nVlCopa	:= (_cAlias4)->(VL_COP	 ) //valor_coparticipacao

							aAdd( _aTemp4 , oTemp4)

							(_cAlias4)->(DbSkip())

						EndDo

						If Len(_aTemp4) > 0

							oTemp3:_aExtrat	:= _aTemp4

							//-----------------------------------
							//Ap๓s utiliza็ใo zerar o vetor
							//-----------------------------------
							_aTemp4 := {}

						EndIf

						aAdd( _aTemp3 , oTemp3)

						If Select(_cAlias4) > 0
							(_cAlias4)->(DbCloseArea())
						EndIf

						(_cAlias3)->(DbSkip())

					EndDo

				EndIf

				If Select(_cAlias3) > 0
					(_cAlias3)->(DbCloseArea())
				EndIf

				If Len(_aTemp3) > 0

					oTemp2:_cBenefi	:= _aTemp3

				EndIf

				aAdd( ::_oRetUt:_aFamili , oTemp2)

			EndIf

			If Select(_cAlias2) > 0
				(_cAlias2)->(DbCloseArea())
			EndIf

		EndIf
		//--------------------------------------------------------------------------------
		// FIM - Montando Informa็๕es da familia, caso ela nใo venha vazia
		//--------------------------------------------------------------------------------

	Else

		//---------------------------------------------------------
		//Conforme informado pelos analistas da RR - Mobile
		//Deve-se retornar o status como True, pois a critica de
		//matricula invalida ้ tratada no login do beneficiario
		//no App.
		//---------------------------------------------------------

		::_oRetUt:_cStatus	:= .T.


		oTemp1 := WsClassNew("EmprUt")

		oTemp1:_cNome 	:= ""
		oTemp1:_cCNPJ	:= ""
		oTemp1:_cContra	:= ""
		oTemp1:_cEstipu	:= ""

		aAdd( ::_oRetUt:_aEmpres , oTemp1)

		oTemp2 := WsClassNew("FamiUt")

		oTemp2:_cNmTitu	:= 	""	//nome_titular
		oTemp2:_cMatTit	:= 	""	//matricula_titular

		oTemp3 := WsClassNew("BenfUt")

		oTemp3:_cNome	:= ""	//nome
		oTemp3:_cMatric	:= ""	//matricula
		oTemp3:_nVlTtCp	:= 0	//valor_total_copart
		oTemp3:_nVlTtUt	:= 0	//valor_total_utiliz

		oTemp4 := WsClassNew("ExtrUt")

		oTemp4:_cCdProc	:= "" 				//codigo_procedimento
		oTemp4:_cDsProc	:= "" 				//descri_procedimento
		oTemp4:_dDtAten	:= CTOD(" / / ") 	//data_atendimento
		oTemp4:_cCdPres	:= "" 				//codigo_prestador
		oTemp4:_cNmPres	:= "" 				//nome_prestador
		oTemp4:_cCPFPre	:= "" 				//cpf_cnpj_prestador
		oTemp4:_cCdTpSv	:= "" 				//codigo_tipo_servico
		oTemp4:_cDcTpSv	:= "" 				//descri_tipo_servico
		oTemp4:_nQuanti	:= 0 				//quantidade
		oTemp4:_nVlServ	:= 0 				//valor_servico
		oTemp4:_nVlCopa	:= 0 				//valor_coparticipacao

		aAdd( _aTemp4 , oTemp4)

		If Len(_aTemp4) > 0

			oTemp3:_aExtrat	:= _aTemp4

		EndIf

		aAdd( _aTemp3 , oTemp3)

		If Len(_aTemp3) > 0

			oTemp2:_cBenefi	:= _aTemp3

		EndIf

		aAdd( ::_oRetUt:_aFamili , oTemp2)

	EndIf

Return lRet
