#INCLUDE 'PROTHEUS.CH'
#INCLUDE "RWMAKE.CH"
#INCLUDE "TOPCONN.CH"
#INCLUDE "TBICONN.CH"

#DEFINE c_ent CHR(13) + CHR(10)

//-------------------------------------------------------------------
/*/{Protheus.doc} function CABG015
description Gatilho para trazer corretamente a numeração da fatura
na rotina de liquidação
@author  Angelo Henrique
@since   25/04/2022
@version version
/*/
//-------------------------------------------------------------------
User Function CABG015()

    Local _aArea    := GetArea()
    Local _cRet     := ""
    Local cAliQry 	:= GetNextAlias()
    Local _cQuery   := ""

    _cQuery := " SELECT                                                         " + c_ent
    _cQuery += " 	LPAD((MAX(E1_NUM) + 1),"+ cvaltochar(TAMSX3("E1_NUM")[1]) + ",'0') PROX " + c_ent
    _cQuery += " FROM                                                           " + c_ent
    _cQuery += " 	" + RETSQLNAME("SE1") + " SE1                               " + c_ent
    _cQuery += " WHERE                                                          " + c_ent
    _cQuery += " 	E1_FILIAL = '" + xFilial("SE1") + "'                        " + c_ent
    _cQuery += " 	AND E1_PREFIXO = '" + M->FO2_PREFIX + "'                    " + c_ent
    _cQuery += " 	AND LENGTH(TRIM(E1_NUM)) = LENGTH(E1_NUM)                   " + c_ent
    _cQuery += " 	AND D_E_L_E_T_ = ' '                                        " + c_ent

    If Select(cAliQry)>0
        (cAliQry)->(DbCloseArea())
    EndIf

    DbUseArea(.T.,"TopConn",TcGenQry(,,_cQuery),cAliQry,.T.,.T.)

    DbSelectArea(cAliQry)

    If !((cAliQry)->(Eof()))

        _cRet := (cAliQry)->PROX

    Else
               
        _cRet := STRZERO(VAL("1"), TAMSX3("E1_NUM")[1])

    EndIf

    If Select(cAliQry)>0
        (cAliQry)->(DbCloseArea())
    EndIf

    RestArea(_aArea)

Return _cRet