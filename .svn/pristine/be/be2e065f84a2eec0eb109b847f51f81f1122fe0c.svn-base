#INCLUDE 'rwmake.ch'
#INCLUDE "TOTVS.CH"
#INCLUDE 'tbiconn.ch'
#INCLUDE 'topconn.ch'
#Define ENTER CHR(13) + CHR(10)

/********************************************************************************/
/*** Programa: CABR281 ***  *** Autor: Wanderley Andrade                      ***/
/********************************************************************************/
/*** Descricao: GERACAO DE EXCEL DAS NOTAS DE COMPRAS                      	  ***/
/***                                                                       	  ***/
/***                                                                       	  ***/
/********************************************************************************/
/*** CABERJ			                                                       	  ***/
/*** Analista Resp. ***  Data  *** Bops: Manutencao Efetuada               	  ***/
/********************************************************************************/
/*** CRIACAO               *** 14/05/20  									  ***/                                         	
/********************************************************************************/

User Function CABR281()
	Private cPerg := "CABR281"//Padr("CAT11",10,"")
	//	aSx1  := {}
	//
	//	Aadd(aSx1,{"GRUPO","ORDEM","PERGUNT"             ,"VARIAVL","TIPO","TAMANHO","DECIMAL","PRESEL","GSC","VALID" ,"VAR01"   ,"F3","DEF01" ,"DEF02" ,"DEF03","DEF04","DEF05","HELP"})
	//	Aadd(aSx1,{cPerg  ,"01"   ,"Documento de..?" 				,"mv_ch1" 		,"C"   ,09       ,0        , 0  ,"C"  ,""   		  ,"mv_par01",""    ,""       ,""      ,""       ,""       ,""        ,"" })
	//	Aadd(aSx1,{cPerg  ,"02"   ,"Documento Ate..?"				,"mv_ch2" 		,"C"   ,09       ,0        , 0  ,"C"  ,""   		  ,"mv_par02",""    ,""       ,""      ,""       ,""       ,""        ,"" })
	//	Aadd(aSx1,{cPerg  ,"03"   ,"Serie de..?"					,"mv_ch3" 		,"C"   ,03       ,0        , 0  ,"C"  ,""   		  ,"mv_par03",""    ,""       ,""      ,""       ,""       ,""        ,"" })
	//	Aadd(aSx1,{cPerg  ,"04"   ,"Serie Ate..?"					,"mv_ch4" 		,"C"   ,03       ,0        , 0  ,"C"  ,""   		  ,"mv_par04",""    ,""       ,""      ,""       ,""       ,""        ,"" })
	//	Aadd(aSx1,{cPerg  ,"05"   ,"Emissao De...........?"		,"mv_ch5" 		,"D"   ,08       ,0        , 0  ,"C"  ,""   		  ,"mv_par05",""    ,""       ,""      ,""       ,""       ,""        ,"" })
	//	Aadd(aSx1,{cPerg  ,"06"   ,"Emissao Ate..........?"		,"mv_ch6" 		,"D"   ,08       ,0        , 0  ,"C"  ,""   		  ,"mv_par06",""    ,""       ,""      ,""       ,""       ,""        ,"" })
	//	Aadd(aSx1,{cPerg  ,"07"   ,"Digitacao de...........?"	,"mv_ch7" 		,"D"   ,08       ,0        , 0  ,"C"  ,""   		  ,"mv_par07",""    ,""       ,""      ,""       ,""       ,""        ,"" })
	//	Aadd(aSx1,{cPerg  ,"08"   ,"Digitacao Ate..........?"	,"mv_ch8" 		,"D"   ,08       ,0        , 0  ,"C"  ,""   		  ,"mv_par08",""    ,""       ,""      ,""       ,""       ,""        ,"" })
	//	Aadd(aSx1,{cPerg  ,"09"   ,"Fornecedor de..?"				,"mv_ch9" 		,"C"   ,06       ,0        , 0  ,"C"  ,""   		  ,"mv_par09","SA2"    ,""       ,""      ,""       ,""       ,""        ,"" })
	//	Aadd(aSx1,{cPerg  ,"10"   ,"Fornecedor ate..?"			,"mv_ch10" 	,"C"   ,06       ,0        , 0  ,"C"  ,""   		  ,"mv_par10",""    ,""       ,""      ,""       ,""       ,""        ,"" })
	//	Aadd(aSx1,{cPerg  ,"11"   ,"Loja de..?"					,"mv_ch11" 	,"C"   ,02       ,0        , 0  ,"C"  ,""   		  ,"mv_par11",""    ,""       ,""      ,""       ,""       ,""        ,"" })
	//	Aadd(aSx1,{cPerg  ,"12"   ,"Loja ate..?"					,"mv_ch12" 	,"C"   ,02       ,0        , 0  ,"C"  ,""   		  ,"mv_par12",""    ,""       ,""      ,""       ,""       ,""        ,"" })
	//	Aadd(aSx1,{cPerg  ,"13"   ,"Centro de Custo de..?"		,"mv_ch13" 	,"C"   ,09       ,0        , 0  ,"C"  ,""   		  ,"mv_par13","CTT"    ,""       ,""      ,""       ,""       ,""        ,"" })
	//	Aadd(aSx1,{cPerg  ,"14"   ,"Centro de Custo ate..?"		,"mv_ch14" 	,"C"   ,09       ,0        , 0  ,"C"  ,""   		  ,"mv_par14","CTT"    ,""       ,""      ,""       ,""       ,""        ,"" })
	//	Aadd(aSx1,{cPerg  ,"15"   ,"Local da Gravação..? "      ,"mv_ch15"    ,"C"   ,30       ,0        , 0  ,"G"  ,"u_Fd7r6()" ,"mv_par15",""    ,""      ,""      ,""       ,""       ,""        ,"" })
	//	fCriaSx1()
	If !Pergunte(cPerg,.T.)
		Return
	Endif
	//	Aadd(aSx1,{1    ,"Documento de..?"				,Space(TamSX3('D1_DOC')[01])	, "", "", ""				, "", 80	, .T.})
	//	Aadd(aSx1,{2    ,"Documento Ate..?"			,Space(TamSX3('D1_DOC')[01])	, "", "", ""				, "", 80	, .T.})
	//	Aadd(aSx1,{3    ,"Serie de..?"					,Space(TamSX3('D1_SERIE')[01])	, "", "", ""				, "", 80	, .T.})
	//	Aadd(aSx1,{4    ,"Serie Ate..?"					,Space(TamSX3('D1_SERIE')[01])	, "", "", ""				, "", 80	, .T.})
	//	Aadd(aSx1,{5    ,"Emissao De...........?"		,CTOD('//')						, "", "", ""				, "", 80	, .T.})
	//	Aadd(aSx1,{6    ,"Emissao Ate..........?"		,CTOD('//')						, "", "", ""				, "", 80	, .T.})
	//	Aadd(aSx1,{7    ,"Digitacao de...........?"	,CTOD('//')						, "", "", ""				, "", 80	, .T.})
	//	Aadd(aSx1,{8    ,"Digitacao Ate..........?"	,CTOD('//')						, "", "", ""				, "", 80	, .T.})
	//	Aadd(aSx1,{9    ,"Fornecedor de..?"			,Space(TamSX3('A2_COD')[01])	, "", "", "SA2"			, "", 80	, .T.})
	//	Aadd(aSx1,{10   ,"Fornecedor ate..?"			,Space(TamSX3('A2_COD')[01])	, "", "", "SA2"			, "", 80	, .T.})
	//	Aadd(aSx1,{11   ,"Loja de..?"					,Space(TamSX3('A2_LOJA')[01])	, "", "", ""				, "", 80	, .T.})
	//	Aadd(aSx1,{12   ,"Loja ate..?"					,Space(TamSX3('A2_LOJA')[01])	, "", "", ""				, "", 80	, .T.})
	//	Aadd(aSx1,{13   ,"Centro de Custo de..?"		,Space(TamSX3('D1_CC')[01])		, "", "", ""				, "", 80	, .T.})
	//	Aadd(aSx1,{14   ,"Centro de Custo ate..?"		,Space(TamSX3('D1_CC')[01])		, "", "", "CTT"			, "", 80	, .T.})
	//	Aadd(aSx1,{15   ,"Local da Gravação..? "  	,Space(100)						, "", "", "u_Fd7r6()"	, "", 120	, .T.})
	//
	//	Pergunte(cPerg,.F.)
	//	If !ParamBox(aSx1, "Informe os parâmetros")
	//		Return
	//	Endif
	//	

	msaguarde( {|| FEXCEL() }, "Aguarde...", "Gerando Relatorio. Compras",.F.)



return

Static Function FEXCEL()
	Local cSql := ""
	Local lGera := .F.


	cSql := "   SELECT 'EMPRESA',			"+ENTER 
	cSql += "   F1_EMISSAO, 					"+ENTER
	cSql += "   F1_DTDIGIT, 					"+ENTER
	cSql += "   D1_DOC, 						"+ENTER
	cSql += "   D1_SERIE, 					"+ENTER
	cSql += "   D1_CC, 						"+ENTER
	cSql += "   F1_FORNECE ,				 	"+ENTER
	cSql += "   F1_LOJA, 					"+ENTER
	cSql += "   A2_NOME, 					"+ENTER
	cSql += "   D1_COD, 						"+ENTER
	cSql += "   B1_DESC,						"+ENTER
	cSql += "   D1_HIST,						"+ENTER
	cSql += "   D1_VUNIT, 					"+ENTER
	cSql += "   D1_QUANT, 					"+ENTER
	cSql += "   D1_TOTAL, 					"+ENTER
	cSql += "   F1_VALBRUT,                "+ENTER
	cSql += "   D1_TES						"+ENTER

	cSql += " 									"+ENTER
	cSql += " "+ENTER

	cSql += " from "+RETSQLNAME("SF1")+" SF1, "+RETSQLNAME("SD1")+" SD1,"+RETSQLNAME("SA2")+" SA2, "+RETSQLNAME("SB1")+" SB11 "+ENTER



	cSql += " WHERE SF1.D_E_L_E_T_<> '*' "+ENTER
	cSql += " AND SD1.D_E_L_E_T_<> '*' "+ENTER
	cSql += " AND SA2.D_E_L_E_T_<> '*' "+ENTER
	cSql += " AND SB11.D_E_L_E_T_<> '*' "+ENTER

	cSql += " AND SF1.F1_FILIAL  = '"+xFilial("SF1")+"' "
	cSql += " AND SD1.D1_FILIAL  = '"+xFilial("SD1")+"' "
	cSql += " AND SA2.A2_FILIAL  = '"+xFilial("SA2")+"' "
	cSql += " AND SB11.B1_FILIAL = '"+xFilial("SB1")+"' "

	cSql += " AND SF1.F1_DOC      = SD1.D1_DOC  	"+ENTER
	cSql += " AND SF1.F1_SERIE    = SD1.D1_SERIE	"+ENTER

	cSql += " AND SF1.F1_FORNECE  = SA2.A2_COD 	"+ENTER

	cSql += " AND SF1.F1_LOJA     = SA2.A2_LOJA 	"+ENTER

	cSql += " AND SF1.F1_FORNECE  = SD1.D1_FORNECE	"+ENTER

	cSql += "  AND SD1.D1_COD      = SB11.B1_COD 	"+ENTER
	*----------------------------------------------------------------------------------------------------
	cSql += " AND SD1.D1_DOC   >= '"+mv_par01+"'    AND SD1.D1_DOC   <= '"+mv_par02+"' "+ENTER

	cSql += " AND SD1.D1_SERIE >= '"+mv_par03+"'    AND SD1.D1_SERIE <= '"+mv_par04+"' "+ENTER

	cSql += " AND SF1.F1_EMISSAO >= '"+DTOS(mv_par05)+"' AND SF1.F1_EMISSAO <= '"+DTOS(mv_par06)+"'  "+ENTER

	cSql += " AND SF1.F1_DTDIGIT >= '"+DTOS(mv_par07)+"' AND SF1.F1_DTDIGIT <= '"+DTOS(mv_par08)+"' "+ENTER

	cSql += " AND SF1.F1_FORNECE >= '"+mv_par09+"'   AND SF1.F1_FORNECE <= '"+mv_par10+"' "+ENTER
	cSql += " AND SF1.F1_LOJA    >= '"+mv_par11+"'       AND SF1.F1_LOJA    <= '"+mv_par12+"' "+ENTER

	cSql += " AND SD1.D1_CC      >= '"+mv_par13+"'     AND SD1.D1_CC      <= '"+mv_par14+"' "+ENTER
	*-----------------------------

	cSql += " ORDER BY D1_DOC,D1_SERIE		"+ENTER





	/*	
	cSql := "  SELECT 'EMPRESA', "+ENTER
	cSql += "  F1_EMISSAO, "+ENTER
	cSql += "  F1_DTDIGIT, "+ENTER
	cSql += "  D1_DOC, "+ENTER
	cSql += "  D1_SERIE, "+ENTER
	cSql += "  D1_CC, "+ENTER
	cSql += "  F1_FORNECE , "+ENTER
	cSql += "  F1_LOJA, "+ENTER

	cSql += "  F1_VALBRUT, "+ENTER

	cSql += "  A2_NOME, "+ENTER
	cSql += "  D1_COD, "+ENTER
	cSql += "  B1_DESC, "+ENTER
	cSql += "  D1_HIST, "+ENTER
	cSql += "  D1_VUNIT, "+ENTER
	cSql += "  D1_QUANT, "+ENTER
	cSql += "  D1_TOTAL, "+ENTER
	cSql += "  D1_TES, "+ENTER
	cSql += "  E2_VENCREA, "+ENTER
	cSql += "  E2_BAIXA "+ENTER
	cSql += "  "+ENTER

	cSql += " from "+RETSQLNAME("SF1")+" SF1, "+RETSQLNAME("SD1")+" SD1,"+RETSQLNAME("SA2")+" SA2, "+RETSQLNAME("SE2")+" SE2,"+RETSQLNAME("SB1")+" SB11 "+ENTER

	cSql += " WHERE SF1.D_E_L_E_T_<> '*' "+ENTER
	cSql += " AND SD1.D_E_L_E_T_<> '*' "+ENTER
	cSql += " AND SA2.D_E_L_E_T_<> '*' "+ENTER
	cSql += " AND SE2.D_E_L_E_T_<> '*' "+ENTER
	cSql += " AND SB11.D_E_L_E_T_<> '*' "+ENTER
	cSql += "  "+ENTER
	cSql += "  "+ENTER
	cSql += "  "+ENTER
	cSql += " AND SF1.F1_FILIAL = '01' "+ENTER
	cSql += " AND SD1.D1_FILIAL = '01' "+ENTER
	cSql += " AND SA2.A2_FILIAL = '  ' "+ENTER
	cSql += " AND SE2.E2_FILIAL = '01' "+ENTER
	cSql += "  "+ENTER
	cSql += " AND SF1.F1_DOC  = SD1.D1_DOC "+ENTER
	cSql += " AND SF1.F1_SERIE = SD1.D1_SERIE "+ENTER

	//	cSql += " AND SF1.F1_DOC = '919622' "+ENTER

	cSql += " AND SF1.F1_FORNECE = SA2.A2_COD "+ENTER
	cSql += " AND SF1.F1_LOJA    = SA2.A2_LOJA "+ENTER
	AND SF1.F1_FORNECE  = SD1.D1_FORNECE
	cSql += " AND SF1.F1_FORNECE = SE2.E2_FORNECE "+ENTER
	cSql += " AND SF1.F1_LOJA    = SE2.E2_LOJA "+ENTER

	cSql += " AND SF1.F1_DOC     = SE2.E2_NUM "+ENTER

	cSql += " AND SD1.D1_COD     = SB11.B1_COD "+ENTER

	cSql += " AND SD1.D1_DOC   >= '"+mv_par01+"'    AND SD1.D1_DOC   <= '"+mv_par02+"' "+ENTER

	cSql += " AND SD1.D1_SERIE >= '"+mv_par03+"'    AND SD1.D1_SERIE <= '"+mv_par04+"' "+ENTER

	cSql += " AND SF1.F1_EMISSAO >= '"+DTOS(mv_par05)+"' AND SF1.F1_EMISSAO <= '"+DTOS(mv_par06)+"'  "+ENTER

	cSql += " AND SF1.F1_DTDIGIT >= '"+DTOS(mv_par07)+"' AND SF1.F1_DTDIGIT <= '"+DTOS(mv_par08)+"' "+ENTER

	cSql += " AND SF1.F1_FORNECE >= '"+mv_par09+"'   AND SF1.F1_FORNECE <= '"+mv_par10+"' "+ENTER
	cSql += " AND SF1.F1_LOJA    >= '"+mv_par11+"'       AND SF1.F1_LOJA    <= '"+mv_par12+"' "+ENTER

	cSql += " AND SD1.D1_CC      >= '"+mv_par13+"'     AND SD1.D1_CC      <= '"+mv_par14+"' "+ENTER

	cSql += " ORDER BY D1_DOC,D1_SERIE "+ENTER
	*/
	memowrit("c:\caberj\CABR281.sql",cSql)
	If ( Select("QRY") > 0 )
		QRY->( dbCloseArea() )
	EndIf

	TcQuery cSql Alias "QRY" New

	if eof()
		Alert("Favor verificar os Parametros - Notas Fiscais")
		QRY->( dbCloseArea() )
		return
	endif	   



	IF !QRY->(EOF())
		//		oExcel := FWMSEXCEL():New()
		oExcel := FWMsExcelEx():New()

		//		oExcel:AddworkSheet("Gerente")	
		oExcel:SetTitleFrColor("#000000")
		oExcel:SetBgColorHeader("#238E23")
		//		oExcel:AddTable ("Gerente","Por Gerente")	
		//		oExcel:AddColumn("Gerente","Por Gerente",PADR("VENDA E FATURAMENTO",60," "),1,1)//LEFT,GENERAL



		//		oExcel:AddworkSheet(alltrim(mv_par01)+"pedidos.xml")

		//oExcel:SetCelFrColor("#FFFFFF")


		oExcel:AddworkSheet("Documentos")
		oExcel:AddTable ("Documentos" ,"Documentos entrada")
		oExcel:AddColumn("Documentos" ,"Documentos entrada"  ,"Empresa",2,1)//LEFT,GENERAL
		oExcel:AddColumn("Documentos" ,"Documentos entrada"  ,"Dt_Emissao",2,1)//CENTER,GENERAL
		oExcel:AddColumn("Documentos" ,"Documentos entrada"  ,"Dt_Dititacao",2,1)
		oExcel:AddColumn("Documentos" ,"Documentos entrada"  ,"Nota",2,1)
		oExcel:AddColumn("Documentos" ,"Documentos entrada"  ,"Serie",2,1)
		oExcel:AddColumn("Documentos" ,"Documentos entrada"  ,"C.Custo",2,1)
		oExcel:AddColumn("Documentos" ,"Documentos entrada"  ,"Fornecedor",2,1)
		oExcel:AddColumn("Documentos" ,"Documentos entrada"  ,"Loja",2,1)
		oExcel:AddColumn("Documentos" ,"Documentos entrada"  ,"Nome",2,1)
		oExcel:AddColumn("Documentos" ,"Documentos entrada"  ,"Codigo",2,1)
		oExcel:AddColumn("Documentos" ,"Documentos entrada"  ,"Descricao",2,1)
		oExcel:AddColumn("Documentos" ,"Documentos entrada"  ,"Historico",2,1)
		oExcel:AddColumn("Documentos" ,"Documentos entrada"  ,"Valor_Unit",2,2)
		oExcel:AddColumn("Documentos" ,"Documentos entrada"  ,"Quantidade",2,2)
		oExcel:AddColumn("Documentos" ,"Documentos entrada"  ,"Total",2,2)
		oExcel:AddColumn("Documentos" ,"Documentos entrada"  ,"TES",2,1)
		oExcel:AddColumn("Documentos" ,"Documentos entrada"  ,"VENCIMENTO",2,1)
		oExcel:AddColumn("Documentos" ,"Documentos entrada"  ,"Parcela",2,1)
		oExcel:AddColumn("Documentos" ,"Documentos entrada"  ,"Val.Parcela",2,2)
		oExcel:AddColumn("Documentos" ,"Documentos entrada"  ,"Saldo",2,2)
		oExcel:AddColumn("Documentos" ,"Documentos entrada"  ,"Dt.Baixa",2,1)

		/*
		oExcel:AddColumn("Documentos" ,"Documentos entrada"  ,"Parcela",2,1)
		oExcel:AddColumn("Documentos" ,"Documentos entrada"  ,"Dt.Baixa",2,1)
		oExcel:AddColumn("Documentos" ,"Documentos entrada"  ,"Saldo",2,2)
		oExcel:AddColumn("Documentos" ,"Documentos entrada"  ,"Val.Parcela",2,2)
		*/


	ENDIF



	DbSelectArea("SM0")  // Seleciona arquivo de empresa
	If SM0->(DbSeek(cEmpAnt))  // Posicione registro
		cNmEmpFil := SM0->M0_NOMECOM  // Nome da empresa/filial
	EndIf




	WHILE !QRY->(EOF())

		cemp1 				:= cNmEmpFil
		//				cemissao 			:= dtoc(stod(QRY->F1_EMISSAO))
		//				DTDIGIT 			:= dtoc(stod(QRY->F1_DTDIGIT))
		DOC1 				:= QRY->D1_DOC
		D1SERIE1  			:= QRY->D1_SERIE
		//				D1CC	 			:= QRY->D1_CC
		F1FORNECE1  		:= QRY->F1_FORNECE
		F1LOJA1			:= QRY->F1_LOJA
		//				A2NOME		 		:= QRY->A2_NOME
		//				D1COD	 			:= QRY->D1_COD
		//				B1DESC		 		:= QRY->B1_DESC
		//				D1HIST	 			:= QRY->D1_HIST
		//				D1VUNIT	 		:= QRY->D1_VUNIT
		//				D1QUANT 			:= QRY->D1_QUANT
		//				D1TOTAL  			:= QRY->D1_TOTAL
		//				D1TES 	 			:= QRY->D1_TES
		//				E2VENCREA	 		:= QRY->E2_VENCREA
		//				E2BAIXA	 		:= dtoc(stod(QRY->E2_BAIXA))

		nF1_VALBRUT       := QRY->F1_VALBRUT

		Do While (DOC1 = QRY->D1_DOC) .and. (D1SERIE1  = QRY->D1_SERIE) .and. (F1FORNECE1 = QRY->F1_FORNECE) .and. (F1LOJA1	= QRY->F1_LOJA)

			cemp 				:= cNmEmpFil
			cemissao 			:= dtoc(stod(QRY->F1_EMISSAO))
			DTDIGIT 			:= dtoc(stod(QRY->F1_DTDIGIT))
			DOC 				:= QRY->D1_DOC
			D1SERIE  			:= QRY->D1_SERIE
			D1CC	 			:= QRY->D1_CC
			F1FORNECE  		:= QRY->F1_FORNECE
			F1LOJA	 			:= QRY->F1_LOJA
			A2NOME		 		:= QRY->A2_NOME
			D1COD	 			:= QRY->D1_COD
			B1DESC		 		:= QRY->B1_DESC
			D1HIST	 			:= QRY->D1_HIST
			D1VUNIT	 		:= QRY->D1_VUNIT
			D1QUANT 			:= QRY->D1_QUANT
			D1TOTAL  			:= QRY->D1_TOTAL
			D1TES 	 			:= QRY->D1_TES
			//E2VENCREA	 		:= QRY->E2_VENCREA
			//E2BAIXA	 		:= dtoc(stod(QRY->E2_BAIXA))






			oExcel:AddRow("Documentos" ,"Documentos entrada",{cemp,;
			cemissao	,;
			DTDIGIT		,;
			DOC	,;
			D1SERIE	,;
			D1CC	,;
			F1FORNECE	,;
			F1LOJA			,;
			A2NOME	,;
			D1COD    	,;
			B1DESC	,;
			D1HIST  	,;
			D1VUNIT  	,;
			D1QUANT  	,;
			D1TOTAL  	,;
			D1TES  	,;
			" "  	,;
			" "  	,;
			" "  	,;
			" "  	,;
			" "  	})
			**************************************************************************************************************************		

			lGera := .T.
			DBSELECTAREA("QRY")
			DBSKIP()
		enddo
		//ALERT("FINAL DO 1 ENDDO")

		cSq2 := "   SELECT E2_FILIAL,E2_NUM,E2_PREFIXO,E2_FORNECE,E2_LOJA,E2_VALOR,E2_VENCREA,E2_PARCELA,E2_BAIXA,E2_SALDO "+ENTER
		cSq2 += "   							FROM "+RETSQLNAME("SE2")+" "+ENTER
		cSq2 += " 							WHERE D_E_L_E_T_<>'*' "+ENTER
		cSq2 += " 							AND E2_FILIAL = '"+xFilial("SE2")+"' "+ENTER
		cSq2 += " 							AND E2_NUM = '"+DOC1+"' "+ENTER
		cSq2 += " 							AND E2_PREFIXO = '"+D1SERIE1+"' "+ENTER
		cSq2 += " 							AND E2_FORNECE = '"+F1FORNECE1+"' "+ENTER
		cSq2 += " 							AND E2_LOJA = '"+F1LOJA1+"' "+ENTER
		cSq2 += " 							ORDER BY E2_NUM,E2_PARCELA "+ENTER
		// alert(cSq2)
		memowrit("c:\caberj\CABR281E2parcelas.sql",cSq2)
		If ( Select("QR2") > 0 )
			QR2->( dbCloseArea() )
		EndIf
		//	alert ("370")
		TcQuery cSq2 Alias "QR2" New




		if eof()
			Alert("DADOS FINANCEIROS NAO ENCONTRADOS")
			QR2->( dbCloseArea() )
			//                 return
		endif	   

		x := 1
		Do while !eof()

			//alert("383")

			cemp1 			:= cNmEmpFil
			E2VALOR		:= 	QR2->E2_VALOR
			E2VENCREA		:= 	DTOC(STOD(	QR2->E2_VENCREA))
			E2PARCELA		:= 	QR2->E2_PARCELA
			E2BAIXA		:= 	DTOC(STOD(QR2->E2_BAIXA))
			E2SALDO		:= 	QR2->E2_SALDO

			oExcel:AddRow("Documentos" ,"Documentos entrada",{cemp1,;
			" "	,;
			" "		,;
			DOC1	,;
			D1SERIE1	,;
			" "	,;
			F1FORNECE1	,;
			F1LOJA1			,;
			" "	,;
			" "    	,;
			" "	,;
			"FINANCEIRO"  	,;
			" "  	,;
			" "  	,;
			IIF(X=1,nF1_VALBRUT, "  ")   	,;
			" "  	,;
			E2VENCREA  	,;
			E2PARCELA  	,;
			E2VALOR   	,;
			E2SALDO  	,;
			E2BAIXA  	})

			X++
			/*
			nF1_VALBRUT   	,;
			E2VENCREA  	,;
			E2PARCELA  	,;
			E2BAIXA  	,;
			E2SALDO  	,;
			E2VALOR  	})
			*/


			lGera := .T.

			DBSELECTAREA("QR2")
			DBSKIP()
		enddo
		QR2->( dbCloseArea() )
	Enddo		             

	If ( Select("QRY") > 0 ) .AND. lGera
		QRY->( dbCloseArea() )

		oExcel:Activate()



		CT:= TIME()
		nomeEX := "Compras_1"+SUBSTR(CT,1,2)+SUBSTR(CT,4,2)+SUBSTR(CT,7,2)+DTOS(DATE())+".XML"



		oExcel:GetXMLFile(alltrim(mv_par15)+nomeEX)

		oExcelApp := MsExcel():New()
		oExcelApp:WorkBooks:Open(alltrim(mv_par15)+nomeEX) // Abre a planilha
		oExcelApp:SetVisible(.T.)

	EndIf
	Return

	//CRIA PERGUNTAS
	**************************
// Static Function fCriaSx1()
// 	**************************

// 	SX1->(DbSetOrder(1))

// 	If SX1->(!DbSeek(cPerg+aSx1[Len(aSx1),2]))
// 		SX1->(DbSeek(cPerg))
// 		While SX1->(!Eof()) .And. Alltrim(SX1->X1_GRUPO) == Alltrim(cPerg)
// 			SX1->(Reclock("SX1",.F.,.F.))
// 			SX1->(DbDelete())
// 			SX1->(MsunLock())
// 			SX1->(DbSkip())
// 		End
// 		For X1:=2 To Len(aSX1)
// 			SX1->(RecLock("SX1",.T.))
// 			For Z:=1 To Len(aSX1[1])
// 				cCampo := "X1_"+aSX1[1,Z]
// 				SX1->(FieldPut(FieldPos(cCampo),aSx1[X1,Z]))
// 			Next
// 			SX1->(MsunLock())
// 		Next
// 	Endif
// return

User Function Fd7r7()
	Private cFile := ""
	// Opções permitidas
	//GETF_NOCHANGEDIR    // Impede que o diretorio definido seja mudado
	//GETF_LOCALFLOPPY    // Mostra arquivos do drive de Disquete
	//QQGETF_LOCALHARD      // Mostra arquivos dos Drives locais como HD e CD/DVD
	//GETF_NETWORKDRIVE   // Mostra pastas compartilhadas da rede
	//GETF_RETDIRECTORY   // Retorna apenas o diretório e não o nome do arquivo

	MV_PAR15:= cFile := cGetFile('Arquivo *|*.*|Arquivo XML|*.xls','Todos os Drives',0,'C:\',.T.,GETF_LOCALHARD+GETF_NETWORKDRIVE+GETF_RETDIRECTORY,.T.)

return .T.


