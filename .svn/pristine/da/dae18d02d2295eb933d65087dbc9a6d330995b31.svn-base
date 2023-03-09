#INCLUDE "REPORT.CH"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "TOPCONN.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCABR198     บAutor  ณAngelo Henrique   บ Data ณ  14/09/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRelat๓rio Sint้tico de movimento de repassados.             บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CABERJ                                                     บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function CABR198()
	
	Local _aArea 	:= GetArea()
	Local oReport	:= Nil
	
	Private _cPerg	:= "CABR198"
	
	//Cria grupo de perguntas
	CABR198A(_cPerg)
	
	If Pergunte(_cPerg,.T.)
		
		oReport := CABR198B()
		oReport:PrintDialog()
		
	EndIf
	
	RestArea(_aArea)
	
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCABR198A    บAutor  ณAngelo Henrique   บ Data ณ  14/09/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRelat๓rio Sint้tico de movimento de repassados.             บฑฑ
ฑฑบ          ณ -----  Perguntas do Relat๓rio -------------------          บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CABERJ                                                     บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function CABR198A(cGrpPerg)
	
	Local aHelpPor := {} //help da pergunta
	
	aHelpPor := {}
	AADD(aHelpPor,"Indique a Empresa  			")
	AADD(aHelpPor,"De/Ate a ser utilizado.		")
	
	PutSx1(cGrpPerg,"01","Empresa De ? "		,"a","a","MV_CH1"	,"C",TamSX3("BA3_CODEMP")[1]	,0,0,"G","","B7APLS"	,"","","MV_PAR01","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")
	PutSx1(cGrpPerg,"02","Empresa Ate ?"		,"a","a","MV_CH2"	,"C",TamSX3("BA3_CODEMP")[1]	,0,0,"G","","B7APLS"	,"","","MV_PAR02","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")
	
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCABR198A    บAutor  ณAngelo Henrique   บ Data ณ  14/09/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRelat๓rio Sint้tico de movimento de repassados.             บฑฑ
ฑฑบ          ณ -----  Gerando as colunas para o relat๓rio -------------   บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CABERJ                                                     บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function CABR198B
	
	Local oReport		:= Nil
	Local oSection1 	:= Nil
	
	oReport := TReport():New("CABR198","Mov. Repassados Sint้tico",_cPerg,{|oReport| CABR198C(oReport)},"Mov. Repassados Sint้tico")
	
	//Impressใo formato paisagem
	oReport:SetLandScape()
	
	oSection1 := TRSection():New(oReport,"Mov. Repassados Sint้tico","BA1")
	
	TRCell():New(oSection1,"BA1_CODEMP" 	,"BA1",,,,,,,,,,,,,,,,,,,,)
	oSection1:Cell("BA1_CODEMP"):SetName("EMPRESA")
	oSection1:Cell("EMPRESA"):SetAutoSize(.F.)
	oSection1:Cell("EMPRESA"):SetSize(10)
	
	TRCell():New(oSection1,"DESC_EMP" 		,"BA1",,,,,,,,,,,,,,,,,,,,)
	oSection1:Cell("DESC_EMP"):SetAutoSize(.F.)
	oSection1:Cell("DESC_EMP"):SetSize(40)
	
	TRCell():New(oSection1,"TOT_ATIVO" 	,"BA1",,,,,,,,,,,,,,,,,,,,)
	oSection1:Cell("TOT_ATIVO"):SetAutoSize(.F.)
	oSection1:Cell("TOT_ATIVO"):SetSize(15)
	
	TRCell():New(oSection1,"TOT_REPAS" 	,"BA1",,,,,,,,,,,,,,,,,,,,)
	oSection1:Cell("TOT_REPAS"):SetAutoSize(.F.)
	oSection1:Cell("TOT_REPAS"):SetSize(15)
	
	TRCell():New(oSection1,"PERC"			,"BA1",,,,,,,,,,,,,,,,,,,,)
	oSection1:Cell("PERC"):SetAutoSize(.F.)
	oSection1:Cell("PERC"):SetSize(15)
	
Return oReport


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCABR198A    บAutor  ณAngelo Henrique   บ Data ณ  14/09/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRelat๓rio Sint้tico de movimento de repassados.             บฑฑ
ฑฑบ          ณ -----  Gerando as informa็๕es para o relat๓rio ---------   บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CABERJ                                                     บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function CABR198C(oReport)
	
	Local _aArea 		:= GetArea()
	Local oSection1 	:= oReport:Section(1)
	Local oSection2	:= oReport:Section(1):Section(1)
	Local _cQuery		:= ""
	Local _cAlias1	:= GetNextAlias()
	Local _nCont		:= 0
	
	//Alterando o tamanho da pแgina para caber todos os campos
	oReport:oPage:setPaperSize(29)
	
	_cQuery := " SELECT BA1_CODEMP,DESC_EMP, TOT_ATIVO,  TOT_REPAS, ROUND(((TOT_REPAS * 100) / TOT_ATIVO),2)  PERC "
	_cQuery += " FROM "
	_cQuery += " ( "
	_cQuery += " SELECT DISTINCT BA1T.BA1_CODEMP, BG9.BG9_DESCRI DESC_EMP, "
	_cQuery += " ( SELECT COUNT(*) "
	_cQuery += " FROM " + RetSqlName("BA1") + " BA1C "
	_cQuery += " WHERE BA1C.D_E_L_E_T_ = ' ' "
	_cQuery += " AND BA1C.BA1_DATBLO = ' ' "
	_cQuery += " AND BA1C.BA1_FILIAL = '" + xFilial("BI3") + "' "
	_cQuery += " AND BA1T.BA1_CODEMP = BA1C.BA1_CODEMP "
	_cQuery += " ) TOT_ATIVO, "
	_cQuery += " ( SELECT COUNT(*) "
	_cQuery += " FROM " + RetSqlName("BA1") + " BA1R "
	_cQuery += " WHERE BA1R.D_E_L_E_T_ = ' ' "
	_cQuery += " AND BA1R.BA1_DATBLO = ' ' "
	_cQuery += " AND BA1R.BA1_YMTREP <> ' ' "
	_cQuery += " AND BA1R.BA1_FILIAL = '" + xFilial("BI3") + "' "
	_cQuery += " AND BA1T.BA1_CODEMP = BA1R.BA1_CODEMP "
	_cQuery += " ) TOT_REPAS "
	_cQuery += " FROM " + RetSqlName("BA1") + " BA1T, " + RetSqlName("BG9") + " BG9 "
	_cQuery += " WHERE BA1T.D_E_L_E_T_ = ' ' "
	_cQuery += " AND BG9.D_E_L_E_T_ = ' ' "
	_cQuery += " AND BA1T.BA1_FILIAL = '" + xFilial("BI3") + "' "
	_cQuery += " AND BG9.BG9_FILIAL = '" + xFilial("BI3") + "' "
	_cQuery += " AND BG9.BG9_CODIGO = BA1T.BA1_CODEMP "
	_cQuery += " ) WHERE TOT_ATIVO <> 0 AND TOT_REPAS <> 0 "
	
	//Empresa
	If !(Empty(MV_PAR01)) .OR. !(Empty(MV_PAR02))
		
		_cQuery += "AND BA1_CODEMP BETWEEN '" + MV_PAR01 + "' AND '" + MV_PAR02 + "' "
		
	EndIf
	
	_cQuery += " ORDER BY BA1_CODEMP "
	
	If Select(_cAlias1) > 0
		(_cAlias1)->(DbCloseArea())
	EndIf
	
	PLSQuery(_cQuery,_cAlias1)
	
	oSection1:Init()
	oSection1:SetHeaderSection(.T.)
	
	While !(_cAlias1)->(eof())
		
		oReport:IncMeter()
		
		If oReport:Cancel()
			Exit
		EndIf
		
		oSection1:Cell("EMPRESA"		):SetValue((_cAlias1)->BA1_CODEMP	)
		oSection1:Cell("DESC_EMP"	):SetValue((_cAlias1)->DESC_EMP		)
		oSection1:Cell("TOT_ATIVO"	):SetValue((_cAlias1)->TOT_ATIVO	)
		oSection1:Cell("TOT_REPAS"	):SetValue((_cAlias1)->TOT_REPAS	)
		oSection1:Cell("PERC"		):SetValue((_cAlias1)->PERC			)
		
		oSection1:PrintLine()
		
		(_cAlias1)->(DbSkip())
		
	EndDo
	
	oSection1:Finish()
	
	If Select(_cAlias1) > 0
		(_cAlias1)->(DbCloseArea())
	EndIf
	
	RestArea(_aArea)
	
Return (.T.)