#INCLUDE "PROTHEUS.CH"
#INCLUDE "XMLXFUN.CH"
#INCLUDE "UTILIDADES.CH"

User Function QtdMedlink
                               
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracao de Variaveis                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

Local cDesc1    := "Este programa tem como objetivo imprimir relatorio "
Local cDesc2	:= "de acordo com os parametros informados pelo usuario."
Local titulo   	:= "Quantidade de arquivos disponibilizados no FTP Medlink"
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
Private nomeprog     := "QTDMEDLINK" // Coloque aqui o nome do programa para impressao no cabecalho
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
Local cMsg 		:= "Este programa exibe a quantidade de arquivos XML disponibilizados pela Medlink." + CRLF + CRLF          
Local lGrava 	:= .F.
Local oException

Private aFiles 	:= {}
Private aSizes 	:= {}
Private aErros	:= {}    
Private aPrint	:= {}
              
cMsg := "Selecione a pasta os estão os arquivos XML. Estes NÃO PODEM estar compactados!"

oDlgQtdMed := MSDialog():New( 095,232,450,803,"Quantidade de arquivos disponibilizados pela Medlink",,,.F.,,,,,,.T.,,,.T. )

	oGrp1      := TGroup():New( 008,008,064,280,"Descrição",oDlgQtdMed,CLR_BLACK,CLR_WHITE,.T.,.F. )
	oSayT1     := TSay():New( 024,012,{||cMsg}	,oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,270,008)
	                   
	oSay1      := TSay():New( 078,008,{||"Caminho XMLs"},oDlgQtdMed,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,036,008)
	oGet1      := TGet():New( 078,049,{|u| If(PCount()>0,cPath:=u,cPath)},oDlgQtdMed,222,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cPath",,)
	oBtn1      := TButton():New( 078,272,"...",oDlgQtdMed,{||cPath:=cGetFile('','XML',1, cPathIni, .F., GETF_RETDIRECTORY ,.T., .T.)},008,010,,,,.T.,,"",,,,.F. )
	
	oCBox1     := TCheckBox():New( 92,008,"Grava a lista dos arquivos na tabela",{|u| If(PCount()>0,lGrava:=u,lGrava)},oDlgQtdMed,148,008,,,,,CLR_BLACK,CLR_WHITE,,.T.,"",, )
	oCBox1:cToolTip := 'Grava a lista dos arquivos na tabela'
	
	oSBtn1     := SButton():New( 150,224,1,{||lOk := .T.,oDlgQtdMed:End()},oDlgQtdMed,,"", )  
					
	oSBtn2     := SButton():New( 150,254,2,{||oDlgQtdMed:End()},oDlgQtdMed,,"", )
	
oDlgQtdMed:Activate(,,,.T.)

nCount 	:= aDir(allTrim(cPath) + "*.xml", aFiles, aSizes)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ SETREGUA -> Indica quantos registros serao processados para a regua ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

ProcRegua(nCount * 2)

For nX := 1 to nCount

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifica o cancelamento pelo usuario...                             ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	
	If lAbortPrint
	    @nLin,00 PSAY "*** CANCELADO PELO OPERADOR ***"
	    Exit
    Endif
    
    //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
    //³ Impressao do cabecalho do relatorio. . .                            ³
    //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

    If nLin > 55 // Salto de Pagina. Neste caso o formulario tem 55 linhas...
       Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
       nLin := 8
    Endif
                                                
	IncProc('Processando arquivo ' + cValToChar(nX) + ' de ' + cValToChar(nCount))
	
	oException 	:= Nil
	oXml		:= Nil
	
	/*
	If aSizes[nX] > 5242880 //5 * 1024 * 1024 B = 5 MB
		lContinua := .F.
	   	aAdd(aErros,'Arquivo: ' + aFiles[nX] + ' - Arquivo muito grande (Possível erro: "XML Dynamic Nodes OVERFLOW")')			
	Else
    */
		TRY
			//Gera o Objeto XML   
			cCounter := aFiles[nX]                             
			oXml := XmlParserFile( cPath + aFiles[nX], "_", @cError, @cWarning )
			lContinua := Empty(cError) .And. Empty(cWarning) .And. oXml <> Nil 
		CATCH
		   lContinua := .F.
		   aAdd(aErros,'Arquivo: ' + aFiles[nX] + ' - Erro ao carregar o arquivo!')
		ENDCATCH	
	
	//EndIf
	
	cNameSpace 	:= ""
	cVersao		:= ""
	cDtRegTrans := ""   
	cNumLote  	:= ""
	cRDA   		:= ""
	cLote   	:= ""
	cTipo		:= ""
	cMacro		:= ""
	aGuias 		:= {}
	nQtd		:= 0
	
	If lContinua

		oXmlChild 	:= XmlGetChild(oXml,1) 
		
		cNameSpace 	:= left(oXmlChild:REALNAME,At(':',oXmlChild:REALNAME) - 1)

	   	If (oNode := RetNod(oXmlChild,cNameSpace + ':versaoPadrao')) <> Nil
			cVersao := oNode:TEXT
		EndIf

		If (oNode := RetNod(oXmlChild,cNameSpace + ':dataRegistroTransacao')) <> Nil
			cDtRegTrans := oNode:TEXT
		EndIf

		If (oNode := RetNod(oXmlChild,cNameSpace + ':numeroLote')) <> Nil
			cNumLote := StrZero(Val(oNode:TEXT),20)
		EndIf

		oNode := RetNod(oXmlChild,cNameSpace + ':codigoPrestadorNaOperadora')
		
		If (oNode := RetNod(XmlGetChild(oNode,1),cNameSpace + ':codigoPrestadorNaOperadora')) <> Nil
			cRDA := oNode:TEXT  
		EndIf
		
		If (oNode := RetNod(oXmlChild,cNameSpace + ':numeroLote')) <> Nil
			cLote := StrZero(Val(oNode:TEXT),20) 
		EndIf

		oNode := RetNod(oXmlChild,cNameSpace + ':guiaFaturamento')
		
		cTipo := TipoGuia(cNameSpace,oNode)
		
		Do Case 
		
			Case cTipo == 'INTERNACAO'
				cMacro		:= "oNode:_" + Upper(cNameSpace) + "_GUIARESUMOINTERNACAO"
				aGuias 		:= &cMacro
				nQtd	 	:= If(ValType(aGuias) == 'A',len(aGuias),1)//ArrayNodes - propriedade que existira quando o no possuir mais de um filho do mesmo tipo
		    
		    Case cTipo == 'SP_SADT'
		    	cMacro		:= "oNode:_" + Upper(cNameSpace) + "_GUIASP_SADT"
		    	aGuias 		:= &cMacro
				nQtd	 	:= If(ValType(aGuias) == 'A',len(aGuias),1)//ArrayNodes - propriedade que existira quando o no possuir mais de um filho do mesmo tipo	
				
			Case cTipo == 'GUIACONSULTA'
		    	cMacro		:= "oNode:_" + Upper(cNameSpace) + "_GUIACONSULTA"
		    	aGuias 		:= &cMacro
				nQtd	 	:= If(ValType(aGuias) == 'A',len(aGuias),1)//ArrayNodes - propriedade que existira quando o no possuir mais de um filho do mesmo tipo	
			
			Otherwise
				aAdd(aErros,'Arquivo: ' + aFiles[nX] + ' - Tipo de guia não identificado ou não mapeado!')
				lContinua := .F.
		
		EndCase

    Else
    	aAdd(aErros,'Arquivo: ' + aFiles[nX] + ' - ' + cError + ' : ' + cWarning)
    	lContinua := .F.
    EndIf       
    
    If lContinua
		aAdd(aPrint,{cRDA,Upper(Posicione('BAU',1,xFilial('BAU') + cRDA,'BAU_NOME')),cNumLote,Upper(aFiles[nX]),cVersao,cTipo,cValToChar(nQtd),cDtRegTrans})
    EndIf        
    
Next

aSort(aPrint,,,{|x,y| x[2] < y[2]})

nCount := len(aPrint)

For nI := 1 to nCount
    
   	IncProc('Imprimindo ' + cValToChar(nI) + ' de ' + cValToChar(nCount))
	
	@nLin,000 PSAY aPrint[nI][1]
   	@nLin,010 PSAY aPrint[nI][2]
   	@nLin,060 PSAY aPrint[nI][3]
   	@nLin,083 PSAY aPrint[nI][4]
   	@nLin,143 PSAY aPrint[nI][5]
	@nLin,153 PSAY aPrint[nI][6]
	@nLin,166 PSAY aPrint[nI][7]
	@nLin,176 PSAY aPrint[nI][8]

	nLin++ 

Next

If (nErros := len(aErros)) > 0
    nLin++
	@nLin,000 PSAY Replicate('_',limite)
	nLin++
	@nLin,000 PSAY 'CRÍTICAS'
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
