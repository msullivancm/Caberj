#Include  'Protheus.ch'

/*/

Autor       : Fabio Bianchini
---------------------------------------------------------------------------------------
Data      	: 08/10/2020
---------------------------------------------------------------------------------------
Descricao 	: O ponto de entrada FA240PA permite a seleção de PA com movimento bancário 
              na tela de Borderô de pagamento. 
---------------------------------------------------------------------------------------
Partida   	: Ponto de Entrada

/*/

User Function FA240PA()

Local lRet  :=  .T.  // .T. - para o sistema permitir a seleção de PA (com mov. Bancário) na tela de borderô de pagamento e
                     // .F. - para não permitir.
Return lRet