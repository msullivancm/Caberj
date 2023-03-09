#INCLUDE "rwmake.ch"

/*/
+---------------------------------------------------------------------------+
|  Programa  |F240PCB  | Autor | altamiro             | Data |  02/10/2015  |
+------------+--------------------------------------------------------------+
|  Descricao | Ponto de entrada para retornar a data de vencimento real     |
|            | Quando o bordero e excluido.                                 |
|            | a variavell vencto receber o vencimento real , e o vencimento|
|            | recebe a data do bordero                                     |
+----------------------------------------------------------------¢-----------+
/*/

user function F240PCB   
//local aArea := GetArea("SEA")        		
Local aAreaSEA := SEA->(GetArea())
Local aAreaSE2 := SE2->(GetArea())

   if SE2->( DbSeek( SEA->(EA_FILIAL+EA_PREFIXO+EA_NUM+EA_PARCELA+EA_TIPO+EA_FORNECE+EA_LOJA)  ) .AND. E2_NUMBOR == SEA->EA_NUMBOR )
      RecLock("SE2",.F.)
      SE2->e2_vencrea:=SE2->e2_vencto       
      se2->e2_fluxo := 'N'                                       
      SE2->( MsUnlock() )
   endif

   RestArea(aAreaSEA)    
   RestArea(aAreaSE2)

return .T.




// FIM DO F240TBOR.PRW



