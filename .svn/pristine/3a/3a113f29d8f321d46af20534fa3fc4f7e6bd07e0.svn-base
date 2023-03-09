#INCLUDE "RPTDEF.CH"
#INCLUDE "FWPrintSetup.ch"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "TOPCONN.CH"
#INCLUDE "PLSMGER.CH"
#INCLUDE "TBICONN.CH"
#INCLUDE "SHELL.CH"
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡ao    ³ PLSR445   ³ Autor ³ TOTVS PLS		     ³ Data ³ 15.10.12 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡ao ³ Relatório de Custos  							   		   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ SigaPLS                                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³													           ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function PLSR445()
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local Cabec1, Cabec2, Cabec3, wnrel
//Local cTamanho   := "M"
//Local cDesc1     := "Impressao do Relatório de Custos"
//Local cDesc2     := "de acordo com a configuracao do usuario."
//Local cDesc3     := " "
Local aArea	     := GetArea()
Local lGerTXT    := .F.
//Local cFiltro    := ""
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Parametros do relatorio (SX1)...                                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local nLayout
Local aDados 	:={}
Local aAux		:={}
Local cSQL		:= ""
Local cProduto	:= ""
Local cTpEvento	:= ""
Local aEventos	:= {}
Local nPos 		:= 0
Local cPlano := ""

Private aReturn  := { "Zebrado", 1,"Administracao", 1, 1, 1, "", 1 }
Private aLinha	 := { }
Private nLastKey := 0
Private cTitulo	 := "RELATORIO DE CUSTOS PLS"
Private cPerg    := "PLRCUS"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Ajusta perguntas                                                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
CriaSX1() //cria pergunta...

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para Impressao do Cabecalho e Rodape    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Cabec1   := OemtoAnsi(cTitulo)
Cabec2   := " "
Cabec3   := " "
cString  := "BD7"
aOrd     := {}

wnRel := "PLSRCUST" // Nome Default do relatorio em Disco

Pergunte(cPerg,.T.)
cCompet  	:= mv_par01
cPlano   	:= mv_par02
nLayout   	:= mv_par03                          
cTipPre		:= mv_par04

cSQL := "SELECT BD7.BD7_CODPAD, BD7.BD7_CODPRO, BD7.BD7_CODPLA, BI3.BI3_DESCRI, BD7.BD7_DATPRO, BD7.BD7_DTPRO, " 			+ CRLF
cSql += "BD7.BD7_VLPRV, BD7.BD7_VLRAPR, BAU.BAU_TIPPRE, BD7.BD7_VLRGLO, BD7.BD7_VLRTPF, BD7.R_E_C_N_O_, BD7.BD7_VLRPAG "	+ CRLF
cSQL += "FROM " + RetSqlName("BD7") + " BD7, "+ RetSqlName("BI3") + " BI3, "						+ CRLF
cSQL += RetSqlName("BAU") + " BAU "																	+ CRLF
cSQL += "WHERE  BD7.BD7_FILIAL = '" + xFilial("BD7") +"' "											+ CRLF
cSQL += "   AND BI3.BI3_FILIAL = '"	+ xFilial("BI3") +"' "											+ CRLF
cSQL += "   AND BAU.BAU_FILIAL = '"	+ xFilial("BAU") +"' "											+ CRLF
cSQL += "	AND BD7.BD7_CODOPE = BI3.BI3_CODINT "													+ CRLF
cSQL += "	AND BD7.BD7_CODPLA = BI3.BI3_CODIGO "													+ CRLF
cSQL += "   AND BD7.BD7_CODRDA = BAU.BAU_CODIGO "													+ CRLF
cSQL += "	AND BD7.BD7_COMPCT = '" + cCompet + "' "									  			+ CRLF
If !Empty(cTipPre)
    cSQL += "AND BAU.BAU_TIPPRE IN ('" + AllTrim(cTipPre) + "') "									+ CRLF
EndIf
If !EMPTY(cPlano)
	cSQL += "AND BD7.BD7_CODPLA IN ('" + AllTrim(cPlano) + "') "									+ CRLF
Endif
cSQL += "	AND BD7.D_E_L_E_T_ = ' ' "																+ CRLF
cSQL += "   AND BI3.D_E_L_E_T_ = ' ' "																+ CRLF
cSQL += "   AND BAU.D_E_L_E_T_ = ' ' "																+ CRLF
cSQL += "ORDER BY BD7_CODPLA, BD7.BD7_CODPAD, BD7.BD7_CODPRO "										+ CRLF

cSql := ChangeQuery(cSql)
If Select("TrbBD7") > 0
	TrbBD7->( dbCloseArea() )
EndIf

dbUseArea(.T.,"TOPCONN",TCGENQRY(,,cSql),"TrbBD7",.F.,.T.)
If TrbBD7->(EoF())
	MsgInfo(' Não há dados para exibição. ')
	TrbBD7->( dbCloseArea() )
	Return
EndIf
cProduto := AllTrim(TrbBD7->BD7_CODPLA)
aAdd(aAux, TrbBD7->BD7_CODPLA + " - " + TrbBD7->BI3_DESCRI)
aEventos := fBuscaEven()

Do While ! TrbBD7->(Eof())
	BD7->(dbGoto(TrbBD7->R_E_C_N_O_))
	cTpEvento 	:= PlTpServ()
	nPos 		:= Ascan(aEventos,{ |x| x[1] == cTpEvento})
	If cProduto == AllTrim(TrbBD7->BD7_CODPLA)
		aEventos[nPos,3] += TrbBD7->BD7_VLRAPR
		aEventos[nPos,4] += TrbBD7->BD7_VLRGLO
		aEventos[nPos,5] += TrbBD7->BD7_VLRTPF
	Else
		fCarrEven(@aAux, aEventos)
		aAdd(aDados, aAux)
		
		aAux 		:= {}
		aEventos 	:= fBuscaEven()
		cProduto 	:= AllTrim(TrbBD7->BD7_CODPLA)
		
		aAdd(aAux, TrbBD7->BD7_CODPLA + " - " + TrbBD7->BI3_DESCRI)
		aEventos[nPos,3] += TrbBD7->BD7_VLRAPR
		aEventos[nPos,4] += TrbBD7->BD7_VLRGLO
		aEventos[nPos,5] += TrbBD7->BD7_VLRTPF
		
	EndIf
	TrbBD7->( dbSkip() )
EndDo
TrbBD7->(DbCloseArea())

fCarrEven(@aAux, aEventos)
aAdd(aDados, aAux)

fGeraRel(aDados, lGerTXT, nLayout)

RestArea(aArea)

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡ao    ³fBuscaEven ³ Autor ³ TOTVS PLS		     ³ Data ³ 15.10.12 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡ao ³ Carrega os eventos cadastrados na tabela SX5 e inicializa   ³±±
±±³			 ³ os valores				 								   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ SigaPLS                                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ 								               				   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function fBuscaEven()
Local aRet 	:= {}

SX5->(DbSetOrder(1))
SX5->(MsSeek(xFilial("SX5")+"YR"+"01"))
While !SX5->(Eof()) .and. SX5->X5_TABELA == "YR"
	aadd(aRet,{AllTrim(SX5->X5_CHAVE),AllTrim(SX5->X5_DESCRI),0,0,0})
	SX5->(DbSkip())
Enddo

Return aRet

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡ao    ³ fCarrEven ³ Autor ³ TOTVS PLS		     ³ Data ³ 15.10.12 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡ao ³ Reajusta e carrega os eventos e seus valores na ordem  	   ³±±
±±³			 ³ desejada para o relatório 								   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ SigaPLS                                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ aAux  - Array auxiliar referenciado			               ³±±
±±³          ³ aEventos - Define a data final da busca		               ³±±
±±³          ³ cPlano   - Define o plano da busca 						   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function fCarrEven(aAux, aEventos)
Local aRetAux	:= {}
Local nI 		:= 0

For nI := 1 To Len(aEventos)
	aAdd(aRetAux, { aEventos[nI,2],aEventos[nI,3],aEventos[nI,4],aEventos[nI,5] })
Next nI

aAdd(aAux, aRetAux[01] )
aAdd(aAux, aRetAux[02] )
aAdd(aAux, aRetAux[03] )
aAdd(aAux, aRetAux[04] )
aAdd(aAux, aRetAux[05] )
aAdd(aAux, aRetAux[13] )
aAdd(aAux, aRetAux[12] )
aAdd(aAux, aRetAux[06] )
aAdd(aAux, aRetAux[07] )
aAdd(aAux, aRetAux[08] )
aAdd(aAux, aRetAux[09] )
aAdd(aAux, aRetAux[10] )
aAdd(aAux, aRetAux[11] )

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡ao    ³ fGeraRel  ³ Autor ³ TOTVS PLS		     ³ Data ³ 24.09.12 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡ao ³ Estrutura Relatório de Custos  							   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ SigaPLS                                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ aDados - Array com as informações do relat´rio              ³±±
±±³          ³ lGerTXT - Define se imprime direto sem passar pela tela 	   ³±±
±±³          ³			 de configuracao/preview do relatorio 		       ³±±
±±³          ³ nLayout - Define o formato de papél para impressao:         ³±±
±±³          ³           1 - Formato Ofício II (216x330mm)                 ³±±
±±³          ³           2 - Formato A4 (210x297mm)                        ³±±
±±³          ³  		 3 - Formato Carta (216x279mm)     			       ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function fGeraRel(aDados, lGerTXT, nLayout )

Local nLinMax 		:= 0
Local nColMax 		:= 0
Local nLinIni		:= 0		// Linha Lateral (inicial) Esquerda
Local nColIni		:= 0		// Coluna Lateral (inicial) Esquerda
Local nColA4    	:= 0
Local cFileLogo		:= ""
Local nOldLinIni	:= 0
Local nX := 0, nI 	:= 0
//Local lPrinter 		:= .F.
Local oFont02n
Local oFont03n
Local oFont04
Local nValAnali		:= 0
Local nCustoFin		:= 0
Local aTotais		:= {}
Local aTotGeral		:= {}
Local cLogoGH 		:= ''

DEFAULT nLayout 	:= 2
DEFAULT lGerTXT 	:= .F.
DEFAULT aDados 		:= 	{ {	;
"PRODUTO A"							 ,;
{'Consultas medicas',				50000.00,     3000.00,    06000.00},;
{'Exames',							15000.00,     0250.00,    00250.00},;
{'Terapias', 						05000.00,     0600.00,    00000.00},;
{'Demais depesas assistenciais',	35000.00,     1530.00,    00300.00},;
{'Outros atend. ambulatoriais',		15200.00,     0200.00,    00000.00},;
{'Internacoes - HM',				60000.00,     6450.00,    00000.00},;
{'Internacoes - Exames',			03000.00,     0000.00,    00000.00},;
{'Internacoes - terapias',			16200.00,     0154.00,    00000.00},;
{'Internacoes - Materiais',			03520.00,     0030.00,    00000.00},;
{'Internacoes - Medicamentos',		01524.00,     0015.00,    00000.00},;
{'Internacoes - Outras despesas',	00600.00,     0000.00,    00000.00} ;
},{									  ;
"PRODUTO B"							 ,;
{'Consultas medicas',				111111.11,    1111.11,    11111.11},;
{'Exames',							222222.22,    2222.22,    22222.22},;
{'Terapias', 						333333.33,    3333.33,    33333.33},;
{'Demais depesas assistenciais',	444444.44,    4444.44,    44444.44},;
{'Outros atend. ambulatoriais',		555555.55,    5555.55,    55555.55},;
{'Internacoes - HM',				666666.66,    6666.66,    66666.66},;
{'Internacoes - Exames',			777777.77,    7777.77,    77777.77},;
{'Internacoes - terapias',			888888.88,    8888.88,    88888.88},;
{'Internacoes - Materiais',			999999.99,    9999.99,    99999.99},;
{'Internacoes - Medicamentos',		100000.10,    1000.10,    10000.10},;
{'Internacoes - Outras despesas',	200000.20,    2000.20,    20000.20} ;
},{									  ;
"PRODUTO C"							 ,;
{'Consultas medicas',				111111.11,    1111.11,    11111.11},;
{'Exames',							222222.22,    2222.22,    22222.22},;
{'Terapias', 						333333.33,    3333.33,    33333.33},;
{'Demais depesas assistenciais',	444444.44,    4444.44,    44444.44},;
{'Outros atend. ambulatoriais',		555555.55,    5555.55,    55555.55},;
{'Internacoes - HM',				666666.66,    6666.66,    66666.66},;
{'Internacoes - Exames',			777777.77,    7777.77,    77777.77},;
{'Internacoes - terapias',			888888.88,    8888.88,    88888.88},;
{'Internacoes - Materiais',			999999.99,    9999.99,    99999.99},;
{'Internacoes - Medicamentos',		100000.10,    1000.10,    10000.10},;
{'Internacoes - Outras despesas',	200000.20,    2000.20,    20000.20} ;
},{									  ;
"PRODUTO D"							 ,;
{'Consultas medicas',				111111.11,    1111.11,    11111.11},;
{'Exames',							222222.22,    2222.22,    22222.22},;
{'Terapias', 						333333.33,    3333.33,    33333.33},;
{'Demais depesas assistenciais',	444444.44,    4444.44,    44444.44},;
{'Outros atend. ambulatoriais',		555555.55,    5555.55,    55555.55},;
{'Internacoes - HM',				666666.66,    6666.66,    66666.66},;
{'Internacoes - Exames',			777777.77,    7777.77,    77777.77},;
{'Internacoes - terapias',			888888.88,    8888.88,    88888.88},;
{'Internacoes - Materiais',			999999.99,    9999.99,    99999.99},;
{'Internacoes - Medicamentos',		100000.10,    1000.10,    10000.10},;
{'Internacoes - Outras despesas',	200000.20,    2000.20,    20000.20} ;
},{									  ;
"PRODUTO E"							 ,;
{'Consultas medicas',				111111.11,    1111.11,    11111.11},;
{'Exames',							222222.22,    2222.22,    22222.22},;
{'Terapias', 						333333.33,    3333.33,    33333.33},;
{'Demais depesas assistenciais',	444444.44,    4444.44,    44444.44},;
{'Outros atend. ambulatoriais',		555555.55,    5555.55,    55555.55},;
{'Internacoes - HM',				666666.66,    6666.66,    66666.66},;
{'Internacoes - Exames',			777777.77,    7777.77,    77777.77},;
{'Internacoes - terapias',			888888.88,    8888.88,    88888.88},;
{'Internacoes - Materiais',			999999.99,    9999.99,    99999.99},;
{'Internacoes - Medicamentos',		100000.10,    1000.10,    10000.10},;
{'Internacoes - Outras despesas',	200000.20,    2000.20,    20000.20} ;
},{				 					  ;
"PRODUTO F"							 ,;
{'Consultas medicas',				50000.00,     3000.00,    06000.00},;
{'Exames',							15000.00,     0250.00,    00250.00},;
{'Terapias', 						05000.00,     0600.00,    00000.00},;
{'Demais depesas assistenciais',	35000.00,     1530.00,    00300.00},;
{'Outros atend. ambulatoriais',		15200.00,     0200.00,    00000.00},;
{'Internacoes - HM',				60000.00,     6450.00,    00000.00},;
{'Internacoes - Exames',			03000.00,     0000.00,    00000.00},;
{'Internacoes - terapias',			16200.00,     0154.00,    00000.00},;
{'Internacoes - Materiais',			03520.00,     0030.00,    00000.00},;
{'Internacoes - Medicamentos',		01524.00,     0015.00,    00000.00},;
{'Internacoes - Outras despesas',	00600.00,     0000.00,    00000.00} } }


If nLayout == 1 // Oficio 2
	nLinMax	:=  1764
	nColMax	:=  2400
Elseif nLayout == 2 // PApél A4
	nLinMax	:=  3420
	nColMax	:=  2365
Else //Carta
	nLinMax	:=  1545
	nColMax	:=  2400
Endif

If nLayout == 1 // Oficio 2
	oFont02n	:= TFont():New("Arial", 09, 09, , .T., , , , .T., .F.) // Negrito
	oFont03n	:= TFont():New("Arial", 14, 14, , .T., , , , .T., .F.) // Negrito
	oFont04		:= TFont():New("Arial", 09, 09, , .F., , , , .T., .F.) // Normal
Else  // Papél A4 ou Carta
	oFont02n	:= TFont():New("Arial", 08, 08, , .T., , , , .T., .F.) // Negrito
	oFont03n	:= TFont():New("Arial", 13, 13, , .T., , , , .T., .F.) // Negrito
	oFont04		:= TFont():New("Arial", 08, 08, , .F., , , , .T., .F.) // Normal
Endif

oPrint	:= TmsPrinter():New("RELCUSTOSPLS.REL") 
//oPrint	:= FwMsPrinter():New("RELCUSTOSPLS.REL", IMP_PDF, .T., , .F., .F., , , , .T., , .T., 1 )

If nLayout ==2
	oPrint:SetPaperSize(9)// Papél A4
Elseif nLayout ==3
	oPrint:SetPaperSize(1)// Papél Carta
Else
	oPrint:SetPaperSize(8) //Papel Oficio2 216 x 330mm / 8 1/2 x 13in
Endif

oPrint:SetLandscape()		// Modo paisagem

// Verifica se existe alguma impressora configurada para Impressao Grafica
//lPrinter := oPrint:IsPrinterActive()

//If ! lPrinter
//	oPrint:Setup()
//EndIf

aAdd(aTotGeral,{0,0,0,0,0})

For nX := 1 To Len(aDados)
	
	If Len(aDados[nX]) == 0
		Loop
	EndIf
	
	If nX == 1 .OR. Mod(nX,6) == 0
		If nX <> 1
			oPrint:EndPage()	// Finaliza a pagina caso nao for o inicio da impressao.
		EndIf
		nLinIni := 0
		nColIni := 0
		nColA4  := 0
		
		oPrint:StartPage()		// Inicia uma nova pagina
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Box Principal                                                 ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		oPrint:Box(nLinIni + 0000, nColIni + 0000, nLinIni + nLinMax, nColIni + nColMax)
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Carrega e Imprime Logotipo da Empresa                         ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		fLogoEmp(@cFileLogo,, cLogoGH)
		
		If File(cFilelogo)
			oPrint:SayBitmap(nLinIni + 0050, nColIni + 0020, cFileLogo, 400, 090) 		// Tem que estar abaixo do RootPath
		EndIf
		
		If nLayout == 2 // Papél A4
			nColA4    := -0335
		Elseif nLayout == 3// Carta
			nColA4    := -0530
		Endif
		oPrint:Say(nLinIni + 0100, nColIni + 1352 + IIF(nLayout == 2 .Or. nLayout == 3,nColA4+140,0), "RELATORIO DE CUSTOS PLS", oFont03n,,,, 2)
	EndIf
	
	aAdd(aTotais,{0,0,0,0,0})
	
	nLinIni += 90
	oPrint:Say(nLinIni + 0140, nColIni + 0355 + nColA4, aDados[nX,01] , oFont02n) // A primeira casa do Array representa a Descrição do Produto Saude.
	
	nLinIni += 50
	oPrint:Say(nLinIni + 0140, nColIni + 0355 + nColA4, "EVENTOS"			 , oFont02n)
	oPrint:Say(nLinIni + 0140, nColIni + 0765 + nColA4, "VALOR APRESENTADO" , oFont02n)
	oPrint:Say(nLinIni + 0140, nColIni + 1325 + nColA4, "GLOSA"				 , oFont02n)
	oPrint:Say(nLinIni + 0140, nColIni + 1585 + nColA4, "VALOR ANALISADO"	 , oFont02n)
	oPrint:Say(nLinIni + 0140, nColIni + 1995 + nColA4, "COPARTICIPACAO"	 , oFont02n)
	oPrint:Say(nLinIni + 0140, nColIni + 2455 + nColA4, "CUSTO FINAL"		 , oFont02n)
	
	nLinIni += 10
	oPrint:Line (nLinIni + 0170, nColIni + 0355 + nColA4, nLinIni + 0170, nColIni + 2645 + nColA4)
	
	nLinIni += 10
	For nI := 2 To Len(aDados[nX]) // A primeira casa do Array representa a Descrição do Produto Saude.
		nLinIni += 30
		nOldLinIni := nLinIni
		
		oPrint:Say(nLinIni + 0140, nColIni + 0355 + nColA4, aDados[nX, nI, 01], oFont04)// A primeira casa deste nivel representa a Descrição do Evento.
		oPrint:Say(nLinIni + 0140, nColIni + 1080 + nColA4, IIf(Empty(aDados[nX, nI, 02]	), "0,00", Transform(aDados[nX, nI, 02], "@E 99,999,999.99")), oFont04,,,,1)
		oPrint:Say(nLinIni + 0140, nColIni + 1445 + nColA4, IIf(Empty(aDados[nX, nI, 03]	), "0,00", Transform(aDados[nX, nI, 03], "@E 99,999,999.99")), oFont04,,,,1)
		nValAnali := aDados[nX, nI, 02] - aDados[nX, nI, 03]
		oPrint:Say(nLinIni + 0140, nColIni + 1845 + nColA4, IIf(Empty(nValAnali			), "0,00", Transform(nValAnali			, "@E 99,999,999.99")), oFont04,,,,1)
		oPrint:Say(nLinIni + 0140, nColIni + 2245 + nColA4, IIf(Empty(aDados[nX, nI, 04]	), "0,00", Transform(aDados[nX, nI, 04], "@E 99,999,999.99")), oFont04,,,,1)
		nCustoFin := nValAnali - aDados[nX, nI, 04]
		oPrint:Say(nLinIni + 0140, nColIni + 2645 + nColA4, IIf(Empty(nCustoFin			), "0,00", Transform(nCustoFin			, "@E 99,999,999.99")), oFont04,,,,1)
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Acumula Sub-Totais							                     ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		aTotais[nX,01] += IIf(Empty(aDados[nX, nI, 02])	, 0, aDados[nX, nI, 02]	)
		aTotais[nX,02] += IIf(Empty(aDados[nX, nI, 03])	, 0, aDados[nX, nI, 03]	)
		aTotais[nX,03] += IIf(Empty(nValAnali)				, 0, nValAnali			)
		aTotais[nX,04] += IIf(Empty(aDados[nX, nI, 04])	, 0, aDados[nX, nI, 04]	)
		aTotais[nX,05] += IIf(Empty(nCustoFin)				, 0, nCustoFin			)
		
		nLinIni := nOldLinIni
		
	Next nI
	nLinIni += 40
	oPrint:Line (nLinIni + 0140, nColIni + 0355 + nColA4, nLinIni + 0140, nColIni + 2645 + nColA4)
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Imprime Sub-Totais						                     ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	nLinIni += 15
	oPrint:Say(nLinIni + 0140, nColIni + 0355 + nColA4, "SUB-TOTAL", oFont02n)
	oPrint:Say(nLinIni + 0140, nColIni + 1080 + nColA4, Transform(aTotais[nX,01], "@E 99,999,999.99"), oFont04,,,,1)
	oPrint:Say(nLinIni + 0140, nColIni + 1445 + nColA4, Transform(aTotais[nX,02], "@E 99,999,999.99"), oFont04,,,,1)
	oPrint:Say(nLinIni + 0140, nColIni + 1845 + nColA4, Transform(aTotais[nX,03], "@E 99,999,999.99"), oFont04,,,,1)
	oPrint:Say(nLinIni + 0140, nColIni + 2245 + nColA4, Transform(aTotais[nX,04], "@E 99,999,999.99"), oFont04,,,,1)
	oPrint:Say(nLinIni + 0140, nColIni + 2645 + nColA4, Transform(aTotais[nX,05], "@E 99,999,999.99"), oFont04,,,,1)
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Acumula Total Geral							                 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	aTotGeral[01,01] += aTotais[nX,01]
	aTotGeral[01,02] += aTotais[nX,02]
	aTotGeral[01,03] += aTotais[nX,03]
	aTotGeral[01,04] += aTotais[nX,04]
	aTotGeral[01,05] += aTotais[nX,05]
	
	nLinIni += 10
Next nX

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Imprime Total Geral						                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
nLinIni += 50
oPrint:Say(nLinIni + 0140, nColIni + 0355 + nColA4, "TOTAL GERAL", oFont02n)
oPrint:Say(nLinIni + 0140, nColIni + 1080 + nColA4, Transform(aTotGeral[01,01], "@E 99,999,999.99"), oFont04,,,,1)
oPrint:Say(nLinIni + 0140, nColIni + 1445 + nColA4, Transform(aTotGeral[01,02], "@E 99,999,999.99"), oFont04,,,,1)
oPrint:Say(nLinIni + 0140, nColIni + 1845 + nColA4, Transform(aTotGeral[01,03], "@E 99,999,999.99"), oFont04,,,,1)
oPrint:Say(nLinIni + 0140, nColIni + 2245 + nColA4, Transform(aTotGeral[01,04], "@E 99,999,999.99"), oFont04,,,,1)
oPrint:Say(nLinIni + 0140, nColIni + 2645 + nColA4, Transform(aTotGeral[01,05], "@E 99,999,999.99"), oFont04,,,,1)


oPrint:Preview()	// Visualiza impressao grafica antes de imprimir
oPrint:Print()
oPrint:SetViewPDF(.T.)
/*
If lGerTXT
	oPrint:Print()		// Imprime Relatorio
Else
*/
//EndIf
//MsgInfo(' Final do Relatório ')

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa   ³ CriaSX1   ³ Autor ³ TOTVS PLS		     ³ Data ³ 15.10.12 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao  ³ Atualiza SX1                                               ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function CriaSX1()

LOCAL aRegs	 :=	{}

aadd(aRegs,{cPerg,"01","Competência?"  				,"","","mv_ch1","C",06,0,0,"G","","mv_par01",""       		,"","","","",""       	,"","","","",""         	,"","","","","","","","","","","","","",""			,""})
aadd(aRegs,{cPerg,"02","Produto Saude"				,"","","mv_ch2","C",10,0,0,"G","","mv_par02",""         	,"","","","",""        	,"","","","",""           	,"","","","","","","","","","","","","","B2DPLS"	,""})
aadd(aRegs,{cPerg,"03","Selecionar Layout Papel:" 	,"","","mv_ch3","N",01,0,0,"C","","mv_par03","Ofício 2"	,"","","","","Papel A4"	,"","","","","Papel Carta"	,"","","","","","","","","","","","","",""				,""})
aadd(aRegs,{cPerg,"04","Classe da RDA?"      		,"","","mv_ch4","C",99,0,0,"G","","mv_par04",""				,"","","","",""			,"","","","",""				,"","","","","","","","","","","","","","BY0PL1"	,""})

PlsVldPerg( aRegs )

Return


