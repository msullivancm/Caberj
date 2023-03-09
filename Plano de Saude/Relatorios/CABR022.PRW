#include "rwmake.ch"
#include "TOPCONN.CH"
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABR022    ºAutor  ³Luzio Tavares     º Data  ³  25/06/08   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Extrato de Utilização                                       º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Plano de Saúde - PLS                                       º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function CABR022()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//Local wnrel
Private cDesc1 	:= "Guias nao Pagas"
Private cDesc2 	:= ""
Private cDesc3 	:= ""
Private cString 	:= "BD6"
Private nQtdLin     := 58
Private cAlias      := "BD6"
Private cRel        := "CABR022"
Private nLi         := nQtdLin+1
Private m_pag       := 1
Private lCompres    := .F.
Private lDicion     := .F.
Private lFiltro     := .F. //.T.
Private lCrystal    := .F.
Private aOrderns    := {"RDA","Grupo/Empresa"}
Private lAbortPrint := .F.
PRIVATE nColuna     := 1 
Private nLimite     := 132
Private tamanho 	:= "M"
Private cTitulo	:= "GUIAS NAO PAGAS NO PERIODO"
Private aReturn := { "Zebrado", 1,"Administracao", 1, 1, 1, "",1 }
Private cPerg   := "CABR22"
Private nomeprog:= "CABR022"
Private nLastKey:=0
Private cabec1  := "RDA    Nome                                 Grupo Empresa                                  Mes/Ano           Valor"
Private cabec2  := ""
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ7ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Atualiza SX1                                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
CriaSX1()

Pergunte(cPerg,.F.)

cRel := SetPrint(cString,cRel,cPerg,@cTitulo,cDesc1,cDesc2,cDesc3,.F.,aOrderns,,tamanho,,.F.)

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
RptStatus({|lEnd| CABR007Imp(@lEnd,cRel,cString)},cTitulo)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Fim da rotina                                                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³ Fun‡…o    ³CABR007Imp³ Autor ³ Luzio Tavares   ³ Data ³ 25/06/08       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Descri‡…o ³Impressao 											                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Sintaxe   ³CABR007Imp(lEnd,wnRel,cString)                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso       ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function CABR007Imp(lEnd,cRel,cString)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define variaveis...                                                      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
LOCAL nOrdSel := aReturn[8]
Local cbcont,cbtxt
Local cSQL
//Local cArqTrab := CriaTrab(nil,.F.)
Local cCodOpe := Mv_Par01
Local cCompetIni := Mv_Par02
Local cCompetFim := Mv_Par03
Local dDatProIni := DtoS(Mv_Par04)
Local dDatProFim := DtoS(Mv_Par05)
Local cCodRdaIni := Mv_Par06
Local cCodRdaFim := Mv_Par07
Local nTipLoc    := Mv_Par08
Local cCodLocIni := Mv_Par09
Local cCodLocFim := Mv_Par10
Local nFase      := Mv_par11
Local nSituac    := Mv_par12
Local nTipRel    := Mv_par13
Local cCodEmpIni := Mv_Par14
Local cCodEmpFim := Mv_Par15

Local nTotRDA, nTotEmp, nTotGer := 0

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para Impressao do Cabecalho e Rodape    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cbtxt    := SPACE(10)
cbcont   := 0
li       := 80
m_pag    := 1

nTipo := GetMv("MV_COMP")

dbSelectArea("BD6")

cSQL := " SELECT BD7_CODRDA, BD7_NOMRDA, BD7_OPEUSR, BD7_CODEMP, bd7_mespag, bd7_anopag, Sum(BD7_VLRPAG) AS TOTAL, BG9_DESCRI "
cSQL += " FROM "+RetSQLName("BD7")+" BD7, "+RetSQLName("BG9")+" BG9 "
cSQL += " WHERE BD7_FILIAL = '"+xFilial("BD7")+"' "
cSQL += " AND BD7_CODOPE = '0001' "
cSQL += " AND BG9_CODINT = BD7_OPEUSR "
cSQL += " AND BG9_CODIGO = BD7_CODEMP "
cSQL += " AND BD7_ANOPAG||BD7_MESPAG BETWEEN '" + substr(cCompetIni,3,4)+substr(cCompetIni,1,2) + "' AND '" + substr(cCompetFim,3,4)+substr(cCompetFim,1,2) + "' "
cSQL += " AND BD7_BLOPAG <> '1' "

If nTipLoc == 1
	cSQL += " AND BD7_CODLDP IN ( '0002', '0011' ) "
ElseIf !Empty(cCodLocFim) .and. SubStr(Upper(AllTrim(cCodLocFim)),1,1) != "Z"
	cSQL += " AND BD7_CODLDP BETWEEN '" + cCodLocIni + "' AND '" + cCodLocFim + "' "
EndIf

If nFase == 1 // Pronta
	cSQL += " AND BD7_FASE = '3' "
ElseIf nFase == 2 // faturada
	cSQL += "AND BD7_FASE = '4' "
	cSQL += "AND BD7_NUMLOT <> '  ' "
ElseIf nFase == 3 // Pronta/Falturada
	cSQL += "AND BD7_FASE IN ('3','4') "
ElseIf nFase == 4 // Digitacao
	cSQL += "AND BD7_FASE = '1' "
EndIf

If nSituac == 1         // Ativa
	cSQL += " AND BD7_SITUAC = '1' "
ElseIf nSituac == 2    // Bloqueada
	cSQL += "AND BD7_SITUAC = '3' "
Else	
	cSQL += "AND BD7_SITUAC IN ('1','3') "
EndIf

If !Empty(dDatProFim)
	cSQL += " AND BD7_DATPRO BETWEEN '"+ dDatProIni +"' AND '"+ dDatProFim +"' "
EndIf	
If !Empty(cCodEmpFim) .and. SubStr(Upper(AllTrim(cCodEmpFim)),1,1) != "Z"
	cSQL += " AND BD7_CODEMP BETWEEN '"+ cCodEmpIni +"' AND '"+ cCodEmpFim +"' "
EndIf	

cSQL += " AND BD7.D_E_L_E_T_ = ' ' "
cSQL += " AND BG9.D_E_L_E_T_ = ' ' "
cSQL += " GROUP BY BD7_CODRDA, BD7_NOMRDA, BD7_OPEUSR, BD7_CODEMP, BG9_DESCRI, BD7_ANOPAG, BD7_MESPAG "

Do Case
	Case nOrdSel == 1
		cSQL += " ORDER BY BD7_CODRDA, BD7_CODEMP, BD7_ANOPAG, BD7_MESPAG "
	Case nOrdSel == 2
		cSQL += " ORDER BY BD7_CODEMP, BD7_CODRDA, BD7_ANOPAG, BD7_MESPAG "
		cabec1 := " Grupo Empresa                                  RDA    Nome                                     Mes/Ano           Valor"
EndCase

memowrit("C:\CABR022.SQL",cSQL)

PLSQuery(cSQL,"cArqTrab")
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Trata se nao existir registros...                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea("cArqTrab")
cArqTrab->(DbGoTop())

SetRegua(RecCount())

cArqTrab->(DbGoTop())

nTotRDA := 0
nTotEmp := 0
nTotGer := 0
While !cArqTrab->(Eof())
//--------------------------------------------------------------------------------------------------------------------------------------------------------------------
// RDA    Nome                                     Grupo Empresa                                  Mes/Ano           Valor
//--------------------------------------------------------------------------------------------------------------------------------------------------------------------
// 123456 LAB BRONSTEIN                            0019 LAR DOS MENINOS                           04/2009  999,999,999.99  
//        1234567890123456789012345678901234567890  
//0....+....1....+....2....+....3....+....4....+....5....+....6....+....7....+....8....+....9....+....0....+....1....+....2....+....3....+....4....+....5....+....6....
// Grupo Empresa                                  RDA    Nome                                     Mes/Ano           Valor
//--------------------------------------------------------------------------------------------------------------------------------------------------------------------
// 0019 LAR DOS MENINOS                           123456 LAB BRONSTEIN                            04/2009  999,999,999.99  
//        1234567890123456789012345678901234567890  
//0....+....1....+....2....+....3....+....4....+....5....+....6....+....7....+....8....+....9....+....0....+....1....+....2....+....3....+....4....+....5....+....6....

	If nOrdSel == 1
	   cCodRDA := cArqTrab->BD7_CODRDA 
		If li > 58
			li := cabec(cTitulo,cabec1,cabec2,nomeprog,tamanho,nTipo)
			li++
		End
   	@ li, 001 PSay cArqTrab->BD7_CODRDA 
		@ li, 008 PSay cArqTrab->BD7_NOMRDA // Nome da Prestador de Serviço - RDA
		While ! cArqTrab->(Eof()) .and. cArqTrab->BD7_CODRDA == cCodRda
			If li > 58
				li := cabec(cTitulo,cabec1,cabec2,nomeprog,tamanho,nTipo)
				li++
			End
			@ li, 049 PSay cArqTrab->BD7_CODEMP
			@ li, 054 PSay SubStr(cArqTrab->BG9_DESCRI,1,40)
			@ li, 096 PSay cArqTrab->BD7_MESPAG + "/" + cArqTrab->BD7_ANOPAG
			@ li, 105 PSay Transform(cArqTrab->TOTAL,"@E 999,999,999.99")//Valor Pagamento
			li++
			nTotRDA  += cArqTrab->TOTAL
			cArqTrab->(DbSkip())
		EndDo
		If li > 58
			li := cabec(cTitulo,cabec1,cabec2,nomeprog,tamanho,nTipo)
			li++
		End
//			@ li, 000 PSAY Replicate("-",220)
//			li++
//			If li > 58
//				li := cabec(cTitulo,cabec1,cabec2,nomeprog,tamanho,nTipo)
//				li++
//			End
		@ li, 001 PSay "Total da RDA -->"
		@ li, 105 PSay Transform(nTotRDA ,"@E 999,999,999.99") //Valor Total da Guias Prontas
		li++
		li++
		nTotGer += nTotRDA
		nTotRDA := 0 
	Else
	   cCodEmp := cArqTrab->BD7_CODEMP 
		If li > 58
			li := cabec(cTitulo,cabec1,cabec2,nomeprog,tamanho,nTipo)
			li++
		End
   	@ li, 001 PSay cArqTrab->BD7_CODEMP
		@ li, 006 PSay SubStr(cArqTrab->BG9_DESCRI,1,40)
		While ! cArqTrab->(Eof()) .and. cArqTrab->BD7_CODEMP == cCodEmp
			If li > 58
				li := cabec(cTitulo,cabec1,cabec2,nomeprog,tamanho,nTipo)
				li++
			End
// Grupo Empresa                                  RDA    Nome                                     Mes/Ano           Valor
//--------------------------------------------------------------------------------------------------------------------------------------------------------------------
// 0019 LAR DOS MENINOS                           123456 LAB BRONSTEIN                            04/2009  999,999,999.99  
//      1234567890123456789012345678901234567890  
//0....+....1....+....2....+....3....+....4....+....5....+....6....+....7....+....8....+....9....+....0....+....1....+....2....+....3....+....4....+....5....+....6....

	   	@ li, 048 PSay cArqTrab->BD7_CODRDA 
			@ li, 055 PSay cArqTrab->BD7_NOMRDA // Nome da Prestador de Serviço - RDA
			@ li, 096 PSay cArqTrab->BD7_MESPAG + "/" + cArqTrab->BD7_ANOPAG
			@ li, 105 PSay Transform(cArqTrab->TOTAL,"@E 999,999,999.99")//Valor Pagamento
			li++
			nTotEmp  += cArqTrab->TOTAL
			cArqTrab->(DbSkip())
	   EndDo
		If li > 58
			li := cabec(cTitulo,cabec1,cabec2,nomeprog,tamanho,nTipo)
			li++
		End
//			@ li, 000 PSAY Replicate("-",220)
//			li++
//			If li > 58
//				li := cabec(cTitulo,cabec1,cabec2,nomeprog,tamanho,nTipo)
//				li++
//			End
		@ li, 000 PSay "Total do Grupo Empresa -->"
		@ li, 105 PSay Transform(nTotEmp ,"@E 999,999,999.99") //Valor Total da Guias Prontas
		li++
		li++
		nTotGer += nTotEmp
		nTotEmp := 0 
	EndIf
Enddo
//li++
@ li, 000 PSAY Replicate("-",220)
li++
@ li, 000 PSay "Total Geral -->"
@ li, 105 PSay Transform(nTotGer ,"@E 999,999,999.99")//Valor Total da Guias Prontas
If li != 80
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Imprime rodape do relatorio...                                     ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	roda(cbcont,cbtxt,tamanho)
End
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
±±³Funcao    ³ CriaSX1  ³ Autor ³ Luzio Tavares   ³ Data ³ 25/06/08 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Atualiza perguntas                                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ CriaSX1()                                                  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function CriaSX1()
LOCAL aRegs	 :=	{}

Aadd(aRegs,{cPerg,"01","Operadora           ","","","MV_CH1","C",04,0,0,"G","","mv_Par01","","","","","","","","","","","","","","","","","","","","","","","","","",""})
Aadd(aRegs,{cPerg,"02","Competencia de      ","","","MV_CH2","C",06,0,0,"G","","Mv_Par02","","","","","","","","","","","","","","","","","","","","","","","","","",""})
Aadd(aRegs,{cPerg,"03","Competencia Ate     ","","","MV_CH3","C",06,0,0,"G","","Mv_Par03","","","","","","","","","","","","","","","","","","","","","","","","","",""})
Aadd(aRegs,{cPerg,"04","Data de             ","","","MV_CH4","D",08,0,0,"G","","Mv_Par04","","","","","","","","","","","","","","","","","","","","","","","","","",""})
Aadd(aRegs,{cPerg,"05","Data Ate            ","","","MV_CH5","D",08,0,0,"G","","Mv_Par05","","","","","","","","","","","","","","","","","","","","","","","","","",""})
Aadd(aRegs,{cPerg,"06","RDA de              ","","","MV_CH6","C",06,0,0,"G","","Mv_Par06","","","","","","","","","","","","","","","","","","","","","","","","","",""})
Aadd(aRegs,{cPerg,"07","RDA Ate             ","","","MV_CH7","C",06,0,0,"G","","Mv_Par07","","","","","","","","","","","","","","","","","","","","","","","","","",""})
Aadd(aRegs,{cPerg,"08","Local Digitacao     ","","","MV_CH8","N",01,0,0,"C","","Mv_Par08","TISS","","","","","Todas","","","","","","","","","","","","","","","","","","","",""})
Aadd(aRegs,{cPerg,"09","Local Digitacao De  ","","","MV_CH9","C",04,0,0,"G","","Mv_Par09","","","","","","","","","","","","","","","","","","","","","","","","","",""})
Aadd(aRegs,{cPerg,"10","Local Digitacao Ate ","","","MV_CHA","C",04,0,0,"G","","Mv_Par10","","","","","","","","","","","","","","","","","","","","","","","","","",""})
Aadd(aRegs,{cPerg,"11","Fase                ","","","MV_CHB","N",01,0,0,"C","","Mv_Par11","Pronta","","","","","Faturada","","","","","Pronta/Faturada","","","","","Digitacao","","","","","Todas Fases","","","","",""})
Aadd(aRegs,{cPerg,"12","Situacao            ","","","MV_CHC","N",01,0,0,"C","","Mv_Par12","Ativa","","","","","Bloqueada","","","","","Todas","","","","","","","","","","","","","","",""})
Aadd(aRegs,{cPerg,"13","Tipo Relatorio      ","","","MV_CHD","N",01,0,0,"C","","Mv_Par13","Sintetico","","","","","Analitico","","","","","","","","","","","","","","","","","","","",""})
Aadd(aRegs,{cPerg,"14","Grupo Empresa de    ","","","MV_CHE","C",04,0,0,"G","","Mv_Par14","","","","","","","","","","","","","","","","","","","","","","","","","",""})
Aadd(aRegs,{cPerg,"15","Grupo Empresa Ate   ","","","MV_CHF","C",04,0,0,"G","","Mv_Par15","","","","","","","","","","","","","","","","","","","","","","","","","",""})

PlsVldPerg( aRegs )
Return