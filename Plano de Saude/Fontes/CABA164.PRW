#INCLUDE "rwmake.ch"

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �NOVO2     � Autor � AP6 IDE            � Data �  22/09/16   ���
�������������������������������������������������������������������������͹��
���Descricao � Codigo gerado pelo AP6 IDE.                                ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP6 IDE                                                    ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/

User Function CABA164(cCompte)


//���������������������������������������������������������������������Ŀ
//� Declaracao de Variaveis                                             �
//�����������������������������������������������������������������������     



Local cVldAlt := ".F." // Validacao para permitir a alteracao. Pode-se utilizar ExecBlock.
Local cVldExc := ".F." // Validacao para permitir a exclusao. Pode-se utilizar ExecBlock.

Private cString := "PDM"
Private cFiltro  := ' '
 
dbSelectArea("PDM")                                                                                

dbSetOrder(1)

//cFiltro:=cCompte   
  

//Set Filter to PDM->PDM_COMPTE == cFiltro

AxCadastro(cString,"Cadastro da Lan�amentos de Debitos e Creditos do IW ",cVldExc,cVldAlt)




Return



dbSelectArea("PDJ")                                                                                

dbSetOrder(1)
  
cFiltro:=cCompte   


//Para Filtrar por umA COMPTENCIA 

Set Filter to PDJ->PDJ_COMPTE =cFiltro
