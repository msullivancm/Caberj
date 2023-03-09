#INCLUDE "PROTHEUS.CH"
#INCLUDE "XMLXFUN.CH"
#INCLUDE "UTILIDADES.CH"
#INCLUDE "FILEIO.CH"
                         
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³XML_RDA_PEG ºAutor  ³Leonardo Portella º Data ³  24/08/12   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Confronta a PEG informada com o RDA no arquivo XML.         º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³CABERJ                                                      º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function XML_RDA_PEG
                               
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracao de Variaveis                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

Local cDesc1    := "Este programa tem como objetivo imprimir relatorio "
Local cDesc2	:= "de acordo com os parametros informados pelo usuario."
Local titulo   	:= "Quantidade de arquivos XML..."
Local cDesc3    := titulo
Local cPict     := ""
Local nLin      := 80                                   
//                           10        20        30        40        50        60        70        80        90        100       110       120       130       140       150       160       170       180       190       200       210       220
//                  1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
Local Cabec1    := "RDA       Nome RDA                                          Lote                   Arquivo                                                     Versao    Tipo         Quant.    Dt Reg. Trans."
Local Cabec2    := " "
Local imprime   := .T.
Local aOrd 		:= {}

Private lEnd         := .F.
Private lAbortPrint  := .F.
Private CbTxt        := ""
Private limite       := 220
Private tamanho      := "G"
Private nomeprog     := "XML_RDA_PEG" // Coloque aqui o nome do programa para impressao no cabecalho
Private nTipo        := 18
Private aReturn      := { "Zebrado", 1, "Administracao", 2, 2, 1, "", 1}
Private nLastKey     := 0
Private cbtxt        := Space(10)
Private cbcont       := 00
Private CONTFL       := 01
Private m_pag        := 01
Private wnrel        := nomeprog// Coloque aqui o nome do arquivo usado para impressao em disco
Private cString 	 := ""

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta a interface padrao com o usuario...                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

wnrel := SetPrint(cString,NomeProg,"",@titulo,cDesc1,cDesc2,cDesc3,.T.,aOrd,.T.,Tamanho,,.T.)

If nLastKey == 27
	Return
Endif

SetDefault(aReturn,cString)

If nLastKey == 27
   Return
Endif

nTipo := If(aReturn[4]==1,15,18)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Processamento. RPTSTATUS monta janela com a regua de processamento. ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

Processa({||ProcRel(Cabec1,Cabec2,Titulo,nLin) },'Processando...')

Return

*****************************************************************************************************************

Static Function ProcRel(Cabec1,Cabec2,Titulo,nLin)

Local nI := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

Local nCount 	:= 0
Local cError   	:= ""
Local cWarning 	:= ""
Local oXml 		:= Nil
Local cFile 	:= "" 
Local nX		:= 0 
Local nY		:= 0
Local cPath 	:= ""
Local cPathIni	:= "SERVIDOR\tiss\caixaentrada\_"    
Local cMsg 		:= "Este programa exibe a quantidade de arquivos XML..." + CRLF + CRLF          
Local oException
Local lOk 		:= .T.

Private aFiles 	:= {}
Private aSizes 	:= {}
Private aErros	:= {}    
Private aPrint	:= {}
              
cMsg := "Selecione a pasta os estão os arquivos XML. Estes NÃO PODEM estar compactados!"

oDlgQtdMed := MSDialog():New( 095,232,450,803,"Quantidade de arquivos XML...",,,.F.,,,,,,.T.,,,.T. )

	oGrp1      := TGroup():New( 008,008,064,280,"Descrição",oDlgQtdMed,CLR_BLACK,CLR_WHITE,.T.,.F. )
	oSayT1     := TSay():New( 024,012,{||cMsg}	,oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,270,008)
	                   
	oSay1      := TSay():New( 078,008,{||"Caminho XMLs"},oDlgQtdMed,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,036,008)
	oGet1      := TGet():New( 078,049,{|u| If(PCount()>0,cPath:=u,cPath)},oDlgQtdMed,222,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cPath",,)
	oBtn1      := TButton():New( 078,272,"...",oDlgQtdMed,{||cPath:=cGetFile('','XML',1, cPathIni, .F., GETF_RETDIRECTORY ,.T., .T.)},008,010,,,,.T.,,"",,,,.F. )
	
	oSBtn1     := SButton():New( 150,224,1,{||lOk := .T.,oDlgQtdMed:End()},oDlgQtdMed,,"", )  
					
	oSBtn2     := SButton():New( 150,254,2,{||oDlgQtdMed:End()},oDlgQtdMed,,"", )
	
oDlgQtdMed:Activate(,,,.T.)

If lOk
	nCount 	:= aDir(allTrim(cPath) + "*.xml", aFiles, aSizes)

	ProcRegua(0)
	
	For nX := 1 to 5
		IncProc('Selecionando registros...')
	Next
	
	cQuery := "SELECT BEA_CODRDA,BD5_CODRDA,DECODE(BD5_TIPGUI,'01','CONSULTA','02','SERVIÇOS','-') TIPO_GUIA,DECODE(BEA_TIPO,'1','Consulta','2','SADT','3','Internacao','4','Odontologico') TIPO_MOVIMENTO,BD5_NUMIMP,BEA_CODPEG,BEA_NUMGUI,BEA_LOTGUI,BEA_DTDIGI,BEA_DESOPE,BD5_REGSOL,BD5_NOMSOL,BEA_REGEXE,BEA_NOMEXE,BEA_DTDIGI,BEA_CODRDA,TRIM(BAU_NOME) BAU_NOME,BAU_TIPPE,TRIM(BEA_ARQIMP) BEA_ARQIMP,BEA_LOTGUI,BEA_NOMUSR,BEA_CODLDP,BD5_CODPEG" + CRLF
	//cQuery := "SELECT DISTINCT BD5_CODRDA||';'||BD5_CODPEG||';'||BD5_CODLDP||';'||BD5_ANOPAG||';'||BD5_MESPAG EXCL_PEG_LOTE" + CRLF
	cQuery += "FROM " + RetSqlName('BEA') + " BEA" + CRLF
	cQuery += "INNER JOIN " + RetSqlName('BAU') + " BAU ON BAU.D_E_L_E_T_ = ' ' " + CRLF
	cQuery += "  AND BAU_FILIAL = '" + xFilial('BAU') + "' " + CRLF
	cQuery += "  AND BAU_CODIGO = BEA_CODRDA" + CRLF
	cQuery += "INNER JOIN " + RetSqlName('BD5') + " BD5 ON BD5.D_E_L_E_T_ = ' ' " + CRLF
	cQuery += "  AND BD5_FILIAL = '" + xFilial('BD5') + "' " + CRLF
	cQuery += "  AND BD5_CODPEG = BEA_CODPEG" + CRLF
	cQuery += "  AND BD5_CODRDA = BEA_CODRDA" + CRLF
	cQuery += "  AND BD5_LOTGUI = BEA_LOTGUI" + CRLF
	cQuery += "  AND BD5_NUMERO = BEA_NUMGUI" + CRLF
	cQuery += "WHERE BEA.D_E_L_E_T_ =  ' '" + CRLF
	
	cQuery += "  AND bd5.r_e_c_n_o_ in (4946771,4901666)" + CRLF
	
	cQuery += "  AND BD5_CODOPE = '" + PlsIntPad() + "'" + CRLF
	cQuery += "  AND BD5_DTDIGI LIKE '" + Substr(DtoS(dDataBase),1,6) + "%'" + CRLF
	cQuery += "  AND BAU_TIPPE = 'F'" + CRLF
	cQuery += "  AND BD5_CODLDP = '0002'" + CRLF

	cAlias := GetNextAlias()
	
	TcQuery cQuery New Alias cAlias
	
	nContador 	:= 0
	nTot		:= 0
	
	COUNT TO nTot
	
	ProcRegua(nTot)
	
	cAlias->(DbGoTop())	
	
	cArq := cPath + 'LOG_XML_' + StrTran(DtoC(Date()),'/','') + '_HR' + StrTran(Time(),':','') + '.txt'
		
	FErase(cArq)

	While !cAlias->(EOF())	
	
		IncProc('Processando arquivo ' + cValToChar(++nContador) + ' de ' + cValToChar(nTot))
		
		Do Case
		
			Case empty(cAlias->(BEA_ARQIMP))
				cAlias->(DbSkip())
				aAdd(aErros,'Nome do arquivo XML nao informado')
				loop                   
				
			Case aScan(aFiles,Upper(AllTrim(cAlias->(BEA_ARQIMP))) + '.XML') <= 0 
				cAlias->(DbSkip())
				aAdd(aErros,'XML [' + Upper(AllTrim(cAlias->(BEA_ARQIMP))) + '.XML' + '] nao encontrado na pasta')
				loop
				
			Case !File(cPath + Upper(AllTrim(cAlias->(BEA_ARQIMP))) + '.XML')
				cAlias->(DbSkip())
				aAdd(aErros,'XML [' + cPath + Upper(AllTrim(cAlias->(BEA_ARQIMP))) + '.XML' + '] nao foi possivel abrir o arquivo')
				loop
				
		EndCase
		
		If !File(cArq)
			nHdl := FCreate(cArq)
			
			If nHdl > 0
				FClose(nHdl)
			Else
				Alert('Não foi possível criar o arquivo de log.')
			EndIf 
		Else
        	nHdl := FOpen(cArq,FO_READWRITE + FO_SHARED)
  		EndIf
  		
		FSeek(nHdl, 0, FS_END) // Posiciona no fim do arquivo   
		cEscreve := '- Abrindo XML [' + cPath + Upper(AllTrim(cAlias->(BEA_ARQIMP))) + '.XML' + ']' + CRLF
		FWrite(nHdl,cEscreve,len(cEscreve)) 
		FClose(nHdl)
	
		oXml		:= Nil
		
		//Gera o Objeto XML   
		oXml := XmlParserFile( cPath + Upper(AllTrim(cAlias->(BEA_ARQIMP))) + '.XML', "_", @cError, @cWarning )
		lContinua := Empty(cError) .and. Empty(cWarning) .and. oXml <> Nil   
		
		If !lContinua
			aAdd(aErros,'Arquivo: ' + cPath + Upper(AllTrim(cAlias->(BEA_ARQIMP))) + '.XML' + ' - Erro XmlParserFile ao carregar o arquivo!')
		EndIf
	
		If lContinua

			oXmlChild 	:= XmlGetChild(oXml,1) 
		
			cNameSpace 	:= left(oXmlChild:REALNAME,At(':',oXmlChild:REALNAME) - 1)

			oNode := RetNod(oXmlChild,cNameSpace + ':codigoPrestadorNaOperadora')
		
			If (oNode := RetNod(XmlGetChild(oNode,1),cNameSpace + ':codigoPrestadorNaOperadora')) <> Nil
				cRDA := oNode:TEXT  
				cNomeRDA := AllTrim(Upper(Posicione('BAU',1,xFilial('BAU') + cRDA,'BAU_NOME')))
		    EndIf

		    cMsgPrt := 'RDA XML: ' + cRDA + ' - ' + cNomeRDA + ' - Tipo Guia: ' + AllTrim(cAlias->(TIPO_MOVIMENTO)) + ' - Num. impresso digitado: ' + AllTrim(cAlias->(BD5_NUMIMP)) + ' - PEG : ' + cAlias->(BD5_CODPEG) + ' - RDA PEG: ' + AllTrim(cAlias->(BD5_CODRDA)) + ' - ' + AllTrim(cAlias->(BAU_NOME))
		    aAdd(aPrint,cMsgPrt)
			
		EndIf
	         
		cAlias->(DbSkip())
	
	EndDo	    

EndIf

nCount := len(aPrint)

For nI := 1 to nCount
    
   	IncProc('Imprimindo ' + cValToChar(nI) + ' de ' + cValToChar(nCount))

	@nLin,000 PSAY aPrint[nI]
	nLin++ 

Next

If (nErros := len(aErros)) > 0
    nLin++
	@nLin,000 PSAY Replicate('_',limite)
	nLin++
	@nLin,000 PSAY 'CRÍTICAS'
	nLin++
	@nLin,000 PSAY Replicate('_',limite)
	nLin += 2
	
	For nY := 1 to nErros 
	
		IncProc('Imprimindo erro ' + cValToChar(nY) + ' de ' + cValToChar(nErros))
	
		@nLin,000 PSAY aErros[nY] 
		nLin++			
	Next

EndIf
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Finaliza a execucao do relatorio...                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

SET DEVICE TO SCREEN

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Se impressao em disco, chama o gerenciador de impressao...          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

If aReturn[5]==1
   dbCommitAll()
   SET PRINTER TO
   OurSpool(wnrel)
Endif

MS_FLUSH()

Return

********************************************************************************************************************************

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Retorna a primeira ocorrencia de um node no arquivo Xml.            ³
//³Rotina recursiva que varre do primeiro ao ultimo node, verificando  ³
//³cada node filho. Retorna Nil se nao encontrar a tag ou retorna o    ³
//³objeto node se encotrar.                                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

Static Function RetNod(oXmlBuscar,cRealName)

Local aNos 		:= {}
Local oChild 	:= Nil
Local nCont		:= XmlChildCount(oXmlBuscar)
Local nInc		:= 0

cRealName := AllTrim(Upper(cRealName))

If oXmlBuscar <> Nil

	If AllTrim(Upper(oXmlBuscar:REALNAME)) == cRealName
		oChild := oXmlBuscar
	Else

		For nInc := 1 to nCont
			oChild := XmlGetChild(oXmlBuscar,nInc)

			If AllTrim(Upper(oChild:REALNAME)) == cRealName     
				Exit
			Else
				oChild := RetNod(oChild,cRealName)
				If oChild <> Nil
					Exit
				EndIf
			EndIf

		Next

	EndIf  

	If oChild <> Nil .and. AllTrim(Upper(oChild:REALNAME)) <> cRealName
		oChild := Nil
	EndIf

Else
	oChild := Nil
EndIf

Return oChild

*************************************************************************************************************

Static Function TipoGuia(cNameSpace,oNode)

Local lErro 	:= .F.
Local cTipo 	:= ''
Local cMacro 	:= 'oNode:_' + Upper(cNameSpace) + '_GUIASP_SADT'

If oNode <> Nil

	TRY
		&cMacro
		lErro := .F.
	CATCH
		lErro := .T.
	ENDCATCH 

	If(!lErro,cTipo := 'SP_SADT',)

	If lErro
	   	cMacro 	:= 'oNode:_' + Upper(cNameSpace) + '_GUIARESUMOINTERNACAO'

		TRY
			&cMacro
			lErro := .F.
		CATCH
			lErro := .T.
		ENDCATCH 

		If(!lErro,cTipo := 'INTERNACAO',) 	
	EndIf

	If lErro
		cMacro 	:= 'oNode:_' + Upper(cNameSpace) + '_GUIA_GIH'

		TRY
			&cMacro   
			lErro := .F.
		CATCH
			lErro := .T.
		ENDCATCH 

		If(!lErro,cTipo := 'GIH',)
	EndIf 
	
	If lErro
	
		cMacro 	:= 'oNode:_' + Upper(cNameSpace) + '_GUIACONSULTA'
		
		TRY
			&cMacro
			lErro := .F.
		CATCH
			lErro := .T.
		ENDCATCH 
	
		If(!lErro,cTipo := 'GUIACONSULTA',)
	EndIf 

EndIf

Return cTipo

*************************************************************************************************************
