#include "rwmake.ch"
#include "topconn.ch"
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCABA002   บAutor  ณCesar Dupim         บ Data ณ  18/11/2005 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณGera tabela de saldo diแrio dใs caixinhas a partir da mov_  บฑฑ
ฑฑบ          ณmenta็ใo do arquivo SEU                                     บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Financeiro                                                 บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function CABA002(cCxIni,cCxFin,dIni)
Local cPerg   :="CABA02"
Private oLeTxt
Private MV_PAR01
Private MV_PAR02
Private MV_PAR03
if cCxIni == Nil
	ValidPerg(cPerg)
	pergunte(cPerg,.F.)
	@ 200,01 TO 320,320 DIALOG oLeTxt TITLE OemToAnsi(" Recalculo Saldo Caixinha ")
	@ 02,010 TO 040,153
	@ 10,018 Say "Este programa ira recalcular os saldos das caixinhas "
	@ 18,018 Say "a partir da data informada nos parโmetros "
	//@ 60,090 BMPBUTTON TYPE 13 ACTION SelArq()
	@ 45,048 BMPBUTTON TYPE 05 ACTION pergunte(cPerg,.T.)
	@ 45,083 BMPBUTTON TYPE 01 ACTION Processa({|| AtuSaldo() },"Processando...")
	@ 45,118 BMPBUTTON TYPE 02 ACTION Close(oLeTxt)
	
	Activate Dialog oLeTxt Centered
else
	MV_PAR01:=cCxIni
	MV_PAR02:=cCxFin
	MV_PAR03:=ctod(dIni)
	AtuSaldo()
endif
Return
Static Function AtuSaldo()
Local cQuery  :=""
Local cCaixa  :=""
Local dDtSaldo:=ctod("  /  /  ")
Local nSaldo  :=0
Local aArea   :=GetArea()
Local lGrava  :=.F.
//Limpa registros de saldo do periodo a ser recalculado
cQuery:="DELETE "+RetSqlName("SZ3")
//cQuery:="DELETE SZ3010 "
cQuery+=" WHERE Z3_CAIXA BETWEEN '"+MV_PAR01+"' AND '"+MV_PAR02+"' "
cQuery+="   AND Z3_DTSALDO >= '"+DTOS(MV_PAR03)+"' "
TCSqlExec(cQuery)
//Faz o somat๓rio da movimenta็ใo do dia agrupado por caixinha, no caso de despesa desconsidera
//os valores de despesas do acerto de despesa (EU_NROADIA <> '') uma vez que esses valores jแ foram
//baixados do caixa no momento do adiantamento
cQuery:="SELECT EU_CAIXA, EU_DTDIGIT, SUM(CASE EU_TIPO "
cQuery+="WHEN '00' THEN CASE WHEN EU_NROADIA <> ' ' THEN 0 ELSE EU_VALOR * -1 END " //DESPESA
cQuery+="WHEN '01' THEN EU_VALOR * -1 " // Adiantamento
cQuery+="WHEN '02' THEN EU_VALOR " // Acerto de despesa
cQuery+="WHEN '10' THEN EU_VALOR " // Mov. BancoXCaixinha
cQuery+="WHEN '11' THEN EU_VALOR * -1 " // Mov. CaixinhaXBanco
cQuery+="END) AS MOVDIA "
cQuery+="FROM "+RetSqlName("SEU")+" SEU "
//cQuery+="FROM SEU010 SEU "
cQuery+="WHERE D_E_L_E_T_ <> '*' "
cQuery+="  AND EU_CAIXA BETWEEN '"+MV_PAR01+"' AND '"+MV_PAR02+"' "
cQuery+="  AND EU_DTDIGIT >= '"+DTOS(MV_PAR03)+"' "
cQuery+="GROUP BY EU_CAIXA, EU_DTDIGIT "
cQuery+="ORDER BY EU_CAIXA, EU_DTDIGIT "
TCQUERY cQuery ALIAS "QRY" NEW
dbselectarea("QRY")
dbgotop()
do while !eof()
	if cCaixa <> QRY->EU_CAIXA
		dbselectarea("SZ3")
		dbseek(xFilial("SZ3")+QRY->EU_CAIXA+DTOS(MV_PAR03),.T.)
		if !bof()
			dbskip(-1)  //posiciona no ๚ltimo dia de saldo da caixinha
		endif
		if SZ3->Z3_CAIXA == QRY->EU_CAIXA .and. SZ3->Z3_DTSALDO < MV_PAR03
			nSaldo:=SZ3->Z3_SALDO
			lGrava:=.T.
		else
			nSaldo:=0
			lGrava:=.F.
		endif
		dDtSaldo:=MV_PAR03
		cCaixa  :=QRY->EU_CAIXA
	endif
	while dtos(dDtSaldo) < QRY->EU_DTDIGIT //Repete o Saldo para dia sem Movimenta็ใo somente se
		if lGrava                           //houver movimenta็ใo anterior
			reclock("SZ3",.T.)
			SZ3->Z3_CAIXA   := QRY->EU_CAIXA
			SZ3->Z3_DTSALDO := dDtSaldo
			SZ3->Z3_SALDO   := nSaldo
			msunlock()
		endif
		dDtSaldo+=1
	enddo
	lGrava:=.T.
	nSaldo+=QRY->MOVDIA
	reclock("SZ3",.T.)
	SZ3->Z3_CAIXA   := QRY->EU_CAIXA
	SZ3->Z3_DTSALDO := dDtSaldo
	SZ3->Z3_SALDO   := nSaldo
	msunlock()
	dDtSaldo+=1
	dbselectarea("QRY")
	dbskip()
enddo
dbclosearea()
RestArea(aArea)
if oleTxt <> Nil
	MsgAlert("Recalculo Terminado","Concluido","INFO")
endif
//Close(oLeTxt)
Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFuncao    ณValidPerg บAutor  ณCesar Dupim         บ Data ณ  09/28/05   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณValida as Perguntas do Relatorio                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ MP8                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function ValidPerg(cPerg)
Local aArea := GetArea()
Local aRegs := {}
Local i,j

dbSelectArea("SX1")
dbSetOrder(1)

aAdd(aRegs,{cPerg , "01" , "Da Caixinha ?     " , "" , "" , "mv_ch1" , "C" ,  6 , 00 , 0 , "G" , "" , "mv_par01" , "             " , "" , "" , "" , "" , "            " , "" , "" , "" , "" , "            " , "" , "" , "" , "" , "               " , "" , "" , "" , "" , "     " , "" , "" , "SC1" , "" , "" , "" })
aAdd(aRegs,{cPerg , "02" , "Ate a Caixinha ?  " , "" , "" , "mv_ch2" , "C" ,  6 , 00 , 0 , "G" , "" , "mv_par02" , "             " , "" , "" , "" , "" , "            " , "" , "" , "" , "" , "            " , "" , "" , "" , "" , "               " , "" , "" , "" , "" , "     " , "" , "" , "SC1" , "" , "" , "" })
aAdd(aRegs,{cPerg , "03" , "A partir da data ?" , "" , "" , "mv_ch3" , "D" ,  8 , 00 , 0 , "G" , "" , "mv_par03" , "             " , "" , "" , "" , "" , "            " , "" , "" , "" , "" , "            " , "" , "" , "" , "" , "               " , "" , "" , "" , "" , "     " , "" , "" , "" , "" , "" , "" })
//	aAdd(aRegs,{cPerg , "04" , "Atฺ a data ?      " , "" , "" , "mv_ch4" , "D" ,  8 , 00 , 0 , "G" , "" , "mv_par04" , "             " , "" , "" , "" , "" , "            " , "" , "" , "" , "" , "            " , "" , "" , "" , "" , "               " , "" , "" , "" , "" , "     " , "" , "" , "" , "" , "" , "" })

For i:=1 to Len(aRegs)
	If !dbSeek(cPerg+"    "+aRegs[i,2])
		RecLock("SX1",.T.)
		For j:=1 to FCount()
			If j <= Len(aRegs[i])
				FieldPut(j,aRegs[i,j])
			Endif
		Next
		MsUnlock()
	Endif
Next
RestArea(aArea)
Return