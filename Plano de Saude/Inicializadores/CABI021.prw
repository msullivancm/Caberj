#INCLUDE "RWMAKE.CH"
#INCLUDE "TOPCONN.CH"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "TBICONN.CH"

#DEFINE cEnt Chr(13)+Chr(10)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABI021   ºAutor  ³Angelo Henrique     º Data ³  04/06/21   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Usado para inicializar o nome na rotina PLSA298             º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³CABERJ                                                      º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function CABI021(_cParam)

    Local _aArea 		:= GetArea()    
    Local _cRet			:= ""
    Local _cQuery 		:= ""
    Local _cGuia        := _cParam

    Private cAliQry1  	:= GetNextAlias()

    _cQuery += "SELECT                                                  " + cEnt
    _cQuery += "    TRIM(BD6.BD6_NOMUSR) NOME                           " + cEnt
    _cQuery += "FROM                                                    " + cEnt
    _cQuery += "	"	+ RetSqlName("B19")		+ " B19					" + cEnt
    _cQuery += "                                                        " + cEnt
    _cQuery += "    INNER JOIN                                          " + cEnt
    _cQuery += "	    "	+ RetSqlName("BD6")		+ " BD6			    " + cEnt
    _cQuery += "    ON                                                  " + cEnt
    _cQuery += "        BD6.BD6_FILIAL      = B19.B19_FILIAL            " + cEnt
    _cQuery += "        AND BD6.BD6_CODOPE  = SUBSTR(B19.B19_GUIA,1,4 )	" + cEnt
    _cQuery += "        AND BD6.BD6_CODLDP  = SUBSTR(B19.B19_GUIA,5,4 )	" + cEnt
    _cQuery += "        AND BD6.BD6_CODPEG  = SUBSTR(B19.B19_GUIA,9,8 ) " + cEnt
    _cQuery += "        AND BD6.BD6_NUMERO  = SUBSTR(B19.B19_GUIA,17,8) " + cEnt
    _cQuery += "        AND BD6.BD6_ORIMOV  = SUBSTR(B19.B19_GUIA,25,1) " + cEnt
    _cQuery += "        AND BD6.BD6_SEQUEN  = SUBSTR(B19.B19_GUIA,26,3) " + cEnt
    _cQuery += "        AND BD6.BD6_CODPRO  = B19.B19_COD               " + cEnt
    _cQuery += "        AND BD6.D_E_L_E_T_  = B19.D_E_L_E_T_            " + cEnt
    _cQuery += "                                                        " + cEnt
    _cQuery += "WHERE                                                   " + cEnt
    _cQuery += "    B19.B19_FILIAL 		= '" + xFilial("B19") + "'      " + cEnt
    _cQuery += "    AND B19.B19_GUIA 	= '" + _cGuia + "'              " + cEnt
    _cQuery += "    AND B19.D_E_L_E_T_ 	= ' '                           " + cEnt

    If Select(cAliQry1)>0
        (cAliQry1)->(DbCloseArea())
    EndIf

    DbUseArea(.T.,"TopConn",TcGenQry(,,_cQuery),cAliQry1,.T.,.T.)

    DbSelectArea(cAliQry1)

    If !((cAliQry1)->(Eof()))

        _cRet := (cAliQry1)->NOME

    EndIf

    If Select(cAliQry1)>0
        (cAliQry1)->(DbCloseArea())
    EndIf
    
    RestArea(_aArea	)

Return _cRet