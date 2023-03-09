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
±±ºDesc.     ³  GERA PLANILHA DE FATURAMENTO PREF  							 º±± 
±±º          ³  		                                                     º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Projeto CABERJ                                                º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function CABR195()   
      
Processa({||PCABR195()},'Processando...')

Return

Static Function PCABR195
	
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
	
	Private cPerg := "CABR195"
	Private cQuery:= ""
	 
	AjustaSX1(cPerg)
		
	If Pergunte(cPerg,.T.)  
	
		cEmpDe 	:= Mv_Par01  
		cEmpAte	:= Mv_Par02  
		cAno	:= Mv_Par03  
	    cMes	:= Mv_Par04
	    lAgl	:= Mv_Par05 == 1
	   
	else
	    Return	
	EndIf   
	if lAgl	
	cQuery += " Select MATRICULA, NOME_EMPREGADO, NOME_DEPENDENTE, CPF_DEPENDENTE, DATA_NASCIMENT, SEXO, TIPO_DEPENDENCIA, BA1_YMTODO, PLANO, sum(BM1_VALOR) BM1_VALOR from ("
	EndIf
	cQuery += " SELECT SUBSTR( TRIM(BA1_MATEMP) , 1, length( TRIM(BA1_MATEMP)) - 2) MATRICULA, "
	cQuery += "        DECODE(BA1_SEXO, 1, 'M', 'F') SEXO, (select BA1_NOMUSR from BA1010 B where B.BA1_CODEMP = BA1.BA1_CODEMP and B.BA1_MATRIC = BA1.BA1_MATRIC and B.BA1_TIPUSU = 'T' and D_E_L_E_T_ = ' ' )  NOME_EMPREGADO, "
	cQuery += "        BA1_NOMUSR  NOME_DEPENDENTE, "
	cQuery += "        BA1_CPFUSR  CPF_DEPENDENTE,  "      
//	cQuery += "        TO_DATE(BA1_DATNAS, 'YYYYMMDD')  DATA_NASCIMENT, "
	cQuery += "        substr(BA1_DATNAS,7,2)||'/'||substr(BA1_DATNAS,5,2)||'/'||substr(BA1_DATNAS,1,4)  DATA_NASCIMENT, "
//	cQuery += "        DECODE(BA1_SEXO, '1', 'MASCULINO','FEMININO') SEXO, "        
	cQuery += "        (select BRP_DESCRI from BRP010 where BA1_GRAUPA = BRP_CODIGO and D_E_L_E_T_ = ' ' )  TIPO_DEPENDENCIA , "
	cQuery += "        BA1_YMTODO, "
	cQuery += "        RETORNA_DESC_PLANO_MS('C',BA1_CODINT, BA1_CODEMP,BA1_MATRIC,BA1_TIPREG) || '+' ||((select RETORNA_DESC_PLANO_MS('C',C.BA1_CODINT,C.BA1_CODEMP,C.BA1_MATRIC,C.BA1_TIPREG) from BA1010 C where BA1.BA1_YMTODO = C.BA1_CODINT || C.BA1_CODEMP || C.BA1_MATRIC || C.BA1_TIPREG || C.BA1_DIGITO and C.BA1_SUBCON = '000000002' and D_E_L_E_T_ = ' ' )) PLANO , "
	cQuery += "        BM1_VALOR "
	cQuery += " FROM " + RETSQLNAME("BA1") +  " BA1 INNER JOIN " + RETSQLNAME("BM1") + " BM1 ON "
	cQuery += "            BM1_FILIAL = ' '            "
	cQuery += "            AND BM1_CODINT = BA1_CODINT "
	cQuery += "            AND BM1_CODEMP = BA1_CODEMP "
	cQuery += "            AND BM1_MATRIC = BA1_MATRIC "
	cQuery += "            AND BM1_TIPREG = BA1_TIPREG "
	cQuery += "            AND BM1.D_E_L_E_T_ = ' ' "
	
	cQuery += " WHERE BA1_FILIAL = ' '  "
	cQuery += "      AND BA1_CODINT = '0001' "
	cQuery += "      AND BA1_CODEMP BETWEEN '" + cEmpDe + "' AND '"  + cEmpAte + "' "        
	cQuery += "      AND BM1_ANO = '" + cAno + "' "
	cQuery += "      AND BM1_MES = '" + cMes + "' "
	cQuery += "      AND BM1_CODTIP in( '101','102' ) "
	cQuery += "      and BA1.D_E_L_E_T_ = ' ' "
	
	//cQuery += "   AND BA1.BA1_NOMUSR LIKE ('%ARLETTE CASTANHEIRA DE ALENCAR%')
	
    if lAgl
	cQuery += "      ) "
	cQuery += "      group by MATRICULA, NOME_EMPREGADO,  NOME_DEPENDENTE, SEXO, CPF_DEPENDENTE, DATA_NASCIMENT, TIPO_DEPENDENCIA, BA1_YMTODO, PLANO "
	EndIf
	cQuery := ChangeQuery( cQuery )
	DbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),"R195",.T.,.T.)         

	// Monta Cabecalho "Fixo"
	aCabec := {"MATRICULA",;
		"NOME EMPREGADO",;
		"NOME DEPENDENTE",; 
		"CPF DEPENDENTE",;  
		"SEXO",;
		"DATA NASCIMENTO",;
		"SEXO",;
		"TIPO DEPENDENCIA",;
		"PLANO",;
		"VALOR"}
			
		While ! R195->(Eof()) 
			IncProc()
			
			AADD(aDados,{R195->MATRICULA, ;
						 R195->NOME_EMPREGADO,;
						 R195->NOME_DEPENDENTE,;
						 R195->CPF_DEPENDENTE,; 
						 R195->SEXO,;
						 R195->DATA_NASCIMENT,;
						 R195->SEXO,;
						 R195->TIPO_DEPENDENCIA,;
						 R195->PLANO,;
			  			 R195->BM1_VALOR})  
			
			R195->(DbSkip())       
			
		EndDo

	aAdd(aDados ,{"Fim"} )
	//Abre excel 
    DlgToExcel({{"ARRAY"," " ,aCabec,aDados}})
If Select("R195") > 0
	dbSelectArea("R195")
	dbCloseArea()
EndIf      

 
*************************************************************************************************************************
//AJUSTAR "COPPRO"
Static Function AjustaSX1      

 
Local aHelpPor := {}
//Monta Help

PutSx1(cPerg,"01","Empresa de:  "  ,"","","mv_ch01","C",04,0,0,"C","","","","","mv_par01","","","","","","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"02","Empresa ate:  "  ,"","","mv_ch02","C",04,0,0,"C","","","","","mv_par02","","","","","","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"03","Ano:  "  ,"","","mv_ch03","C",04,0,0,"C","","","","","mv_par03","","","","","","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"04","Mes:  "  ,"","","mv_ch04","C",02,0,0,"C","","","","","mv_par04","","","","","","","","","","","","","","","","",{},{},{})
//PutSx1(cPerg,"05","Aglutina ?"  ,"","","mv_ch05","N",01,0,0,"C","","mv_par05","Sim ","","","","Nao","","","","","","","","","","","","","","" , "" , "" , "", "", "" )

Return	