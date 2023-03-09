#include "RWMAKE.CH"
#include "PLSMGER.CH"
#include "COLORS.CH"
#include "TOPCONN.CH"

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
��� Programa � PLSKEY01A � Autor � Frederico O. C. Jr � Data � 09/09/22   ���
�������������������������������������������������������������������������͹��
���Desc.     �  apresentar situa��es adversas e se maior de 80 anos	      ���
���          � 									                          ���
�������������������������������������������������������������������������͹��
���Uso       � Protheus                                                   ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function PLSKEY01A

Local aArea			:= GetArea()
Local cRet			:= ""			// retorno esperado � um array (estou retornando texto para na valida��o do retorno [ValType(aAtalhos) == "A"] ser falso e n�o fazer nada)
Local nIdade		:= 0

U_VeSitAdv(BOW->BOW_USUARI)

BA1->(DbSetOrder(2))
if BA1->(DbSeek(xFilial("BA1") + BOW->BOW_USUARI))

	nIdade	:= Calc_Idade(dDatabase, BA1->BA1_DATNAS)

	if nIdade >= 80

		MsgInfo("O(a) benefici�rio(a) deste protocolo de reembolso possui " + AllTrim(str(nIdade)) + " anos.", "ATEN��O - Regra de Coparticipa��o")

	endif

endif

restArea(aArea)

return cRet
