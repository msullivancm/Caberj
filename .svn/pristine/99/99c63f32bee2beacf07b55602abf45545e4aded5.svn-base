#INCLUDE "PROTHEUS.CH"
#INCLUDE "TopConn.Ch"
#include "PLSMGER.CH"
#INCLUDE "FONT.CH"
#include "PRTOPDEF.CH"

#DEFINE c_ent CHR(13) + CHR(10)
/*
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±…ÕÕÕÕÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÕÕÕÀÕÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÀÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÕÕÕª±±
±±∫Programa  ≥CONCOP       ∫Autor  ?ANDERSON RANGEL   ?Data ?FEVEREIRO/21 ∫±?
±±ÃÕÕÕÕÕÕÕÕÕÕÿÕÕÕÕÕÕÕÕÕÕÕÕÕ ÕÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕ ÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕÕÕπ±±
±±∫Desc.     ? GERA PLANILHAS EXCEL PARA CONFERENCIA DE COPARTICIP«’ES      ∫±?
±±?         ? COM OP«¬O DE CHAMAR O CRYSTAL DE MESMO NOME                  ∫±?
±±ÃÕÕÕÕÕÕÕÕÕÕÿÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕπ±±
±±∫Uso       ? Projeto CABERJ                                               ∫±?
±±»ÕÕÕÕÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕº±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
*/

User Function CONCOP()

Local aSaveArea	:= {} 
Local aCabec    := {}
Local aDados    := {} 
Local cEmp      := ""
Local cMes      := ""  
Local cAno      := ""  
Local cEmpini   := ""
Local cEmpate   := ""
Local cAgremp   := ""
local cGera     := ""
Local nI 	    := 0 
Local nSucesso  := 0    

Private cCRPar      := "1;0;1;Relatorio de Conferencia das Coparticipacoes" 
Private cParam1     := "" 
Private cCrystal    := "CONCOP"

Private cPerg := "CONCOP"

aSaveArea	:= GetArea()
AjustaSX1()    

//ler parametros 
If Pergunte(cPerg,.T.)  
   	cEmp    := mv_par01
    cAno    := mv_par02 
 	cMes    := mv_par03 
    cEmpini := mv_par04
    cEmpate := mv_par05
    cAgremp := mv_par06
    cGera   := mv_par07
else
    Return	
EndIf   

If cGera == 1
    IF cEmp = 1 
        cQuery := "SELECT decode(BD6_CODLDP,'0010','Rec','0019','Rec','0017','Rat','Con') TIPO, " + c_ent
        cQuery += "    BD6_ANOPAG||'/'||BD6_MESPAG REF,	" + c_ent
        cQuery += "    BD6_CODEMP CODEMP, RETORNA_DESCRI_GRUPOEMP ( 'C', BD6_CODEMP) EMPRESA,	" + c_ent
        cQuery += "    TRIM(RETORNA_DESCRI_GRUPO_COBERT('C',substr(RETORNA_GRUPO_COBERT ( 'C',BD6_CODPAD,BD6_CODPRO,  'G'),1,3))) GRUPO_COBERT , " + c_ent
        cQuery += "    TO_DATE(TRIM(BD6_DATPRO),'YYYYMMDD') DATPRO, " + c_ent
        cQuery += "    BD6_CODPRO COD_PROCED, " + c_ent
        cQuery += "    BD6_DESPRO DESPRO , " + c_ent
        cQuery += "    BD6_YPROJ PROJ, " + c_ent
        cQuery += "    BD6_OPEUSR ||'.'|| BD6_CODEMP ||'.'|| BD6_MATRIC ||'.'|| BD6_TIPREG ||'-'||BD6_DIGITO MATRICULA, " + c_ent
        cQuery += "    TRIM(BD6_NOMUSR) NOMUSR, " + c_ent
        cQuery += "    BD6_YNEVEN COD_EVENTO, " + c_ent
        cQuery += "    TRIM(ZZT_EVENTO) NOME_EVENTO,  " + c_ent
        cQuery += "    DECODE(TRIM(BD6_PREFIX),'','N„o cobrado','Cobrado') COBRADO , " + c_ent
        cQuery += "    DECODE(TRIM(BD6_SEQPF),'','N„o consolidado','Consolidado') CONSOLIDADO , " + c_ent
        cQuery += "    BD6_PERCOP PERC,BD6_SEQUEN SEQ, " + c_ent
        cQuery += "    SUM(BD6F.BD6_VLRGLO) GLOSADO, " + c_ent
        cQuery += "    SUM(BD7F.VLRPAG)  VL_APROV , " + c_ent
        cQuery += "    SUM(DECODE(BD6F.BD6_BLOCPA,'1',0,DECODE(SIGN(BD6F.BD6_VLRTPF),-1,0,DECODE(BD6_CODEMP,'0004',0,'0009',0,BD6F.BD6_VLRTPF)))) VL_PARTICIPACAO , " + c_ent
        cQuery += "    BD6_CODLDP||BD6_CODPEG||BD6_NUMERO GUIA, " + c_ent
        cQuery += "    BD6F.BD6_PREFIX||BD6F.BD6_NUMTIT||BD6F.BD6_PARCEL||BD6F.BD6_TIPTIT NUMTIT, " + c_ent
        cQuery += "    SIGA_TIPO_EXPOSICAO_ANS(BD6_CODEMP,BD6_MATRIC,BD6_TIPREG,To_Date(Trim(BD6_DATPRO),'YYYYMMDD')) EXPO,    " + c_ent
        cQuery += "    RETORNA_DESC_TIPPAG_MS ( 'C',BD6_OPEUSR || BD6_CODEMP|| BD6_MATRIC || BD6_TIPREG ||BD6_DIGITO) TIPOCOB " + c_ent
        cQuery += "FROM    (SELECT BD7.BD7_FILIAL,BD7_CODPLA,BD7.BD7_OPELOT,BD7.BD7_NUMLOT, BD7.BD7_CODOPE, BD7.BD7_CODLDP,  " + c_ent
        cQuery += "              BD7.BD7_CODPEG, BD7.BD7_NUMERO, BD7.BD7_ORIMOV,  BD7_CODPRO,BD7.BD7_SEQUEN,   " + c_ent
        cQuery += "              Sum(BD7.BD7_VLRPAG) AS VLRPAG " + c_ent
        cQuery += "		FROM BD7010 BD7  " + c_ent
        cQuery += "        WHERE BD7.BD7_FILIAL = '  '   AND  " + c_ent
        cQuery += "               BD7.BD7_CODOPE = '0001' AND  " + c_ent
        cQuery += "               BD7.BD7_SITUAC = '1' AND " + c_ent
        cQuery += "               BD7.BD7_FASE = '4' AND  " + c_ent
        cQuery += "               BD7.BD7_BLOPAG <> '1'  AND  " + c_ent
        cQuery += "               SUBSTR(BD7_NUMLOT,01,04) = '" + cAno + "' AND" + c_ent
		cQuery += "               SUBSTR(BD7_NUMLOT,05,02) =  '" + cMes + "' AND" + c_ent
        //cQuery += "               BD7_NUMLOT like '" + cAno + "'||'" + cMes + "'||'%' AND " + c_ent
        cQuery += "               BD7_CODEMP BETWEEN '" + cEmpini + "' AND  '" + cEmpate + "' AND   " + c_ent
        cQuery += "               BD7_CODEMP not in ( '0004','0009')  AND " + c_ent
        cQuery += "               BD7.D_E_L_E_T_ = ' '   " + c_ent
        cQuery += "      GROUP BY BD7_FILIAL, BD7_CODPLA, BD7.BD7_OPELOT,BD7.BD7_NUMLOT,  BD7_CODPRO,  " + c_ent
        cQuery += "               BD7_CODOPE, BD7_CODLDP, BD7_CODPEG, BD7_NUMERO, BD7_ORIMOV, BD7_SEQUEN " + c_ent
        cQuery += "		) BD7F, BD6010 BD6f ,BI3010 BI3 , ZZT010 ZZT   " + c_ent
        cQuery += "WHERE ZZT_FILIAL = '  ' AND " + c_ent
        cQuery += "      BI3_FILIAL = '  ' AND " + c_ent
        cQuery += "      BD6F.BD6_FILIAL = '  ' AND             " + c_ent
        cQuery += "      BD7F.BD7_FILIAL = BD6F.BD6_FILIAL AND  " + c_ent
        cQuery += "      BD7F.BD7_CODOPE = BD6F.BD6_CODOPE AND  " + c_ent
        cQuery += "      BD7F.BD7_CODLDP = BD6F.BD6_CODLDP AND  " + c_ent
        cQuery += "      BD7F.BD7_CODPEG = BD6F.BD6_CODPEG AND  " + c_ent
        cQuery += "      BD7F.BD7_NUMERO = BD6F.BD6_NUMERO AND  " + c_ent
        cQuery += "      BD7F.BD7_ORIMOV = BD6F.BD6_ORIMOV AND  " + c_ent
        cQuery += "      BD7F.BD7_SEQUEN = BD6F.BD6_SEQUEN AND  " + c_ent
        cQuery += "      BD6F.BD6_CODPRO = BD7F.BD7_CODPRO AND  " + c_ent
        cQuery += "      DECODE(BD6F.BD6_BLOCPA,'1',0,DECODE(SIGN(BD6F.BD6_VLRTPF),-1,0,BD6F.BD6_VLRTPF))>0 AND " + c_ent
        cQuery += "	  BI3_FILIAL=BD7_FILIAL  AND  " + c_ent
        cQuery += "      BI3_CODINT=BD7_CODOPE AND  " + c_ent
        cQuery += "      BI3_CODIGO=BD7_CODPLA AND  " + c_ent
        cQuery += "      BD6_YNEVEN=ZZT_CODEV AND  " + c_ent
        cQuery += "      BD6F.D_E_L_E_T_ = ' ' AND  " + c_ent
        cQuery += "      BI3.D_E_L_E_T_ = ' ' AND  " + c_ent
        cQuery += "      ZZT.D_E_L_E_T_ = ' '  " + c_ent
        cQuery += "GROUP BY BD6_CODEMP , " + c_ent
        cQuery += "      TO_DATE(TRIM(BD6_DATPRO),'YYYYMMDD') , " + c_ent
        cQuery += "      decode(BD6_CODLDP,'0010','Rec','0019','Rec','0017','Rat','Con'), " + c_ent
        cQuery += "      BD6_CODPRO , " + c_ent
        cQuery += "      BD6_DESPRO  , " + c_ent
        cQuery += "      BD6_YPROJ ,BD6_ANOPAG||'/'||BD6_MESPAG, " + c_ent
        cQuery += "      BD6_YNEVEN ,  ZZT_EVENTO , BD6_PERCOP,BD6_SEQUEN, " + c_ent
        cQuery += "      DECODE(TRIM(BD6_PREFIX),'','N„o cobrado','Cobrado')  , " + c_ent
        cQuery += "      BD6_CODLDP||BD6_CODPEG||BD6_NUMERO, " + c_ent
        cQuery += "      BD6_OPEUSR ||'.'|| BD6_CODEMP ||'.'|| BD6_MATRIC ||'.'|| BD6_TIPREG ||'-'||BD6_DIGITO , " + c_ent
        cQuery += "      TRIM(BD6_NOMUSR), " + c_ent
        cQuery += "      BD6F.BD6_PREFIX||BD6F.BD6_NUMTIT||BD6F.BD6_PARCEL||BD6F.BD6_TIPTIT, " + c_ent
        cQuery += "      DECODE(TRIM(BD6_SEQPF),'','N„o consolidado','Consolidado') , " + c_ent
        cQuery += "      SIGA_TIPO_EXPOSICAO_ANS(BD6_CODEMP,BD6_MATRIC,BD6_TIPREG,To_Date(Trim(BD6_DATPRO),'YYYYMMDD')) , " + c_ent
        cQuery += "      RETORNA_DESC_TIPPAG_MS ( 'C',BD6_OPEUSR || BD6_CODEMP|| BD6_MATRIC || BD6_TIPREG ||BD6_DIGITO),  " + c_ent
        cQuery += "      TRIM(RETORNA_DESCRI_GRUPO_COBERT('C',substr(RETORNA_GRUPO_COBERT ( 'C',BD6_CODPAD,BD6_CODPRO,  'G'),1,3))) " + c_ent
        cQuery += "UNION ALL " + c_ent
        cQuery += "SELECT 'OPM' TIPO, " + c_ent
        cQuery += "     BD6_ANOPAG||'/'||BD6_MESPAG REF, " + c_ent
        cQuery += "     CODEMP CODEMP, trim(DESC_EMP) EMPRESA, " + c_ent
        cQuery += "     TRIM(RETORNA_DESCRI_GRUPO_COBERT('C',substr(RETORNA_GRUPO_COBERT ( 'C',TABELA,COD_PROCED,  'G'),1,3))) GRUPO_COBERT, " + c_ent
        cQuery += "     DATA DATPRO, " + c_ent
        cQuery += "     COD_PROCED, " + c_ent
        cQuery += "     DESPRO, " + c_ent
        cQuery += "     PROJ, " + c_ent
        cQuery += "     OPEUSR ||'.'||CODEMP ||'.'|| MATRIC ||'.'||TIPREG ||'-'||DIGITO MATRICULA, " + c_ent
        cQuery += "     BD6_NOMUSR NOMUSR, " + c_ent
        cQuery += "     CODEVENTO Cod_Evento, " + c_ent
        cQuery += "     trim(NOME_EVENTO),  " + c_ent
        cQuery += "     DECODE(TRIM(BD6_PREFIX),'','N„o cobrado','Cobrado') COBRADO , " + c_ent
        cQuery += "     DECODE(TRIM(BD6_SEQPF),'','N„o consolidado','Consolidado') CONSOLIDADO , " + c_ent
        cQuery += "     0 BD6_PERC,BD6_SEQUEN, " + c_ent
        cQuery += "     SUM(GLOSADO) GLOSADO, " + c_ent
        cQuery += "     SUM(VL_APROV)  VL_APROV ,  " + c_ent
        cQuery += "     SUM(VL_PARTICIPACAO) VL_PARTICIPACAO , " + c_ent
        cQuery += "     BD6_CODLDP||BD6_CODPEG||BD6_NUMERO GUIA, " + c_ent
        cQuery += "     BD6_PREFIX||BD6_NUMTIT||BD6_PARCEL||BD6_TIPTIT NUMTIT, " + c_ent
        cQuery += "     EXPOSICAO_ANS, " + c_ent
        cQuery += "     RETORNA_DESC_TIPPAG_MS ( 'C',OPEUSR || CODEMP||MATRIC || TIPREG ||DIGITO) TIPOCOB " + c_ent
        cQuery += "FROM	(SELECT F1_YDTCON, " + c_ent
        cQuery += "				BD6_OPEUSR OPEUSR, " + c_ent
        cQuery += "				BD6_CODEMP CODEMP, " + c_ent
        cQuery += "				BD6_MATRIC MATRIC, " + c_ent
        cQuery += "				BD6_TIPREG TIPREG, " + c_ent
        cQuery += "				BD6_DIGITO DIGITO, " + c_ent
        cQuery += "				BD6_CODPLA PLANO, " + c_ent
        cQuery += "				BD6_YNEVEN CODEVENTO, " + c_ent
        cQuery += "				ZZT_EVENTO NOME_EVENTO, " + c_ent
        cQuery += "				COUNT(DISTINCT BD6_CODEMP||BD6_MATRIC||BD6_TIPREG) QTDE, " + c_ent
        cQuery += "				Sum(D1_QUANT) Ocorrencia, " + c_ent
        cQuery += "				Sum(BD6_VLRGLO) Glosado, " + c_ent
        cQuery += "				Sum(D1_TOTAL)-Sum(D1_VALDESC) Vl_Aprov, " + c_ent
        cQuery += "				0 Vl_Participacao, " + c_ent
        cQuery += "				SIGA_TIPO_EXPOSICAO_ANS(BD6_CODEMP,BD6_MATRIC,BD6_TIPREG,To_Date(Trim(BD6_DATPRO),'YYYYMMDD')) EXPOSICAO_ANS , " + c_ent
        cQuery += "				RETORNA_DESCRI_GRUPO_PLANO ( TRIM(BI3_YGRPLA),BD6_CODEMP,'C') GRUPO_PLANO, " + c_ent
        cQuery += "				Decode(BD6_CODEMP,'0007',Trim(BI3_NREDUZ)||' (SEPE)',BI3_NREDUZ) NOME_PLANO, " + c_ent
        cQuery += "				ZZT_TPCUST , " + c_ent
        cQuery += "				BD6_CODRDA RDA , " + c_ent
        cQuery += "				BD6_CODPRO COD_PROCED, " + c_ent
        cQuery += "				Trim(BD6_DESPRO) DESPRO  , " + c_ent
        cQuery += "				BG9_CODIGO GRUPO_EMP,BG9_DESCRI DESC_EMP ,B19_DOC  , " + c_ent
        cQuery += "				BD6_OPEUSR,BD6_MATRIC,BD6_TIPREG  , " + c_ent
        cQuery += "				To_Date(BD6_DATPRO,'YYYYMMDD') DATA, " + c_ent
        cQuery += "				BD6_CODLDP, BD6_CODPEG, BD6_NUMERO,BD6_SEQUEN, " + c_ent
        cQuery += "				BD6_CODRDA, " + c_ent
        cQuery += "				BD6_NOMUSR , " + c_ent
        cQuery += "				BD6_CODPAD TABELA, " + c_ent
        cQuery += "				DESC_FAIXA_ETARIA (IDADE_MATRIC ( BD6_CODEMP,BD6_MATRIC,BD6_TIPREG,'C',BD6_DATPRO),4) FAIXA, " + c_ent
        cQuery += "				BD6_YPROJ PROJ, " + c_ent
        cQuery += "				BD6_CODESP CODESP,BD6_CONEMP, " + c_ent
        cQuery += "				BD6_YPROJU PROC_JURID, " + c_ent
        cQuery += "				BD6_PREFIX,BD6_NUMTIT,BD6_PARCEL,BD6_TIPTIT, " + c_ent
        cQuery += "				'S' Rol, " + c_ent
        cQuery += "				BD6_SEQPF, " + c_ent
        cQuery += "				BD6_ANOPAG,BD6_MESPAG " + c_ent
        cQuery += "		FROM SIGA.B19010 B19, SIGA.SD1010 SD1, SIGA.SF1010 SF1, SIGA.BD6010 BD6 , " + c_ent
        cQuery += "			 SIGA.SA2010 SA2, ZZT010 ZZT  ,BI3010 BI3 ,BG9010  BG9, SE1010  " + c_ent
        cQuery += "	    WHERE BI3_FILIAL=' ' " + c_ent
        cQuery += "			  AND A2_FILIAL=' ' " + c_ent
        cQuery += "			  AND A2_COD = B19_FORNEC " + c_ent
        cQuery += "			  AND SUBSTR(F1_YDTCON,01,04) = '" + cAno + "' " + c_ent
	    cQuery += "			  AND SUBSTR(F1_YDTCON,05,02) =  '" + cMes + "'  " + c_ent
        //cQuery += "			  AND F1_YDTCON  like '" + cAno + "'||'" + cMes + "'||'%'   " + c_ent
        cQuery += "			  and BD6_CODEMP BETWEEN '" + cEmpini + "' AND  '" + cEmpate + "'    " + c_ent
        cQuery += "			  AND D1_FORNECE= A2_COD " + c_ent
        cQuery += "			  AND f1_FORNECE= A2_COD " + c_ent
        cQuery += "			  AND D1_DOC = F1_DOC " + c_ent
        cQuery += "			  AND B19_DOC = D1_DOC " + c_ent
        cQuery += "			  AND D1_ITEM = B19_ITEM " + c_ent
        cQuery += "			  AND BD6_FILIAL = ' ' " + c_ent
        cQuery += "			  AND ZZT_FILIAL=' ' " + c_ent
        cQuery += "			  AND BG9_FILIAL=' ' " + c_ent
        cQuery += "			  AND BD6_CODPLA=BI3_CODIGO " + c_ent
        cQuery += "			  AND BD6_CODOPE = SubStr(B19_GUIA,01,04) " + c_ent
        cQuery += "			  AND BD6_CODLDP = SubStr(B19_GUIA,05,04) " + c_ent
        cQuery += "			  AND BD6_CODPEG = SubStr(B19_GUIA,09,08) " + c_ent
        cQuery += "			  AND BD6_NUMERO = SubStr(B19_GUIA,17,08) " + c_ent
        cQuery += "			  AND BD6_ORIMOV = SubStr(B19_GUIA,25,01) " + c_ent
        cQuery += "			  AND BD6_SEQUEN = SubStr(B19_GUIA,26,03) " + c_ent
        cQuery += "			  AND BD6_FASE IN ('3','4') " + c_ent
        cQuery += "			  AND BD6_CODLDP='0013' " + c_ent
        cQuery += "			  AND BD6_SITUAC = '1' " + c_ent
        cQuery += "			  AND BD6_YNEVEN=ZZT_CODEV " + c_ent
        cQuery += "			  AND BD6_OPEUSR=BG9_CODINT " + c_ent
        cQuery += "			  AND BD6_CODEMP=BG9_CODIGO " + c_ent
        cQuery += "			  AND SA2.D_E_L_E_T_ = ' ' " + c_ent
        cQuery += "			  AND B19.D_E_L_E_T_ = ' ' " + c_ent
        cQuery += "			  AND SD1.D_E_L_E_T_ = ' ' " + c_ent
        cQuery += "			  AND SF1.D_E_L_E_T_ = ' ' " + c_ent
        cQuery += "			  AND BD6.D_E_L_E_T_ = ' ' " + c_ent
        cQuery += "			  AND ZZT.D_E_L_E_T_ = ' ' " + c_ent
        cQuery += "			  AND BI3.D_E_L_E_T_ = ' ' " + c_ent
        cQuery += "			  AND BG9.D_E_L_E_T_ = ' ' " + c_ent
        cQuery += "		GROUP BY F1_YDTCON, " + c_ent
        cQuery += "				 BD6_OPEUSR, " + c_ent
        cQuery += "				 BD6_CODEMP, " + c_ent
        cQuery += "				 BD6_MATRIC, " + c_ent
        cQuery += "				 BD6_TIPREG, " + c_ent
        cQuery += "				 BD6_DIGITO, " + c_ent
        cQuery += "				 SIGA_TIPO_EXPOSICAO_ANS(BD6_CODEMP,BD6_MATRIC,BD6_TIPREG,To_Date(Trim(BD6_DATPRO),'YYYYMMDD')), " + c_ent
        cQuery += "				 BD6_CODEMP, " + c_ent
        cQuery += "				 BD6_CODPLA, " + c_ent
        cQuery += "				 RETORNA_DESCRI_GRUPO_PLANO ( TRIM(BI3_YGRPLA),BD6_CODEMP,'C'), " + c_ent
        cQuery += "				 Decode(BD6_CODEMP,'0007',Trim(BI3_NREDUZ)||' (SEPE)',BI3_NREDUZ), " + c_ent
        cQuery += "				 BD6_YNEVEN, " + c_ent
        cQuery += "				 Trim(BD6_DESPRO), " + c_ent
        cQuery += "				 BG9_CODIGO ,BG9_DESCRI  ,B19_DOC , " + c_ent
        cQuery += "				 BD6_OPEUSR,BD6_MATRIC,BD6_TIPREG,BD6_NOMUSR, " + c_ent
        cQuery += "				 To_Date(BD6_DATPRO,'YYYYMMDD') , " + c_ent
        cQuery += "				 BD6_CODLDP, BD6_CODPEG, BD6_NUMERO,BD6_SEQUEN, " + c_ent
        cQuery += "				 BD6_CODRDA, " + c_ent
        cQuery += "				 BD6_YPROJ , " + c_ent
        cQuery += "				 BD6_CODPAD , " + c_ent
        cQuery += "				 DESC_FAIXA_ETARIA (IDADE_MATRIC ( BD6_CODEMP,BD6_MATRIC,BD6_TIPREG,'C',BD6_DATPRO),4), " + c_ent
        cQuery += "				 ZZT_EVENTO,ZZT_TPCUST,BD6_CODRDA,BD6_CODPRO , BD6_CODPAD ,BD6_DATPRO,              " + c_ent
        cQuery += "				 BD6_PREFIX,BD6_NUMTIT,BD6_PARCEL,BD6_TIPTIT, " + c_ent
        cQuery += "				 BD6_CODESP ,BD6_CONEMP, " + c_ent
        cQuery += "				 BD6_YPROJU , " + c_ent
        cQuery += "				 BD6_SEQPF, " + c_ent
        cQuery += "				 BD6_ANOPAG,BD6_MESPAG " + c_ent
        cQuery += "		UNION " + c_ent
        cQuery += "		SELECT  DISTINCT " + c_ent
        cQuery += "				F1_YDTCON, " + c_ent
        cQuery += "				BD6_OPEUSR OPEUSR, " + c_ent
        cQuery += "				BD6_CODEMP CODEMP, " + c_ent
        cQuery += "				BD6_MATRIC MATRIC, " + c_ent
        cQuery += "				BD6_TIPREG TIPREG, " + c_ent
        cQuery += "				BD6_DIGITO DIGITO, " + c_ent
        cQuery += "				BD6_CODPLA PLANO, " + c_ent
        cQuery += "				BD6_YNEVEN CODEVENTO, " + c_ent
        cQuery += "				ZZT_EVENTO NOME_EVENTO, " + c_ent
        cQuery += "				1 QTDE, " + c_ent
        cQuery += "				1 Ocorrencia, " + c_ent
        cQuery += "				0 Glosado, " + c_ent
        cQuery += "				0 Vl_Aprov, " + c_ent
        cQuery += "				Nvl( BD7_VLRTPF,0) Vl_Participacao, " + c_ent
        cQuery += "				SIGA_TIPO_EXPOSICAO_ANS(BD6_CODEMP,BD6_MATRIC,BD6_TIPREG,To_Date(Trim(BD6_DATPRO),'YYYYMMDD')) EXPOSICAO_ANS , " + c_ent
        cQuery += "				RETORNA_DESCRI_GRUPO_PLANO ( TRIM(BI3_YGRPLA),BD6_CODEMP,'C') GRUPO_PLANO, " + c_ent
        cQuery += "				Decode(BD6_CODEMP,'0007',Trim(BI3_NREDUZ)||' (SEPE)',BI3_NREDUZ) NOME_PLANO, " + c_ent
        cQuery += "				ZZT_TPCUST , " + c_ent
        cQuery += "				BD6_CODRDA RDA , " + c_ent
        cQuery += "				BD6_CODPRO COD_PROCED, " + c_ent
        cQuery += "				Trim(BD6_DESPRO) DESPRO, " + c_ent
        cQuery += "				BG9_CODIGO GRUPO_EMP,BG9_DESCRI DESC_EMP ,B19_DOC , " + c_ent
        cQuery += "				BD6_OPEUSR,BD6_MATRIC,BD6_TIPREG , " + c_ent
        cQuery += "				To_Date(BD6_DATPRO,'YYYYMMDD') DATA, " + c_ent
        cQuery += "				BD6_CODLDP, BD6_CODPEG, BD6_NUMERO,BD6_SEQUEN, " + c_ent
        cQuery += "				BD6_CODRDA, " + c_ent
        cQuery += "				BD6_NOMUSR, " + c_ent
        cQuery += "				BD6_CODPAD TABELA, " + c_ent
        cQuery += "				DESC_FAIXA_ETARIA (IDADE_MATRIC ( BD6_CODEMP,BD6_MATRIC,BD6_TIPREG,'C',BD6_DATPRO),4) FAIXA, " + c_ent
        cQuery += "				BD6_YPROJ PROJ, " + c_ent
        cQuery += "				BD6_CODESP CODESP, " + c_ent
        cQuery += "				BD6_CONEMP, " + c_ent
        cQuery += "				BD6_YPROJU PROC_JURID, " + c_ent
        cQuery += "				BD6_PREFIX,BD6_NUMTIT,BD6_PARCEL,BD6_TIPTIT, " + c_ent
        cQuery += "				'S' Rol, " + c_ent
        cQuery += "				BD6_SEQPF, " + c_ent
        cQuery += "				BD6_ANOPAG,BD6_MESPAG " + c_ent
        cQuery += "		FROM SIGA.B19010 B19, SIGA.SD1010 SD1, SIGA.SF1010 SF1, SIGA.BD6010 BD6 , " + c_ent
        cQuery += "			 SIGA.SA2010 SA2, ZZT010 ZZT  ,BI3010 BI3 ,BD7010 BD7  ,BG9010  BG9 " + c_ent
        cQuery += "	    WHERE BI3_FILIAL=' ' " + c_ent
        cQuery += "			  AND A2_FILIAL=' ' " + c_ent
        cQuery += "			  AND B19_FILIAL=' ' " + c_ent
        cQuery += "			  AND BG9_FILIAL=' ' " + c_ent
        cQuery += "			  AND SUBSTR(F1_YDTCON,01,04) = '" + cAno + "' " + c_ent
	    cQuery += "			  AND SUBSTR(F1_YDTCON,05,02) =  '" + cMes + "'  " + c_ent
        //cQuery += "			  AND F1_YDTCON like '" + cAno + "'||'" + cMes + "'||'%' " + c_ent
        cQuery += "			  AND D1_FILIAL='01' " + c_ent
        cQuery += "			  AND F1_FILIAL='01' " + c_ent
        cQuery += "			  AND BD7_FILIAL=' ' " + c_ent
        cQuery += "			  AND A2_COD = B19_FORNEC " + c_ent
        cQuery += "			  AND D1_FORNECE= A2_COD " + c_ent
        cQuery += "			  AND f1_FORNECE= A2_COD " + c_ent
        cQuery += "			  AND D1_DOC = F1_DOC " + c_ent
        cQuery += "			  AND B19_DOC = D1_DOC " + c_ent
        cQuery += "			  AND D1_ITEM = B19_ITEM " + c_ent
        cQuery += "			  AND BD6_FILIAL = ' ' " + c_ent
        cQuery += "			  AND ZZT_FILIAL=' ' " + c_ent
        cQuery += "			  AND BD6_CODPLA=BI3_CODIGO " + c_ent
        cQuery += "			  AND BD6_CODOPE = SubStr(B19_GUIA,01,04) " + c_ent
        cQuery += "			  AND BD6_CODLDP = SubStr(B19_GUIA,05,04) " + c_ent
        cQuery += "			  AND BD6_CODPEG = SubStr(B19_GUIA,09,08) " + c_ent
        cQuery += "			  AND BD6_NUMERO = SubStr(B19_GUIA,17,08) " + c_ent
        cQuery += "			  AND BD6_ORIMOV = SubStr(B19_GUIA,25,01) " + c_ent
        cQuery += "			  AND BD6_SEQUEN = SubStr(B19_GUIA,26,03) " + c_ent
        cQuery += "			  AND BD7_CODPRO IN ('01990012','02990016','03990010') " + c_ent
        cQuery += "			  AND BD7_CODOPE = BD6_CODOPE " + c_ent
        cQuery += "			  AND BD7_CODLDP = BD6_CODLDP " + c_ent
        cQuery += "			  AND BD7_CODPEG = BD6_CODPEG " + c_ent
        cQuery += "			  AND BD7_NUMERO = BD6_NUMERO " + c_ent
        cQuery += "			  AND BD6_FASE IN ('3','4') " + c_ent
        cQuery += "			  AND BD6_CODLDP='0013' " + c_ent
        cQuery += "			  AND BD6_SITUAC = '1' " + c_ent
        cQuery += "			  AND BD6_YNEVEN=ZZT_CODEV " + c_ent
        cQuery += "			  AND BD6_OPEUSR=BG9_CODINT " + c_ent
        cQuery += "			  AND BD6_CODEMP=BG9_CODIGO " + c_ent
        cQuery += "			  AND SA2.D_E_L_E_T_ = ' ' " + c_ent
        cQuery += "			  AND B19.D_E_L_E_T_ = ' ' " + c_ent
        cQuery += "			  AND BG9.D_E_L_E_T_ = ' ' " + c_ent
        cQuery += "			  AND SD1.D_E_L_E_T_ = ' ' " + c_ent
        cQuery += "			  AND SF1.D_E_L_E_T_ = ' ' " + c_ent
        cQuery += "			  AND BD6.D_E_L_E_T_ = ' ' " + c_ent
        cQuery += "			  AND ZZT.D_E_L_E_T_ = ' ' " + c_ent
        cQuery += "			  AND BI3.D_E_L_E_T_ = ' ' " + c_ent
        cQuery += "			  AND BD7.D_E_L_E_T_ = ' ' " + c_ent
        cQuery += "		)		 " + c_ent
        cQuery += "WHERE VL_PARTICIPACAO<>0 " + c_ent
        cQuery += "GROUP BY CODEMP , DESC_EMP , " + c_ent
        cQuery += "		 DATA,COD_PROCED,BD6_SEQUEN, " + c_ent
        cQuery += "		 DESPRO, " + c_ent
        cQuery += "		 PROJ, " + c_ent
        cQuery += "		 OPEUSR ||'.'||CODEMP ||'.'|| MATRIC ||'.'||TIPREG ||'-'||DIGITO , " + c_ent
        cQuery += "		 BD6_NOMUSR , " + c_ent
        cQuery += "		 CODEVENTO , " + c_ent
        cQuery += "		 NOME_EVENTO,  " + c_ent
        cQuery += "		 DECODE(TRIM(BD6_PREFIX),'','N„o cobrado','Cobrado')  ,            " + c_ent
        cQuery += "		 BD6_CODLDP||BD6_CODPEG||BD6_NUMERO , " + c_ent
        cQuery += "		 BD6_PREFIX||BD6_NUMTIT||BD6_PARCEL||BD6_TIPTIT,EXPOSICAO_ANS, " + c_ent
        cQuery += "		 BD6_SEQPF, " + c_ent
        cQuery += "		 TRIM(RETORNA_DESCRI_GRUPO_COBERT('C',substr(RETORNA_GRUPO_COBERT ( 'C',TABELA,COD_PROCED,  'G'),1,3))), " + c_ent
        cQuery += "		 BD6_ANOPAG||'/'||BD6_MESPAG, " + c_ent
        cQuery += "		 RETORNA_DESC_TIPPAG_MS ( 'C',OPEUSR || CODEMP||MATRIC || TIPREG ||DIGITO) "
    Else
        cQuery := "SELECT DECODE(BD6_CODLDP,'0010','Rec','0019','Rec','0017','Rat','Con') TIPO,  " + c_ent
        cQuery += "       BD6_ANOPAG||'/'||BD6_MESPAG REF, " + c_ent
        cQuery += "       BD6_CODEMP CODEMP, RETORNA_DESCRI_GRUPOEMP ( 'I', BD6_CODEMP) EMPRESA, " + c_ent
        cQuery += "       TRIM(RETORNA_DESCRI_GRUPO_COBERT('I',substr(RETORNA_GRUPO_COBERT ( 'I',BD6_CODPAD,BD6_CODPRO,  'G'),1,3))) GRUPO_COBERT , " + c_ent
        cQuery += "       TO_DATE(TRIM(BD6_DATPRO),'YYYYMMDD') DATPRO, " + c_ent
        cQuery += "       BD6_CODPRO COD_PROCED, " + c_ent
        cQuery += "       BD6_DESPRO DESPRO , " + c_ent
        cQuery += "       BD6_YPROJ PROJ, " + c_ent
        cQuery += "       BD6_OPEUSR ||'.'|| BD6_CODEMP ||'.'|| BD6_MATRIC ||'.'|| BD6_TIPREG ||'-'||BD6_DIGITO MATRICULA, " + c_ent
        cQuery += "       TRIM(BD6_NOMUSR) NOMUSR, " + c_ent
        cQuery += "       BD6_YNEVEN Cod_Evento, " + c_ent
        cQuery += "       TRIM(ZZT_EVENTO) NOME_EVENTO,  " + c_ent
        cQuery += "       DECODE(TRIM(BD6_PREFIX),'','N„o cobrado','Cobrado') COBRADO , " + c_ent
        cQuery += "       DECODE(TRIM(BD6_SEQPF),'','N„o consolidado','Consolidado') CONSOLIDADO , " + c_ent
        cQuery += "       BD6_PERCOP PERC,BD6_SEQUEN SEQ, " + c_ent
        cQuery += "       SUM(BD6F.BD6_VLRGLO) GLOSADO, " + c_ent
        cQuery += "       SUM(BD7F.VLRPAG)  VL_APROV ,  " + c_ent
        cQuery += "       SUM(DECODE(BD6F.BD6_BLOCPA,'1',0,DECODE(SIGN(BD6F.BD6_VLRTPF),-1,0,DECODE(BD6_CODEMP,'0004',0,'0009',0,BD6F.BD6_VLRTPF)))) VL_PARTICIPACAO , " + c_ent
        cQuery += "       BD6_CODLDP||BD6_CODPEG||BD6_NUMERO GUIA, " + c_ent
        cQuery += "       BD6F.BD6_PREFIX||BD6F.BD6_NUMTIT||BD6F.BD6_PARCEL||BD6F.BD6_TIPTIT NUMTIT, " + c_ent
        cQuery += "       SIGA_TIPO_EXPOSICAO_ANS_INT(BD6_CODEMP,BD6_MATRIC,BD6_TIPREG,To_Date(Trim(BD6_DATPRO),'YYYYMMDD')) EXPO,    " + c_ent
        cQuery += "       RETORNA_DESC_TIPPAG_MS ( 'I',BD6_OPEUSR || BD6_CODEMP|| BD6_MATRIC || BD6_TIPREG ||BD6_DIGITO) TIPOCOB " + c_ent
        cQuery += "FROM (SELECT BD7.BD7_FILIAL,BD7_CODPLA,BD7.BD7_OPELOT,BD7.BD7_NUMLOT, BD7.BD7_CODOPE, BD7.BD7_CODLDP,  " + c_ent
        cQuery += "                BD7.BD7_CODPEG, BD7.BD7_NUMERO, BD7.BD7_ORIMOV,  BD7_CODPRO,BD7.BD7_SEQUEN,   " + c_ent
        cQuery += "               Sum(BD7.BD7_VLRPAG) AS VLRPAG " + c_ent
        cQuery += "          FROM BD7020 BD7  " + c_ent
        cQuery += "         WHERE BD7.BD7_FILIAL = '  '   AND  " + c_ent
        cQuery += "               BD7.BD7_CODOPE = '0001' AND  " + c_ent
        cQuery += "               BD7.BD7_SITUAC = '1' AND " + c_ent
        cQuery += "               BD7.BD7_FASE = '4' AND  " + c_ent
        cQuery += "               BD7.BD7_BLOPAG <> '1'  AND  " + c_ent
        cQuery += "			      SUBSTR(BD7_NUMLOT,01,04) = '" + cAno + "' AND" + c_ent
	    cQuery += "			      SUBSTR(BD7_NUMLOT,05,02) =  '" + cMes + "' AND" + c_ent
        //cQuery += "               BD7_NUMLOT like '" + cAno + "'||'" + cMes + "'||'%' AND " + c_ent
        cQuery += "               BD7_CODEMP BETWEEN '" + cEmpini + "' AND  '" + cEmpate + "' AND   " + c_ent
        cQuery += "               BD7.D_E_L_E_T_ = ' '   " + c_ent
        cQuery += "      GROUP BY BD7_FILIAL, BD7_CODPLA, BD7.BD7_OPELOT,BD7.BD7_NUMLOT,  BD7_CODPRO,  " + c_ent
        cQuery += "               BD7_CODOPE, BD7_CODLDP, BD7_CODPEG, BD7_NUMERO, BD7_ORIMOV, BD7_SEQUEN) BD7F,   " + c_ent
        cQuery += "               BD6020 BD6f ,BI3020 BI3 , ZZT010 ZZT   " + c_ent
        cQuery += "WHERE ZZT_FILIAL = '  ' AND " + c_ent
        cQuery += "       BI3_FILIAL = '  ' AND " + c_ent
        cQuery += "       BD6F.BD6_FILIAL = '  ' AND             " + c_ent
        cQuery += "       BD7F.BD7_FILIAL = BD6F.BD6_FILIAL AND  " + c_ent
        cQuery += "       BD7F.BD7_CODOPE = BD6F.BD6_CODOPE AND  " + c_ent
        cQuery += "       BD7F.BD7_CODLDP = BD6F.BD6_CODLDP AND  " + c_ent
        cQuery += "       BD7F.BD7_CODPEG = BD6F.BD6_CODPEG AND  " + c_ent
        cQuery += "       BD7F.BD7_NUMERO = BD6F.BD6_NUMERO AND  " + c_ent
        cQuery += "       BD7F.BD7_ORIMOV = BD6F.BD6_ORIMOV AND  " + c_ent
        cQuery += "       BD7F.BD7_SEQUEN = BD6F.BD6_SEQUEN AND  " + c_ent
        cQuery += "       BD6F.BD6_CODPRO = BD7F.BD7_CODPRO AND  " + c_ent
        cQuery += "       DECODE(BD6F.BD6_BLOCPA,'1',0,DECODE(SIGN(BD6F.BD6_VLRTPF),-1,0,BD6F.BD6_VLRTPF))>0 AND " + c_ent
        cQuery += "       BI3_FILIAL=BD7_FILIAL  AND  " + c_ent
        cQuery += "       BI3_CODINT=BD7_CODOPE AND  " + c_ent
        cQuery += "       BI3_CODIGO=BD7_CODPLA AND  " + c_ent
        cQuery += "       BD6_YNEVEN=ZZT_CODEV AND  " + c_ent
        cQuery += "       BD6F.D_E_L_E_T_ = ' ' AND  " + c_ent
        cQuery += "       BI3.D_E_L_E_T_ = ' ' AND  " + c_ent
        cQuery += "       ZZT.D_E_L_E_T_ = ' '  " + c_ent
        cQuery += "GROUP BY BD6_CODEMP , " + c_ent
        cQuery += "decode(BD6_CODLDP,'0010','Rec','0019','Rec','0017','Rat','Con'), " + c_ent
        cQuery += "       TO_DATE(TRIM(BD6_DATPRO),'YYYYMMDD') , " + c_ent
        cQuery += "       BD6_CODPRO , " + c_ent
        cQuery += "       BD6_DESPRO  , " + c_ent
        cQuery += "       BD6_YPROJ ,BD6_ANOPAG||'/'||BD6_MESPAG, " + c_ent
        cQuery += "       BD6_YNEVEN ,  ZZT_EVENTO , BD6_PERCOP,BD6_SEQUEN, " + c_ent
        cQuery += "       DECODE(TRIM(BD6_PREFIX),'','N„o cobrado','Cobrado')  , " + c_ent
        cQuery += "       BD6_CODLDP||BD6_CODPEG||BD6_NUMERO, " + c_ent
        cQuery += "       BD6_OPEUSR ||'.'|| BD6_CODEMP ||'.'|| BD6_MATRIC ||'.'|| BD6_TIPREG ||'-'||BD6_DIGITO , " + c_ent
        cQuery += "       TRIM(BD6_NOMUSR), " + c_ent
        cQuery += "       BD6F.BD6_PREFIX||BD6F.BD6_NUMTIT||BD6F.BD6_PARCEL||BD6F.BD6_TIPTIT, " + c_ent
        cQuery += "       DECODE(TRIM(BD6_SEQPF),'','N„o consolidado','Consolidado') , " + c_ent
        cQuery += "       SIGA_TIPO_EXPOSICAO_ANS_INT(BD6_CODEMP,BD6_MATRIC,BD6_TIPREG,To_Date(Trim(BD6_DATPRO),'YYYYMMDD')) , " + c_ent
        cQuery += "       RETORNA_DESC_TIPPAG_MS ( 'I',BD6_OPEUSR || BD6_CODEMP|| BD6_MATRIC || BD6_TIPREG ||BD6_DIGITO),  " + c_ent
        cQuery += "       TRIM(RETORNA_DESCRI_GRUPO_COBERT('I',substr(RETORNA_GRUPO_COBERT ( 'I',BD6_CODPAD,BD6_CODPRO,  'G'),1,3))) " + c_ent
        cQuery += "UNION ALL " + c_ent
        cQuery += "SELECT 'OPM' TIPO, " + c_ent
        cQuery += "       BD6_ANOPAG||'/'||BD6_MESPAG REF, " + c_ent
        cQuery += "       CODEMP CODEMP, trim(DESC_EMP) EMPRESA, " + c_ent
        cQuery += "       TRIM(RETORNA_DESCRI_GRUPO_COBERT('I',substr(RETORNA_GRUPO_COBERT ( 'I',TABELA,COD_PROCED,  'G'),1,3))) GRUPO_COBERT, " + c_ent
        cQuery += "       DATA DATPRO, " + c_ent
        cQuery += "       COD_PROCED, " + c_ent
        cQuery += "       DESPRO, " + c_ent
        cQuery += "       PROJ, " + c_ent
        cQuery += "       OPEUSR ||'.'||CODEMP ||'.'|| MATRIC ||'.'||TIPREG ||'-'||DIGITO MATRICULA, " + c_ent
        cQuery += "       BD6_NOMUSR NOMUSR, " + c_ent
        cQuery += "       CODEVENTO Cod_Evento, " + c_ent
        cQuery += "       trim(NOME_EVENTO),  " + c_ent
        cQuery += "       DECODE(TRIM(BD6_PREFIX),'','N„o cobrado','Cobrado') COBRADO , " + c_ent
        cQuery += "       DECODE(TRIM(BD6_SEQPF),'','N„o consolidado','Consolidado') CONSOLIDADO , " + c_ent
        cQuery += "       0 BD6_PERC,BD6_SEQUEN, " + c_ent
        cQuery += "       SUM(GLOSADO) GLOSADO, " + c_ent
        cQuery += "       SUM(VL_APROV)  VL_APROV ,  " + c_ent
        cQuery += "       SUM(VL_PARTICIPACAO) VL_PARTICIPACAO , " + c_ent
        cQuery += "       BD6_CODLDP||BD6_CODPEG||BD6_NUMERO GUIA, " + c_ent
        cQuery += "       BD6_PREFIX||BD6_NUMTIT||BD6_PARCEL||BD6_TIPTIT NUMTIT, " + c_ent
        cQuery += "       EXPOSICAO_ANS, " + c_ent
        cQuery += "       RETORNA_DESC_TIPPAG_MS ( 'I',OPEUSR || CODEMP||MATRIC || TIPREG ||DIGITO) TIPOCOB " + c_ent
        cQuery += "FROM( " + c_ent
        cQuery += "	SELECT F1_YDTCON, " + c_ent
        cQuery += "         BD6_OPEUSR OPEUSR, " + c_ent
        cQuery += "         BD6_CODEMP CODEMP, " + c_ent
        cQuery += "         BD6_MATRIC MATRIC, " + c_ent
        cQuery += "         BD6_TIPREG TIPREG, " + c_ent
        cQuery += "         BD6_DIGITO DIGITO, " + c_ent
        cQuery += "         BD6_CODPLA PLANO, " + c_ent
        cQuery += "         BD6_YNEVEN CODEVENTO, " + c_ent
        cQuery += "         ZZT_EVENTO NOME_EVENTO, " + c_ent
        cQuery += "         COUNT(DISTINCT BD6_CODEMP||BD6_MATRIC||BD6_TIPREG) QTDE, " + c_ent
        cQuery += "         Sum(D1_QUANT) Ocorrencia, " + c_ent
        cQuery += "         Sum(BD6_VLRGLO) Glosado, " + c_ent
        cQuery += "         Sum(D1_TOTAL)-Sum(D1_VALDESC) Vl_Aprov, " + c_ent
        cQuery += "         0 Vl_Participacao, " + c_ent
        cQuery += "         SIGA_TIPO_EXPOSICAO_ANS_INT(BD6_CODEMP,BD6_MATRIC,BD6_TIPREG,To_Date(Trim(BD6_DATPRO),'YYYYMMDD')) EXPOSICAO_ANS , " + c_ent
        cQuery += "         RETORNA_DESCRI_GRUPO_PLANO ( TRIM(BI3_YGRPLA),BD6_CODEMP,'I') GRUPO_PLANO, " + c_ent
        cQuery += "         Decode(BD6_CODEMP,'0007',Trim(BI3_NREDUZ)||' (SEPE)',BI3_NREDUZ) NOME_PLANO, " + c_ent
        cQuery += "         ZZT_TPCUST , " + c_ent
        cQuery += "         BD6_CODRDA RDA , " + c_ent
        cQuery += "         BD6_CODPRO COD_PROCED, " + c_ent
        cQuery += "         Trim(BD6_DESPRO) DESPRO  , " + c_ent
        cQuery += "         BG9_CODIGO GRUPO_EMP,BG9_DESCRI DESC_EMP ,B19_DOC  , " + c_ent
        cQuery += "         BD6_OPEUSR,BD6_MATRIC,BD6_TIPREG  , " + c_ent
        cQuery += "         To_Date(BD6_DATPRO,'YYYYMMDD') DATA, " + c_ent
        cQuery += "         BD6_CODLDP, BD6_CODPEG, BD6_NUMERO,BD6_SEQUEN, " + c_ent
        cQuery += "         BD6_CODRDA, " + c_ent
        cQuery += "         BD6_NOMUSR , " + c_ent
        cQuery += "         BD6_CODPAD TABELA, " + c_ent
        cQuery += "         DESC_FAIXA_ETARIA (IDADE_MATRIC ( BD6_CODEMP,BD6_MATRIC,BD6_TIPREG,'I',BD6_DATPRO),4) FAIXA, " + c_ent
        cQuery += "         BD6_YPROJ PROJ, " + c_ent
        cQuery += "         BD6_CODESP CODESP,BD6_CONEMP, " + c_ent
        cQuery += "         BD6_YPROJU PROC_JURID, " + c_ent
        cQuery += "         BD6_PREFIX,BD6_NUMTIT,BD6_PARCEL,BD6_TIPTIT, " + c_ent
        cQuery += "         'S' Rol, " + c_ent
        cQuery += "         BD6_SEQPF, " + c_ent
        cQuery += "         BD6_ANOPAG,BD6_MESPAG " + c_ent
        cQuery += "    FROM SIGA.B19020 B19, SIGA.SD1020 SD1, SIGA.SF1020 SF1, SIGA.BD6020 BD6 , " + c_ent
        cQuery += "		 SIGA.SA2020 SA2, ZZT010 ZZT  ,BI3020 BI3 ,BG9020  BG9, se1020  " + c_ent
        cQuery += "    WHERE BI3_FILIAL=' ' " + c_ent
        cQuery += "	AND A2_FILIAL=' ' " + c_ent
        cQuery += "	AND A2_COD = B19_FORNEC " + c_ent
        cQuery += "	AND SUBSTR(F1_YDTCON,01,04) = '" + cAno + "' " + c_ent
	    cQuery += "	AND SUBSTR(F1_YDTCON,05,02) =  '" + cMes + "'  " + c_ent
        //cQuery += "	AND F1_YDTCON  like '" + cAno + "'||'" + cMes + "'||'%'   " + c_ent
        cQuery += "	and BD6_CODEMP BETWEEN '" + cEmpini + "' AND  '" + cEmpate + "'    " + c_ent
        cQuery += "	AND D1_FORNECE= A2_COD " + c_ent
        cQuery += "	AND f1_FORNECE= A2_COD " + c_ent
        cQuery += "	AND D1_DOC = F1_DOC " + c_ent
        cQuery += "	AND B19_DOC = D1_DOC " + c_ent
        cQuery += "	AND D1_ITEM = B19_ITEM " + c_ent
        cQuery += "	AND BD6_FILIAL = ' ' " + c_ent
        cQuery += "	AND ZZT_FILIAL=' ' " + c_ent
        cQuery += "	AND BG9_FILIAL=' ' " + c_ent
        cQuery += "	AND BD6_CODPLA=BI3_CODIGO " + c_ent
        cQuery += "	AND BD6_CODOPE = SubStr(B19_GUIA,01,04) " + c_ent
        cQuery += "	AND BD6_CODLDP = SubStr(B19_GUIA,05,04) " + c_ent
        cQuery += "	AND BD6_CODPEG = SubStr(B19_GUIA,09,08) " + c_ent
        cQuery += "	AND BD6_NUMERO = SubStr(B19_GUIA,17,08) " + c_ent
        cQuery += "	AND BD6_ORIMOV = SubStr(B19_GUIA,25,01) " + c_ent
        cQuery += "	AND BD6_SEQUEN = SubStr(B19_GUIA,26,03) " + c_ent
        cQuery += "	AND BD6_FASE IN ('3','4') " + c_ent
        cQuery += "	AND BD6_CODLDP='0013' " + c_ent
        cQuery += "	AND BD6_SITUAC = '1' " + c_ent
        cQuery += "	AND BD6_YNEVEN=ZZT_CODEV " + c_ent
        cQuery += "	AND BD6_OPEUSR=BG9_CODINT " + c_ent
        cQuery += "	AND BD6_CODEMP=BG9_CODIGO " + c_ent
        cQuery += "	AND SA2.D_E_L_E_T_ = ' ' " + c_ent
        cQuery += "	AND B19.D_E_L_E_T_ = ' ' " + c_ent
        cQuery += "	AND SD1.D_E_L_E_T_ = ' ' " + c_ent
        cQuery += "	AND SF1.D_E_L_E_T_ = ' ' " + c_ent
        cQuery += "	AND BD6.D_E_L_E_T_ = ' ' " + c_ent
        cQuery += "	AND ZZT.D_E_L_E_T_ = ' ' " + c_ent
        cQuery += "	AND BI3.D_E_L_E_T_ = ' ' " + c_ent
        cQuery += "	AND BG9.D_E_L_E_T_ = ' ' " + c_ent
        cQuery += "	GROUP BY F1_YDTCON, " + c_ent
        cQuery += "			 BD6_OPEUSR, " + c_ent
        cQuery += "			 BD6_CODEMP, " + c_ent
        cQuery += "			 BD6_MATRIC, " + c_ent
        cQuery += "			 BD6_TIPREG, " + c_ent
        cQuery += "			 BD6_DIGITO, " + c_ent
        cQuery += "			 SIGA_TIPO_EXPOSICAO_ANS_INT(BD6_CODEMP,BD6_MATRIC,BD6_TIPREG,To_Date(Trim(BD6_DATPRO),'YYYYMMDD')), " + c_ent
        cQuery += "			 BD6_CODEMP, " + c_ent
        cQuery += "			 BD6_CODPLA, " + c_ent
        cQuery += "			 RETORNA_DESCRI_GRUPO_PLANO ( TRIM(BI3_YGRPLA),BD6_CODEMP,'I'), " + c_ent
        cQuery += "			 Decode(BD6_CODEMP,'0007',Trim(BI3_NREDUZ)||' (SEPE)',BI3_NREDUZ), " + c_ent
        cQuery += "			 BD6_YNEVEN, " + c_ent
        cQuery += "			 Trim(BD6_DESPRO), " + c_ent
        cQuery += "			 BG9_CODIGO ,BG9_DESCRI  ,B19_DOC , " + c_ent
        cQuery += "			 BD6_OPEUSR,BD6_MATRIC,BD6_TIPREG,BD6_NOMUSR, " + c_ent
        cQuery += "			 To_Date(BD6_DATPRO,'YYYYMMDD') , " + c_ent
        cQuery += "			 BD6_CODLDP, BD6_CODPEG, BD6_NUMERO,BD6_SEQUEN, " + c_ent
        cQuery += "			 BD6_CODRDA, " + c_ent
        cQuery += "			 BD6_YPROJ , " + c_ent
        cQuery += "			 BD6_CODPAD , " + c_ent
        cQuery += "			 DESC_FAIXA_ETARIA (IDADE_MATRIC ( BD6_CODEMP,BD6_MATRIC,BD6_TIPREG,'I',BD6_DATPRO),4), " + c_ent
        cQuery += "			 ZZT_EVENTO,ZZT_TPCUST,BD6_CODRDA,BD6_CODPRO , BD6_CODPAD ,BD6_DATPRO,              " + c_ent
        cQuery += "			 BD6_PREFIX,BD6_NUMTIT,BD6_PARCEL,BD6_TIPTIT, " + c_ent
        cQuery += "			 BD6_CODESP ,BD6_CONEMP, " + c_ent
        cQuery += "			 BD6_YPROJU , " + c_ent
        cQuery += "			 BD6_SEQPF, " + c_ent
        cQuery += "			 BD6_ANOPAG,BD6_MESPAG " + c_ent
        cQuery += "    UNION " + c_ent
        cQuery += "	SELECT  DISTINCT " + c_ent
        cQuery += "         F1_YDTCON, " + c_ent
        cQuery += "         BD6_OPEUSR OPEUSR, " + c_ent
        cQuery += "         BD6_CODEMP CODEMP, " + c_ent
        cQuery += "         BD6_MATRIC MATRIC, " + c_ent
        cQuery += "         BD6_TIPREG TIPREG, " + c_ent
        cQuery += "         BD6_DIGITO DIGITO, " + c_ent
        cQuery += "         BD6_CODPLA PLANO, " + c_ent
        cQuery += "         BD6_YNEVEN CODEVENTO, " + c_ent
        cQuery += "         ZZT_EVENTO NOME_EVENTO, " + c_ent
        cQuery += "         1 QTDE, " + c_ent
        cQuery += "         1 Ocorrencia, " + c_ent
        cQuery += "         0 Glosado, " + c_ent
        cQuery += "         0 Vl_Aprov, " + c_ent
        cQuery += "         Nvl( BD7_VLRTPF,0) Vl_Participacao, " + c_ent
        cQuery += "         SIGA_TIPO_EXPOSICAO_ANS_INT(BD6_CODEMP,BD6_MATRIC,BD6_TIPREG,To_Date(Trim(BD6_DATPRO),'YYYYMMDD')) EXPOSICAO_ANS , " + c_ent
        cQuery += "         RETORNA_DESCRI_GRUPO_PLANO ( TRIM(BI3_YGRPLA),BD6_CODEMP,'I') GRUPO_PLANO, " + c_ent
        cQuery += "         Decode(BD6_CODEMP,'0007',Trim(BI3_NREDUZ)||' (SEPE)',BI3_NREDUZ) NOME_PLANO, " + c_ent
        cQuery += "         ZZT_TPCUST , " + c_ent
        cQuery += "         BD6_CODRDA RDA , " + c_ent
        cQuery += "         BD6_CODPRO COD_PROCED, " + c_ent
        cQuery += "         Trim(BD6_DESPRO) DESPRO, " + c_ent
        cQuery += "         BG9_CODIGO GRUPO_EMP,BG9_DESCRI DESC_EMP ,B19_DOC , " + c_ent
        cQuery += "         BD6_OPEUSR,BD6_MATRIC,BD6_TIPREG , " + c_ent
        cQuery += "         To_Date(BD6_DATPRO,'YYYYMMDD') DATA, " + c_ent
        cQuery += "         BD6_CODLDP, BD6_CODPEG, BD6_NUMERO,BD6_SEQUEN, " + c_ent
        cQuery += "         BD6_CODRDA, " + c_ent
        cQuery += "         BD6_NOMUSR, " + c_ent
        cQuery += "         BD6_CODPAD TABELA, " + c_ent
        cQuery += "         DESC_FAIXA_ETARIA (IDADE_MATRIC ( BD6_CODEMP,BD6_MATRIC,BD6_TIPREG,'I',BD6_DATPRO),4) FAIXA, " + c_ent
        cQuery += "         BD6_YPROJ PROJ, " + c_ent
        cQuery += "         BD6_CODESP CODESP, " + c_ent
        cQuery += "         BD6_CONEMP, " + c_ent
        cQuery += "         BD6_YPROJU PROC_JURID, " + c_ent
        cQuery += "         BD6_PREFIX,BD6_NUMTIT,BD6_PARCEL,BD6_TIPTIT, " + c_ent
        cQuery += "         'S' Rol, " + c_ent
        cQuery += "         BD6_SEQPF, " + c_ent
        cQuery += "         BD6_ANOPAG,BD6_MESPAG " + c_ent
        cQuery += "    FROM SIGA.B19020 B19, SIGA.SD1020 SD1, SIGA.SF1020 SF1, SIGA.BD6020 BD6 , " + c_ent
        cQuery += "		 SIGA.SA2020 SA2, ZZT010 ZZT  ,BI3020 BI3 ,BD7020 BD7  ,BG9020  BG9 " + c_ent
        cQuery += "	WHERE BI3_FILIAL=' ' " + c_ent
        cQuery += "	AND A2_FILIAL=' ' " + c_ent
        cQuery += "	AND B19_FILIAL=' ' " + c_ent
        cQuery += "	AND BG9_FILIAL=' ' " + c_ent
        cQuery += "	AND SUBSTR(F1_YDTCON,01,04) = '" + cAno + "' " + c_ent
	    cQuery += "	AND SUBSTR(F1_YDTCON,05,02) =  '" + cMes + "'  " + c_ent
        //cQuery += "	AND F1_YDTCON like '" + cAno + "'||'" + cMes + "'||'%' " + c_ent
        cQuery += "	AND D1_FILIAL='01' " + c_ent
        cQuery += "	AND F1_FILIAL='01' " + c_ent
        cQuery += "	AND BD7_FILIAL=' ' " + c_ent
        cQuery += "	AND A2_COD = B19_FORNEC " + c_ent
        cQuery += "	AND D1_FORNECE= A2_COD " + c_ent
        cQuery += "	AND f1_FORNECE= A2_COD " + c_ent
        cQuery += "	AND D1_DOC = F1_DOC " + c_ent
        cQuery += "	AND B19_DOC = D1_DOC " + c_ent
        cQuery += "	AND D1_ITEM = B19_ITEM " + c_ent
        cQuery += "	AND BD6_FILIAL = ' ' " + c_ent
        cQuery += "	AND ZZT_FILIAL=' ' " + c_ent
        cQuery += "	AND BD6_CODPLA=BI3_CODIGO " + c_ent
        cQuery += "	AND BD6_CODOPE = SubStr(B19_GUIA,01,04) " + c_ent
        cQuery += "	AND BD6_CODLDP = SubStr(B19_GUIA,05,04) " + c_ent
        cQuery += "	AND BD6_CODPEG = SubStr(B19_GUIA,09,08) " + c_ent
        cQuery += "	AND BD6_NUMERO = SubStr(B19_GUIA,17,08) " + c_ent
        cQuery += "	AND BD6_ORIMOV = SubStr(B19_GUIA,25,01) " + c_ent
        cQuery += "	AND BD6_SEQUEN = SubStr(B19_GUIA,26,03) " + c_ent
        cQuery += "	AND BD7_CODPRO IN ('01990012','02990016','03990010') " + c_ent
        cQuery += "	AND BD7_CODOPE = BD6_CODOPE " + c_ent
        cQuery += "	AND BD7_CODLDP = BD6_CODLDP " + c_ent
        cQuery += "	AND BD7_CODPEG = BD6_CODPEG " + c_ent
        cQuery += "	AND BD7_NUMERO = BD6_NUMERO " + c_ent
        cQuery += "	AND BD6_FASE IN ('3','4') " + c_ent
        cQuery += "	AND BD6_CODLDP='0013' " + c_ent
        cQuery += "	AND BD6_SITUAC = '1' " + c_ent
        cQuery += "	AND BD6_YNEVEN=ZZT_CODEV " + c_ent
        cQuery += "	AND BD6_OPEUSR=BG9_CODINT " + c_ent
        cQuery += "	AND BD6_CODEMP=BG9_CODIGO " + c_ent
        cQuery += " " + c_ent
        cQuery += "	AND SA2.D_E_L_E_T_ = ' ' " + c_ent
        cQuery += "	AND B19.D_E_L_E_T_ = ' ' " + c_ent
        cQuery += "	AND BG9.D_E_L_E_T_ = ' ' " + c_ent
        cQuery += "	AND SD1.D_E_L_E_T_ = ' ' " + c_ent
        cQuery += "	AND SF1.D_E_L_E_T_ = ' ' " + c_ent
        cQuery += "	AND BD6.D_E_L_E_T_ = ' ' " + c_ent
        cQuery += "	AND ZZT.D_E_L_E_T_ = ' ' " + c_ent
        cQuery += "	AND BI3.D_E_L_E_T_ = ' ' " + c_ent
        cQuery += "	AND BD7.D_E_L_E_T_ = ' ' " + c_ent
        cQuery += "	) " + c_ent
        cQuery += "WHERE VL_PARTICIPACAO<>0 " + c_ent
        cQuery += "GROUP BY CODEMP , DESC_EMP , " + c_ent
        cQuery += "		   DATA ,COD_PROCED,BD6_SEQUEN, " + c_ent
        cQuery += "		   DESPRO, " + c_ent
        cQuery += "		   PROJ, " + c_ent
        cQuery += "		   OPEUSR ||'.'||CODEMP ||'.'|| MATRIC ||'.'||TIPREG ||'-'||DIGITO , " + c_ent
        cQuery += "		   BD6_NOMUSR , " + c_ent
        cQuery += "		   CODEVENTO , " + c_ent
        cQuery += "		   NOME_EVENTO,  " + c_ent
        cQuery += "		   DECODE(TRIM(BD6_PREFIX),'','N„o cobrado','Cobrado')  ,            " + c_ent
        cQuery += "		   BD6_CODLDP||BD6_CODPEG||BD6_NUMERO , " + c_ent
        cQuery += "		   BD6_PREFIX||BD6_NUMTIT||BD6_PARCEL||BD6_TIPTIT,EXPOSICAO_ANS, " + c_ent
        cQuery += "		   BD6_SEQPF, " + c_ent
        cQuery += "		   TRIM(RETORNA_DESCRI_GRUPO_COBERT('I',substr(RETORNA_GRUPO_COBERT ( 'I',TABELA,COD_PROCED,  'G'),1,3))), " + c_ent
        cQuery += "		   BD6_ANOPAG||'/'||BD6_MESPAG, " + c_ent
        cQuery += "		   RETORNA_DESC_TIPPAG_MS ( 'I',OPEUSR || CODEMP||MATRIC || TIPREG ||DIGITO) "
    EndIf
    
    MemoWrite( "c:\temp\CONCOP.sql" , cQuery )
    
    If TcSqlExec(cQuery) <> 0	
        cErro := " - Erro na execuÁ„o da procedure " + CRLF + Space(3) + cQuery + CRLF + Space(3) + 'TcSqlError [ ' + TcSqlError() + ' ]'
        MsgAlert(cErro) 
        Return          	
    Else
        If Select("R284") > 0
            dbSelectArea("R284")
            dbCloseArea()
        EndIf
        
        DbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),"R284",.T.,.T.)         
        nSucesso := 0
        
        For nI := 1 to 5
            IncProc('Gerando RelatÛrio em Excel...')
        Next

        If ! R284->(Eof())
            aCabec := {"TIPO","REF","COD_EMPRESA","EMPRESA","GRUPO_COBERT","DATPRO","COD_PROCED","DESPRO","PROJ","MATRICULA","NOMUSR","COD_EVENTO","NOME_EVENTO","COBRADO",;
                    "CONSOLIDADO","PERCENT","SEQ","GLOSADO","VL_APROV","VL_PARTICIPACAO","GUIA","NUMTIT","EXPO","TIPOCOB"} 
            R284->(DbGoTop())

            While !R284->(Eof()) 
                IncProc()	
                aaDD(aDados,{R284->TIPO , R284->REF , R284->CODEMP , R284->EMPRESA , R284->GRUPO_COBERT , R284->COD_PROCED , R284->DATPRO ,R284->DESPRO , R284->PROJ , R284->MATRICULA ,R284->NOMUSR , R284->COD_EVENTO , R284->NOME_EVENTO , R284->COBRADO ,;
                            R284->CONSOLIDADO , R284->PERC, R284->SEQ ,R284->GLOSADO ,R284->VL_APROV , R284->VL_PARTICIPACAO , R284->GUIA , R284->NUMTIT , R284->EXPO , R284->TIPOCOB})  
                R284->(DbSkip())
            EndDo

            //Abre excel 
            DlgToExcel({{"ARRAY"," " ,aCabec,aDados}})

            If Select("R284") > 0
                dbSelectArea("R284")
                dbCloseArea()
            EndIf 
        EndIf
        If MsgYesNo("Rotina Executada com sucesso , Deseja Emitir o Relatorio em Tela? ")      
            cParam1 :=  alltrim(str(cEmp)) + ";" + cAno + ";" + cMes + ";" + cEmpini + ";" + cEmpate + ";" + str(cAgremp)
            CallCrys(cCrystal,cParam1,cCRPar)
        EndIf	 
   	Endif
   
Else
    cParam1 :=  alltrim(str(cEmp)) + ";" + cAno + ";" + cMes + ";" + cEmpini + ";" + cEmpate + ";" + str(cAgremp)
    CallCrys(cCrystal,cParam1,cCRPar)
EndIf

Return
 
*************************************************************************************************************************
Static Function AjustaSX1     

Local aHelp 	:= {}
Local aArea2	:= GetArea()  

aHelp := {}
aAdd(aHelp, "Informe a Operadora")         
PutSX1(cPerg , "01" , "Operadora:" ,"","","mv_ch01","N",01,0,0,"C","","","","","mv_par01","CABERJ","","","INTEGRAL","","","","","","","","","","","","",aHelp,aHelp,aHelp)
//
aHelp := {}
aAdd(aHelp, "Informe a Ano ReferÍncia")         
PutSX1(cPerg , "02" , "Ano:"  ,"","","mv_ch02","C",04,0,0,"C","","","","","mv_par02","","","","","","","","","","","","","","","","",aHelp,aHelp,aHelp)
//
aAdd(aHelp, "Informe o MÍs de ReferÍncia")         
PutSX1(cPerg , "03" , "Mes:" ,"","","mv_ch03","C",02,0,0,"C","","","","","mv_par03","","","","","","","","","","","","","","","","",aHelp,aHelp,aHelp)
//
aHelp := {}
aAdd(aHelp, "Informe o Grupo Empresa Inicial")         
PutSX1(cPerg , "04" , "Grupo Emp de:","","","mv_ch04","C",04,0,0,"C","","","","","mv_par04","","","","","","","","","","","","","","","","",aHelp,aHelp,aHelp)
//
aHelp := {}
aAdd(aHelp, "Informe o Grupo Empresa Final")         
PutSX1(cPerg , "05" , "Grupo Emp ate:","","","mv_ch05","C",04,0,0,"C","","","","","mv_par05","","","","","","","","","","","","","","","","",aHelp,aHelp,aHelp)
//
aHelp := {}
aAdd(aHelp, "Informe se Deseja Agrupar por Empresa")         
PutSX1(cPerg , "06" , "Agrupar por Empresa?" ,"","","mv_ch06","N",01,0,0,"C","","","","","mv_par06","SIM","","","N√O","","","","","","","","","","","","",aHelp,aHelp,aHelp)
//
aHelp := {}
aAdd(aHelp, "Gera Excel do RelaÛrio Crystal CONCOP")         
PutSX1(cPerg , "07" , "Gera Excel?" ,"","","mv_ch07","N",01,0,0,"C","","","","","mv_par07","SIM","","","N√O","","","","","","","","","","","","",aHelp,aHelp,aHelp) 

RestArea(aArea2)

Return	