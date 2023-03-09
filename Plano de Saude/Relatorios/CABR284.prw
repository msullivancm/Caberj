#INCLUDE "rwmake.ch"
#INCLUDE "protheus.ch"
#INCLUDE "TopConn.ch"
#include "TBICONN.CH"    

#DEFINE c_ent CHR(13) + CHR(10)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABR284      ºAutor  ³ ANDERSON RANGEL   º Data ³ FEVEREIRO/21 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³  GERA PLANILHAS PARA CONFERENCIA DO CONTAS MEDICAS            º±± 
±±º          ³  REEMBOLSO / ANALISE DE GLOSAS / GRUPO ANALISTA               º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³  Projeto CABERJ                                               º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function CABR284()

    //Monta Tela Inicial
    Local lOk 	:= .F.
    Local aOpc  := {'Relatório Reembolso','Relatório Analise de Glosas','Relatório Grupo Analista'}
    Private cOpcCombo
	Private cMes    := " "  
    Private cAno    := " "  
	Private cEmp    := 0
	Private cPergAb := "ACAB284"
	Private cPergC 	:= "CCAB284"

    SetPrvt("oDlg1","oSBtn1","oCBox1")

    oDlg1      := MSDialog():New( 095,232,260,493,"Relatórios Contas Médicas",,,.F.,,,,,,.T.,,,.T. )
    oCBox1     := TComboBox():New( 012,012,{|u| If(PCount()>0,cOpcCombo:=u,cOpcCombo)},aOpc,108,010,oDlg1,,,,CLR_BLACK,CLR_WHITE,.T.,,"",,,,,,,cOpcCombo )
    oSBtn1     := SButton():New( 052,094,1,{||oDlg1:End(),lOk:=.T.},oDlg1,,"", )
    oDlg1:Activate(,,,.T.)

	If lOk

        Do Case

            Case cOpcCombo == aOpc[1]
				
				AjustaSX1() 
				
				//ler parametros 
				If Pergunte(cPergAb,.T.)  
					cMes    := mv_par01 
					cAno    := mv_par02 
					
					//Processo Relatório
					Processa({||ACABR284()},'Gerando Relatório Reembolso...')
				else

					Return	
				
				EndIf 

            Case cOpcCombo == aOpc[2]

				AjustaSX1() 
				
				//ler parametros 
				If Pergunte(cPergAb,.T.)  
					cMes    := mv_par01 
					cAno    := mv_par02 
					
					//Processo Relatório
					Processa({||BCABR284()},'Gerando Relatório Analise de Glosas...')
				else

					Return	
				
				EndIf

            Case cOpcCombo == aOpc[3]

				AjustaSX1b() 
				
				//ler parametros 
				If Pergunte(cPergC,.T.)  
					cEmp    := mv_par01 
					
					//Processo Relatório
					Processa({||CCABR284()},'Gerando Relatório Grupo Analista...')
				else

					Return	
				
				EndIf				   

        EndCase

    EndIf

Return

***********************************************************************************************************
Static Function ACABR284

Local aSaveArea	:= {} 
Local aCabec := {}
Local aDados := {} 
//Local cMes    := " "  
//Local cAno    := " "  
Local nI 	  := 0     
Local cCodope := PLSINTPAD()
Local R284  := GetNextAlias()

aSaveArea	:= GetArea() 

//Monta query 
cQuery := " SELECT * FROM (  " + c_ent
cQuery += " 		SELECT SUBSTR(B44_YDTCON,1,6) REF,  " + c_ent
cQuery += " 		ZZQ_SEQUEN PROTOC,  " + c_ent
cQuery += " 		TO_DATE(TRIM(B44_DATREC),'YYYYMMDD') DT_RECEB,  " + c_ent
cQuery += " 		NVL(TRIM(BA1_CODPLA),BA3_CODPLA)  PLANO,  " + c_ent   
cQuery += " 		BD6_YNEVEN CODEVENTO,   " + c_ent
cQuery += " 		ZZT_EVENTO NOME_EVENTO,  " + c_ent   
cQuery += " 		COUNT(DISTINCT B44_OPEUSR||B44_CODEMP||B44_MATRIC||B44_TIPREG) QTDE,  " + c_ent   
cQuery += " 		SUM(B45_QTDPRO) OCORRENCIA,  " + c_ent
cQuery += " 		SUM(B45_QTDPRO*B45_VLRAPR) VL_INFORMADO,  " + c_ent    
cQuery += " 		SUM(BD6_VLRBPR) VL_PROCESSADO,  " + c_ent   
cQuery += " 		SUM(B45_VLRGLO) GLOSADO,  " + c_ent   
cQuery += " 		SUM(B45_VLRPAG) VAL_APROV,  " + c_ent   
cQuery += " 		0 VL_PARTICIPACAO,     " + c_ent
cQuery += " 		SIGA_TIPO_EXPOSICAO_ANS(B44_CODEMP,B44_MATRIC,B44_TIPREG,TO_DATE(TRIM(B44_DATPRO),'YYYYMMDD')) EXPOSICAO_ANS,    " + c_ent 
cQuery += " 		RETORNA_DESCRI_GRUPO_PLANO ( TRIM(BI3_YGRPLA),B44_CODEMP,'C') GRUPO_PLANO,  " + c_ent   
cQuery += " 		BI3_NREDUZ NOME_PLANO,   " + c_ent  
cQuery += " 		ZZT_TPCUST TIPO_CUSTO,   " + c_ent  
cQuery += " 		B44_CODEMP GRUPO_EMP,   " + c_ent  
cQuery += " 		BG9_DESCRI DESC_EMP,   " + c_ent  
cQuery += " 		BD6_CODPRO TAB_PRO,   " + c_ent  
cQuery += " 		BD6_DESPRO DESC_PRO,  " + c_ent   
cQuery += " 		BD6_OPEUSR||BD6_CODEMP||BD6_MATRIC||BD6_TIPREG||BD6_DIGITO MATRICULA, " + c_ent   
cQuery += " 		BD6_NOMUSR NOME_BENEF,  " + c_ent   
cQuery += " 		BD6_CODLDP LOCAL_DIGITACAO, BD6_CODPEG PEG, BD6_NUMERO SEQ_PEG,  " + c_ent   
cQuery += " 		BD6_CODRDA CODRDA,  " + c_ent   
cQuery += " 		PLS_RETORNA_NOME_RDA (BD6_CODRDA)NOME_RDA, " + c_ent     
cQuery += " 		BD6_YPROJ PROJ,   " + c_ent  
cQuery += " 		CASE  " + c_ent    
cQuery += " 			WHEN ZZQ_TPSOL ='1' THEN 'SOL.REEMBOLSO'    " + c_ent
cQuery += " 			WHEN ZZQ_TPSOL ='2' THEN 'SOL.ESPECIAL'    " + c_ent
cQuery += " 			ELSE ' '    " + c_ent
cQuery += " 		END TIPO_SOLICITACAO,    " + c_ent
cQuery += " 		CASE     " + c_ent
cQuery += " 			WHEN ZZQ_TIPPRO = '1' THEN 'ANESTESIA E HONORARIOS MEDICOS'  " + c_ent   
cQuery += " 			WHEN ZZQ_TIPPRO = '2' THEN 'CONSULTAS, EXAMES E PROCEDIMENTOS'     " + c_ent
cQuery += " 			WHEN ZZQ_TIPPRO = '3' THEN 'PROJETOS ESPECIAIS/ATEND. DOMICILIAR'     " + c_ent
cQuery += " 			WHEN ZZQ_TIPPRO = '4' THEN 'AUX FUNERAL'   " + c_ent                       
cQuery += " 			WHEN ZZQ_TIPPRO = '8' THEN 'URGENCIA E EMERGENCIA'   " + c_ent  
cQuery += " 			WHEN ZZQ_TIPPRO = '9' THEN 'ANESTESIA'     " + c_ent
cQuery += " 			WHEN ZZQ_TIPPRO = 'A' THEN 'AQUISICAO DE LENTES INTRA-OCULAR'  " + c_ent    
cQuery += " 			WHEN ZZQ_TIPPRO = 'B' THEN 'CREDENCIADO ATIVO FORA DA REDE'    " + c_ent                                        
cQuery += " 			WHEN ZZQ_TIPPRO = 'C' THEN 'LIVRE ESCOLHA'  " + c_ent   
cQuery += " 			WHEN ZZQ_TIPPRO = '5' THEN 'PROJETOS'  " + c_ent   
cQuery += " 			WHEN ZZQ_TIPPRO = '6' THEN 'LIBERACAO ESPECIAL'  " + c_ent    
cQuery += " 			WHEN ZZQ_TIPPRO = '7' THEN 'APARELHOS NAO CIRURGICOS'  " + c_ent   
cQuery += " 		END TIPO_REEMBOLSO,    " + c_ent   
cQuery += " 		BD6_CODPAD TABELA,   " + c_ent  
cQuery += " 		'REEMBOLSO' TIPO,    " + c_ent            
cQuery += " 		BD6_CONEMP CONEMP,    " + c_ent 
cQuery += " 		BAU_TIPPRE TIPO_RDA,    " + c_ent
cQuery += " 		BAU_XNOUSR ANALISTA_RES, "+ c_ent
cQuery += " 		BAU_XUSR COD_ANALISTA, "+ c_ent
cQuery += " 		TO_DATE(TRIM(T.E1_VENCTO),'YYYYMMDD') PREV_PAGTO " + c_ent    
cQuery += " 		FROM " + RetSqlName("B44") + " C, " + RetSqlName("B45") + " D, " + RetSqlName("SE1") + " T, " + RetSqlName("BA1") + " U, " + RetSqlName("BA3") + " F, " + c_ent
cQuery += "				 " + RetSqlName("BI3") + " BI3, " + RetSqlName("BG9") + " BG9, " + RetSqlName("ZZT") + " ZZT, " + RetSqlName("BD6") + " BD6, " + RetSqlName("BAU") + " BAU, " + RetSqlName("ZZQ") + " ZZQ   " + c_ent  
cQuery += " 		WHERE B45_FILIAL = '" + xFilial("B45") + "'" + c_ent 
cQuery += " 		AND B44_FILIAL = '" + xFilial("B44") + "'" + c_ent 
cQuery += " 		AND BI3_FILIAL = '" + xFilial("BI3") + "'" + c_ent
cQuery += " 		AND ZZQ_FILIAL = '" + xFilial("ZZQ") + "'" + c_ent
cQuery += " 		AND BA3_FILIAL = '" + xFilial("BA3") + "'" + c_ent
cQuery += " 		AND BA1_FILIAL = '" + xFilial("BA1") + "'" + c_ent 
cQuery += " 		AND BG9_FILIAL = '" + xFilial("BG9") + "'" + c_ent
cQuery += " 		AND ZZT_FILIAL = '" + xFilial("ZZT") + "'" + c_ent
cQuery += " 		AND BD6_FILIAL = '" + xFilial("BD6") + "'" + c_ent  
cQuery += " 		AND BAU_FILIAL = '" + xFilial("BAU") + "'" + c_ent
cQuery += " 		AND E1_FILIAL = '" + xFilial("SE1") + "'" + c_ent
cQuery += " 		AND E1_PREFIXO='RLE'    " + c_ent 
cQuery += " 		AND BD6_CODRDA=BAU_CODIGO   " + c_ent  
cQuery += " 		AND ZZQ_SEQUEN = C.B44_YCDPTC   " + c_ent  
cQuery += " 		AND B44_OPEMOV=B45_OPEMOV    " + c_ent            
cQuery += " 		AND B44_CODLDP=B45_CODLDP    " + c_ent
cQuery += " 		AND B44_CODPEG=B45_CODPEG    " + c_ent
cQuery += " 		AND B44_ANOAUT=B45_ANOAUT    " + c_ent
cQuery += " 		AND B44_MESAUT=B45_MESAUT    " + c_ent
cQuery += " 		AND B44_NUMAUT=B45_NUMAUT    " + c_ent        
cQuery += " 		AND B44_PREFIX =E1_PREFIXO   " + c_ent
cQuery += " 		AND B44_NUM=E1_NUM           " + c_ent
cQuery += " 		AND BA1_CODINT=BA3_CODINT    " + c_ent
cQuery += " 		AND BA1_CODEMP=BA3_CODEMP    " + c_ent
cQuery += " 		AND BA1_MATRIC=BA3_MATRIC    " + c_ent
cQuery += " 		AND BA1_CODINT=B44_OPEUSR    " + c_ent
cQuery += " 		AND BA1_CODEMP=B44_CODEMP    " + c_ent
cQuery += " 		AND BA1_MATRIC=B44_MATRIC    " + c_ent
cQuery += " 		AND BA1_TIPREG=B44_TIPREG    " + c_ent
cQuery += " 		AND BI3_CODINT=BA1_CODINT    " + c_ent
cQuery += " 		AND B44_OPEUSR=BG9_CODINT    " + c_ent
cQuery += " 		AND B44_CODEMP=BG9_CODIGO    " + c_ent
cQuery += " 		AND BI3_CODIGO=NVL(TRIM(BA1_CODPLA),BA3_CODPLA)    " + c_ent 
cQuery += " 		AND BD6_CODOPE = '"+cCodope+"'" + c_ent
cQuery += " 		AND B45_CODLDP=BD6_CODLDP   " + c_ent 
cQuery += " 		AND B45_CODPEG=BD6_CODPEG   " + c_ent 
cQuery += " 		AND B45_NUMERO=BD6_NUMERO   " + c_ent 
cQuery += " 		AND B45_SEQUEN=BD6_SEQUEN   " + c_ent 
cQuery += " 		AND B45_CODPAD=BD6_CODPAD   " + c_ent 
cQuery += " 		AND B45_CODPRO=BD6_CODPRO   " + c_ent 
cQuery += " 		AND SUBSTR(B44_YDTCON,5,2) = '" + cMes + "'" + c_ent
cQuery += " 		AND SUBSTR(B44_YDTCON,1,4) = '" + cAno + "'" + c_ent
cQuery += " 		AND BD6_YNEVEN=ZZT_CODEV     " + c_ent
cQuery += " 		AND C.D_E_L_E_T_=' '         " + c_ent
cQuery += " 		AND D.D_E_L_E_T_=' '         " + c_ent
cQuery += " 		AND T.D_E_L_E_T_=' '         " + c_ent
cQuery += " 		AND U.D_E_L_E_T_=' '         " + c_ent
cQuery += " 		AND F.D_E_L_E_T_=' '         " + c_ent
cQuery += " 		AND BI3.D_E_L_E_T_ = ' '     " + c_ent
cQuery += " 		AND BG9.D_E_L_E_T_=' '       " + c_ent
cQuery += " 		AND ZZT.D_E_L_E_T_=' '       " + c_ent
cQuery += " 		AND BD6.D_E_L_E_T_=' '       " + c_ent
cQuery += " 		AND BAU.D_E_L_E_T_=' '       " + c_ent
cQuery += " 		GROUP BY SUBSTR(B44_YDTCON,1,6), B44_CODEMP, TO_DATE(TRIM(B44_DATREC),'YYYYMMDD') , BG9_DESCRI, NVL(TRIM(BA1_CODPLA), BA3_CODPLA), RETORNA_DESCRI_GRUPO_PLANO ( TRIM(BI3_YGRPLA),B44_CODEMP,'C'),     " + c_ent
cQuery += " 				BI3_NREDUZ, SIGA_TIPO_EXPOSICAO_ANS(B44_CODEMP,B44_MATRIC,B44_TIPREG,TO_DATE(TRIM(B44_DATPRO),'YYYYMMDD')), B44_ANOAUT, B44_MESAUT, ZZT_EVENTO, ZZT_TPCUST,     " + c_ent
cQuery += " 				BD6_CODPRO, BD6_DESPRO, BD6_OPEUSR, BD6_MATRIC, BD6_TIPREG, BD6_DIGITO, BD6_NOMUSR, BD6_CODLDP, BD6_CODPEG, BD6_NUMERO, BD6_CODRDA, PLS_RETORNA_NOME_RDA (BD6_CODRDA),   " + c_ent  
cQuery += " 				BD6_YPROJ, ZZQ_TPSOL, ZZQ_TIPPRO, BD6_CODPAD, BD6_YNEVEN, ZZQ_SEQUEN, BD6_CODEMP, BD6_CONEMP, BAU_TIPPRE, T.E1_VENCTO, BAU_XNOUSR, BAU_XUSR  " + c_ent 
cQuery += " ) SUB1 ORDER BY 1 ASC "

DbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),R284,.T.,.T.)         

If Select("R284") > 0
	dbSelectArea(R284)
	dbCloseArea()
EndIf

For nI := 1 to 5
	IncProc('Processando...')
Next

If !(R284)->(Eof())
	nSucesso := 0
	aCabec := {"REF","PROTOC","DT_RECEB","PLANO","CODEVENTO","NOME_EVENTO","QTDE","OCORRENCIA","VL_INFORMADO","VL_PROCESSADO","GLOSADO","VAL_APROV","VL_PARTICIPACAO","EXPOSICAO_ANS","GRUPO_PLANO",;
	           "NOME_PLANO","TIPO_CUSTO","GRUPO_EMP","TAB_PRO","DESC_PRO","MATRICULA","NOME_BENEF","PEG","SEQ_PEG","CODRDA","NOME_RDA","PROJ",;     
	           "TIPO_SOLICITACAO","TIPO_REEMBOLSO","TABELA","TIPO","CONEMP","TIPO_RDA","ANALISTA_RES","CODIGO_ANALISTA","PREV_PAGTO"} 
	(R284)->(DbGoTop())
	While !(R284)->(Eof()) 
		IncProc()		
		aaDD(aDados,{(R284)->REF , (R284)->PROTOC , (R284)->DT_RECEB ,(R284)->PLANO , (R284)->CODEVENTO , (R284)->NOME_EVENTO ,(R284)->QTDE , (R284)->OCORRENCIA , (R284)->VL_INFORMADO ,(R284)->VL_PROCESSADO , (R284)->GLOSADO ,;
		             (R284)->VAL_APROV ,(R284)->VL_PARTICIPACAO , (R284)->EXPOSICAO_ANS , (R284)->GRUPO_PLANO , (R284)->NOME_PLANO ,(R284)->TIPO_CUSTO ,(R284)->GRUPO_EMP, (R284)->TAB_PRO ,(R284)->DESC_PRO ,;
		             (R284)->MATRICULA ,(R284)->NOME_BENEF ,(R284)->PEG ,(R284)->SEQ_PEG , (R284)->CODRDA ,(R284)->NOME_RDA , (R284)->PROJ ,;      
		             (R284)->TIPO_SOLICITACAO , (R284)->TIPO_REEMBOLSO ,(R284)->TABELA ,(R284)->TIPO , (R284)->CONEMP , (R284)->TIPO_RDA , (R284)->ANALISTA_RES , (R284)->CODIGO_ANALISTA , (R284)->PREV_PAGTO})  
		(R284)->(DbSkip())
	End
	 
	//Abre excel 
    DlgToExcel({{"ARRAY"," " ,aCabec,aDados}})

EndIf	

If Select("R284") > 0
	dbSelectArea(R284)
	dbCloseArea()
EndIf     

MsgInfo("Relatório gerado com sucesso !","Relatório de Reembolso")
Return


***********************************************************************************************************
Static Function BCABR284

Local bSaveArea	:= {} 
Local bCabec := {}
Local bDados := {} 
//Local cMes    := " "  
//Local cAno    := " "  
Local nI 	  := 0     
Local cCodope := PLSINTPAD()
Local cEmpresa:=  Iif(cEmpAnt == '01','CABERJ','INTEGRAL')
Local R284  := GetNextAlias()

bSaveArea	:= GetArea()      

//Monta query 
cQuery := " SELECT  " + c_ent
cQuery += " CASE   " + c_ent
cQuery += "     WHEN BD6_CODLDP = '0001' THEN 'DIGITADO' " + c_ent   
cQuery += "     ELSE 'IMPORTADO' " + c_ent  
cQuery += " END LOCAL_PEG,  " + c_ent
cQuery += " BD6_CODPEG PEG,   " + c_ent
cQuery += " BD6_NUMERO SEQ_PROTHEUS,  " + c_ent
cQuery += " BD6_CODRDA CODIGO_RDA, " + c_ent
cQuery += " PLS_RETORNA_NOME_RDA(BD6_CODRDA) DESCRICAO, " + c_ent
cQuery += " TRIM(BD6_CODOPE||BD6_CODEMP||BD6_MATRIC||BD6_TIPREG||BD6_DIGITO) MATRICULA,  " + c_ent
cQuery += " TRIM(BD6.BD6_NOMUSR) BENEFICIARIO,  " + c_ent
cQuery += " TRIM(BD6.BD6_ANOPAG||BD6.BD6_MESPAG) COMPT,   " + c_ent
cQuery += " TO_DATE(TRIM(BD6.BD6_DATPRO),'YYYYMMDD') DT_EV,  " + c_ent
cQuery += " BD6_HORPRO HORPRO,   " + c_ent
cQuery += " BD6.BD6_CODPAD CODPAD,  " + c_ent
cQuery += " BD6.BD6_CODPRO COD_PRO,  " + c_ent
cQuery += " (SELECT MAX (BR8_DESCRI)  " + c_ent
cQuery += "       FROM " + RetSqlName("BR8") + " BR8" + c_ent
cQuery += "      WHERE BR8.BR8_FILIAL = '" + xFilial("BR8") + "'" + c_ent
cQuery += "        AND BR8.BR8_CODPAD = BD6.BD6_CODPAD     " + c_ent
cQuery += "        AND TRIM(BR8_CODPSA) = TRIM(BD6.BD6_CODPRO)    " + c_ent
cQuery += "        AND BR8.D_E_L_E_T_=' '  " + c_ent
cQuery += " ) DESCRICAO_PRO,   " + c_ent
cQuery += " BD6_QTDPRO QTD_APR ,     " + c_ent
cQuery += " SUM(BD7_VLRAPR) VLR_APR ,   " + c_ent
cQuery += " SUM(BD7_VLRGLO) VLR_GLOSA,   " + c_ent
cQuery += " SUM(BD7_VLRPAG) VLR_PAG,  " + c_ent
If cEmpresa == "CABERJ"
	cQuery += " UPPER(NVL(SIGA.INFO_GLOSA_TISS2('CABERJ',BD6.BD6_CODLDP,BD6.BD6_CODPEG, BD6.BD6_NUMERO,BD6.BD6_SEQUEN,'COD_GLO'),'SEM VINCULO TISS')) MOT_GLOSA,  " + c_ent
	cQuery += " UPPER(NVL(SIGA.INFO_GLOSA_TISS2('CABERJ',BD6.BD6_CODLDP,BD6.BD6_CODPEG, BD6.BD6_NUMERO,BD6.BD6_SEQUEN,'DES_GLO'),'SEM VINCULO TISS')) DESCR_GLOSA,  " + c_ent
Else
	cQuery += " UPPER(NVL(SIGA.INFO_GLOSA_TISS2('INTEGRAL',BD6.BD6_CODLDP,BD6.BD6_CODPEG, BD6.BD6_NUMERO,BD6.BD6_SEQUEN,'COD_GLO'),'SEM VINCULO TISS')) MOT_GLOSA,  " + c_ent
	cQuery += " UPPER(NVL(SIGA.INFO_GLOSA_TISS2('INTEGRAL',BD6.BD6_CODLDP,BD6.BD6_CODPEG, BD6.BD6_NUMERO,BD6.BD6_SEQUEN,'DES_GLO'),'SEM VINCULO TISS')) DESCR_GLOSA,  " + c_ent
Endif
cQuery += " BD6.BD6_NUMLOT LT_PGTO  " + c_ent
cQuery += " FROM " + RetSqlName("BD6") + " BD6, "+ RetSqlName("BD7") + " BD7 " + c_ent
cQuery += " WHERE BD6_FILIAL = '" + xFilial("BD6") + "'" + c_ent
cQuery += " AND BD7_FILIAL = '" + xFilial("BD7") + "'" + c_ent
cQuery += " AND BD6_CODOPE = '"+cCodope+"'" + c_ent
cQuery += " AND BD6_CODLDP = BD7_CODLDP " + c_ent
cQuery += " AND BD6_CODPEG = BD7_CODPEG " + c_ent
cQuery += " AND BD6_NUMERO = BD7_NUMERO " + c_ent
cQuery += " AND BD6_ORIMOV = BD7_ORIMOV " + c_ent
cQuery += " AND BD6_CODOPE = BD7_CODOPE " + c_ent
cQuery += " AND BD6_CODRDA = BD7_CODRDA " + c_ent
cQuery += " AND BD6_SEQUEN = BD7_SEQUEN " + c_ent
cQuery += " AND BD6_CODPAD = BD7_CODPAD " + c_ent
cQuery += " AND BD6_CODPRO = BD7_CODPRO " + c_ent
cQuery += " AND BD6_CODLDP in ('0001','0002')   " + c_ent
cQuery += " AND BD6_CODLDP <= 'ZZZZ'   " + c_ent
cQuery += " AND BD6_ANOPAG = '" + cAno + "'" + c_ent
cQuery += " AND BD6_MESPAG = '" + cMes + "'" + c_ent
cQuery += " AND BD6_VLRGLO > 0.01   " + c_ent
cQuery += " AND BD6_FASE > = '3' " + c_ent
cQuery += " AND BD6_SITUAC = '1'   " + c_ent
cQuery += " AND BD6.D_E_L_E_T_ = ' '  " + c_ent
cQuery += " AND BD7.D_E_L_E_T_ = ' '  " + c_ent
cQuery += " GROUP BY BD6_CODLDP,  " + c_ent
cQuery += "          BD6_CODPEG,  " + c_ent
cQuery += "          BD6_NUMERO,  " + c_ent
cQuery += "          BD6_CODRDA,  " + c_ent
cQuery += "          PLS_RETORNA_NOME_RDA(BD6_CODRDA), " + c_ent
cQuery += "          TRIM(BD6_CODOPE||BD6_CODEMP||BD6_MATRIC||BD6_TIPREG||BD6_DIGITO), " + c_ent
cQuery += "          TRIM(BD6.BD6_NOMUSR),  " + c_ent
cQuery += "          TRIM(BD6.BD6_ANOPAG||BD6.BD6_MESPAG),  " + c_ent
cQuery += "          TO_DATE(TRIM(BD6.BD6_DATPRO),'YYYYMMDD'), " + c_ent
cQuery += "          BD6_HORPRO,  " + c_ent
cQuery += "          BD6.BD6_CODPAD,  " + c_ent
cQuery += "          BD6.BD6_CODPRO,  " + c_ent
cQuery += "          BD6_QTDPRO,  " + c_ent
If cEmpresa == "CABERJ"
	cQuery += " UPPER(NVL(SIGA.INFO_GLOSA_TISS2('CABERJ',BD6.BD6_CODLDP,BD6.BD6_CODPEG, BD6.BD6_NUMERO,BD6.BD6_SEQUEN,'COD_GLO'),'SEM VINCULO TISS')),  " + c_ent
	cQuery += " UPPER(NVL(SIGA.INFO_GLOSA_TISS2('CABERJ',BD6.BD6_CODLDP,BD6.BD6_CODPEG, BD6.BD6_NUMERO,BD6.BD6_SEQUEN,'DES_GLO'),'SEM VINCULO TISS')),  " + c_ent
Else
	cQuery += " UPPER(NVL(SIGA.INFO_GLOSA_TISS2('INTEGRAL',BD6.BD6_CODLDP,BD6.BD6_CODPEG, BD6.BD6_NUMERO,BD6.BD6_SEQUEN,'COD_GLO'),'SEM VINCULO TISS')),  " + c_ent
	cQuery += " UPPER(NVL(SIGA.INFO_GLOSA_TISS2('INTEGRAL',BD6.BD6_CODLDP,BD6.BD6_CODPEG, BD6.BD6_NUMERO,BD6.BD6_SEQUEN,'DES_GLO'),'SEM VINCULO TISS')),  " + c_ent
Endif
cQuery += "           BD6_NUMLOT " 

DbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),R284,.T.,.T.)         

If Select("R284") > 0
	dbSelectArea(R284)
	dbCloseArea()
EndIf

For nI := 1 to 5
	IncProc('Processando...')
Next

If !(R284)->(Eof())
	nSucesso := 0
	bCabec := {"LOCAL_PEG","PEG","SEQ_PROTHEUS","CODIGO_RDA","DESCRICAO","MATRICULA",;
               "BENEFICIARIO","COMPT","DT_EV","HORPRO","CODPAD","COD_PRO","DESCRICAO_PRO","QTD_APR",;
	           "VLR_APR","VLR_GLOSA","VLR_PAG","MOT_GLOSA","DESCR_GLOSA","LT_PGTO"} 
	(R284)->(DbGoTop())
	While !(R284)->(Eof()) 
		IncProc()		
		aaDD(bDados,{(R284)->LOCAL_PEG , (R284)->PEG ,(R284)->SEQ_PROTHEUS , (R284)->CODIGO_RDA , (R284)->DESCRICAO , (R284)->MATRICULA,;
		             (R284)->BENEFICIARIO , (R284)->COMPT , (R284)->DT_EV , (R284)->HORPRO , (R284)->CODPAD, (R284)->COD_PRO , (R284)->DESCRICAO_PRO , (R284)->QTD_APR,;
                     (R284)->VLR_APR , (R284)->VLR_GLOSA ,(R284)->VLR_PAG ,(R284)->MOT_GLOSA , (R284)->DESCR_GLOSA , (R284)->LT_PGTO})  
		(R284)->(DbSkip())
	End
	 
	//Abre excel 
    DlgToExcel({{"ARRAY"," " ,bCabec,bDados}})

EndIf	

If Select("R284") > 0
	dbSelectArea(R284)
	dbCloseArea()
EndIf      

MsgInfo("Relatório gerado com sucesso !","Relatório de Analise de Glosas")
Return


***********************************************************************************************************
Static Function CCABR284

Local aCabec		:= {}
Local aDados		:= {}
Local cAliasQry		:= GetNextAlias()
Local cQuery		:= ""

if cEmp == 1 .or. cEmp == 3		// Caberj ou Ambas

	cQuery := " SELECT 'CABERJ' AS OPERADORA,"																				+ c_ent
	cQuery +=		" BAU_CODIGO,"																							+ c_ent
	cQuery +=		" BAU_NOME,"
	cQuery += 		" BAU_XNOUSR ANALISTA_RES, "																			+ c_ent
	cQuery +=		" BAU_XUSR COD_ANA_RES,"																							+ c_ent
	cQuery +=		" BAU_CODSA2,"																							+ c_ent
	cQuery +=		" BAU_NFANTA,"																							+ c_ent
	cQuery +=		" RESP_CONFERENCIA('C',BAU_CODIGO,TO_CHAR(SYSDATE,'YYYYMMDD'),'C') AS COD_ANA_CONT,"					+ c_ent
	cQuery +=		" RESP_CONFERENCIA('C',BAU_CODIGO,TO_CHAR(SYSDATE,'YYYYMMDD'),'N') AS NOM_ANALISTA,"					+ c_ent
	cQuery +=		" RETORNA_CLASSE_PREST(BAU_CODIGO,'C') AS CLASSE_REDE,"													+ c_ent
	cQuery +=		" BAU_GRPPAG,"																							+ c_ent
	cQuery +=		" TRIM(BAU_END) || ', ' || TRIM(BAU_NUMERO) || "														+ c_ent
	cQuery +=		" (CASE WHEN LENGTH(TRIM(BAU_COMPL))  > 1 THEN ' - ' || TRIM(BAU_COMPL)  ELSE ' ' END) ||"				+ c_ent
	cQuery +=		" (CASE WHEN LENGTH(TRIM(BAU_YCPEND)) > 1 THEN ' - ' || TRIM(BAU_YCPEND) ELSE ' ' END) AS ENDERECO,"	+ c_ent
	cQuery +=		" BAU_BAIRRO,"																							+ c_ent
	cQuery +=		" RETORNA_MUNICIPIO ('C',BAU_MUN) AS MUNICIPIO,"														+ c_ent
	cQuery +=		" TRIM(BAU_EST) AS UF,"																					+ c_ent
	cQuery +=		" BAU_CEP,"																								+ c_ent
	cQuery +=		" BAU_XHAT,"																							+ c_ent
	cQuery +=		" BAU_XMEDLI"																							+ c_ent
	cQuery += " FROM BAU010 BAU"																							+ c_ent
	cQuery += " WHERE D_E_L_E_T_ = ' '"																						+ c_ent
	cQuery +=	" AND (BAU_DATBLO = ' ' OR TO_DATE(BAU_DATBLO,'YYYYMMDD') >= SYSDATE)"										+ c_ent

endif

if cEmp == 2 .or. cEmp == 3		// Integral ou Ambas

	if cEmp == 3
		cQuery += " UNION ALL " + c_ent
	endif

	cQuery += " SELECT 'INTEGRAL' AS OPERADORA,"																			+ c_ent
	cQuery +=		" BAU_CODIGO,"																							+ c_ent
	cQuery +=		" BAU_NOME,"
	cQuery += 		" BAU_XNOUSR ANALISTA_RES, "																				+ c_ent
	cQuery +=		" BAU_XUSR COD_ANA_RES,"																							+ c_ent
	cQuery +=		" BAU_CODSA2,"																							+ c_ent
	cQuery +=		" BAU_NFANTA,"																							+ c_ent
	cQuery +=		" RESP_CONFERENCIA ('I',BAU_CODIGO,TO_CHAR(SYSDATE,'YYYYMMDD'),'C') AS COD_ANA_CONT,"					+ c_ent
	cQuery +=		" RESP_CONFERENCIA ('I',BAU_CODIGO,TO_CHAR(SYSDATE,'YYYYMMDD'),'N') AS NOM_ANALISTA,"					+ c_ent
	cQuery +=		" RETORNA_CLASSE_PREST(BAU_CODIGO,'I') AS CLASSE_REDE,"													+ c_ent
	cQuery +=		" BAU_GRPPAG,"																							+ c_ent
	cQuery +=		" TRIM(BAU_END) || ', ' || TRIM(BAU_NUMERO) || "														+ c_ent
	cQuery +=		" (CASE WHEN LENGTH(TRIM(BAU_COMPL))  > 1 THEN ' - ' || TRIM(BAU_COMPL)  ELSE ' ' END) ||"				+ c_ent
	cQuery +=		" (CASE WHEN LENGTH(TRIM(BAU_YCPEND)) > 1 THEN ' - ' || TRIM(BAU_YCPEND) ELSE ' ' END) AS ENDERECO,"	+ c_ent
	cQuery +=		" BAU_BAIRRO,"																							+ c_ent
	cQuery +=		" RETORNA_MUNICIPIO ('I',BAU_MUN) AS MUNICIPIO,"														+ c_ent
	cQuery +=		" TRIM(BAU_EST) AS UF,"																					+ c_ent
	cQuery +=		" BAU_CEP,"																								+ c_ent
	cQuery +=		" BAU_XHAT,"																							+ c_ent
	cQuery +=		" BAU_XMEDLI"																							+ c_ent
	cQuery += " FROM BAU020 BAU"																							+ c_ent
	cQuery += " WHERE D_E_L_E_T_ = ' '"																						+ c_ent
	cQuery += " AND (BAU_DATBLO = ' ' OR TO_DATE(BAU_DATBLO,'YYYYMMDD') >= SYSDATE)"										+ c_ent

endif

memowrite("C:\temp\CABR284.sql",cQuery)

// TcQuery cQuery New Alias (cAliasQry)
dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAliasQry,.T.,.T.)

(cAliasQry)->(DbGoTop())
if (cAliasQry)->(!EOF())

	aCabec := {"OPERADORA","CODIGO_DO_RDA","NOME_DO_PRESTADOR","CODIGO_DO_FORNECEDOR","NOME_FANTASIA",;
               "NOME_DO_ANALISTA","COD_ANA_CONT","ANALISTA_RES","COD_ANA_RES","CLASSE_REDE","GRP_PAG","ENDERECO","BAIRRO","MUNICIPIO","UF","CEP","HAT","ENV. MEDLINK"}
	
	while (cAliasQry)->(!EOF())

		IncProc()

		aAdd(aDados,{	AllTrim((cAliasQry)->OPERADORA)								,;
						"`" + AllTrim((cAliasQry)->BAU_CODIGO)						,;
						AllTrim((cAliasQry)->BAU_NOME)								,;
						"`" + AllTrim((cAliasQry)->BAU_CODSA2)						,;
						AllTrim((cAliasQry)->BAU_NFANTA)							,;
						AllTrim((cAliasQry)->NOM_ANALISTA)							,;
						AllTrim((cAliasQry)->COD_ANA_CONT)							,;
						AllTrim((cAliasQry)->ANALISTA_RES)							,;
						"`" + AllTrim((cAliasQry)->COD_ANA_RES)						,;
						AllTrim((cAliasQry)->CLASSE_REDE)							,;
						"`" + AllTrim((cAliasQry)->BAU_GRPPAG)						,;
						AllTrim((cAliasQry)->ENDERECO)								,;
						AllTrim((cAliasQry)->BAU_BAIRRO)							,;
						AllTrim((cAliasQry)->MUNICIPIO)								,;
						AllTrim((cAliasQry)->UF)									,;
						AllTrim((cAliasQry)->BAU_CEP)								,;
						AllTrim(X3Combo("BAU_XHAT",   (cAliasQry)->BAU_XHAT))		,;
						AllTrim(X3Combo("BAU_XMEDLI", (cAliasQry)->BAU_XMEDLI))		})
		
		(cAliasQry)->(DbSkip())
	end
	(cAliasQry)->(DbCloseArea())

	DlgToExcel({{"ARRAY"," " ,aCabec,aDados}})		//Abre excel

endif

MsgInfo("Relatório gerado com sucesso !","Relatório Grupo Analista")

return


*************************************************************************************************************************
Static Function AjustaSX1     

PutSx1(cPergAb,"01","Mês Referência","","","mv_ch01","C",02,0,0,"C","","","","","mv_par01","","","","","","","","","","","","","","","","",{},{},{})
PutSx1(cPergAb,"02","Ano Referência","","","mv_ch02","C",04,0,0,"C","","","","","mv_par02","","","","","","","","","","","","","","","","",{},{},{})

Return

*************************************************************************************************************************
Static Function AjustaSX1b      

PutSx1(cPergC,"01","Selecione a Operadora","","","mv_ch01","N",01,0,0,"C","","","","","mv_par01","1 - CABERJ","","","","2 - INTEGRAL","","","3 - AMBAS","","","","","","","","")

Return	
