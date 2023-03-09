#include 'TOTVS.CH'
#include 'TOPCONN.CH'

//Ponto de entrada na rotina de envio de dados ANS (Monitoramento) no momento em que vai gerar a tabela 
//de trabalho temporaria, antes de carregar a tela com as guias. Quando gera o XML nao passa mais por 
//este ponto de entrada. 
//Informa se deve ou nao considerar/enviar a guia no XML de Monitoramento a ser enviado para a ANS

//Leonardo Portella - 30/03/17 - Alterações diversas por conta de alteração do fonte padrão que chama esta rotina conforme abaixo:
//Alterou de: 
// - PLSXMLMON 
// - PLSATMON 
//Para:
// - PLSM270
// - PLSM270B4N
// - PLSM270B4O
// - PLSM270B4P
// - PLSM270B4U
// - PLSM270XTE
// - PLSM270XTQ
// - PLSM270XTR

Static cRatCapta := ''
 
User Function PLSTMON1

Local c_Alias 		:= ''
Local c_AlPadrao 	:= PARAMIXB[1]
Local nRecAlias		:= PARAMIXB[2]
Local cOpca			:= cValToChar(PARAMIXB[3])
Local cAliasMon		:= GetNextAlias()
Local cAliasBR8		:= GetNextAlias()
Local cAliasBC9		:= GetNextAlias()
Local cAlRet		:= GetNextAlias()
Local aArea			:= GetArea()
Local aAreaBAU		:= BAU->(GetArea())
Local aAreaBA1		:= BA1->(GetArea())
Local aAreaBTS		:= BTS->(GetArea())
Local aAreaBB8		:= BB8->(GetArea())
Local lConsGuia		:= .T.
Local cQry			:= ''
Local cQryBR8		:= ''
Local cMatric		:= ''
Local cMacro		:= ''

If nOpca $ '1|3' //BD5: 1 - Primeiro envio 3 - Demais envios
	c_Alias := 'BD5'
ElseIf nOpca $ '2|4' //BE4: 2 - Primeiro envio 4 - Demais envios
	c_Alias := 'BE4'
EndIf

&(c_Alias + '->(DbGoTo(' + cValToChar(nRecAlias) + '))')

If !( &(c_Alias + '->' + c_Alias + '_CODLDP') $ '0000,0001,0002,0010' )
	lConsGuia	:= .F.	
EndIf

/*
//Reenvio - somente guias criticadas
If lConsGuia

	cChvGuia := c_Alias + '->( ' + c_Alias + '_CODLDP + ' + c_Alias + '_CODPEG + ' + c_Alias + '_NUMERO )'
	cChvGuia := &cChvGuia
	
	cQryRet := "SELECT 1" 										+ CRLF 
	cQryRet += "FROM RETORNO_MONITORAMENTO RET" 				+ CRLF
	cQryRet += "WHERE NUMEROGUIAOPERADORA = '" + cChvGuia + "'" + CRLF
	
	TcQuery cQryRet New Alias cAlRet
	
	If cAlRet->(EOF())
		lConsGuia := .F.
	EndIf  
	
	cAlRet->(DbCloseArea())

EndIf
*/

If lConsGuia

	BAU->(DbSetOrder(1))
	
	If BAU->(DbSeek(xFilial('BAU') + &(c_Alias + '->' + c_Alias + '_CODRDA') ))
		
		Do Case
		
			//Repasse e RDA exclusivo para repasse Caberj/Integral (999997) que tb eh repasse nao eh para considerar
			Case ( BAU->BAU_CODOPE $ GetNewPar("MV_YOPAVLC","") ) .or. ;
				( ( cEmpAnt == '02' ) .and. ( BAU->BAU_CODIGO == '999997' ) )
				lConsGuia := .F.
			
			Case BAU->BAU_CODIGO $ '126004|106445'//Rateios da BEM
				lConsGuia := .F.
		
			Case BAU->BAU_CODIGO $ '126839'//RDA OPME - Farmacia
				lConsGuia := .F.
			
			//RDA Repasse Integral > Caberj Estaleiro
			Case ( ( cEmpAnt == '01' ) .and. ( BAU->BAU_CODIGO == '140880' ) )
				lConsGuia := .F.
				
			//PJ deve ter CNPJ com 14 dígitos
			Case ( Alltrim(BAU->BAU_TIPPE) == "J" ) .and. ( len(AllTrim(BAU->BAU_CPFCGC)) <> 14 )
				lConsGuia := .F.
				
			//PF deve ter CPF com 11 dígitos
			Case ( Alltrim(BAU->BAU_TIPPE) <> "J" ) .and. ( len(AllTrim(BAU->BAU_CPFCGC)) <> 11 )
				lConsGuia := .F.
			
			//CPF|CNPJ inválido
			Case !cgc(BAU->BAU_CPFCGC,,.F.)
				lConsGuia := .F.
			
		EndCase
		
	Else
		//Se por acaso nao achar o RDA na BAU, nao envia pois existem outras informacoes que dependem do RDA
		lConsGuia := .F.
	EndIf 
	
EndIf

If lConsGuia

	BB8->(DbSetOrder(1)) //BB8_FILIAL + BB8_CODIGO + BB8_CODINT + BB8_CODLOC + BB8_LOCAL
	
	cCodLoc := c_Alias + '->( ' + c_Alias + '_CODRDA + ' + c_Alias + '_OPERDA + ' + c_Alias + '_CODLOC + ' + c_Alias + '_LOCAL )'
	cCodLoc := &cCodLoc
	
	If BB8->( DbSeek(xFilial("BB8") + cCodLoc ) )
		
		If len(Alltrim(BB8->BB8_CNES)) <> 7 .or. ( Alltrim(BB8->BB8_CNES) $ '9999990' )
			lConsGuia := .F.
		EndIf
		 
	EndIf

EndIf

If lConsGuia

	cQry := "SELECT 1" 										+ CRLF
	cQry += "FROM " + RetSqlName('BC9') 					+ CRLF
	cQry += "WHERE BC9_FILIAL = '" + xFilial('BC9') + "'" 	+ CRLF 
	cQry += "  AND BC9_CODMUN = '" + BAU->BAU_MUN + "'" 	+ CRLF
	cQry += "  AND D_E_L_E_T_ = ' '" 						+ CRLF
  
	TcQuery cQry New Alias cAliasBC9
	
	If cAliasBC9->(EOF())
		lConsGuia := .F.
	EndIf
	
	cAliasBC9->(DbCloseArea())

EndIf

If lConsGuia

	cMacro 	:= c_Alias + '->(' + c_Alias + '_CODOPE + ' + c_Alias + '_CODEMP + ' + c_Alias + '_MATRIC + ' + c_Alias + '_TIPREG + ' + c_Alias + '_DIGITO)'
	cMatric := &cMacro
	cMatric := AllTrim(cMatric)
	
	If len(cMatric) <> 17
		lConsGuia := .F.
	Else
	
		BA1->(DbSetOrder(2)) //BA1_FILIAL + BA1_CODINT + BA1_CODEMP + BA1_MATRIC + BA1_TIPREG + BA1_DIGITO
		
		If !BA1->(MsSeek(xFilial("BA1") + cMatric)) 
			lConsGuia := .F.
		Else
		
			Do Case
					
				//BA1_CODCCO: Campo identificador do envio do SIB. Se o beneficiario nao foi informado para a ANS,  
				//nao posso enviar. O SIB eh feito da competencia anterior. Como o monitoramento ANS eh feito 
				//referente a 2 competencias anteriores, o SIB da competencia do monitoramento ja foi enviado e  
				//o retorno processado 
				Case empty(BA1->BA1_CODCCO)
			 		lConsGuia := .F.
			 	
			 	//Matriculas geradas na agenda 	
				Case !empty(BA1->BA1_XTPBEN)
					lConsGuia := .F.
				
				//Empresas de repasse na Caberj
				Case ( cEmpAnt == '01' ) .and. ( BA1->BA1_CODEMP $ '0004|0009' )
					lConsGuia := .F.
			
				Otherwise 
				
					BTS->(Dbsetorder(1))
					
					//Validacoes de integridade. Usuario e vida. Se nao respeitar as validacoes, gera 
					//erro no schema.
					If BTS->(MsSeek(xFilial("BTS") + AllTrim(BA1->BA1_MATVID)))
						If empty(BTS->BTS_DATNAS)
							lConsGuia := .F.
						EndIf
					Else
						lConsGuia := .F.
					EndIf
			
			End Case
			
		EndIf
		
	EndIf

EndIf

If lConsGuia

	If empty(cRatCapta)//So alimento a variavel estatica 1 vez
	
		//Solicitado pela Dra. Adriana conforme conversa com Dr. Jose Paulo.
		//Enviadas: Sexta-feira, 28 de novembro de 2014 16:38:51 - Assunto: Códigos Próprios Caberj
		//"Tratam-se de códigos de rateio e de benefícios especiais da Caberj que não iremos informar a ANS."
		cRatCapta := '81040016;81040024;81040032;81040059;81040067;81040075;81040091;81040113;'        
		cRatCapta += '81040148;81040199;82000239;82000247;83000020;83000046;83000062;83000097;'
		cRatCapta += '86000217;86000314;86000357;86000365;86000659;86000713;86000748;80010342;'        
		cRatCapta += '80250017;80541402;80403018;80101216'
		
		//Codigos de procedimento de rateios (captation)
		
		cQryBR8 := "SELECT DISTINCT BR8_CODPSA" 											+ CRLF
		cQryBR8 += "FROM " + RetSqlName('BR8') 												+ CRLF
		cQryBR8 += "WHERE BR8_FILIAL = '" + xFilial('BR8') + "'" 							+ CRLF
		cQryBR8 += "	AND BR8_YCAPIT = '1'" 												+ CRLF
		cQryBR8 += "	AND D_E_L_E_T_ = ' '" 												+ CRLF 
		
		TcQuery cQryBR8 New Alias cAliasBR8
		
		While !cAliasBR8->(EOF())
		
			If At(AllTrim(cAliasBR8->BR8_CODPSA),cRatCapta) <= 0
				cRatCapta += ';' + AllTrim(cAliasBR8->BR8_CODPSA)
			EndIf
			
			cAliasBR8->(DbSkip())
			
		EndDo
		
		cAliasBR8->(DbCloseArea())
		
	EndIf
	
	//====>>>>>>>Se a query abaixo trouxer dados, nao ira considerar a guia!<<<<<<<<========//
	
	//Se nao tiver de/para vai gerar com tabela que vai dar erro no schema (ex: tab 01)
	cQry := "SELECT 1" 																	+ CRLF
	cQry += "FROM " +  RetSqlName('BD6') + " BD6" 										+ CRLF 
	cQry += "WHERE BD6_FILIAL = '" + xFilial('BD6') + "'" 								+ CRLF
	cQry += "	AND BD6_CODOPE = '" + &(c_Alias+'->'+c_Alias+'_CODOPE') + "'" 			+ CRLF
	cQry += "	AND BD6_CODLDP = '" + &(c_Alias+'->'+c_Alias+'_CODLDP') + "'" 			+ CRLF
	cQry += "	AND BD6_CODPEG = '" + &(c_Alias+'->'+c_Alias+'_CODPEG') + "'" 			+ CRLF
	cQry += "	AND BD6_NUMERO = '" + &(c_Alias+'->'+c_Alias+'_NUMERO') + "'"			+ CRLF
	cQry += "	AND BD6.D_E_L_E_T_ = ' '" 												+ CRLF
	cQry += "	AND ROWNUM = 1" 														+ CRLF
	cQry += "	AND " 																	+ CRLF
	cQry += "	( BD6_CODPRO IN " + FormatIn(cRatCapta,';') + " OR "					+ CRLF
	
	//Excluir procedimentos odontologicos na Caberj
	If cEmpAnt == '01'
		cQry += "		SUBSTR(BD6_CODPRO,1,2) = '99' OR "	 							+ CRLF 
	EndIf
	
	cQry += "	 	NOT EXISTS " 														+ CRLF
	cQry += "	 	(" 																	+ CRLF
	cQry += "	 		SELECT 2" 														+ CRLF
	cQry += "	 		FROM " +  RetSqlName('BTU') + " BTU" 							+ CRLF 
	cQry += "	 		WHERE BTU_FILIAL = '" + xFilial('BTU') + "'" 					+ CRLF
	cQry += "    			AND BTU_ALIAS = 'BR8'" 										+ CRLF
	cQry += "   			AND BTU_VLRSIS LIKE '  '||BD6_CODPAD||BD6_CODPRO||'%'" 		+ CRLF
	cQry += "   			AND BTU.D_E_L_E_T_ = ' '" 									+ CRLF
	cQry += "		)" 																	+ CRLF
	cQry += "	)"																		+ CRLF
	
	TcQuery cQry New Alias cAliasMon
	
	lConsGuia := cAliasMon->(EOF())//Considera se nao tiver trazido nada na query acima
	
	cAliasMon->(DbCloseArea())
	
EndIf 

BAU->(RestArea(aAreaBAU))
BA1->(RestArea(aAreaBA1))
BTS->(RestArea(aAreaBTS))
BB8->(RestArea(aAreaBB8))
RestArea(aArea)

Return lConsGuia