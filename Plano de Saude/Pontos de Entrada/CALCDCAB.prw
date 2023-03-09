#include "PLSMGER.CH"
//#include "PLSA627.CH"
#include "PROTHEUS.CH"
     
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±±
±±³Funcao    ³ CALCDCAB ³ Autor ³ Jean Schulz	        ³ Data ³ 16.05.05 ³±±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±±
±±³Descricao ³ Rotina para valorizar o acumulado						  ³±±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
 ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function CALCDCAB(dDatPro,cAno,cMes,cFaiDes,aTotLan,nItem)

Local dDatPro	:= paramixb[1]
Local cAno		:= paramixb[2]
Local cMes		:= paramixb[3]
Local cFaiDes	:= paramixb[4]
Local aTotLan	:= paramixb[5]
Local nItem		:= paramixb[6]
Local cChaveBKJ	:= BKJ->(BKJ_FILIAL+BKJ_CODIGO+BKJ_VERSAO)
Local nCont		:= 0
                          
LOCAL nTaxDes	:= 0
LOCAL nVlrMax	:= 0
LOCAL nVlrAdi	:= 0
LOCAL nSalario	:= 0             
LOCAL nSalAdic	:= 0         
LOCAL aMatRet	:= {}          
LOCAL aVetAux	:= {}        
LOCAL nUtiliza	:= aTotLan[nItem][2]   
LOCAL nAcumu1	:= aTotLan[nItem][3]
LOCAL nAcumu2	:= aTotLan[nItem][4]
LOCAL nVlrPag	:= 0             
LOCAL nVlrAc1	:= 0
LOCAL nVlrAc2	:= 0
LOCAL lFouSRA	:= .F.
LOCAL lCalcula	:= .T.
LOCAL aAcertos	:= {}
LOCAL aRetPto	:= {}
LOCAL nVlrJaAnl	:= 0
LOCAL cSitFolh := ""
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Posiciona no funcionario                                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If aTotLan[nItem][6] <> "1" // se for debito   
     Return({})
Endif            
If Len(aTotLan[nItem]) >= 7
	lCalcula := aTotLan[nItem][7]
Endif 

SRA->(DbSetOrder(1))
if SRA->(DbSeek(BA3->BA3_AGFTFU+BA3->BA3_AGMTFU))
    lFouSRA := .T.
    cSitFolh:= SRA->RA_SITFOLH
endif
    
if BA3->(FieldPos("BA3_VALSAL")) > 0 .and. BA3->BA3_VALSAL > 0 
	nSalario := BA3->BA3_VALSAL                       
	nSalAdic := &(GetNewPar("MV_PLCOMS1",'0'))    
else                 
	if lFouSRA
      	nSalario := &(GetNewPar("MV_PLCOMSA",'0'))
      	nSalAdic := &(GetNewPar("MV_PLCOMS1",'0'))    
    endif
endif              
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Pega o percentual padrao a ser descontado							 		³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
nTaxDes := PLSFAIDE(cFaiDes,nSalario,dDatPro)
nVlrMax := (nTaxDes/100)*nSalario

If nItem > 1
	For nCont := 1 to nItem-1
		If BKJ->(MsSeek(cChaveBKJ+aTotLan[nCont,1]))
			If !Empty(BKJ->BKJ_FORCAL)   // Em validação Gedilson 20/08/09
			  nVlrJaAnl += aTotLan[ncont,2]+aTotLan[ncont,3]
		    Endif
		Endif
	Next
Endif


If lCalcula

	If nVlrJaAnl >= nVlrMax
		nVlrAc1 := nAcumu1+nUtiliza
		nVlrPag := 0
	Else	
		nVlrMax := nVlrMax - nVlrJaAnl
		If nAcumu1 > 0
				
			If nAcumu1 + nUtiliza > nVlrMax
				nVlrPag := nVlrMax
				nVlrAc1 := (nAcumu1 + nUtiliza) - nVlrMax
			Else                
				nVlrPag := nAcumu1 + nUtiliza
				nVlrAc1 := 0
			Endif   
	
		Else                
		
			If  nUtiliza > nVlrMax
				
				nVlrPag	:= nVlrMax			
				nVlrAc1	:= nUtiliza-nVlrMax
		   	
			Else  
			              
				nVlrPag := nUtiliza	   
				nVlrAc1 := 0
				nVlrAc2 := 0
			
			Endif
		Endif
	Endif
Else
	nVlrPag := nUtiliza	   
	nVlrAc1 := nAcumu1
	nVlrAc2 := nAcumu2
Endif

           
aadd(aMatRet,{nVlrPag,nVlrAc1,nVlrAc2})
//[1] valor que estou pagando no mes
//[2] valor que estou acumlando no mes
//[3] valor que estou acumlando no mes   
Return(aMatRet)

/*/
