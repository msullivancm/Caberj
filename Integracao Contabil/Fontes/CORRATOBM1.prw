#include 'protheus.ch'
/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  � CORRATOBM1 �Autor  �Roger Cangianeli    � Data �  13/02/08 ���
�������������������������������������������������������������������������͹��
���Desc.     � Ajuste na composi��o da cobran�a para divis�o do           ���
���          � valor por tipo de atos, para planos PF e PJ.				  ���
�������������������������������������������������������������������������͹��
���Uso       � Operadoras de sa�de - cooperativas						  ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

User Function CORRATOBM1()

If MsgYesNo('Divisao do BM1 por tipo de ato. Deseja continuar?')
	MsAguarde({|| RunProc() }, "Ajustando valor do atos BM1...", "", .T.)
	MsgAlert('Processo Finalizado')
EndIf

Return



Static Function RunProc()
Local nPercF, nPercJ, cTipoBG9
//Local cTipo, cBi3Tipo, cBi3TipCon
Local nValACP	:= 0
Local nValACA	:= 0
Local nValANC	:= 0
Local nSeq		:= 0
//Local cCtpl05	:= GetNewPar('MV_YCTPL05','1/2')

BFQ->(dbSetOrder(1))

BM1->(dbSetOrder(1))
BM1->(dbGoTop())
While !BM1->(Eof())
	
	nSeq ++
	MsProcTxt("Revisando registro " + StrZero(nSeq, 9)+"... ")
	ProcessMessages()
	
	nValACP	:= 0
	nValACA	:= 0
	nValANC	:= 0
	
	//	cBi3Tipo	:= Posicione("BI3",1,xFilial("BI3")+PLSINTPAD()+Alltrim(BM1->BM1_CODEVE),"BI3_TIPO")
	//	cBi3TipCon  := Posicione("BI3",1,xFilial("BI3")+PLSINTPAD()+Alltrim(BM1->BM1_CODEVE),"BI3_TIPCON")
	cTipoBG9	:= Posicione("BG9",1,xFilial("BG9")+BM1->(BM1_CODINT+BM1_CODEMP),"BG9_TIPO")
	
	BFQ->(dbSeek(xFilial('BFQ')+PlsIntPad()+BM1->BM1_CODTIP,.F.))
	
	// Percentual para calculo da base dos atos, deve ser igual a 1, que representa 100%.
	nPercF	:= BFQ->(BFQ_YBACPF+BFQ_YBACAF)
	nPercJ	:= BFQ->(BFQ_YBACPJ+BFQ_YBACAJ+BFQ_YBANCJ)
	
	// Verifica se n�o achou o lan�amento, se o total PF � diferente de 100% ou se o total PJ � diferente de 100%.
	// Se atender uma das condi��es, aborta o processo de divis�o da composi��o.
	If BFQ->(Eof()) .or. nPercF # 1.00 .or. nPercJ # 1.00
		BM1->(dbSkip())
		Loop
		
	Else
		If cTipoBG9 == '1' //Pessoa Fisica
			// Calcula o valor da composicao por tipo de ato
			nValACP	:= NoRound(BM1->BM1_VALOR * BFQ->BFQ_YBACPF, 2)
			nValACA	:= NoRound(BM1->BM1_VALOR * BFQ->BFQ_YBACAF, 2)
			nValANC	:= 0	// Nao h� Ato Nao Cooperativo para contrato PF
			// Joga o arredondamento no Ato Cooperativo Principal
			nValACP	+= BM1->BM1_VALOR - (nValACP+nValACA)
		Else
			// Calcula o valor da composicao por tipo de ato
			nValACP	:= NoRound(BM1->BM1_VALOR * BFQ->BFQ_YBACPJ, 2)
			nValACA	:= NoRound(BM1->BM1_VALOR * BFQ->BFQ_YBACAJ, 2)
			nValANC	:= NoRound(BM1->BM1_VALOR * BFQ->BFQ_YBANCJ, 2)
			// Joga o arredondamento no Ato Cooperativo Principal
			nValACP	+= BM1->BM1_VALOR - (nValACP+nValACA+nValANC)
		Endif
		
		If nValACP+nValACA+nValANC > 0
			RecLock('BM1',.F.)
			BM1->BM1_YVLACP	:= nValACP
			BM1->BM1_YVLACA	:= nValACA
			BM1->BM1_YVLANC	:= nValANC
			BM1->(msUnlock())
		EndIf
		
	EndIf		// Se lan�amento deve ser dividido
	
	BM1->(dbSkip())
	
EndDo

Return()
