#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'RWMAKE.CH'
#INCLUDE 'FONT.CH'
#INCLUDE 'COLORS.CH'
#INCLUDE "TopConn.ch"

#DEFINE c_ent CHR(13)+CHR(10)

User Function Cabr019

/*ÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±± Declaração de cVariable dos componentes                                 ±±
Ù±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*/

Private oFntAri13N :=  TFont():New( "Arial"       ,,-13,,.F.,,,,,.F. )
Private oFntAri11N :=  TFont():New( "Arial"       ,,-11,,.F.,,,,,.F. )
Private dDataIni   := cTod("  /  /  ")
Private dDataFim   := cTod("  /  /  ")
Private dPgtoIni   := cTod("  /  /  ")
Private dPgtoFim   := cTod("  /  /  ")
Private dPrevIni   := cTod("  /  /  ")
Private dPrevFim   := cTod("  /  /  ")
Private oRadio
Private nRadio1   
Private nRadio2   
Private aButtons   := {}
Private bOk        := {|| fMontaRel()}
Private bCancel    := {|| oDlg1:End()}
Private cSituaca   := "1"
Private nOrdem     := 1
Private aSituaca   := {"Protocolado","Calculado","Liberado","Cancelados","Pgto Eletronico","Manuais","Todos Pagos"}
Private _cInd      := CriaTrab(Nil, .F.)
Private cOrdem     := " "

/*ÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±± Definicao do Dialog e todos os seus componentes.                        ±±
Ù±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*/

oDlg1 := TDialog():New(095,274,460,670,"Relação de Pedidos de Reembolso Por Situação",,,,,,,,,.T.)
oDlg1:bStart := {||(EnchoiceBar(oDlg1,bOk,bCancel,,aButtons))}

oSay01 := TSay():New(034,012,{|| "Data Inicio"                           },oDlg1,,oFntAri13N,,,,.T.,,,035,10)
oSay02 := TSay():New(034,096,{|| "Data Fim   "                           },oDlg1,,oFntAri13N,,,,.T.,,,035,10)
oSay03 := TSay():New(078,012,{|| "Data Inicio"                           },oDlg1,,oFntAri13N,,,,.T.,,,035,10)
oSay04 := TSay():New(078,096,{|| "Data Fim   "                           },oDlg1,,oFntAri13N,,,,.T.,,,035,10)
oSay05 := TSay():New(122,012,{|| "Data Inicio"                           },oDlg1,,oFntAri13N,,,,.T.,,,035,10)
oSay06 := TSay():New(122,096,{|| "Data Fim   "                           },oDlg1,,oFntAri13N,,,,.T.,,,035,10)
oSay07 := TSay():New(150,012,{|| "Situação   "                           },oDlg1,,oFntAri13N,,,,.T.,,,035,10)

oGet01 := TGet():New(034,050,bSetGet(dDataIni  ),oDlg1,035,10,""    ,{||.T.             },,,oFntAri13N,,,.T.,,,{||.T.},,,,.F.,,"","dDataIni"  )
oGet02 := TGet():New(034,128,bSetGet(dDataFim  ),oDlg1,035,10,""    ,{||.T.             },,,oFntAri13N,,,.T.,,,{||.T.},,,,.F.,,"","dDataFim"  )
oGet03 := TGet():New(078,050,bSetGet(dPgtoIni  ),oDlg1,035,10,""     ,{||.T.             },,,oFntAri13N,,,.T.,,,{||.T.},,,,.F.,,"","dPgtoIni" )
oGet04 := TGet():New(078,128,bSetGet(dPgtoFim  ),oDlg1,035,10,""     ,{||.T.             },,,oFntAri13N,,,.T.,,,{||.T.},,,,.F.,,"","dPgtoFim" )
oGet05 := TGet():New(122,050,bSetGet(dPrevIni  ),oDlg1,035,10,""    ,{||.T.             },,,oFntAri13N,,,.T.,,,{||.T.},,,,.F.,,"","dPrevIni"  )
oGet06 := TGet():New(122,128,bSetGet(dPrevFim  ),oDlg1,035,10,""    ,{||.T.             },,,oFntAri13N,,,.T.,,,{||.T.},,,,.F.,,"","dPrevFim"  )

oGrp1 := TGROUP():New (018, 008, 060, 188, OemToAnsi ("Periodo do Pedido"), oDlg1, 0, 0, .T., .T.)
oGrp2 := TGROUP():New (062, 008, 104, 188, OemToAnsi ("Data de Pagamento"), oDlg1, 0, 0, .T., .T.)
oGrp3 := TGROUP():New (106, 008, 148, 188, OemToAnsi ("Data Prevista de Pagamento"), oDlg1, 0, 0, .T., .T.)

oSituaca := TComboBox():New( 160,012,bSetGet(cSituaca),aSituaca ,080,10 ,oDlg1,,,{||fAtuBrw()},,,.T.,oFntAri13N,,,{||.T.})
           

oGrp5 := TGROUP():New (150, 105, 180, 188, OemToAnsi ("Ordem de Saida" ), oDlg1, 0, 0, .T., .T.)
@ 156,125 RADIO oRadio VAR nRadio1 3D SIZE 60, 11 PROMPT " Plano / Matricula"," Plano / Protocolo" of oDlg1 PIXEL 

oDlg1:Activate(,,,.T.)

Return

*************************
Static Function fAtuBrw()
*************************
If Upper(cSituaca) $ Upper(("Pgto Eletronico|Manuais|Todos Pagos"))
   oGet03:bWhen  := {|| .T.}
   oGet04:bWhen  := {|| .T.}
Else
   oGet03:bWhen  := {|| .F.}
   oGet04:bWhen  := {|| .F.}
Endif
oSituaca:Refresh()
Odlg1:Refresh()
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABR019 ºAutor   Wellington Tonieto  º Data ³  18/08/08     º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³                                                            º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function fMontaRel()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracao de Variaveis                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

Local cDesc1         := "Este programa tem como objetivo imprimir relatorio "
Local cDesc2         := "de acordo com os parametros informados pelo usuario."
Local cDesc3         := "Relação de pedidos de de reebolso  "
Local cPict          := ""
Local imprime        := .T.
Local aOrd           := {}
Private titulo         := "Relação de Pedidos de reebolso Por Situação "
Private nLin           := 80
Private Cabec1         := " P E R I O D O :  " 
Private Cabec2         := " "
Private aVetEmp      := {}
Private aVetFil      := {}
Private aTabEmp      := {}
Private aVetAviso    := {}
Private lEnd         := .F.
Private lAbortPrint  := .F.
Private CbTxt        := ""
Private limite       := 220
Private tamanho      := "G"
Private nomeprog     := "CABR019" // Coloque aqui o nome do programa para impressao no cabecalho
Private nTipo        := 18
Private aReturn      := { "Zebrado", 1, "Administracao", 2, 2, 1, "", 1}
Private nLastKey     := 0
Private cPerg        := "MMX058"
Private cbtxt        := Space(10)
Private cbcont       := 00
Private CONTFL       := 01
Private m_pag        := 01
Private wnrel        := "CABR019" // Coloque aqui o nome do arquivo usado para impressao em disco
Private cString      := "BKD" 
Private cCabRel      := "Protocolo       Associado                               CPF          Banco     Agencia    Conta     Data Pedido   Data Previsao   Data Pgto       Documento                Vl.Pedido    Vl. Reebolso "          

dbSelectArea(cString)
dbSetOrder(1)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta a interface padrao com o usuario...                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

wnrel := SetPrint(cString,NomeProg,cPerg,@titulo,cDesc1,cDesc2,cDesc3,.T.,aOrd,.T.,Tamanho,,.T.)

If nLastKey == 27
	Return
Endif

SetDefault(aReturn,cString)

If nLastKey == 27
   Return
Endif

nTipo := If(aReturn[4]==1,15,18)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Processamento. RPTSTATUS monta janela com a regua de processamento. ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

RptStatus({|| RunReport(Cabec1,Cabec2,Titulo,nLin) },Titulo)
Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFun‡„o    ³RUNREPORT º Autor ³ AP6 IDE            º Data ³  13/08/08   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescri‡„o ³ Funcao auxiliar chamada pela RPTSTATUS. A funcao RPTSTATUS º±±
±±º          ³ monta a janela com a regua de processamento.               º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Programa principal                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function RunReport(Cabec1,Cabec2,Titulo,nLin)

Local nOrdem
Local cAlias      := "_TMP"
Local cQuery      := " "
Private lPgto       := .F. 


If Upper(cSituaca) $ ("PROTOCOLADO|CANCELADO")
 
   If nOrdem == 1
      cOrdem := "PLANO+MATRICULA "
   Else
      cOrdem := "PLANO+PROTOCOLO "  
   Endif
  
  cQuery := " SELECT * FROM ( 
  cQuery += "     SELECT A1_COD CLIENTE,A1_NOME NOME ,A1_CGC CGC,ZZQ_SEQUEN PROTOCOLO , A1_XBANCO BANCO, "
  cQuery += "     A1_XAGENC AGENCIA,A1_XCONTA CONTA,A1_XDGCON DIGITO,ZZQ_DATDIG DAT_DIG ,ZZQ_DATPRE DAT_PREV,ZZQ_VLRTOT VL_PAGO , 0 VALOR ," 
  cQuery += "     ZZQ_FILIAL,ZZQ_CODINT,ZZQ_CODEMP,ZZQ_MATRIC,ZZQ_TIPREG , ZZQ_SEQUEN "
  cQuery += "             
  cQuery += "     FROM " + RetSqlName("ZZQ") + " ZZQ , "
  cQuery +=                RetSqlName("SA1") + " SA1  "  
  cQuery += "     WHERE " 
  cQuery += "     ZZQ.D_E_L_E_T_ = ' ' AND "
  cQuery += "     SA1.D_E_L_E_T_ = ' ' AND "
  cQuery += "     ZZQ.ZZQ_FILIAL = SA1.A1_FILIAL   AND "
  cQuery += "     ZZQ.ZZQ_CODCLI = SA1.A1_COD      AND "
  cQuery += "     ZZQ.ZZQ_LOJCLI = SA1.A1_LOJA         "    
  
  If !empty(dDataFim)
     cQuery += " AND ZZQ.ZZQ_DATDIG BETWEEN '" + dTos(dDataIni) + "' AND '" + dTos(dDataFim) + "'"
  Endif
  
  If !empty(dPrevFim)
     cQuery += " AND ZZQ.ZZQ_DATPRE BETWEEN '" + dTos(dPrevIni) + "' AND '" + dTos(dPrevFim) + "'"
  Endif
  
  cQuery += " ) TAB1 , (SELECT BA1_FILIAL ,BA1_CODEMP EMPRESA ,BA1_MATRIC MATRICULA, BA1_CODPLA PLANO , BA1_VERSAO VERSAO," 
  cQuery += "          BA1_CODINT OPERADORA,BA1_TIPREG TIPO "
  cQuery += "          FROM " + RetSqlName("BA1") + " ) BA1 "
  cQuery += " WHERE " 
  cQuery += " TAB1.ZZQ_FILIAL = BA1.BA1_FILIAL  AND "
  cQuery += " TAB1.ZZQ_CODINT = BA1.OPERADORA   AND "
  cQuery += " TAB1.ZZQ_CODEMP = BA1.EMPRESA     AND "
  cQuery += " TAB1.ZZQ_MATRIC = BA1.MATRICULA   AND "
  cQuery += " TAB1.ZZQ_TIPREG = BA1.TIPO " 
  
  If nOrdem == 1
     cQuery += " ORDER BY PLANO , ZZQ_MATRIC "
  Else
     cQuery += " ORDER BY PLANO , ZZQ_SEQUEN "
  Endif

Else 
   
   
   If nOrdem == 1
      cOrdem := "PLANO+MATRICULA "
   Else
      cOrdem := "PLANO+PROTOCOLO "  
   Endif
  
   cQuery := " SELECT * FROM ( " 
	cQuery += " SELECT * FROM " 
	cQuery += " ( SELECT A1_COD CLIENTE,A1_NOME NOME ,A1_CGC CGC , A1_XBANCO BANCO,A1_XAGENC AGENCIA,A1_XCONTA CONTA ,A1_XDGCON DIGITO, "
	cQuery += " BKD_FILIAL, BKD_CODINT, BKD_CODEMP,BKD_MATRIC,BKD_TIPREG , BKD_CODRBS PROTOCOLO , BKD_DATDIG DAT_DIG , "
	cQuery += " BKD_DATVEN DAT_PREV,BKD_VLRREM VALOR , BKD_VLRPAG VL_PAGO , BKD_CHVSE1  "
	cQuery += " FROM " + RetSqlName("BKD") + " BKD ,  " + RetSqlName("SA1") + " SA1 " 
	cQuery += " WHERE BKD.D_E_L_E_T_ = ' ' AND   SA1.D_E_L_E_T_ = ' '  AND  "     
   cQuery += " BKD.BKD_FILIAL = SA1.A1_FILIAL   AND "
   cQuery += " BKD.BKD_YCDCLI = SA1.A1_COD      AND " 
   cQuery += " BKD.BKD_YLJCLI = SA1.A1_LOJA         "
   
   If !Empty(dDataFim)
      cQuery += " AND BKD.BKD_DATDIG BETWEEN  '" + dTos(dDataIni) + "' AND '" + dTos(dDataFim)  + "'" 
	Endif
	
	If !Empty(dPrevFim)
	   cQuery += " AND BKD.BKD_DATVEN BETWEEN  '" + dTos(dPrevIni) + "' AND '" + dTos(dPrevFim)  + "'"
   Endif
    
   If Upper(cSituaca) == "CALCULADO"
      cQuery += " AND BKD_YSITUA = '1' "
   Else
      cQuery += " AND BKD_YSITUA = '2' "
   Endif 

   cQuery += " ) TAB1 , (SELECT BA1_FILIAL ,BA1_CODEMP EMPRESA ,BA1_MATRIC MATRICULA, BA1_CODPLA PLANO , BA1_VERSAO VERSAO," 
   cQuery += "   BA1_CODINT OPERADORA,BA1_TIPREG TIPO "
   cQuery += "   FROM " + RetSqlName("BA1") + " ) BA1 "
   cQuery += " WHERE " 
   cQuery += " TAB1.BKD_FILIAL = BA1.BA1_FILIAL  AND "
   cQuery += " TAB1.BKD_CODINT = BA1.OPERADORA   AND "
   cQuery += " TAB1.BKD_CODEMP = BA1.EMPRESA     AND "
   cQuery += " TAB1.BKD_MATRIC = BA1.MATRICULA   AND "
   cQuery += " TAB1.BKD_TIPREG = BA1.TIPO " 
    
   If nOrdem == 1
     cQuery += " ORDER BY PLANO,BA1.MATRICULA "
   Else
     cQuery += " ORDER BY PLANO,TAB1.PROTOCOLO "
   Endif
   
   cQuery += ") TAB2 "
   If Upper(cSituaca) $ 'MANUAIS|PGTO ELETRONICO|TODOS PAGOS'
      lPgto := .T.
      cQuery += " LEFT OUTER JOIN ( SELECT *  FROM " + RetSqlName("SE2")+ " ) SE2 "
   	cQuery += " ON  Trim(SE2.E2_TITORIG) = Trim(TAB2.BKD_CHVSE1)
   	cQuery += " WHERE SE2.D_E_L_E_T_ = ' '
    	cQuery += " AND SE2.E2_SALDO = 0  "
    	If  Upper(cSituaca) == 'PGTO ELETRONICO' 
      	 cQuery += " AND SE2.E2_NUMBOR <> ' ' "
 //         If !Empty(dPgtoFim)
 //            cQuery += " AND SE2.E2_BAIXA  BETWEEN '" + dTos(dPgtoIni) + "' AND '" + dTos(dPgtoFim) + "'"
 //         Endif
      ElseIf Upper(cSituaca) == 'MANUAIS'
         cQuery += " AND ( SE2.E2_NUMBCO <> ' ' OR SE2.E2_NUMBOR <> ' ' ) "
         cQuery += " AND SE2.E2_BAIXA  =  ' '  "
      Endif
      If !Empty(dPgtoFim)
          cQuery += " AND SE2.E2_BAIXA  BETWEEN '" + dTos(dPgtoIni) + "' AND '" + dTos(dPgtoFim) + "'"
      Endif   
   Endif
Endif    

If Select(cAlias) > 0
   DbSelectArea(cAlias)
   (cAlias)->(DbCloseArea())
Endif
			
DbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAlias,.T.,.T.)

cTmp2 := CriaTrab(NIL,.F.) //CriaTrab(aStruct,.T.)
Copy To &cTmp2

dbCloseArea()
dbUseArea(.T.,,cTmp2,cAlias,.T.)

cCodPlan := (cAlias)->PLANO 
If Empty(cCodPlan)
   While !Eof() .And. cCodPlan = (cAlias)->PLANO
     	   DbSelectArea("BA3")
       	DbSetOrder(1)
	       If DbSeek(xFilial("BA3")+(cAlias)->(operadora+Empresa+Matricula))
	          RecLock(cAlias,.F.)
	          (cAlias)->PLANO     := BA3->BA3_CODPLA
	          (cAlias)->OPERADORA := BA3->BA3_CODINT
	          (cAlias)->VERSAO    := BA3->BA3_VERSAO
	          MsUnlock()
	       Endif
	   DbSelectArea(cAlias)
	  DbSkip()
	Enddo
Endif

fImprime(cAlias)

Return

********************************
Static Function fImprime(cAlias)
********************************

DbSelectArea(cAlias)
IndRegua (cAlias ,_cInd ,cOrdem,,,OemToAnsi("Selecionando Registros..."))
(cAlias)->(DbGoTop())

nVlTotPd2  := 0
nVlTotRe2  := 0
nTotQtd    := 0

If !Empty(dDataIni) .And. !Empty(dDataFim) 
  Cabec1 += Transform(dDataIni,"@e") + "  Ate  " + Transform(dDataFim,"@e")
ElseIf !Empty(dPgtoIni) .And. !Empty(dPgtoFim) 
  Cabec1  += Transform(dPgtoIni,"@e") + "  Ate  " + Transform(dPgtoFim,"@e")
Else
   Cabec1 += Transform(dPrevIni,"@e") + "  Ate  " + Transform(dPrevFim,"@e")
Endif

While !eof()
			
    //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
   	//³ Impressao do cabecalho do relatorio. . .                            ³
   	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
 
   If nLin > 55 // Salto de Página. Neste caso o formulario tem 55 linhas...
      Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
      nLin := 8
 	Endif

	If lAbortPrint
       @nLin,00 PSAY "*** CANCELADO PELO OPERADOR ***"
   Endif

   // NOME DO PLANO
   cCodInt  := (cAlias)->OPERADORA
   cCodPlan := (cAlias)->PLANO
   cVerPlan := (cAlias)->VERSAO
   
   BI3->(DbSetOrder(1)) 
   BI3->(MsSeek(xFilial("BI3")+cCodInt+cCodPlan+cVerPlan))
   cNomePlan := BI3->BI3_NREDUZ
   cMatPlan  := Alltrim((cAlias)->MATRICULA) + "  " + Alltrim(cNomePlan) 

   @ nLin,000 pSay __PrtLeft(" P L A N O  : " +cCodPlan + " - " + cNomePlan )
   nLin++
   @ nLin, 000 PSAY __PrtFatLine()
   nLin++
   @ nLin, 000 PSAY cCabRel
   nLin++
   @ nLin, 000 PSAY __PrtFatLine()
   nLin++
   
   nTotPl   := 0 
   nVlTotPd := 0
   nVlTotRe := 0
   dDataBx  := cTod("  /  /    ")
   cDocumen := Space(20)
   While !Eof() .And. (cAlias)->Plano  == cCodPlan

	   If nLin > 55 // Salto de Página. Neste caso o formulario tem 55 linhas...
 	      Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
         nLin := 8
   	
   	   @ nLin,000 pSay __PrtLeft(" P L A N O  : " +cCodPlan + " - " + cNomePlan )
           nLin++
		   @ nLin, 000 PSAY __PrtFatLine()
		     nLin++
			@ nLin, 000 PSAY cCabRel
			  nLin++
		   @ nLin, 000 PSAY __PrtFatLine()
			  nLin++
   	Endif

	   nVl_Pedido   := (cAlias)->VL_PAGO
	   
	   If lPgto
	      nVl_reebolso := (cAlias)->E2_VALOR
	      dDataBx      := Stod((cAlias)->E2_BAIXA)
	      cDocumen     := (cAlias)->E2_PREFIXO + " - " +(cAlias)->E2_NUM + " - " + (cAlias)->E2_PARCELA
	   Else
	      nVl_reebolso := (cAlias)->VALOR 
	   Endif
	   
	   @ nLin,000 PSAY (cAlias)->PROTOCOLO
	   @ nLin,015 PSAY Substr((cAlias)->NOME,1,30)
	   @ nLin,055 PSAY substr((cAlias)->CGC,1,14)
	   @ nLin,070 PSAY (cAlias)->BANCO 
	   @ nLin,080 PSAY (cAlias)->AGENCIA
	   @ nLin,090 PSAY Substr((cAlias)->CONTA,1,10)
	   @ nLin,100 PSAY Stod(Alltrim((cAlias)->DAT_DIG ))
	   @ nLin,115 PSAY Stod(Alltrim((cAlias)->DAT_PREV))
      @ nLin,130 PSAY dDataBx
      @ nLin,145 PSAY cDocumen
	   @ nLin,165 PSAY Padl(Transform(nVl_Pedido   ,"@E 999,999,999.99"),15) 
	   @ nLin,180 PSAY Padl(Transform(nVl_reebolso ,"@E 999,999,999.99"),15) 
	   
	   //TOTAIS DO PLANO
	   nTotPl   ++ 
	   nVlTotPd += nVl_Pedido
	   nVlTotRe += nVl_reebolso
	   
	   //TOTAIS DO RELATORIO
	   nTotQtd  ++ 
	   nVlTotPd2  += nVl_Pedido
	   nVlTotRe2  += nVl_reebolso
	   nLin++			
	  
	   dbSelectArea(cAlias)
	   (cAlias)->(dbSkip())
     
     Enddo
     
     @ nLin, 000 PSAY __PrtFatLine()
     nLin += 1
     @ nLin,000 pSay "Total de pedidos do Plano : " + StrZero(nTotPl,6) 
     @ nLin,160 PSAY Padl(Transform(nVlTotPd ,"@E 999,999,999.99"),15) 
     @ nLin,175 pSay Padl(Transform(nVlTotRe ,"@E 999,999,999.99"),15)
     
     nLin += 2
Enddo

@ nLin, 000 PSAY __PrtFatLine()
nLin++
@ nLin,000 pSay "Total Geral dos pedidos   : " + StrZero(nTotQtd,6) 
@ nLin,160 PSAY Padl(Transform(nVlTotPd2 ,"@E 999,999,999.99"),15) 
@ nLin,175 pSay Padl(Transform(nVlTotRe2 ,"@E 999,999,999.99"),15)

nLin+=2

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Finaliza a execucao do relatorio...                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

SET DEVICE TO SCREEN

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Se impressao em disco, chama o gerenciador de impressao...          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

If aReturn[5]==1
   dbCommitAll()
   SET PRINTER TO
   OurSpool(wnrel)
Endif

MS_FLUSH()

Return 
