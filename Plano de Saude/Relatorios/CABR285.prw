#INCLUDE "rwmake.ch"
#INCLUDE "protheus.ch"
#INCLUDE "TopConn.ch"
#include "TBICONN.CH"    

#DEFINE c_ent CHR(13) + CHR(10)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัอออออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCABR284      บAutor  ณ ANDERSON RANGEL   บ Data ณ FEVEREIRO/21 บฑฑ
ฑฑฬออออออออออุอออออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ  RELATำRIO PARA AUXILIAR NA AUTOMAวรO DO PROCESSO             บฑฑ 
ฑฑบ          ณ  DE IMPLANTAวรO DE PRESTADORES JUNTO A OPERATIVA E GERED.     บฑฑ
ฑฑฬออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ  Relat๓rios / Projeto Caberj                                  บฑฑ
ฑฑศออออออออออฯอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function CABR285()

    Local _aArea 	:= GetArea()
	Local oReport	:= Nil

	Private _cPerg  := "CABR285"
	private cCodusu := SubStr(cUSUARIO,7,15)
	private nPos    := 0
	private aGerenc := {}
	PRIVATE ANOMES  := ' '    
	private MV_PAR08 := 1

	//Cria grupo de perguntas
	CABR285A(_cPerg)

	If Pergunte(_cPerg,.T.)

		oReport := CABR285B()
		oReport:PrintDialog()

	EndIf

	RestArea(_aArea)

return()

//Perguntas
Static Function CABR285A(cGrpPerg)

	Local aHelpPor := {} //help da pergunta

	PutSx1(cGrpPerg,"01","RDA De ? "		  ,"a","a","MV_CH1"	,"C",	,0,0,"G","","BAUPLS"	,"","","MV_PAR01",         "","","","" ,"","","","","","","","","","","","",aHelpPor,{},{},"")
	PutSx1(cGrpPerg,"02","RDA Ate ?"		  ,"a","a","MV_CH2"	,"C",	,0,0,"G","","BAUPLS"	,"","","MV_PAR02",         "","","","" ,"","","","","","","","","","","","",aHelpPor,{},{},"")
	
Return

Static Function CABR285B

	Local oReport		:= Nil
	Local oSection1 	:= Nil
	Local oSection2 	:= Nil
	Local oBreak		:= Nil
	
	oReport := TReport():New("CABR285","RELATำRIO DE IMPLANTAวรO DE PRESTADORES OPERATIVA/GERED",_cPerg,{|oReport| CABR285C(oReport)},"Implanta็ใo de Prestadores Operativa/GERED")

	//Impressใo formato paisagem
	oReport:SetLandScape() //Orienta็ใo paisagem
	oReport:SetTotalInLine(.F.)	
	oReport:nLineHeight	:= 30
	oReport:cFontBody		:= "Arial"
	oReport:nColSpace		:= 1

	oSection1 := TRSection():New(oReport,"SITUAวรO OPERATIVA","")
	TRCell():New(oSection1 ,'SITUACAO_MEDLINK'	    ,  ,'Situa็ใo Operativa '    	   ,/*Picture*/			,60				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
	
	oSection2 := TRSection():New(oReport,"PRESTADOR(ES)","")
	TRCell():New(oSection2 ,'CODIGO'	    ,  ,'Codigo RDA '	    ,/*Picture*/	    	,07				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"	)
	TRCell():New(oSection2 ,'NOME'    	    ,  ,'Nome RDA '	        ,/*Picture*/	    	,40				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"	)
    TRCell():New(oSection2 ,'NOME_FANTASIA' ,  ,'Nome Fantasia RDA ',/*Picture*/	    	,40				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"	)
	TRCell():New(oSection2 ,'CPF_CNPJ'      ,  ,'CPF/CNPJ'          ,/*Picture*/			,20				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
	TRCell():New(oSection2 ,'ENDERECO'      ,  ,'Endere็o'          ,/*Picture*/	 		,40          	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
	TRCell():New(oSection2 ,'NUMERO'        ,  ,'Numero'            ,/*Picture*/			,06				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
	TRCell():New(oSection2 ,'BAIRRO'        ,  ,'Bairro'            ,/*Picture*/	 		,20          	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
	TRCell():New(oSection2 ,'CEP'           ,  ,'Cep'               ,/*Picture*/	 		,10          	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
    TRCell():New(oSection2 ,'MUNICIPIO'     ,  ,'Municipio'         ,/*Picture*/			,20				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
	TRCell():New(oSection2 ,'ESTADO'        ,  ,'Estado'            ,/*Picture*/			,02				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
	TRCell():New(oSection2 ,'TELEFONE'      ,  ,'Telefone'          ,/*Picture*/	 		,20          	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
	TRCell():New(oSection2 ,'OUTRO_CONTATO' ,  ,'Outro Contato'     ,/*Picture*/			,10				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
	TRCell():New(oSection2 ,'ENVIA_XML'     ,  ,'Envia XML'	        ,/*Picture*/	 		,01          	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
	TRCell():New(oSection2 ,'PESSOA' 	    ,  ,'Pessoa'            ,/*Picture*/			,01				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
	TRCell():New(oSection2 ,'CLASSE' 	    ,  ,'Classe'            ,/*Picture*/	 		,03          	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
	TRCell():New(oSection2 ,'E_MAIL' 	    ,  ,'E-Mail'            ,/*Picture*/			,30				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
		
	TRFunction():SetEndSection(.T.)

	oReport:SkipLine()
    oBreak := TRBreak():New(oSection1,oSection2:Cell("NOME"),"TOTAIS POR SITUAวรO: ")
	TRFunction():New(oSection2:Cell("E_MAIL"),NIL,"COUNT",oBreak,,,,.F.,.T.)
    oReport:SkipLine()

Return oReport

Static Function CABR285C(oReport)

	Local _aArea 		:= GetArea()
	Local oSection1 	:= oReport:Section(1)
	Local oSection2 	:= oReport:Section(2)

	Local _cQuery		:= ""
	Local (cAlias1)	:= GetNextAlias()
	Local cCtrlSTATUS := ""
	Local nContGuia := 0
	
_cQuery += " SELECT 												" + c_ent
_cQuery += " (CASE WHEN BAU_XMEDLI = 'S' THEN 'IMPLANTADO' " + c_ent
_cQuery += "       WHEN BAU_XMEDLI = 'I' THEN 'EM IMPLANTAวรO' " + c_ent
_cQuery += "       WHEN BAU_XMEDLI = 'D' THEN 'DESCONTINUADO' " + c_ent
_cQuery += "       WHEN BAU_XMEDLI = 'N' THEN 'NรO IMPLANTADO' " + c_ent
_cQuery += "       WHEN BAU_XMEDLI = ' ' THEN 'SEM CLASSIFICAวรO' " + c_ent
_cQuery += "       ELSE TRIM(BAU_XMEDLI) " + c_ent
_cQuery += " END) SITUACAO_MEDLINK, " + c_ent
_cQuery += " BAU_CODIGO CODIGO,  " + c_ent
_cQuery += " BAU_NOME NOME,  " + c_ent
_cQuery += " BAU_NFANTA NOME_FANTASIA,  " + c_ent
_cQuery += " BAU_CPFCGC CPF_CNPJ, " + c_ent
_cQuery += " BB8.BB8_END ENDERECO, " + c_ent
_cQuery += " BB8_NR_END NUMERO, " + c_ent
_cQuery += " BB8_COMEND COMPLEMENTO, " + c_ent
_cQuery += " BB8_BAIRRO BAIRRO, " + c_ent
_cQuery += " BB8_MUN MUNICIPIO, " + c_ent
_cQuery += " BB8_CEP CEP, " + c_ent
_cQuery += " BB8.BB8_EST ESTADO, " + c_ent
_cQuery += " BB8_TEL TELEFONE, " + c_ent
_cQuery += " BB8_CONTAT OUTRO_CONTATO, " + c_ent
_cQuery += " BAU.BAU_XMEDLI ENVIA_XML, " + c_ent
_cQuery += " BAU_TIPPE PESSOA, " + c_ent
_cQuery += " BAU_TIPPRE CLASSE, " + c_ent
_cQuery += " (CASE WHEN BB8_EMAIL <> '' THEN BB8_EMAIL||' / '||BAU_EMAIL " + c_ent
_cQuery += "       ELSE BB8_EMAIL " + c_ent
_cQuery += " END) E_MAIL  " + c_ent
_cQuery += " FROM " + RetSqlName("BAU") + " BAU, " + RetSqlName("BB8") + " BB8, " + RetSqlName("BID") + " BID " + c_ent
_cQuery += " WHERE  BAU.D_E_L_E_T_ <> '*' AND   " + c_ent
_cQuery += "        BAU.BAU_FILIAL =  ' ' AND   " + c_ent
_cQuery += "        BID.D_E_L_E_T_ <> '*' AND   " + c_ent
_cQuery += "        BID.BID_FILIAL =  ' ' AND   " + c_ent
_cQuery += "        BB8.D_E_L_E_T_ <> '*' AND   " + c_ent
_cQuery += "        BB8.BB8_FILIAL = ' ' AND  " + c_ent
_cQuery += "        BAU.BAU_CODBLO = ' ' AND   " + c_ent
_cQuery += "        BAU.BAU_DATBLO = ' ' AND   " + c_ent
_cQuery += "        BAU_DTEXCL = ' '     AND  " + c_ent
_cQuery += "        BAU_TIPPRE <> 'ODN' AND " + c_ent
_cQuery += "        BB8.BB8_CODIGO = BAU.BAU_CODIGO AND  " + c_ent
_cQuery += "        BAU.BAU_MUN = BID.BID_CODMUN AND " + c_ent
	
	If !Empty(MV_PAR01)
		_cQuery += "    BAU_CODIGO >= '"+MV_PAR01+"' "+ c_ent
	Endif
	If !Empty(MV_PAR02)
		_cQuery += "    BAU_CODIGO <= '"+MV_PAR02+"' "+ c_ent
	Endif

	_cQuery += "  ORDER BY 1,2	 " 	+ c_ent
	

	If Select ((cAlias1)) > 0
		dbSelectArea( (cAlias1) )
		dbCloseArea()
	EndIf

	dbUseArea(.T., "TOPCONN",  TCGenQry(,,_cQuery), (cAlias1), .F., .T.)

	If !((cAlias1))->(eof()) 
		(cAlias1)->(DBGOTOP())
		oReport:SetMeter((cAlias1)->(LastRec()))

		While !((cAlias1))->(eof()) 
			If oReport:Cancel()
				Exit
			EndIf

			//Inicia Primeira Se็ใo
			oSection1:Init()
			oSection1:SetHeaderSection(.F.)
			
			oReport:IncMeter()
			
			//Guarda o Conteudo do campo SITUACAO_MEDLINK para comparar no While abaixo. Usado para Quebra de se็ใo           
			cCtrlSTATUS := (cAlias1)->SITUACAO_MEDLINK
			oSection1:Cell("SITUACAO_MEDLINK"):SetValue("SITUAวรO --> " + (cAlias1)->SITUACAO_MEDLINK)
			oSection1:PrintLine() 
			oReport:SkipLine()
			
			//Inicia Segunda Se็ใo			
			oSection2:Init() 

			While (cAlias1)->SITUACAO_MEDLINK == cCtrlSTATUS
                nContGuia := 0
				oReport:IncMeter()
				oSection2:Cell("CODIGO"):SetValue((cAlias1)->CODIGO) 
				oSection2:Cell("NOME"):SetValue((cAlias1)->NOME)
                oSection2:Cell("NOME_FANTASIA"):SetValue((cAlias1)->NOME_FANTASIA)  
				oSection2:Cell("CPF_CNPJ"):SetValue((cAlias1)->CPF_CNPJ)
				oSection2:Cell("ENDERECO"):SetValue((cAlias1)->ENDERECO) 
				oSection2:Cell("NUMERO"):SetValue((cAlias1)->NUMERO) 
				oSection2:Cell("BAIRRO"):SetValue((cAlias1)->BAIRRO)
				oSection2:Cell("CEP"):SetValue((cAlias1)->CEP)
				oSection2:Cell("MUNICIPIO"):SetValue((cAlias1)->MUNICIPIO)   
				oSection2:Cell("ESTADO"):SetValue((cAlias1)->ESTADO) 
				oSection2:Cell("TELEFONE"):SetValue((cAlias1)->TELEFONE)            
				oSection2:Cell("OUTRO_CONTATO"):SetValue((cAlias1)->OUTRO_CONTATO)
				oSection2:Cell("ENVIA_XML"):SetValue((cAlias1)->ENVIA_XML)
				oSection2:Cell("PESSOA"):SetValue((cAlias1)->PESSOA)
				oSection2:Cell("CLASSE"):SetValue((cAlias1)->CLASSE)   
				oSection2:Cell("E_MAIL"):SetValue((cAlias1)->E_MAIL) 
				oSection2:PrintLine()			
				nContGuia++
				(cAlias1)->(DbSkip())
			Enddo
			oReport:SkipLine()
			oSection2:Finish()
		EndDo
        oSection1:PrintLine()
		oReport:SkipLine()
		oSection1:Finish()
	Endif

	If Select ((cAlias1)) > 0
		dbSelectArea( (cAlias1) )
		dbCloseArea()
	EndIf

	RestArea(_aArea)   

Return (.T.)