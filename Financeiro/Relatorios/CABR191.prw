#INCLUDE "REPORT.CH"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "TOPCONN.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCABR191     บAutor  ณAngelo Henrique   บ Data ณ  17/08/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRelat๓rio Financeiro responsแvel por trazer os valores      บฑฑ
ฑฑบ          ณmenores ou iguais ao mencionado no parโmetro.               บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CABERJ                                                     บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function CABR191()
	
	Local _aArea 	:= GetArea()
	Local oReport	:= Nil
	Local _cPerg	:= "CABR191"
	
	//Cria grupo de perguntas
	CABR191C(_cPerg)
	
	If Pergunte(_cPerg,.T.)
		
		oReport := CABR191A()
		oReport:PrintDialog()
		
	EndIf
	
	RestArea(_aArea)
	
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCABR191A  บAutor  ณAngelo Henrique     บ Data ณ  17/08/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRotina que irแ gerar as informa็๕es do relat๓rio            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CABERJ                                                     บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function CABR191A
	
	Local oReport		:= Nil
	Local oSection1 	:= Nil
	Local _cAlias1	:= GetNextAlias()
	
	//Defini็ใo do relat๓rio
	DEFINE REPORT oReport NAME 'Tํtulos com valores inferiores' TITLE 'Tํtulos com valores inferiores' ;
		ACTION {|oReport| CABR191B( oReport,_cAlias1)} DESCRIPTION 'Tํtulos com valores inferiores'
	
	//Impressใo formato retrato
	oReport:SetPortrait()
	
	//Se็ใo 1
	DEFINE SECTION oSection1 OF oReport TITLE 'Tํtulos com valores inferiores' TABLES 'SE1,BA3,BA1'
	
	//Campos da se็ใo 1
	DEFINE CELL NAME 'E1_PREFIXO'	OF oSection1 ALIAS 'SE1' SIZE 15
	DEFINE CELL NAME 'E1_NUM'		OF oSection1 ALIAS 'SE1' SIZE TAMSX3("E1_NUM")[1]
	DEFINE CELL NAME 'E1_PARCELA'	OF oSection1 ALIAS 'SE1' SIZE 10
	DEFINE CELL NAME 'E1_TIPO'  	OF oSection1 ALIAS 'SE1' SIZE 10
	DEFINE CELL NAME 'E1_CLIENTE'	OF oSection1 ALIAS 'SE1' SIZE 10
	DEFINE CELL NAME 'E1_NOMCLI'	OF oSection1 ALIAS 'SE1' SIZE 50
	DEFINE CELL NAME 'E1_EMISSAO'	OF oSection1 ALIAS 'SE1' SIZE 10
	DEFINE CELL NAME 'E1_VALOR'		OF oSection1 ALIAS 'SE1' SIZE TAMSX3("E1_VALOR")[1]
	DEFINE CELL NAME 'E1_PLNUCOB'	OF oSection1 ALIAS 'SE1' SIZE 30
	DEFINE CELL NAME 'E1_ANOBASE'	OF oSection1 ALIAS 'SE1' SIZE 10 
	DEFINE CELL NAME 'E1_MESBASE'	OF oSection1 ALIAS 'SE1' SIZE 10
	DEFINE CELL NAME 'BA3_CODEMP'	OF oSection1 ALIAS 'BA3' SIZE 15
	DEFINE CELL NAME 'BA3_CODINT'	OF oSection1 ALIAS 'BA3' SIZE 15
	DEFINE CELL NAME 'BA3_MATRIC'	OF oSection1 ALIAS 'BA3' SIZE 20
	DEFINE CELL NAME 'BA1_NOMUSR'	OF oSection1 ALIAS 'BA1' SIZE TAMSX3("BA1_NOMUSR")[1]
	
	//Texto totalizador
	oSection1:SetTotalText("")
	
	//Totalizador em coluna
	oSection1:SetTotalInLine(.F.)
	
Return oReport

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCABR191B  บAutor  ณAngelo Henrique     บ Data ณ  17/08/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRotina para montar a query e trazer as informa็๕es no       บฑฑ
ฑฑบ          ณrelat๓rio.                                                  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CABERJ                                                     บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function CABR191B(oReport,_cAlias1)
	
	Local _aArea 		:= GetArea()
	Local oSection1 	:= oReport:Section(1)
	Local _cQuery		:= ""
	
	//Montagem do Filtro da Query
	_cQuery := ""
	_cQuery += " SE1.E1_VALOR <= '" + cValTochar(MV_PAR01) + "'"
	
	//--------------------------------------------------------------------------------------------------
	//Valida็๕es que impactam a query conforme preenchimento dos paramteros listados para o usuแrio
	//--------------------------------------------------------------------------------------------------
	
	//CLIENTE
	If !(Empty(MV_PAR02)) .OR. !(Empty(MV_PAR03))
		
		_cQuery += " AND SE1.E1_CLIENTE BETWEEN '" + MV_PAR02 + "' AND '" + MV_PAR03 + "' "
		
	EndIf
	
	//PREFIXO
	If !(Empty(MV_PAR04)) .OR. !(Empty(MV_PAR05))
		
		_cQuery += " AND SE1.E1_PREFIXO BETWEEN '" + MV_PAR04 + "' AND '" + MV_PAR05 + "' "
		
	EndIf
	
	//NUMERO DO TITULO
	If !(Empty(MV_PAR06)) .OR. !(Empty(MV_PAR07))
		
		_cQuery += " AND SE1.E1_NUM BETWEEN '" + MV_PAR06 + "' AND '" + MV_PAR07 + "' "
		
	EndIf
	
	//Data de Emissใo
	If !(Empty(MV_PAR08)) .OR. !(Empty(MV_PAR09))
		
		_cQuery += " AND SE1.E1_EMISSAO BETWEEN '" + DTOS(MV_PAR08) + "' AND '" + DTOS(MV_PAR09) + "' "
		
	EndIf
	
	//Lote de Cobran็a
	If !(Empty(MV_PAR10)) .OR. !(Empty(MV_PAR11))
		
		_cQuery += " AND SE1.E1_PLNUCOB BETWEEN '" + MV_PAR10 + "' AND '" + MV_PAR11 + "' "
		
	EndIf
	
	_cQuery := "%" + _cQuery + "%"
	
	Begin Report Query oSection1
		BeginSQL Alias _cAlias1
			
			Select
			SE1.E1_PREFIXO
			,SE1.E1_NUM
			,SE1.E1_PARCELA
			,SE1.E1_TIPO
			,SE1.E1_CLIENTE
			,SE1.E1_NOMCLI
			,SE1.E1_EMISSAO
			,SE1.E1_VALOR
			,SE1.E1_PLNUCOB
			,SE1.E1_ANOBASE
			,SE1.E1_MESBASE
			,BA3.BA3_CODEMP
			,BA3.BA3_CODINT
			,BA3.BA3_MATRIC
			,BA1.BA1_NOMUSR
			From
			%table:SE1% SE1
			,%table:BA1% BA1
			,%table:BA3% BA3
			Where
			SE1.%notDel%
			and BA1.%notDel%
			and BA3.%notDel%
			and SE1.E1_FILIAL	= %xFilial:SE1%
			and BA1.BA1_FILIAL	= %xFilial:BA1%
			and BA3.BA3_FILIAL	= %xFilial:BA3%
			and BA3.BA3_CODEMP 	= SE1.E1_CODEMP
			and BA3.BA3_CODINT 	= SE1.E1_CODINT
			and BA3.BA3_MATRIC 	= SE1.E1_MATRIC
			and BA1.BA1_CODEMP 	= BA3.BA3_CODEMP
			and BA1.BA1_CODINT 	= BA3.BA3_CODINT
			and BA1.BA1_MATRIC 	= BA3.BA3_MATRIC
			and SE1.E1_SALDO	> 0
			and BA1.BA1_TIPUSU 	= 'T'
			and %exp:_cQuery%
			
		EndSql
	End Report Query oSection1
	
	//Efetua impressใo
	oSection1:Print()
	
	RestArea(_aArea)
	
Return(.T.)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCABR191C  บAutor  ณAngelo Henrique     บ Data ณ  17/08/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRotina responsavel pela gera็ใo das perguntas no relat๓rio  บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CABERJ                                                     บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function CABR191C(cGrpPerg)
	
	Local aHelpPor := {} //help da pergunta
	
	aHelpPor := {}
	AADD(aHelpPor,"Indique o valor que serแ    ")
	AADD(aHelpPor,"a base para o relat๓rio.    ")
	
	PutSx1(cGrpPerg,"01","Valor  ?"		,"a","a","MV_CH1","N",TamSX3("E1_VALOR")[1]	,2,0,"G","NaoVazio()",""		,"","","MV_PAR01","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")
	
	aHelpPor := {}
	AADD(aHelpPor,"Indique o cliente De/Ate    ")
	AADD(aHelpPor,"a ser utilizado.            ")
	
	PutSx1(cGrpPerg,"02","Cliente de?"	,"a","a","MV_CH2","C",TamSX3("E1_CLIENTE")[1]	,0,0,"G",""			,"CLI"	,"","","MV_PAR02","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")
	PutSx1(cGrpPerg,"03","Cliente Ate?","a","a","MV_CH3","C",TamSX3("E1_CLIENTE")[1]	,0,0,"G",""			,"CLI"	,"","","MV_PAR03","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")
	
	aHelpPor := {}
	AADD(aHelpPor,"Indique o prefixo De/Ate    ")
	AADD(aHelpPor,"a ser utilizado.            ")
	
	PutSx1(cGrpPerg,"04","Prefixo de?"	,"a","a","MV_CH4","C",TamSX3("E1_PREFIXO")[1]	,0,0,"G",""			,""		,"","","MV_PAR04","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")
	PutSx1(cGrpPerg,"05","Prefixo Ate?","a","a","MV_CH5","C",TamSX3("E1_PREFIXO")[1]	,0,0,"G",""			,""		,"","","MV_PAR05","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")
	
	aHelpPor := {}
	AADD(aHelpPor,"Indique o tํtulo  De/Ate    ")
	AADD(aHelpPor,"a ser utilizado.            ")
	
	PutSx1(cGrpPerg,"06","Titulo de?"	,"a","a","MV_CH6","C",TamSX3("E1_NUM")[1]		,0,0,"G",""			,""		,"","","MV_PAR06","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")
	PutSx1(cGrpPerg,"07","Titulo  Ate?","a","a","MV_CH7","C",TamSX3("E1_NUM")[1]		,0,0,"G",""			,""		,"","","MV_PAR07","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")
	
	aHelpPor := {}
	AADD(aHelpPor,"Indique a data de Emissao   ")
	AADD(aHelpPor,"De/Ate a ser utilizada      ")
	
	PutSx1(cGrpPerg,"08","Emissao de?"	,"a","a","MV_CH8","D",TamSX3("E1_EMISSAO")[1]	,0,0,"G",""			,""		,"","","MV_PAR08","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")
	PutSx1(cGrpPerg,"09","Emissao Ate?","a","a","MV_CH9","D",TamSX3("E1_EMISSAO")[1]	,0,0,"G",""			,""		,"","","MV_PAR09","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")
	
	aHelpPor := {}
	AADD(aHelpPor,"Indique o lote De/Ate       ")
	AADD(aHelpPor,"a ser utilizada.            ")
	
	PutSx1(cGrpPerg,"10","Lote de?"		,"a","a","MV_CH10","C",TamSX3("E1_PLNUCOB")[1]	,0,0,"G",""		,""		,"","","MV_PAR10","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")
	PutSx1(cGrpPerg,"11","Lote Ate?"	,"a","a","MV_CH11","C",TamSX3("E1_PLNUCOB")[1]	,0,0,"G",""		,""		,"","","MV_PAR11","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")
	
Return