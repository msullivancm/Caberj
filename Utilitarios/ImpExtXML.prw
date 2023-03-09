#Include "RwMake.ch"
#Include "Protheus.ch"
#define cEnt chr(13)+chr(10)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ ImpCabXML บAutor ณ Frederico O. C. Jr บ Data ณ  28/11/19   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ    Impressใo de cabe็alho do XML dos extratores            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function ImpCabXML(cNome)

Local cDir		:= "\spool\" + AllTrim(cUserName) + "\"
Local aArq		:= cNome + "_" + CriaTrab(,.F.) + ".xml"
Local nHdl		:= 0
Local cData		:= DtoS(DATE())
Local cLinha	:= ""

MontaDir(cDir)

nHdl	:= FCreate(cDir + aArq)

if nHdl <> -1

    cData	:= SubStr(cData,1,4) + '-' + SubStr(cData,5,2) + '-' + SubStr(cData,7,2) + 'T' + TIME() + 'Z'
    
    cLinha := '<?xml version="1.0"?>'															+ cEnt
    cLinha += '<?mso-application progid="Excel.Sheet"?>'										+ cEnt
    cLinha += '<Workbook xmlns="urn:schemas-microsoft-com:office:spreadsheet"'					+ cEnt
    cLinha +=			'xmlns:o="urn:schemas-microsoft-com:office:office"'						+ cEnt
    cLinha +=			'xmlns:x="urn:schemas-microsoft-com:office:excel"'						+ cEnt
    cLinha +=			'xmlns:ss="urn:schemas-microsoft-com:office:spreadsheet"'				+ cEnt
    cLinha +=			'xmlns:html="http://www.w3.org/TR/REC-html40">'							+ cEnt
    cLinha +=		'<DocumentProperties xmlns="urn:schemas-microsoft-com:office:office">'		+ cEnt
    cLinha +=			'<Author>' 		+ cUserName + '</Author>'								+ cEnt
    cLinha +=			'<LastAuthor>' 	+ cUserName + '</LastAuthor>'							+ cEnt
    cLinha +=			'<Created>'		+ cData		+ '</Created>'								+ cEnt
    cLinha +=			'<Version>16.00</Version>'												+ cEnt
    cLinha +=		'</DocumentProperties>'														+ cEnt
    cLinha +=		'<OfficeDocumentSettings xmlns="urn:schemas-microsoft-com:office:office">'	+ cEnt
    cLinha +=			'<AllowPNG/>'															+ cEnt
    cLinha +=		'</OfficeDocumentSettings>'													+ cEnt
    cLinha +=		'<ExcelWorkbook xmlns="urn:schemas-microsoft-com:office:excel">'			+ cEnt
    cLinha +=			'<WindowHeight>7635</WindowHeight>'										+ cEnt
    cLinha +=			'<WindowWidth>20490</WindowWidth>'										+ cEnt
    cLinha +=			'<WindowTopX>32767</WindowTopX>'										+ cEnt
    cLinha +=			'<WindowTopY>32767</WindowTopY>'										+ cEnt
    cLinha +=			'<ProtectStructure>False</ProtectStructure>'							+ cEnt
    cLinha +=			'<ProtectWindows>False</ProtectWindows>'								+ cEnt
    cLinha +=		'</ExcelWorkbook>'															+ cEnt
    cLinha +=		'<Styles>'																	+ cEnt
    cLinha +=			'<Style ss:ID="Default" ss:Name="Normal">'								+ cEnt
    cLinha +=				'<Alignment ss:Vertical="Bottom"/>'									+ cEnt
    cLinha +=				'<Borders/>'														+ cEnt
    cLinha +=				'<Font ss:FontName="Calibri" x:Family="Swiss"'						+ cEnt
    cLinha +=					'ss:Size="11" ss:Color="#000000"/>'								+ cEnt
    cLinha +=				'<Interior/>'														+ cEnt
    cLinha +=				'<NumberFormat/>'													+ cEnt
    cLinha +=				'<Protection/>'														+ cEnt
    cLinha +=			'</Style>'																+ cEnt
    cLinha +=			'<Style ss:ID="data">'													+ cEnt
    cLinha +=				'<NumberFormat ss:Format="dd\/mm\/yyyy;@"/>'						+ cEnt
    cLinha +=			'</Style>'																+ cEnt
    cLinha +=		'</Styles>'																	+ cEnt
    cLinha +=		'<Worksheet ss:Name="' + cNome + '.xml">'									+ cEnt
    cLinha += 			'<Table>'																+ cEnt
    
    FWRITE ( nHdl , cLinha )

endif

return { nHdl, aArq }


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ ImpPriXML บAutor ณ Frederico O. C. Jr บ Data ณ  28/11/19   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ    Impressใo de primeira linha do XML dos extratores 	  บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function ImpPriXML(nHdl, aArray)

Local i			:= 0
Local cLinha	:= ""

if nHdl <> -1 .and. len(aArray) > 0

	cLinha	:= '<Row>'																+ cEnt
    for i := 1 to len(aArray)
    	cLinha += '<Cell><Data ss:Type="String">' + FwNoAccent(aArray[i]) + '</Data></Cell>'	+ cEnt
    next
    cLinha	+= '</Row>'																+ cEnt
    
    FWRITE ( nHdl , cLinha )

endif

return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ ImpLinXML บAutor ณ Frederico O. C. Jr บ Data ณ  28/11/19   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ    Impressใo de linha do XML dos extratores 	 			  บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function ImpLinXML(xCont, nTipo)

Local cLinha	:= ""
Local cData		:= ""

if !empty(xCont)

    if nTipo == 1	// String
    	xCont	:= StrTran( StrTran( StrTran(StrTran(AllTrim(EncodeUTF8(xCont)), "'", "" ), '"', ""), ">", ""), "<", "")
    	cLinha	:= '<Cell><Data ss:Type="String">' +			xCont			+ '</Data>'
    elseif nTipo == 2	// Number
        cLinha	+= '<Cell><Data ss:Type="Number">' + AllTrim(cValToChar(xCont))	+ '</Data>'
    elseif nTipo == 3	// Date
        cData	:= DtoS(xCont)
        if !empty(cData)
            cData	:= SubStr(cData,1,4) + '-' + SubStr(cData,5,2) + '-' + SubStr(cData,7,2) + 'T' + '00:00:00.000Z'
            cLinha	+= '<Cell ss:StyleID="data"><Data ss:Type="DateTime">' + cData + '</Data>'
        endif
    elseif nTipo == 4	// Boolean
        cLinha	+= '<Cell><Data ss:Type="String">' + iif(xCont, 'Verdadeiro', 'Falso') + '</Data>'
    endif
else
    cLinha	:= '<Cell>'
endif

cLinha += '</Cell>' + cEnt

return cLinha



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ ImpRodXML บAutor ณ Frederico O. C. Jr บ Data ณ  28/11/19   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ    Impressใo de rodape do XML dos extratores 	          บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function ImpRodXML(nHdl, cArq)

Local cDir  	:= "\spool\" + AllTrim(cUserName) + "\"
Local cPath 	:= "C:\Extra็๕es\"
Local cLinha 	:= ""

MontaDir(cPath)

if nHdl <> -1

	cLinha :=		'</Table>'																	+ cEnt 
	cLinha +=		'<WorksheetOptions xmlns="urn:schemas-microsoft-com:office:excel">'			+ cEnt 
	cLinha +=			'<PageSetup>'															+ cEnt 
	cLinha +=				'<Header x:Margin="0.31496062000000002"/>'							+ cEnt 
	cLinha +=				'<Footer x:Margin="0.31496062000000002"/>'							+ cEnt 
	cLinha +=				'<PageMargins x:Bottom="0.78740157499999996" x:Left="0.511811024"'	+ cEnt 
	cLinha +=					'x:Right="0.511811024" x:Top="0.78740157499999996"/>'			+ cEnt 
	cLinha +=			'</PageSetup>'															+ cEnt 
	cLinha +=			'<Selected/>'															+ cEnt 
	cLinha +=			'<ProtectObjects>False</ProtectObjects>'								+ cEnt 
	cLinha +=			'<ProtectScenarios>False</ProtectScenarios>'							+ cEnt 
	cLinha +=		'</WorksheetOptions>'														+ cEnt 
	cLinha +=	'</Worksheet>'																	+ cEnt 
	cLinha += '</Workbook>'																		+ cEnt 
	
	FWRITE(nHdl, cLinha)
	
    FCLOSE(nHdl)
    
    // copia o arquivo do servidor para o remote - exclui arquivo no servidor se copair com sucesso
    if CpyS2T(cDir + cArq, cPath, .T.)
    	FErase(cDir + cArq) 
    endif

endif

return cPath + cArq