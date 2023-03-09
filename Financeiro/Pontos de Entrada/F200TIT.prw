/*
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±…ÕÕÕÕÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÀÕÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÀÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÕÕÕª±±
±±∫Programa  ≥ F200TIT  ∫Autor  ≥ Jeferson Couto     ∫ Data ≥  16/10/07   ∫±±
±±ÃÕÕÕÕÕÕÕÕÕÕÿÕÕÕÕÕÕÕÕÕÕ ÕÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕ ÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕÕÕπ±±
±±∫Desc.     ≥ Executado apÛs a leitura da linha de detalhe,              ∫±±
±±∫			 ≥ depois da gravaÁ„o de todos os dados.                      ∫±±
±±∫			 ≥                                   				          ∫±±
±±∫          ≥                                                            ∫±±
±±ÃÕÕÕÕÕÕÕÕÕÕÿÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕπ±±
±±∫Uso       ≥ FINANCEIRO                                                 ∫±±
±±»ÕÕÕÕÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕº±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
*/
#include "RWMAKE.CH"

User Function F200TIT()

	Local aArea			:= GetArea()
	Local nValMult		:= 0  //Recebe o valor de multa+juros+igpm calculados pela funcao generica
	Local _aParcela		:= {}	//Vetor que sera passado para funcao GerAdNeg
	Local cAnoAdd     	:= cMesAdd := cNewStatus := ""
	Local cNewOcorr   	:= AllTrim(cOcorr)
	Local cChave		:= SE1->(E1_PREFIXO+E1_NUM+E1_PARCELA+E1_TIPO)	
	Local lMotSys		:= .F.

	// Inicio - Marcela Coimbra em 05/04/10
	dbSelectArea("SE1")
	If SE1->( EOF() )

		Return

	EndIf
	// Fim - Marcela Coimbra em 05/04/10

	If Upper(Alltrim(mv_par05)) == 'ITAU.2RR' // Sisdeb
		If cNewOcorr == "00"
			cNewStatus := "J"
		ElseIf cNewOcorr == "03"
			cNewStatus := "I"
		Else
			cNewStatus := "K"
		EndIf
	ElseIf Upper(Alltrim(mv_par05)) $ Upper(AllTrim(GetMV("MV_XCNABRR"))) // 112 e 175

		If SE1->E1_YTPEXP == "B" .Or. SE1->E1_YTPEXP == "L"// 112
			If cNewOcorr $ "02|14"  // Adicionado Ocorrencia 14 - Alteracao de vencimento * Luiz Otavio em 20/09/21
				cNewStatus := "L"
			ElseIf cNewOcorr == "06" .Or. cNewOcorr == "08"
				cNewStatus := "G"
			Else
				cNewStatus := "H"
			EndIf
		ElseIf SE1->E1_YTPEXP == "D" // 175
			If cNewOcorr $ "02|14" //Angelo Henrique - Data: 22/06/2021 
				cNewStatus := "L"
			ElseIf cNewOcorr == "06"
				cNewStatus := "G"
			Else
				cNewStatus := "H"
			EndIf
		EndIf
	EndIf

	If !Empty(cNewStatus)

		SE1->(RecLock("SE1", .F.))
		SE1->E1_YTPEXP	 := cNewStatus
		SE1->E1_YTPEDSC := Posicione("SX5", 1, xFilial("SX5")+"K1"+cNewStatus, "X5_DESCRI")
		
		//Adicionado por Luiz Otavio Campos em 16/09/21
		//Motivo* Exibir status para consulta na posicao do usu·rio
		If SE1->E1_FORMREC = "06"
			SE1->E1_HIST := Alltrim(SEB->EB_DESCRI)+" | "+AllTrim(SEB->EB_DESCMOT)					
		EndIf

		SE1->(MsUnlock())
	else		
		//Adicionado por Luiz Otavio Campos em 16/09/21
		//Motivo* Exibir status para consulta na posicao do usu·rio
		If SE1->E1_FORMREC = "06"
			SE1->(RecLock("SE1", .F.))
			SE1->E1_HIST := Alltrim(SEB->EB_DESCRI)+" | "+AllTrim(SEB->EB_DESCMOT)
			SE1->(MsUnlock())
		EndIf			
	EndIf

	/**********TITULOS X OCORRENCIA BANCARIA *******Luiz Otavio ***17/09/2021 *********************************/
	//Realiza a gravaÁ„o da ocorrecia por tÌtulo para envio de e-mail/sms
	If SE1->E1_FORMREC = "06"		
		aArea2:= GetArea()		
		DbSelectArea("P13") // Tabela de Ocorrencia X titulo
		DbSetOrder(1)
		If Dbseek(xFilial("P13")+SE1->E1_PREFIXO+SE1->E1_NUM+SE1->E1_PARCELA+SE1->E1_TIPO)

			while !P13->(Eof()) .and. P13->(P13_FILIAL+P13_PREFIX+P13_TITULO+P13_PARCELA+P13_TIPO) = xFilial("P13")+SE1->E1_PREFIXO+SE1->E1_NUM+SE1->E1_PARCELA+SE1->E1_TIPO
				
				// Bloqueio todos as ocorrencias do titulo que n„o foram enviadas ao benefici·rio
				If P13->P13_STATUS<> 'E'
					
					DbSelectArea("P13")
					RecLock("P13", .F.)								
					P13->P13_STATUS	:= "B"
					//P13->P13_DTINC	:= dDATABASE // Luiz Otavio * 19/11/21 Comentado para n„o subsitituir a data de inclus„o do titulo
					MsUnlock()						
				EndIf

				DbSelectArea("P13")
				DbSkip()
			EndDo			
		EndIf					
		 
		//Incluo novo registro para envio de e-mail ao beneficiario
		DbSelectArea("P13")
		DbSetOrder(1)
		RecLock("P13", .T.)
		P13->P13_FILIAL  := xFilial("P13")
		P13->P13_PREFIX  := SE1->E1_PREFIXO
		P13->P13_TITULO  := SE1->E1_NUM
		P13->P13_PARCELA := SE1->E1_PARCELA
		P13->P13_TIPO	 := SE1->E1_TIPO
		P13->P13_BANCO	 := SE1->E1_PORTADO
		P13->P13_OCORR 	 := cNewOcorr
		P13->P13_DESOCO  := Alltrim(SEB->EB_DESCRI)
		
		
		/********* Atualizado por Luiz Otavio em 03/02/2022 **********************
		//Motivo: Gravar a descriÁ„o do motivo na tabela de Debito automatico
		/*************************************************************************/
		//P13->P13_MOTV	 := AllTrim(SEB->EB_MOTSIS)
		//P13->P13_DESCMO  := AllTrim(SEB->EB_DESCMOT)
		P13->P13_MOTV	 := cMotBan //AllTrim(SEB->EB_MOTSIS)
		P13->P13_DESCMO  := posicione("SEB",1,xFilial("SEB")+SE1->E1_PORTADO+cOcorr+"R"+cMotBan  ,"EB_DESCMOT")

		/********************Fim da AlteraÁ„o **************************************/

		P13->P13_CLIENTE := SE1->E1_CLIENTE
		P13->P13_LOJA	 := SE1->E1_LOJA
		P13->P13_DTINC   := dDataBase
		P13->P13_STATUS	 := "P"						
		P13->P13_CODCFG  := Alltrim(SEB->EB_XCODCFG)
		P13->(MsUnlock())
		Restarea(aArea2)
	EndIf
		
	nValTit2 := nValRec  //Pega valor do titulo para rotina de janela

	//------------------------------------------------------------------------------------------------------
	//Angelo Henrique - Data: 10/12/2021 - INICIO
	//------------------------------------------------------------------------------------------------------
	//AplicaÁ„o de nova regra para gerar baixa em atraso
	//passando a olhar agora as ocorrÍncias que de fato ir„o gerar baixa no titulo, 
	//dessa forma sÛ gerar baixa em atraso para os titulos que ir„o sofrer baixa vindas do banco.
	//OcorrÍncias que hoje fazem a baixa do tÌtulo: 06,07,08,36,37,38,39
	//------------------------------------------------------------------------------------------------------
	/*
	If Trim(mv_par06) == '341'

		lMotSys  := (Posicione("SEB", 1, xFilial("SEB")+mv_par06+cOcorr, "EB_OCORR") $ "09") //GetNewPar("MV_XXMOTBX", "09")Identifica se o motivo È v·lido para gerar registro no BSQ

	ElseIf Trim(mv_par06) == '237'

		//lMotSys  := (Posicione("SEB", 1, xFilial("SEB")+mv_par06+cOcorr, "EB_OCORR") $ "03||10||17||27||30||32") //GetNewPar("MV_XXMOTBX", "09")Identifica se o motivo È v·lido para gerar registro no BSQ
		
		//Alterado por Luiz Otavio * corrigir problema na geraÁ„o de baixa em atraso para titulos rejeitados.
		lMotSys  := (Posicione("SEB", 1, xFilial("SEB")+mv_par06+Alltrim(cOcorr), "EB_OCORR") $ "03||10||17||27||30||32") //GetNewPar("MV_XXMOTBX", "09")Identifica se o motivo È v·lido para gerar registro no BSQ

	EndIf
	*/
	
	If (Posicione("SEB", 1, xFilial("SEB")+mv_par06+Alltrim(cOcorr), "EB_OCORR") $ "06||07||08||36||37||38||39")

		lMotSys  := .T.

	EndIf
	//------------------------------------------------------------------------------------------------------
	//Angelo Henrique - Data: 10/12/2021 - FIM
	//------------------------------------------------------------------------------------------------------
	
	//If M->DBAIXA > SE1->E1_VENCREA .And. !lMotSys .AND. !( SE1->E1_CODEMP $ GETMV('MV_XNBXATR') ) //  MARCELA COIMBRA EM 13/10/2017 - CRIADO O PAR¬METRO GETMV('MV_XNBXATR')
	If M->DBAIXA > SE1->E1_VENCREA .And. lMotSys .AND. !( SE1->E1_CODEMP $ GETMV('MV_XNBXATR') ) //  MARCELA COIMBRA EM 13/10/2017 - CRIADO O PAR¬METRO GETMV('MV_XNBXATR')

		//‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
		//±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
		//PEGO INFORMACOES PARA ALIMENTAR O VETOR _aparcela e aDadUsr
		//±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
		//ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
		BBT->(DbSetOrder(7)) //BBT_PREFIX+BBT_NUMTIT+BBT_PARCEL+BBT_TIPTIT+BBT_RECPAG
		If BBT->(MsSeek(xFilial("BBT")+ cChave))
			If BBT->BBT_NIVEL == "4"
				DbSelectArea("BA3")
				BA3->(DbSetOrder(1))
				BA3->(MsSeek(xFilial("BA3")+BBT->BBT_CODOPE+BBT->BBT_CODEMP+BBT->BBT_MATRIC))

				_cCodInt  := BBT->BBT_CODOPE
				_cCodEmp  := BA3->BA3_CODEMP
				_cMatric  := BBT->BBT_MATRIC
				_cConEmp  := BA3->BA3_CONEMP
				_cVerCon  := BA3->BA3_VERCON
				_cSubCon  := BA3->BA3_SUBCON
				_cVerSub  := BA3->BA3_VERSUB
				_cNiveCob := BBT->BBT_NIVEL

			Else

				_cCodInt := BBT->BBT_CODOPE
				_cCodEmp := Iif(Empty(BBT->BBT_MATRIC),BBT->BBT_CODEMP,Space(25))
				_cMatric  := BBT->BBT_MATRIC
				_cConEmp := Iif(Empty(BBT->BBT_MATRIC),BBT->BBT_CONEMP,Space(25))
				_cVerCon := Iif(Empty(BBT->BBT_MATRIC),BBT->BBT_VERCON,Space(10))
				_cSubCon := Iif(Empty(BBT->BBT_MATRIC),BBT->BBT_SUBCON,Space(25))
				_cVerSub := Iif(Empty(BBT->BBT_MATRIC),BBT->BBT_VERSUB,Space(10))
				_cNiveCob := BBT->BBT_NIVEL
				
			Endif
		Else
			Alert("Titulo Nao Localizado no PLS (TABELA BBT)!!! " ;
				+"Juros nao calculados para o titulo ..: " + cChave)
			Return
		Endif

		//Pego valor da multa atraves do contrato
		//BQC->(MsSeek(xFilial("BQC")+_cCodInt+_cCodEmp+_cConEmp+_cVerCon+_cSubCon+_cVerSub))

		//‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
		//±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
		//chama funcao para calculo de juros + multa  passando como parametro :
		//(cod Cliente,Data Titulo,Data Baixa,Valor Titulo)
		//abril/09 retirado IGPM = Motta
		//±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
		//ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ

		//nValMult := U_CABA997(SE1->E1_VENCREA,M->DBAIXA,nValRec, SuperGetMv("MV_YCIGPM",,.F.))
		nValMult := U_CABA997(SE1->E1_VENCREA,M->DBAIXA,nValRec,.F.,SE1->E1_CODEMP,"FA200TIT")

		nValTit := Round(nValMult,2)  // pega valor Devido

		If nValTit <= 0
			Return
		EndIf

		// ALIMENTO _aDadUsr
		aDadUsr := {_cCodInt,_cCodEmp,_cMatric,_cConEmp,_cVerCon,_cSubCon,_cVerSub,_cNiveCob}

		// ALIMENTO _aParcela
		cAnoAdd :=  SUBSTR(DTOS(M->DBAIXA),1,4)
		cMesAdd  := SUBSTR(DTOS(M->DBAIXA),5,2)

		aadd(_aParcela,{cAnoAdd+cMesAdd,nValTit,cMesAdd+"/"+cAnoAdd,GetNewPar("MV_YCDLJ3","993"),"","","Baixa Em Atraso"})

		//---------------------------------------------------------------------
		//Angelo Henrique - Data: 09/07/2020
		//---------------------------------------------------------------------
		//Atendendo a lei que saiu no processo de pandemia:
		//LEI 8811/2020 - VEDA«√O COBRAN«A DE JUROS E MULTA
		//---------------------------------------------------------------------
		//Data: 02/06/2021 - Chamado:
		//---------------------------------------------------------------------
		//If Empty(_cMatric)

		//‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
		//±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
		//Chamo Rotina para geracao de adicionais dos titulos baixados para este cliente
		//±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
		//ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
		If !U_GerAdNeg(_aParcela,aDadUsr,ALLTRIM(cChave))
			MsgAlert("ImpossÌvel criar adicional para o(s) mÍs(es) solicitado(s). Verifique!", "AtenÁ„o")
		Endif

		//EndIf

	EndIf // TRATAMENTO DE ATRASADO

	RestArea(aArea)
Return
