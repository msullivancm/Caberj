#INCLUDE "rwmake.ch"

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �HISTAED   � Autor � Jean Schulz        � Data �  07/11/06   ���
�������������������������������������������������������������������������͹��
���Descricao � AxCadastro para bloqueio e desbloqueio de opcional partici-���
���          � pacao do profissional de saude ao programa AED.            ���
�������������������������������������������������������������������������͹��
���Uso       � CABERJ                                                     ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/

User Function HISTAED  

Local cVldAlt := ".f." // Validacao para permitir a alteracao. Pode-se utilizar ExecBlock.
Local cVldExc := ".T." // Validacao para permitir a exclusao. Pode-se utilizar ExecBlock.

Private cString := "ZZF"

dbSelectArea("ZZF")
dbSetOrder(1)

AxCadastro(cString,"Hist�rico de participacao Prof. Saude no AED.",cVldAlt,cVldExc)

Return
