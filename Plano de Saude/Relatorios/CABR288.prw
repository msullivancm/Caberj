#INCLUDE "TOPCONN.CH"
#INCLUDE "RWMAKE.CH"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "TBICONN.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCABR288     บAutor  ณAnderson Rangel   บ Data ณ  JULHO/2021 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRelat๓rio Tabela Sub-Contrato                               บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CABERJ                                                     บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function CABR288()
	
	Local _aArea 	:= GetArea()
	Local oReport	:= Nil
	Private _cPerg	:= "CABR288"
	
	//Cria grupo de perguntas
	CABR288C(_cPerg)
	
	If Pergunte(_cPerg,.T.)
		
		//----------------------------------------------------
		//Validando se existe o Excel instalado na mแquina
		//para nใo dar erro e o usuแrio poder visualizar em
		//outros programas como o LibreOffice
		//----------------------------------------------------
		If ApOleClient("MSExcel")
			
            oReport := CABR288A()
            oReport:PrintDialog()
			
		Else
			
			Processa({||CABR288E()},'Processando...')
			
		EndIf
		
	EndIf
	
	RestArea(_aArea)
	
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCABR288A  บAutor  ณAnderson Rangel     บ Data ณ  JULHO/2021 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRotina que irแ gerar as informa็๕es do relat๓rio            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CABERJ                                                     บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function CABR288A
	
	Local oReport		:= Nil
	Local oSection1 	:= Nil
    Local oSection2 	:= Nil
	
	oReport := TReport():New("CABR288","RELATำRIO TABELA DE SUBCONTRATO",_cPerg,{|oReport| CABR288B(oReport)},"Relat๓rio das Tabelas (Faixa Etแria) por Subcontrato")
	
	oReport:SetLandScape()
    //oReport:SetTotalInLine(.T.)	
	oReport:nLineHeight	:= 30
	oReport:cFontBody	:= "Arial"
    oReport:nFontBody	:= 12 // Define o tamanho da fonte.
    oReport:nLineHeight	:= 50 // Define a altura da linha.
	oReport:nColSpace	:= 1
	oReport:oPage:setPaperSize(12)
	
	//--------------------------------
	//Primeira linha do relat๓rio
	//--------------------------------
	oSection1 := TRSection():New(oReport,"DADOS_INICIAIS","BTN, BQC, BT6")
	
	TRCell():New(oSection1,"CODIGO" 			,"BTN")
	oSection1:Cell("CODIGO"):SetAutoSize(.F.)
	oSection1:Cell("CODIGO"):SetSize(20)

	TRCell():New(oSection1,"CODIGO SUBCONTRATO" ,"BTN")
	oSection1:Cell("CODIGO SUBCONTRATO"):SetAutoSize(.F.)
	oSection1:Cell("CODIGO SUBCONTRATO"):SetSize(35)

	TRCell():New(oSection1,"SUBCONTRATO" 	    ,"BQC")
	oSection1:Cell("SUBCONTRATO"):SetAutoSize(.F.)
	oSection1:Cell("SUBCONTRATO"):SetSize(40)

    TRCell():New(oSection1,"CODIGO PLANO" 	    ,"BT6")
	oSection1:Cell("CODIGO PLANO"):SetAutoSize(.F.)
	oSection1:Cell("CODIGO PLANO"):SetSize(20)

	
    //--------------------------------
	//Segunda linha do relat๓rio
	//--------------------------------
    oSection2 := TRSection():New(oReport,"DETALHES_TABELA","BG9, BTN, BI3")

    TRCell():New(oSection2,"EMPRESA" 			,"BG9")
	oSection2:Cell("EMPRESA"):SetAutoSize(.F.)
	oSection2:Cell("EMPRESA"):SetSize(TAMSX3("BG9_NREDUZ")[1])
	
	TRCell():New(oSection2,"PLANO" 		        ,"BI3")
	oSection2:Cell("PLANO"):SetAutoSize(.F.)
	oSection2:Cell("PLANO"):SetSize(TAMSX3("BI3_NREDUZ")[1])
	
	TRCell():New(oSection2,"FAIXA INICIAL" 		,"BTN")
	oSection2:Cell("FAIXA INICIAL"):SetAutoSize(.F.)
	oSection2:Cell("FAIXA INICIAL"):SetSize(TAMSX3("BTN_IDAINI")[1])
	
	TRCell():New(oSection2,"FAIXA FINAL" 		,"BTN")
	oSection2:Cell("FAIXA FINAL"):SetAutoSize(.F.)
	oSection2:Cell("FAIXA FINAL"):SetSize(TAMSX3("BTN_IDAFIN")[1])

	TRCell():New(oSection2,"VALOR"       		,"BTN")
	oSection2:Cell("VALOR"):SetAutoSize(.F.)
	oSection2:Cell("VALOR"):SetSize(TAMSX3("BTN_VALFAI")[1])
	
	TRCell():New(oSection2,"SEXO" 		    	,"BTN")
	oSection2:Cell("SEXO"):SetAutoSize(.F.)
	oSection2:Cell("SEXO"):SetSize(TAMSX3("BTN_SEXO")[1])
    
    TRFunction():SetEndSection(.T.)

Return oReport

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCABR288B  บAutor  ณAnderson Rangel     บ Data ณ  JULHO/2021 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRotina para montar a query e trazer as informa็๕es no       บฑฑ
ฑฑบ          ณrelat๓rio.                                                  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CABERJ                                                     บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function CABR288B(oReport,_cAlias1)
	
	Local _aArea 		:= GetArea()
	Local _cQuery		:= ""
	Local _aAreAC9 		:= AC9->(GetArea())
    Local cCtrlCODIGO   := " "
	Local cCtrlCODSUB   := " "
	Local cCtrlCODPLA   := " "
	
	Private oSection1 	:= oReport:Section(1)
    Private oSection2 	:= oReport:Section(2)
	Private __cAlias1	:= GetNextAlias()
	
	//---------------------------------------------
	//CABR288D Realiza toda a montagem da query
	//facilitando a manuten็ใo do fonte
	//---------------------------------------------
	_cQuery := CABR288D()
	
	If Select(__cAlias1) > 0
		(__cAlias1)->(DbCloseArea())
	EndIf
	
	DbUseArea(.T.,"TOPCONN",TcGenQry(,,_cQuery),__cAlias1,.T.,.T.)
	
	While !(__cAlias1)->(EOF())
		
		If oReport:Cancel()
			Exit
		EndIf
		
        //Inicia Primeira Se็ใo
		oSection1:Init()
        oSection1:SetHeaderSection(.F.)
		
		//Guarda o Conteudo do campo CODIGO, COD_SUBCONTRATO e CODPLA para comparar no While abaixo. Usado para Quebra de se็ใo           
		cCtrlCODIGO := (__cAlias1)->CODIGO
		cCtrlCODSUB := (__cAlias1)->COD_SUBCONTRATO
		cCtrlCODPLA := (__cAlias1)->CODPLA

        oReport:IncMeter()
        oReport:SkipLine()
        oReport:SkipLine()
        oReport:ThinLine()
 		oSection1:Cell("CODIGO" 	    	):SetValue("CODIGO => "+ (__cAlias1)->CODIGO)
		oSection1:Cell("CODIGO SUBCONTRATO" ):SetValue("CODIGO SUBCONTRATO => "+ (__cAlias1)->COD_SUBCONTRATO )
		oSection1:Cell("SUBCONTRATO"  	    ):SetValue("SUBCONTRATO => "+ (__cAlias1)->DESC_SUBCONTRATO	)
		oSection1:Cell("CODIGO PLANO"     	):SetValue("CODIGO PLANO => "+ (__cAlias1)->CODPLA )
		oSection1:PrintLine()
        oReport:FatLine()
		
        //Inicia Segunda Se็ใo			
		oSection2:Init() 
			
		While (__cAlias1)->CODIGO == cCtrlCODIGO .AND. (__cAlias1)->COD_SUBCONTRATO == cCtrlCODSUB .AND. (__cAlias1)->CODPLA == cCtrlCODPLA 

			oReport:IncMeter()
			oSection2:Cell("EMPRESA"):SetValue((__cAlias1)->EMPRESA) 
			oSection2:Cell("PLANO"):SetValue((__cAlias1)->PLANO)
			oSection2:Cell("FAIXA INICIAL"):SetValue((__cAlias1)->IDADE_INICIAL) 
			oSection2:Cell("FAIXA FINAL"):SetValue((__cAlias1)->IDADE_FINAL)
			oSection2:Cell("VALOR"):SetValue((__cAlias1)->VALOR_FAIXA)            
			oSection2:Cell("SEXO"):SetValue((__cAlias1)->SEXO)
			oSection2:PrintLine()			
			
            (__cAlias1)->(DbSkip())
			
		EndDo
		oReport:ThinLine()
		oSection2:Finish()
		
	EndDo
	oReport:FatLine()
    oReport:SkipLine()
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
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCABR288C  บAutor  ณAnderson Rangel     บ Data ณ  JULHO/2021 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRotina responsavel pela gera็ใo das perguntas no relat๓rio  บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CABERJ                                                     บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function CABR288C(cGrpPerg)
	
	Local aHelpPor := {} //help da pergunta
	
	aHelpPor := {}
	AADD(aHelpPor,"Informe a empresa 				")
	AADD(aHelpPor,"Branco para todos				")
	
	u_CABASX1(cGrpPerg,"01","Empresa De: ?"			,"a","a","MV_CH1"	,"C",TamSX3("BG9_CODIGO")[1]	,0,0,"G","","BJLPLS","","","MV_PAR01",""		,"","","",""			,"","",""		,"","","","","","","","",aHelpPor,{},{},"")
	u_CABASX1(cGrpPerg,"02","Empresa Ate:?"			,"a","a","MV_CH2"	,"C",TamSX3("BG9_CODIGO")[1]	,0,0,"G","","BJLPLS","","","MV_PAR02",""		,"","","",""			,"","",""		,"","","","","","","","",aHelpPor,{},{},"")
	
	aHelpPor := {}
	AADD(aHelpPor,"Informe o Contrato		  		")
	AADD(aHelpPor,"Branco para todos		  		")
	
	u_CABASX1(cGrpPerg,"03","Contrato De: ?"		,"a","a","MV_CH3"	,"C",TamSX3("BTN_NUMCON")[1]	,0,0,"G","",""		,"","","MV_PAR03",""		,"","","",""			,"","",""		,"","","","","","","","",aHelpPor,{},{},"")
	u_CABASX1(cGrpPerg,"04","Contrato Ate:?"		,"a","a","MV_CH4"	,"C",TamSX3("BTN_NUMCON")[1]	,0,0,"G","",""		,"","","MV_PAR04",""		,"","","",""			,"","",""		,"","","","","","","","",aHelpPor,{},{},"")
	
	aHelpPor := {}
	AADD(aHelpPor,"Informe o Subcontrato	  		")
	AADD(aHelpPor,"Branco para todos		  		")
	
	u_CABASX1(cGrpPerg,"05","Subcontrato De: ?"		,"a","a","MV_CH5"	,"C",TamSX3("BTN_SUBCON")[1]	,0,0,"G","",""		,"","","MV_PAR05",""		,"","","",""			,"","",""		,"","","","","","","","",aHelpPor,{},{},"")
	u_CABASX1(cGrpPerg,"06","Subcontrato Ate:?"		,"a","a","MV_CH6"	,"C",TamSX3("BTN_SUBCON")[1]	,0,0,"G","",""		,"","","MV_PAR06",""		,"","","",""			,"","",""		,"","","","","","","","",aHelpPor,{},{},"")
	
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCABR288D  บAutor  ณAnderson Rangel     บ Data ณ  JULHO/2021 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRotina responsavel por tratar a query, facilitando assim    บฑฑ
ฑฑบ          ณa manuten็ใo do fonte.                                      บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CABERJ                                                     บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function CABR288D()
	
	Local _cQuery 		:= ""
	
	_cQuery += " SELECT  DISTINCT                                                                               " 	+ CRLF
    _cQuery += "         BTN_CODIGO CODIGO,                                                                     " 	+ CRLF
                                                                                                                
    If cEmpAnt == '01'                                                                                          
        _cQuery += "      RETORNA_DESCRI_GRUPOEMP ('C', BT6_CODIGO) EMPRESA,                                    " 	+ CRLF
    Else                                                                                                        
        _cQuery += "      RETORNA_DESCRI_GRUPOEMP ('I', BT6_CODIGO) EMPRESA,                                    " 	+ CRLF
    EndIf                                                                                                       
                                                                                                                
    _cQuery += "         BTN_NUMCON COD_CONTRATO,                                                               " 	+ CRLF
    _cQuery += "         BTN_SUBCON COD_SUBCONTRATO,                                                            " 	+ CRLF
    _cQuery += "         TRIM(BQC_DESCRI) DESC_SUBCONTRATO,                                                     " 	+ CRLF
    _cQuery += "         BT6_CODPRO CODPLA,                                                                     " 	+ CRLF
    _cQuery += "         TRIM(BI3_NREDUZ) PLANO,                                                                " 	+ CRLF
    _cQuery += "         BTN_IDAINI IDADE_INICIAL,                                                              " 	+ CRLF
    _cQuery += "         BTN_IDAFIN IDADE_FINAL,                                                                " 	+ CRLF
    _cQuery += "         BTN_VALFAI VALOR_FAIXA,                                                                " 	+ CRLF
    _cQuery += "         DECODE(BTN_SEXO,'1','M','2','F','A') SEXO                                              " 	+ CRLF
    _cQuery += "  FROM  " + RetSqlName("BQC") + " BQC, " + RetSqlName("BT6") + " BT6,                           " 	+ CRLF
    _cQuery += "		" + RetSqlName("BTN") + " BTN, " + RetSqlName("BI3") + " BI3                            " 	+ CRLF
    _cQuery += "  WHERE BQC_FILIAL = ' '                                                                        " 	+ CRLF
    _cQuery += "    AND BT6_FILIAL = ' '                                                                        " 	+ CRLF
    _cQuery += "    AND BTN_FILIAL = ' '                                                                        " 	+ CRLF
    _cQuery += "    AND BI3_FILIAL = ' '                                                                        " 	+ CRLF
    _cQuery += "    AND BTN.D_E_L_E_T_ = ' '                                                                    " 	+ CRLF
    _cQuery += "    AND BQC.D_E_L_E_T_ = ' '                                                                    " 	+ CRLF
    _cQuery += "    AND BT6.D_E_L_E_T_ = ' '                                                                    " 	+ CRLF
    _cQuery += "    AND BI3.D_E_L_E_T_ = ' '                                                                    " 	+ CRLF
    _cQuery += "    AND BT6_CODINT||BT6_CODIGO = BQC_CODIGO                                                     " 	+ CRLF
    _cQuery += "    AND BT6_NUMCON = BQC_NUMCON                                                                 " 	+ CRLF
    _cQuery += "    AND BT6_SUBCON = BQC_SUBCON                                                                 " 	+ CRLF
    _cQuery += "    AND BTN_CODIGO = BT6_CODINT||BT6_CODIGO                                                     " 	+ CRLF
    _cQuery += "    AND BTN_NUMCON = BQC_NUMCON                                                                 " 	+ CRLF
    _cQuery += "    AND BTN_SUBCON = BQC_SUBCON                                                                 " 	+ CRLF
    _cQuery += "    AND BTN_CODPRO = BT6_CODPRO                                                                 " 	+ CRLF
    _cQuery += "    AND BI3_CODINT = BT6_CODINT                                                                 " 	+ CRLF
    _cQuery += "    AND BI3_CODIGO = BT6_CODPRO                                                                 " 	+ CRLF
    
    If !empty(MV_PAR01)

       _cQuery += " AND BT6_CODIGO BETWEEN '"+ MV_PAR01 +"' AND '"+ MV_PAR02 +"'                            " 	+ CRLF
    
    EndIf

    If !empty(MV_PAR03)
        
        _cQuery += " AND BT6_NUMCON BETWEEN '"+ MV_PAR03 +"' AND '"+ MV_PAR04 +"'                               " 	+ CRLF
    
    EndIf

    If !empty(MV_PAR05)
        
        _cQuery += " AND BT6_SUBCON BETWEEN '"+ MV_PAR05 +"' AND '"+ MV_PAR06 +"'                               " 	+ CRLF
    
    EndIf
    
    _cQuery += "    AND (BTN_TABVLD = ' ' OR TO_CHAR(SYSDATE,'YYYYMMDD')<=SUBSTR(BTN_TABVLD,1,6))               " 	+ CRLF
    _cQuery += "    ORDER BY CODIGO, EMPRESA, COD_CONTRATO, COD_SUBCONTRATO, CODPLA, IDADE_INICIAL, IDADE_FINAL " 	+ CRLF
	
	//memowrite("C:\temp\CABR288.sql",_cQuery)
	
Return _cQuery


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCABR288E  บAutor  ณAnderson Rangel     บ Data ณ  JULHO/2021 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRotina responsavel por gerar o relat๓rio em CSV, pois       บฑฑ
ฑฑบ          ณalguns usuแrios nใo possuem o Excel.                        บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CABERJ                                                     บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function CABR288E()
	
	Local _aArea 	:= GetArea()
	Local _cQuery	:= ""
	Local nHandle 	:= 0
	Local cNomeArq	:= ""
	Local cMontaTxt	:= ""
	
	Private _cAlias2	:= GetNextAlias()
	
	ProcRegua(RecCount())
	
	cNomeArq := "C:\TEMP\TABELA_SUBCONTRATO"
	cNomeArq += "_" + SUBSTR(DTOS(DATE()),7,2)
	cNomeArq += "_" + SUBSTR(DTOS(DATE()),5,2)
	cNomeArq += "_" + SUBSTR(DTOS(DATE()),1,4)
	cNomeArq += "_" + STRTRAN(TIME(),":","_") + ".csv"
	
	//---------------------------------------------
	//CABR288D Realiza toda a montagem da query
	//facilitando a manuten็ใo do fonte
	//---------------------------------------------
	_cQuery := CABR288D()
	
	If Select(_cAlias2) > 0
		(_cAlias2)->(DbCloseArea())
	EndIf
	
	DbUseArea(.T.,"TOPCONN",TcGenQry(,,_cQuery),_cAlias2,.T.,.T.)
	
	While !(_cAlias2)->(EOF())
		
		IncProc()
		
		//------------------------------------------------------------------
		//Se for a primeira vez, deve ser criado o arquivo e o cabe็alho
		//------------------------------------------------------------------
		If nHandle = 0
			
			//------------------------------------------------------------------
			// criar arquivo texto vazio a partir do root path no servidor
			//------------------------------------------------------------------
			nHandle := FCREATE(cNomeArq)
			
			If nHandle > 0
				
				cMontaTxt := "CODIGO ; "
				cMontaTxt += "EMPRESA ; "
				cMontaTxt += "COD_CONTRATO ; "
				cMontaTxt += "COD_SUBCONTRATO ; "
				cMontaTxt += "DESC_SUBCONTRATO ; "
				cMontaTxt += "CODPLA ; "
				cMontaTxt += "PLANO ; "
				cMontaTxt += "IDADE_INICIAL ; "
				cMontaTxt += "IDADE_FINAL ; "
				cMontaTxt += "VALOR_FAIXA ; "
				cMontaTxt += "SEXO ; "
				
				cMontaTxt += CRLF // Salto de linha para .csv (excel)
				
				FWrite(nHandle,cMontaTxt)
				
			Else
				
				Aviso("Aten็ใo","Nใo foi possํvel criar o relat๓rio",{"OK"})
				Exit
				
			EndIf
			
		EndIf
		
		cMontaTxt := "'" + AllTrim((_cAlias2)->CODIGO		) + ";"
		cMontaTxt += "'" + AllTrim((_cAlias2)->EMPRESA		) + ";"
		cMontaTxt += "'" + AllTrim((_cAlias2)->COD_CONTRATO		) + ";"
		cMontaTxt += "'" + AllTrim((_cAlias2)->COD_SUBCONTRATO		) + ";"
		cMontaTxt += "'" + AllTrim((_cAlias2)->DESC_SUBCONTRATO	) + ";"
		cMontaTxt += "'" + AllTrim((_cAlias2)->CODPLA	) + ";"
		cMontaTxt += "'" + AllTrim((_cAlias2)->PLANO	) + ";"
		cMontaTxt += "'" + AllTrim((_cAlias2)->IDADE_INICIAL		) + ";"
		cMontaTxt += "'" + AllTrim((_cAlias2)->IDADE_FINAL		) + ";"
		cMontaTxt += "'" + AllTrim((_cAlias2)->VALOR_FAIXA	) + ";"
		cMontaTxt += "'" + AllTrim((_cAlias2)->SEXO			) + ";"
		
		cMontaTxt += CRLF // Salto de linha para .csv (excel)
		
		FWrite(nHandle,cMontaTxt)
		
		(_cAlias2)->(DbSkip())
		
	EndDo
	
	If Select(_cAlias2) > 0
		(_cAlias2)->(DbCloseArea())
	EndIf
	
	If nHandle > 0
		
		// encerra grava็ใo no arquivo
		FClose(nHandle)
		
		MsgAlert("Relatorio salvo em: "+ cNomeArq)
		
	EndIf
	
	RestArea(_aArea)
	
Return
