#INCLUDE "rwmake.ch"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNOVO5     บ Autor ณ AP6 IDE            บ Data ณ  09/04/13   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Codigo gerado pelo AP6 IDE.                                บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP6 IDE                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/

User Function CABRGLO1


//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Declaracao de Variaveis                                             ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

Local cDesc1         := "Este programa tem como objetivo imprimir relatorio "
Local cDesc2         := "de acordo com os parametros informados pelo usuario."
Local cDesc3         := "Resumo de anแlise de Recurso"
Local cPict          := ""
Local titulo       := "Resumo de anแlise de Recurso"
Local nLin         := 80

Local Cabec1       := ""
Local Cabec2       := ""
Local imprime      := .T.
Local aOrd := {}
Private lEnd         := .F.
Private lAbortPrint  := .F.
Private CbTxt        := ""
Private limite           := 220
Private tamanho          := "G"
Private nomeprog         := "CABRGLO1" // Coloque aqui o nome do programa para impressao no cabecalho
Private nTipo            := 18
Private aReturn          := { "Zebrado", 1, "Administracao", 2, 2, 1, "", 1}
Private nLastKey        := 0
Private cPerg       := "XA1"
Private cbtxt      := Space(10)
Private cbcont     := 00
Private CONTFL     := 01
Private m_pag      := 01
Private wnrel      := "NOME" // Coloque aqui o nome do arquivo usado para impressao em disco
Private cEnt       := chr(13)+chr(10)

Private cString := "XA1"

PutSX1(cPerg,"01","Operadora?"  ,"" ,"" , "MV_CH1" , "C" ,TamSX3("XA1_OPECRE")[1],0,0,"G","","B89PLS","","S","MV_PAR01","","","","","","","","","","","","","","","","",{},{},{},"")
PutSX1(cPerg,"02","RDA?"        ,"" ,"" , "MV_CH2" , "C" ,TamSX3("XA1_CODRDA")[1],0,0,"G","","BASPLS","","S","MV_PAR02","","","","","","","","","","","","","","","","",{},{},{},"")
PutSX1(cPerg,"03","Recurso de?" ,"" ,"" , "MV_CH3" , "C" ,TamSX3("XA1_CODQUE")[1],0,0,"G","","","","S","MV_PAR03","","","","","","","","","","","","","","","","",{},{},{},"")
PutSX1(cPerg,"04","Recurso ate?","" ,"" , "MV_CH4" , "C" ,TamSX3("XA1_CODQUE")[1],0,0,"G","","","","S","MV_PAR04","","","","","","","","","","","","","","","","",{},{},{},"")
PutSx1(cPerg,"05","Data de ?"   ,"" ,"" , "mv_ch5" , "D" ,08,0,0,"G","","","","S","mv_par05" ,"","","","","","","","","","","","","","","","","","","","")
PutSx1(cPerg,"06","Data ate ?"  ,"" ,"" , "mv_ch6" , "D" ,08,0,0,"G","","","","S","mv_par06" ,"","","","","","","","","","","","","","","","","","","","")
Putsx1(cPerg,"07","Status"      ,"" ,"" , "MV_CH7" , "N" ,01,0,0,"C","",""      ,"","" ,"MV_PAR07","1-Em Negocia็ใo"  ,"","","","2-Aceito"    ,"","","3-Negado"      ,"","","4-Todos" ,"","")
Putsx1(cPerg,"08","Tipo"        ,"" ,"" , "MV_CH8" , "N" ,01,0,0,"C","",""      ,"","" ,"MV_PAR08","1-Simples"  ,"","","","2-Detalhado"    ,"","","","","","","","")

dbSelectArea("XA1")
dbSetOrder(2)


pergunte(cPerg,.T.)

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Monta a interface padrao com o usuario...                           ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

wnrel := SetPrint(cString,NomeProg,cPerg,@titulo,cDesc1,cDesc2,cDesc3,.F.,aOrd,.F.,Tamanho,,.F.,.F.,,,.T.)

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
ฑฑบFuno    ณRUNREPORT บ Autor ณ AP6 IDE            บ Data ณ  09/04/13   บฑฑ
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
local aStatusXA1 := GetStatus("XA1_STATUS")
local aStatusXA2 := GetStatus("XA2_STATUS")
local aStatusMOV := GetStatus("XA2_ORIMOV")
Local cQuery := ""
Local nTotRec := 0
Local nTotPag := 0

If MV_PAR08 == 1
	cQuery := " SELECT DISTINCT XA1.XA1_OPECRE, XA1.XA1_DESCRE, XA1.XA1_CODRDA, XA1.XA1_DESRDA, SUM(XA2_VLRCOB) AS VALOR, SUM(XA2_VLRREC) AS REC " +cEnt
Else
	cQuery := " SELECT DISTINCT XA1.XA1_FILIAL, XA1.XA1_CODQUE, XA1.XA1_OPECRE, XA1.XA1_DESCRE, XA1.XA1_CODRDA, XA1.XA1_DESRDA, XA1.XA1_STATUS, XA1.XA1_DTENVI, SUM(XA2_VLRCOB) AS VALOR, SUM(XA2_VLRREC) AS REC " +cEnt
EndIf
cQuery += " FROM "+RetSQLName("XA1")+" XA1 " +cEnt
cQuery += " INNER JOIN "+RetSQLName("XA2")+" XA2 " +cEnt
cQuery += "        ON XA2.XA2_FILIAL = XA1.XA1_FILIAL " +cEnt
cQuery += "        AND XA2.XA2_CODQUE  = XA1.XA1_CODQUE " +cEnt
cQuery += "        AND XA2.D_E_L_E_T_ = XA1.D_E_L_E_T_ " +cEnt
cQuery += "        AND XA2.XA2_STATUS IN" +IIF(MV_PAR07==4,"('1','2','3')","('"+cValToChar(MV_PAR07)+"')")+" "+cEnt
cQuery += " WHERE XA1.D_E_L_E_T_ = '' " +cEnt
cQuery += "        AND XA1.XA1_OPECRE = '"+MV_PAR01+"' " +cEnt
If !Empty(MV_PAR02)
	cQuery += "        AND XA1.XA1_CODRDA = '"+MV_PAR02+"' " +cEnt
EndIf
cQuery += "        AND XA1.XA1_CODQUE BETWEEN '"+MV_PAR03+"' AND '"+MV_PAR04+"' " +cEnt
cQuery += "        AND XA1.XA1_DTENVI BETWEEN '"+DTOS(MV_PAR05)+"' AND '"+DTOS(MV_PAR06)+"' " +cEnt
If MV_PAR08 == 1
	cQuery += "  GROUP BY XA1.XA1_OPECRE, XA1.XA1_DESCRE, XA1.XA1_CODRDA, XA1.XA1_DESRDA "+cEnt
Else
	cQuery += "  GROUP BY XA1.XA1_FILIAL, XA1.XA1_CODQUE, XA1.XA1_OPECRE, XA1.XA1_DESCRE, XA1.XA1_CODRDA, XA1.XA1_DESRDA, XA1.XA1_STATUS, XA1.XA1_DTENVI "+cEnt
EndIf
cQuery += " ORDER BY XA1.XA1_OPECRE, XA1.XA1_CODRDA "


//Aviso("QUERY",cQuery,{"ok"})

cQuery := ChangeQuery(cQuery)

If Select("TRB") > 0
	dbSelectArea("TRB")
	TRB->(dbCloseArea())
EndIf

dbUseArea(.T.,"TOPCONN",TCGENQRY(,,cQuery),"TRB",.F.,.T.)

dbSelectArea("TRB")
SetRegua(RecCount())
TRB->(dbGoTop())

While TRB->(!EOF())
	
	If lAbortPrint
		@nLin,00 PSAY "*** CANCELADO PELO OPERADOR ***"
		Exit
	Endif
	
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Impressao do cabecalho do relatorio. . .                            ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	
	If nLin > 55 // Salto de Pแgina. Neste caso o formulario tem 55 linhas...
		Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
		nLin := 6
		@nLin,00 PSAY "Operadora:  "+TRB->XA1_OPECRE+" - "+TRB->XA1_DESCRE
		nLin++
		@nLin,00 PSAY __PrtThinLine()
		nLin++
	Endif
	
	@nLin,05 PSAY "RDA: "+TRB->XA1_CODRDA+" - "+TRB->XA1_DESRDA
	nLin++
	@nLin,05 PSAY Replicate("-", limite-05)
	nLin++
	If !(MV_PAR08 == 1)
		@nLin,10 PSAY "Recurso:" +TRB->XA1_CODQUE
		@nLin,50 PSAY "Data do Recurso: "+DTOC(STOD(TRB->XA1_DTENVI))
		@nLin,90 PSAY "Status: "+aStatusXA1[val(TRB->XA1_STATUS)]
		nLin++
	EndIf
	@nLin,10 PSAY "Valor do Recurso:"+Transform(TRB->VALOR, PesqPict("XA2","XA2_VLRCOB"))
	@nLin,50 PSAY "Valor Reconsiderado: "+Transform(TRB->REC, PesqPict("XA2","XA2_VLRREC"))
	nTotRec +=TRB->VALOR
	nTotPag +=TRB->REC
	nLin++
	
	If !(MV_PAR08 == 1)
		cQuery := " SELECT XA2.XA2_SEQQUE, XA2.XA2_CODLDP, XA2.XA2_CODPEG, XA2.XA2_NUMERO, XA2.XA2_SEQUEN, XA2.XA2_NUMIMP, XA2.XA2_CODPAD, XA2.XA2_CODPRO, XA2_ORIMOV," +cEnt
		cQuery += "        XA2.XA2_DESPRO, XA2.XA2_DESQUE, XA2.XA2_STATUS, XA2.XA2_DESNEG, XA2.XA2_DATACO, XA2.XA2_QTDPRO, XA2.XA2_VLRCOB, XA2.XA2_VLRREC, XA2_SALDO " +cEnt
		cQuery += " FROM "+RetSQLName("XA2")+" XA2 " +cEnt
		cQuery += " WHERE  XA2.D_E_L_E_T_ = '' " +cEnt
		cQuery += "        AND XA2.XA2_FILIAL = '"+TRB->XA1_FILIAL+"' " + cEnt
		cQuery += "        AND XA2.XA2_CODQUE = '"+TRB->XA1_CODQUE+"' " + cEnt
		cQuery += "        AND XA2.XA2_STATUS IN" +IIF(MV_PAR07==4,"('1','2','3')","('"+cValToChar(MV_PAR07)+"')")+" "+cEnt
		cQuery := ChangeQuery(cQuery)
		
		If Select("TRB2") > 0
			dbSelectArea("TRB2")
			TRB2->(dbCloseArea())
		EndIf
		
		dbUseArea(.T.,"TOPCONN",TCGENQRY(,,cQuery),"TRB2",.F.,.T.)
		
		dbSelectArea("TRB2")
		TRB2->(dbGoTop())
		
		If TRB2->(!EOF())
			nLin++
			@nLin,10 PSAY "Itens"
			nLin++
			@nLin,10 PSAY Replicate("-", limite-10)
			nLin++
		EndIf
		
		While TRB2->(!EOF())
			
			If nLin > 55 // Salto de Pแgina. Neste caso o formulario tem 55 linhas...
				Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
				nLin := 6
				@nLin,00 PSAY "Operadora:  "+TRB->XA1_OPECRE+" - "+TRB->XA1_DESCRE
				nLin++
				@nLin,00 PSAY __PrtThinLine()
				nLin++
				nLin++
				@nLin,10 PSAY "Itens"
				nLin++
				@nLin,10 PSAY Replicate("-", limite-10)
				nLin++
			Endif
			
			@nLin,15 PSAY "Item do Recurso.: "+TRB2->XA2_SEQQUE
			@nLin,40 PSAY "Data de acordo.: "+DTOC(STOD(TRB2->XA2_DATACO))
			@nLin,70 PSAY "Status: "+aStatusXA2[val(TRB2->XA2_STATUS)]
			@nLin,103 PSAY "Valor Glosado:"+Transform(TRB2->XA2_VLRCOB, PesqPict("XA2","XA2_VLRCOB"))
			@nLin,135 PSAY "Valor Reconsiderado:"+Transform(TRB2->XA2_VLRREC, PesqPict("XA2","XA2_VLRREC"))
			@nLin,171 PSAY "Saldo do Item:"+Transform(TRB2->XA2_SALDO , PesqPict("XA2","XA2_SALDO"))
			nLin++
			@nLin,15 PSAY "Local de Dig: "+TRB2->XA2_CODLDP
			@nLin,40 PSAY "Cod PEG: "+TRB2->XA2_CODPEG
			@nLin,70 PSAY "N๚mero:"+TRB2->XA2_NUMERO
			@nLin,103 PSAY "Sequ๊ncia:"+TRB2->XA2_SEQUEN
			@nLin,135 PSAY "Num Imp.:"+TRB2->XA2_NUMIMP
			nLin++
			@nLin,15 PSAY "Procedimento: "+alltrim(TRB2->XA2_CODPRO)+" - "+TRB2->XA2_DESPRO
			@nLin,135 PSAY "Quant. "+cValToChar(TRB2->XA2_QTDPRO)
			nLin++
			@nLin,15 PSAY "Motivo: "+TRB2->XA2_DESQUE
			nLin++
			@nLin,15 PSAY "Parecer: "+TRB2->XA2_DESNEG
			
			
			nLin+=2
			TRB2->(dbSkip())
		EndDo
		
	EndIf
	nLin+=3
	
	TRB->(dbSkip()) // Avanca o ponteiro do registro no arquivo
EndDo
If MV_PAR08 == 1
	nLin++
	@nLin,10 PSAY __PrtThinLine()
	nLin++
	@nLin,10 PSAY "Total dos Recursos:"+Transform(nTotRec, PesqPict("XA2","XA2_VLRCOB"))
	@nLin,50 PSAY "Total Reconsiderado: "+Transform(nTotPag, PesqPict("XA2","XA2_VLRREC"))
EndIf


//Aviso("QUERY",cQuery,{"ok"})
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


Static Function GetStatus(cCampo)

Local aArea  := GetArea()
Local cCombo := ""
Local aCombo := {}

dbSelectArea("SX3")

dbSetOrder(2)

If dbSeek( cCampo )
	
	cCombo := X3Cbox()
	aCombo := Separa(cCombo,";")
	
EndIf

RestArea(aArea)

Return aCombo



//cQuery += "        XA2.XA2_SEQQUE, XA2.XA2_CODLDP, XA2.XA2_CODPEG, XA2.XA2_NUMERO, XA2.XA2_SEQUEN, XA2.XA2_NUMIMP, XA2.XA2_CODPAD, XA2.XA2_CODPRO," +cEnt
//cQuery += "        XA2.XA2_DESPRO, XA2.XA2_DESQUE, XA2.XA2_STATUS, XA2.XA2_DESNEG, XA2.XA2_DATACO, XA2.XA2_QTDPRO, XA2.XA2_VLRCOB, XA2.XA2_VLRREC " +cEnt
//cQuery += "        AND XA2.XA2_STATUS IN"+IIF(MV_PAR07==4,"('0','1','2')","('"+cValToChar(MV_PAR07-1)+"')" +cEnt



