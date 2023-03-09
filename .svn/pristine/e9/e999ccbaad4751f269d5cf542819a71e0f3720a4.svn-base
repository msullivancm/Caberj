#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 17/09/01


** Programa  : MT100Tok   Autor : Erika Schmitz              Data  10/06/02   **     
** Descricao : Ponto de entrada para nao permitir gerar nota fiscal de entrada**
**             caso o campo natureza esteja em branco.                        **


***********************
User Function MT100TOk() 
***********************

V_Ok     := .T.

IF Inclui .And. Alltrim(FunName()) == "MATA103" 

   V_RetTmp := MAFISRET(,"NF_NATUREZA")

   If Empty(V_RetTmp) .AND. SF4->F4_DUPLIC ="S"
      
      Msgbox("Nota Fiscal sem natureza informada. " + chr(13)+ ;
             "Pontanto, nao podera ser gerada.")
      
      V_Ok     := .F.


   Endif
Endif


Return(V_Ok)

