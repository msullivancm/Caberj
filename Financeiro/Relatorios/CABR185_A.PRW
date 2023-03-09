#Define CRLF Chr(13)+Chr(10)
#INCLUDE "rwmake.ch"
#include "PROTHEUS.CH"                                                                                                                         
#include "TOPCONN.CH"
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ CABR185  º Autor ³ Altamiro Affonso   º Data ³  10/06/15   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Relatorio de extrato de comissão - conferencia             º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP6 IDE                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function CABR185_A()  

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracao de Variaveis                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

Local cDesc1         := "Este programa tem como objetivo imprimir relatorio "
Local cDesc2         := "de saldos pendentes por colaborador."
Local cDesc3         := "totalizadp por colaborador e Geral "
Local cPict          := ""
Local titulo         := "Autorização de pagamento de comisão "

Local Cabec1         := "  " //Codigo     Descrição                                            Saldo"
//                       12345678901234567890123456789012345678901234567890123456789001234567890
//                       0        1         2         3         4         5         6          7
//                          XXX       XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX   999.999.999,99 
//                      BK2_PROPRI||BK2_CODLAN,                                    Sum(BK2_SALDO) 
Local Cabec2         := " "
Local imprime        := .T.
Local aOrd           := {}
Private nLin         := 220  
Private lEnd         := .F.
Private lAbortPrint  := .F.
Private CbTxt        := ""
Private limite       := 100
Private tamanho      := "P"
Private nomeprog     := "CABR185"
Private nTipo        := 15
Private aReturn      := { "Zebrado", 1, "Administracao", 1, 2, 1, "", 1}
Private nLastKey     := 0
Private cbtxt        := Space(10)
Private cbcont       := 00
Private CONTFL       := 01
Private m_pag        := 01
Private wnrel        := "CABR185"
Private cString      := "SE2"
Private cPerg        := "CABR185   "
Private valor_tot    := 0.00  
Private valor_col    := 0.00                                                                      
Private cquebra      := " "        
Private cttitpgto    :=' '   
private cqtdavend    := 0 
private ctraco80     := replicate("_",080)  
Private lflagtot     :=.F.    
private lflagMM      :=.F.
Private cAliastmp    := GetNextAlias()
Private cAliastmp1 	 := GetNextAlias()
Private cAliastmp2 	 := GetNextAlias()      
Private cAliastmp3 	 := GetNextAlias()
Private cAliastmp4 	 := GetNextAlias()    
Private cAliastmp5 	 := GetNextAlias()
Private cAliastmp6 	 := GetNextAlias() 
Private cAliastmp7 	 := GetNextAlias()
Private cAliastmp8 	 := GetNextAlias() 
Private cAliastmp9 	 := GetNextAlias() 
Private cAliastm10   := GetNextAlias() 
Private cAliastm11   := GetNextAlias() 
Private cAliastm12   := GetNextAlias() 
Private cAliastm13   := GetNextAlias()
Private cAliastm14   := GetNextAlias()

Private cQuery        := " "   
Private cQuery1       := " "  
Private cQuery2       := " "  
Private cQuery3       := " "  
Private cQuery4       := " "   
Private cQuery4A      := " "   
Private cQuery4B      := " "  
Private cQuery5       := " "    
Private cQuery6       := " "  
Private cQuery7       := " "  
Private cQuery8       := " "   
Private cQuery9       := " "   
Private cQuery10       := " "   
Private cQuery11       := " "   
Private cQuery12       := " "   
Private cQuery13       := " "  
Private cQuery14       := " "  

ValidPerg(cPerg)

If Pergunte(cPerg,.T.) = .F.
	Return
Endif                                     


//Pergunte(cPerg,.T.)

Private cAnoMes      := substr(mv_par01,4,4)+substr(mv_par01,1,2)   
 
Private cEmpInc      := mv_par02 
Private cEmpFim      := mv_par03
Private cVendInc     := mv_par04   
Private cVendFim     := mv_par05       
private nLMatRep     := mv_par06                              

cmes:= val(substr(mv_par01,1,2))
cano:= val(substr(mv_par01,4,4))
Private cAnoMesa      := str(iif(cmes==01,cano-1, cano),4)+strzero(iif(cmes==01,12,(cmes-1)),2)   
private cAnoAntI      := substr(CalComp(1),1,4) 
private cMesAntI      := substr(CalComp(1),5,2) 
private cAnoAntF      := substr(CalComp(2),1,4) 
private cMesAntF      := substr(CalComp(2),5,2)
private cEmpresa      := Iif(cEmpAnt == '01','C','I')  

private cAnoAntIA      := substr(CalCompA(1),1,4) 
private cMesAntIA      := substr(CalCompA(1),5,2) 
private cAnoAntFA      := substr(CalCompA(2),1,4) 
private cMesAntFA      := substr(CalCompA(2),5,2)

private cAnoAntIB      := substr(CalCompB(1),1,4) 
private cMesAntIB      := substr(CalCompB(1),5,2) 
private cAnoAntFB      := substr(CalCompB(2),1,4) 
private cMesAntFB      := substr(CalCompB(2),5,2)

private cDiaIA:= '31' 
private cDiaIB:= '31'

private cDiaI:= '31'

PRIVATE nVlrCom    := 0 
PRIVATE nVlrImpost := 0 
PRIVATE nVlrTit    := 0
PRIVATE nQtdaTit   := 0 

If cMesAntI $ ('04|06|09|11')
   cDiaI:='30'
ElseIf cMesAntI $('01|03|05|07|08|10|12')
   cDiaI:='31' 
Else    
   cDiaI:=Iif ((Val(cAnoAntI)/4)==0,'29','28')
Endif     
                   
cDiaIA := cDiaIB := cDiaI 

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
/****************************************************/
/* CQUERY  - QUERY DE CARGA DE CALCULO DA COMISSAO  */
/* CQYERY1 - Dados do(s) Titulo(S) a receber        */
/* CQYERY2 - compossição da cobrança                */
/****************************************************/   
///---- distribuicao da comisao    

cQuery := " select bxq_codemp , bxq_mes ||'/'|| bxq_ano referencia , bg9_descri Cliente , "
cQuery += CRLF + " bxq_codven codven,a3_nome Vendedor , bxq_e2pref ||bxq_e2num || bxq_e2tipo ttitpgto , "
cQuery += CRLF + " (nvl(e2_valor,0.00) + nvl(e2_inss,0.00) + nvl(e2_irrf,0.00) + nvl(e2_iss,0.00) + nvl(e2_vretpis,0.00) + nvl(e2_vretcof,0.00) + nvl(e2_vretcsl,0.00)) Vlrtit , nvl(e2_vencrea,' /  /  ') venc , " 
 
cQuery += CRLF + " nvl(e2_valor,0.00) vlr_valor  ,  nvl(e2_inss,0.00) vlr_inss , nvl(e2_irrf,0.00) vlr_irrf , nvl(e2_iss,0.00)vlr_Iss , nvl(e2_vretpis,0.00) vlr_pis , nvl(e2_vretcof,0.00)vlr_cof , nvl(e2_vretcsl,0.00) vlr_csl , " 

cQuery += CRLF + " sum (bxq_bascom) Base_Com, sum(bxq_vlrcom) Vlr_com , bxq_percom , "
cQuery += CRLF + " ROUND(( sum(bxq_vlrcom)*100 / (sum (bxq_bascom))),1)||'%'  Precent , "
cQuery += CRLF + " count (decode(bxq_codven,qtdvida.ba1_codven , 1 , null ) ) qtda_vend1 , "
cQuery += CRLF + " sum (decode(bxq_codven,qtdvida.ba1_codven , bxq_bascom , 0 ) ) bascomvend1 , "
cQuery += CRLF + " sum (decode(bxq_codven,qtdvida.ba1_codven , bxq_vlrcom , 0 ) ) vlrcomvend1 , " 
cQuery += CRLF + " count (decode(bxq_codven,qtdvida.ba1_codve2 , 1 , null ) ) qtda_vend2 , "    
cQuery += CRLF + " sum (decode(bxq_codven,qtdvida.ba1_codve2 , bxq_bascom , 0 ) ) bascomvend2 , "
cQuery += CRLF + " sum (decode(bxq_codven,qtdvida.ba1_codve2 , bxq_vlrcom , 0 ) ) vlrcomvend2 , "     
cQuery += CRLF + " NVL(Sum(DECODE(BA3_COBNIV,'0',1,DECODE(trim(BA3_COBNIV),'',1,null))),0)NVLCOBEMP ,
cQuery += CRLF + " NVL(Sum(DECODE(BA3_COBNIV,'1',1,null )),0) NVLCOBFAM ,
//cQuery += CRLF + " NVL(Sum ((DECODE(BA3_COBNIV,'0',1,null )),0) NVLCOBEMP , "
//cQuery += CRLF + " NVL(Sum (DECODE(BA3_COBNIV,'1',1,null )),0) NVLCOBFAM , "
cQuery += CRLF + " CASE  WHEN bxq_bascom > 0  THEN 'possitivo' WHEN bxq_bascom < 0  THEN 'negativo' END "  
     
cQuery += CRLF+ " from " + RetSqlName("BXQ") +" bxq , " + RetSqlName("BG9") +" bg9 , " + RetSqlName("SE2") +" SE2 , " + RetSqlName("SA3") +" SA3 , " + RetSqlName("BA3") +" BA3 ,"
      
cQuery += CRLF + " (select BA1_codint , BA1_codemp , ba1_codven , ba1_codve2 , "
cQuery += CRLF + "         count( decode(trim(ba1_codven) ,'',null, 1 )) qtda_com1 , "
cQuery += CRLF + "         count(decode(trim(ba1_codve2) ,'',null, 1 ))  qtda_com2 , "   
cQuery += CRLF + "         count(decode(trim(ba1_codven) ,'',decode(trim(ba1_codve2),'',1, null),null)) qtda_sem "       
cQuery += CRLF + "    from " + RetSqlName("BA1") +" ba1 " 
cQuery += CRLF + "   where ba1_filial = '"+xFilial('BA1')+ "' and ba1.d_E_L_E_T_ = ' ' "      
If !empty(cEmpInc )
   cQuery += CRLF+   " and ba1_codemp >= '"+cEmpInc +"' and ba1_codemp <= '"+cEmpFim+"'" 
EndIf                                                                               
If !empty(cVendInc)
   cQuery += CRLF+ " AND (ba1_codven >= '"+cVendInc+"' AND bxq_codven <= '"+cVendFim+"'" 
   cQuery += CRLF+ " OR  (ba1_codve2 >= '"+cVendInc+"' AND bxq_codve2 <= '"+cVendFim+"' )"
EndIf                    

cQuery += CRLF+   "    and (ba1_datblo = ' ' or substr(ba1_datblo,1,6) >= '"+ canomes+"')"
cQuery += CRLF+   "  group by BA1_codint , BA1_codemp , ba1_codven , ba1_codve2 "
cQuery += CRLF+   "  order by BA1_codint , BA1_codemp , ba1_codven , ba1_codve2) qtdvida "       

cQuery += CRLF+ " where bxq_filial = '"+xFilial('BXQ')+ "'  and bxq.d_E_L_E_T_ = ' ' "  
cQuery += CRLF+   " and bg9_filial = '"+xFilial('BG9')+ "'  and bg9.d_E_L_E_T_ = ' ' "
cQuery += CRLF+   " and  e2_filial(+) = '"+xFilial('SE2')+ "'  and se2.d_E_L_E_T_(+) = ' ' "
cQuery += CRLF+   " and  a3_filial = '"+xFilial('SA3')+ "'  and sa3.d_E_L_E_T_ = ' ' "     
cQuery += CRLF+   " and ba3_filial = '"+xFilial('BA3')+ "'  and ba3.d_E_L_E_T_ = ' ' "
If !empty(cEmpInc )
   cQuery += CRLF+   " and bxq_codemp >= '"+cEmpInc +"' and bxq_codemp <= '"+cEmpFim+"'" 
EndIf                                                                                                 
cQuery += CRLF+ " and bxq_mes = '"+substr(mv_par01,1,2)+"' and bxq_ano = '"+substr(mv_par01,4,4)+"' "
If !empty(cVendInc)
   cQuery += CRLF+ " AND bxq_codven >= '"+cVendInc+"' AND bxq_codven <= '"+cVendFim+"'"
EndIf                                                                                     
cQuery += CRLF+ " and qtdvida.BA1_codemp = bxq_codemp and (ba1_codven = bxq_codven or ba1_codve2 = bxq_codven) "         
cQuery += CRLF+ " and bg9_codigo = bxq_codemp "
cQuery += CRLF+ " and bxq_pagcom = bxq_refere "
cQuery += CRLF+ " and bxq_e2pref = e2_prefixo(+) and bxq_e2num = e2_num(+) and  bxq_e2tipo = e2_tipo(+) "
cQuery += CRLF+ " and a3_cod = bxq_codven "
cQuery += CRLF+ " and ba3_codint = bxq_codint and ba3_codemp = bxq_codemp and ba3_matric = bxq_matric "
cQuery += CRLF+ " group by bxq_codemp , bxq_mes ||'/'|| bxq_ano , bxq_codven, a3_nome , bg9_descri, bxq_e2pref ||bxq_e2num || bxq_e2tipo , "   
cQuery += CRLF+ " e2_valor , e2_inss , e2_irrf , e2_iss , e2_vretpis , e2_vretcof , e2_vretcsl , bxq_percom , e2_vencrea ,"
cQuery += CRLF+ " CASE  WHEN bxq_bascom > 0  THEN 'possitivo' WHEN bxq_bascom < 0  THEN 'negativo' END "          
cQuery += CRLF+ " order by  4,13,19 "      

//----- tit a receber     

cQuery1 := " select tabtit.codemp cidemp , sum(e1_valor) vlrrec , sum(e1_saldo) vlrsld " 
cQuery1 += CRLF+ " from  " + RetSqlName("SE1") +" SE1  , (select distinct bxq_codemp codemp, (bxq_prefix || bxq_num||bxq_tipo) tit"
cQuery1 += CRLF+                                          " from  " + RetSqlName("BXQ") +" BXQ "                        
cQuery1 += CRLF+                                         " where bxq_filial = '"+xFilial('BXQ')+ "' and bxq.d_E_L_E_T_ = ' ' "
If !empty(cEmpInc )
cQuery1 += CRLF+                                          " and bxq_codemp >= '"+cEmpInc +"' and bxq_codemp <= '"+cEmpFim+"'" 
EndIf
cQuery1 += CRLF+                                          " and   bxq_ano||bxq_mes = '"+ canomes+"' "       
If !empty(cVendInc)
   cQuery1 += CRLF+                                       " and bxq_codven >= '"+cVendInc+"' AND bxq_codven <= '"+cVendFim+"'"
EndIf 
cQuery1 += CRLF+                                          " and bxq_pagcom = bxq_refere ) tabtit  "
cQuery1 += CRLF+ " where e1_filial = '"+xFilial('SE1')+ "' and se1.d_E_L_E_T_ = ' '"
cQuery1 += CRLF+ " and e1_anobase ||e1_mesbase   = '"+ canomes+"' "  
//cQuery1 += CRLF+ " and e1_baixa <> ' ' and e1_saldo = 0 "
cQuery1 += CRLF+ " and e1_prefixo = substr(tabtit.tit,1,3) "
cQuery1 += CRLF+ " and e1_num = substr(tabtit.tit,4,9) "
cQuery1 += CRLF+ " and trim(e1_tipo) = trim(substr(tabtit.tit,13,3)) "
cQuery1 += CRLF+ "group by tabtit.codemp order by tabtit.codemp "

  
//-----------compossicao da cobranca ----

cQuery2 :=" select bm1_codemp ,  bm1_codtip , bm1_destip lanccom , "  
cQuery2 += CRLF+ " sum(decode(bfq_comiss , '1' , decode(trim(bm1_tipo),'1',bm1_valor,(bm1_valor*-1)), 0)) vlr_com ,"  
cQuery2 += CRLF+ " count(decode(bfq_comiss , '1' , 1, null)) qtda_com ,  "
cQuery2 += CRLF+ " sum(decode(bfq_comiss , '1' , 0, decode(trim(bm1_tipo),'1',bm1_valor,(bm1_valor*-1)))) vlr_sem  ,"
cQuery2 += CRLF+ " count(decode(bfq_comiss , '1' , Null ,1)) qtda_sem "//, count(decode(trim(bm1_MATRIC),NULL,1)) Qtda_smatric "          
cQuery2 += CRLF+ " from " + RetSqlName("BM1") +" bm1 , " + RetSqlName("BFQ") +" bfq "      
cQuery2 += CRLF+ " where bm1_filial = '"+xFilial('BM1')+ "'  and bm1.d_E_L_E_T_ = ' ' "
cQuery2 += CRLF+ " and bfq_filial = '"+xFilial('BFQ')+ "'  and bfq.d_E_L_E_T_ = ' '  "
cQuery2 += CRLF+ " and bfq_propri||bfq_codlan = bm1_codtip  "
cQuery2 += CRLF+ " and bm1_codtip <>'108' "
cQuery2 += CRLF+ " and bm1_prefix || bm1_numtit || bm1_tiptit in "
cQuery2 += CRLF+ " (select distinct (bxq_prefix || bxq_num||bxq_tipo) "
cQuery2 += CRLF+ " from " + RetSqlName("BXQ") +" bxq  "
cQuery2 += CRLF+ " where bxq_filial = '"+xFilial('BXQ')+ "'  and bxq.d_E_L_E_T_ = ' ' and bxq_pagcom = bxq_refere "                                                          
cQuery2 += CRLF+ "   and   bxq_ano||bxq_mes = '"+ canomes+"' "       
If !empty(cEmpInc )
   cQuery2 += CRLF+   " and bxq_codemp >= '"+cEmpInc +"' and bxq_codemp <= '"+cEmpFim+"'" 
EndIf
If !empty(cVendInc)
   cQuery2 += CRLF+   " and bxq_codven >= '"+cVendInc+"' AND bxq_codven <= '"+cVendFim+"' "
EndIf 
cQuery2 += CRLF+ ")"
cQuery2 += CRLF+ " and bm1_ano||bm1_mes = '"+ canomes+"' "       
cQuery2 += CRLF+ " group by  bm1_codemp , bm1_codtip , bm1_destip "
cQuery2 += CRLF+ " order by  bm1_codemp , bm1_codtip , bm1_destip "
//-----evolucao de vidas      
      
cQuery3 :=" select TO_CHAR(ADD_MONTHS(TO_DATE(substr(min(ba1_datinc),1,6) ,'YYYYMM'), 0),'YYYYMM') DATINC , "  
cQuery3 += CRLF+ " COUNT(CASE WHEN (substr(min(ba1_datinc),1,6) = substr(ba1_datinc,1,6)) and (BA3_COBNIV = '0' or BA3_COBNIV = ' ') THEN 1 ELSE NULL END)  IncE ," 
cQuery3 += CRLF+ " COUNT(CASE WHEN (substr(min(ba1_datinc),1,6) = substr(ba1_datinc,1,6)) and  BA3_COBNIV = '1'  THEN 1 ELSE NULL END)  IncF ,"
            
cQuery3 += CRLF+ " TO_CHAR(ADD_MONTHS(TO_DATE('"+ canomes+"' ,'YYYYMM'), -5),'YYYYMM') DAT5 , "
cQuery3 += CRLF+ " Sum( COUNT(CASE WHEN ((substr(BA1_DATINC,1,6) <= TO_CHAR(ADD_MONTHS(TO_DATE('"+ canomes+"' ,'YYYYMM'), -5),'YYYYMM'))  and (BA3_COBNIV = '0' or BA3_COBNIV = ' ') "
cQuery3 += CRLF+ " and (BA1_DATBLO = ' ' OR substr(BA1_DATBLO,1,6) >= TO_CHAR(ADD_MONTHS(TO_DATE('"+ canomes+"' ,'YYYYMM'), -5),'YYYYMM'))) THEN 1 ELSE NULL END)) M5E," 
cQuery3 += CRLF+ " Sum( COUNT(CASE WHEN ((substr(BA1_DATINC,1,6) <= TO_CHAR(ADD_MONTHS(TO_DATE('"+ canomes+"' ,'YYYYMM'), -5),'YYYYMM')) and BA3_COBNIV = '1'          "
cQuery3 += CRLF+ " and (BA1_DATBLO = ' ' OR substr(BA1_DATBLO,1,6) >= TO_CHAR(ADD_MONTHS(TO_DATE('"+ canomes+"' ,'YYYYMM'), -5),'YYYYMM'))) THEN 1 ELSE NULL END)) M5F,"
       
cQuery3 += CRLF+ " TO_CHAR(ADD_MONTHS(TO_DATE('"+canomes+"' ,'YYYYMM'), -4),'YYYYMM') DAT4, "
cQuery3 += CRLF+ " Sum( COUNT(CASE WHEN ((substr(BA1_DATINC,1,6) <= TO_CHAR(ADD_MONTHS(TO_DATE('"+canomes+"' ,'YYYYMM'), -4),'YYYYMM'))  and (BA3_COBNIV = '0' or BA3_COBNIV = ' ') "
cQuery3 += CRLF+ " and (BA1_DATBLO = ' ' OR substr(BA1_DATBLO,1,6) >= TO_CHAR(ADD_MONTHS(TO_DATE('"+canomes+"' ,'YYYYMM'), -4),'YYYYMM'))) THEN 1 ELSE NULL END)) M4E," 
cQuery3 += CRLF+ " Sum( COUNT(CASE WHEN ((substr(BA1_DATINC,1,6) <= TO_CHAR(ADD_MONTHS(TO_DATE('"+canomes+"' ,'YYYYMM'), -4),'YYYYMM')) and BA3_COBNIV = '1'          "
cQuery3 += CRLF+ " and (BA1_DATBLO = ' ' OR substr(BA1_DATBLO,1,6) >= TO_CHAR(ADD_MONTHS(TO_DATE('"+canomes+"' ,'YYYYMM'), -4),'YYYYMM'))) THEN 1 ELSE NULL END)) M4F," 
         
cQuery3 += CRLF+ " TO_CHAR(ADD_MONTHS(TO_DATE('"+canomes+"' ,'YYYYMM'), -3),'YYYYMM') DAT3, "
cQuery3 += CRLF+ " Sum( COUNT(CASE WHEN ((substr(BA1_DATINC,1,6) <= TO_CHAR(ADD_MONTHS(TO_DATE('"+canomes+"' ,'YYYYMM'), -3),'YYYYMM'))  and (BA3_COBNIV = '0' or BA3_COBNIV = ' ') "
cQuery3 += CRLF+ " and (BA1_DATBLO = ' ' OR substr(BA1_DATBLO,1,6) >= TO_CHAR(ADD_MONTHS(TO_DATE('"+canomes+"' ,'YYYYMM'), -3),'YYYYMM'))) THEN 1 ELSE NULL END)) M3E,"
cQuery3 += CRLF+ " Sum( COUNT(CASE WHEN ((substr(BA1_DATINC,1,6) <= TO_CHAR(ADD_MONTHS(TO_DATE('"+canomes+"' ,'YYYYMM'), -3),'YYYYMM')) and BA3_COBNIV = '1'          "
cQuery3 += CRLF+ " and (BA1_DATBLO = ' ' OR substr(BA1_DATBLO,1,6) >= TO_CHAR(ADD_MONTHS(TO_DATE('"+canomes+"' ,'YYYYMM'), -3),'YYYYMM'))) THEN 1 ELSE NULL END)) M3F," 
          
cQuery3 += CRLF+ " TO_CHAR(ADD_MONTHS(TO_DATE('"+canomes+"' ,'YYYYMM'), -2),'YYYYMM') DAT2, "
cQuery3 += CRLF+ " Sum( COUNT(CASE WHEN ((substr(BA1_DATINC,1,6) <= TO_CHAR(ADD_MONTHS(TO_DATE('"+canomes+"' ,'YYYYMM'), -2),'YYYYMM'))  and (BA3_COBNIV = '0' or BA3_COBNIV = ' ') "
cQuery3 += CRLF+ " and (BA1_DATBLO = ' ' OR substr(BA1_DATBLO,1,6) >= TO_CHAR(ADD_MONTHS(TO_DATE('"+canomes+"' ,'YYYYMM'), -2),'YYYYMM'))) THEN 1 ELSE NULL END)) M2E," 
cQuery3 += CRLF+ " Sum( COUNT(CASE WHEN ((substr(BA1_DATINC,1,6) <= TO_CHAR(ADD_MONTHS(TO_DATE('"+canomes+"' ,'YYYYMM'), -2),'YYYYMM')) and BA3_COBNIV = '1'          "
cQuery3 += CRLF+ " and (BA1_DATBLO = ' ' OR substr(BA1_DATBLO,1,6) >= TO_CHAR(ADD_MONTHS(TO_DATE('"+canomes+"' ,'YYYYMM'), -2),'YYYYMM'))) THEN 1 ELSE NULL END)) M2F," 
          
cQuery3 += CRLF+ " TO_CHAR(ADD_MONTHS(TO_DATE('"+canomes+"' ,'YYYYMM'), -1),'YYYYMM') DAT1," 
cQuery3 += CRLF+ " Sum(  COUNT(CASE WHEN ((substr(BA1_DATINC,1,6) <= TO_CHAR(ADD_MONTHS(TO_DATE('"+canomes+"' ,'YYYYMM'), -1),'YYYYMM'))  and (BA3_COBNIV = '0' or BA3_COBNIV = ' ') "
cQuery3 += CRLF+ " and (BA1_DATBLO = ' ' OR substr(BA1_DATBLO,1,6) >= TO_CHAR(ADD_MONTHS(TO_DATE('"+canomes+"' ,'YYYYMM'), -1),'YYYYMM'))) THEN 1 ELSE NULL END)) M1E,"               
cQuery3 += CRLF+ " Sum( COUNT(CASE WHEN ((substr(BA1_DATINC,1,6) <= TO_CHAR(ADD_MONTHS(TO_DATE('"+canomes+"' ,'YYYYMM'), -1),'YYYYMM')) and BA3_COBNIV = '1'          "
cQuery3 += CRLF+ " and (BA1_DATBLO = ' ' OR substr(BA1_DATBLO,1,6) >= TO_CHAR(ADD_MONTHS(TO_DATE('"+canomes+"' ,'YYYYMM'), -1),'YYYYMM'))) THEN 1 ELSE NULL END)) M1F,"
          
cQuery3 += CRLF+ " TO_CHAR(ADD_MONTHS(TO_DATE('"+canomes+"' ,'YYYYMM'), 0),'YYYYMM') DAT0, "
cQuery3 += CRLF+ " Sum( COUNT(CASE WHEN ((substr(BA1_DATINC,1,6) <= TO_CHAR(ADD_MONTHS(TO_DATE('"+canomes+"' ,'YYYYMM'), 0),'YYYYMM')) and (BA3_COBNIV = '0' or BA3_COBNIV = ' ') "
cQuery3 += CRLF+ " and (BA1_DATBLO = ' ' OR substr(BA1_DATBLO,1,6) >= TO_CHAR(ADD_MONTHS(TO_DATE('"+canomes+"' ,'YYYYMM'), 0),'YYYYMM'))) THEN 1 ELSE NULL END)) M0E, "
cQuery3 += CRLF+ " Sum( COUNT(CASE WHEN ((substr(BA1_DATINC,1,6) <= TO_CHAR(ADD_MONTHS(TO_DATE('"+canomes+"' ,'YYYYMM'), 0),'YYYYMM')) and BA3_COBNIV = '1'           "
cQuery3 += CRLF+ " and (BA1_DATBLO = ' ' OR substr(BA1_DATBLO,1,6) >= TO_CHAR(ADD_MONTHS(TO_DATE('"+canomes+"' ,'YYYYMM'), 0),'YYYYMM'))) THEN 1 ELSE NULL END)) M0F  "
    
cQuery3 += CRLF + " from " + RetSqlName("BA1") +" ba1 , " + RetSqlName("BA3") +" ba3 "
cQuery3 += CRLF + " where ba1_filial = '"+xFilial('BA1')+ "' and ba1.d_E_L_E_T_ = ' ' and ba3_filial = '"+xFilial('BA3')+ "' and ba3.d_E_L_E_T_ = ' '"      
    
If !empty(cEmpInc )
   cQuery3 += CRLF+   " and ba1_codemp >= '"+cEmpInc +"' and ba1_codemp <= '"+cEmpFim+"'" 
EndIf
	  
cQuery3 += CRLF+ " AND BA1_CODINT = BA3_CODINT and BA1_CODEMP = BA3_CODEMP and BA1_MATRIC = BA3_MATRIC "   
cQuery3 += CRLF+ " group by ba1_datinc , BA3_COBNIV , ba1_datblo   "
          
///---------------- Regra de comissao cadastrada   com contrato e sub contrata

 cQuery4 := CRLF+" select bxq.codven , bxq.nomvend , " 
 cQuery4 += CRLF+"        bxj1.bxk_qtdde||' a '||bxj1.bxk_qtdate Parcel , bxj1.bxk_percon||'%' percom , "
 cQuery4 += CRLF+"        sum(bxq.qtda) qtda , "
 cQuery4 += CRLF+"        sum(bxq.vlrcom) vlcom , "
 cQuery4 += CRLF+"        sum(bxq.bascom) bacom , " 
 cQuery4 += CRLF+"        bxj1.bxk_percon perc   "    
 If Mv_par07 == 2
    cQuery4 += CRLF+"   , decode(bxj1.bxj_Tipinc,'1','PN','2','ADS','3','Dep','4','Trf','5','Adp', 'Nul')  tipInc  " 
 Else 
    cQuery4 += CRLF+"   , ' '  tipInc "    
 EndIf    
 cQuery4 += CRLF+"        from "
 cQuery4 += CRLF+"      ( select bxq_codven codven ,a3_nome nomvend , bxq_numpar numpar, count(*) qtda , Bxq.Bxq_Percom , sum(bxq_vlrcom) vlrcom , sum(bxq_bascom) bascom , 
 cQuery4 += CRLF+"              bxq_codemp codemp , bxq_matric  , bxq_tipreg , a3_nome Vend , ba1_conemp conemp , ba1_subcon subcon , ba1_tipinc tipinc "

cQuery4 += CRLF+ "  from    " + RetSqlName("BXQ") + " BXQ , " + RetSqlName("SA3") + " SA3, " + RetSqlName("BA1") + " BA1 "   

cQuery4 += CRLF+ "   where  bxQ_filial = '"+xFilial('BXQ')+ "' and bxQ.d_E_L_E_T_ = ' ' "  
cQuery4 += CRLF+ "    and  A3_filial = '"+xFilial('SA3')+ "' and SA3.d_E_L_E_T_ = ' ' "      
cQuery4 += CRLF+ "    and BA1_filial = '"+xFilial('BA1')+ "' and BA1.d_E_L_E_T_ = ' ' " 

cQuery4 += CRLF+ "   and bxq_ano||bxq_mes = '"+ canomes+"' "    

cQuery4 += CRLF+ "   and bxq_codint = ba1_codint 
cQuery4 += CRLF+ "   and bxq_codemp = ba1_codemp 
cQuery4 += CRLF+ "   and bxq_matric = ba1_matric
cQuery4 += CRLF+ "   and bxq_tipreg = ba1_tipreg
cQuery4 += CRLF+ "   and bxq_codven = a3_cod           

If !empty(cEmpInc )
   cQuery4 += CRLF+ "  and bxq_codemp >= '"+cEmpInc +"' and bxq_codemp <= '"+cEmpFim+"'" 
EndIf  

cQuery4 += CRLF+ " AND (bxq_codven >= '"+cVendInc+"' AND bxq_codven <= '"+cVendFim+"'" 
     
cQuery4 += CRLF+ "   and bxq_pagcom = bxq_refere 
cQuery4 += CRLF+ " group by bxq_codven  , bxq_numpar , bxq_codemp , bxq_matric  , bxq_tipreg, Bxq.Bxq_Percom ,a3_nome , ba1_conemp  , ba1_subcon ,ba1_tipinc  )bxq  ,
cQuery4 += CRLF+ " ( select * " 
cQuery4 += CRLF+ "     from    " + RetSqlName("BXJ") + " BXJ , " + RetSqlName("BXK") + " BXK "   

cQuery4 += CRLF+ " where bxK_filial = '"+xFilial('BXK')+ "' and bxk.d_E_L_E_T_ = ' ' "  
cQuery4 += CRLF+ "   and BXJ_filial = '"+xFilial('BXJ')+ "' and bxj.d_E_L_E_T_ = ' ' "     
If !empty(cEmpInc )
   cQuery4 += CRLF+ " and bxj_codemp >= '"+cEmpInc +"' and bxj_codemp <= '"+cEmpFim+"'" 
EndIf       

cQuery4 += CRLF+ " AND (bxj_codven >= '"+cVendInc+"' AND bxj_codven <= '"+cVendFim+"'" 

cQuery4 += CRLF+ "   AND  bxk_seqBXJ = BXJ_SEQ "
cQuery4 += CRLF+ "   AND (BXJ.BXJ_VLDFIM = ' ' or substr(BXJ.BXJ_VLDFIM,1,6) > '"+ canomes+"' ) ) bxj1 " 
cQuery4 += CRLF+ " where bxq.tipinc = bxj_tipinc "
cQuery4 += CRLF+ "   AND BXJ_TIPO = '1' "
cQuery4 += CRLF+ "   and bxj1.bxj_codemp = bxq.codemp "
cQuery4 += CRLF+ "   and bxj1.bxj_codven = bxq.codven "
cQuery4 += CRLF+ "   and bxq.numpar >= bxk_qtdde    "
cQuery4 += CRLF+ "   and bxq.numpar <= bxk_qtdate   "
cQuery4 += CRLF+ "   and bxj1.bxj_conemp = bxq.conemp  "
cQuery4 += CRLF+ "   and bxj1.bxj_subcon = bxq.subcon  "

cQuery4 += CRLF+ " group by bxq.codven , bxq.nomvend , "
If Mv_par07 == 2 
   cQuery4 += CRLF+ " decode(bxj1.bxj_Tipinc,'1','PN','2','ADS','3','Dep','4','Trf','5','Adp', 'Nul') ," 
EndIf    
cQuery4 += CRLF+ "       bxj1.bxk_qtdde||' a '||bxj1.bxk_qtdate , bxj1.bxk_percon||'%'  , bxj1.bxk_percon  "
cQuery4 += CRLF+ " order by 1  " 

///---------------- Regra de comissao cadastrada   sem sub contrata
 cQuery4A := CRLF+" select bxq.codven , bxq.nomvend , " 
 cQuery4A += CRLF+"        bxj1.bxk_qtdde||' a '||bxj1.bxk_qtdate Parcel , bxj1.bxk_percon||'%' percom , "
 cQuery4A += CRLF+"        sum(bxq.qtda) qtda , "
 cQuery4A += CRLF+"        sum(bxq.vlrcom) vlcom , "
 cQuery4A += CRLF+"        sum(bxq.bascom) bacom , " 
 cQuery4A += CRLF+"        bxj1.bxk_percon perc    " 
 If Mv_par07==2 
    cQuery4A += CRLF+"    ,  decode(bxj1.bxj_Tipinc,'1','PN','2','ADS','3','Dep','4','Trf','5','Adp', 'Nul')  tipInc    " 
 Else 
    cQuery4A += CRLF+"   , ' '  tipInc  "   
 EndIf 
 
 cQuery4A += CRLF+"        from "
 cQuery4A += CRLF+"      ( select bxq_codven codven ,a3_nome nomvend , bxq_numpar numpar, count(*) qtda , Bxq.Bxq_Percom , sum(bxq_vlrcom) vlrcom , sum(bxq_bascom) bascom , 
 cQuery4A += CRLF+"              bxq_codemp codemp , bxq_matric  , bxq_tipreg , a3_nome Vend , ba1_conemp conemp , ba1_subcon subcon , ba1_tipinc tipinc "

cQuery4A += CRLF+ "  from    " + RetSqlName("BXQ") + " BXQ , " + RetSqlName("SA3") + " SA3, " + RetSqlName("BA1") + " BA1 "   

cQuery4A += CRLF+ "   where  bxQ_filial = '"+xFilial('BXQ')+ "' and bxQ.d_E_L_E_T_ = ' ' "  
cQuery4A += CRLF+ "    and  A3_filial = '"+xFilial('SA3')+ "' and SA3.d_E_L_E_T_ = ' ' "      
cQuery4A += CRLF+ "    and BA1_filial = '"+xFilial('BA1')+ "' and BA1.d_E_L_E_T_ = ' ' " 

cQuery4A += CRLF+ "   and bxq_ano||bxq_mes = '"+ canomes+"' "    

cQuery4A += CRLF+ "   and bxq_codint = ba1_codint 
cQuery4A += CRLF+ "   and bxq_codemp = ba1_codemp 
cQuery4A += CRLF+ "   and bxq_matric = ba1_matric
cQuery4A += CRLF+ "   and bxq_tipreg = ba1_tipreg
cQuery4A += CRLF+ "   and bxq_codven = a3_cod           

If !empty(cEmpInc )
   cQuery4A += CRLF+ "  and bxq_codemp >= '"+cEmpInc +"' and bxq_codemp <= '"+cEmpFim+"'" 
EndIf       
     
cQuery4A += CRLF+ "   and bxq_pagcom = bxq_refere 
cQuery4A += CRLF+ " group by bxq_codven  , bxq_numpar , bxq_codemp , bxq_matric  , bxq_tipreg, Bxq.Bxq_Percom ,a3_nome , ba1_conemp  , ba1_subcon ,ba1_tipinc  )bxq  ,
cQuery4A += CRLF+ " ( select * " 
cQuery4A += CRLF+ "     from    " + RetSqlName("BXJ") + " BXJ , " + RetSqlName("BXK") + " BXK "   

cQuery4A += CRLF+ " where bxK_filial = '"+xFilial('BXK')+ "' and bxk.d_E_L_E_T_ = ' ' "  
cQuery4A += CRLF+ "   and BXJ_filial = '"+xFilial('BXJ')+ "' and bxj.d_E_L_E_T_ = ' ' "     
If !empty(cEmpInc )
   cQuery4A += CRLF+ " and bxj_codemp >= '"+cEmpInc +"' and bxj_codemp <= '"+cEmpFim+"'" 
EndIf       

cQuery4A += CRLF+ "   AND  bxk_seqBXJ = BXJ_SEQ "
cQuery4A += CRLF+ "   AND  (BXJ.BXJ_VLDFIM = ' ' or substr(BXJ.BXJ_VLDFIM,1,6) > '"+ canomes+"' ) ) bxj1 " 

cQuery4A += CRLF+ " where bxq.tipinc = bxj_tipinc "
cQuery4A += CRLF+ "   AND BXJ_TIPO = '1' "
cQuery4A += CRLF+ "   and bxj1.bxj_codemp = bxq.codemp "
cQuery4A += CRLF+ "   and bxj1.bxj_codven = bxq.codven "
cQuery4A += CRLF+ "   and bxq.numpar >= bxk_qtdde    "
cQuery4A += CRLF+ "   and bxq.numpar <= bxk_qtdate   "     

cQuery4A += CRLF+ "   and bxj1.bxj_conemp = bxq.conemp  "
                                                                         
cQuery4A += CRLF+ " group by bxq.codven , bxq.nomvend ,  "  
If Mv_par07==2 
   cQuery4A += CRLF+ " decode(bxj1.bxj_Tipinc,'1','PN','2','ADS','3','Dep','4','Trf','5','Adp', 'Nul')  , " 
EndIf
cQuery4A += CRLF+ "       bxj1.bxk_qtdde||' a '||bxj1.bxk_qtdate , bxj1.bxk_percon||'%'  , bxj1.bxk_percon  "  

cQuery4A += CRLF+ " order by 1  " 
///---------------- Regra de comissao cadastrada   sem contrato e sub contrata

 cQuery4B := CRLF+" select bxq.codven , bxq.nomvend , " 
 cQuery4B += CRLF+"        bxj1.bxk_qtdde||' a '||bxj1.bxk_qtdate Parcel , bxj1.bxk_percon||'%' percom , "
 cQuery4B += CRLF+"        sum(bxq.qtda) qtda , "
 cQuery4B += CRLF+"        sum(bxq.vlrcom) vlcom , "
 cQuery4B += CRLF+"        sum(bxq.bascom) bacom , " 
 cQuery4B += CRLF+"        bxj1.bxk_percon perc    " 
 If Mv_par07==2 
    cQuery4B += CRLF+"       , decode(bxj1.bxj_Tipinc,'1','PN','2','ADS','3','Dep','4','Trf','5','Adp', 'Nul')  tipInc    " 
Else 
    cQuery4B += CRLF+"   , ' '  tipInc  "       
 EndIf 
 cQuery4B += CRLF+"        from "
 cQuery4B += CRLF+"      ( select bxq_codven codven ,a3_nome nomvend , bxq_numpar numpar, count(*) qtda , Bxq.Bxq_Percom , sum(bxq_vlrcom) vlrcom , sum(bxq_bascom) bascom , 
 cQuery4B += CRLF+"              bxq_codemp codemp , bxq_matric  , bxq_tipreg , a3_nome Vend , ba1_conemp conemp , ba1_subcon subcon , ba1_tipinc tipinc "

 cQuery4B += CRLF+ "  from    " + RetSqlName("BXQ") + " BXQ , " + RetSqlName("SA3") + " SA3, " + RetSqlName("BA1") + " BA1 "   

 cQuery4B+= CRLF+ "   where  bxQ_filial = '"+xFilial('BXQ')+ "' and bxQ.d_E_L_E_T_ = ' ' "  
cQuery4B += CRLF+ "    and  A3_filial = '"+xFilial('SA3')+ "' and SA3.d_E_L_E_T_ = ' ' "      
cQuery4B += CRLF+ "    and BA1_filial = '"+xFilial('BA1')+ "' and BA1.d_E_L_E_T_ = ' ' " 
       
cQuery4B += CRLF+ "   and bxq_ano||bxq_mes = '"+ canomes+"' "    

cQuery4B += CRLF+ "   and bxq_codint = ba1_codint 
cQuery4B += CRLF+ "   and bxq_codemp = ba1_codemp 
cQuery4B += CRLF+ "   and bxq_matric = ba1_matric
cQuery4B += CRLF+ "   and bxq_tipreg = ba1_tipreg
cQuery4B += CRLF+ "   and bxq_codven = a3_cod           

If !empty(cEmpInc )
   cQuery4B += CRLF+ "  and bxq_codemp >= '"+cEmpInc +"' and bxq_codemp <= '"+cEmpFim+"'" 
EndIf       
     
cQuery4B += CRLF+ "   and bxq_pagcom = bxq_refere 
cQuery4B += CRLF+ " group by bxq_codven  , bxq_numpar , bxq_codemp , bxq_matric  , bxq_tipreg, Bxq.Bxq_Percom ,a3_nome , ba1_conemp  , ba1_subcon ,ba1_tipinc  )bxq  ,
cQuery4B += CRLF+ " ( select * " 
cQuery4B += CRLF+ "     from    " + RetSqlName("BXJ") + " BXJ , " + RetSqlName("BXK") + " BXK "   

cQuery4B += CRLF+ " where bxK_filial = '"+xFilial('BXK')+ "' and bxk.d_E_L_E_T_ = ' ' "  
cQuery4B += CRLF+ "   and BXJ_filial = '"+xFilial('BXJ')+ "' and bxj.d_E_L_E_T_ = ' ' "     
If !empty(cEmpInc )
   cQuery4B += CRLF+ " and bxj_codemp >= '"+cEmpInc +"' and bxj_codemp <= '"+cEmpFim+"'" 
EndIf       

cQuery4B += CRLF+ "   AND  bxk_seqBXJ = BXJ_SEQ "
cQuery4B += CRLF+ "   AND  (BXJ.BXJ_VLDFIM = ' ' or substr(BXJ.BXJ_VLDFIM,1,6) > '"+ canomes+"' ) ) bxj1 " 

cQuery4B += CRLF+ " where bxq.tipinc = bxj_tipinc "
cQuery4B += CRLF+ "   AND BXJ_TIPO = '1' "
cQuery4B += CRLF+ "   and bxj1.bxj_codemp = bxq.codemp "
cQuery4B += CRLF+ "   and bxj1.bxj_codven = bxq.codven "
cQuery4B += CRLF+ "   and bxq.numpar >= bxk_qtdde    "
cQuery4B += CRLF+ "   and bxq.numpar <= bxk_qtdate   " 
                                                                         
cQuery4B += CRLF+ " group by bxq.codven , bxq.nomvend , "
If Mv_par07 == 2 
   cQuery4B += CRLF+ " decode(bxj1.bxj_Tipinc,'1','PN','2','ADS','3','Dep','4','Trf','5','Adp', 'Nul') , "  
EndIf    
cQuery4B += CRLF+ "       bxj1.bxk_qtdde||' a '||bxj1.bxk_qtdate , bxj1.bxk_percon||'%'  , bxj1.bxk_percon  "  
cQuery4B += CRLF+ " order by 1   " 
                                                    
///---------------- pgto de mesalidade retorativas    

 cQuery5 :=CRLF+ "SELECT LANCRET.BM1_CODEMP  ,LANCRET.COMP comp , count(*) qtda ,  " // BA1_CODEMP  , SUBSTR(BA1_DATBLO,7,2)||'/'||SUBSTR(BA1_DATBLO,5,2)||'/'||SUBSTR(BA1_DATBLO,1,4) , 
 cQuery5 +=CRLF+ " TO_CHAR(ADD_MONTHS(TO_DATE(substr((ba1_datinc),1,6) ,'YYYYMM'), 0),'YYYYMM') DATINC , "
 cQuery5 +=CRLF+ " COUNT(CASE WHEN  (BA3_COBNIV = '0' or BA3_COBNIV = ' ')    THEN 1 ELSE NULL END)  IncE , "
 cQuery5 +=CRLF+ " COUNT(CASE WHEN   BA3_COBNIV = '1'  THEN 1 ELSE NULL END)  IncF "
 cQuery5 +=CRLF+ " from " + RetSqlName("BA1") + " BA1 ," + RetSqlName("BA3") + " BA3 , ( SELECT BM1_CODEMP , BM1_MATRIC , BM1_TIPREG   , BM1_MES||'/'||BM1_ANO COMP,  BM1_CODTIP ||'-'|| bm1_destip , BM1_VALOR "
 cQuery5 +=CRLF+                                  "  FROM " + RetSqlName("BM1") + " BM1 "
 cQuery5 +=CRLF+                                   " WHERE BM1_FILIAL = '"+xFilial('BM1')+ "' AND D_e_l_e_t_ = ' ' "
 cQuery5 +=CRLF+                                   "   AND BM1_ANO||BM1_MES =  '"+cAnoMes+"' "
 cQuery5 +=CRLF+                                   "   and bm1_codtip in ('118','902') "
 If !empty(cEmpInc )
   cQuery5 += CRLF+ " and bm1_codemp >= '"+cEmpInc +"' and bm1_codemp <= '"+cEmpFim+"'" 
 EndIf
 cQuery5 +=CRLF+                                   " ) LANCRET  " 
 cQuery5 +=CRLF+ " where ba1_filial = '"+xFilial('BA1')+ "' and ba1.d_E_L_E_T_ = ' ' and ba3_filial = '"+xFilial('BA3')+ "' and ba3.d_E_L_E_T_ = ' ' " 
  If !empty(cEmpInc )
   cQuery5 += CRLF+ " and ba1_codemp >= '"+cEmpInc +"' and ba1_codemp <= '"+cEmpFim+"'" 
 EndIf 
 cQuery5 +=CRLF+   " AND substr(BA1_DATINC,1,6)= '"+canomesa+"' AND (substr(BA1_DATBLO,1,6) >= '"+canomesa+"' OR BA1_DATBLO = ' ') "
 cQuery5 +=CRLF+   " AND BA1_CODINT = BA3_CODINT and BA1_CODEMP = BA3_CODEMP and BA1_MATRIC = BA3_MATRIC  "
 cQuery5 +=CRLF+   " and  BA1_CODEMP = LANCRET.Bm1_CODEMP and BA1_MATRIC = LANCRET.Bm1_MATRIC and BA1_tipreg = LANCRET.Bm1_tipreg "
 cQuery5 +=CRLF+   " and not exists ( SELECT BM1_CODEMP , BM1_MATRIC , BM1_TIPREG   , BM1_CODTIP " 
 cQuery5 +=CRLF+                      "  FROM " + RetSqlName("BM1") + " BM1 "
 cQuery5 +=CRLF+                      " WHERE BM1_FILIAL = '"+xFilial('BM1')+ "' AND D_e_l_e_t_ = ' ' "
 cQuery5 +=CRLF+                      "   AND BM1_ANO||BM1_MES =  '"+canomesa+"' "
 cQuery5 +=CRLF+                      "   and BA1_CODINT = Bm1_CODINT and BA1_CODEMP = Bm1_CODEMP and BA1_MATRIC = Bm1_MATRIC and BA1_tipreg = Bm1_tipreg) "    
 cQuery5 +=CRLF+                      " group by LANCRET.BM1_CODEMP ,LANCRET.COMP ,  BA1_CODEMP  ,    ba1_datinc , BA3_COBNIV "   

 //--------------------------------------------- 
cQuery6 :="  select tabtit.codemp cidemp , e1_prefixo||e1_num || e1_tipo tit, substr(e1_vencrea,7,2)||'/'||substr(e1_vencrea,5,2)||'/'||substr(e1_vencrea,1,4) vencto, e1_valor ,e1_saldo saldo, e1_nomcli nomcli "
cQuery6 +=CRLF+"   from  " + RetSqlName("SE1") +" SE1 ,  "
cQuery6 +=CRLF+"       (select distinct BXQ.bxq_codemp codemp, (BXQ.bxq_prefix || BXQ.bxq_num||BXQ.bxq_tipo) tit "     

//cQuery6 += CRLF+       "  from  " + RetSqlName("BXQ") +" BXQ , " + RetSqlName("BXQ") +" BXQ1 "      
cQuery6 += CRLF+       "  from  " + RetSqlName("BXQ") +" BXQ  "                   
cQuery6 += CRLF+       " where bxq.bxq_filial = '"+xFilial('BXQ')+ "' and bxq.d_E_L_E_T_ = ' ' "  
//cQuery6 += CRLF+       "   and bxq1.bxq_filial = '"+xFilial('BXQ')+ "' and bxq1.d_E_L_E_T_ = ' ' "

//cQuery6 += CRLF+       "   AND BXQ.bxq_e2pref = BXQ1.bxq_e2pref "
//cQuery6 += CRLF+       "   AND BXQ.bxq_e2num  = BXQ1.bxq_e2num  "
//cQuery6 += CRLF+       "   AND BXQ.bxq_e2tipo = BXQ1.bxq_e2tipo "
                                                                    
If !empty(cEmpInc )
cQuery6 += CRLF+       "   and bxq.bxq_codemp >= '"+cEmpInc +"' and bxq.bxq_codemp <= '"+cEmpFim+"'" 
EndIf
cQuery6 += CRLF+       "   and bxq.bxq_ano||bxq.bxq_mes = '"+ canomes+"' "       
If !empty(cVendInc)
   cQuery6 += CRLF+    "   and bxq.bxq_codven >= '"+cVendInc+"' AND bxq.bxq_codven <= '"+cVendFim+"'"
EndIf 
cQuery6 += CRLF+       "   and bxq.bxq_pagcom = bxq.bxq_refere ) tabtit  "
cQuery6 += CRLF+ " where e1_filial = '"+xFilial('SE1')+ "' and se1.d_E_L_E_T_ = ' '"
cQuery6 += CRLF+ " and e1_anobase ||e1_mesbase   = '"+ canomes+"' "  
cQuery6 += CRLF+ " and e1_saldo > 0 "
cQuery6 += CRLF+ " and e1_prefixo = substr(tabtit.tit,1,3) "
cQuery6 += CRLF+ " and e1_num = substr(tabtit.tit,4,9) "
cQuery6 += CRLF+ " and trim(e1_tipo) = trim(substr(tabtit.tit,13,3)) "
cQuery6 += CRLF+ " order by tabtit.codemp "

 
//---------------------------------------------   
 

 cQuery7 :=     "SELECT bm11.codemp bm1codemp , bm11.qtda bm1qtda , bxq1.codemp bxqcodemp  , bxq1.qtda bxqqtda"
 cQuery7 +=CRLF+"  FROM ( "
 cQuery7 +=CRLF+"        SELECT codemp ,  COUNT(*)qtda "
 cQuery7 +=CRLF+"          FROM ( "
 cQuery7 +=CRLF+"                SELECT DISTINCT bm1_codemp codemp , bm1_matric , bm1_tipreg  "
 cQuery7 +=CRLF+"                  FROM " + RetSqlName("BM1") + " BM1  ," + RetSqlName("BA1") + " BA1 " 
 cQuery7 +=CRLF+"                 WHERE BA1_FILIAL = '"+xFilial('BA1')+ "' AND BA1.D_e_l_e_t_ = ' ' "
 cQuery7 +=CRLF+"                   AND BM1_FILIAL = '"+xFilial('BM1')+ "' AND BM1.D_e_l_e_t_ = ' ' " 
 cQuery7 +=CRLF+"                   AND BM1_ANO||BM1_MES = '"+ canomes+"' " 
 cQuery7 +=CRLF+"                   AND BM1_CODEMP >= '"+cEmpInc +"' AND BM1_CODEMP <= '"+cEmpFim+"'"
 cQuery7 +=CRLF+"                   AND BA1_codint = bm1_codint "
 cQuery7 +=CRLF+"                   AND BA1_CODEMP = BM1_CODEMP "
 cQuery7 +=CRLF+"                   AND BA1_MATRIC = BM1_MATRIC "
 cQuery7 +=CRLF+"                   AND BA1_TIPREG = BM1_TIPREG " 
// cQuery7 +=CRLF+"                   AND (BA1_CODVEN <> ' ' OR BA1_CODVE2 <> ' ') "
 cQuery7 +=CRLF+"                   AND BM1_CODTIP = '101' "
 cQuery7 +=CRLF+"               ) " 
 cQuery7 +=CRLF+"         GROUP BY codemp "
 cQuery7 +=CRLF+"         ORDER BY codemp "
 cQuery7 +=CRLF+"       ) bm11 "
 cQuery7 +=CRLF+"      ,( "
 cQuery7 +=CRLF+"        SELECT bxq_codemp codemp , COUNT(*) qtda " 
 cQuery7 +=CRLF+"          FROM ( "
 cQuery7 +=CRLF+"                SELECT DISTINCT bxq_codint , bxq_codemp , bxq_matric , bxq_tipreg " 
 cQuery7 +=CRLF+"                  FROM " + RetSqlName("BXQ") +" BXQ "
 cQuery7 +=CRLF+"                 WHERE bxq_filial = '"+xFilial('BXQ')+ "' AND  BXQ.d_E_L_E_T_ = ' ' "  
 cQuery7 +=CRLF+"                   AND BXQ_ANO||BXQ_MES = '"+ canomes+"' " 
 cQuery7 +=CRLF+"                   AND bxq_refere = bxq_pagcom  "
 cQuery7 +=CRLF+"                   AND bxq_vlrcom > 0  "
 cQuery7 +=CRLF+"                   AND BXQ_CODEMP >= '"+cEmpInc +"' AND BXQ_CODEMP <= '"+cEmpFim+"'"
 cQuery7 +=CRLF+"               ) "
 cQuery7 +=CRLF+"         GROUP BY  bxq_codemp "
 cQuery7 +=CRLF+"         ORDER BY  bxq_codemp " 
 cQuery7 +=CRLF+"       )bxq1 "
 cQuery7 +=CRLF+" WHERE BXQ1.CODEMP = BM11.CODEMP "
 cQuery7 +=CRLF+" ORDER BY BXQ1.CODEMP "                           
//---------------------------------------------     

 cQuery8 :=     " SELECT DISTINCT bxq_codint , bxq_codemp , bxq_matric , bxq_tipreg " 
 cQuery8 +=CRLF+"   FROM " + RetSqlName("BXQ") +" BXQ "
 cQuery8 +=CRLF+"  WHERE bxq_filial = '"+xFilial('BXQ')+ "' AND  BXQ.d_E_L_E_T_ = ' ' "  
 cQuery8 +=CRLF+"    AND BXQ_ANO||BXQ_MES = '"+ canomes+"' " 
 cQuery8 +=CRLF+"    AND bxq_refere = bxq_pagcom  "
 cQuery8 +=CRLF+"    AND bxq_vlrcom > 0  "
 cQuery8 +=CRLF+"    AND BXQ_CODEMP >= '"+cEmpInc +"' AND BXQ_CODEMP <= '"+cEmpFim+"' "
 cQuery8 +=CRLF+"MINUS
 cQuery8 +=CRLF+" SELECT DISTINCT BM1_codint , bm1_codemp codemp , bm1_matric , bm1_tipreg  "
 cQuery8 +=CRLF+"   FROM " + RetSqlName("BM1") + " BM1  ," + RetSqlName("BA1") + " BA1 " 
 cQuery8 +=CRLF+"  WHERE BA1_FILIAL = '"+xFilial('BA1')+ "' AND BA1.D_e_l_e_t_ = ' ' "
 cQuery8 +=CRLF+"    AND BM1_FILIAL = '"+xFilial('BM1')+ "' AND BM1.D_e_l_e_t_ = ' ' " 
 cQuery8 +=CRLF+"    AND BM1_ANO||BM1_MES = '"+ canomes+"' " 
 cQuery8 +=CRLF+"    AND BM1_CODEMP >= '"+cEmpInc +"' AND BM1_CODEMP <= '"+cEmpFim+"'"
 cQuery8 +=CRLF+"    AND BA1_codint = bm1_codint "
 cQuery8 +=CRLF+"    AND BA1_CODEMP = BM1_CODEMP "
 cQuery8 +=CRLF+"    AND BA1_MATRIC = BM1_MATRIC "
 cQuery8 +=CRLF+"    AND BA1_TIPREG = BM1_TIPREG " 
 cQuery8 +=CRLF+"    AND (BA1_CODVEN <> ' ' OR BA1_CODVE2 <> ' ') "
 cQuery8 +=CRLF+"    AND BM1_CODTIP = '101' "
//---------------------------------------------          

cquery9 := CRLF+"   SELECT Count(*) qtda " 
cquery9 += CRLF+"     FROM "+ RetSqlName("BA1") + " BA11 " 
cquery9 += CRLF+"    INNER JOIN "+ RetSqlName("BA1") + " BA12 "  
cquery9 += CRLF+"       ON BA11.BA1_MATVID  =  BA12.BA1_MATVID 
cquery9 += CRLF+"      AND BA12.BA1_FILIAL  = '" + xFilial('BA1') + "' AND BA12.D_e_l_e_t_ = ' ' 
cquery9 += CRLF+"      AND BA12.BA1_CODEMP >='"+cEmpInc +"' AND BA12.BA1_codemp <= '"+cEmpFim+"' "    

cquery9 += CRLF+"      AND substr(BA12.BA1_DATINC,1,6) >= '"+ canomes+"' " 
cquery9 += CRLF+"      AND substr(BA12.BA1_DATINC,1,6) <= '"+ canomes+"' "      

cquery9 += CRLF+"      AND TO_DATE (BA12.BA1_DATINC,'YYYYMMDD') - TO_DATE(BA11.BA1_DATBLO,'YYYYMMDD') <= 180 "  

cquery9 += CRLF+"    INNER JOIN " + RetSqlName("BXK") + " BXK "
cquery9 += CRLF+"       ON bxk_filial = '"+xFilial('BXK')+ "' and bxk.d_E_L_E_T_ = ' ' "         
 
cquery9 += CRLF+"      INNER JOIN "+ RetSqlName("BXQ") + " BXQ1 "  
cquery9 += CRLF+"       ON ba12.ba1_codemp = BXQ1.bxq_codemp  "
cquery9 += CRLF+"      AND BXQ1.BXQ_FILIAL = '" + xFilial('BXQ') + "' AND BXQ1.D_e_l_e_t_ = ' ' "
cquery9 += CRLF+"      AND ba12.ba1_matric = BXQ1.bxq_matric "
cquery9 += CRLF+"      AND ba12.ba1_tipreg = BXQ1.bxq_tipreg "
//cquery += CRLF+"      AND BXQ1.bxq_ano || BXQ1.bxq_mes = substr(BA12.BA1_DATINC,1,6) "  (BUSCA AGENCIAMENTO EM QQ MENSALIDADE)
cquery9 += CRLF+"      AND BXQ1.BXQ_REFERE = BXQ1.BXQ_PAGCOM "
cquery9 += CRLF+"      AND BXQ1.BXQ_PERCOM > 10 AND BXQ1.BXQ_BASCOM > 0 " 
cquery9 += CRLF+"      INNER JOIN "+ RetSqlName("BXQ") + " BXQ2 "  
cquery9 += CRLF+"       ON ba11.ba1_codemp = BXQ2.bxq_codemp  "
cquery9 += CRLF+"      AND BXQ2.BXQ_FILIAL  = '" + xFilial('BXQ') + "' AND BXQ2.D_e_l_e_t_ = ' ' "
cquery9 += CRLF+"      AND ba11.ba1_matric = BXQ2.bxq_matric "
cquery9 += CRLF+"      AND ba11.ba1_tipreg = BXQ2.bxq_tipreg  and bxq1.bxq_numpar = bxq2.bxq_numpar "  

//cquery += CRLF+"      AND BXQ2.bxq_ano || BXQ2.bxq_mes = substr(BA11.BA1_DATINC,1,6) "(BUSCA AGENCIAMENTO EM QQ MENSALIDADE)
cquery9 += CRLF+"      AND BXQ2.BXQ_REFERE = BXQ2.BXQ_PAGCOM "      
cquery9 += CRLF+"      AND BXQ2.BXQ_PERCOM > 10  AND BXQ1.BXQ_BASCOM > 0 "  

cquery9 += CRLF+"      And ( ((bxk_qtdde <= 10   and  bxk_qtdate >= 10 )AND (bxq1.bxq_codven = bxq2.bxq_codven))or   "
cquery9 += CRLF+"          ( ((bxq1.bxq_codven <> bxq2.bxq_codven))AND (BXQ1.BXQ_CODVEN = (                          "
cquery9 += CRLF+"              select  bxj_codven 
cquery9 += CRLF+"                from  " + RetSqlName("BXJ") + " BXJ  , " + RetSqlName("SA3") + " SA3 , " + RetSqlName("BXK") + " BXK "
cquery9 += CRLF+"               where  bxj_filial = '"+xFilial('BXJ')+ "' and bxj.d_E_L_E_T_ = ' ' "   
cquery9 += CRLF+"                 and  bxk_filial = '"+xFilial('BXK')+ "' and bxk.d_E_L_E_T_ = ' ' "   
cquery9 += CRLF+"                 and  bxj_vldfim = ' ' "
cquery9 += CRLF+"                 AND  bxj_codemp >= BA12.BA1_codemp AND bxj_codemp <=BA12.BA1_codemp  "      
cquery9 += CRLF+"                 AND  A3_filial = '"+xFilial('SA3')+ "' and SA3.d_E_L_E_T_ = ' ' "
cquery9 += CRLF+"                 AND  bxk_seqbxj = bxj_seq "
cquery9 += CRLF+"                 AND  bxj_codven = a3_cod AND bxj_vldfim = ' ' "
cquery9 += CRLF+"                 AND  bxk_qtdate < 10 "
cquery9 += CRLF+"               GROUP  BY bxj_codven ,a3_nome  "
cquery9 += CRLF+"              HAVING  COUNT(*) = 1 "
cquery9 += CRLF+"            ))  ))     " 
 
cquery9 += CRLF+" full outer JOIN "+ RetSqlName("BXQ") + " BXQ3 "
cquery9 += CRLF+"      ON ba12.ba1_codemp = BXQ3.bxq_codemp " 
cquery9 += CRLF+"      AND BXQ3.BXQ_FILIAL  = '" + xFilial('BXQ') + "' AND BXQ3.D_e_l_e_t_ = ' ' "
cquery9 += CRLF+"     AND ba12.ba1_matric = BXQ3.bxq_matric "
cquery9 += CRLF+"     AND ba12.ba1_tipreg = BXQ3.bxq_tipreg "
cquery9 += CRLF+"     AND BXQ3.BXQ_REFERE = BXQ3.BXQ_PAGCOM "
cquery9 += CRLF+"     AND BXQ3.BXQ_NUMPAR  >= 999  "
cquery9 += CRLF+"     and bxq1.bxq_codven = bxq3.bxq_codven "
cquery9 += CRLF+"     AND BXQ1.BXQ_NUM = BXQ3.BXQ_NUM "
 
cquery9 += CRLF+"    INNER JOIN " + RetSqlName("BXJ") + " BXJ "
cquery9 += CRLF+"       ON bxj_filial = '"+xFilial('BXJ')+ "' and bxj.d_E_L_E_T_ = ' ' "   
cquery9 += CRLF+"      and bxj_codven = BXQ1.BXQ_CODVEN  and bxj_vldfim = ' ' "
cquery9 += CRLF+"      and bxj_codemp >= BXQ1.BXQ_CODEMP AND bxj_codemp <= BXQ1.BXQ_CODEMP "         
cquery9 += CRLF+"      AND bxk_seqbxj = bxj_seq "
      
cquery9 += CRLF+"    INNER JOIN  " + RetSqlName("SA3") + " SA3 " 
cquery9 += CRLF+"       ON A3_filial = '"+xFilial('SA3')+ "' and SA3.d_E_L_E_T_ = ' ' " 
cquery9 += CRLF+"      and bxk_seqbxj = bxj_seq "
cquery9 += CRLF+"      and bxj_codven = a3_cod and bxj_vldfim = ' ' "
      
cquery9 += CRLF+"    WHERE BA11.BA1_FILIAL = '" + xFilial('BA1') + "' AND BA11.D_e_l_e_t_ = ' ' "
cquery9 += CRLF+"      AND BA11.BA1_DATBLO <> ' ' AND BA11.BA1_DATINC < BA12.BA1_DATINC "
cquery9 += CRLF+"      AND BA11.R_E_C_N_O_ <> BA12.R_E_C_N_O_ "
//------------------------------------------------------------
//    Sinistralidade 
cquery11 := CRLF+"select  "
cquery11 += CRLF+"          RETORNA_SINISTRALIDADE_MS_CAB ('"+cEmpresa+"','R',null,'"+cEmpInc +"' ,null,null,null,TO_DATE('"+cAnoAntFA+"'||'"+cMesAntFA+"'||'01','YYYYMMDD'),TO_DATE('"+cAnoAntIA+"'||'"+cMesAntIA+"'||'"+cDiaIA+"','YYYYMMDD')) RECEITA_A  "
cquery11 += CRLF+"         ,RETORNA_SINISTRALIDADE_MS_CAB ('"+cEmpresa+"','C',null,'"+cEmpInc +"' ,null,null,null,TO_DATE('"+cAnoAntFA+"'||'"+cMesAntFA+"'||'01','YYYYMMDD'),TO_DATE('"+cAnoAntIA+"'||'"+cMesAntIA+"'||'"+cDiaIA+"','YYYYMMDD')) CUSTO_A    "
cquery11 += CRLF+"         ,RETORNA_SINISTRALIDADE_MS_CAB ('"+cEmpresa+"','S',null,'"+cEmpInc +"' ,null,null,null,TO_DATE('"+cAnoAntFA+"'||'"+cMesAntFA+"'||'01','YYYYMMDD'),TO_DATE('"+cAnoAntIA+"'||'"+cMesAntIA+"'||'"+cDiaIA+"','YYYYMMDD')) SINIST_A   "   

cquery11 += CRLF+"         ,RETORNA_SINISTRALIDADE_MS_CAB ('"+cEmpresa+"','R',null,'"+cEmpInc +"' ,null,null,null,TO_DATE('"+cAnoAntFB+"'||'"+cMesAntFB+"'||'01','YYYYMMDD'),TO_DATE('"+cAnoAntIA+"'||'"+cMesAntIA+"'||'"+cDiaIB+"','YYYYMMDD')) RECEITA_B  "
cquery11 += CRLF+"         ,RETORNA_SINISTRALIDADE_MS_CAB ('"+cEmpresa+"','C',null,'"+cEmpInc +"' ,null,null,null,TO_DATE('"+cAnoAntFB+"'||'"+cMesAntFB+"'||'01','YYYYMMDD'),TO_DATE('"+cAnoAntIA+"'||'"+cMesAntIA+"'||'"+cDiaIB+"','YYYYMMDD')) CUSTO_B    "
cquery11 += CRLF+"         ,RETORNA_SINISTRALIDADE_MS_CAB ('"+cEmpresa+"','S',null,'"+cEmpInc +"' ,null,null,null,TO_DATE('"+cAnoAntFB+"'||'"+cMesAntFB+"'||'01','YYYYMMDD'),TO_DATE('"+cAnoAntIA+"'||'"+cMesAntIA+"'||'"+cDiaIB+"','YYYYMMDD')) SINIST_B   " 
/*
cquery11 += CRLF+"         ,RETORNA_SINISTRALIDADE_MS_CAB ('"+cEmpresa+"','R',null,'"+cEmpInc +"' ,null,null,null,TO_DATE('"+cAnoAntFB+"'||'"+cMesAntFB+"'||'01','YYYYMMDD'),TO_DATE('"+cAnoAntIB+"'||'"+cMesAntIB+"'||'"+cDiaIB+"','YYYYMMDD')) RECEITA_B  "
cquery11 += CRLF+"         ,RETORNA_SINISTRALIDADE_MS_CAB ('"+cEmpresa+"','C',null,'"+cEmpInc +"' ,null,null,null,TO_DATE('"+cAnoAntFB+"'||'"+cMesAntFB+"'||'01','YYYYMMDD'),TO_DATE('"+cAnoAntIB+"'||'"+cMesAntIB+"'||'"+cDiaIB+"','YYYYMMDD')) CUSTO_B    "
cquery11 += CRLF+"         ,RETORNA_SINISTRALIDADE_MS_CAB ('"+cEmpresa+"','S',null,'"+cEmpInc +"' ,null,null,null,TO_DATE('"+cAnoAntFB+"'||'"+cMesAntFB+"'||'01','YYYYMMDD'),TO_DATE('"+cAnoAntIB+"'||'"+cMesAntIB+"'||'"+cDiaIB+"','YYYYMMDD')) SINIST_B   " */
cquery11 += CRLF+"  from dual " 

//------------------------------------------------------------


cquery10 := CRLF+"    select SUM(BXQ_VLRCOM) VLRCOM   , NVL( E2_VALOR,0) VLRTIT 
cquery10 += CRLF+"    from " + RetSqlName("SE2") + " SE2 , " + RetSqlName("BXQ") + " BXQ   "
cquery10 += CRLF+"   where BXQ_FILIAL   = '"+xFilial('BXQ')+ "' and BXQ.D_E_L_E_T_ = ' '   "
cquery10 += CRLF+"     and E2_FILIAL(+) = '"+xFilial('SE2')+ "' and SE2.D_E_L_E_T_(+)= ' ' "            
cquery10 += CRLF+"     and BXQ_CODEMP >='"+cEmpInc +"' AND BXQ_CODEMP <= '"+cEmpFim+"' "  
cquery10 += CRLF+"     and BXQ_ANO||BXQ_MES >= '"+cAnoAntFA+cMesAntFA+"' and BXQ_ANO||BXQ_MES <= '"+cAnoAntIA+cMesAntIA+"'"
cquery10 += CRLF+"     and BXQ_REFERE    = BXQ_PAGCOM "
cquery10 += CRLF+"     and E2_FORNECE(+) = BXQ_E2FORN "
cquery10 += CRLF+"     and E2_PREFIXO(+) = BXQ_E2PREF "
cquery10 += CRLF+"     and E2_NUM(+)     = BXQ_E2NUM  "
cquery10 += CRLF+"     and E2_PARCELA(+) = BXQ_E2PARC "
cquery10 += CRLF+"     and E2_TIPO(+)    = BXQ_E2TIPO " 
cquery10 += CRLF+"   Group by NVL( E2_VALOR,0)" 

cquery12 := CRLF+"    select SUM(BXQ_VLRCOM) VLRCOM   , NVL( E2_VALOR,0) VLRTIT 
cquery12 += CRLF+"    from " + RetSqlName("SE2") + " SE2 , " + RetSqlName("BXQ") + " BXQ   "
cquery12 += CRLF+"   where BXQ_FILIAL   = '"+xFilial('BXQ')+ "' and BXQ.D_E_L_E_T_ = ' '   "
cquery12 += CRLF+"     and E2_FILIAL(+) = '"+xFilial('SE2')+ "' and SE2.D_E_L_E_T_(+)= ' ' "            
cquery12 += CRLF+"     and BXQ_CODEMP >='"+cEmpInc +"' AND BXQ_CODEMP <= '"+cEmpFim+"' "  
//cquery12 += CRLF+"     and BXQ_ANO||BXQ_MES >= '"+cAnoAntFB+cMesAntFB+"' and BXQ_ANO||BXQ_MES <= '"+cAnoAntIB+cMesAntIB+"'"   
cquery12 += CRLF+"     and BXQ_ANO||BXQ_MES >= '"+cAnoAntFB+cMesAntFB+"' and BXQ_ANO||BXQ_MES <=  '"+cAnoAntIA+cMesAntIA+"'"
cquery12 += CRLF+"     and BXQ_REFERE    = BXQ_PAGCOM "
cquery12 += CRLF+"     and E2_FORNECE(+) = BXQ_E2FORN "
cquery12 += CRLF+"     and E2_PREFIXO(+) = BXQ_E2PREF "
cquery12 += CRLF+"     and E2_NUM(+)     = BXQ_E2NUM  "
cquery12 += CRLF+"     and E2_PARCELA(+) = BXQ_E2PARC "
cquery12 += CRLF+"     and E2_TIPO(+)    = BXQ_E2TIPO " 
cquery12 += CRLF+"   Group by NVL( E2_VALOR,0)"

////---------------------------
cQuery14 := " select BA1_CODEMP ||'-'||substr(BG9_DESCRI,1,12) nomemp, 
cQuery14 += CRLF + " BXQ_codven ||'-'||substr(A3_NOME ,1,12)   nomven, "
cQuery14 += CRLF + " Decode(TRIM(ba1_ymtodo),'', 'Saúde', 'Odonto') tpope, "
cQuery14 += CRLF + " sum(bxq_bascom) VlrTit , sum(bxq_vlrcom) VlrCom, count(*) qtda" 
cQuery14 += CRLF + " from " + RetSqlName("BA1") +" BA1 ," + RetSqlName("BXQ") +" BXQ ,"  
cQuery14 += CRLF + " " + RetSqlName("BG9") +" BG9 ," + RetSqlName("SA3") +" SA3 "  

cQuery14 += CRLF + "where ba1_filial = '"+xFilial('BA1')+ "' and ba1.d_E_L_E_T_ = ' ' "      
cQuery14 += CRLF + "     and bxq_filial = '"+xFilial('BXQ')+ "' and bxq.d_E_L_E_T_ = ' ' "      
cQuery14 += CRLF + "     and bxq_filial = '"+xFilial('BG9')+ "' and BG9.d_E_L_E_T_ = ' ' "      
cQuery14 += CRLF + "     and bxq_filial = '"+xFilial('SA3')+ "' and SA3.d_E_L_E_T_ = ' ' "      
If !empty(cEmpInc )
   cQuery14 += CRLF+ " and ba1_codemp >= '"+cEmpInc +"' and ba1_codemp <= '"+cEmpFim+"'" 
EndIf                                                                               
If !empty(cVendInc)
   cQuery14 += CRLF+ " AND (ba1_codven >= '"+cVendInc+"' AND bxq_codven <= '"+cVendFim+"'" 
   cQuery14 += CRLF+ " OR  ba1_codve2 >= '"+cVendInc+"' AND bxq_codve2 <= '"+cVendFim+"' )"
EndIf  

cQuery14 += CRLF+   " and BXQ_ANO||BXQ_MES >= '"+ canomes+"' and BXQ_ANO||BXQ_MES <=  '"+ canomes+"'"    
cQuery14 += CRLF+   "  and (ba1_datblo = ' ' or substr(ba1_datblo,1,6) > '"+ canomes+"' )"
cQuery14 += CRLF+   "  AND ba1_codint || ba1_codemp || ba1_matric || ba1_tipreg || ba1_digito = bxq_codint || bxq_codemp || bxq_matric || bxq_tipreg || bxq_digito "
cQuery14 += CRLF+   "  AND bxq_pagcom = bxq_refere " 

cQuery14 += CRLF+   "  and bg9_codigo = bxq_codemp " 
cQuery14 += CRLF+   "  and bxq_codven = a3_cod "

cQuery14 += CRLF+   "  group by BA1_CODEMP ||'-'||substr(BG9_DESCRI,1,12) , 
cQuery14 += CRLF+   "  bXQ_codven ||'-'||substr(A3_NOME ,1,12)  , 
cQuery14 += CRLF+   "  decode(TRIM(ba1_ymtodo),'', 'Saúde', 'Odonto') "
cQuery14 += CRLF+   "  order by 3 "       
   
//-----------------------------------------
If Select((cAliastmp)) <> 0 
   (cAliastmp)->(DbCloseArea())  
Endif 
If Select((cAliastmp1)) <> 0 
   (cAliastmp1)->(DbCloseArea())  
Endif
If Select((cAliastmp2)) <> 0 
   (cAliastmp2)->(DbCloseArea())  
Endif
If Select((cAliastmp3)) <> 0 
   (cAliastmp3)->(DbCloseArea())  
Endif                
If Select((cAliastmp4)) <> 0 
   (cAliastmp4)->(DbCloseArea())  
Endif 
If Select((cAliastmp5)) <> 0 
   (cAliastmp5)->(DbCloseArea())  
Endif                    
If Select((cAliastmp6)) <> 0 
   (cAliastmp6)->(DbCloseArea())  
Endif        
If Select((cAliastmp7)) <> 0 
   (cAliastmp7)->(DbCloseArea())  
Endif        
If Select((cAliastmp8)) <> 0 
   (cAliastmp8)->(DbCloseArea())  
Endif          

If Select((cAliastmp9)) <> 0 
   (cAliastmp9)->(DbCloseArea())  
Endif 
/*
If Select((cAliastm10)) <> 0 
   (cAliastm10)->(DbCloseArea())  
Endif  
If Select((cAliastm11)) <> 0 
   (cAliastm11)->(DbCloseArea())  
Endif              

If Select((cAliastm12)) <> 0 
   (cAliastm12)->(DbCloseArea())  
Endif 
*/
If Select((cAliastm14)) <> 0 
   (cAliastm12)->(DbCloseArea())  
Endif 
        
TCQuery cQuery  New Alias (cAliastmp)   
TCQuery cQuery1 New Alias (cAliastmp1)   
TCQuery cQuery2 New Alias (cAliastmp2)   
TCQuery cQuery3 New Alias (cAliastmp3)   
TCQuery cQuery4 New Alias (cAliastmp4) 
(cAliastmp4)->(dbGoTop())   
If (cAliastmp4)->(EOF())   
   (cAliastmp4)->(DbCloseArea())             
   TCQuery cQuery4A New Alias (cAliastmp4) 
   (cAliastmp4)->(dbGoTop())   
   If (cAliastmp4)->(EOF())   
      (cAliastmp4)->(DbCloseArea())             
       TCQuery cQuery4B New Alias (cAliastmp4)    
   EndIf 
EndIf     
TCQuery cQuery5 New Alias (cAliastmp5)    
TCQuery cQuery6 New Alias (cAliastmp6)    
TCQuery cQuery7 New Alias (cAliastmp7)    
TCQuery cQuery8 New Alias (cAliastmp8)    

TCQuery cQuery9 New Alias (cAliastmp9)    
/*
TCQuery cQuery10 New Alias (cAliastm10)    
TCQuery cQuery11 New Alias (cAliastm11)    
TCQuery cQuery12 New Alias (cAliastm12)   
*/
TCQuery cQuery14 New Alias (cAliastm14)   

(cAliastmp )->(dbGoTop()) 
(cAliastmp1)->(dbGoTop())
(cAliastmp2)->(dbGoTop())
(cAliastmp3)->(dbGoTop())
(cAliastmp4)->(dbGoTop()) 
(cAliastmp5)->(dbGoTop()) 
(cAliastmp6)->(dbGoTop())  
(cAliastmp7)->(dbGoTop()) 
(cAliastmp8)->(dbGoTop()) 

(cAliastmp9)->(dbGoTop()) 
/*
(cAliastm10)->(dbGoTop()) 
(cAliastm11)->(dbGoTop()) 
(cAliastm12)->(dbGoTop())
*/
(cAliastm14)->(dbGoTop())

//While (cAliastmp)->(!EOF()) .and. (cAliastmp1)->(!EOF()) .and. (cAliastmp2)->(!EOF()) .and. (cAliastmp3)->(!EOF()) .and. (cAliastmp4)->(!EOF())
	If nLin > 55 // Salto de Página. Neste caso o formulario tem 55 linhas...
	   nLin :=	Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
	   nLin ++
	Endif
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifica o cancelamento pelo usuario...                             ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	
	If lAbortPrint
		@nLin,00 PSAY "*** CANCELADO PELO OPERADOR ***"
	 //	Exit
	Endif
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Impressao do cabecalho do relatorio. . .                            ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ  
	//identificacao da empresa (contratante)
    @ nLin,001 PSAY "Empresa Contratante "     
	@ nLin,043 PSAY "Ref. "
	@ nLin,071 PSAY " Vlr Receb"          
	  nlin++          
    @ nLin,001 PSAY ctraco80
      nlin++        
    @ nLin,002 PSAY substr((cAliastmp)->Cliente,1,40)   
    @ nLin,043 PSAY (cAliastmp)->referencia     
    @ nLin,068 PSAY (cAliastmp1)->vlrrec  Picture "@E 99,999,999.99"  
	//identificacao do(s) vendedor(es)    
  	  nlin++          
    @ nLin,001 PSAY ctraco80
      nlin++
	@ nLin,001 PSAY "Vendedor  "  
	@ nLin,043 PSAY "Tit a Pagar  "
    @ nLin,058 PSAY "      Valor "  
	@ nLin,074 PSAY "Venc." 
	  nlin++          
    @ nLin,001 PSAY ctraco80
      nlin++            
    While (cAliastmp)->(!EOF())   
       if (cAliastmp)->ttitpgto != cttitpgto
           cttitpgto:=(cAliastmp)->ttitpgto 
                
           @ nLin,002 PSAY substr((cAliastmp)->Vendedor,1,40) 
           @ nLin,043 PSAY (cAliastmp)->ttitpgto
           @ nLin,058 PSAY (cAliastmp)->Vlrtit  Picture "@E 99,999,999.99" 
           @ nLin,072 PSAY stod((cAliastmp)->venc)    
             nlin++   
           if (cAliastmp)->Vlr_inss > 0  
              @ nLin,045 PSAY 'INSS'
              @ nLin,058 PSAY (cAliastmp)->Vlr_inss  Picture "@E 99,999,999.99"+"-" 
              nlin++   	
           EndIf     
	       if (cAliastmp)->Vlr_irrf > 0  
              @ nLin,045 PSAY 'IRRF'
              @ nLin,058 PSAY (cAliastmp)->Vlr_irrf  Picture "@E 99,999,999.99"+"-" 
              nlin++   	
           EndIf   
           if (cAliastmp)->Vlr_iss > 0  
              @ nLin,045 PSAY 'ISS'
              @ nLin,058 PSAY (cAliastmp)->Vlr_iss  Picture "@E 99,999,999.99"+"-" 
              nlin++   	
           EndIf     
	       if (cAliastmp)->Vlr_PIS > 0  
              @ nLin,045 PSAY 'PIS'
              @ nLin,058 PSAY (cAliastmp)->Vlr_PIS  Picture "@E 99,999,999.99"+"-" 
              nlin++   	
          EndIf      
          if (cAliastmp)->Vlr_cof > 0  
              @ nLin,045 PSAY 'Cofins '
              @ nLin,058 PSAY (cAliastmp)->Vlr_cof  Picture "@E 99,999,999.99"+"-" 
              nlin++   	
           EndIf     
	       if (cAliastmp)->Vlr_csl > 0  
              @ nLin,045 PSAY 'Csll'
              @ nLin,058 PSAY (cAliastmp)->Vlr_csl  Picture "@E 99,999,999.99"+"-" 
              nlin++   	
           EndIf   
           if (cAliastmp)->Vlr_valor > 0  
              @ nLin,045 PSAY '______________________________'
              nlin++   	
              @ nLin,045 PSAY 'Valor Liq '
              @ nLin,058 PSAY (cAliastmp)->Vlr_valor  Picture "@E 99,999,999.99" 
              nlin++   	
           EndIf     
       EndIf  
       	  If nLin > 55 // Salto de Página. Neste caso o formulario tem 55 linhas...
	         nLin :=	Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
	         nLin ++
	      Endif
      	(cAliastmp)->(dbSkip())                     
  	    
    EndDo    	      
    cttitpgto:=' '    
	//identificacao do(s) lanc; de comissao      
	@ nLin,001 PSAY ctraco80
      nlin++               
    @ nLin,001 PSAY "Vendedor "        
    @ nLin,042 PSAY "Vlr Base"  
	@ nLin,055 PSAY "% "
    @ nLin,062 PSAY "Vlr Comissao"  
	@ nLin,077 PSAY "Qtda" 
	  nlin++          
    @ nLin,001 PSAY ctraco80
      nlin++                
   
                                            
     (cAliastmp4)->(dbGoTop())  
     While (cAliastmp4)->(!EOF())   
          
           @ nLin,002 PSAY substr((cAliastmp4)->NOMVend,1,34)                                  
           @ nLin,037 PSAY (cAliastmp4)->bacom  Picture "@E 99,999,999.99"     
           @ nLin,055 PSAY (cAliastmp4)->percom              
           @ nLin,062 PSAY (cAliastmp4)->vlcom  Picture "@E 99,999,999.99"
             cqtdavend :=(cAliastmp4)->qtda
           @ nLin,076 PSAY cqtdavend  Picture "@E 99,999"

             nlin++
           If nLin > 55 // Salto de Página. Neste caso o formulario tem 55 linhas...
	         nLin :=	Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
	         nLin ++
	      Endif
      
      	(cAliastmp4)->(dbSkip())                     
   
   	    
    EndDo       
    
   //identificacao do(s) lanc de cobranca      

	@ nLin,001 PSAY ctraco80
      nlin++               
    @ nLin,001 PSAY "Lanc. Cobrança "        
    @ nLin,037 PSAY "Vlr C/Comissao "  
	@ nLin,055 PSAY "Qtda"
    @ nLin,062 PSAY "Vlr S/Comissao "  
	@ nLin,077 PSAY "Qtda"
	  nlin++          
    @ nLin,001 PSAY ctraco80
      nlin++           
      (cAliastmp2)->(dbGoTop())          
     While (cAliastmp2)->(!EOF())       
           @ nLin,002 PSAY substr((cAliastmp2)->lanccom ,1,34)                                  
           @ nLin,038 PSAY (cAliastmp2)->vlr_com  Picture "@E 99,999,999.99"     
           @ nLin,053 PSAY (cAliastmp2)->qtda_com Picture "@E 99,999"             
           @ nLin,061 PSAY (cAliastmp2)->vlr_sem  Picture "@E 99,999,999.99"
           @ nLin,075 PSAY (cAliastmp2)->qtda_sem Picture "@E 99,999"                                                     
           
       //    @ nLin,075 PSAY (cAliastmp2)->Qtda_smatric Picture "@E 99,999" 
           
             nlin++
           If nLin > 55 // Salto de Página. Neste caso o formulario tem 55 linhas...
	          nLin :=	Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
	          nLin ++
	       Endif
      	   (cAliastmp2)->(dbSkip())                     
  	    
       EndDo                           
    
     //Evoluçaõ de vidas     

    (cAliastmp3)->(dbGoTop())   
     Cdtinc:= substr((cAliastmp3)->DATINC,5,2)+'/'+substr((cAliastmp3)->DATINC,1,4)
     Cdt5  := substr((cAliastmp3)->DAT5 ,5,2)+'/'+substr((cAliastmp3)->DAT5,1,4) 
     Cdt4  := substr((cAliastmp3)->DAT4 ,5,2)+'/'+substr((cAliastmp3)->DAT4,1,4) 
     Cdt3  := substr((cAliastmp3)->DAT3 ,5,2)+'/'+substr((cAliastmp3)->DAT3,1,4) 
     Cdt2  := substr((cAliastmp3)->DAT2 ,5,2)+'/'+substr((cAliastmp3)->DAT2,1,4) 
     Cdt1  := substr((cAliastmp3)->DAT1 ,5,2)+'/'+substr((cAliastmp3)->DAT1,1,4)
     Cdt0  := substr((cAliastmp3)->DAT0 ,5,2)+'/'+substr((cAliastmp3)->DAT0,1,4)    
	@ nLin,001 PSAY ctraco80
      nlin++                          
      
    @ nLin,014 PSAY Cdtinc        
    @ nLin,024 PSAY Cdt5       
    @ nLin,034 PSAY Cdt4       
    @ nLin,044 PSAY Cdt3       
    @ nLin,054 PSAY Cdt2        
    @ nLin,064 PSAY Cdt1 
    @ nLin,074 PSAY Cdt0                
      nlin++
	@ nLin,001 PSAY ctraco80
                     
      nlin++               

    @ nLin,001 PSAY "C/Comissao "  
    @ nLin,015 PSAY (cAliastmp3)->IncE Picture "@E 99,999" 
    @ nLin,025 PSAY (cAliastmp3)->M5E  Picture "@E 99,999" 
    @ nLin,035 PSAY (cAliastmp3)->M4E  Picture "@E 99,999"
    @ nLin,045 PSAY (cAliastmp3)->M3E  Picture "@E 99,999"
    @ nLin,055 PSAY (cAliastmp3)->M2E  Picture "@E 99,999"
    @ nLin,065 PSAY (cAliastmp3)->M1E  Picture "@E 99,999"
    @ nLin,075 PSAY (cAliastmp3)->M0E  Picture "@E 99,999" 
    
      nlin++                
	@ nLin,001 PSAY ctraco80      

    @ nLin,002 PSAY "S/Comissao "  
    @ nLin,016 PSAY (cAliastmp3)->IncF Picture "@E 99,999" 
    @ nLin,026 PSAY (cAliastmp3)->M5F  Picture "@E 99,999" 
    @ nLin,036 PSAY (cAliastmp3)->M4F  Picture "@E 99,999"
    @ nLin,046 PSAY (cAliastmp3)->M3F  Picture "@E 99,999"
    @ nLin,056 PSAY (cAliastmp3)->M2F  Picture "@E 99,999"
    @ nLin,066 PSAY (cAliastmp3)->M1F  Picture "@E 99,999"
    @ nLin,076 PSAY (cAliastmp3)->M0F  Picture "@E 99,999"

      nlin++         
      If nLin > 55 // Salto de Página. Neste caso o formulario tem 55 linhas...
	     nLin :=	Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
	     nLin ++
      Endif      
                
// regras de comissao para a empresa X vendedor       
      (cAliastmp4)->(dbGoTop())   
      
 //	@ nLin,001 PSAY ctraco80
    @ nLin,001 PSAY "                           Regra(s) do(s) Vendedor(es) da empresa "      
    nlin++        
    @ nLin,001 PSAY "Vendedor(es) "       
    @ nLin,036 PSAY "Parcelas "  
	 @ nLin,055 PSAY "% " 
	 @ nLin,065 PSAY "Qtda Vidas " 
	 @ nLin,077 PSAY "Inc"
	  nlin++          
    @ nLin,001 PSAY ctraco80
      nlin++                   
      (cAliastmp4)->(dbGoTop())  
     While (cAliastmp4)->(!EOF())     
           @ nLin,002 PSAY substr((cAliastmp4)->NOMVend ,1,30)  
           @ nLin,037 PSAY (cAliastmp4)->Parcel
           @ nLin,055 PSAY (cAliastmp4)->percom    
           @ nLin,070 PSAY (cAliastmp4)->qtda   
        if mv_par07 == 2   
           @ nLin,077 PSAY '*'            
           @ nLin,078 PSAY (cAliastmp4)->tipinc 
        Endif 
           If (cAliastmp4)->perc  > 10  .and. lflagMM == .F.       
              lflagMM      := .T.
           EndIF  
             nlin++                                    
           If nLin > 55 // Salto de Página. Neste caso o formulario tem 55 linhas...
	         nLin :=	Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
	         nLin ++
	      Endif
      	  (cAliastmp4)->(dbSkip())                     
    EndDo       
   
   	// Autorizações        

	@ nLin,001 PSAY ctraco80         
	
/////////////////////////////////////////////////
// conferencia de cobranca retoativa X matriculas não cobradas 
    (cAliastmp5)->(dbGoTop())   
 IF (cAliastmp5)->(!EOF())      
 	@ nLin,001 PSAY ctraco80
      nlin++                  
    @ nLin,028 PSAY "Mensalidades Retroativas"        
      nlin++                                  
    @ nLin,005 PSAY "Compet. Incl"       
    @ nLin,020 PSAY "Qtda C/Com"   
    @ nLin,036 PSAY "Qtda S/Com"  
	@ nLin,055 PSAY "Compet. Cob "
    @ nLin,069 PSAY "Qtda Cobrada"   

      nlin++                   
    While (cAliastmp5)->(!EOF())     
          @ nLin,007 PSAY substr((cAliastmp5)->datinc,5,2)+"/"+substr((cAliastmp5)->datinc,1,4)  
          @ nLin,024 PSAY (cAliastmp5)->IncE  
          @ nLin,040 PSAY (cAliastmp5)->Incf
          @ nLin,058 PSAY (cAliastmp5)->comp
          @ nLin,075 PSAY (cAliastmp5)->qtda
           nlin++
          If nLin > 55 // Salto de Página. Neste caso o formulario tem 55 linhas...
	         nLin :=	Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
	         nLin ++
	      Endif    	
	      (cAliastmp5)->(dbSkip())                     
    EndDo       
   @ nLin,001 PSAY ctraco80

 EndIf  
/////////////////////////////////////////////////
// Conferencia qtda de vidas cobradas X vidas em comisao      
      (cAliastmp7)->(dbGoTop())   
      (cAliastmp)->(dbGoTop())
      nlin++                  
    @ nLin,028 PSAY "Qtde de vidas faturas X Comisionadas "        
      nlin++                                        
//	@ nLin,001 PSAY ctraco80
 //     nlin++        
    @ nLin,001 PSAY "Empresa Faturadas "       
    @ nLin,056 PSAY "Qtda Fat "  
    @ nLin,070 PSAY "Qtda Com "  
	  nlin++          
    @ nLin,001 PSAY ctraco80
      nlin++                   
      (cAliastmp7)->(dbGoTop())  
     While (cAliastmp7)->(!EOF())     
           @ nLin,003 PSAY (cAliastmp7)->bm1codemp + " - " + substr((cAliastmp)->Cliente,1,40)    
           @ nLin,056 PSAY (cAliastmp7)->bm1qtda Picture "@E 99,999" 
           @ nLin,070 PSAY (cAliastmp7)->bxqqtda Picture "@E 99,999"     
             nlin++                                    
           If nLin > 55 // Salto de Página. Neste caso o formulario tem 55 linhas...
	         nLin :=	Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
	         nLin ++
	      Endif
      	  (cAliastmp7)->(dbSkip())                     
    EndDo                  
    if mv_par07 == 2   
       @ nLin,001 PSAY ctraco80
         nlin++        
       @ nLin,001 PSAY "* ADS - Adesaõa , Dep - Dependente , PN - Plano Novo , Trf - Transferencia"       
	     nlin++          
	EndIf      
/////////////////////////////////////////////////
// Conferencia qtda de vidas cobradas X vidas em comisao      
 IF (cAliastmp8)->(!EOF())  
      (cAliastmp8)->(dbGoTop())         
      
 	@ nLin,001 PSAY ctraco80
      nlin++        
    @ nLin,001 PSAY "Matricula(s) com comissão sem Faturadas "       
	  nlin++          
    @ nLin,001 PSAY ctraco80
      nlin++                   
     While (cAliastmp8)->(!EOF())     
           @ nLin,001 PSAY (cAliastmp8)->bxq_codint + "." +(cAliastmp8)->bxq_codemp+ "." +(cAliastmp8)->bxq_matric + "-" +(cAliastmp8)->bxq_tipreg              
             (cAliastmp8)->(dbSkip())
             
             if (cAliastmp8)->(!EOF())
                @ nLin,025 PSAY (cAliastmp8)->bxq_codint + "." +(cAliastmp8)->bxq_codemp+ "." +(cAliastmp8)->bxq_matric + "-" +(cAliastmp8)->bxq_tipreg  
                (cAliastmp8)->(dbSkip())
                
                If (cAliastmp8)->(!EOF())
                    @ nLin,050 PSAY (cAliastmp8)->bxq_codint + "." +(cAliastmp8)->bxq_codemp+ "." +(cAliastmp8)->bxq_matric + "-" +(cAliastmp8)->bxq_tipreg                                
                    
                EndIf 
                
             EndIf
                  
             nlin++                                    
           If nLin > 55 // Salto de Página. Neste caso o formulario tem 55 linhas...
	         nLin :=	Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
	         nLin ++
	      Endif
      	  (cAliastmp8)->(dbSkip())                     
    EndDo    
EndIf     	
/////////////////////////////////////////////////////////////////
/*
  
    (cAliastm10)->(dbGoTop())          
    (cAliastm11)->(dbGoTop())         
      
 	@ nLin,001 PSAY ctraco80
      nlin++        
    @ nLin,001 PSAY "             Sinistralidade e Despesas de Comissões - No Ano"       
	  nlin++          
    @ nLin,001 PSAY ctraco80
      nlin++        
    @ nLin,001 PSAY "Total Receita    Total Custo     Sinistralidade       Total de Comissões Pagas"       
//                   123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890     
//                            1         2         3         4         5         6         7         8
 //	  nlin++          
 //   @ nLin,001 PSAY ctraco80 
      nlin++                
          
      nVlrCom    := 0.00 
      nVlrTit    := 0.00
    
     While (cAliastm10)->(!EOF())     
     
        nVlrCom    := nVlrCom+(cAliastm10)->VlrCom 
        nVlrTit    := nVlrTit+(cAliastm10)->VlrTit
        
        (cAliastm10)->(dbSkip())                     
     EndDo    
     
     @ nLin,001 PSAY (cAliastm11)->RECEITA_A Picture "@E 99,999,999.99"
     @ nLin,016 PSAY (cAliastm11)->CUSTO_A   Picture "@E 99,999,999.99"
     @ nLin,035 PSAY (cAliastm11)->SINIST_A  Picture "@E 99,999.99" +'%' 
     @ nLin,061 PSAY nVlrCom Picture "@E 99,999,999.99"

	  nlin++        
    @ nLin,001 PSAY ctraco80
      nlin++
      
      If nLin > 55 // Salto de Página. Neste caso o formulario tem 55 linhas...
	     nLin :=	Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
	     nLin ++
	  Endif        	                                  
	  
*/	  
	  
///////////////////////////////////////////////////// continua alki
   @ nLin,001 PSAY "              Distribuiçao da Comissões Entre Saúde e Odontologico "       
	  nlin++          
    @ nLin,001 PSAY ctraco80
      nlin++        
    @ nLin,001 PSAY "Empresa              Vendedor             Tp Opera  Vlr Base     Vlr Com    Qtda"       
//                   123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890     
//                            1         2         3         4         5         6         7         8
 //	  nlin++          
 //   @ nLin,001 PSAY ctraco80 
      nlin++                

      nVlrCom    := 0.00 
      nVlrTit    := 0.00

     While (cAliastm14)->(!EOF())     
    
     @ nLin,001 PSAY (cAliastm14)->nomemp 
     @ nLin,023 PSAY (cAliastm14)->nomven 
     @ nLin,044 PSAY (cAliastm14)->tpope   
     @ nLin,052 PSAY (cAliastm14)->VlrTit  Picture "@E 999,999.99"
     @ nLin,064 PSAY (cAliastm14)->VlrCom  Picture "@E 999,999.99"
     @ nLin,076 PSAY (cAliastm14)->qtda    Picture "@E 99,999"

	  nlin++
    
     If nLin > 55 // Salto de Página. Neste caso o formulario tem 55 linhas...
	    nLin :=	Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
	    nLin ++
	  Endif
	  
    (cAliastm14)->(dbSkip())   
    
      EndDo    	                                    
	           
    @ nLin,001 PSAY ctraco80
      nlin++       
/////////////
/*
   @ nLin,001 PSAY "       Sinistralidade e Despesas de Comissões - Na validade Contrato "       
	  nlin++          
    @ nLin,001 PSAY ctraco80
      nlin++        
    @ nLin,001 PSAY "Total Receita    Total Custo     Sinistralidade       Total de Comissões Pagas"       
//                   123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890     
//                            1         2         3         4         5         6         7         8
 //	  nlin++          
 //   @ nLin,001 PSAY ctraco80 
      nlin++                

      nVlrCom    := 0.00 
      nVlrTit    := 0.00

     While (cAliastm12)->(!EOF())     
     
        nVlrCom    := nVlrCom+(cAliastm12)->VlrCom 
        nVlrTit    := nVlrTit+(cAliastm12)->VlrTit
        
        (cAliastm12)->(dbSkip())                     
     EndDo    	  

     
     @ nLin,001 PSAY (cAliastm11)->RECEITA_B Picture "@E 99,999,999.99"
     @ nLin,016 PSAY (cAliastm11)->CUSTO_B   Picture "@E 99,999,999.99"
     @ nLin,035 PSAY (cAliastm11)->SINIST_B  Picture "@E 99,999.99" +'%' 
     @ nLin,061 PSAY nVlrCom Picture "@E 99,999,999.99"

	  nlin++          	  
*/
/////////////////////////////////////////////////	
// conferencia á existencia de titulos a receber ligados ao titulo de comissao 
    (cAliastmp6)->(dbGoTop())  
     
    
 IF (cAliastmp6)->(!EOF())      
		@ nLin,001 PSAY ctraco80         
         nlin++     
     	@ nLin,026 PSAY "* * *  A T E N T Ç Ã O * * * "
         nlin++     
     	@ nLin,002 PSAY "Há Titulos á Receber abaixo com SALDO e fazem para da base desta comissão "
         nlin++        	                                                                             
         
    	@ nLin,001 PSAY ctraco80		
        nlin++                  
        @ nLin,001 PSAY "Nome Cliente"              
        @ nLin,040 PSAY "Titulo"       
        @ nLin,055 PSAY "Vencto"   
        @ nLin,074 PSAY "Saldo"    
        nlin++                           
    	@ nLin,001 PSAY ctraco80		
        nlin++                   
    While (cAliastmp6)->(!EOF())     
          @ nLin,001 PSAY substr((cAliastmp6)->nomcli,1,38)  
          @ nLin,040 PSAY (cAliastmp6)->tit  
          @ nLin,055 PSAY (cAliastmp6)->vencto
          @ nLin,068 PSAY (cAliastmp6)->saldo  Picture "@E 99,999,999.99"
          nlin++
           If nLin > 55 // Salto de Página. Neste caso o formulario tem 55 linhas...
	         nLin :=	Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
	         nLin ++
	      Endif
    	  (cAliastmp6)->(dbSkip())                     
    EndDo      
 EndIf    
   @ nLin,001 PSAY ctraco80
/////////////////////////////////////////////////
// Mensagem de critica de matricula ja incluida em outra data 
/*
 If nLMatRep == 1 //.and. lflagMM == .T.  	
   (cAliastmp9)->(dbGoTop())   
    
   IF (cAliastmp9)->qtda > 0     
		@ nLin,001 PSAY ctraco80         
         nlin++     
     	@ nLin,026 PSAY "* * *  A T E N T Ç Ã O * * * "
         nlin++     
     	@ nLin,002 PSAY "Há Usuario(s) com matr(s) anterior(es) Ate 180 dias de cadastro , bloqueda(s)"
         nlin++        	                                                            
       	@ nLin,002 PSAY "Como Matr. novas nesta competencia , Possibilitando o pagar novo Agenciamento"               
         nlin++        	                                                                       
    	@ nLin,001 PSAY ctraco80		
        nlin++  
   EndIf
                             
EndIf    
*/
/////////////////////////////////////////////////
// Autorizações        	
      nlin++              
      nlin++  
    @ nLin,028 PSAY " A U T O R I Z A Ç Õ E S "  
	  nlin++          
      nlin++            
    @ nLin,015 PSAY "G E R E M "  
    @ nLin,035 PSAY "D I C O M "  
    @ nLin,055 PSAY "D I E G E "  
	  nlin++          
      nlin++            
      nlin++            
    @ nLin,013 PSAY "_____________"  
    @ nLin,033 PSAY "_____________"
    @ nLin,053 PSAY "_____________"  

/////////////////////////////////////////////////
// Listagem de critica de matricula ja incluida em outra data 
//       
/*
 If nLMatRep == 1 .and. (cAliastmp9)->qtda > 0    

    Titulo := "Matr Possib. de dupl. pagto Agenciamento "    
    Tamanho:= "G"          

//    u_cabr228(cEmpInc ,cEmpFim,canomes,canomes)
    
 EndIf 
*/
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

aAdd(aRegs,{cPerg,"01","Mes/Ano Comissao       ?","","","mv_ch1","C",07,0,0,"G","","mv_par01","","","","","","","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "99/9999", "" })
aAdd(aRegs,{cPerg,"02","Cod Empresa De         ?","","","mv_ch2","C",04,0,0,"G","","mv_par02","","","","","","","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "", "" })
aAdd(aRegs,{cPerg,"03","Cod Empresa Ate        ?","","","mv_ch3","C",04,0,0,"G","","mv_par03","","","","","","","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "", "" })
aAdd(aRegs,{cPerg,"04","Vendedor De            ?","","","mv_ch4","C",06,0,0,"G","","mv_par04","","","","","","","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "", "" })
aAdd(aRegs,{cPerg,"05","Vendedor Ate           ?","","","mv_ch5","C",06,0,0,"G","","mv_par05","","","","","","","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "", "" })
aadd(aRegs,{cPerg,"06","Matric. Incl. Anterior ?","","","mv_ch6","N", 1,0,0,"C","","mv_par06","Sim","","","","","Nao","","","","","","","","","","","","","","","","","" , "" ,""  , "", "", "" })
aadd(aRegs,{cPerg,"07","Regras de Comissoa     ?","","","mv_ch7","N", 1,0,0,"C","","mv_par07","Sintetica","","","","","Analitica","","","","","","","","","","","","","","","","","" , "" ,""  , "", "", "" })

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

Static Function  CalComp(id)
 
 local Ret :=  ' ' 
 local cMesAI:= 0
 local cAnoAI:= 0 
 local cMesAF:= 0
 local cAnoAF:= 0
 
If cmes== 01
   cMesAI:= 12
   cAnoAI:= (cano-1)
Else                  
   cMesAI:= (cmes-1)
   cAnoAI:=  cano
EndIf 
  
  cMesAF:= IIf ((cMesAI+1)== 13 , 01, (cMesAI+1))

  If cMesAF != 01
     cAnoAF:= (cAnoAI-1)  
  Else                  
     cAnoAF:= cAnoAI 
  EndIf                  

If id == 1 
   Ret:= strzero(cAnoAI,4)+strzero(cMesAI,2)                   
Else                                                               
   Ret:= strzero(cAnoAf,4)+strzero(cMesAF,2)                   
EndIf   

Return(Ret)
           
           
///////////////////////////////////////
Static Function  CalCompA(id)
 
 local Ret :=  ' ' 
 local cMesAI:= 0
 local cAnoAI:= 0 
 local cMesAF:= 0
 local cAnoAF:= 0
 
If cmes== 01
   cMesAI:= 12  
   cAnoAI:= (cano-1)
Else                  
   cMesAI:= (cmes-1)
   cAnoAI:=  cano
EndIf           
   cMesAF:= 01       
   cAnoAF:= cAnoAI 

If id == 1 
   Ret:= strzero(cAnoAI,4)+strzero(cMesAI,2)                   
Else                                                               
   Ret:= strzero(cAnoAf,4)+strzero(cMesAF,2)                   
EndIf   

Return(Ret)                

Static Function  CalCompB(id) 
 
 local Ret :=  ' ' 
 local cMesAI:= 0
 local cAnoAI:= 0 
 local cMesAF:= 0
 local cAnoAF:= 0  
 local cmes := 0
 local cano := 0
 

cquery13 := CRLF+"  SELECT TO_DATE(TRIM(BQC_VALID),'YYYYMMDD') DatInc "
cquery13 += CRLF+"    FROM "+ RetSqlName("BQC") + " BQC "
cquery13 += CRLF+"   WHERE  BQC_FILIAL = '"+xFilial('BQC')+ "'"                           

cquery13 += CRLF+"     AND  trim(BQC_CODEMP)>= '"+cEmpInc +"' AND trim(BQC_CODEMP)<= '"+cEmpFim+"' "                    

If cEmpAnt == '01'
   cquery13 += CRLF+"     AND  EMPRESA_ATIVA('C',BQC_CODEMP) = 1 "
Else                                                             
   cquery13 += CRLF+"     AND  EMPRESA_ATIVA('I',BQC_CODEMP) = 1 "
EndIf    

cquery13 += CRLF+"     AND  TO_DATE(TRIM(BQC_VALID),'YYYYMMDD') - TRUNC(SYSDATE) BETWEEN 0 AND 366 "
cquery13 += CRLF+"     AND  BQC_DATBLO = ' ' "
cquery13 += CRLF+"     AND  BQC.D_E_L_E_T_ = ' '  "
cquery13 += CRLF+"     AND  BQC_NUMCON||BQC_SUBCON = "
cquery13 += CRLF+"         (SELECT min(BQC_NUMCON||BQC_SUBCON) "
cquery13 += CRLF+"            FROM   "+ RetSqlName("BQC") + " BQC "
cquery13 += CRLF+"           WHERE  BQC_FILIAL = '"+xFilial('BQC')+ "'"

cquery13 += CRLF+"     AND  trim(BQC_CODEMP)>= '"+cEmpInc +"' AND trim(BQC_CODEMP)<= '"+cEmpFim+"' "                    

If cEmpAnt == '01'
   cquery13 += CRLF+"             AND    EMPRESA_ATIVA('C',BQC_CODEMP) = 1 "
   cquery13 += CRLF+"             and TOTAL_CARTEIRA_CONT_SUBCON('C',ADD_MONTHS(TRUNC(SYSDATE,'MM'),-1),NULL,NULL,BQC_CODEMP,BQC_NUMCON,BQC_SUBCON) > 0 "
Else                                                                      
   cquery13 += CRLF+"             AND    EMPRESA_ATIVA('I',BQC_CODEMP) = 1 "
   cquery13 += CRLF+"             and TOTAL_CARTEIRA_CONT_SUBCON('I',ADD_MONTHS(TRUNC(SYSDATE,'MM'),-1),NULL,NULL,BQC_CODEMP,BQC_NUMCON,BQC_SUBCON) > 0 "
EndIf 

cquery13 += CRLF+"             AND    TO_DATE(TRIM(BQC_VALID),'YYYYMMDD') - TRUNC(SYSDATE) BETWEEN 0 AND 366 "
cquery13 += CRLF+"             AND    BQC_DATBLO = ' ' AND    BQC.D_E_L_E_T_ = ' ') "

If Select((cAliastm13)) <> 0 
   (cAliastm13)->(DbCloseArea())  
Endif 

TCQuery cQuery13  New Alias (cAliastm13) 

(cAliastm13)->(dbGoTop())                                          

cmes:= val(substr(dtos((cAliastm13)->DatInc),5,2))
                                                     
cano:= val(substr(dtos((cAliastm13)->DatInc),1,4))
If cmes== 01
   cMesAI:= 12  
   cAnoAI:= (cano-1)
Else                  
   cMesAI:= (cmes)
   cAnoAI:=  cano
EndIf           
   cMesAF:= (cMesAI+1)       
   cAnoAF:= (cAnoAI-1) 

If id == 1 
   Ret:= strzero(cAnoAI,4)+strzero(cMesAI,2)                   
Else                                                               
   Ret:= strzero(cAnoAf,4)+strzero(cMesAF,2)                   
EndIf   

Return(Ret)                



