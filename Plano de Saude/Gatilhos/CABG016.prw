#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'PARMTYPE.CH'

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  � CABG016  �Autor  �Angelo Henrique     � Data �  14/06/2022 ���
�������������������������������������������������������������������������͹��
���Desc.     �Gatilho criado para preencher os campos de Hisotico Padrao  ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       �CABERJ                                                      ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function CABG016()

	Local _cArea    := GetArea()
	Local _cArPBL   := PBL->(GetArea())
	Local _cArBAQ   := BAQ->(GetArea())
	Local _cArPCD   := PCD->(GetArea())
	Local _cRet     := ""
	Local _nPosTp	:= Ascan(aHeader,{|x| AllTrim(x[2]) == "ZY_TIPOSV" 	})
	Local _nPosHp	:= Ascan(aHeader,{|x| AllTrim(x[2]) == "ZY_DSCHIST" })

	DbSelectArea("PBL")
	DbSetOrder(1)
	If DbSeek(xFilial("PBL")+aCols[Len(Acols)][_nPosTp])

		//-----------------------------------------------------------
		//Tipo de servi�o normal, onde ser� feito os gatilhos atuais
		//-----------------------------------------------------------
		If PBL->PBL_GERED <> '1'

			_cRet := PADL(TRIM(M->ZY_HISTPAD),TAMSX3("ZY_HISTPAD")[1],"0")

			M->ZY_DSCHIST := POSICIONE("PCD",1,XFILIAL("PCD")+_cRet,"PCD_DESCRI")
			acols[n,_nPosHp] := POSICIONE("PCD",1,XFILIAL("PCD")+_cRet,"PCD_DESCRI")

		Else

			//-----------------------------------------------------------
			//Tratando aqui o processo do GERED
			//-----------------------------------------------------------
			DbSelectArea("BAQ")
			DbSetOrder(1)
			If (DbSeek(xFilial("BAQ") + "0001" + PADR(ALLTRIM(M->ZY_HISTPAD),tamsx3("BAQ_CODESP")[1])))

				_cRet := M->ZY_HISTPAD
				M->ZY_DSCHIST := BAQ->BAQ_DESCRI 	//Em alguns momentos preenche utilizando M->
				acols[n,_nPosHp] := BAQ->BAQ_DESCRI //Em alguns momentos preenche utilizando o ACOLS

			Else

				_cRet := PADL(TRIM(M->ZY_HISTPAD),TAMSX3("ZY_HISTPAD")[1],"0")

				M->ZY_DSCHIST := POSICIONE("PCD",1,XFILIAL("PCD")+_cRet,"PCD_DESCRI")
				acols[n,_nPosHp] := POSICIONE("PCD",1,XFILIAL("PCD")+_cRet,"PCD_DESCRI")

			EndIf

		EndIf

	EndIf

	RestArea(_cArPCD)
	RestArea(_cArBAQ)
	RestArea(_cArPBL)
	RestArea(_cArea )

Return _cRet
