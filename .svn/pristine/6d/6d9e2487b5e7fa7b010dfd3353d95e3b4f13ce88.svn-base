#include 'rwmake.ch'

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCABR001   บ Autor ณ AP6 IDE            บ Data ณ  28/09/05   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Relatorio de Controle de Solicitacao de Compras            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP6 IDE                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/

User Function CABR001
// Local aArea := GetArea()
Local cDesc1       := "Este programa tem como objetivo imprimir relatorio "
Local cDesc2       := "de acordo com os parametros informados pelo usuario."
Local cDesc3       := "Controle de Solicita็ใo de Compras"
// Local cPict        := ""
Local titulo       := "Controle de Solicita็ใo de Compras"
Local nLin         := 80

**********     0         1         2         3         4         5         6         7         8         9        10        11        12        13        14        15        16        17        18        19       200       210       220
**********     01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
Local Cabec1 := "NUMERO DATA DE  APROVADOR       ITEM PRODUTO         D E S C R I C A O              QUANTIDADE   DT.ULT.   INTERVALO"
Local Cabec2 := "       EMISSAO                                                                                   COMPRA    P/ COMPRA"
**********     123456 12/45/78 123456789012345 12   123456789012345 123456789012345678901234567890 123456789012 12/45/78 123456789

// Local imprime      := .T.
Local aOrd         := {}
Private lEnd       := .F.
Private lAbortPrint:= .F.
Private CbTxt      := ""
Private limite     := 130
Private tamanho    := "M"
Private nomeprog   := "IMPSC1" // Coloque aqui o nome do programa para impressao no cabecalho
Private nTipo      := 18
Private aReturn    := { "Zebrado", 1, "Administracao", 2, 2, 1, "", 1}
Private nLastKey   := 0
Private cPerg      := "IMPSC1"
// Private cbtxt      := Space(10)
Private cbcont     := 00
Private CONTFL     := 01
Private m_pag      := 01
Private wnrel      := "IMPSC1" // Coloque aqui o nome do arquivo usado para impressao em disco

Private cString := "SC1"

dbSelectArea("SC1")
dbSetOrder(1)

ValidPerg(cPerg)

pergunte(cPerg,.F.)

wnrel := SetPrint(cString,NomeProg,cPerg,@titulo,cDesc1,cDesc2,cDesc3,.F.,aOrd,.F.,Tamanho,,.T.)

If nLastKey == 27
	Return
Endif

SetDefault(aReturn,cString)

If nLastKey == 27
	Return
Endif

nTipo := If(aReturn[4]==1,15,18)

RptStatus({|| RunReport(Cabec1,Cabec2,Titulo,nLin) },Titulo)
Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFuno    ณRUNREPORT บ Autor ณ AP6 IDE            บ Data ณ  28/09/05   บฑฑ
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

// Local nOrdem
Local nPos := 0

dbSelectArea(cString)
dbSetOrder(1)

SetRegua(RecCount())

dbSeek(xFilial("SC1")+MV_PAR01)
While !EOF() .and. (C1_FILIAL+C1_NUM <= xFilial("SC1")+MV_PAR02)
	
	If C1_EMISSAO < MV_PAR03 .or. C1_EMISSAO > MV_PAR04
		DbSelectArea("SC1")
		DbSkip()
		Loop
	Endif
	
	If lAbortPrint
		@nLin,00 PSAY "*** CANCELADO PELO OPERADOR ***"
		Exit
	Endif
	
	If nLin > 55 // Salto de Pแgina. Neste caso o formulario tem 55 linhas...
		Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
		nLin := 9
	Endif
	
	DbSelectArea("SC1")
	/*
	0         1         2         3         4         5         6         7         8         9        10        11        12        13        14        15        16        17        18        19       200       210       220
	01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
	NUMERO DATA DE  APROVADOR       ITEM PRODUTO         D E S C R I C A O              QUANTIDADE   DT.ULT.  INTERVALO
	EMISSAO                                                                                   COMPRA   DE COMPRA
	123456 12/45/78 123456789012345 12   123456789012345 123456789012345678901234567890 123456789012 12/45/78 123456789
	*/
   	if (MV_PAR05==2 .and.  empty(C1_XLIBERA)) .or.; // Altera็ใo Realizada por Dupim 
   	   (MV_PAR05==1 .and. !empty(C1_XLIBERA)) .or.; //em 24/11/05 para permitir filtrar  
   	   MV_PAR==03    							   //apenas as SC`s liberadas
		cNum := C1_NUM
		@ nLin,000 PSAY SubStr(C1_NUM,1,6)
		@ nLin,007 PSAY dToC(C1_EMISSAO)
		@ nLin,016 PSAY AllTrim(SubStr(C1_XLIBERA,1,15))
		
		nPos := IIF(Empty(C1_XLIBERA),-1,0)
		
		While !Eof() .and. cNum = C1_NUM
			@ nLin,032+nPos PSAY LEFT(C1_ITEM,4)
			@ nLin,037+nPos PSAY SubStr(C1_PRODUTO,1,15)
			@ nLin,053+nPos PSAY Substr(C1_DESCRI,1,30)
			@ nLin,084+nPos PSAY Transform(C1_QUANT,"@E 999999999.99")
			@ nLin,097+nPos PSAY dToC(C1_XDTUCOM)
			@ nLin,107+nPos PSAY Transform(BuscaProd(C1_PRODUTO,"B1_XINTESC"),"@E 999999999")
			
			nLin := nLin + 1 // Avanca a linha de impressao
			nPos := 0
			dbSkip() // Avanca o ponteiro do registro no arquivo
		Enddo
    	nLin := nLin + 1 // Avanca a linha de impressao
	else                                                       // Altera็ใo Realizada por 
	    dbSkip() // Avanca o ponteiro do registro no arquivo  //Dupim em 24/11/05 para 
	endif                                                     //permitir filtrar apenas as SC`s liberadas 
EndDo

SET DEVICE TO SCREEN

If aReturn[5]==1
	dbCommitAll()
	SET PRINTER TO
	OurSpool(wnrel)
Endif

MS_FLUSH()

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFuncao    ณValidPerg บAutor  ณCarlos Aquino       บ Data ณ  09/28/05   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณValida as Perguntas do Relatorio                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ MP9                                                        บฑฑ
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

aAdd(aRegs,{cPerg , "01" , "A partir de ?     " , "" , "" , "mv_ch1" , "C" ,  6 , 00 , 0 , "G" , "" , "mv_par01" , "             " , "" , "" , "" , "" , "            " , "" , "" , "" , "" , "            " , "" , "" , "" , "" , "               " , "" , "" , "" , "" , "     " , "" , "" , "" , "SC1" , "" , "" })
aAdd(aRegs,{cPerg , "02" , "At้ o Numero ?    " , "" , "" , "mv_ch2" , "C" ,  6 , 00 , 0 , "G" , "" , "mv_par02" , "             " , "" , "" , "" , "" , "            " , "" , "" , "" , "" , "            " , "" , "" , "" , "" , "               " , "" , "" , "" , "" , "     " , "" , "" , "" , "SC1" , "" , "" })
aAdd(aRegs,{cPerg , "03" , "A partir da data ?" , "" , "" , "mv_ch3" , "D" ,  8 , 00 , 0 , "G" , "" , "mv_par03" , "             " , "" , "" , "" , "" , "            " , "" , "" , "" , "" , "            " , "" , "" , "" , "" , "               " , "" , "" , "" , "" , "     " , "" , "" , "" , "" , "" , "" })
aAdd(aRegs,{cPerg , "04" , "At้ a data ?      " , "" , "" , "mv_ch4" , "D" ,  8 , 00 , 0 , "G" , "" , "mv_par04" , "             " , "" , "" , "" , "" , "            " , "" , "" , "" , "" , "            " , "" , "" , "" , "" , "               " , "" , "" , "" , "" , "     " , "" , "" , "" , "" , "" , "" })
aAdd(aRegs,{cPerg , "05" , "Lista SCs        ?" , "" , "" , "mv_ch4" , "N" ,  1 , 00 , 0 , "C" , "" , "mv_par05" , "Liberadas    " , "" , "" , "" , "" , "Pendentes   " , "" , "" , "" , "" , "Ambas       " , "" , "" , "" , "" , "               " , "" , "" , "" , "" , "     " , "" , "" , "" , "" , "" , "" })

For i:=1 to Len(aRegs)
	If !dbSeek(cPerg+aRegs[i,2])
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


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFuncao    ณBuscaProd บAutor  ณCarlos Aquino       บ Data ณ  29/09/05   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRetorna o campo passado por paramentro da tabela de produto.บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ MP8                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function BuscaProd(xProd,xCampo)
Local aArea := GetArea()
Local xRet  := ""
DbSelectArea("SB1")
DbSetOrder(1)
DbSeek(xFilial("SB1")+xProd)
if Found()
	xRet := &xCampo
endif
RestArea(aArea)
Return(xRet)      
