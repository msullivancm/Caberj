#INCLUDE "rwmake.ch"
#INCLUDE "protheus.ch"
#INCLUDE "TopConn.ch"
#INCLUDE "TBICONN.CH"

#DEFINE c_ent CHR(13) + CHR(10)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABR283      ºAutor  ³ ANDERSON RANGEL   º Data ³ FEVEREIRO/21 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³  RELATÓRIO PARA AUXILIAR NO ENVIO DO RPS			             º±± 
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³  Relatórios						                             º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function CABR283()

    Local _aArea 	:= GetArea()
	Local oReport	:= Nil

	Private _cPerg  := "CABR283"
	private cCodusu := SubStr(cUSUARIO,7,15)
	private aGerenc := {}
	private aCabec := {}
	private aDados := {}

	//Cria grupo de perguntas
	CABR283A(_cPerg)

	If Pergunte(_cPerg,.T.)

		oReport := CABR283B()
		oReport:PrintDialog()

	EndIf

	RestArea(_aArea)

return()

Static Function CABR283B

	Local oReport		:= Nil
	Local oSection1 	:= Nil
	Local oSection2 	:= Nil
		
	oReport := TReport():New("CABR283","RELATÓRIO BASE ORIENTADOR MÉDICO POR PLANO",_cPerg,{|oReport| CABR283C(oReport)},"Relatório Base Orientador Médico por Plano")
	
	//Impressão formato paisagem
	oReport:SetLandScape() //Orientação paisagem
	oReport:SetTotalInLine(.T.)	
	oReport:nLineHeight	:= 30
	oReport:cFontBody	:= "Arial"
	oReport:nColSpace	:= 1
	
	oSection1 := TRSection():New(oReport,"ATENDIMENTO","")
	TRCell():New(oSection1 ,'GRUPO'			,  ,'Grupo '			,/*Picture*/			,40				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"  )
	TRCell():New(oSection1 ,'ESPECIALIDADE'	,  ,'Especialidade '	,/*Picture*/			,40				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"  )
	TRCell():New(oSection1 ,'REDE'			,  ,'Rede '				,/*Picture*/			,20				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"  )
	TRCell():New(oSection1 ,'PLANO'			,  ,'Plano '			,/*Picture*/			,30				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"  )
	TRCell():New(oSection1 ,'MUNICIPIO'		,  ,'Municipio '		,/*Picture*/			,30				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"  )
	oReport:ThinLine()
	oSection2 := TRSection():New(oReport,"PRESTADOR(ES)","")
	TRCell():New(oSection2 ,'CODIGO'	    ,  ,'Codigo RDA '	    ,/*Picture*/	    	,15				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"	)
	TRCell():New(oSection2 ,'NOME'    	    ,  ,'Nome RDA '	        ,/*Picture*/	    	,60				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"	)
	TRCell():New(oSection2 ,'ENDERECO'      ,  ,'Endereço '         ,/*Picture*/	 		,60          	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"	)
	TRCell():New(oSection2 ,'BAIRRO'        ,  ,'Bairro '           ,/*Picture*/	 		,20          	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"	)
	TRCell():New(oSection2 ,'TELEFONES'   	,  ,'Telefone(s) '      ,/*Picture*/			,20				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"	)
	TRCell():New(oSection2 ,'ESTADO'        ,  ,'Estado '           ,/*Picture*/			,10				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"	)
	TRCell():New(oSection2 ,'INCLUSAO' 		,  ,'Incluido em '	    ,/*Picture*/			,10				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"	)
	
	oReport:ThinLine()	
	TRFunction():SetEndSection(.T.)
	oReport:ThinLine()
	
Return oReport

Static Function CABR283C(oReport)

	Local _aArea 		:= GetArea()
	Local oSection1 	:= oReport:Section(1)
	Local oSection2 	:= oReport:Section(2)

	Local _cQuery	 := ""
	Local cAlias1	 := GetNextAlias()
	Local cCtrlGRUPO := ""
	Local cCtrlESPEC := ""
	Local cCtrlREDE  := ""
	Local cCtrlMUNIC := ""
	Local cCtrlBAIRR := ""
	Local cCtrlPLANO := ""

	Local cRede		:= MV_PAR01
	Local cMunicip	:= MV_PAR02
	Local cGrupo	:= Iif(Empty(MV_PAR03)," ","0"+MV_PAR03)
	Local cEspec	:= MV_PAR04
	Local cPlano	:= MV_PAR05
	
	_cQuery := " SELECT DISTINCT x5_descri grupo, baq_descri especialidade, bau_codigo codigo,								" + c_ent
	_cQuery += "     nvl(TRIM(bau_nfanta), bau_nome) nome, TRIM(bb8.bb8_mun) municipio,   	                      		    " + c_ent
	_cQuery += "     (CASE WHEN ( bb8_codmun = '3304557'                                                                    " + c_ent
	_cQuery += "                 AND ( bb8_bairro LIKE '%JACAREP%'                                                          " + c_ent
	_cQuery += "                     OR bb8_bairro LIKE 'ANIL%'                                                             " + c_ent
	_cQuery += "                     OR bb8_bairro LIKE '%CIDADE%DEUS%'                                                     " + c_ent
	_cQuery += "                     OR bb8_bairro LIKE '%COLONIA%'                                                         " + c_ent
	_cQuery += "                     OR bb8_bairro LIKE '%CURICICA%'                                                        " + c_ent
	_cQuery += "                     OR bb8_bairro LIKE '%FREGUESIA%J%'                                                     " + c_ent
	_cQuery += "                     OR bb8_bairro LIKE '%GARD%AZUL%'                                                       " + c_ent
	_cQuery += "                     OR bb8_bairro LIKE '%PECHINCHA%'                                                       " + c_ent
	_cQuery += "                     OR bb8_bairro LIKE '%PR%SECA%'                                                         " + c_ent
	_cQuery += "                     OR bb8_bairro LIKE '%RIO GRANDE%'                                                      " + c_ent
	_cQuery += "                     OR bb8_bairro LIKE '%TANQUE%'                                                          " + c_ent
	_cQuery += "                     OR bb8_bairro LIKE '%TAQUARA%'                                                         " + c_ent
	_cQuery += "                     OR bb8_bairro LIKE '%VL%VALQUEIRE%' ) ) THEN 'JACAREPAGUA'                             " + c_ent
	_cQuery += "             WHEN ( bb8_codmun = '3304557'                                                                  " + c_ent
	_cQuery += "                 AND ( bb8_bairro LIKE '%GOVER%'                                                            " + c_ent
	_cQuery += "                     OR bb8_bairro LIKE '%BANCARIOS%'                                                       " + c_ent
	_cQuery += "                     OR bb8_bairro LIKE '%BANANAL%'                                                         " + c_ent
	_cQuery += "                     OR bb8_bairro LIKE '%CACUIA%'                                                          " + c_ent
	_cQuery += "                     OR bb8_bairro LIKE '%COCOTA%'                                                          " + c_ent
	_cQuery += "                     OR bb8_bairro LIKE '%FREGUESIA%I%'                                                     " + c_ent
	_cQuery += "                     OR bb8_bairro LIKE '%GALEAO%'                                                          " + c_ent
	_cQuery += "                     OR bb8_bairro LIKE '%GUARABU%'                                                         " + c_ent
	_cQuery += "                     OR bb8_bairro LIKE '%ITACOLOMI%'                                                       " + c_ent
	_cQuery += "                     OR bb8_bairro LIKE '%J%CARIOCA%'                                                       " + c_ent
	_cQuery += "                     OR bb8_bairro LIKE '%GUANABARA%'                                                       " + c_ent
	_cQuery += "                     OR bb8_bairro LIKE '%MONERO%'                                                          " + c_ent
	_cQuery += "                     OR bb8_bairro LIKE '%PITANGUEIRAS%'                                                    " + c_ent
	_cQuery += "                     OR bb8_bairro LIKE '%PORTUGUESA%'                                                      " + c_ent
	_cQuery += "                     OR bb8_bairro LIKE 'PR%%BANDEIRA%'                                                     " + c_ent
	_cQuery += "                     OR bb8_bairro LIKE '%RIBEIRA%'                                                         " + c_ent
	_cQuery += "                     OR bb8_bairro LIKE '%TAUA%'                                                            " + c_ent
	_cQuery += "                     OR bb8_bairro LIKE '%TUBIACANGA%'                                                      " + c_ent
	_cQuery += "                     OR bb8_bairro LIKE '%VILLAGE%'                                                         " + c_ent
	_cQuery += "                     OR bb8_bairro LIKE '%ZUMBI%' ) ) THEN 'ILHA DO GOVERNADOR'                             " + c_ent
	_cQuery += "             ELSE                                                                                           " + c_ent
	_cQuery += "                 TRIM(bb8_bairro)                                                                           " + c_ent
	_cQuery += "      END) bairro, TRIM(bb8_end)||', '||TRIM(bb8_nr_end)||nvl2(TRIM(bb8_comend),' - '||TRIM(bb8_comend),' ') endereco,	" + c_ent
	_cQuery += " 	  bb8_est  estado, to_Date(trim(bau_dtincl),'YYYYMMDD') inclusao,						                " + c_ent
	_cQuery += "     (SELECT bid_yddd                                                                                       " + c_ent
	_cQuery += "      FROM " + RetSqlName("BID") + " bid                                                                    " + c_ent
	_cQuery += "      WHERE bid_filial = ' '                                                                                " + c_ent
	_cQuery += "      AND bid_codmun = bb8_codmun                                                                           " + c_ent
	_cQuery += "      AND d_e_l_e_t_ = ' '                                                                                  " + c_ent
	_cQuery += "     )||trim(bb8_tel) telefones, decode(bb8_codmun, '3304557', 0, 1) ordem,                        		    " + c_ent
	_cQuery += "     TRIM(bi5_descri) rede, bi3_codigo cod_plano, bi3_nreduz plano		                                    " + c_ent
	_cQuery += " FROM " + RetSqlName("BI5") + " bi5, " + RetSqlName("BBK") + " bbk, " + RetSqlName("BAU") + " bau, 			" + c_ent
	_cQuery += " 	  " + RetSqlName("BB8") + " bb8, " + RetSqlName("BAX") + " bax, " + RetSqlName("BAQ") + " baq,			" + c_ent
	_cQuery += "      " + RetSqlName("SX5") + " sx5, " + RetSqlName("BI3") + " bi3, " + RetSqlName("BB6") + " bb6  			" + c_ent
	_cQuery += " WHERE bi5.bi5_codred = bbk.bbk_codred                                                                      " + c_ent
	_cQuery += "     AND bi5_codred = nvl(TRIM('"+ cRede +"'), bi5_codred)                                                  " + c_ent
	_cQuery += "     AND bb8_codmun = nvl(TRIM('"+ cMunicip +"'), bb8_codmun)                                               " + c_ent
	_cQuery += "     AND baq_ygpesp = nvl(TRIM('"+ cGrupo +"'), baq_ygpesp)                                                 " + c_ent
	_cQuery += "     AND instr(nvl(TRIM('"+ cEspec +"'), baq_codesp), baq_codesp) > 0                                       " + c_ent
	//_cQuery += "     AND nvl(substr(TRIM('"+ cplano +"'),5,4), bi3_codigo) = bi3_codigo                                     " + c_ent
	_cQuery += "     AND (case when LENGTH(TRIM('"+ cplano +"')) = 4 then TRIM('"+ cplano +"') else nvl(substr(TRIM('"+ cplano +"'),5,4), bi3_codigo) end) = bi3_codigo " + c_ent
	_cQuery += "     AND bi5.d_e_l_e_t_ = bbk.d_e_l_e_t_                                                                    " + c_ent
	_cQuery += "     AND bbk.bbk_codigo = bau.bau_codigo                                                                    " + c_ent
	_cQuery += "     AND bbk.d_e_l_e_t_ = bau.d_e_l_e_t_                                                                    " + c_ent
	_cQuery += "     AND bau.bau_codigo = bb8.bb8_codigo                                                                    " + c_ent
	_cQuery += "     AND bau.d_e_l_e_t_ = bb8.d_e_l_e_t_                                                                    " + c_ent
	_cQuery += "     AND bi3.d_e_l_e_t_ = bb6.d_e_l_e_t_  	                                                                " + c_ent
	_cQuery += "     AND bb6.bb6_filial = '  ' 		                                                                        " + c_ent
	_cQuery += "     AND bb6.bb6_codigo = bi3.bi3_codint || bi3_codigo 		                                                " + c_ent
	_cQuery += "     AND bb6.bb6_codred = bi5.bi5_codred 	                                                                " + c_ent
	_cQuery += "     AND bb8.bb8_codigo = bax.bax_codigo                                                                    " + c_ent
	_cQuery += "     AND bb8.bb8_codloc = bax.bax_codloc                                                                    " + c_ent
	_cQuery += "     AND bb8.d_e_l_e_t_ = bax.d_e_l_e_t_                                                                    " + c_ent
	_cQuery += "     AND bax.bax_codint = baq.baq_codint                                                                    " + c_ent
	_cQuery += "     AND bax.bax_codesp = baq.baq_codesp                                                                    " + c_ent
	_cQuery += "     AND bax.bax_codesp = bbk_codesp                                                                        " + c_ent
	_cQuery += "     AND bax.bax_codloc = bbk_codloc                                                                        " + c_ent
	_cQuery += "     AND bax.d_e_l_e_t_ = baq.d_e_l_e_t_                                                                    " + c_ent
	_cQuery += "     AND bi5.d_e_l_e_t_ <> '*'                                                                              " + c_ent
	_cQuery += "     AND bb8_datblo = '        '                                                                            " + c_ent
	_cQuery += "     AND bax_datblo = '        '                                                                            " + c_ent
	_cQuery += "     AND bb8_guimed = '1'                                                                                   " + c_ent
	_cQuery += "     AND bax_guimed = '1'                                                                                   " + c_ent
	_cQuery += "     AND bau_guimed <> '0'                                                                                  " + c_ent
	_cQuery += "     AND bau_codblo = ' '                                                                                   " + c_ent
	_cQuery += "     AND bau_datblo = ' '                                                                                   " + c_ent
	_cQuery += "     AND baq_ydivul = '1'                                                                                   " + c_ent
	_cQuery += "     AND bbk_ydivul = '1'                                                                                   " + c_ent
	_cQuery += "     AND bi3_portal = '1' 		                                                                            " + c_ent
	_cQuery += "     AND x5_tabela = '97'                                                                                   " + c_ent
	_cQuery += "     AND x5_chave = baq_ygpesp                                                                              " + c_ent
	_cQuery += " ORDER BY x5_descri, baq_descri, rede, cod_plano, municipio, bairro, nome		                            " + c_ent
	
	//MemoWrite("C:\Temp\CABR283.sql",_cQuery)
	
	If Select ((cAlias1)) > 0
		dbSelectArea( (cAlias1) )
		dbCloseArea()
	EndIf

	dbUseArea(.T., "TOPCONN",  TCGenQry(,,_cQuery), (cAlias1), .F., .T.)

	If !(cAlias1)->(eof()) 
		(cAlias1)->(DBGOTOP())
		oReport:SetMeter((cAlias1)->(LastRec()))

		While !(cAlias1)->(eof()) 
			
			If oReport:Cancel()
				Exit
			EndIf

			//Inicia Primeira Seção
			oSection1:Init()
			oSection1:SetHeaderSection(.F.)
		
			//Guarda o Conteudo do campo GRUPO, ESPECIALIDADE, REDE, MUNICIPIO, BAIRRO e PLANO para comparar no While abaixo. Usado para Quebra de seção           
			cCtrlGRUPO := (cAlias1)->GRUPO
			cCtrlESPEC := (cAlias1)->ESPECIALIDADE
			cCtrlREDE  := (cAlias1)->REDE
			cCtrlMUNIC := (cAlias1)->MUNICIPIO
			cCtrlBAIRR := (cAlias1)->BAIRRO
			cCtrlPLANO := (cAlias1)->PLANO
			
			oReport:IncMeter()
			oReport:SkipLine()
			oReport:SkipLine()
			oSection1:Cell("GRUPO"):SetValue("Grupo => "+ (cAlias1)->GRUPO)
			oSection1:Cell("ESPECIALIDADE"):SetValue("Especialidade => "+ (cAlias1)->ESPECIALIDADE)
			oSection1:Cell("REDE"):SetValue("Rede => "+ (cAlias1)->REDE)
			oSection1:Cell("PLANO"):SetValue("Plano => "+ (cAlias1)->PLANO)
			oSection1:Cell("MUNICIPIO"):SetValue("Município => "+ (cAlias1)->MUNICIPIO)
			oSection1:PrintLine()	
			
			//Inicia Segunda Seção			
			oSection2:Init() 
			
			While (cAlias1)->GRUPO == cCtrlGRUPO .AND. (cAlias1)->ESPECIALIDADE == cCtrlESPEC .AND. (cAlias1)->REDE == cCtrlREDE .AND. (cAlias1)->MUNICIPIO == cCtrlMUNIC .AND. (cAlias1)->BAIRRO == cCtrlBAIRR .AND. (cAlias1)->PLANO == cCtrlPLANO
				
				oReport:IncMeter()
				oSection2:Cell("CODIGO"):SetValue((cAlias1)->CODIGO) 
				oSection2:Cell("NOME"):SetValue((cAlias1)->NOME)
				oSection2:Cell("ENDERECO"):SetValue((cAlias1)->ENDERECO) 
				oSection2:Cell("BAIRRO"):SetValue((cAlias1)->BAIRRO)
				oSection2:Cell("TELEFONES"):SetValue((cAlias1)->TELEFONES)            
				oSection2:Cell("ESTADO"):SetValue((cAlias1)->ESTADO)
				oSection2:Cell("INCLUSAO"):SetValue((cAlias1)->INCLUSAO)
				oSection2:PrintLine()			
				(cAlias1)->(DbSkip())
				
			EndDo
			oReport:ThinLine()
			oSection2:Finish()

		EndDo
		oReport:ThinLine()
		oReport:SkipLine()
		oSection1:Finish()

	Endif

	//Gera Excel
	If MV_PAR06 = 1
		(cAlias1)->(DbGoTop())
		If !(cAlias1)->(Eof())
			nSucesso := 0
			aCabec := {"GRUPO","ESPECIALIDADE","CODIGO_RDA","NOME_RDA","MUNICIPIO","BAIRRO",;
						"ENDERECO","TELEFONE","INCLUSAO","ESTADO","ORDEM","PLANO"}  
						
			While !(cAlias1)->(Eof()) 
				IncProc()		
				aaDD(aDados,{(cAlias1)->GRUPO,(cAlias1)->ESPECIALIDADE,(cAlias1)->CODIGO,(cAlias1)->NOME,(cAlias1)->MUNICIPIO,(cAlias1)->BAIRRO,;
							(cAlias1)->ENDERECO,(cAlias1)->TELEFONES,(cAlias1)->INCLUSAO,(cAlias1)->ESTADO,(cAlias1)->ORDEM,(cAlias1)->PLANO}) 
				(cAlias1)->(DbSkip())
			EndDo
		EndIf

		//Abre excel 
		DlgToExcel({{"ARRAY"," " ,aCabec,aDados}})
	ENDIF

	If Select ((cAlias1)) > 0
		dbSelectArea( (cAlias1) )
		dbCloseArea()
	EndIf

	RestArea(_aArea)   

Return (.T.)

//Perguntas
Static Function CABR283A(cGrpPerg)

	Local aHelpPor := {} //help da pergunta

	PutSx1(cGrpPerg,"01","Rede ? "			,"a","a","MV_CH1"	,"C",	,0,0,"G","","","","","MV_PAR01",""	 ,"","","","",""	,"","","","","","","","","","",aHelpPor,{},{},"")
	PutSx1(cGrpPerg,"02","Municipio ?"		,"a","a","MV_CH2"	,"C",	,0,0,"G","","","","","MV_PAR02",""	 ,"","","","",""	,"","","","","","","","","","",aHelpPor,{},{},"")
	PutSx1(cGrpPerg,"03","Grupo ?"			,"a","a","MV_CH3"	,"C",	,0,0,"G","","","","","MV_PAR03",""	 ,"","","","",""	,"","","","","","","","","","",aHelpPor,{},{},"")
	PutSx1(cGrpPerg,"04","Especialidade ?"	,"a","a","MV_CH4"	,"C",	,0,0,"G","","","","","MV_PAR04",""	 ,"","","","",""	,"","","","","","","","","","",aHelpPor,{},{},"")
	PutSx1(cGrpPerg,"05","Plano ?"			,"a","a","MV_CH5"	,"C",	,0,0,"G","","","","","MV_PAR05",""	 ,"","","","",""	,"","","","","","","","","","",aHelpPor,{},{},"")
	PutSx1(cGrpPerg,"06","Gera Excel ?"		,"a","a","MV_CH6"	,"N", 01,0,0,"C","","","","","MV_PAR06","Sim","","","","","Nao"	,"","","","","","","","","","",aHelpPor,{},{},"")

Return
