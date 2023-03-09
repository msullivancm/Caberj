#INCLUDE "rwmake.ch"

/*------------------------------------------------------------------------- 
| Programa  | CABA563   |Autor  | Otavio Pinto        | Data |  24/09/2014 |
|--------------------------------------------------------------------------|
| Desc.     | AxCadastro para a tabela ZRC-Regra Importacao PLS x GPE      |
|           |                                                              |
 -------------------------------------------------------------------------*/
user function CABA563
local cVldAlt := ".T." // Validacao para permitir a alteracao. Pode-se utilizar ExecBlock.
local cVldExc := ".T." // Validacao para permitir a exclusao. Pode-se utilizar ExecBlock.

private cString := "ZRC"

dbSelectArea(cString) 
dbSetOrder(1)
AxCadastro(cString,"Regra Importacao PLS x GPE",cVldExc,cVldAlt)

return
