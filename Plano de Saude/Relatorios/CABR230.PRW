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
±±ºDesc.     ³  Planilha de titulos em aberto                                º±± 
±±º          ³  		                                                     º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Projeto CABERJ                                                º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function CABR230()   
      
Processa({||PCABR230()},'Processando...')

Return

Static Function PCABR230
	
	Local aSaveArea	:= {} 
	
	Local aCabec := {}
	Local aDados := {}   
	Local cTipoPes := {}
	Local cCodEmp1 := {}
	Local cCodEmp2 := {}  
	Local cSubCon1 := {} 
	Local cSubCon2 := {} 
	Local cConEmp1 := {} 
	Local cConEmp2 := {} 
	Local cVencto1 := CTOD("  /  /  ")
	Local cVencto2 := CTOD("  /  /  ")
	Local nI 	  := 0   
	
	Private cPerg := "CABR230"
	Private cQuery:= ""
	 
	AjustaSX1(cPerg)
		
	If Pergunte(cPerg,.T.)  
	
		c_Empresa	:= Mv_Par01  
		c_MatDe		:= Mv_Par02  
		c_MatAte	:= Mv_Par03  
	   
	else
	
	    Return	
	
	EndIf   
	
	cQuery += " SELECT DISTINCT   BA1_CODINT||BA1_CODEMP||BA1_MATRIC||BA1_TIPREG MATRICULA, "
	cQuery += "                   BA1_NOMUSR NOME, "
	cQuery += "                   TRIM(BA3_MATEMP) CPF_TITULAR, "
	cQuery += "                   BA1_CPFUSR CPF_USUARIO, "
	cQuery += "                   DECODE(BA1_TIPUSU, 'T', 'TITULAR', 'DEPENDENTE') TIPO_USUARIO, "
	cQuery += "                   BI3_DESCRI PLANO, "
	cQuery += "                   SIGA.RETORNA_SINISTRAL_FAM_MS_CAB('C','S',BA3_CODINT,BA3_CODEMP,BA3_MATRIC,TRUNC(ADD_MONTHS(SYSDATE,-13),'MM'),TRUNC(ADD_MONTHS(sysdate,-1),'MM')) SINISTR_12, "
	cQuery += "                   SIGA.RETORNA_SINISTRAL_FAM_MS_CAB('C','S',BA3_CODINT,BA3_CODEMP,BA3_MATRIC,TRUNC(ADD_MONTHS(sysdate,-4),'MM'),TRUNC(ADD_MONTHS(sysdate,-1),'MM')) SINISTR_3,   "
	cQuery += "                   E1_NUM PLS, "
	cQuery += "                   E1_FORMREC FORMA_RECEBIMENTO, "
	cQuery += "                   E1_NUMBOR BORDERO,  "
	cQuery += "                   TO_DATE(TRIM(E1_EMISSAO), 'YYYYMMDD') EMISSAO, "
	cQuery += "                   TO_DATE(TRIM(E1_VENCREA), 'YYYYMMDD') VENCIMENTO, "
	cQuery += "                   E1_ANOBASE ANO_COMPETENCIA, "
	cQuery += "                   E1_MESBASE MES_COMPETENCIA, "
	cQuery += "                   DECODE(BA1_TIPUSU, 'T', E1_VALOR, 0) VALOR, "
	cQuery += "                   DECODE(BA1_TIPUSU, 'T', E1_SALDO, 0) SALDO, "
	cQuery += "                   TO_DATE(TRIM(E1_BAIXA), 'YYYYMMDD') BAIXA "

	cQuery += " FROM " + RetSqlName("SE1") + " SE1 INNER JOIN " + RetSqlName("BA3") + " BA3 ON BA3_FILIAL = ' '  "
	cQuery += "                               AND BA3_CODINT = E1_CODINT " 
	cQuery += "                               AND BA3_CODEMP = E1_CODEMP "
	cQuery += "                               AND BA3_MATRIC = E1_MATRIC "
	cQuery += "                               AND BA3.D_E_L_E_T_ = ' ' "
                              
	cQuery += "             INNER JOIN " + RetSqlName("BA1") + " BA1 ON BA1_FILIAL = ' '  "
	cQuery += "                               AND BA1_CODINT = E1_CODINT " 
	cQuery += "                               AND BA1_CODEMP = E1_CODEMP "
	cQuery += "                               AND E1_MATRIC = BA1_MATRIC "
	cQuery += "                               AND BA1_TIPUSU = 'T' "
	cQuery += "                               AND BA1.D_E_L_E_T_ = ' ' "
                              
	cQuery += "             INNER join " + RetSqlName("BM1") + " BM1 ON BM1_FILIAL = ' '  "
	cQuery += "                               AND BM1_PREFIX = E1_PREFIXO " 
	cQuery += "                               AND BM1_NUMTIT = E1_NUM  "
	cQuery += "                               AND BM1.D_E_L_E_T_ = ' ' "
                              
	cQuery += "             INNER JOIN " + RetSqlName("BI3") + " BI3 ON BI3_FILIAL = ' '  " 
	cQuery += "                               AND BI3_CODIGO = BA1_CODPLA  " 
	cQuery += "                               AND BI3.D_E_L_E_T_ = ' ' "

	cQuery += " WHERE E1_FILIAL = '01' "
	cQuery += "       AND E1_EMISSAO  >= '20160101' "
	cQuery += "       AND E1_CODEMP   =  '" + c_Empresa + "' "
	cQuery += "       AND E1_MATRIC   >= '" + c_MatDe   + "' "
	cQuery += "       AND E1_MATRIC   <= '" + c_MatAte  + "' "
	cQuery += "       AND E1_CLIENTE  <> '044591' "
	cQuery += "       AND E1_TIPO     = 'DP'  "
	cQuery += "       AND E1_SALDO    > 0 "
	cQuery += "       AND SE1.D_E_L_E_T_ = ' '  "
	cQuery += "       AND BA1.D_E_L_E_T_ = ' '  "
      
	cQuery += " ORDER BY 1"
	
	//cQuery += "   AND BA1.BA1_NOMUSR LIKE ('%ARLETTE CASTANHEIRA DE ALENCAR%')
	
  	cQuery := ChangeQuery( cQuery )
	DbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),"R230",.T.,.T.)         

	// Monta Cabecalho "Fixo"
	aCabec := {"MATRICULA", ;
						 "Nome",;
						 "CPF TITULAR",;
						 "CPF USUARIO",; 
						 "TIPO USUARIO",;
						 "PLANO",;
						 "SINISTR_12",;
						 "SINISTR_3",;
						 "PLS",;
						 "FORMA_RECEBIMENTO",;
						 "BORDERO",;
						 "EMISSAO",;
						 "VENCIMENTO",;
						 "ANO_COMPETENCIA",;
						 "MES_COMPETENCIA",;
						 "VALOR",;
						 "SALDO",;
			  			 "BAIXA"}
			
		While ! R230->(Eof()) 
			IncProc()
			
			AADD(aDados,{"'"+R230->MATRICULA, ;
						 R230->NOME,;
						 "'"+R230->CPF_TITULAR,;
						 "'"+R230->CPF_USUARIO,; 
						 R230->TIPO_USUARIO,;
						 R230->PLANO,;
						 R230->SINISTR_12,;
						 R230->SINISTR_3,;
						 R230->PLS,;
						 R230->FORMA_RECEBIMENTO,;
						 R230->BORDERO,;
						 R230->EMISSAO,;
						 R230->VENCIMENTO,;
						 R230->ANO_COMPETENCIA,;
						 R230->MES_COMPETENCIA,;
						 R230->VALOR,;
						 R230->SALDO,;
			  			 R230->BAIXA})  
			
			R230->(DbSkip())       
			
		EndDo

	aAdd(aDados ,{"Fim"} )
	//Abre excel 
    DlgToExcel({{"ARRAY"," " ,aCabec,aDados}})
If Select("R230") > 0
	dbSelectArea("R230")
	dbCloseArea()
EndIf      

 
*************************************************************************************************************************
//AJUSTAR "COPPRO"
Static Function AjustaSX1      

 
Local aHelpPor := {}
//Monta Help

PutSx1(cPerg,"01","Empresa:  "  ,"","","mv_ch01","C",04,0,0,"C","","","","","mv_par01","","","","","","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"02","Matricula de:  "  ,"","","mv_ch02","C",06,0,0,"C","","","","","mv_par02","","","","","","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"03","Matricula ate:"  ,"","","mv_ch03","C",06,0,0,"C","","","","","mv_par03","","","","","","","","","","","","","","","","",{},{},{})

Return	