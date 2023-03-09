#Include "Protheus.ch" //Include conforme o exemplo no TDN (http://tdn.totvs.com.br/kbm#111079)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³ Rdmake    ³PLSXMLLIB ³ Autor ³ Alexander Santos	              ³ Data ³ 19.07.2007 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Descri‡„o ³ Rdmake para retornar o numero da libercao		      				  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function PLSXMLLIB

Local cNumAut 	:= AllTrim( paramixb[1] )

//Leonardo Portella - 16/11/11 - Inicio

Local cOpeMov 	:= Alltrim(paramixb[2])
Local cRDA		:= Alltrim(paramixb[3])
Local cNumSen	:= PadR(Alltrim(paramixb[4]),TamSX3('BEA_SENHA')[1])
Local cSolicInt	:= Alltrim(paramixb[5])
Local cTipGui	:= Alltrim(paramixb[6])
Local cMatric	:= Alltrim(paramixb[7])
Local cGuiPrinc	:= Alltrim(paramixb[8])
Local lHonor	:= paramixb[9]//Se eh um honorario
Local lEvolu	:= paramixb[10]//Se eh uma prorrogacao de internacao
Local aArea 	:= GetArea()
Local aAreaBEA	:= BEA->(GetArea())
Local aAreaBD7	:= BD7->(GetArea())
Local aAreaBE4	:= BE4->(GetArea())
Local cPEGGuia	:= " "
Local lAchouBD7	:= .F.
Local lAchouBEA	:= .F.
Local bFiltroBEA:= {||}

If !empty(cNumSen)

	BEA->(DbSetOrder(14))//Indice E = 14 -> BEA_FILIAL  +  BEA_SENHA
	BEA->(DbGoTop())
	
	//Procuro pela senha
	lAchouBEA := BEA->(DbSeek(xFilial('BEA') + cNumSen))
	
	If lAchouBEA
		bFiltroBEA := {||BEA->(BEA_FILIAL + BEA_SENHA) == xFilial('BEA') + cNumSen}
	Else
		BEA->(DbSetOrder(1))//BEA_FILIAL + BEA_OPEMOV + BEA_ANOAUT + BEA_MESAUT + BEA_NUMAUT + DTOS(BEA_DATPRO) + BEA_HORPRO
		BEA->(DbGoTop())
	
		cNumSen	:= PadR(Alltrim(cNumSen),TamSX3('BEA_OPEMOV')[1] + TamSX3('BEA_ANOAUT')[1] + TamSX3('BEA_MESAUT')[1] + TamSX3('BEA_NUMAUT')[1] )
	
		//Procuro pelo numero da autorizacao
		lAchouBEA := BEA->(DbSeek(xFilial('BEA') + cNumSen))
	
		If lAchouBEA
			bFiltroBEA := {||BEA->(BEA_FILIAL + BEA_OPEMOV + BEA_ANOAUT + BEA_MESAUT + BEA_NUMAUT) == xFilial('BEA') + cNumSen}
		EndIf
	EndIf
	
	While lAchouBEA .and. !BEA->(EOF()) .and. Eval(bFiltroBEA)
	
	    //Verifico se a senha encontrada eh do RDA e do Beneficiario
		If ( cMatric == BEA->( BEA_OPEUSR + BEA_CODEMP + BEA_MATRIC + BEA_TIPREG + BEA_DIGITO ) ) .and. ( cRDA == BEA->BEA_CODRDA )
	
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Conforme o chamado TEMOAK, o retorno esperado para o ponto de entrada               ³
			//³PLSXMLLIB eh BEA_OPEMOV + BEA_ANOAUT + BEA_MESAUT + BEA_NUMAUT,                     ³
			//³alem disso chamado para todas as operacoes, e nao somente em Honorario (lHonor) e   ³
			//³Evolucao (lEvolu). Ainda conforme o chamado TEMOAK, o ponto de entrada nao eh so    ³
			//³usado em Linux.                                                                     ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	
			cNumAut		:= BEA->(BEA_OPEMOV + BEA_ANOAUT + BEA_MESAUT + BEA_NUMAUT)
			cPEGGuia	:= BEA->(BEA_OPEMOV + BEA_CODLDP + BEA_CODPEG + BEA_NUMGUI)
	
			BE4->(DbSetOrder(1))//BE4_FILIAL + BE4_CODOPE + BE4_CODLDP + BE4_CODPEG + BE4_NUMERO + BE4_SITUAC + BE4_FASE
			BE4->(DbGoTop())        
			
			//Leonardo Portella - 05/11/13 - Inicio - Virada P11 - Importacao no local 0016 nao sera utilizada
			
			lAchouBE4 := BE4->(DbSeek(xFilial('BE4') + cPEGGuia + '1'/*ATIVA*/))
			/*
			If ( lAchouBE4 := BE4->(DbSeek(xFilial('BE4') + cPEGGuia + '1')) )
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³BE4_XTISS         ³
				//³1-1:Honorario     ³
				//³2-2:Evolucao      ³
				//³3-3:Tipo Fat.     ³
				//³4-11:Dt alta ori. ³
				//³12-17:Hr alta ori.³
				//³18-25:Dt alta XML ³
				//³26-31:Hr alta XML ³
				//³32-39:Dt Proc XML ³
				//³40-45:Hr Proc XML ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				cXTISS := If(lHonor,'S','N') + If(lEvolu,'S','N') + ' ' + PadR(DtoS(BE4->BE4_DTALTA),8) + PadR(BE4->BE4_HRALTA,8) + Space(30)
				
				BE4->(Reclock('BE4',.F.))
				BE4->BE4_XTISS := cXTISS 
				BE4->(MsUnlock())
			EndIf
	        */
	        
	        //Leonardo Portella - 05/11/13 - Fim
	        
			If lAchouBE4 .and. !lHonor .and. !lEvolu          
	
				If BE4->BE4_FASE <> '4'//Nao esta faturada
	
					BD7->(DbSetOrder(2))//BD7_FILIAL + BD7_CODOPE + BD7_CODLDP + BD7_CODPEG + BD7_NUMERO + BD7_ORIMOV + BD7_CODPAD + BD7_CODPRO + BD7_CODUNM + BD7_NLANC
	
					If BD7->(DbSeek(xFilial('BD7') + cPEGGuia))
	
						While !BD7->(EOF()) .and. ( BD7->(BD7_FILIAL + BD7_CODOPE + BD7_CODLDP + BD7_CODPEG + BD7_NUMERO) == xFilial('BD7') + cPEGGuia )
	
							If ( BD7->BD7_SITUAC == '1'/*ATIVA*/ ) .and. ( BD7->BD7_BLOPAG <> '1' /*Nao esta bloqueado pagamento*/)
	
								If  !( BD7->BD7_CODTPA $ ' |0')
									BD7->(Reclock('BD7',.F.))
									BD7->BD7_CODTPA := " "//Validacao do PLSVLDINB6 no PLSXMOV. BD7_CODTPA tem que ser " " ou "0"
									BD7->(MsUnlock()) 
								EndIf
	
							EndIf
	
							BD7->(DbSkip())
	
						EndDo
					
					EndIf
					
					//Leonardo Portella - 05/11/13 - Inicio - Virada P11 - Importacao no local 0016 nao sera utilizada
					/*
					BE4->(Reclock('BE4',.F.))
					BE4->BE4_DTALTA 	:= CtoD("")
					BE4->BE4_HRALTA 	:= Space(TamSX3('BE4_HRALTA')[1])
					BE4->BE4_ARQIMP 	:= Space(TamSX3('BE4_ARQIMP')[1])
					BE4->BE4_LOTGUI	 	:= Space(TamSX3('BE4_LOTGUI')[1])
					BE4->(MsUnlock())
					
					BEA->(Reclock('BEA',.F.))
					BEA->BEA_ARQIMP 	:= Space(TamSX3('BEA_ARQIMP')[1])
					BEA->BEA_LOTGUI 	:= Space(TamSX3('BEA_LOTGUI')[1])
					BEA->(MsUnlock())
					*/
					//Leonardo Portella - 05/11/13 - Fim
			
				EndIf
	
			EndIf
	
			//Ja encontrei a BEA com mesma matricula e RDA, logo devo sair do While
			exit
	
		EndIf
	
		BEA->(DbSkip())
	
	EndDo

EndIf
	
BEA->(RestArea(aAreaBEA))
BD7->(RestArea(aAreaBD7))
BE4->(RestArea(aAreaBE4))
RestArea(aArea)

//Leonardo Portella - 16/11/11 - Fim

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Fim da Rotina															 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

Return cNumAut