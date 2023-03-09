#include "PLSMGER.CH"
#include "TBICONN.CH"

#Define cCodigosPF "104,116,117,123,124,125,127,134,137,138,139,140,141,142,143,144,145,147,148,149,150,151,152,153,154,155,156,157,158,159,160,161,162,163,164,165,166,167,168,169,170,171,172,173,174,175,176,177"

Static cCodDB     := PLSRETLADC()
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±±
±±³Funcao    ³ CRJR005 ³ Autor ³ Geraldo Felix Junior   ³ Data ³ 24.11.00 ³±±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±±
±±³Descricao ³ Relatorio de pagamentos de associados                      ³±±±
	±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±±
±±³Sintaxe   ³ CRJR005                                                    ³±±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±±
±±³ Uso      ³ Advanced Protheus                                          ³±±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±±
±±³ Alteracoes desde sua construcao inicial          '                     ³±±±
±±ÃÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±±
±±³ Data     ³ BOPS ³ Programador ³ Breve Descricao                       ³±±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±0±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define nome da funcao...                                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
User Function CRJR005()
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define variavaoeis...                                                      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
PRIVATE nQtdLin 	:= 58
PRIVATE cNomeProg   := "CRJR055"
PRIVATE nCaracter   := 15
PRIVATE nLimite     := 220
PRIVATE cTamanho    := "G"
PRIVATE cTitulo     := "Relatorio Gerencial de Pagamento de Associado"
PRIVATE cDesc1      := ""
PRIVATE cDesc2      := ""
PRIVATE cDesc3      := ""
PRIVATE cCabec1     := "                                                                                                      "
PRIVATE cCabec2     := ""
PRIVATE cAlias      := "BA3"
PRIVATE cPerg       := "CRJ005"
PRIVATE cRel        := "CRJR055"
PRIVATE nLi         := 01
PRIVATE m_pag       := 1
PRIVATE aReturn     := { "Zebrado", 1,"Administracao", 1, 1, 1, "",1 }
PRIVATE lAbortPrint := .F.
PRIVATE aOrdens     := { "Codigo do plano" }
PRIVATE lDicion     := .F.
PRIVATE lCompres    := .F.
PRIVATE lCrystal    := .F.
PRIVATE lFiltro     := .T.   
private nVlbxa      := 0.00

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Chama SetPrint                                                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
CriaSX1()

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

cOpe     	:= mv_par01
dBaixaDe	:= mv_par02
dBaixaAte	:= mv_par03
dVencDe		:= mv_par04
dVencAte	:= mv_par05
cCodPlaI 	:= mv_par06
cCodPlaF 	:= mv_par07
nTipo		:= mv_par08
lListTit	:= (mv_par09==1)
nConsid		:= mv_par10
nIdent		:= mv_par11
cNumTit		:= Alltrim(mv_par12)
cCodEmpI    := mv_par13
cCodEmpF    := mv_par14
If nTipo == 2 // Sintetico!!
	lListTit := .T.
Endif

If nTipo == 1 .or. nTipo == 2
	cCabec1 := "Plano                                                                                                                                                                                                               "
	cCabec2 := "Referencia              Contr.    Opcionais    Tx Adesao      Debitos     Creditos     Participacao       Tarifa     Farmacia        Juros   Guia Medico       Cartão       Outros          Liquido          Baixado"
	
Else
	cCabec1 := "Plano                                                                                                                                                                                                               "
	cCabec2 := "Referencia              Contr.    Opcionais    Tx Adesao      Debitos     Creditos     Participacao       Tarifa     Farmacia        Juros   Guia Medico       Cartão       Outros          Liquido          Baixado"
	
Endif

cTitulo := AllTrim(cTitulo) + " - " + "Referencia "+dToc(dBaixaDe)+ " a " + dToc(dBaixaAte)+' - Com Movto. Bancario.'
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Configura Impressora                                                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
SetDefault(aReturn,cAlias)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta RptStatus...                                                       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Proc2BarGauge({|| aCriticas := RJ002Imp()() }  , "Imprimindo...")

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Fim da Rotina Principal...                                               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±±
±±³Funcao    ³ RJ001Imp³ Autor ³ Geraldo Felix Junior   ³ Data ³ 04.11.07 ³±±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±±
±±³Descricao ³ Relatorio de contratos.                                    ³±±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define nome da funcao                                                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Static Function RJ002Imp()
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis do IndRegua...                                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
LOCAL i
LOCAL n
LOCAL nTotMen 	:= 0
LOCAL nTotOpc 	:= 0
LOCAL nTotAde 	:= 0
LOCAL nTotDeb 	:= 0
LOCAL nTotCre 	:= 0
LOCAL nTotPar 	:= 0
LOCAL nTotTax 	:= 0
LOCAL nTotTar	:= 0
LOCAL nTotPla	:= 0
LOCAL nTotFar	:= 0
LOCAL nTotPF	:= 0
LOCAL nTotOut 	:= 0
LOCAL nTotJur	:= 0
LOCAL nTotTit	:= 0
LOCAL nTotal	:= 0
LOCAL pMoeda1	:= "@E 999,999.99"
LOCAL pMoeda2	:= "@E 9,999,999.99"
LOCAL pMoeda3	:= "@E 99,999,999.99"
LOCAL nPos		:= 0
LOCAL nPosTit	:= 0
LOCAL aTitulos 	:= {}
LOCAL aPlaUsr	:= {}
LOCAL nPosPla	:= 0
LOCAL _cCodPla	:= ''
LOCAL _cVerPla 	:= ''
LOCAL nTotGMen 	:= 0
LOCAL nTotGOpc 	:= 0
LOCAL nTotGAde 	:= 0
LOCAL nTotGDeb 	:= 0
LOCAL nTotGCre 	:= 0
LOCAL nTotGPF  	:= 0
LOCAL nTotGTar 	:= 0
LOCAL nTotGFar 	:= 0
LOCAL nTotGOut 	:= 0
LOCAL nTotGBai	:= 0
LOCAL nTotGJur 	:= 0
LOCAL nTotGGui	:= 0
LOCAL nTotGui	:= 0
LOCAL nTotCar	:= 0
LOCAL nTotGCar	:= 0
LOCAL nTotGeral	:= 0
LOCAL nTotLinha := 0
LOCAL nTotGrupo := 0
LOCAL nTotBaixa := 0
LOCAL nTotPMen  := 0
LOCAL nTotPOpc := 0
LOCAL nTotPAde := 0
LOCAL nTotPDeb := 0
LOCAL nTotPCre := 0
LOCAL nTotPPf  := 0
LOCAL nTotPTar := 0
LOCAL nTotPFar := 0
LOCAL nTotPJur := 0
LOCAL nTotPOut := 0
LOCAL nTotPGui := 0
LOCAL nTotPCar := 0
LOCAL nTotPGrp := 0
LOCAL nTotPBai := 0
LOCAL nVenMen := 0
LOCAL nVenOpc := 0
LOCAL nVenAde := 0
LOCAL nVenDeb := 0
LOCAL nVenCre:= 0
LOCAL nVenPF  := 0
LOCAL nVenTar := 0
LOCAL nVenFar := 0
LOCAL nVenJur := 0
LOCAL nVenGui := 0
LOCAL nVenCar := 0
LOCAL nVenOut := 0
Local nControl := 0
LOCAL nVenGrupo := 0
LOCAL nVenBaixa := 0                                                              
LOCAL nRat		:= 0
LOCAL nH		:= 0
LOCAL lLog		:= .F.
LOCAL nBaixaDac	:= 0
Local aCampoTRB := {	{ "TR1_CODIGO"    	, "C", TamSX3("BM1_CODPLA")[1]	, 0 },;
{ "TR1_DESCRI" 		, "C", TamSX3("BM1_DESPLA")[1]								, 0 },;
{ "TR1_ANO" 		, "C", TamSX3("BM1_ANO")[1]										, 0 },;
{ "TR1_MES"			, "C", TamSX3("BM1_MES")[1]										, 0 },;
{ "TR1_TIPCOB"		, "C", TamSX3("E1_FORMREC")[1]									, 0 },;
{ "TR1_BAIXA"		, "D", 8														, 0 },;
{ "TR1_VENCTO"		, "D", 8														, 0 },;
{ "TR1_PREFIX"		, "C", TamSX3("E1_PREFIXO")[1]									, 0 },;
{ "TR1_NUM"			, "C", TamSX3("E1_NUM")[1]										, 0 },;
{ "TR1_PARCEL"		, "C", TamSX3("E1_PARCELA")[1]									, 0 },;
{ "TR1_TIPO"		, "C", TamSX3("E1_TIPO")[1]										, 0 },;
{ "TR1_VALTIT"		, "N", TamSX3("E1_VALOR")[1]									, 2 },;
{ "TR1_DACAO"		, "C", 1														, 0 },;
{ "TR1_VLRBAI"		, "N", TamSX3("E1_VALOR")[1]									, 2 },; 
{ "TR1_TOTBAI"		, "N", TamSX3("E1_VALOR")[1]									, 2 },;
{ "TR1_NUMBCO"		, "C", TamSX3("E1_NUMBCO")[1]									, 0 },;
{ "TR1_VLRMEN"		, "N", TamSX3("BM1_VALOR")[1]									, 2 },;
{ "TR1_VLRDEB"		, "N", TamSX3("BM1_VALOR")[1]									, 2 },;
{ "TR1_VLRCRE"		, "N", TamSX3("BM1_VALOR")[1]									, 2 },;
{ "TR1_VLROPC"		, "N", TamSX3("BM1_VALOR")[1]									, 2 },;
{ "TR1_VLRTAX"		, "N", TamSX3("BM1_VALOR")[1]									, 2 },;
{ "TR1_VLRPF"		, "N", TamSX3("BM1_VALOR")[1]									, 2 },;
{ "TR1_VLRTAR"		, "N", TamSX3("BM1_VALOR")[1]									, 2 },;
{ "TR1_VLRFAR" 		, "N", TamSX3("BM1_VALOR")[1]										, 2 },;
{ "TR1_VLRGUI" 		, "N", TamSX3("BM1_VALOR")[1]										, 2 },;
{ "TR1_VLRCAR" 		, "N", TamSX3("BM1_VALOR")[1]										, 2 },;
{ "TR1_VLRJUR" 		, "N", TamSX3("BM1_VALOR")[1]										, 2 },;
{ "TR1_VLROUT" 		, "N", TamSX3("BM1_VALOR")[1]										, 2 }}

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Exibe mensagem informativa...                                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
IncProcG1("Aguarde. Buscando dados no servidor...")
ProcessMessage()
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Totalizadores por Empresa...                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
PRIVATE nTotCobEmp := 0
PRIVATE nTotRegEmp := 0
Private aQtdusrEmp := 0
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Totalizadores por Contrato...                                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
PRIVATE nTotCobCon := 0
PRIVATE nTotRegCon := 0
Private aQtdusrCon := 0
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Totalizadores por SubContrato...                                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
PRIVATE nTotCobSub := 0
PRIVATE nTotRegSub := 0
PRIVATE nVlrCob    := 0
Private aQtdusrSub := 0     

Private a_Vet 		:= {}
Private a_Cabec 		:= {}

// Monta variaveis com os prefixo utilizados pelo SIGAPLS para gerar titulos no contas a receber...
SX5->( dbSetorder(01) )
cPrefixos := ''
If SX5->( dbSeek(xFilial("SX5")+"BK") )
	While SX5->( !Eof() ) .and. Alltrim(SX5->X5_TABELA) == 'BK'
		cPrefixos += IIf(Empty(cPrefixos), "", ";")+ Alltrim(SX5->X5_CHAVE)
		
		SX5->( dbSkip() )
	Enddo
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Inicia analize com LOG...                                                ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If lLog
	nHoraBase := Seconds()
	PlsLogFil("","CRJR.LOG")
	PlsLogFil("                                 -> Inicio                    ->  ","CRJR.LOG")
	PlsLogFil("","CRJR.LOG")
	nHorIni := Seconds()
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta Expressao de filtro...                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cQuery := "SELECT E5_FILIAL, E5_PREFIXO, E5_NUMERO, E5_PARCELA, E5_TIPO, "
cQuery += "E5_CLIFOR, E5_LOJA, E5_MOTBX, E5_DTDISPO, E5_VALOR, E5_DATA, E5_RECPAG, E5_SEQ "
cQuery += "FROM " + RetSqlName("SE5")+" SE5, " + RetSqlName("SE1")+" SE1 "
cQuery += "WHERE E5_FILIAL = E1_FILIAL "
cQuery += "AND E5_PREFIXO = E1_PREFIXO "
cQuery += "AND E5_NUMERO = E1_NUM "
cQuery += "AND E5_PARCELA = E1_PARCELA "
cQuery += "AND E5_TIPO = E1_TIPO "
cQuery += "AND E1_FILIAL = '" + xFilial("SE1") + "' "
cQuery += "AND E5_FILIAL = '" + xFilial("SE5") + "' "
cQuery += "AND E5_SITUACA <> 'C' "

// Expressao de filtro da data da baixa e do vencimento...
If nConsid == 1
	cQuery += " AND ((E5_DATA 	between '" + dTos(dBaixaDe) 	+ "' AND '" + dTos(dBaixaAte)	+ "')) "
//	cQuery += " OR (E5_RECPAG = 'P' AND E5_TIPODOC = 'ES')) "
//	cQuery += " AND E5_DATA  >= '"+dTos(dBaixaDe)+"'))"
Else
	cQuery += " AND ((E5_DTDISPO  between '" + dTos(dBaixaDe)+ "' AND '" + dTos(dBaixaAte)	+ "')) "
//	cQuery += " OR (E5_RECPAG = 'P' AND E5_TIPODOC = 'ES')) "
//	cQuery += " AND E5_DTDISPO  >= '"+dTos(dBaixaDe)+"'))"
Endif

If lListTit                                                          
	cQuery += " AND E1_VENCTO	between '" + dTos(dVencDe) + "'  AND '" + dTos(dVencAte)	+ "' "
Endif

IF cCodEmpI <> "0004"

cQuery += "AND E1_CODEMP <> '0004'"

EndIf                              

IF !eMPTY(MV_PAR16)

cQuery += "AND E5_BANCO between '" + MV_PAR15 + "' AND '" + MV_PAR16 + "' "

EndIf                              


If Empty(cNumTit)
	// Expressao de filtro do prefixo... deve se considerar apenas os prefixos do PLS.
	cQuery += " AND E5_PREFIXO IN "+FormatIn(cPrefixos,";")
	cQuery += " AND E5_NUMERO >= '      ' AND E5_NUMERO <= 'ZZZZZZ' "   // Para utilizar o indice do SE5.
	
Else
	If nIdent == 1
		// Expressao de filtro do prefixo... deve se considerar apenas os prefixos do PLS.
		cQuery += " AND E5_PREFIXO IN "+FormatIn(cPrefixos,";")
		cquery += " AND E5_NUMERO = '"+cNumTit+"' "
	Else
		// Expressao de filtro do prefixo... deve se considerar apenas os prefixos do PLS.
		cQuery += " AND E1_PREFIXO IN "+FormatIn(cPrefixos,";")
		cquery += " AND E1_NUMBCO = '"+cNumTit+"' "
	Endif		
Endif

// Nao considera abatimentos
cQuery += " AND E5_TIPO NOT IN " + FormatIn(MVABATIM,"|")
cQuery += " AND E5_TIPODOC NOT IN ('DC','D2','JR','J2','TL','MT','M2','CM','C2','TR','TE') "

cQuery += " AND  not exists (SELECT * FROM SE5010 E52 WHERE SE5.E5_FILIAL = E52.E5_FILIAL AND SE5.E5_PREFIXO = E52.E5_PREFIXO AND SE5.E5_NUMERO=E52.E5_NUMERO AND SE5.E5_SEQ= E52.E5_SEQ AND ( E52.E5_SITUACA = 'C' or E52.E5_TIPODOC = 'ES' ) and d_e_l_e_t_ = ' ')"

cQuery += " AND SE1.D_E_L_E_T_ = ' '  "
cQuery += " AND SE5.D_E_L_E_T_ = ' '  "

// seta a ordem de acordo com a opcao do usuario
cQuery += " ORDER BY E5_PREFIXO, E5_NUMERO, E5_PARCELA, E5_TIPO, E5_CLIFOR, E5_LOJA, E5_SEQ" // 

MemoWrit("c:\temp\cg.txt",cQuery)

PlsQuery(cQuery, "TRBSE1")

If lLog
	PlsLogFil("                                 -> Query principal                           ->  "+AllTrim(Str(Seconds()-nHorIni,10,3)),"CRJR.LOG")
	nHorIni := Seconds()
Endif

nQtd:=1
TRBSE1->(DBEval( { | | nQtd ++ }))
If lLog
	PlsLogFil("                                 -> Conta os registros                        ->  "+AllTrim(Str(Seconds()-nHorIni,10,3)),"CRJR.LOG")
	nHorIni := Seconds()
Endif

BarGauge1Set(nQtd)

TRBSE1->(DbGoTop())
If lLog
	PlsLogFil("                                 -> DBGOTOP                                   ->  "+AllTrim(Str(Seconds()-nHorIni,10,3)),"CRJR.LOG")
	nHorIni := Seconds()
Endif

BQC->(DbSetOrder(1))
BFQ->(DbSetOrder(1))
BI3->(dbSetorder(1))
SE1->(dbSetorder(1))
BA1->(dbSetorder(2))
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Cria o Arquivo de Trabalho que armazenara os valores por produto...      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cArqTRB := CriaTrab(aCampoTRB, .T.)

dbUseArea(.T.,,cArqTRB,"TRB1",.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Cria Indice 1 do Arquivo de Trabalho com a Grade Curricular do aluno.    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cInd1TRB := CriaTrab(Nil, .F.)

// Indice diferenciado para a opcao de impressao de titulos...
If lListTit
	If nIdent == 1 // Listar numero do titulo...
		IndRegua("TRB1",cInd1TRB,"TR1_DACAO + TR1_CODIGO + TR1_ANO + TR1_MES + TR1_TIPCOB + dTos(TR1_VENCTO) + TR1_PREFIX + TR1_NUM + TR1_PARCEL + TR1_TIPO",,,"Indexando Arquivo de Trabalho")
		
	Else // Listar nosso numero...
		IndRegua("TRB1",cInd1TRB,"TR1_DACAO + TR1_CODIGO + TR1_ANO + TR1_MES + TR1_TIPCOB + dTos(TR1_VENCTO) + TR1_NUMBCO",,,"Indexando Arquivo de Trabalho")
	
	Endif
	
Else
	IndRegua("TRB1",cInd1TRB,"TR1_DACAO + TR1_CODIGO + TR1_ANO + TR1_MES + TR1_TIPCOB + dTos(TR1_VENCTO)",,,"Indexando Arquivo de Trabalho")
	
Endif

// Indexa o arquico temporario..
TRB1->( dbClearIndex() )
TRB1->(dbSetIndex(cInd1TRB + OrdBagExt()))
If lLog
	PlsLogFil("                                 -> Criando arquivo temporario                ->  "+AllTrim(Str(Seconds()-nHorIni,10,3)),"CRJR.LOG")
	nHorIni := Seconds()
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define matriz de planos...                                               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
aPlanos := {}

cPreRat := ''
cNumRat	:= ''
cParRat	:= ''
cTipRat	:= ''
cChvTit  := ''
 	
While ! TRBSE1->(Eof())
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Posicion o registro fisicamente no SE1...                                ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	//	SE1->( dbGoto(TRBSE1->SE1RECNO) )
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifica se o titulo sofreu movimentacao                                 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	lCanc 	:= .F.
	lDac	:= .F.
	nBaixa	:= 0
	cPrefix := TRBSE1->E5_PREFIXO
	cNum	:= TRBSE1->E5_NUMERO
	cParcel	:= TRBSE1->E5_PARCELA
	cTipo	:= TRBSE1->E5_TIPO
	cCLi	:= TRBSE1->E5_CLIFOR
	cLoja	:= TRBSE1->E5_LOJA
	cSeq	:= TRBSE1->E5_SEQ
	// aki altamiro 29/06/09 ///// correcao acumulo no valor total da baixa nao financeira 
   nBaixaDac	:= 0    
   
  
	////////////////////////////////////////////////////////////////////////////////////	
	If nConsid == 1 // Considera data da baixa
		dData := TRBSE1->E5_DATA
		
	Else // Considera data da disponibilizacao...
		dData := TRBSE1->E5_DTDISPO
		
	Endif
	
	If lLog
		//		             10        20        30        40        50
		//         012345678901234567890123456789012345678901234567890
		PlsLogFil("-> inicio processo SE5                         ->  "+AllTrim(Str(Seconds()-nHorIni,10,3)),"CRJR.LOG")
		nHorIni := Seconds()
	Endif
	While ! TRBSE1->(eof()) .and. 	xFilial("SE5") + cPrefix + cNum + cParcel + cTipo + cCli + cLoja ==; //+ cSeq ==;
		TRBSE1->(E5_FILIAL+E5_PREFIXO+E5_NUMERO+E5_PARCELA+E5_TIPO+E5_CLIFOR+E5_LOJA ) //+E5_SEQ)
		
		If TemBxCanc(TRBSE1->(E5_FILIAL+E5_PREFIXO+E5_NUMERO+E5_PARCELA+E5_TIPO+E5_CLIFOR+E5_LOJA+E5_SEQ),.T.)
			TRBSE1->(dbSkip())
			Loop
			
		ElseIf TRBSE1->E5_MOTBX == GetNewPar("MV_PLMOTBC","CAN")
			lCanc := .T. // indica que o titulo foi baixado por motivo de cancelamento
			
		Else
			// Tratar titulos baixados por DACAO...
			lDac	:= !(MovBcoBx( TRBSE1->E5_MOTBX, .F. )) // indica que o titulo foi baixado por motivo de DACAO
			
		Endif
		
		If !lDac // Baixa financeira
			If TRBSE1->E5_RECPAG == 'R'
				nBaixa += TRBSE1->E5_VALOR
			Else
				nBaixa -= TRBSE1->E5_VALOR
			Endif
		Else
			If TRBSE1->E5_RECPAG == 'R'
				nBaixaDac += TRBSE1->E5_VALOR
			Else
				nBaixaDac -= TRBSE1->E5_VALOR
			Endif
		Endif
		TRBSE1->(dbSkip())
	Enddo
	If lLog
		//		             10        20        30        40        50
		//         012345678901234567890123456789012345678901234567890
		PlsLogFil("-> FIM processo SE5            ->  "+cPrefix + cNum + cParcel + cTipo+"->"+AllTrim(Str(Seconds()-nHorIni,10,3)),"CRJR.LOG")
		nHorIni := Seconds()
	Endif
	// Se nao houver baixas, volta ao topo...
	If nBaixa <= 0 .and. nBaixaDac <= 0
		Loop
	Endif
	
	For nControl := 1 To 2 // PrimeirA vez para baixa normal, a segundA vez Para baixa nao financEira.
		
		If nControl == 1
			If nBaixa <= 0
				Loop
			Else
				lDac := .F.
			Endif
		ElsE 
			If nBaixaDac <= 0
				Loop
			ElsE
				lDac :=.T.
				nBaixa := nBaixADaC 
			Endif
		Endif
			
		// Caractere que define ordem do relatorio por tipo baixa...
		If lDac
			cDacao	:= 'B'
		Else
			cDacao	:= 'A'
		Endif
		
		// Titulo sera desconsiderado por ter sido baixado por cancelamento..
		If lCanc
			//   	TRBSE1->( dbSkip() )
			Loop
		Endif
		
		// Psiciona o SE1 novamente...
		SE1->( dbSeek(xFilial("SE1") + cPrefix + cNum + cParcel + cTipo) )
		
		_cAno 	:= SE1->E1_ANOBASE
		_cMes 	:= SE1->E1_MESBASE
		nQtd 		:= 0
		aRateio 	:= {}
		lRateio 	:= .F.
		lFracao	:= .F.
		
		// Caso seja uma baixa parcial e exista mais de um produto na composicao do titulo, o valor da baixa devera
		// ser fracionado durante o rateio do valor da baixa entre os planos...
		If (SE1->E1_VALOR - nBaixa) > 0
			lFracao := .T.
		Endif
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Apresenta mensagem em tela...                                            ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If lLog
			//		             10        20        30        40        50
			//         012345678901234567890123456789012345678901234567890
			PlsLogFil("-> Inicio QUERY BM1                            ->  "+AllTrim(Str(Seconds()-nHorIni,10,3)),"CRJR.LOG")
			nHorIni := Seconds()
		Endif
		IncProcG1("Processando titulo - "+ SE1->(E1_PREFIXO + '.' + E1_NUM + '.' + E1_PARCELA + E1_TIPO))
		ProcessMessage()
		// verifico se existe mais de um produto na
		// composicao do titulo e caso exista, realizo o rateio do valor da baixa...
		cSql := "SELECT distinct decode(BM1_CODPLA, '0114', '0112', '0115' , '0113', BM1_CODPLA) BM1_CODPLA "
		cSql += "FROM "+RetSqlName("BM1")+" BM1 "
		cSql += "WHERE BM1_FILIAL = '"+xFilial("BM1")+"' "
		cSql += "AND BM1_PREFIX = '"+cPrefix+"' "
		cSql += "AND BM1_NUMTIT = '"+cNum+"' "
		cSql += "AND BM1_PARCEL = '"+cParcel+"' "
		cSql += "AND BM1_TIPTIT = '"+cTipo+"' "
		//cSql += "AND BM1_CODPLA <> ' ' "
		cSql += "AND BM1.D_E_L_E_T_ = ' ' "
		
		PlsQuery(cSql, "TRB")
		If lLog
			//		             10        20        30        40        50
			//         012345678901234567890123456789012345678901234567890
			PlsLogFil("-> Fim QUERY BM1                               ->  "+AllTrim(Str(Seconds()-nHorIni,10,3)),"CRJR.LOG")
			nHorIni := Seconds()
		Endif
		
		TRB->(DBEval( { | | nQtd ++ }))
		If lLog
			//		             10        20        30        40        50
			//         012345678901234567890123456789012345678901234567890
			PlsLogFil("-> Contador de registros                       ->  "+AllTrim(Str(Seconds()-nHorIni,10,3)),"CRJR.LOG")
			nHorIni := Seconds()
		Endif
		
		TRB->( dbCloseArea() )
		If	nQtd > 1 // Deve ter pelo menos 2 planos para que seja necessario fazer o rateio...
			lRateio := .T.
		Endif             
		
		**'Marcela Coimbra - 31/07/2013'**
		If cCodEmpI == '0004' .and.  cCodEmpF == '0004'
		     
			lRateio := .T.
		
		EndIf
		
		If Select("TRB")>0
			TRB->( dbCloseArea() )
		EndIf
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Seleciona a composicao do titulo...                                      ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If lLog
			//		             10        20        30        40        50
			//         012345678901234567890123456789012345678901234567890
			PlsLogFil("-> Inicio QUERY secundaria no BM1               ->  "+AllTrim(Str(Seconds()-nHorIni,10,3)),"CRJR.LOG")
			nHorIni := Seconds()
		Endif
		
		cSql := "SELECT BM1_CODINT, BM1_CODEMP, BM1_MATRIC, BM1_TIPREG, BM1_CODTIP, BM1_DESTIP, "     //b
	 	cSql +=	"decode(trim(BM1_CODEVE), '0114', '0112', '0115' , '0113', BM1_CODEVE) BM1_CODEVE, decode(trim(BM1_CODEVE), '0114', 'STANDARD E', '0115' , 'STANDARD M', BM1_DESEVE) BM1_DESEVE, BM1_VALOR, BM1_PREFIX, BM1_NUMTIT, BM1_PARCEL, BM1_TIPTIT, "
		cSql += "decode(BM1_CODPLA, '0114', '0112', '0115' , '0113', BM1_CODPLA) BM1_CODPLA , decode(BM1_CODPLA, '0114', 'STANDARD E', '0115' , 'STANDARD M', BM1_DESPLA) BM1_DESPLA , BM1_VERPLA, BM1_ANO, BM1_MES, BM1_TIPO "
	 //	cSql := "SELECT BM1_CODINT, BM1_CODEMP, BM1_MATRIC, BM1_TIPREG, BM1_CODTIP, BM1_DESTIP, "
//	 	cSql +=	"BM1_CODEVE, BM1_DESEVE, BM1_VALOR, BM1_PREFIX, BM1_NUMTIT, BM1_PARCEL, BM1_TIPTIT, "
  //	cSql += "BM1_CODPLA, BM1_DESPLA, BM1_VERPLA, BM1_ANO, BM1_MES, BM1_TIPO  "
	    
	 //	cSql := "SELECT BM1_CODINT, BM1_CODEMP, BM1_MATRIC, BM1_TIPREG, BM1_CODTIP, BM1_DESTIP, "
	//	cSql +=	"decode(trim(BM1_CODEVE), '0114', '0112', '0115' , '0113', BM1_CODEVE) BM1_CODEVE, decode(trim(BM1_CODEVE), '0114', 'STANDARD E', '0115' , 'STANDARD M', BM1_DESEVE) BM1_DESEVE, BM1_VALOR, BM1_PREFIX, BM1_NUMTIT, BM1_PARCEL, BM1_TIPTIT, "
	//	cSql += "decode(BM1_CODPLA, '0114', '0112', '0115' , '0113', BM1_CODPLA) BM1_CODPLA, decode(BM1_CODPLA, '0114', 'STANDARD E', '0115' , 'STANDARD M', BM1_DESPLA) BM1_DESPLA, BM1_VERPLA, BM1_ANO, BM1_MES, BM1_TIPO  "

		cSql += "FROM "+RetSqlName("BM1")+" BM1 "
		cSql += "WHERE BM1_FILIAL = '"+xFilial("BM1")+"' "
		cSql += "AND BM1_PREFIX = '"+cPrefix+"' "
		cSql += "AND BM1_NUMTIT = '"+cNum+"' "
		cSql += "AND BM1_PARCEL = '"+cParcel+"' "
		cSql += "AND BM1_TIPTIT = '"+cTipo+"' " 
	
		cSql += "AND BM1_CODEMP >= '"+cCodEmpI+"' AND BM1_CODEMP <= '"+cCodEmpF+"' "   
			If cCodEmpI <> '0004' .and.  cCodEmpF <> '0004'
		//cSql += "AND BM1_CODPLA <> ' ' "      
			endIf
		cSql += "AND BM1.D_E_L_E_T_ = ' ' "
		cSql += "ORDER BY BM1_CODINT, BM1_CODEMP, BM1_MATRIC, BM1_TIPREG, BM1_CODTIP, BM1_CODEVE "
		
		PlsQuery(cSql, "TRB")
		If lLog
			//		             10        20        30        40        50
			//         012345678901234567890123456789012345678901234567890
			PlsLogFil("-> QUERY secundaria no BM1                     ->  "+AllTrim(Str(Seconds()-nHorIni,10,3)),"CRJR.LOG")
			nHorIni := Seconds()
		Endif
		nQtd := 1
		BarGauge2Set(nQtd)
		
		aPlaUsr := {}
		cChvTit := ''
		
		If lLog
			//		             10        20        30        40        50
			//         012345678901234567890123456789012345678901234567890
			PlsLogFil("-> Inicio do processamento do BM1              ->  "+AllTrim(Str(Seconds()-nHorIni,10,3)),"CRJR.LOG")
			nHorIniProc := Seconds()
		Endif
		While !TRB->( Eof() )
			// Reseta a variavel
			If lLog
				nHorIni := Seconds()
			Endif
			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Apresenta mensagem em tela...                                            ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			IncProcG2("Processando familia - "+ BA3->(BA3_CODINT+'.'+BA3_CODEMP+'.'+BA3_MATRIC))
			ProcessMessage()
			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Posiciona a familia do usuario                                           ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If TRB->(BM1_CODINT+BM1_CODEMP+BM1_MATRIC) <> BA3->(BA3_CODINT+BA3_CODEMP+BA3_MATRIC)
				BA3->( MsSeek(xFilial("BA3")+TRB->(BM1_CODINT+BM1_CODEMP+BM1_MATRIC)) )
			Endif
			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Posiciona o usuario                                           			 ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If TRB->(BM1_CODINT+BM1_CODEMP+BM1_MATRIC+BM1_TIPREG) <> BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG)
				BA1->( MsSeek(xFilial("BA1")+TRB->(BM1_CODINT+BM1_CODEMP+BM1_MATRIC+BM1_TIPREG)) )
			Endif
			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Defini qual o plano do usuario...                                  ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			_cCodPla := ''
			_cVerPla := ''
			
			// Regra numero um: Utiliza o plano do BM1.
			If !Empty(TRB->BM1_CODPLA) .and. !Empty(TRB->BM1_VERPLA)
				_cCodPla := trim(TRB->BM1_CODPLA)
				_cVerPla := TRB->BM1_VERPLA
			Endif
			
			// Regra numero tres: Utiliza o plano do usuario ou da familia.
			If Empty(_cCodPla)
				If !Empty(BA1->BA1_CODPLA)
					_cCodPla := BA1->BA1_CODPLA
					_cVerPla := BA1->BA1_VERSAO
				Else
					_cCodPla := BA3->BA3_CODPLA
					_cVerPla := BA3->BA3_VERSAO
				Endif
			Endif
			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Verifica se pode considerar o plano, de acordo com parametros...   ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If  _cCodPla < cCodPlaI .or. ;
				_cCodPla > cCodPlaF
				TRB->(DbSkip())
				Loop
			EndIf
			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Verifica se foi abortada a impressao...                            ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If  Interrupcao(lAbortPrint)
				Exit
			Endif
			
			// Posiciona o produto
			BI3->( MsSeek(xFilial("BA3")+ BA3->BA3_CODINT + _cCodPla) )
			If lLog
				//		             10        20        30        40        50
				//         012345678901234567890123456789012345678901234567890
				PlsLogFil("-> Analise do plano do usuario                 ->  "+AllTrim(Str(Seconds()-nHorIni,10,3)),"CRJR.LOG")
				nHorIni := Seconds()
			Endif
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Alimenta o arquivo temporario...                                   ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If lListTit
				If nIdent == 1 // Lista numero do titulo
					cChave := cDacao + _cCodPla + _cAno + _cMes + SE1->E1_FORMREC + dTos(SE1->E1_VENCTO) +;
					SE1->E1_PREFIXO + SE1->E1_NUM + SE1->E1_PARCELA + SE1->E1_TIPO
					
				Else  // Lista nosso numero
					cChave := cDacao + _cCodPla + _cAno + _cMes + SE1->E1_FORMREC + dTos(SE1->E1_VENCTO) +;
					Iif(!Empty(SE1->E1_NUMBCO), SE1->E1_NUMBCO, SE1->(E1_PREFIXO+E1_NUM+E1_PARCELA+E1_TIPO))
					
				Endif
				
			Else
				cChave := cDacao + _cCodPla + _cAno + _cMes + SE1->E1_FORMREC + dTos(SE1->E1_VENCTO)
				
			Endif
			If lLog
				//		             10        20        30        40        50
				//         012345678901234567890123456789012345678901234567890
				PlsLogFil("-> Inicio da gravacao                          ->  "+AllTrim(Str(Seconds()-nHorIni,10,3)),"CRJR.LOG")
				nHorIni := Seconds()
			Endif
			
			lFound := TRB1->( MsSeek( cChave ) ) // Procura registro no arquivo temporario...
			
			TRB1->( RecLock("TRB1", !lFound) )
			If !lFound                                         
			
				TRB1->TR1_CODIGO 	:= _cCodPla
				TRB1->TR1_DESCRI 	:= BI3->BI3_DESCRI
				TRB1->TR1_ANO		:= _cAno
				TRB1->TR1_MES		:= _cMes
				TRB1->TR1_VLRTAR	:= SE1->E1_DECRESC
				TRB1->TR1_BAIXA		:= dData
				TRB1->TR1_VENCTO	:= SE1->E1_VENCTO
				TRB1->TR1_TIPCOB	:= SE1->E1_FORMREC
				TRB1->TR1_PREFIX	:= SE1->E1_PREFIXO
				TRB1->TR1_NUM		:= SE1->E1_NUM
				TRB1->TR1_PARCEL	:= SE1->E1_PARCELA
				TRB1->TR1_TIPO		:= SE1->E1_TIPO
				TRB1->TR1_VALTIT	:= SE1->E1_VALOR
				TRB1->TR1_TOTBAI	:= nBaixa    		// Valor da baixa real
				
				// Caso so exista um plano na composicao, grava o valor total da baixa e nao realiza o rateio...
				If !lRateio .and. lListTit
					TRB1->TR1_VLRBAI	:= nBaixa		// O vlrbai será o valor da baixa rateada...
				Endif
				
				If !Empty(SE1->E1_NUMBCO)
					TRB1->TR1_NUMBCO	:= SE1->E1_NUMBCO
				Else
					TRB1->TR1_NUMBCO	:= SE1->(E1_PREFIXO+E1_NUM+E1_PARCELA+E1_TIPO)
				Endif
				
				If lDac
					TRB1->TR1_DACAO	:= 'B'
				Else
					TRB1->TR1_DACAO	:= 'A'
				Endif
			Endif
			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Atualiza matriz com valores do plano                               ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			// Caso so exista um plano na composicao, grava o valor total da baixa e nao realiza o rateio...
			
			If !lRateio .and. !lListTit .and. TRB->(BM1_PREFIX + BM1_NUMTIT + BM1_PARCEL + BM1_TIPTIT) <> cChvTit
				TRB1->TR1_VLRBAI	+= nBaixa
				cChvTit := TRB->(BM1_PREFIX + BM1_NUMTIT + BM1_PARCEL + BM1_TIPTIT)
				
			Endif
			
			If TRB->BM1_CODTIP $ '101, 118'		// Mensalidade
				TRB1->TR1_VLRMEN += TRB->BM1_VALOR
				
			Elseif TRB->BM1_CODTIP $ '102,133'	// Opcionais
				TRB1->TR1_VLROPC += TRB->BM1_VALOR
				
			Elseif TRB->BM1_CODTIP == '103'		// Taxa de adesao
				TRB1->TR1_VLRTAX += TRB->BM1_VALOR
				
			Elseif TRB->BM1_CODTIP == '909'		// Guia medico
				TRB1->TR1_VLRGUI += TRB->BM1_VALOR
				
			Elseif TRB->BM1_CODTIP $ '107, 908'	// Cartao de identificaçao
				TRB1->TR1_VLRCAR += TRB->BM1_VALOR
				
			Elseif TRB->BM1_CODTIP $ cCodigosPF	// Co-participacoes...
				TRB1->TR1_VLRPF  += TRB->BM1_VALOR
				
			Elseif Alltrim(TRB->BM1_CODEVE) $ GetNewPar("MV_YLANFAR","998")	// Farmacia
				TRB1->TR1_VLRFAR += TRB->BM1_VALOR
				
			Elseif Alltrim(TRB->BM1_CODEVE) $ GetNewPar("MV_YCDLJ3","993")	// Juros...
				TRB1->TR1_VLRJUR += TRB->BM1_VALOR
				
			Elseif TRB->BM1_CODTIP $ cCodDB		// Debitos / creditos...
				If BFQ->( MsSeek(xFilial("BFQ")+TRB->BM1_CODINT + TRB->BM1_CODTIP) )
					If BFQ->BFQ_DEBCRE == '2' 	// Credito.
						TRB1->TR1_VLRCRE += TRB->BM1_VALOR 
						
					Elseif BFQ->BFQ_DEBCRE == '1' // Debitos.
						TRB1->TR1_VLRDEB += TRB->BM1_VALOR
						
					Endif
				Endif
			Else
				TRB1->TR1_VLROUT += TRB->BM1_VALOR
				
			Endif
			
			// Libera o registro...
			TRB1->( MsUnlock() )
			If lLog
				//		             10        20        30        40        50
				//         012345678901234567890123456789012345678901234567890
				PlsLogFil("-> Fim da gravacao                             ->  "+AllTrim(Str(Seconds()-nHorIni,10,3)),"CRJR.LOG")
				nHorIni := Seconds()
			Endif
			
			// Reset para testar o dbskip()
			If lLog
				nHorIni := Seconds()
			Endif
			
			// Acumula o valor de cada plano para calcular as partes do rateio...                                           
		   
			If lRateio
				If (nPos := Ascan(aRateio, {|x| x[1] == cChave})) == 0
					
					Aadd(aRateio, {cChave,Iif(TRB->BM1_TIPO == '1', TRB->BM1_VALOR, (TRB->BM1_VALOR * -1)), 0})
				Else
					If TRB->BM1_TIPO == '1'
						aRateio[nPos][2] += TRB->BM1_VALOR
						
					Else
						aRateio[nPos][2] -= TRB->BM1_VALOR
						
					Endif
					
				Endif
			Endif
			
			// Acessa o proximo registro...
			
			TRB->(DbSkip())
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Fim do laco...                                                     ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If lLog
				//		             10        20        30        40        50
				//         012345678901234567890123456789012345678901234567890
				PlsLogFil("-> Proximo registro                            ->  "+AllTrim(Str(Seconds()-nHorIni,10,3)),"CRJR.LOG")
				nHorIni := Seconds()
			Endif
		Enddo
		
		If lLog
			//		             10        20        30        40        50
			//         012345678901234567890123456789012345678901234567890
			PlsLogFil("-> Fim do processamento do BM1                 ->  "+AllTrim(Str(Seconds()-nHorIniProc,10,3)),"CRJR.LOG")
			nHorIni := Seconds()
		Endif
		
		If lLog
			//		             10        20        30        40        50
			//         012345678901234567890123456789012345678901234567890
			PlsLogFil("-> Inicio do rateio por plano                  ->  "+AllTrim(Str(Seconds()-nHorIni,10,3)),"CRJR.LOG")
			nHorIni := Seconds()
		Endif
		// Realiza o rateio e grava no arquivo temporario a parte referente a cada plano que compoem o titulo...
		// anula rotina de rateio lRateio := .F.
       // lRateio := .F. // consultado ao contador sobre rateio , este mandou NAO  ratear - apurar a diferença em 29/10/10

		If lRateio .and. Len(aRateio) > 0
			/*
			For nH := 1 To Len(aRateio)
				lfracao := .f.
				If lFracao
					// Fraciona o valor...
					//				nFracao := Round(aRateio[nH][2] / SE1->E1_VALOR,10) //Gedilson
					//nFracao := round(aRateio[nH][2] / SE1->E1_VALOR,6)
				   //mbc 22/09/2016	nFracao := round(aRateio[nH][2] / SE1->E1_VALOR,17)
					nFracao := round(aRateio[nH][2] / SE1->E1_VALOR,17)
					nRat := Round((nFracao * nBaixa), 2)
					
				Else
					nRat := aRateio[nH][2]
					
				Endif
				
				If TRB1->( MsSeek( aRateio[nH][1] ) ) // Procura registro no arquivo temporario...
					TRB1->( RecLock("TRB1", .F.) )
					TRB1->TR1_VLRBAI := nRat
					TRB1->( MsUnlock() )
				Endif
			Next*/ 
			      
			n_TotRat 	:= 0   
			n_TotPRat 	:= 0   // Total parcial
			n_QtdRat 	:= 0
			
			For nH := 1 To Len(aRateio)
			
				n_TotRat += aRateio[nH][2]    
				n_QtdRat++
			
			Next     
			
			n_PerProp := 0  
			
			For nH := 1 To Len(aRateio) 
			
				n_PerProp 	:= 	round((aRateio[nH][2]/n_TotRat)*100, 2 ) // Percentual cobrado
			 	nRat 	  	:= 	round(n_PerProp*nBaixa/100, 2 )
			
				
				If nH == Len(aRateio)    

					nRat := nBaixa - n_TotPRat 
				
				EndIf    
				
					n_TotPRat	+=	nRat 
				
			 	If TRB1->( MsSeek( aRateio[nH][1] ) )
					TRB1->( RecLock("TRB1", .F.) )
					TRB1->TR1_VLRBAI := nRat
					TRB1->( MsUnlock() )
				Endif
			
			
			Next
		
				/*
				If TRB1->( MsSeek( aRateio[nH][1] ) )
				
				If lFracao
					// Fraciona o valor...
					//				nFracao := Round(aRateio[nH][2] / SE1->E1_VALOR,10) //Gedilson
					//nFracao := round(aRateio[nH][2] / SE1->E1_VALOR,6)
				   //mbc 22/09/2016	nFracao := round(aRateio[nH][2] / SE1->E1_VALOR,17)
					nFracao := round(aRateio[nH][2] / SE1->E1_VALOR,17)
					nRat := Round((nFracao * nBaixa), 2)
					
				Else
					nRat := aRateio[nH][2]
					
				Endif 
				*/
				
				 // Procura registro no arquivo temporario...   
			
		Endif
		If lLog
			//		             10        20        30        40        50
			//         012345678901234567890123456789012345678901234567890
			PlsLogFil("-> Fim do rateio por plano                     ->  "+AllTrim(Str(Seconds()-nHorIni,10,3)),"CRJR.LOG")
			nHorIni := Seconds()
		Endif
		
		If lLog
			//		             10        20        30        40        50
			//         012345678901234567890123456789012345678901234567890
			PlsLogFil(" "+AllTrim(Str(Seconds()-nHorIni,10,3)),"CRJR.LOG")
		Endif
		TRB->( dbCloseArea() )
		
	Next
Enddo


/*
          10        20        30        40        50        60        70        80        90        100       110       120       130       140       150       160       170       180       190       200       210       220
01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
2007/10         999,999,999.99   999,999.99   999,999.99   999,999.99   999,999.99   999,999,999.99   999,999.99   999,999.99   999,999.99    999,999.99   999,999.99   999,999.99   999,999,999.99   999,999,999.99
Plano
Referencia              Contr.    Opcionais    Tx Adesao      Debitos     Creditos     Participacao       Tarifa     Farmacia        Juros   Guia Medico       Cartão       Outros          Liquido          Baixado
9999-999999999999999999999999999999

2007/10         999,999,999.99   999,999.99   999,999.99   999,999.99   999,999.99   999,999,999.99   999,999.99   999,999.99   999,999.99    999,999.99   999,999.99   999,999.99   999,999,999.99   999,999,999.99
2007/10         999,999,999.99   999,999.99   999,999.99   999,999.99   999,999.99   999,999,999.99   999,999.99   999,999.99   999,999.99    999,999.99   999,999.99   999,999.99   999,999,999.99   999,999,999.99

Totais          999,999,999.99   999,999.99   999,999.99   999,999.99   999,999.99   999,999,999.99   999,999.99   999,999.99   999,999.99    999,999.99   999,999.99   999,999.99   999,999,999.99   999,999,999.99
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
*/
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Inicializa impressao dos titulos que movimentaram banco...         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

nLi := 1000
If lLog
	PlsLogFil("                                 -> Inicio da impressao                         ->  "+AllTrim(Str(Seconds()-nHorIni,10,3)),"CRJR.LOG")
	nHorIni := Seconds()
Endif					
	
TRB1->( dbGotop() )

BQL->( dbSetorder(01) )
While !TRB1->( Eof() )
	                                 
	If Alltrim(TRB1->TR1_DACAO) <> 'A'
		TRB1->( dbSkip() )
		Loop
	Endif
				
	// Controle de saldo de pagina...
	If  nli > nQtdLin
		nli := Cabec(cTitulo,cCabec1,cCabec2,cNomeProg,cTamanho,nCaracter)
		nli++
	Endif
	
	// Controle de quebra...
	cQuebra := TRB1->TR1_CODIGO
	cDesQuebr := TRB1->TR1_CODIGO + ' - ' + TRB1->TR1_DESCRI
	
	// Imprime plano, dado principal da quebra.
	// Antes de inicar a impressao, verifica se ha espaco na pagina... se nao houver, providencia o salto de pagina.
	If nLi >= 55
		nLi := 1000
		Loop
	Endif
	@ nLi, 000 Psay '==> ' + cDesQuebr
	nLi+= 2
	
	While !TRB1->( Eof() ) .and. TRB1->TR1_CODIGO == cQuebra
		
		// Controle de saldo de pagina...
		If  nli > nQtdLin
			nli := Cabec(cTitulo,cCabec1,cCabec2,cNomeProg,cTamanho,nCaracter)
			nli++
		Endif
		
		nTotLinha := 0
		@ nLi, 000 Psay '** '+ Alltrim(TRB1->TR1_ANO) + '/' + Alltrim(TRB1->TR1_MES)
		If nTipo == 1
			nLi++
		Endif
		
		// Inicia a segunda quebra, por data de baixa... a partir deste ponto a quebra fica assim: Preduto + Referencia + Data Baixa.
		_cMes := Alltrim(TRB1->TR1_MES)
		_cAno := Alltrim(TRB1->TR1_ANO)

   If TRB1->TR1_NUM == '000997852'
        
	   	ggg:= '23'
   
   EndIf 

		
		cDataBaixa 	:= ''
		cTipoCob	:= ''
		cTit		:= TRB1->(TR1_PREFIX+TR1_NUM+TR1_PARCEL+TR1_TIPO)
		lFirst		:= .T.
		
		While !TRB1->( Eof() ) .and. TRB1->TR1_CODIGO + Alltrim(TRB1->TR1_ANO) + Alltrim(TRB1->TR1_MES) == cQuebra + _cAno + _cMes
		
			If Alltrim(TRB1->TR1_DACAO) <> 'A'
				TRB1->( dbSkip() )
				Loop
			Endif
		      if 1 != 1 // força a NAO entrada nesta condição  altamiro   
		   //	If TRB1->TR1_TOTBAI < TRB1->TR1_VALTIT // Se o valor da baixa for menor que o valor do titulo, ativa rateio por coluna...
				// Calcula o fator...
				nFator := (TRB1->TR1_VLRBAI / TRB1->TR1_VALTIT)
				
				// Altera os aplicando o fator sobre os valores ja apurados...
				TRB1->( RecLock("TRB1", .F.) )
					TRB1->TR1_VLRMEN := Round((TRB1->TR1_VLRMEN * nFator),2)
					TRB1->TR1_VLROPC := Round((TRB1->TR1_VLROPC * nFator),2)
					TRB1->TR1_VLRTAX := Round((TRB1->TR1_VLRTAX * nFator),2)
					TRB1->TR1_VLRDEB := Round((TRB1->TR1_VLRDEB * nFator),2)
					TRB1->TR1_VLRCRE := Round((TRB1->TR1_VLRCRE * nFator),2)
					TRB1->TR1_VLRPF  := Round((TRB1->TR1_VLRPF  * nFator),2)
					TRB1->TR1_VLRTAR := Round((TRB1->TR1_VLRTAR * nFator),2)
					TRB1->TR1_VLRFAR := Round((TRB1->TR1_VLRFAR * nFator),2)
					TRB1->TR1_VLRJUR := Round((TRB1->TR1_VLRJUR * nFator),2)
					TRB1->TR1_VLRGUI := Round((TRB1->TR1_VLRGUI * nFator),2)
					TRB1->TR1_VLRCAR := Round((TRB1->TR1_VLRCAR * nFator),2)
					                                  
					// Recalcula valores
					nTotal := TRB1->(TR1_VLRMEN + TR1_VLROPC + TR1_VLRTAX + TR1_VLRDEB + TR1_VLRCRE +;
					TR1_VLRPF + TR1_VLRTAR + TR1_VLRFAR + TR1_VLRJUR + TR1_VLRGUI + TR1_VLRCAR)
					
					// Eh possivel existir diferenca de centavos em funcao do fator...					
					nDif := TRB1->TR1_VLRBAI - nTotal 
					                                          
					// Se existir diferenca, adicina na coluna de contra prestacao...
					If nDif > 0
						TRB1->TR1_VLRMEN += nDif
					Endif
					
					
				TRB1->( MsUnlock() )
			Endif
							
			// Imprime o tipo de cobranca quando for analitico...
			If nTipo == 1
				If BQL->( dbSeek(xFilial("BQL")+TRB1->TR1_TIPCOB) )
					cDesTipCb := BQL->BQL_DESCRI
				Else
					cDesTipCb := "Tipo de cobrança nao encontrado."
				Endif
			Endif
			
			nTotLinha := 0
			If  nli > nQtdLin
				nli := Cabec(cTitulo,cCabec1,cCabec2,cNomeProg,cTamanho,nCaracter)
				nli++
				
				// Imprime o codigo do produto e a descricao quando mudar de pagina...
				@ nLi, 000 Psay '==> ' + cDesQuebr
				nLi+= 2
			
				// Imprime o mes e o ano do movimento quando trocar de pagina...
				@ nLi, 000 Psay '** '+Alltrim(_cAno) + '/' + Alltrim(_cMes)
				
				// Imprime o tipo de cobranca quando for analitico...
				If nTipo == 1
					nLi += 2
					@ nLi, 003 Psay '**** '+cDesTipCb
					cTipoCob := TRB1->TR1_TIPCOB
					
					// Imprime o vencimento quando for analitico...
					nLi += 2
					@ nLi, 006 Psay "Vencimento: " + dToc(TRB1->TR1_VENCTO)
					nLi++
					cDataBaixa := dToc(TRB1->TR1_VENCTO)
				Endif
			Endif
			
			// Imprime o tipo de cobranca quando for analitico...
			If nTipo == 1 .and. cTipoCob <> TRB1->TR1_TIPCOB
				// Quando imprime os titulo, deve haver uma soma do total do vencimento...
				If nTipo == 1 .and. (!Empty(cDataBaixa) .and. cDataBaixa <> dToc(TRB1->TR1_VENCTO)) .and. lListTit
					nLi++
					@ nLi, 000 Psay "Total:"+cDataBaixa
					@ nLi, 016 Psay Transform(nVenMen, pMoeda2)
					@ nLi, 033 Psay Transform(nVenOpc, pMoeda1)
					@ nLi, 046 Psay Transform(nVenAde, pMoeda1)
					@ nLi, 059 Psay Transform(nVenDeb, pMoeda1)
					@ nLi, 072 Psay Transform(nVenCre, pMoeda1)
					@ nLi, 085 Psay Transform(nVenPF , pMoeda2)
					@ nLi, 102 Psay Transform(nVenTar, pMoeda1)
					@ nLi, 115 Psay Transform(nVenFar, pMoeda1)
					@ nLi, 128 Psay Transform(nVenJur, pMoeda1)
					@ nLi, 142 Psay Transform(nVenGui, pMoeda1)
					@ nLi, 155 Psay Transform(nVenCar, pMoeda1)
					@ nLi, 168 Psay Transform(nVenOut, pMoeda1)
					@ nLi, 181 Psay Transform(nVenGrupo, pMoeda2)
					@ nLi, 198 Psay Transform(nVenBaixa, pMoeda2)
					
					// Redefine as variaveis...
					nVenMen := nVenOpc := nVenAde := nVenDeb := nVenCre := nVenPF  	:= nVenTar := 0
					nVenFar := nVenJur := nVenGui := nVenCar := nVenOut := nVenGrupo	:= nVenBaixa := 0
					
					nLi++
				Endif
				
				nLi++
				@ nLi, 000 Psay Replicate('-', nLimite)
				
				nLi += 2
				@ nLi, 003 Psay '**** '+cDesTipCb
				cTipoCob := TRB1->TR1_TIPCOB
				
				nLi += 2
				@ nLi, 006 Psay "Vencimento: " + dToc(TRB1->TR1_VENCTO)
				nLi++
				cDataBaixa := dToc(TRB1->TR1_VENCTO)
			Endif
			
			// Imprime o vencimento quando for analitico...
			If nTipo == 1 .and. (Empty(cDataBaixa) .or. cDataBaixa <> dToc(TRB1->TR1_VENCTO))
				nLi++
				
				// Quando imprime os titulo, deve haver uma soma do total do vencimento...
				If lListTit
					@ nLi, 000 Psay "Total:"+cDataBaixa
					@ nLi, 016 Psay Transform(nVenMen, pMoeda2)
					@ nLi, 033 Psay Transform(nVenOpc, pMoeda1)
					@ nLi, 046 Psay Transform(nVenAde, pMoeda1)
					@ nLi, 059 Psay Transform(nVenDeb, pMoeda1)
					@ nLi, 072 Psay Transform(nVenCre, pMoeda1)
					@ nLi, 085 Psay Transform(nVenPF , pMoeda2)
					@ nLi, 102 Psay Transform(nVenTar, pMoeda1)
					@ nLi, 115 Psay Transform(nVenFar, pMoeda1)
					@ nLi, 128 Psay Transform(nVenJur, pMoeda1)
					@ nLi, 142 Psay Transform(nVenGui, pMoeda1)
					@ nLi, 155 Psay Transform(nVenCar, pMoeda1)
					@ nLi, 168 Psay Transform(nVenOut, pMoeda1)
					@ nLi, 181 Psay Transform(nVenGrupo, pMoeda2)
					@ nLi, 198 Psay Transform(nVenBaixa, pMoeda2)
					
					// Redefine as variaveis...
					nVenMen := nVenOpc := nVenAde := nVenDeb := nVenCre := nVenPF  	:= nVenTar := 0
					nVenFar := nVenJur := nVenGui := nVenCar := nVenOut := nVenGrupo	:= nVenBaixa := 0
					
					nLi += 2
				Endif
				
				@ nLi, 006 Psay "Vencimento: " + dToc(TRB1->TR1_VENCTO)
				nLi++
				cDataBaixa := dToc(TRB1->TR1_VENCTO)
			Endif
			
			// Imprime o titulo quando for analitico e o parametro "listar titulos" for = SIM...
			If nTipo == 1 .and. lListTit
				If nIdent == 1		// Lista numero do titulo
					@ nLi, 000 Psay TRB1->(TR1_PREFIX + TR1_NUM + TR1_PARCEL + TR1_TIPO)
					
				Else	// Lista nosso numero 
					@ nLi, 000 Psay TRB1->TR1_NUMBCO
				
				Endif
				
			Endif
			
			// Imprime o detalhe do relatorio...
			If nTipo == 1      
			    
				@ nLi, 016 Psay Transform(TRB1->TR1_VLRMEN, pMoeda2); nTotMen += TRB1->TR1_VLRMEN; nTotGMen += TRB1->TR1_VLRMEN; nTotLinha += TRB1->TR1_VLRMEN
				@ nLi, 033 Psay Transform(TRB1->TR1_VLROPC, pMoeda1); nTotOpc += TRB1->TR1_VLROPC; nTotGOpc += TRB1->TR1_VLROPC; nTotLinha += TRB1->TR1_VLROPC
				@ nLi, 046 Psay Transform(TRB1->TR1_VLRTAX, pMoeda1); nTotAde += TRB1->TR1_VLRTAX; nTotGAde += TRB1->TR1_VLRTAX; nTotLinha += TRB1->TR1_VLRTAX
				@ nLi, 059 Psay Transform(TRB1->TR1_VLRDEB, pMoeda1); nTotDeb += TRB1->TR1_VLRDEB; nTotGDeb += TRB1->TR1_VLRDEB; nTotLinha += TRB1->TR1_VLRDEB
				@ nLi, 072 Psay Transform(TRB1->TR1_VLRCRE, pMoeda1); nTotCre += TRB1->TR1_VLRCRE; nTotGCre += TRB1->TR1_VLRCRE; nTotLinha -= TRB1->TR1_VLRCRE
				@ nLi, 085 Psay Transform(TRB1->TR1_VLRPF , pMoeda2); nTotPF  += TRB1->TR1_VLRPF;  nTotGPF	+= TRB1->TR1_VLRPF ; nTotLinha += TRB1->TR1_VLRPF
				@ nLi, 102 Psay Transform(TRB1->TR1_VLRTAR, pMoeda1); nTotTar += TRB1->TR1_VLRTAR; nTotGTar += TRB1->TR1_VLRTAR; nTotLinha += TRB1->TR1_VLRTAR
				@ nLi, 115 Psay Transform(TRB1->TR1_VLRFAR, pMoeda1); nTotFar += TRB1->TR1_VLRFAR; nTotGFar += TRB1->TR1_VLRFAR; nTotLinha += TRB1->TR1_VLRFAR
				@ nLi, 128 Psay Transform(TRB1->TR1_VLRJUR, pMoeda1); nTotJur += TRB1->TR1_VLRJUR; nTotGJur += TRB1->TR1_VLRJUR; nTotLinha += TRB1->TR1_VLRJUR
				@ nLi, 142 Psay Transform(TRB1->TR1_VLRGUI, pMoeda1); nTotGui += TRB1->TR1_VLRGUI; nTotGGui += TRB1->TR1_VLRGUI; nTotLinha += TRB1->TR1_VLRGUI
				@ nLi, 155 Psay Transform(TRB1->TR1_VLRCAR, pMoeda1); nTotCar += TRB1->TR1_VLRCAR; nTotGCar += TRB1->TR1_VLRCAR; nTotLinha += TRB1->TR1_VLRCAR
				@ nLi, 168 Psay Transform(TRB1->TR1_VLROUT, pMoeda1); nTotOut += TRB1->TR1_VLROUT; nTotGOut += TRB1->TR1_VLROUT; nTotLinha += TRB1->TR1_VLROUT
				@ nLi, 181 Psay Transform(nTotLinha, pMoeda2); nTotGrupo += nTotLinha   
			   //mbc 22/09/2016	if   TRB1->TR1_totbai == TRB1->TR1_VLRBAI                                        
               //mbc 22/09/2016    nVlbxa :=TRB1->TR1_totbai
              //mbc 22/09/2016  else     				
               //mbc 22/09/2016    nVlbxa :=((TRB1->TR1_totbai / trb1->tr1_valtit) * TRB1->TR1_VLRBAI)
             //mbc 22/09/2016   EndIf  
             nVlbxa :=TRB1->TR1_VLRBAI 
                @ nLi, 198 Psay Transform(nVlbxa, pMoeda2); nTotBaixa += nVlbxa; nTotGBai += nVlbxa				
//				@ nLi, 198 Psay Transform(TRB1->TR1_VLRBAI, pMoeda2); nTotBaixa += TRB1->TR1_VLRBAI; nTotGBai += TRB1->TR1_VLRBAI
				
				
				
				aadd( a_Vet, {	TRB1->(TR1_PREFIX + TR1_NUM + TR1_PARCEL + TR1_TIPO),;
								TRB1->TR1_VLRMEN, ;
								TRB1->TR1_VLROPC, ;
								TRB1->TR1_VLRTAX, ;
								TRB1->TR1_VLRDEB, ;
								TRB1->TR1_VLRCRE, ;
								TRB1->TR1_VLRPF , ;
								TRB1->TR1_VLRTAR, ;
								TRB1->TR1_VLRFAR, ;
								TRB1->TR1_VLRJUR, ;
								TRB1->TR1_VLRGUI,;
								TRB1->TR1_VLRCAR,;
								TRB1->TR1_VLROUT,;
								nTotLinha ,;
								nVlbxa })
				
							
				If lListTit
					nVenMen += TRB1->TR1_VLRMEN
					nVenOpc += TRB1->TR1_VLROPC
					nVenAde += TRB1->TR1_VLRTAX
					nVenDeb += TRB1->TR1_VLRDEB
					nVenCre += TRB1->TR1_VLRCRE
					nVenPF  += TRB1->TR1_VLRPF
					nVenTar += TRB1->TR1_VLRTAR
					nVenFar += TRB1->TR1_VLRFAR
					nVenJur += TRB1->TR1_VLRJUR
					nVenGui += TRB1->TR1_VLRGUI
					nVenCar += TRB1->TR1_VLRCAR
					nVenOut += TRB1->TR1_VLROUT
					nVenGrupo += nTotLinha
				  //
				  	nVenBaixa += nVlbxa
				Endif
				
				nLi++
			Else        
				/* if   TRB1->TR1_totbai = TRB1->TR1_VLRBAI                                        
                   nVlbxa :=TRB1->TR1_totbai
                else     				
                   nVlbxa :=((TRB1->TR1_totbai / trb1->tr1_valtit) * TRB1->TR1_VLRBAI)
                EndIf   ?  
                */
                
                nVlbxa :=TRB1->TR1_VLRBAI
                
				// Totaliza por plano para imprimir em uma unica linha sintetica...
				nTotMen += TRB1->TR1_VLRMEN; nTotGMen += TRB1->TR1_VLRMEN; nTotLinha += TRB1->TR1_VLRMEN
				nTotOpc += TRB1->TR1_VLROPC; nTotGOpc += TRB1->TR1_VLROPC; nTotLinha += TRB1->TR1_VLROPC
				nTotAde += TRB1->TR1_VLRTAX; nTotGAde += TRB1->TR1_VLRTAX; nTotLinha += TRB1->TR1_VLRTAX
				nTotDeb += TRB1->TR1_VLRDEB; nTotGDeb += TRB1->TR1_VLRDEB; nTotLinha += TRB1->TR1_VLRDEB
				nTotCre += TRB1->TR1_VLRCRE; nTotGCre += TRB1->TR1_VLRCRE; nTotLinha -= TRB1->TR1_VLRCRE
				nTotPF 	+= TRB1->TR1_VLRPF;  nTotGPF  += TRB1->TR1_VLRPF ; nTotLinha += TRB1->TR1_VLRPF
				nTotTar += TRB1->TR1_VLRTAR; nTotGTar += TRB1->TR1_VLRTAR; nTotLinha += TRB1->TR1_VLRTAR
				nTotFar += TRB1->TR1_VLRFAR; nTotGFar += TRB1->TR1_VLRFAR; nTotLinha += TRB1->TR1_VLRFAR
				nTotJur += TRB1->TR1_VLRJUR; nTotGJur += TRB1->TR1_VLRJUR; nTotLinha += TRB1->TR1_VLRJUR
				nTotGui += TRB1->TR1_VLRGUI; nTotGGui += TRB1->TR1_VLRGUI; nTotLinha += TRB1->TR1_VLRGUI
				nTotCar += TRB1->TR1_VLRCAR; nTotGCar += TRB1->TR1_VLRCAR; nTotLinha += TRB1->TR1_VLRCAR
				nTotOut += TRB1->TR1_VLROUT; nTotGOut += TRB1->TR1_VLROUT; nTotLinha += TRB1->TR1_VLROUT
                nTotBaixa += nVlbxa; nTotGBai += nVlbxa				
				//nTotBaixa += TRB1->TR1_VLRBAI; nTotGBai += TRB1->TR1_VLRBAI
				nTotGrupo += nTotLinha
				
			Endif
			TRB1->( dbSkip() )
		Enddo
		
		// Quando imprime os titulo, deve haver uma soma do total do vencimento...
		If nTipo == 1 .and. lListTit
			nLi++
			@ nLi, 000 Psay "Total:"+cDataBaixa
			@ nLi, 016 Psay Transform(nVenMen, pMoeda2)
			@ nLi, 033 Psay Transform(nVenOpc, pMoeda1)
			@ nLi, 046 Psay Transform(nVenAde, pMoeda1)
			@ nLi, 059 Psay Transform(nVenDeb, pMoeda1)
			@ nLi, 072 Psay Transform(nVenCre, pMoeda1)
			@ nLi, 085 Psay Transform(nVenPF , pMoeda2)
			@ nLi, 102 Psay Transform(nVenTar, pMoeda1)
			@ nLi, 115 Psay Transform(nVenFar, pMoeda1)
			@ nLi, 128 Psay Transform(nVenJur, pMoeda1)
			@ nLi, 142 Psay Transform(nVenGui, pMoeda1)
			@ nLi, 155 Psay Transform(nVenCar, pMoeda1)
			@ nLi, 168 Psay Transform(nVenOut, pMoeda1)
			@ nLi, 181 Psay Transform(nVenGrupo, pMoeda2)
			@ nLi, 198 Psay Transform(nVenBaixa, pMoeda2)
			
			// Redefine as variaveis...
			nVenMen := nVenOpc := nVenAde := nVenDeb := nVenCre := nVenPF  	:= nVenTar 		:= 0
			nVenFar := nVenJur := nVenGui := nVenCar := nVenOut := nVenGrupo	:= nVenBaixa 	:= 0
			
			nLi++
		Endif
		
		// Imprime totais do mes/ano de referencia do vencimento..
		If nTipo == 1
			// Imprime o total do plano, finalizando a quebra...
			nLi ++
			@ nLi, 000 Psay "Total:"+ _cAno + '/' + _cMes
		Endif
		
		@ nLi, 016 Psay Transform(nTotMen, pMoeda2)
		@ nLi, 033 Psay Transform(nTotOpc, pMoeda1)
		@ nLi, 046 Psay Transform(nTotAde, pMoeda1)
		@ nLi, 059 Psay Transform(nTotDeb, pMoeda1)
		@ nLi, 072 Psay Transform(nTotCre, pMoeda1)
		@ nLi, 085 Psay Transform(nTotPF , pMoeda2)
		@ nLi, 102 Psay Transform(nTotTar, pMoeda1)
		@ nLi, 115 Psay Transform(nTotFar, pMoeda1)
		@ nLi, 128 Psay Transform(nTotJur, pMoeda1)
		@ nLi, 142 Psay Transform(nTotGui, pMoeda1)
		@ nLi, 155 Psay Transform(nTotCar, pMoeda1)
		@ nLi, 168 Psay Transform(nTotOut, pMoeda1)
		@ nLi, 181 Psay Transform(nTotGrupo, pMoeda2)
		@ nLi, 198 Psay Transform(nTotBaixa, pMoeda2)
		
		nLi ++
		If nTipo == 1  // Apenas para o analitico...
			@ nLi, 000 Psay Replicate('-', nLimite)
			
			nLi += 2
		Endif
		// Incrementa total geral do relatorio
		nTotGeral += nTotGrupo
		
		// Incrementa total do plano
		nTotPMen += nTotMen
		nTotPOpc += nTotOpc
		nTotPAde += nTotAde
		nTotPDeb += nTotDeb
		nTotPCre += nTotCre
		nTotPPf  += nTotPF
		nTotPTar += nTotTar
		nTotPFar += nTotFar
		nTotPJur += nTotTit
		nTotPOut += nTotOut
		nTotPGui += nTotGui
		nTotPCar += nTotCar
		nTotPGrp += nTotGrupo
		nTotPBai += nTotBaixa
		
		// Reinicia as variaveis totalizadoras...
		nTotMen := nTotOpc := nTotAde := nTotDeb := 0
		nTotCre := nTotPF  := nTotTar := nTotFar := 0
		nTotJur := nTotTit := nTotOut := nTotGrupo := 0
		nTotGui := nTotCar := nTotBaixa := 0
		
	Enddo
	
	If  nli > nQtdLin
		nli := Cabec(cTitulo,cCabec1,cCabec2,cNomeProg,cTamanho,nCaracter)
		nli++
		
		// Imprime o codigo do produto e a descricao quando mudar de pagina...
		@ nLi, 000 Psay '==> ' + cDesQuebr
		nLi+= 2
	Endif
	
	If nTipo == 2
		nLi++
	Endif
	// Imprime o total do plano, finalizando a quebra...
	@ nLi, 000 Psay "Total plano"
	
	@ nLi, 016 Psay Transform(nTotPMen, pMoeda2)
	@ nLi, 033 Psay Transform(nTotPOpc, pMoeda1)
	@ nLi, 046 Psay Transform(nTotPAde, pMoeda1)
	@ nLi, 059 Psay Transform(nTotPDeb, pMoeda1)
	@ nLi, 072 Psay Transform(nTotPCre, pMoeda1)
	@ nLi, 085 Psay Transform(nTotPPF , pMoeda2)
	@ nLi, 102 Psay Transform(nTotPTar, pMoeda1)
	@ nLi, 115 Psay Transform(nTotPFar, pMoeda1)
	@ nLi, 128 Psay Transform(nTotPJur, pMoeda1)
	@ nLi, 142 Psay Transform(nTotPGui, pMoeda1)
	@ nLi, 155 Psay Transform(nTotPCar, pMoeda1)
	@ nLi, 168 Psay Transform(nTotPOut, pMoeda1)
	@ nLi, 181 Psay Transform(nTotPGrp, pMoeda2)
	@ nLi, 198 Psay Transform(nTotPBai, pMoeda2)
	
	nLi ++
	@ nLi, 000 Psay Replicate('-', nLimite)
	
	nLi += 2
	
	// Reinicia as variaveis totalizadoras...
	nTotPMen := nTotPOpc := nTotPAde := nTotPDeb := 0
	nTotPCre := nTotPPF  := nTotPTar := nTotPFar := 0
	nTotPJur := nTotPTit := nTotPOut := nTotPGrp:= 0
	nTotPGui := nTotPCar := nTotPBai	:= 0
	
	// Total geral do relatorio
	nTotGeral += nTotGrupo
	
	nTotMen := nTotOpc := nTotAde := nTotDeb := 0
	nTotCre := nTotPF  := nTotTar := nTotFar := 0
	nTotJur := nTotTit := nTotOut := nTotGrupo := 0
	nTotBaixa := 0
	
Enddo

// Imprime os totais gerais
If  nli > nQtdLin
	nli := Cabec(cTitulo,cCabec1,cCabec2,cNomeProg,cTamanho,nCaracter)
	nli++
Endif

// Imprime o total do plano, finalizando a quebra...
@ nLi, 000 Psay "Totais gerais "
@ nLi, 016 Psay Transform(nTotGMen, pMoeda3)
@ nLi, 033 Psay Transform(nTotGOpc, pMoeda1)
@ nLi, 046 Psay Transform(nTotGAde, pMoeda1)
@ nLi, 059 Psay Transform(nTotGDeb, pMoeda1)
@ nLi, 072 Psay Transform(nTotGCre, pMoeda1)
@ nLi, 085 Psay Transform(nTotGPF , pMoeda2)
@ nLi, 102 Psay Transform(nTotGTar, pMoeda1)
@ nLi, 115 Psay Transform(nTotGFar, pMoeda1)
@ nLi, 128 Psay Transform(nTotGJur, pMoeda1)
@ nLi, 142 Psay Transform(nTotGGui, pMoeda1)
@ nLi, 155 Psay Transform(nTotGCar, pMoeda1)
@ nLi, 168 Psay Transform(nTotGOut, pMoeda1)
@ nLi, 181 Psay Transform(nTotGeral, pMoeda3)
@ nLi, 198 Psay Transform(nTotGBai, pMoeda3)

nLi++
@ nLi, 000 Psay Replicate('-', nLimite)

/*******************************************************

Inicia a impressao dos titulos que nao movimentaram bancos

********************************************************/
// Reinicia as variaveis totalizadoras...
nTotPMen := nTotPOpc := nTotPAde := nTotPDeb := 0
nTotPCre := nTotPPF  := nTotPTar := nTotPFar := 0
nTotPJur := nTotPTit := nTotPOut := nTotPGrp:= 0
nTotPGui := nTotPCar := nTotPBai	:= 0
	
// Total geral do relatorio
nTotGeral := nTotGrupo := nTotBaixa := 0
nTotMen := nTotOpc := nTotAde := nTotDeb := 0
nTotCre := nTotPF  := nTotTar := nTotFar := 0
nTotJur := nTotTit := nTotOut := nTotGrupo := 0 

nVenMen := nVenOpc := nVenAde := nVenDeb := nVenCre := nVenPF  	:= nVenTar := 0
nVenFar := nVenJur := nVenGui := nVenCar := nVenOut := nVenGrupo	:= nVenBaixa	:= 0	

nTotGMen := nTotGOpc := nTotGAde := nTotGDeb := nTotGCre := nTotGPF := nTotGBai	 := 0
nTotGTar := nTotGFar := nTotGJur := nTotGGui := nTotGCar := nTotGOut := nTotGeral := 0

// Altera o titulo do relatorio
cTitulo := "Relatorio Gerencial de Pagamento de Associado" + " - " + "Referencia "+;
				dToc(dBaixaDe)+ " a " + dToc(dBaixaAte)+' - Sem Movto. Bancario.'
If lLog
	PlsLogFil("                                 -> Fim da impressao - Com mvto bancario        ->  "+AllTrim(Str(Seconds()-nHorIni,10,3)),"CRJR.LOG")
	nHorIni := Seconds()  

Endif					

If lLog
	PlsLogFil("                                 -> Inicio da impressao - sem mvto banc         ->  "+AllTrim(Str(Seconds()-nHorIni,10,3)),"CRJR.LOG")
	nHorIni := Seconds()
Endif					
	
nLi := 1000
TRB1->( dbGotop() )

BQL->( dbSetorder(01) )
While !TRB1->( Eof() )
	
	// Controle de saldo de pagina...
	If Alltrim(TRB1->TR1_DACAO) <> 'B'
		TRB1->( dbSkip() )
		Loop
	Endif
				
	If  nli > nQtdLin
		nli := Cabec(cTitulo,cCabec1,cCabec2,cNomeProg,cTamanho,nCaracter)
		nli++
	Endif
	
	// Controle de quebra...
	cQuebra := TRB1->TR1_CODIGO
	cDesQuebr := TRB1->TR1_CODIGO + ' - ' + TRB1->TR1_DESCRI
	
	// Imprime plano, dado principal da quebra.
	// Antes de inicar a impressao, verifica se ha espaco na pagina... se nao houver, providencia o salto de pagina.
	If nLi >= 55
		nLi := 1000
		Loop
	Endif
	@ nLi, 000 Psay '==> ' + cDesQuebr
	nLi+= 2
	
	While !TRB1->( Eof() ) .and. TRB1->TR1_CODIGO == cQuebra
		
		// Controle de saldo de pagina...
		If  nli > nQtdLin
			nli := Cabec(cTitulo,cCabec1,cCabec2,cNomeProg,cTamanho,nCaracter)
			nli++
		Endif
		
		nTotLinha := 0
		@ nLi, 000 Psay '** '+ Alltrim(TRB1->TR1_ANO) + '/' + Alltrim(TRB1->TR1_MES)
		If nTipo == 1
			nLi++
		Endif
		
		// Inicia a segunda quebra, por data de baixa... a partir deste ponto a quebra fica assim: Preduto + Referencia + Data Baixa.
		_cMes := Alltrim(TRB1->TR1_MES)
		_cAno := Alltrim(TRB1->TR1_ANO)
		
		cDataBaixa 	:= ''
		cTipoCob	:= ''
		cTit		:= TRB1->(TR1_PREFIX+TR1_NUM+TR1_PARCEL+TR1_TIPO)
		lFirst		:= .T.
		
		While !TRB1->( Eof() ) .and. TRB1->TR1_CODIGO + Alltrim(TRB1->TR1_ANO) + Alltrim(TRB1->TR1_MES) == cQuebra + _cAno + _cMes
		
			If Alltrim(TRB1->TR1_DACAO) <> 'B'
				TRB1->( dbSkip() )
				Loop
			Endif

		        
			If TRB1->TR1_VLRBAI < TRB1->TR1_VALTIT // Se o valor da baixa for menor que o valor do titulo, ativa rateio por coluna...
				// Calcula o fator...
				nFator := (TRB1->TR1_VLRBAI / TRB1->TR1_VALTIT)
				
				// Altera os aplicando o fator sobre os valores ja apurados...
				TRB1->( RecLock("TRB1", .F.) )
					TRB1->TR1_VLRMEN := Round((TRB1->TR1_VLRMEN * nFator),2)
					TRB1->TR1_VLROPC := Round((TRB1->TR1_VLROPC * nFator),2)
					TRB1->TR1_VLRTAX := Round((TRB1->TR1_VLRTAX * nFator),2)
					TRB1->TR1_VLRDEB := Round((TRB1->TR1_VLRDEB * nFator),2)
					TRB1->TR1_VLRCRE := Round((TRB1->TR1_VLRCRE * nFator),2)
					TRB1->TR1_VLRPF  := Round((TRB1->TR1_VLRPF  * nFator),2)
					TRB1->TR1_VLRTAR := Round((TRB1->TR1_VLRTAR * nFator),2)
					TRB1->TR1_VLRFAR := Round((TRB1->TR1_VLRFAR * nFator),2)
					TRB1->TR1_VLRJUR := Round((TRB1->TR1_VLRJUR * nFator),2)
					TRB1->TR1_VLRGUI := Round((TRB1->TR1_VLRGUI * nFator),2)
					TRB1->TR1_VLRCAR := Round((TRB1->TR1_VLRCAR * nFator),2)
					// Recalcula valores
					nTotal := TRB1->(TR1_VLRMEN + TR1_VLROPC + TR1_VLRTAX + TR1_VLRDEB + TR1_VLRCRE +;
					TR1_VLRPF + TR1_VLRTAR + TR1_VLRFAR + TR1_VLRJUR + TR1_VLRGUI + TR1_VLRCAR)
					
					// Eh possivel existir diferenca de centavos em funcao do fator...					
					nDif := TRB1->TR1_VLRBAI - nTotal 
					           
					// Se existir diferenca, adicina na coluna de contra prestacao...
					If nDif > 0
						TRB1->TR1_VLRMEN += nDif
					Endif
				TRB1->( MsUnlock() )
			Endif
					
			// Imprime o tipo de cobranca quando for analitico...
			If nTipo == 1
				If BQL->( dbSeek(xFilial("BQL")+TRB1->TR1_TIPCOB) )
					cDesTipCb := BQL->BQL_DESCRI
				Else
					cDesTipCb := "Tipo de cobrança nao encontrado."
				Endif
			Endif
			
			nTotLinha := 0
			If  nli > nQtdLin
				nli := Cabec(cTitulo,cCabec1,cCabec2,cNomeProg,cTamanho,nCaracter)
				nli++
				
				// Imprime o codigo do produto e a descricao quando mudar de pagina...
				@ nLi, 000 Psay '==> ' + cDesQuebr
				nLi+= 2
				
				// Imprime o mes e o ano do movimento quando trocar de pagina...
				@ nLi, 000 Psay '** '+Alltrim(_cAno) + '/' + Alltrim(_cMes)
				
				// Imprime o tipo de cobranca quando for analitico...
				If nTipo == 1
					nLi += 2
					@ nLi, 003 Psay '**** '+cDesTipCb
					cTipoCob := TRB1->TR1_TIPCOB
					
					// Imprime o vencimento quando for analitico...
					nLi += 2
					@ nLi, 006 Psay "Vencimento: " + dToc(TRB1->TR1_VENCTO)
					nLi++
					cDataBaixa := dToc(TRB1->TR1_VENCTO)
				Endif
			Endif
			
			// Imprime o tipo de cobranca quando for analitico...
			If nTipo == 1 .and. cTipoCob <> TRB1->TR1_TIPCOB
				// Quando imprime os titulo, deve haver uma soma do total do vencimento...
				If nTipo == 1 .and. (!Empty(cDataBaixa) .and. cDataBaixa <> dToc(TRB1->TR1_VENCTO)) .and. lListTit
					nLi++
					@ nLi, 000 Psay "Total:"+cDataBaixa
					@ nLi, 016 Psay Transform(nVenMen, pMoeda2)
					@ nLi, 033 Psay Transform(nVenOpc, pMoeda1)
					@ nLi, 046 Psay Transform(nVenAde, pMoeda1)
					@ nLi, 059 Psay Transform(nVenDeb, pMoeda1)
					@ nLi, 072 Psay Transform(nVenCre, pMoeda1)
					@ nLi, 085 Psay Transform(nVenPF , pMoeda2)
					@ nLi, 102 Psay Transform(nVenTar, pMoeda1)
					@ nLi, 115 Psay Transform(nVenFar, pMoeda1)
					@ nLi, 128 Psay Transform(nVenJur, pMoeda1)
					@ nLi, 142 Psay Transform(nVenGui, pMoeda1)
					@ nLi, 155 Psay Transform(nVenCar, pMoeda1)
					@ nLi, 168 Psay Transform(nVenOut, pMoeda1)
					@ nLi, 181 Psay Transform(nVenGrupo, pMoeda2)
					@ nLi, 198 Psay Transform(nVenBaixa, pMoeda2)
					
					// Redefine as variaveis...
					nVenMen := nVenOpc := nVenAde := nVenDeb := nVenCre := nVenPF  	:= nVenTar 		:= 0
					nVenFar := nVenJur := nVenGui := nVenCar := nVenOut := nVenGrupo	:= nVenBaixa	:= 0
					
					nLi++
				Endif
				
				nLi++
				@ nLi, 000 Psay Replicate('-', nLimite)
				
				nLi += 2
				@ nLi, 003 Psay '**** '+cDesTipCb
				cTipoCob := TRB1->TR1_TIPCOB
				
				nLi += 2
				@ nLi, 006 Psay "Vencimento: " + dToc(TRB1->TR1_VENCTO)
				nLi++
				cDataBaixa := dToc(TRB1->TR1_VENCTO)
			Endif
			
			// Imprime o vencimento quando for analitico...
			If nTipo == 1 .and. (Empty(cDataBaixa) .or. cDataBaixa <> dToc(TRB1->TR1_VENCTO))
				nLi++
				
				// Quando imprime os titulo, deve haver uma soma do total do vencimento...
				If lListTit
					@ nLi, 000 Psay "Total:"+cDataBaixa
					@ nLi, 016 Psay Transform(nVenMen, pMoeda2)
					@ nLi, 033 Psay Transform(nVenOpc, pMoeda1)
					@ nLi, 046 Psay Transform(nVenAde, pMoeda1)
					@ nLi, 059 Psay Transform(nVenDeb, pMoeda1)
					@ nLi, 072 Psay Transform(nVenCre, pMoeda1)
					@ nLi, 085 Psay Transform(nVenPF , pMoeda2)
					@ nLi, 102 Psay Transform(nVenTar, pMoeda1)
					@ nLi, 115 Psay Transform(nVenFar, pMoeda1)
					@ nLi, 128 Psay Transform(nVenJur, pMoeda1)
					@ nLi, 142 Psay Transform(nVenGui, pMoeda1)
					@ nLi, 155 Psay Transform(nVenCar, pMoeda1)
					@ nLi, 168 Psay Transform(nVenOut, pMoeda1)
					@ nLi, 181 Psay Transform(nVenGrupo, pMoeda2)
					@ nLi, 198 Psay Transform(nVenBaixa, pMoeda2)
					
					// Redefine as variaveis...
					nVenMen := nVenOpc := nVenAde := nVenDeb := nVenCre := nVenPF  	:= nVenTar 		:= 0
					nVenFar := nVenJur := nVenGui := nVenCar := nVenOut := nVenGrupo	:= nVenBaixa	:= 0
					
					nLi += 2
				Endif
				
				@ nLi, 006 Psay "Vencimento: " + dToc(TRB1->TR1_VENCTO)
				nLi++
				cDataBaixa := dToc(TRB1->TR1_VENCTO)
			Endif
			
			// Imprime o titulo quando for analitico e o parametro "listar titulos" for = SIM...
			If nTipo == 1 .and. lListTit
				If nIdent == 1		// Lista numero do titulo
					@ nLi, 000 Psay TRB1->(TR1_PREFIX + TR1_NUM + TR1_PARCEL + TR1_TIPO)
					
				Else	// Lista nosso numero 
					@ nLi, 000 Psay TRB1->TR1_NUMBCO
				
				Endif
			Endif
			
			// Imprime o detalhe do relatorio...
			If nTipo == 1
				@ nLi, 016 Psay Transform(TRB1->TR1_VLRMEN, pMoeda2); nTotMen += TRB1->TR1_VLRMEN; nTotGMen += TRB1->TR1_VLRMEN; nTotLinha += TRB1->TR1_VLRMEN
				@ nLi, 033 Psay Transform(TRB1->TR1_VLROPC, pMoeda1); nTotOpc += TRB1->TR1_VLROPC; nTotGOpc += TRB1->TR1_VLROPC; nTotLinha += TRB1->TR1_VLROPC
				@ nLi, 046 Psay Transform(TRB1->TR1_VLRTAX, pMoeda1); nTotAde += TRB1->TR1_VLRTAX; nTotGAde += TRB1->TR1_VLRTAX; nTotLinha += TRB1->TR1_VLRTAX
				@ nLi, 059 Psay Transform(TRB1->TR1_VLRDEB, pMoeda1); nTotDeb += TRB1->TR1_VLRDEB; nTotGDeb += TRB1->TR1_VLRDEB; nTotLinha += TRB1->TR1_VLRDEB
				@ nLi, 072 Psay Transform(TRB1->TR1_VLRCRE, pMoeda1); nTotCre += TRB1->TR1_VLRCRE; nTotGCre += TRB1->TR1_VLRCRE; nTotLinha -= TRB1->TR1_VLRCRE
				@ nLi, 085 Psay Transform(TRB1->TR1_VLRPF , pMoeda2); nTotPF  += TRB1->TR1_VLRPF;  nTotGPF	+= TRB1->TR1_VLRPF ; nTotLinha += TRB1->TR1_VLRPF
				@ nLi, 102 Psay Transform(TRB1->TR1_VLRTAR, pMoeda1); nTotTar += TRB1->TR1_VLRTAR; nTotGTar += TRB1->TR1_VLRTAR; nTotLinha += TRB1->TR1_VLRTAR
				@ nLi, 115 Psay Transform(TRB1->TR1_VLRFAR, pMoeda1); nTotFar += TRB1->TR1_VLRFAR; nTotGFar += TRB1->TR1_VLRFAR; nTotLinha += TRB1->TR1_VLRFAR
				@ nLi, 128 Psay Transform(TRB1->TR1_VLRJUR, pMoeda1); nTotJur += TRB1->TR1_VLRJUR; nTotGJur += TRB1->TR1_VLRJUR; nTotLinha += TRB1->TR1_VLRJUR
				@ nLi, 142 Psay Transform(TRB1->TR1_VLRGUI, pMoeda1); nTotGui += TRB1->TR1_VLRGUI; nTotGGui += TRB1->TR1_VLRGUI; nTotLinha += TRB1->TR1_VLRGUI
				@ nLi, 155 Psay Transform(TRB1->TR1_VLRCAR, pMoeda1); nTotCar += TRB1->TR1_VLRCAR; nTotGCar += TRB1->TR1_VLRCAR; nTotLinha += TRB1->TR1_VLRCAR
				@ nLi, 168 Psay Transform(TRB1->TR1_VLROUT, pMoeda1); nTotOut += TRB1->TR1_VLROUT; nTotGOut += TRB1->TR1_VLROUT; nTotLinha += TRB1->TR1_VLROUT
				@ nLi, 181 Psay Transform(nTotLinha, pMoeda2); nTotGrupo += nTotLinha
				@ nLi, 198 Psay Transform(TRB1->TR1_VLRBAI, pMoeda2); nTotBaixa += TRB1->TR1_VLRBAI; nTotGBai += TRB1->TR1_VLRBAI
				
				If lListTit
					nVenMen += TRB1->TR1_VLRMEN
					nVenOpc += TRB1->TR1_VLROPC
					nVenAde += TRB1->TR1_VLRTAX
					nVenDeb += TRB1->TR1_VLRDEB
					nVenCre += TRB1->TR1_VLRCRE
					nVenPF  += TRB1->TR1_VLRPF
					nVenTar += TRB1->TR1_VLRTAR
					nVenFar += TRB1->TR1_VLRFAR
					nVenJur += TRB1->TR1_VLRJUR
					nVenGui += TRB1->TR1_VLRGUI
					nVenCar += TRB1->TR1_VLRCAR
					nVenOut += TRB1->TR1_VLROUT
					nVenGrupo += nTotLinha
					nVenBaixa += TRB1->TR1_VLRBAI
				Endif
				
				nLi++
			Else
				// Totaliza por plano para imprimir em uma unica linha sintetica...
				nTotMen += TRB1->TR1_VLRMEN; nTotGMen += TRB1->TR1_VLRMEN; nTotLinha += TRB1->TR1_VLRMEN
				nTotOpc += TRB1->TR1_VLROPC; nTotGOpc += TRB1->TR1_VLROPC; nTotLinha += TRB1->TR1_VLROPC
				nTotAde += TRB1->TR1_VLRTAX; nTotGAde += TRB1->TR1_VLRTAX; nTotLinha += TRB1->TR1_VLRTAX
				nTotDeb += TRB1->TR1_VLRDEB; nTotGDeb += TRB1->TR1_VLRDEB; nTotLinha += TRB1->TR1_VLRDEB
				nTotCre += TRB1->TR1_VLRCRE; nTotGCre += TRB1->TR1_VLRCRE; nTotLinha -= TRB1->TR1_VLRCRE
				nTotPF 	+= TRB1->TR1_VLRPF;  nTotGPF  += TRB1->TR1_VLRPF ; nTotLinha += TRB1->TR1_VLRPF
				nTotTar += TRB1->TR1_VLRTAR; nTotGTar += TRB1->TR1_VLRTAR; nTotLinha += TRB1->TR1_VLRTAR
				nTotFar += TRB1->TR1_VLRFAR; nTotGFar += TRB1->TR1_VLRFAR; nTotLinha += TRB1->TR1_VLRFAR
				nTotJur += TRB1->TR1_VLRJUR; nTotGJur += TRB1->TR1_VLRJUR; nTotLinha += TRB1->TR1_VLRJUR
				nTotGui += TRB1->TR1_VLRGUI; nTotGGui += TRB1->TR1_VLRGUI; nTotLinha += TRB1->TR1_VLRGUI
				nTotCar += TRB1->TR1_VLRCAR; nTotGCar += TRB1->TR1_VLRCAR; nTotLinha += TRB1->TR1_VLRCAR
				nTotOut += TRB1->TR1_VLROUT; nTotGOut += TRB1->TR1_VLROUT; nTotLinha += TRB1->TR1_VLROUT
				nTotGrupo += nTotLinha
				nTotBaixa += TRB1->TR1_VLRBAI; nTotGBai += TRB1->TR1_VLRBAI
				
			Endif
			TRB1->( dbSkip() )
		Enddo
		
		// Quando imprime os titulo, deve haver uma soma do total do vencimento...
		If nTipo == 1 .and. lListTit
			nLi++
			@ nLi, 000 Psay "Total:"+cDataBaixa
			@ nLi, 016 Psay Transform(nVenMen, pMoeda2)
			@ nLi, 033 Psay Transform(nVenOpc, pMoeda1)
			@ nLi, 046 Psay Transform(nVenAde, pMoeda1)
			@ nLi, 059 Psay Transform(nVenDeb, pMoeda1)
			@ nLi, 072 Psay Transform(nVenCre, pMoeda1)
			@ nLi, 085 Psay Transform(nVenPF , pMoeda2)
			@ nLi, 102 Psay Transform(nVenTar, pMoeda1)
			@ nLi, 115 Psay Transform(nVenFar, pMoeda1)
			@ nLi, 128 Psay Transform(nVenJur, pMoeda1)
			@ nLi, 142 Psay Transform(nVenGui, pMoeda1)
			@ nLi, 155 Psay Transform(nVenCar, pMoeda1)
			@ nLi, 168 Psay Transform(nVenOut, pMoeda1)
			@ nLi, 181 Psay Transform(nVenGrupo, pMoeda2)
			@ nLi, 198 Psay Transform(nVenBaixa, pMoeda2)
			
			// Redefine as variaveis...
			nVenMen := nVenOpc := nVenAde := nVenDeb := nVenCre := nVenPF  	:= nVenTar 		:= 0
			nVenFar := nVenJur := nVenGui := nVenCar := nVenOut := nVenGrupo	:= nVenBaixa := 0
			
			nLi++
		Endif
		
		// Imprime totais do mes/ano de referencia do vencimento..
		If nTipo == 1
			// Imprime o total do plano, finalizando a quebra...
			nLi ++
			@ nLi, 000 Psay "Total:"+ _cAno + '/' + _cMes
		Endif
		
		@ nLi, 016 Psay Transform(nTotMen, pMoeda2)
		@ nLi, 033 Psay Transform(nTotOpc, pMoeda1)
		@ nLi, 046 Psay Transform(nTotAde, pMoeda1)
		@ nLi, 059 Psay Transform(nTotDeb, pMoeda1)
		@ nLi, 072 Psay Transform(nTotCre, pMoeda1)
		@ nLi, 085 Psay Transform(nTotPF , pMoeda2)
		@ nLi, 102 Psay Transform(nTotTar, pMoeda1)
		@ nLi, 115 Psay Transform(nTotFar, pMoeda1)
		@ nLi, 128 Psay Transform(nTotJur, pMoeda1)
		@ nLi, 142 Psay Transform(nTotGui, pMoeda1)
		@ nLi, 155 Psay Transform(nTotCar, pMoeda1)
		@ nLi, 168 Psay Transform(nTotOut, pMoeda1)
		@ nLi, 181 Psay Transform(nTotGrupo, pMoeda2)
		@ nLi, 198 Psay Transform(nTotBaixa, pMoeda2)
		
		nLi ++
		If nTipo == 1  // Apenas para o analitico...
			@ nLi, 000 Psay Replicate('-', nLimite)
			
			nLi += 2
		Endif
		// Incrementa total geral do relatorio
		nTotGeral += nTotGrupo
		
		// Incrementa total do plano
		nTotPMen += nTotMen
		nTotPOpc += nTotOpc
		nTotPAde += nTotAde
		nTotPDeb += nTotDeb
		nTotPCre += nTotCre
		nTotPPf  += nTotPF
		nTotPTar += nTotTar
		nTotPFar += nTotFar
		nTotPJur += nTotTit
		nTotPOut += nTotOut
		nTotPGui += nTotGui
		nTotPCar += nTotCar
		nTotPGrp += nTotGrupo 
		nTotPBai += nTotBaixa
		
		// Reinicia as variaveis totalizadoras...
		nTotMen := nTotOpc := nTotAde := nTotDeb := 0
		nTotCre := nTotPF  := nTotTar := nTotFar := 0
		nTotJur := nTotTit := nTotOut := nTotGrupo := 0
		nTotGui := nTotCar := nTotBaixa := 0
		
	Enddo
	
	If  nli > nQtdLin
		nli := Cabec(cTitulo,cCabec1,cCabec2,cNomeProg,cTamanho,nCaracter)
		nli++
		
		// Imprime o codigo do produto e a descricao quando mudar de pagina...
		@ nLi, 000 Psay '==> ' + cDesQuebr
		nLi+= 2
	Endif
	
	If nTipo == 2
		nLi++
	Endif
	// Imprime o total do plano, finalizando a quebra...
	@ nLi, 000 Psay "Total plano"
	
	@ nLi, 016 Psay Transform(nTotPMen, pMoeda2)
	@ nLi, 033 Psay Transform(nTotPOpc, pMoeda1)
	@ nLi, 046 Psay Transform(nTotPAde, pMoeda1)
	@ nLi, 059 Psay Transform(nTotPDeb, pMoeda1)
	@ nLi, 072 Psay Transform(nTotPCre, pMoeda1)
	@ nLi, 085 Psay Transform(nTotPPF , pMoeda2)
	@ nLi, 102 Psay Transform(nTotPTar, pMoeda1)
	@ nLi, 115 Psay Transform(nTotPFar, pMoeda1)
	@ nLi, 128 Psay Transform(nTotPJur, pMoeda1)
	@ nLi, 142 Psay Transform(nTotPGui, pMoeda1)
	@ nLi, 155 Psay Transform(nTotPCar, pMoeda1)
	@ nLi, 168 Psay Transform(nTotPOut, pMoeda1)
	@ nLi, 181 Psay Transform(nTotPGrp, pMoeda2)
	@ nLi, 198 Psay Transform(nTotPBai, pMoeda2)
	
	nLi ++
	@ nLi, 000 Psay Replicate('-', nLimite)
	
	nLi += 2
	
	// Reinicia as variaveis totalizadoras...
	nTotPMen := nTotPOpc := nTotPAde := nTotPDeb := 0
	nTotPCre := nTotPPF  := nTotPTar := nTotPFar := 0
	nTotPJur := nTotPTit := nTotPOut := nTotPGrp:= 0
	nTotPGui := nTotPCar := nTotPBai := 0
	
	// Total geral do relatorio
	nTotGeral += nTotGrupo
	
	nTotMen := nTotOpc := nTotAde := nTotDeb := 0
	nTotCre := nTotPF  := nTotTar := nTotFar := 0
	nTotJur := nTotTit := nTotOut := nTotGrupo := 0
	
Enddo

// Imprime os totais gerais
If  nli > nQtdLin
	nli := Cabec(cTitulo,cCabec1,cCabec2,cNomeProg,cTamanho,nCaracter)
	nli++
Endif

// Imprime o total do plano, finalizando a quebra...
@ nLi, 000 Psay "Totais gerais "
@ nLi, 016 Psay Transform(nTotGMen, pMoeda2)
@ nLi, 033 Psay Transform(nTotGOpc, pMoeda1)
@ nLi, 046 Psay Transform(nTotGAde, pMoeda1)
@ nLi, 059 Psay Transform(nTotGDeb, pMoeda1)
@ nLi, 072 Psay Transform(nTotGCre, pMoeda1)
@ nLi, 085 Psay Transform(nTotGPF , pMoeda2)
@ nLi, 102 Psay Transform(nTotGTar, pMoeda1)
@ nLi, 115 Psay Transform(nTotGFar, pMoeda1)
@ nLi, 128 Psay Transform(nTotGJur, pMoeda1)
@ nLi, 142 Psay Transform(nTotGGui, pMoeda1)
@ nLi, 155 Psay Transform(nTotGCar, pMoeda1)
@ nLi, 168 Psay Transform(nTotGOut, pMoeda1)
@ nLi, 181 Psay Transform(nTotGeral, pMoeda2)
@ nLi, 198 Psay Transform(nTotGBai, pMoeda2)

nLi++     

@ nLi, 000 Psay Replicate('-', nLimite)
                                       
If lLog
	PlsLogFil("                                 -> Fim da impressao - sem mvto banc         ->  "+AllTrim(Str(Seconds()-nHorIni,10,3)),"CRJR.LOG")
	nHorIni := Seconds()
Endif	  

 If Len(a_Vet) > 0 .and. ApMsgYesNo(" Gera planinha Excel ?")      

	        	aadd( a_Cabec , {'Referencia', 'Contr.', 'Opcionais','Tx Adesao','Debitos','Creditos','Participacao','Tarifa','Farmacia', 'Juros', 'Guia Medico', 'Cartão', 'Outros', 'Liquido', 'Baixado'  })
	
				DlgToExcel({{"ARRAY","Relatorio Gerencial de Pagamento de Associado" ,a_Cabec,a_Vet}})    
	
			EndIf	  			

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Imprime rodape...                                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Roda(0,Space(10))
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Fecha area de trabalho...                                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
BA3->(DbClearFilter())
BA3->(RetIndex("BA3"))

TRBSE1->( dbClosearea() )

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Finaliza e elimina o arquivo fisico do temporario...                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
TRB1->( dbCloseArea() )
FErase(cArqTRB  + ".DBF")
FErase(cInd1TRB + OrdBagExt())
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

Static Function CriaSX1()

Local aRegs	:=	{}

aadd(aRegs,{cPerg,"01","Operadora ?     ","","","mv_ch1","C", 4,0,0,"G",""           	,"mv_par01",""            	,"","","","",""               	,"","","","",""              ,"","","","",""      	,"","","","","","","","",IIf(PlsGetVersao() >= 8,"B89PLS","B89"),""})
aadd(aRegs,{cPerg,"02","Data De ?       ","","","mv_ch2","D", 8,0,0,"G",""           	,"mv_par02",""            	,"","","","",""               	,"","","","",""              ,"","","","",""      	,"","","","","","","","",""   ,""})
aadd(aRegs,{cPerg,"03","Data Ate?       ","","","mv_ch3","D", 8,0,0,"G",""           	,"mv_par03",""            	,"","","","",""               	,"","","","",""              ,"","","","",""      	,"","","","","","","","",""   ,""})
aadd(aRegs,{cPerg,"04","Vencimento De ? ","","","mv_ch4","D", 8,0,0,"G",""           	,"mv_par04",""            	,"","","","",""               	,"","","","",""              ,"","","","",""      	,"","","","","","","","",""   ,""})
aadd(aRegs,{cPerg,"05","Vencimento Ate? ","","","mv_ch5","D", 8,0,0,"G",""           	,"mv_par05",""            	,"","","","",""               	,"","","","",""              ,"","","","",""      	,"","","","","","","","",""   ,""})
aadd(aRegs,{cPerg,"06","Produto de ?    ","","","mv_ch6","C", 4,0,0,"G",""           	,"mv_par06",""       		,"","","","",""            		,"","","","",""              ,"","","","",""      	,"","","","","","","","",IIf(PlsGetVersao() >= 8,"B2DPLS","B2D"),""})
aadd(aRegs,{cPerg,"07","Produto ate?    ","","","mv_ch7","C", 4,0,0,"G",""           	,"mv_par07",""        		,"","","","",""            		,"","","","",""              ,"","","","",""      	,"","","","","","","","",IIf(PlsGetVersao() >= 8,"B2DPLS","B2D"),""})
aadd(aRegs,{cPerg,"08","Tipo Relatorio? ","","","mv_ch8","N", 1,0,0,"C",""		   	,"mv_par08","Analitico"    ,"","","","","Sintetico"      	,"","","","","Resumido"      ,"","","","",""   	,"","","","","","","","",""   	,""})
aadd(aRegs,{cPerg,"09","Listar titulos? ","","","mv_ch9","N", 1,0,0,"C",""		   	,"mv_par09","Sim"    		,"","","","","Nao"         		,"","","","",""      ,"","","","",""   	,"","","","","","","","",""   	,""})
aadd(aRegs,{cPerg,"10","Considerar Data?","","","mv_cha","N", 1,0,0,"C",""		   	,"mv_par10","Da Baixa"    	,"","","","","Da disponib."    	,"","","","",""      ,"","","","",""   	,"","","","","","","","",""   	,""})
aadd(aRegs,{cPerg,"11","Identificação ? ","","","mv_chb","N", 1,0,0,"C",""		   	,"mv_par11","No. Titulo"   ,"","","","","Nosso Numero"    	,"","","","",""      ,"","","","",""   	,"","","","","","","","",""   	,""})
aadd(aRegs,{cPerg,"12","Titulo ? 		 ","","","mv_chc","C", 16,0,0,"G",""		   	,"mv_par12",""   				,"","","","",""    					,"","","","",""      ,"","","","",""   	,"","","","","","","","",""   	,""})
aadd(aRegs,{cPerg,"13","Empresa Inicial ? ","","","mv_chd","C", 4,0,0,"G",""		   	,"mv_par13",""    ,"","","","",""      	,"","","","",""      ,"","","","",""   	,"","","","","","","","",""   	,""})
aadd(aRegs,{cPerg,"14","Empresa Final   ? ","","","mv_che","C", 4,0,0,"G",""		   	,"mv_par14",""    ,"","","","",""      	,"","","","",""      ,"","","","",""   	,"","","","","","","","",""   	,""})
aadd(aRegs,{cPerg,"15","Banco de?"         ,"","","mv_chf","C", 3,0,0,"G",""		   	,"mv_par15",""    ,"","","","",""      	,"","","","",""      ,"","","","",""   	,"","","","","","","","",""   	,""})
aadd(aRegs,{cPerg,"16","Banco Ate?"        ,"","","mv_chg","C", 3,0,0,"G",""		   	,"mv_par16",""    ,"","","","",""      	,"","","","",""      ,"","","","",""   	,"","","","","","","","",""   	,""})


PlsVldPerg( aRegs )

Return
