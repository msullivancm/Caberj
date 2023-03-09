#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'PARMTYPE.CH'

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABI005     ºAutor  ³Angelo Henrique   º Data ³  16/03/17   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Inicializador padrão criado para mostrar o status da ANS.   º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CABERJ                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function CABI011(cCampo)
	
	
		Local _aArea 	:= GetArea()
	Local _aArZZQ 	:= ZZQ->(GetArea())
	Local _cRet     := ""
	Default cCampo := ""
	
	
	if !empty(ZZQ->ZZQ_DBANCA)
		if cCampo == 'ZZQ_XBANCO'
			_cRet := IIF(INCLUI,'',POSICIONE("PCT",1,XFILIAL("PCT")+ZZQ->(ZZQ_DBANCA+ZZQ_CODCLI),"PCT_BANCO")) 
		elseif cCampo == 'ZZQ_XAGENC'
			_cRet := IIF(INCLUI,'',POSICIONE("PCT",1,XFILIAL("PCT")+ZZQ->(ZZQ_DBANCA+ZZQ_CODCLI),"PCT_NUMAGE"))
		elseif cCampo == 'ZZQ_XCONTA'
			_cRet := IIF(INCLUI,'',POSICIONE("PCT",1,XFILIAL("PCT")+ZZQ->(ZZQ_DBANCA+ZZQ_CODCLI),"PCT_NCONTA"))
		elseif cCampo == 'ZZQ_XDGCON' 
			_cRet := IIF(INCLUI,'',POSICIONE("PCT",1,XFILIAL("PCT")+ZZQ->(ZZQ_DBANCA+ZZQ_CODCLI),"PCT_DVCONT"))
		endif 
		                   
	
	else 
	
	if cCampo == 'ZZQ_XBANCO'
			_cRet := IIF(INCLUI,'',POSICIONE("SA1",1,XFILIAL("SA1")+ZZQ->(ZZQ_CODCLI+ZZQ_LOJCLI),"A1_XBANCO")) 
		elseif cCampo == 'ZZQ_XAGENC'
			_cRet := IIF(INCLUI,'',POSICIONE("SA1",1,XFILIAL("SA1")+ZZQ->(ZZQ_CODCLI+ZZQ_LOJCLI),"A1_XAGENC"))
		elseif cCampo == 'ZZQ_XCONTA'
			_cRet := IIF(INCLUI,'',POSICIONE("SA1",1,XFILIAL("SA1")+ZZQ->(ZZQ_CODCLI+ZZQ_LOJCLI),"A1_XCONTA"))
		elseif cCampo == 'ZZQ_XDGCON' 
			_cRet := IIF(INCLUI,'',POSICIONE("SA1",1,XFILIAL("SA1")+ZZQ->(ZZQ_CODCLI+ZZQ_LOJCLI),"A1_XDGCON "))
		endif 
	
	EndIf
	
	
	RestArea(_aArZZQ)
	RestArea(_aArea)
	
Return _cRet