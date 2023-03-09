#include "PROTHEUS.CH"
#include "PLSMGER.CH"
/*
������������������������������������������������������������������������������
������������������������������������������������������������������������������
��������������������������������������������������������������������������Ŀ��
���Funcao    �M260SQRE � Autor � Altamiro Affonso       � Data � 09.01.13  ���
��������������������������������������������������������������������������Ĵ��
���Descricao � Ponto de entrada para tratar :                              ��� 
���Descricao � a - Reembolso que n�o caracterizam custo m�dico;     	   ���
���Descricao � b - cr�dito concedido ao assistido como aux�lio funeral.	   ���    
��������������������������������������������������������������������������Ĵ��
��� Uso      � Advanced Protheus                                           ���
���������������������������������������������������������������������������ٱ�
������������������������������������������������������������������������������
*/
//��������������������������������������������������������������������������Ŀ
//� Define nome da funcao                                                    �
//����������������������������������������������������������������������������
User Function PM260CLA( )      
local crec_:= val(PARAMIXB[1])
B5A->(DbGoTo(crec_))
 //alert ("M260GRV") 

 cNomusr := ConsNome(b5a->b5a_nomusr)

if b5a->b5a_nomusr != cNomusr 

   b5a->(reclock("B5A",.F.))
   B5A->b5a_nomusr := cNomusr 
   b5a->(msunlock())

 EndIf    
 Return() 


/////limpa caracteres especias dos nomes (titular , dependente , executantes)
/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �PLSM260   �Autor  �altamiro	         � Data �  31/05/11   ���
�������������������������������������������������������������������������͹��
���Desc.     �remove carracteres invalidos do nomes                       ���
���          |                                                            ���
�������������������������������������������������������������������������͹��
���Uso       �dmed                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static FUNCTION ConsNome(cReeNom)
PRIVATE lverde := .T.
PRIVATE nnumro := 0
PRIVATE x  := 1   
//private num := "0123456789ABXCDEFGHIJLMNOPQRSTUVXZabcdefghiflmnopqrstuvxz*"
x:= 1  
a:=''  
while x <= len(cReeNom)    
        if (substr(cReeNom ,x , 1)) $ ".|-|_|/|'|=|:"  
            a+=' '
        elseif (substr(cReeNom ,x , 1)) $ "0"  
            a+='O'
        else 
            a+= substr(cReeNom ,x , 1) 
        endIf    
     x++
enddo
Return(a) 
