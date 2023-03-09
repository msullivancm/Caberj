#include "PROTHEUS.CH"
#include "TOTVS.CH"
#include "PLSMGER.CH"  
#INCLUDE "rwmake.ch"                                                                                                                               
#INCLUDE "topconn.ch" 
#INCLUDE "tbiconn.ch" 


#Define CRLF Chr(13)+Chr(10)
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±±
±±³Funcao    ³ cabr247³ Autor ³Altamiro                 ³ Data ³ 16.11.17 ³±±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±±
±±³Descricao ³ custo caberj / integral nova visao / grupamento            ³±±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±±
±±³Sintaxe   ³ cabr247                                                    ³±±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±±
±±³ Uso      ³ Advanced Protheus                                          ³±±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±±
±±³ Alteracoes desde sua construcao inicial                               ³±±±
±±ÃÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±±
±±³ Data     ³ BOPS ³ Programador ³ Breve Descricao                       ³±±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define nome da funcao                                                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
USER Function Cabr247()
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Define variaveis padroes para todos os relatorios...                     ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	PRIVATE nQtdLin     := 60
	PRIVATE nLimite     := 220
	PRIVATE cTamanho    := "G"
	PRIVATE cTitulo     := "Relatório de Despesas de Convênios Reciprocidade"
	PRIVATE cDesc1      := "Este Relatorio tem como objetivo emitir resumo demonstrando a composicao de " //"Este Relatorio tem como objetivo emitir resumo demonstrando a composicao de"
	PRIVATE cDesc2      := "um lote de cobranca."  //"um lote de cobranca."
	PRIVATE cDesc3      := ""
	PRIVATE cAlias      := "BDC"
	PRIVATE cPerg       := "CABR247" 
	PRIVATE cRel        := "CABR242"
	PRIVATE nli         := 80
	PRIVATE m_pag       := 1    
	PRIVATE lCompres    := .F. 
	PRIVATE lDicion     := .F. 
	PRIVATE lFiltro     := .F. 
	PRIVATE lCrystal    := .F. 
	PRIVATE aOrderns    := {}
	PRIVATE aReturn     := { "", 1,"", 1, 1, 1, "",1 } 
	PRIVATE lAbortPrint := .F.
	PRIVATE cCabec1     := "Lote      Geraçào  Referência                                         Total de servicos                        Taxas           Total"
	//PRIVATE cCabec2     := STR0008  //"OPERADORA ORIGEM                          PRFX TITULO  PARC. TIPO QTD EVE. "
	PRIVATE cCabec2		:= ""          
	private cAliasCT    := GetNextAlias() 
	private cTitSe1   := '' 

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Testa ambiente do relatorio somente top...                               ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If ! PLSRelTop()
		Return
	Endif    

	BE4->(DbSetOrder(1))
	BD5->(DbSetOrder(1))

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Variaveis utilizadas para parametros                         				³
	//³ mv_par01 // Operadora Inicial                          						³
	//³ mv_par02 // Operado Final                                    				³
	//³ mv_par03 // Numero Cobranca incial                    						³
	//³ mv_par04 // Numero Cobranca Final                            				³
	//³ mv_par05 // Operadora inicial                                				³
	//³ mv_par06 // Operadora final                                  				³
	//³ mv_par07 // Tipo de relatorio  ? analitico/resumido/sintetico				³
	//³ mv_par08 // Demonstra criticas ?                             				³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ



	ValidPerg(cPerg) 

	If Pergunte(cPerg,.T.) = .F.
		Return
	Endif

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Chama SetPrint (padrao)                                                  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	cRel := SetPrint(cAlias,cRel,cPerg,@cTitulo,cDesc1,cDesc2,cDesc3,lDicion,aOrderns,lCompres,cTamanho,{},lFiltro,lCrystal)
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifica se foi cancelada a operacao (padrao)                            ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If nLastKey  == 27 
		Return
	Endif


	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Configura impressora (padrao)                                            ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	SetDefault(aReturn,cAlias) 

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Emite relat¢rio                                                          ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	MsAguarde({|| Selecao() }, cTitulo, "", .T.)

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Libera threads                                                           ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	Ms_Flush()

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Fim da rotina                                                            ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	Return ()
	/*/
	ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
	±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
	±±ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
	±±³Programa   ³ r591Imp  ³ Autor ³Geraldo Felix Junior...³ Data ³ 28.04.04 ³±±
	±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
	±±³Descricao  ³ Imprime detalhe do relatorio...                            ³±±
	±±ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
	±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
	/*/
	Static Function Selecao()
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Define variaveis...                                                      ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	LOCAL cSQL 
	LOCAL _VLRTADTOT := 0
	LOCAL _VLRBPFTOT := 0
	LOCAL _VLRINSTOT := 0 

	cSQL := " SELECT  refer, "      
	cSQL += "         CODEMP, "     
	cSQL += "         GRUPO_PLANO, "      
	cSQL += "         NOME_PLANO,  "   
	cSQL += "         substr(DTEVENT,4,5) ,      "
	cSQL += "         CodEvento,     " 
	cSQL += "         Nome_Evento,   "  
	cSQL += "         ZZT_TPCUST,    "   
	cSQL += "         codrda ,  nomrda , GRPPAG ,  DESCGRP , tippre ,   "   
	cSQL += "         TIPO ,         "
	cSQL += "         SUM(VL_APROV+GLOSADO) APRESENTADO , "      
	cSQL += "         SUM(GLOSADO) GLOSADO ,              "
	cSQL += "         SUM(VL_APROV) PAGO ,                "
	cSQL += "         SUM(Vl_Participacao) COPART         "
	cSQL += "    FROM(                                    "
	cSQL += "     SELECT   /*+first_rows index_asc(BD7 BD70205)*/  "    
	cSQL += "              BD7_CODPLA PLANO,      "
	cSQL += "              BD6_YNEVEN CodEvento,  "    
	cSQL += "              ZZT_EVENTO Nome_Evento,"      
	cSQL += "              QTDE,                  "
	cSQL += "              Sum(BD6F.BD6_QTDPRO) Ocorrencia, "     
	cSQL += "              Sum(BD6F.BD6_VLRGLO) Glosado,    " 
	cSQL += "              Sum(BD7F.VLRPAG)  Vl_Aprov,      "
	cSQL += "              sum(Decode(BD6F.BD6_BLOCPA,'1',0,Decode(Sign(BD6F.BD6_VLRTPF),-1,0,Decode(BD6_CODEMP,'0004',0,'0009',0,BD6F.BD6_VLRTPF)))) Vl_Participacao, "     
	cSQL += "              EXPOS EXPOSICAO_ANS , "      
	cSQL += "              RETORNA_DESC_GRUPO_PLANO ( TRIM(BI3_YGRPLA),'I') GRUPO_PLANO , "     
	cSQL += "              Decode(BD6_CODEMP,'0007',Trim(BI3_NREDUZ)||' (SEPE)',BI3_NREDUZ) NOME_PLANO , "     
	cSQL += "              ZZT_TPCUST , "     
	cSQL += "              BD6_YPROJ PROJ, "      
	cSQL += "              decode(BD6_CODLDP,'0010','Recup Glosa','0017','Rateio','Conta') TIPO, "         
	cSQL += "              BD6_CODEMP CODEMP, "     
	cSQL += "              RETORNA_DESCRI_GRUPOEMP('I',BD6_CODEMP) NOME_EMP, "      
	cSQL += "              TO_DATE(BD6_DATPRO,'YYYYMMDD')  DTEVENT ,         "
	cSQL += "              bd7f.refer refer , bd7f.codrda codrda , bd7f.nomrda nomrda , "    
	cSQL += "              bd7f.GRPPAG GRPPAG , bd7f.DESCGRP DESCGRP , bd7f.tippre tippre " 
	cSQL += "       FROM  "    
	cSQL += "       (SELECT BD7.BD7_FILIAL,BD7_CODPLA,SIGA_TIPO_EXPOSICAO_ANS(BD7_CODEMP,BD7_MATRIC,BD7_TIPREG,To_Date(Trim(BD7_DATPRO),'YYYYMMDD')) EXPOS, "     
	cSQL += "               BD7.BD7_OPELOT, "     
	cSQL += "               BD7.BD7_CODOPE, BD7.BD7_CODLDP, BD7.BD7_CODPEG, BD7.BD7_NUMERO, BD7.BD7_ORIMOV, BD7_CODPRO, "     
	cSQL += "               BD7.BD7_SEQUEN,  Sum(BD7.BD7_VLRPAG) AS VLRPAG, "     
	cSQL += "               COUNT(DISTINCT BD7_CODEMP||BD7_MATRIC||BD7_TIPREG) QTDE , "      
	cSQL += "               substr(BD7.BD7_NUMLOT,1,6) refer , "      
	cSQL += "               bd7.bd7_codrda CODRDA , bd7.bd7_nomrda NOMRDA , "     
	cSQL += "               BAU_GRPPAG GRPPAG , B16_DESCRI  DESCGRP , bau_tippre tippre "   
	cSQL += "       FROM BD7020 BD7 , BAU020 BAU , B16020 B16 "    
	cSQL += "       WHERE BD7.BD7_FILIAL=' ' " 
	cSQL += "       AND BD7_OPELOT = '0001'  "                                             

	cSQL += "       AND BD7.BD7_NUMLOT >= '2017100001' AND BD7.BD7_NUMLOT <= '2017109999' "     

	cSQL += "       AND BD7_SITUAC = 1 "    
	cSQL += "       AND BD7_OPEUSR >='0001' "    
	cSQL += "       AND BD7_CODEMP >= '0001' "    
	cSQL += "       AND BD7_MATRIC >= '000001' "     
	cSQL += "       AND BD7_TIPREG >= '00' "    
	cSQL += "       AND BAU_FILIAL =' ' AND BAU.D_e_l_e_t_ = ' ' and bau.R_E_C_D_E_L_ = 0 "     
	cSQL += "       AND B16_FILIAL =' ' AND B16.D_E_L_E_T_ = ' ' "      
	cSQL += "       AND BD7.BD7_CODOPE = '0001' "     
	cSQL += "       AND BD7.BD7_FASE = '4' "     
	cSQL += "       AND BD7.BD7_BLOPAG <> '1' "     
	cSQL += "       AND BAU_CODIGO = BD7.BD7_CODRDA "     
	cSQL += "       AND bau_grppag = B16_CODIGO     " 
	cSQL += "       AND BD7.D_E_L_E_T_ = ' '        "
	cSQL += "       GROUP BY BD7_FILIAL, BD7_CODPLA, BD7.BD7_OPELOT,BD7_CODPRO, "     
	cSQL += "                SIGA_TIPO_EXPOSICAO_ANS(BD7_CODEMP,BD7_MATRIC,BD7_TIPREG,To_Date(Trim(BD7_DATPRO),'YYYYMMDD')), "     
	cSQL += "                BD7_FILIAL, BD7_CODOPE, BD7_CODLDP, BD7_CODPEG, BD7_NUMERO, BD7_ORIMOV, BD7_SEQUEN , "    
	cSQL += "                bd7.bd7_codrda, bd7.bd7_nomrda ,BAU_GRPPAG, B16_DESCRI, bau_tippre , "      
	cSQL += "                substr(BD7.BD7_NUMLOT,1,6)) BD7F , "     
	cSQL += "       BD6020 BD6F  ,BI3020 BI3 ,ZZT020 ZZT        "
	cSQL += "     WHERE ZZT_FILIAL=' ' "     
	cSQL += "       and BI3_FILIAL=' ' "     
	cSQL += "       AND BD6F.BD6_FILIAL=' ' "     
	cSQL += "       AND BD7F.BD7_FILIAL = BD6F.BD6_FILIAL "     
	cSQL += "       AND BD7F.BD7_CODOPE = BD6F.BD6_CODOPE "     
	cSQL += "       AND BD7F.BD7_CODLDP = BD6F.BD6_CODLDP "     
	cSQL += "       AND BD7F.BD7_CODPEG = BD6F.BD6_CODPEG "     
	cSQL += "       AND BD7F.BD7_NUMERO = BD6F.BD6_NUMERO "     
	cSQL += "       AND BD7F.BD7_ORIMOV = BD6F.BD6_ORIMOV "     
	cSQL += "       and BD7F.BD7_SEQUEN = BD6F.BD6_SEQUEN "     
	cSQL += "       AND BD6F.BD6_CODPRO = BD7F.BD7_CODPRO "     
	cSQL += "       AND BI3_FILIAL = BD7_FILIAL "     
	cSQL += "       AND BI3_CODINT=BD7_CODOPE   "   
	cSQL += "       AND BI3_CODIGO=BD7_CODPLA   "  
	cSQL += "       AND BD6_YNEVEN=ZZT_CODEV    "  
	cSQL += "       AND BD6F.D_E_L_E_T_ = ' '   "   
	cSQL += "       AND BI3.D_E_L_E_T_ = ' '    "  
	cSQL += "       AND ZZT.D_E_L_E_T_ = ' '    "  
	cSQL += "     GROUP BY EXPOS,BD6_CODEMP,    "  
	cSQL += "              decode(BD6_CODLDP,'0010','Recup Glosa','0017','Rateio','Conta'), "     
	cSQL += "              BD7_CODPLA , "     
	cSQL += "              TRIM(BI3_YGRPLA),Decode(BD6_CODEMP,'0007',Trim(BI3_NREDUZ)||' (SEPE)',BI3_NREDUZ), "     
	cSQL += "              BD6_YNEVEN , "     
	cSQL += "              ZZT_EVENTO,QTDE ,ZZT_TPCUST , "     
	cSQL += "              BD6_YPROJ , "     
	cSQL += "              BD6_CODEMP , "     
	cSQL += "              RETORNA_DESCRI_GRUPOEMP('I',BD6_CODEMP),"     
	cSQL += "              TO_DATE(BD6_DATPRO,'YYYYMMDD') , "      
	cSQL += "              bd7f.refer ,bd7f.codrda , bd7f.nomrda , "    
	cSQL += "              bd7f.GRPPAG , bd7f.DESCGRP , bd7f.tippre "    
	cSQL += "   UNION ALL "     
	cSQL += "   SELECT  NVL( RETORNA_PLANO_USU_MS ('I',BGQ_CODOPE,BGQ_CODEMP,BGQ_MATRIC,'00','N'),BBB_YCODPL) PLANO , "     
	cSQL += "              BGQ_YNEVEN CodEvento , "     
	cSQL += "              ZZT_EVENTO Nome_Evento , "     
	cSQL += "              Count(DISTINCT BGQ_CODSEQ)QTDE , "     
	cSQL += "              Count(BGQ_CODSEQ) Ocorrencia , "    
	cSQL += "              0 Glosado , "     
	cSQL += "              Sum(Decode(BBB_TIPSER,1,-1*BGQ_VALOR,BGQ_VALOR)) Vl_Aprov , "     
	cSQL += "              0 Vl_Participacao , "     
	cSQL += "              decode(nvl(trim(BGQ_CODEMP),RETORNA_GRUPO_EMP(BI3_CODIGO)),'0004',2,'0009',2,0) EXPOSICAO_ANS , "      
	cSQL += "              RETORNA_DESC_GRUPO_PLANO ( TRIM(BI3_YGRPLA),'I') GRUPO_PLANO , "      
	cSQL += "              BI3_NREDUZ NOME_PLANO , "     
	cSQL += "              ZZT_TPCUST , "     
	cSQL += "              BGQ_YPROJ PROJ , "     
	cSQL += "              'Lancamentos Deb/Cred' Tipo , "     
	cSQL += "              BGQ_CODEMP CODEMP , "     
	cSQL += "              RETORNA_DESCRI_GRUPOEMP('I',BGQ_CODEMP) , "    
	cSQL += "              TO_DATE(BGQ_ANO||BGQ_MES||'01','YYYYMMDD') DTEVENT , "       
	cSQL += "              substr(BGQ_NUMLOT,1,6) refer  , "    
	cSQL += "              bgq_codigo CODRDA , bgq_nome NOMRDA , "     
	cSQL += "              BAU_GRPPAG GRPPAG , B16_DESCRI  DESCGRP , bau_tippre tippre  "   
	cSQL += "         FROM BGQ020, BBB020, BI3020 BI3  ,ZZT020 ZZT  , BAU020 BAU , B16020 B16  "   
	cSQL += "        WHERE BGQ_FILIAL = ' ' "     
	cSQL += "          AND BGQ_CODLAN <> '050' "     
	cSQL += "          AND BBB_FILIAL = ' ' "     
	cSQL += "          AND BBB_CODSER = BGQ_CODLAN "     
	cSQL += "          AND ZZT_FILIAL = '  ' "     
	cSQL += "          AND BGQ_YNEVEN=ZZT_CODEV "     
	cSQL += "          AND BI3_FILIAL = '  ' "     
	cSQL += "          AND BI3_CODIGO=NVL( RETORNA_PLANO_USU_MS ('I',BGQ_CODOPE,BGQ_CODEMP,BGQ_MATRIC,'00','N'),BBB_YCODPL) "     

	cSQL += "          AND BGQ_NUMLOT >= '2017100001' AND BGQ_NUMLOT <= '2017109999'      

	cSQL += "          AND BAU_FILIAL =' ' AND BAU.D_e_l_e_t_ = ' ' and bau.R_E_C_D_E_L_ = 0 "     
	cSQL += "          AND B16_FILIAL =' ' AND B16.D_E_L_E_T_ = ' ' "     
	cSQL += "          AND BAU_CODIGO = bgq_codigo  "   
	cSQL += "          AND bau_grppag = B16_CODIGO  "    
	cSQL += "          AND BI3.D_E_L_E_T_ = ' '     " 
	cSQL += "          AND ZZT.D_E_L_E_T_ = ' '     " 
	cSQL += "          AND BGQ020.D_E_L_E_T_ = ' '  "    
	cSQL += "          AND BBB020.D_E_L_E_T_ = ' '  "    
	cSQL += "     GROUP BY NVL( RETORNA_PLANO_USU_MS ('I',BGQ_CODOPE,BGQ_CODEMP,BGQ_MATRIC,'00','N'),BBB_YCODPL) , "      
	cSQL += "              BGQ_YNEVEN ,  ZZT_EVENTO, ZZT_TPCUST , "     
	cSQL += "              decode(nvl(trim(BGQ_CODEMP),RETORNA_GRUPO_EMP(BI3_CODIGO)),'0004',2,'0009',2,0) , "     
	cSQL += "              RETORNA_DESC_GRUPO_PLANO ( TRIM(BI3_YGRPLA),'I'),BI3_NREDUZ , "      
	cSQL += "              BGQ_YPROJ ,BGQ_CODEMP , RETORNA_DESCRI_GRUPOEMP('I',BGQ_CODEMP) , "      
	cSQL += "              TO_DATE(BGQ_ANO||BGQ_MES||'01','YYYYMMDD') , "       
	cSQL += "              substr(BGQ_NUMLOT,1,6) , "    
	cSQL += "              bgq_codigo , bgq_nome , "     
	cSQL += "              BAU_GRPPAG , B16_DESCRI , bau_tippre "     
	cSQL += " UNION ALL "     
	cSQL += "       SELECT PLANO , "     
	cSQL += "              CODEVENTO , "     
	cSQL += "              NOME_EVENTO , "     
	cSQL += "              SUM(QTDE) , "     
	cSQL += "              SUM(OCORRENCIA) , "     
	cSQL += "              SUM(GLOSADO) , "     
	cSQL += "              SUM(VL_APROV) VL_APROV , "     
	cSQL += "              SUM(VL_PARTICIPACAO) VL_PARTICIPACAO , "     
	cSQL += "              EXPOSICAO_ANS , "    
	cSQL += "              GRUPO_PLANO , "     
	cSQL += "              NOME_PLANO , "     
	cSQL += "              ZZT_TPCUST , "     
	cSQL += "              PROJ , "      
	cSQL += "              'Material' Tipo , "          
	cSQL += "              CODEMP , "     
	cSQL += "              RETORNA_DESCRI_GRUPOEMP ('I',CODEMP) NOME_EMP , "       
	cSQL += "              DTEVENT , "      
	cSQL += "              refer   , "         
	cSQL += "              '000000' CODRDA , 'Material' NOMRDA , "     
	cSQL += "              '0000' GRPPAG , 'Material'  DESCGRP , " 
	cSQL += "              'Material' tippre "    
	cSQL += " FROM( "     
	cSQL += "       SELECT BD6_CODPLA PLANO , "     
	cSQL += "              BD6_YNEVEN CodEvento , "      
	cSQL += "              ZZT_EVENTO Nome_Evento , "      
	cSQL += "              COUNT(DISTINCT BD6_CODEMP||BD6_MATRIC||BD6_TIPREG) QTDE , "     
	cSQL += "              Sum(D1_QUANT) Ocorrencia , "     
	cSQL += "              Sum(BD6_VLRGLO) Glosado , "     
	cSQL += "              Sum(D1_TOTAL)-Sum(D1_VALDESC)  Vl_Aprov , "     
	cSQL += "              RETORNA_VL_COPART_OPME (BD6_CODOPE,BD6_CODLDP,BD6_CODPEG,BD6_NUMERO,'I') Vl_Participacao , "     
	cSQL += "              SIGA_TIPO_EXPOSICAO_ANS(BD6_CODEMP,BD6_MATRIC,BD6_TIPREG,To_Date(Trim(BD6_DATPRO),'YYYYMMDD')) EXPOSICAO_ANS , "     
	cSQL += "              RETORNA_DESC_GRUPO_PLANO ( TRIM(BI3_YGRPLA),'I') GRUPO_PLANO , "     
	cSQL += "              Decode(BD6_CODEMP,'0007',Trim(BI3_NREDUZ)||' (SEPE)',BI3_NREDUZ) NOME_PLANO , "     
	cSQL += "              0 Val_adiant , B19_DOC , "     
	cSQL += "              ZZT_TPCUST , "     
	cSQL += "              BD6_YPROJ PROJ , "     
	cSQL += "              BD6_CODEMP CODEMP , "       
	cSQL += "              TO_DATE(BD6_DATPRO,'YYYYMMDD') DTEVENT , "     
	cSQL += "              substr(F1_EMISSAO,1,6) refer "       
	cSQL += "    from SIGA.B19020 B19, SIGA.SD1020 SD1, SIGA.SF1020 SF1, SIGA.BD6020 BD6 , "     
	cSQL += "         SIGA.SA2020 SA2, ZZT020 ZZT  ,BI3020 BI3 "     
	cSQL += "   WHERE BI3_FILIAL = ' ' "     
	cSQL += "     AND  A2_FILIAL = ' ' "     

	cSQL += "     AND F1_EMISSAO >= '20171001'  AND F1_EMISSAO <= '20171031' "       

	cSQL += "     AND A2_COD = B19_FORNEC "   
	cSQL += "     AND D1_FORNECE = A2_COD  "    
	cSQL += "     AND f1_FORNECE = A2_COD  "    
	cSQL += "     AND D1_DOC     = F1_DOC  " 
	cSQL += "     AND B19_DOC    = D1_DOC  "  
	cSQL += "     AND D1_ITEM    = B19_ITEM "    
	cSQL += "     and BD6_FILIAL = ' ' "     
	cSQL += "     AND ZZT_FILIAL=' '   "   
	cSQL += "     AND BD6_CODPLA = BI3_CODIGO "     
	cSQL += "     AND BD6_CODOPE = SubStr(B19_GUIA,01,04) "      
	cSQL += "     AND BD6_CODLDP = SubStr(B19_GUIA,05,04) "     
	cSQL += "     AND BD6_CODPEG = SubStr(B19_GUIA,09,08) "     
	cSQL += "     AND BD6_NUMERO = SubStr(B19_GUIA,17,08) "     
	cSQL += "     AND BD6_ORIMOV = SubStr(B19_GUIA,25,01) "     
	cSQL += "     AND BD6_SEQUEN = SubStr(B19_GUIA,26,03) "     
	cSQL += "     AND BD6_FASE IN (3,4) "     
	cSQL += "     AND BD6_CODLDP ='0013' "     
	cSQL += "     AND BD6_SITUAC = 1 "    
	cSQL += "     AND BD6_YNEVEN = ZZT_CODEV "     
	cSQL += "     AND SA2.D_E_L_E_T_ = ' '   "   
	cSQL += "     AND B19.D_E_L_E_T_ = ' '   "   
	cSQL += "     AND SD1.D_E_L_E_T_ = ' '   "   
	cSQL += "     AND SF1.D_E_L_E_T_ = ' '   "   
	cSQL += "     AND BD6.D_E_L_E_T_ = ' '   "   
	cSQL += "     AND ZZT.D_E_L_E_T_ = ' '   "   
	cSQL += "     AND BI3.D_E_L_E_T_ = ' '   "  
	cSQL += "     GROUP BY SIGA_TIPO_EXPOSICAO_ANS(BD6_CODEMP,BD6_MATRIC,BD6_TIPREG,To_Date(Trim(BD6_DATPRO),'YYYYMMDD')) , "     
	cSQL += "              BD6_CODEMP , "     
	cSQL += "              BD6_CODPLA , "     
	cSQL += "              TRIM(BI3_YGRPLA),Decode(BD6_CODEMP,'0007',Trim(BI3_NREDUZ)||' (SEPE)',BI3_NREDUZ) , "     
	cSQL += "              BD6_YNEVEN, B19_DOC , "     
	cSQL += "              ZZT_EVENTO,ZZT_TPCUST , "     
	cSQL += "              BD6_YPROJ , "     
	cSQL += "              RETORNA_VL_COPART_OPME (BD6_CODOPE,BD6_CODLDP,BD6_CODPEG,BD6_NUMERO,'I') , "     
	cSQL += "              BD6_CODEMP , "      
	cSQL += "              TO_DATE(BD6_DATPRO,'YYYYMMDD') , "      
	cSQL += "              substr(F1_EMISSAO,1,6) ) "     
	cSQL += "   GROUP BY  PLANO,  NOME_EVENTO ,     " 
	cSQL += "             CODEVENTO , "     
	cSQL += "             GRUPO_PLANO,"      
	cSQL += "             NOME_PLANO, "     
	cSQL += "             EXPOSICAO_ANS,ZZT_TPCUST,PROJ,"      
	cSQL += "             CODEMP,"     
	cSQL += "             RETORNA_DESCRI_GRUPOEMP ('I',CODEMP), "      
	cSQL += "             DTEVENT , "       
	cSQL += "             refer  "    
	cSQL += " UNION ALL "     
	cSQL += "      SELECT  Nvl(Trim(BA1_CODPLA),BA3_CODPLA) Plano, "     
	cSQL += "              BD6_YNEVEN CodEvento, "      
	cSQL += "              ZZT_EVENTO Nome_Evento, "     
	cSQL += "              COUNT(DISTINCT B44_OPEUSR||B44_CODEMP||B44_MATRIC||B44_TIPREG) Qtde, "     
	cSQL += "              Sum(B45_QTDPRO) Ocorrencia, "     
	cSQL += "              Sum(B45_VLRGLO) Glosado,    "  
	cSQL += "              Sum(B45_VLRPAG) Val_Aprov,  "    
	cSQL += "              0 Vl_Participacao,          "
	cSQL += "              SIGA_TIPO_EXPOSICAO_ANS(B44_CODEMP,B44_MATRIC,B44_TIPREG,To_Date(Trim(B44_DATPRO),'YYYYMMDD')) EXPOSICAO_ANS, "     
	cSQL += "              RETORNA_DESC_GRUPO_PLANO ( TRIM(BI3_YGRPLA),'I') GRUPO_PLANO, "     
	cSQL += "              Decode(B44_CODEMP,'0007',Trim(BI3_NREDUZ)||' (SEPE)',BI3_NREDUZ) NOME_PLANO, "     
	cSQL += "              ZZT_TPCUST , "     
	cSQL += "              BD6_YPROJ PROJ, "     
	cSQL += "              'Reembolso' Tipo, "          
	cSQL += "              B44_CODEMP CODEMP, "     
	cSQL += "              RETORNA_DESCRI_GRUPOEMP('I',B44_CODEMP) NOME_EMP , "     
	cSQL += "              TO_DATE(BD6_DATPRO,'YYYYMMDD') DTEVENT , "   
	cSQL += "              substr(E1_EMISSAO,1,6) refer , "    
	cSQL += "              '000000' CODRDA , 'Reembolso' NOMRDA , "     
	cSQL += "              '0000' GRPPAG , 'Reembolso'  DESCGRP , "
	cSQL += "              'Rembolso' tippre "   
	cSQL += "         from B44020 C,B45020 D ,SE1020 T ,BA1020 U,BA3020 F ,BI3020 BI3 ,BG9020 BG9 , "     
	cSQL += "              ZZT020 ZZT, BD6020 BD6 , ZZQ020 ZZQ "     
	cSQL += "        WHERE B45_FILIAL =' '  "    
	cSQL += "          AND B44_FILIAL =' '  "    
	cSQL += "          AND BI3_FILIAL =' '  "    
	cSQL += "          AND BA3_FILIAL =' '  "    
	cSQL += "          AND BA1_FILIAL =' '  "    
	cSQL += "          AND BG9_FILIAL =' '  "    
	cSQL += "          AND ZZT_FILIAL =' '  "    
	cSQL += "          and BD6_FILIAL =' '  "    
	cSQL += "          AND ZZQ_FILIAL =' '  "    
	cSQL += "          AND E1_FILIAL  ='01' "     
	cSQL += "          AND E1_PREFIXO ='RLE' "     
	cSQL += "          AND B44_CODLDP =B45_CODLDP "     
	cSQL += "          AND B44_CODPEG =B45_CODPEG "     
	cSQL += "          AND B44_NUMAUT =B45_NUMAUT "     
	cSQL += "          AND B44_PREFIX =E1_PREFIXO "     
	cSQL += "          AND B44_NUM=E1_NUM         "
	cSQL += "          AND BA1_CODINT=BA3_CODINT  "    
	cSQL += "          AND BA1_CODEMP=BA3_CODEMP  "    
	cSQL += "          AND BA1_MATRIC=BA3_MATRIC  "    
	cSQL += "          AND BA1_CODINT=B44_OPEUSR  "    
	cSQL += "          AND BA1_CODEMP=B44_CODEMP  "   
	cSQL += "          AND BA1_MATRIC=B44_MATRIC  "    
	cSQL += "          AND BA1_TIPREG=B44_TIPREG  "    
	cSQL += "          AND BI3_CODINT=BA1_CODINT  "   
	cSQL += "          AND B44_OPEUSR=BG9_CODINT  "    
	cSQL += "          AND B44_CODEMP=BG9_CODIGO  "   
	cSQL += "          AND BI3_CODIGO=Nvl(Trim(BA1_CODPLA),BA3_CODPLA) "         

	cSQL += "          AND E1_EMISSAO >= '20171001'  AND E1_EMISSAO <= '20171031'  "      

	cSQL += "          AND BD6_CODOPE='0001' "     
	cSQL += "          AND B45_CODLDP=BD6_CODLDP  "    
	cSQL += "          AND B45_CODPEG=BD6_CODPEG  "    
	cSQL += "          AND B45_NUMERO=BD6_NUMERO  "    
	cSQL += "          AND B45_SEQUEN=BD6_SEQUEN  "    
	cSQL += "          AND B45_CODPAD=BD6_CODPAD  "    
	cSQL += "          AND B45_CODPRO=BD6_CODPRO  "    
	cSQL += "          and BD6_YNEVEN=ZZT_CODEV   "   
	cSQL += "          AND ZZQ_SEQUEN = B44_YCDPTC "      
	cSQL += "          AND C.D_E_L_E_T_=' '        "
	cSQL += "          AND D.D_E_L_E_T_=' '        "
	cSQL += "          AND T.D_E_L_E_T_=' '     " 
	cSQL += "          AND U.D_E_L_E_T_=' '     " 
	cSQL += "          AND F.D_E_L_E_T_=' '     " 
	cSQL += "          AND BI3.D_E_L_E_T_ = ' ' "     
	cSQL += "          AND BG9.D_E_L_E_T_=' '   "   
	cSQL += "          AND ZZT.D_E_L_E_T_=' '   "   
	cSQL += "          AND ZZQ.D_E_L_E_T_=' '   "   
	cSQL += "          AND BD6.D_E_L_E_T_=' '   "   
	cSQL += "     GROUP BY                      "
	cSQL += "              Nvl(Trim(BA1_CODPLA),BA3_CODPLA) ,  "    
	cSQL += "              RETORNA_DESC_GRUPO_PLANO ( TRIM(BI3_YGRPLA),'I') , "     
	cSQL += "              Decode(B44_CODEMP,'0007',Trim(BI3_NREDUZ)||' (SEPE)',BI3_NREDUZ) , "      
	cSQL += "              SIGA_TIPO_EXPOSICAO_ANS(B44_CODEMP,B44_MATRIC,B44_TIPREG,To_Date(Trim(B44_DATPRO),'YYYYMMDD')),B44_ANOAUT,B44_MESAUT, "     
	cSQL += "              ZZT_EVENTO,ZZT_TPCUST ,      
	cSQL += "              BD6_YNEVEN , "     
	cSQL += "              BD6_YPROJ,   "   
	cSQL += "              (CASE WHEN (B45_ZZZCOD NOT IN('04','11','21','29','37','45','53','75','83','91','99','9H','9O','9S','9V','00','9Z','AA','AI', "      
	cSQL += "                                 'AQ','AY','B6','BE','BM','BU','C4','C8','CB','CG','CN','CU','D1','DD','DW','E5','ED','EZ','F0') "     
	cSQL += "               AND ZZQ_TIPPRO<>'1') "     
	cSQL += "               then '2'  else '1' end), "     
	cSQL += "              B44_CODEMP , "     
	cSQL += "              RETORNA_DESCRI_GRUPOEMP('I',B44_CODEMP), "     
	cSQL += "              TO_DATE(BD6_DATPRO,'YYYYMMDD') , "     
	cSQL += "              substr(E1_EMISSAO,1,6) "       
	cSQL += "              )"      
	cSQL += "              Group By "     
	cSQL += "                       refer,"       
	cSQL += "                       CODEMP,"      
	cSQL += "                       GRUPO_PLANO, "      
	cSQL += "                       NOME_PLANO,  "    
	cSQL += "                       substr(DTEVENT,4,5) , " 
	cSQL += "                       CodEvento, "     
	cSQL += "                       Nome_Evento,"      
	cSQL += "                       ZZT_TPCUST ,"     
	cSQL += "                       codrda , nomrda ,"     
	cSQL += "                       GRPPAG , DESCGRP , "  
	cSQL += "                       tippre , TIPO "


	cSQL := " SELECT PCS_OPEORI ,PCS_ANOPAG||PCS_MESPAG ,PCS_PREFIX prefixo , PCS_NUMTIT num , PCS_TIPO tipo ,  " + CRLF
	cSQL += "        COUNT(*) QTDA ,  SUM( PCS_VLRBPF) VLRBPF , SUM( PCS_VLRTAD ) VLRTAD , SUM( PCS_VLRINS ) VLRINS " + CRLF
	cSQL += "   FROM "+RetSqlName('PCS')+ " PCS " + CRLF
	cSQL += "  WHERE PCS_FILIAL ='"+xFilial("PCS")+"' " + CRLF
	cSQL += "    AND D_E_L_E_T_ = ' '  " + CRLF
	cSQL += "    AND PCS_OPEORI = '"+TRB1->BTO_OPEORI+"'  " + CRLF
	cSQL += "    AND PCS_ANOPAG||PCS_MESPAG = '"+cmv_par091+"'  " + CRLF
	cSQL += "    GROUP BY PCS_OPEORI ,PCS_ANOPAG||PCS_MESPAG ,PCS_PREFIX , PCS_NUMTIT , PCS_TIPO  " + CRLF
	cSQL += "    ORDER BY 1,2,4

	If Select((cAliasCT)) <> 0 

		(cAliasCT)->(DbCloseArea()) 

	Endif           

	TcQuery cSQL New Alias (cAliasCT)         

	While !(cAliasCT)->( Eof() ) 

		If mv_par17 == 1
			// 	@ nLi, 000 PSAY TRB1->BTO_OPEORI+"-"
			//	@ nLi, 007 PSAY Left(Posicione("BA0",1,xFilial("BA0")+TRB1->BTO_OPEORI,"BA0_NOMINT"),18)
			@ nLi, 034 PSAY (cAliasCT)->PREFIXO
			@ nLi, 039 PSAY (cAliasCT)->NUM 
			@ nLi, 046 PSAY ' ' 
			@ nLi, 050 PSAY (cAliasCT)->TIPO 
			@ nLi, 053 PSAY StrZero((cAliasCT)->QTDA, 5)

			//@ nLi, 059 PSAY Transform(TRB1->BTO_VLRCOP,"@E 99,999,999.99")          
			@ nLi, 074 PSAY Transform(((cAliasCT)->VLRBPF)*-1,"99,999,999.99")
			/*
			If BTO->( FieldPos("BTO_VLRCP3") ) > 0
			@ nLi, 090 PSAY Transform(TRB1->BTO_VLRCP3,"@E 99,999,999.99")	
			Endif		 
			*/
			@ nLi, 103 PSAY Transform(((cAliasCT)->VLRTAD*-1),"@E 99,999,999.99")	
			@ nLi, 118 PSAY Transform(((cAliasCT)->VLRBPF*-1)+((cAliasCT)->VLRTAD*-1),"99,999,999.99")
			@ nLi, 133 PSAY Transform(((cAliasCT)->VLRINS*-1),"@E 99,999,999.99")	

			nLi++                                                                        
			aadd(arettitcov,{(cAliasCT)->PREFIXO , (cAliasCT)->NUM , (cAliasCT)->TIPO , mv_par03 , mv_par08, mv_par09 , mv_par10, mv_par11 , mv_par12, mv_par13 , mv_par14, mv_par15 , mv_par16})
		EndIf 
		_VLRTAD :=_vlrtad + (cAliasCT)->VLRTAD
		_VLRBPF :=_VLRBPF + (cAliasCT)->VLRBPF
		_VLRINS :=_VLRINS + (cAliasCT)->VLRINS 

		IF Mv_par16 == 1 
			// faz baixa parcial inserir chamada aki
		EndIF    		

		(cAliasCT)->( dbSkip() )       

	EndDo				        

	If mv_par07 == 1 // Analitico
		If lfat
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Busca a movimentacao da operadora por usuarios... somente analitico³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ			        	            	
			cSql := " SELECT BD6_CODOPE, BD6_CODEMP, BD6_MATRIC, BD6_TIPREG, BD6_DIGITO, BD6_DATPRO, " + CRLF
			cSql += " BD6_NOMUSR, BD6_CODRDA, BD6_NOMRDA, BD6_DESPRO, BD6_VLRTPF , BD6_VLRBPF , BD6_VLRTAD, BD6_NUMIMP,  "+ CRLF
			cSql += " BD6_CODOPE, BD6_CODLDP, BD6_CODPEG, BD6_NUMERO, BD6_ORIMOV, BD6_SEQUEN, BD6_CODPRO,  "+ CRLF
			cSql += " BA1_YMTREP, "+ CRLF
			cSql += " BAU_CODIGO, BAU_TIPPE, BAU_NOME , "+ CRLF 

			cSql += "  0.00 VLRTPFPCS , 0.00 VLRBPFPCS ,  0.00  VLRTADPCS , " + CRLF                      

			cSql += " decode(trim(BD6_FASE),'4','4-Fat','1','1-Dig','2','2-Conf','3','3-Prt',  'N-Prt') fase ,"+ CRLF

			cSql += " CASE WHEN trim(bd6.D_e_l_e_t_)      = '*'                  THEN 'Delet. PLS '"+ CRLF 
			cSql += "      WHEN nvl(bd6_CODPEG,' ')       = ' '                  THEN 'Não Exist PLS ' "+ CRLF
			cSql += "      WHEN trim(BD6_FASE) <> '4'                            THEN 'G. Não Paga  ' "+ CRLF
			cSql += "      WHEN NVL(BD6_NUMFAT,'            ') = '            '  THEN 'G. Não Cobrd' "+ CRLF 
			cSql += "      Else 'Ok' END  statuspeg  , "+ CRLF

			cSql += "  0.00 DifB , 0.00 DifT , 0.00 DifTOT , "+ CRLF  

			cSql += "      0 PCSRECNO  "+ CRLF   

			cSql += " FROM "+cBDHName+" BDH,"+cBD6Name+" BD6, "+cBA1Name+" BA1, "+cBAUName+" BAU "+ CRLF 
			cSql += " WHERE BDH_OPEFAT = '"+TRB1->BTO_OPEORI+"' "+ CRLF
			cSql += " AND BDH_NUMFAT = '"+TRB1->BTO_CODOPE+TRB1->BTO_NUMERO+"' "+ CRLF
			cSql += " AND BDH_OPEORI = '"+TRB1->BTO_OPEORI+"' "+ CRLF
			cSql += " AND BDH_CODINT = '"+TRB1->BTO_CODOPE+"' "+ CRLF
			cSql += " AND BA1_FILIAL = '"+xFilial("BA1")+"' "+ CRLF
			cSql += " AND BA1_CODINT = BDH_CODINT " + CRLF
			cSql += " AND BA1_CODEMP = BDH_CODEMP "+ CRLF
			cSql += " AND BA1_MATRIC = BDH_MATRIC "+ CRLF
			cSql += " AND BA1_TIPREG = BDH_TIPREG "+ CRLF
			cSql += " AND BD6_FILIAL = '"+xFilial("BD6")+"' "+ CRLF
			cSql += " AND BD6_OPEUSR = BDH_CODINT "+ CRLF
			cSql += " AND BD6_CODEMP = BDH_CODEMP "+ CRLF
			cSql += " AND BD6_MATRIC = BDH_MATRIC "+ CRLF                       
			cSql += " AND BD6_TIPREG = BDH_TIPREG "+ CRLF
			cSql += " AND BD6_ANOPAG = BDH_ANOFT  "+ CRLF
			cSql += " AND BD6_MESPAG = BDH_MESFT  "+ CRLF
			cSql += " AND BD6_SEQPF  = BDH_SEQPF  "+ CRLF
			cSql += " AND BD6_NUMSE1 = BDH_NUMSE1 "+ CRLF                       

			cSql += " AND NOT EXISTS ( SELECT * FROM siga.PCS010 PCS WHERE PCS_FILIAL = ' ' AND PCS.D_e_l_e_t_ = ' ' AND PCS_RECBD6 = BD6.r_e_c_n_o_ ) " + CRLF

			cSql += " AND BAU_FILIAL = '"+xFilial("BAU")+"' "+ CRLF
			cSql += " AND BAU_CODIGO = BD6_CODRDA "+ CRLF
			cSql += " AND BA1.D_E_L_E_T_ = ' ' "+ CRLF
			cSql += " AND BDH.D_E_L_E_T_ = ' ' "+ CRLF
			cSql += " AND BD6.D_E_L_E_T_ = ' ' "+ CRLF
			cSql += " AND BAU.D_E_L_E_T_ = ' ' "+ CRLF       

			///tratamento para guias reapresentadas					
			/*					
			cSql += "and (trim(nvl(bd6.D_e_l_e_t_,'*')) = '*' AND NOT EXISTS" + CRLF
			cSql += " ( select  NULL" + CRLF
			cSql += "    from siga.pcs010 pcs , bd6010 bd61" + CRLF
			cSql += "   where pcs_filial      =' ' and pcs.D_e_l_E_T_ = ' ' " + CRLF
			cSql += "     and bd61.bd6_filial =' ' " + CRLF //--and bd61.D_E_L_E_T_ = '*' 
			cSql += "     and bd61.R_E_C_N_O_ = pcs_recbd6 " + CRLF
			cSql += "     and trim(bd61.BD6_CODOPE) = trim(BD6.BD6_CODOPE) " + CRLF
			cSql += "     and trim(bd61.BD6_CODEMP) = trim(BD6.BD6_CODEMP) " + CRLF
			cSql += "     and trim(bd61.BD6_MATRIC) = trim(BD6.BD6_MATRIC) " + CRLF
			cSql += "     and trim(bd61.BD6_TIPREG) = trim(BD6.BD6_TIPREG) " + CRLF
			cSql += "     and trim(bd61.BD6_DATPRO) = trim(BD6.BD6_DATPRO) " + CRLF
			cSql += "     and trim(bd61.BD6_CODPRO) = trim(BD6.BD6_CODPRO) " + CRLF
			cSql += "     and trim(BD61.bd6_CODRDA) = trim(BD6.bd6_CODRDA) " + CRLF
			cSql += "     and trim(bd61.BD6_NUMIMP) = trim(BD6.BD6_NUMIMP) " + CRLF
			cSql += "     and trim(bd61.bd6_HORPRO) = trim(BD6.bd6_HORPRO) " + CRLF
			cSql += "   AND PCS_VLRBPF      = BD6.BD6_VLRBPF " + CRLF
			cSql += "   AND PCS_VLRTAD      = BD6.BD6_VLRTAD " + CRLF
			cSql += "   AND PCS_VLRTPF      = BD6.BD6_VLRTPF " + CRLF
			cSql += " ) ) " + CRLF      
			///  					
			*/					       
			If mv_par08 == 1    

				cSql += "union"+ CRLF

				cSql += " SELECT BD6_CODOPE, BD6_CODEMP, BD6_MATRIC, BD6_TIPREG, BD6_DIGITO, BD6_DATPRO," + CRLF 
				cSql += " BD6_NOMUSR, BD6_CODRDA, BD6_NOMRDA, BD6_DESPRO,"+ CRLF 
				cSql += " BD6_VLRTPF, BD6_VLRBPF, BD6_VLRTAD,"+ CRLF 
				cSql += " BD6_NUMIMP, BD6_CODOPE, BD6_CODLDP, BD6_CODPEG, BD6_NUMERO, BD6_ORIMOV," + CRLF
				cSql += " BD6_SEQUEN, BD6_CODPRO,   BA1_YMTREP,  BAU_CODIGO, BAU_TIPPE, BAU_NOME ," + CRLF

				cSql += "  PCS_VLRTPF VLRTPFPCS , PCS_VLRBPF VLRBPFPCS ,  PCS_VLRTAD VLRTADPCS ,  " + CRLF                      

				cSql += " decode(trim(BD6_FASE),'4','4-Fat','1','1-Dig','2','2-Conf','3','3-Prt', 'N-Prt') fase ,"+ CRLF      

				cSql += "  CASE WHEN trim(nvl(bd6.D_e_l_e_t_,'*')) = '*'             THEN 'Delet. PLS'      " + CRLF  
				cSql += "       WHEN nvl(bd6_CODPEG,' ')      = ' '             THEN 'Não Exist PLS'   " + CRLF  
				cSql += "       WHEN trim(nvl(BD6_BLOCPA,'1'))= '1'             THEN 'G. Bloq Cob'     " + CRLF  
				cSql += "       WHEN trim(nvl(BD6_SITUAC,'0'))<> '1'            THEN 'G. Não Ativa'    " + CRLF  
				cSql += "       WHEN SUBSTR(trim(nvl(BD6_fase,'1')),1,1) < '3'  THEN 'G. Fase 1 ou 2'  " + CRLF  
				cSql += "       WHEN trim(nvl(BD6_fase,'1'))  <> '4'            THEN 'G. Não Paga'     " + CRLF  
				cSql += "       WHEN NVL(BD6_NUMFAT,'            ') = '            ' THEN 'G. Não Cobrd'    " + CRLF  
				cSql += "       WHEN PCS_VLRTPF     <>  nvl(BD6_VLRTPF,0.00)     THEN 'Div Vlr Cobrd'   " + CRLF  
				cSql += "       WHEN PCS_VLRBPF     <>  nvl(BD6_VLRBPF,0.00)     THEN 'Div Vlr Pagto'   " + CRLF  
				cSql += "       WHEN PCS_VLRTAD     <>  nvl(BD6_VLRTAD,0.00)     THEN 'Div Vlr Taxa'    " + CRLF  
				cSql += "       Else 'Ok' END  statuspeg  , " + CRLF                      

				cSql += "      (nvl(BD6_VLRBPF,0.00) - PCS_VLRBPF) DifB , "+ CRLF     
				cSql += "      (nvl(BD6_VLRTAD,0.00) - PCS_VLRTAD) DifT , "+ CRLF 
				cSql += "      (nvl(BD6_VLRTPF,0.00) - PCS_VLRTPF) DifTOT ,  "+ CRLF  

				cSql += "      PCS.r_e_c_n_o_ PCSRECNO  "+ CRLF 

				cSql += " FROM  "+RetSqlName('BD6')+" BD6 , "+RetSqlName('BA1')+" BA1 , "+RetSqlName('BAU')+" BAU , "+RetSqlName('PCS')+" PCS " + CRLF 
				cSql += " WHERE BA1_FILIAL = '"+xFilial("BA1")+"' "+ CRLF  
				cSql += " AND BA1_CODINT = BD6_OPEUSR " + CRLF
				cSql += " AND BA1_CODEMP = BD6_CODEMP " + CRLF
				cSql += " AND BA1_MATRIC = BD6_MATRIC " + CRLF
				cSql += " AND BA1_TIPREG = BD6_TIPREG " + CRLF
				cSql += " AND BD6_FILIAL = '"+xFilial("BD6")+"' " + CRLF

				cSql += " AND pcs_filial = '"+xFilial("PCS")+"' " + CRLF
				cSql += " AND PCS_RECBD6 = BD6.r_e_c_n_o_ " + CRLF

				cSQL += " AND PCS_OPEORI = '"+TRB1->BTO_OPEORI+"'  " + CRLF
				cSQL += " AND PCS_ANOPAG||PCS_MESPAG = '"+cmv_par091+"'  " + CRLF

				cSql += " AND BAU_FILIAL = '"+xFilial("BAU")+"' " + CRLF  
				cSql += " AND BAU_CODIGO = BD6_CODRDA "+ CRLF
				cSql += " AND BA1.D_E_L_E_T_ = ' ' " + CRLF  

				cSql += " AND BAU.D_E_L_E_T_ = ' ' " + CRLF
				cSql += " and PCS.D_E_L_E_T_ = ' ' " + CRLF    

				///tratamento para guias reapresentadas
				/*                   
				cSql += "and (trim(nvl(bd6.D_e_l_e_t_,'*')) = '*' AND NOT EXISTS" + CRLF
				cSql += " ( select  NULL" + CRLF
				cSql += "    from siga.pcs010 pcs , bd6010 bd61" + CRLF
				cSql += "   where pcs_filial      =' ' and pcs.D_e_l_E_T_ = ' ' " + CRLF
				cSql += "     and bd61.bd6_filial =' ' " + CRLF //--and bd61.D_E_L_E_T_ = '*' 
				cSql += "     and bd61.R_E_C_N_O_ = pcs_recbd6 " + CRLF
				cSql += "     and trim(bd61.BD6_CODOPE) = trim(BD6.BD6_CODOPE) " + CRLF
				cSql += "     and trim(bd61.BD6_CODEMP) = trim(BD6.BD6_CODEMP) " + CRLF
				cSql += "     and trim(bd61.BD6_MATRIC) = trim(BD6.BD6_MATRIC) " + CRLF
				cSql += "     and trim(bd61.BD6_TIPREG) = trim(BD6.BD6_TIPREG) " + CRLF
				cSql += "     and trim(bd61.BD6_DATPRO) = trim(BD6.BD6_DATPRO) " + CRLF
				cSql += "     and trim(bd61.BD6_CODPRO) = trim(BD6.BD6_CODPRO) " + CRLF
				cSql += "     and trim(BD61.bd6_CODRDA) = trim(BD6.bd6_CODRDA) " + CRLF
				cSql += "     and trim(bd61.BD6_NUMIMP) = trim(BD6.BD6_NUMIMP) " + CRLF
				cSql += "     and trim(bd61.bd6_HORPRO) = trim(BD6.bd6_HORPRO) " + CRLF

				//cSql += "     --  AND PCS_VLRBPF      = BD6.BD6_VLRBPF " + CRLF
				//cSql += "     --  AND PCS_VLRTAD      = BD6.BD6_VLRTAD " + CRLF
				//cSql += "     --  AND PCS_VLRTPF      = BD6.BD6_VLRTPF " + CRLF
				cSql += " ) ) " + CRLF      
				///          
				*/              
				cSql += "  and ( trim(nvl(bd6.D_e_l_e_t_,'*'))  = '*'    " + CRLF  
				cSql += "        or nvl(bd6_CODPEG,' ')         = ' '    " + CRLF 
				cSql += "        or trim(nvl(BD6_SITUAC,'0'))  <> '1'    " + CRLF   

				If mv_par15 == 1 
					cSql += "        or trim(nvl(BD6_BLOCPA,'1'))   = '1'    " + CRLF  
				EndIf    

				If mv_par13 == 1
					cSql += "        or trim(nvl(BD6_fase,'1'))     < '3'    " + CRLF  
				EndIf              

				If mv_par12 == 1   
					cSql += "        or trim(nvl(BD6_fase,'1'))    <> '4'    " + CRLF  
				EndIf 

				If mv_par14 == 1 
					cSql += "        or NVL(BD6_NUMFAT,'            ') = '            ' " + CRLF  
				EndIf 

				If mv_par09 == 1
					cSql += "        or PCS_VLRTPF >  nvl(BD6_VLRTPF,0.00)   " + CRLF   
				ElseIf mv_par09 == 2
					cSql += "        or PCS_VLRTPF <  nvl(BD6_VLRTPF,0.00)   " + CRLF      
				ElseIf mv_par09 == 4
					cSql += "        or PCS_VLRTPF <> nvl(BD6_VLRTPF,0.00)   " + CRLF      
				EndIf           

				If mv_par10 == 1
					cSql += "        or PCS_VLRBPF >  nvl(BD6_VLRBPF,0.00)   " + CRLF   
				ElseIf mv_par10 == 2
					cSql += "        or PCS_VLRBPF <  nvl(BD6_VLRBPF,0.00)   " + CRLF      
				ElseIf mv_par10 == 4
					cSql += "        or PCS_VLRBPF <> nvl(BD6_VLRBPF,0.00)   " + CRLF         
				EndIf 

				If mv_par11 == 1
					cSql += "        or PCS_VLRTAD >  nvl(BD6_VLRTAD,0.00)   " + CRLF  
				ElseIf mv_par11 == 2
					cSql += "        or PCS_VLRTAD <  nvl(BD6_VLRTAD,0.00)   " + CRLF       
				ElseIf mv_par11 == 4
					cSql += "        or PCS_VLRTAD <> nvl(BD6_VLRTAD,0.00)   " + CRLF         
				EndIf                                                                           					

				cSql += " ) " + CRLF 

			EndIf 	

			cSql += " ORDER BY 1,2,3,4,5,6 "+ CRLF  

			PlsQuery(cSql, "TRB2")  

			/*  If Select(("TRB2")) <> 0 

			("TRB2")->(DbCloseArea()) 

			Endif           

			TcQuery Sql New Alias ("TRB2")            		
			*/      		                              
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Imprime a movimentacao...                                          ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ			        	            		
			//Modificada logica para Caberj.

			If cFazFec == 1
				FGrvPlan(cOPEORI ,cmv_par091 )   
			EndIf 

			TRB2->( dbGotop() )
			@ nLi, 000 PSAY Replicate('-',215)
			nLi++

			cMatImpAnt := "" 

			While !TRB2->( Eof() )

				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Tratar campos vazios...                                                  ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

				cDatPro := StoD("")
				cNumImp := ""
				If Empty(TRB2->(BD6_DATPRO))

					If TRB2->BD6_ORIMOV == "1"
						If BD5->(MsSeek(xFilial("BD5")+TRB2->(BD6_CODOPE, BD6_CODLDP, BD6_CODPEG, BD6_NUMERO)))
							cDatPro := BD5->BD5_DATPRO
							cNumImp := BD5->BD5_NUMIMP
						Endif
					Else
						If BE4->(MsSeek(xFilial("BE4")+TRB2->(BD6_CODOPE, BD6_CODLDP, BD6_CODPEG, BD6_NUMERO)))
							cDatPro := BE4->BE4_DATPRO
							cNumImp := BE4->BE4_NUMIMP
						Endif
					Endif
				Else
					cDatPro := DtoC(TRB2->BD6_DATPRO)
					cNumImp := TRB2->BD6_NUMIMP
				Endif

				/*
				10        20        30        40        50        60        70        80        90        100       110       120       130       140       150       160       170       180       190       200       210
				012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
				Associado                                               Mat. Convenio      Data Proc.   Prestador                    Nr.Impresso           Procedimento                        Valor     Taxa Conv.         INSS   "
				xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx-9.999.9999.999999.99-9  xxxxxxxxxxxxxxxxx   99/99/99    999999-xxxxxxxxxxxxxxxxxxxx  99999999999999999999  xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx 999,999.99     999,999.99   999,999.99   "
				*/		

				_nMultINSS := Iif(TRB2->BAU_TIPPE=="F",0.2,0)


				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ 12/2/08: Conforme regra solicitada, nao imprimir o ³
				//³ quando for o mesmo beneficiario nome e matricula...³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ			        	            		
				If TRB2->(BD6_CODOPE+BD6_CODEMP+BD6_MATRIC+BD6_TIPREG+BD6_DIGITO) <> cMatImpAnt

					If !Empty(cMatImpAnt)
						//Imprime totalizador somatorio / batimento de valores...
						@ nLi, 076 PSAY Replicate('-',139)
						nLi++
						@ nLi, 176 PSAY Transform(_nTotUsrValor,"@E 999,999.99")
						@ nLi, 191 PSAY Transform(_nTotUsrTaxa,"@E 999,999.99")
						@ nLi, 204 PSAY Transform(_nTotUsrINSS,"@E 999,999.99") 
						nLi+=2
					Endif

					_nTotUsrValor	:= 0
					_nTotUsrTaxa	:= 0
					_nTotUsrINSS	:= 0

					@ nLi, 000 PSAY Left(TRB2->BD6_NOMUSR,31)+'-'+Transform(TRB2->(BD6_CODOPE+BD6_CODEMP+BD6_MATRIC+BD6_TIPREG+BD6_DIGITO),"@R !.!!!.!!!!.!!!!!!-!!-!")    //__cPictUsr
					@ nLi, 056 PSAY Alltrim(TRB2->BA1_YMTREP)+Space(17-Len(Alltrim(TRB2->BA1_YMTREP)))      
					nLi+=1
				Endif
				@ nLi, 076 PSAY cDatPro
				@ nLi, 088 PSAY TRB2->BD6_CODRDA+'-'+Substr(TRB2->BAU_NOME,1,20)
				@ nLi, 117 PSAY cNumImp
				@ nLi, 139 PSAY TRB2->BD6_CODPRO+Substr(TRB2->BD6_DESPRO,1,20)

				if   (trim(TRB2->statuspeg) == 'Delet. PLS' ) .or.  (trim(TRB2->statuspeg) == 'Não Exist PLS' ) ;
				.or.  (trim(TRB2->statuspeg) == 'G. Não Paga') .or.  (trim(TRB2->statuspeg) == 'G. Não Cobrd'  ) ;
				.or.  (trim(TRB2->statuspeg) == 'G. Bloq Cob') .or.  (trim(TRB2->statuspeg) == 'G. Não Ativa'  ) ; 
				.or.  (trim(TRB2->statuspeg) == 'G. Fase 1 ou 2')

					@ nLi, 010 PSAY TRB2->statuspeg + ' - ' + Transform((TRB2->(VLRBPFPCS)*-1),"@E 999,999.99") + ' - ' + Transform((TRB2->(VLRTADPCS)*-1),"@E 999,999.99")

					@ nLi, 176 PSAY Transform((TRB2->(VLRBPFPCS)*-1 ),"@E 999,999.99")
					@ nLi, 191 PSAY Transform((TRB2->(VLRTADPCS)*-1),"@E 999,999.99")
					@ nLi, 204 PSAY Transform(((TRB2->(VLRBPFPCS)*_nMultINSS)*-1),"@E 999,999.99") //INSS (cfme regra Caberj - Marcela - somente cobra de PF.) 

					_VLRTADT:=  TRB2->(VLRTADPCS)*-1
					_VLRBPFT:= (TRB2->(VLRBPFPCS))*-1
					_VLRINST:= (TRB2->(VLRBPFPCS)*_nMultINSS)*-1    

					_nTotUsrValor	+= TRB2->VLRBPFPCS  *-1
					_nTotUsrTaxa	+= TRB2->VLRTADPCS  *-1
					_nTotUsrINSS	+= (TRB2->VLRBPFPCS *_nMultINSS)*-1

					_nTotValor += TRB2->VLRBPFPCS*-1
					_nTotTaxa  += TRB2->VLRTADPCS*-1
					_nTotINSS  += (TRB2->VLRBPFPCS *_nMultINSS)*-1

				ElseIf (TRB2->DifB <> 0 .OR. TRB2->DifT <> 0 .OR. TRB2->DifTOT <> 0)  


					@ nLi, 010 PSAY TRB2->statuspeg + ' - ' +  Transform((TRB2->DifB),"@E 999,999.99") + ' - ' +  Transform((TRB2->DifT),"@E 999,999.99")    


					@ nLi, 176 PSAY Transform((TRB2->DifB ),"@E 999,999.99")
					@ nLi, 191 PSAY Transform((TRB2->DifT ),"@E 999,999.99")
					@ nLi, 204 PSAY Transform(((TRB2->DifB)*_nMultINSS),"@E 999,999.99")  //INSS (cfme regra Caberj - Marcela - somente cobra de PF.)

					_VLRTADT:=  TRB2->DifT
					_VLRbPFT:=  TRB2->DifB
					_VLRINST:=  TRB2->((BD6_VLRTPF-BD6_VLRTAD)+(TRB2->DifB+TRB2->DifT))*_nMultINSS - TRB2->(BD6_VLRTPF-BD6_VLRTAD)*_nMultINSS 

					_nTotUsrValor	+= TRB2->DifB
					_nTotUsrTaxa	+= TRB2->DifT
					_nTotUsrINSS	+= TRB2->((BD6_VLRTPF-BD6_VLRTAD)+(TRB2->DifB+TRB2->DifT))*_nMultINSS - TRB2->(BD6_VLRTPF-BD6_VLRTAD)*_nMultINSS 

					_nTotValor += TRB2->DifB
					_nTotTaxa  += TRB2->DifT
					_nTotINSS  += TRB2->((BD6_VLRTPF-BD6_VLRTAD)+(TRB2->DifB+TRB2->DifT))*_nMultINSS - TRB2->(BD6_VLRTPF-BD6_VLRTAD)*_nMultINSS 

				Else 

					@ nLi, 176 PSAY Transform(TRB2->(BD6_VLRTPF-BD6_VLRTAD),"@E 999,999.99")
					@ nLi, 191 PSAY Transform(TRB2->(BD6_VLRTAD),"@E 999,999.99")
					@ nLi, 204 PSAY Transform((TRB2->(BD6_VLRTPF-BD6_VLRTAD)*_nMultINSS),"@E 999,999.99") //INSS (cfme regra Caberj - Marcela - somente cobra de PF.)

					_VLRTADT:=  0.00
					_VLRBPFT:=  0.00
					_VLRINST:=  0.00 

					_nTotUsrValor += TRB2->(BD6_VLRTPF-BD6_VLRTAD) + _VLRBPFT
					_nTotUsrTaxa  += TRB2->(BD6_VLRTAD) + _VLRTADT  
					_nTotUsrINSS  += (TRB2->(BD6_VLRTPF-BD6_VLRTAD)*_nMultINSS) + _VLRINST

					_nTotValor += TRB2->(BD6_VLRTPF-BD6_VLRTAD) + _VLRBPFT
					_nTotTaxa  += TRB2->(BD6_VLRTAD) + _VLRTADT
					_nTotINSS  += (TRB2->(BD6_VLRTPF-BD6_VLRTAD)*_nMultINSS) + _VLRINST

				EndIf  
				//@ nLi, 198 PSAY Transform(TRB2->(BD6_VLRTPF-BD6_VLRTAD)*0.2,"@E 999,999.99") //INSS (cfme regra Caberj - Marcela - somente cobra de PF.)
				cMatImpAnt := TRB2->(BD6_CODOPE+BD6_CODEMP+BD6_MATRIC+BD6_TIPREG+BD6_DIGITO)   

				If cFazFec == 1 .and.(trim(TRB2->statuspeg)) != 'Ok'  .AND. TRB2->PCSRECNO != 0     
					FGrvContr( (trim(TRB2->PCSRECNO)) , (trim(TRB2->statuspeg))  )
				EndIf 

				//			fMarcPcs((trim(TRB2->statuspeg)) futura implemnetação 

				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ 12/2/08: Conforme solicitado pelo finenceiro, somar³
				//³ o valor por usuario para totalizacao individual... ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ			        	            							

				_VLRTADTOT += _VLRTADT
				_VLRBPFTOT += _VLRBPFT
				_VLRINSTOT += _VLRINST

				_VLRTADT :=  0.00
				_VLRBPFT :=  0.00
				_VLRINST :=  0.00 

				nLi ++
				TRB2->( dbSkip() )
				lImprimiu := .T.

				VldPag()

			Enddo


			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ 12/2/08: Imprime o ultimo totalizador por usuario. ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ			        	            												
			If !Empty(cMatImpAnt)
				//Imprime totalizador somatorio / batimento de valores...
				@ nLi, 076 PSAY Replicate('-',139)
				nLi+=2
				@ nLi, 176 PSAY Transform(_nTotUsrValor,"@E 999,999.99")
				@ nLi, 191 PSAY Transform(_nTotUsrTaxa,"@E 999,999.99")
				@ nLi, 204 PSAY Transform(_nTotUsrINSS,"@E 999,999.99") 
				nLi++
			Endif

			//Imprime totalizador somatorio / batimento de valores...
			@ nLi, 000 PSAY Replicate('-',215)
			nLi++
			@ nLi, 176 PSAY Transform(_nTotValor,"@E 999,999.99")
			@ nLi, 191 PSAY Transform(_nTotTaxa,"@E 999,999.99")
			@ nLi, 204 PSAY Transform(_nTotINSS,"@E 999,999.99") 
			nLi ++

			If lImprimiu
				nLi++
			Endif
			TRB2->( dbClosearea() )
		Elseif lCri 
			BTG->( dbSetorder(02) )
			If BTG->( dbSeek(xFilial("BTG")+TRB1->(BTF_CODOPE+BTF_NUMERO+BTO_SEQUEN)) )
				cNumCob := TRB1->BTF_NUMERO
				cSequen := TRB1->BTO_SEQUEN

				While !BTG->( Eof() ) .and. BTG->BTG_NUMERO == cNumCob .and. BTG->BTG_SEQUEN == cSequen
					@ nLi, 007 PSAY BTG->BTG_CODCRI+" - "+Posicione("SX5",1,xFilial("SX5")+"BI"+BTG->BTG_CODCRI,"X5_DESCRI")

					BTG->( dbSkip() ) 
					lImprimiu := .T.
					nLi++	      					
				Enddo
				If lImprimiu
					nLi++
				Endif
			Endif
		Endif
	Endif
	lImprimiu := .F.

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Sumariza as variaveis totalizadoras...                             ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ			        	
	nVLRCOP	+= TRB1->BTO_VLRCOP
	nVLRCP2	+= TRB1->BTO_VLRCP2
	If BTO->( FieldPos("BTO_VLRCP3") ) > 0
		nVLRCP3 += TRB1->BTO_VLRCP3
	Endif                       

	nVLRTAX	+= TRB1->BTO_VLRTAX  
	nCUSTOT	+= TRB1->BTO_CUSTOT  
	nQTDEVE += TRB1->BTO_QTDEVE

	//TRB1->(DbSkip())
	//Enddo
	@ nLi, 082 PSAY "Valor "
	@ nLi, 111 PSAY "Taxa " 

	@ nLi, 126 PSAY "Inss "      

	@ nLi, 150 PSAY "Total "
	nLi++
	@ nLi, 067 PSAY Replicate('-', 88); nLi++
	@ nLi, 037 PSAY "TOTAIS ---> "
	//@ nLi, 053 PSAY StrZero(nQTDEVE, 5)

	//@ nLi, 059 PSAY Transform(nVLRCOP,"@E 99,999,999.99")

	//		@ nLi, 074 PSAY Transform(((nVLRCOP+nVLRCP2+nVLRCP3) - _VLRBPF ),"@E 99,999,999.99") 
	@ nLi, 074 PSAY Transform((_nTotValor),"@E 99,999,999.99")
	/*
	If BTO->( FieldPos("BTO_VLRCP3") ) > 0
	@ nLi, 090 PSAY Transform(nVLRCP3,"@E 99,999,999.99")
	Endif
	*/                                                             
	//		@ nLi, 103 PSAY Transform((nVLRTAX -   _VLRTAD),"@E 99,999,999.99")			   
	@ nLi, 103 PSAY Transform((_nTotTaxa),"@E 99,999,999.99")	                        
	//	@ nLi, 118 PSAY Transform((nCUSTOT - ( _VLRBPF + _VLRTAD) ),"@E 99,999,999.99")		
	@ nLi, 118 PSAY Transform(( _nTotINSS ),"@E 99,999,999.99")		

	@ nLi, 142 PSAY Transform((_nTotValor+_nTotTaxa+_nTotINSS),"@E 99,999,999.99")	

	arettit:= {cOPEORI ,cTitse1,_nTotValor,_nTotTaxa,_nTotINSS, mv_par03 , mv_par08, mv_par09 , mv_par10, mv_par11 , mv_par12, mv_par13 , mv_par14, mv_par15 , mv_par16}  


	nLi 	+= 2

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Reseta as variaveis...                                             ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ		
	lFat 	:= .F.
	lCri 	:= .F.
	lNoSel  := .F.

	nQTDEVE	:= 0
	nVLRCOP := 0
	nVLRCP2 := 0
	nVLRTAX := 0
	nCUSTOT := 0

	_VLRTADTOT := 0
	_VLRBPFTOT := 0
	_VLRINSTOT := 0

	//Enddo
	@ nLi, 000 PSAY Replicate('-',155)
	//Enddo 


	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Imprime rodape do relatorio...                                     ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	Roda(0,space(10),cTamanho)
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Fecha arquivo...                                                   ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	TRB1->(DbCloseArea())
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Libera impressao                                                         ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If  aReturn[5] == 1 
		Set Printer To
		Ourspool(cRel)
	Endif

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Fim do Relat¢rio                                                         ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	DbSelectArea("BDC")

Return( arettit )

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±± 
±±³Programa   ³ R590Cabec ³ Autor ³Geraldo Felix Junior. ³ Data ³ 28.04.04 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao  ³ Imprime Cabecalho                                          ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
/*/
Static Function R590Cabec()      
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Imprime cabecalho...                                                     ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	nLi := Cabec(cTitulo,cCabec1,cCabec2,cRel,cTamanho,IIF(aReturn[4]==1,GetMv("MV_COMP"),GetMv("MV_NORM")))
	nLi ++

Return                                                                       
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±± 
±±³Programa   ³ VLDPAG    ³ Autor ³Geraldo Felix Junior. ³ Data ³ 28.04.04 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao  ³ Valida a proxima pagina...                                 ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
/*/
Static Function VldPag()

	If nLi > nQtdLin
		R590Cabec()
	Endif 


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

	PutSx1(cPerg,"01","Compt Custo ?    "   ,"","","mv_ch01","C",06,0,0,"G","","mv_par01","","","","","","","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "9999", "" )                                                                                                                                                             

	Pergunte(cPerg,.F.)

Return(.T.)       



/////////////////////////////////////////////////////////////////  


Static Function FGrvContr( nReg , sts  )
	/*
	dbgoto(nReg)  

	If   ((trim(TRB2->statuspeg) == 'Delet. PLS' ) .or. (trim(TRB2->statuspeg) == 'Não Exist PLS' ) ;
	.or. (trim(TRB2->statuspeg) == 'G. Bloq Cob') .or. (trim(TRB2->statuspeg) == 'G. Não Ativa'  ))   

	If  TRB2->DifTOT > 0  
	If  TRB2->DifB > 0
	If  TRB2->DifT > 0

	If (trim(TRB2->statuspeg) == 'G. Não Paga') .or.  (trim(TRB2->statuspeg) == 'G. Não Cobrd'  ) 

	If  TRB2->DifTOT > 0  
	If  TRB2->DifB > 0
	If  TRB2->DifT > 0

	If (trim(TRB2->statuspeg) == 'G. Fase 1 ou 2')     

	If  TRB2->DifTOT > 0  
	If  TRB2->DifB > 0
	If  TRB2->DifT > 0

	If (trim(TRB2->statuspeg) == 'Div Vlr Cobrd'     
	If (trim(TRB2->statuspeg) == 'Div Vlr Pagto'     
	If (trim(TRB2->statuspeg) == 'Div Vlr Taxa'      

	*/

Return()   

Static Function FGrvPlan(cOperadora,cComp )                  

	cNomeArq := "C:\TEMP\"+trim(cOperadora)+'_'+cComp+DtoS(date())+"_"+STRTRAN(TIME(),":","")+".csv"
	// cNomeArq := "\LOGCOBCONV\"+trim(cOperadora)+'_'+cComp+DtoS(date())+"_"+STRTRAN(TIME(),":","")+".csv"
	nHandle := FCREATE(cNomeArq)

	cMontaTxt := 'Empresa  : '+ trim(cOperadora) 
	cMontaTxt += CRLF
	FWrite(nHandle,cMontaTxt)		

	cMontaTxt := 'Ação  : Log de Cobrança Final'
	cMontaTxt += CRLF
	FWrite(nHandle,cMontaTxt)		  

	cMontaTxt := 'Usuario : '+SubStr(cUSUARIO,7,15)
	cMontaTxt += CRLF
	FWrite(nHandle,cMontaTxt) 


	cMontaTxt := "BD6_CODOPE  ;" 
	cMontaTxt += "BD6_CODEMP  ;" 
	cMontaTxt += "BD6_MATRIC ;" 
	cMontaTxt += "BD6_TIPREG ;" 
	cMontaTxt += "BD6_DIGITO ;" 
	cMontaTxt += "BD6_DATPRO ;"
	cMontaTxt += "BD6_NOMUSR ;" 
	cMontaTxt += "BD6_CODRDA ;" 
	cMontaTxt += "BD6_NOMRDA ;" 
	cMontaTxt += "BD6_DESPRO ;"
	cMontaTxt += "BD6_VLRTPF ;" 
	cMontaTxt += "BD6_VLRBPF ;" 
	cMontaTxt += "BD6_VLRTAD ;"
	cMontaTxt += "BD6_NUMIMP ;"
	cMontaTxt += "BD6_CODOPE ;" 
	cMontaTxt += "BD6_CODLDP ;" 
	cMontaTxt += "BD6_CODPEG ;" 
	cMontaTxt += "BD6_NUMERO ;"
	cMontaTxt += "BD6_ORIMOV ;"
	cMontaTxt += "BD6_SEQUEN ;" 
	cMontaTxt += "BD6_CODPRO ;"   
	cMontaTxt += "BA1_YMTREP ;"
	cMontaTxt += "BAU_CODIGO ;"
	cMontaTxt += "BAU_TIPPE  ;"
	cMontaTxt += "BAU_NOME   ;"
	cMontaTxt += "VLRTPFPCS  ;"
	cMontaTxt += "VLRBPFPCS  ;"
	cMontaTxt += "VLRTADPCS  ;"
	cMontaTxt += "statuspeg  ;"
	cMontaTxt += "DifB       ;"
	cMontaTxt += "DifT       ;"
	cMontaTxt += "DifTOT     ;"
	cMontaTxt += CRLF // Salto de linha para .csv (excel)   

	FWrite(nHandle,cMontaTxt)


	TRB2->( dbGotop() )

	While !TRB2->( Eof() )		

		cMontaTxt := TRB2->BD6_CODOPE + ";" 
		cMontaTxt += TRB2->BD6_CODEMP + ";" 
		cMontaTxt += TRB2->BD6_MATRIC + ";" 
		cMontaTxt += TRB2->BD6_TIPREG + ";" 
		cMontaTxt += TRB2->BD6_DIGITO + ";" 
		cMontaTxt += dtos(TRB2->BD6_DATPRO) + ";"
		cMontaTxt += TRB2->BD6_NOMUSR + ";" 
		cMontaTxt += TRB2->BD6_CODRDA + ";" 
		cMontaTxt += TRB2->BD6_NOMRDA + ";" 
		cMontaTxt += TRB2->BD6_DESPRO + ";"
		cMontaTxt += Transform((TRB2->BD6_VLRTPF),"@E 99,999,999.99")+ ";" 
		cMontaTxt += Transform((TRB2->BD6_VLRBPF),"@E 99,999,999.99")+ ";"  
		cMontaTxt += Transform((TRB2->BD6_VLRTAD),"@E 99,999,999.99")+ ";"  
		cMontaTxt += TRB2->BD6_NUMIMP + ";"
		cMontaTxt += TRB2->BD6_CODOPE + ";" 
		cMontaTxt += TRB2->BD6_CODLDP + ";" 
		cMontaTxt += TRB2->BD6_CODPEG + ";" 
		cMontaTxt += TRB2->BD6_NUMERO + ";"
		cMontaTxt += TRB2->BD6_ORIMOV + ";"
		cMontaTxt += TRB2->BD6_SEQUEN + ";" 
		cMontaTxt += TRB2->BD6_CODPRO + ";"   
		cMontaTxt += TRB2->BA1_YMTREP + ";"
		cMontaTxt += TRB2->BAU_CODIGO + ";"
		cMontaTxt += TRB2->BAU_TIPPE  + ";"
		cMontaTxt += TRB2->BAU_NOME   + ";" 
		cMontaTxt += Transform((TRB2->VLRTPFPCS),"@E 99,999,999.99")+ ";"                              
		cMontaTxt += Transform((TRB2->VLRBPFPCS),"@E 99,999,999.99")+ ";"  
		cMontaTxt += Transform((TRB2->VLRTADPCS),"@E 99,999,999.99")+ ";"  
		cMontaTxt += TRB2->statuspeg  + ";
		cMontaTxt += Transform((TRB2->DifB),"@E 99,999,999.99")+ ";"                         
		cMontaTxt += Transform((TRB2->DifT),"@E 99,999,999.99")+ ";"                         
		cMontaTxt += Transform((TRB2->DifTOT),"@E 99,999,999.99")+ ";"                         
		cMontaTxt += CRLF // Salto de linha para .csv (excel)   

		FWrite(nHandle,cMontaTxt)    

		TRB2->( dbSkip() ) 

	EndDo  

	If nHandle > 0

		// encerra gravação no arquivo
		FClose(nHandle)
		//	cNomeArq1+= cNomeArq + CRLF
		MsgAlert("Relatorio salvo em: "+cNomeArq)

		//	fEnvEmail(cNomeArq , cEmpresa , trim(aDados[1,1]) )
	EndIf       

Return()	





