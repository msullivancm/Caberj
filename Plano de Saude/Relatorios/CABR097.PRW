#INCLUDE "PROTHEUS.CH"
#INCLUDE "TOPCONN.CH"
#INCLUDE "REPORT.CH"

/*/{Protheus.doc} CABR097
Relatório de extrato de utilização, mostrando os procedimentos 
quantidade e valores.

Nome do relatório: Relatorio Faturamento Associado Por Familia

---------------------------------------------------------------
Informações
---------------------------------------------------------------
Este relatório esta sendo modificado para atender a nova 
demanda/necessidade do financeiro

Para verificar a versão anterior favor olhar no SVN
---------------------------------------------------------------	
	
@type function
@version 2.0 
@author angelo.cassago
@since 05/10/2022
/*/
User Function CABR097()

	Local _aArea 		:= GetArea()
	Local oReport		:= Nil

	Private _cPerg	:= "CABR097"

	//Cria grupo de perguntas
	CABR097C(_cPerg)

	If Pergunte(_cPerg,.T.)

		oReport := CABR097A()
		oReport:PrintDialog()

	EndIf

	RestArea(_aArea)

Return

/*/{Protheus.doc} CABR097A
Rotina que irá gerar as informações do relatório
@type function
@version  2.0
@author angelo.cassago
@since 05/10/2022
/*/
Static Function CABR097A

	Local oReport	:= Nil
	Local oSection1 := Nil
	Local oSection2	:= Nil
	Local oSection3	:= Nil
	Local oSection4	:= Nil
	Local oSection5	:= Nil
	Local oSection6	:= Nil

	oReport := TReport():New("CABR097","Relatório Faturamento Associado Por Familia",_cPerg,{|oReport| CABR097B(oReport)},"Relatório Faturamento Associado Por Familia")

	oReport:SetLandScape()

	oReport:oPage:setPaperSize(12)

	//--------------------------------
	//Primeira linha do relatório
	//--------------------------------
	oSection1 := TRSection():New(oReport,"EMPRESA","BG9")

	TRCell():New(oSection1,"CODEMP" 	,"BG9","CODIGO EMPRESA"			,						,,,,,,,,,,,,,,,,,,)
	oSection1:Cell("CODEMP"):SetAutoSize(.F.)
	oSection1:Cell("CODEMP"):SetSize(20)

	TRCell():New(oSection1,"NREDUZ" 	,"BG9","DESCRIÇÃO"				,						,,,,,,,,,,,,,,,,,,)
	oSection1:Cell("NREDUZ"):SetAutoSize(.F.)
	oSection1:Cell("NREDUZ"):SetSize(30)

	//--------------------------------
	//Segunda linha do relatório
	//--------------------------------
	oSection2 := TRSection():New(oSection1,"CONTRATO - SUBCONTRATO","BM1,BQC")

	TRCell():New(oSection2,"CONT" 		,"BM1","CONTRATO"				,						,,,,,,,,,,,,,,,,,,)
	oSection2:Cell("CONT"):SetAutoSize(.F.)
	oSection2:Cell("CONT"):SetSize(14)

	TRCell():New(oSection2,"SUBCON" 	,"BM1","SUBCONTRATO"			,						,,,,,,,,,,,,,,,,,,)
	oSection2:Cell("SUBCON"):SetAutoSize(.F.)
	oSection2:Cell("SUBCON"):SetSize(14)

	TRCell():New(oSection2,"DESCSUB" 	,"BQC","DESCRICAO"				,						,,,,,,,,,,,,,,,,,,)
	oSection2:Cell("DESCSUB"):SetAutoSize(.F.)
	oSection2:Cell("DESCSUB"):SetSize(30)

	//--------------------------------
	//Terceira linha do relatório
	//--------------------------------
	oSection3 := TRSection():New(oSection2,"INFORMAÇÕES BENEFICIÁRIO","BA1,BD6,BAU")

	TRCell():New(oSection3,"MATRIC"		,"BA1","MATRICULA"				,						,,,,,,,,,,,,,,,,,,)
	oSection3:Cell("MATRIC"):SetAutoSize(.F.)
	oSection3:Cell("MATRIC"):SetSize(20)

	TRCell():New(oSection3,"NOME" 		,"BA1","NOME BENEFICIARIO"		,						,,,,,,,,,,,,,,,,,,)
	oSection3:Cell("NOME"):SetAutoSize(.F.)
	oSection3:Cell("NOME"):SetSize(40)

	TRCell():New(oSection3,"TIPUSU" 		,"BA1","TIPO BENEFICIARIO"	,						,,,,,,,,,,,,,,,,,,)
	oSection3:Cell("TIPUSU"):SetAutoSize(.F.)
	oSection3:Cell("TIPUSU"):SetSize(18)

	//----------------------------------------
	//Realtório Analítico ou Sintético
	//----------------------------------------
	If mv_par11 = 1 //Analitico

		TRCell():New(oSection3,"PREST" 		,"BAU","NOME PRESTADOR"			,						,,,,,,,,,,,,,,,,,,)
		oSection3:Cell("PREST"):SetAutoSize(.F.)
		oSection3:Cell("PREST"):SetSize(40)

		TRCell():New(oSection3,"DATPRO" 		,"BD6","DATA PROCEDIMENTO"	,						,,,,,,,,,,,,,,,,,,)
		oSection3:Cell("DATPRO"):SetAutoSize(.F.)
		oSection3:Cell("DATPRO"):SetSize(20)

		TRCell():New(oSection3,"PRCED" 		,"BD6","PROCEDIMENTO"			,						,,,,,,,,,,,,,,,,,,)
		oSection3:Cell("PRCED"):SetAutoSize(.F.)
		oSection3:Cell("PRCED"):SetSize(14)

		TRCell():New(oSection3,"DESCRI" 	,"BD6","DESCRICAO DA COBRANÇA"	,						,,,,,,,,,,,,,,,,,,)
		oSection3:Cell("DESCRI"):SetAutoSize(.F.)
		oSection3:Cell("DESCRI"):SetSize(50)

		TRCell():New(oSection3,"QTD" 		,"BD6","QUANTIDADE"				,						,,,,,,,,,,,,,,,,,,)
		oSection3:Cell("QTD"):SetAutoSize(.F.)
		oSection3:Cell("QTD"):SetSize(14)
		oSection3:Cell("QTD"):SetAlign("CENTER")

	EndIf

	TRCell():New(oSection3,"VALOR" 		,"BD6","VALOR"					,"@E 999,999,999,999.99",,,,,,,,,,,,,,,,,,)
	oSection3:Cell("VALOR"):SetAutoSize(.F.)
	oSection3:Cell("VALOR"):SetSize(12)
	oSection3:Cell("VALOR"):SetAlign("CENTER")

	//--------------------------------
	//Quarta linha do relatório
	//--------------------------------
	oSection4 := TRSection():New(oSection3,"","BA1")

	TRCell():New(oSection4,"TOTUSU"		,"BA1","TOTAL USUARIO"			,"@E 999,999,999,999.99",,,,,,,,,,,,,,,,,,)

	//--------------------------------
	//Quarta linha do relatório
	//--------------------------------
	oSection5 := TRSection():New(oSection4,"","BA1")

	TRCell():New(oSection5,"TOTFAM"		,"BA1","TOTAL FAMILIA"			,"@E 999,999,999,999.99",,,,,,,,,,,,,,,,,,)

	//--------------------------------
	//Quinta linha do relatório
	//--------------------------------
	oSection6 := TRSection():New(oSection5,"","BA1")

	TRCell():New(oSection6,"TOTGER"		,"BA1","TOTAL GERAL" 			,"@E 999,999,999,999.99",,,,,,,,,,,,,,,,,,)


Return oReport

/*/{Protheus.doc} CABR097B
Rotina para montar a query e trazer as informações no relatório
@type function
@version  2.0
@author angelo.cassago
@since 05/10/2022
@param oReport, object, objeto do relatório
/*/
Static Function CABR097B(oReport)

	Local _aArea 		:= GetArea()
	Local _cQuery		:= ""
	Local _cEmp 		:= ""
	Local _cCont 		:= ""
	Local _cSub 		:= ""
	Local _cMat 		:= ""
	Local  _nTotusu		:= 0
	Local  _nTotfam		:= 0
	Local  _nTotGr 		:= 0
	Local _lPrim 		:= .T.
	Local oFnt25N		:= TFont():New("Courier New",,25,,.T.,,,,,.F.,.F.)
	Local oFnt32N		:= TFont():New("Courier New",,32,,.T.,,,,,.F.,.F.)

	Private oSection1 	:= oReport:Section(1)
	Private oSection2 	:= oReport:Section(1):Section(1)
	Private oSection3 	:= oReport:Section(1):Section(1):Section(1)
	Private oSection4 	:= oReport:Section(1):Section(1):Section(1):Section(1)
	Private oSection5 	:= oReport:Section(1):Section(1):Section(1):Section(1):Section(1)
	Private oSection6 	:= oReport:Section(1):Section(1):Section(1):Section(1):Section(1):Section(1)
	Private _cAlias1	:= GetNextAlias()
	Private _cAlias2	:= GetNextAlias()

	//------------------------------------------------------------------
	//Não permite que seja impresso o cabeçalho padrão do TREPORT
	//------------------------------------------------------------------
	oReport:HideHeader()

	If cEmpAnt = '01'
		oReport:SayBitmap(100, 40, "lgrl01.bmp", 350, 150)
	Else
		oReport:SayBitmap(100, 40, "lgrl02.bmp", 350, 150)
	EndIf

	oReport:SkipLine( 15 )

	//----------------------------------------
	//Realiza a montagem das query's
	//----------------------------------------
	//Parametros:
	// 1 - Query inicial
	// 2 - Query detalhamento Analitico
	// 3 - Query detalhamento Sintético
	//----------------------------------------
	_cQuery := CABR097D("1")

	If Select(_cAlias1) > 0
		(_cAlias1)->(DbCloseArea())
	EndIf

	DbUseArea(.T.,"TOPCONN",TcGenQry(,,_cQuery),_cAlias1,.T.,.T.)

	While !(_cAlias1)->(EOF())

		oReport:IncMeter()

		If oReport:Cancel()
			Exit
		EndIf

		If _lPrim

			_lPrim := .F.

			cMsg := "EXTRATO DO USUÁRIO"
			oReport:Say(125, 1040, cMsg, oFnt32N)
			oReport:Say(225, 1125,  "Competência: " + AllTrim((_cAlias1)->MES+"/"+(_cAlias1)->ANO), oFnt25N)

		EndIf

		If !(_cEmp = (_cAlias1)->CODEMP)

			_cEmp 	:= (_cAlias1)->CODEMP
			_cCont 	:= ""
			_cSub 	:= ""
			_cMat 	:= ""

			oSection1:Init()
			oSection1:SetHeaderSection(.T.)

			oSection1:Cell("CODEMP"):SetValue((_cAlias1)->CODEMP)
			oSection1:Cell("NREDUZ"):SetValue((_cAlias1)->NREDUZ)

			oSection1:PrintLine()
			oSection1:Finish()

		EndIf

		If !(_cCont = (_cAlias1)->CONT) .Or. !(_cSub = (_cAlias1)->SUBCON)

			_cCont 	:= (_cAlias1)->CONT
			_cSub 	:= (_cAlias1)->SUBCON
			_cMat 	:= ""

			oSection2:Init()
			oSection2:SetHeaderSection(.T.)

			oSection2:Cell("CONT"	):SetValue((_cAlias1)->CONT		)
			oSection2:Cell("SUBCON"	):SetValue((_cAlias1)->SUBCON	)
			oSection2:Cell("DESCSUB"):SetValue((_cAlias1)->DESCSUB	)

			oSection2:PrintLine()
			oSection2:Finish()

		EndIf

		//----------------------------------------
		//Realtório Analítico
		//----------------------------------------
		If mv_par11 = 1

			//---------------------------------------------
			//Imprime o total de cada familia
			//---------------------------------------------
			If !(SUBSTR(_cMat,1,14) == (_cAlias1)->(CODINT+CODEMP+MATRIC)) .And. _nTotfam != 0

				oSection5:Init()
				oSection5:SetHeaderSection(.T.)

				oSection5:Cell("TOTFAM"):SetValue(_nTotfam)

				oSection5:PrintLine()
				oSection5:Finish()

				//-----------------------------------------------------------------
				//Após imprimir o total do usuário zerar a variável para o próximo
				//-----------------------------------------------------------------
				_nTotGr  += _nTotfam
				_nTotfam := 0

			EndIf

			If !(_cMat ==  (_cAlias1)->(CODINT+CODEMP+MATRIC+TIPREG+DIGITO))

				_cMat :=  (_cAlias1)->(CODINT+CODEMP+MATRIC+TIPREG+DIGITO)

				//----------------------------------------
				//Realiza a montagem das query's
				//----------------------------------------
				//Parametros:
				// 1 - Query inicial
				// 2 - Query detalhamento Analitico
				// 3 - Query detalhamento Sintético
				//----------------------------------------
				_cQuery := CABR097D("2")

				If Select(_cAlias2) > 0
					(_cAlias2)->(DbCloseArea())
				EndIf

				DbUseArea(.T.,"TOPCONN",TcGenQry(,,_cQuery),_cAlias2,.T.,.T.)

				While ! (_cAlias2)->(EOF())

					oReport:IncMeter()

					oSection3:Init()
					oSection3:SetHeaderSection(.T.)

					oSection3:Cell("MATRIC"	):SetValue(_cMat				)
					oSection3:Cell("NOME" 	):SetValue((_cAlias2)->NOME		)
					oSection3:Cell("TIPUSU"	):SetValue((_cAlias2)->TIPUSU	)
					oSection3:Cell("PREST" 	):SetValue((_cAlias2)->PREST	)
					oSection3:Cell("DATPRO"	):SetValue((_cAlias2)->DATPRO	)
					oSection3:Cell("PRCED"	):SetValue((_cAlias2)->PRCED	)
					oSection3:Cell("DESCRI"	):SetValue((_cAlias2)->DESCRI	)
					oSection3:Cell("QTD" 	):SetValue((_cAlias2)->QTD 		)
					oSection3:Cell("VALOR" 	):SetValue((_cAlias2)->VALOR	)

					oSection3:PrintLine()

					_nTotusu += (_cAlias2)->VALOR //Total por usuário

					(_cAlias2)->(DbSkip())

				EndDo

				//---------------------------------------------
				//Imprime o total de cada usuário
				//---------------------------------------------
				If _nTotusu != 0

					oSection4:Init()
					oSection4:SetHeaderSection(.T.)

					oSection4:Cell("TOTUSU"):SetValue(_nTotusu)

					oSection4:PrintLine()
					oSection4:Finish()

					//-----------------------------------------------------------------
					//Após imprimir o total do usuário zerar a variável para o próximo
					//-----------------------------------------------------------------
					_nTotfam += _nTotusu //Total por familia
					_nTotusu := 0

				EndIf

				oSection3:Finish()

				If Select(_cAlias2) > 0
					(_cAlias2)->(DbCloseArea())
				EndIf

			EndIf

		Else //Relatório Sintético

			//---------------------------------------------
			//Imprime o total de cada familia
			//---------------------------------------------
			If !(SUBSTR(_cMat,1,14) == (_cAlias1)->(CODINT+CODEMP+MATRIC)) .And. _nTotfam != 0

				oSection5:Init()
				oSection5:SetHeaderSection(.T.)

				oSection5:Cell("TOTFAM"):SetValue(_nTotfam)

				oSection5:PrintLine()
				oSection5:Finish()

				//-----------------------------------------------------------------
				//Após imprimir o total do usuário zerar a variável para o próximo
				//-----------------------------------------------------------------
				_nTotGr  += _nTotfam
				_nTotfam := 0

			EndIf

			If !(_cMat ==  (_cAlias1)->(CODINT+CODEMP+MATRIC+TIPREG+DIGITO))

				_cMat :=  (_cAlias1)->(CODINT+CODEMP+MATRIC+TIPREG+DIGITO)

				//----------------------------------------
				//Realiza a montagem das query's
				//----------------------------------------
				//Parametros:
				// 1 - Query inicial
				// 2 - Query detalhamento Analitico
				// 3 - Query detalhamento Sintético
				//----------------------------------------
				_cQuery := CABR097D("3")

				If Select(_cAlias2) > 0
					(_cAlias2)->(DbCloseArea())
				EndIf

				DbUseArea(.T.,"TOPCONN",TcGenQry(,,_cQuery),_cAlias2,.T.,.T.)

				While ! (_cAlias2)->(EOF())

					oReport:IncMeter()

					oSection3:Init()
					oSection3:SetHeaderSection(.T.)

					oSection3:Cell("MATRIC"	):SetValue(_cMat				)
					oSection3:Cell("NOME" 	):SetValue((_cAlias2)->NOME		)
					oSection3:Cell("TIPUSU"	):SetValue((_cAlias2)->TIPUSU	)
					oSection3:Cell("VALOR" 	):SetValue((_cAlias2)->VALOR	)

					oSection3:PrintLine()

					_nTotusu += (_cAlias2)->VALOR //Total por usuário

					(_cAlias2)->(DbSkip())

				EndDo

				//---------------------------------------------
				//Imprime o total de cada usuário
				//---------------------------------------------
				If _nTotusu != 0					
					
					_nTotfam += _nTotusu //Total por familia
					_nTotusu := 0

				EndIf

				oSection3:Finish()

				If Select(_cAlias2) > 0
					(_cAlias2)->(DbCloseArea())
				EndIf

			EndIf

		EndIf

		(_cAlias1)->(DbSkip())

	EndDo

	//------------------------------------------
	//Impressão do total geral familia
	//------------------------------------------
	If _nTotfam != 0

		oSection5:Init()
		oSection5:SetHeaderSection(.T.)

		oSection5:Cell("TOTFAM"):SetValue(_nTotfam)

		oSection5:PrintLine()
		oSection5:Finish()

		//-----------------------------------------------------------------
		//Após imprimir o total do usuário zerar a variável para o próximo
		//-----------------------------------------------------------------
		_nTotGr  += _nTotfam
		_nTotfam := 0

	EndIf

	//------------------------------------------
	//Impressão do total geral familia
	//------------------------------------------
	If _nTotGr != 0

		oSection6:Init()
		oSection6:SetHeaderSection(.T.)

		oSection6:Cell("TOTGER"):SetValue(_nTotGr)

		oSection6:PrintLine()
		oSection6:Finish()

		//-----------------------------------------------------------------
		//Após imprimir o total do usuário zerar a variável para o próximo
		//-----------------------------------------------------------------
		_nTotGr := 0

	EndIf

	If Select(_cAlias1) > 0
		(_cAlias1)->(DbCloseArea())
	EndIf

	RestArea(_aArea)

Return(.T.)

/*/{Protheus.doc} CABR097C
Rotina responsavel pela geração das perguntas no relatório
@type function
@version 2.0
@author angelo.cassago
@since 05/10/2022
@param cGrpPerg, character, nome da pergunta
/*/
Static Function CABR097C(cGrpPerg)

	u_CABASX1(cGrpPerg,"01",OemToAnsi("Operadora:")				,"","","mv_ch01","C",04,0,0,"G","","","","","mv_par01",""			,"","","",""			,"","","","","","","","","","","",{},{},{})
	u_CABASX1(cGrpPerg,"02",OemToAnsi("Empresa De")				,"","","mv_ch02","C",04,0,0,"G","","","","","mv_par02",""			,"","","",""			,"","","","","","","","","","","",{},{},{})
	u_CABASX1(cGrpPerg,"03",OemToAnsi("Empresa Ate")			,"","","mv_ch03","C",04,0,0,"G","","","","","mv_par03",""			,"","","",""			,"","","","","","","","","","","",{},{},{})
	u_CABASX1(cGrpPerg,"04",OemToAnsi("Matricula De?")			,"","","mv_ch04","C",06,0,0,"G","","","","","mv_par04",""			,"","","",""			,"","","","","","","","","","","",{},{},{})
	u_CABASX1(cGrpPerg,"05",OemToAnsi("Matricula Ate")			,"","","mv_ch05","C",06,0,0,"G","","","","","mv_par05",""			,"","","",""			,"","","","","","","","","","","",{},{},{})
	u_CABASX1(cGrpPerg,"06",OemToAnsi("Usuario De:")			,"","","mv_ch06","C",02,0,0,"G","","","","","mv_par06",""			,"","","",""			,"","","","","","","","","","","",{},{},{})
	u_CABASX1(cGrpPerg,"07",OemToAnsi("Usuario Ate:")			,"","","mv_ch07","C",02,0,0,"G","","","","","mv_par07",""			,"","","",""			,"","","","","","","","","","","",{},{},{})
	u_CABASX1(cGrpPerg,"08",OemToAnsi("Lote Cobrança :")		,"","","mv_ch08","C",12,0,0,"G","","","","","mv_par08",""			,"","","",""			,"","","","","","","","","","","",{},{},{})
	u_CABASX1(cGrpPerg,"09",OemToAnsi("Mês Base")				,"","","mv_ch09","C",02,0,0,"G","","","","","mv_par09",""			,"","","",""			,"","","","","","","","","","","",{},{},{})
	u_CABASX1(cGrpPerg,"10",OemToAnsi("Ano Base")				,"","","mv_ch10","C",04,0,0,"G","","","","","mv_par10",""			,"","","",""			,"","","","","","","","","","","",{},{},{})
	u_CABASX1(cGrpPerg,"11",OemToAnsi("Tipo de Impresso")		,"","","mv_ch11","N",01,0,0,"C","","","","","mv_par11","Analitico"	,"","","","Sintetico"	,"","","","","","","","","","","",{},{},{})	

Return

/*/{Protheus.doc} CABR097D
Rotina para a montagem e manutenção das querys utilizadas durante o processo
@type function
@version  2.0
@author angelo.cassago
@since 05/10/2022
@return variant, retona a query montada
/*/

Static Function CABR097D(_cParam)

	Local _cRet := ""

	Default _cParam := "1" //Query Principal

	If _cParam == "1"

		_cRet += " SELECT 									" 	+ CRLF
		_cRet += "     BM1.BM1_CONEMP CONT,    				" 	+ CRLF
		_cRet += "     BM1.BM1_SUBCON SUBCON,         		" 	+ CRLF
		_cRet += "     BG9.BG9_CODIGO CODEMP,         		" 	+ CRLF
		_cRet += "     TRIM(BG9.BG9_NREDUZ) NREDUZ,   		" 	+ CRLF
		_cRet += "     TRIM(BQC.BQC_DESCRI) DESCSUB,  		" 	+ CRLF
		_cRet += "     BM1.BM1_CODINT CODINT, 				" 	+ CRLF
		_cRet += "     BM1.BM1_CODEMP CODEMP, 				" 	+ CRLF
		_cRet += "     BM1.BM1_MATRIC MATRIC, 				" 	+ CRLF
		_cRet += "     BM1.BM1_TIPREG TIPREG, 				" 	+ CRLF
		_cRet += "     BM1.BM1_DIGITO DIGITO, 				" 	+ CRLF
		_cRet += "     BM1.BM1_PLNUCO PLNUCO, 				" 	+ CRLF
		_cRet += "     BM1.BM1_MES MES, 					" 	+ CRLF
		_cRet += "     BM1.BM1_ANO ANO 						" 	+ CRLF
		_cRet += " FROM										" 	+ CRLF
		_cRet += "     " + RETSQLNAME("BM1") + " BM1 		" 	+ CRLF
		_cRet += "     										" 	+ CRLF
		_cRet += "     INNER JOIN 							" 	+ CRLF
		_cRet += "         " + RETSQLNAME("BFQ") + " BFQ 	" 	+ CRLF
		_cRet += "     ON 									" 	+ CRLF
		_cRet += "         BFQ.BFQ_FILIAL              = '" + xFilial("BFQ") + "' " 	+ CRLF
		_cRet += "         AND BFQ.BFQ_CODINT          = BM1.BM1_CODINT 			" 	+ CRLF
		_cRet += "         AND BFQ_PROPRI||BFQ_CODLAN  = BM1.BM1_CODTIP 			" 	+ CRLF
		_cRet += "         AND BFQ.BFQ_YTPANL          = 'C' 						" 	+ CRLF
		_cRet += "         AND BFQ.D_E_L_E_T_          = ' ' 						" 	+ CRLF
		_cRet += "         									" 	+ CRLF
		_cRet += "     INNER JOIN    						" 	+ CRLF
		_cRet += "         " + RETSQLNAME("BQC") + " BQC 	" 	+ CRLF
		_cRet += "     ON 								" 	+ CRLF
		_cRet += "         BQC.BQC_FILIAL      = '" + xFilial("BQC") + "' " 	+ CRLF
		_cRet += "         AND BQC.BQC_CODINT  = BM1.BM1_CODINT 	" 	+ CRLF
		_cRet += "         AND BQC.BQC_CODEMP  = BM1.BM1_CODEMP 	" 	+ CRLF
		_cRet += "         AND BQC.BQC_NUMCON  = BM1.BM1_CONEMP 	" 	+ CRLF
		_cRet += "         AND BQC.BQC_VERCON  = BM1.BM1_VERCON 	" 	+ CRLF
		_cRet += "         AND BQC.BQC_SUBCON  = BM1.BM1_SUBCON 	" 	+ CRLF
		_cRet += "         AND BQC.BQC_VERSUB  = BM1.BM1_VERSUB 	" 	+ CRLF
		_cRet += "         AND BQC.D_E_L_E_T_  = ' ' 				" 	+ CRLF
		_cRet += "      											" 	+ CRLF
		_cRet += "     INNER JOIN  									" 	+ CRLF
		_cRet += "         " + RETSQLNAME("BG9") + " BG9  			" 	+ CRLF
		_cRet += "     ON  											" 	+ CRLF
		_cRet += "         BG9.BG9_FILIAL      = '" + xFilial("BG9") + "' 	" 	+ CRLF
		_cRet += "         AND BG9.BG9_CODINT  = BM1.BM1_CODINT 			" 	+ CRLF
		_cRet += "         AND BG9.BG9_CODIGO  = BM1.BM1_CODEMP 			" 	+ CRLF
		_cRet += "         AND BG9.D_E_L_E_T_  = ' '  	" 	+ CRLF
		_cRet += "        								" 	+ CRLF
		_cRet += " WHERE								" 	+ CRLF
		_cRet += "     BM1.BM1_FILIAL      = '" + xFilial("BM1") + " '   	" 	+ CRLF

		If !Empty(MV_PAR01)
			_cRet += "     AND BM1.BM1_CODINT  = '" + MV_PAR01 + "'	 " 	+ CRLF
		EndIf

		If !Empty(MV_PAR02) .AND. !Empty(MV_PAR03)
			_cRet += "     AND BM1.BM1_CODEMP  BETWEEN '" + MV_PAR02 + "' AND '" + MV_PAR03 + "' " 	+ CRLF
		EndIf

		If !Empty(MV_PAR04) .AND. !Empty(MV_PAR05)
			_cRet += "     AND BM1.BM1_MATRIC  BETWEEN '" + MV_PAR04 + "' AND '" + MV_PAR05 + "' " 	+ CRLF
		EndIf

		If !Empty(MV_PAR06) .AND. !Empty(MV_PAR07)
			_cRet += "     AND BM1.BM1_TIPREG  BETWEEN '" + MV_PAR06 + "' AND '" + MV_PAR07 + "' " 	+ CRLF
		EndIf

		If !Empty(MV_PAR08)
			_cRet += "     AND BM1.BM1_PLNUCO  = '" + MV_PAR08 + "'	" 	+ CRLF
		EndIf

		If !Empty(MV_PAR09)
			_cRet += "     AND BM1.BM1_MES     = '" + MV_PAR09 + "'	" 	+ CRLF
		EndIf

		If !Empty(MV_PAR10)
			_cRet += "     AND BM1.BM1_ANO     = '" + MV_PAR10 + "'	" 	+ CRLF
		EndIf

		_cRet += "     AND BM1.D_E_L_E_T_  = ' '" 	+ CRLF
		_cRet += " GROUP BY				" 	+ CRLF
		_cRet += "     BM1.BM1_CONEMP,	" 	+ CRLF
		_cRet += "     BM1.BM1_SUBCON,	" 	+ CRLF
		_cRet += "     BG9.BG9_CODIGO,	" 	+ CRLF
		_cRet += "     BG9.BG9_NREDUZ,	" 	+ CRLF
		_cRet += "     BQC.BQC_DESCRI,	" 	+ CRLF
		_cRet += "     BM1.BM1_CODINT,	" 	+ CRLF
		_cRet += "     BM1.BM1_CODEMP,	" 	+ CRLF
		_cRet += "     BM1.BM1_MATRIC,	" 	+ CRLF
		_cRet += "     BM1.BM1_TIPREG,	" 	+ CRLF
		_cRet += "     BM1.BM1_DIGITO, 	" 	+ CRLF
		_cRet += "     BM1.BM1_PLNUCO, 	" 	+ CRLF
		_cRet += "     BM1.BM1_MES,		" 	+ CRLF
		_cRet += "     BM1.BM1_ANO		" 	+ CRLF
		_cRet += " ORDER BY           	" 	+ CRLF
		_cRet += "     BM1.BM1_CONEMP,	" 	+ CRLF
		_cRet += "     BM1.BM1_SUBCON,	" 	+ CRLF
		_cRet += "     BM1.BM1_CODINT,	" 	+ CRLF
		_cRet += "     BM1.BM1_CODEMP,	" 	+ CRLF
		_cRet += "     BM1.BM1_MATRIC,	" 	+ CRLF
		_cRet += "     BM1.BM1_TIPREG,	" 	+ CRLF
		_cRet += "     BM1.BM1_DIGITO 	" 	+ CRLF

	ElseIf _cParam == "2" //Query Detalhamento Analitico

		_cRet += " SELECT													" + CRLF
		_cRet += " 	TRIM(BA1.BA1_NOMUSR) NOME,  							" + CRLF
		_cRet += " 	DECODE(BA1_TIPUSU,'T','TITULAR','DEPENDENTE') TIPUSU,	" + CRLF
		_cRet += " 	TRIM(BAU.BAU_NOME) PREST,   							" + CRLF
		_cRet += " 	BD6.BD6_CODPRO PRCED, 									" + CRLF
		_cRet += " 	FORMATA_DATA_MS(BD6.BD6_DATPRO) DATPRO, 				" + CRLF
		_cRet += " 	UPPER(TRIM(BD6.BD6_DESPRO)) DESCRI, 					" + CRLF
		_cRet += " 	BD6.BD6_VLRPF VALOR,  									" + CRLF
		_cRet += " 	BD6.BD6_QTDPRO QTD 										" + CRLF
		_cRet += " FROM             										" + CRLF
		_cRet += " 	" + RETSQLNAME("BD6") + " BD6 							" + CRLF
		_cRet += " 															" + CRLF
		_cRet += " 	INNER JOIN												" + CRLF
		_cRet += " 		" + RETSQLNAME("BAU") + " BAU 						" + CRLF
		_cRet += " 	ON														" + CRLF
		_cRet += " 		BAU.BAU_FILIAL = '" + xFilial("BAU") + "'			" + CRLF
		_cRet += " 		AND BAU.BAU_CODIGO = BD6.BD6_CODRDA 				" + CRLF
		_cRet += " 		AND BAU.D_E_L_E_T_ = ' ' 							" + CRLF
		_cRet += " 															" + CRLF
		_cRet += " 	INNER JOIN												" + CRLF
		_cRet += " 		" + RETSQLNAME("BA1") + " BA1 						" + CRLF
		_cRet += " 	ON														" + CRLF
		_cRet += " 		BA1.BA1_FILIAL = '" + xFilial("BA1") + "'			" + CRLF
		_cRet += " 		AND BA1.BA1_CODINT = BD6.BD6_OPEUSR					" + CRLF
		_cRet += " 		AND BA1.BA1_CODEMP = BD6.BD6_CODEMP					" + CRLF
		_cRet += " 		AND BA1.BA1_MATRIC = BD6.BD6_MATRIC					" + CRLF
		_cRet += " 		AND BA1.BA1_TIPREG = BD6.BD6_TIPREG					" + CRLF
		_cRet += " 		AND BA1.BA1_DIGITO = BD6.BD6_DIGITO					" + CRLF
		_cRet += " 		AND BA1.D_E_L_E_T_ = ' '							" + CRLF
		_cRet += " 															" + CRLF
		_cRet += " WHERE 													" + CRLF
		_cRet += " 	BD6.BD6_FILIAL = '" + xFilial("BD6") + "'				" + CRLF
		_cRet += " 	AND BD6.BD6_OPEUSR = '" + (_cAlias1)->CODINT + "' 		" + CRLF
		_cRet += " 	AND BD6.BD6_CODEMP = '" + (_cAlias1)->CODEMP + "' 		" + CRLF
		_cRet += " 	AND BD6.BD6_MATRIC = '" + (_cAlias1)->MATRIC + "' 		" + CRLF
		_cRet += " 	AND BD6.BD6_TIPREG = '" + (_cAlias1)->TIPREG + "' 		" + CRLF
		_cRet += " 	AND BD6.BD6_DIGITO = '" + (_cAlias1)->DIGITO + "' 		" + CRLF
		_cRet += " 	AND BD6.BD6_NUMFAT = '" + (_cAlias1)->PLNUCO + "' 		" + CRLF
		_cRet += " 	AND BD6.D_E_L_E_T_ = ' '								" + CRLF

	ElseIf _cParam == "3" //Query Detalhamento Sintético

		_cRet += " SELECT													" + CRLF
		_cRet += " 	BA1.BA1_CODINT||BA1.BA1_CODEMP||BA1.BA1_MATRIC||BA1.BA1_TIPREG||BA1.BA1_DIGITO MATRICULA, " + CRLF
		_cRet += " 	TRIM(BA1.BA1_NOMUSR) NOME,  							" + CRLF
		_cRet += " 	DECODE(BA1_TIPUSU,'T','TITULAR','DEPENDENTE') TIPUSU,	" + CRLF		
		_cRet += " 	SUM(BD6.BD6_VLRPF) VALOR								" + CRLF		
		_cRet += " FROM             										" + CRLF
		_cRet += " 	" + RETSQLNAME("BD6") + " BD6 							" + CRLF
		_cRet += " 															" + CRLF
		_cRet += " 	INNER JOIN												" + CRLF
		_cRet += " 		" + RETSQLNAME("BAU") + " BAU 						" + CRLF
		_cRet += " 	ON														" + CRLF
		_cRet += " 		BAU.BAU_FILIAL = '" + xFilial("BAU") + "'			" + CRLF
		_cRet += " 		AND BAU.BAU_CODIGO = BD6.BD6_CODRDA 				" + CRLF
		_cRet += " 		AND BAU.D_E_L_E_T_ = ' ' 							" + CRLF
		_cRet += " 															" + CRLF
		_cRet += " 	INNER JOIN												" + CRLF
		_cRet += " 		" + RETSQLNAME("BA1") + " BA1 						" + CRLF
		_cRet += " 	ON														" + CRLF
		_cRet += " 		BA1.BA1_FILIAL = '" + xFilial("BA1") + "'			" + CRLF
		_cRet += " 		AND BA1.BA1_CODINT = BD6.BD6_OPEUSR					" + CRLF
		_cRet += " 		AND BA1.BA1_CODEMP = BD6.BD6_CODEMP					" + CRLF
		_cRet += " 		AND BA1.BA1_MATRIC = BD6.BD6_MATRIC					" + CRLF
		_cRet += " 		AND BA1.BA1_TIPREG = BD6.BD6_TIPREG					" + CRLF
		_cRet += " 		AND BA1.BA1_DIGITO = BD6.BD6_DIGITO					" + CRLF
		_cRet += " 		AND BA1.D_E_L_E_T_ = ' '							" + CRLF
		_cRet += " 															" + CRLF
		_cRet += " WHERE 													" + CRLF
		_cRet += " 		BD6.BD6_FILIAL = '" + xFilial("BD6") + "'			" + CRLF
		_cRet += " 		AND BD6.BD6_OPEUSR = '" + (_cAlias1)->CODINT + "' 	" + CRLF
		_cRet += " 		AND BD6.BD6_CODEMP = '" + (_cAlias1)->CODEMP + "' 	" + CRLF
		_cRet += " 		AND BD6.BD6_MATRIC = '" + (_cAlias1)->MATRIC + "' 	" + CRLF
		_cRet += " 		AND BD6.BD6_TIPREG = '" + (_cAlias1)->TIPREG + "' 	" + CRLF
		_cRet += " 		AND BD6.BD6_DIGITO = '" + (_cAlias1)->DIGITO + "' 	" + CRLF
		_cRet += " 		AND BD6.BD6_NUMFAT = '" + (_cAlias1)->PLNUCO + "' 	" + CRLF
		_cRet += " 		AND BD6.D_E_L_E_T_ = ' '							" + CRLF
		_cRet += " GROUP BY													" + CRLF
    	_cRet += " 		BA1.BA1_CODINT||BA1.BA1_CODEMP||BA1.BA1_MATRIC||BA1.BA1_TIPREG||BA1.BA1_DIGITO, " + CRLF
    	_cRet += " 		BA1.BA1_NOMUSR, " + CRLF
 		_cRet += " 		BA1_TIPUSU 		" + CRLF
 		_cRet += " 		ORDER BY 1  	" + CRLF

	EndIf

Return _cRet
