#INCLUDE "rwmake.ch"

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �CDPROAUDIMED� Autor � Jean Schulz      � Data �  18/09/06   ���
�������������������������������������������������������������������������͹��
���Descricao � AxCadastro para deXpara de produtos x ad. pagto RDA.       ���
�������������������������������������������������������������������������͹��
���Uso       � CABERJ                                                     ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/

User Function CDPROADIRDA
Local cVldInc := ".T." // Validacao para permitir a Inclusao/Alteracao. 
Local cVldExc := ".T."

Private cString := "ZZ8"

dbSelectArea("ZZ8") 
dbSetOrder(1)

AxCadastro(cString,"Produto Sa�de X Adicional",cVldExc,cVldInc) 

Return
