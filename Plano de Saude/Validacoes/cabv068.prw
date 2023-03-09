#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'FWMVCDEF.CH'

// +--------------------------+----------------------------------+------------+
// | Programa : cabv068.prw   | Autor : Marcelo Trindade         | 05/10/2022 |
// +--------------------------+----------------------------------+------------+
// | Funcao   : cabv068() validacao de campo BAQ_YGPESP - grupo especialidade.|
// +--------------------------------------------------------------------------+
// | Descricao: Solicitação Paulo                      .           |
// +--------------------------------------------------------------------------+



User function CABV068()

Local lRet := .T.

 DbSelectArea('SX5')
 SX5->(DbSetOrder(1)) // X5_FILIAL+X5_TABELA+X5_CHAVE
 SX5->(DbGoTop())

IF M->BAQ_YDIVUL = "1"
   If !SX5->(DbSeek(FWxFilial("SX5") + "97" + M->BAQ_YGPESP))
       Alert("Necessário informar campo grupo especialidade valido.") 
      lRet := .F.
   Endif
Endif

Return(lRet)

