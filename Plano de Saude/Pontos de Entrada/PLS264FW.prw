#include "Protheus.CH"
#Define CRLF Chr(13)+Chr(10)
#DEFINE c_ent CHR(13) + CHR(10)


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³PLS264FW  ºAutor  ³Leonardo Portella   º Data ³  17/09/12   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³PE na gravacao do arquivo da carteirinha, apos todas as va- º±±
±±º          ³lidacoes do sistema e com o arquivo pronto para ser entregueº±±
±±º          ³a grafica.                                                  º±±
±±º          ³Utilizo este PE para gravar a data de validade, pois as     º±±
±±º          ³rotinas que utilizam a funcao PLSA264 estao utilizando como º±±
±±º          ³reemissao, pois assim nao gera cobrancas ao usuario.        º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³Caberj                                                      º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

************************************


//Static CRLF := CHR(13) + CHR(10)

************************************

User Function PLS264FW
	
	Local n_i := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS
	
	Local aArea			:= GetArea()
	Local aAreaBA1		:= BA1->(GetArea())
	Local aAreaBA3		:= BA3->(GetArea())  
	Local aAreaBTS		:= BTS->(GetArea()) //SERGIO CUNHA 13/05/2016
	Local cLinha 		:= PARAMIXB[1]
	Local aCart  		:= Separa(StrTran(cLinha,Chr(13)+Chr(10),''),';',.T.)
	Local cMatric 		:= ""
	Local dValidade		:= CtoD('//')
	Local dNovaValid 	:= CtoD('//')
	Local cLinhaIns 	:= StrTran(StrTran(cLinha,'"',''),CHR(13)+CHR(10),'')
	Local aLinhaIns 	:= Separa(cLinhaIns,';',.T.)
	Local cInsert		:= ''
	
	Local _lInaAd 	:= .F. //Angelo Henrique - Data:13/10/15
	Local _lNvCt 		:= .F. //Angelo Henrique - Data:13/10/15
	Local aDadUsr		:= {} 	//Angelo Henrique - Data:13/10/15
	Local cCodCli 	:= "" 	//Angelo Henrique - Data:13/10/15
	Local cLoja   	:= "" 	//Angelo Henrique - Data:13/10/15
	Local lRet			:= .T.	//Angelo Henrique - Data:13/10/15
	Local _dDtRenv 	:= CTOD(" / / ") //Angelo Henrique - Data: 27/10/15
	Local _dNasc 	 	:= CTOD(" / / ") //Angelo Henrique - Data: 15/02/16
	
	If !empty(aCart[4]) .and. !empty(aCart[7])
		
		cMatric		:= AllTrim(StrTran(StrTran(StrTran(aCart[7],'.',''),'-',''),'"',''))
		aCart[4]	:= StrTran(aCart[4],'"','')
		
		If ( len(cMatric) == 17 ) .and. ( len(aCart[4]) == 10 ) .and. ( Substr(aCart[4],3,1) == '/' ) .and. ( Substr(aCart[4],6,1) == '/' )
			
			dValidade	:= CtoD(aCart[4])
			
			BA1->(DbSetOrder(2))//BA1_FILIAL+BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG+BA1_DIGITO
			
			If BA1->(MsSeek(xFilial('BA1') + cMatric))
				
				BA3->(DbSetOrder(1))//BA3_FILIAL+BA3_CODINT+BA3_CODEMP+BA3_MATRIC+BA3_CONEMP+BA3_VERCON+BA3_SUBCON+BA3_VERSUB
				
				If BA3->(MsSeek(xFilial('BA3') + BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_CONEMP+BA1_VERCON+BA1_SUBCON+BA1_VERSUB) ))
					
					//-----------------------------------------------------------------------------
					// Inicio - Angelo Henrique - Data:13/10/2015 - Chamado: 16312
					//-----------------------------------------------------------------------------
					//Colocado a validação do FUNNAME pois na execução da rotina de geração
					//individual das carteirinhas passa por esse ponto, mas já realizou
					//a atualização no ponto de entrada PLS264EM.
					//Na geração individual é necessário estar no ponto de entrada PLS264EM
					//pois só passa nele, enquanto na geração em lote do fonte CABP999 só passa aqui
					//-----------------------------------------------------------------------------
					If UPPER(FUNNAME()) == "CABP999"
						
						DbSelectArea("BDE")
						DbSetOrder(1)
						If DbSeek(xFilial("BDE") + BA1->BA1_CODINT + BA1->BA1_CDIDEN)
							
							If BDE->BDE_MOTIVO $ "2|3" //Renovação
								
								lRet := .T.
								
							Else
								
								lRet := .F.
								
							EndIf
							
						EndIf
						
						//---------------------------------------------------------------
						// Inicio - Angelo Henrique - Data:08/10/2015 - Chamado: 16312
						// Mudança nas regras de validação para geração de carteirinha
						// Função para inadimplência (24 meses)
						//---------------------------------------------------------------
						If BA1->BA1_CODEMP == "0001" .And. BA1->BA1_SUBCON == "000000010"
							
							lRet := .F.
							
						ElseIf !(BA1->BA1_CODEMP $ "0001|0002|0005")
							
							lRet := .F.
							
						EndIf
						
						If lRet
							
							aDadUsr 	:= PLSDADUSR(BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG+BA1_DIGITO),"1",.F.,dDataBase,nil,nil,nil)
							
							cCodCli := aDadUsr[58]
							cLoja   := aDadUsr[59]
							
							//-------------------------------------------------------
							//PR - Título de negociação/parcelamento
							//-------------------------------------------------------
							If UPPER(AllTrim(NegParc("C",BA1->BA1_CODINT,BA1->BA1_CODEMP,BA1->BA1_MATRIC, DTOS(dDataBase)))) == "EM NEGOCIACAO"
								
								_lNvCt 	:= .T.
								_lNotEmt	:= .F.
								
							EndIf
							
							If !_lNvCt
								
								//--------------------------------------------------------------------------
								//Valida na data Atual se possui ou não título vencido mais de 60 dias
								//Para saber se esta ou não Inadimplente
								//Não gerar carteira caso esteja inadimplente
								//--------------------------------------------------------------------------
								_lDiaIna := u_IndimpCt(cCodCli,cLoja,"0")
								
								If _lDiaIna
									
									lRet := .F.
									
								EndIf
								
							EndIf
							
							If lRet
								
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
									_lNotEmt	:= .F.
									
								EndIf
								
							EndIf
							
						Else
							
							dDtVali := U_ValPLS264(dValidade)//Precisa estar ponteirado na BA1 e BA3
							
							
						EndIf
						
						If lRet
							
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
							
							dDtVali := CTOD(" / / ")
							
							//-----------------------------------------------------------
							//Caso tenha dado verdadeiro em alguma das validações
							//deve alterar a validade das carteiras para 2 anos
							//-----------------------------------------------------------
							If _lNvCt
								
								dDtVali := YearSum(LastDate(_dDtRenv),2)
								
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
								If BA1->BA1_TIPUSU == "D" .And. !(BA1->BA1_GRAUPA $ "02|03|04|25")
									
									//-----------------------------------------------------
									//Utilizando a data de validade que o beneficiário
									//receberá na carteira para realizar a validação
									//-----------------------------------------------------
									If Calc_Idade(dDtVali,BA1->BA1_DATNASC) >= 24
										
										_dNasc  := CTOD(SUBSTR(DTOC(BA1->BA1_DATNASC),1,6) + SUBSTR(DTOC(dDataBase),7,4))
										dDtVali := YearSum(LastDate(_dNasc),(24 - Calc_Idade(LastDate(_dNasc),BA1->BA1_DATNASC)))
										
									EndIf
									
								EndIf
								
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
							
							RecLock("BA1", .F.)
							
							BA1->BA1_DTVLCR := dDtVali
							
							MsUnLock()
							
						EndIf
						
					Else
						
						//dNovaValid	:= U_ValPLS264(dValidade)//Precisa estar ponteirado na BA1 e BA3
						dDtVali := U_ValPLS264(dValidade)//Precisa estar ponteirado na BA1 e BA3
						
					EndIf
					
					//--------------------------------------------------------------------------
					//Fim - Angelo - 13/10/2015
					//--------------------------------------------------------------------------
					
					
					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³Altero a validade no arquivo que sera enviado para impressao, caso esteja diferente do retornado pela ³
					//³funcao U_ValPLS264 (no PE PLS264DT), mantendo a coerencia entre o que consta no cadastro do usuario e ³
					//³na carteirinha.                                                                                       ³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					
					//------------------------------------------------------------------------------------
					//Angelo Henrique - Data:13/10/15
					//------------------------------------------------------------------------------------
					//If dValidade <> dNovaValid
					
					If dValidade <> dDtVali
						
						//------------------------------------------------------------------------------------
						//Angelo Henrique - Data:13/10/15
						//------------------------------------------------------------------------------------
						//aCart[4] 	:= '"' + StrZero(Day(dNovaValid),2) + '/' + StrZero(Month(dNovaValid),2) + '/' + StrZero(Year(dNovaValid),4) + '"'
						
						aCart[4] 	:= '"' + StrZero(Day(dDtVali),2) + '/' + StrZero(Month(dDtVali),2) + '/' + StrZero(Year(dDtVali),4) + '"'
						cLinha		:= ""
						
						For n_I := 1 to len(aCart)
							cLinha += aCart[n_I] + ';'
						Next
						
						cLinha := Left(cLinha,len(cLinha) - 1)//Retiro ultimo ';'
						cLinha += Chr(13) + Chr(10)
						
					EndIf
					
					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³Nao faco nenhuma outra validacao pois esta data de validade          ³
					//³e a que esta indo para a carteirinha e que sera entregue ao usuario, ³
					//³portanto deve ser esta validade na BA1.                              ³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					
					//-----------------------------------------------------------------------
					//Angelo Henrique - Data:13/10/15
					//-----------------------------------------------------------------------
					If UPPER(FUNNAME()) != "CABP999"
						
						If BA1->BA1_DTVLCR <> dDtVali
							
							BA1->(Reclock('BA1',.F.))
							BA1->BA1_DTVLCR := dDtVali
							BA1->(MsUnlock())
							
						EndIf
						
					EndIf
					
				EndIf
				
			EndIf
			
		EndIf
		
	EndIf
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Leonardo Portella - 14/11/12 - Inicio - Gravacao de dados para ³
	//³impressao da carteirinha na impressora Caberj.                 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	
	cLinhaIns 	:= StrTran(StrTran(cLinha,'"',''),CRLF,'')
	aLinhaIns 	:= Separa(cLinhaIns,';',.T.)
	
	cMatric		:= AllTrim(StrTran(StrTran(StrTran(aLinhaIns[7],'.',''),'-',''),'"',''))
	
	BA1->(DbSetOrder(2))//BA1_FILIAL+BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG+BA1_DIGITO
	
	BA1->(MsSeek(xFilial('BA1') + cMatric))
	
	BQC->(DbSetOrder(1))//BQC_FILIAL + BQC_CODIGO + BQC_NUMCON + BQC_VERCON + BQC_SUBCON + BQC_VERSUB
	
	BQC->(MsSeek(xFilial("BQC") + BA1->(BA1_CODINT + BA1_CODEMP + BA1_CONEMP + BA1_VERCON + BA1_SUBCON + BA1_VERSUB)))
	
	BI3->(DbSetOrder(1))//BI3_FILIAL + BI3_CODINT + BI3_CODIGO + BI3_VERSAO
	
	BI3->(MsSeek(xFilial("BI3") + BA1->(BA1_CODINT + BA1_CODPLA)))   

	//Sergio Cunha - 13/05/2016 - Inicio
	BTS->(DbSetOrder(1))//BTS_FILIAL+BTS_MATVID	 
	BTS->(MsSeek(xFilial("BTS") + BA1->BA1_MATVID))
	//Sergio Cunha - 13/05/2016 - Fim
	
	cInsert := "INSERT INTO CART_ASSOCIADO VALUES ( " 				 										+ CRLF
	cInsert += "( SELECT NVL(MAX(ID),0) + 1 FROM CART_ASSOCIADO ) ," 										+ CRLF //ID
	cInsert += "'" + If(!empty(BQC->BQC_NOMCAR),AllTrim(BQC->BQC_NOMCAR),aLinhaIns[3]) + "'," 	 		+ CRLF //Empresa
	cInsert += "'" + DtoS(CtoD(aLinhaIns[4])) + "'," 				  										+ CRLF //Validade
	
	//Leonardo Portella - 09/01/13 - Fazer tratamento para remover aspas simples pois gera erro no insert
	//cInsert += "'" + StrTran(aLinhaIns[6],"'"," ") + "',"				 									+ CRLF //Nome
	cInsert += "'" + SubStr(BA1->BA1_NOMUSR,1,50) + "',"													+ CRLF //Nome
	
	cInsert += "'" + aLinhaIns[7] + "'," 																	+ CRLF //Matricula
	cInsert += "'" + If(!empty(BI3->BI3_DESCAR),AllTrim(BI3->BI3_DESCAR),aLinhaIns[9]) + "',"				+ CRLF //Plano
	
	//BIANCHINI - 20/08/2014 - TRATAR QUARTO COLETIVO
	//cInsert += "'" + If(aLinhaIns[10] == 'APARTAMENT','APARTAMENTO',aLinhaIns[10])+ "'," 					+ CRLF //Acomodacao
	If (aLinhaIns[10] $ 'APARTAMENT|INDIVIDUAL' )
		cInsert += "'ACOMODAÇÃO INDIVIDUAL'"	+ "," + CRLF //Acomodacao
	ElseIf (aLinhaIns[10] == 'COLETIVO')
		cInsert += "'ACOMODAÇÃO COLETIVA'" + "," + CRLF //Acomodacao
	Else
		cInsert += aLinhaIns[10] + ","  + CRLF //Acomodacao
	Endif
	
	cInsert += "'" + DtoS(BA1->BA1_DATNAS) + "'," 															+ CRLF //Data nascimento
	
	//Leonardo Portella - 27/12/12 - Inicio - Pegar informacoes de carencia
	
	aCarencias := Separa(aLinhaIns[17],'_',.F.)
	
	cInsert += "'" + If(len(aCarencias) >= 1 .and. !empty(aCarencias[1]),AllTrim(Posicione('BAT',1,xFilial("BAT") + PLSINTPAD() + aCarencias[1],'BAT_DESCRI'));
		+ ' ATE ' + aLinhaIns[11],Space(8)) + "',"		+ CRLF 	//Carencia1
	
	cInsert += "'" + If(len(aCarencias) >= 2 .and. !empty(aCarencias[2]),AllTrim(Posicione('BAT',1,xFilial("BAT") + PLSINTPAD() + aCarencias[2],'BAT_DESCRI'));
		+ ' ATE ' + aLinhaIns[12],Space(8)) + "'," 	+ CRLF 	//Carencia2
	
	cInsert += "'" + If(len(aCarencias) >= 3 .and. !empty(aCarencias[3]),AllTrim(Posicione('BAT',1,xFilial("BAT") + PLSINTPAD() + aCarencias[3],'BAT_DESCRI'));
		+ ' ATE ' + aLinhaIns[13],Space(8)) + "'," 	+ CRLF 	//Carencia3
	
	//Leonardo Portella - 27/12/12 - Fim
	
	cInsert += "'" + BDE->BDE_CODIGO + "',"								 									+ CRLF //Lote
	cInsert += "' ',"													 									+ CRLF //Data de impressao
	cInsert += "' ',"													 									+ CRLF //Hora da impressao
	cInsert += "' ',"													 									+ CRLF //Login
	cInsert += "'0',"														 									+ CRLF //Quantidade impressa
	cInsert += "'" + If(cEmpAnt == '01','CABERJ','INTEGRAL') + "',"	 									+ CRLF //Caberj ou Integral
	cInsert += "'" + If(BA1->BA1_CODPLA $ '0036|0037','SIM','NAO') + "',"									+ CRLF //Odontologico
	//Sergio Cunha - 12/05/15 - Inicio - Pegar informacoes da rede
	cSQL := " SELECT BB6_CODRED CODRED "
	cSQL += "      , TRIM(BI5_DESCRI) DESRED "
	cSQL += "   FROM " +RetSqlName("BB6")+ " BB6 "
	cSQL += "      , " +RetSqlName("BI5")+ " BI5 "
	cSQL += "  WHERE BB6_FILIAL = '"+xFilial("BB6")+"'"
	cSQL += "    AND BI5_FILIAL = '"+xFilial("BI5")+"'"
	cSQL += "    AND BB6_CODIGO = '" + BA1->(BA1_CODINT+BA1_CODPLA) + "'"
	cSQL += "    AND BB6_ATIVO = '1' "
	cSQL += "    AND BB6_CODRED = BI5_CODRED "
	cSQL += "    AND BB6.D_E_L_E_T_ = ' ' "
	cSQL += "    AND BI5.D_E_L_E_T_ = ' ' "
	
	PlsQuery(cSQL, "TRBRED")
	
	If !Empty(TRBRED->DESRED)
		cInsert += "'" + TRIM(TRBRED->DESRED)+ "'," + CRLF //REDE
	Else	                                    //Motta 9/11/15
		cInsert += "''," + CRLF //REDE nula  //Motta 9/11/15
	endif
	TRBRED->(DbCloseArea())
	//MENSAGEM ADU
	cCodint		:=	BA1->BA1_CODINT
	cCodemp		:=	BA1->BA1_CODEMP
	cMatric		:=	BA1->BA1_MATRIC
	cTipreg		:=	BA1->BA1_TIPREG
	cConemp		:=	BA1->BA1_CONEMP
	cVercon		:=	BA1->BA1_VERCON
	cSubcon		:=	BA1->BA1_SUBCON
	cVersub		:=	BA1->BA1_VERSUB
	cCodpla		:=	BA3->BA3_CODPLA
	cVerpla		:=	BA3->BA3_VERSAO
	cOpcional	:=	'0023'
	cVeropc		:=	'001'
	
	If u_ChkOpc(cCodint, cCodemp, cMatric, cTipreg, cConemp, cVercon, cSubcon, cVersub, cCodpla, cVerpla, cOpcional, cVeropc)
		cInsert += "'" + GetMV("MV_YMSGADU")+ "'," + CRLF //ADU
	Else                                     //Motta 9/11/15
		cInsert += "'',"  + CRLF //ADU NULO  //Motta 9/11/15
	endif
	//Sergio  Cunha - 12/05/15 - Fim  
	//Sergio  Cunha - 13/05/16 - Inicio       
	If !Empty(BTS->BTS_NRCRNA)
   		cInsert += "'" + BTS->BTS_NRCRNA+ "'" + CRLF //CNS  
	Else 
		cInsert += "''"  + CRLF ////CNS  NULO 
	endif
	//Sergio  Cunha - 13/05/16 - Fim  
	cInsert += " )" 													 									+ CRLF
	If ( TcSqlExec(cInsert) < 0 )
		MsgStop("Erro na insercao de dados na tabela 'CART_ASSOCIADO'" + CRLF + CRLF + TcSqlError(),AllTrim(SM0->M0_NOMECOM))
	EndIf
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Leonardo Portella - 14/11/12 - Fim ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	
	BA1->(RestArea(aAreaBA1))
	BA3->(RestArea(aAreaBA3))   
	BTS->(RestArea(aAreaBTS))
	RestArea(aArea)
	
Return cLinha

*************************************************************************************************************************

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