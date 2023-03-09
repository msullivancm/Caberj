#INCLUDE "PLSR591.ch"
#Include "Ap5Mail.Ch"
#Include 'Tbiconn.ch'
#include "PROTHEUS.CH"
#include "PLSMGER.CH"
#INCLUDE "rwmake.ch"
#INCLUDE "topconn.ch"
#Define CRLF Chr(13)+Chr(10)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±±
±±³Funcao    ³ PLSR591 ³ Autor ³Geraldo Felix Junior    ³ Data ³ 28.04.04 ³±±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±±
±±³Descricao ³ Emissao do resumo de cobranca (Intercambio Eventual)       ³±±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±±
±±³Sintaxe   ³ PLSR591                                                    ³±±±
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
USER Function Cabr242(cmv_par01, cmv_par02, cmv_par03, cmv_par04, cmv_par05, cmv_par06, cmv_par07, cmv_par08 , cmv_par09  , cmv_par10 , cmvpar11 )
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
PRIVATE cPerg1      := "CABR242"
PRIVATE cRel        := "CABR242"
PRIVATE nli         := 80
PRIVATE m_pag       := 1
PRIVATE lCompres    := .F.
PRIVATE lDicion     := .F.
PRIVATE lFiltro     := .F.
PRIVATE lCrystal    := .F.
PRIVATE aOrderns    := {}
PRIVATE aReturn     := { "", 1,"", 1, 1, 1, "",1 }
PRIVATE lAbortPrint := .F.    

PRIVATE cCabec1     := "Lote      Geraçào  Referência                                         Total de servicos                        Taxas           Total"
//PRIVATE cCabec2     := STR0008  //"OPERADORA ORIGEM                          PRFX TITULO  PARC. TIPO QTD EVE. "
PRIVATE cCabec2		:= ""
private cAliasCT    := GetNextAlias()
private cmv_par091  := cmv_par09

private cmv_par101  := cmv_par10
private cFazFec     := cmvpar11 

private cStsPeg     :='              '

PRIVATE arettit    := {}
PRIVATE arettitcov := {}
PRIVATE adados     := {}
PRIVATE adados1    := {}
private cOPEORI     := ' '

private _VLRTAD := 0.00
private _VLRBPF := 0.00
private _VLRINS := 0.00

private _VLRTADT:= 0.00
private _VLRBPFT:= 0.00
private _VLRINST:= 0.00

private _VLRTADTOT:= 0.00
private _VLRBPFTOT:= 0.00
private _VLRINSTOT:= 0.00

private cTitSe1   := ''

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Testa ambiente do relatorio somente top...                               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If ! PLSRelTop()
	Return
Endif

BE4->(DbSetOrder(1))
BD5->(DbSetOrder(1))

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

mv_par05 := cmv_par10
mv_par06 := cmv_par10


ValidPerg1(cPerg1)

If Pergunte(cPerg1,.T.) = .F.
	Return
Endif

Pergunte(cPerg1,.F.)
If cMv_par01 != ' '
	mv_par01 := cMv_par01
	mv_par02 := cMv_par02
	mv_par03 := cMv_par03
	mv_par04 := cMv_par04
	mv_par05 := cMv_par05
	mv_par06 := cMv_par06
	mv_par07 := cMv_par07
	mv_par08 := cMv_par08
Endif

mv_par07 := 1

If mv_par07 == 1
	cCabec2 := "Associado                                               Mat. Convenio      Data Proc.   Prestador                    Nr.Impresso           Procedimento                              Valor     Taxa Conv.         INSS   "
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Chama SetPrint (padrao)                                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cRel := SetPrint(cAlias,cRel,cPerg1,@cTitulo,cDesc1,cDesc2,cDesc3,lDicion,aOrderns,lCompres,cTamanho,{},lFiltro,lCrystal)
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
Return (arettit)
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
LOCAL cBD7Name 	:= BD7->(RetSQLName("BD7"))
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
LOCAL nQTDEVE	:= 0
LOCAL cTipInt   := GetNewPar("MV_PLSCDIE","1")
LOCAL cMatImpAnt:= ""
LOCAL _nTotUsrValor	:= 0
LOCAL _nTotUsrTaxa	:= 0
LOCAL _nTotUsrINSS	:= 0

private _nTotUsr    := 99999999.99

Private _cChave := ""

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta query...                                                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cSQL := "SELECT * FROM "+cBTFName+","+cBTOName+" WHERE "
cSQL += "BTF_FILIAL = '"+xFilial("BTF")+"' AND "
cSQL += "BTF_CODOPE >= '"+mv_par01+"' AND "
cSQL += "BTF_CODOPE <= '"+mv_par02+"' AND "
cSQL += "BTF_NUMERO >= '"+mv_par03+"' AND "
cSQL += "BTF_NUMERO <= '"+mv_par04+"' AND "

cSQL += "BTO_OPEORI >= '"+cmv_par101+"' AND "
cSQL += "BTO_OPEORI <= '"+cmv_par101+"' AND "
//cSQL += "BTO_OPEORI >= '"+mv_par05+"' AND "
//cSQL += "BTO_OPEORI <= '"+mv_par06+"' AND "

cSQL += cBTFName+".D_E_L_E_T_ = '' AND "
cSQL += cBTOName+".D_E_L_E_T_ = '' AND "
cSql += "BTF_CODOPE = BTO_CODOPE   AND "
cSql += "BTF_NUMERO = BTO_NUMERO "
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
		//@ nLi, 059 PSAY Transform(TRB1->BTF_VLRCOP,"@E 99,999,999.99")
		@ nLi, 074 PSAY Transform(TRB1->(BTF_VLRCOP+BTF_VLRCP2+BTF_VLRCP3),"@E 99,999,999.99")
		/*
		If BTF->( FieldPos("BTF_VLRCP3") ) > 0
		@ nLi, 090 PSAY Transform(TRB1->BTF_VLRCP3,"@E 99,999,999.99")
		Endif
		*/
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
			
			cOPEORI  := Left(Posicione("BA0",1,xFilial("BA0")+TRB1->BTO_OPEORI,"BA0_NOMINT"),18)
			
			
			
			@ nLi, 000 PSAY TRB1->BTO_OPEORI+"-"
			@ nLi, 007 PSAY Left(Posicione("BA0",1,xFilial("BA0")+TRB1->BTO_OPEORI,"BA0_NOMINT"),18)
			
			If mv_par17 == 1
				
				@ nLi, 034 PSAY TRB1->BTO_PREFIX
				@ nLi, 039 PSAY TRB1->BTO_NUMTIT
				@ nLi, 046 PSAY TRB1->BTO_PARCEL
				@ nLi, 050 PSAY TRB1->BTO_TIPTIT
				@ nLi, 053 PSAY StrZero(TRB1->BTO_QTDEVE, 5)
				
				//@ nLi, 059 PSAY Transform(TRB1->BTO_VLRCOP,"@E 99,999,999.99")
				@ nLi, 074 PSAY Transform(TRB1->(BTO_VLRCOP+BTO_VLRCP2+BTO_VLRCP3),"@E 99,999,999.99")
				/*
				If BTO->( FieldPos("BTO_VLRCP3") ) > 0
				@ nLi, 090 PSAY Transform(TRB1->BTO_VLRCP3,"@E 99,999,999.99")
				Endif
				*/
				@ nLi, 103 PSAY Transform(TRB1->BTO_VLRTAX,"@E 99,999,999.99")
				@ nLi, 118 PSAY Transform(TRB1->BTO_CUSTOT,"@E 99,999,999.99")
				
			EndIf
			nLi++
			_nTotValor	:= 0
			_nTotTaxa	:= 0
			_nTotINSS	:= 0
			
			cTitSe1 := TRB1->BTO_PREFIX + TRB1->BTO_NUMTIT + TRB1->BTO_PARCEL + TRB1->BTO_TIPTIT
			
			/****************************************************************/
			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Monta query do titulo ...                                                ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			
			
			
			cSQL := " SELECT PCS_OPEORI ,PCS_ANOPAG||PCS_MESPAG ,PCS_PREFIX prefixo , PCS_NUMTIT num , PCS_TIPO tipo ,  " + CRLF
			cSQL += "        COUNT(*) QTDA ,  SUM( PCS_VLRBPF) VLRBPF , SUM( PCS_VLRTAD ) VLRTAD , SUM( PCS_VLRINS ) VLRINS " + CRLF
			cSQL += "   FROM "+RetSqlName('PCS')+ " PCS " + CRLF
			cSQL += "  WHERE PCS_FILIAL ='"+xFilial("PCS")+"' " + CRLF
			cSQL += "    AND D_E_L_E_T_ = ' '  " + CRLF
			cSQL += "    AND PCS_OPEORI = '"+TRB1->BTO_OPEORI+"'  " + CRLF
			cSQL += "    AND PCS_ANOPAG||PCS_MESPAG = '"+cmv_par091+"'  " + CRLF
			cSQL += "    GROUP BY PCS_OPEORI ,PCS_ANOPAG||PCS_MESPAG ,PCS_PREFIX , PCS_NUMTIT , PCS_TIPO  " + CRLF
			cSQL += "    ORDER BY 1,2,4
			
			If Select((cAliasCT)) <> 0
				
				(cAliasCT)->(DbCloseArea())
				
			Endif
			
			TcQuery cSQL New Alias (cAliasCT)
			
			While !(cAliasCT)->( Eof() )
				
				If mv_par17 == 1
					// 	@ nLi, 000 PSAY TRB1->BTO_OPEORI+"-"
					//	@ nLi, 007 PSAY Left(Posicione("BA0",1,xFilial("BA0")+TRB1->BTO_OPEORI,"BA0_NOMINT"),18)
					@ nLi, 034 PSAY (cAliasCT)->PREFIXO
					@ nLi, 039 PSAY (cAliasCT)->NUM
					@ nLi, 046 PSAY ' '
					@ nLi, 050 PSAY (cAliasCT)->TIPO
					@ nLi, 053 PSAY StrZero((cAliasCT)->QTDA, 5)
					
					//@ nLi, 059 PSAY Transform(TRB1->BTO_VLRCOP,"@E 99,999,999.99")
					@ nLi, 074 PSAY Transform(((cAliasCT)->VLRBPF)*-1,"99,999,999.99")
					/*
					If BTO->( FieldPos("BTO_VLRCP3") ) > 0
					@ nLi, 090 PSAY Transform(TRB1->BTO_VLRCP3,"@E 99,999,999.99")
					Endif
					*/
					@ nLi, 103 PSAY Transform(((cAliasCT)->VLRTAD*-1),"@E 99,999,999.99")
					@ nLi, 118 PSAY Transform(((cAliasCT)->VLRBPF*-1)+((cAliasCT)->VLRTAD*-1),"99,999,999.99")
					@ nLi, 133 PSAY Transform(((cAliasCT)->VLRINS*-1),"@E 99,999,999.99")
					
					nLi++
					aadd(arettitcov,{(cAliasCT)->PREFIXO , (cAliasCT)->NUM , (cAliasCT)->TIPO , mv_par03 , mv_par08, mv_par09 , mv_par10, mv_par11 , mv_par12, mv_par13 , mv_par14, mv_par15 , mv_par16})
				EndIf
				_VLRTAD :=_vlrtad + (cAliasCT)->VLRTAD
				_VLRBPF :=_VLRBPF + (cAliasCT)->VLRBPF
				_VLRINS :=_VLRINS + (cAliasCT)->VLRINS
				
				IF Mv_par16 == 1
					// faz baixa parcial inserir chamada aki
				EndIF
				
				(cAliasCT)->( dbSkip() )
				
			EndDo
			
			If mv_par07 == 1 // Analitico
				If lfat
					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³ Busca a movimentacao da operadora por usuarios... somente analitico³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					cSql := " SELECT BD6_CODOPE, BD6_CODEMP, BD6_MATRIC, BD6_TIPREG, BD6_DIGITO, BD6_DATPRO, " + CRLF
					cSql += " BD6_NOMUSR, BD6_CODRDA, BD6_NOMRDA, BD6_DESPRO, BD6_VLRTPF , BD6_VLRBPF , BD6_VLRTAD, BD6_NUMIMP,  "+ CRLF
					cSql += " BD6_CODOPE, BD6_CODLDP, BD6_CODPEG, BD6_NUMERO, BD6_ORIMOV, BD6_SEQUEN, BD6_CODPRO,  "+ CRLF
					cSql += " BA1_YMTREP, "+ CRLF
					cSql += " BAU_CODIGO, BAU_TIPPE, BAU_NOME , "+ CRLF
					
					cSql += "  0.00 VLRTPFPCS , 0.00 VLRBPFPCS ,  0.00  VLRTADPCS , " + CRLF
					
					cSql += " decode(trim(BD6_FASE),'4','4-Fat','1','1-Dig','2','2-Conf','3','3-Prt',  'N-Prt') fase ,"+ CRLF
					
					cSql += " CASE WHEN trim(bd6.D_e_l_e_t_)      = '*'                  THEN 'Delet. PLS '"+ CRLF
					cSql += "      WHEN nvl(bd6_CODPEG,' ')       = ' '                  THEN 'Não Exist PLS ' "+ CRLF
					cSql += "      WHEN trim(BD6_FASE) <> '4'                            THEN 'G. Não Paga  ' "+ CRLF
					cSql += "      WHEN NVL(BD6_NUMFAT,'            ') = '            '  THEN 'G. Não Cobrd' "+ CRLF
					cSql += "      Else 'Ok' END  statuspeg  , "+ CRLF
					
					cSql += "  0.00 DifB , 0.00 DifT , 0.00 DifTOT , "+ CRLF
					
					cSql += "      0 PCSRECNO  "+ CRLF
					
					cSql += " FROM "+cBDHName+" BDH,"+cBD6Name+" BD6, "+cBA1Name+" BA1, "+cBAUName+" BAU "+ CRLF
					cSql += " WHERE BDH_OPEFAT = '"+TRB1->BTO_OPEORI+"' "+ CRLF
					cSql += " AND BDH_NUMFAT = '"+TRB1->BTO_CODOPE+TRB1->BTO_NUMERO+"' "+ CRLF
					cSql += " AND BDH_OPEORI = '"+TRB1->BTO_OPEORI+"' "+ CRLF
					cSql += " AND BDH_CODINT = '"+TRB1->BTO_CODOPE+"' "+ CRLF
					cSql += " AND BA1_FILIAL = '"+xFilial("BA1")+"' "+ CRLF
					cSql += " AND BA1_CODINT = BDH_CODINT " + CRLF
					cSql += " AND BA1_CODEMP = BDH_CODEMP "+ CRLF
					cSql += " AND BA1_MATRIC = BDH_MATRIC "+ CRLF
					cSql += " AND BA1_TIPREG = BDH_TIPREG "+ CRLF
					cSql += " AND BD6_FILIAL = '"+xFilial("BD6")+"' "+ CRLF
					cSql += " AND BD6_OPEUSR = BDH_CODINT "+ CRLF
					cSql += " AND BD6_CODEMP = BDH_CODEMP "+ CRLF
					cSql += " AND BD6_MATRIC = BDH_MATRIC "+ CRLF
					cSql += " AND BD6_TIPREG = BDH_TIPREG "+ CRLF
					cSql += " AND BD6_ANOPAG = BDH_ANOFT  "+ CRLF
					cSql += " AND BD6_MESPAG = BDH_MESFT  "+ CRLF
					cSql += " AND BD6_SEQPF  = BDH_SEQPF  "+ CRLF
					cSql += " AND BD6_NUMSE1 = BDH_NUMSE1 "+ CRLF
					
					cSql += " AND NOT EXISTS ( SELECT * FROM siga.PCS010 PCS WHERE PCS_FILIAL = ' ' AND PCS.D_e_l_e_t_ = ' ' AND PCS_RECBD6 = BD6.r_e_c_n_o_ AND PCS_LCFEC = 11 ) " + CRLF
					
					cSql += " AND BAU_FILIAL = '"+xFilial("BAU")+"' "+ CRLF
					cSql += " AND BAU_CODIGO = BD6_CODRDA "+ CRLF
					cSql += " AND BA1.D_E_L_E_T_ = ' ' "+ CRLF
					cSql += " AND BDH.D_E_L_E_T_ = ' ' "+ CRLF
					cSql += " AND BD6.D_E_L_E_T_ = ' ' "+ CRLF
					cSql += " AND BAU.D_E_L_E_T_ = ' ' AND bau.R_E_C_D_E_L_ = 0"+ CRLF
					
					///tratamento para guias reapresentadas
					if Mv_par18 == 2
						cSql += " AND NOT EXISTS" + CRLF
						cSql += " ( select  NULL" + CRLF
						cSql += "    from siga.pcs010 pcs , bd6010 bd61" + CRLF
						cSql += "   where pcs_filial      =' ' and pcs.D_e_l_E_T_ = ' ' " + CRLF
						cSql += "     and bd61.bd6_filial =' ' " + CRLF
						cSql += "     and bd61.R_E_C_N_O_ = pcs_recbd6 " + CRLF
						cSql += "     and trim(bd61.BD6_CODOPE) = trim(BD6.BD6_CODOPE) " + CRLF
						cSql += "     and trim(bd61.BD6_CODEMP) = trim(BD6.BD6_CODEMP) " + CRLF
						cSql += "     and trim(bd61.BD6_MATRIC) = trim(BD6.BD6_MATRIC) " + CRLF
						cSql += "     and trim(bd61.BD6_TIPREG) = trim(BD6.BD6_TIPREG) " + CRLF
						cSql += "     and trim(bd61.BD6_DATPRO) = trim(BD6.BD6_DATPRO) " + CRLF
						cSql += "     and trim(bd61.BD6_CODPRO) = trim(BD6.BD6_CODPRO) " + CRLF
						cSql += "     and trim(BD61.bd6_CODRDA) = trim(BD6.bd6_CODRDA) " + CRLF
						cSql += "     and trim(bd61.BD6_NUMIMP) = trim(BD6.BD6_NUMIMP) " + CRLF
						
						cSql += "     and bd61.r_e_c_n_o_ <> bd6.r_e_c_n_o_  " + CRLF
						
						cSql += "     and ( bd61.D_e_l_e_t_ = '*' ) " + CRLF
						//cSql += "        or bd61.BD6_SITUAC     <> '1' ) " + CRLF
						
						
						//cSql += "     and trim(bd61.bd6_HORPRO) = trim(BD6.bd6_HORPRO) " + CRLF
						if Mv_par19 == 2
							cSql += "    AND PCS_MESPAG = BD61.BD6_MESPAG " + CRLF
							cSql += "    AND PCS_ANOPAG = BD61.BD6_ANOPAG " + CRLF
						EndIf
						cSql += "   AND PCS_VLRBPF      >= BD6.BD6_VLRBPF " + CRLF
						cSql += "   AND PCS_VLRTAD      >= BD6.BD6_VLRTAD " + CRLF
						cSql += "   AND PCS_VLRTPF      >= BD6.BD6_VLRTPF " + CRLF
						cSql += " )  " + CRLF
					EndIf
					/////
					If mv_par08 == 1
						
						cSql += "union"+ CRLF
						
						cSql += " SELECT BD6_CODOPE, BD6_CODEMP, BD6_MATRIC, BD6_TIPREG, BD6_DIGITO, BD6_DATPRO," + CRLF
						cSql += " BD6_NOMUSR, BD6_CODRDA, BD6_NOMRDA, BD6_DESPRO,"+ CRLF
						cSql += " BD6_VLRTPF, BD6_VLRBPF, BD6_VLRTAD,"+ CRLF
						cSql += " BD6_NUMIMP, BD6_CODOPE, BD6_CODLDP, BD6_CODPEG, BD6_NUMERO, BD6_ORIMOV," + CRLF
						cSql += " BD6_SEQUEN, BD6_CODPRO,   BA1_YMTREP,  BAU_CODIGO, BAU_TIPPE, BAU_NOME ," + CRLF
						
						cSql += "  PCS_VLRTPF VLRTPFPCS , PCS_VLRBPF VLRBPFPCS ,  PCS_VLRTAD VLRTADPCS ,  " + CRLF
						
						cSql += " decode(trim(BD6_FASE),'4','4-Fat','1','1-Dig','2','2-Conf','3','3-Prt', 'N-Prt') fase ,"+ CRLF
						
						cSql += "  CASE WHEN trim(nvl(bd6.D_e_l_e_t_,'*')) = '*'             THEN 'Delet. PLS'      " + CRLF
						cSql += "       WHEN nvl(bd6_CODPEG,' ')      = ' '             THEN 'Não Exist PLS'   " + CRLF
						cSql += "       WHEN trim(nvl(BD6_BLOCPA,'1'))= '1'             THEN 'G. Bloq Cob'     " + CRLF
						cSql += "       WHEN trim(nvl(BD6_SITUAC,'0'))<> '1'            THEN 'G. Não Ativa'    " + CRLF
						cSql += "       WHEN SUBSTR(trim(nvl(BD6_fase,'1')),1,1) < '3'  THEN 'G. Fase 1 ou 2'  " + CRLF
						cSql += "       WHEN trim(nvl(BD6_fase,'1'))  <> '4'            THEN 'G. Não Paga'     " + CRLF
						cSql += "       WHEN NVL(BD6_NUMFAT,'            ') = '            ' THEN 'G. Não Cobrd'    " + CRLF
						cSql += "       WHEN PCS_VLRTPF     <>  nvl(BD6_VLRTPF,0.00)     THEN 'Div Vlr Cobrd'   " + CRLF
						cSql += "       WHEN PCS_VLRBPF     <>  nvl(BD6_VLRBPF,0.00)     THEN 'Div Vlr Pagto'   " + CRLF
						cSql += "       WHEN PCS_VLRTAD     <>  nvl(BD6_VLRTAD,0.00)     THEN 'Div Vlr Taxa'    " + CRLF
						cSql += "       Else 'Ok' END  statuspeg  , " + CRLF
						
						cSql += "      (nvl(BD6_VLRBPF,0.00) - PCS_VLRBPF) DifB , "+ CRLF
						cSql += "      (nvl(BD6_VLRTAD,0.00) - PCS_VLRTAD) DifT , "+ CRLF
						cSql += "      (nvl(BD6_VLRTPF,0.00) - PCS_VLRTPF) DifTOT ,  "+ CRLF
						
						cSql += "      PCS.r_e_c_n_o_ PCSRECNO  "+ CRLF
						
						cSql += " FROM  "+RetSqlName('BD6')+" BD6 , "+RetSqlName('BA1')+" BA1 , "+RetSqlName('BAU')+" BAU , siga."+RetSqlName('PCS')+" PCS " + CRLF
						cSql += " WHERE BA1_FILIAL = '"+xFilial("BA1")+"' "+ CRLF
						cSql += " AND BA1_CODINT = BD6_OPEUSR " + CRLF
						cSql += " AND BA1_CODEMP = BD6_CODEMP " + CRLF
						cSql += " AND BA1_MATRIC = BD6_MATRIC " + CRLF
						cSql += " AND BA1_TIPREG = BD6_TIPREG " + CRLF
						cSql += " AND BD6_FILIAL = '"+xFilial("BD6")+"' " + CRLF
						
						cSql += " AND pcs_filial = '"+xFilial("PCS")+"' " + CRLF
						cSql += " AND PCS_RECBD6 = BD6.r_e_c_n_o_ " + CRLF
						
						cSQL += " AND PCS_OPEORI = '"+TRB1->BTO_OPEORI+"'  " + CRLF
						cSQL += " AND PCS_ANOPAG||PCS_MESPAG = '"+cmv_par091+"'  " + CRLF
						
						cSql += " AND BAU_FILIAL = '"+xFilial("BAU")+"' " + CRLF
						cSql += " AND BAU_CODIGO = BD6_CODRDA "+ CRLF
						cSql += " AND BA1.D_E_L_E_T_ = ' ' " + CRLF
						
						cSql += " AND BAU.D_E_L_E_T_ = ' ' AND bau.R_E_C_D_E_L_ = 0 " + CRLF
						cSql += " and PCS.D_E_L_E_T_ = ' ' " + CRLF
						
						///tratamento para guias reapresentadas
						if Mv_par18 == 2
							cSql += " AND NOT EXISTS" + CRLF
							cSql += " ( select  NULL" + CRLF
							cSql += "    from siga.pcs010 pcs , bd6010 bd61" + CRLF
							cSql += "   where pcs_filial      =' ' and pcs.D_e_l_E_T_ = ' ' " + CRLF
							cSql += "     and bd61.bd6_filial =' ' and bd61.D_e_l_E_T_ = ' ' " + CRLF
							//cSql += "     and bd61.R_E_C_N_O_ = pcs_recbd6 " + CRLF
							cSql += "     and trim(bd61.BD6_CODOPE) = trim(BD6.BD6_CODOPE) " + CRLF
							cSql += "     and trim(bd61.BD6_CODEMP) = trim(BD6.BD6_CODEMP) " + CRLF
							cSql += "     and trim(bd61.BD6_MATRIC) = trim(BD6.BD6_MATRIC) " + CRLF
							cSql += "     and trim(bd61.BD6_TIPREG) = trim(BD6.BD6_TIPREG) " + CRLF
							cSql += "     and trim(bd61.BD6_DATPRO) = trim(BD6.BD6_DATPRO) " + CRLF
							cSql += "     and trim(bd61.BD6_CODPRO) = trim(BD6.BD6_CODPRO) " + CRLF
							cSql += "     and trim(BD61.bd6_CODRDA) = trim(BD6.bd6_CODRDA) " + CRLF
							cSql += "     and trim(bd61.BD6_NUMIMP) = trim(BD6.BD6_NUMIMP) " + CRLF
							
							//cSql += "     and trim(bd61.bd6_HORPRO) = trim(BD6.bd6_HORPRO) " + CRLF
							
							cSql += "     and bd61.r_e_c_n_o_ <> bd6.r_e_c_n_o_  " + CRLF
							
							cSql += "     and ( bd6.D_e_l_e_t_ = '*' )" + CRLF
							//cSql += "        or bd6.BD6_SITUAC     <> '1' ) " + CRLF
							
							if Mv_par19 == 2
								cSql += "    AND PCS_MESPAG = BD61.BD6_MESPAG " + CRLF
								cSql += "    AND PCS_ANOPAG = BD61.BD6_ANOPAG " + CRLF
							EndIf
							cSql += "     AND PCS_VLRBPF  = BD61.BD6_VLRBPF " + CRLF
							cSql += "     AND PCS_VLRTAD  = BD61.BD6_VLRTAD " + CRLF
							cSql += "     AND PCS_VLRTPF  = BD61.BD6_VLRTPF " + CRLF
							cSql += " ) " + CRLF
						EndIf
						///
						cSql += "  and ( trim(nvl(bd6.D_e_l_e_t_,'*'))  = '*'    " + CRLF
						cSql += "        or nvl(bd6_CODPEG,' ')         = ' '    " + CRLF
						cSql += "        or trim(nvl(BD6_SITUAC,'0'))  <> '1'    " + CRLF
						
						If mv_par15 == 1
							cSql += "        or trim(nvl(BD6_BLOCPA,'1'))   = '1'    " + CRLF
						EndIf
						
						If mv_par13 == 1
							cSql += "        or trim(nvl(BD6_fase,'1'))     < '3'    " + CRLF
						EndIf
						
						If mv_par12 == 1
							cSql += "        or trim(nvl(BD6_fase,'1'))    <> '4'    " + CRLF
						EndIf
						
						If mv_par14 == 1
							cSql += "        or NVL(BD6_NUMFAT,'            ') = '            ' " + CRLF
						EndIf
						
						If mv_par09 == 1
							cSql += "        or PCS_VLRTPF >  nvl(BD6_VLRTPF,0.00)   " + CRLF
						ElseIf mv_par09 == 2
							cSql += "        or PCS_VLRTPF <  nvl(BD6_VLRTPF,0.00)   " + CRLF
						ElseIf mv_par09 == 4
							cSql += "        or PCS_VLRTPF <> nvl(BD6_VLRTPF,0.00)   " + CRLF
						EndIf
						
						If mv_par10 == 1
							cSql += "        or PCS_VLRBPF >  nvl(BD6_VLRBPF,0.00)   " + CRLF
						ElseIf mv_par10 == 2
							cSql += "        or PCS_VLRBPF <  nvl(BD6_VLRBPF,0.00)   " + CRLF
						ElseIf mv_par10 == 4
							cSql += "        or PCS_VLRBPF <> nvl(BD6_VLRBPF,0.00)   " + CRLF
						EndIf
						
						If mv_par11 == 1
							cSql += "        or PCS_VLRTAD >  nvl(BD6_VLRTAD,0.00)   " + CRLF
						ElseIf mv_par11 == 2
							cSql += "        or PCS_VLRTAD <  nvl(BD6_VLRTAD,0.00)   " + CRLF
						ElseIf mv_par11 == 4
							cSql += "        or PCS_VLRTAD <> nvl(BD6_VLRTAD,0.00)   " + CRLF
						EndIf
						
						cSql += " ) " + CRLF
						
					EndIf
					
					cSql += " ORDER BY 1,2,3,4,5,6 "+ CRLF
					
					PlsQuery(cSql, "TRB2")
					
					/*  If Select(("TRB2")) <> 0
					
					("TRB2")->(DbCloseArea())
					
					Endif
					
					TcQuery Sql New Alias ("TRB2")
					*/
					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³ Imprime a movimentacao...                                          ³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					//Modificada logica para Caberj.
					
					//		If cFazFec == 1
					//		   FGrvPlan(cOPEORI ,cmv_par091 )
					//			EndIf
					
					fGeraVet()
					
					fGrvPlan(cOPEORI ,cmv_par091 )
					
	//				fVerLinha()
					//    u_caba242a(adados)
					
					TRB2->( dbGotop() )
					@ nLi, 000 PSAY Replicate('-',215)
					nLi++
					
					cMatImpAnt := ""
					
					While !TRB2->( Eof() )
						
						//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
						//³ Tratar campos vazios...                                                  ³
						//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
						
						cDatPro := StoD("")
						cNumImp := ""
						If Empty(TRB2->(BD6_DATPRO))
							
							If TRB2->BD6_ORIMOV == "1"
								If BD5->(MsSeek(xFilial("BD5")+TRB2->(BD6_CODOPE, BD6_CODLDP, BD6_CODPEG, BD6_NUMERO)))
									cDatPro := BD5->BD5_DATPRO
									cNumImp := BD5->BD5_NUMIMP
								Endif
							Else
								If BE4->(MsSeek(xFilial("BE4")+TRB2->(BD6_CODOPE, BD6_CODLDP, BD6_CODPEG, BD6_NUMERO)))
									cDatPro := BE4->BE4_DATPRO
									cNumImp := BE4->BE4_NUMIMP
								Endif
							Endif
						Else
							cDatPro := DtoC(TRB2->BD6_DATPRO)
							cNumImp := TRB2->BD6_NUMIMP
						Endif
						
						/*
						10        20        30        40        50        60        70        80        90        100       110       120       130       140       150       160       170       180       190       200       210
						012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
						Associado                                               Mat. Convenio      Data Proc.   Prestador                    Nr.Impresso           Procedimento                        Valor     Taxa Conv.         INSS   "
						xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx-9.999.9999.999999.99-9  xxxxxxxxxxxxxxxxx   99/99/99    999999-xxxxxxxxxxxxxxxxxxxx  99999999999999999999  xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx 999,999.99     999,999.99   999,999.99   "
						*/
						
						_nMultINSS := Iif(TRB2->BAU_TIPPE=="F",0.2,0)
						
						
						//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
						//³ 12/2/08: Conforme regra solicitada, nao imprimir o ³
						//³ quando for o mesmo beneficiario nome e matricula...³
						//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
						If TRB2->(BD6_CODOPE+BD6_CODEMP+BD6_MATRIC+BD6_TIPREG+BD6_DIGITO) <> cMatImpAnt
							
							If !Empty(cMatImpAnt)
								//Imprime totalizador somatorio / batimento de valores...
								@ nLi, 076 PSAY Replicate('-',139)
								nLi++
								@ nLi, 176 PSAY Transform(_nTotUsrValor,"@E 999,999.99")
								@ nLi, 191 PSAY Transform(_nTotUsrTaxa,"@E 999,999.99")
								@ nLi, 204 PSAY Transform(_nTotUsrINSS,"@E 999,999.99")
								nLi+=2
								
								
								
							Endif
							
							_nTotUsrValor	:= 0
							_nTotUsrTaxa	:= 0
							_nTotUsrINSS	:= 0
							
							@ nLi, 000 PSAY Left(TRB2->BD6_NOMUSR,31)+'-'+Transform(TRB2->(BD6_CODOPE+BD6_CODEMP+BD6_MATRIC+BD6_TIPREG+BD6_DIGITO),"@R !.!!!.!!!!.!!!!!!-!!-!")    //__cPictUsr
							@ nLi, 056 PSAY Alltrim(TRB2->BA1_YMTREP)+Space(17-Len(Alltrim(TRB2->BA1_YMTREP)))
							nLi+=1
						Endif
						@ nLi, 076 PSAY cDatPro
						@ nLi, 088 PSAY TRB2->BD6_CODRDA+'-'+Substr(TRB2->BAU_NOME,1,20)
						@ nLi, 117 PSAY cNumImp
						@ nLi, 139 PSAY TRB2->BD6_CODPRO+Substr(TRB2->BD6_DESPRO,1,20)
						
						if   (trim(TRB2->statuspeg) == 'Delet. PLS' ) .or.  (trim(TRB2->statuspeg) == 'Não Exist PLS' ) ;
							.or.  (trim(TRB2->statuspeg) == 'G. Não Paga') .or.  (trim(TRB2->statuspeg) == 'G. Não Cobrd'  ) ;
							.or.  (trim(TRB2->statuspeg) == 'G. Bloq Cob') .or.  (trim(TRB2->statuspeg) == 'G. Não Ativa'  ) ;
							.or.  (trim(TRB2->statuspeg) == 'G. Fase 1 ou 2')
							  
							  cStsPeg :='ESTORNO       '
						 //	@ nLi, 010 PSAY TRB2->statuspeg + ' - ' + Transform((TRB2->(VLRBPFPCS)*-1),"@E 999,999.99") + ' - ' + Transform((TRB2->(VLRTADPCS)*-1),"@E 999,999.99")  
                            @ nLi, 010 PSAY cStsPeg + ' - ' + Transform((TRB2->(VLRBPFPCS)*-1),"@E 999,999.99") + ' - ' + Transform((TRB2->(VLRTADPCS)*-1),"@E 999,999.99") 
						 
							
							@ nLi, 176 PSAY Transform((TRB2->(VLRBPFPCS)*-1 ),"@E 999,999.99")
							@ nLi, 191 PSAY Transform((TRB2->(VLRTADPCS)*-1),"@E 999,999.99")
							@ nLi, 204 PSAY Transform(((TRB2->(VLRBPFPCS)*_nMultINSS)*-1),"@E 999,999.99") //INSS (cfme regra Caberj - Marcela - somente cobra de PF.)
							
							_VLRTADT:=  TRB2->(VLRTADPCS)*-1
							_VLRBPFT:= (TRB2->(VLRBPFPCS))*-1
							_VLRINST:= (TRB2->(VLRBPFPCS)*_nMultINSS)*-1
							
							_nTotUsrValor	+= TRB2->VLRBPFPCS  *-1
							_nTotUsrTaxa	+= TRB2->VLRTADPCS  *-1
							_nTotUsrINSS	+= (TRB2->VLRBPFPCS *_nMultINSS)*-1
							
							_nTotValor += TRB2->VLRBPFPCS*-1
							_nTotTaxa  += TRB2->VLRTADPCS*-1
							_nTotINSS  += (TRB2->VLRBPFPCS *_nMultINSS)*-1
							
						ElseIf (TRB2->DifB <> 0 .OR. TRB2->DifT <> 0 .OR. TRB2->DifTOT <> 0)
							                 
							cStsPeg :='COBRAN./ACERTO'
				//			@ nLi, 010 PSAY TRB2->statuspeg + ' - ' +  Transform((TRB2->DifB),"@E 999,999.99") + ' - ' +  Transform((TRB2->DifT),"@E 999,999.99") 
                            @ nLi, 010 PSAY cStsPeg + ' - ' +  Transform((TRB2->DifB),"@E 999,999.99") + ' - ' +  Transform((TRB2->DifT),"@E 999,999.99")							
							
							
							@ nLi, 176 PSAY Transform((TRB2->DifB ),"@E 999,999.99")
							@ nLi, 191 PSAY Transform((TRB2->DifT ),"@E 999,999.99")
							@ nLi, 204 PSAY Transform(((TRB2->DifB)*_nMultINSS),"@E 999,999.99")  //INSS (cfme regra Caberj - Marcela - somente cobra de PF.)
							
							_VLRTADT:=  TRB2->DifT
							_VLRbPFT:=  TRB2->DifB
							_VLRINST:=  TRB2->((BD6_VLRTPF-BD6_VLRTAD)+(TRB2->DifB+TRB2->DifT))*_nMultINSS - TRB2->(BD6_VLRTPF-BD6_VLRTAD)*_nMultINSS
							
							_nTotUsrValor	+= TRB2->DifB
							_nTotUsrTaxa	+= TRB2->DifT
							_nTotUsrINSS	+= TRB2->((BD6_VLRTPF-BD6_VLRTAD)+(TRB2->DifB+TRB2->DifT))*_nMultINSS - TRB2->(BD6_VLRTPF-BD6_VLRTAD)*_nMultINSS
							
							_nTotValor += TRB2->DifB
							_nTotTaxa  += TRB2->DifT
							_nTotINSS  += TRB2->((BD6_VLRTPF-BD6_VLRTAD)+(TRB2->DifB+TRB2->DifT))*_nMultINSS - TRB2->(BD6_VLRTPF-BD6_VLRTAD)*_nMultINSS
							
						Else
							
							@ nLi, 176 PSAY Transform(TRB2->(BD6_VLRTPF-BD6_VLRTAD),"@E 999,999.99")
							@ nLi, 191 PSAY Transform(TRB2->(BD6_VLRTAD),"@E 999,999.99")
							@ nLi, 204 PSAY Transform((TRB2->(BD6_VLRTPF-BD6_VLRTAD)*_nMultINSS),"@E 999,999.99") //INSS (cfme regra Caberj - Marcela - somente cobra de PF.)
							
							_VLRTADT:=  0.00
							_VLRBPFT:=  0.00
							_VLRINST:=  0.00
							
							_nTotUsrValor += TRB2->(BD6_VLRTPF-BD6_VLRTAD) + _VLRBPFT
							_nTotUsrTaxa  += TRB2->(BD6_VLRTAD) + _VLRTADT
							_nTotUsrINSS  += (TRB2->(BD6_VLRTPF-BD6_VLRTAD)*_nMultINSS) + _VLRINST
							
							_nTotValor += TRB2->(BD6_VLRTPF-BD6_VLRTAD) + _VLRBPFT
							_nTotTaxa  += TRB2->(BD6_VLRTAD) + _VLRTADT
							_nTotINSS  += (TRB2->(BD6_VLRTPF-BD6_VLRTAD)*_nMultINSS) + _VLRINST
							
						EndIf
						//@ nLi, 198 PSAY Transform(TRB2->(BD6_VLRTPF-BD6_VLRTAD)*0.2,"@E 999,999.99") //INSS (cfme regra Caberj - Marcela - somente cobra de PF.)
						cMatImpAnt := TRB2->(BD6_CODOPE+BD6_CODEMP+BD6_MATRIC+BD6_TIPREG+BD6_DIGITO)
						
						
						
						If cFazFec == 1 .and.(trim(TRB2->statuspeg)) != 'Ok'  .AND. TRB2->PCSRECNO != 0
							//			If (trim(TRB2->statuspeg)) != 'Ok'  .AND. TRB2->PCSRECNO != 0
							
							FGrvContr( TRB2->PCSRECNO , (trim(TRB2->statuspeg))  )
							
						EndIf
						
						//			fMarcPcs((trim(TRB2->statuspeg)) futura implemnetação
						
						//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
						//³ 12/2/08: Conforme solicitado pelo finenceiro, somar³
						//³ o valor por usuario para totalizacao individual... ³
						//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
						
						_VLRTADTOT+= _VLRTADT
						_VLRBPFTOT+= _VLRBPFT
						_VLRINSTOT+= _VLRINST
						
						_VLRTADT:=  0.00
						_VLRBPFT:=  0.00
						_VLRINST:=  0.00
						
						nLi ++
						TRB2->( dbSkip() )
						lImprimiu := .T.
						
						VldPag()
						
					Enddo
					
					
					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³ 12/2/08: Imprime o ultimo totalizador por usuario. ³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					If !Empty(cMatImpAnt)
						//Imprime totalizador somatorio / batimento de valores...
						@ nLi, 076 PSAY Replicate('-',139)
						nLi+=2
						@ nLi, 176 PSAY Transform(_nTotUsrValor,"@E 999,999.99")
						@ nLi, 191 PSAY Transform(_nTotUsrTaxa,"@E 999,999.99")
						@ nLi, 204 PSAY Transform(_nTotUsrINSS,"@E 999,999.99")
						nLi++
					Endif
					
					//Imprime totalizador somatorio / batimento de valores...
					@ nLi, 000 PSAY Replicate('-',215)
					nLi++
					@ nLi, 176 PSAY Transform(_nTotValor,"@E 999,999.99")
					@ nLi, 191 PSAY Transform(_nTotTaxa,"@E 999,999.99")
					@ nLi, 204 PSAY Transform(_nTotINSS,"@E 999,999.99")
					nLi ++
					
					If lImprimiu
						nLi++
					Endif
					TRB2->( dbClosearea() )
				Elseif lCri
					BTG->( dbSetorder(02) )
					If BTG->( dbSeek(xFilial("BTG")+TRB1->(BTF_CODOPE+BTF_NUMERO+BTO_SEQUEN)) )
						cNumCob := TRB1->BTF_NUMERO
						cSequen := TRB1->BTO_SEQUEN
						
						While !BTG->( Eof() ) .and. BTG->BTG_NUMERO == cNumCob .and. BTG->BTG_SEQUEN == cSequen
							@ nLi, 007 PSAY BTG->BTG_CODCRI+" - "+Posicione("SX5",1,xFilial("SX5")+"BI"+BTG->BTG_CODCRI,"X5_DESCRI")
							
							BTG->( dbSkip() )
							lImprimiu := .T.
							nLi++
						Enddo
						If lImprimiu
							nLi++
						Endif
					Endif
				Endif
			Endif
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
			
			TRB1->(DbSkip())
		Enddo
		@ nLi, 082 PSAY "Valor "
		@ nLi, 111 PSAY "Taxa "
		
		@ nLi, 126 PSAY "Inss "
		
		@ nLi, 150 PSAY "Total "
		nLi++
		@ nLi, 067 PSAY Replicate('-', 88); nLi++
		@ nLi, 037 PSAY "TOTAIS ---> "
		//@ nLi, 053 PSAY StrZero(nQTDEVE, 5)
		
		//@ nLi, 059 PSAY Transform(nVLRCOP,"@E 99,999,999.99")
		
		//		@ nLi, 074 PSAY Transform(((nVLRCOP+nVLRCP2+nVLRCP3) - _VLRBPF ),"@E 99,999,999.99")
		@ nLi, 074 PSAY Transform((_nTotValor),"@E 99,999,999.99")
		/*
		If BTO->( FieldPos("BTO_VLRCP3") ) > 0
		@ nLi, 090 PSAY Transform(nVLRCP3,"@E 99,999,999.99")
		Endif
		*/
		//		@ nLi, 103 PSAY Transform((nVLRTAX -   _VLRTAD),"@E 99,999,999.99")
		@ nLi, 103 PSAY Transform((_nTotTaxa),"@E 99,999,999.99")
		//	@ nLi, 118 PSAY Transform((nCUSTOT - ( _VLRBPF + _VLRTAD) ),"@E 99,999,999.99")
		@ nLi, 118 PSAY Transform(( _nTotINSS ),"@E 99,999,999.99")
		
		@ nLi, 142 PSAY Transform((_nTotValor+_nTotTaxa+_nTotINSS),"@E 99,999,999.99")
		
		arettit:= {cOPEORI ,cTitse1,_nTotValor,_nTotTaxa,_nTotINSS, mv_par03 , mv_par08, mv_par09 , mv_par10, mv_par11 , mv_par12, mv_par13 , mv_par14, mv_par15 , mv_par16}
		
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
		
		_VLRTADTOT:= 0
		_VLRBPFTOT:= 0
		_VLRINSTOT:= 0
		
	Enddo
	@ nLi, 000 PSAY Replicate('-',155)
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

Return( arettit )

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

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ValidPerg º Autor ³ Jose Carlos Noronhaº Data ³ 01/08/07    º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Parametros para selecao dos titulos do PLS                 º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³                                                            º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ValidPerg1()

PutSx1(cPerg1,"01","Operadora de ?    "  ,"","","mv_ch01","C",04,0,0,"G","","mv_par01","","","","","","","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "9999", "" )
PutSx1(cPerg1,"02","Operadora Ate?    "  ,"","","mv_ch02","C",04,0,0,"G","","mv_par02","","","","","","","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "9999", "" )
PutSx1(cPerg1,"03","Lote Int Event.De?"  ,"","","mv_ch03","C",08,0,0,"G","","mv_par03","","","","","","","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "", "" )
PutSx1(cPerg1,"04","Lote Int Event.Ate?" ,"","","mv_ch04","C",08,0,0,"G","","mv_par04","","","","","","","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "", "" )
PutSx1(cPerg1,"05","Ope Origem De ?   "  ,"","","mv_ch05","C",04,0,0,"G","","mv_par05","","","","","","","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "9999", "" )
PutSx1(cPerg1,"06","Ope Origem Ate ?  "  ,"","","mv_ch06","C",04,0,0,"G","","mv_par06","","","","","","","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "9999", "" )

PutSx1(cPerg1,"07","Modelo  ?"           ,"","","mv_ch07","N",01,0,0,"C","","","","","mv_par07","Analitico","","","","resumido","","","Sintetico","","","","","","","","","","","","","","","","","" , "" , "" , "", "", "" )
PutSx1(cPerg1,"08","Faz Criticas ?"      ,"","","mv_ch08","N",01,0,0,"C","","","","","mv_par08","Sim","","","","Não","","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "", "" )


PutSx1(cPerg1,"09",OemToAnsi("Critíca Vlr Tot  Part"   )  ,"","","mv_ch09","N",01,0,0,"C","","","","","mv_par09","À Maior ","","","","À Menor","","","Não Critica","","","Critica Tot","","","","","",{},{},{})
PutSx1(cPerg1,"10",OemToAnsi("Critíca Vlr Base Part"   )  ,"","","mv_ch10","N",01,0,0,"C","","","","","mv_par10","À Maior ","","","","À Menor","","","Não Critica","","","Critica Tot","","","","","",{},{},{})
PutSx1(cPerg1,"11",OemToAnsi("Critíca Vlr Taxa Part"   )  ,"","","mv_ch11","N",01,0,0,"C","","","","","mv_par11","À Maior ","","","","À Menor","","","Não Critica","","","Critica Tot","","","","","",{},{},{})

PutSx1(cPerg1,"12",OemToAnsi("Critíca Fase 3       "   )  ,"","","mv_ch12","N",01,0,0,"C","","","","","mv_par12","Sim ","","","","Não ","","","","","","","","","","","",{},{},{})
PutSx1(cPerg1,"13",OemToAnsi("Critíca Fase Ant 3   "   )  ,"","","mv_ch13","N",01,0,0,"C","","","","","mv_par13","Sim ","","","","Não ","","","","","","","","","","","",{},{},{})

PutSx1(cPerg1,"14",OemToAnsi("Critíca Faturad      "   )  ,"","","mv_ch14","N",01,0,0,"C","","","","","mv_par14","Sim ","","","","Não ","","","","","","","","","","","",{},{},{})
PutSx1(cPerg1,"15",OemToAnsi("Critíca Bloq Faturad "   )  ,"","","mv_ch15","N",01,0,0,"C","","","","","mv_par15","Sim ","","","","Não ","","","","","","","","","","","",{},{},{})

PutSx1(cPerg1,"16",OemToAnsi("Faz Conciliação      "   )  ,"","","mv_ch16","N",01,0,0,"C","","","","","mv_par16","Sim ","","","","Não ","","","","","","","","","","","",{},{},{})
PutSx1(cPerg1,"17",OemToAnsi("Mostrar Titulo COV   "   )  ,"","","mv_ch17","N",01,0,0,"C","","","","","mv_par17","Sim ","","","","Não ","","","","","","","","","","","",{},{},{})
PutSx1(cPerg1,"18",OemToAnsi("Mostrar Lanc. Duplic "   )  ,"","","mv_ch18","N",01,0,0,"C","","","","","mv_par18","Sim ","","","","Não ","","","","","","","","","","","",{},{},{})

PutSx1(cPerg1,"19",OemToAnsi("Consid Duplic F/ Compet" )  ,"","","mv_ch19","N",01,0,0,"C","","","","","mv_par19","Sim ","","","","Não ","","","","","","","","","","","",{},{},{})

Pergunte(cPerg1,.F.)

Return(.T.)



/////////////////////////////////////////////////////////////////


Static Function FGrvContr( nReg , sts  )


If   ((trim(TRB2->statuspeg) == 'Delet. PLS' ) .or. (trim(TRB2->statuspeg) == 'Não Exist PLS' ) ;
	.or. (trim(TRB2->statuspeg) == 'G. Bloq Cob') .or. (trim(TRB2->statuspeg) == 'G. Não Ativa'  ))
	
	DbSelectArea("PCS")
	dbgoto(nReg)
	
	PCS->(RecLock("PCS",.F.))
	PCS->PCS_LCFEC := 22
	PCS->(MsUnlock())
	
EndIf
/*
If (trim(TRB2->statuspeg) == 'G. Não Paga') .or.  (trim(TRB2->statuspeg) == 'G. Não Cobrd'  )

If  TRB2->DifTOT > 0
If  TRB2->DifB > 0
If  TRB2->DifT > 0

If (trim(TRB2->statuspeg) == 'G. Fase 1 ou 2')

If  TRB2->DifTOT > 0
If  TRB2->DifB > 0
If  TRB2->DifT > 0

If (trim(TRB2->statuspeg) == 'Div Vlr Cobrd'
If (trim(TRB2->statuspeg) == 'Div Vlr Pagto'
If (trim(TRB2->statuspeg) == 'Div Vlr Taxa'

*/

Return()

Static Function FGrvPlan(cOperadora,cComp )

local ix := 0
cNomeArq := "C:\TEMP\"+trim(cOperadora)+'_'+cComp+DtoS(date())+"_"+STRTRAN(TIME(),":","")+".csv"
// cNomeArq := "\LOGCOBCONV\"+trim(cOperadora)+'_'+cComp+DtoS(date())+"_"+STRTRAN(TIME(),":","")+".csv"
nHandle := FCREATE(cNomeArq)

cMontaTxt := 'Empresa  : '+ trim(cOperadora)
cMontaTxt += CRLF
FWrite(nHandle,cMontaTxt)

cMontaTxt := 'Ação  : Log de Cobrança Final'
cMontaTxt += CRLF
FWrite(nHandle,cMontaTxt)

cMontaTxt := 'Usuario : '+SubStr(cUSUARIO,1,15)
cMontaTxt += CRLF
FWrite(nHandle,cMontaTxt)
cMontaTxt := "BD6_CODOPE  ;"
cMontaTxt += "BD6_CODEMP  ;"
cMontaTxt += "BD6_MATRIC ;"
cMontaTxt += "BD6_TIPREG ;"
cMontaTxt += "BD6_DIGITO ;"
cMontaTxt += "BD6_DATPRO ;"
cMontaTxt += "BD6_NOMUSR ;"
cMontaTxt += "BD6_CODRDA ;"
cMontaTxt += "BD6_NOMRDA ;"
cMontaTxt += "BD6_DESPRO ;"
cMontaTxt += "BD6_VLRTPF ;"
cMontaTxt += "BD6_VLRBPF ;"
cMontaTxt += "BD6_VLRTAD ;"
cMontaTxt += "BD6_NUMIMP ;"
cMontaTxt += "BD6_CODOPE ;"
cMontaTxt += "BD6_CODLDP ;"
cMontaTxt += "BD6_CODPEG ;"
cMontaTxt += "BD6_NUMERO ;"
cMontaTxt += "BD6_ORIMOV ;"
cMontaTxt += "BD6_SEQUEN ;"
cMontaTxt += "BD6_CODPRO ;"
cMontaTxt += "BA1_YMTREP ;"
cMontaTxt += "BAU_CODIGO ;"
cMontaTxt += "BAU_TIPPE  ;"
cMontaTxt += "BAU_NOME   ;"
cMontaTxt += "VLRTPFPCS  ;"
cMontaTxt += "VLRBPFPCS  ;"
cMontaTxt += "VLRTADPCS  ;"
cMontaTxt += "statuspeg  ;"
cMontaTxt += "DifB       ;"
cMontaTxt += "DifT       ;"
cMontaTxt += "DifTOT     ;"
cMontaTxt += CRLF // Salto de linha para .csv (excel)

FWrite(nHandle,cMontaTxt)


//	    TRB2->( dbGotop() )


For ix := 1 To Len(aDados)
	//    cMontaTxt := aDados[ix,01] + ";"
	cMontaTxt := aDados[ix,02] + ";"
	cMontaTxt += aDados[ix,03] + ";"
	cMontaTxt += aDados[ix,04] + ";"
	cMontaTxt += aDados[ix,05] + ";"
	cMontaTxt += aDados[ix,06] + ";"
	cMontaTxt += aDados[ix,07] + ";"
	cMontaTxt += aDados[ix,08] + ";"
	cMontaTxt += aDados[ix,09] + ";"
	cMontaTxt += aDados[ix,10] + ";"
	cMontaTxt += aDados[ix,11] + ";"
	cMontaTxt += aDados[ix,12] + ";"
	cMontaTxt += aDados[ix,13] + ";"
	cMontaTxt += aDados[ix,14] + ";"
	cMontaTxt += aDados[ix,15] + ";"
	cMontaTxt += aDados[ix,16] + ";"
	cMontaTxt += aDados[ix,17] + ";"
	cMontaTxt += aDados[ix,18] + ";"
	cMontaTxt += aDados[ix,19] + ";"
	cMontaTxt += aDados[ix,20] + ";"
	cMontaTxt += aDados[ix,21] + ";"
	cMontaTxt += aDados[ix,22] + ";"
	cMontaTxt += aDados[ix,23] + ";"
	cMontaTxt += aDados[ix,24] + ";"
	cMontaTxt += aDados[ix,25] + ";"
	cMontaTxt += aDados[ix,26] + ";"
	cMontaTxt += aDados[ix,27] + ";"
	cMontaTxt += aDados[ix,28] + ";"
	cMontaTxt += aDados[ix,29] + ";"
	cMontaTxt += aDados[ix,30] + ";
	cMontaTxt += aDados[ix,31] + ";"
	cMontaTxt += aDados[ix,32] + ";"
	cMontaTxt += aDados[ix,33] + ";"
	cMontaTxt += CRLF // Salto de linha para .csv (excel)
	
	FWrite(nHandle,cMontaTxt)
	
next
//		  TRB2->( dbSkip() )


//      EndDo

If nHandle > 0
	
	// encerra gravação no arquivo
	FClose(nHandle)
	//	cNomeArq1+= cNomeArq + CRLF
	MsgAlert("Relatorio salvo em: "+cNomeArq)
	
	//	fEnvEmail(cNomeArq , cEmpresa , trim(aDados[1,1]) )
EndIf

Return()


static Function fGeraVet()


While !TRB2->( Eof() )
	
	aAdd(aDados1,{ .T. ,;
	TRB2->BD6_CODOPE , ;
	TRB2->BD6_CODEMP , ;
	TRB2->BD6_MATRIC , ;
	TRB2->BD6_TIPREG , ;
	TRB2->BD6_DIGITO , ;
	dtos(TRB2->BD6_DATPRO) , ;
	TRB2->BD6_NOMUSR , ;
	TRB2->BD6_CODRDA , ;
	TRB2->BD6_NOMRDA , ;
	TRB2->BD6_DESPRO , ;
	TRB2->BD6_VLRTPF , ;
	TRB2->BD6_VLRBPF , ;
	TRB2->BD6_VLRTAD , ;
	TRB2->BD6_NUMIMP , ;
	TRB2->BD6_CODOPE , ;
	TRB2->BD6_CODLDP , ;
	TRB2->BD6_CODPEG , ;
	TRB2->BD6_NUMERO , ;
	TRB2->BD6_ORIMOV , ;
	TRB2->BD6_SEQUEN , ;
	TRB2->BD6_CODPRO , ;
	TRB2->BA1_YMTREP , ;
	TRB2->BAU_CODIGO , ;
	TRB2->BAU_TIPPE  , ;
	TRB2->BAU_NOME   , ;
	TRB2->VLRTPFPCS , ;
	TRB2->VLRBPFPCS , ;
	TRB2->VLRTADPCS , ;
	TRB2->statuspeg  , ;
	TRB2->DifB  , ;
	TRB2->DifT , ;
	TRB2->DifTOT })
	
	

	aAdd(aDados,{ .T. ,;
	TRB2->BD6_CODOPE , ;
	TRB2->BD6_CODEMP , ;
	TRB2->BD6_MATRIC , ;
	TRB2->BD6_TIPREG , ;
	TRB2->BD6_DIGITO , ;
	dtos(TRB2->BD6_DATPRO) , ;
	TRB2->BD6_NOMUSR , ;
	TRB2->BD6_CODRDA , ;
	TRB2->BD6_NOMRDA , ;
	TRB2->BD6_DESPRO , ;
	Transform((TRB2->BD6_VLRTPF),"@E 99,999,999.99") , ;
	Transform((TRB2->BD6_VLRBPF),"@E 99,999,999.99") , ;
	Transform((TRB2->BD6_VLRTAD),"@E 99,999,999.99") , ;
	TRB2->BD6_NUMIMP , ;
	TRB2->BD6_CODOPE , ;
	TRB2->BD6_CODLDP , ;
	TRB2->BD6_CODPEG , ;
	TRB2->BD6_NUMERO , ;
	TRB2->BD6_ORIMOV , ;
	TRB2->BD6_SEQUEN , ;
	TRB2->BD6_CODPRO , ;
	TRB2->BA1_YMTREP , ;
	TRB2->BAU_CODIGO , ;
	TRB2->BAU_TIPPE  , ;
	TRB2->BAU_NOME   , ;
	Transform((TRB2->VLRTPFPCS),"@E 99,999,999.99") , ;
	Transform((TRB2->VLRBPFPCS),"@E 99,999,999.99") , ;
	Transform((TRB2->VLRTADPCS),"@E 99,999,999.99") , ;
	TRB2->statuspeg  , ;
	Transform((TRB2->DifB),"@E 99,999,999.99")  , ;
	Transform((TRB2->DifT),"@E 99,999,999.99")  , ;
	Transform((TRB2->DifTOT),"@E 99,999,999.99")})
	
	TRB2->( dbSkip() )
	
EndDo

Return()




/////////////////////////////////////////////
/* escolha da linha que comporam acobranla */
/////////////////////////////////////////////

static Function fVerLinha( )

local cRda      := ' '
local cNivel    := ' '
local nI := 0

//Private aBrwPEG   :=  adados
//                        1     30      8               7         10     11                28          29          27         13           14         12          31     32       33
Private aCabPEG1		:= { " ","Critica","Usuario " ,"Dt Proced" ,"Rda ","Procedimento "  ,"Vl B Ant","Vl Tx Ant","Vl T Ant","Vl B Atu ","Vl Tx Atu","Vl T Atu ","DifB ","DifT  ","DifTOT"}
Private aTamPEG1		:= { 10, 25       ,40         ,15          ,40    ,40               ,35         , 35       ,35         ,35         ,35         ,35         ,35    ,35       ,35     }

Private oOk      	:= LoadBitMap(GetResources(),"LBOK")
Private oNo      	:= LoadBitMap(GetResources(),"LBNO")

Private aObjects 	:= {}

Private aSizeAut 	:= MsAdvSize()

Private cUsuario:= SubStr(cUSUARIO,7,15)
//private cDthr   := STR(dtos(DATE()) + "-" + Time())

private lsair := .F.
private lConf:= .F.

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³MsAdvSize()                          ³
//³-------------------------------------³
//³1 -> Linha inicial area trabalho.    ³
//³2 -> Coluna inicial area trabalho.   ³
//³3 -> Linha final area trabalho.      ³
//³4 -> Coluna final area trabalho.     ³
//³5 -> Coluna final dialog (janela).   ³
//³6 -> Linha final dialog (janela).    ³
//³7 -> Linha inicial dialog (janela).  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

lAjustHor	:= .T.
lAjustVert 	:= .F.

aAdd( aObjects, { 130,  260, lAjustHor, lAjustVert } )
//aAdd( aObjects, { 130,  250, lAjustHor, lAjustVert } )
//aAdd( aObjects, { 130,  250, lAjustHor, lAjustVert } )

nSepHoriz   := 5
nSepVert    := 5
nSepBorHor 	:= 5
nSepBorVert	:= 5

aInfo  		:= { aSizeAut[ 1 ], aSizeAut[ 2 ], aSizeAut[ 3 ], aSizeAut[ 4 ], nSepHoriz, nSepVert, nSepBorHor, nSepBorVert }
aPosObj 	:= MsObjSize( aInfo, aObjects, .T. )

oDlg10 		:= MsDialog():New( aSizeAut[7],00,aSizeAut[3]-100,aSizeAut[5]-10,"Desmarque as Linha que NÃO deseja considerar no fechamento ... ",,,.F.,,,,,,.T.,,,.T. )

oSayPEG    	:= TSay():New( aPosObj[1][1],aPosObj[1][2],{||'Guias Selecionadas ....  '},oDlg10,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,236,016)

bDbClickP	:= {|| adados[oBrwPEG1:nAt,1] := !adados[oBrwPEG1:nAt,1]  ,oBrwPEG1:Refresh()}

oBrwPEG1 	:= TcBrowse():New(aPosObj[1][1]+10,aPosObj[1][2],aPosObj[1][4],aPosObj[1][3],,aCabPEG1,aTamPEG1,oDlg10,,,,,bDbClickP,,,,,,,.F.,,.T.,,.F.,,, )

oBrwPEG1:SetArray(adados)

oBrwPEG1:bLine := {||{If( adados[oBrwPEG1:nAt,1],oOk,oNo) ,;
					   	  adados[oBrwPEG1:nAt,30]		  ,;
						  substr(adados[oBrwPEG1:nAt,8],1,30)  ,;
						  substr(adados[oBrwPEG1:nAt,7],7,2)+'/'+substr(adados[oBrwPEG1:nAt,7],5,2)+'/'+substr(adados[oBrwPEG1:nAt,7],1,4) ,;
						  substr(adados[oBrwPEG1:nAt,10],1,30) ,;
						  substr(adados[oBrwPEG1:nAt,11],1,30) ,;
						  adados[oBrwPEG1:nAt,28] ,;
						  adados[oBrwPEG1:nAt,29] ,;
						  adados[oBrwPEG1:nAt,27] ,;
						  adados[oBrwPEG1:nAt,13] ,;
						  adados[oBrwPEG1:nAt,14] ,;
						  adados[oBrwPEG1:nAt,12] ,;
						  adados[oBrwPEG1:nAt,31] ,;
						  adados[oBrwPEG1:nAt,32] ,;
						  adados[oBrwPEG1:nAt,33] }}
							
oBrwPEG1:nScrollType  := 1 // Scroll VCR

lConf 	:= .T.

aBut    := {"PENDENTE", {||marca1()     ,oBrwPEG1:Refresh()   }	, "Marcar Todos "       , "Marcar Todos"     } 
aAdd(aBut, {"PENDENTE", {||desmarca1()  ,oBrwPEG1:Refresh()   }	, "DesMarcar Todos "	, "DesMarcar Todos"	 } )
aAdd(aBut, {"PENDENTE", {||lsair:= .T. , oDlg10:End()        }	, "Sair "   	        , "Sair"             } )

lConf    := .F.

bOk 	:= { oDlg10:End()   }

bCancel := {||lConf := .F.,oDlg10:End()}

//oDlg10:Activate(,,,.T.,,,EnchoiceBar(oDlg10,bOk,bCancel,,aBut))          

oDlg10:Activate(,,,.T.,,,)

If lConf    == .T.
   a:= 'a'
EndIf 
   
MsgInfo("Processo finalizado")

Return()


************************************************************************************

************************************************************************************
Static Function marca1()

local nI

	For nI := 1 to len(aBrwPEG1)
		
		aBrwPEG1[nI,1]:= .T.
		
	Next

RETURN()


Static Function desmarca1()

local nI
	
	For nI := 1 to len(aBrwPEG1)
		
		aBrwPEG1[nI,1]:= .F.
		
	Next

RETURN()

