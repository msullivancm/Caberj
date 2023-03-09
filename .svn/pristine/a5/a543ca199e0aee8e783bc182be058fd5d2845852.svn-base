#Include 'Protheus.ch'

/*/{Protheus.doc} F565TPLIQ
  Ponto de entrada utilizado para gravar os campos do PLS
  com base no campo da fatura que foi gravado no P.E. F565GRV
  Dessa forma os campos do PLS no titulo são gravados corretamente
@type function
@version  1.0
@author angelo.cassago
@since 24/10/2022
/*/
User Function F565TPLIQ

	Local _aArea    := GetArea()
	Local _aArSE2   := SE2->(GetArea())
	Local _aArSE5   := SE5->(GetArea())
	Local _cQuery   := ""
	Local cAliasTRB := GetNextAlias()
	Local _cNumLiq  := SE2->E2_NUMLIQ

	//ponterar no titulo pai e pegar as informações
	_cQuery   += " SELECT										        " + CRLF
	_cQuery   += "     SE2.E2_FILIAL,                                  	" + CRLF
	_cQuery   += "     SE2.E2_PREFIXO,                                  " + CRLF
	_cQuery   += "     SE2.E2_NUM,                                  	" + CRLF
	_cQuery   += "     SE2.E2_TIPO,                                  	" + CRLF
	_cQuery   += "     SE2.E2_FORNECE,                                  " + CRLF
	_cQuery   += "     SE2.E2_LOJA,                                  	" + CRLF
	_cQuery   += "     SE2.E2_ANOBASE,                                  " + CRLF
	_cQuery   += "     SE2.E2_MESBASE,                                  " + CRLF
	_cQuery   += "     SE2.E2_APROVA,                                   " + CRLF
	_cQuery   += "     SE2.E2_CODRDA,                                   " + CRLF
	_cQuery   += "     SE2.E2_STATLIB,                                  " + CRLF
	_cQuery   += "     SE2.E2_STATUS,                                   " + CRLF
	_cQuery   += "     SE2.E2_YLIBPLS,                                  " + CRLF
	_cQuery   += "     SE2.E2_PLLOTE,                                   " + CRLF
	_cQuery   += "     SE2.E2_DATALIB                                   " + CRLF	
	_cQuery   += " FROM                     					        " + CRLF
	_cQuery   += "     " + RetSqlName("SE2") + " SE2 			        " + CRLF
	_cQuery   += " WHERE                    					        " + CRLF
	_cQuery   += "     SE2.E2_FILIAL = '" + xFilial("SE2") + "'         " + CRLF
	_cQuery   += "     AND SE2.E2_YFATFOR   =  '" + _cNumLiq + "' 		" + CRLF
	_cQuery   += "     AND SE2.D_E_L_E_T_   =  ' ' 				        " + CRLF
	
	If Select(cAliasTRB) <> 0
		(cAliasTRB)->(dbCloseArea())
	Endif

	dbUseArea(.T.,"TOPCONN",TcGenQry(,,_cQuery),cAliasTRB,.T.,.T.)

	If !((cAliasTRB)->(Eof()))

		RecLock("SE2", .F.)

		SE2->E2_ANOBASE := (cAliasTRB)->E2_ANOBASE
		SE2->E2_MESBASE := (cAliasTRB)->E2_MESBASE
		SE2->E2_APROVA  := (cAliasTRB)->E2_APROVA
		SE2->E2_CODRDA  := (cAliasTRB)->E2_CODRDA
		SE2->E2_STATLIB := (cAliasTRB)->E2_STATLIB
		SE2->E2_STATUS  := (cAliasTRB)->E2_STATUS
		SE2->E2_PLLOTE  := (cAliasTRB)->E2_PLLOTE
		SE2->E2_YLIBPLS := (cAliasTRB)->E2_YLIBPLS
		SE2->E2_DATALIB := STOD((cAliasTRB)->E2_DATALIB)

		MsUnlock()

	Else

		Aviso("Atenção","Não foi encontrado o titulo primário da liquidação, favor entrar em contato com TI.",{"OK"})

	EndIf
    
	RestArea(_aArSE5)
	RestArea(_aArSE2)
	RestArea(_aArea )

Return
