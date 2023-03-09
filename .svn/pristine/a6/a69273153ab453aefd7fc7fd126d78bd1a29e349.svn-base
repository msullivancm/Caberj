/*/

Autor	  : Edilson Leal (Korus Consultoria)
-----------------------------------------------------------------------------
Data	  : 20/02/08
-----------------------------------------------------------------------------
Descricao : Retorna valores de MULTA+IGPM para Rotina de Parcelamento
-----------------------------------------------------------------------------
Partida   : CAB010 (Parcelamento de titulos)

/*/

#Include "rwmake.ch"     
#Include "Protheus.ch"

**************************************************************
User Function CABA997A(dDataTit,dDataBx,nValor,lIGP, lJuros)  
**************************************************************
                                
 Local MULTA     := GetNewPar("MV_XMULTA",2) 
 Local JUROS     := GetNewPar("MV_XJUROS",1) 
 Local IGPM      := 0 
 Local DATATIT   := dDataTit
 Local DATABAIXA := dDataBx  
 Local VALOR     := nValor   
 Local TOTDEV    := 0  
 Local DATAPROC  := ""
 Local aIgpm     := {} 
 Local aArea     := GetArea()
 
 Local nI := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS
	
 Default lIGP    := .T.	
 Default lJuros  := .T.

 nDiasAt  := DATABAIXA - DATATIT
 nDiasAt2 := DATABAIXA - DATATIT  
		
/*	
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±
 PEGA O VALOR DO IGPM
±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
If lIGP	   
   cDataAnt := ""
	If nDiasAt2 > 0		
		SZ4->(DbSetOrder(1))		
		While nDiasAt2 > 0    			
			CAUX     :=	DaySub( DATABAIXA , nDiasAt2 )			
			DATAPROC := SUBSTR(DTOS(CAUX),1,6)			
			If cDataAnt <> DATAPROC		   
			   If SZ4->(dbSeek(xFilial("SZ4")+DATAPROC))
				   If 	SZ4->Z4_VALOR > 0
			 	 	   AADD(aIgpm, (1+(SZ4->Z4_VALOR/100) ) )	 
			      EndIf
			   Else
			     If DATAPROC <> SUBS(DTOS(DATABAIXA),1,6)
			       MsgBox("ATENÇÃO: Não existe IGPM cadastrado para o Ano/Mes: "+DATAPROC)			  						  			  
			     EndIf
			   EndIf			   
			EndIf   
			nDiasAt2  := nDiasAt2 - 30
			cDataAnt  := DATAPROC			
		End  		
		
		If Len(aIgpm) > 0			
		  IGPM := aIgpm[1]
		EndIf
		
      If Len(aIgpm) > 1	   
	      For nI := 2 To Len(aIgpm)
	   
	          IGPM *= aIgpm[nI]
   	
	      Next
      EndIf
	   
	   If Len(aIgpm) > 0				   	      
	      IGPM -= 1	
	      IGPM *= 100			
	   EndIf	   
		
	EndIf  
	                                                                     
EndIf
// Só recebe multa caso esteja em atraso.
If nDiasAt <= 0				   	      
   MULTA := 0   
EndIf
	
/*	
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
 FAZ O CALCULO DE MULTA + IGPM
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

TOTDEV := VALOR * (MULTA/100)	 // CALCULO DA MULTA
TOTDEV += VALOR * (IGPM/100)   // CALCULO DO IGPM

RestArea(aArea)	
Return  TOTDEV             