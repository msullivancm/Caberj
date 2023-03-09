#include 'protheus.ch'
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ PLGRVBM1 ºAutor  ³Roger Cangianeli    º Data ³  13/02/08   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Ponto de entrada na composição da cobrança para divisão do º±±
±±º          ³ valor por tipo de atos, para planos PF e PJ.				  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Operadoras de saúde - cooperativas						  º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function PLGRVBM1() 


Local nPercF, nPercJ

Local aArea		:= GetArea()
Local aAreaBFQ	:= BFQ->(GetArea())

Local nValACP	:= 0
Local nValACA	:= 0
Local nValANC	:= 0    
Local aAreaBG9	:= BG9->(GetArea())

//Local cCtpl05	:= GetNewPar('MV_YCTPL05','1/2')
Local cTipoBG9	:= Posicione("BG9",1,xFilial("BG9")+BM1->(BM1_CODINT+BM1_CODEMP),"BG9_TIPO")



            
// Marcela Coimbra - Funcção criada para definir se a linha se refere a um plano odontológico
fSetOdonto()
 

BFQ->(dbSetOrder(1))
BFQ->(dbSeek(xFilial('BFQ')+PlsIntPad()+BM1->BM1_CODTIP,.F.))

// Percentual para calculo da base dos atos, deve ser igual a 1, que representa 100%.
nPercF	:= BFQ->(BFQ_YBACPF+BFQ_YBACAF)
nPercJ	:= BFQ->(BFQ_YBACPJ+BFQ_YBACAJ+BFQ_YBANCJ)

// Verifica se não achou o lançamento, se o total PF é diferente de 100% ou se o total PJ é diferente de 100%.
// Se atender uma das condições, aborta o processo de divisão da composição.
If BFQ->(Eof()) .or. nPercF # 1.00 .or. nPercJ # 1.00
	BFQ->(RestArea(aAreaBFQ))
	RestArea(aArea)
	RestArea(aAreaBG9)
	Return()
	
Else
	If cTipoBG9 == '1' //Pessoa Fisica
		// Calcula o valor da composicao por tipo de ato
		nValACP	:= NoRound(BM1->BM1_VALOR * BFQ->BFQ_YBACPF, 2)
		nValACA	:= NoRound(BM1->BM1_VALOR * BFQ->BFQ_YBACAF, 2)
		nValANC	:= 0	// Nao há Ato Nao Cooperativo para contrato PF
		// Joga o arredondamento no Ato Cooperativo Principal
		nValACP	+= BM1->BM1_VALOR - (nValACP+nValACA)
		
	Else
		// Calcula o valor da composicao por tipo de ato
		nValACP	:= NoRound(BM1->BM1_VALOR * BFQ->BFQ_YBACPJ, 2)
		nValACA	:= NoRound(BM1->BM1_VALOR * BFQ->BFQ_YBACAJ, 2)
		nValANC	:= NoRound(BM1->BM1_VALOR * BFQ->BFQ_YBANCJ, 2)
		// Joga o arredondamento no Ato Cooperativo Principal
		nValACP	+= BM1->BM1_VALOR - (nValACP+nValACA+nValANC)
		
	EndIf
	
	If nValACP+nValACA+nValANC > 0
		RecLock('BM1',.F.)
		BM1->BM1_YVLACP	:= nValACP
		BM1->BM1_YVLACA	:= nValACA
		BM1->BM1_YVLANC	:= nValANC
		BM1->(msUnlock())
	EndIf
	
EndIf		// Se lançamento deve ser dividido

	BFQ->(RestArea(aAreaBFQ))
	RestArea(aArea)
	RestArea(aAreaBG9)                                                  

Return()             
                

// Marcela Coimbra - Funcção criada para definir se a linha se refere a um plano odontológico
Static Function fSetOdonto() 

	Local a_AreaBI3 := BI3->( GetArea("BI3") )
	Local a_AreaBA1 := BA1->( GetArea("BA1") )

	RecLock('BM1',.F.)                                   
	                     //BI3_FILIAL+BI3_CODINT+BI3_CODIGO+BI3_VERSAO                                                                                                                     
		BM1->BM1_XISODO	:= iIF( POSICIONE("BI3", 1, XFILIAL("BI3") + '0001' + ALLTRIM(BM1->BM1_CODPLA), "BI3_CODSEG"  )  == '004', '1', '2')   // 1 = SIM, 2 = NAO   
		
		//BM1->BM1_CODPLA := POSICIONE("BA1", 2, XFILIAL("BA1") + BM1->(BM1_CODINT + BM1_CODEMP + BM1_MATRIC + BM1_TIPREG ), "BA1_CODPLA"  )       
		
	BM1->(msUnlock())    
	
	BI3->( RestArea( a_AreaBI3 ) )
	BA1->( RestArea( a_AreaBA1 ) )

Return		
