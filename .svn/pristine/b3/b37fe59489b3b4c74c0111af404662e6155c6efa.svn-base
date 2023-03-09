#INCLUDE "PROTHEUS.CH"
#DEFINE c_ent CHR(13) + CHR(10)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³PLS264EM ³ Autor ³ Eduardo Motta        ³ Data ³ 17.11.2005 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Analisa a necessidade de gerar carteirinha para o usuario  ³±±
±±³          ³ posicionado (BA1).                                         ³±±
±±³          ³ Ponto de entrada para nao gerar carteirinha de usuarios    ³±±
±±³          ³ inadimplentes.                                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ Advanced Protheus                                          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function Pls264Em()
	
	Local nTipo 	:= ParamIxb[1]
	Local nAtraso  	:= 0
	Local nDiasAtr 	:= 0
	LOCAL nDiasPar  := GETMV("MV_PLDIADB")
	LOCAL cPosTit   := alltrim(GetNewPar("MV_PLPOSTI","1")) // 1-titulos em aberto  2-titulos em aberto/baixados
	LOCAL cTipAtr   := alltrim(GetNewPar("MV_PLTIPAT","2")) // 1-dias corridos  2-dias acumulados
	Local nSaldo 	:= 0.00
	Local nTits  	:= 0
	LOCAL cCodCli   := ""
	LOCAL cLoja     := ""
	LOCAL cNivCob	:= ""
	Local aDadUsr
	Local dData     := dDataBase
	Local cCodInt   := BA1->BA1_CODINT
	Local cCodEmp   := BA1->BA1_CODEMP
	Local cConEmp   := BA1->BA1_CONEMP
	Local cSubCon   := BA1->BA1_SUBCON
	Local cMatrUs   := BA1->BA1_MATRIC
	Local lRet		:= .T.
	
	//Leonardo Portella - 19/07/11 - Inicio
	//Regra definida com Carla Torres e Simone (cadastro)
	
	Local dDataConsid := If(allTrim(Upper(FunName())) == 'PLSA262', M->BDE_DTRNCR, dDataBase)
	
	Local nMesLim 	:= 2 //Quantidade de meses a considerar a partir da data do subcontrato
	Local nMes		:= Month(dDataConsid) + nMesLim
	Local cMes		:= strZero( If( nMes > 12, nMes % 12, nMes ),2 )
	Local cAno		:= cValToChar( If( nMes > 12, Year(dDataConsid) + 1, Year(dDataConsid) ) )
	Local dLimite 	:= StoD(cAno + cMes + strZero(Day(dDataConsid),2))
	Local nIdadeFut	:= nCalcIdade(BA1->BA1_DATNAS, dLimite)
	Local lDepend	:= BA1->BA1_TIPUSU == 'D'
	Local lMater	:= BA1->BA1_CODPLA == '0001'
	Local lGrauPar	:= BA1->BA1_GRAUPA $ '05|06|12|13|23|24' //(BRP) Graus de parentesco aos quais se aplica a regra
	
	Local _lInaAd  := .F. //Angelo Henrique - Data:09/10/15
	Local _lNvCt 	 := .F. //Angelo Henrique - Data:09/10/15
	Local _lNotEmt := .T. //Angelo Henrique - Data:09/10/15
	Local _aAreBHH := BHH->(GetArea()) //Angelo Henrique - Data:09/10/15
	Local _aAreBA1 := BA1->(GetArea()) //Angelo Henrique - Data:13/10/15
	Local _aAreBED := BED->(GetArea()) //Angelo Henrique - Data:13/10/15
	Local _aAreBDE := BDE->(GetArea()) //Angelo Henrique - Data:13/10/15
	Local lRenv	 := .T. //Angelo Henrique - Data: 16/10/15
	Local _dDtRenv := CTOD(" / / ") //Angelo Henrique - Data: 27/10/15
	Local _dNasc 	 := CTOD(" / / ") //Angelo Henrique - Data: 15/02/16
	
	Private aCritica := {}
	
	//If ( cEmpAnt == '01' .and. lMater .and. lDepend .and. lGrauPar .and. nIdadeFut >= 24 ) .or. ( !empty(BA1->BA1_YDTLIM) .and. dLimite > BA1->BA1_YDTLIM )
	If ( cEmpAnt == '01' .and. lMater .and. lDepend .and. lGrauPar .and. nIdadeFut >= 24 )
		Return .F.
	EndIf
	
	If !empty(BA1->BA1_YDTLIM) .and. dLimite > BA1->BA1_YDTLIM
		
		If Alltrim(FunName()) <> "PLSA262"
			
			MsgAlert("A Data Limite informada impede a geração de carteira.","Atencao!")
			
		EndIf
		
		Return .F.
		
	EndIf
	
	//Leonardo Portella - 19/07/11 - Fim
	
	//Leonardo Portella - 20/07/11 - Considerar a data de bloqueio futuro
	If ( !empty(BA1->BA1_DATBLO) .and. BA1->BA1_DATBLO <= dLimite )
		Return .F.
	EndIf
	
	//Leonardo Portella - 16/09/11 - Nao imprimir se o usuario estiver bloqueado
	If BA1->BA1_IMAGE != 'ENABLE'
		Return .F.
	EndIf
	
	
	//--------------------------------------------------------------------------
	//Angelo Henrique - data:17/09/2015
	//--------------------------------------------------------------------------
	// Chamado: 19614
	//--------------------------------------------------------------------------
	//Tendo em vista reunião Suope e Surem,
	//foi definido para criar mecanismo do sistema não
	//gerar carteira p/ dependentes que completou 18 anos e está SEM CPF
	//--------------------------------------------------------------------------
	
	If UPPER(AllTrim(BA1->BA1_TIPUSU))== "D" .And. Empty(BA1->BA1_CPFUSR)
		
		If BA1->BA1_CODEMP != "0004" //Reciprocidade - Chamado 21857 - não olhar esta regra.
			
			//-------------------------------------
			// Função padrão para calcular idade
			//-------------------------------------
			// Calc_Idade
			//-------------------------------------
			If Calc_Idade(ddatabase,BA1->BA1_DATNASC) >= 18
				
				lRet := .F.
				Aviso("Atenção","Dependente possui idade maior ou igual a 18 anos e não tem CPF cadastrado, Cartão não será gerado! Favor atualizar.", {"OK"})
				Return .F.
				
			EndIf
			
		EndIf
		
	EndIf
	
	**'----------------------------------------------'**
	**'-- Marcela Coimbra -- Data: 23/09/2010      --'**
	**'----------------------------------------------'**
	If cEmpAnt == "02" .and. fVerNivel(cCodInt, cCodEmp, cMatrUs) < "4"
		
		Return .T.
		
	EndIf
	
	If nTipo # 2 .and. nTipo # 3
		Return .T.
	EndIf
	
	aDadUsr 	:= PLSDADUSR(BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG+BA1_DIGITO),"1",.F.,dDataBase,nil,nil,nil)
	
	If !aDadUsr[1]
		Return .F.
	EndIf
	
	If ! cPosTit $ "1,2" // 1-titulos em aberto  2-titulos em aberto/baixados
		cPosTit := "1"    // default = 1 porque os primeiros clientes tratavam assim
	Endif
	If ! cTipAtr $ "1,2"   // 1-Dias Corridos  2-Dias Acumulados
		cTipAtr := "2"      // default = 2 porque os primeiros clientes tratavam assim
	Endif
	
	cCodCli := aDadUsr[58]
	cLoja   := aDadUsr[59]
	cNivCob := aDadUsr[61]
	
	//---------------------------------------------------------------
	// Inicio - Angelo Henrique - Data:08/10/2015 - Chamado: 16312
	// Mudança nas regras de validação para geração de carteirinha
	// Função para inadimplência (24 meses)
	//---------------------------------------------------------------
	If BA1->BA1_CODEMP == "0001" .And. BA1->BA1_SUBCON == "000000010"
		
		lRenv := .F.
		
	ElseIf !(BA1->BA1_CODEMP $ "0001|0002|0005")
		
		lRenv := .F.
		
	EndIf
	
	//-------------------------------------------
	//Validação para saber se é ou não renovação
	// 2 - Renovação de contrato PJ(Custo OPER)
	// 3 - Renovação de contrato PF PJ(Pre PAGTO)
	//-------------------------------------------
	If !(MV_PAR02 $("2|3"))
		
		lRenv := .F.
		
	EndIf
	
	If AllTrim(UPPER(FUNNAME())) == "PLSA262"
		
		If M->BDE_MOTIVO $("2|3")
			
			lRenv := .T.
			
		Else
			
			lRenv := .F.
			
		EndIf
		
	EndIf
	
	
	If lRet
		
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
			
			If _lDiaIna .And. AllTrim(BA1->BA1_XLIBCA) != "L"
				
				lRet := .F.
				
				If AllTrim(UPPER(FUNNAME())) == "PLSA261"
					
					Alert("Carteira não será gerada, inadimplente por mais de 60 dias")
					
				EndIf
				
			EndIf
			
		EndIf
		
		If lRet .And. lRenv
			
			If !_lNvCt
				
				//Adimplente ou Inadimplente em 60 dias (data atual)
				_lInaAd := u_IndimpCt(cCodCli,cLoja,"1")
				
				If !_lInaAd //Adimplente na Data Atual (60 Dias)
					
					//-------------------------------------------------------
					//Estar inadimplente 24 meses por mais de 60 dias
					//-------------------------------------------------------
					If u_IndimpCt(cCodCli,cLoja,"2")
						
						_lNvCt := .T.
						_lNotEmt	:= .F.
						
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
							_lNotEmt	:= .F.
							
						EndIf
						
						If BA1->BA1_CODEMP == "0002" .And. BA1->BA1_SUBCON == "000000008"
							
							_lNvCt := .T.
							_lNotEmt	:= .F.
							
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
									_lNotEmt	:= .F.
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
			
		EndIf
		
	EndIf
	//---------------------------------------------------------------
	// Fim - Angelo Henrique - Data:08/10/2015 - Chamado: 16312
	// Mudança nas regras de validação para geração de carteirinha
	//---------------------------------------------------------------
	
	If _lNotEmt  .And. AllTrim(BA1->BA1_XLIBCA) != "L"//Angelo Henrique - Data: 09/10/2015 -- Validação de inadimplência, para poder verificar ou não os títulos
		
		If cPosTit == "1" // considerar apenas titulos em aberto
			SE1->(DbSetOrder(8))
			If SE1->(DbSeek(xFilial("SE1")+cCodCli+cLoja+"A"))
				While ! SE1->(Eof()) .And. SE1->(E1_FILIAL+E1_CLIENTE+E1_LOJA+E1_STATUS) == xFilial("SE1")+cCodCli+cLoja+"A"
					
					If dtos(dData) > dtos(SE1->E1_VENCREA) 
						If ( cNivCob >= "4" .And. SE1->(E1_CODINT+E1_CODEMP+E1_MATRIC) == cCodInt+cCodEmp+cMatrUs ) .Or. ;
								( cNivCob <  "4" .And. SE1->(E1_CODINT+E1_CODEMP+E1_CONEMP+E1_SUBCON) == cCodInt+cCodEmp+cConEmp+cSubCon )
							nAtraso   := dData - SE1->E1_VENCREA
							If  cTipAtr == "1"
								nDiasAtr := If(nAtraso > nDiasAtr,nAtraso,nDiasAtr) // para dias corridos, utiliza o maior atraso
							Else
								nDiasAtr += nAtraso  // para dias acumulados, acumula os atrasos
							Endif
							**'----------------------------------------------'**
							**'-- Marcela Coimbra -- Data: 31/08/2011      --'**
							**'-- Motivo: Nao considerar titulos de RLE    --'**
							**'-- como inadimplência                       --'**
							**'-- Inicio ------------------------------------'**
							
							// 0     += 1
							
							//-----------------------------------------------------------------
							//Angelo Henrique - Data: 20/08/2018
							//-----------------------------------------------------------------
							//Chamado: 51764 - Estar inadimplente por mais de 60 dias
							//-----------------------------------------------------------------
							//If SE1->E1_PREFIXO == 'PLS' .AND.  SE1->E1_TIPO <> 'PR' .and. (!Empty(SE1->E1_MATRIC) .AND. SE1->E1_CODEMP <> '0024' )
		
							//-----------------------------------------------------------------
							//Mateus Medeiros  - Data: 23/11/2018
							//-----------------------------------------------------------------
							//Chamado: 54125 - correção da validação em questão
							//-----------------------------------------------------------------
							//If SE1->E1_PREFIXO == 'PLS' .AND.  SE1->E1_TIPO <> 'PR' .and. (!Empty(SE1->E1_MATRIC) .AND. SE1->E1_CODEMP <> '0024' ) .And. nDiasAtr > 60  
							If SE1->E1_PREFIXO == 'PLS' .AND.  SE1->E1_TIPO <> 'PR' .and. (!Empty(SE1->E1_MATRIC) .AND. SE1->E1_CODEMP <> '0024' ) .And. nDiasAtr > 60 .And. SE1->E1_SALDO > 0  	
								nTits     += 1
								
								aadd( aCritica, { SE1->E1_PREFIXO, SE1->E1_NUM, SE1->E1_PARCELA, SE1->E1_TIPO, SE1->E1_CLIENTE, DTOC(SE1->E1_VENCREA) })
								
							EndIf
							
							**'----------------------------------------------'**
							**'-- Marcela Coimbra -- Data: 31/08/2011      --'**
							**'-- Fim  --------------------------------------'**
							
							nSaldo    += SE1->E1_SALDO
						Endif
					Endif
					SE1->(DbSkip())
				Enddo
			Endif
		Else  // considerar titulos em aberto/baixados
			dDatIni := dData - 365 // verifica ate 1 anos atras
			SE1->(DbSetOrder(8))
			If SE1->(DbSeek(xFilial("SE1")+cCodCli+cLoja))
				While ! SE1->(Eof()) .And. SE1->(E1_FILIAL+E1_CLIENTE+E1_LOJA) == xFilial("SE1")+cCodCli+cLoja
					If dtos(dData)   >  dtos(SE1->E1_VENCREA) .and. ;
							dtos(dDatIni) <= dtos(SE1->E1_EMISSAO)
						If ( BA3->BA3_TIPOUS == "1" .And. SE1->(E1_CODINT+E1_CODEMP+E1_MATRIC) == cCodInt+cCodEmp+cMatrUs ) .Or. ;
								( BA3->BA3_TIPOUS == "2" .And. SE1->(E1_CODINT+E1_CODEMP) == cCodInt+cCodEmp )
							If  SE1->E1_SALDO == 0
								nAtraso   := SE1->E1_BAIXA - SE1->E1_VENCREA
							Else
								nAtraso   := dData - SE1->E1_VENCREA
							Endif
							If  cTipAtr == "1"
								nDiasAtr := If(nAtraso > nDiasAtr,nAtraso,nDiasAtr) // para dias corridos, utiliza o maior atraso
							Else
								nDiasAtr += nAtraso  // para dias acumulados, acumula os atrasos
							Endif
							**'----------------------------------------------'**
							**'-- Marcela Coimbra -- Data: 31/08/2011      --'**
							**'-- Motivo: Nao considerar titulos de RLE    --'**
							**'-- como inadimplência                       --'**
							**'-- Inicio ------------------------------------'**
							/*If  SE1->E1_SALDO > 0
							nTits     += 1
						Endif */
						
						//-----------------------------------------------------------------
						//Angelo Henrique - Data: 20/08/2018
						//-----------------------------------------------------------------
						//Chamado: 51764 - Estar inadimplente por mais de 60 dias
						//-----------------------------------------------------------------
						//If  SE1->E1_SALDO > 0 .AND. SE1->E1_PREFIXO == 'PLS' .AND.  SE1->E1_TIPO <> 'PR'
						If  SE1->E1_SALDO > 0 .AND. SE1->E1_PREFIXO == 'PLS' .AND.  SE1->E1_TIPO <> 'PR' .And. nDiasAtr > 60
							
							nTits     += 1
							
							aadd( aCritica, { SE1->E1_PREFIXO, SE1->E1_NUM, SE1->E1_PARCELA, SE1->E1_TIPO, SE1->E1_CLIENTE, DTOC(SE1->E1_VENCREA) })
							
						Endif
						
						**'----------------------------------------------'**
						**'-- Marcela Coimbra -- Data: 31/08/2011      --'**
						**'-- Fim  --------------------------------------'**
						nSaldo += SE1->E1_SALDO
					Endif
				Endif
				SE1->(DbSkip())
			Enddo
			
		Endif
		
	EndIf //Angelo Henrique - Data: 09/10/2015 -- Validação de inadimplência, para poder verificar ou não os títulos
	
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Tratamento padrao (nro de dias atraso > dias parametrizados...		³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
/*
If  nDiasAtr > nDiasPar
Return .F.
Endif
*/


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Tratamento Caberj (Dois titulos em aberto, nao imprime cartao...	³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If nTits > GetNewPar("MV_YQATRE1",1)
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Modificar retorno caso usuario possa imprimir com titulos em atraso.³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	//If Alltrim(cUserName) $ GetNewPar("MV_YUSCAID","") .And. M->BDE_YIMPAT == "1"
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Valido se rotina de lotes, permite imprimir atrasados. Senao, nega. ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If Alltrim(FunName()) == "PLSA262"
		
		//-----------------------------------------------------------------------------
		//Angelo Henrique - Data: 25/09/2015
		//-----------------------------------------------------------------------------
		//Chamado: 20453
		//-----------------------------------------------------------------------------
		//Lancamentos de carteira coligadas prefeitura
		//tendo em vista os pls em aberto por questão contratuais,
		//conforme confirmado pela esther (gefin). favor liberar os
		//lancamentos dos cartões uma vez que o comercial solicitou
		//prioridade devido as reclamações das empresas.
		//obrigada
		//-----------------------------------------------------------------------------
		If cCodEmp $ ("0025|0027|0028")
			
			If M->BDE_YIMPAT == "1"
				lRet := .T.
			Else
				lRet := .F.
			Endif
			
		EndIf
		
	Else
		
		lRet := .F.
		
		**'----------------------------------------------'**
		**'-- Marcela Coimbra -- Data: 16/09/2010      --'**
		**'----------------------------------------------'**
		**'-- Incluida mensagem.                       --'**
		**'----------------------------------------------'**
		
		ApMsgAlert("Existem mais de um títulos vencidos. O cartão não será gerado.")
		
		PLSCRIGEN(aCritica,{ {"Prefixo","@C",007},{"Numero","@C",009},{"Parcela","@C",007},{"Tipo","@C",004},{"Cliente","@C",006},{"Vencimento","@C",010}},"Títulos vencidos.",.T.)
		
		**'-- Fim ---------------------------------------'**
		
	Endif
	
	
Endif

//---------------------------------------------
//Fim - Angelo Henrique - Chamado: 20453
//---------------------------------------------

//----------------------------------------------------------------------------------------
//Angelo Henrique - Data: 22/12/2015
//----------------------------------------------------------------------------------------
//Atualiza alguns camops no beneficiário para ser utilizado na liberação de cartão
//Rotina CABA344 - Liberação de beneficiários com débitos
//Chamado: 10648
//----------------------------------------------------------------------------------------]
If !lRet
	
	RecLock("BA1",.F.)
	
	BA1->BA1_XLIBCA := "B" //BLOQUEADO
	BA1->BA1_XLTORI := IIF(AllTrim(UPPER(FUNNAME())) == "PLSA261" , BDE->BDE_CODIGO , M->BDE_CODIGO) //LOTE EM QUE O USUÁRIO SERIA GERADO
	
	BA1->(MsUnlock())
	
ElseIf lRet .And. BA1->BA1_XLIBCA == "L"
	
	RecLock("BA1",.F.)
	
	BA1->BA1_XLIBCA := "" //Neutro
	
	BA1->(MsUnlock())
	
EndIf

//---------------------------------------------------------------
// Inicio - Angelo Henrique - Data:08/10/2015 - Chamado: 16312
// Mudança nas regras de validação para geração de carteirinha
//---------------------------------------------------------------
If lRet .And. lRenv
	
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
	If AllTrim(UPPER(FUNNAME())) == "PLSA261"
		
		MV_PAR04 := dDtVali
		
	EndIf
	
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
	
EndIf

RestArea(_aAreBDE)
RestArea(_aAreBED)
RestArea(_aAreBA1)
RestArea(_aAreBHH)

//---------------------------------------------------------------
// Fim - Angelo Henrique - Data:08/10/2015 - Chamado: 16312
//---------------------------------------------------------------

Return lRet

**'----------------------------------------------'**
**'-- Marcela Coimbra -- Data: 23/09/2010      --'**
**'----------------------------------------------'**
**'-- Retorna o nivel de cobrança do usuario   --'**
**'-- pois para a integral, quando o nivel de  --'**
**'-- cobrança for de contrato, a regra de     --'**
**'-- nao emitir carteirinha nao eh mais valida--'**
**'----------------------------------------------'**

Static Function fVerNivel(cCodInt, cCodEmp, cMatrUs)
	
	Local a_BA1Area := BA1->( GetArea() )
	Local a_BA3Area := BA3->( GetArea() )
	Local c_Nivel := "10"
	
	dbSelectArea("BA1")
	dbSetOrder(1)
	dbSeek( xFilial("BA1") + cCodInt + cCodEmp + cMatrUs)
	
	dbSelectArea("BA3")
	dbSetOrder(1)
	dbSeek( xFilial("BA3") + cCodInt + cCodEmp + cMatrUs )
	
	aCliente := PLSRETNCB(cCodInt, cCodEmp, cMatrUs, NIL)
	
	c_Nivel := aCliente[5]
	
	RestArea( a_BA1Area )
	RestArea( a_BA3Area )
	
Return c_Nivel

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³nCalcIdadeºAutor  ³Leonardo Portella   º Data ³  19/07/11   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Calcula a idade em uma data passada por parametro.          º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³CABERJ                                                      º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function nCalcIdade(dNasc, dCalc)
	
	Local nIdade 	:= Year(dCalc) - Year(dNasc) - 1
	
	If Month(dCalc) > Month(dNasc)
		
		++nIdade
		
	ElseIf Month(dCalc) == Month(dNasc)
		
		If Day(dCalc) >= Day(dNasc)
			
			++nIdade
			
		EndIf
		
	EndIf
	
Return nIdade

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³Inadimp   ºAutor  ³Angelo Henrique     º Data ³  08/10/2015 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Valida se o beneficiário esteve inadimplente no período     º±±
±±º          ³de 2 anos                                                   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³CABERJ                                                      º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function IndimpCt(_cParam1, _cParam2, _cParam3)
	
	Local _lRet 		:= .F.
	Local _cQuery 	:= ""
	Local _cAliasQry	:= GetNextAlias()
	Local _nDiasAtr	:= 0
	Local _dDtBsc		:= GetNewPar("MV_XDTIT"		,CTOD("29/02/2016"))
	Local _dDtBPrv	:= GetNewPar("MV_XDTITPR"	,CTOD("29/02/2016"))
	Local _dDtInad	:= CTOD(" / / ")
	Local _aAreaBA3	:= BA3->(GetArea())
	
	Default _cParam1 	:= ""
	Default _cParam2 	:= ""
	Default _cParam3 	:= "1"
	
	//-----------------------------------------------------------------------
	//Realizando processo de validação para saber se esta indimplente
	//necessário ir no nível de cobrança, na familia de cada usuário
	//visualizar se é PREVI ou SISDEB, BOLETO e etc.
	//-----------------------------------------------------------------------
	DbSelectArea("BA3")
	DbSetOrder(1) //BA3_FILIAL+BA3_CODINT+BA3_CODEMP+BA3_MATRIC+BA3_CONEMP+BA3_VERCON+BA3_SUBCON+BA3_VERSUB
	If DbSeek(xFilial("BA3") + BA1->BA1_CODINT + BA1->BA1_CODEMP + BA1->BA1_MATRIC)
		
		//------------------------------------
		//Se for PREVI
		//Tipo de Pagamento:
		//01 - COBRANCA MATER APOSENTADOS
		//08 - COBRANCA MATER APOSENT. VINCU.
		//------------------------------------
		If BA3->BA3_TIPPAG $ ("01|08")
			
			_dDtInad := _dDtBPrv
			
		Else //Se for os demais
			
			_dDtInad := _dDtBsc
			
		EndIf
		
	EndIf
	
	/*
	_cQuery := " SELECT E1_VENCREA, (CASE WHEN (E1_ANOBASE||E1_MESBASE = '201507' AND " + c_ent
	_cQuery += " PROV_TRATA_JUL2015_PREVI(E1_CODINT,E1_CODEMP, E1_MATRIC) IN (0,2))  " + c_ent
	_cQuery += " THEN E1_BAIXA " + c_ent
	_cQuery += " WHEN (E1_ANOBASE||E1_MESBASE = '201507' AND  " + c_ent
	_cQuery += " PROV_TRATA_JUL2015_PREVI(E1_CODINT,E1_CODEMP, E1_MATRIC) = 1)  " + c_ent
	_cQuery += " THEN E1_VENCREA  " + c_ent
	_cQuery += " ELSE E1_BAIXA END) BAIXA , E1_SALDO, " + c_ent
	_cQuery += " FROM " + RetSqlName("SE1")+ " SE1 " + c_ent
	_cQuery += " WHERE D_E_L_E_T_ 	= ' ' " + c_ent
	_cQuery += " AND E1_FILIAL  	= '" + xFilial("SE1")	+ "' " + c_ent
	_cQuery += " AND E1_CODINT = '" + AllTrim(BA1->BA1_CODINT) + "' " + c_ent
	_cQuery += " AND E1_CODEMP = '" + AllTrim(BA1->BA1_CODEMP) + "' " + c_ent
	_cQuery += " AND E1_MATRIC = '" + AllTrim(BA1->BA1_MATRIC) + "' " + c_ent
	_cQuery += " AND E1_PREFIXO	= 'PLS' " + c_ent
	_cQuery += " AND E1_TIPO NOT IN ('PR','RA') " + c_ent
	_cQuery += " AND SIGA_RET_SIT_TIT_PRXREA('C',E1_PREFIXO||E1_NUM||E1_PARCELA||E1_TIPO) NOT IN ('CAN') " + c_ent
	
	*/
	
	_cQuery := " SELECT (CASE WHEN (E1_ANOBASE||E1_MESBASE = '201507' AND " + c_ent
	_cQuery += " PROV_TRATA_JUL2015_PREVI(E1_CODINT,E1_CODEMP, E1_MATRIC) IN (0,2)) " + c_ent
	_cQuery += " THEN E1_SALDO " + c_ent
	_cQuery += " WHEN (E1_ANOBASE||E1_MESBASE = '201507' AND " + c_ent
	_cQuery += " PROV_TRATA_JUL2015_PREVI(E1_CODINT,E1_CODEMP, E1_MATRIC) = 1) " + c_ent
	_cQuery += " THEN 0 " + c_ent
	_cQuery += " WHEN (E1_ANOBASE||E1_MESBASE = '201601' AND " + c_ent
	_cQuery += " prov_trata_jan2016_previ(E1_CODINT,E1_CODEMP, E1_MATRIC) IN (0,2)) " + c_ent
	_cQuery += " THEN E1_SALDO " + c_ent
	_cQuery += " WHEN (E1_ANOBASE||E1_MESBASE = '201601' AND " + c_ent
	_cQuery += " prov_trata_jan2016_previ(E1_CODINT,E1_CODEMP, E1_MATRIC) = 1) " + c_ent
	_cQuery += " THEN 0 " + c_ent
	_cQuery += " ELSE E1_SALDO END) SALDO, " + c_ent
	_cQuery += " E1_VENCREA , " + c_ent
	_cQuery += " (CASE WHEN (E1_ANOBASE||E1_MESBASE = '201601' AND " + c_ent
	_cQuery += " PROV_TRATA_JUL2015_PREVI(E1_CODINT,E1_CODEMP, E1_MATRIC) IN (0,2)) " + c_ent
	_cQuery += " THEN TO_DATE(TRIM(PROV_CART_MENOR_BAIXA('C',E1_PREFIXO||E1_NUM||E1_PARCELA||E1_TIPO,'" + BA3->BA3_TIPPAG + "')),'YYYYMMDD') " + c_ent
	_cQuery += " WHEN (E1_ANOBASE||E1_MESBASE = '201601' AND " + c_ent
	_cQuery += " PROV_TRATA_JUL2015_PREVI(E1_CODINT,E1_CODEMP, E1_MATRIC) = 1) " + c_ent
	_cQuery += " THEN TO_DATE(TRIM(E1_VENCREA),'YYYYMMDD') " + c_ent
	_cQuery += " WHEN (E1_ANOBASE||E1_MESBASE = '201601' AND " + c_ent
	_cQuery += " PROV_TRATA_JAN2016_PREVI(E1_CODINT,E1_CODEMP, E1_MATRIC) IN (0,2)) " + c_ent
	_cQuery += " THEN TO_DATE(TRIM(PROV_CART_MENOR_BAIXA('C',E1_PREFIXO||E1_NUM||E1_PARCELA||E1_TIPO,'" + BA3->BA3_TIPPAG + "')),'YYYYMMDD') " + c_ent
	_cQuery += " WHEN (E1_ANOBASE||E1_MESBASE = '201601' AND " + c_ent
	_cQuery += " PROV_TRATA_JAN2016_PREVI(E1_CODINT,E1_CODEMP, E1_MATRIC) = 1) " + c_ent
	_cQuery += " THEN TO_DATE(TRIM(E1_VENCREA),'YYYYMMDD') " + c_ent
	_cQuery += " ELSE TO_DATE(TRIM(PROV_CART_MENOR_BAIXA('C',E1_PREFIXO||E1_NUM||E1_PARCELA||E1_TIPO,'" + BA3->BA3_TIPPAG + "')),'YYYYMMDD') END) BAIXA " + c_ent
	
	_cQuery += " FROM " + RetSqlName("SE1") + " SE1 " + c_ent
	_cQuery += " WHERE D_E_L_E_T_ 	= ' ' " + c_ent
	_cQuery += " AND E1_FILIAL  	= '" + xFilial("SE1")	+ "' " + c_ent
	_cQuery += " AND E1_CODINT = '" + AllTrim(BA1->BA1_CODINT) + "' " + c_ent
	_cQuery += " AND E1_CODEMP = '" + AllTrim(BA1->BA1_CODEMP) + "' " + c_ent
	_cQuery += " AND E1_MATRIC = '" + AllTrim(BA1->BA1_MATRIC) + "' " + c_ent
	_cQuery += " AND E1_PREFIXO	= 'PLS' " + c_ent
	_cQuery += " AND E1_TIPO NOT IN ('PR','RA') " + c_ent
	_cQuery += " AND SIGA_RET_SIT_TIT_PRXREA('C',E1_PREFIXO||E1_NUM||E1_PARCELA||E1_TIPO) NOT IN ('CAN') " + c_ent
	
	//------------------------------------------
	//Validando se esta ou não Inadimplente
	//------------------------------------------
	If _cParam3 == "1"
		
		_cQuery += " AND E1_VENCREA >= '" + DTOS(MonthSub(_dDtInad,2)) + "' "
		
	EndIf
	
	//-----------------------------------------------------
	//No período de 24 meses
	//-----------------------------------------------------
	If _cParam3 $ "0|2"
		
		_cQuery += " AND E1_VENCREA >= '" + DTOS(YearSub(_dDtInad,2)) + "' "
		
	EndIf
	
	If Select(_cAliasQry)>0
		(_cAliasQry)->(DbCloseArea())
	EndIf
	
	DbUseArea(.T.,"TopConn",TcGenQry(,,_cQuery),_cAliasQry,.T.,.T.)
	
	DbSelectArea(_cAliasQry)
	
	While !((_cAliasQry)->(Eof()))
		//consultar a tabela temporária aqui para a matricula + ano e mês de competência
		If  _cParam3 == "0"
			
			//If (_cAliasQry)->E1_SALDO > 0
			If (_cAliasQry)->SALDO > 0
				
				If STOD((_cAliasQry)->E1_VENCREA) < _dDtInad  .And. _dDtInad - STOD((_cAliasQry)->E1_VENCREA) > 60
					
					_lRet := .T.
					Exit
					
				EndIf
				
			EndIf
			
		EndIf
		
		If  _cParam3 = "1"
			
			//If STOD((_cAliasQry)->E1_VENCREA) < _dDtInad .And. (_cAliasQry)->E1_SALDO > 0
			If STOD((_cAliasQry)->E1_VENCREA) < _dDtInad .And. (_cAliasQry)->SALDO > 0
				
				_lRet := .T.
				
			ElseIf STOD((_cAliasQry)->E1_VENCREA) < _dDtInad .And. Empty((_cAliasQry)->BAIXA)
				
				_lRet := .T.
				
			EndIf
			
		EndIf
		
		If Empty((_cAliasQry)->BAIXA) .And. _dDtInad - STOD((_cAliasQry)->E1_VENCREA) > 60
			
			_lRet := .T.
			
			If _cParam3 == "0"
				
				Exit
				
			EndIf
			
			//ElseIf STOD((_cAliasQry)->BAIXA) - STOD((_cAliasQry)->E1_VENCREA) > 60 .And. (_cAliasQry)->E1_SALDO > 0
		ElseIf (_cAliasQry)->BAIXA - STOD((_cAliasQry)->E1_VENCREA) > 60 .And. (_cAliasQry)->SALDO > 0
			
			_lRet := .T.
			
			If _cParam3 == "0"
				
				Exit
				
			EndIf
			
		EndIf
		
		//If (_cAliasQry)->E1_SALDO > 0 .AND. STOD((_cAliasQry)->E1_VENCREA) < _dDtInad
		If (_cAliasQry)->SALDO > 0 .AND. STOD((_cAliasQry)->E1_VENCREA) < _dDtInad
			
			_nDiasAtr += _dDtInad - STOD((_cAliasQry)->E1_VENCREA)
			
		ElseIf !Empty((_cAliasQry)->BAIXA)
			
			If (_cAliasQry)->BAIXA - STOD((_cAliasQry)->E1_VENCREA) > 0
				
				_nDiasAtr += (_cAliasQry)->BAIXA - STOD((_cAliasQry)->E1_VENCREA)
				
			EndIf
			
		ElseIf STOD((_cAliasQry)->E1_VENCREA) < _dDtInad
			
			_nDiasAtr += _dDtInad - STOD((_cAliasQry)->E1_VENCREA)
			
		EndIf
		
		(_cAliasQry)->(DbSkip())
		
	EndDo
	
	If _cParam3 $ "2"
		
		If _nDiasAtr > 60
			
			_lRet := .T.
			
		Else
			
			_lRet := .F.
			
		EndIf
		
	EndIf
	
	If Select(_cAliasQry)>0
		(_cAliasQry)->(DbCloseArea())
	EndIf
	
	RestArea(_aAreaBA3)
	
Return _lRet

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