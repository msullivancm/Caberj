
#INCLUDE "rwmake.ch"
#INCLUDE "topconn.ch"
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ CABR102  º Autor ³ Altamiro Affonso   º Data ³  05/10/10   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Relatorio De titlios liberados X produçaõ recebida         º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP6 IDE                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function CABR103

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracao de Variaveis                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

Local cDesc1         := "Este programa tem como objetivo imprimir relatorio "
Local cDesc2         := "de titlos a pagar x Produção medica por competencia "
Local cDesc3         := " Sintetico e analistico e conferencia  "
Local cPict          := " "
Local titulo         := "POSIÇÃO DE TITULOS A PAGAR POR COMPETENCIA   "
Local nLin           := 80 			

Local Cabec1         :=  "          Conferencia - Titulos Produzidos  -  Lotes Produzidos -  Debitos/Creditos Lancados"                    
Local Cabec2         := "    Dt.Movim.  Vl.Movim.     Tp Mot.Bx Historico "
Local imprime        := .T.
Local aOrd           := {}
Private lEnd         := .F.
Private lAbortPrint  := .F.
Private CbTxt        := ""
Private limite       := 80
Private tamanho      := "G"
Private nomeprog     := "CABR103"
Private nTipo        := 15
Private aReturn      := { "Zebrado", 1, "Administracao", 1, 2, 1, "", 1}
Private nLastKey     := 0
Private cbtxt        := Space(10)
Private cbcont       := 00
Private CONTFL       := 01
Private m_pag        := 01
Private wnrel        := "CABR103"
Private cString      := "SE2"
Private cPerg        := "CABR103   " 

dbSelectArea("SE2")
dbSetOrder(1)

ValidPerg(cPerg)
If Pergunte(cPerg,.T.) = .F.
	Return
Endif
Private cComptI      := mv_par01 
Private cComptF      := mv_par02
Private cFornDe      := mv_par03 
Private cFornAte     := mv_par04
Private cRdaDe       := mv_par05 
Private cRdaAte      := mv_par06
Private cResConf     := mv_par07 //1 -sim, 2- Nao
Private cSintAnal    := mv_par08 //1 -sintetico, 2- Analitico
Private cGeraExc     := mv_par09 //1 -sim, 2- Nao      
Private cProced      := mv_par10 //1 -Co-participaçao , 2- Custo , 3 -Ambos
Private cFase1       := mv_par11 //1-Digitação,2-Conferencia ,3-Ativa,4-Faturada 
Private cSituac      := mv_par12 //1-Ativa ,2-Canc./Bloqueada 
Private cEmpInic     := mv_par13
Private cEmpFim      := mv_par14 
Private cMatrInic    := mv_par15
Private cMatrFim     := mv_par16 
Private cPlaInic     := mv_par17
Private cPlaFim      := mv_par18

Private cContQbc     := " "       
private VLRPAGTP     := 0.00
private VLRECTP      := 0.00
private VLRPAGTT     := 0.00
private VLRECTT      := 0.00
private Tmcmvlt      := 0.00 
private precet       := 0.00  
private TmtlDt       :="  /      "
private Tmtlvl       :="0,00"           

private  aTitXls     := { } //' ' ,Total C.Pagar, ' ' , Total Guias , ' ' , Total Lotes , ' ' , Total Deb/Cred}
private  aTitulo     := {}
                                        
If cResConf = 1  
   Cabec1 := "          Conferencia - Titulos Produzidos  -  Lotes Produzidos -  Debitos/Creditos Lancados"  
   Cabec2 := "          Total C.Pagar             Total Guias             Total Lotes          Total Deb/Cred "
EndIf   

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

SetRegua(RecCount())    

If cResConf = 1                   
//bd - debito e credito
   cQuedc :=  "SELECT BGQ_ANO ,BGQ_MES ,  Sum (Decode (BGQ_TIPO , '2' ,BGQ_VALOR,(BGQ_VALOR *-1))) valor "
   cQuedc +=  " FROM " + RetSqlName("BGQ")+" BGQ  "
   cQuedc +=  " WHERE BGQ_FILIAL = '"+xFilial("BGQ")+"' AND D_e_l_e_t_ = ' ' "    
   cQuedc +=  " AND  BGQ_ANO||BGQ_MES  >= '" + cComptI + "' AND BGQ_ANO||BGQ_MES  <= '" + cComptF + "'" 
   cQuedc +=  " AND  BGQ_CODLAN <> '050' " 
If !empty (cRdaAte)        
   cQuedc +=  " AND BGQ_CODIGO >= '" + cRdaDe + "' AND BGQ_CODIGO <= '" + cRdaAte + "'"    
EndIf           
   cQuedc +=  " group by BGQ_ANO ,BGQ_MES  "
   cQuedc +=  " ORDER by BGQ_ANO ,BGQ_MES  "
// cp - contas a pagar 

   cQuecp :=  "SELECT  SubStr(E2_PLLOTE,1,6 ) PLLOTE, Sum (E2_VALOR + E2_ISS  + E2_INSS + E2_IRRF  +  E2_VRETPIS + E2_VRETCOF + E2_VRETCSL) VLTIT"
   cQuecp +=  " FROM " + RetSqlName("SE2")+" SE2  "
   cQuecp +=  " WHERE SE2.E2_FILIAL = '"+xFilial("SE2")+"' "
   cQuecp +=  " AND D_e_l_e_t_ = ' ' "                                                      
   If !empty (cRdaAte)  
       cQuecp +=  " AND E2_CODRDA >= '" + cRdaDe + "' AND E2_CODRDA <= '" + cRdaAte + "'"    
   EndIf    
   cQuecp +=  " AND  E2_ANOBASE ||  E2_MESBASE >= '" + cComptI + "' AND E2_ANOBASE || E2_MESBASE <= '" + cComptF + "' "
   cQuecp +=  " AND SubStr (E2_PLLOTE,1,6 ) >= '" + cComptI   + "' AND SubStr (E2_PLLOTE,1,6 )  <= '" + cComptF + "'"    
   cQuecp +=  " AND E2_ORIGEM = 'PLSMPAG'"     
            
   cQuecp +=  " group by SubStr(E2_PLLOTE,1,6 )  "      
   cQuecp +=  " ORDER by SubStr(E2_PLLOTE,1,6 )  "      
  
//Lt - lote de pagamento  
   
   cQuelt :=  " SELECT BAF_ANOLOT ,BAF_MESLOT ,Sum (BAF_VLRBRU) VLLOT 
   cQuelt +=  " FROM " + RetSqlName("BAF")+" BAF  "  
   cQuelt +=  " WHERE BAF.BAF_FILIAL = '"+xFilial("BAF")+"' "
   cQuelt +=  " AND D_E_L_E_T_ = ' '"                                                                             
   cQuelt +=  " AND BAF_ANOLOT ||BAF_MESLOT >= '" + cComptI + "' AND BAF_ANOLOT ||BAF_MESLOT <= '"+ cComptF + "' "
   cQueLt +=  " group by BAF_ANOLOT ,BAF_MESLOT  "      
   cQueLt +=  " ORDER by BAF_ANOLOT ,BAF_MESLOT  "      
                                                           
 //Cm - conta medicas 
   cQuecm :=  " SELECT SubStr (BD7_NUMLOT, 1,6) numlot, Sum (BD7_VLRPAG) VLPAG"
   cQuecm +=  " FROM " + RetSqlName("BD7")+" BD7  "
   cQuecm +=  " WHERE BD7.BD7_FILIAL = '"+xFilial("BD7")+"' "
   cQuecm +=  " AND D_e_l_e_t_ = ' ' "        
   cQuecm +=  " AND BD7_VLRPAG > 0 "
   cQuecm +=  " AND BD7_BLOPAG <> '1' "
   if !empty (cProced)
       cQuecm +=  " AND BD7_CODPRO = '"+ cProced + "'"
   EndIf 
   cQuecm +=  " AND BD7_FASE = '"+ cFase1 + "' " 
   cQuecm +=  " AND BD7_SITUAC = '"+ cSituac +"' " 
   If !empty (cRdaAte)          
      cQuecm +=  " AND BD7_CODRDA >= '" + cRdaDe + "' AND BD7_CODRDA <= '" + cRdaAte + "'"                                            
   EndIf   
   cQuecm +=  " AND  SubStr (BD7_NUMLOT, 1,6) >= '" + cComptI + "' AND SubStr (BD7_NUMLOT, 1,6)  <= '" + cComptf + "'"       
   If !empty (cEmpFim)                                                                    
      cQuecm +=  " AND BD7_CODEMP >= '" + cEmpInic + "' AND BD7_CODRDA <= '" + cEmpFim + "'" 
   EndIf 
   If !empty (cMatrFim)                                                                    
      cQuecm +=  " AND BD7_MATRIC >= '" + cMatrInic + "' AND BD7_MATRIC <= '" + cMatrFim + "'" 
   EndIf 
   If !empty (cPlaFim)                                                                    
      cQuecm +=  " AND BD7_CODPLA >= '" + cPlaInic + "' AND BD7_CODPLA <= '" + cPlaFim + "'" 
   EndIf   
   cQuecm +=  " GROUP BY SubStr (BD7_NUMLOT, 1,6)"
   cQuecm +=  " ORDER BY SubStr (BD7_NUMLOT, 1,6) "
                            
EndIf                       
//Cm - Contas Medicas
   cQuecmS :=  " SELECT  BD7_ANOPAG , BD7_MESPAG , Sum (BD7_VLRPAG) VLPAG"
   cQuecmS +=  " FROM " + RetSqlName("BD7")+" BD7  "
   cQuecmS +=  " WHERE BD7.BD7_FILIAL = '"+xFilial("BD7")+"' "    
   if !empty (cProced)
       cQuecmS +=  " AND BD7_CODPRO = '"+ cProced + "'"
   EndIf 
   cQuecmS +=  " AND D_e_l_e_t_ = ' ' "        
   cQuecmS +=  " AND BD7_VLRPAG > 0 "
   cQuecmS +=  " AND BD7_BLOPAG <> '1' "   
   cQuecmS +=  " AND BD7_FASE = '"+ cFase1 + "' " 
   cQuecmS +=  " AND BD7_SITUAC = '"+ cSituac +"' "                                                                                       
   If !empty (cRdaAte)  
      cQuecmS +=  " AND BD7_CODRDA >= '" + cRdaDe + "' AND BD7_CODRDA <= '" + cRdaAte + "'"                                                  
   EndIf   
   cQuecmS +=  " AND SubStr (BD7_NUMLOT, 1,6) >= '" + cComptI + "' AND SubStr (BD7_NUMLOT, 1,6)  <= '" + cComptf + "'"   
   If !empty (cEmpFim)                                                                    
      cQuecmS +=  " AND BD7_CODEMP >= '" + cEmpInic + "' AND BD7_CODRDA <= '" + cEmpFim + "'" 
   EndIf 
   If !empty (cMatrFim)                                                                    
      cQuecmS +=  " AND BD7_MATRIC >= '" + cMatrInic + "' AND BD7_MATRIC <= '" + cMatrFim + "'" 
   EndIf 
   If !empty (cPlaFim)                                                                    
      cQuecmS +=  " AND BD7_CODPLA >= '" + cPlaInic + "' AND BD7_CODPLA <= '" + cPlaFim + "'" 
   EndIf      
   cQuecmS +=  " GROUP BY BD7_ANOPAG , BD7_MESPAG "
   cQuecmS +=  " ORDER BY BD7_ANOPAG , BD7_MESPAG "    
   
   //////////////////////  
   /* incluir 
   > Descrição dos planos
   > Código da empresa /  descrição
   > Regime da guia 
   */
                         
   cQuecmA :=  " SELECT BD7_MESPAG||'/'||BD7_ANOPAG DTPGTO, BD7_NUMLOT  , BD7_CODLDP  ,  BD7_CODPEG  ,   BD7_NUMERO  , BD7_FASE , "
   cQuecmA +=  " BD7_SITUAC  ,  BD7_CODPLA  ,  BD7_CODRDA  ,  BD7_NOMRDA , BD7_DATPRO  ,  BD6_CODPRO , BD6_DESPRO , BD7_MATRIC  , "
   cQuecmA +=  " BD7_NOMUSR  ,  BD7_VLRPAG  , BD6_VLRTPF   ,  BD6_TPPF   , BD6_BLOCPA  ,ZZT_TPCUST , BI3_DESCRI , BG9_DESCRI "
   cQuecmA +=  " FROM " + RetSqlName("BD7")+" BD7 "
   cQuecmA +=  ", " + RetSqlName("BD6")+" BD6 "  
   cQuecmA +=  ", " + RetSqlName("ZZT")+" ZZT "              
   cQuecmA +=  ", " + RetSqlName("BI3")+" BI3 "              
   cQuecmA +=  ", " + RetSqlName("BG9")+" BG9 "             
   

   cQuecmA +=  " WHERE BD7.BD7_FILIAL = '"+xFilial("BD7")+"' "
   cQuecmA +=  " AND BD6.BD6_FILIAL = '"+xFilial("BD6")+"' " 
   cQuecmA +=  " AND ZZT.ZZT_FILIAL = '"+xFilial("ZZT")+"' " 
   cQuecmA +=  " AND BI3.BI3_FILIAL = '"+xFilial("BI3")+"' " 
   cQuecmA +=  " AND BG9.BG9_FILIAL = '"+xFilial("BG9")+"' "

   if !empty (cProced)
       cQuecmA +=  " AND BD7_CODPRO = '"+ cProced + "'"
   EndIf 
   cQuecmA +=  " AND BD7.D_e_l_e_t_ = ' ' "
   cQuecmA +=  " AND BD6.D_e_l_e_t_ = ' ' "         
   cQuecmA +=  " AND ZZT.D_e_l_e_t_ = ' ' "         
   cQuecmA +=  " AND BI3.D_e_l_e_t_ = ' ' "        
   cQuecmA +=  " AND BG9.D_e_l_e_t_ = ' ' "        
   cQuecmA +=  " AND BD7_VLRPAG > 0  AND BD7_BLOPAG <> '1' "
   cQuecmA +=  " AND BD7_FASE = '"+ cFase1 + "' AND BD7_SITUAC = '"+ cSituac +"' "    
   If !empty (cRdaAte)    
      cQuecmA +=  " AND BD7_CODRDA >= '" + cRdaDe + "' AND BD7_CODRDA <= '" + cRdaAte + "'" 
   EndIf   
   cQuecmA +=  " AND BD6_CODOPE = BD7_CODOPE AND BD6_CODLDP = BD7_CODLDP AND BD6_CODPEG = BD7_CODPEG "
   cQuecmA +=  " AND BD6_ORIMOV = BD7_ORIMOV  AND BD6_MATRIC = bd7_MATRIC AND BD6_TIPREG = BD7_TIPREG and bd7_sequen = bd6_sequen "
   cQuecmA +=  " AND BD6_SITUAC = BD7_SITUAC AND BD6_FASE   = BD7_FASE   AND BD6_NUMERO = BD7_NUMERO AND BD7_CODPRO =  BD6_CODPRO "                                                          
   cQuecmA +=  " AND  SubStr (BD7_NUMLOT, 1,6) >= '" + cComptI + "' AND SubStr (BD7_NUMLOT, 1,6)  <= '" + cComptf + "'"       
   If !empty (cEmpFim)                                                                    
      cQuecmA +=  " AND BD7_CODEMP >= '" + cEmpInic + "' AND BD7_CODRDA <= '" + cEmpFim + "'" 
   EndIf 
   If !empty (cMatrFim)                                                                    
      cQuecmA +=  " AND BD7_MATRIC >= '" + cMatrInic + "' AND BD7_MATRIC <= '" + cMatrFim + "'" 
   EndIf 
   If !empty (cPlaFim)                                                                    
      cQuecmA +=  " AND BD7_CODPLA >= '" + cPlaInic + "' AND BD7_CODPLA <= '" + cPlaFim + "'" 
   EndIf      
   cQuecmA +=  " AND BD6_YNEVEN = ZZT_CODEV "
   cQuecmA +=  " AND BI3_CODINT = BD7_CODOPE   AND BI3_CODIGO = BD7_CODPLA  "      
   cQuecmA +=  " AND BG9_CODINT = BD7_CODOPE   AND BG9_CODIGO = BD7_CODEMP  " 

   cQuecmA +=  " ORDER BY BD7_ANOPAG ,BD7_MESPAG  "

If cResConf = 1  
   If Select("TMCP") > 0
      dbSelectArea("TMCP")
	  dbclosearea()
   Endif
   TCQuery cQuecp Alias "TMCP" New
   dbSelectArea("TMCP")
   tmcp->(dbGoTop())

   If Select("TMDC") > 0
      dbSelectArea("TMDC")
	  dbclosearea()
   Endif
   TCQuery cQuedc Alias "TMDC" New
   dbSelectArea("TMDC")
   tmdc->(dbGoTop()) 
   
     If Select("TMLT") > 0
       dbSelectArea("TMLT")
	   dbclosearea()
    Endif
    TCQuery cQuelt Alias "TMLT" New
    dbSelectArea("TMLT")
    tmlt->(dbGoTop())               
 
   If Select("TMCM") > 0
      dbSelectArea("TMCM")
	  dbclosearea()
   Endif
   TCQuery cQuecm Alias "TMCM" New
   dbSelectArea("TMCM")
   tmcm->(dbGoTop())
EndIf                     
 if cSintAnal <> 2
    If Select("TMCMS") > 0
       dbSelectArea("TMCMS")
   	   dbclosearea()
    Endif
    TCQuery cQuecmS Alias "TMCMS" New
    dbSelectArea("TMCMS")
    tmcmS->(dbGoTop())
 EndIf    
 If cSintAnal <> 1 
    If Select("TMCMA") > 0
       dbSelectArea("TMCMA")
  	   dbclosearea()
    Endif
    TCQuery cQuecmA Alias "TMCMA" New
    dbSelectArea("TMCMA")
    tmcmA->(dbGoTop())
 EndIf          
   
if cResConf = 1   
   Cabec1 := "                                              Relação de Totais por Competencia originais  -  Conferencia"  
   Cabec2 := "                  Mes/Ano    Valor Financeiro         Mes/Ano       Valor Guias          Mes/Ano    Valor Lote          Mes/Ano    Valor Deb/Cred       "
     nLin++ 
   @ nLin,000 PSay replicate("_",220)                                     
     nLin++                 
   @ nLin,000 PSay cabec1                                 
     nLin++                 
   @ nLin,000 PSay cabec2 
     nLin++ 
   @ nLin,000 PSay replicate("_",220)                                     
   
   
   While (tmcp->(!EOF()) .or. tmdc->(!EOF()) .or. tmlt->(!EOF()) .or. tmcm->(!EOF()) )
    	If nLin > 60 // Salto de Página. Neste caso o formulario tem 55 linhas...
	  	   Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
	       nLin := 9
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
	                                                                                                              
     if tmcp->(!EOF())             
        @ nLin,019 PSAY SubStr(TMCP->PLLOTE,5,2 ) +"/" + SubStr(TMCP->PLLOTE,1,4 )
        @ nLin,033 PSAY TMCP->VLTIT Picture "@E 99,999,999.99"   
        TmcpDt:=(SubStr(TMCP->PLLOTE,5,2 ) +"/" + SubStr(TMCP->PLLOTE,1,4 ))
        Tmcpvl:=TMCP->VLTIT
        tmcp->(dbSkip()) 
     Else                  
        TmcpDt:="  /      "
        Tmcpvl:="0,00"
     EndIf 
     
     If tmcm->(!EOF())                               
        @ nLin,055 PSAY SubStr (TMCM->NUMLOT,5,2) +"/" + SubStr (TMCM->NUMLOT,1,4)
        @ nLin,067 PSAY TMCM->VLPAG Picture "@E 99,999,999.99"
        TmcmDt:=(SubStr (TMCM->NUMLOT, 5,2) +"/" + SubStr (TMCM->NUMLOT, 1,4))
        Tmcmvl:=TMCM->VLPAG
        tmcm->(dbSkip())   
     Else              
        TmcmDt:="  /      "
        Tmcmvl:="0,00"
     EndIf               
     
     If tmlt->(!EOF())                                                
          @ nLin,090 PSAY TMLT->BAF_MESLOT +"/" + TMLT->BAF_ANOLOT
          @ nLin,098 PSAY TMLT->VLLOT Picture "@E 99,999,999.99" 
          TmtlDt:=(TMLT->BAF_MESLOT +"/" + TMLT->BAF_ANOLOT)
          Tmtlvl:=TMLT->VLLOT
          tmlt->(dbSkip())   
     Else              
          TmtlDt:="  /      "
          Tmtlvl:="0,00"
     EndIf               
     
     If  tmdc->(!EOF()) 
           @ nLin,121  PSAY TMDC->BGQ_MES + "/" + TMDC->BGQ_ANO                                                                                
           @ nLin,133  PSAY TMDC->valor       Picture "@E 99,999,999.99" 
           TmdcDt:=(TMDC->BGQ_MES + "/" + TMDC->BGQ_ANO)
           Tmdcvl:=TMDC->valor
           tmdc->(dbSkip())   
     Else              
        TmdcDt:="  /      "
        Tmdcvl:="0,00"
     EndIf    
     if cGeraExc = 1   
        Aadd(aTitulo,{ TmcpDt ,;
                       Tmcpvl ,;
                       TmcmDt ,;                       
                       Tmcmvl ,;
                       TmtlDt ,;
                       Tmtlvl ,;
                       TmdcDt ,;
                       Tmdcvl})
     EndIf   
    nLin++ 
   EndDo                                               

   if cGeraExc = 1   
      Aadd(aTitulo,{ "----------" ,;
                     "----------" ,;
                     "----------" ,;                       
                     "----------" ,;
                     "----------" ,;
                     "----------" ,;
                     "----------" ,;
                     "----------"})
   EndIf     
EndIf

  
iF cSintAnal <>  2 
   Cabec1 := "                                              Relação de Totais por Competencia originais  -  Sintetico "  
   Cabec2 := "                                                           Mes/Ano             Valor            %         "
            //123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012
//                     1         2         3         4         5         6         7         8         9         100       1         2         3         4         5         6         7         8         9         100       1         2         3         4         5         6         7         8         9         100

   @ nLin,000 PSay replicate("_",220)                                     
     nLin++                 
   @ nLin,000 PSay cabec1                                 
     nLin++                 
   @ nLin,000 PSay cabec2 
     nLin++ 
   @ nLin,000 PSay replicate("_",220)    
    Tmcmvlt := 0.00         
    tmcmS->(dbGoTop())
    While tmcmS->(!EOF())
          Tmcmvlt +=TMCMS->VLPAG
          tmcmS->(dbSkip())          
    EndDo                  
    dbSelectArea("TMCMS")
    tmcmS->(dbGoTop())
                                     
   While  tmcmS->(!EOF())
      nLin++            
      @ nLin,060 PSAY TMCMS->BD7_MESPAG +"/" + TMCMS->BD7_ANOPAG
      @ nLin,080 PSAY TMCMS->VLPAG Picture "@E 99,999,999.99"
      @ nLin,097 PSAY ((TMCMS->VLPAG / Tmcmvlt)*100) Picture "@E 999.999%"      
        TmcmDt:=TMCMS->BD7_MESPAG +"/" + TMCMS->BD7_ANOPAG
        Tmcmvl:=TMCMS->VLPAG   
        precet :=((TMCMS->VLPAG / Tmcmvlt)*100)
        tmcmS->(dbSkip())  
        if cGeraExc = 1   
        Aadd(aTitulo,{ ' ' ,;
                       ' ' ,;
                       TmcmDt ,;                       
                       Tmcmvl ,;
                       precet ,;
                       ' ' ,;
                       ' ' ,;
                       ' ' })
     EndIf    
   EndDo                                 
      nlin++
    @ nLin,000 PSay replicate("_",220)    
      nlin++   
    @ nLin,067 PSAY " Total ----> " 
    @ nLin,080 PSAY  Tmcmvlt Picture "@E 99,999,999.99"
   if cGeraExc = 1   
      Aadd(aTitulo,{ "----------" ,;
                     "----------" ,;
                     "----------" ,;                       
                     "----------" ,;
                     "----------" ,;
                     "----------" ,;
                     "----------" ,;
                     "----------"})
   EndIf     
EndIf  
 
iF cSintAnal <>  1                  
Cabec1 := "                                                                                            Relação de Totais por Competencia originais - Analitico "  
Cabec2 := " Mes/Ano     Num Lote     Num.Peg   Numero     Fase  Sit    Plano      RDA   Nome RDA               Dt Proced   Cod.Procd   Desc.Proced            Matric   Usuario                             Vl Pgto         Vl Cobrado"
            //123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012
//                     1         2         3         4         5         6         7         8         9         100       1         2         3         4         5         6         7         8         9         100       1         2         3         4         5         6         7         8         9         100
//             XX/XXXX   XXXXXXXXXX   XXXXXXXXX   XXXXXXXX     X    X      XXXX   XXXXXX   XXXXXXXXXXXXXXXXXXXX XX/XX/XXXXX    XXXXXXXX   XXXXXXXXXXXXXXXXXXXX   XXXXXX   XXXXXXXXXXXXXXXXXXXXXXXXX    999.999.999,99     999.999.999,99
                          
     nLin++   
   @ nLin,000 PSay replicate("_",220)  
     nLin++             
   @ nLin,000 PSay cabec1                                 
     nLin++                 
   @ nLin,000 PSay cabec2 
     nLin++ 
   @ nLin,000 PSay replicate("_",220)
   While  tmcmA->(!EOF())    
          If nLin > 60 // Salto de Página. Neste caso o formulario tem 55 linhas...
	      	 Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
	         nLin := 8
	      Endif       
	      if cContQbc = " " 
	         cContQbc :=TMCMa->DTPGTO
	      elseif cContQbc <> TMCMa->DTPGTO
	         nLin++ 
           @ nLin,000 PSay replicate("_",220) 
             nLin++                
           @ nLin,086 PSAY "Total da competencia " + cContQbc  
           @ nLin,186 PSAY VLRPAGTP Picture "@E 999,999,999.99"
           @ nLin,205 PSAY VLRECTP Picture "@E 999,999,999.99"
             nLin++ 
           @ nLin,000 PSay replicate("_",220) 
             VLRPAGTP     := 0.00
             VLRECTP      := 0.00         
             cContQbc := TMCMa->DTPGTO
	       EndIf                                           
      nLin++             
      @ nLin,002 PSAY TMCMa->DTPGTO 
      @ nLin,012 PSAY TMCMa->BD7_NUMLOT
      @ nLin,025 PSAY TMCMa->BD7_CODPEG
      @ nLin,037 PSAY TMCMa->BD7_NUMERO
      @ nLin,050 PSAY TMCMa->BD7_FASE
      @ nLin,055 PSAY TMCMa->BD7_SITUAC
      @ nLin,062 PSAY TMCMa->BD7_CODPLA
      @ nLin,069 PSAY TMCMa->BD7_CODRDA 
      @ nLin,078 PSAY substr(TMCMa->BD7_NOMRDA,1,20)
      @ nLin,099 PSAY stod (TMCMa->BD7_DATPRO)
      @ nLin,114 PSAY TMCMa->BD6_CODPRO
      @ nLin,125 PSAY substr(TMCMa->BD6_DESPRO,1,20)
      @ nLin,148 PSAY TMCMa->BD7_MATRIC  
      @ nLin,157 PSAY substr(TMCMa->BD7_NOMUSR,1,25)                      
      @ nLin,186 PSAY TMCMa->BD7_VLRPAG Picture "@E 999,999,999.99"
      if  (TMCMa->BD6_TPPF = '1'  .and.  TMCMa->BD6_BLOCPA <> '1')                
          vlpagto := TMCMa->BD6_VLRTPF
      else                             
          vlpagto := 0.00
      EndIf            
      @ nLin,205 PSAY  vlpagto Picture "@E 999,999,999.99"
      VLRPAGTP +=TMCMa->BD7_VLRPAG
      VLRECTP  +=vlpagto 
      VLRPAGTT +=TMCMa->BD7_VLRPAG
      VLRECTT  +=vlpagto
      
      if cGeraExc = 1   
        Aadd(aTitulo,{TMCMa->DTPGTO     ,; 
                      TMCMa->BD7_NUMLOT ,;
                      TMCMa->BD7_CODPEG ,;
                      TMCMa->BD7_NUMERO ,;
                      TMCMa->BD7_FASE   ,;
                      TMCMa->BD7_SITUAC ,;
                      TMCMa->BD7_CODPLA ,;
                      TMCMa->BD7_CODRDA ,;
                      substr(TMCMa->BD7_NOMRDA,1,20) ,;
                      stod (TMCMa->BD7_DATPRO) ,;
                      TMCMa->BD6_CODPRO ,;  
                      TMCMa->BD6_DESPRO ,;
                      TMCMa->BD7_MATRIC ,;  
                      TMCMa->BD7_NOMUSR ,;                     
                      TMCMa->BD7_VLRPAG ,;
                      vlpagto           ,;
                      TMCMa->ZZT_TPCUST ,; 
                      TMCMa->BI3_DESCRI ,; 
                      TMCMa->BG9_DESCRI  })
      EndIf 
      tmcma->(dbSkip())  
         
   EndDo                          
   nLin++ 
 @ nLin,000 PSay replicate("_",220) 
   nLin++                
 @ nLin,086 PSAY "Total da Geral competencia " + cContQbc   
 @ nLin,186 PSAY VLRPAGTP Picture "@E 999,999,999.99"
 @ nLin,205 PSAY VLRECTP  Picture "@E 999,999,999.99"
   nLin++ 
 @ nLin,000 PSay replicate("_",220)   
    nLin++ 
 @ nLin,086 PSAY "Total da Geral  " 
 @ nLin,186 PSAY VLRPAGTT Picture "@E 999,999,999.99"
 @ nLin,205 PSAY VLRECTT  Picture "@E 999,999,999.99"
   nLin++ 
 @ nLin,000 PSay replicate("_",220)    
 EndIf    
             
  //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
  //³ Gera excel                                                         ³
  //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
if cGeraExc = 1
   DlgToExcel({{"ARRAY","Gravações da Filial" , aTitXls  ,atitulo}})           
  //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ		        
EndIf
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


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ValidPerg º Autor ³ Jose Carlos Noronhaº Data ³ 01/08/07    º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Parametros para selecao dos titulos do PLS                 º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³                                                            º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ValidPerg()

Local aAreaAtu := GetArea()
Local aRegs    := {}
Local i,j

DbSelectArea("SX1")
dbSetOrder(1)
cPerg := PADR(cPerg,10)

aAdd(aRegs,{cPerg,"01","Compet. Pgto Inicial ?","","","mv_ch1" ,"C",06,0,0,"G","","mv_par01","","","","","","","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "", "" }) 
aAdd(aRegs,{cPerg,"02","Compet. Pgto Final   ?","","","mv_ch2" ,"C",06,0,0,"G","","mv_par02","","","","","","","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "", "" })
aAdd(aRegs,{cPerg,"03","Do  Fornecedor       ?","","","mv_ch3" ,"C",06,0,0,"G","","mv_par03","","","","","","","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "", "" }) 
aAdd(aRegs,{cPerg,"04","Ate Fornecedor       ?","","","mv_ch4" ,"C",06,0,0,"G","","mv_par04","","","","","","","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "", "" })
aAdd(aRegs,{cPerg,"05","Do RDA               ?","","","mv_ch5" ,"C",06,0,0,"G","","mv_par05","","","","","","","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "", "" })
aAdd(aRegs,{cPerg,"06","Ate RDA              ?","","","mv_ch6" ,"C",06,0,0,"G","","mv_par06","","","","","","","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "", "" })
aAdd(aRegs,{cPerg,"07","Resumo de Conferencia?","","","mv_ch7" ,"N",01,0,0,"c","","mv_par07","Sim ","","","","","Não ","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "", "" })
aAdd(aRegs,{cPerg,"08","Relatorio            ?","","","mv_ch8" ,"N",01,0,0,"c","","mv_par08","Sintetico ","","","","","Analitico ","","","","","Ambos","","","","","","","","","","","","","","" , "" , "" , "", "", "" })
aAdd(aRegs,{cPerg,"09","Gera Excel           ?","","","mv_ch9" ,"N",01,0,0,"c","","mv_par09","Sim ","","","","","Não ","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "", "" })
aAdd(aRegs,{cPerg,"10","Procedimento         ?","","","mv_ch10" ,"C",08,0,0,"G","","mv_par10","","","","","","","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "", "" }) 
aAdd(aRegs,{cPerg,"11","Fase                 ?","","","mv_ch11" ,"C",01,0,0,"G","","mv_par11","","","","","","","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "", "" }) 
aAdd(aRegs,{cPerg,"12","Situação             ?","","","mv_ch12" ,"C",01,0,0,"G","","mv_par12","","","","","","","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "", "" })
aAdd(aRegs,{cPerg,"13","Empresa Inicial      ?","","","mv_ch13" ,"C",04,0,0,"G","","mv_par13","","","","","","","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "", "" }) 
aAdd(aRegs,{cPerg,"14","Empresa Final        ?","","","mv_ch14" ,"C",04,0,0,"G","","mv_par14","","","","","","","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "", "" })
aAdd(aRegs,{cPerg,"15","Matricula Inicial    ?","","","mv_ch15" ,"C",06,0,0,"G","","mv_par15","","","","","","","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "", "" }) 
aAdd(aRegs,{cPerg,"16","Matricula Final      ?","","","mv_ch16" ,"C",06,0,0,"G","","mv_par16","","","","","","","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "", "" }) 
aAdd(aRegs,{cPerg,"17","Plano Inicial        ?","","","mv_ch17" ,"C",04,0,0,"G","","mv_par15","","","","","","","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "", "" }) 
aAdd(aRegs,{cPerg,"18","Plano Final          ?","","","mv_ch18" ,"C",04,0,0,"G","","mv_par16","","","","","","","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "", "" })

//aAdd(aRegs,{cPerg,"11","Fase                 ?","","","mv_ch11" ,"N",01,0,0,"c","","mv_par11","1-Digitação ","","","","","2-Conferencia ","","","","","3-Ativa","","","","","4-Faturada","","","","","","","","","" , "" , "" , "", "", "" }) 
                
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

RestArea( aAreaAtu )

Return(.T.)
