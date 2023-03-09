#INCLUDE "TOPCONN.CH"
#INCLUDE "RWMAKE.CH"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "TBICONN.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABR289     ºAutor  ³Anderson Rangel   º Data ³  JULHO/2021 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Relatório Tabela Sub-Contrato                               º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CABERJ                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function CABR289()
	
	Local _aArea 	:= GetArea()
	Local oReport	:= Nil
	Private _cPerg	:= "CABR289"
	
	//Cria grupo de perguntas
	CABR289C(_cPerg)
	
	If Pergunte(_cPerg,.T.)
		
		//----------------------------------------------------
		//Validando se existe o Excel instalado na máquina
		//para não dar erro e o usuário poder visualizar em
		//outros programas como o LibreOffice
		//----------------------------------------------------
		If ApOleClient("MSExcel")
			
            If MV_PAR10 = 1	
				oReport := CABR289A()
            	oReport:PrintDialog()
			Else
				oReport := CABR289R()
            	oReport:PrintDialog()
			EndIf
		Else
			
			Processa({||CABR289E()},'Processando...')
			
		EndIf
		
	EndIf
	
	RestArea(_aArea)
	
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  CABR289R  ºAutor  ³Anderson Rangel     º Data ³ OUTUBRO/2021 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Rotina que irá gerar as informações do relatório            º±±
±±º          ³ (Formato Reduzido)                                         º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CABERJ                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function CABR289R
	
	Local oReport		:= Nil
	Local oSection1 	:= Nil
	
	oReport := TReport():New("CABR289","RELATÓRIO CLASSE DE CARÊNCIA (REDUZIDO)",_cPerg,{|oReport| CABR289B(oReport)},"Relatório Classe de Carência por Grupo Empresa")
	
	oReport:SetPortrait() 
	oReport:cFontBody	:= "Arial"
    oReport:nLineHeight	:= 30 // Define a altura da linha.
	oReport:nColSpace	:= 1
	oReport:oPage:setPaperSize(12)
	
	//--------------------------------
	//Primeira linha do relatório
	//--------------------------------
	oSection1 := TRSection():New(oReport,"DADOS","BA6, BDL, BAE, BAT")
	
	TRCell():New(oSection1,"CODIGO" 		,"BDL")
	oSection1:Cell("CODIGO"):SetAutoSize(.F.)
	oSection1:Cell("CODIGO"):SetSize(10)

	TRCell():New(oSection1,"CLASSE" 	    ,"BDL")
	oSection1:Cell("CLASSE"):SetAutoSize(.F.)
	oSection1:Cell("CLASSE"):SetSize(TAMSX3("BDL_DESCRI")[1])

    TRCell():New(oSection1,"CARENCIA" 	    ,"BA6")
	oSection1:Cell("CARENCIA"):SetAutoSize(.F.)
	oSection1:Cell("CARENCIA"):SetSize(15)

	TRCell():New(oSection1,"UNIDADE" 		,"BA6")
	oSection1:Cell("UNIDADE"):SetAutoSize(.F.)
	oSection1:Cell("UNIDADE"):SetSize(15)

	TRCell():New(oSection1,"CARENCIA NOVOS BENEF." 	    ,"BA6")
	oSection1:Cell("CARENCIA NOVOS BENEF."):SetAutoSize(.F.)
	oSection1:Cell("CARENCIA NOVOS BENEF."):SetSize(TAMSX3("BA6_XCANBE")[1])

	TRCell():New(oSection1,"UNIDADE NOVOS BENEF." 	    ,"BA6")
	oSection1:Cell("UNIDADE NOVOS BENEF."):SetAutoSize(.F.)
	oSection1:Cell("UNIDADE NOVOS BENEF."):SetSize(TAMSX3("BA6_XUNNBE")[1])

	TRCell():New(oSection1,"CARENCIA ADVINDOS CONC." 	    ,"BA6")
	oSection1:Cell("CARENCIA ADVINDOS CONC."):SetAutoSize(.F.)
	oSection1:Cell("CARENCIA ADVINDOS CONC."):SetSize(TAMSX3("BA6_XCABEC")[1])

	TRCell():New(oSection1,"UNIDADE ADV_CONC." 	    ,"BA6")
	oSection1:Cell("UNIDADE ADV_CONC."):SetAutoSize(.F.)
	oSection1:Cell("UNIDADE ADV_CONC."):SetSize(TAMSX3("BA6_XUNBEC")[1])

	TRCell():New(oSection1,"CARENCIA REDUZIDA" 	    ,"BA6")
	oSection1:Cell("CARENCIA REDUZIDA"):SetAutoSize(.F.)
	oSection1:Cell("CARENCIA REDUZIDA"):SetSize(TAMSX3("BA6_CAREDU")[1])

    TRCell():New(oSection1,"PLANO" 	    	,"BA6")
	oSection1:Cell("PLANO"):SetAutoSize(.F.)
	oSection1:Cell("PLANO"):SetSize(10)

    TRCell():New(oSection1,"DESCRICAO PLANO","BA6")
	oSection1:Cell("DESCRICAO PLANO"):SetAutoSize(.F.)
	oSection1:Cell("DESCRICAO PLANO"):SetSize(28)

	TRCell():New(oSection1,"EMPRESA" 		,"BA6")
	oSection1:Cell("EMPRESA"):SetAutoSize(.F.)
	oSection1:Cell("EMPRESA"):SetSize(10)

    TRCell():New(oSection1,"CONTRATO" 	    ,"BA6")
	oSection1:Cell("CONTRATO"):SetAutoSize(.F.)
	oSection1:Cell("CONTRATO"):SetSize(25)

	TRCell():New(oSection1,"SUBCONTRATO" 	,"BA6")
	oSection1:Cell("SUBCONTRATO"):SetAutoSize(.F.)
	oSection1:Cell("SUBCONTRATO"):SetSize(20)

    TRCell():New(oSection1,"DESCRICAO SUBCONTRATO","BA6")
	oSection1:Cell("DESCRICAO SUBCONTRATO"):SetAutoSize(.F.)
	oSection1:Cell("DESCRICAO SUBCONTRATO"):SetSize(35)

    TRFunction():SetEndSection(.T.)

Return oReport

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABR289A  ºAutor  ³Anderson Rangel     º Data ³  JULHO/2021 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Rotina que irá gerar as informações do relatório            º±±
±±º          ³ (Formtato Paisagem)                                        º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CABERJ                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function CABR289A
	
	Local oReport		:= Nil
	Local oSection1 	:= Nil
	
	oReport := TReport():New("CABR289","RELATÓRIO CLASSE DE CARÊNCIA",_cPerg,{|oReport| CABR289B(oReport)},"Relatório Classe de Carência por Grupo Empresa")
	
	oReport:SetLandScape()
	oReport:cFontBody	:= "Arial"
    oReport:nLineHeight	:= 30 // Define a altura da linha.
	oReport:nColSpace	:= 1
	oReport:oPage:setPaperSize(12)
	
	//--------------------------------
	//Primeira linha do relatório
	//--------------------------------
	oSection1 := TRSection():New(oReport,"DADOS","BA6, BDL, BAE, BAT")
	
	TRCell():New(oSection1,"NIVEL" 			,"")
	oSection1:Cell("NIVEL"):SetAutoSize(.F.)
	oSection1:Cell("NIVEL"):SetSize(5)

	TRCell():New(oSection1,"CODIGO" ,"BDL")
	oSection1:Cell("CODIGO"):SetAutoSize(.F.)
	oSection1:Cell("CODIGO"):SetSize(TAMSX3("BDL_CODIGO")[1])

	TRCell():New(oSection1,"CLASSE" 	    ,"BDL")
	oSection1:Cell("CLASSE"):SetAutoSize(.F.)
	oSection1:Cell("CLASSE"):SetSize(TAMSX3("BDL_DESCRI")[1])

    TRCell():New(oSection1,"CARENCIA" 	    ,"BA6")
	oSection1:Cell("CARENCIA"):SetAutoSize(.F.)
	oSection1:Cell("CARENCIA"):SetSize(15)

	TRCell():New(oSection1,"UNIDADE" 		,"BA6")
	oSection1:Cell("UNIDADE"):SetAutoSize(.F.)
	oSection1:Cell("UNIDADE"):SetSize(15)

	TRCell():New(oSection1,"CARENCIA NOVOS BENEF." 	    ,"BA6")
	oSection1:Cell("CARENCIA NOVOS BENEF."):SetAutoSize(.F.)
	oSection1:Cell("CARENCIA NOVOS BENEF."):SetSize(TAMSX3("BA6_XCANBE")[1])

	TRCell():New(oSection1,"UNIDADE NOVOS BENEF." 	    ,"BA6")
	oSection1:Cell("UNIDADE NOVOS BENEF."):SetAutoSize(.F.)
	oSection1:Cell("UNIDADE NOVOS BENEF."):SetSize(TAMSX3("BA6_XUNNBE")[1])

	TRCell():New(oSection1,"CARENCIA ADVINDOS CONC." 	    ,"BA6")
	oSection1:Cell("CARENCIA ADVINDOS CONC."):SetAutoSize(.F.)
	oSection1:Cell("CARENCIA ADVINDOS CONC."):SetSize(TAMSX3("BA6_XCABEC")[1])

	TRCell():New(oSection1,"UNIDADE ADV_CONC." 	    ,"BA6")
	oSection1:Cell("UNIDADE ADV_CONC."):SetAutoSize(.F.)
	oSection1:Cell("UNIDADE ADV_CONC."):SetSize(TAMSX3("BA6_XUNBEC")[1])

	// TRCell():New(oSection1,"CARENCIA REDUZIDA" 	    ,"BA6")
	// oSection1:Cell("CARENCIA REDUZIDA"):SetAutoSize(.F.)
	// oSection1:Cell("CARENCIA REDUZIDA"):SetSize(TAMSX3("BA6_CAREDU")[1])

	TRCell():New(oSection1,"CARENCIA REDUZIDA" 	    ,"BA6")
	oSection1:Cell("CARENCIA REDUZIDA"):SetAutoSize(.F.)
	oSection1:Cell("CARENCIA REDUZIDA"):SetSize(20)

	TRCell():New(oSection1,"OPERADORA" 	    ,"BA6")
	oSection1:Cell("OPERADORA"):SetAutoSize(.F.)
	oSection1:Cell("OPERADORA"):SetSize(TAMSX3("BA6_CODPRO")[1])

    TRCell():New(oSection1,"PLANO" 	    ,   "BA6")
	oSection1:Cell("PLANO"):SetAutoSize(.F.)
	oSection1:Cell("PLANO"):SetSize(TAMSX3("BA6_CODPRO")[1])

    TRCell():New(oSection1,"DESCRICAO PLANO","BA6")
	oSection1:Cell("DESCRICAO PLANO"):SetAutoSize(.F.)
	oSection1:Cell("DESCRICAO PLANO"):SetSize(20)

	TRCell():New(oSection1,"EMPRESA" ,       "BA6")
	oSection1:Cell("EMPRESA"):SetAutoSize(.F.)
	oSection1:Cell("EMPRESA"):SetSize(TAMSX3("BA6_CODIGO")[1])

	TRCell():New(oSection1,"NOME" 	    ,"BA6")
	oSection1:Cell("NOME"):SetAutoSize(.F.)
	oSection1:Cell("NOME"):SetSize(30)

    TRCell():New(oSection1,"CONTRATO" 	    ,"BA6")
	oSection1:Cell("CONTRATO"):SetAutoSize(.F.)
	oSection1:Cell("CONTRATO"):SetSize(TAMSX3("BA6_NUMCON")[1])

	TRCell():New(oSection1,"SUBCONTRATO" 	    ,"BA6")
	oSection1:Cell("SUBCONTRATO"):SetAutoSize(.F.)
	oSection1:Cell("SUBCONTRATO"):SetSize(TAMSX3("BA6_SUBCON")[1])

    TRCell():New(oSection1,"DESCRICAO SUBCONTRATO" 	    ,"BA6")
	oSection1:Cell("DESCRICAO SUBCONTRATO"):SetAutoSize(.F.)
	oSection1:Cell("DESCRICAO SUBCONTRATO"):SetSize(30)

    TRCell():New(oSection1,"SEXO" 	    ,"BAT")
	oSection1:Cell("SEXO"):SetAutoSize(.F.)
	oSection1:Cell("SEXO"):SetSize(4)

    TRFunction():SetEndSection(.T.)

Return oReport


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABR289B  ºAutor  ³Anderson Rangel     º Data ³  JULHO/2021 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Rotina para montar a query e trazer as informações no       º±±
±±º          ³relatório.                                                  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CABERJ                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function CABR289B(oReport,_cAlias1)
	
	Local _aArea 		:= GetArea()
	Local _cQuery		:= ""
	Local _aAreAC9 		:= AC9->(GetArea())
	
	Private oSection1 	:= oReport:Section(1)
	Private __cAlias1	:= GetNextAlias()
	
	//---------------------------------------------
	//CABR289D Realiza toda a montagem da query
	//facilitando a manutenção do fonte
	//---------------------------------------------
	_cQuery := CABR289D()
	
	If Select(__cAlias1) > 0
		(__cAlias1)->(DbCloseArea())
	EndIf
	
	DbUseArea(.T.,"TOPCONN",TcGenQry(,,_cQuery),__cAlias1,.T.,.T.)
	
    oSection1:Init()
    oSection1:SetHeaderSection(.T.)

	If MV_PAR10 = 1
		While !(__cAlias1)->(EOF())
			
			oReport:IncMeter()
			
			If oReport:Cancel()
				Exit
			EndIf
			
			oSection1:Cell("NIVEL" 	    	        ):SetValue((__cAlias1)->NIVEL)
			oSection1:Cell("CODIGO"                 ):SetValue((__cAlias1)->CODIGO)
			oSection1:Cell("CLASSE"  	            ):SetValue((__cAlias1)->CLASSE)
			oSection1:Cell("CARENCIA"     	        ):SetValue((__cAlias1)->CARENCIA)
			oSection1:Cell("UNIDADE"     	        ):SetValue((__cAlias1)->UNIDADE)
			oSection1:Cell("CARENCIA NOVOS BENEF."  ):SetValue((__cAlias1)->CARENCIA_NB)
			oSection1:Cell("UNIDADE NOVOS BENEF."  	):SetValue((__cAlias1)->UNIDADE_NB)
			oSection1:Cell("CARENCIA ADVINDOS CONC."):SetValue((__cAlias1)->CARENCIA_ADV)
			oSection1:Cell("UNIDADE ADV_CONC."	  	):SetValue((__cAlias1)->UNIDADE_ADV)
			oSection1:Cell("CARENCIA REDUZIDA"      ):SetValue((__cAlias1)->CARENCIA_REDUZ)
			oSection1:Cell("OPERADORA"              ):SetValue((__cAlias1)->OPER)
			oSection1:Cell("PLANO"  	            ):SetValue((__cAlias1)->PLANO)
			oSection1:Cell("DESCRICAO PLANO"        ):SetValue((__cAlias1)->DESCR_PLANO)
			oSection1:Cell("EMPRESA"    	        ):SetValue((__cAlias1)->EMPRESA)
			oSection1:Cell("NOME"                   ):SetValue((__cAlias1)->NOME_EMP)
			oSection1:Cell("CONTRATO"  	            ):SetValue((__cAlias1)->CONTRATO)
			oSection1:Cell("SUBCONTRATO"     	    ):SetValue((__cAlias1)->SUBCONTRATO)
			oSection1:Cell("DESCRICAO SUBCONTRATO"  ):SetValue((__cAlias1)->DESC_SUBCON)
			oSection1:Cell("SEXO"     	            ):SetValue((__cAlias1)->SEXO)
			
			oSection1:PrintLine()
			
			(__cAlias1)->(DbSkip())
		
		EndDo
	else
		While !(__cAlias1)->(EOF())
			
			oReport:IncMeter()
			
			If oReport:Cancel()
				Exit
			EndIf
			
			oSection1:Cell("CODIGO"                 ):SetValue((__cAlias1)->CODIGO)
			oSection1:Cell("CLASSE"  	            ):SetValue((__cAlias1)->CLASSE)
			oSection1:Cell("CARENCIA"     	        ):SetValue((__cAlias1)->CARENCIA)
			oSection1:Cell("UNIDADE"     	        ):SetValue((__cAlias1)->UNIDADE)
			oSection1:Cell("CARENCIA NOVOS BENEF."  ):SetValue((__cAlias1)->CARENCIA_NB)
			oSection1:Cell("UNIDADE NOVOS BENEF."  	):SetValue((__cAlias1)->UNIDADE_NB)
			oSection1:Cell("CARENCIA ADVINDOS CONC."):SetValue((__cAlias1)->CARENCIA_ADV)
			oSection1:Cell("UNIDADE ADV_CONC."	  	):SetValue((__cAlias1)->UNIDADE_ADV)
			oSection1:Cell("CARENCIA REDUZIDA"      ):SetValue((__cAlias1)->CARENCIA_REDUZ)
			oSection1:Cell("PLANO"  	            ):SetValue((__cAlias1)->PLANO)
			oSection1:Cell("DESCRICAO PLANO"        ):SetValue((__cAlias1)->DESCR_PLANO)
			oSection1:Cell("EMPRESA"    	        ):SetValue((__cAlias1)->EMPRESA)
			oSection1:Cell("CONTRATO"  	            ):SetValue((__cAlias1)->CONTRATO)
			oSection1:Cell("SUBCONTRATO"     	    ):SetValue((__cAlias1)->SUBCONTRATO)
			oSection1:Cell("DESCRICAO SUBCONTRATO"  ):SetValue((__cAlias1)->DESC_SUBCON)
			
			oSection1:PrintLine()
			
			(__cAlias1)->(DbSkip())
		
		EndDo
	EndIf
	oReport:FatLine()
    oReport:SkipLine()
	oSection1:Finish()
	
	If Select(__cAlias1) > 0
		(__cAlias1)->(DbCloseArea())
	EndIf
	
	RestArea(_aArea	 )
	RestArea(_aAreAC9)
	
Return(.T.)


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABR289C  ºAutor  ³Anderson Rangel     º Data ³  JULHO/2021 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Rotina responsavel pela geração das perguntas no relatório  º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CABERJ                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function CABR289C(cGrpPerg)
	
	Local aHelpPor := {} //help da pergunta
	
	aHelpPor := {}
	AADD(aHelpPor,"Informe a empresa 				")
	AADD(aHelpPor,"Branco para todos				")
	
	u_CABASX1(cGrpPerg,"01","Empresa De: ?"			,"a","a","MV_CH1"	,"C",TamSX3("BA6_CODIGO")[1]	,0,0,"G","","BJLPLS","","","MV_PAR01","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")
	u_CABASX1(cGrpPerg,"02","Empresa Ate:?"			,"a","a","MV_CH2"	,"C",TamSX3("BA6_CODIGO")[1]	,0,0,"G","","BJLPLS","","","MV_PAR02","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")
	
	aHelpPor := {}
	AADD(aHelpPor,"Informe o Contrato		  		")
	AADD(aHelpPor,"Branco para todos		  		")
	
	u_CABASX1(cGrpPerg,"03","Contrato De: ?"		,"a","a","MV_CH3"	,"C",TamSX3("BA6_NUMCON")[1]	,0,0,"G","",""		,"","","MV_PAR03","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")
	u_CABASX1(cGrpPerg,"04","Contrato Ate:?"		,"a","a","MV_CH4"	,"C",TamSX3("BA6_NUMCON")[1]	,0,0,"G","",""		,"","","MV_PAR04","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")
	
	aHelpPor := {}
	AADD(aHelpPor,"Informe o Subcontrato	  		")
	AADD(aHelpPor,"Branco para todos		  		")
	
	u_CABASX1(cGrpPerg,"05","Subcontrato De: ?"		,"a","a","MV_CH5"	,"C",TamSX3("BA6_SUBCON")[1]	,0,0,"G","",""		,"","","MV_PAR05","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")
	u_CABASX1(cGrpPerg,"06","Subcontrato Ate:?"		,"a","a","MV_CH6"	,"C",TamSX3("BA6_SUBCON")[1]	,0,0,"G","",""		,"","","MV_PAR06","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")

    aHelpPor := {}
	AADD(aHelpPor,"Informe o Plano	  		 	    ")
	AADD(aHelpPor,"Branco para todos		  		")
	
	u_CABASX1(cGrpPerg,"07","Plano De: ?"		    ,"a","a","MV_CH7"	,"C",TamSX3("BA6_CODPRO")[1]	,0,0,"G","","BI3PLS","","","MV_PAR07","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")
	u_CABASX1(cGrpPerg,"08","Plano Ate:?"		    ,"a","a","MV_CH8"	,"C",TamSX3("BA6_CODPRO")[1]	,0,0,"G","","BI3PLS","","","MV_PAR08","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")

    aHelpPor := {}
	AADD(aHelpPor,"Informe a Classe de Carencia		")
	AADD(aHelpPor,"Branco para todos		  		")
	
	u_CABASX1(cGrpPerg,"09","Classe de Carencia: ?"	,"a","a","MV_CH9"	,"C",TamSX3("BA6_CARENC")[1]	,0,0,"G","",""		,"","","MV_PAR09","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")

	aHelpPor := {}
	AADD(aHelpPor,"Informe o Relatório será			")
	AADD(aHelpPor,"Formato Reduzido		  			")
	
	u_CABASX1(cGrpPerg,"10","Formato Reduzido: ?"	,"a","a","MV_CH10"	,"C",3							,0,0,"C","",""		,"","","MV_PAR10","Não","","","","Sim","","","","","","","","","","","",aHelpPor,{},{},"")
	
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABR289D  ºAutor  ³Anderson Rangel     º Data ³  JULHO/2021 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Rotina responsavel por tratar a query, facilitando assim    º±±
±±º          ³a manutenção do fonte.                                      º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CABERJ                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function CABR289D()
	
	Local _cQuery 		:= ""
	
	_cQuery := " SELECT DISTINCT '3' NIVEL,																			" 	+ CRLF
    _cQuery += "        BDL_CODIGO CODIGO,                                                              			" 	+ CRLF
    _cQuery += "        BDL_DESCRI CLASSE,                                                              			" 	+ CRLF
    _cQuery += "        BA6_CARENC CARENCIA,                                                            			" 	+ CRLF
	_cQuery += "        BA6_CAREDU CARENCIA_REDUZ,                                                      			" 	+ CRLF
	_cQuery += "        BA6_XCANBE CARENCIA_NB,                                                         			" 	+ CRLF
	_cQuery += "        BA6_XCABEC CARENCIA_ADV,                                                        			" 	+ CRLF
    _cQuery += "        DECODE(BA6_UNICAR,'1','HORAS','2','DIAS','3','MESES','4','ANOS','5','VIDA') UNIDADE,		"	+ CRLF
    _cQuery += "        DECODE(BA6_XUNNBE,'1','HORAS','2','DIAS','3','MESES','4','ANOS','5','VIDA') UNIDADE_NB, 	" 	+ CRLF
    _cQuery += "        DECODE(BA6_XUNBEC,'1','HORAS','2','DIAS','3','MESES','4','ANOS','5','VIDA') UNIDADE_ADV,	"	+ CRLF
    _cQuery += "        BDL_CODINT OPER,                                                                			" 	+ CRLF
    _cQuery += "        BA6_CODPRO PLANO,                                                               			" 	+ CRLF

    If cEmpAnt == '01'                                                                                          
        
        _cQuery += "        RETORNA_DESCRI_PLANO('C', BA6_CODPRO) DESCR_PLANO,                               " 	+ CRLF

    Else                                                                                                        
        
        _cQuery += "        RETORNA_DESCRI_PLANO('I', BA6_CODPRO) DESCR_PLANO,                               " 	+ CRLF

    EndIf 

    _cQuery += "        BA6_CODIGO EMPRESA,                                                             " 	+ CRLF

    If cEmpAnt == '01'                                                                                          
        
        _cQuery += "        RETORNA_DESCRI_GRUPOEMP('C', BA6_CODIGO) NOME_EMP,                               " 	+ CRLF

    Else                                                                                                        

        _cQuery += "        RETORNA_DESCRI_GRUPOEMP('I', BA6_CODIGO) NOME_EMP,                               " 	+ CRLF

    EndIf 

    _cQuery += "        BA6_NUMCON CONTRATO,                                                            " 	+ CRLF
    _cQuery += "        BA6_SUBCON SUBCONTRATO,                                                         " 	+ CRLF

    If cEmpAnt == '01'                                                                                          

        _cQuery += "        RETORNA_DESC_SUBCONTRATO('C', BA6_CODIGO, BA6_NUMCON, BA6_SUBCON) DESC_SUBCON,	" 	+ CRLF

    Else                                                                                                     

        _cQuery += "        RETORNA_DESC_SUBCONTRATO('I', BA6_CODIGO, BA6_NUMCON, BA6_SUBCON) DESC_SUBCON,	" 	+ CRLF

    EndIf

    _cQuery += "        DECODE(BAT_SEXO,'1','M','2','F','A') SEXO										" 	+ CRLF
    _cQuery += " FROM   " + RetSqlName("BA6") + " BA6 , " + RetSqlName("BDL") + " BDL , 				" 	+ CRLF
    _cQuery += "		" + RetSqlName("BAE") + " BAE , " + RetSqlName("BAT") + " BAT                   " 	+ CRLF
    _cQuery += " WHERE  BA6_FILIAL = ' '                                     							" 	+ CRLF
    _cQuery += " AND	BDL_FILIAL = ' '                                     							" 	+ CRLF
    _cQuery += " AND	BAE_FILIAL = ' '                                     							" 	+ CRLF
    _cQuery += " AND	BAT_FILIAL = ' '                                     							" 	+ CRLF
    _cQuery += " AND    BA6_CLACAR = BAE_CLACAR                                                         " 	+ CRLF
    _cQuery += " AND    BA6_FILIAL = BDL_FILIAL                                                         " 	+ CRLF
    _cQuery += " AND    BA6_CLACAR = BDL_CODIGO                                                         " 	+ CRLF
    _cQuery += " AND    BAT_FILIAL = BAE_FILIAL                                                         " 	+ CRLF
    _cQuery += " AND    BAT_CODIGO = BAE_CODGRU                                                         " 	+ CRLF
    _cQuery += " AND    BAE_CODIGO = BA6_CODINT||BA6_CODPRO                                             " 	+ CRLF
    _cQuery += " AND    BA6.D_E_L_E_T_ = ' '                                                            " 	+ CRLF
    _cQuery += " AND    BDL.D_E_L_E_T_ = ' '                                                            " 	+ CRLF
    _cQuery += " AND    BAE.D_E_L_E_T_ = ' '                                                            " 	+ CRLF
    _cQuery += " AND    BAT.D_E_L_E_T_ = ' '                                                            " 	+ CRLF

    If !empty(MV_PAR01)
    
    _cQuery += " AND BA6_CODIGO BETWEEN '"+ MV_PAR01 +"' AND '"+ MV_PAR02 +"'                            " 	+ CRLF

    EndIf

    If !empty(MV_PAR03)
        
        _cQuery += " AND BA6_NUMCON BETWEEN '"+ MV_PAR03 +"' AND '"+ MV_PAR04 +"'                               " 	+ CRLF

    EndIf

    If !empty(MV_PAR05)
        
        _cQuery += " AND BA6_SUBCON BETWEEN '"+ MV_PAR05 +"' AND '"+ MV_PAR06 +"'                               " 	+ CRLF

    EndIf

    If !empty(MV_PAR07)
        
        _cQuery += " AND BA6_CODPRO BETWEEN '"+ MV_PAR07 +"' AND '"+ MV_PAR08 +"'                               " 	+ CRLF

    EndIf

    If !empty(MV_PAR09)
        
        _cQuery += " AND BA6_CARENC = '"+ MV_PAR09 +"'					                               " 	+ CRLF

    EndIf

    _cQuery += " ORDER BY BA6_CODIGO,BA6_CODPRO,BA6_NUMCON,BA6_SUBCON,BDL_CODIGO                        " 	+ CRLF
	
	//memowrite("C:\temp\CABR289.sql",_cQuery)
	
Return _cQuery


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABR289E  ºAutor  ³Anderson Rangel     º Data ³  JULHO/2021 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Rotina responsavel por gerar o relatório em CSV, pois       º±±
±±º          ³alguns usuários não possuem o Excel.                        º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CABERJ                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function CABR289E()
	
	Local _aArea 	:= GetArea()
	Local _cQuery	:= ""
	Local nHandle 	:= 0
	Local cNomeArq	:= ""
	Local cMontaTxt	:= ""
	
	Private _cAlias2	:= GetNextAlias()
	
	ProcRegua(RecCount())
	
	cNomeArq := "C:\TEMP\RELATORIO_CLASSE_CARENCIA"
	cNomeArq += "_" + SUBSTR(DTOS(DATE()),7,2)
	cNomeArq += "_" + SUBSTR(DTOS(DATE()),5,2)
	cNomeArq += "_" + SUBSTR(DTOS(DATE()),1,4)
	cNomeArq += "_" + STRTRAN(TIME(),":","_") + ".csv"
	
	//---------------------------------------------
	//CABR289D Realiza toda a montagem da query
	//facilitando a manutenção do fonte
	//---------------------------------------------
	_cQuery := CABR289D()
	
	If Select(_cAlias2) > 0
		(_cAlias2)->(DbCloseArea())
	EndIf
	
	DbUseArea(.T.,"TOPCONN",TcGenQry(,,_cQuery),_cAlias2,.T.,.T.)
	
	While !(_cAlias2)->(EOF())
		
		IncProc()
		
		//------------------------------------------------------------------
		//Se for a primeira vez, deve ser criado o arquivo e o cabeçalho
		//------------------------------------------------------------------
		If nHandle = 0
			
			//------------------------------------------------------------------
			// criar arquivo texto vazio a partir do root path no servidor
			//------------------------------------------------------------------
			nHandle := FCREATE(cNomeArq)
			
			If nHandle > 0
				
				cMontaTxt := "NIVEL ; "
				cMontaTxt += "CODIGO ; "
				cMontaTxt += "CLASSE ; "
				cMontaTxt += "CARENCIA ; "
				cMontaTxt += "UNIDADE ; "
				cMontaTxt += "CARENCIA_NB ; "
				cMontaTxt += "UNIDADE_NB ; "
				cMontaTxt += "CARENCIA ADVINDOS CONC. ; "
				cMontaTxt += "UNIDADE ADV_CONC. ; "
				cMontaTxt += "CARENCIA_REDUZ ; "
				cMontaTxt += "OPER ; "
				cMontaTxt += "PLANO ; "
				cMontaTxt += "DESCR_PLANO ; "
				cMontaTxt += "EMPRESA ; "
				cMontaTxt += "NOME_EMP ; "
				cMontaTxt += "CONTRATO ; "
                cMontaTxt += "SUBCONTRATO ; "
                cMontaTxt += "DESC_SUBCON ; "
                cMontaTxt += "SEXO ; "
				
				cMontaTxt += CRLF // Salto de linha para .csv (excel)
				
				FWrite(nHandle,cMontaTxt)
				
			Else
				
				Aviso("Atenção","Não foi possível criar o relatório",{"OK"})
				Exit
				
			EndIf
			
		EndIf
		
		cMontaTxt := "'" + AllTrim((_cAlias2)->NIVEL		  ) + ";"
		cMontaTxt += "'" + AllTrim((_cAlias2)->CODIGO		  ) + ";"
		cMontaTxt += "'" + AllTrim((_cAlias2)->CLASSE		  ) + ";"
		cMontaTxt += "'" + AllTrim((_cAlias2)->CARENCIA		  ) + ";"
		cMontaTxt += "'" + AllTrim((_cAlias2)->UNIDADE	      ) + ";"
		cMontaTxt += "'" + AllTrim((_cAlias2)->CARENCIA_NB	  ) + ";"
		cMontaTxt += "'" + AllTrim((_cAlias2)->UNIDADE_NB     ) + ";"
		cMontaTxt += "'" + AllTrim((_cAlias2)->CARENCIA_ADV	  ) + ";"
		cMontaTxt += "'" + AllTrim((_cAlias2)->UNIDADE_ADV    ) + ";"
		cMontaTxt += "'" + AllTrim((_cAlias2)->CARENCIA_REDUZ ) + ";"
		cMontaTxt += "'" + AllTrim((_cAlias2)->OPER	          ) + ";"
		cMontaTxt += "'" + AllTrim((_cAlias2)->PLANO    	  ) + ";"
		cMontaTxt += "'" + AllTrim((_cAlias2)->DESCR_PLANO	  ) + ";"
		cMontaTxt += "'" + AllTrim((_cAlias2)->EMPRESA		  ) + ";"
		cMontaTxt += "'" + AllTrim((_cAlias2)->NOME_EMP	      ) + ";"
        cMontaTxt += "'" + AllTrim((_cAlias2)->CONTRATO		  ) + ";"
		cMontaTxt += "'" + AllTrim((_cAlias2)->SUBCONTRATO	  ) + ";"
		cMontaTxt += "'" + AllTrim((_cAlias2)->DESC_SUBCON	  ) + ";"
		cMontaTxt += "'" + AllTrim((_cAlias2)->SEXO			  ) + ";"
		
		cMontaTxt += CRLF // Salto de linha para .csv (excel)
		
		FWrite(nHandle,cMontaTxt)
		
		(_cAlias2)->(DbSkip())
		
	EndDo
	
	If Select(_cAlias2) > 0
		(_cAlias2)->(DbCloseArea())
	EndIf
	
	If nHandle > 0
		
		// encerra gravação no arquivo
		FClose(nHandle)
		
		MsgAlert("Relatorio salvo em: "+ cNomeArq)
		
	EndIf
	
	RestArea(_aArea)
	
Return
