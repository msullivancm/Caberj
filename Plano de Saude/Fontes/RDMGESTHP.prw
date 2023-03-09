#Include "rwmake.ch"     
#Include "Protheus.ch"
 


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �RDMGESTHP �Motta  �Caberj              � Data �  12/10/10   ���
�������������������������������������������������������������������������͹��
���Desc.     � Chamada da tela de Gestor Hospitalar x RDA (PAC)           ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                         ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/


User Function RDMGESTHP()

Private cString := "PAC"

dbSelectArea("PAC")
dbSetOrder(1)

AxCadastro(cString,"Gestores Hospitalares X RDA.",".T.",".T.")

Return Nil      


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �ValGHP    �Motta  �Caberj              � Data �  12/10/10   ���
�������������������������������������������������������������������������͹��
���Desc.     �  Validador de Gestor Hospitalar x Hospital                 ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/


User Function ValGHP(cRDA,cTipo)

Local lRet := .T.  

dbselectarea("BAU")  
dbsetorder(1)
dbseek(xFilial("BAU")+trim(cRDA))       

If !Found()  // 31/08/07 - Noronha
	msgBox("Codigo de RDA nao Cadastrado.","Sem Cadastro:","INFO")
    lRet := .F. 
Else
  If cTipo = "G" //Gestor
    If BAU->BAU_YINDGH != "S" 
      msgBox("Codigo de RDA nao e de um Gestor Hospitalar.","Cadastro:","INFO")
      lRet := .F.
    Endif
  Elseif cTipo = "H" //Hospital
    If BAU->BAU_TIPPRE != "HOS" 
      msgBox("Codigo de RDA nao e de um Hospital.","Cadastro:","INFO")
      lRet := .F.
    Endif
  Endif         
Endif          

Return lRet
