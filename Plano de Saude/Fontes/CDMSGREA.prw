#INCLUDE "rwmake.ch"

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  |CDMSGREA	� Autor � Paulo Motta        � Data �  06/09/06   ���
�������������������������������������������������������������������������͹��
���Descricao � AxCadastro para lan�amentos de mensagens de reajuste  	  ���
�������������������������������������������������������������������������͹��
���Uso       � CABERJ                                                     ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/

User Function CDMSGREA

Private cString := "SZI"

dbSelectArea("SZI")
dbSetOrder(1)

AxCadastro(cString,"Mensagem de Reajuste.",".T.",".T.")

Return 