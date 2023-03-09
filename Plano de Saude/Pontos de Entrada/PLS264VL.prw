#INCLUDE 'PROTHEUS.CH'
#DEFINE c_ent CHR(13) + CHR(10)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³PLS264VL ³ Autor ³ Angelo Henrique      ³ Data ³ 15/10/2015 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Ponto de entrada utilizado para gravar a data de validade  ³±±
±±³          ³ em outras tabelas relacionadas.                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Continua  ³ Utilizado aqui na CABERJ pois caso o usuário mudar o       ³±±
±±³Descrição ³ parametro da data de validade, não impactar nos calculos   ³±±
±±³          ³ já efetuados no ponto de entrada PLS264EM, logo é reforçado³±±
±±³          ³ aqui neste parametros os mesmos calculos e regravados nas  ³±±
±±³          ³ tabelas para que seja tudo calculado corretamente.         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Relação   ³ Para Carteirinha alem deste P.E. utilizo com as mesmas     ³±±
±±³          ³ validações e regras os seguintes pontos de entrada:        ³±±
±±³          ³ PLS264EM                                                   ³±±
±±³          ³ PLS264DT                                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ CABERJ                                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

User Function PLS264VL()
	
	Local _lInaAd  	:= .F. //Angelo Henrique - Data:09/10/15
	Local _lNvCt 	 	:= .F. //Angelo Henrique - Data:09/10/15
	Local _aAreBHH 	:= BHH->(GetArea()) //Angelo Henrique - Data:09/10/15
	Local _aAreBA1 	:= BA1->(GetArea()) //Angelo Henrique - Data:13/10/15
	Local _aAreBED 	:= BED->(GetArea()) //Angelo Henrique - Data:13/10/15
	Local _aAreBDE 	:= BDE->(GetArea()) //Angelo Henrique - Data:13/10/15
	Local aDadUsr		:= {}
	Local cCodCli		:= ""
	Local cLoja		:= ""
	Local lRet			:= .T.
	Local _dDtRenv 	:= ctod(" / / ") //Angelo Henrique - Data: 27/10/15
	Local _dNasc 	 	:= CTOD(" / / ") //Angelo Henrique - Data: 15/02/16
	
	If AllTrim(UPPER(FUNNAME())) == "PLSA261"
		
		If BA1->BA1_CODEMP == "0001" .And. BA1->BA1_SUBCON == "000000010"
			
			lRet := .F.
			
		ElseIf !(BA1->BA1_CODEMP $ "0001|0002|0005")
			
			lRet := .F.
			
		EndIf
		
		//-------------------------------------------
		//Validação para saber se é ou não renovação
		// 2 - Renovação de contrato PJ(Custo OPER)
		// 3 - Renovação de contrato PF PJ(Pre PAGTO)
		//-------------------------------------------
		If !(MV_PAR02 $("2|3"))
			
			lRet := .F.
			
		EndIf
		
		If AllTrim(UPPER(FUNNAME())) == "PLSA262"
			
			If M->BDE_MOTIVO $("2|3")
				
				lRenv := .T.
				
			Else
				
				lRenv := .F.
				
			EndIf
			
		EndIf
		
		If lRet
			
			aDadUsr := PLSDADUSR(BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG+BA1_DIGITO),"1",.F.,dDataBase,nil,nil,nil)
			cCodCli := aDadUsr[58]
			cLoja   := aDadUsr[59]
			
			//-------------------------------------------------------
			//PR - Título de negociação
			//-------------------------------------------------------
			If UPPER(AllTrim(NegParc("C",BA1->BA1_CODINT,BA1->BA1_CODEMP,BA1->BA1_MATRIC, DTOS(dDataBase)))) == "EM NEGOCIACAO"
				
				_lNvCt := .T.
				
			EndIf
			
			If !_lNvCt
				
				//--------------------------------------------------------------------------
				//Valida na data Atual se possui ou não título vencido mais de 60 dias
				//Para saber se esta ou não Inadimplente
				//Retorna .T. para inadimplente ou .F. para adimplente
				//--------------------------------------------------------------------------
				_lDiaIna := u_IndimpCt(cCodCli,cLoja,"0")
				
				If _lDiaIna
					
					lRet := .F.
					
					If AllTrim(UPPER(FUNNAME())) == "PLSA261"
						
						Alert("Carteira não será gerada, inadimplente por mais de 60 dias")
						
					EndIf
					
				EndIf
				
			EndIf
			
			If lRet
				
				If !_lNvCt
					
					//Adimplente ou Inadimplente em 60 dias
					_lInaAd := u_IndimpCt(cCodCli,cLoja,"1")
					
					If !_lInaAd //Adimplente na Data Atual (60 Dias)
						
						//-------------------------------------------------------
						//Estar inadimplente 24 meses por mais de 60 dias
						//-------------------------------------------------------
						If u_IndimpCt(cCodCli,cLoja,"2")
							
							_lNvCt := .T.
							
						EndIf
						
						//-------------------------------------------------------
						//PR - Título de parcelamento
						//-------------------------------------------------------
						If !_lNvCt
							
							If UPPER(AllTrim(NegParc("C",BA1->BA1_CODINT,BA1->BA1_CODEMP,BA1->BA1_MATRIC, DTOS(dDataBase)))) == "EM PARCELAMENTO"
								
								_lNvCt 	:= .T.
								_lNotEmt	:= .F.
								
							EndIf
							
						EndIf
						
						//-------------------------------------------------------
						//Ação Judicial/ANS e não ter caído nas regras anteriores
						//-------------------------------------------------------
						If !_lNvCt
							
							If BA1->BA1_CODEMP == "0001" .And. BA1->BA1_SUBCON == "000000006"
								
								_lNvCt := .T.
								
							EndIf
							
							If BA1->BA1_CODEMP == "0002" .And. BA1->BA1_SUBCON == "000000008"
								
								_lNvCt := .T.
								
							EndIf
							
							DbSelectArea("BHH")
							DbSetOrder(1)
							If DbSeek(xFilial("BHH")+BA1->BA1_CODINT+BA1->BA1_CODEMP+BA1->BA1_MATRIC+BA1->BA1_TIPREG)
								
								While BA1->BA1_CODINT + BA1->BA1_CODEMP + BA1->BA1_MATRIC + BA1->BA1_TIPREG == BHH->BHH_CODINT + BHH->BHH_CODEMP + BHH->BHH_MATRIC + BHH->BHH_TIPREG
									
									//-----------------------------------------------------------
									//- 004 Ação Judicial
									//- 005 Processo Judicial
									//- 011 Demandas ANS
									//- 014 Processo Judicial - Reajuste
									//- 015 PROCON
									//-----------------------------------------------------------
									If AllTrim(BHH->BHH_CODSAD) $ ("004|005|011|014|015")
										
										_lNvCt := .T.
										
										Exit
										
									EndIf
									
									BHH->(DbSkip())
									
								EndDo
								
							EndIf
							
						EndIf
						
					Else //Inadimplente na Data Atual (60 Dias)
						
						_lNvCt 	:= .T.
						
					EndIf
					
				EndIf
				
				//----------------------------------------------------
				//Conforme alinhamento com JUDY - Data:27/10/2015
				//MATER recebe como data de renovação ABRIL
				//Afinidade recebe como data de renovação Novembro
				//----------------------------------------------------
				If BA1->BA1_CODEMP $ "0002|0005" //Afinidade
					
					_dDtRenv := GETMV("MV_XRENOVA")
					
				ElseIf BA1->BA1_CODEMP = "0001" //Mater
					
					_dDtRenv := GETMV("MV_XRENOV1")
					
				EndIf
				
				If Alltrim(FunName()) == "PLSA261"
					
					//--------------------------------------------------------------------
					//no lançamento avuso ele respeita o ano passado por parametro
					//no lançamento em lote ele sempre soma mais um por padrão
					//logo tratado por  parametro e aqui
					//--------------------------------------------------------------------
					_dDtRenv := YearSum(_dDtRenv,1)
					
				EndIf
				
				dDtVali := CTOD(" / / ")
				
				//-----------------------------------------------------------
				//Caso tenha dado verdadeiro em alguma das validações
				//deve alterar a validade das carteiras para 2 anos
				//-----------------------------------------------------------
				If _lNvCt
					
					dDtVali := YearSum(LastDate(_dDtRenv),2)
					
				Else //Senão cair nas regras gerais de validade
					
					//--------------------------------------------------------------
					//Regra para idade													|
					//Quantidade de tempo que o beneficiário possui o plano			|
					//--------------------------------------------------------------
					//              Regra									| Renovar 	|
					//--------------------------------------------------------------
					//Mais que 20 anos e ter idade menor que 90 anos		| 20 anos	|
					//Mais que 15 anos e menor que 20 anos					| 15 anos	|
					//Mais que 10 anos e menor que 15 anos					| 10 anos	|
					//Mais que 05 anos e menor que 10 anos					| 05 anos	|
					//Menos de 05 anos										| 02 anos	|
					//Idade superior a 90 anos								| 02 anos	|
					//--------------------------------------------------------------
					
					If Calc_Idade(dDataBase,BA1->BA1_DATINC) >= 20
						
						If Calc_Idade(dDataBase,BA1->BA1_DATNASC) >= 90
							
							dDtVali := YearSum(LastDate(_dDtRenv),2)
							
						Else
							
							If Calc_Idade(dDataBase,BA1->BA1_DATNASC) + 20 > 90
								
								dDtVali := YearSum(LastDate(_dDtRenv),(90 - Calc_Idade(LastDate(_dDtRenv),BA1->BA1_DATNASC)))
								
							Else
								
								dDtVali := YearSum(LastDate(_dDtRenv),20)
								
							EndIf
							
						EndIf
						
					ElseIf Calc_Idade(dDataBase,BA1->BA1_DATINC) >= 15 .And. Calc_Idade(dDataBase,BA1->BA1_DATINC) < 20
						
						If Calc_Idade(dDataBase,BA1->BA1_DATNASC) >= 90
							
							dDtVali := YearSum(LastDate(_dDtRenv),2)
							
						Else
							
							If Calc_Idade(dDataBase,BA1->BA1_DATNASC) + 15 > 90
								
								dDtVali := YearSum(LastDate(_dDtRenv),(90 - Calc_Idade(LastDate(_dDtRenv),BA1->BA1_DATNASC)))
								
							Else
								
								dDtVali := YearSum(LastDate(_dDtRenv),15)
								
							EndIf
							
						EndIf
						
					ElseIf Calc_Idade(dDataBase,BA1->BA1_DATINC) >= 10 .And. Calc_Idade(dDataBase,BA1->BA1_DATINC) < 15
						
						If Calc_Idade(dDataBase,BA1->BA1_DATNASC) >= 90
							
							dDtVali := YearSum(LastDate(_dDtRenv),2)
							
						Else
							
							If Calc_Idade(dDataBase,BA1->BA1_DATNASC) + 10 > 90
								
								dDtVali := YearSum(LastDate(_dDtRenv),(90 - Calc_Idade(LastDate(_dDtRenv),BA1->BA1_DATNASC)))
								
							Else
								
								dDtVali := YearSum(LastDate(_dDtRenv),10)
								
							EndIf
							
						EndIf
						
					ElseIf Calc_Idade(dDataBase,BA1->BA1_DATINC) >= 05 .And. Calc_Idade(dDataBase,BA1->BA1_DATINC) < 10
						
						If Calc_Idade(dDataBase,BA1->BA1_DATNASC) >= 90
							
							dDtVali := YearSum(LastDate(_dDtRenv),2)
							
						Else
							
							If Calc_Idade(dDataBase,BA1->BA1_DATNASC) + 5 > 90
								
								dDtVali := YearSum(LastDate(_dDtRenv),(90 - Calc_Idade(LastDate(_dDtRenv),BA1->BA1_DATNASC)))
								
							Else
								
								dDtVali := YearSum(LastDate(_dDtRenv),5)
								
							EndIf
							
						EndIf
						
					ELseIf Calc_Idade(dDataBase,BA1->BA1_DATINC) < 5
						
						If Calc_Idade(dDataBase,BA1->BA1_DATNASC) + 2 > 90
							
							If Calc_Idade(dDataBase,BA1->BA1_DATNASC) >= 90
								
								dDtVali := YearSum(LastDate(_dDtRenv),2)
								
							Else
								
								dDtVali := YearSum(LastDate(_dDtRenv),(90 - Calc_Idade(LastDate(_dDtRenv),BA1->BA1_DATNASC)))
								
								If Year(dDtVali) < YEAR(YearSum(LastDate(_dDtRenv),1))
									
									dDtVali := YearSum(LastDate(_dDtRenv),1)
									
								EndIf
								
							EndIf
							
						Else
							
							dDtVali := YearSum(LastDate(_dDtRenv),2)
							
						EndIf
						
					EndIf
					
				EndIf
				
				//---------------------------------------------------------------------------------------------------------------------
				//Aplicando a regra de dependente
				//---------------------------------------------------------------------------------------------------------------------
				//1.2 Condições de renovação para dependentes
				//---------------------------------------------------------------------------------------------------------------------
				//	1.2.1 Dependentes até 24 anos (respeitando as da data de validade até o limite de 24, anos, salvo casos especiais)
				//	1.2.2 Dependentes (cônjugue e/ou filhos maiores de 24 anos em condições especiais - filhos especiais e etc) - irão
				//	respeitar as regras gerais de validade com base no tempo do plano
				//---------------------------------------------------------------------------------------------------------------------
				//Códigos gravados no beneficiários:
				// 02 - Esposa
				// 03 - Companheiro(a)
				// 04 - Esposo
				// 25 - Filho Especial
				//---------------------------------------------------------------------------------------------------------------------
				
				//-------------------------------------------------------------------------------
				//Validar se é dependente e não for especial ou marido e mulher (Conjuge)
				//precisa estar na regra de que a validade só poderá ser até 24 anos
				//-------------------------------------------------------------------------------
				If BA1->BA1_TIPUSU == "D" .And. !(BA1->BA1_GRAUPA $ "02|03|04|08|25")
					
					//---------------------------------------------------------------------------
					//Tratando os beneficiários dependentes, porém maiores que 90 anos de idade
					//---------------------------------------------------------------------------
					If Calc_Idade(dDtVali,BA1->BA1_DATNASC) >= 90
						
						_dNasc := CTOD(SUBSTR(DTOC(BA1->BA1_DATNASC),1,6) + SUBSTR(DTOC(dDataBase),7,4))
						dDtVali := YearSum(LastDate(_dNasc),2)
						
					ElseIf Calc_Idade(dDtVali,BA1->BA1_DATNASC) >= 24
						
						//-----------------------------------------------------
						//Utilizando a data de validade que o beneficiário
						//receberá na carteira para realizar a validação
						//-----------------------------------------------------
						
						_dNasc := CTOD(SUBSTR(DTOC(BA1->BA1_DATNASC),1,6) + SUBSTR(DTOC(dDataBase),7,4))
						dDtVali := YearSum(LastDate(_dNasc),(24 - Calc_Idade(LastDate(_dNasc),BA1->BA1_DATNASC)))
						
					EndIf
					
				EndIf
				
				If Empty(dDtVali)
					
					dDtVali := YearSum(LastDate(_dDtRenv),2)
					
				EndIf
				
				//------------------------------------------------------------
				//Gravando a data de validade correta, após as validações
				//------------------------------------------------------------
				MV_PAR04 := dDtVali
				
				RecLock("BA1", .F.)
				
				BA1->BA1_DTVLCR := dDtVali
				
				MsUnLock()
				
				If AllTrim(UPPER(FUNNAME())) == "PLSA262"
					
					M->BDE_DATVAL := dDtVali //Atualizando a tela da geração em lote
					
					dDtVali := YearSub(LastDate(dDtVali),1)
					
				Else
					
					RecLock("BDE", .F.)
					
					BDE->BDE_DATVAL := dDtVali
					
					BDE->(MsUnLock())
					
					DbSelectArea("BED")
					DbSetOrder(1)
					If DbSeek(xFilial("BED") + BA1->BA1_CODINT + BA1->BA1_CODEMP + BA1->BA1_MATRIC + BA1->BA1_TIPREG + BA1->BA1_DIGITO)
						
						RecLock("BED", .F.)
						
						BED->BED_DATVAL := dDtVali
						
						BDE->(MsUnLock())
						
					EndIf
					
				EndIf
				
				RestArea(_aAreBDE)
				RestArea(_aAreBED)
				RestArea(_aAreBA1)
				RestArea(_aAreBHH)
				
				//---------------------------------------------------------------
				// Fim - Angelo Henrique - Data:08/10/2015 - Chamado: 16312
				//---------------------------------------------------------------
				
			EndIf
			
		EndIf
		
	EndIf
	
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NegParc   ºAutor  ³Angelo Henrique     º Data ³  03/11/2015 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Valida se o beneficiário esta em negociação ou em possui    º±±
±±º          ³parcelamento                                                º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³CABERJ                                                      º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function NegParc(PEMP,PCODINT,PCODEMP,PMATRIC,PDATA)
	
	Local _cRet		:= ""
	Local _cQuery 	:= ""
	Local _cAliasQry	:= GetNextAlias()
	
	_cQuery := " SELECT "
	_cQuery += " RETORNA_SITUACAO_PARCELAMENTO( '" + PEMP + "', '" + PCODINT + "', '" + PCODEMP + "', '" + PMATRIC + "', '" + PDATA + "') SITUAC"
	_cQuery += " FROM DUAL"
	
	If Select(_cAliasQry)>0
		(_cAliasQry)->(DbCloseArea())
	EndIf
	
	DbUseArea(.T.,"TopConn",TcGenQry(,,_cQuery),_cAliasQry,.T.,.T.)
	
	DbSelectArea(_cAliasQry)
	
	If!((_cAliasQry)->(Eof()))
		
		_cRet := (_cAliasQry)->SITUAC
		
	EndIf
	
	If Select(_cAliasQry)>0
		(_cAliasQry)->(DbCloseArea())
	EndIf
	
Return _cRet