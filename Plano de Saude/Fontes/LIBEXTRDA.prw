#INCLUDE "rwmake.ch"

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  LIBEXTRDA   � Autor � Raquel            � Data �  20/08/12   ���
�������������������������������������������������������������������������͹��
���Descricao � Cadastro de Data de Libera��o do Extrato RDA na Internet   ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/

User Function LIBEXTRDA


//���������������������������������������������������������������������Ŀ
//� Declaracao de Variaveis                                             �
//�����������������������������������������������������������������������

Local cVldAlt := ".T." // Validacao para permitir a alteracao. Pode-se utilizar ExecBlock.
Local cVldExc := ".F." // Validacao para permitir a exclusao. Pode-se utilizar ExecBlock.

Private cString := "PBE"

dbSelectArea("PBE")
dbSetOrder(1)

AxCadastro(cString,"Cadastro de Data de Libera��o do Extrato da RDA na Internet",cVldExc,cVldAlt)

Return