#INCLUDE "TOTVS.CH"
#include 'parmtype.ch'

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �MT120BRW    �Autor  �Angelo Henrique   � Data �  20/03/17   ���
�������������������������������������������������������������������������͹��
���Desc.     �Ponto de entrada utilizado para acrescentar bot�es no pedido���
���          �de compras                                                  ���
�������������������������������������������������������������������������͹��
���Uso       � CABERJ                                                     ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

User function MT120BRW()

Local _aArea := GetArea()

AAdd( aRotina, { 'REL.EMP/FAT', 'U_RELFAT()', 0, 4 } )

RestArea(_aArea)

Return


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �RELFAT      �Autor  �Angelo Henrique   � Data �  20/03/17   ���
�������������������������������������������������������������������������͹��
���Desc.     �Relat�rio para listar os pedidos empenhados e faturados     ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � CABERJ                                                     ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

User Function RELFAT()

Local _aArea 	:= GetArea()
Local _aArC7 	:= SC7->(GetArea())

Private cParams	:= ""                                                 

Private cParIpr	:="1;0;1;Autoriza��o de Material"

cParams := SUBSTR(cEmpAnt,2,1) + ";" + SC7->C7_XAUTOP + ";" + SC7->C7_NUM
If Alltrim(SC7->C7_XREGATD)=='1'
	CallCrys("AUTFATA",cParams,cParIpr)
ElseIf Alltrim(SC7->C7_XREGATD)=='2'
	CallCrys("AUTFAT",cParams,cParIpr)
Else  
	Aviso("Aten��o","Por favor verificar o regime de atendimento da senha",{"OK"})
EndIf

RestArea(_aArC7)
RestArea(_aArea)

Return
