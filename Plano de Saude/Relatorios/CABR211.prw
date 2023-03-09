#INCLUDE "REPORT.CH"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "TOPCONN.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCABR211     บAutor  ณAngelo Henrique   บ Data ณ  10/05/16   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRelat๓rio de OPME X Senha                                   บฑฑ
ฑฑบ          ณQuery elaborada por Roberto Santos.                         บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CABERJ                                                     บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function CABR211()
	
	Local _aArea 		:= GetArea()
	Local oReport		:= Nil
	
	Private _cPerg	:= "CABR211"
	
	//Cria grupo de perguntas
	CABR211C(_cPerg)
	
	If Pergunte(_cPerg,.T.)
		
		oReport := CABR211A()
		oReport:PrintDialog()
		
	EndIf
	
	RestArea(_aArea)
	
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCABR211A  บAutor  ณAngelo Henrique     บ Data ณ  17/08/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRotina que irแ gerar as informa็๕es do relat๓rio            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CABERJ                                                     บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function CABR211A
	
	Local oReport		:= Nil
	Local oSection1 	:= Nil
	Local oSection2 	:= Nil
	
	oReport := TReport():New("CABR211","OPME x SENHA INTERNACAO",_cPerg,{|oReport| CABR211B(oReport)},"OPME x SENHA INTERNACAO")
	
	oReport:SetLandScape()
	
	oReport:oPage:setPaperSize(12)
			
	//--------------------------------
	//Primeira linha do relat๓rio
	//--------------------------------
	oSection1 := TRSection():New(oReport,"OPME","SF1, SA2, B19, SE2, SD1, BD6, BI3, BD5, BE4, BR8, BE2, BQV")
	
	TRCell():New(oSection1,"BD6_NOMUSR" 	,"BD6") //01 -- Nome Beneficiแrio
	oSection1:Cell("BD6_NOMUSR"):SetAutoSize(.F.)
	oSection1:Cell("BD6_NOMUSR"):SetSize(30)
	
	TRCell():New(oSection1,"BI3_DESCRI" 	,"BI3") //02 -- Descri็ใo Plano
	oSection1:Cell("BI3_DESCRI"):SetAutoSize(.F.)
	oSection1:Cell("BI3_DESCRI"):SetSize(15)
	
	TRCell():New(oSection1,"BE4_SENHA" 	,"BE4") //03 -- Senha
	oSection1:Cell("BE4_SENHA"):SetAutoSize(.F.)
	oSection1:Cell("BE4_SENHA"):SetSize(10)
	
	TRCell():New(oSection1,"BR8_DESCRI" 	,"BR8") //04 -- Procedimento
	oSection1:Cell("BR8_DESCRI"):SetAutoSize(.F.)
	oSection1:Cell("BR8_DESCRI"):SetSize(30)
	
	TRCell():New(oSection1,"BE4_NOMRDA"	,"BE4") //05 -- Nome da Rede
	oSection1:Cell("BE4_NOMRDA"):SetAutoSize(.F.)
	oSection1:Cell("BE4_NOMRDA"):SetSize(30)
	
	TRCell():New(oSection1,"BE4_NOMSOL" 	,"BE4") //06 -- Nome do solicitante (Medico)
	oSection1:Cell("BE4_NOMSOL"):SetAutoSize(.F.)
	oSection1:Cell("BE4_NOMSOL"):SetSize(30)
	
	TRCell():New(oSection1,"Fornecedor" 	,"SA2") //07 -- Fornecedor
	oSection1:Cell("Fornecedor"):SetAutoSize(.F.)
	oSection1:Cell("Fornecedor"):SetSize(20)
	
	TRCell():New(oSection1,"E2_VALOR" 		,"SE2") //08 -- Valor Liquido (Valor Autorizado)
	oSection1:Cell("E2_VALOR"):SetAutoSize(.F.)
	oSection1:Cell("E2_VALOR"):SetSize(10)
	
	TRCell():New(oSection1,"DESCONTO" 		,"SE2") //09 -- Desconto
	oSection1:Cell("DESCONTO"):SetAutoSize(.F.)
	oSection1:Cell("DESCONTO"):SetSize(10)	
	
	TRCell():New(oSection1,"E2_VENCTO" 	,"SE2") //10 -- Vencimento
	oSection1:Cell("E2_VENCTO"):SetAutoSize(.F.)
	oSection1:Cell("E2_VENCTO"):SetSize(10)
	
	TRCell():New(oSection1,"E2_BAIXA" 		,"SE2") //11 -- Data de Pagamento
	oSection1:Cell("E2_BAIXA"):SetAutoSize(.F.)
	oSection1:Cell("E2_BAIXA"):SetSize(10)
	
	//--------------------------
	//Se็ใo do Totalizador
	//--------------------------
	oSection2 := TRSection():New(oSection1,"","SE2")
		
	TRCell():New(oSection2,"Total Geral"		,"SE2",					  ,PESQPICT("SE2", "E2_VALOR"))
	oSection2:Cell("Total Geral"):SetAutoSize(.F.)
	oSection2:Cell("Total Geral"):SetSize(TAMSX3("E2_VALOR")[1])
	
	TRCell():New(oSection2,"Total Desconto"	,"SE2",					  ,PESQPICT("SE2", "E2_VALOR"))
	oSection2:Cell("Total Desconto"):SetAutoSize(.F.)
	oSection2:Cell("Total Desconto"):SetSize(TAMSX3("E2_VALOR")[1])
	
Return oReport

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCABR211B  บAutor  ณAngelo Henrique     บ Data ณ  17/08/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRotina para montar a query e trazer as informa็๕es no       บฑฑ
ฑฑบ          ณrelat๓rio.                                                  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CABERJ                                                     บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function CABR211B(oReport,_cAlias1)
	
	Local _aArea 			:= GetArea()
	Local _cSenha 		:= ""	
	Local _nTtGr			:= 0 //Total Geral
	Local _nTtDs			:= 0 //Total Desconto
	
	Private oSection1 	:= oReport:Section(1)
	Private oSection2		:= oReport:Section(1):Section(1)
	Private _cQuery		:= ""
	Private _cAlias1		:= GetNextAlias()
	
	
	_cQuery := " SELECT DISTINCT F1_DOC, " + CRLF
	_cQuery += " F1_SERIE, " 	+ CRLF
	_cQuery += " F1_FORNECE, " 	+ CRLF
	_cQuery += " A2_NOME, " 		+ CRLF
	_cQuery += " E2_EMISSAO, " 	+ CRLF
	_cQuery += " E2_VENCTO, " 	+ CRLF
	_cQuery += " (F1_DESCONT/ " + CRLF
	_cQuery += " (SELECT Count(R_E_C_N_O_) " 		+ CRLF
	_cQuery += " FROM " + RETSQLNAME("SE2") + " SE2I "	+ CRLF
	_cQuery += " WHERE E2_FILIAL = F1_FILIAL " 	+ CRLF
	_cQuery += " AND E2_PREFIXO = F1_SERIE " 		+ CRLF
	_cQuery += " AND E2_NUM = F1_DOC " 			+ CRLF
	_cQuery += " AND E2_FORNECE = F1_FORNECE " 	+ CRLF
	_cQuery += " AND SE2I.D_E_L_E_T_ = ' ')) DESCONTO, " + CRLF
	_cQuery += " E2_VALOR VLRLIQUIDO, " 	+ CRLF
	_cQuery += " E2_SALDO VALORSALDO, " 	+ CRLF
	_cQuery += " E2_BAIXA, " 				+ CRLF
	_cQuery += " BD6.BD6_NOMUSR BENEF,  " + CRLF
	_cQuery += " retorna_plano_usu_ms ('C',BD6_OPEUSR,BD6_CODEMP, BD6_MATRIC, BD6_TIPREG,'n') CODPLANO,  " + CRLF
	_cQuery += " BI3_DESCRI DSCPLA, " 	+ CRLF
	_cQuery += " BE4_CODRDA CODRDA, " 		+ CRLF
	_cQuery += " BE4_NOMRDA REDE, " 		+ CRLF
	_cQuery += " BE4.BE4_NOMSOL MEDICO, " 	+ CRLF
	_cQuery += " BD5.BD5_GUIINT, " 	+ CRLF
	_cQuery += " BE4.BE4_SENHA, " 	+ CRLF
	_cQuery += " BR8.BR8_CODPSA, " 	+ CRLF
	_cQuery += " BR8.BR8_DESCRI "  	+ CRLF
	
	_cQuery += " FROM " + RETSQLNAME("B19") + " B19, " + CRLF
	_cQuery += RETSQLNAME("SD1") + " SD1, " + CRLF
	_cQuery += RETSQLNAME("SF1") + " SF1, " + CRLF
	_cQuery += RETSQLNAME("BD6") + " BD6, " + CRLF
	_cQuery += RETSQLNAME("SA2") + " SA2, " + CRLF
	_cQuery += RETSQLNAME("SE2") + " SE2, " + CRLF
	_cQuery += RETSQLNAME("BI3") + " BI3, " + CRLF
	_cQuery += RETSQLNAME("BD5") + " BD5, " + CRLF
	_cQuery += RETSQLNAME("BE4") + " BE4, " + CRLF
	_cQuery += RETSQLNAME("BR8") + " BR8, " + CRLF
	_cQuery += RETSQLNAME("BE2") + " BE2  " + CRLF
	
	_cQuery += " WHERE A2_COD = B19_FORNEC  " + CRLF
	_cQuery += " AND D1_DOC = F1_DOC " 		+ CRLF
	_cQuery += " AND B19_DOC = D1_DOC " 		+ CRLF
	_cQuery += " AND D1_ITEM = B19_ITEM " 		+ CRLF
	_cQuery += " AND BD6_FILIAL = '" + xFilial("BD6") + "' " + CRLF
	_cQuery += " AND BD6_CODOPE = SubStr(B19_GUIA,01,04) " + CRLF
	_cQuery += " AND BD6_CODLDP = SubStr(B19_GUIA,05,04) " + CRLF
	_cQuery += " AND BD6_CODPEG = SubStr(B19_GUIA,09,08) " + CRLF
	_cQuery += " AND BD6_NUMERO = SubStr(B19_GUIA,17,08) " + CRLF
	_cQuery += " AND BD6_ORIMOV = SubStr(B19_GUIA,25,01) " + CRLF
	_cQuery += " AND BD6_SEQUEN = SubStr(B19_GUIA,26,03) " + CRLF
	
	If !Empty(MV_PAR03) .And. !Empty(MV_PAR04)
	
		_cQuery += " AND F1_FORNECE BETWEEN '" + MV_PAR03 + "' AND '" + MV_PAR04 + "' " + CRLF
	
	EndIf
	
	If !Empty(MV_PAR05) .And. !Empty(MV_PAR06)
	
		_cQuery += " AND E2_EMISSAO >= '" + DTOS(MV_PAR05) + "' " 	+ CRLF
		_cQuery += " AND E2_EMISSAO <= '" + DTOS(MV_PAR06) + "' " 	+ CRLF
	
	EndIf
	
	If !Empty(MV_PAR08) .And. !Empty(MV_PAR09)
	
		_cQuery += " AND E2_BAIXA >= '" + DTOS(MV_PAR08) + "' " 	+ CRLF
		_cQuery += " AND E2_BAIXA <= '" + DTOS(MV_PAR09) + "' " 	+ CRLF	
	
	EndIf
	
	If !Empty(MV_PAR10) .And. !Empty(MV_PAR11)
	
		_cQuery += " AND E2_VENCREA >= '" + DTOS(MV_PAR10) + "' " 	+ CRLF
		_cQuery += " AND E2_VENCREA <= '" + DTOS(MV_PAR11) + "' " 	+ CRLF	
	
	EndIf		
	
	If !(MV_PAR07 == 3)
		
		If MV_PAR07 == 2
			
			_cQuery += " AND E2_BAIXA <> ' ' " 
		
		Else
			
			_cQuery += " AND E2_BAIXA = ' ' "
		
		Endif
		
	EndIf
	
	_cQuery += " AND BI3_FILIAL = '" + xFilial("BI3") + "' " 			+ CRLF
	_cQuery += " AND BI3_CODINT = BD6_CODOPE " 	+ CRLF
	_cQuery += " AND BI3_CODIGO = retorna_plano_usu_ms ('C',BD6_OPEUSR,BD6_CODEMP, BD6_MATRIC, BD6_TIPREG,'N') " + CRLF
	
	If !Empty(MV_PAR01) .And. !Empty(MV_PAR02)
	
		_cQuery += " AND BI3_CODIGO BETWEEN '" + MV_PAR01 + "' AND '" + MV_PAR02 + "' " + CRLF
		
	EndIf
	
	_cQuery += " AND E2_FILIAL = '" + xFilial("SE2") + "' " 			+ CRLF
	_cQuery += " AND A2_FILIAL = '" + xFilial("SA2") + "' " 			+ CRLF
	_cQuery += " AND D1_FILIAL = '" + xFilial("SD1") + "' " 			+ CRLF
	_cQuery += " AND F1_FILIAL = '" + xFilial("SF1") + "' " 			+ CRLF
	_cQuery += " AND F1_FORNECE = D1_FORNECE " 	+ CRLF
	_cQuery += " AND F1_FORNECE = B19_FORNEC " 	+ CRLF
	_cQuery += " AND E2_FILIAL = F1_FILIAL " 		+ CRLF
	_cQuery += " AND E2_PREFIXO = F1_SERIE " 		+ CRLF
	_cQuery += " AND E2_NUM = F1_DOC " 			+ CRLF
	_cQuery += " AND E2_FORNECE = F1_FORNECE " 	+ CRLF
	_cQuery += " AND SE2.D_E_L_E_T_ = ' ' " 		+ CRLF
	_cQuery += " AND SA2.D_E_L_E_T_ = ' ' " 		+ CRLF
	_cQuery += " AND B19.D_E_L_E_T_ = ' ' " 		+ CRLF
	_cQuery += " AND SD1.D_E_L_E_T_ = ' ' " 		+ CRLF
	_cQuery += " AND SF1.D_E_L_E_T_ = ' ' " 		+ CRLF
	_cQuery += " AND BI3.D_E_L_E_T_ = ' ' " 		+ CRLF
	_cQuery += " AND BD6.D_E_L_E_T_ = ' ' " 		+ CRLF
	_cQuery += " AND BD5.D_E_L_E_T_ = ' ' " 		+ CRLF
	_cQuery += " AND BE4.D_E_L_E_T_ = ' ' " 		+ CRLF
	_cQuery += " AND BD5_FILIAL = BD6_FILIAL " 	+ CRLF
	_cQuery += " AND BE4_TIPGUI='03' " 			+ CRLF
	
	_cQuery += " AND BE4_CODOPE = SubStr(BD5_GUIINT,01,04) "	+ CRLF
	_cQuery += " AND BE4_CODLDP = SubStr(BD5_GUIINT,05,04) "	+ CRLF
	_cQuery += " AND BE4_CODPEG = SubStr(BD5_GUIINT,09,08) " 	+ CRLF
	_cQuery += " AND BE4_NUMERO = SubStr(BD5_GUIINT,17,08) " 	+ CRLF
	
	_cQuery += " AND BD5_CODOPE = BD6_CODOPE " 	+ CRLF
	_cQuery += " AND BD5_CODLDP = BD6_CODLDP " 	+ CRLF
	_cQuery += " AND BD5_CODPEG = BD6_CODPEG " 	+ CRLF
	_cQuery += " AND BD5_NUMERO = BD6_NUMERO " 	+ CRLF
	_cQuery += " AND BD5_ORIMOV = BD6_ORIMOV " 	+ CRLF
	
	_cQuery += " AND BE2_ANOINT = BE4_ANOINT " 	+ CRLF
	_cQuery += " AND BE2_MESINT = BE4_MESINT " 	+ CRLF
	_cQuery += " AND BE2_NUMINT = BE4_NUMINT " 	+ CRLF
	_cQuery += " AND BR8_FILIAL = '" + xFilial("BR8") + "' " 			+ CRLF
	_cQuery += " AND BR8_CODPAD = BE2_CODPAD " 	+ CRLF
	_cQuery += " AND BR8_CODPSA = BE2_CODPRO " 	+ CRLF
	_cQuery += " AND BR8_TPPROC IN ('0','6') " 	+ CRLF
	_cQuery += " AND BR8_YMATER='1' " 				+ CRLF
	_cQuery += " AND BR8.D_E_L_E_T_ = ' ' " 		+ CRLF
	_cQuery += " AND BD5.D_E_L_E_T_ = ' ' " 		+ CRLF
	_cQuery += " AND BD6.D_E_L_E_T_ = ' ' " 		+ CRLF
	_cQuery += " AND BE2.D_E_L_E_T_ = ' ' " 		+ CRLF
	_cQuery += " AND BE4.D_E_L_E_T_ = ' ' " 		+ CRLF
	
	_cQuery += " UNION " + CRLF
	
	_cQuery += " SELECT DISTINCT F1_DOC, " + CRLF
	_cQuery += " F1_SERIE, " 	+ CRLF
	_cQuery += " F1_FORNECE, " 	+ CRLF
	_cQuery += " A2_NOME, " 		+ CRLF
	_cQuery += " E2_EMISSAO, " 	+ CRLF
	_cQuery += " E2_VENCTO, " 	+ CRLF
	_cQuery += " (F1_DESCONT/ " + CRLF
	_cQuery += " (SELECT Count(R_E_C_N_O_) " 		+ CRLF
	_cQuery += " FROM " + RETSQLNAME("SE2") + " SE2I " 	+ CRLF
	_cQuery += " WHERE E2_FILIAL = F1_FILIAL " 	+ CRLF
	_cQuery += " AND E2_PREFIXO = F1_SERIE " 		+ CRLF
	_cQuery += " AND E2_NUM = F1_DOC " 			+ CRLF
	_cQuery += " AND E2_FORNECE = F1_FORNECE " 	+ CRLF
	_cQuery += " AND SE2I.D_E_L_E_T_ = ' ')) DESCONTO, " + CRLF
	_cQuery += " E2_VALOR VLRLIQUIDO, " + CRLF
	_cQuery += " E2_SALDO VALORSALDO, " + CRLF
	_cQuery += " E2_BAIXA, " + CRLF
	_cQuery += " BD6.BD6_NOMUSR BENEF, " + CRLF
	_cQuery += " retorna_plano_usu_ms ('C',BD6_OPEUSR,BD6_CODEMP, BD6_MATRIC, BD6_TIPREG,'n') CODPLANO, " + CRLF
	_cQuery += " BI3_DESCRI DSCPLA, " 	+ CRLF
	_cQuery += " BE4_CODRDA CODRDA, " 		+ CRLF
	_cQuery += " BE4_NOMRDA REDE, " 		+ CRLF
	_cQuery += " BE4.BE4_NOMSOL MEDICO, " 	+ CRLF
	_cQuery += " BD5.BD5_GUIINT, " 	+ CRLF
	_cQuery += " BE4.BE4_SENHA, " 	+ CRLF
	_cQuery += " BR8.BR8_CODPSA, " 	+ CRLF
	_cQuery += " BR8.BR8_DESCRI " 	+ CRLF
	
	_cQuery += " FROM " + RETSQLNAME("B19") + " B19, " + CRLF
	_cQuery += RETSQLNAME("SD1") + " SD1, " + CRLF
	_cQuery += RETSQLNAME("SF1") + " SF1, " + CRLF
	_cQuery += RETSQLNAME("BD6") + " BD6, " + CRLF
	_cQuery += RETSQLNAME("SA2") + " SA2, " + CRLF
	_cQuery += RETSQLNAME("SE2") + " SE2, " + CRLF
	_cQuery += RETSQLNAME("BI3") + " BI3, " + CRLF
	_cQuery += RETSQLNAME("BD5") + " BD5, " + CRLF
	_cQuery += RETSQLNAME("BE4") + " BE4, " + CRLF
	_cQuery += RETSQLNAME("BR8") + " BR8, " + CRLF
	_cQuery += RETSQLNAME("BE2") + " BE2, " + CRLF
	_cQuery += RETSQLNAME("BQV") + " BQV  " + CRLF
	_cQuery += " WHERE A2_COD = B19_FORNEC " + CRLF
	_cQuery += " AND D1_DOC = F1_DOC " 	+ CRLF
	_cQuery += " AND B19_DOC = D1_DOC " 	+ CRLF
	_cQuery += " AND D1_ITEM = B19_ITEM " 	+ CRLF
	_cQuery += " AND BD6_FILIAL = '" + xFilial("BD6") + "' " 	+ CRLF
	_cQuery += " AND BD6_CODOPE = SubStr(B19_GUIA,01,04) " + CRLF
	_cQuery += " AND BD6_CODLDP = SubStr(B19_GUIA,05,04) " + CRLF
	_cQuery += " AND BD6_CODPEG = SubStr(B19_GUIA,09,08) " + CRLF
	_cQuery += " AND BD6_NUMERO = SubStr(B19_GUIA,17,08) " + CRLF
	_cQuery += " AND BD6_ORIMOV = SubStr(B19_GUIA,25,01) " + CRLF
	_cQuery += " AND BD6_SEQUEN = SubStr(B19_GUIA,26,03) " + CRLF
	
	If !Empty(MV_PAR03) .And. !Empty(MV_PAR04)
	
		_cQuery += " AND F1_FORNECE BETWEEN '" + MV_PAR03 + "' AND '" + MV_PAR04 + "' " + CRLF
	
	EndIf
	
	If !Empty(MV_PAR05) .And. !Empty(MV_PAR06)
	
		_cQuery += " AND E2_EMISSAO >= '" + DTOS(MV_PAR05) + "' " 	+ CRLF
		_cQuery += " AND E2_EMISSAO <= '" + DTOS(MV_PAR06) + "' " 	+ CRLF
	
	EndIf	
	
	If !Empty(MV_PAR08) .And. !Empty(MV_PAR09)
	
		_cQuery += " AND E2_BAIXA >= '" + DTOS(MV_PAR08) + "' " 	+ CRLF
		_cQuery += " AND E2_BAIXA <= '" + DTOS(MV_PAR09) + "' " 	+ CRLF	
	
	EndIf	
	
	If !Empty(MV_PAR10) .And. !Empty(MV_PAR11)
	
		_cQuery += " AND E2_VENCREA >= '" + DTOS(MV_PAR10) + "' " 	+ CRLF
		_cQuery += " AND E2_VENCREA <= '" + DTOS(MV_PAR11) + "' " 	+ CRLF	
	
	EndIf
	
	If !(MV_PAR07 == 3)
		
		If MV_PAR07 == 2
			
			_cQuery += " AND E2_BAIXA <> ' ' " 
		
		Else
			
			_cQuery += " AND E2_BAIXA = ' ' "
		
		Endif
		
	EndIf
	
	_cQuery += " AND BI3_FILIAL = '" + xFilial("BI3") + "' " 			+ CRLF
	_cQuery += " AND BI3_CODINT = BD6_CODOPE " 	+ CRLF
	_cQuery += " AND BI3_CODIGO = retorna_plano_usu_ms ('C',BD6_OPEUSR,BD6_CODEMP, BD6_MATRIC, BD6_TIPREG,'N') " + CRLF
	
	If !Empty(MV_PAR01) .And. !Empty(MV_PAR02)
	
		_cQuery += " AND BI3_CODIGO BETWEEN '" + MV_PAR01 + "' AND '" + MV_PAR02 + "' " + CRLF
		
	EndIf
	
	_cQuery += " AND E2_FILIAL = '" + xFilial("SE2") + "' " 			+ CRLF
	_cQuery += " AND A2_FILIAL = '" + xFilial("SA2") + "' " 			+ CRLF
	_cQuery += " AND D1_FILIAL = '" + xFilial("SD1") + "' " 			+ CRLF
	_cQuery += " AND F1_FILIAL = '" + xFilial("SF1") + "' " 			+ CRLF
	_cQuery += " AND F1_FORNECE = D1_FORNECE " 	+ CRLF
	_cQuery += " AND F1_FORNECE = B19_FORNEC " 	+ CRLF
	_cQuery += " AND E2_FILIAL = F1_FILIAL " 		+ CRLF
	_cQuery += " AND E2_PREFIXO = F1_SERIE " 		+ CRLF
	_cQuery += " AND E2_NUM = F1_DOC " 			+ CRLF
	_cQuery += " AND E2_FORNECE = F1_FORNECE " 	+ CRLF
	_cQuery += " AND SE2.D_E_L_E_T_ = ' ' " 		+ CRLF
	_cQuery += " AND SA2.D_E_L_E_T_ = ' ' " 		+ CRLF
	_cQuery += " AND B19.D_E_L_E_T_ = ' ' " 		+ CRLF
	_cQuery += " AND SD1.D_E_L_E_T_ = ' ' " 		+ CRLF
	_cQuery += " AND SF1.D_E_L_E_T_ = ' ' " 		+ CRLF
	_cQuery += " AND BI3.D_E_L_E_T_ = ' ' " 		+ CRLF
	_cQuery += " AND BD6.D_E_L_E_T_ = ' ' " 		+ CRLF
	_cQuery += " AND BD5.D_E_L_E_T_ = ' ' " 		+ CRLF
	_cQuery += " AND BE4.D_E_L_E_T_ = ' ' " 		+ CRLF
	_cQuery += " AND BD5_FILIAL = BD6_FILIAL " 	+ CRLF
	_cQuery += " AND BE4_TIPGUI='03' " 			+ CRLF
	
	_cQuery += " AND BE4_CODOPE = SubStr(BD5_GUIINT,01,04) " + CRLF
	_cQuery += " AND BE4_CODLDP = SubStr(BD5_GUIINT,05,04) " + CRLF
	_cQuery += " AND BE4_CODPEG = SubStr(BD5_GUIINT,09,08) " + CRLF
	_cQuery += " AND BE4_NUMERO = SubStr(BD5_GUIINT,17,08) " + CRLF
	
	_cQuery += " AND BD5_CODOPE = BD6_CODOPE " 	+ CRLF
	_cQuery += " AND BD5_CODLDP = BD6_CODLDP " 	+ CRLF
	_cQuery += " AND BD5_CODPEG = BD6_CODPEG " 	+ CRLF
	_cQuery += " AND BD5_NUMERO = BD6_NUMERO " 	+ CRLF
	_cQuery += " AND BD5_ORIMOV = BD6_ORIMOV " 	+ CRLF
	
	_cQuery += " AND BE2_ANOINT = BE4_ANOINT " 	+ CRLF
	_cQuery += " AND BE2_MESINT = BE4_MESINT " 	+ CRLF
	_cQuery += " AND BE2_NUMINT = BE4_NUMINT " 	+ CRLF
	_cQuery += " AND BE2_OPEMOV = BQV_CODOPE " 	+ CRLF
	_cQuery += " AND BE2_ANOAUT = BQV_ANOINT " 	+ CRLF
	_cQuery += " AND BE2_MESINT = BQV_MESINT " 	+ CRLF
	_cQuery += " AND BE2_NUMINT = BQV_NUMINT " 	+ CRLF
	_cQuery += " AND BR8_FILIAL = '" + xFilial("BR8") + "' " 	+ CRLF
	_cQuery += " AND BR8_CODPAD = BQV_CODPAD " 	+ CRLF
	_cQuery += " AND BR8_CODPSA = BQV_CODPRO " 	+ CRLF
	_cQuery += " AND BR8_FILIAL = '" + xFilial("BR8") + "' " 	+ CRLF
	_cQuery += " AND BR8_CODPAD = BQV_CODPAD " 	+ CRLF
	_cQuery += " AND BR8_CODPSA = BQV_CODPRO " 	+ CRLF
	_cQuery += " AND BR8_TPPROC IN ('0','6') " 	+ CRLF
	_cQuery += " AND BR8_YMATER ='1' " 			+ CRLF
	_cQuery += " AND BR8.D_E_L_E_T_ = ' ' " 		+ CRLF
	_cQuery += " AND BD5.D_E_L_E_T_ = ' ' " 		+ CRLF
	_cQuery += " AND BD6.D_E_L_E_T_ = ' ' " 		+ CRLF
	_cQuery += " AND BE2.D_E_L_E_T_ = ' ' " 		+ CRLF
	_cQuery += " AND BE4.D_E_L_E_T_ = ' ' " 		+ CRLF
	_cQuery += " AND BQV.D_E_L_E_T_ = ' ' " 		+ CRLF
	_cQuery += " AND BQV_FILIAL = '" + xFilial("BQV") + "' " 	+ CRLF
	
	_cQuery += " ORDER BY CODPLANO, " 	+ CRLF
	_cQuery += " F1_FORNECE, " 			+ CRLF
	_cQuery += " F1_DOC, " 				+ CRLF
	_cQuery += " E2_VENCTO, " 			+ CRLF
	_cQuery += " E2_BAIXA " 				+ CRLF
	
	If Select(_cAlias1) > 0
		(_cAlias1)->(DbCloseArea())
	EndIf
	
	PLSQuery(_cQuery,_cAlias1)
	
	oSection1:Init()
	oSection1:SetHeaderSection(.T.)
	
	_cSenha 	:= ""
	
	_nTtGr		:= 0 //Total Geral
	_nTtDs		:= 0 //Total Desconto
	
	While !(_cAlias1)->(eof())
		
		oReport:IncMeter()
		
		If oReport:Cancel()
			Exit
		EndIf
		
		If _cSenha != (_cAlias1)->BE4_SENHA
		
			_cSenha := (_cAlias1)->BE4_SENHA
			
		Else
		
			(_cAlias1)->(DbSkip())
			Loop
		
		EndIf
		
		_nTtGr		+= (_cAlias1)->VLRLIQUIDO //Total Geral
		_nTtDs		+= (_cAlias1)->DESCONTO //Total Desconto
						
		oSection1:Cell("BD6_NOMUSR"	):SetValue( (_cAlias1)->BENEF			) //01 -- Nome Beneficiแrio
		oSection1:Cell("BI3_DESCRI"	):SetValue( (_cAlias1)->DSCPLA			) //02 -- Descri็ใo Plano
		oSection1:Cell("BE4_SENHA"	):SetValue( (_cAlias1)->BE4_SENHA		) //03 -- Senha
		oSection1:Cell("BR8_DESCRI"	):SetValue( (_cAlias1)->BR8_DESCRI		) //04 -- Procedimento
		oSection1:Cell("BE4_NOMRDA"	):SetValue( (_cAlias1)->REDE			) //05 -- Nome da Rede
		oSection1:Cell("BE4_NOMSOL"	):SetValue( (_cAlias1)->MEDICO			) //06 -- Nome do solicitante (Medico)
		oSection1:Cell("Fornecedor"	):SetValue( (_cAlias1)->A2_NOME			) //07 -- Fornecedor
		oSection1:Cell("E2_VALOR"	):SetValue( (_cAlias1)->VLRLIQUIDO		) //08 -- Valor Liquido (Valor Autorizado)
		oSection1:Cell("DESCONTO"	):SetValue( (_cAlias1)->DESCONTO		) //09 -- Desconto
		oSection1:Cell("E2_VENCTO"	):SetValue( (_cAlias1)->E2_VENCTO		) //10 -- Vencimento
		oSection1:Cell("E2_BAIXA"	):SetValue( (_cAlias1)->E2_BAIXA		) //11 -- Data de Pagamento
				
		oSection1:PrintLine()
		
		(_cAlias1)->(DbSkip())
		
	EndDo
	
	
	oSection2:Init()
	oSection2:SetHeaderSection(.T.)
			
	oSection2:Cell("Total Geral"	):SetValue(_nTtGr	)
	oSection2:Cell("Total Desconto"	):SetValue(_nTtDs	)
	
	oSection2:PrintLine()
	
	oSection2:Finish()

	oSection1:Finish()
	
	If Select(_cAlias1) > 0
		(_cAlias1)->(DbCloseArea())
	EndIf
	
	RestArea(_aArea)
	
Return(.T.)


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCABR211C  บAutor  ณAngelo Henrique     บ Data ณ  17/08/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRotina responsavel pela gera็ใo das perguntas no relat๓rio  บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CABERJ                                                     บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function CABR211C(cGrpPerg)
	
	Local aHelpPor := {} //help da pergunta

	aHelpPor := {}
	AADD(aHelpPor,"Indique a Data de 				")
	AADD(aHelpPor,"Movimenta็ใo						")
	
	PutSx1(cGrpPerg,"01","Plano De ?"			,"a","a","MV_CH1"	,"C",TamSX3("BI3_CODIGO")[1]	,0,0,"G","","","","","MV_PAR01","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")
	PutSx1(cGrpPerg,"02","Plano Ate ?"			,"a","a","MV_CH2"	,"C",TamSX3("BI3_CODIGO")[1]	,0,0,"G","","","","","MV_PAR02","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")
	
	aHelpPor := {}
	AADD(aHelpPor,"Indique o Fornecedor			")
	AADD(aHelpPor,"           						")
		
	PutSx1(cGrpPerg,"03","Fornecedor De ?"		,"a","a","MV_CH3"	,"C",TamSX3("F1_FORNECE")[1]	,0,0,"G","","","","","MV_PAR03","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")
	PutSx1(cGrpPerg,"04","Fornecedor Ate ?"	,"a","a","MV_CH4"	,"C",TamSX3("F1_FORNECE")[1]	,0,0,"G","","","","","MV_PAR04","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")
	
	aHelpPor := {}
	AADD(aHelpPor,"Indique a Data de Movimento	")
	AADD(aHelpPor,"           						")
		
	PutSx1(cGrpPerg,"05","Data Movto De ?"		,"a","a","MV_CH5"	,"D",TamSX3("E2_EMISSAO")[1]	,0,0,"G","","","","","MV_PAR05","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")
	PutSx1(cGrpPerg,"06","Data Movto Ate ?"	,"a","a","MV_CH6"	,"D",TamSX3("E2_EMISSAO")[1]	,0,0,"G","","","","","MV_PAR06","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")
			
	aHelpPor := {}
	AADD(aHelpPor,"Tipo de Relatorio	 			")
	AADD(aHelpPor,"           						")
	
	PutSx1(cGrpPerg,"07","Tipo de Relat. ?"	,"a","a","MV_CH7"	,"C",1								,0,0,"C","","","","","MV_PAR07","Autorizado","","","","Pago","","","Ambos","","","","","","","","",aHelpPor,{},{},"")
		
	aHelpPor := {}
	AADD(aHelpPor,"Indique a Data de Pagamento	")
	AADD(aHelpPor,"           						")
		
	PutSx1(cGrpPerg,"08","Data Pagto De ?"		,"a","a","MV_CH8"	,"D",TamSX3("E2_BAIXA")[1]		,0,0,"G","","","","","MV_PAR08","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")
	PutSx1(cGrpPerg,"09","Data Pagto Ate ?"	,"a","a","MV_CH9"	,"D",TamSX3("E2_BAIXA")[1]		,0,0,"G","","","","","MV_PAR09","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")
	
	aHelpPor := {}
	AADD(aHelpPor,"Indique a Data de Vencimento	")
	AADD(aHelpPor,"           						")
		
	PutSx1(cGrpPerg,"10","Data Venc De ?"		,"a","a","MV_CH10"	,"D",TamSX3("E2_VENCREA")[1],0,0,"G","","","","","MV_PAR10","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")
	PutSx1(cGrpPerg,"11","Data Venc Ate ?"		,"a","a","MV_CH11"	,"D",TamSX3("E2_VENCREA")[1],0,0,"G","","","","","MV_PAR11","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")
				
Return
