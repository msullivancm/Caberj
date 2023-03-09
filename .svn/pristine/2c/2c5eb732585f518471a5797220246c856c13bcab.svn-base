#INCLUDE "PROTHEUS.CH"
#Include "TOPCONN.CH"
                             
/*/                                                                                      
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±…ÕÕÕÕÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÀÕÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÀÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÕª±±
±±∫Programa  ≥CABR220   ∫ Autor ≥Altamiro              ∫ Data ≥ 01/10/12  ∫±±
±±ÃÕÕÕÕÕÕÕÕÕÕÿÕÕÕÕÕÕÕÕÕÕ ÕÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕ ÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕπ±±
±±∫Descricao ≥ Rotina para complementar a rotima do Diops                 ∫±±
±±∫          ≥                                                            ∫±±
±±»ÕÕÕÕÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕº±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
/*/                  

User Function CABR220()

Local   nCont		:= 0    
Local   cMsg		:= ""
Private cDpj        := 'N„o'   
private cImp        := 'N„o'
Private oLeTxt
Private lAbortPrint :=.F.
Private cPerg       := "CABR220"
Private cTitulo     := "Relatorio Complementar do DIOP's "   
Private cTitulo2    := "Relatorio Complementar do DIOP's "
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
private a           := 1                     
 
 AjustaSX1(cPerg)

cCompet     :=  SUBSTR(mv_par01,4,4) + SUBSTR(mv_par01,1,2) 
cEmpresa    :=  Iif(cEmpAnt == '01','C','I')  
cEmp        :=  Iif(cEmpAnt == '01','Caberj','Integral')                   
nOpcao      :=  mv_par02    
            
  If mv_par03 == 1
      
         cTitulo:= 'ExtraÁ„o de cooparticipaÁ„o e suas data de cobranÁa' 
         MsgAlert(cTitulo,"INFO")                                  
         Processa({||Processa6()}, cTitulo, "", .T.)          

  ElseIf nOpcao == 1  // Diops     
         MsgAlert(cTitulo,"INFO") 
         Processa({||Processa1()}, cTitulo, "", .T.)          
  ElseIf nOpcao == 2  // auditoria guias      
         cTitulo:= 'ExtraÁ„o de Guias para Auditoria'  
         MsgAlert(cTitulo,"INFO")   
         Processa({||Processa2()}, cTitulo, "", .T.)           
  ElseIf nOpcao == 3  // auditoria Material   
         cTitulo:= 'ExtraÁ„o de Materiais para Auditoria'
         MsgAlert(cTitulo,"INFO")                                
         Processa({||Processa3()}, cTitulo, "", .T.)                  
  ElseIf nOpcao == 4  // auditoria guias      
         cTitulo:= 'ExtraÁ„o de Reembolso para Auditoria'
         MsgAlert(cTitulo,"INFO")                                  
         Processa({||Processa4()}, cTitulo, "", .T.)        
  ElseIf nOpcao == 5  // auditoria guias      
         cTitulo:= 'ExtraÁ„o  Deb/Cre para Auditoria'
         MsgAlert(cTitulo,"INFO")                                  
         Processa({||Processa5()}, cTitulo, "", .T.)   

   EndIf 

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
              
cQuery := " SELECT DAT_EV DTEVENT ," + CRLF  
CQUERY += "        SUM(VL_APROV+GLOSADO) APRESENTADO , " + CRLF  
CQUERY += "        SUM(GLOSADO) GLOSADO , " + CRLF  
CQUERY += "        SUM(VL_APROV)PAGO , " + CRLF    
CQUERY += "        SUM(VL_PARTICIPACAO)COPART " + CRLF    
CQUERY += "   FROM( " + CRLF                              
CQUERY += "        SELECT /*+FIRST_ROWS INDEX_ASC(BD7 BD70105)*/  " + CRLF
CQUERY += "               BD7_CODPLA PLANO, " + CRLF 
CQUERY += "               BD6_YNEVEN COD_EVENTO ,  " + CRLF
CQUERY += "               ZZT_EVENTO NOME_EVENTO , " + CRLF 
CQUERY += "               QTDE, " + CRLF 
CQUERY += "               SUM(BD6F.BD6_QTDPRO) OCORRENCIA, " + CRLF 
CQUERY += "               SUM(BD6F.BD6_VLRGLO) GLOSADO,  " + CRLF
CQUERY += "               SUM(BD7F.VLRPAG)  VL_APROV,  " + CRLF
CQUERY += "               SUM(DECODE(BD6F.BD6_BLOCPA,'1',0,DECODE(SIGN(BD6F.BD6_VLRTPF),-1,0,DECODE(BD6_CODEMP,'0004',0,'0009',0,BD6F.BD6_VLRTPF)))) VL_PARTICIPACAO, " + CRLF 
CQUERY += "               EXPOS EXPOSICAO_ANS , " + CRLF  
CQUERY += "               RETORNA_DESC_GRUPO_PLANO ( TRIM(BI3_YGRPLA),'"+cEmpresa+"') GRUPO_PLANO, " + CRLF 
CQUERY += "               DECODE(BD6_CODEMP,'0007',TRIM(BI3_NREDUZ)||' (SEPE)',BI3_NREDUZ) NOME_PLANO, " + CRLF  
CQUERY += "               ZZT_TPCUST , " + CRLF 
CQUERY += "               BD6_YPROJ PROJ, " + CRLF 
CQUERY += "               DECODE(BD6_CODLDP,'0010','RECUP GLOSA','0017','RATEIO','CONTA') TIPO, " + CRLF 
CQUERY += "               BR8_YINBEN BENEF, " + CRLF  
CQUERY += "               BD6_CODEMP CODEMP, " + CRLF 
CQUERY += "               RETORNA_DESCRI_GRUPOEMP('"+cEmpresa+"',BD6_CODEMP) NOME_EMP, " + CRLF 
CQUERY += "               TO_DATE(BD6_DATPRO,'YYYYMMDD') DAT_EV   " + CRLF 
CQUERY += "          FROM( " + CRLF
// custo guias 
CQUERY += "               SELECT BD7.BD7_FILIAL,BD7_CODPLA,SIGA_TIPO_EXPOSICAO_ANS(BD7_CODEMP,BD7_MATRIC,BD7_TIPREG,TO_DATE(TRIM(BD7_DATPRO),'YYYYMMDD')) EXPOS, " + CRLF 
CQUERY += "                      BD7.BD7_OPELOT, " + CRLF 
CQUERY += "                      BD7.BD7_CODOPE, BD7.BD7_CODLDP, BD7.BD7_CODPEG, BD7.BD7_NUMERO, BD7.BD7_ORIMOV, BD7_CODPRO, " + CRLF 
CQUERY += "                      BD7.BD7_SEQUEN,  SUM(BD7.BD7_VLRPAG) AS VLRPAG,  " + CRLF
CQUERY += "                      COUNT(DISTINCT BD7_CODEMP||BD7_MATRIC||BD7_TIPREG) QTDE  " + CRLF

CQUERY += "                 FROM "+RetSqlName('BD7')+ " BD7 " + CRLF  
CQUERY += "                WHERE BD7.BD7_FILIAL='" + xFilial('BD7') + "' " + CRLF   
CQUERY += "                  AND BD7.BD7_CODOPE = '0001' " + CRLF 
CQUERY += "                  AND BD7.BD7_SITUAC = '1'  " + CRLF
CQUERY += "                  AND BD7.BD7_FASE = '4'  " + CRLF
CQUERY += "                  AND BD7.BD7_BLOPAG <> '1'  " + CRLF

CQUERY += "                  AND BD7.BD7_NUMLOT LIKE '"+cCompet +"'||'%' " + CRLF  

CQUERY += "                  AND BD7.D_E_L_E_T_ = ' ' " + CRLF 
CQUERY += "                GROUP BY BD7_FILIAL, BD7_CODPLA, BD7.BD7_OPELOT,BD7_CODPRO,  " + CRLF
CQUERY += "                      SIGA_TIPO_EXPOSICAO_ANS(BD7_CODEMP,BD7_MATRIC,BD7_TIPREG,TO_DATE(TRIM(BD7_DATPRO),'YYYYMMDD')), " + CRLF 
CQUERY += "                      BD7_FILIAL, BD7_CODOPE, BD7_CODLDP, BD7_CODPEG, BD7_NUMERO, BD7_ORIMOV, BD7_SEQUEN) BD7F, " + CRLF 
cQuery += "               "+RetSqlName('BD6')+ " BD6F , "+RetSqlName('BI3')+ " BI3 ,"+RetSqlName('ZZT')+ " ZZT , "+RetSqlName('BR8')+ " BR8    " + CRLF

CQUERY += "         WHERE ZZT_FILIAL='" + xFilial('ZZT') + "' " + CRLF   
CQUERY += "           AND BI3_FILIAL='" + xFilial('BI3') + "' " + CRLF   
CQUERY += "           AND BR8_FILIAL='" + xFilial('BR8') + "' " + CRLF   

CQUERY += "           AND BD6F.BD6_CODPAD=BR8_CODPAD " + CRLF 
CQUERY += "           AND BD6F.BD6_CODPRO=BR8_CODPSA " + CRLF 
CQUERY += "           AND BR8.D_E_L_E_T_=' '  " + CRLF

CQUERY += "           AND BD6F.BD6_FILIAL='" + xFilial('BD6') + "' " + CRLF

CQUERY += "           AND BD7F.BD7_FILIAL = BD6F.BD6_FILIAL  " + CRLF
CQUERY += "           AND BD7F.BD7_CODOPE = BD6F.BD6_CODOPE  " + CRLF
CQUERY += "           AND BD7F.BD7_CODLDP = BD6F.BD6_CODLDP  " + CRLF
CQUERY += "           AND BD7F.BD7_CODPEG = BD6F.BD6_CODPEG  " + CRLF
CQUERY += "           AND BD7F.BD7_NUMERO = BD6F.BD6_NUMERO  " + CRLF
CQUERY += "           AND BD7F.BD7_ORIMOV = BD6F.BD6_ORIMOV  " + CRLF
CQUERY += "           AND BD7F.BD7_SEQUEN = BD6F.BD6_SEQUEN  " + CRLF 
CQUERY += "           AND BD6F.BD6_CODPRO = BD7F.BD7_CODPRO  " + CRLF
  
CQUERY += "           AND BI3_FILIAL =BD7_FILIAL  " + CRLF
CQUERY += "           AND BI3_CODINT=BD7_CODOPE  " + CRLF
CQUERY += "           AND BI3_CODIGO=BD7_CODPLA  " + CRLF
CQUERY += "           AND BD6_YNEVEN=ZZT_CODEV  " + CRLF
CQUERY += "           AND BD6F.D_E_L_E_T_ = ' '  " + CRLF
CQUERY += "           AND BI3.D_E_L_E_T_ = ' '  " + CRLF
CQUERY += "           AND ZZT.D_E_L_E_T_ = ' '  " + CRLF
  
CQUERY += "         GROUP BY EXPOS,BD6_CODEMP, " + CRLF 
CQUERY += "               DECODE(BD6_CODLDP,'0010','RECUP GLOSA','0017','RATEIO','CONTA'), " + CRLF 
CQUERY += "               BD7_CODPLA, " + CRLF 
CQUERY += "               TRIM(BI3_YGRPLA),DECODE(BD6_CODEMP,'0007',TRIM(BI3_NREDUZ)||' (SEPE)',BI3_NREDUZ), " + CRLF 
CQUERY += "               BD6_YNEVEN , " + CRLF 
CQUERY += "               ZZT_EVENTO,QTDE ,ZZT_TPCUST , " + CRLF 
CQUERY += "               BD6_YPROJ, " + CRLF 
CQUERY += "               BR8_YINBEN, " + CRLF 
CQUERY += "               BD6_CODEMP , " + CRLF 
CQUERY += "               RETORNA_DESCRI_GRUPOEMP('"+cEmpresa+"',BD6_CODEMP),  " + CRLF
CQUERY += "               TO_DATE(BD6_DATPRO,'YYYYMMDD') " + CRLF 
 
CQUERY += "  UNION ALL  " + CRLF
// custo deb/cred  
CQUERY += " SELECT NVL( RETORNA_PLANO_USU_MS ('"+cEmpresa+"',BGQ_CODOPE,BGQ_CODEMP,BGQ_MATRIC,'00','N'),BBB_YCODPL) PLANO, " + CRLF 
CQUERY += "        BGQ_YNEVEN COD_EVENTO, " + CRLF 
CQUERY += "        ZZT_EVENTO NOME_EVENTO, " + CRLF 
CQUERY += "        COUNT(DISTINCT BGQ_CODSEQ)QTDE, " + CRLF  
CQUERY += "        COUNT(BGQ_CODSEQ) OCORRENCIA, " + CRLF  
CQUERY += "        0 GLOSADO, " + CRLF 
CQUERY += "        SUM(DECODE(BBB_TIPSER,1,-1*BGQ_VALOR,BGQ_VALOR)) VL_APROV, " + CRLF 
CQUERY += "        0 VL_PARTICIPACAO, " + CRLF 
CQUERY += "        DECODE(NVL(TRIM(BGQ_CODEMP),RETORNA_GRUPO_EMP(BI3_CODIGO)),'0004',2,'0009',2,0) EXPOSICAO_ANS, " + CRLF  
CQUERY += "        RETORNA_DESC_GRUPO_PLANO ( TRIM(BI3_YGRPLA),'"+cEmpresa+"') GRUPO_PLANO, " + CRLF 
CQUERY += "        BI3_NREDUZ NOME_PLANO, " + CRLF 
CQUERY += "        ZZT_TPCUST , " + CRLF 
CQUERY += "        BGQ_YPROJ PROJ, " + CRLF 
CQUERY += "        'LANCAMENTOS DEB/CRED' TIPO, " + CRLF 
CQUERY += "        '1' BENEF, " + CRLF 
CQUERY += "        BGQ_CODEMP CODEMP, " + CRLF 
CQUERY += "        RETORNA_DESCRI_GRUPOEMP('"+cEmpresa+"',BGQ_CODEMP), " + CRLF 
CQUERY += "        TO_DATE(BGQ_ANO||BGQ_MES||'01','YYYYMMDD') DAT_EV " + CRLF 
 
CQUERY += "   FROM  "+RetSqlName('BBB')+ " BBB, "+RetSqlName('BGQ')+ " BGQ, "+RetSqlName('BI3')+ " BI3, "+RetSqlName('ZZT')+ " ZZT " + CRLF  

CQUERY += "  WHERE BGQ_FILIAL = '" + xFilial('BGQ') + "' " + CRLF                                                                                                        
CQUERY += "    AND BGQ_CODLAN <> '050' " + CRLF

CQUERY += "    AND BBB_FILIAL = '" + xFilial('BBB') + "' " + CRLF  
CQUERY += "    AND BBB_CODSER = BGQ_CODLAN  " + CRLF 

CQUERY += "    AND ZZT_FILIAL = '" + xFilial('ZZT') + "' " + CRLF  

CQUERY += "    AND BGQ_YNEVEN=ZZT_CODEV " + CRLF
 
CQUERY += "    AND BI3_FILIAL = '" + xFilial('BI3') + "' " + CRLF 
CQUERY += "    AND BI3_CODIGO=NVL( RETORNA_PLANO_USU_MS ('"+cEmpresa+"',BGQ_CODOPE,BGQ_CODEMP,BGQ_MATRIC,'00','N'),BBB_YCODPL) " + CRLF

CQUERY += "    AND BGQ_NUMLOT LIKE '"+cCompet +"'||'%'  

CQUERY += "    AND BI3.D_E_L_E_T_ = ' '  " + CRLF
CQUERY += "    AND ZZT.D_E_L_E_T_ = ' '  " + CRLF
CQUERY += "    AND BGQ.D_E_L_E_T_ = ' '  " + CRLF
CQUERY += "    AND BBB.D_E_L_E_T_ = ' '  " + CRLF
CQUERY += "  GROUP BY NVL( RETORNA_PLANO_USU_MS ('"+cEmpresa+"',BGQ_CODOPE,BGQ_CODEMP,BGQ_MATRIC,'00','N'),BBB_YCODPL) , " + CRLF   
CQUERY += "        BGQ_YNEVEN ,  ZZT_EVENTO, ZZT_TPCUST, " + CRLF 
CQUERY += "        DECODE(NVL(TRIM(BGQ_CODEMP),RETORNA_GRUPO_EMP(BI3_CODIGO)),'0004',2,'0009',2,0), " + CRLF 
CQUERY += "        RETORNA_DESC_GRUPO_PLANO ( TRIM(BI3_YGRPLA),'"+cEmpresa+"'),BI3_NREDUZ , " + CRLF 
CQUERY += "        BGQ_YPROJ ,BGQ_CODEMP , RETORNA_DESCRI_GRUPOEMP('"+cEmpresa+"',BGQ_CODEMP), " + CRLF 
CQUERY += "        TO_DATE(BGQ_ANO||BGQ_MES||'01','YYYYMMDD') " + CRLF  
  
CQUERY += "  UNION ALL " + CRLF 
// custo materiais   
CQUERY += " SELECT PLANO, " + CRLF 
CQUERY += "        CODEVENTO, " + CRLF 
CQUERY += "        NOME_EVENTO, " + CRLF 
CQUERY += "        SUM(QTDE),  " + CRLF
CQUERY += "        SUM(OCORRENCIA), " + CRLF 
CQUERY += "        SUM(GLOSADO), " + CRLF 
CQUERY += "        SUM(VL_APROV)  VL_APROV, " + CRLF 
CQUERY += "        SUM(VL_PARTICIPACAO) VL_PARTICIPACAO, " + CRLF 
CQUERY += "        EXPOSICAO_ANS , " + CRLF 
CQUERY += "        GRUPO_PLANO, " + CRLF 
CQUERY += "        NOME_PLANO, " + CRLF 
CQUERY += "        ZZT_TPCUST , " + CRLF 
CQUERY += "        PROJ, " + CRLF 
CQUERY += "        'MATERIAL' TIPO, " + CRLF 
CQUERY += "        BENEF, " + CRLF 
CQUERY += "        CODEMP, " + CRLF  
CQUERY += "        RETORNA_DESCRI_GRUPOEMP ('"+cEmpresa+"',CODEMP) NOME_EMP, " + CRLF  
CQUERY += "        DAT_EV " + CRLF  
  
CQUERY += "   FROM( " + CRLF 
CQUERY += "        SELECT BD6_CODPLA PLANO, " + CRLF 
CQUERY += "               BD6_YNEVEN CODEVENTO, " + CRLF 
CQUERY += "               ZZT_EVENTO NOME_EVENTO, " + CRLF 
CQUERY += "               COUNT(DISTINCT BD6_CODEMP||BD6_MATRIC||BD6_TIPREG) QTDE, " + CRLF 
CQUERY += "               SUM(D1_QUANT) OCORRENCIA, " + CRLF 
CQUERY += "               SUM(BD6_VLRGLO) GLOSADO, " + CRLF 
CQUERY += "               SUM(D1_TOTAL)-SUM(D1_VALDESC)  VL_APROV, " + CRLF 
CQUERY += "               RETORNA_VL_COPART_OPME (BD6_CODOPE,BD6_CODLDP,BD6_CODPEG,BD6_NUMERO,'"+cEmpresa+"') VL_PARTICIPACAO,  " + CRLF
CQUERY += "               SIGA_TIPO_EXPOSICAO_ANS(BD6_CODEMP,BD6_MATRIC,BD6_TIPREG,TO_DATE(TRIM(BD6_DATPRO),'YYYYMMDD')) EXPOSICAO_ANS ,  " + CRLF
CQUERY += "               RETORNA_DESC_GRUPO_PLANO ( TRIM(BI3_YGRPLA),'"+cEmpresa+"') GRUPO_PLANO,  " + CRLF
CQUERY += "               DECODE(BD6_CODEMP,'0007',TRIM(BI3_NREDUZ)||' (SEPE)',BI3_NREDUZ) NOME_PLANO,  " + CRLF
CQUERY += "               0 VAL_ADIANT , B19_DOC,  " + CRLF
CQUERY += "               ZZT_TPCUST ,  " + CRLF
CQUERY += "               BD6_YPROJ PROJ,  " + CRLF
CQUERY += "               BR8_YINBEN BENEF,  " + CRLF
CQUERY += "               BD6_CODEMP CODEMP,  " + CRLF
CQUERY += "               TO_DATE(BD6_DATPRO,'YYYYMMDD') DAT_EV " + CRLF            

CQUERY += "   FROM  "+RetSqlName('B19')+ " B19, "+RetSqlName('SD1')+ " SD1, "+RetSqlName('SF1')+ " SF1, "+RetSqlName('BD6')+ " BD6 , " + CRLF        
CQUERY += "         "+RetSqlName('SA2')+ " SA2, "+RetSqlName('ZZT')+ " ZZT, "+RetSqlName('BI3')+ " BI3, "+RetSqlName('BR8')+ " BR8   " + CRLF  

CQUERY += "         WHERE BI3_FILIAL='" + xFilial('BI3') + "' " + CRLF  
CQUERY += "           AND A2_FILIAL='" + xFilial('SA2') + "' " + CRLF  
//CQUERY += "           AND F1_EMISSAO LIKE '"+cCompet +"'||'%' "+ CRLF 
CQUERY += "           AND F1_YDTCON BETWEEN '"+cCompet +"'||'01'  AND '"+cCompet +"'||'31'  
CQUERY += "           AND A2_COD = B19_FORNEC " + CRLF 
CQUERY += "           AND D1_FORNECE= A2_COD " + CRLF 
CQUERY += "           AND F1_FORNECE= A2_COD " + CRLF 
CQUERY += "           AND D1_DOC = F1_DOC " + CRLF 
CQUERY += "           AND B19_DOC = D1_DOC " + CRLF 
CQUERY += "           AND D1_ITEM = B19_ITEM " + CRLF 

CQUERY += "           AND BD6_FILIAL = '" + xFilial('BD6') + "' " + CRLF  
CQUERY += "           AND ZZT_FILIAL = '" + xFilial('ZZT') + "' " + CRLF  
CQUERY += "           AND BR8_FILIAL = '" + xFilial('BR8') + "' " + CRLF  

CQUERY += "           AND BD6_CODPAD=BR8_CODPAD " + CRLF 
CQUERY += "           AND BD6_CODPRO=BR8_CODPSA " + CRLF 
CQUERY += "           AND BR8.D_E_L_E_T_=' ' " + CRLF  
CQUERY += "           AND BD6_CODPLA=BI3_CODIGO  " + CRLF
CQUERY += "           AND BD6_CODOPE = SUBSTR(B19_GUIA,01,04) " + CRLF 
CQUERY += "           AND BD6_CODLDP = SUBSTR(B19_GUIA,05,04) " + CRLF 
CQUERY += "           AND BD6_CODPEG = SUBSTR(B19_GUIA,09,08) " + CRLF 
CQUERY += "           AND BD6_NUMERO = SUBSTR(B19_GUIA,17,08) " + CRLF 
CQUERY += "           AND BD6_ORIMOV = SUBSTR(B19_GUIA,25,01) " + CRLF 
CQUERY += "           AND BD6_SEQUEN = SUBSTR(B19_GUIA,26,03) " + CRLF 
CQUERY += "           AND BD6_FASE IN (3,4) " + CRLF 
CQUERY += "           AND BD6_CODLDP='0013' " + CRLF 
CQUERY += "           AND BD6_SITUAC = 1  " + CRLF
CQUERY += "           AND BD6_YNEVEN=ZZT_CODEV " + CRLF 
  
CQUERY += "           AND SA2.D_E_L_E_T_ = ' ' " + CRLF 
CQUERY += "           AND B19.D_E_L_E_T_ = ' ' " + CRLF 
CQUERY += "           AND SD1.D_E_L_E_T_ = ' ' " + CRLF 
CQUERY += "           AND SF1.D_E_L_E_T_ = ' ' " + CRLF 
CQUERY += "           AND BD6.D_E_L_E_T_ = ' ' " + CRLF 
CQUERY += "           AND ZZT.D_E_L_E_T_ = ' ' " + CRLF  
CQUERY += "           AND BI3.D_E_L_E_T_ = ' ' " + CRLF 
   
CQUERY += "     GROUP BY SIGA_TIPO_EXPOSICAO_ANS(BD6_CODEMP,BD6_MATRIC,BD6_TIPREG,TO_DATE(TRIM(BD6_DATPRO),'YYYYMMDD')), " + CRLF  
CQUERY += "           BD6_CODEMP , " + CRLF 
CQUERY += "           BD6_CODPLA , " + CRLF 
CQUERY += "           TRIM(BI3_YGRPLA),DECODE(BD6_CODEMP,'0007',TRIM(BI3_NREDUZ)||' (SEPE)',BI3_NREDUZ) , " + CRLF 
CQUERY += "           BD6_YNEVEN, B19_DOC , " + CRLF 
CQUERY += "           ZZT_EVENTO,ZZT_TPCUST , " + CRLF 
CQUERY += "           BD6_YPROJ , " + CRLF 
CQUERY += "           RETORNA_VL_COPART_OPME (BD6_CODOPE,BD6_CODLDP,BD6_CODPEG,BD6_NUMERO,'"+cEmpresa+"') , " + CRLF  
CQUERY += "           BR8_YINBEN , " + CRLF 
CQUERY += "           BD6_CODEMP,TO_DATE(BD6_DATPRO,'YYYYMMDD') ) " + CRLF 
  
CQUERY += "  GROUP BY PLANO,  NOME_EVENTO , " + CRLF 
CQUERY += "        CODEVENTO , " + CRLF 
CQUERY += "        GRUPO_PLANO , " + CRLF 
CQUERY += "        NOME_PLANO , " + CRLF 
CQUERY += "        EXPOSICAO_ANS,ZZT_TPCUST,PROJ,BENEF , " + CRLF 
CQUERY += "        CODEMP , " + CRLF 
CQUERY += "        RETORNA_DESCRI_GRUPOEMP ('"+cEmpresa+"',CODEMP),DAT_EV " + CRLF 
 
CQUERY += "  UNION ALL " + CRLF 
/// custo reembolso 
CQUERY += " SELECT NVL(TRIM(BA1_CODPLA),BA3_CODPLA)  PLANO , " + CRLF 
CQUERY += "        BD6_YNEVEN COD_EVENTO , " + CRLF 
CQUERY += "        ZZT_EVENTO NOME_EVENTO , " + CRLF 
CQUERY += "        COUNT(DISTINCT B44_OPEUSR||B44_CODEMP||B44_MATRIC||B44_TIPREG) QTDE , " + CRLF 
CQUERY += "        SUM(B45_QTDPRO) OCORRENCIA , " + CRLF 
CQUERY += "        SUM(B45_VLRGLO) GLOSADO , " + CRLF 
CQUERY += "        SUM(B45_VLRPAG) VAL_APROV , " + CRLF  
CQUERY += "        0 VL_PARTICIPACAO , " + CRLF 
              
CQUERY += "        SIGA_TIPO_EXPOSICAO_ANS(B44_CODEMP,B44_MATRIC,B44_TIPREG,TO_DATE(TRIM(B44_DATPRO),'YYYYMMDD')) EXPOSICAO_ANS , " + CRLF 
CQUERY += "        RETORNA_DESC_GRUPO_PLANO ( TRIM(BI3_YGRPLA),'"+cEmpresa+"') GRUPO_PLANO , " + CRLF 
CQUERY += "        DECODE(B44_CODEMP,'0007',TRIM(BI3_NREDUZ)||' (SEPE)',BI3_NREDUZ) NOME_PLANO, " + CRLF  
CQUERY += "        ZZT_TPCUST , " + CRLF 
CQUERY += "        BD6_YPROJ PROJ, " + CRLF 
CQUERY += "        'REEMBOLSO' TIPO, " + CRLF 
CQUERY += "        (CASE WHEN (B45_ZZZCOD NOT IN('04','11','21','29','37','45','53','75','83','91','99','9H','9O','9S','9V','00','9Z','AA','AI', " + CRLF 
CQUERY += "                    'AQ','AY','B6','BE','BM','BU','C4','C8','CB','CG','CN','CU','D1','DD','DW','E5','ED','EZ','F0') " + CRLF  
CQUERY += "        AND ZZQ_TIPPRO<>'1'  ) " + CRLF 
CQUERY += "        THEN '2' " + CRLF  
CQUERY += "        ELSE '1' " + CRLF 
CQUERY += "        END  " + CRLF
CQUERY += "        ) BENEF, " + CRLF  
CQUERY += "        B44_CODEMP CODEMP, " + CRLF  
CQUERY += "        RETORNA_DESCRI_GRUPOEMP('"+cEmpresa+"',B44_CODEMP) NOME_EMP , " + CRLF  
CQUERY += "        TO_DATE(BD6_DATPRO,'YYYYMMDD') DATA_EV  " + CRLF

CQUERY += "   FROM  "+RetSqlName('B44')+ " C , "+RetSqlName('B45')+ " D , "+RetSqlName('SE1')+ " T , "+RetSqlName('BA1')+ " U , " + CRLF        
CQUERY += "         "+RetSqlName('BA3')+ " F, "+RetSqlName('ZZT')+ " ZZT, "+RetSqlName('BI3')+ " BI3, "+RetSqlName('BG9')+ " BG9 , " + CRLF    
CQUERY += "         "+RetSqlName('BD6')+ " BD6 , "+RetSqlName('ZZQ')+ " ZZQ, "+RetSqlName('BR8')+ " BR8 " + CRLF   
  
CQUERY += "       WHERE B45_FILIAL='" + xFilial('B45') + "' " + CRLF    
CQUERY += "         AND B44_FILIAL='" + xFilial('B44') + "' " + CRLF 
CQUERY += "         AND BI3_FILIAL='" + xFilial('BI3') + "' " + CRLF 
CQUERY += "         AND BA3_FILIAL='" + xFilial('BA3') + "' " + CRLF 
CQUERY += "         AND BA1_FILIAL='" + xFilial('BA1') + "' " + CRLF 
CQUERY += "         AND BG9_FILIAL='" + xFilial('BG9') + "' " + CRLF 
CQUERY += "         AND ZZT_FILIAL='" + xFilial('ZZT') + "' " + CRLF 
CQUERY += "         AND BD6_FILIAL='" + xFilial('BD6') + "' " + CRLF 
CQUERY += "         AND ZZQ_FILIAL='" + xFilial('ZZQ') + "' " + CRLF 
CQUERY += "         AND  E1_FILIAL='" + xFilial('SE1') + "' " + CRLF 
CQUERY += "         AND E1_PREFIXO='RLE'   " + CRLF 
CQUERY += "         AND B44_CODLDP=B45_CODLDP   " + CRLF 
CQUERY += "         AND B44_CODPEG=B45_CODPEG   " + CRLF 
CQUERY += "         AND B44_NUMAUT=B45_NUMAUT   " + CRLF 
CQUERY += "         AND B44_PREFIX =E1_PREFIXO   " + CRLF 
CQUERY += "         AND B44_NUM=E1_NUM   " + CRLF 
CQUERY += "         AND BA1_CODINT=BA3_CODINT   " + CRLF 
CQUERY += "         AND BA1_CODEMP=BA3_CODEMP   " + CRLF 
CQUERY += "         AND BA1_MATRIC=BA3_MATRIC   " + CRLF 
CQUERY += "         AND BA1_CODINT=B44_OPEUSR   " + CRLF 
CQUERY += "         AND BA1_CODEMP=B44_CODEMP   " + CRLF 
CQUERY += "         AND BA1_MATRIC=B44_MATRIC   " + CRLF 
CQUERY += "         AND BA1_TIPREG=B44_TIPREG   " + CRLF 
CQUERY += "         AND BI3_CODINT=BA1_CODINT   " + CRLF 
CQUERY += "         AND B44_OPEUSR=BG9_CODINT   " + CRLF 
CQUERY += "         AND B44_CODEMP=BG9_CODIGO   " + CRLF 
CQUERY += "         AND BR8_FILIAL='" + xFilial('BR8') + "' " + CRLF 
CQUERY += "         AND BD6_CODPAD=BR8_CODPAD   " + CRLF 
CQUERY += "         AND BD6_CODPRO=BR8_CODPSA   " + CRLF 
CQUERY += "         AND BR8.D_E_L_E_T_=' '   " + CRLF 
  
CQUERY += "         AND BI3_CODIGO=NVL(TRIM(BA1_CODPLA),BA3_CODPLA) " + CRLF   
 
//CQUERY += "         AND SUBSTR(E1_EMISSAO,1,6)='"+cCompet +"' " + CRLF   
CQUERY += "         AND SUBSTR(B44_YDTCON,1,6) BETWEEN '"+cCompet +"' AND '"+cCompet +"' " + CRLF
  
CQUERY += "         AND BD6_CODOPE='0001'   " + CRLF 
CQUERY += "         AND B45_CODLDP=BD6_CODLDP   " + CRLF 
CQUERY += "         AND B45_CODPEG=BD6_CODPEG   " + CRLF 
CQUERY += "         AND B45_NUMERO=BD6_NUMERO   " + CRLF 
CQUERY += "         AND B45_SEQUEN=BD6_SEQUEN   " + CRLF 
CQUERY += "         AND B45_CODPAD=BD6_CODPAD   " + CRLF 
CQUERY += "         AND B45_CODPRO=BD6_CODPRO   " + CRLF  
  
CQUERY += "         AND BD6_YNEVEN=ZZT_CODEV " + CRLF 
CQUERY += "         AND ZZQ_SEQUEN = B44_YCDPTC " + CRLF  
CQUERY += "         AND C.D_E_L_E_T_=' ' " + CRLF 
CQUERY += "         AND D.D_E_L_E_T_=' ' " + CRLF 
CQUERY += "         AND T.D_E_L_E_T_=' ' " + CRLF  
CQUERY += "         AND U.D_E_L_E_T_=' ' " + CRLF  
CQUERY += "         AND F.D_E_L_E_T_=' ' " + CRLF  
CQUERY += "         AND BI3.D_E_L_E_T_=' '  " + CRLF 
CQUERY += "         AND BG9.D_E_L_E_T_=' ' " + CRLF 
CQUERY += "         AND ZZT.D_E_L_E_T_=' ' " + CRLF  
CQUERY += "         AND ZZQ.D_E_L_E_T_=' ' " + CRLF 
CQUERY += "         AND BD6.D_E_L_E_T_=' ' " + CRLF 
  
CQUERY += "       GROUP BY " + CRLF 
CQUERY += "             NVL(TRIM(BA1_CODPLA),BA3_CODPLA) , " + CRLF 
CQUERY += "             RETORNA_DESC_GRUPO_PLANO ( TRIM(BI3_YGRPLA),'"+cEmpresa+"') , " + CRLF 
CQUERY += "             DECODE(B44_CODEMP,'0007',TRIM(BI3_NREDUZ)||' (SEPE)',BI3_NREDUZ), " + CRLF 
CQUERY += "             SIGA_TIPO_EXPOSICAO_ANS(B44_CODEMP,B44_MATRIC,B44_TIPREG,TO_DATE(TRIM(B44_DATPRO),'YYYYMMDD')),B44_ANOAUT,B44_MESAUT, " + CRLF 
CQUERY += "             ZZT_EVENTO,ZZT_TPCUST , " + CRLF  
CQUERY += "             BD6_YNEVEN, " + CRLF 
CQUERY += "             BD6_YPROJ, " + CRLF 
CQUERY += "            (CASE WHEN (B45_ZZZCOD NOT IN('04','11','21','29','37','45','53','75','83','91','99','9H','9O','9S','9V','00','9Z','AA','AI', " + CRLF  
CQUERY += "                        'AQ','AY','B6','BE','BM','BU','C4','C8','CB','CG','CN','CU','D1','DD','DW','E5','ED','EZ','F0') " + CRLF  
CQUERY += "             AND ZZQ_TIPPRO<>'1' ) " + CRLF  
CQUERY += "             THEN '2'  ELSE '1' END)," + CRLF  
CQUERY += "             B44_CODEMP , " + CRLF 
CQUERY += "             RETORNA_DESCRI_GRUPOEMP('"+cEmpresa+"',B44_CODEMP),TO_DATE(BD6_DATPRO,'YYYYMMDD')) " + CRLF  
CQUERY += "  WHERE PROJ=' '  " + CRLF             
CQUERY += "  GROUP BY DAT_EV " + CRLF      
CQUERY += "  ORDER BY DAT_EV " + CRLF
   
   If Select(("TMP")) <> 0 
      ("TMP")->(DbCloseArea()) 
   Endif
    
    TCQuery cQuery Alias "TMP" New 
                                                                                           
    dbSelectArea("TMP")

    tmp->(dbGoTop())  

    FGrvPlan1()  

Return()               


Static Function AjustaSX1(cPerg)

Local aHelpPor := {}

PutSx1(cPerg,"01",OemToAnsi("Mes/Ano Custo?  ") 	        	,"","","mv_ch1","C",07,0,0,"G","","","","","mv_par01","","","","","","","","","","","","","","","","99/9999",aHelpPor,{},{})
PutSx1(cPerg,"02",OemToAnsi("Listar Diops / Auditoria ?")     	,"","","mv_ch2","N",01,0,0,"C","","","","","mv_par02","Diops","","","","Audit Guias","","","Audit Materias","","","Aud Reembolso","","","Aud Deb/Ced","","",{},{},{})   

Pergunte(cPerg,.T.)

Return 
/////////////
//Diops
/////////////
Static Function FGrvPlan1()

   cNomDadCab:= cEmp+' - 1 - Relatorio de Apoio ao DIOPs '   
   cNomPla   := cEmp+' - 1 - Relatorio de Apoio ao DIOPs ' 

   cComp     := SUBSTR(mv_par01,4,4) +'/'+ SUBSTR(mv_par01,1,2) 
   cNomeArq := "C:\TEMP\" + SUBSTR(mv_par01,1,2) + SUBSTR(mv_par01,4,4) + " - "+cNomDadCab+"_"+SubStr(DtoS(date()),7,2)+"_"+SubStr(DtoS(date()),5,2)+"_"+SubStr(DtoS(date()),1,4)+"_"+STRTRAN(TIME(),":","_")+".csv"

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
                                
   cMontaTxt := "Data Evento      ;"   
   cMontaTxt += "Vlr Apresentado  ;"  
   cMontaTxt += "Vlr Glosado      ;"
   cMontaTxt += "Vlr Pago         ;"
   cMontaTxt += "Vlr Coparticipado;"  		  		 		  		
		
   cMontaTxt += CRLF // Salto de linha para .csv (excel)
             
   FWrite(nHandle,cMontaTxt)
   
   tmp->(dbGoTop())                    
   
   While !(TMP->(Eof()))    

      cMontaTxt := substr(DtoS(tmp->DTEVENT),7,2)+'/'+substr(DtoS(tmp->DTEVENT),5,2)+'/'+substr(DtoS(tmp->DTEVENT),1,4)+";"

	  cMontaTxt += Transform(tmp->APRESENTADO  ,'@E  999,999,999.99') + ";"
	  cMontaTxt += Transform(tmp->GLOSADO      ,'@E  999,999,999.99') + ";"
	  cMontaTxt += Transform(tmp->PAGO         ,'@E  999,999,999.99') + ";" 
  	  cMontaTxt += Transform(tmp->COPART       ,'@E  999,999,999.99') + ";"
		  
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

     	MsgAlert("Relatorio salvo em: " + CRLF +cNomeArq1)
    
Return () 
 //////////////////
 // Auditoria 
 //////////////////
 //Guias
 //////////////////
 Static Function FGrvPlan2()

   cNomDadCab:= cEmp+' - 2 - ExtraÁ„o Guias para Auditoria '   
   cNomPla   := cEmp+' - 2 - ExtraÁ„o Guias para Auditoria '

   cComp     := SUBSTR(mv_par01,4,4) +'/'+ SUBSTR(mv_par01,1,2) 
   cNomeArq := "C:\TEMP\" + SUBSTR(mv_par01,1,2) + SUBSTR(mv_par01,4,4) + " - "+cNomDadCab+"_"+SubStr(DtoS(date()),7,2)+"_"+SubStr(DtoS(date()),5,2)+"_"+SubStr(DtoS(date()),1,4)+"_"+STRTRAN(TIME(),":","_")+".csv"

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
                                
   cMontaTxt := "LOTE REMESSA     ;"   
   cMontaTxt += "N∫ GUIA          ;"  
   cMontaTxt += "NOME DO PACIENTE ;"
   cMontaTxt += "FORNECEDOR       ;"
   cMontaTxt += "PF/PJ            ;"  	
   
   cMontaTxt += "REFER	          ;" 
   cMontaTxt += "OPEUSR	          ;" 
   cMontaTxt += "CODEMP	          ;" 
   cMontaTxt += "MATRIC	          ;" 
   cMontaTxt += "TIPREG	          ;" 
   cMontaTxt += "DIGITO	          ;" 
   cMontaTxt += "PLANO	          ;" 
   cMontaTxt += "COD_EVENTO	      ;" 
   cMontaTxt += "NOME_EVENTO	  ;" 
   cMontaTxt += "QTDE	          ;" 
   cMontaTxt += "OCORRENCIA	      ;"  
   cMontaTxt += "GLOSADO          ;" 	 
   cMontaTxt += "VL_APROV         ;" 	 
   cMontaTxt += "TAXA 	          ;" 
   cMontaTxt += "VL_PARTICIPACAO  ;" 	 
   cMontaTxt += "VL_INFORMADO 	  ;" 
   cMontaTxt += "GRUPO_PLANO	  ;" 
   cMontaTxt += "NOME_PLANO	      ;" 
   cMontaTxt += "TIPO	          ;" 
   cMontaTxt += "RDA	          ;" 
   cMontaTxt += "RDASOL	          ;" 
   cMontaTxt += "PROJ	          ;" 
   cMontaTxt += "DESPRO	          ;" 
   cMontaTxt += "COD_PROCED	      ;" 
   cMontaTxt += "TABELA	          ;" 
   cMontaTxt += "DATA	          ;" 
   cMontaTxt += "MATVID           ;"  
   cMontaTxt += "JURIDICO         ;"
	  		 		  		
		
   cMontaTxt += CRLF // Salto de linha para .csv (excel)
             
   FWrite(nHandle,cMontaTxt)
   
   tmp->(dbGoTop())                    
   
   While !(TMP->(Eof()))   
	    cMontaTxt :=  ' ' +";"     
	    cMontaTxt += TRIM(tmp->numimp) +";"
	    cMontaTxt += TRIM(tmp->USUARIO)  +";"
	    cMontaTxt += TRIM(tmp->Fornecedor)   +";"
	    cMontaTxt += TRIM(tmp->tpessoa) +";"
	    cMontaTxt += TRIM(tmp->REFER) +";"
	    cMontaTxt += TRIM(tmp->OPEUSR) +";"
	    cMontaTxt += TRIM(tmp->CODEMP) +";"
	    cMontaTxt += TRIM(tmp->MATRIC) +";"
	    cMontaTxt += TRIM(tmp->TIPREG) +";"
	    cMontaTxt += TRIM(tmp->DIGITO) +";"
	    cMontaTxt += TRIM(tmp->PLANO) +";"
	    cMontaTxt += Transform(tmp->COD_EVENTO,'@E  999') +";"
	    cMontaTxt += TRIM(tmp->NOME_EVENTO) +";"
	    cMontaTxt += Transform(tmp->QTDE ,'@E  99,999') + ";"
	    cMontaTxt += Transform(tmp->OCORRENCIA ,'@E  99')+";"
	    cMontaTxt += Transform(tmp->GLOSADO ,'@E  999,999,999.99') + ";"
	    cMontaTxt += Transform(tmp->VL_APROV ,'@E  999,999,999.99') + ";"
	    cMontaTxt += Transform(tmp->TAXA,'@E  99')  +";"
	    cMontaTxt += Transform(tmp->VL_PARTICIPACAO ,'@E  999,999,999.99') + ";"
	    cMontaTxt += Transform(tmp->VL_INFORMADO ,'@E  999,999,999.99') + ";"
	    cMontaTxt += TRIM(tmp->GRUPO_PLANO) +";"
	    cMontaTxt += TRIM(tmp->NOME_PLANO) +";"
	    cMontaTxt += TRIM(tmp->TIPO)  +";"
	    cMontaTxt += TRIM(tmp->RDA) +";"
	    cMontaTxt += TRIM(tmp->RDASOL) +";"
	    cMontaTxt += TRIM(tmp->PROJ) +";"
	    cMontaTxt += TRIM(tmp->DESPRO) +";"
	    cMontaTxt += TRIM(tmp->COD_PROCED) +";"
	    cMontaTxt += TRIM(tmp->TABELA) +";"
	    cMontaTxt += substr(tmp->DATA,7,2)+'/'+ substr(tmp->DATA,5,2)+'/'+substr(tmp->DATA,1,4)  +";"
	    cMontaTxt += TRIM(tmp->MATVID)  +";" 
	    cMontaTxt += TRIM(tmp->jurid)  +";" 
	    
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

     	MsgAlert("Relatorio salvo em: " + CRLF +cNomeArq1)
    
Return ()         
 //////////////////
 // Auditoria 
 //////////////////
 //Materias
 //////////////////
 Static Function FGrvPlan3()    
 
   cNomDadCab:= cEmp+' - 3 - ExtraÁ„o Materiais para Auditoria '   
   cNomPla   := cEmp+' - 3 - ExtraÁ„o Materiais para Auditoria '

   cComp     := SUBSTR(mv_par01,4,4) +'/'+ SUBSTR(mv_par01,1,2) 
   cNomeArq := "C:\TEMP\" + SUBSTR(mv_par01,1,2) + SUBSTR(mv_par01,4,4) + " - "+cNomDadCab+"_"+SubStr(DtoS(date()),7,2)+"_"+SubStr(DtoS(date()),5,2)+"_"+SubStr(DtoS(date()),1,4)+"_"+STRTRAN(TIME(),":","_")+".csv"

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
                                   
   cMontaTxt := "LOTE REMESSA     ;"   
   cMontaTxt += "N∫ GUIA          ;"  
   cMontaTxt += "NOME DO PACIENTE ;"
   cMontaTxt += "FORNECEDOR       ;"
   cMontaTxt += "PF/PJ            ;"  	
   
   cMontaTxt += "REFER	          ;" 
   cMontaTxt += "OPEUSR	          ;" 
   cMontaTxt += "CODEMP	          ;" 
   cMontaTxt += "MATRIC	          ;" 
   cMontaTxt += "TIPREG	          ;" 
   cMontaTxt += "DIGITO	          ;" 
   cMontaTxt += "PLANO	          ;" 
   cMontaTxt += "COD_EVENTO	      ;" 
   cMontaTxt += "NOME_EVENTO	  ;" 
   cMontaTxt += "QTDE	          ;" 
   cMontaTxt += "OCORRENCIA	      ;"  
   cMontaTxt += "GLOSADO          ;" 	 
   cMontaTxt += "VL_APROV         ;" 	 
   cMontaTxt += "TAXA 	          ;" 
   cMontaTxt += "VL_PARTICIPACAO  ;" 	 
   cMontaTxt += "VL_INFORMADO 	  ;" 
   cMontaTxt += "GRUPO_PLANO	  ;" 
   cMontaTxt += "NOME_PLANO	      ;" 
   cMontaTxt += "TIPO	          ;" 
   cMontaTxt += "RDA	          ;" 
   cMontaTxt += "RDASOL	          ;" 
   cMontaTxt += "PROJ	          ;" 
   cMontaTxt += "DESPRO	          ;" 
   cMontaTxt += "COD_PROCED	      ;" 
   cMontaTxt += "TABELA	          ;" 
   cMontaTxt += "DATA	          ;" 
   cMontaTxt += "MATVID           ;"
   cMontaTxt += "JURIDICO         ;" 
		
   cMontaTxt += CRLF // Salto de linha para .csv (excel)
             
   FWrite(nHandle,cMontaTxt)
   
   tmp->(dbGoTop())                    
   
   While !(TMP->(Eof()))   
	    cMontaTxt :=  ' ' +";"     
	    cMontaTxt +=tmp->numimp +";"
	    cMontaTxt += tmp->USUARIO  +";"
	    cMontaTxt += tmp->Fornecedor   +";"
	    cMontaTxt += tmp->tpessoa    +";"   
	    cMontaTxt += tmp->REFER +";"
	    cMontaTxt += tmp->OPEUSR +";"
	    cMontaTxt += tmp->CODEMP +";"
	    cMontaTxt += tmp->MATRIC +";"
	    cMontaTxt += tmp->TIPREG +";"
	    cMontaTxt += tmp->DIGITO +";"
	    cMontaTxt += tmp->PLANO +";"
	    cMontaTxt += Transform(tmp->COD_EVENTO,'@E  999') +";"
	    cMontaTxt += tmp->NOME_EVENTO +";"
	    cMontaTxt += Transform(tmp->QTDE ,'@E  99,999') + ";"
	    cMontaTxt += Transform(tmp->OCORRENCIA ,'@E  99')+";"
	    cMontaTxt += Transform(tmp->GLOSADO ,'@E  999,999,999.99') + ";"
	    cMontaTxt += Transform(tmp->VL_APROV ,'@E  999,999,999.99') + ";"
	    cMontaTxt += Transform(tmp->TAXA,'@E  99')  +";"
	    cMontaTxt += Transform(tmp->VL_PARTICIPACAO ,'@E  999,999,999.99') + ";"
	    cMontaTxt += Transform(tmp->VL_INFORMADO ,'@E  999,999,999.99') + ";"
	    cMontaTxt += tmp->GRUPO_PLANO +";"
	    cMontaTxt += tmp->NOME_PLANO +";"
	    cMontaTxt += tmp->TIPO  +";"
	    cMontaTxt += tmp->RDA +";"
	    cMontaTxt += tmp->RDASOL +";"
	    cMontaTxt += tmp->PROJ +";"
	    cMontaTxt += tmp->DESPRO +";"
	    cMontaTxt += tmp->COD_PROCED +";"
	    cMontaTxt += tmp->TABELA +";"
	    cMontaTxt += substr(tmp->DATA,7,2)+'/'+ substr(tmp->DATA,5,2)+'/'+substr(tmp->DATA,1,4)  +";"
	    cMontaTxt += tmp->MATVID  +";"      
  	    cMontaTxt += TRIM(tmp->jurid)  +";" 
	    
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

  	MsgAlert("Relatorio salvo em: " + CRLF +cNomeArq1)
   
Return ()          

//////////////////
 // Auditoria 
 //////////////////
 //Reembolso 
 //////////////////
 Static Function FGrvPlan4()    

   cNomDadCab:= cEmp+' - 4 - ExtraÁ„o Reembolso para Auditoria '   
   cNomPla   := cEmp+' - 4 - ExtraÁ„o Reembolso para Auditoria '
 

    
   cComp     := SUBSTR(mv_par01,4,4) +'/'+ SUBSTR(mv_par01,1,2) 
   cNomeArq := "C:\TEMP\" + SUBSTR(mv_par01,1,2) + SUBSTR(mv_par01,4,4) + " - "+cNomDadCab+"_"+SubStr(DtoS(date()),7,2)+"_"+SubStr(DtoS(date()),5,2)+"_"+SubStr(DtoS(date()),1,4)+"_"+STRTRAN(TIME(),":","_")+".csv"

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
                                   
   cMontaTxt := "LOTE REMESSA     ;"   
   cMontaTxt += "N∫ GUIA          ;"  
   cMontaTxt += "NOME DO PACIENTE ;"
   cMontaTxt += "FORNECEDOR       ;"
   cMontaTxt += "PF/PJ            ;"  	
   
   cMontaTxt += "REFER	          ;" 
   cMontaTxt += "OPEUSR	          ;" 
   cMontaTxt += "CODEMP	          ;" 
   cMontaTxt += "MATRIC	          ;" 
   cMontaTxt += "TIPREG	          ;" 
   cMontaTxt += "DIGITO	          ;" 
   cMontaTxt += "PLANO	          ;" 
   cMontaTxt += "COD_EVENTO	      ;" 
   cMontaTxt += "NOME_EVENTO	  ;" 
   cMontaTxt += "QTDE	          ;" 
   cMontaTxt += "OCORRENCIA	      ;"  
   cMontaTxt += "GLOSADO          ;" 	 
   cMontaTxt += "VL_APROV         ;" 	 
   cMontaTxt += "TAXA 	          ;" 
   cMontaTxt += "VL_PARTICIPACAO  ;" 	 
   cMontaTxt += "VL_INFORMADO 	  ;" 
   cMontaTxt += "GRUPO_PLANO	  ;" 
   cMontaTxt += "NOME_PLANO	      ;" 
   cMontaTxt += "TIPO	          ;" 
   cMontaTxt += "RDA	          ;" 
   cMontaTxt += "RDASOL	          ;" 
   cMontaTxt += "PROJ	          ;" 
   cMontaTxt += "DESPRO	          ;" 
   cMontaTxt += "COD_PROCED	      ;" 
   cMontaTxt += "TABELA	          ;" 
   cMontaTxt += "DATA	          ;" 
   cMontaTxt += "MATVID           ;"      
   cMontaTxt += "EXTRAROL         ;"  
   cMontaTxt += "JURIDICO         ;"   
   
		
   cMontaTxt += CRLF // Salto de linha para .csv (excel)
             
   FWrite(nHandle,cMontaTxt)
   
   tmp->(dbGoTop())                    
   
   While !(TMP->(Eof()))   
	    cMontaTxt :=  ' ' +";"     
	    cMontaTxt += tmp->numimp +";"
	    cMontaTxt += tmp->USUARIO  +";"
	    cMontaTxt += tmp->Fornecedor   +";"
	    cMontaTxt += tmp->tpessoa    +";"   
	    cMontaTxt += tmp->REFER +";"
	    cMontaTxt += tmp->OPEUSR +";"
	    cMontaTxt += tmp->CODEMP +";"
	    cMontaTxt += tmp->MATRIC +";"
	    cMontaTxt += tmp->TIPREG +";"
	    cMontaTxt += tmp->DIGITO +";"
	    cMontaTxt += tmp->PLANO +";"
	    cMontaTxt += Transform(tmp->COD_EVENTO,'@E  999') +";"
	    cMontaTxt += tmp->NOME_EVENTO +";"
	    cMontaTxt += Transform(tmp->QTDE ,'@E  99,999') + ";"
	    cMontaTxt += Transform(tmp->OCORRENCIA ,'@E  99')+";"
	    cMontaTxt += Transform(tmp->GLOSADO ,'@E  999,999,999.99') + ";"
	    cMontaTxt += Transform(tmp->VL_APROV ,'@E  999,999,999.99') + ";"
	    cMontaTxt += Transform(tmp->TAXA,'@E  99')  +";"
	    cMontaTxt += Transform(tmp->VL_PARTICIPACAO ,'@E  999,999,999.99') + ";"
	    cMontaTxt += Transform(tmp->VL_INFORMADO ,'@E  999,999,999.99') + ";"
	    cMontaTxt += tmp->GRUPO_PLANO +";"
	    cMontaTxt += tmp->NOME_PLANO +";"
	    cMontaTxt += tmp->TIPO  +";"
	    cMontaTxt += tmp->RDA +";"
	    cMontaTxt += tmp->RDASOL +";"
	    cMontaTxt += tmp->PROJ +";"
	    cMontaTxt += tmp->DESPRO +";"
	    cMontaTxt += tmp->COD_PROCED +";"
	    cMontaTxt += tmp->TABELA +";"
	    cMontaTxt += substr(tmp->DATA,7,2)+'/'+ substr(tmp->DATA,5,2)+'/'+substr(tmp->DATA,1,4)  +";"
	    cMontaTxt += tmp->MATVID  +";" 
	    cMontaTxt += tmp->Extrarol  +";"   
	    cMontaTxt += TRIM(tmp->jurid)  +";" 	    
	    
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

  	MsgAlert("Relatorio salvo em: " + CRLF +cNomeArq1)
   
Return ()                

//////////////////
 // Auditoria 
 //////////////////
 //deb/cre
 //////////////////
 Static Function FGrvPlan5()    
 
   cNomDadCab:= cEmp+' - 5 - ExtraÁ„o D_C para Auditoria '   
   cNomPla   := cEmp+' - 5 - ExtraÁ„o D_C para Auditoria '

   cComp     := SUBSTR(mv_par01,4,4) +'/'+ SUBSTR(mv_par01,1,2) 
   cNomeArq  := "C:\TEMP\" + SUBSTR(mv_par01,1,2) + SUBSTR(mv_par01,4,4) + " - "+cNomDadCab+"_"+SubStr(DtoS(date()),7,2)+"_"+SubStr(DtoS(date()),5,2)+"_"+SubStr(DtoS(date()),1,4)+"_"+STRTRAN(TIME(),":","_")+".csv"

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
                                   
   cMontaTxt := "LOTE REMESSA     ;"   
   cMontaTxt += "N∫ GUIA          ;"  
   cMontaTxt += "NOME DO PACIENTE ;"
   cMontaTxt += "FORNECEDOR       ;"
   cMontaTxt += "PF/PJ            ;"  	
   
   cMontaTxt += "REFER	          ;" 
   cMontaTxt += "OPEUSR	          ;" 
   cMontaTxt += "CODEMP	          ;" 
   cMontaTxt += "MATRIC	          ;" 
   cMontaTxt += "TIPREG	          ;" 
   cMontaTxt += "DIGITO	          ;" 
   cMontaTxt += "PLANO	          ;" 
   cMontaTxt += "COD_EVENTO	      ;" 
   cMontaTxt += "NOME_EVENTO	  ;" 
   cMontaTxt += "QTDE	          ;" 
   cMontaTxt += "OCORRENCIA	      ;"  
   cMontaTxt += "GLOSADO          ;" 	 
   cMontaTxt += "VL_APROV         ;" 	 
   cMontaTxt += "TAXA 	          ;" 
   cMontaTxt += "VL_PARTICIPACAO  ;" 	 
   cMontaTxt += "VL_INFORMADO 	  ;" 
   cMontaTxt += "GRUPO_PLANO	  ;" 
   cMontaTxt += "NOME_PLANO	      ;" 
   cMontaTxt += "TIPO	          ;" 
   cMontaTxt += "RDA	          ;" 
   cMontaTxt += "RDASOL	          ;" 
   cMontaTxt += "PROJ	          ;" 
   cMontaTxt += "DESPRO	          ;" 
   cMontaTxt += "COD_PROCED	      ;" 
   cMontaTxt += "TABELA	          ;" 
   cMontaTxt += "DATA	          ;" 
   cMontaTxt += "MATVID           ;" 
		
   cMontaTxt += CRLF // Salto de linha para .csv (excel)
             
   FWrite(nHandle,cMontaTxt)
   
   tmp->(dbGoTop())                    
   
   While !(TMP->(Eof()))   
	    cMontaTxt :=  ' ' +";"     
	    cMontaTxt += tmp->numimp +";"
	    cMontaTxt += tmp->USUARIO  +";"
	    cMontaTxt += tmp->Fornecedor   +";"
	    cMontaTxt += tmp->tpessoa    +";"   
	    cMontaTxt += tmp->REFER +";"
	    cMontaTxt += tmp->OPEUSR +";"
	    cMontaTxt += tmp->CODEMP +";"
	    cMontaTxt += tmp->MATRIC +";"
	    cMontaTxt += tmp->TIPREG +";"
	    cMontaTxt += tmp->DIGITO +";"
	    cMontaTxt += tmp->PLANO +";"
	    cMontaTxt += Transform(tmp->COD_EVENTO,'@E  999') +";"
	    cMontaTxt += tmp->NOME_EVENTO +";"
	    cMontaTxt += Transform(tmp->QTDE ,'@E  99,999') + ";"
	    cMontaTxt += Transform(tmp->OCORRENCIA ,'@E  99')+";"
	    cMontaTxt += Transform(tmp->GLOSADO ,'@E  999,999,999.99') + ";"
	    cMontaTxt += Transform(tmp->VL_APROV ,'@E  999,999,999.99') + ";"
	    cMontaTxt += Transform(tmp->TAXA,'@E  99')  +";"
	    cMontaTxt += Transform(tmp->VL_PARTICIPACAO ,'@E  999,999,999.99') + ";"
	    cMontaTxt += Transform(tmp->VL_INFORMADO ,'@E  999,999,999.99') + ";"
	    cMontaTxt += tmp->GRUPO_PLANO +";"
	    cMontaTxt += tmp->NOME_PLANO +";"
	    cMontaTxt += tmp->TIPO  +";"
	    cMontaTxt += tmp->RDA +";"
	    cMontaTxt += tmp->RDASOL +";"
	    cMontaTxt += tmp->PROJ +";"
	    cMontaTxt += tmp->DESPRO +";"
	    cMontaTxt += tmp->COD_PROCED +";"
	    cMontaTxt += tmp->TABELA +";"
	    cMontaTxt += substr(tmp->DATA,7,2)+'/'+ substr(tmp->DATA,5,2)+'/'+substr(tmp->DATA,1,4)  +";"
	    cMontaTxt += tmp->MATVID  +";" 
	    
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

  	MsgAlert("Relatorio salvo em: " + CRLF +cNomeArq1)
   
Return ()        

 
Static Function Processa2()   

	cQuery := "  SELECT /*+first_rows index_asc(BD7 BD70105)*/ " + CRLF
    cQuery += "         SUBSTR(BD7_NUMLOT,1,6) REFER, " + CRLF
    cQuery += "         BD6F.BD6_OPEUSR OPEUSR, " + CRLF
    cQuery += "         BD6F.BD6_CODEMP CODEMP, " + CRLF
    cQuery += "         BD6F.BD6_MATRIC MATRIC, " + CRLF
    cQuery += "         BD6F.BD6_TIPREG TIPREG, " + CRLF
    cQuery += "         BD6F.BD6_DIGITO DIGITO, " + CRLF
    cQuery += "         BD7_CODPLA PLANO, " + CRLF
    cQuery += "         BD6_YNEVEN COD_EVENTO, " + CRLF
    cQuery += "         ZZT_EVENTO NOME_EVENTO, " + CRLF
    cQuery += "         COUNT(DISTINCT BD6_CODEMP||BD6_MATRIC||BD6_TIPREG) QTDE, " + CRLF
    cQuery += "         SUM(BD6F.BD6_QTDPRO) OCORRENCIA, " + CRLF
    cQuery += "         SUM(BD6F.BD6_VLRGLO) GLOSADO, " + CRLF
    cQuery += "         SUM(BD7F.VLRPAG) VL_APROV, " + CRLF
    cQuery += "         0 TAXA , " + CRLF
    cQuery += "         SUM(DECODE(BD6F.BD6_BLOCPA,'1',0,DECODE(SIGN(BD6F.BD6_VLRTPF),-1,0,DECODE( BD6_CODEMP,'0004',0,'0009',0,BD6F.BD6_VLRTPF)))) VL_PARTICIPACAO, " + CRLF
    cQuery += "         SUM(BD6_VLRBPR) VL_INFORMADO, " + CRLF
    cQuery += "         0 VL_RECUPERADO, " + CRLF
    cQuery += "         0 VL_PROTOCOLADO, " + CRLF
    cQuery += "         0 VL_TOTAL_PROT, " + CRLF
    cQuery += "         EXPOS EXPOSICAO_ANS , " + CRLF
    cQuery += "         DECODE(TRIM(BI3_YGRPLA),'4','MATER','2','AFINIDADE','3','EMPRESARIAL','1', 'ADMINISTRATIVO') GRUPO_PLANO, " + CRLF
    cQuery += "         DECODE(BD6_CODEMP,'0007',TRIM(BI3_NREDUZ)||' (SEPE)',BI3_NREDUZ) NOME_PLANO, " + CRLF
    cQuery += "         0 VAL_ADIANT , " + CRLF
    cQuery += "         ZZT_TPCUST , " + CRLF
    cQuery += "         'CONTA' TIPO , " + CRLF
    cQuery += "         BD6_CODRDA RDA, " + CRLF
    cQuery += "         NVL(Trim(PLS_RETORNA_RDA_SOLIC ('"+cEmpresa+"',BD6F.BD6_CDPFSO )),'999999') RDASOL, " + CRLF
    cQuery += "         BD6_YPROJ PROJ, " + CRLF
    cQuery += "         BD6_DESPRO DESPRO, " + CRLF
    cQuery += "         BD6_CODPRO COD_PROCED, " + CRLF
    cQuery += "         BD6_CODPAD TABELA, " + CRLF
    cQuery += "         BD6_DATPRO DATA, " + CRLF
    cQuery += "         apropriacao_custo, " + CRLF
    cQuery += "         retorna_evento_cab ( bd6_opeusr,bd6_codldp, bd6_codpeg,bd6_numero,bd6_orimov, bd6_codpad,bd6_codpro,'"+cEmpresa+"') EVENTONOVO, " + CRLF
   // cQuery += "         RETORNA_EVENTO_EVOL ( BD6_OPEUSR,BD6_CODLDP, BD6_CODPEG,BD6_NUMERO,BD6_ORIMOV ,BD6_CODPAD,BD6_CODPRO,BD6_MATVID,'"+cEmpresa+"') EVENTOANT, " + CRLF
    cQuery += "         BD6_MATVID MATVID ,  " + CRLF
    cQuery += "         bd6f.bd6_numimp numimp ,  " + CRLF
    cQuery += "         bd6f.BD6_OPEUSR ||'.'||bd6f.BD6_CODEMP ||'.'||bd6f.BD6_MATRIC ||'.'||bd6f.BD6_TIPREG ||'.'||bd6f.BD6_DIGITO ||'-'||bd6f.bd6_nomusr USUARIO , " + CRLF
    cQuery += "         DECODE(BAU_TIPPE,'F' ,'Fisica' , 'Juridica') tpessoa ,  " + CRLF
    cQuery += "         a2_cod ||'-'|| a2_nome Fornecedor  ," + CRLF          
 
    cQuery += "         decode(trim(BD6F.bd6_yproju),NULL, 'N' ,'S') jurid  "+CRLF 
       
    cQuery += "  FROM ( SELECT BD7.BD7_FILIAL, " + CRLF
    cQuery += "                BD7.BD7_CODPLA,  " + CRLF
    cQuery += "                SIGA_TIPO_EXPOSICAO_ANS(BD7_CODEMP,BD7_MATRIC,BD7_TIPREG,To_Date(Trim( BD7_DATPRO),'YYYYMMDD')) EXPOS, " + CRLF
    cQuery += "                BD7.BD7_OPELOT, " + CRLF
    cQuery += "                BD7.BD7_NUMLOT, " + CRLF
    cQuery += "                BD7.BD7_CODOPE, " + CRLF
    cQuery += "                BD7.BD7_CODLDP, " + CRLF
    cQuery += "                BD7.BD7_CODPEG, " + CRLF
    cQuery += "                BD7.BD7_NUMERO, " + CRLF
    cQuery += "                BD7.BD7_ORIMOV, " + CRLF
    cQuery += "                BD7_CODPRO, " + CRLF
    cQuery += "                BD7.BD7_SEQUEN, " + CRLF
    cQuery += "                APROPRIACAO_CUSTO ('3',SUBSTR(BD7_NUMLOT,1,4),SUBSTR(BD7_NUMLOT,5,2), BD7_OPELOT,BD7_NUMLOT,BD7_CODRDA) APROPRIACAO_CUSTO, " + CRLF
    cQuery += "                SUM(BD7.BD7_VLRPAG) AS VLRPAG " + CRLF
    cQuery += "           FROM "+RetSqlName('BD7')+ " BD7 " + CRLF  
    cQuery += "          WHERE BD7.BD7_FILIAL='" + xFilial('BD7') + "' " + CRLF                
    cQuery += "            AND BD7.BD7_CODOPE   = '0001' " + CRLF
    cQuery += "            AND BD7.BD7_SITUAC   = '1' " + CRLF
    cQuery += "            AND BD7.BD7_FASE     = '4' " //--TODAS AS GUIAS PAGAS
    cQuery += "            AND BD7.BD7_BLOPAG  <> '1' " + CRLF
    cQuery += "            AND bd7_numlot    like  '"+cCompet +"'||'%' "+ CRLF 
    cQuery += "            AND BD7.D_E_L_E_T_   = ' ' " + CRLF
    cQuery += "          GROUP BY BD7_FILIAL, " + CRLF
    cQuery += "                   BD7_CODPLA, " + CRLF
    cQuery += "                   BD7.BD7_OPELOT, " + CRLF
    cQuery += "                   BD7.BD7_NUMLOT, " + CRLF
    cQuery += "                   BD7_CODPRO, " + CRLF
    cQuery += "                   SIGA_TIPO_EXPOSICAO_ANS(BD7_CODEMP,BD7_MATRIC,BD7_TIPREG,To_Date(Trim( BD7_DATPRO),'YYYYMMDD')), " + CRLF
    cQuery += "                   BD7_FILIAL, " + CRLF
    cQuery += "                   BD7_CODOPE, " + CRLF
    cQuery += "                   BD7_CODLDP, " + CRLF
    cQuery += "                   BD7_CODPEG, " + CRLF
    cQuery += "                   BD7_NUMERO, " + CRLF
    cQuery += "                   BD7_ORIMOV, " + CRLF
    cQuery += "                   BD7_SEQUEN, " + CRLF
    cQuery += "                   APROPRIACAO_CUSTO ('3',SUBSTR(BD7_NUMLOT,1,4),SUBSTR(BD7_NUMLOT,5,2), BD7_OPELOT,BD7_NUMLOT,BD7_CODRDA) " + CRLF
    cQuery += "       ) BD7F ,  " + CRLF      
    cQuery += "        "+RetSqlName('BD6')+ " BD6F , "+RetSqlName('BI3')+ " BI3 ,"+RetSqlName('ZZT')+ " ZZT , " + CRLF
    cQuery += "        "+RetSqlName('BAU')+ " BAU  , "+RetSqlName('SA2')+ " SA2   " + CRLF    
    
    CQUERY += "         WHERE ZZT_FILIAL='" + xFilial('ZZT') + "' " + CRLF   
    CQUERY += "           AND BI3_FILIAL='" + xFilial('BI3') + "' " + CRLF   
    CQUERY += "           AND BAU_FILIAL='" + xFilial('BAU') + "'  AND BAU.D_e_l_e_t_ = ' ' AND BAU.R_e_c_d_e_l_ = 0 " + CRLF   
    CQUERY += "           AND  A2_FILIAL='" + xFilial('SA2') + "'  AND SA2.D_e_l_e_t_ = ' ' AND BAU_codsa2 = a2_cod " + CRLF
    CQUERY += "           AND BI3_FILIAL='" + xFilial('BI3') + "' " + CRLF   

    cQuery += "            AND BAU_codIGO = BD6F.BD6_CODRDA " + CRLF
    cQuery += "            AND BD7F.BD7_FILIAL = BD6F.BD6_FILIAL " + CRLF
    cQuery += "            AND BD7F.BD7_CODOPE = BD6F.BD6_CODOPE " + CRLF 
    cQuery += "            AND BD7F.BD7_CODLDP = BD6F.BD6_CODLDP " + CRLF
    cQuery += "            AND BD7F.BD7_CODPEG = BD6F.BD6_CODPEG " + CRLF
    cQuery += "            AND BD7F.BD7_NUMERO = BD6F.BD6_NUMERO " + CRLF
    cQuery += "            AND BD7F.BD7_ORIMOV = BD6F.BD6_ORIMOV " + CRLF
    cQuery += "            AND BD7F.BD7_SEQUEN = BD6F.BD6_SEQUEN " + CRLF
    cQuery += "            AND BD7F.BD7_CODPRO = BD6F.BD6_CODPRO " + CRLF
//    cQuery += "            AND BD6F.R_E_C_N_O_ NOT IN
//    cQuery += "            ( SELECT BD6RECNO FROM CUSTO_ADM_201210 ) --motta 28122012
//    cQuery += "                 AND BD6F.R_E_C_N_O_ NOT IN    
//    cQuery += "                   ( SELECT BD6RECNO FROM CUSTO_ADM_201211 )
    cQuery += "            AND BI3_FILIAL      =BD7_FILIAL " + CRLF
    cQuery += "            AND BI3_CODINT      =BD7_CODOPE " + CRLF
    cQuery += "            AND BI3_CODIGO      =BD7_CODPLA " + CRLF
    cQuery += "            AND BD6_YNEVEN      =ZZT_CODEV  " + CRLF
    cQuery += "            AND BD6F.D_E_L_E_T_ = ' ' " + CRLF
    cQuery += "            AND BI3.D_E_L_E_T_  = ' ' " + CRLF
    cQuery += "            AND ZZT.D_E_L_E_T_  = ' ' " + CRLF
    cQuery += "          GROUP BY SUBSTR(BD7_NUMLOT,1,6) , " + CRLF
    cQuery += "                EXPOS , " + CRLF
    cQuery += "                BD6F.BD6_OPEUSR , " + CRLF
    cQuery += "                BD6F.BD6_CODEMP , " + CRLF
    cQuery += "                BD6F.BD6_MATRIC , " + CRLF
    cQuery += "                BD6F.BD6_TIPREG , " + CRLF
    cQuery += "                BD6F.BD6_DIGITO , " + CRLF
    cQuery += "                BD7_CODPLA , " + CRLF
    cQuery += "                TRIM(BI3_YGRPLA) , " + CRLF
    cQuery += "                DECODE(BD6_CODEMP,'0007',Trim(BI3_NREDUZ)||' (SEPE)',BI3_NREDUZ) , " + CRLF
    cQuery += "                BD6_YNEVEN , " + CRLF
    cQuery += "                ZZT_EVENTO , " + CRLF
    cQuery += "                ZZT_TPCUST , " + CRLF
    cQuery += "                BD6_CODRDA , " + CRLF
    cQuery += "                NVL(Trim(PLS_RETORNA_RDA_SOLIC ('"+cEmpresa+"',BD6F.BD6_CDPFSO )),'999999') , " + CRLF
    cQuery += "                BD6_YPROJ , " + CRLF
    cQuery += "                BD6_CODPRO , " + CRLF
    cQuery += "                BD6_CODPAD , " + CRLF
    cQuery += "                BD6_DATPRO , " + CRLF 
    cQuery += "                BD6_DESPRO , " + CRLF
    cQuery += "                APROPRIACAO_CUSTO , " + CRLF
    cQuery += "                retorna_evento_cab ( bd6_opeusr,bd6_codldp, bd6_codpeg,bd6_numero,bd6_orimov, bd6_codpad,bd6_codpro,'"+cEmpresa+"'), " + CRLF
  //  cQuery += "                RETORNA_EVENTO_EVOL ( BD6_OPEUSR,BD6_CODLDP, BD6_CODPEG,BD6_NUMERO,BD6_ORIMOV ,BD6_CODPAD,BD6_CODPRO,BD6_MATVID,'"+cEmpresa+"'), " + CRLF
    cQuery += "                BD6_MATVID , " + CRLF
    cQuery += "                bd6f.bd6_numimp , " + CRLF
    cQuery += "                bd6f.BD6_OPEUSR ||'.'||bd6f.BD6_CODEMP ||'.'||bd6f.BD6_MATRIC ||'.'||bd6f.BD6_TIPREG ||'.'||bd6f.BD6_DIGITO ||'-'||bd6f.bd6_nomusr , " + CRLF
    cQuery += "                DECODE(BAU_TIPPE,'F' ,'Fisica' , 'Juridica') ,  " + CRLF
    cQuery += "                a2_cod ||'-'|| a2_nome  , " + CRLF
                                                                                    
    cQuery += "         decode(trim(BD6F.bd6_yproju),NULL, 'N' ,'S') "+CRLF 

 If Select(("TMP")) <> 0 
      ("TMP")->(DbCloseArea()) 
   Endif
    
    TCQuery cQuery Alias "TMP" New 
                                                                                           
    dbSelectArea("TMP")

    tmp->(dbGoTop())  

    FGrvPlan2()  

Return ()     

Static Function Processa3()   

	cQuery := "  SELECT SUBSTR(F1_EMISSAO,1,6) REFER, " + CRLF
	cQuery += "         OPEUSR, " + CRLF
	cQuery += "         CODEMP, " + CRLF
	cQuery += "         MATRIC, " + CRLF
	cQuery += "         TIPREG, " + CRLF
	cQuery += "         DIGITO, " + CRLF
	cQuery += "         PLANO,  " + CRLF
	cQuery += "         COD_EVENTO, " + CRLF
	cQuery += "         NOME_EVENTO, " + CRLF
	cQuery += "         SUM(QTDE) QTDE, " + CRLF
	cQuery += "         SUM(OCORRENCIA) OCORRENCIA, " + CRLF
	cQuery += "         SUM(GLOSADO) GLOSADO, " + CRLF
	cQuery += "         SUM(VL_APROV) VL_APROV, " + CRLF
	cQuery += "         0 TAXA , " + CRLF
	cQuery += "         SUM(VL_PARTICIPACAO) VL_PARTICIPACAO, " + CRLF
	cQuery += "         0 VL_INFORMADO, " + CRLF
	cQuery += "         0 VL_RECUPERADO, " + CRLF
	cQuery += "         0 VL_PROTOCOLADO, " + CRLF
	cQuery += "         0 VL_TOTAL_PROT, " + CRLF
	cQuery += "         EXPOSICAO_ANS , " + CRLF
	cQuery += "         GRUPO_PLANO, " + CRLF
	cQuery += "         NOME_PLANO, " + CRLF
	cQuery += "         0 VAL_ADIANT , " + CRLF
	cQuery += "         ZZT_TPCUST , " + CRLF
	cQuery += "         'Material' Tipo , " + CRLF
	cQuery += "         RDA, " + CRLF
	cQuery += "         RDASOL, " + CRLF
	cQuery += "         PROJ, " + CRLF
	cQuery += "         DESPRO, " + CRLF
	cQuery += "         COD_PROCED, " + CRLF
   	cQuery += "         TABELA, " + CRLF
	cQuery += "         DATA, " + CRLF
	cQuery += "         APROPRIACAO_CUSTO, " + CRLF
	cQuery += "         EVENTONOVO, " + CRLF
//	cQuery += "         EVENTOANT, " + CRLF
	cQuery += "         MATVID    , " + CRLF
	cQuery += "         numimp , " + CRLF
	cQuery += "         USUARIO , " + CRLF
	cQuery += "         tpessoa ,  " + CRLF
	cQuery += "         Fornecedor ," + CRLF	                              
	cQuery += "         jurid " + CRLF
	
	cQuery += "         FROM  ( " + CRLF
	cQuery += "                 SELECT F1_EMISSAO, " + CRLF
	cQuery += "                        BD6_OPEUSR OPEUSR, " + CRLF
	cQuery += "                        BD6_CODEMP CODEMP, " + CRLF
	cQuery += "                        BD6_MATRIC MATRIC, " + CRLF
	cQuery += "                        BD6_TIPREG TIPREG, " + CRLF
	cQuery += "                        BD6_DIGITO DIGITO, " + CRLF
	cQuery += "                        BD6_CODPLA PLANO,  " + CRLF
	cQuery += "                        BD6_YNEVEN Cod_Evento, " + CRLF
	cQuery += "                        ZZT_EVENTO Nome_Evento, " + CRLF
	cQuery += "                        COUNT(DISTINCT BD6_CODEMP||BD6_MATRIC||BD6_TIPREG) QTDE, " + CRLF
	cQuery += "                        SUM(D1_QUANT) Ocorrencia, " + CRLF
	cQuery += "                        SUM(BD6_VLRGLO) Glosado,  " + CRLF
	cQuery += "                        SUM(D1_TOTAL)-SUM(D1_VALDESC) Vl_Aprov," + CRLF
	cQuery += "                        0 Taxa , " + CRLF
	cQuery += "                        0 Vl_Participacao , " + CRLF
	cQuery += "                        0 Vl_Informado, " + CRLF
	cQuery += "                        0 Vl_Recuperado, " + CRLF
	cQuery += "                        0 Vl_Protocolado, " + CRLF
	cQuery += "                        0 Vl_Total_Prot , " + CRLF
	cQuery += "                        SIGA_TIPO_EXPOSICAO_ANS(BD6_CODEMP,BD6_MATRIC,BD6_TIPREG,To_Date(Trim(BD6_DATPRO),'YYYYMMDD')) EXPOSICAO_ANS , " + CRLF
	cQuery += "                        RETORNA_DESC_GRUPO_PLANO ( TRIM(BI3_YGRPLA),'"+cEmpresa+"') GRUPO_PLANO, " + CRLF
	cQuery += "                        DECODE(BD6_CODEMP,'0007',Trim(BI3_NREDUZ) ||' (SEPE)',BI3_NREDUZ) NOME_PLANO, " + CRLF
	cQuery += "                        0 Val_adiant , " + CRLF
	cQuery += "                        ZZT_TPCUST , " + CRLF
	cQuery += "                        BD6_CODRDA RDA , " + CRLF
	cQuery += "                        NVL(Trim(PLS_RETORNA_RDA_SOLIC ('"+cEmpresa+"',BD6_CDPFSO )),'999999') RDASOL, " + CRLF
	cQuery += "                        BD6_YPROJ PROJ, " + CRLF
	cQuery += "                        Trim(BD6_DESPRO) DESPRO, " + CRLF
	cQuery += "                        BD6_CODPRO COD_PROCED, " + CRLF
	cQuery += "                        BD6_CODPAD TABELA, " + CRLF
	cQuery += "                        BD6_DATPRO DATA, " + CRLF
	cQuery += "                        apropriacao_custo_opme ('3',substr(f1_emissao,1,4),substr(f1_emissao,5,2),f1_fornece,f1_loja,f1_serie,f1_doc) apropriacao_custo, " + CRLF
	cQuery += "                        retorna_evento_cab ( bd6_opeusr,bd6_codldp, bd6_codpeg,bd6_numero,bd6_orimov,bd6_codpad,bd6_codpro,'"+cEmpresa+"' ) EVENTONOVO, " + CRLF
//	cQuery += "                        RETORNA_EVENTO_EVOL ( BD6_OPEUSR,BD6_CODLDP, BD6_CODPEG,BD6_NUMERO,BD6_ORIMOV,BD6_CODPAD,BD6_CODPRO,BD6_MATVID,'"+cEmpresa+"' ) EVENTOANT, " + CRLF
	cQuery += "                        BD6_MATVID MATVID , " + CRLF
      
	cQuery += "                        bd6_numimp numimp , " + CRLF
	cQuery += "                        BD6_OPEUSR ||'.'||BD6_CODEMP ||'.'||BD6_MATRIC ||'.'||BD6_TIPREG ||'.'||BD6_DIGITO ||'-'||bd6_nomusr USUARIO , " + CRLF
	cQuery += "                        DECODE(BAU_TIPPE,'F' ,'Fisica' , 'Juridica') tpessoa , " + CRLF
	cQuery += "                        a2_cod ||'-'|| a2_nome Fornecedor , " + CRLF
	
    cQuery += "                        decode(trim(bd6_yproju),NULL, 'N' ,'S') jurid  "+CRLF 
      
	cQuery += "                   FROM "+RetSqlName('B19')+ " B19 , " + CRLF
	cQuery += "                        "+RetSqlName('SD1')+ " SD1 , " + CRLF      
	cQuery += "                        "+RetSqlName('SF1')+ " SF1 , " + CRLF             
	cQuery += "                        "+RetSqlName('BD6')+ " BD6 , " + CRLF
	cQuery += "                        "+RetSqlName('ZZT')+ " ZZT , " + CRLF      
	cQuery += "                        "+RetSqlName('BI3')+ " BI3 , " + CRLF      
    cQuery += "                        "+RetSqlName('BAU')+ " BAU , " + CRLF
    cQuery += "                        "+RetSqlName('SA2')+ " SA2   " + CRLF     
    
	cQuery += "                  WHERE BI3_FILIAL= '" + xFilial('BI3') + "' " + CRLF 
	cQuery += "                    AND A2_FILIAL   ='" + xFilial('SA2') + "'" + CRLF
	cQuery += "                    AND A2_COD       = B19_FORNEC
  
  	cQuery += "                    AND BAU_FILIAL     = '" + xFilial('BAU') + "'  AND BAU.D_e_l_e_t_ = ' ' AND BAU.R_e_c_d_e_l_ = 0 " + CRLF
	cQuery += "                    AND BAU_codIGO     = BD6_CODRDA" + CRLF
	cQuery += "                    AND SD1.D1_FORNECE = A2_COD" + CRLF
	cQuery += "                    AND SF1.f1_FORNECE = A2_COD" + CRLF
	cQuery += "                    AND SD1.D1_DOC     = SF1.F1_DOC" + CRLF
	cQuery += "                    AND B19_DOC        = SD1.D1_DOC" + CRLF
	cQuery += "                    AND SD1.D1_SERIE   = SF1.F1_SERIE" + CRLF
	cQuery += "                    AND B19_SERIE      = SF1.F1_SERIE  " + CRLF
	cQuery += "                    AND SD1.D1_LOJA    = SF1.F1_LOJA " + CRLF
	cQuery += "                    AND B19_LOJA       = SF1.F1_LOJA      " + CRLF
	cQuery += "                    AND SD1.D1_COD     = B19.B19_COD" + CRLF
	cQuery += "                    AND SD1.D1_ITEM    = B19_ITEM" + CRLF
	cQuery += "                    AND BD6_FILIAL     = '" + xFilial('BD6') + "'" + CRLF
	cQuery += "                    AND ZZT_FILIAL     = '" + xFilial('ZZT') + "'" + CRLF
	cQuery += "                    AND BD6_CODPLA     = BI3_CODIGO" + CRLF
	cQuery += "                    AND BD6_CODOPE     = SUBSTR(B19_GUIA,01,04)" + CRLF
	cQuery += "                    AND BD6_CODLDP     = SUBSTR(B19_GUIA,05,04)" + CRLF
	cQuery += "                    AND BD6_CODPEG     = SUBSTR(B19_GUIA,09,08)" + CRLF
	cQuery += "                    AND BD6_NUMERO     = SUBSTR(B19_GUIA,17,08)" + CRLF
   	cQuery += "                    AND BD6_ORIMOV     = SUBSTR(B19_GUIA,25,01)" + CRLF
	cQuery += "                    AND BD6_SEQUEN     = SUBSTR(B19_GUIA,26,03)" + CRLF
	cQuery += "                    AND BD6_FASE      IN (3,4)" + CRLF
	cQuery += "                    AND BD6_CODLDP     ='0013'" + CRLF
	cQuery += "                    AND BD6_SITUAC     = 1" + CRLF
	cQuery += "                    AND BD6_YNEVEN     = ZZT_CODEV" + CRLF
    
//	cQuery += "                    AND F1_EMISSAO LIKE  '"+cCompet +"'||'%' "+ CRLF 
    CQUERY += "                    AND F1_YDTCON BETWEEN '"+cCompet +"'||'01'  AND '"+cCompet +"'||'31'      
    
	cQuery += "                    AND SA2.D_E_L_E_T_ = ' ' AND B19.D_E_L_E_T_ = ' ' AND SD1.D_E_L_E_T_ = ' '" + CRLF
	cQuery += "                    AND SF1.D_E_L_E_T_ = ' ' AND BD6.D_E_L_E_T_ = ' ' AND ZZT.D_E_L_E_T_ = ' '" + CRLF
	cQuery += "                    AND BI3.D_E_L_E_T_ = ' '" + CRLF
	cQuery += "                  GROUP BY F1_EMISSAO, BD6_OPEUSR, BD6_CODEMP, BD6_MATRIC, BD6_TIPREG,  BD6_DIGITO," + CRLF
	cQuery += "                        SIGA_TIPO_EXPOSICAO_ANS(BD6_CODEMP,BD6_MATRIC,BD6_TIPREG,To_Date(Trim(BD6_DATPRO),'YYYYMMDD'))," + CRLF
	cQuery += "                        BD6_CODEMP, BD6_CODPLA, RETORNA_DESC_GRUPO_PLANO ( TRIM(BI3_YGRPLA),'"+cEmpresa+"')," + CRLF
	cQuery += "                        DECODE(BD6_CODEMP,'0007',Trim(BI3_NREDUZ)||' (SEPE)',BI3_NREDUZ), BD6_YNEVEN," + CRLF
	cQuery += "                        Trim(BD6_DESPRO) , ZZT_EVENTO, ZZT_TPCUST , BD6_CODRDA," + CRLF
	cQuery += "                        NVL(Trim(PLS_RETORNA_RDA_SOLIC ('"+cEmpresa+"',BD6_CDPFSO )),'999999') ," + CRLF
	cQuery += "                        BD6_YPROJ , BD6_CODPRO , BD6_CODPAD, BD6_DATPRO ," + CRLF
	cQuery += "                        APROPRIACAO_CUSTO_OPME ('3',SUBSTR(F1_EMISSAO,1,4),SUBSTR(F1_EMISSAO,5,2),F1_FORNECE,F1_LOJA,F1_SERIE,F1_DOC)," + CRLF
	cQuery += "                        retorna_evento_cab ( bd6_opeusr,bd6_codldp, bd6_codpeg,bd6_numero,bd6_orimov,bd6_codpad,bd6_codpro,'"+cEmpresa+"' ) ," + CRLF
//	cQuery += "                        RETORNA_EVENTO_EVOL ( BD6_OPEUSR,BD6_CODLDP, BD6_CODPEG,BD6_NUMERO,BD6_ORIMOV,BD6_CODPAD,BD6_CODPRO,BD6_MATVID,'"+cEmpresa+"' ) ," + CRLF
	cQuery += "                        BD6_MATVID," + CRLF
     
	cQuery += "                        bd6_numimp , " + CRLF
	cQuery += "                        BD6_OPEUSR ||'.'|| BD6_CODEMP ||'.'|| BD6_MATRIC ||'.'|| BD6_TIPREG ||'.'|| BD6_DIGITO ||'-'|| bd6_nomusr ," + CRLF
	cQuery += "                        DECODE(BAU_TIPPE,'F' ,'Fisica' , 'Juridica') , " + CRLF
	cQuery += "                        a2_cod ||'-'|| a2_nome , " + CRLF   
	
	cQuery += "                        decode(trim(bd6_yproju),NULL, 'N' ,'S') " + CRLF 
      
	cQuery += "                        UNION ALL" + CRLF
    
	cQuery += "  SELECT DISTINCT F1_EMISSAO," + CRLF
	cQuery += "         BD6_OPEUSR OPEUSR," + CRLF
	cQuery += "         BD6_CODEMP CODEMP," + CRLF
	cQuery += "         BD6_MATRIC MATRIC," + CRLF
	cQuery += "         BD6_TIPREG TIPREG," + CRLF
	cQuery += "         BD6_DIGITO DIGITO," + CRLF
	cQuery += "         BD6_CODPLA PLANO," + CRLF
	cQuery += "         BD6_YNEVEN Cod_Evento," + CRLF
	cQuery += "         ZZT_EVENTO Nome_Evento," + CRLF
	cQuery += "         1 QTDE," + CRLF
	cQuery += "         1 Ocorrencia," + CRLF
	cQuery += "         0 Glosado, " + CRLF
	cQuery += "         0 Vl_Aprov," + CRLF
	cQuery += "         0 Taxa ," + CRLF
	cQuery += "         NVL(BD7_VLRTPF,0) Vl_Participacao," + CRLF
	cQuery += "         0 Vl_Informado," + CRLF
	cQuery += "         0 Vl_Recuperado," + CRLF
	cQuery += "         0 Vl_Protocolado," + CRLF
	cQuery += "         0 Vl_Total_Prot," + CRLF
	cQuery += "         SIGA_TIPO_EXPOSICAO_ANS(BD6_CODEMP,BD6_MATRIC,BD6_TIPREG,To_Date(Trim(BD6_DATPRO),'YYYYMMDD')) EXPOSICAO_ANS ," + CRLF
	cQuery += "         RETORNA_DESC_GRUPO_PLANO ( TRIM(BI3_YGRPLA),'"+cEmpresa+"') GRUPO_PLANO," + CRLF
	cQuery += "         DECODE(BD6_CODEMP,'0007',Trim(BI3_NREDUZ) ||' (SEPE)',BI3_NREDUZ) NOME_PLANO," + CRLF
	cQuery += "         0 Val_adiant ," + CRLF
	cQuery += "         ZZT_TPCUST ," + CRLF
	cQuery += "         BD6_CODRDA RDA ," + CRLF
	cQuery += "         NVL(Trim(PLS_RETORNA_RDA_SOLIC ('"+cEmpresa+"',BD6_CDPFSO )),'999999') RDASOL," + CRLF
	cQuery += "         BD6_YPROJ PROJ," + CRLF
	cQuery += "         Trim(BR8_DESCRI) DESPRO," + CRLF
	cQuery += "         BD6_CODPRO COD_PROCED," + CRLF
	cQuery += "         BD6_CODPAD TABELA," + CRLF
	cQuery += "         BD6_DATPRO DATA," + CRLF
	cQuery += "         apropriacao_custo_opme ('3',substr(f1_emissao,1,4),substr(f1_emissao,5,2),f1_fornece,f1_loja,f1_serie,f1_doc) apropriacao_custo," + CRLF
	cQuery += "         RETORNA_EVENTO_CAB ( BD6_OPEUSR,BD6_CODLDP, BD6_CODPEG,BD6_NUMERO,BD6_ORIMOV,BD6_CODPAD,BD6_CODPRO,'"+cEmpresa+"' ) EVENTONOVO," + CRLF
//	cQuery += "         RETORNA_EVENTO_EVOL ( BD6_OPEUSR,BD6_CODLDP, BD6_CODPEG,BD6_NUMERO,BD6_ORIMOV,BD6_CODPAD,BD6_CODPRO,BD6_MATVID,'"+cEmpresa+"' ) EVENTOANT," + CRLF
	cQuery += "         BD6_MATVID MATVID , " + CRLF
	cQuery += "         bd6_numimp numimp , " + CRLF
	cQuery += "         BD6_OPEUSR ||'.'|| BD6_CODEMP ||'.'|| BD6_MATRIC ||'.'|| BD6_TIPREG ||'.'|| BD6_DIGITO ||'-'|| bd6_nomusr USUARIO ," + CRLF
	cQuery += "         DECODE(BAU_TIPPE,'F' ,'Fisica' , 'Juridica') tpessoa , " + CRLF
	cQuery += "         a2_cod ||'-'|| a2_nome Fornecedor ,  " + CRLF
	
    cQuery += "         decode(trim(bd6_yproju),NULL, 'N' ,'S') jurid  "+CRLF                                                                        
	
	cQuery += "                   FROM "+RetSqlName('B19')+ " B19 , " + CRLF
	cQuery += "                        "+RetSqlName('SD1')+ " SD1 , " + CRLF      
	cQuery += "                        "+RetSqlName('SF1')+ " SF1 , " + CRLF             
	cQuery += "                        "+RetSqlName('BD6')+ " BD6 , " + CRLF
	cQuery += "                        "+RetSqlName('ZZT')+ " ZZT , " + CRLF      
	cQuery += "                        "+RetSqlName('BI3')+ " BI3 , " + CRLF      
    cQuery += "                        "+RetSqlName('BAU')+ " BAU , " + CRLF 
   	cQuery += "                        "+RetSqlName('BD7')+ " BD7 , " + CRLF      
    cQuery += "                        "+RetSqlName('BR8')+ " BR8 , " + CRLF    
    cQuery += "                        "+RetSqlName('SA2')+ " SA2   " + CRLF     

    cQuery += "                  WHERE BI3_FILIAL ='" + xFilial('BI3') + "'" + CRLF
    cQuery += "                    AND A2_FILIAL  ='" + xFilial('SA2') + "'" + CRLF
    cQuery += "                    AND B19_FILIAL     ='" + xFilial('B19') + "'" + CRLF
    cQuery += "                    AND D1_FILIAL      ='01' " + CRLF
    cQuery += "                    AND F1_FILIAL      ='01' " + CRLF
    cQuery += "                    AND BD7_FILIAL     ='" + xFilial('BD7') + "'" + CRLF
    cQuery += "                    AND BR8_FILIAL     ='" + xFilial('BR8') + "'" + CRLF
    cQuery += "                    AND A2_COD         = B19_FORNEC " + CRLF
    
    cQuery += "                    AND BAU_FILIAL = '" + xFilial('BAU') + "'  AND BAU.D_e_l_e_t_ = ' ' AND BAU.R_e_c_d_e_l_ = 0 " + CRLF
    cQuery += "                    AND BAU_codIGO = BD6_CODRDA " + CRLF
    
  //  cQuery += "                    AND F1_EMISSAO LIKE  '"+cCompet +"'||'%' "+ CRLF 
    CQUERY += "                    AND F1_YDTCON BETWEEN '"+cCompet +"'||'01'  AND '"+cCompet +"'||'31'  
    
    cQuery += "                    AND SD1.D1_FORNECE   = A2_COD" + CRLF
    cQuery += "                    AND SF1.f1_FORNECE   = A2_COD" + CRLF
    cQuery += "                    AND SD1.D1_DOC       = SF1.F1_DOC" + CRLF
    cQuery += "                    AND B19_DOC          = SD1.D1_DOC" + CRLF
    
    cQuery += "                    AND SD1.D1_SERIE   = SF1.F1_SERIE" + CRLF
    cQuery += "                    AND B19_SERIE      = SF1.F1_SERIE  " + CRLF
    cQuery += "                    AND SD1.D1_LOJA    = SF1.F1_LOJA " + CRLF
    cQuery += "                    AND B19_LOJA       = SF1.F1_LOJA      " + CRLF
    
    cQuery += "                    AND SD1.D1_COD     = B19.B19_COD" + CRLF
    
    cQuery += "                    AND SD1.D1_ITEM    = B19_ITEM" + CRLF
    cQuery += "                    AND BD6_FILIAL     = '" + xFilial('BD6') + "'" + CRLF
    cQuery += "                    AND ZZT_FILIAL     = '" + xFilial('ZZT') + "'" + CRLF
    cQuery += "                    AND BD6_CODPLA     = BI3_CODIGO" + CRLF
    cQuery += "                    AND BD6_CODOPE     = SUBSTR(B19_GUIA,01,04)" + CRLF
    cQuery += "                    AND BD6_CODLDP     = SUBSTR(B19_GUIA,05,04)" + CRLF
    cQuery += "                    AND BD6_CODPEG     = SUBSTR(B19_GUIA,09,08)" + CRLF
    cQuery += "                    AND BD6_NUMERO     = SUBSTR(B19_GUIA,17,08)" + CRLF
    cQuery += "                    AND BD6_ORIMOV     = SUBSTR(B19_GUIA,25,01)" + CRLF
    cQuery += "                    AND BD6_SEQUEN     = SUBSTR(B19_GUIA,26,03)" + CRLF
    cQuery += "                    AND BD7_CODPRO    IN ('01990012','02990016','03990010')" + CRLF
    cQuery += "                    AND BD7_CODOPE     = BD6_CODOPE" + CRLF
    cQuery += "                    AND BD7_CODLDP     = BD6_CODLDP" + CRLF
    cQuery += "                    AND BD7_CODPEG     = BD6_CODPEG" + CRLF
    cQuery += "                    AND BD7_NUMERO     = BD6_NUMERO" + CRLF
    cQuery += "                    AND BR8_CODPAD     = BD6_CODPAD" + CRLF
    cQuery += "                    AND BR8_CODPSA     = BD6_CODPRO" + CRLF
    cQuery += "                    AND BD6_FASE      IN (3,4)" + CRLF
    cQuery += "                    AND BD6_CODLDP     = '0013'" + CRLF
    cQuery += "                    AND BD6_SITUAC     = 1" + CRLF
    cQuery += "                    AND BD6_YNEVEN     =ZZT_CODEV" + CRLF
    cQuery += "                    AND SA2.D_E_L_E_T_ = ' '" + CRLF
    cQuery += "                    AND B19.D_E_L_E_T_ = ' '    AND SD1.D_E_L_E_T_ = ' '" + CRLF
    cQuery += "                    AND SF1.D_E_L_E_T_ = ' '    AND BD6.D_E_L_E_T_ = ' '" + CRLF
    cQuery += "                    AND ZZT.D_E_L_E_T_ = ' '    AND BI3.D_E_L_E_T_ = ' '" + CRLF
    cQuery += "                    AND BD7.D_E_L_E_T_ = ' '    AND BR8.D_E_L_E_T_ = ' '" + CRLF
    cQuery += "           )" + CRLF
    cQuery += "                  GROUP BY SUBSTR(F1_EMISSAO,1,6)," + CRLF
    cQuery += "                  OPEUSR, CODEMP, MATRIC, TIPREG," + CRLF
    cQuery += "                  DIGITO, PLANO,  NOME_EVENTO, COD_EVENTO," + CRLF
    cQuery += "                  GRUPO_PLANO, NOME_PLANO, EXPOSICAO_ANS, ZZT_TPCUST ," + CRLF
    cQuery += "                  RDA , RDASOL , PROJ, COD_PROCED," + CRLF
    cQuery += "                  DESPRO , TABELA , DATA ,   APROPRIACAO_CUSTO," + CRLF
 //   cQuery += "                  EVENTONOVO , EVENTOANT,  MATVID ,  " + CRLF
    cQuery += "                  EVENTONOVO ,   MATVID ,  " + CRLF
	cQuery += "                  numimp , USUARIO , tpessoa ,  Fornecedor , jurid "
////
 If Select(("TMP")) <> 0 
      ("TMP")->(DbCloseArea()) 
   Endif
    
    TCQuery cQuery Alias "TMP" New 
                                                                                           
    dbSelectArea("TMP")

    tmp->(dbGoTop())  

    FGrvPlan3()  

Return ()               

Static Function Processa4()      

cQuery := "  SELECT (SUBSTR(E1_VENCREA,1,6)) REFER, " + CRLF
cQuery += "         B44_OPEUSR OPEUSR," + CRLF
cQuery += "         B44_CODEMP CODEMP," + CRLF
cQuery += "         B44_MATRIC MATRIC," + CRLF
cQuery += "         B44_TIPREG TIPREG," + CRLF
cQuery += "         B44_DIGITO DIGITO," + CRLF
cQuery += "         NVL(Trim(BA1_CODPLA),BA3_CODPLA) PLANO," + CRLF
cQuery += "         BD6_YNEVEN COD_EVENTO, " + CRLF
cQuery += "         ZZT_EVENTO NOME_EVENTO," + CRLF
cQuery += "         COUNT(DISTINCT B44_OPEUSR||B44_CODEMP||B44_MATRIC||B44_TIPREG) QTDE," + CRLF
cQuery += "         SUM(B45_QTDPRO) OCORRENCIA," + CRLF
cQuery += "         SUM(B45_VLRGLO) GLOSADO,   " + CRLF
cQuery += "         SUM(B45_VLRPAG) VL_APROV,  " + CRLF
cQuery += "         0 TAXA," + CRLF
cQuery += "         0 VL_PARTICIPACAO, " + CRLF
cQuery += "         SUM(B45_VLRMAN) VL_INFORMADO, " + CRLF
cQuery += "         0 VL_RECUPERADO,  " + CRLF
cQuery += "         0 VL_PROTOCOLADO, " + CRLF
cQuery += "         0 VL_TOTAL_PROT,  " + CRLF
cQuery += "         SIGA_TIPO_EXPOSICAO_ANS(B44_CODEMP,B44_MATRIC,B44_TIPREG,To_Date(Trim(B44_DATPRO),'YYYYMMDD')) EXPOSICAO_ANS, " + CRLF
cQuery += "         RETORNA_DESC_GRUPO_PLANO ( TRIM(BI3_YGRPLA),'"+cEmpresa+"') GRUPO_PLANO, " + CRLF
cQuery += "         DECODE(B44_CODEMP,'0007',Trim(BI3_NREDUZ)||' (SEPE)',BI3_NREDUZ) NOME_PLANO, " + CRLF
cQuery += "         0 Val_adiant,      " + CRLF
cQuery += "         ZZT_TPCUST ,       " + CRLF
cQuery += "         'Reembolso' Tipo,  " + CRLF
cQuery += "         B44_CODRDA RDA,    " + CRLF
cQuery += "         NVL(Trim(PLS_RETORNA_RDA_SOLIC ('"+cEmpresa+"',B44_CDPFSO )),'999999') RDASOL, " + CRLF
cQuery += "         BD6_YPROJ PROJ," + CRLF
cQuery += "         Trim(BD6_DESPRO) DESPRO," + CRLF
cQuery += "         B45_CODPRO COD_PROCED,  " + CRLF
cQuery += "         B45_CODPAD TABELA,      " + CRLF
cQuery += "         B44_DATPRO DATA, " + CRLF
cQuery += "         1 APROPRIACAO_CUSTO, " + CRLF
cQuery += "         RETORNA_EVENTO_CAB ( BD6_OPEUSR,BD6_CODLDP, BD6_CODPEG,BD6_NUMERO,BD6_ORIMOV,BD6_CODPAD,BD6_CODPRO,'"+cEmpresa+"' )  EVENTONOVO," + CRLF
//cQuery += "         RETORNA_EVENTO_EVOL ( BD6_OPEUSR,BD6_CODLDP, BD6_CODPEG,BD6_NUMERO,BD6_ORIMOV,BD6_CODPAD,BD6_CODPRO,BD6_MATVID,'"+cEmpresa+"' ) EVENTOANT, " + CRLF
cQuery += "         BD6_MATVID MATVID , " + CRLF      

cQuery += "         bd6_numimp numimp , " + CRLF
cQuery += "         BD6_OPEUSR ||'.'|| BD6_CODEMP ||'.'|| BD6_MATRIC ||'.'|| BD6_TIPREG ||'.'|| BD6_DIGITO ||'-'|| bd6_nomusr USUARIO ," + CRLF
cQuery += "         DECODE(BAU_TIPPE,'F' ,'Fisica' , 'Juridica') tpessoa , " + CRLF
cQuery += "         a2_cod ||'-'|| a2_nome Fornecedor , " + CRLF
 
cQuery += "         decode(zzq_tpsol , '2','Extrarol', 'Normal') Extrarol , " + CRLF 

cQuery += "         decode(trim(bd6_yproju),NULL, 'N' ,'S') jurid  "+CRLF 
    
cQuery += "    FROM "+RetSqlName('B44')+ " C , " + CRLF
cQuery += "         "+RetSqlName('B45')+ " D , " + CRLF      
cQuery += "         "+RetSqlName('SE1')+ " T , " + CRLF             
cQuery += "         "+RetSqlName('BA1')+ " U , " + CRLF
cQuery += "         "+RetSqlName('BA3')+ " F , " + CRLF      
cQuery += "         "+RetSqlName('BI3')+ " BI3 , " + CRLF  
cQuery += "         "+RetSqlName('BG9')+ " BG9 , " + CRLF  
cQuery += "         "+RetSqlName('ZZT')+ " ZZT , " + CRLF  
cQuery += "         "+RetSqlName('BD6')+ " BD6 , " + CRLF      

cQuery += "         "+RetSqlName('ZZQ')+ " ZZQ , " + CRLF  

cQuery += "         "+RetSqlName('BAU')+ " BAU , " + CRLF
cQuery += "         "+RetSqlName('SA2')+ " SA2 " + CRLF  
                                                  
cQuery += "   WHERE B45_FILIAL  ='" + xFilial('B45') + "' " + CRLF 
cQuery += "     AND B44_FILIAL  ='" + xFilial('B44') + "' " + CRLF 
cQuery += "     AND BI3_FILIAL  ='" + xFilial('BI3') + "' " + CRLF 
cQuery += "     AND BA3_FILIAL  ='" + xFilial('BA3') + "' " + CRLF 
cQuery += "     AND BA1_FILIAL  ='" + xFilial('BA1') + "' " + CRLF 
cQuery += "     AND BG9_FILIAL  ='" + xFilial('BG9') + "' " + CRLF 
cQuery += "     AND ZZT_FILIAL  ='" + xFilial('ZZT') + "' " + CRLF 

cQuery += "     AND ZZQ_FILIAL  ='" + xFilial('ZZQ') + "' " + CRLF 

cQuery += "     AND BD6_FILIAL  ='" + xFilial('BD6') + "' " + CRLF 
cQuery += "     AND E1_FILIAL   ='" + xFilial('SE1') + "' " + CRLF 
 
cQuery += "     AND A2_FILIAL   ='" + xFilial('SA2') + "' " + CRLF 

CQUERY += "    AND BAU_FILIAL='" + xFilial('BAU') + "'  AND BAU.D_e_l_e_t_ = ' ' AND BAU.R_e_c_d_e_l_ = 0 " + CRLF   
CQUERY += "    AND  A2_FILIAL='" + xFilial('SA2') + "'  AND SA2.D_e_l_e_t_ = ' ' AND BAU_codsa2 = a2_cod " + CRLF
cQuery += "    AND BAU_codIGO = BD6.BD6_CODRDA " + CRLF

cQuery += "     AND E1_PREFIXO  ='RLE' " + CRLF
cQuery += "     AND B44_CODLDP  =B45_CODLDP" + CRLF
cQuery += "     AND B44_CODPEG  =B45_CODPEG" + CRLF
cQuery += "     AND B44_NUMAUT  =B45_NUMAUT" + CRLF
cQuery += "     AND B44_PREFIX  =E1_PREFIXO" + CRLF
cQuery += "     AND B44_NUM     =E1_NUM    " + CRLF
cQuery += "     AND BA1_CODINT  =BA3_CODINT" + CRLF
cQuery += "     AND BA1_CODEMP  =BA3_CODEMP" + CRLF
cQuery += "     AND BA1_MATRIC  =BA3_MATRIC" + CRLF
cQuery += "     AND BA1_CODINT  =B44_OPEUSR" + CRLF
cQuery += "     AND BA1_CODEMP  =B44_CODEMP" + CRLF
cQuery += "     AND BA1_MATRIC  =B44_MATRIC" + CRLF
cQuery += "     AND BA1_TIPREG  =B44_TIPREG" + CRLF
cQuery += "     AND BI3_CODINT  =BA1_CODINT" + CRLF
cQuery += "     AND B44_OPEUSR  =BG9_CODINT" + CRLF
cQuery += "     AND B44_CODEMP  =BG9_CODIGO" + CRLF
cQuery += "     AND BI3_CODIGO  =NVL(Trim(BA1_CODPLA),BA3_CODPLA) " + CRLF
cQuery += "     AND BD6_CODOPE  ='0001' " + CRLF
cQuery += "     AND B45_CODLDP  =BD6_CODLDP" + CRLF
cQuery += "     AND B45_CODPEG  =BD6_CODPEG" + CRLF
cQuery += "     AND B45_NUMERO  =BD6_NUMERO" + CRLF
cQuery += "     AND B45_SEQUEN  =BD6_SEQUEN" + CRLF
cQuery += "     AND B45_CODPAD  =BD6_CODPAD" + CRLF
cQuery += "     AND B45_CODPRO  =BD6_CODPRO" + CRLF
cQuery += "     AND BD6_YNEVEN  =ZZT_CODEV " + CRLF

cQuery += "     AND ZZQ_SEQUEN = B44_YCDPTC  "+CRLF

/*
cQuery += "     AND (((SUBSTR(E1_VENCREA,1,6)) < '201006'  " + CRLF //--- apartir de junho/2010 contabilizac?o por emissao  
cQuery += "           AND E1_VENCREA like '"+cCompet +"'||'%' )" + CRLF 
cQuery += "    OR " + CRLF                                                                             
cQuery += "       ((SUBSTR(E1_EMISSAO,1,6)) >= '201006' " + CRLF //-- apartir de junho/2010 contabilizac?o por emissao
cQuery += "         and E1_EMISSAO like '"+cCompet +"'||'%'))" + CRLF                                  
*/
cQuery += "    AND SUBSTR(B44_YDTCON,1,6) BETWEEN '"+cCompet +"' AND '"+cCompet +"' " + CRLF
  
cQuery += "     AND C.D_E_L_E_T_     =' '" + CRLF
cQuery += "     AND D.D_E_L_E_T_     =' '" + CRLF
cQuery += "     AND T.D_E_L_E_T_     =' '" + CRLF
cQuery += "     AND U.D_E_L_E_T_     =' '" + CRLF
cQuery += "     AND F.D_E_L_E_T_     =' '" + CRLF
cQuery += "     AND BI3.D_E_L_E_T_   =' '" + CRLF
cQuery += "     AND BG9.D_E_L_E_T_   =' '" + CRLF
cQuery += "     AND ZZT.D_E_L_E_T_   =' '" + CRLF 

cQuery += "     AND ZZQ.D_E_L_E_T_   =' '" + CRLF

cQuery += "     AND BD6.D_E_L_E_T_   =' '" + CRLF 
cQuery += "     AND SA2.D_E_L_E_T_   =' '" + CRLF
cQuery += "     AND BAU.D_E_L_E_T_   =' '" + CRLF

cQuery += "   GROUP BY (SUBSTR(E1_VENCREA,1,6)), " + CRLF 
cQuery += "         B44_OPEUSR ," + CRLF
cQuery += "         B44_CODEMP, " + CRLF
cQuery += "         B44_MATRIC, " + CRLF
cQuery += "         B44_TIPREG, " + CRLF
cQuery += "         B44_DIGITO, " + CRLF
cQuery += "         NVL(Trim(BA1_CODPLA),BA3_CODPLA) ," + CRLF 
cQuery += "         RETORNA_DESC_GRUPO_PLANO ( TRIM(BI3_YGRPLA),'"+cEmpresa+"') ," + CRLF 
cQuery += "         DECODE(B44_CODEMP,'0007',Trim(BI3_NREDUZ)||' (SEPE)',BI3_NREDUZ)," + CRLF 
cQuery += "         SIGA_TIPO_EXPOSICAO_ANS(B44_CODEMP,B44_MATRIC,B44_TIPREG,To_Date(Trim(B44_DATPRO),'YYYYMMDD'))," + CRLF 
cQuery += "         B44_ANOAUT,  " + CRLF
cQuery += "         B44_MESAUT,  " + CRLF
cQuery += "         ZZT_EVENTO,  " + CRLF
cQuery += "         ZZT_TPCUST , " + CRLF
cQuery += "         BD6_YNEVEN , " + CRLF
cQuery += "         B44_CODRDA, " + CRLF 
cQuery += "         NVL(Trim(PLS_RETORNA_RDA_SOLIC ('"+cEmpresa+"',B44_CDPFSO )),'999999'), " + CRLF 
cQuery += "         BD6_YPROJ ,           " + CRLF   
cQuery += "         B44_DATPRO ,          " + CRLF
cQuery += "         Trim(BD6_DESPRO) ,    " + CRLF
cQuery += "         B45_CODPRO,           " + CRLF
cQuery += "         B45_CODPAD,           " + CRLF
cQuery += "         1, " + CRLF 
cQuery += "         RETORNA_EVENTO_CAB ( BD6_OPEUSR,BD6_CODLDP, BD6_CODPEG,BD6_NUMERO,BD6_ORIMOV,BD6_CODPAD,BD6_CODPRO,'"+cEmpresa+"' ) , " + CRLF 
//cQuery += "         RETORNA_EVENTO_EVOL ( BD6_OPEUSR,BD6_CODLDP, BD6_CODPEG,BD6_NUMERO,BD6_ORIMOV,BD6_CODPAD,BD6_CODPRO,BD6_MATVID,'"+cEmpresa+"' ) , " + CRLF 
cQuery += "         BD6_MATVID ," + CRLF
cQuery += "         bd6_numimp , " + CRLF
cQuery += "         BD6_OPEUSR ||'.'|| BD6_CODEMP ||'.'|| BD6_MATRIC ||'.'|| BD6_TIPREG ||'.'|| BD6_DIGITO ||'-'|| bd6_nomusr ," + CRLF
cQuery += "         DECODE(BAU_TIPPE,'F' ,'Fisica' , 'Juridica') , " + CRLF
cQuery += "         a2_cod ||'-'|| a2_nome  , " + CRLF                               

cQuery += "         decode(zzq_tpsol , '2','Extrarol', 'Normal')  , " + CRLF 

cQuery += "         decode(trim(bd6_yproju),NULL, 'N' ,'S')   "+CRLF 

////
 If Select(("TMP")) <> 0 
      ("TMP")->(DbCloseArea()) 
   Endif
    
    TCQuery cQuery Alias "TMP" New 
                                                                                           
    dbSelectArea("TMP")

    tmp->(dbGoTop())  

    FGrvPlan4()  
    
Return ()               

Static Function Processa5()      

cQuery := "  SELECT SUBSTR(BGQ_NUMLOT,1,6) REFER, " + CRLF
cQuery += "         '' OPEUSR, " + CRLF
cQuery += "         '' CODEMP, " + CRLF
cQuery += "         '' MATRIC, " + CRLF
cQuery += "         '' TIPREG, " + CRLF
cQuery += "         '' DIGITO, " + CRLF
cQuery += "         BI3_CODIGO PLANO, " + CRLF
cQuery += "         BBB_YNEVEN COD_EVENTO,  " + CRLF
cQuery += "         ZZT_EVENTO NOME_EVENTO, " + CRLF
cQuery += "         COUNT(DISTINCT BGQ_CODSEQ) QTDE, " + CRLF
cQuery += "         COUNT(BGQ_CODSEQ) OCORRENCIA, " + CRLF
cQuery += "         0 GLOSADO, " + CRLF //----> Leandro 13/10/2003 
cQuery += "         SUM(DECODE(BBB_TIPSER,1,-1*BGQ_VALOR,BGQ_VALOR)) VL_APROV, " + CRLF
cQuery += "         0 TAXA , " + CRLF
cQuery += "         0 VL_PARTICIPACAO, " + CRLF
cQuery += "         SUM(DECODE(BBB_TIPSER,1,-1*BGQ_VALOR,BGQ_VALOR)) Vl_Informado, " + CRLF
cQuery += "         0 Vl_Recuperado, " + CRLF
cQuery += "         0 Vl_Protocolado, " + CRLF
cQuery += "         0 Vl_Total_Prot, " + CRLF
cQuery += "         decode(RETORNA_GRUPO_EMP(BI3_CODIGO),'0004',2,'0009',2,0) EXPOSICAO_ANS, " + CRLF
cQuery += "         RETORNA_DESC_GRUPO_PLANO ( TRIM(BI3_YGRPLA),'"+cEmpresa+"') GRUPO_PLANO, " + CRLF
cQuery += "         BI3_NREDUZ NOME_PLANO, " + CRLF
cQuery += "         0 Val_adiant, " + CRLF
cQuery += "         ZZT_TPCUST , " + CRLF
cQuery += "         'Lancamentos Deb/Cred' Tipo , " + CRLF
cQuery += "         BGQ_CODIGO RDA, " + CRLF
cQuery += "         BGQ_CODIGO RDASOL, " + CRLF
cQuery += "         BGQ_YPROJ PROJ, " + CRLF
cQuery += "         Trim(BBB_DESCRI) DESPRO, " + CRLF
cQuery += "         BGQ_CODLAN COD_PROCED, " + CRLF
cQuery += "         '  ' TABELA, " + CRLF
cQuery += "         SUBSTR(BGQ_NUMLOT,1,4)||SUBSTR(BGQ_NUMLOT,5,2)||'01' DATA , " + CRLF
cQuery += "         APROPRIACAO_CUSTO ('3', SUBSTR(BGQ_NUMLOT,1,4),SUBSTR(BGQ_NUMLOT,5,2),BGQ_OPELOT,BGQ_NUMLOT,BGQ_CODIGO)	APROPRIACAO_CUSTO, " + CRLF
cQuery += "         Decode(BBB_YEVCAB,51,7,57,7,BBB_YEVCAB) EVENTONOVO, " + CRLF
cQuery += "         Decode(BBB_YEVCAB,51,7,57,7,5,60,4,60,2,76,BBB_YEVCAB) EVENTOANT , " + CRLF
cQuery += "         ' ' MATVID , " + CRLF
cQuery += "         ' ' numimp, " + CRLF
cQuery += "         ' ' USUARIO , " + CRLF 
cQuery += "         ' ' tpessoa , " + CRLF
cQuery += "         ' ' Fornecedor " + CRLF

cQuery += "    FROM "+RetSqlName('BGQ')+ " BGQ , " + CRLF   
cQuery += "         "+RetSqlName('BBB')+ " BBB , " + CRLF 
cQuery += "         "+RetSqlName('BI3')+ " BI3 , " + CRLF 
cQuery += "         "+RetSqlName('ZZT')+ " ZZT   " + CRLF

cQuery += "   WHERE BGQ_FILIAL        = '" + xFilial('BGQ') + "' " + CRLF 
cQuery += "     AND BGQ_CODLAN       <> '050' " + CRLF

cQuery += "     AND BGQ_NUMLOT        LIKE '"+cCompet +"'||'%'" + CRLF

cQuery += "     AND BBB_FILIAL        = '" + xFilial('BBB') + "' " + CRLF 
cQuery += "     AND BBB_CODSER        = BGQ_CODLAN " + CRLF
cQuery += "     AND ZZT_FILIAL        = '" + xFilial('ZZT') + "' " + CRLF 
cQuery += "     AND BBB_YNEVEN        =ZZT_CODEV " + CRLF
cQuery += "     AND BI3_FILIAL        = '" + xFilial('BI3') + "' " + CRLF 
cQuery += "     AND BI3_CODIGO        =NVL( RETORNA_PLANO_USU_MS ('"+cEmpresa+"',BGQ_CODOPE,BGQ_CODEMP,BGQ_MATRIC,'00','N'),BBB_YCODPL) " + CRLF
cQuery += "     AND BI3.D_E_L_E_T_    = ' ' " + CRLF
cQuery += "     AND ZZT.D_E_L_E_T_    = ' ' " + CRLF
cQuery += "     AND BGQ.D_E_L_E_T_ = ' ' " + CRLF
cQuery += "     AND BBB.D_E_L_E_T_ = ' ' " + CRLF
cQuery += "     GROUP BY SUBSTR(BGQ_NUMLOT,1,6) , " + CRLF
cQuery += "           SUBSTR(BGQ_NUMLOT,1,4)||SUBSTR(BGQ_NUMLOT,5,2)||'01', " + CRLF
cQuery += "           BI3_CODIGO , " + CRLF
cQuery += "           BBB_YNEVEN , " + CRLF
cQuery += "           ZZT_EVENTO,  " + CRLF
cQuery += "           ZZT_TPCUST,  " + CRLF
cQuery += "           RETORNA_DESC_GRUPO_PLANO ( TRIM(BI3_YGRPLA),'"+cEmpresa+"'), " + CRLF
cQuery += "           BI3_NREDUZ,  " + CRLF
cQuery += "           BGQ_CODIGO , " + CRLF
cQuery += "           BGQ_YPROJ ,  " + CRLF
cQuery += "           BGQ_CODLAN , " + CRLF
cQuery += "           '  ' ," + CRLF
cQuery += "           Trim(BBB_DESCRI)," + CRLF
cQuery += "           APROPRIACAO_CUSTO ('3', SUBSTR(BGQ_NUMLOT,1,4),SUBSTR(BGQ_NUMLOT,5,2),BGQ_OPELOT,BGQ_NUMLOT,BGQ_CODIGO)," + CRLF
cQuery += "           Decode(BBB_YEVCAB,51,7,57,7,BBB_YEVCAB)," + CRLF
cQuery += "           Decode(BBB_YEVCAB,51,7,57,7,5,60,4,60,2,76,BBB_YEVCAB)" + CRLF

////
 If Select(("TMP")) <> 0 
      ("TMP")->(DbCloseArea()) 
   Endif
    
    TCQuery cQuery Alias "TMP" New 
                                                                                           
    dbSelectArea("TMP")

    tmp->(dbGoTop())  

    FGrvPlan5()    
    

Return ()  


Static Function Processa6()      

//cQuery := "  SELECT /*+first_rows index_asc(BD7 BD70105)*/   " + CRLF 
/*
cQuery += "         substr(BD7F.bd7_numlot,1,6) compte_custo " + CRLF    
cQuery += "         , BD7F.bd7_anopag||BD7F.bd7_mespag compte_aviso " + CRLF   
cQuery += "         , RETORNA_DESC_CONTRATO('C',BD6_OPEUSR,BD6_CODEMP,BD6_CONEMP) CONTRATO " + CRLF           
cQuery += "         , Sum(BD7F.VLRPAG)     Vl_Aprov " + CRLF  
cQuery += "         , sum(bd6f.bd6_vlrpf)  Vlpf " + CRLF           
cQuery += "         , bd6f.bd6_pertad      Perc_Tx " + CRLF       
cQuery += "         , Sum(BD6F.bd6_vlrtad) Taxa " + CRLF         
cQuery += "         , Sum(BD6F.BD6_VLRTPF) Tot_cob " + CRLF   
cQuery += "         , Bd6f.Bd6_numfat numfat " + CRLF            
cQuery += "         , bd6f.bd6_seqpf seqpf " + CRLF      
cQuery += "         , bd7f.bd7_conemp " + CRLF  
cQuery += "         , bd6f.bd6_codemp CodEmp  " + CRLF 
cQuery += "         , bd6f.bd6_matric " + CRLF  
cQuery += "         , bd6f.bd6_tipreg " + CRLF 
cQuery += "         , DECODE(BD6F.BD6_BLOCPA,'1', 'Sim','N„o' ) bloqCob " + CRLF 
cQuery += "         , nvl(bdh_vlcopa,0) " + CRLF
cQuery += "         , BD6_CODRDA  " + CRLF
cQuery += "         , BD7f.BD7_CODLDP " + CRLF
cQuery += "         , BD7f.BD7_CODPEG " + CRLF
cQuery += "         , BD7f.BD7_NUMERO " + CRLF
cQuery += "         , BD7f.BD7_SEQUEN " + CRLF
cQuery += "         , bd7f.bd7_datpro " + CRLF
cQuery += "         , bd6_tipgui " + CRLF
cQuery += "         , BD6F.BD6_DESPRO  " + CRLF
If cEmpAnt == '02' 
   cQuery += "         , RETORNA_EMISSAO_FATURA('I',Bd6f.Bd6_numfat) DtCob " + CRLF 
ELSE
   cQuery += "         , RETORNA_EMISSAO_FATURA('C',Bd6f.Bd6_numfat) DtCob " + CRLF
EndIf       
cQuery += "    FROM  " + CRLF
cQuery += "         (SELECT BD7.BD7_FILIAL,BD7_CODPLA,SIGA_TIPO_EXPOSICAO_ANS(BD7_CODEMP,BD7_MATRIC,BD7_TIPREG,To_Date(Trim(BD7_DATPRO),'YYYYMMDD')) EXPOS, " + CRLF    
cQuery += "                 BD7.BD7_OPELOT,BD7.BD7_NUMLOT, " + CRLF   
cQuery += "                 BD7.BD7_CODOPE, BD7.BD7_CODLDP, BD7.BD7_CODPEG, BD7.BD7_NUMERO, BD7.BD7_ORIMOV, BD7_CODPRO, bd7_mespag , bd7_anopag , " + CRLF    
cQuery += "                 BD7.BD7_SEQUEN,  Sum(BD7.BD7_VLRPAG) AS VLRPAG , " + CRLF    
cQuery += "                 COUNT(DISTINCT BD7_CODEMP||BD7_MATRIC||BD7_TIPREG) QTDE , " + CRLF  
cQuery += "                 bd7.bd7_conemp , bd7.bd7_datpro " + CRLF
cQuery += "           FROM "+RetSqlName('BD7')+ " BD7 " + CRLF  
cQuery += "          WHERE BD7.BD7_FILIAL=' ' " + CRLF    
cQuery += "            AND BD7.BD7_CODOPE = '0001' " + CRLF   
cQuery += "            AND BD7.BD7_SITUAC = '1'    " + CRLF
cQuery += "            AND BD7.BD7_FASE = '4' " + CRLF   
cQuery += "            AND BD7.BD7_BLOPAG <> '1' " + CRLF 
cQuery += "            AND BD7.bd7_numlot    like  '"+cCompet +"'||'%' "+ CRLF   
//cQuery += "            AND BD7.BD7_NUMLOT BETWEEN  '2022010000'  AND '2022019999'    
cQuery += "            AND BD7.bd7_VLRPAG > 0  " + CRLF  
cQuery += "            AND BD7.D_E_L_E_T_ = ' ' " + CRLF   

If cEmpAnt == '01' 
   cQuery += "            AND BD7_CODEMP NOT IN ('0017','0013','0009','0004') " + CRLF
EndIf    

cQuery += "       GROUP BY BD7_FILIAL, BD7_CODPLA, BD7.BD7_OPELOT,BD7.BD7_NUMLOT,BD7_CODPRO,bd7_mespag , bd7_anopag , " + CRLF   
cQuery += "                SIGA_TIPO_EXPOSICAO_ANS(BD7_CODEMP,BD7_MATRIC,BD7_TIPREG,To_Date(Trim(BD7_DATPRO),'YYYYMMDD')) , " + CRLF    
cQuery += "                BD7_FILIAL, BD7_CODOPE, BD7_CODLDP, BD7_CODPEG, BD7_NUMERO, BD7_ORIMOV, BD7_SEQUEN,bd7_conemp, bd7_datpro) BD7F , " + CRLF    
    
cQuery += "        "+RetSqlName('BD6')+ " BD6F , " +RetSqlName('BI3')+ " BI3 ,"+RetSqlName('ZZT')+ " ZZT , " + CRLF
cQuery += "        "+RetSqlName('BDH')+ " BDH    " + CRLF    
cQuery += "  WHERE ZZT_FILIAL = ' '    " + CRLF
cQuery += "    AND BI3_FILIAL = ' '    " + CRLF
cQuery += "    AND BD6F.BD6_FILIAL =' '   " + CRLF
cQuery += "    and bdh_filial(+)   = ' '  " + CRLF
cQuery += "    AND substr(BD7F.BD7_NUMLOT,1,6) >= '"+cCompet +"'  " + CRLF    
cQuery += "    AND substr(BD7F.BD7_NUMLOT,1,6) <= '"+cCompet +"' " + CRLF 
cQuery += "    AND BD7F.BD7_FILIAL = BD6F.BD6_FILIAL " + CRLF   
cQuery += "    AND BD7F.BD7_CODOPE = BD6F.BD6_CODOPE " + CRLF   
cQuery += "    AND BD7F.BD7_CODLDP = BD6F.BD6_CODLDP " + CRLF   
cQuery += "    AND BD7F.BD7_CODPEG = BD6F.BD6_CODPEG " + CRLF   
cQuery += "    AND BD7F.BD7_NUMERO = BD6F.BD6_NUMERO " + CRLF   
cQuery += "    AND BD7F.BD7_ORIMOV = BD6F.BD6_ORIMOV " + CRLF   
cQuery += "    AND BD7F.BD7_SEQUEN = BD6F.BD6_SEQUEN " + CRLF   
cQuery += "    AND BD6F.BD6_CODPRO = BD7F.BD7_CODPRO " + CRLF   
          
cQuery += "    and bd7f.vlrpag > 0  " + CRLF  
cQuery += "    and bd6_vlrtpf  > 0  " + CRLF 
cQuery += "    AND BI3_FILIAL =BD7_FILIAL " + CRLF   
cQuery += "    AND BI3_CODINT =BD7_CODOPE " + CRLF   
cQuery += "    AND BI3_CODIGO =BD7_CODPLA " + CRLF   
cQuery += "    AND BD6_YNEVEN =ZZT_CODEV  " + CRLF     
cQuery += "    AND BD6F.D_E_L_E_T_ = ' '  " + CRLF  
cQuery += "    AND BI3.D_E_L_E_T_  = ' '  " + CRLF  
cQuery += "    AND ZZT.D_E_L_E_T_  = ' '  " + CRLF
       
cQuery += "    and bdh_codint(+) = '0001' " + CRLF
cQuery += "    and bdh_codemp(+) = bd6_codemp " + CRLF
cQuery += "    and bdh_matric(+) = bd6_matric " + CRLF 
cQuery += "    and bdh_tipreg(+) = bd6_tipreg " + CRLF
cQuery += "    and bdh_anoft (+) = bd6_anopag " + CRLF
cQuery += "    and bdh_mesft (+) = bd6_mespag " + CRLF
cQuery += "    and bdh_seqpf (+) = bd6_seqpf  " + CRLF
cQuery += "    AND bdh.D_E_L_E_T_(+) = ' '    " + CRLF
*/
//cQuery += "GROUP BY /*+first_rows index_asc(BD7 BD70105)*/ " + CRLF    
/*
cQuery += "    substr(BD7F.bd7_numlot,1,6) , " + CRLF
cQuery += "    BD7F.bd7_anopag||BD7F.bd7_mespag , " + CRLF    
cQuery += "    RETORNA_DESC_CONTRATO('C',BD6_OPEUSR,BD6_CODEMP,BD6_CONEMP) , " + CRLF    
cQuery += "    bd6f.bd6_pertad , " + CRLF    
cQuery += "    Bd6f.Bd6_numfat , " + CRLF
cQuery += "    bd6f.bd6_seqpf  , " + CRLF
cQuery += "    bd7f.bd7_conemp , " + CRLF
cQuery += "    bd6f.bd6_codemp , " + CRLF
cQuery += "    bd6f.bd6_matric , " + CRLF
cQuery += "    bd6f.bd6_tipreg , " + CRLF
cQuery += "    nvl(bdh_vlrcp6,0) , " + CRLF  
cQuery += "    nvl(bdh_vlrt16,0) , " + CRLF    
cQuery += "    nvl(bdh_vlcopa,0) , " + CRLF 
cQuery += "    DECODE(BD6F.BD6_BLOCPA,'1', 'Sim','N„o' ) " + CRLF 
cQuery += "    , BD6_CODRDA " + CRLF
cQuery += "    , BD7f.BD7_CODLDP " + CRLF
cQuery += "    , BD7f.BD7_CODPEG " + CRLF
cQuery += "    , BD7f.BD7_NUMERO " + CRLF
cQuery += "    , BD7f.BD7_SEQUEN " + CRLF
cQuery += "    , bd7f.bd7_datpro " + CRLF
cQuery += "    , bd6_tipgui " + CRLF
cQuery += "    , BD6F.BD6_DESPRO " + CRLF
If cEmpAnt == '02' 
   cQuery += "         , RETORNA_EMISSAO_FATURA('I',Bd6f.Bd6_numfat) " + CRLF 
ELSE
   cQuery += "         , RETORNA_EMISSAO_FATURA('C',Bd6f.Bd6_numfat) " + CRLF
EndIf       
*/
///////////////INTEGRAL//////////

If cEmpAnt == '02'  
  cQuery := "SELECT  /*+first_rows index_asc(BD7 BD70205)*/"
  cQuery +=  CRLF + "EXPOSICAO_ANS ANS,"
  cQuery +=  CRLF + "GRUPO_PLANO,"
  cQuery +=  CRLF + "NOME_PLANO,"
  cQuery +=  CRLF + "(CASE WHEN Trim(PROJ) IS NULL THEN 'Custo Fora do Projeto'"
  cQuery +=  CRLF + "else 'Custo Projeto '||TRIM(PROJ) end) PROJ,"
  cQuery +=  CRLF + "Decode(ZZT_TPCUST,'A','AMBULATORIAL','H','HOSPITALAR','O','ODONTOLOGICO','') TPCUST,"
  cQuery +=  CRLF + "COD_EVENTO,"
  cQuery +=  CRLF + "NOME_EVENTO,"
  cQuery +=  CRLF + "COD_PROCED,"
  cQuery +=  CRLF + "DESPRO,"
  cQuery +=  CRLF + "ZZT_TPCUST,"
  cQuery +=  CRLF + "PLANO,"
  cQuery +=  CRLF + "NOME_RDA,"
  cQuery +=  CRLF + "RDA,"
  cQuery +=  CRLF + "BD6_CODLDP LOCAL, BD6_CODPEG PEG, BD6_NUMERO NUMERO,"
  cQuery +=  CRLF + "TABELA,"
  cQuery +=  CRLF + "BD6_OPEUSR,BD6_CODEMP,BD6_MATRIC,BD6_TIPREG,BD6_DIGITO,"
  cQuery +=  CRLF + "NOME,"
  cQuery +=  CRLF + "FAIXA,"
  cQuery +=  CRLF + "Trim (BG9_DESCRI) EMPRESA,"
  cQuery +=  CRLF + "TRIM(PROJ) CODPROJ,"
  cQuery +=  CRLF + "TIPO,"
  cQuery +=  CRLF + "DATA,"
  cQuery +=  CRLF + "Sum(QTDE) QTDE,"
  cQuery +=  CRLF + "Sum(OCORRENCIA) OCORRENCIA,"
  cQuery +=  CRLF + "Sum(QTD_ITENS) QTD_ITENS,"
  cQuery +=  CRLF + "Sum(GLOSADO + VL_APROV) VL_INFORMADO,"
  cQuery +=  CRLF + "Sum(GLOSADO) GLOSADO,"
  cQuery +=  CRLF + "Sum(VL_APROV) VL_APROV,"
  cQuery +=  CRLF + "Sum(VL_PARTICIPACAO) VL_PARTICIPACAO,"
  cQuery +=  CRLF + "Sum(VL_APROV - VL_PARTICIPACAO) CUSTO,"
  cQuery +=  CRLF + "PROC_JURID,"
  cQuery +=  CRLF + "Rol ,"
  cQuery +=  CRLF + "numfat ,"

  cQuery +=  CRLF + "DECODE(TRIM(numfat),'',' ',RETORNA_EMISSAO_FATURA('I',numfat)) DtCob "

  cQuery +=  CRLF + "FROM("
  cQuery +=  CRLF + " SELECT   BD7_CODPLA PLANO,"
  cQuery +=  CRLF + "BD6_YNEVEN Cod_Evento,"
  cQuery +=  CRLF + "ZZT_EVENTO Nome_Evento,"
  cQuery +=  CRLF + "QTDE,"
  cQuery +=  CRLF + "SUM(DECODE(BD7F.VLRPAG,0,0,QTD_EVENTO(BD6_CODPRO ,RETORNA_EVENTO_CAB ( BD6_OPEUSR,BD6_CODLDP, BD6_CODPEG,BD6_NUMERO,BD6_ORIMOV,BD6_CODPAD,BD6_CODPRO,'I' ),BD6F.BD6_QTDPRO))) Ocorrencia,"
  cQuery +=  CRLF + "Sum(BD6F.BD6_QTDPRO) qtd_itens,"
  cQuery +=  CRLF + "Sum(BD6F.BD6_VLRGLO) Glosado,"
  cQuery +=  CRLF + "Sum(BD7F.VLRPAG)  Vl_Aprov,"
  cQuery +=  CRLF + "sum(Decode(BD6F.BD6_BLOCPA,'1',0,Decode(Sign(BD6F.BD6_VLRTPF),-1,0,BD6F.BD6_VLRTPF))) Vl_Participacao,"
  cQuery +=  CRLF + "EXPOS EXPOSICAO_ANS , "
  cQuery +=  CRLF + "RETORNA_DESCRI_GRUPO_PLANO ( TRIM(BI3_YGRPLA),BD6_CODEMP,'I') GRUPO_PLANO,"
  cQuery +=  CRLF + "BI3_NREDUZ NOME_PLANO,"
  cQuery +=  CRLF + "ZZT_TPCUST,"
  cQuery +=  CRLF + "BD6_CODEMP,"
  cQuery +=  CRLF + "BG9_DESCRI,"
  cQuery +=  CRLF + "BD6_CODPRO COD_PROCED,"
  cQuery +=  CRLF + "BD6_DESPRO DESPRO,"
  cQuery +=  CRLF + "BD6_OPEUSR,BD6_MATRIC,BD6_TIPREG,BD6_DIGITO,"
  cQuery +=  CRLF + "BD6_NOMUSR NOME,"
  cQuery +=  CRLF + "BD6_CODLDP, BD6_CODPEG, BD6_NUMERO,"
  cQuery +=  CRLF + "To_Date(BD6_DATPRO,'YYYYMMDD') DATA,"
  cQuery +=  CRLF + "BD6_CODRDA RDA,"
  cQuery +=  CRLF + "PLS_RETORNA_NOME_RDA (BD6_CODRDA,'I') NOME_RDA,"
  cQuery +=  CRLF + "BD6_YPROJ PROJ,"
  cQuery +=  CRLF + "BD6_CODPAD TABELA,"
  cQuery +=  CRLF + "DESC_FAIXA_ETARIA (IDADE_MATRIC ( BD6_CODEMP,BD6_MATRIC,BD6_TIPREG,'I',BD6_DATPRO),4) FAIXA,"
  cQuery +=  CRLF + "decode(BD6_CODLDP,'0010','Recup Glosa','0019','Recup Glosa','0017','Rateio','Conta') Tipo,"
  cQuery +=  CRLF + "BD6_YPROJU PROC_JURID,"
  cQuery +=  CRLF + "'S' Rol , "
  cQuery +=  CRLF + "Bd6_numfat numfat"
  cQuery +=  CRLF + "FROM"
  cQuery +=  CRLF + "(SELECT BD7.BD7_FILIAL,BD7_CODPLA,SIGA_TIPO_EXPOSICAO_ANS_INT(BD7_CODEMP,BD7_MATRIC,BD7_TIPREG,To_Date(Trim(BD7_DATPRO),'YYYYMMDD')) EXPOS,"
  cQuery +=  CRLF + "BD7.BD7_OPELOT,BD7.BD7_NUMLOT,"
  cQuery +=  CRLF + "BD7.BD7_CODOPE, BD7.BD7_CODLDP, BD7.BD7_CODPEG, BD7.BD7_NUMERO, BD7.BD7_ORIMOV, BD7_CODPRO,"
  cQuery +=  CRLF + "BD7.BD7_SEQUEN,  Sum(BD7.BD7_VLRPAG) AS VLRPAG,"
  cQuery +=  CRLF + "COUNT(DISTINCT BD7_CODEMP||BD7_MATRIC||BD7_TIPREG) QTDE"
  cQuery +=  CRLF + "FROM BD7020 BD7"
  cQuery +=  CRLF + "WHERE BD7.BD7_FILIAL=' '"
  cQuery +=  CRLF + "AND BD7.BD7_CODOPE = '0001'"
  cQuery +=  CRLF + "AND BD7.BD7_SITUAC = '1'"
  cQuery +=  CRLF + "AND BD7.BD7_FASE = '4'"// --TODAS AS GUIAS PAGAS
  cQuery +=  CRLF + "AND BD7.BD7_BLOPAG <> '1'"
  cQuery +=  CRLF + "AND BD7.BD7_NUMLOT BETWEEN  '"+cCompet+"0000'  AND '"+cCompet+"9999'"
        
  cQuery +=  CRLF + "AND BD7.D_E_L_E_T_ = ' '"
  cQuery +=  CRLF + "GROUP BY BD7_FILIAL, BD7_CODPLA, BD7.BD7_OPELOT,BD7.BD7_NUMLOT,"
  cQuery +=  CRLF + "SIGA_TIPO_EXPOSICAO_ANS_INT(BD7_CODEMP,BD7_MATRIC,BD7_TIPREG,To_Date(Trim(BD7_DATPRO),'YYYYMMDD')),BD7_CODPRO,"
  cQuery +=  CRLF + "BD7_FILIAL, BD7_CODOPE, BD7_CODLDP, BD7_CODPEG, BD7_NUMERO, BD7_ORIMOV, BD7_SEQUEN) BD7F,"
  cQuery +=  CRLF + "BD6020 BD6F ,BI3020 BI3 ,ZZT010 ZZT ,BG9020 BG9"

  cQuery +=  CRLF + "WHERE ZZT_FILIAL=' '"
  cQuery +=  CRLF + "  AND BI3_FILIAL=' '"
  cQuery +=  CRLF + "  AND BD6F.BD6_FILIAL=' '"
  cQuery +=  CRLF + "  AND BG9_FILIAL=' '"

  cQuery +=  CRLF + "  AND BD7F.BD7_FILIAL = BD6F.BD6_FILIAL"
  cQuery +=  CRLF + "  AND BD7F.BD7_CODOPE = BD6F.BD6_CODOPE"
  cQuery +=  CRLF + "  AND BD7F.BD7_CODLDP = BD6F.BD6_CODLDP"
  cQuery +=  CRLF + "  AND BD7F.BD7_CODPEG = BD6F.BD6_CODPEG"
  cQuery +=  CRLF + "  AND BD7F.BD7_NUMERO = BD6F.BD6_NUMERO"
  cQuery +=  CRLF + "  AND BD7F.BD7_ORIMOV = BD6F.BD6_ORIMOV"
  cQuery +=  CRLF + "  AND BD7F.BD7_SEQUEN = BD6F.BD6_SEQUEN"
  cQuery +=  CRLF + "  AND BD6F.BD6_CODPRO = BD7F.BD7_CODPRO"

  cQuery +=  CRLF + "  AND BI3_FILIAL =BD7_FILIAL"
  cQuery +=  CRLF + "AND BI3_CODINT=BD7_CODOPE"
  cQuery +=  CRLF + "AND BI3_CODIGO=BD7_CODPLA"

  cQuery +=  CRLF + "AND BD6_YNEVEN=ZZT_CODEV"

  cQuery +=  CRLF + "AND BD6_OPEUSR=BG9_CODINT"
  cQuery +=  CRLF + "AND BD6_CODEMP=BG9_CODIGO"

  //cQuery +=  CRLF + "AND BD6_VLRTPF <> 0 "

  cQuery +=  CRLF + "     AND Decode(BD6F.BD6_BLOCPA,'1',0,Decode(Sign(BD6F.BD6_VLRTPF),-1,0,BD6F.BD6_VLRTPF)) <> 0 "

  cQuery +=  CRLF + "AND BD6F.D_E_L_E_T_ = ' '"
  cQuery +=  CRLF + "AND BI3.D_E_L_E_T_ = ' '"
  cQuery +=  CRLF + "AND ZZT.D_E_L_E_T_ = ' '"
  cQuery +=  CRLF + "AND BG9.D_E_L_E_T_ = ' '"

  cQuery +=  CRLF + "GROUP BY EXPOS,BD6_CODEMP,BG9_DESCRI,"
  cQuery +=  CRLF + "         BD7_CODPLA,"
  cQuery +=  CRLF + "         RETORNA_DESCRI_GRUPO_PLANO ( TRIM(BI3_YGRPLA),BD6_CODEMP,'I'),"
  cQuery +=  CRLF + "         BI3_NREDUZ,"
  cQuery +=  CRLF + "         BD6_YNEVEN,"
  cQuery +=  CRLF + "         ZZT_EVENTO,ZZT_TPCUST,QTDE,"
  cQuery +=  CRLF + "         BD6_CODPRO,"
  cQuery +=  CRLF + "         BD6_OPEUSR,BD6_MATRIC,BD6_TIPREG,BD6_DIGITO,"
  cQuery +=  CRLF + "         BD6_NOMUSR,"
  cQuery +=  CRLF + "         BD6_DESPRO ,"
  cQuery +=  CRLF + "         BD6_CODLDP, BD6_CODPEG, BD6_NUMERO,"
  cQuery +=  CRLF + "         BD6_CODRDA,"
  cQuery +=  CRLF + "         PLS_RETORNA_NOME_RDA (BD6_CODRDA,'I'),"
  cQuery +=  CRLF + "         BD6_YPROJ,"
  cQuery +=  CRLF + "         BD6_CODPAD ,"
  cQuery +=  CRLF + "         DESC_FAIXA_ETARIA (IDADE_MATRIC ( BD6_CODEMP,BD6_MATRIC,BD6_TIPREG,'I',BD6_DATPRO),4) ,"
  cQuery +=  CRLF + "         To_Date(BD6_DATPRO,'YYYYMMDD'),"
  cQuery +=  CRLF + "         BD6_YPROJU ,"
  cQuery +=  CRLF + "         Bd6_numfat"
  cQuery +=  CRLF + "   UNION ALL"

  // MATERIAL MICROSIGA

  cQuery +=  CRLF + " SELECT PLANO,"
  cQuery +=  CRLF + "        CODEVENTO,"
  cQuery +=  CRLF + "        NOME_EVENTO,"
  cQuery +=  CRLF + "        SUM(QTDE),"
  cQuery +=  CRLF + "        SUM(OCORRENCIA),"
  cQuery +=  CRLF + "        SUM(OCORRENCIA),"
  cQuery +=  CRLF + "        SUM(GLOSADO),"
  cQuery +=  CRLF + "        SUM(VL_APROV) VL_APROV,"
  cQuery +=  CRLF + "        SUM(VL_PARTICIPACAO) VL_PARTICIPACAO,"
  cQuery +=  CRLF + "        EXPOSICAO_ANS ,"
  cQuery +=  CRLF + "        GRUPO_PLANO,"
  cQuery +=  CRLF + "        NOME_PLANO,"
  cQuery +=  CRLF + "        ZZT_TPCUST ,"
  cQuery +=  CRLF + "        GRUPO_EMP,"
  cQuery +=  CRLF + "        DESC_EMP ,"
  cQuery +=  CRLF + "        COD_PROCED,"
  cQuery +=  CRLF + "        DESPRO,"
  cQuery +=  CRLF + "        BD6_OPEUSR,BD6_MATRIC,BD6_TIPREG,DIGITO,"
  cQuery +=  CRLF + "        BD6_NOMUSR,"
  cQuery +=  CRLF + "        BD6_CODLDP, BD6_CODPEG, BD6_NUMERO,"
  cQuery +=  CRLF + "        DATA,"
  cQuery +=  CRLF + "        BD6_CODRDA,"
  cQuery +=  CRLF + "        PLS_RETORNA_NOME_RDA (BD6_CODRDA,'I') NOME_RDA,"
  cQuery +=  CRLF + "        PROJ,"
  cQuery +=  CRLF + "        TABELA,"
  cQuery +=  CRLF + "        FAIXA,"
  cQuery +=  CRLF + "        'Material' Tipo,"
  cQuery +=  CRLF + "        PROC_JURID,"
  cQuery +=  CRLF + "        Rol , "
  cQuery +=  CRLF + "        numfat"
  cQuery +=  CRLF + "   FROM("

  cQuery +=  CRLF + "    SELECT DISTINCT"
  cQuery +=  CRLF + "    F1_YDTCON,"
  cQuery +=  CRLF + "    BD6_OPEUSR OPEUSR,"
  cQuery +=  CRLF + "    BD6_CODEMP CODEMP,"
  cQuery +=  CRLF + "    BD6_MATRIC MATRIC,"
  cQuery +=  CRLF + "    BD6_TIPREG TIPREG,"
  cQuery +=  CRLF + "    BD6_DIGITO DIGITO,"
  cQuery +=  CRLF + "    BD6_CODPLA PLANO,"
  cQuery +=  CRLF + "    BD6_YNEVEN CodEvento,"
  cQuery +=  CRLF + "    ZZT_EVENTO Nome_Evento,"
  cQuery +=  CRLF + "    1 QTDE,"
  cQuery +=  CRLF + "    1 Ocorrencia,"
  cQuery +=  CRLF + "    0 Glosado,"
  cQuery +=  CRLF + "    0 Vl_Aprov,"
  cQuery +=  CRLF + "    Nvl( BD7_VLRTPF,0) Vl_Participacao,"
  cQuery +=  CRLF + "    SIGA_TIPO_EXPOSICAO_ANS_INT(BD6_CODEMP,BD6_MATRIC,BD6_TIPREG,To_Date(Trim(BD6_DATPRO),'YYYYMMDD')) EXPOSICAO_ANS ,"
  cQuery +=  CRLF + "    RETORNA_DESCRI_GRUPO_PLANO ( TRIM(BI3_YGRPLA),BD6_CODEMP,'I') GRUPO_PLANO,"
  cQuery +=  CRLF + "    Decode(BD6_CODEMP,'0007',Trim(BI3_NREDUZ)||' (SEPE)',BI3_NREDUZ) NOME_PLANO,"
  cQuery +=  CRLF + "    ZZT_TPCUST ,"
  cQuery +=  CRLF + "    BD6_CODRDA RDA ,"
  cQuery +=  CRLF + "    BD6_CODPRO COD_PROCED,"
  cQuery +=  CRLF + "    Trim(BD6_DESPRO) DESPRO,"
  cQuery +=  CRLF + "    BG9_CODIGO GRUPO_EMP,BG9_DESCRI DESC_EMP ,B19_DOC ,"
  cQuery +=  CRLF + "    BD6_OPEUSR,BD6_MATRIC,BD6_TIPREG ,"
  cQuery +=  CRLF + "    To_Date(BD6_DATPRO,'YYYYMMDD') DATA,"
  cQuery +=  CRLF + "    BD6_CODLDP, BD6_CODPEG, BD6_NUMERO,"
  cQuery +=  CRLF + "    BD6_CODRDA,"
  cQuery +=  CRLF + "    BD6_NOMUSR,"
  cQuery +=  CRLF + "    BD6_CODPAD TABELA,"
  cQuery +=  CRLF + "    DESC_FAIXA_ETARIA (IDADE_MATRIC ( BD6_CODEMP,BD6_MATRIC,BD6_TIPREG,'I',BD6_DATPRO),4) FAIXA,"
  cQuery +=  CRLF + "    BD6_YPROJ PROJ,"
  cQuery +=  CRLF + "    BD6_YPROJU PROC_JURID,"
  cQuery +=  CRLF + "    'S' Rol , "
  cQuery +=  CRLF + "    bd6_numfat numfat" 

  cQuery +=  CRLF + "    FROM SIGA.B19020 B19, SIGA.SD1020 SD1, SIGA.SF1020 SF1, SIGA.BD6020 BD6 ,SIGA.SA2020 SA2, ZZT010 ZZT ,BI3020 BI3 ,BD7020 BD7 ,BG9020 BG9"

  cQuery +=  CRLF + "    WHERE BI3_FILIAL=' '"
  cQuery +=  CRLF + "    AND A2_FILIAL=' '"
  cQuery +=  CRLF + "    AND B19_FILIAL=' '"
  cQuery +=  CRLF + "    AND BG9_FILIAL=' '"
  cQuery +=  CRLF + "    AND F1_YDTCON BETWEEN '"+cCompet+"01'  AND '"+cCompet+"31'"
  cQuery +=  CRLF + "    AND D1_FILIAL='01'"
  cQuery +=  CRLF + "    AND F1_FILIAL='01'"
  cQuery +=  CRLF + "    AND BD7_FILIAL=' '"
  cQuery +=  CRLF + "    AND A2_COD = B19_FORNEC"
  cQuery +=  CRLF + "    AND D1_FORNECE= A2_COD"
  cQuery +=  CRLF + "    AND f1_FORNECE= A2_COD"
  cQuery +=  CRLF + "    AND D1_DOC = F1_DOC"
  cQuery +=  CRLF + "    AND B19_DOC = D1_DOC"
  cQuery +=  CRLF + "    AND D1_ITEM = B19_ITEM"
  cQuery +=  CRLF + "    AND BD6_FILIAL = ' '"
  cQuery +=  CRLF + "    AND ZZT_FILIAL=' '"
  cQuery +=  CRLF + "    AND BD6_CODPLA=BI3_CODIGO"
  cQuery +=  CRLF + "    AND BD6_CODOPE = SubStr(B19_GUIA,01,04)"
  cQuery +=  CRLF + "    AND BD6_CODLDP = SubStr(B19_GUIA,05,04)"
  cQuery +=  CRLF + "    AND BD6_CODPEG = SubStr(B19_GUIA,09,08)"
  cQuery +=  CRLF + "    AND BD6_NUMERO = SubStr(B19_GUIA,17,08)"
  cQuery +=  CRLF + "    AND BD6_ORIMOV = SubStr(B19_GUIA,25,01)"
  cQuery +=  CRLF + "    AND BD6_SEQUEN = SubStr(B19_GUIA,26,03)"
  cQuery +=  CRLF + "    AND BD7_CODPRO IN ('01990012','02990016','03990010')"
  cQuery +=  CRLF + "    AND BD7_CODOPE = BD6_CODOPE"
  cQuery +=  CRLF + "    AND BD7_CODLDP = BD6_CODLDP"
  cQuery +=  CRLF + "    AND BD7_CODPEG = BD6_CODPEG"
  cQuery +=  CRLF + "    AND BD7_NUMERO = BD6_NUMERO"
  cQuery +=  CRLF + "    AND BD6_FASE IN ('3','4')"
  cQuery +=  CRLF + "    AND BD6_CODLDP='0013'"
  cQuery +=  CRLF + "    AND BD6_SITUAC = '1'"
  cQuery +=  CRLF + "    AND BD6_YNEVEN=ZZT_CODEV"
  cQuery +=  CRLF + "    AND BD6_OPEUSR=BG9_CODINT"
  cQuery +=  CRLF + "    AND BD6_CODEMP=BG9_CODIGO"

  cQuery +=  CRLF + "    AND BD7_VLRTPF <> 0 "

  cQuery +=  CRLF + "    AND SA2.D_E_L_E_T_ = ' '"
  cQuery +=  CRLF + "    AND B19.D_E_L_E_T_ = ' '"
  cQuery +=  CRLF + "    AND BG9.D_E_L_E_T_ = ' '"
  cQuery +=  CRLF + "    AND SD1.D_E_L_E_T_ = ' '"
  cQuery +=  CRLF + "    AND SF1.D_E_L_E_T_ = ' '"
  cQuery +=  CRLF + "    AND BD6.D_E_L_E_T_ = ' '"
  cQuery +=  CRLF + "    AND ZZT.D_E_L_E_T_ = ' '"
  cQuery +=  CRLF + "    AND BI3.D_E_L_E_T_ = ' '"
  cQuery +=  CRLF + "    AND BD7.D_E_L_E_T_ = ' ')"
  cQuery +=  CRLF + "    GROUP BY  PLANO,  NOME_EVENTO,"
  cQuery +=  CRLF + "    CODEVENTO,"
  cQuery +=  CRLF + "    GRUPO_PLANO,"
  cQuery +=  CRLF + "    NOME_PLANO,"
  cQuery +=  CRLF + "    EXPOSICAO_ANS,ZZT_TPCUST,"
  cQuery +=  CRLF + "    GRUPO_EMP,"
  cQuery +=  CRLF + "    DESC_EMP ,"
  cQuery +=  CRLF + "    COD_PROCED,"
  cQuery +=  CRLF + "    DESPRO ,BD6_NOMUSR,"
  cQuery +=  CRLF + "    BD6_CODLDP, BD6_CODPEG, BD6_NUMERO,"
  cQuery +=  CRLF + "    PLS_RETORNA_NOME_RDA (BD6_CODRDA,'I'),FAIXA,TABELA,"
  cQuery +=  CRLF + "    BD6_OPEUSR,BD6_MATRIC,BD6_TIPREG,DIGITO,BD6_CODRDA,data,PROJ,"
  cQuery +=  CRLF + "    PROC_JURID, Rol , numfat )"
  ///FIM MATERIAL MICROSIGA
  cQuery +=  CRLF + "    where RDA=NVL(TRIM(' '),RDA)"
  cQuery +=  CRLF + "    AND BD6_CODEMP=NVL(TRIM(' '),BD6_CODEMP)"
  cQuery +=  CRLF + "    GROUP BY " //--REFER,
  cQuery +=  CRLF + "    EXPOSICAO_ANS ,"
  cQuery +=  CRLF + "    GRUPO_PLANO,"
  cQuery +=  CRLF + "    NOME_PLANO,"
  cQuery +=  CRLF + "    (CASE WHEN Trim(PROJ) IS NULL THEN 'Custo Fora do Projeto'"
  cQuery +=  CRLF + "    ELSE 'Custo Projeto '||Trim(PROJ) END) ,"
  cQuery +=  CRLF + "    Decode(ZZT_TPCUST,'A','AMBULATORIAL','H','HOSPITALAR','O','ODONTOLOGICO','') ,"
  cQuery +=  CRLF + "    COD_EVENTO,"
  cQuery +=  CRLF + "    NOME_EVENTO,"
  cQuery +=  CRLF + "    COD_PROCED,"
  cQuery +=  CRLF + "    DESPRO,data,"
  cQuery +=  CRLF + "    ZZT_TPCUST,"
  cQuery +=  CRLF + "    Trim(PROJ),Trim (BG9_DESCRI),"
  cQuery +=  CRLF + "    PLANO,NOME_RDA,"
  cQuery +=  CRLF + "    BD6_OPEUSR,BD6_CODEMP,BD6_MATRIC,BD6_TIPREG,BD6_DIGITO,"
  cQuery +=  CRLF + "    BD6_CODLDP, BD6_CODPEG, BD6_NUMERO,NOME,FAIXA,RDA,TABELA,tipo,PROC_JURID, Rol , numfat,"
  cQuery +=  CRLF + "    DECODE(TRIM(numfat),'',' ',RETORNA_EMISSAO_FATURA('I',numfat)) "

elseIf cEmpAnt == '01' 
//////////////////////////////////////
//////////////////////caberj /////////////////////////
/************************************ MICROSIGA PAGO******************************************/
  cQuery := "SELECT  /*+first_rows index_asc(BD7 BD70205)*/"
  cQuery +=  CRLF + "EXPOSICAO_ANS ANS,"
  cQuery +=  CRLF + "GRUPO_PLANO,"
  cQuery +=  CRLF + "NOME_PLANO,"
  cQuery +=  CRLF + "(CASE WHEN Trim(PROJ) IS NULL THEN 'Custo Fora do Projeto'"
  cQuery +=  CRLF + "      ELSE 'Custo Projeto '||DECODE(Trim(PROJ),'AAI','AAG',Trim(PROJ)) END) PROJ,"
  cQuery +=  CRLF + "Decode(ZZT_TPCUST,'A','AMBULATORIAL','H','HOSPITALAR','O','ODONTOLOGICO','') TPCUST,"
  cQuery +=  CRLF + "COD_EVENTO,"
  cQuery +=  CRLF + "NOME_EVENTO,"
  cQuery +=  CRLF + "COD_PROCED,"
  cQuery +=  CRLF + "DESPRO,"
  cQuery +=  CRLF + "ZZT_TPCUST,"
  cQuery +=  CRLF + "PLANO,"
  cQuery +=  CRLF + "NOME_RDA,"
  cQuery +=  CRLF + "RDA,"
  cQuery +=  CRLF + "BD6_CODLDP LOCAL, BD6_CODPEG PEG, BD6_NUMERO NUMERO,"
  cQuery +=  CRLF + "TABELA,"
  cQuery +=  CRLF + "BD6_OPEUSR,BD6_CODEMP,BD6_MATRIC,BD6_TIPREG,BD6_DIGITO,"
  cQuery +=  CRLF + "RETORNA_DESC_CONTRATO('C',BD6_OPEUSR,BD6_CODEMP,BD6_CONEMP) CONTRATO,"
  cQuery +=  CRLF + "NOME,"
  cQuery +=  CRLF + "FAIXA,"
  cQuery +=  CRLF + "tipo,"
  cQuery +=  CRLF + "Trim (BG9_DESCRI) EMPRESA,"
  cQuery +=  CRLF + "DECODE(Trim(PROJ),'AAI','AAG',Trim(PROJ)) CODPROJ,"
  cQuery +=  CRLF + "Sum(QTDE) QTDE,"
  cQuery +=  CRLF + "Sum(OCORRENCIA) OCORRENCIA,"
  cQuery +=  CRLF + "Sum(QTD_ITENS) QTD_ITENS,"
  cQuery +=  CRLF + "Sum(GLOSADO + VL_APROV) VL_INFORMADO,"
  cQuery +=  CRLF + "Sum(GLOSADO) GLOSADO,"
  cQuery +=  CRLF + "Sum(VL_APROV) VL_APROV,"
  cQuery +=  CRLF + "SUM(VL_PARTICIPACAO) VL_PARTICIPACAO,"
  cQuery +=  CRLF + "SUM(VL_APROV - VL_PARTICIPACAO) CUSTO,"
  cQuery +=  CRLF + "RETORNA_DESC_ESP_MS (CODESP) ESPRDA,"
  cQuery +=  CRLF + "PROC_JURID,"
  cQuery +=  CRLF + "Rol ,"
  cQuery +=  CRLF + "numfat ,"

  cQuery +=  CRLF + "DECODE(TRIM(numfat),'',' ',RETORNA_EMISSAO_FATURA('C',numfat)) DtCob "

  cQuery +=  CRLF + "FROM("
  cQuery +=  CRLF + "     SELECT BD7_CODPLA PLANO,"
  cQuery +=  CRLF + "     BD6_YNEVEN Cod_Evento,"
  cQuery +=  CRLF + "     ZZT_EVENTO Nome_Evento,"
  cQuery +=  CRLF + "     QTDE,"
  cQuery +=  CRLF + "     SUM(DECODE(BD7F.VLRPAG,0,0,QTD_EVENTO(BD6_CODPRO ,RETORNA_EVENTO_CAB ( BD6_OPEUSR,BD6_CODLDP, BD6_CODPEG,BD6_NUMERO,BD6_ORIMOV,BD6_CODPAD,BD6_CODPRO,'C' ),BD6F.BD6_QTDPRO))) Ocorrencia, "
  cQuery +=  CRLF + "     Sum(BD6F.BD6_QTDPRO) qtd_itens,"             
  cQuery +=  CRLF + "     Sum(BD6F.BD6_VLRGLO) Glosado,"
  cQuery +=  CRLF + "     Sum(BD7F.VLRPAG)  Vl_Aprov,"
  cQuery +=  CRLF + "     Sum(case when BD6F.BD6_BLOCPA='1' then 0"
  cQuery +=  CRLF + "     when Sign(BD6F.BD6_VLRTPF)=-1 then 0 "
  cQuery +=  CRLF + "     when BD6_CODEMP in ('0004','0009') then 0"
  cQuery +=  CRLF + "     when (BD6_CODEMP in ('0013','0017') and "
  cQuery +=  CRLF + "     To_Date(Trim(BD6_DATPRO),'YYYYMMDD')>=to_date('01-08-2021','dd-mm-yyyy')) then 0"
  cQuery +=  CRLF + "     else BD6F.BD6_VLRTPF end) Vl_Participacao,"
              //--sum(Decode(BD6F.BD6_BLOCPA,'1',0,Decode(Sign(BD6F.BD6_VLRTPF),-1,0,Decode(BD6_CODEMP,'0004',0,'0009',0,BD6F.BD6_VLRTPF)))) Vl_Participacao,
  cQuery +=  CRLF + "     EXPOS EXPOSICAO_ANS , "
  cQuery +=  CRLF + "     RETORNA_DESCRI_GRUPO_PLANO ( TRIM(BI3_YGRPLA),BD6_CODEMP,'C') GRUPO_PLANO,"
  cQuery +=  CRLF + "     BI3_NREDUZ NOME_PLANO,"
  cQuery +=  CRLF + "     ZZT_TPCUST,"
  cQuery +=  CRLF + "     BD6_CODEMP,"
  cQuery +=  CRLF + "     BG9_DESCRI,"
  cQuery +=  CRLF + "     BD6_CODPRO COD_PROCED,"
  cQuery +=  CRLF + "     BD6_DESPRO DESPRO,"
  cQuery +=  CRLF + "     BD6_OPEUSR,BD6_MATRIC,BD6_TIPREG,BD6_DIGITO,"
  cQuery +=  CRLF + "     BD6_NOMUSR NOME,"
  cQuery +=  CRLF + "     BD6_CODLDP, BD6_CODPEG, BD6_NUMERO,"
  cQuery +=  CRLF + "     To_Date(BD6_DATPRO,'YYYYMMDD') DATA,"
  cQuery +=  CRLF + "     BD6_CODRDA RDA,"
  cQuery +=  CRLF + "     PLS_RETORNA_NOME_RDA (BD6_CODRDA)NOME_RDA,"
  cQuery +=  CRLF + "     BD6_YPROJ PROJ,"
  cQuery +=  CRLF + "     BD6_CODPAD TABELA,"
  cQuery +=  CRLF + "     DESC_FAIXA_ETARIA (IDADE_MATRIC ( BD6_CODEMP,BD6_MATRIC,BD6_TIPREG,'C',BD6_DATPRO),4) FAIXA,"
  cQuery +=  CRLF + "     decode(BD6_CODLDP,'0010','Recup Glosa','0019','Recup Glosa','0017','Rateio','Conta') TIPO,"
  cQuery +=  CRLF + "     BD6_CODESP CODESP,"
  cQuery +=  CRLF + "     BD6_CONEMP,"
  cQuery +=  CRLF + "     BD6_YPROJU PROC_JURID,"
  cQuery +=  CRLF + "     'S' Rol , "
  cQuery +=  CRLF + "     Bd6_numfat numfat "             
  cQuery +=  CRLF + "     FROM  (SELECT BD7.BD7_FILIAL,BD7_CODPLA,SIGA_TIPO_EXPOSICAO_ANS(BD7_CODEMP,BD7_MATRIC,BD7_TIPREG,To_Date(Trim(BD7_DATPRO),'YYYYMMDD')) EXPOS,"
  cQuery +=  CRLF + "     BD7.BD7_OPELOT,BD7.BD7_NUMLOT,"
  cQuery +=  CRLF + "     BD7.BD7_CODOPE, BD7.BD7_CODLDP, BD7.BD7_CODPEG, BD7.BD7_NUMERO, BD7.BD7_ORIMOV, BD7_CODPRO,"
  cQuery +=  CRLF + "     BD7.BD7_SEQUEN,  Sum(BD7.BD7_VLRPAG) AS VLRPAG,"
  cQuery +=  CRLF + "     COUNT(DISTINCT BD7_CODEMP||BD7_MATRIC||BD7_TIPREG) QTDE"
  cQuery +=  CRLF + "     FROM BD7010 BD7"
  cQuery +=  CRLF + "     WHERE BD7.BD7_FILIAL=' '"
  cQuery +=  CRLF + "     AND BD7.BD7_CODOPE = '0001'"
  cQuery +=  CRLF + "     AND BD7.BD7_SITUAC = '1'"
  cQuery +=  CRLF + "     AND BD7.BD7_FASE = '4'" //--TODAS AS GUIAS PAGAS
  cQuery +=  CRLF + "     AND BD7.BD7_BLOPAG <> '1'"

  cQuery +=  CRLF + "     AND BD7.BD7_NUMLOT BETWEEN  '"+cCompet+"0000'  AND '"+cCompet+"9999'"

        //-- AND BD7.bd7_VLRPAG <> 0
  cQuery +=  CRLF + "     AND BD7.D_E_L_E_T_ = ' '"
  cQuery +=  CRLF + "     GROUP BY BD7_FILIAL, BD7_CODPLA, BD7.BD7_OPELOT,BD7.BD7_NUMLOT,"
  cQuery +=  CRLF + "     SIGA_TIPO_EXPOSICAO_ANS(BD7_CODEMP,BD7_MATRIC,BD7_TIPREG,To_Date(Trim(BD7_DATPRO),'YYYYMMDD')),BD7_CODPRO,"
  cQuery +=  CRLF + "     BD7_FILIAL, BD7_CODOPE, BD7_CODLDP, BD7_CODPEG, BD7_NUMERO, BD7_ORIMOV, BD7_SEQUEN) BD7F," 
  cQuery +=  CRLF + "     BD6010 BD6F ,BI3010 BI3 ,ZZT010 ZZT ,BG9010 BG9"

  cQuery +=  CRLF + "     WHERE ZZT_FILIAL=' '"
  cQuery +=  CRLF + "     AND BI3_FILIAL=' '"
  cQuery +=  CRLF + "     AND BD6F.BD6_FILIAL=' '"
  cQuery +=  CRLF + "     AND BG9_FILIAL=' '"

//  cQuery +=  CRLF + "     AND BD6_VLRTPF <> 0 "

  cQuery +=  CRLF + "     AND case when BD6F.BD6_BLOCPA='1' then 0 "
  cQuery +=  CRLF + "         when Sign(BD6F.BD6_VLRTPF)=-1 then 0 "
  cQuery +=  CRLF + "         when BD6_CODEMP in ('0004','0009') then 0 "
  cQuery +=  CRLF + "         when (BD6_CODEMP in ('0013','0017') and "
  cQuery +=  CRLF + "         To_Date(Trim(BD6_DATPRO),'YYYYMMDD')>=to_date('01-08-2021','dd-mm-yyyy')) then 0 "
  cQuery +=  CRLF + "         else BD6F.BD6_VLRTPF end <> 0 "
     
  cQuery +=  CRLF + "     AND BD7F.BD7_FILIAL = BD6F.BD6_FILIAL"
  cQuery +=  CRLF + "     AND BD7F.BD7_CODOPE = BD6F.BD6_CODOPE"
  cQuery +=  CRLF + "     AND BD7F.BD7_CODLDP = BD6F.BD6_CODLDP"
  cQuery +=  CRLF + "     AND BD7F.BD7_CODPEG = BD6F.BD6_CODPEG"
  cQuery +=  CRLF + "     AND BD7F.BD7_NUMERO = BD6F.BD6_NUMERO"
  cQuery +=  CRLF + "     AND BD7F.BD7_ORIMOV = BD6F.BD6_ORIMOV"
  cQuery +=  CRLF + "     AND BD7F.BD7_SEQUEN = BD6F.BD6_SEQUEN"
  cQuery +=  CRLF + "     AND BD6F.BD6_CODPRO = BD7F.BD7_CODPRO"

  cQuery +=  CRLF + "     AND BI3_FILIAL =BD7_FILIAL"
  cQuery +=  CRLF + "     AND BI3_CODINT=BD7_CODOPE"
  cQuery +=  CRLF + "     AND BI3_CODIGO=BD7_CODPLA"

  cQuery +=  CRLF + "     AND BD6_YNEVEN=ZZT_CODEV"

  cQuery +=  CRLF + "     AND BD6_OPEUSR=BG9_CODINT"
  cQuery +=  CRLF + "     AND BD6_CODEMP=BG9_CODIGO"

  cQuery +=  CRLF + "     AND BD6F.D_E_L_E_T_ = ' '"
  cQuery +=  CRLF + "     AND BI3.D_E_L_E_T_ = ' '"
  cQuery +=  CRLF + "     AND ZZT.D_E_L_E_T_ = ' '"
  cQuery +=  CRLF + "     AND BG9.D_E_L_E_T_ = ' '"

  cQuery +=  CRLF + "     GROUP BY EXPOS,BD6_CODEMP,BG9_DESCRI,"
  cQuery +=  CRLF + "     BD7_CODPLA,"
  cQuery +=  CRLF + "     RETORNA_DESCRI_GRUPO_PLANO ( TRIM(BI3_YGRPLA),BD6_CODEMP,'C'),"
  cQuery +=  CRLF + "     BI3_NREDUZ,"
  cQuery +=  CRLF + "     BD6_YNEVEN,"
  cQuery +=  CRLF + "     ZZT_EVENTO,ZZT_TPCUST,QTDE,"
  cQuery +=  CRLF + "     BD6_CODPRO,"
  cQuery +=  CRLF + "     BD6_OPEUSR,BD6_MATRIC,BD6_TIPREG,BD6_DIGITO,"
  cQuery +=  CRLF + "     BD6_NOMUSR,"
  cQuery +=  CRLF + "     BD6_DESPRO ,"
  cQuery +=  CRLF + "     BD6_CODLDP, BD6_CODPEG, BD6_NUMERO,"
  cQuery +=  CRLF + "     BD6_CODRDA,"
  cQuery +=  CRLF + "     PLS_RETORNA_NOME_RDA (BD6_CODRDA),"
  cQuery +=  CRLF + "     BD6_YPROJ,BD6_CODPAD ,"
  cQuery +=  CRLF + "     decode(BD6_CODLDP,'0010','Recup Glosa','0019','Recup Glosa','0017','Rateio','Conta'),"
  cQuery +=  CRLF + "     DESC_FAIXA_ETARIA (IDADE_MATRIC ( BD6_CODEMP,BD6_MATRIC,BD6_TIPREG,'C',BD6_DATPRO),4),"
  cQuery +=  CRLF + "     TO_DATE(BD6_DATPRO,'YYYYMMDD'),"
  cQuery +=  CRLF + "     BD6_CODESP ,BD6_CONEMP,BD6_YPROJU ,"
  cQuery +=  CRLF + "     Bd6_numfat"

  cQuery +=  CRLF + "  UNION"

  //-- MATERIAL MICROSIGA

  cQuery +=  CRLF + " SELECT PLANO,"
  cQuery +=  CRLF + " CODEVENTO,"
  cQuery +=  CRLF + " NOME_EVENTO,"
  cQuery +=  CRLF + " SUM(QTDE),"
  cQuery +=  CRLF + " SUM(OCORRENCIA),"
  cQuery +=  CRLF + " SUM(OCORRENCIA),"
  cQuery +=  CRLF + " SUM(GLOSADO),"
  cQuery +=  CRLF + " SUM(VL_APROV)  VL_APROV,"
  cQuery +=  CRLF + " SUM(VL_PARTICIPACAO) VL_PARTICIPACAO,"
  cQuery +=  CRLF + " EXPOSICAO_ANS ,"
  cQuery +=  CRLF + " GRUPO_PLANO,"
  cQuery +=  CRLF + " NOME_PLANO,"
  cQuery +=  CRLF + " ZZT_TPCUST ,"
  cQuery +=  CRLF + " GRUPO_EMP,"
  cQuery +=  CRLF + " DESC_EMP ,"
  cQuery +=  CRLF + " COD_PROCED,"
  cQuery +=  CRLF + " DESPRO,"
  cQuery +=  CRLF + " BD6_OPEUSR,BD6_MATRIC,BD6_TIPREG,DIGITO,"
  cQuery +=  CRLF + " BD6_NOMUSR,"
  cQuery +=  CRLF + " BD6_CODLDP, BD6_CODPEG, BD6_NUMERO,"
  cQuery +=  CRLF + " DATA,"
  cQuery +=  CRLF + " BD6_CODRDA,"
  cQuery +=  CRLF + " PLS_RETORNA_NOME_RDA (BD6_CODRDA)NOME_RDA,"
  cQuery +=  CRLF + " PROJ,"
  cQuery +=  CRLF + " TABELA,"
  cQuery +=  CRLF + " FAIXA,"
  cQuery +=  CRLF + " 'Material' TIPO,"
  cQuery +=  CRLF + " CODESP,"
  cQuery +=  CRLF + " BD6_CONEMP,"
  cQuery +=  CRLF + " PROC_JURID,"
  cQuery +=  CRLF + " Rol, "
  cQuery +=  CRLF + " numfat"
  cQuery +=  CRLF + " FROM("

  cQuery +=  CRLF + "       SELECT DISTINCT"
  cQuery +=  CRLF + "       F1_YDTCON,"
  cQuery +=  CRLF + "       BD6_OPEUSR OPEUSR,"
  cQuery +=  CRLF + "       BD6_CODEMP CODEMP,"
  cQuery +=  CRLF + "       BD6_MATRIC MATRIC,"
  cQuery +=  CRLF + "       BD6_TIPREG TIPREG,"
  cQuery +=  CRLF + "       BD6_DIGITO DIGITO,"
  cQuery +=  CRLF + "       BD6_CODPLA PLANO,"
  cQuery +=  CRLF + "       BD6_YNEVEN CodEvento,"
  cQuery +=  CRLF + "       ZZT_EVENTO Nome_Evento,"
  cQuery +=  CRLF + "       1 QTDE,"
  cQuery +=  CRLF + "       1 Ocorrencia,"
  cQuery +=  CRLF + "       0 Glosado,"
  cQuery +=  CRLF + "       0 Vl_Aprov,"
  cQuery +=  CRLF + "       Nvl( BD7_VLRTPF,0) Vl_Participacao,"
  cQuery +=  CRLF + "       SIGA_TIPO_EXPOSICAO_ANS(BD6_CODEMP,BD6_MATRIC,BD6_TIPREG,To_Date(Trim(BD6_DATPRO),'YYYYMMDD')) EXPOSICAO_ANS ,"
  cQuery +=  CRLF + "       RETORNA_DESCRI_GRUPO_PLANO ( TRIM(BI3_YGRPLA),BD6_CODEMP,'C') GRUPO_PLANO,"
  cQuery +=  CRLF + "       Decode(BD6_CODEMP,'0007',Trim(BI3_NREDUZ)||' (SEPE)',BI3_NREDUZ) NOME_PLANO,"
  cQuery +=  CRLF + "       ZZT_TPCUST ,"
  cQuery +=  CRLF + "       BD6_CODRDA RDA ,"
  cQuery +=  CRLF + "       BD6_CODPRO COD_PROCED,"
  cQuery +=  CRLF + "       Trim(BD6_DESPRO) DESPRO,"
  cQuery +=  CRLF + "       BG9_CODIGO GRUPO_EMP,BG9_DESCRI DESC_EMP ,B19_DOC ,"
  cQuery +=  CRLF + "       BD6_OPEUSR,BD6_MATRIC,BD6_TIPREG ,"
  cQuery +=  CRLF + "       To_Date(BD6_DATPRO,'YYYYMMDD') DATA,"
  cQuery +=  CRLF + "       BD6_CODLDP, BD6_CODPEG, BD6_NUMERO,"
  cQuery +=  CRLF + "       BD6_CODRDA,"
  cQuery +=  CRLF + "       BD6_NOMUSR,"
  cQuery +=  CRLF + "       BD6_CODPAD TABELA,"
  cQuery +=  CRLF + "       DESC_FAIXA_ETARIA (IDADE_MATRIC ( BD6_CODEMP,BD6_MATRIC,BD6_TIPREG,'C',BD6_DATPRO),4) FAIXA,"
  cQuery +=  CRLF + "       BD6_YPROJ PROJ,"
  cQuery +=  CRLF + "       BD6_CODESP CODESP,"
  cQuery +=  CRLF + "       BD6_CONEMP,"
  cQuery +=  CRLF + "       BD6_YPROJU PROC_JURID,"
  cQuery +=  CRLF + "       'S' Rol, "
  cQuery +=  CRLF + "       bd6_numfat numfat"

  cQuery +=  CRLF + "       FROM SIGA.B19010 B19, SIGA.SD1010 SD1, SIGA.SF1010 SF1, SIGA.BD6010 BD6 ,"
  cQuery +=  CRLF + "            SIGA.SA2010 SA2, ZZT010 ZZT ,BI3010 BI3 ,BD7010 BD7 ,BG9010 BG9 "

  cQuery +=  CRLF + "       WHERE BI3_FILIAL=' '"
  cQuery +=  CRLF + "       AND A2_FILIAL=' '"
  cQuery +=  CRLF + "       AND B19_FILIAL=' '"
  cQuery +=  CRLF + "       AND BG9_FILIAL=' '"

  cQuery +=  CRLF + "       AND F1_YDTCON BETWEEN '"+cCompet+"01'  AND '"+cCompet+"31'"

  cQuery +=  CRLF + "       AND D1_FILIAL='01'"
  cQuery +=  CRLF + "       AND F1_FILIAL='01'"
  cQuery +=  CRLF + "       AND BD7_FILIAL=' '"
  cQuery +=  CRLF + "       AND A2_COD = B19_FORNEC"
  cQuery +=  CRLF + "       AND D1_FORNECE= A2_COD"
  cQuery +=  CRLF + "       AND f1_FORNECE= A2_COD"
  cQuery +=  CRLF + "       AND D1_DOC = F1_DOC"
  cQuery +=  CRLF + "       AND B19_DOC = D1_DOC"
  cQuery +=  CRLF + "       AND D1_ITEM = B19_ITEM"
  cQuery +=  CRLF + "       AND BD6_FILIAL = ' '"
  cQuery +=  CRLF + "       AND ZZT_FILIAL=' '"
  cQuery +=  CRLF + "       AND BD6_CODPLA=BI3_CODIGO"
  cQuery +=  CRLF + "       AND BD6_CODOPE = SubStr(B19_GUIA,01,04)"
  cQuery +=  CRLF + "       AND BD6_CODLDP = SubStr(B19_GUIA,05,04)"
  cQuery +=  CRLF + "       AND BD6_CODPEG = SubStr(B19_GUIA,09,08)"
  cQuery +=  CRLF + "       AND BD6_NUMERO = SubStr(B19_GUIA,17,08)"
  cQuery +=  CRLF + "       AND BD6_ORIMOV = SubStr(B19_GUIA,25,01)"
  cQuery +=  CRLF + "       AND BD6_SEQUEN = SubStr(B19_GUIA,26,03)"
  cQuery +=  CRLF + "       AND BD7_CODPRO IN ('01990012','02990016','03990010')"
  cQuery +=  CRLF + "       AND BD7_CODOPE = BD6_CODOPE"
  cQuery +=  CRLF + "       AND BD7_CODLDP = BD6_CODLDP"
  cQuery +=  CRLF + "       AND BD7_CODPEG = BD6_CODPEG"
  cQuery +=  CRLF + "       AND BD7_NUMERO = BD6_NUMERO"
  cQuery +=  CRLF + "       AND BD6_FASE IN ('3','4')"
  cQuery +=  CRLF + "       AND BD6_CODLDP='0013'"
  cQuery +=  CRLF + "       AND BD6_SITUAC = '1'"
  cQuery +=  CRLF + "       AND BD6_YNEVEN=ZZT_CODEV"
  cQuery +=  CRLF + "       AND BD6_OPEUSR=BG9_CODINT"
  cQuery +=  CRLF + "       AND BD6_CODEMP=BG9_CODIGO"

  cQuery +=  CRLF + "       AND BD7_VLRTPF <> 0 "

  cQuery +=  CRLF + "       AND SA2.D_E_L_E_T_ = ' '"
  cQuery +=  CRLF + "       AND B19.D_E_L_E_T_ = ' '"
  cQuery +=  CRLF + "       AND BG9.D_E_L_E_T_ = ' '"
  cQuery +=  CRLF + "       AND SD1.D_E_L_E_T_ = ' '"
  cQuery +=  CRLF + "       AND SF1.D_E_L_E_T_ = ' '"
  cQuery +=  CRLF + "       AND BD6.D_E_L_E_T_ = ' '"
  cQuery +=  CRLF + "       AND ZZT.D_E_L_E_T_ = ' '"
  cQuery +=  CRLF + "       AND BI3.D_E_L_E_T_ = ' '"
  cQuery +=  CRLF + "       AND BD7.D_E_L_E_T_ = ' ')"
  cQuery +=  CRLF + "       GROUP BY PLANO, NOME_EVENTO,"
  cQuery +=  CRLF + "       CODEVENTO,"
  cQuery +=  CRLF + "       GRUPO_PLANO,"
  cQuery +=  CRLF + "       NOME_PLANO,"
  cQuery +=  CRLF + "       EXPOSICAO_ANS,ZZT_TPCUST,"
  cQuery +=  CRLF + "       GRUPO_EMP,"
  cQuery +=  CRLF + "       DESC_EMP ,"
  cQuery +=  CRLF + "       COD_PROCED,"
  cQuery +=  CRLF + "       DESPRO ,BD6_NOMUSR,"
  cQuery +=  CRLF + "       BD6_CODLDP, BD6_CODPEG, BD6_NUMERO,"
  cQuery +=  CRLF + "       PLS_RETORNA_NOME_RDA (BD6_CODRDA),"
  cQuery +=  CRLF + "       TABELA,"
  cQuery +=  CRLF + "       FAIXA,"
  cQuery +=  CRLF + "       BD6_OPEUSR,BD6_MATRIC,BD6_TIPREG,DIGITO,BD6_CODRDA,data,PROJ,CODESP,BD6_CONEMP,"
  cQuery +=  CRLF + "       PROC_JURID,"
  cQuery +=  CRLF + "       Rol, numfat )"
  //FIM MATERIAL MICROSIGA
  cQuery +=  CRLF + " WHERE RDA=Nvl(Trim(' '),RDA)"
  cQuery +=  CRLF + " GROUP BY " //--REFER,
  cQuery +=  CRLF + "       EXPOSICAO_ANS,"
  cQuery +=  CRLF + "       GRUPO_PLANO,"
  cQuery +=  CRLF + "       NOME_PLANO,"
  cQuery +=  CRLF + "       (CASE WHEN Trim(PROJ) IS NULL THEN 'Custo Fora do Projeto'"
  cQuery +=  CRLF + "             ELSE 'Custo Projeto '||DECODE(Trim(PROJ),'AAI','AAG',Trim(PROJ)) END) ,"
  cQuery +=  CRLF + "       Decode(ZZT_TPCUST,'A','AMBULATORIAL','H','HOSPITALAR','') ,"
  cQuery +=  CRLF + "       COD_EVENTO,"
  cQuery +=  CRLF + "       NOME_EVENTO,"
  cQuery +=  CRLF + "       COD_PROCED,"
  cQuery +=  CRLF + "       DESPRO,"
  cQuery +=  CRLF + "       ZZT_TPCUST,"
  cQuery +=  CRLF + "       DECODE(TRIM(PROJ),'AAI','AAG',TRIM(PROJ)),TRIM (BG9_DESCRI),"
  cQuery +=  CRLF + "       RETORNA_DESC_CONTRATO('C',BD6_OPEUSR,BD6_CODEMP,BD6_CONEMP),"
  cQuery +=  CRLF + "       PLANO,NOME_RDA,"
  cQuery +=  CRLF + "       FAIXA,"
  cQuery +=  CRLF + "       BD6_OPEUSR,BD6_CODEMP,BD6_MATRIC,BD6_TIPREG,BD6_DIGITO,"
  cQuery +=  CRLF + "       BD6_CODLDP, BD6_CODPEG, BD6_NUMERO,NOME,RDA,TABELA,tipo,RETORNA_DESC_ESP_MS (CODESP),"
  cQuery +=  CRLF + "       PROC_JURID ,"
  cQuery +=  CRLF + "       Rol , "
  cQuery +=  CRLF + "       numfat , "

  cQuery +=  CRLF + "DECODE(TRIM(numfat),'',' ',RETORNA_EMISSAO_FATURA('C',numfat)) "

EndIf 

/************************************ FIM MICROSIGA PAGO******************************************/

///////////////////////////////////////////////////////
 If Select(("TMP")) <> 0 
      ("TMP")->(DbCloseArea()) 
   Endif
    
    TCQuery cQuery Alias "TMP" New 
                                                                                           
    dbSelectArea("TMP")

    tmp->(dbGoTop())  

    FGrvPlan6()    
    

Return () 

Static Function FGrvPlan6()    

If cEmpAnt == '01'   
   cNomDadCab:= cEmp+' - 6 - ExtraÁ„o de coparticipaÁ„o e suas data de cobranÁa - Caberj '   
   cNomPla   := cEmp+' - 6 - ExtraÁ„o de coparticipaÁ„o e suas data de cobranÁa - Caberj '
ElseIf cEmpAnt == '02' 
   cNomDadCab:= cEmp+' - 6 - ExtraÁ„o de coparticipaÁ„o e suas data de cobranÁa - Integral '   
   cNomPla   := cEmp+' - 6 - ExtraÁ„o de coparticipaÁ„o e suas data de cobranÁa - Integral '
EndIf 
   cComp     := SUBSTR(mv_par01,4,4) +'/'+ SUBSTR(mv_par01,1,2) 
   cNomeArq  := "C:\TEMP\" + SUBSTR(mv_par01,1,2) + SUBSTR(mv_par01,4,4) + " - "+cNomDadCab+"_"+SubStr(DtoS(date()),7,2)+"_"+SubStr(DtoS(date()),5,2)+"_"+SubStr(DtoS(date()),1,4)+"_"+STRTRAN(TIME(),":","_")+".csv"

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

   cMontaTxt := "Cod.PLano  ;"
   cMontaTxt += "Nome Plano ;"

   cMontaTxt += "Cod. Rda   ;"
   cMontaTxt += "Nome Rda   ;"

   cMontaTxt += "Cod. Empresa ;"
   cMontaTxt += "Matr. Benef. ;"
   cMontaTxt += "TipReg       ;"
   cMontaTxt += "Nome Benef.  ;"

   cMontaTxt += "Vl Apresent. ;" 
   cMontaTxt += "Vl Glosado   ;" 
   cMontaTxt += "Vl Aprovado  ;"
   cMontaTxt += "Vl Copartic  ;"
   cMontaTxt += "Vl Custo     ;" 
 
   cMontaTxt += "numfat	      ;" 
   
   cMontaTxt += "Dt. CobranÁa;" 
		
   cMontaTxt += CRLF // Salto de linha para .csv (excel)
             
   FWrite(nHandle,cMontaTxt)
   
   tmp->(dbGoTop())                    
   
   While !(TMP->(Eof()))

	    cMontaTxt := tmp->PLANO      +";"     
	    cMontaTxt += tmp->NOME_PLANO +";"
	    cMontaTxt += tmp->RDA        +";"
      cMontaTxt += tmp->NOME_RDA   +";"
      cMontaTxt += tmp->BD6_CODEMP +";"
      cMontaTxt += tmp->BD6_MATRIC +";"
      cMontaTxt += tmp->BD6_TIPREG +";"
      cMontaTxt += tmp->NOME       +";"
      cMontaTxt += Transform(tmp->VL_INFORMADO    ,'@E 999,999,999.99') + ";"
      cMontaTxt += Transform(tmp->GLOSADO         ,'@E 999,999,999.99') + ";"
      cMontaTxt += Transform(tmp->VL_APROV        ,'@E 999,999,999.99') + ";"
      cMontaTxt += Transform(tmp->VL_PARTICIPACAO ,'@E 999,999,999.99') + ";"
      cMontaTxt += Transform(tmp->CUSTO           ,'@E 999,999,999.99') + ";"
	    cMontaTxt += tmp->numfat      +";"
	    cMontaTxt += substr(tmp->DtCob,7,2)+'/'+substr(tmp->DtCob,5,2)+'/'+substr(tmp->DtCob,1,4) +";"

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

  	MsgAlert("Relatorio salvo em: " + CRLF +cNomeArq1)
   
Return ()        

