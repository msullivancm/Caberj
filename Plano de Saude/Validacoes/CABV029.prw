#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'PARMTYPE.CH'

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  � CABV028  �Autor  �Angelo Henrique     � Data �  27/03/2017 ���
�������������������������������������������������������������������������͹��
���Desc.     �Valida��o para exibir mensagem caso o benefici�rio tenha    ���
���          �bloqueio do tipo tempor�rio (aquele que n�o � encaminhado   ���
���          � para a ANS).                                               ���
�������������������������������������������������������������������������͹��
���Uso       �CABERJ                                                      ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

User Function CABV029(_cParam1)

	Local _aArea 		:= GetArea()
	Local _lRet			:= .T.	
	Local _cPln			:= ""
	Local _cMatric		:= ""
	Local _cMsg			:= GetNewPar("MV_XBLQTMP","Favor visualizar a situa��o deste benefici�rio com o setor de Cadastro.")
	
	Default _cParam1	:= "1" //1 - Interna��o (BE4) || 2 - Autoriza��o/Libera��o (BE1) 

	If _cParam1 == "1"
	
		_cMatric = M->BE4_USUARI
	
	Else
	
		_cMatric = M->BE1_USUARI
	
	EndIf


	//Valida��o para saber se o benefici�rio selecionado esta bloqueado.
	If !Empty(_cMatric)

		//Refor�o o ponteramento na tabela
		DbSelectArea("BA1")
		DbSetOrder(2)
		If DbSeek(xFilial("BA1") + _cMatric)

			If cEmpAnt == "01"

				_cPln = "509|563" 

			Else

				_cPln = "765|749"

			EndIf

			If !(Empty(BA1->BA1_DATBLO)) .AND. BA1->BA1_MOTBLO $ _cPln

				Aviso("Aten��o",_cMsg,{"OK"})

			EndIf

		EndIf

	EndIf

	RestArea(_aArea)

Return _lRet