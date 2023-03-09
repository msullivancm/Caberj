#INCLUDE "rwmake.ch"
#INCLUDE "protheus.ch"
#INCLUDE "TopConn.ch"
#include "TBICONN.CH"    

#DEFINE c_ent CHR(13) + CHR(10)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัอออออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCABR131      บAutor  ณ PAULO MOTTA        บ Data ณ SETEMBRO/13 บฑฑ
ฑฑฬออออออออออุอออออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ  GERA PLANILHA PARA CONFERENCIA DE COPARTICIPACOES DE         บฑฑ 
ฑฑบ          ณ  ASSISTIDOS                                                   บฑฑ
ฑฑฬออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Projeto CABERJ                                                บฑฑ
ฑฑศออออออออออฯอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function CABR131()     
      
Processa({||PCABR131()},'Processando...')

Return

Static Function PCABR131

Local aSaveArea	:= {} 

Local aCabec := {}
Local aDados := {} 

Local cRefer  := " " 
Local cRDA    := " "  
Local cRDASOL := " "   
Local nValDe  := 0   
Local nValAte := 0   
Local cTpCust := " "   
Local nProj   := 0   
Local cEmp    := " "
Local cTab131 := " "  
Local cEmp131 := " "      
Local nI 	  := 0     

Private cPerg := "CAB131"

aSaveArea	:= GetArea()
AjustaSX1()    
 
//Monta tabela/parametro das functiions conforme Empresa(Caberj/Integral) 
If cEmpAnt = "01" 
  cTab131 := "V_CUSTO_CAB_ABERTO"   
  cEmp131 := "'C'"
Else  
  cTab131 := "V_CUSTO_INT_ABERTO"      
  cEmp131 := "'I'"
End if  

//ler parametros 
If Pergunte(cPerg,.T.)  
   	cRefer  := Substr(DToS(mv_par01),1,6)
 	cRDA    := mv_par02  
	cRDASOL := mv_par03
	nValDe  := mv_par04   
	nValAte := mv_par05   
	cTpCust := mv_par06  
	nProj   := mv_par07  
	cEmp    := mv_par08       
else
    Return	
EndIf         

//Monta query 
cQuery := " SELECT PROJ,  " + c_ent  
If cEmpAnt = "01" 
  cQuery += " PLS_LISTA_PROJ_ATIVO('  ',OPEUSR,CODEMP,MATRIC,TIPREG,'0',TO_DATE(TRIM(DATA),'YYYYMMDD')) PRJASSDTPRC, " + c_ent  
else
  cQuery += " PLS_LISTA_PROJ_ATIVO_INT('  ',OPEUSR,CODEMP,MATRIC,TIPREG,'0',TO_DATE(TRIM(DATA),'YYYYMMDD')) PRJASSDTPRC, " + c_ent  
Endif
cQuery += "        CODEMP,  " + c_ent     
cQuery += "        (OPEUSR||CODEMP||MATRIC||TIPREG||DIGITO) MATRIC, " + c_ent 
If cEmpAnt = "01" 
  cQuery += "        Decode(Nvl(RETORNA_NUCLEO_MS(OPEUSR,CODEMP,MATRIC,TIPREG,TO_CHAR(LAST_DAY(TO_DATE(REFER,'YYYYMM')),'YYYYMMDD')),RETORNA_NUCLEO_MS(OPEUSR,CODEMP,MATRIC,TIPREG,DATA)), " + c_ent
  cQuery += "               '1','NUPRE NITEROI','2','NUPRE TIJUCA','3','NUPRE BANGU','') NUPRE," + c_ent
Else
  cQuery += "        ' ' NUPRE," + c_ent 
Endif
cQuery += "        BA1_NOMUSR NOME, " + c_ent  
cQuery += "        IDADE_S(BA1_DATNAS,TRIM(DATA)) IDADE_EVT, " + c_ent  
cQuery += "        PLANO, " + c_ent 
cQuery += "        NOME_PLANO, " + c_ent
cQuery += "        RDA, " + c_ent
cQuery += "        BAU1.BAU_NOME NOMERDA, " + c_ent
cQuery += "        RDASOL, " + c_ent 
cQuery += "        BAU2.BAU_NOME NOMRDASOL, " + c_ent
cQuery += "        OPEUSR, " + c_ent
cQuery += "        LOCALI, " + c_ent
cQuery += "        PEG, " + c_ent         
cQuery += "        NUMERO, " + c_ent   
cQuery += "        TRIM(NOME_EVENTO) NOME_EVENTO, " + c_ent                   
cQuery += "        (SELECT MIN(BG7_CODGRU||'-'||TRIM(BG7_DESCRI)) " + c_ent   
cQuery += "         FROM  " + RetSqlName("BG7") + " BG7 , " + RetSqlName("BG8") + " BG8 " + c_ent  
cQuery += "         WHERE BG8_FILIAL='  ' " + c_ent  
cQuery += "         AND   BG8_CODINT='0001' " + c_ent  
cQuery += "         AND   BG8_CODPAD=TABELA " + c_ent  
cQuery += "         AND   BG8_CODPSA=COD_PROCED " + c_ent  
cQuery += "         AND   BG7_FILIAL = BG8_FILIAL " + c_ent  
cQuery += "         AND   BG7_CODINT = BG8_CODINT " + c_ent  
cQuery += "         AND   BG7_CODGRU = BG8_CODGRU " + c_ent  
cQuery += "         AND   BG7.D_E_L_E_T_<> '*' " + c_ent  
cQuery += "         AND   BG8.D_E_L_E_T_<> '*'  ) GRP_COB," + c_ent  
cQuery += "        ZZT_TPCUST TPCUST, " + c_ent
cQuery += "        TABELA, " + c_ent
cQuery += "        COD_PROCED CODPROC, " + c_ent  
cQuery += "        DESPRO PROCEDIMENTO, " + c_ent
cQuery += "        NUMSE1 TITULO," + c_ent
cQuery += "        FORMATA_DATA_MS(data) DTPROC, " + c_ent         
cQuery += "        FORMATA_DATA_MS(RETORNA_DATA_MS(DECODE(TRIM(PROJ),'AAG','0041','AED','0038','TAB','0062','AAI','0060','MAT','0083','PGD','0137',''), " + c_ent
cQuery += "                                        OPEUSR, " + c_ent
cQuery += "                                        CODEMP, " + c_ent 
cQuery += "                                        MATRIC, " + c_ent
cQuery += "                                        TIPREG, " + c_ent
cQuery += "                                        DATA)) DTINCPROJ, " + c_ent 
cQuery += "        NUMIMP, " + c_ent 
cQuery += "        SIGLASOL, " + c_ent 
cQuery += "        ESTSOL, " + c_ent   
cQuery += "        REGSOL, " + c_ent  
cQuery += "        CDPFSO CODPROFSAUDE, " + c_ent  
cQuery += "        RETORNA_NOME_PROF_SAUDE(" + cEmp131  + ",CDPFSO) NOME_SOLICITANTE, " + c_ent     
cQuery += "        (SELECT MAX(DECODE(ZZF_TPPROF,'1','AED','2','AAG','3','AED/AAG','4','MAT','5','PGD','6','PAL','7','CTM',' ') )  " + c_ent
cQuery += "         FROM " + RetSqlName("BB0") + " BB0 , " +RetSqlName("ZZF") + " ZZF " + c_ent
cQuery += "         WHERE BB0_FILIAL = ' ' " + c_ent
cQuery += "         AND ZZF_FILIAL = ' '  " + c_ent
cQuery += "         AND TRIM(BB0_CODIGO) = CDPFSO " + c_ent
cQuery += "         AND BB0_CODOPE = '0001' " + c_ent
cQuery += "         AND BB0_CODIGO = ZZF_CODIGO " + c_ent
cQuery += "         AND (BB0_DATBLO = ' ' or BB0_DATBLO >= DATA) " + c_ent
cQuery += "         AND (ZZF_DATBLO = ' ' or ZZF_DATBLO >= DATA) " + c_ent
cQuery += "         AND ZZF.D_E_L_E_T_ = ' ' " + c_ent
cQuery += "         AND BB0.D_E_L_E_T_ = ' ') SOLPROJ,  " + c_ent
/*29/11/19 TABELA DE ISENCOES*/
cQuery += "        (SELECT (CASE WHEN COUNT(*) = 0 THEN 'NAO' ELSE 'SIM' END) "  + c_ent 	
cQuery += "         FROM   " + RetSqlName("ZRS") + " ZRS , " + RetSqlName("ZRT") + " ZRT "  + c_ent 	
cQuery += "         WHERE  ZRS_FILIAL = ' ' "  + c_ent 	
cQuery += "         AND    ZRT_FILIAL = ZRS_FILIAL "  + c_ent 	
cQuery += "         AND    ZRT_SOLICI = ZRS_SOLICI "  + c_ent 
cQuery += "         AND    ZRT_MATRIC = ZRS_MATRIC "  + c_ent 	
cQuery += "         AND    OPEUSR = SUBSTR(ZRT_MATRIC,1,4) "  + c_ent 	
cQuery += "         AND    CODEMP = SUBSTR(ZRT_MATRIC,5,4) "  + c_ent 	
cQuery += "         AND    MATRIC = SUBSTR(ZRT_MATRIC,9,6) "  + c_ent 	
cQuery += "         AND    TIPREG = SUBSTR(ZRT_MATRIC,15,2) "  + c_ent 	 
cQuery += "         AND    DIGITO = SUBSTR(ZRT_MATRIC,17,1)  "  + c_ent 	  
cQuery += "         AND    COD_PROCED = ZRT_CODPRO "  + c_ent 	
cQuery += "         AND    TO_DATE(TRIM(DATA),'YYYYMMDD') BETWEEN  TO_DATE(TRIM(ZRS_DATSOL),'YYYYMMDD') AND "  + c_ent 	
cQuery += "                TO_DATE(TRIM(ZRS_DATSOL),'YYYYMMDD')+120 "  + c_ent 	
cQuery += "         AND    ZRS.D_E_L_E_T_ = ' ' "  + c_ent 	
cQuery += "         AND    ZRT.D_E_L_E_T_ = ' ') TABSOL, "  + c_ent 	
/*FIM 29/11/19 TABELA DE ISENCOES*/
cQuery += "        OCORRENCIA, " + c_ent           
cQuery += "        VL_APRESENTADO, " + c_ent //Motta 29/9/15
cQuery += "        VL_BASE_PAGTO, " + c_ent  //Motta 29/9/15
cQuery += "        VL_APROV, " + c_ent
cQuery += "        VL_PARTICIPACAO, " + c_ent  
cQuery += "        ROUND(VL_PARTICIPACAO/OCORRENCIA,2)  VL_PART_UNIT,  " + c_ent      
cQuery += "        (VL_APROV - VL_PARTICIPACAO) CUSTO, " + c_ent 
cQuery += "        PERCOP  " + c_ent    
cQuery += " FROM  " + cTab131 + " VC, " + RetSqlName("BA1") + " BA1, " + c_ent
cQuery += "        (SELECT BAU_CODIGO , BAU_NOME " + c_ent
cQuery += "         FROM   " + RetSqlName("BAU") + "  "  + c_ent    
cQuery += "         WHERE  D_E_L_E_T_ = ' ') BAU1,  " + c_ent
cQuery += "        (SELECT BAU_CODIGO , BAU_NOME " + c_ent
cQuery += "         FROM   " + RetSqlName("BAU") + "  " + c_ent    
cQuery += "         WHERE  D_E_L_E_T_ = ' ') BAU2 " + c_ent  
cQuery += " where  REFER = '" + cRefer + "' " + c_ent    
If cEmpAnt = "01" 
  cQuery += " and    CODEMP not in ('0004','0009') " + c_ent  
end if;  
cQuery += " and    VL_APROV <> 0 " + c_ent  
cQuery += " AND    VL_PARTICIPACAO BETWEEN " + Str(nValDe) + " AND " + Str(nValAte) + " " + c_ent  
if nProj == 1 
	If cEmpAnt = "01" 
	  cQuery += " AND    (TRIM(PROJ) LIKE '%AED%' OR TRIM(PROJ) LIKE '%AAG%' OR TRIM(PROJ) LIKE '%MAT%' OR TRIM(PROJ) LIKE '%PGD%') " + c_ent
	else
	  cQuery += " AND    (TRIM(PROJ) IS NOT NULL) " + c_ent  
	end if
Else     
  	if nProj == 2
		If cEmpAnt = "01" 
	  		cQuery += " AND (TRIM(PROJ) IS NULL OR NOT((TRIM(PROJ) LIKE '%AED%' OR TRIM(PROJ) LIKE '%AAG%' OR TRIM(PROJ) LIKE '%MAT%' OR TRIM(PROJ) LIKE '%PGD%'))) " + c_ent
		else
	  		cQuery += " AND (TRIM(PROJ) IS NULL) " + c_ent  
		end if
	end if
End if	
cQuery += " AND    BA1_FILIAL = '  ' "  + c_ent 
cQuery += " AND    BA1_CODINT = OPEUSR " + c_ent  
cQuery += " AND    BA1_CODINT = OPEUSR " + c_ent
cQuery += " AND    BA1_CODEMP = CODEMP " + c_ent
cQuery += " AND    BA1_MATRIC = MATRIC " + c_ent   
cQuery += " AND    BA1_TIPREG = TIPREG  " + c_ent
cQuery += " AND    BA1_DIGITO = DIGITO " + c_ent
cQuery += " AND    BAU1.BAU_CODIGO (+) = RDA " + c_ent
cQuery += " AND    NVL(TRIM('" + cRDA + "'),RDA) = RDA " + c_ent
cQuery += " AND    BAU2.BAU_CODIGO (+) = RDASOL " + c_ent
If cRDASOL != " "  
  cQuery += " AND    NVL(TRIM('" + cRDASOL + "'),RDASOL) = RDASOL " + c_ent
End if 
cQuery += " AND    NVL(TRIM('" +  cTpCust + "'),VC.ZZT_TPCUST) = VC.ZZT_TPCUST " + c_ent     
cQuery += " AND    NVL(TRIM('" + cEmp + "'),BA1_CODEMP) = BA1_CODEMP " + c_ent
cQuery += " AND    BA1.D_E_L_E_T_ = ' ' " + c_ent
cQuery += " ORDER BY 1,2,3,11,12,13,14 "

//memowrite("C:\TEMP\sql131.sql",cQuery)      
                                                 //
If Select("R131") > 0
	dbSelectArea("R131")
	dbCloseArea()
EndIf

DbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),"R131",.T.,.T.)         

For nI := 1 to 5
	IncProc('Processando...')
Next

If ! R131->(Eof())
	nSucesso := 0
	aCabec := {"PROJETO","PRJASSDTPRC","CODEMP","MATRICULA","NUPRE","NOME","IDADE_EVT","PLANO","NOME_PLANO","RDA","NOMERDA","RDASOL","NOMRDASOL","OPEUSR","LOCAL",;
	           "PEG","NUMERO","GRP_COB","TP_CUSTO","NOME_EVENTO","TABELA","COD_PROC","PROCEDIMENTO","TITULO","DT_PROC","DT_INC_PROJ","NUMIMP",;     
	           "SIGLASOL","UF_SOLIC","NUM_SOLICITANTE","COD_PROF_SAUDE","NOME_SOLICITANTE",;
	           "SOL_PROJ","SOLEXPROC","OCORRENCIA","VL_APRESENTADO","VL_BASE_PAGTO","VL_APROV",;
	           "VL_PARTICIPACAO","VL_PART_UNIT","CUSTO","PERCOP"} 
	R131->(DbGoTop())
	While ! R131->(Eof()) 
		IncProc()		
		aaDD(aDados,{R131->PROJ , R131->PRJASSDTPRC ,R131->CODEMP , R131->MATRIC , R131->NUPRE ,R131->NOME , R131->IDADE_EVT , R131->PLANO , R131->NOME_PLANO ,R131->RDA , R131->NOMERDA ,;
		             R131->RDASOL ,R131->NOMRDASOL , R131->OPEUSR ,R131->LOCALI , R131->PEG ,R131->NUMERO ,R131->GRP_COB,R131->TPCUST ,R131->NOME_EVENTO ,;
		             R131->TABELA ,R131->CODPROC ,R131->PROCEDIMENTO ,R131->TITULO , R131->DTPROC ,R131->DTINCPROJ , R131->NUMIMP ,;      
		             R131->SIGLASOL,R131->ESTSOL,R131->REGSOL,R131->CODPROFSAUDE ,R131->NOME_SOLICITANTE ,; 
		             R131->SOLPROJ , R131->TABSOL ,R131->OCORRENCIA ,R131->VL_APRESENTADO , R131->VL_BASE_PAGTO ,;
		             R131->VL_APROV , R131->VL_PARTICIPACAO,R131->VL_PART_UNIT,R131->CUSTO,R131->PERCOP})  
		
		R131->(DbSkip())
	End
	 
	//Abre excel 
    DlgToExcel({{"ARRAY"," " ,aCabec,aDados}})

EndIf	

If Select("R131") > 0
	dbSelectArea("R131")
	dbCloseArea()
EndIf      

 
*************************************************************************************************************************
//AJUSTAR "COPPRO"
Static Function AjustaSX1      

 
Local aHelpPor := {}
//Monta Help
Aadd( aHelpPor, 'A-Ambulatorial ' ) 
Aadd( aHelpPor, 'H-Hospitar ' )
Aadd( aHelpPor, 'Branco para todos' )


PutSx1(cPerg,"01","Referencia  "  ,"","","mv_ch01","D",08,0,0,"C","","","","","mv_par01","","","","","","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"02","RDA         "  ,"","","mv_ch02","C",06,0,0,"C","","BAUPLS","","","mv_par02","","","","","","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"03","RDA SOL     "  ,"","","mv_ch03","C",06,0,0,"C","","BAUPLS","","","mv_par03","","","","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "", "" )  
PutSx1(cPerg,"04","Valor De    "  ,"","","mv_ch04","N",12,2,0,"G","","","","","mv_par04","","","","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "", "" )  
PutSx1(cPerg,"05","Valor De    "  ,"","","mv_ch05","N",12,2,0,"G","","","","","mv_par05","","","","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "", "" )  
PutSx1(cPerg,"06","Tipo Custo  "  ,"","","mv_ch06","C",01,0,0,"C","","","","","mv_par06","","","","","","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"07","Projeto     "  ,"","","mv_ch07","C",01,0,0,"C","","","","","mv_par07","1-Em Projeto","","","","2-Fora Projeto","","","3-Todos","","","","","","","","",{},{},{})    
PutSx1(cPerg,"08","Empresa     "  ,"","","mv_ch08","C",04,0,0,"C","","BG9CON","","","mv_par08","","","","","","","","","","","","","","","","",{},{},{})    
PutSX1Help("P."+cPerg+"06.",aHelpPor,{},{})

Return	
