#INCLUDE "rwmake.ch"
#INCLUDE "protheus.ch"
#INCLUDE "TopConn.ch"
#include "TBICONN.CH"    

#DEFINE c_ent CHR(13) + CHR(10)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABR196      ºAutor  ³ Marcela Coimbra    º Data ³ 28/08/2015  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³  GERA PLANILHA DE RAC            							 º±± 
±±º          ³  		                                                     º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Projeto CABERJ                                                º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function CABR196()   
      
Processa({||PCABR196()},'Processando...')                            

Return

Static Function PCABR196
	
	//Local aSaveArea	:= {} 
	Local aCabec := {}
	Local aDados := {}   
	//Local cVencto1 := CTOD("  /  /  ")
	//Local cVencto2 := CTOD("  /  /  ")
	//Local nI 	  := 0   
	
	Private cPerg := "CABR196"
	Private cQuery:= ""
	 
	AjustaSX1(cPerg)
		
	If Pergunte(cPerg,.T.)  
	
		cAno	:= Mv_Par01  
	    cMes	:= Mv_Par02 
	 	cEmpD	:= Mv_Par03  
	    cEmpA	:= Mv_Par04
	   
	else
	    Return	
	EndIf   
		
	cQuery := " select  distinct e1.e1_prefixo || E1.E1_NUM NUM_TITULO,   " 
	cQuery += "         e1.e1_valor valor_titulo,                         "
	cQuery += " TO_DATE(TRIM(ra.E1_EMISSAO),'YYYYMMDD') RAC_DATA_EMISSAO, " // ANDERSON RANGEL - MARÇO/2021 - ID 68996
	cQuery += "        ra.e1_Prefixo || RA.E1_NUM RAC_NUM_TITULO,         "
	cQuery += "        ra.e1_valor VALOR_RAC,                             "
	// ANDERSON RANGEL - MARÇO/2021 - ID 68996
	cQuery += "(CASE WHEN (SELECT distinct e11.E1_PREFIXO||e11.E1_NUM 		"
    cQuery += "        FROM " + RETSQLNAME("SE1") + " e11 "
    cQuery += "        WHERE e11.E1_FILIAL = '01' AND e11.e1_Prefixo = 'PLS' AND e11.D_E_L_E_T_ = ' ' AND e11.E1_NUM = ra.E1_NUM) is not null "
    cQuery += "  THEN (SELECT distinct e11.E1_PREFIXO||e11.E1_NUM "
    cQuery += "        FROM " + RETSQLNAME("SE1") + " e11 "
    cQuery += "        WHERE e11.E1_FILIAL = '01' AND e11.e1_Prefixo = 'PLS' AND e11.D_E_L_E_T_ = ' ' AND e11.E1_NUM = ra.E1_NUM) "
    cQuery += "  WHEN (SELECT distinct e11.E1_PREFIXO||e11.E1_NUM "
    cQuery += "        FROM " + RETSQLNAME("SE1") + " e11 "
    cQuery += "        WHERE e11.E1_FILIAL = '01' AND e11.e1_Prefixo = 'PLS' AND e11.D_E_L_E_T_ = '*' AND e11.E1_NUM = ra.E1_NUM) is not null "
    cQuery += "  THEN (SELECT distinct e11.E1_PREFIXO||e11.E1_NUM "
    cQuery += "        FROM " + RETSQLNAME("SE1") + " e11 "
    cQuery += "        WHERE e11.E1_FILIAL = '01' AND e11.e1_Prefixo = 'PLS' AND e11.D_E_L_E_T_ = '*' AND e11.E1_NUM = ra.E1_NUM) "
    cQuery += "  ELSE 'NÃO LOCALIZADO' "
	cQuery += "END) PLS_NUM_TIT_ORIG, "
	cQuery += "(CASE WHEN (SELECT distinct e11.E1_MESBASE||'/'||e11.E1_ANOBASE "
    cQuery += "        FROM " + RETSQLNAME("SE1") + " e11 "
    cQuery += "        WHERE e11.E1_FILIAL = '01' AND e11.e1_Prefixo = 'PLS' AND e11.D_E_L_E_T_ = ' ' AND e11.E1_NUM = ra.E1_NUM) is not null "
    cQuery += "  THEN (SELECT distinct e11.E1_MESBASE||'/'||e11.E1_ANOBASE "
    cQuery += "        FROM " + RETSQLNAME("SE1") + " e11 "
    cQuery += "        WHERE e11.E1_FILIAL = '01' AND e11.e1_Prefixo = 'PLS' AND e11.D_E_L_E_T_ = ' ' AND e11.E1_NUM = ra.E1_NUM) "
    cQuery += "  WHEN (SELECT distinct e11.E1_MESBASE||'/'||e11.E1_ANOBASE "
    cQuery += "        FROM " + RETSQLNAME("SE1") + " e11 "
    cQuery += "        WHERE e11.E1_FILIAL = '01' AND e11.e1_Prefixo = 'PLS' AND e11.D_E_L_E_T_ = '*' AND e11.E1_NUM = ra.E1_NUM) is not null "
    cQuery += "  THEN (SELECT distinct e11.E1_MESBASE||'/'||e11.E1_ANOBASE "
    cQuery += "        FROM " + RETSQLNAME("SE1") + " e11 "
    cQuery += "        WHERE e11.E1_FILIAL = '01' AND e11.e1_Prefixo = 'PLS' AND e11.D_E_L_E_T_ = '*' AND e11.E1_NUM = ra.E1_NUM) "
    cQuery += "  ELSE 'NÃO LOCALIZADO' "
	cQuery += "END) PLS_COMPET_ORIG, "
	// FIM
	cQuery += "        e1.e1_cliente COD_CLIENTE,                         "  
	cQuery += "        e1.e1_nomcli NOME_CLIENTE,     				      "	 
	cQuery += "        e1.E1_CODEMP COD_EMPRESA,             	          " 
	cQuery += "        e1.E1_CODINT||e1.E1_CODEMP||e1.E1_MATRIC MATRICULA,"
	cQuery += "        e1.E1_FORMREC FORM_REC                             "
	cQuery += "from " + RETSQLNAME("SE1") + " e1,"+RETSQLNAME("SE1") + " ra "
	cQuery += "where e1.e1_filial = '01'                                  "
	// cQuery += "      and e1.e1_emissao >= '20130901'                      "     ** ANDERSON RANGEL - RETIRADA DATA CHUMBADA
	cQuery += "      and e1.e1_anobase = '" + cAno +  "'                  "
	cQuery += "      and e1.e1_mesbase = '" + cMes +  "'                  "
 	cQuery += "      and ra.e1_filial = '01'                              "
	cQuery += "      and e1.e1_cliente = ra.e1_cliente                    "
	cQuery += "      and ra.e1_tipo = 'RA'                                "
	cQuery += "      and ra.e1_saldo <> 0                                 "     
	cQuery += "      AND e1.E1_FORMREC IN ('04', '06', '09')              "  //necessita remover a pedido do CArlos
	cQuery += "      AND e1.E1_CODEMP BETWEEN '" + cEmpD +  "'  AND  '" + cEmpA +  "' "
	cQuery += "      AND ra.d_e_l_e_t_ = ' '                              "
	cQuery += "      AND E1.d_e_l_e_t_ = ' '                              "
	cQuery += "  order by 5"                                             
	
	MemoWrite("C:\Temp\CABR196.sql",cQuery)
	cQuery := ChangeQuery( cQuery )
	DbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),"R196",.T.,.T.)         

	// Monta Cabecalho "Fixo"
	aCabec := {"NUM_TITULO",;
			   "RAC_DATA_EMISSAO",;
	           "VALOR_TITULO",;
               "RAC_NUM_TITULO",;
               "VALOR_RAC",;
               "PLS_NUM_TIT_ORIG",;
               "PLS_COMPET_ORIG",;			   
               "COD_CLIENTE",;
               "NOME_CLIENTE",;
               "COD_EMPRESA",;
               "MATRICULA",;
               "FORM_REC"}
			
		While ! R196->(Eof()) 
			IncProc()
			
			AADD(aDados,{R196->NUM_TITULO,;
						 R196->RAC_DATA_EMISSAO,;
						 R196->VALOR_TITULO,;
						 R196->RAC_NUM_TITULO,;
						 R196->VALOR_RAC,;
						 R196->PLS_NUM_TIT_ORIG,;
						 R196->PLS_COMPET_ORIG,;
						 R196->COD_CLIENTE,;
						 R196->NOME_CLIENTE,;
						 "'"+R196->COD_EMPRESA,;
						 "'"+R196->MATRICULA,;
						 R196->FORM_REC})  
			R196->(DbSkip())       
			
		EndDo

	aAdd(aDados ,{"Fim"} )
	//Abre excel 
    DlgToExcel({{"ARRAY"," " ,aCabec,aDados}})
	If Select("R196") > 0
		dbSelectArea("R196")
		dbCloseArea()                                                                       
	EndIf      
	APMSGINFO("Excel de Titulos RAC Gerado com Sucesso !","CABR196")
Return
 
*************************************************************************************************************************
//AJUSTAR "COPPRO"
Static Function AjustaSX1(cPerg)      

 
//Local aHelpPor := {}
//Monta Help

PutSx1(cPerg,"01","Ano:  "  ,"","","mv_ch01","C",04,0,0,"C","","","","","mv_par01","","","","","","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"02","Mes:  "  ,"","","mv_ch02","C",02,0,0,"C","","","","","mv_par02","","","","","","","","","","","","","","","","",{},{},{})   
PutSx1(cPerg,"03","Empresa de:  "  ,"","","mv_ch03","C",04,0,0,"C","","","","","mv_par03","","","","","","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"04","Empresa até:  "  ,"","","mv_ch04","C",04,0,0,"C","","","","","mv_par04","","","","","","","","","","","","","","","","",{},{},{})


Return	