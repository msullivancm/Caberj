#INCLUDE "rwmake.ch"
#INCLUDE "protheus.ch"
#INCLUDE "TopConn.ch"
#include "TBICONN.CH"

#DEFINE c_ent CHR(13) + CHR(10)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABR286      ºAutor  ³ PAULO MOTTA           º Data ³ JUNHO/21 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³  GERA PLANILHA RDA X REDE                                     º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³  Relatórios / Projeto Caberj                                  º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function CABR286()

	Private cPerg 		:= "RELIRDA"
	Private cClasse		:= " "
	Private cEspec		:= " "
	
	AjustaSX1()
	
	//ler parametros
	Pergunte(cPerg,.T.)

	cClasse		:= trim(mv_par01)
	cEspec		:= trim(mv_par02)
	
	Processa({||REPROAT()},'Gerando Relatório Crystal...')

	If MsgYesNo("Deseja Emitir o Relatório em Excel? ") 
		Processa({||PCABR286()},'Processando...')
	endIf

Return

//Inclusão da chamada do relatório em Crystal - ANDERSON / GLPI 75192
Static Function REPROAT()  

	Private cCRPar      := "1;0;1;Relatório RDA x Especialidade x Produto" 
	Private cParam1     := " " 
	Private cCrystal    := "RELIRDA"    

	cParam1 :=  SUBSTR(cEmpAnt,2,1)+";"+cClasse+";"+cEspec
	MsgInfo(cParam1)
	CallCrys(cCrystal,cParam1,cCRPar)   

Return


Static Function PCABR286()

	Local aSaveArea	:= ""

	Local aCabec := {}
	Local aDados := {}
	Local cEmp286 := ""

	Local nI 	  := 0

	//Private cPerg := "CAB286"

	aSaveArea	:= GetArea()
	//AjustaSX1()

	If cEmpAnt = "01"
		cEmp286 := "'C'"
	Else
		cEmp286 := "'I'"
	Endif

	//ler parametros
	//Pergunte(cPerg,.T.)

	//Monta query
	cQuery := "SELECT DISTINCT                                             " + c_ent
	cQuery += "BAU_CODIGO CODIGO,                                          " + c_ent
	cQuery += "NVL(TRIM(BAU_NFANTA),BAU_NOME) AS NOME,                     " + c_ent
	cQuery += "BAU_TIPPRE CLASSE,                                          " + c_ent
	cQuery += "DECODE(BAU_GUIMED,'0','NÃ£o','Sim') LIVRO_MEDICO,           " + c_ent
	cQuery += "TRIM(BB8.BB8_MUN) AS MUNICIPIO  ,                           " + c_ent
	cQuery += "TRIM(BB8_BAIRRO)  BAIRRO ,                                  " + c_ent
	cQuery += "TRIM(BB8_END) ENDERECO ,                                    " + c_ent
	cQuery += "TRIM(BB8_NR_END) NUMERO,                                    " + c_ent
	cQuery += "TRIM(BB8_COMEND) COMPLEMENTO,                               " + c_ent
	cQuery += "BAQ_DESCRI ESPECIALIDADE,                                   " + c_ent
	cQuery += "(SELECT BID_YDDD                                            " + c_ent
	cQuery += " FROM " + RetSqlName('BID') +                            "  " + c_ent
	cQuery += " WHERE BID_FILIAL=' '                                       " + c_ent
	cQuery += " AND BID_CODMUN=BB8_CODMUN AND D_E_L_E_T_=' ') AS DDD ,     " + c_ent
	cQuery += "BB8_TEL AS TELEFONES ,                                      " + c_ent
	cQuery += "TO_DATE(TRIM(BAU_DTINCL),'YYYYMMDD') INCLUSAO,              " + c_ent
	cQuery += "BB8_EST AS UF  ,                                            " + c_ent
	cQuery += "REDES (" + cEmp286  + ",BAU_CODIGO,NULL,NULL) REDES   ,     " + c_ent
	cQuery += "OBTER_REGIAO(" + cEmp286  + ",BB8_CEP) REGIAO,              " + c_ent
	cQuery += "TRIM(BAU_EMAIL) EMAILPRINC                                  " + c_ent
	cQuery += "FROM " + RetSqlName('BAU') + " BAU,                         " + c_ent
	cQuery += RetSqlName('BB8') + " BB8,                                   " + c_ent
	cQuery += RetSqlName('BAX') + " BAX,                                   " + c_ent
	cQuery += RetSqlName('BAQ') + " BAQ                                    " + c_ent
	cQuery += "WHERE BAU_FILIAL=' '                                        " + c_ent
	cQuery += "AND BAX_FILIAL=' '                                          " + c_ent
	cQuery += "AND BB8_FILIAL=' '                                          " + c_ent
	//cQuery += "AND BB8_EST=NVL(TRIM('RJ'),BB8_EST)                         " + c_ent
	cQuery += "AND BAU.BAU_CODIGO = BB8.BB8_CODIGO                         " + c_ent
	cQuery += "AND BB8.BB8_CODIGO = BAX.BAX_CODIGO                         " + c_ent
	cQuery += "AND BB8.BB8_CODLOC = BAX.BAX_CODLOC                         " + c_ent
	cQuery += "AND BAX.BAX_CODINT = BAQ.BAQ_CODINT                         " + c_ent
	cQuery += "AND BAX.BAX_CODESP = BAQ.BAQ_CODESP                         " + c_ent
	cQuery += "AND BAX.D_E_L_E_T_ = ' '                                    " + c_ent
	cQuery += "AND BAQ.D_E_L_E_T_ = ' '                                    " + c_ent
	cQuery += "AND BB8.D_E_L_E_T_ = ' '                                    " + c_ent
	cQuery += "AND BAU.D_E_L_E_T_ = ' '                                    " + c_ent
	cQuery += "AND BB8_DATBLO = '        '                                 " + c_ent
	cQuery += "AND BAX_DATBLO = '        '                                 " + c_ent
	cQuery += "AND BAU_CODBLO = ' '                                        " + c_ent
	cQuery += "AND BAU_DATBLO = ' '                                        " + c_ent
	If !Empty(cClasse)
		cQuery += "AND BAU_TIPPRE = '" + cClasse + "'" + c_ent
	Endif
	If !Empty(cEspec)
		cQuery += "AND BAQ_CODESP = '" + cEspec + "'" + c_ent
	Endif
	cQuery += "ORDER BY 1                                                  " + c_ent

	//memowrite("C:\TEMP\sql286.sql",cQuery)

	If Select("R286") > 0
		dbSelectArea("R286")
		dbCloseArea()
	EndIf

	DbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),"R286",.T.,.T.)

	For nI := 1 to 5
		IncProc('Processando...')
	Next

	If ! R286->(Eof())
		nSucesso := 0
		aCabec := {"CODIGO","NOME","CLASSE","LIVRO_MEDICO","MUNICIPIO","BAIRRO",;
			"ENDERECO","NUMERO","COMPLEMENTO","ESPECIALIDADE","DDD","TELEFONES",;
			"INCLUSAO","UF","REDES","REGIAO","EMAILPRINC"}
		R286->(DbGoTop())
		While ! R286->(Eof())
			IncProc()
			aaDD(aDados,{R286->CODIGO,R286->NOME,R286->CLASSE,R286->LIVRO_MEDICO,R286->MUNICIPIO,R286->BAIRRO,;
				R286->ENDERECO,R286->NUMERO,R286->COMPLEMENTO,R286->ESPECIALIDADE,R286->DDD,R286->TELEFONES,;
				R286->INCLUSAO,R286->UF,R286->REDES,R286->REGIAO,R286->EMAILPRINC})
			R286->(DbSkip())
		End
		//Abre excel
		DlgToExcel({{"ARRAY"," " ,aCabec,aDados}})

	EndIf

	If Select("R286") > 0
		dbSelectArea("R286")
		dbCloseArea()
	EndIf

Return

Static Function AjustaSX1()


	Local aHelpPor := {}
	//Monta Help

	PutSX1(cPerg,"01","Classe Rede  " ,"","","MV_CH1" ,"C",3,0,0,"G","","","","","MV_PAR01","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")
	PutSX1(cPerg,"02","Especialidade" ,"","","MV_CH2" ,"C",3,0,0,"G","","","","","MV_PAR02","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")
	
Return
