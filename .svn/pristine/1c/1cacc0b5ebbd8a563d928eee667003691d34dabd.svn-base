#INCLUDE "RWMAKE.CH"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "TOPCONN.CH"
#INCLUDE "TBICONN.CH"

#DEFINE c_ent CHR(13) + CHR(10)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABR249      ºAutor  ³ Marcela Coimbra    º Data ³ 23/02/2018  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³  Relatório de faturamento por rúbrica                         º±±
±±º          ³  		                                                     º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Projeto CABERJ                                                º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±'±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±º em 8/5/20 Motta inclusao coluna de sinistralidade                        º±±
±±º em 15/12/20 Motta ajuste sinistralidade (usar a bm1)                     º±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
±±º em 01/02/2021 - Colunas acrescentadas conforme chamado: 72293            º±±
±±º em 01/02/2021 - Reestruturação da Query					                 º±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function CABR249()

	Processa({||PCABR249()},'Processando...')

Return

//Função principal
Static Function PCABR249()

	Local a_Cabec 		:= {}
	Local a_Dados 		:= {}
	Local a_Item 		:= {}
	Local a_DadosTmp 	:= {}
	Local n_Count		:= 0

	Private cPerg 		:= "CABR249"
	Private cQuery		:= ""

	Private c_Pivot 	:= ""
	Private c_Pivot2 	:= ""

	//-------------------------------------------------
	//Angelo Henrique - Data: 02/08/2019
	//-------------------------------------------------
	Private c_LotDe		:= ""
	Private c_LotAte	:= ""
	//-------------------------------------------------

	//-------------------------------------------------
	//Angelo Henrique - Data: 30/10/2019
	//-------------------------------------------------
	Private c_MatDe		:= ""
	Private c_MatAte	:= ""
	//-------------------------------------------------

	AjustaSX1(cPerg)

	If Pergunte(cPerg,.T.)

		c_EmpDe		:= Mv_Par01
		c_EmpAte	:= Mv_Par02
		c_CompDe	:= Mv_Par03
		c_CompAte	:= Mv_Par04

		//-------------------------------------------------
		//Angelo Henrique - Data: 02/08/2019
		//-------------------------------------------------
		//Acrescentando os parâmetros para o lote
		//-------------------------------------------------
		c_LotDe		:= Mv_Par05
		c_LotAte	:= Mv_Par06

		//-------------------------------------------------
		//Angelo Henrique - Data: 30/10/2019
		//-------------------------------------------------
		//Acrescentando os parâmetros para a matricula
		//-------------------------------------------------
		c_MatDe		:= Mv_Par07
		c_MatAte	:= Mv_Par08

		//-------------------------------------------------

	else

		Return

	EndIf

	If MV_PAR09 == 1 //SIM

		a_Cabec := {"COMPETENCIA"		,;
			"TITULO"					,;
			"VALOR_TITULO"				,; //Angelo Henrique -- Data:30/10/2019
			"SALDO"						,; //Angelo Henrique -- Data:30/10/2019
			"ABATIMENTO" 				,; //Angelo Henrique -- Data:30/01/2020
			"SALDO_RECEBER"				,; //Angelo Henrique -- Data:30/01/2020
			"SALDO_PARTIDA"				,; //Angelo Henrique -- Data:01/02/2020
			"VALOR_BAIXA"				,; //Angelo Henrique -- Data:30/09/2020 -- Release 27
			"HIST_BAIXA"				,; //Angelo Henrique -- Data:30/09/2020 -- Release 27
			"Nº LOTE DE COBRANÇA"		,;
			"Nº BORDERÔ"				,;
			"EMISSÃO TÍTULO"			,; //Angelo Henrique -- Data:30/10/2019
			"VCTO TÍTULO"				,;
			"CLIENTE"					,; //Angelo henrique -- Data:27/01/2021
			"RAZAO SOCIAL"				,;
			"CODIGO EMPRESA"			,;
			"MATRÍCULA"					,;
			"Nº CONTRATO"				,;
			"Nº SUBCONTRATO"			,;
			"Nº RPS"					,;
			"Nº NOTA FISCAL"			,;
			"EMISSÃO NOTA FISCAL"		,; //Angelo Henrique -- Data:30/10/2019
			"GERA NOTA CP"				,; //Angelo Henrique -- Data:30/10/2019
			"CIDADE NF"					,;
			"LIBERADO PARA IMPRESSÃO?"	,;
			"EMPRESA"					,;
			"TIPO COBRANÇA"				,;
			"FORMA_COBRANCA"			,; //Angelo Henrique -- Data:01/02/2019
			"NIVEL"						,;
			"VENCIMENTO"				,; 
			"SINIS_TRIM"                ,; //Motta 6/5/20
			"SINIS_ANO"                 ,; //Motta 6/5/20
			"DATA_BAIXA" 				,;
			"TP_BAIXA" 					,;
			"BANCO"						,;
			"CONTA"						}

	Else

		a_Cabec := {"COMPETENCIA"		,;
			"TITULO"					,;
			"VALOR_TITULO"				,; //Angelo Henrique -- Data:30/10/2019
			"SALDO"						,; //Angelo Henrique -- Data:30/10/2019
			"ABATIMENTO" 				,; //Angelo Henrique -- Data:30/01/2020
			"SALDO_RECEBER"				,; //Angelo Henrique -- Data:30/01/2020
			"SALDO_PARTIDA"				,; //Angelo Henrique -- Data:01/02/2020
			"Nº LOTE DE COBRANÇA"		,;
			"Nº BORDERÔ"				,;
			"EMISSÃO TÍTULO"			,; //Angelo Henrique -- Data:30/10/2019
			"VCTO TÍTULO"					,;
			"CLIENTE"					,; //Angelo henrique -- Data:27/01/2021
			"RAZAO SOCIAL"				,;
			"CODIGO EMPRESA"			,;
			"MATRÍCULA"					,;
			"Nº CONTRATO"				,;
			"Nº SUBCONTRATO"			,;
			"Nº RPS"					,;
			"Nº NOTA FISCAL"			,;
			"EMISSÃO NOTA FISCAL"		,; //Angelo Henrique -- Data:30/10/2019
			"GERA NOTA CP"					,; //Angelo Henrique -- Data:30/10/2019
			"CIDADE NF"						,;
			"LIBERADO PARA IMPRESSÃO?"	,;
			"EMPRESA"					,;
			"TIPO COBRANÇA"				,;
			"FORMA_COBRANCA"			,; //Angelo Henrique -- Data:01/02/2019
			"NIVEL"						,;
			"VENCIMENTO"				,; 
		"SINIS_TRIM"                ,;//Motta 5/5/20
			"SINIS_ANO"                 }//Motta 5/5/20

	EndIf
	//------------------------------------------------------
	//Angelo Henrique - Data:30/10/2019
	//------------------------------------------------------
	//Colunas com ordem alterada para melhor visualizaçõa
	//------------------------------------------------------
	//"SALDO",;
	//"VALOR_TITULO"}
	//------------------------------------------------------

	cQuery := " SELECT distinct BM1_CODTIP " + c_ent

	cQuery += " FROM "+RetSqlName("SE1")+" SE1  INNER JOIN " + RetSqlName("BM1") + " BM1 ON BM1_FILIAL = ' '" + c_ent
	cQuery += "                                       AND BM1_PREFIX = SE1.E1_PREFIXO" + c_ent
	cQuery += "                                       AND BM1_NUMTIT = SE1.E1_NUM" + c_ent
	cQuery += "                                       AND BM1_CODTIP NOT IN ( '903')" + c_ent
	cQuery += "                                       AND BM1.D_E_L_E_T_ = ' '" + c_ent

	cQuery += "                               INNER JOIN " + RetSqlName("SA1") + " SA1 ON A1_FILIAL = ' ' " + c_ent
	cQuery += "                                         AND A1_COD = E1_CLIENTE " + c_ent
	cQuery += "                                         AND SA1.D_E_L_E_T_ = ' ' " + c_ent

	cQuery += "                               INNER JOIN " + RetSqlName("BG9") + " BG9 ON BG9_FILIAL = ' '" + c_ent
	cQuery += "                                         AND BG9_CODINT = '0001'" + c_ent
	cQuery += "                                         AND BG9_CODIGO = SE1.E1_CODEMP" + c_ent
	cQuery += "                                         AND BG9.D_E_L_E_T_ = ' '" + c_ent

	cQuery += "                               LEFT JOIN " + RetSqlName("BT5") + " BT5 ON BT5_FILIAL = ' '" + c_ent
	cQuery += "                                         AND BT5_CODINT = SE1.E1_CODINT " + c_ent
	cQuery += "                                         AND BT5_CODIGO = SE1.E1_CODEMP " + c_ent
	cQuery += "                                         AND BT5_NUMCON = SE1.E1_NUMCON " + c_ent
	cQuery += "                                         AND BT5.D_E_L_E_T_ = ' ' " + c_ent

	cQuery += "                               LEFT JOIN " + RetSqlName("BQC") + " BQC ON BQC_FILIAL = ' ' " + c_ent
	cQuery += "                                         AND BQC_CODIGO = SE1.E1_CODINT||E1_CODEMP " + c_ent
	cQuery += "                                         AND BQC_NUMCON = SE1.E1_CONEMP " + c_ent
	cQuery += "                                         AND BQC_SUBCON = SE1.E1_SUBCON " + c_ent
	cQuery += "                                         AND BQC.D_E_L_E_T_ = ' ' " + c_ent

	cQuery += "                               LEFT JOIN " + RetSqlName("BA3") + " BA3 ON BA3_FILIAL = ' ' " + c_ent
	cQuery += "                                         AND BA3_CODINT = SE1.E1_CODINT " + c_ent
	cQuery += "                                         AND BA3_CODEMP = SE1.E1_CODEMP " + c_ent
	cQuery += "                                         AND BA3_MATRIC = SE1.E1_MATRIC " + c_ent
	cQuery += "                                         AND BA3.D_E_L_E_T_ = ' ' " + c_ent

	cQuery += " WHERE BM1_FILIAL = ' ' " + c_ent
	cQuery += " AND BM1_CODINT = '0001' " + c_ent
	cQuery += " AND BM1_CODEMP BETWEEN '" + c_EmpDe + "' AND '" + c_EmpAte + "'"  + c_ent
	cQuery += " AND BM1_ANO||BM1_MES BETWEEN '" + c_CompDe + "' AND '" + c_CompAte + "' " + c_ent
	cQuery += " AND SE1.E1_TIPO = 'DP' " + c_ent
	cQuery += " AND SE1.D_E_L_E_T_ = ' ' " + c_ent

	//--------------------------------------------------------------------------------------------------
	//Angelo Henrique - Data: 02/08/2019
	//--------------------------------------------------------------------------------------------------
	//Acrescentando os parâmetros para o lote
	//--------------------------------------------------------------------------------------------------
	If !(Empty(c_LotDe)) .And. !(Empty(c_LotAte))

		cQuery += " AND BM1_PLNUCO BETWEEN '" + c_LotDe + "' AND '" + c_LotAte + "' " + c_ent

	EndIf
	//--------------------------------------------------------------------------------------------------

	//--------------------------------------------------------------------------------------------------
	//Angelo Henrique - Data: 30/10/2019
	//--------------------------------------------------------------------------------------------------
	//Acrescentando os parâmetros para a matricula
	//--------------------------------------------------------------------------------------------------
	If !(Empty(c_MatDe)) .And. !(Empty(c_MatAte)) 

		cQuery += " AND BM1_MATRIC BETWEEN '" + c_MatDe + "' AND '" + c_MatAte + "' " + c_ent

	EndIf
	//--------------------------------------------------------------------------------------------------

	If Select("R248F") > 0
		dbSelectArea("R248F")
		dbCloseArea()
	EndIf

	DbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),"R248F",.T.,.T.)
	if !R248F->( EOF() )
		While !R248F->( EOF() )

			c_Pivot 	+= "'" + R248F->BM1_CODTIP  + "', "
			c_Pivot2 	+= '"'+ "'" + R248F->BM1_CODTIP  + "'" + '"'+ " TIPO_"+R248F->BM1_CODTIP + ", "

			aadd(a_Cabec, "'" + R248F->BM1_CODTIP + "'" )
			aadd(a_Item	, "R249->TIPO_" + R248F->BM1_CODTIP  )

			R248F->( dbSkip() )

		EndDo

		c_Pivot  := substr(c_Pivot , 1, len(c_Pivot) - 2) + " "
		c_Pivot2 := substr(c_Pivot2, 1, len(c_Pivot2) - 2) + " "

		R248F->( dbCloseArea() )

		cQuery := " SELECT 																	" + c_ent
		cQuery += " 	TITULO, 															" + c_ent
		cQuery += "		(																	" + c_ent
		cQuery += "			SELECT 															" + c_ent
		cQuery += "				SE1_INT.E1_SALDO 											" + c_ent
		cQuery += "			FROM 															" + c_ent
		cQuery += "				" + RetSqlName("SE1") + " SE1_INT							" + c_ent
		cQuery += "			WHERE 															" + c_ent
		cQuery += " 			SE1_INT.E1_NUM 			= TITULO 							" + c_ent
		cQuery += " 			AND SE1_INT.E1_PREFIXO 	= PREFIXO 							" + c_ent
		cQuery += " 			AND SE1_INT.E1_PARCELA 	= PARCELA 							" + c_ent
		cQuery += "				AND SE1_INT.E1_TIPO 	= TIPO_TIT 							" + c_ent
		cQuery += " 			AND SE1_INT.D_E_L_E_T_ 	= ' ' 								" + c_ent
		cQuery += " 			AND SE1_INT.E1_CLIENTE 	= CLIENTE 							" + c_ent
		cQuery += "  			AND SE1_INT.E1_LOJA 	= '01' 								" + c_ent
		cQuery += "  			AND SE1_INT.E1_FILIAL 	= '" + xFilial("SE1") + "' 			" + c_ent
		cQuery += " 	) SALDO_TIT, 														" + c_ent
		cQuery += " 	ABATIMENTO, 														" + c_ent //-- ANGELO - Data: 30/01/2021
		cQuery += " 	SALDO_REC, 															" + c_ent //-- ANGELO - Data: 30/01/2021
		cQuery += " 	SALDO_PARTIDA,														" + c_ent //-- ANGELO - Data: 30/01/2021

		If MV_PAR09 == 1 //SIM
			cQuery += " 	HIST_BAIXA ,													" + c_ent //--Angelo Henrique - Data: 30/09/2020 - Release 27
			cQuery += " 	VALOR_BAIXA,													" + c_ent //--Angelo Henrique - Data: 30/09/2020 - Release 27
		EndIf

		cQuery += " 	NOTA_FISCAL, 														" + c_ent
		cQuery += " 	EMISSAO_NFE,														" + c_ent //-- ANGELO - Data: 30/10/2019
		cQuery += " 	GERA_NOTA_CP,														" + c_ent //-- ANGELO - Data: 30/10/2019
		cQuery += " 	NUM_COBRANCA,														" + c_ent
		cQuery += " 	EMISSAO_TIT,														" + c_ent //-- ANGELO - Data: 30/10/2019
		cQuery += " 	BORDERO,  															" + c_ent 
		cQuery += " 	VENCTO_TIT,   														" + c_ent 
		cQuery += " 	RAZAO_SOCIAL, 														" + c_ent 
		cQuery += " 	CLIENTE,															" + c_ent //-- ANGELO - Data: 01/02/2021
		cQuery += " 	CODIGO_EMPRESA,														" + c_ent 
		cQuery += "		CASE 																" + c_ent		
		cQuery += "			WHEN NIVEL = 'FAMILIA' THEN CODINT||CODEMP||MATRIC 				" + c_ent		
		cQuery += "			ELSE    ' '  													" + c_ent
		cQuery += "		END  MATRIC, 														" + c_ent
		cQuery += "		NUMCON,  															" + c_ent
		cQuery += "		SUBCON,  															" + c_ent
		cQuery += "		RPS,																" + c_ent
		
		
		if cEmpAnt == "02"

			//----------------------------------------------------------------------------------------------------
			//Angelo Henrique - Data: 30/10/2019 - Alteração para pegar pela filial se é Niterói ou Rio
			//----------------------------------------------------------------------------------------------------
			//cQuery += "CASE WHEN instr('" + GetMv("MV_XEMPNIT") + "',CODEMP) > 0 THEN 'NIT' "
			//cQuery += "WHEN instr('" + GetMv("MV_XEMPJAU") + "',CODEMP) > 0 THEN 'RIO' "

			cQuery += "		CASE 															" + c_ent
			cQuery += "			WHEN F2_FILIAL = '04' THEN 'NIT' 							" + c_ent
			cQuery += "			WHEN F2_FILIAL = '01' THEN 'RIO' 							" + c_ent
			cQuery += "			ELSE DECODE(MUN_CLIENTE,'04557','RIO','NIT') 				" + c_ent
			cQuery += "		END MUN_CLIENTE, 												" + c_ent
		Else
			cQuery += "		'RIO' MUN_CLIENTE, 												" + c_ent //  CABERJ SOMENTE EMITE NOTA PARA O RIO
		endif
		
		cQuery += " 	CASE 																" + c_ent
		cQuery += " 		WHEN LIB_IMP IN ('L','D') THEN 'SIM'    						" + c_ent
		cQuery += " 		ELSE 'NAO' 														" + c_ent
		cQuery += " 	END LIB_IMP,														" + c_ent

		If MV_PAR09 == 1 //SIM

			cQuery += "		EMPRESA, 														" + c_ent 
			cQuery += "		TIPO_COBRANCA, 													" + c_ent 
			cQuery += "		FORMA_COBRANCA, 												" + c_ent 
			cQuery += "		NIVEL, 															" + c_ent 
			cQuery += "		VENCTO, 														" + c_ent 
			cQuery += "		COMPETENCIA, 													" + c_ent 
			cQuery += "		SIN_TRIM, 														" + c_ent 
			cQuery += "		SIN_ANO, 														" + c_ent 
			cQuery += "		VALOR_TITULO, 													" + c_ent 
			cQuery += "		DATA_BAIXA, 													" + c_ent 
			cQuery += "		TP_BAIXA, 														" + c_ent 
			cQuery += "		BANCO, 															" + c_ent 
			cQuery += "		CONTA, " + c_Pivot2 + " 										" + c_ent //Motta 6/5/20

		Else

			cQuery += "		EMPRESA, 														" + c_ent 
			cQuery += "		TIPO_COBRANCA, 													" + c_ent 
			cQuery += "		FORMA_COBRANCA, 												" + c_ent 
			cQuery += "		NIVEL, 															" + c_ent 
			cQuery += "		VENCTO, 														" + c_ent 
			cQuery += "		COMPETENCIA, 													" + c_ent 
			cQuery += "		SIN_TRIM, 														" + c_ent 
			cQuery += "		SIN_ANO, 														" + c_ent 
			cQuery += "		VALOR_TITULO,  " + c_Pivot2 + " 								" + c_ent //Motta 6/5/20

		EndIf

		cQuery += " 	FROM 																" + c_ent
		cQuery += " 		( 																" + c_ent
		cQuery += " 			SELECT 														" + c_ent
		cQuery += " 				SE1.E1_NUM TITULO,											" + c_ent
		cQuery += "					SE1.E1_TIPO TIPO_TIT,    									" + c_ent
		cQuery += "					SE1.E1_PARCELA PARCELA,    									" + c_ent
		cQuery += "					SE1.E1_PREFIXO PREFIXO,    									" + c_ent
		cQuery += "					SE1.E1_CLIENTE CLIENTE,										" + c_ent
		cQuery += " 				SE1.E1_PLNUCOB NUM_COBRANCA,								" + c_ent

		//-------------------------------------------------------------------------------------------------------------------
		//Inicio - Angelo Henrique - Data:30/01/2020
		//-------------------------------------------------------------------------------------------------------------------
		cQuery += "  				(SE1.E1_IRRF + SE1.E1_CSLL + SE1.E1_COFINS + SE1.E1_PIS) ABATIMENTO, 			" + c_ent
		cQuery += "      			CASE 													" + c_ent
		cQuery += "          			WHEN SE1.E1_SALDO = 0 THEN SE1.E1_SALDO 					" + c_ent
		cQuery += "          			ELSE SE1.E1_SALDO - (SE1.E1_IRRF + SE1.E1_CSLL + SE1.E1_COFINS + SE1.E1_PIS) 	" + c_ent
		cQuery += "      			END 													" + c_ent
		cQuery += "  				SALDO_REC, 												" + c_ent
		cQuery += "  				NVL((SE1.E1_VALOR - SE1_NCC.E1_VALOR),SE1.E1_VALOR) SALDO_PARTIDA," + c_ent
		//-------------------------------------------------------------------------------------------------------------------
		//Fim - Angelo Henrique - Data:30/01/2020
		//-------------------------------------------------------------------------------------------------------------------

		If MV_PAR09 == 1 //SIM
			cQuery += " 	SE5.E5_HISTOR HIST_BAIXA ,										" + c_ent //Angelo Henrique - Data: 30/09/2020 - Release 27
			cQuery += " 	SE5.E5_VALOR  VALOR_BAIXA,										" + c_ent //Angelo Henrique - Data: 30/09/2020 - Release 27
		EndIf

		cQuery += "  	SE1.E1_NUMBOR BORDERO,													" + c_ent
		cQuery += "  	FORMATA_DATA_MS(SE1.E1_EMISSAO) EMISSAO_TIT,							" + c_ent //-- ANGELO - Data: 30/10/2019
		cQuery += "  	FORMATA_DATA_MS(SE1.E1_VENCTO) VENCTO_TIT,								" + c_ent
		cQuery += "     SE1.E1_CODINT CODINT ,													" + c_ent
		cQuery += " 	SE1.E1_CODEMP CODEMP , 													" + c_ent
		cQuery += "  	SE1.E1_MATRIC MATRIC , 													" + c_ent
		cQuery += "		CASE 																" + c_ent
		cQuery += "			WHEN BA3_CONEMP <> ' ' THEN BA3_CONEMP 							" + c_ent
		cQuery += "			ELSE SE1.E1_CONEMP 													" + c_ent
		cQuery += "		END NUMCON, 														" + c_ent				
		cQuery += "		CASE 																" + c_ent
		cQuery += "			WHEN BA3_SUBCON <> ' ' THEN BA3_SUBCON 							" + c_ent
		cQuery += "			ELSE SE1.E1_SUBCON 													" + c_ent
		cQuery += "		END SUBCON, 														" + c_ent		
		cQuery += "  	F2_NFELETR NOTA_FISCAL," + c_ent
		cQuery += "  	SE1.E1_XDOCNF RPS," + c_ent
		cQuery += "  	FORMATA_DATA_MS(F2_EMINFE) EMISSAO_NFE," + c_ent //-- ANGELO - Data: 30/10/2019
		cQuery += "  	NVL(DECODE(BQC_YODONT,'1','SIM','0','NAO',' ','EM BRANCO'),'EM BRANCO') GERA_NOTA_CP," + c_ent //-- ANGELO - Data: 30/10/2019
		cQuery += "  	SE1.E1_YTPEXP LIB_IMP	," + c_ent
		cQuery += "  	NVL(TRIM(BA1_NOMUSR),A1_NOME) RAZAO_SOCIAL," + c_ent
		cQuery += "  	A1_COD_MUN MUN_CLIENTE," + c_ent
		cQuery += " 	BG9_CODIGO CODIGO_EMPRESA," + c_ent
		cQuery += " 	BG9_DESCRI EMPRESA," + c_ent
		cQuery += " 	BA3_TIPPAG TIPO_COBRANCA," + c_ent
		cQuery += " 	SE1.E1_FORMREC FORMA_COBRANCA," + c_ent
		cQuery += " 	(CASE WHEN TRIM(BA3_VENCTO) <> ' ' THEN 'FAMILIA' " + c_ent
		cQuery += "        WHEN TRIM(BQC_VENCTO) <> ' ' THEN 'SUBCONTRATO'" + c_ent
		cQuery += "        WHEN TRIM(BT5_VENCTO) <> ' ' THEN 'CONTRATO' ELSE 'EMPRESA' END ) NIVEL," + c_ent
		cQuery += " 	(CASE WHEN TRIM(BA3_VENCTO) <> ' ' THEN BA3_VENCTO " + c_ent
		cQuery += "        WHEN TRIM(BQC_VENCTO) <> ' ' THEN BQC_VENCTO  " + c_ent
		cQuery += "        WHEN TRIM(BT5_VENCTO) <> ' ' THEN BT5_VENCTO ELSE BG9_VENCTO END ) VENCTO," + c_ent
		cQuery += "  	SE1.E1_MESBASE||'/'||SE1.E1_ANOBASE COMPETENCIA," + c_ent
		//Motta 6/5/20
		cQuery += " 	CASE 									" + c_ent
		cQuery += " 		WHEN TRIM(SE1.E1_MATRIC) = ' ' THEN		" + c_ent
		cQuery += " 		RETORNA_SINISTRAL_CONTR_SUB(" + Iif(cEmpAnt == "01","'C'","'I'") + ",'S',BM1_CODINT,BM1_CODEMP,BM1_MATRIC, 	" + c_ent
		cQuery += "                              		ADD_MONTHS(TO_DATE(SE1.E1_ANOBASE||SE1.E1_MESBASE,'YYYYMM'),-3), 				" + c_ent
		cQuery += "                              		ADD_MONTHS(TO_DATE(SE1.E1_ANOBASE||SE1.E1_MESBASE,'YYYYMM'),-1)) 				" + c_ent
		cQuery += " 		WHEN TRIM(SE1.E1_MATRIC) <> ' ' THEN 																		" + c_ent
		cQuery += " 		RETORNA_SINISTRAL_FAM_MS_CAB(" + Iif(cEmpAnt == "01","'C'","'I'") + ",'S',BM1_CODINT,BM1_CODEMP,BM1_MATRIC, " + c_ent
		cQuery += "                              		ADD_MONTHS(TO_DATE(SE1.E1_ANOBASE||SE1.E1_MESBASE,'YYYYMM'),-3),				" + c_ent
		cQuery += "                              		ADD_MONTHS(TO_DATE(SE1.E1_ANOBASE||SE1.E1_MESBASE,'YYYYMM'),-1)) 				" + c_ent
		cQuery += " 	END SIN_TRIM, 																									" + c_ent
		cQuery += " 	CASE 																											" + c_ent
		cQuery += " 		WHEN TRIM(SE1.E1_MATRIC) = ' ' THEN																			" + c_ent
		cQuery += " 		RETORNA_SINISTRAL_CONTR_SUB(" + Iif(cEmpAnt == "01","'C'","'I'") + ",'S',BM1_CODINT,BM1_CODEMP,BM1_MATRIC, 	" + c_ent
		cQuery += "                             	 	ADD_MONTHS(TO_DATE(SE1.E1_ANOBASE||SE1.E1_MESBASE,'YYYYMM'),-12), 				" + c_ent
		cQuery += "                              		ADD_MONTHS(TO_DATE(SE1.E1_ANOBASE||SE1.E1_MESBASE,'YYYYMM'),-1))  				" + c_ent
		cQuery += " 		WHEN TRIM(SE1.E1_MATRIC) <> ' ' THEN 																			" + c_ent
		cQuery += " 		RETORNA_SINISTRAL_FAM_MS_CAB(" + Iif(cEmpAnt == "01","'C'","'I'") + ",'S',BM1_CODINT,BM1_CODEMP,BM1_MATRIC, " + c_ent
		cQuery += "                              		ADD_MONTHS(TO_DATE(SE1.E1_ANOBASE||SE1.E1_MESBASE,'YYYYMM'),-12), 				" + c_ent
		cQuery += "                              		ADD_MONTHS(TO_DATE(SE1.E1_ANOBASE||SE1.E1_MESBASE,'YYYYMM'),-1))  				" + c_ent
		cQuery += " 	END SIN_ANO , 																									" + c_ent
		//Fim Motta 6/5/20
		cQuery += "  	BM1_CODTIP  TIPO,																								" + c_ent
		cQuery += "  	SE1.E1_VALOR VALOR_TITULO,       																				" + c_ent

		If MV_PAR09 == 1 //SIM

			cQuery += "  	SIGA.FORMATA_DATA_MS(SE5.E5_DATA) DATA_BAIXA,	" + c_ent
			cQuery += "  	SE5.E5_MOTBX TP_BAIXA,						" + c_ent
			cQuery += "  	SE5.E5_BANCO BANCO,						" + c_ent
			cQuery += "  	SE5.E5_CONTA CONTA,						" + c_ent

		EndIf

		cQuery += "  	SUM (DECODE ( BM1_TIPO , 1 ,BM1_VALOR, (BM1_VALOR*-1))) VALOR, " + c_ent
		cQuery += "  	SF2.F2_FILIAL" + c_ent //-- ANGELO - Data: 30/10/2019


		cQuery += " 	FROM " + RetSqlName("SE1") + "  SE1  INNER JOIN " + RetSqlName("BM1") + "  BM1 ON BM1_FILIAL = ' '" + c_ent
		cQuery += "                                       AND BM1_PREFIX = SE1.E1_PREFIXO" + c_ent
		cQuery += "                                       AND BM1_NUMTIT = SE1.E1_NUM" + c_ent
		cQuery += "                                       AND BM1_CODTIP NOT IN ( '903')" + c_ent

		//--------------------------------------------------------------------------------------------------
		//Angelo Henrique - Data: 30/10/2019
		//--------------------------------------------------------------------------------------------------
		//Acrescentando os parâmetros para a matricula
		//--------------------------------------------------------------------------------------------------
		If !(Empty(c_MatDe)) .And. !(Empty(c_MatAte))

			cQuery += "                                       AND BM1_MATRIC BETWEEN '" + c_MatDe + "' AND '" + c_MatAte + "' " + c_ent

		EndIf
		//--------------------------------------------------------------------------------------------------


		cQuery += "                                       AND BM1.D_E_L_E_T_ = ' '" + c_ent

		cQuery += "                               INNER JOIN " + RetSqlName("SA1") + "  SA1 ON A1_FILIAL = ' ' " + c_ent
		cQuery += "                                         AND A1_COD = SE1.E1_CLIENTE " + c_ent
		cQuery += "                                         AND SA1.D_E_L_E_T_ = ' ' " + c_ent

		cQuery += "                               INNER JOIN " + RetSqlName("BG9") + "  BG9 ON BG9_FILIAL = ' '" + c_ent
		cQuery += "                                         AND BG9_CODINT = '0001'" + c_ent
		cQuery += "                                         AND BG9_CODIGO = SE1.E1_CODEMP" + c_ent
		cQuery += "                                         AND BG9.D_E_L_E_T_ = ' '" + c_ent

		cQuery += "                               LEFT JOIN " + RetSqlName("BT5") + "  BT5 ON BT5_FILIAL = ' '" + c_ent
		cQuery += "                                         AND BT5_CODINT = SE1.E1_CODINT " + c_ent
		cQuery += "                                         AND BT5_CODIGO = SE1.E1_CODEMP " + c_ent
		cQuery += "                                         AND BT5_NUMCON = SE1.E1_CONEMP " + c_ent
		cQuery += "                                         AND BT5.D_E_L_E_T_ = ' ' " + c_ent

		cQuery += "                               LEFT JOIN " + RetSqlName("BQC") + "  BQC ON BQC_FILIAL = ' ' " + c_ent
		cQuery += "                                         AND BQC_CODIGO = SE1.E1_CODINT||SE1.E1_CODEMP " + c_ent
		cQuery += "                                         AND BQC_NUMCON = SE1.E1_CONEMP " + c_ent
		cQuery += "                                         AND BQC_SUBCON = SE1.E1_SUBCON " + c_ent
		cQuery += "                                         AND BQC.D_E_L_E_T_ = ' ' " + c_ent

		cQuery += "                               LEFT JOIN " + RetSqlName("BA3") + "  BA3 ON BA3_FILIAL = ' ' " + c_ent
		cQuery += "                                         AND BA3_CODINT = SE1.E1_CODINT " + c_ent
		cQuery += "                                         AND BA3_CODEMP = SE1.E1_CODEMP " + c_ent
		cQuery += "                                         AND BA3_MATRIC = SE1.E1_MATRIC " + c_ent
		cQuery += "                                         AND BA3.D_E_L_E_T_ = ' ' " + c_ent

		//INICIO - Angelo Henrique - Data:27/01/2021
		cQuery += "                               LEFT JOIN " + RetSqlName("BA1") + "  BA1 ON BA1_FILIAL = ' ' " + c_ent
		cQuery += "                                         AND BA1_CODINT = SE1.E1_CODINT 	" + c_ent
		cQuery += "                                         AND BA1_CODEMP = SE1.E1_CODEMP 	" + c_ent
		cQuery += "                                         AND BA1_MATRIC = SE1.E1_MATRIC 	" + c_ent
		cQuery += "                                         AND BA1_TIPUSU = 'T'  		" + c_ent
		cQuery += "                                         AND BA1.D_E_L_E_T_ = ' ' 	" + c_ent
		//FIM - Angelo Henrique - Data:27/01/2021

		cQuery += "                                LEFT JOIN "+RetSqlName("SF2")+"  SF2 ON 					" + c_ent
		cQuery += "                                         F2_DOC = SE1.E1_XDOCNF " + c_ent
		cQuery += "                                         AND F2_SERIE = SE1.E1_XSERNF" + c_ent
		cQuery += "                                         AND SF2.F2_CLIENTE  = SE1.E1_CLIENTE " + c_ent //-- ANGELO - Data: 30/10/2019
		cQuery += "                                         AND SF2.F2_LOJA     = SE1.E1_LOJA" + c_ent //-- ANGELO - Data: 30/10/2019
		cQuery += "                                         AND SF2.D_E_L_E_T_ = ' ' " + c_ent

		If MV_PAR09 == 1 //SIM

			cQuery += "                            LEFT JOIN "+RetSqlName("SE5")+"  SE5 ON 				" + c_ent
			cQuery += "                                         SE5.E5_FILIAL 		= SE1.E1_FILIAL		" + c_ent
			cQuery += "                                         AND SE5.E5_PREFIXO 	= SE1.E1_PREFIXO	" + c_ent
			cQuery += "                                         AND SE5.E5_NUMERO 	= SE1.E1_NUM		" + c_ent
			cQuery += "                                         AND SE5.E5_PARCELA 	= SE1.E1_PARCELA	" + c_ent
			cQuery += "                                         AND SE5.E5_TIPO 	= SE1.E1_TIPO		" + c_ent
			cQuery += "                                         AND SE5.E5_CLIFOR 	= SE1.E1_CLIENTE	" + c_ent
			cQuery += "                                         AND SE5.E5_LOJA 	= SE1.E1_LOJA		" + c_ent
			cQuery += "                                         AND SE5.D_E_L_E_T_ 	= ' ' 				" + c_ent

		EndIf

		cQuery += "                                LEFT JOIN " + RetSqlName("SE1") + " SE1_NCC ON 					" + c_ent
		cQuery += "                                             SE1_NCC.E1_FILIAL       = SE1.E1_FILIAL" + c_ent
        cQuery += "                                             AND SE1_NCC.E1_PREFIXO  = SE1.E1_PREFIXO" + c_ent
        cQuery += "                                             AND SE1_NCC.E1_NUM      = SE1.E1_NUM" + c_ent
        cQuery += "                                             AND SE1_NCC.E1_PARCELA  = SE1.E1_PARCELA" + c_ent
        cQuery += "                                             AND SE1_NCC.E1_TIPO     = 'NCC'" + c_ent
        cQuery += "                                             AND SE1_NCC.E1_CLIENTE  = SE1.E1_CLIENTE" + c_ent
        cQuery += "                                             AND SE1_NCC.E1_LOJA     = SE1.E1_LOJA" + c_ent
        cQuery += "                                             AND SE1_NCC.D_E_L_E_T_  = ' '" + c_ent

		cQuery += " WHERE BM1_FILIAL = ' ' " + c_ent
		cQuery += " AND BM1_CODINT = '0001' " + c_ent
		cQuery += " AND BM1_CODEMP BETWEEN '" + c_EmpDe + "' AND '" + c_EmpAte + "'"  + c_ent
		cQuery += " AND BM1_ANO||BM1_MES BETWEEN '" + c_CompDe + "' AND '" + c_CompAte + "' " + c_ent


		//--------------------------------------------------------------------------------------------------
		//Angelo Henrique - Data: 02/08/2019
		//--------------------------------------------------------------------------------------------------
		//Acrescentando os parâmetros para o lote
		//--------------------------------------------------------------------------------------------------
		If !(Empty(c_LotDe)) .And. !(Empty(c_LotAte))

			cQuery += " AND BM1_PLNUCO BETWEEN '" + c_LotDe + "' AND '" + c_LotAte + "' " + c_ent

		EndIf
		//--------------------------------------------------------------------------------------------------

		//--------------------------------------------------------------------------------------------------
		//Angelo Henrique - Data: 30/10/2019
		//--------------------------------------------------------------------------------------------------
		//Acrescentando os parâmetros para a matricula
		//--------------------------------------------------------------------------------------------------
		If !(Empty(c_MatDe)) .And. !(Empty(c_MatAte))

			cQuery += " AND SE1.E1_MATRIC BETWEEN '" + c_MatDe + "' AND '" + c_MatAte + "' " + c_ent

		EndIf
		//--------------------------------------------------------------------------------------------------

		// cQuery += " and bm1_numtit = '003154927' " + c_ent
		cQuery += " AND SE1.E1_TIPO = 'DP' " + c_ent
		cQuery += " AND SE1.D_E_L_E_T_ = ' ' " + c_ent
		cQuery += " GROUP BY   SE1.E1_NUM ," + c_ent
		cQuery += "    SE1.E1_TIPO ," + c_ent
		cQuery += "SE1.E1_PARCELA ," + c_ent
		cQuery += "SE1.E1_PREFIXO ," + c_ent
		cQuery += "SE1.E1_CLIENTE ,	" + c_ent
		cQuery += " SE1.E1_PLNUCOB," + c_ent

		//-------------------------------------------------------------------------------------------------------------------
		//Inicio - Angelo Henrique - Data:30/01/2020
		//-------------------------------------------------------------------------------------------------------------------
		cQuery += "  (SE1.E1_IRRF + SE1.E1_CSLL + SE1.E1_COFINS + SE1.E1_PIS), " + c_ent
		cQuery += "      CASE " + c_ent
		cQuery += "          WHEN SE1.E1_SALDO = 0 THEN SE1.E1_SALDO " + c_ent
		cQuery += "          ELSE SE1.E1_SALDO - (SE1.E1_IRRF + SE1.E1_CSLL + SE1.E1_COFINS + SE1.E1_PIS) " + c_ent
		cQuery += "      END, " + c_ent
		cQuery += "  				NVL((SE1.E1_VALOR - SE1_NCC.E1_VALOR),SE1.E1_VALOR) ," + c_ent
		//-------------------------------------------------------------------------------------------------------------------
		//Fim - Angelo Henrique - Data:30/01/2020
		//-------------------------------------------------------------------------------------------------------------------

		If MV_PAR09 == 1 //SIM
			cQuery += " SE5.E5_HISTOR ," + c_ent //Angelo Henrique - Data: 30/09/2020 - Release 27
			cQuery += " SE5.E5_VALOR  ," + c_ent //Angelo Henrique - Data: 30/09/2020 - Release 27
		Endif		
		cQuery += " SE1.E1_NUMBOR ," + c_ent
		cQuery += " SE1.E1_EMISSAO," + c_ent //-- ANGELO - Data: 30/10/2019
		cQuery += " SE1.E1_VENCTO," + c_ent
		cQuery += " NVL(TRIM(BA1_NOMUSR),A1_NOME) ," + c_ent
		cQuery += " A1_COD_MUN," + c_ent
		cQuery += " BG9_CODIGO ," + c_ent
		cQuery += " SE1.E1_CODINT  ," + c_ent
		cQuery += " SE1.E1_CODEMP  , " + c_ent
		cQuery += " SE1.E1_MATRIC  ," + c_ent
		cQuery += " case when ba3_conemp <> ' ' then ba3_conemp else SE1.E1_CONEMP end , " + c_ent
		cQuery += " case when ba3_subcon <> ' ' then ba3_subcon else SE1.E1_SUBCON end , " + c_ent		
		cQuery += "  SE1.E1_XDOCNF  ,F2_NFELETR , " + c_ent
		cQuery += "  F2_EMINFE  ," + c_ent //-- ANGELO - Data: 30/10/2019
		cQuery += "  BQC_YODONT ," + c_ent //-- ANGELO - Data: 30/10/2019
		cQuery += "  SE1.E1_YTPEXP  ," + c_ent
		cQuery += "  BG9_CODIGO ," + c_ent
		cQuery += "  BG9_DESCRI ," + c_ent
		cQuery += "  BA3_TIPPAG ," + c_ent
		cQuery += "  SE1.E1_FORMREC," + c_ent
		cQuery += "  (CASE WHEN TRIM(BA3_VENCTO) <> ' ' THEN 'FAMILIA' " + c_ent
		cQuery += "         WHEN TRIM(BQC_VENCTO) <> ' ' THEN 'SUBCONTRATO'" + c_ent
		cQuery += "         WHEN TRIM(BT5_VENCTO) <> ' ' THEN 'CONTRATO' ELSE 'EMPRESA' END ) ," + c_ent
		cQuery += "  (CASE WHEN TRIM(BA3_VENCTO) <> ' ' THEN BA3_VENCTO " + c_ent
		cQuery += "         WHEN TRIM(BQC_VENCTO) <> ' ' THEN BQC_VENCTO " + c_ent
		cQuery += "         WHEN TRIM(BT5_VENCTO) <> ' ' THEN BT5_VENCTO ELSE BG9_VENCTO END ) ," + c_ent
		cQuery += "   SE1.E1_MESBASE||'/'||SE1.E1_ANOBASE ," + c_ent
		//Motta 6/5/20
		cQuery += " CASE 									" + c_ent
		cQuery += " 	WHEN TRIM(SE1.E1_MATRIC) = ' ' THEN		" + c_ent
		cQuery += " 	RETORNA_SINISTRAL_CONTR_SUB(" + Iif(cEmpAnt == "01","'C'","'I'") + ",'S',BM1_CODINT,BM1_CODEMP,BM1_MATRIC, " + c_ent
		cQuery += "                              ADD_MONTHS(TO_DATE(SE1.E1_ANOBASE||SE1.E1_MESBASE,'YYYYMM'),-3), " + c_ent
		cQuery += "                              ADD_MONTHS(TO_DATE(SE1.E1_ANOBASE||SE1.E1_MESBASE,'YYYYMM'),-1)) " + c_ent
		cQuery += " 	WHEN TRIM(SE1.E1_MATRIC) <> ' ' THEN
		cQuery += " 	RETORNA_SINISTRAL_FAM_MS_CAB(" + Iif(cEmpAnt == "01","'C'","'I'") + ",'S',BM1_CODINT,BM1_CODEMP,BM1_MATRIC, " + c_ent
		cQuery += "                              ADD_MONTHS(TO_DATE(SE1.E1_ANOBASE||SE1.E1_MESBASE,'YYYYMM'),-3), " + c_ent
		cQuery += "                              ADD_MONTHS(TO_DATE(SE1.E1_ANOBASE||SE1.E1_MESBASE,'YYYYMM'),-1)) " + c_ent
		cQuery += " END, " + c_ent
		cQuery += " CASE 									" + c_ent
		cQuery += " 	WHEN TRIM(SE1.E1_MATRIC) = ' ' THEN		" + c_ent
		cQuery += " 	RETORNA_SINISTRAL_CONTR_SUB(" + Iif(cEmpAnt == "01","'C'","'I'") + ",'S',BM1_CODINT,BM1_CODEMP,BM1_MATRIC, " + c_ent
		cQuery += "                              ADD_MONTHS(TO_DATE(SE1.E1_ANOBASE||SE1.E1_MESBASE,'YYYYMM'),-12), " + c_ent
		cQuery += "                              ADD_MONTHS(TO_DATE(SE1.E1_ANOBASE||SE1.E1_MESBASE,'YYYYMM'),-1))  " + c_ent
		cQuery += " 	WHEN TRIM(SE1.E1_MATRIC) <> ' ' THEN
		cQuery += " 	RETORNA_SINISTRAL_FAM_MS_CAB(" + Iif(cEmpAnt == "01","'C'","'I'") + ",'S',BM1_CODINT,BM1_CODEMP,BM1_MATRIC, " + c_ent
		cQuery += "                              ADD_MONTHS(TO_DATE(SE1.E1_ANOBASE||SE1.E1_MESBASE,'YYYYMM'),-12), " + c_ent
		cQuery += "                              ADD_MONTHS(TO_DATE(SE1.E1_ANOBASE||SE1.E1_MESBASE,'YYYYMM'),-1))  " + c_ent
		cQuery += " END, " + c_ent
		//Fim Motta 6/5/20
		cQuery += "   BM1_CODTIP  ,	" + c_ent
		cQuery += "   SE1.E1_VALOR, 	" + c_ent

		If MV_PAR09 == 1 //SIM

			cQuery += "   SE5.E5_DATA,		" + c_ent
			cQuery += "   SE5.E5_MOTBX,	" + c_ent
			cQuery += "   SE5.E5_BANCO,	" + c_ent
			cQuery += "   SE5.E5_CONTA,	" + c_ent

		EndIf

		cQuery += "   F2_FILIAL 										" + c_ent //-- ANGELO - Data: 30/10/2019
		cQuery += "     )   PIVOT ( SUM(VALOR)  						" + c_ent
		cQuery += "                 FOR TIPO IN ( "  + c_Pivot + " )) A " + c_ent
		cQuery += " ORDER BY 1											" + c_ent

		//MemoWrite( "c:\temp\cabr249_sql.sql" , cQuery )

		cQuery := ChangeQuery( cQuery )
		DbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),"R249",.T.,.T.)

		// Monta Cabecalho "Fixo"

		While ! R249->(Eof())

			IncProc()
			a_DadosTmp := {}

			AADD(a_DadosTmp,"'"+R249->COMPETENCIA     	) // Angelo Henrique - Data:27/01/2021 - Ordem alterada
			AADD(a_DadosTmp,"'"+R249->TITULO		   	)
			AADD(a_DadosTmp,R249->VALOR_TITULO         	) // Angelo Henrique - Data:30/10/2019 - Ordem alterada
			AADD(a_DadosTmp,R249->SALDO_TIT			   	) // Angelo Henrique - Data:30/10/2019 - Ordem alterada
			AADD(a_DadosTmp,R249->ABATIMENTO		   	) // Angelo Henrique - Data:30/01/2020
			AADD(a_DadosTmp,R249->SALDO_REC		   		) // Angelo Henrique - Data:30/01/2021
			AADD(a_DadosTmp,R249->SALDO_PARTIDA	   		) // Angelo Henrique - Data:01/02/2021			

			If MV_PAR09 == 1 //SIM
				AADD(a_DadosTmp,R249->VALOR_BAIXA	   	) // Angelo Henrique - Data:30/09/2020 - RELEASE 27
				AADD(a_DadosTmp,R249->HIST_BAIXA	   	) // Angelo Henrique - Data:30/09/2020 - RELEASE 27
			EndIf

			AADD(a_DadosTmp,"'"+R249->NUM_COBRANCA	   	)
			AADD(a_DadosTmp,"'"+R249->BORDERO		   	)
			AADD(a_DadosTmp,"'"+R249->EMISSAO_TIT	   	) // Angelo Henrique - Data:30/10/2019
			AADD(a_DadosTmp,"'"+R249->VENCTO_TIT	   	)
			AADD(a_DadosTmp,"'"+R249->CLIENTE		 	) // Angelo Henrique - Data:01/02/2021			
			AADD(a_DadosTmp,R249->RAZAO_SOCIAL	 	   	)			
			AADD(a_DadosTmp,"'"+R249->CODIGO_EMPRESA   	)

			AADD(a_DadosTmp,"'"+R249->MATRIC 		   	)
			AADD(a_DadosTmp,"'"+R249->NUMCON 		   	)
			AADD(a_DadosTmp,"'"+R249->SUBCON 		   	)
			AADD(a_DadosTmp,"'"+R249->RPS 			   	)
			AADD(a_DadosTmp,"'"+R249->NOTA_FISCAL	   	) // NF NOTA FISCAL
			AADD(a_DadosTmp,"'"+R249->EMISSAO_NFE	   	) // Angelo Henrique - Data:30/10/2019
			AADD(a_DadosTmp,"'"+R249->GERA_NOTA_CP	   	) // Angelo Henrique - Data:30/10/2019
			AADD(a_DadosTmp,"'"+R249->MUN_CLIENTE 	   	)
			AADD(a_DadosTmp,"'"+R249->LIB_IMP 		   	)
			AADD(a_DadosTmp,"'"+R249->EMPRESA 		   	)

			AADD(a_DadosTmp,"'"+R249->TIPO_COBRANCA   	)
			AADD(a_DadosTmp,"'"+R249->FORMA_COBRANCA  	)
			AADD(a_DadosTmp,R249->NIVEL			   	 	)
			AADD(a_DadosTmp,R249->VENCTO               	)
			//AADD(a_DadosTmp,"'"+R249->COMPETENCIA     	)
			AADD(a_DadosTmp,R249->SIN_TRIM              ) //Motta 6/5/20
			AADD(a_DadosTmp,R249->SIN_ANO               ) //Motta 6/5/20			

			If MV_PAR09 == 1 //SIM

				AADD(a_DadosTmp,"'"+R249->DATA_BAIXA    )
				AADD(a_DadosTmp,R249->TP_BAIXA     		)
				AADD(a_DadosTmp,"'"+R249->BANCO     	)
				AADD(a_DadosTmp,"'"+R249->CONTA     	)

			EndIf


			for n_Count := 1 to Len(a_Item)

				AADD(a_DadosTmp,&(a_Item[n_Count]))

			Next

			aadd( a_Dados, a_DadosTmp )

			R249->(DbSkip())

		EndDo

		aAdd(a_Dados ,{"Relatório Extraído em: " + DToC(dDataBase) + ", Horário: " + TIME()} )
		
		aAdd(a_Dados ,{"Fim"} )
		//Abre excel
		DlgToExcel({{"ARRAY"," " ,a_Cabec,a_Dados}})

		If Select("R249") > 0
			dbSelectArea("R249")
			dbCloseArea()
		EndIf
	else
		msgalert("Não há dados para extração do Maprec com os parâmetros informados.","ATENÇÃO")
	Endif
Return

*************************************************************************************************************************
//AJUSTAR "COPPRO"
Static Function AjustaSX1()

	PutSx1(cPerg,"01","Empresa de:  "  		,"","","mv_ch01","C",04,0,0,"C","","","","","mv_par01","","","","","","","","","","","","","","","","",{},{},{})
	PutSx1(cPerg,"02","Empresa ate: "  		,"","","mv_ch02","C",04,0,0,"C","","","","","mv_par02","","","","","","","","","","","","","","","","",{},{},{})
	PutSx1(cPerg,"03","Competencia de:  "  	,"","","mv_ch03","C",06,0,0,"C","","","","","mv_par03","","","","","","","","","","","","","","","","",{},{},{})
	PutSx1(cPerg,"04","Competencia ate:"  	,"","","mv_ch04","C",06,0,0,"C","","","","","mv_par04","","","","","","","","","","","","","","","","",{},{},{})

	//-------------------------------------------------------
	//Angelo Henrique - Data: 02/08/2019
	//-------------------------------------------------------
	//Acrescentado parâmetros para poder filtrar o lote
	//-------------------------------------------------------
	u_CABASX1(cPerg,"05","Lote de:"  		,"","","mv_ch05","C",TAMSX3("E1_PLNUCOB")[1],0,0,"C","","","","","mv_par05","","","","","","","","","","","","","","","","",{},{},{})
	u_CABASX1(cPerg,"06","Lote ate:"  		,"","","mv_ch06","C",TAMSX3("E1_PLNUCOB")[1],0,0,"C","","","","","mv_par06","","","","","","","","","","","","","","","","",{},{},{})

	//-------------------------------------------------------
	//Angelo Henrique - Data: 30/10/2019
	//-------------------------------------------------------
	//Acrescentado parâmetros para poder filtrar a matricula
	//-------------------------------------------------------
	u_CABASX1(cPerg,"07","Matricula de:" 	,"","","mv_ch07","C",TAMSX3("E1_MATRIC")[1],0,0,"C","","BA1PLS","","","mv_par07","","","","","","","","","","","","","","","","",{},{},{})
	u_CABASX1(cPerg,"08","Matricula ate:"	,"","","mv_ch08","C",TAMSX3("E1_MATRIC")[1],0,0,"C","","BA1PLS","","","mv_par08","","","","","","","","","","","","","","","","",{},{},{})

	u_CABASX1(cPerg,"09","Inf. Baixas:"		,"","","mv_ch09","N",1					   ,0,0,"C","",""      ,"","","mv_par09	","SIM","","","","NAO","","","","","","","","","","","",{},{},{})

Return

