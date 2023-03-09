#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'TOTVS.CH'
#INCLUDE 'TOPCONN.CH'
#INCLUDE 'TBICONN.CH'

User Function ORTGERLA(_aItens,_dDataLan) 

Local aArea    	:= GetArea()
Local aRet     	:= {}
Local nX		:= 0 
Local nc		:= 0 
Local nCont		:= 0  
Local cCampoCt2	:= ""  
Local cConteudo	:= ""  
Local aTempIt   := {}  
Local cChaveKey	:= ""
default _aItens := {}

if empty(_aItens)   
	aRet := { .F.,"Dados Invalidos!"}
	RestArea(aArea)
	Return aRet 
endif
/*
if !CtbStatus('01',_dDataLan,_dDataLan, .F.)	  
	aRet := { .F.,"Calendario Contabil fechado para essa data!"}
	RestArea(aArea)
	Return aRet 
endif           
*/
dbselectarea('SX3')
SX3->(dbsetorder(2)) 

dbselectarea('CT2')
CT2->(dbsetorder(1)) 

For nX := 1 To Len(_aItens)
    
    aTempIt   := _aItens[nX]
	nPosKey	  := aScan( aTempIt ,{|x| AllTrim(x[1]) == "CT2_KEY"})  
	cChaveKey := '' 
	
	if nPosKey > 0
		cChaveKey := aTempIt[nPosKey,2]
 
    
		if !fExistCt2(cChaveKey)
		 
			CT2->(RecLock("CT2",.T.))
	
			For nc := 1 To Len(aTempIt)
		         
				if SX3->(dbseek(PadR(aTempIt[nc,1],10)))
		
			   		cCampoCt2 := 'CT2->'+aTempIt[nc,1] 
					cConteudo := aTempIt[nc,2]  
							
					&cCampoCt2 := cConteudo 
				endif	
			next nc	 
	   		CT2->(MsUnLock())  	
		endif  
		nCont++ 
	endif	
Next nX   

aRet := { .T.,nCont}

YCT2->(dbCloseArea())	
RestArea(aArea)
Return aRet 