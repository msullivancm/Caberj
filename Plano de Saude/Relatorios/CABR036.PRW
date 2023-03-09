#INCLUDE "TOTVS.CH"
#INCLUDE "TOPCONN.CH"
#Include "MSGRAPHI.CH"
#Include "FILEIO.CH"

/*/{Protheus.doc} CABR036
Relatório para imprimir o log de envio de email CBC
@type function
@version  1.0
@author angelo.cassago
@since 15/07/2022
/*/
User Function CABR036()

	Local oReport   := NIL
	Local aArea     := GetArea()
	Private cPerg   := "CABR036"

	AjustaSx1(cPerg)

	IF !Pergunte(cPerg, .T.)
		Return
	Endif

	oReport:= ReportDef()
	oReport:PrintDialog()

	RestArea(aArea)

Return


/*/{Protheus.doc} ReportDef
Rotina que monta as colunas do relatório e o método TREPORT
@type function
@version  1.0
@author angelo.cassago
@since 15/07/2022
@return variant, Objeto do método
/*/
Static Function ReportDef()

	Local oSection2		:= Nil
	Local oReport		:= Nil
	Local cTit 			:= "Relatório de LOG de ENVIO CBC"

	cDesCRel := cTit

	//??????????????????????????????????????
	//?Criacao do componente de impressao                                     ?
	//?oReport():New                                                          ?
	//?ExpC1 : Nome do relatorio                                              ?
	//?ExpC2 : Titulo                                                         ?
	//?ExpC3 : Pergunte                                                       ?
	//?ExpB4 : Bloco de codigo que sera executado na confirmacao da impressao ?
	//?ExpC5 : Descricao                                                      ?
	//??????????????????????????????????????
	cDesl:= "Este relatorio tem como objetivo imprimir o relatório de LOG de ENVIO CBC."
	oReport:= TReport():New(cPerg,cTit,cPerg, {|oReport| ReportPrint(oReport)},cDescRel)
	oReport:SetLandScape()
	oReport:SetTotalInLine(.T.)

	Pergunte(oReport:uParam,.F.)

	oSection2 := TRSection():New(oReport,"Logs de Envio",{}, , ,) //"Documento"
	// Colunas do relatório
	TRCell():New(oSection2,"MATRICULA"			,,"MATRICULA"			, ""	,30	   	,  ,{|| (cAliasTRB)->MATRICULA			} ,"LEFT"  , ,"LEFT"  )
	TRCell():New(oSection2,"NOME"			    ,,"NOME"			    , ""	,150	,  ,{|| (cAliasTRB)->NOME			    } ,"LEFT"  , ,"LEFT"  )
	TRCell():New(oSection2,"PROTOCOLO_DE_ENVIO" ,,"PROTOCOLO_DE_ENVIO"  , ""	,40	   	,  ,{|| (cAliasTRB)->PROTOCOLOENVIO     } ,"LEFT"  , ,"LEFT"  )
	TRCell():New(oSection2,"DATA_ENVIO"         ,,"DATA_ENVIO"          , ""	,20	   	,  ,{|| (cAliasTRB)->DATAENVIO          } ,"LEFT"  , ,"LEFT"  )
	TRCell():New(oSection2,"HORA_ENVIO"         ,,"HORA_ENVIO"          , ""	,20	   	,  ,{|| (cAliasTRB)->HORAENVIO          } ,"LEFT"  , ,"LEFT"  )
	TRCell():New(oSection2,"USUARIO_ENVIO"      ,,"USUARIO_ENVIO"       , ""	,20	   	,  ,{|| (cAliasTRB)->USUARIOENVIO       } ,"LEFT"  , ,"LEFT"  )
	TRCell():New(oSection2,"EMAIL"				,,"EMAIL"				, ""	,250	,  ,{|| (cAliasTRB)->EMAIL				} ,"LEFT"  , ,"LEFT"  )
	TRCell():New(oSection2,"ASSUNTO"            ,,"ASSUNTO"             , ""	,250	,  ,{|| (cAliasTRB)->ASSUNTO            } ,"LEFT"  , ,"LEFT"  )
	TRCell():New(oSection2,"MENSAGEM"           ,,"MENSAGEM"            , ""	,500	,  ,{|| (cAliasTRB)->MENSAGEM           } ,"LEFT"  , ,"LEFT"  )

Return(oReport)

/*/{Protheus.doc} ReportPrint
Rotina para receber as informações da query
@type function
@version  1.0
@author angelo.cassago
@since 15/07/2022
@param oReport, object, objeto com as colunas e informações do método
/*/
Static Function ReportPrint(oReport)

	Local oSection2		:= Nil
	Local cQry 			:= " "

	Private cAliasTRB  	:= GETNEXTALIAS()
	Private aArea1  	:= {}

	oSection2 := oReport:Section(1)

	// Query para buscar os dados no banco
	cQry += " SELECT                                                                                    " + CRLF
	cQry += "     CBC.CODINT||CBC.CODEMP||CBC.MATRIC||CBC.TIPREG||CBC.DIGITO MATRICULA,                 " + CRLF
	cQry += "     TRIM(BA1.BA1_NOMUSR) NOME,                                                            " + CRLF
	cQry += "     CBC.PROTOCOLOENVIO,                                                                   " + CRLF
	cQry += "     FORMATA_DATA_MS(CBC.DATAENVIO) DATAENVIO,                                             " + CRLF
	cQry += "     CBC.USUARIOENVIO,                                                                     " + CRLF
	cQry += "     CBC.HORAENVIO,                                                                        " + CRLF
	cQry += "     CBC.EMAIL,                                                                            " + CRLF
	cQry += "     CBC.ASSUNTO,                                                                          " + CRLF
	cQry += "     CBC.MENSAGEM                                                                          " + CRLF
	cQry += " FROM                                                                                      " + CRLF
	cQry += "     LOG_ENV_EMAIL_CBC CBC                                                                 " + CRLF
	cQry += "                                                                                           " + CRLF
	cQry += "     INNER JOIN                                                                            " + CRLF
	cQry += "         " + RetSqlName("BA1") + " BA1                                                     " + CRLF
	cQry += "     ON                                                                                    " + CRLF
	cQry += "         BA1.BA1_FILIAL = '" + xFilial("BA1") + "'                                         " + CRLF
	cQry += "         AND BA1.BA1_CODINT = CBC.CODINT                                                   " + CRLF
	cQry += "         AND BA1.BA1_CODEMP = CBC.CODEMP                                                   " + CRLF
	cQry += "         AND BA1.BA1_MATRIC = CBC.MATRIC                                                   " + CRLF
	cQry += "         AND BA1.BA1_TIPREG = CBC.TIPREG                                                   " + CRLF
	cQry += "         AND BA1.BA1_DIGITO = CBC.DIGITO                                                   " + CRLF
	cQry += "         AND BA1.D_E_L_E_T_ = ' '                                                          " + CRLF
	cQry += " WHERE                                                                                     " + CRLF
	cQry += "     CBC.EMPRESA = '" + IIF(cEmpAnt = '01','CABERJ','INTEGRAL') + "'                       " + CRLF

	If !Empty(MV_PAR01) .And. !Empty(MV_PAR02)
		cQry += "     AND CBC.USUARI BETWEEN '" + MV_PAR01 + "' AND '" + MV_PAR02 + "'	                " + CRLF
	EndIf

	If !Empty(MV_PAR03) .And. !Empty(MV_PAR04)
		cQry += "     AND CBC.PROTOCOLOENVIO BETWEEN '" + MV_PAR03 + "' AND '" + MV_PAR04 + "'          " + CRLF
	EndIf

	If !Empty(MV_PAR05) .And. !Empty(MV_PAR05)
		cQry += "     AND cbc.dataenvio BETWEEN '" + DTOS(MV_PAR05) + "' AND '" + DTOS(MV_PAR06) + "'   " + CRLF
	EndIf

    cQry += " ORDER BY 4,6                                                                              " + CRLF

	dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQry),cAliasTRB,.T.,.T.)

	dbSelectArea(cAliasTRB)
	(cAliasTRB)->(dbgotop())

	oReport:SetMeter((cAliasTRB)->(LastRec()))

	//Imprime os dados do relatorio
	If (cAliasTRB)->(Eof())
		Alert("Não foram encontrados dados!")
	Else

		oSection2:Init()

		While  !(cAliasTRB)->(Eof())

			oReport:IncMeter()
			oSection2:PrintLine()

			(cAliasTRB)->(DbSkip())
		Enddo

		oReport:FatLine()
		oReport:Section(1):Finish()

		(cAliasTRB)->(DbCloseArea())

	EndIf

Return

/*/{Protheus.doc} AjustaSX1
Rotina que gera as perguntas do relatório
@type function
@version  1.0
@author angelo.cassago
@since 15/07/2022
@param cPerg, character, nome da pergunta
/*/
Static Function AjustaSX1(cPerg)

	Local aHelpPor	:= {}

	aHelpPor := {}
	AADD(aHelpPor,"Informe a Matricula:					")

	u_CABASX1(cPerg,"01","Matricula De:"	    ,"Matricula De"	        ,"Matricula De:"        ,"MV_CH1"	,"C",17 		            ,0,0,"G","","","","","MV_PAR01","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")
	u_CABASX1(cPerg,"02","Matricula Ate: "	    ,"Matricula Ate"        ,"Matricula Ate:"       ,"MV_CH2"	,"C",17 		            ,0,0,"G","","","","","MV_PAR02","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")

	aHelpPor := {}
	AADD(aHelpPor,"Informe a Matricula:					")

	u_CABASX1(cPerg,"03","Protocolo Envio De:"  ,"Protocolo Envio De"   ,"Protocolo Envio De"   ,"MV_CH3"	,"C",TamSX3("ZX_SEQ")[1]    ,0,0,"G","","","","","MV_PAR03","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")
	u_CABASX1(cPerg,"04","Protocolo Envio Ate: ","Protocolo Envio Ate"  ,"Protocolo Envio Ate"  ,"MV_CH4"	,"C",TamSX3("ZX_SEQ")[1] 	,0,0,"G","","","","","MV_PAR04","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")

	aHelpPor := {}
	AADD(aHelpPor,"Informe a Data de Transferencia:		")

	u_CABASX1(cPerg,"05","Data Envio De: "	    ,"Data Envio De"        ,"Data Envio De"        ,"MV_CH5"	,"D",TamSX3("ZX_DATDE")[1]  ,0,0,"G","","","","","MV_PAR05","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")
	u_CABASX1(cPerg,"06","Data Envio Ate:"      ,"Data Envio Ate"       ,"Data Envio Ate"       ,"MV_CH6"	,"D",TamSX3("ZX_DATDE")[1]  ,0,0,"G","","","","","MV_PAR06","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")

Return
