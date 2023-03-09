#INCLUDE "RWMAKE.CH"
#include "PLSMGER.CH"
#include "COLORS.CH"
#include "TOPCONN.CH"
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³FA070CA4  ºAutor  ³Microsiga           º Data ³  09/28/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Ponto de entrada chamado no momento do cancelamento da baixaº±±
±±º          ³SE1 - Ira excluir os lancamentos no pls                     º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ FINANCEIRO                                                 º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function FA070CA4()
	Local cChave := SE1->(E1_PREFIXO+E1_NUM)//+E1_PARCELA+E1_TIPO 
	lRet := .T.      	

	cQuery := " UPDATE "+RetSqlName("BSQ")+" BSQ SET BSQ.D_E_L_E_T_ = '*' WHERE trim( BSQ_YNMSE1 ) = '" + ALLTRIM(cChave) + "'" 
	cQuery += " AND BSQ_PREFIX =' ' AND BSQ_NUMTIT =' ' AND BSQ_PARCEL = ' ' AND BSQ_TIPTIT = ' ' "
	If TcSqlExec(cQuery) < 0
		lRet := .F.	
	ENDIF	

	RecLock("SE1", .F.)
	SE1->E1_YTPEXP	:= "R"
	SE1->E1_YTPEDSC	:= Posicione("SX5", 1, xFilial("SX5")+"K1"+"R", "X5_DESCRI")
	SE1->(MsUnlock())      

return lRet

User Function FA070CAN()

	RecLock("SE1", .F.)
	SE1->E1_YTPEXP	   := "R"
	SE1->E1_YTPEDSC	   := Posicione("SX5", 1, xFilial("SX5")+"K1R", "X5_DESCRI")
	SE1->(MsUnlock())    
	
	// Marcela Coimbra - Retirar saldo negativo de acrescimo
	If SE1->E1_JUROS < 0 .or. SE1->E1_SDACRES < 0 

		RecLock("SE1", .F.)
			SE1->E1_JUROS   := 0
	    	SE1->E1_SDACRES := 0  
	    SE1->(MsUnlock())  

    EndIf                    
    
    fApagaBxAtr()

Return()      

**'Marcela Coimbra - 27/03/2013 - Chamado 5650'**
Static Function fApagaBxAtr()
      
	Local c_Qry 	:= ""
	Local lRet 		:= .T.
	Local c_CodSeq 	:= ""
	Local n_Valor  	:= 0
	
	c_Qry 	:= " SELECT BSQ_CODSEQ, BSQ_VALOR FROM  "+RetSqlName("BSQ")+" WHERE TRIM(BSQ_YNMSE1) = '" + SE1->E1_PREFIXO + SE1->E1_NUM + SE1->E1_PARCELA + "' AND BSQ_NUMTIT = ' ' "  
	
	TCQuery c_Qry Alias "TMP_BSQ" New  
	
	If !TMP_BSQ->( EOF() )
	     
		c_CodSeq := TMP_BSQ->BSQ_CODSEQ
		n_Valor  := TMP_BSQ->BSQ_VALOR
	
	EndIf  
	
	TMP_BSQ->( dbCloseArea() )  
	
	c_Qry 	:= " UPDATE " + RetSqlName("BSQ") + " BSQ SET BSQ.D_E_L_E_T_ = '*' WHERE TRIM(BSQ_YNMSE1) = '" + SE1->E1_PREFIXO + SE1->E1_NUM + SE1->E1_PARCELA + "'" 
	
	If TcSqlExec( c_Qry ) < 0                   
	
		lRet := .F.	
	
	Else
	
//		MsgInfo('O lançamento de "Baixa em Atraso" referente a esse título foi excluído.  Codigo do lançamento ' + c_CodSeq + ', Valor do lançamento: R$' + Transform(n_Valor,"999,999.99") + '.')	
	
	ENDIF	

Return lRet
