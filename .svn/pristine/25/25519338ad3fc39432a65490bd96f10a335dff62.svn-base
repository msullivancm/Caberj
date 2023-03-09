#INCLUDE "rwmake.ch"
#INCLUDE "protheus.ch"
#INCLUDE "TopConn.ch"
#include "TBICONN.CH"

#DEFINE c_ent CHR(13) + CHR(10)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABR229      ºAutor  ?SERGIO CUNHA       ?Data ?ABR/2015    º±?
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ? GERA PLANILHA DE REEMBOLSO  								 º±?
±±?         ? 		                                                     º±?
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ?Projeto CABERJ                                                º±?
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function CABR229()

Processa({||PCABR229()},'Processando...')

Return

Static Function PCABR229

Local aSaveArea	:= {}

Local aCabec := {}
Local aDados := {}
Local nI 	  := 0
Local c_AnoDe:= ' '
Local c_MesDe := ' '
Local c_AnoAte := ' '
Local c_MesAte := ' '
Local c_Codrda := ' '
Local c_Emp 	:= IIF(cempant = '01', "C", "I")
Local c_Emp2 	:= IIF(cempant = '01', "CABERJ", "INTEGRAL")
Local nHandle := 0

Private cPerg := "CABR229"

AjustaSX1(cPerg)

If Pergunte(cPerg,.T.)
	
	c_Codrda := mv_par01
	c_AnoDe  := mv_par02
	c_MesDe  := mv_par03
	c_AnoAte := mv_par04
	c_MesAte := mv_par05
	
else
	Return
EndIf

/*Monta query */
cQuery :="SELECT  CODRDA,																								"+c_ent
cQuery +="        PLS_RETORNA_NOME_RDA (CODRDA,'" + c_Emp + "') DESC_RDA,                                               "+c_ent   
cQuery +="  	  REMESSA,																								"+c_ent   
cQuery +="        COMPETENCIA,                                                                                          "+c_ent
cQuery +="        CASE                                                                                                  "+c_ent
cQuery +="            WHEN STATUS_REMESSA = 'CPR' THEN 'COMPR PROT REMESSA'                                             "+c_ent
cQuery +="            WHEN STATUS_REMESSA = 'PPR' THEN 'PREVIA PROT REMESSA'                                            "+c_ent
cQuery +="            WHEN STATUS_REMESSA = 'CCA' THEN 'COMPROVANTE CANCELADO'                                          "+c_ent
cQuery +="        ELSE                                                                                                  "+c_ent
cQuery +="            'PREVIA CANCELADA'                                                                                "+c_ent
cQuery +="        END  STATUS_REMESSA,                                                                                  "+c_ent
cQuery +="        ZRW_VLTGUI VLR_XML,                                                                                   "+c_ent
cQuery +="       UPPER(ANALISTA) ANALISTA,                                                                              "+c_ent
cQuery +="        XML,                                                                                                  "+c_ent
cQuery +="        CASE                                                                                                  "+c_ent
cQuery +="            WHEN STATUS_REMESSA = 'CPR' THEN PBH.PBH_PATHAR                                                   "+c_ent
cQuery +="            WHEN STATUS_REMESSA = 'PPR' THEN 'REMESSA COM STATUS DE PREVIA'                                   "+c_ent
cQuery +="            WHEN STATUS_REMESSA = 'CCA' THEN 'COMPROVANTE CANCELADO'                                          "+c_ent
cQuery +="        ELSE                                                                                                  "+c_ent
cQuery +="            'PREVIA CANCELADA'                                                                                "+c_ent
cQuery +="        END PASTA                                                                                             "+c_ent
cQuery +="FROM                                                                                                          "+c_ent
cQuery +="  (                                                                                                           "+c_ent
cQuery +="   SELECT A.CODRDA,ZZP_STATUS STATUS_REMESSA, ZRW_VLTGUI,ANALISTA , UPPER(A.XML) XML,ZZP_NUMREM REMESSA, ZZPREFER COMPETENCIA"+c_ent
cQuery +="    FROM                                                                                                      "+c_ent
cQuery +="    (                                                                                                         "+c_ent
cQuery +="      SELECT ZRW.*,ZZP_STATUS,ZZP_CODRDA CODRDA,                                                              "+c_ent
cQuery +="        ZRW_XML XML ,                                                                                         "+c_ent
cQuery +="        ZZP.ZZP_ANOPAG||ZZP.ZZP_MESPAG ZZPREFER,                                                              "+c_ent
cQuery +="        ZZP_NUMREM,                                                                                           "+c_ent  
cQuery +="        ZZP_CODANA||' - '||ZZP_NOMANA ANALISTA                                                                "+c_ent    
cQuery +="      FROM "+RetSqlName('ZRW') +" ZRW                                                                         "+c_ent
cQuery +="      INNER JOIN "+RetSqlName('ZZP') +" ZZP ON ZZP_NUMREM = ZRW_NUMREM                                        "+c_ent
cQuery +="        AND ZZP_IDOPER = ZRW_IDTOTA                                                                           "+c_ent
cQuery +="      WHERE ZZP.D_E_L_E_T_ = ' '                                                                              "+c_ent
cQuery +="        AND ZRW.D_E_L_E_T_ = ' '                                                                              "+c_ent
If !EMPTY(c_Codrda)
cQuery +="        AND ZZP_CODRDA  = '"+c_Codrda+"'                                                                      "+c_ent   
EndIf
If !EMPTY(c_Codrda) .and. !EMPTY(c_AnoDe)
cQuery +="        AND ZZP.ZZP_ANOPAG BETWEEN '"+c_AnoDe+"' and '"+c_AnoAte +"'                                          "+c_ent    
EndIf
If !EMPTY(c_MesDe) .and. !EMPTY(c_MesAte)
EndIf
cQuery +="        AND ZZP.ZZP_MESPAG BETWEEN '"+c_MesDe+"' and '"+c_MesAte+"'                                           "+c_ent
cQuery +="    ) A                                                                                                       "+c_ent
cQuery +="    WHERE NOT EXISTS                                                                                          "+c_ent
cQuery +="    (                                                                                                         "+c_ent
cQuery +="      SELECT 1                                                                                                "+c_ent
cQuery +="      FROM SIGA."+RetSqlName('BXX') +" BXX                                                                    "+c_ent
cQuery +="      WHERE BXX.BXX_CODRDA = A.CODRDA                                                                         "+c_ent
cQuery +="        AND TRIM(UPPER(BXX.BXX_ARQIN)) = TRIM(UPPER(A.XML))                                                   "+c_ent
cQuery +="        AND BXX.D_E_L_E_T_ = ' '                                                                              "+c_ent
cQuery +="        AND BXX.BXX_DATMOV LIKE ZZPREFER||'%'                                                                 "+c_ent
cQuery +="    )                                                                                                         "+c_ent
cQuery +="  ) B                                                                                                         "+c_ent
cQuery +="  INNER JOIN PBH010 PBH ON B.CODRDA = PBH.PBH_CODRDA                                       				   "+c_ent
cQuery +="    AND TRIM(B.XML) = TRIM(PBH.PBH_XML)                                                                       "+c_ent
cQuery +="    AND PBH.D_E_L_E_T_ = ' '                                                                                  "+c_ent
cQuery +="    AND PBH.R_E_C_N_O_ =                                                                                      "+c_ent
cQuery +="    (                                                                                                         "+c_ent
cQuery +="      SELECT MAX(PBHB.R_E_C_N_O_)                                                                             "+c_ent
cQuery +="		FROM PBH010 PBHB  	   																					"+c_ent
cQuery +="      WHERE PBHB.PBH_FILIAL = ' '                                                                             "+c_ent
cQuery +="        AND TRIM(B.XML) = TRIM(PBHB.PBH_XML)                                                                  "+c_ent
cQuery +="        AND PBHB.D_E_L_E_T_ = ' '                                                                             "+c_ent
cQuery +="    )                                                                                                         "+c_ent
cQuery +="WHERE                                                                                                         "+c_ent
cQuery +="  PBH.PBH_FILIAL = ' '                                                                                        "+c_ent
cQuery +="  AND PBH.PBH_EMPRES = '" + c_Emp2 + "'                                                                        "+c_ent
cQuery +="  AND PBH.D_E_L_E_T_ = ' '                                                                                    "+c_ent
cQuery +="ORDER BY 1, 3 DESC                                                                                            "+c_ent

memowrite("C:\temp\CABR229.sql",cQuery)

If Select("R229") > 0
	dbSelectArea("R229")
	dbCloseArea()
EndIf

DbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),"R229",.T.,.T.)

For nI := 1 to 5
	IncProc('Processando...')
Next

If ! R229->(Eof())
	nSucesso := 0
	// Monta Cabecalho "Fixo"
	aCabec :=  {"CODRDA","DESC_RDA","REMESSA","COMPETENCIA","STATUS_REMESSA","VLR_XML","ANALISTA ","XML","PASTA"}  
		
	// Nome do arquivo criado, o nome é composto por uma descrição
	//a data e a hora da criação, para que não existam nomes iguais
	If !ApOleClient("MSExcel")
		cNomeArq := "C:\TEMP\Relatorio_"+SubStr(DtoS(date()),7,2)+"_"+SubStr(DtoS(date()),5,2)+"_"+SubStr(DtoS(date()),1,4)+"_"+STRTRAN(TIME(),":","_")+".csv"
		
		// criar arquivo texto vazio a partir do root path no servidor
		
		nHandle := FCREATE(cNomeArq)
		
		If nHandle > 0
			
			cMontaTxt := "CODRDA;"
			cMontaTxt += "DESC_RDA;"  
	   		cMontaTxt += "REMESSA;"
			cMontaTxt += "COMPETENCIA ;"
			cMontaTxt += "STATUS_REMESSA ;"  
			cMontaTxt += "VLR_XML ;"    
			cMontaTxt += "ANALISTA ;"		
			cMontaTxt += "XML ;"
			cMontaTxt += "PASTA;"
			cMontaTxt += CRLF // Salto de linha para .csv (excel)
			
			FWrite(nHandle,cMontaTxt)
			
		EndIf
		
	EndIf
	
	R229->(DbGoTop())
	While ! R229->(Eof())
		
		AADD(aDados,{R229->CODRDA,R229->DESC_RDA,R229->REMESSA,R229->COMPETENCIA,R229->STATUS_REMESSA,R229->XML,R229->PASTA})
		
		If !ApOleClient("MSExcel")
			
			If nHandle > 0
				
				cMontaTxt := R229->CODRDA+ ";"
				cMontaTxt += R229->DESC_RDA+ ";"
				cMontaTxt += R229->REMESSA+ ";"
				cMontaTxt += R229->COMPETENCIA + ";"
				cMontaTxt += R229->STATUS_REMESSA + ";" 
				cMontaTxt += R229->VLR_XML + ";"    
				cMontaTxt += R229->ANALISTA + ";"	
				cMontaTxt += R229->XML+ ";"
				cMontaTxt += R229->PASTA + ";"
				cMontaTxt += CRLF // Salto de linha para .csv (excel)
				
				FWrite(nHandle,cMontaTxt)
				
			EndIf
			
		EndIf
		
		R229->(DbSkip())
		
		c_Cc := ' '
		c_CcDesc := ' '
		
	EndDo
	
	If Select("R229") > 0
		dbSelectArea("R229")
		dbCloseArea()
	EndIf
	
	_cTit := "XML" + " Gerando em" + REPLACE(DTOC(DDATABASE),"/","_") + " AS " + Time()
	
	//Abre excel
	If ApOleClient("MSExcel")
		
		DlgToExcel({{"ARRAY",_cTit,aCabec,aDados}})
						
	else        
	
		If nHandle > 0
			
			// encerra gravação no arquivo
			FClose(nHandle)
			
			MsgAlert("Relatorio salvo em: "+cNomeArq)
			
		Else
			
			Aviso("Atenção","Arquivo nao pode ser criado, favor visualizar a pasta.",{"OK"})
			
		EndIf
		
	EndIf
	
EndIf

If Select("R229") > 0
	dbSelectArea("R229")
	dbCloseArea()
EndIf


//*************************************************************************************************************************
//AJUSTAR "COPPRO"
Static Function AjustaSX1

Local aHelpPor := {}
//Monta Help


PutSx1(cPerg,"01","RDA"	 				,"","","mv_ch1","C",06,0,0,"G","","","","","mv_par01","","","","","","","","","","","","","","","","",aHelpPor,{},{})
PutSx1(cPerg,"02","Ano Compt de:" 		,"","","mv_ch2","C",04,0,0,"G","","","","","mv_par02","","","","","","","","","","","","","","","","",aHelpPor,{},{})
PutSx1(cPerg,"03","Mes Compt de:" 		,"","","mv_ch3","C",02,0,0,"G","","","","","mv_par03","","","","","","","","","","","","","","","","",aHelpPor,{},{})
PutSx1(cPerg,"04","Ano Compt ate:" 		,"","","mv_ch4","C",04,0,0,"G","","","","","mv_par04","","","","","","","","","","","","","","","","",aHelpPor,{},{})
PutSx1(cPerg,"05","Mes Compt ate:" 		,"","","mv_ch5","C",02,0,0,"G","","","","","mv_par05","","","","","","","","","","","","","","","","",aHelpPor,{},{})


Return
