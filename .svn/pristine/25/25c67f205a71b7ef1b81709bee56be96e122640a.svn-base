#INCLUDE 'TOTVS.CH'
#INCLUDE "TOPCONN.CH" 
#Include "MSGRAPHI.CH"
#Include "FILEIO.CH"
#DEFINE CRLF Chr(13)+Chr(10)

/*/{Protheus.doc} CABR313
description
@type function
@version  1.0.0
@author Marcos Cantalice - 7 Consulting
@since 28/06/2022
@return variant, return_description
/*/
USER FUNCTION CABR313()

Local oReport
Local aArea := GetArea()
Private cPerg  := "CABR313"

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
Local cTit := "Relatório para Cobrança de Carteinha"
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

		 
	oSection2 := TRSection():New(oReport,"Relatório para Cobrança de Carteinha",) 

	// Colunas do relatorio
	TRCell():New(oSection2,"",,"EMPRESA"			, "",15,.F.,{|| (cAliasBOL)->EMPRESA}			,"LEFT",.T.,"LEFT" )
	TRCell():New(oSection2,"",,"MATRICULA"			, "",15,.F.,{|| (cAliasBOL)->MATRICULA}			,"LEFT",.T.,"LEFT" )
	TRCell():New(oSection2,"",,"NOME"				, "",50,.F.,{|| (cAliasBOL)->NOME}				,"LEFT",.T.,"LEFT" )
	TRCell():New(oSection2,"",,"VIA"				, "",10,.F.,{|| (cAliasBOL)->VIA_CART}			,"LEFT",.T.,"LEFT" )
	TRCell():New(oSection2,"",,"MOTIVO"				, "",40,.F.,{|| (cAliasBOL)->MOTIVO}			,"LEFT",.T.,"LEFT" )
	TRCell():New(oSection2,"",,"DATA SOLICITACAO"	, "",10,.F.,{|| (cAliasBOL)->DT_SOLICITACAO}	,"LEFT",.T.,"LEFT" )
	TRCell():New(oSection2,"",,"VALIDADE"			, "",10,.F.,{|| (cAliasBOL)->VALIDADE}			,"LEFT",.T.,"LEFT" )
	TRCell():New(oSection2,"",,"VALOR"				, "",10,.F.,{|| (cAliasBOL)->VALOR}				,"LEFT",.T.,"LEFT" )

RestArea( aAreaSM0 )

Return(oReport)

Static Function ReportPrt(oReport)
Local oSection2 

Private cAliasBOL  := GetnextAlias()
Private dDatabase    
Private dData
Private aArea1  := {} 

oSection2 := oReport:Section(1)

// Query para buscar os dados no banco

	cQry:="SELECT  																															" + CRLF
	cQry+="     BA1_CODEMP EMPRESA, BED_MATRIC MATRICULA, BED_NOMUSR NOME, MAX(BED_VIACAR) VIA_CART,  										" + CRLF
	cQry+="    	CONCAT(BED_MOTIVO,CONCAT(' - ',BPX_DESCRI)) MOTIVO,  																		" + CRLF
	cQry+="    	TO_DATE(BED_DTSOLI, 'YYYYMMDD') DT_SOLICITACAO, TO_DATE(BED_DATVAL, 'YYYYMMDD') VALIDADE,									" + CRLF
	cQry+="    	TRIM(TO_CHAR(BJC_VALOR,'999G999G990D99MI','NLS_NUMERIC_CHARACTERS = '',.'' ')) VALOR 										" + CRLF
	cQry+=" FROM  																															" + CRLF
	cQry+="     "+RETSQLNAME("BED")+" BED 																									" + CRLF
	cQry+="     INNER JOIN "+RETSQLNAME("BPX")+" BPX ON (BPX_MOTIVO = BED_MOTIVO) 															" + CRLF
	cQry+="     INNER JOIN "+RETSQLNAME("BA1")+" BA1 ON (BA1_CODINT = BED_CODINT AND BA1_CODEMP = BED_CODEMP AND BA1_MATRIC = BED_MATRIC)	" + CRLF
	cQry+="     INNER JOIN "+RETSQLNAME("BJC")+" BJC ON (BPX_CODINT = BJC_CODINT AND BPX_MOTIVO = BJC_MOTIVO								" + CRLF
	cQry+="     											AND BA1_SUBCON = BJC_SUBCON AND BJC_CODEMP = BA1_CODEMP)						" + CRLF
	cQry+=" WHERE  																															" + CRLF
	cQry+="     BED.D_E_L_E_T_ = ' ' 																										" + CRLF
	cQry+="     AND BPX.D_E_L_E_T_ = ' ' 																									" + CRLF
	cQry+="     AND BA1.D_E_L_E_T_ = ' ' 																									" + CRLF
	cQry+="     AND BJC.D_E_L_E_T_ = ' ' 																									" + CRLF
	cQry+="     AND BED_MOTIVO IN ('1','5','7','8') 																						" + CRLF
	cQry+="     AND BED_DTSOLI BETWEEN '"+MV_PAR01+"01' AND '"+MV_PAR02+"31' 																" + CRLF
	IF !EMPTY(MV_PAR03)
	cQry+="     AND BA1_CODEMP = '"+MV_PAR03+"' 																							" + CRLF
	ENDIF
	cQry+=" GROUP BY BED_MATRIC, BED_NOMUSR, BED_MOTIVO,BPX_DESCRI,  BED_DTSOLI, BED_DATVAL, BA1_CODEMP, BJC_VALOR 							" + CRLF
	cQry+=" ORDER BY BED_DTSOLI																												" + CRLF
//cQry    := ChangeQuery(cQry)
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
		
	oReport:FatLine()
	oReport:Section(1):Finish()

	(cAliasBOL)->(DbCloseArea())

EndIf

Return

Static Function AjustaSX1_2(cPerg)

Local aHelpPor	:= {} 


aHelpPor := {}
AADD(aHelpPor,"Informe:			")

	u_CABASX1(cPerg,"01","Ano/Mês de:"	        		,"","",	"MV_CH1" ,"C",6,0,0,"G","","","","","MV_PAR01","","","","","")		
	u_CABASX1(cPerg,"02","Ano/Mês até:"    				,"","", "MV_CH2" ,"C",6,0,0,"G","","","","","MV_PAR02","","","","","")
	u_CABASX1(cPerg,"03","Empresa:"    					,"","", "MV_CH3" ,"C",4,0,0,"G","","","","","MV_PAR03","","","","","")
Return()

