#INCLUDE 'TOTVS.CH'
#INCLUDE "TOPCONN.CH" 
#Include "MSGRAPHI.CH"
#Include "FILEIO.CH"
#DEFINE CRLF Chr(13)+Chr(10)

/*/{Protheus.doc} CABR295
RELATORIO SUBCONTRATO - REAJUSTE E VENCIMENTO 
@type function
@version 1.0.0
@author Marcos Cantalice - 7 Consulting
@since 11/02/2022
@return variant, return_description
/*/
USER FUNCTION CABR295()

Local oReport
Local aArea := GetArea()
Private cPerg  := "CABR295"

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
Local cTit := "Relatorio de Subcontrato - Reajuste e Vencimento"
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
cDesl:= "Este relatorio tem como objetivo imprimir o reajuste e o vencimento dos subcontratos."
oReport:= TReport():New(cPerg,cTit,cPerg, {|oReport| ReportPrt(oReport)},cDescRel)
oReport:SetLandScape(.T.)
oReport:SetTotalInLine(.T.)


Pergunte(oReport:uParam,.F.)

		 
		oSection2 := TRSection():New(oReport,"SubContratos",{"BQC", "BT5"}) 

		// Colunas do relatÃ³rio
		TRCell():New(oSection2,"BQC_CODIGO"    ,,"Empresa"  	        		, ""	,11	   ,.F.,{|| (cAliasBOL)->EMPRESA}        ,"LEFT"  ,.T. ,"LEFT" )
		TRCell():New(oSection2,"BQC_NUMCON"    ,,"Contrato"  	            	, ""	,22	   ,.F.,{|| (cAliasBOL)->CONTRATO}       ,"LEFT"  ,.T. ,"LEFT" )
		TRCell():New(oSection2,"BQC_SUBCON"	   ,,"Sub"  		            	, ""	,15	   ,.F.,{|| (cAliasBOL)->SUBCONTRATO }   ,"LEFT"  ,.T. ,"LEFT" )
		TRCell():New(oSection2,"BQC_COBNIV"	   ,,"Cb.Sub"  	        	    	, ""	,7	   ,.F.,{|| (cAliasBOL)->CBNESTNIVEL }   ,"LEFT"  ,.T. ,"LEFT" )
		TRCell():New(oSection2,"BT5_COBNIV"    ,,"Cb.Cont"			            , ""	,10	   ,.F.,{|| (cAliasBOL)->BT5_COBNIV }    ,"LEFT"  ,.T. ,"LEFT" )  
		TRCell():New(oSection2,"BQC_CODCLI"	   ,,"Cod Cliente" 			    	, ""	,17	   ,.F.,{|| (cAliasBOL)->CLIENTE }       ,"LEFT"  ,.T. ,"LEFT" )
		TRCell():New(oSection2,"BQC_VENCTO"    ,,"Dt.Venc."			            , ""	,20	   ,.F.,{|| (cAliasBOL)->VENCIMENTO }    ,"LEFT"  ,.T. ,"LEFT" )  	
		TRCell():New(oSection2,"BQC_MESREA"    ,,"Mes reajuste"			        , ""	,23	   ,.F.,{|| (cAliasBOL)->REAJUSTE }      ,"LEFT"  ,.T. ,"LEFT" )  	
		TRCell():New(oSection2,"BQC_DATCON"    ,,"Dt sub-cont"			        , ""	,14	   ,.F.,{|| (cAliasBOL)->DATASUBCONT }   ,"LEFT"  ,.T. ,"LEFT" )  	
		TRCell():New(oSection2,"BQC_DESCRI"    ,,"Id.Sub-Cont"			        , ""	,40	   ,.F.,{|| (cAliasBOL)->BQC_DESCRI }    ,"LEFT"  ,.T. ,"LEFT" )  	
		TRCell():New(oSection2,"BQC_CNPJ"      ,,"CNPJ"			                , ""	,25	   ,.F.,{|| (cAliasBOL)->BQC_CNPJ }      ,"LEFT"  ,.T. ,"LEFT" )  	
		TRCell():New(oSection2,"BQC_YODONT"    ,,"Gera NF COPA"			        , ""	,3	   ,.F.,{|| (cAliasBOL)->BQC_YODONT }    ,"LEFT"  ,.T. ,"LEFT" )  	
		TRCell():New(oSection2,"BQC_GRPCOB"    ,,"Grupo de cobrança"			, ""	,5	   ,.F.,{|| (cAliasBOL)->BQC_GRPCOB }    ,"LEFT"  ,.T. ,"LEFT" )  	
		TRCell():New(oSection2,""              ,,"Suspensao imediata?"			, ""	,8     ,.F.,                                 ,"LEFT"  ,.T. ,"LEFT" )  	
		TRCell():New(oSection2,""              ,,"Caracteristica do vencimento"	, ""	,4	   ,.F.,                                 ,"LEFT"  ,.T. ,"LEFT" )  	
		TRCell():New(oSection2,"BT5_TIPCON"    ,,"Tipo de contrato"			    , ""	,20	   ,.F.,{|| (cAliasBOL)->BT5_TIPCON }    ,"LEFT"  ,.T. ,"LEFT" )  	
		TRCell():New(oSection2,"BT5_DATCON"    ,,"Dt.Contrato"			        , ""	,14	   ,.F.,{|| (cAliasBOL)->BT5_DATCON }    ,"LEFT"  ,.T. ,"LEFT" )  	
		TRCell():New(oSection2,"BT5_YDESCR"    ,,"Nome Contrato"			    , ""	,20	   ,.F.,{|| (cAliasBOL)->BT5_YDESCR }    ,"LEFT"  ,.T. ,"LEFT" )  	
		TRCell():New(oSection2,"BQC_DATBLO"    ,,"Data Bloq."			        , ""	,	   ,.F.,{|| (cAliasBOL)->DATABLO }  	 ,"LEFT"  ,.T. ,"LEFT" )  
		TRCell():New(oSection2,"BQC_CODBLO"    ,,"Cod. Bloq"		            , ""	,	   ,.F.,{|| (cAliasBOL)->BQC_CODBLO }    ,"LEFT"  ,.T. ,"LEFT" )  
		TRCell():New(oSection2,"BQC_YSTSCO"    ,,"Situação do Contrato"         , ""	,	   ,.F.,{|| (cAliasBOL)->SIT_CONTRATO }  ,"LEFT"  ,.T. ,"LEFT" )  
		TRCell():New(oSection2,"BT5_YNATUR"    ,,"Natureza do Contrato"         , ""	,	   ,.F.,{|| (cAliasBOL)->NAT_CONT }  	 ,"LEFT"  ,.T. ,"LEFT" )  
		TRCell():New(oSection2,"BG9_YTPEMP"    ,,"Tipo Empresa"	        		, ""	,11	   ,.F.,{|| (cAliasBOL)->TIPO_EMP}        ,"LEFT"  ,.T. ,"LEFT" )

		//TRFunction():New(oSection2:Cell("BQC_SUBCON"),/*"oTotal"*/ ,"COUNT", /*oBreak */,"Total de Registros",/*[ cPicture ]*/,/*[ uFormula ]*/,,.F.)	
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


	cQry:=" SELECT 																												" + CRLF
	cQry+="		SUBSTR(BQC_CODIGO, 5,4) AS EMPRESA, DECODE(BG9_YTPEMP, '1','Emp. Contratante','2','Administradora') AS TIPO_EMP," + CRLF
	cQry+= " BQC_NUMCON AS CONTRATO, BQC_SUBCON AS SUBCONTRATO, 																" + CRLF
	cQry+=" 	DECODE (BQC_YSTSCO,'01','ART.30','02','ART.31','03','AMBOS','04','JUDICIAL','05','AGREGADO',					" + CRLF
	cQry+=" 			BQC_YSTSCO) SIT_CONTRATO,																				" + CRLF
	cQry+="		CASE BQC_COBNIV WHEN '1' THEN 'SIM' ELSE 'NAO' END AS CBNESTNIVEL, BQC_CODCLI AS CLIENTE,						" + CRLF
	cQry+="		BQC_VENCTO AS VENCIMENTO, BQC_MESREA AS REAJUSTE, TO_DATE(BQC_DATCON,'YYYY/MM/DD') DATASUBCONT,					" + CRLF
	cQry+="		BQC_DESCRI, BQC_CNPJ, BQC_YODONT, BQC_GRPCOB, 																	" + CRLF
	cQry+="		CASE BT5_TIPCON WHEN '1' THEN 'INDIVIDUAL' WHEN '2' THEN 'FAMILIAR' WHEN '3' THEN 'COLETIVO POR ADESAO'			" + CRLF
	cQry+="			WHEN '4' THEN 'COLETIVO EMPRESARIAL' END BT5_TIPCON, TO_DATE(BT5_DATCON,'YYYY/MM/DD') BT5_DATCON,			" + CRLF
	cQry+="		BT5_YDESCR, CASE BT5_COBNIV WHEN '1' THEN 'SIM' ELSE 'NAO' END AS BT5_COBNIV,									" + CRLF
	cQry+="		TO_DATE(TRIM(BQC_DATBLO), 'YYYY/MM/DD') DATABLO , BQC_CODBLO,													" + CRLF
	cQry+="		DECODE(BT5_YNATUR, '1', 'Saude', '2', 'Dental') NAT_CONT														" + CRLF
	cQry+="	FROM "+RetSqlName("BQC")+" BQC 																						" + CRLF
	cQry+="	INNER JOIN "+RetSqlName("BT5")+" BT5 																				" + CRLF
	cQry+="    ON BQC_FILIAL = BT5_FILIAL AND BQC_CODIGO = CONCAT(BT5_CODINT,BT5_CODIGO) 										" + CRLF
	cQry+="    			AND BQC_NUMCON = BT5_NUMCON AND BQC_VERCON = BT5_VERSAO 												" + CRLF
	cQry+="	INNER JOIN "+RetSqlName("BG9")+" BG9 																				" + CRLF
	cQry+="    ON BQC_FILIAL = BG9_FILIAL AND BQC_CODEMP = BG9_CODIGO 															" + CRLF
	cQry+="    			AND BQC_CODINT = BG9_CODINT AND BG9.D_E_L_E_T_ = ' '													" + CRLF
	cQry+=" WHERE BQC.D_E_L_E_T_ = ' ' 																							" + CRLF
	cQry+=" AND BT5.D_E_L_E_T_ = ' ' 																							" + CRLF

    IF !EMPTY(MV_PAR01)
        cQry+=" AND BQC_CODEMP >= '"+MV_PAR01+"'																			" + CRLF
    ENDIF
    IF !EMPTY(MV_PAR02)
	    cQry+=" AND BQC_CODEMP <= '"+MV_PAR02+"'																			" + CRLF
    ENDIF
    IF !EMPTY(MV_PAR03)
        cQry+=" AND BQC_NUMCON >= '"+MV_PAR03+"'																			" + CRLF
    ENDIF
    IF !EMPTY(MV_PAR04)
	    cQry+=" AND BQC_NUMCON <= '"+MV_PAR04+"'																			" + CRLF
    ENDIF
    IF !EMPTY(MV_PAR05)
        cQry+=" AND BQC_SUBCON >= '"+MV_PAR05+"'																			" + CRLF
    ENDIF
    IF !EMPTY(MV_PAR06)
	    cQry+=" AND BQC_SUBCON <= '"+MV_PAR06+"'																			" + CRLF
    ENDIF
    IF !EMPTY(MV_PAR07)
        cQry+=" AND BQC_MESREA >= '"+MV_PAR07+"'																			" + CRLF
    ENDIF
    IF !EMPTY(MV_PAR08)
	    cQry+=" AND BQC_MESREA <= '"+MV_PAR08+"'																			" + CRLF
    ENDIF
    IF !EMPTY(MV_PAR09)
        cQry+=" AND BQC_VENCTO >= '"+MV_PAR09+"'																			" + CRLF
    ENDIF
    IF !EMPTY(MV_PAR10)
	    cQry+=" AND BQC_VENCTO <= '"+MV_PAR10+"'																			" + CRLF
    ENDIF    
    cQry+="ORDER BY EMPRESA																									" + CRLF

cQry    := ChangeQuery(cQry)
dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQry),cAliasBOL,.T.,.T.)

dbSelectArea(cAliasBOL)
(cAliasBOL)->(dbgotop())	

oReport:SetMeter((cAliasBOL)->(LastRec()))	  

//Imprime os dados do relatorio
If (cAliasBOL)->(Eof())
	Alert("NÃ£o foram encontrados dados!")
Else

	oSection2:Init()

	While  !(cAliasBOL)->(Eof())       
			
		oReport:IncMeter()
		oSection2:PrintLine()
			
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
AADD(aHelpPor,"Informe o tipo de produto que deseja exibir:			")

 u_CABASX1(cPerg,"01","Grupo Empresa de:"	 ,"","",	"MV_CH1" ,"C",TAMSX3("BQC_CODEMP")[1]  	,0,0,"G","","",	"","","MV_PAR01","","","","","","","","","","","","","","","","",{},{},{})	
 u_CABASX1(cPerg,"02","Grupo Empresa ate:" 	 ,"","",	"MV_CH2" ,"C",TAMSX3("BQC_CODEMP")[1]	,0,0,"G","","",	"","","MV_PAR02","","","","","","","","","","","","","","","","",{},{},{})
 u_CABASX1(cPerg,"03","Contrato de:" 		 ,"","",	"MV_CH3" ,"C",TAMSX3("BQC_NUMCON")[1]	,0,0,"G","","",	"","","MV_PAR03","","","","","","","","","","","","","","","","",{},{},{})
 u_CABASX1(cPerg,"04","Contrato ate:" 	     ,"","",	"MV_CH4" ,"C",TAMSX3("BQC_NUMCON")[1]	,0,0,"G","","",	"","","MV_PAR04","","","","","","","","","","","","","","","","",{},{},{})
 u_CABASX1(cPerg,"05","Subcontrato de:" 	 ,"","",	"MV_CH5" ,"C",TAMSX3("BQC_SUBCON")[1]	,0,0,"G","","",	"","","MV_PAR05","","","","","","","","","","","","","","","","",{},{},{})
 u_CABASX1(cPerg,"06","Subcontrato ate:"     ,"","",	"MV_CH6" ,"C",TAMSX3("BQC_SUBCON")[1]	,0,0,"G","","",	"","","MV_PAR06","","","","","","","","","","","","","","","","",{},{},{})
 u_CABASX1(cPerg,"07","Mes de reajuste de:"  ,"","",	"MV_CH7" ,"C",TAMSX3("BQC_MESREA")[1]	,0,0,"G","","",	"","","MV_PAR07","","","","","","","","","","","","","","","","",{},{},{})
 u_CABASX1(cPerg,"08","Mes de reajuste ate:" ,"","",	"MV_CH8" ,"C",TAMSX3("BQC_MESREA")[1]	,0,0,"G","","",	"","","MV_PAR08","","","","","","","","","","","","","","","","",{},{},{})
 u_CABASX1(cPerg,"09","Vencimento de:" 	     ,"","",	"MV_CH9" ,"C",TAMSX3("BQC_VENCTO")[1]	,0,0,"G","","",	"","","MV_PAR09","","","","","","","","","","","","","","","","",{},{},{})
 u_CABASX1(cPerg,"10","Vencimento ate:" 	 ,"","",	"MV_CH10","C",TAMSX3("BQC_VENCTO")[1]	,0,0,"G","","",	"","","MV_PAR10","","","","","","","","","","","","","","","","",{},{},{})

Return()
