#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'RWMAKE.CH'
#INCLUDE 'FONT.CH'
#INCLUDE 'COLORS.CH'
#INCLUDE "TopConn.ch"

#DEFINE c_ent CHR(13)+CHR(10)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ CABR021  ºAutor  ³ Microsiga          º Data ³  04/07/09   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Relatorio para reembolso - nova rotina.                    º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function CABR021

/*ÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±± Declaração de cVariable dos componentes                                 ±±
Ù±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*/

Private oFntAri13N	:= TFont():New( "Arial" ,,-13,,.F.,,,,,.F. )
Private oFntAri11N	:= TFont():New( "Arial" ,,-11,,.F.,,,,,.F. )
Private dDataIni	:= cTod("  /  /  ")
Private dDataFim	:= cTod("  /  /  ")
Private dPgtoIni	:= cTod("  /  /  ")
Private dPgtoFim	:= cTod("  /  /  ")
Private dPrevIni	:= cTod("  /  /  ")
Private dPrevFim	:= cTod("  /  /  ")
Private oRadio
Private nRadio1
Private nRadio2
Private aButtons   := {}
Private bOk        := {|| fMontaRel()}
Private bCancel    := {|| oDlg1:End()}
Private cSituaca   := "1"
Private cPrefixo   := Space(6)
Private ctprel     := Space(6)
Private cBancoDig  := strTran(GetMv("MV_BCODIG"),"|","','")
Private nOrdem     := 1
Private aSituaca   := {"Protocolado","Calculado","Liberado","Cancelados","Pgto Eletronico","Manuais","Todos Pagos"}
Private aPrefixo   := {"Todos","RLE","AXF"}
Private aTprel     := {"C/Compl","S/Compl"}
Private _cInd      := CriaTrab(Nil, .F.)
Private cOrdem     := " "
Private cModPgto   := Space(TamSx3("EA_MODELO" )[1])
Private cDigProt   := space(15)

oDlg1 := TDialog():New(070,274,600,670,"Relação de Pedidos de Reembolso Por Situação",,,,,,,,,.T.)

	oDlg1:bStart := {||(EnchoiceBar(oDlg1,bOk,bCancel,,aButtons))}

	oGrp1		:= TGROUP():New (030, 008, 060, 188, OemToAnsi ("Periodo do Pedido"), oDlg1, 0, 0, .T., .T.)
	oSay01		:= TSay():New(043,012,{|| "Data Inicio"  },oDlg1,,oFntAri13N,,,,.T.,,,047,10)
	oSay02		:= TSay():New(043,096,{|| "Data Fim   "  },oDlg1,,oFntAri13N,,,,.T.,,,047,10)
	oGet01		:= TGet():New(043,050,bSetGet(dDataIni  ),oDlg1,045,10,"",{||.T. },,,oFntAri13N,,,.T.,,,{||.T.},,,,.F.,,"","dDataIni"  )
	oGet02		:= TGet():New(043,128,bSetGet(dDataFim  ),oDlg1,045,10,"",{||.T. },,,oFntAri13N,,,.T.,,,{||.T.},,,,.F.,,"","dDataFim"  )

	oGrp2		:= TGROUP():New (062, 008, 104, 188, OemToAnsi ("Data de Pagamento"), oDlg1, 0, 0, .T., .T.)
	oSay03		:= TSay():New(078,012,{|| "Data Inicio"  },oDlg1,,oFntAri13N,,,,.T.,,,035,10)
	oSay04		:= TSay():New(078,096,{|| "Data Fim   "  },oDlg1,,oFntAri13N,,,,.T.,,,035,10)
	oGet03		:= TGet():New(078,050,bSetGet(dPgtoIni  ),oDlg1,045,10,"",{||.T. },,,oFntAri13N,,,.T.,,,{||.T.},,,,.F.,,"","dPgtoIni"  )
	oGet04		:= TGet():New(078,128,bSetGet(dPgtoFim  ),oDlg1,045,10,"",{||.T. },,,oFntAri13N,,,.T.,,,{||.T.},,,,.F.,,"","dPgtoFim"  )

	oGrp3		:= TGROUP():New (106, 008, 148, 188, OemToAnsi ("Data Prevista de Pagamento"), oDlg1, 0, 0, .T., .T.)
	oSay05		:= TSay():New(122,012,{|| "Data Inicio"  },oDlg1,,oFntAri13N,,,,.T.,,,035,10)
	oSay06		:= TSay():New(122,096,{|| "Data Fim   "  },oDlg1,,oFntAri13N,,,,.T.,,,035,10)
	oGet05		:= TGet():New(122,050,bSetGet(dPrevIni  ),oDlg1,045,10,"",{||.T. },,,oFntAri13N,,,.T.,,,{||.T.},,,,.F.,,"","dPrevIni"  )
	oGet06		:= TGet():New(122,128,bSetGet(dPrevFim  ),oDlg1,045,10,"",{||.T. },,,oFntAri13N,,,.T.,,,{||.T.},,,,.F.,,"","dPrevFim"  )

	oSay07		:= TSay():New(150,012,{|| "Situação   "  },oDlg1,,oFntAri13N,,,,.T.,,,035,10)
	oSituaca	:= TComboBox():New( 160,012,bSetGet(cSituaca),aSituaca ,080,10 ,oDlg1,,,{||fAtuBrw()},,,.T.,oFntAri13N,,,{||.T.})

	oSay08		:= TSay():New(150,128,{|| "Motivo     "  },oDlg1,,oFntAri13N,,,,.T.,,,035,10)
	oGet07		:= TGet():New(160,128,bSetGet(cModPgto  ),oDlg1,035,10,"",{||.T. },,,oFntAri13N,,,.T.,,,{||.T.},,,,.F.,,"58","cModPgto")

	oSay09		:= TSay():New(180,012,{|| "Dig.Protoc."  },oDlg1,,oFntAri13N,,,,.T.,,,035,10)
	oGet08		:= TGet():New(190,012,bSetGet(cDigProt  ),oDlg1,070,10,"",{||.T. },,,oFntAri13N,,,.T.,,,{||.T.},,,,.F.,,"","dPrevFim"  )

	oSay10		:= TSay():New(180,128,{|| "Prefixo    "  },oDlg1,,oFntAri13N,,,,.T.,,,035,10)
	oPrefixo	:= TComboBox():New( 190,128,bSetGet(cPrefixo),aPrefixo ,035,10 ,oDlg1,,,,,,.T.,oFntAri13N,,,{||.T.})

	oSay11 := TSay():New(210,012,{|| "Complemento"  },oDlg1,,oFntAri13N,,,,.T.,,,045,10)
	oTprel := TComboBox():New( 220,12,bSetGet(cTprel),atprel ,070,10 ,oDlg1,,,,,,.T.,oFntAri13N,,,{||.T.})

oDlg1:Activate(,,,.T.)

return


//**********************************************************************//
// Tratamento de possibilidade de preenchimento de campos de filtro		//
//**********************************************************************//
Static Function fAtuBrw()

If Upper(cSituaca) $ Upper(("Liberado|Calculado|Pgto Eletronico|Manuais|Todos Pagos"))
	oGet03:bWhen	:= {|| .T.}
	oGet04:bWhen	:= {|| .T.}
	oGet08:bWhen	:= {|| .F.}
	oPrefixo:bWhen	:= {|| .T.}
Else
	oGet03:bWhen	:= {|| .F.}
	oGet04:bWhen	:= {|| .F.}
	oGet08:bWhen	:= {|| .T.}
	oPrefixo:bWhen	:= {|| .F.}
Endif

oPrefixo:Refresh()
oSituaca:Refresh()
oDlg1:Refresh()

return


//**********************************************************************//
// Função para a montagem do relatório									//
//**********************************************************************//
Static Function fMontaRel()

Local cDesc1			:= "Este programa tem como objetivo imprimir relatorio  "
Local cDesc2			:= "de acordo com os parametros informados pelo usuario."
Local cDesc3			:= "Relação de pedidos de de reembolso  "
Local aOrd				:= {}

Private titulo			:= "Relação de Pedidos de reembolso Por Situação "
Private nLin			:= 80
Private Cabec1			:= " P E R I O D O :  "
Private Cabec2			:= " "
Private aVetEmp			:= {}
Private aVetFil			:= {}
Private aTabEmp			:= {}
Private aVetAviso		:= {}
Private lEnd			:= .F.
Private lAbortPrint		:= .F.
Private CbTxt			:= ""
Private limite			:= 220
Private tamanho			:= "G"
Private nomeprog		:= "CABR21x" // Coloque aqui o nome do programa para impressao no cabecalho
Private nTipo			:= 18
Private aReturn			:= { "Zebrado", 1, "Administracao", 2, 2, 1, "", 1}
Private nLastKey		:= 0
Private cPerg			:= "MMX058"
Private cbcont			:= 00
Private CONTFL			:= 01
Private m_pag			:= 01
Private wnrel			:= "CABR21x" // Coloque aqui o nome do arquivo usado para impressao em disco
Private cString			:= "B44"
Private cCabRel			:= "Protocolo   Cliente                          CPF          Banco     Agencia    Conta     Data Pedido   Data Previsao   Data Pgto       Documento         Vl.Pedido    Vl. Reembolso   Digitador Prot.  Cheque   Data Evento"

dbSelectArea(cString)
dbSetOrder(1)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta a interface padrao com o usuario...                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
wnrel := SetPrint(cString,NomeProg,cPerg,@titulo,cDesc1,cDesc2,cDesc3,.T.,aOrd,.T.,Tamanho,,.T.)

If nLastKey == 27
	Return
Endif

SetDefault(aReturn,cString)

If nLastKey == 27
	Return
Endif

nTipo := If(aReturn[4]==1,15,18)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Processamento. RPTSTATUS monta janela com a regua de processamento. ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
RptStatus({|| RunReport(Cabec1,Cabec2,Titulo,nLin) },Titulo)

return



/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFun‡„o    ³RUNREPORT º Autor ³ AP6 IDE            º Data ³  13/08/08   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescri‡„o ³ Funcao auxiliar chamada pela RPTSTATUS. A funcao RPTSTATUS º±±
±±º          ³ monta a janela com a regua de processamento.               º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Programa principal                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function RunReport(Cabec1,Cabec2,Titulo,nLin)

Local nOrdem
Local cAlias		:= "_TMP"
Local cQuery		:= " "

Private lPgto		:= Upper(cSituaca) $ 'MANUAIS|PGTO ELETRONICO|TODOS PAGOS'

If Upper(cSituaca) $ ("PROTOCOLADO|CANCELADO")

	If nOrdem == 1
		cOrdem := "PLANO+MATRICULA "
	Else
		cOrdem := "PLANO+PROTOCOLO "
	Endif

	cQuery := " SELECT ZZQ_SEQUEN       PROTOCOLO,																			" + c_ent
	cQuery += " 	TRIM(A1_NOME)    NOME,																					" + c_ent
	cQuery += " 	A1_CGC           CGC,																					" + c_ent
	cQuery += " 	CASE WHEN ZZQ_XTPRGT = '2'  THEN 'SIM' ELSE 'NAO' END CHEQUE,											" + c_ent
	cQuery += " 	CASE WHEN ZZQ_XTPRGT <> '1' THEN ' ' WHEN ZZQ_DBANCA <> ' ' THEN ZZQ_XBANCO ELSE A1_XBANCO END BANCO,	" + c_ent
	cQuery += " 	CASE WHEN ZZQ_XTPRGT <> '1' THEN ' ' WHEN ZZQ_DBANCA <> ' ' THEN ZZQ_XAGENC ELSE A1_XAGENC END AGENCIA,	" + c_ent
	cQuery += " 	CASE WHEN ZZQ_XTPRGT <> '1' THEN ' ' WHEN ZZQ_DBANCA <> ' ' THEN ZZQ_XCONTA ELSE A1_XCONTA END CONTA,	" + c_ent
	cQuery += " 	CASE WHEN ZZQ_XTPRGT <> '1' THEN ' ' WHEN ZZQ_DBANCA <> ' ' THEN ZZQ_XDGCON ELSE A1_XDGCON END DIGITO,	" + c_ent
	cQuery += " 	ZZQ_DATDIG       DAT_DIG,																				" + c_ent
	cQuery += "		ZZQ_DATPRE       DAT_PREV,																				" + c_ent
	cQuery += " 	ZZQ_VLRTOT       VL_PAGO,																				" + c_ent
	cQuery += " 	0                VALOR,																					" + c_ent
	cQuery += " 	TRIM(ZZQ_USRDIG) DIGITADOR,																				" + c_ent
	cQuery += " 	' '              B44CHVSE1,																				" + c_ent
	cQuery += " 	ZZQ_CPFEXE       CPFEXE,																				" + c_ent
	cQuery += " 	ZZQ_REGEXE       REGEXE,																				" + c_ent
	cQuery += " 	ZZQ_SIGEXE       SIGEXE,																				" + c_ent
	cQuery += " 	ZZQ_ESTEXE       ESTEXE,																				" + c_ent
	cQuery += " 	TRIM(ZZQ_NOMEXE) NOMEXE,																				" + c_ent
	cQuery += " 	' '              E2_BAIXA,																				" + c_ent
	cQuery += " 	FORMATA_MATRICULA_MS(TRIM(ZZQ_CODBEN)) FMATRIC,															" + c_ent
	cQuery += " 	TRIM(PCA_DESCRI) PORTA_ENTRADA,																			" + c_ent
	cQuery += " 	DECODE(ZZQ_TPSOL,'1','SOLIC. REEMBOLSO','2','SOLIC. ESPECIAL') TIPO_REEMBOLSO,							" + c_ent
	cQuery += " 	TRIM(PCB_DESCRI) CANAL,																					" + c_ent
	cQuery += " 	BA1_CODINT       OPERADORA,																				" + c_ent
	cQuery += " 	BA1_CODEMP       EMPRESA,																				" + c_ent
	cQuery += " 	BA1_MATRIC       MATRICULA,																				" + c_ent
	cQuery += " 	BA1_TIPREG       TIPO,																					" + c_ent
	cQuery += " 	BA1_NOMUSR       USUARIO,																				" + c_ent
	cQuery += " 	BA1_CODPLA       PLANO,																					" + c_ent
	cQuery += " 	BA1_VERSAO       VERSAO,																				" + c_ent
	cQuery += " 	CASE WHEN bow_xdteve IS NULL THEN bow_xdteve  															" + c_ent
	cQuery += " 		ELSE SUBSTR(bow_xdteve, 7,2)||'/'||SUBSTR(bow_xdteve, 5,2)||'/'||SUBSTR(bow_xdteve, 1,4) 			" + c_ent
	cQuery += " 	END DATA_EVENTO																							" + c_ent
	cQuery += " FROM " + 	RetSqlName("ZZQ") + " ZZQ"
	cQuery += "		LEFT JOIN " + 	RetSqlName("BOW") + " BOW ON (BOW_FILIAL = ZZQ_FILIAL AND BOW_YCDPTC = ZZQ_SEQUEN AND BOW.D_E_L_E_T_ = ' ') "
	cQuery +=	" INNER JOIN " + RetSqlName("SA1") + " SA1"
	cQuery +=	  " ON (    A1_FILIAL = '" + xFilial("SA1") + "'"
	cQuery +=		  " AND A1_COD    = ZZQ_CODCLI"
	cQuery +=		  " AND A1_LOJA   = ZZQ_LOJCLI)"
	cQuery +=	" INNER JOIN " + RetSqlName("BA1") + " BA1"
	cQuery +=	  " ON (    BA1_FILIAL = '" + xFilial("BA1") + "'"
	cQuery +=		  " AND BA1_CODINT = SUBSTR(ZZQ_CODBEN, 1,4)"
	cQuery +=		  " AND BA1_CODEMP = SUBSTR(ZZQ_CODBEN, 5,4)"
	cQuery +=		  " AND BA1_MATRIC = SUBSTR(ZZQ_CODBEN, 9,6)"
	cQuery +=		  " AND BA1_TIPREG = SUBSTR(ZZQ_CODBEN,15,2)"
	cQuery +=		  " AND BA1_DIGITO = SUBSTR(ZZQ_CODBEN,17,1))"
	cQuery +=	" LEFT JOIN PCA010 PCA"
	cQuery +=	  " ON (    PCA.D_E_L_E_T_ = ' '"
	cQuery +=		  " AND PCA_FILIAL = '" + xFilial("PCA") + "'"
	cQuery +=		  " AND PCA_COD    = ZZQ_XWEB)"
	cQuery +=	" LEFT JOIN PCB010 PCB"
	cQuery +=	  " ON (    PCB.D_E_L_E_T_ = ' '"
	cQuery +=		  " AND PCB_FILIAL = '" + xFilial("PCB") + "'"
	cQuery +=		  " AND PCB_COD    = ZZQ_CANAL)"
	cQuery += " WHERE ZZQ.D_E_L_E_T_ = ' ' AND SA1.D_E_L_E_T_ = ' ' AND BA1.D_E_L_E_T_ = ' '"
	cQuery +=	" AND ZZQ_FILIAL  = '" + xFilial("ZZQ") + "'"

	if Upper(cSituaca) == 'PROTOCOLADO'
		cQuery += " AND ZZQ_STATUS <> '2'"
	elseif Upper(cSituaca) == 'CANCELADO'
		cQuery += " AND ZZQ_STATUS = '2'"
	endif
	
	if !empty(dDataFim)
		cQuery += " AND ZZQ_DATDIG BETWEEN '" + DtoS(dDataIni) + "' AND '" + DtoS(dDataFim) + "'"
	endif

	if !empty(dPrevFim)
		cQuery += " AND ZZQ_DATPRE BETWEEN '" + DtoS(dPrevIni) + "' AND '" + DtoS(dPrevFim) + "'"
	endif

	if !empty(cDigProt)
		cQuery += " AND ZZQ_USRDIG = '" + AllTrim(cDigProt) + "'"
	endif

	cQuery += " ORDER BY PLANO, PROTOCOLO"

Else
	
	If nOrdem == 1
		cOrdem := "PLANO+MATRICULA "+c_ent
	Else
		cOrdem := "PLANO+PROTOCOLO "+c_ent
	Endif

	cQuery := " SELECT ZZQ_SEQUEN       PROTOCOLO,																			" + c_ent
	cQuery += " 	TRIM(A1_NOME)    NOME,																					" + c_ent
	cQuery += " 	A1_CGC           CGC,																					" + c_ent
	cQuery += " 	CASE WHEN ZZQ_XTPRGT = '2'  THEN 'SIM' ELSE 'NAO' END CHEQUE,											" + c_ent
	cQuery += " 	CASE WHEN ZZQ_XTPRGT <> '1' THEN ' ' WHEN ZZQ_DBANCA <> ' ' THEN ZZQ_XBANCO ELSE A1_XBANCO END BANCO,	" + c_ent
	cQuery += " 	CASE WHEN ZZQ_XTPRGT <> '1' THEN ' ' WHEN ZZQ_DBANCA <> ' ' THEN ZZQ_XAGENC ELSE A1_XAGENC END AGENCIA,	" + c_ent
	cQuery += " 	CASE WHEN ZZQ_XTPRGT <> '1' THEN ' ' WHEN ZZQ_DBANCA <> ' ' THEN ZZQ_XCONTA ELSE A1_XCONTA END CONTA,	" + c_ent
	cQuery += " 	CASE WHEN ZZQ_XTPRGT <> '1' THEN ' ' WHEN ZZQ_DBANCA <> ' ' THEN ZZQ_XDGCON ELSE A1_XDGCON END DIGITO,	" + c_ent
	cQuery += " 	ZZQ_DATDIG       DAT_DIG,																				" + c_ent
	cQuery += " 	CASE WHEN E1_VENCREA <> ' ' THEN E1_VENCREA ELSE ZZQ_DATPRE END DAT_PREV,"
	cQuery += " 	ZZQ_VLRTOT       VL_PAGO,"
	cQuery += " 	B44_VLRPAG       VALOR,"
	cQuery += " 	TRIM(B44_YUSSIS) DIGITADOR,"
	cQuery += " 	B44_PREFIX||B44_NUM||B44_PARCEL||B44_TIPO B44CHVSE1,"
	cQuery += " 	ZZQ_CPFEXE       CPFEXE,"
	cQuery += " 	ZZQ_REGEXE       REGEXE,"
	cQuery += " 	ZZQ_SIGEXE       SIGEXE,"
	cQuery += " 	ZZQ_ESTEXE       ESTEXE,"
	cQuery += " 	TRIM(ZZQ_NOMEXE) NOMEXE,"
	cQuery +=		 iif(lPgto, "", " ' '") + " E2_BAIXA,"
	cQuery +=		 iif(lPgto, " E2_VALOR,", "")
	cQuery +=		 " FORMATA_MATRICULA_MS(TRIM(ZZQ_CODBEN)) FMATRIC,"
	cQuery +=		 " TRIM(PCA_DESCRI) PORTA_ENTRADA,"
	cQuery +=		 " DECODE(ZZQ_TPSOL,'1','SOLIC. REEMBOLSO','2','SOLIC. ESPECIAL') TIPO_REEMBOLSO,"
	cQuery +=		 " TRIM(PCB_DESCRI) CANAL,"
	cQuery +=		 " BA1_CODINT       OPERADORA,"
	cQuery +=		 " BA1_CODEMP       EMPRESA,"
	cQuery +=		 " BA1_MATRIC       MATRICULA,"
	cQuery +=		 " BA1_TIPREG       TIPO,"
	cQuery +=		 " BA1_NOMUSR       USUARIO,"
	cQuery +=		 " BA1_CODPLA       PLANO,"
	cQuery +=		 " BA1_VERSAO       VERSAO,"
	cQuery +=		 " CASE WHEN bow_xdteve IS NULL THEN bow_xdteve ELSE SUBSTR(bow_xdteve, 7,2)||'/'||SUBSTR(bow_xdteve, 5,2)||'/'||SUBSTR(bow_xdteve, 1,4) END DATA_EVENTO"
	cQuery += " FROM " + 	RetSqlName("ZZQ") + " ZZQ"
	cQuery += "		LEFT JOIN " + 	RetSqlName("BOW") + " BOW ON (BOW_FILIAL = ZZQ_FILIAL AND BOW_YCDPTC = ZZQ_SEQUEN AND BOW.D_E_L_E_T_ = ' ') "
	cQuery +=	" INNER JOIN " + RetSqlName("B44") + " B44"
	cQuery +=	  " ON (    B44_FILIAL = ZZQ_FILIAL"
	cQuery +=		  " AND B44_YCDPTC = ZZQ_SEQUEN)"
	cQuery +=	" INNER JOIN " + RetSqlName("SA1") + " SA1"
	cQuery +=	  " ON (    A1_FILIAL = '" + xFilial("SA1") + "'"
	cQuery +=		  " AND A1_COD    = ZZQ_CODCLI"
	cQuery +=		  " AND A1_LOJA   = ZZQ_LOJCLI)"
	cQuery +=	" INNER JOIN " + RetSqlName("BA1") + " BA1"
	cQuery +=	  " ON (    BA1_FILIAL = '" + xFilial("BA1") + "'"
	cQuery +=		  " AND BA1_CODINT = SUBSTR(ZZQ_CODBEN, 1,4)"
	cQuery +=		  " AND BA1_CODEMP = SUBSTR(ZZQ_CODBEN, 5,4)"
	cQuery +=		  " AND BA1_MATRIC = SUBSTR(ZZQ_CODBEN, 9,6)"
	cQuery +=		  " AND BA1_TIPREG = SUBSTR(ZZQ_CODBEN,15,2)"
	cQuery +=		  " AND BA1_DIGITO = SUBSTR(ZZQ_CODBEN,17,1))"
	cQuery +=	" LEFT JOIN PCA010 PCA"
	cQuery +=	  " ON (    PCA.D_E_L_E_T_ = ' '"
	cQuery +=		  " AND PCA_FILIAL = '" + xFilial("PCA") + "'"
	cQuery +=		  " AND PCA_COD    = ZZQ_XWEB)"
	cQuery +=	" LEFT JOIN PCB010 PCB"
	cQuery +=	  " ON (    PCB.D_E_L_E_T_ = ' '"
	cQuery +=		  " AND PCB_FILIAL = '" + xFilial("PCB") + "'"
	cQuery +=		  " AND PCB_COD    = ZZQ_CANAL)"
	cQuery +=	" LEFT JOIN " + RetSqlName("SE1") + " SE1"
	cQuery +=	  " ON (    SE1.D_E_L_E_T_ = ' '"
	cQuery +=		  " AND E1_FILIAL  = '" + xFilial("SE1") + "'"
	cQuery +=		  " AND	E1_PREFIXO = B44_PREFIX"
	cQuery +=		  " AND	E1_NUM     = B44_NUM"
	cQuery +=		  " AND	E1_PARCELA = B44_PARCEL"
	cQuery +=		  " AND	E1_TIPO    = B44_TIPO)"

	if lPgto

		cQuery +=	" LEFT JOIN " + RetSqlName("SE2") + " SE2"
		cQuery +=	  " ON (    SE2.D_E_L_E_T_ = ' '"
		cQuery +=		  " AND E2_FILIAL  = '" + xFilial("SE2") + "'"
		cQuery +=		  " AND (   E2_TITORIG = B44_PREFIX||B44_NUM||B44_PARCEL||B44_TIPO"
		cQuery +=			   " OR (SUBSTR(E2_TITORIG,1,3)||'000'||SUBSTR(E2_TITORIG,4,10) = B44_PREFIX||B44_NUM||B44_PARCEL||B44_TIPO)"
		cQuery +=			   " OR (SUBSTR(E2_TITORIG,1,9)||'   '||SUBSTR(E2_TITORIG,10,4) = B44_PREFIX||B44_NUM||B44_PARCEL||B44_TIPO))"
		cQuery +=		  " AND E2_SALDO = 0"

		if Upper(cSituaca) == 'PGTO ELETRONICO'
			cQuery += " AND E2_NUMBOR <> ' '"
		elseif Upper(cSituaca) == 'MANUAIS'
			cQuery += " AND (E2_NUMBCO <> ' ' OR E2_NUMBOR <> ' ')"
			cQuery += " AND E2_BAIXA = ' '"
		endif

		if !empty(dPgtoFim)
			cQuery += " AND E2_BAIXA BETWEEN '" + DtoS(dPgtoIni) + "' AND '" + DtoS(dPgtoFim) + "'"
		endif

		cQuery += " )"
	
	endif

	cQuery += " WHERE ZZQ.D_E_L_E_T_ = ' ' AND B44.D_E_L_E_T_ = ' ' AND SA1.D_E_L_E_T_ = ' ' AND BA1.D_E_L_E_T_ = ' '"
	cQuery +=	" AND ZZQ_FILIAL  = '" + xFilial("ZZQ") + "'"

	if !empty(cModPgto)

		if cModPgto == '01'						// Credito em Conta Corrente

			cQuery += " AND (CASE WHEN B44_XBANCO <> ' ' THEN B44_XBANCO ELSE A1_XBANCO END) = '341'"
		
		elseif cModPgto == '03'					// DOC

			cQuery += " AND (CASE WHEN B44_XBANCO <> ' ' THEN B44_XBANCO ELSE A1_XBANCO END) <> '341'"
			cQuery += " AND (E1_VALOR < 5000 AND B44_XBANCO NOT IN ('" + cBancoDig + "'))"
		
		elseif cModPgto $ '41'					// TED

			cQuery += " AND (CASE WHEN B44_XBANCO <> ' ' THEN B44_XBANCO ELSE A1_XBANCO END) <> '341'"
			cQuery += " AND (E1_VALOR >= 5000 OR B44_XBANCO IN ('" + cBancoDig + "'))"
		
		endif
	
	endif

	if cPrefixo == 'RLE'
		cQuery += " AND NOT(ZZQ_TPSOL = '1' AND ZZQ_TIPPRO = '4')"		// Demais reembolsos
	elseif cPrefixo == 'AXF'
		cQuery += " AND ZZQ_TPSOL = '1' AND ZZQ_TIPPRO = '4'"			// Auxilio Funeral
	endif

	if !empty(dDataFim)
		cQuery += " AND B44_DTDIGI BETWEEN '" + DtoS(dDataIni) + "' AND '" + DtoS(dDataFim) + "'"
	endif

	if !Empty(dPrevFim)
		cQuery += " AND E1_VENCREA BETWEEN '" + DtoS(dPrevIni) + "' AND '" + DtoS(dPrevFim) + "'"
	endif

	if Upper(cSituaca) == "CALCULADO"
		cQuery += " AND B44_YSITUA = '1'"
	else
		cQuery += " AND B44_YSITUA = '2'"
	endif

	cQuery += " ORDER BY PLANO, PROTOCOLO"

endif

if Select(cAlias) > 0
	DbSelectArea(cAlias)
	(cAlias)->(DbCloseArea())
endif

DbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAlias,.T.,.T.)

fImprime(cAlias)

return



//**********************************************************************//
// Função para a impressao do relatório									//
//**********************************************************************//
Static Function fImprime(cAlias)

Local aDados := {}

DbSelectArea(cAlias)
(cAlias)->(DbGoTop())

nVlTotPd2	:= 0
nVlTotRe2	:= 0
nTotQtd		:= 0
cNomeArq	:= ' '
CMONTATXT	:= ' '
nHandle		:= 0
aCabec		:= {}

if !Empty(dDataIni) .and. !Empty(dDataFim)
	Cabec1 += Transform(dDataIni,"@e") + "  Ate  " + Transform(dDataFim,"@e")
elseif !Empty(dPgtoIni) .And. !Empty(dPgtoFim)
	Cabec1  += Transform(dPgtoIni,"@e") + "  Ate  " + Transform(dPgtoFim,"@e")
else
	Cabec1 += Transform(dPrevIni,"@e") + "  Ate  " + Transform(dPrevFim,"@e")
endif

Cabec1 += Iif(Empty(cModPgto),"","  -  M O T I V O: "+cModPgto)

While !eof()

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Impressao do cabecalho do relatorio. . .                            ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

	If nLin > 55 // Salto de Página. Neste caso o formulario tem 55 linhas...
		Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
		nLin := 8
	Endif

	If lAbortPrint
		@nLin,00 PSAY "*** CANCELADO PELO OPERADOR ***"
	Endif

	// NOME DO PLANO
	cCodInt		:= (cAlias)->OPERADORA
	cCodPlan	:= (cAlias)->PLANO
	cVerPlan	:= (cAlias)->VERSAO
	
	BI3->(DbSetOrder(1))
	BI3->(MsSeek(xFilial("BI3")+cCodInt+cCodPlan+cVerPlan))

	cNomePlan	:= BI3->BI3_NREDUZ
	cMatPlan	:= Alltrim((cAlias)->MATRICULA) + "  " + Alltrim(cNomePlan)

	@ nLin,000 pSay __PrtLeft(" P L A N O  : " +cCodPlan + " - " + cNomePlan )
	nLin++
	@ nLin, 000 PSAY __PrtFatLine()
	nLin++
	@ nLin, 000 PSAY cCabRel
	nLin++
	@ nLin, 000 PSAY __PrtFatLine()
	nLin++

	nTotPl		:= 0
	nVlTotPd	:= 0
	nVlTotRe	:= 0
	dDataBx		:= cTod("  /  /    ")
	cDocumen	:= Space(20)

	while !Eof() .And. (cAlias)->Plano == cCodPlan

		if nLin > 55	// Salto de Página. Neste caso o formulario tem 55 linhas

			Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
			nLin := 8

			@ nLin,000 pSay __PrtLeft(" P L A N O  : " +cCodPlan + " - " + cNomePlan )
			nLin++
			@ nLin, 000 PSAY __PrtFatLine()
			nLin++
			@ nLin, 000 PSAY cCabRel
			nLin++
			@ nLin, 000 PSAY __PrtFatLine()
			nLin++

			aCabec		:=  {"Protocolo","Cliente","Matricula","Nome Beneficiário","CPF","Banco","Agencia","Conta","Data Pedido","Data Previsao","Data Pgto","Documento","Vlr Pedido","Vlr Reembolso","Digitador Prot.","Porta de Entrada", "Tipo Reembolso", "Canal","Cheque", "Data Evento"}
			cNomeArq	:= "C:\TEMP\Relatorio_"+SubStr(DtoS(date()),7,2)+"_"+SubStr(DtoS(date()),5,2)+"_"+SubStr(DtoS(date()),1,4)+"_"+STRTRAN(TIME(),":","_")+".csv"
			nHandle		:= FCREATE(cNomeArq)

			if !ApOleClient("MSExcel")

				if nHandle > 0

					cMontaTxt := "Protocolo;"
					cMontaTxt += "Cliente;"
					cMontaTxt += "Matricula;"
					cMontaTxt += "Nome Beneficiario;"
					cMontaTxt += "CPF;"
					cMontaTxt += "Banco;"
					cMontaTxt += "Agencia;"
					cMontaTxt += "Conta;"
					cMontaTxt += "Data Pedido;"
					cMontaTxt += "Data Previsao;"
					cMontaTxt += "Data Pgto;"
					cMontaTxt += "Documento;"
					cMontaTxt += "Vlr Pedido;"
					cMontaTxt += "Vlr Reembolso;"
					cMontaTxt += "Digitador Prot.;"
					cMontaTxt += "Porta de Entrada;"
					cMontaTxt += "Tipo Reembolso;"
					cMontaTxt += "Canal;"
					cMontaTxt += "Cheque"
					cMontaTxt += "Data Evento"
					cMontaTxt += CRLF

					FWrite(nHandle,cMontaTxt)
				
				endif
			
			endIf
		
		endif

		nVl_Pedido	:= (cAlias)->VL_PAGO
		cDocumen	:= (cAlias)->B44CHVSE1

		if lPgto
			nVl_reebolso	:= (cAlias)->E2_VALOR
			dDataBx			:= Stod((cAlias)->E2_BAIXA)
		else
			nVl_reebolso	:= (cAlias)->VALOR
			dDataBx			:= "  /  /  "
		endif

		@ nLin,000 PSAY (cAlias)->PROTOCOLO
		@ nLin,010 PSAY Substr((cAlias)->NOME,1,30)
		@ nLin,045 PSAY substr((cAlias)->CGC,1,14)
		@ nLin,060 PSAY (cAlias)->BANCO
		@ nLin,070 PSAY (cAlias)->AGENCIA
		@ nLin,080 PSAY Substr((cAlias)->CONTA,1,10)+'-'+(cAlias)->DIGITO 
		@ nLin,93 PSAY Stod(Alltrim((cAlias)->DAT_DIG ))
		@ nLin,105 PSAY Stod(Alltrim((cAlias)->DAT_PREV))
		@ nLin,120 PSAY dDataBx
		@ nLin,135 PSAY cDocumen
		@ nLin,150 PSAY Padl(Transform(nVl_Pedido   ,"@E 999,999,999.99"),15)
		@ nLin,165 PSAY Padl(Transform(nVl_reebolso ,"@E 999,999,999.99"),15)
		@ nLin,183 PSAY (cAlias)->DIGITADOR
		@ nLin,203 PSAY (cAlias)->CHEQUE
		@ nLin,208 PSAY (cAlias)->DATA_EVENTO

		aAdd(aDados, {	(cAlias)->PROTOCOLO										,;
						Substr((cAlias)->NOME,1,30)								,;
						(cAlias)->FMATRIC										,;
						Substr((cAlias)->USUARIO,1,30)							,;
						Substr((cAlias)->CGC,1,14)								,;
						(cAlias)->BANCO											,;
						(cAlias)->AGENCIA										,;
						Substr((cAlias)->CONTA,1,10)+'-'+(cAlias)->DIGITO		,;
						Stod(Alltrim((cAlias)->DAT_DIG))						,;
						Stod(Alltrim((cAlias)->DAT_PREV))						,;
						dDataBx													,;
						cDocumen												,;
						Padl(Transform(nVl_Pedido,   "@E 999,999,999.99"), 15)	,;
						Padl(Transform(nVl_reebolso, "@E 999,999,999.99"), 15)	,;
						(cAlias)->DIGITADOR										,;
						(cAlias)->PORTA_ENTRADA									,;
						(cAlias)->TIPO_REEMBOLSO								,;
						(cAlias)->CANAL											,;
						(cAlias)->CHEQUE										,;
						(cAlias)->DATA_EVENTO									})
		
		if !ApOleClient("MSExcel")

			if nHandle > 0

				cMontaTxt := (cAlias)->PROTOCOLO										+ ";"
				cMontaTxt += Substr((cAlias)->NOME,1,30)								+ ";"
				cMontaTxt += (cAlias)->FMATRIC											+ ";"
				cMontaTxt +=  Substr((cAlias)->USUARIO,1,30)							+ ";"
				cMontaTxt += substr((cAlias)->CGC,1,14)									+ ";"
				cMontaTxt += (cAlias)->BANCO											+ ";"
				cMontaTxt += (cAlias)->AGENCIA											+ ";"
				cMontaTxt += Substr((cAlias)->CONTA,1,10)								+ ";"
				cMontaTxt += Alltrim((cAlias)->DAT_DIG )								+ ";"
				cMontaTxt += Alltrim((cAlias)->DAT_PREV)								+ ";"
				cMontaTxt += DTOS(dDataBx)												+ ";"
				cMontaTxt += cDocumen													+ ";"
				cMontaTxt += Padl(Transform(nVl_Pedido   ,"@E 999,999,999.99"),15)		+ ";"
				cMontaTxt += Padl(Transform(nVl_reebolso ,"@E 999,999,999.99"),15)		+ ";"
				cMontaTxt += (cAlias)->DIGITADOR										+ ";"
				cMontaTxt += (cAlias)->PORTA_ENTRADA									+ ";"
				cMontaTxt += (cAlias)->TIPO_REEMBOLSO									+ ";"
				cMontaTxt += (cAlias)->CANAL											+ ";"
				cMontaTxt += (cAlias)->CHEQUE											+ ";"
				cMontaTxt += (cAlias)->DATA_EVENTO										+ CRLF

				FWrite(nHandle,cMontaTxt)
			
			endif
		
		endif

		if ctprel == 'C/Compl' .and. Upper(cSituaca) $ ("PROTOCOLADO|CANCELADO")

			nLin++
			@ nLin,000 PSAY (cAlias)->operadora + '.' + (cAlias)->empresa + '.' + (cAlias)->matricula + '-' + (cAlias)->tipo + ' - ' + (cAlias)->usuario
			nLin++
			@ nLin,000 PSAY ' Nome Exec.: ' + (cAlias)->nomexe + ' Cpf Exec.: ' + (cAlias)->cpfexe + ' Cr Exec.: ' + (cAlias)->regexe + ' Sigla Exec.: ' + (cAlias)->sigexe + ' Est. Exec.: ' + (cAlias)->estexe
		
		endif
		nLin++

		// TOTAIS DO PLANO
		nTotPl++
		nVlTotPd += nVl_Pedido
		nVlTotRe += nVl_reebolso

		// TOTAIS DO RELATORIO
		nTotQtd++
		nVlTotPd2 += nVl_Pedido
		nVlTotRe2 += nVl_reebolso

		dbSelectArea(cAlias)
		(cAlias)->(dbSkip())
	end

	@ nLin, 000 PSAY __PrtFatLine()
	nLin += 1
	@ nLin,000 pSay "Total de pedidos do Plano : " + StrZero(nTotPl,6)
	@ nLin,150 PSAY Padl(Transform(nVlTotPd ,"@E 999,999,999.99"),15)
	@ nLin,165 pSay Padl(Transform(nVlTotRe ,"@E 999,999,999.99"),15)

	nLin += 2
end

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Gera excel                        							        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ     
if MsgYesNo("Gerar Planilha?")

	if ApOleClient("MSExcel")

		aCabec :=  {"Protocolo","Cliente","Matricula","Nome Beneficiário","CPF","Banco","Agencia","Conta","Data Pedido","Data Previsao","Data Pgto","Documento","Vlr Pedido","Vlr Reembolso","Digitador Prot.","Porta de Entrada", "Tipo Reembolso", "Canal","Cheque", "Data Evento"}
		DlgToExcel({{"ARRAY",titulo,aCabec,aDados}})
	
	elseif nHandle > 0

		FClose(nHandle)
		MsgInfo("Relatorio salvo em: " + cNomeArq)
	endif

endif

@ nLin, 000 PSAY __PrtFatLine()
nLin++
@ nLin,000 pSay "Total Geral dos pedidos   : " + StrZero(nTotQtd,6)
@ nLin,150 PSAY Padl(Transform(nVlTotPd2 ,"@E 999,999,999.99"),15)
@ nLin,165 pSay Padl(Transform(nVlTotRe2 ,"@E 999,999,999.99"),15)

nLin+=2

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Finaliza a execucao do relatorio...                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
SET DEVICE TO SCREEN

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Se impressao em disco, chama o gerenciador de impressao...          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
if aReturn[5] == 1
	dbCommitAll()
	SET PRINTER TO
	OurSpool(wnrel)
endif

MS_FLUSH()

return
