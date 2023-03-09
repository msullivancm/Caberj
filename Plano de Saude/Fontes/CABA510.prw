#INCLUDE "rwmake.ch"

/*------------------------------------------------------------------------- 
| Programa  | CABA510   |Autor  | Otavio Pinto        | Data |  09/09/2014 |
|--------------------------------------------------------------------------|
| Desc.     | AxCadastro para a tabela ZDL - Regras para Calculo de Data   |
|           | Limite.                                                      |
 -------------------------------------------------------------------------*/
user function CABA510
local cVldAlt := ".T." // Validacao para permitir a alteracao. Pode-se utilizar ExecBlock.
local cVldExc := ".T." // Validacao para permitir a exclusao. Pode-se utilizar ExecBlock.

private cString := "ZDL"

dbSelectArea(cString) 
dbSetOrder(1)
AxCadastro(cString,"Regras para Calculo de Data Limite",cVldExc,cVldAlt)

return
