#INCLUDE "PROTHEUS.CH"
#Include "TOPCONN.CH"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABR178  º Autor ³Altamiro               º Data ³ 20/02/14  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Acompanhamento de Pagas e prevista                         º±±
±±º          ³                                                            º±±
±±º          ³                                                            º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/                  

User Function CABR178  
Local cMsg			:= ""
/////
Local cDesc1         := "Este programa tem como objetivo fazer debitos na comissão por  "
Local cDesc2         := "motivo de devolução de importancia pagas sobre assistido excluido"
Local cDesc3         := " "
Local cPict          := ""
Local titulo         := "Devolução de Comissão  "
Local nLin           := 80 															
Local Cabec1         := " "// Empresa                                                 "+        cM0+"   Qtda "+        cM1+"   Qtda "+        cM2+"   Qtda "+        cM3+"   Qtda "+        cM4+"   Qtda "+        cM5+"   Qtda "+        cM6+"   Qtda "
                                                                                        
//                       123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012
//                       0        1         2         3         4         5         6         7         8         9         10        11        12        13        14        15        16        17        18        19        200       210       220
//                       XXXXXX - XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX          9.999.999,99  9.999 9.999.999,99  9.999
//                      BK2_PROPRI||BK2_CODLAN,                                    Sum(BK2_SALDO) 
Local Cabec2         := ""
Local imprime        := .T.
Local aOrd           := {}
Private lEnd         := .F.
Private lAbortPrint  := .F.
Private CbTxt        := ""
Private limite       := 220
Private tamanho      := "G"
Private nomeprog     := "CABR178"
Private nTipo        := 15
Private aReturn      := { "Zebrado", 1, "Administracao", 1, 2, 1, "", 1}
Private nLastKey     := 0
Private cbtxt        := Space(10)
Private cbcont       := 00
Private CONTFL       := 01
Private m_pag        := 01
Private wnrel        := "CABR178"
Private cString      := "bxq"
////


Private lAbortPrint :=.F.
Private cPerg       := "CABR178"
Private cTitulo     := "Acompanhamento de Comissões - pagas e prevista - analise gerencial "

Private cAliastmp 	:= GetNextAlias()  
Private cAliastmp1 	:= GetNextAlias()
                                                                         
//SetPrvt("oDlg1","oGrp1","oSay1","oSBtn1","oSBtn2","oSBtn3")

cMsg += " Este programa ira fazer Listagem Acompanhamento Comissões - pagas e prevista -  " + CRLF
cMsg += "  analise gerencial  " + CRLF       

***************************************************************************    
 
Private  aDados1     := {}       
Private  acabec1     :={"Competencia","Matric - Nome Usuario","Tipo","Evento","Valor","Ano Ir","Ident. Tit.","Dt. Vencto","Dt. Baixa"}
private  Descric     := ' '        

/***********/  
private cM0  := ' ' 
private cM1  := ' '  
private cM2  := ' ' 
private cM3  := ' ' 
private cM4  := ' ' 
private cM5  := ' ' 
private cM6  := ' '  
private cM7  := ' ' 
private cM8  := ' ' 
private cM9  := ' ' 
private cM10 := ' ' 
private cM11 := ' ' 
   	             	
/***********/                                                                                                
 	
AjustaSX1(cPerg)

Pergunte(cPerg,.T.) 

cAMInc    	:=  substr(dtos(dDataBase),1,6)   
cAMFim    	:= 	substr(dtos(dDataBase),1,6)  
cEmpresInc  := mv_par01    
cEmpresFim  := mv_par02  

cGeraEx     := mv_par05 

cEmpresa    := Iif(cEmpAnt == '01','C','I')
 
cAMInc    	:= fGeraDt(cAMFim)                                         
Cabec1      := " Empresa                                         "+cM0+"  Qtda             "+cM1+"  Qtda             "+cM2+"  Qtda             "+cM3+"  Qtda             "+cM4+"  Qtda             "+cM5+"  Qtda          Previsto     Qtda"
//              123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012
//              0        1         2         3         4         5         6         7         8         9         10        11        12        13        14        15        16        17        18        19        200       210       220
//                                                        9,999,999.99   9.999      9,999,999.99   9.999      9,999,999.99   9.999     9,999,999.99   9.999      9,999,999.99   9.999      9,999,999.99   9.999      9,999,999.99   9.999
Processa({||Processa1()}, cTitulo, "", .T.)       



////////////////////////////////////
                        

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta a interface padrao com o usuario...                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

wnrel := SetPrint(cString,NomeProg,"",@titulo,cDesc1,cDesc2,cDesc3,.F.,aOrd,.F.,Tamanho,,.T.)

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
±±ºFun‡„o    ³RUNREPORT º Autor ³ AP6 IDE            º Data ³  31/08/07   º±±
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
Local cQuery := ' '                                          
dbSelectArea(cString)
dbSetOrder(1)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ SETREGUA -> Indica quantos registros serao processados para a regua ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ


For i := 1 To Len(aDados1)                                                             
    If nLin > 65 // Salto de Página. Neste caso o formulario tem 55 linhas...
	   nLin :=	Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
	   nLin ++
    Endif
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifica o cancelamento pelo usuario...                             ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
    If lAbortPrint
	  @nLin,00 PSAY "*** CANCELADO PELO OPERADOR ***"
	   Exit
	Endif                                                     
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Impressao do cabecalho do relatorio. . .                            ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ    
 

Cabec1      := " Empresa                                         "+cM0+"  Qtda             "+cM1+"  Qtda             "+cM2+"  Qtda             "+cM3+"  Qtda             "+cM4+"  Qtda             "+cM5+"  Qtda             "+cM6+"  Qtda"
//              123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012
//              0        1         2         3         4         5         6         7         8         9         10        11        12        13        14        15        16        17        18        19        200       210       220
//              XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX  9,999,999.99   9.999      9,999,999.99   9.999      9,999,999.99   9.999     9,999,999.99   9.999      9,999,999.99   9.999      9,999,999.99   9.999      9,999,999.99   9.999

	 @ nLin,000 PSay  substr(aDados1[i][1],1,40)
	 @ nLin,043 PSay  aDados1[i][02]  Picture "@E 9,999,999.99"  
 	 @ nLin,056 PSAY  aDados1[i][04]  Picture "@E 9,999"     
	 @ nLin,068 PSay  aDados1[i][06]  Picture "@E 9,999,999.99"  
 	 @ nLin,081 PSAY  aDados1[i][08]  Picture "@E 9,999"    
	 @ nLin,093 PSay  aDados1[i][10]  Picture "@E 9,999,999.99"  
 	 @ nLin,106 PSAY  aDados1[i][12]  Picture "@E 9,999"    
	 @ nLin,118 PSay  aDados1[i][14]  Picture "@E 9,999,999.99"  
 	 @ nLin,131 PSAY  aDados1[i][16]  Picture "@E 9,999"    
	 @ nLin,143 PSay  aDados1[i][18]  Picture "@E 9,999,999.99"  
 	 @ nLin,156 PSAY  aDados1[i][20]  Picture "@E 9,999"    
	 @ nLin,169 PSay  aDados1[i][22]  Picture "@E 9,999,999.99"  
 	 @ nLin,182 PSAY  aDados1[i][24]  Picture "@E 9,999"    
	 @ nLin,195 PSay  aDados1[i][26]  Picture "@E 9,999,999.99"  
 	 @ nLin,208 PSAY  aDados1[i][28]  Picture "@E 9,999"    
       nLin ++     // Avanca a linha de impressao 	 
	 @ nLin,043 PSay  aDados1[i][03]  Picture "@E 9,999,999.99"  
 	 @ nLin,056 PSAY  aDados1[i][05]  Picture "@E 9.99"+"%"     
	 @ nLin,068 PSay  aDados1[i][07]  Picture "@E 9,999,999.99"  
 	 @ nLin,081 PSAY  aDados1[i][09]  Picture "@E 9.99"+"%"    
	 @ nLin,093 PSay  aDados1[i][11]  Picture "@E 9,999,999.99"  
 	 @ nLin,106 PSAY  aDados1[i][13]  Picture "@E 9.99"+"%"        
	 @ nLin,118 PSay  aDados1[i][15]  Picture "@E 9,999,999.99"  
 	 @ nLin,131 PSAY  aDados1[i][17]  Picture "@E 9.99"+"%"        
	 @ nLin,143 PSay  aDados1[i][19]  Picture "@E 9,999,999.99"  
 	 @ nLin,156 PSAY  aDados1[i][21]  Picture "@E 9.99"+"%"        
	 @ nLin,169 PSay  aDados1[i][23]  Picture "@E 9,999,999.99"  
 	 @ nLin,182 PSAY  aDados1[i][25]  Picture "@E 9.99"+"%"      
	 @ nLin,195 PSay  aDados1[i][27]  Picture "@E 9,999,999.99"  
 	 @ nLin,208 PSAY  aDados1[i][29]  Picture "@E 9.99"+"%"        
	nLin ++     // Avanca a linha de impressao
Next i   
			

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



////////////////////////////////////

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Libera impressao                                                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
   
// faz ecxel
if cGeraEx == 1 
    DlgToExcel({{"ARRAY","Acompanhamento de empresa X contrato X Sub-contrato - analise gerencial",aCabec1,aDados1}})   
EndIF
//fGeraRel2()    
MsgInfo("Processo finalizado")

Return                 

**************************************************************************

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFun‡„o    ³ PROCESSA1º Autor ³ Jean Schulz        º Data ³  11/11/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescri‡„o ³ Funcao auxiliar chamada pela PROCESSA.  A funcao PROCESSA  º±±
±±º          ³ monta a janela com a regua de processamento.               º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Programa principal                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function Processa1()        

ProcRegua(FT_FLASTREC()) 

nCont := 0
IncProc('Processando...')      
////////////////////////////////////      
/*
cquery :=      " SELECT   bm1_codemp ||' - ' || bqc_descri  emp ,  "

cquery += CRLF+" SUM(CASE WHEN BM1_ANO||BM1_MES = TO_CHAR(ADD_MONTHS(TO_DATE('"+cAMFim +"' ,'YYYYMM'),-11),'YYYYMM') THEN (DECODE(BM1_TIPO,'1',1,-1) * BM1_VALOR) ELSE 0 END) M11,"
cquery += CRLF+" COUNT(CASE WHEN BM1_ANO||BM1_MES = TO_CHAR(ADD_MONTHS(TO_DATE('"+cAMFim +"' ,'YYYYMM'),-11),'YYYYMM') THEN (DECODE(BM1_CODTIP,'101',1,NULL)) ELSE NULL END) M11Q,"
cquery += CRLF+" MAX(CASE WHEN BM1_ANO||BM1_MES = TO_CHAR(ADD_MONTHS(TO_DATE('"+cAMFim +"' ,'YYYYMM'),-11),'YYYYMM') THEN (DECODE(TRIM(BM1_NUMTIT),NULL,' ',BM1_PREFIX ||'-'||BM1_NUMTIT ||'-'||BM1_TIPTIT||'-'||(TO_CHAR(TO_DATE(trim(e1_baixa) ,'YYYYMMDD'), 'DD/MM/YY')))) ELSE ' ' END) M11T ,"
               
cquery += CRLF+" SUM(CASE WHEN BM1_ANO||BM1_MES = TO_CHAR(ADD_MONTHS(TO_DATE('"+cAMFim +"' ,'YYYYMM'),-10),'YYYYMM') THEN (DECODE(BM1_TIPO,'1',1,-1) * BM1_VALOR) ELSE 0 END) M10,"
cquery += CRLF+" COUNT(CASE WHEN BM1_ANO||BM1_MES = TO_CHAR(ADD_MONTHS(TO_DATE('"+cAMFim +"' ,'YYYYMM'),-10),'YYYYMM') THEN (DECODE(BM1_CODTIP,'101',1,NULL)) ELSE NULL END) M10Q,"
cquery += CRLF+" MAX(CASE WHEN BM1_ANO||BM1_MES = TO_CHAR(ADD_MONTHS(TO_DATE('"+cAMFim +"' ,'YYYYMM'),-10),'YYYYMM') THEN (DECODE(TRIM(BM1_NUMTIT),NULL,' ',BM1_PREFIX ||'-'||BM1_NUMTIT ||'-'||BM1_TIPTIT||'-'||(TO_CHAR(TO_DATE(trim(e1_baixa) ,'YYYYMMDD'), 'DD/MM/YY')))) ELSE ' ' END) M10T ,"
               
cquery += CRLF+" SUM(CASE WHEN BM1_ANO||BM1_MES = TO_CHAR(ADD_MONTHS(TO_DATE('"+cAMFim +"' ,'YYYYMM'),-9 ),'YYYYMM') THEN (DECODE(BM1_TIPO,'1',1,-1) * BM1_VALOR) ELSE 0 END) M9,"
cquery += CRLF+" COUNT(CASE WHEN BM1_ANO||BM1_MES = TO_CHAR(ADD_MONTHS(TO_DATE('"+cAMFim +"' ,'YYYYMM'),-9 ),'YYYYMM') THEN (DECODE(BM1_CODTIP,'101',1,NULL)) ELSE NULL END) M9Q,"
cquery += CRLF+" MAX(CASE WHEN BM1_ANO||BM1_MES = TO_CHAR(ADD_MONTHS(TO_DATE('"+cAMFim +"' ,'YYYYMM'),-9 ),'YYYYMM') THEN (DECODE(TRIM(BM1_NUMTIT),NULL,' ',BM1_PREFIX ||'-'||BM1_NUMTIT ||'-'||BM1_TIPTIT||'-'||(TO_CHAR(TO_DATE(trim(e1_baixa) ,'YYYYMMDD'), 'DD/MM/YY')))) ELSE ' ' END) M9T ,"

cquery += CRLF+" SUM(CASE WHEN BM1_ANO||BM1_MES = TO_CHAR(ADD_MONTHS(TO_DATE('"+cAMFim +"' ,'YYYYMM'),-8 ),'YYYYMM') THEN (DECODE(BM1_TIPO,'1',1,-1) * BM1_VALOR) ELSE 0 END) M8, "
cquery += CRLF+" COUNT(CASE WHEN BM1_ANO||BM1_MES = TO_CHAR(ADD_MONTHS(TO_DATE('"+cAMFim +"' ,'YYYYMM'),-8 ),'YYYYMM') THEN (DECODE(BM1_CODTIP,'101',1,NULL)) ELSE NULL END) M8Q, "
cquery += CRLF+" MAX(CASE WHEN BM1_ANO||BM1_MES = TO_CHAR(ADD_MONTHS(TO_DATE('"+cAMFim +"' ,'YYYYMM'),-8 ),'YYYYMM') THEN (DECODE(TRIM(BM1_NUMTIT),NULL,' ',BM1_PREFIX ||'-'||BM1_NUMTIT ||'-'||BM1_TIPTIT||'-'||(TO_CHAR(TO_DATE(trim(e1_baixa) ,'YYYYMMDD'), 'DD/MM/YY')))) ELSE ' ' END) M8T ,"
               
cquery += CRLF+" SUM(CASE WHEN BM1_ANO||BM1_MES = TO_CHAR(ADD_MONTHS(TO_DATE('"+cAMFim +"' ,'YYYYMM'),-7 ),'YYYYMM') THEN (DECODE(BM1_TIPO,'1',1,-1) * BM1_VALOR) ELSE 0 END) M7, "
cquery += CRLF+" COUNT(CASE WHEN BM1_ANO||BM1_MES = TO_CHAR(ADD_MONTHS(TO_DATE('"+cAMFim +"' ,'YYYYMM'),-7 ),'YYYYMM') THEN (DECODE(BM1_CODTIP,'101',1,NULL)) ELSE NULL END) M7Q, "
cquery += CRLF+" MAX(CASE WHEN BM1_ANO||BM1_MES = TO_CHAR(ADD_MONTHS(TO_DATE('"+cAMFim +"' ,'YYYYMM'),-7 ),'YYYYMM') THEN (DECODE(TRIM(BM1_NUMTIT),NULL,' ',BM1_PREFIX ||'-'||BM1_NUMTIT ||'-'||BM1_TIPTIT||'-'||(TO_CHAR(TO_DATE(trim(e1_baixa) ,'YYYYMMDD'), 'DD/MM/YY')))) ELSE ' ' END) M7T ,"
               
cquery += CRLF+" SUM(case when BM1_ANO||BM1_MES = TO_CHAR(ADD_MONTHS(TO_DATE('"+cAMFim +"' ,'YYYYMM'),-6 ),'YYYYMM') then (DECODE(BM1_TIPO,'1',1,-1) * BM1_VALOR) else 0 end) M6,"
cquery += CRLF+" COUNT(CASE WHEN BM1_ANO||BM1_MES = TO_CHAR(ADD_MONTHS(TO_DATE('"+cAMFim +"' ,'YYYYMM'),-6 ),'YYYYMM') THEN (DECODE(BM1_CODTIP,'101',1,NULL)) ELSE NULL END) M6Q,"
cquery += CRLF+" MAX(CASE WHEN BM1_ANO||BM1_MES = TO_CHAR(ADD_MONTHS(TO_DATE('"+cAMFim +"' ,'YYYYMM'),-6 ),'YYYYMM') THEN (DECODE(TRIM(BM1_NUMTIT),NULL,' ',BM1_PREFIX ||'-'||BM1_NUMTIT ||'-'||BM1_TIPTIT||'-'||(TO_CHAR(TO_DATE(trim(e1_baixa) ,'YYYYMMDD'), 'DD/MM/YY')))) ELSE ' ' END) M6T ,"
               
cquery += CRLF+" SUM(CASE WHEN BM1_ANO||BM1_MES = TO_CHAR(ADD_MONTHS(TO_DATE('"+cAMFim +"' ,'YYYYMM'),-5 ),'YYYYMM') THEN (DECODE(BM1_TIPO,'1',1,-1) * BM1_VALOR) ELSE 0 END) M5, "
cquery += CRLF+" COUNT(CASE WHEN BM1_ANO||BM1_MES = TO_CHAR(ADD_MONTHS(TO_DATE('"+cAMFim +"' ,'YYYYMM'),-5 ),'YYYYMM') THEN (DECODE(BM1_CODTIP,'101',1,NULL)) ELSE NULL END) M5Q, "
cquery += CRLF+" MAX(CASE WHEN BM1_ANO||BM1_MES = TO_CHAR(ADD_MONTHS(TO_DATE('"+cAMFim +"' ,'YYYYMM'),-5 ),'YYYYMM') THEN (DECODE(TRIM(BM1_NUMTIT),NULL,' ',BM1_PREFIX ||'-'||BM1_NUMTIT ||'-'||BM1_TIPTIT||'-'||(TO_CHAR(TO_DATE(trim(e1_baixa) ,'YYYYMMDD'), 'DD/MM/YY')))) ELSE ' ' END) M5T ,"
                
cquery += CRLF+" SUM(CASE WHEN BM1_ANO||BM1_MES = TO_CHAR(ADD_MONTHS(TO_DATE('"+cAMFim +"' ,'YYYYMM'),-4 ),'YYYYMM') THEN (DECODE(BM1_TIPO,'1',1,-1) * BM1_VALOR) ELSE 0 END) M4, "
cquery += CRLF+" COUNT(CASE WHEN BM1_ANO||BM1_MES = TO_CHAR(ADD_MONTHS(TO_DATE('"+cAMFim +"' ,'YYYYMM'),-4 ),'YYYYMM') THEN (DECODE(BM1_CODTIP,'101',1,NULL)) ELSE NULL END) M4Q, "
cquery += CRLF+" MAX(CASE WHEN BM1_ANO||BM1_MES = TO_CHAR(ADD_MONTHS(TO_DATE('"+cAMFim +"' ,'YYYYMM'),-4 ),'YYYYMM') THEN (DECODE(TRIM(BM1_NUMTIT),NULL,' ',BM1_PREFIX ||'-'||BM1_NUMTIT ||'-'||BM1_TIPTIT||'-'||(TO_CHAR(TO_DATE(trim(e1_baixa) ,'YYYYMMDD'), 'DD/MM/YY')))) ELSE ' ' END) M4T ,"
             
cquery += CRLF+" SUM(CASE WHEN BM1_ANO||BM1_MES = TO_CHAR(ADD_MONTHS(TO_DATE('"+cAMFim +"' ,'YYYYMM'),-3 ),'YYYYMM') THEN (DECODE(BM1_TIPO,'1',1,-1) * BM1_VALOR) ELSE 0 END) M3, "
cquery += CRLF+" COUNT(CASE WHEN BM1_ANO||BM1_MES = TO_CHAR(ADD_MONTHS(TO_DATE('"+cAMFim +"' ,'YYYYMM'),-3 ),'YYYYMM') THEN (DECODE(BM1_CODTIP,'101',1,NULL)) ELSE NULL END) M3Q, "
cquery += CRLF+" MAX(CASE WHEN BM1_ANO||BM1_MES = TO_CHAR(ADD_MONTHS(TO_DATE('"+cAMFim +"' ,'YYYYMM'),-3 ),'YYYYMM') THEN (DECODE(TRIM(BM1_NUMTIT),NULL,' ',BM1_PREFIX ||'-'||BM1_NUMTIT ||'-'||BM1_TIPTIT||'-'||(TO_CHAR(TO_DATE(trim(e1_baixa) ,'YYYYMMDD'), 'DD/MM/YY')))) ELSE ' ' END) M3T ,"
                            
cquery += CRLF+" SUM(CASE WHEN BM1_ANO||BM1_MES = TO_CHAR(ADD_MONTHS(TO_DATE('"+cAMFim +"' ,'YYYYMM'),-2 ),'YYYYMM') THEN (DECODE(BM1_TIPO,'1',1,-1) * BM1_VALOR) ELSE 0 END) M2, "
cquery += CRLF+" COUNT(CASE WHEN BM1_ANO||BM1_MES = TO_CHAR(ADD_MONTHS(TO_DATE('"+cAMFim +"' ,'YYYYMM'),-2 ),'YYYYMM') THEN (DECODE(BM1_CODTIP,'101',1,NULL)) ELSE NULL END) M2Q, "
cquery += CRLF+" MAX(CASE WHEN BM1_ANO||BM1_MES = TO_CHAR(ADD_MONTHS(TO_DATE('"+cAMFim +"' ,'YYYYMM'),-2 ),'YYYYMM') THEN (DECODE(TRIM(BM1_NUMTIT),NULL,' ',BM1_PREFIX ||'-'||BM1_NUMTIT ||'-'||BM1_TIPTIT||'-'||(TO_CHAR(TO_DATE(trim(e1_baixa) ,'YYYYMMDD'), 'DD/MM/YY')))) ELSE ' ' END) M2T ,"

cquery += CRLF+" SUM(CASE WHEN BM1_ANO||BM1_MES = TO_CHAR(ADD_MONTHS(TO_DATE('"+cAMFim +"' ,'YYYYMM'),-1 ),'YYYYMM') THEN (DECODE(BM1_TIPO,'1',1,-1) * BM1_VALOR) ELSE 0 END) M1, "
cquery += CRLF+" COUNT(CASE WHEN BM1_ANO||BM1_MES = TO_CHAR(ADD_MONTHS(TO_DATE('"+cAMFim +"' ,'YYYYMM'),-1 ),'YYYYMM') THEN (DECODE(BM1_CODTIP,'101',1,NULL)) ELSE NULL END) M1Q, "
cquery += CRLF+" MAX(CASE WHEN BM1_ANO||BM1_MES = TO_CHAR(ADD_MONTHS(TO_DATE('"+cAMFim +"' ,'YYYYMM'),-1 ),'YYYYMM') THEN (DECODE(TRIM(BM1_NUMTIT),NULL,' ',BM1_PREFIX ||'-'||BM1_NUMTIT ||'-'||BM1_TIPTIT||'-'||(TO_CHAR(TO_DATE(trim(e1_baixa) ,'YYYYMMDD'), 'DD/MM/YY')))) ELSE ' ' END) M1T ,"

cquery += CRLF+" SUM(CASE WHEN BM1_ANO||BM1_MES = TO_CHAR(ADD_MONTHS(TO_DATE('"+cAMFim +"' ,'YYYYMM'),0  ),'YYYYMM') THEN (DECODE(BM1_TIPO,'1',1,-1) * BM1_VALOR) ELSE 0 END) M0 ,"
cquery += CRLF+" COUNT(CASE WHEN BM1_ANO||BM1_MES = TO_CHAR(ADD_MONTHS(TO_DATE('"+cAMFim +"' ,'YYYYMM'),0  ),'YYYYMM') THEN (DECODE(BM1_CODTIP,'101',1,NULL)) ELSE NULL END) M0Q ,"
cquery += CRLF+" MAX(CASE WHEN BM1_ANO||BM1_MES = TO_CHAR(ADD_MONTHS(TO_DATE('"+cAMFim +"' ,'YYYYMM'),0  ),'YYYYMM') THEN (DECODE(TRIM(BM1_NUMTIT),NULL,' ',BM1_PREFIX ||'-'||BM1_NUMTIT ||'-'||BM1_TIPTIT||'-'||(TO_CHAR(TO_DATE(trim(e1_baixa) ,'YYYYMMDD'), 'DD/MM/YY')))) ELSE ' '  END ) M0T "
 
cquery += CRLF+" FROM BM1020 BM1 , BQC020 BQC , SE1020 SE1 "                            
cquery += CRLF+" WHERE BM1_FILIAL = ' ' AND BM1.D_E_L_E_T_ = ' ' AND BQC_FILIAL = ' ' AND BQC.D_E_L_E_T_ = ' ' AND E1_FILIAL = '01' AND SE1.D_E_L_E_T_ = ' ' "
cquery += CRLF+" AND BQC_NUMCON = BM1_CONEMP AND BQC_VERCON = BM1_VERCON AND BQC_SUBCON = BM1_SUBCON AND BQC_VERSUB = BM1_VERSUB AND BQC_CODEMP = BM1_CODEMP "
cquery += CRLF+" AND BM1_PREFIX = E1_PREFIXO AND BM1_NUMTIT = E1_NUM AND E1_parcela = BM1_PARCEL and BM1_TIPTIT = e1_tipo AND BM1_CODTIP NOT IN ('108')" 

// cEmpresInc//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

cquery += CRLF+" AND BM1_CODEMP >= '"+cEmpresInc+"' AND BM1_CODEMP <= '"+cEmpresFim+"'"
cquery += CRLF+" AND BM1_ANO ||BM1_MES >= '"+cAMInc +"' and  BM1_ANO ||BM1_MES <= '"+cAMFim +"'

cquery += CRLF+" GROUP BY bm1_codemp , bqc_descri   "
cquery += CRLF+" ORDER BY BM1_CODEMP  "
*/
/////////////////////////////////////////
cquery :=      " SELECT bxq_codemp ||' - ' || bg9_descri  emp , " 
cquery += CRLF+" SUM(CASE WHEN Bxq_ANO||Bxq_MES = TO_CHAR(ADD_MONTHS(TO_DATE('"+cAMFim +"' ,'YYYYMM'),0),'YYYYMM') THEN  Bxq_bascom ELSE 0 END) B5 , "
cquery += CRLF+" SUM(CASE WHEN Bxq_ANO||Bxq_MES = TO_CHAR(ADD_MONTHS(TO_DATE('"+cAMFim +"' ,'YYYYMM'),0),'YYYYMM') THEN  Bxq_vlrcom ELSE 0 END) C5 , "
cquery += CRLF+" COUNT(CASE WHEN Bxq_ANO||Bxq_MES = TO_CHAR(ADD_MONTHS(TO_DATE('"+cAMFim +"' ,'YYYYMM'),0),'YYYYMM') THEN 1 ELSE NULL END) Q5 , "
       
cquery += CRLF+" SUM(CASE WHEN Bxq_ANO||Bxq_MES = TO_CHAR(ADD_MONTHS(TO_DATE('"+cAMFim +"' ,'YYYYMM'),-1),'YYYYMM') THEN  Bxq_bascom ELSE 0 END) B4 , "
cquery += CRLF+" SUM(CASE WHEN Bxq_ANO||Bxq_MES = TO_CHAR(ADD_MONTHS(TO_DATE('"+cAMFim +"' ,'YYYYMM'),-1),'YYYYMM') THEN  Bxq_vlrcom ELSE 0 END) C4 , "
cquery += CRLF+" COUNT(CASE WHEN Bxq_ANO||Bxq_MES = TO_CHAR(ADD_MONTHS(TO_DATE('"+cAMFim +"'  ,'YYYYMM'),-1),'YYYYMM') THEN 1 ELSE NULL END) Q4 , "

cquery += CRLF+" SUM(CASE WHEN Bxq_ANO||Bxq_MES = TO_CHAR(ADD_MONTHS(TO_DATE('"+cAMFim +"' ,'YYYYMM'),-2),'YYYYMM') THEN  Bxq_bascom ELSE 0 END) B3 , "
cquery += CRLF+" SUM(CASE WHEN Bxq_ANO||Bxq_MES = TO_CHAR(ADD_MONTHS(TO_DATE('"+cAMFim +"' ,'YYYYMM'),-2),'YYYYMM') THEN  Bxq_vlrcom ELSE 0 END) C3 , "
cquery += CRLF+" COUNT(CASE WHEN Bxq_ANO||Bxq_MES = TO_CHAR(ADD_MONTHS(TO_DATE('"+cAMFim +"' ,'YYYYMM'),-2),'YYYYMM') THEN 1 ELSE NULL END) Q3 , "

cquery += CRLF+" SUM(CASE WHEN Bxq_ANO||Bxq_MES = TO_CHAR(ADD_MONTHS(TO_DATE('"+cAMFim +"' ,'YYYYMM'),-3),'YYYYMM') THEN  Bxq_bascom ELSE 0 END) B2 , "
cquery += CRLF+" SUM(CASE WHEN Bxq_ANO||Bxq_MES = TO_CHAR(ADD_MONTHS(TO_DATE('"+cAMFim +"' ,'YYYYMM'),-3),'YYYYMM') THEN  Bxq_vlrcom ELSE 0 END) C2 , "
cquery += CRLF+" COUNT(CASE WHEN Bxq_ANO||Bxq_MES = TO_CHAR(ADD_MONTHS(TO_DATE('"+cAMFim +"' ,'YYYYMM'),-3),'YYYYMM') THEN 1 ELSE NULL END) Q2 , "

cquery += CRLF+" SUM(CASE WHEN Bxq_ANO||Bxq_MES = TO_CHAR(ADD_MONTHS(TO_DATE('"+cAMFim +"' ,'YYYYMM'),-4),'YYYYMM') THEN  Bxq_bascom ELSE 0 END) B1 , "
cquery += CRLF+" SUM(CASE WHEN Bxq_ANO||Bxq_MES = TO_CHAR(ADD_MONTHS(TO_DATE('"+cAMFim +"' ,'YYYYMM'),-4),'YYYYMM') THEN  Bxq_vlrcom ELSE 0 END) C1 , "
cquery += CRLF+" COUNT(CASE WHEN Bxq_ANO||Bxq_MES = TO_CHAR(ADD_MONTHS(TO_DATE('"+cAMFim +"' ,'YYYYMM'),-4),'YYYYMM') THEN 1 ELSE NULL END) Q1 , "       

cquery += CRLF+" SUM(CASE WHEN Bxq_ANO||Bxq_MES = TO_CHAR(ADD_MONTHS(TO_DATE('"+cAMFim +"' ,'YYYYMM'),-5),'YYYYMM') THEN  Bxq_bascom ELSE 0 END) B0 , "
cquery += CRLF+" SUM(CASE WHEN Bxq_ANO||Bxq_MES = TO_CHAR(ADD_MONTHS(TO_DATE('"+cAMFim +"' ,'YYYYMM'),-5),'YYYYMM') THEN  Bxq_vlrcom ELSE 0 END) C0 , "
cquery += CRLF+" COUNT(CASE WHEN Bxq_ANO||Bxq_MES = TO_CHAR(ADD_MONTHS(TO_DATE('"+cAMFim +"' ,'YYYYMM'),-5),'YYYYMM') THEN 1 ELSE NULL END) Q0 "
        
cquery += CRLF+" FROM  " + RetSqlName("BXQ")+" BXQ , " + RetSqlName("BG9")+" BG9 "
cquery += CRLF+" WHERE BXQ_FILIAL = '"+xFilial("BXQ")+"'  AND Bxq.D_E_L_E_T_ = ' ' "   
cquery += CRLF+" AND Bg9_FILIAL = '"+xFilial("BG9")+"' AND Bg9.D_E_L_E_T_ = ' ' "
cquery += CRLF+" AND bg9_codint = bxq_codint and Bg9_CODigo = Bxq_CODEMP "
cquery += CRLF+" AND Bxq_CODEMP >= '"+cEmpresInc+"' AND Bxq_CODEMP <= '"+cEmpresFim+"' "
cquery += CRLF+" AND Bxq_ANO ||Bxq_MES >= '"+cAMInc +"' and  Bxq_ANO ||Bxq_MES <= '"+cAMFim +"' "
cquery += CRLF+" and bxq_pagcom = bxq_refere "
cquery += CRLF+" GROUP BY bxq_codemp , bg9_descri "  
 
 ///////////////////////////////

cquery1 :=       " SELECT bxq_codemp ||' - ' || bg9_descri  emp ,  Bxq_ANO || Bxq_MES , "
cquery1 += CRLF+       " SUM(CASE WHEN Bxq_ANO||Bxq_MES = TO_CHAR(ADD_MONTHS(TO_DATE('"+cAMFim +"' ,'YYYYMM'),0),'YYYYMM') THEN  Bxq_bascom ELSE 0 END) B0P, "
cquery1 += CRLF+       " SUM(CASE WHEN Bxq_ANO||Bxq_MES = TO_CHAR(ADD_MONTHS(TO_DATE('"+cAMFim +"' ,'YYYYMM'),0),'YYYYMM') THEN ((Bxq_bascom*BXP_PERCON)/100) ELSE 0 END) C0P, "
cquery1 += CRLF+       " COUNT(CASE WHEN Bxq_ANO||Bxq_MES = TO_CHAR(ADD_MONTHS(TO_DATE('"+cAMFim +"' ,'YYYYMM'),0),'YYYYMM') THEN 1 ELSE NULL END) Q0P  "
        
cquery1 += CRLF+  "  FROM " + RetSqlName("BXQ")+" BXQ , " + RetSqlName("BG9")+" BG9 , " + RetSqlName("BXO")+" BXO , " + RetSqlName("BXP")+" BXP "  
cquery1 += CRLF+  " WHERE BxQ_FILIAL = '"+xFilial("BXQ")+"' AND BxQ.D_E_L_E_T_ = ' ' "
cquery1 += CRLF+    " AND BG9_FILIAL = '"+xFilial("BG9")+"' AND BG9.D_E_L_E_T_ = ' ' "
cquery1 += CRLF+    " AND BxO_FILIAL = '"+xFilial("BXO")+"' AND BxO.D_E_L_E_T_ = ' ' "
cquery1 += CRLF+    " AND BxP_FILIAL = '"+xFilial("BXP")+"' AND BxP.D_E_L_E_T_ = ' ' "
cquery1 += CRLF+    " AND bG9_codint = bxQ_codint  and BG9_CODigo = BxQ_CODEMP "

cquery1 += CRLF+    " AND Bxq_CODEMP >= '"+cEmpresInc+"' AND Bxq_CODEMP <= '"+cEmpresFim+"' "

cquery1 += CRLF+    " AND BxQ_ANO||Bxq_MES = (select max(BxQ_ANO || BxQ_MES) from " + RetSqlName("BXQ")+" bxQ1 where bxQ1.BxQ_FILIAL = '"+xFilial("BXQ")+"' AND BxQ1.D_E_L_E_T_ = ' '  and bxQ1.BxQ_CODEMP = bxQ.BxQ_CODEMP) "

cquery1 += CRLF+    " and bxQ_pagcom = bxq_refere  AND BXO_CODEMP = BXQ_CODEMP AND Bxo_MATRIC = BxQ_MATRIC  AND BXO_TIPREG = BXQ_TIPREG "
cquery1 += CRLF+    " AND BXP_SEQBXO = BXO_SEQ     AND BXP_QTDDE <=(bxq_numpar+1)  AND BXP_QTDATE >= (bxq_numpar+1) "
cquery1 += CRLF+    " GROUP BY bxq_codemp , bg9_descri  , Bxq_ANO , Bxq_MES "
cquery1 += CRLF+    " ORDER BY Bxq_CODEMP "
     
/////////////////////////////////////////*
	   	
    If Select((cAliastmp)) <> 0 
       (cAliastmp)->(DbCloseArea()) 
    Endif
  
    TCQuery cQuery New Alias (cAliastmp)  
    
    dbSelectArea(cAliastmp)
   
    (cAliastmp)->(dbGoTop())   

   If Select((cAliastmp1)) <> 0 
       (cAliastmp1)->(DbCloseArea()) 
    Endif
  
    TCQuery cQuery1 New Alias (cAliastmp1)  
    
    dbSelectArea(cAliastmp1)
   
    (cAliastmp1)->(dbGoTop())   
           
    While (cAliastmp)->(!Eof())    
       
       aaDD(aDados1,{(cAliastmp)->emp        ,;  // 1
	   	             (cAliastmp)->B0         ,;  // 2
   	             	 (cAliastmp)->C0         ,;  // 3
	   	             (cAliastmp)->Q0         ,;  // 4 
	   	             iif((cAliastmp)->B0 > 0,Round((((cAliastmp)->C0*100)/(cAliastmp)->B0),2), 0.00),;//5
	   	             (cAliastmp)->B1         ,;  // 6
   	             	 (cAliastmp)->C1         ,;  // 7
	   	             (cAliastmp)->Q1         ,;  // 8  
	   	             iif((cAliastmp)->B1 > 0,Round((((cAliastmp)->C1*100)/(cAliastmp)->B1),2), 0.00),; //9
	   	             (cAliastmp)->B2         ,;  // 10
   	             	 (cAliastmp)->C2         ,;  // 11
	   	             (cAliastmp)->Q2         ,;  // 12
	   	             iif((cAliastmp)->B2 > 0,Round((((cAliastmp)->C2*100)/(cAliastmp)->B2),2), 0.00),;//13
	   	             (cAliastmp)->B3         ,;  // 14
   	             	 (cAliastmp)->C3         ,;  // 15
	   	             (cAliastmp)->Q3         ,;  // 16
	   	             iif((cAliastmp)->B3 > 0,Round((((cAliastmp)->C3*100)/(cAliastmp)->B3),2), 0.00),;//17
	   	             (cAliastmp)->B4         ,;  // 18
   	             	 (cAliastmp)->C4         ,;  // 19
	   	             (cAliastmp)->Q4         ,;  // 20
	   	             iif((cAliastmp)->B4 > 0,Round((((cAliastmp)->C4*100)/(cAliastmp)->B4),2), 0.00),; //21
	   	             (cAliastmp)->B5         ,;  // 22
   	             	 (cAliastmp)->C5         ,;  // 23
	   	             (cAliastmp)->Q5         ,;  // 24                                     
	   	             iif((cAliastmp)->B5 > 0,Round((((cAliastmp)->C5*100)/(cAliastmp)->B5),2), 0.00),;//25
	   	             (cAliastmp1)->B0P       ,;  // 26
   	             	 (cAliastmp1)->C0P       ,;  // 27
	   	             (cAliastmp1)->Q0P       ,;  //28
	   	             iif((cAliastmp1)->B0P > 0,Round((((cAliastmp1)->C0P*100)/(cAliastmp1)->B0P),2), 0.00)})  // 29               
       (cAliastmp)->(dbSkip()) 	    
       (cAliastmp1)->(dbSkip()) 	   
     EndDo	                   
Return    
*************************************************************************************************************
  
Static Function fGeraDt (CAnoMes) 

local nCompM:= val(substr(CAnoMes,5,2))   
local nCompA:= val(substr(CAnoMes,1,4))   
          
//cM0 := space(10-len(ltrim(str(nCompM))+'/'+ltrim(str(nCompA))) ) + ltrim(str(nCompM))+'/'+ltrim(str(nCompA))  
cM0 := ltrim(str(nCompM))+'/'+ltrim(str(nCompA)) 
              
if nCompM > 1
   nCompM := nCompM - 1 
   cM1    := ltrim(str(nCompM))+'/'+ltrim(str(nCompA))
else                   
   nCompM := 12 
   nCompA := nCompA - 1                      
   cM1    := ltrim(str(nCompM))+'/'+ltrim(str(nCompA))
EndIf          
if nCompM > 1
   nCompM := nCompM - 1 
   cM2    := ltrim(str(nCompM))+'/'+ltrim(str(nCompA))
else                   
   nCompM := 12 
   nCompA := nCompA - 1                      
   cM2    := ltrim(str(nCompM))+'/'+ltrim(str(nCompA))
EndIf 
if nCompM > 1
   nCompM := nCompM - 1 
   cM3    := ltrim(str(nCompM))+'/'+ltrim(str(nCompA))
else                   
   nCompM := 12 
   nCompA := nCompA - 1                      
   cM3    := ltrim(str(nCompM))+'/'+ltrim(str(nCompA))
EndIf 
if nCompM > 1
   nCompM := nCompM - 1 
   cM4    := ltrim(str(nCompM))+'/'+ltrim(str(nCompA))
else                   
   nCompM := 12 
   nCompA := nCompA - 1                      
   cM4    := ltrim(str(nCompM))+'/'+ltrim(str(nCompA))
EndIf 
if nCompM > 1
   nCompM := nCompM - 1 
   cM5    := ltrim(str(nCompM))+'/'+ltrim(str(nCompA))
else                   
   nCompM := 12 
   nCompA := nCompA - 1                      
   cM5    := ltrim(str(nCompM))+'/'+ltrim(str(nCompA)) 
EndIf 
if nCompM > 1
   nCompM := nCompM - 1 
   cM6    := ltrim(str(nCompM))+'/'+ltrim(str(nCompA)) 
else                   
   nCompM := 12 
   nCompA := nCompA - 1                      
   cM6    := ltrim(str(nCompM))+'/'+ltrim(str(nCompA))  
EndIf 
/*
if nCompM > 1
   nCompM := nCompM - 1 
   cM7    := ltrim(str(nCompM))+'/'+ltrim(str(nCompA)) 
else                   
   nCompM := 12 
   nCompA := nCompA - 1                      
   cM7    := ltrim(str(nCompM))+'/'+ltrim(str(nCompA)) 
EndIf 
if nCompM > 1
   nCompM := nCompM - 1 
   cM8    := ltrim(str(nCompM))+'/'+ltrim(str(nCompA)) 
else                   
   nCompM := 12 
   nCompA := nCompA - 1                      
   cM8    := ltrim(str(nCompM))+'/'+ltrim(str(nCompA)) 
EndIf 
if nCompM > 1
   nCompM := nCompM - 1 
   cM9    := ltrim(str(nCompM))+'/'+ltrim(str(nCompA))
else                   
   nCompM := 12 
   nCompA := nCompA - 1                      
   cM9    := ltrim(str(nCompM))+'/'+ltrim(str(nCompA))
EndIf 
if nCompM > 1
   nCompM := nCompM - 1 
   cM10   := ltrim(str(nCompM))+'/'+ltrim(str(nCompA))
else                   
   nCompM := 12 
   nCompA := nCompA - 1                      
   cM10   := ltrim(str(nCompM))+'/'+ltrim(str(nCompA))
EndIf  
if nCompM > 1
   nCompM := nCompM - 1 
   cM11   := ltrim(str(nCompM))+'/'+ltrim(str(nCompA))
else                   
   nCompM := 12 
   nCompA := nCompA - 1                      
   cM11   := ltrim(str(nCompM))+'/'+ltrim(str(nCompA))
EndIf
*/        
return (ltrim(str(nCompA)) + ltrim(str(nCompM)))
*************************************************************************************************************  
Static Function fGeraRel2

Local oReport 
Private cPerg		:= "CABR178"  
Private aOrdem 		:= {}//{'RDA','Ano/Mes'}

//aSort( aDados1,,,{|x,y| x[10] < y[10]} )

oReport:= ReportDef2()
oReport:PrintDialog()

Return

*************************************************************************************************************
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportDef ³ Autor ³ Leonardo Portella                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³A funcao estatica ReportDef devera ser criada para todos os ³±±
±±³          ³relatorios que poderao ser agendados pelo usuario.          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ExpO1: Objeto do relatorio                                  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/                         

Static Function ReportDef2()

Local oReport 
Local oDPJ
//Local oDPJ1     
oReport	:= TReport():New("CABR178","Acompanhamento de Comissao por  empresa  - analise gerencial",, {|oReport| ReportPrt(oReport)},"Acompanhamento de Comissao por  empresa  - analise gerencial")
oReport:SetTotalInLine(.F.)//Imprime na linha: .F. - Imprime abaixo da linha com o titulo de cada coluna: .T.
//oReport:SetTotalText('Total Geral') 

*'-----------------------------------------------------------------------------------'*
*'Solucao para impressao em que as colunas se truncam: "SetColSpace" e "SetLandScape"'* 
*'-----------------------------------------------------------------------------------'*

oReport:SetColSpace(1) //Espacamento entre colunas. 
oReport:SetLandscape() //Impressao em paisagem.  
//oReport:SetPortrait() //Impressao em retrato.  

oDPJ := TRSection():New(oReport,"Acompanhamento de Comissao por  empresa  - analise gerencial",,aOrdem)             

   TRCell():New(oDPJ ,'EMPRES'	   		,/*TABELA*/	,'Empresa' 	             ,/*Picture*/   ,07			,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
   TRCell():New(oDPJ ,'DESEMP'	   		,/*TABELA*/	,' ' 	                 ,/*Picture*/   ,16			,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)   
   TRCell():New(oDPJ , 'esp1'  		    ,/*TABELA*/	,space(07)               ,/*Picture*/   ,07			,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
   TRCell():New(oDPJ , 'esp2' 	    	,/*TABELA*/	,space(16) 	             ,/*Picture*/   ,16			,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)  


   TRCell():New(oDPJ ,'B0'	     		,/*TABELA*/	, cM0                    ,/*Picture*/   ,11			,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT"		)    
   TRCell():New(oDPJ ,'C0'	     		,/*TABELA*/	, ' '                    ,/*Picture*/   ,11			,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT"	    )    

   TRCell():New(oDPJ ,'Q0'	     		,/*TABELA*/	, 'Qtda %'               ,/*Picture*/   ,04    		,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT"	    ) 
   TRCell():New(oDPJ ,'P0'	     		,/*TABELA*/	, ' '                    ,/*Picture*/   ,04			,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT"	    )      
   
   TRCell():New(oDPJ ,'B1'	     		,/*TABELA*/	, cM1                    ,/*Picture*/   ,11			,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT"		)    
   TRCell():New(oDPJ ,'C1'	     		,/*TABELA*/	, ' '                    ,/*Picture*/   ,11			,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT"	    )    

   TRCell():New(oDPJ ,'Q1'	     		,/*TABELA*/	, 'Qtda %'               ,/*Picture*/   ,04			,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT"	    ) 
   TRCell():New(oDPJ ,'P1'	     		,/*TABELA*/	, ' '                    ,/*Picture*/   ,04			,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT"	    )         
   
   TRCell():New(oDPJ ,'B2'	     		,/*TABELA*/	, cM2                    ,/*Picture*/   ,11			,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT"		)    
   TRCell():New(oDPJ ,'C2'	     		,/*TABELA*/	, ' '                    ,/*Picture*/   ,11			,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT"	    )    

   TRCell():New(oDPJ ,'Q2'	     		,/*TABELA*/	, 'Qtda %'               ,/*Picture*/   ,04			,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT"	    ) 
   TRCell():New(oDPJ ,'P2'	     		,/*TABELA*/	, ' '                    ,/*Picture*/   ,04			,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT"	    )        

   TRCell():New(oDPJ ,'B3'	     		,/*TABELA*/	, cM3                    ,/*Picture*/   ,11			,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT"		)    
   TRCell():New(oDPJ ,'C3'	     		,/*TABELA*/	, ' '                    ,/*Picture*/   ,11			,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT"	    )    

   TRCell():New(oDPJ ,'Q3'	     		,/*TABELA*/	, 'Qtda %'               ,/*Picture*/   ,04			,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT"	    ) 
   TRCell():New(oDPJ ,'P3'	     		,/*TABELA*/	, ' '                    ,/*Picture*/   ,04			,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT"	    )        
                        
   TRCell():New(oDPJ ,'B4'	     		,/*TABELA*/	, cM4                    ,/*Picture*/   ,11			,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT"		)    
   TRCell():New(oDPJ ,'C4'	     		,/*TABELA*/	, ' '                    ,/*Picture*/   ,11			,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT"	    )    

   TRCell():New(oDPJ ,'Q4'	     		,/*TABELA*/	, 'Qtda %'               ,/*Picture*/   ,04			,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT"	    ) 
   TRCell():New(oDPJ ,'P4'	     		,/*TABELA*/	, ' '                    ,/*Picture*/   ,04			,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT"	    )        

   TRCell():New(oDPJ ,'B5'	     		,/*TABELA*/	, cM5                    ,/*Picture*/   ,11			,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT"		)    
   TRCell():New(oDPJ ,'C5'	     		,/*TABELA*/	, ' '                    ,/*Picture*/   ,11			,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT"	    )    

   TRCell():New(oDPJ ,'Q5'	     		,/*TABELA*/	, 'Qtda %'               ,/*Picture*/   ,04			,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT"	    ) 
   TRCell():New(oDPJ ,'P5'	     		,/*TABELA*/	, ' '                    ,/*Picture*/   ,04			,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT"	    )        
    
   TRCell():New(oDPJ ,'B6'	     		,/*TABELA*/	, "Previsto"             ,/*Picture*/   ,11			,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT"		)    
   TRCell():New(oDPJ ,'C6'	     		,/*TABELA*/	, ' '                    ,/*Picture*/   ,11			,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT"	    )    

   TRCell():New(oDPJ ,'Q6'	     		,/*TABELA*/	, 'Qtda %'               ,/*Picture*/   ,04			,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT"	    ) 
   TRCell():New(oDPJ ,'P6'	     		,/*TABELA*/	, ' '                    ,/*Picture*/   ,04			,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT"	    )        

 
oBreak01 		:= TRBreak():New(oDPJ,oDPJ:Cell("EMPRES"),"Total por Empresa "	,.F.)  

lTotSecBrk01	:= .F.//Indica se totalizador sera impresso na quebra de secao
lTotFimBrk01	:= .F.//Indica se totalizador sera impresso no final do relatorio - Como o total eh o mesmo, basta que apenas um esteja ativado

                                                                   
 TRFunction():New(oDPJ:Cell("EMPRES")    	    ,NIL,"count"		,oBreak01,,"@E 9,999"	,/*uFormula*/	,lTotSecBrk01,lTotFimBrk01) 

//********************************************************/ 
 
//  oDPJ1:= TRSection():New(oReport,"Acompanhamento de Comissao por  empresa  - analise gerencial",,aOrdem)             
                                                                                                                                                                            
//   TRCell():New(oDPJ1 , space(07)  		,/*TABELA*/	,' '     	             ,/*Picture*/   ,07			,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
//   TRCell():New(oDPJ1 , space(16) 		,/*TABELA*/	,' ' 	                 ,/*Picture*/   ,16			,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)   
   
//   TRCell():New(oDPJ1 ,'C0'	     		,/*TABELA*/	, cM0                       ,/*Picture*/   ,11				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT"		)    
//   TRCell():New(oDPJ1 ,'P0'	     		,/*TABELA*/	, '%'                       ,/*Picture*/   ,04				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT"		)   
//   TRCell():New(oDPJ1 ,'C1'      		,/*TABELA*/	, cM1                       ,/*Picture*/   ,11				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT"	   	)   
//   TRCell():New(oDPJ1 ,'P1'      		,/*TABELA*/	, '%'                       ,/*Picture*/   ,04				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT"		)   
//   TRCell():New(oDPJ1 ,'C2'	     		,/*TABELA*/	, cM2                       ,/*Picture*/   ,11				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT"		)   
//   TRCell():New(oDPJ1 ,'P2'      		,/*TABELA*/	, '%'                       ,/*Picture*/   ,04				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT"		)   
//   TRCell():New(oDPJ1 ,'C3'	     		,/*TABELA*/	, cM3                       ,/*Picture*/   ,11				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT"		)   
//   TRCell():New(oDPJ1 ,'P3'      		,/*TABELA*/	, '%'                       ,/*Picture*/   ,04				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT"		)   
//   TRCell():New(oDPJ1 ,'C4'	     		,/*TABELA*/	, cM4                       ,/*Picture*/   ,11				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT"	 	)   
//   TRCell():New(oDPJ1 ,'P4'      		,/*TABELA*/	, '%'                       ,/*Picture*/   ,04				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT"		)   
//   TRCell():New(oDPJ1 ,'C5'	     		,/*TABELA*/	, cM5                       ,/*Picture*/   ,11				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT"		)   
//   TRCell():New(oDPJ1 ,'P5'      		,/*TABELA*/	, '%'                       ,/*Picture*/   ,04				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT"		)   
//   TRCell():New(oDPJ1 ,'C6'	     		,/*TABELA*/	, cM6                       ,/*Picture*/   ,11				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT"		)    
//  TRCell():New(oDPJ1 ,'P6'      		,/*TABELA*/	, '%'                       ,/*Picture*/   ,04				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT"		)   
 
//oBreak01 		:= TRBreak():New(oDPJ1,oDPJ1:Cell("EMPRES"),"Total por Empresa "	,.F.)  

//lTotSecBrk02	:= .F.//Indica se totalizador sera impresso na quebra de secao
//lTotFimBrk02	:= .F.//Indica se totalizador sera impresso no final do relatorio - Como o total eh o mesmo, basta que apenas um esteja ativado

                                                                
 //TRFunction():New(oDPJ:Cell("EMPRES")    	    ,NIL,"count"		,oBreak01,,"@E 9,999"	,/*uFormula*/	,lTotSecBrk01,lTotFimBrk01) 

Return(oReport)

********************************************************************************************************************************

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportPrint³ Autor ³ Leonardo Portella                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³A funcao estatica ReportDef devera ser criada para todos os ³±±
±±³          ³relatorios que poderao ser agendados pelo usuario.          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function ReportPrt(oReport)

Local   cImp    :='Não'

Local i := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

Private oDPJ 	:= oReport:Section(1)      
//Private oDPJ1 	:= oReport:Section(2)

Private nCont	:= 0   

nCont := Len(aDados1)

//Se nao tiver esta linha, nao imprime os dados
oDPJ:init() 
//oDPJ1:init()

oReport:SetMeter(nCont) 

cTot	:= AllTrim(Transform(nCont,'@E 999,999,999,999'))
nCont 	:= 0       

For i := 1 To Len(aDados1)

	oReport:SetMsgPrint("Imprimindo linha " + AllTrim(Transform(++nCont,'@E 999,999,999,999')) + ' de ' + cTot)

	oReport:IncMeter()

	If oReport:Cancel()  
	    
	    oReport:FatLine()     
	    oReport:PrintText('Cancelado pelo operador!!!',,,CLR_RED,,,.T.)
		
	    exit
	    
	EndIf                                                                                      
  
       oDPJ:Cell('EMPRES'	 		):SetValue(SUBSTR(aDados1[i][1],1,4))     
       oDPJ:Cell('DESEMP'	 		):SetValue(SUBSTR(aDados1[i][1],5,16))
       oDPJ:Cell('B0'   	 		):SetValue(Transform(aDados1[i][02],'@E 9,999,999.99'))     
       oDPJ:Cell('C0'   	 		):SetValue(Transform(aDados1[i][03],'@E 9,999,999.99'))         
       oDPJ:Cell('Q0'   	 		):SetValue(Transform(aDados1[i][04],'@E 9,999'))          
       oDPJ:Cell('P0'   	 		):SetValue(Transform(aDados1[i][05],'@E 99.99'))           
       oDPJ:Cell('B1'   	 		):SetValue(Transform(aDados1[i][06],'@E 9,999,999.99')) 
       oDPJ:Cell('C1'   	 		):SetValue(Transform(aDados1[i][07],'@E 9,999,999.99'))  
       oDPJ:Cell('Q1'   	 		):SetValue(Transform(aDados1[i][08],'@E 9,999'))  
       oDPJ:Cell('P1'   	 		):SetValue(Transform(aDados1[i][09],'@E 99.99'))          
       oDPJ:Cell('B2'   	 		):SetValue(Transform(aDados1[i][10],'@E 9,999,999.99'))  
       oDPJ:Cell('C2'   	 		):SetValue(Transform(aDados1[i][11],'@E 9,999,999.99'))     
       oDPJ:Cell('Q2'   	 		):SetValue(Transform(aDados1[i][12],'@E 9,999'))     
       oDPJ:Cell('P2'   	 		):SetValue(Transform(aDados1[i][13],'@E 99.99'))               
       oDPJ:Cell('B3'   	 		):SetValue(Transform(aDados1[i][14],'@E 9,999,999.99'))   
       oDPJ:Cell('C3'   	 		):SetValue(Transform(aDados1[i][15],'@E 9,999,999.99'))         
       oDPJ:Cell('Q3'   	 		):SetValue(Transform(aDados1[i][16],'@E 9,999'))      
       oDPJ:Cell('P3'   	 		):SetValue(Transform(aDados1[i][17],'@E 99.99'))      
       oDPJ:Cell('B4'   	 		):SetValue(Transform(aDados1[i][18],'@E 9,999,999.99'))       
       oDPJ:Cell('C4'   	 		):SetValue(Transform(aDados1[i][19],'@E 9,999,999.99'))       
       oDPJ:Cell('Q4'   	 		):SetValue(Transform(aDados1[i][20],'@E 9999'))             
       oDPJ:Cell('P4'   	 		):SetValue(Transform(aDados1[i][21],'@E 99.99'))                    
       oDPJ:Cell('B5'   	 		):SetValue(Transform(aDados1[i][22],'@E 9,999,999.99'))      
       oDPJ:Cell('C5'   	 		):SetValue(Transform(aDados1[i][23],'@E 9,999,999.99'))      
       oDPJ:Cell('Q5'   	 		):SetValue(Transform(aDados1[i][24],'@E 9,999'))            
       oDPJ:Cell('P5'   	 		):SetValue(Transform(aDados1[i][25],'@E 99.99'))                   
       oDPJ:Cell('B6'   	 		):SetValue(Transform(aDados1[i][26],'@E 9,999,999.99'))       
       oDPJ:Cell('C6'   	 		):SetValue(Transform(aDados1[i][27],'@E 9,999,999.99'))       
       oDPJ:Cell('Q6'   	 		):SetValue(Transform(aDados1[i][28],'@E 9,999'))   
       oDPJ:Cell('P6'   	 		):SetValue(Transform(aDados1[i][29],'@E 99.99'))      

       oDPJ:Cell('EMPRES'	 		):SHOW()     
       oDPJ:Cell('DESEMP'	 		):SHOW()
       oDPJ:Cell('B0'   	 		):SHOW()
       oDPJ:Cell('Q0'   	 		):SHOW()
       oDPJ:Cell('B1'   	 		):SHOW()
       oDPJ:Cell('Q1'   	 		):SHOW()
       oDPJ:Cell('B2'   	 		):SHOW()     
       oDPJ:Cell('Q2'   	 		):SHOW()   
       oDPJ:Cell('B3'   	 		):SHOW()     
       oDPJ:Cell('Q3'   	 		):SHOW()      
       oDPJ:Cell('B4'   	 		):SHOW()     
       oDPJ:Cell('Q4'   	 		):SHOW()          
       oDPJ:Cell('B5'   	 		):SHOW()    
       oDPJ:Cell('Q5'   	 		):SHOW()           
       oDPJ:Cell('B6'   	 		):SHOW()     
       oDPJ:Cell('Q6'   	 		):SHOW() 
          
       oDPJ:Cell('esp1'   	 		):HIDE() 
       oDPJ:Cell('esp2'   	 		):HIDE()
       oDPJ:Cell('C0'   	 		):HIDE()     
       oDPJ:Cell('P0'   	 		):HIDE()    
       oDPJ:Cell('C1'   	 		):HIDE()  
       oDPJ:Cell('P1'   	 		):HIDE()  
       oDPJ:Cell('C2'   	 		):HIDE()     
       oDPJ:Cell('P2'   	 		):HIDE()
       oDPJ:Cell('C3'   	 		):HIDE()
       oDPJ:Cell('P3'   	 		):HIDE()
       oDPJ:Cell('C4'   	 		):HIDE()
       oDPJ:Cell('P4'   	 		):HIDE()
       oDPJ:Cell('C5'   	 		):HIDE()
       oDPJ:Cell('P5'   	 		):HIDE()
       oDPJ:Cell('C6'   	 		):HIDE()
       oDPJ:Cell('P6'   	 		):HIDE()

       oDPJ:PrintLine()                                                                  
       
//       ******************************                                                    
       oDPJ:Cell('EMPRES'	 		):HIDE()     
       oDPJ:Cell('DESEMP'	 		):HIDE()
       oDPJ:Cell('B0'   	 		):HIDE()
       oDPJ:Cell('Q0'   	 		):HIDE()
       oDPJ:Cell('B1'   	 		):HIDE()
       oDPJ:Cell('Q1'   	 		):HIDE()
       oDPJ:Cell('B2'   	 		):HIDE()     
       oDPJ:Cell('Q2'   	 		):HIDE()   
       oDPJ:Cell('B3'   	 		):HIDE()     
       oDPJ:Cell('Q3'   	 		):HIDE()      
       oDPJ:Cell('B4'   	 		):HIDE()     
       oDPJ:Cell('Q4'   	 		):HIDE()          
       oDPJ:Cell('B5'   	 		):HIDE()    
       oDPJ:Cell('Q5'   	 		):HIDE()           
       oDPJ:Cell('B6'   	 		):HIDE()     
       oDPJ:Cell('Q6'   	 		):HIDE()
       oDPJ:Cell('esp1'   	 		):SHOW() 
       oDPJ:Cell('esp2'   	 		):SHOW()    
       oDPJ:Cell('C0'   	 		):SHOW()     
       oDPJ:Cell('P0'   	 		):SHOW()    
       oDPJ:Cell('C1'   	 		):SHOW()  
       oDPJ:Cell('P1'   	 		):SHOW()  
       oDPJ:Cell('C2'   	 		):SHOW()     
       oDPJ:Cell('P2'   	 		):SHOW()
       oDPJ:Cell('C3'   	 		):SHOW()
       oDPJ:Cell('P3'   	 		):SHOW()
       oDPJ:Cell('C4'   	 		):SHOW()
       oDPJ:Cell('P4'   	 		):SHOW()
       oDPJ:Cell('C5'   	 		):SHOW()
       oDPJ:Cell('P5'   	 		):SHOW()
       oDPJ:Cell('C6'   	 		):SHOW()
       oDPJ:Cell('P6'   	 		):SHOW()  

      oDPJ:PrintLine() 
Next i
oDPJ:Finish() 
//oDPJ1:Finish()

Return   

******************************************************************************************

Static Function AjustaSX1(cPerg)

Local aHelpPor := {}

PutSx1(cPerg,"01",OemToAnsi("Cod. Empresa Incial ") 	   ,"","","mv_ch1","C",04,0,0,"G","","","","","mv_par01","","","","","","","","","","","","","","","","","",{},{})      
PutSx1(cPerg,"02",OemToAnsi("Cod. Empresa Final  ") 	   ,"","","mv_ch2","C",04,0,0,"G","","","","","mv_par02","","","","","","","","","","","","","","","","","",{},{})     

PutSx1(cPerg,"03",OemToAnsi("Listar Empr. Bloqueada ") 	   ,"","","mv_ch3","N",01,0,0,"C","","","","","mv_par03","Sim","","","","Não","","","","","","","","","","","",{},{},{})   
PutSx1(cPerg,"04",OemToAnsi("Calc. Previsto Empr. Bloq. ") ,"","","mv_ch3","N",01,0,0,"C","","","","","mv_par04","Sim","","","","Não","","","","","","","","","","","",{},{},{})  

PutSx1(cPerg,"05",OemToAnsi("Gerar Excel ") 	           ,"","","mv_ch3","N",01,0,0,"C","","","","","mv_par05","Sim","","","","Não","","","","","","","","","","","",{},{},{})  

Pergunte(cPerg,.F.)

Return

