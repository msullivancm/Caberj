#include 'rwmake.ch'
#include "TOPCONN.CH"
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABP001   ºAutor  ³Luzio Tavares       º Data ³  31/03/08   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Cadastro das Guias utilizadas no AED e no AEG              º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP7                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function CABP001()

_aArea	:= GetArea()

dbSelectARea("SZC")
dbSetOrder(1)
_cMsg	:= "Controle das Guias de Servicos para o AED"

axCadastro("SZC",_cMsg,"ExecBlock('EXCLSZC')","ExecBlock('ALTSZC')")

RestArea(_aArea)

Return

User Function ExclSZC()
Local _lRet	:= .F.
Local _cMsg	:= 'Exclusao nao permitida!'
If !MsgBox(_cMsg, 'ATENCAO', 'YESNO')
	_lRet	:= .F.
EndIf
Return(_lRet)

User Function ALTSZC()
local _lRet	:= .F.
Local cQuery := ""

M->ZC_NUMINI := strzero(val(M->ZC_NUMINI),10)
M->ZC_NUMFIM := strzero(val(M->ZC_NUMFIM),10)

cQUery := "SELECT ZC_NUMINI, ZC_NUMFIM FROM "+RetSQLName("SZC")+" "
cQUery += "WHERE D_E_L_E_T_ <> '*' AND '"+M->ZC_NUMINI+"' BETWEEN ZC_NUMINI AND ZC_NUMFIM "
cQUery += "OR '"+M->ZC_NUMFIM+"' BETWEEN ZC_NUMINI AND ZC_NUMFIM "

TCQUERY cQuery ALIAS "VALTAL" NEW

dbselectarea("VALTAL")
If Eof()
	_lRet := .T.
Else
	Alert('Guia Inicial ou Guia Final ja se encontra cadastrada')
EndIf
VALTAL->(DbCloseArea())

Return(_lRet)
