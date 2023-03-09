#INCLUDE "TOTVS.CH"

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �MT120LOK  � Autor � Luiz Otavio        � Data �  28/02/14   ���
�������������������������������������������������������������������������͹��
���Descricao � Valida�� da linha do pedido de compras.                    ���
���          �  Validar Rateio de centro de custo.						  ���
�������������������������������������������������������������������������͹��
���Alteracoes�														      ���
���          �                                                            ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/
User Function MT120LOK()
	Local aArea := GetArea()
	Local lRet := .T.	
	Local nPosCC    := GdFieldPos("C7_CC")    //Centro de custo
	Local nPosITEM    := GdFieldPos("C7_ITEM")    //Centro de custo
    Local i:=0
	
	IF !aCols[n,len(aheader)+1]

		If Empty(aCols[n,nPosCC]) .and. !(Type("ACPISCH")="A" .And. len(ACPISCH)>0) //Valida o centro de custo se informado			
			lRet := .F.		
			Alert("O centro de custo � obrigat�rio. favor informar!")	
		ElseIf Empty(aCols[n,nPosCC])
			lRet := .F.	

			For i:= 1 to len(ACPISCH)
				If ACPISCH[i][1]= aCols[n,nPosITEM] .and. Len(ACPISCH[i][2])>0
					lRet:= .T.
					exit
				EndIf	
			Next i
				
			If !lRet		
				Alert("O centro de custo � obrigat�rio. favor informar!")	
			EndIf				
		EndIf
	EndIf

	RestArea(aArea)
	
Return lRet
