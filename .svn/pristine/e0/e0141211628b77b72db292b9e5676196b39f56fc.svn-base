#INCLUDE "PROTHEUS.CH"

/*/{Protheus.doc} PLS627QR
Ponto de entrada utilizado para alterações sobre a query principal do lote de cobrança
@type function
@version 1.0  
@author angelo.cassago
@since 14/12/2022
@obs Esse PE recebe como parametro a própria query q será executada, esta query é chamado n vezes conforme for colocado a quantidade 
de empresas ou parametrizações aplicadas na tela.    
    Foram criados indices para melhorar a performance (CABERj | INTEGRAL):
    1 - BA3010_TUNING_20230102 | BA3020_TUNING_20230102
    2-  BT5010_TUNING_20230102 | BT5020_TUNING_20230102
@return variant, retorna nova query
/*/
User Function PLS627QR

	Local _cQuery   := PARAMIXB[1]
	Local _cPesq    := ""
	Local _cSubst   := ""
	Local _cEmp     := IIF(cEmpAnt == "01","010","020")

	_cPesq  := " AND BA3" + _cEmp + ".D_E_L_E_T_ = ' ' "

	//_cSubst := " AND (BA3_DATBLO = ' ' OR BA3_DATBLO >= '" + DTOS(YearSub(date(),2)) + "') " + _cPesq
	
    _cSubst := " AND                                                    " + CRLF
	_cSubst += "    (                                                   " + CRLF
	_cSubst += "        BA3_DATBLO = ' '                                " + CRLF
	_cSubst += "        OR                                              " + CRLF
	_cSubst += "        ba3_matric in                                   " + CRLF
	_cSubst += "            (                                           " + CRLF    
	_cSubst += "                select                                  " + CRLF
	_cSubst += "                    bsq.bsq_matric                      " + CRLF
	_cSubst += "                from                                    " + CRLF
	_cSubst += "                    " + RetSqlName("bsq") + " bsq       " + CRLF
	_cSubst += "                where                                   " + CRLF
	_cSubst += "                    bsq.bsq_filial      = ba3_filial    " + CRLF
	_cSubst += "                    and bsq.bsq_codint  = ba3_codint    " + CRLF
	_cSubst += "                    and bsq.bsq_codemp  = ba3_codemp    " + CRLF
	_cSubst += "                    and bsq.bsq_matric  = ba3_matric    " + CRLF
	_cSubst += "                    and bsq.bsq_numtit  = ' '           " + CRLF
	_cSubst += "                    and bsq.d_e_l_e_t_  = ' '           " + CRLF
	_cSubst += "        )                                               " + CRLF
	_cSubst += "    )                                                   " + CRLF
	_cSubst += _cPesq
    
	_cQuery := strtran(_cQuery,_cPesq,_cSubst)

	_cPesq  := " AND BT5" + _cEmp + ".D_E_L_E_T_ = ' ' "

	If M->BDC_INTERC == "0"

		_cSubst := " AND (BT5_INTERC = '0' OR BT5_INTERC = ' ' ) " + _cPesq

	Else
		_cSubst := " AND BT5_INTERC = '" + M->BDC_INTERC + "' " + _cPesq
	EndIf

	_cQuery := strtran(_cQuery,_cPesq,_cSubst)

Return _cQuery
