User function PL627VCT()
LOCAL nDiaInf		:= PARAMIXB[1]
LOCAL nDiaPad  		:= PARAMIXB[2]  
LOCAL cMes			:= PARAMIXB[3]  
LOCAL cAno			:= PARAMIXB[4]
LOCAL cTpVcPP		:= PARAMIXB[5]
LOCAL nVencCO		:= PARAMIXB[6]
LOCAL cTpVcCO		:= PARAMIXB[7]
LOCAL cTipo			:= PARAMIXB[8]
LOCAL nDiaRet		:= 0
LOCAL dDataPP		:= cTod('')
LOCAL dDataCO		:= cTod('')
LOCAL cMesAux       := ''
LOCAL cAnoAux		:= ''

// Se o vencimento padrao, informado no nivel de cobranca for 
// maior que dia informado no LOTE, vale o do nivel de cobranca.
If nDiaPad > nDiaInf  
	nDiaRet := nDiaPad	
Else
	nDiaRet := nDiaInf
Endif

If cTipo == '1' // Pessoa Fisica...
	dDataPP := PLMontVen(nDiaRet,cMes,cAno)

Else // Pessoa Juridica...
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Cacula data de vencimento para o pre pagamento...   |
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If cTpVcPP == '1' // Fora o mes...
		cMesAux := StrZero((Val(cMes)+1), 2)
		cAnoAux := cAno
		
		If cMesAux > '12'
			cMesAux := '01'
			cAnoAux := StrZero((Val(cAno)+1), 4)
		Endif
		
	Else
		cMesAux := cMes
		cAnoAux := cAno
		
	Endif
	dDataPP := PLMontVen(nDiaRet,cMesAux,cAnoAux) 
	 	          
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Cacula data de vencimento para o custo operacional...  |
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	// Se o vencimento padrao, informado no nivel de cobranca for 
	// maior que dia informado no LOTE, vale o do nivel de cobranca.
	If nVencCO > nDiaInf  
		nDiaRet := nVencCO
	
	Else
		nDiaRet := nDiaInf
	
	Endif	
	If cTpVcCO == '1' // Fora o mes...
		cMesAux := StrZero((Val(cMes)+1), 2)
		cAnoAux := cAno
		
		If cMesAux > '12'
			cMesAux := '01'
			cAnoAux := StrZero((Val(cAno)+1), 4)
		Endif
		
	Else
		cMesAux := cMes
		cAnoAux := cAno
		
	Endif
	dDataCO := PLMontVen(nDiaRet,cMesAux,cAnoAux)
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Se nao for informada data do CO, ela assumira a mesma data do PP...|
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If Empty(dDataCO)
		dDataCO := dDataPP
	Endif
	
Endif

If BDC->(FieldPos("BDC_YDTVCT")) > 0
	If !Empty(M->BDC_YDTVCT)
		dDataPP := M->BDC_YDTVCT
		dDataCO := M->BDC_YDTVCT
	Endif
Endif

Return({dDataPP,dDataCO})

//Return(dData)