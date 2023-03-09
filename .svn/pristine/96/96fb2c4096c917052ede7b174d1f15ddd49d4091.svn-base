#include "rwmake.ch"
#include "TOPCONN.CH"
/*/
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ CABA008  ³ Autor ³ LUZIO TAVARES          ³ Data ³ 29/01/2009 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Gerar relatorio das guias duplicadas                          |±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ CABERJ                                                        ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

User Function CABA008()
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Inicializa variaveis                                                               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

cUsur := PlretOpe() // armazena na variavel o usuario do sistema

Private nCaracter   := 15
Private cString  := "BD6"
Private cDesc1   := "Este programa apresenta as guias em duplicidades no sistema."
Private cDesc2   := ""
Private cDesc3   := ""
Private limite   := 220    //132
Private Tamanho  := "G"    //"M"
Private aReturn := { "Zebrado",1,"Administracao",1,1,1,"",1 }
Private aLinha   := {}
Private nLastKey := 0
Private titulo   := "Guias em Duplicidades"
PRIVATE Cabec1     := "RDA"
PRIVATE Cabec2     := "Mes/Ano Local  PEG       Numero    Matricula           Usuario                                              Procedimento      Descricao                                           Data       Vlr. Co-Part.       Vlr. Pago Pago? Cobrado?"
//                     10/2008  0011  00000042  00000087  0001.0001.006443-00 therezinha candida bernardes                         28010060          acido polico(rie)                                   30/07/08  000.000.000,00  000.000.000,00  Nao  Nao
//                     0....+....1....+....2....+....3....+....4....+....5....+....6....+....7....+....8....+....9....+....0....+....1....+....2....+....3....+....4....+....5....+....6....+....7....+....8....+....9....+....0....+....1....+....2
Private cCancel  := "***** CANCELADO PELO OPERADOR *****"
Private m_pag    := 1                                    // numero da pagina
Private nomeprog := "("+Alltrim(Cusur)+")"
Private wnrel    := "CABA008"
Private cPerg    := "GUIDUP"
Private pag      := 1
Private li       := 80
Private lDicion     := .F.
Private lCompres    := .F.
Private lCrystal    := .F.
Private lFiltro     := .T.
Private aOrdens     := ""

PRIVATE nFase

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas selecionadas                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
AjustaSX1(cPerg)
Pergunte(cPerg,.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Chamada padrao de relatorios                                                       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
wnrel := SetPrint(cString,wnrel,cPerg,@titulo,cDesc1,cDesc2,cDesc3,lDicion,aOrdens,lCompres,Tamanho,{},lFiltro,lCrystal)

If  nLastKey == 27
	Set Filter To
	Return
End

SetDefault(aReturn,cString)

If  nLastKey == 27
	Set Filter To
	Return
End

nTipo := If(aReturn[4]==1,15,18)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Processa relatorio                                                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//RptStatus({|| CABR011IMP() })
Processa({|| CABA008IMP() }, "Processando...", "", .T.)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Libera spool                                                                       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Set Filter To
If  aReturn[5] == 1
	Set Printer To
	Commit
	ourspool(wnrel)    // Chamada do Spool de Impressao
Endif
MS_FLUSH()             // Libera fila de relatorios em spool
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Fim do programa                                                                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Return

/*/
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ CABA008IMP                                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Processa relatorio                                            |±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function CABA008IMP()
Local nTotal:= 0 // recebe o n total de registros
Local nProc:=1 // incrementado por unidade de registro

Local cCompetIni := Mv_Par01
Local cCompetFim := Mv_Par02
Local dData1 := DtoS(Mv_Par03)
Local dData2 := DtoS(Mv_Par04)
Local cCodRdaIni := Mv_Par05
Local cCodRdaFim := Mv_Par06
Local cTipLoc := Mv_Par07
Local nFase     := mv_par08
Local	nVlrPagTot := 0
Local nVlrTot := 0

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta query                                                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cSQLTmp := " SELECT BD6.* "
cSQLTmp += " FROM " + RetSQLName("BD6") + " BD6, "
cSQLTmp += " ( "
cSQLTmp += " SELECT A.BD6_OPEUSR, A.BD6_CODEMP, "
cSQLTmp += " A.BD6_MATRIC, A.BD6_TIPREG, "
cSQLTmp += " A.BD6_DATPRO, A.BD6_CODRDA, A.BD6_CODPRO, A.BD6_NUMIMP "  // --,Max(r_e_c_n_o_) AS recno --, Count( DISTINCT BD6_CODLDP || BD6_CODPEG || BD6_NUMERO ) AS QTD "
cSQLTmp += " FROM " + RetSQLName("BD6") + " A "
cSQLTmp += " WHERE A.BD6_FILIAL = '" + xFilial("BD6") + "' "
cSQLTmp += " AND A.BD6_CODOPE = '0001' "
cSQLTmp += " AND A.BD6_ANOPAG || A.BD6_MESPAG BETWEEN '" + substr(cCompetIni,3,4)+substr(cCompetIni,1,2) + "' AND '" + substr(cCompetFim,3,4)+substr(cCompetFim,1,2) + "' "
cSQLTmp += " AND A.D_E_L_E_T_ = ' ' "

If cTipLoc == 1
	cSQLTmp += " AND A.BD6_CODLDP IN ( '0002', '0011' ) "
EndIf

If nFase == 1 // Pronta
	cSQLTmp += " AND A.BD6_FASE = '3' "
ElseIf nFase == 2 // faturada
	cSQLTmp += "AND A.BD6_FASE = '4' "
	cSQLTmp += "AND A.BD6_NUMLOT <> '  ' "
ElseIf nFase == 3 // Pronta/Falturada
	cSQLTmp += "AND A.BD6_FASE IN ('3','4') "
ElseIf nFase == 4 // Digitacao
	cSQLTmp += "AND A.BD6_FASE = '1' "
EndIf

cSQLTmp += " AND A.BD6_SITUAC = '1' "
cSQLTmp += " GROUP BY A.BD6_OPEUSR, A.BD6_CODEMP, A.BD6_MATRIC, A.BD6_TIPREG, A.BD6_DATPRO, A.BD6_CODRDA, A.BD6_CODPRO, A.BD6_NUMIMP "
cSQLTmp += " HAVING Count( DISTINCT A.BD6_CODLDP || A.BD6_CODPEG || A.BD6_NUMERO ) > 1 "
cSQLTmp += " ) SUB "
cSQLTmp += " WHERE BD6.BD6_FILIAL = '" + xFilial("BD6") + "' "
cSQLTmp += " AND BD6.BD6_CODOPE = '0001' "
cSQLTmp += " AND BD6.BD6_OPEUSR = SUB.BD6_OPEUSR "
cSQLTmp += " AND BD6.BD6_CODEMP = SUB.BD6_CODEMP "
cSQLTmp += " AND BD6.BD6_MATRIC = SUB.BD6_MATRIC "
cSQLTmp += " AND BD6.BD6_TIPREG = SUB.BD6_TIPREG "
cSQLTmp += " AND BD6.BD6_DATPRO = SUB.BD6_DATPRO "
cSQLTmp += " AND BD6.BD6_CODRDA = SUB.BD6_CODRDA "
cSQLTmp += " AND BD6.BD6_CODPRO = SUB.BD6_CODPRO "
cSQLTmp += " AND BD6.D_E_L_E_T_ = ' ' "
cSQLTmp += " ORDER by BD6.BD6_CODRDA, BD6.BD6_OPEUSR, BD6.BD6_CODEMP, BD6.BD6_MATRIC, BD6.BD6_TIPREG, BD6.BD6_DATPRO, BD6.BD6_CODPRO, BD6.BD6_CODLDP, BD6.BD6_CODPEG, BD6.BD6_NUMERO, BD6.BD6_NUMIMP "
//cSQLTmp += " ORDER by BD6.BD6_OPEUSR, BD6.BD6_CODEMP, BD6.BD6_MATRIC, BD6.BD6_TIPREG, BD6.BD6_DATPRO, BD6.BD6_CODRDA, BD6.BD6_CODPRO, BD6.BD6_CODLDP, BD6.BD6_CODPEG, BD6.BD6_NUMERO, BD6.BD6_NUMIMP "

MemoWrite("C:\CABA008.SQL", cSQLTmp)

PLSQuery(cSQLTmp,"CONS")
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta regua                                                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
CONS->(DBEval( { | | nTotal++ }))
CONS-> ( DbGotop())
ProcRegua(nTotal)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Imprime relatorio                                                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
While !CONS->(eof())
	cCodRda := CONS->BD6_CODRDA

//	cOpeUsr := CONS->BD6_OPEUSR
//	cCodEmp := CONS->BD6_CODEMP
//	cMatric := CONS->BD6_MATRIC
//	cTipreg := CONS->BD6_TIPREG
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Imprime cabecalho                                                               ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If  li >= 65
		li := cabec(titulo,cabec1,cabec2,nomeprog,tamanho,nCaracter)
		li++
//		@ li,000 pSay "0....+....1....+....2....+....3....+....4....+....5....+....6....+....7....+....8....+....9....+....0....+....1....+....2....+....3....+....4....+....5....+....6....+....7....+....8....+....9....+....0....+....1....+....2"
//		li++
	EndIf

	@ li,000 pSay CONS->BD6_CODRDA+"-"+CONS->BD6_NOMRDA
	
//	@ li,000 pSay alltrim(CONS->BD6_OPEUSR)+"."+alltrim(CONS->BD6_CODEMP)+"."+alltrim(CONS->BD6_MATRIC)+"-"+alltrim(CONS->BD6_TIPREG) //+"-"+BD6_DIGITO
//	@ li,pCol()+2 pSay CONS->BD6_NOMUSR
	li++
	li++
	
	While !CONS->(eof()) .and.;
	   cCodRda == CONS->BD6_CODRDA

//		cOpeUsr == CONS->BD6_OPEUSR .and.;
//		cCodEmp == CONS->BD6_CODEMP .and.;
//		cMatric == CONS->BD6_MATRIC .and.;
//		cTipReg == CONS->BD6_TIPREG
		
		cCodOpe := CONS->BD6_CODOPE
		cCodLdp := CONS->BD6_CODLDP
		cCodPeg := CONS->BD6_CODPEG
		cNumero := CONS->BD6_NUMERO
		cSequen := CONS->BD6_SEQUEN
		
		cOpeUsr := CONS->BD6_OPEUSR
		cCodEmp := CONS->BD6_CODEMP
		cMatric := CONS->BD6_MATRIC
		cTipreg := CONS->BD6_TIPREG
//		cCodRda := CONS->BD6_CODRDA
		cCodPro := CONS->BD6_CODPRO
		dDatPro := CONS->BD6_DATPRO
		cNumImp := CONS->BD6_NUMIMP
		
		nRecno := CONS->R_E_C_N_O_
		
		CONS->( DbSkip() )
		
		If cOpeUsr == CONS->BD6_OPEUSR .and.;
			cCodEmp == CONS->BD6_CODEMP .and.;
			cMatric == CONS->BD6_MATRIC .and.;
			cTipReg == CONS->BD6_TIPREG .and.;
			cCodRda == CONS->BD6_CODRDA .and.;
			cCodPro == CONS->BD6_CODPRO .and.;
			DtoS(dDatPro) == DtoS(CONS->BD6_DATPRO) .and.;
			cNumImp == CONS->BD6_NUMIMP
			
			BD6->(DbGoto(nRecno))

			cSQLTmp := " SELECT SUM(BD7_VLRPAG) AS TOTPAG "
			cSQLTmp += " FROM BD7010 BD7 "
			// 		cSQLTmp += " FROM BD7010AUXFM BD7 "
			// 		cSQLTmp += " WHERE BD7_FILIAL = '"+xFilial("BD7")+"' "
			cSQLTmp += " WHERE BD7_FILIAL = '  ' "
			cSQLTmp += " AND BD7_CODOPE = '"+BD6->BD6_CODOPE+"' "
			cSQLTmp += " AND BD7_CODLDP = '"+BD6->BD6_CODLDP+"' "
			cSQLTmp += " AND BD7_CODPEG = '"+BD6->BD6_CODPEG+"' "
			cSQLTmp += " AND BD7_NUMERO = '"+BD6->BD6_NUMERO+"' "
			// 		cSQLTmp += " AND BD7_ORIMOV = '"+TRB->BD6_ORIMOV+"' "
			cSQLTmp += " AND BD7_SEQUEN = '"+BD6->BD6_SEQUEN+"' "
			cSQLTmp += " AND BD7_CODPRO = '"+BD6->BD6_CODPRO+"' "
			// 		cSQLTmp += " AND BD7_VLRPAG > 0 "
			cSQLTmp += " AND BD7_BLOPAG <> '1' "
			//  		cSQLTmp += " AND BD7_NUMLOT <> '     ' "
			// 		cSQLTmp += " AND SubStr(BD7_NUMLOT,1,6) >= '"+cAno+cMes+"' "
			// 		cSQLTmp += " AND SubStr(BD7_NUMLOT,1,6) <= '"+cAnoAte+cMesAte+"' "
			
			If nFase == 1 // Pronta
				cSQLTmp += " AND BD7_FASE = '3' "
				cSQLTmp += " AND BD7.BD7_NUMLOT = '  ' "
			ElseIf nFase == 2 // faturada
				cSQLTmp += " AND BD7.BD7_FASE = '4' "
				cSQLTmp += " AND BD7.BD7_NUMLOT <> '     ' "
			ElseIf nFase == 3 // Ambas
				cSQLTmp += " AND BD7.BD7_FASE IN ('3','4') "
			EndIf
			
			cSQLTmp += " AND D_E_L_E_T_ = ' ' "
			
			PLSQUERY(cSQLTmp,"TRBBD7")
			
			nVlrTotBD7 := TRBBD7->TOTPAG
			
			TRBBD7->(DbCloseArea())
			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Imprime cabecalho                                                               ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If  li >= 65
				li := cabec(titulo,cabec1,cabec2,nomeprog,tamanho,nCaracter)
				Li++
			EndIf
			
			// 		BD6->(DbGoto(TRB->(REGBD6)))
			
			//0....+....1....+....2....+....3....+....4....+....5....+....6....+....7....+....8....+....9....+....0....+....1....+....2....+....3....+....4....+....5....+....6....+....7....+....8....+....9....+....0....+....1....+....2
			//Matricula             Nome                                                Data        Quantidade     Codigo                                                    Bloqueio
			//                                                                          Internacao  Aut.   Intern. RDA                                                       Usuario
			//0001.0001.999999-99-9 XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX  99/99/9999  99999  99999   123456-XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX 99/99/9999
			//                      12345678901234567890123456789012345678901234567890
			
//			@ li,000 pSay CONS->BD6_CODRDA+"-"+CONS->BD6_NOMRDA
			@ li,000 pSay BD6->BD6_MESPAG+"/"+BD6->BD6_ANOPAG
			@ li,pCol()+2 pSay BD6->BD6_CODLDP
			@ li,pCol()+2 pSay BD6->BD6_CODPEG
			@ li,pCol()+2 pSay BD6->BD6_NUMERO
			@ li,pCol()+2 pSay alltrim(BD6->BD6_OPEUSR)+"."+alltrim(BD6->BD6_CODEMP)+"."+alltrim(BD6->BD6_MATRIC)+"-"+alltrim(BD6->BD6_TIPREG) //+"-"+BD6->BD6_DIGITO
			@ li,pCol()+2 pSay BD6->BD6_NOMUSR
			@ li,pCol()+2 pSay BD6->BD6_CODPRO
			@ li,pCol()+2 pSay BD6->BD6_DESPRO
			@ li,pCol()+2 pSay BD6->BD6_DATPRO
			@ li,pCol()+2 PSay Transform(BD6->BD6_VLRTPF,"@E 999,999,999.99")//Valor Co-Participação
			@ li,pCol()+2 PSay Transform(nVlrTotBD7,"@E 999,999,999.99")//Valor Pagamento
			
			If !Empty(BD6->BD6_NUMLOT) .and. nVlrTotBD7 > 0  //Pago
				@ li,pCol()+2 PSay "Sim"   //cArqTrab->BD6_FASE
			Else
				@ li,pCol()+2 PSay "Nao"   //cArqTrab->BD6_FASE
			EndIf
			If !Empty(BD6->BD6_NUMSE1)  //Cobrado
				@ li,pCol()+2 PSay "Sim"
			Else
				@ li,pCol()+2 PSay "Nao"   //cArqTrab->BD6_FASE
			EndIf
			
//			CONS->( DbSkip() )
			
			cSQLTmp := " SELECT SUM(BD7_VLRPAG) AS TOTPAG "
			cSQLTmp += " FROM BD7010 BD7 "
			// 		cSQLTmp += " FROM BD7010AUXFM BD7 "
			// 		cSQLTmp += " WHERE BD7_FILIAL = '"+xFilial("BD7")+"' "
			cSQLTmp += " WHERE BD7_FILIAL = '  ' "
			cSQLTmp += " AND BD7_CODOPE = '"+CONS->BD6_CODOPE+"' "
			cSQLTmp += " AND BD7_CODLDP = '"+CONS->BD6_CODLDP+"' "
			cSQLTmp += " AND BD7_CODPEG = '"+CONS->BD6_CODPEG+"' "
			cSQLTmp += " AND BD7_NUMERO = '"+CONS->BD6_NUMERO+"' "
			// 		cSQLTmp += " AND BD7_ORIMOV = '"+TRB->BD6_ORIMOV+"' "
			cSQLTmp += " AND BD7_SEQUEN = '"+CONS->BD6_SEQUEN+"' "
			cSQLTmp += " AND BD7_CODPRO = '"+CONS->BD6_CODPRO+"' "
			
			// 		cSQLTmp += " AND BD7_VLRPAG > 0 "
			cSQLTmp += " AND BD7_BLOPAG <> '1' "
			//  		cSQLTmp += " AND BD7_NUMLOT <> '     ' "
			// 		cSQLTmp += " AND SubStr(BD7_NUMLOT,1,6) >= '"+cAno+cMes+"' "
			// 		cSQLTmp += " AND SubStr(BD7_NUMLOT,1,6) <= '"+cAnoAte+cMesAte+"' "
			
			If nFase == 1 // Pronta
				cSQLTmp += " AND BD7_FASE = '3' "
				cSQLTmp += " AND BD7.BD7_NUMLOT = '  ' "
			ElseIf nFase == 2 // faturada
				cSQLTmp += " AND BD7.BD7_FASE = '4' "
				cSQLTmp += " AND BD7.BD7_NUMLOT <> '     ' "
			ElseIf nFase == 3 // Ambas
				cSQLTmp += " AND BD7.BD7_FASE IN ('3','4') "
			EndIf
			
			cSQLTmp += " AND D_E_L_E_T_ = ' ' "
			
			PLSQUERY(cSQLTmp,"TRBBD7")
			
			nVlrTotBD7 := TRBBD7->TOTPAG
			
			TRBBD7->(DbCloseArea())

			li ++
			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Imprime cabecalho                                                               ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If  li >= 65
				li := cabec(titulo,cabec1,cabec2,nomeprog,tamanho,nCaracter)
				Li++
			EndIf
						
//			@ li,000 pSay CONS->BD6_CODRDA+"-"+CONS->BD6_NOMRDA
			@ li,000 pSay CONS->BD6_MESPAG+"/"+CONS->BD6_ANOPAG
			@ li,pCol()+2 pSay CONS->BD6_CODLDP
			@ li,pCol()+2 pSay CONS->BD6_CODPEG
			@ li,pCol()+2 pSay CONS->BD6_NUMERO
			@ li,pCol()+2 pSay alltrim(CONS->BD6_OPEUSR)+"."+alltrim(CONS->BD6_CODEMP)+"."+alltrim(CONS->BD6_MATRIC)+"-"+alltrim(CONS->BD6_TIPREG) //+"-"+BD6_DIGITO
			@ li,pCol()+2 pSay CONS->BD6_NOMUSR
			@ li,pCol()+2 pSay CONS->BD6_CODPRO
			@ li,pCol()+2 pSay CONS->BD6_DESPRO
			@ li,pCol()+2 pSay CONS->BD6_DATPRO
			@ li,pCol()+2 PSay Transform(CONS->BD6_VLRTPF,"@E 999,999,999.99")  //Valor Co-Participação
			@ li,pCol()+2 PSay Transform(nVlrTotBD7,"@E 999,999,999.99")        //Valor Pagamento
			
			If !Empty(CONS->BD6_NUMLOT) .and. nVlrTotBD7 > 0  //Pago
				@ li,pCol()+2 PSay "Sim"   //cArqTrab->BD6_FASE
			Else
				@ li,pCol()+2 PSay "Nao"   //cArqTrab->BD6_FASE
			EndIf
			If !Empty(CONS->BD6_NUMSE1)  //Cobrado
				@ li,pCol()+2 PSay "Sim"
			Else
				@ li,pCol()+2 PSay "Nao"   //cArqTrab->BD6_FASE
			EndIf

			nVlrTot += nVlrTotBD7

			li ++
		EndIf
		Npercent := (nProc/nTotal)*100
		IncProc("Gerando " + Transform(Npercent,"@E 9,999.9") + "  % do Relatório  " )
		ProcessMessage()
		nProc++
	End
	li++
	@ li,000      PSay "Valor Pago a Maior para esta RDA"
	@ li,pCol()+2 PSay Transform(nVlrTot,"@E 999,999,999.99")  //Valor Co-Participação
	nVlrPagTot += nVlrTot 

	nVlrTot := 0
	
	li++
	li++
End
li++
@ li,000      PSay "Valor Total Pago a Maior"
@ li,pCol()+2 PSay Transform(nVlrPagTot,"@E 999,999,999.99")  //Valor Co-Participação

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Fecha arquivo de trabalho                                                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
CONS->(dbCloseArea())

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Imprime rodape                                                                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Roda(0,"","G")
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Fim da funcao                                                                      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

Return()
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³AjustaSX1 ºAutor  ³Luzio Tavares       º Data ³  25/08/2008 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Cria as perguntas no SX1.                                   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³CABERJ                                                      º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function AjustaSX1(cPerg)

Local aRegs		:= {}

Aadd(aRegs,{cPerg,"01","Competencia de   ","","","MV_CH1","C",6,0,0,"G","","Mv_Par01","","","","","","","","","","","","","","","","","","","","","","","","","",""})
Aadd(aRegs,{cPerg,"02","Competencia Ate  ","","","MV_CH2","C",6,0,0,"G","","Mv_Par02","","","","","","","","","","","","","","","","","","","","","","","","","",""})
Aadd(aRegs,{cPerg,"03","Data de          ","","","MV_CH3","D",8,0,0,"G","","Mv_Par03","","","","","","","","","","","","","","","","","","","","","","","","","",""})
Aadd(aRegs,{cPerg,"04","Data Ate         ","","","MV_CH4","D",8,0,0,"G","","Mv_Par04","","","","","","","","","","","","","","","","","","","","","","","","","",""})
Aadd(aRegs,{cPerg,"05","RDA de           ","","","MV_CH5","C",6,0,0,"G","","Mv_Par05","","","","","","","","","","","","","","","","","","","","","","","","","",""})
Aadd(aRegs,{cPerg,"06","RDA Ate          ","","","MV_CH6","C",6,0,0,"G","","Mv_Par06","","","","","","","","","","","","","","","","","","","","","","","","","",""})
Aadd(aRegs,{cPerg,"07","Local Digitacao  ","","","MV_CH7","N",1,0,0,"C","","Mv_Par07","TISS","","","","","Todas","","","","","","","","","","","","","","","","","","","",""})
aadd(aRegs,{cPerg,"08","Fase             ","","","mv_ch8","N",1,0,0,"C","","mv_par08","Pronta"      ,"","","","","Faturada","","","","","Pronta/Faturada","","","","","Digitacao","","","","","Todas Fases","","","","",""})
//Aadd(aRegs,{cPerg,"08","Somente Vencidas ","","","MV_CH8","N",1,0,0,"C","","Mv_Par08","Sim","","","","","Nao","","","","","","","","","","","","","","","","","","","",""})
PlsVldPerg( aRegs )

Return(.T.)
