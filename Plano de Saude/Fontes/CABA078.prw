#INCLUDE "rwmake.ch"
/*--------------------------------------------------------------------------
| Programa  | CABA078  | Autor | Otavio Pinto         | Data |  21/06/2013  |
|---------------------------------------------------------------------------|
| Descricao | Procedimento do NUPRE                                         |
|           |                                                               |
|---------------------------------------------------------------------------|
| Uso       | Projeto Qualidade de Vida                                     | 
 --------------------------------------------------------------------------*/
user function CABA078

/*--------------------------------------------------------------------------
| Declaracao de Variaveis                                                   |
 --------------------------------------------------------------------------*/

local cVldAlt   := ".T." // Validacao para permitir a alteracao. Pode-se utilizar ExecBlock.
local cVldExc   := ".T." // Validacao para permitir a exclusao. Pode-se utilizar ExecBlock.
local aRotAdic  := {} 

private cString := "ZUE"

AAdd( aRotAdic, { "Imprimir", "u_PLSRZUEIMP", 0, 4 } ) 

dbSelectArea(cString)

(cString)->( dbSetOrder(1) )

AxCadastro(cString,"Procedimento do NUPRE",cVldAlt,cVldExc,aRotAdic)

return


user function PLSRZUEIMP
MsgStop( "Ainda não implementado..." ) 
return 



// Fim do Programa CABA078.PRW