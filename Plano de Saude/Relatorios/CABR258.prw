#INCLUDE "REPORT.CH"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "TOPCONN.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCABR258   บAutor  ณAngelo Henrique     บ Data ณ  22/05/18   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Relat๓rio de Visualiza็ใo cadastral nos planos odontologicoบฑฑ
ฑฑบ          ณ MetLife.                                                   บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CABERJ                                                     บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function CABR258()
	
	Local _aArea 	:= GetArea()
	Local oReport	:= Nil
	
	Private _cPerg	:= "CABR258"
	
	//Cria grupo de perguntas
	CABR258A(_cPerg)
	
	If Pergunte(_cPerg,.T.)
		
		//----------------------------------------------------
		//Validando se existe o Excel instalado na mแquina
		//para nใo dar erro e o usuแrio poder visualizar em
		//outros programas como o LibreOffice
		//----------------------------------------------------
		If ApOleClient("MSExcel")
			
			oReport := CABR258B()
			oReport:PrintDialog()
			
		Else
			
			Processa({||CABR258E()},'Processando...')
			
		EndIf
		
	EndIf
	
	RestArea(_aArea)
	
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCABR258A  บAutor  ณAngelo Henrique     บ Data ณ  22/05/18   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRotina responsavel pela gera็ใo das perguntas no relat๓rio  บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CABERJ                                                     บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function CABR258A(cGrpPerg)
	
	Local aHelpPor := {} //help da pergunta
	
	aHelpPor := {}
	AADD(aHelpPor,"Informe a Empresa:			")
	
	PutSx1(cGrpPerg,"01","Empresa De: ?  "		,"a","a","MV_CH1"	,"C",TamSX3("BA1_CODEMP")[1]	,0,0,"G","","B7APLS","","","MV_PAR01","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")
	PutSx1(cGrpPerg,"02","Empresa Ate: ? "		,"a","a","MV_CH2"	,"C",TamSX3("BA1_CODEMP")[1]	,0,0,"G","","B7APLS","","","MV_PAR02","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")
	
	aHelpPor := {}
	AADD(aHelpPor,"Informe o Contrato:			")
	
	PutSx1(cGrpPerg,"03","Contrato De:? "		,"a","a","MV_CH3"	,"C",TamSX3("BA1_CONEMP")[1]	,0,0,"G","","BT5"	,"","","MV_PAR03","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")
	PutSx1(cGrpPerg,"04","Contrato Ate:? "		,"a","a","MV_CH4"	,"C",TamSX3("BA1_CONEMP")[1]	,0,0,"G","","BT5"	,"","","MV_PAR04","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")
	
	aHelpPor := {}
	AADD(aHelpPor,"Informe o Sub-Contrato:		")
	
	PutSx1(cGrpPerg,"05","SubContrato De:? "	,"a","a","MV_CH5"	,"C",TamSX3("BA1_SUBCON")[1]	,0,0,"G","","B7CPLS","","","MV_PAR05","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")
	PutSx1(cGrpPerg,"06","SubContrato Ate:? "	,"a","a","MV_CH6"	,"C",TamSX3("BA1_SUBCON")[1]	,0,0,"G","","B7CPLS","","","MV_PAR06","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")
	
	aHelpPor := {}
	AADD(aHelpPor,"Bloqueado?					")
	
	PutSx1(cGrpPerg,"07","Bloqueado:? "			,"a","a","MV_CH7"	,"N",1							,0,0,"C","",""		,"","","MV_PAR07","SIM","SIM","SIM","","NAO","NAO","NAO","AMBOS","AMBOS","","","","","","","",aHelpPor,{},{},"")
	
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCABR258B  บAutor  ณAngelo Henrique     บ Data ณ  08/05/18   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRotina que irแ gerar as informa็๕es do relat๓rio            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CABERJ                                                     บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function CABR258B
	
	Local oReport		:= Nil
	Local oSection1 	:= Nil
	
	oReport := TReport():New("CABR258","CADASTRO ODONTOLOGICO",_cPerg,{|oReport| CABR258C(oReport)},"CADASTRO ODONTOLOGICO")
	
	oReport:SetLandScape()
	
	oReport:oPage:setPaperSize(9)
	
	//--------------------------------
	//Primeira linha do relat๓rio
	//--------------------------------
	oSection1 := TRSection():New(oReport,"CADASTRO ODONTOLOGICO","BA1,BG9,BRP,BI3,BTS")
	
	TRCell():New(oSection1,"EMPRESA" 		,"BA1")
	oSection1:Cell("EMPRESA"):SetAutoSize(.F.)
	oSection1:Cell("EMPRESA"):SetSize(TAMSX3("BA1_CODEMP")[1])
	
	TRCell():New(oSection1,"DESC_EMPRESA" 	,"BG9")
	oSection1:Cell("DESC_EMPRESA"):SetAutoSize(.F.)
	oSection1:Cell("DESC_EMPRESA"):SetSize(TAMSX3("BG9_DESCRI")[1])
	
	TRCell():New(oSection1,"CONTRATO" 		,"BA1")
	oSection1:Cell("CONTRATO"):SetAutoSize(.F.)
	oSection1:Cell("CONTRATO"):SetSize(TAMSX3("BA1_CONEMP")[1])
	
	TRCell():New(oSection1,"SUBCONTRATO" 	,"BA1")
	oSection1:Cell("SUBCONTRATO"):SetAutoSize(.F.)
	oSection1:Cell("SUBCONTRATO"):SetSize(TAMSX3("BA1_SUBCON")[1])
	
	TRCell():New(oSection1,"MATRICULA" 		,"BA1")
	oSection1:Cell("MATRICULA"):SetAutoSize(.F.)
	oSection1:Cell("MATRICULA"):SetSize(20)
	
	TRCell():New(oSection1,"MAT_ODONTO" 	,"BA1")
	oSection1:Cell("MAT_ODONTO"):SetAutoSize(.F.)
	oSection1:Cell("MAT_ODONTO"):SetSize(20)
	
	TRCell():New(oSection1,"TITULAR" 		,"BA1")
	oSection1:Cell("TITULAR"):SetAutoSize(.F.)
	oSection1:Cell("TITULAR"):SetSize(TAMSX3("BA1_NOMUSR")[1])
	
	TRCell():New(oSection1,"ASSOCIADO" 		,"BA1")
	oSection1:Cell("ASSOCIADO"):SetAutoSize(.F.)
	oSection1:Cell("ASSOCIADO"):SetSize(TAMSX3("BA1_NOMUSR")[1])
	
	TRCell():New(oSection1,"NOME_MAE" 		,"BA1")
	oSection1:Cell("NOME_MAE"):SetAutoSize(.F.)
	oSection1:Cell("NOME_MAE"):SetSize(TAMSX3("BA1_MAE")[1])
	
	TRCell():New(oSection1,"CPF" 			,"BA1")
	oSection1:Cell("CPF"):SetAutoSize(.F.)
	oSection1:Cell("CPF"):SetSize(TAMSX3("BA1_CPFUSR")[1])
	
	TRCell():New(oSection1,"NASCIMENTO" 	,"BA1")
	oSection1:Cell("NASCIMENTO"):SetAutoSize(.F.)
	oSection1:Cell("NASCIMENTO"):SetSize(10)
	
	TRCell():New(oSection1,"IDADE" 			,"BA1")
	oSection1:Cell("IDADE"):SetAutoSize(.F.)
	oSection1:Cell("IDADE"):SetSize(10)
	
	TRCell():New(oSection1,"TIPO" 			,"BA1")
	oSection1:Cell("TIPO"):SetAutoSize(.F.)
	oSection1:Cell("TIPO"):SetSize(20)
	
	TRCell():New(oSection1,"PARENTESCO" 	,"BRP")
	oSection1:Cell("PARENTESCO"):SetAutoSize(.F.)
	oSection1:Cell("PARENTESCO"):SetSize(TAMSX3("BRP_DESCRI")[1])
	
	TRCell():New(oSection1,"COD_PLANO" 		,"BA1")
	oSection1:Cell("COD_PLANO"):SetAutoSize(.F.)
	oSection1:Cell("COD_PLANO"):SetSize(TAMSX3("BA1_CODPLA")[1])
	
	TRCell():New(oSection1,"DESC_PLANO" 	,"BI3")
	oSection1:Cell("DESC_PLANO"):SetAutoSize(.F.)
	oSection1:Cell("DESC_PLANO"):SetSize(TAMSX3("BI3_DESCRI")[1])
	
	TRCell():New(oSection1,"INCLUSAO" 		,"BA1")
	oSection1:Cell("INCLUSAO"):SetAutoSize(.F.)
	oSection1:Cell("INCLUSAO"):SetSize(10)
	
	TRCell():New(oSection1,"EXCLUSAO" 		,"BA1")
	oSection1:Cell("EXCLUSAO"):SetAutoSize(.F.)
	oSection1:Cell("EXCLUSAO"):SetSize(10)
	
	TRCell():New(oSection1,"CNS" 			,"BTS")
	oSection1:Cell("CNS"):SetAutoSize(.F.)
	oSection1:Cell("CNS"):SetSize(20)
	
Return oReport


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCABR244B  บAutor  ณAngelo Henrique     บ Data ณ  13/10/17   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRotina para montar a query e trazer as informa็๕es no       บฑฑ
ฑฑบ          ณrelat๓rio.                                                  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CABERJ                                                     บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function CABR258C(oReport)
	
	Local _aArea 		:= GetArea()
	Local _cQuery		:= ""
	
	Private oSection1 	:= oReport:Section(1)
	Private _cAlias1	:= GetNextAlias()
	
	//---------------------------------------------
	//CABR258D Realiza toda a montagem da query
	//facilitando a manuten็ใo do fonte
	//---------------------------------------------
	_cQuery := CABR258D()
	
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
		
		oSection1:Cell("EMPRESA" 		):SetValue( (_cAlias1)->EMPRESA		)
		oSection1:Cell("DESC_EMPRESA" 	):SetValue( (_cAlias1)->DESC_EMPRESA)
		oSection1:Cell("CONTRATO" 		):SetValue( (_cAlias1)->CONTRATO	)
		oSection1:Cell("SUBCONTRATO" 	):SetValue( (_cAlias1)->SUBCONTRATO	)
		oSection1:Cell("MATRICULA" 		):SetValue( (_cAlias1)->MATRICULA	)
		oSection1:Cell("MAT_ODONTO" 	):SetValue( (_cAlias1)->MAT_ODONTO	)
		oSection1:Cell("TITULAR" 		):SetValue( (_cAlias1)->TITULAR		)
		oSection1:Cell("ASSOCIADO" 		):SetValue( (_cAlias1)->ASSOCIADO	)
		oSection1:Cell("NOME_MAE" 		):SetValue( (_cAlias1)->NOME_MAE	)
		oSection1:Cell("CPF" 			):SetValue( (_cAlias1)->CPF			)
		oSection1:Cell("NASCIMENTO" 	):SetValue( (_cAlias1)->NASCIMENTO	)
		oSection1:Cell("IDADE" 			):SetValue( (_cAlias1)->IDADE		)
		oSection1:Cell("TIPO" 			):SetValue( (_cAlias1)->TIPO		)
		oSection1:Cell("PARENTESCO" 	):SetValue( (_cAlias1)->PARENTESCO	)
		oSection1:Cell("COD_PLANO" 		):SetValue( (_cAlias1)->COD_PLANO	)
		oSection1:Cell("DESC_PLANO" 	):SetValue( (_cAlias1)->DESC_PLANO	)
		oSection1:Cell("INCLUSAO" 		):SetValue( (_cAlias1)->INCLUSAO	)
		oSection1:Cell("EXCLUSAO" 		):SetValue( (_cAlias1)->EXCLUSAO	)
		oSection1:Cell("CNS" 			):SetValue( (_cAlias1)->CNS			)
		
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
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCABR258D  บAutor  ณAngelo Henrique     บ Data ณ  24/10/16   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRotina responsavel por tratar a query, facilitando assim    บฑฑ
ฑฑบ          ณa manuten็ใo do fonte.                                      บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CABERJ                                                     บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function CABR258D()
	
	Local _cQuery 	:= ""		
	
	_cQuery += " SELECT																							" + CRLF
	_cQuery += " 	BA1.BA1_CODEMP EMPRESA,																		" + CRLF
	_cQuery += " 	TRIM(BG9.BG9_DESCRI) DESC_EMPRESA,															" + CRLF
	_cQuery += " 	BA1.BA1_CONEMP CONTRATO,																	" + CRLF
	_cQuery += " 	BA1.BA1_SUBCON SUBCONTRATO,																	" + CRLF
	_cQuery += " 	BA1.BA1_CODINT||BA1.BA1_CODEMP||BA1.BA1_MATRIC||BA1.BA1_TIPREG||BA1.BA1_DIGITO MATRICULA,	" + CRLF
	_cQuery += " 	BA1.BA1_YMTODO MAT_ODONTO,																	" + CRLF
	_cQuery += " 	TRIM(BA1T.BA1_NOMUSR) TITULAR,																" + CRLF
	_cQuery += " 	TRIM(BA1.BA1_NOMUSR) ASSOCIADO,																" + CRLF
	_cQuery += " 	TRIM(BA1.BA1_MAE) NOME_MAE,																	" + CRLF
	_cQuery += " 	BA1.BA1_CPFUSR CPF,																			" + CRLF
	_cQuery += " 	SIGA.FORMATA_DATA_MS(BA1.BA1_DATNAS) NASCIMENTO,											" + CRLF
	_cQuery += " 	IDADE(TO_DATE(BA1.BA1_DATNAS,'YYYYMMDD'),SYSDATE) IDADE,									" + CRLF
	_cQuery += " 	DECODE(BA1.BA1_TIPUSU,'T','TITULAR','DEPENDENTE') TIPO,										" + CRLF
	_cQuery += " 	TRIM(BRP.BRP_DESCRI) PARENTESCO,															" + CRLF
	_cQuery += " 	BA1.BA1_CODPLA COD_PLANO,																	" + CRLF
	_cQuery += " 	TRIM(BI3.BI3_DESCRI) DESC_PLANO,															" + CRLF
	_cQuery += " 	SIGA.FORMATA_DATA_MS(BA1.BA1_DATINC) INCLUSAO,												" + CRLF
	_cQuery += " 	SIGA.FORMATA_DATA_MS(BA1.BA1_DATBLO) EXCLUSAO,												" + CRLF
	_cQuery += " 	BTS.BTS_NRCRNA CNS																			" + CRLF
	_cQuery += " FROM																							" + CRLF
	_cQuery += " 	" + RetSqlName("BA1") + " BA1                      											" + CRLF
	
	//-------------------------------------
	//-- EMPRESA
	//-------------------------------------
	_cQuery += " 	INNER JOIN																					" + CRLF
	_cQuery += " 		" + RetSqlName("BG9") + " BG9                      										" + CRLF
	_cQuery += " 	ON																							" + CRLF
	_cQuery += " 		BG9.BG9_FILIAL = '" + xFilial("BG9") + "'												" + CRLF
	_cQuery += " 		AND BG9.BG9_CODINT = BA1.BA1_CODINT														" + CRLF
	_cQuery += " 		AND BG9.BG9_CODIGO = BA1.BA1_CODEMP														" + CRLF
	_cQuery += " 		AND BG9.D_E_L_E_T_ = ' '																" + CRLF
	
	//-------------------------------------
	//-- TITULAR
	//-------------------------------------
	_cQuery += " 	INNER JOIN																					" + CRLF
	_cQuery += " 		" + RetSqlName("BA1") + " BA1T                      									" + CRLF
	_cQuery += " 	ON																							" + CRLF
	_cQuery += " 		BA1T.BA1_FILIAL = '" + xFilial("BA1") + "'												" + CRLF
	_cQuery += " 		AND BA1T.BA1_CODINT = BA1.BA1_CODINT													" + CRLF
	_cQuery += " 		AND BA1T.BA1_CODEMP = BA1.BA1_CODEMP													" + CRLF
	_cQuery += " 		AND BA1T.BA1_MATRIC = BA1.BA1_MATRIC													" + CRLF
	_cQuery += " 		AND BA1T.BA1_TIPUSU = 'T'																" + CRLF
	_cQuery += " 		AND BA1T.D_E_L_E_T_ = ' '																" + CRLF
	
	//-------------------------------------
	//-- GRAU PARENTESCO
	//-------------------------------------
	_cQuery += " 	INNER JOIN																					" + CRLF
	_cQuery += " 		" + RetSqlName("BRP") + " BRP                      										" + CRLF
	_cQuery += " 	ON																							" + CRLF
	_cQuery += " 		BRP.BRP_FILIAL = '" + xFilial("BRP") + "'												" + CRLF
	_cQuery += " 		AND BRP.BRP_CODIGO = BA1.BA1_GRAUPA														" + CRLF
	_cQuery += " 		AND BRP.D_E_L_E_T_ = ' '																" + CRLF
	
	//-------------------------------------
	//-- PLANO
	//-------------------------------------
	_cQuery += " 	INNER JOIN																					" + CRLF
	_cQuery += " 		" + RetSqlName("BI3") + " BI3                      										" + CRLF
	_cQuery += " 	ON																							" + CRLF
	_cQuery += " 		BI3.BI3_FILIAL = '" + xFilial("BI3") + "'												" + CRLF
	_cQuery += " 		AND BI3.BI3_CODIGO = BA1.BA1_CODPLA														" + CRLF
	_cQuery += " 		AND BI3.D_E_L_E_T_ = ' '																" + CRLF
	
	//-------------------------------------
	//-- VIDA
	//-------------------------------------
	_cQuery += " 	INNER JOIN																					" + CRLF
	_cQuery += " 		" + RetSqlName("BTS") + " BTS                      										" + CRLF
	_cQuery += " 	ON																							" + CRLF
	_cQuery += " 		BTS.BTS_FILIAL = '" + xFilial("BTS") + "'												" + CRLF
	_cQuery += " 		AND BTS.BTS_MATVID = BA1.BA1_MATVID														" + CRLF
	_cQuery += " 		AND BTS.D_E_L_E_T_ = ' '																" + CRLF
	
	_cQuery += " WHERE																							" + CRLF
	_cQuery += " 	BA1.BA1_FILIAL = '" + xFilial("BA1") + "'													" + CRLF
	_cQuery += " 	AND BA1.D_E_L_E_T_ = ' '																	" + CRLF
	
	//-------------------------------------
	//-- FILTROS TODOS DE/ATE (BETWEEN)
	//-------------------------------------
	If !(Empty(MV_PAR01) .OR. Empty(MV_PAR02)) //EMPRESA
		
		_cQuery += " 	AND BA1.BA1_CODEMP BETWEEN '" + MV_PAR01 + "' AND '" + MV_PAR02 + "' 					" + CRLF
		
	EndIf
	
	If !(Empty(MV_PAR03) .OR. Empty(MV_PAR04)) //CONTRATO
		
		_cQuery += " 	AND BA1.BA1_CONEMP BETWEEN '" + MV_PAR03 + "' AND '" + MV_PAR04 + "'					" + CRLF
		
	EndIf
	
	If !(Empty(MV_PAR05) .OR. Empty(MV_PAR06)) //SUBCONTRATO
		
		_cQuery += " 	AND BA1.BA1_SUBCON BETWEEN '" + MV_PAR05 + "' AND '" + MV_PAR06 + "'  					" + CRLF
		
	EndIf
	
	//-------------------------------------
	//-- Bloqueados? (SIM, NAO e AMBOS)
	//-------------------------------------
	If MV_PAR07 = 1 // SIM
		
		_cQuery += " 	AND BA1.BA1_DATBLO <> ' ' 																" + CRLF
		
	ElseIf MV_PAR07 = 2 //NAO
		
		_cQuery += " 	AND BA1.BA1_DATBLO = ' '																" + CRLF
		
	EndIf
	
	_cQuery += " ORDER BY																						" + CRLF
	_cQuery += " 	BA1.BA1_CODEMP,																				" + CRLF
	_cQuery += " 	BA1.BA1_CONEMP,																				" + CRLF
	_cQuery += " 	BA1.BA1_SUBCON,																				" + CRLF
	_cQuery += " 	BA1.BA1_CODINT||BA1.BA1_CODEMP||BA1.BA1_MATRIC||BA1.BA1_TIPREG||BA1.BA1_DIGITO,				" + CRLF
	_cQuery += " 	BA1T.BA1_NOMUSR,																			" + CRLF
	_cQuery += " 	BA1.BA1_NOMUSR																				" + CRLF
			
Return _cQuery


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCABR258E  บAutor  ณAngelo Henrique     บ Data ณ  08/05/18   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRotina responsavel por gerar o relat๓rio em CSV, pois       บฑฑ
ฑฑบ          ณalguns usuแrios nใo possuem o Excel.                        บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CABERJ                                                     บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function CABR258E()
	
	Local _aArea 	:= GetArea()
	Local _cQuery	:= ""
	Local nHandle 	:= 0
	Local cNomeArq	:= ""
	Local cMontaTxt	:= ""
	
	Private _cAlias2	:= GetNextAlias()
	
	ProcRegua(RecCount())
	
	cNomeArq := "C:\TEMP\CADASTRO ODONTOLOGICO"
	cNomeArq += "_" + SUBSTR(DTOS(DATE()),7,2)
	cNomeArq += "_" + SUBSTR(DTOS(DATE()),5,2)
	cNomeArq += "_" + SUBSTR(DTOS(DATE()),1,4)
	cNomeArq += "_" + STRTRAN(TIME(),":","_") + ".csv"
	
	//---------------------------------------------
	//CABR244D Realiza toda a montagem da query
	//facilitando a manuten็ใo do fonte
	//---------------------------------------------
	_cQuery := CABR258D()
	
	If Select(_cAlias2) > 0
		(_cAlias2)->(DbCloseArea())
	EndIf
	
	DbUseArea(.T.,"TOPCONN",TcGenQry(,,_cQuery),_cAlias2,.T.,.T.)
	
	While !(_cAlias2)->(EOF())
		
		IncProc()
		
		//------------------------------------------------------------------
		//Se for a primeira vez, deve ser criado o arquivo e o cabe็alho
		//------------------------------------------------------------------
		If nHandle = 0
			
			//------------------------------------------------------------------
			// criar arquivo texto vazio a partir do root path no servidor
			//------------------------------------------------------------------
			nHandle := FCREATE(cNomeArq)
			
			If nHandle > 0
				
				cMontaTxt := "EMPRESA 		; "
				cMontaTxt += "DESC_EMPRESA 	; "
				cMontaTxt += "CONTRATO		; "
				cMontaTxt += "SUBCONTRATO 	; "
				cMontaTxt += "MATRICULA 	; "
				cMontaTxt += "MAT_ODONTO 	; "
				cMontaTxt += "TITULAR 		; "
				cMontaTxt += "ASSOCIADO 	; "
				cMontaTxt += "NOME_MAE 		; "
				cMontaTxt += "CPF 			; "
				cMontaTxt += "NASCIMENTO 	; "
				cMontaTxt += "IDADE 		; "
				cMontaTxt += "TIPO 			; "
				cMontaTxt += "PARENTESCO 	; "
				cMontaTxt += "COD_PLANO 	; "
				cMontaTxt += "DESC_PLANO 	; "
				cMontaTxt += "INCLUSAO 		; "
				cMontaTxt += "EXCLUSAO 		; "
				cMontaTxt += "CNS 			; "
				
				cMontaTxt += CRLF // Salto de linha para .csv (excel)
				
				FWrite(nHandle,cMontaTxt)
				
			Else
				
				Aviso("Aten็ใo","Nใo foi possํvel criar o relat๓rio",{"OK"})
				Exit
				
			EndIf
			
		EndIf
		
		cMontaTxt := AllTrim((_cAlias2)->EMPRESA 			) + ";"
		cMontaTxt += AllTrim((_cAlias2)->DESC_EMPRESA 		) + ";"
		cMontaTxt += "'" + AllTrim((_cAlias2)->CONTRATO		) + ";"
		cMontaTxt += "'" + AllTrim((_cAlias2)->SUBCONTRATO 	) + ";"
		cMontaTxt += "'" + AllTrim((_cAlias2)->MATRICULA 	) + ";"
		cMontaTxt += "'" + AllTrim((_cAlias2)->MAT_ODONTO 	) + ";"
		cMontaTxt += AllTrim((_cAlias2)->TITULAR 			) + ";"
		cMontaTxt += AllTrim((_cAlias2)->ASSOCIADO 			) + ";"
		cMontaTxt += AllTrim((_cAlias2)->NOME_MAE 			) + ";"
		cMontaTxt += "'" + AllTrim((_cAlias2)->CPF 			) + ";"
		cMontaTxt += AllTrim((_cAlias2)->NASCIMENTO 		) + ";"
		cMontaTxt += AllTrim((_cAlias2)->IDADE 				) + ";"
		cMontaTxt += AllTrim((_cAlias2)->TIPO 				) + ";"
		cMontaTxt += AllTrim((_cAlias2)->PARENTESCO 		) + ";"
		cMontaTxt += "'" + AllTrim((_cAlias2)->COD_PLANO 	) + ";"
		cMontaTxt += AllTrim((_cAlias2)->DESC_PLANO 		) + ";"
		cMontaTxt += AllTrim((_cAlias2)->INCLUSAO 			) + ";"
		cMontaTxt += AllTrim((_cAlias2)->EXCLUSAO 			) + ";"
		cMontaTxt += "'" + AllTrim((_cAlias2)->CNS 			) + ";"
		
		cMontaTxt += CRLF // Salto de linha para .csv (excel)
		
		FWrite(nHandle,cMontaTxt)
		
		(_cAlias2)->(DbSkip())
		
	EndDo
	
	If Select(_cAlias2) > 0
		(_cAlias2)->(DbCloseArea())
	EndIf
	
	If nHandle > 0
		
		// encerra grava็ใo no arquivo
		FClose(nHandle)
		
		MsgAlert("Relatorio salvo em: "+cNomeArq)
		
	EndIf
	
	RestArea(_aArea)
	
Return