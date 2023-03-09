#Include "Protheus.ch"
#Include "Rwmake.ch"
#Include "Topconn.ch"

#Define _LF Chr(13)+Chr(10) // Quebra de linha.
#Define _BL 50

#include "PLSMGER.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±±
±±³Funcao    ³ CABR060 ³ Autor ³ Gedilson Rangel        ³ Data ³ 24.06.09 ³±±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±±
±±³Descricao ³ Relatório de clientes devedores com mais de 60 dias.       ³±±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define nome da funcao...                                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
User Function CABR997()
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define variavaoeis...                                                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
PRIVATE nQtdLin 	:= 58  //LINHAS VERTICAIS
PRIVATE cNomeProg   := "CABR999" //NOME PADRAO AO IMPRIMIR
PRIVATE nCaracter   := 15
PRIVATE nLimite     := 220
PRIVATE cTamanho    := "G"
PRIVATE cTitulo     := "Relatorio Faturamento Associado Por Familia"
PRIVATE cDesc1      := ""
PRIVATE cDesc2      := ""
PRIVATE cDesc3      := ""
PRIVATE cCabec1     := "Empresa       Cont/Sub      Matricula             Nome                                                       Serviço                                                                                              Valor    "
PRIVATE cCabec2     := "                              Prestador                                    Procedimento       Data Proc            Descrição Procedimento                                                            Valor PF              "
PRIVATE cAlias      := "BM1"
PRIVATE cPerg       := "CABR99"
PRIVATE cRel        := "CABR997"
PRIVATE nLi         := 01
PRIVATE m_pag       := 1
PRIVATE aReturn     := { "Zebrado", 1,"Administracao", 1, 1, 1, "",1 }
PRIVATE lAbortPrint := .F.
PRIVATE aOrdens     := {}
PRIVATE lDicion     := .F.
PRIVATE lCompres    := .F.
PRIVATE lCrystal    := .F.
PRIVATE lFiltro     := .T.
PRIVATE aOutLanc	:= {}

/*
0         10        20        30        40        50        60        70        80        90        100       110       120       130       140       150       160       170       180       190       200       210       220       230
012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
"Empresa       Cont/Sub    Matricula             Nome                                                         Serviço                                                                                              Valor    "
012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890

0         10        20        30        40        50        60        70        80        90        100       110       120       130       140       150       160       170       180       190       200       210       220       230
012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
"                              Prestador                                    Procedimento       Data Proc            Descrição Procedimento                                                            Valor PF              "
012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
*/
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Chama SetPrint                                                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
CriaSX1(cPerg)
cRel := SetPrint(cAlias,cRel,cPerg,@cTitulo,cDesc1,cDesc2,cDesc3,lDicion,aOrdens,lCompres,cTamanho,{},lFiltro,lCrystal)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica se foi cancelada a operacao                                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If nLastKey  == 27
	Return
Endif
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Recebe parametros                                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Pergunte(cPerg,.F.)

cCodInt    		:= mv_par01
cCodempD	   	:= mv_par02
cCodempA	   	:= mv_par03
cMatricD    	:= mv_par04
cMatricA    	:= mv_par05
cTipRegD		:= mv_par06
cTipRegA		:= mv_par07
cLoteCob		:= mv_par08 //Procedimento executado
cMesBase		:= mv_par09 //Mes base da cobrança
cAnoBase		:= mv_par10 //Ano base da cobrança
cTipImpr		:= mv_par11 //Analitico ou sintetico
cCoPart			:= mv_par12 //Demonstra Co-Participação
cQuebra			:= mv_par13 //Quebra de pagina

cTitulo := AllTrim(cTitulo)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Configura Impressora                                                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
SetDefault(aReturn,cAlias)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta RptStatus...                                                       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Processa({|| ImpRel(cPerg)},cTitulo)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Fim da Rotina Principal...                                               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±±
±±³Funcao    ³ ImpRel  ³ Autor ³ Romulo Ferrari         ³ Data ³ 17.06.09 ³±±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±±
±±³Descricao ³ Relatório de custo por internação sem honorários Médicos   ³±±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define nome da funcao                                                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Static Function ImpRel()
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis do IndRegua...                                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
LOCAL i
LOCAL n
LOCAL _cEmpRel := Iif(Substr(cNumEmp,1,2)=="01",'C','I')
LOCAL nQtd		:= 0
LOCAL cContra	:= ""
LOCAL cSubcon	:= ""
LOCAL cCodInt 	:= ""
LOCAL cCodEmp 	:= ""
LOCAL cMatric	:= ""
LOCAL cTipReg	:= ""
LOCAL cContra	:= ""
LOCAL cSubCon	:= ""
LOCAL cTotUsr	:= 0
LOCAL cTotFam	:= 0
LOCAL cTotSub	:= 0
LOCAL cTotCon	:= 0
LOCAL cTotEmp	:= 0
LOCAL cTotGer	:= 0
LOCAL nImpSub 	:= 0
LOCAL cSubImpr	:= " "
LOCAL cImpMat   := "1"
Local _nCount	:= 0

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta Expressao de filtro...                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

cQuery := " SELECT BM1.BM1_CONEMP, BM1.BM1_VERCON,BM1.BM1_SUBCON, BM1.BM1_VERSUB, BG9.BG9_CODIGO, BG9.BG9_NREDUZ, BQC_DESCRI, BM1.BM1_CODINT, "
cQuery += " BM1.BM1_CODEMP, BM1.BM1_MATRIC, BM1.BM1_TIPREG,BM1.BM1_DIGITO, BFQ.BFQ_YTPANL, BM1.BM1_CODTIP, BM1.BM1_DESTIP, BM1.BM1_TIPUSU, "
cQuery += " BM1.BM1_TIPO, BM1.BM1_PLNUCO, BM1.BM1_NOMUSR,BM1.BM1_NIVCOB, BM1.BM1_ORIGEM, SUM(BM1.BM1_VALOR) BM1_VALOR "
cQuery += " FROM "+RetSQLName("BM1")+" BM1, "+RetSQLName("BFQ")+" BFQ, "+RetSQLName("BQC")+" BQC, "+RetSQLName("BG9")+" BG9 "
cQuery += " WHERE BM1_FILIAL = '"+xFilial("BM1")+"' "
cQuery += " AND BFQ.BFQ_FILIAL = '"+xFilial("BFQ")+"' "
cQuery += " AND BQC.BQC_FILIAL = '"+xFilial("BQC")+"' "
cQuery += " AND BG9.BG9_FILIAL = '"+xFilial("BG9")+"' "
cQuery += " AND BM1.BM1_CODINT = BFQ.BFQ_CODINT "
cQuery += " AND BM1.BM1_CODTIP = BFQ_PROPRI+BFQ_CODLAN "
If cCoPart == 1
cQuery += " AND BFQ.BFQ_YTPANL = 'C' "                  
Endif
cQuery += " AND BM1_CODINT = BQC_CODINT "
cQuery += " AND BM1_CODEMP = BQC_CODEMP "
cQuery += " AND BM1_CONEMP = BQC_NUMCON "
cQuery += " AND BM1_VERCON = BQC_VERCON "
cQuery += " AND BM1_SUBCON = BQC_SUBCON "
cQuery += " AND BM1_VERSUB = BQC_VERSUB "
cQuery += " AND BM1_CODINT = BG9_CODINT "
cQuery += " AND BM1_CODEMP = BG9_CODIGO "
cQuery += " AND BM1.BM1_CODINT = '"+mv_par01+"'"
cQuery += " AND BM1.BM1_CODEMP >= '"+mv_par02+"'"
cQuery += " AND BM1.BM1_CODEMP <= '"+mv_par03+"'"
cQuery += " AND BM1.BM1_MATRIC >= '"+mv_par04+"'"
cQuery += " AND BM1.BM1_MATRIC <= '"+mv_par05+"'"
cQuery += " AND BM1.BM1_TIPREG >= '"+mv_par06+"'"
cQuery += " AND BM1.BM1_TIPREG <= '"+mv_par07+"'"

If ! Empty(cLoteCob)
	cQuery += " AND BM1.BM1_PLNUCO = '"+mv_par08+"'"
Else
	cQuery += " AND BM1.BM1_PLNUCO <> ' '
EndIf 
cQuery += " AND BM1.BM1_MES = '"+mv_par09+"'"
cQuery += " AND BM1.BM1_ANO = '"+mv_par10+"'"
cQuery += " AND BFQ.D_E_L_E_T_ = ' '
cQuery += " AND BM1.D_E_L_E_T_ = ' '
cQuery += " AND BQC.D_E_L_E_T_ = ' '
cQuery += " AND BG9.D_E_L_E_T_ = ' '
cQuery += " GROUP BY BG9.BG9_CODIGO,BM1.BM1_CONEMP, BM1.BM1_VERCON,BM1.BM1_SUBCON, BM1.BM1_VERSUB, BM1_CODTIP, BM1.BM1_DESTIP, BG9.BG9_NREDUZ, "
cQuery += " BQC_DESCRI,  BM1.BM1_CODINT, BM1.BM1_CODEMP, BM1.BM1_MATRIC, BM1.BM1_TIPREG,BM1.BM1_DIGITO, BFQ.BFQ_YTPANL,  BM1.BM1_TIPUSU, BM1.BM1_TIPO, "
cQuery += " BM1.BM1_PLNUCO, BM1.BM1_NOMUSR,BM1.BM1_NIVCOB, BM1.BM1_ORIGEM "
cQuery += " ORDER BY BM1.BM1_CONEMP, BM1.BM1_SUBCON, BM1.BM1_CODINT, BM1.BM1_CODEMP, BM1.BM1_MATRIC, BM1.BM1_TIPREG, BM1.BM1_DIGITO "

//=================================================
//PARTE DA PROGRAMACAO

//memowrite("C:\CABR123.TXT",cQuery) Gera um arquivo texto no diretorio especificado

PlsQuery(cQuery, "TRBBM1")
DbSelectArea("TRBBM1")
nQtd:=0
TRBBM1->(DBEval( { | | nQtd ++ }))
ProcRegua(nQtd)

TRBBM1->(DbGoTop())
nLi := 500

If mv_par13 = 1
	
	U_Cb997Graf()  //chama a funcao de impressão grafica
	
Else
	
	While ! TRBBM1->(Eof())
		cCodEmp := TRBBM1->BM1_CODEMP
		cContra := TRBBM1->BM1_CONEMP
		cSubCon := TRBBM1->BM1_SUBCON
		cMatric	:= TRBBM1->BM1_MATRIC
		cTipreg := TRBBM1->BM1_TIPREG
		nImpSub := 0
		cSubImp := TRBBM1->(BM1_CONEMP+BM1_SUBCON)
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Apresenta mensagem em tela...                                            ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		IncProc( "Processando...")
		
		If mv_par11	== 1 //Relatorio analitico
			nLi := Cabec(cTitulo,cCabec1,cCabec2,cNomeProg,cTamanho,nCaracter)
			While TRBBM1->(BM1_CODEMP) == cCodEmp .AND. !TRBBM1->(Eof())
				@ nLi, 010 Psay Trim(TRBBM1->BG9_CODIGO)
				@ nLi, 014 Psay "-"
				@ nLi, 015 Psay Trim(TRBBM1->BG9_NREDUZ)
				nLi ++
				cContra := TRBBM1->(BM1_CONEMP)
				While TRBBM1->BM1_CODEMP == cCodEmp .AND. TRBBM1->(BM1_CONEMP) == cContra .AND. !TRBBM1->(Eof())
					@ nLi, 015 Psay Trim(TRBBM1->BM1_CONEMP)+"."
					cSubCon := TRBBM1->(BM1_SUBCON)
					nImpSub := 0
					While TRBBM1->BM1_CODEMP == cCodEmp .AND. TRBBM1->(BM1_CONEMP) == cContra .AND.;
						TRBBM1->(BM1_SUBCON) == cSubCon .AND. !TRBBM1->(Eof())
						If nLi >= nQtdLin
							U_Cb997ImpRP()
						EndIf
						If nImpSub = 0
							@ nLi, 028 Psay Trim(TRBBM1->BM1_SUBCON)
							@ nLi, 037 Psay "-"
							@ nLi, 038 Psay Trim(TRBBM1->BQC_DESCRI)
							nLi ++
							cSubImpr := TRBBM1->(BM1_CONEMP+BM1_SUBCON)
							nImpSub := 1
						Endif
						cMatric	:= TRBBM1->BM1_MATRIC
						
						While TRBBM1->BM1_CODEMP == cCodEmp .AND.;
							TRBBM1->(BM1_CONEMP) == cContra .AND.;
							TRBBM1->(BM1_SUBCON) == cSubCon .AND.;
							TRBBM1->(BM1_MATRIC) == cMatric .AND. !TRBBM1->(Eof())
							If Empty(TRBBM1->(BM1_MATRIC))
								AADD(aOutLanc,{TRBBM1->BM1_NIVCOB,TRBBM1->BM1_TIPO,TRBBM1->BM1_DESTIP,TRBBM1->BM1_ORIGEM,TRBBM1->BM1_CONEMP,TRBBM1->BM1_SUBCON,TRBBM1->BM1_VALOR})
								TRBBM1->(dbSkip())
								cMatric	:= TRBBM1->BM1_MATRIC
								nImpSub := 0
								cSubImp := TRBBM1->(BM1_CONEMP+BM1_SUBCON)
							EndIf
							cTipreg := TRBBM1->BM1_TIPREG
							While TRBBM1->BM1_CODEMP == cCodEmp .AND.;
								TRBBM1->(BM1_CONEMP) == cContra .AND.;
								TRBBM1->(BM1_SUBCON) == cSubCon .AND.;
								TRBBM1->(BM1_MATRIC) == cMatric .AND.;
								TRBBM1->(BM1_TIPREG) == cTipReg .AND. !TRBBM1->(Eof())
								If nLi >= nQtdLin
									U_Cb997ImpRP()
								EndIf
								If  cImpMat = '1'
									@ nLi, 027 Psay TRBBM1->BM1_CODINT
									@ nLi, 031 Psay "."
									@ nLi, 032 Psay TRBBM1->BM1_CODEMP
									@ nLi, 036 Psay "."
									@ nLi, 037 Psay TRBBM1->BM1_MATRIC
									@ nLi, 043 Psay "."
									@ nLi, 044 Psay TRBBM1->BM1_TIPREG
									@ nLi, 049 Psay Trim(TRBBM1->BM1_NOMUSR)
									cImpMat := '2'
								EndIf
								If TRBBM1->BM1_TIPO == '2'
									cTotUsr := (cTotUsr - TRBBM1->(BM1_VALOR))
									@ nLi, 110 Psay TRBBM1->BM1_DESTIP
									@ nLi, 200 Psay Transform((TRBBM1->BM1_VALOR),"@E 999,999,999.99")
									nLi++
								Else
									cTotUsr := (cTotUsr + TRBBM1->(BM1_VALOR))
									@ nLi, 110 Psay TRBBM1->BM1_DESTIP
									@ nLi, 200 Psay Transform((TRBBM1->BM1_VALOR),"@E 999,999,999.99")
									nLi++
								EndIf
								
								If TRBBM1->BFQ_YTPANL == 'C'
									cQuery := " SELECT BAU.BAU_NOME, BD6_CODLDP, BD6_CODPEG, BD6_NUMERO, BD6_SEQUEN, "
									cQuery += " BD6_CODPRO, BD6_DATPRO, BD6_DESPRO, BD6_VLRPF, BD6_DIGITO,BD6_SEQPF "
									cQuery += " FROM "+RetSQLName("BD6")+" BD6 , "+RetSQLName("BAU")+" BAU "
									cQuery += " WHERE BD6_FILIAL = '"+xFilial("BD6")+"' "
									cQuery += " AND BAU_FILIAL = '"+xFilial("BAU")+"' "
									cQuery += " AND BD6_CODRDA = BAU_CODIGO "
									cQuery += " AND BD6_OPEUSR = '"+TRBBM1->BM1_CODINT+"' "
									cQuery += " AND BD6_CODEMP = '"+TRBBM1->BM1_CODEMP+"' "
									cQuery += " AND BD6_MATRIC = '"+TRBBM1->BM1_MATRIC+"' "
									cQuery += " AND BD6_TIPREG = '"+TRBBM1->BM1_TIPREG+"' "
									cQuery += " AND BD6_DIGITO = '"+TRBBM1->BM1_DIGITO+"' "
									cQuery += " AND BD6_NUMFAT = '"+TRBBM1->BM1_PLNUCO+"' "
									cQuery += " AND BD6.D_E_L_E_T_ <> '*'
									
									PlsQuery(cQuery, "TRBBD6")
									DbSelectArea("TRBBD6")
									
									While ! TRBBD6->(Eof())
										If nLi >= nQtdLin
											U_Cb997ImpRP()
										EndIf
										@ nLi, 030 Psay TRBBD6->BAU_NOME
										@ nLi, 075 Psay TRIM(TRBBD6->BD6_CODPRO)
										@ nLi, 095 Psay TRBBD6->BD6_DATPRO
										@ nLi, 115 Psay SUBSTR(TRIM(TRBBD6->BD6_DESPRO),1,40)
										@ nLi, 157 Psay TRBBD6->BD6_CODLDP
										@ nLi, 162 Psay TRBBD6->BD6_CODPEG
										@ nLi, 171 Psay TRBBD6->BD6_NUMERO
										@ nLi, 180 Psay TRBBD6->BD6_SEQUEN
										@ nLi, 190 Psay Transform((TRBBD6->BD6_VLRPF),"@E 999,999,999.99")
										nLi ++
										TRBBD6->(dbSkip())
									EndDo
									DbCloseArea("TRBBD6")
								Endif
								TRBBM1->(dbSkip())
							EndDo
							nLi++
							If nLi >= nQtdLin
								U_Cb997ImpRP()
							EndIf
							@ nLi, 075 pSay ("Total do Usuario")+ (Replicate(".",100))
							@ nLi, 200 pSay Transform((cTotUsr),"@E 999,999,999.99")
							cTotFam += cTotUsr
							cTotUsr := 0
							cImpMat := '1'
							nLi++
						EndDo
						nLi++
						If nLi >= nQtdLin
							U_Cb997ImpRP()
						EndIf
						@ nLi, 075 pSay ("Total da Familia")+ (Replicate(".",100))
						@ nLi, 200 pSay Transform((cTotFam),"@E 999,999,999.99")
						cTotSub += cTotFam
						cTotFam := 0
						nLi += 2
					EndDo
					If nLi >= nQtdLin
						U_Cb997ImpRP()
					Else
						If Len(aOutLanc) > 0
							For _nCount := 1 To Len(aOutLanc)
								If (aOutLanc[_nCount][1]) == '3' .AND. (aOutLanc[_nCount][5]) == cContra .AND. (aOutLanc[_nCount][6]) == cSubCon
									@ nLi, 075 pSay ("OUTROS LANÇAMENTOS")
									nLi++
									
									If TRBBM1->BM1_TIPO == '2'
										cTotSub := (cTotSub - (aOutLanc[_nCount][7]))
										@ nLi, 085 Psay (aOutLanc[_nCount][3])
										@ nLi, 150 Psay (aOutLanc[_nCount][4])
										@ nLi, 200 Psay Transform((aOutLanc[_nCount][7]),"@E 999,999,999.99")
										nLi++
									Else
										cTotSub := (cTotSub + (aOutLanc[_nCount][7]))
										@ nLi, 085 Psay (aOutLanc[_nCount][3])
										@ nLi, 150 Psay (aOutLanc[_nCount][4])
										@ nLi, 200 Psay Transform((aOutLanc[_nCount][7]),"@E 999,999,999.99")
										nLi++
									EndIf
									_nCount += 1
								EndIf
							Next
						EndIf
						nLi += 2
						@ nLi, 015 pSay ("Total do SubContrato")
						@ nLi, 200 pSay Transform((cTotSub),"@E 999,999,999.99")
						cTotCon += cTotSub
						cTotSub := 0
						cSubCon := TRBBM1->BM1_SUBCON
						If cSubImp <> TRBBM1->(BM1_CONEMP+BM1_SUBCON)
							nImpSub := 0
						EndIf
						aOutLanc := {}
					Endif
					nLi += 2
				EndDo
				If nLi >= nQtdLin
					U_Cb997ImpRP()
				EndIf
				@ nLi, 015 pSay ("Total do Contrato")
				@ nLi, 200 pSay Transform((cTotCon),"@E 999,999,999.99")
				cTotEmp := cTotEmp + cTotCon
				cTotCon := 0
				nLi += 2
			EndDo
			If nLi >= nQtdLin
				U_Cb997ImpRP()
			EndIf
			cTotGer := cTotGer + cTotEmp
			@ nLi, 010 pSay ("Total Geral")
			@ nLi, 200 pSay Transform((cTotGer),"@E 999,999,999.99")
			Roda(0,Space(10))
		Else  //Relatório Sintético
			If mv_par11	== 2
				cCabec1 := "Empresa       Cont/Sub      Matricula             Nome                                                                                                         Valor    "
				nLi := Cabec(cTitulo,cCabec1,"",cNomeProg,cTamanho,nCaracter)
				While TRBBM1->(BM1_CODEMP) == cCodEmp .AND. !TRBBM1->(Eof())
					@ nLi, 010 Psay Trim(TRBBM1->BG9_CODIGO)
					@ nLi, 014 Psay "-"
					@ nLi, 015 Psay Trim(TRBBM1->BG9_NREDUZ)
					nLi ++
					cContra := TRBBM1->(BM1_CONEMP)
					While 	TRBBM1->BM1_CODEMP == cCodEmp .AND. ;
						TRBBM1->(BM1_CONEMP) == cContra .AND. ;
						!TRBBM1->(Eof())
						@ nLi, 015 Psay Trim(TRBBM1->BM1_CONEMP)+"."
						
						cSubCon := TRBBM1->BM1_SUBCON
						While	TRBBM1->(BM1_CODEMP) == cCodEmp .AND.;
							TRBBM1->(BM1_CONEMP) == cContra .AND. ;
							TRBBM1->(BM1_SUBCON) == cSubCon .AND. ;
							!TRBBM1->(Eof())
							If nImpSub = 0
								@ nLi, 028 Psay Trim(TRBBM1->BM1_SUBCON)
								@ nLi, 037 Psay "-"
								@ nLi, 038 Psay Trim(TRBBM1->BQC_DESCRI)
								nLi ++
								cSubImpr := TRBBM1->(BM1_CONEMP+BM1_SUBCON)
								nImpSub := 1
							Endif
							cMatric := TRBBM1->(BM1_MATRIC)
							
							While 	TRBBM1->BM1_CODEMP == cCodEmp .AND. ;
								TRBBM1->(BM1_CONEMP) == cContra .AND. ;
								TRBBM1->(BM1_SUBCON) == cSubCon .AND. ;
								TRBBM1->(BM1_MATRIC) == cMatric .AND. ;
								!TRBBM1->(Eof())
								If Empty(TRBBM1->(BM1_MATRIC))
									AADD(aOutLanc,{TRBBM1->BM1_NIVCOB,TRBBM1->BM1_TIPO,TRBBM1->BM1_DESTIP,TRBBM1->BM1_ORIGEM,TRBBM1->BM1_CONEMP,TRBBM1->BM1_SUBCON,TRBBM1->BM1_VALOR})
									TRBBM1->(dbSkip())
									cMatric	:= TRBBM1->BM1_MATRIC
									nImpSub := 0
									cSubImp := TRBBM1->(BM1_CONEMP+BM1_SUBCON)
								EndIf
								If nLi >= nQtdLin
									U_Cb997ImpRP()
								EndIf
								If cImpMat == '1'
									@ nLi, 027 Psay TRBBM1->BM1_CODINT
									@ nLi, 031 Psay "."
									@ nLi, 032 Psay TRBBM1->BM1_CODEMP
									@ nLi, 036 Psay "."
									@ nLi, 037 Psay TRBBM1->BM1_MATRIC
									@ nLi, 043 Psay "."
									@ nLi, 044 Psay TRBBM1->BM1_TIPREG
									@ nLi, 049 Psay Trim(TRBBM1->BM1_NOMUSR)
									cImpMat := '2'
								EndIf
								
								If TRBBM1->BM1_TIPO == '2'
									cTotFam := (cTotFam - TRBBM1->(BM1_VALOR))
								Else
									cTotFam := (cTotFam + TRBBM1->(BM1_VALOR))
								EndIf
								
								TRBBM1->(dbSkip())
							EndDo
							If nLi >= nQtdLin
								U_Cb997ImpRP()
							EndIf
							@ nLi, 150 pSay Transform((cTotFam),"@E 999,999,999.99")
							cTotSub += cTotFam
							cTotFam := 0
							cImpMat := '1'
							nLi++
						EndDo
						If nLi >= nQtdLin
							U_Cb997ImpRP()
						EndIf
						
						If Len(aOutLanc) > 0
							For _nCount := 1 To Len(aOutLanc)
								If (aOutLanc[_nCount][1]) == '3' .AND. (aOutLanc[_nCount][5]) == cContra .AND. (aOutLanc[_nCount][6]) == cSubCon
									@ nLi, 049 pSay ("OUTROS LANÇAMENTOS")
									nLi++
									
									If TRBBM1->BM1_TIPO == '2'
										cTotSub := (cTotSub - (aOutLanc[_nCount][7]))
										@ nLi, 049 Psay (aOutLanc[_nCount][3])
										@ nLi, 100 Psay (aOutLanc[_nCount][4])
										@ nLi, 150 Psay Transform((aOutLanc[_nCount][7]),"@E 999,999,999.99")
										nLi++
									Else
										cTotSub := (cTotSub + (aOutLanc[_nCount][7]))
										@ nLi, 049 Psay (aOutLanc[_nCount][3])
										@ nLi, 100 Psay (aOutLanc[_nCount][4])
										@ nLi, 150 Psay Transform((aOutLanc[_nCount][7]),"@E 999,999,999.99")
										nLi++
									EndIf
									_nCount += 1
								EndIf
							Next
						EndIf
						nLi++
						@ nLi, 015 pSay ("Total do SubContrato")
						@ nLi, 150 pSay Transform((cTotSub),"@E 999,999,999.99")
						cTotCon += cTotSub
						cTotSub := 0
						If cSubImp <> TRBBM1->(BM1_CONEMP+BM1_CONEMP)
							nImpSub := 0
						EndIf
						nLi += 2
					EndDo
					If nLi >= nQtdLin
						U_Cb997ImpRP()
					EndIf
					@ nLi, 015 pSay ("Total do Contrato")
					@ nLi, 150 pSay Transform((cTotCon),"@E 999,999,999.99")
					cTotEmp := cTotEmp + cTotCon
					cTotCon:= 0
					nLi += 2
				EndDo
				If nLi >= nQtdLin
					U_Cb997ImpRP()
				EndIf
				cTotGer += cTotEmp
				@ nLi, 010 pSay ("Total Geral")
				@ nLi, 150 pSay Transform((cTotGer),"@E 999,999,999.99")
				nLi++
				cTotGer := 0
				Roda(0,Space(10))
			EndIf
		EndIf
	EndDo
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Imprime rodape...                                                  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	//Roda(0,Space(10))
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Fecha area de trabalho...                                          ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	TRBBM1->( dbClosearea() )
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Libera impressao                                                         ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If  aReturn[5] == 1
		Set Printer To
		Ourspool(crel)
	Endif
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Fim da impressao do relatorio...                                         ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	Return()
Endif

User Function Cb997ImpRP()
If mv_par11 == 1
	Roda(0,Space(10))
	nLi := Cabec(cTitulo,cCabec1,cCabec2,cNomeProg,cTamanho,nCaracter)
	nLi ++
	@ nLi, 010 Psay Trim(TRBBM1->BG9_CODIGO)
	@ nLi, 014 Psay "-"
	@ nLi, 015 Psay Trim(TRBBM1->BG9_NREDUZ)
	nLi ++
	@ nLi, 015 Psay Trim(TRBBM1->BM1_CONEMP)+"."
	@ nLi, 028 Psay Trim(TRBBM1->BM1_SUBCON)
	@ nLi, 037 Psay "-"
	@ nLi, 038 Psay Trim(TRBBM1->BQC_DESCRI)
	nLi ++
Else
	Roda(0,Space(10))
	cCabec1 := "Empresa       Cont/Sub      Matricula             Nome                                                                                                         Valor    "
	nLi := Cabec(cTitulo,cCabec1,"",cNomeProg,cTamanho,nCaracter)
	nLi ++
	@ nLi, 010 Psay Trim(TRBBM1->BG9_CODIGO)
	@ nLi, 014 Psay "-"
	@ nLi, 015 Psay Trim(TRBBM1->BG9_NREDUZ)
	nLi ++
	@ nLi, 015 Psay Trim(TRBBM1->BM1_CONEMP)+"."
	@ nLi, 028 Psay Trim(TRBBM1->BM1_SUBCON)
	@ nLi, 037 Psay "-"
	@ nLi, 038 Psay Trim(TRBBM1->BQC_DESCRI)
	nLi ++
EndIf
Return


/*+-------------------------------------------------------------------------+
|  Função........: Cb010Imp                                               |
|  Data..........: 07.05.2009                                             |
|  Analista......: Eduardo de Moraes Folly                                |
|  Descrição.....: Impressão da proposta.                                 |
+-------------------------------------------------------------------------+*/
//**********************
User Function Cb997Graf()
//**********************
Local aArea		:= GetArea()
Local cTitulo	:= "EXTRATO DO USUÁRIO"

Private nVlParc		:= 0
Private nVlNeg		:= 0

oReport	:= TReport():New("CABR997", cTitulo, /*cPerg*/, {|oReport| PrintReport(oReport)}, cTitulo)

oReport:PrintDialog()


RestArea(aArea)


Return


/*+-------------------------------------------------------------------------+
|  Função........: PrintReport                                            |
|  Data..........: 07.05.2009                                             |
|  Analista......: Eduardo de Moraes Folly                                |
|  Descrição.....: Função auxiliar para impressão da proposta.            |
+-------------------------------------------------------------------------+*/
//**********************************
Static Function PrintReport(oReport)
//**********************************

LOCAL cContra	:= " "
LOCAL cSubcon	:= ""
LOCAL cCodInt 	:= ""
LOCAL cCodEmp 	:= ""
LOCAL cMatric	:= ""
LOCAL cTipReg	:= ""
LOCAL cContra	:= ""
LOCAL cSubCon	:= ""
LOCAL cTotUsr	:= 0
LOCAL cTotFam	:= 0
LOCAL cTotSub	:= 0
LOCAL cTotCon	:= 0
LOCAL cTotEmp	:= 0
LOCAL cTotGer	:= 0
LOCAL nImpSub 	:= 0
LOCAL cSubImpr	:= " "
LOCAL cImpMat   := "1"

PRIVATE _cEmpRel	:= Iif(Substr(cNumEmp,1,2)=="01",'C','I')
PRIVATE oFnt9		:= TFont():New("Courier New"		,,9,,.F.,,,,,.F.,.F.)
PRIVATE oFnt10		:= TFont():New("Arial"		,,10,,.F.,,,,,.F.,.F.)
PRIVATE oFnt10c		:= TFont():New("Arial",,10,,.F.,,,,,.F.,.F.)
PRIVATE oFnt10N		:= TFont():New("Arial"		,,10,,.T.,,,,,.F.,.F.)
PRIVATE oFnt10cN	:= TFont():New("Courier New",,10,,.T.,,,,,.F.,.F.)
PRIVATE oFnt14N		:= TFont():New("Arial"		,,14,,.T.,,,,,.F.,.F.)
PRIVATE oFnt32N		:= TFont():New("Courier New",,32,,.T.,,,,,.F.,.F.)
PRIVATE nTop		:= 100
PRIVATE nTopInt		:= nTop
PRIVATE nLeft		:= 40

oReport:HideHeader()
oReport:HideFooter()

nTop	+= _BL
nTopAux := nTop
nCol0	:= nLeft - 30   // Matricula
nCol1	:= nCol0 + 280	// Nome
nCol2	:= nCol1 + 360	//
nCol3	:= nCol2 + 460	// Cobrança
nCol4	:= nCol3 + 460	// Valor
nCol5	:= nCol4 + 860	// Vazio
nCol6   := nLeft + 80   // Prestador
nCol7   := nCol6 + 800  // Codigo Procedimento
nCol8   := nCol7 + 250  // Data Procedimento
nCol9  	:= nCol8 + 330  // Descrição do Procedimento
nCol10  := nCol9 + 1250  // Valor PF
nRight	:= nCol5 + 850	// Tamanho da linha

dbSelectArea("TRBBM1")

While ! TRBBM1->(Eof())
	cCodEmp := TRBBM1->BM1_CODEMP
	nImpSub := 0
	cSubImp := TRBBM1->(BM1_CONEMP+BM1_SUBCON)
	
	While 	TRBBM1->(BM1_CODEMP) == cCodEmp .AND. ;
			!TRBBM1->(Eof())

		cContra := TRBBM1->BM1_CONEMP
		While 	TRBBM1->BM1_CODEMP == cCodEmp .AND.;
				TRBBM1->(BM1_CONEMP) == cContra .AND. ;
				!TRBBM1->(Eof())

			cSubCon := TRBBM1->BM1_SUBCON
			While 	TRBBM1->BM1_CODEMP == cCodEmp .AND. ;
					TRBBM1->(BM1_CONEMP) == cContra .AND. ;
					TRBBM1->(BM1_SUBCON) == cSubCon .AND. ;
					!TRBBM1->(Eof())
				
				Cab997PGR()
				cMatric	:= TRBBM1->BM1_MATRIC
				While 	TRBBM1->BM1_CODEMP == cCodEmp .AND. ;
						TRBBM1->(BM1_CONEMP) == cContra .AND. ;
						TRBBM1->(BM1_SUBCON) == cSubCon .AND. ;
						TRBBM1->(BM1_MATRIC) == cMatric .AND. ;
						!TRBBM1->(Eof())

					cTipreg := TRBBM1->BM1_TIPREG					
					While 	TRBBM1->BM1_CODEMP == cCodEmp .AND. ;
							TRBBM1->(BM1_CONEMP) == cContra .AND. ;
							TRBBM1->(BM1_SUBCON) == cSubCon .AND. ;
							TRBBM1->(BM1_MATRIC == cMatric) .AND. ;
							TRBBM1->(BM1_TIPREG) == cTipReg .AND. ;
							!TRBBM1->(Eof())
						
						If nTop >= 2000
							Cab997PGR()
						EndIf
						
						If  cImpMat == '1'
							
							nTop += 10
							cMsg := BM1_CODINT + "." + TRBBM1->BM1_CODEMP + "." + TRBBM1->BM1_MATRIC + "." + TRBBM1->BM1_TIPREG
							oReport:Say(nTop, nLeft, cMsg, oFnt10c)
							
							cMsg := Trim(TRBBM1->BM1_NOMUSR)
							oReport:Say(nTop, nCol1 + 250, cMsg, oFnt10c)
							
							cImpMat := '2'
							
						EndIf
						If TRBBM1->BM1_TIPO == '2'
							cTotUsr := (cTotUsr - TRBBM1->(BM1_VALOR))
							cMsg := Trim(TRBBM1->BM1_DESTIP)
							oReport:Say(nTop, nCol3 + 350, cMsg, oFnt10c)
							
							cMsg := Transform(TRBBM1->BM1_VALOR, "@E 999,999,999.99")
							oReport:Say(nTop, nCol4 + 1300, cMsg, oFnt10c)
							
							nTop += _BL
						Else
							cTotUsr := (cTotUsr + TRBBM1->(BM1_VALOR))
							
							cMsg := Trim(TRBBM1->BM1_DESTIP)
							oReport:Say(nTop, nCol3 + 350, cMsg, oFnt10c)
							
							cMsg := Transform(TRBBM1->BM1_VALOR, "@E 999,999,999.99")
							oReport:Say(nTop, nCol4 + 1300, cMsg, oFnt10c)
							
							nTop += _BL
						EndIf
						
						If TRBBM1->BFQ_YTPANL == 'C'
							cQuery := " SELECT BAU.BAU_NOME, BD6_CODLDP, BD6_CODPEG, BD6_NUMERO, BD6_SEQUEN, "
							cQuery := " BD6_CODPRO, BD6_DATPRO, BD6_DESPRO, BD6_VLRPF, BD6_DIGITO,BD6_SEQPF "
							cQuery += " FROM "+RetSQLName("BD6")+" BD6 , "+RetSQLName("BAU")+" BAU "
							cQuery += " WHERE BD6_FILIAL = '"+xFilial("BD6")+"' "
							cQuery += " AND BAU_FILIAL = '"+xFilial("BAU")+"' "
							cQuery += " AND BD6_CODRDA = BAU_CODIGO "
							cQuery += " AND BD6_OPEUSR = '"+TRBBM1->BM1_CODINT+"' "
							cQuery += " AND BD6_CODEMP = '"+TRBBM1->BM1_CODEMP+"' "
							cQuery += " AND BD6_MATRIC = '"+TRBBM1->BM1_MATRIC+"' "
							cQuery += " AND BD6_TIPREG = '"+TRBBM1->BM1_TIPREG+"' "
							cQuery += " AND BD6_DIGITO = '"+TRBBM1->BM1_DIGITO+"' "
							cQuery += " AND BD6_NUMFAT = '"+TRBBM1->BM1_PLNUCO+"' "
							cQuery += " AND BD6.D_E_L_E_T_ <> '*'
							
							PlsQuery(cQuery, "TRBBD6")
							
							DbSelectArea("TRBBD6")
							
							While	! TRBBD6->(Eof())
								
								If nTop >= 2000
									Cab997PGR()
								EndIf
								
								cMsg := TRIM(TRBBD6->BAU_NOME)
								oReport:Say(nTop, nCol6, cMsg, oFnt9)
								
								cMsg := TRIM(TRBBD6->BD6_CODPRO)
								oReport:Say(nTop, nCol7, cMsg, oFnt9)
								
								cMsg := dToC(TRBBD6->BD6_DATPRO)
								oReport:Say(nTop, nCol8, cMsg, oFnt9)
								
								cMsg := TRIM(TRBBD6->BD6_DESPRO)
								oReport:Say(nTop, nCol9, cMsg, oFnt9)
								
								cMsg := Transform((TRBBD6->BD6_VLRPF),"@E 999,999,999.99")
								oReport:Say(nTop, nCol10, cMsg, oFnt9)
								
								nTop += _BL
								
								TRBBD6->(dbSkip())
							EndDo
							DbCloseArea("TRBBD6")
						Endif
						TRBBM1->(dbSkip())
					EndDo
					
					If nTop >= 2000
						Cab997PGR()
					EndIf
					
					nTop += _BL //Salta total do usuario.
					cMsg := "Total do Usuario..................................."
					oReport:Say(nTop, nCol3, cMsg, oFnt10N)
					cMsg := Transform((cTotUsr),"@E 999,999,999.99")
					oReport:Say(nTop, nCol4 + 1390, cMsg, oFnt10N)
					cTotFam += cTotUsr
					cTotUsr := 0
					cTipReg:= TRBBM1->BM1_TIPREG
					cImpMat := '1'
					nTop += _BL
					
				EndDo
				
				If nTop >= 2000
					Cab997PGR()
				EndIf
				
				cMsg := "Total do Familia...................................."
				oReport:Say(nTop, nCol3, cMsg, oFnt10N)
				cMsg := Transform((cTotFam),"@E 999,999,999.99")
				oReport:Say(nTop, nCol4 + 1390, cMsg, oFnt10N)
				cTotSub += cTotFam
				cTotFam := 0
			EndDo
		EndDo
	EndDo
EndDo
DbCloseArea("TRBBM1")

Static Function Cab997PGR()

oReport:EndPage() //Salta para proxima pagina

nTop		:= 100
nTopInt		:= nTop
nLeft		:= 40

If _cEmpRel = 'C'
	oReport:SayBitmap(nTop, nLeft, "lgrl01.bmp", 400, 123)
Else
	oReport:SayBitmap(nTop, nLeft, "lgrl02.bmp", 400, 123)
EndIf

cMsg := "EXTRATO DO USUÁRIO"
oReport:Say(nTop + 25, nLeft + 1000, cMsg, oFnt32N)

nTop	+= _BL
nTopAux := nTop
nCol0	:= nLeft - 30   // Matricula
nCol1	:= nCol0 + 280	// Nome
nCol2	:= nCol1 + 360	//
nCol3	:= nCol2 + 460	// Cobrança
nCol4	:= nCol3 + 460	// Valor
nCol5	:= nCol4 + 860	// Vazio
nCol6   := nLeft + 80   // Prestador
nCol7   := nCol6 + 800  // Codigo Procedimento
nCol8   := nCol7 + 250  // Data Procedimento
nCol9  	:= nCol8 + 330  // Descrição do Procedimento
nCol10  := nCol9 + 1250  // Valor PF
nRight	:= nCol5 + 850	// Tamanho da linha
nTop += 210
cMsg := Trim(TRBBM1->BG9_CODIGO) + " - " + Trim(TRBBM1->BG9_NREDUZ)
oReport:Say(nTop, nLeft, cMsg, oFnt10N)
nTop += _BL
cMsg := Trim(TRBBM1->BM1_CONEMP) + "-" + Trim(TRBBM1->BM1_SUBCON) + "-" + Trim(TRBBM1->BQC_DESCRI)
oReport:Say(nTop, nLeft, cMsg, oFnt10N)
nTop += _BL

nTop += 60
cMsg := "Matrícula"
oReport:Say(nTop, nLeft, cMsg, oFnt10N)

cMsg := "Nome"
oReport:Say(nTop, nCol1 + 250, cMsg, oFnt10N)

cMsg := "Descrição Cobrança"
oReport:Say(nTop, nCol3 + 350, cMsg, oFnt10N)

cMsg := "Valor"
oReport:Say(nTop, nCol4 + 1350, cMsg, oFnt10N)

nTop += _BL
oReport:Line(nTop, nLeft, nTop, nRight)

Return

Return




/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa   ³ CriaSX1   ³ Autor ³ Angelo Sperandio     ³ Data ³ 03.02.05 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao  ³ Atualiza SX1                                               ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
/*/

Static Function CriaSX1(cPerg)

PutSx1(cPerg,"01",OemToAnsi("Operadora:")			,"","","mv_ch1","C",04,0,0,"G","","","","","mv_par01","","","","","","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"02",OemToAnsi("Empresa De")			,"","","mv_ch2","C",04,0,0,"G","","","","","mv_par02","","","","","","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"03",OemToAnsi("Empresa Ate")			,"","","mv_ch3","C",04,0,0,"G","","","","","mv_par03","","","","","","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"04",OemToAnsi("Matricula De?")		,"","","mv_ch4","C",06,0,0,"G","","","","","mv_par04","","","","","","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"05",OemToAnsi("Matricula Ate")		,"","","mv_ch5","C",06,0,0,"G","","","","","mv_par05","","","","","","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"06",OemToAnsi("Usuario De:")			,"","","mv_ch6","C",02,0,0,"G","","","","","mv_par06","","","","","","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"07",OemToAnsi("Usuario Ate:")			,"","","mv_ch7","C",02,0,0,"G","","","","","mv_par07","","","","","","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"08",OemToAnsi("Lote Cobrança :")		,"","","mv_ch08","C",12,0,0,"G","","","","","mv_par08","","","","","","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"09",OemToAnsi("Mês Base")				,"","","mv_ch09","C",02,0,0,"G","","","","","mv_par09","","","","","","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"10",OemToAnsi("Ano Base")				,"","","mv_ch10","C",04,0,0,"G","","","","","mv_par10","","","","","","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"11",OemToAnsi("Tipo de Impresso")		,"","","mv_ch11","N",01,0,0,"C","","","","","mv_par11","Analitico","","","","Sintetico","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"12",OemToAnsi("Somente Utilização:?")	,"","","mv_ch12","N",01,0,0,"C","","","","","mv_par12","Sim","","","","Nao","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"13",OemToAnsi("Quebra?")				,"","","mv_ch13","N",01,0,0,"C","","","","","mv_par13","Sim","","","","Não","","","","","","","","","","","",{},{},{})

Return
