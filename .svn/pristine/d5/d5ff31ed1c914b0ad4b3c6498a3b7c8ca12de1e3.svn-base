#include "plsr266.ch"
#include "protheus.ch"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±±
±±³Funcao    ³ PLSR266 ³ Autor ³ Sandro Hoffman Lopes   ³ Data ³ 26.06.06 ³±±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±±
±±³Descricao ³ Lista relatorio das Empresas/Familias que nao foram        ³±±±
±±³          ³ faturadas em determinada competencia (Mes/Ano)             ³±±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±±
±±³Sintaxe   ³ PLSR266()                                                  ³±±±
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
*/
User Function U_PLSR266

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracao de Variaveis                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local cDesc1        := STR0001 //"Este programa tem como objetivo imprimir relatorio "
Local cDesc2        := STR0002 //"de Empresas/Familias que nao foram faturadas em"
Local cDesc3        := STR0003 //"determinada competencia (Mes/Ano)."
Local cPict         := ""
Local titulo        := STR0004 //"RELACAO EMPRESAS/FAMILIAS NAO FATURADAS"
Local nLin          := 80
Local Cabec1        := STR0005 //"               MATRICULA                NOME DO USUARIO                                                       VENCTO  GRP COBR"
Local Cabec2        := ""
Local imprime       := .T.
Local aOrd          := {}

Private lEnd        := .F.
Private lAbortPrint := .F.
Private CbTxt       := ""
Private limite      := 132
Private tamanho     := "M"
Private nomeprog    := "PLSR266"
Private nTipo       := 15
Private aReturn     := { STR0010, 1, STR0011, 1, 2, 1, "", 1} //"Zebrado"###"Administracao"
Private nLastKey    := 0
Private cPerg       := "PLR266"
Private cbcont      := 00
Private CONTFL      := 01
Private m_pag       := 01
Private wnrel       := "PLSR266"
Private lCompres    := .T.
Private lDicion     := .F.
Private lFiltro     := .F.
Private lCrystal    := .F.
Private cString     := "BA3"
Private nTotVid     := 0

fCriaSX1(cPerg)
Pergunte(cPerg,.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta a interface padrao com o usuario...                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
wnrel:=  SetPrint(cString,NomeProg,cPerg,@Titulo,cDesc1,cDesc2,cDesc3,lDicion,aOrd,lCompres,Tamanho,{},lFiltro,lCrystal)

If nLastKey == 27
	Return
Endif

SetDefault(aReturn,cString)

If nLastKey == 27
   Return
Endif

Titulo := AllTrim(Titulo) + STR0009 + mv_par03 + "/" + mv_par02

nTipo := If(aReturn[4]==1,15,18)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Emite relat¢rio                                                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
MsAguarde({|| R266Imp(Cabec1,Cabec2,Titulo,nLin) }, Titulo, "", .T.)

Roda(0,"","M")

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Finaliza a execucao do relatorio...                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

SET DEVICE TO SCREEN

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Se impressao em disco, chama o gerenciador de impressao...          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

If aReturn[5]==1
   dbCommitAll()
   SET PRINTER TO
   OurSpool(wnrel)
Endif

MS_FLUSH()

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³R266Imp    ³ Autor ³ Sandro Hoffman Lopes  ³ Data ³ 26/06/06³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³Imprime relatorio para conferencia dos valores gerados no   ³±±
±±³          ³arquivo de pagamento da RDA.                                ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function R266Imp(Cabec1,Cabec2,Titulo,nLin)

	Local cSql
	Local cTipo
	Local cAno
	Local cMes
	Local lListUsu
	Local cCodIntDe
	Local cCodIntAte
	Local cCodEmpDe
	Local cCodEmpAte
	Local cConEmpDe
	Local cConEmpAte
	Local cVerConDe
	Local cVerConAte
	Local cSubConDe
	Local cSubConAte
	Local cVerSubDe
	Local cVerSubAte
	Local cMatricDe
	Local cMatricAte
	Local cGrpCobDe
	Local cGrpCobAte
	Local lBloquea //Gedilson
	Local cCodEmp
	Local cConEmp
	Local cVerCon
	Local cSubCon
	Local cVerSub
	Local i
	Local lImpBG9
	Local lImpBT5
	Local lImpBQC
	Local aUsuarios

	cTipo      := Str(mv_par01, 1)
	cAno       := mv_par02
	cMes       := mv_par03
	lListUsu   := (mv_par04 == 1)
	cCodIntDe  := mv_par05
	cCodIntAte := mv_par06
	cCodEmpDe  := mv_par07
	cCodEmpAte := mv_par08
	cConEmpDe  := mv_par09
	cConEmpAte := mv_par10
	cVerConDe  := mv_par11
	cVerConAte := mv_par12
	cSubConDe  := mv_par13
	cSubConAte := mv_par14
	cVerSubDe  := mv_par15
	cVerSubAte := mv_par16
	cMatricDe  := mv_par17
	cMatricAte := mv_par18
	cGrpCobDe  := mv_par19
	cGrpCobAte := mv_par20
	lBloquea   := (mv_par21  == 1)  //Gedilson

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Inicia a montagem da query principal para selecionar as familias... ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ	
	cSql := "SELECT BA3_MODPAG, BA3_CODINT, BA3_COBNIV, BA3_VENCTO, BA3_CODEMP, BA3_CONEMP, BA3_VERCON, "
	cSql += "       BA3_SUBCON, BA3_VERSUB, BA3_MATRIC, BA3_GRPCOB, BA3_TIPOUS, " + RetSqlName("BA3")+".R_E_C_N_O_ BA3REC,"
	cSql += "       BG9_VENCTO, " + RetSqlName("BG9")+".R_E_C_N_O_ BG9REC "

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Campos utilizados quando eh pessoa juridica...                           ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If cTipo == "2"
		cSql += ", BT5_COBNIV, BT5_VENCTO, " + RetSqlName("BT5")+".R_E_C_N_O_ BT5REC, "
		cSql += "  BQC_COBNIV, BQC_VENCTO, BQC_GRPCOB, " + RetSqlName("BQC")+".R_E_C_N_O_ BQCREC "
	EndIf

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Tabelas de uso geral... pessoa fisica/juridica                           ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ		                                             
	cSql += "FROM " + RetSqlName("BA3") + ", " + RetSqlName("BG9")

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Tabelas de uso exclusivo para pessoa juridica...                         ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ	     
	If cTipo == "2"
		cSql += ", " + RetSqlName("BT5") + ", " + RetSqlName("BQC")
	EndIf

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Inicializa montagem do filtro...                                         ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ			
    cSql += " WHERE BA3_FILIAL = '" + xFilial("BA3") + "' "
	cSql += "   AND BG9_FILIAL = '" + xFilial("BG9") + "' "

	If cTipo == "2"
		cSql += "AND BT5_FILIAL = '" + xFilial("BT5") + "' "	
		cSql += "AND BQC_FILIAL = '" + xFilial("BQC") + "' "		
	EndIf

	cSql += "   AND BA3_CODEMP = BG9_CODIGO "
	cSql += "   AND BA3_CODINT = BG9_CODINT "

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Filtro para pessoa juridica...                                           ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ					
	If cTipo == "2"	
		cSql += "AND BA3_CODINT = BT5_CODINT "
		cSql += "AND BA3_CODEMP = BT5_CODIGO "
		cSql += "AND BA3_CONEMP = BT5_NUMCON "
		cSql += "AND BA3_VERCON = BT5_VERSAO "
		
		cSql += "AND BA3_CODINT+BA3_CODEMP = BQC_CODIGO  "
		cSql += "AND BA3_CONEMP = BQC_NUMCON "
		cSql += "AND BA3_VERCON = BQC_VERCON "
		cSql += "AND BA3_SUBCON = BQC_SUBCON "
		cSql += "AND BA3_VERSUB = BQC_VERSUB "
		cSql += "AND " + RetSqlName("BT5") + ".D_E_L_E_T_ = ' ' "
		cSql += "AND " + RetSqlName("BQC") + ".D_E_L_E_T_ = ' ' "
	EndIf	

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Uso geral                                                                ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ			
    If lBloquea 
    	cSql += "AND BA3_DATBLO <> '' "
	Else
		cSql += "AND BA3_DATBLO = '' "
    EndIf

	cSql += "   AND " + RetSqlName("BA3") + ".D_E_L_E_T_ = ' ' "
	cSql += "   AND " + RetSqlName("BG9") + ".D_E_L_E_T_ = ' ' "

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Se for informado empresa...    			                            ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ	
	If ! Empty(cCodEmpAte)
		cSql += "AND BA3_CODEMP >= '" + cCodEmpDe + "' AND BA3_CODEMP <= '" + cCodEmpAte + "' "
	Endif

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Filtro para pessoa juridica...                                           ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ					
	If cTipo == "2"
		cSql += "AND BA3_TIPOUS = '2' "
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Se for informado contrato...   			                            ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ		
		If ! Empty(cConEmpAte + cVerConAte)
			cSql += "AND (BA3_CONEMP >= '" + cConEmpDe  + "' AND BA3_VERCON >= '" + cVerConDe  + "') AND "
			cSql += "    (BA3_CONEMP <= '" + cConEmpAte + "' AND BA3_VERCON <= '" + cVerConAte + "') "
		Endif
			                                 
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Se for informado sub contrato...    	                            ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ		
		If ! Empty(cSubConAte+cVerSubAte)
			cSql += "AND (BA3_SUBCON >= '" + cSubConDe  + "' AND BA3_VERSUB >= '" + cVerSubDe  + "') AND "
			cSql += "    (BA3_SUBCON <= '" + cSubConAte + "' AND BA3_VERSUB <= '" + cVerSubAte + "') "
		Endif                          
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Filtra por grupo de cobranca...			                            ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If !Empty(cGrpCobAte)
			cSql += "AND (((BQC_GRPCOB >= '" + cGrpCobDe + "' AND BQC_GRPCOB <= '" + cGrpCobAte + "') AND BA3_COBNIV <> '1' ) OR "
			cSql += "     ((BA3_GRPCOB >= '" + cGrpCobDe + "' AND BA3_GRPCOB <= '" + cGrpCobAte + "') AND BA3_COBNIV =  '1' ))"
		EndIf
	ElseIf cTipo == "1"
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Filtra exclusivo para pessoa fisica...                              ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ	
		cSql += " AND BA3_TIPOUS = '1' "

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Filtra por grupo de cobranca...			                            ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If !Empty(cGrpCobAte)
			cSql += " AND (BA3_GRPCOB >= '" + cGrpCobDe + "' AND BA3_GRPCOB <= '" + cGrpCobAte + "') "
		EndIf
	EndIf
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Se for informado matricula... 			                            ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ		
	If ! Empty(cMatricAte)
		cSql += "AND BA3_MATRIC >= '" + cMatricDe + "' AND BA3_MATRIC <= '" + cMatricAte + "' "
	EndIf

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Ordena o resultado da query...  	                                ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If cTipo == '2'
		cSql += "ORDER BY BA3_FILIAL, BA3_CODINT, BA3_CODEMP, BA3_CONEMP, BA3_VERCON, BA3_SUBCON, BA3_VERSUB, BA3_MATRIC"
	Else
		cSql += "ORDER BY BA3_FILIAL, BA3_CODINT, BA3_CODEMP, BA3_MATRIC"
	Endif

	PLSQuery(cSql,"SELEFAM")

	SELEFAM->(DbGoTop())
 	Do While ! SELEFAM->(Eof())
	
		If Interrupcao(lAbortPrint)
			Exit
		EndIf   

		BA3->(DbGoTo(SELEFAM->BA3REC))
		BG9->(DbGoTo(SELEFAM->BG9REC))

 		cCodEmp := SELEFAM->BA3_CODEMP
		lImpBG9 := .T.
					
 		Do While ! SELEFAM->(Eof()) .And. SELEFAM->BA3_CODEMP == cCodEmp
 		
			If Interrupcao(lAbortPrint)
				Exit
			EndIf   
			
 			If cTipo == "2"
				BT5->(DbGoTo(SELEFAM->BT5REC))
				lImpBT5 := .T.
			Else
				lImpBT5 := .F.
			EndIf

 		    cConEmp := SELEFAM->BA3_CONEMP
 		    cVerCon := SELEFAM->BA3_VERCON
 			
 			Do While ! SELEFAM->(Eof()) .And. SELEFAM->(BA3_CODEMP+BA3_CONEMP+BA3_VERCON) == cCodEmp+cConEmp+cVerCon
 			
				If Interrupcao(lAbortPrint)
					Exit
				EndIf   

	 			If cTipo == "2"
					BQC->(DbGoTo(SELEFAM->BQCREC))
					lImpBQC := .T.
				Else
					lImpBQC := .F.
				EndIf

 		    	cSubCon := SELEFAM->BA3_SUBCON
 		    	cVerSub := SELEFAM->BA3_VERSUB

 				Do While ! SELEFAM->(Eof()) .And. SELEFAM->(BA3_CODEMP+BA3_CONEMP+BA3_VERCON+BA3_SUBCON+BA3_VERSUB) == cCodEmp+cConEmp+cVerCon+cSubCon+cVerSub
 				
					If Interrupcao(lAbortPrint)
						Exit
					EndIf   
					
					MsProcTxt(SELEFAM->(STR0012 + BA3_CODEMP + " " + STR0013 + BA3_MATRIC))
					ProcessMessages()
					
					aUsuarios := PLSLOADUSR(SELEFAM->BA3_CODINT,SELEFAM->BA3_CODEMP,SELEFAM->BA3_MATRIC,cAno,cMes)
			
					If Len(aUsuarios) == 0
						SELEFAM->(DbSkip())
						Loop
					EndIf         
					
					For i := 1 to Len(aUsuarios)
						If AllTrim(SELEFAM->BA3_MODPAG) == "1" // Pre-Pagamento
							If ! fLe_BM1(SELEFAM->BA3_CODINT, SELEFAM->BA3_CODEMP, SELEFAM->BA3_MATRIC, cAno, cMes, aUsuarios[i, 1])
								Loop
							EndIf   
						Else
							If ! fLe_BDH(SELEFAM->BA3_CODINT, SELEFAM->BA3_CODEMP, SELEFAM->BA3_MATRIC, cAno, cMes, aUsuarios[i, 1])
								Loop
							EndIf   
						EndIf
					
						If lImpBG9
							lImpBG9 := .F.
							fSomaLin(@nLin, Titulo, Cabec1, Cabec2, 2)
							@ nLin,  0 pSay Replicate("-", 136)
							fSomaLin(@nLin, Titulo, Cabec1, Cabec2, 2)
							@ nLin,  0 pSay STR0006 + BG9->BG9_CODIGO + " - " + BG9->BG9_DESCRI //"Empresa: "
						EndIf     
						
						If lImpBT5
							lImpBT5 := .F.
							fSomaLin(@nLin, Titulo, Cabec1, Cabec2, 1)
							@ nLin,  5 pSay STR0007 + BT5->BT5_NUMCON + "-" + BT5->BT5_VERSAO //"Contrato: "
							If SELEFAM->BT5_COBNIV == "1"
								@ nLin, 112 pSay Transform(SELEFAM->BT5_VENCTO, "99")
							EndIf
						EndIf
						
						If lImpBQC
							lImpBQC := .F.
							fSomaLin(@nLin, Titulo, Cabec1, Cabec2, 1)
							@ nLin, 10 pSay STR0008 + BQC->BQC_SUBCON + "-" + BQC->BQC_VERSUB + " - " + BQC->BQC_DESCRI //"SubContrato: "
							If SELEFAM->BQC_COBNIV == "1"
								@ nLin, 112 pSay Transform(SELEFAM->BQC_VENCTO, "99")
							EndIf
							@ nLin, 120 pSay SELEFAM->BQC_GRPCOB
					    EndIf
					    
					    If lListUsu .Or. SELEFAM->BA3_TIPOUS == '1'
							fSomaLin(@nLin, Titulo, Cabec1, Cabec2, 1)
							@ nLin, 15 pSay Transform(SELEFAM->(BA3_CODINT+BA3_CODEMP+BA3_MATRIC+aUsuarios[i, 1]+aUsuarios[i, 12]), "@R !.!!!.!!!!.!!!!!!-!!.!") + " - " + ;
											aUsuarios[i, 3]
							If SELEFAM->BA3_COBNIV == "1"
								@ nLin, 112 pSay Transform(SELEFAM->BA3_VENCTO, "99")
							EndIf
							@ nLin, 120 pSay SELEFAM->BA3_GRPCOB
						EndIf
					Next i
					
					SELEFAM->(DbSkip())
				EndDo
			EndDo
    	EndDo
	EndDo
	
	SELEFAM->(DbCloseArea())

Return

/*/  
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³ Programa  ³ fLe_BM1       ³ Autor ³ Sandro Hoffman     ³ Data ³ 26.06.2006 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Descri‡„o ³ Le tabela BM1 para verificar se houve faturamento              ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function fLe_BM1(cCodInt, cCodEmp, cMatric, cAno, cMes, cTipreg)

    Local lRet

	BM1->(DbSetOrder(1))
	lRet := ! BM1->(MsSeek(xFilial("BM1")+cCodInt+cCodEmp+cMatric+cAno+cMes+cTipreg))

Return lRet

/*/  
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³ Programa  ³ fLe_BDH       ³ Autor ³ Sandro Hoffman     ³ Data ³ 26.06.2006 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Descri‡„o ³ Le tabela BDH para verificar se ha participacao financeira e,  ³±±
±±³           ³ se houver, se houve faturamento da mesma.                      ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function fLe_BDH(cCodInt, cCodEmp, cMatric, cAno, cMes, cTipreg)

    Local lRet

	BDH->(DbSetOrder(1))
	If BDH->(MsSeek(xFilial("BDH")+cCodInt+cCodEmp+cMatric+cTipreg+cAno+cMes))
		If BDH->BDH_STATUS == "1" // A Faturar
			lRet := .T.
		Else
			lRet := fLe_BM1(cCodInt, cCodEmp, cMatric, cAno, cMes, cTipreg)
		EndIf
	Else
		lRet := .F.
	EndIf
	
Return lRet

/*/  
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³ Programa  ³ fSomaLin      ³ Autor ³ Sandro Hoffman     ³ Data ³ 26.06.2006 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Descri‡„o ³ Soma "n" Linhas a variavel "nLin" e verifica limite da pagina  ³±±
±±³           ³ para impressao do cabecalho                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function fSomaLin(nLin, Titulo, Cabec1, Cabec2, nLinSom)

	nLin += nLinSom
	If nLin > 58
		nLin := Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo) + 1
	EndIf

Return


/*/  
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³ Programa  ³ fCriaSX1      ³ Autor ³ Sandro Hoffman     ³ Data ³ 26.06.2006 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Descri‡„o ³ Cria grupo de perguntas caso seja necessario                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function fCriaSX1(cPerg)

   Local aRegs := {}

   // 1     2     3       4      5      6       7    8       9       10     11  12    13    14    15      16      17    18    19    20      21      22    23    24    25      26      27    28    29    30      31      32    33    34    35      36      37    38 39
   // Grupo/Ordem/Pergunt/PerSpa/PerEng/Variavl/Tipo/Tamanho/Decimal/PreSel/GSC/Valid/Var01/Def01/DefSpa1/DefEng1/Cnt01/Var02/Def02/DefSpa2/DefEng2/Cnt02/Var03/Def03/DefSpa3/DefEng3/Cnt03/Var04/Def04/DefSpa4/DefEng4/Cnt04/Var05/Def05/DefSpa5/DefEng5/Cnt05/F3/GRPSXG
   //             1    2       3                 45   6      7   8  9 0  1   2    3        4  5  6  7  8  9  0  1  2  3  4  5  6  7  8  9  0  1  2  3  4  5  6  7  8  9
   
   aAdd(aRegs,{cPerg,"01","Tipo Contrato      ?","","","mv_ch1","N",01,00,1,"C","","mv_par01","Pessoa Fisica","","","","","Pessoa Juridica","","","","","","","","","","","","","","","","","","","",""})
   aAdd(aRegs,{cPerg,"02","Ano Competencia    ?","","","mv_ch2","C",04,00,0,"G","","mv_par02","","","","","","","","","","","","","","","","","","","","","","","","","",""})
   aAdd(aRegs,{cPerg,"03","Mes Competencia    ?","","","mv_ch3","C",02,00,0,"G","","mv_par03","","","","","","","","","","","","","","","","","","","","","","","","","",""})
   aAdd(aRegs,{cPerg,"04","Listar Usuarios PJ ?","","","mv_ch4","N",01,00,1,"C","","mv_par04","Sim","","","","","Nao","","","","","","","","","","","","","","","","","","","",""})
   aAdd(aRegs,{cPerg,"05","Operadora De       ?","","","mv_ch5","C",04,00,0,"G","","mv_par05","","","","","","","","","","","","","","","","","","","","","","","","","B89",""})
   aAdd(aRegs,{cPerg,"06","Operadora Ate      ?","","","mv_ch6","C",04,00,0,"G","","mv_par06","","","","","","","","","","","","","","","","","","","","","","","","","B89",""})
   aAdd(aRegs,{cPerg,"07","Grupo/Empresa De   ?","","","mv_ch7","C",04,00,0,"G","","mv_par07","","","","","","","","","","","","","","","","","","","","","","","","","B7A",""})
   aAdd(aRegs,{cPerg,"08","Grupo/Empresa Ate  ?","","","mv_ch8","C",04,00,0,"G","","mv_par08","","","","","","","","","","","","","","","","","","","","","","","","","B7A",""})
   aAdd(aRegs,{cPerg,"09","Contrato De        ?","","","mv_ch9","C",12,00,0,"G","","mv_par09","","","","","","","","","","","","","","","","","","","","","","","","","B7B",""})
   aAdd(aRegs,{cPerg,"10","Contrato Ate       ?","","","mv_cha","C",12,00,0,"G","","mv_par10","","","","","","","","","","","","","","","","","","","","","","","","","B7B",""})
   aAdd(aRegs,{cPerg,"11","Versao Contrato De ?","","","mv_chb","C",03,00,0,"G","","mv_par11","","","","","","","","","","","","","","","","","","","","","","","","","",""})
   aAdd(aRegs,{cPerg,"12","Versao Contrato Ate?","","","mv_chc","C",03,00,0,"G","","mv_par12","","","","","","","","","","","","","","","","","","","","","","","","","",""})
   aAdd(aRegs,{cPerg,"13","Subcontrato De     ?","","","mv_chd","C",09,00,0,"G","","mv_par13","","","","","","","","","","","","","","","","","","","","","","","","","B7C",""})
   aAdd(aRegs,{cPerg,"14","Subcontrato Ate    ?","","","mv_che","C",09,00,0,"G","","mv_par14","","","","","","","","","","","","","","","","","","","","","","","","","B7C",""})
   aAdd(aRegs,{cPerg,"15","Versao Subcont De  ?","","","mv_chf","C",03,00,0,"G","","mv_par15","","","","","","","","","","","","","","","","","","","","","","","","","",""})
   aAdd(aRegs,{cPerg,"16","Versao Subcont Ate ?","","","mv_chg","C",03,00,0,"G","","mv_par16","","","","","","","","","","","","","","","","","","","","","","","","","",""})
   aAdd(aRegs,{cPerg,"17","Matricula De       ?","","","mv_chh","C",06,00,0,"G","","mv_par17","","","","","","","","","","","","","","","","","","","","","","","","","",""})
   aAdd(aRegs,{cPerg,"18","Matricula Ate      ?","","","mv_chi","C",06,00,0,"G","","mv_par18","","","","","","","","","","","","","","","","","","","","","","","","","",""})
   aAdd(aRegs,{cPerg,"19","Grupo Cobranca De  ?","","","mv_chj","C",04,00,0,"G","","mv_par19","","","","","","","","","","","","","","","","","","","","","","","","","BR0",""})
   aAdd(aRegs,{cPerg,"20","Grupo Cobranca Ate ?","","","mv_chk","C",04,00,0,"G","","mv_par20","","","","","","","","","","","","","","","","","","","","","","","","","BR0",""})
   aAdd(aRegs,{cPerg,"21","Lista Bloqueados   ?","","","mv_chl","N",01,00,1,"C","","mv_par21","Sim","","","","","Nao","","","","","","","","","","","","","","","","","","","",""})
   
   PlsVldPerg( aRegs )

Return