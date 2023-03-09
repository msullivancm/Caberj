#INCLUDE "rwmake.ch"  
#INCLUDE "PROTHEUS.CH"
#INCLUDE "TOPCONN.CH"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCABR063   บ Autor ณ Renato Peixoto     บ Data ณ  24/05/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Relat๓rio materiais OPME utilizados nas interna็๕es.       บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบ          ณ Em DEZ/14 Parametro para Procedimento Liberado ou Pago     บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP6 IDE                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/

//Leonardo Portella - 20/10/15 - Otimizacao de querys e alteracao do conceito: 
//devera olhar pela nota de entrada pois existem guias de internacao que nao 
//estao faturadas.  
        

User Function CABR063

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Declaracao de Variaveis                                             ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

Local cDesc1         := "Este programa tem como objetivo imprimir relatorio "
Local cDesc2         := "de acordo com os parametros informados pelo usuario."
Local cDesc3         := "Relatorio Mat. OPME por periodo"
Local cPict          := ""
Local titulo         := "Relatorio Mat. OPME por periodo"
Local nLin           := 80

Local Cabec1         := "Cod. Procedimento           Desc. Procedimento                   Qtd        Percentual        Valor       Valor Medio Unitแrio         "
Local Cabec2         := ""
Local imprime        := .T.
Local aOrd           := {}
Private lEnd         := .F.
Private lAbortPrint  := .F.
Private CbTxt        := ""
Private limite       := 220
Private tamanho      := "G"
Private nomeprog     := "Relat๓rio de Materiais OPME" // Coloque aqui o nome do programa para impressao no cabecalho
Private nTipo        := 18
Private aReturn      := { "Zebrado", 1, "Administracao", 2, 2, 1, "", 1}
Private nLastKey     := 0
Private cbtxt        := Space(10)
Private cbcont       := 00
Private CONTFL       := 01
Private m_pag        := 01
Private wnrel        := "CABR063" // Coloque aqui o nome do arquivo usado para impressao em disco

Private cString      := "" 

Private cPerg	     := "CABR63" 
Private cMesDe       := ""
Private cMesAte      := ""
Private cAnoDe       := ""
Private cAnoAte      := ""
Private cCompetDe    := ""  
Private cCompetAte   := ""
Private cVisaoRel    := "" //1=Resumida; 2=Por Plano
Private aRel         := {} 

Private cAnoDe       := ""
Private cAnoAte      := ""
Private cMesDe       := ""
Private cMesAtev     := ""
Private cCompetDe    := ""
Private cCompetAte   := ""
Private cCodPro      := ""
Private cDesPro      := ""
Private aVetOPME     := {}
Private aInt         := {}
Private aVetTot      := {}
Private aProcsOPME   := {}
Private nVlTot       := 0
Private nVlMTot      := 0
Private nQtdTot      := 0

//Monta as perguntas do relat๓rio
AjustaSX1()

Pergunte(cPerg,.T.)

If MV_PAR07 = 2
	Cabec1       := "Chave Int.                  Matricula                    Nome Beneficiario                  Cod. Procedimento         Desc. Procedimento                  Qtd        Percentual            Valor     Valor Medio Unitแrio         "
	limite       := 220
	tamanho      := "G"
EndIf

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Monta a interface padrao com o usuario...                           ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

wnrel := SetPrint(cString,NomeProg,cPerg,@titulo,cDesc1,cDesc2,cDesc3,.T.,aOrd,.T.,Tamanho,,.T.)  

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

**************************************************************************************************************************

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFuno    ณRUNREPORT บ Autor ณ AP6 IDE            บ Data ณ  24/05/12   บฑฑ
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
Local cPlano     := ""
Local cInt       := "" 
Local nQtdTotPla := 0
Local nPerTotPla := 0
Local nVlTotPla  := 0
Local nVlMTotPla := 0
Local i          := 0
Local j          := 0

Processa({||nCont := BscMatOPME()},"Grupo Caberj")

SetRegua(Len(aVetTot))

//Calculo os totais, que serao usados para calcular o percentual em cada item...
For i := 1 To Len(aVetTot)
	nQtdTot += aVetTot[i][3]
    nVlTot  += aVetTot[i][4]
    nVlMTot += aVetTot[i][5]
Next i

i := 0

For i := 1 To Len(aVetTot)
   //ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
   //ณ Verifica o cancelamento pelo usuario...                             ณ
   //ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

   If lAbortPrint
      @nLin,00 PSAY "*** CANCELADO PELO OPERADOR ***"
      Exit
   Endif

   //ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
   //ณ Impressao do cabecalho do relatorio. . .                            ณ
   //ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

   If nLin > 55 // Salto de Pแgina. Neste caso o formulario tem 55 linhas...
      Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
      nLin := 8
   Endif
   
   If MV_PAR07 == 2 .AND. cPlano <> aVetTot[i][6] .AND. i > 1
   		nLin++
   		@nLin,00   PSAY "Totais do Plano: "+AllTrim(cPlano)
   		@nLin,28   PSAY " "
   		@nLin,55   PSAY " "
   		@nLin,098  PSAY " "
   		@nLin,120  PSAY " "
   		@nLin,150  PSAY nQtdTotPla PICTURE "@E 999,999"
   		@nLin,167  PSAY Transform(nPerTotPla, "@E 999.99")+"%"
   		@nLin,180  PSAY nVlTotPla  PICTURE "@E 999,999,999.99"
   		@nLin,200  PSAY nVlMTotPla PICTURE "@E 999,999,999.99"
   		
   		Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
      	nLin := 8
      	@nLin,00  PSAY "Plano: "+aVetTot[i][6]
        nLin++
        @nLin,00  PSAY "Interna็ใo: "+aVetTot[i][7]
        nLin+=3
        If Len(aProcsOPME) > 0
        	@nLin,00 PSAY "Outros procedimentos que ocorreram nessa interna็ใo que tamb้m permitem a utiliza็ใo de OPME: "
        	nLin++
        	For j := 1 To Len(aProcsOPME)
        		If aProcsOPME[j][1] == aVetTot[i][7]
        			@nLin,00 PSAY AllTrim(aProcsOPME[j][2])+" - "+aProcsOPME[j][3]
        			nLin++
        		EndIf
        	Next j
        	nLin+=2
        EndIf  
        nQtdTotPla := 0
        nPerTotPla := 0
		nVlTotPla  := 0
		nVlMTotPla := 0
   EndIf
   
   If MV_PAR07 == 2 .AND. cInt <> aVetTot[i][7] .AND. i > 1 .AND. cPlano == aVetTot[i][6] 
   		nLin++
   		@nLin,00 PSAY Replicate("-",220)
   		nLin++
   		@nLin,00  PSAY "Interna็ใo: "+aVetTot[i][7]
        nLin+=3
        If Len(aProcsOPME) > 0
        	@nLin,00 PSAY "Outros procedimentos que ocorreram nessa interna็ใo que tamb้m permitem a utiliza็ใo de OPME: "
        	nLin++
        	For j := 1 To Len(aProcsOPME)
        		If aProcsOPME[j][1] == aVetTot[i][7]
        			@nLin,00 PSAY AllTrim(aProcsOPME[j][2])+" - "+aProcsOPME[j][3]
        			nLin++
        		EndIf
        	Next j
        	nLin+=2
        EndIf
        
   EndIf
   
   If i == 1
   		nLin++
   		@nLin,00 PSAY Replicate("-",220)
   		nLin++
   
   		@nLin,00 PSAY "Perํodo pesquisado: "+SUBSTR(cCompetde,5,2)+"/"+SUBSTR(cCompetde,1,4)+" at้:"+SUBSTR(cCompetAte,5,2)+"/"+SUBSTR(cCompetAte,1,4)+"."
   		nLin++
   		@nLin,00 PSAY "Procedimento pesquisado que permite a utiliza็ใo de OPME: "+cCodPro+" - "+cDesPro+"."
   		nLin++                      
   		@nLin,00 PSAY Replicate("-",220)
   		nLin++     
   		nLIn++
   		If MV_PAR07 == 1
   			If Len(aProcsOPME) > 0
   				@nLin,00 PSAY "Outros procedimentos envolvidos nas interna็๕es do perํodo pesquisado que tamb้m permitem a utiliza็ใo de OPME:"
   				nLIn++
   				For j := 1 To Len(aProcsOPME)
   					@nLin,00 PSAY "Interna็ใo: "+aProcsOPME[j][1]+" Procedimento: "+AllTrim(aProcsOPME[j][2])+" - "+aProcsOPME[j][3]
   					nLin++
   				Next j
   				nLin++	
			EndIf
		EndIf   		
   EndIf
   
   If MV_PAR07 == 2 .AND. i == 1
   		@nLin,00  PSAY "Plano: "+aVetTot[i][6]
        nLin++
        @nLin,00  PSAY "Interna็ใo: "+aVetTot[i][7]
        nLin+=3
        If Len(aProcsOPME) > 0
        	@nLin,00 PSAY "Outros procedimentos que ocorreram nessa interna็ใo que tamb้m permitem a utiliza็ใo de OPME: "
        	nLin++
        	For j := 1 To Len(aProcsOPME)
        		If aProcsOPME[j][1] == aVetTot[i][7]
        			@nLin,00 PSAY AllTrim(aProcsOPME[j][2])+" - "+aProcsOPME[j][3]
        			nLin++
        		EndIf
        	Next j
        	nLin+=2
        EndIf
   EndIf     
   
   If MV_PAR07 = 1
   
   		@nLin,00  PSAY aVetTot[i][1]
   		@nLin,28  PSAY AllTrim(aVetTot[i][2])
   		@nLin,60  PSAY aVetTot[i][3] PICTURE "@E 999,999"
   		@nLin,75  PSAY Transform((aVetTot[i][3] * 100) / nQtdTot, "@E 999.99") +"%" 
   		@nLin,86  PSAY aVetTot[i][4] PICTURE "@E 999,999,999.99"
   		@nLin,105 PSAY aVetTot[i][5] PICTURE "@E 999,999,999.99"
   
   		nLin := nLin + 1 // Avanca a linha de impressao
   
   Else
        //Logica de impressao caso seja o relatorio analitico
              
   		@nLin,00  PSAY aVetTot[i][7] 
   		@nLin,28  PSAY aVetTot[i][8] 
   		@nLin,55  PSAY aVetTot[i][9]
   		@nLin,098 PSAY aVetTot[i][1]
   		@nLin,120 PSAY AllTrim(aVetTot[i][2])
   		@nLin,150 PSAY aVetTot[i][3] PICTURE "@E 999,999"
   		@nLin,167 PSAY Transform((aVetTot[i][3] * 100) / nQtdTot, "@E 999.99") +"%" 
   		@nLin,180 PSAY aVetTot[i][4] PICTURE "@E 999,999,999.99"
   		@nLin,200 PSAY aVetTot[i][5] PICTURE "@E 999,999,999.99"
   		   
   		nLin := nLin + 1 // Avanca a linha de impressao
   EndIf
   
   If MV_PAR07 = 2
   		cPlano := aVetTot[i][6]				
   		cInt   := aVetTot[i][7]
   		nQtdTotPla += aVetTot[i][3]
   		nPerTotPla += (aVetTot[i][3] * 100) / nQtdTot
		nVlTotPla  += aVetTot[i][4]
		nVlMTotPla += aVetTot[i][5]
   EndIf   
      
Next i

If MV_PAR07 = 2
	//imprime mais uma vez o total do ultimo plano impresso
		nLin++
   		@nLin,00  PSAY "Totais do Plano: "+AllTrim(cPlano)
   		@nLin,28  PSAY " "
   		@nLin,55  PSAY " "
   		@nLin,098 PSAY " "
   		@nLin,120 PSAY " "
   		@nLin,150 PSAY nQtdTotPla PICTURE "@E 999,999"
        @nLin,167 PSAY Transform(nPerTotPla,"@E 999.99")+"%"
   		@nLin,180 PSAY nVlTotPla  PICTURE "@E 999,999,999.99"
   		@nLin,200 PSAY nVlMTotPla PICTURE "@E 999,999,999.99"
   		nLin++	
EndIf
	
nLin += 2
If MV_PAR07 = 1
	@nLin,00  PSAY "TOTAIS"
	@nLin,60  PSAY nQtdTot PICTURE "@E 999,999"
	@nLin,86  PSAY nVlTot  PICTURE "@E 999,999,999.99"
	@nLin,105 PSAY nVlMTot PICTURE "@E 999,999,999.99"
Else
	@nLin,00  PSAY "TOTAL GERAL"
	@nLin,150 PSAY nQtdTot PICTURE "@E 999,999"
	@nLin,169 PSAY "100%"
	@nLin,180 PSAY nVlTot  PICTURE "@E 999,999,999.99"
	@nLin,200 PSAY nVlMTot PICTURE "@E 999,999,999.99"	
EndIf

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

**************************************************************************************************************************

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณBscMatOMPEบAutor  ณRenato Peixoto      บ Data ณ  22/05/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณFun็ใo que cont้m as querys que vใo buscar os materiais que บฑฑ
ฑฑบ          ณforam utilizados com o procedimento informado por parโmetro.บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function BscMatOPME()

Local cOpeLot    	:= "0001"
Local cCodLDP    	:= "0013" //Local de digita็ใo para OPME
Local i          	:= 0
Local j          	:= 0 
Local cQryPrOPME 	:= ""
Local cAliasPrOP 	:= GetNextAlias()
Local cAlias1		:= GetNextAlias()
Local cAlias2		:= GetNextAlias()

cAnoDe     			:= MV_PAR01
cAnoAte    			:= MV_PAR02
cMesDe     			:= MV_PAR03
cMesAte    			:= MV_PAR04

cCompetDe  			:= cAnoDe + cMesDe
cCompetAte 			:= cAnoAte + cMesAte  
cCodPro 			:= MV_PAR05
cDesPro 			:= Posicione("BR8",1,xFilial("BR8") + MV_PAR06 + cCodPro,"BR8_DESCRI")

ProcRegua(0)

For i := 0 to 5
	IncProc('Selecionando registros...')
Next

//Busca interna็๕es na competencia que possuem procedimentos que permitem OPME
cQuery := "SELECT DISTINCT BE2_CODPRO PROC_PRINCIPAL, TRIM(BR8_DESCRI) DESC_PROC_PRINCIPAL, BD5_GUIINT"		+ CRLF
cQuery += "FROM " + RetSqlName("BE4") + " BE4"																+ CRLF
cQuery += "INNER JOIN " + RetSqlName("BE2") + " BE2 ON BE2_FILIAL = '" + xFilial("BE2") + "'"				+ CRLF
cQuery += "  AND BE2_OPEMOV = BE4_CODOPE"																	+ CRLF
cQuery += "  AND BE2_ANOINT = BE4_ANOINT"																	+ CRLF
cQuery += "  AND BE2_MESINT = BE4_MESINT"																	+ CRLF
cQuery += "  AND BE2_NUMINT = BE4_NUMINT"																	+ CRLF
cQuery += "  AND BE2.D_E_L_E_T_ = ' '" 																		+ CRLF

If mv_par08 == 1 
  cQuery += "   AND BE2_CODPRO = '" + cCodPro + "'"															+ CRLF  
EndIf

cQuery += "INNER JOIN " + RetSqlName("BR8") + " BR8 ON BR8_FILIAL = '" + xFilial("BR8") + "'"				+ CRLF
cQuery += "  AND BR8_CODPAD = BE2_CODPAD"																	+ CRLF
cQuery += "  AND BR8_CODPSA = BE2_CODPRO"																	+ CRLF
cQuery += "  AND BR8.D_E_L_E_T_ = ' '"																		+ CRLF

//Procedimento ou Pacote
cQuery += "  AND BR8_TPPROC IN ('0','6')"																	+ CRLF

cQuery += "INNER JOIN " + RetSqlName("BD5") + " BD5 ON BD5_FILIAL = '" + xFilial("BD5") + "'"				+ CRLF
cQuery += "  AND BD5_CODLDP = '" + cCodLDP + "'"															+ CRLF
cQuery += "  AND SUBSTR(BD5_GUIINT,1,4) = BE4_CODOPE"														+ CRLF
cQuery += "  AND SUBSTR(BD5_GUIINT,5,4) = BE4_CODLDP"														+ CRLF
cQuery += "  AND SUBSTR(BD5_GUIINT,9,8) = BE4_CODPEG"														+ CRLF
cQuery += "  AND SUBSTR(BD5_GUIINT,17,8) = BE4_NUMERO"														+ CRLF  
cQuery += "  AND BD5.D_E_L_E_T_ = ' '"																		+ CRLF
cQuery += "INNER JOIN " + RetSqlName("BD6") + " BD6 ON BD6_FILIAL = '" + xFilial("BD6") + "'"				+ CRLF
cQuery += "  AND BD6_CODOPE = BD5_CODOPE"																	+ CRLF
cQuery += "  AND BD6_CODLDP = BD5_CODLDP"																	+ CRLF
cQuery += "  AND BD6_CODPEG = BD5_CODPEG"																	+ CRLF
cQuery += "  AND BD6_NUMERO = BD5_NUMERO"																	+ CRLF
cQuery += "  AND BD6_SITUAC = '1'"																			+ CRLF
cQuery += "  AND BD6.D_E_L_E_T_ = ' '" 																		+ CRLF
//Guia X NF
cQuery += "INNER JOIN " + RetSqlName("B19") + " B19 ON B19_FILIAL = '" + xFilial("B19") + "'"				+ CRLF
cQuery += "  AND B19_GUIA = BD6_CODOPE||BD6_CODLDP||BD6_CODPEG||BD6_NUMERO||BD6_ORIMOV||BD6_SEQUEN"			+ CRLF
cQuery += "  AND B19.D_E_L_E_T_ = ' '" 																		+ CRLF
//NF Entrada
cQuery += "INNER JOIN " + RetSqlName("SF1") + " F1 ON F1_FILIAL = '" + xFilial("SF1") + "'"					+ CRLF 
cQuery += "  AND F1_DOC = B19_DOC"																			+ CRLF
cQuery += "  AND F1_SERIE = B19_SERIE"																		+ CRLF
cQuery += "  AND F1_FORNECE = B19_FORNEC"																	+ CRLF
cQuery += "  AND F1_LOJA = B19_LOJA"																		+ CRLF
cQuery += "  AND F1_EMISSAO BETWEEN '" + cCompetDe + "01' AND '" + cCompetAte + "31'"						+ CRLF
cQuery += "WHERE BE4_FILIAL = '" + xFilial("BE4") + "'"														+ CRLF
cQuery += "  AND BE4.D_E_L_E_T_ = ' '"																		+ CRLF
  
If mv_par08 <> 1                      
  cQuery += "  AND EXISTS (SELECT /*+ INDEX(BD6B BD60101) */ NULL"											+ CRLF  
  cQuery += "            FROM "+RetSqlName("BD6")+" BD6B" 													+ CRLF  
  cQuery += "            WHERE BD6B.BD6_FILIAL = BE4.BE4_FILIAL"											+ CRLF  
  cQuery += "              AND BD6B.BD6_CODOPE = BE4.BE4_CODOPE"											+ CRLF  
  cQuery += "              AND BD6B.BD6_CODLDP = BE4.BE4_CODLDP"											+ CRLF  
  cQuery += "              AND BD6B.BD6_CODPEG = BE4.BE4_CODPEG"											+ CRLF 
  cQuery += "              AND BD6B.BD6_NUMERO = BE4.BE4_NUMERO"											+ CRLF  
  cQuery += "              AND BD6B.BD6_CODPRO = '" + cCodPro + "'"											+ CRLF
  cQuery += "              AND BD6B.BD6_SITUAC = '1'"														+ CRLF
  cQuery += "              AND BD6B.D_E_L_E_T_ = ' ')"														+ CRLF                    
EndIf 

cQuery += " "																								+ CRLF
cQuery += "UNION"																							+ CRLF
cQuery += " "																								+ CRLF

cQuery += "SELECT DISTINCT BQV_CODPRO PROC_PRINCIPAL, TRIM(BQV_DESPRO) DESC_PROC_PRINCIPAL, BD5_GUIINT" 	+ CRLF
cQuery += "FROM " + RetSqlName("BE4") + " BE4"																+ CRLF
cQuery += "INNER JOIN " + RetSqlName("BE2") + " BE2 ON BE2_FILIAL = '" + xFilial("BE2") + "'"				+ CRLF
cQuery += "  AND BE2_OPEMOV = BE4_CODOPE"																	+ CRLF
cQuery += "  AND BE2_ANOINT = BE4_ANOINT"																	+ CRLF
cQuery += "  AND BE2_MESINT = BE4_MESINT"																	+ CRLF
cQuery += "  AND BE2_NUMINT = BE4_NUMINT"																	+ CRLF
cQuery += "  AND BE2.D_E_L_E_T_ = ' '" 																		+ CRLF

//Evolucao das Diarias          
cQuery += "INNER JOIN " + RetSqlName("BQV") + " BQV ON BQV_FILIAL = '" + xFilial("BQV") + "'"				+ CRLF
cQuery += "  AND BQV_CODOPE = BE2_OPEMOV"																	+ CRLF
cQuery += "  AND BQV_ANOINT = BE2_ANOAUT"																	+ CRLF
cQuery += "  AND BQV_MESINT = BE2_MESINT"																	+ CRLF
cQuery += "  AND BQV_NUMINT = BE2_NUMINT"																	+ CRLF
cQuery += "  AND BQV.D_E_L_E_T_ = ' '" 																		+ CRLF   

If mv_par08 == 1 
  cQuery += "  AND BQV_CODPRO = '" + cCodPro + "'"															+ CRLF   
EndIf

cQuery += "INNER JOIN " + RetSqlName("BR8") + " BR8 ON BR8_FILIAL = '" + xFilial("BR8") + "'"				+ CRLF
cQuery += "  AND BR8_CODPAD = BQV_CODPAD"																	+ CRLF
cQuery += "  AND BR8_CODPSA = BQV_CODPRO"																	+ CRLF
cQuery += "  AND BR8.D_E_L_E_T_ = ' '"																		+ CRLF

//Permite material OPME
cQuery += "  AND BR8_YMATER = '1'"																			+ CRLF 

//Procedimento ou Pacote
cQuery += "  AND BR8_TPPROC IN ('0','6')"																	+ CRLF

cQuery += "INNER JOIN " + RetSqlName("BD5") + " BD5 ON BD5_FILIAL = '" + xFilial("BD5") + "'"				+ CRLF
cQuery += "  AND BD5_CODLDP = '" + cCodLDP + "'"															+ CRLF
cQuery += "  AND SUBSTR(BD5_GUIINT,1,4) = BE4_CODOPE"														+ CRLF
cQuery += "  AND SUBSTR(BD5_GUIINT,5,4) = BE4_CODLDP"														+ CRLF
cQuery += "  AND SUBSTR(BD5_GUIINT,9,8) = BE4_CODPEG"														+ CRLF
cQuery += "  AND SUBSTR(BD5_GUIINT,17,8) = BE4_NUMERO"														+ CRLF  
cQuery += "  AND BD5.D_E_L_E_T_ = ' '"																		+ CRLF
cQuery += "INNER JOIN " + RetSqlName("BD6") + " BD6 ON BD6_FILIAL = '" + xFilial("BD6") + "'"				+ CRLF
cQuery += "  AND BD6_CODOPE = BD5_CODOPE"																	+ CRLF
cQuery += "  AND BD6_CODLDP = BD5_CODLDP"																	+ CRLF
cQuery += "  AND BD6_CODPEG = BD5_CODPEG"																	+ CRLF
cQuery += "  AND BD6_NUMERO = BD5_NUMERO"																	+ CRLF
cQuery += "  AND BD6_SITUAC = '1'"																			+ CRLF
cQuery += "  AND BD6.D_E_L_E_T_ = ' '" 																		+ CRLF
//Guia X NF
cQuery += "INNER JOIN " + RetSqlName("B19") + " B19 ON B19_FILIAL = '" + xFilial("B19") + "'"				+ CRLF
cQuery += "  AND B19_GUIA = BD6_CODOPE||BD6_CODLDP||BD6_CODPEG||BD6_NUMERO||BD6_ORIMOV||BD6_SEQUEN"			+ CRLF
cQuery += "  AND B19.D_E_L_E_T_ = ' '"																		+ CRLF
//NF Entrada
cQuery += "INNER JOIN " + RetSqlName("SF1") + " F1 ON F1_FILIAL = '" + xFilial("SF1") + "'"					+ CRLF 
cQuery += "  AND F1_DOC = B19_DOC"																			+ CRLF
cQuery += "  AND F1_SERIE = B19_SERIE"																		+ CRLF
cQuery += "  AND F1_FORNECE = B19_FORNEC"																	+ CRLF
cQuery += "  AND F1_LOJA = B19_LOJA"																		+ CRLF
cQuery += "  AND F1_EMISSAO BETWEEN '" + cCompetDe + "01' AND '" + cCompetAte + "31'"						+ CRLF
cQuery += "WHERE BE4_FILIAL = '" + xFilial("BE4") + "'"														+ CRLF
cQuery += "  AND BE4.D_E_L_E_T_ = ' '"																		+ CRLF
 
If mv_par08 <> 1                      
  cQuery += "  AND EXISTS (SELECT /*+ INDEX(BD6B BD60101) */ NULL"											+ CRLF  
  cQuery += "            FROM "+RetSqlName("BD6")+" BD6B" 													+ CRLF  
  cQuery += "            WHERE BD6B.BD6_FILIAL = BE4.BE4_FILIAL"											+ CRLF  
  cQuery += "              AND BD6B.BD6_CODOPE = BE4.BE4_CODOPE"											+ CRLF  
  cQuery += "              AND BD6B.BD6_CODLDP = BE4.BE4_CODLDP"											+ CRLF  
  cQuery += "              AND BD6B.BD6_CODPEG = BE4.BE4_CODPEG"											+ CRLF 
  cQuery += "              AND BD6B.BD6_NUMERO = BE4.BE4_NUMERO"											+ CRLF  
  cQuery += "              AND BD6B.BD6_CODPRO = '" + cCodPro + "'"											+ CRLF
  cQuery += "              AND BD6B.BD6_SITUAC = '1'"														+ CRLF
  cQuery += "              AND BD6B.D_E_L_E_T_ = ' ')"														+ CRLF                    
EndIf 

TcQuery cQuery New Alias cAlias1

cAlias1->(dbGoTop())

While !(cAlias1->(Eof()) )

	cChavInt := cAlias1->BD5_GUIINT
	aAdd( aInt , { cAlias1->BD5_GUIINT } )
	
	cQryPrOPME := "SELECT BD6_CODPAD, BD6_CODPRO, TRIM(BR8_DESCRI) BR8_DESCRI" 									+ CRLF
	cQryPrOPME += "FROM " + RetSqlName("BD6") + " BD6" 															+ CRLF
	cQryPrOPME += "INNER JOIN " + RetSqlName("BR8") + " BR8 ON BR8_FILIAL = '" + xFilial('BR8') + "'" 			+ CRLF
	cQryPrOPME += "  AND BR8_CODPAD = BD6_CODPAD" 																+ CRLF 
	cQryPrOPME += "  AND BR8_CODPSA = BD6_CODPRO"																+ CRLF
	cQryPrOPME += "  AND BR8_YMATER = '1'" 																		+ CRLF
	cQryPrOPME += "  AND BR8.D_E_L_E_T_ = ' '" 																	+ CRLF
	cQryPrOPME += "  AND BR8_CODPSA <> '" + cCodPro + "'" 														+ CRLF	
	cQryPrOPME += "WHERE BD6.D_E_L_E_T_ = ' '" 																	+ CRLF 
	cQryPrOPME += "  AND BD6_CODOPE = '" + Substr(cChavInt,1,4) + "'" 											+ CRLF
	cQryPrOPME += "  AND BD6_CODLDP = '" + Substr(cChavInt,5,4) + "'" 											+ CRLF
	cQryPrOPME += "  AND BD6_CODPEG = '" + Substr(cChavInt,9,8) + "'" 											+ CRLF
	cQryPrOPME += "  AND BD6_NUMERO = '" + Substr(cChavInt,17,8) + "'" 											+ CRLF
	
	TcQuery cQryPrOPME New Alias cAliasPrOP
	
	While !(cAliasPrOP->(Eof()))
		aAdd ( aProcsOPME, {cChavInt, cAliasPrOP->BD6_CODPRO, cAliasPrOP->BR8_DESCRI} )
		cAliasPrOP->(DbSkip())
	EndDo
	
	cAliasPrOP->(DbCloseArea()) 
	
	//Query que vai trazer cada material utilizado nas interna็๕es trazidas pela primeira query:
	cQuery2 := "SELECT D1_PEDIDO PEDIDO,"																		+ CRLF
	cQuery2 += "  BD6_OPEUSR||'.'||BD6_CODEMP||'.'||BD6_MATRIC||'.'||BD6_TIPREG||'-'||BD6_DIGITO MATRICULA,"	+ CRLF
	cQuery2 += "  TRIM(BD6_NOMUSR) NOME_ASSOCIADO,"																+ CRLF
	cQuery2 += "  RETORNA_DESC_PLANO_MS('C',BA1_CODINT,BA1_CODEMP,BA1_MATRIC,BA1_TIPREG) NOME_PLANO,"			+ CRLF
	cQuery2 += "  TRIM(BA1_ENDERE)||' '||TRIM(BA1_NR_END||' '||BA1_COMEND) ENDERECO_USUARIO,"					+ CRLF
	cQuery2 += "  TRIM(BA1_BAIRRO) BAIRRO_USUARIO,"																+ CRLF
	cQuery2 += "  BA1_MUNICI MUN_USUARIO,"																		+ CRLF
	cQuery2 += "  BA1_TELEFO TEL_USUARIO,"																		+ CRLF
	cQuery2 += "  B1_COD COD_PRODUTO,"																			+ CRLF
	cQuery2 += "  B1_DESC DESC_PRODUTO,"																		+ CRLF
	cQuery2 += "  A2_COD COD_FORNECEDOR,"																		+ CRLF
	cQuery2 += "  TRIM(A2_NOME) FORNECEDOR,"																	+ CRLF
	cQuery2 += "  D1_QUANT QTD,"																				+ CRLF
	cQuery2 += "  D1_TOTAL VALOR_TOTAL,"																		+ CRLF
	cQuery2 += "  BD6_VLRTPF VALOR_COPART,"																		+ CRLF
	cQuery2 += "  TO_DATE(E2_EMISSAO,'YYYYMMDD') DATA_COMPRA,"													+ CRLF
	cQuery2 += "  TO_DATE(TRIM(E2_VENCREA),'YYYYMMDD') DATA_VENCIMANTO,"										+ CRLF
	cQuery2 += "  NVL(TRIM(E2_PARCELA),'1') PARCELA,"															+ CRLF
	cQuery2 += "  E2_VALOR VAL_PARCELA,"																		+ CRLF
	cQuery2 += "  TO_DATE(TRIM(E2_BAIXA),'YYYYMMDD') DATA_BAIXA,"												+ CRLF
	cQuery2 += "  TO_DATE(D1_DTDIGIT,'YYYYMMDD') DATA_LICITACAO,"												+ CRLF
	cQuery2 += "  F1_DESCONT VALOR_DESCONTO,"																	+ CRLF
	cQuery2 += "  TRIM(E2_NUM)||'/'||TRIM(E2_PREFIXO) NOTA_FISCAL,"												+ CRLF
	cQuery2 += "  TRIM(E4_DESCRI) COND_PGTO,"																	+ CRLF
	cQuery2 += "  TO_DATE(BD6_DATPRO,'YYYYMMDD') DATA_SOLICITACAO,"												+ CRLF
	cQuery2 += "  BD5_GUIINT GUIA_ORIGEM"																		+ CRLF
	cQuery2 += "FROM " + RetSqlName("BD5") + " BD5"																+ CRLF
	cQuery2 += "INNER JOIN " + RetSqlName("BD6") + " BD6 ON BD6_FILIAL = '" + xFilial("BD6") + "'"				+ CRLF
	cQuery2 += "  AND BD6_FILIAL = BD5_FILIAL"																	+ CRLF
	cQuery2 += "  AND BD6_CODOPE = BD5_CODOPE"																	+ CRLF
	cQuery2 += "  AND BD6_CODLDP = BD5_CODLDP"																	+ CRLF
	cQuery2 += "  AND BD6_CODPEG = BD5_CODPEG"																	+ CRLF
	cQuery2 += "  AND BD6_NUMERO = BD5_NUMERO"																	+ CRLF
	cQuery2 += "  AND BD6_ORIMOV = BD5_ORIMOV"																	+ CRLF
	cQuery2 += "  AND BD6_FASE IN (3,4)"																		+ CRLF
	cQuery2 += "  AND BD6_CODLDP = '" + cCodLdp + "'"															+ CRLF
	cQuery2 += "  AND BD6_SITUAC = '1'"																			+ CRLF
	cQuery2 += "  AND BD6.D_E_L_E_T_ = ' '"																		+ CRLF
	cQuery2 += "INNER JOIN " + RetSqlName("B19") + " B19 ON B19_FILIAL = '" + xFilial("B19") + "'"				+ CRLF
	cQuery2 += "  AND B19_GUIA = BD6_CODOPE||BD6_CODLDP||BD6_CODPEG||BD6_NUMERO||BD6_ORIMOV||BD6_SEQUEN"		+ CRLF
	cQuery2 += "  AND B19.D_E_L_E_T_ = ' '"																		+ CRLF
	cQuery2 += "INNER JOIN " + RetSqlName("SA2") + " SA2 ON A2_FILIAL = '" + xFilial("SA2") + "'"				+ CRLF
	cQuery2 += "  AND A2_COD = B19_FORNEC"																		+ CRLF
	cQuery2 += "  AND SA2.D_E_L_E_T_ = ' '"																		+ CRLF
	cQuery2 += "INNER JOIN " + RetSqlName("SF1") + " SF1 ON F1_FILIAL = '" + xFilial("SF1") + "'"				+ CRLF
	cQuery2 += "  AND F1_DOC = B19_DOC"																			+ CRLF
	cQuery2 += "  AND F1_SERIE = B19_SERIE"																		+ CRLF
	cQuery2 += "  AND F1_FORNECE = B19_FORNEC"																	+ CRLF
	cQuery2 += "  AND F1_LOJA = B19_LOJA"																		+ CRLF
	cQuery2 += "  AND SF1.D_E_L_E_T_ = ' '"																		+ CRLF
	cQuery2 += "INNER JOIN " + RetSqlName("SD1") + " SD1 ON D1_FILIAL = '" + xFilial("SD1") + "'"				+ CRLF
	cQuery2 += "  AND D1_DOC = F1_DOC"																			+ CRLF
	cQuery2 += "  AND D1_SERIE = F1_SERIE"																		+ CRLF
	cQuery2 += "  AND D1_FORNECE = F1_FORNECE"																	+ CRLF
	cQuery2 += "  AND D1_LOJA = F1_LOJA"																		+ CRLF
	cQuery2 += "  AND SD1.D_E_L_E_T_ = ' '"																		+ CRLF
	cQuery2 += "INNER JOIN " + RetSqlName("SB1") + " SB1 ON B1_FILIAL = '" + xFilial("SB1") + "'"				+ CRLF
	cQuery2 += "  AND B1_COD = D1_COD"																			+ CRLF
	cQuery2 += "  AND SB1.D_E_L_E_T_ = ' '"																		+ CRLF
	cQuery2 += "INNER JOIN " + RetSqlName("SE2") + " SE2 ON E2_FILIAL = '" + xFilial("SE2") + "'"				+ CRLF
	cQuery2 += "  AND E2_FORNECE = F1_FORNECE"																	+ CRLF
	cQuery2 += "  AND E2_PREFIXO = F1_SERIE"																	+ CRLF
	cQuery2 += "  AND E2_NUM = F1_DOC"																			+ CRLF 
	cQuery2 += "  AND SE2.D_E_L_E_T_ = ' '"																		+ CRLF
	cQuery2 += "INNER JOIN " + RetSqlName("BA3") + " BA3 ON BA3_FILIAL = '" + xFilial("BA3") + "'"				+ CRLF
	cQuery2 += "  AND BA3_CODINT = BD6_OPEUSR"																	+ CRLF
	cQuery2 += "  AND BA3_CODEMP = BD6_CODEMP"																	+ CRLF
	cQuery2 += "  AND BA3_MATRIC = BD6_MATRIC"																	+ CRLF
	cQuery2 += "  AND BA3.D_E_L_E_T_ = ' '"																		+ CRLF
	cQuery2 += "INNER JOIN " + RetSqlName("BA1") + " BA1 ON BA1_FILIAL = '" + xFilial("BA1") + "'"				+ CRLF
	cQuery2 += "  AND BA1_CODINT = BD6_OPEUSR"																	+ CRLF
	cQuery2 += "  AND BA1_CODEMP = BD6_CODEMP"																	+ CRLF
	cQuery2 += "  AND BA1_MATRIC = BD6_MATRIC"																	+ CRLF
	cQuery2 += "  AND BA1_TIPREG = BD6_TIPREG"																	+ CRLF
	cQuery2 += "  AND BA1.D_E_L_E_T_ = ' '"																		+ CRLF
	cQuery2 += "INNER JOIN " + RetSqlName("BR8") + " BR8 ON BR8_FILIAL = '" + xFilial("BR8") + "'"				+ CRLF
	cQuery2 += "  AND BR8_CODPAD = BD6_CODPAD"																	+ CRLF
	cQuery2 += "  AND BR8_CODPSA = BD6_CODPRO"																	+ CRLF
	cQuery2 += "  AND BR8.D_E_L_E_T_ = ' '"																		+ CRLF
	cQuery2 += "INNER JOIN " + RetSqlName("SE4") + " SE4 ON E4_FILIAL = '" + xFilial("SE4") + "'"				+ CRLF
	cQuery2 += "  AND E4_CODIGO = F1_COND"																		+ CRLF
	cQuery2 += "  AND SE4.D_E_L_E_T_ = ' '"																		+ CRLF
    cQuery2 += "WHERE BD5_GUIINT = '" + cChavInt + "'"															+ CRLF
	cQuery2 += "  AND BD5.D_E_L_E_T_ = ' '"																		+ CRLF

	TcQuery cQuery2 New Alias cAlias2

	cAlias2->(dbGoTop())
    
    nCont := 0

	cAlias2->(DbEval({||++nCont}))

	cAlias2->(dbGoTop())
    
	While !(cAlias2->(Eof()) )
		
		If MV_PAR07 == 1
			aAdd( aVetOPME, {cAlias2->COD_PRODUTO, cAlias2->DESC_PRODUTO, cAlias2->QTD, cAlias2->VALOR_TOTAL, cAlias2->NOME_PLANO } )
		Else
			aAdd( aVetTot,  {cAlias2->COD_PRODUTO, cAlias2->DESC_PRODUTO, cAlias2->QTD, cAlias2->VALOR_TOTAL, 0, cAlias2->NOME_PLANO, cAlias2->GUIA_ORIGEM, cAlias2->MATRICULA, cAlias2->NOME_ASSOCIADO } )
		EndIf
		
		cAlias2->(DbSkip())
	 
	EndDo	
	
	cAlias2->(DbCloseArea())
	
	cAlias1->(DbSkip())
	
EndDo

//Faz os calculos de qtd media e valor medio
If MV_PAR07 == 1
	If Len(aVetOPME) > 0
		For i := 1 To Len(aVetOPME)
			If Len(aVetTot) = 0
				aAdd ( aVetTot, {aVetOPME[i][1],aVetOPME[i][2],aVetOPME[i][3],aVetOPME[i][4], 0, aVetOPME[i][5] } )
			Else
				If aScan( aVetTot, {|x| x[1] = aVetOPME[i][1] } ) > 0 
					nPos := aScan( aVetTot, {|x| x[1] = aVetOPME[i][1] } )   
					aVetTot[nPos][3] += aVetOPME[i][3]
				  	aVetTot[nPos][4] += aVetOPME[i][4]
				Else
				 	aAdd (aVetTot, {aVetOPME[i][1],aVetOPME[i][2],aVetOPME[i][3],aVetOPME[i][4], 0, aVetOPME[i][5] } )
				EndIf
			EndIf
		Next i
	EndIf				
EndIf

For i := 1 To Len(aVetTot)
	aVetTot[i][5] := aVetTot[i][4] / aVetTot[i][3]	
Next i

If MV_PAR07 == 1
	aSort(aVetTot , , , {|x,y| x[6] < y[6] })
Else
	aSort(aVetTot , , , {|x,y| x[6]+x[7] < y[6]+y[7] })
EndIf

cAlias1->(DbCloseArea())

Return 

**************************************************************************************************************************

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑฺฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฟฑฑ
ฑฑณFunao    ณ AjustaSX1ณ Autor ณ Renato Peixoto                          ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณDescri…o ณ Ajusta as perguntas do SX1                                 ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/

Static Function AjustaSX1()

Local aHelp 	:= {}

aHelp := {}
aAdd(aHelp, "Informe o ano inicial de pesquisa Faturamento")
PutSX1(cPerg , "01" , "Ano de" 	,"","","mv_ch1","C",4,0,0,"G",""	,"","","","mv_par01","","","","","","","","","","","","","","","","",aHelp,aHelp,aHelp)

aHelp := {}
aAdd(aHelp, "Informe o ano final de pesquisa Faturamento")
PutSX1(cPerg , "02" , "Ano at้" 	,"","","mv_ch2","C",4,0,0,"G",""	,"","","","mv_par02","","","","","","","","","","","","","","","","",aHelp,aHelp,aHelp)

aHelp := {}
aAdd(aHelp, "Informe o m๊s inicial de pesquisa Faturamento")
PutSX1(cPerg , "03" , "Mes de" 	,"","","mv_ch3","C",2,0,0,"G",""	,"","","","mv_par03","","","","","","","","","","","","","","","","",aHelp,aHelp,aHelp)

aHelp := {}
aAdd(aHelp, "Informe o m๊s final de pesquisa Faturamento")
PutSX1(cPerg , "04" , "Mes at้" 	,"","","mv_ch4","C",2,0,0,"G",""	,"","","","mv_par04","","","","","","","","","","","","","","","","",aHelp,aHelp,aHelp)

aHelp := {}
aAdd(aHelp, "C๓d. do Procedimento")
PutSX1(cPerg,"05", "Procedimento","","","mv_ch5","C",8,0,1,"G","","BR8MAT","","","mv_par05",""	,"","","","","","",""	,"","","","","","","","",aHelp,aHelp,aHelp)

aHelp := {}
aAdd(aHelp, "C๓d. da Tabela")
PutSX1(cPerg,"06", "Tabela Padrใo","","","mv_ch6","C",2,0,1,"S","","","","","mv_par06",""	,"","","","","","",""	,"","","","","","","","",aHelp,aHelp,aHelp)

aAdd(aHelp, "Visใo do relat๓rio")
PutSX1(cPerg,"07", "Visใo","","","mv_ch7","N",1,0,1,"C","","","","","mv_par07","Resumida"	,"","","","Por Plano","","",""	,"","","","","","","","",aHelp,aHelp,aHelp)

//Motta 22/12/2014
aAdd(aHelp, "Opcao Procedimento")
PutSX1(cPerg,"08", "Opc. Proc","","","mv_ch8","N",1,0,1,"C","","","","","mv_par08","Liberado"	,"","","","Pago","","",""	,"","","","","","","","",aHelp,aHelp,aHelp)
//Fim Motta 22/12/2014

Return

**************************************************************************************************************************