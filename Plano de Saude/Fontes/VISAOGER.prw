#include "PLSMGER.CH"
#include "PROTHEUS.CH"    
#include "rwmake.ch"
#include "topconn.ch"

User Function VISAOGER()

Local _aArea	:= GetArea()
Local cVld	:= ".T."

dbSelectARea("SZJ")
dbSetOrder(1)
_cMsg	:= "Cadastro de visoes gerenciais - SZJ"

axCadastro("SZJ",_cMsg,cVld,cVld)

RestArea(_aArea)

Return

User Function GRUPOGER()

Local _aArea	:= GetArea()
Local cVld	:= ".T."

dbSelectARea("SZK")
dbSetOrder(1)
_cMsg	:= "Cadastro de grupos gerenciais - SZK"

axCadastro("SZK",_cMsg,cVld,cVld)

RestArea(_aArea)

Return

User Function ITENSGER()

Local _aArea	:= GetArea()
Local cVld	:= ".T."

dbSelectARea("SZL")
dbSetOrder(1)
_cMsg	:= "Cadastro de itens gerenciais - SZL"

axCadastro("SZL",_cMsg,cVld,cVld)

RestArea(_aArea)

Return
