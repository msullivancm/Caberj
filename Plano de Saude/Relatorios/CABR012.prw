#INCLUDE "rwmake.ch"
#INCLUDE "protheus.ch"
#INCLUDE "TopConn.ch"
#include "TBICONN.CH"    

#DEFINE c_ent CHR(13) + CHR(10)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัอออออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCABR012      บAutor  ณ PAULO MOTTA        บ Data ณ OUTUBRO/18  บฑฑ
ฑฑฬออออออออออุอออออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ  GERA PLANILHA PARA MOVIMENTACAO DE CARTIRA (CADASTRO)        บฑฑ 
ฑฑฬออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Projeto CABERJ                                                บฑฑ      
ฑฑศออออออออออฯอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function CABR012()   
      
Processa({||PCABR012()},'Processando...')

Return

Static Function PCABR012

Local aSaveArea	:= {} 

Local aCabec := {}
Local aDados := {} 

Local cRefDe  := " "   
Local cRefAte := " "                                           
Local cRDA    := " "  
Local cRDASOL := " "   
Local nValDe  := 0   
Local nValAte := 0   
Local cTpCust := " "   
Local nProj   := 0   
Local cEmp    := " "
Local cEmp012 := " " 
Local cEmp012 := " "    
Local nI 	  := 0     

Private cPerg := "CAB012"

aSaveArea	:= GetArea()
AjustaSX1()    
 
//Monta tabela/parametro das functiions conforme Empresa(Caberj/Integral) 
If cEmpAnt = "01"  
  cEmp012 := "'C'"
Else       
  cEmp012 := "'I'"
End if  

//ler parametros 
If Pergunte(cPerg,.T.)   
    cRefDe  := Substr(DToS(MonthSub(mv_par01,11)),1,8)
   	cRefAte := Substr(DToS(mv_par01),1,8)
 	cEmp    := mv_par02  
	cPlano  := mv_par03     
else
    Return	
EndIf      

//Monta query 
cQuery := " SELECT (CASE WHEN A.BA1_DATBLO = ' ' THEN 'ENTRANTE' ELSE 'SAINTE' END) MOVIMENTO,  " + c_ent  
cQuery += "        BA1_CODINT|| BA1_CODEMP|| BA1_MATRIC|| BA1_TIPREG|| BA1_DIGITO MATRICULA," + c_ent   
cQuery += "        TRIM (BA1_NOMUSR) NOME,      " + c_ent   
cQuery += "        BA1_CPFUSR CPF," + c_ent   
cQuery += "        TRIM (D.BI3_CODIGO) COD_PLANO," + c_ent   
cQuery += "        TRIM (D.BI3_DESCRI) PLANO,   " + c_ent   
cQuery += "        BII_DESCRI TIPO_CONTRATACAO," + c_ent   
cQuery += "        RETORNA_DESCRI_GRUPO_PLANO ( TRIM(BI3_YGRPLA),BA1_CODPLA,"+cEmp012+") GRUPO_PLANO, " + c_ent       
cQuery += "        BA1_CODEMP CODEMP,     " + c_ent   
cQuery += "        RETORNA_DESCRI_GRUPOEMP ("+cEmp012+",BA1_CODEMP) NOMEEMP," + c_ent     
cQuery += "        BA1_CONEMP CONTRATO," + c_ent       
cQuery += "        BA1_SUBCON SUBCONTRATO," + c_ent   
cQuery += "        RETORNA_DESC_SUBCONTRATO ("+cEmp012+",BA1_CODEMP,BA1_CONEMP,BA1_SUBCON) NOMESUBCON," + c_ent   
cQuery += "        BA1_MATVID MATVID," + c_ent       
cQuery += "        BA1_TRAORI MAT_ORIGEM," + c_ent   
cQuery += "        BA1_TRADES MAT_DESTINO, " + c_ent    
cQuery += "       (SELECT DECODE(COUNT(*),'0','N','S') X " + c_ent      
cQuery += "        FROM   " + RetSqlName('BA1') + " E" + c_ent 
cQuery += "        WHERE  E.BA1_FILIAL  = A.BA1_FILIAL" + c_ent 
cQuery += "        AND    E.BA1_MATVID  = A.BA1_MATVID" + c_ent 
cQuery += "        AND    E.BA1_MATRIC <> A.BA1_MATRIC" + c_ent 
cQuery += "        AND    E.BA1_DATINC  < A.BA1_DATINC" + c_ent 
cQuery += "        AND    E.D_E_L_E_T_ = ' ') EXISTE_MAT_ANT," + c_ent 
cQuery += "       (SELECT DECODE(COUNT(*),'0','N','S') X" + c_ent    
cQuery += "        FROM   " + RetSqlName('BA1') + " E" + c_ent 
cQuery += "        WHERE  E.BA1_FILIAL  = A.BA1_FILIAL" + c_ent 
cQuery += "        AND    E.BA1_MATVID  = A.BA1_MATVID" + c_ent 
cQuery += "        AND    E.BA1_MATRIC <> A.BA1_MATRIC" + c_ent 
cQuery += "        AND    E.BA1_DATINC  > A.BA1_DATINC" + c_ent 
cQuery += "        AND    E.D_E_L_E_T_ = ' ') EXISTE_MAT_POST,      " + c_ent   
cQuery += "       VERIFICA_UPDOWNGRADE_PL("+cEmp012+",BA1_CODINT,BA1_CODEMP,BA1_MATRIC,BA1_TIPREG,BA1_DIGITO) UPDOWN," + c_ent   
cQuery += "       (CASE WHEN A.BA1_DATINC >= '"+cRefDe+"' THEN 'S' ELSE 'N' END) REGRA_INCLUSAO," + c_ent 
cQuery += "       (CASE WHEN A.BA1_DATBLO >= '"+cRefDe+"' THEN 'S' ELSE 'N' END) REGRA_BLOQUEIO," + c_ent  
cQuery += "       TO_DATE(TRIM(A.BA1_DATINC),'YYYYMMDD') DT_INCLUSAO," + c_ent 
cQuery += "       TRUNC(TO_DATE(TRIM(A.BA1_DATBLO),'YYYYMMDD'),'MM') DT_BLOQ, " + c_ent  
cQuery += "       TO_DATE(TRIM(A.BA1_YDTDIG),'YYYYMMDD') DT_DIGIT, " + c_ent 
cQuery += "       TO_DATE(TRIM(BA1_DATNAS),'YYYYMMDD') DT_NASCIMENTO, " + c_ent  
cQuery += "       (SELECT DESC_FAIXA FROM FAIXA_ETARIA WHERE IDADE_S(BA1_DATNAS) BETWEEN IDADE_INICIAL AND IDADE_FINAL AND  TIPO_FAIXA=3) FAIXA, " + c_ent 
cQuery += "       CASE WHEN BA1_SEXO = '1' THEN 'MASCULINO' " + c_ent    
cQuery += "            WHEN BA1_SEXO = '2' THEN 'FEMININO'" + c_ent 
cQuery += "            ELSE BA1_SEXO" + c_ent 
cQuery += "            END AS SEXO," + c_ent 
cQuery += "       BA1_EMAIL EMAIL," + c_ent 
cQuery += "       (TRIM(BA1_DDD)||' '||TRIM(BA1_TELEFO)||' '||TRIM(BA1_YCEL)||' '||TRIM(BA1_YTEL2)) FONES, " + c_ent 
cQuery += "       BA1_ESTADO UF, " + c_ent     
cQuery += "       BA1_MUNICI MUNICIPIO, " + c_ent 
cQuery += "       BA1_BAIRRO BAIRRO, " + c_ent 
cQuery += "       CASE WHEN A.BA1_TIPUSU = 'T' THEN 'TITULAR' " + c_ent 
cQuery += "            WHEN A.BA1_TIPUSU = 'D' THEN 'DEPENDENTE'" + c_ent 
cQuery += "            WHEN A.BA1_TIPUSU = 'A' THEN 'AGREGADADO'" + c_ent 
cQuery += "            ELSE A.BA1_TIPUSU" + c_ent 
cQuery += "            END AS TP_USUARIO," + c_ent 
cQuery += "       TRIM (B.BRP_DESCRI) PARENTESCO, " + c_ent 
cQuery += "       (CASE WHEN TRIM(A.BA1_MOTBLO) IS NULL THEN ' '" + c_ent 
cQuery += "             ELSE " + c_ent   
If cEmpAnt = "01" 
  cQuery += "               (CASE WHEN A.BA1_MOTBLO IN ('001','485','003') THEN 'S' ELSE 'N' END) " + c_ent
Else
  cQuery += "               (CASE WHEN A.BA1_MOTBLO IN ('001','003','995','749') THEN 'S' ELSE 'N' END)" + c_ent 
Endif
cQuery += "             END) OBITO_INADPLIM," + c_ent 
cQuery += "        A.BA1_MOTBLO MOTBLO," + c_ent 
cQuery += "       (CASE WHEN BA1_MOTBLO <> ' '" + c_ent 
cQuery += "             THEN" + c_ent   
cQuery += "               (SELECT MAX(BTN_VALFAI) X" + c_ent 
cQuery += "                FROM " + RetSqlName('BTN') + " BTN " + c_ent  
cQuery += "                WHERE  BTN_FILIAL = '  ' " + c_ent 
cQuery += "                AND    BTN_CODIGO = BA1_CODINT||BA1_CODEMP" + c_ent 
cQuery += "                AND    BTN_NUMCON = BA1_CONEMP" + c_ent 
cQuery += "                AND    BTN_SUBCON = BA1_SUBCON" + c_ent 
cQuery += "                AND    BTN_CODPRO = BA1_CODPLA" + c_ent 
cQuery += "                AND    SIGA.IDADE_S(BA1_DATNAS) BETWEEN BTN_IDAINI AND BTN_IDAFIN" + c_ent 
cQuery += "                AND    BTN_TABVLD = ' '" + c_ent 
cQuery += "                AND    D_E_L_E_T_ = ' ') " + c_ent 
cQuery += "             ELSE" + c_ent 
cQuery += "               RETORNA_VL_ULT_MENSALIDADE('"+cEmpAnt+"',BA1_CODINT,BA1_CODEMP,BA1_MATRIC,BA1_TIPREG) " + c_ent 
cQuery += "             END) VL_ULT_MEN_RETOR,    " + c_ent  
cQuery += "      OBTER_DESC_MOT_BLOQ("+cEmp012+",  " + c_ent       
cQuery += "                          SUBSTR(RETORNA_NIVEL_BLOQ(BA1_CODINT,BA1_CODEMP,BA1_MATRIC,BA1_TIPREG,BA1_DATBLO,"+cEmp012+"),1,1)," + c_ent
cQuery += "                          BA1_MOTBLO) MOTIVO,   " + c_ent
cQuery += "      TO_CHAR(NVL(ADD_MONTHS(TRUNC(TO_DATE(TRIM(A.BA1_DATBLO),'YYYYMMDD'),'MM'),-11),TO_DATE('"+cRefDe+"','YYYYMMDD')),'YYYY/MM') REF_SIN_DE," + c_ent
cQuery += "      TO_CHAR(NVL(TRUNC(TO_DATE(TRIM(A.BA1_DATBLO),'YYYYMMDD'),'MM'),TO_DATE("+cRefAte+",'YYYYMMDD')),'YYYY/MM') REF_SIN_ATE,  " + c_ent
cQuery += "      RETORNA_SINISTRALIDADE_MS_CAB("+cEmp012+",'S',BA1_CODINT,BA1_CODEMP,BA1_MATRIC,BA1_TIPREG, BA1_DIGITO,  " + c_ent 
cQuery += "                                    NVL(ADD_MONTHS(TRUNC(TO_DATE(TRIM(A.BA1_DATBLO),'YYYYMMDD'),'MM'),-11),TO_DATE('"+cRefDe+"','YYYYMMDD')), " + c_ent
cQuery += "                                    NVL(TRUNC(TO_DATE(TRIM(A.BA1_DATBLO),'YYYYMMDD'),'MM'),TO_DATE("+cRefAte+",'YYYYMMDD'))) SINISTRALIDADE," + c_ent
cQuery += "      RETORNA_SINISTRALIDADE_MS_CAB("+cEmp012+",'C',BA1_CODINT,BA1_CODEMP,BA1_MATRIC,BA1_TIPREG, BA1_DIGITO,  " + c_ent
cQuery += "                                    NVL(ADD_MONTHS(TRUNC(TO_DATE(TRIM(A.BA1_DATBLO),'YYYYMMDD'),'MM'),-11),TO_DATE('"+cRefDe+"','YYYYMMDD')),    " + c_ent
cQuery += "                                    NVL(TRUNC(TO_DATE(TRIM(A.BA1_DATBLO),'YYYYMMDD'),'MM'),TO_DATE("+cRefAte+",'YYYYMMDD'))) CUSTO," + c_ent
cQuery += "      RETORNA_SINISTRALIDADE_MS_CAB("+cEmp012+",'R',BA1_CODINT,BA1_CODEMP,BA1_MATRIC,BA1_TIPREG, BA1_DIGITO," + c_ent
cQuery += "                                    NVL(ADD_MONTHS(TRUNC(TO_DATE(TRIM(A.BA1_DATBLO),'YYYYMMDD'),'MM'),-11),TO_DATE('"+cRefDe+"','YYYYMMDD')), " + c_ent
cQuery += "                                    NVL(TRUNC(TO_DATE(TRIM(A.BA1_DATBLO),'YYYYMMDD'),'MM'),TO_DATE('"+cRefAte+"','YYYYMMDD'))) RECEITA," + c_ent
If cEmpAnt = "01" 
  cQuery += "               IND_RETORNA_SALDO_DEVIDO(BA1_CODINT,BA1_CODEMP,BA1_MATRIC,TO_CHAR((SYSDATE-3),'YYYYMMDD'),'V')    SALDO_EM_ABERTO    " + c_ent
Else
  cQuery += "               IND_RETORNA_SALDO_DEVIDO_INT(BA1_CODINT,BA1_CODEMP,BA1_MATRIC,TO_CHAR((SYSDATE-3),'YYYYMMDD'),'V') SALDO_EM_ABERTO    " + c_ent 
Endif
cQuery += " FROM " + RetSqlName('BA1') + " A" + c_ent  
cQuery += " RIGHT JOIN " + RetSqlName('BRP') + " B ON (A.BA1_GRAUPA = B.BRP_CODIGO)   " + c_ent 
cQuery += " RIGHT JOIN " + RetSqlName('BI3') + " D ON (A.BA1_CODPLA = D.BI3_CODIGO)   " + c_ent 
cQuery += " RIGHT JOIN " + RetSqlName('BII') + " F ON (D.BI3_TIPCON = F.BII_CODIGO)     " + c_ent 
cQuery += " WHERE ( (A.BA1_DATINC >= '"+cRefDe+"') or (A.BA1_DATBLO >= '"+cRefDe+"'))      " + c_ent 
cQuery += " AND BI3_CODSEG <> '004'   " + c_ent     
If mv_par02 <> ' '  
  cQuery += " AND BA1_CODEMP = '"+mv_par02+"' " + c_ent         
Endif  
If mv_par03 <> ' '
  cQuery += " AND BA1_CODPLA = '"+mv_par03+"' " + c_ent  
Endif       
If cEmpAnt = "01" 
  cQuery += " AND BA1_CODEMP NOT IN ('0004','0009') " + c_ent  
Endif
cQuery += " AND A.D_E_L_E_T_ = ' '   " + c_ent 
cQuery += " AND B.D_E_L_E_T_ = ' '   " + c_ent 
cQuery += " AND D.D_E_L_E_T_ = ' '   " + c_ent 
cQuery += " ORDER BY BA1_NOMUSR,TO_DATE(TRIM(A.BA1_DATINC),'YYYYMMDD'),BA1_CODINT|| BA1_CODEMP|| BA1_MATRIC|| BA1_TIPREG|| BA1_DIGITO  " + c_ent 

memowrite("C:\TEMP\sql012.sql",cQuery)      
                                                 
If Select("R012") > 0
	dbSelectArea("R012")
	dbCloseArea()
EndIf

DbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),"R012",.T.,.T.)         

For nI := 1 to 5
	IncProc('Processando...')
Next

If ! R012->(Eof())
	nSucesso := 0
	aCabec := {"MOVIMENTO","MATRICULA","NOME","CPF","COD_PLANO","PLANO","TIPO_CONTRATACAO","GRUPO_PLANO","CODEMP","NOMEEMP","CONTRATO","SUBCONTRATO",;    
               "NOMESUBCON","MATVID","MAT_ORIGEM","MAT_DESTINO","EXISTE_MAT_ANT","EXISTE_MAT_POST","UPDOWN","REGRA_INCLUSAO","REGRA_BLOQUEIO", "DT_INCLUSAO",;   
               "DT_BLOQ","DT_DIGIT","DT_NASCIMENTO","FAIXA","SEXO","EMAIL","FONES","UF","MUNICIPIO","BAIRRO","PARENTESCO","OBITO_INADPLIM","MOTBLO",;   
               "VL_ULT_MEN_RETOR","MOTIVO","REF_SIN_DE","REF_SIN_ATE","SINISTRALIDADE","CUSTO","RECEITA","SALDO_EM_ABERTO"} 
	R012->(DbGoTop())
	While ! R012->(Eof()) 
		IncProc()		
		aaDD(aDados,{R012->MOVIMENTO,R012->MATRICULA,R012->NOME,R012->CPF,R012->COD_PLANO,R012->PLANO,R012->TIPO_CONTRATACAO,R012->GRUPO_PLANO,;         
                     R012->CODEMP,R012->NOMEEMP,R012->CONTRATO,R012->SUBCONTRATO,R012->NOMESUBCON,R012->MATVID,R012->MAT_ORIGEM,R012->MAT_DESTINO,;    
                     R012->EXISTE_MAT_ANT,R012->EXISTE_MAT_POST,R012->UPDOWN,R012->REGRA_INCLUSAO,R012->REGRA_BLOQUEIO,R012->DT_INCLUSAO,R012->DT_BLOQ,R012->DT_DIGIT,;    
                     R012->DT_NASCIMENTO,R012->FAIXA,R012->SEXO,R012->EMAIL,R012->FONES,R012->UF,R012->MUNICIPIO,R012->BAIRRO,R012->PARENTESCO,;
                     R012->OBITO_INADPLIM,R012->MOTBLO,R012->VL_ULT_MEN_RETOR,R012->MOTIVO,R012->REF_SIN_DE,R012->REF_SIN_ATE,R012->SINISTRALIDADE,;  
                     R012->CUSTO,R012->RECEITA,R012->SALDO_EM_ABERTO})  
		
		R012->(DbSkip())
	End
	 
	//Abre excel 
    DlgToExcel({{"ARRAY"," " ,aCabec,aDados}})

EndIf	

If Select("R012") > 0
	dbSelectArea("R012")
	dbCloseArea()
EndIf      

 
*************************************************************************************************************************
//AJUSTAR "COPPRO"
Static Function AjustaSX1      

 
Local aHelpPor := {}
//Monta Help
PutSx1(cPerg,"01","Referencia  "  ,"","","mv_ch01","D",08,0,0,"C","","","","","mv_par01","","","","","","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"02","Empresa     "  ,"","","mv_ch02","C",04,0,0,"C","","BG9CON","","","mv_par02","","","","","","","","","","","","","","","","",{},{},{})    
PutSx1(cPerg,"03","Plano       "  ,"","","mv_ch03","C",06,0,0,"C","","B2DPLS","","","mv_par03","","","","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "", "" )  

Return	