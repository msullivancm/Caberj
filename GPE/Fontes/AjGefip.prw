#Include "PROTHEUS.CH"
#iNCLUDE "TOPCONN.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณAJSEFIP   บAutor  ณWellington Tonieto  บ Data ณ  03/31/08   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Imprime as inconsistencias encontradas entre o m๓dulos fina-บฑฑ
ฑฑบ          ณ e PLS para congerencia da gefip                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

*************************
User Function AjGefip()
*************************

Local oDlg     := Nil

Private dDataDe    := dDatabase
Private dDataAte   := dDataBase
Private cMesAno    := Space(02)
Private cAnoPag    := Space(04)
Private cCodOpeDe  := Space(04)
Private cCodOpeAte := Space(04)
Private nLin       := 80

DEFINE MSDIALOG oDlg FROM 0,0 TO 310,330 PIXEL TITLE "Informe periodo desejado:"

@ 001,003 TO 130,0160 LABEL "" OF oDlg PIXEL

@ 010,015  SAY "Data Inicio........:" SIZE 55,10 PIXEL OF oDlg
@ 030,015  SAY "Data Final.........:" SIZE 55,10 PIXEL OF oDlg
@ 050,015  SAY "Mes Lote Inicio....:" SIZE 55,10 PIXEL OF oDlg
@ 070,015  SAY "Ano Lote Inicio....:" SIZE 55,10 PIXEL OF oDlg
@ 090,015  SAY "Operadora De.......:" SIZE 55,10 PIXEL OF oDlg
@ 110,015  SAY "Operadora Ate......:" SIZE 55,10 PIXEL OF oDlg

@ 010,070 MSGET dDataDe    PICTURE "@!"  WHEN .T. SIZE 15,10 PIXEL OF oDlg
@ 030,070 MSGET dDataAte   PICTURE "@!"  WHEN .T. SIZE 15,10 PIXEL OF oDlg
@ 050,070 MSGET cMesAno    PICTURE "@!"  WHEN .T. SIZE 10,10 PIXEL OF oDlg
@ 070,070 MSGET cAnoPag    PICTURE "@!"  WHEN .T. SIZE 10,10 PIXEL OF oDlg
@ 090,070 MSGET cCodOpeDe  PICTURE "@!"  WHEN .T. SIZE 10,10 PIXEL OF oDlg
@ 110,070 MSGET cCodOpeAte PICTURE "@!"  WHEN .T. SIZE 10,10 PIXEL OF oDlg

DEFINE SBUTTON FROM 135,050 TYPE 1 OF oDlg ENABLE ACTION MsAguarde({||CrtSefip(),odlg:end()}) ENABLE OF oDlg
DEFINE SBUTTON FROM 135,090 TYPE 2 OF oDlg ENABLE ONSTOP "Sair..." ACTION oDlg:End()

ACTIVATE MSDIALOG oDlg CENTER

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNOVO7     บ Autor ณ AP6 IDE            บ Data ณ  09/04/08   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Codigo gerado pelo AP6 IDE.                                บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP6 IDE                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/

Static Function CrtSefip()

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Declaracao de Variaveis                                             ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

Local cDesc1        := "Este programa tem como objetivo imprimir relatorio "
Local cDesc2        := "de acordo com os parametros informados pelo usuario."
Local cDesc3        := ""
Local cPict         := ""
Local titulo        := "Relatorio de consistencia da Gefip - FINANCEIRO X PLS  - Periodo..: " + Transform(dDataDe,"@e") + " Ate " + Transform(dDataAte,"@e") 

Local Cabec1        := "                                                                  --------FINANCEIRO--------    ----------PLS------------      -----DIFERENCAS--------   "
Local Cabec2        := "Mes CodRda   Prestador                                 Lote         Vl.Base      Vl.Imposto       Vl.Base       Vl.Imposto        Base        Imposto      Log  "
Local imprime       := .T.
Local aOrd          := {}
Private lEnd        := .F.
Private lAbortPrint := .F.
Private CbTxt       := ""
Private limite      := 80
Private tamanho     := "G"
Private nomeprog    := "NOME" // Coloque aqui o nome do programa para impressao no cabecalho
Private nTipo       := 18
Private aReturn     := { "Zebrado", 1, "Administracao", 2, 2, 1, "", 1}
Private nLastKey    := 0
Private cbtxt       := Space(10)
Private cbcont      := 00
Private CONTFL      := 01
Private m_pag       := 01
Private wnrel       := "NOME" // Coloque aqui o nome do arquivo usado para impressao em disco
Private cString     := "SE2"
Private cPerg       := " "
Private mv_par00    := " "

dbSelectArea("SE2")

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Monta a interface padrao com o usuario...                           ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

// SetPrint(cString,NomeProg,"",@titulo,cDesc1,cDesc2,cDesc3,.T.,aOrd,.T.,Tamanho,,.T.)
wnrel := SetPrint(cString,wnrel,cPerg,@titulo,cDesc1,cDesc2,cDesc3,.F.,"",,Tamanho)

If nLastKey == 27
	Return
Endif

SetDefault(aReturn,cString)

If nLastKey == 27
	Return
Endif

nTipo := If(aReturn[4]==1,15,18)

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Processamento. RPTSTATUS monta janela com a regua de processamento. ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

RptStatus({|| RunReport(Cabec1,Cabec2,Titulo,nLin) },Titulo)
Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFuno    ณRUNREPORT บ Autor ณ AP6 IDE            บ Data ณ  09/04/08   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescrio ณ Funcao auxiliar chamada pela RPTSTATUS. A funcao RPTSTATUS บฑฑ
ฑฑบ          ณ monta a janela com a regua de processamento.               บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Programa principal                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/

Static Function RunReport(Cabec1,Cabec2,Titulo,nLin)

Local nOrdem
Local J := 1
Local cQuery  := " "
Local nVlTotFin    := 0
Local nVlTotPls    := 0
Local nVlInssFin   := 0
Local nVlInssPls   := 0
Local nVlErroBs    := 0
Local nVlErroIm    := 0

DbSelectArea("BAU")
DbSetOrder(1)

cQuery := " SELECT * FROM ( "
cQuery += "   SELECT * FROM ( "
cQuery += "     SELECT  B15_OPERDA,B15_CODRDA,B15_MESLOT,B15_ANOLOT,B15_NUMLOT,SUM(B15_BASEPF) VALORPF,SUM(B15_BASEPJ) VALORPJ,"
cQuery += "                            SUM(B15_BASEJF) BASEJF,SUM(B15_INSSPF) INSSPF,SUM(B15_INSSPJ) INSSPJ "
cQuery += "     FROM " + RetSqlName("B15") + " B15 "
cQuery += "         LEFT OUTER JOIN " + RetSqlName("BAU") + " BAU "
cQuery += "         ON   BAU.BAU_FILIAL   = '  ' AND BAU.BAU_CODIGO   = B15.B15_CODRDA AND  BAU.D_E_L_E_T_ <> '*' "
cQuery += "         WHERE "
cQuery += "         B15.B15_FILIAL  = '" + xFilial("B15")  + "'  AND "
cQuery += "         (B15.B15_OPERDA >= '" + cCodOpeDe      + "' AND "
cQuery += "         B15.B15_OPERDA <=  '" + cCodOpeAte     + "') AND "
cQuery += "         B15.B15_ANOLOT >=  '" + cAnoPag        + "'  AND "
cQuery += "         B15.B15_MESLOT >=  '" + cMesAno        + "'  AND "
cQuery += "         B15.D_E_L_E_T_ <> '*' "
cQuery += "         GROUP BY B15.B15_OPERDA,B15.B15_CODRDA,B15.B15_MESLOT,B15.B15_ANOLOT,B15.B15_NUMLOT "
cQuery += "     ) B15 "
cQuery += "   RIGHT OUTER JOIN ( "
cQuery += "                  SELECT E2_MESBASE,E2_CODRDA,A2_NOME,Sum(E2_VALOR+E2_INSS+E2_ISS+E2_PIS+E2_COFINS+E2_CSLL+E2_IRRF) VL_BASEFIN ,Sum(E2_INSS) INSS,E2_PLLOTE "
cQuery += "                  FROM " + RetSqlName("SE2") + " SE2 , "  + RetSqlName("SA2") + " SA2 "
cQuery += "                  WHERE SE2.E2_FILIAL   = '01' "
cQuery += "                        And  SE2.E2_FORNECE   = SA2.A2_COD "
cQuery += "                        And  SE2.D_E_L_E_T_  <> '*'        "
cQuery += "                        And  SE2.E2_BAIXA    >= '" + Dtos(dDataDe) + "'"
cQuery += "                        And  SE2.E2_BAIXA    <= '" + dTos(dDataAte)+ "'"
cQuery += "                        And  SE2.E2_SALDO    = 0           "
cQuery += "                        And  (SE2.E2_INSS    > 0 OR SA2.A2_TIPO = 'F' ) "
cQuery += "                        And  SE2.E2_CODRDA  <> ' ' GROUP BY E2_MESBASE,E2_CODRDA,A2_NOME,E2_PLLOTE "
cQuery += "   )SE2 "
cQuery += " ON   SE2.E2_CODRDA = B15_CODRDA AND B15_ANOLOT||B15_MESLOT||B15_NUMLOT = SE2.E2_PLLOTE  "
cQuery += " ) TABF           "
cQuery += " ORDER BY B15_CODRDA "

cQuery := ChangeQuery(cQuery)

IF Select("TRC") > 0
	DbSelectArea("TRC")
	DbCloseArea()
ENDIF

TCQUERY cQuery ALIAS "TRC" NEW
dbselectarea("TRC")
TRC->(dbGoTop())

SetRegua(RecCount())

While !eof()
	
	_MsgLog    := "  "
	nVlBaseFin := TRC->VL_BASEFIN
	nVlBasePls := TRC->VALORPJ
	nVlImpFin  := TRC->INSS
	nVlImpPls  := TRC->INSSPJ
	
	If !Empty(TRC->B15_CODRDA)
		
		IF Abs(TRC->VL_BASEFIN) <> Abs(TRC->VALORPJ)
			_MsgLog := " Valor da Base de calculo do financeiro diferente da base PLS !!! "
		Endif
		
		IF Abs(TRC->INSS)   <>  Abs(TRC->INSSPJ)
			_MsgLog := " Valor do Imposto calculado no financeiro diferente do PLS!!!"
		Endif
	Else
		_MsgLog := " Registro nao localizado na base de impostos do modulos PLS !!!"
	Endif
	
	If !Empty(_MsgLog)
		
		If nLin > 55 // Salto de Pแgina. Neste caso o formulario tem 55 linhas...
		   Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
		   nLin := 8
 	   Endif
	
		nLin ++
		@ nLin,000 PSAY Replicate("_",220)
	   nLin++
		
		@ nLin,000 PSAY TRC->E2_MESBASE
		@ nLin,005 PSAY TRC->E2_CODRDA
		@ nLin,015 PSAY Substr(TRC->A2_NOME,1,30)
		@ nLin,050 PSAY TRC->E2_PLLOTE
		@ nLin,060 PSAY PADL(Transform(nVlBaseFin ,"@e 999,999.99"),15)
		@ nLin,075 PSAY PADL(Transform(nVlImpFin  ,"@e 999,999.99"),15)
		@ nLin,090 PSAY PADL(Transform(nVlBasePls ,"@e 999,999.99"),15)
		@ nLin,105 PSAY PADL(Transform(nVlImpPls  ,"@e 999,999.99"),15)
		@ nLin,120 PSAY PADL(Transform((nVlBaseFin - nVlBasePls),"@e 999,999.99"),15)
		@ nLin,135 PSAY PADL(Transform((nVlImpFin  - nVlImpPls ),"@e 999,999.99"),15)
		@ nLin,155 PSAY _MsgLog
		
		nVlTotFin    += nVlBaseFin
		nVlTotPls    += nVlBasePls
		nVlInssFin   += nVlImpFin
		nVlInssPls   += nVlImpPls
		nVlErroBs    += (nVlBaseFin - nVlBasePls)
		nVlErroIm    += (nVlImpFin  - nVlImpPls )
	Endif
	
	DbSelectArea("TRC")
	DbSkip()
Enddo

nLin += 4

@ nLin,010 PSAY " T O T A I S  D O   R E L A T O R I O "
@ nLin,060 PSAY PADL(Transform(nVlTotFin  ,"@e 999,999.99"),15)
@ nLin,075 PSAY PADL(Transform(nVlInssFin ,"@e 999,999.99"),15)
@ nLin,090 PSAY PADL(Transform(nVlTotPls  ,"@e 999,999.99"),15)
@ nLin,105 PSAY PADL(Transform(nVlInssPls ,"@e 999,999.99"),15)
@ nLin,120 PSAY PADL(Transform(nVlErroBs  ,"@e 999,999.99"),15)
@ nLin,135 PSAY PADL(Transform(nVlErroIm ,"@e 999,999.99"),15)


//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Finaliza a execucao do relatorio...                                 ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

SET DEVICE TO SCREEN

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Se impressao em disco, chama o gerenciador de impressao...          ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

If aReturn[5]==1
	dbCommitAll()
	SET PRINTER TO
	OurSpool(wnrel)
Endif

MS_FLUSH()

Return


