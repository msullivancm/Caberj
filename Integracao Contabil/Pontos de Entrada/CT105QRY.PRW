#include 'protheus.ch'
/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �CT105QRY �Autor  �Roger Cangianeli     � Data �  05/12/07   ���
�������������������������������������������������������������������������͹��
���Desc.     � Ponto de entrada para inclus�o de campos espec�ficos quando���
���          � contabiliza de forma aglutinada, gravando de CTK para CT2. ���
�������������������������������������������������������������������������͹��
���Uso       � Espec�fico M�dulo PLS									  ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
USER FUNCTION CT105QRY()
Local cQuery := ParamIxb[1]
Local lAglut := ParamIxb[2]
// Se n�o aglutina os campos espec�ficos ser�o gravados do CTK para o CT2, n�o modificar a query.
If lAglut
	If At(' FROM '+RetSqlName('CTK'), cQuery) > 0 .AND. At(' ORDER BY ', cQuery) > 0
		cQuery	:= Stuff( cQuery, At(' FROM '+RetSqlName('CTK'), cQuery), 0, ', CTK_YREVER')
		cQuery	:= Stuff( cQuery, At(' ORDER BY ', cQuery), 0, ', CTK_YREVER')
	EndIf
EndIf
//cQuery	:= ChangeQuery(cQuery)

Return(cQuery)