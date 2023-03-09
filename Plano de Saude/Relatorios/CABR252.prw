#INCLUDE "REPORT.CH"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "TOPCONN.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABR252   ºAutor  ³Angelo Henrique     º Data ³  24/04/18   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Relatório de Taxa de Adesão no nível da família            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CABERJ                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function CABR252()
	
	Local _aArea 	:= GetArea()
	Local oReport	:= Nil
	
	Private _cPerg	:= "CABR252"
	
	//Cria grupo de perguntas
	CABR252A(_cPerg)
	
	If Pergunte(_cPerg,.T.)
		
		//----------------------------------------------------
		//Validando se existe o Excel instalado na máquina
		//para não dar erro e o usuário poder visualizar em
		//outros programas como o LibreOffice
		//----------------------------------------------------
		If ApOleClient("MSExcel")
			
			oReport := CABR252B()
			oReport:PrintDialog()
			
		Else
			
			Processa({||CABR252E()},'Processando...')
			
		EndIf
		
	EndIf
	
	RestArea(_aArea)
	
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABR252A  ºAutor  ³Angelo Henrique     º Data ³  24/04/18   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Rotina responsavel pela geração das perguntas no relatório  º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CABERJ                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function CABR252A(cGrpPerg)
	
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
	
	PutSx1(cGrpPerg,"07","Produto De: ? "				,"a","a","MV_CH7"	,"C",TamSX3("BA3_CODPLA")[1]	,0,0,"G","","B2DPLS","","","MV_PAR07","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")
	PutSx1(cGrpPerg,"08","Produto Ate:? "				,"a","a","MV_CH8"	,"C",TamSX3("BA3_CODPLA")[1]	,0,0,"G","","B2DPLS","","","MV_PAR08","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")
	
	aHelpPor := {}
	AADD(aHelpPor,"Informe a Data de Inclusão		")
	AADD(aHelpPor,"da Família						")
	
	PutSx1(cGrpPerg,"09","Data Inclusão De: ? "			,"a","a","MV_CH9"	,"D",TamSX3("BA3_DATBAS")[1]	,0,0,"G","",""		,"","","MV_PAR09","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")
	PutSx1(cGrpPerg,"10","Data Inclusão Ate:? "			,"a","a","MV_CHA"	,"D",TamSX3("BA3_DATBAS")[1]	,0,0,"G","",""		,"","","MV_PAR10","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")
	
	aHelpPor := {}
	AADD(aHelpPor,"Informe se irá usar Taxa de 0%	")	
	
	PutSx1(cGrpPerg,"11","Taxa 0% ? "					,"a","a","MV_CHB"	,"N",1							,0,0,"C","",""		,"","","MV_PAR11","Sim","","","","Não","","","","","","","","","","","",aHelpPor,{},{},"")
	
	
	
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABR252B  ºAutor  ³Angelo Henrique     º Data ³  19/04/18   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Rotina que irá gerar as informações do relatório            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CABERJ                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function CABR252B
	
	Local oReport		:= Nil
	Local oSection1 	:= Nil
	
	oReport := TReport():New("CABR252","TAXA DE ADESAO FAMILIA",_cPerg,{|oReport| CABR252C(oReport)},"TAXA DE ADESAO FAMILIA")
	
	oReport:SetLandScape()
	
	oReport:oPage:setPaperSize(9)
	
	//--------------------------------
	//Primeira linha do relatório
	//--------------------------------
	oSection1 := TRSection():New(oReport,"BG9","BT5, BQC, BI3, BRX, BA3")
	
	TRCell():New(oSection1,"COD_EMPRESA" 			,"BG9")
	oSection1:Cell("COD_EMPRESA"):SetAutoSize(.F.)
	oSection1:Cell("COD_EMPRESA"):SetSize(TAMSX3("BG9_CODIGO")[1])
	
	TRCell():New(oSection1,"DESC_EMPRESA"			,"BG9")
	oSection1:Cell("DESC_EMPRESA"):SetAutoSize(.F.)
	oSection1:Cell("DESC_EMPRESA"):SetSize(TAMSX3("BG9_DESCRI")[1])
	
	TRCell():New(oSection1,"CONTRATO"				,"BT5")
	oSection1:Cell("CONTRATO"):SetAutoSize(.F.)
	oSection1:Cell("CONTRATO"):SetSize(TAMSX3("BT5_NUMCON")[1])
	
	TRCell():New(oSection1,"SUB_CONTRATO"			,"BQC")
	oSection1:Cell("SUB_CONTRATO"):SetAutoSize(.F.)
	oSection1:Cell("SUB_CONTRATO"):SetSize(TAMSX3("BQC_SUBCON")[1])
	
	TRCell():New(oSection1,"NOME_SUBCONTRATO" 		,"BQC")
	oSection1:Cell("NOME_SUBCONTRATO"):SetAutoSize(.F.)
	oSection1:Cell("NOME_SUBCONTRATO"):SetSize(TAMSX3("BQC_DESCRI")[1])
	
	TRCell():New(oSection1,"MATRICULA" 				,"BA3")
	oSection1:Cell("MATRICULA"):SetAutoSize(.F.)
	oSection1:Cell("MATRICULA"):SetSize(20)
	
	TRCell():New(oSection1,"DATA_INCLUSAO" 			,"BA3")
	oSection1:Cell("DATA_INCLUSAO"):SetAutoSize(.F.)
	oSection1:Cell("DATA_INCLUSAO"):SetSize(TAMSX3("BA3_DATBAS")[1])
	
	TRCell():New(oSection1,"COD_PLANO"				,"BA3")
	oSection1:Cell("COD_PLANO"):SetAutoSize(.F.)
	oSection1:Cell("COD_PLANO"):SetSize(TAMSX3("BA3_CODPLA")[1])
	
	TRCell():New(oSection1,"NOME_PLANO"				,"BI3")
	oSection1:Cell("NOME_PLANO"):SetAutoSize(.F.)
	oSection1:Cell("NOME_PLANO"):SetSize(TAMSX3("BI3_DESCRI")[1])
	
	TRCell():New(oSection1,"VALOR_ADESAO_FAMILIA"	,"BRX")
	oSection1:Cell("VALOR_ADESAO_FAMILIA"):SetAutoSize(.F.)
	oSection1:Cell("VALOR_ADESAO_FAMILIA"):SetSize(20)
	
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

Static Function CABR252C(oReport)
	
	Local _aArea 		:= GetArea()
	Local _cQuery		:= ""
	
	Private oSection1 	:= oReport:Section(1)
	Private _cAlias1	:= GetNextAlias()
	
	//---------------------------------------------
	//CABR252D Realiza toda a montagem da query
	//facilitando a manutenção do fonte
	//---------------------------------------------
	_cQuery := CABR252D()
	
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
		
		oSection1:Cell("COD_EMPRESA" 			):SetValue( (_cAlias1)->CD_EMP	)
		oSection1:Cell("DESC_EMPRESA"			):SetValue( (_cAlias1)->DSC_EMP	)
		oSection1:Cell("CONTRATO"				):SetValue( (_cAlias1)->CONT	)
		oSection1:Cell("SUB_CONTRATO"			):SetValue( (_cAlias1)->SUB		)
		oSection1:Cell("NOME_SUBCONTRATO" 		):SetValue( (_cAlias1)->NM_SUB	)
		oSection1:Cell("MATRICULA" 				):SetValue( (_cAlias1)->MAT		)
		oSection1:Cell("DATA_INCLUSAO" 			):SetValue( (_cAlias1)->DT_INC	)
		oSection1:Cell("COD_PLANO"				):SetValue( (_cAlias1)->COD_PLA	)
		oSection1:Cell("NOME_PLANO"				):SetValue( (_cAlias1)->DSC_PLA	)
		oSection1:Cell("VALOR_ADESAO_FAMILIA"	):SetValue( (_cAlias1)->VLR_ADS	)
		
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
±±ºPrograma  ³CABR252D  ºAutor  ³Angelo Henrique     º Data ³  24/10/16   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Rotina responsavel por tratar a query, facilitando assim    º±±
±±º          ³a manutenção do fonte.                                      º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CABERJ                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function CABR252D()
	
	Local _cQuery 	:= ""
	
	_cQuery += " SELECT																			" + CRLF
	_cQuery += " 	BG9.BG9_CODIGO CD_EMP,														" + CRLF
	_cQuery += " 	TRIM(BG9.BG9_DESCRI) DSC_EMP,												" + CRLF
	_cQuery += " 	BT5.BT5_NUMCON CONT,    													" + CRLF
	_cQuery += " 	BQC.BQC_SUBCON SUB,    														" + CRLF
	_cQuery += " 	TRIM(BQC.BQC_DESCRI) NM_SUB,   												" + CRLF
	_cQuery += " 	BA3.BA3_CODINT||BA3.BA3_CODEMP||BA3.BA3_MATRIC MAT,							" + CRLF
	_cQuery += " 	SIGA.FORMATA_DATA_MS(BA3.BA3_DATBAS) DT_INC,								" + CRLF
	_cQuery += " 	BA3.BA3_CODPLA COD_PLA,														" + CRLF
	_cQuery += " 	TRIM(BI3.BI3_DESCRI) DSC_PLA,												" + CRLF
	_cQuery += " 	SIGA.EXIBE_MOEDA(BRX.BRX_VLRADE) VLR_ADS									" + CRLF
	
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
	//-- FAMILIA
	//-- --------------------------------
	_cQuery += " 	INNER JOIN																	" + CRLF
	_cQuery += "    	" + RetSqlName("BA3") + " BA3                      						" + CRLF
	_cQuery += " 	ON																			" + CRLF
	_cQuery += " 		BA3.BA3_FILIAL = '" + xFilial("BA3") + "'								" + CRLF
	_cQuery += " 		AND BA3_CODINT = BQC.BQC_CODINT											" + CRLF
	_cQuery += " 		AND BA3_CODEMP = BQC.BQC_CODEMP											" + CRLF
	_cQuery += " 		AND BA3_CONEMP = BQC.BQC_NUMCON											" + CRLF
	_cQuery += " 		AND BA3_VERCON = BQC.BQC_VERCON											" + CRLF
	_cQuery += " 		AND BA3_SUBCON = BQC.BQC_SUBCON											" + CRLF
	_cQuery += " 		AND BA3_VERSUB = BQC.BQC_VERSUB											" + CRLF
	_cQuery += " 		AND BA3.BA3_DATBLO = ' '												" + CRLF
	_cQuery += " 		AND BA3.D_E_L_E_T_ = ' '												" + CRLF
	
	//-- --------------------------------
	//-- PARAMETRO DE DATA DE INCLUSÃO
	//-- --------------------------------
	If !Empty(MV_PAR09) .And. !Empty(MV_PAR10)
	
		_cQuery += " 		AND BA3.BA3_DATBAS BETWEEN '" + DTOS(MV_PAR09) + "' AND '" + DTOS(MV_PAR10) + "'" + CRLF
	
	EndIf
	
	//-- --------------------------------
	//-- PRODUTO
	//-- --------------------------------
	_cQuery += " 	INNER JOIN																	" + CRLF
	_cQuery += "    	" + RetSqlName("BI3") + " BI3                 							" + CRLF
	_cQuery += " 	ON																			" + CRLF
	_cQuery += " 		BI3.BI3_FILIAL = '" + xFilial("BI3") + "'								" + CRLF
	_cQuery += " 		AND BI3.BI3_CODINT = BA3.BA3_CODINT										" + CRLF
	_cQuery += " 		AND BI3.BI3_CODIGO = BA3.BA3_CODPLA										" + CRLF
	_cQuery += " 		AND BI3.D_E_L_E_T_ = ' '												" + CRLF
	
	//-- --------------------------------
	//-- PARAMETRO DE PRODUTO DE/ATE
	//-- --------------------------------
	If !Empty(MV_PAR07) .And. !Empty(MV_PAR08)
		
		_cQuery += " 		AND BI3.BI3_CODIGO BETWEEN '" + MV_PAR07 + "' AND '" + MV_PAR08 + "'" + CRLF
		
	EndIf
	
	//-- --------------------------------
	//-- FAMILIA E VALORES DE ADESÃO
	//-- --------------------------------
	_cQuery += " 	INNER JOIN																	" + CRLF
	_cQuery += "    	" + RetSqlName("BRX") + " BRX                 							" + CRLF
	_cQuery += " 	ON																			" + CRLF
	_cQuery += " 		BRX.BRX_FILIAL = '" + xFilial("BRX") + "'								" + CRLF
	_cQuery += " 		AND BRX.BRX_CODOPE = BA3.BA3_CODINT										" + CRLF
	_cQuery += " 		AND BRX.BRX_CODEMP = BA3.BA3_CODEMP										" + CRLF
	_cQuery += " 		AND BRX.BRX_MATRIC = BA3.BA3_MATRIC										" + CRLF
	_cQuery += " 		AND BRX.D_E_L_E_T_ = ' '												" + CRLF
	
	//-- --------------------------------
	//-- PARAMETRO DE TAXA 0 SIM OU NÃO
	//-- --------------------------------
	If MV_PAR11 == 1 
	
		_cQuery += " 		AND BRX.BRX_VLRADE = 0													" + CRLF
	
	EndIf
	
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
	
	_cQuery += " ORDER BY  1,3,4,6,8 															" + CRLF
	
Return _cQuery


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABR252E  ºAutor  ³Angelo Henrique     º Data ³  19/04/18   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Rotina responsavel por gerar o relatório em CSV, pois       º±±
±±º          ³alguns usuários não possuem o Excel.                        º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CABERJ                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function CABR252E()
	
	Local _aArea 	:= GetArea()
	Local _cQuery	:= ""
	Local nHandle 	:= 0
	Local cNomeArq	:= ""
	Local cMontaTxt	:= ""
	
	Private _cAlias2	:= GetNextAlias()
	
	ProcRegua(RecCount())
	
	cNomeArq := "C:\TEMP\RELATORIO_TAXA_ADESAO_FAMILIA"
	cNomeArq += "_" + SUBSTR(DTOS(DATE()),7,2)
	cNomeArq += "_" + SUBSTR(DTOS(DATE()),5,2)
	cNomeArq += "_" + SUBSTR(DTOS(DATE()),1,4)
	cNomeArq += "_" + STRTRAN(TIME(),":","_") + ".csv"
	
	//---------------------------------------------
	//CABR244D Realiza toda a montagem da query
	//facilitando a manutenção do fonte
	//---------------------------------------------
	_cQuery := CABR252D()
	
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
				
				cMontaTxt := "COD_EMPRESA ; "
				cMontaTxt += "DESC_EMPRESA ; "
				cMontaTxt += "CONTRATO ; "
				cMontaTxt += "SUB_CONTRATO ; "
				cMontaTxt += "NOME_SUBCONTRATO ; "
				cMontaTxt += "MATRICULA ; "
				cMontaTxt += "DATA_INCLUSAO ; "
				cMontaTxt += "COD_PLANO ; "
				cMontaTxt += "NOME_PLANO ; "
				cMontaTxt += "VALOR_ADESAO_FAMILIA ; "
									
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
		cMontaTxt += "'" + AllTrim((_cAlias2)->SUB		) + ";"		
		cMontaTxt += AllTrim((_cAlias2)->NM_SUB			) + ";"
		cMontaTxt += "'" + AllTrim((_cAlias2)->MAT		) + ";"
		cMontaTxt += AllTrim((_cAlias2)->DT_INC			) + ";"
		cMontaTxt += "'" + AllTrim((_cAlias2)->COD_PLA	) + ";"
		cMontaTxt += AllTrim((_cAlias2)->DSC_PLA		) + ";"		
		cMontaTxt += AllTrim((_cAlias2)->VLR_ADS		) + ";"
		
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