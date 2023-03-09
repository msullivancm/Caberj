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
ฑฑบPrograma  ณCABR193     บAutor  ณAngelo Henrique   บ Data ณ  17/08/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRelat๓rio de Movimenta็ใo de Repassados - CABERJ.           บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CABERJ                                                     บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿ 18/12/19 AJUSTE DA REGRA DE ATIVOS PARA ALINHAR COM OS RELATORIOS DE      ฿                                                            
฿  CARTEIRA EVCART /PIRETI                                                  ฿
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function CABR193()
	
	Local _aArea 	:= GetArea()
	Local oReport	:= Nil
	
	Private _cPerg	:= "CABR193"
	
	//Cria grupo de perguntas
	CABR193C(_cPerg)
	
	If Pergunte(_cPerg,.T.)
		
		oReport := CABR193A()
		oReport:PrintDialog()
		
	EndIf
	
	RestArea(_aArea)
	
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCABR193A  บAutor  ณAngelo Henrique     บ Data ณ  17/08/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRotina que irแ gerar as informa็๕es do relat๓rio            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CABERJ                                                     บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function CABR193A
	
	Local oReport		:= Nil
	Local oSection1 	:= Nil
	Local oSection2 	:= Nil
	Local _cAlias1	:= GetNextAlias()
	
	oReport := TReport():New("CABR193","Mov. Repassados - Caberj",_cPerg,{|oReport| CABR193B(oReport)},"Mov. Repassados - Caberj")
	
	//Impressใo formato paisagem
	oReport:SetLandScape()
	
	oSection1 := TRSection():New(oReport,"Mov. Repassados - Caberj","BA1")
	
	TRCell():New(oSection1,"MAT_CABERJ" 	,"BA1",							,,,,,,,,,,,,,,,,,,,)
	oSection1:Cell("MAT_CABERJ"):SetAutoSize(.F.)
	oSection1:Cell("MAT_CABERJ"):SetSize(18)
	
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
	
	TRCell():New(oSection1,"MAT_REPASSE" 	,"BA1",							,,,,,,,,,,,,,,,,,,,)
	oSection1:Cell("MAT_REPASSE"):SetAutoSize(.F.)
	oSection1:Cell("MAT_REPASSE"):SetSize(20)
	
	TRCell():New(oSection1,"EMPRESA" 		,"BA1",							,,,,,,,,,,,,,,,,,,,)
	oSection1:Cell("EMPRESA"):SetAutoSize(.F.)
	oSection1:Cell("EMPRESA"):SetSize(7)
	
	TRCell():New(oSection1,"DESC_EMP" 		,"BG9",							,,,,,,,,,,,,,,,,,,,)
	oSection1:Cell("DESC_EMP"):SetAutoSize(.F.)
	oSection1:Cell("DESC_EMP"):SetSize(30)
	
	TRCell():New(oSection1,"PLANO" 			,"BA1",							,,,,,,,,,,,,,,,,,,,)
	oSection1:Cell("PLANO"):SetAutoSize(.F.)
	oSection1:Cell("PLANO"):SetSize(6)
	
	TRCell():New(oSection1,"DESC_PLANO"	,"BI3",								,,,,,,,,,,,,,,,,,,,)
	oSection1:Cell("DESC_PLANO"):SetAutoSize(.F.)
	oSection1:Cell("DESC_PLANO"):SetSize(23)
	
	TRCell():New(oSection1,"NOME" 			,"BA1",							,,,,,,,,,,,,,,,,,,,)
	oSection1:Cell("NOME"):SetAutoSize(.F.)
	oSection1:Cell("NOME"):SetSize(40)
	
	TRCell():New(oSection1,"CPF" 			,"BA1",							,,,,,,,,,,,,,,,,,,,)
	oSection1:Cell("CPF"):SetAutoSize(.F.)
	oSection1:Cell("CPF"):SetSize(13)
	/*
	//MATEUS MEDEIROS CHAMADO: 45218 14/12/2017 - INICIO
	TRCell():New(oSection1,"IDADE" 			,"BA1",							,,,,,,,,,,,,,,,,,,,)
	oSection1:Cell("IDADE"):SetAutoSize(.F.)
	oSection1:Cell("IDADE"):SetSize(9)
	// FIM
	*/
	TRCell():New(oSection1,"NASCIMENTO"		,"BA1",							,,,,,,,,,,,,,,,,,,,)
	oSection1:Cell("NASCIMENTO"):SetAutoSize(.F.)
	oSection1:Cell("NASCIMENTO"):SetSize(9)
	
	TRCell():New(oSection1,"NOME_MAE"		,"BA1",							,,,,,,,,,,,,,,,,,,,)
	oSection1:Cell("NOME_MAE"):SetAutoSize(.F.)
	oSection1:Cell("NOME_MAE"):SetSize(40)
	
	TRCell():New(oSection1,"CODOPORIG"		,"BA1",							,,,,,,,,,,,,,,,,,,,)
	oSection1:Cell("CODOPORIG"):SetAutoSize(.F.)
	oSection1:Cell("CODOPORIG"):SetSize(10)
	
	TRCell():New(oSection1,"OPERORIG" 		,"BA1",							,,,,,,,,,,,,,,,,,,,)
	oSection1:Cell("OPERORIG"):SetAutoSize(.F.)
	oSection1:Cell("OPERORIG"):SetSize(30)		
	
	TRCell():New(oSection1,"CODOPDEST"		,"BA1",							,,,,,,,,,,,,,,,,,,,)
	oSection1:Cell("CODOPDEST"):SetAutoSize(.F.)
	oSection1:Cell("CODOPDEST"):SetSize(10)
	
	TRCell():New(oSection1,"OPERDEST" 		,"BA1",							,,,,,,,,,,,,,,,,,,,)
	oSection1:Cell("OPERDEST"):SetAutoSize(.F.)
	oSection1:Cell("OPERDEST"):SetSize(30)
	
	TRCell():New(oSection1,"ESTADO" 		,"BA0",							,,,,,,,,,,,,,,,,,,,)
	oSection1:Cell("ESTADO"):SetAutoSize(.F.)
	oSection1:Cell("ESTADO"):SetSize(7)
	
	TRCell():New(oSection1,"DATA_INC" 		,"BA1",							,,,,,,,,,,,,,,,,,,,)
	oSection1:Cell("DATA_INC"):SetAutoSize(.F.)
	oSection1:Cell("DATA_INC"):SetSize(10)
	
	TRCell():New(oSection1,"BLOQUEIO" 		,"BA1",							,,,,,,,,,,,,,,,,,,,)
	oSection1:Cell("BLOQUEIO"):SetAutoSize(.F.)
	oSection1:Cell("BLOQUEIO"):SetSize(10)
	
	//SERGIO CUNHA CHAMADO: 44665 14/11/2017 - INICIO
	TRCell():New(oSection1,"MUNICIPIO" 		,"BA1",							,,,,,,,,,,,,,,,,,,,)
	oSection1:Cell("MUNICIPIO"):SetAutoSize(.F.)
	oSection1:Cell("MUNICIPIO"):SetSize(20)
	
	TRCell():New(oSection1,"EST_BENEF" 		,"BA1",							,,,,,,,,,,,,,,,,,,,)
	oSection1:Cell("EST_BENEF"):SetAutoSize(.F.)
	oSection1:Cell("EST_BENEF"):SetSize(10)
	
	TRCell():New(oSection1,"CNS_BENEF" 		,"BTS",							,,,,,,,,,,,,,,,,,,,)
	oSection1:Cell("CNS_BENEF"):SetAutoSize(.F.)
	oSection1:Cell("CNS_BENEF"):SetSize(30)
	
	//SERGIO CUNHA CHAMADO: 44665 14/11/2017 - FIM
	//--------------------------
	//Se็ใo do Totalizador
	//--------------------------
	oSection2 := TRSection():New(oSection1,"","BA1")
	
	TRCell():New(oSection2,"TOTAL" 			,"BA1",							,,30			    )
	
	
	
Return oReport

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCABR193B  บAutor  ณAngelo Henrique     บ Data ณ  17/08/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRotina para montar a query e trazer as informa็๕es no       บฑฑ
ฑฑบ          ณrelat๓rio.                                                  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CABERJ                                                     บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function CABR193B(oReport,_cAlias1)
	
	Local _aArea 		:= GetArea()
	Local oSection1 	:= oReport:Section(1)
	Local oSection2		:= oReport:Section(1):Section(1)
	Local _cQuery		:= ""
	Local _cAlias1		:= GetNextAlias()
	Local _nCont		:= 0
	
	//Alterando o tamanho da pแgina para caber todos os campos
	oReport:oPage:setPaperSize(29)
	
	_cQuery := " SELECT 																							" + cEnt
	_cQuery += " BA1C.BA1_CODINT||BA1C.BA1_CODEMP||BA1C.BA1_MATRIC||BA1C.BA1_TIPREG||BA1C.BA1_DIGITO  MAT_CABERJ, 	" + cEnt
	_cQuery += " BA1C.BA1_CONEMP CONTRATO, 																			" + cEnt
	_cQuery += " TRIM(BT5C.BT5_NOME) NOME_CONT,																		" + cEnt
	_cQuery += " BA1C.BA1_SUBCON SUBCONT, 																			" + cEnt
	_cQuery += " TRIM(BQCC.BQC_NREDUZ) NOME_SUB,																	" + cEnt
	_cQuery += " BA1C.BA1_YMTREP MAT_REPASSE, 																		" + cEnt
	_cQuery += " BA1C.BA1_CODEMP EMPRESA, 																			" + cEnt
	_cQuery += " BG9C.BG9_DESCRI DESC_EMP, 																			" + cEnt
	_cQuery += " BA1C.BA1_CODPLA PLANO, 																			" + cEnt
	_cQuery += " BI3C.BI3_DESCRI DESC_PLANO, 																		" + cEnt
	_cQuery += " BA1C.BA1_NOMUSR NOME, 																				" + cEnt
	_cQuery += " BA1C.BA1_CPFUSR CPF, 																				" + cEnt
	_cQuery += " BA1C.BA1_MAE NOME_MAE, 																			" + cEnt
	_cQuery += " BA1C.BA1_OPEORI CODOPORI,																			" + cEnt
	_cQuery += " (																									" + cEnt
	_cQuery += " 	SELECT																							" + cEnt			
	_cQuery += " 		BA0DS.BA0_NOMINT																			" + cEnt
	_cQuery += " 	FROM																							" + cEnt
	_cQuery += "	" + RetSqlName("BA0") + " BA0DS  																" + cEnt	
	_cQuery += " 	WHERE																							" + cEnt								
	_cQuery += " 		BA0DS.BA0_CODIDE||BA0DS.BA0_CODINT = BA1C.BA1_OPEORI										" + cEnt
	_cQuery += " 		AND BA0DS.D_E_L_E_T_ = ' '																	" + cEnt
	_cQuery += " ) OPERORIG,																						" + cEnt								
	_cQuery += " BA1C.BA1_OPEDES CODOPDEST, 																		" + cEnt
	_cQuery += " BA0C.BA0_NOMINT OPERDEST, 																			" + cEnt
	_cQuery += " BA0C.BA0_EST ESTADO, 																				" + cEnt
	_cQuery += " BA1C.BA1_DATINC DATA_INC, 																			" + cEnt
	_cQuery += " BA1C.BA1_DATBLO BLOQUEIO, 																			" + cEnt
	_cQuery += " BA1C.BA1_MUNICI MUNICIPIO, 																		" + cEnt
	_cQuery += " BA1C.BA1_ESTADO EST_BENEF, 																		" + cEnt
	
	//MATEUS MEDEIROS CHAMADO: GLPI - 45218 14/12/2017 - INICIO
	//_cQuery += " IDADE(TO_DATE(BA1C.BA1_DATNAS,'YYYYMMDD'),SYSDATE) IDADE, 											" + cEnt
	//_cQuery += " FORMATA_DATA_MS(BA1C.BA1_DATNAS) NASCIMENTO, 														" + cEnt
	_cQuery += " BA1C.BA1_DATNAS NASCIMENTO, 																		" + cEnt
	_cQuery += " BTSC.BTS_NRCRNA CNS 																				" + cEnt
	//FIM CHAMADO: GLPI - 45218 14/12/2017 - INICIO
	
	_cQuery += " FROM 																								" + cEnt
	_cQuery += "	" + RetSqlName("BA1") + " BA1C , 																" + cEnt
	_cQuery += "	" + RetSqlName("BA0") + " BA0C , 																" + cEnt
	_cQuery += "	" + RetSqlName("BG9") + " BG9C , 																" + cEnt
	_cQuery += "	" + RetSqlName("BI3") + " BI3C , 																" + cEnt
	_cQuery += "	" + RetSqlName("BTS") + " BTSC , 																" + cEnt
	_cQuery += "	" + RetSqlName("BT5") + " BT5C , 																" + cEnt
	_cQuery +=  "	" + RetSqlName("BQC") + " BQCC   																" + cEnt
	_cQuery += " WHERE 																								" + cEnt
	_cQuery += " BA0C.BA0_CODIDE||BA0C.BA0_CODINT = BA1C.BA1_OPEDES 												" + cEnt
	_cQuery += " AND BG9C.BG9_CODIGO = BA1C.BA1_CODEMP 																" + cEnt
	_cQuery += " AND BI3C.BI3_CODIGO = BA1C.BA1_CODPLA 																" + cEnt
	_cQuery += " AND BTSC.BTS_MATVID = BA1C.BA1_MATVID 																" + cEnt
	_cQuery += " AND BA1C.D_E_L_E_T_ = ' ' 																			" + cEnt
	_cQuery += " AND BA0C.D_E_L_E_T_ = ' ' 																			" + cEnt
	_cQuery += " AND BG9C.D_E_L_E_T_ = ' ' 																			" + cEnt
	_cQuery += " AND BI3C.D_E_L_E_T_ = ' ' 																			" + cEnt
	_cQuery += " AND BTSC.D_E_L_E_T_ = ' ' 																			" + cEnt
	_cQuery += " AND BT5C.D_E_L_E_T_ = ' ' 																			" + cEnt
	_cQuery += " AND BQCC.D_E_L_E_T_ = ' ' 																			" + cEnt
	_cQuery += " AND BA1C.BA1_FILIAL = '" + xFilial("BA1") + "' 													" + cEnt
	_cQuery += " AND BA0C.BA0_FILIAL = '" + xFilial("BA0") + "' 													" + cEnt
	_cQuery += " AND BG9C.BG9_FILIAL = '" + xFilial("BG9") + "' 													" + cEnt
	_cQuery += " AND BI3C.BI3_FILIAL = '" + xFilial("BI3") + "' 													" + cEnt
	_cQuery += " AND BTSC.BTS_FILIAL = '" + xFilial("BTS") + "' 													" + cEnt
	_cQuery += " AND BT5C.BT5_FILIAL = '" + xFilial("BT5") + "' 													" + cEnt
	_cQuery += " AND BQCC.BQC_FILIAL = '" + xFilial("BQC") + "' 													" + cEnt
	//Motta tratar ativos no m๊s 18/12/19
	//_cQuery += " AND BA1C.BA1_DATBLO = ' ' 																		" + cEnt
	_cQuery += " AND VERIFBLOQANS_MS(BA1_CODINT,                                                                    " + cEnt
	_cQuery += "                     BA1_CODEMP,                                                                    " + cEnt
	_cQuery += "                     BA1_MATRIC,                                                                    " + cEnt
	_cQuery += "                     BA1_TIPREG,'" + DTOS(MV_PAR04) + "','" + IIF(cEmpAnt=="01", "C","I")+ "')=0    " + cEnt
	//Fim tratar ativos no m๊s 18/12/19
    _cQuery += " AND BT5C.BT5_CODINT = BA1C.BA1_CODINT 																" + cEnt
	_cQuery += " AND BT5C.BT5_CODIGO = BA1C.BA1_CODEMP 																" + cEnt
	_cQuery += " AND BT5C.BT5_NUMCON = BA1C.BA1_CONEMP 																" + cEnt
	_cQuery += " AND BT5C.BT5_VERSAO = BA1C.BA1_VERCON 																" + cEnt
	_cQuery += " AND BQCC.BQC_CODIGO = BA1C.BA1_CODINT||BA1C.BA1_CODEMP 											" + cEnt
	_cQuery += " AND BQCC.BQC_NUMCON = BA1C.BA1_CONEMP 																" + cEnt
	_cQuery += " AND BQCC.BQC_VERCON = BA1C.BA1_VERCON 																" + cEnt
	_cQuery += " AND BQCC.BQC_SUBCON = BA1C.BA1_SUBCON 																" + cEnt
	_cQuery += " AND BQCC.BQC_VERSUB = BA1C.BA1_VERSUB 																" + cEnt
	
	//REMOVIDO CONFORME CHAMADO 50915
	//_cQuery += " AND BA1C.BA1_YMTREP 	<> ' ' "
	
	//Empresa
	If !(Empty(MV_PAR01)) .OR. !(Empty(MV_PAR02))
		
		_cQuery += "AND BA1C.BA1_CODEMP BETWEEN '" + MV_PAR01 + "' AND '" + MV_PAR02 + "' 							" + cEnt
		
	EndIf
	
	//Data de Inclusใo
	If !(Empty(MV_PAR03)) .OR. !(Empty(MV_PAR04))
		
		_cQuery += " AND BA1C.BA1_DATINC BETWEEN '" + DTOS(MV_PAR03) + "' AND '" + DTOS(MV_PAR04) + "' 				" + cEnt
		
	EndIf
	
	//Operadora Destino
	If !(Empty(MV_PAR05)) .OR. !(Empty(MV_PAR06))
		
		_cQuery += " AND BA1C.BA1_OPEDES BETWEEN '" + MV_PAR05 + "' AND '" + MV_PAR06 + "' 							" + cEnt
		
	EndIf
	
	//Operadora Origem
	If !(Empty(MV_PAR07)) .OR. !(Empty(MV_PAR08))
		
		_cQuery += " AND BA1C.BA1_OPEORI BETWEEN '" + MV_PAR07 + "' AND '" + MV_PAR08 + "' 							" + cEnt
		
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
		
		oSection1:Cell("MAT_CABERJ"	):SetValue((_cAlias1)->MAT_CABERJ				)
		oSection1:Cell("MAT_REPASSE"):SetValue((_cAlias1)->MAT_REPASSE				)
		oSection1:Cell("EMPRESA"	):SetValue((_cAlias1)->EMPRESA					)
		oSection1:Cell("DESC_EMP"	):SetValue((_cAlias1)->DESC_EMP					)
		oSection1:Cell("CONTRATO"	):SetValue((_cAlias1)->CONTRATO					)
		oSection1:Cell("NOME_CONT"	):SetValue((_cAlias1)->NOME_CONT				)
		oSection1:Cell("SUBCONT"	):SetValue((_cAlias1)->SUBCONT					)
		oSection1:Cell("NOME_SUB"	):SetValue((_cAlias1)->NOME_SUB					)
		oSection1:Cell("PLANO"		):SetValue((_cAlias1)->PLANO					)
		oSection1:Cell("DESC_PLANO"	):SetValue((_cAlias1)->DESC_PLANO				)
		oSection1:Cell("NOME"		):SetValue((_cAlias1)->NOME						)
		oSection1:Cell("CPF"		):SetValue((_cAlias1)->CPF						)
		
		//MATEUS MEDEIROS CHAMADO: 45218  14/12/2017 - INICIO
		//oSection1:Cell("IDADE"		):SetValue(cvaltochar((_cAlias1)->IDADE)  	)
		oSection1:Cell("NASCIMENTO"	):SetValue(DTOC(STOD((_cAlias1)->NASCIMENTO))	)
		// FIM CHAMADO 45218
		
		oSection1:Cell("NOME_MAE"	):SetValue((_cAlias1)->NOME_MAE					)
		oSection1:Cell("CODOPORIG"	):SetValue((_cAlias1)->CODOPORI					)
		oSection1:Cell("OPERORIG"	):SetValue((_cAlias1)->OPERORIG					)
		oSection1:Cell("CODOPDEST"	):SetValue((_cAlias1)->CODOPDEST				)
		oSection1:Cell("OPERDEST"	):SetValue((_cAlias1)->OPERDEST					)
		oSection1:Cell("ESTADO"		):SetValue((_cAlias1)->ESTADO					)
		oSection1:Cell("DATA_INC"	):SetValue(DTOC(STOD((_cAlias1)->DATA_INC))		)
		oSection1:Cell("BLOQUEIO"	):SetValue(DTOC(STOD((_cAlias1)->BLOQUEIO))		)
		
		//SERGIO CUNHA CHAMADO: 44665 14/11/2017 - INICIO
		oSection1:Cell("MUNICIPIO"	):SetValue((_cAlias1)->MUNICIPIO				)
		oSection1:Cell("EST_BENEF"	):SetValue((_cAlias1)->EST_BENEF				)
		//SERGIO CUNHA CHAMADO: 44665 14/11/2017 - FIM
		
		oSection1:Cell("CNS_BENEF"	):SetValue((_cAlias1)->CNS						)
		
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
ฑฑบPrograma  ณCABR193C  บAutor  ณAngelo Henrique     บ Data ณ  17/08/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRotina responsavel pela gera็ใo das perguntas no relat๓rio  บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CABERJ                                                     บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function CABR193C(cGrpPerg)
	
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
	AADD(aHelpPor,"Operadora Destino			")
	AADD(aHelpPor,"De/Ate a ser utilizado.		")
	
	PutSx1(cGrpPerg,"05","Operadora Destino De ? "		,"a","a","MV_CH5"	,"C", 4							,0,0,"G","","BA0COD"	,"","","MV_PAR05","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")
	PutSx1(cGrpPerg,"06","Operadora Destino Ate ?"		,"a","a","MV_CH6"	,"C", 4							,0,0,"G","","BA0COD"	,"","","MV_PAR06","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")
	
	aHelpPor := {}
	AADD(aHelpPor,"Operadora Origem				")
	AADD(aHelpPor,"De/Ate a ser utilizado.		")
	
	PutSx1(cGrpPerg,"07","Operadora Origem De ? "		,"a","a","MV_CH7"	,"C", 4							,0,0,"G","","BA0COD"	,"","","MV_PAR07","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")
	PutSx1(cGrpPerg,"08","Operadora Origem Ate ?"		,"a","a","MV_CH8"	,"C", 4							,0,0,"G","","BA0COD"	,"","","MV_PAR08","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")
	
Return
