#INCLUDE 'TOTVS.CH'
#INCLUDE "TOPCONN.CH" 
#Include "MSGRAPHI.CH"
#Include "FILEIO.CH"
#DEFINE CRLF Chr(13)+Chr(10)

USER FUNCTION CABR014()

Local oReport
Local aArea := GetArea()
Private cPerg  := "CABR014"

AjustaSX1_2(cPerg)

IF !Pergunte(cPerg, .T.)
	Return
Endif

oReport:= ReportH()
oReport:PrintDialog()

RestArea(aArea)

RETURN

Static Function ReportH()
                                      
Local oSection2
Local oReport
Local aAreaSM0  := SM0->(GetArea())   
Local cTit := "Relatório de Cadastro de Usuarios Permitidos"
Public cTabela := ""
Public cCodverba := ""
Public cPeriodo := ""
Public cValor := ""
Private contador := 1

cDesCRel := cTit

//??????????????????????????????????????
//?Criacao do componente de impressao                                     ?
//?oReport():New                                                          ?
//?ExpC1 : Nome do relatorio                                              ?
//?ExpC2 : Titulo                                                         ?
//?ExpC3 : Pergunte                                                       ?
//?ExpB4 : Bloco de codigo que sera executado na confirmacao da impressao ?
//?ExpC5 : Descricao                                                      ?
//??????????????????????????????????????
cDesl:= ""
oReport:= TReport():New(cPerg,cTit,cPerg, {|oReport| ReportPrt(oReport)},cDescRel)
//oReport:SetLandScape(.F.)
oReport:SetTotalInLine(.T.)


Pergunte(oReport:uParam,.F.)

		 
		oSection2 := TRSection():New(oReport,"Usuarios Permitidos",) 

		// Colunas do relatorio
		TRCell():New(oSection2,"GRUPO"			,,"Grupo/Empresa"	   	, ""    ,4	   ,  ,{|| (cAliasBOL)->GRUPO       } ,"LEFT"  ,.T.,"LEFT"  )
		TRCell():New(oSection2,"BT0_NUMCON"		,,"Contrato"	 		, ""    ,12	   ,  ,{|| (cAliasBOL)->BT0_NUMCON  } ,"LEFT"  ,.T.,"LEFT"  )
		TRCell():New(oSection2,"BT0_SUBCON"		,,"Subcontrato"	 		, ""    ,10	   ,  ,{|| (cAliasBOL)->BT0_SUBCON  } ,"LEFT"  ,.T.,"LEFT"  )
		TRCell():New(oSection2,"BI3_DESCRI"		,,"Descri.Produto"		, ""	,60	   ,  ,{|| (cAliasBOL)->BI3_DESCRI  } ,"LEFT"  ,.T.,"LEFT"  )
		TRCell():New(oSection2,"BT0_TIPUSR"		,,"Tipo.Usuario"     	, ""	,1	   ,  ,{|| (cAliasBOL)->BT0_TIPUSR  } ,"RIGHT" ,.T.,"RIGHT" )
		TRCell():New(oSection2,"BT0_GRAUPA"		,,"Grau.Parentesco" 	, ""    ,2	   ,  ,{|| (cAliasBOL)->BT0_GRAUPA  } ,"LEFT"  ,.T.,"LEFT"  )
		TRCell():New(oSection2,"BRP_DESCRI"		,,"Descri.GrauParent"	, ""   	,30	   ,  ,{|| (cAliasBOL)->BRP_DESCRI	} ,"LEFT"  ,.T.,"LEFT"  )
		TRCell():New(oSection2,"BT0_ESTCIV"		,,"Estado.Civil" 	    , ""	,1     ,  ,{|| (cAliasBOL)->BT0_ESTCIV  } ,"LEFT"  ,.T.,"LEFT"  )
		TRCell():New(oSection2,"BRP_SEXO"		,,"Sexo" 	            , ""	,1     ,  ,{|| (cAliasBOL)->BRP_SEXO   	} ,"LEFT"  ,.T.,"LEFT"  )
		TRCell():New(oSection2,"BT0_NMIUSR"		,,"Num.MinimoUsuario"	, ""	,4	   ,  ,{|| (cAliasBOL)->BT0_NMIUSR  } ,"LEFTR" ,.T.,"LEFT"  )
		TRCell():New(oSection2,"BT0_NMAUSR"	    ,,"Num.MaximoUsuario"   , ""	,4	   ,  ,{|| (cAliasBOL)->BT0_NMAUSR	} ,"LEFTR" ,.T.,"LEFT"  )
		TRCell():New(oSection2,"BT0_IDAMIN" 	,,"Idade.Minima"     	, ""	,3	   ,  ,{|| (cAliasBOL)->BT0_IDAMIN	} ,"LEFT"  ,.T.,"LEFT"  )
		TRCell():New(oSection2,"BT0_UNIMIN" 	,,"Unid.IdadeMin"       , ""	,1	   ,  ,{|| (cAliasBOL)->BT0_UNIMIN  } ,"LEFT"  ,.T.,"LEFT"  )
		TRCell():New(oSection2,"BT0_IDAMAX"		,,"Idade.Maxima" 		, ""	,3	   ,  ,{|| (cAliasBOL)->BT0_IDAMAX  } ,"LEFT"  ,.T.,"LEFT"  )
		TRCell():New(oSection2,"BT0_UNIMAX"		,,"Unid.Maxima"  	 	, ""  	,1	   ,  ,{|| (cAliasBOL)->BT0_UNIMAX  } ,"RIGHT" ,.T.,"RIGHT" )
			

RestArea( aAreaSM0 )

Return(oReport)

Static Function ReportPrt(oReport)
//Local oSection1 
Local oSection2 
//Local aUser 

Private cAliasBOL  := GetnextAlias()
Private dDatabase    
Private dData
Private aArea1  := {} 


oSection2 := oReport:Section(1)

// Query para buscar os dados no banco

	cQry :="	SELECT                                                                                                  " + CRLF                                                      				
    cQry +="		BT0_NUMCON, BT0_SUBCON, SUBSTR(BT0_CODIGO,5,4) GRUPO, NVL(BI3_DESCRI,' ') BI3_DESCRI, BT0_TIPUSR,	" + CRLF
	cQry +="		BT0_GRAUPA, NVL(BRP_DESCRI,' ') BRP_DESCRI,                                                         " + CRLF 
    cQry +="		BT0_ESTCIV, NVL(BT0_SEXO,' ') BT0_SEXO, NVL(BRP_SEXO,' ') BRP_SEXO, BT0_NMIUSR,                     " + CRLF 			
    cQry +="		BT0_NMAUSR, BT0_IDAMIN,CASE BT0_UNIMIN WHEN '0' THEN 'DIAS' 										" + CRLF
    cQry +="                                        	WHEN '1' THEN 'MESES' 											" + CRLF
    cQry +="                                        	WHEN '2' THEN 'ANOS' END BT0_UNIMIN, 							" + CRLF
	cQry +="        BT0_IDAMAX, CASE BT0_UNIMAX WHEN '0' THEN 'DIAS' 													" + CRLF
    cQry +="                                    WHEN '1' THEN 'MESES' 													" + CRLF
    cQry +="                                    WHEN '2' THEN 'ANOS' END BT0_UNIMAX                                     " + CRLF
    cQry +="	FROM "+RetSqlName('BT0')+" BT0                                                                      	" + CRLF 					
    cQry +="		INNER JOIN "+RetSqlName('BI3')+" BI3 ON BI3.D_E_L_E_T_=' ' AND BI3_FILIAL = BT0_FILIAL   			" + CRLF                                     
    cQry +=" 			AND BI3.BI3_VERSAO = BT0.BT0_VERSAO AND BI3.BI3_CODIGO = BT0.BT0_CODPRO                         " + CRLF
	cQry +=" 		LEFT JOIN "+RetSqlName('BRP')+" BRP ON BRP.BRP_CODIGO = BT0.BT0_GRAUPA AND BRP.D_E_L_E_T_=' '   	" + CRLF  
	cQry +=" 			AND BRP.BRP_FILIAL = BT0.BT0_FILIAL                                                             " + CRLF 
	cQry +="	WHERE                                                                                                   " + CRLF 
	cQry +="		BT0.D_E_L_E_T_ = ' '                                                                                " + CRLF 
	IF !EMPTY(MV_PAR01)
    	cQry +="		AND SUBSTR(BT0_CODIGO,5,4) >= '"+MV_PAR01+"'													" + CRLF
	ENDIF
	IF !EMPTY(MV_PAR02)
    	cQry +="		AND SUBSTR(BT0_CODIGO,5,4) <= '"+MV_PAR02+"'													" + CRLF
	ENDIF
	IF !EMPTY(MV_PAR03)
    	cQry +=" 		AND BT0_NUMCON >= "+MV_PAR03+"																	" + CRLF
	ENDIF
	IF !EMPTY(MV_PAR04)
    	cQry +=" 		AND BT0_NUMCON <= "+MV_PAR04+"																	" + CRLF
	ENDIF
	IF !EMPTY(MV_PAR05)
    	cQry +="		AND BT0_SUBCON >= '"+MV_PAR05+"'																" + CRLF
	ENDIF
	IF !EMPTY(MV_PAR06)
    	cQry +="		AND BT0_SUBCON <= '"+MV_PAR06+"'																" + CRLF
	ENDIF

cQry    := ChangeQuery(cQry)
dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQry),cAliasBOL,.T.,.T.)


dbSelectArea(cAliasBOL)
(cAliasBOL)->(dbgotop())	

oReport:SetMeter((cAliasBOL)->(LastRec()))	  

//Imprime os dados do relatorio
If (cAliasBOL)->(Eof())
	Alert("Nao foram encontrados dados!")
Else

	oSection2:Init()

	While  !(cAliasBOL)->(Eof())       
		
		oReport:IncMeter()
		oSection2:PrintLine()
		
		(cAliasBOL)->(DbSkip())
	
	Enddo   
		
	//oReport:FatLine()
	oReport:Section(1):Finish()

	(cAliasBOL)->(DbCloseArea())

EndIf

Return

Static Function AjustaSX1_2(cPerg)

Local aHelpPor	:= {} 


aHelpPor := {}
AADD(aHelpPor,"Informe qual especialidade deseja exibir:			")

 	u_CABASX1(cPerg,"01","Grupo Empresa De:"	,""	,"","MV_CH1"	,"C",4 							,0,0,"G","","","","","MV_PAR01","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")
    u_CABASX1(cPerg,"02","Grupo Empresa Ate: "	,""	,"","MV_CH2"	,"C",4 							,0,0,"G","","","","","MV_PAR02","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")
	u_CABASX1(cPerg,"03","Contrato De : "		,""	,"","MV_CH3"	,"C",TamSX3("BT0_NUMCON")[1] 	,0,0,"G","","","","","MV_PAR03","","","","","","","","","","","","","","","","",aHelpPor,{},{},"") 
   	u_CABASX1(cPerg,"04","Contrato Ate: "		,""	,"","MV_CH4"	,"C",TamSX3("BT0_NUMCON")[1] 	,0,0,"G","","","","","MV_PAR04","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")
	u_CABASX1(cPerg,"05","Sub Contr De : "		,""	,"","MV_CH5"	,"C",TamSX3("BT0_SUBCON")[1] 	,0,0,"G","","","","","MV_PAR05","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")
    u_CABASX1(cPerg,"06","Sub Contr Ate: "		,""	,"","MV_CH6"	,"C",TamSX3("BT0_SUBCON")[1] 	,0,0,"G","","","","","MV_PAR06","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")

Return()
