#INCLUDE 'PROTHEUS.CH'

/*/{Protheus.doc} CABR278

Rotina Utilizada para gerar o relat๓rio de Quita็ใo de D้bitos

@description Esta rotina chama o Crystal para exibir o relat๓rio
@description Arquivo Crystal: QUITDEB
@description Procedure do Oracle: CR_PLS_QUITACAO_DEBITO

@type function
@author angelo.cassago
@since 13/12/2019
@version 1.0
/*/

User Function CABR278()
			
	Private cParams	:= ""	
	Private cParIpr	:="1;0;1;Declara็ใo de Quita็ใo"
	Private _cPerg	:= "CABR278"
	
	//-----------------------------------------------------
	//Cria grupo de perguntas
	//-----------------------------------------------------
	CABR278A(_cPerg)
	
	If Pergunte(_cPerg,.T.)
		
		cParams := ";" + MV_PAR01 + ";" + MV_PAR02 + ";" + MV_PAR03 + ";" + MV_PAR04 + ";" + MV_PAR05  + ";" + SUBSTR(cEmpAnt,2,1) + ";" + AllTrim(MV_PAR06) + ";"	+ AllTrim(MV_PAR07)
		
		CallCrys("QUITDEB",cParams,cParIpr)
		
	EndIf			
	
Return



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCABR278A  บAutor  ณAngelo Henrique     บ Data ณ  11/12/19   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRotina responsavel pela gera็ใo das perguntas no relat๓rio  บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CABERJ                                                     บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function CABR278A(cGrpPerg)
	
	Local aHelpPor 	:= {} //help da pergunta
	Local _nTamMat	:= 0
	
	_nTamMat	+= TamSX3("BA1_CODINT")[1]
	_nTamMat	+= TamSX3("BA1_CODEMP")[1]
	_nTamMat	+= TamSX3("BA1_MATRIC")[1]
	
	aHelpPor := {}
	AADD(aHelpPor,"Informe a Matricula 			")
	AADD(aHelpPor,"do beneficiแrio.				")
	AADD(aHelpPor,"Branco para todos			")
	
	u_CABASX1(cGrpPerg,"01","Matricula: ?"			,"a","a","MV_CH1"	,"C",_nTamMat					,0,0,"G","","CAB595","","","MV_PAR01","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")
	
	aHelpPor := {}
	AADD(aHelpPor,"Informe o M๊s  de			")
	AADD(aHelpPor,"Compet๊ncia  De:				")
	AADD(aHelpPor,"Branco para todos	  		")
	
	u_CABASX1(cGrpPerg,"02","Mes De: "				,"a","a","MV_CH2"	,"C",TamSX3("E1_MESBASE")[1]	,0,0,"G","","","","","MV_PAR02","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")
	
	aHelpPor := {}
	AADD(aHelpPor,"Informe o M๊s de 			")
	AADD(aHelpPor,"Compet๊ncia  At้:			")
	AADD(aHelpPor,"Branco para todos			")
	
	u_CABASX1(cGrpPerg,"03","M๊s At้"				,"a","a","MV_CH3"	,"C",TamSX3("E1_MESBASE")[1]	,0,0,"G","","","","","MV_PAR03","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")
	
	
	aHelpPor := {}
	AADD(aHelpPor,"Informe o Ano de  			")
	AADD(aHelpPor,"Compet๊ncia De: 				")
	AADD(aHelpPor,"Branco para todos			")
	
	u_CABASX1(cGrpPerg,"04","Ano De: "				,"a","a","MV_CH4"	,"C",TamSX3("E1_ANOBASE")[1]	,0,0,"G","","","","","MV_PAR04","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")
	
	aHelpPor := {}
	AADD(aHelpPor,"Informe o Ano de  			")
	AADD(aHelpPor,"Compet๊ncia Ate:				")
	AADD(aHelpPor,"Branco para todos			")
		
	u_CABASX1(cGrpPerg,"05","Ano At้: "				,"a","a","MV_CH5"	,"C",TamSX3("E1_ANOBASE")[1]	,0,0,"G","","","","","MV_PAR05","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")
		
	aHelpPor := {}
	AADD(aHelpPor,"Informe a(s) rubrica(s) que	")
	AADD(aHelpPor,"compoem a mensalidade		")	
	
	u_CABASX1(cGrpPerg,"06","Rubric Mensalidade:"	,"a","a","MV_CH6"	,"C",99						,0,0,"G","","","","","MV_PAR06","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")
		
	aHelpPor := {}
	AADD(aHelpPor,"Informe a(s) rubrica(s) que	")
	AADD(aHelpPor,"compoem a COPART				")
	
	u_CABASX1(cGrpPerg,"07","Rubric Copart:"		,"a","a","MV_CH7"	,"C",99						,0,0,"G","","","","","MV_PAR07","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")		
	
Return