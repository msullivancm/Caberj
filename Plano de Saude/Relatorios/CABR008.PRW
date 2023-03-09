#Include "rwmake.ch"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABR008    ºAutor  ³Luzio Tavares      º Data ³   30/06/08  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Relatorio de erros do retorno do Itau                       º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Plano de Saúde - PLS                                       º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function CABR008()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//Local wnrel
Private cDesc1 	:= "Este programa tem como objetivo imprimir os registros que foram rejeitados pelo Itau "
Private cDesc2 	:= ""
Private cDesc3 	:= ""
Private cString 	:= "BD6"
Private nQtdLin     := 58
Private cAlias      := "BD6"
Private cRel        := "CABR008"
Private nLi         := nQtdLin+1
Private m_pag       := 1
Private lCompres    := .F.
Private lDicion     := .F.
Private lFiltro     := .F. //.T.
Private lCrystal    := .F.
//Private aOrderns    := {"Grupo/Empresa + Produto","Produto + Grupo/Empresa"}
Private lAbortPrint := .F.
PRIVATE nColuna     := 1
Private nLimite     := 220
Private tamanho 	:= "G"
Private cTitulo	:= "REGISTROS COM ERRO NO RETORNO DO ITAU"
Private aReturn := { "Zebrado", 1,"Administracao", 1, 1, 1, "",1 }
Private cPerg   := "CABR08"
Private nomeprog:= "CABR008"
Private nLastKey:=0
Private cabec1  := "Ope. Local PEG      Numero   Seq. Lote   Codigo    Descricao                                            Valor  Matricula              Nome		                                  Inclusao    Bloqueio    RDA    Mat.Empresa  Dt.Proced."
//Private cabec1  := "Ope. Local PEG      Numero   Seq. Lote   Codigo   Descricao                            Valor             Matricula   Nome"  //"Ope. Local PEG      Numero   Seq. Lote   Codigo   Descricao"
Private cabec2  := ""
Private aCodCri :=  {{"01","R","Tipo de registro invalido."},;
{"08","I","Sequencial de arquivo Invalido."},;
{"09","R","Numero da Funcional nao numerico."},;
{"10","R","Numero da Funcional nao encontrado em nosso cadastro."},;
{"11","R","Numero do Dependente nao numerico."},;
{"12","R","Numero do Deopendente nao encontrado em nosso cadastro."},;
{"15","R","Tipo de movimento invalido."},;
{"16","R","Ano Mes de Desconto Invalido."},;
{"17","R","Data Procedimento Invalida."},;
{"18","I","Nome do Credenciado nao Preenchido."},;
{"20","R","Indicador de Lancamento Invalido."},;
{"23","R","Indicador de Incidencia de fator moderador Invalido."},;
{"51","R","Registro ja Processado."},;
{"53","R","CPF do Usuario Diferente do nosso Cadastro."},;
{"54","I","Nome do BeneficiarioDiferente do nosso Cadastro."},;
{"55","I","Um erro foi encontrado no registro trailer detalhe de usuario."},;
{"56","I","Dependente Bloqueado."},;
{"57","I","Titular nao possui Dependente."},;
{"58","I","Dependente nao Encontrado."},;
{"76","R","Registro fora do periodo de vigencia do plano."},;
{"77","I","Nome Invalido - Puesquisa Fonetica."}}

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Atualiza SX1                                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
CriaSX1()

Pergunte(cPerg,.F.)

cRel := SetPrint(cString,cRel,cPerg,@cTitulo,cDesc1,cDesc2,cDesc3,.F.,"",,tamanho,,.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Acessa parametros do relatorio...                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

//cMatric  := mv_par01
dDataDe	:= mv_par03
dDataAte := mv_par04

If nLastKey == 27
	Return
End

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Configura impressora (padrao)                                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
SetDefault(aReturn,cString)

If nLastKey == 27
	Return ( NIL )
End

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Emite relat¢rio                                                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
RptStatus({|lEnd| CABR008Imp(@lEnd,cRel,cString)},cTitulo)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Fim da rotina                                                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³ Fun‡…o    ³CABR008Imp³ Autor ³ Luzio Tavares         ³ Data ³ 25/06/08 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Descri‡…o ³Impressao 											                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Sintaxe   ³CABR008Imp(lEnd,wnRel,cString)                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso       ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function CABR008Imp(lEnd,cRel,cString)

Local i := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS
Local n := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define variaveis...                                                      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local cDirExp	:= GETNEWPAR("MV_YEXFTIT","\Exporta\FTMITAU\")
Local cEOL		:= CHR(13)+CHR(10)
Local cCpo		:= ""

Local aGetUsr		:= {}
Local cbcont,cbtxt
Local cSQL
Local nTotCo, nTotPag := 0
Local cCodCri := ""
Local aTotCri := {}

Local cNumFun	:= ""
Local cFamAnt  := ""
Local cFamilia := ""

Local nTotal := 0 // recebe o n total de registros
Local nProc  := 1 // incrementado por unidade de registro
Local	Npercent := 0

Local cIndFM	:= "N"
Local nVlrPro	:= 0

Local cNomeArq	:= ""

PRIVATE cConEmp	:= ""

//cDiaGer := cMesAte+Substr(cAnoAte,3,2)
cNomeArq := cDirExp+"REJ.TXT"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para Impressao do Cabecalho e Rodape    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cbtxt    := SPACE(10)
cbcont   := 0
li       := 80
m_pag    := 1

nTipo := GetMv("MV_COMP")

dbSelectArea("BD6")

cSQL := "SELECT BD6_CODOPE, BD6_OPEUSR, BD6_CODEMP, BD6_MATRIC, BD6_TIPREG, BD6_CODLDP, BD6_DIGITO, "
cSQL += "BD6_CODPEG, BD6_NUMERO, BD6_SEQUEN, BD6_YFTITA, BD6_YERITA, BD6_DIGITO, BD6_ANOPAG, BD6_MESPAG, "
cSQL += "BD6_NOMUSR, BD6_CODRDA, BD6_NOMRDA, BD6_FASE, "
cSQL += "BD6_DATPRO, BD6_QTDPRO, BD6_STAFAT, BD6_SITUAC, "
cSQL += "BD6_CODPAD, BD6_CODPRO, BD6_DESPRO, "
cSQL += "BD6_VLRPAG, BD6_VLRTPF, BA1_DATBLO, BA1_DATINC, BA1_MATEMP, BA1_CODINT "
cSQL += "FROM "+RetSQLName("BD6")+ " BD6, "+RetSQLName("BA1")+ " BA1 "
cSQL += "WHERE BD6.D_E_L_E_T_ <> '*' AND "
cSQL += "BD6_FILIAL  = '"+xFilial("BD6")+"' AND "
cSQL += "BD6_DATPRO BETWEEN '"+DTOS(dDataDe)+"' AND '"+DTOS(dDataAte)+"' AND "
cSQL += "BD6_YFTITA BETWEEN '"+MV_PAR01+"' AND '"+MV_PAR02+"' AND "
cSQL += "SUBSTR(BD6_YERITA,1,1) = 'R' AND "
cSQL += "BA1_CODINT = BD6_OPEUSR AND "
cSQL += "BA1_CODEMP = BD6_CODEMP AND "
cSQL += "BA1_MATRIC = BD6_MATRIC AND "
cSQL += "BA1_TIPREG = BD6_TIPREG "
If val(MV_PAR07) > 0
	If val(MV_PAR06) == val(MV_PAR07)
		cSQL += "AND (SUBSTR(BD6_YERITA,2,2) = ( '"+MV_PAR06+"' ) OR "
		cSQL += "SUBSTR(BD6_YERITA,4,2) = ( '"+MV_PAR06+"' ) OR "
		cSQL += "SUBSTR(BD6_YERITA,6,2) = ( '"+MV_PAR06+"' ) OR "
		cSQL += "SUBSTR(BD6_YERITA,8,2) = ( '"+MV_PAR06+"' ) OR "
		cSQL += "SUBSTR(BD6_YERITA,10,2) = ( '"+MV_PAR06+"' ) ) "
	Else
		cSQL += "AND ( SUBSTR(BD6_YERITA,2,2) BETWEEN '"+MV_PAR06+"' AND '"+MV_PAR07+"' OR "
		cSQL += " SUBSTR(BD6_YERITA,4,2) BETWEEN '"+MV_PAR06+"' AND '"+MV_PAR07+"' OR "
		cSQL += " SUBSTR(BD6_YERITA,6,2) BETWEEN '"+MV_PAR06+"' AND '"+MV_PAR07+"' OR "
		cSQL += " SUBSTR(BD6_YERITA,8,2) BETWEEN '"+MV_PAR06+"' AND '"+MV_PAR07+"' OR "
		cSQL += " SUBSTR(BD6_YERITA,10,2) BETWEEN '"+MV_PAR06+"' AND '"+MV_PAR07+"' ) "
	EndIf
EndIf
cSQL += "ORDER BY BD6_YFTITA, BD6_CODEMP, BD6_ANOPAG, BD6_MESPAG, BD6_CODLDP, BD6_CODPEG, BD6_NUMERO, BD6_SEQUEN "

memowrit("C:\CABR008.SQL",cSQL)

PLSQuery(cSQL,"cArqTrab")
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Trata se nao existir registros...                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea("cArqTrab")
cArqTrab->(DbGoTop())

SetRegua(RecCount())

cArqTrab->(DbGoTop())

nTotCo := 0
nTotPag := 0
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta regua                                                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cArqTrab->(DBEval( { | | nTotal++ }))
cArqTrab-> ( DbGotop())
ProcRegua(nTotal)

If MV_PAR08 = 2 .and. !U_Cria_TXT(cNomeArq)
	Return
EndiF

While !cArqTrab->(Eof())
	
	Npercent := (nProc/nTotal)*100
	IncProc("Processando: " + Transform(Npercent,"@E 9,999.9") + "  % do Total de: "+ Transform(nTotal,"@E 9999999"))
	ProcessMessage()
	
	nProc++
	
	If MV_PAR08 = 2

		cNumFun := Replicate("0",11-Len(Alltrim(cArqTrab->BA1_MATEMP)))+Alltrim(cArqTrab->BA1_MATEMP)
		If Substr(Alltrim(cArqTrab->BA1_MATEMP),1,1) = "_"
			cNumFun := Substr(Alltrim(cArqTrab->BA1_MATEMP),2,11)
		ElseIf Substr(Alltrim(cArqTrab->BA1_MATEMP),1,2) = "__"
			cNumFun := Substr(Alltrim(cArqTrab->BA1_MATEMP),3,11)
		ElseIf Substr(Alltrim(cArqTrab->BA1_MATEMP),1,3) = "___"
			cNumFun := Substr(Alltrim(cArqTrab->BA1_MATEMP),4,11)
		Endif

		cFamAnt := cArqTrab->(BD6_OPEUSR+BD6_CODEMP+BD6_MATRIC)
		cPadAnt	:= cArqTrab->BD6_CODPAD
		cProAnt	:= cArqTrab->BD6_CODPRO
		cFamilia := cArqTrab->(BD6_OPEUSR+BD6_CODEMP+BD6_MATRIC+BD6_TIPREG+BD6_DIGITO)+"-"+cArqTrab->BD6_NOMUSR
		
		If cArqTrab->BD6_CODLDP != '0012'
			cSQLTmp := " SELECT SUM(BD7_VLRPAG) AS TOTPAG "
			cSQLTmp += " FROM BD7010 BD7 "
			cSQLTmp += " WHERE BD7_FILIAL = '"+xFilial("BD7")+"' "
			cSQLTmp += " AND BD7_CODOPE = '"+BD6->BD6_CODOPE+"' "
			cSQLTmp += " AND BD7_CODLDP = '"+BD6->BD6_CODLDP+"' "
			cSQLTmp += " AND BD7_CODPEG = '"+BD6->BD6_CODPEG+"' "
			cSQLTmp += " AND BD7_NUMERO = '"+BD6->BD6_NUMERO+"' "
			cSQLTmp += " AND BD7_ORIMOV = '"+BD6->BD6_ORIMOV+"' "
			cSQLTmp += " AND BD7_SEQUEN = '"+BD6->BD6_SEQUEN+"' "
			cSQLTmp += " AND BD7_CODPRO = '"+BD6->BD6_CODPRO+"' "
			
			//Inserido por Luzio para que considere apenas as composicoes que foram realmente pagas
			If Empty(Alltrim(cArqTrab->BD6_YFTITA))
				cSQLTmp += " AND BD7_VLRPAG > 0 "
				If !Empty(Alltrim(cArqTrab->BD6_NUMLOT)) // Verifica se a guia ja foi paga
					cSQLTmp += " AND BD7_BLOPAG <> '1' "
					cSQLTmp += " AND BD7_NUMLOT <> '     ' "
				Else                               // Paga as guias do OPME
					cSQLTmp += " AND BD7_BLOPAG = '1' "
					cSQLTmp += " AND BD7_NUMLOT = '     ' "
				EndIf
			EndIf
			cSQLTmp += " AND D_E_L_E_T_ = ' ' "
			
			PLSQUERY(cSQLTmp,"TRBBD7")
			nVlrTotBD7 := TRBBD7->TOTPAG
			TRBBD7->(DbCloseArea())
		Else
			nVlrTotBD7 := cArqTrab->BD6_VLRPAG
		EndIf
		
		cNomRDABD6 := cArqTrab->BD6_NOMRDA
		If Empty(cNomRDABD6)
			cNomRDABD6 := Posicione("BAU",1,xFilial("BAU")+cArqTrab->BD6_CODRDA,"BAU_NOME")
		Endif
		
		BA1->(DbSetOrder(1))
		If BA1->(MsSeek(xFilial("BA1")+cArqTrab->(BD6_OPEUSR+BD6_CODEMP+BD6_MATRIC+BD6_TIPREG+BD6_DIGITO)))
			cNomUsr	:= Substr(Alltrim(BA1->BA1_NOMUSR),1,30)+Space(30-Len(Substr(Alltrim(BA1->BA1_NOMUSR),1,30)))
		EndIf      
		If cArqTrab->BD6_TIPREG == "00"
			cMatTit := Substr(BA1->BA1_CODINT,2,3)+BA1->(BA1_CODEMP+BA1_MATRIC+BA1_TIPREG)
		Else	
			BA1->(DbSetOrder(2))
			If BA1->(MsSeek(xFilial("BA1")+cFamAnt+"00"))
				cMatTit := Substr(cArqTrab->BA1_CODINT,2,3)+cArqTrab->(BD6_CODEMP+BD6_MATRIC+BD6_TIPREG)
			Endif
		EndIf	
 		cCPFUsr := Iif(Empty(BA1->BA1_CPFUSR),BA1->BA1_CPFPRE,BA1->BA1_CPFUSR)
		
		cLin := Space(1)+cEOL
		
		cCpo :=	"10" //D01
		cCpo += cNumFun   //cArqTrab->BKE_YMTEMI //D02 e D03
		cCpo += Iif(GetNewPar("MV_YCONITA","000000000001")==cConEmp,"01115","01123") //D04
		cCpo += Iif(GetNewPar("MV_YCONITA","000000000001")==cConEmp,"04697","04705") //D05
		cCpo += cCPFUsr //D06
		cCpo += cNomUsr //D07
		cCpo += cArqTrab->BD6_MATRIC+Space(4) //D08
		cCpo += cMatTit //D09
		cCpo += cArqTrab->BD6_TIPREG+Space(2) //D10
		cCpo += Iif(Empty(cArqTrab->BD6_YFTITA),"01","03") //D11   // 01-Despesas Medicas, 03-Estorno Despesas Medicas
		cCpo += cArqTrab->(BD6_ANOPAG+BD6_MESPAG) //D12
		cCpo += cDatPro //D13
		If cArqTrab->BD6_CODLDP == '0012' .and. cArqTrab->BD6_CODPRO != '83000089'
			cCpo += Alltrim(cArqTrab->BD6_NOMSOL)+Space(50-Len(AllTrim(cArqTrab->BD6_NOMSOL))) //D14
		Else
			cCpo += Alltrim(cNomRDABD6)+Space(50-Len(Alltrim(cNomRDABD6))) //D14
		EndIf
		cCpo += Alltrim(cArqTrab->BD6_DESPRO)+Space(90-Len(Alltrim(cArqTrab->BD6_DESPRO))) //D15
		cCpo += Iif(Empty(alltrim(cArqTrab->BD6_YFTITA)),"D","C") //D16
		cCpo += StrZero(nVlrTotBD7*100,15) //D17
		cCpo += cIndFM //D18
		cCpo += StrZero(nVlrPro*100,15) //D19
		cCpo += cArqTrab->(BD6_CODLDP+BD6_CODPEG+BD6_NUMERO+BD6_ORIMOV+BD6_SEQUEN)+Space(6) //D20
		cCpo += Space(20) //D21
		cCpo += "I" //D22
		cCpo +=	Alltrim(cClasProc)+Space(35-len(Alltrim(cClasProc))) //D23
		cCpo += Space(110) //D24
		cCpo += Space(1)//D24
		cCpo += Space(10)//D25
		cCpo += StrZero(nCont,10) //D26
		
		nCont++
		
		If !(U_GrLinha_TXT(cCpo,cLin))
			MsgAlert("ATENÇÃO! NÃO FOI POSSÍVEL GRAVAR CORRETAMENTE A LINHA ATUAL! OPERAÇÃO ABORTADA!")
			Return
		Endif
		
	Else
		//--------------------------------------------------------------------------------------------------------------------------------------------------------------------
		//Ope. Local PEG      Numero   Seq. Lote   Codigo   Descricao
		//      Tipo Codigo Descricao
		//--------------------------------------------------------------------------------------------------------------------------------------------------------------------
		//0001  0001 00000001 00000001 001  123456 80280340 HOMOCISTEINA, DOSAGEM NO SANGUE
		//      X    XX     XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
		//0....+....1....+....2....+....3....+....4....+....5....+....6....+....7....+....8....+....9....+....0....+....1....+....2....+....3....+....4....+....5....+....6....
		If MV_PAR05 = 1
			If li > 58
				li := cabec(cTitulo,cabec1,cabec2,nomeprog,tamanho,nTipo)
				
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Imprime Matrícula e Nome Usuário                                         ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				//			li++
				//			@ li, 000 pSay "Ope. Local PEG      Numero   Seq. Lote   Codigo   Descricao                            Valor             Matricula   Nome"
				//			li++
				//			@ li, 000 PSAY Replicate("-",220)
			End
			//Ope. Local PEG      Numero   Seq. Lote   Codigo    Descricao                                            Valor  Matricula              Nome		                                  Inclusao    Bloqueio    RDA    Mat.Empresa  Dt.Proced.
			//0001  0001 00000001 00000001 001  123456 80280340  HOMOCISTEINA, DOSAGEM NO SANGUE             999.999.999,99  0001.0001.999999.00-1  1234567890123456789012345678901234567890  xx/xx/xxxx  xx/xx/xxxx  xxxxxx xxxxxxxxxxx  xx/xx/xxxx
			//  														        1234567890123456789012345678901234567890
			//0....+....1....+....2....+....3....+....4....+....5....+....6....+....7....+....8....+....9....+....0....+....1....+....2....+....3....+....4....+....5....+....6....+....7....+....8....+....9....+....0....+....1....+....2....+....
			//     X    XX     XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
			li++
			@ li, 000 PSay cArqTrab->BD6_CODOPE // Data do atendimento
			@ li, 006 PSay cArqTrab->BD6_CODLDP // Nome da Prestador de Serviço - RDA
			@ li, 011 PSay cArqTrab->BD6_CODPEG // Nome da Prestador de Serviço - RDA
			@ li, 020 PSay cArqTrab->BD6_NUMERO // Nome da Prestador de Serviço - RDA
			@ li, 029 PSay cArqTrab->BD6_SEQUEN // Nome da Prestador de Serviço - RDA
			@ li, 034 PSay cArqTrab->BD6_YFTITA // Nome da Prestador de Serviço - RDA
			@ li, 041 PSay Transform(cArqTrab->BD6_CODPRO,PesqPict("BD6","BD6_CODPRO")) //Codigo Procedimento
			@ li, 051 PSay cArqTrab->BD6_DESPRO // Nome da Prestador de Serviço - RDA
			@ li, 095 PSay cArqTrab->BD6_VLRPAG Picture PesqPict("BD6","BD6_VLRPAG")  //Qtde do Procedimento
			@ li, 110 PSay cArqTrab->BD6_OPEUSR+"."+cArqTrab->BD6_CODEMP+"."+cArqTrab->BD6_MATRIC+"."+cArqTrab->BD6_TIPREG+"-"+cArqTrab->BD6_DIGITO
			@ li, 135 PSay cArqTrab->BD6_NOMUSR
			@ li, 176 PSay cArqTrab->BA1_DATINC
			@ li, 188 PSay cArqTrab->BA1_DATBLO
			@ li, 200 PSay cArqTrab->BD6_CODRDA
			@ li, 207 PSay cArqTrab->BA1_MATEMP
			@ li, 220 PSay cArqTrab->BD6_DATPRO
			li++
			//		For i= 2 to 10 step 2
			//			cCodCri := substr(cArqTrab->BD6_YERITA,i,2)
			//			If cCodCri <> '00'
			//				nPos := Ascan(aCodCri, { |x| AllTrim(x[1]) == cCodCri } )
			//				If nPos > 0
			//					@ li, 005 PSay aCodCri[nPos,2]  // Tipo do erro
			//					@ li, 010 PSay aCodCri[nPos,1]  // Codigo do erro
			//					@ li, 018 PSay aCodCri[nPos,3]  // Descricao do erro
			//					li++
			//				EndIf
			//			EndIf
			//		Next
		EndIf
		
		nTotCo  += cArqTrab->BD6_VLRTPF
		nTotPag += cArqTrab->BD6_VLRPAG
		
		For i= 2 to 10 step 2
			cDescri := ''
			cTipo   := ''
			cCodCri := substr(cArqTrab->BD6_YERITA,i,2)
			If cCodCri <> '00'
				nPos := 0
				nPos := Ascan(aCodCri, { |x| AllTrim(x[1]) == cCodCri } )
				If nPos > 0
					cDescri := aCodCri[nPos,3]
					cTipo   := aCodCri[nPos,2]
					If MV_PAR05 = 1
						@ li, 005 PSay aCodCri[nPos,2]  // Tipo do erro
						@ li, 010 PSay aCodCri[nPos,1]  // Codigo do erro
						@ li, 018 PSay aCodCri[nPos,3]  // Descricao do erro
						li++
					EndIf
				EndIf
				nPos1 := 0
				nPos1 := Ascan(aTotCri, { |x| AllTrim(x[1]) == cCodCri } )
				If nPos1 > 0
					aTotCri[nPos1,4] += 1
					aTotCri[nPos1,5] += cArqTrab->BD6_VLRPAG
				Else
					aadd(aTotCri,{cCodCri, cTipo, cDescri, 1, cArqTrab->BD6_VLRPAG})
				EndIF
			EndIf
		Next
	EndIf
	cArqTrab->(DbSkip())
Enddo

If MV_PAR08 = 2
	U_Fecha_TXT()
Else
	If li > 58
		Li := cabec(cTitulo,cabec1,cabec2,nomeprog,tamanho,nTipo)
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Imprime Matrícula e Nome Usuário                                         ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		//	li++
		//	@ li, 000 pSay "Ope. Local PEG      Numero   Seq. Lote   Codigo   Descricao "
		//	li++
		//	@ li, 000 PSAY Replicate("-",220)
	End
	li++
	@ li, 000 PSAY Replicate("-",220)
	li++
	@ li, 005 PSay "Total Rejeicao -->"
	@ li, 025 PSay Transform(nTotPag,"@E 999,999,999.99")//Valor Total Pagamento
	li++
	For n = 1 to Len(aTotCri)
		If li > 58
			Li := cabec(cTitulo,cabec1,cabec2,nomeprog,tamanho,nTipo)
		End
		li++
		//0....+....1....+....2....+....3....+....4....+....5....+....6....+....7....+....8....+....9....+....0....+....1....+....2....+....3....+....4....+....5....+....6....
		//     X XX XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX XXXX9 999.999.999,99
		//             1234567890123456789012345678901234567890123456789012345678901234567890
		@ li, 005 PSay aTotCri[n,2]  // Tipo do erro
		@ li, 007 PSay aTotCri[n,1]  // Codigo do erro
		@ li, 010 PSay aTotCri[n,3]  // Descricao do erro
		@ li, 077 PSay Transform(aTotCri[n,4],"@E 99999") // Quantidade de registro rejeitado
		@ li, 083 PSay Transform(aTotCri[n,5],"@E 999,999,999.99")  // Valor Total de registros rejeitados
	Next
	If li != 80
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Imprime rodape do relatorio...                                     ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		roda(cbcont,cbtxt,tamanho)
	End
EndIf
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Recupera a Integridade dos dados                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea("cArqTrab")
cArqTrab->(dbCloseArea())
dbSelectArea("BD6")

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Libera impressao                                                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Set Device To Screen

If aReturn[5] = 1
	Set Printer To
	dbCommitAll()
	OurSpool(cRel)
Endif

MS_FLUSH()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Fim do Relat¢rio                                                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ CriaSX1  ³ Autor ³ Luzio Tavares         ³ Data ³ 25/06/08 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Atualiza perguntas                                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ CriaSX1()                                                  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function CriaSX1()
Local aRegs		:= {}

Aadd(aRegs,{cPerg,"01","Lote De          ","","","MV_CH1","C",06,0,0,"G","","Mv_Par01","","","","","","","","","","","","","","","","","","","","","","","","","",""})
Aadd(aRegs,{cPerg,"02","Lote Ate         ","","","MV_CH2","C",06,0,0,"G","","Mv_Par02","","","","","","","","","","","","","","","","","","","","","","","","","",""})
Aadd(aRegs,{cPerg,"03","Data De          ","","","MV_CH3","D",08,0,0,"G","","Mv_Par03","","","","","","","","","","","","","","","","","","","","","","","","","",""})
Aadd(aRegs,{cPerg,"04","Data Ate         ","","","MV_CH4","D",08,0,0,"G","","Mv_Par04","         ","","","","","         ","","","","","","","","","","","","","","","","","","","",""})
Aadd(aRegs,{cPerg,"05","Tipo Relatorio   ","","","MV_CH5","N",01,0,0,"C","","Mv_Par05","Analitico","","","","","Sintetico","","","","","","","","","","","","","","","","","","","",""})
Aadd(aRegs,{cPerg,"06","Cod. Erro De     ","","","MV_CH6","C",02,0,0,"G","","Mv_Par06","         ","","","","","         ","","","","","","","","","","","","","","","","","","","",""})
Aadd(aRegs,{cPerg,"07","Cod. Erro Ate    ","","","MV_CH7","C",02,0,0,"G","","Mv_Par07","         ","","","","","         ","","","","","","","","","","","","","","","","","","","",""})
Aadd(aRegs,{cPerg,"08","Gerar em Arquivo ","","","MV_CH8","N",01,0,0,"C","","Mv_Par08","Nao      ","","","","","Sim      ","","","","","","","","","","","","","","","","","","","",""})

PlsVldPerg( aRegs )

Return
