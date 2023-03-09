#Include "RWMAKE.CH"
#Include "PLSMGER.CH"
#Include "COLORS.CH"
#Include "TOPCONN.CH"
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³FA070TIT  ºAutor  ³Microsiga           º Data ³  09/28/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Ponto de entrada chamado no momento da baixa do SE1         º±±
±±º          ³										                      º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ FINANCEIRO                                                 º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function FA070TIT()
	Local cAnoAdd
	Local cMesAdd
	Local nValMult // recebe o valor de multa+juros+igpm calculados pela funcao generica
	Local _aParcela	:={} // vetor que sera passado para funcao GerAdNeg
	Local lRet		:= .T.
	Local cChave	:= SE1->(E1_PREFIXO+E1_NUM+E1_PARCELA+E1_TIPO)
	Local cNumTit	:= SE1->E1_NUM
	Local cBaixa 	:= Upper(SubStr(cMotBx, 1, 3))  


//altamiro	05/06/2017	
// para liberar a execução do resto do codigo 
// sem outra a alteração , sem  outra alteração   

If IsInCallStack("u_CABA210")

   Return lRet
    
EndIf    
   

	nValTit2 := nValRec  // pega valor do titulo para rotina de janela

	// Testa se a variável foi criada pelo financeiro.
	If Type("lCABE999") == "U"
		lCABE999 := .F.
	Endif

/*
ROTINA QUE FAZ A BAIXA E GERA LANCAMENTOS NO PLS DOS TITULOS EM ATRASO.
*/
//	IF DDATABASE > SE1->E1_VENCREA  .AND. lCABE999 // SE BAIXAR O TITULO EM ATRASO e lcabe999 nao vier de rotina customizada.
//	M->DBAIXA // DATA EFETIVA DA BAIXA DO TITULO ( 01_10_2007)  
//  (cBaixa $"NOR") foi inserido para tratar a baixa em atraso apenas baixas normais Gedilson.
	**'Marcela Coimbra - Em 28/06/17 - Retirar empresas da prefeitura da rotina de cobrança de baixa em atraso'**
	//	If ((M->DBAIXA > SE1->E1_VENCREA)  .AND. (lCABE999) .AND. (SE1->E1_TIPO != "NCC") // PAULO MOTTA BAIXA RIOPREVI / NAO GERAR JUROS PARA BAIXA DE NCC EM ATRASO
	//If ((M->DBAIXA > SE1->E1_VENCREA)  .AND. (lCABE999) .AND. (SE1->E1_TIPO != "NCC") .AND. (cBaixa $"NOR")) .AND. !( SE1->E1_CODEMP $ ('0003|0024|0025|0027|0028') )// PAULO MOTTA BAIXA RIOPREVI / NAO GERAR JUROS PARA BAIXA DE NCC EM ATRASO
	If ((M->DBAIXA > SE1->E1_VENCREA)  .AND. (lCABE999) .AND. (SE1->E1_TIPO != "NCC") .AND. (cBaixa $"NOR")) .AND. !( SE1->E1_CODEMP $ GETMV('MV_XNBXATR') )// MARCELA COIMBRA EM 13/10/2017 - CRIADO O PARÂMETRO GETMV('MV_XNBXATR')
	**'Marcela Coimbra - FIM - Em 28/06/17 - Retirar empresas da prefeitura da rotina de cobrança de baixa em atraso'**	
		/* PEGO INFORMACOES PARA ALIMENTAR O VETOR _aparcela e aDadUsr */
		BBT->(DbSetOrder(7)) //BBT_PREFIX+BBT_NUMTIT+BBT_PARCEL+BBT_TIPTIT+BBT_RECPAG
		BBT->(MsSeek(xFilial("BBT")+ cChave))
	
		If BBT->BBT_NIVEL == "4"
			BA3->(DbSetOrder(1))
			BA3->(MsSeek(xFilial("BA3")+BBT->BBT_CODOPE+BBT->BBT_CODEMP+BBT->BBT_MATRIC))
		
			_cCodInt	:= BBT->BBT_CODOPE
			_cCodEmp	:= BA3->BA3_CODEMP
			_cMatric	:= BBT->BBT_MATRIC
			_cConEmp	:= BA3->BA3_CONEMP
			_cVerCon	:= BA3->BA3_VERCON
			_cSubCon	:= BA3->BA3_SUBCON
			_cVerSub	:= BA3->BA3_VERSUB
			_cNiveCob	:= BBT->BBT_NIVEL
		Else
			_cCodInt	:= BBT->BBT_CODOPE
			_cCodEmp	:= Iif(Empty(BBT->BBT_MATRIC),BBT->BBT_CODEMP,Space(25))
			_cMatric	:= BBT->BBT_MATRIC
			_cConEmp	:= Iif(Empty(BBT->BBT_MATRIC),BBT->BBT_CONEMP,Space(25))
			_cVerCon	:= Iif(Empty(BBT->BBT_MATRIC),BBT->BBT_VERCON,Space(10))
			_cSubCon	:= Iif(Empty(BBT->BBT_MATRIC),BBT->BBT_SUBCON,Space(25))
			_cVerSub	:= Iif(Empty(BBT->BBT_MATRIC),BBT->BBT_VERSUB,Space(10))
			_cNiveCob	:= BBT->BBT_NIVEL
		Endif
		// Pego valor da multa atraves do contrato
//		BQC->(MsSeek(xFilial("BQC")+_cCodInt+_cCodEmp+_cConEmp+_cVerCon+_cSubCon+_cVerSub))
	
		/*
		Chama funcao para calculo de juros + multa passando como parametro :
		(cod Cliente,Data Titulo,Data Baixa,Valor Titulo)
		Abril/09 retirado IGPM - Motta 
		*/
	//	nValMult	:= U_CABA997(SE1->E1_VENCREA,M->DBAIXA,nValRec,.F.)               
		nValMult    := U_CABA997(SE1->E1_VENCREA,M->DBAIXA,nValRec,.F.,SE1->E1_CODEMP,"FA070TIT")
		nValMult    := U_CABA997(SE1->E1_VENCREA,M->DBAIXA,nValRec,.F.,SE1->E1_CODEMP,"FA070TIT", SE1->E1_PREFIXO,SE1->E1_NUM)
		nValTit		:= nValMult  // pega valor Devido
	
		If nValTit <= 0 
			lRet := .F.
			Return lRet
		EndIf
	
		// ALIMENTO _aDadUsr
		aDadUsr := {_cCodInt,_cCodEmp,_cMatric,_cConEmp,_cVerCon,_cSubCon,_cVerSub,_cNiveCob}
	
		// ALIMENTO _aParcela
		cAnoAdd :=  SUBSTR(DTOS(M->DBAIXA),1,4)
		cMesAdd  := SUBSTR(DTOS(M->DBAIXA),5,2)

		aadd(_aParcela,{cAnoAdd+cMesAdd,nValTit,cMesAdd+"/"+cAnoAdd,GetNewPar("MV_YCDLJ3","993"),"","","Baixa Em Atraso"})
	
		/*
		Chamo Rotina para geracao de adicionais dos titulos baixados para este cliente
		*/       
		
		cQuery := " SELECT * FROM "+RetSqlName("BSQ")+" WHERE trim( BSQ_YNMSE1 ) = '" + substr(cChave, 1, 12) + "'"  
		cQuery += " AND BSQ_PREFIX =' ' AND BSQ_NUMTIT =' ' AND BSQ_PARCEL = ' ' AND BSQ_TIPTIT = ' ' AND D_E_L_E_T_ = ' ' "

		TCQUERY cQuery NEW ALIAS "TMPFAT"                   
		If TMPFAT->( EOF() )
		**'Inicio Marcela Coimbra GLPI 11193 - Perguntar se deseja parcelar na rotina de baixa por fatura'**
	   //	If alltrim(SE1->E1_FATURA) == 'NOTFAT' .and. MsgYesNo("O título " + SE1->E1_PREFIXO + SE1->E1_NUM + " é uma fatura. Deseja gerar baixa em atraso no valor de R$ " +  Transform( nValMult,"999,999.99") + "?")

			//---------------------------------------------------------------------
			//Angelo Henrique - Data: 09/07/2020
			//---------------------------------------------------------------------
			//Atendendo a lei que saiu no processo de pandemia:
			//LEI 8811/2020 - VEDAÇÃO COBRANÇA DE JUROS E MULTA
			//---------------------------------------------------------------------
			//Data: 02/06/2021 - Chamado: 
			//---------------------------------------------------------------------
			//If Empty(_cMatric) 
		
				If !U_GerAdNeg(_aParcela,aDadUsr,ALLTRIM(cChave))
					MsgAlert("Impossível criar adicional para o(s) mês(es) solicitado(s) . Verifique!")
					lRet := .F.
				Else
						MsgAlert("Adicional(is) criado(s) com sucesso para o Título : " + cNumTit,"Atenção!")
				Endif  

			//EndIf
			
		EndIf   

		
		TMPFAT->( dbCloseArea() ) 
		                          
	EndIf //  Tratamento de Atrasado
/*
	If lRet // Se a baixa puder ser realizada
		cNewStatus := "Q"
		If cBaixa == "NEG" // Se o tipo de baixar for por negociação.
			cNewStatus := "P"
		EndIf
		RecLock("SE1", .F.)
		SE1->E1_YTPEXP	:= cNewStatus
		SE1->E1_YTPEDSC	:= Posicione("SX5", 1, xFilial("SX5")+"K1"+cNewStatus, "X5_DESCRI")
		SE1->(MsUnlock())
	EndIf
*/

Return lRet