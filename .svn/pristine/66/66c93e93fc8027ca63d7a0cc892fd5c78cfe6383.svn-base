#INCLUDE 'PROTHEUS.CH'

#DEFINE c_ent CHR(13) + CHR(10)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABV025   ºAutor  ³Angelo Henrique     º Data ³  08/09/16   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Rotina utilizada para validar no momento do bloqueio do    º±±
±±º          ³usuário ou da família para não deixar inserir data de       º±±
±±º          ³bloqueio menor que a data de inclusão do beneficiário e     º±±
±±º          ³e avisar ao usuário caso o e inclusão do beneficiário e     º±±
±±º          ³bloqueio menor que a data de inclusão do beneficiário e     º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CABERJ                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function CABV025(_cParam)
	
	Local _aArea 		:= GetArea()
	Local _aArBCA		:= BCA->(GetArea())
	Local _lRet		:= .T.
	Local _cMsg		:= ""
	
	Default _cParam	:= ""
	
	//---------------------------------------
	//_cParam = 1 BCA - Bloqueio de Usuário
	//---------------------------------------
	//_cParam = 2 BC3 - Bloqueio de Família
	//---------------------------------------
	
	If _cParam == "1"
		
		If M->BCA_DATA - dDatabase > 30
			
			_cMsg := "DATA DE BLOQUEIO SUPERIOR A 30 DIAS" + c_ent
			_cMsg += "DATA DIGITADA: " + DTOC(M->BCA_DATA) + c_ent
			_cMsg += "ESTA CORRETO A DATA INFORMADA?" + c_ent
			
			AVISO("Atencao", _cMsg,{"OK"})
			
		EndIf
		
	ElseIf _cParam == "2"
		
		If M->BC3_DATA - dDatabase > 30
			
			_cMsg := "DATA DE BLOQUEIO SUPERIOR A 30 DIAS" + c_ent
			_cMsg += "DATA DIGITADA: " + DTOC(M->BC3_DATA) + c_ent
			_cMsg += "ESTA CORRETO A DATA INFORMADA?" + c_ent
			
			AVISO("Atencao", _cMsg,{"OK"})
			
		EndIf		
		
	EndIf
	
	RestArea(_aArBCA)
	RestArea(_aArea)
	
Return _lRet
