#INCLUDE "PROTHEUS.CH"
#Include "TOPCONN.CH"
                             
/*/                                                                                      
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±…ÕÕÕÕÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÀÕÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÀÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÕª±±
±±∫Programa  ≥CABR223  ∫ Autor ≥Altamiro               ∫ Data ≥ 31/08/16  ∫±±
±±ÃÕÕÕÕÕÕÕÕÕÕÿÕÕÕÕÕÕÕÕÕÕ ÕÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕ ÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕπ±±
±±∫Descricao ≥Rotina p/ CONFERENCIA da previa X custo e suas fase X glosas∫±±
±±∫          ≥                                                            ∫±±
±±»ÕÕÕÕÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕº±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
/*/                  

User Function CABR223()

Local   nCont		:= 0    
Local   cMsg		:= ""
Private cDpj        := 'N„o'   
private cImp        := 'N„o'
Private oLeTxt
Private lAbortPrint :=.F.
Private cPerg       := "CABR223"
Private cTitulo     := "previa X custo e suas fase X glosas"
Private lpvez       :=.T.   
Private cTpCrit     :=" "  
Private lImporta    := .F.  
Private f_ok        := .F.
Private nLocaliz    := 0 // 1 - zzq -- 2 se2  -- 0 nao localizado         

private cpgto       := ' '    

private cTitCSald   := ' '   
PRIVATE nVlrTitPri  := 0.00
PRIVATE nVlrTitcmp  := 0.00   
private cNomeArq1   := ' '      
private i           := 1                     
 
 AjustaSX1(cPerg)

cCompMes    := SUBSTR(mv_par01,1,2) 
cCompAno    := SUBSTR(mv_par01,4,4)  
dDatproi    := dtos(mv_par02) 
dDatprof    := dtos(mv_par03)     

  
  
Processa({||Processa1()}, cTitulo, "", .T.)   

/*  If tmp1->QTDPROC == 0 .and.  nListar == 2 
     FGrvPlan() 
  EndIf  */
//⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø
//≥ Libera impressao                                                         ≥
//¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ


MsgInfo("Processo finalizado")

Return                 

**************************************************************************

/*/
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±…ÕÕÕÕÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÀÕÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÀÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÕÕÕª±±
±±∫FunáÑo    ≥ PROCESSA1∫ Autor ≥ Jean Schulz        ∫ Data ≥  11/11/06   ∫±±
±±ÃÕÕÕÕÕÕÕÕÕÕÿÕÕÕÕÕÕÕÕÕÕ ÕÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕ ÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕÕÕπ±±
±±∫DescriáÑo ≥ Funcao auxiliar chamada pela PROCESSA.  A funcao PROCESSA  ∫±±
±±∫          ≥ monta a janela com a regua de processamento.               ∫±±
±±ÃÕÕÕÕÕÕÕÕÕÕÿÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕπ±±
±±∫Uso       ≥ Programa principal                                         ∫±±              
±±»ÕÕÕÕÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕº±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
/*/
Static Function Processa1()     
For i:= 1 to 4

cQuery := " SELECT nvl(TAB.GRPPAG, tabp.gruppgtp||'-'||grpdescp ) GRPPAG ,NVL (TAB.CODRDA,tabp.CODRDAP ) CODRDA , " + CRLF    
cQuery += "        nvl(SUBSTR(TAB.NOME,1,40),SUBSTR(TABP.NOMRDAP,1,40)) NOME , " + CRLF  
cQuery += "        nvl(TAB.TPESSOA,' ') TPESSOA ,  " + CRLF  
                                                                       
cQuery += "       (SUM (DECODE (TAB.SEQ, '1', TAB.VALOR_LOTE, 0.00)) + " + CRLF  
cQuery += "        SUM (DECODE (TAB.SEQ, '2', TAB.VALOR_LOTE, 0.00)) + " + CRLF  
cQuery += "        SUM (DECODE (TAB.SEQ, '3', TAB.VALOR_LOTE, 0.00)) + " + CRLF  
cQuery += "        SUM (DECODE (TAB.SEQ, '4', TAB.VALOR_LOTE, 0.00)) + " + CRLF  
cQuery += "        SUM (DECODE (TAB.SEQ, '6', TAB.VALOR_LOTE, 0.00)) + " + CRLF  
cQuery += "        SUM (DECODE (TAB.SEQ, '7', TAB.VALOR_LOTE, 0.00))) Analisado_TOT , " + CRLF  
                                                                        
cQuery += "       (SUM (DECODE (TAB.SEQ, '12', TAB.VALOR_LOTE, 0.00)) + " + CRLF  
cQuery += "        SUM (DECODE (TAB.SEQ,  '2', TAB.VALOR_LOTE, 0.00)) + " + CRLF  
cQuery += "        SUM (DECODE (TAB.SEQ,  '3', TAB.VALOR_LOTE, 0.00)) + " + CRLF  
cQuery += "        SUM (DECODE (TAB.SEQ,  '4', TAB.VALOR_LOTE, 0.00)) + " + CRLF  
cQuery += "        SUM (DECODE (TAB.SEQ,  '6', TAB.VALOR_LOTE, 0.00)) + " + CRLF  
cQuery += "        SUM (DECODE (TAB.SEQ,  '7', TAB.VALOR_LOTE, 0.00))) Analisado_COMP , " + CRLF  

cQuery += "       (SUM (DECODE (TAB.SEQ, '1', TAB.VALOR_LOTE, 0.00))  + " + CRLF  
cQuery += "        SUM (DECODE (TAB.SEQ, '2', TAB.VALOR_LOTE, 0.00))  + " + CRLF  
cQuery += "        SUM (DECODE (TAB.SEQ, '3', TAB.VALOR_LOTE, 0.00))  + " + CRLF  
cQuery += "        SUM (DECODE (TAB.SEQ, '4', TAB.VALOR_LOTE, 0.00))  + " + CRLF  
cQuery += "        SUM (DECODE (TAB.SEQ, '6', TAB.VALOR_LOTE, 0.00))  + " + CRLF  
cQuery += "        SUM (DECODE (TAB.SEQ, '7', TAB.VALOR_LOTE, 0.00))) + " + CRLF  
cQuery += "       (SUM (DECODE (TAB.SEQ, '1', TAB.VALOR_GLOSA, 0.00)) + " + CRLF  
cQuery += "        SUM (DECODE (TAB.SEQ, '2', TAB.VALOR_GLOSA, 0.00)) + " + CRLF        
cQuery += "        SUM (DECODE (TAB.SEQ, '3', TAB.VALOR_GLOSA, 0.00)) + " + CRLF  
cQuery += "        SUM (DECODE (TAB.SEQ, '4', TAB.VALOR_GLOSA, 0.00))) analTOT_glo , " + CRLF  

cQuery += "       (SUM (DECODE (TAB.SEQ, '1', TAB.VALOR_GLOSA, 0.00))  + " + CRLF  
cQuery += "        SUM (DECODE (TAB.SEQ, '2', TAB.VALOR_GLOSA, 0.00))  + " + CRLF        
cQuery += "        SUM (DECODE (TAB.SEQ, '3', TAB.VALOR_GLOSA, 0.00))  + " + CRLF  
cQuery += "        SUM (DECODE (TAB.SEQ, '4', TAB.VALOR_GLOSA, 0.00))) VLRGLOS , " + CRLF    
   
cQuery += "        nvl(TABP.VLRTOT,0.00)  PREV_TPOTA ,  " + CRLF   

cQuery += "        SUM (DECODE (TAB.SEQ, '1', TAB.VALOR_LOTE, 0.00)) FATURADA ,  " + CRLF  
cQuery += "        SUM (DECODE (TAB.SEQ, '12',TAB.VALOR_LOTE, 0.00)) FATCOMP  ,  " + CRLF  
cQuery += "        SUM (DECODE (TAB.SEQ, '2', TAB.VALOR_LOTE, 0.00)) ATVPRT35 ,  " + CRLF  
cQuery += "        SUM (DECODE (TAB.SEQ, '3', TAB.VALOR_LOTE, 0.00)) ATVPRONT ,  " + CRLF  
cQuery += "        SUM (DECODE (TAB.SEQ, '4', TAB.VALOR_LOTE, 0.00)) CONFEREN ,  " + CRLF  
cQuery += "        SUM (DECODE (TAB.SEQ, '6', TAB.VALOR_LOTE, 0.00)) DBCRENFA ,  " + CRLF  
cQuery += "        SUM (DECODE (TAB.SEQ, '7', TAB.VALOR_LOTE, 0.00)) DBCREFAT    " + CRLF  
 
cQuery += "   FROM (  " + CRLF  
cQuery += "         SELECT '1' SEQ ,'faturada ' TIPO , BAU_GRPPAG||' - ' || b16_descri  GRPPAG ,bau_CODIGO ||' - ' || BAU_NOME  NOME, BAU_CODIGO CODRDA ,  " + CRLF  
cQuery += "                DECODE(TRIM(BAU_CODRET),'1708','P_JURIDICA','0588','P_FISICA','Nao Especificado') Tpessoa , SUM (BD7_VLRPAG) VALOR_LOTE ,count(*) qtda ,  " + CRLF  
cQuery += "                BD7_CODPEG PEG , BD7_CODLDP LOCDIG  , NVL(ZN_CODANA,' ') CODANA , NVL(ZN_NOMANA,' ') NOMANA , SUM (BD7_VLRGLO) VALOR_GLOSA ,  " + CRLF  
cQuery += "                CASE WHEN bd7_codemp = '0024' THEN 'Prefeitura'  " + CRLF  
cQuery += "                     WHEN bd7_codemp = '0025' THEN 'Prefeitura'  " + CRLF  
cQuery += "                     WHEN bd7_codemp = '0026' THEN 'Prefeitura'  " + CRLF  
cQuery += "                     WHEN bd7_codemp = '0027' THEN 'Prefeitura'  " + CRLF  
cQuery += "                     WHEN bd7_codemp = '0028' THEN 'Prefeitura'  " + CRLF  
cQuery += "                     Else 'Rede'  " + CRLF  
cQuery += "                 End empresa  " + CRLF  
cQuery += "            FROM "+RetSqlName('BD7')+ " BD7 ,"+RetSqlName('BAU')+ " BAU , "+RetSqlName('B16')+ " B16  , "+RetSqlName('SZN')+ " SZN " + CRLF
cQuery += "           WHERE BD7_FILIAL = '  ' AND BD7.D_E_L_E_T_ = ' ' AND BD7_FASE = '4' AND BD7.BD7_SITUAC = '1' AND BD7.BD7_CODEMP <>'9999'  " + CRLF  
cQuery += "             AND BD7.BD7_MESPAG >= '01' AND BD7.BD7_ANOPAG >= '2001'  " + CRLF  
cQuery += "             AND BD7_NUMLOT >= '"+cCompAno+cCompMes+"0001' AND BD7_NUMLOT <= '"+cCompAno+cCompMes+"9999'  " + CRLF  
cQuery += "             AND BD7_DATPRO >= '"+dDatproi+"' AND BD7_DATPRO <= '"+dDatprof+"'  " + CRLF  
cQuery += "             AND ( BD7.BD7_CONPAG = '1' OR BD7.BD7_CONPAG = ' ') AND BD7.BD7_LOTBLO = ' ' AND BD7.BD7_BLOPAG <> '1'  " + CRLF  
cQuery += "             AND BD7_YFAS35 = 'T' AND BAU_FILIAL = '  ' AND BAU.D_E_L_E_T_ = ' ' AND B16_FILIAL = '  ' AND B16.D_E_L_E_T_ = ' '  " + CRLF  
cQuery += "             AND bau_grppag = b16_codigo AND BD7_CODRDA  = BAU_CODIGO AND BD7_VLRPAG > 0  " + CRLF  
cQuery += "             AND ZN_FILIAL(+) = '  ' AND SZN.D_E_L_E_T_(+) = ' ' AND BAU_CODIGO = ZN_CODRDA(+)  " + CRLF  
cQuery += "             AND (ZN_VIGFIM(+) = ' ' OR ZN_VIGFIM(+) >= '"+cCompAno+cCompMes+"' ) " + CRLF  
cQuery += "        GROUP BY BAU_GRPPAG, b16_descri , BAU_CODIGO ,  BAU_NOME, BAU_CODRET , BD7_CODPEG, BD7_CODLDP  , ZN_CODANA , ZN_NOMANA , bd7_codemp  " + CRLF  
cQuery += " UNION ALL "
cQuery += "          SELECT '12' SEQ ,'faturada ' TIPO , BAU_GRPPAG||' - ' || b16_descri  GRPPAG ,bau_CODIGO ||' - ' || BAU_NOME  NOME, BAU_CODIGO CODRDA ,  " + CRLF  
cQuery += "                 DECODE(TRIM(BAU_CODRET),'1708','P_JURIDICA','0588','P_FISICA','Nao Especificado') Tpessoa , SUM (BD7_VLRPAG) VALOR_LOTE ,count(*) qtda ,  " + CRLF  
cQuery += "                 BD7_CODPEG PEG , BD7_CODLDP LOCDIG  , NVL(ZN_CODANA,' ') CODANA , NVL(ZN_NOMANA,' ') NOMANA , SUM (BD7_VLRGLO) VALOR_GLOSA ,  " + CRLF  
cQuery += "                 CASE WHEN bd7_codemp = '0024' THEN 'Prefeitura'  " + CRLF  
cQuery += "                      WHEN bd7_codemp = '0025' THEN 'Prefeitura'  " + CRLF  
cQuery += "                      WHEN bd7_codemp = '0026' THEN 'Prefeitura'  " + CRLF  
cQuery += "                      WHEN bd7_codemp = '0027' THEN 'Prefeitura'  " + CRLF  
cQuery += "                      WHEN bd7_codemp = '0028' THEN 'Prefeitura' " + CRLF
cQuery += "                      Else 'Rede' " + CRLF
cQuery += "                  End empresa " + CRLF                          
cQuery += "            FROM "+RetSqlName('BD7')+ " BD7 ,"+RetSqlName('BAU')+ " BAU , "+RetSqlName('B16')+ " B16  , "+RetSqlName('SZN')+ " SZN " + CRLF
cQuery += "           WHERE BD7_FILIAL = '  ' " + CRLF
cQuery += "             AND BD7.D_E_L_E_T_ = ' ' AND BD7_FASE = '4' AND BD7.BD7_SITUAC = '1' AND BD7.BD7_CODEMP <>'9999' " + CRLF

cQuery += "             AND BD7.BD7_MESPAG = '"+cCompMes+"' AND BD7.BD7_ANOPAG = '"+cCompAno+"' " + CRLF
cQuery += "             AND substr (BD7_NUMLOT,1,6) like  ('"+cCompAno+cCompMes+"%') " + CRLF
cQuery += "             AND BD7_DATPRO >= '"+dDatproi+"' AND BD7_DATPRO <= '"+dDatprof+"' " + CRLF

cQuery += "             AND ( BD7.BD7_CONPAG = '1' OR BD7.BD7_CONPAG = ' ') AND BD7.BD7_LOTBLO = ' ' AND BD7.BD7_BLOPAG <> '1' " + CRLF
cQuery += "             AND BD7_YFAS35 = 'T' AND BAU_FILIAL = '  ' AND BAU.D_E_L_E_T_ = ' ' AND B16_FILIAL = '  ' AND B16.D_E_L_E_T_ = ' ' " + CRLF
cQuery += "             AND bau_grppag = b16_codigo AND BD7_CODRDA  = BAU_CODIGO AND BD7_VLRPAG > 0 " + CRLF
cQuery += "             AND ZN_FILIAL(+) = '  ' AND SZN.D_E_L_E_T_(+) = ' ' AND BAU_CODIGO = ZN_CODRDA(+) " + CRLF

cQuery += "             AND (ZN_VIGFIM(+) = ' ' OR ZN_VIGFIM(+) >= '"+cCompAno+cCompMes+"' )" + CRLF

cQuery += "        GROUP BY BAU_GRPPAG, b16_descri , BAU_CODIGO ,  BAU_NOME, BAU_CODRET , BD7_CODPEG, BD7_CODLDP  , ZN_CODANA , ZN_NOMANA , bd7_codemp " + CRLF
cQuery += " UNION ALL " + CRLF
cQuery += "          SELECT '2' SEQ ,'Pronta_Conferida '  TIPO ,BAU_GRPPAG||' - ' || B16_DESCRI GRPPAG ,BAU_CODIGO ||' - ' || BAU_NOME  NOME, BAU_CODIGO CODRDA , " + CRLF
cQuery += "                 DECODE(TRIM(BAU_CODRET),'1708','P_JURIDICA','0588','P_FISICA','Nao Especificado') TPESSOA ,SUM (BD7_VLRPAG) VALOR_LOTE  ,count(*) qtda , " + CRLF
cQuery += "                 BD7_CODPEG PEG , BD7_CODLDP LOCDIG  , NVL(ZN_CODANA,' ') CODANA , NVL(ZN_NOMANA,' ') NOMANA , SUM (BD7_VLRGLO) VALOR_GLOSA , " + CRLF
cQuery += "                 CASE WHEN bd7_codemp = '0024' THEN 'Prefeitura' " + CRLF
cQuery += "                      WHEN bd7_codemp = '0025' THEN 'Prefeitura' " + CRLF
cQuery += "                      WHEN bd7_codemp = '0026' THEN 'Prefeitura' " + CRLF
cQuery += "                      WHEN bd7_codemp = '0027' THEN 'Prefeitura' " + CRLF
cQuery += "                      WHEN bd7_codemp = '0028' THEN 'Prefeitura' " + CRLF
cQuery += "                      Else 'Rede' " + CRLF
cQuery += "                 End empresa " + CRLF
cQuery += "            FROM "+RetSqlName('BD7')+ " BD7 ,"+RetSqlName('BAU')+ " BAU , "+RetSqlName('B16')+ " B16  , "+RetSqlName('SZN')+ " SZN " + CRLF
cQuery += "           WHERE BD7_FILIAL = '  ' " + CRLF
cQuery += "             AND BD7.D_E_L_E_T_ = ' ' AND BD7_FASE = '3' AND BD7.BD7_SITUAC = '1' AND BD7.BD7_CODEMP <>'9999' " + CRLF 

cQuery += "             AND BD7.BD7_ANOPAG || BD7.BD7_MESPAG = '"+cCompAno+cCompMes+"' " + CRLF 
cQuery += "             AND BD7_DATPRO >= '"+dDatproi+"' AND BD7_DATPRO <= '"+dDatprof+"' " + CRLF

cQuery += "             AND ( BD7.BD7_CONPAG = '1' OR BD7.BD7_CONPAG = ' ') AND BD7.BD7_LOTBLO = ' ' AND BD7.BD7_BLOPAG <> '1' AND BD7_NUMLOT >= ' ' " + CRLF
cQuery += "             AND BD7_YFAS35 = 'T' AND BAU_FILIAL = '  ' AND BAU.D_E_L_E_T_ = ' ' AND B16_FILIAL = '  ' AND B16.D_E_L_E_T_ = ' ' " + CRLF
cQuery += "             AND bau_grppag = b16_codigo AND BD7_CODRDA  = BAU_CODIGO AND BD7_VLRPAG > 0 " + CRLF
cQuery += "             AND ZN_FILIAL(+) = '  ' AND SZN.D_E_L_E_T_(+) = ' ' AND BAU_CODIGO = ZN_CODRDA(+) " + CRLF

cQuery += "             AND (ZN_VIGFIM(+) = ' ' OR ZN_VIGFIM(+) >= '"+cCompAno+cCompMes+"' ) " + CRLF

cQuery += "        GROUP BY BAU_GRPPAG, b16_descri , BAU_CODIGO ,  BAU_NOME, BAU_CODRET , BD7_CODPEG, BD7_CODLDP , ZN_CODANA , ZN_NOMANA , bd7_codemp " + CRLF 
cQuery += " UNION ALL " + CRLF
cQuery += "          SELECT '3' SEQ , 'Pronta_Nao_Conferida_SEM_35' TIPO , BAU_GRPPAG||' - ' || b16_descri GRPPAG , Bau_CODIGO ||' - ' || BAU_NOME  NOME, BAU_CODIGO CODRDA , " + CRLF
cQuery += "                 DECODE(TRIM(BAU_CODRET),'1708','P_JURIDICA','0588','P_FISICA','Nao Especificado') Tpessoa , SUM (BD7_VLRPAG) VALOR_LOTE  ,count(*) qtda , " + CRLF
cQuery += "                 BD7_CODPEG PEG , BD7_CODLDP LOCDIG , NVL(ZN_CODANA,' ') CODANA , NVL(ZN_NOMANA,' ') NOMANA , SUM (BD7_VLRGLO) VALOR_GLOSA  , " + CRLF
cQuery += "                 CASE WHEN bd7_codemp = '0024' THEN 'Prefeitura' " + CRLF
cQuery += "                      WHEN bd7_codemp = '0025' THEN 'Prefeitura' " + CRLF
cQuery += "                      WHEN bd7_codemp = '0026' THEN 'Prefeitura' " + CRLF
cQuery += "                      WHEN bd7_codemp = '0027' THEN 'Prefeitura' " + CRLF
cQuery += "                      WHEN bd7_codemp = '0028' THEN 'Prefeitura' " + CRLF
cQuery += "                      Else 'Rede' " + CRLF
cQuery += "                  End empresa " + CRLF
cQuery += "            FROM "+RetSqlName('BD7')+ " BD7 ,"+RetSqlName('BAU')+ " BAU , "+RetSqlName('B16')+ " B16  , "+RetSqlName('SZN')+ " SZN " + CRLF
cQuery += "           WHERE BD7_FILIAL = '  ' " + CRLF
cQuery += "             AND BD7.D_E_L_E_T_ = ' ' AND BD7_FASE = '3' AND BD7.BD7_SITUAC = '1' AND BD7.BD7_CODEMP <>'9999' " + CRLF

cQuery += "             AND BD7.BD7_ANOPAG || BD7.BD7_MESPAG = '"+cCompAno+cCompMes+"' " + CRLF

cQuery += "             AND BD7_DATPRO >= '"+dDatproi+"' AND BD7_DATPRO <= '"+dDatprof+"' " + CRLF

cQuery += "             AND ( BD7.BD7_CONPAG = '1' OR BD7.BD7_CONPAG = ' ')  AND BD7.BD7_LOTBLO = ' ' AND BD7.BD7_BLOPAG <> '1' AND BD7_NUMLOT >= ' ' " + CRLF
cQuery += "             AND BD7_YFAS35 = 'F' AND BAU_FILIAL = '  ' AND BAU.D_E_L_E_T_ = ' ' AND B16_FILIAL = '  'AND B16.D_E_L_E_T_ = ' ' " + CRLF
cQuery += "             AND bau_grppag = b16_codigo AND BD7_CODRDA  = BAU_CODIGO AND BD7_VLRPAG > 0 " + CRLF 
cQuery += "             AND ZN_FILIAL(+) = '  ' AND SZN.D_E_L_E_T_(+) = ' ' AND BAU_CODIGO = ZN_CODRDA(+) " + CRLF

cQuery += "             AND (ZN_VIGFIM(+) = ' ' OR ZN_VIGFIM(+) >= '"+cCompAno+cCompMes+"' ) " + CRLF

cQuery += "        GROUP BY BAU_GRPPAG, b16_descri , BAU_CODIGO ,  BAU_NOME, BAU_CODRET , BD7_CODPEG, BD7_CODLDP , ZN_CODANA , ZN_NOMANA , bd7_codemp  " + CRLF
cQuery += " UNION ALL " + CRLF
cQuery += "          SELECT '4' SEQ , 'Em_Conferencia_FASE2' TIPO , BAU_GRPPAG||' - ' || B16_DESCRI GRPPAG ,BAU_CODIGO ||' - ' || BAU_NOME  NOME, BAU_CODIGO CODRDA , " + CRLF
cQuery += "                 DECODE(TRIM(BAU_CODRET),'1708','P_JURIDICA','0588','P_FISICA','Nao Especificado') Tpessoa , SUM (BD7_VLRPAG) VALOR_LOTE ,count(*) qtda , " + CRLF
cQuery += "                 BD7_CODPEG PEG , BD7_CODLDP LOCDIG , NVL(ZN_CODANA,' ') CODANA , NVL(ZN_NOMANA,' ') NOMANA , SUM (BD7_VLRGLO) VALOR_GLOSA , " + CRLF
cQuery += "                 CASE WHEN bd7_codemp = '0024' THEN 'Prefeitura' " + CRLF
cQuery += "                      WHEN bd7_codemp = '0025' THEN 'Prefeitura' " + CRLF
cQuery += "                      WHEN bd7_codemp = '0026' THEN 'Prefeitura' " + CRLF
cQuery += "                      WHEN bd7_codemp = '0027' THEN 'Prefeitura' " + CRLF
cQuery += "                      WHEN bd7_codemp = '0028' THEN 'Prefeitura' " + CRLF
cQuery += "                      Else 'Rede' " + CRLF
cQuery += "                 End empresa " + CRLF
cQuery += "            FROM "+RetSqlName('BD7')+ " BD7 ,"+RetSqlName('BAU')+ " BAU , "+RetSqlName('B16')+ " B16  , "+RetSqlName('SZN')+ " SZN " + CRLF
cQuery += "           WHERE BD7_FILIAL = '  ' " + CRLF
cQuery += "             AND BD7.D_E_L_E_T_ = ' ' AND BD7_FASE = '2' AND BD7.BD7_SITUAC = '1' AND BD7.BD7_CODEMP <>'9999' " + CRLF

cQuery += "             AND BD7.BD7_ANOPAG || BD7.BD7_MESPAG = '"+cCompAno+cCompMes+"' " + CRLF

cQuery += "             AND BD7_DATPRO >= '"+dDatproi+"' AND BD7_DATPRO <= '"+dDatprof+"' " + CRLF

cQuery += "             AND ( BD7.BD7_CONPAG = '1' OR BD7.BD7_CONPAG = ' ') AND BD7.BD7_LOTBLO = ' ' AND BD7.BD7_BLOPAG <> '1' AND BD7_NUMLOT >= ' ' " + CRLF
cQuery += "             AND BD7_YFAS35 = 'F' AND BAU_FILIAL = '  ' AND BAU.D_E_L_E_T_ = ' ' AND B16_FILIAL = '  'AND B16.D_E_L_E_T_ = ' ' " + CRLF
cQuery += "             AND bau_grppag = b16_codigo AND BD7_CODRDA  = BAU_CODIGO AND BD7_VLRPAG > 0  " + CRLF
cQuery += "             AND ZN_FILIAL(+) = '  ' AND SZN.D_E_L_E_T_(+) = ' ' AND BAU_CODIGO = ZN_CODRDA(+) " + CRLF

cQuery += "             AND (ZN_VIGFIM(+) = ' ' OR ZN_VIGFIM(+) >= '"+cCompAno+cCompMes+"') " + CRLF

cQuery += "        GROUP BY BAU_GRPPAG, b16_descri , BAU_CODIGO ,  BAU_NOME, BAU_CODRET , BD7_CODPEG, BD7_CODLDP , ZN_CODANA , ZN_NOMANA , bd7_codemp " + CRLF
cQuery += " UNION ALL " + CRLF
cQuery += "          SELECT '5' SEQ ,'Em_DigitaÁ„o_FASE1 ' TIPO , BAU_GRPPAG||' - ' || b16_descri GRPPAG ,BAU_CODIGO ||' - ' || BAU_NOME  NOME,  BAU_CODIGO CODRDA , " + CRLF
cQuery += "                 DECODE(TRIM(BAU_CODRET),'1708','P_JURIDICA','0588','P_FISICA','Nao Especificado') TPESSOA , COUNT (*) VALOR_LOTE  ,count(*) qtda , " + CRLF
cQuery += "                 BD7_CODPEG PEG , BD7_CODLDP LOCDIG , NVL(ZN_CODANA,' ') CODANA , NVL(ZN_NOMANA,' ') NOMANA , 0.00  VALOR_GLOSA , " + CRLF
cQuery += "                 CASE WHEN bd7_codemp = '0024' THEN 'Prefeitura' " + CRLF
cQuery += "                      WHEN bd7_codemp = '0025' THEN 'Prefeitura' " + CRLF
cQuery += "                      WHEN bd7_codemp = '0026' THEN 'Prefeitura' " + CRLF
cQuery += "                      WHEN bd7_codemp = '0027' THEN 'Prefeitura' " + CRLF
cQuery += "                      WHEN bd7_codemp = '0028' THEN 'Prefeitura' " + CRLF
cQuery += "                      Else 'Rede' " + CRLF
cQuery += "                 End  empresa " + CRLF
cQuery += "            FROM "+RetSqlName('BD7')+ " BD7 ,"+RetSqlName('BAU')+ " BAU , "+RetSqlName('B16')+ " B16  , "+RetSqlName('SZN')+ " SZN " + CRLF
cQuery += "           WHERE BD7_FILIAL = '  ' AND BD7.D_E_L_E_T_ = ' ' AND BD7_FASE = '1' AND BD7.BD7_SITUAC = '1' AND BD7.BD7_CODEMP <>'9999' 	" + CRLF

cQuery += "             AND BD7.BD7_ANOPAG || BD7.BD7_MESPAG = '"+cCompAno+cCompMes+"' " + CRLF 
cQuery += "             AND BD7_DATPRO >= '"+dDatproi+"' AND BD7_DATPRO <= '"+dDatprof+"' " + CRLF

cQuery += "             AND ( BD7.BD7_CONPAG = '1' OR BD7.BD7_CONPAG = ' ') AND BD7.BD7_LOTBLO = ' ' AND BD7.BD7_BLOPAG <> '1' AND BD7_NUMLOT >= ' ' " + CRLF
cQuery += "             AND BD7_YFAS35 = 'F' AND BAU_FILIAL = '  ' AND BAU.D_E_L_E_T_ = ' ' AND B16_FILIAL = '  'AND B16.D_E_L_E_T_ = ' ' " + CRLF
cQuery += "             AND bau_grppag = b16_codigo AND BD7_CODRDA  = BAU_CODIGO " + CRLF  
cQuery += "             AND ZN_FILIAL(+) = '  ' AND SZN.D_E_L_E_T_(+) = ' ' AND BAU_CODIGO = ZN_CODRDA(+) " + CRLF

cQuery += "             AND (ZN_VIGFIM(+) = ' ' OR ZN_VIGFIM(+) >= '"+cCompAno+cCompMes+"' ) " + CRLF

cQuery += "        GROUP BY BAU_GRPPAG, b16_descri , BAU_CODIGO ,  BAU_NOME, BAU_CODRET, BD7_CODPEG , BD7_CODLDP , ZN_CODANA , ZN_NOMANA , bd7_codemp " + CRLF 
cQuery += " UNION ALL " + CRLF
cQuery += "          SELECT '6' SEQ ,'Deb_Cred_Nao_faturado ' TIPO , BAU_GRPPAG||' - ' || b16_descri GRPPAG ,BAU_CODIGO  ||' - ' || BAU_NOME  NOME, BAU_CODIGO CODRDA , " + CRLF
cQuery += "                 DECODE(TRIM(BAU_CODRET),'1708','P_JURIDICA','0588','P_FISICA','Nao Especificado') TPESSOA , " + CRLF
cQuery += "                 SUM (DECODE(BGQ.BGQ_TIPO,'2',BGQ.BGQ_VALOR,(BGQ.BGQ_VALOR * -1))) VALOR_LOTE  ,count(*) qtda , " + CRLF
cQuery += "                 ' ' PEG , ' ' LOCDIG  , ' ' CODANA , ' ' NOMANA , 0.00  VALOR_GLOSA  , " + CRLF
cQuery += "                 CASE WHEN bd7_codemp = '0024' THEN 'Prefeitura' " + CRLF
cQuery += "                      WHEN bd7_codemp = '0025' THEN 'Prefeitura' " + CRLF
cQuery += "                      WHEN bd7_codemp = '0026' THEN 'Prefeitura' " + CRLF
cQuery += "                      WHEN bd7_codemp = '0027' THEN 'Prefeitura' " + CRLF
cQuery += "                      WHEN bd7_codemp = '0028' THEN 'Prefeitura' " + CRLF
cQuery += "                      Else 'Rede' " + CRLF
cQuery += "                  End empresa " + CRLF            
cQuery += "            FROM "+RetSqlName('BGQ')+ " BGQ ,"+RetSqlName('BAU')+ " BAU , "+RetSqlName('B16')+ " B16 " + CRLF
cQuery += "           WHERE Bgq_FILIAL = '  ' AND BGQ.D_E_L_E_T_ = ' ' AND BAU_FILIAL = '  ' AND BAU.D_E_L_E_T_ = ' ' AND B16_FILIAL = '  'AND B16.D_E_L_E_T_ = ' ' " + CRLF
cQuery += "             AND BGQ.BGQ_ANO = '2016' AND BGQ.BGQ_MES = '08' AND BGQ.BGQ_CODLAN <> '050' AND BGQ.BGQ_NUMLOT = ' ' " + CRLF
cQuery += "             AND BGQ.BGQ_CODIGO = BAU_CODIGO   AND BAU_GRPPAG = B16_CODIGO " + CRLF
cQuery += "        GROUP BY BAU_GRPPAG, b16_descri , BAU_CODIGO , BAU_NOME, BAU_CODRET , bgq_codemp " + CRLF
cQuery += " UNION ALL " + CRLF
cQuery += "          SELECT '7' SEQ,'Deb_Cred_faturado ' TIPO , BAU_GRPPAG||' - ' || b16_descri GRPPAG ,BAU_CODIGO  ||' - ' || BAU_NOME  NOME, BAU_CODIGO CODRDA , " + CRLF
cQuery += "                 DECODE(TRIM(BAU_CODRET),'1708','P_JURIDICA','0588','P_FISICA','Nao Especificado') TPESSOA , " + CRLF
cQuery += "                 SUM (DECODE(BGQ.BGQ_TIPO,'2',BGQ.BGQ_VALOR,(BGQ.BGQ_VALOR * -1))) VALOR_LOTE  ,count(*) qtda , " + CRLF
cQuery += "                 ' ' PEG , ' ' LOCDIG  , ' ' CODANA , ' ' NOMANA , 0.00  VALOR_GLOSA  , " + CRLF
cQuery += "                 CASE WHEN bd7_codemp = '0024' THEN 'Prefeitura' " + CRLF
cQuery += "                      WHEN bd7_codemp = '0025' THEN 'Prefeitura' " + CRLF
cQuery += "                      WHEN bd7_codemp = '0026' THEN 'Prefeitura' " + CRLF
cQuery += "                      WHEN bd7_codemp = '0027' THEN 'Prefeitura' " + CRLF
cQuery += "                      WHEN bd7_codemp = '0028' THEN 'Prefeitura' " + CRLF
cQuery += "                      Else 'Rede' " + CRLF
cQuery += "                  End empresa " + CRLF	        
cQuery += "            FROM "+RetSqlName('BGQ')+ " BGQ ,"+RetSqlName('BAU')+ " BAU , "+RetSqlName('B16')+ " B16 " + CRLF
cQuery += "           WHERE BGQ_FILIAL = '  ' AND BGQ.D_E_L_E_T_ = ' ' AND BAU_FILIAL = '  ' AND BAU.D_E_L_E_T_ = ' ' AND B16_FILIAL = '  'AND B16.D_E_L_E_T_ = ' ' " + CRLF
cQuery += "             AND BGQ.BGQ_ANO = '"+cCompAno+"' AND BGQ.BGQ_MES = '"+cCompMes+"' AND BGQ.BGQ_CODLAN <> '050' " + CRLF

cQuery += "             AND BGQ.BGQ_NUMLOT >= '"+cCompAno+cCompMes+"'0001' AND BGQ.BGQ_NUMLOT <= '"+cCompAno+cCompMes+"'9999' " + CRLF

cQuery += "             AND BGQ.BGQ_CODIGO = BAU_CODIGO   AND BAU_GRPPAG = B16_CODIGO " + CRLF 
cQuery += "        GROUP BY BAU_GRPPAG, b16_descri , BAU_CODIGO , BAU_NOME, BAU_CODRET , bgq_codemp ) TAB " + CRLF  
cQuery += "FULL OUTER JOIN "
cQuery += "                 (SELECT bau_CODIGO CODRDAP, BAU_NOME NOMRDAP ,bau_grppag gruppgtp , b16_descri grpdescp , " + CRLF  
cQuery += "                         SUM(ZZP_VLINHO) VLRHOSP , SUM(ZZP_VLINAM) VLRAMB , SUM(ZZP_VLINOD) VLROD , " + CRLF
cQuery += "                        (SUM(ZZP_VLINHO) + SUM(ZZP_VLINAM)+ SUM(ZZP_VLINOD)) VLRTOT " + CRLF
cQuery += "                    FROM "+RetSqlName('ZZP')+ " ZZP ,"+RetSqlName('BAU')+ " BAU , "+RetSqlName('B16')+ " B16 " + CRLF
cQuery += "                   WHERE ZZP_FILIAL = ' ' AND  ZZP.D_e_l_e_t_ = ' ' " + CRLF
cQuery += "                     AND BAU_FILIAL = ' ' AND  BAU.D_e_l_e_t_ = ' ' and bau.R_E_C_D_E_L_ = 0 " + CRLF
cQuery += "                     AND B16_FILIAL = ' ' AND  B16.D_e_l_e_t_ = ' ' " + CRLF  
cQuery += "                     AND ZZP_CODRDA BETWEEN '      ' AND '999999' " + CRLF

cQuery += "                     AND ZZP_ANOPAG||ZZP_MESPAG >= '"+cCompAno+cCompMes+"' AND ZZP_ANOPAG||ZZP_MESPAG <= '"+cCompAno+cCompMes+"' " + CRLF

cQuery += "                     AND ZZP_CODRDA = BAU_CODIGO " + CRLF
cQuery += "                     AND bau_grppag = b16_codigo " + CRLF
cQuery += "                     AND ZZP_STATUS NOT IN ('PCA','CCA') " + CRLF
cQuery += "                GROUP BY bau_CODIGO , bau_nome ,bau_grppag , b16_descri ) TABP " + CRLF
cQuery += "        ON TAB.CODRDA = TABP.CODRDAP " + CRLF
cQuery += "        GROUP BY nvl(TAB.GRPPAG, tabp.gruppgtp||'-'||grpdescp ) , NVL(TAB.CODRDA,tabp.CODRDAP ) , " + CRLF  
cQuery += "                 nvl(SUBSTR(TAB.NOME,1,40),SUBSTR(TABP.NOMRDAP,1,40)) , " + CRLF 
cQuery += "                 nvl(TAB.TPESSOA,' ') , " + CRLF
cQuery += "                 nvl(TABP.VLRHOSP,0.00) , nvl(TABP.VLRAMB,0.00) , nvl(TABP.VLROD,0.00) , nvl(TABP.VLRTOT,0.00) " + CRLF           
cQuery += "        ORDER BY GRPPAG , CODRDA " + CRLF
   
   If Select(("TMP")) <> 0 
      ("TMP")->(DbCloseArea()) 
   Endif
    
    TCQuery cQuery Alias "TMP" New 
                                                                                           
    dbSelectArea("TMP")

    tmp->(dbGoTop())  

    FGrvPlan()  

next

Return()               


Static Function AjustaSX1(cPerg)

Local aHelpPor := {}

PutSx1(cPerg,"01",OemToAnsi("Mes/Ano Custo?       ") 		,"","","mv_ch1","C",07,0,0,"G","","","","","mv_par01","","","","","","","","","","","","","","","","99/9999",aHelpPor,{},{})
PutSx1(cPerg,"02",OemToAnsi("Dt proced. Inicial?  ") 		,"","","mv_ch2","D",10,0,0,"G","","","","","mv_par02","","","","","","","","","","","","","","","","99/99/9999",aHelpPor,{},{}) 
PutSx1(cPerg,"03",OemToAnsi("Dt proced. Final  ?  ") 		,"","","mv_ch3","D",10,0,0,"G","","","","","mv_par03","","","","","","","","","","","","","","","","99/99/9999",aHelpPor,{},{})

Pergunte(cPerg,.T.)

Return 

Static Function FGrvPlan()

   If I = 1 
       If  mv_par02 == 1           
           cNomDadCab:= '1 - Rda - Faturado  '   
           cNomPla   := '1 - Rda - Faturado  ' 
       Else                                  
           cNomDadCab:= '1 - Rda - 3 1_2  '   
           cNomPla   := '1 - Rda - 3 1_2  ' 
       EndIf     
   ElseIf I = 2                    
       If  mv_par02 == 1           
           cNomDadCab:= '2 - Analista - Faturado   '   
           cNomPla   := '2 - Analista - Faturado   '
       Else 
           cNomDadCab:= '2 - Analista - 3 1_2  '   
           cNomPla   := '2 - Analista - 3 1_2  '       
       EndIf      
   ElseIf I = 3                          
       If  mv_par02 == 1           
           cNomDadCab:= '3 - Analista  -  Rda - Faturado  '   
           cNomPla   := '3 - Analista  -  Rda - Faturado  ' 
       Else                                   
          cNomDadCab:= '3 - Analista  -  Rda - 3 1_2  '   
          cNomPla   := '3 - Analista  -  Rda - 3 1_2  '        
       EndIf    
   ElseIf I = 4 
       If  mv_par02 == 1           
           cNomDadCab:= '4 - Rda  -  Analista - Faturado  '   
           cNomPla   := '4 - Rda  -  Analista - Faturado  '                   
       Else                                                      
           cNomDadCab:= '4 - Rda  -  Analista - 3 1_2  '   
           cNomPla   := '4 - Rda  -  Analista - 3 1_2  '                   
       EndIf      
   EndIf                    
   cComp     :=  cCompMes+'/'+cCompAno 
   cNomeArq := "C:\TEMP\"+cCompAno+cCompMes+" - "+cNomDadCab+"_"+SubStr(DtoS(date()),7,2)+"_"+SubStr(DtoS(date()),5,2)+"_"+SubStr(DtoS(date()),1,4)+"_"+STRTRAN(TIME(),":","_")+".csv"

   nHandle := FCREATE(cNomeArq)
   cMontaTxt := cNomDadCab
   cMontaTxt += CRLF
   FWrite(nHandle,cMontaTxt)       		 
   cMontaTxt := 'Competencia : ' + cComp
   cMontaTxt += CRLF
   FWrite(nHandle,cMontaTxt)		 
   cMontaTxt := 'Planilha : '+cNomPla  
   cMontaTxt += CRLF
   FWrite(nHandle,cMontaTxt)	        
                                 
        
   If I = 1 
      cMontaTxt := "Grp Pagto ;" 
      cMontaTxt += "Rda ;"   
   ElseIf I = 2              
      cMontaTxt := "Analista ;"   
   ElseIf I = 3                   
      cMontaTxt := "Analista ;"
      cMontaTxt += "Rda  ;"
   ElseIf I = 4                               
      cMontaTxt := "Grp Pagto ;" 
      cMontaTxt += "Rda ;" 
      cMontaTxt += "Analista  ;"     
   EndIf                    
   
   cMontaTxt += "Vlr Pagto   ;"  
   cMontaTxt += "Qtda Pgto   ;"   
   cMontaTxt += "Vlr Glosado ;"
   cMontaTxt += "Qtda Glosado ;" 
   cMontaTxt += "Vlr Apresentado ;"
   cMontaTxt += "Qtda Apresentado;"  		  		 		  		
		
   cMontaTxt += CRLF // Salto de linha para .csv (excel)
             
   FWrite(nHandle,cMontaTxt)
   
   tmp->(dbGoTop())                    
   
   While !(TMP->(Eof()))    

	   If I = 1           
          cMontaTxt := tmp->GRPPAG +";" 
	      cMontaTxt += tmp->RDA +";"   
	   ElseIf I = 2              
	      cMontaTxt := tmp->ANALISTA +";"   
	   ElseIf I = 3                   
	      cMontaTxt := tmp->ANALISTA +";"
	      cMontaTxt += tmp->RDA +";"         
	   ElseIf I = 4               
	      cMontaTxt := tmp->GRPPAG  +";"               
	      cMontaTxt += tmp->RDA +";"         
	      cMontaTxt += tmp->ANALISTA +";"
	   EndIf                                                                                                                                                                                                                   

	  cMontaTxt += Transform(tmp->Vlr_PAGO  ,'@E  999,999,999.99') + ";"
  	  cMontaTxt += Transform(tmp->qtda_PAGO ,'@E          99,999') + ";"
	  cMontaTxt += Transform(tmp->Vlr_GLO   ,'@E  999,999,999.99') + ";"
  	  cMontaTxt += Transform(tmp->qtda_GLO  ,'@E          99,999') + ";"       
	  cMontaTxt += Transform(tmp->Vlr_APRE  ,'@E  999,999,999.99') + ";"
	  cMontaTxt += Transform(tmp->qtda_APRE ,'@E          99,999') + ";"       
		  
	  cMontaTxt += CRLF // Salto de linha para .csv (excel)      
		      
	  FWrite(nHandle,cMontaTxt)


      tmp->(DbSkip())

    EndDo       

	If nHandle > 0
		
		// encerra gravaÁ„o no arquivo
		FClose(nHandle)
		cNomeArq1+= cNomeArq + CRLF
     	//	MsgAlert("Relatorio salvo em: "+cNomeArq)
		
	EndIf                

    If I = 4 		
     	MsgAlert("Relatorio salvo em: " + CRLF +cNomeArq1)
    EndIf           
    
Return () 
