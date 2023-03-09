#INCLUDE "rwmake.ch"

/*------------------------------------------------------------------------
| Funcao    | FA550CKBCO  | Otavio Pinto               | Data | 13/02/15  |
|-------------------------------------------------------------------------|
| Descricao | Ponto de Entrada para checar banco.                         |
|           |                                                             |
|           | Retornando .T. deixara o CheckBox marcado para gerar mov.   |
|           | no financeiro (SE5)                                         |
|           |                                                             |
 ------------------------------------------------------------------------*/

user function FA550CKBCO()
local lRet := if ( GetNewPar("MV_XGERFIN", "S" ) == "S", .T.,.F.)

return lRet