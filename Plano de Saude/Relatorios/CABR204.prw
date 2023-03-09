#INCLUDE "REPORT.CH"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "TOPCONN.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCABR204   บAutor  ณAngelo Henrique     บ Data ณ  11/01/16   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRelat๓rio utilizado para exibir os beneficiแrios com ou     บฑฑ
ฑฑบ          ณsem CNS.                                                    บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CABERJ                                                     บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function CABR204()
	
	Local _aArea 		:= GetArea()
	
	Local oReport		:= Nil
	
	Private _cPerg	:= "CABR204"
	
	//Cria grupo de perguntas
	CABR204A(_cPerg)
	
	If Pergunte(_cPerg,.T.)
		
		oReport := CABR204B()
		oReport:PrintDialog()
		
	EndIf
	
	RestArea(_aArea)
	
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCABR204A    บAutor  ณAngelo Henrique   บ Data ณ  05/01/16   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRelat๓rio de beneficiแrios para libera็ใo de gera็ใo de     บฑฑ
ฑฑบ          ณcarteira.                                                   บฑฑ
ฑฑบ          ณ -----  Perguntas do Relat๓rio -------------------          บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CABERJ                                                     บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function CABR204A(cGrpPerg)
	
	Local aHelpPor := {} //help da pergunta
	
	aHelpPor := {}
	AADD(aHelpPor,"Indique a Empresa				")
	AADD(aHelpPor,"De/Ate a ser utilizada.			")
	
	PutSx1(cGrpPerg,"01","Empresa De ? "	,"a","a","MV_CH1"	,"C",TamSX3("BA1_CDIDEN")[1]	,0,0,"G","","B7APLS"	,"","","MV_PAR01","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")
	PutSx1(cGrpPerg,"02","Empresa Ate ?"	,"a","a","MV_CH2"	,"C",TamSX3("BA1_CDIDEN")[1]	,0,0,"G","","B7APLS"	,"","","MV_PAR02","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")
	
	aHelpPor := {}
	AADD(aHelpPor,"Indique a Op็ใo:  				")
	AADD(aHelpPor,"Preenchido, Vazio ou Ambos.   	")
	
	PutSX1(cGrpPerg,"03","Listar ?" 		,"a","a","MV_CH3","N",1								,0,0,"C","",""		,"","","MV_PAR03","Preenchido","","","","Vazio","","","Ambos","","","","","","","","",aHelpPor,{},{},"")
	
	aHelpPor := {}
	AADD(aHelpPor,"Indique a Data de Inclusใo 	")
	AADD(aHelpPor,"De/Ate a ser utilizado.			")
	
	PutSx1(cGrpPerg,"04","Data De ? "			,"a","a","MV_CH4"	,"D",TamSX3("BA1_DATINC")[1]	,0,0,"G","",""		,"","","MV_PAR04","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")
	PutSx1(cGrpPerg,"05","Data Ate ?"			,"a","a","MV_CH5"	,"D",TamSX3("BA1_DATINC")[1]	,0,0,"G","",""		,"","","MV_PAR05","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")
	
	aHelpPor := {}
	AADD(aHelpPor,"Indique o Plano Origem:			")
	AADD(aHelpPor,"Utilizado para Reciprocidade  	")
	
	PutSX1(cGrpPerg,"06","Origem ?" 			,"a","a","MV_CH6","C",TamSX3("BA1_OPEORI")[1]		,0,0,"G","","B89PLS"	,"","","MV_PAR06","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")
	
	aHelpPor := {}
	AADD(aHelpPor,"Indique o Plano Destino:		")
	AADD(aHelpPor,"Utilizado para Reciprocidade  	")
	
	PutSX1(cGrpPerg,"07","Destino ?" 			,"a","a","MV_CH7","C",TamSX3("BA1_OPEDES")[1]		,0,0,"G","","B89PLS"	,"","","MV_PAR07","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")
	
Return



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCABR204B    บAutor  ณAngelo Henrique   บ Data ณ  05/01/16   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRelat๓rio de beneficiแrios para libera็ใo de gera็ใo de     บฑฑ
ฑฑบ          ณcarteira.                                                   บฑฑ
ฑฑบ          ณ -----  Gerando as colunas para o relat๓rio -------------   บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CABERJ                                                     บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function CABR204B
	
	Local oReport		:= Nil
	Local oSection1 	:= Nil
	
	oReport := TReport():New("CABR204","Beneficiแrios CNS",_cPerg,{|oReport| CABR204C(oReport)},"Beneficiแrios CNS")
	
	//Impressใo formato paisagem
	oReport:SetLandScape()
	
	oSection1 := TRSection():New(oReport,"Beneficiแrios CNS","BA1")
	
	TRCell():New(oSection1,"EMPRESA"			,"BA1",,,,,,,,,,,,,,,,,,,,)
	oSection1:Cell("EMPRESA"):SetAutoSize(.F.)
	oSection1:Cell("EMPRESA"):SetSize(10)
	
	TRCell():New(oSection1,"DESC_EMP" 			,"BA1",,,,,,,,,,,,,,,,,,,,)
	oSection1:Cell("DESC_EMP"):SetAutoSize(.F.)
	oSection1:Cell("DESC_EMP"):SetSize(50)
	
	TRCell():New(oSection1,"CPF"				,"BA1",,,,,,,,,,,,,,,,,,,,)
	oSection1:Cell("CPF"):SetAutoSize(.T.)
		
	TRCell():New(oSection1,"NOME" 				,"BA1",,,,,,,,,,,,,,,,,,,,)
	oSection1:Cell("NOME"):SetAutoSize(.F.)
	oSection1:Cell("NOME"):SetSize(50)
	
	TRCell():New(oSection1,"DT_NASC"			,"BA1",,,,,,,,,,,,,,,,,,,,)
	oSection1:Cell("DT_NASC"):SetAutoSize(.T.)
	
	TRCell():New(oSection1,"DT_INC"				,"BA1",,,,,,,,,,,,,,,,,,,,)
	oSection1:Cell("DT_INC"):SetAutoSize(.T.)	
	
	TRCell():New(oSection1,"CARTAO_NACIONAL"	,"BA1",,,,,,,,,,,,,,,,,,,,)
	oSection1:Cell("CARTAO_NACIONAL"):SetAutoSize(.T.)
	
	TRCell():New(oSection1,"ORIGEM"				,"BA1",,,,,,,,,,,,,,,,,,,,)
	oSection1:Cell("ORIGEM"):SetAutoSize(.T.)
	
	TRCell():New(oSection1,"DESTINO"			,"BA1",,,,,,,,,,,,,,,,,,,,)
	oSection1:Cell("DESTINO"):SetAutoSize(.T.)
	
Return oReport


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCABR204A    บAutor  ณAngelo Henrique   บ Data ณ  05/01/16   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRelat๓rio de beneficiแrios para libera็ใo de gera็ใo de     บฑฑ
ฑฑบ          ณcarteira.                                                   บฑฑ
ฑฑบ          ณ -----  Gerando as informa็๕es para o relat๓rio ---------   บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CABERJ                                                     บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function CABR204C(oReport)
	
	Local _aArea 		:= GetArea()
	Local oSection1 	:= oReport:Section(1)
	Local oSection2	:= oReport:Section(1):Section(1)
	Local _cQuery		:= ""
	Local _cAlias1	:= GetNextAlias()
	Local _nCont		:= 0
	Local _cCPF		:= ""
	
	//Alterando o tamanho da pแgina para caber todos os campos
	oReport:oPage:setPaperSize(29)
	
	_cQuery := " SELECT BA1.BA1_CODEMP EMPRESA, BG9.BG9_DESCRI DESC_EMP, "
	_cQuery += " BA1.BA1_CPFUSR CPF1, "
	_cQuery += " BA1.BA1_NOMUSR NOME, " 
	_cQuery += " BA1.BA1_DATINC DT_INC, "
	_cQuery += " BA1.BA1_DATNAS DT_NASC, "
	_cQuery += " BTS.BTS_NRCRNA CARTAO_NACIONAL, "
	_cQuery += " BTS.BTS_CPFUSR CPF2,"
	_cQuery += " BA1.BA1_OPEORI ORIGEM,"
	_cQuery += " BA1.BA1_OPEDES DESTINO"
	_cQuery += " FROM " + RetSqlName("BA1") + " BA1, " + RetSqlName("BG9") + " BG9, " + RetSqlName("BTS") + " BTS, " + RetSqlName("BA3") + " BA3 "
	_cQuery += " WHERE BA1.D_E_L_E_T_ = ' ' "
	_cQuery += " AND BG9.D_E_L_E_T_ = ' ' "
	_cQuery += " AND BTS.D_E_L_E_T_ = ' ' "
	_cQuery += " AND BA3.D_E_L_E_T_ = ' ' "
	_cQuery += " AND BA1.BA1_FILIAL = '" + xFilial("BA1") + "' "
	_cQuery += " AND BG9.BG9_FILIAL = '" + xFilial("BG9") + "' "
	_cQuery += " AND BTS.BTS_FILIAL = '" + xFilial("BTS") + "' "
	_cQuery += " AND BA3.BA3_FILIAL = '" + xFilial("BA3") + "' "
	_cQuery += " AND BG9.BG9_CODIGO = BA1.BA1_CODEMP "
	_cQuery += " AND BA1.BA1_MATVID = BTS.BTS_MATVID "
	_cQuery += " AND BA1.BA1_DATBLO = ' ' "
	_cQuery += " AND BA3.BA3_DATBLO = ' ' "
	_cQuery += " AND BA1.BA1_NOMUSR <> 'BA3 SEM TITULAR' "
	_cQuery += " AND BA3_CODINT = BA1_CODINT "
	_cQuery += " AND BA3_CODEMP = BA1_CODEMP "
	_cQuery += " AND BA3_MATRIC = BA1_MATRIC "
	
	//---------------------------------------------------------------------------
	//Regras abaixo somente para CABERJ, para nใo calcular ODONTOLOGICO
	//---------------------------------------------------------------------------
	If cEmpAnt = "01"
						
		_cQuery += " AND NOT ( BA1_CODEMP = '0024' AND BA1_SUBCON = '000000002') "
		_cQuery += " AND NOT ( BA1_CODEMP = '0025' AND BA1_SUBCON = '000000002') "
		_cQuery += " AND NOT ( BA1_CODEMP = '0025' AND BA1_SUBCON = '000000004') "
		_cQuery += " AND NOT ( BA1_CODEMP = '0027' AND BA1_SUBCON = '000000002') "
		_cQuery += " AND NOT ( BA1_CODEMP = '0028' AND BA1_SUBCON = '000000002') "
		
	EndIf
		
	//Empresa
	If !(Empty(MV_PAR01)) .OR. !(Empty(MV_PAR02))
		
		_cQuery += "AND BA1.BA1_CODEMP BETWEEN '" + MV_PAR01 + "' AND '" + MV_PAR02 + "' "
		
	EndIf
	
	//CNS: Preenchido, Vazio ou Ambos
	If !(Empty(MV_PAR03))
		
		If MV_PAR03 = 1
			
			_cQuery += "AND BTS.BTS_NRCRNA <> ' ' " //Preenchido
			
		ElseIf MV_PAR03 = 2
			
			_cQuery += "AND BTS.BTS_NRCRNA = ' ' " //Vazio
			
		EndIf
		
	EndIf
	
	//Data de Inclusใo
	If !(Empty(MV_PAR04)) .OR. !(Empty(MV_PAR05))
		
		_cQuery += "AND BA1.BA1_DATINC BETWEEN '" + DTOS(MV_PAR04) + "' AND '" + DTOS(MV_PAR05) + "' "
		
	EndIf
	
	//Reciprocidade
	If !(Empty(MV_PAR01)) .And. (!(Empty(MV_PAR06)) .OR. !(Empty(MV_PAR06))) 
	
		If !(Empty(MV_PAR06))
		
			_cQuery += "AND BA1.BA1_OPEORI = '" + MV_PAR06 + "'"
				
		EndIf
		
		If !(Empty(MV_PAR06))
		
			_cQuery += "AND BA1.BA1_OPEDES = '" + MV_PAR07 + "'"
		
		EndIf
	
	EndIf
		
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
		
		//-----------------------------------------------------------
		//Validando o CPF, pois em alguns casos no cadastro de vida
		//o CPF do beneficiแrio esta preenchido
		//-----------------------------------------------------------
		If Empty(AllTrim((_cAlias1)->CPF1))
		     
			_cCPF := (_cAlias1)->CPF2
		
		Else
		
			_cCPF := (_cAlias1)->CPF1
		
		EndIf
		
		oSection1:Cell("EMPRESA"				):SetValue(AllTrim((_cAlias1)->EMPRESA	)	)
		oSection1:Cell("DESC_EMP"			):SetValue(AllTrim((_cAlias1)->DESC_EMP)	)
		oSection1:Cell("CPF"					):SetValue(_cCPF								)
		oSection1:Cell("NOME"				):SetValue(AllTrim((_cAlias1)->NOME)		)
		oSection1:Cell("DT_NASC"				):SetValue(STOD((_cAlias1)->DT_NASC)		)
		oSection1:Cell("DT_INC"				):SetValue(STOD((_cAlias1)->DT_INC)		)
		oSection1:Cell("CARTAO_NACIONAL"	):SetValue((_cAlias1)->CARTAO_NACIONAL		)		
		oSection1:Cell("ORIGEM"				):SetValue((_cAlias1)->ORIGEM				)
		oSection1:Cell("DESTINO"				):SetValue((_cAlias1)->DESTINO				)		
		
		oSection1:PrintLine()
		
		(_cAlias1)->(DbSkip())
		
	EndDo
	
	oSection1:Finish()
	
	If Select(_cAlias1) > 0
		(_cAlias1)->(DbCloseArea())
	EndIf
	
	RestArea(_aArea)
	
Return (.T.)
