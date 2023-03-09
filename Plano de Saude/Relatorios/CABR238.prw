#INCLUDE "REPORT.CH"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "TOPCONN.CH"
#INCLUDE "RWMAKE.CH"
#INCLUDE "TBICONN.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCABR238     บAutor  ณAngelo Henrique   บ Data ณ  22/05/17   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRelat๓rio de LOTES DE CARTEIRAS.                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CABERJ                                                     บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

user function CABR238()

	Local _aArea 		:= GetArea()
	Local oReport		:= Nil
	Private _cPerg		:= "CABR238"

	//Cria grupo de perguntas
	CABR238C(_cPerg)

	If Pergunte(_cPerg,.T.)

		oReport := CABR238A()	
		oReport:PrintDialog()

	EndIf

	RestArea(_aArea)

return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCABR238A  บAutor  ณAngelo Henrique     บ Data ณ  22/05/17   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRotina que irแ gerar as informa็๕es do relat๓rio            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CABERJ                                                     บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function CABR238A

	Local oReport		:= Nil
	Local oSection1 	:= Nil

	oReport := TReport():New("CABR238","Lotes de Carteiras",_cPerg,{|oReport| CABR238B(oReport)},"Lote de Carteiras")

	oReport:SetLandScape()

	oReport:oPage:setPaperSize(9)

	oSection1 := TRSection():New(oReport,"BED")

	TRCell():New(oSection1,"LOTE"			,"BDE") //01 -- LOTE
	oSection1:Cell("LOTE"):SetAutoSize(.F.)
	oSection1:Cell("LOTE"):SetSize(14)

	TRCell():New(oSection1,"MOTIVO"			,"BDE") //02 -- MOTIVA
	oSection1:Cell("MOTIVO"):SetAutoSize(.F.)
	oSection1:Cell("MOTIVO"):SetSize(08)

	TRCell():New(oSection1,"DESC_MOTIVO"	,"BPX") //03 -- DESCRIวรO DO MOTIVO
	oSection1:Cell("DESC_MOTIVO"):SetAutoSize(.F.)
	oSection1:Cell("DESC_MOTIVO"):SetSize(40)

	TRCell():New(oSection1,"EMPRESA"		,"BED") //04 -- EMPRESA
	oSection1:Cell("EMPRESA"):SetAutoSize(.F.)
	oSection1:Cell("EMPRESA"):SetSize(08)

	TRCell():New(oSection1,"DESC_EMPRESA"	,"BG9") //05 -- DESCRIวรO DA EMPRESA
	oSection1:Cell("DESC_EMPRESA"):SetAutoSize(.F.)
	oSection1:Cell("DESC_EMPRESA"):SetSize(10)

	TRCell():New(oSection1,"MATRICULA"		,"BED") //06 -- MATRICULA
	oSection1:Cell("MATRICULA"):SetAutoSize(.F.)
	oSection1:Cell("MATRICULA"):SetSize(30)

	TRCell():New(oSection1,"CONTRATO"		,"BA1") //07 -- CONTRATO
	oSection1:Cell("CONTRATO"):SetAutoSize(.F.)
	oSection1:Cell("CONTRATO"):SetSize(15)

	TRCell():New(oSection1,"SUB_CONTRATO"	,"BA1") //08 -- SUBCONTRATO
	oSection1:Cell("SUB_CONTRATO"):SetAutoSize(.F.)
	oSection1:Cell("SUB_CONTRATO"):SetSize(15)

	TRCell():New(oSection1,"VIA_CARTEIRA"	,"BED") //09 -- VIA CARTEIRA
	oSection1:Cell("VIA_CARTEIRA"):SetAutoSize(.F.)
	oSection1:Cell("VIA_CARTEIRA"):SetSize(14)

	TRCell():New(oSection1,"NOME"			,"BA1") //10 -- NOME
	oSection1:Cell("NOME"):SetAutoSize(.F.)
	oSection1:Cell("NOME"):SetSize(60)

	TRCell():New(oSection1,"DT_SOLICITACAO"	,"BED") //11 -- DATA DE SOLCIITAวรO DO LOTE
	oSection1:Cell("DT_SOLICITACAO"):SetAutoSize(.F.)
	oSection1:Cell("DT_SOLICITACAO"):SetSize(14)	

	TRCell():New(oSection1,"DT_VALIDADE"	,"BED") //12 -- DATA DE VALIDADE
	oSection1:Cell("DT_VALIDADE"):SetAutoSize(.F.)
	oSection1:Cell("DT_VALIDADE"):SetSize(14)		

Return oReport

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCABR238B  บAutor  ณAngelo Henrique     บ Data ณ  17/08/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRotina para montar a query e trazer as informa็๕es no       บฑฑ
ฑฑบ          ณrelat๓rio.                                                  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CABERJ                                                     บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function CABR238B(oReport)

	Local _aArea 		:= GetArea()
	Local _aArBPX		:= BPX->(GetArea()) 

	Private oSection1 	:= oReport:Section(1)	
	Private _cQuery		:= ""
	Private _cAlias1	:= GetNextAlias()

	_cQuery := " SELECT " + CRLF
	_cQuery += " 	BDE.BDE_CODIGO LOTE, 	" + CRLF
	_cQuery += " 	BDE.BDE_MOTIVO MOTIVO,  " + CRLF
	_cQuery += " 	BDE.BDE_CODINT CODINT, 	" + CRLF
	_cQuery += " 	BED.BED_CODEMP EMPRESA, " + CRLF
	_cQuery += " 	TRIM(BG9.BG9_DESCRI) DESC_EMPRESA, " + CRLF
	_cQuery += " 	BED.BED_CODINT||BED.BED_CODEMP||BED.BED_MATRIC||BED.BED_TIPREG||BED.BED_DIGITO MATRICULA, " + CRLF
	_cQuery += " 	BA1.BA1_CONEMP CONTRATO, 	 " + CRLF
	_cQuery += " 	BA1.BA1_SUBCON SUB_CONTRATO, " + CRLF
	_cQuery += " 	BED.BED_VIACAR VIA_CARTEIRA, " + CRLF
	_cQuery += " 	TRIM(BED.BED_NOMUSR) NOME, 	 " + CRLF
	_cQuery += " 	SIGA.FORMATA_DATA_MS(BED.BED_DTSOLI) DT_SOLICITACAO, " + CRLF
	_cQuery += " 	SIGA.FORMATA_DATA_MS(BED.BED_DATVAL) DT_VALIDADE 	 " + CRLF
	_cQuery += " FROM  " + CRLF
	_cQuery += " 	" + RetSqlName("BDE") + " BDE " + CRLF
	_cQuery += " 	INNER JOIN  " + RetSqlName("BED") + " BED " + CRLF
	_cQuery += " 	ON BED.D_E_L_E_T_ = ' ' " + CRLF
	_cQuery += " 		AND BED.BED_FILIAL = '" + xFilial("BED") + "' " + CRLF
	_cQuery += " 		AND BED.BED_CODINT = BDE.BDE_CODINT " + CRLF
	_cQuery += " 		AND BED.BED_CDIDEN = BDE.BDE_CODIGO " + CRLF
	_cQuery += " 	INNER JOIN " + RetSqlName("BG9") + " BG9 " + CRLF
	_cQuery += " 	ON BG9.D_E_L_E_T_ = ' ' " + CRLF
	_cQuery += " 		AND BG9.BG9_FILIAL = '" + xFilial("BG9") + "' " + CRLF
	_cQuery += " 		AND BG9.BG9_CODINT = BED.BED_CODINT " + CRLF
	_cQuery += " 		AND BG9.BG9_CODIGO = BED.BED_CODEMP " + CRLF
	_cQuery += " 	INNER JOIN " + RetSqlName("BA1") + " BA1 " + CRLF
	_cQuery += " 	ON BA1.D_E_L_E_T_ = ' ' " + CRLF
	_cQuery += " 		AND BA1.BA1_FILIAL = '" + xFilial("BA1") + "' " + CRLF
	_cQuery += " 		AND BA1.BA1_CODINT = BED.BED_CODINT " + CRLF
	_cQuery += " 		AND BA1.BA1_CODEMP = BED.BED_CODEMP " + CRLF
	_cQuery += " 		AND BA1.BA1_MATRIC = BED.BED_MATRIC " + CRLF
	_cQuery += " 		AND BA1.BA1_TIPREG = BED.BED_TIPREG " + CRLF
	_cQuery += " 		AND BA1.BA1_DIGITO = BED.BED_DIGITO " + CRLF      
	_cQuery += " WHERE  " + CRLF
	_cQuery += " 	BDE.D_E_L_E_T_ = ' ' " + CRLF
	_cQuery += " 	AND BDE.BDE_FILIAL = '" + xFilial("BDE") + "' " + CRLF
	_cQuery += " 	AND BDE.BDE_CODIGO = '" + MV_PAR01 + "' " + CRLF

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

		oSection1:Cell("LOTE"	):SetValue( (_cAlias1)->LOTE					) //01 -- LOTE

		oSection1:Cell("MOTIVO"	):SetValue( (_cAlias1)->MOTIVO					) //02 -- MOTIVO

		If !Empty((_cAlias1)->MOTIVO)

			DbSelectArea("BPX")
			DbSetOrder(1)
			If DbSeek(xFilial("BPX") + (_cAlias1)->CODINT + (_cAlias1)->MOTIVO)

				oSection1:Cell("DESC_MOTIVO"):SetValue( BPX->BPX_DESCRI			) //03 -- DESCRIวรO DO MOTIVO

			Endif

		Else

		EndIf

		oSection1:Cell("EMPRESA"		):SetValue( (_cAlias1)->EMPRESA			) //04 -- EMPRESA	

		oSection1:Cell("DESC_EMPRESA"	):SetValue( (_cAlias1)->DESC_EMPRESA	) //05 -- DESCRIวรO DA EMPRESA

		oSection1:Cell("MATRICULA"		):SetValue( (_cAlias1)->MATRICULA		) //06 -- MATRICULA

		oSection1:Cell("CONTRATO"		):SetValue( (_cAlias1)->CONTRATO		) //07 -- CONTRATO

		oSection1:Cell("SUB_CONTRATO"	):SetValue( (_cAlias1)->SUB_CONTRATO	) //08 -- SUB_CONTRATO

		oSection1:Cell("VIA_CARTEIRA"	):SetValue( (_cAlias1)->VIA_CARTEIRA	) //09 -- VIA CARTEIRA

		oSection1:Cell("NOME"			):SetValue( (_cAlias1)->NOME			) //10 -- NOME

		oSection1:Cell("DT_SOLICITACAO"	):SetValue( (_cAlias1)->DT_SOLICITACAO	) //11 -- DATA DA SOLICITAวรO

		oSection1:Cell("DT_VALIDADE"	):SetValue( (_cAlias1)->DT_VALIDADE		) //12 -- DATA DE VALIDADE

		oSection1:PrintLine()

		(_cAlias1)->(DbSkip())

	EndDo

	oSection1:Finish()

	If Select(_cAlias1) > 0
		(_cAlias1)->(DbCloseArea())
	EndIf

	RestArea(_aArBPX)
	RestArea(_aArea	)

Return(.T.)


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCABR238C  บAutor  ณAngelo Henrique     บ Data ณ  17/08/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRotina responsavel pela gera็ใo das perguntas no relat๓rio  บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CABERJ                                                     บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function CABR238C(cGrpPerg)

	Local aHelpPor := {} //help da pergunta

	aHelpPor := {}
	AADD(aHelpPor,"Informe o lote de carteira	")	

	PutSx1(cGrpPerg,"01","Lote: ?"			,"a","a","MV_CH1"	,"C",TamSX3("BED_CDIDEN")[1]	,0,0,"G","","BEDPLS","","","MV_PAR01","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")

Return

