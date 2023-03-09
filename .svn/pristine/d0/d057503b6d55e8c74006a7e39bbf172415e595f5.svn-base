#Include "protheus.ch"
#Include "rwmake.ch"
/*------------------------------------------------------------------------- 
| Programa  |VldDatIni     |Autor  |Otavio Pinto        | Data |  11/05/15 |
|--------------------------------------------------------------------------|
| Desc.     | Validacao da data Inicial                                    |
|           |                                                              |
|--------------------------------------------------------------------------|
| Uso       | Parametro da pergunta AUTPRO e AUTPRO2                       |
 -------------------------------------------------------------------------*/
user function VldDatIni( __cParam1 )      
local   lRet := .T.

if ( __cParam1 < dDataBase )     
   MsgAlert( "Data Inicial informada deve ser maior ou igual à data corrente... Verifique ! " )
   lRet := .F.
endif

return lRet

// Fim da rotina VldDatIni.prw