#INCLUDE "TOPCONN.CH"
#INCLUDE "RWMAKE.CH"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "TBICONN.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCABR275     บAutor  ณAngelo Henrique   บ Data ณ  10/05/16   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRelat๓rio judicial de beneficiแrios                         บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CABERJ                                                     บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function CABR275()
	
	Local _aArea 	:= GetArea()
	Local oReport	:= Nil
	Private _cPerg	:= "CABR275"
	
	//Cria grupo de perguntas
	CABR275C(_cPerg)
	
	If Pergunte(_cPerg,.T.)
		
		//----------------------------------------------------
		//Validando se existe o Excel instalado na mแquina
		//para nใo dar erro e o usuแrio poder visualizar em
		//outros programas como o LibreOffice
		//----------------------------------------------------
		If ApOleClient("MSExcel")
			
			oReport := CABR275A()
			oReport:PrintDialog()
			
		Else
			
			Processa({||CABR275E()},'Processando...')
			
		EndIf
		
	EndIf
	
	RestArea(_aArea)
	
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCABR275A  บAutor  ณAngelo Henrique     บ Data ณ  17/08/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRotina que irแ gerar as informa็๕es do relat๓rio            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CABERJ                                                     บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function CABR275A
	
	Local oReport		:= Nil
	Local oSection1 	:= Nil
	
	oReport := TReport():New("CABR275","RELATORIO JUDICIAL - BENEFICIARIOS",_cPerg,{|oReport| CABR275B(oReport)},"RELATORIO JUDICIAL - BENEFICIARIOS")
	
	oReport:SetLandScape()
	
	oReport:oPage:setPaperSize(12)
	
	//--------------------------------
	//Primeira linha do relat๓rio
	//--------------------------------
	oSection1 := TRSection():New(oReport,"JUDICIAL","BA1, BQC, BG9, BM1, BG3")
	
	TRCell():New(oSection1,"COD_EMP" 			,"BA1")
	oSection1:Cell("COD_EMP"):SetAutoSize(.F.)
	oSection1:Cell("COD_EMP"):SetSize(TAMSX3("BA1_CODEMP")[1])
	
	TRCell():New(oSection1,"EMPRESA" 			,"BG9")
	oSection1:Cell("EMPRESA"):SetAutoSize(.F.)
	oSection1:Cell("EMPRESA"):SetSize(TAMSX3("BG9_DESCRI")[1])
	
	TRCell():New(oSection1,"CONTRATO" 			,"BA1")
	oSection1:Cell("CONTRATO"):SetAutoSize(.F.)
	oSection1:Cell("CONTRATO"):SetSize(TAMSX3("BA1_CONEMP")[1])
	
	TRCell():New(oSection1,"SUBCON" 			,"BA1")
	oSection1:Cell("SUBCON"):SetAutoSize(.F.)
	oSection1:Cell("SUBCON"):SetSize(TAMSX3("BA1_SUBCON")[1])
	
	TRCell():New(oSection1,"SUBCONTRATO" 		,"BQC")
	oSection1:Cell("SUBCONTRATO"):SetAutoSize(.F.)
	oSection1:Cell("SUBCONTRATO"):SetSize(TAMSX3("BQC_DESCRI")[1])
	
	TRCell():New(oSection1,"MATRICULA" 			,"BA1")
	oSection1:Cell("MATRICULA"):SetAutoSize(.F.)
	oSection1:Cell("MATRICULA"):SetSize(20)
	
	TRCell():New(oSection1,"BENEFICIARIO" 		,"BA1")
	oSection1:Cell("BENEFICIARIO"):SetAutoSize(.F.)
	oSection1:Cell("BENEFICIARIO"):SetSize(TAMSX3("BA1_NOMUSR")[1])
	
	TRCell():New(oSection1,"BLOQUEIO" 			,"BA1")
	oSection1:Cell("BLOQUEIO"):SetAutoSize(.F.)
	oSection1:Cell("BLOQUEIO"):SetSize(15)
	
	TRCell():New(oSection1,"COD_BLOQ" 			,"BA1")
	oSection1:Cell("COD_BLOQ"):SetAutoSize(.F.)
	oSection1:Cell("COD_BLOQ"):SetSize(TAMSX3("BA1_NOMUSR")[1])
	
	TRCell():New(oSection1,"DESC_BLOQ" 			,"BG3")
	oSection1:Cell("DESC_BLOQ"):SetAutoSize(.F.)
	oSection1:Cell("DESC_BLOQ"):SetSize(TAMSX3("BG3_DESBLO")[1])
	
	TRCell():New(oSection1,"ANO BASE"			,"BM1")
	oSection1:Cell("ANO BASE"):SetAutoSize(.F.)
	oSection1:Cell("ANO BASE"):SetSize(10)
	
	TRCell():New(oSection1,"MES BASE" 			,"BM1")
	oSection1:Cell("MES BASE"):SetAutoSize(.F.)
	oSection1:Cell("MES BASE"):SetSize(10)
	
	TRCell():New(oSection1,"MENSALIDADE" 		,"BM1")
	oSection1:Cell("MENSALIDADE"):SetAutoSize(.F.)
	oSection1:Cell("MENSALIDADE"):SetSize(TAMSX3("BM1_VALOR")[1])
	
	
Return oReport

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCABR275B  บAutor  ณAngelo Henrique     บ Data ณ  17/08/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRotina para montar a query e trazer as informa็๕es no       บฑฑ
ฑฑบ          ณrelat๓rio.                                                  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CABERJ                                                     บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function CABR275B(oReport,_cAlias1)
	
	Local _aArea 		:= GetArea()
	Local _cQuery		:= ""
	Local _aAreAC9 		:= AC9->(GetArea())
	Local _cChavAC9		:= ""
	
	Private oSection1 	:= oReport:Section(1)
	Private _cAlias1	:= GetNextAlias()
	Private _cEmpAnt	:= cEmpAnt
	
	//---------------------------------------------
	//CABR275D Realiza toda a montagem da query
	//facilitando a manuten็ใo do fonte
	//---------------------------------------------
	_cQuery := CABR275D()
	
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
		
		oSection1:Cell("COD_EMP" 		):SetValue( (_cAlias1)->COD_EMP			)
		oSection1:Cell("EMPRESA" 		):SetValue( (_cAlias1)->EMPRESA			)
		oSection1:Cell("CONTRATO" 		):SetValue( (_cAlias1)->CONTRATO		)
		oSection1:Cell("SUBCON" 		):SetValue( (_cAlias1)->SUBCON			)
		oSection1:Cell("SUBCONTRATO" 	):SetValue( (_cAlias1)->SUBCONTRATO		)
		oSection1:Cell("MATRICULA" 		):SetValue( (_cAlias1)->MATRICULA		)
		oSection1:Cell("BENEFICIARIO"	):SetValue( (_cAlias1)->BENEFICIARIO	)
		oSection1:Cell("BLOQUEIO"		):SetValue( (_cAlias1)->BLOQUEIO		)
		oSection1:Cell("COD_BLOQ"		):SetValue( (_cAlias1)->COD_BLOQ		)
		oSection1:Cell("DESC_BLOQ"		):SetValue( (_cAlias1)->DESC_BLOQ		)
		oSection1:Cell("ANO BASE"		):SetValue( (_cAlias1)->ANO				)
		oSection1:Cell("MES BASE" 		):SetValue( (_cAlias1)->MES				)
		oSection1:Cell("MENSALIDADE" 	):SetValue( (_cAlias1)->MENSALIDADE		)
		
		oSection1:PrintLine()
		
		(_cAlias1)->(DbSkip())
		
	EndDo
	
	oSection1:Finish()
	
	If Select(_cAlias1) > 0
		(_cAlias1)->(DbCloseArea())
	EndIf
	
	RestArea(_aArea	 )
	RestArea(_aAreAC9)
	
Return(.T.)


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCABR275C  บAutor  ณAngelo Henrique     บ Data ณ  17/08/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRotina responsavel pela gera็ใo das perguntas no relat๓rio  บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CABERJ                                                     บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function CABR275C(cGrpPerg)
	
	Local aHelpPor := {} //help da pergunta
	
	aHelpPor := {}
	AADD(aHelpPor,"Informe a empresa 				")
	AADD(aHelpPor,"Branco para todos				")
	
	u_CABASX1(cGrpPerg,"01","Empresa De: ?"			,"a","a","MV_CH1"	,"C",TamSX3("BG9_CODIGO")[1]	,0,0,"G","","BJLPLS","","","MV_PAR01",""		,"","","",""			,"","",""		,"","","","","","","","",aHelpPor,{},{},"")
	u_CABASX1(cGrpPerg,"02","Empresa Ate:?"			,"a","a","MV_CH2"	,"C",TamSX3("BG9_CODIGO")[1]	,0,0,"G","","BJLPLS","","","MV_PAR02",""		,"","","",""			,"","",""		,"","","","","","","","",aHelpPor,{},{},"")
	
	aHelpPor := {}
	AADD(aHelpPor,"Informe o M๊s    				")
	AADD(aHelpPor,"Branco para todos				")
	
	u_CABASX1(cGrpPerg,"03","M๊s De: ?"				,"a","a","MV_CH3"	,"C",TamSX3("BM1_MES")[1]		,0,0,"G","",""		,"","","MV_PAR03",""		,"","","",""			,"","",""		,"","","","","","","","",aHelpPor,{},{},"")
	u_CABASX1(cGrpPerg,"04","M๊s At้:?"				,"a","a","MV_CH4"	,"C",TamSX3("BM1_MES")[1]		,0,0,"G","",""		,"","","MV_PAR04",""		,"","","",""			,"","",""		,"","","","","","","","",aHelpPor,{},{},"")
	
	aHelpPor := {}
	AADD(aHelpPor,"Informe o Ano 					")
	AADD(aHelpPor,"Branco para todos				")
	
	u_CABASX1(cGrpPerg,"05","Ano De: ?"				,"a","a","MV_CH5"	,"C",TamSX3("BM1_ANO")[1]		,0,0,"G","",""		,"","","MV_PAR05",""		,"","","",""			,"","",""		,"","","","","","","","",aHelpPor,{},{},"")
	u_CABASX1(cGrpPerg,"06","Ano At้:?"				,"a","a","MV_CH6"	,"C",TamSX3("BM1_ANO")[1]		,0,0,"G","",""		,"","","MV_PAR06",""		,"","","",""			,"","",""		,"","","","","","","","",aHelpPor,{},{},"")
	
	
	aHelpPor := {}
	AADD(aHelpPor,"Informe o Contrato		  		")
	AADD(aHelpPor,"Branco para todos		  		")
	
	u_CABASX1(cGrpPerg,"07","Contrato De: ?"		,"a","a","MV_CH7"	,"C",TamSX3("BA1_CONEMP")[1]	,0,0,"G","",""		,"","","MV_PAR07",""		,"","","",""			,"","",""		,"","","","","","","","",aHelpPor,{},{},"")
	u_CABASX1(cGrpPerg,"08","Contrato Ate:?"		,"a","a","MV_CH8"	,"C",TamSX3("BA1_CONEMP")[1]	,0,0,"G","",""		,"","","MV_PAR08",""		,"","","",""			,"","",""		,"","","","","","","","",aHelpPor,{},{},"")
	
	aHelpPor := {}
	AADD(aHelpPor,"Informe o Subcontrato	  		")
	AADD(aHelpPor,"Branco para todos		  		")
	
	u_CABASX1(cGrpPerg,"09","Subcontrato De: ?"		,"a","a","MV_CH9"	,"C",TamSX3("BA1_SUBCON")[1]	,0,0,"G","",""		,"","","MV_PAR09",""		,"","","",""			,"","",""		,"","","","","","","","",aHelpPor,{},{},"")
	u_CABASX1(cGrpPerg,"10","Subcontrato Ate:?"		,"a","a","MV_CH10"	,"C",TamSX3("BA1_SUBCON")[1]	,0,0,"G","",""		,"","","MV_PAR10",""		,"","","",""			,"","",""		,"","","","","","","","",aHelpPor,{},{},"")
	
	aHelpPor := {}
	AADD(aHelpPor,"Informe o que deseja Imprimir	")
	AADD(aHelpPor,"Branco para todos		  		")
	
	u_CABASX1(cGrpPerg,"11","Bloqueado: ?"			,"a","a","MV_CH11"	,"N",01							,0,0,"C","",""		,"","","MV_PAR09","ATIVOS"	,"","","","BLOQUEADOS"	,"","","AMBOS"	,"","","","","","","","",aHelpPor,{},{},"")
	
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCABR275D  บAutor  ณAngelo Henrique     บ Data ณ  24/10/16   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRotina responsavel por tratar a query, facilitando assim    บฑฑ
ฑฑบ          ณa manuten็ใo do fonte.                                      บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CABERJ                                                     บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function CABR275D()
	
	Local _cQuery 		:= ""
	
	_cQuery += " SELECT                                                                                         " 	+ CRLF
	_cQuery += "     BQC.BQC_YSTSCO SIT_CONTRATO,                                                               " 	+ CRLF
	_cQuery += "     BG9.BG9_CODIGO COD_EMP,                                                                    " 	+ CRLF
	_cQuery += "     TRIM(BG9.BG9_DESCRI) EMPRESA,                                                              " 	+ CRLF
	_cQuery += "     BA1.BA1_CONEMP CONTRATO,                                                                   " 	+ CRLF
	_cQuery += "     BA1.BA1_SUBCON SUBCON,                                                                     " 	+ CRLF
	_cQuery += "     TRIM(BQC.BQC_DESCRI) SUBCONTRATO,															" 	+ CRLF
	_cQuery += "     BA1.BA1_CODINT||BA1.BA1_CODEMP||BA1.BA1_MATRIC||BA1.BA1_TIPREG||BA1.BA1_DIGITO MATRICULA ,	" 	+ CRLF
	_cQuery += "     TRIM(BA1.BA1_NOMUSR) BENEFICIARIO,            												" 	+ CRLF
	_cQuery += "     SIGA.FORMATA_DATA_MS(BA1.BA1_DATBLO) BLOQUEIO,												" 	+ CRLF
	_cQuery += "     NVL(BA1.BA1_MOTBLO,' ') COD_BLOQ,															" 	+ CRLF
	_cQuery += "     NVL(OBTER_DESC_MOT_BLOQ('I',BA1.BA1_CONSID,BA1.BA1_MOTBLO),' ') DESC_BLOQ,					" 	+ CRLF
	_cQuery += "     NVL(BM1.BM1_ANO,' ') ANO,                                                                  " 	+ CRLF
	_cQuery += "     NVL(BM1_MES,' ') MES,                                                                      " 	+ CRLF
	_cQuery += "     NVL(BM1.BM1_VALOR, 0) MENSALIDADE                                                          " 	+ CRLF
	_cQuery += "                                                                                                " 	+ CRLF
	_cQuery += " FROM                                                                                           " 	+ CRLF
	_cQuery += "                                                                                                " 	+ CRLF
	_cQuery += "     " + RetSqlName("BA1") + " BA1                                                              " 	+ CRLF
	_cQuery += "                                                                                                " 	+ CRLF
	_cQuery += "     INNER JOIN                                                                                 " 	+ CRLF
	_cQuery += "     " + RetSqlName("BG9") + " BG9                                                              " 	+ CRLF
	_cQuery += "     ON                                                                                         " 	+ CRLF
	_cQuery += "         BG9.BG9_FILIAL      = BA1.BA1_FILIAL                                                   " 	+ CRLF
	_cQuery += "         AND BG9_CODINT      = BA1.BA1_CODINT                                                   " 	+ CRLF
	_cQuery += "         AND BG9_CODIGO      = BA1.BA1_CODEMP                                                   " 	+ CRLF
	_cQuery += "         AND BG9.D_E_L_E_T_  = ' '                                                              " 	+ CRLF
	_cQuery += "                                                                                                " 	+ CRLF
	_cQuery += "     INNER JOIN                                                                                 " 	+ CRLF
	_cQuery += "     " + RetSqlName("BQC") + " BQC                                                              " 	+ CRLF
	_cQuery += "     ON                                                                                         " 	+ CRLF
	_cQuery += "         BQC.BQC_NUMCON      = BA1.BA1_CONEMP                                                   " 	+ CRLF
	_cQuery += "         AND BQC.BQC_SUBCON  = BA1.BA1_SUBCON                                                   " 	+ CRLF
	_cQuery += "         AND BQC.BQC_CODEMP  = BA1.BA1_CODEMP                                                   " 	+ CRLF
	_cQuery += "         AND BQC.BQC_CODINT  = BA1.BA1_CODINT                                                   " 	+ CRLF
	_cQuery += "         AND BQC.BQC_YSTSCO  = '04'                                                             " 	+ CRLF
	_cQuery += "         AND BQC.D_E_L_E_T_  = ' '                                                              " 	+ CRLF
	_cQuery += "                                                                                                " 	+ CRLF
	_cQuery += "     LEFT JOIN                                                                                  " 	+ CRLF
	_cQuery += "     " + RetSqlName("BM1") + " BM1                                                              " 	+ CRLF
	_cQuery += "     ON                                                                                         " 	+ CRLF
	_cQuery += "         BM1.BM1_FILIAL      = BA1.BA1_FILIAL                                                   " 	+ CRLF
	_cQuery += "         AND BM1.BM1_CODINT  = BA1.BA1_CODINT                                                   " 	+ CRLF
	_cQuery += "         AND BM1.BM1_CODEMP  = BA1.BA1_CODEMP                                                   " 	+ CRLF
	_cQuery += "         AND BM1.BM1_MATRIC  = BA1.BA1_MATRIC                                                   " 	+ CRLF
	_cQuery += "         AND BM1.BM1_TIPREG  = BA1.BA1_TIPREG                                                   " 	+ CRLF
	_cQuery += "         AND BM1.BM1_DIGITO  = BA1.BA1_DIGITO                                                   " 	+ CRLF
	_cQuery += "         AND BM1.BM1_CODTIP  = '101'                                                            " 	+ CRLF
	
	If !(Empty(MV_PAR03)) .And. !(Empty(MV_PAR04))
		
		_cQuery += "         AND BM1.BM1_MES BETWEEN '" + MV_PAR03 + "' AND '" + MV_PAR04 + "'                  " 	+ CRLF
		
	EndIf
	
	If !(Empty(MV_PAR05)) .And. !(Empty(MV_PAR06))
		
		_cQuery += "         AND BM1.BM1_ANO BETWEEN '" + MV_PAR05 + "' AND '" + MV_PAR06 + "'                  " 	+ CRLF
		
	EndIf
	
	_cQuery += "         AND BM1.D_E_L_E_T_  = ' '                                                              " 	+ CRLF
	_cQuery += "                                                                                                " 	+ CRLF
	_cQuery += " WHERE                                                                                          " 	+ CRLF
	_cQuery += "                                                                                                " 	+ CRLF
	_cQuery += "     BA1.BA1_FILIAL          = '  '                                                             " 	+ CRLF
	
	If !(Empty(MV_PAR01)) .And. !(Empty(MV_PAR02))
		
		_cQuery += "     AND BA1.BA1_CODEMP BETWEEN '" + MV_PAR01 + "' AND '" + MV_PAR02 + "'					" 	+ CRLF
		
	EndIf
	
	If !(Empty(MV_PAR07)) .And. !(Empty(MV_PAR08))
		
		_cQuery += "     AND BA1.BA1_CONEMP BETWEEN '" + MV_PAR07 + "' AND '" + MV_PAR08 + "'                   " 	+ CRLF
		
	EndIf
	
	If !(Empty(MV_PAR09)) .And. !(Empty(MV_PAR10))
		
		_cQuery += "     AND BA1.BA1_SUBCON BETWEEN '" + MV_PAR09 + "' AND '" + MV_PAR10 + "'                   " 	+ CRLF
		
	EndIf
	
	If MV_PAR11 = 1 //ATIVOS
		
		_cQuery += "     AND BA1.BA1_DATBLO = ' '																" 	+ CRLF
		
	ElseIf MV_PAR11 = 2 //BLOQUEADOS
		
		_cQuery += "     AND BA1.BA1_DATBLO <> ' '																" 	+ CRLF
		
	EndIf
	
	_cQuery += "     AND BA1.D_E_L_E_T_      = ' '                                                              " 	+ CRLF
	_cQuery += "                                                                                                " 	+ CRLF
	_cQuery += " ORDER BY                                                                                       " 	+ CRLF
	_cQuery += "     BA1.BA1_CODEMP,                                                                            " 	+ CRLF
	_cQuery += "     BA1.BA1_CONEMP,                                                                            " 	+ CRLF
	_cQuery += "     BA1.BA1_SUBCON,                                                                            " 	+ CRLF
	_cQuery += "     BA1.BA1_CODINT||BA1.BA1_CODEMP||BA1.BA1_MATRIC||BA1.BA1_TIPREG||BA1.BA1_DIGITO             " 	+ CRLF
	
	memowrite("C:\temp\CABR275.sql",_cQuery)
	
Return _cQuery


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCABR275E  บAutor  ณAngelo Henrique     บ Data ณ  24/10/16   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRotina responsavel por gerar o relat๓rio em CSV, pois       บฑฑ
ฑฑบ          ณalguns usuแrios nใo possuem o Excel.                        บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CABERJ                                                     บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function CABR275E()
	
	Local _aArea 	:= GetArea()
	Local _cQuery	:= ""
	Local nHandle 	:= 0
	Local cNomeArq	:= ""
	Local cMontaTxt	:= ""
	
	Private _cAlias2	:= GetNextAlias()
	
	ProcRegua(RecCount())
	
	cNomeArq := "C:\TEMP\JUDICIAL"
	cNomeArq += "_" + SUBSTR(DTOS(DATE()),7,2)
	cNomeArq += "_" + SUBSTR(DTOS(DATE()),5,2)
	cNomeArq += "_" + SUBSTR(DTOS(DATE()),1,4)
	cNomeArq += "_" + STRTRAN(TIME(),":","_") + ".csv"
	
	//---------------------------------------------
	//CABR275D Realiza toda a montagem da query
	//facilitando a manuten็ใo do fonte
	//---------------------------------------------
	_cQuery := CABR275D()
	
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
				
				cMontaTxt := "COD_EMP ; "
				cMontaTxt += "EMPRESA ; "
				cMontaTxt += "CONTRATO ; "
				cMontaTxt += "SUBCON ; "
				cMontaTxt += "SUBCONTRATO ; "
				cMontaTxt += "MATRICULA ; "
				cMontaTxt += "BENEFICIARIO ; "
				cMontaTxt += "BLOQUEIO ; "
				cMontaTxt += "COD_BLOQ ; "
				cMontaTxt += "DESC_BLOQ ; "
				cMontaTxt += "ANO BASE ; "
				cMontaTxt += "MES BASE ; "
				cMontaTxt += "MENSALIDADE ; "
				
				cMontaTxt += CRLF // Salto de linha para .csv (excel)
				
				FWrite(nHandle,cMontaTxt)
				
			Else
				
				Aviso("Aten็ใo","Nใo foi possํvel criar o relat๓rio",{"OK"})
				Exit
				
			EndIf
			
		EndIf
		
		cMontaTxt := "'" + AllTrim((_cAlias2)->COD_EMP		) + ";"
		cMontaTxt += "'" + AllTrim((_cAlias2)->EMPRESA		) + ";"
		cMontaTxt += "'" + AllTrim((_cAlias2)->CONTRATO		) + ";"
		cMontaTxt += "'" + AllTrim((_cAlias2)->SUBCON		) + ";"
		cMontaTxt += "'" + AllTrim((_cAlias2)->SUBCONTRATO	) + ";"
		cMontaTxt += "'" + AllTrim((_cAlias2)->MATRICULA	) + ";"
		cMontaTxt += "'" + AllTrim((_cAlias2)->BENEFICIARIO	) + ";"
		cMontaTxt += "'" + AllTrim((_cAlias2)->BLOQUEIO		) + ";"
		cMontaTxt += "'" + AllTrim((_cAlias2)->COD_BLOQ		) + ";"
		cMontaTxt += "'" + AllTrim((_cAlias2)->DESC_BLOQ	) + ";"
		cMontaTxt += "'" + AllTrim((_cAlias2)->ANO			) + ";"
		cMontaTxt += "'" + AllTrim((_cAlias2)->MES			) + ";"
		cMontaTxt += "'" + AllTrim((_cAlias2)->MENSALIDADE	) + ";"
		
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