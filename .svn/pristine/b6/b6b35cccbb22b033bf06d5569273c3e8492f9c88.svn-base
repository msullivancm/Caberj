#Include "RwMake.Ch"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³PLSATUTAB ºAutor  ³Geraldo Felix Jr.   º Data ³  09/23/04   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Migra o valor de cobranca do sub contrato para a familia    º±±
±±º          ³somente para pessoa juridica...                             º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function PLATUFAI()

If ! Pergunte("PLSPFM", .T.)
	Return
Endif

If  ! msgyesno("Este programa ira copiar os valores de faixa etaria do subcontrato para as Familias/Usuarios PJ")
	Return()
Endif

MsAguarde({|| PlsAtuFam()}, "", "Migracao valor cobranca familia", .T.)

MsgStop("Fim!")

Return

Static Function PlsAtuFam

Local cCodQtd, cCodFor, nHeader
Local cAno := mv_par02, cMes := mv_par01

BA3->(DbSetOrder(1))
BA3->(DbSeek(xFilial("BA3") + mv_par03 + alltrim(mv_par05) ))

While 	! BA3->(Eof()) .And. BA3->BA3_FILIAL = xFilial("BA3") .And.;
		BA3->BA3_CODINT >= mv_par03 .And. BA3->BA3_CODINT <= mv_par04 .And.;
		BA3->BA3_CODEMP >= mv_par05 .And. BA3->BA3_CODEMP <= mv_par06 .And.;
		BA3->BA3_MATRIC >= mv_par07 .And. BA3->BA3_MATRIC <= mv_par08
	
	MsProcTXT("Atualizando Familia Empresa "+BA3->BA3_CODEMP + " - Matricula "+ BA3->BA3_MATRIC)
	cCodFor := BA3->BA3_FORPAG
	
	If 	Empty(BA3->BA3_MOTBLO) .And. ! Empty(cCodFor) .And.;
	    BJK->(	DbSeek(xFilial("BJK") + BA3->BA3_CODINT + BA3->BA3_CODEMP +;
		BA3->BA3_MATRIC))
		BJ1->(MsSeek(xFilial("BJ1") + cCodFor))
		
		DbSelectArea("BJK")
	  	RecLock("BJK", .F.)
		Replace BJK_FILIAL With xFilial("BJK"), BJK_CODOPE With BA3->BA3_CODINT,;
		BJK_CODEMP With BA3->BA3_CODEMP, BJK_MATRIC With BA3->BA3_MATRIC,;
		BJK_CODFOR With cCodFor, BJK_AUTOMA With "1"
		MsUnLock()
		
		nLido := 0
	
		If BA3->BA3_TIPOUS = "2"	// Pessoa Juridica - Valores da Mensalidade
			/*
			cCodQtd := PlsRetQtd(	BA3->BA3_CODINT, BA3->BA3_CODEMP, BA3->BA3_CONEMP, BA3->BA3_VERCON,;
									BA3->BA3_SUBCON, BA3->BA3_VERSUB, BA3->BA3_CODPLA, BA3->BA3_VERSAO,;
									cCodFor, "","","")
			*/
			cCodQtd := "001"
			
			cSQL := "SELECT * FROM "+RetSQLName("BTN")+" WHERE "
			cSQL += "BTN_FILIAL = '"+xFilial("BTN")+"' AND "
			cSQL += "BTN_CODIGO = '"+BA3->BA3_CODINT+BA3->BA3_CODEMP+"' AND "
			cSQL += "BTN_NUMCON = '"+BA3->BA3_CONEMP+"' AND "
			cSQL += "BTN_VERCON = '"+BA3->BA3_VERCON+"' AND "
			cSQL += "BTN_SUBCON = '"+BA3->BA3_SUBCON+"' AND "
			cSQL += "BTN_VERSUB = '"+BA3->BA3_VERSUB+"' AND "
			cSQL += "BTN_CODPRO = '"+BA3->BA3_CODPLA+"' AND "
			cSQL += "BTN_VERPRO = '"+BA3->BA3_VERSAO+"' AND "
			cSQL += "BTN_CODQTD = '"+cCodQtd+"' AND "
			cSQL += "BTN_FAIFAM = '"+BJ1->BJ1_FAIFAM+"' AND BTN_CODFOR = '"+cCodFor+"' AND "
			cSQL += "D_E_L_E_T_ <> '*' AND BTN_TABVLD = (SELECT MAX(BTN_TABVLD) FROM "+RetSQLName("BTN")
			cSQL += " WHERE BTN_FILIAL = '"+xFilial("BTN")+"' AND "
			cSQL += "BTN_CODIGO = '"+BA3->BA3_CODINT+BA3->BA3_CODEMP+"' AND "
			cSQL += "BTN_NUMCON = '"+BA3->BA3_CONEMP+"' AND "
			cSQL += "BTN_VERCON = '"+BA3->BA3_VERCON+"' AND "
			cSQL += "BTN_SUBCON = '"+BA3->BA3_SUBCON+"' AND "
			cSQL += "BTN_VERSUB = '"+BA3->BA3_VERSUB+"' AND "
			cSQL += "BTN_CODPRO = '"+BA3->BA3_CODPLA+"' AND "
			cSQL += "BTN_VERPRO = '"+BA3->BA3_VERSAO+"' AND "
			cSQL += "BTN_CODQTD = '"+cCodQtd+"' AND "
			cSQL += "BTN_FAIFAM = '"+BJ1->BJ1_FAIFAM+"' AND BTN_CODFOR = '"+cCodFor+"' AND "
			cSQL += "BTN_TABVLD <= '"+cAno+cMes+"' AND D_E_L_E_T_ <> '*') "
			cSQL += "ORDER BY BTN_CODFOR, BTN_TIPUSR DESC,BTN_GRAUPA DESC ,BTN_SEXO DESC"
			
			PLSQuery(cSQL,"TrbBTN")
			
			While ! TrbBTN->(Eof())
				nLido ++
				DbSelectArea("BBU")
				RecLock("BBU", .T.)
				Replace BBU_FILIAL With xFilial("BBU") , BBU_CODOPE With BA3->BA3_CODINT,;
						BBU_CODEMP With BA3->BA3_CODEMP, BBU_MATRIC With BA3->BA3_MATRIC,;
						BBU_AUTOMA With "1"
				For nHeader := 1 To BBU->(FCount())
					If (nPos := BTN->(FieldPos(StrTran(BBU->(FieldName(nHeader)), "BBU", "BTN")))) > 0
						Replace &("BBU->" + BBU->(FieldName(nHeader))) With TRBBTN->(FieldGet(nPos))
					Endif
				Next
				MsUnLock()
				
				TrbBTN->(DbSkip())
			EndDo
			TrbBTN->(DbCloseArea())
		Endif
		
		nLido := 0
		
		If BA3->BA3_TIPOUS = "2"	// Pessoa Juridica - Descontos da Mensalidade
			BFT->(DbSetOrder(1))
			BFT->(DbSeek(	xFilial("BFT")  + BA3->BA3_CODINT + BA3->BA3_CODEMP + BA3->BA3_CONEMP +;
							BA3->BA3_VERCON + BA3->BA3_SUBCON + BA3->BA3_VERSUB + BA3->BA3_CODPLA +;
							BA3->BA3_VERSAO + cCodFor + cCodQtd))
			While 	BFT->BFT_FILIAL = xFilial("BFT") .And.;
					BFT->BFT_CODIGO = BA3->BA3_CODINT + BA3->BA3_CODEMP .And.;
					BFT->BFT_NUMCON = BA3->BA3_CONEMP .And. BFT->BFT_VERCON = BA3->BA3_VERCON .And.;
					BFT->BFT_SUBCON = BA3->BA3_SUBCON .And. BFT->BFT_VERSUB = BA3->BA3_VERSUB .And.;
					BFT->BFT_CODPRO = BA3->BA3_CODPLA .And. BFT->BFT_VERPRO = BA3->BA3_VERSAO .And.;
					BFT->BFT_CODFOR = cCodFor .And. BFT->BFT_CODQTD = cCodQtd  .And. ! BFT->(Eof())
				
				DbSelectArea("BFY")
				RecLock("BFY", .T.)
				Replace BFY_FILIAL With xFilial("BFY") , BFY_CODOPE With BA3->BA3_CODINT,;
						BFY_CODEMP With BA3->BA3_CODEMP, BFY_MATRIC With BA3->BA3_MATRIC,;
						BFY_AUTOMA With "1"
				nLido ++
				For nHeader := 1 To BFY->(FCount())
					If (nPos := BFT->(FieldPos(StrTran(BFY->(FieldName(nHeader)), "BFY", "BFT")))) > 0
						Replace &("BFY->" + BFY->(FieldName(nHeader))) With BFT->(FieldGet(nPos))
					Endif
				Next
				MsUnLock()
				
				BFT->(DbSkip())
			EndDo
		Endif

	Endif
	U_AtuUsu(cCodFor,cCodQtd,cAno,cMes,nHeader)	
	BA3->(DbSkip())
EndDo

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³PLSATUTAB ºAutor  ³Otacilio Albino Jr. º Data ³ 22/02/2005 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Migra o valor de cobranca do sub contrato para o Usuario   º±±
±±º          ³da Familia somente para pessoa juridica...                 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³                                                           º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function AtuUsu(cCodFor,cCodQtd,cAno,cMes,nHeader)

dbSelectArea("BA1")
dbSetOrder(1)
dbSeek(xFilial("BA1")+BA3->(BA3_CODINT+BA3_CODEMP+BA3_MATRIC))
While 	BA3->(BA3_FILIAL+BA3_CODINT+BA3_CODEMP+BA3_MATRIC) == BA1->(BA1_FILIAL+BA1_CODINT+BA1_CODEMP+BA1_MATRIC);
		.And. !Eof()
	If BA3->BA3_CODPLA <> BA1->BA1_CODPLA
		If Empty(BA1->BA1_MOTBLO) .And. ! Empty(cCodFor)
			nLido := 0
			
			If BA3->BA3_TIPOUS = "2"	// Pessoa Juridica - Valores da Mensalidade
			/*
				cCodQtd := PlsRetQtd(	BA1->BA1_CODINT, BA1->BA1_CODEMP, BA1->BA1_CONEMP, BA1->BA1_VERCON,;
										BA1->BA1_SUBCON, BA1->BA1_VERSUB, BA1->BA1_CODPLA, BA1->BA1_VERSAO,;
										cCodFor,"","","")
			*/
				cCodQtd := "001"
				
				cSQL := "SELECT * FROM "+RetSQLName("BTN")+" WHERE "
				cSQL += "BTN_FILIAL = '"+xFilial("BTN")+"' AND "
				cSQL += "BTN_CODIGO = '"+BA1->BA1_CODINT+BA1->BA1_CODEMP+"' AND "
				cSQL += "BTN_NUMCON = '"+BA1->BA1_CONEMP+"' AND "
				cSQL += "BTN_VERCON = '"+BA1->BA1_VERCON+"' AND "
				cSQL += "BTN_SUBCON = '"+BA1->BA1_SUBCON+"' AND "
				cSQL += "BTN_VERSUB = '"+BA1->BA1_VERSUB+"' AND "
				cSQL += "BTN_CODPRO = '"+BA1->BA1_CODPLA+"' AND "
				cSQL += "BTN_VERPRO = '"+BA1->BA1_VERSAO+"' AND "
				cSQL += "BTN_CODQTD = '"+cCodQtd+"' AND "
				cSQL += "BTN_FAIFAM = '"+BJ1->BJ1_FAIFAM+"' AND BTN_CODFOR = '"+cCodFor+"' AND "
				cSQL += "D_E_L_E_T_ <> '*' AND BTN_TABVLD = (SELECT MAX(BTN_TABVLD) FROM "+RetSQLName("BTN")
				cSQL += " WHERE BTN_FILIAL = '"+xFilial("BTN")+"' AND "
				cSQL += "BTN_CODIGO = '"+BA1->BA1_CODINT+BA1->BA1_CODEMP+"' AND "
				cSQL += "BTN_NUMCON = '"+BA1->BA1_CONEMP+"' AND "
				cSQL += "BTN_VERCON = '"+BA1->BA1_VERCON+"' AND "
				cSQL += "BTN_SUBCON = '"+BA1->BA1_SUBCON+"' AND "
				cSQL += "BTN_VERSUB = '"+BA1->BA1_VERSUB+"' AND "
				cSQL += "BTN_CODPRO = '"+BA1->BA1_CODPLA+"' AND "
				cSQL += "BTN_VERPRO = '"+BA1->BA1_VERSAO+"' AND "
				cSQL += "BTN_CODQTD = '"+cCodQtd+"' AND "
				cSQL += "BTN_FAIFAM = '"+BJ1->BJ1_FAIFAM+"' AND BTN_CODFOR = '"+cCodFor+"' AND "
				cSQL += "BTN_TABVLD <= '"+cAno+cMes+"' AND D_E_L_E_T_ <> '*') "
				cSQL += "ORDER BY BTN_CODFOR, BTN_TIPUSR DESC,BTN_GRAUPA DESC ,BTN_SEXO DESC"
				
				PLSQuery(cSQL,"TrcBTN")

			    dbSelectArea("BDK")
			    dbSetOrder(2)
			    If !dbSeek(xFilial("BDK")+BA1->(BA1->BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG))
					While ! TrcBTN->(Eof())
						nLido ++
						DbSelectArea("BDK")
						RecLock("BDK", .T.)
						Replace BDK_FILIAL With xFilial("BDK") , BDK_CODINT With BA1->BA1_CODINT,;
								BDK_CODEMP With BA1->BA1_CODEMP, BDK_MATRIC With BA1->BA1_MATRIC,;
								BDK_TIPREG With BA1->BA1_TIPREG, BDK_CODFAI With TrcBTN->BTN_CODFAI,;
								BDK_IDAINI With TrcBTN->BTN_IDAINI, BDK_IDAFIN With TrcBTN->BTN_IDAFIN,;
								BDK_VALOR  With TrcBTN->BTN_VALFAI, BDK_ANOMES With TrcBTN->BTN_ANOMES,;
								BDK_VLRANT With TrcBTN->BTN_VLRANT
						MsUnLock()
						TrcBTN->(DbSkip())
					EndDo
				Endif
				TrcBTN->(DbCloseArea())
			Endif
			
			nLido := 0
			
			If BA3->BA3_TIPOUS = "2"	// Pessoa Juridica - Descontos da Mensalidade
				BFT->(DbSetOrder(1))
				BFT->(DbSeek(	xFilial("BFT")  + BA1->BA1_CODINT + BA1->BA1_CODEMP + BA1->BA1_CONEMP +;
								BA1->BA1_VERCON + BA1->BA1_SUBCON + BA1->BA1_VERSUB + BA1->BA1_CODPLA +;
								BA1->BA1_VERSAO + cCodFor + cCodQtd))

			    dbSelectArea("BDQ")
			    dbSetOrder(1)
			    If !dbSeek(xFilial("BDQ")+BA1->(BA1->BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG))						

					While 	BFT->BFT_FILIAL = xFilial("BFT") .And.;
						BFT->BFT_CODIGO = BA1->BA1_CODINT + BA1->BA1_CODEMP .And.;        
						BFT->BFT_NUMCON = BA1->BA1_CONEMP .And. BFT->BFT_VERCON = BA1->BA1_VERCON .And.;
						BFT->BFT_SUBCON = BA1->BA1_SUBCON .And. BFT->BFT_VERSUB = BA1->BA1_VERSUB .And.;
						BFT->BFT_CODPRO = BA1->BA1_CODPLA .And. BFT->BFT_VERPRO = BA1->BA1_VERSAO .And.;
						BFT->BFT_CODFOR = cCodFor .And. BFT->BFT_CODQTD = cCodQtd  .And. ! BFT->(Eof())
						DbSelectArea("BDQ")
						RecLock("BDQ", .T.)
						Replace BDQ_FILIAL With xFilial("BDQ") , BDQ_CODINT With BA1->BA1_CODINT,;
								BDQ_CODEMP With BA1->BA1_CODEMP, BDQ_MATRIC With BA1->BA1_MATRIC,;
								BDQ_TIPREG With BA1->BA1_TIPREG, BDQ_CODFAI With BFT->BFT_CODFAI,;
								BDQ_TIPUSR With BFT->BFT_TIPUSR, BDQ_GRAUPA With BFT->BFT_GRAUPA,;
								BDQ_PERCEN With BFT->BFT_PERCEN, BDQ_VALOR  With BFT->BFT_VALOR,;
								BDQ_QTDDE  With BFT->BFT_QTDDE,  BDQ_QTDATE With BFT->BFT_QTDATE,;
								BDQ_DATDE  With BFT->BFT_DATDE,  BDQ_DATATE With BFT->BFT_DATATE,;
								BDQ_TIPO   With BFT->BFT_TIPO
						nLido ++
						MsUnLock()
						BFT->(DbSkip())
					EndDo
				EndIf	
			Endif
		EndIf
	EndIf 
	RecLock("BA1")
	Replace BA1->BA1_FORPAG With BA3->BA3_FORPAG
	MsUnLock()
	BA1->(dbSkip())
End

Return