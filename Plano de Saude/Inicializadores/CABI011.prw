#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'PARMTYPE.CH'

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �CABI005     �Autor  �Angelo Henrique   � Data �  16/03/17   ���
�������������������������������������������������������������������������͹��
���Desc.     �Inicializador padr�o criado para mostrar o status da ANS.   ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � CABERJ                                                     ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
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