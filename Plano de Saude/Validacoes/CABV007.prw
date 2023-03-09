#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'TOPCONN.CH'

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABV007   ºAutor  ³Leonardo Portella   º Data ³  07/11/11   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Validacao do numero impresso, verificando se existe alguma  º±±
±±º          ³guia na BD5 com o mesmo numero impresso para o RDA, com ou  º±±
±±º          ³sem zeros a esquerda. Utilizado no campo BD5_NUMIMP e pode  º±±
±±º          ³ser utilizado em mais pontos colocando a variavel lAviso    º±±
±±º          ³com .F. para nao exibir a mensagem.                         º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³CABERJ                                                      º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function CABV007(cNumImpr, cRDA, lAviso, nRecno)

Local cQry 		:= ""
Local cAlias 	:= GetNextAlias()
Local lOk		:= .T.

Default lAviso 	:= .T.
Default nRecno 	:= 0                   

If !( BD5->BD5_CODLDP $ '0013|0017' )

	cQry += "SELECT BD5_CODRDA, BD5_NUMIMP, BD5_CODPEG"	  						 						+ CRLF
	cQry += "FROM " + RetSqlName('BD5')				 													+ CRLF
	cQry += "WHERE D_E_L_E_T_ = ' '"  																	+ CRLF
	cQry += "    AND BD5_FILIAL = '" + xFilial('BD5') + "'"  											+ CRLF
	cQry += "    AND BD5_CODOPE = '" + PLSINTPAD() + "'"  												+ CRLF
	cQry += "    AND BD5_CODRDA = '" + cRDA + "'" 														+ CRLF
	cQry += "    AND BD5_SITUAC = '1'"			 														+ CRLF    
	cQry += "    AND BD5_CODLDP NOT IN ( '0013','0017' )"												+ CRLF
	//Bianchini - 27/03/2019 - Tratamento Performance P12
	//cQry += "    AND REMOVE_ZEROS_ESQ(TRIM(BD5_NUMIMP)) = REMOVE_ZEROS_ESQ(TRIM('" + cNumImpr + "'))" 	+ CRLF
	cQry += "    AND LTRIM(BD5_NUMIMP,'0') = LTRIM('" + cNumImpr + "','0')" 	+ CRLF
	cQry += "    AND ROWNUM = 1"				 														+ CRLF
	
	//Leonardo Portella - 07/03/17 - Não deve levar em conta a guia origem do estorno nesta crítica - 1=Sim;0=Nao  
	cQry += "    AND BD5_ESTORI <> '1'"																	+ CRLF
	
	//Leonardo Portella - 07/03/17 - Desconsiderar a própria guia quando esta não vier da digitação CM
	cQry += "    AND R_E_C_N_O_ <> " + cValToChar(nRecno)												+ CRLF
	
	TcQuery cQry New Alias cAlias
	
	lOk	:= cAlias->(EOF())
	
	If !lOk .and. lAviso 
		cMsg := 'Já existe uma guia com este número impresso!'	 	+ CRLF 
		cMsg += ' - PEG: ' + AllTrim(cAlias->BD5_CODPEG) 			+ CRLF 
		cMsg += ' - Num. Impr.: ' + AllTrim(cAlias->BD5_NUMIMP)		+ CRLF
		cMsg += ' - RDA: ' + AllTrim(cAlias->BD5_CODRDA)			+ CRLF
	
		Aviso('ATENÇÃO',cMsg,{'Ok'})
	EndIf
	
	cAlias->(DbCloseArea())

EndIf
	
Return lOk