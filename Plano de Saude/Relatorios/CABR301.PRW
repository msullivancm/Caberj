#INCLUDE 'TOTVS.CH'
#INCLUDE "TOPCONN.CH" 
#Include "MSGRAPHI.CH"
#Include "FILEIO.CH"
#DEFINE CRLF Chr(13)+Chr(10)

/*/{Protheus.doc} CABR301
description
@type function
@version  1.0.0
@author Marcos Cantalice - 7 Consulting
@since 04/04/2022
@return variant, return_description
/*/
USER FUNCTION CABR301()

Local oReport
Local aArea := GetArea()
Private cPerg  := "CABR301"

AjustaSX1_2(cPerg)

IF !Pergunte(cPerg, .T.)
	Return
Endif

oReport:= ReportH()
oReport:PrintDialog()

RestArea(aArea)

RETURN

Static Function ReportH()
                                      
Local oSection1
Local oReport
Local aAreaSM0  := SM0->(GetArea())   
Local cTit := "Relatório de Coparticipação a Nível do Produto"
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
oReport:SetLandScape(.T.)
oReport:SetTotalInLine(.T.)


Pergunte(oReport:uParam,.F.)

		 
		oSection1 := TRSection():New(oReport,"Relatório de Coparticipação a Nível do Produto") 

		// Colunas do relatorio
		TRCell():New(oSection1,"" ,,"CODIGO"  				, ""	,8	   ,.F.,{|| (cAliasBOL)->COD}  				,"LEFT"  ,.T. ,"LEFT" )
		TRCell():New(oSection1,"" ,,"PRODUTO"  				, ""	,30	   ,.F.,{|| (cAliasBOL)->PRODUTO}  			,"LEFT"  ,.T. ,"LEFT" )
		TRCell():New(oSection1,"" ,,"GRUPO"  	    		, ""	,65	   ,.F.,{|| (cAliasBOL)->DESCRIGRUPO}  		,"LEFT"  ,.T. ,"LEFT" )
		TRCell():New(oSection1,"" ,,"REG. ATENDIMENTO"  	, ""	,25	   ,.F.,{|| (cAliasBOL)->REG_ATENDIMENTO}  	,"LEFT"  ,.T. ,"LEFT" )
		TRCell():New(oSection1,"" ,,"QTD ATÉ"  				, ""	,10	   ,.F.,{|| (cAliasBOL)->QTD_ATE}  			,"LEFT"  ,.T. ,"LEFT" )
		TRCell():New(oSection1,"" ,,"% COPART"  			, ""	,10	   ,.F.,{|| (cAliasBOL)->PORC_COPART}  		,"RIGHT"  ,.T. ,"LEFT" )
		TRCell():New(oSection1,"" ,,"VALOR COPART"  		, ""	,20	   ,.F.,{|| (cAliasBOL)->VALOR_COPART}  	,"LEFT"  ,.T. ,"LEFT" )
		TRCell():New(oSection1,"" ,,"TAXA ADM"  			, ""	,20	   ,.F.,{|| (cAliasBOL)->TAXA_ADM}  		,"LEFT"  ,.T. ,"LEFT" )
		TRCell():New(oSection1,"" ,,"VALOR FRANQ"  			, ""	,15	   ,.F.,{|| (cAliasBOL)->VALOR_FRANQ}  		,"LEFT"  ,.T. ,"LEFT" )
		TRCell():New(oSection1,"" ,,"SOMENTE COMPRA"  		, ""	,25	   ,.F.,{|| (cAliasBOL)->SOMENTE_COMPRA}  	,"LEFT"  ,.T. ,"LEFT" )
		TRCell():New(oSection1,"" ,,"PGTO NO ATO"  			, ""	,20	   ,.F.,{|| (cAliasBOL)->PGT_ATO}  			,"LEFT"  ,.T. ,"LEFT" )
		TRCell():New(oSection1,"" ,,"PGTO NA RDA"  			, ""	,20	   ,.F.,{|| (cAliasBOL)->PGT_RDA}  			,"LEFT"  ,.T. ,"LEFT" )
		TRCell():New(oSection1,"" ,,"SOMENTE PROC"  		, ""	,20	   ,.F.,{|| (cAliasBOL)->SOMENTE_PROC}  	,"LEFT"  ,.T. ,"LEFT" )
		TRCell():New(oSection1,"" ,,"VIGÊNCIA DE"  			, ""	,20	   ,.F.,{|| STOD((cAliasBOL)->VIGENCIA_DE)} ,"LEFT"  ,.T. ,"LEFT" )
		TRCell():New(oSection1,"" ,,"VIGÊNCIA ATÉ"  		, ""	,20	   ,.F.,{|| STOD((cAliasBOL)->VIGENCIA_ATE)},"LEFT"  ,.T. ,"LEFT" )

RestArea( aAreaSM0 )

Return(oReport)

Static Function ReportPrt(oReport)
Local oSection1 
//Local aUser 

Private cAliasBOL  := GetnextAlias()
Private dDatabase    
Private dData
Private aArea1  := {} 


oSection1 := oReport:Section(1)

// Query para buscar os dados no banco

	cQry:="SELECT 																						" + CRLF
	cQry+="BHI_CODPLA COD, BI3_DESCRI PRODUTO,BG7_DESCRI DESCRIGRUPO,									" + CRLF
	cQry+="CASE BHI_TIPO WHEN '1' THEN 'INTERNAÇÃO'														" + CRLF
	cQry+="              WHEN '2' THEN 'AMBULATORIAL'													" + CRLF
	cQry+="              WHEN '3' THEN 'AMBOS'															" + CRLF
	cQry+="              END REG_ATENDIMENTO,															" + CRLF
	cQry+="BHI_QTD QTD_ATE, CONCAT(BHI_PERCOP,'%') PORC_COPART,											" + CRLF
	cQry+="BHI_VLRCOP VALOR_COPART, BHI_TXADM TAXA_ADM, BHI_LIMFRA VALOR_FRANQ,							" + CRLF
	cQry+="CASE BHI_SOMCOM WHEN '0' THEN 'NÃO'															" + CRLF
	cQry+="                WHEN '1' THEN 'SIM' 															" + CRLF
	cQry+="                END SOMENTE_COMPR,															" + CRLF
	cQry+="CASE BHI_PAGATO WHEN '0' THEN 'NÃO'															" + CRLF
	cQry+="                WHEN '1' THEN 'SIM'															" + CRLF
	cQry+="                END PGT_ATO,																	" + CRLF
	cQry+="CASE BHI_PAGRDA WHEN '0' THEN 'NÃO'															" + CRLF
	cQry+="                WHEN '1' THEN 'SIM'															" + CRLF
	cQry+="                END PGT_RDA,																	" + CRLF
	cQry+="CASE BHI_SOMPRO WHEN '0' THEN 'NÃO'															" + CRLF
	cQry+="                WHEN '1' THEN 'SIM'															" + CRLF
	cQry+="                END SOMENTE_PROC,															" + CRLF
	cQry+="TRIM(BHI_VIGDE) VIGENCIA_DE, TRIM(BHI_VIGATE) VIGENCIA_ATE									" + CRLF
	cQry+="FROM "+RetSqlName("BHI")+" BHI, "+RetSqlName("BI3")+" BI3 , "+RetSqlName("BG7")+" BG7		" + CRLF
	cQry+="WHERE BHI.D_E_L_E_T_=' '																		" + CRLF
	cQry+="AND   BI3.D_E_L_E_T_=' '																		" + CRLF
	cQry+="AND   BG7.D_E_L_E_T_=' '																		" + CRLF
	cQry+="AND   BHI_CODPLA=BI3_CODIGO																	" + CRLF
	cQry+="AND   BHI_CODGRU=BG7_CODGRU																	" + CRLF
	IF  !EMPTY(MV_PAR01)
		cQry+="AND BHI_CODPLA = '"+MV_PAR01+"'															" + CRLF
	ENDIF
	IF  !EMPTY(MV_PAR02)
		cQry+="AND BI3_DESCRI LIKE '%"+ALLTRIM(MV_PAR02)+"%'											" + CRLF
	ENDIF
	IF  MV_PAR03 = 1 //ABERTA
		cQry+="AND TRIM(BHI_VIGATE) >= '"+DTOS(Date())+"'													" + CRLF
		ELSEIF MV_PAR03 = 2 //FECHADA
		cQry+="AND TRIM(BHI_VIGATE) < '"+DTOS(Date())+"'													" + CRLF
	ENDIF
	cQry+="ORDER BY BHI_CODPLA 																			" + CRLF

cQry    := ChangeQuery(cQry)
dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQry),cAliasBOL,.T.,.T.)


dbSelectArea(cAliasBOL)
(cAliasBOL)->(dbgotop())	

oReport:SetMeter((cAliasBOL)->(LastRec()))	  

//Imprime os dados do relatorio
If (cAliasBOL)->(Eof())
	Alert("Nao foram encontrados dados!")
Else

	oSection1:Init()

	While  !(cAliasBOL)->(Eof())       
		
		oReport:IncMeter()
		oSection1:PrintLine()
		
		(cAliasBOL)->(DbSkip())

	Enddo   
		
	oReport:FatLine()
	oReport:Section(1):Finish()

	(cAliasBOL)->(DbCloseArea())

EndIf

Return

Static Function AjustaSX1_2(cPerg)

Local aHelpPor	:= {} 


aHelpPor := {}
AADD(aHelpPor,"Informe qual especialidade deseja exibir:			")

 u_CABASX1(cPerg,"01","Cód Produto:"	        ,"","",	"MV_CH1" ,"C",4  	                    ,0,0,"G","","",	"","","MV_PAR01","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")		
 u_CABASX1(cPerg,"02","Nome Produto"			,"","", "MV_CH2" ,"C",20						,0,0,"G","","", "","","MV_PAR02","",,,,"")
 u_CABASX1(cPerg,"03","Vigência"				,"","a","MV_CH1" ,"C",1                        	,0,0,"C","","", "","","MV_PAR03","1 - Aberta","1 - Aberta","1 - Aberta","","2 - Fechada","2 - Fechada","2 - Fechada","3 - Todas","3 - Todas","3 - Todas","","","","","","",aHelpPor,{},{},"")	
Return()

