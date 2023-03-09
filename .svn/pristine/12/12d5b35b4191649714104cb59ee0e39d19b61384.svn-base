#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'PARMTYPE.CH'

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ CABV035  ºAutor  ³Mateus Medeiros     º Data ³  04/10/2017 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Validação criada para não permitir ao usuario o não          ±±
±±º          ³preenchimento do campo E-mail no cadastro de Vidas.         º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³CABERJ                                                      º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

user function CABV035()

	Local _aArea 	:= GetArea()
	Local _aArBTS 	:= BTS->(GetArea())
	Local _lRet		:= .T.

	if Empty(ALLTRIM(M->BTS_EMAIL))
		_lRet := .F.
		IF ALLTRIM(M->BTS_EMAIL) # "E-MAIL OBRIGATORIO"
			Aviso("Atenção","O Preenchimento do campo e-mail é obrigatório.", {"OK"})
		ENDIF
	else
		if AT("@",M->BTS_EMAIL)==0
			_lRet := .F.
			IF ALLTRIM(M->BTS_EMAIL) # "E-MAIL OBRIGATORIO"
				Aviso("Atenção","E-mail informado não é válido.", {"OK"})
			ENDIF
		endif
	EndIf
//IIF( M->BTS_XSMAIL == "S",!Empty(M->BTS_EMAIL) .AND. AT("@",M->BTS_EMAIL)>0 ,Empty(M->BTS_EMAIL) .OR. AT("@",M->BTS_EMAIL)>0 )  
	RestArea(_aArBTS)
	RestArea(_aArea)

return _lRet