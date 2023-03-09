#INCLUDE 'PROTHEUS.CH'
#DEFINE c_ent CHR(13) + CHR(10)

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Programa  �PLS262GR � Autor � Angelo Henrique      � Data � 04/11/2015 ���
�������������������������������������������������������������������������Ĵ��
���Descri��o � Ponto de entrada utilizado no final da rotina de gera��o de���
���          � carteiras em lote fonte PLS262.                            ���
�������������������������������������������������������������������������Ĵ��
���Rela��o   � Chamado ao finalizar o processo de gera��o de carterias em ���
���          � lotes, nesse ponto o arquivo .txt j� foi criado, por isso  ���
���          � al�m de atualizar as tabelas envolvidas, � necess�rio que  ���
���          � se atualize o arquivo txt dependo da altera��o.            ���
�������������������������������������������������������������������������Ĵ��
���Uso       � CABERJ                                                     ���
�������������������������������������������������������������������������Ĵ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/

User Function PLS262GR()
	
	Local _aArea 		:= GetArea()
	Local _aArBDE 	:= BDE->(GetArea())
	Local _aArBED 	:= BED->(GetArea())
	Local _aArBA1 	:= BA1->(GetArea())
	Local _lInaAd		:= .F. //Angelo Henrique - Data:09/10/15
	Local _lNvCt 		:= .F. //Angelo Henrique - Data:09/10/15
	Local _dDtRenv 	:= CTOD(" / / ")
	Local dDtVali		:= CTOD(" / / ")
	Local aDadUsr 	:= {}
	Local cCodCli 	:= ""
	Local cLoja   	:= ""
	
	If BDE->BDE_MOTIVO $("2|3")
		
		DbSelectArea("BED")
		DbSetOrder(4)
		If DbSeek(xFilial("BED")+BDE->BDE_CODIGO)
			
			While BED->(!EOF()) .AND. BDE->BDE_CODIGO == BED->BED_CDIDEN
				
				DbSelectArea("BA1")
				DbSetOrder(2)
				If DbSeek(xFilial("BA1")+BED->BED_CODINT + BED->BED_CODEMP + BED->BED_MATRIC + BED->BED_TIPREG + BED->BED_DIGITO)
					
					If BA1->BA1_CODEMP == "0001" .And. BA1->BA1_SUBCON == "000000010"
						
						Exit
						
					ElseIf !(BA1->BA1_CODEMP $ "0001|0002|0005")
						
						Exit
						
					EndIf
					
					_lNvCt 	:= .F.
					_lInaAd	:= .F.
					dDtVali 	:= CTOD(" / / ")
					_dDtRenv	:= CTOD(" / / ")
					
					aDadUsr := PLSDADUSR(BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG+BA1_DIGITO),"1",.F.,dDataBase,nil,nil,nil)
					cCodCli := aDadUsr[58]
					cLoja   := aDadUsr[59]
					
					//-------------------------------------------------------
					//PR - T�tulo de negocia��o
					//-------------------------------------------------------
					If UPPER(AllTrim(NegParc("C",BA1->BA1_CODINT,BA1->BA1_CODEMP,BA1->BA1_MATRIC, DTOS(dDataBase)))) == "EM NEGOCIACAO"
						
						_lNvCt := .T.
						
					EndIf
					
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
							//PR - T�tulo de parcelamento
							//-------------------------------------------------------
							If !_lNvCt
								
								If UPPER(AllTrim(NegParc("C",BA1->BA1_CODINT,BA1->BA1_CODEMP,BA1->BA1_MATRIC, DTOS(dDataBase)))) == "EM PARCELAMENTO"
									
									_lNvCt 	:= .T.
									
								EndIf
								
							EndIf
							
							//-------------------------------------------------------
							//A��o Judicial/ANS e n�o ter ca�do nas regras anteriores
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
										//- 004 A��o Judicial
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
					//MATER recebe como data de renova��o ABRIL
					//Afinidade recebe como data de renova��o Novembro
					//----------------------------------------------------
					If BA1->BA1_CODEMP $ "0002|0005" //Afinidade
						
						_dDtRenv := GETMV("MV_XRENOVA")
						
					ElseIf BA1->BA1_CODEMP = "0001" //Mater
						
						_dDtRenv := GETMV("MV_XRENOV1")
						
					EndIf
					
					//---------------------------------------------------
					//Colocando no ano atual
					//---------------------------------------------------
					_dDtRenv := YearSum(_dDtRenv,1)
					
					dDtVali := CTOD(" / / ")
					
					//-----------------------------------------------------------
					//Caso tenha dado verdadeiro em alguma das valida��es
					//deve alterar a validade das carteiras para 2 anos
					//-----------------------------------------------------------
					If _lNvCt
						
						dDtVali := YearSum(LastDate(_dDtRenv),2)
						
					Else //Sen�o cair nas regras gerais de validade
						
						//--------------------------------------------------------------
						//Regra para idade													|
						//Quantidade de tempo que o benefici�rio possui o plano			|
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
					//1.2 Condi��es de renova��o para dependentes
					//---------------------------------------------------------------------------------------------------------------------
					//	1.2.1 Dependentes at� 24 anos (respeitando as da data de validade at� o limite de 24, anos, salvo casos especiais)
					//	1.2.2 Dependentes (c�njugue e/ou filhos maiores de 24 anos em condi��es especiais - filhos especiais e etc) - ir�o
					//	respeitar as regras gerais de validade com base no tempo do plano
					//---------------------------------------------------------------------------------------------------------------------
					//C�digos gravados no benefici�rios:
					// 02 - Esposa
					// 03 - Companheiro(a)
					// 04 - Esposo
					// 25 - Filho Especial
					//---------------------------------------------------------------------------------------------------------------------
					
					//-------------------------------------------------------------------------------
					//Validar se � dependente e n�o for especial ou marido e mulher (Conjuge)
					//precisa estar na regra de que a validade s� poder� ser at� 24 anos
					//-------------------------------------------------------------------------------
					If BA1->BA1_TIPUSU == "D" .And. !(BA1->BA1_GRAUPA $ "02|03|04|08|25")
						
						//---------------------------------------------------------------------------
						//Tratando os benefici�rios dependentes, por�m maiores que 90 anos de idade
						//---------------------------------------------------------------------------
						If Calc_Idade(dDtVali,BA1->BA1_DATNASC) >= 90
							
							_dNasc := CTOD(SUBSTR(DTOC(BA1->BA1_DATNASC),1,6) + SUBSTR(DTOC(dDataBase),7,4))
							dDtVali := YearSum(LastDate(_dNasc),2)
							
						ElseIf Calc_Idade(dDtVali,BA1->BA1_DATNASC) >= 24
							
							//-----------------------------------------------------
							//Utilizando a data de validade que o benefici�rio
							//receber� na carteira para realizar a valida��o
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
					
					
					RecLock("BED", .F.)
					
					BED->BED_DATVAL := dDtVali
					
					BDE->(MsUnLock())
					
				EndIf
				
				BED->(DbSkip())
				
			EndDo
			
		EndIf
		
		//----------------------------------
		//Rotina para atualizar o arquivo
		//----------------------------------
		Processa({||AtuCart()},'Ajuste Carteirinha','Processando...',.F.)
		
		
	EndIf
	
	RestArea(_aArea)
	RestArea(_aArBA1)
	RestArea(_aArBED)
	RestArea(_aArBDE)
	
Return

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �NegParc   �Autor  �Angelo Henrique     � Data �  03/11/2015 ���
�������������������������������������������������������������������������͹��
���Desc.     �Valida se o benefici�rio esta em negocia��o ou em possui    ���
���          �parcelamento                                                ���
�������������������������������������������������������������������������͹��
���Uso       �CABERJ                                                      ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
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


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �AtuCart   �Autor  �Angelo Henrique     � Data �  05/11/2015 ���
�������������������������������������������������������������������������͹��
���Desc.     �Rotina respons�vel pela atualiza��o do arquivo de carteiras ���
���          �no processo de renova��o MATER e AFINIDADE                  ���
�������������������������������������������������������������������������͹��
���Uso       �CABERJ                                                      ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

Static Function AtuCart
	
	Local nOpca 		:= 0//Somente servidor
	Local cArq 		:= ''
	Local cPath		:= ''
	Local aArqs		:= ''
	Local nI			:= 0
	
	Local cLine		:= ''
	Local aLine		:= {}
	Local nQtd 		:= 0
	Local nI			:= 0
	Local nHandle 	:= FT_FUse(AllTrim(BDE->BDE_DIRGRV) + AllTrim(BDE->BDE_CODIGO) + ".TXT" )
	Local nHdl			:= 0
	Local aCabec		:= {}
	Local cMsg			:= ''
	Local aNewArq		:= {}
	Local cBuffer		:= ''
	Local nLinOri		:= 0
	Local _cMat		:= ""
	Local _cQuery 	:= ""
	Local _cAliasQry	:= GetNextAlias()
	
	Private aFiles
	Private aSizes
	
	FT_FGoTop()
	
	nLinOri := FT_FLastRec()
	cTot 	:= AllTrim(Transform(nLinOri, "@E 999,999,999"))
	
	ProcRegua(nLinOri)
	
	nQtd := 0
	
	FT_FGoTop()
	
	While !FT_FEOF()
		
		IncProc('Linha: ' + AllTrim(Transform(++nQtd, "@E 999,999,999")) + ' de ' + cTot)
		
		cLine := FT_FReadLn() // Retorna a linha corrente
		
		aLine := Separa(cLine,';',.T.)
		
		If len(aLine) > 0
			
			_cMat := Replace(aLine[7]	,'.','')
			_cMat := Replace(_cMat		,'-','')
			_cMat := REPLACE(_cMat		,'"','')
			
			_cQuery := " SELECT BA1_DTVLCR "
			_cQuery += " FROM " + RetSqlName("BA1")+ " BA1 "
			_cQuery += " WHERE BA1_CODINT||BA1_CODEMP||BA1_MATRIC||BA1_TIPREG||BA1_DIGITO = '" + _cMat + "'"
			_cQuery += " AND D_E_L_E_T_ = ' ' "
			
			If Select(_cAliasQry)>0
				(_cAliasQry)->(DbCloseArea())
			EndIf
			
			DbUseArea(.T.,"TopConn",TcGenQry(,,_cQuery),_cAliasQry,.T.,.T.)
			
			DbSelectArea(_cAliasQry)
			
			If!((_cAliasQry)->(Eof()))
				
				aLine[4] := + '"' + DTOC(STOD((_cAliasQry)->BA1_DTVLCR)) + '"'
				cLine := ""
				For nI := 1 to len(aLine)
					cLine += aLine[nI] + ';'
				Next
				
				aAdd(aNewArq,cLine)
				
			EndIf
			
		EndIf
		
		If Select(_cAliasQry)>0
			(_cAliasQry)->(DbCloseArea())
		EndIf
		
		FT_FSKIP()
		
	EndDo
	
	// Fecha o Arquivo
	FCLOSE(nHandle)
	FT_FUSE()
	
	If File(AllTrim(BDE->BDE_DIRGRV) + AllTrim(BDE->BDE_CODIGO) + ".TXT")
		If ( FErase(AllTrim(BDE->BDE_DIRGRV) + AllTrim(BDE->BDE_CODIGO) + ".TXT") <> 0 )
			MsgStop('Erro ao deletar o arquivo [ ' + AllTrim(BDE->BDE_DIRGRV) + AllTrim(BDE->BDE_CODIGO) + ".TXT" + ' ].' + CRLF + 'Opera��o cancelada...',AllTrim(SM0->M0_NOMECOM))
			Return
		EndIf
	EndIf
	
	nHdl := FCreate(AllTrim(BDE->BDE_DIRGRV) + AllTrim(BDE->BDE_CODIGO) + ".TXT")
	
	nQtd := len(aNewArq)
	cTot := AllTrim(Transform(nQtd, "@E 999,999,999"))
	
	ProcRegua(nQtd)
	
	For nI := 1 to len(aNewArq)
		
		IncProc('Gerando arquivo. Linha: ' + AllTrim(Transform(nI, "@E 999,999,999")) + ' de ' + cTot)
		
		cBuffer	:= aNewArq[nI] + CRLF
		
		FWrite(nHdl,cBuffer,len(cBuffer))
		
	Next
	
	FClose(nHdl)
	
	If File(AllTrim(BDE->BDE_DIRGRV) + AllTrim(BDE->BDE_CODIGO) + ".TXT")
		cMsg := 'Ajuste de carteirinhas Renova��o finalizado!' 					+ CRLF
		cMsg += '- Arquivo [ ' + AllTrim(BDE->BDE_DIRGRV) + AllTrim(BDE->BDE_CODIGO)+ ' ] gerado.' 				+ CRLF
		cMsg += '- Arquivo original [ ' + cValToChar(nLinOri) + ' linhas ]' 		+ CRLF
		cMsg += '- Arquivo gerado [ ' + cValToChar(len(aNewArq)) + ' linhas ]' 		+ CRLF
		
		MsgAlert(cMsg,AllTrim(SM0->M0_NOMECOM))
	Else
		MsgStop('Ocorreu algum erro na cria��o do arquivo [ ' + AllTrim(BDE->BDE_DIRGRV) + AllTrim(BDE->BDE_CODIGO) + ' ]. Verifique...',AllTrim(SM0->M0_NOMECOM))
	EndIf
	
Return