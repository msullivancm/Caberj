#INCLUDE "REPORT.CH"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "TOPCONN.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABR253   ºAutor  ³Angelo Henrique     º Data ³  24/04/18   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Relatório de Taxa de Adesão no nível da família            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CABERJ                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function CABR253()
	
	Local _aArea 	:= GetArea()
	Local oReport	:= Nil
	
	Private _cPerg	:= "CABR253"
	
	//Cria grupo de perguntas
	CABR253A(_cPerg)
	
	If Pergunte(_cPerg,.T.)
		
		//----------------------------------------------------
		//Validando se existe o Excel instalado na máquina
		//para não dar erro e o usuário poder visualizar em
		//outros programas como o LibreOffice
		//----------------------------------------------------
		If ApOleClient("MSExcel")
			
			oReport := CABR253B()
			oReport:PrintDialog()
			
		Else
			
			Processa({||CABR253E()},'Processando...')
			
		EndIf
		
	EndIf
	
	RestArea(_aArea)
	
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABR253A  ºAutor  ³Angelo Henrique     º Data ³  24/04/18   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Rotina responsavel pela geração das perguntas no relatório  º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CABERJ                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function CABR253A(cGrpPerg)
	
	Local aHelpPor := {} //help da pergunta
	
	aHelpPor := {}
	AADD(aHelpPor,"Informe a Data do Protocolo			")
	AADD(aHelpPor,"de solicitação de Carteiras De/Ate	")
	
	PutSx1(cGrpPerg,"01","Data De: ? "			,"a","a","MV_CH1"	,"D",TamSX3("ZX_DATDE")[1]	,0,0,"G","",""		,"","","MV_PAR01","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")
	PutSx1(cGrpPerg,"02","Data Ate:? "			,"a","a","MV_CH2"	,"D",TamSX3("ZX_DATDE")[1]	,0,0,"G","",""		,"","","MV_PAR02","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")
	
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABR253B  ºAutor  ³Angelo Henrique     º Data ³  08/05/18   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Rotina que irá gerar as informações do relatório            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CABERJ                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function CABR253B
	
	Local oReport		:= Nil
	Local oSection1 	:= Nil
	
	oReport := TReport():New("CABR253","PA DE CARTEIRA X LOTE DE CARTEIRA",_cPerg,{|oReport| CABR253C(oReport)},"PA DE CARTEIRA X LOTE DE CARTEIRA")
	
	oReport:SetLandScape()
	
	oReport:oPage:setPaperSize(9)
	
	//--------------------------------
	//Primeira linha do relatório
	//--------------------------------
	oSection1 := TRSection():New(oReport,"PA DE CARTEIRA X LOTE DE CARTEIRA","SZX,SZY,BA1,SX5,BI3,PBL")
	
	TRCell():New(oSection1,"PROTOCOLO" 		,"SZX")
	oSection1:Cell("PROTOCOLO"):SetAutoSize(.F.)
	oSection1:Cell("PROTOCOLO"):SetSize(TAMSX3("ZX_SEQ")[1])
	
	TRCell():New(oSection1,"MATRICULA"		,"BA1")
	oSection1:Cell("MATRICULA"):SetAutoSize(.F.)
	oSection1:Cell("MATRICULA"):SetSize(20)
	
	TRCell():New(oSection1,"NOME"			,"BA1")
	oSection1:Cell("NOME"):SetAutoSize(.F.)
	oSection1:Cell("NOME"):SetSize(TAMSX3("BA1_NOMUSR")[1])
	
	TRCell():New(oSection1,"PLANO"			,"BA1")
	oSection1:Cell("PLANO"):SetAutoSize(.F.)
	oSection1:Cell("PLANO"):SetSize(TAMSX3("BA1_CODPLA")[1])
	
	TRCell():New(oSection1,"DESC_PLANO" 	,"BI3")
	oSection1:Cell("DESC_PLANO"):SetAutoSize(.F.)
	oSection1:Cell("DESC_PLANO"):SetSize(TAMSX3("BI3_DESCRI")[1])
	
	TRCell():New(oSection1,"LOTE_DATA"		,"BED")
	oSection1:Cell("LOTE_DATA"):SetAutoSize(.F.)
	oSection1:Cell("LOTE_DATA"):SetSize(30)
	
	TRCell():New(oSection1,"TIPO_SERVICO"	,"SZY")
	oSection1:Cell("TIPO_SERVICO"):SetAutoSize(.F.)
	oSection1:Cell("TIPO_SERVICO"):SetSize(TAMSX3("ZY_TIPOSV")[1])
	
	TRCell():New(oSection1,"DESC_SERV"		,"PBL")
	oSection1:Cell("DESC_SERV"):SetAutoSize(.F.)
	oSection1:Cell("DESC_SERV"):SetSize(TAMSX3("PBL_YDSSRV")[1])
	
	TRCell():New(oSection1,"COD_HIST"		,"PCD")
	oSection1:Cell("COD_HIST"):SetAutoSize(.F.)
	oSection1:Cell("COD_HIST"):SetSize(TAMSX3("PCD_COD")[1])
	
	TRCell():New(oSection1,"HIST_PADRAO"	,"PCD")
	oSection1:Cell("HIST_PADRAO"):SetAutoSize(.F.)
	oSection1:Cell("HIST_PADRAO"):SetSize(TAMSX3("PCD_DESCRI")[1])
	
	TRCell():New(oSection1,"OBS"			,"PCD")
	oSection1:Cell("OBS"):SetAutoSize(.F.)
	oSection1:Cell("OBS"):SetSize(TAMSX3("ZY_OBS")[1])
	
	TRCell():New(oSection1,"EXPIRA"			,"PCD")
	oSection1:Cell("EXPIRA"):SetAutoSize(.F.)
	oSection1:Cell("EXPIRA"):SetSize(15)
	
Return oReport


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABR244B  ºAutor  ³Angelo Henrique     º Data ³  13/10/17   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Rotina para montar a query e trazer as informações no       º±±
±±º          ³relatório.                                                  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CABERJ                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function CABR253C(oReport)
	
	Local _aArea 		:= GetArea()
	Local _cQuery		:= ""
	
	Private oSection1 	:= oReport:Section(1)
	Private _cAlias1	:= GetNextAlias()
	
	//---------------------------------------------
	//CABR253D Realiza toda a montagem da query
	//facilitando a manutenção do fonte
	//---------------------------------------------
	_cQuery := CABR253D()
	
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
		
		oSection1:Cell("PROTOCOLO" 		):SetValue( (_cAlias1)->PROTOCOLO	)
		oSection1:Cell("MATRICULA"		):SetValue( (_cAlias1)->MATRICULA	)
		oSection1:Cell("NOME"			):SetValue( (_cAlias1)->NOME		)
		oSection1:Cell("PLANO"			):SetValue( (_cAlias1)->PLANO		)
		oSection1:Cell("DESC_PLANO" 	):SetValue( (_cAlias1)->DESC_PLANO	)
		oSection1:Cell("LOTE_DATA" 		):SetValue( (_cAlias1)->LT_DT		)
		oSection1:Cell("TIPO_SERVICO"	):SetValue( (_cAlias1)->TIPO_SERVICO)
		oSection1:Cell("DESC_SERV"		):SetValue( (_cAlias1)->DESC_SERV	)
		oSection1:Cell("COD_HIST"		):SetValue( (_cAlias1)->COD_HIST	)
		oSection1:Cell("HIST_PADRAO"	):SetValue( (_cAlias1)->HIST_PADRAO	)
		oSection1:Cell("OBS"			):SetValue( (_cAlias1)->OBS			)
		oSection1:Cell("EXPIRA"			):SetValue( (_cAlias1)->EXPIRA		)
		
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
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABR253D  ºAutor  ³Angelo Henrique     º Data ³  24/10/16   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Rotina responsavel por tratar a query, facilitando assim    º±±
±±º          ³a manutenção do fonte.                                      º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CABERJ                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function CABR253D()
	
	Local _cQuery 	:= ""
	
	_cQuery += " SELECT																							" + CRLF
	_cQuery += "	DISTINCT																					" + CRLF
	_cQuery += "	SZX.ZX_SEQ PROTOCOLO,																		" + CRLF
	_cQuery += "	BA1.BA1_CODINT||BA1.BA1_CODEMP||BA1.BA1_MATRIC||BA1.BA1_TIPREG||BA1.BA1_DIGITO MATRICULA,	" + CRLF
	_cQuery += "	TRIM(BA1.BA1_NOMUSR) NOME,																	" + CRLF
	_cQuery += "	BA1.BA1_CODPLA PLANO,																		" + CRLF
	_cQuery += "	TRIM(BI3.BI3_DESCRI) DESC_PLANO,															" + CRLF
	
	//-- ---------------------------------------------------------
	//-- SUBQUERY CONTENDO A DATA E LOTE CASO TENHA SIDO GERADO
	//-- ---------------------------------------------------------
	_cQuery += "	(																							" + CRLF
	_cQuery += "		SELECT																					" + CRLF
	_cQuery += "			NVL(MAX(BED.BED_CDIDEN||' - '||SIGA.FORMATA_DATA_MS(BED.BED_DTSOLI)), ' ')			" + CRLF
	_cQuery += "		FROM																					" + CRLF
	_cQuery += "    		" + RetSqlName("BED") + " BED                      									" + CRLF
	_cQuery += "		WHERE																					" + CRLF
	_cQuery += "			BED.BED_FILIAL = '" + xFilial("BED") + "'											" + CRLF
	_cQuery += "			AND BED.BED_CODINT = BA1.BA1_CODINT													" + CRLF
	_cQuery += "			AND BED.BED_CODEMP = BA1.BA1_CODEMP													" + CRLF
	_cQuery += "			AND BED.BED_MATRIC = BA1.BA1_MATRIC													" + CRLF
	_cQuery += "			AND BED.BED_TIPREG = BA1.BA1_TIPREG													" + CRLF
	_cQuery += "			AND BED.BED_DIGITO = BA1.BA1_DIGITO													" + CRLF
	_cQuery += "			AND BED.D_E_L_E_T_ = ' '															" + CRLF
	
	//-- --------------------------------------------
	//-- PARAMETRO DE DATA DE INCLUSÃO DO PROTOCOLO
	//-- --------------------------------------------
	If !Empty(MV_PAR01) .And. !Empty(MV_PAR02)
		
		_cQuery += "			AND BED.BED_DTSOLI BETWEEN '" + DTOS(MV_PAR01) + "' AND '" + DTOS(MV_PAR02) + "'" + CRLF
		
	EndIf
	
	_cQuery += "	) LT_DT ,																									" + CRLF
	_cQuery += "	SZY.ZY_TIPOSV TIPO_SERVICO,																					" + CRLF
	_cQuery += "	TRIM(PBL.PBL_YDSSRV) DESC_SERV,																				" + CRLF
	_cQuery += " 	NVL(PCD.PCD_COD,' ') COD_HIST,																				" + CRLF
	_cQuery += " 	NVL(PCD.PCD_DESCRI,' ') HIST_PADRAO,																		" + CRLF
	_cQuery += " 	TRIM(SZY.ZY_OBS) OBS,																						" + CRLF
	_cQuery += "    DECODE																										" + CRLF
	_cQuery += "    (																											" + CRLF
	_cQuery += "     	SUBSTR																									" + CRLF
	_cQuery += "     		(																									" + CRLF
	_cQuery += "     			( 	 																							" + CRLF
	_cQuery += "     				(  																							" + CRLF
	_cQuery += "     					N_DIAS_UTEIS_PERIODO(TO_DATE(TRIM(SZX.ZX_DATDE||SZX.ZX_HORADE),'YYYYMMDDHH24MI'), 		" + CRLF
	_cQuery += "     					NVL(TO_DATE(TRIM(SZX.ZX_DATATE||SZX.ZX_HORATE),'YYYYMMDDHH24MI'),SYSDATE))  			" + CRLF
	_cQuery += "     				)  																							" + CRLF
	_cQuery += "     				- DECODE(TRIM(SZX.ZX_SLA),NULL,'X',SZX.ZX_SLA)  											" + CRLF
	_cQuery += "     			)  																								" + CRLF
	_cQuery += "     			,1,1  																							" + CRLF
	_cQuery += "     		)  																									" + CRLF
	_cQuery += "     	,'-','A EXPIRAR','EXPIRADO'  																			" + CRLF
	_cQuery += "    )EXPIRA  																									" + CRLF
	_cQuery += " FROM																											" + CRLF
	_cQuery += "    " + RetSqlName("SZX") + " SZX                      															" + CRLF
	
	//-- --------------------------------
	//-- ITENS DO PROTOCOLO
	//-- --------------------------------
	_cQuery += "	INNER JOIN																									" + CRLF
	_cQuery += "    " + RetSqlName("SZY") + " SZY                      															" + CRLF
	_cQuery += "	ON																											" + CRLF
	_cQuery += "		SZY.D_E_L_E_T_ = ' '																					" + CRLF
	_cQuery += "		AND SZY.ZY_FILIAL = '" + xFilial("SZY") + "'															" + CRLF
	_cQuery += "		AND SZY.ZY_SEQBA = SZX.ZX_SEQ																			" + CRLF
	_cQuery += "		AND SZY.ZY_SEQSERV = '000001'																			" + CRLF
	_cQuery += "		AND SZY.ZY_TIPOSV = '1001'																				" + CRLF
	
	//-- --------------------------------
	//-- USUARIO
	//-- --------------------------------
	_cQuery += "	INNER JOIN																									" + CRLF
	_cQuery += "    " + RetSqlName("BA1") + " BA1                      															" + CRLF
	_cQuery += "	ON																											" + CRLF
	_cQuery += "		BA1.BA1_FILIAL = '" + xFilial("BA1") + "'																" + CRLF
	_cQuery += "		AND BA1.BA1_CODINT = SZX.ZX_CODINT																		" + CRLF
	_cQuery += "		AND BA1.BA1_CODEMP = SZX.ZX_CODEMP																		" + CRLF
	_cQuery += "		AND BA1.BA1_MATRIC = SZX.ZX_MATRIC																		" + CRLF
	_cQuery += "		AND BA1.BA1_TIPREG = SZX.ZX_TIPREG																		" + CRLF
	_cQuery += "		AND BA1.BA1_DIGITO = SZX.ZX_DIGITO																		" + CRLF
	_cQuery += "		AND BA1.BA1_DATBLO = ' '																				" + CRLF
	_cQuery += "		AND BA1.D_E_L_E_T_ = ' '																				" + CRLF
	
	//-- --------------------------------
	//-- TABELAS GENÉRICAS
	//-- --------------------------------
	_cQuery += "	INNER JOIN																									" + CRLF
	_cQuery += "		SX5010 SX5																								" + CRLF
	_cQuery += "	ON																											" + CRLF
	_cQuery += "		SX5.D_E_L_E_T_ = ' '																					" + CRLF
	_cQuery += "		AND SX5.X5_TABELA = 'ZT'																				" + CRLF
	_cQuery += "		AND SX5.X5_CHAVE = SZX.ZX_TPDEM																			" + CRLF
	
	//-- --------------------------------
	//-- PRODUTO
	//-- --------------------------------
	_cQuery += "	INNER JOIN																									" + CRLF
	_cQuery += "    " + RetSqlName("BI3") + " BI3                      															" + CRLF
	_cQuery += "	ON																											" + CRLF
	_cQuery += "		BI3.BI3_FILIAL = '" + xFilial("BI3") + "'																" + CRLF
	_cQuery += "		AND BI3.BI3_CODINT = BA1.BA1_CODINT																		" + CRLF
	_cQuery += "		AND BI3.BI3_CODIGO = BA1.BA1_CODPLA																		" + CRLF
	_cQuery += "		AND BI3.D_E_L_E_T_ = ' '																				" + CRLF
	
	//-- --------------------------------
	//-- TIPO DE SERVIÇO
	//-- --------------------------------
	_cQuery += "	INNER JOIN																									" + CRLF
	_cQuery += "    " + RetSqlName("PBL") + " PBL                      															" + CRLF
	_cQuery += "	ON																											" + CRLF
	_cQuery += "		PBL.PBL_FILIAL = '" + xFilial("PBL") + "'																" + CRLF
	_cQuery += "		AND PBL.PBL_YCDSRV = SZY.ZY_TIPOSV																		" + CRLF
	_cQuery += "		AND PBL.D_E_L_E_T_ = ' '																				" + CRLF
	_cQuery += "		AND PBL.PBL_YCDSRV > 999																				" + CRLF
	
	_cQuery += "	INNER JOIN                       																			" + CRLF
	_cQuery += "    " + RetSqlName("PCD") + " PCD                      															" + CRLF
	_cQuery += "    ON																											" + CRLF
	_cQuery += "    	PCD.PCD_FILIAL = '" + xFilial("PCD") + "'																" + CRLF
	_cQuery += "    	AND PCD.PCD_COD = SZY.ZY_HISTPAD																		" + CRLF
	_cQuery += "    	AND PCD.D_E_L_E_T_ = ' '																				" + CRLF
	
	_cQuery += " WHERE																											" + CRLF
	_cQuery += " 	SZX.D_E_L_E_T_ = ' '																						" + CRLF
	_cQuery += " 	AND SZX.ZX_FILIAL = '" + xFilial("SZX") + "'																" + CRLF
	_cQuery += " 	AND SZX.ZX_TPDEM = 'T'																						" + CRLF
	_cQuery += " 	AND SZX.ZX_TPINTEL = '1'																					" + CRLF
	
	//-- --------------------------------------------
	//-- PARAMETRO DE DATA DE INCLUSÃO DO PROTOCOLO
	//-- --------------------------------------------
	If !Empty(MV_PAR01) .And. !Empty(MV_PAR02)
		
		_cQuery += " 	AND SZX.ZX_DATDE BETWEEN '" + DTOS(MV_PAR01) + "' AND '" + DTOS(MV_PAR02) + "'							" + CRLF
		
	EndIf
	
	_cQuery += " 	ORDER BY 2																									" + CRLF
	
Return _cQuery


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABR253E  ºAutor  ³Angelo Henrique     º Data ³  08/05/18   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Rotina responsavel por gerar o relatório em CSV, pois       º±±
±±º          ³alguns usuários não possuem o Excel.                        º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CABERJ                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function CABR253E()
	
	Local _aArea 	:= GetArea()
	Local _cQuery	:= ""
	Local nHandle 	:= 0
	Local cNomeArq	:= ""
	Local cMontaTxt	:= ""
	
	Private _cAlias2	:= GetNextAlias()
	
	ProcRegua(RecCount())
	
	cNomeArq := "C:\TEMP\RELATORIO_PA_CARTEIRA_X_LOTE_CARTEIRA"
	cNomeArq += "_" + SUBSTR(DTOS(DATE()),7,2)
	cNomeArq += "_" + SUBSTR(DTOS(DATE()),5,2)
	cNomeArq += "_" + SUBSTR(DTOS(DATE()),1,4)
	cNomeArq += "_" + STRTRAN(TIME(),":","_") + ".csv"
	
	//---------------------------------------------
	//CABR244D Realiza toda a montagem da query
	//facilitando a manutenção do fonte
	//---------------------------------------------
	_cQuery := CABR253D()
	
	If Select(_cAlias2) > 0
		(_cAlias2)->(DbCloseArea())
	EndIf
	
	DbUseArea(.T.,"TOPCONN",TcGenQry(,,_cQuery),_cAlias2,.T.,.T.)
	
	While !(_cAlias2)->(EOF())
		
		IncProc()
		
		//------------------------------------------------------------------
		//Se for a primeira vez, deve ser criado o arquivo e o cabeçalho
		//------------------------------------------------------------------
		If nHandle = 0
			
			//------------------------------------------------------------------
			// criar arquivo texto vazio a partir do root path no servidor
			//------------------------------------------------------------------
			nHandle := FCREATE(cNomeArq)
			
			If nHandle > 0
				
				cMontaTxt := "PROTOCOLO ; "
				cMontaTxt += "MATRICULA ; "
				cMontaTxt += "NOME ; "
				cMontaTxt += "PLANO ; "
				cMontaTxt += "DESC_PLANO ; "
				cMontaTxt += "LOTE_DATA ; "
				cMontaTxt += "TIPO_SERVICO ; "
				cMontaTxt += "DESC_SERV ; "
				cMontaTxt += "COD_HIST ; "
				cMontaTxt += "HIST_PADRAO ; "
				cMontaTxt += "OBS ; "
				cMontaTxt += "EXPIRA ; "
				
				cMontaTxt += CRLF // Salto de linha para .csv (excel)
				
				FWrite(nHandle,cMontaTxt)
				
			Else
				
				Aviso("Atenção","Não foi possível criar o relatório",{"OK"})
				Exit
				
			EndIf
			
		EndIf
		
		cMontaTxt := AllTrim((_cAlias2)->PROTOCOLO			) + ";"
		cMontaTxt += "'" + AllTrim((_cAlias2)->MATRICULA	) + ";"
		cMontaTxt += AllTrim((_cAlias2)->NOME				) + ";"
		cMontaTxt += "'" + AllTrim((_cAlias2)->PLANO		) + ";"
		cMontaTxt += AllTrim((_cAlias2)->DESC_PLANO			) + ";"
		cMontaTxt += "'" + AllTrim((_cAlias2)->LT_DT		) + ";"
		cMontaTxt += "'" + AllTrim((_cAlias2)->TIPO_SERVICO	) + ";"
		cMontaTxt += AllTrim((_cAlias2)->DESC_SERV			) + ";"		
		cMontaTxt += "'" + AllTrim((_cAlias2)->COD_HIST		) + ";"
		cMontaTxt += AllTrim((_cAlias2)->HIST_PADRAO		) + ";"
		cMontaTxt += AllTrim((_cAlias2)->OBS				) + ";"
		cMontaTxt += AllTrim((_cAlias2)->EXPIRA				) + ";"
		
		cMontaTxt += CRLF // Salto de linha para .csv (excel)
		
		FWrite(nHandle,cMontaTxt)
		
		(_cAlias2)->(DbSkip())
		
	EndDo
	
	If Select(_cAlias2) > 0
		(_cAlias2)->(DbCloseArea())
	EndIf
	
	If nHandle > 0
		
		// encerra gravação no arquivo
		FClose(nHandle)
		
		MsgAlert("Relatorio salvo em: "+cNomeArq)
		
	EndIf
	
	RestArea(_aArea)
	
Return