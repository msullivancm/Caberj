#INCLUDE "rwmake.ch"

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �CDCLAPRO  � Autor � Jean Schulz        � Data �  25/10/06   ���
�������������������������������������������������������������������������͹��
���Descricao � AxCadastro para cadastro de Classes de produtos.           ���
�������������������������������������������������������������������������͹��
���Uso       � CABERJ                                                     ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/

User Function CDCLAPRO 

Local cVldAlt := ".T." // Validacao para permitir a alteracao. Pode-se utilizar ExecBlock.
Local cVldExc := ".T." // Validacao para permitir a exclusao. Pode-se utilizar ExecBlock.

Private cString := "ZZB"

dbSelectArea("ZZB")
dbSetOrder(1)

AxCadastro(cString,"Cadastro de Classes de Produtos.",cVldAlt,cVldExc)

Return