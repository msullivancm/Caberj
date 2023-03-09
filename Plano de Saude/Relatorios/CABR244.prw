#INCLUDE "REPORT.CH"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "TOPCONN.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABR244     ºAutor  ³Angelo Henrique   º Data ³  10/05/16   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Relatório do CBI                                            º±±
±±º          ³Este relatório também deve listar os arquivos deletados     º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CABERJ                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function CABR244()
	
	Local _aArea 	:= GetArea()
	Local oReport	:= Nil
	Private _cPerg	:= "CABR244"
	
	//Cria grupo de perguntas
	CABR244C(_cPerg)
	
	If Pergunte(_cPerg,.T.)
		
		//----------------------------------------------------
		//Validando se existe o Excel instalado na máquina
		//para não dar erro e o usuário poder visualizar em
		//outros programas como o LibreOffice
		//----------------------------------------------------
		If ApOleClient("MSExcel")
			
			oReport := CABR244A()
			oReport:PrintDialog()
			
		Else
			
			Processa({||CABR244E()},'Processando...')
			
		EndIf
		
	EndIf
	
	RestArea(_aArea)
	
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABR244A  ºAutor  ³Angelo Henrique     º Data ³  13/10/17   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Rotina que irá gerar as informações do relatório            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CABERJ                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function CABR244A
	
	Local oReport		:= Nil
	Local oSection1 	:= Nil
	
	oReport := TReport():New("CABR244","IMPORTACAO CBI",_cPerg,{|oReport| CABR244B(oReport)},"IMPORTACAO CBI")
	
	oReport:SetLandScape()
	
	oReport:oPage:setPaperSize(12)
	
	//--------------------------------
	//Primeira linha do relatório
	//--------------------------------
	oSection1 := TRSection():New(oReport,"ZZ0","ZZ0, BG9, ZZ1")
	
	TRCell():New(oSection1,"ARQUIVO" 		,"ZZ0") //01 -- ARQUIVO -- NOME DO ARQUIVO
	oSection1:Cell("ARQUIVO"):SetAutoSize(.F.)
	oSection1:Cell("ARQUIVO"):SetSize(TAMSX3("ZZ0_NOMARQ")[1])
	
	TRCell():New(oSection1,"COD_EMP" 		,"ZZ0") //02 -- COD_EMP -- CODIGO DA EMPRESA
	oSection1:Cell("COD_EMP"):SetAutoSize(.F.)
	oSection1:Cell("COD_EMP"):SetSize(TAMSX3("ZZ0_CODEMP")[1])
	
	TRCell():New(oSection1,"EMPRESA" 		,"BG9") //03 -- EMPRESA -- NOME REDUZIDO DA EMPRESA
	oSection1:Cell("EMPRESA"):SetAutoSize(.F.)
	oSection1:Cell("EMPRESA"):SetSize(TAMSX3("BG9_NREDUZ")[1])
	
	TRCell():New(oSection1,"CONTRATO" 		,"ZZ0") //04 -- CONTRATO -- NUMERO DO CONTRATO
	oSection1:Cell("CONTRATO"):SetAutoSize(.F.)
	oSection1:Cell("CONTRATO"):SetSize(TAMSX3("ZZ0_NUMCON")[1])
	
	TRCell():New(oSection1,"SUBCONTRATO" 	,"ZZ0") //05 -- SUBCONTRATO -- NUMERO DO SUBCONTRATO
	oSection1:Cell("SUBCONTRATO"):SetAutoSize(.F.)
	oSection1:Cell("SUBCONTRATO"):SetSize(TAMSX3("ZZ0_SUBCON")[1])
	
	TRCell():New(oSection1,"DT_IMPORTA" 	,"ZZ0") //06 -- DT_IMPORTA -- DATA DE IMPORTAÇÃO DO ARQUIVO
	oSection1:Cell("DT_IMPORTA"):SetAutoSize(.F.)
	oSection1:Cell("DT_IMPORTA"):SetSize(TAMSX3("ZZ0_DTIMPO")[1])
	
	TRCell():New(oSection1,"DT_CRIT"		,"ZZ0") //07 -- DT_CRIT -- DATA EM QUE O ARQUIVO FOI CRITICADO
	oSection1:Cell("DT_CRIT"):SetAutoSize(.F.)
	oSection1:Cell("DT_CRIT"):SetSize(TAMSX3("ZZ0_DTCRIT")[1])
	
	TRCell():New(oSection1,"DT_INSERI" 		,"ZZ0") //08 -- DT_INSERI -- DATA EM QUE O ARQUIVO FOI CRITICADO
	oSection1:Cell("DT_INSERI"):SetAutoSize(.F.)
	oSection1:Cell("DT_INSERI"):SetSize(TAMSX3("ZZ0_DTINSB")[1])
	
	TRCell():New(oSection1,"DELETADO" 		,"ZZ0") //09 -- DELETADO -- SE ESTA DELETADO OU NÃO NO SISTEMA
	oSection1:Cell("DELETADO"):SetAutoSize(.F.)
	oSection1:Cell("DELETADO"):SetSize(5)
	
	TRCell():New(oSection1,"USU_INCLUI" 	,"ZZ0") //10 -- USU_INCLUI -- USUARIO QUE REALIZOU A INCLUSÃO
	oSection1:Cell("USU_INCLUI"):SetAutoSize(.F.)
	oSection1:Cell("USU_INCLUI"):SetSize(TAMSX3("ZZ0_USUIMP")[1])
	
	TRCell():New(oSection1,"USU_EXCLUI"		,"ZZ0") //11 -- USU_EXCLUI -- USUARIO QUE REALIZOU A EXCLUSÃO
	oSection1:Cell("USU_EXCLUI"):SetAutoSize(.F.)
	oSection1:Cell("USU_EXCLUI"):SetSize(TAMSX3("ZZ0_USUEXC")[1])
	
	TRCell():New(oSection1,"DT_EXCLUI"		,"ZZ0") //12 -- DT_EXCLUI -- DATA QUE FOI EXCLUIDO
	oSection1:Cell("DT_EXCLUI"):SetAutoSize(.F.)
	oSection1:Cell("DT_EXCLUI"):SetSize(TAMSX3("ZZ0_DTEXC")[1])
	
	TRCell():New(oSection1,"STATUS"		,"ZZ0") //13 -- STATUS
	oSection1:Cell("STATUS"):SetAutoSize(.F.)
	oSection1:Cell("STATUS"):SetSize(TAMSX3("ZZ0_USUEXC")[1])
	
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

Static Function CABR244B(oReport,_cAlias1)
	
	Local _aArea 		:= GetArea()
	Local _cQuery		:= ""
	
	Private oSection1 	:= oReport:Section(1)
	Private _cAlias1	:= GetNextAlias()
	
	//---------------------------------------------
	//CABR244D Realiza toda a montagem da query
	//facilitando a manutenção do fonte
	//---------------------------------------------
	_cQuery := CABR244D()
	
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
		
		oSection1:Cell("ARQUIVO" 	):SetValue( (_cAlias1)->ARQUIVO		)//01 -- ARQUIVO 		-- NOME DO ARQUIVO
		oSection1:Cell("COD_EMP" 	):SetValue( (_cAlias1)->COD_EMP		)//02 -- COD_EMP 		-- CODIGO DA EMPRESA
		oSection1:Cell("EMPRESA" 	):SetValue( (_cAlias1)->EMPRESA		)//03 -- EMPRESA 		-- NOME REDUZIDO DA EMPRESA
		oSection1:Cell("CONTRATO" 	):SetValue( (_cAlias1)->CONTRATO	)//04 -- CONTRATO 		-- NUMERO DO CONTRATO
		oSection1:Cell("SUBCONTRATO"):SetValue( (_cAlias1)->SUBCONTRATO )//05 -- SUBCONTRATO 	-- NUMERO DO SUBCONTRATO
		oSection1:Cell("DT_IMPORTA" ):SetValue( (_cAlias1)->DT_IMPORTA	)//06 -- DT_IMPORTA 	-- DATA DE IMPORTAÇÃO DO ARQUIVO
		oSection1:Cell("DT_CRIT"	):SetValue( (_cAlias1)->DT_CRIT		)//07 -- DT_CRIT 		-- DATA EM QUE O ARQUIVO FOI CRITICADO
		oSection1:Cell("DT_INSERI" 	):SetValue( (_cAlias1)->DT_INSERI	)//08 -- DT_INSERI 		-- DATA EM QUE O ARQUIVO FOI CRITICADO
		oSection1:Cell("DELETADO" 	):SetValue( (_cAlias1)->DELETADO	)//09 -- DELETADO 		-- SE ESTA DELETADO OU NÃO NO SISTEMA
		oSection1:Cell("USU_INCLUI" ):SetValue( (_cAlias1)->USU_INCLUI	)//10 -- USU_INCLUI 	-- USUARIO QUE REALIZOU A INCLUSÃO
		oSection1:Cell("USU_EXCLUI"	):SetValue( (_cAlias1)->USU_EXCLUI	)//11 -- USU_EXCLUI 	-- USUARIO QUE REALIZOU A EXCLUSÃO
		oSection1:Cell("DT_EXCLUI"	):SetValue( (_cAlias1)->DT_EXC		)//12 -- DT_EXCLUI		-- DATA EM QUE O ARQUIVO FOI EXCLUÍDO
		oSection1:Cell("STATUS"		):SetValue( (_cAlias1)->STATUS		)//13 -- STATUS			-- STATUS EM QUE SE ENCONTRA O ARQUIVO
		
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
±±ºPrograma  ³CABR244C  ºAutor  ³Angelo Henrique     º Data ³  13/10/17   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Rotina responsavel pela geração das perguntas no relatório  º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CABERJ                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function CABR244C(cGrpPerg)
	
	Local aHelpPor := {} //help da pergunta
	
	aHelpPor := {}
	AADD(aHelpPor,"Informe o arquivo de 			")
	AADD(aHelpPor,"importação 						")
	AADD(aHelpPor,"Branco para todos				")
	
	PutSx1(cGrpPerg,"01","Arquivo: ?"				,"a","a","MV_CH1"	,"C",TamSX3("ZZ0_NOMARQ")[1]	,0,0,"G","",""		,"","","MV_PAR01","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")
	
	aHelpPor := {}
	AADD(aHelpPor,"Informe a Data Inicial de  		")
	AADD(aHelpPor,"Importação do arquivo	   	   	")
	
	PutSx1(cGrpPerg,"02","Data de Importação de: "	,"a","a","MV_CH2"	,"D",TamSX3("ZZ0_DTIMPO")[1]	,0,0,"G","",""		,"","","MV_PAR02","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")
	
	aHelpPor := {}
	AADD(aHelpPor,"Informe a Data Final de  		")
	AADD(aHelpPor,"Importação do arquivo	   	   	")
	
	PutSx1(cGrpPerg,"03","Data de Importação até: "	,"a","a","MV_CH3"	,"D",TamSX3("ZZ0_DTIMPO")[1]	,0,0,"G","",""		,"","","MV_PAR03","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")
	
	aHelpPor := {}
	AADD(aHelpPor,"Grupo/Empresa 					")
	AADD(aHelpPor,"Branco para todos          		")
	
	PutSx1(cGrpPerg,"04","Grupo/Empresa:"			,"a","a","MV_CH4"	,"C",TamSX3("BG9_CODIGO")[1]	,0,0,"G","","BG9"	,"","","MV_PAR04","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")
	
	
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABR244D  ºAutor  ³Angelo Henrique     º Data ³  24/10/16   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Rotina responsavel por tratar a query, facilitando assim    º±±
±±º          ³a manutenção do fonte.                                      º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CABERJ                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function CABR244D()
	
	Local _cQuery 	:= ""
	Local _lMvOk	:= .F.
	
	_cQuery += " SELECT																						" + CRLF
	_cQuery += "     TRIM(ZZ0.ZZ0_NOMARQ) ARQUIVO,                                                    		" + CRLF
	_cQuery += "     ZZ0.ZZ0_CODEMP COD_EMP,                                                          		" + CRLF
	_cQuery += "     BG9.BG9_NREDUZ EMPRESA,                                                          		" + CRLF
	_cQuery += "     TRIM(ZZ0.ZZ0_NUMCON) CONTRATO,                                                   		" + CRLF
	_cQuery += "     TRIM(ZZ0.ZZ0_SUBCON) SUBCONTRATO,                                                		" + CRLF
	_cQuery += "     SIGA.FORMATA_DATA_MS(ZZ0.ZZ0_DTIMPO) DT_IMPORTA,                                 		" + CRLF
	_cQuery += "     SIGA.FORMATA_DATA_MS(ZZ0.ZZ0_DTCRIT) DT_CRIT,                                    		" + CRLF
	_cQuery += "     SIGA.FORMATA_DATA_MS(ZZ0.ZZ0_DTINSB) DT_INSERI,                                  		" + CRLF
	_cQuery += "     DECODE(ZZ0.D_E_L_E_T_ ,' ','NAO','SIM') DELETADO,                                		" + CRLF
	_cQuery += "     NVL(TRIM(ZZ0.ZZ0_USUIMP),' ') USU_INCLUI,                                        		" + CRLF
	_cQuery += "     NVL(TRIM(ZZ0.ZZ0_USUEXC),' ') USU_EXCLUI,                                         		" + CRLF
	_cQuery += "     SIGA.FORMATA_DATA_MS(ZZ0.ZZ0_DTEXC) DT_EXC,                                      		" + CRLF
	_cQuery += "     DECODE	(                                       										" + CRLF
	_cQuery += "     			ZZ0_STATUS,                                       							" + CRLF
	_cQuery += "     			'1','IMPORTADO',                                       						" + CRLF
	_cQuery += "     			'2','ANALISADO SEM CRITICAS',                                       		" + CRLF
	_cQuery += "     			'3','ANALISADO COM CRITICAS',                                       		" + CRLF
	_cQuery += "     			'4','TOTALMENTE INSERIDO NA BASE',                                       	" + CRLF
	_cQuery += "     			'5','PARCIALMENTE INSERIDO NA BASE',                                       	" + CRLF
	_cQuery += "     			'6','ARQUIVO EXPORTADO'                                       				" + CRLF
	_cQuery += "     		) STATUS                                       									" + CRLF
	_cQuery += " FROM                                                                                 		" + CRLF
	_cQuery += "     " + RetSqlName("ZZ0") + " ZZ0                                                    		" + CRLF
	_cQuery += "     INNER JOIN                                                                       		" + CRLF
	_cQuery += "         " + RetSqlName("BG9") + " BG9                                                 		" + CRLF
	_cQuery += "     ON                                                                               		" + CRLF
	_cQuery += "         BG9.D_E_L_E_T_ = ' '                                                         		" + CRLF
	_cQuery += "         AND BG9.BG9_CODINT = ZZ0.ZZ0_CODOPE                                          		" + CRLF
	_cQuery += "         AND BG9.BG9_CODIGO = ZZ0.ZZ0_CODEMP                                          		" + CRLF
	
	If !Empty(MV_PAR01) .Or. !Empty(MV_PAR02) .And. !Empty(MV_PAR03) .Or. !Empty(MV_PAR04)
		
		_cQuery += " WHERE                                                                                		" + CRLF
		
	EndIf
	
	If !Empty(MV_PAR01)
		
		_cQuery += "     TRIM(ZZ0.ZZ0_NOMARQ) LIKE '%" + AllTrim(MV_PAR01) + "%'                          	" + CRLF
		_lMvOk	:= .T.
		
	EndIf
	
	If !Empty(MV_PAR02) .And. !Empty(MV_PAR03)
		
		If _lMvOk
			
			_cQuery += "     AND " + CRLF
			
		EndIf
		
		_cQuery += "     	ZZ0.ZZ0_DTIMPO BETWEEN '" + DTOS(MV_PAR02) + "' AND '" + DTOS(MV_PAR03) + "' 	" + CRLF
		
		_lMvOk	:= .T.
		
	EndIf
	
	If !Empty(MV_PAR04)
		
		If _lMvOk
			
			_cQuery += "     AND " + CRLF
			
		EndIf
		
		_cQuery += "     	ZZ0.ZZ0_CODEMP = '" + MV_PAR04 + "'                                            " + CRLF
		
	EndIf
	
Return _cQuery


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABR244E  ºAutor  ³Angelo Henrique     º Data ³  24/10/16   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Rotina responsavel por gerar o relatório em CSV, pois       º±±
±±º          ³alguns usuários não possuem o Excel.                        º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CABERJ                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function CABR244E()
	
	Local _aArea 	:= GetArea()
	Local _cQuery	:= ""
	Local nHandle 	:= 0
	Local cNomeArq	:= ""
	Local cMontaTxt	:= ""
	
	Private _cAlias2	:= GetNextAlias()
	
	ProcRegua(RecCount())
	
	cNomeArq := "C:\TEMP\RELATORIO_CBI"
	cNomeArq += "_" + SUBSTR(DTOS(DATE()),7,2)
	cNomeArq += "_" + SUBSTR(DTOS(DATE()),5,2)
	cNomeArq += "_" + SUBSTR(DTOS(DATE()),1,4)
	cNomeArq += "_" + STRTRAN(TIME(),":","_") + ".csv"
	
	//---------------------------------------------
	//CABR244D Realiza toda a montagem da query
	//facilitando a manutenção do fonte
	//---------------------------------------------
	_cQuery := CABR244D()
	
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
				
				cMontaTxt := "ARQUIVO ;"
				cMontaTxt += "COD_EMP ;"
				cMontaTxt += "EMPRESA ;"
				cMontaTxt += "CONTRATO ;"
				cMontaTxt += "SUBCONTRATO ;"
				cMontaTxt += "DT_IMPORTA ;"
				cMontaTxt += "DT_CRIT ;"
				cMontaTxt += "DT_INSERI ;"
				cMontaTxt += "DELETADO ;"
				cMontaTxt += "USU_INCLUI ;"
				cMontaTxt += "USU_EXCLUI ;"
				
				cMontaTxt += CRLF // Salto de linha para .csv (excel)
				
				FWrite(nHandle,cMontaTxt)
				
			Else
				
				Aviso("Atenção","Não foi possível criar o relatório",{"OK"})
				Exit
				
			EndIf
			
		EndIf
		
		cMontaTxt := AllTrim((_cAlias2)->ARQUIVO)     		+ ";"
		cMontaTxt += "'" + AllTrim((_cAlias2)->COD_EMP)     + ";"
		cMontaTxt += AllTrim((_cAlias2)->EMPRESA)     		+ ";"
		cMontaTxt += "'" + AllTrim((_cAlias2)->CONTRATO)    + ";"
		cMontaTxt += "'" + AllTrim((_cAlias2)->SUBCONTRATO) + ";"
		cMontaTxt += AllTrim((_cAlias2)->DT_IMPORTA)  		+ ";"
		cMontaTxt += AllTrim((_cAlias2)->DT_CRIT)     		+ ";"
		cMontaTxt += AllTrim((_cAlias2)->DT_INSERI)   		+ ";"
		cMontaTxt += AllTrim((_cAlias2)->DELETADO)    		+ ";"
		cMontaTxt += AllTrim((_cAlias2)->USU_INCLUI)  		+ ";"
		cMontaTxt += AllTrim((_cAlias2)->USU_EXCLUI)  		+ ";"
		
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