#INCLUDE "REPORT.CH"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "TOPCONN.CH"

#DEFINE CRLF  CHR(13)+CHR(10)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCABR280   บAutor  ณFabio Bianchini   บ Data ณ  22/04/20   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRelat๓rio para acompanhamento de Recursos de Glosa gerados  บฑฑ
ฑฑบ          ณpela nova rotina (PLSRECGLO2)                               บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CABERJ                                                     บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function CABR280()

Local _aArea		:= GetArea()
Local oReport		:= Nil

Private _cPerg		:= "CABR280"

CABR280A(_cPerg)		// CriaR Perguntas
if Pergunte(_cPerg,.T.)
	oReport := CABR280B()
	oReport:PrintDialog()
endif

RestArea(_aArea)

return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCABR280A    บAutor  ณFabio Bianchini   บ Data ณ  14/09/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRelat๓rio para acompanhamento de Recursos de Glosa gerados  บฑฑ
ฑฑบ          ณpela nova rotina (PLSRECGLO2)                               บฑฑ
ฑฑบ          ณ -----  Perguntas do Relat๓rio -------------------          บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออxออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CABERJ                                                     บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function CABR280A(cGrpPerg)

Local aHelpPor := {} //help da pergunta

PutSx1(cGrpPerg,"01","Status do Recurso?"	,"","","MV_CH1","N",1						,0,0,"G","","CABC08","","","MV_PAR01",""    ,"","","","",""    ,"","","","","","","","","","",aHelpPor,{},{},"")
PutSx1(cGrpPerg,"02","RDA de?"				,"","","MV_CH2","C",TamSX3("B4D_CODRDA")[1]	,0,0,"G","","BAUPLS","","","MV_PAR02",""    ,"","","","",""    ,"","","","","","","","","","",aHelpPor,{},{},"")
PutSx1(cGrpPerg,"03","RDA ate?"				,"","","MV_CH3","C",TamSX3("B4D_CODRDA")[1]	,0,0,"G","","BAUPLS","","","MV_PAR03",""    ,"","","","",""    ,"","","","","","","","","","",aHelpPor,{},{},"")
PutSx1(cGrpPerg,"04","Ano/Mes de?"			,"","","MV_CH4","C",6						,0,0,"G","",""		,"","","MV_PAR04",""    ,"","","","",""    ,"","","","","","","","","","",aHelpPor,{},{},"")
PutSx1(cGrpPerg,"05","Ano/Mes ate?"			,"","","MV_CH5","C",6						,0,0,"G","",""		,"","","MV_PAR05",""    ,"","","","",""    ,"","","","","","","","","","",aHelpPor,{},{},"")
PutSx1(cGrpPerg,"06","Analista responsแvel?","","","MV_CH6","C",6						,0,0,"G","","SZNPLS","","","MV_PAR06",""    ,"","","","",""    ,"","","","","","","","","","",aHelpPor,{},{},"")
PutSx1(cGrpPerg,"07","Com quebras?"			,"","","MV_CH7","C",1						,0,0,"C","",""		,"","","MV_PAR07","Sim" ,"","","","","Nใo" ,"","","","","","","","","","",aHelpPor,{},{},"")
PutSx1(cGrpPerg,"08","Objeto do Recurso?"	,"","","MV_CH8","C",1						,0,0,"C","",""		,"","","MV_PAR08","Item","","","","","Guia","","","","","","","","","","",aHelpPor,{},{},"")

return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCABR280B    บAutor  ณFabio Bianchini   บ Data ณ  14/09/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRelat๓rio Sint้tico de movimento de repassados.             บฑฑ
ฑฑบ          ณ -----  Gerando as colunas para o relat๓rio -------------   บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CABERJ                                                     บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function CABR280B

Local oReport		:= Nil
Local oSection1 	:= Nil
Local oSection2 	:= Nil
Local oSection3 	:= Nil
Local oBreak		:= Nil

oReport := TReport():New("CABR280","CONFERสNCIA DOS RECURSOS DE GLOSAS",_cPerg,{|oReport| CABR280C(oReport)},"Confer๊ncia Recurso de Glosa")

oReport:SetLandScape()				// Orienta็ใo paisagem
oReport:SetTotalInLine(.F.)
oReport:nLineHeight		:= 30
oReport:cFontBody		:= "Arial"
oReport:nColSpace		:= 1

if MV_PAR07 == 1					// Com Quebras

	oSection1 := TRSection():New(oReport,"SITUAวรO DO RECURSO","")
	TRCell():New(oSection1 , 'STATUS'		, , 'Status'				,								,60,,,			,,"CENTER"	)

	oSection2 := TRSection():New(oReport,"PRESTADOR(ES)","")
	TRCell():New(oSection2 , 'CODRDA'		, , 'Codigo RDA'			,								,07,,,			,,"CENTER"	)
	TRCell():New(oSection2 , 'NOMRDA'		, , 'Nome RDA'				,								,40,,,			,,"CENTER"	)

	oSection3 := TRSection():New(oReport,"RECURSOS DE GLOSAS","")
	TRCell():New(oSection3 , 'MES_GUIORI'	, , 'M๊s Orig.'				,								,05,,,			,,"CENTER"	)
	TRCell():New(oSection3 , 'ANO_GUIORI'	, , 'Ano Orig.'				,								,07,,,			,,"CENTER"	)
	TRCell():New(oSection3 , 'COMP_GUIORI'	, , 'Comp Orig.'			,								,07,,,			,,"CENTER"	)
	TRCell():New(oSection3 , 'LOC_GUIORI'	, , 'Local Orig.'			,								,06,,,			,,"CENTER"	)
	TRCell():New(oSection3 , 'PEG_GUIORI'	, , 'PEG Orig.'				,								,10,,,			,,"CENTER"	)
	TRCell():New(oSection3 , 'GUIA_GUIORI'	, , 'Guia Orig.'			,								,15,,,			,,"CENTER"	)
	TRCell():New(oSection3 , 'MES_RECURSO'	, , 'M๊s Rec.'				,								,05,,,			,,"CENTER"	)
	TRCell():New(oSection3 , 'ANO_RECURSO'	, , 'Ano Rec.'				,								,07,,,			,,"CENTER"	)
	TRCell():New(oSection3 , 'LOC_RECURSO'	, , 'Local Rec.'			,								,06,,,			,,"CENTER"	)
	TRCell():New(oSection3 , 'PEG_RECURSO'	, , 'PEG Rec.'				,								,10,,,			,,"CENTER"	)
	TRCell():New(oSection3 , 'GUIA_RECURSO'	, , 'Guia Rec.'				,								,15,,,			,,"CENTER"	)
	TRCell():New(oSection3 , 'FASE_PEG'		, , 'Fase Rec.'				,								,15,,,			,,"CENTER"	)
	TRCell():New(oSection3 , 'NUM_LOTE'		, , 'Lote de Pagamento' 	, 								,13,,,"RIGHT"	,,"RIGHT"	)
	TRCell():New(oSection3 , 'TITULO_PAG'	, , 'Titulo de Pagamento'	, 								,13,,,"RIGHT"	,,"RIGHT"	)
	if MV_PAR08 == 1		// Item
		TRCell():New(oSection3 , 'CODPAD'	, , 'Tp. Tab.'				,								,06,,,			,,"CENTER"	)
		TRCell():New(oSection3 , 'CODPRO'	, , 'Cod. Proc.'			,								,15,,,			,,"CENTER"	)
		TRCell():New(oSection3 , 'DESPRO'	, , 'Desc. Proc.'			,								,30,,,			,,"CENTER"	)
	endif
	TRCell():New(oSection3 , 'DATA_SOLICITACAO'	, , 'Data Solicitacao'	,								,30,,,			,,"CENTER"	)
	TRCell():New(oSection3 , 'PROTOCOLO'	, , 'Protocolo'				,								,17,,,			,,"CENTER"	)
	TRCell():New(oSection3 , 'VLR_GLOSA'	, , 'Vlr. Glosa'			, PesqPict("B4E","B4E_VLRGLO")	,13,,,"RIGHT"	,,"RIGHT"	)
	TRCell():New(oSection3 , 'VLR_SOLIC'	, , 'Vlr. Solic.'			, PesqPict("B4E","B4E_VLRREC")	,13,,,"RIGHT"	,,"RIGHT"	)
	TRCell():New(oSection3 , 'VLR_RECUP'	, , 'Vlr. Recup.'			, PesqPict("B4E","B4E_VLRACA")	,13,,,"RIGHT"	,,"RIGHT"	)
	TRCell():New(oSection3 , 'VLR_MANT'		, , 'Vlr. Mant.'			, PesqPict("B4E","B4E_VLRREC")	,13,,,"RIGHT"	,,"RIGHT"	)
	TRCell():New(oSection3 , 'ANALISTA'		, , 'Analista'				,								,40,,,			,,"CENTER"	)
	
	
	TRFunction():SetEndSection(.T.)

	oBreak := TRBreak():New(oSection2,oSection3:Cell("VLR_GLOSA"),"SUBTOTAIS POR STATUS/PRESTADOR: GLOSA / RECURSO / LIBERADO")
	TRFunction():New(oSection3:Cell("VLR_GLOSA"),NIL,"SUM",oBreak,,,,.F.,.F.)
	TRFunction():New(oSection3:Cell("VLR_SOLIC"),NIL,"SUM",oBreak,,,,.F.,.F.)
	TRFunction():New(oSection3:Cell("VLR_RECUP"),NIL,"SUM",oBreak,,,,.F.,.F.)
	TRFunction():New(oSection3:Cell("VLR_MANT") ,NIL,"SUM",oBreak,,,,.F.,.F.)

	oReport:SkipLine()

	TRFunction():New(oSection3:Cell("VLR_GLOSA"),NIL,"SUM",,,,,.F.,.T.)
	TRFunction():New(oSection3:Cell("VLR_SOLIC"),NIL,"SUM",,,,,.F.,.T.)
	TRFunction():New(oSection3:Cell("VLR_RECUP"),NIL,"SUM",,,,,.F.,.T.)
	TRFunction():New(oSection3:Cell("VLR_MANT") ,NIL,"SUM",,,,,.F.,.T.)

elseif MV_PAR07 == 2			// Sem Quebras

	oSection1 := TRSection():New(oReport,"RECURSOS DE GLOSAS","")
	TRCell():New(oSection1 , 'STATUS'		, , 'Status'				,								,60,,,			,,"CENTER"	)
	TRCell():New(oSection1 , 'CODRDA'		, , 'Codigo RDA'			,								,07,,,			,,"CENTER"	)
	TRCell():New(oSection1 , 'NOMRDA'		, , 'Nome RDA'				,								,40,,,			,,"CENTER"	)
	TRCell():New(oSection1 , 'MES_GUIORI'	, , 'M๊s Orig.'				,								,05,,,			,,"CENTER"	)
	TRCell():New(oSection1 , 'ANO_GUIORI'	, , 'Ano Orig.'				,								,07,,,			,,"CENTER"	)
	TRCell():New(oSection1 , 'COMP_GUIORI'	, , 'Comp Orig.'			,								,07,,,			,,"CENTER"	)
	TRCell():New(oSection1 , 'LOC_GUIORI'	, , 'Local Orig.'			,								,06,,,			,,"CENTER"	)
	TRCell():New(oSection1 , 'PEG_GUIORI'	, , 'PEG Orig.'				,								,10,,,			,,"CENTER"	)
	TRCell():New(oSection1 , 'GUIA_GUIORI'	, , 'Guia Orig.'			,								,15,,,			,,"CENTER"	)
	TRCell():New(oSection1 , 'MES_RECURSO'	, , 'M๊s Rec.'				,								,05,,,			,,"CENTER"	)
	TRCell():New(oSection1 , 'ANO_RECURSO'	, , 'Ano Rec.'				,								,07,,,			,,"CENTER"	)
	TRCell():New(oSection1 , 'LOC_RECURSO'	, , 'Local Rec.'			,								,06,,,			,,"CENTER"	)
	TRCell():New(oSection1 , 'PEG_RECURSO'	, , 'PEG Rec.'				,								,10,,,			,,"CENTER"	)
	TRCell():New(oSection1 , 'GUIA_RECURSO'	, , 'Guia Rec.'				,								,15,,,			,,"CENTER"	)
	TRCell():New(oSection1 , 'FASE_PEG'		, , 'Fase Rec.'				,								,15,,,			,,"CENTER"	)
	TRCell():New(oSection1 , 'NUM_LOTE'		, , 'Lote de Pagamento'		, 								,13,,,"RIGHT"	,,"RIGHT"	)
	TRCell():New(oSection1 , 'TITULO_PAG'	, , 'Titulo de Pagamento'	, 								,13,,,"RIGHT"	,,"RIGHT"	)
	if MV_PAR08 == 1		// Item
		TRCell():New(oSection1 , 'CODPAD'	, , 'Tp. Tab.'				,								,06,,,			,,"CENTER"	)
		TRCell():New(oSection1 , 'CODPRO'	, , 'Cod. Proc.'			,								,15,,,			,,"CENTER"	)
		TRCell():New(oSection1 , 'DESPRO'	, , 'Desc. Proc.'			,								,30,,,			,,"CENTER"	)
	endif
	TRCell():New(oSection1 , 'DATA_SOLICITACAO'	, , 'Data Solicitacao'	,								,30,,,			,,"CENTER"	)
	TRCell():New(oSection1 , 'PROTOCOLO'	, , 'Protocolo'				,								,17,,,			,,"CENTER"	)
	TRCell():New(oSection1 , 'VLR_GLOSA'	, , 'Vlr. Glosa'			, PesqPict("B4E","B4E_VLRGLO")	,13,,,"RIGHT"	,,"RIGHT"	)
	TRCell():New(oSection1 , 'VLR_SOLIC'	, , 'Vlr. Solic.'			, PesqPict("B4E","B4E_VLRREC")	,13,,,"RIGHT"	,,"RIGHT"	)
	TRCell():New(oSection1 , 'VLR_RECUP'	, , 'Vlr. Recup.'			, PesqPict("B4E","B4E_VLRACA")	,13,,,"RIGHT"	,,"RIGHT"	)
	TRCell():New(oSection1 , 'VLR_MANT'		, , 'Vlr. Mant.'			, PesqPict("B4E","B4E_VLRREC")	,13,,,"RIGHT"	,,"RIGHT"	)
	TRCell():New(oSection1 , 'ANALISTA'		, , 'Analista'				,								,40,,,			,,"CENTER"	)
	

	TRFunction():SetEndSection(.T.)

endif

return oReport


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCABR280C  บAutor  ณFabio Bianchini     บ Data ณ  22/04/20   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRelat๓rio para acompanhamento de Recursos de Glosa gerados  บฑฑ
ฑฑบ          ณpela nova rotina (PLSRECGLO2)                               บฑฑ
ฑฑบ          ณ -----  Gerando as informa็๕es para o relat๓rio ---------   บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CABERJ                                                     บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function CABR280C(oReport)

Local _aArea		:= GetArea()
Local oSection1		:= oReport:Section(1)
Local oSection2		:= oReport:Section(2)
Local oSection3		:= oReport:Section(3)

Local cQuery		:= ""
Local cAlias1		:= GetNextAlias()
Local cCtrlStatus	:= ""
Local cCtrlRDA		:= ""
Local nContGuia		:= 0
Local cMvPar01		:= ""
Local nX			:= 0

if !empty(MV_PAR01)
	for nX := 1 to Len(AllTrim(MV_PAR01))
		if SubStr(AllTrim(MV_PAR01),nX,1) <> ","
			cMvPar01	+= "'" + SubStr(AllTrim(MV_PAR01),nX,1) + "'"
		else
			cMvPar01	+= SubStr(AllTrim(MV_PAR01),nX,1)
		endif
	next nX
endif

cQuery := " SELECT DISTINCT B4D_CODRDA CODRDA,															" + CRLF
cQuery +=		 " B4D_NOMCON NOMRDA,															" + CRLF
cQuery +=		 " B4D_STATUS,																	" + CRLF
cQuery +=		 " CASE WHEN B4D_STATUS = '0' THEN '0 - INCLUIDO'								" + CRLF
cQuery +=			  " WHEN B4D_STATUS = '1' THEN '1 - PROTOCOLADO'							" + CRLF
cQuery +=			  " WHEN B4D_STATUS = '2' THEN '2 - EM ANALISE'								" + CRLF
cQuery +=			  " WHEN B4D_STATUS = '3' THEN '3 - AUTORIZADO'								" + CRLF
cQuery +=			  " WHEN B4D_STATUS = '4' THEN '4 - NEGADO'									" + CRLF
cQuery +=			  " WHEN B4D_STATUS = '5' THEN '5 - AUT.PARCIAL' END STATUS,				" + CRLF
cQuery +=		 " B4D_MESAUT MES_GUIORI,														" + CRLF
cQuery +=		 " B4D_ANOAUT ANO_GUIORI,														" + CRLF
cQuery +=		 " B4D_MESAUT||B4D_ANOAUT COMP_GUIORI,											" + CRLF
cQuery +=		 " B4D_CODLDP LOC_GUIORI,														" + CRLF
cQuery +=		 " B4D_CODPEG PEG_GUIORI,														" + CRLF
cQuery +=		 " B4D_NUMAUT GUIA_GUIORI,														" + CRLF
cQuery +=		 " SUBSTR(B4D_DATSOL,5,2) MES_RECURSO,											" + CRLF
cQuery +=		 " SUBSTR(B4D_DATSOL,1,4) ANO_RECURSO,											" + CRLF
cQuery +=		 " B4D_DCDDLP LOC_RECURSO,														" + CRLF
cQuery +=		 " B4D_DCDPEG PEG_RECURSO,														" + CRLF
cQuery +=		 " B4D_DNUMER GUIA_RECURSO,														" + CRLF
cQuery +=		 " CASE WHEN TRIM(BE4_FASE)='1' OR TRIM(BD5_FASE) ='1' THEN '1 - Digitacao' 	" + CRLF	
cQuery +=		 "		WHEN TRIM(BE4_FASE)='2' OR TRIM(BD5_FASE) ='2' THEN '2 - Conferencia' 	" + CRLF		
cQuery +=		 "		WHEN TRIM(BE4_FASE)='3' OR TRIM(BD5_FASE) ='3' THEN '3 - Pronta' 		" + CRLF			
cQuery +=		 "		WHEN TRIM(BE4_FASE)='4' OR TRIM(BD5_FASE) ='4' THEN '4 - Faturada'  	" + CRLF			
cQuery +=		 "	END  FASE_PEG, 																" + CRLF
cQuery +=		 " B4D_PROTOC PROTOCOLO,														" + CRLF
cQuery +=		 " ZN_NOMANA ANALISTA,															" + CRLF
cQuery +=		 " CASE WHEN TRIM(BE4_NUMLOT)IS NULL THEN TRIM(BD5_NUMLOT) 						" + CRLF
cQuery +=		 " 		WHEN TRIM(BD5_NUMLOT) IS NULL THEN TRIM(BE4_NUMLOT) 					" + CRLF
cQuery +=		 " END NUM_LOTE, 																" + CRLF
cQuery +=		 "   (SELECT E2_PREFIXO||'-'||E2_NUM||'-'||E2_TIPO TITULO_PAG 					" + CRLF
cQuery +=		 "   FROM " + RetSqlName("SE2") + " E2 											" + CRLF
cQuery +=		 "   WHERE (E2_FORNECE = BAU_CODSA2 OR E2_FORNECE = 'UNIAO')  											" + CRLF
cQuery +=		 "   	AND E2.D_E_L_E_T_ = ' ' AND												" + CRLF
cQuery +=		 "   E2_PLLOTE = (CASE WHEN TRIM(BE4_NUMLOT)IS NULL THEN TRIM(BD5_NUMLOT) 		" + CRLF
cQuery +=		 "   					WHEN TRIM(BD5_NUMLOT) IS NULL THEN TRIM(BE4_NUMLOT) 	" + CRLF
cQuery +=		 "   						END) AND E2_PLLOTE <> ' ' AND						" + CRLF
cQuery +=		 "		E2_TIPO = 'FT' ) TITULO_PAG, 											" + CRLF
cQuery +=		 "	 SUBSTR(B4D_DATREC,7,2)||'/'||SUBSTR(B4D_DATREC,5,2)||'/'||SUBSTR(B4D_DATREC,1,4) DATA_SOLICITACAO,			 									" + CRLF

if MV_PAR08 == 1		// Item
	cQuery +=	 " B4E_CODPAD CODPAD,															" + CRLF
	cQuery +=	 " B4E_CODPRO CODPRO,															" + CRLF
	cQuery +=	 " B4E_DESPRO DESPRO,															" + CRLF
	cQuery +=	 " B4E_VLRGLO VLR_GLOSA,														" + CRLF
	cQuery +=	 " B4E_VLRREC VLR_SOLIC,														" + CRLF
	cQuery +=	 " B4E_VLRACA VLR_RECUP,														" + CRLF
	cQuery +=	 " B4E_VLRREC - B4E_VLRACA VLR_MANT,											" + CRLF
	cQuery +=	 " B4E_JUSPRE JUSTIFICATIVA														" + CRLF
else					// Guia/Protocolo
	cQuery +=	 " B4D_VLRGLO VLR_GLOSA,														" + CRLF
	cQuery +=	 " B4D_TOTREC VLR_SOLIC,														" + CRLF
	cQuery +=	 " B4D_TOTACA VLR_RECUP,														" + CRLF
	cQuery +=	 " B4D_TOTREC - B4D_TOTACA VLR_MANT,											" + CRLF
	cQuery +=	 " B4D_JUSGUI JUSTIFICATIVA														" + CRLF
endif

cQuery += " FROM " + RetSqlName("B4D") + " B4D													" + CRLF

if MV_PAR08 == 1		// Item
	cQuery +=	" INNER JOIN " + RetSqlName("B4E") + " B4E										" + CRLF
	cQuery +=		" ON (    B4D_FILIAL = B4E_FILIAL											" + CRLF
	cQuery +=			" AND B4D_OPEMOV = B4E_OPEMOV											" + CRLF
	cQuery +=			" AND B4D_ANOAUT = B4E_ANOAUT											" + CRLF
	cQuery +=			" AND B4D_MESAUT = B4E_MESAUT											" + CRLF
	cQuery +=			" AND B4D_NUMAUT = B4E_NUMAUT											" + CRLF
	cQuery +=			" AND B4D_SEQB4D = B4E_SEQB4D											" + CRLF
	cQuery +=			" AND B4E.D_E_L_E_T_ = ' '	)											" + CRLF
endif

cQuery +=	" LEFT JOIN " + RetSqlName("SZN") + " SZN											" + CRLF
cQuery +=		" ON (    SZN.D_E_L_E_T_ = ' ' 													" + CRLF
cQuery +=		" AND ZN_FILIAL = B4D_FILIAL													" + CRLF
cQuery +=		" AND ZN_CODRDA = B4D_CODRDA 													" + CRLF
cQuery +=		" AND (   TO_CHAR(SYSDATE,'YYYYMM') BETWEEN SUBSTR(ZN_VIGINI,3,4)||SUBSTR(ZN_VIGINI,1,2) AND SUBSTR(ZN_VIGFIM,3,4)||SUBSTR(ZN_VIGFIM,1,2) " + CRLF
cQuery +=		" OR TO_CHAR(SYSDATE,'YYYYMM') >=SUBSTR(ZN_VIGINI,3,4)||SUBSTR(ZN_VIGINI,1,2) AND ZN_VIGFIM = ' ')" + CRLF
cQuery +=		" AND ZN_ATIVO  = '0')															" + CRLF

cQuery +=		" LEFT JOIN " + RetSqlName("BE4") + " BE4 ON (BE4_FILIAL = b4d_filial AND 		" + CRLF
cQuery +=		" BE4_CODOPE = B4D_OPEMOV AND BE4_CODLDP = B4D_DCDDLP 							" + CRLF
cQuery +=		" AND BE4_CODPEG = B4D_DCDPEG AND  BE4_NUMERO = B4D_DNUMER						" + CRLF
cQuery +=		" AND BE4.D_E_L_E_T_ = ' ')														" + CRLF

cQuery +=		" LEFT JOIN " + RetSqlName("BD5") + " BD5 ON (BD5_FILIAL = b4d_filial AND 		" + CRLF
cQuery +=		" BD5_CODOPE = B4D_OPEMOV AND BD5_CODLDP = B4D_DCDDLP 							" + CRLF
cQuery +=		" AND BD5_CODPEG = B4D_DCDPEG AND  BD5_NUMERO = B4D_DNUMER						" + CRLF
cQuery +=		" AND BD5.D_E_L_E_T_ = ' ')														" + CRLF

cQuery +=		" LEFT JOIN " + RetSqlName("BAU") + " BAU ON (BAU_FILIAL = b4d_filial 	 		" + CRLF
cQuery +=		" AND bau_codigo = B4D_CODRDA AND BD5.D_E_L_E_T_ = ' ')							" + CRLF

cQuery += " WHERE B4D.D_E_L_E_T_ = ' '															" + CRLF
cQuery += " AND B4D_FILIAL = '" + xFilial("B4D") + "'											" + CRLF
if MV_PAR08 == 1		// Item
	cQuery += " AND B4D_OBJREC = '3'															" + CRLF
else					// Guia/Protocolo
	cQuery += " AND B4D_OBJREC <> '3'															" + CRLF
endif
if !Empty(cMVPAR01)
	cQuery += " AND B4D_STATUS IN (" + cMVPAR01 + ")											" + CRLF
endif
if !Empty(MV_PAR02)
	cQuery += " AND B4D_CODRDA >= '" + MV_PAR02 + "'											" + CRLF
endif
if !Empty(MV_PAR03)
	cQuery += " AND B4D_CODRDA <= '" + MV_PAR03 + "'											" + CRLF
endif
if !Empty(MV_PAR04) .and. MV_PAR04 <= MV_PAR05
	cQuery += " AND B4D_ANOAUT||B4D_MESAUT >= '" + MV_PAR04 + "'								" + CRLF
endif
if !Empty(MV_PAR05) .and. MV_PAR05 >= MV_PAR04
	cQuery += " AND B4D_ANOAUT||B4D_MESAUT <= '" + MV_PAR05 + "'								" + CRLF
endif
if !empty(MV_PAR06)
	cQuery += " AND ZN_CODANA = '" + AllTrim(MV_PAR06) + "'										" + CRLF
endif
cQuery += " ORDER BY 3, 1, 6, 5, 7, 8															" + CRLF

if Select (cAlias1) > 0
	(cAlias1)->(DbCloseArea())
endif

dbUseArea(.T., "TOPCONN",  TCGenQry(,,cQuery), cAlias1, .F., .T.)

(cAlias1)->(DbGoTop())
if !(cAlias1)->(EOF())

	oReport:SetMeter((cAlias1)->(LastRec()))

	while !(cAlias1)->(EOF())

		if oReport:Cancel()
			exit
		endif

		if MV_PAR07 == 1		// Com Quebras

			oSection1:Init()					// Inicia Primeira Se็ใo
			oSection1:SetHeaderSection(.F.)
			
			oReport:IncMeter()

			//Guarda o Coneudo do campo STATUS para comparar no While abaixo. Usado para Quebra de se็ใo           
			cCtrlStatus := (cAlias1)->STATUS

			oSection1:Cell("STATUS"):SetValue("Status --> " + (cAlias1)->STATUS)
			oSection1:PrintLine()

			oReport:SkipLine()

			oSection2:Init()					// Inicia Segunda Se็ใo
			while (cAlias1)->STATUS == cCtrlStatus

				oReport:IncMeter()

				oSection2:Cell("CODRDA"):SetValue((cAlias1)->CODRDA)
				oSection2:Cell("NOMRDA"):SetValue((cAlias1)->NOMRDA)
				oSection2:PrintLine()

				cCtrlRDA := (cAlias1)->CODRDA

				oSection3:Init() 				// Inicia Terceira Se็ใo

				nContGuia := 0

				While (cAlias1)->CODRDA == cCtrlRDA .and. (cAlias1)->STATUS == cCtrlStatus

					oReport:IncMeter()

					oSection3:Cell("MES_GUIORI"	 ):SetValue((cAlias1)->MES_GUIORI)
					oSection3:Cell("ANO_GUIORI"	 ):SetValue((cAlias1)->ANO_GUIORI)
					oSection3:Cell("COMP_GUIORI" ):SetValue((cAlias1)->COMP_GUIORI)
					oSection3:Cell("LOC_GUIORI"	 ):SetValue((cAlias1)->LOC_GUIORI)
					oSection3:Cell("PEG_GUIORI"	 ):SetValue((cAlias1)->PEG_GUIORI)
					oSection3:Cell("GUIA_GUIORI" ):SetValue((cAlias1)->GUIA_GUIORI)
					oSection3:Cell("MES_RECURSO" ):SetValue((cAlias1)->MES_RECURSO)
					oSection3:Cell("ANO_RECURSO" ):SetValue((cAlias1)->ANO_RECURSO)
					oSection3:Cell("LOC_RECURSO" ):SetValue((cAlias1)->LOC_RECURSO)
					oSection3:Cell("PEG_RECURSO" ):SetValue((cAlias1)->PEG_RECURSO)
					oSection3:Cell("GUIA_RECURSO"):SetValue((cAlias1)->GUIA_RECURSO)
					oSection3:Cell("FASE_PEG"	 ):SetValue((cAlias1)->FASE_PEG)
					oSection3:Cell("NUM_LOTE"    ):SetValue((cAlias1)->NUM_LOTE)
					oSection3:Cell("TITULO_PAG"  ):SetValue((cAlias1)->TITULO_PAG)
					if MV_PAR08 == 1		// Item
						oSection3:Cell("CODPAD"  ):SetValue((cAlias1)->CODPAD)
						oSection3:Cell("CODPRO"  ):SetValue((cAlias1)->CODPRO)
						oSection3:Cell("DESPRO"  ):SetValue((cAlias1)->DESPRO)
					endif
					oSection3:Cell("DATA_SOLICITACAO"  ):SetValue((cAlias1)->DATA_SOLICITACAO)
					oSection3:Cell("PROTOCOLO"   ):SetValue((cAlias1)->PROTOCOLO)
					oSection3:Cell("VLR_GLOSA"   ):SetValue((cAlias1)->VLR_GLOSA)
					oSection3:Cell("VLR_SOLIC"   ):SetValue((cAlias1)->VLR_SOLIC)
					oSection3:Cell("VLR_RECUP"   ):SetValue((cAlias1)->VLR_RECUP)
					oSection3:Cell("VLR_MANT"    ):SetValue((cAlias1)->VLR_MANT)
					oSection3:Cell("ANALISTA"    ):SetValue((cAlias1)->ANALISTA)
					

					oSection3:PrintLine()

					nContGuia++

					(cAlias1)->(DbSkip())
				end
				
				oReport:ThinLine()
				oReport:SkipLine()
				oSection3:Finish()
			end

			oReport:SkipLine()
			oSection2:Finish()

		elseif MV_PAR07 == 2

			oSection1:Init()					// Inicia ฺnica Se็ใo
			oSection1:SetHeaderSection(.F.)

			oReport:IncMeter()

			oSection1:Cell("STATUS"      ):SetValue((cAlias1)->STATUS)
			oSection1:Cell("CODRDA"      ):SetValue((cAlias1)->CODRDA)
			oSection1:Cell("NOMRDA"      ):SetValue((cAlias1)->NOMRDA)
			oSection1:Cell("MES_GUIORI"	 ):SetValue((cAlias1)->MES_GUIORI)
			oSection1:Cell("ANO_GUIORI"	 ):SetValue((cAlias1)->ANO_GUIORI)
			oSection1:Cell("COMP_GUIORI" ):SetValue((cAlias1)->COMP_GUIORI)
			oSection1:Cell("LOC_GUIORI"	 ):SetValue((cAlias1)->LOC_GUIORI)
			oSection1:Cell("PEG_GUIORI"	 ):SetValue((cAlias1)->PEG_GUIORI)
			oSection1:Cell("GUIA_GUIORI" ):SetValue((cAlias1)->GUIA_GUIORI)
			oSection1:Cell("MES_RECURSO" ):SetValue((cAlias1)->MES_RECURSO)
			oSection1:Cell("ANO_RECURSO" ):SetValue((cAlias1)->ANO_RECURSO)
			oSection1:Cell("LOC_RECURSO" ):SetValue((cAlias1)->LOC_RECURSO)
			oSection1:Cell("PEG_RECURSO" ):SetValue((cAlias1)->PEG_RECURSO)
			oSection1:Cell("GUIA_RECURSO"):SetValue((cAlias1)->GUIA_RECURSO)
			oSection1:Cell("FASE_PEG"	 ):SetValue((cAlias1)->FASE_PEG)
			oSection1:Cell("NUM_LOTE"    ):SetValue((cAlias1)->NUM_LOTE)
			oSection1:Cell("TITULO_PAG"  ):SetValue((cAlias1)->TITULO_PAG)
			if MV_PAR08 == 1		// Item
				oSection1:Cell("CODPAD"  ):SetValue((cAlias1)->CODPAD)
				oSection1:Cell("CODPRO"  ):SetValue((cAlias1)->CODPRO)
				oSection1:Cell("DESPRO"  ):SetValue((cAlias1)->DESPRO)
			endif
			oSection1:Cell("DATA_SOLICITACAO"  ):SetValue((cAlias1)->DATA_SOLICITACAO)
			oSection1:Cell("PROTOCOLO"   ):SetValue((cAlias1)->PROTOCOLO)
			oSection1:Cell("VLR_GLOSA"   ):SetValue((cAlias1)->VLR_GLOSA)
			oSection1:Cell("VLR_SOLIC"   ):SetValue((cAlias1)->VLR_SOLIC)
			oSection1:Cell("VLR_RECUP"   ):SetValue((cAlias1)->VLR_RECUP)
			oSection1:Cell("VLR_MANT"    ):SetValue((cAlias1)->VLR_MANT)
			oSection1:Cell("ANALISTA"    ):SetValue((cAlias1)->ANALISTA)
			

			oSection1:PrintLine()
			
			(cAlias1)->(DbSkip())
		endif
	
	end

	oReport:SkipLine()
	oSection1:Finish()

endif

if Select (cAlias1) > 0
	(cAlias1)->(DbCloseArea())
endif

RestArea(_aArea)

return .T.
