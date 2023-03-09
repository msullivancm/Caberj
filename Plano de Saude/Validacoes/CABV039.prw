#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'RWMAKE.CH'
#INCLUDE "TOPCONN.CH"
#INCLUDE "TBICONN.CH"

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  � CABV039  �Autor  �Angelo Henrique     � Data �  02/01/2018 ���
�������������������������������������������������������������������������͹��
���Desc.     �Valida��o criada para n�o permitir que nos campos de celular ��
���          �seja permitido preencher caracteres, somente numeros.       ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       �CABERJ                                                      ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

User Function CABV039(_cParam)
	
	Local _aArea	:= GetArea()
	Local _lRet		:= .T.
	Local _ni		:= 0
	
	Default _cParam := ""
	
	For _ni:= 1 to Len(AllTrim(_cParam))
		
		If !(SubStr(_cParam,_ni,1) $ "0123456789")
		
			Aviso("Aten��o", "Campo de Celular ou Telefone so pode conter n�meros e sem espa�os.", {"OK"})
			
			_lRet := .F.
			
			Exit
		
		EndIf
		
	Next _ni
	
	RestArea(_aArea)
	
Return _lRet



/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  � CABV039  �Autor  �Angelo Henrique     � Data �  02/01/2018 ���
�������������������������������������������������������������������������͹��
���Desc.     �Valida��o criada para n�o permitir que nos campo de DDD      ��
���          �n�o permitindo o preenchimento de caracteres.               ���
���          �Validar tamb�m se o DDD existe na base.                     ���
�������������������������������������������������������������������������͹��
���Uso       �CABERJ                                                      ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

User Function CABV039A(_cParam)
	
	Local _aArea	:= GetArea()
	Local _lRet		:= .T.
	Local _ni		:= 0
	Local _cQuery	:= ""
	Local _cAlias	:= GetNextAlias()
	
	Default _cParam := ""
	
	For _ni:= 1 to Len(AllTrim(_cParam))
		
		If !(SubStr(_cParam,_ni,1) $ "0123456789")
		
			Aviso("Aten��o", "Campo de DDD so pode conter n�meros e sem espa�os.", {"OK"})
			
			_lRet := .F.
			
			Exit
		
		EndIf
		
	Next _ni
	
	//-----------------------------------------------------
	//Validar agora se o DDD existe na base
	//-----------------------------------------------------
	If !Empty(AllTrim(_cParam)) .And. _lRet
	
		_cQuery := " SELECT  											" + CRLF
		_cQuery += "	BID.BID_CODMUN,									" + CRLF
		_cQuery += "	BID.BID_DESCRI, 								" + CRLF
		_cQuery += "	BID.BID_EST, 									" + CRLF
		_cQuery += "	BID_YDDD     									" + CRLF		
		_cQuery += " FROM 												" + CRLF
		_cQuery += "	" + RetSqlName('BID') + " BID	  				" + CRLF
		_cQuery += " WHERE   											" + CRLF
		_cQuery += "	BID.D_E_L_E_T_ = ' '							" + CRLF
		_cQuery += "	AND BID.BID_FILIAL = '" + xFilial("BID") + "' 	" + CRLF
		_cQuery += "	AND BID.BID_YDDD = '" + _cParam + "' 			" + CRLF		
		
		TcQuery _cQuery New Alias (_cAlias)
		
		If (_cAlias)->(EOF())
						
			Aviso("Aten��o", "N�o foi encontrado este DDD cadastrado..", {"OK"})
			
			_lRet := .F.
			
		EndIf
		
		(_cAlias)->(DbCloseArea())
	
	EndIf
		
	RestArea(_aArea)
	
Return _lRet