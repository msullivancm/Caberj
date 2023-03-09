#INCLUDE "rwmake.ch"
#INCLUDE "protheus.ch"
#INCLUDE "TopConn.ch"
#include "TBICONN.CH"

#DEFINE c_ent CHR(13) + CHR(10)

/*
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±…ÕÕÕÕÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÕÕÕÀÕÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÀÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÕÕÕª±±
±±∫Programa  ≥CABR248      ∫Autor  ≥ Marcela Coimbra    ∫ Data ≥ 23/02/2018  ∫±±
±±ÃÕÕÕÕÕÕÕÕÕÕÿÕÕÕÕÕÕÕÕÕÕÕÕÕ ÕÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕ ÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕÕÕπ±±
±±∫Desc.     ≥  Maprec Integral                                              ∫±±
±±∫          ≥  		                                                     ∫±±
±±ÃÕÕÕÕÕÕÕÕÕÕÿÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕπ±±
±±∫Uso       ≥ Projeto CABERJ                                                ∫±±
±±»ÕÕÕÕÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕº±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±'±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
*/
User Function CABR248()
	
	Processa({||PCABR248()},'Processando...')
	
Return

Static Function PCABR248()
	
	Local aSaveArea	:= {}
	
	Local a_Cabec 		:= {}
	Local a_Dados 		:= {}
	Local a_Item 		:= {}
	Local a_DadosTmp 	:= {}
	Local n_Cont  		:= 1
	Private cPerg 		:= "CABRX248"
	Private cQuery		:= ""
	
	Private c_Pivot 	:= ""
	Private c_Pivot2 	:= ""
	
	
	AjustaSX1(cPerg)
	
	If Pergunte(cPerg,.T.)
		
		c_EmpDe		:= Mv_Par01
		c_EmpAte	:= Mv_Par02
		c_EmisDe	:= dtos(Mv_Par03)
		c_EmisAte	:= dtos(Mv_Par04)
		c_CompDe	:= Mv_Par05
		c_CompAte	:= Mv_Par06
		
	else
		
		Return
		
	EndIf
	
	a_Cabec := {	"FILIAL",;
		"RPS",;
		"NOTA FISCAL",;
		"EMISSAO",;
		"TRANSMISSAO",;
		"EMPRESA",;
		"RAZ√O SOCIAL",;
		"NÕVEL",;
		"VENCIMENTO",;
		"COMPETENCIA",;
		"VALOR_TITULO",;
		"VALOR NOTA" }
	
	
	
	cQuery := " select distinct BM1_CODTIP, BM1_DESTIP " + c_ent
	cQuery += " from " + RetSqlName("SF2") + " SF2 inner join " + RetSqlName("SD2") + " SD2 on D2_DOC = F2_DOC  " + c_ent
	cQuery += "                                         and D2_SERIE = F2_SERIE " + c_ent
	cQuery += "                                         and SD2.D_E_L_E_T_ = ' ' " + c_ent
	cQuery += ""
	cQuery += "                               inner join " + RetSqlName("SE1") + " SE1 on E1_FILIAL = '01' "  + c_ent
	cQuery += "                                         and E1_PREFIXO = D2_XPREPLS " + c_ent
	cQuery += "                                         and E1_NUM = D2_XTITPLS " + c_ent
	cQuery += "                                         and E1_TIPO = 'DP' " + c_ent
	cQuery += "                                         and decode(trim(E1_XFILNF), '', '01',  E1_XFILNF ) = F2_FILIAL " + c_ent
	cQuery += "                                         and SE1.D_E_L_E_T_ = ' ' " + c_ent
	
	cQuery += "                               inner join " + RetSqlName("BM1") + " BM1 on BM1_FILIAL = ' ' " + c_ent
	cQuery += "                                       and BM1_PREFIX = E1_PREFIXO " + c_ent
	cQuery += "                                       and BM1_NUMTIT = E1_NUM " + c_ent
	cQuery += "                                       and BM1_CODTIP not in ( '903') " + c_ent
	cQuery += "                                       and BM1.D_E_L_E_T_ = ' ' " + c_ent
	
	
	cQuery += " where F2_EMINFE between '" + c_EmisDe + "' and '" + dtos(lastday(stod(c_EmisAte))) + "'" + c_ent
	cQuery += "       and E1_CODEMP between 			 '" + c_EmpDe  	+ "'   and '" + c_EmpAte 	+ "'" + c_ent
	cQuery += "       and E1_ANOBASE||E1_MESBASE between '" + c_CompDe  	+ "'   and '" + c_CompAte 	+ "'" + c_ent
	
	cQuery += "       and F2_CODNFE <> ' '" + c_ent
	cQuery += " order by 1 " + c_ent
	MemoWrite("C:\Temp1\query_CABR248_1.txt",cQuery)
	//	cQuery := ChangeQuery( cQuery )
	DbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),"R248F",.T.,.T.)
	IF !R248F->( EOF() )
		While !R248F->( EOF() )
			
			c_Pivot 	+= "'" + R248F->BM1_CODTIP  + "', "
			c_Pivot2 	+= '"'+ "'" + R248F->BM1_CODTIP  + "'" + '"'+ " TIPO_"+R248F->BM1_CODTIP + ", "
			
			aadd(a_Cabec, "'" + R248F->BM1_CODTIP + "'" )
			aadd(a_Item	, "R233->TIPO_" + R248F->BM1_CODTIP  )
			
			R248F->( dbSkip() )
			
		EndDo
		
		c_Pivot  := substr(c_Pivot , 1, len(c_Pivot) - 2) + " "
		c_Pivot2 := substr(c_Pivot2, 1, len(c_Pivot2) - 2) + " "
		
		R248F->( dbCloseArea() )
		// Seleciona nota fiscal transmitida eletronicamente
		cQuery := " SELECT FILIAL, RPS,F2_NFELETR, F2_EMINFE, F2_HORNFE,RAZAO_SOCIAL,CODIGO_EMPRESA,ENPRESA, competencia, nivel, vento,  valor_titulo, valor_nota, " + c_Pivot2 + " "+ c_ent
		cQuery += " FROM (   " + c_ent
		cQuery += " Select " + c_ent
		cQuery += "  decode(f2_filial, '01', 'RIO', 'NITEROI') FILIAL, " + c_ent
		cQuery += "           f2_doc RPS," + c_ent
		cQuery += " F2_NFELETR, " + c_ent
		cQuery += " F2_EMINFE, " + c_ent
		cQuery += " F2_HORNFE, " + c_ent
		cQuery += " a1_nome razao_social," + c_ent
		cQuery += " bg9_codigo codigo_empresa," + c_ent
		cQuery += " BG9_DESCRI Enpresa," + c_ent
		cQuery += " (case when trim(ba3_vencto) <> ' ' then 'FAMÕLIA' " + c_ent
		cQuery += "        when trim(BQC_vencto) <> ' ' then 'SUBCONTRATO'" + c_ent
		cQuery += "        when trim(Bt5_vencto) <> ' ' then 'CONTRATO' else 'EMPRESA' end ) nivel," + c_ent
		cQuery += " (case when trim(ba3_vencto) <> ' ' then ba3_vencto " + c_ent
		cQuery += "        when trim(BQC_vencto) <> ' ' then BQC_vencto  " + c_ent
		cQuery += "        when trim(Bt5_vencto) <> ' ' then Bt5_vencto else Bg9_vencto end ) vento," + c_ent
		cQuery += "        e1_mesbase||'/'||e1_anobase competencia," + c_ent
		cQuery += "        bm1_codtip tipo," + c_ent
		cQuery += "        e1_valor valor_titulo," + c_ent
		cQuery += "        f2_valbrut valor_nota," + c_ent
		cQuery += "        SUM (DECODE ( BM1_TIPO , 1 ,BM1_VALOR, (BM1_VALOR*-1))) valor" + c_ent
		
		cQuery += " from " + RetSqlName("SF2") + " sf2 inner join " + RetSqlName("SD2") + " sd2 on d2_doc = f2_doc " + c_ent
		cQuery += "                                         and d2_serie = f2_serie " + c_ent
		cQuery += "                                         and sd2.d_e_l_E_t_ = ' '" + c_ent
		
		cQuery += "                               inner join " + RetSqlName("SE1") + " se1 on e1_filial = '01'" + c_ent
		cQuery += "                                         and e1_prefixo = D2_XPREPLS" + c_ent
		cQuery += "                                         and e1_num = D2_XTITPLS" + c_ent
		cQuery += "                                         and e1_tipo = 'DP'" + c_ent
		cQuery += "                                         and decode(trim(E1_XFILNF), '', '01',  E1_XFILNF ) = F2_FILIAL " + c_ent
		cQuery += "                                         and se1.d_e_l_e_t_ = ' '" + c_ent
		
		cQuery += "                               inner join " + RetSqlName("BM1") + " BM1 on bm1_filial = ' '" + c_ent
		cQuery += "                                       and bm1_prefix = e1_prefixo" + c_ent
		cQuery += "                                       and bm1_numtit = e1_num" + c_ent
		cQuery += "                                       and BM1_CODTIP NOT IN ( '903')" + c_ent
		cQuery += "                                       and bm1.d_e_l_e_t_ = ' '" + c_ent
		
		cQuery += "                               inner join " + RetSqlName("SA1") + " sa1 on a1_filial = ' '" + c_ent
		cQuery += "                                         and a1_cod = e1_cliente" + c_ent
		cQuery += "                                         and sa1.d_e_l_e_t_ = ' '" + c_ent
		
		cQuery += "                               inner join " + RetSqlName("BG9") + " bg9 on bg9_filial = ' '" + c_ent
		cQuery += "                                         and bg9_codint = '0001'" + c_ent
		cQuery += "                                         and bg9_codigo = e1_codemp" + c_ent
		cQuery += "                                         and bg9.d_e_l_e_t_ = ' '" + c_ent
		
		cQuery += "                               left join " + RetSqlName("BT5") + " bt5 on bt5_filial = ' '" + c_ent
		cQuery += "                                         and bt5_codint = e1_codint" + c_ent
		cQuery += "                                         and bt5_codigo = e1_codemp" + c_ent
		cQuery += "                                         and BT5_NUMCON = e1_numcon" + c_ent
		
		cQuery += "                               left join " + RetSqlName("BQC") + " bqc on bqc_filial = ' '" + c_ent
		cQuery += "                                         and bqc_codigo = e1_codint||e1_codemp" + c_ent
		cQuery += "                                         and BQC_NUMCON = E1_CONEMP" + c_ent
		cQuery += "                                         and BQC_SUBCON = e1_subcon" + c_ent
		cQuery += "                                         and bqc.d_e_l_e_t_ = ' '" + c_ent
		
		cQuery += "                               left join " + RetSqlName("BA3") + " ba3 on ba3_filial = ' '" + c_ent
		cQuery += "                                         and ba3_codint = e1_codint" + c_ent
		cQuery += "                                         and ba3_codemp = e1_codemp" + c_ent
		cQuery += "                                         and Ba3_matric = e1_matric" + c_ent
		
		cQuery += " where F2_EMINFE between '" + c_EmisDe + "' and '" + dtos(lastday(stod(c_EmisAte ))) + "'" + c_ent
		cQuery += "       and E1_CODEMP between 			 '" + c_EmpDe  	+ "'   and '" + c_EmpAte 	+ "'" + c_ent
		cQuery += "       and E1_ANOBASE||E1_MESBASE between '" + c_CompDe  	+ "'   and '" + c_CompAte 	+ "'" + c_ent
		
		cQuery += "      and F2_CODNFE <> ' '" + c_ent
		
		cQuery += " group by  decode(f2_filial, '01', 'RIO', 'NITEROI')," + c_ent
		cQuery += "           f2_doc," + c_ent
		cQuery += "           F2_NFELETR, " + c_ent
		cQuery += "           F2_EMINFE, " + c_ent
		cQuery += "           F2_HORNFE, " + c_ent
		cQuery += "           a1_nome," + c_ent
		cQuery += "             bg9_codigo ," + c_ent
		cQuery += "             BG9_DESCRI," + c_ent
		cQuery += "             (case when trim(ba3_vencto) <> ' ' then 'FAMÕLIA' " + c_ent
		cQuery += "                    when trim(BQC_vencto) <> ' ' then 'SUBCONTRATO'" + c_ent
		cQuery += "                    when trim(Bt5_vencto) <> ' ' then 'CONTRATO' else 'EMPRESA' end ) ," + c_ent
		cQuery += "             (case when trim(ba3_vencto) <> ' ' then ba3_vencto " + c_ent
		cQuery += "                    when trim(BQC_vencto) <> ' ' then BQC_vencto  " + c_ent
		cQuery += "                    when trim(Bt5_vencto) <> ' ' then Bt5_vencto else Bg9_vencto end ) ," + c_ent
		cQuery += "                    e1_mesbase||'/'||e1_anobase ," + c_ent
		cQuery += "                    bm1_codtip ," + c_ent
		cQuery += "                        e1_valor ," + c_ent
		cQuery += "                       f2_valbrut " + c_ent
		cQuery += "        )         "+ c_ent
		cQuery += "        PIVOT ( SUM(VALOR)  "+ c_ent
		cQuery += "               FOR TIPO in( " + c_Pivot + ")  ) A "  + c_ent
		
		MemoWrite("C:\Temp1\query_CABR248_2.txt",cQuery)
		
		//	cQuery := ChangeQuery( cQuery )
		DbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),"R233",.T.,.T.)
		
		// Monta Cabecalho "Fixo"
		
		While ! R233->(Eof())
			
			IncProc()
			a_DadosTmp := {}
			
			AADD(a_DadosTmp,R233->FILIAL)
			AADD(a_DadosTmp,"'"+R233->RPS)
			AADD(a_DadosTmp,"'" + R233->F2_NFELETR,)
			AADD(a_DadosTmp,stod(R233->F2_EMINFE))
			AADD(a_DadosTmp,"'"+R233->F2_HORNFE)
			//	AADD(a_DadosTmp,"'"+R233->razao_social)
			AADD(a_DadosTmp,"'"+R233->codigo_empresa)
			AADD(a_DadosTmp,"'"+R233->Enpresa)
			AADD(a_DadosTmp,"'"+R233->nivel)
			AADD(a_DadosTmp,R233->vento)
			AADD(a_DadosTmp,R233->competencia)
			//	AADD(a_DadosTmp,R233->tipo)
			AADD(a_DadosTmp,R233->valor_titulo)
			AADD(a_DadosTmp,R233->valor_nota)
			
			for n_Count := 1 to Len(a_Item)
				
				AADD(a_DadosTmp,&(a_Item[n_Count]))
				
			Next
			
			aadd( a_Dados, a_DadosTmp )
			
			R233->(DbSkip())
			
		EndDo
		
		// Seleciona nota fiscal digitada manualmente
		cQuery := " SELECT FILIAL, RPS,F2_NFELETR, F2_EMINFE, F2_HORNFE,RAZAO_SOCIAL,CODIGO_EMPRESA,ENPRESA, competencia, nivel, vento,  valor_titulo, valor_nota, " + c_Pivot2 + " "+ c_ent
		cQuery += " FROM "+ c_ent
		cQuery += "  (SELECT DECODE(E1_XFILNF,'01','RIO','NITEROI') FILIAL,"+ c_ent
		cQuery += "    'DIGITACAO MANUAL' RPS, "+ c_ent
		cQuery += "    E1_XDOCNF F2_NFELETR, " + c_ent
		cQuery += "    E1_XDTDIGI F2_EMINFE,"+ c_ent
		cQuery += "    ' ' F2_HORNFE,"+ c_ent
		cQuery += "    A1_NOME RAZAO_SOCIAL,"+ c_ent
		cQuery += "    BG9_CODIGO CODIGO_EMPRESA,"+ c_ent
		cQuery += "    BG9_DESCRI ENPRESA,"+ c_ent
		cQuery += "    ("+ c_ent
		cQuery += "    CASE"+ c_ent
		cQuery += "      WHEN TRIM(BA3_VENCTO) <> ' '"+ c_ent
		cQuery += "      THEN 'FAMÕLIA'"+ c_ent
		cQuery += "      WHEN TRIM(BQC_VENCTO) <> ' '"+ c_ent
		cQuery += "      THEN 'SUBCONTRATO'"+ c_ent
		cQuery += "      WHEN TRIM(BT5_VENCTO) <> ' '"+ c_ent
		cQuery += "      THEN 'CONTRATO'"+ c_ent
		cQuery += "      ELSE 'EMPRESA'"+ c_ent
		cQuery += "    END ) NIVEL,"+ c_ent
		cQuery += "    ("+ c_ent
		cQuery += "    CASE"+ c_ent
		cQuery += "      WHEN TRIM(BA3_VENCTO) <> ' '"+ c_ent
		cQuery += "      THEN BA3_VENCTO"+ c_ent
		cQuery += "      WHEN TRIM(BQC_VENCTO) <> ' '"+ c_ent
		cQuery += "      THEN BQC_VENCTO"+ c_ent
		cQuery += "      WHEN TRIM(BT5_VENCTO) <> ' '"+ c_ent
		cQuery += "      THEN BT5_VENCTO"+ c_ent
		cQuery += "      ELSE BG9_VENCTO"+ c_ent
		cQuery += "    END ) VENTO,"+ c_ent
		cQuery += "    E1_MESBASE"+ c_ent
		cQuery += "    ||'/'"+ c_ent
		cQuery += "    ||E1_ANOBASE COMPETENCIA,"+ c_ent
		cQuery += "    BM1_CODTIP TIPO,"+ c_ent
		cQuery += "    E1_VALOR VALOR_TITULO,"+ c_ent
		cQuery += "    e1_valor VALOR_NOTA,"+ c_ent
		cQuery += "    SUM (DECODE (BM1_TIPO,1,BM1_VALOR,(BM1_VALOR*-1))) VALOR"+ c_ent
		cQuery += "  FROM " + RETSQLNAME("SE1") + " SE1  INNER JOIN " + RETSQLNAME("BM1") + " BM1 " + c_ent
		cQuery += "  ON BM1_FILIAL       = ' '"+ c_ent
		cQuery += "  AND BM1_PREFIX      = E1_PREFIXO"+ c_ent
		cQuery += "  AND BM1_NUMTIT      = E1_NUM"+ c_ent
		cQuery += "  AND BM1_CODTIP NOT IN ('903')"+ c_ent
		cQuery += "  AND BM1.D_E_L_E_T_  = ' '"+ c_ent
		cQuery += "  INNER JOIN " + RETSQLNAME("SA1") + " SA1"+ c_ent
		cQuery += "  ON A1_FILIAL       = ' '" + c_ent
		cQuery += "  AND A1_COD         = E1_CLIENTE" + c_ent
		cQuery += "  AND SA1.D_E_L_E_T_ = ' '" + c_ent
		cQuery += "  INNER JOIN " + RETSQLNAME("BG9") + " BG9" + c_ent
		cQuery += "  ON BG9_FILIAL      = ' '" + c_ent
		cQuery += "  AND BG9_CODINT     = '0001'" + c_ent
		cQuery += "  AND BG9_CODIGO     = E1_CODEMP" + c_ent
		cQuery += "  AND BG9.D_E_L_E_T_ = ' '" + c_ent
		cQuery += "  LEFT JOIN " + RETSQLNAME("BT5") + " BT5" + c_ent
		cQuery += "  ON BT5_FILIAL  = ' '" + c_ent
		cQuery += "  AND BT5_CODINT = E1_CODINT" + c_ent
		cQuery += "  AND BT5_CODIGO = E1_CODEMP" + c_ent
		cQuery += "  AND BT5_NUMCON = E1_NUMCON" + c_ent
		cQuery += "  LEFT JOIN " + RETSQLNAME("BQC") + " BQC" + c_ent
		cQuery += "  ON BQC_FILIAL  = ' '" + c_ent
		cQuery += "  AND BQC_CODIGO = E1_CODINT" + c_ent
		cQuery += "    ||E1_CODEMP" + c_ent
		cQuery += "  AND BQC_NUMCON     = E1_CONEMP" + c_ent
		cQuery += "  AND BQC_SUBCON     = E1_SUBCON" + c_ent
		cQuery += "  AND BQC.D_E_L_E_T_ = ' '" + c_ent
		cQuery += "  LEFT JOIN " + RETSQLNAME("BA3") + " BA3" + c_ent
		cQuery += "  ON BA3_FILIAL  = ' '" + c_ent
		cQuery += "  AND BA3_CODINT = E1_CODINT" + c_ent
		cQuery += "  AND BA3_CODEMP = E1_CODEMP" + c_ent
		cQuery += "  AND BA3_MATRIC = E1_MATRIC" + c_ent
		cQuery += "  WHERE E1_XDTDIGI BETWEEN '" + c_EmisDe  + "' and '" + dtos(lastday(stod((c_EmisAte )))) + "'" + c_ent
		cQuery += "       and E1_CODEMP between '" + c_EmpDe  + "'   and '" + c_EmpAte + "'" + c_ent
		cQuery += "       and E1_ANOBASE||E1_MESBASE between '" + c_CompDe  	+ "'   and '" + c_CompAte 	+ "'" + c_ent
		
		cQuery += "  AND E1_XSTDOC = 'M'" + c_ent
		cQuery += "  GROUP BY DECODE(E1_XFILNF, '01', 'RIO', 'NITEROI')," + c_ent
		cQuery += "    'DIGITACAO MANUAL' ," + c_ent
		cQuery += "    E1_XDOCNF ," + c_ent
		cQuery += "    E1_XDTDIGI ," + c_ent
		cQuery += "    ' '," + c_ent
		cQuery += "    A1_NOME," + c_ent
		cQuery += "    BG9_CODIGO ," + c_ent
		cQuery += "    BG9_DESCRI," + c_ent
		cQuery += "    (" + c_ent
		cQuery += "    CASE" + c_ent
		cQuery += "      WHEN TRIM(BA3_VENCTO) <> ' '" + c_ent
		cQuery += "      THEN 'FAMÕLIA'" + c_ent
		cQuery += "      WHEN TRIM(BQC_VENCTO) <> ' '" + c_ent
		cQuery += "      THEN 'SUBCONTRATO'" + c_ent
		cQuery += "      WHEN TRIM(BT5_VENCTO) <> ' '" + c_ent
		cQuery += "      THEN 'CONTRATO'" + c_ent
		cQuery += "      ELSE 'EMPRESA'" + c_ent
		cQuery += "    END ) ," + c_ent
		cQuery += "    (" + c_ent
		cQuery += "    CASE" + c_ent
		cQuery += "      WHEN TRIM(BA3_VENCTO) <> ' '" + c_ent
		cQuery += "      THEN BA3_VENCTO" + c_ent
		cQuery += "      WHEN TRIM(BQC_VENCTO) <> ' '" + c_ent
		cQuery += "      THEN BQC_VENCTO" + c_ent
		cQuery += "      WHEN TRIM(BT5_VENCTO) <> ' '" + c_ent
		cQuery += "      THEN BT5_VENCTO" + c_ent
		cQuery += "      ELSE BG9_VENCTO" + c_ent
		cQuery += "    END ) ," + c_ent
		cQuery += "    E1_MESBASE" + c_ent
		cQuery += "    ||'/'" + c_ent
		cQuery += "    ||E1_ANOBASE ," + c_ent
		cQuery += "    BM1_CODTIP ," + c_ent
		cQuery += "    E1_VALOR ,
		cQuery += "    E1_VALOR" + c_ent
		cQuery += "        )         "+ c_ent
		cQuery += "        PIVOT ( SUM(VALOR)  "+ c_ent
		cQuery += "               FOR TIPO in( " + c_Pivot + ")  ) A "  + c_ent
		MemoWrite("C:\Temp1\query_CABR248_3.txt",cQuery)
		R233->( dbCloseArea() )
		
		cQuery := ChangeQuery( cQuery )
		DbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),"R233",.T.,.T.)
		
		// Monta Cabecalho "Fixo"
		
		While ! R233->(Eof())
			
			IncProc()
			a_DadosTmp := {}
			
			AADD(a_DadosTmp,R233->FILIAL)
			AADD(a_DadosTmp,"'"+R233->RPS)
			AADD(a_DadosTmp,"'" + R233->F2_NFELETR,)
			AADD(a_DadosTmp,stod(R233->F2_EMINFE))
			AADD(a_DadosTmp,"'"+R233->F2_HORNFE)
			//	AADD(a_DadosTmp,"'"+R233->razao_social)
			AADD(a_DadosTmp,"'"+R233->codigo_empresa)
			AADD(a_DadosTmp,"'"+R233->Enpresa)
			AADD(a_DadosTmp,"'"+R233->nivel)
			AADD(a_DadosTmp,R233->vento)
			AADD(a_DadosTmp,R233->competencia)
			//	AADD(a_DadosTmp,R233->tipo)
			AADD(a_DadosTmp,R233->valor_titulo)
			AADD(a_DadosTmp,R233->valor_nota)
			
			for n_Count := 1 to Len(a_Item)
				
				AADD(a_DadosTmp,&(a_Item[n_Count]))
				
			Next
			
			aadd( a_Dados, a_DadosTmp )
			
			R233->(DbSkip())
			
		EndDo
		
		If Select("R233") > 0
			dbSelectArea("R233")
			dbCloseArea()
		EndIf
		
		aAdd(a_Dados ,{"Fim"} )
		//Abre excel
		DlgToExcel({{"ARRAY"," " ,a_Cabec,a_Dados}})
	Else
		MsgInfo("N„o h· dados para serem visualizados com os par‚metros informados. ")
	Endif 
	
Return

*************************************************************************************************************************
//AJUSTAR "COPPRO"
Static Function AjustaSX1()
	
	Local aHelpPor := {}
	
	PutSx1(cPerg,"01","Empresa de:     "  		,"","","mv_ch01","C",04,0,0,"G","","BG9","","","mv_par01","","","","","","","","","","","","","","","","",{},{},{})
	PutSx1(cPerg,"02","Empresa ate:    "  		,"","","mv_ch02","C",04,0,0,"G","","BG9","","","mv_par02","","","","","","","","","","","","","","","","",{},{},{})
	PutSx1(cPerg,"03","Emiss„o NF de:  "  		,"","","mv_ch03","D",06,0,0,"G","","","","","mv_par03","","","","","","","","","","","","","","","","",{},{},{})
	PutSx1(cPerg,"04","Emiss„o NF ate: "  		,"","","mv_ch04","D",06,0,0,"G","","","","","mv_par04","","","","","","","","","","","","","","","","",{},{},{})
	PutSx1(cPerg,"05","CompetÍncia de: "  		,"","","mv_ch05","C",06,0,0,"G","","","","","mv_par03","","","","","","","","","","","","","","","","",{},{},{})
	PutSx1(cPerg,"06","CompetÍncia atÈ:"  		,"","","mv_ch06","C",06,0,0,"G","","","","","mv_par04","","","","","","","","","","","","","","","","",{},{},{})
	
Return

