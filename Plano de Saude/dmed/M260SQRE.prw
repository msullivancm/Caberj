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
User Function M260SQRE( )
					
Local cSelect	:= paramixb[1] 
Local cFrom  	:= paramixb[2]  
Local cWhere	:= paramixb[3] 
     
    
     cWhere     += " AND NOT EXISTS  (SELECT NULL "
     cWhere     += " FROM B45010  B45  WHERE B45.B45_FILIAL ||B45.B45_OPEMOV||B45.B45_ANOAUT||B45.B45_MESAUT|| B45.B45_NUMAUT = "
     cWhere     += " B44.B44_FILIAL ||B44.B44_OPEMOV||B44.B44_ANOAUT||B44.B44_MESAUT|| B44.B44_NUMAUT                            "
     cWhere     += " AND D_E_L_E_T_<>'*' AND B45_CODPRO IN ('83000011','83000020','82000050', '03000206','82000204' ,'50020021','80940030','90990013'))"


Return (cSelect+cFrom+cWhere)       


