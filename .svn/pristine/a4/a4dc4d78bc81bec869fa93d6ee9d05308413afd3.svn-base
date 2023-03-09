#include "rwmake.ch"
#include "TOPCONN.CH"
/*/
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
╠╠зддддддддддбддддддддддбдддддддбддддддддддддддддддддддддбддддддбдддддддддддд©╠╠
╠╠ЁFun┤┘o    Ё CABR011  Ё Autor Ё LUZIO TAVARES          Ё Data Ё 25/08/2008 Ё╠╠
╠╠цддддддддддеддддддддддадддддддаддддддддддддддддддддддддаддддддадддддддддддд╢╠╠
╠╠ЁDescri┤┘o Ё Gerar relatorio de GIH's sem alta                             |╠╠
╠╠цддддддддддеддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд╢╠╠
╠╠ЁUso       Ё Especifico - Gerencia                                         Ё╠╠
╠╠юддддддддддаддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды╠╠
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
ъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъ
/*/

User Function CABR011()

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Inicializa variaveis                                                               Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды

cUsur := PlretOpe() // armazena na variavel o usuario do sistema

cString  := "SCP"
cDesc1   := "Este programa apresenta relatorio de GIH's sem alta."
cDesc2   := "Pode-se selecionar listar as Internacoes vencidas ou nao"
cDesc3   := "Usuario Ativo: ("+Alltrim(Cusur)+")"
limite   := 220    //132
tamanho  := "G"    //"M"
aReturn  := { "Zebrado", 1,"Setor:", 1, 2, 1, "",1 }
aLinha   := {}
nLastKey := 0
titulo   := "GIH sem Alta - CABR011"
////cabec1 := "Codigo:       Pla:  DescriГЦo:                                                    PEG:      Dlp:  Numero:       Proced.:   Bloqueio:"
//cabec1   := "Matricula     Cod.  Descricao                                                     PEG:      Local Numero:       Data       Bloqueio"
//cabec2   := "              Plano                                                                         Dig.                Internacao Usuario "
cabec1   := "Matricula             Nome                                                Data        Quantidade    Codigo                                                    Bloqueio"
cabec2   := "                                                                          Internacao  Aut.  Intern. RDA                                                       Usuario"
cCancel  := "***** CANCELADO PELO OPERADOR *****"
m_pag    := 1                                    // numero da pagina
nomeprog := "("+Alltrim(Cusur)+")"
wnrel    := "CABR011"
cPerg    := "CABR11"
pag      := 1
li       := 80

/*
cCred    :=0
cDeb     :=0
cCredT   :=0
cDebT    :=0
cCredL   :=0
cDebL    :=0
cBase    :=0
cLiq     :=0
cTipcon  :=0
cValor   :=0
*/

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Verifica as perguntas selecionadas                           Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
AjustaSX1(cPerg)
Pergunte(cPerg,.F.)

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Chamada padrao de relatorios                                                       Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
wnRel := SetPrint(cString,wnrel,cPerg,@titulo,cDesc1,cDesc2,cDesc3,.F.,"",.T.,tamanho,"",.T.)
If  nLastKey == 27
	Set Filter To
	Return
End
SetDefault(aReturn,cString)
If  nLastKey == 27
	Set Filter To
	Return
End
//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Processa relatorio                                                                 Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
//RptStatus({|| CABR011IMP() })
Processa({|| CABR011IMP() }, "Processando...", "", .T.)
//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Libera spool                                                                       Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
Set Filter To
If  aReturn[5] == 1
	Set Printer To
	Commit
	ourspool(wnrel)    // Chamada do Spool de Impressao
Endif
MS_FLUSH()             // Libera fila de relatorios em spool
//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Fim do programa                                                                    Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
Return

/*/
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
╠╠зддддддддддбддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©╠╠
╠╠ЁFun┤┘o    Ё CABR011IMP                                                    Ё╠╠
╠╠цддддддддддеддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд╢╠╠
╠╠ЁDescri┤┘o Ё Processa relatorio                                            |╠╠
╠╠юддддддддддаддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды╠╠
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
ъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъ
/*/

Static Function CABR011IMP()
Local nTotal:= 0 // recebe o n total de registros
Local nProc:=1 // incrementado por unidade de registro
Local dData1 := DtoS(Mv_Par01)
Local dData2 := DtoS(Mv_Par02)
Local nTipo  := Mv_Par03
Local nDiasInt := 0
Private aDiarAp := {0,0}

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Monta query                                                                        Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
//
cSQL := " select BE4_FILIAL, be4_opeusr,be4_codemp,be4_matric,be4_tipreg,BE4_DIGITO,DECODE(Trim(BA1_CODPLA),NULL,BA3_CODPLA,BA1_CODPLA) AS BA1_CODPLA,"
cSQL += " BA1_NOMUSR, be4_codpeg,be4_codldp,be4_numero,be4_datpro,ba1_datblo,BA1_CODINT,BE4_DTALTA,"
cSQL += " BE4_CODOPE,BE4_ANOINT,BE4_MESINT,BE4_NUMINT, BE4_CODRDA, BE4_NOMRDA"
cSQL += " FROM " + RetSQLName("BE4") + " BE4, "+ RetSQLName("BA1") +" BA1, "+ RetSQLName("BA3")+ " BA3 "
cSQL += " WHERE BA1_FILIAL = '" + xFilial("BA1") + "' AND "
cSQL += " BE4_FILIAL = '" + xFilial("BE4") + "' AND "
cSQL += " be4_dtalta = '  ' and "
cSQL += " be4_datpro <> '     ' and"
cSQL += " be4_datpro BETWEEN '"+DData1+"' and '"+DData2+"' and"
cSQL += " be4.d_e_l_e_t_ = ' ' and"
cSQL += " ba1.d_e_l_e_t_ = ' ' and"
cSQL += " BA3.D_E_L_E_T_ = ' ' AND"
cSQL += " be4_codope = ba1_codint and"
cSQL += " be4_codemp = ba1_codemp and"
cSQL += " be4_matric = ba1_matric and"
cSQL += " be4_tipreg = ba1_tipreg and"
cSQL += " be4_situac = '1' and"
cSQL += " BA3_CODINT = BA1_CODINT AND"
cSQL += " BA3_CODEMP = BA1_CODEMP AND"
cSQL += " BA3_MATRIC = BA1_MATRIC "
cSQL += " ORDER BY BE4_CODRDA,BE4_DATPRO,be4_opeusr,be4_codemp,be4_matric,be4_tipreg DESC"

//MemoWrite("C:\CABR011.SQL", cSQL)

PLSQuery(cSQL,"CONS")
//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Monta regua                                                                        Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
CONS->(DBEval( { | | nTotal++ }))
CONS-> ( DbGotop())
ProcRegua(nTotal)
//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Imprime relatorio                                                                  Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
While !CONS->(eof())
	//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//Ё Imprime cabecalho                                                               Ё
	//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
	If  li >= 58
		cabec(titulo,cabec1,cabec2,nomeprog,tamanho,GetMv("MV_COMP"))
	EndIf
	
	nDiasInt := dDataBase - CONS->BE4_DATPRO
	If nDiasInt == 0
		nDiasInt := 1
	ElseIf nDiasInt < 1
		nDiasInt := 0
	EndIf
	
	aDiarAp := 	U_QTDDIARLIB()
	
	If nTipo == 1 .and. (aDiarAp[1]+aDiarAp[2] > nDiasInt)
		CONS->( DbSkip() )
		Loop
	EndIf
	
	//	If !Empty(CONS->BA1CODPLA)
	//		cCodPla := CONS->BA1_CODPLA+BA1_VERSAO)
	//	Else
	//		cCodPla := CONS->(BA3_CODPLA+BA3_VERSAO)
	//	EndIf
	
	cDesPla := "Produto nao Identificado"
	BI3->(DbSetOrder(1))
	If BI3->(DbSeek(xFilial("BI3")+CONS->(BA1_CODINT+BA1_CODPLA)))
		cDesPla := BI3->BI3_DESCRI
	EndIf
	//0....+....1....+....2....+....3....+....4....+....5....+....6....+....7....+....8....+....9....+....0....+....1....+....2....+....3....+....4....+....5....+....6....+....7....+....8....+....9....+....0....+....1....+....2
	//Matricula             Nome                                                Data        Quantidade     Codigo                                                    Bloqueio
	//                                                                          Internacao  Aut.   Intern. RDA                                                       Usuario
	//0001.0001.999999-99-9 XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX  99/99/9999  99999  99999   123456-XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX 99/99/9999
	//                      12345678901234567890123456789012345678901234567890
	
	@ li,000 pSay alltrim(CONS->BE4_OPEUSR)+"."+alltrim(CONS->BE4_CODEMP)+"."+alltrim(CONS->BE4_MATRIC)+"-"+alltrim(CONS->BE4_TIPREG)+"-"+BE4_DIGITO
	@ li,022 pSay CONS->BA1_NOMUSR
	@ li,074 pSay CONS->BE4_DATPRO
	@ li,086 pSay Transform((aDiarAp[1]+aDiarAp[2]),"@E 99999")
	@ li,093 pSay Transform(nDiasInt,"@E 99999")
	@ li,101 pSay CONS->BE4_CODRDA+"-"+CONS->BE4_NOMRDA
	@ li,159 pSay CONS->BA1_DATBLO
	//   @ li,092 pSay CONS->BE4_CODLDP
	//   @ li,098 pSay CONS->BE4_NUMERO
	//   @ li,110 pSay CONS->BE4_DATPRO   //Dpro
	//   @ li,122 pSay CONS->BA1_DATBLO   //Dblo
	
	li ++
	Npercent := (nProc/nTotal)*100
	IncProc("Gerando " + Transform(Npercent,"@E 9,999.9") + "  % do RelatСrio  " )
	ProcessMessage()
	nProc++
	CONS->( DbSkip() )
End

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Fecha arquivo de trabalho                                                          Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
CONS->(dbCloseArea())

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Imprime rodape                                                                     Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
Roda(0,"","G")
//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Fim da funcao                                                                      Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды

Return()
/*
эээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээ
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
╠╠иммммммммммяммммммммммкмммммммяммммммммммммммммммммкммммммяммммммммммммм╩╠╠
╠╠╨Programa  ЁAjustaSX1 ╨Autor  ЁLuzio Tavares       ╨ Data Ё  25/08/2008 ╨╠╠
╠╠лммммммммммьммммммммммймммммммоммммммммммммммммммммйммммммоммммммммммммм╧╠╠
╠╠╨Desc.     ЁCria as perguntas no SX1.                                   ╨╠╠
╠╠лммммммммммьмммммммммммммммммммммммммммммммммммммммммммммммммммммммммммм╧╠╠
╠╠╨Uso       ЁCABERJ                                                      ╨╠╠
╠╠хммммммммммомммммммммммммммммммммммммммммммммммммммммммммммммммммммммммм╪╠╠
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
ъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъ
*/
Static Function AjustaSX1(cPerg)

Local aRegs		:= {}

Aadd(aRegs,{cPerg,"01","Data de          ","","","MV_CH1","D",8,0,0,"G","","Mv_Par01","","","","","","","","","","","","","","","","","","","","","","","","","",""})
Aadd(aRegs,{cPerg,"02","Data ate         ","","","MV_CH2","D",8,0,0,"G","","Mv_Par02","","","","","","","","","","","","","","","","","","","","","","","","","",""})
Aadd(aRegs,{cPerg,"03","Somente Vencidas ","","","MV_CH3","N",1,0,0,"C","","Mv_Par03","Sim","","","","","Nao","","","","","","","","","","","","","","","","","","","",""})
PlsVldPerg( aRegs )

Return(.T.)

/*/
ээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээ
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
╠╠зддддддддддбддддддддддддбдддддддбдддддддддддддддддддддбддддддбдддддддддд©╠╠╠
╠╠ЁFuncao    Ё QTDDIARLIB Ё Autor Ё Luzio Tavares       Ё Data Ё28/08/2008Ё╠╠╠
╠╠цддддддддддеддддддддддддадддддддадддддддддддддддддддддаддддддадддддддддд╢╠╠╠
╠╠ЁDescricao Ё Apura a Quantidade de Diarias Autorizadas			           Ё╠╠╠
╠╠юддддддддддадддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды╠╠╠
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
ъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъ
/*/
User Function QTDDIARLIB()
Local nDAut   := 0
Local nDSol   := 0
Local nDPro   := 0
Local lUmIte  := .F.
Local aArea   := GetArea()

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Zera variavies															 Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
aDiarAp := {0,0}
//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Internacao															                    Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
DbSelectArea("BEJ")
BEJ->(DbSetOrder(1))   //BEJ_FILIAL + BEJ_CODOPE + BEJ_ANOINT + BEJ_MESINT + BEJ_NUMINT + BEJ_SEQUEN
If BEJ->(MsSeek(xFilial("BEJ")+ CONS->(BE4_CODOPE + BE4_ANOINT + BE4_MESINT + BE4_NUMINT)))
	While ! BEJ->(Eof()) .And. CONS->(BE4_FILIAL+BE4_CODOPE+BE4_ANOINT+BE4_MESINT+BE4_NUMINT) == ;
		xFilial("BEJ")+BEJ->(BEJ_CODOPE+BEJ_ANOINT+BEJ_MESINT+BEJ_NUMINT)
		If BEJ->BEJ_STATUS == '1' .AND. BR8->( MsSeek( xFilial("BR8")+ BEJ->(BEJ_CODPAD+BEJ_CODPRO)))
			If BR8->BR8_TPPROC == "4"
				nDAut += BEJ->BEJ_QTDPRO
				nDSol += BEJ->BEJ_QTDSOL
			Endif
		Endif
		BEJ->(DbSkip())
	Enddo
Endif

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Evolucao						                                               Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
DbSelectArea("BQV")
BQV->(DbSetOrder(1))   //BQV_FILIAL + BQV_CODOPE + BQV_ANOINT + BQV_MESINT + BQV_NUMINT + BQV_SEQUEN
If BQV->(MsSeek(xFilial("BQV")+ CONS->(BE4_CODOPE + BE4_ANOINT + BE4_MESINT + BE4_NUMINT)))
	If BQV->( FieldPos("BQV_STATUS") ) > 0
		While ! BQV->(Eof()) .And. CONS->(BE4_FILIAL+BE4_CODOPE+BE4_ANOINT+BE4_MESINT+BE4_NUMINT) == ;
			xFilial("BQV")+BQV->(BQV_CODOPE+BQV_ANOINT+BQV_MESINT+BQV_NUMINT)
			If BQV->BQV_STATUS == '1' .AND. BR8->( MsSeek( xFilial("BR8")+ BQV->(BQV_CODPAD+BQV_CODPRO)))
				If BR8->BR8_TPPROC == "4"
					nDPro += BQV->BQV_QTDPRO
				Endif
			Endif
			BQV->(DbSkip())
			lUmIte := .T.
		Enddo
	EndIf
	//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//Ё Se existe algum procedimento na evolucao(prorrogacao)				        Ё
	//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
	If nDPro = 0 .And. lUmIte
		nDPro := 1
	EndIf
Endif
RestArea(aArea)

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Fim da Rotina															 Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
Return( {nDAut,nDPro, nDSol} )
