#INCLUDE "rwmake.ch"

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �CADPROCL  � Autor � Jean Schulz        � Data �  25/10/06   ���
�������������������������������������������������������������������������͹��
���Descricao � AxCadastro para amarracao de produtos X Classes.           ���
�������������������������������������������������������������������������͹��
���Uso       � CABERJ                                                     ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/

User Function CADPROCL

Local cVldAlt := ".T." // Validacao para permitir a alteracao. Pode-se utilizar ExecBlock.
Local cVldExc := ".T." // Validacao para permitir a exclusao. Pode-se utilizar ExecBlock.

Private cString := "ZZC"

dbSelectArea("ZZC")
dbSetOrder(1)

AxCadastro(cString,"Cadastro de Produtos X Classes de Produtos.",cVldAlt,cVldExc)

Return