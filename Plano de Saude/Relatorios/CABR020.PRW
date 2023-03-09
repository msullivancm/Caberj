#include "PLSMGER.CH"
#INCLUDE "PROTHEUS.CH"
#IFDEF TOP
	#INCLUDE "TOPCONN.CH"
#ENDIF
/*/
ээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээ
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
╠╠зддддддддддбдддддддддбдддддддбддддддддддддддддддддддддбддддддбдддддддддд©╠╠╠
╠╠ЁFuncao    Ё cabr020 Ё Autor Ё Luzio Tavares          Ё Data Ё 04.02.09 Ё╠╠╠
╠╠цддддддддддедддддддддадддддддаддддддддддддддддддддддддаддддддадддддддддд╢╠╠╠
╠╠ЁDescricao Ё Relatorio do Custo de uma internacao                       Ё╠╠╠
╠╠цддддддддддедддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд╢╠╠╠
╠╠ЁSintaxe   Ё cabr020()                                                  Ё╠╠╠
╠╠цддддддддддедддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд╢╠╠╠
╠╠Ё Uso      Ё Advanced Protheus                                          Ё╠╠╠
╠╠цддддддддддадддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд╢╠╠╠
╠╠Ё Alteracoes desde sua construcao inicial                               Ё╠╠╠
╠╠цддддддддддбддддддбдддддддддддддбддддддддддддддддддддддддддддддддддддддд╢╠╠╠
╠╠Ё Data     Ё BOPS Ё Programador Ё Breve Descricao                       Ё╠╠╠
╠╠цддддддддддеддддддедддддддддддддеддддддддддддддддддддддддддддддддддддддд╢╠╠╠
╠╠Ё          Ё      Ё             Ё                                       Ё╠╠╠
╠╠юддддддддддаддддддадддддддддддддаддддддддддддддддддддддддддддддддддддддды╠╠╠
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
ъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъ
/*/
User Function cabr020()
//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Define variaveis padroes para todos os relatorios...                     Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
PRIVATE nQtdLin     := 58 //80
PRIVATE cNomeProg   := "cabr020"
PRIVATE nCaracter   := 15
PRIVATE nLimite     := 220
PRIVATE cTamanho    := "G"
PRIVATE cTitulo     := "Custo do Procedimento no Periodo: "
PRIVATE cDesc1      := "Relatorio do Custo das Internacoes Realizadas"
PRIVATE cDesc2      := ""
PRIVATE cDesc3      := ""
PRIVATE cAlias      := "BD6"
PRIVATE cPerg       := "cabr20"
PRIVATE cRel        := "cabr020"
PRIVATE nli         := 999
PRIVATE nQtdini     := nli
PRIVATE m_pag       := 1
PRIVATE lCompres    := .F.
PRIVATE lDicion     := .F.
PRIVATE lFiltro     := .F.
PRIVATE lCrystal    := .F.
PRIVATE aOrderns    := {"Por Usuario","Por RDA"}
PRIVATE aReturn     := { "", 1,"", 1, 1, 1, "",1 }
PRIVATE lAbortPrint := .F.
PRIVATE cCabec1     := " "
PRIVATE cCabec2     := "Seq   Procedimento   Descricao                                                 Qtd      Dt Atend    Vlr Pago   Guia                     Impresso               RDA                                                Compet."
PRIVATE nColuna     := 03

PRIVATE cCodOpeDe    := Mv_Par01
PRIVATE cCodOpeAte   := Mv_Par02
PRIVATE cCodRdaDe    := Mv_Par03
PRIVATE cCodRdaAte   := Mv_Par04
PRIVATE cCodEspDe    := Mv_Par05
PRIVATE cCodEspAte   := Mv_Par06
PRIVATE dDatIntDe    := Mv_Par07
PRIVATE dDatIntAte   := Mv_Par08
PRIVATE cSomInt      := Mv_Par09
PRIVATE cFase        := Mv_Par10
PRIVATE dDtProDe     := Mv_Par11
PRIVATE dDtProAte    := Mv_Par12
PRIVATE cCodTpProDe  := Mv_Par13
PRIVATE cCodTpProAte := Mv_Par14
PRIVATE cCodProDe    := Mv_Par15
PRIVATE cCodProAte   := Mv_Par16
PRIVATE cOpeUsuDe    := Mv_Par17
PRIVATE cOpeUsuAte   := Mv_Par18
PRIVATE cGruEmpDe    := Mv_Par19
PRIVATE cGruEmpAte   := Mv_Par20
PRIVATE cContraDe    := Mv_Par21
PRIVATE cContraAte   := Mv_Par22
PRIVATE cSubConDe    := Mv_Par23
PRIVATE cSubConAte   := Mv_Par24
PRIVATE cMatricDe    := Mv_Par25
PRIVATE cMatricAte   := Mv_Par26
PRIVATE cTipRegDe    := Mv_Par27
PRIVATE cTipRegAte   := Mv_Par28
PRIVATE cPlanoDe     := Mv_Par29
PRIVATE cPlanoAte    := Mv_Par30
PRIVATE cAnaSin      := Mv_Par31
PRIVATE nLisHonMed   := Mv_Par32
PRIVATE cCompDe      := Mv_Par33
PRIVATE cCompAte     := Mv_Par34
PRIVATE cCompPagDe   := Mv_Par35
PRIVATE cCompPagAte  := Mv_Par36
PRIVATE cImprRes     := Mv_Par37
PRIVATE cCustoHosp   := MV_par38 // Motta 8/12/14

AjustaSX1()
Pergunte(cPerg,.F.)

cTitulo += DtoC(Mv_Par11) + " a " + DtoC(Mv_Par12)

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Chama SetPrint (padrao)                                                  Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
cRel := SetPrint(cAlias,cRel,cPerg,@cTitulo,cDesc1,cDesc2,cDesc3,lDicion,aOrderns,lCompres,cTamanho,{},lFiltro,lCrystal)
//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Verifica se foi cancelada a operacao (padrao)                                    Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
If  nLastKey  == 27
	Return
Endif

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Acessa parametros do relatorio...                                        Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
/*
If  nLisBlo == 1
lLisBlo := .T.
Else
lLisBlo := .F.
Endif
If  nSomInt == 1
lSomInt := .T.
Else
lSomInt := .F.
Endif
*/

cCodOpeDe    := Mv_Par01
cCodOpeAte   := Mv_Par02
cCodRdaDe    := Mv_Par03
cCodRdaAte   := Mv_Par04
cCodEspDe    := Mv_Par05
cCodEspAte   := Mv_Par06
dDatIntDe    := Mv_Par07
dDatIntAte   := Mv_Par08
cSomInt      := Mv_Par09
cFase        := Mv_Par10
dDtProDe     := Mv_Par11
dDtProAte    := Mv_Par12
cCodTpProDe  := Mv_Par13
cCodTpProAte := Mv_Par14
cCodProDe    := Mv_Par15
cCodProAte   := Mv_Par16
cOpeUsuDe    := Mv_Par17
cOpeUsuAte   := Mv_Par18
cGruEmpDe    := Mv_Par19
cGruEmpAte   := Mv_Par20
cContraDe    := Mv_Par21
cContraAte   := Mv_Par22
cSubConDe    := Mv_Par23
cSubConAte   := Mv_Par24
cMatricDe    := Mv_Par25
cMatricAte   := Mv_Par26
cTipRegDe    := Mv_Par27
cTipRegAte   := Mv_Par28
cPlanoDe     := Mv_Par29
cPlanoAte    := Mv_Par30
cAnaSin      := Mv_Par31
cLisHonMed   := Mv_Par32
cCompDe      := substr(Mv_Par33,3,4)+substr(Mv_Par33,1,2)
cCompAte     := substr(Mv_Par34,3,4)+substr(Mv_Par34,1,2)
cCompPagDe   := substr(Mv_Par35,3,4)+substr(Mv_Par35,1,2)
cCompPagAte  := substr(Mv_Par36,3,4)+substr(Mv_Par36,1,2)
cImprRes     := Mv_Par37    
cCustoHosp   := MV_par38 // Motta 8/12/14

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Configura impressora (padrao)                                            Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
SetDefault(aReturn,cAlias)

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Emite relat╒rio                                                          Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
//MsAguarde({|| CABR020Imp() }, cTitulo, "", .T.)

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Processa relatorio                                                                 Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
Processa({|| CABR020Imp() }, "Processando Informacoes...", "", .T.)


//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Fim da rotina                                                            Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
Return

/*/
ээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээ
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
╠╠здддддддддддбддддддддддбдддддддбдддддддддддддддддддддддбддддддбдддддддддд©╠╠
╠╠ЁPrograma   Ё CABR020Imp Ё Autor Ё Luzio Tavares       Ё Data Ё 04.02.09 Ё╠╠
╠╠цдддддддддддеддддддддддадддддддадддддддддддддддддддддддаддддддадддддддддд╢╠╠
╠╠ЁDescricao  Ё Relatorio de internacao                                    Ё╠╠
╠╠юдддддддддддадддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды╠╠
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
/*/
Static Function CABR020Imp()

Local n := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

Local cFiltroSel
Local cFiltro
Local cFiltro1
Local cFiltro2
Local cFiltroBD6
Local aFreqEve := {}
Local aFreqTot := {}
Local aMapProc := {}
Local aMapHMTot := {}
Local cDesCombo := space(0)

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Define variaveis...                                                      Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
LOCAL cSQL
LOCAL nOrdSel := aReturn[8]
LOCAL cLinha
LOCAL cRdaAnt
LOCAL cMatric
LOCAL nVlrPag := 0
LOCAL nVlrGlo := 0
LOCAL	nTVlrPag := 0
LOCAL	nTVlrGlo := 0
LOCAL	nTotVlrPag := 0
LOCAL	nTotVlrGlo := 0
LOCAL	nT1VlrPag := 0
LOCAL	nT1VlrGlo := 0
LOCAL	nT2VlrPag := 0
LOCAL	nT2VlrGlo := 0
LOCAL nFrequenc := 0
LOCAL nFaixa    := 0

Local nTotal   := 0    // recebe o n total de registros
Local nProc    := 1    // incrementado por unidade de registro
Local Npercent := 0

PRIVATE nIdade

If !(UPPER(Substr(alltrim(cCodProAte),1,1))) $ "Z"

	cSql := "SELECT DISTINCT BD6_FILIAL, BD6_codope, BD6_codldp, BD6_codpeg, BD6_numero, BD6_anopag, BD6_mespag,  BD6_OPEUSR, BD6_CODEMP, "
	cSql += "BD6_MATRIC, BD6_TIPREG, BD6_DIGITO, BD6_NOMUSR, BD6_ORIMOV, BD6_CODRDA,  BD6_NUMIMP, BD6_CODPAD, BD6_CODPRO, BR8_TPPROC, BR8_DESCRI, BD6_NUMLOT, BD5_GUIINT, BD6_SENEVO AS BE4_SENHA "
	cSql += " FROM "+RetSQLName("BD6") + " BD6, " + RetSQLName("BD5") + " BD5,  "+ RetSQLName("BR8") + " BR8, "+ RetSQLName("BAU") + " BAU " // Motta 08/12/14
	
	cSQL += " WHERE BD6_FILIAL = '"+xFilial("BD6")+"' "
	cSQL += " AND BD6_SITUAC = '1' "
	If !(UPPER(Substr(alltrim(cCodOPeAte),1,1))) $ "Z"   //!Empty(cCodOPeAte)
		cSQL += " AND BD6_CODOPE BETWEEN '" + cCodOpeDe + "' AND '" + cCodOpeAte + "' "
	Else
		cSQL += " AND BD6_CODOPE = '0001' "
	EndIf
	
	If UPPER(Substr(alltrim(cCodTpProAte),1,1)) $ "Z"
		//cSQL += " AND BD6_CODPAD||BD6_CODPRO BETWEEN '01" + Alltrim(cCodProDe) + "' AND '01" + Alltrim(cCodProAte) + "' "
		//cSQL += " AND BD6_CODPRO BETWEEN '" + Alltrim(cCodProDe) + "' AND '" + Alltrim(cCodProAte) + "' "
		cSQL += " AND BD6_CODPRO BETWEEN '" + PADL(cCodProDe,16) + "' AND '" + PADL(cCodProAte,16) + "' "
	Else
		//		cSQL += " AND BD6_CODPAD||BD6_CODPRO BETWEEN '" + AllTrim(cCodTpProDe)+Alltrim(cCodProDe) + "' AND '" + Alltrim(cCodTpProAte)+Alltrim(cCodProAte) + "' "
		//cSQL += " AND BD6_CODPAD = '" + AllTrim(cCodTpProAte) + "' "
		If !EMPTY(cCodTpProDe)
			cSQL += " AND BD6_CODPAD BETWEEN '" + AllTrim(cCodTpProDe) + "' AND '" + AllTrim(cCodTpProAte) + "' "
		Else
			cSQL += " AND BD6_CODPAD BETWEEN '" + PADL(cCodTpProDe,16) + "' AND '" + AllTrim(cCodTpProAte) + "' "
		Endif
		
		//cSQL += " AND BD6_CODPRO BETWEEN '" + Alltrim(cCodProDe) + "' AND '" + Alltrim(cCodProAte) + "' "
		cSQL += " AND BD6_CODPRO BETWEEN '" + PADL(cCodProDe,16) + "' AND '" + PADL(cCodProAte,16) + "' "
	EndIf
	If !(UPPER(Substr(alltrim(cCodRdaAte),1,1))) $ "Z"   //	If !Empty(cCodRdaAte)
		cSQL += " AND BD6_CODRDA BETWEEN '" + cCodRdaDe + "' AND '" + cCodRdaAte + "' "
	EndIf
	If !Empty(dDtProAte)
		cSQL += " AND BD6_DATPRO BETWEEN '" + dtos(dDtProDe) + "' AND '" + dtos(dDtProAte) + "' "
	EndIf
	If !(UPPER(Substr(alltrim(cCodEspAte),1,1))) $ "Z"   //	If !Empty(cCodEspAte)
		cSQL += " AND BD6_CODESP BETWEEN '" + cCodEspDe + "' AND '" + cCodEspAte + "' "
	EndIf
	
	If !(UPPER(Substr(alltrim(cCompAte),1,1))) $ "Z" .and. (!Empty(cCompDe) .and. !Empty(cCompAte))
		cSQL += " AND BD6_ANOPAG||BD6_MESPAG BETWEEN '" + cCompDe + "' AND '" + cCompAte + "' "
	EndIf
	
	If !(UPPER(Substr(alltrim(cCompPagAte),1,1))) $ "Z" .and. (!Empty(cCompPagDe) .and. !Empty(cComppagAte))
		cSQL += " AND SubStr(BD6_numlot,1,6) BETWEEN '" + cCompPagDe + "' AND '" + cCompPagAte + "' "
	EndIf
	
	//-------------------------------------------------------------------------
	//Angelo Henrique - Data: 08/02/2018
	//-------------------------------------------------------------------------
	//ApСs analise junto ao analista Roberto Meirelles
	//и necessАrio ter a validaГЦo do tipo de guia para que 
	//nЦo haja duplicidade no relatСrio 
	//-------------------------------------------------------------------------
	cSQL +=   " AND BD6_TIPGUI <> '05' "
	//-------------------------------------------------------------------------	
	
	If cFase = 1
		cSQL +=   " AND BD6_FASE IN ('4') "
	ElseIf	cFase = 2
		cSQL +=   " AND BD6_FASE IN ('3') "
	ElseIf	cFase = 3
		cSQL +=   " AND BD6_FASE IN ('3','4') "
	EndIf
	
	If !(UPPER(Substr(alltrim(cOPeUsuAte),1,1))) $ "Z"   //	If !Empty(cOPeUsuAte)
		cSQL += " AND BD6_OPEUSR BETWEEN '" + cOpeUsuDe + "' AND '" + cOPeUsuAte + "' "
	Endif
	If !(UPPER(Substr(alltrim(cGruEmpAte),1,1))) $ "Z"   //	If !Empty(cGruEmpAte)
		cSQL += " AND BD6_CODEMP BETWEEN '" + cGruEmpDe + "' AND '" + cGruEmpAte + "' "
	EndIf
	If !(UPPER(Substr(alltrim(cContraAte),1,1))) $ "Z"   //	If !Empty(cContraAte)
		cSQL += " AND BD6_CONEMP BETWEEN '" + cContraDe + "' AND '" + cContraAte + "' "
	EndIf
	//cSQL += " AND BD6_VERCON >= '" + cVerConDe + "' AND BD6_VERCON <= '" + cVerConAte + "' "
	If !(UPPER(Substr(alltrim(cSubConAte),1,1))) $ "Z"   //	If !Empty(cSubConAte)
		cSQL += " AND BD6_SUBCON BETWEEN '" + cSubConDe + "' AND '" + cSubConAte + "' "
	EndIf
	
	//cSQL += " AND BD6_VERSUB >= '" + cVerSubDe + "' AND BD6_VERSUB <= '" + cVerSubAte + "' "
	If !(UPPER(Substr(alltrim(cMatricAte),1,1))) $ "Z"   //		If !Empty(cMatricAte)
		cSQL += " AND BD6_MATRIC BETWEEN '" + cMatricDe + "' AND '" + cMatricAte + "' "
	EndIf
	If !(UPPER(Substr(alltrim(cTipRegAte),1,1))) $ "Z"   //		If !Empty(cTipRegAte)
		cSQL += " AND BD6_TIPREG BETWEEN '" + cTipRegDe + "' AND '" + cTipRegAte + "' "
	EndIf
	If !(UPPER(Substr(alltrim(cPlanoAte),1,1))) $ "Z"   //		If !Empty(cPlanoAte)
		cSQL += " AND BD6_CODPLA BETWEEN '" + cPlanoDe  + "' AND '" + cPlanoAte  + "' "
	EndIf
	cSQL += " AND BD6.D_E_L_E_T_ = ' ' "
	cSQL += " AND BD5_FILIAL = '"+xFilial("BD5")+"' "
	cSql += " AND BD5_CODOPE = BD6_CODOPE "
	cSql += " AND BD5_CODLDP = BD6_CODLDP "
	cSql += " AND BD5_CODPEG = BD6_CODPEG "
	cSql += " AND BD5_NUMERO = BD6_NUMERO "
	cSql += " AND BD5_ANOPAG = BD6_ANOPAG "
	cSql += " AND BD5_MESPAG = BD6_MESPAG "
	cSql += " AND BD5_CODRDA = BD6_CODRDA "
	cSQL += " AND BR8_FILIAL = '  ' "
	cSQL += " AND BR8_CODPAD = BD6_CODPAD "
	cSQL += " AND BR8_CODPSA = BD6_CODPRO " 
	cSQL += " AND BAU_FILIAL = '  ' "
	cSQL += " AND BAU_CODIGO = BD6_CODRDA "//Motta 08/12/14    
	If cCustoHosp != 4
	  	cSQL += " AND BAU_YCTHOS = '" + AllTrim(Str(cCustoHosp)) + "' " //Motta 08/12/14    
	Endif
	
	cSQL += " AND BR8.D_E_L_E_T_ = ' ' "
	cSql += " AND BD5.d_e_l_e_t_ = ' ' " 
	cSql += " AND Bau.d_e_l_e_t_ = ' ' " //Motta 08/12/14
	
	cSql += "UNION "
	
	cSql += "SELECT DISTINCT BD6_FILIAL, BD6_codope, BD6_codldp, BD6_codpeg, BD6_numero, BD6_anopag, BD6_mespag,  BD6_OPEUSR, BD6_CODEMP, "
	cSql += " BD6_MATRIC, BD6_TIPREG, BD6_DIGITO, BD6_NOMUSR, BD6_ORIMOV, BD6_CODRDA,  BD6_NUMIMP, BD6_CODPAD, BD6_CODPRO, BR8_TPPROC, BR8_DESCRI, BD6_NUMLOT,' ' AS BD5_GUIINT, BE4_SENHA "
	cSql += " FROM "+RetSQLName("BD6") + " BD6, " + RetSQLName("BE4") + " BE4,  "+ RetSQLName("BR8") + " BR8, "
	cSql += RetSQLName("BAU") + " BAU " // Motta 08/12/14
	cSQL += " WHERE BD6_FILIAL = '"+xFilial("BD6")+"' "
	cSQL += " AND BD6_SITUAC = '1' "
	If !(UPPER(Substr(alltrim(cCodOPeAte),1,1))) $ "Z"   //!Empty(cCodOPeAte)
		cSQL += " AND BD6_CODOPE BETWEEN '" + cCodOpeDe + "' AND '" + cCodOpeAte + "' "
	Else
		cSQL += " AND BD6_CODOPE = '0001' "
	EndIf
	If UPPER(Substr(alltrim(cCodTpProAte),1,1)) $ "Z"
		//		cSQL += " AND BD6_CODPAD||BD6_CODPRO BETWEEN '01" + Alltrim(cCodProDe) + "' AND '01" + Alltrim(cCodProAte) + "' "
		//cSQL += " AND BD6_CODPRO BETWEEN '" + Alltrim(cCodProDe) + "' AND '" + Alltrim(cCodProAte) + "' "
		cSQL += " AND BD6_CODPRO BETWEEN '" + PADL(cCodProDe,16) + "' AND '" + PADL(cCodProAte,16) + "' "
	Else
		//		cSQL += " AND BD6_CODPAD||BD6_CODPRO BETWEEN '" + AllTrim(cCodTpProDe)+Alltrim(cCodProDe) + "' AND '" + Alltrim(cCodTpProAte)+Alltrim(cCodProAte) + "' "
		//cSQL += " AND BD6_CODPAD = '" + AllTrim(cCodTpProAte) + "' "
		cSQL += " AND BD6_CODPAD BETWEEN '" + PADL(cCodTpProDe,16) + "' AND '" + PADL(cCodTpProAte,16) + "' "
		//cSQL += " AND BD6_CODPRO BETWEEN '" + Alltrim(cCodProDe) + "' AND '" + Alltrim(cCodProAte) + "' "
		cSQL += " AND BD6_CODPRO BETWEEN '" + PADL(cCodProDe,16) + "' AND '" + PADL(cCodProAte,16) + "' "
	EndIf
	If !(UPPER(Substr(alltrim(cCodRdaAte),1,1))) $ "Z"   //	If !Empty(cCodRdaAte)
		cSQL += " AND BD6_CODRDA BETWEEN '" + cCodRdaDe + "' AND '" + cCodRdaAte + "' "
	EndIf
	If !Empty(dDtProAte)
		cSQL += " AND BD6_DATPRO BETWEEN '" + dtos(dDtProDe) + "' AND '" + dtos(dDtProAte) + "' "
	EndIf
	If !(UPPER(Substr(alltrim(cCodEspAte),1,1))) $ "Z"   //	If !Empty(cCodEspAte)
		cSQL += " AND BD6_CODESP BETWEEN '" + cCodEspDe + "' AND '" + cCodEspAte + "' "
	EndIf
	
	If !(UPPER(Substr(alltrim(cCompAte),1,1))) $ "Z" .and. (!Empty(cCompDe) .and. !Empty(cCompAte))
		cSQL += " AND BD6_ANOPAG||BD6_MESPAG BETWEEN '" + cCompDe + "' AND '" + cCompAte + "' "
	EndIf
	
	If !(UPPER(Substr(alltrim(cCompPagAte),1,1))) $ "Z" .and. (!Empty(cCompPagDe) .and. !Empty(cComppagAte))
		cSQL += " AND SubStr(BD6_numlot,1,6) BETWEEN '" + cCompPagDe + "' AND '" + cCompPagAte + "' "
	EndIf
	
	//-------------------------------------------------------------------------
	//Angelo Henrique - Data: 08/02/2018
	//-------------------------------------------------------------------------
	//ApСs analise junto ao analista Roberto Meirelles
	//и necessАrio ter a validaГЦo do tipo de guia para que 
	//nЦo haja duplicidade no relatСrio 
	//-------------------------------------------------------------------------
	cSQL +=   " AND BD6_TIPGUI = '05' "
	//-------------------------------------------------------------------------
	
	If cFase = 1
		cSQL +=   " AND BD6_FASE IN ('4') "
	ElseIf	cFase = 2
		cSQL +=   " AND BD6_FASE IN ('3') "
	ElseIf	cFase = 3
		cSQL +=   " AND BD6_FASE IN ('3','4') "
	EndIf
	
	If !(UPPER(Substr(alltrim(cOPeUsuAte),1,1))) $ "Z"   //	If !Empty(cOPeUsuAte)
		cSQL += " AND BD6_OPEUSR BETWEEN '" + cOpeUsuDe + "' AND '" + cOPeUsuAte + "' "
	Endif
	If !(UPPER(Substr(alltrim(cGruEmpAte),1,1))) $ "Z"   //	If !Empty(cGruEmpAte)
		cSQL += " AND BD6_CODEMP BETWEEN '" + cGruEmpDe + "' AND '" + cGruEmpAte + "' "
	EndIf
	If !(UPPER(Substr(alltrim(cContraAte),1,1))) $ "Z"   //	If !Empty(cContraAte)
		cSQL += " AND BD6_CONEMP BETWEEN '" + cContraDe + "' AND '" + cContraAte + "' "
	EndIf
	//cSQL += " AND BD6_VERCON >= '" + cVerConDe + "' AND BD6_VERCON <= '" + cVerConAte + "' "
	If !(UPPER(Substr(alltrim(cSubConAte),1,1))) $ "Z"   //	If !Empty(cSubConAte)
		cSQL += " AND BD6_SUBCON BETWEEN '" + cSubConDe + "' AND '" + cSubConAte + "' "
	EndIf
	
	//cSQL += " AND BD6_VERSUB >= '" + cVerSubDe + "' AND BD6_VERSUB <= '" + cVerSubAte + "' "
	If !(UPPER(Substr(alltrim(cMatricAte),1,1))) $ "Z"   //		If !Empty(cMatricAte)
		cSQL += " AND BD6_MATRIC BETWEEN '" + cMatricDe + "' AND '" + cMatricAte + "' "
	EndIf
	If !(UPPER(Substr(alltrim(cTipRegAte),1,1))) $ "Z"   //		If !Empty(cTipRegAte)
		cSQL += " AND BD6_TIPREG BETWEEN '" + cTipRegDe + "' AND '" + cTipRegAte + "' "
	EndIf
	If !(UPPER(Substr(alltrim(cPlanoAte),1,1))) $ "Z"   //		If !Empty(cPlanoAte)
		cSQL += " AND BD6_CODPLA BETWEEN '" + cPlanoDe  + "' AND '" + cPlanoAte  + "' "
	EndIf
	cSql += "AND BD6.D_E_L_E_T_ = ' ' "
	cSQL += "AND BE4_FILIAL = '"+xFilial("BE4")+"' "
	cSQL += "AND BE4_CODOPE = BD6_OPEINT "
	cSQL += "AND BE4_ANOINT = BD6_ANOINT "
	cSQL += "AND BE4_MESINT = BD6_MESINT "
	cSQL += "AND BE4_NUMINT = BD6_NUMINT "
	//	cSql += "AND BE4_SENHA  = bd6_senevo "
	cSql += "AND BE4.d_e_l_e_t_ = ' ' "  
	cSQL += " AND BR8_FILIAL = '  ' " 
	cSQL += " AND BR8_CODPAD = BD6_CODPAD "
	cSQL += " AND BR8_CODPSA = BD6_CODPRO " 
	cSQL += " AND BAU_FILIAL = '  ' "
	cSQL += " AND BAU_CODIGO = BD6_CODRDA "//Motta 08/12/14     
	If cCustoHosp != 4
	  	cSQL += " AND BAU_YCTHOS = '" + AllTrim(Str(cCustoHosp)) + "' " //Motta 08/12/14    
	Endif
	cSql += " AND Bau.d_e_l_e_t_ = ' ' " //Motta 08/12/14
	cSQL += " AND BR8.D_E_L_E_T_ = ' ' "
	
ElseIf Empty(cCodProDe) .and. (UPPER(Substr(alltrim(cCodProAte),1,1))) $ "Z"  //Motta 08/12/14  Empty(cCodProAte)
	cSql := "SELECT DISTINCT BD6_FILIAL, BD6_codope, BD6_codldp, BD6_codpeg, BD6_numero, BD6_anopag, BD6_mespag, "
	cSql += " BD6_OPEUSR, BD6_CODEMP, BD6_MATRIC, BD6_TIPREG, BD6_DIGITO, BD6_NOMUSR, BD6_ORIMOV, BD6_CODRDA,
	cSql += " BD6_NUMIMP, BD6_NUMLOT, BR8_TPPROC, BR8_DESCRI , BD6_CODPAD, BD6_CODPRO, "
	cSql += " (SELECT BE4_SENHA  FROM BE4010 BE4  "
	cSql += " WHERE BE4_FILIAL = '  '  AND "
	cSql += " BE4_CODOPE = BD6_CODOPE  AND "
	cSql += " BE4_CODLDP = BD6_CODLDP  AND "
	cSql += " BE4_CODPEG = BD6_CODPEG  AND "
	cSql += " BE4_NUMERO = BD6_NUMERO  AND "
	cSql += " BE4_ANOPAG = BD6_ANOPAG  AND "
	cSql += " BE4_MESPAG = BD6_MESPAG  AND "
	cSql += " BE4_CODRDA = BD6_CODRDA  AND "
	cSql += " d_e_l_e_t_ = ' ' ) AS BE4_SENHA, "
	cSql += " (SELECT BD5_GUIINT "
	cSql += " FROM BD5010 BD5 "
	cSql += " WHERE BD5_FILIAL = '"+xFilial("BD5")+"' "
	cSql += " AND BD5_CODOPE = BD6_CODOPE "
	cSql += " AND BD5_CODLDP = BD6_CODLDP "
	cSql += " AND BD5_CODPEG = BD6_CODPEG "
	cSql += " AND BD5_NUMERO = BD6_NUMERO "
	cSql += " AND BD5_ANOPAG = BD6_ANOPAG "
	cSql += " AND BD5_MESPAG = BD6_MESPAG "
	cSql += " AND BD5_CODRDA = BD6_CODRDA "
	cSql += " AND d_e_l_e_t_ = ' ' ) AS BD5_GUIINT "
	cSql += " FROM " + RetSQLName("BD6") + " BD6, "+ RetSQLName("BR8") + " BR8, " 	
	cSql += RetSQLName("BAU") + " BAU " // Motta 08/12/14	
	cSQL += " WHERE BD6_FILIAL = '"+xFilial("BD6")+"' "
	cSQL += " AND BD6_SITUAC = '1' "
	If !Empty(cCodOPeAte)
		cSQL += " AND BD6_CODOPE BETWEEN '" + cCodOpeDe + "' AND '" + cCodOpeAte + "' "
	Else
		cSQL += " AND BD6_CODOPE = '0001' "
	EndIf
	If UPPER(Substr(alltrim(cCodTpProAte),1,1)) $ "Z"
		//		cSQL += " AND BD6_CODPAD||BD6_CODPRO BETWEEN '01" + Alltrim(cCodProDe) + "' AND '01" + Alltrim(cCodProAte) + "' "
		//cSQL += " AND BD6_CODPRO BETWEEN '" + Alltrim(cCodProDe) + "' AND '" + Alltrim(cCodProAte) + "' "
		cSQL += " AND BD6_CODPRO BETWEEN '" + PADL(cCodProDe,16) + "' AND '" + PADL(cCodProAte,16) + "' "
	Else
		//		cSQL += " AND BD6_CODPAD||BD6_CODPRO BETWEEN '" + AllTrim(cCodTpProDe)+Alltrim(cCodProDe) + "' AND '" + Alltrim(cCodTpProAte)+Alltrim(cCodProAte) + "' "
		//cSQL += " AND BD6_CODPAD = '" + AllTrim(cCodTpProAte) + "' "
		cSQL += " AND BD6_CODPAD BETWEEN '" + PADL(cCodTpProDe,16) + "' AND '" + PADL(cCodTpProAte,16) + "' "
		//cSQL += " AND BD6_CODPRO BETWEEN '" + Alltrim(cCodProDe) + "' AND '" + Alltrim(cCodProAte) + "' "
		cSQL += " AND BD6_CODPRO BETWEEN '" + PADL(cCodProDe,16) + "' AND '" + PADL(cCodProAte,16) + "' "
	EndIf
	cSQL += " AND BD6_CODRDA BETWEEN '" + cCodRdaDe + "' AND '" + cCodRdaAte + "' "
	cSQL += " AND BD6_DATPRO BETWEEN '" + dtos(dDtProDe) + "' AND '" + dtos(dDtProAte) + "' "
	cSQL += " AND BD6_CODESP BETWEEN '" + cCodEspDe + "' AND '" + cCodEspAte + "' "
	If !(UPPER(Substr(alltrim(cCompAte),1,1))) $ "Z" .and. (!Empty(cCompDe) .and. !Empty(cCompAte))
		cSQL += " AND BD6_ANOPAG||BD6_MESPAG BETWEEN '" + cCompDe + "' AND '" + cCompAte + "' "
	EndIf
	
	If !(UPPER(Substr(alltrim(cCompPagAte),1,1))) $ "Z" .and. (!Empty(cCompPagDe) .and. !Empty(cComppagAte))
		cSQL += " AND SubStr(BD6_numlot,1,6) BETWEEN '" + cCompPagDe + "' AND '" + cCompPagAte + "' "
	EndIf
	
	//-------------------------------------------------------------------------
	//Angelo Henrique - Data: 08/02/2018
	//-------------------------------------------------------------------------
	//ApСs analise junto ao analista Roberto Meirelles
	//и necessАrio ter a validaГЦo do tipo de guia para que 
	//nЦo haja duplicidade no relatСrio 
	//-------------------------------------------------------------------------
	cSQL +=   " AND BD6_TIPGUI = '05' "
	//-------------------------------------------------------------------------	
	
	If cFase = 1
		cSQL +=   " AND BD6_FASE IN ('4') "
	ElseIf	cFase = 2
		cSQL +=   " AND BD6_FASE IN ('3') "
	ElseIf	cFase = 3
		cSQL +=   " AND BD6_FASE IN ('3','4') "
	EndIf
	
	cSQL += " AND BD6_OPEUSR BETWEEN '" + cOpeUsuDe + "' AND '" + cOPeUsuAte + "' "
	cSQL += " AND BD6_CODEMP BETWEEN '" + cGruEmpDe + "' AND '" + cGruEmpAte + "' "
	cSQL += " AND BD6_CONEMP BETWEEN '" + cContraDe + "' AND '" + cContraAte + "' "
	//cSQL += " AND BD6_VERCON >= '" + cVerConDe + "' AND BD6_VERCON <= '" + cVerConAte + "' "
	cSQL += " AND BD6_SUBCON BETWEEN '" + cSubConDe + "' AND '" + cSubConAte + "' "
	//cSQL += " AND BD6_VERSUB >= '" + cVerSubDe + "' AND BD6_VERSUB <= '" + cVerSubAte + "' "
	cSQL += " AND BD6_MATRIC BETWEEN '" + cMatricDe + "' AND '" + cMatricAte + "' "
	cSQL += " AND BD6_TIPREG BETWEEN '" + cTipRegDe + "' AND '" + cTipRegAte + "' "
	cSQL += " AND BD6_CODPLA BETWEEN '" + cPlanoDe  + "' AND '" + cPlanoAte  + "' "
	cSQL += " AND BR8_FILIAL = '  ' "
	cSQL += " AND BR8_CODPAD = BD6_CODPAD "
	cSQL += " AND BR8_CODPSA = BD6_CODPRO "  
	cSQL += " AND BAU_FILIAL = '  ' "
	cSQL += " AND BAU_CODIGO = BD6_CODRDA "//Motta 08/12/14   	
	If cCustoHosp != 4
	  	cSQL += " AND BAU_YCTHOS = '" + AllTrim(Str(cCustoHosp)) + "' " //Motta 08/12/14    
	Endif	
	cSQL += " AND BR8.D_E_L_E_T_ = ' ' "  
	cSql += " AND Bau.d_e_l_e_t_ = ' ' " //Motta 08/12/14
EndIf

Do Case
	Case nOrdSel == 1
		cSQL += " ORDER BY BD6_CODPAD, BD6_CODPRO, BD6_OPEUSR, BD6_CODEMP, BD6_MATRIC, BD6_TIPREG, BD6_CODOPE, BD6_CODLDP, BD6_CODPEG, BD6_NUMERO "
	Case nOrdSel == 2
		cSQL += " ORDER BY BD6_CODPAD, BD6_CODPRO, BD6_CODRDA, BD6_OPEUSR, BD6_CODEMP, BD6_MATRIC, BD6_TIPREG, BD6_CODOPE, BD6_CODLDP, BD6_CODPEG, BD6_NUMERO "
EndCase

memowrit("C:\TEMP\CABR020.SQL",cSQL) 

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Executa query...                                                         Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
PLSQuery(cSQL,"Trb")

Trb->(DbGotop())

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Monta regua                                                                        Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
Trb->(DBEval( { | | nTotal++ }))
Trb->( DbGotop())
ProcRegua(nTotal)

/*
Seq   Procedimento   Descricao                                                 Qtd      Dt Atend    Vlr Pago   Guia                     Impresso               RDA                                                Compet.
****************************************************************************************************************************************************************************************************************************

Beneficiario: 0001.0001.009016.01-  ROBERTO CORTESE                          Dt Intern: 22/12/08  Dt Alta: 24/12/08  Tipo: ADULTO          Impresso:                       Autoriz: 0001.2008.12.00000743  Pad Conforto: 0,00   CID: S72

004   01  32.04.001-6   BACIA                                                       1   22/12/08       17,98   0000.00016112.00000005                          044369 - CLINICA SAO GONCALO                       12/2008
005   01  32.04.004-0   ARTICULACAO COXO-FEMURAL(CADA LADO)                         1   22/12/08       21,22
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Total da Guia                                                                                                1.221,09        0,00

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Total do beneficiario                                                                                        1.221,09        0,00
*/

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Navega pelos registros selecionados...                                   Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
While ! Trb->(Eof())
	//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//Ё Exibe mensagem...                                                  Ё
	//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
	Npercent := (nProc/nTotal)*100
	IncProc("Processando 1: " + Transform(Npercent,"@E 9,999.9") + "  % do Total de: "+ Transform(nTotal,"@E 9999999"))
	ProcessMessage()
	
	nProc++
	
	//	//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//	//Ё Exibe mensagem...                                                  Ё
	//	//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
	//	MsProcTXT("Imprimindo GIH ...")   //+Trb->(BE4_ANOINT+"."+BE4_MESINT+"-"+BE4_NUMINT)+"...")
	
	//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//Ё Separa a Competencia Selecionada                                   Ё
	//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
	If !Empty(Trb->(BD5_GUIINT))
		Trb->(DbSkip())
		loop
	EndIf
	
	//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//Ё Inicializ variaveis                                                Ё
	//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
	cCodPro := Trb->(BD6_CODPAD+BD6_CODPRO)
	
	cCabec1 := "PROCEDIMENTO: " + Trb->BD6_CODPAD + space(2) + ;
	transform(Trb->BD6_CODPRO,"@R XX.XX.XXX-X") + space(3) + ;
	substr(Trb->(BR8_DESCRI),1,56)
//	substr(posicione("BR8",1,xFilial("BR8")+Trb->(BD6_CODPAD+BD6_CODPRO),"BR8_DESCRI"),1,56)
		
	nLi := 999

	aFreqEve := {}
	aMapProc := {}
		
	If nOrdSel == 1
		//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
		//Ё Imprime codigo do procedimento                                     Ё
		//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
		If  nli > nQtdLin
			nli := Cabec(cTitulo,cCabec1,cCabec2,cNomeProg,cTamanho,nCaracter)
			nli++
			nLi++
		Endif
		//		@ nLi, 0 pSay cLinha
		//		nli++
		//		nli++
		
		//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
		//Ё Inicializ variaveis                                                Ё
		//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
		//			cMatric := Trb->BE4_OPEUSR + Trb->BE4_CODEMP + Trb->BE4_MATRIC + Trb->BE4_TIPREG + Trb->BE4_DIGITO
		cMatric := Trb->(BD6_OPEUSR+BD6_CODEMP+BD6_MATRIC+BD6_TIPREG)
		
		lImpMatric := .T.
		
		While ! Trb->(Eof()) .and. Trb->(BD6_OPEUSR+BD6_CODEMP+BD6_MATRIC+BD6_TIPREG) == cMatric
			
			//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
			//Ё Exibe mensagem...                                                  Ё
			//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
			Npercent := (nProc/nTotal)*100
			IncProc("Processando 2: " + Transform(Npercent,"@E 9,999.9") + "  % do Total de: "+ Transform(nTotal,"@E 9999999"))
			ProcessMessage()
			
			nProc++
			
			//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
			//Ё Separa a Competencia Selecionada                                   Ё
			//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
			If !Empty(Trb->(BD5_GUIINT))
				Trb->(DbSkip())
				loop
			EndIf
			
			//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
			//Ё Separa a Competencia Selecionada                                   Ё
			//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
			If !empty(cCompAte)
				If Trb->(BD6_ANOPAG+BD6_MESPAG) < cCompDe .or. Trb->(BD6_ANOPAG+BD6_MESPAG) > cCompAte
					Trb->(DbSkip())
					loop
				EndIf
			EndIf
			
			If !empty(cCompPagAte) .and. val(cCompPagAte) > 0
				If Trb->(SubStr(BD6_numlot,1,6)) < cCompPagDe .or. Trb->(SubStr(BD6_numlot,1,6)) > cCompPagAte
					Trb->(DbSkip())
					loop
				EndIf
			EndIf
			
			//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
			//Ё Verifica se foi abortada a impressao...                            Ё
			//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
			If  Interrupcao(lAbortPrint)
				nLi ++
				@ nLi, nColuna pSay PLSTR0002
				Exit
			Endif
			
			//			BA1->(dbSeek(xFilial("BA1")+cMatric))
			
			BE4->(DbSetOrder(1))
			If BE4->(DbSeek(xFilial("BE4")+Trb->(BD6_CODOPE+BD6_CODLDP+BD6_CODPEG+BD6_NUMERO)))
				//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
				//Ё Posiciona tabelas                                                  Ё
				//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
				BQR->(dbSeek(xFilial("BQR")+BE4->(BE4_GRPINT+BE4_TIPINT)))
				BN5->(dbSeek(xFilial("BN5")+BE4->(BE4_CODOPE+BE4_PADCON)))
			EndIf
			
			//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
			//Ё Imprime dados do usuario                                           Ё
			//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
			cLinha  := "Beneficiario: " + transform(cMatric,"@R XXXX.XXXX.XXXXXX.XX-X") + space(1) + ;
			substr(Trb->BD6_NOMUSR,1,40) + space(1) + ;
			"Dt Intern: " + dtoc(BE4->BE4_DATPRO) + space(2) + ;
			"Dt Alta: " + dtoc(BE4->BE4_DTALTA) + space(2) + ;
			"Tipo: " + substr(BQR->BQR_DESTIP,1,15) + space(1) + ;
			"Autoriz: " + transform(BE4->(BE4_OPERDA+BE4_ANOINT+BE4_MESINT+BE4_NUMINT),"@R XXXX.XXXX.XX.XXXXXXXX") + space(2) + ;
			"Pad Conforto: " + transform(BN5->BN5_FATMUL,"@E 9.99") + space(3) + ;
			"CID: " + 	BE4->BE4_CID
			
			If lImpMatric
				//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
				//Ё Imprime nome da RDA                                                Ё
				//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
				//				nli := 999
				
				If  nli > nQtdLin
					nli := Cabec(cTitulo,cCabec1,cCabec2,cNomeProg,cTamanho,nCaracter)
					nli++
				Endif
				@ nLi, 0 pSay cLinha
				nli++
				nli++
				lImpMatric := .F.
			EndIf
			
			//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
			//Ё Monta query...                                                           Ё
			//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
			cSQL := "SELECT BD6_FILIAL, BD6_CODOPE, BD6_CODLDP, BD6_CODPEG, BD6_NUMERO, BD6_NUMIMP, BD6_DATPRO, BD6_CODPAD, BD6_CODPRO, "
			cSQL += "       BD6_DESPRO, BD6_QTDPRO, BD6_CID,    BD6_PERVIA, BD6_ORIMOV, BD6_SEQUEN, BD6_ANOPAG, BD6_MESPAG, "
			cSQL += " BD6_OPEUSR, BD6_CODEMP, BD6_MATRIC, BD6_TIPREG, BD6_DIGITO, BD6_NOMUSR, ' ' AS BD5_GUIINT, BD6_NUMLOT, BD6_CODRDA, bd6_vlrpag, br8_tpproc, BR8_DESCRI  "
			cSQL += " FROM " + RetSQLName("BD6") + " BD6, "+ RetSQLName("BR8") + " BR8 "
			cSQL += " WHERE BD6_FILIAL  = '" + xFilial("BD6") + "' "
			cSQL += " AND BD6_CODOPE  = '" + Trb->BD6_CODOPE  + "' "
			//		cSQL += " AND BD6_FASE <> '1' "
			cSQL += " AND BD6_CODLDP  = '" + Trb->BD6_CODLDP  + "' "
			cSQL += " AND BD6_CODOPE  = '" + Trb->BD6_CODOPE  + "' "
			cSQL += " AND BD6_CODPEG  = '" + Trb->BD6_CODPEG  + "' "
			cSQL += " AND BD6_NUMERO  = '" + Trb->BD6_NUMERO  + "' "
			//			cSQL += " AND BD6_ANOPAG  = '" + Trb->BD6_ANOPAG  + "' "
			//			cSQL += " AND BD6_MESPAG  = '" + Trb->BD6_MESPAG  + "' "
			cSQL += " AND BD6_CODRDA  = '" + Trb->BD6_CODRDA  + "' "
			cSQL += " AND BD6.d_e_l_e_t_ = ' ' "
		   	cSQL += " AND BR8_FILIAL = '  ' "
		   	cSQL += " AND BR8_CODPAD = BD6_CODPAD "
			cSQL += " AND BR8_CODPSA = BD6_CODPRO "
			cSQL += " AND BR8.D_E_L_E_T_ = ' ' "
			
			cSQL += " UNION ALL "
			cSQL += "SELECT BD6_FILIAL, BD6_CODOPE, BD6_CODLDP, BD6_CODPEG, BD6_NUMERO, BD6_NUMIMP, BD6_DATPRO, BD6_CODPAD, BD6_CODPRO, "
			cSQL += " BD6_DESPRO, BD6_QTDPRO, BD6_CID,    BD6_PERVIA, BD6_ORIMOV, BD6_SEQUEN, BD6_ANOPAG, BD6_MESPAG, "
			cSQL += " BD6_OPEUSR, BD6_CODEMP, BD6_MATRIC, BD6_TIPREG, BD6_DIGITO, BD6_NOMUSR, BD5_GUIINT, BD6_NUMLOT, BD6_CODRDA, bd6_vlrpag, br8_tpproc, BR8_DESCRI "
			cSQL += " FROM " + RetSQLName("BD6") + " BD6, "+ RetSQLName("BD5") + " BD5, "+ RetSQLName("BR8") + " BR8 "
			cSQL += " WHERE BD6_FILIAL  = '" + xFilial("BD6") + "' "
			cSQL += " AND BD6_FASE <> '1' "
			cSQL += " AND BD5_FILIAL  = '" + xFilial("BD5") + "' "
			cSQL += " AND BD5_CODOPE = BD6_CODOPE "
			cSQL += " AND BD5_CODLDP = BD6_CODLDP "
			cSQL += " AND BD5_CODPEG = BD6_CODPEG "
			cSQL += " AND BD5_NUMERO = BD6_NUMERO "
			//			cSQL += " AND BD5_ANOPAG = BD6_ANOPAG "
			//			cSQL += " AND BD5_MESPAG = BD6_MESPAG "
			cSQL += " AND BD5_CODRDA = BD6_CODRDA "
			//AND BD5_GUIINT = '000100000000615100000038'
			cSQL += " AND BD5_GUIINT = '" + Trb->(BD6_CODOPE+BD6_CODLDP+BD6_CODPEG+BD6_NUMERO) + "' "
			cSQL += " AND BD6.d_e_l_e_t_ = ' ' "
			cSQL += " AND BD5.d_e_l_e_t_ = ' ' "
			cSQL += " AND BR8_FILIAL = '  ' "
			cSQL += " AND BR8_CODPAD = BD6_CODPAD "
			cSQL += " AND BR8_CODPSA = BD6_CODPRO "
			cSQL += " AND BR8.D_E_L_E_T_ = ' ' "
			
			
			cSQL += " ORDER BY BD6_CODLDP, BD6_CODPEG, BD6_NUMERO"
			
			//memowrit("C:\CABR020A.SQL",cSQL)  
			//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
			//Ё Executa query...                                                         Ё
			//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
			PLSQuery(cSQL,"TrbBD6")
			//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
			//Ё Processa todas as guias deste usuario                              Ё
			//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
			
			cImpRDA := .T.
			
			BA1->(DbSetOrder(1))
			BA1->(dbSeek(xFilial("BA1")+Trb->(BD6_OPEUSR+BD6_CODEMP+BD6_MATRIC+BD6_TIPREG)))
			//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
			//Ё Imprime usuario, se for relatorio analitico...                     Ё
			//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
			nIdade := Calc_Idade(BD6_DATPRO,BA1->BA1_DATNAS)
			nFaixa := RetFai(nIdade)
			
			While !TrbBD6->(eof())
				
				If !empty(cCompAte) .or. val(cCompAte) > 0
					If TrbBD6->(BD6_ANOPAG+BD6_MESPAG) < cCompDe .or. TrbBD6->(BD6_ANOPAG+BD6_MESPAG) > cCompAte
						TrbBD6->(DbSkip())
						loop
					EndIf
				EndIf
				
				If !empty(cCompPagAte) .and. val(cCompPagAte) > 0
					If Trb->(SubStr(BD6_numlot,1,6)) < cCompPagDe .or. Trb->(SubStr(BD6_numlot,1,6)) > cCompPagAte
						Trb->(DbSkip())
						loop
					EndIf
				EndIf
				
//				BR8->(DbSetOrder(1))
//				BR8->(dbSeek(xFilial("BR8")+TrbBD6->(BD6_CODPAD+BD6_CODPRO)))
				
				//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
				//Ё Nao considera os Honorarios Medicos                                Ё
				//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
				If cLisHonMed == 2 .and. TrbBD6->BR8_TPPROC == "0"  //BR8->BR8_TPPROC == "0"
					TrbBD6->(DbSkip())
					loop
				EndIf
				
				nVlrPag := 0
				nVlrGlo := 0
				//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
				//Ё Posiciona BD7-Composicao do Procedimento                           Ё
				//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
				BD7->(dbSeek(xFilial("BD7")+TrbBD6->(BD6_CODOPE+BD6_CODLDP+BD6_CODPEG+BD6_NUMERO+BD6_ORIMOV+BD6_SEQUEN)))
				While ! BD7->(eof()) .and. BD7->(BD7_FILIAL+BD7_CODOPE+BD7_CODLDP+BD7_CODPEG+BD7_NUMERO+BD7_ORIMOV+BD7_SEQUEN) == ;
					xFilial("BD7")+TrbBD6->(BD6_CODOPE+BD6_CODLDP+BD6_CODPEG+BD6_NUMERO+BD6_ORIMOV+BD6_SEQUEN)
					//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
					//Ё Salta itens bloqueados                                             Ё
					//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
					If (BD7->BD7_BLOPAG == "1" .OR. BD7->BD7_VLRPAG == 0)
						BD7->(dbSkip())
						Loop
					EndIf
					
					If !empty(cCompPagAte) .or. val(cCompPagAte) > 0
						If SubStr(BD7->BD7_NUMLOT,1,6) < cCompPagDe .and. SubStr(BD7->BD7_NUMLOT,1,6) > cCompPagAte
							BD7->(dbSkip())
							Loop
						Endif
					EndIf
					
					nVlrPag += BD7->BD7_VLRPAG
					nVlrGlo += BD7->BD7_VLRGLO
					
					//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
					//Ё Acessa proximo registro                                            Ё
					//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
					BD7->(dbSkip())
				Enddo
				//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
				//Ё Monta dados da guia                                                Ё
				//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
				If nVlrPag > 0
					
					/*
					If cImpRDA
					//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
					//Ё Imprime identificaco da guia                                       Ё
					//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
					cLinha := "Guia: " + transform(TrbBD6->(BD6_CODLDP+BD6_CODPEG+BD6_NUMERO+BD6_ORIMOV),"@R XXXX.XXXXXXXX.XXXXXXXX") + space(3) + ;
					"Impresso: " + TrbBD6->BD6_NUMIMP + space(3) + ;
					"RDA: " + TrbBD6->BD6_CODRDA +" - " + posicione("BAU",1,xFilial("BAU")+TrbBD6->BD6_CODRDA,"BAU_NOME") + space(3) + ;
					"Competencia: " + TrbBD6->BD6_MESPAG + "/" + TrbBD6->BD6_ANOPAG
					
					If  nli > nQtdLin
					nli := Cabec(cTitulo,cCabec1,cCabec2,cNomeProg,cTamanho,nCaracter)
					nli++
					Endif
					@ nLi, 0 pSay cLinha
					nli++
					nli++
					cImpRDA := .F.
					EndIf
					*/
					
					cGuia := TrbBD6->BD6_SEQUEN + space(3) + ;
					TrbBD6->BD6_CODPAD + space(2) + ;
					transform(TrbBD6->BD6_CODPRO,"@R XX.XX.XXX-X") + space(3) + ;
					substr(posicione("BR8",1,xFilial("BR8")+TrbBD6->(BD6_CODPAD+BD6_CODPRO),"BR8_DESCRI"),1,56) + space(3) + ;
					transform(TrbBD6->BD6_QTDPRO,"@E 99")+ space(3) +;  //					transform(TrbBD6->BD6_PERVIA,"@E 999.99") + space(3) +;  //			transform(BD7->BD7_FATMUL,"@E 9.99") + space(3) + ;
					dtoc(TrbBD6->BD6_DATPRO) + space(3) + ;
					transform(nVlrPag,"@E 99,999.99") + space(3) + ;     //transform(nVlrGlo,"@E 99,999.99") + space(3) + ;
					transform(TrbBD6->(BD6_CODLDP+BD6_CODPEG+BD6_NUMERO+BD6_ORIMOV),"@R XXXX.XXXXXXXX.XXXXXXXX") + space(3) + ;
					TrbBD6->BD6_NUMIMP + space(3) + ;
					TrbBD6->BD6_CODRDA +" - " + posicione("BAU",1,xFilial("BAU")+TrbBD6->BD6_CODRDA,"BAU_NOME") + space(3) + ;
					TrbBD6->BD6_MESPAG + "/" + TrbBD6->BD6_ANOPAG
					
					If  nli > nQtdLin
						nli := Cabec(cTitulo,cCabec1,cCabec2,cNomeProg,cTamanho,nCaracter)
						nli++
					Endif
					@ nLi, 0 pSay cGuia
					nli++
					
					nPos := Ascan(aFreqEve,{|x| x[1] == TrbBD6->BD6_CODPAD .and. x[2] == TrbBD6->BD6_CODPRO .and. x[3] == Alltrim(BA1->BA1_TIPUSU) .and. x[4]== Alltrim(BA1->BA1_SEXO) .And. x[5] == nFaixa  })
					If nPos = 0
						aadd(aFreqEve,{TrbBD6->BD6_CODPAD, TrbBD6->BD6_CODPRO, Alltrim(BA1->BA1_TIPUSU), Alltrim(BA1->BA1_SEXO), nFaixa, TrbBD6->BD6_QTDPRO , TrbBD6->BD6_VLRPAG })
					Else
						aFreqEve[nPos][6] += TrbBD6->BD6_QTDPRO
						aFreqEve[nPos][7] += TrbBD6->BD6_VLRPAG
					Endif
					
					nPos := Ascan(aMapProc,{|x| x[1] == TrbBD6->BR8_TPPROC })
					If nPos = 0
						aadd(aMapProc,{TrbBD6->BR8_TPPROC, Alltrim(BA1->BA1_TIPUSU), Alltrim(BA1->BA1_SEXO), nFaixa, TrbBD6->BD6_QTDPRO , TrbBD6->BD6_VLRPAG })
					Else
						aMapProc[nPos][5] += TrbBD6->BD6_QTDPRO
						aMapProc[nPos][6] += TrbBD6->BD6_VLRPAG
					Endif

					nPos := Ascan(aMapHMTot,{|x| x[1] == TrbBD6->BR8_TPPROC })
					If nPos == 0
						aadd(aMapHMTot,{TrbBD6->BR8_TPPROC, Alltrim(BA1->BA1_TIPUSU), Alltrim(BA1->BA1_SEXO), nFaixa, TrbBD6->BD6_QTDPRO , TrbBD6->BD6_VLRPAG })
					Else
						aMapHMTot[nPos][5] += TrbBD6->BD6_QTDPRO
						aMapHMTot[nPos][6] += TrbBD6->BD6_VLRPAG
					Endif

					nPos := Ascan(aFreqTot,{|x| x[1] == TrbBD6->BD6_CODPAD .and. x[2] == TrbBD6->BD6_CODPRO .and. x[3] == Alltrim(BA1->BA1_TIPUSU) .and. x[4]== Alltrim(BA1->BA1_SEXO) .And. x[5] == nFaixa  })
					If nPos == 0
						aadd(aFreqTot,{TrbBD6->BD6_CODPAD, TrbBD6->BD6_CODPRO, Alltrim(BA1->BA1_TIPUSU), Alltrim(BA1->BA1_SEXO), nFaixa, TrbBD6->BD6_QTDPRO , TrbBD6->BD6_VLRPAG })
					Else
						aFreqTot[nPos][6] += TrbBD6->BD6_QTDPRO
						aFreqTot[nPos][7] += TrbBD6->BD6_VLRPAG
					Endif
					
				EndIf
				
				cGuia   := space(105)
				nTVlrPag += nVlrPag
				nTVlrGlo += nVlrGlo
				
				nVlrPag := 0
				nVlrGlo := 0
				
				//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
				//Ё Acessa proximo registro                                            Ё
				//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
				TrbBD6->(dbSkip())
			Enddo
			
			//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
			//Ё Monta query para pesquisar as orteses e proteses pagas pelo saude...     Ё
			//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
			cSQL := "SELECT BD6_FILIAL, BD6_CODOPE, BD6_CODLDP, BD6_CODPEG, BD6_NUMERO, BD6_NUMIMP, BD6_DATPRO, BD6_CODPAD, BD6_CODPRO, "
			cSQL += " BD6_DESPRO, BD6_QTDPRO, BD6_CID, BD6_PERVIA, BD6_ORIMOV, BD6_SEQUEN, BD6_ANOPAG, BD6_MESPAG, "
			cSQL += " BD6_OPEUSR, BD6_CODEMP, BD6_MATRIC, BD6_TIPREG, BD6_DIGITO, BD6_NOMUSR, ' ' AS BD5_GUIINT, BD6_NUMLOT, BD6_CODRDA, bd6_vlrpag, BR8_TPPROC, BR8_DESCRI "
			cSQL += " FROM " + RetSQLName("BD6") + " BD61, "+ RetSQLName("BR8") + " BR8 "
			cSQL += " WHERE BD6_FILIAL  = '" + xFilial("BD6") + "' "
			cSQL += " AND BD6_CODOPE  = '" + Trb->BD6_CODOPE  + "' "
			cSQL += " AND BD6_FASE   = '3' "
			cSQL += " AND BD6_SITUAC =  '2' "
			cSQL += " AND BD6_CODLDP = '0012' "
			cSQL += " AND BD6_OPEUSR = '"+Trb->BD6_OPEUSR + "' "
			cSQL += " AND BD6_CODEMP = '"+Trb->BD6_CODEMP + "' "
			cSQL += " AND BD6_MATRIC = '"+Trb->BD6_MATRIC + "' "
			cSQL += " AND BD6_TIPREG = '"+Trb->BD6_TIPREG + "' "
			cSQL += " AND BD6_DATPRO BETWEEN '" + Dtos(BE4->BE4_DATPRO) + "' AND '"+ DtoS(BE4->BE4_DTALTA) + "' "
			cSQL += " AND BD6_CODPAD = '01' "
			cSQL += " AND BD6_CODPRO = '83000089' "
			cSQL += " AND BR8_FILIAL = '  ' "
			cSQL += " AND BR8_CODPAD = BD6_CODPAD "
			cSQL += " AND BR8_CODPSA = BD6_CODPRO "
			cSQL += " AND BR8.D_E_L_E_T_ = ' ' "
			cSQL += " AND BD61.d_e_l_e_t_ = ' ' "
			
			//Incluido por Luzio em 20/08/2009 para que considere as OPME que foram cadastrados pelo padrao e que estao bloqueados.
			// Guias com as guias do OPME pagas a Fornecedores por nota fiscal.
			cSQL += " UNION "
			
			cSQL := "SELECT BD6_FILIAL, BD6_CODOPE, BD6_CODLDP, BD6_CODPEG, BD6_NUMERO, BD6_NUMIMP, BD6_DATPRO, BD6_CODPAD, BD6_CODPRO, "
			cSQL += " BD6_DESPRO, BD6_QTDPRO, BD6_CID, BD6_PERVIA, BD6_ORIMOV, BD6_SEQUEN, BD6_ANOPAG, BD6_MESPAG, "
			cSQL += " BD6_OPEUSR, BD6_CODEMP, BD6_MATRIC, BD6_TIPREG, BD6_DIGITO, BD6_NOMUSR, ' ' AS BD5_GUIINT, BD6_NUMLOT, "
			cSQL += " BD6_CODRDA, bd6_vlrpag, BR8_TPPROC, BR8_DESCRI "
			cSQL += " FROM " + RetSQLName("BD6") + " BD6, " + RetSQLName("BD7") + " BD7, " + RetSQLName("B19") + " B19, "+ RetSQLName("BR8") + " BR8 "
			cSQL += " WHERE BD6_FILIAL  = '" + xFilial("BD6") + "' "
			cSQL += " AND BD6_CODOPE  = '" + Trb->BD6_CODOPE  + "' "
			cSQL += " AND BD6_CODLDP  = '" + Trb->BD6_CODLDP  + "' "
			cSQL += " AND BD6_CODOPE  = '" + Trb->BD6_CODOPE  + "' "
			cSQL += " AND BD6_CODPEG  = '" + Trb->BD6_CODPEG  + "' "
			cSQL += " AND BD6_NUMERO  = '" + Trb->BD6_NUMERO  + "' "
			//cSQL += " AND BD6_ANOPAG  = '" + Trb->BD6_ANOPAG  + "' "
			//cSQL += " AND BD6_MESPAG  = '" + Trb->BD6_MESPAG  + "' "
			cSQL += " AND BD6_CODRDA  = '" + Trb->BD6_CODRDA  + "' "
			//cSQL += " AND BD6_FASE     = '3' "         //Fase da Guia igual a PRONTA
			//cSQL += " AND BD6_SITUAC   = '1' "         //Situacao igual
			cSql += " AND BD7_FILIAL = '" + xFilial("BD7") + "' "
			cSQL += " AND BD7_CODOPE = BD6_CODOPE "
			cSQL += " AND BD7_CODLDP = BD6_CODLDP "
			cSQL += " AND BD7_CODPEG = BD6_CODPEG "
			cSQL += " AND BD7_NUMERO = BD6_NUMERO "
			cSQL += " AND BD7_ORIMOV = BD6_ORIMOV "
			cSQL += " AND BD7_SEQUEN = BD6_SEQUEN "
			cSQL += " AND BD7_BLOPAG = '1' "             //Bloqueio de pagamento da composicao do prodcedimento
			cSQL += " AND BD7_NUMLOT = '     ' "
			cSQL += " AND B19_GUIA   = BD6_CODOPE||BD6_CODLDP||BD6_CODPEG||BD6_NUMERO||BD6_ORIMOV||BD6_SEQUEN "
			cSQL += " AND B19_COD    = BD6_CODPRO "
			cSQL += " AND BD6.D_E_L_E_T_ <> '*' "
			cSQL += " AND BD7.D_E_L_E_T_ <> '*' "
			cSQL += " AND B19.D_E_L_E_T_ <> '*' "
			cSQL += " AND BR8_FILIAL = '  ' "
			cSQL += " AND BR8_CODPAD = BD6_CODPAD "
			cSQL += " AND BR8_CODPSA = BD6_CODPRO "
			cSQL += " AND BR8.D_E_L_E_T_ = ' ' "
			
			/* Nova query para apurar as OPME e os reembolsos referente a estes atendimentos
			// Processa as guias de reembolso realziadas pela rotina padrao.
			cSQL += " UNION "
			cSQL += " SELECT BD6_FILIAL, BD6_CODOPE, B45_CODLDP AS BD6_CODLDP, B45_CODPEG AS BD6_CODPEG, B45_NUMERO AS BD6_NUMERO, BD6_NUMIMP "
			cSQL += " 		B45_DATPRO AS BD6_DATPRO, B45_CODPAD AS BD6_CODPAD, B45_CODPRO AS BD6_CODPRO, "
			cSQL += " 		BD6_DESPRO, B45_QTDPRO AS BD6_QTDPRO, BD6_CID, BD6_PERVIA, B45_ORIMOV AS BD6_ORIMOV, B45_SEQUEN AS BD6_SEQUEN, "
			cSQL += " 		B44_ANOPAG AS BD6_ANOPAG, B44_MESPAG AS BD6_MESPAG, "
			cSQL += " 		B44_OPEUSR AS BD6_OPEUSR, B44_CODEMP AS BD6_CODEMP, B44_MATRIC AS BD6_MATRIC, B44_TIPREG AS BD6_TIPREG, "
			cSQL += " 		B44_DIGITO AS BD6_DIGITO, B44_NOMUSR AS BD6_NOMUSR, BD5_GUIINT, B44_NUM AS BD7_NUMLOT, B44_REGEXE AS BD6_CODRDA, "
			cSQL += " 		B45_VLRPAG AS BD6_VLRPAG "
			cSQL += "       FROM "+RetSqlName("B44")+" B44, "+RetSqlName("B45")+" B45, "+RetSqlName("BD6")+" BD6, "+RetSqlName("BD7")+" BD7, "
			cSQL += RetSqlName("SE1")+" SE1, "+RetSqlName("SE2")+" SE2 "
			cSQL += "       WHERE B45_FILIAL = '" + xFilial("B45") + "' "
			cSQL += "         AND B44_FILIAL = '" + xFilial("B44") + "' "
			cSQL += "         AND BD7_FILIAL = '" + xFilial("BD7") + "' "
			cSQL += "         AND BD6_FILIAL = '" + xFilial("BD6") + "' "
			cSQL += "         AND E1_FILIAL  = '01'
			cSQL += " 			AND BD6_CODOPE  = '" + Trb->BD6_CODOPE  + "' "
			cSQL += " 			AND BD6_CODLDP  = '" + Trb->BD6_CODLDP  + "' "
			cSQL += " 			AND BD6_CODOPE  = '" + Trb->BD6_CODOPE  + "' "
			cSQL += " 			AND BD6_CODPEG  = '" + Trb->BD6_CODPEG  + "' "
			cSQL += " 			AND BD6_NUMERO  = '" + Trb->BD6_NUMERO  + "' "
			//cSQL += " AND BD6_ANOPAG  = '" + Trb->BD6_ANOPAG  + "' "
			//cSQL += " AND BD6_MESPAG  = '" + Trb->BD6_MESPAG  + "' "
			cSQL += " 			AND BD6_CODRDA  = '" + Trb->BD6_CODRDA  + "' "
			cSQL += "         AND B44_CODLDP = B45_CODLDP "
			cSQL += "         AND B44_CODPEG = B45_CODPEG "
			cSQL += "         AND B44_NUMAUT = B45_NUMAUT "
			cSQL += "         AND B44_NUM <> '   ' "
			cSQL += "         AND B44_YSITUA = '2' "
			cSQL += "         AND B44_PREFIX = E1_PREFIXO "
			cSQL += "         AND B44_NUM    = E1_NUM "
			cSQL += "         AND B45_VLRPAG > 0 "
			
			cSQL += "         AND BD6_CODLDP = B45_CODLDP "
			cSQL += "         AND BD6_CODPEG = B45_CODPEG "
			cSQL += "         AND BD6_NUMERO = B45_NUMERO "
			//cSQL += "       AND BD6_ORIMOV = B45_ORIMOV "
			cSQL += "         AND BD6_SEQUEN = B45_SEQUEN "
			
			
			cSQL += "         AND BD7_CODOPE = BD6_CODOPE "
			cSQL += "         AND BD7_CODLDP = BD6_CODLDP "
			cSQL += "         AND BD7_CODPEG = BD6_CODPEG "
			cSQL += "         AND BD7_NUMERO = BD6_NUMERO "
			cSQL += "         AND BD7_ORIMOV = BD6_ORIMOV "
			cSQL += "         AND BD7_SEQUEN = BD6_SEQUEN "
			//cSQL += "         AND DECODE(E2_VENCREA,NULL,SubStr(E1_VENCREA,1,6),SubStr(E2_VENCREA,1,6)) = '200906' "
			cSQL += "         AND BD7_CODPEG = BD6_CODPEG "
			cSQL += "         AND BD7_NUMERO = BD6_NUMERO "
			cSQL += "         AND BD7_ORIMOV = BD6_ORIMOV "
			cSQL += "         AND BD7_SEQUEN = BD6_SEQUEN "
			cSQL += "         AND (BD6_OPEUSR||BD6_CODEMP||BD6_MATRIC||BD6_TIPREG <> '0001000600360300' AND BD6_CODLDP = '9000' ) "
			cSQL += "         AND E1_PREFIXO||E1_NUM||E1_PARCELA||E1_TIPO = E2_TITORIG(+) "
			cSQL += "         AND B44.D_E_L_E_T_=' ' "
			cSQL += "         AND B45.D_E_L_E_T_=' ' "
			cSQL += "         AND BD6.D_E_L_E_T_=' ' "
			cSQL += "         AND BD7.D_E_L_E_T_=' ' "
			cSQL += "         AND SE1.D_E_L_E_T_=' ' "
			cSQL += "         AND SE2.D_E_L_E_T_=' ' "
			
			*/
			//memowrit("C:\CABR020B.SQL",cSQL)     
			//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
			//Ё Executa query...                                                         Ё
			//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
			PLSQuery(cSQL,"TrbBD6A")
			
			While !TrbBD6A->(eof())
				If TrbBD6A->BD6_VLRPAG > 0
					
					/*
					cLinha := transform(TrbBD6A->(BD6_CODLDP+BD6_CODPEG+BD6_NUMERO+BD6_ORIMOV),"@R XXXX.XXXXXXXX.XXXXXXXX") + space(3) + ;
					TrbBD6A->BD6_SEQUEN + space(3) + ;
					TrbBD6A->BD6_NUMIMP + space(3) + ;
					TrbBD6A->BD6_MESPAG + "/" + TrbBD6->BD6_ANOPAG+ space(3) + ;
					TrbBD6A->BD6_CODPAD + space(2) + ;
					transform(TrbBD6A->BD6_CODPRO,"@R XX.XX.XXX-X") + space(3) + ;
					substr(posicione("BR8",1,xFilial("BR8")+TrbBD6A->(BD6_CODPAD+BD6_CODPRO),"BR8_DESCRI"),1,56) + space(3) + ;
					transform(TrbBD6A->BD6_QTDPRO,"@E 99")+ space(3) +;
					transform(TrbBD6A->BD6_PERVIA,"@E 999.99") + space(3) +;
					dtoc(TrbBD6A->BD6_DATPRO) + space(3) + ;
					transform(nVlrPag,"@E 99,999.99")
					transform(TrbBD6A->(BD6_CODLDP+BD6_CODPEG+BD6_NUMERO+BD6_ORIMOV),"@R XXXX.XXXXXXXX.XXXXXXXX") + space(3) + ;
					TrbBD6A->BD6_NUMIMP + space(3) + ;
					TrbBD6A->BD6_CODRDA +" - " + posicione("BAU",1,xFilial("BAU")+TrbBD6A->BD6_CODRDA,"BAU_NOME") + space(3) + ;
					TrbBD6A->BD6_MESPAG + "/" + TrbBD6A->BD6_ANOPAG
					*/
					cLinha := TrbBD6A->BD6_SEQUEN + space(3) + ;
					TrbBD6A->BD6_CODPAD + space(2) + ;
					transform(TrbBD6A->BD6_CODPRO,"@R XX.XX.XXX-X") + space(3) + ;
					substr(posicione("BR8",1,xFilial("BR8")+TrbBD6A->(BD6_CODPAD+BD6_CODPRO),"BR8_DESCRI"),1,56) + space(3) + ;
					transform(TrbBD6A->BD6_QTDPRO,"@E 99")+ space(3) +;  //					transform(TrbBD6->BD6_PERVIA,"@E 999.99") + space(3) +;  //			transform(BD7->BD7_FATMUL,"@E 9.99") + space(3) + ;
					dtoc(TrbBD6A->BD6_DATPRO) + space(3) + ;
					transform(TrbBD6A->BD6_VLRPAG,"@E 99,999.99") + space(3) + ;     //transform(nVlrGlo,"@E 99,999.99") + space(3) + ;
					transform(TrbBD6A->(BD6_CODLDP+BD6_CODPEG+BD6_NUMERO+BD6_ORIMOV),"@R XXXX.XXXXXXXX.XXXXXXXX") + space(3) + ;
					TrbBD6A->BD6_NUMIMP + space(3) + ;
					TrbBD6A->BD6_CODRDA +" - " + posicione("BAU",1,xFilial("BAU")+TrbBD6A->BD6_CODRDA,"BAU_NOME") + space(3) + ;
					TrbBD6A->BD6_MESPAG + "/" + TrbBD6A->BD6_ANOPAG
					
					If  nli > nQtdLin
						nli := Cabec(cTitulo,cCabec1,cCabec2,cNomeProg,cTamanho,nCaracter)
						nli++
					Endif
					@ nLi, 0 pSay cLinha
					nli++
					
					nPos := Ascan(aFreqEve,{|x| x[1] == TrbBD6A->BD6_CODPAD .and. x[2] == TrbBD6A->BD6_CODPRO .and. x[3] == Alltrim(BA1->BA1_TIPUSU) .and. x[4]== Alltrim(BA1->BA1_SEXO) .And. x[5] == nFaixa  })
					If nPos = 0
						aadd(aFreqEve,{TrbBD6A->BD6_CODPAD, TrbBD6A->BD6_CODPRO, Alltrim(BA1->BA1_TIPUSU), Alltrim(BA1->BA1_SEXO), nFaixa, TrbBD6A->BD6_QTDPRO , TrbBD6A->BD6_VLRPAG })
					Else
						aFreqEve[nPos][6] += TrbBD6A->BD6_QTDPRO
						aFreqEve[nPos][7] += TrbBD6A->BD6_VLRPAG
					Endif

					nPos := Ascan(aMapProc,{|x| x[1] == TrbBD6A->BR8_TPPROC })
					If nPos = 0
						aadd(aMapProc,{TrbBD6A->BR8_TPPROC, Alltrim(BA1->BA1_TIPUSU), Alltrim(BA1->BA1_SEXO), nFaixa, TrbBD6A->BD6_QTDPRO , TrbBD6A->BD6_VLRPAG })
					Else
						aMapProc[nPos][5] += TrbBD6A->BD6_QTDPRO
						aMapProc[nPos][6] += TrbBD6A->BD6_VLRPAG
					Endif

					nPos := Ascan(aMapHMTot,{|x| x[1] == TrbBD6A->BR8_TPPROC })
					If nPos == 0
						aadd(aMapHMTot,{TrbBD6A->BR8_TPPROC, Alltrim(BA1->BA1_TIPUSU), Alltrim(BA1->BA1_SEXO), nFaixa, TrbBD6A->BD6_QTDPRO , TrbBD6A->BD6_VLRPAG })
					Else
						aMapHMTot[nPos][5] += TrbBD6A->BD6_QTDPRO
						aMapHMTot[nPos][6] += TrbBD6A->BD6_VLRPAG
					Endif
					
					nPos := Ascan(aFreqTot,{|x| x[1] == TrbBD6A->BD6_CODPAD .and. x[2] == TrbBD6A->BD6_CODPRO .and. x[3] == Alltrim(BA1->BA1_TIPUSU) .and. x[4]== Alltrim(BA1->BA1_SEXO) .And. x[5] == nFaixa  })
					If nPos == 0
						aadd(aFreqTot,{TrbBD6A->BD6_CODPAD, TrbBD6A->BD6_CODPRO, Alltrim(BA1->BA1_TIPUSU), Alltrim(BA1->BA1_SEXO), nFaixa, TrbBD6A->BD6_QTDPRO , TrbBD6A->BD6_VLRPAG })
					Else
						aFreqTot[nPos][6] += TrbBD6A->BD6_QTDPRO
						aFreqTot[nPos][7] += TrbBD6A->BD6_VLRPAG
					Endif
					cLinha   := space(105)
					
					nTVlrPag += TrbBD6A->BD6_VLRPAG
					//				nTVlrGlo += TrbBD6A->BD6_VLRGLO
					
					nVlrPag := 0
					nVlrGlo := 0
				EndIf
				
				//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
				//Ё Acessa proximo registro                                            Ё
				//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
				TrbBD6A->(dbSkip())
			Enddo
			
			If nTVlrPag > 0
				//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
				//Ё Imprime separador de linhas                                        Ё
				//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
				cLinha := "Total da Guia" + space(50) + ;
				transform(nTVlrPag,"@E 999,999.99") + space(3) + ;
				transform(nTVlrGlo,"@E 999,999.99")
				If  nli > nQtdLin
					nli := Cabec(cTitulo,cCabec1,cCabec2,cNomeProg,cTamanho,nCaracter)
					nli++
				Endif
				@ nLi, 0 pSay replicate("-",220)
				nli++
				@ nLi, 0 pSay cLinha
				nli++
				nli++
			EndIf
			
			nT1VlrPag += nTVlrPag
			nT1VlrGlo += nTVlrGlo
			
			nTVlrPag := 0
			nTVlrGlo := 0
			
			//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
			//Ё Fecha arquivo de trabalho                                          Ё
			//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
			TrbBD6A->(DbCloseArea())
			TrbBD6->(DbCloseArea())
			
			Trb->(dbSkip())
		Enddo
		
		If nT1VlrPag > 0
			//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
			//Ё Imprime separador de linhas                                        Ё
			//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
			cLinha := "Total do beneficiario" + space(50) + ;
			transform(nT1VlrPag,"@E 999,999.99") + space(3) + ;
			transform(nT1VlrGlo,"@E 999,999.99")
			
			If  nli > nQtdLin
				nli := Cabec(cTitulo,cCabec1,cCabec2,cNomeProg,cTamanho,nCaracter)
				nli++
			Endif
			@ nLi, 0 pSay replicate("-",220)
			nli++
			@ nLi, 0 pSay cLinha
			nli++
			nli++
			//	   	nli := 999
		EndIf
		nTotVlrPag += nt1VlrPag
		nTotVlrGlo += nt1VlrGlo
		nT1VlrPag := 0
		nT1VlrGlo := 0
		
		/*
		For n = 1 to len(aFreqEve)
		cLinha := "| " + transform(aFreqEve[n][2],"@R XX.XX.XXX-X") + " - " + ;
		substr(posicione("BR8",1,xFilial("BR8")+aFreqEve[n][1]+aFreqEve[n][2],"BR8_DESCRI"),1,56)+ " | " + ;
		transform(aFreqEve[n][6],"@E 999999") + " | " + ;
		transform(aFreqEve[n][7],"@E 999,999.99") + " | " + ;
		transform((aFreqEve[n][7]/aFreqEve[n][6]),"@E 999,999.99")+ " | "  //Media por procedimento
		
		If  nli > nQtdLin
		nli := Cabec(cTitulo,cCabec1,cCabec2,cNomeProg,cTamanho,nCaracter)
		nli++
		Endif
		If n == 1
		@ nLi, 0 pSay replicate("-",110)
		nli++
		EndIf
		@ nLi, 0 pSay cLinha
		nli++
		Next
		@ nLi, 0 pSay replicate("-",110)
		*/
		
		//*****************************************************************************************************************
	ElseIf nOrdSel == 2
		
		If cAnaSin == 1
			cCabec2 := "Guia               Impresso Compet. Procedimento   Descricao                                                 Qtd               % Via   Dt Atend  Fator    Vlr Pago"
		Else
			cCabec2 := "RDA                                                         Frequencia    Vlr Pago  Custo Medio"
		EndIf
		//                    xxxx.xxxxxx.xxxxxx
		If !Empty(Trb->(BD5_GUIINT))
			Trb->(DbSkip())
			loop
		EndIf
		
		//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
		//Ё Imprime codigo do procedimento                                     Ё
		//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
		If  nli > nQtdLin
			nli := Cabec(cTitulo,cCabec1,cCabec2,cNomeProg,cTamanho,nCaracter)
			nli++
			nLi++
		Endif
		
		//		@ nLi, 0 pSay cLinha
		//		nli++
		//		nli++
		
		/*
		//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
		//Ё Inicializ variaveis                                                Ё
		//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
		cCodPro := Trb->(BD6_CODPAD+BD6_CODPRO)
		
		cCabec1 := "PROCEDIMENTO: " + Trb->BD6_CODPAD + space(2) + ;
		transform(Trb->BD6_CODPRO,"@R XX.XX.XXX-X") + space(3) + ;
		substr(posicione("BR8",1,xFilial("BR8")+Trb->(BD6_CODPAD+BD6_CODPRO),"BR8_DESCRI"),1,56)
		
		//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
		//Ё Imprime codigo do procedimento                                     Ё
		//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
		If  nli > nQtdLin
		nli := Cabec(cTitulo,cCabec1,cCabec2,cNomeProg,cTamanho,nCaracter)
		nli++
		nLi++
		Endif
		//		@ nLi, 0 pSay cLinha
		//		nli++
		//		nli++
		*/
		
		While ! Trb->(Eof()) .and. Trb->(BD6_CODPAD+BD6_CODPRO) == cCodPro
			If !Empty(Trb->(BD5_GUIINT))
				Trb->(DbSkip())
				loop
			EndIf

			//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
			//Ё Inicializ variaveis                                                Ё
			//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
			cCodRDA := Trb->(BD6_CODRDA)
			
			lImpMatric := .T.
			nFrequenc := 0
			
			aFreqEve := {}
			aMapProc := {}
			
			While ! Trb->(Eof()) .and. Trb->(BD6_CODPAD+BD6_CODPRO) == cCodPro  .and. Trb->(BD6_CODRDA) == cCodRDA
				
				//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
				//Ё Separa a Competencia Selecionada                                   Ё
				//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
				If !Empty(Trb->(BD5_GUIINT))
					Trb->(DbSkip())
					loop
				EndIf
				
				//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
				//Ё Separa a Competencia Selecionada                                   Ё
				//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
				If !empty(cCompAte) .and. val(cCompAte) > 0
					If Trb->(BD6_ANOPAG+BD6_MESPAG) < cCompDe .or. Trb->(BD6_ANOPAG+BD6_MESPAG) > cCompAte
						Trb->(DbSkip())
						loop
					EndIf
				EndIf
				
				If !empty(cCompPagAte) .and. val(cCompPagAte) > 0
					If Trb->(SubStr(BD6_numlot,1,6)) < cCompPagDe .or. Trb->(SubStr(BD6_numlot,1,6)) > cCompPagAte
						Trb->(DbSkip())
						loop
					EndIf
				EndIf
				
				//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
				//Ё Verifica se foi abortada a impressao...                            Ё
				//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
				If  Interrupcao(lAbortPrint)
					nLi ++
					@ nLi, nColuna pSay PLSTR0002
					Exit
				Endif
				
				//				BAU->(DbSetOrder(1))
				//				BAU->(dbSeek(xFilial("BA1")+cCodRDA))
				
				//				cLinha := "RDA: " + Trb->BD6_CODRDA +" - " + posicione("BAU",1,xFilial("BAU")+Trb->BD6_CODRDA,"BAU_NOME")
				cLinha := "RDA: " + cCodRDA +" - " + posicione("BAU",1,xFilial("BAU")+cCodRDA,"BAU_NOME")
				
				If cAnaSin == 1
					If lImpMatric
						//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
						//Ё Imprime nome da RDA                                                Ё
						//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
						If  nli > nQtdLin
							nli := Cabec(cTitulo,cCabec1,cCabec2,cNomeProg,cTamanho,nCaracter)
						Endif
						nli++
						@ nLi, 0 pSay cLinha
						nli++
						nli++
						lImpMatric := .F.
					EndIf
				EndIf
				
				cMatric := Trb->(BD6_OPEUSR+BD6_CODEMP+BD6_MATRIC+BD6_TIPREG)
				
				cCodOpe := Trb->BD6_CODOPE
				cCodLdp := TRB->BD6_CODLDP
				cCodPeg := TRB->BD6_CODPEG
				cCodPeg := TRB->BD6_NUMERO
				
				While ! Trb->(Eof()) .and. Trb->(BD6_OPEUSR+BD6_CODEMP+BD6_MATRIC+BD6_TIPREG) == cMatric
					//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
					//Ё Exibe mensagem...                                                  Ё
					//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
					Npercent := (nProc/nTotal)*100
					IncProc("Processando: " + Transform(Npercent,"@E 9,999.9") + "  % do Total de: "+ Transform(nTotal,"@E 9999999"))
					ProcessMessage()
					
					nProc++
					
					//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
					//Ё Separa a Competencia Selecionada                                   Ё
					//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
					If !Empty(Trb->(BD5_GUIINT))
						Trb->(DbSkip())
						loop
					EndIf
					
					BE4->(DbSetOrder(1))
					If BE4->(DbSeek(xFilial("BE4")+Trb->(BD6_CODOPE+BD6_CODLDP+BD6_CODPEG+BD6_NUMERO)))
						
						//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
						//Ё Posiciona tabelas                                                  Ё
						//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
						BQR->(dbSeek(xFilial("BQR")+BE4->(BE4_GRPINT+BE4_TIPINT)))
						BN5->(dbSeek(xFilial("BN5")+BE4->(BE4_CODOPE+BE4_PADCON)))
					EndIf
					
					//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
					//Ё Separa a Competencia Selecionada                                   Ё
					//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
					If Empty(BE4->BE4_DATPRO)
						//						Trb->(DbSkip())
						//						loop
						
						//Leonardo Portella - 07/11/14 - Inicio - Virada TISS 3 - Compilacao TDS - CABR020.PRW(1433)   Command has no effect
						/*
						substr(Trb->BD6_NOMUSR,1,40) + space(1) + ;
						"Impresso: " + Trb->BD6_NUMIMP + space(2)
						*/
						//Leonardo Portella - 07/11/14 - Fim
						
						//						"Dt Intern: " + dtoc(BE4->BE4_DATPRO) + space(2) + ;
						//						"Dt Alta: " + dtoc(BE4->BE4_DTALTA) + space(2) + ;
						//						"Tipo: " + substr(BQR->BQR_DESTIP,1,15) + space(1) + ;
						//						"Autoriz: " + transform(BE4->(BE4_OPERDA+BE4_ANOINT+BE4_MESINT+BE4_NUMINT),"@R XXXX.XXXX.XX.XXXXXXXX") + space(2) + ;   //				"Pad Conforto: " + transform(BN5->BN5_FATMUL,"@E 9.99") + space(3) + ;
						//						"CID: " + 	BE4->BE4_CID
					Else
						//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
						//Ё Imprime dados do usuario                                           Ё
						//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
						cLinha := "Beneficiario: " + transform(cMatric,"@R XXXX.XXXX.XXXXXX.XX-X") + space(1) + ;
						substr(Trb->BD6_NOMUSR,1,40) + space(1) + ;
						"Dt Intern: " + dtoc(BE4->BE4_DATPRO) + space(2) + ;
						"Dt Alta: " + dtoc(BE4->BE4_DTALTA) + space(2) + ;
						"Tipo: " + substr(BQR->BQR_DESTIP,1,15) + space(1) + ;
						"Impresso: " + Trb->BD6_NUMIMP + space(2) + ;
						"Autoriz: " + transform(BE4->(BE4_OPERDA+BE4_ANOINT+BE4_MESINT+BE4_NUMINT),"@R XXXX.XXXX.XX.XXXXXXXX") + space(2) + ;   //				"Pad Conforto: " + transform(BN5->BN5_FATMUL,"@E 9.99") + space(3) + ;
						"CID: " + 	BE4->BE4_CID
					EndIf
					
					If cAnaSin == 1
						If  nli > nQtdLin
							nli := Cabec(cTitulo,cCabec1,cCabec2,cNomeProg,cTamanho,nCaracter)
							nli++
						Endif
						@ nLi, 0 pSay cLinha
						nli++
						nli++
					Endif
					
					cImpRDA := .F.
					//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
					//Ё Monta query...                                                           Ё
					//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
					cSQL := "SELECT BD6_FILIAL, BD6_CODOPE, BD6_CODLDP, BD6_CODPEG, BD6_NUMERO, BD6_NUMIMP, BD6_DATPRO, BD6_CODPAD, BD6_CODPRO, "
					cSQL += " BD6_DESPRO, BD6_QTDPRO, BD6_CID,    BD6_PERVIA, BD6_ORIMOV, BD6_SEQUEN, BD6_ANOPAG, BD6_MESPAG, "
					cSQL += " BD6_OPEUSR, BD6_CODEMP, BD6_MATRIC, BD6_TIPREG, BD6_DIGITO, BD6_NOMUSR, ' ' AS BD5_GUIINT, BD6_NUMLOT, "
					cSQL += " BD6_CODRDA, bd6_vlrpag, BR8_TPPROC, BR8_DESCRI "
					cSQL += " FROM " + RetSQLName("BD6") + " BD6, "+ RetSQLName("BR8") + " BR8 "
					cSQL += " WHERE BD6_FILIAL  = '" + xFilial("BD6") + "' "
					cSQL += " AND BD6_CODLDP  = '" + Trb->BD6_CODLDP  + "' "
					cSQL += " AND BD6_CODOPE  = '" + Trb->BD6_CODOPE  + "' "
					cSQL += " AND BD6_CODPEG  = '" + Trb->BD6_CODPEG  + "' "
					cSQL += " AND BD6_NUMERO  = '" + Trb->BD6_NUMERO  + "' "
					cSQL += " AND BD6_ORIMOV  = '" + Trb->BD6_ORIMOV  + "' "
					//					cSQL += " AND BD6_ANOPAG  = '" + Trb->BD6_ANOPAG  + "' "
					//					cSQL += " AND BD6_MESPAG  = '" + Trb->BD6_MESPAG  + "' "
					cSQL += " AND BD6_CODRDA  = '" + Trb->BD6_CODRDA  + "' "
					cSQL += " AND BD6.d_e_l_e_t_ = ' ' "
					cSQL += " AND BR8_FILIAL = '  ' "
					cSQL += " AND BR8_CODPAD = BD6_CODPAD "
					cSQL += " AND BR8_CODPSA = BD6_CODPRO "
					cSQL += " AND BR8.D_E_L_E_T_ = ' ' "
					
					cSQL += " UNION ALL "
					cSQL += "SELECT BD6_FILIAL, BD6_CODOPE, BD6_CODLDP, BD6_CODPEG, BD6_NUMERO, BD6_NUMIMP, BD6_DATPRO, BD6_CODPAD, BD6_CODPRO, "
					cSQL += "       BD6_DESPRO, BD6_QTDPRO, BD6_CID,    BD6_PERVIA, BD6_ORIMOV, BD6_SEQUEN, BD6_ANOPAG, BD6_MESPAG, "
					cSQL += " BD6_OPEUSR, BD6_CODEMP, BD6_MATRIC, BD6_TIPREG, BD6_DIGITO, BD6_NOMUSR, BD5_GUIINT, BD6_NUMLOT, "
					cSQL += " BD6_CODRDA, bd6_vlrpag, BR8_TPPROC, BR8_DESCRI "
					cSQL += " FROM " + RetSQLName("BD6") + " BD6, "+ RetSQLName("BD5") + " BD5, "+ RetSQLName("BR8") + " BR8 "
					cSQL += " WHERE BD6_FILIAL  = '" + xFilial("BD6") + "' "
					cSQL += " AND BD6_FASE <> '1' "
					cSQL += " AND BD5_FILIAL  = '" + xFilial("BD5") + "' "
					cSQL += " AND BD5_CODOPE = BD6_CODOPE "
					cSQL += " AND BD5_CODLDP = BD6_CODLDP "
					cSQL += " AND BD5_CODPEG = BD6_CODPEG "
					cSQL += " AND BD5_NUMERO = BD6_NUMERO "
					cSQL += " AND BD5_ORIMOV = BD6_ORIMOV "
					//					cSQL += " AND BD5_ANOPAG = BD6_ANOPAG "
					//					cSQL += " AND BD5_MESPAG = BD6_MESPAG "
					cSQL += " AND BD5_CODRDA = BD6_CODRDA "
					//AND BD5_GUIINT = '000100000000615100000038'
					cSQL += " AND BD5_GUIINT = '" + Trb->(BD6_CODOPE+BD6_CODLDP+BD6_CODPEG+BD6_NUMERO) + "' "
					cSQL += " AND BD6.d_e_l_e_t_ = ' ' "
					cSQL += " AND BD5.d_e_l_e_t_ = ' ' "
					cSQL += " AND BR8_FILIAL = '  ' "
					cSQL += " AND BR8_CODPAD = BD6_CODPAD "
					cSQL += " AND BR8_CODPSA = BD6_CODPRO "
					cSQL += " AND BR8.D_E_L_E_T_ = ' ' "
					
					cSQL += " ORDER BY BD6_CODLDP, BD6_CODPEG, BD6_NUMERO"
					
					//memowrit("C:\CABR020A.SQL",cSQL) 
					//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
					//Ё Executa query...                                                         Ё
					//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
					PLSQuery(cSQL,"TrbBD6")
					//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
					//Ё Processa todas as guias deste usuario                              Ё
					//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
					
					cImpRDA := .T.
					
					nFrequenc += 1
					
					While !TrbBD6->(eof())
						
						If !empty(cCompAte) .or. val(cCompAte) > 0
							If TrbBD6->(BD6_ANOPAG+BD6_MESPAG) < cCompDe .or. TrbBD6->(BD6_ANOPAG+BD6_MESPAG) > cCompAte
								TrbBD6->(DbSkip())
								loop
							EndIf
						EndIf
						
						BR8->(DbSetOrder(1))
						BR8->(dbSeek(xFilial("BR8")+TrbBD6->(BD6_CODPAD+BD6_CODPRO)))
						
						//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
						//Ё Nao considera os Honorarios Medicos                                Ё
						//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
						If cLisHonMed == 2 .and. TrbBD6->BR8_TPPROC == "0"  //BR8->BR8_TPPROC == "0"
							TrbBD6->(DbSkip())
							loop
						EndIf
						
						nVlrPag := 0
						nVlrGlo := 0
						//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
						//Ё Posiciona BD7-Composicao do Procedimento                           Ё
						//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
						BD7->(dbSeek(xFilial("BD7")+TrbBD6->(BD6_CODOPE+BD6_CODLDP+BD6_CODPEG+BD6_NUMERO+BD6_ORIMOV+BD6_SEQUEN)))
						While ! BD7->(eof()) .and. BD7->(BD7_FILIAL+BD7_CODOPE+BD7_CODLDP+BD7_CODPEG+BD7_NUMERO+BD7_ORIMOV+BD7_SEQUEN) == ;
							xFilial("BD7")+TrbBD6->(BD6_CODOPE+BD6_CODLDP+BD6_CODPEG+BD6_NUMERO+BD6_ORIMOV+BD6_SEQUEN)
							//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
							//Ё Salta itens bloqueados                                             Ё
							//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
							If (BD7->BD7_BLOPAG == "1" .OR. BD7->BD7_VLRPAG == 0)
								BD7->(dbSkip())
								Loop
							EndIf
							
							If !empty(cCompPagAte) .or. val(cCompPagAte) > 0
								If SubStr(BD7->BD7_NUMLOT,1,6) < cCompPagDe .and. SubStr(BD7->BD7_NUMLOT,1,6) > cCompPagAte
									BD7->(dbSkip())
									Loop
								Endif
							EndIf
							
							nVlrPag += BD7->BD7_VLRPAG
							nVlrGlo += BD7->BD7_VLRGLO
							//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
							//Ё Acessa proximo registro                                            Ё
							//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
							BD7->(dbSkip())
						Enddo
						
						If cAnaSin == 1
							//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
							//Ё Monta dados da guia                                                Ё
							//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
							If nVlrPag > 0
								
								cLinha := transform(TrbBD6->(BD6_CODLDP+BD6_CODPEG+BD6_NUMERO+BD6_ORIMOV),"@R XXXX.XXXXXXXX.XXXXXXXX") + space(3) + ;
								TrbBD6->BD6_SEQUEN + space(3) + ;
								TrbBD6->BD6_NUMIMP + space(3) + ;
								TrbBD6->BD6_MESPAG + "/" + TrbBD6->BD6_ANOPAG+ space(3) + ;
								TrbBD6->BD6_CODPAD + space(2) + ;
								transform(TrbBD6->BD6_CODPRO,"@R XX.XX.XXX-X") + space(3) + ;
								substr(posicione("BR8",1,xFilial("BR8")+TrbBD6->(BD6_CODPAD+BD6_CODPRO),"BR8_DESCRI"),1,56) + space(3) + ;
								transform(TrbBD6->BD6_QTDPRO,"@E 99")+ space(3) +;
								transform(TrbBD6->BD6_PERVIA,"@E 999.99") + space(3) +;  //			transform(BD7->BD7_FATMUL,"@E 9.99") + space(3) + ;
								dtoc(TrbBD6->BD6_DATPRO) + space(3) + ;
								transform(nVlrPag,"@E 99,999.99") //+ space(3) + ;
								//								transform(nVlrGlo,"@E 99,999.99")
								
								If  nli > nQtdLin
									nli := Cabec(cTitulo,cCabec1,cCabec2,cNomeProg,cTamanho,nCaracter)
									nli++
								Endif
								@ nLi, 0 pSay cLinha
								nli++
							EndIf
						EndIf
						
						cLinha   := space(105)
						nTVlrPag += nVlrPag
						nTVlrGlo += nVlrGlo
						
						nVlrPag := 0
						nVlrGlo := 0
						
						nPos := Ascan(aFreqEve,{|x| x[1] == TrbBD6->BD6_CODPAD .and. x[2] == TrbBD6->BD6_CODPRO .and. x[3] == Alltrim(BA1->BA1_TIPUSU) .and. x[4]== Alltrim(BA1->BA1_SEXO) .And. x[5] == nFaixa  })
						If nPos = 0
							aadd(aFreqEve,{TrbBD6->BD6_CODPAD, TrbBD6->BD6_CODPRO, Alltrim(BA1->BA1_TIPUSU), Alltrim(BA1->BA1_SEXO), nFaixa, TrbBD6->BD6_QTDPRO , TrbBD6->BD6_VLRPAG })
						Else
							aFreqEve[nPos][6] += TrbBD6->BD6_QTDPRO
							aFreqEve[nPos][7] += TrbBD6->BD6_VLRPAG
						Endif

						nPos := Ascan(aMapProc,{|x| x[1] == TrbBD6->BR8_TPPROC })
						If nPos = 0
							aadd(aMapProc,{TrbBD6->BR8_TPPROC, Alltrim(BA1->BA1_TIPUSU), Alltrim(BA1->BA1_SEXO), nFaixa, TrbBD6->BD6_QTDPRO , TrbBD6->BD6_VLRPAG })
						Else
							aMapProc[nPos][5] += TrbBD6->BD6_QTDPRO
							aMapProc[nPos][6] += TrbBD6->BD6_VLRPAG
						Endif

						nPos := Ascan(aMapHMTot,{|x| x[1] == TrbBD6->BR8_TPPROC })
						If nPos == 0
							aadd(aMapHMTot,{TrbBD6->BR8_TPPROC, Alltrim(BA1->BA1_TIPUSU), Alltrim(BA1->BA1_SEXO), nFaixa, TrbBD6->BD6_QTDPRO , TrbBD6->BD6_VLRPAG })
						Else
							aMapHMTot[nPos][5] += TrbBD6->BD6_QTDPRO
							aMapHMTot[nPos][6] += TrbBD6->BD6_VLRPAG
						Endif
											
						nPos := Ascan(aFreqTot,{|x| x[1] == TrbBD6->BD6_CODPAD .and. x[2] == TrbBD6->BD6_CODPRO .and. x[3] == Alltrim(BA1->BA1_TIPUSU) .and. x[4]== Alltrim(BA1->BA1_SEXO) .And. x[5] == nFaixa  })
						If nPos == 0
							aadd(aFreqTot,{TrbBD6->BD6_CODPAD, TrbBD6->BD6_CODPRO, Alltrim(BA1->BA1_TIPUSU), Alltrim(BA1->BA1_SEXO), nFaixa, TrbBD6->BD6_QTDPRO , TrbBD6->BD6_VLRPAG })
						Else
							aFreqTot[nPos][6] += TrbBD6->BD6_QTDPRO
							aFreqTot[nPos][7] += TrbBD6->BD6_VLRPAG
						Endif
						
						//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
						//Ё Acessa proximo registro                                            Ё
						//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
						
						TrbBD6->(dbSkip())
					Enddo
					
					//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
					//Ё Monta query para pesquisar as orteses e proteses pagas pelo saude...     Ё
					//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
					cSQL := "SELECT BD6_FILIAL, BD6_CODOPE, BD6_CODLDP, BD6_CODPEG, BD6_NUMERO, BD6_NUMIMP, BD6_DATPRO, BD6_CODPAD, BD6_CODPRO, "
					cSQL += " BD6_DESPRO, BD6_QTDPRO, BD6_CID, BD6_PERVIA, BD6_ORIMOV, BD6_SEQUEN, BD6_ANOPAG, BD6_MESPAG, "
					cSQL += " BD6_OPEUSR, BD6_CODEMP, BD6_MATRIC, BD6_TIPREG, BD6_DIGITO, BD6_NOMUSR, ' ' AS BD5_GUIINT, BD6_NUMLOT, "
					cSQL += " BD6_CODRDA, bd6_vlrpag, BR8_TPPROC, BR8_DESCRI "
					cSQL += " FROM " + RetSQLName("BD6") + " BD61, "+ RetSQLName("BR8") + " BR8 "
					cSQL += " WHERE BD6_FILIAL  = '" + xFilial("BD6") + "' "
					cSQL += " AND BD6_CODOPE  = '" + Trb->BD6_CODOPE  + "' "
					cSQL += " AND BD6_FASE   = '3' "
					cSQL += " AND BD6_SITUAC =  '2' "
					cSQL += " AND BD6_CODLDP = '0012' "
					cSQL += " AND BD6_OPEUSR = '"+Trb->BD6_OPEUSR + "' "
					cSQL += " AND BD6_CODEMP = '"+Trb->BD6_CODEMP + "' "
					cSQL += " AND BD6_MATRIC = '"+Trb->BD6_MATRIC + "' "
					cSQL += " AND BD6_TIPREG = '"+Trb->BD6_TIPREG + "' "
					cSQL += " AND BD6_DATPRO BETWEEN '" + Dtos(BE4->BE4_DATPRO) + "' AND '"+ DtoS(BE4->BE4_DTALTA) + "' "
					cSQL += " AND BD6_CODPAD = '01' "
					cSQL += " AND BD6_CODPRO = '83000089' "
					cSQL += " AND BD61.d_e_l_e_t_ = ' ' "    
					cSQL += " AND BR8_FILIAL = '  ' "
					cSQL += " AND BR8_CODPAD = BD6_CODPAD "
					cSQL += " AND BR8_CODPSA = BD6_CODPRO "
					cSQL += " AND BR8.D_E_L_E_T_ = ' ' "
					
					//Incluido por Luzio em 20/08/2009 para que considere as OPME que foram cadastrados pelo padrao e que estao bloqueados.
					// Guias com as guias do OPME pagas a Fornecedores por nota fiscal.
					cSQL += " UNION "
					
					cSQL := "SELECT BD6_FILIAL, BD6_CODOPE, BD6_CODLDP, BD6_CODPEG, BD6_NUMERO, BD6_NUMIMP, BD6_DATPRO, BD6_CODPAD, BD6_CODPRO, "
					cSQL += " BD6_DESPRO, BD6_QTDPRO, BD6_CID, BD6_PERVIA, BD6_ORIMOV, BD6_SEQUEN, BD6_ANOPAG, BD6_MESPAG, "
					cSQL += " BD6_OPEUSR, BD6_CODEMP, BD6_MATRIC, BD6_TIPREG, BD6_DIGITO, BD6_NOMUSR, ' ' AS BD5_GUIINT, BD6_NUMLOT, "
					cSQL += " BD6_CODRDA, bd6_vlrpag, BR8_TPPROC, BR8_DESCRI "
					cSQL += " FROM " + RetSQLName("BD6") + " BD6, " + RetSQLName("BD7") + " BD7, " + RetSQLName("B19") + " B19, "+ RetSQLName("BR8") + " BR8 "
					cSQL += " WHERE BD6_FILIAL  = '" + xFilial("BD6") + "' "
					cSQL += " AND BD6_CODOPE  = '" + Trb->BD6_CODOPE  + "' "
					cSQL += " AND BD6_CODLDP  = '" + Trb->BD6_CODLDP  + "' "
					cSQL += " AND BD6_CODOPE  = '" + Trb->BD6_CODOPE  + "' "
					cSQL += " AND BD6_CODPEG  = '" + Trb->BD6_CODPEG  + "' "
					cSQL += " AND BD6_NUMERO  = '" + Trb->BD6_NUMERO  + "' "
					//cSQL += " AND BD6_ANOPAG  = '" + Trb->BD6_ANOPAG  + "' "
					//cSQL += " AND BD6_MESPAG  = '" + Trb->BD6_MESPAG  + "' "
					cSQL += " AND BD6_CODRDA  = '" + Trb->BD6_CODRDA  + "' "
					//cSQL += " AND BD6_FASE     = '3' "         //Fase da Guia igual a PRONTA
					//cSQL += " AND BD6_SITUAC   = '1' "         //Situacao igual
					cSql += " AND BD7_FILIAL = '" + xFilial("BD7") + "' "
					cSQL += " AND BD7_CODOPE = BD6_CODOPE "
					cSQL += " AND BD7_CODLDP = BD6_CODLDP "
					cSQL += " AND BD7_CODPEG = BD6_CODPEG "
					cSQL += " AND BD7_NUMERO = BD6_NUMERO "
					cSQL += " AND BD7_ORIMOV = BD6_ORIMOV "
					cSQL += " AND BD7_SEQUEN = BD6_SEQUEN "
					cSQL += " AND BD7_BLOPAG = '1' "             //Bloqueio de pagamento da composicao do prodcedimento
					cSQL += " AND BD7_NUMLOT = '     ' "
					cSQL += " AND B19_GUIA   = BD6_CODOPE||BD6_CODLDP||BD6_CODPEG||BD6_NUMERO||BD6_ORIMOV||BD6_SEQUEN "
					cSQL += " AND B19_COD    = BD6_CODPRO "
					cSQL += " AND BD6.D_E_L_E_T_ <> '*' "
					cSQL += " AND BD7.D_E_L_E_T_ <> '*' "
					cSQL += " AND B19.D_E_L_E_T_ <> '*' "
				  	cSQL += " AND BR8_FILIAL = '  ' "
					cSQL += " AND BR8_CODPAD = BD6_CODPAD "
					cSQL += " AND BR8_CODPSA = BD6_CODPRO "
					cSQL += " AND BR8.D_E_L_E_T_ = ' ' "
					
					/* Nova query para apurar as OPME e os reembolsos referente a estes atendimentos
					// Processa as guias de reembolso realziadas pela rotina padrao.
					cSQL += " UNION "
					cSQL += " SELECT BD6_FILIAL, BD6_CODOPE, B45_CODLDP AS BD6_CODLDP, B45_CODPEG AS BD6_CODPEG, B45_NUMERO AS BD6_NUMERO, BD6_NUMIMP "
					cSQL += " 		B45_DATPRO AS BD6_DATPRO, B45_CODPAD AS BD6_CODPAD, B45_CODPRO AS BD6_CODPRO, "
					cSQL += " 		BD6_DESPRO, B45_QTDPRO AS BD6_QTDPRO, BD6_CID, BD6_PERVIA, B45_ORIMOV AS BD6_ORIMOV, B45_SEQUEN AS BD6_SEQUEN, "
					cSQL += " 		B44_ANOPAG AS BD6_ANOPAG, B44_MESPAG AS BD6_MESPAG, "
					cSQL += " 		B44_OPEUSR AS BD6_OPEUSR, B44_CODEMP AS BD6_CODEMP, B44_MATRIC AS BD6_MATRIC, B44_TIPREG AS BD6_TIPREG, "
					cSQL += " 		B44_DIGITO AS BD6_DIGITO, B44_NOMUSR AS BD6_NOMUSR, BD5_GUIINT, B44_NUM AS BD7_NUMLOT, B44_REGEXE AS BD6_CODRDA, "
					cSQL += " 		B45_VLRPAG AS BD6_VLRPAG "
					cSQL += "       FROM "+RetSqlName("B44")+" B44, "+RetSqlName("B45")+" B45, "+RetSqlName("BD6")+" BD6, "+RetSqlName("BD7")+" BD7, "
					cSQL += RetSqlName("SE1")+" SE1, "+RetSqlName("SE2")+" SE2 "
					cSQL += "       WHERE B45_FILIAL = '" + xFilial("B45") + "' "
					cSQL += "         AND B44_FILIAL = '" + xFilial("B44") + "' "
					cSQL += "         AND BD7_FILIAL = '" + xFilial("BD7") + "' "
					cSQL += "         AND BD6_FILIAL = '" + xFilial("BD6") + "' "
					cSQL += "         AND E1_FILIAL  = '01'
					cSQL += " 			AND BD6_CODOPE  = '" + Trb->BD6_CODOPE  + "' "
					cSQL += " 			AND BD6_CODLDP  = '" + Trb->BD6_CODLDP  + "' "
					cSQL += " 			AND BD6_CODOPE  = '" + Trb->BD6_CODOPE  + "' "
					cSQL += " 			AND BD6_CODPEG  = '" + Trb->BD6_CODPEG  + "' "
					cSQL += " 			AND BD6_NUMERO  = '" + Trb->BD6_NUMERO  + "' "
					//cSQL += " AND BD6_ANOPAG  = '" + Trb->BD6_ANOPAG  + "' "
					//cSQL += " AND BD6_MESPAG  = '" + Trb->BD6_MESPAG  + "' "
					cSQL += " 			AND BD6_CODRDA  = '" + Trb->BD6_CODRDA  + "' "
					cSQL += "         AND B44_CODLDP = B45_CODLDP "
					cSQL += "         AND B44_CODPEG = B45_CODPEG "
					cSQL += "         AND B44_NUMAUT = B45_NUMAUT "
					cSQL += "         AND B44_NUM <> '   ' "
					cSQL += "         AND B44_YSITUA = '2' "
					cSQL += "         AND B44_PREFIX = E1_PREFIXO "
					cSQL += "         AND B44_NUM    = E1_NUM "
					cSQL += "         AND B45_VLRPAG > 0 "
					
					cSQL += "         AND BD6_CODLDP = B45_CODLDP "
					cSQL += "         AND BD6_CODPEG = B45_CODPEG "
					cSQL += "         AND BD6_NUMERO = B45_NUMERO "
					//cSQL += "       AND BD6_ORIMOV = B45_ORIMOV "
					cSQL += "         AND BD6_SEQUEN = B45_SEQUEN "
					
					
					cSQL += "         AND BD7_CODOPE = BD6_CODOPE "
					cSQL += "         AND BD7_CODLDP = BD6_CODLDP "
					cSQL += "         AND BD7_CODPEG = BD6_CODPEG "
					cSQL += "         AND BD7_NUMERO = BD6_NUMERO "
					cSQL += "         AND BD7_ORIMOV = BD6_ORIMOV "
					cSQL += "         AND BD7_SEQUEN = BD6_SEQUEN "
					//cSQL += "         AND DECODE(E2_VENCREA,NULL,SubStr(E1_VENCREA,1,6),SubStr(E2_VENCREA,1,6)) = '200906' "
					cSQL += "         AND BD7_CODPEG = BD6_CODPEG "
					cSQL += "         AND BD7_NUMERO = BD6_NUMERO "
					cSQL += "         AND BD7_ORIMOV = BD6_ORIMOV "
					cSQL += "         AND BD7_SEQUEN = BD6_SEQUEN "
					cSQL += "         AND (BD6_OPEUSR||BD6_CODEMP||BD6_MATRIC||BD6_TIPREG <> '0001000600360300' AND BD6_CODLDP = '9000' ) "
					cSQL += "         AND E1_PREFIXO||E1_NUM||E1_PARCELA||E1_TIPO = E2_TITORIG(+) "
					cSQL += "         AND B44.D_E_L_E_T_=' ' "
					cSQL += "         AND B45.D_E_L_E_T_=' ' "
					cSQL += "         AND BD6.D_E_L_E_T_=' ' "
					cSQL += "         AND BD7.D_E_L_E_T_=' ' "
					cSQL += "         AND SE1.D_E_L_E_T_=' ' "
					cSQL += "         AND SE2.D_E_L_E_T_=' ' "
					*/
					
					//memowrit("C:\CABR020d.SQL",cSQL) 
					//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
					//Ё Executa query...                                                         Ё
					//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
					PLSQuery(cSQL,"TrbBD6A")
					
					While !TrbBD6A->(eof())
						nVlrPag += TrbBD6A->BD6_VLRPAG
						
						If cAnaSin == 1
							//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
							//Ё Monta dados da guia                                                Ё
							//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
							If TrbBD6A->BD6_VLRPAG > 0
								
								cLinha := transform(TrbBD6A->(BD6_CODLDP+BD6_CODPEG+BD6_NUMERO+BD6_ORIMOV),"@R XXXX.XXXXXXXX.XXXXXXXX") + space(3) + ;
								TrbBD6A->BD6_SEQUEN + space(3) + ;
								TrbBD6A->BD6_NUMIMP + space(3) + ;
								TrbBD6A->BD6_MESPAG + "/" + TrbBD6->BD6_ANOPAG+ space(3) + ;
								TrbBD6A->BD6_CODPAD + space(2) + ;
								transform(TrbBD6A->BD6_CODPRO,"@R XX.XX.XXX-X") + space(3) + ;
								substr(posicione("BR8",1,xFilial("BR8")+TrbBD6A->(BD6_CODPAD+BD6_CODPRO),"BR8_DESCRI"),1,56) + space(3) + ;
								transform(TrbBD6A->BD6_QTDPRO,"@E 99")+ space(3) +;
								transform(TrbBD6A->BD6_PERVIA,"@E 999.99") + space(3) +;
								dtoc(TrbBD6A->BD6_DATPRO) + space(3) + ;
								transform(TrbBD6A->BD6_VLRPAG,"@E 99,999.99")
								
								If  nli > nQtdLin
									nli := Cabec(cTitulo,cCabec1,cCabec2,cNomeProg,cTamanho,nCaracter)
									nli++
								Endif
								@ nLi, 0 pSay cLinha
								nli++
							EndIf
							
						EndIf
						cLinha   := space(105)
						nTVlrPag += TrbBD6A->BD6_VLRPAG
						nTVlrGlo += nVlrGlo
						
						nVlrPag := 0
						nVlrGlo := 0
						
						nPos := Ascan(aFreqEve,{|x| x[1] == TrbBD6A->BD6_CODPAD .and. x[2] == TrbBD6A->BD6_CODPRO .and. x[3] == Alltrim(BA1->BA1_TIPUSU) .and. x[4]== Alltrim(BA1->BA1_SEXO) .And. x[5] == nFaixa  })
						If nPos = 0
							aadd(aFreqEve,{TrbBD6A->BD6_CODPAD, TrbBD6A->BD6_CODPRO, Alltrim(BA1->BA1_TIPUSU), Alltrim(BA1->BA1_SEXO), nFaixa, TrbBD6A->BD6_QTDPRO , TrbBD6A->BD6_VLRPAG })
						Else
							aFreqEve[nPos][6] += TrbBD6A->BD6_QTDPRO
							aFreqEve[nPos][7] += TrbBD6A->BD6_VLRPAG
						Endif

						nPos := Ascan(aMapProc,{|x| x[1] == TrbBD6A->BR8_TPPROC })
						If nPos = 0
							aadd(aMapProc,{TrbBD6A->BR8_TPPROC, Alltrim(BA1->BA1_TIPUSU), Alltrim(BA1->BA1_SEXO), nFaixa, TrbBD6A->BD6_QTDPRO , TrbBD6A->BD6_VLRPAG })
						Else
							aMapProc[nPos][5] += TrbBD6A->BD6_QTDPRO
							aMapProc[nPos][6] += TrbBD6A->BD6_VLRPAG
						Endif

						nPos := Ascan(aMapHMTot,{|x| x[1] == TrbBD6A->BR8_TPPROC })
						If nPos == 0
							aadd(aMapHMTot,{TrbBD6A->BD6_CODPAD, TrbBD6A->BD6_CODPRO, Alltrim(BA1->BA1_TIPUSU), Alltrim(BA1->BA1_SEXO), nFaixa, TrbBD6A->BD6_QTDPRO , TrbBD6A->BD6_VLRPAG })
						Else
							aMapHMTot[nPos][5] += TrbBD6A->BD6_QTDPRO
							aMapHMTot[nPos][6] += TrbBD6A->BD6_VLRPAG
						Endif
											
						nPos := Ascan(aFreqTot,{|x| x[1] == TrbBD6A->BD6_CODPAD .and. x[2] == TrbBD6A->BD6_CODPRO .and. x[3] == Alltrim(BA1->BA1_TIPUSU) .and. x[4]== Alltrim(BA1->BA1_SEXO) .And. x[5] == nFaixa  })
						If nPos == 0
							aadd(aFreqTot,{TrbBD6A->BR8_TPPROC, Alltrim(BA1->BA1_TIPUSU), Alltrim(BA1->BA1_SEXO), nFaixa, TrbBD6A->BD6_QTDPRO , TrbBD6A->BD6_VLRPAG })
						Else
							aFreqTot[nPos][6] += TrbBD6A->BD6_QTDPRO
							aFreqTot[nPos][7] += TrbBD6A->BD6_VLRPAG
						Endif
						
						TrbBD6A->(dbSkip())
					Enddo
					
					If cAnaSin == 1
						If nTVlrPag > 0
							//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
							//Ё Imprime separador de linhas                                        Ё
							//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
							cLinha := "Total da Guia" + space(50) + ;
							transform(nTVlrPag,"@E 999,999.99")
							If  nli > nQtdLin
								nli := Cabec(cTitulo,cCabec1,cCabec2,cNomeProg,cTamanho,nCaracter)
								nli++
							Endif
							@ nLi, 0 pSay replicate("-",220)
							nli++
							@ nLi, 0 pSay cLinha
							nli++
							nli++
						EndIf
					EndIf
					
					nT1VlrPag += nTVlrPag
					nT1VlrGlo += nTVlrGlo
					
					nTVlrPag := 0
					nTVlrGlo := 0
					
					//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
					//Ё Fecha arquivo de trabalho                                          Ё
					//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
					TrbBD6A->(DbCloseArea())
					TrbBD6->(DbCloseArea())
					Trb->(dbSkip())
				EndDo
			Enddo
			If nT1VlrPag > 0
				If cAnaSin == 1
					//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
					//Ё Imprime separador de linhas                                        Ё
					//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
					cLinha := "Total do beneficiario" + space(50) + ;
					transform(nT1VlrPag,"@E 999,999.99") //+ space(3) + ;
					//					transform(nT1VlrGlo,"@E 999,999.99")
					
					If  nli > nQtdLin
						nli := Cabec(cTitulo,cCabec1,cCabec2,cNomeProg,cTamanho,nCaracter)
						nli++
					Endif
					@ nLi, 0 pSay replicate("-",220)
					nli++
					@ nLi, 0 pSay cLinha
					nli++
					nli++
				Else
					cLinha := cCodRDA +" - " + posicione("BAU",1,xFilial("BAU")+cCodRDA,"BAU_NOME") + space(3) + ;
					transform(nFrequenc,"@E 999999") + space(3) + ;
					transform(nT1VlrPag,"@E 999,999.99") + space(3) + ;
					transform((nT1VlrPag/nFrequenc),"@E 999,999.99")         //Media por RDA
					
					//					If lImpMatric
					//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
					//Ё Imprime nome da RDA                                                Ё
					//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
					If  nli > nQtdLin
						nli := Cabec(cTitulo,cCabec1,cCabec2,cNomeProg,cTamanho,nCaracter)
						nli++
					Endif
					@ nLi, 0 pSay cLinha
					nli++
				EndIf
			EndIf
			nT2VlrPag += nt1VlrPag
			nT2VlrGlo += nt1VlrGlo
			
			//			If cAnaSin == 1 .and.
			If cImprRes == 2
				Asort(aFreqEve,,, {|x, y| x[1]+x[2] < y[1]+y[2]})
				For n = 1 to len(aFreqEve)
					cLinha := "| " + transform(aFreqEve[n][2],"@R XX.XX.XXX-X") + " - " + ;
					substr(posicione("BR8",1,xFilial("BR8")+aFreqEve[n][1]+aFreqEve[n][2],"BR8_DESCRI"),1,56)+ " | " + ;
					transform(aFreqEve[n][6],"@E 999999") + " | " + ;
					transform(aFreqEve[n][7],"@E 999,999.99") + " | " + ;
					transform((aFreqEve[n][7]/aFreqEve[n][6]),"@E 999,999.99")+ " | "  //Media por procedimento
					If  nli > nQtdLin
						nli := Cabec(cTitulo,cCabec1,cCabec2,cNomeProg,cTamanho,nCaracter)
						nli++
					Endif
					If n == 1
						@ nLi, 0 pSay replicate("-",110)
						nli++
					EndIf
					@ nLi, 0 pSay cLinha
					nli++
				Next
				@ nLi, 0 pSay replicate("-",110)
				nli++

				Asort(aMapProc,,, {|x, y| x[1] < y[1]})
				For n = 1 to len(aMapProc)
					dbSelectArea("SX3")
					dbSetOrder(2)
					If SX3->(dbSeek("BR8_TPPROC")) .AND. !Empty(SX3->X3_CBOX)
	    		        cDesCombo := X3Combo(SX3->X3_CAMPO,aMapProc[n][1])
			        EndIf

					cLinha := "| " + Alltrim(cDesCombo)+Space(40-Len(Alltrim(cDesCombo))) + " | " + ; //"| " + transform(aMapProc[n][1],"@R XX.XX.XXX-X") + " - " + ; //substr(posicione("BR8",1,xFilial("BR8")+aMapProc[n][1]+aMapProc[n][2],"BR8_DESCRI"),1,56)+ " | " + ;
					transform(aMapProc[n][5],"@E 999999") + " | " + ;
					transform(aMapProc[n][6],"@E 999,999.99") + " | " + ;
					transform((aMapProc[n][6]/aMapProc[n][5]),"@E 999,999.99")+ " | "  //Media por procedimento
					If  nli > nQtdLin
						nli := Cabec(cTitulo,cCabec1,cCabec2,cNomeProg,cTamanho,nCaracter)
						nli++
					Endif
					If n == 1
						@ nLi, 0 pSay replicate("-",110)
						nli++
					EndIf
					@ nLi, 0 pSay cLinha
					nli++
					cDesCombo := space(0)
				Next
				@ nLi, 0 pSay replicate("-",110)
				nli++

			EndIf
			
			nT1VlrPag := 0
			nT1VlrGlo := 0
		EndDo
		//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
		//Ё Imprime separador de linhas                                        Ё
		//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
		cLinha := "Custo do Procedimento" + space(50) + ;
		transform(nT2VlrPag,"@E 999,999.99")
		
		If  nli > nQtdLin
			nli := Cabec(cTitulo,cCabec1,cCabec2,cNomeProg,cTamanho,nCaracter)
			nli++
		Endif
		@ nLi, 0 pSay replicate("-",220)
		nli++
		@ nLi, 0 pSay cLinha
		nli++

		If cAnaSin == 1 .and. nOrdSel == 2 
			nli := 999
		EndIf
		
	EndIf
	nTotVlrPag += nt2VlrPag
	nTotVlrGlo += nt2VlrGlo
	nT2VlrPag := 0
	nT2VlrGlo := 0
	
	//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//Ё Acessa proximo registro...                                         Ё
	//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
Enddo
//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Imprime separador de linhas                                        Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
cLinha := "Total Geral" + space(50) + ;
transform(nTotVlrPag,"@E 9,999,999.99")  ///+ space(3) + ;
//transform(nTotVlrGlo,"@E 9,999,999.99")

If  nli > nQtdLin
	nli := Cabec(cTitulo,cCabec1,cCabec2,cNomeProg,cTamanho,nCaracter)
	nli++
Endif
@ nLi, 0 pSay replicate("-",220)
nli++
@ nLi, 0 pSay cLinha
nli++

If cImprRes == 2
	Asort(aFreqTot,,, {|x, y| x[1]+x[2] < y[1]+y[2]})
	For n = 1 to len(aFreqTot)
		cLinha := "| " + transform(aFreqTot[n][2],"@R XX.XX.XXX-X") + " - " + ;
		substr(posicione("BR8",1,xFilial("BR8")+aFreqTot[n][1]+aFreqTot[n][2],"BR8_DESCRI"),1,56)+ " | " + ;
		transform(aFreqTot[n][6],"@E 999999") + " | " + ;
		transform(aFreqTot[n][7],"@E 999,999.99") + " | " + ;
		transform((aFreqTot[n][7]/aFreqTot[n][6]),"@E 999,999.99")+ " | "  //Media por procedimento
		If  nli > nQtdLin
			nli := Cabec(cTitulo,cCabec1,cCabec2,cNomeProg,cTamanho,nCaracter)
			nli++
		Endif
		If n == 1
			@ nLi, 0 pSay replicate("-",110)
			nli++
		EndIf
		@ nLi, 0 pSay cLinha
		nli++
	Next

//Imprime Resumo pro tipo de procedimento (br8_tpproc)
	Asort(aMapHMTot,,, {|x, y| x[1] < y[1]})
	nli++
	@ nLi, 0 pSay replicate("-",110)
	For n = 1 to len(aMapHMTot)
		dbSelectArea("SX3")
		dbSetOrder(2)
		If SX3->(dbSeek("BR8_TPPROC")) .AND. !Empty(SX3->X3_CBOX)
	        cDesCombo := X3Combo(SX3->X3_CAMPO,aMapHMTot[n][1])
        EndIf

		cLinha := "| " + Alltrim(cDesCombo)+Space(40-Len(Alltrim(cDesCombo))) + " | " + ;   //transform(aMapHMTot[n][1],"@R XX.XX.XXX-X") + " - " + ; 	//substr(posicione("BR8",1,xFilial("BR8")+aMapProc[n][1]+aMapProc[n][2],"BR8_DESCRI"),1,56)+ " | " + ;
		transform(aMapHMTot[n][5],"@E 999999") + " | " + ;
		transform(aMapHMTot[n][6],"@E 999,999.99") + " | " + ;
		transform((aMapHMTot[n][6]/aMapHMTot[n][5]),"@E 999,999.99")+ " | "  //Media por procedimento
		If  nli > nQtdLin
			nli := Cabec(cTitulo,cCabec1,cCabec2,cNomeProg,cTamanho,nCaracter)
			nli++
		Endif
		If n == 1
			@ nLi, 0 pSay replicate("-",110)
			nli++
		EndIf
		@ nLi, 0 pSay cLinha
		nli++
		cDesCombo := space(0)
	Next
	@ nLi, 0 pSay replicate("-",110)
EndIf

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Fecha arquivo...                                                   Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
Trb->(DbCloseArea())
//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Rodape                                                                   Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
Roda(0,space(10),cTamanho)
//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Libera impressao                                                         Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
If  aReturn[5] == 1
	Set Printer To
	Ourspool(cRel)
Endif
//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Fim do Relat╒rio                                                         Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
Return()

/*
эээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээ
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
╠╠иммммммммммяммммммммммкмммммммяммммммммммммммммммммкммммммяммммммммммммм╩╠╠
╠╠╨Programa  ЁAjustaSX1 ╨Autor  ЁLuzio Tavares       ╨ Data Ё  13/03/08   ╨╠╠
╠╠лммммммммммьммммммммммймммммммоммммммммммммммммммммйммммммоммммммммммммм╧╠╠
╠╠╨Desc.     ЁCria as perguntas no SX1.                                   ╨╠╠
╠╠лммммммммммьмммммммммммммммммммммммммммммммммммммммммммммммммммммммммммм╧╠╠
╠╠╨Uso       ЁCABERJ                                                      ╨╠╠
╠╠хммммммммммомммммммммммммммммммммммммммммммммммммммммммммммммммммммммммм╪╠╠
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
ъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъ
*/
Static Function AjustaSX1()
Local aRegs		:= {}

Aadd(aRegs,{cPerg,"01","Operadora De        ","","","MV_CH1","C",04,0,0,"G","","Mv_Par01","         ","","","","","   ","","","","","","","","","","","","","","","","","","","B42PLS",""})
Aadd(aRegs,{cPerg,"02","Operadora Ate       ","","","MV_CH2","C",04,0,0,"G","","Mv_Par02","         ","","","","","   ","","","","","","","","","","","","","","","","","","","B42PLS",""})
Aadd(aRegs,{cPerg,"03","Rede de Atend. De   ","","","MV_CH3","C",06,0,0,"G","","Mv_Par03","         ","","","","","   ","","","","","","","","","","","","","","","","","","","BAUPLS",""})
Aadd(aRegs,{cPerg,"04","Rede de Atend. Ate  ","","","MV_CH4","C",06,0,0,"G","","Mv_Par04","         ","","","","","   ","","","","","","","","","","","","","","","","","","","BAUPLS",""})
Aadd(aRegs,{cPerg,"05","Especialidade De    ","","","MV_CH3","C",03,0,0,"G","","Mv_Par05","         ","","","","","   ","","","","","","","","","","","","","","","","","","","      ",""})
Aadd(aRegs,{cPerg,"06","Especialidade Ate   ","","","MV_CH4","C",03,0,0,"G","","Mv_Par06","         ","","","","","   ","","","","","","","","","","","","","","","","","","","      ",""})
Aadd(aRegs,{cPerg,"07","Dt Internacao De    ","","","MV_CH5","D",08,0,0,"G","","Mv_Par07","         ","","","","","   ","","","","","","","","","","","","","","","","","","","",""})
Aadd(aRegs,{cPerg,"08","Dt Internacao Ate   ","","","MV_CH6","D",08,0,0,"G","","Mv_Par08","         ","","","","","   ","","","","","","","","","","","","","","","","","","","",""})
Aadd(aRegs,{cPerg,"09","Somente Aut Intern  ","","","MV_CH8","N",01,0,0,"C","","Mv_Par09","Nao      ","","","","","Sim","","","","","","","","","","","","","","","","","","","      ",""})
Aadd(aRegs,{cPerg,"10","Fase                ","","","MV_CH9","N",01,0,0,"C","","Mv_Par10","Faturada ","","","","","Ativa","","","","","Ativa/Faturada","","","","","","","","","","","","","","      ",""})
Aadd(aRegs,{cPerg,"11","Data Proced De      ","","","MV_CHa","D",08,0,0,"G","","Mv_Par11","         ","","","","","   ","","","","","","","","","","","","","","","","","","","      ",""})
Aadd(aRegs,{cPerg,"12","Data Proced Ate     ","","","MV_CHb","D",08,0,0,"G","","Mv_Par12","         ","","","","","   ","","","","","","","","","","","","","","","","","","","      ",""})
Aadd(aRegs,{cPerg,"13","Cod Tp Proc De      ","","","MV_CHc","C",02,0,0,"G","","Mv_Par13","         ","","","","","   ","","","","","","","","","","","","","","","","","","","B41   ",""})
Aadd(aRegs,{cPerg,"14","Cod Tp Proc Ate     ","","","MV_CHd","C",02,0,0,"G","","Mv_Par14","         ","","","","","   ","","","","","","","","","","","","","","","","","","","B41   ",""})
Aadd(aRegs,{cPerg,"15","Cod Procedimento De ","","","MV_CHe","C",16,0,0,"G","","Mv_Par15","         ","","","","","   ","","","","","","","","","","","","","","","","","","","BGHPLS",""})  //YBR
Aadd(aRegs,{cPerg,"16","Cod Procedimento Ate","","","MV_CHf","C",16,0,0,"G","","Mv_Par16","         ","","","","","   ","","","","","","","","","","","","","","","","","","","BGHPLS",""})  //YBR
Aadd(aRegs,{cPerg,"17","Ope Usuario De      ","","","MV_CHg","C",04,0,0,"G","","Mv_Par17","         ","","","","","   ","","","","","","","","","","","","","","","","","","","      ",""})
Aadd(aRegs,{cPerg,"18","Ope Usuario Ate     ","","","MV_CHh","C",04,0,0,"G","","Mv_Par18","         ","","","","","   ","","","","","","","","","","","","","","","","","","","      ",""})
Aadd(aRegs,{cPerg,"19","Grupo/Empresa De    ","","","MV_CHi","C",04,0,0,"G","","Mv_Par19","         ","","","","","   ","","","","","","","","","","","","","","","","","","","BJLPLS",""})
Aadd(aRegs,{cPerg,"20","Grupo/Empresa Ate   ","","","MV_CHj","C",04,0,0,"G","","Mv_Par20","         ","","","","","   ","","","","","","","","","","","","","","","","","","","BJLPLS",""})
Aadd(aRegs,{cPerg,"21","Contrato De         ","","","MV_CHk","C",12,0,0,"G","","Mv_Par21","         ","","","","","   ","","","","","","","","","","","","","","","","","","","B7BPLS",""})
Aadd(aRegs,{cPerg,"22","Contrato Ate        ","","","MV_CHl","C",12,0,0,"G","","Mv_Par22","         ","","","","","   ","","","","","","","","","","","","","","","","","","","B7BPLS",""})
Aadd(aRegs,{cPerg,"23","Subcontrato De      ","","","MV_CHm","C",09,0,0,"G","","Mv_Par23","         ","","","","","   ","","","","","","","","","","","","","","","","","","","BA6PLS",""})
Aadd(aRegs,{cPerg,"24","Subcontrato De      ","","","MV_CHn","C",09,0,0,"G","","Mv_Par24","         ","","","","","   ","","","","","","","","","","","","","","","","","","","BA6PLS",""})
Aadd(aRegs,{cPerg,"25","Matricula De        ","","","MV_CHo","C",06,0,0,"G","","Mv_Par25","         ","","","","","   ","","","","","","","","","","","","","","","","","","","",""})
Aadd(aRegs,{cPerg,"26","Matricula Ate       ","","","MV_CHp","C",06,0,0,"G","","Mv_Par26","         ","","","","","   ","","","","","","","","","","","","","","","","","","","",""})
Aadd(aRegs,{cPerg,"27","Tipo Registro de    ","","","MV_CHq","C",02,0,0,"G","","Mv_Par27","         ","","","","","   ","","","","","","","","","","","","","","","","","","","",""})
Aadd(aRegs,{cPerg,"28","Tipo Registro Ate   ","","","MV_CHr","C",02,0,0,"G","","Mv_Par28","         ","","","","","   ","","","","","","","","","","","","","","","","","","","",""})
Aadd(aRegs,{cPerg,"29","Plano De            ","","","MV_CHs","C",04,0,0,"G","","Mv_Par29","         ","","","","","   ","","","","","","","","","","","","","","","","","","","B2DPLS",""})
Aadd(aRegs,{cPerg,"30","Plano Ate           ","","","MV_CHt","C",04,0,0,"G","","Mv_Par30","         ","","","","","   ","","","","","","","","","","","","","","","","","","","B2DPLS",""})
Aadd(aRegs,{cPerg,"31","Analistico/Sintetico","","","MV_CHu","N",01,0,0,"C","","Mv_Par31","Analitico","","","","","Sintetico","","","","","","","","","","","","","","","","","","","      ",""})
Aadd(aRegs,{cPerg,"32","Lista Hon. Medicos  ","","","MV_CHv","N",01,0,0,"C","","Mv_Par32","Sim      ","","","","","Nao","","","","","","","","","","","","","","","","","","","      ",""})
Aadd(aRegs,{cPerg,"33","Compet. Producao De ","","","MV_CHx","C",06,0,0,"G","","Mv_Par33","         ","","","","","   ","","","","","","","","","","","","","","","","","","","",""})
Aadd(aRegs,{cPerg,"34","Compet. Producao Ate","","","MV_CHw","C",06,0,0,"G","","Mv_Par34","         ","","","","","   ","","","","","","","","","","","","","","","","","","","",""})
Aadd(aRegs,{cPerg,"35","Compet Pagto De     ","","","MV_CHy","C",06,0,0,"G","","Mv_Par35","         ","","","","","   ","","","","","","","","","","","","","","","","","","","",""})
Aadd(aRegs,{cPerg,"36","Compet Pagto Ate    ","","","MV_CH!","C",06,0,0,"G","","Mv_Par36","         ","","","","","   ","","","","","","","","","","","","","","","","","","","",""})
Aadd(aRegs,{cPerg,"37","Imprime Resumo Proc.","","","MV_CH@","N",01,0,0,"C","","Mv_Par37","Nao      ","","","","","Sim","","","","","","","","","","","","","","","","","","","",""})
Aadd(aRegs,{cPerg,"38","Custo Hosp.         ","","","MV_CH#","N",01,0,0,"C","","Mv_Par38","AAA-Custo Alto","","","","","AA-Custo Medio","","","","","A-Custo Padrao","","","",""," -Todos","","","","","","","","","",""}) // Motta 8/12/14


PlsVldPerg( aRegs )

Return()

/*/
ээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээ
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
╠╠здддддддддддбдддддддддддбдддддддбддддддддддддддддддддддбддддддбдддддддддд©╠╠
╠╠ЁPrograma   Ё RetFai    Ё Autor Ё Luzio Tavares        Ё Data Ё 28.02.08 Ё╠╠
╠╠цдддддддддддедддддддддддадддддддаддддддддддддддддддддддаддддддадддддддддд╢╠╠
╠╠ЁDescricao  Ё Retorna a faixa etaria do usuario                          Ё╠╠
╠╠юдддддддддддадддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды╠╠
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
/*/
Static Function RetFai(nIdade)
Local nFaixa

BL9->(DbGoTop())
While ! BL9->(Eof())
	If nIdade <= BL9->BL9_IDADEF
		nFaixa := Val(BL9->BL9_SEQUEN)
		Exit
	Endif
	BL9->(DbSkip())
Enddo

Return(nFaixa)
