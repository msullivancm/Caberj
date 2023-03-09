#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'RWMAKE.CH'
#INCLUDE 'FONT.CH'
#INCLUDE 'COLORS.CH'
#INCLUDE "TBICONN.CH"
#INCLUDE "TOPCONN.CH"

Static cEOL := chr(13) + chr(10)


/*/{Protheus.doc} CABA618

Rotina Utilizada para exibir os relatÛrios de mensagem de quitaÁ„o

@Obs
As QUERY's foram copiadas das extraÁıes que a Analista Marcela Coimbra
encaminhava para o finandeiro

@type function
@author angelo.cassago
@since 26/12/2019
@version 1.0
/*/

User function CABA618()
	
	Local _nOpc	:= 0
	
	SetPrvt("oDlg1","oGrp1","oSay1","oSay2","oSay3","oSay4","oSay5","oSay6","oBtn1","oBtn2","oBtn3","oBtn4")
	SetPrvt("oBtn6")
	
	/*ƒƒƒƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ±±
	±± Definicao do Dialog e todos os seus componentes.                        ±±
	Ÿ±±¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ*/
	
	oDlg1      := MSDialog():New( 092,232,422,794,"Processo de Mensagem de QuitaÁ„o",,,.F.,,,,,,.T.,,,.T. )
	
	oGrp1      := TGroup():New( 004,004,152,272,"    Rotina de ExtraÁ„o do Processo de Mensagem de QuitaÁ„o       ",oDlg1,CLR_HBLUE,CLR_WHITE,.T.,.F. )
	
	oSay1      := TSay():New( 016,012,{||"Nesta tela ser· possÌvel  reitrar as seguintes informaÁıes:"											},oGrp1,,,.F.,.F.,.F.,.T.,CLR_HBLUE,CLR_WHITE,244,008)
	oSay2      := TSay():New( 028,012,{||"1 - Usu·rios que ir„o receber a mensagem de QuitaÁ„o"													},oGrp1,,,.F.,.F.,.F.,.T.,CLR_HBLUE,CLR_WHITE,152,008)
	oSay3      := TSay():New( 040,012,{||"2 - Usu·rios que N„o ir„o receber a mensagem de QuitaÁ„o"												},oGrp1,,,.F.,.F.,.F.,.T.,CLR_HBLUE,CLR_WHITE,156,008)
	oSay4      := TSay():New( 052,012,{||"3 - Usu·rios Novos que N„o ir„o receber a mensagem de QuitaÁ„o"										},oGrp1,,,.F.,.F.,.F.,.T.,CLR_HBLUE,CLR_WHITE,160,008)
	oSay5      := TSay():New( 064,012,{||"4 - Importar os Benefici·rios apÛs a validaÁ„o  para que os mesmos possam ter a mensagem de QuitaÁ„o"	},oGrp1,,,.F.,.F.,.F.,.T.,CLR_HBLUE,CLR_WHITE,252,008)
	oSay6      := TSay():New( 076,012,{||"5 - Apresentar Layout para ImportaÁ„o"																},oGrp1,,,.F.,.F.,.F.,.T.,CLR_HBLUE,CLR_WHITE,208,008)
	
	oBtn1      := TButton():New( 088,012,"1 - Usuarios Com Mensagem"		,oGrp1,{||U_CABA618A(1) },088,012,,,,.T.,,"",,,,.F. )
	oBtn2      := TButton():New( 088,108,"2 - Usuarios Sem Mensagem"		,oGrp1,{||U_CABA618A(2)	},088,012,,,,.T.,,"",,,,.F. )
	oBtn3      := TButton():New( 112,012,"3 - Usuarios Novos Sem Mensagem"	,oGrp1,{||U_CABA618A(3) },088,012,,,,.T.,,"",,,,.F. )
	oBtn4      := TButton():New( 112,108,"4 - Importar Benefici·rios "		,oGrp1,{||U_CABA618G() },088,012,,,,.T.,,"",,,,.F. )
	oBtn5      := TButton():New( 132,012,"5 - Layout"						,oGrp1,{||U_CABA618H()  },088,012,,,,.T.,,"",,,,.F. )
	oBtn6      := TButton():New( 132,108,"Fechar"							,oGrp1,{||oDlg1:End()	},088,012,,,,.T.,,"",,,,.F. )
	
	oDlg1:Activate(,,,.T.)
	
Return


/*/{Protheus.doc} CABR618A

Rotina Utilizada para exibir os seguintes RelatÛrios:
1 - Usuarios Com Mensagem
2 - Usuarios Sem Mensagem
3 - Usuarios Novos Sem Mensagem

@type function
@author angelo.cassago
@since 26/12/2019
@version 1.0
/*/
User Function CABA618A(_nOpc)
	
	Local oReport	:= Nil
	
	Private _nParam := _nOpc
	
	oReport := U_CABA618B(_nParam)
	oReport:PrintDialog()
	
Return

/*/{Protheus.doc} CABR618B

Rotina Utilizada para gerar as informaÁıes dos relatÛrios

@type function
@author angelo.cassago
@since 26/12/2019
@version 1.0
/*/
User Function CABA618B(_nParam)
	
	Local oReport		:= Nil
	Local oSection1 	:= Nil
	Local _cTitulo		:= ""
	Local _cPerg		:= ""
	
	//---------------------------------------------
	// 1 - Usuarios Com Mensagem
	// 2 - Usuarios Sem Mensagem
	// 3 - Usuarios Novos Sem Mensagem
	//---------------------------------------------
	
	If _nParam = 1
		
		_cTitulo := "Usuarios Com Mensagem de QuitaÁ„o"
		
	ElseIf _nParam = 2
		
		_cTitulo := "Usuarios Sem Mensagem de QuitaÁ„o"
		
	Else
		
		_cTitulo := "Usuarios Novos Sem Mensagem de QuitaÁ„o"
		
	EndIf
	
	oReport := TReport():New("CABA618",_cTitulo,_cPerg,{|oReport| CABA618C(oReport)},_cTitulo)
	
	oReport:SetLandScape()
	
	oReport:oPage:setPaperSize(9)
	
	//--------------------------------
	//Primeira linha do relatÛrio
	//--------------------------------
	oSection1 := TRSection():New(oReport,"QUITACAO","BA1, BA3, SE1, BM1")
	
	TRCell():New(oSection1,"TITULO" 		,"BA1")
	oSection1:Cell("TITULO"):SetAutoSize(.F.)
	oSection1:Cell("TITULO"):SetSize(50)
	
	TRCell():New(oSection1,"CPF_TITULAR" 	,"BA1")
	oSection1:Cell("CPF_TITULAR"):SetAutoSize(.F.)
	oSection1:Cell("CPF_TITULAR"):SetSize(30)
	
	TRCell():New(oSection1,"MATRICULA" 		,"BA1")
	oSection1:Cell("MATRICULA"):SetAutoSize(.F.)
	oSection1:Cell("MATRICULA"):SetSize(30)
	
	TRCell():New(oSection1,"NOME" 			,"BA1")
	oSection1:Cell("NOME"):SetAutoSize(.F.)
	oSection1:Cell("NOME"):SetSize(TAMSX3("BA1_NOMUSR")[1])
	
	TRCell():New(oSection1,"INCLUSAO " 		,"BA1")
	oSection1:Cell("INCLUSAO"):SetAutoSize(.F.)
	oSection1:Cell("INCLUSAO"):SetSize(20)
	
	TRCell():New(oSection1,"BLOQUEIO" 		,"BA1")
	oSection1:Cell("BLOQUEIO"):SetAutoSize(.F.)
	oSection1:Cell("BLOQUEIO"):SetSize(20)
	
	TRCell():New(oSection1,"PLANO" 			,"BA1")
	oSection1:Cell("PLANO"):SetAutoSize(.F.)
	oSection1:Cell("PLANO"):SetSize(40)
	
Return oReport

/*/{Protheus.doc} CABR618C

Rotina Utilizada para gerar as informaÁıes dos relatÛrios

@type function
@author angelo.cassago
@since 26/12/2019
@version 1.0
/*/
Static Function CABA618C(oReport)
	
	Local _aArea 		:= GetArea()
	Local _cQuery		:= ""
	
	Private oSection1 	:= oReport:Section(1)
	Private _cAlias1	:= GetNextAlias()
	
	//---------------------------------------------
	// 1 - Usuarios Com Mensagem
	// 2 - Usuarios Sem Mensagem
	// 3 - Usuarios Novos Sem Mensagem
	//---------------------------------------------
	If _nParam = 1
		
		_cQuery := CABA618D()
		
	ElseIf _nParam = 2
		
		_cQuery := CABA618E()
		
	Else
		
		_cQuery := CABA618F()
		
	EndIf
	
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
		
		oSection1:Cell("TITULO" 		):SetValue( (_cAlias1)->TITULO		)
		oSection1:Cell("CPF_TITULAR"	):SetValue( (_cAlias1)->CPF_TITULAR	)
		oSection1:Cell("MATRICULA" 		):SetValue( (_cAlias1)->MATRICULA	)
		oSection1:Cell("NOME" 			):SetValue( (_cAlias1)->NOME		)
		oSection1:Cell("INCLUSAO " 		):SetValue( (_cAlias1)->INCLUSAO	)
		oSection1:Cell("BLOQUEIO" 		):SetValue( (_cAlias1)->BLOQUEIO	)
		oSection1:Cell("PLANO" 			):SetValue( (_cAlias1)->PLANO		)
		
		oSection1:PrintLine()
		
		(_cAlias1)->(DbSkip())
		
	EndDo
	
	oSection1:Finish()
	
	If Select(_cAlias1) > 0
		(_cAlias1)->(DbCloseArea())
	EndIf
	
	RestArea(_aArea	 )
	
Return


/*/{Protheus.doc} CABA618D

Rotina Utilizada para montar a query de Usuarios Com Mensagem

@type function
@author angelo.cassago
@since 26/12/2019
@version 1.0
/*/
Static Function CABA618D
	
	Local _cQuery 		:= ""
	Local _cAnoBlq		:= cValToChar(Year(dDatabase)		) + "0401"
	Local _cMnsIni 		:= cValToChar(Year(dDatabase) - 1	) + "0101"
	Local _cMnsFim 		:= cValToChar(Year(dDatabase) - 1	) + "1231"
	
	_cQuery += " SELECT                                                                                                                             " 	+ CRLF
	_cQuery += "     DISTINCT                                                                                                                       " 	+ CRLF
	_cQuery += "     'COM MENSAGEM DE QUITACAO' TITULO,                                                                                             " 	+ CRLF
	_cQuery += "     BA1.BA1_CPFUSR CPF_TITULAR,                                                                                                    " 	+ CRLF
	_cQuery += "     BA1.BA1_CODINT||BA1.BA1_CODEMP||BA1.BA1_MATRIC||BA1.BA1_TIPREG MATRICULA,                                                      " 	+ CRLF
	_cQuery += "     TRIM(BA1.BA1_NOMUSR) NOME,                                                                                                     " 	+ CRLF
	_cQuery += "     SIGA.FORMATA_DATA_MS(BA1.BA1_DATINC) INCLUSAO,                                                                                 " 	+ CRLF
	_cQuery += "     SIGA.FORMATA_DATA_MS(BA1.BA1_DATBLO) BLOQUEIO,                                                                                 " 	+ CRLF
	_cQuery += "     RETORNA_DESC_PLANO_MS('C',BA1.BA1_CODINT,BA1.BA1_CODEMP,BA1.BA1_MATRIC,BA1.BA1_TIPREG) PLANO                                   " 	+ CRLF
	_cQuery += " FROM                                                                                                                               " 	+ CRLF
	_cQuery += "     " + RetSqlName("BA1") + " BA1                                                              									" 	+ CRLF
	_cQuery += "                                                                                                                                    " 	+ CRLF
	_cQuery += "     INNER JOIN                                                                                                                     " 	+ CRLF
	_cQuery += "     	 " + RetSqlName("BA3") + " BA3                                                              								" 	+ CRLF
	_cQuery += "     ON                                                                                                                             " 	+ CRLF
	_cQuery += "         BA3.BA3_FILIAL      = '" + xFilial("BA3" ) + "'                                                                            " 	+ CRLF
	_cQuery += "         AND BA3.BA3_CODINT  = BA1.BA1_CODINT                                                                                       " 	+ CRLF
	_cQuery += "         AND BA3.BA3_CODEMP  = BA1.BA1_CODEMP                                                                                       " 	+ CRLF
	_cQuery += "         AND BA3.BA3_MATRIC  = BA1.BA1_MATRIC                                                                                       " 	+ CRLF
	_cQuery += "     	 AND BA3.BA3_CODINT  = '0001'                                                                                               " 	+ CRLF
	_cQuery += "     	 AND BA3.BA3_CODEMP  IN ('0001', '0002', '0005', '5007')                                                                    " 	+ CRLF
	_cQuery += "     	 AND BA3.BA3_GRPCOB  IN ('0002','0003','0005','0009','1001','1002','1003','5007')                                           " 	+ CRLF
	_cQuery += "         AND BA3.D_E_L_E_T_  = ' '                                                                                                  " 	+ CRLF
	_cQuery += " WHERE                                                                                                                              " 	+ CRLF
	_cQuery += "     BA1.BA1_FILIAL          = '" + xFilial("BA1" ) + "'                                                                            " 	+ CRLF
	_cQuery += "     AND BA1.BA1_TIPUSU		 = 'T'																									" 	+ CRLF	
	_cQuery += "     AND (BA1.BA1_DATBLO     = ' ' OR BA1.BA1_DATBLO >= '" + _cAnoBlq + "')                                                         " 	+ CRLF
	_cQuery += "     AND BA1.D_E_L_E_T_ = ' '                                                                                                       " 	+ CRLF
	_cQuery += "     AND BA1.BA1_CPFUSR <> ' '                                                                                                      " 	+ CRLF
	_cQuery += "     AND BA1.BA1_CPFUSR NOT IN (                                                                                                    " 	+ CRLF
	_cQuery += "                             SELECT                                                                                                 " 	+ CRLF
	_cQuery += "                                 DISTINCT                                                                                           " 	+ CRLF
	_cQuery += "                                 BA1.BA1_CPFUSR                                                                                     " 	+ CRLF
	_cQuery += "                             FROM                                                                                                   " 	+ CRLF
	_cQuery += "     	 						 " + RetSqlName("SE1") + " SE1DP                                         							" 	+ CRLF
	_cQuery += "                                                                                                                                    " 	+ CRLF
	_cQuery += "                                 INNER JOIN                                                                                         " 	+ CRLF
	_cQuery += "     	 						 	" + RetSqlName("SE1") + " SE1FT                                         						" 	+ CRLF
	_cQuery += "                                 ON                                                                                                 " 	+ CRLF
	_cQuery += "                                     SE1FT.E1_FILIAL         = '" + xFilial("SE1" ) + "'                                            " 	+ CRLF
	_cQuery += "                                     AND SE1FT.E1_NUM        = SE1DP.E1_FATURA                                                      " 	+ CRLF
	_cQuery += "                                 	 AND SE1FT.E1_SALDO      <> 0                                                               	" 	+ CRLF
	_cQuery += "                                     AND SE1FT.D_E_L_E_T_    = ' '                                                                  " 	+ CRLF
	_cQuery += "                                                                                                                                    " 	+ CRLF
	_cQuery += "                                 INNER JOIN                                                                                         " 	+ CRLF
	_cQuery += "     	 						 	 " + RetSqlName("BM1") + " BM1                                         							" 	+ CRLF
	_cQuery += "                                 ON                                                                                                 " 	+ CRLF
	_cQuery += "                                     BM1.BM1_FILIAL          = '" + xFilial("BM1" ) + "'                                            " 	+ CRLF
	_cQuery += "                                     AND BM1.BM1_PREFIX      = SE1DP.E1_PREFIXO                                                     " 	+ CRLF
	_cQuery += "                                     AND BM1.BM1_NUMTIT      = SE1DP.E1_NUM                                                         " 	+ CRLF
	_cQuery += "                                     AND BM1.D_E_L_E_T_      = ' '                                                                  " 	+ CRLF
	_cQuery += "                                                                                                                                    " 	+ CRLF
	_cQuery += "                                 INNER JOIN                                                                                         " 	+ CRLF
	_cQuery += "     	 						 	 " + RetSqlName("BA1") + " BA1                                         							" 	+ CRLF
	_cQuery += "                                 ON                                                                                                 " 	+ CRLF
	_cQuery += "                                     BA1.BA1_FILIAL          = '" + xFilial("BA1" ) + "'                                            " 	+ CRLF
	_cQuery += "                                     AND BA1.BA1_CODINT      = BM1.BM1_CODINT                                                       " 	+ CRLF
	_cQuery += "                                     AND BA1.BA1_CODEMP      = BM1.BM1_CODEMP                                                       " 	+ CRLF
	_cQuery += "                                     AND BA1.BA1_MATRIC      = BM1.BM1_MATRIC                                                       " 	+ CRLF
	_cQuery += "                                     AND BA1.BA1_TIPREG      = '00'                                                                 " 	+ CRLF
	_cQuery += "                                     AND BA1.D_E_L_E_T_      = ' '                                                                  " 	+ CRLF
	_cQuery += "                             WHERE                                                                                                  " 	+ CRLF
	_cQuery += "                                 SE1DP.E1_FILIAL             = '" + xFilial("SE1" ) + "'                                            " 	+ CRLF
	_cQuery += "                                 AND SE1DP.E1_VENCREA        BETWEEN '" + _cMnsIni + "' AND '" + _cMnsFim + "'                      " 	+ CRLF
	_cQuery += "                                 AND SE1DP.E1_SALDO          = 0                                                                    " 	+ CRLF
	_cQuery += "                                 AND SE1DP.E1_TIPO           = 'DP'                                                                 " 	+ CRLF
	_cQuery += "                                 AND SE1DP.D_E_L_E_T_        = ' '                                                                  " 	+ CRLF
	_cQuery += "                                 AND EXISTS (                                                                                       " 	+ CRLF
	_cQuery += "                                             SELECT                                                                                 " 	+ CRLF
	_cQuery += "                                                 SE5.E5_NUMERO                                                                      " 	+ CRLF
	_cQuery += "                                             FROM                                                                                   " 	+ CRLF
	_cQuery += "     	 						 	 			 " + RetSqlName("SE5") + " SE5                                     					" 	+ CRLF
	_cQuery += "                                             WHERE                                                                                  " 	+ CRLF
	_cQuery += "                                                 SE5.E5_FILIAL       = '" + xFilial("SE5" ) + "'                                    " 	+ CRLF
	_cQuery += "                                                 AND SE5.E5_PREFIXO  = SE1DP.E1_PREFIXO                                             " 	+ CRLF
	_cQuery += "                                                 AND SE5.E5_NUMERO   = SE1DP.E1_NUM                                                 " 	+ CRLF
	_cQuery += "                                                 AND SE5.E5_PARCELA  = SE1DP.E1_PARCELA                                             " 	+ CRLF
	_cQuery += "                                                 AND SE5.E5_MOTBX    IN ('FAT','LIQ')                                               " 	+ CRLF
	_cQuery += "                                                 AND SE5.D_E_L_E_T_  = ' '                                                          " 	+ CRLF
	_cQuery += "                                                 AND NOT EXISTS (                                                                   " 	+ CRLF
	_cQuery += "                                                                 SELECT                                                             " 	+ CRLF
	_cQuery += "                                                                     SE51.E5_NUMERO                                                 " 	+ CRLF
	_cQuery += "                                                                 FROM                                                               " 	+ CRLF
	_cQuery += "     	 						 	 								 " + RetSqlName("SE5") + " SE51                             	" 	+ CRLF
	_cQuery += "                                                                 WHERE                                                              " 	+ CRLF
	_cQuery += "                                                                     SE51.E5_FILIAL      =  '" + xFilial("SE5" ) + "'               " 	+ CRLF
	_cQuery += "                                                                     AND SE51.D_E_L_E_T_ = ' '                                      " 	+ CRLF
	_cQuery += "                                                                     AND SE51.E5_PREFIXO = SE5.E5_PREFIXO                           " 	+ CRLF
	_cQuery += "                                                                     AND SE51.E5_NUMERO  = SE5.E5_NUMERO                            " 	+ CRLF
	_cQuery += "                                                                     AND SE51.E5_TIPO    = SE5.E5_TIPO                              " 	+ CRLF
	_cQuery += "                                                                     AND SE51.E5_SEQ     = SE5.E5_SEQ                               " 	+ CRLF
	_cQuery += "                                                                     AND SE51.E5_CLIFOR  = SE5.E5_CLIFOR                            " 	+ CRLF
	_cQuery += "                                                                     AND (SE51.E5_TIPODOC = 'ES' OR TRIM(SE51.E5_SITUACA)  = 'C')	" 	+ CRLF
	_cQuery += "                                                                 )                                                                  " 	+ CRLF
	_cQuery += "                                             )                                                                                      " 	+ CRLF
	_cQuery += "                                                                                                                                    " 	+ CRLF
	_cQuery += "                             UNION	                                                                                                " 	+ CRLF
	_cQuery += "                                                                                                                                    " 	+ CRLF
	_cQuery += "                                                                                                                                    " 	+ CRLF
	_cQuery += "                             SELECT                                                                                                 " 	+ CRLF
	_cQuery += "                                 DISTINCT                                                                                           " 	+ CRLF
	_cQuery += "                                 BA1I.BA1_CPFUSR                                                                                    " 	+ CRLF
	_cQuery += "                             FROM                                                                                                   " 	+ CRLF
	_cQuery += "     	 						 " + RetSqlName("SE1") + " SE1DP                                         							" 	+ CRLF
	_cQuery += "                                                                                                                                    " 	+ CRLF
	_cQuery += "                                 INNER JOIN                                                                                         " 	+ CRLF
	_cQuery += "     	 						 	 " + RetSqlName("BM1") + " BM1                                         							" 	+ CRLF
	_cQuery += "                                 ON                                                                                                 " 	+ CRLF
	_cQuery += "                                     BM1.BM1_FILIAL      = '" + xFilial("BM1" ) + "'                                                " 	+ CRLF
	_cQuery += "                                     AND BM1.BM1_PREFIX  = SE1DP.E1_PREFIXO                                                         " 	+ CRLF
	_cQuery += "                                     AND BM1.BM1_NUMTIT  = SE1DP.E1_NUM                                                             " 	+ CRLF
	_cQuery += "                                     AND BM1.D_E_L_E_T_  = ' '                                                                      " 	+ CRLF
	_cQuery += "                                                                                                                                    " 	+ CRLF
	_cQuery += "                                 INNER JOIN                                                                                         " 	+ CRLF
	_cQuery += "     	 						 	 " + RetSqlName("BA1I") + " BA1I                                       							" 	+ CRLF
	_cQuery += "                                 ON                                                                                                 " 	+ CRLF
	_cQuery += "                                     BA1I.BA1_FILIAL     = '" + xFilial("BA1" ) + "'                                                " 	+ CRLF
	_cQuery += "                                     AND BA1I.BA1_CODINT = BM1.BM1_CODINT                                                           " 	+ CRLF
	_cQuery += "                                     AND BA1I.BA1_CODEMP = BM1.BM1_CODEMP                                                           " 	+ CRLF
	_cQuery += "                                     AND BA1I.BA1_MATRIC = BM1.BM1_MATRIC                                                           " 	+ CRLF
	_cQuery += "                                     AND BA1I.BA1_TIPREG = '00'                                                                     " 	+ CRLF
	_cQuery += "                                                                                                                                    " 	+ CRLF
	_cQuery += "                             WHERE                                                                                                  " 	+ CRLF
	_cQuery += "                                 SE1DP.E1_FILIAL         = '" + xFilial("SE1" ) + "'                                                " 	+ CRLF
	_cQuery += "                                 AND SE1DP.E1_VENCREA    BETWEEN '" + _cMnsIni + "' AND '" + _cMnsFim + "'                          " 	+ CRLF
	_cQuery += "                                 AND SE1DP.E1_PREFIXO    = 'PLS'                                                                    " 	+ CRLF
	_cQuery += "                                 AND SE1DP.E1_CODEMP     IN ('0001', '0002', '0005', '5007')                                        " 	+ CRLF
	_cQuery += "                                 AND SE1DP.E1_SALDO      <> 0                                                                       " 	+ CRLF
	_cQuery += "                                 AND SE1DP.E1_TIPO       = 'DP'                                                                     " 	+ CRLF
	_cQuery += "                                 AND SE1DP.D_E_L_E_T_    = ' '                                                                      " 	+ CRLF
	_cQuery += "                             )                                                                                                      " 	+ CRLF
	
Return _cQuery


/*/{Protheus.doc} CABA618E

Rotina Utilizada para montar a query de Usuarios Sem Mensagem

@type function
@author angelo.cassago
@since 26/12/2019
@version 1.0
/*/
Static Function CABA618E
	
	Local _cQuery 		:= ""
	Local _cAnoBlq		:= cValToChar(Year(dDatabase)		) + "0401"
	Local _cMnsIni 		:= cValToChar(Year(dDatabase) - 1	) + "0101"
	Local _cMnsFim 		:= cValToChar(Year(dDatabase) - 1	) + "1231"
	
	_cQuery += " SELECT                                                                                                                                             " 	+ CRLF
	_cQuery += "     DISTINCT                                                                                                                                       " 	+ CRLF
	_cQuery += "     'SEM MENSAGEM DE QUITACAO' TITULO,                                                                                                             " 	+ CRLF
	_cQuery += "     BA1.BA1_CPFUSR CPF_TITULAR,                                                                                                                    " 	+ CRLF
	_cQuery += "     BA1.BA1_CODINT||BA1.BA1_CODEMP||BA1.BA1_MATRIC||BA1.BA1_TIPREG MATRICULA,                                                                      " 	+ CRLF
	_cQuery += "     TRIM(BA1.BA1_NOMUSR) NOME,                                                                                                                     " 	+ CRLF
	_cQuery += "     SIGA.FORMATA_DATA_MS(BA1.BA1_DATINC) INCLUSAO,                                                                                                 " 	+ CRLF
	_cQuery += "     SIGA.FORMATA_DATA_MS(BA1.BA1_DATBLO) BLOQUEIO,                                                                                                 " 	+ CRLF
	_cQuery += "     RETORNA_DESC_PLANO_MS('C',BA1.BA1_CODINT,BA1.BA1_CODEMP,BA1.BA1_MATRIC,BA1.BA1_TIPREG) PLANO                                                   " 	+ CRLF
	_cQuery += " FROM                                                                                                                                               " 	+ CRLF
	_cQuery += "     " + RetSqlName("BA1") + " BA1                                                              													" 	+ CRLF
	_cQuery += "                                                                                                                                                    " 	+ CRLF
	_cQuery += "     INNER JOIN                                                                                                                                     " 	+ CRLF
	_cQuery += "     	 " + RetSqlName("BA3") + " BA3                                                              												" 	+ CRLF
	_cQuery += "     ON                                                                                                                                             " 	+ CRLF
	_cQuery += "         BA3.BA3_FILIAL      = '" + xFilial("BA3" ) + "'                                                                                            " 	+ CRLF
	_cQuery += "         AND BA3.BA3_CODINT  = BA1.BA1_CODINT                                                                                                       " 	+ CRLF
	_cQuery += "         AND BA3.BA3_CODEMP  = BA1.BA1_CODEMP                                                                                                       " 	+ CRLF
	_cQuery += "         AND BA3.BA3_MATRIC  = BA1.BA1_MATRIC                                                                                                       " 	+ CRLF
	_cQuery += "     	 AND BA3.BA3_CODINT  = '0001'                                                                                                               " 	+ CRLF
	_cQuery += "     	 AND BA3.BA3_CODEMP  IN ('0001', '0002', '0005', '5007')                                                                                    " 	+ CRLF
	_cQuery += "     	 AND BA3.BA3_GRPCOB  IN ('0002','0003','0005','0009','1001','1002','1003','5007')                                                           " 	+ CRLF
	_cQuery += "         AND BA3.D_E_L_E_T_  = ' '                                                                                                                  " 	+ CRLF
	_cQuery += "                                                                                                                                                    " 	+ CRLF
	_cQuery += " WHERE                                                                                                                                              " 	+ CRLF
	_cQuery += "     BA1.BA1_FILIAL      	 = '" + xFilial("BA1" ) + "'                                                                                            " 	+ CRLF
	_cQuery += "     AND (BA1.BA1_DATBLO     = ' ' OR BA1.BA1_DATBLO >= '" + _cAnoBlq + "')                                                                         " 	+ CRLF
	_cQuery += "     AND BA1.D_E_L_E_T_      = ' '                                                                                                                  " 	+ CRLF
	_cQuery += "     AND BA1.BA1_CPFUSR      <> ' '                                                                                                                 " 	+ CRLF
	_cQuery += "     AND BA1.BA1_CPFUSR      IN (                                                                                                                   " 	+ CRLF
	_cQuery += "                                     SELECT                                                                                                         " 	+ CRLF
	_cQuery += "                                         DISTINCT                                                                                                   " 	+ CRLF
	_cQuery += "                                         BA1.BA1_CPFUSR                                                                                             " 	+ CRLF
	_cQuery += "                                                                                                                                                    " 	+ CRLF
	_cQuery += "                                     FROM                                                                                                           " 	+ CRLF
	_cQuery += "     									 " + RetSqlName("SE1") + " SE1DP	                                                              			" 	+ CRLF
	_cQuery += "                                                                                                                                                    " 	+ CRLF
	_cQuery += "                                         INNER JOIN                                                                                                 " 	+ CRLF
	_cQuery += "     										 " + RetSqlName("SE1") + " SE1FT                                                              			" 	+ CRLF
	_cQuery += "                                         ON                                                                                                         " 	+ CRLF
	_cQuery += "                                             SE1FT.E1_FILIAL         = '" + xFilial("SE1" ) + "'                                                    " 	+ CRLF
	_cQuery += "                                             AND SE1FT.E1_NUM        = SE1DP.E1_FATURA                                                              " 	+ CRLF
	_cQuery += "                                             AND SE1FT.D_E_L_E_T_    = ' '                                                                          " 	+ CRLF
	_cQuery += "                                                                                                                                                    " 	+ CRLF
	_cQuery += "                                         INNER JOIN                                                                                                 " 	+ CRLF
	_cQuery += "     										 " + RetSqlName("BM1") + " BM1                                                              			" 	+ CRLF
	_cQuery += "                                         ON                                                                                                         " 	+ CRLF
	_cQuery += "                                             BM1.BM1_FILIAL          = '" + xFilial("BM1" ) + "'                                                    " 	+ CRLF
	_cQuery += "                                             AND BM1.BM1_PREFIX      = SE1DP.E1_PREFIXO                                                             " 	+ CRLF
	_cQuery += "                                             AND BM1.BM1_NUMTIT      = SE1DP.E1_NUM                                                                 " 	+ CRLF
	_cQuery += "                                             AND BM1.D_E_L_E_T_      = ' '                                                                          " 	+ CRLF
	_cQuery += "                                                                                                                                                    " 	+ CRLF
	_cQuery += "                                         INNER JOIN                                                                                                 " 	+ CRLF
	_cQuery += "     										 " + RetSqlName("BA1") + " BA1                                                              			" 	+ CRLF
	_cQuery += "                                         ON                                                                                                         " 	+ CRLF
	_cQuery += "                                             BA1.BA1_FILIAL          = '" + xFilial("BA1" ) + "'                                                    " 	+ CRLF
	_cQuery += "                                             AND BA1.BA1_CODINT      = BM1.BM1_CODINT                                                               " 	+ CRLF
	_cQuery += "                                             AND BA1.BA1_CODEMP      = BM1.BM1_CODEMP                                                               " 	+ CRLF
	_cQuery += "                                             AND BA1.BA1_MATRIC      = BM1.BM1_MATRIC                                                               " 	+ CRLF
	_cQuery += "                                             AND BA1.BA1_TIPREG      = '00'                                                                         " 	+ CRLF
	_cQuery += "                                             AND BA1.D_E_L_E_T_      = ' '                                                                          " 	+ CRLF
	_cQuery += "                                     WHERE                                                                                                          " 	+ CRLF
	_cQuery += "                                         SE1DP.E1_FILIAL             = '" + xFilial("SE1" ) + "'                                                    " 	+ CRLF
	_cQuery += "                                         AND SE1DP.E1_VENCREA        BETWEEN '" + _cMnsIni + "' AND '" + _cMnsFim + "'                              " 	+ CRLF
	_cQuery += "                                         AND SE1DP.E1_SALDO          = 0                                                                            " 	+ CRLF
	_cQuery += "                                         AND SE1FT.E1_SALDO          <> 0                                                                           " 	+ CRLF
	_cQuery += "                                         AND SE1DP.E1_TIPO           = 'DP'                                                                         " 	+ CRLF
	_cQuery += "                                         AND SE1DP.D_E_L_E_T_        = ' '                                                                          " 	+ CRLF
	_cQuery += "                                         AND EXISTS (                                                                                               " 	+ CRLF
	_cQuery += "                                                         SELECT                                                                                     " 	+ CRLF
	_cQuery += "                                                             SE5.E5_NUMERO                                                                          " 	+ CRLF
	_cQuery += "                                                         FROM                                                                                       " 	+ CRLF
	_cQuery += "     										 				 " + RetSqlName("SE5") + " SE5                                                          " 	+ CRLF
	_cQuery += "                                                         WHERE                                                                                      " 	+ CRLF
	_cQuery += "                                                             SE5.E5_FILIAL       = '" + xFilial("SE5" ) + "'                                        " 	+ CRLF
	_cQuery += "                                                             AND SE5.E5_PREFIXO  = SE1DP.E1_PREFIXO                                                 " 	+ CRLF
	_cQuery += "                                                             AND SE5.E5_NUMERO   = SE1DP.E1_NUM                                                     " 	+ CRLF
	_cQuery += "                                                             AND SE5.E5_PARCELA  = SE1DP.E1_PARCELA                                                 " 	+ CRLF
	_cQuery += "                                                             AND SE5.E5_MOTBX    IN ('FAT','LIQ')                                                   " 	+ CRLF
	_cQuery += "                                                             AND SE5.D_E_L_E_T_  = ' '                                                              " 	+ CRLF
	_cQuery += "                                                             AND NOT EXISTS (                                                                       " 	+ CRLF
	_cQuery += "                                                                                 SELECT                                                             " 	+ CRLF
	_cQuery += "                                                                                     SE51.E5_NUMERO                                                 " 	+ CRLF
	_cQuery += "                                                                                 FROM                                                               " 	+ CRLF
	_cQuery += "     										 										 " + RetSqlName("SE5") + " SE51                                 " 	+ CRLF
	_cQuery += "                                                                                 WHERE                                                              " 	+ CRLF
	_cQuery += "                                                                                     SE51.E5_FILIAL          =  '" + xFilial("SE5" ) + "'           " 	+ CRLF
	_cQuery += "                                                                                     AND SE51.D_E_L_E_T_     = ' '                                  " 	+ CRLF
	_cQuery += "                                                                                     AND SE51.E5_PREFIXO     = SE5.E5_PREFIXO                       " 	+ CRLF
	_cQuery += "                                                                                     AND SE51.E5_NUMERO      = SE5.E5_NUMERO                        " 	+ CRLF
	_cQuery += "                                                                                     AND SE51.E5_TIPO        = SE5.E5_TIPO                          " 	+ CRLF
	_cQuery += "                                                                                     AND SE51.E5_SEQ         = SE5.E5_SEQ                           " 	+ CRLF
	_cQuery += "                                                                                     AND SE51.E5_CLIFOR      = SE5.E5_CLIFOR                        " 	+ CRLF
	_cQuery += "                                                                                     AND (SE51.E5_TIPODOC = 'ES' OR TRIM(SE5.E5_SITUACA)  = 'C')	" 	+ CRLF
	_cQuery += "                                                                           )                                                                        " 	+ CRLF
	_cQuery += "                                                     )                                                                                              " 	+ CRLF
	_cQuery += "                                                                                                                                                    " 	+ CRLF
	_cQuery += "                                     UNION	                                                                                                        " 	+ CRLF
	_cQuery += "                                                                                                                                                    " 	+ CRLF
	_cQuery += "                                     SELECT                                                                                                         " 	+ CRLF
	_cQuery += "                                         DISTINCT                                                                                                   " 	+ CRLF
	_cQuery += "                                             BA1I.BA1_CPFUSR                                                                                        " 	+ CRLF
	_cQuery += "                                     FROM                                                                                                           " 	+ CRLF
	_cQuery += "     									 " + RetSqlName("SE1") + " SE1DP                                                              				" 	+ CRLF
	_cQuery += "                                                                                                                                                    " 	+ CRLF
	_cQuery += "                                         INNER JOIN                                                                                                 " 	+ CRLF
	_cQuery += "     										 " + RetSqlName("BM1") + " BM1                                                              			" 	+ CRLF
	_cQuery += "                                         ON                                                                                                         " 	+ CRLF
	_cQuery += "                                             BM1.BM1_FILIAL          = '" + xFilial("BM1" ) + "'                                                    " 	+ CRLF
	_cQuery += "                                             AND BM1.BM1_PREFIX      = SE1DP.E1_PREFIXO                                                             " 	+ CRLF
	_cQuery += "                                             AND BM1.BM1_NUMTIT      = SE1DP.E1_NUM                                                                 " 	+ CRLF
	_cQuery += "                                             AND BM1.D_E_L_E_T_      = ' '                                                                          " 	+ CRLF
	_cQuery += "                                                                                                                                                    " 	+ CRLF
	_cQuery += "                                         INNER JOIN                                                                                                 " 	+ CRLF
	_cQuery += "     										 " + RetSqlName("BA1") + " BA1I                                                              			" 	+ CRLF
	_cQuery += "                                         ON                                                                                                         " 	+ CRLF
	_cQuery += "                                             BA1I.BA1_FILIAL         = '" + xFilial("BA1" ) + "'                                                    " 	+ CRLF
	_cQuery += "                                             AND BA1I.BA1_CODINT     = BM1.BM1_CODINT                                                               " 	+ CRLF
	_cQuery += "                                             AND BA1I.BA1_CODEMP     = BM1.BM1_CODEMP                                                               " 	+ CRLF
	_cQuery += "                                             AND BA1I.BA1_MATRIC     = BM1.BM1_MATRIC                                                               " 	+ CRLF
	_cQuery += "                                             AND BA1I.BA1_TIPREG     = '00'                                                                         " 	+ CRLF
	_cQuery += "                                                                                                                                                    " 	+ CRLF
	_cQuery += "                                     WHERE                                                                                                          " 	+ CRLF
	_cQuery += "                                         SE1DP.E1_FILIAL             = '" + xFilial("SE1" ) + "'                                                    " 	+ CRLF
	_cQuery += "                                         AND SE1DP.E1_VENCREA        BETWEEN '" + _cMnsIni + "' AND '" + _cMnsFim + "'                              " 	+ CRLF
	_cQuery += "                                         AND SE1DP.E1_PREFIXO        = 'PLS'                                                                        " 	+ CRLF
	_cQuery += "                                         AND SE1DP.E1_CODEMP         IN ('0001', '0002', '0005', '5007')                                            " 	+ CRLF
	_cQuery += "                                         AND SE1DP.E1_SALDO          <> 0                                                                           " 	+ CRLF
	_cQuery += "                                         AND SE1DP.E1_TIPO           = 'DP'                                                                         " 	+ CRLF
	_cQuery += "                                         AND SE1DP.D_E_L_E_T_        = ' '                                                                          " 	+ CRLF
	_cQuery += "                                 )                                                                                                                  " 	+ CRLF
	
Return _cQuery


/*/{Protheus.doc} CABA618F

Rotina Utilizada para montar a query de Usuarios Novos Sem Mensagem

@type function
@author angelo.cassago
@since 26/12/2019
@version 1.0
/*/
Static Function CABA618F
	
	Local _cQuery 		:= ""
	Local _cAnoBlq		:= cValToChar(Year(dDatabase)		) + "0401"
	Local _cMnsIni 		:= cValToChar(Year(dDatabase) - 1	) + "0101"
	Local _cMnsFim 		:= cValToChar(Year(dDatabase) - 1	) + "1231"
	
	_cQuery += " SELECT                                                                                                                                     " 	+ CRLF
	_cQuery += "     DISTINCT                                                                                                                               " 	+ CRLF
	_cQuery += "     'NOVOS NAO RECEBEM MENSAGEM' TITULO,                                                                                                   " 	+ CRLF
	_cQuery += "     BA1.BA1_CPFUSR CPF_TITULAR,                                                                                                            " 	+ CRLF
	_cQuery += "     BA1.BA1_CODINT||BA1.BA1_CODEMP||BA1.BA1_MATRIC||BA1.BA1_TIPREG MATRICULA,                                                              " 	+ CRLF
	_cQuery += "     TRIM(BA1.BA1_NOMUSR) NOME,                                                                                                             " 	+ CRLF
	_cQuery += "     SIGA.FORMATA_DATA_MS(BA1.BA1_DATINC) INCLUSAO,                                                                                         " 	+ CRLF
	_cQuery += "     SIGA.FORMATA_DATA_MS(BA1.BA1_DATBLO) BLOQUEIO,                                                                                         " 	+ CRLF
	_cQuery += "     RETORNA_DESC_PLANO_MS('C',BA1.BA1_CODINT,BA1.BA1_CODEMP,BA1.BA1_MATRIC,BA1.BA1_TIPREG) PLANO                                           " 	+ CRLF
	_cQuery += " FROM                                                                                                                                       " 	+ CRLF
	_cQuery += "     " + RetSqlName("BA1") + " BA1                                                              											" 	+ CRLF
	_cQuery += "                                                                                                                                            " 	+ CRLF
	_cQuery += "     INNER JOIN                                                                                                                             " 	+ CRLF
	_cQuery += "     	 " + RetSqlName("BA3") + " BA3                                                             											" 	+ CRLF
	_cQuery += "     ON                                                                                                                                     " 	+ CRLF
	_cQuery += "         BA3.BA3_FILIAL          = '" + xFilial("BA3" ) + "'                                                                                " 	+ CRLF
	_cQuery += "         AND BA3.BA3_CODINT      = BA1.BA1_CODINT                                                                                           " 	+ CRLF
	_cQuery += "         AND BA3.BA3_CODEMP      = BA1.BA1_CODEMP                                                                                           " 	+ CRLF
	_cQuery += "         AND BA3.BA3_MATRIC      = BA1.BA1_MATRIC                                                                                           " 	+ CRLF
	_cQuery += "     	 AND BA3.BA3_CODINT      = '0001'                                                                                                   " 	+ CRLF
	_cQuery += "     	 AND BA3.BA3_CODEMP      IN ('0001', '0002', '0005', '5007')                                                                        " 	+ CRLF
	_cQuery += "     	 AND BA3.BA3_GRPCOB      IN ('0002','0003','0005','0009','1001','1002','1003','5007')                                               " 	+ CRLF
	_cQuery += "         AND BA3.D_E_L_E_T_      = ' '                                                                                                      " 	+ CRLF
	_cQuery += "                                                                                                                                            " 	+ CRLF
	_cQuery += " WHERE                                                                                                                                      " 	+ CRLF
	_cQuery += "     BA1.BA1_FILIAL              = '" + xFilial("BA1" ) + "'                                                                                " 	+ CRLF
	_cQuery += "     AND (BA1.BA1_DATBLO         = ' ' OR BA1.BA1_DATBLO >= '" + _cAnoBlq + "')                                                             " 	+ CRLF
	_cQuery += "     AND BA1.D_E_L_E_T_          = ' '                                                                                                      " 	+ CRLF
	_cQuery += "     AND BA1.BA1_CPFUSR          <> ' '                                                                                                     " 	+ CRLF
	_cQuery += "     AND BA1.BA1_CPFUSR  IN (                                                                                                               " 	+ CRLF
	_cQuery += "                             SELECT                                                                                                         " 	+ CRLF
	_cQuery += "                                 DISTINCT                                                                                                   " 	+ CRLF
	_cQuery += "                                 BA1.BA1_CPFUSR                                                                                             " 	+ CRLF
	_cQuery += "                             FROM                                                                                                           " 	+ CRLF
	_cQuery += "     							 " + RetSqlName("SE1") + " SE1DP                                                              				" 	+ CRLF
	_cQuery += "                                                                                                                                            " 	+ CRLF
	_cQuery += "                                 INNER JOIN                                                                                                 " 	+ CRLF
	_cQuery += "     								 " + RetSqlName("SE1") + " SE1FT                                                              			" 	+ CRLF
	_cQuery += "                                 ON                                                                                                         " 	+ CRLF
	_cQuery += "                                     SE1FT.E1_FILIAL         = '" + xFilial("SE1" ) + "'                                                    " 	+ CRLF
	_cQuery += "                                     AND SE1FT.E1_NUM        = SE1DP.E1_FATURA                                                              " 	+ CRLF
	_cQuery += "                                     AND SE1FT.D_E_L_E_T_    = ' '                                                                          " 	+ CRLF
	_cQuery += "                                                                                                                                            " 	+ CRLF
	_cQuery += "                                 INNER JOIN                                                                                                 " 	+ CRLF
	_cQuery += "     								 " + RetSqlName("BM1") + " BM1                                                              			" 	+ CRLF
	_cQuery += "                                 ON                                                                                                         " 	+ CRLF
	_cQuery += "                                     BM1.BM1_FILIAL          = '" + xFilial("BM1" ) + "'                                                    " 	+ CRLF
	_cQuery += "                                     AND BM1.BM1_PREFIX      = SE1DP.E1_PREFIXO                                                             " 	+ CRLF
	_cQuery += "                                     AND BM1.BM1_NUMTIT      = SE1DP.E1_NUM                                                                 " 	+ CRLF
	_cQuery += "                                     AND BM1.D_E_L_E_T_      = ' '                                                                          " 	+ CRLF
	_cQuery += "                                                                                                                                            " 	+ CRLF
	_cQuery += "                                 INNER JOIN                                                                                                 " 	+ CRLF
	_cQuery += "     								 " + RetSqlName("BA1") + " BA1                                                             				" 	+ CRLF
	_cQuery += "                                 ON                                                                                                         " 	+ CRLF
	_cQuery += "                                     BA1.BA1_FILIAL          = '" + xFilial("BA1" ) + "'                                                 	" 	+ CRLF
	_cQuery += "                                     AND BA1.BA1_CODINT      = BM1.BM1_CODINT                                                            	" 	+ CRLF
	_cQuery += "                                     AND BA1.BA1_CODEMP      = BM1.BM1_CODEMP                                                            	" 	+ CRLF
	_cQuery += "                                     AND BA1.BA1_MATRIC      = BM1.BM1_MATRIC                                                            	" 	+ CRLF
	_cQuery += "                                     AND BA1.BA1_TIPREG      = '00'                                                                      	" 	+ CRLF
	_cQuery += "                                     AND BA1.D_E_L_E_T_      = ' '                                                                       	" 	+ CRLF
	_cQuery += "                             WHERE                                                                                                          " 	+ CRLF
	_cQuery += "                                 SE1DP.E1_FILIAL             = '" + xFilial("SE1" ) + "'                                                    " 	+ CRLF
	_cQuery += "                                 AND SE1DP.E1_VENCREA BETWEEN '" + _cMnsIni + "' AND '" + _cMnsFim + "'                                     " 	+ CRLF
	_cQuery += "                                 AND NOT (SE1FT.E1_VENCREA BETWEEN '" + _cMnsIni + "' AND '" + _cMnsFim + "')                               " 	+ CRLF
	_cQuery += "                                 AND SE1DP.E1_SALDO          = 0                                                                            " 	+ CRLF
	_cQuery += "                                 AND SE1FT.E1_SALDO          <> 0                                                                           " 	+ CRLF
	_cQuery += "                                 AND SE1DP.E1_TIPO           = 'DP'                                                                         " 	+ CRLF
	_cQuery += "                                 AND SE1DP.D_E_L_E_T_        = ' '                                                                          " 	+ CRLF
	_cQuery += "                                 AND EXISTS (                                                                                               " 	+ CRLF
	_cQuery += "                                                 SELECT                                                                                     " 	+ CRLF
	_cQuery += "                                                     SE5.E5_NUMERO                                                                          " 	+ CRLF
	_cQuery += "                                                 FROM                                                                                       " 	+ CRLF
	_cQuery += "     								 				 " + RetSqlName("SE5") + " SE5                                                			" 	+ CRLF
	_cQuery += "                                                 WHERE                                                                                      " 	+ CRLF
	_cQuery += "                                                     SE5.E5_FILIAL       = '" + xFilial("SE5" ) + "'                                        " 	+ CRLF
	_cQuery += "                                                     AND SE5.E5_PREFIXO  = SE1DP.E1_PREFIXO                                                 " 	+ CRLF
	_cQuery += "                                                     AND SE5.E5_NUMERO   = SE1DP.E1_NUM                                                     " 	+ CRLF
	_cQuery += "                                                     AND SE5.E5_PARCELA  = SE1DP.E1_PARCELA                                                 " 	+ CRLF
	_cQuery += "                                                     AND SE5.E5_MOTBX    IN ('FAT','LIQ')                                                   " 	+ CRLF
	_cQuery += "                                                     AND SE5.D_E_L_E_T_  = ' '                                                              " 	+ CRLF
	_cQuery += "                                                     AND NOT EXISTS (                                                                       " 	+ CRLF
	_cQuery += "                                                                         SELECT                                                             " 	+ CRLF
	_cQuery += "                                                                             SE51.E5_NUMERO                                                 " 	+ CRLF
	_cQuery += "                                                                         FROM                                                               " 	+ CRLF
	_cQuery += "     								 										 " + RetSqlName("SE5") + " SE51                                 " 	+ CRLF
	_cQuery += "                                                                         WHERE                                                              " 	+ CRLF
	_cQuery += "                                                                             SE51.E5_FILIAL          =  '" + xFilial("SE5" ) + "'           " 	+ CRLF
	_cQuery += "                                                                             AND SE51.D_E_L_E_T_     = ' '                                  " 	+ CRLF
	_cQuery += "                                                                             AND SE51.E5_PREFIXO     = SE5.E5_PREFIXO                       " 	+ CRLF
	_cQuery += "                                                                             AND SE51.E5_NUMERO      = SE5.E5_NUMERO                        " 	+ CRLF
	_cQuery += "                                                                             AND SE51.E5_TIPO        = SE5.E5_TIPO                          " 	+ CRLF
	_cQuery += "                                                                             AND SE51.E5_SEQ         = SE5.E5_SEQ                           " 	+ CRLF
	_cQuery += "                                                                             AND SE51.E5_CLIFOR      = SE5.E5_CLIFOR                        " 	+ CRLF
	_cQuery += "                                                                             AND (SE51.E5_TIPODOC    = 'ES' OR TRIM(SE5.E5_SITUACA)  = 'C')	" 	+ CRLF
	_cQuery += "                                                                     )                                                                      " 	+ CRLF
	_cQuery += "                                             )                                                                                              " 	+ CRLF
	_cQuery += "                                                                                                                                            " 	+ CRLF
	_cQuery += "                                                                                                                                            " 	+ CRLF
	_cQuery += "                             UNION                                                                                                          " 	+ CRLF
	_cQuery += "                                                                                                                                            " 	+ CRLF
	_cQuery += "                             SELECT                                                                                                         " 	+ CRLF
	_cQuery += "                                 DISTINCT                                                                                                   " 	+ CRLF
	_cQuery += "                                 BA1I.BA1_CPFUSR                                                                                            " 	+ CRLF
	_cQuery += "                             FROM                                                                                                           " 	+ CRLF
	_cQuery += "     							 " + RetSqlName("SE1") + " SE1DP	                                                              			" 	+ CRLF
	_cQuery += "                                                                                                                                            " 	+ CRLF
	_cQuery += "                                 INNER JOIN                                                                                                 " 	+ CRLF
	_cQuery += "     								 " + RetSqlName("BM1") + " BM1                                                              			" 	+ CRLF
	_cQuery += "                                 ON                                                                                                         " 	+ CRLF
	_cQuery += "                                     BM1.BM1_FILIAL = '" + xFilial("BM1" ) + "'                                                             " 	+ CRLF
	_cQuery += "                                     AND BM1.BM1_PREFIX = SE1DP.E1_PREFIXO                                                                  " 	+ CRLF
	_cQuery += "                                     AND BM1.BM1_NUMTIT = SE1DP.E1_NUM                                                                      " 	+ CRLF
	_cQuery += "                                     AND BM1.D_E_L_E_T_ = ' '                                                                               " 	+ CRLF
	_cQuery += "                                                                                                                                            " 	+ CRLF
	_cQuery += "                                 INNER JOIN                                                                                                 " 	+ CRLF
	_cQuery += "     								 " + RetSqlName("BA1") + " BA1I                                                              			" 	+ CRLF
	_cQuery += "                                 ON                                                                                                         " 	+ CRLF
	_cQuery += "                                     BA1I.BA1_FILIAL = '" + xFilial("BA1" ) + "'                                                            " 	+ CRLF
	_cQuery += "                                     AND BA1I.BA1_CODINT = BM1.BM1_CODINT                                                                   " 	+ CRLF
	_cQuery += "                                     AND BA1I.BA1_CODEMP = BM1.BM1_CODEMP                                                                   " 	+ CRLF
	_cQuery += "                                     AND BA1I.BA1_MATRIC = BM1.BM1_MATRIC                                                                   " 	+ CRLF
	_cQuery += "                                     AND BA1I.BA1_TIPREG = '00'                                                                             " 	+ CRLF
	_cQuery += "                                                                                                                                            " 	+ CRLF
	_cQuery += "                             WHERE                                                                                                          " 	+ CRLF
	_cQuery += "                                 SE1DP.E1_FILIAL = '" + xFilial("SE1" ) + "'                                                                " 	+ CRLF
	_cQuery += "                                 AND SE1DP.E1_VENCREA BETWEEN '" + _cMnsIni + "' AND '" + _cMnsFim + "'                                     " 	+ CRLF
	_cQuery += "                                 AND SE1DP.E1_PREFIXO = 'PLS'                                                                               " 	+ CRLF
	_cQuery += "                                 AND E1_CODEMP IN ('0001', '0002', '0005', '5007')                                                          " 	+ CRLF
	_cQuery += "                                 AND SE1DP.E1_SALDO <> 0                                                                                    " 	+ CRLF
	_cQuery += "                                 AND SE1DP.E1_TIPO = 'DP'                                                                                   " 	+ CRLF
	_cQuery += "                                 AND 1 = 2                                                                                                  " 	+ CRLF
	_cQuery += "                                 AND SE1DP.D_E_L_E_T_ = ' '                                                                                 " 	+ CRLF
	_cQuery += "                       )                                                                                                                    " 	+ CRLF
	
	MemoWrite( "c:\temp\CABA618F.sql" , _cQuery )
	
Return _cQuery


/*/{Protheus.doc} CABA618G

Rotina Utilizada para importar os benefici·rios que ir„o ter a mensagem exibida no boleto.

@type function
@author angelo.cassago
@since 26/12/2019
@version 1.0
/*/
User Function CABA618G
	
	Local aArea    		:= GetArea()
	Local cDescr		:= ""
	Local cFlag			:= .F.
	
	Private cProg       := "CABA618"
	Private cArqCSV		:= "C:\"
	Private nOpen		:= -1
	Private cDiretorio	:= " "
	Private oDlg		:= Nil
	Private oGet1		:= Nil
	Private oBtn1		:= Nil
	Private oGrp1		:= Nil
	Private oSay1		:= Nil
	Private oSBtn1		:= Nil
	Private oSBtn2		:= Nil
	Private oCombo		:= Nil
	Private nLinhaAtu  	:= 0
	Private cTrbPos
	Private lEnd	    := .F.
	Private _cTime		:= TIME()
	Private _aDadGrv	:= {}
	
	cDescr := "Este programa ir· importar os Benefici·rios que ir„o receber a Mensagem de QuitaÁ„o apartir de um arquivo CSV."
	
	oDlg              := MSDialog():New( 095,232,301,762,"ImportaÁ„o Benefici·rios Com Mensagem de QuitaÁ„o",,,.F.,,,,,,.T.,,,.T. )
	oGet1             := TGet():New( 062,020,{||cArqCSV},oDlg,206,008,,,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cArqCSV",,)
	oGet1:lReadOnly   := .T.
	
	oButton1          := TBrowseButton():New( 062,228,'...',oDlg,,022,011,,,.F.,.T.,.F.,,.F.,,,)
	
	*-----------------------------------------------------------------------------------------------------------------*
	*Buscar o arquivo no diretorio desejado.                                                                          *
	*Comando para selecionar um arquivo.                                                                              *
	*Parametro: GETF_LOCALFLOPPY - Inclui o floppy drive local.                                                       *
	*           GETF_LOCALHARD   - Inclui o Harddisk local.                                                           *
	*-----------------------------------------------------------------------------------------------------------------*
	
	oButton1:bAction  := {||cArqCSV := cGetFile("Arquivos CSV (*.CSV)|*.csv|","Selecione o .CSV a importar",1,cDiretorio,.T.,GETF_LOCALHARD)}
	oButton1:cToolTip := "Importar CSV"
	
	oGrp1             := TGroup():New( 008,020,050,252,"",oDlg,CLR_BLACK,CLR_WHITE,.T.,.F. )
	oSay1             := TSay():New( 016,028,{||cDescr},oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,226,030)
	oButton2          := tButton():New(082,092,'AvanÁar' ,oDlg,,35,15,,,,.T.)
	oButton2:bAction  := {||If(empty(cArqCSV) .or. right(allTrim(lower(cArqCSV)),4) != ".csv",MsgAlert("Informe um arquivo!"),(cFlag := .T.,oDlg:End()))}
	oButton2:cToolTip := "Ir para o prÛximo passo"
	
	oButton3          := tButton():New(082,144,'Cancelar',oDlg,,35,15,,,,.T.)
	oButton3:bAction  := {||cFlag := .F.,fClose(nOpen),oDlg:End()}
	oButton3:cToolTip := "Cancela a importaÁ„o"
	
	oDlg:Activate(,,,.T.)
	
	If cFlag == .T.
		Processa({|lEnd|ImportCSV(@lEnd, cArqCSV)},"Aguarde...","",.T.)
	EndIf
	
	RestArea(aArea)
	
	
Return



/*/{Protheus.doc} CABA618H

Rotina Utilizada para gerar o layout de importaÁ„o

@type function
@author angelo.cassago
@since 26/12/2019
@version 1.0
/*/
User Function CABA618H
	
	Local a_vet 	:= {}
	Local a_Cabec 	:= {}
	Local c_titulo	:= "Layout para ImportaÁ„o dos Beneficiarios que ter„o Mensagem de QuitaÁ„o"
	
	a_Cabec := {"CODINT", "CODEMP", "MATRIC", "TIPREG" }
	
	aadd(a_vet,{ "'" + '0001' , "'" + '0001' , "'" + '000001' , "'" + '01' })
	
	DlgToExcel({{"ARRAY", c_titulo, a_Cabec, a_vet}})
	
Return



/*/
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±…ÕÕÕÕÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÀÕÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÀÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÕÕÕª±±
±±∫Programa  ≥ ImportCSV  ∫ Autor ≥ Angelo Henrique    ∫ Data ≥  08/01/19 ∫±±
±±ÃÕÕÕÕÕÕÕÕÕÕÿÕÕÕÕÕÕÕÕÕÕ ÕÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕ ÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕÕÕπ±±
±±∫Descricao ≥ Efetua a importalÁao do arquivo .CSV                       ∫±±
±±ÃÕÕÕÕÕÕÕÕÕÕÿÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕπ±±
±±∫Uso       ≥ CABERJ                                                     ∫±±
±±»ÕÕÕÕÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕº±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
/*/

Static Function ImportCSV(lEnd,cArqCSV)
	
	Local cLinha 	:= ""
	Local nTotal	:= 0
	Local aStruc    := {}
	Local _ntot 	:= 0
	Local cArq    	:= Replace(UPPER(cArqCSV),".CSV","_LOG.TXT")
	Local nHandle 	:= FCreate(cArq)
	
	Private _nCod	:= 0
	Private _nEmp	:= 0
	Private _nMat	:= 0
	Private _nTip	:= 0
	
	Private _cTime	:= TIME() //Hora inicial da importaÁ„o
	Private aLinha	:= {}
	
	
	//--------------------------------------------------------------
	//Limpando a tabela antes de realizar a importaÁ„o
	//--------------------------------------------------------------
	_cQuery := " DELETE FROM SIGA.MATRICULA_QUITACAO " + cEOL
	
	If TcSqlExec(_cQuery ) < 0
		
		Aviso("AtenÁ„o","N„o foi possÌvel realizar a limpeza da tabela antes da importaÁ„o",{"OK"})
		
	Else
		
		//⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø
		//≥ Criacao do arquivo temporario...                                    ≥
		//¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ
		aAdd(aStruc,{"CAMPO","C",500,0})
		
		cTrbPos := CriaTrab(aStruc,.T.)
		
		If Select("TrbPos") <> 0
			TrbPos->(dbCloseArea())
		End
		
		DbUseArea(.T.,,cTrbPos,"TrbPos",.T.)
		
		lInicio 	:= .T.
		lCabecOk 	:= .T.
		
		//-------------------------------------------------
		// importa arquivo para tabela tempor·ria
		//-------------------------------------------------
		PLSAppTmp(cArqCSV)
		
		TRBPOS->(DbGoTop())
		
		If TRBPOS->(EOF())
			MsgStop("Arquivo Vazio!")
			TRBPOS->(DBCLoseArea())
			Close(oLeTxt)
			lRet := .F.
			Return
		End
		
		nTotal := TRBPOS->(LastRec()-1)
		
		ProcRegua(nTotal)
		
		TRBPOS->(DbGoTop())
		
		While !TRBPOS->(Eof())
			
			If lEnd
				MsgAlert("Interrompido pelo usu·rio","Aviso")
				Return
			EndIf
			
			++nLinhaAtu
			
			IncProc("Processando a Linha n˙mero " + allTrim(Str(nLinhaAtu-1)) + " De " + cValTochar(nTotal))
			
			//-----------------------------------------------------------------------
			// Faz a leitura da linha do arquivo e atribui a vari·vel cLinha
			//-----------------------------------------------------------------------
			cLinha := UPPER(TRBPOS->CAMPO)
			
			//-----------------------------------------------------------------------
			// Se ja passou por todos os registros da planilha CSV sai do while
			//-----------------------------------------------------------------------
			if Empty(cLinha) .OR. substring(cLinha,1,1) == ";"
				Exit
			EndIf
			
			//-----------------------------------------------------------------------
			// Transfoma todos os ";;" em "; ;", de modo que o StrTokArr ir· retornar
			// sempre um array com o n˙mero de colunas correto.
			//-----------------------------------------------------------------------
			cLinha := strTran(cLinha,";;","; ;")
			cLinha := strTran(cLinha,";;","; ;")
			
			//-----------------------------------------------------------------------
			// Para que o ˙ltimo item nunca venha vazio.
			//-----------------------------------------------------------------------
			cLinha += " ;"
			
			aLinha := strTokArr(cLinha,";")
			
			If lInicio
				lInicio := .F.
				IncProc("Lendo cabeÁalho...De: "+cValTochar(nTotal))
				
				if !lLeCabec(aLinha)
					MsgAlert("CabeÁalho inv·lido, favor verificar e reimportar","Aviso")
					Return
				else
					lCabecOk :=  .T.
				endif
				//-----------------------------------------------------------------------
				// N„o continua se o cabeÁalho n„o estiver Ok
				//-----------------------------------------------------------------------
				
			Else
				
				//-----------------------------------------------------------------------
				// n„o È linha em branco
				//-----------------------------------------------------------------------
				If len(aLinha) > 0
					
					*'-------------------------------------------------------------------'*
					*'FunÁ„o para gravar as informaÁıes do arquivo na tabela EMS_IMPORTA
					*'-------------------------------------------------------------------'*
					fProcDad(aLinha)
					
				EndIf
				
			EndIf
			
			TRBPOS->(dbskip())
			
		EndDo
		
		IncProc("Gravando arquivo de Log ")
		
		For _ntot := 1 To Len(_aDadGrv)
			
			If nHandle < 0
				
				MsgAlert("Erro durante criaÁ„o do arquivo de Log.")
				Exit
				
			Else
				
				IncProc("Gravando arquivo de Log " + cValToChar(_ntot) + " de " + cValTochar(nTotal))
				
				FWrite(nHandle, _aDadGrv[_ntot] + CRLF)
				
			EndIf
			
		Next _ntot
		
		//⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø
		//≥FClose - Comando que fecha o arquivo, liberando o uso para outros programas.                                       ≥
		//¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ
		FClose(nHandle)
		
		If MSGYESNO( "Deseja extrair em Excel as informaÁıes Gravadas?", "Gerar Excel ?" )
			
			GerExcel()
			
		EndIf
		
		Aviso("AtenÁ„o","ImportaÁ„o de lanÁamentos finalizada..",{"OK"})
		
	EndIf
	
Return

/*/
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±…ÕÕÕÕÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÀÕÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÀÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÕÕÕª±±
±±∫Programa  ≥ PLSAppTmp  ∫ Autor ≥ Angelo Henrique    ∫ Data ≥  08/01/19 ∫±±
±±ÃÕÕÕÕÕÕÕÕÕÕÿÕÕÕÕÕÕÕÕÕÕ ÕÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕ ÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕÕÕπ±±
±±∫Descricao ≥ Realiza o append do arquivo em uma tabela temporaria       ∫±±
±±ÃÕÕÕÕÕÕÕÕÕÕÿÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕπ±±
±±∫Uso       ≥ CABERJ                                                     ∫±±
±±»ÕÕÕÕÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕº±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
/*/

Static Function PLSAppTmp(cNomeArq)
	
	DbSelectArea("TRBPOS")
	Append From &(cNomeArq) SDF
	
Return

/*/
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±…ÕÕÕÕÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÀÕÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÀÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÕÕÕª±±
±±∫Programa  ≥ lLeCabec   ∫ Autor ≥ Angelo Henrique    ∫ Data ≥  08/01/19 ∫±±
±±ÃÕÕÕÕÕÕÕÕÕÕÿÕÕÕÕÕÕÕÕÕÕ ÕÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕ ÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕÕÕπ±±
±±∫Descricao ≥ Realiza a validaÁ„o do cabeÁalho                           ∫±±
±±ÃÕÕÕÕÕÕÕÕÕÕÿÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕπ±±
±±∫Uso       ≥ CABERJ                                                     ∫±±
±±»ÕÕÕÕÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕº±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
/*/

Static Function lLeCabec(aLinha)
	
	Local lRet 		:= .T.
	Local _ni		:= 0
	
	//------------------------------------------------------------------------------
	//Realizando o tratamento no cabeÁalho antes de executar as validaÁıes
	//------------------------------------------------------------------------------
	For _ni := 1 To Len(aLinha)
		
		aLinha[_ni] := u_SemAcento(UPPER(AllTrim(aLinha[_ni])))
		
	Next _ni
	
	_nCod	:= aScan(aLinha,{|x| Alltrim(UPPER(x)) == "CODINT" 	})
	_nEmp	:= aScan(aLinha,{|x| Alltrim(UPPER(x)) == "CODEMP" 	})
	_nMat	:= aScan(aLinha,{|x| Alltrim(UPPER(x)) == "MATRIC" 	})
	_nTip	:= aScan(aLinha,{|x| Alltrim(UPPER(x)) == "TIPREG" 	})
	
	if _nCod == 0
		lRet := .F.
	elseif _nEmp == 0
		lRet := .F.
	elseif _nMat == 0
		lRet := .F.
	elseif _nTip == 0
		lRet := .F.
	endif
	
Return lRet


/*
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±…ÕÕÕÕÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÀÕÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÀÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÕÕÕª±±
±±∫Programa  ≥fProcDad   ∫Autor  ≥ Angelo Henrique   ∫ Data ≥  08/01/19   ∫±±
±±ÃÕÕÕÕÕÕÕÕÕÕÿÕÕÕÕÕÕÕÕÕÕ ÕÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕ ÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕÕÕπ±±
±±∫Desc.     ≥ FunÁ„o para armazenar os dados lidos do arquivo no vetor   ∫±±
±±∫		     ≥ e gravar na BA1				 							  ∫±±
±±ÃÕÕÕÕÕÕÕÕÕÕÿÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕπ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
*/

Static Function fProcDad(aLinha)
	
	Local _aArea 	:= GetArea()
	Local _na		:= 0
	
	//-------------------------------------------------------------------------------
	//Antes de realizar a gravaÁ„o verificar se existem ainda caracteres especiais
	//-------------------------------------------------------------------------------
	For _na := 1 To Len(aLinha)
		
		aLinha[_na] := Replace(Replace(AllTrim(aLinha[_na]),'"',''),'=','')
		
	Next _na
	
	_cQuery := " INSERT INTO SIGA.MATRICULA_QUITACAO	" + cEOL
	_cQuery += " (										" + cEOL
	_cQuery += " 	CODINT    	, 						" + cEOL
	_cQuery += " 	CODEMP    	, 						" + cEOL
	_cQuery += " 	MATRIC  	, 						" + cEOL
	_cQuery += " 	TIPREG     	 						" + cEOL
	_cQuery += " )										" + cEOL
	_cQuery += " VALUES									" + cEOL
	_cQuery += " (										" + cEOL
	_cQuery += " 	'" + AllTrim(aLinha[_nCod])	+ "' ,	" + cEOL
	_cQuery += " 	'" + AllTrim(aLinha[_nEmp])	+ "' ,	" + cEOL
	_cQuery += " 	'" + AllTrim(aLinha[_nMat])	+ "' ,	" + cEOL
	_cQuery += " 	'" + AllTrim(aLinha[_nTip])	+ "' 	" + cEOL
	_cQuery += " )										" + cEOL
	_cQuery += " 										" + cEOL
	
	If TcSqlExec(_cQuery ) < 0
		
		Aviso("AtenÁ„o","N„o foi possÌvel importar os registros",{"OK"})
		
	EndIf
	
	RestArea(_aArea )
	
Return


/*/{Protheus.doc} CABA618

Rotina Utilizada para exibir os relatÛrios de mensagem de quitaÁ„o

@Obs
As QUERY's foram copiadas das extraÁıes que a Analista Marcela Coimbra
encaminhava para o finandeiro

@type function
@author angelo.cassago
@since 26/12/2019
@version 1.0
/*/
Static Function GerExcel()
	
	Local _cQuery 		:= ""
	Local a_vet 		:= {}
	Local a_Cabec 		:= {}
	Local c_titulo		:= "Benefici·rios que ir„o receber Mensagem de QuitaÁ„o"
	
	Private _cAlias2	:= GetNextAlias()
	
	a_Cabec := {"MATRICULA", "NOME"}
	
	_cQuery += " SELECT                                         " 	+ CRLF
	_cQuery += "     CODINT||CODEMP||MATRIC||TIPREG MATRICULA,	" 	+ CRLF
	_cQuery += "     TRIM(BA1.BA1_NOMUSR) NOME                  " 	+ CRLF
	_cQuery += " FROM                                           " 	+ CRLF
	_cQuery += "     SIGA.MATRICULA_QUITACAO MQUIT              " 	+ CRLF
	_cQuery += "                                                " 	+ CRLF
	_cQuery += "     INNER JOIN                                 " 	+ CRLF
	_cQuery += "         BA1010 BA1                             " 	+ CRLF
	_cQuery += "     ON                                         " 	+ CRLF
	_cQuery += "         BA1.BA1_CODINT      = MQUIT.CODINT     " 	+ CRLF
	_cQuery += "         AND BA1.BA1_CODEMP  = MQUIT.CODEMP     " 	+ CRLF
	_cQuery += "         AND BA1.BA1_MATRIC  = MQUIT.MATRIC     " 	+ CRLF
	_cQuery += "         AND BA1.BA1_TIPREG  = MQUIT.TIPREG     " 	+ CRLF
	
	
	If Select(_cAlias2) > 0
		(_cAlias2)->(DbCloseArea())
	EndIf
	
	DbUseArea(.T.,"TOPCONN",TcGenQry(,,_cQuery),_cAlias2,.T.,.T.)
		
	While !(_cAlias2)->(EOF())					
	
		aadd(a_vet,{ "'" + (_cAlias2)->MATRICULA , (_cAlias2)->NOME })
			
		(_cAlias2)->(DbSkip())
		
	EndDo
	
	DlgToExcel({{"ARRAY", c_titulo, a_Cabec, a_vet}})
	
	If Select(_cAlias2) > 0
		(_cAlias2)->(DbCloseArea())
	EndIf
	
Return