#INCLUDE "REPORT.CH"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "TOPCONN.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABR257   ºAutor  ³Angelo Henrique     º Data ³  22/05/18   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Relatório de Log de Atualização de Prestadores via Web.    º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CABERJ                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function CABR257()
	
	Local _aArea 	:= GetArea()
	Local oReport	:= Nil
	
	Private _cPerg	:= "CABR257"
	
	//Cria grupo de perguntas
	CABR257A(_cPerg)
	
	If Pergunte(_cPerg,.T.)
		
		//----------------------------------------------------
		//Validando se existe o Excel instalado na máquina
		//para não dar erro e o usuário poder visualizar em
		//outros programas como o LibreOffice
		//----------------------------------------------------
		If ApOleClient("MSExcel")
			
			oReport := CABR257B()
			oReport:PrintDialog()
			
		Else
			
			Processa({||CABR257E()},'Processando...')
			
		EndIf
		
	EndIf
	
	RestArea(_aArea)
	
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABR257A  ºAutor  ³Angelo Henrique     º Data ³  22/05/18   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Rotina responsavel pela geração das perguntas no relatório  º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CABERJ                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function CABR257A(cGrpPerg)
	
	Local aHelpPor := {} //help da pergunta
	
	aHelpPor := {}
	AADD(aHelpPor,"Informe RDA:					")
	
	PutSx1(cGrpPerg,"01","RDA De: ? "			,"a","a","MV_CH1"	,"C",TamSX3("BAU_CODIGO")[1]	,0,0,"G","",""		,"","","MV_PAR01","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")
	PutSx1(cGrpPerg,"02","RDA Ate: ? "			,"a","a","MV_CH2"	,"C",TamSX3("BAU_CODIGO")[1]	,0,0,"G","",""		,"","","MV_PAR02","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")
	
	aHelpPor := {}
	AADD(aHelpPor,"Informe a Data para pesquisa	")
	
	PutSx1(cGrpPerg,"03","Data Ate:? "			,"a","a","MV_CH3"	,"D",TamSX3("BAU_DTINCL")[1]	,0,0,"G","",""		,"","","MV_PAR03","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")
	PutSx1(cGrpPerg,"04","Data Ate:? "			,"a","a","MV_CH4"	,"D",TamSX3("BAU_DTINCL")[1]	,0,0,"G","",""		,"","","MV_PAR04","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")
	
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABR257B  ºAutor  ³Angelo Henrique     º Data ³  08/05/18   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Rotina que irá gerar as informações do relatório            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CABERJ                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function CABR257B
	
	Local oReport		:= Nil
	Local oSection1 	:= Nil
	
	oReport := TReport():New("CABR257","LOG PRESTADORES ESOCIAL",_cPerg,{|oReport| CABR257C(oReport)},"LOG PRESTADORES ESOCIAL")
	
	oReport:SetLandScape()
	
	oReport:oPage:setPaperSize(9)
	
	//--------------------------------
	//Primeira linha do relatório
	//--------------------------------
	oSection1 := TRSection():New(oReport,"LOG PRESTADORES ESOCIAL","BAU")
	
	TRCell():New(oSection1,"CODIGO" 	,"BAU")
	oSection1:Cell("CODIGO"):SetAutoSize(.F.)
	oSection1:Cell("CODIGO"):SetSize(TAMSX3("BAU_CODIGO")[1])
	
	TRCell():New(oSection1,"NOME" 		,"BAU")
	oSection1:Cell("NOME"):SetAutoSize(.F.)
	oSection1:Cell("NOME"):SetSize(TAMSX3("BAU_NOME")[1])
	
	TRCell():New(oSection1,"FANTASIA" 	,"BAU")
	oSection1:Cell("FANTASIA"):SetAutoSize(.F.)
	oSection1:Cell("FANTASIA"):SetSize(TAMSX3("BAU_NFANTA")[1])
	
	TRCell():New(oSection1,"NACIONAL" 	,"BAU")
	oSection1:Cell("NACIONAL"):SetAutoSize(.F.)
	oSection1:Cell("NACIONAL"):SetSize(TAMSX3("BAU_NACION")[1])
	
	TRCell():New(oSection1,"CEP" 		,"BAU")
	oSection1:Cell("CEP"):SetAutoSize(.F.)
	oSection1:Cell("CEP"):SetSize(TAMSX3("BAU_CEP")[1])
	
	TRCell():New(oSection1,"ENDERECO" 	,"BAU")
	oSection1:Cell("ENDERECO"):SetAutoSize(.F.)
	oSection1:Cell("ENDERECO"):SetSize(TAMSX3("BAU_END")[1])
	
	TRCell():New(oSection1,"NUMERO" 	,"BAU")
	oSection1:Cell("NUMERO"):SetAutoSize(.F.)
	oSection1:Cell("NUMERO"):SetSize(TAMSX3("BAU_NUMERO")[1])
	
	TRCell():New(oSection1,"COMPLEM" 	,"BAU")
	oSection1:Cell("COMPLEM"):SetAutoSize(.F.)
	oSection1:Cell("COMPLEM"):SetSize(TAMSX3("BAU_YCPEND")[1])
	
	TRCell():New(oSection1,"BAIRRO" 	,"BAU")
	oSection1:Cell("BAIRRO"):SetAutoSize(.F.)
	oSection1:Cell("BAIRRO"):SetSize(TAMSX3("BAU_BAIRRO")[1])
	
	TRCell():New(oSection1,"MUNICIPIO" 	,"BAU")
	oSection1:Cell("MUNICIPIO"):SetAutoSize(.F.)
	oSection1:Cell("MUNICIPIO"):SetSize(TAMSX3("BAU_MUN")[1])
	
	TRCell():New(oSection1,"ESTADO" 	,"BAU")
	oSection1:Cell("ESTADO"):SetAutoSize(.F.)
	oSection1:Cell("ESTADO"):SetSize(TAMSX3("BAU_EST")[1])
	
	TRCell():New(oSection1,"EMAIL" 		,"BAU")
	oSection1:Cell("EMAIL"):SetAutoSize(.F.)
	oSection1:Cell("EMAIL"):SetSize(TAMSX3("BAU_EMAIL")[1])
	
	TRCell():New(oSection1,"TELEFONE" 	,"BAU")
	oSection1:Cell("TELEFONE"):SetAutoSize(.F.)
	oSection1:Cell("TELEFONE"):SetSize(TAMSX3("BAU_TEL")[1])
	
	TRCell():New(oSection1,"SEXO" 		,"BAU")
	oSection1:Cell("SEXO"):SetAutoSize(.F.)
	oSection1:Cell("SEXO"):SetSize(TAMSX3("BAU_SEXO")[1])
	
	TRCell():New(oSection1,"GRAU" 		,"BAU")
	oSection1:Cell("GRAU"):SetAutoSize(.F.)
	oSection1:Cell("GRAU"):SetSize(TAMSX3("BAU_XGRAUI")[1])
	
	TRCell():New(oSection1,"RACA" 		,"BAU")
	oSection1:Cell("RACA"):SetAutoSize(.F.)
	oSection1:Cell("RACA"):SetSize(TAMSX3("BAU_XRACAC")[1])
	
	TRCell():New(oSection1,"PAISORIG" 	,"BAU")
	oSection1:Cell("PAISORIG"):SetAutoSize(.F.)
	oSection1:Cell("PAISORIG"):SetSize(TAMSX3("BAU_XPAISO")[1])
	
	TRCell():New(oSection1,"NMSOCIAL" 	,"BAU")
	oSection1:Cell("NMSOCIAL"):SetAutoSize(.F.)
	oSection1:Cell("NMSOCIAL"):SetSize(TAMSX3("BAU_XSOCIA")[1])
	
	TRCell():New(oSection1,"DTGRAVAC" 	,"BAU")
	oSection1:Cell("DTGRAVAC"):SetAutoSize(.F.)
	oSection1:Cell("DTGRAVAC"):SetSize(10)
	
	TRCell():New(oSection1,"HRGRAVAC" 	,"BAU")
	oSection1:Cell("HRGRAVAC"):SetAutoSize(.F.)
	oSection1:Cell("HRGRAVAC"):SetSize(10)
	
	TRCell():New(oSection1,"DTNEGAC" 	,"BAU")
	oSection1:Cell("DTNEGAC"):SetAutoSize(.F.)
	oSection1:Cell("DTNEGAC"):SetSize(10)
	
	TRCell():New(oSection1,"STATUS" 	,"BAU")
	oSection1:Cell("STATUS"):SetAutoSize(.F.)
	oSection1:Cell("STATUS"):SetSize(50)
	
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

Static Function CABR257C(oReport)
	
	Local _aArea 		:= GetArea()
	Local _cQuery		:= ""
	
	Private oSection1 	:= oReport:Section(1)
	Private _cAlias1	:= GetNextAlias()
	
	//---------------------------------------------
	//CABR257D Realiza toda a montagem da query
	//facilitando a manutenção do fonte
	//---------------------------------------------
	_cQuery := CABR257D()
	
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
		
		oSection1:Cell("CODIGO" 	):SetValue( (_cAlias1)->CODIGO		)
		oSection1:Cell("NOME"		):SetValue( (_cAlias1)->NOME		)
		oSection1:Cell("FANTASIA"	):SetValue( (_cAlias1)->FANTASIA	)
		oSection1:Cell("NACIONAL"	):SetValue( (_cAlias1)->NACIONAL	)
		oSection1:Cell("CEP"		):SetValue( (_cAlias1)->CEP			)
		oSection1:Cell("ENDERECO"	):SetValue( (_cAlias1)->ENDERECO	)
		oSection1:Cell("NUMERO"		):SetValue( (_cAlias1)->NUMERO		)
		oSection1:Cell("COMPLEM"	):SetValue( (_cAlias1)->COMPLEM		)
		oSection1:Cell("BAIRRO"		):SetValue( (_cAlias1)->BAIRRO		)
		oSection1:Cell("MUNICIPIO"	):SetValue( (_cAlias1)->DSCMUN		)
		oSection1:Cell("ESTADO"		):SetValue( (_cAlias1)->ESTADO		)
		oSection1:Cell("EMAIL"		):SetValue( (_cAlias1)->EMAIL		)
		oSection1:Cell("TELEFONE"	):SetValue( (_cAlias1)->TELEFONE	)
		oSection1:Cell("SEXO"		):SetValue( (_cAlias1)->SEXO		)
		oSection1:Cell("GRAU"		):SetValue( (_cAlias1)->GRAU		)
		oSection1:Cell("RACA"		):SetValue( (_cAlias1)->RACA		)
		oSection1:Cell("PAISORIG"	):SetValue( (_cAlias1)->DESCPAIS	)
		oSection1:Cell("NMSOCIAL"	):SetValue( (_cAlias1)->SOCIAL		)
		oSection1:Cell("DTGRAVAC"	):SetValue( (_cAlias1)->DTGRAVA		)
		oSection1:Cell("HRGRAVAC"	):SetValue( (_cAlias1)->HRGRAVA		)		
		oSection1:Cell("DTNEGAC" 	):SetValue( (_cAlias1)->DTNEGA		)
		oSection1:Cell("STATUS" 	):SetValue( (_cAlias1)->STATUS		)			
		
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
±±ºPrograma  ³CABR257D  ºAutor  ³Angelo Henrique     º Data ³  24/10/16   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Rotina responsavel por tratar a query, facilitando assim    º±±
±±º          ³a manutenção do fonte.                                      º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CABERJ                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function CABR257D()
	
	Local _cQuery 	:= ""
	Local _lMv01 	:= .F.
	
	_cQuery += " SELECT 																" + CRLF
	_cQuery += " 	LOGCAB.CODIGO CODIGO,												" + CRLF
	_cQuery += " 	TRIM(LOGCAB.NOME) NOME,												" + CRLF
	_cQuery += " 	TRIM(LOGCAB.FANTASIA) FANTASIA,										" + CRLF
	_cQuery += " 	UPPER(LOGCAB.NACIONAL) NACIONAL,									" + CRLF
	_cQuery += " 	LOGCAB.CEP CEP,														" + CRLF
	_cQuery += " 	TRIM(LOGCAB.ENDERECO) ENDERECO,										" + CRLF
	_cQuery += " 	LOGCAB.NUMERO NUMERO,												" + CRLF
	_cQuery += " 	NVL(TRIM(LOGCAB.COMPLEM),' ') COMPLEM,								" + CRLF
	_cQuery += " 	TRIM(LOGCAB.BAIRRO) BAIRRO,											" + CRLF
	_cQuery += " 	LOGCAB.MUNIC MUNICIPIO,												" + CRLF
	_cQuery += " 	TRIM(BID.BID_DESCRI) DSCMUN,										" + CRLF
	_cQuery += " 	LOGCAB.ESTADO ESTADO,												" + CRLF
	_cQuery += " 	TRIM(LOGCAB.EMAIL) EMAIL,											" + CRLF
	_cQuery += " 	TRIM(LOGCAB.TELEF) TELEFONE,										" + CRLF
	_cQuery += " 	NVL(DECODE(LOGCAB.SEXO,'0','MASCULINO','1','FEMININO'),' ') SEXO,	" + CRLF
	_cQuery += " 	LOGCAB.GRAU GRAU,													" + CRLF
	_cQuery += " 	TRIM(SX5.X5_DESCRI) DESCGRAU,										" + CRLF
	_cQuery += " 	DECODE																" + CRLF
	_cQuery += " 	(																	" + CRLF
	_cQuery += " 		RACA,															" + CRLF
	_cQuery += " 		'1','INDIGENA',													" + CRLF
	_cQuery += " 		'2','BRANCA',													" + CRLF
	_cQuery += " 		'4','NEGRA',													" + CRLF
	_cQuery += " 		'6','AMARELA',													" + CRLF
	_cQuery += " 		'8','PARDA',													" + CRLF
	_cQuery += " 		'9','NAO INFORMADO'												" + CRLF
	_cQuery += " 	) RACA,																" + CRLF
	_cQuery += " 	LOGCAB.PAISORIG PAISORIG,											" + CRLF
	_cQuery += " 	TRIM(SYA.YA_DESCR) DESCPAIS,										" + CRLF
	_cQuery += " 	NVL(TRIM(LOGCAB.SOCIAL),' ') SOCIAL,								" + CRLF
	_cQuery += " 	FORMATA_DATA_MS(LOGCAB.DTGRAVA) DTGRAVA,							" + CRLF
	_cQuery += " 	LOGCAB.HRGRAVA HRGRAVA,												" + CRLF
	_cQuery += " 	FORMATA_DATA_MS(LOGCAB.DTNEGA) DTNEGA,								" + CRLF
	_cQuery += " 	DECODE																" + CRLF
	_cQuery += " 		(																" + CRLF
	_cQuery += " 			NVL(LOGCAB.DTNEGA, ' '),									" + CRLF
	_cQuery += " 			' ','ALTERACAO','NEGOU ALTERACAO'							" + CRLF
	_cQuery += " 		) STATUS														" + CRLF
	_cQuery += " FROM																	" + CRLF
	
	If cEmpAnt == "01"
	
		_cQuery += " 	LOG_BAU_CABERJ LOGCAB											" + CRLF
	
	Else
	
		_cQuery += " 	LOG_BAU_INTEGRAL LOGCAB											" + CRLF
	
	EndIf
	
	_cQuery += " 	LEFT JOIN															" + CRLF
	_cQuery += " 		" + RetSqlName("SX5") + " SX5                      				" + CRLF
	_cQuery += " 	ON																	" + CRLF
	_cQuery += " 		SX5.X5_FILIAL = '" + xFilial("SX5") + "'						" + CRLF
	_cQuery += " 		AND SX5.X5_TABELA = '26'										" + CRLF
	_cQuery += " 		AND TRIM(SX5.X5_CHAVE) = TRIM(LOGCAB.GRAU)						" + CRLF
	_cQuery += " 		AND SX5.D_E_L_E_T_ = ' '										" + CRLF
	_cQuery += " 	LEFT JOIN															" + CRLF
	_cQuery += " 		" + RetSqlName("SYA") + " SYA                      				" + CRLF
	_cQuery += " 	ON																	" + CRLF
	_cQuery += " 		SYA.YA_FILIAL = '" + xFilial("SYA") + "'						" + CRLF
	_cQuery += " 		AND TRIM(SYA.YA_CODGI) = TRIM(LOGCAB.PAISORIG)					" + CRLF
	_cQuery += " 		AND SYA.D_E_L_E_T_ = ' '										" + CRLF
	_cQuery += " 	LEFT JOIN															" + CRLF
	_cQuery += "   		" + RetSqlName("BID") + " BID                      				" + CRLF
	_cQuery += " 	ON																	" + CRLF
	_cQuery += " 		BID.BID_FILIAL = '" + xFilial("BID") + "'						" + CRLF
	_cQuery += " 		AND TRIM(BID.BID_CODMUN) = TRIM(LOGCAB.MUNIC)					" + CRLF
	_cQuery += " 		AND BID.D_E_L_E_T_ = ' '										" + CRLF
	
	If !(Empty(MV_PAR01) .OR. Empty(MV_PAR02) .OR. Empty(MV_PAR03) .OR. Empty(MV_PAR04))
		
		_cQuery += " WHERE 																" + CRLF
		
		If !(Empty(MV_PAR01) .OR. Empty(MV_PAR02))
			
			_cQuery += " LOGCAB.CODIGO BETWEEN '" + MV_PAR01 + "' AND '" + MV_PAR02 + "'" + CRLF
			_lMv01 := .T.
			
		EndIf
		
		If !(Empty(MV_PAR03) .OR. Empty(MV_PAR04))
			
			If _lMv01
				
				_cQuery += " AND 														" + CRLF
				
			EndIf
			
			_cQuery += " LOGCAB.DTGRAVA BETWEEN '" + MV_PAR03 + "' AND '" + MV_PAR04 + "'" + CRLF
			
		EndIf
		
	EndIf
	
	_cQuery += " ORDER BY LOGCAB.CODIGO, LOGCAB.DTGRAVA, LOGCAB.HRGRAVA    				" + CRLF	
Return _cQuery


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABR257E  ºAutor  ³Angelo Henrique     º Data ³  08/05/18   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Rotina responsavel por gerar o relatório em CSV, pois       º±±
±±º          ³alguns usuários não possuem o Excel.                        º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CABERJ                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function CABR257E()
	
	Local _aArea 	:= GetArea()
	Local _cQuery	:= ""
	Local nHandle 	:= 0
	Local cNomeArq	:= ""
	Local cMontaTxt	:= ""
	
	Private _cAlias2	:= GetNextAlias()
	
	ProcRegua(RecCount())
	
	cNomeArq := "C:\TEMP\RELATORIO_LOG_PRESTADORES"
	cNomeArq += "_" + SUBSTR(DTOS(DATE()),7,2)
	cNomeArq += "_" + SUBSTR(DTOS(DATE()),5,2)
	cNomeArq += "_" + SUBSTR(DTOS(DATE()),1,4)
	cNomeArq += "_" + STRTRAN(TIME(),":","_") + ".csv"
	
	//---------------------------------------------
	//CABR244D Realiza toda a montagem da query
	//facilitando a manutenção do fonte
	//---------------------------------------------
	_cQuery := CABR257D()
	
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
				
				cMontaTxt := "CODIGO	; "
				cMontaTxt += "NOME		; "
				cMontaTxt += "FANTASIA	; "
				cMontaTxt += "NACIONAL	; "
				cMontaTxt += "CEP		; "
				cMontaTxt += "ENDERECO	; "
				cMontaTxt += "NUMERO	; "
				cMontaTxt += "COMPLEM	; "
				cMontaTxt += "BAIRRO	; "
				cMontaTxt += "MUNICIPIO	; "
				cMontaTxt += "ESTADO	; "
				cMontaTxt += "EMAIL		; "
				cMontaTxt += "TELEFONE	; "
				cMontaTxt += "SEXO		; "
				cMontaTxt += "GRAU		; "
				cMontaTxt += "RACA		; "
				cMontaTxt += "PAIS_ORIG	; "
				cMontaTxt += "SOCIAL	; "
				cMontaTxt += "DTGRAVAC	; "
				cMontaTxt += "HRGRAVAC	; "
				cMontaTxt += "DTNEGAC	; "
				cMontaTxt += "STATUS	; "
				
				cMontaTxt += CRLF // Salto de linha para .csv (excel)
				
				FWrite(nHandle,cMontaTxt)
				
			Else
				
				Aviso("Atenção","Não foi possível criar o relatório",{"OK"})
				Exit
				
			EndIf
			
		EndIf
		
		cMontaTxt := AllTrim((_cAlias2)->CODIGO			) + ";"
		cMontaTxt += AllTrim((_cAlias2)->NOME			) + ";"
		cMontaTxt += AllTrim((_cAlias2)->FANTASIA		) + ";"
		cMontaTxt += AllTrim((_cAlias2)->NACIONAL		) + ";"
		cMontaTxt += "'" + AllTrim((_cAlias2)->CEP		) + ";"
		cMontaTxt += AllTrim((_cAlias2)->ENDERECO		) + ";"
		cMontaTxt += "'" + AllTrim((_cAlias2)->NUMERO	) + ";"
		cMontaTxt += AllTrim((_cAlias2)->COMPLEM		) + ";"
		cMontaTxt += AllTrim((_cAlias2)->BAIRRO			) + ";"
		cMontaTxt += AllTrim((_cAlias2)->DSCMUN			) + ";"
		cMontaTxt += AllTrim((_cAlias2)->ESTADO			) + ";"
		cMontaTxt += AllTrim((_cAlias2)->EMAIL			) + ";"
		cMontaTxt += "'" + AllTrim((_cAlias2)->TELEFONE	) + ";"
		cMontaTxt += AllTrim((_cAlias2)->SEXO			) + ";"
		cMontaTxt += AllTrim((_cAlias2)->GRAU			) + ";"
		cMontaTxt += AllTrim((_cAlias2)->RACA			) + ";"
		cMontaTxt += AllTrim((_cAlias2)->DESCPAIS		) + ";"
		cMontaTxt += AllTrim((_cAlias2)->SOCIAL			) + ";"
		cMontaTxt += AllTrim((_cAlias2)->DTGRAVA		) + ";"
		cMontaTxt += "'" + AllTrim((_cAlias2)->HRGRAVA  ) + ";"
		cMontaTxt += AllTrim((_cAlias2)->DTNEGA			) + ";"
		cMontaTxt += AllTrim((_cAlias2)->STATUS			) + ";"
		
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