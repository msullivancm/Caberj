   #INCLUDE "rwmake.ch"

/*/
+---------------------------------------------------------------------------+
|  Programa  |F240TBOR  | Autor | Otavio Pinto       | Data |  21/05/2012   |
+------------+--------------------------------------------------------------+
|  Descricao | Ponto de entrada para Informar a data de Geracao do Bordero  |
|            | NOTA:                                                        |
|            | As variaveis, lDtBord e dDataBor estão sendo declaradas como |
|            | publicas no PA: F240BROWSE                                   |
+---------------------------------------------------------------------------+
/*/

user function F240TBOR
local oDlg
                               
if lDtBord 
   lDtBord := .F.
   //+-------------------------------------------------------------------------------+
   //| Janela para interface com usuario                                             | 
   //| Este tratamento e para que a janela seja exibida uma unica vez para solicitar |    
   //| a data de gravacao do(s) bordero(s).                                          | 
   //+-------------------------------------------------------------------------------+
   @ 120,200 TO 315,540 DIALOG oDlg TITLE OemToAnsi("DATA DE GERACAO DO BORDERO")

   @ 002,010 To 065,160
   @ 010,017 Say OemToAnsi("Informe a data de Geracao do Bordero")

   @ 031,035 GET dDataBor SIZE 070,008 VALID !EMPTY(dDataBor)

   @ 70,095 BmpButton Type 01 Action ( Processa({|| GravaBordero(dDataBor) },"Data de Geracao do Bordero","Processando ..."),Close(oDlg) )
   @ 70,135 BmpButton Type 02 Action Close(oDlg)          // Cancela

   Activate Dialog oDlg Centered
else
   GravaBordero(dDataBor)  
endif

return ""


/*--------------------------------
  GravaBordero(dDataDe)
  Rotina para gravacao da data de Geracao de Bordero
  03.04.2012 - Otavio Pinto
*/
static function GravaBordero(dDataDe)
Local aAreaSEA := SEA->(GetArea())
Local aAreaSE2 := SE2->(GetArea())

    if !empty( dDataDe )      
       if SEA->( dbSeek( EA_FILIAL+EA_NUMBOR+EA_PREFIXO+EA_NUM+EA_PARCELA+EA_TIPO+EA_FORNECE+EA_LOJA ) )
          RecLock("SEA",.F.)
          SEA->EA_DATABOR := dDataBor
          SEA->( MsUnlock() )
       endif
       if SE2->( dbSeek( SEA->(EA_FILIAL+EA_PREFIXO+EA_NUM+EA_PARCELA+EA_TIPO+EA_FORNECE+EA_LOJA)  ) .AND. E2_NUMBOR == SEA->EA_NUMBOR )
          RecLock("SE2",.F.)
          SE2->E2_DTBORDE := dDataBor  
          //// altamro 15/10/2014 -- fluxo de caixa --- Inicio 
 
          // SE2->e2_vencto:= SE2->e2_vencrea   
          //SE2->e2_vencrea:= SE2->E2_DTBORDE    //por Luiz Otávio 08/12/2021 -  Não alterar mais data de vencimento
          SE2->E2_DATAAGE:= SE2->E2_DTBORDE      // por Luiz Otávio 08/12/2021

           se2->e2_fluxo := 'S'                                       
          //// altamro 15/10/2014 -- fluxo de caixa --- Fim    
          SE2->( MsUnlock() )
       endif
    endif                                           

   RestArea(aAreaSEA)    
   RestArea(aAreaSE2)
   
return 




// FIM DO F240TBOR.PRW



