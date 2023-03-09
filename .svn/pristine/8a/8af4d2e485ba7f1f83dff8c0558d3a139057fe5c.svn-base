*****************************************************************************
*+-------------------------------------------------------------------------+*
*|Funcao      | F590CAN  | Autor | Edilson Leal  (Korus Consultoria)       |*
*+------------+------------------------------------------------------------+*
*|Data        | 18.12.2007                                                 |*
*+------------+------------------------------------------------------------+*
*|Descricao   | Ponto de Entrada na retirada do titulo do bordero.         |*
*|            | executado no cancelamento na manutenção de borderos.       |*
*|            | Carteria a Pagar. Verifica Integridade das tabelas.        |*
*+------------+------------------------------------------------------------+*
*|Arquivos    | SE2, SEA                                                   |*
*+------------+------------------------------------------------------------+*
*|Alteracoes  | 														                  |*
*+-------------------------------------------------------------------------+*
*****************************************************************************

#Include "Rwmake.ch"
#Include "Topconn.ch"

************************
User Function F590CAN() 
************************
 
 If Paramixb[1] <> "P"
    Return
 EndIf

 aAreaSEA    := GetArea("SEA")
 cChave      := Paramixb[2]+SE2->E2_PREFIXO+SE2->E2_NUM+SE2->E2_PARCELA+SE2->E2_TIPO+SE2->E2_FORNECE+SE2->E2_LOJA
 lMsErroAuto :=.F. 
   
 If SEA->(DbSeek(xFilial("SEA")+cChave))    
    
    Begin Transaction
    
    SEA->(RecLock("SEA",.F.))
    SEA->(DbDelete())
    SEA->(MsUnLock())    
    
    If lMsErroAuto
       DisarmTransaction()
    EndIf
    
    End Transaction
    
    If lMsErroAuto
       MostraErro()
       MsgBox("Erro na gravação do SEA!!! Contate o Administrador do Sistema.")       
    EndIf
         
 EndIf
 
 lMsErroAuto := .F.
 
 If AllTrim(SE2->E2_NUMBOR) <> "" .Or. AllTrim(SE2->E2_PORTADO) <> ""    
    
    Begin Transaction             
    
    SE2->(RecLock("SE2",.F.))
    SE2->E2_NUMBOR  := Space(6)
    SE2->E2_PORTADO := ""
    SE2->(MsUnlock())
    
    If lMsErroAuto
       DisarmTransaction()
    EndIf
    
    End Transaction
    
    If lMsErroAuto
       MostraErro()
       MsgBox("Erro na gravação do SE2!!! Contate o Administrador do Sistema.")       
    EndIf
 
 EndIf

/***************************************************************************************/
/*Atualizado por Luiz Otávio Campo 22/07/2021
/* Retornar a Data original do vencimento real após a retirdada do titulo do borderô
/***************************************************************************************/
// Comentado por Luiz Otávio 08/12/2021 -  Não alterar data de vencimento real

  /*  DbSelectArea("SE2")
    SE2->(RecLock("SE2",.F.))
    SE2->E2_VENCREA  := datavalida(SE2->E2_VENCTO)
    SE2->(MsUnlock())*/


 RestArea(aAreaSEA) 
 
Return


