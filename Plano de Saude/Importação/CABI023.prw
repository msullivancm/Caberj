#Include "PLSMGER.CH"
#Include "PROTHEUS.CH"
#Include "COLORS.CH"
#INCLUDE "rwmake.ch"
#INCLUDE "topconn.ch"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ CABI023  บAutor  ณ Fred O. C. Jr      บ Data ณ  27/08/21   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ    Rotina para carga de Terminologias TISS                 บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function CABI023()

Local oDlg
Local oCodTab
Local cCodTab	:= Space(2)
Local nOpcao	:= 0
Local oArquiv
Local cArquiv	:= ""
Local nPosVig	:= 0
Local nQtdDig	:= 8
Local lErro		:= .F.
Local nCont		:= 1

DEFINE MSDIALOG oDlg TITLE OemToAnsi("Importa็ใo de Terminologia TUSS") FROM 000,000 TO 200,400 PIXEL

	@006,008 SAY "Este programa tem por objetivo a importa็ใo de arquivo com a atualiza็ใo"				PIXEL
	@014,008 SAY "da Terminologia TUSS."																PIXEL
	
	@030,008 SAY "As tabelas de terminologia tratadas neste importador sใo:"				 			PIXEL
	@038,008 SAY " -> Tabelas: 18, 19, 20, 22, 24, 38 e 64"									 			PIXEL
	
	@055,008 SAY "Informe qual tabela quer importar:"										 			PIXEL
	@054,098 MsGet oCodTab		VAR cCodTab			SIZE 020,008										PIXEL OF oDlg
	
	@075,045 BUTTON "CONFIRMAR"	SIZE 050,010 PIXEL ACTION (nOpcao := 1, Close(oDlg))
	@075,107 BUTTON "CANCELAR"	SIZE 050,010 PIXEL ACTION Close(oDlg)

ACTIVATE DIALOG oDlg CENTERED

if nOpcao == 1

	if cCodTab == '18' .or. cCodTab == '19' .or. cCodTab == '20' .or. cCodTab == '22' .or. cCodTab == '24' .or. cCodTab == '38' .or. cCodTab == '64'
	
		nOpcao := 0
		
		DEFINE MSDIALOG oDlg TITLE OemToAnsi("Terminologia TUSS - Tabela " + cCodTab) FROM 000,000 TO 325,410 PIXEL
		
			if cCodTab == '18'
				@006,008 SAY "-> Terminologia de Diแrias, Taxas e Gases Medicinais"									PIXEL
			elseif cCodTab == '19'
				@006,008 SAY "-> Terminologia de Materiais e ำrteses, Pr๓teses e Materiais Especiais (OPME)"		PIXEL
			elseif cCodTab == '20'
				@006,008 SAY "-> Terminologia de Medicamentos"														PIXEL
			elseif cCodTab == '22'
				@006,008 SAY "-> Terminologia de Procedimentos e Eventos em Sa๚de"									PIXEL
			elseif cCodTab == '24'
				@006,008 SAY "-> Terminologia do C๓digo Brasileiro de Ocupa็ใo (CBO)"								PIXEL
			elseif cCodTab == '38'
				@006,008 SAY "-> Terminologia de Mensagens (Glosas, Negativas e Outras)"							PIXEL
			elseif cCodTab == '64'
				@006,008 SAY "-> Terminologia de Forma de Envio para ANS de Procedimentos e Itens Assistenciais."	PIXEL
			endif
			
			@022,070 SAY "- Regras de Importa็ใo -"																	PIXEL
			@034,018 SAY "* O arquivo para esta carga deve estar em formato CSV."									PIXEL
			@042,018 SAY "* O nome do arquivo deve come็ar com o c๓digo da tabela a ser importada."					PIXEL
			@050,018 SAY "* As colunas constantes devem obedecer o seguinte layout:"								PIXEL
			
			if cCodTab == '18' .or. cCodTab == '22' .or. cCodTab == '24' .or. cCodTab == '38'
			
				nPosVig := 3
				
				if cCodTab == '24'
					nQtdDig	:= 6
				elseif cCodTab == '38'
					nQtdDig	:= 4
				endif
				
				@058,035 SAY "1- C๓digo do Termo"																	PIXEL
				@066,035 SAY "2- Termo"																				PIXEL
				@074,035 SAY "3- Data de Inํcio Vig๊ncia"															PIXEL
				@082,035 SAY "4- Data de Fim de Vig๊ncia"															PIXEL
				@090,035 SAY "5- Data de Fim de Implanta็ใo"														PIXEL
				
			elseif cCodTab == '19'
			
				nPosVig := 5
				
				@058,035 SAY "1- C๓digo do Termo"																	PIXEL
				@066,035 SAY "2- Termo"																				PIXEL
				@074,035 SAY "3- Modelo"																			PIXEL
				@082,035 SAY "4- Fabricante"																		PIXEL
				@090,035 SAY "5- Data de Inํcio Vig๊ncia"															PIXEL
				@098,035 SAY "6- Data de Fim de Vig๊ncia"															PIXEL
				@106,035 SAY "7- Data de Fim de Implanta็ใo"														PIXEL
			
			elseif cCodTab == '20'
			
				nPosVig := 5
				
				@058,035 SAY "1- C๓digo do Termo"																	PIXEL
				@066,035 SAY "2- Termo"																				PIXEL
				@074,035 SAY "3- Apresenta็ใo"																		PIXEL
				@082,035 SAY "4- Laborat๓rio"																		PIXEL
				@090,035 SAY "5- Data de Inํcio Vig๊ncia"															PIXEL
				@098,035 SAY "6- Data de Fim de Vig๊ncia"															PIXEL
				@106,035 SAY "7- Data de Fim de Implanta็ใo"														PIXEL
			
			elseif cCodTab == '64'
			
				nPosVig := 5
				
				@058,035 SAY "1- Tab. Terminologia (18-19-20-22)"													PIXEL
				@066,035 SAY "2- C๓digo do Termo"																	PIXEL
				@074,035 SAY "3- Forma de Envio"																	PIXEL
				@082,035 SAY "4- C๓digo do Grupo"																	PIXEL
				@090,035 SAY "5- Data de Inํcio Vig๊ncia"															PIXEL
				@098,035 SAY "6- Data de Fim de Vig๊ncia"															PIXEL
				@106,035 SAY "7- Data de Fim de Implanta็ใo"														PIXEL
			
			endif
			
			@125,008 SAY "Arquivo:"															 			PIXEL
			@124,035 MsGet oArquiv		VAR cArquiv		SIZE 140,008		When .F.								PIXEL OF oDlg
			@124,178 BUTTON "..." SIZE 015,010 PIXEL ACTION (cArquiv := cGetFile("Arquivo Texto (*.csv) | *.csv", OemToAnsi("Selecione Arquivo"),,"",.F.,GETF_LOCALHARD+GETF_NETWORKDRIVE,.F.))
			
			@144,045 BUTTON "CONFIRMAR"	SIZE 050,010 PIXEL ACTION (nOpcao := 1, Close(oDlg))
			@144,107 BUTTON "CANCELAR"	SIZE 050,010 PIXEL ACTION Close(oDlg)
		
		ACTIVATE DIALOG oDlg CENTERED
		
		if nOpcao == 1
		
			if !Empty(cArquiv)
			
				while at("\", cArquiv, nCont) <> 0
					nCont := at("\", cArquiv, nCont) + 1
				end
				
				if SubStr(cArquiv,nCont,2) == cCodTab
				
					Processa( {|| lErro := VincTab(cCodTab, cArquiv, nPosVig, nQtdDig) }, "Importando - Tabela " + cCodTab, "Importando...", .T. )
					
					if !lErro
						MsgInfo("Processamento concluํdo com sucesso!")
					else
						MsgInfo("Processamento concluํdo! Por้m alguns registros apresentaram problemas na importa็ใo. " +;
								"Por favor verificar o arquivo de log criado no mesmo diret๓rio que o arquivo que selecionou para importa็ใo!")
					endif
				
				else
				
					alert("As duas primeiras posi็๕es do nome do arquivo devem conter o c๓digo da tabela a ser importada.")
				
				endif
			
			else
			
				Alert("Arquivo nใo informado. Processamento nใo executado!")
			
			endif
		
		endif
	
	else
		Alert("Tabela informada nใo contemplada neste importador.")
	endif

endif

return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ VincTab  บAutor  ณMicrosiga           บ Data ณ  01/21/16   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ    Rotina para carga de Terminologias TISS                 บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function VincTab(cCodTab, cArquivo, nPosVig, nQtdDig)

Local nHdl		:= FT_FUse(cArquivo)
Local cBuffer	:= ""
Local aAux		:= {}

Local nIncNew	:= 0
Local nRECAlt	:= 0
Local dMaxVig	:= StoD("")
Local cCodTermo	:= ""
Local cDescri	:= ""
Local dVigDe	:= StoD("")
Local dVigAte	:= StoD("")
Local dImplAte	:= StoD("")
Local cTabOri	:= ""
Local cFormEn	:= ""
Local cCodGru	:= ""
Local cDesGru	:= ""

Local lChk		:= .F.
Local lErro		:= .F.

Local nHdl2		:= 0
Local nCont		:= 1

Local cQuery	:= ""
Local cAliasQry

Local cEOL		:= CHR(13) + CHR(10)

while at("\", cArquivo, nCont) <> 0
	nCont := at("\", cArquivo, nCont) + 1
end

nHdl2	:= FCREATE( SubStr(cArquivo, 1, nCont-1) + "log_tabela_" + cCodTab + "_" + DtoS(date()) + "-" + StrTran(time(), ":", "") + ".csv")

if nHdl2 <> -1

	cExtracao := "LINHA;COD. TERMO;CRITICA;LOG" + cEOL
	FWRITE ( nHdl2 , cExtracao )
	
	// Se arquivo foi aberto, come็ar o processamento
	if nHdl <> -1
	
		nCont := 1
		
		ProcRegua(FT_FLastRec())	// Retorna o n๚mero de linhas do arquivo
		
		FT_FGoTop()	// Posiciona na primeira linha
		FT_FSkip()	// Pula primeira linha - cabe็alho
		while !FT_FEOF()
		
			IncProc()
			
			nCont++
			
			cBuffer	:= FT_FReadLn() // Retorna a linha corrente
			aAux	:= StrTokArr2( cBuffer, ";", .T. )
			lChk	:= .F.
			
			if empty(cBuffer)
				FT_FSkip()	// Pula para pr๓xima linha
				loop
			endif
			
			cCodTermo := iif(len(aAux) > 1, iif(cCodTab <> "64", AllTrim(aAux[1]), AllTrim(aAux[2]) ), "" )      
			
			// Validar qtde de digitos
			if	( (cCodTab == "18" .or. cCodTab == "22" .or. cCodTab == "24" .or. cCodTab == "38")	.and. len(aAux) == 5 ) .or.;
				( (cCodTab == "19" .or. cCodTab == "20" .or. cCodTab == "64")						.and. len(aAux) == 7 )
				
				// Procedimento tem que ser num้rico
				if val( cCodTermo ) > 0
				
					// Tratar qtde esperada de digitos no cod. do termo
					if len( cCodTermo ) == nQtdDig
					
						cDescri := iif(cCodTab <> "64", Upper(FwNoAccent(OEMToANSI(StrTran(StrTran(StrTran(AllTrim(aAux[2]),"ร",""),"'",""),'"',"")))), "")
						
						// descri็ใo do termo - obrigatorio
						if ( cCodTab <> "64" .and. !empty( cDescri ) ) .or. ( cCodTab == "64" .and. empty( cDescri ) )
						
							dVigDe		:= CtoD( aAux[nPosVig]     )
							dVigAte		:= CtoD( aAux[nPosVig + 1] )
							dImplAte	:= CtoD( aAux[nPosVig + 2] )
							
							// Tratamentos dos campos de data
							if !(empty( dVigDe ) .and. !empty( aAux[nPosVig] ))
							
								if !(empty( dVigAte ) .and. !empty( aAux[nPosVig + 1] ))
								
									if !(empty( dImplAte ) .and. !empty( aAux[nPosVig + 2] ))
									
										if !empty( dVigDe )
										
											if !empty( dImplAte )
											
												if dVigAte >= dVigDe .or. empty( dVigAte )
												
													if cCodTab == "64"
													
														cTabOri	:= AllTrim(aAux[1])
														cFormEn	:= AllTrim(aAux[3])
														cCodGru	:= AllTrim(aAux[4])
														cDesGru	:= ""
														
														if cTabOri == '18' .or. cTabOri == '19' .or. cTabOri == '20' .or. cTabOri == '22'
														
															if cFormEn == 'Individualizado' .or. cFormEn == 'Consolidado'
															
																BTQ->(DbSetOrder(2))	// BTQ_FILIAL+BTQ_CODTAB+BTQ_CDTERM+BTQ_VIGDE
																if BTQ->(DbSeek( xFilial("BTQ") + cTabOri + cCodTermo ))
																
																	cDescri := AllTrim( BTQ->BTQ_DESTER )
																	
																	if cFormEn == 'Consolidado'
																	
																		BTQ->(DbSetOrder(2))	// BTQ_FILIAL+BTQ_CODTAB+BTQ_CDTERM+BTQ_VIGDE
																		if BTQ->(DbSeek( xFilial("BTQ") + "63" + cCodGru )) .and. !empty(cCodGru)
																		
																			cDesGru		:= AllTrim( BTQ->BTQ_DESTER )
																			lChk		:= .T.		// Passou nas regras de preenchimento do arquivo
																		
																		else
																			lErro		:= .T.
																			cExtracao := AllTrim(str(nCont)) + ";" + cCodTermo + ";Sim;Codigo do grupo nao localizado na tabela 63 da terminologia." + cEOL
																			FWRITE ( nHdl2 , cExtracao )
																		endif
																	
																	else
																	
																		if empty(cCodGru)
																		
																			lChk		:= .T.		// Passou nas regras de preenchimento do arquivo
																		
																		else
																			lErro		:= .T.
																			cExtracao := AllTrim(str(nCont)) + ";" + cCodTermo + ";Sim;Codigo individualizado nao deve possuir grupo." + cEOL
																			FWRITE ( nHdl2 , cExtracao )
																		endif
																	
																	endif
																	
																else
																	lErro		:= .T.
																	cExtracao := AllTrim(str(nCont)) + ";" + cCodTermo + ";Sim;Procedimento nao existe na tabela de terminologia original." + cEOL
																	FWRITE ( nHdl2 , cExtracao )
																endif
															
															else
																lErro		:= .T.
																cExtracao := AllTrim(str(nCont)) + ";" + cCodTermo + ";Sim;Forma de envio invalida." + cEOL
																FWRITE ( nHdl2 , cExtracao )
															endif
														
														else
															lErro		:= .T.
															cExtracao := AllTrim(str(nCont)) + ";" + cCodTermo + ";Sim;Tabela de terminologia de origem nao contemplada." + cEOL
															FWRITE ( nHdl2 , cExtracao )
														endif
													
													else
														lChk		:= .T.		// Passou nas regras de preenchimento do arquivo
													endif
												
												else
													lErro		:= .T.
													cExtracao := AllTrim(str(nCont)) + ";" + cCodTermo + ";Sim;Data de fim de vigencia anterior a data de inicio." + cEOL
													FWRITE ( nHdl2 , cExtracao )
												endif
											
											else
												lErro		:= .T.
												cExtracao := AllTrim(str(nCont)) + ";" + cCodTermo + ";Sim;Data de fim de implantacao nao informada." + cEOL
												FWRITE ( nHdl2 , cExtracao )
											endif
										
										else
											lErro		:= .T.
											cExtracao := AllTrim(str(nCont)) + ";" + cCodTermo + ";Sim;Data de inicio de vigencia nao informada." + cEOL
											FWRITE ( nHdl2 , cExtracao )
										endif
									
									else
										lErro		:= .T.
										cExtracao := AllTrim(str(nCont)) + ";" + cCodTermo + ";Sim;Data de fim de implantacao invalida." + cEOL
										FWRITE ( nHdl2 , cExtracao )
									endif
								
								else
									lErro		:= .T.
									cExtracao := AllTrim(str(nCont)) + ";" + cCodTermo + ";Sim;Data de fim de vigencia invalida." + cEOL
									FWRITE ( nHdl2 , cExtracao )
								endif
							
							else
								lErro		:= .T.
								cExtracao := AllTrim(str(nCont)) + ";" + cCodTermo + ";Sim;Data de inicio de vigencia invalida." + cEOL
								FWRITE ( nHdl2 , cExtracao )
							endif
						
						else
							lErro		:= .T.
							cExtracao := AllTrim(str(nCont)) + ";" + cCodTermo + ";Sim;Descricao do termo nao informada." + cEOL
							FWRITE ( nHdl2 , cExtracao )
						endif
					
					else
						lErro		:= .T.
						cExtracao := AllTrim(str(nCont)) + ";" + cCodTermo + ";Sim;Quantidade de caracteres do codigo do termo invalido." + cEOL
						FWRITE ( nHdl2 , cExtracao )
					endif
				
				else
					lErro		:= .T.
					cExtracao := AllTrim(str(nCont)) + ";" + cCodTermo + ";Sim;Codigo do termo possui caracter(es) alfanumerico(s)." + cEOL
					FWRITE ( nHdl2 , cExtracao )
				endif
			
			else
				lErro		:= .T.
				cExtracao := AllTrim(str(nCont)) + ";" + cCodTermo + ";Sim;Quant. de dados incorreta no arquivo." + cEOL
				FWRITE ( nHdl2 , cExtracao )
			endif
			
			//Regras de preenchimento da linha - OK (entrar pro processamento)
			if lChk
			
				nIncNew	:= 0	// Nใo fazer nada
				
				BTQ->(DbSetOrder(2))	// BTQ_FILIAL+BTQ_CODTAB+BTQ_CDTERM+BTQ_VIGDE
				if BTQ->(DbSeek( xFilial("BTQ") + cCodTab + cCodTermo ))
				
					dMaxVig	:= StoD("")
					
					while BTQ->(!EOF()) .and. AllTrim(BTQ->(BTQ_FILIAL+BTQ_CODTAB+BTQ_CDTERM)) == xFilial("BTQ") + cCodTab + cCodTermo
					
						if BTQ->BTQ_VIGDE == dVigDe
						
							nIncNew	:= 3	// Termo jแ importado (atualizar registro)
							nRECAlt	:= BTQ->(Recno())
							exit
						
						elseif BTQ->BTQ_VIGDE > dMaxVig .and. !empty(BTQ->BTQ_VIGDE)
						
							dMaxVig := BTQ->BTQ_VIGDE
							nRECAlt	:= BTQ->(Recno())
						
						endif
						
						BTQ->(DbSkip())
					end
					
					if nIncNew <> 3		// nใo ้ uma atualiza็ใo - checar vigencia final da base com a que se vai importar
					
						if dVigDe > dMaxVig
						
							nIncNew	:= 2	// Termo jแ existe, mas ้ uma nova vig๊ncia
						
						else
							lErro		:= .T.
							cExtracao := AllTrim(str(nCont)) + ";" + cCodTermo + ";Sim;Data de inicio de vigencia menor que a ultima cadastrada." + cEOL
							FWRITE ( nHdl2 , cExtracao )
						endif
					
					endif
				
				else
				
					nIncNew	:= 1	// Novo Termo
				
				endif
				
				if nIncNew == 2
				
					BTQ->(DbSetOrder(2))	// BTQ_FILIAL+BTQ_CODTAB+BTQ_CDTERM+BTQ_VIGDE
					BTQ->(DbGoTo(nRECAlt))
					
					BTQ->(RecLock("BTQ", .F.))
						BTQ->BTQ_VIGATE := dVigDe - 1
						BTQ->BTQ_XUSBLO	:= cUserName
						BTQ->BTQ_XDTBLO	:= date()
						BTQ->BTQ_XHRBLO	:= time()
					BTQ->(MsUnLock())
					
					cExtracao := AllTrim(str(nCont)) + ";" + cCodTermo + ";Nao;Nova vigencia incluida." + cEOL
					FWRITE ( nHdl2 , cExtracao )
					
				endif
				
				if nIncNew > 0
				
					if nIncNew == 1
					
						cExtracao := AllTrim(str(nCont)) + ";" + cCodTermo + ";Nao;Novo termo criado." + cEOL
						FWRITE ( nHdl2 , cExtracao )
					
					elseif nIncNew == 3
					
						cExtracao := AllTrim(str(nCont)) + ";" + cCodTermo + ";Nao;Termo existente atualizado." + cEOL
						FWRITE ( nHdl2 , cExtracao )
					
					endif
					
					BTQ->(RecLock("BTQ", iif(nIncNew == 3, .F., .T.) ))
						BTQ->BTQ_FILIAL	:= xFilial("BTQ")
						BTQ->BTQ_CODTAB	:= cCodTab
						BTQ->BTQ_CDTERM	:= cCodTermo
						BTQ->BTQ_DESTER	:= cDescri
						BTQ->BTQ_VIGDE	:= dVigDe
						BTQ->BTQ_VIGATE	:= dVigAte
						BTQ->BTQ_DATFIM	:= dImplAte
						
						if cCodTab == "19"
							BTQ->BTQ_REFFAB	:= Upper(FwNoAccent(OEMToANSI(StrTran(StrTran(StrTran(AllTrim(aAux[3]),"ร",""),"'",""),'"',""))))
							BTQ->BTQ_FABRIC	:= Upper(FwNoAccent(OEMToANSI(StrTran(StrTran(StrTran(AllTrim(aAux[4]),"ร",""),"'",""),'"',""))))
						endif
						
						if cCodTab == "20"
							BTQ->BTQ_APRESE	:= Upper(FwNoAccent(OEMToANSI(StrTran(StrTran(StrTran(AllTrim(aAux[3]),"ร",""),"'",""),'"',""))))
							BTQ->BTQ_LABORA	:= Upper(FwNoAccent(OEMToANSI(StrTran(StrTran(StrTran(AllTrim(aAux[4]),"ร",""),"'",""),'"',""))))
						endif
						
						if cCodTab == "64"
							BTQ->BTQ_FENVIO	:= cFormEn
							BTQ->BTQ_TABTUS	:= cTabOri
							BTQ->BTQ_CODGRU	:= cCodGru
							BTQ->BTQ_DESGRU	:= cDesGru
						endif
						
						BTU->(DbSetOrder(5))	// BTU_FILIAL+BTU_CODTAB+BTU_CDTERM+BTU_ALIAS
						if BTU->(DbSeek(xFilial("BTU") + cCodTab + cCodTermo ))
							BTQ->BTQ_HASVIN	:= "1"
						else
							BTQ->BTQ_HASVIN	:= "0"
						endif
						
						// Log de importa็ใo (somente na inclusใo)
						if nIncNew <> 3
							BTQ->BTQ_XUSIMP	:= cUserName
							BTQ->BTQ_XDTIMP	:= date()
							BTQ->BTQ_XHRIMP	:= time()
						endif

						BTQ->BTQ_XDESTE	:= cDescri
						
						/*
						BTQ->BTQ_DSCDET := 
						BTQ->BTQ_SIGLA	:= 
						*/
					
					BTQ->(MsUnLock())
				
				endif
			
			endif
			
			FT_FSkip()	// Pula para pr๓xima linha
		end
		
		FT_FUse()
		
		// Buscar qual tabela padrใo ้ o de-para da tabela TISS importada
		BTU->(DbSetOrder(3))	// BTU_FILIAL+BTU_CODTAB+BTU_ALIAS+BTU_CDTERM
		if BTU->(DbSeek( xFilial("BTU") + "87" + "BR4" + cCodTab ))
		
			BR4->(DbSetOrder(1))	// BR4_FILIAL+BR4_CODPAD+BR4_SEGMEN
			if BR4->(DbSeek( AllTrim(BTU->BTU_VLRSIS) )) .and. !empty( BTU->BTU_VLRBUS )
			
				if MsgYesNo("Foi identificado que a tabela de de-para da terminologia " + cCodTab + " ้ a " + AllTrim(BTU->BTU_VLRBUS) + "."+;
								CHR(13)+CHR(10) + CHR(13)+CHR(10)																			+;
							"Deseja executar a amarra็ใo de todos os c๓digos semelhantes entre a Tabela Padrใo e Terminologia?"				)
					
					nCont  := 0
					
					cQuery := " select BTQ.R_E_C_N_O_ as BTQREC, BR8.R_E_C_N_O_ as BR8REC"
					cQuery += " from " + RetSqlName("BTQ") + " BTQ"
					cQuery +=	" inner join " + RetSqlName("BR8") + " BR8"
					cQuery +=		" on (    BR8_FILIAL = BTQ_FILIAL"
					cQuery +=			" and BR8_CODPAD = '" + AllTrim(BTU->BTU_VLRBUS) + "'"
					cQuery +=			" and BR8_CODPSA = BTQ_CDTERM)"
					cQuery += " where BTQ.D_E_L_E_T_ = ' ' and BR8.D_E_L_E_T_ = ' '"
					cQuery += 	" and BTQ_FILIAL = '" + xFilial("BTQ") + "'"
					cQuery +=	" and BTQ_CODTAB = '" +     cCodTab    + "'"
					cQuery +=	" and not exists (select BTU_FILIAL"
					cQuery +=					" from " + RetSqlName("BTU") + " BTU"
					cQuery +=					" where BTU.D_E_L_E_T_ = ' '"
					cQuery +=						" and BTU_FILIAL = BTQ_FILIAL"
					cQuery +=						" and BTU_CODTAB = '" + cCodTab + "'"
					cQuery +=						" and BTU_ALIAS  = 'BR8'"
					cQuery +=						" and BTU_CDTERM = BTQ_CDTERM)"
					cQuery += " order by BTQ_CODTAB, BTQ_CDTERM"
					
					cAliasQry := MpSysOpenQuery(cQuery)
					
					DbSelectArea( cAliasQry )
					while !(cAliasQry)->(Eof())
					
						BTQ->(DbSetOrder(1))
						BTQ->(DbGoTo( (cAliasQry)->BTQREC ))
						
						BR8->(DbSetOrder(1))
						BR8->(DbGoTo( (cAliasQry)->BR8REC ))
						
						if AllTrim(BTQ->BTQ_CDTERM) == AllTrim(BR8->BR8_CODPSA)
						
							nCont++
							
							Begin Transaction
							
								// marcar que possui vinculo na BTQ
								BTQ->(RecLock("BTQ", .F. ))
									BTQ->BTQ_HASVIN := '1'
								BTQ->(MsUnLock())
								
								// criar o vinculo
								Reclock("BTU", .T.)
									BTU->BTU_FILIAL	:= xFilial("BTU")
									BTU->BTU_CODTAB	:= cCodTab
									BTU->BTU_VLRSIS	:= xFilial("BR8") + BR8->(BR8_CODPAD+BR8_CODPSA)
									BTU->BTU_VLRBUS	:= BR8->BR8_CODPSA
									BTU->BTU_CDTERM	:= BTQ->BTQ_CDTERM
									BTU->BTU_ALIAS	:= "BR8"
								BTU->(MsUnlock())
							
							End Transaction
							
							cExtracao := "-;" + AllTrim(BTQ->BTQ_CDTERM) + ";Nao;Vinculo Terminologia x Tabela Padrao criado." + cEOL
							FWRITE ( nHdl2 , cExtracao )
						
						endif
						
						(cAliasQry)->(DbSkip())
					end
					dbselectarea(cAliasQry)
					(cAliasQry)->(dbclosearea())
				
				endif
				
			endif
		
		endif
		
	else
		Alert("Erro na abertura do arquivo. Processamento abortado!")
	endif

else
	Alert("Erro na cria็ใo do arquivo de log. Processamento abortado!")
endif

FCLOSE ( nHdl  )
FCLOSE ( nHdl2 )

return lErro
