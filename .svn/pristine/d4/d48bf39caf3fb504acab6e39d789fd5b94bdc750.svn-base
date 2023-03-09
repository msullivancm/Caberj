#INCLUDE "TOTVS.CH"
#INCLUDE "TOPCONN.CH"
#Include "MSGRAPHI.CH"
#Include "FILEIO.CH"

/*/{Protheus.doc} CABR037
Relatório para imprimir o log de envio de email CBC
@type function
@version  1.0
@author angelo.cassago
@since 31/08/2022
/*/
User Function CABR037()

	Local oReport   := NIL
	Local aArea     := GetArea()
	Private cPerg   := "CABR037"

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
@since 31/08/2022
@return variant, Objeto do método
/*/
Static Function ReportDef()

	Local oSection2		:= Nil
	Local oReport		:= Nil
	Local cTit 			:= "Relatório de Beneficiarios CBC x CMB"

	cDesCRel            := cTit

	//??????????????????????????????????????
	//?Criacao do componente de impressao                                     ?
	//?oReport():New                                                          ?
	//?ExpC1 : Nome do relatorio                                              ?
	//?ExpC2 : Titulo                                                         ?
	//?ExpC3 : Pergunte                                                       ?
	//?ExpB4 : Bloco de codigo que sera executado na confirmacao da impressao ?
	//?ExpC5 : Descricao                                                      ?
	//??????????????????????????????????????
	cDesl:= "Este relatorio tem como objetivo imprimir o relatório de Beneficiarios CBC x CMB."
	oReport:= TReport():New(cPerg,cTit,cPerg, {|oReport| ReportPrint(oReport)},cDescRel)
	oReport:SetLandScape()
	oReport:SetTotalInLine(.T.)

	Pergunte(oReport:uParam,.F.)

	oSection2 := TRSection():New(oReport,"Beneficiarios CBC x CMB",{}, , ,) //"Documento"
	
    // Colunas do relatório
	TRCell():New(oSection2,"MATRICULA"			    ,,"MATRICULA"			    , "" ,30	,  ,{|| (cAliasTRB)->MATRICULA			} ,"LEFT"  , ,"LEFT"  )
	TRCell():New(oSection2,"NOME"			        ,,"NOME"			        , "" ,100	,  ,{|| (cAliasTRB)->NOME			    } ,"LEFT"  , ,"LEFT"  )
	TRCell():New(oSection2,"CPF"                    ,,"CPF"                     , "" ,20	,  ,{|| (cAliasTRB)->CPF                } ,"LEFT"  , ,"LEFT"  )
	TRCell():New(oSection2,"EMAIL"                  ,,"EMAIL"                   , "" ,100	,  ,{|| (cAliasTRB)->EMAIL              } ,"LEFT"  , ,"LEFT"  )
	TRCell():New(oSection2,"CONTATO"                ,,"CONTATO"                 , "" ,20	,  ,{|| (cAliasTRB)->CONTATO            } ,"LEFT"  , ,"LEFT"  )
    TRCell():New(oSection2,"TIPO_SERVICO"           ,,"TIPO_SERVICO"            , "" ,13    ,  ,{|| (cAliasTRB)->TIPO_SERVICO       } ,"LEFT"  , ,"LEFT"  )
    TRCell():New(oSection2,"SERVICO"                ,,"SERVICO"                 , "" ,20	,  ,{|| (cAliasTRB)->SERVICO            } ,"LEFT"  , ,"LEFT"  )
	TRCell():New(oSection2,"VIGENCIA_INICIAL"	    ,,"VIGENCIA_INICIAL"		, "" ,15	,  ,{|| (cAliasTRB)->VIGENCIA_INICIAL	} ,"LEFT"  , ,"LEFT"  )
	TRCell():New(oSection2,"VIGENCIA_FINAL"         ,,"VIGENCIA_FINAL"          , "" ,15	,  ,{|| (cAliasTRB)->VIGENCIA_FINAL     } ,"LEFT"  , ,"LEFT"  )
	TRCell():New(oSection2,"PROTOCOLO_DE_REGISTRO"  ,,"PROTOCOLO_DE_REGISTRO"   , "" ,25	,  ,{|| (cAliasTRB)->PROTOCOLO          } ,"LEFT"  , ,"LEFT"  )
	TRCell():New(oSection2,"OBSERVACAO"             ,,"OBSERVACAO"              , "" ,250	,  ,{|| (cAliasTRB)->OBS                } ,"LEFT"  , ,"LEFT"  )

Return(oReport)

/*/{Protheus.doc} ReportPrint
Rotina para receber as informações da query
@type function
@version  1.0
@author angelo.cassago
@since 31/08/2022
@param oReport, object, objeto com as colunas e informações do método
/*/
Static Function ReportPrint(oReport)

	Local oSection2		:= Nil
	Local cQry 			:= " "

	Private cAliasTRB  	:= GETNEXTALIAS()
	Private aArea1  	:= {}

	oSection2 := oReport:Section(1)

	// Query para buscar os dados no banco

	cQry += " SELECT                                                	" + CRLF
	cQry += "     PES.PES_USUARI MATRICULA,                         	" + CRLF
	cQry += "     TRIM(PES.PES_NOMUSR) NOME,                        	" + CRLF
	cQry += "     PES.PES_CPFUSR CPF,                               	" + CRLF
	cQry += "     TRIM(PES.PES_EMAIL)  EMAIL,                       	" + CRLF
	cQry += "     PES.PES_CONTAT CONTATO,                           	" + CRLF
	cQry += "     PES.PES_SERVIC TIPO_SERVICO,                      	" + CRLF
	cQry += "     PBL.PBL_YDSSRV SERVICO,                           	" + CRLF
	cQry += "     FORMATA_DATA_MS(PES.PES_INIVIG) VIGENCIA_INICIAL,		" + CRLF
	cQry += "     FORMATA_DATA_MS(PES.PES_FIMVIG) VIGENCIA_FINAL, 		" + CRLF
	cQry += "     PES.PES_PROTOC PROTOCOLO,                         	" + CRLF
	cQry += "     TRIM(PES.PES_OBS) OBS                             	" + CRLF
	cQry += " FROM                                                  	" + CRLF
	cQry += "     " + RETSQLNAME("PES") + " PES                         " + CRLF
	cQry += "                                                       	" + CRLF
	cQry += "     INNER JOIN                                        	" + CRLF
    cQry += "       " + RETSQLNAME("PBL") + " PBL                       " + CRLF	
	cQry += "     ON                                                	" + CRLF
	cQry += "         PBL_FILIAL = ' '                              	" + CRLF
	cQry += "         AND PBL.PBL_YCDSRV = PES.PES_SERVIC           	" + CRLF
	cQry += "         AND PBL.D_E_L_E_T_ = ' '                      	" + CRLF
	cQry += "                                                       	" + CRLF
	cQry += " WHERE                                                 	" + CRLF
	cQry += "     PES.PES_FILIAL = '" + xFilial("PES") + "'             " + CRLF
	
    If !Empty(MV_PAR01)
		cQry += "     AND PES.PES_USUARI = '" + MV_PAR01 + "'          						        " + CRLF
	EndIf

	If !Empty(MV_PAR02)
		cQry += "     AND PES.PES_SERVIC = '" + MV_PAR02 + "'                       		        " + CRLF
	EndIf

    If !Empty(MV_PAR03) .And. !Empty(MV_PAR04)
	cQry += "     AND PES.PES_INIVIG BETWEEN '" + DTOS(MV_PAR03) + "' AND '" + DTOS(MV_PAR04) + "'	" + CRLF
    EndIf

    If !Empty(MV_PAR05) .And. !Empty(MV_PAR06)
	cQry += "     AND PES.PES_FIMVIG BETWEEN '" + DTOS(MV_PAR05) + "' AND '" + DTOS(MV_PAR06) + "'  " + CRLF
    EndIf

	cQry += "     AND PES.D_E_L_E_T_ = ' '								                            " + CRLF	                  				

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
@since 31/08/2022
@param cPerg, character, nome da pergunta
/*/
Static Function AjustaSX1(cPerg)

	Local aHelpPor	:= {}

	aHelpPor := {}
	AADD(aHelpPor,"Informe a Matricula:			    ")

	u_CABASX1(cPerg,"01","Matricula: "	    ,"Matricula:"	        ,"Matricula:"           ,"MV_CH1"	,"C",17 		                ,0,0,"G","","","","","MV_PAR01","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")

	aHelpPor := {}
	AADD(aHelpPor,"Informe o tipo de servico:					")

	u_CABASX1(cPerg,"02","Tipo de Servico:" ,"Tipo de Servico:"     ,"Tipo de Servico:"     ,"MV_CH2"	,"C",TamSX3("PES_SERVIC")[1]    ,0,0,"G","","","","","MV_PAR02","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")

	aHelpPor := {}
	AADD(aHelpPor,"Informe a Vigencia Inicial:		")

	u_CABASX1(cPerg,"03","Vig. Inicial De: ","Vig. Inicial De: "    ,"Vig. Inicial De: "    ,"MV_CH3"	,"D",TamSX3("PES_INIVIG")[1]    ,0,0,"G","","","","","MV_PAR03","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")
	u_CABASX1(cPerg,"04","Vig. Inicial Ate:","Vig. Inicial Ate:"    ,"Vig. Inicial Ate:"    ,"MV_CH4"	,"D",TamSX3("PES_INIVIG")[1]    ,0,0,"G","","","","","MV_PAR04","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")

	aHelpPor := {}
	AADD(aHelpPor,"Informe a Vegencia final:		")

	u_CABASX1(cPerg,"05","Vig. Final De: "  ,"Vig. Final De:"       ,"Vig. Final De:"       ,"MV_CH5"	,"D",TamSX3("PES_FIMVIG")[1]    ,0,0,"G","","","","","MV_PAR05","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")
	u_CABASX1(cPerg,"06","Vig. Final Ate:"  ,"Vig. Final Ate:"      ,"Vig. Final Ate:"      ,"MV_CH6"	,"D",TamSX3("PES_FIMVIG")[1]    ,0,0,"G","","","","","MV_PAR06","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")

Return
