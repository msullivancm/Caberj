#include "PLSMGER.CH"

/*
ээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээ
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
╠╠зддддддддддбдддддддддбдддддддбддддддддддддддддддддддддбддддддбдддддддддд©╠╠╠
╠╠ЁFuncao    Ё CABR060 Ё Autor Ё Gedilson Rangel        Ё Data Ё 24.06.09 Ё╠╠╠
╠╠цддддддддддедддддддддадддддддаддддддддддддддддддддддддаддддддадддддддддд╢╠╠╠
╠╠ЁDescricao Ё RelatСrio de clientes devedores com mais de 60 dias.       Ё╠╠╠
╠╠юддддддддддадддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды╠╠╠
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
ъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъ
*/
//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Define nome da funcao...                                                 Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
User Function CABR060()
//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Define variavaoeis...                                                    Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
PRIVATE nQtdLin 	:= 58  //LINHAS VERTICAIS
PRIVATE cNomeProg   := "CABR060" //NOME PADRAO AO IMPRIMIR
PRIVATE nCaracter   := 15
PRIVATE nLimite     := 220
PRIVATE cTamanho    := "G"
PRIVATE cTitulo     := "RelatСrio de Clientes com Debito Acima de 60 Dias"
PRIVATE cDesc1      := ""
PRIVATE cDesc2      := ""
PRIVATE cDesc3      := ""
PRIVATE cCabec1     := "Codigo Nome Cliente                      Matricula        Nome Usuario                                                 Bloq.    Tel          Cel         Titulo        S Ano/Mes Vencto   D          Valor          Saldo  "
PRIVATE cCabec2     := " "
PRIVATE cAlias      := "SE1"
PRIVATE cPerg       := "CABR60"
PRIVATE cRel        := "CABR060"
PRIVATE nLi         := 01
PRIVATE m_pag       := 1
PRIVATE aReturn     := { "Zebrado", 1,"Administracao", 1, 1, 1, "",1 }
PRIVATE lAbortPrint := .F.
PRIVATE aOrdens     := {}
PRIVATE lDicion     := .F.
PRIVATE lCompres    := .F.
PRIVATE lCrystal    := .F.
PRIVATE lFiltro     := .T.

/*
0         10        20        30        40        50        60        70        80        90        100       110       120       130       140       150       160       170       180       190       200       210       220
01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
"Codigo Nome Cliente                      Matricula        Nome Usuario                                                 Bloq.    Tel          Cel         Titulo        S Ano/Mes Vencto   D          Valor          Saldo  "
01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
*/
//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Chama SetPrint                                                           Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
CriaSX1(cPerg)
cRel := SetPrint(cAlias,cRel,cPerg,@cTitulo,cDesc1,cDesc2,cDesc3,lDicion,aOrdens,lCompres,cTamanho,{},lFiltro,lCrystal)
//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Verifica se foi cancelada a operacao                                     Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
If nLastKey  == 27
	Return
Endif
//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Recebe parametros                                                        Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
Pergunte(cPerg,.F.)

cQtdDiaD     	:= mv_par01
cQtdDiaA		:= mv_par02
cCodCli			:= mv_par03

cTitulo := AllTrim(cTitulo)
//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Configura Impressora                                                     Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
SetDefault(aReturn,cAlias)

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Monta RptStatus...                                                       Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
Processa({|| ImpRel(cPerg)},cTitulo)

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Fim da Rotina Principal...                                               Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
Return


/*
ээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээ
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
╠╠зддддддддддбдддддддддбдддддддбддддддддддддддддддддддддбддддддбдддддддддд©╠╠╠
╠╠ЁFuncao    Ё ImpRel  Ё Autor Ё Romulo Ferrari         Ё Data Ё 17.06.09 Ё╠╠╠
╠╠цддддддддддедддддддддадддддддаддддддддддддддддддддддддаддддддадддддддддд╢╠╠╠
╠╠ЁDescricao Ё RelatСrio de custo por internaГЦo sem honorАrios MИdicos   Ё╠╠╠
╠╠юддддддддддадддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды╠╠╠
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
ъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъ
*/
//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Define nome da funcao                                                    Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
Static Function ImpRel()
//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Variaveis do IndRegua...                                                 Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
LOCAL i
LOCAL n
LOCAL _cEmpRel := Iif(Substr(cNumEmp,1,2)=="01",'C','I')
LOCAL nQtd		:= 0
LOCAL cCodCli  := ""
LOCAL cMatric  := ""
LOCAL cStTCli  := 0
LOCAL cStTMat  := 0
LOCAL cTotGer  := 0
//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Monta Expressao de filtro...                                             Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды

cQuery := " SELECT E1_CLIENTE, E1_NOMCLI, BA3_CODINT, BA3_CODEMP, BA3_MATRIC, BA1_NOMUSR, E1_PREFIXO, E1_NUM, E1_ANOBASE, E1_MESBASE, E1_BAIXA," 
cQuery += " E1_EMISSAO, E1_VENCREA,E1_VENCREA,(TRUNC(SYSDATE) - To_Date(E1_VENCREA,'YYYYMMDD')) QTDDIAS,E1_VALOR, E1_SALDO, E1_SITUACA, BA1_DATBLO," 
cQuery += " BA1_TELEFO, BA1_YCEL "
cQuery += " FROM "+RetSQLName("SE1")+ " SE1," +RetSQLName("BA3")+" BA3,"+RetSQLName("BA1")+" BA1"
cQuery += " WHERE E1_FILIAL = '"+xFilial("SE1")+"' "
cQuery += " AND BA3_FILIAL = ' ' "
cQuery += " AND BA1_FILIAL = ' ' "
cQuery += " AND E1_PREFIXO = 'PLS' "
cQuery += " AND E1_TIPO = 'DP ' "
cQuery += " AND E1_CLIENTE = BA3_CODCLI  "
If ! Empty(mv_par03)
	cQuery +=  " AND E1_CLIENTE = '"+mv_par03+"'"
End
cQuery += " AND (E1_BAIXA = ' ' OR (E1_BAIXA <> ' ' AND E1_SALDO > 0 AND E1_SALDO < E1_VALOR))"
cQuery += " AND BA1_CODINT = BA3_CODINT "
cQuery += " AND BA1_CODEMP = BA3_CODEMP "
cQuery += " AND BA1_MATRIC = BA3_MATRIC "                         
cQuery += " AND To_Date(E1_VENCREA,'YYYYMMDD') < SYSDATE "
cQuery += " AND (TRUNC(SYSDATE) - To_Date(E1_VENCREA,'YYYYMMDD')) >= '"+mv_par01+"'"
cQuery += " AND (TRUNC(SYSDATE) - To_Date(E1_VENCREA,'YYYYMMDD')) <= '"+mv_par02+"'"
cQuery += " AND BA1_TIPREG = '00' "
cQuery += " AND (BA3_DATBLO = ' ' OR (BA3_DATBLO <> ' ' AND BA3_MOTBLO = '024')) "//Parametro
cQuery += " AND (BA1_DATBLO = ' ' OR (BA1_DATBLO <> ' ' AND BA1_MOTBLO = '024')) "
cQuery += " AND SE1.D_E_L_E_T_ <> '*' " 
cQuery += " AND BA1.D_E_L_E_T_ <> '*' "
cQuery += " AND BA3.D_E_L_E_T_ <> '*' "
cQuery += " ORDER BY E1_CLIENTE, BA3_CODINT, BA3_CODEMP, BA3_MATRIC, E1_ANOBASE, E1_MESBASE " 

//=================================================
//PARTE DA PROGRAMACAO

//memowrite("C:\CABR123.TXT",cQuery) Gera um arquivo texto no diretorio especificado

PlsQuery(cQuery, "TRB")

nQtd:=0
TRB->(DBEval( { | | nQtd ++ }))
ProcRegua(nQtd)

TRB->(DbGoTop())
nLi := 500


While ! TRB->(Eof())
	cCodCli := TRB->(E1_CLIENTE)
	
	//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//Ё Apresenta mensagem em tela...                                            Ё
	//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
	IncProc( "Processando...")
	
	If  nli > nQtdLin
		nLi := Cabec(cTitulo,cCabec1,cCabec2,cNomeProg,cTamanho,nCaracter)
		nLi++
	Endif              

	While TRB->(E1_CLIENTE) == cCodCli .AND. !TRB->(Eof())
		cMatric := TRB->(BA3_CODINT+BA3_CODEMP+BA3_MATRIC)
		While TRB->(E1_CLIENTE) == cCodCli .AND.TRB->(BA3_CODINT+BA3_CODEMP+BA3_MATRIC)== cMatric .AND. !TRB->(Eof())
			@ nLi, 000 Psay TRB->E1_CLIENTE
			@ nLi, 007 Psay TRB->E1_NOMCLI
			@ nLi, 041 Psay TRB->BA3_CODINT
			@ nLi, 046 Psay TRB->BA3_CODEMP
			@ nLi, 051 Psay TRB->BA3_MATRIC
			@ nLi, 058 Psay AllTrim(TRB->BA1_NOMUSR)
			@ nLi, 119 Psay TRB->BA1_DATBLO
			@ nLi, 128 Psay TRB->BA1_TELEFO
			@ nLi, 141 Psay TRB->BA1_YCEL
			@ nLi, 154 Psay TRB->E1_PREFIXO
			@ nLi, 158 Psay TRB->E1_NUM
			@ nLi, 168 Psay TRB->E1_SITUACA
			@ nLi, 170 Psay TRB->E1_ANOBASE
			@ nLi, 174 Psay "/"
			@ nLi, 175 Psay TRB->E1_MESBASE
			@ nLi, 178 Psay TRB->E1_VENCREA  
			@ nLi, 187 Psay TRB->QTDDIAS
			@ nLi, 191 Psay (Transform(TRB->E1_VALOR,"@E 999,999,999.99"))
			If (TRB->E1_SALDO) <> (TRB->E1_VALOR)
				@ nLi, 205 Psay (Transform(TRB->E1_SALDO,"@E 999,999,999.99"))
			End
			nLi++
			cSTtMat := cStTMat + (TRB->E1_VALOR)
			TRB->(dbSkip())
		EndDo
		@ nLi, 041 pSay replicate("-", 179)
		nLi++
		@ nLi, 041 pSay ("Total da Matricula...................................")
		@ nLi, 141 pSay Transform((cStTMat),"@E 999,999,999,999.99")
		cSTtCli := cSTtCli + cStTMat
		cStTMat:= 0
		nLi++
		nLi++
	EndDo
	@ nLi, 041 pSay replicate("_", 179)
	nLi++
	@ nLi, 041 pSay ("Total do Cliente.....................................")
	@ nLi, 141 pSay Transform((cSTtCli),"@E 999,999,999,999.99")
	cTotGer += cSTtCli
	cStTMat := 0
	cSTtCli := 0
	nLi++
	nLi++
End 
	nLi++
	@ nLi, 041 pSay ("Total do Geral.....................................")                 
	@ nLi, 141 pSay Transform((cTotGer),"@E 999,999,999,999.99")

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Imprime rodape...                                                  Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
Roda(0,Space(10))
//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Fecha area de trabalho...                                          Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
TRB->( dbClosearea() )

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Libera impressao                                                         Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
If  aReturn[5] == 1
	Set Printer To
	Ourspool(crel)
Endif
//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Fim da impressao do relatorio...                                         Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
Return()


/*/
ээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээ
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
╠╠здддддддддддбдддддддддддбдддддддбддддддддддддддддддддддбддддддбдддддддддд©╠╠
╠╠ЁPrograma   Ё CriaSX1   Ё Autor Ё Angelo Sperandio     Ё Data Ё 03.02.05 Ё╠╠
╠╠цдддддддддддедддддддддддадддддддаддддддддддддддддддддддаддддддадддддддддд╢╠╠
╠╠ЁDescricao  Ё Atualiza SX1                                               Ё╠╠
╠╠юдддддддддддадддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды╠╠
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
/*/

Static Function CriaSX1(cPerg)

cQtdDiaD     	:= mv_par01
cQtdDiaA     	:= mv_par02
cCodCli			:= mv_par03

PutSx1(cPerg,"01",OemToAnsi("Qtd. Dias De:")			,"","","mv_ch1","C",04,0,0,"G","","","","","mv_par01","","","","","","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"02",OemToAnsi("Qtd. Dias AtИ:")			,"","","mv_ch2","C",04,0,0,"G","","","","","mv_par02","","","","","","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"03",OemToAnsi("Cod.Cliente")			,"","","mv_ch3","C",06,0,0,"G","","SA1","","","mv_par03","","","","","","","","","","","","","","","","",{},{},{})
//PutSx1(cPerg,"04",OemToAnsi("Bloqueio-024?")	   	,"","","mv_ch4","C",01,0,1,"C","","","","","mv_par04","","","","","","","","","","","","","","","","",{},{},{})

Return
