#INCLUDE "rwmake.ch"
/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  � CABASZA  � Autor � Jose Carlos Noronha� Data �  02/08/07   ���
�������������������������������������������������������������������������͹��
���Descricao � Cadastro de Aprovadores para Liberar/Bloqeuar Titulos PLS  ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � Caberj                                                     ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/
User Function CABASZA

//���������������������������������������������������������������������Ŀ
//� Declaracao de Variaveis                                             �
//�����������������������������������������������������������������������

Local cVldAlt := ".T." // Validacao para permitir a alteracao. Pode-se utilizar ExecBlock.
Local cVldExc := ".T." // Validacao para permitir a exclusao. Pode-se utilizar ExecBlock.

Private cString := "SZA"

dbSelectArea("SZA")

dbSetOrder(1)

AxCadastro(cString,"Cadastro de Aprovadores Para Liberar/Bloquear Titulos do PLS",cVldAlt,cVldExc)

Return

//���������������������������������������������������������������������Ŀ
//� Validacao para nao incluir usuario ja cadastrado                    �
//�����������������������������������������������������������������������
User Function CABVSZA

Local c_CodUsu := M->ZA_COD

PswOrder(1)
PswSeek(c_CodUsu,.T.)
aUser := PswRet(1)
If Len(aUser) <> 0
	If aUser[1,4] <> ""
		dbselectarea("SZA")
		dbsetorder(1)
		dbseek(xFilial("SZA")+c_CodUsu)
		If Found()
		   Alert("Usu�rio J� Cadastrado !")
		   Return(.F.)
		Endif	
   Endif
Else
   Return(.F.)
EndIf

Return(.T.)                                                  


