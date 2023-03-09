#Include "protheus.ch"
#Include "rwmake.ch"
/*
+--------------------------------------------------------------------------+
| Programa  | VldTpServ    |Autor  |Otavio Pinto        | Data |  04/07/12 |
+--------------------------------------------------------------------------+
| Desc.     | Validacao do Tipo de Servico                                 |
|           | Inibir os codigos a baixo por solicitacao do Dr.Carlos       |
|           | "04,06,08,11,23,24,25,27,36,53"                              |
|           | U_VldTpServ( M->ZY_TIPOSV )                                  | 
| 24.07.12  | Incluir 44 e 47    - OSP                                     |
| 09.10.12  | Liberar 11,23,24,27,36,44    - OSP                           |
+--------------------------------------------------------------------------+
| Uso       | inclusao de usuario                                          |
+--------------------------------------------------------------------------+
*/

User Function VldTpServ( _cParam )      
local   lRet     := .T.

_cParam := Alltrim(_cParam)

if ( _cParam $ "04,06,08,25,47,53" )
   MsgAlert( "Tipo de Servico { "+_cParam+" } Nao Esta Disponivel... "+Chr(13)+Chr(13)+"Informe Outro Codigo ! "   )
   lRet := .F.
endif

return lRet