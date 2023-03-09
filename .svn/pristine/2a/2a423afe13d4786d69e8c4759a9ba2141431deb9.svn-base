#INCLUDE "rwmake.ch"
#INCLUDE "protheus.ch"
#INCLUDE "TopConn.ch"
#include "TBICONN.CH"    

#DEFINE c_ent CHR(13) + CHR(10)

/*
********************************************************************************
***Programa  *CABR279      *Autor  * PAULO MOTTA        * Data * JAN/20      ***
********************************************************************************
***Desc.     *  GERA PLANILHA INTERNACOES LIBERADAS EM EXCEL                 *** 
********************************************************************************
***Uso       * Projeto CABERJ                                                *** 
********************************************************************************
*/
User Function CABR279()   

	Processa({||PCABR279()},'Processando...')

Return

Static Function PCABR279

	Local aSaveArea	:= {} 

	Local aCabec := {}
	Local aDados := {} 

	Local cRefDe  := " "   
	Local cRefAte := " " 
	Local cEmp    := " "
	Local cEmp279 := " " 
	Local cTab279 := " "    
	Local nI 	  := 0   
	Local cQuery  := " "  

	Private cPerg := "CAB279"

	aSaveArea	:= GetArea()
	AjustaSX1()    

	//Monta tabela/parametro das functiions conforme Empresa(Caberj/Integral) 
	If cEmpAnt = "01"  
		cEmp279 := "'C'"
	Else       
		cEmp279 := "'I'"
	End if  

	//ler parametros 
	If Pergunte(cPerg,.T.)   

	else
		Return	
	EndIf      

	//Monta query 
	cQuery := " SELECT TO_DATE(TRIM(BE4_DTDIGI),'YYYYMMDD') DATA_DIGIT,                     " + c_ent  
	cQuery += "        TO_DATE(TRIM(BE4_DATPRO),'YYYYMMDD') DATA_INTERN,                    " + c_ent
	cQuery += "        TO_DATE(TRIM(BE4_PRVINT),'YYYYMMDD') DATA_PREVISTA,                  " + c_ent
	cQuery += "        TO_DATE(TRIM(BE4_XDTLIB),'YYYYMMDD') DATA_LIBERACAO,                 " + c_ent
	cQuery += "        DECODE(BE4_GRPINT,'1','INTERNACAO CLINICA',                          " + c_ent
	cQuery += "                          '2','INTERNACAO CIRURGICA',                        " + c_ent
	cQuery += "                          '3','INTERNACAO OBSTETRICA',                       " + c_ent
	cQuery += "                          '4','INTERNACAO PEDIATRICA',                       " + c_ent
	cQuery += "                          '5','INTERNACAO PSIQUIATRICA') GRP_INT,            " + c_ent
	cQuery += "        RETORNA_DESC_TIPO_INTERN("+cEmp279+",BE4_GRPINT,BE4_TIPINT) TIPO_INTERNACAO, " + c_ent  
	cQuery += "        BE4_CODRDA COD_HOSP,                                                 " + c_ent
	cQuery += "        NVL(TRIM(BAU_NFANTA),TRIM(BAU_NOME)) NOME_HOSP,                      " + c_ent
	cQuery += "        BE4_SENHA SENHA,                                                      " + c_ent
	cQuery += "        BE4_ANOINT||BE4_MESINT||BE4_NUMINT NUMINT,                            " + c_ent
	cQuery += "        BE4_YTRANS,                                                           " + c_ent
	cQuery += "        BE4_CODOPE||'.'||BE4_CODEMP||'.'||BE4_MATRIC||'-'||                   " + c_ent
	cQuery += "        BE4_TIPREG||'-'||BE4_DIGITO MATRIC,                                   " + c_ent
	cQuery += "        BE4_NOMUSR NOME_ASS,                                                  " + c_ent
	cQuery += "        PLS_QTD_DIARIAS_LIBERADAS(BE4_CODOPE,BE4_ANOINT||BE4_MESINT,          " + c_ent
	cQuery += "                                  BE4_NUMINT,'"+Substr(cEmpAnt,2,1)+"') DIAS_INT,   " + c_ent     
	cQuery += "        TRIM(BE4_INDCLI) INDIC_CLIN,                                          " + c_ent
	cQuery += "        BE4_REGSOL CR_SOLIC,                                                  " + c_ent
	cQuery += "        BE4_NOMSOL NOME_SOLIC,                                                " + c_ent
	cQuery += "        DECODE(TRIM(BI4_DESCRI),'INDIVIDUAL','APT','COL') ACOMODACAO,         " + c_ent
	cQuery += "        BE4_DESOPE OPER,                                                      " + c_ent     
	cQuery += "        IDADE(TO_DATE(TRIM(BA1_DATNAS),'YYYYMMDD'),SYSDATE) IDADE,            " + c_ent    
	cQuery += "        DECODE(BA1_SEXO,'1','M','2','F','') SEXO,                             " + c_ent    
	cQuery += "        TRIM(BE4_CID) CID,                                                    " + c_ent    
	cQuery += "        TRIM(BA9_DOENCA)  DESC_CID,                                           " + c_ent    
	cQuery += "        TRIM(BI3_NREDUZ) PLANO,                                               " + c_ent    
	cQuery += "        BA1_BAIRRO BAIRRO,                                                    " + c_ent    
	cQuery += "        BA1_MUNICI MUNICIPIO,                                                 " + c_ent    
	cQuery += "        MU.BID_DESCRI MUNIC_RDA,                                              " + c_ent    
	cQuery += "        MU.BID_EST UF_RDA,                                                    " + c_ent          
	If cEmpAnt = "01"   
		cQuery += "      SUBSTR(PLS_LISTA_PROJ_ATIVO (' ',BA1_CODINT,BA1_CODEMP,BA1_MATRIC,    " + c_ent  
		cQuery += "                                   BA1_TIPREG,0,                            " + c_ent  
		cQuery += "      							    To_Date(trim(BE4_DTDIGI),'YYYYMMDD')) ,  " + c_ent  
		cQuery += "              1,100) PROJETO_ATIVOS,                                        " + c_ent     
		cQuery += "      DECODE(RETORNA_LOCAL_MAT(BA1_CODINT,BA1_CODEMP,BA1_MATRIC,            " + c_ent  
		cQuery += "                               BA1_TIPREG,BE4_DTDIGI),                      " + c_ent  
		cQuery += "             '056',' TIJUCA','058',' COPACABANA',' ') LOCAL_MAT,            " + c_ent  
	Else   
		cQuery += "      SUBSTR(PLS_LISTA_PROJ_ATIVO_INT (' ',BA1_CODINT,BA1_CODEMP,BA1_MATRIC," + c_ent  
		cQuery += "                                       BA1_TIPREG,0,                        " + c_ent  
		cQuery += "		    						    To_Date(trim(BE4_DTDIGI),'YYYYMMDD')) ,  " + c_ent  
		cQuery += "			  1,100) PROJETO_ATIVOS,                                         " + c_ent  
		cQuery += "      DECODE(RETORNA_LOCAL_MAT_INT(BA1_CODINT,BA1_CODEMP,BA1_MATRIC,        " + c_ent  
		cQuery += "                                   BA1_TIPREG,BE4_DTDIGI),                  " + c_ent  
		cQuery += "			  '056',' TIJUCA','058',' COPACABANA',' ') LOCAL_MAT,            " + c_ent  
	Endif      
	cQuery += "        NVL(TO_DATE(TRIM(BE4_DTALTA),'YYYYMMDD'),TRUNC(SYSDATE))-             " + c_ent   
	cQuery += "            TO_DATE(TRIM(BE4_DATPRO),'YYYYMMDD') TOT_DIAS_INT,                " + c_ent   			
	cQuery += "        TO_DATE(TRIM(BE4_DTALTA),'YYYYMMDD') DT_ALTA,                         " + c_ent 		
	cQuery += "        BG9_CODIGO CODEMP,TRIM(BG9_NREDUZ) EMPRESA,                           " + c_ent 		
	cQuery += "        TRIM(BE4_MSG03) CONTATOS,                                             " + c_ent     
	cQuery += "        (CASE  WHEN OBTER_CUSTO_GR(BE4_SENHA,BE4_DATPRO,' ') = 0              " + c_ent 
	cQuery += "                 THEN 'UTI'                                                   " + c_ent 
	cQuery += "               WHEN OBTER_CUSTO_GR(BE4_SENHA,BE4_DATPRO,' ') = 1              " + c_ent 
	cQuery += "                 THEN 'APARTAMENTO'                                           " + c_ent 
	cQuery += "               WHEN OBTER_CUSTO_GR(BE4_SENHA,BE4_DATPRO,' ') = 2              " + c_ent 
	cQuery += "                 THEN 'COLETIVO'                                              " + c_ent 
	cQuery += "               WHEN OBTER_CUSTO_GR(BE4_SENHA,BE4_DATPRO,' ') = 3              " + c_ent 
	cQuery += "                 THEN 'DAY CLINIC'                                            " + c_ent 
	cQuery += "               ELSE 'APARTAMENTO'                                             " + c_ent 
	cQuery += "         END) AS ACOMODACAO_REAL,                                             " + c_ent 			
	cQuery += "        DECODE(TRIM(BDR_CARINT),'U','Urgencia','Eletiva')  TIPADM,            " + c_ent 
	cQuery += "        NVL(TRIM(BA1_CPFUSR),TRIM(BA1_CPFPRE)) CPF,                           " + c_ent 
	cQuery += "        OBTER_PROCED_PRINC_INTERN("+cEmp279+",                              " + c_ent 
	cQuery += "                                   BE4_CODOPE,BE4_ANOINT,BE4_MESINT,          " + c_ent 
	cQuery += "                                   BE4_NUMINT,'1') CODPROCPRIC,               " + c_ent 
	cQuery += "        OBTER_PROCED_PRINC_INTERN("+cEmp279+",                              " + c_ent 
	cQuery += "                                   BE4_CODOPE,BE4_ANOINT,BE4_MESINT,          " + c_ent 
	cQuery += "                                   BE4_NUMINT,'2') DESCPROCPRINC,             " + c_ent 
	cQuery += "        OBTER_PROCED_PRINC_INTERN("+cEmp279+",                              " + c_ent 
	cQuery += "                                   BE4_CODOPE,BE4_ANOINT,BE4_MESINT,          " + c_ent 
	cQuery += "                                   BE4_NUMINT,'3') GRPCOBPRPRINC              " + c_ent 			  
	cQuery += "  FROM "+RetSqlName('BE4')+" I,                                            " + c_ent      
	cQuery += "       "+RetSqlName('BI4')+" A,                                            " + c_ent    
	cQuery += "  	  "+RetSqlName('BA1')+" U,                                            " + c_ent    
	cQuery += "  	  "+RetSqlName('BA9')+" C,                                            " + c_ent    
	cQuery += "  	  "+RetSqlName('BI3')+" P ,                                           " + c_ent    
	cQuery += "  	  "+RetSqlName('BID')+" MU,                                           " + c_ent    
	cQuery += "       "+RetSqlName('BAU')+" PR,                                           " + c_ent    
	cQuery += "       "+RetSqlName('BA3')+" F,                                            " + c_ent    
	cQuery += "  	  "+RetSqlName('BG9')+" BG9,                                          " + c_ent    
	cQuery += "  	  "+RetSqlName('BDR')+" BDR                                           " + c_ent     
	cQuery += "  WHERE BE4_FILIAL=' '                                                        " + c_ent    
	cQuery += "  AND BA9_FILIAL=' '	                                                         " + c_ent   
	cQuery += "  AND BI4_FILIAL=' '	                                                         " + c_ent    
	cQuery += "  AND BAU_FILIAL=' '	                                                         " + c_ent  
	cQuery += "  AND BI3_FILIAL=' '	                                                         " + c_ent    
	cQuery += "  AND BA3_FILIAL=' '	                                                         " + c_ent  
	cQuery += "  AND MU.BID_FILIAL=' '	                                                     " + c_ent    
	cQuery += "  AND BA1_FILIAL=' '	                                                         " + c_ent  
	cQuery += "  AND BG9_FILIAL=' '	                                                         " + c_ent    
	cQuery += "  AND BE4_CID=BA9_CODDOE	                                                     " + c_ent  
	cQuery += "  AND BE4_OPEUSR=BA1_CODINT	                                                 " + c_ent    
	cQuery += "  AND BE4_CODEMP=BA1_CODEMP	                                                 " + c_ent  
	cQuery += "  AND BE4_MATRIC=BA1_MATRIC	                                                 " + c_ent    
	cQuery += "  AND BE4_TIPREG=BA1_TIPREG	                                                 " + c_ent  

	cQuery += "  AND BDR_FILIAL=' '                                                          " + c_ent 
	cQuery += "  AND BDR_CODTAD=BE4_TIPADM                                                   " + c_ent 
	cQuery += "  AND BE4_CODOPE = BDR_CODOPE                                                 " + c_ent 
	cQuery += "  AND BDR_CARINT=NVL(trim('"+MV_PAR11+"'),BDR_CARINT)                               " + c_ent 
	cQuery += "  AND BDR.D_E_L_E_T_=' '                                                      " + c_ent 
	cQuery += "  AND BA1_CODINT=BA3_CODINT                                                   " + c_ent 
	cQuery += "  AND BA1_CODEMP=BA3_CODEMP                                                   " + c_ent 
	cQuery += "  AND BA1_MATRIC=BA3_MATRIC                                                   " + c_ent 
	cQuery += "  AND BE4_PADINT=BI4_CODACO                                                   " + c_ent 
	/*
	AND ( ((0  sflagProj /=1) AND
	(InStr(Nvl(PLS_LISTA_PROJ_ATIVO (' ',BA1_CODINT,BA1_CODEMP,
	BA1_MATRIC,BA1_TIPREG,0,BE4_DATPRO),' '),''  vProjeto /)<>0)) OR
	((0  sflagProj /=0) )
	)
	*/
	//BIANCHINI - 04/02/2020 - Retirado para melhor entendimento e implementação. Provavel ter que 
	//                         construir uma função 	
	//If !EMPTY(MV_PAR07)
	//	cQuery += " AND ( (('"+MV_PAR07+"'='2') AND                                              " + c_ent 
	//	cQuery += "        (BE4_TIPINT IN ('04','05','06','09','10','11'))) OR                   " + c_ent 
	//	cQuery += "       (('"+MV_PAR07+"'='1') )                                                " + c_ent 	
	//	cQuery += "     )  																		 " + c_ent 
	//Endif                                                                      	
	cQuery += "  AND BE4_SITUAC='1'                                                          " + c_ent 	
	cQuery += "  AND BE4_CODRDA=Nvl(Trim('"+MV_PAR03+"'),BE4_CODRDA)                               " + c_ent 	
	cQuery += "  AND BI3_FILIAL =BA1_FILIAL                                                  " + c_ent 	
	cQuery += "  AND BI3_CODINT=BA1_CODINT                                                   " + c_ent 	
	cQuery += "  AND BI3_CODIGO=NVL(TRIM(BA1_CODPLA),BA3_CODPLA)                             " + c_ent 	
	cQuery += "  AND BI3_VERSAO=Nvl(TRIM(BA1_VERSAO),BA3_VERSAO)                             " + c_ent 	
	cQuery += "  AND BE4_CODRDA=BAU_CODIGO                                                   " + c_ent 	
	cQuery += "  AND BAU_MUN=MU.BID_CODMUN                                                   " + c_ent 	
	cQuery += "  AND BE4_CANCEL <> '1'                                                       " + c_ent 	
	cQuery += "  AND BE4_STATUS <> '3'                                                       " + c_ent 	
	cQuery += "  AND BE4_TIPGUI = '03'                                                       " + c_ent 	  
	If     MV_PAR04 = "1"
		cQuery += " AND TO_DATE(TRIM(BE4_DTDIGI),'YYYYMMDD') BETWEEN TO_DATE('" + dToS(MV_PAR01) +"','YYYYMMDD') AND " + c_ent
		cQuery += "                                                  TO_DATE('" + dToS(MV_PAR02) +"','YYYYMMDD')     " + c_ent 
	Elseif MV_PAR04 = "2"  
		cQuery += " AND TO_DATE(TRIM(BE4_DATPRO),'YYYYMMDD') BETWEEN TO_DATE('" + dToS(MV_PAR01) +"','YYYYMMDD') AND " + c_ent
		cQuery += "                                                  TO_DATE('" + dToS(MV_PAR02) +"','YYYYMMDD')     " + c_ent 
	Elseif MV_PAR04 = "3"  
		cQuery += " AND TO_DATE(TRIM(BE4_PRVINT),'YYYYMMDD') BETWEEN TO_DATE('" + dToS(MV_PAR01) +"','YYYYMMDD') AND " + c_ent
		cQuery += "                                                  TO_DATE('" + dToS(MV_PAR02) +"','YYYYMMDD')     " + c_ent 
	Else
		cQuery += " AND TO_DATE(TRIM(BE4_XDTLIB),'YYYYMMDD') BETWEEN TO_DATE('" + dToS(MV_PAR01) +"','YYYYMMDD') AND " + c_ent
		cQuery += "                                                  TO_DATE('" + dToS(MV_PAR02) +"','YYYYMMDD')     " + c_ent 
	Endif		
	cQuery += " AND BAU_MUN=Nvl(trim('"+MV_PAR06+"'),BAU_MUN)                                 " + c_ent 
	If !Empty(MV_PAR08)
		cQuery += " AND ('"+MV_PAR08+"' = '4'                                                     " + c_ent 	
		cQuery += "      OR                                                                       " + c_ent 	
		cQuery += "      NVL(TRIM('"+MV_PAR08+"'),BE4_GRPINT) = BE4_GRPINT                        " + c_ent 	
		cQuery += "     )  																		  " + c_ent 	
	Endif                                                                       
	cQuery += " AND BE4_TIPINT = Nvl(Trim('"+MV_PAR09+"'),BE4_TIPINT)                         " + c_ent 	
	cQuery += " AND BE4_CODEMP=Nvl(Trim('"+MV_PAR10+"'),BE4_CODEMP)                           " + c_ent 	
	cQuery += " AND BA1_CODINT=BG9_CODINT  													  " + c_ent 
	cQuery += " AND BA1_CODEMP=BG9_CODIGO 													  " + c_ent 	
	cQuery += " AND BG9.D_E_L_E_T_ <> '*' 													  " + c_ent 	
	cQuery += " AND I.D_E_L_E_T_ <> '*'   													  " + c_ent 	
	cQuery += " AND A.D_E_L_E_T_ <> '*'   													  " + c_ent 	
	cQuery += " AND U.D_E_L_E_T_ <> '*'   													  " + c_ent 	
	cQuery += " AND F.D_E_L_E_T_ <> '*'   													  " + c_ent 	
	cQuery += " AND C.D_E_L_E_T_ <> '*'   													  " + c_ent 	
	cQuery += " AND P.D_E_L_E_T_ <> '*'   													  " + c_ent 	
	cQuery += " AND MU.D_E_L_E_T_ <> '*'  													  " + c_ent 	
	cQuery += " AND PR.D_E_L_E_T_ <> '*'  													  " + c_ent 

	memowrite("C:\TEMP\sql279.sql",cQuery)      

	If Select("R279") > 0
		dbSelectArea("R279")
		dbCloseArea()
	EndIf

	DbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),"R279",.T.,.T.)         

	For nI := 1 to 5
		IncProc('Processando...')
	Next

	If ! R279->(Eof())
		nSucesso := 0
		aCabec := {"DATA_DIGIT",;
				   "DATA_INTERN",;
				   "DATA_PREVISTA",;
				   "DATA_LIBERACAO",;
				   "GRP_INT",;
				   "TIPO_INTERNACAO",;
				   "COD_HOSP",;
				   "NOME_HOSP",;
				   "SENHA",;
				   "NUMINT",;
				   "BE4_YTRANS",;
				   "MATRIC",;
				   "NOME_ASS",;
				   "DIAS_INT",;
				   "INDIC_CLIN",;
				   "CR_SOLIC",;
				   "NOME_SOLIC",;
				   "ACOMODACAO",;
				   "OPER",;
				   "IDADE",;
				   "SEXO",;
				   "CID",;
				   "DESC_CID",;
				   "PLANO",;
				   "BAIRRO",;
				   "MUNICIPIO",;
				   "MUNIC_RDA",;
				   "UF_RDA",;
				   "PROJETO_ATIVOS",;
				   "LOCAL_MAT",;
				   "TOT_DIAS_INT",;
				   "DT_ALTA",;
				   "EMPRESA",;
				   "CONTATOS",;
				   "ACOMODACAO_REAL",;
				   "TIPADM",;
				   "CPF",;
				   "CODPROCPRIC",;
				   "DESCPROCPRINC",;
				   "GRPCOBPRPRINC"} 

		R279->(DbGoTop())
		While ! R279->(Eof()) 
			IncProc()		
			aaDD(aDados,{R279->DATA_DIGIT,;
						 R279->DATA_INTERN,;
						 R279->DATA_PREVISTA,;
						 R279->DATA_LIBERACAO,;
						 R279->GRP_INT,;
						 R279->TIPO_INTERNACAO,; 
						 "'"+R279->COD_HOSP,;
						 R279->NOME_HOSP,;
						 "'"+R279->SENHA,;
						 "'"+R279->NUMINT,;
						 R279->BE4_YTRANS,;
						 R279->MATRIC,;
						 R279->NOME_ASS,;
						 R279->DIAS_INT,;    
						 R279->INDIC_CLIN,;
						 R279->CR_SOLIC,;
						 R279->NOME_SOLIC,;
						 R279->ACOMODACAO,;
						 R279->OPER,;
						 R279->IDADE,;
						 R279->SEXO,;
						 R279->CID,R279->DESC_CID,;                                           
						 R279->PLANO,;
						 R279->BAIRRO,;
						 R279->MUNICIPIO,;
						 R279->MUNIC_RDA,;
						 R279->UF_RDA,;
						 R279->PROJETO_ATIVOS,;
						 R279->LOCAL_MAT,;
						 R279->TOT_DIAS_INT,;                 		
						 R279->DT_ALTA,;
						 R279->EMPRESA,;
						 R279->CONTATOS,;
						 R279->ACOMODACAO_REAL,;
						 R279->TIPADM,;
						 R279->CPF,;                            
						 R279->CODPROCPRIC,;
						 R279->DESCPROCPRINC,;
						 R279->GRPCOBPRPRINC})  		
			R279->(DbSkip())
		End

		//Abre excel 
		DlgToExcel({{"ARRAY"," " ,aCabec,aDados}})

	EndIf	

	If Select("R279") > 0
		dbSelectArea("R279")
		dbCloseArea()
	EndIf      

	*************************************************************************************************************************

Static Function AjustaSX1      
	/*
	Local aHelpPor := {}

	u_CABASX1(cPerg,"01","Data Inicial"      ,"","","mv_ch01","D",10,0,0,"G","","mv_par01","","","","","","","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "99/99/9999", "" ) 
	u_CABASX1(cPerg,"02","Data Final  "      ,"","","mv_ch02","D",10,0,0,"G","","mv_par02","","","","","","","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "99/99/9999", "" )
	u_CABASX1(cPerg,"03","Cod. RDA    "      ,"","","mv_ch03","C",06,0,0,"G","","mv_par03","","","","","","","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "9999", "" )
	u_CABASX1(cPerg,"04","Tipo        "      ,"","","mv_ch04","C",01,0,0,"G","","mv_par04","","","","","","","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "9999", "" )
	u_CABASX1(cPerg,"05","Operadora   "      ,"","","mv_ch05","C",01,0,0,"G","","mv_par05","","","","","","","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "9999", "" )
	u_CABASX1(cPerg,"06","Municipio   "      ,"","","mv_ch06","C",07,0,0,"G","","mv_par06","","","","","","","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "9999", "" )
	u_CABASX1(cPerg,"07","UTI         "      ,"","","mv_ch07","C",01,0,0,"G","","mv_par07","","","","","","","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "9999", "" )
	u_CABASX1(cPerg,"08","Grp. Intern."      ,"","","mv_ch08","C",01,0,0,"G","","mv_par08","","","","","","","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "9999", "" )
	u_CABASX1(cPerg,"09","Tipo Intern."      ,"","","mv_ch09","C",02,0,0,"G","","mv_par09","","","","","","","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "9999", "" )
	u_CABASX1(cPerg,"10","Cod. Emp.   "      ,"","","mv_ch10","C",04,0,0,"G","","mv_par10","","","","","","","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "9999", "" )
	u_CABASX1(cPerg,"11","Admissao    "      ,"","","mv_ch11","C",01,0,0,"G","","mv_par11","","","","","","","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "9999", "" )

	*/		

Return	