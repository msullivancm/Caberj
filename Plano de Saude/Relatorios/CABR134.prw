#INCLUDE "rwmake.ch"
#INCLUDE "protheus.ch"
#INCLUDE "TopConn.ch"
#include "TBICONN.CH"    

#DEFINE c_ent CHR(13) + CHR(10)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABR134      ºAutor  ³ PAULO MOTTA        º Data ³ MARCO/2014  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³  GERA PLANILHA PARA CONFERENCIA DE REAJUSTE DE MENSALIDADES   º±± 
±±º          ³  (MAPREC)                                                     º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Projeto CABERJ                                                º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function CABR134()   
      
Processa({||PCABR134()},'Processando...')

Return

Static Function PCABR134

Local aSaveArea	:= {} 

Local aCabec := {}
Local aDados := {} 

Local cRefDe  := " " 
Local cRefAte := " "  
Local dDatAux := CTOD("  /  /  ")
Local cAno    := " "
Local cMes    := " "
Local nI 	  := 0   

Private cPerg := "CAB134"

aSaveArea	:= GetArea()
AjustaSX1()    

/*ler parametro*/ 
If Pergunte(cPerg,.T.)  
    dDatAux := MonthSub(mv_par01,23)
    cRefDe  := Substr(DToS(MonthSub(mv_par01,23)),1,6) 
    cRefAte := Substr(DToS(mv_par01),1,6)   
    cAno    := Substr(DToS(mv_par01),1,4) 
    cMes    := Substr(DToS(mv_par01),5,2) 
else
    Return	
EndIf      

/*Monta query */
cQuery := " SELECT RETORNA_GRUPO_PLANO_MS('C',BA1_CODINT,BA1_CODEMP,BA1_MATRIC,BA1_TIPREG) GRUPOPLANO,  " + c_ent
cQuery += "        RETORNA_DESC_PLANO_MS('C',BA1_CODINT,BA1_CODEMP,BA1_MATRIC,BA1_TIPREG) PLANO, " + c_ent 
cQuery += "        (BA1_CODINT||BA1_CODEMP||BA1_MATRIC||BA1_TIPREG||BA1_DIGITO) MATRIC, " + c_ent 
cQuery += "        BA1_NOMUSR NOME, " + c_ent 
cQuery += "        BA1_MATVID MATVID, " + c_ent 
cQuery += "        IDADE_S(BA1_DATNAS) IDADE, " + c_ent 
cQuery += "        FORMATA_DATA_MS(BA1_DATNAS) DATNAS, " + c_ent 
cQuery += "        FORMATA_DATA_MS(NVL(TRIM(BA1_DATINC),BA3_DATBLO)) DATINC, " + c_ent 
cQuery += "        FORMATA_DATA_MS(NVL(TRIM(BA1_DATBLO),BA3_DATBLO)) DATBLO, " + c_ent 
cQuery += "        BM1_CODTIP CODTIP, " + c_ent 
cQuery += "        BM1_CODTIP||'-'||BFQ_DESCRI COBRANCA, " + c_ent 
cQuery += "        FORMATA_DATA_MS(TRIM(BA3_DATCIV)) DAT_CIV, " + c_ent 
cQuery += "        TRUNC(MONTHS_BETWEEN(TO_DATE('" + cRefAte + "','YYYYMM'), " + c_ent 
cQuery += "                             TO_DATE(TRIM(BA3_DATCIV),'YYYYMMDD'))) MESES_CONTR, " + c_ent 
cQuery += "        PESQ_RETORNA_QTD_FAIXA(BA1_CODINT,BA1_CODEMP,BA1_MATRIC,BA1_TIPREG,'" + cAno + "') QTD_FAIXAS, " + c_ent        
cQuery += "        DESC_FAIXA, " + c_ent 
cQuery += "        BA1_TIPUSU TIPUSU, " + c_ent 
cQuery += "        BRP_DESCRI GRAU_PAREN," + c_ent 
cQuery += "        BA3_MESREA MESREA, " + c_ent 
cQuery += "        BA3_INDREA INDREA, " + c_ent 
cQuery += "        DECODE(BA3_TIPPAG,'00','SEM ENVIO', " + c_ent    
cQuery += "                          '01','PREVI', " + c_ent 
cQuery += "                          '02','LIQ'," + c_ent 
cQuery += "                          '03','EMP', " + c_ent   
cQuery += "                          '04','112', " + c_ent 
cQuery += "                          '05','175', " + c_ent 
cQuery += "                          '06','SISDEB', " + c_ent       
cQuery += "                          '07','ITAU', " + c_ent 
cQuery += "                          '08','PREVI','') TIPPAG, " + c_ent   
cQuery += "        DECODE(BM1_CODTIP,'101',REAJ.OBS,'') OBS, " + c_ent 
cQuery += "        DECODE(BA1_MUDFAI,'0','NAO','1','SIM','SIM') MUDAFAIXA, " + c_ent 
cQuery += "        BM1_CODFAI CODFAI, " + c_ent  
cQuery += "        (CASE WHEN BM1_CODTIP = '101' THEN (LPAD(BM1_IDAINI,3,'0') || ' A ' || LPAD(BM1_IDAFIN,3,'0')) ELSE ' ' END) FX_COBRADA, " + c_ent 
cQuery += "        IND_SITUACAO_JUDICIAL('C',BA1_CODINT,BA1_CODEMP,BA1_MATRIC,BA1_TIPREG) IND_SIT_JUD, " + c_ent    
cQuery += "        SUM(CASE WHEN BM1_ANO||BM1_MES = TO_CHAR(ADD_MONTHS(TO_DATE('" + cRefAte + "','YYYYMM'),-23),'YYYYMM') THEN (DECODE(BM1_TIPO,'1',1,-1) * BM1_VALOR) ELSE 0 END) M01, " + c_ent 
cQuery += "        SUM(CASE WHEN BM1_ANO||BM1_MES = TO_CHAR(ADD_MONTHS(TO_DATE('" + cRefAte + "','YYYYMM'),-22),'YYYYMM') THEN (DECODE(BM1_TIPO,'1',1,-1) * BM1_VALOR) ELSE 0 END) M02, " + c_ent
cQuery += "        SUM(CASE WHEN BM1_ANO||BM1_MES = TO_CHAR(ADD_MONTHS(TO_DATE('" + cRefAte + "','YYYYMM'),-21),'YYYYMM') THEN (DECODE(BM1_TIPO,'1',1,-1) * BM1_VALOR) ELSE 0 END) M03, " + c_ent 
cQuery += "        SUM(CASE WHEN BM1_ANO||BM1_MES = TO_CHAR(ADD_MONTHS(TO_DATE('" + cRefAte + "','YYYYMM'),-20),'YYYYMM') THEN (DECODE(BM1_TIPO,'1',1,-1) * BM1_VALOR) ELSE 0 END) M04, " + c_ent 
cQuery += "        SUM(CASE WHEN BM1_ANO||BM1_MES = TO_CHAR(ADD_MONTHS(TO_DATE('" + cRefAte + "','YYYYMM'),-19),'YYYYMM') THEN (DECODE(BM1_TIPO,'1',1,-1) * BM1_VALOR) ELSE 0 END) M05, " + c_ent       
cQuery += "        SUM(CASE WHEN BM1_ANO||BM1_MES = TO_CHAR(ADD_MONTHS(TO_DATE('" + cRefAte + "','YYYYMM'),-18),'YYYYMM') THEN (DECODE(BM1_TIPO,'1',1,-1) * BM1_VALOR) ELSE 0 END) M06, " + c_ent 
cQuery += "        SUM(CASE WHEN BM1_ANO||BM1_MES = TO_CHAR(ADD_MONTHS(TO_DATE('" + cRefAte + "','YYYYMM'),-17),'YYYYMM') THEN (DECODE(BM1_TIPO,'1',1,-1) * BM1_VALOR) ELSE 0 END) M07, " + c_ent
cQuery += "        SUM(CASE WHEN BM1_ANO||BM1_MES = TO_CHAR(ADD_MONTHS(TO_DATE('" + cRefAte + "','YYYYMM'),-16),'YYYYMM') THEN (DECODE(BM1_TIPO,'1',1,-1) * BM1_VALOR) ELSE 0 END) M08, " + c_ent 
cQuery += "        SUM(CASE WHEN BM1_ANO||BM1_MES = TO_CHAR(ADD_MONTHS(TO_DATE('" + cRefAte + "','YYYYMM'),-15),'YYYYMM') THEN (DECODE(BM1_TIPO,'1',1,-1) * BM1_VALOR) ELSE 0 END) M09, " + c_ent 
cQuery += "        SUM(CASE WHEN BM1_ANO||BM1_MES = TO_CHAR(ADD_MONTHS(TO_DATE('" + cRefAte + "','YYYYMM'),-14),'YYYYMM') THEN (DECODE(BM1_TIPO,'1',1,-1) * BM1_VALOR) ELSE 0 END) M10, " + c_ent  
cQuery += "        SUM(CASE WHEN BM1_ANO||BM1_MES = TO_CHAR(ADD_MONTHS(TO_DATE('" + cRefAte + "','YYYYMM'),-13),'YYYYMM') THEN (DECODE(BM1_TIPO,'1',1,-1) * BM1_VALOR) ELSE 0 END) M11, " + c_ent 
cQuery += "        SUM(CASE WHEN BM1_ANO||BM1_MES = TO_CHAR(ADD_MONTHS(TO_DATE('" + cRefAte + "','YYYYMM'),-12),'YYYYMM') THEN (DECODE(BM1_TIPO,'1',1,-1) * BM1_VALOR) ELSE 0 END) M12, " + c_ent  
cQuery += "        SUM(CASE WHEN BM1_ANO||BM1_MES = TO_CHAR(ADD_MONTHS(TO_DATE('" + cRefAte + "','YYYYMM'),-11),'YYYYMM') THEN (DECODE(BM1_TIPO,'1',1,-1) * BM1_VALOR) ELSE 0 END) M13, " + c_ent 
cQuery += "        SUM(CASE WHEN BM1_ANO||BM1_MES = TO_CHAR(ADD_MONTHS(TO_DATE('" + cRefAte + "','YYYYMM'),-10),'YYYYMM') THEN (DECODE(BM1_TIPO,'1',1,-1) * BM1_VALOR) ELSE 0 END) M14, " + c_ent  
cQuery += "        SUM(CASE WHEN BM1_ANO||BM1_MES = TO_CHAR(ADD_MONTHS(TO_DATE('" + cRefAte + "','YYYYMM'),-09),'YYYYMM') THEN (DECODE(BM1_TIPO,'1',1,-1) * BM1_VALOR) ELSE 0 END) M15, " + c_ent 
cQuery += "        SUM(CASE WHEN BM1_ANO||BM1_MES = TO_CHAR(ADD_MONTHS(TO_DATE('" + cRefAte + "','YYYYMM'),-08),'YYYYMM') THEN (DECODE(BM1_TIPO,'1',1,-1) * BM1_VALOR) ELSE 0 END) M16, " + c_ent  
cQuery += "        SUM(CASE WHEN BM1_ANO||BM1_MES = TO_CHAR(ADD_MONTHS(TO_DATE('" + cRefAte + "','YYYYMM'),-07),'YYYYMM') THEN (DECODE(BM1_TIPO,'1',1,-1) * BM1_VALOR) ELSE 0 END) M17, " + c_ent 
cQuery += "        SUM(CASE WHEN BM1_ANO||BM1_MES = TO_CHAR(ADD_MONTHS(TO_DATE('" + cRefAte + "','YYYYMM'),-06),'YYYYMM') THEN (DECODE(BM1_TIPO,'1',1,-1) * BM1_VALOR) ELSE 0 END) M18, " + c_ent  
cQuery += "        SUM(CASE WHEN BM1_ANO||BM1_MES = TO_CHAR(ADD_MONTHS(TO_DATE('" + cRefAte + "','YYYYMM'),-05),'YYYYMM') THEN (DECODE(BM1_TIPO,'1',1,-1) * BM1_VALOR) ELSE 0 END) M19, " + c_ent 
cQuery += "        SUM(CASE WHEN BM1_ANO||BM1_MES = TO_CHAR(ADD_MONTHS(TO_DATE('" + cRefAte + "','YYYYMM'),-04),'YYYYMM') THEN (DECODE(BM1_TIPO,'1',1,-1) * BM1_VALOR) ELSE 0 END) M20, " + c_ent   
cQuery += "        SUM(CASE WHEN BM1_ANO||BM1_MES = TO_CHAR(ADD_MONTHS(TO_DATE('" + cRefAte + "','YYYYMM'),-03),'YYYYMM') THEN (DECODE(BM1_TIPO,'1',1,-1) * BM1_VALOR) ELSE 0 END) M21, " + c_ent  
cQuery += "        SUM(CASE WHEN BM1_ANO||BM1_MES = TO_CHAR(ADD_MONTHS(TO_DATE('" + cRefAte + "','YYYYMM'),-02),'YYYYMM') THEN (DECODE(BM1_TIPO,'1',1,-1) * BM1_VALOR) ELSE 0 END) M22, " + c_ent 
cQuery += "        SUM(CASE WHEN BM1_ANO||BM1_MES = TO_CHAR(ADD_MONTHS(TO_DATE('" + cRefAte + "','YYYYMM'),-01),'YYYYMM') THEN (DECODE(BM1_TIPO,'1',1,-1) * BM1_VALOR) ELSE 0 END) M23, " + c_ent   
cQuery += "        SUM(CASE WHEN BM1_ANO||BM1_MES = TO_CHAR(ADD_MONTHS(TO_DATE('" + cRefAte + "','YYYYMM'),000),'YYYYMM') THEN (DECODE(BM1_TIPO,'1',1,-1) * BM1_VALOR) ELSE 0 END) M24, " + c_ent  
cQuery += "        PESQ_TABELA_RET_VL_CORRETO2(BA1_CODINT,BA1_CODEMP,BA1_MATRIC,BA1_TIPREG,'" + cAno + "','" + cMes + "') VLTABELA  " + c_ent 
cQuery += " FROM   SIGA.BM1010 , SIGA.BA3010, SIGA.BA1010, SIGA.BFQ010, " + c_ent       
cQuery += "        (SELECT  BM1X.BM1_FILIAL FILIAL, " + c_ent 
cQuery += "                 BM1X.BM1_CODINT CODINT, " + c_ent 
cQuery += "                 BM1X.BM1_CODEMP CODEMP, " + c_ent 
cQuery += "                 BM1X.BM1_MATRIC MATRIC, " + c_ent 
cQuery += "                 BM1X.BM1_TIPREG TIPREG, " + c_ent 
cQuery += "                 (CASE WHEN COUNT(DISTINCT BM1_CODFAI) > 1 THEN 'FX' " + c_ent 
cQuery += "                       WHEN COUNT(DISTINCT BM1_VALOR)  > 1  THEN 'RE' " + c_ent 
cQuery += "                       ELSE '  ' END) OBS " + c_ent 
cQuery += "         FROM   SIGA.BM1010 BM1X" + c_ent 
cQuery += "         WHERE  BM1X.BM1_FILIAL = '  ' " + c_ent 
cQuery += "         AND    BM1X.BM1_CODINT = '0001' " + c_ent  
cQuery += "         AND    BM1X.BM1_CODEMP IN ('0001','0002','0003','0005') " + c_ent 
cQuery += "         AND    BM1X.BM1_ANO||BM1_MES BETWEEN '" + cRefDe + "' AND '" + cRefAte + "'" + c_ent 
cQuery += "         AND    BM1X.BM1_CODTIP  = '101' " + c_ent    
cQuery += "         AND    BM1X.D_E_L_E_T_ = ' '" + c_ent 
cQuery += "         GROUP BY BM1X.BM1_FILIAL," + c_ent 
cQuery += "                  BM1X.BM1_CODINT, " + c_ent 
cQuery += "                  BM1X.BM1_CODEMP, " + c_ent 
cQuery += "                  BM1X.BM1_MATRIC, " + c_ent 
cQuery += "                  BM1X.BM1_TIPREG) REAJ , FAIXA_ETARIA FE, " + c_ent 
cQuery += "        (SELECT BRP_CODIGO , BRP_DESCRI   " + c_ent 
cQuery += "         FROM   BRP010 " + c_ent 
cQuery += "         WHERE  BRP_FILIAL = '  ' " + c_ent 
cQuery += "         AND    D_E_L_E_T_ = ' ') BRP " + c_ent 
cQuery += " WHERE  BM1_FILIAL = '  ' " + c_ent 
cQuery += " AND    BM1_CODINT = '0001' " + c_ent 
cQuery += " AND    BM1_CODEMP IN ('0001','0002','0003','0005') " + c_ent 
cQuery += " AND    BM1_ANO||BM1_MES BETWEEN '" + cRefDe + "' AND '" + cRefAte + "' " + c_ent 
cQuery += " AND    BA1_FILIAL = BM1_FILIAL " + c_ent   
cQuery += " AND    BA1_CODINT = BM1_CODINT " + c_ent 
cQuery += " AND    BA1_CODEMP = BM1_CODEMP " + c_ent 
cQuery += " AND    BA1_MATRIC = BM1_MATRIC " + c_ent 
cQuery += " AND    BA1_TIPREG = BM1_TIPREG " + c_ent   
cQuery += " AND    BA3_CODEMP IN ('0001','0002','0003','0005') " + c_ent 
cQuery += " AND    BA1_FILIAL = BA3_FILIAL " + c_ent 
cQuery += " AND    BA1_CODINT = BA3_CODINT " + c_ent 
cQuery += " AND    BA1_CODEMP = BA3_CODEMP " + c_ent 
cQuery += " AND    BA1_MATRIC = BA3_MATRIC " + c_ent      
cQuery += " AND    BFQ_FILIAL = BM1_FILIAL " + c_ent 
cQuery += " AND    BFQ_CODINT = BM1_CODINT " + c_ent 
cQuery += " AND    BFQ_PROPRI = SUBSTR(BM1_CODTIP,1,1) " + c_ent 
cQuery += " AND    BFQ_CODLAN = SUBSTR(BM1_CODTIP,2,3) " + c_ent 
cQuery += " AND    BFQ_YTPANL = 'M' " + c_ent 
cQuery += " AND    BM1_CODTIP NOT IN ('102','103') " + c_ent 
cQuery += " AND    REAJ.FILIAL = BM1_FILIAL " + c_ent 
cQuery += " AND    REAJ.CODINT = BM1_CODINT " + c_ent   
cQuery += " AND    REAJ.CODEMP = BM1_CODEMP " + c_ent 
cQuery += " AND    REAJ.MATRIC = BM1_MATRIC " + c_ent 
cQuery += " AND    REAJ.TIPREG = BM1_TIPREG " + c_ent 
cQuery += " AND    BA3_MESREA = NVL(TRIM(''),BA3_MESREA) " + c_ent 
cQuery += " AND    TIPO_FAIXA =" + c_ent   
cQuery += "        DECODE(RETORNA_QTD_FAIXA_ATUARIA(BA1_CODINT,BA1_CODEMP,BA1_MATRIC,BA1_TIPREG,'" + cAno + "'),7,2,8,1,10,3,3) " + c_ent 
cQuery += " AND    IDADE_S(BA1_DATNAS) BETWEEN IDADE_INICIAL AND IDADE_FINAL " + c_ent 
cQuery += " AND    BRP_CODIGO (+) = BA1_GRAUPA " + c_ent 


cQuery += " AND    BM1010.D_E_L_E_T_ = ' ' " + c_ent 
cQuery += " AND    BA3010.D_E_L_E_T_ = ' ' " + c_ent 
cQuery += " AND    BA1010.D_E_L_E_T_ = ' ' " + c_ent 
cQuery += " AND    BFQ010.D_E_L_E_T_ = ' ' " + c_ent  
cQuery += " GROUP BY RETORNA_GRUPO_PLANO_MS('C',BA1_CODINT,BA1_CODEMP,BA1_MATRIC,BA1_TIPREG), " + c_ent 
cQuery += "          RETORNA_DESC_PLANO_MS('C',BA1_CODINT,BA1_CODEMP,BA1_MATRIC,BA1_TIPREG), " + c_ent 
cQuery += "          (BA1_CODINT||BA1_CODEMP||BA1_MATRIC||BA1_TIPREG||BA1_DIGITO)," + c_ent 
cQuery += "          BA1_NOMUSR,  " + c_ent 
cQuery += "          BA1_MATVID , " + c_ent   
cQuery += "          IDADE_S(BA1_DATNAS)  , " + c_ent 
cQuery += "          FORMATA_DATA_MS(BA1_DATNAS), " + c_ent 
cQuery += "          FORMATA_DATA_MS(NVL(TRIM(BA1_DATINC),BA3_DATBLO)) , " + c_ent 
cQuery += "          FORMATA_DATA_MS(NVL(TRIM(BA1_DATBLO),BA3_DATBLO)), " + c_ent 
cQuery += "          BM1_CODTIP, " + c_ent   
cQuery += "          BM1_CODTIP||'-'||BFQ_DESCRI," + c_ent 
cQuery += "          FORMATA_DATA_MS(TRIM(BA3_DATCIV)), " + c_ent 
cQuery += "          TRUNC(MONTHS_BETWEEN(TO_DATE('" + cRefAte + "','YYYYMM')," + c_ent 
cQuery += "                               TO_DATE(TRIM(BA3_DATCIV),'YYYYMMDD'))), " + c_ent 
cQuery += "          PESQ_RETORNA_QTD_FAIXA(BA1_CODINT,BA1_CODEMP,BA1_MATRIC,BA1_TIPREG,'" + cAno + "'), " + c_ent 
cQuery += "          DESC_FAIXA, " + c_ent 
cQuery += "          BA1_TIPUSU , " + c_ent 
cQuery += "          BRP_DESCRI , " + c_ent 
cQuery += "          BA3_MESREA , " + c_ent 
cQuery += "          BA3_INDREA , " + c_ent  
cQuery += "          DECODE(BA3_TIPPAG,'00','SEM ENVIO', " + c_ent 
cQuery += "                            '01','PREVI', " + c_ent 
cQuery += "                            '02','LIQ', " + c_ent 
cQuery += "                            '03','EMP', " + c_ent 
cQuery += "                            '04','112', " + c_ent 
cQuery += "                            '05','175', " + c_ent   
cQuery += "                            '06','SISDEB', " + c_ent 
cQuery += "                            '07','ITAU', " + c_ent 
cQuery += "                            '08','PREVI',''), " + c_ent     
cQuery += "          DECODE(BM1_CODTIP,'101',REAJ.OBS,''), " + c_ent 
cQuery += "          DECODE(BA1_MUDFAI,'0','NAO','1','SIM','SIM'), " + c_ent 
cQuery += "          BM1_CODFAI, " + c_ent 
cQuery += "          (CASE WHEN BM1_CODTIP = '101' THEN (LPAD(BM1_IDAINI,3,'0') || ' A ' || LPAD(BM1_IDAFIN,3,'0')) ELSE ' ' END), " + c_ent 
cQuery += "          PESQ_TABELA_RET_VL_CORRETO2(BA1_CODINT,BA1_CODEMP,BA1_MATRIC,BA1_TIPREG,'" + cAno + "','" + cMes + "'),  " + c_ent  
cQuery += "          IND_SITUACAO_JUDICIAL('C',BA1_CODINT,BA1_CODEMP,BA1_MATRIC,BA1_TIPREG) " + c_ent   
cQuery += " ORDER BY 5,4,3,10  "      

memowrite("C:\sql134.sql",cQuery)      

If Select("R134") > 0
	dbSelectArea("R134")
	dbCloseArea()
EndIf

DbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),"R134",.T.,.T.)         

For nI := 1 to 5
	IncProc('Processando...')
Next

If ! R134->(Eof())
	nSucesso := 0
    // Monta Cabecalho "Fixo"
	aCabec := {"GRUPOPLANO","PLANO","MATRIC","NOME","MATVID","IDADE","DATNAS","DATINC","DATBLO","CODTIP","COBRANCA","DAT_CIV","MESES_CONTR",;
	           "QTD_FAIXAS","DESC_FAIXA","TIPUSU","GRAU_PAREN","MESREA","INDREA","TIPPAG","OBS","MUDAFAIXA","CODFAI","FX_COBRADA","IND_SIT_JUD"} 
   
    // Monta Cabecalho "Variaveis"
	FOR NI := 1 TO 24     
        AADD(ACABEC,Substr(DToS(dDatAux),1,6))
		dDatAux := MonthSum(dDatAux,1)	    	
	NEXT   
	
	// Monta Cabecalho "Fixo"
	AADD(ACABEC,"VLTABELA")
	
	R134->(DbGoTop())
	While ! R134->(Eof()) 
		IncProc()
		
		AADD(aDados,{R134->GRUPOPLANO,R134->PLANO,R134->MATRIC,R134->NOME,R134->MATVID,R134->IDADE,R134->DATNAS,R134->DATINC,R134->DATBLO,;
		             R134->CODTIP,R134->COBRANCA,R134->DAT_CIV,R134->MESES_CONTR,R134->QTD_FAIXAS,R134->DESC_FAIXA,R134->TIPUSU,R134->GRAU_PAREN,;
		             R134->MESREA,R134->INDREA,R134->TIPPAG,R134->OBS,R134->MUDAFAIXA,R134->CODFAI,R134->FX_COBRADA,R134->IND_SIT_JUD,;
		             R134->M01,R134->M02,R134->M03,R134->M04,R134->M05,R134->M06,;   
		             R134->M07,R134->M08,R134->M09,R134->M10,R134->M11,R134->M12,;
		             R134->M13,R134->M14,R134->M15,R134->M16,R134->M17,R134->M18,;
		             R134->M19,R134->M20,R134->M21,R134->M22,R134->M23,R134->M24,;
		             R134->VLTABELA})  
		
		R134->(DbSkip())
	End
	 
	//Abre excel 
    DlgToExcel({{"ARRAY"," " ,aCabec,aDados}})

EndIf	

If Select("R134") > 0
	dbSelectArea("R134")
	dbCloseArea()
EndIf      

 
*************************************************************************************************************************
//AJUSTAR "COPPRO"
Static Function AjustaSX1      

 
Local aHelpPor := {}
//Monta Help

PutSx1(cPerg,"01","Referencia  "  ,"","","mv_ch01","D",08,0,0,"C","","","","","mv_par01","","","","","","","","","","","","","","","","",{},{},{})

Return	