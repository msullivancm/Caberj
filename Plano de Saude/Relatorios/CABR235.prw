#INCLUDE "rwmake.ch"
#INCLUDE "protheus.ch"
#INCLUDE "TopConn.ch"
#include "TBICONN.CH"    

#DEFINE c_ent CHR(13) + CHR(10)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABR235      ºAutor  ³ PAULO MOTTA        º Data ³ ABRIL/17    º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³  GERA PLANILHA PARA REDE PARA O COMERCIAL                     º±± 
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Projeto CABERJ                                                º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
± feito com base no orimed e orime2 cr-pls-orinetador_medico                   ±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
± 29/08/2022 : MMT - Alterada função de impressão para DLGTOCSV                ±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function CABR235()   
      
Processa({||PCABR235()},'Processando...')

Return

Static Function PCABR235

Local aSaveArea	:= {} 

Local aCabec := {}
Local aDados := {} 

Local cRede   := " "  
Local cMun    := " "  
Local cGrupo  := " "  
Local cEspec  := " "
Local nI 	  := 0  
Local cTabSub := ""

Private cPerg := "CABR235"

aSaveArea	:= GetArea()
AjustaSX1()   

//ler parametros 
If Pergunte(cPerg,.T.) 
 	cRede   := mv_par01  
	cMun    := mv_par02    
	cGrupo  := mv_par03  
	cEspec  := mv_par04  
else
    Return	
EndIf      

/*view de subsespecialidade idem 
   CR_WWW_ESPECIALIDADE_ADM 
   site*/
If cEmpAnt = "01" 
  cTabSub := "V_SUB_BAX_CAB VSUB" 
Else  
  cTabSub := "V_SUB_BAX_INT VSUB"  
End if

//Monta query 
cQuery := "SELECT DISTINCT      " + c_ent  
cQuery += "   X5_DESCRI GRUPO,      " + c_ent          
cQuery += "   BAQ_DESCRI ESPECIALIDADE,      " + c_ent 
cQuery += "   DESCRISUB SUBESPEC, " + c_ent 
cQuery += "   BAU_CODIGO CODRDA,     " + c_ent 
cQuery += "   TRIM(BAU_NOME) AS RAZAO_SOCIAL,     " + c_ent 
cQuery += "   TRIM(BAU_NFANTA) AS NOME_FANTASIA,     " + c_ent 
cQuery += "  CASE WHEN LENGTH(TRIM(BAU_CPFCGC))=11 THEN " + c_ent
cQuery += "        CONCAT(SUBSTR(BAU_CPFCGC,1,3),CONCAT('.',CONCAT(SUBSTR(BAU_CPFCGC,4,3),CONCAT('.',CONCAT(SUBSTR(BAU_CPFCGC,7,3),CONCAT('-',SUBSTR(BAU_CPFCGC,10,2))))))) " + c_ent
cQuery += "    ELSE " + c_ent
cQuery += "        CONCAT(SUBSTR(BAU_CPFCGC,1,2),CONCAT('.',CONCAT(SUBSTR(BAU_CPFCGC,3,3),CONCAT('.',CONCAT(SUBSTR(BAU_CPFCGC,6,3),CONCAT('/',CONCAT(SUBSTR(BAU_CPFCGC,9,4),CONCAT('-',SUBSTR(BAU_CPFCGC,13,2))))))))) " + c_ent
cQuery += "    END CPFCNPJ, " + c_ent 
cQuery += "   TRIM(BB8.BB8_MUN) AS NOME_MUNICIPIO  ,      " + c_ent          
cQuery += "   (CASE WHEN (BB8_CODMUN = '3304557' AND (BB8_BAIRRO LIKE '%JACAREP%'   OR     " + c_ent 
cQuery += "                                           BB8_BAIRRO LIKE 'ANIL%'   OR     " + c_ent 
cQuery += "                                           BB8_BAIRRO LIKE '%CIDADE%DEUS%'   OR     " + c_ent 
cQuery += "                                           BB8_BAIRRO LIKE '%COLONIA%'   OR     " + c_ent          
cQuery += "                                           BB8_BAIRRO LIKE '%CURICICA%'   OR     " + c_ent 
cQuery += "                                           BB8_BAIRRO LIKE '%FREGUESIA%J%'   OR     " + c_ent 
cQuery += "                                           BB8_BAIRRO LIKE '%GARD%AZUL%'   OR     " + c_ent 
cQuery += "                                           BB8_BAIRRO LIKE '%PECHINCHA%'   OR     " + c_ent          
cQuery += "                                           BB8_BAIRRO LIKE '%PR%SECA%'   OR     " + c_ent 
cQuery += "                                           BB8_BAIRRO LIKE '%RIO GRANDE%'   OR     " + c_ent 
cQuery += "                                           BB8_BAIRRO LIKE '%TANQUE%'   OR     " + c_ent
cQuery += "                                           BB8_BAIRRO LIKE '%TAQUARA%'   OR     " + c_ent          
cQuery += "                                           BB8_BAIRRO LIKE '%VL%VALQUEIRE%')) THEN 'JACAREPAGUA'     " + c_ent 
cQuery += "         WHEN (BB8_CODMUN = '3304557' AND (BB8_BAIRRO LIKE '%GOVER%'   OR     " + c_ent 
cQuery += "                                           BB8_BAIRRO LIKE '%BANCARIOS%'   OR     " + c_ent 
cQuery += "                                           BB8_BAIRRO LIKE '%BANANAL%'   OR     " + c_ent          
cQuery += "                                           BB8_BAIRRO LIKE '%CACUIA%'   OR            " + c_ent 
cQuery += "                                           BB8_BAIRRO LIKE '%COCOTA%'   OR     " + c_ent 
cQuery += "                                           BB8_BAIRRO LIKE '%FREGUESIA%I%'   OR       " + c_ent 
cQuery += "                                           BB8_BAIRRO LIKE '%GALEAO%'   OR        " + c_ent          
cQuery += "                                           BB8_BAIRRO LIKE '%GUARABU%'   OR        " + c_ent 
cQuery += "                                           BB8_BAIRRO LIKE '%ITACOLOMI%'   OR     " + c_ent 
cQuery += "                                           BB8_BAIRRO LIKE '%J%CARIOCA%'   OR              " + c_ent 
cQuery += "                                           BB8_BAIRRO LIKE '%GUANABARA%'   OR       " + c_ent          
cQuery += "                                           BB8_BAIRRO LIKE '%MONERO%'   OR       " + c_ent 
cQuery += "                                           BB8_BAIRRO LIKE '%PITANGUEIRAS%'   OR              " + c_ent 
cQuery += "                                           BB8_BAIRRO LIKE '%PORTUGUESA%'   OR             " + c_ent 
cQuery += "                                           BB8_BAIRRO LIKE 'PR%%BANDEIRA%'   OR             " + c_ent          
cQuery += "                                           BB8_BAIRRO LIKE '%RIBEIRA%'   OR       " + c_ent 
cQuery += "                                           BB8_BAIRRO LIKE '%TAUA%'   OR              " + c_ent 
cQuery += "                                           BB8_BAIRRO LIKE '%TUBIACANGA%'   OR              " + c_ent 
cQuery += "                                           BB8_BAIRRO LIKE '%VILLAGE%'   OR       " + c_ent          
cQuery += "                                           BB8_BAIRRO LIKE '%ZUMBI%')) THEN 'ILHA DO GOVERNADOR'       " + c_ent 
cQuery += "         ELSE TRIM(BB8_BAIRRO) END) NOME_BAIRRO ,       " + c_ent 
cQuery += "   TRIM(BB8_END) ENDERECO ,     " + c_ent 
cQuery += "   TRIM(BB8_NR_END) NUMERO,     " + c_ent          
cQuery += "   TRIM(BB8_COMEND) COMPLEMENTO,     " + c_ent 
cQuery += "   BB8_TEL AS TELEFONES ,     " + c_ent 
cQuery += "   BAU_DTINCL INCLUSAO,     " + c_ent 
cQuery += "   BB8_EST AS UF  ,     " + c_ent          
cQuery += "   (SELECT BID_YDDD FROM " + RetSqlName("BID") + " BID WHERE BID_FILIAL=' ' AND BID_CODMUN=BB8_CODMUN AND D_E_L_E_T_=' ') AS DDD   ,      " + c_ent 
cQuery += "   DECODE(BB8_CODMUN,'3304557',0,1) ORDEM,     " + c_ent 
cQuery += "   TRIM(BI5_DESCRI) REDE,     " + c_ent
cQuery += "   CASE WHEN BB8_GUIMED = '1' AND BAX_GUIMED = '1' AND BAU_GUIMED = '1' THEN 'SIM' ELSE 'NAO' END DIVULGADO  " + c_ent
cQuery += "  FROM " + RetSqlName("BI5") + " BI5, " + RetSqlName("BBK") + " BBK, " + RetSqlName("BAU") + " BAU, " + c_ent
cQuery += " " + RetSqlName("BB8") + " BB8, " + RetSqlName("BAX") + " BAX, " + RetSqlName("BAQ") + " BAQ, " + c_ent  
cQuery += " " + RetSqlName("SX5") + " SX5, " + cTabSub + c_ent 
cQuery += " WHERE BI5.BI5_CODRED = BBK.BBK_CODRED       " + c_ent 
//cQuery += "   AND BI5_CODRED='" + cRede + "'       " + c_ent                      //Motta 21/8/20        
cQuery += "   AND BI5_CODRED = NVL(TRIM('" + cRede + "'),BI5_CODRED)      " + c_ent //Motta 21/8/20  
cQuery += "   AND BB8_CODMUN = NVL(TRIM('" + cMun + "'),BB8_CODMUN)      " + c_ent 
cQuery += "   AND BAQ_YGPESP = NVL(TRIM('" + cGrupo + "'),BAQ_YGPESP)       " + c_ent          
cQuery += "   AND INSTR(NVL(TRIM('" + cEspec + "'),BAQ_CODESP),BAQ_CODESP) > 0       " + c_ent  
cQuery += "   AND BI5.D_E_L_E_T_ = BBK.D_E_L_E_T_       " + c_ent 
cQuery += "   AND BBK.BBK_CODIGO = BAU.BAU_CODIGO       " + c_ent 
cQuery += "   AND BBK.D_E_L_E_T_ = BAU.D_E_L_E_T_       " + c_ent          
cQuery += "   AND BAU.BAU_CODIGO = BB8.BB8_CODIGO       " + c_ent 
cQuery += "   AND BAU.D_E_L_E_T_ = BB8.D_E_L_E_T_       " + c_ent 
cQuery += "   AND BB8.BB8_CODIGO = BAX.BAX_CODIGO       " + c_ent 
cQuery += "   AND BB8.BB8_CODLOC = BAX.BAX_CODLOC       " + c_ent          
cQuery += "   AND BB8.D_E_L_E_T_ = BAX.D_E_L_E_T_       " + c_ent 
cQuery += "   AND BAX.BAX_CODINT = BAQ.BAQ_CODINT       " + c_ent 
cQuery += "   AND BAX.BAX_CODESP = BAQ.BAQ_CODESP       " + c_ent 
cQuery += "   and BAX.BAX_CODESP = BBK_CODESP     " + c_ent          
cQuery += "   and BAX.BAX_CODLOC = BBK_CODLOC     " + c_ent 
cQuery += "   AND BAX.D_E_L_E_T_ = BAQ.D_E_L_E_T_       " + c_ent 
cQuery += "   AND BI5.D_E_L_E_T_ <> '*'       " + c_ent 
cQuery += "   AND BB8_DATBLO = '        '      " + c_ent          
cQuery += "   AND BAX_DATBLO = '        '      " + c_ent 
IF MV_PAR05 = 1
	cQuery += "   AND BB8_GUIMED = '1'       " + c_ent 
	cQuery += "   AND BAX_GUIMED = '1'        " + c_ent 
	cQuery += "   AND BAU_GUIMED <> '0'       " + c_ent          
	cQuery += "   AND BAQ_YDIVUL = '1'     " + c_ent 
	cQuery += "   AND BBK_YDIVUL = '1'      " + c_ent          
ENDIF
cQuery += "   AND BAU_CODBLO = ' '       " + c_ent 
cQuery += "   AND BAU_DATBLO = ' '      " + c_ent 
cQuery += "   AND X5_TABELA ='97'       " + c_ent 
cQuery += "   AND X5_CHAVE=BAQ_YGPESP     " + c_ent 
cQuery += "   AND VSUB.CODRDA (+) = BAX_CODIGO " + c_ent 
cQuery += "   AND VSUB.CODESP (+) = BAX_CODESP " + c_ent 
cQuery += "     ORDER BY TRIM(BI5_DESCRI),     " + c_ent
cQuery += "              ORDEM,     " + c_ent
cQuery += "             UF,     " + c_ent                          
cQuery += "            NOME_MUNICIPIO,     " + c_ent 
cQuery += "            X5_DESCRI,     " + c_ent 
cQuery += "            BAQ_DESCRI,     " + c_ent 
cQuery += "            RAZAO_SOCIAL   " + c_ent

//memowrite("C:\TEMP\sql235.sql",cQuery)      

                                                 //
If Select("R235") > 0
	dbSelectArea("R235")
	dbCloseArea()
EndIf

DbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),"R235",.T.,.T.)         

For nI := 1 to 5
	IncProc('Processando...')
Next

If ! R235->(Eof())
	nSucesso := 0
	aCabec := {"GRUPO","ESPECIALIDADE","SUBESPEC","CODRDA","RAZÃO SOCIAL","NOME FANTASIA","CPFCNPJ","NOME_MUNICIPIO","NOME_BAIRRO","ENDERECO","NUMERO","COMPLEMENTO","TELEFONES","INCLUSAO",;
	           "UF","DDD","ORDEM","REDE", "DIVULGADO"}  
	           
	R235->(DbGoTop())
	While ! R235->(Eof()) 
		IncProc()		
		aaDD(aDados,{R235->GRUPO,R235->ESPECIALIDADE,R235->SUBESPEC,R235->CODRDA,R235->RAZAO_SOCIAL,R235->NOME_FANTASIA,R235->CPFCNPJ,R235->NOME_MUNICIPIO,R235->NOME_BAIRRO,R235->ENDERECO,R235->NUMERO,;
		             R235->COMPLEMENTO,R235->TELEFONES,R235->INCLUSAO,R235->UF,R235->DDD,R235->ORDEM,R235->REDE, R235->DIVULGADO}) 
		R235->(DbSkip())
	End
	 
	//Abre excel 
    U_DlgToCSV({{"ARRAY"," " ,aCabec,aDados}})
    //DlgToExcel({{"ARRAY"," " ,aCabec,aDados}})


EndIf	

If Select("R235") > 0
	dbSelectArea("R235")
	dbCloseArea()
EndIf      

 
*************************************************************************************************************************
//AJUSTAR "COPPRO"
Static Function AjustaSX1      

 
Local aHelpPor := {}
//Monta Help
Aadd( aHelpPor, '01 PRONTO SOCORRO ' )       
Aadd( aHelpPor, '02 UNIDADES DE INTERNACAO ' )    
Aadd( aHelpPor, '03 CONSULTORIOS/CLINICAS ' )       
Aadd( aHelpPor, '04 SERVICOS DE DIAGNOSE E TERAPIAS ' )   
Aadd( aHelpPor, 'BRANCO PARA TODOS ' )  


u_CABASX1(cPerg,"01","Rede        			","","","MV_CH1","C",02,0,0,"C","","B46PLS"	,"","","MV_PAR01","","","","","","","","","","","","","","","","",{},{},{})
u_CABASX1(cPerg,"02","Cod. Mun    			","","","MV_CH2","C",08,0,0,"C","","B57PLS"	,"","","MV_PAR02","","","","","","","","","","","","","","","","",{},{},{})
u_CABASX1(cPerg,"03","Cod. Grupo  			","","","MV_CH3","C",02,0,0,"C","",""		,"","","MV_PAR03","","","","","","","","","","","","","","","","",{},{},{}) 
u_CABASX1(cPerg,"04","Cod. Espec  			","","","MV_CH4","C",03,2,0,"G","","BAQPL2"	,"","","MV_PAR04","","","","","","","","","","","","","","","","",{},{},{})  
u_CABASX1(cPerg,"05","Somente Divulgados 	","","","MV_CH5","N",01,0,0,"C","",""		,"","","MV_PAR05","SIM",,,,"NÃO",,,"",,,"")
PutSX1Help("P."+cPerg+"03.",aHelpPor,{},{}) 

Return	
