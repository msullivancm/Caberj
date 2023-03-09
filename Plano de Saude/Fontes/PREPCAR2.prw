#INCLUDE 'PROTHEUS.CH'

#DEFINE cEnt chr(10)+chr(13)
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³PREPCAR2 ³ Autor ³ Angelo Henrique      ³ Data ³ 16/10/2015 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descrição ³ Rotina responsável por gerar os arquivos da carteirinha    ³±±
±±³          ³ em lotes separados por bairro                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ CABERJ                                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±³Parâmetros³ 1 - Nome do Arquivo original que foi gerado.               ³±±
±±³          ³ 2 - Array contendo os dados do arquivo                     ³±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
±±³Regras    ³ Preparar o arquivo da seguinte forma de regionalização:    ³±±
±±³          ³------------------------------------------------------------³±±
±±³          ³ Ag. Niterói:                                               ³±±
±±³          ³   - Centro, Santa Rosa, Icaraí, Barreto, Fonseca,          ³±±
±±³          ³     São Domingos e Ingá.                                   ³±±
±±³          ³------------------------------------------------------------³±±
±±³          ³ Ag. Centro RJ:                                             ³±±
±±³          ³   - Centro, Flamengo, Lapa, Santo Cristo, Glória.          ³±±
±±³          ³------------------------------------------------------------³±±
±±³          ³ Ag. Tijuca:                                                ³±±
±±³          ³   - Tijuca, Rio Comprido, Maracanã, Grajaú, Praça da       ³±±
±±³          ³     Bandeira, São Cristóvão.                               ³±±
±±³          ³------------------------------------------------------------³±±
±±³          ³ Ag. Bangu:                                                 ³±±
±±³          ³   - Bangu, Campo Grande.                                   ³±±
±±³          ³------------------------------------------------------------³±±
±±³          ³ Ag. Copacabana:                                            ³±±
±±³          ³   - Copacabana, Ipanema, Leblon, Leme, Botafogo.           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±± Alteração após as construções:                                          ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±Autor       ³Mateus Medeiros                    ³Data: 03/11/2017 	   ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±Desc. Alteração: Incluir preparação lote para envio pelos correios   	   ±±
±± de acordo com o fora parametrizado na BA3/BA1					   	   ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

User Function PREPCAR2(_cParam1, _aParam2)
	
	Local _aArea		:= GetArea()
	Local _aArBA1		:= BA1->(GetArea())
	Local _cAliasQry	:= GetNextAlias()
	Local _aCorreios    := {} //Vetor com dados que serão dos Correios - Mateus Medeiros - 03/11/2017
	Local _aAgNit		:= {} //Vetor com dados da agencia Niterói
	Local _aAgCet		:= {} //Vetor com dados da agencia Centro
	Local _aAgTij		:= {} //Vetor com dados da agencia Tijuca
	Local _aAgBng		:= {} //Vetor com dados da agencia Bangu
	Local _aAgCop		:= {} //Vetor com dados da agencia Copacabana
	Local _aGeral		:= {} //Vetor que irá receber os demais beneficiários que não estiverem contemplados nas regras de bairros
	Local _aLinha		:= {} //Vetor que recebe linha a linha do array proncipal
	Local _cMunic 		:= "" //Municipio do Títular
	Local _cBairr 		:= "" //Bairro do Títular
	Local _cQuery		:= ""
	Local _lBair		:= .F. //Validador dos bairros
	Local cEOL			:= CHR(13)+CHR(10)
	Local _cMatLt		:= ""
	Local _ni			:= 0
	Local _nx			:= 0
	Local nCont			:= 0
	
	//-----------------------------------------------------------
	//Variáveis utilizadas no momento da separação dos KIT's
	//-----------------------------------------------------------
	Local cCodint 		:=	""
	Local cCodemp 		:=	""
	Local cMatric 		:=	""
	Local cTipreg 		:=	""
	Local cConemp 		:=	""
	Local cVercon 		:=	""
	Local cSubcon 		:=	""
	Local cVersub 		:=	""
	Local cCodpla 		:=	""
	Local cVerpla 		:=	""
	Local cOpcional		:=	"0023"
	Local cVeropc		:=	"001"
	Local _cEstKit		:= ""
	Local cAliasBA3		:= GetNextAlias()
	//-----------------------------------------------------------
	
	Default _cParam1 	:= "" //Nome do Arquivo
	Default _aParam2 	:= {} //Array com os dados
	
	If Len(_aParam2) > 0
		
		For _ni := 1 To Len(_aParam2)
			
			_aLinha := StrTokArr( _aParam2[_ni], ";" )
			
			_lBair := .F.
			
			//--------------------------------------------------------------------------------------
			//Varrendo todo o vetor, pois em alguns casos a posição da matricula esta vindo trocada
			//--------------------------------------------------------------------------------------
			For _nx := 1 to Len(_aLinha)
				
				_cMatLt := Replace(Replace(_aLinha[_nx],".",""),"-","")
				
				If Len(_cMatLt) >= 14
								
					DbSelectArea("BA1")
					DbSetOrder(2)
					If DbSeek(xFilial("BA1")+_cMatLt)
						
						Exit
						
					EndIf
					
				EndIf
				
			Next
			
			DbSelectArea("BA1")
			DbSetOrder(2)
			If DbSeek(xFilial("BA1")+_cMatLt)
				
				//----------------------------------------------------
				//  Início válida Mateus Medeiros - 03/11/2017 
				//	Controle para verificar se o envio da carteira será 
				//  para os correios ou para as agências.
				// 1 - Correios / 2 - Agência - Criar campos na integral 
				//----------------------------------------------------								
				cQuery := " SELECT BA3_XENVCA,BA3_XAGENC					"+ cEnt
				cQuery += "  FROM  			  								"+ cEnt
				cQuery += "   "+RetSqlName("BA3")+" BA3						"+ cEnt
				cQuery += "  WHERE  BA3.BA3_FILIAL  = '"+xFilial("BA3")+"'  "+ cEnt
				cQuery += "    AND BA3.BA3_CODINT  = '"+BA1->BA1_CODINT+"'  "+ cEnt
				cQuery += "    AND BA3.BA3_CODEMP  = '"+BA1->BA1_CODEMP+"'	"+ cEnt
				cQuery += "    AND BA3.BA3_MATRIC  = '"+BA1->BA1_MATRIC+"' 	"+ cEnt
				cQuery += "    AND D_E_L_E_T_ = ' '				 			"+ cEnt
				
				PlsQuery(cQuery,cAliasBA3)
				
				if (cAliasBA3)->(!Eof())
					cOpEnv      :=  (cAliasBA3)->BA3_XENVCA
					cAgenc      :=  (cAliasBA3)->BA3_XAGENC
				endif
				
				if select(cAliasBA3) > 0
					dbselectarea(cAliasBA3)
					(cAliasBA3)->(DbcloseArea())
				endif
				//----------------------------------------------------
				// Fim - Mateus Medeiros - 03/11/2017
				//----------------------------------------------------
				
				//----------------------------------------------------
				//Se for dependente deve olhar o endereço do títular
				//----------------------------------------------------
				If AllTrim(UPPER(BA1->BA1_TIPUSU)) = "T" //Títular
					
					_cMunic 	:= BA1->BA1_MUNICI
					_cBairr 	:= BA1->BA1_BAIRRO
					_cEstad 	:= BA1->BA1_ESTADO
					cCodint 	:= BA1->BA1_CODINT
					cCodemp 	:= BA1->BA1_CODEMP
					cMatric 	:= BA1->BA1_MATRIC
					cTipreg 	:= BA1->BA1_TIPREG
					cConemp 	:= BA1->BA1_CONEMP
					cVercon 	:= BA1->BA1_VERCON
					cSubcon 	:= BA1->BA1_SUBCON
					cVersub 	:= BA1->BA1_VERSUB
					cCodpla 	:= BA1->BA1_CODPLA
					cVerpla 	:= BA1->BA1_VERSAO
			
				Else
					
					//-----------------------------------------------------------------------------------------------------------
					//Query para buscar o títular e assim pegar o endereço correto
					//-----------------------------------------------------------------------------------------------------------
					_cQuery := " SELECT BA1_MUNICI, BA1_BAIRRO, BA1_ESTADO, BA1_CODINT, BA1_CODEMP, BA1_MATRIC, BA1_TIPREG, "
					_cQuery += " BA1_CONEMP, BA1_VERCON, BA1_SUBCON, BA1_VERSUB, BA1_CODPLA, BA1_VERSAO "
					_cQuery += " FROM " + RetSqlName("BA1") + " BA1 "
					_cQuery += " WHERE D_E_L_E_T_ 	= ' ' "
					_cQuery += " AND BA1_FILIAL  	= '" + xFilial("BA1")	+ "' "
					_cQuery += " AND BA1_CODINT 	= '" + BA1->BA1_CODINT	+ "' "
					_cQuery += " AND BA1_CODEMP 	= '" + BA1->BA1_CODEMP	+ "' "
					_cQuery += " AND BA1_MATRIC 	= '" + BA1->BA1_MATRIC	+ "' "
					_cQuery += " AND BA1_TIPUSU 	= 'T' " //TITULAR
					
					If Select(_cAliasQry)>0
						(_cAliasQry)->(DbCloseArea())
					EndIf
					
					DbUseArea(.T.,"TopConn",TcGenQry(,,_cQuery),_cAliasQry,.T.,.T.)
					
					DbSelectArea(_cAliasQry)
					
					If !((_cAliasQry)->(Eof()))
						
						_cMunic := (_cAliasQry)->BA1_MUNICI
						_cBairr := (_cAliasQry)->BA1_BAIRRO
						_cEstad := (_cAliasQry)->BA1_ESTADO
						cCodint :=	(_cAliasQry)->BA1_CODINT
						cCodemp :=	(_cAliasQry)->BA1_CODEMP
						cMatric :=	(_cAliasQry)->BA1_MATRIC
						cTipreg :=	(_cAliasQry)->BA1_TIPREG
						cConemp :=	(_cAliasQry)->BA1_CONEMP
						cVercon :=	(_cAliasQry)->BA1_VERCON
						cSubcon :=	(_cAliasQry)->BA1_SUBCON
						cVersub :=	(_cAliasQry)->BA1_VERSUB
						cCodpla :=	(_cAliasQry)->BA1_CODPLA
						cVerpla :=	(_cAliasQry)->BA1_VERSAO
						
					EndIf
					
					If Select(_cAliasQry)>0
						(_cAliasQry)->(DbCloseArea())
					EndIf
					
				EndIf
				
				_cEstKit := "RIO DE JANEIRO|NITEROI|BELFORD ROXO|DUQUE DE CAXIAS|NILOPOLIS|NOVA IGUACU|SAO GONCALO|SAO JOAO DE MERITI"
				
				//--------------------------------------------------------------------------------------------------------------------------
				//Rotina utilizada para validar se o beneficiário possui ADU
				//--------------------------------------------------------------------------------------------------------------------------
				If u_ChkOpc(cCodint, cCodemp, cMatric, cTipreg, cConemp, cVercon, cSubcon, cVersub, cCodpla, cVerpla, cOpcional, cVeropc) .And. AllTrim(Upper(_cMunic)) $ _cEstKit
					
					_aParam2[_ni] += "; KIT 1"
					
				Else
					
					If AllTrim(Upper(_cEstad)) == "RJ"
						
						_aParam2[_ni] += "; KIT 2"
						
					Else
						
						_aParam2[_ni] += "; KIT 3"
						
					EndIf
					
				EndIf
				//--------------------------------------------------------------
				
				
					
				//-----------------------------------------------------
				//Alimentar os vetores corretos por municipio e bairro
				//Gerando assim arquivos separados
				//-----------------------------------------------------
				
				//-----------------------------------------------------
				// Inicio - Mateus Medeiros - 03/11/17 - para atender
				// as necessidades do chamado 42784 
				//-----------------------------------------------------
				
				if cOpEnv == '2' // Entrega nas Agencias
			
					//If AllTrim(Upper(_cMunic)) == "RIO DE JANEIRO"
						
						//If AllTrim(Upper(_cBairr)) $ "CENTRO|FLAMENGO|LAPA|SANTO CRISTO|GLORIA"
					If AllTrim(Upper(cAgenc)) == '1' // Agencia Centro
							
						aAdd(_aAgCet,_aParam2[_ni])
						_lBair := .T.
						                                                                                         	
//						ElseIf AllTrim(Upper(_cBairr)) $ "TIJUCA|RIO COMPRIDO|MARACANA|GRAJAU|PRACA DA BANDEIRA|SAO CRISTOVAO"
					ElseIf AllTrim(Upper(cAgenc)) == '2' // Agencia Tijuca
						
						aAdd(_aAgTij,_aParam2[_ni])
						_lBair := .T.
							
//						ElseIf AllTrim(Upper(_cBairr)) $ "COPACABANA|IPANEMA|LEBLON|LEME|BOTAFOGO"
					ElseIf AllTrim(Upper(cAgenc)) == '3' // Agencia Copacabana
						
						aAdd(_aAgCop,_aParam2[_ni])
						_lBair := .T.
						
							
						/*ElseIf AllTrim(Upper(_cBairr)) $ "BANGU|CAMPO GRANDE|CPO GRANDE" //Cadastrado na BA1 CAMPO GRANDE ERRADO (CPO GRANDE)
						ElseIf AllTrim(Upper(cAgenc)) == '2' // Agencia Centro	
							aAdd(_aAgBng,_aParam2[_ni])
							_lBair := .T.
							
						EndIf*/
						
//						ElseIf AllTrim(Upper(_cMunic)) == "NITEROI"
					ElseIf AllTrim(Upper(cAgenc)) == '4' // Agencia NITEROI
//						If AllTrim(Upper(_cBairr)) $ "CENTRO|SANTA ROSA|ICARAI|BARRETO|FONSECA|SAO DOMINGOS|INGA"
							
						aAdd(_aAgNit,_aParam2[_ni])
						_lBair := .T.
							
					EndIf
						
//					EndIf
				
				endif
				
				//------------------------------------------------------------------------------
				// Fim Mateus Medeiros - 03/11/2017 - Chamado 42784
				//------------------------------------------------------------------------------
				//Caso não tenha entrado em nenhuma das validações deverá gerar outro arquivo
				//------------------------------------------------------------------------------
				If !_lBair // Entrega pelos correios
					
					
					aAdd(_aGeral,_aParam2[_ni])
					
				EndIf
				
			EndIf
			
		Next _ni
		
	EndIf
	
	//----------------------------------------------
	//Inicio do processo de criação dos arquivos
	//separados, após a alimentação dos vetores
	//----------------------------------------------
	
	cLin := Space(1)+cEOL
	
	//-------------------------
	//Varrendo vetor niterói
	//-------------------------
	If Len(_aAgNit) > 0
		
		If U_Cria_TXT(SUBSTR(_cParam1,1,Len(_cParam1)-4) + "_niteroi.txt")
			
			ProcRegua(Len(_aAgNit))
			
			For nCont := 1 to Len(_aAgNit)
				
				IncProc('Gravando Arquivo Niteroi...')
				
				If !(U_GrLinha_TXT(_aAgNit[nCont],cLin))
					
					MsgAlert("ATENÇÃO! NÃO FOI POSSÍVEL GRAVAR CORRETAMENTE O CONTEÚDO DAS INFORMAÇÕES PARA NITERÓI! OPERAÇÃO ABORTADA!")
					Exit
					
				Endif
				
			Next nCont
			
			U_Fecha_TXT()
			
		Endif
		
	EndIf
	
	//-------------------------
	//Varrendo vetor Centro
	//-------------------------
	If Len(_aAgCet) > 0
		
		If U_Cria_TXT(SUBSTR(_cParam1,1,Len(_cParam1)-4) + "_centro.txt")
			
			ProcRegua(Len(_aAgCet))
			
			For nCont := 1 to Len(_aAgCet)
				
				IncProc('Gravando Arquivo Centro...')
				
				If !(U_GrLinha_TXT(_aAgCet[nCont],cLin))
					
					MsgAlert("ATENÇÃO! NÃO FOI POSSÍVEL GRAVAR CORRETAMENTE O CONTEÚDO DAS INFORMAÇÕES PARA CENTRO! OPERAÇÃO ABORTADA!")
					Exit
					
				Endif
				
			Next nCont
			
			U_Fecha_TXT()
			
		Endif
		
	EndIf
	
	//-------------------------
	//Varrendo vetor Tijuca
	//-------------------------
	If Len(_aAgTij) > 0
		
		If U_Cria_TXT(SUBSTR(_cParam1,1,Len(_cParam1)-4) + "_tijuca.txt")
			
			ProcRegua(Len(_aAgTij))
			
			For nCont := 1 to Len(_aAgTij)
				
				IncProc('Gravando Arquivo Tijuca...')
				
				If !(U_GrLinha_TXT(_aAgTij[nCont],cLin))
					
					MsgAlert("ATENÇÃO! NÃO FOI POSSÍVEL GRAVAR CORRETAMENTE O CONTEÚDO DAS INFORMAÇÕES PARA TIJUCA! OPERAÇÃO ABORTADA!")
					Exit
					
				Endif
				
			Next nCont
			
			U_Fecha_TXT()
			
		Endif
		
	EndIf
	
	//-------------------------
	//Varrendo vetor Bangu
	//-------------------------
	If Len(_aAgBng) > 0
		
		If U_Cria_TXT(SUBSTR(_cParam1,1,Len(_cParam1)-4) + "_bangu.txt")
			
			ProcRegua(Len(_aAgBng))
			
			For nCont := 1 to Len(_aAgBng)
				
				IncProc('Gravando Arquivo Bangu...')
				
				If !(U_GrLinha_TXT(_aAgBng[nCont],cLin))
					
					MsgAlert("ATENÇÃO! NÃO FOI POSSÍVEL GRAVAR CORRETAMENTE O CONTEÚDO DAS INFORMAÇÕES PARA BANGU! OPERAÇÃO ABORTADA!")
					Exit
					
				Endif
				
			Next nCont
			
			U_Fecha_TXT()
			
		Endif
		
	EndIf
	
	//-------------------------
	//Varrendo vetor Copacabana
	//-------------------------
	If Len(_aAgCop) > 0
		
		If U_Cria_TXT(SUBSTR(_cParam1,1,Len(_cParam1)-4) + "_copacabana.txt")
			
			ProcRegua(Len(_aAgCop))
			
			For nCont := 1 to Len(_aAgCop)
				
				IncProc('Gravando Arquivo Copacabana...')
				
				If !(U_GrLinha_TXT(_aAgCop[nCont],cLin))
					
					MsgAlert("ATENÇÃO! NÃO FOI POSSÍVEL GRAVAR CORRETAMENTE O CONTEÚDO DAS INFORMAÇÕES PARA COPACABANA! OPERAÇÃO ABORTADA!")
					Exit
					
				Endif
				
			Next nCont
			
			U_Fecha_TXT()
			
		Endif
		
	EndIf
	
	//-------------------------
	//Varrendo vetor Geral
	//-------------------------
	If Len(_aGeral) > 0
		
		If U_Cria_TXT(SUBSTR(_cParam1,1,Len(_cParam1)-4) + "_geral.txt")
			
			ProcRegua(Len(_aGeral))
			
			For nCont := 1 to Len(_aGeral)
				
				IncProc('Gravando Arquivo Geral...')
				
				If !(U_GrLinha_TXT(_aGeral[nCont],cLin))
					
					MsgAlert("ATENÇÃO! NÃO FOI POSSÍVEL GRAVAR CORRETAMENTE O CONTEÚDO DAS INFORMAÇÕES GERAIS! OPERAÇÃO ABORTADA!")
					Exit
					
				Endif
				
			Next nCont
			
			U_Fecha_TXT()
			
		Endif
		
	EndIf
	
	
	RestArea(_aArBA1)
	RestArea(_aArea)
	
Return