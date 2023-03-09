#INCLUDE "RWMAKE.CH"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "TOPCONN.CH"
#INCLUDE "FONT.CH"
#INCLUDE "TBICONN.CH"

#DEFINE cEnt CHR(13) + CHR(10)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCABR194     บAutor  ณAngelo Henrique   บ Data ณ  17/08/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRelat๓rio de Movimenta็ใo de Repassados - INTEGRAL          บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CABERJ                                                     บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function CABR194()
	
	Local _aArea 	:= GetArea()
	Local oReport	:= Nil
	
	Private _cPerg	:= "CABR194"
	
	//Cria grupo de perguntas
	CABR194C(_cPerg)
	
	If Pergunte(_cPerg,.T.)
		
		oReport := CABR194A()
		oReport:PrintDialog()
		
	EndIf
	
	RestArea(_aArea)
	
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCABR194A  บAutor  ณAngelo Henrique     บ Data ณ  17/08/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRotina que irแ gerar as informa็๕es do relat๓rio            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CABERJ                                                     บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function CABR194A
	
	Local oReport		:= Nil
	Local oSection1 	:= Nil
	Local oSection2 	:= Nil
	Local _cAlias1	:= GetNextAlias()
	
	oReport := TReport():New("CABR194","Mov. Repassados - Integral",_cPerg,{|oReport| CABR194B(oReport)},"Mov. Repassados - Integral")
	
	//Impressใo formato paisagem
	oReport:SetLandScape()
	
	//Alterando o tamanho da pแgina para caber todos os campos
	oReport:oPage:setPaperSize(29)
	
	//Tamanho do fonte para caber na pagina A4
	oReport:nFontBody := 4
	
	oSection1 := TRSection():New(oReport,"Mov. Repassados - Integral","BA1")
	
	TRCell():New(oSection1,"MAT_INTEGRAL" 	,"BA1",,,,,,,,,,,,,,,,,,,,)
	oSection1:Cell("MAT_INTEGRAL"):SetAutoSize(.F.)
	oSection1:Cell("MAT_INTEGRAL"):SetSize(25)
	
	TRCell():New(oSection1,"CONTRATO" 		,"BA1",							,,,,,,,,,,,,,,,,,,,)
	oSection1:Cell("CONTRATO"):SetAutoSize(.F.)
	oSection1:Cell("CONTRATO"):SetSize(15)
	
	TRCell():New(oSection1,"NOME_CONT" 		,"BT5",							,,,,,,,,,,,,,,,,,,,)
	oSection1:Cell("NOME_CONT"):SetAutoSize(.F.)
	oSection1:Cell("NOME_CONT"):SetSize(50)
	
	TRCell():New(oSection1,"SUBCONT" 		,"BG9",							,,,,,,,,,,,,,,,,,,,)
	oSection1:Cell("SUBCONT"):SetAutoSize(.F.)
	oSection1:Cell("SUBCONT"):SetSize(30)
	
	TRCell():New(oSection1,"NOME_SUB" 		,"BQC",							,,,,,,,,,,,,,,,,,,,)
	oSection1:Cell("NOME_SUB"):SetAutoSize(.F.)
	oSection1:Cell("NOME_SUB"):SetSize(50)
	
	TRCell():New(oSection1,"MAT_CABERJ" 	,"BA1",,,,,,,,,,,,,,,,,,,,)
	oSection1:Cell("MAT_CABERJ"):SetAutoSize(.F.)
	oSection1:Cell("MAT_CABERJ"):SetSize(25)
	
	TRCell():New(oSection1,"MAT_REPASSE" 	,"BA1",,,,,,,,,,,,,,,,,,,,)
	oSection1:Cell("MAT_REPASSE"):SetAutoSize(.F.)
	oSection1:Cell("MAT_REPASSE"):SetSize(25)
	
	TRCell():New(oSection1,"EMPRESA" 		,"BA1",,,,,,,,,,,,,,,,,,,,)
	oSection1:Cell("EMPRESA"):SetAutoSize(.F.)
	oSection1:Cell("EMPRESA"):SetSize(7)
	
	TRCell():New(oSection1,"DESC_EMP" 		,"BG9",,,,,,,,,,,,,,,,,,,,)
	oSection1:Cell("DESC_EMP"):SetAutoSize(.F.)
	oSection1:Cell("DESC_EMP"):SetSize(30)
	
	TRCell():New(oSection1,"PLANO" 			,"BA1",,,,,,,,,,,,,,,,,,,,)
	oSection1:Cell("PLANO"):SetAutoSize(.F.)
	oSection1:Cell("PLANO"):SetSize(5)
	
	TRCell():New(oSection1,"DESC_PLANO"	,"BI3",,,,,,,,,,,,,,,,,,,,)
	oSection1:Cell("DESC_PLANO"):SetAutoSize(.F.)
	oSection1:Cell("DESC_PLANO"):SetSize(23)
	
	TRCell():New(oSection1,"NOME" 			,"BA1",,,,,,,,,,,,,,,,,,,,)
	oSection1:Cell("NOME"):SetAutoSize(.F.)
	oSection1:Cell("NOME"):SetSize(40)
	
	TRCell():New(oSection1,"CPF" 			,"BA1",,,,,,,,,,,,,,,,,,,,)
	oSection1:Cell("CPF"):SetAutoSize(.F.)
	oSection1:Cell("CPF"):SetSize(13)
	/*
	//MATEUS MEDEIROS CHAMADO: GLPI - 45218 14/12/2017 - INICIO
	TRCell():New(oSection1,"IDADE" 			,"BA1",,,,,,,,,,,,,,,,,,,,)
	oSection1:Cell("IDADE"):SetAutoSize(.F.)
	oSection1:Cell("IDADE"):SetSize(7)
	// FIM
	*/
	
	TRCell():New(oSection1,"NASCIMENTO"		,"BA1",							,,,,,,,,,,,,,,,,,,,)
	oSection1:Cell("NASCIMENTO"):SetAutoSize(.F.)
	oSection1:Cell("NASCIMENTO"):SetSize(9)
	
	TRCell():New(oSection1,"NOME_MAE" 			,"BA1",,,,,,,,,,,,,,,,,,,,)
	oSection1:Cell("NOME_MAE"):SetAutoSize(.F.)
	oSection1:Cell("NOME_MAE"):SetSize(40)
	
	TRCell():New(oSection1,"CODOPDEST" 	,"BA1",,,,,,,,,,,,,,,,,,,,)
	oSection1:Cell("CODOPDEST"):SetAutoSize(.F.)
	oSection1:Cell("CODOPDEST"):SetSize(10)
	
	TRCell():New(oSection1,"OPERDEST" 		,"BA1",,,,,,,,,,,,,,,,,,,,)
	oSection1:Cell("OPERDEST"):SetAutoSize(.F.)
	oSection1:Cell("OPERDEST"):SetSize(30)
	
	TRCell():New(oSection1,"ESTADO" 		,"BA1",,,,,,,,,,,,,,,,,,,,)
	oSection1:Cell("ESTADO"):SetAutoSize(.F.)
	oSection1:Cell("ESTADO"):SetSize(7)
	
	TRCell():New(oSection1,"DAT_IN_INT" 	,"BA1",,,,,,,,,,,,,,,,,,,,)
	oSection1:Cell("DAT_IN_INT"):SetAutoSize(.F.)
	oSection1:Cell("DAT_IN_INT"):SetSize(9)
	
	TRCell():New(oSection1,"BLQ_INTEGR" 	,"BA1",,,,,,,,,,,,,,,,,,,,)
	oSection1:Cell("BLQ_INTEGR"):SetAutoSize(.F.)
	oSection1:Cell("BLQ_INTEGR"):SetSize(9)
	
	TRCell():New(oSection1,"DAT_IN_CAB" 	,"BA1",,,,,,,,,,,,,,,,,,,,)
	oSection1:Cell("DAT_IN_CAB"):SetAutoSize(.F.)
	oSection1:Cell("DAT_IN_CAB"):SetSize(9)
	
	TRCell():New(oSection1,"BLQ_CABERJ" 	,"BA1",,,,,,,,,,,,,,,,,,,,)
	oSection1:Cell("BLQ_CABERJ"):SetAutoSize(.F.)
	oSection1:Cell("BLQ_CABERJ"):SetSize(9)
	
	//--------------------------
	//Se็ใo do Totalizador
	//--------------------------
	oSection2 := TRSection():New(oSection1,"","BA1")
	
	TRCell():New(oSection2,"TOTAL" 			,"BA1",							,,30				 )
	
Return oReport

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCABR194B  บAutor  ณAngelo Henrique     บ Data ณ  17/08/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRotina para montar a query e trazer as informa็๕es no       บฑฑ
ฑฑบ          ณrelat๓rio.                                                  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CABERJ                                                     บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function CABR194B(oReport,_cAlias1)
	
	Local _aArea 		:= GetArea()
	Local oSection1 	:= oReport:Section(1)
	Local oSection2	:= oReport:Section(1):Section(1)
	Local _cQuery		:= ""
	Local _cAlias1	:= GetNextAlias()
	Local _nCont		:= 0
	
	_cQuery := " SELECT 																								" + cEnt
	_cQuery += " 	BA1I.BA1_CODINT||BA1I.BA1_CODEMP||BA1I.BA1_MATRIC||BA1I.BA1_TIPREG||BA1I.BA1_DIGITO  MAT_INTEGRAL, 	" + cEnt
	_cQuery += " 	BA1I.BA1_CONEMP CONTRATO, 																			" + cEnt
	_cQuery += " 	TRIM(BT5I.BT5_NOME) NOME_CONT,																		" + cEnt
	_cQuery += " 	BA1I.BA1_SUBCON SUBCONT, 																			" + cEnt
	_cQuery += " 	TRIM(BQCI.BQC_NREDUZ) NOME_SUB,																		" + cEnt
	_cQuery += " 	BA1I.BA1_YMTREP MAT_REPASSE, 																		" + cEnt
	_cQuery += " 	BA1I.BA1_CODEMP EMPRESA, 																			" + cEnt
	_cQuery += " 	BG9I.BG9_DESCRI DESC_EMP, 																		 	" + cEnt
	_cQuery += " 	BA1I.BA1_CODPLA PLANO, 																				" + cEnt
	_cQuery += " 	BA1I.BA1_NOMUSR NOME, 																				" + cEnt
	_cQuery += " 	BA1I.BA1_DATINC DAT_IN_INT, 																		" + cEnt
	_cQuery += " 	BA1I.BA1_DATBLO BLQ_INTEGR, 																		" + cEnt
	
	//_cQuery += " 	IDADE(TO_DATE(BA1I.BA1_DATNAS,'YYYYMMDD'),SYSDATE) IDADE, 											" + cEnt
	
	_cQuery += " 	FORMATA_DATA_MS(BA1C.BA1_DATNAS) NASCIMENTO, 														" + cEnt
	_cQuery += " 	BI3I.BI3_DESCRI DESC_PLANO, 																		" + cEnt
	_cQuery += " 	BA1I.BA1_CPFUSR CPF, 																				" + cEnt
	_cQuery += " 	BA1I.BA1_MAE NOME_MAE, 																				" + cEnt
	_cQuery += " 	BA1C.BA1_CODINT||BA1C.BA1_CODEMP||BA1C.BA1_MATRIC||BA1C.BA1_TIPREG||BA1C.BA1_DIGITO  MAT_CABERJ, 	" + cEnt
	_cQuery += " 	BA1C.BA1_OPEDES CODOPDEST, 																			" + cEnt
	_cQuery += " 	BA1C.BA1_DATINC DAT_IN_CAB, 																		" + cEnt
	_cQuery += " 	BA1C.BA1_DATBLO BLQ_CABERJ, 																		" + cEnt
	_cQuery += " 	BA0C.BA0_NOMINT OPERDEST, 																			" + cEnt
	_cQuery += " 	BA0C.BA0_EST ESTADO 																				" + cEnt
	_cQuery += " FROM 																									" + cEnt
	_cQuery += " 	BA1020 BA1I, 																						" + cEnt
	_cQuery += " 	" + RetSqlName("BG9") + " BG9I, 																	" + cEnt  
	_cQuery += " 	" + RetSqlName("BI3") + " BI3I, 																	" + cEnt 
	_cQuery += " 	BA1010 BA1C, 																						" + cEnt
	_cQuery += " 	BA0010 BA0C,  																						" + cEnt
	_cQuery += "	BT5020 BT5I, 																						" + cEnt
	_cQuery +=  "	BQC020 BQCI   																						" + cEnt
	_cQuery += " WHERE 																									" + cEnt
	_cQuery += " 	BA1I.BA1_FILIAL = '" + xFilial("BA1") + "' 															" + cEnt
	_cQuery += " 	AND SUBSTR(BA1I.BA1_YMTREP, 1,4) = BA1C.BA1_CODINT 													" + cEnt
	_cQuery += " 	AND SUBSTR(BA1I.BA1_YMTREP, 5,4) = BA1C.BA1_CODEMP 													" + cEnt
	_cQuery += " 	AND SUBSTR(BA1I.BA1_YMTREP, 9,6) = BA1C.BA1_MATRIC 													" + cEnt
	_cQuery += " 	AND SUBSTR(BA1I.BA1_YMTREP,15,2) = BA1C.BA1_TIPREG 													" + cEnt
	_cQuery += " 	AND BG9I.BG9_FILIAL = '" + xFilial("BG9") + "'  													" + cEnt
	_cQuery += " 	AND BA1I.BA1_CODEMP = BG9I.BG9_CODIGO 		  														" + cEnt
	_cQuery += " 	AND BA1I.BA1_CODPLA = BI3I.BI3_CODIGO   															" + cEnt
	_cQuery += " 	AND BA0C.BA0_FILIAL = '" + xFilial("BA0") + "'   													" + cEnt
	_cQuery += " 	AND BT5I.BT5_FILIAL = '" + xFilial("BT5") + "' 														" + cEnt
	_cQuery += " 	AND BQCI.BQC_FILIAL = '" + xFilial("BQC") + "' 														" + cEnt
	_cQuery += " 	AND SUBSTR(BA1C.BA1_OPEDES,1,1) = BA0C.BA0_CODIDE   												" + cEnt
	_cQuery += " 	AND SUBSTR(BA1C.BA1_OPEDES,2,3) = BA0C.BA0_CODINT   												" + cEnt
	_cQuery += " 	AND BT5I.BT5_CODINT = BA1I.BA1_CODINT 																" + cEnt
	_cQuery += " 	AND BT5I.BT5_CODIGO = BA1I.BA1_CODEMP 																" + cEnt
	_cQuery += " 	AND BT5I.BT5_NUMCON = BA1I.BA1_CONEMP 																" + cEnt
	_cQuery += " 	AND BT5I.BT5_VERSAO = BA1I.BA1_VERCON 																" + cEnt
	_cQuery += " 	AND BQCI.BQC_CODIGO = BA1I.BA1_CODINT||BA1I.BA1_CODEMP 												" + cEnt
	_cQuery += " 	AND BQCI.BQC_NUMCON = BA1I.BA1_CONEMP 																" + cEnt
	_cQuery += " 	AND BQCI.BQC_VERCON = BA1I.BA1_VERCON 																" + cEnt
	_cQuery += " 	AND BQCI.BQC_SUBCON = BA1I.BA1_SUBCON 																" + cEnt
	_cQuery += " 	AND BQCI.BQC_VERSUB = BA1I.BA1_VERSUB 																" + cEnt
	_cQuery += " 	AND BA1C.D_E_L_E_T_ = ' ' 																			" + cEnt
	_cQuery += " 	AND BA1I.D_E_L_E_T_ = ' ' 																			" + cEnt
	_cQuery += " 	AND BG9I.D_E_L_E_T_ = ' ' 																			" + cEnt
	_cQuery += " 	AND BI3I.D_E_L_E_T_ = ' ' 																			" + cEnt
	_cQuery += " 	AND BA0C.D_E_L_E_T_ = ' ' 																			" + cEnt
	_cQuery += " 	AND BT5I.D_E_L_E_T_ = ' ' 																			" + cEnt
	_cQuery += " 	AND BQCI.D_E_L_E_T_ = ' ' 																			" + cEnt
	_cQuery += " 	AND BA1C.BA1_FILIAL = ' ' 																			" + cEnt
	_cQuery += " 	AND BI3I.BI3_FILIAL = ' ' 																			" + cEnt
	
	//REMOVIDO CONFORME CHAMADO 50915
	//_cQuery += " AND BA1I.BA1_YMTREP <> ' ' "
	
	//Empresa
	If !(Empty(MV_PAR01)) .OR. !(Empty(MV_PAR02))
		
		_cQuery += "AND BA1I.BA1_CODEMP BETWEEN '" + MV_PAR01 + "' AND '" + MV_PAR02 + "' 								" + cEnt
		
	EndIf
	
	//Data de Inclusใo
	If !(Empty(MV_PAR03)) .OR. !(Empty(MV_PAR04))
		
		_cQuery += " AND BA1I.BA1_DATINC BETWEEN '" + DTOS(MV_PAR03) + "' AND '" + DTOS(MV_PAR04) + "'					" + cEnt			
		
	EndIf
	
	//Operadora
	If !(Empty(MV_PAR05)) .OR. !(Empty(MV_PAR06))
		
		_cQuery += " AND BA1C.BA1_OPEDES BETWEEN '" + MV_PAR05 + "' AND '" + MV_PAR06 + "' 								" + cEnt
		
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
		
		oSection1:Cell("MAT_INTEGRAL"):SetValue((_cAlias1)->MAT_INTEGRAL			)		
		oSection1:Cell("CONTRATO"	 ):SetValue((_cAlias1)->CONTRATO				)
		oSection1:Cell("NOME_CONT"	 ):SetValue((_cAlias1)->NOME_CONT				)
		oSection1:Cell("SUBCONT"	 ):SetValue((_cAlias1)->SUBCONT					)
		oSection1:Cell("NOME_SUB"	 ):SetValue((_cAlias1)->NOME_SUB				)				
		oSection1:Cell("MAT_CABERJ"	 ):SetValue((_cAlias1)->MAT_CABERJ				)
		oSection1:Cell("MAT_REPASSE" ):SetValue((_cAlias1)->MAT_REPASSE				)
		oSection1:Cell("EMPRESA"	 ):SetValue((_cAlias1)->EMPRESA					)
		oSection1:Cell("DESC_EMP"	 ):SetValue((_cAlias1)->DESC_EMP				)
		oSection1:Cell("PLANO"		 ):SetValue((_cAlias1)->PLANO					)
		oSection1:Cell("DESC_PLANO"	 ):SetValue((_cAlias1)->DESC_PLANO				)
		oSection1:Cell("NOME"		 ):SetValue((_cAlias1)->NOME					)
		oSection1:Cell("CPF"		 ):SetValue((_cAlias1)->CPF						)
		
		//MATEUS MEDEIROS CHAMADO: 45218  14/12/2017 - INICIO
		//oSection1:Cell("IDADE"		 ):SetValue(cvaltochar((_cAlias1)->IDADE)	)
		oSection1:Cell("NASCIMENTO"	 ):SetValue((_cAlias1)->NASCIMENTO				)
		//FIM
		
		oSection1:Cell("NOME_MAE"	 ):SetValue((_cAlias1)->NOME_MAE				)
		oSection1:Cell("CODOPDEST"	 ):SetValue((_cAlias1)->CODOPDEST				)
		oSection1:Cell("OPERDEST"	 ):SetValue((_cAlias1)->OPERDEST				)
		oSection1:Cell("ESTADO"		 ):SetValue((_cAlias1)->ESTADO					)
		oSection1:Cell("DAT_IN_INT"	 ):SetValue(DTOC(STOD((_cAlias1)->DAT_IN_INT))	)
		oSection1:Cell("BLQ_INTEGR"	 ):SetValue(DTOC(STOD((_cAlias1)->BLQ_INTEGR))	)
		oSection1:Cell("DAT_IN_CAB"	 ):SetValue(DTOC(STOD((_cAlias1)->DAT_IN_CAB))	)
		oSection1:Cell("BLQ_CABERJ"	 ):SetValue(DTOC(STOD((_cAlias1)->BLQ_CABERJ))	)
		
		_nCont ++
		
		oSection1:PrintLine()
		
		(_cAlias1)->(DbSkip())
		
	EndDo
	
	oSection2:Init()
	oSection2:SetHeaderSection(.T.)
	
	oSection2:Cell("TOTAL"	):SetValue(_nCont	)
	
	oSection2:PrintLine()
	
	oSection2:Finish()
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
ฑฑบPrograma  ณCABR194C  บAutor  ณAngelo Henrique     บ Data ณ  17/08/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRotina responsavel pela gera็ใo das perguntas no relat๓rio  บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CABERJ                                                     บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function CABR194C(cGrpPerg)
	
	Local aHelpPor := {} //help da pergunta
	
	
	aHelpPor := {}
	AADD(aHelpPor,"Indique a Empresa  			")
	AADD(aHelpPor,"De/Ate a ser utilizado.		")
	
	PutSx1(cGrpPerg,"01","Empresa De ? "		,"a","a","MV_CH1"	,"C",TamSX3("BA3_CODEMP")[1]	,0,0,"G","","B7APLS"	,"","","MV_PAR01","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")
	PutSx1(cGrpPerg,"02","Empresa Ate ?"		,"a","a","MV_CH2"	,"C",TamSX3("BA3_CODEMP")[1]	,0,0,"G","","B7APLS"	,"","","MV_PAR02","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")
	
	aHelpPor := {}
	AADD(aHelpPor,"Indique a Data de Inclusใo ")
	AADD(aHelpPor,"De/Ate a ser utilizado.		")
	
	PutSx1(cGrpPerg,"03","Data De ? "			,"a","a","MV_CH3"	,"D",TamSX3("BA1_DATINC")[1]	,0,0,"G","",""		,"","","MV_PAR03","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")
	PutSx1(cGrpPerg,"04","Data Ate ?"			,"a","a","MV_CH4"	,"D",TamSX3("BA1_DATINC")[1]	,0,0,"G","",""		,"","","MV_PAR04","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")
	
	aHelpPor := {}
	AADD(aHelpPor,"Operadora 					")
	AADD(aHelpPor,"De/Ate a ser utilizado.		")
	
	PutSx1(cGrpPerg,"05","Operadora De ? "		,"a","a","MV_CH5"	,"C",TamSX3("BA0_CODINT")[1]	,0,0,"G","","BA0COD"	,"","","MV_PAR05","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")
	PutSx1(cGrpPerg,"06","Operadora Ate ?"		,"a","a","MV_CH6"	,"C",TamSX3("BA0_CODINT")[1]	,0,0,"G","","BA0COD"	,"","","MV_PAR06","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")
	
Return