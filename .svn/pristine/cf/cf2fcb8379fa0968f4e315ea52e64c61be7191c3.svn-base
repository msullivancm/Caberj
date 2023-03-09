#Include "protheus.ch"
#Include "totvs.ch"
#Include "topconn.ch"
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³ Rdmake    ³PLSXMLSCU ³ Autor ³ Alexander Santos				  ³ Data ³ 19.07.2007 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Descri‡„o ³ Rdmake para retornar a sigla,crm e uf								  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function PLSXMLSCU

Local aArea			:= GetArea()//Leonardo Portella - 11/08/11
LOCAL cSigla 		:= AllTrim( paramixb[1] )
LOCAL cCrm 	 		:= AllTrim( paramixb[2] )
LOCAL cUf 	 		:= AllTrim( paramixb[3] )
LOCAL cCodProf 		:= AllTrim( paramixb[4] )
Local cES       	:= AllTrim( paramixb[5] )
Local cNome			:= AllTrim( paramixb[6] )
Local cCBOS			:= AllTrim( paramixb[7] )
Local cCrmAux		:= cCrm
Local dDatPro		:= Date()
Local _aAreaBB0		:= BB0->(GetArea())
Local aStatTmp		:= {}
Local nRecProjBB0	:= 0
Local cQuery		:= ""
Local lAchou		:= .F.

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³cES:               ³
//³"S" - Solicitante  ³
//³"E" - Executante   ³
//³"" - Equipe (vazio)³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

if !IsInCallStack("PROCONLINE")

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Tratar codigo do prestador na operadora, retirando . e - do codigo...    ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	cCrm := StrTran(cCrm,"-","")
	cCrm := StrTran(cCrm,".","")

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Tratar codigo do solicitante e executante cfme regras Caberj.            ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

	//BIANCHINI - 24/06/2019 - DE/PARA de Solicitantes.  Gravando os campos "_SIGLA" está desponteirando BB0 
	If Val(AllTrim(cSigla))     == 1
		cSigla := "CRAS"
	ElseIf Val(AllTrim(cSigla)) == 2
		cSigla := "COREN"
	ElseIf Val(AllTrim(cSigla)) == 3
		cSigla := "CRF"
	ElseIf Val(AllTrim(cSigla)) == 4
		cSigla := "CRFA"
	ElseIf Val(AllTrim(cSigla)) == 5   
		cSigla := "CREFITO"
	ElseIf Val(AllTrim(cSigla)) == 6
		cSigla := "CRM"
	ElseIf Val(AllTrim(cSigla)) == 7
		cSigla := "CRN"
	ElseIf Val(AllTrim(cSigla)) == 8
		cSigla := "CRO"
	ElseIf Val(AllTrim(cSigla)) == 9
		cSigla := "CRP"
	Endif

	//Leonardo Portella - 11/08/11 - Inicio
	//Existem CRMs cadastrados na BB0 com o codigo precedido por '0052CRM', somente '52CRM' ou somente 'CRM'
	//Verifico se encontro o CRM na BB0 antes de alterar. Caso nao encontre, nao altero.      
	If ( cSigla == 'CRM' )

		aStatTmp := u_StatBB0(cCrm,dDatpro,nil,nil,cSigla,cUf)
		
		If Len(aStatTmp) > 0
			If !Empty(aStatTmp[1]) //Se Achou o Profissional Vinculado a Projeto
				dbSelectArea('BB0')
				dbSetOrder(1)
				
				If DbSeek(xFilial('BB0') + AllTrim(aStatTmp[1]))
					lAchou := .T.
					cCrmAux := AllTrim(BB0->BB0_NUMCR) 
					cCrm 	:= cCrmAux
				Endif
			Else //Se não achou, tenta na BB0 pura, tratando os zeros a esquerda por query. Mesma query da STATBB0, sem o Join com ZZF
				cQuery := " SELECT BB0_VINC, 								  "	+ CRLF
				cQuery += "        BB0_CODIGO,								  "	+ CRLF
				cQuery += "        BB0_NOME, 								  "	+ CRLF
				cQuery += "        BB0_CODSIG,                                "	+ CRLF
				cQuery += "        BB0_NUMCR,                                 "	+ CRLF
				cQuery += "        BB0_ESTADO,                                "	+ CRLF
				cQuery += "        BB0_CGC,                                   "	+ CRLF
				cQuery += "        BB0_DATBLO                                 "	+ CRLF
				cQuery += "  FROM " + RetSqlName("BB0") + " BB0				  " + CRLF
				cQuery += " WHERE BB0_FILIAL = '" + xFilial("BB0") + " '      "	+ CRLF
				cQuery += "   AND BB0_ESTADO = '"+cUf+ "'                    "	+ CRLF
				cQuery += "   AND "	+ CRLF
				/*
				cQuery += "   ( "	+ CRLF //Angelo Henrique - Data:07/04/2016
				cQuery += "   LTRIM(TRIM(BB0_NUMCR),0) = LTRIM(TRIM(SUBSTR(LPAD(TRIM(REMOVE_ALFA(REMOVE_CARACTERS_ESPEC_II('"+cCrm+"'))),10,'0'),(LENGTH(LPAD(TRIM(REMOVE_ALFA(REMOVE_CARACTERS_ESPEC_II('"+cCrm+"'))),10,'0'))-6)+1,LENGTH(LPAD(TRIM(REMOVE_ALFA(REMOVE_CARACTERS_ESPEC_II('"+cCrm+"'))),10,'0')))),0)"	+ CRLF
				cQuery += "   OR "	+ CRLF //Angelo Henrique - Data:07/04/2016
				cQuery += "   LTRIM(TRIM(BB0_NUMCR),0) = LTRIM(TRIM(REMOVE_ALFA(REMOVE_CARACTERS_ESPEC_II('"+cCrm+"'))),0) "	+ CRLF //Angelo Henrique - Data:07/04/2016
				cQuery += "   OR "	+ CRLF //Fabio Bianchini - Data:02/03/2020
				cQuery += "   LTRIM(TRIM(BB0_NUMCR),0) = LTRIM(TRIM(SUBSTR(LPAD(TRIM(REMOVE_ALFA(REMOVE_CARACTERS_ESPEC_II('52"+cCrm+"'))),10,'0'),(LENGTH(LPAD(TRIM(REMOVE_ALFA(REMOVE_CARACTERS_ESPEC_II('52"+cCrm+"'))),10,'0'))-6)+1,LENGTH(LPAD(TRIM(REMOVE_ALFA(REMOVE_CARACTERS_ESPEC_II('52"+cCrm+"'))),10,'0')))),0)"	+ CRLF
				cQuery += "   OR "	+ CRLF //Fabio Bianchini - Data:02/03/2020
				cQuery += "   LTRIM(TRIM(BB0_NUMCR),0) = LTRIM(TRIM(REMOVE_ALFA(REMOVE_CARACTERS_ESPEC_II('52"+cCrm+"'))),0) "	+ CRLF //Fabio Bianchini - Data:02/03/2020
				cQuery += "   OR "	+ CRLF //Fabio Bianchini - Data:02/03/2020
				cQuery += "   LTRIM(TRIM(BB0_NUMCR),0) = LTRIM(TRIM(SUBSTR(LPAD(TRIM(REMOVE_ALFA(REMOVE_CARACTERS_ESPEC_II('052"+cCrm+"'))),10,'0'),(LENGTH(LPAD(TRIM(REMOVE_ALFA(REMOVE_CARACTERS_ESPEC_II('052"+cCrm+"'))),10,'0'))-6)+1,LENGTH(LPAD(TRIM(REMOVE_ALFA(REMOVE_CARACTERS_ESPEC_II('052"+cCrm+"'))),10,'0')))),0)"	+ CRLF
				cQuery += "   OR "	+ CRLF //Fabio Bianchini - Data:02/03/2020
				cQuery += "   LTRIM(TRIM(BB0_NUMCR),0) = LTRIM(TRIM(REMOVE_ALFA(REMOVE_CARACTERS_ESPEC_II('052"+cCrm+"'))),0) "	+ CRLF //Fabio Bianchini - Data:02/03/2020
				cQuery += "   OR "	+ CRLF //Fabio Bianchini - Data:02/03/2020
				cQuery += "   LTRIM(TRIM(BB0_NUMCR),0) = LTRIM(TRIM(SUBSTR(LPAD(TRIM(REMOVE_ALFA(REMOVE_CARACTERS_ESPEC_II('0052"+cCrm+"'))),10,'0'),(LENGTH(LPAD(TRIM(REMOVE_ALFA(REMOVE_CARACTERS_ESPEC_II('0052"+cCrm+"'))),10,'0'))-6)+1,LENGTH(LPAD(TRIM(REMOVE_ALFA(REMOVE_CARACTERS_ESPEC_II('0052"+cCrm+"'))),10,'0')))),0)"	+ CRLF
				cQuery += "   OR "	+ CRLF //Fabio Bianchini - Data:02/03/2020
				cQuery += "   LTRIM(TRIM(BB0_NUMCR),0) = LTRIM(TRIM(REMOVE_ALFA(REMOVE_CARACTERS_ESPEC_II('0052"+cCrm+"'))),0) "	+ CRLF //Fabio Bianchini - Data:02/03/2020
				cQuery += "   ) "	+ CRLF //Fabio Bianchini - Data:02/03/2020
				*/
				cQuery += "   ( "	+ CRLF //Angelo Henrique - Data:07/04/2016
				cQuery += "   LTRIM(TRIM(BB0_NUMCR),0) = LTRIM(TRIM(SUBSTR(LPAD(REMOVE_CARACTERS_ESPEC_III('"+cCrm+"'),10,'0'),(LENGTH(LPAD(REMOVE_CARACTERS_ESPEC_III('"+cCrm+"'),10,'0'))-6)+1,LENGTH(LPAD(REMOVE_CARACTERS_ESPEC_III('"+cCrm+"'),10,'0')))),0)"	+ CRLF
				cQuery += "   OR "	+ CRLF //Angelo Henrique - Data:07/04/2016
				cQuery += "   LTRIM(TRIM(BB0_NUMCR),0) = LTRIM(REMOVE_CARACTERS_ESPEC_III('"+cCrm+"'),0) "	+ CRLF //Angelo Henrique - Data:07/04/2016
				cQuery += "   OR "	+ CRLF //Fabio Bianchini - Data:02/03/2020
				cQuery += "   LTRIM(TRIM(BB0_NUMCR),0) = LTRIM(TRIM(SUBSTR(LPAD(REMOVE_CARACTERS_ESPEC_III('52"+cCrm+"'),10,'0'),(LENGTH(LPAD(REMOVE_CARACTERS_ESPEC_III('52"+cCrm+"'),10,'0'))-6)+1,LENGTH(LPAD(REMOVE_CARACTERS_ESPEC_III('52"+cCrm+"'),10,'0')))),0)"	+ CRLF
				cQuery += "   OR "	+ CRLF //Fabio Bianchini - Data:02/03/2020
				cQuery += "   LTRIM(TRIM(BB0_NUMCR),0) = LTRIM(REMOVE_CARACTERS_ESPEC_III('52"+cCrm+"'),0) "	+ CRLF //Fabio Bianchini - Data:02/03/2020
				cQuery += "   OR "	+ CRLF //Fabio Bianchini - Data:02/03/2020
				cQuery += "   LTRIM(TRIM(BB0_NUMCR),0) = LTRIM(TRIM(SUBSTR(LPAD(REMOVE_CARACTERS_ESPEC_III('052"+cCrm+"'),10,'0'),(LENGTH(LPAD(REMOVE_CARACTERS_ESPEC_III('052"+cCrm+"'),10,'0'))-6)+1,LENGTH(LPAD(REMOVE_CARACTERS_ESPEC_III('052"+cCrm+"'),10,'0')))),0)"	+ CRLF
				cQuery += "   OR "	+ CRLF //Fabio Bianchini - Data:02/03/2020
				cQuery += "   LTRIM(TRIM(BB0_NUMCR),0) = LTRIM(REMOVE_CARACTERS_ESPEC_III('052"+cCrm+"'),0) "	+ CRLF //Fabio Bianchini - Data:02/03/2020
				cQuery += "   OR "	+ CRLF //Fabio Bianchini - Data:02/03/2020
				cQuery += "   LTRIM(TRIM(BB0_NUMCR),0) = LTRIM(TRIM(SUBSTR(LPAD(REMOVE_CARACTERS_ESPEC_III('0052"+cCrm+"'),10,'0'),(LENGTH(LPAD(REMOVE_CARACTERS_ESPEC_III('0052"+cCrm+"'),10,'0'))-6)+1,LENGTH(LPAD(REMOVE_CARACTERS_ESPEC_III('0052"+cCrm+"'),10,'0')))),0)"	+ CRLF
				cQuery += "   OR "	+ CRLF //Fabio Bianchini - Data:02/03/2020
				cQuery += "   LTRIM(TRIM(BB0_NUMCR),0) = LTRIM(REMOVE_CARACTERS_ESPEC_III('0052"+cCrm+"'),0) "	+ CRLF //Fabio Bianchini - Data:02/03/2020
				cQuery += "   ) "	+ CRLF //Fabio Bianchini - Data:02/03/2020
				cQuery += "   AND BB0_CODSIG = '"+cSigla+"'                  "	+ CRLF
				cQuery += "   AND BB0_CODOPE = '"+PLSINTPAD()+"'              "	+ CRLF
				cQuery += "   AND (BB0_DATBLO = ' ' or BB0_DATBLO >= '" + DtoS(dDatPro)+ "')"	+ CRLF
				cQuery += "   AND BB0.D_E_L_E_T_ = ' '                        "	
		
				memowrite("c:\TEMP\PLSXMLSCU.SQL",cQuery)
		
				TcQuery cQuery Alias "BB0TMP" New
		
				DbSelectArea("BB0TMP")

				If !EOF()
					lAchou := .T.
					cCrmAux := AllTrim(BB0TMP->BB0_NUMCR) 
					cCrm 	:= cCrmAux
				Endif
				
				BB0TMP->(DbCloseArea())
			Endif
			
		Endif

		//Se nenhuma das formas anteriores achou, tento uma ultima vez indpo direto em BB0 com o CRM que veio no XML
		If !lAchou .and. cCrm == AllTrim(cCrmAux)   
			dbSelectArea('BB0')
			dbSetOrder(4)
			dbGoTop()
			
			MsSeek(xFilial('BB0') + cUf + PadR(cCrm,TamSx3('BB0_NUMCR')[1]) + cSigla)//Se achei o enviado, não mudo nada
			
			If BB0->(Found()) //.AND. ( EMPTY(BB0->BB0_DATBLO) .OR. BB0->BB0_DATBLO > DATE() ) 
				//lAchou := .T.
				//cCrmAux := AllTrim(BB0->BB0_NUMCR) 
				//cCrm 	:= cCrmAux
				While !(BB0->(EOF())) .and.  BB0->(BB0_FILIAL + BB0_ESTADO + BB0_NUMCR + BB0_CODSIG) == xFilial('BB0') + cUf + PadR(cCrm,TamSx3('BB0_NUMCR')[1]) + cSigla 
					IF ( EMPTY(BB0->BB0_DATBLO) .OR. BB0->BB0_DATBLO > DATE() )
						lAchou := .T.
						cCrmAux := AllTrim(BB0->BB0_NUMCR) 
						cCrm 	:= cCrmAux
					Endif
					BB0->(DbSkip())
				Enddo
				
			Endif 
		//Else
			//cCrm := AllTrim(cCrmAux)
		Endif
		
		If !lAchou

			dbSelectArea('BB0')
			dbSetOrder(4)
	//		dbGoTop()
			
	//		MsSeek(xFilial('BB0') + cUf + PadR(cCrm,TamSx3('BB0_NUMCR')[1]) + cSigla)//Se achei o enviado, não mudo nada
			
			//If !BB0->(Found()) 
	//		If ( !BB0->(Found()) ) .OR. ( BB0->(Found()) .AND. !EMPTY(BB0->BB0_DATBLO) ) 
	//			dbGoTop()
			
				Do Case
				
					Case ( left(cCrm,4) == "0052" ) .and. ( cValToChar(len(cCrm)) $ "10|11" ) 
		
						//Busco pelo 52CRM
						If MsSeek(xFilial('BB0') + cUf + PadR(right(cCrm,len(cCrm) - 2),TamSx3('BB0_NUMCR')[1]) + cSigla)
							//cCrm := right(cCrm,len(cCrm) - 2)
							While !(BB0->(EOF())) .and.  BB0->(BB0_FILIAL + BB0_ESTADO + BB0_NUMCR + BB0_CODSIG) == xFilial('BB0') + cUf + PadR(right(cCrm,len(cCrm) - 2),TamSx3('BB0_NUMCR')[1]) + cSigla 
								IF ( EMPTY(BB0->BB0_DATBLO) .OR. BB0->BB0_DATBLO > DATE() )
								cCrm := right(cCrm,len(cCrm) - 2)
								Exit
								Endif
								BB0->(DbSkip())
							Enddo
						Else
							dbGoTop()
							//Busco pelo CRM
							If MsSeek(xFilial('BB0') + cUf + PadR(right(cCrm,len(cCrm) - 4),TamSx3('BB0_NUMCR')[1]) + cSigla)
								//cCrm := right(cCrm,len(cCrm) - 4)
								While !(BB0->(EOF())) .and.  BB0->(BB0_FILIAL + BB0_ESTADO + BB0_NUMCR + BB0_CODSIG) == xFilial('BB0') + cUf + PadR(right(cCrm,len(cCrm) - 4),TamSx3('BB0_NUMCR')[1]) + cSigla 
									IF ( EMPTY(BB0->BB0_DATBLO) .OR. BB0->BB0_DATBLO > DATE() )
									cCrm := right(cCrm,len(cCrm) - 4)
									Exit
									Endif
									BB0->(DbSkip())
								Enddo							
							EndIf
						EndIf
				
					Case ( left(cCrm,2) == "52" ) .and. ( cValToChar(len(cCrm)) $ "8|9" ) 
						//Busco pelo 0052CRM
						If MsSeek(xFilial('BB0') + cUf + '00' + PadR(cCrm,TamSx3('BB0_NUMCR')[1] - 2) + cSigla)
							//cCrm := '00' + cCrm
							While !(BB0->(EOF())) .and.  BB0->(BB0_FILIAL + BB0_ESTADO + BB0_NUMCR + BB0_CODSIG) == xFilial('BB0') + cUf + '00' + PadR(cCrm,TamSx3('BB0_NUMCR')[1] - 2) + cSigla 
								IF ( EMPTY(BB0->BB0_DATBLO) .OR. BB0->BB0_DATBLO > DATE() )
								cCrm := '00' + cCrm
								Exit
								Endif
								BB0->(DbSkip())
							Enddo
						Else
							dbGoTop()
							//Busco pelo CRM
							If MsSeek(xFilial('BB0') + cUf + PadR(right(cCrm,len(cCrm) - 2),TamSx3('BB0_NUMCR')[1]) + cSigla)
								//cCrm := right(cCrm,len(cCrm) - 2)														
								While !(BB0->(EOF())) .and.  BB0->(BB0_FILIAL + BB0_ESTADO + BB0_NUMCR + BB0_CODSIG) == xFilial('BB0') + cUf + PadR(right(cCrm,len(cCrm) - 2),TamSx3('BB0_NUMCR')[1]) + cSigla 
									IF ( EMPTY(BB0->BB0_DATBLO) .OR. BB0->BB0_DATBLO > DATE() )
									cCrm := right(cCrm,len(cCrm) - 2)
									Exit
									Endif
									BB0->(DbSkip())
								Enddo
							EndIf
						EndIf			
				
					Case ( cValToChar(len(cCrm)) $ "6|7" ) 
		
						//Busco pelo 0052CRM
						If MsSeek(xFilial('BB0') + cUf + '0052' + PadR(cCrm,TamSx3('BB0_NUMCR')[1] - 4) + cSigla)
							//cCrm := '0052' + cCrm
							While !(BB0->(EOF())) .and.  BB0->(BB0_FILIAL + BB0_ESTADO + BB0_NUMCR + BB0_CODSIG) == xFilial('BB0') + cUf + '0052' + PadR(cCrm,TamSx3('BB0_NUMCR')[1] - 4) + cSigla 
								IF ( EMPTY(BB0->BB0_DATBLO) .OR. BB0->BB0_DATBLO > DATE() )
								cCrm := '0052' + cCrm
								Exit
								Endif
								BB0->(DbSkip())
							Enddo						
						Else
							dbGoTop()
							//Busco pelo 052CRM
							If MsSeek(xFilial('BB0') + cUf + '052' + PadR(cCrm,TamSx3('BB0_NUMCR')[1] - 3) + cSigla)
								//cCrm := '052' + cCrm
								While !(BB0->(EOF())) .and.  BB0->(BB0_FILIAL + BB0_ESTADO + BB0_NUMCR + BB0_CODSIG) == xFilial('BB0') + cUf + '052' + PadR(cCrm,TamSx3('BB0_NUMCR')[1] - 3) + cSigla 
									IF ( EMPTY(BB0->BB0_DATBLO) .OR. BB0->BB0_DATBLO > DATE() )
									cCrm := '052' + cCrm
									Exit
									Endif
									BB0->(DbSkip())
								Enddo								
							Else
								dbGoTop()
								//Busco pelo 52CRM
								If MsSeek(xFilial('BB0') + cUf + '52' + PadR(cCrm,TamSx3('BB0_NUMCR')[1] - 2) + cSigla)
									//cCrm := '52' + cCrm
									While !(BB0->(EOF())) .and.  BB0->(BB0_FILIAL + BB0_ESTADO + BB0_NUMCR + BB0_CODSIG) == xFilial('BB0') + cUf + '52' + PadR(cCrm,TamSx3('BB0_NUMCR')[1] - 2) + cSigla 
										IF ( EMPTY(BB0->BB0_DATBLO) .OR. BB0->BB0_DATBLO > DATE() )
										cCrm := '52' + cCrm
										Exit
										Endif
										BB0->(DbSkip())
									Enddo									
								EndIf
							EndIf
						EndIf
							
				End Case
			
	//		EndIf	
			
		Endif	
		//Leonardo Portella - Fim - 18/05/15 - Critica X34: Buscar pelos outros complementos possiveis
	EndIf

	//Leonardo Portella - 11/08/11 - Fim

endif

RestArea(_aAreaBB0)
RestArea(aArea)//Leonardo Portella - 11/08/11



//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Fim da Rotina															 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

Return( {cSigla,cCrm,cUf} )

//***************************************************************************************************

//Prioriza um CRM que esteja vinculado a um projeto

Static Function nBB0Proj(cNumCR)

Local aArea		:= GetArea()
Local nRecBB0 	:= 0
Local cQry		:= ''
Local cAlias	:= GetNextAlias()

cNumCR := AllTrim(cNumCR)

Do Case
		
	Case ( left(cNumCR,4) == "0052" ) .and. ( cValToChar(len(cNumCR)) $ "10|11" ) 
	
		cNumCR := Right(cNumCR,len(cNumCR) - 4)
		
	Case ( left(cNumCR,2) == "52" ) .and. ( cValToChar(len(cNumCR)) $ "8|9" )  
	
		cNumCR := Right(cNumCR,len(cNumCR) - 2)
	
EndCase

cQry := "SELECT BB0.R_E_C_N_O_ RECBB0, TRIM(BB0_NUMCR) BB0_NUMCR, BB0_CODIGO"					+ CRLF
cQry += "FROM " + RetSqlName("BB0") + " BB0" 													+ CRLF
cQry += "INNER JOIN " + RetSqlName("ZZF") + " ZZF ON ZZF_FILIAL = '" + xFilial('ZZF') + "'"	 	+ CRLF 
cQry += "  AND ZZF_CODIGO = BB0_CODIGO" 														+ CRLF
cQry += "  AND ZZF_DATBLO = ' '" 																+ CRLF
cQry += "  AND ZZF.D_E_L_E_T_ = ' '" 															+ CRLF
cQry += "WHERE BB0_FILIAL = '" + xFilial('BB0') + "' " 											+ CRLF
cQry += "  AND BB0_DATBLO = ' '" 																+ CRLF
cQry += "  AND BB0.D_E_L_E_T_ = ' '" 															+ CRLF
cQry += "  AND BB0_CODSIG = 'CRM'" 																+ CRLF
cQry += "  AND BB0_NUMCR LIKE '%" + cNumCR + "'"		 										+ CRLF
cQry += "ORDER BY BB0.R_E_C_N_O_ DESC"					 										+ CRLF

PLSQuery(cQry,cAlias)


While !(cAlias)->(EOF())

	If 	( (cAlias)->BB0_NUMCR == '0052' + cNumCR ) 	.or. ;
		( (cAlias)->BB0_NUMCR == '52' + cNumCR ) 		.or. ;
		( (cAlias)->BB0_NUMCR == cNumCR )
		
		nRecBB0 := (cAlias)->RECBB0
		Exit
		
	EndIf

	(cAlias)->(DbSkip())

EndDo

(cAlias)->(DbCloseArea())

RestArea(aArea)

Return nRecBB0
