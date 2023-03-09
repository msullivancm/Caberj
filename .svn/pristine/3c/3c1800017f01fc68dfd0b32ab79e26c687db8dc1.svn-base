#INCLUDE "REPORT.CH"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "TOPCONN.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABR250   ºAutor  ³Angelo Henrique     º Data ³  18/04/18   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Relatório de Taxa de Adesão.                               º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CABERJ                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function CABR250()
	
	Local _aArea 	:= GetArea()
	Local oReport	:= Nil
	
	Private _cPerg	:= "CABR250"
	
	//Cria grupo de perguntas
	CABR250A(_cPerg)
	
	If Pergunte(_cPerg,.T.)
		
		//----------------------------------------------------
		//Validando se existe o Excel instalado na máquina
		//para não dar erro e o usuário poder visualizar em
		//outros programas como o LibreOffice
		//----------------------------------------------------
		If ApOleClient("MSExcel")
			
			oReport := CABR250B()
			oReport:PrintDialog()
			
		Else
			
			Processa({||CABR250E()},'Processando...')
			
		EndIf
		
	EndIf
	
	RestArea(_aArea)
	
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABR250A  ºAutor  ³Angelo Henrique     º Data ³  13/10/17   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Rotina responsavel pela geração das perguntas no relatório  º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CABERJ                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function CABR250A(cGrpPerg)
	
	Local aHelpPor := {} //help da pergunta
	
	aHelpPor := {}
	AADD(aHelpPor,"Informe a empresa De/Ate			")
	
	PutSx1(cGrpPerg,"01","Empresa De: ?"				,"a","a","MV_CH1"	,"C",TamSX3("BG9_CODIGO")[1]	,0,0,"G","","B7APLS","","","MV_PAR01","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")
	PutSx1(cGrpPerg,"02","Empresa Ate:?"				,"a","a","MV_CH2"	,"C",TamSX3("BG9_CODIGO")[1]	,0,0,"G","","B7APLS","","","MV_PAR02","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")
	
	aHelpPor := {}
	AADD(aHelpPor,"Informe o contrato De/ate  		")
	
	PutSx1(cGrpPerg,"03","Contrato De: ? "				,"a","a","MV_CH3"	,"C",TamSX3("BT5_NUMCON")[1]	,0,0,"G","","BE6PLS","","","MV_PAR03","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")
	PutSx1(cGrpPerg,"04","Contrato Ate:? "				,"a","a","MV_CH4"	,"C",TamSX3("BT5_NUMCON")[1]	,0,0,"G","","BE6PLS","","","MV_PAR04","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")
	
	aHelpPor := {}
	AADD(aHelpPor,"Informe o sub-contrato De/Ate	")
	
	PutSx1(cGrpPerg,"05","Sub-Contrato De: ? "			,"a","a","MV_CH5"	,"C",TamSX3("BQC_SUBCON")[1]	,0,0,"G","","BKCPLS","","","MV_PAR05","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")
	PutSx1(cGrpPerg,"06","Sub-Contrato Ate:? "			,"a","a","MV_CH6"	,"C",TamSX3("BQC_SUBCON")[1]	,0,0,"G","","BKCPLS","","","MV_PAR06","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")
	
	aHelpPor := {}
	AADD(aHelpPor,"Informe o Produto De/Ate			")
	
	PutSx1(cGrpPerg,"07","Produto De: ? "				,"a","a","MV_CH7"	,"C",TamSX3("BT6_CODPRO")[1]	,0,0,"G","","B2DPLS","","","MV_PAR07","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")
	PutSx1(cGrpPerg,"08","Produto Ate:? "				,"a","a","MV_CH8"	,"C",TamSX3("BT6_CODPRO")[1]	,0,0,"G","","B2DPLS","","","MV_PAR08","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")
	
	
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABR250B  ºAutor  ³Angelo Henrique     º Data ³  19/04/18   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Rotina que irá gerar as informações do relatório            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CABERJ                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function CABR250B
	
	Local oReport		:= Nil
	Local oSection1 	:= Nil
	
	oReport := TReport():New("CABR250","TAXA DE ADESAO",_cPerg,{|oReport| CABR244C(oReport)},"TAXA DE ADESAO")
	
	oReport:SetLandScape()
	
	oReport:oPage:setPaperSize(9)
	
	//--------------------------------
	//Primeira linha do relatório
	//--------------------------------
	oSection1 := TRSection():New(oReport,"BG9","BT5, BQC, BT6, BI3, BR6, BIH")
	
	TRCell():New(oSection1,"COD_EMPRESA" 		,"BG9")
	oSection1:Cell("COD_EMPRESA"):SetAutoSize(.F.)
	oSection1:Cell("COD_EMPRESA"):SetSize(TAMSX3("BG9_CODIGO")[1])
	
	TRCell():New(oSection1,"DESC_EMPRESA"		,"BG9")
	oSection1:Cell("DESC_EMPRESA"):SetAutoSize(.F.)
	oSection1:Cell("DESC_EMPRESA"):SetSize(TAMSX3("BG9_DESCRI")[1] - 40)
	
	TRCell():New(oSection1,"CONTRATO"			,"BT5")
	oSection1:Cell("CONTRATO"):SetAutoSize(.F.)
	oSection1:Cell("CONTRATO"):SetSize(TAMSX3("BT5_NUMCON")[1] + 5)
	
	TRCell():New(oSection1,"DATA_CONTRATO"		,"BT5")
	oSection1:Cell("DATA_CONTRATO"):SetAutoSize(.F.)
	oSection1:Cell("DATA_CONTRATO"):SetSize(12)
	
	TRCell():New(oSection1,"SUB_CONTRATO"		,"BQC")
	oSection1:Cell("SUB_CONTRATO"):SetAutoSize(.F.)
	oSection1:Cell("SUB_CONTRATO"):SetSize(TAMSX3("BQC_SUBCON")[1])
	
	TRCell():New(oSection1,"DATA_SUBCONTRATO"	,"BQC")
	oSection1:Cell("DATA_SUBCONTRATO"):SetAutoSize(.F.)
	oSection1:Cell("DATA_SUBCONTRATO"):SetSize(12)
	
	TRCell():New(oSection1,"NOME_SUBCONTRATO" 	,"BQC")
	oSection1:Cell("NOME_SUBCONTRATO"):SetAutoSize(.F.)
	oSection1:Cell("NOME_SUBCONTRATO"):SetSize(TAMSX3("BQC_DESCRI")[1] - 50)
	
	TRCell():New(oSection1,"COD_PRODUTO"		,"BT6")
	oSection1:Cell("COD_PRODUTO"):SetAutoSize(.F.)
	oSection1:Cell("COD_PRODUTO"):SetSize(TAMSX3("BT6_CODPRO")[1])
	
	TRCell():New(oSection1,"NOME_PRODUTO"		,"BI3")
	oSection1:Cell("NOME_PRODUTO"):SetAutoSize(.F.)
	oSection1:Cell("NOME_PRODUTO"):SetSize(TAMSX3("BI3_DESCRI")[1] - 30)
	
	TRCell():New(oSection1,"FORMA_COBRANCA"		,"BR6")
	oSection1:Cell("FORMA_COBRANCA"):SetAutoSize(.F.)
	oSection1:Cell("FORMA_COBRANCA"):SetSize(TAMSX3("BR6_CODFOR")[1])
	
	TRCell():New(oSection1,"TIPO_USUARIO"		,"BR6")
	oSection1:Cell("TIPO_USUARIO"):SetAutoSize(.F.)
	oSection1:Cell("TIPO_USUARIO"):SetSize(TAMSX3("BR6_TIPUSR")[1])
	
	TRCell():New(oSection1,"DESC_USUARIO"		,"BIH")
	oSection1:Cell("DESC_USUARIO"):SetAutoSize(.F.)
	oSection1:Cell("DESC_USUARIO"):SetSize(TAMSX3("BIH_DESCRI")[1])
	
	TRCell():New(oSection1,"VALOR_ADESAO"		,"BR6")
	oSection1:Cell("VALOR_ADESAO"):SetAutoSize(.F.)
	oSection1:Cell("VALOR_ADESAO"):SetSize(20)
	
Return oReport


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABR244B  ºAutor  ³Angelo Henrique     º Data ³  13/10/17   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Rotina para montar a query e trazer as informações no       º±±
±±º          ³relatório.                                                  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CABERJ                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function CABR244C(oReport)
	
	Local _aArea 		:= GetArea()
	Local _cQuery		:= ""
	
	Private oSection1 	:= oReport:Section(1)
	Private _cAlias1	:= GetNextAlias()
	
	//---------------------------------------------
	//CABR250D Realiza toda a montagem da query
	//facilitando a manutenção do fonte
	//---------------------------------------------
	_cQuery := CABR250D()
	
	If Select(_cAlias1) > 0
		(_cAlias1)->(DbCloseArea())
	EndIf
	
	DbUseArea(.T.,"TOPCONN",TcGenQry(,,_cQuery),_cAlias1,.T.,.T.)
	
	oSection1:Init()
	oSection1:SetHeaderSection(.T.)
	
	While !(_cAlias1)->(EOF())
		
		oReport:IncMeter()
		
		If oReport:Cancel()
			Exit
		EndIf
		
		oSection1:Cell("COD_EMPRESA"		):SetValue( (_cAlias1)->CD_EMP		)
		oSection1:Cell("DESC_EMPRESA"		):SetValue( (_cAlias1)->DSC_EMP		)
		oSection1:Cell("CONTRATO"			):SetValue( (_cAlias1)->CONT		)
		oSection1:Cell("DATA_CONTRATO"		):SetValue( (_cAlias1)->DT_CONT		)
		oSection1:Cell("SUB_CONTRATO"		):SetValue( (_cAlias1)->SUBCONT		)
		oSection1:Cell("DATA_SUBCONTRATO"	):SetValue( (_cAlias1)->DT_SUB		)
		oSection1:Cell("NOME_SUBCONTRATO"	):SetValue( (_cAlias1)->NM_SUB		)
		oSection1:Cell("COD_PRODUTO"		):SetValue( (_cAlias1)->CD_PROD		)
		oSection1:Cell("NOME_PRODUTO"		):SetValue( (_cAlias1)->NM_PROD		)
		oSection1:Cell("FORMA_COBRANCA"		):SetValue( (_cAlias1)->FM_COB		)
		oSection1:Cell("TIPO_USUARIO"		):SetValue( (_cAlias1)->TP_USU		)
		oSection1:Cell("DESC_USUARIO"		):SetValue( (_cAlias1)->DSC_USU		)
		oSection1:Cell("VALOR_ADESAO"		):SetValue( (_cAlias1)->VLR_ADES	)
		
		oSection1:PrintLine()
		
		(_cAlias1)->(DbSkip())
		
	EndDo
	
	oSection1:Finish()
	
	If Select(_cAlias1) > 0
		(_cAlias1)->(DbCloseArea())
	EndIf
	
	RestArea(_aArea)
	
Return(.T.)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABR250D  ºAutor  ³Angelo Henrique     º Data ³  24/10/16   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Rotina responsavel por tratar a query, facilitando assim    º±±
±±º          ³a manutenção do fonte.                                      º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CABERJ                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function CABR250D()
	
	Local _cQuery 	:= ""
	
	_cQuery += " SELECT																			" + CRLF	
	_cQuery += " 	BG9.BG9_CODIGO CD_EMP,														" + CRLF
	_cQuery += " 	TRIM(BG9.BG9_DESCRI) DSC_EMP,												" + CRLF
	_cQuery += " 	BT5.BT5_NUMCON CONT,														" + CRLF
	_cQuery += " 	SIGA.FORMATA_DATA_MS(BT5.BT5_DATCON) DT_CONT,								" + CRLF
	_cQuery += " 	BQC.BQC_SUBCON SUBCONT,														" + CRLF
	_cQuery += " 	SIGA.FORMATA_DATA_MS(BQC.BQC_DATCON) DT_SUB,								" + CRLF
	_cQuery += " 	TRIM(BQC.BQC_DESCRI) NM_SUB,												" + CRLF
	_cQuery += " 	BT6.BT6_CODPRO CD_PROD,														" + CRLF
	_cQuery += " 	TRIM(BI3.BI3_DESCRI) NM_PROD,												" + CRLF
	_cQuery += " 	BR6.BR6_CODFOR FM_COB,														" + CRLF
	_cQuery += " 	BR6.BR6_TIPUSR TP_USU,														" + CRLF
	_cQuery += " 	TRIM(BIH.BIH_DESCRI) DSC_USU,												" + CRLF
	_cQuery += " 	SIGA.EXIBE_MOEDA(BR6.BR6_VLRADE) VLR_ADES									" + CRLF
	_cQuery += " FROM																			" + CRLF
	
	//-- --------------------------------
	//-- GRUPO/EMPRESA
	//-- --------------------------------
	_cQuery += "     " + RetSqlName("BG9") + " BG9                      						" + CRLF
	
	//-- --------------------------------
	//-- CONTRATO
	//-- --------------------------------
	_cQuery += " 	INNER JOIN																	" + CRLF
	_cQuery += "     	" + RetSqlName("BT5") + " BT5                      						" + CRLF	
	_cQuery += " 	ON																			" + CRLF
	_cQuery += " 		BT5.BT5_FILIAL = '" + xFilial("BT5") + "'								" + CRLF
	_cQuery += " 		AND BT5.BT5_CODINT = BG9.BG9_CODINT										" + CRLF
	_cQuery += " 		AND BT5.BT5_CODIGO = BG9.BG9_CODIGO										" + CRLF
	_cQuery += " 		AND BT5.D_E_L_E_T_ = ' '												" + CRLF
	
	//-- --------------------------------
	//--PARAMETRO DE CONTRATO DE/ATE
	//-- --------------------------------
	If !Empty(MV_PAR03) .And. !Empty(MV_PAR04)
		
		_cQuery += " 		AND BT5.BT5_NUMCON BETWEEN '" + MV_PAR03 + "' AND '" + MV_PAR04 + "'" + CRLF
		
	EndIf
	
	//-- --------------------------------
	//-- SUBCONTRATO
	//-- --------------------------------
	_cQuery += " 	INNER JOIN
	_cQuery += "    	" + RetSqlName("BQC") + " BQC                      						" + CRLF
	_cQuery += " 	ON																			" + CRLF
	_cQuery += " 		BQC.BQC_FILIAL = '" + xFilial("BQC") + "'								" + CRLF
	_cQuery += " 		AND BQC.BQC_CODIGO = BT5.BT5_CODINT||BT5.BT5_CODIGO						" + CRLF
	_cQuery += " 		AND BQC.BQC_NUMCON = BT5.BT5_NUMCON										" + CRLF
	_cQuery += " 		AND BQC.BQC_VERCON = BT5.BT5_VERSAO										" + CRLF
	_cQuery += " 		AND BQC.BQC_CODINT = BT5.BT5_CODINT										" + CRLF
	_cQuery += " 		AND BQC.BQC_CODEMP = BT5.BT5_CODIGO										" + CRLF
	_cQuery += " 		AND BQC.BQC_DATBLO = ' '												" + CRLF
	_cQuery += " 		AND BQC.D_E_L_E_T_ = ' '												" + CRLF
	
	//-- --------------------------------
	//--PARAMETRO DE SUBCONTRATO DE/ATE
	//-- --------------------------------
	If !Empty(MV_PAR05) .And. !Empty(MV_PAR06)
		
		_cQuery += " 		AND BQC.BQC_SUBCON BETWEEN '" + MV_PAR05 + "' AND '" + MV_PAR06 + "'" + CRLF
		
	EndIf
	
	//-- --------------------------------
	//-- EMPRESA X CONTRATO X PRODUTO
	//-- --------------------------------
	_cQuery += " 	INNER JOIN																	" + CRLF
	_cQuery += "    		" + RetSqlName("BT6") + " BT6                      					" + CRLF
	_cQuery += " 	ON																			" + CRLF
	_cQuery += " 		BT6.BT6_FILIAL = '" + xFilial("BT6") + "'								" + CRLF
	_cQuery += " 		AND BT6.BT6_CODINT = BQC.BQC_CODINT										" + CRLF
	_cQuery += " 		AND BT6.BT6_CODIGO = BQC.BQC_CODEMP										" + CRLF
	_cQuery += " 		AND BT6.BT6_NUMCON = BQC.BQC_NUMCON										" + CRLF
	_cQuery += " 		AND BT6.BT6_VERCON = BQC.BQC_VERCON										" + CRLF
	_cQuery += " 		AND BT6.BT6_SUBCON = BQC.BQC_SUBCON										" + CRLF
	_cQuery += " 		AND BT6.BT6_VERSUB = BQC.BQC_VERSUB										" + CRLF
	_cQuery += " 		AND BT6.D_E_L_E_T_ = ' '												" + CRLF
	
	//-- --------------------------------
	//-- PARAMETRO DE PRODUTO DE/ATE
	//-- --------------------------------
	If !Empty(MV_PAR07) .And. !Empty(MV_PAR08)
		
		_cQuery += " 		AND BT6.BT6_CODPRO BETWEEN '" + MV_PAR07 + "' AND '" + MV_PAR08 + "'" + CRLF
		
	EndIf
	
	//-- --------------------------------
	//-- PRODUTO
	//-- --------------------------------
	_cQuery += " 	INNER JOIN																	" + CRLF
	_cQuery += "    	" + RetSqlName("BI3") + " BI3                 							" + CRLF
	_cQuery += " 	ON																			" + CRLF
	_cQuery += " 		BI3.BI3_FILIAL = '" + xFilial("BI3") + "'								" + CRLF
	_cQuery += " 		AND BI3.BI3_CODINT = BT6.BT6_CODINT										" + CRLF
	_cQuery += " 		AND BI3.BI3_CODIGO = BT6.BT6_CODPRO										" + CRLF
	_cQuery += " 		AND BI3.D_E_L_E_T_ = ' '												" + CRLF
	
	//-- --------------------------------
	//-- TAXA DE ADESAO X GRUPO X EMPRESA
	//-- --------------------------------
	_cQuery += " 	INNER JOIN																	" + CRLF
	_cQuery += "    	" + RetSqlName("BR6") + " BR6                      						" + CRLF
	_cQuery += " 	ON																			" + CRLF
	_cQuery += " 		BR6.BR6_FILIAL = '" + xFilial("BR6") + "'								" + CRLF					
	_cQuery += " 		AND BR6.BR6_CODIGO = BT6.BT6_CODINT||BT6.BT6_CODIGO						" + CRLF
	_cQuery += " 		AND BR6.BR6_NUMCON = BT6.BT6_NUMCON										" + CRLF
	_cQuery += " 		AND BR6.BR6_VERCON = BT6.BT6_VERCON										" + CRLF
	_cQuery += " 		AND BR6.BR6_SUBCON = BT6.BT6_SUBCON										" + CRLF
	_cQuery += " 		AND BR6.BR6_VERSUB = BT6.BT6_VERSUB										" + CRLF
	_cQuery += " 		AND BR6.BR6_CODPRO = BT6.BT6_CODPRO										" + CRLF
	_cQuery += " 		AND BR6.BR6_VERPRO = BT6.BT6_VERSAO										" + CRLF
	_cQuery += " 		AND BR6.D_E_L_E_T_ = ' '												" + CRLF
	
	//-- --------------------------------
	//-- TIPO DE USUARIOS
	//-- --------------------------------
	_cQuery += " 	INNER JOIN																	" + CRLF
	_cQuery += "    	" + RetSqlName("BIH") + " BIH                      						" + CRLF
	_cQuery += " 	ON																			" + CRLF
	_cQuery += " 		BIH.BIH_FILIAL = '" + xFilial("BIH") + "'								" + CRLF
	_cQuery += " 		AND BIH.BIH_CODTIP = BR6.BR6_TIPUSR										" + CRLF
	_cQuery += " 		AND BIH.D_E_L_E_T_ = ' '												" + CRLF
		
	_cQuery += " WHERE																			" + CRLF
	_cQuery += " 	BG9.BG9_FILIAL = '" + xFilial("BG9") + "'									" + CRLF
	_cQuery += " 	AND BG9.BG9_CODINT = '0001'													" + CRLF
	_cQuery += " 	AND BG9.D_E_L_E_T_ = ' '													" + CRLF
	
	//-- --------------------------------
	//-- PARAMETRO DE EMPRESA DE/ATE
	//-- --------------------------------
	If !Empty(MV_PAR01) .And. !Empty(MV_PAR02)
		
		_cQuery += " 	AND BG9.BG9_CODIGO BETWEEN '" + MV_PAR01 + "' AND '" + MV_PAR02 + "'	" + CRLF
		
	EndIf
	
	_cQuery += " ORDER BY  1,3,5,9 																" + CRLF
	
Return _cQuery	


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABR250E  ºAutor  ³Angelo Henrique     º Data ³  19/04/18   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Rotina responsavel por gerar o relatório em CSV, pois       º±±
±±º          ³alguns usuários não possuem o Excel.                        º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CABERJ                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function CABR250E()
	
	Local _aArea 	:= GetArea()
	Local _cQuery	:= ""
	Local nHandle 	:= 0
	Local cNomeArq	:= ""
	Local cMontaTxt	:= ""
	
	Private _cAlias2	:= GetNextAlias()
	
	ProcRegua(RecCount())
	
	cNomeArq := "C:\TEMP\RELATORIO_TAXA_ADESAO"
	cNomeArq += "_" + SUBSTR(DTOS(DATE()),7,2)
	cNomeArq += "_" + SUBSTR(DTOS(DATE()),5,2)
	cNomeArq += "_" + SUBSTR(DTOS(DATE()),1,4)
	cNomeArq += "_" + STRTRAN(TIME(),":","_") + ".csv"
	
	//---------------------------------------------
	//CABR244D Realiza toda a montagem da query
	//facilitando a manutenção do fonte
	//---------------------------------------------
	_cQuery := CABR250D()
	
	If Select(_cAlias2) > 0
		(_cAlias2)->(DbCloseArea())
	EndIf
	
	DbUseArea(.T.,"TOPCONN",TcGenQry(,,_cQuery),_cAlias2,.T.,.T.)
	
	While !(_cAlias2)->(EOF())
		
		IncProc()
		
		//------------------------------------------------------------------
		//Se for a primeira vez, deve ser criado o arquivo e o cabeçalho
		//------------------------------------------------------------------
		If nHandle = 0
			
			//------------------------------------------------------------------
			// criar arquivo texto vazio a partir do root path no servidor
			//------------------------------------------------------------------
			nHandle := FCREATE(cNomeArq)
			
			If nHandle > 0
								
				cMontaTxt := "COD_EMPRESA ;"
				cMontaTxt += "DESC_EMPRESA ;"
				cMontaTxt += "CONTRATO ;"
				cMontaTxt += "DATA_CONTRATO ;"
				cMontaTxt += "SUB_CONTRATO ;"
				cMontaTxt += "DATA_SUBCONTRATO ;"
				cMontaTxt += "NOME_SUBCONTRATO ;"
				cMontaTxt += "COD_PRODUTO ;"
				cMontaTxt += "NOME_PRODUTO ;"
				cMontaTxt += "FORMA_COBRANCA ;"
				cMontaTxt += "TIPO_USUARIO ;"
				cMontaTxt += "DESC_USUARIO ;"
				cMontaTxt += "VALOR_ADESAO ;"
				
				cMontaTxt += CRLF // Salto de linha para .csv (excel)
				
				FWrite(nHandle,cMontaTxt)
				
			Else
				
				Aviso("Atenção","Não foi possível criar o relatório",{"OK"})
				Exit
				
			EndIf
			
		EndIf
		
		cMontaTxt := "'" + AllTrim((_cAlias2)->CD_EMP	) + ";"
		cMontaTxt += AllTrim((_cAlias2)->DSC_EMP		) + ";"
		cMontaTxt += "'" + AllTrim((_cAlias2)->CONT		) + ";"
		//cMontaTxt += AllTrim((_cAlias2)->DT_CONT		) + ";"
		cMontaTxt += "'" + AllTrim((_cAlias2)->SUBCONT	) + ";"
		cMontaTxt += AllTrim((_cAlias2)->DT_SUB			) + ";"
		cMontaTxt += AllTrim((_cAlias2)->NM_SUB			) + ";"
		cMontaTxt += "'" + AllTrim((_cAlias2)->CD_PROD	) + ";"
		cMontaTxt += AllTrim((_cAlias2)->NM_PROD		) + ";"
		cMontaTxt += AllTrim((_cAlias2)->FM_COB			) + ";"
		cMontaTxt += AllTrim((_cAlias2)->TP_USU			) + ";"
		cMontaTxt += AllTrim((_cAlias2)->DSC_USU		) + ";"
		cMontaTxt += AllTrim((_cAlias2)->VLR_ADES		) + ";"
		
		cMontaTxt += CRLF // Salto de linha para .csv (excel)
		
		FWrite(nHandle,cMontaTxt)
		
		(_cAlias2)->(DbSkip())
		
	EndDo
	
	If Select(_cAlias2) > 0
		(_cAlias2)->(DbCloseArea())
	EndIf
	
	If nHandle > 0
		
		// encerra gravação no arquivo
		FClose(nHandle)
		
		MsgAlert("Relatorio salvo em: "+cNomeArq)
		
	EndIf
	
	RestArea(_aArea)
	
Return