#INCLUDE "rwmake.ch"
/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �CADFXINTER� Autor � Leandro            � Data �  20/08/07   ���
�������������������������������������������������������������������������͹��
���Descricao �AxCadastro para cadastro das faixas de pgto dos Internistas ���
�������������������������������������������������������������������������͹��
���Uso       � CABERJ- Semelhante ao cadastro de remuneracao internistas  ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/
User Function CADFXINTER()
Local cVldInc := ".T." // Validacao para permitir a Inclusao/Alteracao. Pode-se utilizar ExecBlock.
Local cVldExc := ".T." // Validacao para permitir a exclusao.
Private cString := "ZZU"

dbSelectArea("ZZU")
dbSetOrder(1)

AxCadastro(cString,"Cadastro de faixas de remuracao dos internistas.",cVldExc,cVldInc)

Return
