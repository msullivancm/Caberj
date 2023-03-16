#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'PARMTYPE.CH'
#INCLUDE 'APWEBSRV.CH'
#INCLUDE 'TBICONN.CH'
#INCLUDE 'TOPCONN.CH'
#INCLUDE 'RWMAKE.CH'
#INCLUDE 'AP5MAIL.CH'
#INCLUDE 'FONT.CH'
#INCLUDE 'COLORS.CH'


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ CABA004  บAutor  ณAngelo Henrique     บ Data ณ  23/05/2018 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRotina criada para enviar e-mail para as areas responsแveis บฑฑ
ฑฑบ          ณdos protocolos que ainda estใo em aberto.                   บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณCABERJ                                                      บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/


User Function CABA004(_cParam)
	
	Default _cParam := "1"
	
	//---------------------------------------------------
	//Passando:
	//---------------------------------------------------
	//_cParam = '1' ou em branco -- Via MENU
	//_cParam = '2' -- Via SCHEDULE
	//---------------------------------------------------
	
	If ValType(_cParam) == "A" //Array
		
		_cParam := IIF(ValType(_cParam[1]) != "C", cValToChar(_cParam[1]), _cParam[1])
		
	EndIf
	
	QOut("CABA004 - INICIO - Envio do Relatorio de PA")
	QOut("CABA004 - Parametro enviado: " + _cParam)
	
	If !Empty(_cParam)
		
		If _cParam == "2"
			
			QOut("CABA004 - Preparacao de ambiente")
			
			RpcSetType(3)
			
			If FindFunction("WfPrepEnv")
				
				WFPrepEnv("01","01", , , "PLS")
				
			Else
				
				PREPARE ENVIRONMENT EMPRESA "01" FILIAL "01"  MODULO "PLS"
				
			EndIf
			
			QOut("CABA004 - Empresa Logada: " + cEmpAnt)
			
			QOut("CABA004 - Filial Logada: " + cFilAnt)
			
		EndIf
		
	EndIf
	
	// ***********************************************
	// Rotina da gera็ใo do Arquivo
	// ***********************************************
	u_CABA004A()
	
	QOut("CABA004 - FIM - Envio dos Protocolos de Atendimento")
	
	
	
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ CABA004  บAutor  ณAngelo Henrique     บ Data ณ  23/05/2018 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRotina criada para enviar e-mail para as areas responsแveis บฑฑ
ฑฑบ          ณdos protocolos que ainda estใo em aberto.                   บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณCABERJ                                                      บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function CABA004A()
	
	Local _aArea	:= GetArea()
	Local cAliQry   := GetNextAlias()
	Local cQry 		:= ""
	Local _cTxTot	:= ""
	Local a_HtmTot  := "\HTML\PATOTGERAL.HTML" //Variavel que irแ receber o template do HTML a ser utilizado.
	Local c_ToTot	:= ""
	Local c_CCTot	:= ""
	Local c_AssTot := "Protocolos Abertos por Area"
	Local a_MsgTot	:= {}
	Local cAliQry2  := GetNextAlias()
	Local _ni		:= 0
	Local _ny		:= 0

	//----------------------------------------------------------------------------
	//Fazer para a CABERJ e INTEGRAL
	//----------------------------------------------------------------------------
	For _ni := 1 To 2
		
		//---------------------------------------------------------------
		//Pegando a query geral aqui, pois ela serแ chamada duas vezes
		//---------------------------------------------------------------
		cQry := CABA04QY(_ni)
		
		TcQuery cQry New Alias (cAliQry)
		
		If  !(cAliQry)->(EOF())
			
			//------------------------------------------------------------
			//Gerando aqui o e-mail totalizador para ser encaminhado
			//------------------------------------------------------------
			If _ni = 1
				
				_cTxTot += '<br>' + CRLF
				_cTxTot += '<span data-mce-style="font-size: 16pt;">Abaixo estใo listados todos os protocolos de atendimento que estใo em abertos para as &aacute;reas.</span></div>' + CRLF
				_cTxTot += '<br>' + CRLF
				
				_cTxTot += '<br>' + CRLF
				_cTxTot += '<span data-mce-style="font-size: 18pt; font-weight:bold">CABERJ:</span></div>' + CRLF
				_cTxTot += '<br>' + CRLF
				
			Else
				
				_cTxTot += '<br>' + CRLF
				_cTxTot += '<span data-mce-style="font-size: 18pt; font-weight:bold">INTEGRAL:</span></div>' + CRLF
				_cTxTot += '<br>' + CRLF
				
			EndIf
			
			//-----------------------------------
			//Criando a tabela
			//-----------------------------------
			_cTxTot += '<TABLE BORDER=1>				' + CRLF
			_cTxTot += '<TR style="font-weight:bold">	' + CRLF
			_cTxTot += '<TD>AREA</TD>					' + CRLF
			_cTxTot += '<TD>DESCRICAO</TD>				' + CRLF
			_cTxTot += '<TD>PA ABERTAS</TD>				' + CRLF
			_cTxTot += '</TR>							' + CRLF
			
			(cAliQry)->(DbGoTop())
			While  !(cAliQry)->(EOF())
				
				_cTxTot += '<TR>' + CRLF
				_cTxTot += '<TD>' + (cAliQry)->AREA 				+ '</TD>' + CRLF
				_cTxTot += '<TD>' + (cAliQry)->DESCRI 				+ '</TD>' + CRLF
				_cTxTot += '<TD>' + cValToChar((cAliQry)->ABERTAS) 	+ '</TD>' + CRLF
				_cTxTot += '</TR>' + CRLF
				
				(cAliQry)->(DbSkip())
				
			EndDo
			
			_cTxTot += '</TABLE>' + CRLF
			
			//--------------------------------------------------------------------
			//Caso seja a ultima rodada dele para a INTEGRAL, encaminhar o e-mail
			//--------------------------------------------------------------------
			If _ni = 2
				
				//--------------------------------------------------------------
				//Acrescentando aqui o vetor das variแveis da pแgina web
				//--------------------------------------------------------------
				aAdd( a_MsgTot, { "_cTexto"	, _cTxTot })
				
				c_ToTot := GetNewPar("MV_XEMAIPA","teste@caberj.com.br")
				//c_ToTot := "angelo.cassago@caberj.com.br"
				
				//-----------------------------------------------------
				//Fun็ใo para envio de e-mail
				//-----------------------------------------------------
				If Env_1(a_HtmTot, c_ToTot, c_CCTot, c_AssTot, a_MsgTot )
					
					//Aviso("Aten็ใo", "Protocolo enviado com sucesso!",{"OK"})
					QOut("CABA004 - Protocolo totalizador encaminhado com sucesso para o e-mail: " + c_ToTot)
					
				EndIf
				
				//--------------------------------------------
				//Zerando as variแveis para nใo dar problema
				//--------------------------------------------
				a_MsgTot := {}
				_cTxTot  := ""
				
			EndIf
			
			(cAliQry)->(DbCloseArea())
			
		EndIf
		
	Next _ni
	
	//---------------------------------------------------------------
	//Verificando se o ALIAS foi fechado para nใo dar erro
	//---------------------------------------------------------------
	If Select((cAliQry)) > 0
		(cAliQry)->(DbCloseArea())
	EndIf
	
	//---------------------------------------------------------------
	//Pegando a query geral aqui, pois ela serแ chamada duas vezes
	//---------------------------------------------------------------
	cQry := CABA04QY(_ni)
	
	//---------------------------------------------------------------
	//Verificando se o ALIAS foi fechado para nใo dar erro
	//---------------------------------------------------------------
	If Select((cAliQry)) > 0
		(cAliQry)->(DbCloseArea())
	EndIf
	
	TcQuery cQry New Alias (cAliQry)
	//----------------------------------------------------------------------------------
	//Ap๓s ter gerado o totalizador serแ encaminhado o individual para as แreas
	//----------------------------------------------------------------------------------
	(cAliQry)->(DbGoTop())
	
	While  !(cAliQry)->(EOF())
		
		If (cAliQry)->ABERTAS > 0
			
			For _ny := 1 To 2
				
				If _ny = 1
					
					_cTxTot := '<br>' + CRLF
					_cTxTot += '<span data-mce-style="font-size: 16pt;">Abaixo estใo listados os protocolos de atendimento que estใo em abertos para a &aacute;rea: <strong>' + (cAliQry)->DESCRI + '</strong></span></div>' + CRLF
					_cTxTot += '<br>' + CRLF
					
					_cTxTot += '<br>' + CRLF
					_cTxTot += '<span data-mce-style="font-size: 18pt; font-weight:bold">CABERJ:</span></div>' + CRLF
					_cTxTot += '<br>' + CRLF
					
				Else
					
					_cTxTot += '<br>' + CRLF
					_cTxTot += '<span data-mce-style="font-size: 18pt; font-weight:bold">INTEGRAL:</span></div>' + CRLF
					_cTxTot += '<br>' + CRLF
					
				EndIf
				
				cQry := " SELECT 	                                            											" 	+ CRLF
				cQry += " 	PCF.PCF_COD AREA, 	                		        											" 	+ CRLF
				cQry += " 	TRIM(PCF.PCF_DESCRI) DESCRI,		    	        											" 	+ CRLF
				cQry += " 	TRIM(PCF.PCF_EMAIL) EMAIL,		    	        												" 	+ CRLF
				cQry += " 	SZX.ZX_SEQ PROTOCOLO,	                            											" 	+ CRLF
				cQry += " 	SIGA.FORMATA_DATA_MS(SZX.ZX_DATDE) INCLUSAO,		   											" 	+ CRLF
				cQry += " 	NVL(SZX.ZX_CODINT||SZX.ZX_CODEMP||SZX.ZX_MATRIC||SZX.ZX_TIPREG||SZX.ZX_DIGITO,' ') MATRICULA,	" 	+ CRLF
				cQry += " 	NVL(TRIM(BA1.BA1_NOMUSR),' ') BENEF,		                                                    " 	+ CRLF
				cQry += " 	TRIM(PCB.PCB_DESCRI) CANAL,                                                                     " 	+ CRLF
				cQry += " 	TRIM(PCA.PCA_DESCRI) PORTA,			                                                            " 	+ CRLF
				cQry += " 	RETORNA_DESCRI_PLANO('" + IIf(_ny==1,'C','I') + "',BA1_CODPLA) NOMEPLANO,                       " 	+ CRLF//Motta 7/10/21
				cQry += " 	TRIM(SX5.X5_DESCRI) DEMANDA,                                                                    " 	+ CRLF
				cQry += " 	TRIM(PBL.PBL_YDSSRV) SERVICO,                                                                   " 	+ CRLF
				cQry += " 	SZX.ZX_SLA SLA,                                                                   				" 	+ CRLF
				cQry += " 	TO_CHAR(                                                              							" 	+ CRLF
				cQry += " 		(                                                                   						" 	+ CRLF
				cQry += " 			N_DIAS_UTEIS_PERIODO(TO_DATE(SZX.ZX_DATDE||SZX.ZX_HORADE,'YYYYMMDDHH24MI'),             " 	+ CRLF
				cQry += " 			NVL(TO_DATE(TRIM(SZX.ZX_DATATE||SZX.ZX_HORATE),'YYYYMMDDHH24MI'),SYSDATE))              " 	+ CRLF
				cQry += " 		)                                                                   						" 	+ CRLF
				cQry += " 		- DECODE(TRIM(SZX.ZX_SLA),NULL,'X',SZX.ZX_SLA)                                              " 	+ CRLF
				cQry += " 	) DIAS		                                                                   					" 	+ CRLF
				cQry += " FROM                                                                                              " 	+ CRLF
				cQry += " 	PCF010 PCF                                                                                      " 	+ CRLF
				cQry += " 	INNER JOIN                                                                                      " 	+ CRLF
				
				//-------------------------------------------------------------------------
				//Validando aqui para a CABERJ e INTEGRAL
				//-------------------------------------------------------------------------
				If _ny = 1
					
					cQry += " 	SZX010 SZX 																					"   + CRLF
					
				Else
					
					cQry += " 	SZX020 SZX 																					"   + CRLF
					
				EndIf
				
				cQry += " 	ON                                                                                              " 	+ CRLF
				cQry += " 		SZX.ZX_FILIAL = ' '                                                                         " 	+ CRLF
				cQry += " 		AND SZX.D_E_L_E_T_ = ' '                                                                    " 	+ CRLF
				cQry += " 		AND SZX.ZX_CODAREA = PCF.PCF_COD                                                            " 	+ CRLF
				cQry += " 		AND SZX.ZX_TPINTEL = '1'                                                                    " 	+ CRLF
				cQry += " 	INNER JOIN                                                                                      " 	+ CRLF
				cQry += " 		PCB010 PCB                                                                                  " 	+ CRLF
				cQry += " 	ON                                                                                              " 	+ CRLF
				cQry += " 		PCB.PCB_FILIAL = ' '                                                                        " 	+ CRLF
				cQry += " 		AND PCB.D_E_L_E_T_ = ' '                                                                    " 	+ CRLF
				cQry += " 		AND PCB.PCB_COD = SZX.ZX_CANAL                                                              " 	+ CRLF
				cQry += " 	INNER JOIN                                                                                      " 	+ CRLF
				cQry += " 		PCA010 PCA                                                                                  " 	+ CRLF
				cQry += " 	ON                                                                                              " 	+ CRLF
				cQry += " 		PCA.PCA_FILIAL = ' '                                                                        " 	+ CRLF
				cQry += " 		AND PCA.D_E_L_E_T_ = ' '                                                                    " 	+ CRLF
				cQry += " 		AND PCA.PCA_COD = SZX.ZX_PTENT                                                              " 	+ CRLF
				cQry += " 	INNER JOIN                                                                                      " 	+ CRLF
				
				//-------------------------------------------------------------------------
				//Validando aqui para a CABERJ e INTEGRAL
				//-------------------------------------------------------------------------
				If _ny = 1
					
					cQry += " 	BA1010 BA1 																					"   + CRLF
					
				Else
					
					cQry += " 	BA1020 BA1 																					"   + CRLF
					
				EndIf
				
				cQry += " 	ON                                                                                              " 	+ CRLF
				cQry += " 		BA1.BA1_FILIAL = '" + xFilial("BA1") + "'                                                   " 	+ CRLF
				cQry += " 		AND BA1.BA1_CODINT = SZX.ZX_CODINT                                                          " 	+ CRLF
				cQry += " 		AND BA1.BA1_CODEMP = SZX.ZX_CODEMP                                                          " 	+ CRLF
				cQry += " 		AND BA1.BA1_MATRIC = SZX.ZX_MATRIC                                                          " 	+ CRLF
				cQry += " 		AND BA1.BA1_TIPREG = SZX.ZX_TIPREG                                                          " 	+ CRLF
				cQry += " 		AND BA1.BA1_DIGITO = SZX.ZX_DIGITO                                                          " 	+ CRLF
				cQry += " 		AND BA1.D_E_L_E_T_ = ' '                                                                    " 	+ CRLF
				cQry += " 	INNER JOIN                                                                                      " 	+ CRLF
				cQry += " 		SX5010 SX5                                                                                  " 	+ CRLF
				cQry += " 	ON                                                                                              " 	+ CRLF
				cQry += " 		SX5.X5_FILIAL = '" + xFilial("SX5") + "'                                                    " 	+ CRLF
				cQry += " 		AND SX5.X5_TABELA = 'ZT'                                                                    " 	+ CRLF
				cQry += " 		AND SX5.X5_CHAVE = SZX.ZX_TPDEM                                                             " 	+ CRLF
				cQry += " 		AND SX5.D_E_L_E_T_ = ' '                                                                    " 	+ CRLF
				cQry += " 	INNER JOIN                                                           							" 	+ CRLF
				
				//-------------------------------------------------------------------------
				//Validando aqui para a CABERJ e INTEGRAL
				//-------------------------------------------------------------------------
				If _ny = 1
					
					cQry += " 	SZY010 SZY 																					"   + CRLF
					
				Else
					
					cQry += " 	SZY020 SZY 																					"   + CRLF
					
				EndIf
				
				cQry += " 	ON                                                           									" 	+ CRLF
				cQry += " 		SZY.ZY_FILIAL = ' '                                                          			 	" 	+ CRLF
				cQry += " 		AND SZY.ZY_SEQBA = SZX.ZX_SEQ                                                       	    " 	+ CRLF
				cQry += " 		AND SZY.ZY_SEQSERV = '000001'                                                       	    " 	+ CRLF
				cQry += " 		AND SZY.D_E_L_E_T_ = ' '                                                        		   	" 	+ CRLF
				cQry += " 	INNER JOIN                                                           							" 	+ CRLF
				cQry += " 		PBL010 PBL                                                   						        " 	+ CRLF
				cQry += " 	ON                                                           									" 	+ CRLF
				cQry += " 		PBL.PBL_FILIAL = ' '                                                           				" 	+ CRLF
				cQry += " 		AND PBL.PBL_YCDSRV = SZY.ZY_TIPOSV                                                          " 	+ CRLF
				cQry += " 		AND PBL.D_E_L_E_T_ = ' '                                                           			" 	+ CRLF
				cQry += " WHERE                                                                                             " 	+ CRLF
				cQry += " 	PCF.PCF_FILIAL = '" + xFilial("PCF") + "'                                                       " 	+ CRLF
				cQry += " 	AND PCF.D_E_L_E_T_ = ' '                                                                        " 	+ CRLF
				cQry += " 	AND PCF.PCF_COD = '" + (cAliQry)->AREA + "'                                                     " 	+ CRLF
				cQry += " 	AND PCF.PCF_EMAIL <> ' ' 																		" 	+ CRLF
				cQry += " ORDER BY                                                                                          " 	+ CRLF
				cQry += " 	PCF.PCF_COD,                                                                                    " 	+ CRLF
				cQry += " 	SZX.ZX_DATDE                                                                                    " 	+ CRLF
				
				If Select((cAliQry2)) > 0
					(cAliQry2)->(DbCloseArea())
				EndIf
				
				TcQuery cQry New Alias (cAliQry2)
				
				//-----------------------------------
				//Criando a tabela
				//-----------------------------------
				_cTxTot += '<TABLE BORDER=1>									' + CRLF
				_cTxTot += '<TR style="font-weight:bold">						' + CRLF
				_cTxTot += '<TD>PROTOCOLO</TD>									' + CRLF
				_cTxTot += '<TD>INCLUSAO</TD>									' + CRLF
				_cTxTot += '<TD>MATRICULA</TD>									' + CRLF
				_cTxTot += '<TD>BENEFICIARIO</TD>								' + CRLF
				_cTxTot += '<TD>CANAL</TD>										' + CRLF
				_cTxTot += '<TD>PORTA ENTRADA</TD>								' + CRLF
				_cTxTot += '<TD>NOMEPLANO</TD>				     				' + CRLF//Motta 7/10/21
				_cTxTot += '<TD>DEMANDA</TD>									' + CRLF
				_cTxTot += '<TD>SERVI&Ccedil;O</TD>								' + CRLF
				_cTxTot += '<TD>&nbsp;&nbsp;SLA&nbsp;&nbsp;</TD>				' + CRLF
				_cTxTot += '<TD>&nbsp;&nbsp;&nbsp;EXPIRAR&nbsp;&nbsp;&nbsp;</TD>' + CRLF
				_cTxTot += '</TR>												' + CRLF
				
				While !(cAliQry2)->(EOF())
					
					_cTxTot += '<TR>' + CRLF
					_cTxTot += '<TD>' + (cAliQry2)->PROTOCOLO					+ '</TD>' + CRLF
					_cTxTot += '<TD>' + AllTrim((cAliQry2)->INCLUSAO)			+ '</TD>' + CRLF
					_cTxTot += '<TD>' + (cAliQry2)->MATRICULA 					+ '</TD>' + CRLF
					_cTxTot += '<TD>' + (cAliQry2)->BENEF 						+ '</TD>' + CRLF
					_cTxTot += '<TD>' + (cAliQry2)->CANAL 						+ '</TD>' + CRLF
					_cTxTot += '<TD>' + (cAliQry2)->PORTA 						+ '</TD>' + CRLF
					_cTxTot += '<TD>' + (cAliQry2)->NOMEPLANO	         		+ '</TD>' + CRLF//Motta 7/10/21
					_cTxTot += '<TD>' + (cAliQry2)->DEMANDA						+ '</TD>' + CRLF
					_cTxTot += '<TD>' + (cAliQry2)->SERVICO						+ '</TD>' + CRLF
					_cTxTot += '<TD>' + cValToChar((cAliQry2)->SLA) + " dias"	+ '</TD>' + CRLF
					
					If SUBSTR((cAliQry2)->DIAS,1,1) = "-"
						
						_cTxTot += '<TD>' + Replace((cAliQry2)->DIAS,"-","") + " dias a expirar "	+ '</TD>' + CRLF
						
					Else
						
						_cTxTot += '<TD>' + "Expirado h&aacute; " + (cAliQry2)->DIAS + " dias."		+ '</TD>' + CRLF
						
					EndIf
					
					_cTxTot += '</TR>' + CRLF
					
					(cAliQry2)->(DbSkip())
					
				EndDo
				
				_cTxTot += '</TABLE>' + CRLF
				
				//--------------------------------------------------------------------
				//Caso seja a ultima rodada dele para a INTEGRAL, encaminhar o e-mail
				//--------------------------------------------------------------------
				If _ny = 2
					
					//--------------------------------------------------------------
					//Acrescentando aqui o vetor das variแveis da pแgina web
					//--------------------------------------------------------------
					aAdd( a_MsgTot, { "_cTexto"	, _cTxTot }) //Informa็๕es beneficiแrios bloqueados
					
					//c_ToTot := "angelo.cassago@caberj.com.br"
					//c_ToTot := "motta@caberj.com.br"
					c_ToTot := (cAliQry)->EMAIL
					
					//-----------------------------------------------------
					//Fun็ใo para envio de e-mail
					//-----------------------------------------------------
					If Env_1(a_HtmTot, c_ToTot, c_CCTot, c_AssTot, a_MsgTot )
						
						//Aviso("Aten็ใo", "Protocolo enviado com sucesso para a area: " + (cAliQry)->AREA ,{"OK"})
						QOut("CABA004 - protocolo enviado com sucesso para a area: " + (cAliQry)->AREA)
						QOut("CABA004 - Com o seguinte email: " + (cAliQry)->EMAIL)
						
					EndIf
					
					//--------------------------------------------
					//Zerando o vetor ap๓s encaminhar o e-mail
					//--------------------------------------------
					a_MsgTot := {}
					_cTxTot := ""
					
				EndIf
				
			Next _ny
			
		EndIf
		
		//-----------------------------------------------------------------------------
		//Fechando a segunda แrea aberta, onde foram listados os protocolos em aberto
		//-----------------------------------------------------------------------------
		If Select((cAliQry2)) > 0
			(cAliQry2)->(DbCloseArea())
		EndIf
		
		(cAliQry)->(DbSkip())
		
	EndDo
	
	If Select((cAliQry)) > 0
		(cAliQry)->(DbCloseArea())
	EndIf
	
	RestArea(_aArea)
	
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCABA04QY  บAutor  ณAngelo Henrique     บ Data ณ  28/05/18   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Fun็ใo para armazenar a query principal uma vez que ela    บฑฑ
ฑฑบ          ณserแ chamada duas vezes.                                    บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function CABA04QY(_ni)
	
	Local _cQuery := ""
	
	_cQuery := " SELECT 												" 	+ CRLF
	_cQuery += " 	PCF.PCF_COD AREA,									" 	+ CRLF
	_cQuery += " 	TRIM(PCF.PCF_DESCRI) DESCRI,						" 	+ CRLF
	_cQuery += " 	TRIM(PCF.PCF_EMAIL) EMAIL,		    	        	" 	+ CRLF
	_cQuery += " 	(													" 	+ CRLF
	_cQuery += " 		SELECT											" 	+ CRLF
	_cQuery += " 			COUNT(SZX.ZX_SEQ) TOTAL						" 	+ CRLF
	_cQuery += " 		FROM 											"   + CRLF
	
	//-------------------------------------------------------------------------
	//Validando aqui para a CABERJ e INTEGRAL
	//-------------------------------------------------------------------------
	If _ni = 1
		
		_cQuery += " 	SZX010 SZX 										"   + CRLF
		
	Else
		
		_cQuery += " 	SZX020 SZX 										"   + CRLF
		
	EndIf
	
	_cQuery += " 		WHERE											" 	+ CRLF
	_cQuery += " 			SZX.ZX_FILIAL = '" + xFilial("SZX") + "'	" 	+ CRLF
	_cQuery += " 			AND SZX.D_E_L_E_T_ = ' '					" 	+ CRLF
	_cQuery += " 			AND SZX.ZX_CODAREA = PCF.PCF_COD			" 	+ CRLF
	_cQuery += " 			AND SZX.ZX_TPINTEL = '1'					" 	+ CRLF
	_cQuery += "	) ABERTAS											" 	+ CRLF
	_cQuery += " FROM " + RetSqlName('PCF') + " PCF 					"   + CRLF
	_cQuery += " WHERE													" 	+ CRLF
	_cQuery += " 	PCF.PCF_FILIAL = '" + xFilial("PCF") + "'			" 	+ CRLF
	_cQuery += " 	AND PCF.D_E_L_E_T_ = ' '							" 	+ CRLF
	_cQuery += " ORDER BY												" 	+ CRLF
	_cQuery += " 	PCF.PCF_COD											" 	+ CRLF
	
Return _cQuery


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณEnv_1     บAutor  ณAngelo Henrique     บ Data ณ  30/03/17   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Fun็ใo generica responsavel pelo envio de e-mails.         บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function Env_1(c_ArqTxt, c_To, c_CC, c_Assunto, a_Msg )
	
	Local n_It 			:= 0
	
	Local l_Result    	:= .F.                   		// resultado de uma conexใo ou envio
	Local nHdl        	:= fOpen(c_ArqTxt,68)
	Local c_Body      	:= space(99999)
	
	Private _cServer  	:= Trim(GetMV("MV_RELSERV")) 	// smtp.ig.com.br ou 200.181.100.51
	
	Private _cUser    	:= GetNewPar("MV_XMAILPA", "protocolodeatendimento@caberj.com.br")
	Private _cPass    	:= GetNewPar("MV_XPSWPA" , "Caberj2017@!")
	
	Private _cFrom    	:= "CABERJ PROTHEUS"
	Private cMsg      	:= ""
	
	If !(nHdl == -1)
		
		nBtLidos := fRead(nHdl,@c_Body,99999)
		fClose(nHdl)
		
		For n_It:= 1 to Len( a_Msg )
			
			c_Body  := StrTran(c_Body, a_Msg[n_It][1] , a_Msg[n_It][2])
			
		Next
		
		// Tira quebras de linha para nao dar problema no WebMail da Caberj
		c_Body  := StrTran(c_Body,CHR(13)+CHR(10) , "")

		l_Result := U_CabEmail(c_To, "", "", c_Assunto, c_Body, {}, _cUser,, .T.,,,,{})[1]

		/*
		// Contecta o servidor de e-mail
		CONNECT SMTP SERVER _cServer ACCOUNT _cUser PASSWORD _cPass RESULT l_Result
		
		If !l_Result
			
			GET MAIL ERROR _cError
			
			DISCONNECT SMTP SERVER RESULT lOk
			
		Else
			
			SEND MAIL FROM _cUser TO c_To SUBJECT c_Assunto BODY c_Body  RESULT l_Result
			
			If !l_Result
				
				GET MAIL ERROR _cError
				
			Endif
			
		EndIf
		*/
		
	Endif
	
Return l_Result
