#INCLUDE "TOPCONN.CH"

#DEFINE CRLF CHR(13) + CHR(10)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³PLSCOMEV  ºAutor  ³ Jean Schulz        º Data ³  18/03/08   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Ponto de entrada para tratar valor apresentado = pago. Caso º±±
±±º          ³nao seja apresentado valor, nao pagar nada.                 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function PLSCOMEV
	
LOCAL aCompoOrig  	:= paramixb[1] //a composicao do evento original, que pode ser alterada neste ponto de entrada
LOCAL cCodPad     	:= paramixb[3] //Codigo tipo de procedimento (01,02,etc)
LOCAL cCodPro     	:= paramixb[4] //Codigo do procedimento
LOCAL lVlrApr     	:= .F.
LOCAL nFor
Local aArea   		:= GetArea()
Local aAreaBAU 		:= BAU->(GetArea()) //Leonardo Portella - 28/08/12
Local lReaprPR		:= .F. //Leonardo Portella - 13/04/16
Local _aAreaBD6		:= BD6->(GetArea()) //Angelo Henrique - Data:02/09/2015
Local _aAreaBD7		:= BD7->(GetArea()) //Angelo Henrique - Data:02/09/2015
Local cQrPr 		:= ''
Local nVlrUS 		:= 0
Local aVetUS 		:= {}
Local aCompoRecip	:= paramixb[1]

if !(Alltrim(FunName()) $ "PLSA001|PLSA001A")	// não entrar se for reembolso

	//Leonardo Portella - 28/08/12 - Inicio - Ponteirar no RDA pois estava glosando reciprocidade - Chamado ID 3110
	BAU->(DbSetOrder(1))//BAU_FILIAL + BAU_CODIGO
	BAU->(MsSeek(xFilial('BAU') + BD6->BD6_CODRDA))
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Conforme regra Caberj, caso prestador de intercambio, aceitar o valor cobrado...|
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	// Este parametro MV_YOPAVLC guarda os codigos de Operadora (BA0) de Intercambio

	//Bianchini - 18/03/2019 - Ajuste no bloqueio de Composicoes para negociacoes
	If BAU->(Found()) .and. cCodPad + cCodPro == BD6->(BD6_CODPAD + BD6_CODPRO) .and. EMPTY(BD6->BD6_NUMLOT)
	
		//BAU->BAU_CODOPE $ GetNewPar("MV_YOPAVLC","")  .and. ;
		//Leonardo Portella - 13/04/16 - Início - Guias de reapresentação PR não devem ser glosadas. A guias elegíveis ao PR
		//são guias em fase pronta e conferidas na fase 3.5, logo as guias de reapresentação geradas pela Caberj (rotina Web
		//do Alexandre) também estão Ok e não devem ser glosadas.
		
		If 	( cEmpAnt == '01' ) 						.and. ;
				( BCI->BCI_CODLDP == '0002' ) 				.and. ;
				( BCL->BCL_ALIAS == 'BD5' ) 				.and. ;
				( Left(AllTrim(BD5->BD5_NUMIMP),2) == 'PR' )
			
			aArPR		:= GetArea()
			aAliasPR 	:= GetNextAlias()
			
			cQrPr		:= "SELECT 1" 																						+ CRLF
			cQrPr		+= "FROM RECIPR_GUIA" 																				+ CRLF
			cQrPr		+= "WHERE EMPRESA = '" + IIF(cEmpAnt == '01','CABERJ','INTEGRAL') + "'" 								+ CRLF
			cQrPr		+= "	AND IDLOTE = " + cValToChar(Val(Left(BCI->BCI_ARQUIV,20))) 									+ CRLF
			cQrPr		+= "	AND OPERADORA = 'REAPRES_PR'" 																+ CRLF
			cQrPr		+= "	AND ALFA_NUM_EXCECAO_PARAMETRO(NUMEROGUIAPRESTADOR) = '" + AllTrim(BD5->BD5_NUMIMP) + "'" 	+ CRLF
			
			TcQuery cQrPr New Alias aAliasPR
			
			lReaprPR 	:= !aAliasPR->(EOF())
			
			aAliasPR->(DbCloseArea())
			
			RestArea(aArPR)
			
		EndIf
		
		//Leonardo Portella - 13/04/16 - Fim
	
		If 	lReaprPR .or. ( ( AllTrim(BD6->BD6_DESBPF) == "RATEIO INTERNISTAS" ) .or. ( BD6->BD6_CODLDP == '0017' ) )  .or.;
				 ( ( cEmpAnt == '02' ) .and. ( BAU->BAU_CODIGO == '999997'/*RDA repasse Caberj/Integral*/ ) )
			
			If BD6->BD6_VLRAPR > 0
				lVlrApr := .T.
			Else
				cSQL := "SELECT COUNT(BD7_FILIAL) AS QTD FROM "+RetSQLName("BD7")+" WHERE "
				cSQL += "BD7_FILIAL = '"+xFilial("BD7")+"' AND "
				cSQL += "BD7_CODOPE = '"+BD6->BD6_CODOPE+"' AND "
				cSQL += "BD7_CODLDP = '"+BD6->BD6_CODLDP+"' AND "
				cSQL += "BD7_CODPEG = '"+BD6->BD6_CODPEG+"' AND "
				cSQL += "BD7_NUMERO = '"+BD6->BD6_NUMERO+"' AND "
				cSQL += "BD7_ORIMOV = '"+BD6->BD6_ORIMOV+"' AND "
				cSQL += "BD7_SEQUEN = '"+BD6->BD6_SEQUEN+"' AND "
				cSQL += "D_E_L_E_T_ = ' ' AND "
				cSQL += "BD7_VLRAPR > 0 "
				PLSQuery(cSQL,"TrbBD7Aux")
				
				If TrbBD7Aux->QTD > 0
					lVlrApr := .T.
				Endif
				
				TrbBD7Aux->(DbCloseArea())
			Endif

			//PRIMEIRO PROCURA O VALOR DE US DOS PARAMETROS MENSAIS
		
			cSQL := "SELECT NVL(BFM_VALRDA,0) AS USPAG FROM "+RetSQLName("BFM")+" WHERE "
			cSQL += "BFM_FILIAL = '"+xFilial("BFM")+"' AND "
			cSQL += "BFM_ANO||BFM_MES = '" + SUBSTR(DTOS(BD6->BD6_DATPRO),1,6) + "' AND "
			cSQL += "D_E_L_E_T_ = ' ' "

			PLSQuery(cSQL,"TrbBFMAux")
		
			If TrbBFMAux->USPAG <> 0
				For nFor := 1 To Len(aCompoOrig)
					
					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³--Composicao (aCompoOri[nFor])                                              ³
					//³Cada aRet[X] e composto da seguinte maneira:                                ³
					//³                                                                            ³
					//³aRet[X][1]  - BD4->BD4_CODIGO (Un.Med.Valor - BD3)                          ³
					//³aRet[X][2]  - Str(BD3->BD3_ORDEM) (Ordem Prior.)                            ³
					//³aRet[X][3]  - valor de referencia,                                          ³
					//³aRet[X][4]  - BD4->BD4_VLMED (Valor Medio )                                 ³
					//³aRet[X][5]  - BD4->BD4_PERACI (% Acima Aud.)                                ³
					//³aRet[X][6]  - BD3->BD3_RDMAKE (Expr. AdvPl)                                 ³
					//³aRet[X][7]  - BD3->BD3_UNIDAD (Unidade)                                     ³
					//³aRet[X][8]  - BD3->BD3_TIPVAL (Tipo de Valorizacao: 1=Calculada;2=Informada)³
					//³aRet[X][9]  - considera fator multiplicador ? ( '0' nao '1' sim )           ³
					//³aRet[X][10] - considera horario especial ? ( '0' nao '1' sim )              ³
					//³aRet[X][11] - considera horario banda ? ( '0' nao '1' sim )                 ³
					//³aRet[X][12] - considera porte medico ? ( '0' nao '1' sim )                  ³
					//³aRet[X][13] - bloqueia o pagamento ? ( '0' nao '1' sim )                    ³
					//³aRet[X][14] - cConsVia													   ³
					//³aRet[X][15] - cCodTab                                                       ³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

					//Fabio Bianchini - 12/02/2019 - Chamado 55893 - Colocado este IF para não sobrepor as composições de 
					//								 Instrumentador nem de Auxiliares.  Quando se tem mais de um Auxiliar 
					//								 ou Instrumentador, o trecho abaixo estava transformando em apenas 1 auxiliar/instrumentador
					If !(AllTrim(BD7->BD7_CODUNM) $ "AUX|INS")				
					//Leonardo Portella - 28/08/12 - Inicio - Informar o valor a referencia como o valor apresentado, pois estava glosando reciprocidade - Chamado ID 3110
						//aCompoOrig[nFor][3]  	:= IIF(lVlrApr,BD6->BD6_VLRAPR,BD6->BD6_VLRBPF)
						aCompoOrig[nFor][3]  	:= IIF(lVlrApr,BD6->BD6_VLRAPR * BD6->BD6_QTDPRO,BD6->BD6_VLRBPF)
						aCompoOrig[nFor][4]  	:= 0
						aCompoOrig[nFor][5]  	:= 0
						aCompoOrig[nFor][6]  	:= 'PLSRETREA'
						aCompoOrig[nFor][7]  	:= 'R$'
						aCompoOrig[nFor][8]  	:= '2'
						aCompoOrig[nFor][9]  	:= '0'
						aCompoOrig[nFor][10]  	:= '0'
						aCompoOrig[nFor][11]  	:= '0'
						aCompoOrig[nFor][12]  	:= '0'
						aCompoOrig[nFor][13]  	:= '0'
					Endif
					//Leonardo Portella - 28/08/12 - Fim

					//BIANCHINI - 22/05/2019 - Retirado para avaliar erros de copart, principalmente em convenios
					//                         O BD6_VLRMAN compoe o valor do pagamento 
					
					BD6->(Reclock("BD6",.F.))
					If ! lVlrApr
						//CALCULO TEMPORARIO PARA VALOR DO PROCEDIMENTO
						nTempVlrPro := aCompoOrig[nFor,3] * TrbBFMAux->USPAG
						BD6->BD6_VLRPAG := nTempVlrPro * BD6->BD6_QTDPRO
						BD6->BD6_VLRBPR := nTempVlrPro * BD6->BD6_QTDPRO
						BD6->BD6_VLRAPR := nTempVlrPro
						BD6->BD6_VLRMAN := nTempVlrPro * BD6->BD6_QTDPRO
						BD6->BD6_VLRBPF := nTempVlrPro * BD6->BD6_QTDPRO
					Else
						BD6->BD6_VLRGLO := 0
						BD6->BD6_VLRPAG := BD6->BD6_VLRAPR * BD6->BD6_QTDPRO
						BD6->BD6_VLRBPR := BD6->BD6_VLRAPR * BD6->BD6_QTDPRO
						BD6->BD6_VLRAPR := BD6->BD6_VLRAPR 
						BD6->BD6_VLRMAN := BD6->BD6_VLRAPR * BD6->BD6_QTDPRO
						BD6->BD6_VLRBPF := BD6->BD6_VLRAPR * BD6->BD6_QTDPRO
					Endif
					BD6->(MsUnlock())
				Next
			Endif
			TrbBFMAux->(DbCloseArea())
		EndIf
	Endif

	//BIANCHINI - 29/01/2021 - Na P12R27 quando o RDA é amarrado a uma operadora ou o Beneficiario 
	//                         é de uma operadora origem, o sistema só pega valores de Grupo Operadora
	//                         A TOTVS orientou a criar o PE PLSONVPC, que não funciona
	If BAU->(Found()) .and. (BAU->BAU_CODOPE $ GetNewPar("MV_YOPAVLC","") .or. (cEmpAnt == '01' .and. BD6->BD6_CODEMP $ '0004|0009') )  .and. ;
			cCodPad + cCodPro == BD6->(BD6_CODPAD + BD6_CODPRO) .and. EMPTY(BD6->BD6_NUMLOT)

		cSQL := "SELECT NVL(BFM_VALRDA,0) AS USPAG FROM "+RetSQLName("BFM")+" WHERE "
		cSQL += "BFM_FILIAL = '"+xFilial("BFM")+"' AND "
		cSQL += "BFM_ANO||BFM_MES = '" + SUBSTR(DTOS(BD6->BD6_DATPRO),1,6) + "' AND "
		cSQL += "D_E_L_E_T_ = ' ' "

		PLSQuery(cSQL,"TrbBFMAux")
	
		If TrbBFMAux->USPAG <> 0
			nVlrUS := TrbBFMAux->USPAG
		Endif

		TrbBFMAux->(DbCloseArea()) 
		
		aVetUS := u_BuscaCH()

		For nFor := 1 To Len(aCompoRecip)
			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³--Composicao (aCompoRecip[nFor])                                              ³
			//³Cada aRet[X] e composto da seguinte maneira:                                ³
			//³                                                                            ³
			//³aRet[X][1]  - BD4->BD4_CODIGO (Un.Med.Valor - BD3)                          ³
			//³aRet[X][2]  - Str(BD3->BD3_ORDEM) (Ordem Prior.)                            ³
			//³aRet[X][3]  - valor de referencia,                                          ³
			//³aRet[X][4]  - BD4->BD4_VLMED (Valor Medio )                                 ³
			//³aRet[X][5]  - BD4->BD4_PERACI (% Acima Aud.)                                ³
			//³aRet[X][6]  - BD3->BD3_RDMAKE (Expr. AdvPl)                                 ³
			//³aRet[X][7]  - BD3->BD3_UNIDAD (Unidade)                                     ³
			//³aRet[X][8]  - BD3->BD3_TIPVAL (Tipo de Valorizacao: 1=Calculada;2=Informada)³
			//³aRet[X][9]  - considera fator multiplicador ? ( '0' nao '1' sim )           ³
			//³aRet[X][10] - considera horario especial ? ( '0' nao '1' sim )              ³
			//³aRet[X][11] - considera horario banda ? ( '0' nao '1' sim )                 ³
			//³aRet[X][12] - considera porte medico ? ( '0' nao '1' sim )                  ³
			//³aRet[X][13] - bloqueia o pagamento ? ( '0' nao '1' sim )                    ³
			//³aRet[X][14] - cConsVia													   ³
			//³aRet[X][15] - cCodTab                                                       ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
													
			If (AllTrim(aCompoRecip[nFor][1]) $ "HM")	 					
				//aCompoRecip[nFor][3]  	:= IIF(aVetUS[1][1] > 0,(aVetUS[1][1]*aCompoRecip[nFor][3])*BD6->BD6_QTDPRO,IIF(aVetUS[1][2] > 0,aVetUS[1][2]*BD6->BD6_QTDPRO,(aCompoRecip[nFor][3]*nVlrUS)*BD6->BD6_QTDPRO))          
				aCompoRecip[nFor][3]  	:= IIF(aVetUS[1][1] > 0,(aVetUS[1][1]*aCompoRecip[nFor][3]),IIF(aVetUS[1][2] > 0,aVetUS[1][2],(aCompoRecip[nFor][3]*nVlrUS)))          
				aCompoRecip[nFor][4]  	:= 0
				aCompoRecip[nFor][5]  	:= 0
				aCompoRecip[nFor][6]  	:= 'PLSRETREA'
				aCompoRecip[nFor][7]  	:= 'R$'
				/*aCompoRecip[nFor][8]  	:= '2'
				aCompoRecip[nFor][9]  	:= '0'
				aCompoRecip[nFor][10]  	:= '0'
				aCompoRecip[nFor][11]  	:= '0'
				aCompoRecip[nFor][12]  	:= '0'
				aCompoRecip[nFor][13]  	:= '0'*/
			Endif
		Next

	Endif	
	aCompoOrig := aCompoRecip

	RestArea(_aAreaBD6)
	RestArea(_aAreaBD7)

	BAU->(RestArea(aAreaBAU))//Leonardo Portella - 28/08/12

endif

RestArea(aArea)
	
Return aCompoOrig



User Function CABZERO()
	
	LOCAL cCodCri := Eval({ || PLSPOSGLO(PLSINTPAD(),"708","Valor apresentado nao informado",nil,"1"), "706" })
	LOCAL cMsg    := cCodCri+" - "+PLSBCTDESC()
	LOCAL aRet    := {{0,"ESP",0,0,0,0,"",0,0,"0",'0'}}
	LOCAL lOK     := .F.
	
Return({lOK,cMsg,aRet,cCodCri})



/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³ Objeto     ³ PLSRETTAUX ³ Autor ³ Tulio Cesar          ³ Data ³ 11.09.2003 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Descri‡„o  ³ Retorna a tabela de auxiliarea para uma TDE.                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso        ³ Advanced Protheus                                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³             ATUALIZACOES SOFRIDAS DESDE A CONSTRU€AO INICIAL               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Programador ³ Data   ³ BOPS ³  Motivo da Altera‡„o                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function CABRETTAUX
	
	LOCAL cCodInt    := paramixb[6]
	LOCAL cCodTab    := paramixb[8]
	LOCAL nRef       := paramixb[2]
	LOCAL aRet       := paramixb[3]
	LOCAL nFatMul    := paramixb[20]
	LOCAL aRetAux    := {}
	LOCAL nInd
	LOCAL nFor
	LOCAL lOK
	LOCAL nVlrAux
	LOCAL nVlrAuxCal
	LOCAL cAlias
	LOCAL cMsg
	LOCAL cCodCri
	LOCAL nValorHM := 0
	LOCAL aVlBloq    := paramixb[42]
	
	BP1->(DbSetOrder(1))
	If BP1->(MsSeek(xFilial("BP1")+cCodInt+cCodTab))
		While ! BP1->(Eof()) .And. BP1->(BP1_FILIAL+BP1_CODINT+BP1_CODTAB) == ;
				xFilial("BP1")+cCodInt+cCodTab
			
			If nRef == BP1->BP1_NUMAUX
				nVlrAux :=BP1->BP1_PERCAX
				lOK     := .T.
				cAlias  := "BP1"
				Exit
			Endif
			
			BP1->(DbSkip())
		Enddo
	Endif
	
	If lOK
		For nInd := 1 To Len(aRet)
			
			If AllTrim(aRet[nInd,1]) $ AllTrim(PLSCHMP())
				For nFor := 1 To Len(aRet[nInd,5])
					nValorHM += aRet[nInd,5,nFor,4]
				Next
				Exit
			Endif
		Next
		
		If nValorHM == 0 .And. Len(aVlBloq) >= 1
			aVlBloq := aClone(aVlBloq)[1]
			
			For nInd := 1 To Len(aVlBloq)
				If AllTrim(aVlBloq[nInd,1]) $ AllTrim(PLSCHMP())
					For nFor := 1 To Len(aVlBloq[nInd,5])
						nValorHM += aVlBloq[nInd,5,nFor,4]
					Next
					Exit
				Endif
			Next
		Endif
		
		nVlrAuxCal := ((nValorHM*nVlrAux)/100)
		//[11] - utilizou horario especial ?
		aadd(aRetAux,{round(nVlrAux,2),cAlias,round(nRef,2),round(nVlrAuxCal,2),0,nFatMul,"% HM",0,0,"0",'0'})
	Else
		PLSPOSGLO(PLSINTPAD(),__aCdCri037[1],__aCdCri037[2])
		cCodCri := __aCdCri037[1]
		cMsg    := cCodCri+" - "+PLSBCTDESC()
	Endif
	
Return({lOK,cMsg,aRetAux,cCodCri})
