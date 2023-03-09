#Include "Rwmake.Ch"
#Include "Colors.Ch"
#Include "TbiConn.Ch"
#include "topconn.ch"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "FONT.CH"

/*/
Autor       : Ronaldo Pena
---------------------------------------------------------------------------------------
Data      	: 18/09/2007
---------------------------------------------------------------------------------------
Descricao 	: Filtro para a montagem do Bordero de pagamentos
---------------------------------------------------------------------------------------
Alterações 	: 16/11/2007 - PH - Obter filtro pelo Saldo e não pelo Valor
07/03/2008 - Edilson : Titulo principal deve estar totalmente baixado.
---------------------------------------------------------------------------------------
Partida   	: Ponto de Entrada
/*/

#xtranslate bSetGet(<uVar>) => {|u| If(PCount()== 0, <uVar>,<uVar> := u)}

User Function F240FIL()

	Private _cFiltro

	cBancoDig  := GetMv("MV_BCODIG")
	cSeqAprova := Soma1(GetMv("MV_DOCSEQ"))
	PutMv("MV_DOCSEQ",cSeqAProva)

	_cFiltro := "Alltrim(E2_APROVA)== '"+cSeqAprova+"'"

	fMontaFiltro()
	IF _cFiltro == ""
		MsgBox("Executando procedimento padrão Microsiga.","Filtro cancelado!","INFO")
	Endif

Return(_cFiltro)


Static Function fMontaFiltro()

	nDlg00Larg := 650
	nDlg00Alt  := 410
	lOk        := .F.
	bOk        := {|| lOk:= .T. , oDlg01:End() }
	bCancel    := {|| oDlg01:End()}
	aButtons   := {}

	oFnt12AriN := TFont():New( "Arial" ,,-12,,.F.,,,,,.F. )
	oFnt13AriN := TFont():New( "Arial" ,,-13,,.F.,,,,,.F. )
	oFnt14AriB := TFont():New( "Arial" ,,-14,,.T.,,,,,.T. )

	aOrigem    := {"1 - PLS","2 - Financeiro","3 - Ambos" }
	cOrigem    := aOrigem[1]
	cNaturez   := Space(09)
	cPrefixo   := Space(03)
	cTpInc     := Space(80)
	cTpExc     := Space(80)
	cGrpRda    := Space(06)
	cBancoI    := ZGetVarIni(cModPgto,"Banco Igual"    		,Space(3)	,"F240FI2023.INI"			)
	cBancoD    := ZGetVarIni(cModPgto,"Banco Diferente"		,Space(3)	,"F240FI2023.INI"			)

	nVlrMin    := Val(ZGetVarIni(cModPgto,"Valor Minimo"	,'0'		,"F240FI2023.INI")			)
	nVlrMax    := Val(ZGetVarIni(cModPgto,"Valor Maximo"   	,'0'		,"F240FI2023.INI")			)

	lVlMinEd 	:= STRTRAN(ZGetVarIni(cModPgto,"VlMinEd"   	,''			,"F240FI2023.INI"),'"',''	)
	lVlMaxEd 	:= STRTRAN(ZGetVarIni(cModPgto,"VlMaxEd"   	,''			,"F240FI2023.INI"),'"',''	)

	lVlMinEd 	:= if("T"$lVlMinEd,.T.,.F.)
	lVlMaxEd 	:= if("T"$lVlMaxEd,.T.,.F.)

	aGrpPag    :={ }
	dBaixaI    := Ctod("")
	dBaixaF    := Ctod("")

	//------------------------------------------------------------------------------
	//Inicio - Angelo Henrique - Data: 09/08/2021 - Chamado 76463
	//------------------------------------------------------------------------------
	//1- Disponibilizando possibilidade de filtrar INTERIOR e GRANDE RIO
	//2- Disponibilizando possibilidade de colocar Grupo de Rubrica
	//------------------------------------------------------------------------------
	aGpPag    := {" ","1 - Interior","2 - Grande Rio","3 - Ambos" }
	cGpPag    := aGpPag[1]
	cGrubr    := Space(TAMSX3("ZUO_GRUPO")[1])
	//------------------------------------------------------------------------------
	//FIM - Angelo Henrique - Data: 09/08/2021 - Chamado 76463
	//------------------------------------------------------------------------------
	//1- Disponibilizando possibilidade de filtrar INTERIOR e GRANDE RIO
	//2- Disponibilizando possibilidade de colocar Grupo de Rubrica
	//------------------------------------------------------------------------------

	fGGrpPag()

	oDlg01:=TDialog():New(000,000,nDlg00Alt+30,nDlg00Larg ,"Filtro Especial - Versão 09/11/2007",,,,,,,,,.T.)

	oDlg01:nClrPane:= RGB(255,255,254)
	oDlg01:bStart  := {||(EnchoiceBar(oDlg01,bOk,bCancel,,aButtons))}

	oSayTipCon  :=TSay():New(035,005,{||"Origem do Título"    },oDlg01,,oFnt13AriN,,,,.T.,,,100,10)
	oSayNaturez :=TSay():New(050,005,{||"Natureza"            },oDlg01,,oFnt13AriN,,,,.T.,,,100,10)
	oSayNaturez :=TSay():New(065,005,{||"Prefixo"             },oDlg01,,oFnt13AriN,,,,.T.,,,100,10)

	//------------------------------------------------------------------------------
	//Inicio - Angelo Henrique - Data: 09/08/2021 - Chamado 76463
	//------------------------------------------------------------------------------
	//1- Disponibilizando possibilidade de filtrar INTERIOR e GRANDE RIO
	//2- Disponibilizando possibilidade de colocar Grupo de Rubrica
	//------------------------------------------------------------------------------

	oSayGpag  :=TSay():New(035,182,{||"Grupo de Pagamento"    },oDlg01,,oFnt13AriN,,,,.T.,,,100,10)
	oGetGpag  :=TComboBox():New(035,255,bSetGet(cGpPag),aGpPag,070,010,oDlg01,,{||.T.},,,,.T.,oFnt13AriN,,,{||.T.},,,,                ,"cGpPag"   )

	oSayGrub  :=TSay():New(050,182,{||"Grupo por Rubrica"    },oDlg01,,oFnt13AriN,,,,.T.,,,100,10)
	oGetGrub  :=TGet():New(050,255,bSetGet(cGrubr) ,oDlg01,070,10,               ,{||.T.},,,oFnt12AriN,,,.T.,,,{||.T.},,,,.F.,,"ZUO"  ,"cGrubr"  )

	//------------------------------------------------------------------------------
	//FIM - Angelo Henrique - Data: 09/08/2021 - Chamado 76463
	//------------------------------------------------------------------------------
	//1- Disponibilizando possibilidade de filtrar INTERIOR e GRANDE RIO
	//2- Disponibilizando possibilidade de colocar Grupo de Rubrica
	//------------------------------------------------------------------------------

	oSayEmissao :=TSay():New(080,005,{||"Considerar Tipos"    },oDlg01,,oFnt13AriN,,,,.T.,,,100,10)
	oSayEmissao :=TSay():New(095,005,{||"Desconsiderar Tipos" },oDlg01,,oFnt13AriN,,,,.T.,,,100,10)
	oSayGrpRda  :=TSay():New(110,005,{||"Grupo RDA"           },oDlg01,,oFnt13AriN,,,,.T.,,,100,10)
	oSayTipPag  :=TSay():New(135,005,{||"Tipo de Pagamento"   },oDlg01,,oFnt13AriN,,,,.T.,,,100,10)
	oSayBanco   :=TSay():New(150,005,{||"Banco Igual"         },oDlg01,,oFnt13AriN,,,,.T.,,,100,10)
	oSayBanco   :=TSay():New(165,005,{||"Banco Diferente"     },oDlg01,,oFnt13AriN,,,,.T.,,,100,10)
	oSayVlrMin  :=TSay():New(180,005,{||"Valor Minimo"        },oDlg01,,oFnt13AriN,,,,.T.,,,100,10)
	oSayVlrMax  :=TSay():New(195,005,{||"Valor Maximo"        },oDlg01,,oFnt13AriN,,,,.T.,,,100,10)

	oSayInfo    :=TSay():New(132,182,{||"Filtro Exclusivo para Títulos de Taxas" },oDlg01,,oFnt14AriB,,,,.T.,,,150,10)
	oSayBaixaI  :=TSay():New(145,188,{||"Data da Baixa Inicial"                  },oDlg01,,oFnt13AriN,,,,.T.,,,120,10)
	oSayBaixaF  :=TSay():New(160,188,{||"Data da Baixa Final"                    },oDlg01,,oFnt13AriN,,,,.T.,,,120,10)

	oGetOrigem  :=TComboBox():New(032,075,bSetGet(cOrigem),aOrigem,080,050,oDlg01,,{||.T.},,,,.T.,oFnt13AriN,,,{||.T.},,,,                ,"cOrigem"   )
	oGetNaturez :=TGet():New(050,075,bSetGet(cNaturez) ,oDlg01,060,10,               ,{||.T.},,,oFnt12AriN,,,.T.,,,{||.T.},,,,.F.,,"SED"  ,"cNaturez"  )
	oGetPrefixo :=TGet():New(065,075,bSetGet(cPrefixo) ,oDlg01,060,10,"@!"           ,{||.T.},,,oFnt12AriN,,,.T.,,,{||.T.},,,,.F.,,""     ,"cPrefixo"  )
	oGetTpInc   :=TGet():New(080,075,bSetGet(cTpInc)   ,oDlg01,242,10,               ,{||.T.},,,oFnt12AriN,,,.T.,,,{||.T.},,,,.F.,,       ,"cTpInc"    )
	oGetTpExc   :=TGet():New(095,075,bSetGet(cTpExc)   ,oDlg01,242,10,               ,{||.T.},,,oFnt12AriN,,,.T.,,,{||.T.},,,,.F.,,       ,"cTpExc"    )
	oGetGrpRda  :=TGet():New(110,075,bSetGet(cGrpRda)  ,oDlg01,060,10,               ,{||.T.},,,oFnt12AriN,,,.T.,,,{||.T.},,,,.F.,,"B16A" ,"cGrpRda"   )
	oGetTpPag   :=TGet():New(135,075,bSetGet(cModPgto) ,oDlg01,060,10,               ,{||.T.},,,oFnt13AriN,,,.T.,,,{||.F.},,,,.F.,,       ,"cModPgto"  )
	oGetBancoI  :=TGet():New(150,075,bSetGet(cBancoI)  ,oDlg01,060,10,               ,{||.T.},,,oFnt12AriN,,,.T.,,,{||.T.},,,,.F.,,       ,"cBancoI"   )
	oGetBancoD  :=TGet():New(165,075,bSetGet(cBancoD)  ,oDlg01,060,10,               ,{||.T.},,,oFnt12AriN,,,.T.,,,{||.T.},,,,.F.,,       ,"cBancoD"   )

	oGetVlrMin  :=TGet():New(180,075,bSetGet(nVlrMin)  ,oDlg01,060,10,"@E 999,999.99",{||.T.},,,oFnt12AriN,,,.T.,,,{||lVlMinEd},,,,.F.,,       ,"nVlrMin"   )
	oGetVlrMax  :=TGet():New(195,075,bSetGet(nVlrMax)  ,oDlg01,060,10,"@E 999,999,999.99",{||.T.},,,oFnt12AriN,,,.T.,,,{||lVlMaxEd},,,,.F.,,       ,"nVlrMax"   )

	oGetdBaixaI :=TGet():New(145,255,bSetGet(dBaixaI)  ,oDlg01,050,10,               ,{||.T.},,,oFnt12AriN,,,.T.,,,{||.T.},,,,.F.,,       ,"dBaixaI"   )
	oGetdBaixaF :=TGet():New(160,255,bSetGet(dBaixaF)  ,oDlg01,050,10,               ,{||.T.},,,oFnt12AriN,,,.T.,,,{||.T.},,,,.F.,,       ,"dBaixaF"   )

	oDlg01:Activate(,,,.T.)

	If lOk
		Processa({|| fProcessa()},"Aguarde Processamento...")
	Endif

Return()

Static Function  fGGrpPag()

Return()

Static Function fProcessa()

	Local aAreaSA2 := SA2->(GetArea())
	Local aAreaSE2 := SE2->(GetArea())

	DbSelectArea("SA2")
	DbSetOrder(1)

	cQry := " SELECT SE2.R_E_C_N_O_ AS RECSE2 "

	IF ALLTRIM(cPrefixo) = "RLE"
		cQry += " , ( SELECT PCT.PCT_BANCO "
		cQry += " FROM  " + RetSqlName("B44")  + " B44 "
		cQry += " INNER JOIN " + RetSqlName("ZZQ") + " ZZQ ON "
		cQry += " ZZQ_SEQUEN 		= B44_YCDPTC "
		cQry += " AND ZZQ_FILIAL 	= '" + xFilial("ZZQ") + "' "
		cQry += " AND ZZQ_DATDIG <> ' ' "
		cQry += " INNER JOIN " + RetSqlName("PCT") + "  PCT ON "
		cQry += " PCT_CODIGO 		= ZZQ_DBANCA "
		cQry += " AND PCT_CLIENT   = ZZQ_CODCLI "
		cQry += " AND PCT_LOJA	   = ZZQ_LOJCLI "
		cQry += " AND PCT_FILIAL 	= '" + xFilial("PCT") + "' "
		cQry += " WHERE "
		cQry += " B44_FILIAL 		= '" + xFilial("B44")  + "' "
		cQry += " AND B44_PREFIX 	= SE2.E2_PREFIXO "
		cQry += " AND B44_NUM   	= SE2.E2_NUM "
		cQry += " AND B44_PARCEL 	= SE2.E2_PARCELA "
		cQry += " AND B44_TIPO  	= 'NCC' "
		cQry += " AND B44.D_E_L_E_T_ = ' ' "
		cQry += " AND PCT.D_E_L_E_T_ = ' ' "
		cQry += " AND ZZQ.D_E_L_E_T_ = ' ' )  PCT_BANCO "
	Endif

	cQry += " FROM " + RetSqlName('SE2') + " SE2 "

	//------------------------------------------------------------------------------
	//Inicio - Angelo Henrique - Data: 09/08/2021 - Chamado 76463
	//------------------------------------------------------------------------------
	//1- Disponibilizando possibilidade de filtrar INTERIOR e GRANDE RIO
	//2- Disponibilizando possibilidade de colocar Grupo de Rubrica
	//------------------------------------------------------------------------------
	If Left(cGpPag,1) == "1" .OR. Left(cGpPag,1) == "2" .OR. Left(cGpPag,1) == "3"

		cQry += " INNER JOIN "
		cQry += "   " + RetSqlName("BAU") + "  BAU  "
		cQry += " ON "
		cQry += "   BAU.BAU_FILIAL = '" + xFilial("BAU") + "' "
		cQry += "   AND BAU.BAU_CODIGO = SE2.E2_CODRDA "
		cQry += "   AND BAU.D_E_L_E_T_ = ' ' "

		If Left(cGpPag,1) == "1"//INTEROR

			cQry += "   AND BAU.BAU_GRPPAG IN ('1001', '1002', '1003') "

		Else //Grande Rio

			cQry += "   AND BAU.BAU_GRPPAG NOT IN ('1001', '1002', '1003') "

		EndIf

	EndIf

	//-------------------------------------------------------
	//Se tiver preenchido grupo de cobrançca
	//-------------------------------------------------------
	If !Empty(AllTrim(cGrubr))

		cQry += " INNER JOIN "
		cQry += "   " + RetSqlName("ZUO") + "  ZUO  "
		cQry += " ON "
		cQry += "   ZUO.ZUO_FILIAL = '" + xFilial("ZUO") + "' "
		cQry += "   AND ZUO.ZUO_GRUPO = '" + cGrubr + "' "
		cQry += "   AND ZUO_PREF = SE2.E2_PREFIXO "
		cQry += "   AND ZUO.D_E_L_E_T_ = ' ' "

	EndIf
	//------------------------------------------------------------------------------
	//FIM - Angelo Henrique - Data: 09/08/2021 - Chamado 76463
	//------------------------------------------------------------------------------
	//1- Disponibilizando possibilidade de filtrar INTERIOR e GRANDE RIO
	//2- Disponibilizando possibilidade de colocar Grupo de Rubrica
	//------------------------------------------------------------------------------

	//-------------------------------------------------------
	// Se forma de pagto for 45
	// GLPI 87611
	// AJUSTE NA ROTINA - QUANDO O CADASTRO FORNECEDOR APRESENTAR FORM PAGTO = 45 PIX,
	// PUXAR BORDERÔ PIX (CABERJ
	//-------------------------------------------------------
	// Chamado  90584

	If cModPgto == "46"

		cQry += " INNER JOIN "
		cQry += "   " + RetSqlName("SA2") + "  SA2  "
		cQry += " ON "
		cQry += "   SA2.A2_FILIAL = '" + xFilial("SA2") + "' "
		cQry += "   AND SA2.A2_COD  =  SE2.E2_FORNECE  "
		cQry += "   AND SA2.A2_LOJA =  SE2.E2_LOJA  "
		cQry += "   AND SA2.A2_FORMPAG <> '45' "
		cQry += "   AND SA2.D_E_L_E_T_ = ' ' "

	EndIf

	//------------------------------------------------------------------------------
	//FIM - MMT - Data: 08/07/2021 - Chamado 87611
	//------------------------------------------------------------------------------

	//------------------------------------------------------------------------------
	//Angelo Henrique - Data: 01/03/2023
	//------------------------------------------------------------------------------
	//Chamado: 98049
	//------------------------------------------------------------------------------
	//Incluído validação para só pegar fornecedores que estão cadastrados como
	//forma de pagamento PIX
	//------------------------------------------------------------------------------
	If cModPgto == "45"

		cQry += " INNER JOIN "
		cQry += "   " + RetSqlName("SA2") + "  SA2  "
		cQry += " ON "
		cQry += "   SA2.A2_FILIAL = '" + xFilial("SA2") + "' "
		cQry += "   AND SA2.A2_COD  =  SE2.E2_FORNECE  "
		cQry += "   AND SA2.A2_LOJA =  SE2.E2_LOJA  "
		cQry += "   AND SA2.A2_FORMPAG = '" + cModPgto + "' "
		cQry += "   AND SA2.D_E_L_E_T_ = ' ' "

	EndIf
	//------------------------------------------------------------------------------

	cQry += " WHERE SE2.D_E_L_E_T_  <> '*'"
	cQry += "   AND SE2.E2_FILIAL    = '"+xFilial("SE2")  +"'"
	cQry += "   AND SE2.E2_VENCREA  >= '"+Dtos(dVenIni240)+"'"
	cQry += "   AND SE2.E2_VENCREA  <= '"+Dtos(dVenFim240)+"'"
	cQry += "   AND SE2.E2_NUMBOR    = ' '"
	cQry += "   AND SE2.E2_SALDO     > 0 "

	cQry += "   ORDER BY SE2.E2_PREFIXO, SE2.E2_NUM  "

	If Select("QRY") > 0
		QRY->(DbCloseArea())
	Endif

	DbUseArea(.T., "TOPCONN", TCGenQry(,,cQry), 'QRY', .F., .T.)
	nRegs := Contar("QRY","!Eof()")

	ProcRegua(nRegs)
	QRY->(DbGoTop())

	While QRY->(!Eof())

		IncProc()
		SE2->(DbGoTop())
		SE2->(DbGoTo(QRY->RECSE2))

		//***** Filtro de Prefixo *****
		If !Empty(cPrefixo) .And. SE2->E2_PREFIXO != cPrefixo
			QRY->(DbSkip())
			Loop
		Endif

		If Left(cOrigem,1) == "1" .And. Upper(Alltrim(SE2->E2_ORIGEM)) != "PLSMPAG"
			QRY->(DbSkip()) ; Loop
		ElseIf Left(cOrigem,1) == "2" .And. Upper(Alltrim(SE2->E2_ORIGEM)) == "PLSMPAG"
			QRY->(DbSkip()) ; Loop
		Endif

		//***** Filtro de Natureza *****
		If !Empty(cNaturez) .And. SE2->E2_NATUREZ != cNaturez
			QRY->(DbSkip()) ; Loop
		Endif


		//***** Filtro de Tipos a Considerar *****
		If !Empty(cTpInc) .And. !SE2->E2_TIPO $ cTpInc
			QRY->(DbSkip()) ; Loop
		Endif

		//***** Filtro de Tipos a Desconsiderar *****
		If !Empty(cTpExc) .And. SE2->E2_TIPO $ cTpExc
			QRY->(DbSkip()) ; Loop
		Endif

		//***** Filtro de Grupo de Atendimento *****
		If !Empty(cGrpRda)
			DbSelectArea("BAU")
			DbSetOrder(1)
			If DbSeek(xFilial("BAU")+SE2->E2_CODRDA)
				If BAU->BAU_GRPPAG <> Left(cGrpRda, Len(BAU->BAU_GRPPAG))
					QRY->(DbSkip()) ; Loop
				EndIf
			Else
				QRY->(DbSkip()) ; Loop
			EndIf
			DbSelectArea("QRY")
		Endif

		If !SA2->(DbSeek(xFilial("SA2")+SE2->E2_FORNECE+SE2->E2_LOJA))
			MsgBox("Fornecedor não cadastrado!!!")
			Return
		EndIf

		//***** Filtro de Banco Igual *****
		IF ALLTRIM(cPrefixo) <> "RLE"
			If !Empty(cBancoI) .And. !SA2->A2_BANCO $ cBancoI
				QRY->(DbSkip()) ; Loop
			Endif
		Endif

		//***** Filtro de Banco Diferente *****
		IF ALLTRIM(cPrefixo) <> "RLE"
			If !Empty(cBancoD) .And. SA2->A2_BANCO $ cBancoD
				QRY->(DbSkip()) ; Loop
			Endif
		Endif

			/*
			SE FOR 341 - CREDITO EM CONTA MODALIDADE 01
			SE FOR <> 341 E < 5000 MODALIDADE 03 // Regra banco central para DOC/TED
			SE FOR BANCO DIGITAL OU VALOR ACIMA DE 5000 SERA MODALcmodpgtoIDADE TED 41    
			*/

		IF ALLTRIM(cPrefixo) = "RLE"

			if cmodpgto <> '03' .AND. cmodpgto <> '41'
				If cmodpgto == '01' .and.  QRY->PCT_BANCO = "341"
					// Sem acao
				Else
					QRY->(DbSkip()) ; Loop
				Endif
			Endif

			// Regra banco central para DOC/TED
			if cmodpgto <> '01' .AND. cmodpgto <> '41'
				If cmodpgto == '03' .and.  QRY->PCT_BANCO <> "341" .AND. SE2->E2_SALDO < 5000 .AND. !QRY->PCT_BANCO $ cBancoDig
					// Sem acao
				Else
					QRY->(DbSkip()) ; Loop
				Endif
			Endif

			// Regra banco central para DOC/TED
			if cmodpgto <> '01' .AND. cmodpgto <> '03'
				If (cmodpgto == '41' .and. QRY->PCT_BANCO <> "341" .AND. SE2->E2_SALDO > 5000 ) .OR. QRY->PCT_BANCO $ cBancoDig
					// Sem acao
				Else
					QRY->(DbSkip()) ; Loop
				Endif
			Endif

		Endif

		If cmodpgto == '03' .and.  SA2->A2_BANCO $ cBancoDig
			QRY->(DbSkip()) ; Loop
		Endif

		IF ALLTRIM(cPrefixo) <> "RLE"

			If ((nVlrMin > 0 .And. SE2->E2_SALDO > nVlrMin) .or. SA2->A2_BANCO $ cBancoDig)
				A:='B'
			ElseIf (nVlrMin > 0 .And. SE2->E2_SALDO < nVlrMin)
				QRY->(DbSkip()) ; Loop
			Endif

		Else

			If ((nVlrMin > 0 .And. SE2->E2_SALDO > nVlrMin) .or. QRY->PCT_BANCO $ cBancoDig)
				A:='B'
			ElseIf (nVlrMin > 0 .And. SE2->E2_SALDO < nVlrMin)
				QRY->(DbSkip()) ; Loop
			Endif

		Endif

		//***** Verificar Valor Maximo *****
		If nVlrMax > 0 .And. SE2->E2_SALDO > nVlrMax
			QRY->(DbSkip())
			Loop
		Endif

		//***** Validação para o módulo PLS (liberação) *****
		If Upper(Alltrim(SE2->E2_ORIGEM)) $ "PLSMPAG|PLSM152"
			If !SE2->E2_TIPO $ MVISS+"|"+MVTAXA+"|"+MVTXA+"|"+MVINSS+"|"+"|SES"
				If SA2->A2_YBLQPLS == 'S' .Or.  (AllTrim(SA2->A2_YBLQPLS) == "" .and. SA2->A2_tipo =='J')  // Edilson Leal 03/01/08 - Incluido tratamento para campo vazio.
					IF !SE2->E2_YLIBPLS $ 'S|M'
						QRY->(DbSkip())
						Loop
					ENDIF
				Endif
			Endif
		Endif

		//****** Verificar se o Titulo refere-se a Taxa para validar a Baixa do Pai *****
		If SE2->E2_TIPO $ MVISS+"|"+MVTAXA+"|"+MVTXA+"|"+MVINSS+"|"+"|SES"
			If !Empty(dBaixaI) .And. !Empty(dBaixaF)
				lBxPai := fBxPai(AllTrim(SE2->E2_FILIAL), AllTrim(SE2->E2_PREFIXO), AllTrim(SE2->E2_NUM), AllTrim(SE2->E2_PARCELA), Alltrim(SE2->E2_NATUREZ))
				If !lBxPai
					QRY->(DbSkip())
					Loop
				EndIf
			EndIf
		Endif

		//******  Chamado 95053 *****

		IF ALLTRIM(cPrefixo) = "COM"

			If ALLTRIM(SE2->E2_PREFIXO) = "COM" .AND. !SE2->E2_YLIBPLS $ 'S|M'
				QRY->(DbSkip())
				Loop
			Endif

			If ALLTRIM(SE2->E2_PREFIXO) = "COM"  .AND.  SE2->E2_TIPO $ MVISS+"|"+MVTAXA+"|"+MVTXA+"|"+MVINSS+"|"+"|SES"
				QRY->(DbSkip())
				Loop
			Endif

		Endif

		//******  Fim Chamado 95053 *****

		SE2->(RecLock("SE2",.F.))

		IF ALLTRIM(cPrefixo) = "RLE"
			SE2->E2_YBCOCNB := QRY->PCT_BANCO
		else
			SE2->E2_YBCOCNB := SA2->A2_BANCO
		Endif

		SE2->E2_APROVA  := cSeqAprova
		SE2->(MsUnLock())

		QRY->(DbSkip())
	End

	RestArea(aAreaSA2)
	RestArea(aAreaSE2)

Return


Static Function ZGetVarIni(_cTopico,_cItem,_cDefault,_cFile)

	Local _cLine
	Local _cWord
	Local _nPos
	Local _cRet      := _cDefault
	Local _lContinua := .T.

	If !File(_cFile)
		Return(_cDefault)
	Endif

	Ft_FUse(_cFile)
	Ft_FGoTop()

	While !Ft_FEof() .And. _lContinua

		_cLine := AllTrim(Ft_FReadLn())

		If Empty(_cLine) .Or. Subs(_cLine,1,1) == "#"
			Ft_FSkip()
			Loop
		Endif

		If Subs(_cLine,1,1) == "[" .And. Subs(_cLine,Len(_cLine),1) == "]"
			_cChave := Subs(_cLine,2,Len(_cLine)-2)

			If Upper(_cTopico) == Upper(_cChave)
				Ft_FSkip()

				While !Ft_FEof() .And. _lContinua

					_cLine := AllTrim(Ft_FReadLn())

					If Subs(_cLine,1,1) == "[" .And. Subs(_cLine,Len(_cLine),1) == "]"
						_lContinua := .F.
						Exit
					EndIf

					If (_nPos := AT("=",_cLine) ) > 0
						_cWord := Subs(_cLine,1,_nPos-1)
						If Upper(Alltrim(_cWord)) != Upper(Alltrim(_cItem))
							Ft_FSkip()
							Loop
						Endif
						_cRet := AllTrim(Subs(_cLine,_nPos+1))
						Ft_FSkip()
						While !Ft_FEof()
							_cLine := AllTrim(Ft_FReadLn())
							If Empty(_cLine) .Or. AT("=",_cLine) > 0
								_lContinua := .F.
								Exit
							Endif
							_cRet += _cLine
							Ft_FSkip()
						End
					EndIf
					Ft_FSkip()
				End
			Else
				Ft_FSkip()
				While !Ft_FEof()
					_cLine := AllTrim(Ft_FReadLn())
					If Subs(_cLine,1,1) != "[" .And. Subs(_cLine,Len(_cLine),1) != "]"
						Ft_Fskip()
					Else
						Exit
					EndIf
				End
			EndIf
		EndIf
	End
	Ft_Fuse()
Return( If(Left(_cRet,1)=="&",&(Subs(_cRet,2)),_cRet))


Static Function fBxPai(cTxFil, cTxPref, cTxNum, cTxParc, cTxNat)

	lOk := .F.
	cCpoImpo := ""

	If cTxNat $ Alltrim(GetMV("MV_PISNAT"))
		cCpoParc := "E2_PARCPIS"
	ElseIf cTxNat $ Alltrim(GetMV("MV_COFINS"))
		cCpoParc := "E2_PARCCOF"
	ElseIf cTxNat $ Alltrim(GetMV("MV_CSLL"))
		cCpoParc := "E2_PARCSLL"
	ElseIf cTxNat $ Alltrim(GetMV("MV_IRF"))
		cCpoParc := "E2_PARCIR"
		cCpoImpo := "   AND E2_IRRF > 0"
	ElseIf cTxNat $ Alltrim(GetMV("MV_ISS"))
		cCpoParc := "E2_PARCISS"
	ElseIf cTxNat $ Alltrim(GetMV("MV_INSS"))
		cCpoParc := "E2_PARCINS"
	ElseIf cTxNat $ Alltrim(GetMV("MV_SEST"))
		cCpoParc := "E2_PARCSES"
	Else
		Return(lOk)
	EndIf

	cQry := " SELECT E2_BAIXA "
	cQry += " FROM " + RetSqlName("SE2")
	cQry += " WHERE D_E_L_E_T_ <>'*' "
	cQry += "   AND E2_FILIAL  = '" + cTxFil + "'"
	cQry += "   AND E2_PREFIXO = '" + cTxPref + "'"
	cQry += "   AND E2_NUM     = '" + cTxNum + "'"
	cQry += "   AND " + cCpoParc + "='" + cTxParc + "'"
	cQry += "   AND E2_BAIXA >='" + dTos(dBaixaI) + "'"
	cQry += "   AND E2_BAIXA <='" + dTos(dBaixaF) + "'"
	cQry += cCpoImpo
	cQry += "   AND E2_SALDO = 0"

	If TcSqlExec(cQry) < 0
		MsgInfo("Erro na seleção de Registros !!!","Atenção")
		Return (lOk)
	Endif

	If Select("QRY2") > 0
		QRY2->(DbCloseArea())
	Endif

	DbUseArea(.T., "TOPCONN", TCGenQry(,,cQry), 'QRY2', .F., .T.)

	QRY2->(DbGoTop())
	If !Empty(QRY2->E2_BAIXA)
		lOk := .T.
	EndIf

Return (lOk)
