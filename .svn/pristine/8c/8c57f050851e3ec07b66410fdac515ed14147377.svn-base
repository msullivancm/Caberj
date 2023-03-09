#Include "topconn.ch"
#include "COLORS.CH"

#Define CRLF Chr(13)+Chr(10)
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³PLS180F  ºAutor  ³Microsiga           º Data ³  10/09/19    º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Ponto de entrada permitir atualizar campos no BB0, ou       º±±
±±º          ³realizar gravações ao término da Consolidação               º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±º          ³realizar gravações ao término da Consolidação               º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Protheus                                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/ 

User Function PLS180F

Local cCodEmpCMB  := GetNewPar("MV_XCOBRCC",'0325')   

	If ( (cEmpAnt == '02') .and. (cCodEmpCMB >= MV_PAR02) .and. (cCodEmpCMB <= MV_PAR03) ) 
		MsgRun("Verificando Dados Consolidados CMB...",,{|| ConCMB(),CLR_HBLUE})
	Endif
	
Return    

Static Function ConCMB
	Local aAreaBDH	  := BDH->(GetArea())
	Local aMatrics	  := {}
	Local nSaldo	  := 0
	Local nCobraCop	  := 0
	Local cMesFt	  := ""
	Local cAnoFt	  := ""
	Local cDataFatTMP := ""
	Local nSomaSld		  := 0
	Local nPos 		  := 0
	Local cSeqPDN	  := "00000000"
	Local cQuery  	  := ""
	Local cQryCC	  := ""	
	Local cLancCre	  := iif(cEmpAnt == '01',"","9A8")
	Local cLancDeb	  := iif(cEmpAnt == '01',"","9A9")
	Local cLancSld	  := iif(cEmpAnt == '01',"","9AA")
	Local cAliasBDH   := GetNextAlias()
	Local cAliasCC    := GetNextAlias()
	Local lCobrancaCC := .F.
	Local nLimiteCC	  := 0 //182.27 //Valor da Primeira Faixa do plano básico CMB.  Virá da tabela PDD
	Local nSaldoAnt	  := 0
	Local cCodEmpCMB  := GetNewPar("MV_XCOBRCC",'0325')   
	Private c_Seq	  := ""

	//************************************************************//
	//*** VERIFICAR SE A EMPRESA UTILIZA MODELO CONTA CORRENTE ***//
	//************************************************************//

	If ( (cEmpAnt == '02') .and. (cCodEmpCMB >= MV_PAR02) .and. (cCodEmpCMB <= MV_PAR03) )  

		DbSelectArea("PDD")
		DbSetOrder(1) //Buscar Parametros na Matriz de Cobrança/Copart
		If DbSeek(xFilial("PDD")+cCodEmpCMB) 
			While !PDD->(EOF()) .AND. PDD->PDD_CODEMP == cCodEmpCMB
				If MV_PAR04+MV_PAR05 >= SUBS(DTOS(PDD->PDD_VIGINI),1,6) .AND. (MV_PAR04+MV_PAR05 <= SUBS(DTOS(PDD->PDD_VIGFIN),1,6) .or. EMPTY(PDD->PDD_VIGFIN)) 
					lCobrancaCC	:= PDD->PDD_COBRCC == '1'
					nLimiteCC	:= PDD->PDD_LIMCOB
				Endif
				PDD->(DbSkip())
			Enddo
		Endif
		PDD->(DbCloseArea())

	Endif

	//**********************************************************//
	//*** INÍCIO DA LEITURA DO QUE ACABOU DE SER CONSOLIDADO ***//
	//**********************************************************//
	If lCobrancaCC

		//RECRIANDO AS VARIAVEIS cMesFt e cAnoFt, POIS DAQUI EM DIANTE TRATAREMOS TODOS
		//OS CASOS QUE NÃO POSSUIAM CONSOLIÇÃO.  ENTÃO USAREMOS A DATA DO PARÂMETRO, SUB-
		//TRAINDO-SE 1(UM) MÊS 

		cDataFatTMP := DTOS(MonthSub(STOD(MV_PAR04 + MV_PAR05 + '01'),1))
		cMesFt		:= SUBS(cDataFatTMP,5,2)
		cAnoFt		:= SUBS(cDataFatTMP,1,4)

		//QUERY PARA TRAZER TODAS CONSOLIDAÇÕES DESTA COMPETÊNCIA
		cQuery	:= "SELECT BDH_CODINT " + CRLF
		cQuery	+= "     , BDH_CODEMP " + CRLF
		cQuery	+= "     , BDH_MATRIC " + CRLF
		cQuery	+= "     , BDH_TIPREG " + CRLF
		cQuery	+= "     , MAX(BDH_MESFT) MESFT " + CRLF
		cQuery	+= "     , MAX(BDH_ANOFT) ANOFT " + CRLF
		cQuery	+= "     , SUM(BDH_VLCOPA) VLCOPA "    + CRLF
		cQuery	+= "  FROM "+RetSqlName("BDH")+" BDH " + CRLF
		cQuery	+= " WHERE BDH_FILIAL = '"+xFilial("BDH")+"' " + CRLF
		cQuery	+= "   AND BDH_CODINT =  '"+MV_PAR01+"' " + CRLF		
		cQuery	+= "   AND BDH_CODEMP = '" + cCodEmpCMB + "' " + CRLF				
		cQuery	+= "   AND BDH_ANOFT||BDH_MESFT  <  '" + MV_PAR04 + MV_PAR05 + "' " + CRLF
		cQuery	+= "   AND BDH_PREFIX = ' ' " + CRLF
		cQuery	+= "   AND BDH_NUMTIT = ' ' " + CRLF
		cQuery	+= "   AND BDH_PARCEL = ' ' " + CRLF
		cQuery	+= "   AND BDH_TIPTIT = ' ' " + CRLF
		cQuery	+= "   AND BDH_NUMFAT = ' ' " + CRLF
		cQuery	+= "   AND BDH.D_E_L_E_T_ =  ' ' " + CRLF
		cQuery	+= " GROUP BY BDH_CODINT " + CRLF
		cQuery	+= "        , BDH_CODEMP " + CRLF
		cQuery	+= "        , BDH_MATRIC " + CRLF
		cQuery	+= "        , BDH_TIPREG " + CRLF
		cQuery	+= " ORDER BY BDH_CODINT " + CRLF
		cQuery	+= "        , BDH_CODEMP " + CRLF
		cQuery	+= "        , BDH_MATRIC " + CRLF
		cQuery	+= "        , BDH_TIPREG " + CRLF

		If Select(cAliasBDH) > 0
			(cAliasBDH)->(DbCloseArea())
			cAliasBDH := GetNextAlias()
		Endif

		memowrite('c:\temp\QryCMB.sql',cQuery)

		PLSQuery(cQuery,cAliasBDH)

		If !(cAliasBDH)->(EOF()) 
			//ESTE LAÇO WHILE VAI TRATAR TODOS OS BENEFICIARIOS QUE TIVERAM CONSOLIDAÇÃO NESTA COMPETENCIA
			While !(cAliasBDH)->(EOF())
				nCobraCop := 0
				nSaldo := 0

				//GUARDAR MATRICULAS PARA USAR NO FINAL DO PROCESSO
				aAdd(aMatrics,(cAliasBDH)->(BDH_CODINT+BDH_CODEMP+BDH_MATRIC+BDH_TIPREG))

				//GUARDO O VALOR CONSOLIDADO DE CADA MATRICULA, A ULTIMA COMPETENCIA
				//ENCONTRADA QUE SERÁ USADA COMO REFERENCIA PARA GRAVAR OS DEBITOS E
				//CREDITOS
				nCobraCop := (cAliasBDH)->VLCOPA 

				//VERIFICAR SE PARA ESTAS MATRICULAS SELECIONADAS EXISTE ALGUM SALDO REMANESCENTE
				cQryCC	:= " SELECT * "
				cQryCC	+= "   FROM "+RetSqlName("PDN")+" PDN " 													 + CRLF
				cQryCC	+= "  WHERE PDN_FILIAL = '"+xFilial("PDN")+"' " 											 + CRLF
				cQryCC	+= "    AND PDN_MATRIC = '" + (cAliasBDH)->(BDH_CODINT+BDH_CODEMP+BDH_MATRIC+BDH_TIPREG)+"'" + CRLF
				cQryCC	+= "    AND D_E_L_E_T_ = ' ' " 																 + CRLF
				cQryCC	+= "    AND PDN_SEQUEN IN (SELECT MAX(PDN_SEQUEN) " 										 + CRLF
				cQryCC	+= "                        FROM "+RetSqlName("PDN")+" PDN2 " 								 + CRLF
				cQryCC	+= "                        WHERE PDN2.PDN_FILIAL = '"+xFilial("PDN")+"' " 					 + CRLF
				cQryCC	+= "                          AND PDN2.PDN_MATRIC = PDN.PDN_MATRIC " 						 + CRLF
				cQryCC	+= "    					  AND D_E_L_E_T_ = ' ' " 										 + CRLF
				cQryCC	+= "    					  AND PDN2.PDN_MATRIC = '" + (cAliasBDH)->(BDH_CODINT+BDH_CODEMP+BDH_MATRIC+BDH_TIPREG)+"')" + CRLF

				If Select(cAliasCC) > 0
					(cAliasCC)->(DbCloseArea()) 
					cAliasCC := GetNextAlias()
				Endif		
				
				memowrite('c:\temp\QryCMB2.sql',cQryCC)
				
				PLSQuery(cQryCC,cAliasCC)

				//SE HOUVER SALDO REMANESCENTE EU INCORPORO ESTE VALOR AO NOVO VALOR
				If !( (cAliasCC)->(EOF()) ) .AND. ( (cAliasCC)->PDN_SALDO > 0 )
					nSaldo += (cAliasCC)->PDN_SALDO
				Endif

				//SE O TOTAL A SER COBRADO(SALDO REMANESCENTE + VALOR CONSOLIDADO) FOR MAIOR DO QUE O LIMITE,
				//GERO UM NOVO SALDO E COBRO SOMENTE O LIMITE
				If  (nCobraCop + nSaldo) > nLimiteCC

					nSomaSld   := (nCobraCop + nSaldo) - nLimiteCC
					cSeqPDN	:= STRZERO(VAL(GetSeqPDN((cAliasBDH)->(BDH_CODINT+BDH_CODEMP+BDH_MATRIC+BDH_TIPREG)))+1,8)
				
					//INSERE EM PDN - VALORES DE MOVIMENTAÇÃO
					DbSelectArea("PDN")
					RecLock("PDN",.T.)
					PDN->PDN_FILIAL := xFilial("PDN") 
					PDN->PDN_MATRIC := (cAliasBDH)->(BDH_CODINT+BDH_CODEMP+BDH_MATRIC+BDH_TIPREG)
					PDN->PDN_COMPET := cAnoFt + cMesFt //MV_PAR04 + MV_PAR05
					PDN->PDN_LANCRE := cLancCre
					PDN->PDN_VLRCRE := nCobraCop + nSaldo //nCobraCop
					PDN->PDN_BSQCRE := ""
					PDN->PDN_LANDEB := cLancDeb
					PDN->PDN_VLRDEB := nLimiteCC
					PDN->PDN_BSQDEB := ""
					If nSaldo > 0 
						PDN->PDN_LANSLD := cLancSld
					Else 
						PDN->PDN_LANSLD := ""
					Endif
					PDN->PDN_SALDO  := nSomaSld //nSaldo
					PDN->PDN_BSQSLD := ""
					PDN->PDN_SEQUEN := cSeqPDN 
					MsUnlock()

					//INSERT EM BSQ - CREDITO					
					GravaBSQ( (cAliasBDH)->(BDH_CODINT+BDH_CODEMP+BDH_MATRIC+BDH_TIPREG),cAnoFt ,cMesFt ,cLancCre,nCobraCop + nSaldo )
					RecLock("PDN",.F.)
					PDN->PDN_BSQCRE := c_Seq 
					MsUnlock()	 	

					//INSERT EM BSQ - DEBITO(LIMITE)					
					GravaBSQ( (cAliasBDH)->(BDH_CODINT+BDH_CODEMP+BDH_MATRIC+BDH_TIPREG),cAnoFt,cMesFt,cLancDeb,nLimiteCC )
					RecLock("PDN",.F.)
					PDN->PDN_BSQDEB := c_Seq  
					MsUnlock()
					
					If nSaldo > 0
						//INSERT EM BSQ - DEBITO(SALDO REMANESCENTE)						
						GravaBSQ( (cAliasBDH)->(BDH_CODINT+BDH_CODEMP+BDH_MATRIC+BDH_TIPREG),cAnoFt,cMesFt,cLancSld,nSaldo )
						RecLock("PDN",.F.)
						PDN->PDN_BSQSLD := c_Seq  
						MsUnlock()
					Endif

					PDN->(DbCloseArea())	 	

					//SE O TOTAL A SER COBRADO(SALDO REMANESCENTE + VALOR CONSOLIDADO) FOR MENOR DO QUE O LIMITE,
					//TENHO QUE ZERAR O SALDO E COBRÁ-LO
					
				ElseIf (nCobraCop + nSaldo) <= nLimiteCC .AND. (nSaldo > 0)
					nSaldoAnt := nSaldo //Não pode entrar o nCobraCop porque senão irá cobrar a copart 2x
					nSaldo    := 0	
					cSeqPDN	:= STRZERO(VAL(GetSeqPDN((cAliasBDH)->(BDH_CODINT+BDH_CODEMP+BDH_MATRIC+BDH_TIPREG)))+1,8)
					//INSERE EM PDN - VALORES DE MOVIMENTAÇÃO
					DbSelectArea("PDN")
					RecLock("PDN",.T.)
					PDN->PDN_FILIAL := xFilial("PDN") 
					PDN->PDN_MATRIC := (cAliasBDH)->(BDH_CODINT+BDH_CODEMP+BDH_MATRIC+BDH_TIPREG)
					PDN->PDN_COMPET := cAnoFt + cMesFt //MV_PAR04 + MV_PAR05
					PDN->PDN_LANCRE := ""
					PDN->PDN_VLRCRE := 0
					PDN->PDN_BSQCRE := "" 
					PDN->PDN_LANDEB := "" //cLancDeb
					PDN->PDN_VLRDEB := nSaldoAnt //nCobraCop + nSaldoAnt
					PDN->PDN_BSQDEB := ""
					If nSaldoAnt > 0  
						PDN->PDN_LANSLD := cLancSld 
					Else
						PDN->PDN_LANSLD := "" //cLancSld 
					Endif
					PDN->PDN_SALDO  := nSaldo
					PDN->PDN_BSQSLD := ""
					PDN->PDN_SEQUEN := cSeqPDN 
					MsUnlock()

					If nSaldoAnt > 0 
						//INSERT EM BSQ - DEBITO(SALDO)
						//GravaBSQ( (cAliasBDH)->(BDH_CODINT+BDH_CODEMP+BDH_MATRIC+BDH_TIPREG),MV_PAR04,MV_PAR05,cLancSld,nSaldoAnt )
						GravaBSQ( (cAliasBDH)->(BDH_CODINT+BDH_CODEMP+BDH_MATRIC+BDH_TIPREG),cAnoFt,cMesFt,cLancSld,nSaldoAnt )
						RecLock("PDN",.F.)
						PDN->PDN_BSQSLD := c_Seq  
						MsUnlock()
					Endif	
					PDN->(DbCloseArea())	
				Endif
				(cAliasBDH)->(DbSkip())
			EndDo 

			(cAliasBDH)->(DbCloseArea())
			(cAliasCC)->(DbCloseArea())
		Endif

		//*****************************************************************************************//
		//*** VERIFICACAO DA EXISTENCIA DE MATRICULAS QUE NAO FIZERAM PARTE DESTA CONSOLIDAÇAO, ***//
		//*** MAS QUE POSSUEM SALDO A SER COBRADO. VARIAVEL "nCobraCop" SEMPRE = 0(ZERO)		***//
		//*****************************************************************************************//

		//VERIFICAR SE PARA ESTAS MATRICULAS SELECIONADAS EXISTE ALGUM SALDO REMANESCENTE
		cQryCC	:= " SELECT * "
		cQryCC	+= "   FROM "+RetSqlName("PDN")+" PDN " 										+ CRLF
		cQryCC	+= "  WHERE PDN_FILIAL = '"+xFilial("PDN")+"' " 								+ CRLF
		cQryCC	+= "    AND D_E_L_E_T_ = ' ' " 													+ CRLF
		cQryCC	+= "    AND PDN_SEQUEN IN (SELECT MAX(PDN_SEQUEN) " 							+ CRLF
		cQryCC	+= "                        FROM "+RetSqlName("PDN")+" PDN2 " 					+ CRLF
		cQryCC	+= "                        WHERE PDN2.PDN_FILIAL = '"+xFilial("PDN")+"' " 		+ CRLF
		cQryCC	+= "                          AND PDN2.PDN_MATRIC = PDN.PDN_MATRIC " 			+ CRLF
		cQryCC	+= "                          AND SUBSTR(PDN2.PDN_MATRIC,5,4) BETWEEN '"+MV_PAR02+"' AND '"+MV_PAR03+"' " + CRLF
		cQryCC	+= "    					  AND D_E_L_E_T_ = ' ' )"   			 			+ CRLF

		If Select(cAliasCC) > 0
			(cAliasCC)->(DbCloseArea())
			cAliasCC := GetNextAlias()
		Endif	

		PLSQuery(cQryCC,cAliasCC)

		While !(cAliasCC)->(EOF())
			nCobraCop := 0
			nSaldo := 0
			nSaldoAnt := 0

			If (cAliasCC)->PDN_SALDO > 0 //.AND. EMPTY((cAliasCC)->PDN_LOTCOB)
				nPos := 0
				nPos := ASCAN(aMatrics, (cAliasCC)->PDN_MATRIC)
				If nPos == 0 
					nSaldo += (cAliasCC)->PDN_SALDO

					//SE O TOTAL A SER COBRADO(SALDO REMANESCENTE) FOR MAIOR DO QUE O LIMITE,
					//GERO UM NOVO SALDO E COBRO SOMENTE O LIMITE
					If  nSaldo > nLimiteCC
						nSaldoAnt := nSaldo
						nSaldo    := nSaldo - nLimiteCC
						cSeqPDN	  := STRZERO(VAL(GetSeqPDN((cAliasCC)->(PDN_MATRIC)))+1,8)
						//INSERE EM PDN - VALORES DE MOVIMENTAÇÃO
						DbSelectArea("PDN")
						RecLock("PDN",.T.)
						PDN->PDN_FILIAL := xFilial("PDN") 
						PDN->PDN_MATRIC := (cAliasCC)->PDN_MATRIC
						PDN->PDN_COMPET := cAnoFt + cMesFt //MV_PAR04 + MV_PAR05
						PDN->PDN_LANCRE := ""
						PDN->PDN_VLRCRE := 0
						PDN->PDN_BSQCRE := "" 
						PDN->PDN_LANDEB := "" //cLancDeb
						PDN->PDN_VLRDEB := nLimiteCC
						PDN->PDN_BSQDEB := ""
						PDN->PDN_LANSLD := cLancSld
						PDN->PDN_SALDO  := nSaldo
						PDN->PDN_BSQSLD := ""
						PDN->PDN_SEQUEN := cSeqPDN 
						MsUnlock()

						//INSERT EM BSQ - DEBITO(LIMITE)
						GravaBSQ( (cAliasCC)->PDN_MATRIC,cAnoFt,cMesFt,cLancSld,nLimiteCC )
						RecLock("PDN",.F.)
						PDN->PDN_BSQSLD := c_Seq  
						MsUnlock()	 
						PDN->(DbCloseArea())	

						//SE O TOTAL A SER COBRADO(SALDO REMANESCENTE + VALOR CONSOLIDADO) FOR MENOR DO QUE O LIMITE,
						//TENHO QUE ZERAR O SALDO E COBRÁ-LO
					ElseIf nSaldo <= nLimiteCC .AND. (cAliasCC)->PDN_SALDO > 0 
						nSaldoAnt := nSaldo
						nSaldo    := 0	
						cSeqPDN	  := STRZERO(VAL(GetSeqPDN((cAliasCC)->PDN_MATRIC))+1,8)
						//INSERE EM PDN - VALORES DE MOVIMENTAÇÃO
						DbSelectArea("PDN")
						RecLock("PDN",.T.)
						PDN->PDN_FILIAL := xFilial("PDN") 
						PDN->PDN_MATRIC := (cAliasCC)->PDN_MATRIC
						PDN->PDN_COMPET := cAnoFt + cMesFt //MV_PAR04 + MV_PAR05
						PDN->PDN_LANCRE := ""
						PDN->PDN_VLRCRE := 0
						PDN->PDN_BSQCRE := "" 
						PDN->PDN_LANDEB := ""//cLancDeb
						PDN->PDN_VLRDEB := nSaldoAnt
						PDN->PDN_BSQDEB := ""
						PDN->PDN_LANSLD := cLancSld
						PDN->PDN_SALDO  := nSaldo
						PDN->PDN_BSQSLD := ""
						PDN->PDN_SEQUEN := cSeqPDN 
						MsUnlock()

						//INSERT EM BSQ - DEBITO(SALDO)
						//GravaBSQ( (cAliasCC)->PDN_MATRIC,MV_PAR04,MV_PAR05,cLancSld,nSaldoAnt )
						GravaBSQ( (cAliasCC)->PDN_MATRIC,cAnoFt,cMesFt,cLancSld,nSaldoAnt )
						RecLock("PDN",.F.)
						PDN->PDN_BSQSLD := c_Seq  
						MsUnlock()	
						PDN->(DbCloseArea()) 	
					Endif

				Endif
			Endif
			(cAliasCC)->(DbSkip())
		Enddo

		If Select(cAliasBDH) > 0
			(cAliasBDH)->(DbCloseArea())
		Endif
	Endif
	//************************************************************************************************//
	//*** FIM DA VERIFICACAO DA EXISTENCIA DE MATRICULAS QUE NAO FIZERAM PARTE DESTA CONSOLIDAÇAO, ***//
	//*** MAS QUE POSSUEM SALDO A SER COBRADO													   ***//
	//************************************************************************************************//

	RestArea(aAreaBDH)
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³GravaBSQ   ºAutor  ³ Fabio Bianchini   º Data ³  11/09/19   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Função para Gravar BSQ do Modelo de Cobrança Conta Correnteº±±
±±º		     ³ 								 							  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function GravaBSQ(cMatric,cAno,cMes,cCodLan,nValor)

	Local _aArea 	:= GetArea()
	Local _aArBA1 	:= BA1->(GetArea())
	Local _aArBA3 	:= BA3->(GetArea())
	Local _aArBSQ 	:= BSQ->(GetArea())
	Local _aDadGrv	:= {} 
	Local _cChvBSQ	:= ""	
	Local _cNivel	:= ""
	Local cValor	:= CValToChar(nValor)

	//--------------------------------------------------------
	//Rotina para trazer o ultimo sequencial inserido
	//--------------------------------------------------------

	c_Seq := STPEGASEQ()
	c_Seq := Soma1(c_Seq)

	If  !Empty( c_Seq )

		DbSelectArea("BA1")
		DbSetOrder(2)
		If DbSeek( xFilial("BA1") + cMatric )

			//-------------------------------------------------------------------
			//validação para saber em qual nível deve ser colocado o lançamento
			//-------------------------------------------------------------------
			DbSelectArea("BA3")
			DbSetOrder(1) //BA3_FILIAL+BA3_CODINT+BA3_CODEMP+BA3_MATRIC+BA3_CONEMP+BA3_VERCON+BA3_SUBCON+BA3_VERSUB

			If DbSeek( xFilial("BA3") +  BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC))
				If BA3->BA3_COBNIV == '1' //1=Sim;0=Nao
					_cNivel := "5"
				Else
					_cNivel := "3"
				EndIf
			Else
				_cNivel := "3"
			EndIf

			//--------------------------------------------------------------------------------------------------------------
			//Montagem da chave da BSQ
			//--------------------------------------------------------------------------------------------------------------
			//Indice número 2:
			//--------------------------------------------------------------------------------------------------------------
			//BSQ_FILIAL+BSQ_USUARI+BSQ_CONEMP+BSQ_VERCON+BSQ_SUBCON+BSQ_VERSUB+BSQ_ANO+BSQ_MES+BSQ_CODLAN+BSQ_TIPO
			//--------------------------------------------------------------------------------------------------------------
			_cChvBSQ := xFilial("BSQ")  														//BSQ_FILIAL
			_cChvBSQ += BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG+BA1_DIGITO)			//BSQ_USUARI
			_cChvBSQ += BA1->(BA1_CONEMP+BA1_VERCON+BA1_SUBCON+BA1_VERSUB) 						//BSQ_CONEMP+BSQ_VERCON+BSQ_SUBCON+BSQ_VERSUB
			_cChvBSQ += cAno				 													//BSQ_ANO
			_cChvBSQ += cMes																	//BSQ_MES
			_cChvBSQ += cCodLan																	//BSQ_CODLAN
			_cChvBSQ += POSICIONE("BSP",1,xFilial("BSP")+cCodLan,"BSP_TIPSER") 					//BSQ_TIPO
			//--------------------------------------------------------------------------------------------------------------

			DbSelectArea("BSQ")
			DbSetOrder(2) //BSQ_FILIAL+BSQ_USUARI+BSQ_CONEMP+BSQ_VERCON+BSQ_SUBCON+BSQ_VERSUB+BSQ_ANO+BSQ_MES+BSQ_CODLAN+BSQ_TIPO
			If !(DbSeek( _cChvBSQ ))

				RecLock("BSQ",.T.)

				BSQ_FILIAL 	:= xFilial("BSQ")
				BSQ_CODSEQ 	:= c_Seq  //soma1(c_Seq)
				BSQ_USUARI 	:= BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG+BA1_DIGITO)
				BSQ_CODINT 	:= BA1->BA1_CODINT
				BSQ_CODEMP	:= BA1->BA1_CODEMP
				BSQ_CONEMP	:= BA1->BA1_CONEMP
				BSQ_VERCON  := '001'
				BSQ_SUBCON	:= BA1->BA1_SUBCON
				BSQ_VERSUB	:= '001'
				BSQ_MATRIC  := BA1->BA1_MATRIC
				BSQ_ANO		:= cAno
				BSQ_MES		:= cMes
				BSQ_CODLAN 	:= cCodLan 	
				BSQ_VALOR	:= VAL(StrTran(cValor,",","."))
				BSQ_TIPO 	:= POSICIONE("BSP",1,xFilial("BSP")+cCodLan,"BSP_TIPSER") 
				BSQ_NPARCE	:= '1'
				BSQ_TIPEMP 	:= '2'
				BSQ_AUTOMA 	:= '0'
				BSQ_COBNIV  := _cNivel
				BSQ_OBS     := POSICIONE("BSP",1,xFilial("BSP")+cCodLan,"BSP_DESCRI")
				BSQ_ZHIST   := UPPER(CUSERNAME) + " - " + DTOC(dDataBase) + " - " + TIME()

				MSUnLock()

				//--------------------------------------
				//Gravar Log informativo
				//--------------------------------------
				aAdd(_aDadGrv,;
				"Matricula: " 		+ AllTrim(BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG+BA1_DIGITO)) + ;
				" - Ano: " 			+ cAno + ;
				" - Mes: " 			+ cMes + ;
				" - Lançamento: " 	+ cCodLan + ;
				" - Incluido com sucesso. " )

			Else
				//c_Seq	:= " "
				c_Seq	:= BSQ->BSQ_CODSEQ
				//--------------------------------------
				//Gravar Log informativo
				//--------------------------------------
				aAdd(_aDadGrv,;
				"Matricula: " 		+ AllTrim(BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG+BA1_DIGITO)) + ;
				" - Ano: " 			+ cAno + ;
				" - Mes: " 			+ cMes + ;
				" - Lançamento: " 	+ cCodLan + ;
				" - Já existe lançamento incluído para este beneficiário.. " )

			EndIf

		Else

			//--------------------------------------
			//Gravar Log informativo
			//--------------------------------------
			c_Seq	:= " "
			aAdd(_aDadGrv,;
			"Matricula: " 		+ AllTrim(BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG+BA1_DIGITO)) + ;				
			" - Não encontrada no sistema. " )

		EndIf
		BSQ->(DbCloseArea())
		BA3->(DbCloseArea())
		BA1->(DbCloseArea())
	EndIf

	RestArea(_aArBSQ)
	RestArea(_aArBA3)
	RestArea(_aArBA1)
	RestArea(_aArea )

Return


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ STPEGASEQ  º Autor ³ Angelo Henrique    º Data ³  27/05/19 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Traz a numeração para o sequencial dos lançamentos.        º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CABERJ                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function STPEGASEQ()

	Local c_Qry := ""
	Local c_Cod := ""
	Local c_Alias := GetNextAlias()

	c_Qry := " SELECT Max(BSQ_CODSEQ) VALMAX FROM " + retsqlname("BSQ") + " WHERE D_E_L_E_T_ = ' ' "

	If Select(c_Alias) > 0
		(c_Alias)->(DbCloseArea())
		c_Alias := GetNextAlias()
	Endif

	PLSQuery(c_Qry,c_Alias)

	If !( (c_Alias)->(EOF()) )

		c_Cod	:= (c_Alias)->VALMAX

	Endif

	(c_Alias)->(dbCloseArea())

Return c_Cod

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ GetSeqPDN  º Autor ³ Fabio Bianchini    º Data ³  27/05/19 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Traz a numeração para o sequencial dos lançamentos PDN     º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CABERJ                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function GetSeqPDN(cMatric)

	Local c_Qry   := ""
	Local c_Seq   := "00000000"
	Local c_Alias := GetNextAlias()

	c_Qry := " SELECT Max(PDN_SEQUEN) VALMAX "
	c_Qry += "   FROM " + retsqlname("PDN") 
	c_Qry += "  WHERE PDN_FILIAL = '"+xFilial("PDN")+"'"
	c_Qry += "    AND PDN_MATRIC = '"+cMatric+"'"
	c_Qry += "    AND D_E_L_E_T_ = ' ' "

	If Select(c_Alias) > 0
		(c_Alias)->(DbCloseArea())
		c_Alias := GetNextAlias()
	Endif

	PLSQuery(c_Qry,c_Alias)

	If !( (c_Alias)->(EOF()) ) .and. !( EMPTY((c_Alias)->VALMAX) )
		c_Seq	:= STRZERO(VAL((c_Alias)->VALMAX),8)
	Endif

	(c_Alias)->(dbCloseArea())

Return c_Seq
