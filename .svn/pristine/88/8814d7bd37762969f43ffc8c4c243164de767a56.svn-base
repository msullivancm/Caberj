#INCLUDE "PLSR591.ch"
#include "PLSMGER.CH"
#Include "protheus.ch"
#Include "rwmake.ch"
#Include "topconn.ch"
#INCLUDE "plsmcon.ch"                            

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±±
±±³Funcao    ³ RIN591  ³ Autor ³Geraldo Felix Junior    ³ Data ³ 28.04.04 ³±±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±±
±±³Descricao ³ Emissao do resumo de cobranca (Intercambio Eventual)       ³±±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±±
±±³Sintaxe   ³ RIN591                                                     ³±±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±±
±±³ Uso      ³ Advanced Protheus                                          ³±±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±±
±±³ Alteracoes desde sua construcao inicial                               ³±±±                            
±±ÃÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±±
±±³ Data     ³ BOPS ³ Programador ³ Breve Descricao                       ³±±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define nome da funcao                                                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
USER Function RIN591(cmv_par01, cmv_par02, cmv_par03, cmv_par04, cmv_par05, cmv_par06, cmv_par07, cmv_par08)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define variaveis padroes para todos os relatorios...                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
PRIVATE nQtdLin     := 60
PRIVATE nLimite     := 220
PRIVATE cTamanho    := "G"
PRIVATE cTitulo     := "Relatório de Despesas de Convênios Reciprocidade"
PRIVATE cDesc1      := STR0002 //"Este Relatorio tem como objetivo emitir resumo demonstrando a composicao de"
PRIVATE cDesc2      := STR0003  //"um lote de cobranca."
PRIVATE cDesc3      := ""
PRIVATE cAlias      := "BDC"
PRIVATE cPerg       := "PLR591"
PRIVATE cRel        := "PLSR591NOVO"
PRIVATE nli         := 80
PRIVATE m_pag       := 1
PRIVATE lCompres    := .F.
PRIVATE lDicion     := .F.
PRIVATE lFiltro     := .F.
PRIVATE lCrystal    := .F.
PRIVATE aOrderns    := {}
PRIVATE aReturn     := { "", 1,"", 1, 1, 1, "",1 }
PRIVATE lAbortPrint := .F.
PRIVATE cCabec1     := "Lote      Geraçào  Referência                                         Total de servicos                        Taxas           Total       Vlr. INSS"
//PRIVATE cCabec2     := STR0008  //"OPERADORA ORIGEM                          PRFX TITULO  PARC. TIPO QTD EVE. "
PRIVATE cCabec2		:= ""
PRIVATE aGerINSS		:= {}
PRIVATE nTitInss		:= 0
PRIVATE cAnoTit 		:= ""
PRIVATE cMesTit		:= ""

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Testa ambiente do relatorio somente top...                               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If ! PLSRelTop()
	Return
Endif

BE4->(DbSetOrder(1))
BD5->(DbSetOrder(1))
SZ8->(DbSetOrder(1)	)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                         				³
//³ mv_par01 // Operadora Inicial                          						³
//³ mv_par02 // Operado Final                                    				³
//³ mv_par03 // Numero Cobranca incial                    						³
//³ mv_par04 // Numero Cobranca Final                            				³
//³ mv_par05 // Operadora inicial                                				³
//³ mv_par06 // Operadora final                                  				³
//³ mv_par07 // Tipo de relatorio  ? analitico/resumido/sintetico				³
//³ mv_par08 // Demonstra criticas ?                             				³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
AjustaSX1()

Pergunte(cPerg,.F.)
If cMv_par01 # Nil
	mv_par01 := cMv_par01
	mv_par02 := cMv_par02
	mv_par03 := cMv_par03
	mv_par04 := cMv_par04
	mv_par05 := cMv_par05
	mv_par06 := cMv_par06
	mv_par07 := cMv_par07
	mv_par08 := cMv_par08
Endif

If mv_par07 == 1
	cCabec2 := "Associado                                               Mat. Convenio      Data Proc.   Prestador                    Nr.Impresso           Procedimento                              Valor     Taxa Conv.         INSS   "
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Chama SetPrint (padrao)                                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cRel := SetPrint(cAlias,cRel,cPerg,@cTitulo,cDesc1,cDesc2,cDesc3,lDicion,aOrderns,lCompres,cTamanho,{},lFiltro,lCrystal)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica se foi cancelada a operacao (padrao)                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If nLastKey  == 27
	Return
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Configura impressora (padrao)                                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
SetDefault(aReturn,cAlias)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Emite relat¢rio                                                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
MsAguarde({|| r591Imp() }, cTitulo, "", .T.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Libera threads                                                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Ms_Flush()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Fim da rotina                                                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Return
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa   ³ r591Imp  ³ Autor ³Geraldo Felix Junior...³ Data ³ 28.04.04 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao  ³ Imprime detalhe do relatorio...                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
/*/
Static Function r591Imp()
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define variaveis...                                                      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
LOCAL cSQL
LOCAL cBTFName 	:= BTF->(RetSQLName("BTF"))
LOCAL cBTOName 	:= BTO->(RetSQLName("BTO"))
LOCAL cBDHName 	:= BDH->(RetSQLName("BDH"))
LOCAL cBA1Name 	:= BA1->(RetSQLName("BA1"))
LOCAL cBD6Name 	:= BD6->(RetSQLName("BD6"))
LOCAL cBAUName 	:= BAU->(RetSQLName("BAU"))
LOCAL cStatus	:= ''
LOCAL cLote		:= ''
LOCAL cNumCob 	:= ''
LOCAL cSequen 	:= ''
LOCAL lFat		:= .F.
LOCAL lCri		:= .F.
LOCAL lNosel	:= .F.
LOCAL lImprimiu := .F.
LOCAL nVLRCOP	:= 0
LOCAL nVLRCP2	:= 0
LOCAL nVLRCP3	:= 0
LOCAL nVLRTAX	:= 0
LOCAL nCUSTOT	:= 0
LOCAL nCUSINSS	:= 0
LOCAL nQTDEVE	:= 0
LOCAL cTipInt   := GetNewPar("MV_PLSCDIE","1")
LOCAL cMatImpAnt:= ""
LOCAL _nTotUsrValor	:= 0
LOCAL _nTotUsrTaxa	:= 0
LOCAL _nTotUsrINSS	:= 0
LOCAL cOpeBTO			:= ""

Private _cChave := ""

SE1->(DbSetOrder(1)) //E1_FILIAL+E1_PREFIXO+E1_NUM+E1_PARCELA+E1_TIPO

nTitInss	:= mv_par09

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta query...                                                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cSQL := "SELECT * FROM "+cBTFName+","+cBTOName+" WHERE "
cSQL += "BTF_FILIAL = '"+xFilial("BTF")+"' AND "
cSQL += "BTF_CODOPE >= '"+mv_par01+"' AND "
cSQL += "BTF_CODOPE <= '"+mv_par02+"' AND "
cSQL += "BTF_NUMERO >= '"+mv_par03+"' AND "
cSQL += "BTF_NUMERO <= '"+mv_par04+"' AND "

cSQL += "BTO_OPEORI >= '"+mv_par05+"' AND "
cSQL += "BTO_OPEORI <= '"+mv_par06+"' AND "

cSQL += cBTFName+".D_E_L_E_T_ = '' AND "
cSQL += cBTOName+".D_E_L_E_T_ = '' AND "
cSql += "BTF_CODOPE = BTO_CODOPE   AND "
cSql += "BTF_NUMERO = BTO_NUMERO AND "
cSql += "BTO_STATUS = '1' " // mbc
cSQL += "ORDER BY " + BTF->(IndexKey()) +"+BTO_STATUS"

PLSQuery(cSQL,"TRB1")

If TRB1->(Eof())
	TRB1->(DbCloseArea())
	Help("",1,"RECNO")
	Return
Endif
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Exibe mensagem...                                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
MsProcTxt(PLSTR0001)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Inicio da impressao dos detalhes...                                      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
aGerINSS := {}

While ! TRB1->(Eof())
	nLi := 80
	VldPag()
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Referentes ao cabecalho do lote...                                       ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If mv_par07 <> 1
		@ nLi, 000 PSAY TRB1->BTF_NUMERO
		@ nLi, 010 PSAY dToc(TRB1->BTF_DATGER)
		@ nLi, 020 PSAY TRB1->BTF_ANOINI+"/"+TRB1->BTF_MESINI
		If TRB1->BTF_OPEGER > 0
			@ nLi, 036 PSAY StrZero(TRB1->BTF_OPEGER,4)
		Endif
		If TRB1->BTF_OPECRI > 0
			@ nLi, 045 PSAY StrZero(TRB1->BTF_OPECRI,4)
		Endif
		If TRB1->BTF_NOSELE > 0
			@ nLi, 053 PSAY StrZero(TRB1->BTF_NOSELE,4)
		Endif
		@ nLi, 074 PSAY Transform(TRB1->(BTF_VLRCOP+BTF_VLRCP2+BTF_VLRCP3),"@E 99,999,999.99")
		@ nLi, 103 PSAY Transform(TRB1->BTF_VLRTAX,"@E 99,999,999.99")
		@ nLi, 118 PSAY Transform(TRB1->BTF_CUSTOT,"@E 99,999,999.99")
	Endif
	nLi += 2
	
	cLote := TRB1->BTF_NUMERO
	While !TRB1->( Eof() ) .and. TRB1->BTO_NUMERO == cLote
		
		
		If TRB1->BTO_STATUS == '1'
			//@ nLi, 000 PSAY STR0009 ; nLi++   	// FATURADAS
			//@ nLi, 000 PSAY "----------"
			lFat := .T.
		Elseif TRB1->BTO_STATUS == '2'			// CRITICADAS
			//@ nLi, 000 PSAY STR0010	; nLi++
			//@ nLi, 000 PSAY "------------"
			lCri := .T.
		Else
			//@ nLi, 000 PSAY STR0011 ; nLi++		// NAO SELECIONADAS
			//@ nLi, 000 PSAY "-----------------"
			lNoSel := .T.
		Endif
		
		nLi++
		cStatus := TRB1->BTO_STATUS
		
		While !TRB1->( Eof() ) .and. TRB1->BTO_NUMERO == cLote .and. TRB1->BTO_STATUS == cStatus

			/*			
			@ nLi, 000 PSAY TRB1->BTO_OPEORI+"-"
			@ nLi, 007 PSAY Left(Posicione("BA0",1,xFilial("BA0")+TRB1->BTO_OPEORI,"BA0_NOMINT"),18)
			@ nLi, 034 PSAY TRB1->BTO_PREFIX
			@ nLi, 039 PSAY TRB1->BTO_NUMTIT
			@ nLi, 046 PSAY TRB1->BTO_PARCEL
			@ nLi, 050 PSAY TRB1->BTO_TIPTIT
			@ nLi, 053 PSAY StrZero(TRB1->BTO_QTDEVE, 5)
			
			@ nLi, 074 PSAY Transform(TRB1->(BTO_VLRCOP+BTO_VLRCP2+BTO_VLRCP3),"@E 99,999,999.99")
			@ nLi, 103 PSAY Transform(TRB1->BTO_VLRTAX,"@E 99,999,999.99")
			@ nLi, 118 PSAY Transform(TRB1->BTO_CUSTOT,"@E 99,999,999.99")
			nLi++
			*/
			
			_nTotValor	:= 0
			_nTotTaxa	:= 0
			_nTotINSS	:= 0
			
			//If mv_par07 == 1 // Analitico
				If lfat
					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³ Busca a movimentacao da operadora por usuarios... somente analitico³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					cSql := " SELECT BD6_CODOPE, BD6_CODEMP, BD6_MATRIC, BD6_TIPREG, BD6_DIGITO, BD6_DATPRO, "
					cSql += " BD6_NOMUSR, BD6_CODRDA, BD6_NOMRDA, BD6_DESPRO, BD6_VLRTPF, BD6_VLRTAD, BD6_NUMIMP,  "
					cSql += " BD6_CODOPE, BD6_CODLDP, BD6_CODPEG, BD6_NUMERO, BD6_ORIMOV, BD6_SEQUEN, BD6_CODPRO,  "
					cSql += " BA1_YMTREP, "
					cSql += " BAU_CODIGO, BAU_TIPPE, BAU_NOME "

					cSql += " FROM "+cBDHName+" BDH INNER JOIN "+cBD6Name+" BD6 ON BD6_FILIAL = '  ' "  
                    cSql += "       AND BD6_OPEUSR = BDH_CODINT   "
                    cSql += "       AND BD6_CODEMP = BDH_CODEMP   "
                    cSql += "       AND BD6_MATRIC = BDH_MATRIC   "
                    cSql += "       AND BD6_TIPREG = BDH_TIPREG   "
                    cSql += "       AND BD6_ANOPAG = BDH_ANOFT    "
                    cSql += "       AND BD6_MESPAG = BDH_MESFT    "
                    cSql += "       AND BD6_SEQPF =  BDH_SEQPF    "
                    cSql += "       AND BD6_NUMTIT = BDH_NUMTIT   "
                          
                    cSql += " INNER JOIN "+cBA1Name+" BA1 ON  BA1_FILIAL = '  ' "
                    cSql += "       AND BA1_CODINT = BDH_CODINT                 "
                    cSql += "       AND BA1_CODEMP = BDH_CODEMP                 "
                    cSql += "       AND BA1_MATRIC = BDH_MATRIC                 "
                    cSql += "       AND BA1_TIPREG = BDH_TIPREG                 "
                                                           
                    cSql += " INNER JOIN "+cBAUName+" BAU ON    BAU_FILIAL = '  ' "  
                    cSql += " AND BAU_CODIGO = BD6_CODRDA  "

					cSql += " WHERE BDH_FILIAL = ' '  "
					cSql += " AND BDH_OPEFAT = '"+TRB1->BTO_OPEORI+"'  "
					cSql += " AND BDH_NUMFAT = '"+TRB1->BTO_CODOPE+TRB1->BTO_NUMERO+"'  "
					cSql += " AND BDH_OPEORI = '"+TRB1->BTO_OPEORI+"'  "
					cSql += " AND BDH_CODINT = '"+TRB1->BTO_CODOPE+"'  "
					cSql += " 
					cSql += " AND BA1.D_E_L_E_T_ = ' '  "
					cSql += " AND BDH.D_E_L_E_T_ = ' '  "
					cSql += " AND BD6.D_E_L_E_T_ = ' '  "
					cSql += " AND BAU.D_E_L_E_T_ = ' '  "    
					cSql += " ORDER BY BD6_NOMUSR "
									   
					/*	cSql += " FROM "+cBDHName+" BDH,"+cBD6Name+" BD6, "+cBA1Name+" BA1, "+cBAUName+" BAU "
					cSql += " WHERE BDH_OPEFAT = '"+TRB1->BTO_OPEORI+"' "
					cSql += " AND BDH_NUMFAT = '"+TRB1->BTO_CODOPE+TRB1->BTO_NUMERO+"' "
					cSql += " AND BDH_OPEORI = '"+TRB1->BTO_OPEORI+"' "
					cSql += " AND BDH_CODINT = '"+TRB1->BTO_CODOPE+"' "
					cSql += " AND BA1_FILIAL = '"+xFilial("BA1")+"' "
					cSql += " AND BA1_CODINT = BDH_CODINT "
					cSql += " AND BA1_CODEMP = BDH_CODEMP "
					cSql += " AND BA1_MATRIC = BDH_MATRIC "
					cSql += " AND BA1_TIPREG = BDH_TIPREG "
					cSql += " AND BD6_FILIAL = '"+xFilial("BD6")+"' "
					cSql += " AND BD6_OPEUSR = BDH_CODINT "
					cSql += " AND BD6_CODEMP = BDH_CODEMP "
					cSql += " AND BD6_MATRIC = BDH_MATRIC "
					cSql += " AND BD6_TIPREG = BDH_TIPREG "
					cSql += " AND BD6_ANOPAG = BDH_ANOFT "
					cSql += " AND BD6_MESPAG = BDH_MESFT "
					cSql += " AND BD6_SEQPF =  BDH_SEQPF "
					cSql += " AND BD6_NUMTIT = BDH_NUMTIT "
					cSql += " AND BAU_FILIAL = '"+xFilial("BAU")+"' "
					cSql += " AND BAU_CODIGO = BD6_CODRDA "
					cSql += " AND BA1.D_E_L_E_T_ = ' ' "
					cSql += " AND BDH.D_E_L_E_T_ = ' ' "
					cSql += " AND BD6.D_E_L_E_T_ = ' ' "
					cSql += " AND BAU.D_E_L_E_T_ = ' ' "
				
                    */
					PlsQuery(cSql, "TRBXX2")
				   //	TCQUERY cSql ALIAS "TRBXX2" NEW
					
					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³ Imprime a movimentacao...                                          ³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					//Modificada logica para Caberj.
					
					If mv_par07 == 1
						@ nLi, 000 PSAY Replicate('-',215)
						nLi++
					Endif

					TRBXX2->( dbGotop() )
					
					cMatImpAnt := ""
					
					While !TRBXX2->( Eof() )
						
						//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
						//³ Tratar campos vazios...                                                  ³
						//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
						
						cDatPro := StoD("")
						cNumImp := ""
						If Empty(TRBXX2->(BD6_DATPRO))
							
							If TRBXX2->BD6_ORIMOV == "1"
								If BD5->(MsSeek(xFilial("BD5")+TRBXX2->(BD6_CODOPE, BD6_CODLDP, BD6_CODPEG, BD6_NUMERO)))
									cDatPro := BD5->BD5_DATPRO
									cNumImp := BD5->BD5_NUMIMP
								Endif
							Else
								If BE4->(MsSeek(xFilial("BE4")+TRBXX2->(BD6_CODOPE, BD6_CODLDP, BD6_CODPEG, BD6_NUMERO)))
									cDatPro := BE4->BE4_DATPRO
									cNumImp := BE4->BE4_NUMIMP
								Endif
							Endif
						Else
							cDatPro := DtoC(TRBXX2->BD6_DATPRO)
							cNumImp := TRBXX2->BD6_NUMIMP
						Endif
						
						/*
						10        20        30        40        50        60        70        80        90        100       110       120       130       140       150       160       170       180       190       200       210
						012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
						Associado                                               Mat. Convenio      Data Proc.   Prestador                    Nr.Impresso           Procedimento                        Valor     Taxa Conv.         INSS   "
						xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx-9.999.9999.999999.99-9  xxxxxxxxxxxxxxxxx   99/99/99    999999-xxxxxxxxxxxxxxxxxxxx  99999999999999999999  xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx 999,999.99     999,999.99   999,999.99   "
						*/
						
						_nMultINSS := Iif(TRBXX2->BAU_TIPPE=="F",0.2,0)
						
						
						//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
						//³ 12/2/08: Conforme regra solicitada, nao imprimir o ³
						//³ quando for o mesmo beneficiario nome e matricula...³
						//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
						If TRBXX2->(BD6_CODOPE+BD6_CODEMP+BD6_MATRIC+BD6_TIPREG+BD6_DIGITO) <> cMatImpAnt
							
							If !Empty(cMatImpAnt)
								//Imprime totalizador somatorio / batimento de valores...
								If mv_par07 == 1
									@ nLi, 076 PSAY Replicate('-',139)
									nLi++
									@ nLi, 176 PSAY Transform(_nTotUsrValor,"@E 999,999.99")
									@ nLi, 191 PSAY Transform(_nTotUsrTaxa,"@E 999,999.99")
									@ nLi, 204 PSAY Transform(_nTotUsrINSS,"@E 999,999.99")
									nLi+=2
								Endif
							Endif
							
							_nTotUsrValor	:= 0
							_nTotUsrTaxa	:= 0
							_nTotUsrINSS	:= 0
							
							If mv_par07 == 1
								@ nLi, 000 PSAY Left(TRBXX2->BD6_NOMUSR,31)+'-'+Transform(TRBXX2->(BD6_CODOPE+BD6_CODEMP+BD6_MATRIC+BD6_TIPREG+BD6_DIGITO), "@R !.!!!.!!!!.!!!!!!-!!-!")   //"@R !!!.!!!!.!!!!!!-!!-!"
								@ nLi, 056 PSAY Alltrim(TRBXX2->BA1_YMTREP)+Space(17-Len(Alltrim(TRBXX2->BA1_YMTREP)))
							Endif
						Endif   
						
						If mv_par07 == 1
							@ nLi, 076 PSAY cDatPro
							@ nLi, 088 PSAY TRBXX2->BD6_CODRDA+'-'+Substr(TRBXX2->BAU_NOME,1,20)
							@ nLi, 117 PSAY cNumImp
							@ nLi, 139 PSAY TRBXX2->BD6_CODPRO+Substr(TRBXX2->BD6_DESPRO,1,20)
							@ nLi, 176 PSAY Transform(TRBXX2->(BD6_VLRTPF-BD6_VLRTAD),"@E 999,999.99")
							@ nLi, 191 PSAY Transform(TRBXX2->(BD6_VLRTAD),"@E 999,999.99")
							@ nLi, 204 PSAY Transform(TRBXX2->(BD6_VLRTPF-BD6_VLRTAD)*_nMultINSS,"@E 999,999.99") //INSS (cfme regra Caberj - Marcela - somente cobra de PF.)
							//@ nLi, 198 PSAY Transform(TRBXX2->(BD6_VLRTPF-BD6_VLRTAD)*0.2,"@E 999,999.99") //INSS (cfme regra Caberj - Marcela - somente cobra de PF.)
							nLi ++
							lImprimiu := .T.
							
						Endif
						
						cMatImpAnt := TRBXX2->(BD6_CODOPE+BD6_CODEMP+BD6_MATRIC+BD6_TIPREG+BD6_DIGITO)
						
						//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
						//³ 12/2/08: Conforme solicitado pelo finenceiro, somar³
						//³ o valor por usuario para totalizacao individual... ³
						//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
						_nTotUsrValor += TRBXX2->(BD6_VLRTPF-BD6_VLRTAD)
						_nTotUsrTaxa += TRBXX2->(BD6_VLRTAD)
						_nTotUsrINSS += TRBXX2->(BD6_VLRTPF-BD6_VLRTAD)*_nMultINSS
						
						_nTotValor += TRBXX2->(BD6_VLRTPF-BD6_VLRTAD)
						_nTotTaxa += TRBXX2->(BD6_VLRTAD)
						_nTotINSS += TRBXX2->(BD6_VLRTPF-BD6_VLRTAD)*_nMultINSS
						
						TRBXX2->( dbSkip() )

						VldPag()
						
					Enddo
					
					
					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³ 12/2/08: Imprime o ultimo totalizador por usuario. ³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					If !Empty(cMatImpAnt)
						If mv_par07 == 1
							//Imprime totalizador somatorio / batimento de valores...
							@ nLi, 076 PSAY Replicate('-',139)
							nLi+=2
							@ nLi, 176 PSAY Transform(_nTotUsrValor,"@E 999,999.99")
							@ nLi, 191 PSAY Transform(_nTotUsrTaxa,"@E 999,999.99")
							@ nLi, 204 PSAY Transform(_nTotUsrINSS,"@E 999,999.99")
							nLi++
						Endif
					Endif
					
					//Imprime totalizador somatorio / batimento de valores...
					If mv_par07 == 1
						@ nLi, 000 PSAY Replicate('-',215)
						nLi++
						@ nLi, 173 PSAY Transform(_nTotValor,"@E 99,999,999.99")
						@ nLi, 188 PSAY Transform(_nTotTaxa,"@E 99,999,999.99")
						@ nLi, 201 PSAY Transform(_nTotINSS,"@E 99,999,999.99")
						nLi ++
					Endif
															
					If lImprimiu
						nLi++
					Endif
					
					TRBXX2->( dbClosearea() )
					
				Elseif lCri
				
					BTG->( dbSetorder(02) )
					
					If BTG->( dbSeek(xFilial("BTG")+TRB1->(BTF_CODOPE+BTF_NUMERO+BTO_SEQUEN)) )
					
						cNumCob := TRB1->BTF_NUMERO
						cSequen := TRB1->BTO_SEQUEN
						
						While !BTG->( Eof() ) .and. BTG->BTG_NUMERO == cNumCob .and. BTG->BTG_SEQUEN == cSequen
				
							If mv_par07 == 1	
								@ nLi, 007 PSAY BTG->BTG_CODCRI+" - "+Posicione("SX5",1,xFilial("SX5")+"BI"+BTG->BTG_CODCRI,"X5_DESCRI")							
								lImprimiu := .T.
								nLi++           
							Endif

							BTG->( dbSkip() )
							
						Enddo
						
						If lImprimiu
							nLi++
						Endif
						
					Endif
				Endif
				
			//Endif  
			
			lImprimiu := .F.
			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Sumariza as variaveis totalizadoras...                             ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			nVLRCOP	+= TRB1->BTO_VLRCOP
			nVLRCP2	+= TRB1->BTO_VLRCP2
			
			If BTO->( FieldPos("BTO_VLRCP3") ) > 0
				nVLRCP3 += TRB1->BTO_VLRCP3
			Endif
			
			nVLRTAX	+= TRB1->BTO_VLRTAX
			nCUSTOT	+= TRB1->BTO_CUSTOT
			nQTDEVE += TRB1->BTO_QTDEVE
			nCUSINSS += _nTotINSS
			
			@ nLi, 000 PSAY TRB1->BTO_OPEORI+"-"
			@ nLi, 007 PSAY Left(Posicione("BA0",1,xFilial("BA0")+TRB1->BTO_OPEORI,"BA0_NOMINT"),18)
			@ nLi, 034 PSAY TRB1->BTO_PREFIX
			@ nLi, 039 PSAY TRB1->BTO_NUMTIT
			@ nLi, 046 PSAY TRB1->BTO_PARCEL
			@ nLi, 050 PSAY TRB1->BTO_TIPTIT
			@ nLi, 053 PSAY StrZero(TRB1->BTO_QTDEVE, 5)
			
			@ nLi, 074 PSAY Transform(TRB1->(BTO_VLRCOP+BTO_VLRCP2+BTO_VLRCP3),"@E 99,999,999.99")
			@ nLi, 103 PSAY Transform(TRB1->BTO_VLRTAX,"@E 99,999,999.99")
			@ nLi, 118 PSAY Transform(TRB1->BTO_CUSTOT,"@E 99,999,999.99")
			@ nLi, 133 PSAY Transform(_nTotINSS,"@E 99,999,999.99")			
			nLi++
			
			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Nova implementacao: Gerar titulos automaticamente caso nao existam...	  ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			//nTitInss: 1-Gera Titulo / 2 - Desfaz Titulos / 3 - Somente relatorio			
			cOpeBTO += If(Empty(cOpeBTO), "", ";") + TRB1->BTO_OPEORI
			
			SZ8->(MsSeek(xFilial("SZ8")+TRB1->(BTO_PREFIX+BTO_NUMTIT+BTO_PARCEL+BTO_TIPTIT)))

			lPodeCriar := Iif(nTitInss == 1,.T.,.F.)
			
			If lPodeCriar .And. SZ8->(Found())
				lPodeCriar := .F.			
			Endif
			
			If nTitInss == 2 
				DesfazTit("INS", TRB1->BTO_NUMTIT, TRB1->BTO_PARCEL, TRB1->BTO_TIPTIT)			
			Endif

			If SE1->(MsSeek(xFilial("SE1")+TRB1->(BTO_PREFIX+BTO_NUMTIT+BTO_PARCEL+BTO_TIPTIT)))			
				cAnoTit := SE1->E1_ANOBASE
				cMesTit := SE1->E1_MESBASE
			Endif				
			
			If lPodeCriar
			
		      If _nTotInss > 0

					aadd(aGerINSS,{{"E1_PREFIXO" ,"INS",Nil},;
									 	{"E1_NUM"     ,SE1->E1_NUM,Nil},;
			                    	{"E1_PARCELA" ,SE1->E1_PARCELA,Nil},;
			                    	{"E1_TIPO"    ,SE1->E1_TIPO,Nil},;
			                    	{"E1_VALOR"   ,_nTotInss ,Nil},;
			                    	{"E1_NATUREZ" ,GetNewPar("MV_YNTINS",SE1->E1_NATUREZ),Nil},;
			                    	{"E1_CLIENTE" ,SE1->E1_CLIENTE,Nil},;
			                    	{"E1_LOJA"    ,SE1->E1_LOJA ,Nil},;
			                    	{"E1_EMISSAO" ,dDataBase,Nil},;
			                    	{"E1_EMIS1"   ,dDataBase,Nil},;
			                    	{"E1_HIST"    ,TRB1->BTO_OPEORI,Nil},;
			                    	{"E1_VENCTO"  ,Iif(SE1->E1_VENCTO < dDataBase,dDataBase,SE1->E1_VENCTO),Nil},; 
			                    	{"E1_VENCREA" ,DataValida(Iif(SE1->E1_VENCTO < dDataBase,dDataBase,SE1->E1_VENCTO)),Nil},;
			                    	{"E1_MESBASE" ,SE1->E1_MESBASE,Nil},;
			                    	{"E1_ANOBASE" ,SE1->E1_ANOBASE,Nil},;
			                    	{"E1_PORCJUR" ,SE1->E1_PORCJUR,Nil},;
			                    	{"E1_ORIGEM" ,"PLSMPAG",Nil} })
			                    					                    	
			   Endif                 					                    	

			Endif
			
			TRB1->(DbSkip())			
			
		Enddo
		
		@ nLi, 082 PSAY "Valor "
		@ nLi, 111 PSAY "Taxa "
		@ nLi, 126 PSAY "Total "
		@ nLi, 141 PSAY "INSS  "
		nLi++
		@ nLi, 067 PSAY Replicate('-', 80)
		nLi++
		@ nLi, 037 PSAY STR0012 // TOTAIS --->
		
		@ nLi, 074 PSAY Transform(nVLRCOP+nVLRCP2+nVLRCP3,"@E 99,999,999.99")
		@ nLi, 103 PSAY Transform(nVLRTAX,"@E 99,999,999.99")
		@ nLi, 118 PSAY Transform(nCUSTOT,"@E 99,999,999.99")
		@ nLi, 133 PSAY Transform(nCUSINSS,"@E 99,999,999.99")
		nLi 	+= 2
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Reseta as variaveis...                                             ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		lFat 	:= .F.
		lCri 	:= .F.
		lNoSel  := .F.
		
		nQTDEVE	:= 0
		nVLRCOP := 0
		nVLRCP2 := 0
		nVLRTAX := 0
		nCUSTOT := 0
		nCUSINSS := 0
      
		If lPodeCriar
			Processa( {|| IncTitINSS( aGerINSS ) }, "Aguarde","Criando Titulos INSS...",.T.)
		Endif
		
		cSQL1 := " SELECT E1_PREFIXO, E1_NUM, E1_PARCELA, E1_TIPO, E1_VALOR, E1_NOMCLI "
		cSQL1 += " FROM "+RetSQLName("SE1")+" SE1 "
		cSQL1 += " WHERE E1_FILIAL = '"+xFilial("SE1")+"' "
		cSQL1 += " AND E1_PREFIXO = 'INS' " //Somente titulos de INSS
		cSQL1 += " AND E1_ANOBASE = '"+cAnoTit+"' " 
		cSQL1 += " AND E1_MESBASE = '"+cMesTit+"' " 
		cSQL1 += " AND E1_HIST IN "+FormatIn(cOpeBTO,";")
		cSQL1 += " AND SE1.D_E_L_E_T_ = ' ' " 
		
		PLSQuery(cSQL1,"TRBTOT")
		
		lPrima := .t.
				
		nTotGerIN := 0
		While !TRBTOT->(Eof())		
		
			If lPrima
			
				@ nLi, 074 PSAY "Titulos de INSS gerados"
				nLi++		
				@ nLi, 074 PSAY Replicate("-",23)
				nLi++		
				
				lPrima := .F.
			Endif
						
			@ nLi, 074 PSAY TRBTOT->(E1_PREFIXO+E1_NUM+E1_PARCELA+E1_TIPO) 
			@ nLi, 090 PSAY TRBTOT->E1_NOMCLI 			
			@ nLi, 120 PSAY Transform(TRBTOT->E1_VALOR,"@E 99,999,999.99")
			nLi++
			nTotGerIN += TRBTOT->E1_VALOR			
			TRBTOT->(DbSkip())
					
		Enddo
		      
		nLi++
      
      If nTotGerIN > 0
			@ nLi, 074 PSAY "Total: "
			@ nLi, 120 PSAY Transform(nTotGerIN,"@E 99,999,999.99")
			nLi++
		Endif
					
		TRBTOT->(DbCloseArea())		

	Enddo
	
	@ nLi, 000 PSAY Replicate('-',147)
	
Enddo
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Imprime rodape do relatorio...                                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Roda(0,space(10),cTamanho)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Fecha arquivo...                                                   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
TRB1->(DbCloseArea())
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Libera impressao                                                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If  aReturn[5] == 1
	Set Printer To
	Ourspool(cRel)
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Fim do Relat¢rio                                                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
DbSelectArea("BDC")

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa   ³ R590Cabec ³ Autor ³Geraldo Felix Junior. ³ Data ³ 28.04.04 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao  ³ Imprime Cabecalho                                          ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
/*/
Static Function R590Cabec()
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Imprime cabecalho...                                                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
nLi := Cabec(cTitulo,cCabec1,cCabec2,cRel,cTamanho,IIF(aReturn[4]==1,GetMv("MV_COMP"),GetMv("MV_NORM")))
nLi ++

Return
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa   ³ VLDPAG    ³ Autor ³Geraldo Felix Junior. ³ Data ³ 28.04.04 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao  ³ Valida a proxima pagina...                                 ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
/*/
Static Function VldPag()

If nLi > nQtdLin
	R590Cabec()
Endif


Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³AjustaSX1 ºAutor  ³Microsiga           º Data ³  15/08/08   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function AjustaSX1()

PutSx1(cPerg,"09",OemToAnsi("Titulos INSS")		,"","","mv_ch9","C",01,0,1,"C","","","","","mv_par09","Gerar","","","","Desfazer","","","Som. Relatorio","","","","","","","","",{},{},{})

Return 


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³PLSR591NOVOºAutor  ³Microsiga           º Data ³  08/15/08   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function IncTitINSS(aGerINSS)
Local nCont := 0

Begin Transaction

For nCont := 1 to Len(aGerINSS)

	lMsErroAuto := .F.
	MsExecAuto({|x,y| Fina040(x,y)},aGerINSS[nCont],3)
	If lMsErroAuto
		DisarmTransaction()
		MostraErro()
	Endif   
		
	SZ8->(RecLock("SZ8",.T.))
	SZ8->Z8_FILIAL := xFilial("SZ8")
	SZ8->Z8_PREORI := "PLS"
	SZ8->Z8_NUMORI := aGerINSS[nCont,2,2] 
	SZ8->Z8_PARORI := aGerINSS[nCont,3,2]
	SZ8->Z8_TIPORI := aGerINSS[nCont,4,2]
	SZ8->Z8_PREFIX := aGerINSS[nCont,1,2] 
	SZ8->Z8_NUMTIT := aGerINSS[nCont,2,2] 
	SZ8->Z8_PARCEL := aGerINSS[nCont,3,2] 
	SZ8->Z8_TIPTIT := aGerINSS[nCont,4,2] 		
	SZ8->(MsUnlock())

Next
			
End Transaction 

Return Nil




/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³DesfazTit ºAutor  ³Microsiga           º Data ³  15/08/08   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function DesfazTit(cPrefixo, cNumero, cParcela, cTipo)
Local lRet := .F.
Local aAreaSE1 := SE1->(GetArea())

If SE1->(MsSeek(xFilial("SE1")+cPrefixo+cNumero+cParcela+cTipo))
           
	Begin Transaction 
	
	aGerINSS := {{"E1_PREFIXO" ,cPrefixo,Nil},;
					{"E1_NUM"     ,cNumero,Nil},;
					{"E1_PARCELA" ,cParcela,Nil},;
					{"E1_TIPO"    ,cTipo,Nil}}/*,;
					{"E1_VALOR"   ,_nTotInss ,Nil},;
					{"E1_NATUREZ" ,GetNewPar("MV_YNTINS",SE1->E1_NATUREZ),Nil},;
					{"E1_CLIENTE" ,SE1->E1_CLIENTE,Nil},;
					{"E1_LOJA"    ,SE1->E1_LOJA ,Nil},;
					{"E1_EMISSAO" ,dDataBase,Nil},;
					{"E1_EMIS1"   ,dDataBase,Nil},;
					{"E1_HIST"    ,"TIT.INSS GERADO PELO PLSR591",Nil},;
					{"E1_VENCTO"  ,Iif(SE1->E1_VENCTO < dDataBase,dDataBase,SE1->E1_VENCTO),Nil},; 
					{"E1_VENCREA" ,DataValida(Iif(SE1->E1_VENCTO < dDataBase,dDataBase,SE1->E1_VENCTO)),Nil},;	                    	
					{"E1_MESBASE" ,SE1->E1_MESBASE,Nil},;
					{"E1_ANOBASE" ,SE1->E1_ANOBASE,Nil},;	                    	
					{"E1_PORCJUR" ,SE1->E1_PORCJUR,Nil} }*/
	
	lMsErroAuto := .F.
	MsExecAuto({|x,y| Fina040(x,y)},aGerINSS,5) //Exclusao de titulos
	If lMsErroAuto
		DisarmTransaction()
		MostraErro()	
	Else
	                       
	   If SZ8->(Found())
			SZ8->(RecLock("SZ8",.F.))
			SZ8->(DbDelete())
			SZ8->(MsUnlock())
		Endif
		
	Endif
	
	
	End Transaction

Endif

RestArea(aAreaSE1)

Return lRet