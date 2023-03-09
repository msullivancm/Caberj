
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABR007    ºAutor  ³Luzio Tavares      º Data ³  25/06/08   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Extrato de Utilização                                       º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Plano de Saúde - PLS                                       º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function CABR007()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//Local wnrel
Private cDesc1 	:= "Este programa tem como objetivo imprimir Extrato Usuário "
Private cDesc2 	:= ""
Private cDesc3 	:= ""
Private cString 	:= "BD6"
Private nQtdLin     := 58
Private cAlias      := "BD6"
Private cRel        := "CABR007"
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
Private cTitulo	:= "EXTRATO de UTILIZACAO para SIMPLES CONFERENCIA"
Private aReturn := { "Zebrado", 1,"Administracao", 1, 1, 1, "",1 }
Private cPerg   := "CABR07    "
Private nomeprog:= "CABR007"
Private nLastKey:=0
Private cabec1  := ""
Private cabec2  := ""
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Atualiza SX1                                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
CriaSX1()

Pergunte(cPerg,.F.)

cRel := SetPrint(cString,cRel,cPerg,@cTitulo,cDesc1,cDesc2,cDesc3,.F.,"",,tamanho,,.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Acessa parametros do relatorio...                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

cMatric  := mv_par01
dDataDe	:= mv_par02
dDataAte := mv_par03

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
±±³ Descri‡…o ³Impressao 											       ³±±
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
Local cbcont,cbtxt
Local cSQL
//Local cArqTrab := CriaTrab(nil,.F.)
Local nTotCo, nTotPag := 0

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para Impressao do Cabecalho e Rodape    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cbtxt    := SPACE(10)
cbcont   := 0
li       := 80
m_pag    := 1

nTipo := GetMv("MV_COMP")

dbSelectArea("BD6")

cSQL := "SELECT BD6_OPEUSR, BD6_CODEMP, BD6_MATRIC, BD6_TIPREG,  "
cSQL += "BD6_DIGITO, BD6_ANOPAG, BD6_MESPAG, "
cSQL += "BD6_NOMUSR, BD6_CODRDA, BD6_NOMRDA, BD6_FASE, "
cSQL += "BD6_DATPRO, BD6_QTDPRO, BD6_STAFAT, BD6_SITUAC, "
cSQL += "BD6_CODPAD, BD6_CODPRO, BD6_DESPRO, "
cSQL += "BD6_VLRPAG, BD6_VLRTPF, BD6_NUMSE1, bd6_prefix, bd6_numtit, bd6_tiptit , "

cSQL += "(SELECT SUM(BD7_VLRPAG) "
cSQL += "FROM "+RetSQLName("BD7")+" BD7 "
cSQL += "WHERE D_E_L_E_T_ <> '*' "
cSQL += "AND BD7_FILIAL = '"+xFilial("BD7")+"' "
cSQL += "AND BD7_CODOPE = BD6.BD6_CODOPE "
cSQL += "AND BD7_CODLDP = BD6.BD6_CODLDP "
cSQL += "AND BD7_CODPEG = BD6.BD6_CODPEG "
cSQL += "AND BD7_NUMERO = BD6.BD6_NUMERO "
cSQL += "AND BD7_ORIMOV = BD6.BD6_ORIMOV "
cSQL += "AND BD7_SEQUEN = BD6.BD6_SEQUEN "
cSQL += "AND BD7_CODPRO = BD6.BD6_CODPRO "
cSQL += "AND BD7_NUMLOT <> '    ' ) AS BD7VLRPAG "

cSQL += "FROM "+RetSQLName("BD6")+ " BD6 "
cSQL += "WHERE BD6_FILIAL  = '"+xFilial("BD6")+"' AND "
cSQL += "BD6_OPEUSR||BD6_CODEMP||BD6_MATRIC||BD6_TIPREG  = '"+cMatric+"' AND "
cSQL += "BD6_DATPRO >= '"+DTOS(dDataDe)+"' AND "
cSQL += "BD6_DATPRO <= '"+DTOS(dDataAte)+"' AND "
cSQL += "BD6_SITUAC = '1' AND "
//	cSQL += "BD6_FASE = '4' AND "
cSQL += "BD6.D_E_L_E_T_ <> '*' "
cSQL += " ORDER BY BD6_DATPRO, BD6_NOMRDA"
memowrit("C:\temp\CABR007.SQL",cSQL)

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
While !cArqTrab->(Eof())
//--------------------------------------------------------------------------------------------------------------------------------------------------------------------
//        Data      Prestador Serviço                   Qtde  Procedimento                                                       Valor             Valor           Fatura
//     Atendimento                                            Código   Descrição                                                 Co-Part.          Pagam.  Fase   Cobranca
//--------------------------------------------------------------------------------------------------------------------------------------------------------------------
//     25/06/07     LAB BRONSTEIN                       1,00  80280340     HOMOCISTEINA, DOSAGEM NO SANGUE                           0,00           54,73   Sim      Nao
//                                                                                                                                         999,999,999.99
//     25/06/07     LAB BRONSTEIN                       1,00  28010175     ACIDO URICO                                               1,04            3,48   4   PLS017937 DP 
//0....+....1....+....2....+....3....+....4....+....5....+....6....+....7....+....8....+....9....+....0....+....1....+....2....+....3....+....4....+....5....+....6....

	If li > 58
		cabec(cTitulo,cabec1,cabec2,nomeprog,tamanho,nTipo)
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Imprime Matrícula e Nome Usuário                                         ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		@ li,000 PSAY "Matrícula    : "+cArqTrab->(BD6_OPEUSR+"."+BD6_CODEMP+"."+BD6_MATRIC+"."+BD6_TIPREG+"."+BD6_DIGITO)
		li++
		@ li,000 PSay "Nome Usuário : "+cArqTrab->BD6_NOMUSR
		li++
		@ li,000 PSay "Período: " +DtoC(dDataDe)+ " a " +DtoC(dDataAte)
		li++
		@ li,000 PSAY Replicate("-",220)
		li++
      @ li, 005 pSay "   Data      Prestador Serviço               Qtde  Procedimento                                                       Valor             Valor           Fatura"
//         Data      Prestador Serviço               Qtde      Procedimento                                                  Valor             Valor           Fatura"
		li++
      @ li, 005 pSay "Atendimento                                        Código   Descrição                                                 Co-Part.          Pagam.  Paga   Cobrada"
//      Atendimento                                          Código   Descrição                                              Co-Part.          Pagam.  Fase   Cobranca"
		li++
		@ li, 000 PSAY Replicate("-",220)
	End
	li++
	@ li, 005 PSay cArqTrab->BD6_DATPRO  // Data do atendimento
	@ li, 018 PSay cArqTrab->BD6_NOMRDA // Nome da Prestador de Serviço - RDA
	@ li, 050 PSay cArqTrab->BD6_QTDPRO Picture PesqPict("BD6","BD6_QTDPRO")  //Qtde do Procedimento
	@ li, 060 PSay Transform(cArqTrab->BD6_CODPRO,PesqPict("BD6","BD6_CODPRO")) //Código Procedimento
	@ li, 073 PSay cArqTrab->BD6_DESPRO // Descrição Procedimento
	@ li, 121 PSay Transform(cArqTrab->BD6_VLRTPF,"@E 999,999,999.99")//Valor Co-Participação
	@ li, 132 PSay Transform(cArqTrab->BD6_VLRPAG,"@E 999,999,999.99")//Valor Pagamento
	If cArqTrab->BD7VLRPAG > 0
   	@ li, 154 PSay "Sim"   //cArqTrab->BD6_FASE
   Else
   	@ li, 154 PSay "Nao"   //cArqTrab->BD6_FASE
   EndIf	
//	If !Empty(cArqTrab->BD6_NUMSE1) -- altamiro em 14/06/2012
    If !Empty(cArqTrab->BD6_NUMTIT)
		@ li, 163 PSay cArqTrab->(bd6_prefix+bd6_numtit+bd6_tiptit)
//		@ li, 163 PSay "Sim"
    Else
      	@ li, 163 PSay "Nao"   //cArqTrab->BD6_FASE
	EndIf
	nTotCo  += cArqTrab->BD6_VLRTPF
	nTotPag += cArqTrab->BD6_VLRPAG
	cArqTrab->(DbSkip())
Enddo
li++
@ li, 000 PSAY Replicate("-",220)
li++
@ li, 005 PSay "Total Co-Participação -->"
@ li, 116 PSay Transform(nTotCo ,"@E 999,999,999.99")//Valor Total Co-Participação
@ li, 132 PSay Transform(nTotPag,"@E 999,999,999.99")//Valor Total Pagamento
If li != 80
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Imprime rodape do relatorio...                                     ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	roda(cbcont,cbtxt,tamanho)
End
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

dbSelectArea("SX1")
SX1->(DbSetOrder(1))
If ! SX1->(DbSeek("CABR07    01"))
	SX1->(RecLock("SX1",.T.))
	SX1->X1_F3      := "BY2PLS"
	SX1->X1_GRUPO   := "CABR07    "
	SX1->X1_ORDEM   := "01"
	SX1->X1_PERGUNT := "Matrícula"
	SX1->X1_VARIAVL := "mv_ch1"
	SX1->X1_TIPO    := "C"
	SX1->X1_TAMANHO := 16
	SX1->X1_GSC     := "G"
	SX1->X1_VAR01   := "mv_par01"
	SX1->X1_DEF01   := ""
	SX1->X1_DEF02   := ""
	SX1->X1_DEF03   := ""
	SX1->X1_DEF04   := ""
	SX1->X1_DEF05   := ""
	SX1->(MsUnLock())
Endif
If ! SX1->(DbSeek("CABR07    02"))
	SX1->(RecLock("SX1",.T.))
	SX1->X1_F3      := ""
	SX1->X1_GRUPO   := "CABR07    "
	SX1->X1_ORDEM   := "02"
	SX1->X1_PERGUNT := "Data de ?"
	SX1->X1_VARIAVL := "mv_ch2"
	SX1->X1_TIPO    := "D"
	SX1->X1_TAMANHO := 8
	SX1->X1_GSC     := "G"
	SX1->X1_VAR01   := "mv_par02"
	SX1->X1_DEF01   := ""
	SX1->X1_DEF02   := ""
	SX1->X1_DEF03   := ""
	SX1->X1_DEF04   := ""
	SX1->X1_DEF05   := ""
	SX1->(MsUnLock())
Endif
If ! SX1->(DbSeek("CABR07    03"))
	SX1->(RecLock("SX1",.T.))
	SX1->X1_F3      := ""
	SX1->X1_GRUPO   := "CABR07    "
	SX1->X1_ORDEM   := "03"
	SX1->X1_PERGUNT := "Data Até ?"
	SX1->X1_VARIAVL := "mv_ch3"
	SX1->X1_TIPO    := "D"
	SX1->X1_TAMANHO := 8
	SX1->X1_GSC     := "G"
	SX1->X1_VAR01   := "mv_par03"
	SX1->X1_DEF01   := ""
	SX1->X1_DEF02   := ""
	SX1->X1_DEF03   := ""
	SX1->X1_DEF04   := ""
	SX1->X1_DEF05   := ""
	SX1->(MsUnLock())
Endif
//Aadd(aRegs,{cPerg,"04","Rede Referenciada:      ","","","MV_CH4","N",01,0,0,"C","","Mv_Par04","Plena","","","","","Maximus","","","","","Executiva","","","","","","","","","","","","","","U31",""})

//PlsVldPerg( aRegs )

Return