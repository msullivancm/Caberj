#Define CRLF Chr(13)+Chr(10)
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  |PL264QRY  ºAutor  ³Fabio Bianchini     º Data ³  03/31/15   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Mofdifica a Query da Geraçao de Carteira em Lote            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User function PL264QRY
	Local cSql1 := paramixb[1]
	Local cSql2 := paramixb[2]
	Local cSql3 := paramixb[3]
	Local cSql1Compl := " "
	Local cSql2Compl := " "
	Local cSql3Compl := " "
	Local _cSqlPrf	:= "" //Angelo Henrique - Data:20/07/2016 - Multiplanos Prefeitura
	Local _aHelpPt 	:= {} //Angelo Henrique - Data:20/07/2016 - Help da pergunta
	Local 	_cPerg		:= "PLPREF" //Angelo Henrique - Data:20/07/2016 - Perguntas
	
	/*
	//BACALHAU - CARTEIRAS MATER
	cSql1Compl	:= " , (   select lpad(matricula_,17,'0') MATRICULA " +CRLF
	cSql1Compl	+= "            , substr(NOVA_DATA,7,4)||substr(NOVA_DATA,4,2)||substr(NOVA_DATA,1,2) VALIDADE " +CRLF
	cSql1Compl	+= "         from adimp_nego " +CRLF
	cSql1Compl	+= "        WHERE NOVA_DATA IS NOT NULL "+CRLF
	cSql1Compl	+= "       union " +CRLF
	cSql1Compl	+= "       select lpad(matricula,17,'0') MATRICULA " +CRLF
	cSql1Compl	+= "            , substr(NOVA_DATA,7,4)||substr(NOVA_DATA,4,2)||substr(NOVA_DATA,1,2) VALIDADE " +CRLF
	cSql1Compl	+= "         from adimp_parc " +CRLF
	cSql1Compl	+= "        WHERE NOVA_DATA IS NOT NULL " +CRLF
	cSql1Compl	+= "       union " +CRLF
	cSql1Compl	+= "       select lpad(matricula,17,'0') MATRICULA " +CRLF
	cSql1Compl	+= "            , substr(NOVA_DATA,7,4)||substr(NOVA_DATA,4,2)||substr(NOVA_DATA,1,2) VALIDADE " +CRLF
	cSql1Compl	+= "         from adimplentes " +CRLF
	cSql1Compl	+= "        WHERE NOVA_DATA IS NOT NULL " +CRLF
	cSql1Compl	+= "       union " +CRLF
	cSql1Compl	+= "       select lpad(matricula,17,'0') MATRICULA " +CRLF
	cSql1Compl	+= "            , substr(NOVA_DATA,7,4)||substr(NOVA_DATA,4,2)||substr(NOVA_DATA,1,2) VALIDADE " +CRLF
	cSql1Compl	+= "         from inadimp_3060 " +CRLF
	cSql1Compl	+= "        WHERE NOVA_DATA IS NOT NULL " +CRLF
	cSql1Compl	+= "       union " +CRLF
	cSql1Compl	+= "       select lpad(matricula,17,'0') MATRICULA " +CRLF
	cSql1Compl	+= "            , substr(NOVA_DATA,7,4)||substr(NOVA_DATA,4,2)||substr(NOVA_DATA,1,2) VALIDADE " +CRLF
	cSql1Compl	+= "         from inadimp_30 " +CRLF
	cSql1Compl	+= "        WHERE NOVA_DATA IS NOT NULL " +CRLF
	cSql1Compl	+= "   ) TMP " +CRLF
	
	
	cSql1Compl	:= " , (   select lpad(matricula,17,'0') MATRICULA " +CRLF
	cSql1Compl	+= "            , substr(NOVA_DATA,7,4)||substr(NOVA_DATA,4,2)||substr(NOVA_DATA,1,2) VALIDADE " +CRLF
	cSql1Compl	+= "         from mater_dep " +CRLF
	cSql1Compl	+= "        WHERE NOVA_DATA IS NOT NULL "+CRLF
	cSql1Compl	+= "   ) TMP " +CRLF
	
	cSql2Compl  := cSql1Compl
	
	cSql3Compl  := " AND BA1.BA1_CODINT = SUBSTR(TMP.MATRICULA,1,4)  " +CRLF
	cSql3Compl  += " AND BA1.BA1_CODEMP = SUBSTR(TMP.MATRICULA,5,4)  " +CRLF
	cSql3Compl  += " AND BA1.BA1_MATRIC = SUBSTR(TMP.MATRICULA,9,6)  " +CRLF
	cSql3Compl  += " AND BA1.BA1_TIPREG = SUBSTR(TMP.MATRICULA,15,2) " +CRLF
	
	cSql1 := cSql1 + cSql1Compl
	cSql2 := cSql2 + cSql2Compl
	cSql3 := cSql3 + cSql3Compl
	*/
	If BDE->(FieldPos("BDE_YQTFAM")) > 0
		If M->BDE_YQTFAM == '0' //ATE 4 MEMBROS NA FAMILIA
			cSql3Compl  := " AND EXISTS (SELECT 1 " +CRLF
			cSql3Compl  += "               FROM "+RetSQLName("BA1")+" X " +CRLF
			cSql3Compl  += "              WHERE X.BA1_FILIAL = '"+xFilial("BA1")+"'" +CRLF
			cSql3Compl  += "                AND X.BA1_CODINT = BA1.BA1_CODINT " +CRLF
			cSql3Compl  += "                AND X.BA1_CODEMP = BA1.BA1_CODEMP " +CRLF
			cSql3Compl  += "                AND X.BA1_MATRIC = BA1.BA1_MATRIC " +CRLF
			cSql3Compl  += "                AND X.BA1_CONEMP = BA1.BA1_CONEMP " +CRLF
			cSql3Compl  += "                AND X.BA1_SUBCON = BA1.BA1_SUBCON " +CRLF
			cSql3Compl  += "                AND X.BA1_CODPLA = BA3.BA3_CODPLA " +CRLF
			cSql3Compl  += "                AND X.D_E_L_E_T_ = ' '            " +CRLF
			cSql3Compl  += "              GROUP BY X.BA1_MATRIC               " +CRLF
			cSql3Compl  += "             HAVING COUNT(X.BA1_MATRIC) <= 4)     " +CRLF
		ElseIf M->BDE_YQTFAM == '1' //MAIS DE 4 MEMBROS NA FAMILIA
			cSql3Compl  := " AND EXISTS (SELECT 1 " +CRLF
			cSql3Compl  += "               FROM "+RetSQLName("BA1")+" X " +CRLF
			cSql3Compl  += "              WHERE X.BA1_FILIAL = '"+xFilial("BA1")+"'" +CRLF
			cSql3Compl  += "                AND X.BA1_CODINT = BA1.BA1_CODINT " +CRLF
			cSql3Compl  += "                AND X.BA1_CODEMP = BA1.BA1_CODEMP " +CRLF
			cSql3Compl  += "                AND X.BA1_MATRIC = BA1.BA1_MATRIC " +CRLF
			cSql3Compl  += "                AND X.BA1_CONEMP = BA1.BA1_CONEMP " +CRLF
			cSql3Compl  += "                AND X.BA1_SUBCON = BA1.BA1_SUBCON " +CRLF
			cSql3Compl  += "                AND X.BA1_CODPLA = BA3.BA3_CODPLA " +CRLF
			cSql3Compl  += "                AND X.D_E_L_E_T_ = ' '            " +CRLF
			cSql3Compl  += "              GROUP BY X.BA1_MATRIC               " +CRLF
			cSql3Compl  += "             HAVING COUNT(X.BA1_MATRIC) > 4)      " +CRLF
		Endif
	Endif
	
	cSql3 := cSql3 + cSql3Compl
	
	//-------------------------------------------------------------------------
	//INICIO - Angelo Henrique - Data: 20/07/2016
	//-------------------------------------------------------------------------
	//Validação para multiplos planos para a prefeitura, onda em uma familia
	//o titular pode possuir plano diferente do dependente
	//-------------------------------------------------------------------------
	//Aproveitado esta melhoria para colocar na query o plano selecionado
	//pelo usuário
	//-------------------------------------------------------------------------
	If !Empty(AllTrim(M->BDE_CODPRO))
		
		_cSqlPrf := " AND BA1_CODPLA = '" + M->BDE_CODPRO + "' " + CRLF
		
	EndIf
	
	If MSGYESNO("Deseja selecionar os planos da prefeitura e Coligadas?","Atenção")
		
		If M->BDE_EMPDE $ ("0024|0025|0027|0028") //Prefeitura e Coligadas
			
			aHelpPor := {}
			AADD(aHelpPor,"Indique os Planos Prefeitura	")
			AADD(aHelpPor,"De/Ate a ser utilizado.     	")
			
			PutSx1(_cPerg,"01","Plano De ? "		,"a","a","MV_CH1"	,"C",TamSX3("BA1_CODPLA")[1]	,0,0,"G","","BI3PRF"	,"","","MV_PAR01","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")
			PutSx1(_cPerg,"02","Plano Ate ?"		,"a","a","MV_CH2"	,"C",TamSX3("BA1_CODPLA")[1]	,0,0,"G","","BI3PRF"	,"","","MV_PAR02","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")
			
			Pergunte(_cPerg,.T.)
			
			If !Empty(AllTrim(MV_PAR01)) .And. !Empty(AllTrim(MV_PAR02))
				
				_cSqlPrf := "AND BA1_CODPLA IN ('" + MV_PAR01 + "','" + MV_PAR02 + "')"
				
			EndIf
			
		EndIf
		
	EndIf
	
	cSql3 := cSql3 + _cSqlPrf
	
	//-------------------------------------------------------------------------
	//FIM - Angelo Henrique - Data: 20/07/2016
	//-------------------------------------------------------------------------
	
Return {cSql1,cSql2,cSql3}
