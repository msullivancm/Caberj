#INCLUDE "rwmake.ch"
/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa    CDFXETPR � Autor � Mauricio           � Data �  29/06/07   ���
�������������������������������������������������������������������������͹��
���Descricao � AxCadastro                                                 ���
�������������������������������������������������������������������������͹��
���Uso       � CABERJ                                                     ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/
User Function CDFXETPR()
Local cVldInc := ".T." // Validacao para permitir a Inclusao/Alteracao. Pode-se utilizar ExecBlock.
Local cVldExc := ".T." // Validacao para permitir a exclusao.
Private cString := "ZZU"

dbSelectArea("ZZU")
dbSetOrder(1)

AxCadastro(cString,"Cadastro de Faixa Etaria Proposta.",cVldExc,cVldInc)

Return
