#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'PARMTYPE.CH'

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  � CABG006  �Autor  �Angelo Henrique     � Data �  23/12/2016 ���
�������������������������������������������������������������������������͹��
���Desc.     �Gatilho   utilizado no M�DULO DE ATIVO, para preencher      ���
���          �o campo de custo.                                           ���
�������������������������������������������������������������������������͹��
���Uso       �CABERJ                                                      ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

User Function CABG006()

	Local _aArea 		:= GetArea()
	Local _aArSN3 		:= SN3->(GetArea())
	Local _cRet			:= ""	
	Local _nPosDsp		:= Ascan(aHeader,{|x| x[2] = "N3_CCDESP"}) //DOMINIO
	Local _nPosCst		:= Ascan(aHeader,{|x| x[2] = "N3_CCUSTO"}) //CONTRA-DOMINIO	

	aCols[n][_nPosCst] 	:= aCols[n][_nPosDsp]
	
	_cRet := aCols[n][_nPosDsp]

	GetDRefresh()

	RestArea(_aArSN3)	
	RestArea(_aArea)	

Return _cRet