#INCLUDE "rwmake.ch"
#INCLUDE "protheus.ch"
#INCLUDE "TopConn.ch"
#include "TBICONN.CH"    

#DEFINE c_ent CHR(13) + CHR(10)

/*                                        
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABR155      ºAutor  ³ Marcela Coimbra    º Data ³ 28/08/2015  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³  Maprec Integral                                              º±± 
±±º          ³  		                                                     º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Projeto CABERJ                                                                                                                                                                                                                                                                                                                                                                                                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±'±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function CABR233()    
      
Processa({||PCABR233()},'Processando...')

Return

Static Function PCABR233()
	
	Local aSaveArea	:= {} 
	
	Local a_Cabec 		:= {}
	Local a_Dados 		:= {}   
	Local a_Item 		:= {}   
	Local a_DadosTmp 	:= {}   
	Local n_Cont  		:= 1	
	Private cPerg 		:= "CABG233"
	Private cQuery		:= ""
	 
	AjustaSX1(cPerg)
		
	If Pergunte(cPerg,.T.)  
	
		c_EmpDe		:= Mv_Par01  
		c_EmpAte	:= Mv_Par02  
		c_CompDe	:= Mv_Par03  
		c_CompAte	:= Mv_Par04  
	   
	else
	
	    Return	
	
	EndIf    

	a_Cabec := {	"GRUPOPLANO",;
					"PLANO",;
					"MATRIC",;
					"NOME",;
					"MUDA FAIXA",;
					"FAIXA COBRADA",;
					"TIPREG",;
					"MATRIC",;
					"CODEMP",;
					"CODINT",;
					"IDADE",;
					"DATA_NASCIMENTO",;
					"DATA INCLUSAO",;
					"MOTIVO BLOQUEIO",;
					"DATA BLOQUEIO",;
					"CODTIP",;
					"COBRANCA",;
					"DAT_REAJUS",;
					"MESES_CONTR",;
					"MESREA",;
					"INDREA",;
					"TIPPAG",;
					"OBS",;
					"MUDAFAIXA",;
					"CODFAI" }
	    
	c_CompDet 	:= c_CompDe   
	c_Pivot 	:= "'" + c_CompDet  + "', "   
	c_Pivot2 	:= '"' + "'" + c_CompDet  + "'" + '"' + " C_"+c_CompDet + ", "   

	aadd(a_Cabec, "'" + c_CompDet + "'" )
	aadd(a_Item	, "R233->C_" + c_CompDet  )
				
	While c_CompDet <> c_CompAte   
	     
		c_CompDet :=  soma1(c_CompDet) 
		
		If  SUBSTR( c_CompDet, 5, 2 ) <= '12'  .AND. SUBSTR( c_CompDet, 5, 2 ) <> '00'
			
			c_Pivot 	+= "'" + c_CompDet  + "', "        
			c_Pivot2 	+= '"' + "'" + c_CompDet  + "'" + '"' + " C_"+c_CompDet + ", "         
			
			aadd(a_Cabec, "'" + c_CompDet + "'" )
			aadd(a_Item	, "R233->C_" + c_CompDet  )  
			
		EndIf
		
	EndDo  
	
	c_Pivot  := substr(c_Pivot , 1, len(c_Pivot) - 2) + " "
  	c_Pivot2 := substr(c_Pivot2, 1, len(c_Pivot2) - 2) + " "
	
	cQuery := " SELECT A.*, " + c_Pivot2 + " "+ c_ent
	cQuery += " FROM (   " + c_ent
	cQuery += " select RETORNA_GRUPO_PLANO_MS('I',BA1_CODINT,BA1_CODEMP,BA1_MATRIC,BA1_TIPREG) GRUPOPLANO, "  + c_ent
	cQuery += "              RETORNA_DESC_PLANO_MS('I',BA1_CODINT,BA1_CODEMP,BA1_MATRIC,BA1_TIPREG) PLANO, "  + c_ent                                   
	cQuery += "              (BA1_CODINT||BA1_CODEMP||BA1_MATRIC||BA1_TIPREG||BA1_DIGITO) MATRIC, "+ c_ent
	cQuery += "              BA1_NOMUSR NOME, BA1_MUDFAI, BA1_FAICOB, BA1_TIPREG, BA1_MATRIC, BA1_CODEMP, BA1_CODINT, "+ c_ent
	cQuery += "              IDADE_S(BA1_DATNAS) IDADE, "+ c_ent
	cQuery += "              FORMATA_DATA_MS(BA1_DATNAS) DATNAS, "+ c_ent
	cQuery += "              FORMATA_DATA_MS(BA1_DATINC) DATINC, "+ c_ent
	cQuery += "              BA1_MOTBLO MOTBLO, "+ c_ent
	cQuery += "              FORMATA_DATA_MS(NVL(TRIM(BA1_DATBLO),BA3_DATBLO)) DATBLO, "+ c_ent
	cQuery += "              BM1_CODTIP CODTIP, "+ c_ent
	cQuery += "              BM1_CODTIP||'-'||BFQ_DESCRI COBRANCA, "+ c_ent
	cQuery += "              TO_DATE(TRIM(BA3_DATCIV),'YYYYMMDD') DAT_REAJUS, "+ c_ent
	cQuery += "              TRUNC(MONTHS_BETWEEN(TO_DATE('01/05/2013','DD/MM/YYYY'), "+ c_ent                                      
	cQuery += "                                   TO_DATE(TRIM(BA3_DATCIV),'YYYYMMDD'))) MESES_CONTR, " + c_ent
	cQuery += "              BA3_MESREA MESREA, " + c_ent
	cQuery += "              BA3_INDREA INDREA,  " + c_ent
                                   
	cQuery += "              DECODE(BA3_TIPPAG,'00','SEM ENVIO', " + c_ent
	cQuery += "                                '01','PREVI', " + c_ent
	cQuery += "                                '02','LIQ', "+ c_ent                                     
	cQuery += "                                '03','EMP',  "+ c_ent                                    
	cQuery += "                                '04','112',  "+ c_ent                                    
	cQuery += "                                '05','175',  "+ c_ent                                    
	cQuery += "                                '06','SISDEB', "+ c_ent                                     
	cQuery += "                                '07','ITAU',   "+ c_ent                                   
	cQuery += "                                '08','PREVI','') TIPPAG, "+ c_ent
	cQuery += "              DECODE(BM1_CODTIP,'101','','') OBS, "+ c_ent
	cQuery += "              DECODE(BA1_MUDFAI,'0','NAO','1','SIM','SIM') MUDAFAIXA, "+ c_ent                                      
	cQuery += "              BM1_CODFAI CODFAI, "+ c_ent
	cQuery += "              BM1_ANO||BM1_MES ANOMES, "+ c_ent
	cQuery += "              sum( (DECODE(BM1_TIPO,'1',1,-1) * BM1_VALOR )) VALOR "+ c_ent
             
	cQuery += "                     from   SIGA." + RETSQLNAME("BM1") + " BM1, SIGA." + RETSQLNAME("BA3") + " BA3, SIGA." + RETSQLNAME("BA1") + " BA1, SIGA." + RETSQLNAME("BFQ") + " BFQ "+ c_ent
	cQuery += "       where  BM1_FILIAL = '  ' "+ c_ent                                        
	cQuery += "       and    BM1_CODINT = '0001' "+ c_ent                                      
	cQuery += "       and    BM1_CODEMP >= '" + c_EmpDe  + "' "+ c_ent                                        
	cQuery += "       and    BM1_CODEMP <= '" + c_EmpAte + "' "+ c_ent                                        
	cQuery += "       and    BM1_ANO||BM1_MES between '" + c_CompDe + "' and '" + c_CompAte + "' "+ c_ent
                                                   
	cQuery += "       and    BA1_FILIAL = BM1_FILIAL "+ c_ent                                     
	cQuery += "       and    BA1_CODINT = BM1_CODINT "  + c_ent                                    
	cQuery += "       and    BA1_CODEMP = BM1_CODEMP " + c_ent                                    
	cQuery += "       and    BA1_MATRIC = BM1_MATRIC "+ c_ent                                     
	cQuery += "       and    BA1_TIPREG = BM1_TIPREG "  + c_ent                                   
                        
//	cQuery += "       and    NVL(TRIM(BA1_CODPLA),BA3_CODPLA) = NVL(TRIM(''),NVL(TRIM(BA1_CODPLA),BA3_CODPLA))  "  + c_ent                                  
//	cQuery += "       and    ('' is null or (INSTR('',RETORNA_GRUPO_PLANO_COD_MS('I',NVL(TRIM(BA1_CODPLA),BA3_CODPLA))) > 0)) "   + c_ent                                                       
	cQuery += "       and    BA1_FILIAL = BA3_FILIAL " + c_ent                                    
	cQuery += "       and    BA1_CODINT = BA3_CODINT "  + c_ent                                   
	cQuery += "       and    BA1_CODEMP = BA3_CODEMP "  + c_ent                                  
	cQuery += "       and    BA1_MATRIC = BA3_MATRIC " + c_ent                                    
	cQuery += "       and    BFQ_FILIAL = BM1_FILIAL "   + c_ent                                  
	cQuery += "       and    BFQ_CODINT = BM1_CODINT "   + c_ent                                  
	cQuery += "       and    BFQ_PROPRI = SUBSTR(BM1_CODTIP,1,1) "+ c_ent
	cQuery += "       and    BFQ_CODLAN = SUBSTR(BM1_CODTIP,2,3) " + c_ent                                    
	cQuery += "       and    BFQ_YTPANL = 'M' "+ c_ent                                       
	cQuery += "       and    BM1_CODTIP not in ('102','103') "    + c_ent                                 
	cQuery += "       and    BA3_MESREA = NVL(TRIM(''),BA3_MESREA) "  + c_ent            
                    
                                  
	cQuery += "       and    BM1.D_E_L_E_T_ = ' ' "   + c_ent                                   
	cQuery += "       and    BA3.D_E_L_E_T_ = ' ' "   + c_ent                                  
	cQuery += "       and    BA1.D_E_L_E_T_ = ' ' "   + c_ent                                  
	cQuery += "       and    BFQ.D_E_L_E_T_ = ' ' "   + c_ent                                  
	cQuery += "       group by  RETORNA_GRUPO_PLANO_MS('I',BA1_CODINT,BA1_CODEMP,BA1_MATRIC,BA1_TIPREG) , "  + c_ent                                   
	cQuery += "              RETORNA_DESC_PLANO_MS('I',BA1_CODINT,BA1_CODEMP,BA1_MATRIC,BA1_TIPREG) , "+ c_ent                                     
	cQuery += "              (BA1_CODINT||BA1_CODEMP||BA1_MATRIC||BA1_TIPREG||BA1_DIGITO) , "  + c_ent                                   
	cQuery += "              BA1_NOMUSR , BA1_MUDFAI, BA1_FAICOB, BA1_TIPREG, BA1_MATRIC, BA1_CODEMP, BA1_CODINT,  "  + c_ent                                 
	cQuery += "              IDADE_S(BA1_DATNAS) , "  + c_ent                                                                      
	cQuery += "              FORMATA_DATA_MS(BA1_DATNAS) , "    + c_ent                                 
	cQuery += "              FORMATA_DATA_MS(BA1_DATINC) , "    + c_ent                                 
	cQuery += "              BA1_MOTBLO , "    + c_ent                                 
	cQuery += "              FORMATA_DATA_MS(NVL(TRIM(BA1_DATBLO),BA3_DATBLO)) , "   + c_ent                                  
	cQuery += "              BM1_CODTIP , " + c_ent                                    
	cQuery += "              BM1_CODTIP||'-'||BFQ_DESCRI ,    "+ c_ent                                  
	cQuery += "              TO_DATE(TRIM(BA3_DATCIV),'YYYYMMDD') , "    + c_ent                                 
	cQuery += "              TRUNC(MONTHS_BETWEEN(TO_DATE('01/05/2013','DD/MM/YYYY'), "    + c_ent                                 
	cQuery += "                                   TO_DATE(TRIM(BA3_DATCIV),'YYYYMMDD'))) , "   + c_ent                                  
	cQuery += "              BA3_MESREA , "   + c_ent                                  
	cQuery += "              BA3_INDREA , "    + c_ent                

	cQuery += "              DECODE(BA3_TIPPAG,'00','SEM ENVIO',  "  + c_ent                                  
	cQuery += "                                '01','PREVI',  "   + c_ent                                 
	cQuery += "                                '02','LIQ', " + c_ent                                    
	cQuery += "                                '03','EMP', "   + c_ent                                  
	cQuery += "                                '04','112', "    + c_ent                                 
	cQuery += "                                '05','175',  "  + c_ent                                  
	cQuery += "                                '06','SISDEB', " + c_ent                                    
	cQuery += "                                '07','ITAU',  "   + c_ent                                 
	cQuery += "                                '08','PREVI','') ,  " + c_ent                                   
	cQuery += "              DECODE(BM1_CODTIP,'101','','') ,  "   + c_ent                                 
	cQuery += "              DECODE(BA1_MUDFAI,'0','NAO','1','SIM','SIM') ,   "  + c_ent                                 
	cQuery += "              BM1_CODFAI ,  "   + c_ent
	cQuery += "              BM1_ANO||BM1_MES     "    + c_ent                                           
	cQuery += "        order by (case when BA3_MESREA >= '08' then 0 else 1 end),BA3_MESREA,1,2,3,4,5,6,7,8,17 "   + c_ent                                 
	cQuery += "        )         "+ c_ent
	cQuery += "        PIVOT ( SUM(VALOR)  "+ c_ent
	cQuery += "               FOR ANOMES in( " + c_Pivot + ")  ) A "  + c_ent
	
	
	MemoWrite( "c:\temp\cabr233_sql.sql" , cQuery )
  	
  	cQuery := ChangeQuery( cQuery )
	DbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),"R233",.T.,.T.)         

	// Monta Cabecalho "Fixo"
			
		While ! R233->(Eof()) 
		                                      
			IncProc()  
			a_DadosTmp := {}
			
			AADD(a_DadosTmp,"'"+R233->GRUPOPLANO) 
			AADD(a_DadosTmp,"'"+R233->PLANO)
			AADD(a_DadosTmp,"'" + R233->MATRIC)
			AADD(a_DadosTmp,R233->NOME)
			AADD(a_DadosTmp,"'"+R233->BA1_MUDFAI)
			AADD(a_DadosTmp,"'"+R233->BA1_FAICOB)
			AADD(a_DadosTmp,"'"+R233->BA1_TIPREG)
			AADD(a_DadosTmp,"'"+R233->BA1_MATRIC)
			AADD(a_DadosTmp,"'"+R233->BA1_CODEMP)
			AADD(a_DadosTmp,"'"+R233->BA1_CODINT)
			AADD(a_DadosTmp,R233->IDADE)
			AADD(a_DadosTmp,R233->DATNAS)
			AADD(a_DadosTmp,R233->DATINC) 
			AADD(a_DadosTmp,"'"+R233->MOTBLO) 
			AADD(a_DadosTmp,R233->DATBLO)
			AADD(a_DadosTmp,"'"+R233->CODTIP)
			AADD(a_DadosTmp,"'"+R233->COBRANCA)
			AADD(a_DadosTmp,R233->DAT_REAJUS)
			AADD(a_DadosTmp,R233->MESES_CONTR)
			AADD(a_DadosTmp,"'"+R233->MESREA)
			AADD(a_DadosTmp,"'"+R233->INDREA)
			AADD(a_DadosTmp,"'"+R233->TIPPAG)
			AADD(a_DadosTmp,R233->OBS)
			AADD(a_DadosTmp,"'"+R233->MUDAFAIXA)
			AADD(a_DadosTmp,"'"+R233->CODFAI)
			
			for n_Count := 1 to Len(a_Item) 
			
				AADD(a_DadosTmp,&(a_Item[n_Count]))
						 
			Next 
			
			aadd( a_Dados, a_DadosTmp )						 
			
			R233->(DbSkip())       
			
		EndDo

	aAdd(a_Dados ,{"Fim"} )
	//Abre excel 
    DlgToExcel({{"ARRAY"," " ,a_Cabec,a_Dados}})
If Select("R233") > 0
	dbSelectArea("R233")
	dbCloseArea()
EndIf      

*************************************************************************************************************************
//AJUSTAR "COPPRO"
Static Function AjustaSX1()      

 
Local aHelpPor := {}
//Monta Help

PutSx1(cPerg,"01","Empresa de:  "  		,"","","mv_ch01","C",04,0,0,"C","","","","","mv_par01","","","","","","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"02","Empresa ate: "  		,"","","mv_ch02","C",04,0,0,"C","","","","","mv_par02","","","","","","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"03","Competencia de:  "  	,"","","mv_ch03","C",06,0,0,"C","","","","","mv_par02","","","","","","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"04","Competencia ate:"  	,"","","mv_ch04","C",06,0,0,"C","","","","","mv_par02","","","","","","","","","","","","","","","","",{},{},{})

Return	