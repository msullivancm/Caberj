#INCLUDE "rwmake.ch"

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �CDMURAL � Autor � Raquel Casemiro       � Data �  11/09/06   ���
�������������������������������������������������������������������������͹��
���Descricao � AxCadastro para Ocorrencias do Prestador x ���
�������������������������������������������������������������������������͹��
���Uso       � CABERJ                                                     ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/

User Function OCORRENCIAS


Private cString := "ZZ7"

dbSelectArea("ZZ7")
dbSetOrder(1)

AxCadastro(cString,"Ocorrencias Prestador")

Return