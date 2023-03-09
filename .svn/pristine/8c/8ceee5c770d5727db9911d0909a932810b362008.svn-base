#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'RWMAKE.CH'
#INCLUDE "TOPCONN.CH"
#INCLUDE "TBICONN.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ CABV039  ºAutor  ³Angelo Henrique     º Data ³  02/01/2018 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Validação criada para não permitir que nos campos de celular ±±
±±º          ³seja permitido preencher caracteres, somente numeros.       º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³CABERJ                                                      º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function CABV039(_cParam)
	
	Local _aArea	:= GetArea()
	Local _lRet		:= .T.
	Local _ni		:= 0
	
	Default _cParam := ""
	
	For _ni:= 1 to Len(AllTrim(_cParam))
		
		If !(SubStr(_cParam,_ni,1) $ "0123456789")
		
			Aviso("Atenção", "Campo de Celular ou Telefone so pode conter números e sem espaços.", {"OK"})
			
			_lRet := .F.
			
			Exit
		
		EndIf
		
	Next _ni
	
	RestArea(_aArea)
	
Return _lRet



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ CABV039  ºAutor  ³Angelo Henrique     º Data ³  02/01/2018 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Validação criada para não permitir que nos campo de DDD      ±±
±±º          ³não permitindo o preenchimento de caracteres.               º±±
±±º          ³Validar também se o DDD existe na base.                     º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³CABERJ                                                      º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
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
		
			Aviso("Atenção", "Campo de DDD so pode conter números e sem espaços.", {"OK"})
			
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
						
			Aviso("Atenção", "Não foi encontrado este DDD cadastrado..", {"OK"})
			
			_lRet := .F.
			
		EndIf
		
		(_cAlias)->(DbCloseArea())
	
	EndIf
		
	RestArea(_aArea)
	
Return _lRet