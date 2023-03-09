#INCLUDE "REPORT.CH"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "TOPCONN.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABR251   ºAutor  ³Angelo Henrique     º Data ³  18/04/18   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Relatório de Documentos Excluídos no banco de conhecimento º±±
±±º          ³tabela (AC9), trazendo assim o log.                         º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CABERJ                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function CABR251()
	
	Local _aArea 	:= GetArea()
	Local oReport	:= Nil
	
	//----------------------------------------------------
	//Validando se existe o Excel instalado na máquina
	//para não dar erro e o usuário poder visualizar em
	//outros programas como o LibreOffice
	//----------------------------------------------------
	If ApOleClient("MSExcel")
		
		oReport := CABR251A()
		oReport:PrintDialog()
		
	Else
		
		Processa({||CABR251D()},'Processando...')
		
	EndIf
	
	RestArea(_aArea)
	
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABR251A  ºAutor  ³Angelo Henrique     º Data ³  19/04/18   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Rotina que irá gerar as informações do relatório            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CABERJ                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function CABR251A
	
	Local oReport		:= Nil
	Local oSection1 	:= Nil
	
	oReport := TReport():New("CABR251","Documentos Excluidos",/*_cPerg*/,{|oReport| CABR244C(oReport)},"Documentos Excluidos")
	
	oReport:SetLandScape()
	
	oReport:oPage:setPaperSize(12)
	
	//--------------------------------
	//Primeira linha do relatório
	//--------------------------------
	oSection1 := TRSection():New(oReport,"AC9","AC9")
	
	TRCell():New(oSection1,"PROTOCOLO" 		,"AC9")
	oSection1:Cell("PROTOCOLO"):SetAutoSize(.F.)
	oSection1:Cell("PROTOCOLO"):SetSize(TAMSX3("AC9_CODENT")[1])
	
	TRCell():New(oSection1,"USUARIO_INCLUI" ,"AC9")
	oSection1:Cell("USUARIO_INCLUI"):SetAutoSize(.F.)
	oSection1:Cell("USUARIO_INCLUI"):SetSize(TAMSX3("AC9_XUSU")[1])
	
	TRCell():New(oSection1,"DATA_INCLUI" 	,"AC9")
	oSection1:Cell("DATA_INCLUI"):SetAutoSize(.F.)
	oSection1:Cell("DATA_INCLUI"):SetSize(12)
	
	TRCell():New(oSection1,"HORA_INCLUI" 	,"AC9")
	oSection1:Cell("HORA_INCLUI"):SetAutoSize(.F.)
	oSection1:Cell("HORA_INCLUI"):SetSize(8)
	
	TRCell():New(oSection1,"USUARIO_EXCLUI" ,"AC9")
	oSection1:Cell("USUARIO_EXCLUI"):SetAutoSize(.F.)
	oSection1:Cell("USUARIO_EXCLUI"):SetSize(TAMSX3("AC9_XUSUDE")[1])
	
	TRCell():New(oSection1,"DATA_EXCLUI" 	,"AC9")
	oSection1:Cell("DATA_EXCLUI"):SetAutoSize(.F.)
	oSection1:Cell("DATA_EXCLUI"):SetSize(12)
	
	TRCell():New(oSection1,"HORA_EXCLUI" 	,"AC9")
	oSection1:Cell("HORA_EXCLUI"):SetAutoSize(.F.)
	oSection1:Cell("HORA_EXCLUI"):SetSize(8)
	
	TRCell():New(oSection1,"DOCUMENTO" 		,"AC9")
	oSection1:Cell("DOCUMENTO"):SetAutoSize(.F.)
	oSection1:Cell("DOCUMENTO"):SetSize(TAMSX3("ACB_OBJETO")[1])
	
	TRCell():New(oSection1,"DESCRICAO" 		,"AC9")
	oSection1:Cell("DESCRICAO"):SetAutoSize(.F.)
	oSection1:Cell("DESCRICAO"):SetSize(TAMSX3("ACB_DESCRI")[1])
	
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

Static Function CABR244C(oReport)
	
	Local _aArea 		:= GetArea()
	Local _cQuery		:= ""
	
	Private oSection1 	:= oReport:Section(1)
	Private _cAlias1	:= GetNextAlias()
	
	//---------------------------------------------
	//CABR251C Realiza toda a montagem da query
	//facilitando a manutenção do fonte
	//---------------------------------------------
	_cQuery := CABR251C()
	
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
		
		oSection1:Cell("PROTOCOLO"		):SetValue( (_cAlias1)->PROTOCOLO	)
		oSection1:Cell("USUARIO_INCLUI"	):SetValue( (_cAlias1)->USU_INC		)
		oSection1:Cell("DATA_INCLUI"	):SetValue( (_cAlias1)->DT_INC		)
		oSection1:Cell("HORA_INCLUI"	):SetValue( (_cAlias1)->HR_INC		)
		oSection1:Cell("USUARIO_EXCLUI"	):SetValue( (_cAlias1)->USU_EXC		)
		oSection1:Cell("DATA_EXCLUI"	):SetValue( (_cAlias1)->DT_EXC		)
		oSection1:Cell("HORA_EXCLUI"	):SetValue( (_cAlias1)->HR_EXC		)
		oSection1:Cell("DOCUMENTO"		):SetValue( (_cAlias1)->DOCUMENTO	)
		oSection1:Cell("DESCRICAO"		):SetValue( (_cAlias1)->DESCRICAO	)		
		
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
±±ºPrograma  ³CABR251C  ºAutor  ³Angelo Henrique     º Data ³  24/10/16   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Rotina responsavel por tratar a query, facilitando assim    º±±
±±º          ³a manutenção do fonte.                                      º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CABERJ                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function CABR251C()
	
	Local _cQuery 	:= ""
	Local _cChvSZX	:= SZX->(ZX_FILIAL+ZX_SEQ+ZX_CODINT+ZX_CODEMP+ZX_MATRIC+ZX_TIPREG+ZX_DIGITO+DTOS(ZX_DATDE)+ZX_HORADE+DTOS(ZX_DATATE)+ZX_HORATE)
	
	_cQuery += " SELECT																								" + CRLF	
	_cQuery += " 	SUBSTR(AC9.AC9_CODENT,3,20) PROTOCOLO,															" + CRLF
	_cQuery += " 	UPPER(TRIM(AC9.AC9_XUSU)) USU_INC,																" + CRLF
	_cQuery += " 	FORMATA_DATA_MS(AC9.AC9_XDTINC) DT_INC,															" + CRLF
	_cQuery += " 	NVL2(TRIM(AC9.AC9_HRINC),SUBSTR(AC9.AC9_HRINC,1,2)||':'||SUBSTR(AC9.AC9_HRINC,3,2),' ') HR_INC,	" + CRLF
	_cQuery += " 	UPPER(TRIM(AC9.AC9_XUSUDE)) USU_EXC,															" + CRLF
	_cQuery += " 	FORMATA_DATA_MS(AC9.AC9_XDTEXC) DT_EXC,															" + CRLF
	_cQuery += " 	NVL2(TRIM(AC9.AC9_HREXC),SUBSTR(AC9.AC9_HREXC,1,2)||':'||SUBSTR(AC9.AC9_HREXC,3,2),' ') HR_EXC,	" + CRLF
	_cQuery += " 	TRIM(ACB.ACB_OBJETO) DOCUMENTO,																	" + CRLF
	_cQuery += " 	TRIM(ACB.ACB_DESCRI) DESCRICAO																	" + CRLF
	_cQuery += " FROM																								" + CRLF
	_cQuery += "    " + RetSqlName("AC9") + " AC9                      												" + CRLF	
	_cQuery += " 	INNER JOIN																						" + CRLF
	_cQuery += "     	" + RetSqlName("ACB") + " ACB                      											" + CRLF
	_cQuery += " 	ON																								" + CRLF
	_cQuery += " 		ACB.ACB_FILIAL = '" + xFilial("ACB") + "'													" + CRLF
	_cQuery += " 		AND ACB.ACB_CODOBJ = AC9.AC9_CODOBJ															" + CRLF
	_cQuery += " WHERE																								" + CRLF
	_cQuery += " 	AC9.AC9_FILIAL = '" + xFilial("AC9") + "'														" + CRLF
	_cQuery += " 	AND AC9.D_E_L_E_T_ = '*'																		" + CRLF
	_cQuery += " 	AND AC9.AC9_ENTIDA = 'SZX'																		" + CRLF
	_cQuery += " 	AND AC9.AC9_CODENT = '" + _cChvSZX + "'															" + CRLF
	_cQuery += " ORDER BY 1																							" + CRLF 
		
Return _cQuery

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABR251D  ºAutor  ³Angelo Henrique     º Data ³  19/04/18   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Rotina responsavel por gerar o relatório em CSV, pois       º±±
±±º          ³alguns usuários não possuem o Excel.                        º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CABERJ                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function CABR251D()
	
	Local _aArea 	:= GetArea()
	Local _cQuery	:= ""
	Local nHandle 	:= 0
	Local cNomeArq	:= ""
	Local cMontaTxt	:= ""
	
	Private _cAlias2	:= GetNextAlias()
	
	ProcRegua(RecCount())
	
	cNomeArq := "C:\TEMP\RELATORIO_LOG_DOCUMENTO_PA"
	cNomeArq += "_" + SUBSTR(DTOS(DATE()),7,2)
	cNomeArq += "_" + SUBSTR(DTOS(DATE()),5,2)
	cNomeArq += "_" + SUBSTR(DTOS(DATE()),1,4)
	cNomeArq += "_" + STRTRAN(TIME(),":","_") + ".csv"
	
	//---------------------------------------------
	//CABR244D Realiza toda a montagem da query
	//facilitando a manutenção do fonte
	//---------------------------------------------
	_cQuery := CABR251C()
	
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
				
				cMontaTxt := "PROTOCOLO ;"
				cMontaTxt += "USUARIO_INCLUI ;"
				cMontaTxt += "DATA_INCLUI ;"
				cMontaTxt += "HORA_INCLUI ;"
				cMontaTxt += "USUARIO_EXCLUI ;"
				cMontaTxt += "DATA_EXCLUI ;"
				cMontaTxt += "HORA_EXCLUI ;"
				cMontaTxt += "DOCUMENTO ;"
				cMontaTxt += "DESCRICAO ;"				
				
				cMontaTxt += CRLF // Salto de linha para .csv (excel)
				
				FWrite(nHandle,cMontaTxt)
				
			Else
				
				Aviso("Atenção","Não foi possível criar o relatório",{"OK"})
				Exit
				
			EndIf
			
		EndIf		
		
		cMontaTxt := AllTrim((_cAlias2)->PROTOCOLO	) + ";"
		cMontaTxt += AllTrim((_cAlias2)->USU_INC	) + ";"
		cMontaTxt += AllTrim((_cAlias2)->DT_INC		) + ";"
		cMontaTxt += AllTrim((_cAlias2)->HR_INC		) + ";"
		cMontaTxt += AllTrim((_cAlias2)->USU_EXC	) + ";"
		cMontaTxt += AllTrim((_cAlias2)->DT_EXC		) + ";"
		cMontaTxt += AllTrim((_cAlias2)->HR_EXC		) + ";"
		cMontaTxt += AllTrim((_cAlias2)->DOCUMENTO	) + ";"
		cMontaTxt += AllTrim((_cAlias2)->DESCRICAO	) + ";"
	
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