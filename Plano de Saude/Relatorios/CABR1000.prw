#INCLUDE "Topconn.ch"
#INCLUDE "Protheus.ch"

#DEFINE cEnt chr(10)+chr(13)
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³RCOMR01   ºAutor  ³ Vinícius Moreira   º Data ³ 12/11/2013  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Impressão de cadastro de produtos em TReport simples.      º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AcademiaERP                                                º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function CABR1000()
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Declaracao de variaveis                   ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	Private oReport  := Nil
	Private oSection := Nil
	Private cPerg 	 := PadR ("CABR1000", Len (SX1->X1_GRUPO))
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Criacao e apresentacao das perguntas      ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	PutSx1(cPerg,"01","Empresa?"  ,'','',"mv_ch1","C",TamSx3 ("B1_COD")[1] ,0,,"G","","BG9PLS","","","mv_par01","","","","","","","","","","","","","","","","")
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Definicoes/preparacao para impressao      ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	ReportDef()
	oReport:PrintDialog()

Return Nil

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ReportDef ºAutor  ³ Vinícius Moreira   º Data ³ 12/11/2013  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Definição da estrutura do relatório.                       º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³                                                            º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function ReportDef()

	oReport := TReport():New("RCOMR01","Titulares e Dependentes",cPerg,{|oReport| PrintReport(oReport)},"Impressão de Titulares e Dependentes por empresas.")
	oReport:SetLandscape(.T.)

	oSection := TRSection():New( oReport , "Titulares e Dependentes", {"QRY"} )

	TRCell():New(oSection ,'BA1_MATRIC'		,"QRY",'MAT. TITULAR'	,/*Picture*/	,6		,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
	TRCell():New(oSection ,'MATRICULA'		,"QRY",'MATRICULA'		,/*Picture*/	,20	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
	TRCell():New(oSection ,'NOME'			,"QRY",'NOME'	    	,/*Picture*/	,50	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
	TRCell():New(oSection ,'PLANO'			,"QRY",'PLANO'			,/*Picture*/	,50		,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
	TRCell():New(oSection ,'DT_NASCIMENTO'	,"QRY",'DT_NASCIMENTO'	,/*Picture*/	,15		,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
	TRCell():New(oSection ,'IDADE' 			,"QRY",'IDADE'			,/*Picture*/	,2		,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
	TRCell():New(oSection ,'SEXO' 			,"QRY",'SEXO'			,/*Picture*/	,10		,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
	TRCell():New(oSection ,'INCLUSAO'		,"QRY",'INCLUSAO'		,/*Picture*/	,20		,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
	TRCell():New(oSection ,'TP_USUARIO'		,"QRY",'TIPO USUARIO',/*Picture*/	,20		,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
	TRCell():New(oSection ,'PARENTESCO'		,"QRY",'PARENTESCO'		,/*Picture*/	,20		,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)

	/*oBreak := TRBreak():New(oSection,oSection:Cell("BA1_MATRIC"),"Quantidade por Matricula")
	TRFunction():New(oSection:Cell("BA1_MATRIC"),NIL,"COUNT",oBreak)
*/

Return Nil

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³RCOMR01   ºAutor  ³ Vinícius Moreira   º Data ³ 12/11/2013  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³                                                            º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function PrintReport(oReport)

	Local cQuery     := ""

	Pergunte(cPerg,.F.)


	cQuery := " SELECT BA1_MATRIC,BA1_CODINT|| BA1_CODEMP|| BA1_MATRIC|| BA1_TIPREG|| BA1_DIGITO MATRICULA, "+cEnt
	cQuery += "			TRIM (BA1_NOMUSR) NOME, "+cEnt
	cQuery += "			TRIM (D.BI3_DESCRI) PLANO, "+cEnt
	cQuery += "			FORMATA_DATA_MS(BA1_DATNAS) DT_NASCIMENTO, "+cEnt
	cQuery += "			IDADE_S(BA1_DATNAS) IDADE, "+cEnt
	cQuery += "			CASE WHEN BA1_SEXO = '1' THEN 'MASCULINO' "+cEnt
	cQuery += "			ELSE 'FEMININO' "+cEnt
	cQuery += "			END AS SEXO, "+cEnt
	cQuery += "			FORMATA_DATA_MS(A.BA1_DATINC) INCLUSAO, "+cEnt
	cQuery += "			CASE WHEN A.BA1_TIPUSU = 'T' THEN 'TITULAR' "+cEnt
	cQuery += "			ELSE 'DEPENDENTE' "+cEnt
	cQuery += "			END AS TP_USUARIO, "+cEnt
	cQuery += "			TRIM (B.BRP_DESCRI) PARENTESCO "+cEnt
	cQuery += "		FROM "+RetSqlName("BA1")+" A "+cEnt
	cQuery += "			RIGHT JOIN "+RetSqlName("BRP")+" B ON (A.BA1_GRAUPA = B.BRP_CODIGO) "+cEnt
	cQuery += "			RIGHT JOIN "+RetSqlName("BI3")+" D ON (A.BA1_CODPLA = D.BI3_CODIGO) "+cEnt

	cQuery += "		WHERE A.BA1_CODEMP = '"+MV_PAR01+"'" +cEnt
	//cQuery += "AND A.BA1_TIPUSU = 'D' "+cEnt
	cQuery += "		AND A.BA1_DATBLO = ' ' "+cEnt
	cQuery += "		AND A.D_E_L_E_T_ = ' ' "+cEnt
	cQuery += "		AND B.D_E_L_E_T_ = ' ' "+cEnt
	cQuery += "		AND D.D_E_L_E_T_ = ' ' "+cEnt

	cQuery += "			ORDER BY BA1_MATRIC,MATRICULA"+cEnt

	/*
	cQuery += " SELECT " + CRLF
	cQuery += "     SB1.B1_COD " + CRLF
	cQuery += "    ,SB1.B1_DESC " + CRLF
	cQuery += "    ,SB1.B1_TIPO " + CRLF
	cQuery += "    ,SB1.B1_UM " + CRLF
	cQuery += "  FROM " + RetSqlName("SB1") + " SB1 " + CRLF
	cQuery += " WHERE SB1.B1_FILIAL = '" + xFilial ("SB1") + "' " + CRLF
	cQuery += "   AND SB1.B1_COD    BETWEEN '" + mv_par01 + "' AND '" + mv_par02 + "' " + CRLF
	cQuery += "   AND SB1.D_E_L_E_T_ = ' ' " + CRLF
	*/
	cQuery := ChangeQuery(cQuery)

	If Select("QRY") > 0
		Dbselectarea("QRY")
		QRY->(DbClosearea())
	EndIf

	TcQuery cQuery New Alias "QRY"

	oSection:BeginQuery()
	oSection:EndQuery({{"QRY"},cQuery})
	oSection:Print()

Return Nil