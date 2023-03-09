#INCLUDE "RWMAKE.CH"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "TOPCONN.CH"
#INCLUDE "FONT.CH"
#INCLUDE "TBICONN.CH"

#DEFINE c_ent CHR(13) + CHR(10)
/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �CABV054   �Autor  �Angelo Henrique     � Data �  12/12/18   ���
�������������������������������������������������������������������������͹��
���Desc.     � Rotina utilizada para validar informa��es na tela de       ���
���          � Analista x RDA.                                            ���
�������������������������������������������������������������������������͹��
���Uso       � CABERJ                                                     ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
*/

User Function CABV054()
	
	Local _aArea 	:= GetArea()
	Local _cQuery	:= ""
	Local cAlias1 	:= GetNextAlias()
	Local _lRet		:= .T.
	
	If !(Empty(M->ZN_CODRDA))
		
		_cQuery := " SELECT                                         " + c_ent
		_cQuery += "  	BAUC.BAU_CODIGO                             " + c_ent
		_cQuery += " FROM 											" + c_ent
		_cQuery += "  	BAU010 BAUC                                 " + c_ent
		_cQuery += " WHERE                                          " + c_ent
		_cQuery += " 	BAUC.BAU_FILIAL = '" + xFilial("BAU") + "'  " + c_ent
		_cQuery += " 	AND BAUC.BAU_CODIGO = '" + M->ZN_CODRDA + "'" + c_ent
		_cQuery += " 	AND BAUC.D_E_L_E_T_ = ' '					" + c_ent
		_cQuery += "                                                " + c_ent
		_cQuery += " UNION ALL                                      " + c_ent
		_cQuery += "                                                " + c_ent
		_cQuery += " SELECT                                         " + c_ent
		_cQuery += "  	BAUI.BAU_CODIGO                             " + c_ent
		_cQuery += " FROM                                           " + c_ent
		_cQuery += "  	BAU020 BAUI                                 " + c_ent
		_cQuery += " WHERE                                          " + c_ent
		_cQuery += "  	BAUI.BAU_FILIAL = '" + xFilial("BAU") + "'  " + c_ent
		_cQuery += "  	AND BAUI.BAU_CODIGO = '" + M->ZN_CODRDA + "'" + c_ent
		_cQuery += " 	AND BAUI.D_E_L_E_T_ = ' '                   " + c_ent
		
		If Select(cAlias1) > 0
			(cAlias1)->(DbCloseArea())
		Endif
		
		DbUseArea(.T.,"TOPCONN", TCGENQRY(,,_cQuery),cAlias1, .F., .T.)
		
		(cAlias1)->(DbGoTop())
		
		If (cAlias1)->(Eof())
			
			_lRet		:= .F.
			
			Aviso("Aten��o","N�o foi encontrado RDA cadastrado na base",{"OK"})
						
		EndIf
		
	EndIf
	
	RestArea(_aArea)
	
Return _lRet

