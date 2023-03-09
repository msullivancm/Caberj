#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'PARMTYPE.CH'
#INCLUDE "APWEBSRV.CH"
#INCLUDE "TBICONN.CH"

/*/{Protheus.doc} WSXFUNC
    Rotina que irá conter todas as funções genéricas dos webservice da caberj
@type function
@version  1.0
@author angelo.cassago
@since 16/01/2023
@param _cFunc, variant, Traz qual função será executada.
@return variant, Dependendo de quem esta chamando e a função que será executada poderá retornar logico, caracter e etc
/*/
User Function WSXFUNC(_cFunc)

	Local _xRet := NIL

	_xRet := &_cFunc

Return _xRet

/*/{Protheus.doc} WSMATCPF
    Rotina que será utilizada para trazer a matricula do beneficiário 
    quando o mesmo coloca o CPF no aplicativo
@type function
@version  1.0
@author angelo.cassago
@since 16/01/2023
@param _cLogMob, variant, Recebe o CPF informado no mobile para poder procurar a matricula 
@return variant, retorna a matricual com base no CPF informado.
/*/
Static Function WSMATCPF(_cLogMob)

	Local _cMat     := ""
	Local _cQuery   := ""
	Local _cAlias1  := GetNextAlias()

	_cQuery := " SELECT 												" + CRLF
	_cQuery += "    BA1_CODINT||BA1.BA1_CODEMP||BA1.BA1_MATRIC||BA1.BA1_TIPREG||BA1.BA1_DIGITO MATRICULA " + CRLF
	_cQuery += " FROM 													" + CRLF
	_cQuery += "     " + RetSqlName("BA1") + " BA1 						" + CRLF
	_cQuery += "      													" + CRLF
	_cQuery += "     INNER JOIN 										" + CRLF
	_cQuery += "         " + RetSqlName("BI3") + " BI3 					" + CRLF
	_cQuery += "     ON 												" + CRLF
	_cQuery += "         BI3_FILIAL = BA1.BA1_FILIAL 					" + CRLF
	_cQuery += "         AND BI3.BI3_CODINT = BA1.BA1_CODINT 			" + CRLF
	_cQuery += "         AND BI3.BI3_CODIGO = BA1.BA1_CODPLA			" + CRLF
	_cQuery += "         AND BI3.BI3_CODSEG <> '004' 					" + CRLF
	_cQuery += "         AND BI3.D_E_L_E_T_ = ' ' 						" + CRLF
	_cQuery += " WHERE 													" + CRLF
	_cQuery += "     BA1.BA1_FILIAL 	= '" + xFilial("BA1") + "' 		" + CRLF
	_cQuery += "     AND BA1.BA1_CODINT = '0001' 						" + CRLF
	_cQuery += "     AND BA1.BA1_CPFUSR = '" + _cLogMob + "' 			" + CRLF
	_cQuery += "     AND BA1.BA1_DATBLO = ' ' 							" + CRLF
	_cQuery += "     AND BA1.R_E_C_N_O_ = ( 							" + CRLF
	_cQuery += "         SELECT 										" + CRLF
	_cQuery += "             MAX(BA1_INT.R_E_C_N_O_) 					" + CRLF
	_cQuery += "         FROM 											" + CRLF
	_cQuery += "             " + RetSqlName("BA1") + " BA1_INT 			" + CRLF
	_cQuery += "         WHERE 											" + CRLF
	_cQuery += "             BA1_INT.BA1_FILIAL      = BA1.BA1_FILIAL 	" + CRLF
	_cQuery += "             AND BA1_INT.BA1_CODINT  = BA1.BA1_CODINT 	" + CRLF
	_cQuery += "             AND BA1_INT.BA1_CPFUSR  = BA1.BA1_CPFUSR 	" + CRLF
	_cQuery += "             AND BA1_INT.D_E_L_E_T_  = ' '     			" + CRLF
	_cQuery += "     ) 													" + CRLF
	_cQuery += "     AND BA1.D_E_L_E_T_ = ' '     						" + CRLF

	If Select(_cAlias1) > 0
		(_cAlias1)->(DbCloseArea())
	EndIf

	PLSQuery(_cQuery,_cAlias1)

	If !(_cAlias1)->(EOF())

		_cMat :=  (_cAlias1)->(MATRICULA)

	EndIf

	If Select(_cAlias1) > 0
		(_cAlias1)->(DbCloseArea())
	EndIf

Return _cMat
