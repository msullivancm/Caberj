#INCLUDE "rwmake.ch"
#INCLUDE "protheus.ch"
#INCLUDE "TopConn.ch"
#include "TBICONN.CH"

#DEFINE c_ent CHR(13) + CHR(10)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัอออออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCABR291    บAutor  ณ ANDERSON RANGEL      บ Data ณ OUTUBRO/21  บฑฑ
ฑฑฬออออออออออุอออออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ  GERA PLANILHA DATA LIMITE BENEFICIARIO                       บฑฑ
ฑฑฬออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ  Relat๓rios / Projeto Caberj                                  บฑฑ
ฑฑศออออออออออฯอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function CABR291()

	Private cPerg 		:= "CABR291"
	Private nTipEmp		:= 0
	
	//Cria grupo de perguntas
	CABR291A(cPerg)
	
	If Pergunte(cPerg,.T.)  
		nTipEmp		:= mv_par01
	else
		Return	
	EndIf

	Processa({||PCABR291()},'Gerando Relat๓rio Data Limite...')

Return

Static Function CABR291A(cPerg)

	Local aHelpPor := {} 
	
	//help da pergunta
	aHelpPor := {}
	
	u_CABASX1(cPerg,"01","Operadora ?"		,"a","a","MV_CH1"	,"N",01,0,0,"C","",""		,"","","MV_PAR01","CABERJ"	,"","","","INTEGRAL","","","AMBAS"	,"","","","","","","","",aHelpPor,{},{},"")
	
Return


Static Function PCABR291()

	Local aSaveArea	:= ""
	Local aCabec  := {}
	Local aDados  := {}
	Local cQuery  := ""
	Local cQueryC := ""
	Local cQueryI := ""
	Local nI 	  := 0

	aSaveArea	:= GetArea()

	//Monta Query Caberj
	cQueryC += "SELECT 'CABERJ' OPERADORA, DT_INCLUSAO, TO_DATE(DT_NASC,'YYYYMMDD') DT_NASC, MATRICULA, BENEFICIARIO, PLANO, GRAU_PARENTESCO,                                                   " + c_ent
	cQueryC += "		DECODE(NIVEL,'P','PRODUTO','SUBCONTRATO') NIVEL, IDADE, IDADE_LIMITE||' ANOS' IDADE_LIMITE,                                                                                " + c_ent
	cQueryC += "		(CASE WHEN TO_NUMBER(IDADE_S(DT_NASC)) < TO_NUMBER(IDADE_LIMITE)                                                                                                           " + c_ent
	cQueryC += "			THEN 'EXPIRA EM: '||TO_CHAR(TO_NUMBER(IDADE_LIMITE) - TO_NUMBER(IDADE_S(DT_NASC)))||' ANOS'                                                                            " + c_ent
	cQueryC += "			ELSE 'EXPIRADO Hม: '||TO_CHAR(TO_NUMBER(IDADE_S(DT_NASC)) - TO_NUMBER(IDADE_LIMITE))||' ANOS'                                                                          " + c_ent
	cQueryC += "		END) STATUS                                                                                                                                                                " + c_ent
	cQueryC += "FROM (                                                                                                                                                                          " + c_ent
	cQueryC += "     SELECT DISTINCT TO_DATE(BA1_DATINC,'YYYYMMDD') DT_INCLUSAO, BA1_DATNAS DT_NASC, BA1_CODEMP EMPRESA,                                                                        " + c_ent
	cQueryC += "			SIGA.FORMATA_MATRICULA_MS(BA1_CODINT||BA1_CODEMP||BA1_MATRIC||BA1_TIPREG||BA1_DIGITO) MATRICULA,                                                                       " + c_ent
	cQueryC += "			TRIM(BA1_NOMUSR) BENEFICIARIO, SIGA.RETORNA_DESC_PLANO_MS('C', BA1_CODINT, BA1_CODEMP, BA1_MATRIC, BA1_TIPREG) PLANO,                                                  " + c_ent
	cQueryC += "			SIGA.RETORNA_DESCRI_GRAUPARENT('C', BA1_GRAUPA) GRAU_PARENTESCO, IDADE_S(BA1_DATNAS)||' ANOS' IDADE,                                                                   " + c_ent
	cQueryC += "			SIGA.RETORNA_DATA_LIMITE('C','N',BA1_CODINT, BA1_CODEMP, BA1_CONEMP, BA1_VERCON, BA1_SUBCON, BA1_VERSUB, BA1_CODPLA, BA1_VERSAO, BA1_TIPUSU, BA1_GRAUPA) NIVEL,        " + c_ent
	cQueryC += "			SIGA.RETORNA_DATA_LIMITE('C','I',BA1_CODINT, BA1_CODEMP, BA1_CONEMP, BA1_VERCON, BA1_SUBCON, BA1_VERSUB, BA1_CODPLA, BA1_VERSAO, BA1_TIPUSU, BA1_GRAUPA) IDADE_LIMITE  " + c_ent
	cQueryC += "     FROM BA1010 BA1                                                                                                                                                            " + c_ent
	cQueryC += "     WHERE BA1.D_E_L_E_T_ = ' '                                                                                                                                                 " + c_ent
	cQueryC += "     AND BA1_DATBLO = ' ' )                                                                                                                                                     " + c_ent
	cQueryC += "WHERE IDADE_LIMITE <> -1                                                                                                                                                        " + c_ent
	
	//Monta Query Integral
	cQueryI += "SELECT 'INTEGRAL' OPERADORA, DT_INCLUSAO, TO_DATE(DT_NASC,'YYYYMMDD') DT_NASC, MATRICULA, BENEFICIARIO, PLANO, GRAU_PARENTESCO,                                                     " + c_ent
	cQueryI += "		DECODE(NIVEL,'P','PRODUTO','SUBCONTRATO') NIVEL, IDADE, IDADE_LIMITE||' ANOS' IDADE_LIMITE,                                                                                     " + c_ent
	cQueryI += "		(CASE WHEN TO_NUMBER(IDADE_S(DT_NASC)) < TO_NUMBER(IDADE_LIMITE)                                                                                                                " + c_ent
	cQueryI += "			THEN 'EXPIRA EM: '||TO_CHAR(TO_NUMBER(IDADE_LIMITE) - TO_NUMBER(IDADE_S(DT_NASC)))||' ANOS'                                                                                 " + c_ent
	cQueryI += "			ELSE 'EXPIRADO Hม: '||TO_CHAR(TO_NUMBER(IDADE_S(DT_NASC)) - TO_NUMBER(IDADE_LIMITE))||' ANOS'                                                                               " + c_ent
	cQueryI += "		END) STATUS                                                                                                                                                                     " + c_ent
	cQueryI += "FROM (                                                                                                                                                                                  " + c_ent
	cQueryI += "     SELECT DISTINCT TO_DATE(BA1_DATINC,'YYYYMMDD') DT_INCLUSAO, BA1_DATNAS DT_NASC, BA1_CODEMP EMPRESA,                                                                                " + c_ent
	cQueryI += "			SIGA.FORMATA_MATRICULA_MS(BA1_CODINT||BA1_CODEMP||BA1_MATRIC||BA1_TIPREG||BA1_DIGITO) MATRICULA,                                                                            " + c_ent
	cQueryI += "			TRIM(BA1_NOMUSR) BENEFICIARIO, SIGA.RETORNA_DESC_PLANO_MS('I', BA1_CODINT, BA1_CODEMP, BA1_MATRIC, BA1_TIPREG) PLANO,                                                       " + c_ent
	cQueryI += "			SIGA.RETORNA_DESCRI_GRAUPARENT('I', BA1_GRAUPA) GRAU_PARENTESCO, IDADE_S(BA1_DATNAS)||' ANOS' IDADE,                                                                        " + c_ent
	cQueryI += "			SIGA.RETORNA_DATA_LIMITE('I','N',BA1_CODINT, BA1_CODEMP, BA1_CONEMP, BA1_VERCON, BA1_SUBCON, BA1_VERSUB, BA1_CODPLA, BA1_VERSAO, BA1_TIPUSU, BA1_GRAUPA) NIVEL,             " + c_ent
	cQueryI += "			SIGA.RETORNA_DATA_LIMITE('I','I',BA1_CODINT, BA1_CODEMP, BA1_CONEMP, BA1_VERCON, BA1_SUBCON, BA1_VERSUB, BA1_CODPLA, BA1_VERSAO, BA1_TIPUSU, BA1_GRAUPA) IDADE_LIMITE       " + c_ent
	cQueryI += "     FROM BA1020 BA1                                                                                                                                                                    " + c_ent
	cQueryI += "     WHERE BA1.D_E_L_E_T_ = ' '                                                                                                                                                         " + c_ent
	cQueryI += "     AND BA1_DATBLO = ' ' )                                                                                                                                                             " + c_ent
	cQueryI += "WHERE IDADE_LIMITE <> -1                                                                                                                                                                " + c_ent
	
	IF nTipEmp = 1
		cQuery := cQueryC
		CQuery += "ORDER BY 1, 4 "+ c_ent
	elseif nTipEmp = 2
		cQuery := cQueryI
		CQuery += "ORDER BY 1, 4 "+ c_ent
	else
		cQuery += cQueryI + c_ent
		cQuery += "UNION ALL " + c_ent
		cQuery += CQueryC + c_ent
		CQuery += "ORDER BY 1, 4 "+ c_ent
	EndIf
	
	Memowrite("C:\TEMP\cabr291.sql",cQuery)

	If Select("R291") > 0
		dbSelectArea("R291")
		dbCloseArea()
	EndIf

	DbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),"R291",.T.,.T.)

	For nI := 1 to 5
		IncProc('Processando...')
	Next

	If !R291->(Eof())
		nSucesso := 0
		aCabec := {"OPERADORA","DT_INCLUSAO","DT_NASC","MATRICULA","BENEFICIARIO","PLANO",;
					"GRAU_PARENTESCO","NIVEL","IDADE","IDADE_LIMITE","STATUS"}
		R291->(DbGoTop())
		While !R291->(Eof())
			IncProc()
			aaDD(aDados,{R291->OPERADORA,R291->DT_INCLUSAO,R291->DT_NASC,R291->MATRICULA,R291->BENEFICIARIO,R291->PLANO,;
				R291->GRAU_PARENTESCO,R291->NIVEL,R291->IDADE,R291->IDADE_LIMITE,R291->STATUS})
			R291->(DbSkip())
		End
		//Abre excel
		DlgToExcel({{"ARRAY"," " ,aCabec,aDados}})

	EndIf

	If Select("R291") > 0
		dbSelectArea("R291")
		dbCloseArea()
	EndIf

Return
