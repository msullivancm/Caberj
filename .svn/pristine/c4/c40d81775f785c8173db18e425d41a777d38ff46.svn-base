#INCLUDE 'TOTVS.CH'
#INCLUDE "TOPCONN.CH" 
#Include "MSGRAPHI.CH"
#Include "FILEIO.CH"
#DEFINE CRLF Chr(13)+Chr(10)

/*/{Protheus.doc} CABR313
description
@type function
@version  1.0.0
@author Ramon Nogueira - 7 Consulting
@since 30/01/2023
@return variant, return_description
/*/
USER FUNCTION CABR322()

Local oReport
Local aArea := GetArea()
Private cPerg  := "CABR322"

AjustaSX1(cPerg)

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
Local cTit := "Relatório de data inicial de contrato"

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

		 
	oSection2 := TRSection():New(oReport,"Relatório de data inicial de contrato",) 

	// Colunas do relatorio
	TRCell():New(oSection2,"",,"CODIGO"			 , "",15,.F.,{|| (cAliasBOL)->CODIGO}	,"LEFT",.T.,"LEFT" )
	TRCell():New(oSection2,"",,"NOME"			 , "",50,.F.,{|| (cAliasBOL)->NOME}		,"LEFT",.T.,"LEFT" )
	TRCell():New(oSection2,"",,"CONTRATO"		 , "",15,.F.,{|| (cAliasBOL)->CONTRATO}	,"LEFT",.T.,"LEFT" )
	TRCell():New(oSection2,"",,"DATA SOLICITACAO", "",10,.F.,{|| (cAliasBOL)->DATAINI}	,"LEFT",.T.,"LEFT" )

RestArea( aAreaSM0 )

Return(oReport)

Static Function ReportPrt(oReport)
Local oSection2 

Private cAliasBOL  := GetnextAlias()
Private aArea1  := {} 

oSection2 := oReport:Section(1)

// Query para buscar os dados no banco

    cQry := " SELECT BG9_CODIGO CODIGO, BG9_DESCRI NOME, BT5_NUMCON CONTRATO, "+CRLF
    cQry += " SUBSTR(BT5_DATCON,7,2)||'/'||SUBSTR(BT5_DATCON,5,2)||'/'||SUBSTR(BT5_DATCON,1,4) DATAINI "+CRLF
    cQry += " FROM "+RetSqlName("BG9")+" BG9 "+CRLF
    cQry += " INNER JOIN "+RetSqlName("BT5")+" BT5 "+CRLF
    cQry += " ON ( BG9_FILIAL = BT5_FILIAL AND BG9_CODINT = BT5_CODINT AND BG9_CODIGO = BT5_CODIGO AND BT5.D_E_L_E_T_ = ' ') "+CRLF
    cQry += " WHERE BT5_DATCON BETWEEN '"+DToS(MV_PAR01)+"' AND '"+DToS(MV_PAR02)+"'"+CRLF
    cQry += " AND BG9.D_E_L_E_T_ = ' ' "+CRLF
    cQry += " ORDER BY 1 "+CRLF

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

Static Function AjustaSX1(cPerg)

Local aHelpPor	:= {} 

aHelpPor := {}
AADD(aHelpPor,"Informe:			")

	u_CABASX1(cPerg,"01","DT.Inicio de:"	        		,"","",	"MV_CH1" ,"D",8,0,0,"G","","","","","MV_PAR01","","","","","")		
	u_CABASX1(cPerg,"02","DT.Inicio até :"    				,"","", "MV_CH2" ,"D",8,0,0,"G","","","","","MV_PAR02","","","","","")

Return()

