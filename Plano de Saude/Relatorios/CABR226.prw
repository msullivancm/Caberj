#INCLUDE "REPORT.CH"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "TOPCONN.CH"

#DEFINE c_ent CHR(13) + CHR(10)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABR226   ºAutor  ³Angelo Henrique     º Data ³  11/01/16   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Relatório utilizado para exibir os beneficiários que tiveramº±±
±±º          ³movimentação em 2 meses, 2 matriculas.                      º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CABERJ                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function CABR226()

	Local _aArea 		:= GetArea() 

	Local oReport		:= Nil

	Private _cPerg	:= "CABR226"

	//Cria grupo de perguntas
	CABR226A(_cPerg)

	If Pergunte(_cPerg,.T.)

		oReport := CABR226B()
		oReport:PrintDialog()

	EndIf

	RestArea(_aArea)

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABR226A    ºAutor  ³Angelo Henrique   º Data ³  05/01/16   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Relatório de beneficiários para liberação de geração de     º±±
±±º          ³carteira.                                                   º±±
±±º          ³ -----  Perguntas do Relatório -------------------          º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CABERJ                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function CABR226A(cGrpPerg)

	Local aHelpPor := {} //help da pergunta

	aHelpPor := {}
	AADD(aHelpPor,"Informe a operadora				")

	PutSx1(cGrpPerg,"01","Operadora: ?"	,"a","a","MV_CH1"	,"C",TamSX3("BA1_CODINT")[1]		,0,0,"G","","B89PLS"	,"","","MV_PAR01","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")

	aHelpPor := {}
	AADD(aHelpPor,"Indique a Empresa				")
	AADD(aHelpPor,"                        		")

	PutSx1(cGrpPerg,"02","Empresa: ? "		,"a","a","MV_CH2"	,"C",TamSX3("BA1_CODEMP")[1]	,0,0,"G","","B7APLS"	,"","","MV_PAR02","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")

	aHelpPor := {}
	AADD(aHelpPor,"Indique a Data de Inclusão 	")
	AADD(aHelpPor,"De/Ate a ser utilizado.			")
	AADD(aHelpPor,"Informar apenas meses próximos	")
	AADD(aHelpPor,"Ex: Janeiro/Fevereiro         	")
	AADD(aHelpPor,"Ex: Agosto/Setembro           	")

	PutSx1(cGrpPerg,"03","Data De ? "		,"a","a","MV_CH3"	,"D",TamSX3("BA1_DATINC")[1]	,0,0,"G","",""			,"","","MV_PAR03","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")
	PutSx1(cGrpPerg,"04","Data Ate ?"		,"a","a","MV_CH4"	,"D",TamSX3("BA1_DATINC")[1]	,0,0,"G","",""			,"","","MV_PAR04","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")

Return



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABR226B    ºAutor  ³Angelo Henrique   º Data ³  05/01/16   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Relatório de beneficiários para liberação de geração de     º±±
±±º          ³carteira.                                                   º±±
±±º          ³ -----  Gerando as colunas para o relatório -------------   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CABERJ                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function CABR226B

	Local oReport		:= Nil
	Local oSection1 	:= Nil

	oReport := TReport():New("CABR226","Duas Matriculas no Mês",_cPerg,{|oReport| CABR226C(oReport)},"Duas Matriculas no Mês")

	//Impressão formato paisagem
	oReport:SetLandScape()

	oSection1 := TRSection():New(oReport,"Duas Matriculas no Mês","BA1")

	TRCell():New(oSection1,"MATRICULA"			,"BA1",,,,,,,,,,,,,,,,,,,,)
	oSection1:Cell("MATRICULA"):SetAutoSize(.F.)
	oSection1:Cell("MATRICULA"):SetSize(20)

	TRCell():New(oSection1,"INCLUSAO" 			,"BA1",,,,,,,,,,,,,,,,,,,,)
	oSection1:Cell("INCLUSAO"):SetAutoSize(.F.)
	oSection1:Cell("INCLUSAO"):SetSize(12)

	TRCell():New(oSection1,"NOME"				,"BA1",,,,,,,,,,,,,,,,,,,,)
	oSection1:Cell("NOME"):SetAutoSize(.F.)
	oSection1:Cell("NOME"):SetSize(50)

	TRCell():New(oSection1,"CPF" 				,"BA1",,,,,,,,,,,,,,,,,,,,)
	oSection1:Cell("CPF"):SetAutoSize(.F.)
	oSection1:Cell("CPF"):SetSize(20)

	TRCell():New(oSection1,"PLANO"				,"BA1",,,,,,,,,,,,,,,,,,,,)
	oSection1:Cell("PLANO"):SetAutoSize(.F.)
	oSection1:Cell("PLANO"):SetSize(10)

	TRCell():New(oSection1,"DESC_PLANO"		,"BA1",,,,,,,,,,,,,,,,,,,,)
	oSection1:Cell("DESC_PLANO"):SetAutoSize(.F.)
	oSection1:Cell("DESC_PLANO"):SetSize(30)

	TRCell():New(oSection1,"DT_BLOQ"			,"BA1",,,,,,,,,,,,,,,,,,,,)
	oSection1:Cell("DT_BLOQ"):SetAutoSize(.F.)
	oSection1:Cell("DT_BLOQ"):SetSize(30)

	TRCell():New(oSection1,"MOTIVO_BLOQ"		,"BA1",,,,,,,,,,,,,,,,,,,,)
	oSection1:Cell("MOTIVO_BLOQ"):SetAutoSize(.F.)
	oSection1:Cell("MOTIVO_BLOQ"):SetSize(30)

	TRCell():New(oSection1,"MATRIC_NV"			,"BA1",,,,,,,,,,,,,,,,,,,,)
	oSection1:Cell("MATRIC_NV"):SetAutoSize(.F.)
	oSection1:Cell("MATRIC_NV"):SetSize(30)

	TRCell():New(oSection1,"DT_INC_MATRIC_NV"	,"BA1",,,,,,,,,,,,,,,,,,,,)
	oSection1:Cell("DT_INC_MATRIC_NV"):SetAutoSize(.F.)
	oSection1:Cell("DT_INC_MATRIC_NV"):SetSize(30)

	TRCell():New(oSection1,"PLANO_NV"			,"BA1",,,,,,,,,,,,,,,,,,,,)
	oSection1:Cell("PLANO_NV"):SetAutoSize(.F.)
	oSection1:Cell("PLANO_NV"):SetSize(30)

	TRCell():New(oSection1,"MOT_BLOQ_NV"		,"BA1",,,,,,,,,,,,,,,,,,,,)
	oSection1:Cell("MOT_BLOQ_NV"):SetAutoSize(.F.)
	oSection1:Cell("MOT_BLOQ_NV"):SetSize(30)

	TRCell():New(oSection1,"DESC_PLANO_NV"		,"BA1",,,,,,,,,,,,,,,,,,,,)
	oSection1:Cell("DESC_PLANO_NV"):SetAutoSize(.F.)
	oSection1:Cell("DESC_PLANO_NV"):SetSize(30)

	TRCell():New(oSection1,"DT_BLOQ_NV"		,"BA1",,,,,,,,,,,,,,,,,,,,)
	oSection1:Cell("DT_BLOQ_NV"):SetAutoSize(.F.)
	oSection1:Cell("DT_BLOQ_NV"):SetSize(30)

Return oReport


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABR226A    ºAutor  ³Angelo Henrique   º Data ³  05/01/16   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Relatório de beneficiários para liberação de geração de     º±±
±±º          ³carteira.                                                   º±±
±±º          ³ -----  Gerando as informações para o relatório ---------   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CABERJ                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function CABR226C(oReport)

	Local _aArea 		:= GetArea()
	Local oSection1 	:= oReport:Section(1)
	Local oSection2		:= oReport:Section(1):Section(1)
	Local _cQuery		:= ""
	Local _cAlias1		:= GetNextAlias()

	//Alterando o tamanho da página para caber todos os campos
	oReport:oPage:setPaperSize(29)

	_cQuery := " SELECT " 	+ CRLF	
	_cQuery += " 	BA1.BA1_CODINT||BA1.BA1_CODEMP||BA1.BA1_MATRIC||BA1.BA1_TIPREG||BA1.BA1_DIGITO MATRIC_BLQ, " 	+ CRLF
	_cQuery += " 	NVL(TO_CHAR(TO_DATE(TRIM(BA1.BA1_DATINC),'YYYYMMDD'),'DD/MM/YYYY'),' ') DT_INC, " 	+ CRLF
	_cQuery += " 	TRIM(BA1.BA1_NOMUSR) NOME, BA1.BA1_CPFUSR CPF, BA1.BA1_CODPLA PLANO, TRIM(BI3.BI3_DESCRI) DESC_PLANO, " 	+ CRLF  
	_cQuery += " 	NVL(TO_CHAR(TO_DATE(TRIM(BA1.BA1_DATBLO),'YYYYMMDD'),'DD/MM/YYYY'),' ') DT_BLOQ, " 	+ CRLF
	_cQuery += " 	BA3.BA3_MOTBLO MOT_BLOQ, " 	+ CRLF
	_cQuery += " 	NVL(BLQ.BA1_CODINT||BLQ.BA1_CODEMP||BLQ.BA1_MATRIC||BLQ.BA1_TIPREG||BLQ.BA1_DIGITO, ' ') MATRIC_NOVA, " 	+ CRLF
	_cQuery += " 	NVL(TO_CHAR(TO_DATE(TRIM(BLQ.BA1_DATINC),'YYYYMMDD'),'DD/MM/YYYY'),' ') DT_INC_NV, " 	+ CRLF
	_cQuery += " 	BLQ.BA1_CODPLA PLANO_NV, " 	+ CRLF
	_cQuery += " 	BLQ.BA1_MOTBLO MT_BLQ_NV, " 	+ CRLF
	_cQuery += " 	( " 	+ CRLF
	_cQuery += " 		SELECT" 	+ CRLF 
	_cQuery += " 			TRIM(BI3.BI3_DESCRI) DESC_PLANO " 	+ CRLF
	_cQuery += " 		FROM " 	+ CRLF 
	_cQuery += " 			" + RetSqlName("BI3") + " BI3 " 	+ CRLF
	_cQuery += " 		WHERE " 	+ CRLF 
	_cQuery += " 			BI3.D_E_L_E_T_ = ' ' " 	+ CRLF
	_cQuery += " 			AND BI3.BI3_FILIAL = '" + xFilial("BI3") + "' " 	+ CRLF
	_cQuery += " 			AND BI3.BI3_CODIGO = BLQ.BA1_CODPLA " 	+ CRLF
	_cQuery += " 			AND BI3.BI3_CODINT = BLQ.BA1_CODINT " 	+ CRLF
	_cQuery += " 	) DSC_PL_NV," 	+ CRLF
	_cQuery += " 	NVL(TO_CHAR(TO_DATE(TRIM(BLQ.BA1_DATBLO),'YYYYMMDD'),'DD/MM/YYYY'),' ') DT_BLQ_NV" 	+ CRLF
	_cQuery += " FROM " + RetSqlName("BA1") + " BA1 " 	+ CRLF
	_cQuery += " 	INNER JOIN " + RetSqlName("BA3") + " BA3 " 	+ CRLF
	_cQuery += " 		ON BA3.BA3_FILIAL = '" + xFilial("BA3") + "' " 	+ CRLF
	_cQuery += " 		AND BA3.BA3_CODINT = BA1.BA1_CODINT " 	+ CRLF
	_cQuery += " 		AND BA3.BA3_CODEMP = BA1.BA1_CODEMP " 	+ CRLF
	_cQuery += " 		AND BA3.BA3_MATRIC = BA1.BA1_MATRIC " 	+ CRLF
	_cQuery += " 		AND BA3.D_E_L_E_T_ = ' '" 	+ CRLF         
	_cQuery += " 	INNER JOIN " + RetSqlName("BI3") + " BI3 " 	+ CRLF
	_cQuery += " 		ON BI3.BI3_FILIAL = '" + xFilial("BI3") + "' " 	+ CRLF
	_cQuery += " 		AND BI3.BI3_CODINT = BA1.BA1_CODINT " 	+ CRLF
	_cQuery += " 		AND BI3.BI3_CODIGO = BA1.BA1_CODPLA " 	+ CRLF    
	_cQuery += " 		AND BI3.D_E_L_E_T_ = ' ' " 	+ CRLF  
	_cQuery += " 	INNER JOIN " + RetSqlName("BA1") + " BLQ " 	+ CRLF
	_cQuery += " 		ON BLQ.D_E_L_E_T_ = ' ' " 	+ CRLF
	_cQuery += " 		AND BLQ.BA1_FILIAL = '" + xFilial("BA1") + "' " 	+ CRLF
	_cQuery += " 		AND BLQ.BA1_CPFUSR = BA1.BA1_CPFUSR " 	+ CRLF
	_cQuery += " 		AND BLQ.BA1_CODEMP = BA1.BA1_CODEMP " 	+ CRLF                  
	_cQuery += " 		AND BLQ.BA1_MATRIC > BA1.BA1_MATRIC " 	+ CRLF
	_cQuery += " 		AND BLQ.BA1_DATINC = BA1.BA1_DATINC " 	+ CRLF
	_cQuery += " 		AND BLQ.BA1_DATBLO = ' ' 			" 	+ CRLF

	//-------------------------------------
	//Prefeitura remover os odontologicos
	//-------------------------------------
	If MV_PAR02 = "0024"

		_cQuery += " 		AND BLQ.BA1_CODPLA NOT IN ('0098','0099') " 	+ CRLF

	EndIf
	_cQuery += " WHERE " 	+ CRLF  
	_cQuery += " 	BA1.BA1_FILIAL = '" + xFilial("BA1") + "' " 	+ CRLF
	_cQuery += " 	AND BA1.D_E_L_E_T_ = ' ' " 	+ CRLF
	_cQuery += " 	AND BA1.BA1_DATBLO = ' ' " 	+ CRLF	

	//---------------------------
	//OPERADORA
	//---------------------------
	If !Empty(AllTrim(MV_PAR01))

		_cQuery += " 	AND BA1.BA1_CODINT = '" + MV_PAR01 + "' " 	+ CRLF

	EndIf
	
	//---------------------------
	//EMPRESA
	//---------------------------
	If !Empty(AllTrim(MV_PAR02))

		_cQuery += " 	AND BA1.BA1_CODEMP = '" + MV_PAR02 + "' " 	+ CRLF

		//-------------------------------------
		//Prefeitura remover os odontologicos
		//-------------------------------------
		If MV_PAR02 = "0024"

			_cQuery += " 	AND BA1.BA1_CODPLA NOT IN ('0098','0099') " 	+ CRLF

		EndIf

	EndIf
	
	//---------------------------
	//DATA DE INCLUSAO
	//---------------------------
	If !Empty(AllTrim(MV_PAR03)) .OR. !Empty(AllTrim(MV_PAR04))
	
		_cQuery += " 	AND BA1.BA1_DATINC BETWEEN '" + DTOS(MV_PAR03) + "' AND '" + DTOS(MV_PAR04) + "' " 	+ CRLF
		
	EndIf

	_cQuery += " ORDER BY BA1.BA1_MATRIC, BA1.BA1_TIPREG, BA1.BA1_DIGITO " 	+ CRLF

	If Select(_cAlias1) > 0
		(_cAlias1)->(DbCloseArea())
	EndIf

	PLSQuery(_cQuery,_cAlias1)

	oSection1:Init()
	oSection1:SetHeaderSection(.T.)

	While !(_cAlias1)->(EOF())

		oReport:IncMeter()

		If oReport:Cancel()
			Exit
		EndIf

		oSection1:Cell("MATRICULA"			):SetValue(AllTrim((_cAlias1)->MATRIC_BLQ	)	)
		oSection1:Cell("INCLUSAO"			):SetValue(AllTrim((_cAlias1)->DT_INC		)	)
		oSection1:Cell("NOME"				):SetValue(AllTrim((_cAlias1)->NOME			)	)
		oSection1:Cell("CPF"				):SetValue(AllTrim((_cAlias1)->CPF			)	)
		oSection1:Cell("PLANO"				):SetValue(AllTrim((_cAlias1)->PLANO		)	)
		oSection1:Cell("DESC_PLANO"			):SetValue(AllTrim((_cAlias1)->DESC_PLANO	)	)
		oSection1:Cell("DT_BLOQ"			):SetValue(AllTrim((_cAlias1)->DT_BLOQ		)	)
		oSection1:Cell("MOTIVO_BLOQ"		):SetValue(AllTrim((_cAlias1)->MOT_BLOQ		)	)
		oSection1:Cell("MATRIC_NV"			):SetValue(AllTrim((_cAlias1)->MATRIC_NOVA	)	)
		oSection1:Cell("DT_INC_MATRIC_NV"	):SetValue(AllTrim((_cAlias1)->DT_INC_NV	)	)
		oSection1:Cell("PLANO_NV"			):SetValue(AllTrim((_cAlias1)->PLANO_NV		)	)
		oSection1:Cell("MOT_BLOQ_NV"		):SetValue(AllTrim((_cAlias1)->MT_BLQ_NV	)	)
		oSection1:Cell("DESC_PLANO_NV"		):SetValue(AllTrim((_cAlias1)->DSC_PL_NV	)	)
		oSection1:Cell("DT_BLOQ_NV"			):SetValue(AllTrim((_cAlias1)->DT_BLQ_NV	)	)

		oSection1:PrintLine()

		(_cAlias1)->(DbSkip())

	EndDo

	oSection1:Finish()

	If Select(_cAlias1) > 0
		(_cAlias1)->(DbCloseArea())
	EndIf

	RestArea(_aArea)

Return (.T.)
