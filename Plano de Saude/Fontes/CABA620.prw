#INCLUDE "rwmake.ch"

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �CABA620   � Autor � Motta              � Data �  JUNHO/20   ���
�������������������������������������������������������������������������͹��
���Descricao � AXCADASTRO TABELA PDV CONTATOS EMPRESA VENDA (VENDEDORES)  ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP6 IDE                                                    ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/

User Function CABA620()

//���������������������������������������������������������������������Ŀ
//� Declaracao de Variaveis                                             �
//�����������������������������������������������������������������������  

Local cVldAlt := ".T." // Validacao para permitir a alteracao. Pode-se utilizar ExecBlock.
Local cVldExc := ".T." // Validacao para permitir a exclusao. Pode-se utilizar ExecBlock.

Private cString := "PDV"

dbSelectArea("PDV")                                                                                

dbSetOrder(1)

AxCadastro(cString,"Cadastro  Contatos Empresa Venda (Vendedores)",cVldExc,cVldAlt)

Return
