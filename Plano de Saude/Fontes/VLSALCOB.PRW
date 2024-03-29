#INCLUDE "rwmake.ch"
#Include 'PLSMGER.CH'
#Include 'COLORS.CH'
#Include 'TOPCONN.CH'


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �VLSALCOB  �Motta  �Microsiga           � Data �  09/21/07   ���
�������������������������������������������������������������������������͹��
���Desc.     �  Funcao que retorna o salario do colaborador (ligado ao    ���
���          �  parametro MV_PLCOMSA)                                     ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                         ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/            

User Function VLSALCOB()  

//���������������������������������������������������������������������Ŀ
//� Declaracao de Variaveis                                             �
//�����������������������������������������������������������������������

Local nValSalCob := 0;

//���������������������������������������������������������������������Ŀ
//� Se est� de f�rias/afastado obtem o valor da verba 101 para o salario         �
//�����������������������������������������������������������������������


If SRA->RA_SITFOLH == "F" // Ferias
  SRC->(DBSetOrder(1))
  If SRC->(MsSeek(xFilial("SRC")+SRA->RA_MAT+"101"))
    nValSalCob := SRC->RC_VALOR
  Else
    nValSalCob := SRA->RA_SALARIO
  Endif
Elseif SRA->RA_SITFOLH == "A" // Afastada
  SRC->(DBSetOrder(1))
  If SRC->(MsSeek(xFilial("SRC")+SRA->RA_MAT+"101"))
    nValSalCob := SRC->RC_VALOR
  Else
    nValSalCob := 0
  Endif
  //Verifica se existe Sal Maternidade
  If SRC->(MsSeek(xFilial("SRC")+SRA->RA_MAT+"108")) 
    nValSalCob := nValSalCob + SRC->RC_VALOR
  Endif      
Else
  nValSalCob := SRA->RA_SALARIO
Endif

Return nValSalCob
