#Include  'Protheus.ch'

/*/

Autor       : Fabio Bianchini
---------------------------------------------------------------------------------------
Data      	: 08/10/2020
---------------------------------------------------------------------------------------
Descricao 	: O ponto de entrada FA240PA permite a sele��o de PA com movimento banc�rio 
              na tela de Border� de pagamento. 
---------------------------------------------------------------------------------------
Partida   	: Ponto de Entrada

/*/

User Function FA240PA()

Local lRet  :=  .T.  // .T. - para o sistema permitir a sele��o de PA (com mov. Banc�rio) na tela de border� de pagamento e
                     // .F. - para n�o permitir.
Return lRet