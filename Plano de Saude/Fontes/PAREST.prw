#INCLUDE "rwmake.ch"

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �RDMPAS	� Autor � Raquel        � Data �  09/09/11        ���
�������������������������������������������������������������������������͹��
���Descricao � AxCadastro para cadastro de Paramentros p/ os relatorios   ���
���de estudo do custo ambulatorial                                        ���
���Uso       � CABERJ                                                     ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/                                                                             

User Function PAREST
Local cVldInc := ".T." // Validacao para permitir a Inclusao/Alteracao. Pode-se utilizar ExecBlock.

Private cString := "PAX"

dbSelectArea("PAX")
dbSetOrder(1)

AxCadastro(cString,"Parametros de estudo do Custo Ambulatorial.",,cVldInc) //Codeblock - Avaliacao de exclusao 

Return 
/*