#INCLUDE "REPORT.CH"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "TOPCONN.CH"
#INCLUDE "RWMAKE.CH"
#INCLUDE "TBICONN.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCABR216     บAutor  ณAngelo Henrique   บ Data ณ  10/05/16   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRelat๓rio de Protocolo de Atendimento - Hist๓rico Padrใo x  บฑฑ
ฑฑบ          ณTipo de Servi็os                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CABERJ                                                     บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function CABR216()
	
	Local _aArea 		:= GetArea()
	Local oReport		:= Nil
	Private _cPerg	:= "CABR216"
	
	//Cria grupo de perguntas
	//CABR216C(_cPerg)
	
	//If Pergunte(_cPerg,.T.)
	
	oReport := CABR216A()	
	oReport:PrintDialog()
	
	//EndIf
	
	RestArea(_aArea)
	
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCABR216A  บAutor  ณAngelo Henrique     บ Data ณ  17/08/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRotina que irแ gerar as informa็๕es do relat๓rio            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CABERJ                                                     บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function CABR216A
	
	Local oReport		:= Nil
	Local oSection1 	:= Nil
	
	oReport := TReport():New("CABR216","Controle de PA Pendentes",_cPerg,{|oReport| CABR216B(oReport)},"Controle de PA Pendentes")
			
	oReport:SetLandScape()
	
	oReport:oPage:setPaperSize(9)
	
	oSection1 := TRSection():New(oReport,"SZX")
	
	TRCell():New(oSection1,"COD_CANAL"	,"SZX") //01 -- CODIGO DO CANAL
	oSection1:Cell("COD_CANAL"):SetAutoSize(.F.)
	oSection1:Cell("COD_CANAL"):SetSize(10)
	
	TRCell():New(oSection1,"DESC_CANAL","SZX") //02 -- DESCRIวรO DO CANAL
	oSection1:Cell("DESC_CANAL"):SetAutoSize(.F.)
	oSection1:Cell("DESC_CANAL"):SetSize(30)
	
	TRCell():New(oSection1,"COD_PORTA"	,"SZX") //03 -- CODIGO DA PORTA DE ENTRADA
	oSection1:Cell("COD_PORTA"):SetAutoSize(.F.)
	oSection1:Cell("COD_PORTA"):SetSize(10)
	
	TRCell():New(oSection1,"DESC_PORTA","SZX") //04 -- DESCRIวรO DA PORTA DE ENTRADA
	oSection1:Cell("DESC_PORTA"):SetAutoSize(.F.)
	oSection1:Cell("DESC_PORTA"):SetSize(40)
	
	TRCell():New(oSection1,"COD_AREA"	,"SZX") //05 -- CODIGO DA AREA
	oSection1:Cell("COD_AREA"):SetAutoSize(.F.)
	oSection1:Cell("COD_AREA"):SetSize(10)
	
	TRCell():New(oSection1,"DESC_AREA"	,"SZX") //06 -- DESCRIวรO DA AREA
	oSection1:Cell("DESC_AREA"):SetAutoSize(.F.)
	oSection1:Cell("DESC_AREA"):SetSize(30)
	
	TRCell():New(oSection1,"EXPIRA_24"	,"SZX") //07 -- EXPIRA 24
	oSection1:Cell("EXPIRA_24"):SetAutoSize(.F.)
	oSection1:Cell("EXPIRA_24"):SetSize(60)
	
	TRCell():New(oSection1,"FORA_1"		,"SZX") //08 -- PA FORA DO PRAZO 1 DIA
	oSection1:Cell("FORA_1"):SetAutoSize(.F.)
	oSection1:Cell("FORA_1"):SetSize(10)
	
	TRCell():New(oSection1,"FORA_2"		,"SZX") //09 -- PA FORA DO PRAZO 2 DIAS
	oSection1:Cell("FORA_2"):SetAutoSize(.F.)
	oSection1:Cell("FORA_2"):SetSize(10)
	
	TRCell():New(oSection1,"MAIOR_2"	,"SZX") //10 -- PA FORA DO PRAZO MAIS QUE 2 DIAS
	oSection1:Cell("MAIOR_2"):SetAutoSize(.F.)
	oSection1:Cell("MAIOR_2"):SetSize(10)	
	
Return oReport

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCABR216B  บAutor  ณAngelo Henrique     บ Data ณ  17/08/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRotina para montar a query e trazer as informa็๕es no       บฑฑ
ฑฑบ          ณrelat๓rio.                                                  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CABERJ                                                     บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function CABR216B(oReport)
	
	Local _aArea 			:= GetArea()
	Local _cCanal			:= ""
	Local _cPort			:= ""
	Local _cArea			:= ""
	
	Private oSection1 	:= oReport:Section(1)	
	Private _cQuery		:= ""
	Private _cAlias1		:= GetNextAlias()
	
	
	_cQuery := " SELECT  													" + CRLF
	_cQuery += " 	SZX.ZX_CANAL CDCANA	, TRIM(PCB.PCB_DESCRI) DSCANA, 	" + CRLF
	_cQuery += " 	SZX.ZX_PTENT CDPORT	, TRIM(PCA.PCA_DESCRI) DSPORT, 	" + CRLF
	_cQuery += " 	SZX.ZX_CODAREA CDAREA, TRIM(PCF.PCF_DESCRI) DSAREA, 	" + CRLF
	_cQuery += " 	( 															" + CRLF
	_cQuery += " 		SELECT  												" + CRLF
	_cQuery += " 			COUNT(ZX_24.ZX_SEQ) 								" + CRLF
	_cQuery += " 		FROM  													" + CRLF
	_cQuery += " 		" + RetSqlName("SZX") + " ZX_24 					" + CRLF
	_cQuery += " 		WHERE 													" + CRLF
	_cQuery += " 			ZX_24.D_E_L_E_T_ = ' ' 							" + CRLF
	_cQuery += " 			AND ZX_24.ZX_TPINTEL = '1' 						" + CRLF
	_cQuery += " 			AND ZX_24.ZX_CANAL = SZX.ZX_CANAL 				" + CRLF
	_cQuery += " 			AND ZX_24.ZX_PTENT = SZX.ZX_PTENT 				" + CRLF
	_cQuery += " 			AND ZX_24.ZX_CODAREA = SZX.ZX_CODAREA 			" + CRLF
	_cQuery += " 			AND TO_DATE(ZX_24.ZX_DATDE,'YYYYMMDD') + ZX_24.ZX_SLA <= TRUNC(SYSDATE) " + CRLF
	_cQuery += " 	) EXPIRA_24, 												" + CRLF
	_cQuery += " 	( 															" + CRLF
	_cQuery += " 		SELECT 												" + CRLF
	_cQuery += " 			COUNT(ZX_1.ZX_SEQ)								" + CRLF
	_cQuery += " 		FROM 													" + CRLF
	_cQuery += " 		" + RetSqlName("SZX") + " ZX_1						" + CRLF
	_cQuery += " 		WHERE 													" + CRLF
	_cQuery += " 			ZX_1.D_E_L_E_T_ = ' ' 							" + CRLF
	_cQuery += " 			AND ZX_1.ZX_TPINTEL = '1' 						" + CRLF
	_cQuery += " 			AND ZX_1.ZX_CANAL = SZX.ZX_CANAL 				" + CRLF
	_cQuery += " 			AND ZX_1.ZX_PTENT = SZX.ZX_PTENT 				" + CRLF
	_cQuery += " 			AND ZX_1.ZX_CODAREA = SZX.ZX_CODAREA 			" + CRLF
	_cQuery += " 			AND (TO_DATE(ZX_1.ZX_DATDE,'YYYYMMDD') + ZX_1.ZX_SLA) - TRUNC(SYSDATE) = 1 " + CRLF
	_cQuery += " 	)FORA_1, 													" + CRLF
	_cQuery += " 	( 															" + CRLF
	_cQuery += " 		SELECT 												" + CRLF
	_cQuery += " 			COUNT(ZX_2.ZX_SEQ)								" + CRLF
	_cQuery += " 		FROM 													" + CRLF
	_cQuery += " 		" + RetSqlName("SZX") + " ZX_2						" + CRLF
	_cQuery += " 		WHERE 													" + CRLF
	_cQuery += " 			ZX_2.D_E_L_E_T_ = ' ' 							" + CRLF
	_cQuery += " 			AND ZX_2.ZX_TPINTEL = '1' 						" + CRLF
	_cQuery += " 			AND ZX_2.ZX_CANAL = SZX.ZX_CANAL 				" + CRLF
	_cQuery += " 			AND ZX_2.ZX_PTENT = SZX.ZX_PTENT 				" + CRLF
	_cQuery += " 			AND ZX_2.ZX_CODAREA = SZX.ZX_CODAREA 			" + CRLF
	_cQuery += " 			AND (TO_DATE(ZX_2.ZX_DATDE,'YYYYMMDD') + ZX_2.ZX_SLA) - TRUNC(SYSDATE) = 2 " + CRLF
	_cQuery += " 	)FORA_2, 													" + CRLF
	_cQuery += " 	( 															" + CRLF
	_cQuery += " 		SELECT 												" + CRLF
	_cQuery += " 			COUNT(ZX_M.ZX_SEQ) 								" + CRLF
	_cQuery += " 		FROM 													" + CRLF
	_cQuery += " 		" + RetSqlName("SZX") + " ZX_M						" + CRLF
	_cQuery += " 		WHERE 													" + CRLF
	_cQuery += " 			ZX_M.D_E_L_E_T_ = ' ' 							" + CRLF
	_cQuery += " 			AND ZX_M.ZX_TPINTEL = '1' 						" + CRLF
	_cQuery += " 			AND ZX_M.ZX_CANAL = SZX.ZX_CANAL 				" + CRLF
	_cQuery += " 			AND ZX_M.ZX_PTENT = SZX.ZX_PTENT 				" + CRLF
	_cQuery += " 			AND ZX_M.ZX_CODAREA = SZX.ZX_CODAREA			" + CRLF
	_cQuery += " 			AND (TO_DATE(ZX_M.ZX_DATDE,'YYYYMMDD') + ZX_M.ZX_SLA) - TRUNC(SYSDATE) > 2  " + CRLF
	_cQuery += " 	)MAIOR_2 													" + CRLF
	_cQuery += " FROM  														" + CRLF
	_cQuery += "" + RetSqlName("SZX") + " SZX,							" + CRLF
	_cQuery += "" + RetSqlName("PCB") + " PCB,							" + CRLF
	_cQuery += "" + RetSqlName("PCA") + " PCA,							" + CRLF
	_cQuery += "" + RetSqlName("PCF") + " PCF								" + CRLF
	_cQuery += " WHERE  														" + CRLF
	_cQuery += " SZX.D_E_L_E_T_ = ' ' 										" + CRLF
	_cQuery += " AND PCB.D_E_L_E_T_ = ' ' 									" + CRLF
	_cQuery += " AND PCA.D_E_L_E_T_ = ' ' 									" + CRLF
	_cQuery += " AND PCF.D_E_L_E_T_ = ' ' 									" + CRLF
	_cQuery += " AND SZX.ZX_TPINTEL = '1' 									" + CRLF
	_cQuery += " AND SZX.ZX_CANAL <> ' '  									" + CRLF
	_cQuery += " AND SZX.ZX_PTENT <> ' ' 									" + CRLF
	_cQuery += " AND SZX.ZX_CODAREA <> ' ' 								" + CRLF
	_cQuery += " AND SZX.ZX_CANAL = PCB.PCB_COD 							" + CRLF
	_cQuery += " AND SZX.ZX_PTENT = PCA.PCA_COD 							" + CRLF
	_cQuery += " AND SZX.ZX_CODAREA = PCF.PCF_COD 						" + CRLF
	_cQuery += " GROUP BY  													" + CRLF
	_cQuery += " SZX.ZX_CANAL, SZX.ZX_PTENT, SZX.ZX_CODAREA, PCB.PCB_DESCRI, PCA.PCA_DESCRI, 		" + CRLF
	_cQuery += " PCF.PCF_DESCRI, TRIM(PCB.PCB_DESCRI), TRIM(PCA.PCA_DESCRI), TRIM(PCF.PCF_DESCRI) 	" + CRLF
	_cQuery += " ORDER BY 													" + CRLF
	_cQuery += " SZX.ZX_CANAL, SZX.ZX_PTENT, SZX.ZX_CODAREA 			" + CRLF
	
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
		
		oSection1:Cell("COD_CANAL"	):SetValue( (_cAlias1)->CDCANA		) //01 -- CODIGO DE SERVIวO
		oSection1:Cell("DESC_CANAL"	):SetValue( (_cAlias1)->DSCANA		) //02 -- DESCRICAO DO SERVIวO
		
		oSection1:Cell("COD_PORTA"	):SetValue( (_cAlias1)->CDPORT		) //03 -- CODIGO DA PORTA DE ENTRADA
		oSection1:Cell("DESC_PORTA"	):SetValue( (_cAlias1)->DSPORT		) //04 -- DESCRICAO DA PORTA DE ENTRADA				
			
		oSection1:Cell("COD_AREA"	):SetValue( (_cAlias1)->CDAREA		) //05 -- CODIGO DA AREA
		oSection1:Cell("DESC_AREA"	):SetValue( (_cAlias1)->DSAREA		) //06 -- DESCRICAO DA AREA
		
		oSection1:Cell("EXPIRA_24"	):SetValue( (_cAlias1)->EXPIRA_24	) //07 -- EXPIRA_24
		
		oSection1:Cell("FORA_1"		):SetValue( (_cAlias1)->FORA_1		) //08 -- PA FORA DO PRAZO 1 DIA
		
		oSection1:Cell("FORA_2"		):SetValue( (_cAlias1)->FORA_2		) //09 -- PA FORA DO PRAZO 2 DIAS
		
		oSection1:Cell("MAIOR_2"		):SetValue( (_cAlias1)->MAIOR_2		) //10 -- PA FORA DO PRAZO MAIS QUE 2 DIAS
		
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
ฑฑบPrograma  ณCABR216C  บAutor  ณAngelo Henrique     บ Data ณ  17/08/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRotina responsavel pela gera็ใo das perguntas no relat๓rio  บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CABERJ                                                     บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function CABR216C(cGrpPerg)
	
	Local aHelpPor := {} //help da pergunta
	
	aHelpPor := {}
	AADD(aHelpPor,"Informe o tipo de  			")
	AADD(aHelpPor,"Servi็o De/Ate				")
	AADD(aHelpPor,"Branco para todos			")
	
	PutSx1(cGrpPerg,"01","Servi็o De: ?"	,"a","a","MV_CH1"	,"C",TamSX3("PCE_TIPOSV")[1]	,0,0,"G","","PBLPA1","","","MV_PAR01","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")
	PutSx1(cGrpPerg,"02","Servi็o Ate: ?"	,"a","a","MV_CH2"	,"C",TamSX3("PCE_TIPOSV")[1]	,0,0,"G","","PBLPA1","","","MV_PAR02","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")
	
	aHelpPor := {}
	AADD(aHelpPor,"Informe o Historico 		")
	AADD(aHelpPor,"Padrใo						")
	AADD(aHelpPor,"Branco para todos	    	")
	
	PutSx1(cGrpPerg,"03","Historico De:"	,"a","a","MV_CH3"	,"C",TamSX3("PCE_CDHIST")[1]	,0,0,"G","","PCDPA1","","","MV_PAR03","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")
	PutSx1(cGrpPerg,"04","Historico At้:"	,"a","a","MV_CH4"	,"C",TamSX3("PCE_CDHIST")[1]	,0,0,"G","","PCDPA1","","","MV_PAR04","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")
	
Return

