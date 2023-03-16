#INCLUDE "APWEBSRV.CH"
#INCLUDE "XMLXFUN.CH"
#INCLUDE "PLSMGER.CH"
#INCLUDE "PROTHEUS.CH"
//#INCLUDE "PLSA973.CH"

// Define
#DEFINE PLSMONEY "@E 99,999,999,999.99"

// Define de nome de arquivos
#DEFINE _cTISTRAN "tissV"+StrTran(TISVERS,".","_")+".XSD"
#DEFINE _cTISGUIA "tissGuiasV"+StrTran(TISVERS,".","_")+".XSD"
#DEFINE _cTISCOMP "tissComplexTypesV"+StrTran(TISVERS,".","_")+".XSD"
#DEFINE _cTISSIMP "tissSimpleTypesV"+StrTran(TISVERS,".","_")+".XSD"
#DEFINE __aCdCri198 {"09Q","Habilita checagem DE/PARA TUSS!"}


// Define de pastas
	STATIC TISVERS 	   := GetNewPar("MV_TISSVER","2.02.03")
	STATIC cSemaforo   := "PLSXML973.SMF"
	STATIC cFileTmp	   := "XMLTMP"
	STATIC cDirRaiz	   := PLSMUDSIS( GetNewPar("MV_TISSDIR","\TISS\") )
	STATIC cDirTemp	   := PLSMUDSIS( cDirRaiz+"TEMP\" )
	STATIC cDirCaiEn   := PLSMUDSIS( cDirRaiz+"CAIXAENTRADA\" )
	STATIC cDirCEBkp   := cDirCaiEn
	STATIC cDirCaiSa   := PLSMUDSIS( cDirRaiz+"CAIXASAIDA\" )
	STATIC cDirProce   := PLSMUDSIS( cDirRaiz+"PROCESSADOS\" )
	STATIC cDirNaPro   := PLSMUDSIS( cDirRaiz+"NAOPROCESSADOS\" )
	STATIC cDirSchema  := PLSMUDSIS( cDirRaiz+"SCHEMAS\" )
	STATIC cDirLog	   := PLSMUDSIS( cDirRaiz+"LOG\" )
	STATIC cDirUpload  := PLSMUDSIS( cDirRaiz+"UPLOAD\")
	STATIC cDirDownld  := PLSMUDSIS( cDirRaiz+"DOWNLOAD\")
	STATIC lOnline 	   := .F.
	STATIC cDirOnl	   := "ONLINE\"
	STATIC cSenha1	   := ""
// Variaveis Static
	STATIC lLog 	  := Iif(GetNewPar("MV_LOGSCHE","1")=="1",.T.,.F.)
	STATIC cPerg	  := "PLS973" + Space(4)
	STATIC lOkXml	  := .T.
	STATIC lProcLog	  := .T.
	STATIC aMatShema  := {}
	STATIC cValHash   := ""
	STATIC aMatCab	  := {}
	STATIC aMatPre	  := {}
	STATIC aMatOpe	  := {}
	STATIC aMatEpi	  := {}
	STATIC aResultado := {}
	STATIC aMatBWT	  := {}
	STATIC aUnMed	  := {}
	STATIC cPrefANS   := Iif(TISVERS < "2.02.02" .OR. TISVERS >= "3" ,"ans:","ansTISS:")
	STATIC lVerTISS   := Iif( AllTrim(TISVERS) >= "2.02.02" .AND. AllTrim(TISVERS) < "3",.T.,.F. )
	STATIC aTipPart   := U_CBRConTPA()
	STATIC aPathTag 	:= {}
	STATIC nHoraBase
	STATIC cHoraBase
	STATIC lWLIO := ( GetNewPar("MV_PLCPXML",'0') == '1' ) .Or. ( GetNewPar("MV_PLCPWEB",'0') == '1' ) .Or. ( GetNewPar("MV_PLCPTON",'0') == '1' )
	STATIC aLibera := {}
	
/*/{Protheus.doc} PLSA973
Importa��o de arquivos XML
#tissver 2.x,3.x

@type Function
@author Alexander Santos
@since 17/05/2007
@version 1.0
/*/
User Function CABA973()
	LOCAL aArea		:= GetArea()
	LOCAL nI		:= 0
	LOCAL aSays     := {}
	LOCAL aButtons  := {}
	LOCAL cCadastro := "Importa��o de Guias no Padr�o TISS"    //"Importa��o de Guias no Padr�o TISS"
	LOCAL aMatDir   := {cDirRaiz,cDirTemp,cDirCaiEn,cDirCaiSa,cDirProce,cDirNaPro,cDirSchema,cDirLog }
	PRIVATE lSxbBXX	:= .T.


// Retorna ao diretorio original
	cDirCaiEn := cDirCEBkp

// Verifica se as pastas base estao criadas e cria
	For nI:=1 To  Len(aMatDir)
		If !ExistDir(aMatDir[nI])
			If MakeDir( aMatDir[nI] ) <> 0
				MsgAlert("Imposs�vel criar diretorio ( "+aMatDir[nI]+" ) ")//"Impossível criar diretorio ( "###" ) "
				Return
			EndIf
		EndIf
	Next

// Says
	AADD(aSays,"Esta op��o permite a importa��o de guias no Padr�o TISS.") //"Esta opção permite a importação de guias no Padrão TISS."
	AADD(aSays,"")
	AADD(aSays,"Clique no bot�o OK para iniciar o processamento") //"Clique no botão OK para iniciar o processamento"
	
	
// Exibe janela de processamento
	If GetRpoRelease()=="R1.1"
		tNewProcess():New("PLSA973","CABESP Importa��o TISS",{|oSelf|u_CabaTiss(cDirCaiEn,oSelf)},cCadastro,"",,.F.,,,.T.,.T. )
	Else

	// Monta botoes para janela de processamento
		AADD(aButtons, { 5,.T.,{|| Pergunte(cPerg,.T. ) } } )
		AADD(aButtons, { 1,.T.,{|| Processa( {|| Pergunte(cPerg,.F. ),PLSA973PRO(cDirCaiEn) },  "Processando Importa��o", "Processando Importa��o",.F. ) } } )//"Processando Importação"###"Processando Importação"
		AADD(aButtons, { 2,.T.,{|| FechaBatch() } } )

	// Exibe janela de processamento
		FormBatch( cCadastro, aSays, aButtons,,250 )
	EndIf

	RestArea(aArea)
Return

/*/{Protheus.doc} PLSA973PRO
Importacao de notas padrao TISS
#tissver 2.x

@type Function
@author Alexander Santos
@since 17/05/2007
@version 1.0
/*/
User Function CABA973PRO(cDirFiles,cDirOnline,lOnL,cSforo,cFTmp,lFileUniq,cTissVerOn)
	LOCAL cCodPeg 		:= MV_PAR01
	LOCAL cCodRda		:= AllTrim(MV_PAR04)
	LOCAL aRet			:= {}
	DEFAULT cDirOnline 	:= cDirOnl
	DEFAULT lOnL	  	:= lOnline
	DEFAULT cSforo      := cSemaforo
	DEFAULT cFTmp       := cFileTmp
	DEFAULT lFileUniq	:= .F.
	DEFAULT cTissVerOn := ""

	If lOnL
		cCodPeg := ""
		cCodRda := ""
	Endif

// Redefine o STATIC
	lOnline   := lOnL
	cSemaforo := cSforo
	cFileTmp  := cFTmp

// Se for on-line redefino as pastas
	If lOnL .And. At(cDirOnline,cDirProce)==0
		cDirOnl		:= cDirOnline
		cDirCaiEn	:= StrTran(cDirCaiEn,cDirRaiz,cDirRaiz+cDirOnl)
		cDirCaiSa	:= StrTran(cDirCaiSa,cDirRaiz,cDirRaiz+cDirOnl)
		cDirProce	:= StrTran(cDirProce,cDirRaiz,cDirRaiz+cDirOnl)
		cDirNaPro  	:= StrTran(cDirNaPro,cDirRaiz,cDirRaiz+cDirOnl)
		cDirLog		:= StrTran(cDirLog,cDirRaiz,cDirRaiz+cDirOnl)
	EndIf

// Se nao for online
	If !lOnline

		Processa( {|| u_CabaTiss(cDirFiles,,lFileUniq,cCodRda) }, "Processando","Aguarde...",.F. )//"Processando"###"Aguarde..."
	Else
		cFileXML := cDirFiles
		cFileDel  := SubStr(SubStr(cFileXml,Rat(PLSMUDSIS("\"),cFileXml)+1,Len(cFileXml)),Rat("_",cFileXml)-Rat(PLSMUDSIS("\"),cFileXml),1)
		aRet := u_CabaTiss(cDirFiles,nil,lFileUniq,cCodRda,nil,nil,nil,cTissVerOn)
	EndIf

Return aRet

/*/{Protheus.doc} u_CabaTiss
Processa a importacao de guias Padrao TISS
#tissver 2.x,3.x

@type Function
@author Alexander Santos
@since 17/03/2007
@version 1.0
/*/
User Function CabaTiss(cDirFiles,oSelf,lFileUniq,cRdaPath,l974,oProcess,cCodPeg,cTissVerBXX,lBg)
	LOCAL nFor,nPos,nX,nI,nY
	LOCAL nQtdFiles   := 0
	LOCAL cFileTISS   := ""
	LOCAL cFileHas	  := ""
	LOCAL cArqRet	  := ""
	LOCAL cMsg		  := ""
	LOCAL cDatHor	  := ""
	LOCAL cMsgCri	  := ""
	LOCAL nIniSeg	  := Seconds()
	LOCAL aFiles      := {}
	LOCAL aAux        := {}
	LOCAL aResGeral   := {}
	LOCAL cOldRaiz    := cDirRaiz
	LOCAL bBlockXml   := nil
	LOCAL cTipoGlosa  := ""
	PRIVATE l974Xml	  := .f.
	DEFAULT lFileUniq := .F.
	DEFAULT oSelf	  := nil
	DEFAULT l974	  := .f.
	DEFAULT oProcess  := nil
	DEFAULT cCodPeg	  := ""
	DEFAULT cTissVerBXX := ""
	DEFAULT lBg			:= .F. //Define se a rotina � utilizada em background. Se for, n�o podemos exibir nenhuma forma de interacao com usuario, como alertas, barras, etc
	If !Empty(cTissVerBXX)
		TISVERS := cTissVerBXX // atualizo a versao da TISS para o arquivo, usado a partir da TISS 3 q desconsidera o parametro MV_TISVER
	EndIf

	l974Xml := l974
	if l974Xml
		lOkXml 	:= .T.
	endIf

// Retorna ao diretorio original
	If !lOnline
		cDirCaiEn := cDirCEBkp
	Endif

// Diretorio informado pelo usuario
	if !l974Xml
		If !Empty(MV_PAR03) .or. lOnline
			If !lOnline
				cDirRaiz   := PLSMUDSIS(AllTrim(MV_PAR03) + Iif(Right(MV_PAR03,1) != PLSMUDSIS('\'),'\',''))
			Endif
			cDirTemp   := PLSMUDSIS(StrTran(cDirTemp,cOldRaiz,cDirRaiz))
			cDirCaiEn  := PLSMUDSIS(StrTran(cDirCaiEn,cOldRaiz,cDirRaiz) + If(!Empty(cRdaPath),cRdaPath + "\" ,""))
			cDirFiles  := PLSMUDSIS(StrTran(cDirFiles,cOldRaiz,cDirRaiz) + If(!Empty(cRdaPath),cRdaPath + "\" ,""))
			cDirCaiSa  := PLSMUDSIS(StrTran(cDirCaiSa,cOldRaiz,cDirRaiz))
			cDirProce  := PLSMUDSIS(StrTran(cDirProce,cOldRaiz,cDirRaiz))
			cDirNaPro  := PLSMUDSIS(StrTran(cDirNaPro,cOldRaiz,cDirRaiz))
			cDirSchema := PLSMUDSIS(StrTran(cDirSchema,cOldRaiz,cDirRaiz))
			cDirLog    := PLSMUDSIS(StrTran(cDirLog,cOldRaiz,cDirRaiz))
			aMatDir    := {cDirRaiz,cDirTemp,cDirCaiEn,cDirCaiSa,cDirProce,cDirNaPro,cDirSchema,cDirLog}

		// Verifica se as pastas base estao criadas e cria
			For	nI:=1 To  Len(aMatDir)
			If !ExistDir(aMatDir[nI])
				If MakeDir( aMatDir[nI] ) <> 0
					If !lOnline .AND. !lBg
						MsgAlert("Imposs�vel criar diretorio ( "+aMatDir[nI]+" ) ")//"Impossível criar diretorio ( "###" ) "
						Return
					Else
						Return {"Imposs�vel criar diretorio ( "+aMatDir[nI]+" ) "}
					Endif
				EndIf
			EndIf
		Next

	ElseIf !Empty(cRdaPath)

		cDirCaiEn := PLSMUDSIS(cDirCaiEn + cRdaPath + "\")
		cDirFiles := PLSMUDSIS(cDirFiles + cRdaPath + "\")
	EndIf
else
	cDirTemp   := PLSMUDSIS(StrTran(cDirTemp,cOldRaiz,cDirRaiz))
	cDirCaiEn  := PLSMUDSIS(StrTran(cDirCaiEn,cOldRaiz,cDirRaiz) + cRdaPath + "\")
	cFileTISS  := PLSMUDSIS(cDirFiles)
	cDirCaiSa  := PLSMUDSIS(StrTran(cDirCaiSa,cOldRaiz,cDirRaiz))
	cDirProce  := PLSMUDSIS(StrTran(cDirProce,cOldRaiz,cDirRaiz))
	cDirNaPro  := PLSMUDSIS(StrTran(cDirNaPro,cOldRaiz,cDirRaiz))
	cDirSchema := PLSMUDSIS(StrTran(cDirSchema,cOldRaiz,cDirRaiz))
	cDirLog    := PLSMUDSIS(StrTran(cDirLog,cOldRaiz,cDirRaiz))
endIf


// Verifica se os arquivos de Schema existem
if !l974Xml
	If !File(cDirSchema+_cTISTRAN)
		cMsg += _cTISTRAN+","
	EndIf
	If !File(cDirSchema+_cTISGUIA)
		cMsg += _cTISGUIA+","
	EndIf
	If !File(cDirSchema+_cTISCOMP)
		cMsg += _cTISCOMP+","
	EndIf
	If !File(cDirSchema+_cTISSIMP)
		cMsg += _cTISSIMP+","
	EndIf
	If !Empty(cMsg)
		If !lOnline .AND. !lBg
			MsgAlert("Arquivo(s) de Schemas n�o encontrado(s) ( "+SubStr(cMsg,1,( Len(cMsg)-1 ) )+" )")//"Arquivo(s) de Schemas não encontrado(s) ( "###" )"
			Return
		Else
			Return {"Arquivo(s) de Schemas n�o encontrado(s) ( "+SubStr(cMsg,1,( Len(cMsg)-1 ) )+" )"}//"Arquivo(s) de Schemas não encontrado(s) ( "###" )"
		EndIf
	EndIf
ENDIF


// Aquivos xml	da caixa de entrada
if !l974Xml
	If !lFileUniq
		aFiles := Directory( cDirFiles+"*.XML" )  //"*.XML"
	Else
		aFiles := Directory( cDirFiles )
	EndIf
	nQtdFiles := Len(aFiles)

	// Verifica se o arquivo de log existe e renomeia
	If File(cDirLog+"XMLLOG.TXT")  //"XMLLOG.TXT"
		cArLgOri := cDirLog+"XMLLOG.TXT"
		If !Empty(mv_par01)
			cArLgDes := AllTrim(cDirLog+"XMLLOG"+PlsIntPad()+MV_PAR01+".TXT")
		Else
			cArLgDes := AllTrim(cDirLog+"XMLLOG"+DtoS(Date())+StrTran(Time(),":","")+".TXT")
		EndIf
		If fREname(cArLgOri,cArLgDes) == -1//"XMLLOG.TXT"
			If !lOnline .AND. !lBg
				MsgAlert("Imposs�vel renomear arquivo de LOG ( XMLLOG.TXT )")//"Impossível renomear arquivo de LOG ( XMLLOG.TXT )"
				Return
			EndIf
		EndIf
	EndIf

	// REGUA
	If !lOnline .AND. !lBg
		If GetRpoRelease()=="R1.1"
			oSelf:SetRegua1(nQtdFiles)
		Else
			ProcRegua(nQtdFiles)
		EndIf
	EndIf
else
	nQtdFiles := 1
endIf

// Carregando
If nQtdFiles > 0
	If (TISVERS < "3")

		// Monta Schemas
		If Len(aMatShema) == 0
			if !l974Xml
				If !lOnline .AND. !lBg
					If GetRpoRelease()=="R1.1"
						oSelf:incRegua1("Aguarde carregando Schemas...") //"Aguarde carregando Schemas..."
					Else
						IncProc("Aguarde carregando Schemas...")  //"Aguarde carregando Schemas..."
						ProcessMessage()
					Endif
				EndIf
			endIf
			aMatShema := u_CBMMATSXD(cCodPeg)
			If !Empty(aMatShema[1])
				If !lOnline .AND. !lBg
					MsgAlert(aMatShema[1])
					Return
				Else
					Return {aMatShema[1]}
				EndIf
			Else
				aMatShema  := aMatShema[2]
				aMatCab	   := {}
				aMatPre	   := {}
				aMatOpe	   := {}
				aMatEpi	   := {}
			EndIf
		EndIF

		// Monta matriz do cabecalho com base no schema
		If Len(aMatCab) == 0
			If ( nPos := aScan( aMatShema,{|x|Upper(x[1])=="CABECALHO"} ) ) > 0
				For nI:=1 To Len(aMatShema[nPos])
					If ValType(aMatShema[nPos,nI]) == "A"
						For nX:=1 To Len(aMatShema[nPos,nI])
							AaDd(aAux,aMatShema[nPos,nI,nX])
						Next
					Else
						AaDd(aAux,aMatShema[nPos,nI])
					EndIf
				Next
				aMatCab := aAux
			Else
				cMsg += "N�o foi poss�vel encontrar o cabe�alho no schema"+Chr(10) //"Não foi possível encontrar o cabeçalho no schema"
			EndIf
		EndIf

		// Monta matriz do operadoraparaprestadro com base no schema
		If Len(aMatOpe) == 0
			If ( nPos := aScan( aMatShema,{|x|Upper(x[1])=="OPERADORAPARAPRESTADOR_OP_CH"} ) ) > 0
				aMatShema[nPos,1] := SubStr(aMatShema[nPos,1],1,Len(aMatShema[nPos,1])-3)
				aMatOpe := aMatShema[nPos]
			Else
				cMsg += "Mensagens da operadora n�o encontrada no schema"+Chr(10)//"Mensagens da operadora não encontrada no schema"
			EndIf
		EndIf

		// Monta matriz do prestadorparaoperadora com base no schema
		If Len(aMatPre) == 0
			If ( nPos := aScan( aMatShema,{|x|Upper(x[1])=="PRESTADORPARAOPERADORA_OP_CH"} ) ) > 0
				aMatShema[nPos,1] := SubStr(aMatShema[nPos,1],1,Len(aMatShema[nPos,1])-3)
				aMatPre := aMatShema[nPos]
			Else
				cMsg += "N�o foi poss�vel encontrar Mensagens do prestador no schema"+Chr(10)  //"Não foi possível encontrar Mensagens do prestador no schema"
			EndIf
		EndIf

		// Monta matriz de epilogo com base no schema
		If Len(aMatEpi) == 0
			If ( nPos := aScan( aMatShema,{|x|Upper(x[1])=="EPILOGO"} ) ) > 0
				aMatEpi := aMatShema[nPos]
			Else
				cMsg += "N�o foi poss�vel encontrar o epilogo no schema"+Chr(10) //"Não foi possível encontrar o epilogo no schema"
			EndIf
		EndIf
	EndIf

	// Processando arquivos xml
	If Empty(cMsg)

		// Carrega Matriz
		If Len(aMatBWT) == 0
			BWT->( DbGoTop() )
			BWT->( DbSeek(Xfilial("BWT")))
			While !BWT->( Eof() ) .AND. xFilial("BWT") == BWT->BWT_FILIAL
				AaDd(aMatBWT,{ BWT->BWT_CODOPE,BWT->BWT_CODPAR,BWT->BWT_CODEDI } )
				BWT->( DbSkip()	)
			EndDo

			// Carrega Matriz
			aUnMed := PLSXBKC()
		EndIf
		if !l974Xml

			// Processamento dos arquivo
			For nFor := 1 To Len(aFiles)

				// Segue no processamento do arquivo
				lOkXml := .T.

				// Nome do arquivo
				cFileTISS := Lower( AllTrim(aFiles[nFor,1]) )

				// Log do arquivo
				u_CABLOGX("Inicio do Processamento ( "+DtoC( Date() )+" - "+Time()+" ) "+" - ["+Iif(!ISSRVUNIX(),"SO Windows","SO Linux")+"]",,.F.)//"Inicio do Processamento ( "###" - "###" ) "
				u_CABLOGX("",,.F.)
				u_CABLOGX("",,.F.)
				u_CABLOGX("Arquivo ("+cFileTISS+" ) ",,.F.) //"Arquivo ("###" ) "
				u_CABLOGX("",,.F.)

				// Verifica se a sequencia foi informada
				cFileSeq := SubStr(SubStr(cFileXml,Rat(PLSMUDSIS("\"),cFileXml)+1,Len(cFileXml)),1,Rat("_",cFileXml)-Rat(PLSMUDSIS("\"),cFileXml)-1)
				If !lOnline // no online isso nao eh necessario pois quem monta o arquivo sou eu
					If Val(cFileSeq) == 0 .or. Len(cFileSeq) > 20 .or. Len(cFileSeq) <= 0
						u_CABLOGX("Numero sequencial no nome do arquivo invalido ( "+cFileTISS+" ) ",.F.)
						cMsg := "Numero sequencial no nome do arquivo invalido ( "+cFileTISS+" ) "
					EndIf
				Endif

				// Verifica delimitador
				cFileHas  := AllTrim( SubStr(SubStr(cFileXml,Rat(PLSMUDSIS("\"),cFileXml)+1,Len(cFileXml)),Rat("_",cFileXml)-Rat(PLSMUDSIS("\"),cFileXml)+1,Rat(".",cFileXml)-Rat("_",cFileXml)-1) )

				If !lOnline// no online isso nao eh necessario pois quem monta o arquivo sou eu
					If cFileDel <> "_"
						u_CABLOGX("Delimitador n�o encontrado no nome do arquivo ( "+cFileTISS+" ) ",.F.)//"Delimitador não encontrado no nome do arquivo ( "###" ) "
						cMsg := "Delimitador n�o encontrado no nome do arquivo ( "+cFileTISS+" ) "
					EndIf
				Endif


				// Vefica hash contido no arquivo
				cFileHas  := AllTrim( SubStr(SubStr(cFileXml,Rat(PLSMUDSIS("\"),cFileXml)+1,Len(cFileXml)),Rat("_",cFileXml)-Rat(PLSMUDSIS("\"),cFileXml)+1,Rat(".",cFileXml)-Rat("_",cFileXml)-1) )
				If Len(cFileHas) <> 32
					u_CABLOGX("Tamanho do hash no nome do arquivo invalido ( "+cFileTISS+"  ",.F.)
				EndIf

				// Processamento
				If lOkXml
					cDatHor := AllTrim(DtoS(aFiles[nFor,3]))+AllTrim(StrTran(aFiles[nFor,4],":",""))
					If !lOnline .AND. !lBg
						If GetRpoRelease()=="R1.1"
							oSelf:incRegua1("Arquivo "+cFileSeq+"...  "+AllTrim(Str((nFor*100)/nQtdFiles,3))+"% conclu�do")//"Arquivo "###"...  "###"% concluído"
						Else
							IncProc("Arquivo "+cFileSeq+"...  "+AllTrim(Str((nFor*100)/nQtdFiles,3))+"% conclu�do")//"Arquivo "###"...  "###"% concluído"
							ProcessMessage()
						Endif
					EndIf
					if !lBg
						aArqRet := ProcFile(cFileTISS,cDatHor,cFileHas)
					Else
						aArqRet := ProcFile(cFileTISS,cDatHor,cFileHas,oProcess,cCodPeg,l974,lBg)
					EndIf
					If ValType(aArqRet)=="A"
						If aArqRet[1] == nil
							lOkXML 	:= .F.
							cArqRet	:= nil
							cMsg		:= aArqRet[2]
						Else
							cArqRet	:= aArqRet[1]
							cMsg		:= ""
						Endif
					Endif
				Else
					If Empty(cMsg)
						cMsg := "Nenhum arquivo XML encontrado para processamento" //"Nenhum arquivo XML encontrado para processamento"
					Endif
					PLSGRVARQ(cFileTISS,cCodPeg)
				EndIf

				// Log de Termino
				u_CABLOGX("",,.F.)
				u_CABLOGX("Fim do Processamento ( "+Time()+" ) Dura��o ( "+AllTrim( Str( (Seconds()-nIniSeg)/60,12,3) )+" )",,.F.) //"Fim do Processamento ( "###" ) Duração ( "
				u_CABLOGX("",,.F.)

				// Verifica retorno
				For nY:=1 To Len(aResultado)
					AaDd(aResGeral,aResultado[nY])
				Next
				aResultado := {}
			Next
		else
			aArqRet := ProcFile(cFileTISS,cDatHor,cFileHas,oProcess,cCodPeg,l974,lBg)
			If ValType(aArqRet)=="A"
				If aArqRet[1] == nil
					lOkXML 	:= .F.
					cArqRet	:= nil
					cMsg		:= aArqRet[2]
				Else
					cArqRet	:= aArqRet[1]
					cMsg		:= ""
				Endif
			Endif
		endIf
	Else
		If !lOnline .AND. !lBg
			MsgAlert(cMsg)
			Return
		Else
			Return {cMsg}
		EndIf
	EndIf

	if !l974Xml

		//Resultado
		If nQtdFiles == 0 .And. !lOnline .AND. !lBg
			PutHelp("PPLSA973FIL",{"N�o foi encontrado arquivos no    ", "diret�rio informado."},{},{},.f.)//"Não foi encontrado arquivos no    "###"diretório informado."
			PutHelp("SPLSA973FIL",{"Confira o diret�rio    ","informado."},{},{},.f.)//"Confira o diretório    "###"informado."
			Help("",1,"PLSA973FIL")
		Else

			// LOG em arquivo
			If lLog
				For nI:=1 To Len(aResGeral)
					PLSLOGFIL( aResGeral[nI,1],cDirLog+"XMLLOG.TXT" )  //"XMLLOG.TXT"

					If lOnline
						If aResGeral[nI,2] == 4
							cMsg += AllTrim(aResGeral[nI,1])+", "
						EndIf

						If aResGeral[nI,4]
							If 'NUM. GUIA PRESTADOR' $ AllTrim(aResGeral[nI,1])
								cMsgCri += Chr(13) + AllTrim(StrTran(aResGeral[nI,1],"Tiss    -","") ) + Chr(13) + Chr(13)
							Else
								cMsgCri += AllTrim(StrTran(aResGeral[nI,1],"Tiss    -","") ) + Chr(13)
							EndIf
						EndIf

						If !Empty(aResGeral[nI,5])
							cTipoGlosa := aResGeral[nI,5]
						EndIf
					EndIf
				Next
				cMsg := Left(cMsg,Len(cMsg)-2)
			EndIf

			//Marca como processado - RDA E ARQUIVO
			If lOkXml .And. !Empty(MV_PAR04)
				PLSXMLPRO(MV_PAR04,cFileTISS)//BXX_STATUS=3=Processado
			EndIf

			//Mostra as criticas
			If !lOnline .AND. !lBg
				PlsCriGen(aResGeral, { {"Status","@C",1000} } , "  Resultado ",,,,,,,,,,,,,,,,,,,,TFont():New("Courier New",7,14,,.F.,,,,.F.,.F.))	     //"Status"###"  Resultado "
			EndIf
		Endif
	endIf
Else
	If !lOnline .AND. !lBg
		MsgAlert("Nenhum arquivo XML encontrado para processamento")//"Nenhum arquivo XML encontrado para processamento"
	Else
		cMsg := "Nenhum arquivo XML encontrado para processamento"  //"Nenhum arquivo XML encontrado para processamento"
	EndIf
EndIf
if !l974Xml
	If !lOnline .AND. !lBg
		If GetRpoRelease()=="R1.1" .and. lArqTiss
			oSelf:SaveLog("Processamento XML Realizado!")
		Endif
	EndIf
endIf

Return {cMsg,cArqRet,cMsgCri,lOkXML,cTipoGlosa}

/*/{Protheus.doc} ProcFile
Processa a importacao do XML
#tissver 2.x,3.x

@type Function
@author Alexander Santos
@since 17/03/2007
@version 1.0
/*/
static Function ProcFile(cFileTISS,cDatHor,cFileHas,oProcess,cCodPeg,l974,lBg)
	LOCAL nI,nY,nPos,nH,nPos2
	LOCAL oXml      := NIL
	LOCAL lCriDir	:= .T.
	LOCAL cArqRet   := ""
	LOCAL cNameSpace:= ""
	LOCAL cNameEleme:= ""
	LOCAL cErro  	:= ""
	LOCAL cAviso 	:= ""
	LOCAL cXmlLay   := ""
	LOCAL cCodRda   := ""
	LOCAL cFileGrv	:= ""
	LOCAL cStrNew	:= ""
	LOCAL cEncod 	:= ""
	LOCAL aRet		:= {}
	LOCAL aMatXCab	:= {}
	LOCAL aMatXPre	:= {}
	LOCAL aMatXEpi	:= {}
	LOCAL aMatAux	:= {}
	LOCAL bBlockXml   := nil
	LOCAL I			:=0
	Local cDirBCon	:= ""
	Local cNomArC		:= ""
	DEFAULT cFileHas:= ""
	DEFAULT cDatHor := ""
	DEFAULT cCodPeg	:= ""
	DEFAULT l974	:= .F.
	DEFAULT lBg		:= .F.


// Abre o arquivo
	cFileSeq := SubStr(SubStr(cFileTISS,Rat(PLSMUDSIS("\"),cFileTISS)+1,Len(cFileTISS)),1,Rat("_",cFileTISS)-Rat(PLSMUDSIS("\"),cFileTISS)-1)
	cFileDel := SubStr(SubStr(cFileTISS,Rat(PLSMUDSIS("\"),cFileTISS)+1,Len(cFileTISS)),Rat("_",cFileTISS)-Rat(PLSMUDSIS("\"),cFileTISS),1)
	cFileHas := AllTrim( SubStr(SubStr(cFileTISS,Rat(PLSMUDSIS("\"),cFileTISS)+1,Len(cFileTISS)),Rat("_",cFileTISS)-Rat(PLSMUDSIS("\"),cFileTISS)+1,Rat(".",cFileTISS)-Rat("_",cFileTISS)-1) )
	//Algumas vezes o arquivo n�o��copiado corretamente para a caixa de entrada. Desta forma, iremos verificar se existe na pasta e se n�o, copiar do banco de Conhecimento 
	//para a caixa de entrada
	If ( !File(cDirCaiEn+cFileSeq+cFileDel+cFileHas+".xml") )
		cDirBCon := PLSMUDSIS(MsDocPath()+"\")  //pego diret? do Banco de Conhecimento
		cNomArC  := cFileSeq + cFileDel + cFileHas+".xml"
		
		//Verifico se a pasta do prestador existe na caixa de entrada. Se n�o, crio novamente.
		if !ExistDir(cDirCaiEn)
			If MakeDir( cDirCaiEn ) <> 0
				if !lOnline .AND. !lBg
					msgstop("N�o�foi poss�vel criar arquivo ( " + cNomArC + " ) na Caixa de Entrada da pasta TISS. O processo ser�interrompido.")  //"N�o�foi poss�vel criar arquivo ( " -  " ) na Caixa de Entrada da pasta TISS. O processo ser�interrompido."
				Else
					QOut("N�o�foi poss�vel criar arquivo ( " + cNomArC + " ) na Caixa de Entrada da pasta TISS. O processo ser�interrompido.")	//"N�o�foi poss�vel criar arquivo ( " -  " ) na Caixa de Entrada da pasta TISS. O processo ser�interrompido."
				EndIf
				Return nil
			EndIf
		EndIf
			
		//Insiro o arquivo na pasta			
		If ( File(cDirBCon + cNomArC ) )
			__CopyFile( cDirBCon+cNomArC , cDirCaiEn+cNomArC )
		Elseif !lOnline .AND. !lBg
			msgstop("Arquivo (" + cNomArC + ") n�o�existe na Caixa de Entrada da pasta TISS e Banco de Conhecimento." )  //"#Arquivo (" - ") n�o�existe na Caixa de Entrada da pasta TISS e Banco de Conhecimento."
			Return nil
		Else
			QOut("Arquivo (" + cNomArC + ") n�o�existe na Caixa de Entrada da pasta TISS e Banco de Conhecimento.")	//"#Arquivo (" - ") n�o�existe na Caixa de Entrada da pasta TISS e Banco de Conhecimento."
			Return nil
		EndIf
	EndIf
				
	oXml := XmlParserFile(cDirCaiEn+cFileSeq+cFileDel+cFileHas+".xml","_",@cErro,@cAviso)
	If !Empty(cErro)
		If !lOnline .AND. !lBg
			msgstop(cErro)
		Else
			QOut(cErro)
		Endif
		return nil
	Endif
	If !Empty(cAviso)
		If !lOnline .AND. !lBg
			msgstop(cAviso)
		Else
			QOut(cErro)
		Endif
		return nil
	Endif
	cEncod := SubStr(MemoRead(cDirCaiEn+cFileTISS),20,30)
	If ( nPos := At( 'utf',Lower(cEncod) ) ) > 0
		cEncod := Upper(SubStr(cEncod,nPos,5))
	ElseIf ( nPos := At( 'iso',Lower(cEncod) ) ) > 0
		cEncod := Upper(SubStr(cEncod,nPos,10))
	Else
		cEncod	:= "ISO-8859-1"
	EndIf

	aMatAux 	:= classDataArr(oXml)
	nPos 		:= ( At("_",SubStr( aMatAux[Len(aMatAux),1],2 ) )+1 )
	cNameSpace 	:= Upper( SubStr( aMatAux[Len(aMatAux),1],1,nPos ) )
	cNameEleme 	:= Upper( SubStr( aMatAux[Len(aMatAux),1],(nPos+1) ) )

// Estrutura bruta
	oObjXml := XmlChildEx(oXml,cNameSpace+cNameEleme)

// Verifica cabecalho
	If XmlNodeExist(oObjXml,cNameSpace+"CABECALHO")
		If ValType( &( "oObjXml:"+cNameSpace+"CABECALHO" ) ) == "O"
			aAux := u_CBMONSTR( u_CBSAJMAT(cNameSpace, classDataArr( &( "oObjXml:"+cNameSpace+"CABECALHO" ) ) ) ,Len(cNameSpace) )
			AaDd( aMatXCab,"CABECALHO" )
			For nI:=1 To Len(aAux)
				AaDd(aMatXCab,aAux[nI])
			Next
		EndIf
	EndIf

// Verifica Mensagem
	If XmlNodeExist(oObjXml,cNameSpace+"PRESTADORPARAOPERADORA")
		If ValType( &( "oObjXml:"+cNameSpace+"PRESTADORPARAOPERADORA" ) ) == "O"
			aMatXPre := { "PRESTADORPARAOPERADORA",u_CBMONSTR( u_CBSAJMAT(cNameSpace, classDataArr( &( "oObjXml:"+cNameSpace+"PRESTADORPARAOPERADORA" ) ) ) ,Len(cNameSpace) )[1] }
		EndIf
	EndIf

// Verifica Epilogo
	If XmlNodeExist(oObjXml,cNameSpace+"EPILOGO")
		If ValType( &( "oObjXml:"+cNameSpace+"EPILOGO" ) ) == "O"
			aMatXEpi := { "EPILOGO",u_CBMONSTR( u_CBSAJMAT(cNameSpace, classDataArr( &( "oObjXml:"+cNameSpace+"EPILOGO" ) ) ) ,Len(cNameSpace) )[1] }
		EndIf
	EndIf

// Não tem erros na matriz static aresultado continua
	lSlvOk := lOkXml
	If lOkXml

// Processamento
		lSlvOk := lOkXml
		If (TISVERS >= "3")

// Monta um array do arquivo XML com as tags seus caminhos e valores
			aMatAux := u_CXMLTOARR(aMatAux)
		EndIf
		If lOnline .AND. GetNewPar("MV_PLVLTOEX",.F.)
		// Esse tratamento de se da para valida磯 do arquivo de importa磯 da Tiss-on-line
		// Para que o sistema verifique se ja foi importado o arquivo
		
			ccTexto:="" // Validando Hash
			For i:=1 to (len(aMatAux)-1)
				If at("nSeqGui",aMatAux[i,3])=0
					ccTexto+=Alltrim(aMatAux[i,3])
				Endif
			Next
			ccTexto:=md5(ccTexto)
		
			If cFileHas <> ccTexto // Validando Hash
				return({nil,EncodeUtf8("Hash invalido   ")})	//"Hash invᬩdo, Diferen硠entre informado e a valida磯 do conteu?o"
			Endif
		 
			If ( nPos1 := aScan( aMatAux,{|x|Upper(x[1])=="NUMEROGUIAPRESTADOR"} ) ) > 0
				aAreaBD5		:= BD5->(GetArea())
				aAreaBE4		:= BE4->(GetArea())
				aAreaBA1		:= BA1->(GetArea())

				cNumGuiaPrest	:= aMatAux[nPos1,3]
				nPos2 := aScan( aMatAux,{|x|Upper(x[1])=="NUMEROCARTEIRA"} )
				If nPos2 > 0
					cNumCarteira := u_cbMatValida(aMatAux[nPos2,3], "")
				Else
					cNumCarteira := ""
				EndIf

			// n㯠podem haver os caracteres > e < nas mensagens do tiss Online, se tiver, ele vai bagun硲 o retorno, pq vamos achar que uma tag come篵/fechou indevidamente

				If !Empty(cNumCarteira)
			
					BA1->(dbSetOrder(2))
					If !BA1->(DbSeek(xFilial("BA1")+cNumCarteira))
						QOut("Matricula do usuario invalida  -> ( ")
						return({nil,EncodeUtf8("Matricula do usuario invalida")}) //"Matricula do usuario invalida"}) //"Matricula do usuario invalida  -> ( "
					Endif
			
					BD5->(dbSetOrder(6))
					If BD5->(DbSeek(xFilial("BD5")+cNumGuiaPrest))
						QOut("Lote de guia XML j� importado para esta RDA!")
						return({nil,EncodeUtf8("Lote de guia XML j� importado para esta RDA!")})	//"Lote de guia XML jᠩmportado para esta RDA!"
					Endif

				
					BE4->(dbSetOrder(6))
					If BE4->(DbSeek(xFilial("BE4")+cNumGuiaPrest))
						QOut("Lote de guia XML j� importado para esta RDA!")
						return({nil,EncodeUtf8("Lote de guia XML j� importado para esta RDA!")})	//"Lote de guia XML jᠩmportado para esta RDA!"
					Endif
				
					cAliasTrb :=GetNextAlias()
					BeginSql Alias cAliasTrb
						SELECT BCI_ARQUIV FROM %table:BCI% BCI WHERE BCI.BCI_FILIAL = %exp:xFilial("BCI")%  AND BCI.BCI_ARQUIV in  (%exp:cFileTISS%)    AND BCI.%notDel%
					Endsql
					If (cAliasTrb)->(!Eof())
						QOut("Lote de guia XML j� importado para esta RDA!")
						(cAliasTrb)->(DbCloseArea())
						return({nil,EncodeUtf8("Lote de guia XML j� importado para esta RDA!")}) //"Lote de guia XML jᠩmportado para esta RDA!"
					Else
						(cAliasTrb)->(DbCloseArea())
					Endif
				Else
					return({nil,EncodeUtf8("Matricula do usuario invalida")}) //"Matricula do usuario invalida  -> ( "
				Endif
				RestArea(aAreaBA1)
				RestArea(aAreaBD5)
				RestArea(aAreaBE4)
			Endif
		
		Endif

		aRet := u_CBTPTRAN(cFileTISS,cDatHor,aMatXCab,aMatXPre,aMatXEpi,cFileHas,oProcess,cCodPeg,lSlvOk,aMatAux, lBg, l974Xml)
		If Empty(aRet[1])
			lSlvOk := .F.
		Endif
	EndIf

// Processamento com controle de transa��o
	If lSlvOk
		if !l974Xml
			If !lOnline .AND. !lBg
				If GetRpoRelease()=="R1.1"
					oSelf:incRegua1("Preparando arquivo de retorno...")
				Else
					IncProc("Preparando arquivo de retorno...")
					ProcessMessage()
				Endif
			Endif
			nH := PLSAbreSem(cSemaforo)
			FErase(PLSMUDSIS(cDirTemp+cFileTmp))
		//Se o retorno do u_CBTPTRAN tiver somente uma posicao no array pode ser o xml de retorno caso o cliente mude a funcao da validacao na BVR
			If ExistBlock("PLSOBSXML")
				cArqRet := u_CBPROCRES(aRet,cEncod,,,,,,,,,aMatAux)
			ElseIf (TISVERS >= "3" .AND. Len(aRet) == 1)
				cArqRet := aRet[1]
			Else
				cArqRet := u_CBPROCRES(aRet,cEncod,,,,,,,,,aMatAux, aRet[9])
			EndIf
			PLSFechaSem(nH,cSemaforo)
		endIf
	EndIf

// Verfica se a pasta existe e processamento e move para processado ou nao
	PLSGRVARQ(PLSMUDSIS(cFileTISS),cCodPeg)

	oXml := nil
	oObjXml := nil
	DelClassIntF()

Return({cArqRet,''})

/*/{Protheus.doc} u_CABLOGX
Ajusta matriz bruta
cTipoGlosa reprasenta o SimpleType dm_tipoGlosa

#tissver 2.x

@type Function
@author Alexander Santos
@since 12/05/2007
@version 1.0
/*/
User Function CABLOGX(cMsg,lXml,lTpCri,lCrit,cTipoGlosa)
	LOCAL nTpCri  	:= 0
	DEFAULT lTpCri 	:= .T.
	DEFAULT lXml	:= .T.
	DEFAULT lCrit	:= .F.

// Retira abertura e fechamento de tag xml
	cMsg := StrTran(StrTran(StrTran(cMsg,'->','-'),'<',' '),'>',' ')

// Variavel que define o processamento de um arquivo
	If lOkXml
		lOkXml := lXml
	EndIf

// Defini se a critica e fatal ou informativa
	If lTpCri
		If lXml
			nTpCri := 2
		Else
			nTpCri := 4
		EndIf

	// Ajusta informacao de criticas
		If nTpCri <> 0 .And. AsCan( aResultado,{|x|x[2] == nTpCri} ) == 0
			If nTpCri == 2
				AaDd(aResultado, { "",1,Len(aResultado),lCrit,cTipoGlosa } )
				AaDd(aResultado, { "***** Informa��es *****",1,Len(aResultado),lCrit,cTipoGlosa } ) //"***** Informações *****"
				AaDd(aResultado, { "",1,Len(aResultado),lCrit,cTipoGlosa } )
			Else
				AaDd(aResultado, { "",3,Len(aResultado),lCrit,cTipoGlosa } )
				AaDd(aResultado, { "***** Tipo de critica que n�o processa o arquivo *****",3,Len(aResultado),lCrit,cTipoGlosa } ) //"***** Tipo de critica que não processa o arquivo *****"
				AaDd(aResultado, { "",3,Len(aResultado),lCrit,cTipoGlosa } )
			EndIf
		EndIf
	EndIf

// Alimenta a matriz de log
	AaDd(aResultado, { cMsg,nTpCri,Len(aResultado),lCrit,cTipoGlosa } )

Return

/*/{Protheus.doc} u_CBSAJMAT
Ajusta matriz bruta
#tissver 2.x

@type Function
@author Alexander Santos
@since 12/05/2007
@version 1.0
/*/
User Function CBSAJMAT(cNameSpace,aMat)
	LOCAL nI
	LOCAL aMatAux := {}

// Ajusta matriz com base no elementname
	For nI:=1 To Len(aMat)
		If At(cNameSpace,aMat[nI,1]) > 0
			AaDd(aMatAux,aMat[nI])
		EndIf
	Next

Return(aMatAux)

/*/{Protheus.doc} u_CBMMATSXD
Monta matriz geral dos elementos do schema
#tissver 2.x,3.x

@type Function
@author Alexander Santos
@since 12/05/2007
@version 1.0
/*/
User Function CBMMATSXD(cCodPeg)
	LOCAL nI,nY
	LOCAL cErro	    := ""
	LOCAL aMTisTran	:= {}
	LOCAL aMTisGuia := {}
	LOCAL aMTisComp := {}
	LOCAL aMTisSimp := {}
	LOCAL aMatTiss  := {}
	LOCAL bBlockXml   := nil
	DEFAULT cCodPeg := ""


// Tratamento dos tipos complexos
	aMTisTran := u_cbMONXSD(cDirSchema+_cTISTRAN,cCodPeg)
	cErro	  := aMTisTran[1]
	If Empty(cErro)
		aMTisGuia := u_cbMONXSD(cDirSchema+_cTISGUIA,cCodPeg)
		cErro	  := aMTisGuia[1]
		If Empty(cErro)
			aMTisComp := u_cbMONXSD(cDirSchema+_cTISCOMP,cCodPeg)
			cErro     := aMTisComp[1]
			If Empty(cErro)
				aMTisSimp := u_cbMONXSD(cDirSchema+_cTISSIMP,cCodPeg)
				cErro     := aMTisSimp[1]
			EndIf
		EndIf
	EndIf

// Monta matriz guias tiss
	If Empty(cErro)
		For nI:=1 To Len(aMTisTran[2])
			aMatTiss := u_CBMATGUI(aMTisTran[2,nI],aMTisTran[2],aMTisGuia[2],aMTisComp[2],aMTisSimp[2],cCodPeg)
		Next
	EndIf

// Ordena
	If Len(aMatTiss) > 0
		aMatTiss := aSort( aMatTiss[2],,, { |x, y| x[1] < y[1] } )
	Endif

// LogFil das Transacoes
	If lLog .And. Empty(cDirOnl) .And. !File(cDirLog+"GUIAS.TXT")  //"GUIAS.TXT"
		PLSLOGFIL( "MENSAGEMTISS" , cDirLog+"GUIAS.TXT" )  //"GUIAS.TXT"
		cTab := Space(2)
		For nI:=1 To Len(aMatTiss)
			aMatNiv := aMatTiss[nI]
			PLSLOGFIL( "-----------------------------------------------------" , cDirLog+"GUIAS.TXT" )  //### //"-----------------------------------------------------"###"GUIAS.TXT"
			u_cbIMPGT( aMatNiv,cTab )
		Next
	EndIf

Return( { cErro,aMatTiss } )

/*/{Protheus.doc} u_CBMATGUI
Monta matriz tiss
#tissver 2.x,3.x

@type Function
@author Alexander Santos
@since 15/05/2007
@version 1.0
/*/
User Function CBMATGUI(aMat,aMatT,aMatG,aMatC,aMatS,cCodPeg)
	LOCAL nI
	LOCAL lCh		:= .F.
	LOCAL cString	:= ""
	LOCAL cStringP	:= ""
	DEFAULT cCodPeg   := ""

// Monta matriz de elementos
	If ValType(aMat) == "A"
		For nI:=1 To Len(aMat)
			If ValType(aMat[nI]) <> "A"
				cString := aMat[nI]
				If At(cPrefANS,cString) > 0 .Or. At(":ct",cString) > 0
					cStringP := SubStr( cString,Iif(lVerTISS,9,5),Len(cString) )
					lCh 	 := .F.
					aMatAux  := u_CBFINDTIS( cStringP,aMatT,aMatG,aMatC,aMatS,@lCh,cCodPeg )
					If Len(aMatAux) == 1 .And. ValType(aMatAux[1]) == "A"
						aMatAux := aMatAux[1]
					EndIf
					If lCh .And. nI>1
						aMat[(nI-1)] += "_CH"
					EndIf
					If lCh .And. Len(aMat)>=(nI+1) .and. ValType(aMat[(nI+1)]) == "A"
						aMat[(nI+1),1] += "_NC"
					EndIf
					aMat[nI] := aMatAux
					u_CBMATGUI( aMat[nI],aMatT,aMatG,aMatC,aMatS,cCodPeg )
				EndIf
			Else
				u_CBMATGUI( aMat[nI],aMatT,aMatG,aMatC,aMatS,cCodPeg )
			EndIf
		Next
	EndIf

Return(aMat)

/*/{Protheus.doc} u_CBFINDTIS
Acha a descricao na matriz
#tissver 2.x,3.x

@type Function
@author Alexander Santos
@since 15/05/2007
@version 1.0
/*/
User Function CBFINDTIS(cDescri,aMatT,aMatG,aMatC,aMatS,lCh,cCodPeg)
	LOCAL nI,nY
	LOCAL cString := ""
	LOCAL cStringP:= ""
	LOCAL nPos 	  := 0
	LOCAL nPosCh  := 0
	LOCAL aRetMat := {}
	LOCAL aRetAux := {}
	LOCAL aMatAux := {}
	LOCAL bBlockXml   := nil
	DEFAULT lCh   := .F.
	DEFAULT cCodPeg := ""

// Verifica qual tabela
	Do Case
	Case ( (nPos := aScan( aMatT,{|x|AllTrim(x[1])==AllTrim(cDescri) } ) ) > 0) .Or. ( lCh := ( ( nPosCh := aScan( aMatT,{|x|AllTrim(x[1])==AllTrim(cDescri+"_CH") } ) ) > 0 ) )
		If lCh
			cDescri += "_CH"
			nPos 	  := nPosCh
		EndIf
		aMatAux := aMatT[ nPos ]
	Case ( (nPos := aScan( aMatG,{|x|AllTrim(x[1])==AllTrim(cDescri) } ) ) > 0) .Or. ( lCh := ( ( nPosCh := aScan( aMatG,{|x|AllTrim(x[1])==AllTrim(cDescri+"_CH") } ) ) > 0 ) )
		If lCh
			cDescri += "_CH"
			nPos 	  := nPosCh
		EndIf
		aMatAux := aMatG[ nPos ]
	Case ( (nPos := aScan( aMatC,{|x|AllTrim(x[1])==AllTrim(cDescri) } ) ) > 0) .Or. ( lCh := ( ( nPosCh := aScan( aMatC,{|x|AllTrim(x[1])==AllTrim(cDescri+"_CH") } ) ) > 0 ) )
		If lCh
			cDescri += "_CH"
			nPos 	  := nPosCh
		EndIf
		aMatAux := aMatC[ nPos ]
	Case ( (nPos := aScan( aMatS,{|x|AllTrim(x[1])==AllTrim(cDescri) } ) ) > 0) .Or. ( lCh := ( ( nPosCh := aScan( aMatS,{|x|AllTrim(x[1])==AllTrim(cDescri+"_CH") } ) ) > 0 ) )
		If lCh
			cDescri += "_CH"
			nPos 	  := nPosCh
		EndIf
		aMatAux := aMatS[ nPos ]
	OtherWise
		u_CABLOGX("Elemento n�o encontrado-> "+cDescri,.F.)// "Elemento não encontrado-> "
	EndCase

// Localiza texto na matriz
	If nPos > 0
		For nI:=1 To Len(aMatAux)
			If ValType(aMatAux[nI]) <> "A"
				If aMatAux[nI] <> cDescri
					cString := aMatAux[nI]
					If At(cPrefANS,cString) == 0
						AaDd( aRetMat, cString )
					Else
						cStringP := SubStr(cString,Iif(lVerTISS,9,5),Len(cString))
						aRetAux  := u_CBFINDTIS(cStringP,aMatT,aMatG,aMatC,aMatS,lCh)
						If Len(aRetAux) == 1 .And. ValType(aRetAux[1]) == "A"
							aRetAux	:= aRetAux[1]
						EndIf
						If Len(aRetMat) > 0 .And. ValType( aRetMat[Len(aRetMat)] ) == "A"
							AaDd( aRetMat[Len(aRetMat)], aRetAux )
						Else
							AaDd( aRetMat, aRetAux )
						EndIf
					EndIf
				EndIf
			Else
				AaDd( aRetMat, aMatAux[nI] )
			EndIf
		Next
	EndIf

Return(aRetMat)

/*/{Protheus.doc} u_cbIMPGT
Gera a estrutura em arquivo para conferencia com xsd
#tissver 2.x,3.x

@type Function
@author Alexander Santos
@since 22/05/2007
@version 1.0
/*/
USer Function cbIMPGT(aMat,cTab)
	LOCAL nX
	LOCAL aAux := {}

// For para gravar a estrutura no aruqivo
	For nX:=1 To Len(aMat)
		If ValType(aMat[nX]) <> "A"
			PLSLOGFIL( Upper(cTab+aMat[nX]) , cDirLog+"GUIAS.TXT" )  //"GUIAS.TXT"
		Else
			aAux := aMat[nX]
			u_cbIMPGT(aAux,(cTab+Space(2)))
		EndIf
	Next

Return

/*/{Protheus.doc} u_CBCHKNODE
Checa se um elemento existe no objeto
#tissver 2.x

@type Function
@author Alexander Santos
@since 22/05/2007
@version 1.0
/*/
User Function CBCHKNODE(oObj,cElemento,cCodPeg)
	LOCAL nPos
	LOCAL cEleAux := ""
	LOCAL lRet	  := .T.
	LOCAL bBNode  := NIL
	LOCAL cEleOld := cElemento
	DEFAULT cCodPeg := ""

// Ajusta String
	cElemento += ":"

// While para verificar o no
	While ( nPos := ( At(":",cElemento)-1 ) ) > 1 .And. lRet

		cEleAux   := SubStr(cElemento,1,nPos)
		cElemento := SubStr(cElemento,(nPos+2),Len(cElemento))

		If !Empty(cEleAux)
			If ValType(oObj) == "O"
				If Eval( &( "{|| XmlNodeExist(oObj,'"+cEleAux+"') } " ) )
					oObj := XmlChildEx( oObj , cEleAux )
				Else
					lRet := .F.
				EndIf
			Else
				lRet := .F.
			EndIf
		EndIf

	EndDo

Return(lRet)

/*/{Protheus.doc} u_cbMONXSD
Monta elemento baseado no schema
#tissver 2.x,3.x

@type Function
@author Alexander Santos
@since 12/05/2007
@version 1.0
/*/
User Function cbMONXSD(cDirFile,cCodPeg)
	LOCAL nI
	LOCAL cErro  	:= ""
	LOCAL cAviso 	:= ""
	LOCAL cNamRaiz  := ""
	LOCAL cNamNiv   := ""
	LOCAL aMatRet	:= {}
	LOCAL aMatOBJ	:= {}
	LOCAL oXml      := NIL
	LOCAL oObjType	:= NIL
	DEFAULT cCodPeg := ""

// Tratamento dos tipos complexos
	oXml := XmlParserFile(cDirFile,"_",@cErro,@cAviso)

// Faz o tratamento
	If ( Empty(cErro) .And. Empty(cAviso) .And. oXml <> Nil)

	// Obj raiz
		oObjType := XmlChildEx(oXml,"_SCHEMA")

	// Define matriz de elementos
		If  u_CBCHKNODE(oObjType,"_COMPLEXTYPE:_SEQUENCE:_ELEMENT",cCodPeg)
			If u_CBCHKNODE(oObjType,"_COMPLEXTYPE:_NAME")
				cNamRaiz := oObjType:_COMPLEXTYPE:_NAME:TEXT
			EndIf
			aMatOBJ := XmlChildEx( oObjType:_COMPLEXTYPE:_SEQUENCE,"_ELEMENT" )
			AaDd(aMatRet, { cNamRaiz, U_CBMONELE(aMatOBJ,cCodPeg) } )
		EndIf

	// Define matriz de elementos
		If	u_CBCHKNODE(oObjType,"_ELEMENT:_COMPLEXTYPE:_SEQUENCE")
			If  u_CBCHKNODE(oObjType,"_ELEMENT:_NAME")
				cNamRaiz := oObjType:_ELEMENT:_NAME:TEXT
			EndIf

			oObjType := XmlChildEx( oObjType:_ELEMENT:_COMPLEXTYPE,"_SEQUENCE" )

			If u_CBCHKNODE(oObjType,"_CHOICE:_ELEMENT")
				aMatOBJ := XmlChildEx( oObjType:_CHOICE,"_ELEMENT" )
			EndIf

			If XmlNodeExist( oObjType,"_ELEMENT" ) .And. ValType( XmlChildEx( oObjType,"_ELEMENT") ) == "A"
				For nI:=1 To Len( XmlChildEx( oObjType,"_ELEMENT") )
					AaDd(aMatOBJ, XmlChildEx( oObjType,"_ELEMENT")[nI] )
				Next
			EndIf
			AaDd(aMatRet, { cNamRaiz,U_CBMONELE(aMatOBJ,cCodPeg) } )
			oObjType := XmlChildEx(oXml,"_SCHEMA")
		EndIf

	// Define matriz de elementos
		If	XmlNodeExist( oObjType,"_COMPLEXTYPE" ) .And. ValType(oObjType:_COMPLEXTYPE) == "A"
			aMatOBJ := XmlChildEx( oObjType,"_COMPLEXTYPE" )
			aMatRet := U_CBMONELE(aMatOBJ,cCodPeg)
		EndIf

	// Define matriz de elementos
		If	u_CBCHKNODE(oObjType,"_ELEMENT:_COMPLEXTYPE:_COMPLEXCONTENT:_EXTENSION:_SEQUENCE")

			cNamRaiz := oObjType:_ELEMENT:_NAME:TEXT
			cNamNiv  := oObjType:_ELEMENT:_COMPLEXTYPE:_COMPLEXCONTENT:_EXTENSION:_BASE:TEXT

			aMatOBJ := XmlChildEx( oObjType:_ELEMENT:_COMPLEXTYPE:_COMPLEXCONTENT:_EXTENSION:_SEQUENCE,"_ELEMENT" )
			AaDd(aMatRet, { cNamRaiz, cNamNiv, U_CBMONELE(aMatOBJ,cCodPeg) } )
		EndIf

	// Define matriz de elementos
		If	XmlNodeExist( oObjType,"_SIMPLETYPE" ) .And. ValType(oObjType:_SIMPLETYPE) == "A"
			aMatOBJ := XmlChildEx( oObjType,"_SIMPLETYPE" )
			aMatRet := U_CBMONELE(aMatOBJ,cCodPeg)
		EndIf

	// Processa Matriz elementos
	EndIf

	oXml 	 := nil
	oObjType := nil
	DelClassIntF()

Return( {cErro,aMatRet} )

/*/{Protheus.doc} U_CBMONELE
Monta elemento baseado na raiz
@type function
@author TOTVS
@since 12.05.07
@version 1.0
/*/
User Function CBMONELE(aMatObj,cCodPeg)
	LOCAL nI,nY
	LOCAL cRestri		:= ""
	LOCAL lNew			:= .F.
	LOCAL lNewII		:= .F.
	LOCAL aMatEle		:= {}
	LOCAL aMatNiv		:= {}
	LOCAL aMatEnum		:= {}
	LOCAL oElement		:= NIL
	LOCAL oElementAux 	:= NIL
	DEFAULT cCodPeg		:= ""

// Matriz de elementos
	If Len(aMatObj) > 0
		For nI:=1 To Len(aMatObj)

		// Inclui na matriz de elementos ligados ao tipo complexo
			u_CABNIV( NIL,aMatObj[nI],aMatEle,cCodPeg )
			oElement  	:= NIL
			oElementAux	:= NIL

		// Monta elemento
			If u_CBCHKNODE(aMatObj[nI],"_SEQUENCE")
				oElementAux := XmlChildEx(aMatObj[nI],"_SEQUENCE")
			EndIf

		// Elemento
			lCheck := .T.
			If u_CBCHKNODE(oElementAux,"_ELEMENT")

				oElement := XmlChildEx(oElementAux,"_ELEMENT")

				If 	ValType(oElement) == "O"
					u_CABNIV( NIL,oElement,aMatEle,cCodPeg )
				ElseIf ValType(oElement) == "A" .And. u_CBCHKNODE(oElementAux,"_CHOICE:_ELEMENT") .And. ValType(oElementAux:_CHOICE:_ELEMENT) == "A"
					For nY:=1 To Len(oElementAux:_CHOICE:_ELEMENT)
						AaDd(oElement,oElementAux:_CHOICE:_ELEMENT[nY])
					Next
				EndIf

				If u_CBCHKNODE(oElement,"_COMPLEXTYPE:_SEQUENCE:_ELEMENT")
					oElement := XmlChildEx(oElement:_COMPLEXTYPE:_SEQUENCE,"_ELEMENT")
				ElseIf ValType(oElement) == "O"
					u_CABNIV( NIL,oElement,aMatEle,cCodPeg )
				EndIf

				If u_CBCHKNODE(oElement,"_COMPLEXTYPE:_COMPLEXCONTENT:_EXTENSION")
					oElement := XmlChildEx(oElement:_COMPLEXTYPE:_COMPLEXCONTENT,"_EXTENSION")

					u_CABNIV( NIL,oElement,aMatEle,cCodPeg )

					oElementAux := oElement
					oElement	:= XmlChildEx(oElement:_SEQUENCE,"_ELEMENT")
					lNewII 	 	:= .T.
				EndIf

				lCheck := u_CBCHKNODE(oElementAux,"_SEQUENCE")
			EndIf

		// Sequencia do elemento
			If lCheck
				If ValType(oElementAux) == "O"

					If u_CBCHKNODE(oElementAux,"_SEQUENCE:_ELEMENT")
						oElementAux := XmlChildEx(oElementAux:_SEQUENCE,"_ELEMENT")
					EndIf

					If ValType(oElement) == "A"
						aMatEle  := u_cbALIMAT(oElement,aMatEle,cCodPeg)
					EndIf
					oElement := oElementAux
				EndIf

			// Sequencia do elemento
				If 	u_CBCHKNODE(aMatObj[nI],"_SEQUENCE:_SEQUENCE:_ELEMENT:_COMPLEXTYPE:_SEQUENCE:_ELEMENT")

					u_CABNIV( NIL,aMatObj[nI]:_SEQUENCE:_SEQUENCE:_ELEMENT,aMatEle,cCodPeg )
					oElement := XmlChildEx(aMatObj[nI]:_SEQUENCE:_SEQUENCE:_ELEMENT:_COMPLEXTYPE:_SEQUENCE,"_ELEMENT")

				ElseIf 	u_CBCHKNODE(aMatObj[nI],"_COMPLEXTYPE:_COMPLEXCONTENT:_EXTENSION:_SEQUENCE:_ELEMENT")

					u_CABNIV( NIL,aMatObj[nI]:_COMPLEXTYPE:_COMPLEXCONTENT:_EXTENSION,aMatEle,cCodPeg )
					oElement := XmlChildEx(aMatObj[nI]:_COMPLEXTYPE:_COMPLEXCONTENT:_EXTENSION:_SEQUENCE,"_ELEMENT")

				ElseIf u_CBCHKNODE(aMatObj[nI],"_COMPLEXCONTENT:_EXTENSION:_SEQUENCE:_ELEMENT")

					u_CABNIV( NIL,aMatObj[nI]:_COMPLEXCONTENT:_EXTENSION,aMatEle,cCodPeg )
					oElement := XmlChildEx(aMatObj[nI]:_COMPLEXCONTENT:_EXTENSION:_SEQUENCE,"_ELEMENT")

				ElseIf u_CBCHKNODE(aMatObj[nI],"_CHOICE:_ELEMENT")

					u_CABNIV( "CH",NIL,aMatEle,cCodPeg )
					oElement := XmlChildEx(aMatObj[nI]:_CHOICE,"_ELEMENT")

				ElseIf 	u_CBCHKNODE(aMatObj[nI],"_COMPLEXTYPE:_SEQUENCE:_ELEMENT")

					oElement := XmlChildEx(aMatObj[nI]:_COMPLEXTYPE:_SEQUENCE,"_ELEMENT")

				ElseIf u_CBCHKNODE(aMatObj[nI],"_COMPLEXTYPE:_CHOICE:_ELEMENT")

					u_CABNIV( "CH",NIL,aMatEle,cCodPeg )
					oElement := XmlChildEx(aMatObj[nI]:_COMPLEXTYPE:_CHOICE,"_ELEMENT")

				ElseIf ValType(oElement) <> "O" .And. ValType(oElement) <> "A"
					oElement := aMatObj[nI]
				EndIf
			EndIf

		// Tipo Simples
			If u_CBCHKNODE(aMatObj[nI],"_RESTRICTION")
				lNew 	 := .T.
				cRestri  := ""
				oElement := XmlChildEx(aMatObj[nI],"_RESTRICTION")

			// Inclui na matriz de elementos ligados ao tipo complexo
				cRestri += oElement:_BASE:TEXT + ";"

			// Se tem Total de digitos
				If u_CBCHKNODE(oElement,"_TOTALDIGITS")
					cRestri += "IN="+AllTrim(oElement:_TOTALDIGITS:_VALUE:TEXT) + ";"
				EndIf

			// Se tem Total de decimais
				If u_CBCHKNODE(oElement,"_FRACTIONDIGITS")
					cRestri += "DE="+AllTrim(oElement:_FRACTIONDIGITS:_VALUE:TEXT) + ";"
				EndIf

			// Se tem tamanho
				If u_CBCHKNODE(oElement,"_LENGTH")
					cRestri += "LE=" + AllTrim(oElement:_LENGTH:_VALUE:TEXT) + ";"
				EndIf

			// Se tem tamanho minimo
				If u_CBCHKNODE(oElement,"_MINLENGTH")
					cRestri += "MI="+AllTrim(oElement:_MINLENGTH:_VALUE:TEXT) + ";"
				EndIf

			// Se tem tamanho maximo
				If u_CBCHKNODE(oElement,"_MAXLENGTH")
					cRestri += "MA="+AllTrim(oElement:_MAXLENGTH:_VALUE:TEXT) + ";"
				EndIf

			// Inclui registro
				u_CABNIV( cRestri,NIL,aMatEle,cCodPeg )

			// Se tem conteudo enumerados
				If u_CBCHKNODE(oElement,"_ENUMERATION")
					aMatEnum := XmlChildEx(oElement,"_ENUMERATION")
					cRestri  := ""
					If ValType(aMatEnum) == "A"
						For nY:=1 To Len(aMatEnum)
							cRestri += aMatEnum[nY]:_VALUE:TEXT + ";"
						Next
					ElseIf ValType(aMatEnum) == "O"
						cRestri += aMatEnum:_VALUE:TEXT + ";"
					EndIf
					u_CABNIV( cRestri,NIL,aMatEle,cCodPeg )
				EndIf
			EndIf

		// Alimenta matriz
			If lNew
				AaDd( aMatNiv,aMatEle )
			ElseIf lNewII
				If Len(aMatEle) >= 4
					aMatAux := { aMatEle[1] }
					AaDd( aMatAux,{ aMatEle[2] } )

					For nY:=3 To Len(aMatEle)
						AaDd( aMatAux[Len(aMatAux)],aMatEle[nY] )
					Next

					AaDd( aMatNiv,aMatAux )
					lNewII := .F.
				Else
					AaDd( aMatNiv,aMatEle )
				EndIf
			Else
				AaDd( aMatNiv,u_cbALIMAT(oElement,aMatEle,cCodPeg) )
			EndIf
			aMatEle	:= {}
		Next
	EndIf

Return( aMatNiv )

/*/{Protheus.doc} u_cbALIMAT
Monta matriz conforme elemento
@type function
@author TOTVS
@since 12.05.07
@version 1.0
/*/
User Function cbALIMAT(oElement,aMatAux,cCodPeg)
	LOCAL nY,nX,nF
	LOCAL lAdcLin	:= .F.
	LOCAL lExten	:= .F.
	LOCAL lExtenII	:= .F.
	LOCAL aMatNiv   := {}
	LOCAL aMatSuN1  := {}
	LOCAL aMatSuN2  := {}
	LOCAL oElementF := NIL
	DEFAULT cCodPeg := ""

// Matriz de tipos complexos
	If ValType(oElement) <> "U"
		If ValType(oElement) <> "O"
			For nY:=1 To Len(oElement)
				u_CABNIV( NIL,oElement[nY],aMatNiv,cCodPeg )

			// Elementos
				If u_CBCHKNODE(oElement[nY],"_COMPLEXTYPE:_COMPLEXCONTENT:_EXTENSION:_SEQUENCE:_ELEMENT")

					oElementF := XmlChildEx(oElement[nY]:_COMPLEXTYPE:_COMPLEXCONTENT:_EXTENSION:_SEQUENCE,"_ELEMENT")
					u_CABNIV( NIL,oElement[nY]:_COMPLEXTYPE:_COMPLEXCONTENT:_EXTENSION,aMatNiv,cCodPeg )

					If u_CBCHKNODE(oElementF,"_COMPLEXTYPE:_COMPLEXCONTENT:_EXTENSION:_SEQUENCE:_ELEMENT")

						lExten := .T.
						u_CABNIV( NIL,oElementF,aMatSuN1,cCodPeg )
						u_CABNIV( NIL,oElementF:_COMPLEXTYPE:_COMPLEXCONTENT:_EXTENSION,aMatSuN1,cCodPeg )
						oElementF := XmlChildEx(oElementF:_COMPLEXTYPE:_COMPLEXCONTENT:_EXTENSION:_SEQUENCE,"_ELEMENT")

					ElseIf u_CBCHKNODE(oElementF,"_COMPLEXTYPE:_SEQUENCE:_ELEMENT")

						u_CABNIV( NIL,oElementF,aMatNiv,cCodPeg )
						oElementF := XmlChildEx(oElementF:_COMPLEXTYPE:_SEQUENCE,"_ELEMENT")

					ElseIf ValType(oElementF) <> "A"

						lExtenII := .T.

					EndIf

				ElseIf u_CBCHKNODE(oElement[nY],"_COMPLEXTYPE:_CHOICE:_ELEMENT")

					u_CABNIV( "CH",NIL,aMatNiv,cCodPeg )
					oElementF := XmlChildEx(oElement[nY]:_COMPLEXTYPE:_CHOICE,"_ELEMENT")

				ElseIf u_CBCHKNODE(oElement[nY],"_COMPLEXTYPE:_ALL:_ELEMENT")

					oElementF := XmlChildEx(oElement[nY]:_COMPLEXTYPE:_ALL,"_ELEMENT")

				ElseIf u_CBCHKNODE(oElement[nY],"_COMPLEXTYPE:_COMPLEXCONTENT:_EXTENSION")

					oElementF := XmlChildEx(oElement[nY]:_COMPLEXTYPE:_COMPLEXCONTENT,"_EXTENSION")

				ElseIf u_CBCHKNODE(oElement[nY],"_COMPLEXTYPE:_SEQUENCE:_ELEMENT")

					oElementF := XmlChildEx(oElement[nY]:_COMPLEXTYPE:_SEQUENCE,"_ELEMENT")

					If u_CBCHKNODE(oElementF,"_COMPLEXTYPE:_SEQUENCE:_ELEMENT")

						u_CABNIV( NIL,oElementF,aMatNiv,cCodPeg )
						oElementF := XmlChildEx(oElementF:_COMPLEXTYPE:_SEQUENCE,"_ELEMENT")

					ElseIf u_CBCHKNODE(oElementF,"_COMPLEXTYPE:_COMPLEXCONTENT:_EXTENSION:_SEQUENCE:_ELEMENT")

						If u_CBCHKNODE(oElementF,"_COMPLEXTYPE:_COMPLEXCONTENT:_EXTENSION:_SEQUENCE:_ELEMENT") .And.;
								u_CBCHKNODE(oElementF,"_COMPLEXTYPE:_COMPLEXCONTENT:_EXTENSION:_BASE")
							lAdcLin := .T.
						EndIf

						aMatNivAux := {}

						u_CABNIV( NIL,oElementF,aMatNivAux,cCodPeg )
						u_CABNIV( NIL,oElementF:_COMPLEXTYPE:_COMPLEXCONTENT:_EXTENSION,aMatNivAux,cCodPeg )

						AaDd(aMatNiv,aMatNivAux)

						oElementF := XmlChildEx(oElementF:_COMPLEXTYPE:_COMPLEXCONTENT:_EXTENSION:_SEQUENCE,"_ELEMENT")

					ElseIf ValType(oElementF) <> "A"

						lExtenII := .T.

					EndIf
				Else
					oElementF := oElement[nY]
				EndIf

			// Matriz de sub elementos
				If ValType(oElementF) == "A"

					For nX:=1 To Len(oElementF)

						oElementG := oElementF[nX]
						u_CABNIV( NIL,oElementG,aMatSuN1,cCodPeg )

						If u_CBCHKNODE(oElementG,"_COMPLEXTYPE:_COMPLEXCONTENT:_EXTENSION:_SEQUENCE:_ELEMENT")

							u_CABNIV( NIL,oElementG:_COMPLEXTYPE:_COMPLEXCONTENT:_EXTENSION,aMatSuN1,cCodPeg )
							oElementG := XmlChildEx(oElementG:_COMPLEXTYPE:_COMPLEXCONTENT:_EXTENSION:_SEQUENCE,"_ELEMENT")

						ElseIf u_CBCHKNODE(oElementG,"_COMPLEXTYPE:_COMPLEXCONTENT:_EXTENSION")

							oElementG := XmlChildEx(oElementG:_COMPLEXTYPE:_COMPLEXCONTENT,"_EXTENSION")

						ElseIf u_CBCHKNODE(oElementG,"_COMPLEXTYPE:_SEQUENCE:_ELEMENT")

							oElementG := XmlChildEx(oElementG:_COMPLEXTYPE:_SEQUENCE,"_ELEMENT")

						EndIf

					// Verifica se existe
						If ValType(oElementG) <> "A"
							u_CABNIV( NIL,oElementG,aMatSuN1,cCodPeg )
							u_CBMCOM( oElementG,aMatSuN1 )
						Else
							For nF:=1 To Len(oElementG)
								u_CABNIV( NIL,oElementG[nF],aMatSuN2,cCodPeg )
								u_CBMCOM( oElementG[nF],aMatSuN2 )
							Next
							AaDd(aMatSuN1,aMatSuN2)
							aMatSuN2 := {}
						EndIf
					Next
					If !Empty(aMatSuN1)
						If ValType( aMatNiv[Len(aMatNiv)] ) == "A"
							If lAdcLin
								For nX:=1 To Len(aMatSuN1)
									If At('CP_',aMatSuN1[nX]) == 0 .And. At(cPrefANS,aMatSuN1[nX]) == 0
										aMatSuN1[nX]:= "EX_"+aMatSuN1[nX]
									EndIf
									AaDd(aMatNiv[Len(aMatNiv)],aMatSuN1[nX])
								Next
							Else
								AaDd(aMatNiv[Len(aMatNiv)],	aMatSuN1)
							EndIf
						Else
							If Len(aMatNiv)==2
								aMatNiv[2] := { aMatNiv[2] }
								AaDd(aMatNiv[2],aMatSuN1)
							Else
								AaDd(aMatNiv,aMatSuN1)
							EndIf
						EndIf
						aMatSuN1 := {}
					EndIf
				Else
					If lExten
						u_CABNIV( NIL,oElementF,aMatSuN2,cCodPeg )
						u_CBMCOM( oElementF,aMatSuN2 )
						AaDd(aMatSuN1,aMatSuN2)
						aMatSuN2 := {}
						AaDd( aMatNiv,aMatSuN1 )
						lExten := .F.
					ElseIf lExtenII
						u_CABNIV( NIL,oElementF,aMatSuN1,cCodPeg )
						u_CBMCOM( oElementF,aMatSuN1 )
						AaDd( aMatNiv,aMatSuN1 )
						aMatSuN1 := {}
						lExtenII := .F.
					Else
						u_CABNIV( NIL,oElementF,aMatNiv,cCodPeg )
						u_CBMCOM( oElementF,aMatNiv )
					EndIf
				EndIf
			Next
			If ValType( aMatAux[ Len(aMatAux) ] ) == "A"
				AaDd( aMatAux[ Len(aMatAux) ] , aMatNiv )
			Else
				AaDd( aMatAux,aMatNiv )
			EndIf
			aMatNiv := {}
		Else
			u_CABNIV( NIL,oElement,aMatAux,cCodPeg )
			u_CBMCOM( oElement,aMatAux )
		EndIf
	EndIf

Return(aMatAux)

/*/{Protheus.doc} u_cbMELE
Retorna nome elemento base
@type function
@author TOTVS
@since 19.05.07
@version 1.0
/*/
User Function cbMELE(oObj)
	LOCAL cName   := ""

	If u_CBCHKNODE(oObj,"_BASE")
		cName := oObj:_BASE:TEXT
	EndIf

	If u_CBCHKNODE(oObj,"_NAME")
		cName := oObj:_NAME:TEXT
	EndIf

	If u_CBCHKNODE(oObj,"_MINOCCURS") .And. Val(oObj:_MINOCCURS:TEXT) == 0
		cName += "_OP"
	EndIf

Return(cName)

/*/{Protheus.doc} u_CBMCOM
Monta complemento do elemento
@type function
@author TOTVS
@since 19.05.07
@version 1.0
/*/
User Function CBMCOM(oObj,aMat,cCodPeg)
	LOCAL cRestri := ""
	DEFAULT cCodPeg := ""

// Complemento
	If u_CBCHKNODE(oObj,"_TYPE")
		If At("ans",oObj:_TYPE:TEXT) <> 0
			u_CABNIV( oObj:_TYPE:TEXT,NIL,aMat,cCodPeg )
		Else
			u_CABNIV( "TY_"+oObj:_TYPE:TEXT,NIL,aMat,cCodPeg )
		EndIf
	EndIf

// Verifica se tem tipo simples no comple
	If u_CBCHKNODE(oObj,"_SIMPLETYPE:_RESTRICTION")
		oObj := XmlChildEx(oObj:_SIMPLETYPE,"_RESTRICTION")

	// Tipo
		If u_CBCHKNODE(oObj,"_BASE")
			If At("ans",oObj:_BASE:TEXT) == 0
				cRestri += "TY_" + oObj:_BASE:TEXT + ";"
			Else
				u_CABNIV( NIL,oObj,aMat,cCodPeg )
			EndIf
		EndIf

	// Se tem Total de digitos
		If u_CBCHKNODE(oObj,"_TOTALDIGITS")
			cRestri += "IN="+AllTrim(oObj:_TOTALDIGITS:_VALUE:TEXT) + ";"
		EndIf

	// Se tem Total de decimais
		If u_CBCHKNODE(oObj,"_FRACTIONDIGITS")
			cRestri += "DE="+AllTrim(oObj:_FRACTIONDIGITS:_VALUE:TEXT) + ";"
		EndIf

	// Se tem tamanho
		If u_CBCHKNODE(oObj,"_LENGTH")
			cRestri += "LE="+AllTrim(oObj:_LENGTH:_VALUE:TEXT) + ";"
		EndIf

	// Se tem tamanho minimo
		If u_CBCHKNODE(oObj,"_MINLENGTH")
			cRestri += "MI="+AllTrim(oObj:_MINLENGTH:_VALUE:TEXT) + ";"
		EndIf

	// Se tem tamanho maximo
		If u_CBCHKNODE(oObj,"_MAXLENGTH")
			cRestri += "MA="+AllTrim(oObj:_MAXLENGTH:_VALUE:TEXT) + ";"
		EndIf

	// Alimenta Matriz
		u_CABNIV( cRestri,NIL,aMat,cCodPeg )
	EndIf

Return(aMat)

/*/{Protheus.doc} u_CABNIV
Verifica duplicidade e inclui na matriz
@type function
@author TOTVS
@since 19.05.07
@version 1.0
/*/
User Function CABNIV(cTexto,oObj,aMat,cCodPeg)
	LOCAL nPos 		:= 0
	LOCAL cTextoAux := ""
	LOCAL lCon		:= .F.
	LOCAL bBlockXml   := nil
	DEFAULT cCodPeg := ""

// Verifica se e obj
	If ValType(oObj) == "O"
		cTexto := u_cbMELE(oObj)
	EndIf

// Se e opcional
	If At("_OP",cTexto) > 0
		cTextoAux := SubStr(cTexto, 1, Len(cTexto)-3 )
	Else
		cTextoAux := cTexto
	EndIf

// Vazio
	If !Empty(cTextoAux)
		If ( nPos := aScan( aMat ,{ |x|AllTrim(x)==AllTrim("CP_"+cTextoAux) } ) ) == 0
			If cTextoAux == "CH" .Or. At(cPrefANS,cTextoAux) > 0 .Or. At(";",cTextoAux) > 0 .Or.;
					( nPos := aScan( aMat ,{ |x|AllTrim(x)==AllTrim(cTextoAux) } ) ) == 0 .And.;
					( nPos := aScan( aMat ,{ |x|AllTrim(x)==AllTrim(cTexto) } ) ) == 0

				If cTextoAux == "CH"
					aMat[Len(aMat)] := aMat[Len(aMat)]+"_CH"
				Else
					If At(cPrefANS+"st_",cTextoAux) > 0 .Or. At("TY_",cTextoAux) > 0
						aMat[Len(aMat)] := "CP_"+aMat[Len(aMat)]
					EndIf
					If At("TY_",cTexto) > 0
						AaDd( aMat, { AllTrim( SubStr( cTexto, 4, Len(cTexto) ) ) + ";" } )
					Else
						AaDd( aMat, AllTrim( cTexto ) )
					EndIf
				EndIf
			Else
				If At("_OP",aMat[nPos]) == 0
					aMat[nPos] := AllTrim(cTexto)
				EndIf
			EndIf
		EndIf
	EndIf

Return(aMat)

/*/{Protheus.doc} U_CABARRAY
Monta um array e procura conteudo no mesmo
@type function
@author TOTVS
@since 16/05/07
@version 1.0
/*/
User Function CABARRAY(cString,cDelimit,cFind,cCodPeg)
	LOCAL nPos    := 0
	LOCAL nPFind  := 0
	LOCAL lRet 	  := .F.
	LOCAL aRet    := {}
	LOCAL bBlockXml   := nil
	DEFAULT cFind := ""
	DEFAULT cCodPeg := ""

// Verifica se foi informado delimitador no final
	If Right(cString,1) <> cDelimit
		cString += cDelimit
	EndIf

// Monta array
	If !Empty(cString)
		While ( nPos := At( cDelimit, cString ) ) > 0
			AaDd( aRet,StrTran(SubStr( cString, 1, nPos-1 ),"'","") )
			cString := SubStr( cString, nPos+1, Len(cString) )
		EndDo

	// Verifica se existe na matriz
		If Len(aRet)>0 .And. !Empty(cFind)
			nPFind := aScan( aRet,{ |x|AllTrim(x)==AllTrim(cFind) } )
		EndIf
	EndIf

Return( { IiF(nPFind>0,.T.,.F.) , nPFind , aRet } )

/*/{Protheus.doc} u_CBMONSTR
Monta estrutura detalhada
@type function
@author TOTVS
@since 22.05.07
@version 1.0
/*/
USer Function CBMONSTR(aMat,nTam,cCodPeg)
	LOCAL nX,nI,nH
	LOCAL aAux 	  	:= {}
	LOCAL aMatAux 	:= {}
	LOCAL cElemento := ""
	LOCAL cConteudo := ""
	DEFAULT cCodPeg := ""

// For para gravar a estrutura no aruqivo
	For nX:=1 To Len(aMat)
		If ValType(aMat[nX]) <> "O"
			For nI:=1 To Len(aMat[nX])
				If ValType(aMat[nX,nI]) == "O"
					If ValType( aMat[nX,nI]:REALNAME ) == "C" .And. ValType( aMat[nX,2]:TEXT ) == "C"

						cElemento := Upper( SubStr( aMat[nX,2]:REALNAME,nTam ) )
						cConteudo :=  StrTran( StrTran( StrTran( aMat[nX,2]:TEXT ,Chr(13),""),Chr(10),""),Chr(9),"")

						If !Empty(cConteudo)
							cElemento := "CP_"+cElemento
						EndIf
						AaDd( aAux, { cElemento,cConteudo } )

						aMatAux := u_CBMONSTR( classDataArr(aMat[nX,nI]) , nTam,cCodPeg )

						If Len(aMatAux) > 0
							For nH:=1 To Len(aMatAux)
								If Empty(aAux[Len(aAux),2])
									aAux[Len(aAux),2] := aMatAux[nH]
								Else
									AaDd( aAux[Len(aAux)], aMatAux[nH] )
								EndIf
							Next
						EndIf
					EndIf
				ElseIf ValType(aMat[nX,nI]) == "A"
					aMatAux := u_CBMONSTR( aMat[nX,nI] , nTam,cCodPeg )
					If Len(aMatAux) > 0
						For nH:=1 To Len(aMatAux)
							AaDd( aAux , aMatAux[nH] )
						Next
					EndIf
				EndIf
			Next
		Else
			If ValType(aMat[nX]) == "O"
				If ValType( aMat[nX]:REALNAME ) == "C" .And. ValType( aMat[nX]:TEXT ) == "C"

					cElemento := Upper( SubStr( aMat[nX]:REALNAME,nTam ) )
					cConteudo := StrTran( StrTran( StrTran( aMat[nX]:TEXT ,Chr(13),""),Chr(10),""),Chr(9),"")

					If !Empty(cConteudo)
						cElemento := "CP_"+cElemento
					EndIf

					AaDd( aAux, { cElemento,cConteudo } )

					aMatAux := u_CBMONSTR( classDataArr(aMat[nX]) , nTam,cCodPeg )

					If Len(aMatAux) > 0
						For nH:=1 To Len(aMatAux)
							If Empty(aAux[Len(aAux),2])
								aAux[Len(aAux),2] := aMatAux[nH]
							Else
								AaDd( aAux[Len(aAux)], aMatAux[nH] )
							EndIf
						Next
					EndIf
				EndIf
			EndIf
		EndIf
	Next

Return(aAux)

/*/{Protheus.doc} u_CBDESCH
Conta quantidade de elementos de CH
@type function
@author TOTVS
@since 22.05.07
@version 1.0
/*/
User Function CBDESCH(aMat,aMatX,cOrig,cCodPeg)
	LOCAL nX        := 0
	LOCAL nCont 	:= 0
	LOCAL lOp		:= .F.
	LOCAL cElemento := ""
	LOCAL cEleCh	:= ""
	LOCAL cEleChFI	:= ""
	LOCAL bBlockXml   := nil
	DEFAULT cCodPeg := ""

// Conta elementos de CH
	For nX:=1 To Len(aMat)
		If ValType(aMat[nX]) <> "A" .And. At("_NC",aMat[nX]) == 0
			cElemento := Upper( aMat[nX] )
			lOp       := At("_OP",cElemento) > 0
			cElemento := AllTrim( StrTran(cElemento,"_CH","") )
			cElemento := AllTrim( StrTran(cElemento,"_OP","") )

			If ValType(aMatX[2]) == "A"
				If ( nPos := aScan( aMatX,{|x|x[1] == cElemento },2 ) ) > 0
					nCont++
					cEleChFI += AllTrim( StrTran(cElemento,"CP_","") ) + ","
				EndIf
			EndIf

			cEleCh += AllTrim( StrTran(cElemento,"CP_","") ) + ","

		EndIf
	Next

// Se todos os elementos do choice forem opcionais nao trata
	If lOp
		nCont:=1
	EndIf

// Verifica resultado
	If nCont>1
	//u_CABLOGX("Informe somente um elemento da sequencia ( "+cEleCh+" ), encontrado(s) ( "+cEleChFI+ " ).  Origem -> "+cOrig,.F.) //"Informe somente um elemento da sequencia ( "###" ), encontrado(s) ( "###" ).  Origem -> "
	ElseIf nCont==0
	//u_CABLOGX("Informe pelo menos um elemento da sequencia ( "+cEleCh+ " ).  Origem -> "+cOrig,.F.) //"Informe pelo menos um elemento da sequencia ( "###" ).  Origem -> "
	EndIf

Return(nCont==1)

/*/{Protheus.doc} u_CBVLDXML
Valida XML com base no Schemas
@type function
@author TOTVS
@since 22.05.07
@version 1.0
/*/
User Function CBVLDXML( aMatS,aMatX,cOrig,aMatDad,lEleCh,cCodPeg )
	LOCAL nX,nY		:= 0
	LOCAL nB,nH		:= 0
	LOCAL nPosFid	:= 0
	LOCAL cElemento	:= ""
	LOCAL cOrigCor  := ""
	LOCAL cConteudo	:= ""
	LOCAL lAchou	:= .F.
	LOCAL lFind		:= .T.
	LOCAL lCampo    := .F.
	LOCAL lCh	    := .F.
	LOCAL lOp	    := .F.
	LOCAL lElOpc	:= .F.
	LOCAL lCaOpc  	:= .F.
	LOCAL aRet		:= {}
	LOCAL aAuxX		:= {}
	DEFAULT cOrig	:= "\"
	DEFAULT aMatDad	:= {}
	DEFAULT lEleCh	:= .F.
	DEFAULT cCodPeg	:= ""




// Origem
	cOrigCor := cOrig

// Todos os elementos do shema para validar o xml de recebido
	For nX:=1 To Len(aMatS)
		If ValType( aMatS[nX] ) <> "A" .And. At(";",aMatS[nX]) == 0
			lAchou 	  := .F.
			lElOpc	  := .F.
			lCaOpc	  := .F.
			lNillAble := .F.
			cElemento := Upper( aMatS[nX] )
			lCampo    := At("CP_",cElemento) > 0
			lCh		  := At("_CH",cElemento) > 0
			lOp       := At("_OP",cElemento) > 0
			lEx       := At("EX_",cElemento) > 0
			_aRet	  := u_CBBUSELE( "CP_:NIL",aMatX,.F.,cCodPeg )
			If _aRet[1]
				aMatX[_aRet[3],1] := "CP_:NIL"
				lNillAble := Iif(aMatX[_aRet[3],2]=='true',.T.,.F.)
			EndIf
			cElemento := AllTrim( StrTran(cElemento,"_CH","") )
			cElemento := AllTrim( StrTran(cElemento,"_OP","") )
			cElemento := AllTrim( StrTran(cElemento,"_NC","") )
			Iif(lCampo,lCaOpc:=lOp,lElOpc:=lOp )

		// Verifica existencia
			aRet 	  := u_CBBUSELE( cElemento,aMatX,lCampo,cCodPeg )
			lAchou 	  := aRet[1]
			cConteudo := aRet[2]
			nPosFid	  := aRet[3]
			cElemento := AllTrim( StrTran(cElemento,"CP_","") )

		// Retorno
			If !lAchou .And. !lCaOpc .And. !lElOpc .And. !lEleCh .And. !lEx .And. !lNillAble
				u_CABLOGX( "Elemento n�o encontrado ( "+cElemento+" ) na origem -> "+cOrigCor,.F.) //"Elemento não encontrado ( "###" ) na origem -> "
			ElseIf lAchou
				If (Empty( AllTrim(cConteudo) ) .and. ALLTRIM(UPPER(cElemento))<>"CODIGO" ) .And. lCampo .And. !lCaOpc  // Incluido o codigo no Array para posterior Validação
					u_CABLOGX("Conteudo do elemento ( "+cElemento+" ) n�o informado.  Origem -> "+cOrigCor,.F.) //"Conteudo do elemento ( "###" ) não informado.  Origem -> "
					If lEleCh
						AaDd( aMatDad, { cElemento,"",cOrigCor } )
					EndIf
				ElseIf !Empty(cConteudo) .And. !lCampo
					u_CABLOGX("Elemento ( "+cElemento+" ) n�o deve receber conteudo.  Origem -> "+cOrigCor,.F.) //"Elemento ( "###" ) não deve receber conteudo.  Origem -> "
				Else
					AaDd( aMatDad, { cElemento,cConteudo,Iif( !Empty(cConteudo),cOrigCor,"" ) } )

				// Campos no formato de matriz
					If lCampo .And. Len(aMatX)>2
						nPosFid++
						For nY:=nPosFid To Len(aMatX)
							aRet   	  := u_CBBUSELE( "CP_"+cElemento,@aMatX,lCampo,cCodPeg )
							lAchou 	  := aRet[1]
							cConteudo := aRet[2]
							If lAchou
								AaDd( aMatDad, { cElemento,cConteudo,Iif( !Empty(cConteudo),cOrigCor,"" ) } )
							Else
								Exit
							EndIf
						Next
					EndIf
				EndIf
			EndIf

		// Verifica elemento Choice
			If lCh .And. lAchou
				lEleCh := u_CBDESCH( aMatS[nX+1] , IiF( ValType(aMatX[nPosFid])<>"A" , aMatX , aMatX[nPosFid] ) , cOrigCor+cElemento+"\")
				lAchou := lEleCh
			EndIf

	// Se achou
		ElseIf lAchou

			aAuxX := aMatX
			If !lCampo .And. nPosFid > 0
				If ValType( aMatX[nPosFid] ) == "A"
					aAuxX := aMatX[nPosFid]
				ElseIf Len( aMatX ) == 2
					aAuxX := aMatX[nPosFid+1]
				EndIf
				If Len(aMatS)>=nX+1 .And. cElemento <> "CABECALHO"
					If  ValType(aMatS[nX+1]) <> "A"
						nPosFid := 0
					EndIf
				Else
					nPosFid := 0
				EndIf
			EndIf

			If At(";",cElemento) == 0 .And. !lCampo
				cOrig += cElemento+"\"
			EndIf
			lFind := .T.
			While lFind
				u_CBVLDXML( aMatS[nX],aAuxX,cOrig,aMatDad,Iif(lCh,lEleCh,lCh),cCodPeg )

				For nB:=1 To Len(aAuxX)
					If ValType(aAuxX[nB]) == 'A' .And. At("CP_",aAuxX[nB,1]) == 0 .And. At("*",aAuxX[nB,1]) == 0
						nPosnH 	  := 0
						For nH:=1 To Len(aMatS)
							If ValType(aMatS[nH]) <> 'A' .And. At("EX_",aMatS[nH]) > 0 .And. aAuxX[nB,1] == Upper( AllTrim( StrTran(aMatS[nH],"EX_","") ) )
								nPosnH := nH+1
								Exit
							EndIf
						Next
						If nPosnH>0
							If At(";",aAuxX[nB,1]) == 0 .And. !lCampo
								cOrig += aAuxX[nB,1]+"\"
							EndIf

							u_CBVLDXML( aMatS[nPosnH],aAuxX[nB],cOrig,aMatDad,Iif(lCh,lEleCh,lCh),cCodPeg )
						EndIf
					EndIf
				Next

				If At(";",cElemento) == 0 .And. !lCampo
					aRet  := u_CBBUSELE( cElemento,aMatX,lCampo,cCodPeg)
					lFind := aRet[1]
					If lFind
						aAuxX := aMatX[aRet[3]]
						AaDd( aMatDad, { cElemento,"","" } )
					EndIf
				Else
					lFind := .F.
				EndIf
			EndDo
			cOrig  := cOrigCor
		EndIf
	Next

Return(aMatDad)

/*/{Protheus.doc} u_CBBUSELE
Busca Elemento na matriz
@type function
@author TOTVS
@since 22.05.07
@version 1.0
/*/
User Function CBBUSELE(cElemento,aMatX,lCampo,cCodPeg)
	LOCAL nPos		:= 0
	LOCAL cConteudo := ""
	LOCAL lFind 	:= .F.
	LOCAL lFEle 	:= .F.
	LOCAL bBlockXml   := nil
	DEFAULT cCodPeg := ""

// Procura elemento na matriz
	If ( lFEle := ( nPos := aScan(aMatX,{|x| ValType(x) == "C" .AND. x == cElemento } ) ) == 0 )
		If ValType(aMatX) == "A" .AND. Len(aMatX)>=2 .And. ValType(aMatX[2]) == "A"
			nPos := aScan( aMatX,{|x|x[1] == cElemento },2 )
			If lCampo .And. nPos == 0
				nPos := aScan( aMatX,{|x|x[1] == AllTrim( StrTran(cElemento,"CP_","") ) },2 )
			EndIf
		Else
			nPos := 0
		EndIf
	EndIf

// Se achou
	If nPos>0
		lFind := .T.
		If !lFEle
			aMatX[nPos]	:= "*"+aMatX[nPos]
		Else
			aMatX[nPos,1] := "*"+aMatX[nPos,1]
		EndIf
		If lCampo
			If ValType(aMatX[nPos]) == "A"
				cConteudo := aMatX[nPos,2]
			Else
				cConteudo := aMatX[2]
			EndIf
		EndIf
	EndIf

Return( {lFind,cConteudo,nPos} )

/*/{Protheus.doc} u_CBTPTRAN
Processamento conforme tipo de transacao
@type function
@author TOTVS
@since 22.05.07
@version 1.0
/*/
User Function CBTPTRAN(cNomeArq,cDatHor,aMatXCab,aMatXPre,aMatXEpi,cFileHas,oProcess,cCodPeg,lOk,aDadosXml,lBg, l974Xml)
	LOCAL nI,nY
	LOCAL nPos		:= 0
	LOCAL nPosAux	:= 0
	LOCAL nPosNext	:= 0
	LOCAL nTotGui	:= 0
	LOCAL cHash	    := ""
	LOCAL cContHash := ""
	LOCAL cTpTran	:= ""
	LOCAL cGuia		:= ""
	LOCAL cTpGuias	:= ""
	LOCAL cConteudo := ""
	LOCAL cTranRet  := ""
	LOCAL cOrigem	:= ""
	LOCAL cTagOri	:= ""
	LOCAL cNomApl	:= ""
	LOCAL cVerApl	:= ""
	LOCAL cFabApl	:= ""
	LOCAL lHasAr	:= .F.
	LOCAL lHasCo	:= .F.
	LOCAL cTime		:= Time()
	LOCAL nIniSeg	:= Seconds()
	LOCAL aMatAux 	:= {}
	LOCAL aMatNew 	:= {}
	LOCAL aRet	    := {}
	LOCAL aMatRet   := {}
	LOCAL aMatCri	:= {}
	LOCAL aMatC   	:= {}
	LOCAL aMatM   	:= {}
	LOCAL cTipo     := ""
	LOCAL bBlockXml   := nil
	LOCAL aTagsExp		:= {}
	LOCAL aRetTrans	:= {}
	LOCAL xRetTrans	:= {}
	LOCAL cExpVld		:= ""
	LOCAL cExpMont		:= ""
	LOCAL oError		:= nil
	LOCAL cCodRP
	LOCAL nIdx
	LOCAL aDadosRet	:= {}
	LOCAL cTpCab := ""			//1,5
	LOCAL cCCCab := ""			//2,6
	LOCAL cCodRda := ""		//3,15
	LOCAL cNomRda := ""		//4
	LOCAL cMatric := ""		//7
	LOCAL cNomeUsu := ""		//8
	LOCAL cNumeSeq := ""		//9,13
	LOCAL cNumAut := ""		//10
	LOCAL cNumAut2 := ""		//17
	LOCAL lAchouNAut := .F.		//18
	LOCAL lHonorario := .F.	//11
	LOCAL lResIntern := .F.	//12
	LOCAL dDatPro := ""		//14
	LOCAL cCNES := ""			//16
	LOCAL lExisBVR	:= .F.
	LOCAL cStTiss := ""
	PRIVATE aDados	:= aDadosXml //dados do XML a partir da versao 3 da TISS
	PRIVATE cTipoRD	:= ""
	DEFAULT oProcess:= nil
	DEFAULT cCodPeg	:= ""
	DEFAULT lOk	:= lOkXML
	DEFAULT lBg	:= .F.
	Default l974Xml	:= .F.

	If (TISVERS < "3")


	// Valida Cabecalho
		AaDd( aMatRet , u_CBVLDXML(aMatCab,aMatXCab,nil,nil,nil,cCodPeg) )

	// Valida Corpo
		AaDd( aMatRet , u_CBVLDXML(aMatPre,aMatXPre,nil,nil,nil,cCodPeg) )

	// Valida Epilogo
		AaDd( aMatRet , u_CBVLDXML(aMatEpi,aMatXEpi,nil,nil,nil,cCodPeg) )

	// Verifica campos do software gerador - verao >= 2_02_02
		If lVerTISS
			cNomApl := u_CBPEGCON("NOMEAPLICATIVO",aMatRet[1],cCodPeg)
			cVerApl := u_CBPEGCON("VERSAOAPLICATIVO",aMatRet[1],cCodPeg)
			cFabApl := u_CBPEGCON("FABRICANTEAPLICATIVO",aMatRet[1],cCodPeg)
		EndIf


	// Ajusta cabecalho
		For nI:=1 To Len(aMatRet[1])
			If !Empty(aMatRet[1,nI,2])
				AaDd(aMatC,aMatRet[1,nI])
			EndIf
		Next


	// Tipos de Guias Prestador para Operadora TISS <= 2.02.03
		cTpGuias :=	"GUIACONSULTA,"							//Lote Guias
		cTpGuias +=	"GUIASP_SADT,"							//Lote Guias
		cTpGuias +=	"GUIAHONORARIOINDIVIDUAL,"				//Lote Guias
		cTpGuias +=	"GUIARESUMOINTERNACAO,"					//Lote Guias
		cTpGuias +=	"GUIAODONTOLOGIA,"				   		//Lote Guias 					- Pendente
		cTpGuias +=	"GUIACONSULTAREAPRESENTACAO,"			//Lote Guias
		cTpGuias +=	"GUIASP_SADTREAPRESENTACAO,"			//Lote Guias
		cTpGuias +=	"GUIAHONORARIOINDIVIDUALREAPRESENTACAO,"//Lote Guias
		cTpGuias +=	"GUIARESUMOINTERNACAOREAPRESENTACAO,"	//Lote Guias
		cTpGuias +=	"GUIAODONTOLOGIAREAPRESENTACAO,"		//Lote Guias 					- Pendente
		cTpGuias +=	"GUIASOLICITACAOSADT,"                  //Solicitacao Procedimento
		cTpGuias +=	"GUIASOLICINTERNACAO,"					//Solicitacao Procedimento
		cTpGuias +=	"GUIASOLICITACAOPRORROGACAO,"			//Solicitacao Procedimento
		cTpGuias +=	"GUIASOLICITACAOODONTOLOGIA,"			//Solicitacao Procedimento 		- Pendente
		cTpGuias +=	"VERIFICAELEGIBILIDADE,"				//Verifica Elegibilidade
		cTpGuias +=	"DADOSGUIA,"							//Cancela Guia
		cTpGuias +=	"CANCELA_GUIA,"							//Cancela Guia
		cTpGuias +=	"IDENTIFICACAOSOLICITACAO,"             //Solicitacao Status Autorizacao
		cTpGuias +=	"SOLICITACAODEMONSTRATIVORETORNO,"		//Solicitacao Demostrativo
		cTpGuias +=	"DEMONSTRATIVOANALISECONTA,"			//Demonstrativos Retorno
		cTpGuias +=	"DEMONSTRATIVOODONTOLOGIA,"             //Demonstrativos Retorno
		cTpGuias +=	"DEMONSTRATIVOPAGAMENTO,"               //Demonstrativos Retorno
		cTpGuias +=	"DETALHEPROTOCOLO,"						//Solicitacao Status Protocolo
		cTpGuias += "RECURSOGUIA,"                          //solicitação de recurso de glosa
		cTpGuias += "RECURSOPROTOCOLO"						//solicitação de recurso de glosa

	// Procura o tipo de guia - PLSPCONGR
		cGuia := u_CBPEGCON(cTpGuias,"",aMatRet[2],"E",nil,.F.,nil,cCodPeg)

		If !Empty(cGuia)
			nPos	 := aScan(aMatRet[2],{|x|x[1] == cGuia },(nPos+1) )
			nPosAux	 := nPos

			While nPosAux > 0
				For nI:=1 To (nPos-1)
					AaDd(aMatAux,aMatRet[2,nI])
				Next
				nPosNext := aScan(aMatRet[2],{|x|x[1] == cGuia },(nPosAux+1) )
				If nPosAux>nPos .And. nPosNext == 0
					nPosNext := Len(aMatRet[2])+1
				EndIf
				If nPosNext > 0
					For nI:=nPosAux To (nPosNext-1)
						AaDd(aMatAux,aMatRet[2,nI])
					Next
				ElseIf nPosAux == nPos
					aMatAux := aMatRet[2]
				EndIf
				nPosAux := nPosNext
				If Len(aMatAux) > nPos
					For nI:=1 To Len(aMatAux)
						If !Empty(aMatAux[nI,2])
							AaDd(aMatNew,aMatAux[nI])
						EndIf
					Next
					AaDd(aMatM,aMatNew)
				EndIf
				If nPosNext == Len(aMatRet[2])+1
					nPosAux := 0
				EndIf
				aMatAux := {}
				aMatNew := {}
			EndDo
		Else
			u_CABLOGX("Tipo de guia n�o encontrado ( "+cTpGuias+" ) ",.F.) //"Tipo de guia não encontrado ( "
		EndIf
	Else

		// Tipos de Guias Prestador para Operadora
		cTpGuias :=	u_C973TpGui()


		// Procura o tipo de guia
		cGuia := u_CBTPGUIA(cTpGuias, aDados)

		If !Empty(cGuia)
			nPos	 := aScan(aDados,{|x| StrTran(StrTran(x[1],"-",""),"_","") == StrTran(StrTran(cGuia,"-",""),"_","") },(nPos+1) )
			nPosAux	 := nPos

			//  cabecalho														 					³
			For nI:=1 To (nPos-1)
				If !Empty(aDados[nI,3])
					AaDd(aMatC,aDados[nI])
				EndIf
			Next

			While nPosAux > 0
				For nI:=1 To (nPos-1)
					AaDd(aMatAux,aDados[nI])
				Next
				nPosNext := aScan(aDados,{|x| StrTran(StrTran(x[1],"-",""),"_","") == StrTran(StrTran(cGuia,"-",""),"_","") },(nPosAux+1) )
				If nPosAux>nPos .And. nPosNext == 0
					nPosNext := Len(aDados)+1
				EndIf
				If nPosNext > 0
					For nI:=nPosAux To (nPosNext-1)
						AaDd(aMatAux,aDados[nI])
					Next
				ElseIf nPosAux == nPos
					aMatAux := aDados
				EndIf
				nPosAux := nPosNext
				If Len(aMatAux) > nPos
					For nI:=1 To Len(aMatAux)
						If !Empty(aMatAux[nI,3])
							AaDd(aMatNew,aMatAux[nI])
						EndIf
					Next
					AaDd(aMatM,aMatNew)
				EndIf
				If nPosNext == Len(aDados)+1
					nPosAux := 0
				EndIf
				aMatAux := {}
				aMatNew := {}
			EndDo
		Else
			u_CABLOGX("Tipo de guia n�o encontrado ( "+cTpGuias+" ) ",.F.) //"Tipo de guia não encontrado ( "
		EndIf

	EndIf


// Verifica se em consulta ou sp-sadt ou internacao
	Do Case
	Case cGuia $ "GUIACONSULTA,GUIACONSULTAREAPRESENTACAO"
		cTipo 	:= "1"
	Case cGuia $ "GUIASOLICITACAOSADT,GUIASP_SADT,GUIASP_SADTREAPRESENTACAO,SOLICITACAOSP_SADT,GUIASPSADT"
		cTipo 	:= "2"
	Case cGuia $ "GUIASOLICINTERNACAO,GUIASOLICITACAOPRORROGACAO,GUIAHONORARIOINDIVIDUAL,GUIAHONORARIOINDIVIDUALREAPRESENTACAO,GUIARESUMOINTERNACAO,GUIARESUMOINTERNACAOREAPRESENTACAO,SOLICITACAOINTERNACAO,SOLICITACAOPRORROGACAO"
		cTipo 	:= "3"
	Case cGuia $ "GUIAODONTOLOGIA,GUIAODONTOLOGIAREAPRESENTACAO,GUIAODONTO"
		cTipo 	:= "4"
	EndCase


// Verifica tipo de transacao recebida e o retorno
	If TISVERS < "3" .AND. Len(aMatRet) > 0 .AND. Len(aMatRet[1]) > 0
		cTpTran  := u_CBPEGCON("TIPOTRANSACAO",aMatRet[1],cCodPeg)
		cNumeSeq := u_CBPEGCON("SEQUENCIALTRANSACAO",aMatRet[1],cCodPeg)

	// Dados para informacao do destino do retorno
		cTagOri	 := "registroANS"
		cOrigem  := u_CPEGCONR(Upper(cTagOri),'\CABECALHO\ORIGEM\',aMatRet[1],nil,nil,nil,nil,cCodPeg)
		If Empty(cOrigem)
			cTagOri	 := 'CPF'
			cOrigem  := AllTrim( u_CPEGCONR(Upper(cTagOri),"CABECALHO\ORIGEM\CODIGOPRESTADORNAOPERADORA",aMatRet[1],nil,nil,nil,nil,cCodPeg) )
			If Empty(cOrigem)
				cTagOri	 := 'CNPJ'
				cOrigem  := AllTrim( u_CPEGCONR(Upper(cTagOri),"CABECALHO\ORIGEM\CODIGOPRESTADORNAOPERADORA",aMatRet[1],nil,nil,nil,nil,cCodPeg) )
				If Empty(cOrigem)
					cTagOri	 := 'cnpjPagador'
					cOrigem  := AllTrim( u_CPEGCONR(Upper(cTagOri),"CABECALHO\ORIGEM",aMatRet[1],nil,nil,nil,nil,cCodPeg) )
					If Empty(cOrigem)
						cTagOri	 := 'codigoPrestadorNaOperadora'
						cOrigem  := u_CPEGCONR(Upper(cTagOri),"CABECALHO\ORIGEM\CODIGOPRESTADORNAOPERADORA",aMatRet[1],nil,nil,nil,nil,cCodPeg)
					EndIf
				EndIf
			EndIf
		EndIf
	ElseIf (TISVERS >= "3")
		cTpTran  := u_CVLRTAGXML(aDados, "TIPOTRANSACAO")
		cNumeSeq := u_CVLRTAGXML(aDados, "SEQUENCIALTRANSACAO")

	// Dados para informacao do destino do retorno
		cTagOri	 := "REGISTROANS"
		cOrigem  := u_CVLRTAGXML(aDados, "\CABECALHO\ORIGEM\" + cTagOri)
		If Empty(cOrigem)
			cTagOri	 := 'CPF'
			cOrigem  := u_CVLRTAGXML(aDados, "\CABECALHO\ORIGEM\IDENTIFICACAOPRESTADOR\" + cTagOri)
			If Empty(cOrigem)
				cTagOri	 := 'CNPJ'
				cOrigem  := u_CVLRTAGXML(aDados, "\CABECALHO\ORIGEM\IDENTIFICACAOPRESTADOR\" + cTagOri)
				If Empty(cOrigem)
					cTagOri	 := 'codigoPrestadorNaOperadora'
					cOrigem  := u_CVLRTAGXML(aDados, "\CABECALHO\ORIGEM\IDENTIFICACAOPRESTADOR\" + cTagOri)
				EndIf
			EndIf
		EndIf
	EndIf



// Tipo de transacao e retorno
	Do Case
	Case cTpTran $ "ENVIO_LOTE_GUIAS,RE_APRESENTACAO_GUIA"
		cTranRet := "PROTOCOLO_RECEBIMENTO=protocoloRecebimento"
	Case cTpTran == "SOLICITACAO_PROCEDIMENTOS"
		If (TISVERS < "3")
			cTranRet := "RESPOSTA_SOLICITACAO=autorizacaoServico"//AUTORIZACAO_ODONTOLOGIA=autorizacaoServico
		Else
			cTranRet := "RESPOSTA_SOLICITACAO=autorizacaoProcedimento"
		EndIf
	Case cTpTran $ "SOLICITA_STATUS_AUTORIZACAO,STATUS_AUTORIZACAO"
		cTranRet := "STATUS_AUTORIZACAO=situacaoAutorizacao"
	Case cTpTran == "CANCELA_GUIA"
		cTranRet := "CANCELAMENTO_GUIA_RECIBO=reciboCancelaGuia"
	Case cTpTran == "VERIFICA_ELEGIBILIDADE"
		cTranRet := "SITUACAO_ELEGIBILIDADE=respostaElegibilidade"
	Case cTpTran == "SOLIC_STATUS_PROTOCOLO"
		cTranRet := "SITUACAO_PROTOCOLO=situacaoProtocolo"
	Case cTpTran == "SOLIC_DEMONSTRATIVO_RETORNO"
		cTranRet := "DEMONSTRATIVO_PAGAMENTO=demonstrativosRetorno_demonstrativoPagamento,"+;
			"DEMONSTRATIVO_ANALISE_CONTA=demonstrativosRetorno_demonstrativoAnaliseConta,"+;
			"DEMONSTRATIVO_ODONTOLOGIA=demonstrativosRetorno_demonstrativoPagamentoOdonto"
	Case cTpTran == "SOLIC_STATUS_RECURSO_GLOSA"
		cTranRet := "RESPOSTA_RECURSO_GLOSA=respostaRecursoGlosa"
	Case cTpTran == "RECURSO_GLOSA"
		cTranRet := "RECEBIMENTO_RECURSO_GLOSA=recebimentoRecursoGlosa"
	EndCase


// Processamento
	If lOk
		//  Verifica tipo de transacao com a transacao
		If At(cGuia,"GUIASOLICITACAOSADT,SOLICITACAOSP_SADT,SOLICITACAOSPSADT,GUIASOLICINTERNACAO,SOLICITACAOINTERNACAO,GUIASOLICITACAOPRORROGACAO,SOLICITACAOPRORROGACAO,GUIASOLICITACAOODONTOLOGIA,GUIAODONTO") > 0 .And. cTpTran=="ENVIO_LOTE_GUIAS"
			u_CABLOGX("Tipo de transa��o ( "+cTpTran+" ) inv�lido para o tipo de guia ( "+cGuia+" ) ",.F.)	 //"Tipo de transação ( "###" ) invalido para o tipo de guia ( "###" ) "
		EndIf

		If (TISVERS < "3")

		// Mostra log de processamento
			if !l974Xml
				If !lOnline .AND. !lBg
					If GetRpoRelease()=="R1.1"
						oSelf:SetRegua1(Len(aMatM))
					Else
						ProcRegua(Len(aMatM))
					EndIf
				EndIf
			endIf

		// Case
			Do Case

			Case cTpTran $ "ENVIO_LOTE_GUIAS,RE_APRESENTACAO_GUIA"
				nTotGui := Len(aMatM)

				if l974Xml .And. !lBg
					oProcess:setRegua2(nTotGui)
				endIf

				For nI:=1 To nTotGui

					If lOk
						if l974Xml .And. !lBg
							oProcess:IncRegua2("Guia ["+cValToChar(nI)+"] do total ["+cValToChar(nTotGui)+"]")
						endIf

						xRft := u_CBLGSP( cGuia,cNomeArq,cDatHor,aMatC,aMatM[nI],lHasAr,lHasCo, .F.,cCodPeg,lOk,nI, lBg, l974Xml)
						AaDd( aRet, xRft)
						If !lProcLog
							Exit
						EndIf
					EndIf
				Next

				// Mostra log de processamento

				If lProcLog
					u_CBMOSPRC(aMatM,aRet,cCodPeg)
				EndIf

				lProcLog := .T.

			Case cTpTran == "SOLICITACAO_PROCEDIMENTOS"
				For nI:=1 To Len(aMatM)
					If lOk
						xRft := u_CBLGSP( cGuia,cNomeArq,cDatHor,aMatC,aMatM[nI],lHasAr,lHasCo,.F.,cCodPeg,lOk,/*nSeqGui*/ ,lBg, l974Xml )
						AaDd( aRet, xRft )
						If !lProcLog
							Exit
						EndIf
					EndIf
				Next

				// Mostra log de processamento
				If lProcLog
					if l974Xml .And. !lBg
						oProcess:IncRegua2("Gravando Log da Importacao!")
					endIf
					u_CBMOSPRC(aMatM,aRet,cCodPeg)
				EndIf
				lProcLog := .T.

			Case cTpTran == "SOLICITA_STATUS_AUTORIZACAO"
				For nI:=1 To Len(aMatM)
					If lOk
						If nI<Len(aMatM)
							AaDd(aMatM[nI], aMatM[ Len(aMatM) , Len(aMatM[Len(aMatM)]) ] )
						EndIf
						AaDd( aRet, u_cabaSA( cGuia,cNomeArq,cDatHor,aMatC,aMatM[nI],lHasAr,lHasCo,cCodPeg ) )
					EndIf
				Next

			Case cTpTran == "CANCELA_GUIA"
				For nI:=1 To Len(aMatM)
					If lOk
						AaDd( aRet, u_cabCG( cGuia,cNomeArq,cDatHor,aMatC,aMatM[nI],lHasAr,lHasCo,cCodPeg ) )
					EndIf
				Next

			Case cTpTran == "VERIFICA_ELEGIBILIDADE"
				AaDd( aRet, u_CABVE( cGuia,cNomeArq,cDatHor,aMatC,aMatM[1],lHasAr,lHasCo,cCodPeg ) )

			Case cTpTran == "SOLIC_STATUS_PROTOCOLO"
				If lOk
					aRetAux := u_CABSP( cGuia,cNomeArq,cDatHor,aMatC,aMatM[1],lHasAr,lHasCo,cCodPeg )
					For nI:=1 To Len(aRetAux[2])
						aRetAux[1,9] := aRetAux[2,nI,1]
						AaDd( aRet, { aClone(aRetAux[1]),aRetAux[2,nI,2]} )
					Next
				EndIf

			Case cTpTran == "SOLIC_DEMONSTRATIVO_RETORNO"
			OtherWise
				u_CABLOGX("Transac��o n�o definida nos schemas ( "+cTpTran+" ) ",.F.)//"Transação não definida nos Schemas ( "###" ) "
			EndCase

		// Log do Fim da gravacao
		Else // TISS 3.0

	// TISS 3.0
			If !PlsAliasExi("BVR") .AND. cTpTran $ "ENVIO_LOTE_GUIAS,RE_APRESENTACAO_GUIA,SOLICITACAO_PROCEDIMENTOS"
				nTotGui := Len(aMatM)
			// Ajusta posiçao do Array TISS 2 x TISS 3
				PlsAjsArT(@aMatC)
				if l974Xml .And. !lBg
					oProcess:setRegua2(nTotGui)
				endIf

				For nI:=1 To nTotGui
					PlsAjsArT(@aMatM, nI)
					If lOk
						If l974Xml .And. !lBg
							oProcess:IncRegua2("Guia ["+cValToChar(nI)+"] do total ["+cValToChar(nTotGui)+"]")
						endIf

						xRft := u_CBLGSP3( cGuia,cNomeArq,cDatHor,aMatC,aMatM[nI],lHasAr,lHasCo, .F.,cCodPeg,lOk,nI,/*aMatBWT*/, lBg, l974Xml)

						AaDd( aRet, xRft)
						If !lProcLog
							Exit
						EndIf
					EndIf
				Next

			// Mostra log de processamento

				If lProcLog
					u_CBMOSPRC(aMatM,aRet,cCodPeg)
				EndIf
				lProcLog := .T.
			Else
				If PlsAliasExi("BVR")
					BVR->(DbSelectArea("BVR"))
					BVR->(DbSetOrder(1)) //BVR_FILIAL+BVR_TISVER+BVR_TRANS
					If cTpTran $ "ENVIO_LOTE_GUIAS,RE_APRESENTACAO_GUIA,SOLICITACAO_PROCEDIMENTOS"
						lExisBVR := (BVR->(MsSeek(xFilial("BVR")+TISVERS+cTpTran)))
					EndIf
					If cTpTran $ "ENVIO_LOTE_GUIAS,RE_APRESENTACAO_GUIA,SOLICITACAO_PROCEDIMENTOS" .AND. !lExisBVR
						nTotGui := Len(aMatM)
					// Ajusta posiçao do Array TISS 2 x TISS 3
						PlsAjsArT(@aMatC)
						if l974Xml .And. !lBg
							oProcess:setRegua2(nTotGui)
						endIf

						If IsInCallStack("PLIMPLOT")
					    // Processamento multi-thread
						//xRft := U_PLSIMPFST(oProcess,nTotGui,aMatM,lOk,l974Xml,aRet,cGuia,cNomeArq,cDatHor,aMatC,lHasAr,lHasCo,cCodPeg,aMatBWT)	//	TUXB79
							xRft := U_PLSIMPFST(oProcess,nTotGui,aMatM,lOk,l974Xml,aRet,cGuia,cNomeArq,cDatHor,aMatC,lHasAr,lHasCo,cCodPeg)
						//	Removido o parametro aMatBWT, por alterar o conteudo do aPartic (Equipe Informada no XML), no PLS720IBD7()
						// 	e não gerava o BD7 igual ao DB4 quando a equipe não era informada no XML
							aRet := aClone(xRft)
						Else

							For nI:=1 To nTotGui
								PlsAjsArT(@aMatM, nI)
								If lOk
									If l974Xml .And. !lBg
										oProcess:IncRegua2("Guia ["+cValToChar(nI)+"] do total ["+cValToChar(nTotGui)+"]")
									endIf

									xRft := u_CBLGSP3(cGuia, cNomeArq, cDatHor, aMatC, aMatM[nI], lHasAr, lHasCo, .F., cCodPeg, lOk, nI,/*aMatBWT*/, lBg, l974Xml)

									AaDd( aRet, xRft)
									If !lProcLog
										Exit
									EndIf
								EndIf
							Next
						EndIf

					// Mostra log de processamento

						If lProcLog
							u_CBMOSPRC(aMatM,aRet,cCodPeg)
						EndIf
						lProcLog := .T.

					ElseIf (BVR->(MsSeek(xFilial("BVR")+TISVERS+cTpTran)))
						nLines := MLCount( BVR->BVR_EXPVLD )

						For nI := 1 to nLines
							if !(empty(memoLine(BVR->BVR_EXPVLD,,nI)))
								cExpVld += alltrim(strTran(strTran(memoLine(BVR->BVR_EXPVLD,,nI), chr(10), ""), chr(13),""))
							endIf
						next nI


					// Comentado o tratamento do erro pois conflitava com a execução de importaçao das guias anter
					//Begin Sequence
						xRetTrans := &(cExpVld)

						If (ValType(xRetTrans) == "C")
							//caso a funcao da transacao retorne um dado do tipo string, quer dizer que o cliente customizou a transacao na tabela BVR e retornou somente o XML
							Return { xRetTrans }
						ElseIf (ValType(xRetTrans) == "A")
							aRetTrans := xRetTrans
						EndIf
					//End Sequence
					//ErrorBlock(oError)
						cAteRN := ""

						For nI := 1 To Iif (len(aRetTrans) > 0, len(aRetTrans), 1)
							If (cTpTran $ "VERIFICA_ELEGIBILIDADE,CANCELA_GUIA,SOLIC_STATUS_PROTOCOLO,SOLICITA_STATUS_AUTORIZACAO,RECURSO_GLOSA,SOLIC_STATUS_RECURSO_GLOSA,SOLIC_DEMONSTRATIVO_RETORNO")

							//Preciso Ajustar para qual tipo de relatório é o certo. cTipoRD possui a informação
								IIF (cTpTran == "SOLIC_DEMONSTRATIVO_RETORNO", cTranRet := cTipoRD, "")

								cCodRP := u_CVLRTAGXML(aDados, "\DADOSPRESTADOR\CPFCONTRATADO,\DADOSCONTRATADO\CPFCONTRATADO", nI)
								cCodRP := cCodRP+Space( TamSX3("BAU_CPFCGC")[1]-Len(cCodRP) )
								nIdx := 4
								If (Empty(cCodRP))
									cCodRP := u_CVLRTAGXML(aDados, "\DADOSPRESTADOR\CNPJCONTRATADO,\DADOSCONTRATADO\CNPJCONTRATADO", nI)
									If (Empty(cCodRP))
										cCodRP := u_CVLRTAGXML(aDados, "\DADOSPRESTADOR\CODIGOPRESTADORNAOPERADORA,\DADOSCONTRATADO\CODIGOPRESTADORNAOPERADORA", nI)
										nIdx := 1
									EndIf
								EndIf

								cCodRda := ""
								cNomRda := ""
								cTpCab := ""
								cCCCab := ""
								cCNES := ""
								BAU->( DbSetOrder( nIdx ) ) //BAU_FILIAL + BAU_CPFCGC ou  BAU_CODIGO ou BAU_CODBB0
								If BAU->( MsSeek( xFilial("BAU")+cCodRP ) )
									cCodRda := BAU->BAU_CODIGO
									cNomRda := AllTrim(BAU->BAU_NOME)
									cTpCab  := AllTrim(BAU->BAU_TIPPE)
									cCCCab  := AllTrim(BAU->BAU_CPFCGC)
									cCNES 	:= AllTrim(BAU->BAU_CNES)
								EndIf

								cMatric := u_CVLRTAGXML(aDados, "\NUMEROCARTEIRA", nI)
								cNomeUsu := u_CVLRTAGXML(aDados, "\NOMEBENEFICIARIO", nI)
								dDatPro := u_CVLRTAGXML(aDados, "\DATAREGISTROTRANSACAO", nI)
								cAteRN := ""
								If (cTpTran $ "CANCELA_GUIA,SOLIC_STATUS_PROTOCOLO,SOLICITA_STATUS_AUTORIZACAO")
									If (cTpTran $ "SOLIC_STATUS_PROTOCOLO")
										cNumAut := aRetTrans[nI, 2]
										cNumeSeq := u_CVLRTAGXML(aDados, "\NUMEROPROTOCOLO", nI)
									Else
										cNumAut := u_CVLRTAGXML(aDados, "\NUMEROGUIAPRESTADOR", nI)
										cNumAut2 := u_CVLRTAGXML(aDados, "\NUMEROGUIAOPERADORA", nI)
									EndIf

									//Pesquisa Guia pelo Numero do Prestador ou da Operadora
									If !Empty(cNumAut) .OR. !Empty(cNumAut2)
										BEA->( DbSetOrder(1) ) //BEA_FILIAL + BEA_OPEMOV + BEA_ANOAUT + BEA_MESAUT + BEA_NUMAUT + DTOS(BEA_DATPRO) + BEA_HORPRO
										If !BEA->( MsSeek( xFilial("BEA")+cNumAut ) )
											If BEA->( MsSeek( xFilial("BEA")+cNumAut2 ) )
												cNumAut := cNumAut2
												lAchouNAut := .T.
											EndIf
										Else
											lAchouNAut := .T.
										EndIf
									EndIf

									If !Empty(cNumAut)
										If !lAchouNAut
											u_CABLOGX("Guia n�o encontrada -> ( "+cNumAut+" ) ",.F.,,,"2906") //"Guia não encontrada -> ( "###" ) "
										Else

											If (cTpTran == "SOLIC_STATUS_PROTOCOLO" .OR. cTpTran == "SOLICITA_STATUS_AUTORIZACAO")

											// Se for atendimento de intercambio devolve a matricula antiga
												cAteRN := If(BEA->BEA_ATERNA=='1','S','N')
												If BEA->BEA_TIPUSR == "01"
													cMatric := BEA->BEA_MATANT
												Else
													cMatric := BEA->(BEA_OPEUSR+BEA_CODEMP+BEA_MATRIC+BEA_TIPREG+BEA_DIGITO)
												EndIf
												cNomeUsu := BEA->BEA_NOMUSR

												If (cTpTran == "SOLIC_STATUS_PROTOCOLO")
													dDatPro := BEA->BEA_DTDIGI //Data de envio do lote de guias de cobrança para a operadora
													if(len(aRetTrans[nI]) > 9)
														cStTiss := aRetTrans[nI,10]
													endIf
												ElseIf (cTpTran == "SOLICITA_STATUS_AUTORIZACAO")
													dDatPro := BEA->BEA_VALSEN //Data correta da validade na libera��o
												EndIf
											Else
												dDatPro := BEA->BEA_DATPRO
											EndIf
										EndIf
									Else
										u_CABLOGX("Guia n�o encontrada -> ( "+cNumAut+" ) ",.F.,,,"2906") //"Guia não encontrada -> ( "###" ) "
									EndIf
								EndIf
							EndIf

							aRetAux := {}
							aAdd(aRetAux, cTpCab) 					//1
							aAdd(aRetAux, cCCCab) 					//2
							aAdd(aRetAux, cCodRda) 				//3
							aAdd(aRetAux, cNomRda) 				//4
							aAdd(aRetAux, cTpCab) 					//5
							aAdd(aRetAux, cCCCab) 					//6
							aAdd(aRetAux, cMatric) 				//7
							aAdd(aRetAux, cNomeUsu) 				//8
							aAdd(aRetAux, cNumeSeq) 				//9
							aAdd(aRetAux, cNumAut) 				//10
							aAdd(aRetAux, lHonorario) 				//11
							aAdd(aRetAux, lResIntern) 				//12
							aAdd(aRetAux, cNumeSeq) 				//13
							aAdd(aRetAux, Iif(ValType(dDatPro) == "D",dDatPro, u_CBAJUDAT(dDatPro))) 		//14
							aAdd(aRetAux, cCodRda) 				//15
							aAdd(aRetAux, cCNES)					//16
							aAdd(aRetAux, 0)//17
							aAdd(aRetAux, cAteRN)//18
							aAdd(aRetAux, cStTiss) // 19

							aAdd(aDadosRet, aRetAux)
						Next

						For nI := 1 To Len(aDadosRet)
							aAdd(aRet, { ;
								Iif(Len(aDadosRet) < nI, aDadosRet[Len(aDadosRet)], aDadosRet[nI]), ;
								Iif(Len(aRetTrans) == 0, Nil, Iif(Len(aRetTrans) < nI, aRetTrans[Len(aRetTrans)], aRetTrans[nI])) ;
								})
						Next

					EndIf
				EndIf
			EndIf
		EndIf
		u_CABLOGX("",,.F.)
		u_CABLOGX("Dura��o do processamento da guia (checagem de regras e grava��o da guia) ( "+AllTrim( Str( (Seconds()-nIniSeg)/60,12,3) )+" ) ",,.F.) //### //### //"Duração do processamento da guia (checagem de regras e gravação da guia) ( "###" ) "
		u_CABLOGX("",,.F.)
	EndIf

// Retorno com dados mais nao consegue processar
	If Len(aMatM)>0 .And. Len(aRet)==0
		aRet := {{}}
	EndIf

Return( { aRet,cTranRet,cNumeSeq,cOrigem,cTagOri,cNomApl,cVerApl,cFabApl, aRetTrans } )

/*/{Protheus.doc} u_CBMOSPRC
Mostra dados do processamento da guia
@type function
@author TOTVS
@since 22.05.07
@version 1.0
/*/
User Function CBMOSPRC(aMatM,aRet,cCodPeg)
	LOCAL nI,nY
	LOCAL lCab	  := .T.
	LOCAL lIntRes := .F.
	LOCAL aMatCri := {}
	LOCAL aMatInf := {}
	LOCAL aRetCri := {}
	LOCAL cMsgS	  := ""
	LOCAL cMsgN	  := ""
	LOCAL cMsgAT  := ""
	LOCAL cMsgNT  := "NAO AUTORIZADA"   //"NAO AUTORIZADA"
	LOCAL cMsgAP  := "AUTORIZACAO PARCIAL"  //"AUTORIZACAO PARCIAL"
	LOCAL nTotNGrv:= 0
	LOCAL nTotAP  := 0
	LOCAL nTotAT  := 0
	LOCAL nTotNT  := 0
	LOCAL nVAprTot:= 0
	LOCAL cTexto := ""
	LOCAL cCodInt := PlsIntPAd()
	DEFAULT aMatM :={}
	DEFAULT aRet  :={}


	BXX->(DbSetORder(6))
	If BXX->(MsSeek(xFilial("BXX")+cCodInt+cCodPeg))
		BXX->(Reclock("BXX",.F.))

		If Len(aRet) > 0
			If Len(aRet[1]) > 0


				cTexto := "****** INICIO - INFORMACAO DO PROCESSAMENTO DO ARQUIVO ******"+CRLF
				cTexto += ""+CRLF

				For nI:=1 To Len(aRet)

					If aRet[nI,1,11] .Or. aRet[nI,1,12]
						lIntRes := .T.
						cMsgN   := "GUIA NAO ATUALIZADA"
						cMsgS   := "GUIA ATUALIZADA"
						cMsgAT  := ""
						cMsgNT  := ""
						cMsgAP  := ""
					Else
						cMsgN   := "GUIA NAO GRAVADA"
						cMsgS   := "GUIA GRAVADA"
						cMsgAT  := ""
						cMsgNT  := ""
						cMsgAP  := ""
					EndIf
					If Len(aRet[nI,2]) > 0
						cTexto +=  IiF( Empty(aRet[nI,2,2]) , cMsgN+"  --  " , cMsgS + " -- Nota (" + aRet[nI,2,2] + ") " )  + IiF( lIntRes , "" , Iif( aRet[nI,2,1] .And. Len(aRet[nI,2,4] ) > 0 , cMsgAP , IiF( aRet[nI,2,1] , cMsgAT , cMsgNT ) ) )+CRLF
						If Empty(aRet[nI,2,2])
							nTotNGrv++
						EndIf
						If aRet[nI,2,1] .And. Len(aRet[nI,2,4])>0
							nTotAP++
						ElseIf aRet[nI,2,1]
							nTotAT++
						Else
							nTotNT++
						EndIf

						aMatInf := aRet[nI,2,10]
						If Len(aMatInf)>0
							cTexto += Space(3)+"** INFORMACOES COMPLEMENTARES"+CRLF
							For nY := 1 To Len(aMatInf)
								If !Empty(AllTrim(aMatInf[nY,2]))
									If AllTrim(aMatInf[nY,2]) == "NIL"
										cTexto +=  Space(3) + AllTrim(aMatInf[nY,1])+CRLF
									Else
										If AllTrim(aMatInf[nY,1]) == "VALOR TOTAL APR" //"VALOR TOTAL APR"
											cTexto +=   Space(3) + AllTrim(aMatInf[nY,1]) + Space( 25-Len( AllTrim(aMatInf[nY,1]) ) )+" - [ "+AllTrim(TransForm( Val( aMatInf[nY,2] ),PLSMONEY) )+" ]" +CRLF //### //### //" - [ "###" ]"
											nVAprTot += Val( aMatInf[nY,2] )
										Else
											If AllTrim(aMatInf[nY,1]) == 'NUM. GUIA PRESTADOR' .And. Len(aRet[nI,2,4])>0
												cTexto +=  Space(3) + AllTrim(aMatInf[nY,1]) + Space( 25-Len( AllTrim(aMatInf[nY,1]) ) )+" - [ "+AllTrim(aMatInf[nY,2])+" ]"+CRLF   //### //### //" - [ "###" ]"
											Else
												cTexto +=  Space(3) + AllTrim(aMatInf[nY,1]) + Space( 25-Len( AllTrim(aMatInf[nY,1]) ) )+" - [ "+AllTrim(aMatInf[nY,2])+" ]"+CRLF  //### //### //" - [ "###" ]"
											EndIf
										EndIf
									EndIf
								EndIf
							Next
							cTexto +=""+CRLF
						EndIf

						aMatCri := aRet[nI,2,4]
						lCab 	:= .T.
						For nY := 1 To Len(aMatCri)
							If !Empty( aMatCri[nY,2] )
								aRetCri := PLSRETCRI(aMatCri[nY,2])
								If lCab
									cTexto +=""+CRLF
									cTexto +=Space(3)+"** CRITICA(S)"+CRLF   //"** CRITICA(S)"
									cTexto +=""+CRLF
									lCab := .F.
								EndIf
								cExiCri := aMatCri[nY,2]
								cTexto +=Space(3)+"Sistema -> ("+AllTrim(aMatCri[nY,4])+"-"+AllTrim(aMatCri[nY,5])+") -  "+AllTrim(aMatCri[nY,2])+" - "+AllTrim(aMatCri[nY,3])+CRLF //###### //###### //###### //"Sistema -> ("###") -  "###" - "
								cTexto +=Space(3)+"Tiss    -> "+Space( 5+Len( AllTrim(aMatCri[nY,4])+"-"+AllTrim(aMatCri[nY,5]) ) )+AllTrim(aRetCri[1,1]+" - "+aRetCri[1,2])+CRLF //### //### //### //"Tiss    -> "###" - "
							EndIf
						Next
						cTexto +=""+CRLF
					Else
						cTexto += cMsgN + "  --  " + IiF( lIntRes , "" , cMsgNT )+CRLF
						nTotNGrv := Len(aMatM)
					EndIf

				Next
				cTexto +=""+CRLF
				cTexto +="Numero de nota(s) no arquivo     ( "+StrZero(Len(aMatM),10)+" ) "+CRLF //"Numero de nota(s) no arquivo     ( "###" ) "
				If lIntRes
					cTexto +="Numero de nota(s) Atualizada(s)     ( "+StrZero(Len(aMatM)-nTotNGrv-nTotNT,10)+" ) "+CRLF //"Numero de nota(s) Atualizada(s)     ( "###" ) "
					cTexto +="Numero de nota(s) nao Atualizada(s) ( "+StrZero(nTotNGrv+nTotNT,10)+" ) "+CRLF //"Numero de nota(s) não Atualizada(s) ( "###" ) "
				Else
					cTexto +="Numero de nota(s) Gravada(s)     ( "+StrZero(Len(aMatM)-nTotNGrv,10)+" ) "+CRLF //"Numero de nota(s) Gravada(s)     ( "###" ) "
					cTexto +="Numero de nota(s) nao Gravada(s) ( "+StrZero(nTotNGrv,10)+" ) "+CRLF //"Numero de nota(s) não Gravada(s) ( "###" ) "
					cTexto +="--------------------------------------------------------------"+CRLF//"--------------------------------------------------------------"
					cTexto +="Total Apr. Arqv.      ( "+AllTrim(TransForm(nVAprTot,PLSMONEY))+" ) "+CRLF//"Total Apr. Arqv.      ( "###" ) "
				EndIf
				cTexto +=""+CRLF
				cTexto +="****** FIM - INFORMACAO DO PROCESSAMENTO DO ARQUIVO ******"+CRLF//"****** FIM - INFORMAÇÃO DO PROCESSAMENTO DO ARQUIVO ******"
				cTexto +=""+CRLF

				RestArea(BXX->(GetArea()))
				MSMM(,TamSX3("BXX_DETREG")[1],,ansiToOem(cTexto),1,,,"BXX","BXX_CODREG")
			Endif
		Else
			cTexto +=""+CRLF
			cTexto +="****** NADA FOI PROCESSADO ******"+CRLF//"****** NADA FOI PROCESSADO ******"
			cTexto +=""+CRLF

			RestArea(BXX->(GetArea()))
			MSMM(,TamSX3("BXX_DETREG")[1],,ansiToOem(cTexto),1,,,"BXX","BXX_CODREG")

		EndIf
		BXX->(MsUnlock())
	Endif


Return()

/*/{Protheus.doc} u_CBLGSP
Processa guia.. no PLSXMOV (Envio lote guias)
@type function
@author TOTVS
@since 22.05.07
@version 1.0
/*/
User Function CBLGSP(cGuia,cNomeArq,cDatHor,aMatC,aMatM,lHasAr,lHasCo,lLotGui,cCodPeg,lOk,nSeqGui, lBg, l974Xml)
	LOCAL nCont	  	:= 0
	LOCAL nQtd		:= 0
	LOCAL nIdx		:= 0
	LOCAL nPos		:= 1
	LOCAL nPosVlrApr:= 0
	LOCAL nPosXX	:= 1
	LOCAL cTpCab 	:= ""
	LOCAL cCCCab	:= ""
	LOCAL cTipo 	:= ""
	LOCAL cOrigem	:= ""
	LOCAL cObs		:= ""
	LOCAL cSigla  	:= ""
	LOCAL cCrm 	  	:= ""
	LOCAL cUf 	  	:= ""
	LOCAL cCodRP	:= ""
	LOCAL cCodProf	:= ""
	LOCAL cRdaPro  	:= ""
	LOCAL cRdaCon  	:= ""
	LOCAL cRdaOri  	:= ""
	LOCAL cNomRda	:= ""
	LOCAL cNomCont	:= ""
	LOCAL cMatric	:= ""
	LOCAL cNomeUsu	:= ""
	LOCAL cData		:= ""
	LOCAL cHora		:= ""
	LOCAL cDataHora := ""
	LOCAL cDtFimFat := ""
	LOCAL cHrFimFat := ""
	LOCAL cNumSen	:= ""
	LOCAL cNumeLot  := ""
	LOCAL cNumeSeq	:= ""
	LOCAL cNumImp	:= ""
	LOCAL cNumAut	:= ""
	LOCAL cBAUSol 	:= ""
	LOCAL cLocalExec:= "1"
	LOCAL cTipoGrv  := "1"
	LOCAL cNumEvo	:= ""
	LOCAL cCodPad	:= ""
	LOCAL cCodPadAlt:= ""
	LOCAL cTpPessoa	:= ""
	LOCAL cCPFCGC	:= ""
	LOCAL cCNES		:= ""
	LOCAL cIdenfic  := ""
	LOCAL cNumImpOp	:= ""
	LOCAL cNumEvoOp := ""
	LOCAL cCrmRda   := ""
	LOCAL cSlgRda   := ""
	LOCAL cEstRda   := ""
	LOCAL cNomPre	:= ""
	LOCAL cPosPro	:= ""
	LOCAL cOpeExe	:= ""
	LOCAL cProExe	:= ""
	LOCAL cCodPro   := ""
	LOCAL cCodProAlt:= ""
	LOCAL cNumSolInt:= ""
	LOCAL cGuiPri	:= ""
	LOCAL cNumeDNAux:= ""
	LOCAL cNumeDN	:= ""
	LOCAL cTipPro	:= ""
	LOCAL cDescric	:= ""
	LOCAL cConPrEx 	:= ""
	LOCAL cNomRdEx 	:= ""
	LOCAL cTagDia2  := ""
	LOCAL cTagDia3	:= ""
	LOCAL cTagDia4	:= ""
	LOCAL cTagDia5	:= ""
	LOCAL cTipPOr	:= ""
	LOCAL cSeqBXX   := ""
	LOCAL cVersao   := StrTran(TISVERS,"_",".")
	LOCAL nTamObs   := (TamSX3("BEA_MSG01")[1])
	LOCAL cOpeMov	:= PlsIntPad()
	LOCAL cArqImp   := Left( cNomeArq,At(".",cNomeArq)-1 )
	LOCAL lEvolu	:= .F.
	LOCAL lInter	:= .F.
	LOCAL lResInt   := .F.
	LOCAL lHonor	:= .F.
	LOCAL lAchouVlr := .F.
	LOCAL lImpXml   := .T.
	LOCAL aTpPRec	:= {}
	LOCAL aRet    	:= {}
	LOCAL aRetAux	:= {}
	LOCAL aDados  	:= {}
	LOCAL aMatIte 	:= {}
	LOCAL aItens  	:= {}
	LOCAL aRetTag	:= {}
	LOCAL aMatPro	:= {}
	LOCAL aMatEqu	:= {}
	LOCAL bBlockXml := nil
	Local cCodldp	:=	""
	Local cChave	:=	""
	LOCAL nIndUt	:=	0
	LOCAL nInd1		:= 0
	LOCAL nI		:= 1
	LOCAL nE		:= 1
	LOCAL nP		:= 1
	LOCAL lNMudFs	:= .F.
	LOCAL dDatAcat  := dDataBase
	LOCAL nZ		:= 0
	LOCAL nt		:= 0
	LOCAL cCnpjPres :=""
	LOCAL cTipFat	:= ""
	LOCAL cEspBD6	:= ""
	LOCAL cEspPe	:= ""
	LOCAL aRetPe := {}
	Local nLimite	:= 0

	DEFAULT lLotGui	:= .F.
	DEFAULT cCodPeg := ""
	DEFAULT lOk		:= lOkXml
	DEFAULT nSeqGui := 0
	Default lBg	:= .F.
	Default l974Xml	:= .F.

// Indices
	BAX->( DbSetOrder(1) ) //BAX_FILIAL + BAX_CODIGO + BAX_CODINT + BAX_CODLOC + BAX_CODESP + BAX_CODSUB
	BAQ->( DbSetOrder(4) ) //BAQ_FILIAL + BAQ_CODINT + BAQ_CBOS

// Verifica se em consulta ou sp-sadt ou internacao
	Do Case
	Case cGuia $ "GUIACONSULTA,GUIACONSULTAREAPRESENTACAO"
		cTipo 	:= "1"
		cOrigem	:= "1" //Execucao
		cTipGui	:= "01"
	Case cGuia == "GUIASOLICITACAOSADT"
		cTipo 	:= "2"
		cOrigem	:= "2" //Solicitacao
		cTipGui	:= "02"
		lImpXml	:= .F.
	Case cGuia $ "GUIASP_SADT,GUIASP_SADTREAPRESENTACAO"
		cTipo 	:= "2"
		cOrigem	:= "1" //Execucão
		cTipGui	:= "02"
	Case cGuia == "GUIASOLICINTERNACAO"
		lInter   := .T.
		cTipo 	:= "3"
		cOrigem	:= "2" //Solicitacao
		cTipGui	:= "03"
		lImpXml	:= .F.
	Case cGuia == "GUIASOLICITACAOPRORROGACAO"
		lInter   := .T.
		lEvolu   := .T.
		cTipo 	:= "3"
		cOrigem	:= "2" //Solicitacao
		cTipGui	:= "03"
		lImpXml	:= .F.
	Case cGuia $ "GUIAHONORARIOINDIVIDUAL,GUIAHONORARIOINDIVIDUALREAPRESENTACAO"
		lInter   := .T.
		lHonor	:= .T.
		cTipo 	:= "3"
		cOrigem	:= "1" //Execucao
		cTipGui	:= "06"
	Case cGuia $ "GUIARESUMOINTERNACAO,GUIARESUMOINTERNACAOREAPRESENTACAO"
		lResInt  := .T.
		cTipo 	:= "3"
		cOrigem	:= "1" //Execucao
		cTipGui	:= "05"
	Case cGuia $ "GUIAODONTOLOGIA,GUIAODONTOLOGIAREAPRESENTACAO"
	EndCase

// Verificando se a Peg Já existe  na Importação do XML
// para não criar duas BCI para a mesma RDA com BCI_CODLDP diferentes


	If l974Xml

		BXX->(dbSetOrder(6))//BXX_FILIAL + BXX_CODINT +  BXX_CODPEG
		If BXX->(msSeek(xFilial("BXX")+cOpeMov+cCodPeg))
			cChave   := BXX->BXX_CHVPEG
			dDatAcat := BXX->BXX_DATMOV
		Endif

		BCI->(dbSetOrder(1))//BCI_FILIAL + BCI_CODOPE + BCI_CODLDP + BCI_CODPEG + BCI_FASE + BCI_SITUAC
		If BCI->(msSeek(xFilial("BCI")+cChave)) .and. empty(BCI->BCI_PROCES)
			cCodldp	 := BCI->BCI_CODLDP
		Endif
	//se for imp xml tem q ser igual a 5
		cLocalExec:= "5"
	Endif



// Matriz cabecalho da guia
	AaDd( aDados, {"DATACA"	, dDatAcat } )
	AaDd( aDados, {"TP_CLIENTE"	, "XML" } )											//Tipo de Transacao
	AaDd( aDados, {"CODLDP"		, If (!empty(cCodldp),cCodldp,If(PLSOBRPRDA(),PLSRETLDP(9),PLSRETLDP(2))) } )	//Local de Digitacao

	AaDd( aDados, {"IMPXML"		, lImpXml } )  										//aqui ele define se vai gravar a guia somente ou se vai ter liberacao...

	AaDd( aDados, {"AUDEMP"		, .T. } )  											//Critica da operadora se manda para auditoria
	AaDd( aDados, {"GERSEN"		, Iif(lInter .Or. lEvolu ,.F.,.T.) } )				//Gerar senha de autorizacao
	AaDd( aDados, {"TPGRV"		, "4" } )											//Tipo de Gravacao
	AaDd( aDados, {"TIPOMAT"   	, "" } )											//Matricula Procura a antiga depois a nova
	AaDd( aDados, {"LVALOR"		, .T. } ) 											//indica que o evento sera valorizado
	AaDd( aDados, {"LRETVPF"	, .T. } ) 											//indica que devera ser retornado o valor da participacao financeira
	AaDd( aDados, {"LREGPAGATO"	, .F. } ) 											//indica se ira checar regra de "pagar o evento no ato"
	AaDd( aDados, {"INCAUTIE"  	, .T. } )											//Se o usuario for de intercambio e nao existir ele inclui
	AaDd( aDados, {"TIPO"      	, AllTrim( cTipo ) } )								//Tipo de Guia
	AaDd( aDados, {"ORIGEM"    	, cOrigem } )										//Origem
	AaDd( aDados, {"CHKREG"    	, .T. } ) 											//Se vai checar regras ou nao
	AaDd( aDados, {"ARQIMP"		, cArqImp} ) 										//Nome do Arquivo+Data e Hora
	AaDd( aDados, {"NRAOPE"		, "" } )											//Numero autorizacao operadora
	AaDd( aDados, {"NRAEMP"		, "" } )    										//Numero autorizacao empresa
	AaDd( aDados, {"MSG01"		, "" } )											//Mensagem 1
	AaDd( aDados, {"MSG02"		, "" } )											//Mensagem 2
	AaDd( aDados, {"MSG03"		, "" } )											//Mensagem 3
	AaDd( aDados, {"NATJURI"	, "" } )											//Natureza juridica
	AaDd( aDados, {"AREAABR"	, "" } )								 			//Abrangencia
	AaDd( aDados, {"INTERN" 	, lInter } )										//Interncao
	AaDd( aDados, {"EVOLU"	, lEvolu } )										//Evolucao (Prorrogacao)
	AaDd( aDados, {"HORIND" 	, lHonor } )										//Honorario Individual
	AaDd( aDados, {"RESINT" 	, lResInt } )										//Resumo de Internacao
	AaDd( aDados, {"LNMUDF" 	, .F. } )										//Se nao muda fase para processamento de XML
	AaDd( aDados, {"TIPGUI" 	, cTipGui } )



// Data e hora
	If ExistBlock("PLSXMLDAT")
		aRetTag := ExecBlock( "PLSXMLDAT",.F.,.F.,{cGuia} )
		cData 	:= u_CPEGCONR(aRetTag[1],cGuia+AllTrim(aRetTag[2]),aMatM,nil,.T.,nil,nil,cCodPeg)
	EndIf

// Se entrou no ponto de entrada mais nao retornou nada
	If cTipo == "2" .And. Empty(cData)
		cDataHora := u_CPEGCONR("DATAHORAATENDIMENTO",cGuia,aMatM,nil,.T.,nil,nil,cCodPeg)
		If !Empty(cDataHora)
			cData := SubStr(cDataHora,1,8)
			cHora := SubStr(cDataHora,10,6)
		EndIf
	EndIf

	If cTipo $ "1,2" .Or. (cTipo == "3" .And. cOrigem == "2") .Or. lHonor
		If Empty(cData)
			cData := u_CPEGCONR("DATAEMISSAOGUIA",cGuia,aMatM,nil,nil,nil,nil,cCodPeg)

			If Empty(cData)
				cData := u_CPEGCONR("DATAREGISTROTRANSACAO","\CABECALHO\IDENTIFICACAOTRANSACAO",aMatC,nil,nil,.F.,nil,cCodPeg)

			EndIf
		EndIf
		If Empty(cHora)
		// Foi retirada a inclusão da hora da guia de consulta,
		// pois como não existe tag específica, não podemos arbitrariamente informar um horário.
		// No caso do horário de transação, pode haver complicações se a operadora utilizar
		// pagamento de horário especial, pois se o prestador gerar um xml
		// dentro do horário especial, receberá o adicional indevidamente
			If cTipo $ "1"
				cHora := ""
			Else
				cHora := u_CPEGCONR("HORAREGISTROTRANSACAO","\CABECALHO\IDENTIFICACAOTRANSACAO",aMatC,nil,nil,nil,nil,cCodPeg)
			EndIf
		EndIf
	Else
		cDataHora := u_CPEGCONR("DATAHORAINTERNACAO",cGuia,aMatM,nil,nil,nil,nil,cCodPeg)
		If !Empty(cDataHora)
			cData := SubStr(cDataHora,1,8)
			cHora := SubStr(cDataHora,10,6)
		EndIf
	EndIf


// Data e Hora do Atendimento
	If Len(cHora)>8
		cHora := SubStr(cHora,1,8)
	EndIf

// Mesmo pegando a data no tratamento acima nao deixo atribuir para a matriz³
// pois a data correta e vai ser retirada da tag DADOSATENDIMENTO 		 	³
	If cTipo <> "1"
		AaDd( aDados, {"DATPRO", u_CBAJUDAT(cData) } )
	EndIf
	AaDd( aDados, {"HORAPRO", cHora } )

// Numero da guia principal
	cGuiPri := u_CPEGCONR("NUMEROGUIAPRINCIPAL",cGuia,aMatM,nil,nil,nil,nil,cCodPeg)
	AaDd( aDados, {"GUIPRI" , cGuiPri  } )

// Identificador da guia
	If lEvolu
		cNumImp 	:= u_CPEGCONR("NUMEROGUIAPRESTADOR",cGuia+"\IDENTIFICACAOPRORROGACAO",aMatM,nil,nil,nil,nil,cCodPeg)
		cNumEvo 	:= u_CPEGCONR("NUMEROGUIAPRESTADOR",cGuia+"\IDENTIFICACAOGUIAREFERENCIA",aMatM,nil,nil,nil,nil,cCodPeg)

		cNumImpOp 	:= u_CPEGCONR("NUMEROGUIAOPERADORA",cGuia+"\IDENTIFICACAOPRORROGACAO",aMatM,nil,nil,nil,nil,cCodPeg)
		cNumEvoOp 	:= u_CPEGCONR("NUMEROGUIAOPERADORA",cGuia+"\IDENTIFICACAOGUIAREFERENCIA",aMatM,nil,nil,nil,nil,cCodPeg)

		If !Empty(cNumImpOp)
			cNumImp := cNumImpOp
		EndIf

		If !Empty(cNumEvoOp)
			cNumEvo := cNumEvoOp
		EndIf
	Else
		cNumImp		:= u_CPEGCONR("NUMEROGUIAPRESTADOR",cGuia,aMatM,nil,nil,nil,nil,cCodPeg)
		cNumImpOp	:= u_CPEGCONR("NUMEROGUIAOPERADORA",cGuia,aMatM,nil,nil,nil,nil,cCodPeg)


	// Numero da Senha de autorizacao
		If (cTipo == "2" .Or. cTipo == "3") .And. cOrigem == "1"
			cSlvTag := ""
			If cTipo == "2"
				cSlvTag := "\DADOSAUTORIZACAO"
			Endif
			cNumSen := u_CPEGCONR("SENHAAUTORIZACAO",cGuia+cSlvTag,aMatM,nil,nil,nil,nil,cCodPeg)

			If cTipGui $ "02"
				If Empty(cNumSen) .and. !Empty(cNumImpOp)
					cNumSen := cNumImpOp
				Endif
			Endif

		EndIf
	EndIf
	If GetNewPar("MV_PLSNUIM",.F.)   // Pega o numero da operado ao inves da prestadora para gravação
		cNumImp := cNumImpOp
	Endif

// Pega a solicitacao de internacao
	If lResInt
	//este parametro indica se a operadora vai trabalhar com a senha ou com nro de autorizacao na internacao
		If GetNewPar("MV_PLSENIN",'1') == '1'
			cNumSen := u_CPEGCONR("NUMEROGUIASOLICITACAO",cGuia,aMatM,,.T.,nil,nil,cCodPeg)
			If Empty(cNumSen)
				cSlvTag := "\DADOSAUTORIZACAO"
				cNumSen := u_CPEGCONR("SENHAAUTORIZACAO",cGuia+cSlvTag,aMatM,nil,nil,nil,nil,cCodPeg)
				If Empty(cNumSen)
					cNumSen := u_CPEGCONR("SENHAAUTORIZACAO",cGuia,aMatM,nil,nil,nil,nil,cCodPeg)
				Endif
			Endif
		Else
			cSlvTag := "\DADOSAUTORIZACAO"
			cNumSen := u_CPEGCONR("SENHAAUTORIZACAO",cGuia+cSlvTag,aMatM,nil,nil,nil,nil,cCodPeg)
			If Empty(cNumSen)
				cNumSen := u_CPEGCONR("SENHAAUTORIZACAO",cGuia,aMatM,nil,nil,nil,nil,cCodPeg)
				If Empty(cNumSen)
					cNumSen := u_CPEGCONR("NUMEROGUIASOLICITACAO",cGuia,aMatM,,.T.)
				Endif
			Endif
		Endif
	EndIf
	If lHonor
		If Empty(cNumSen)
			If !Empty(cGuiPri)
				cNumSen := cGuiPri
			Endif
		Endif
	Endif

// Codigo da Operadora ORIGEM
	cRdaOri := AllTrim( u_CPEGCONR("CPF,CNPJ","CABECALHO\ORIGEM\CODIGOPRESTADORNAOPERADORA",aMatC,nil,nil,nil,nil,cCodPeg) )
	cRdaOri := cRdaOri+Space( TamSX3("BAU_CPFCGC")[1]-Len(cRdaOri) )
	nIdx 	:= 4
	If Empty(cRdaOri)
		cRdaOri := AllTrim( u_CPEGCONR("cnpjPagador","CABECALHO\ORIGEM",aMatC,nil,nil,nil,nil,cCodPeg) )
		cRdaOri := cRdaOri+Space( TamSX3("BAU_CPFCGC")[1]-Len(cRdaOri) )
		If Empty(cRdaOri)
			xRdaOri  := u_CPEGCONR("CODIGOPRESTADORNAOPERADORA","CABECALHO\ORIGEM\CODIGOPRESTADORNAOPERADORA",aMatC)
			cRdaOri  := xRdaOri
			If Len(alltrim(xRdaOri)) > TamSX3("BAU_CODIGO")[1]//se eh maior significa que o prestador mandou o cnpj na TAG  de codigo
				nIdx 	 := 4
			Else
				cRdaOri := padr(cRdaOri,6)
				nIdx 	 := 1
			Endif
		EndIf
	EndIf

	If !Empty(cRdaOri)
		BAW->(DbSetOrder(3))
		cRdaAnt := cRdaOri+Space( TamSX3("BAW_CODANT")[1]-Len(cRdaOri) )
		If BAW->(MsSeek(xFilial("BAW")+cOpeMov+cRdaAnt))
			cRdaOri := BAW->BAW_CODIGO
			nIdx 	:= 1
		Endif
	Endif

// RDA
	u_CBIVRDA(cRdaOri,nIdx,,aDados)

// Ponto de entrada
	U_CBXPROF("R",cRdaOri,"1",cNumImp,cOrigem,nIdx,cData,cHora,,NIL,aMatC)
	If BAU->( Found() )
		cRdaOri	  := BAU->BAU_CODIGO
		cNomRda   := AllTrim(BAU->BAU_NOME)
		cTpCab 	  := AllTrim(BAU->BAU_TIPPE)
		cCCCab	  := AllTrim(BAU->BAU_CPFCGC)
		cTipPOr	  := AllTrim(BAU->BAU_TIPPRE)
	Else
		cRdaOri	  := GetNewPar("MV_PLSRDAG",'999999')
		cNomRda   := AllTrim(Posicione("BAU",1,xFilial("BAU")+GetNewPar("MV_PLSRDAG",'999999'),"BAU_NOME"))
		cTpCab 	  := AllTrim(BAU->BAU_TIPPE)
		cCCCab	  := AllTrim(BAU->BAU_CPFCGC)
		cTipPOr	  := AllTrim(BAU->BAU_TIPPRE)
	Endif
	cRdaGuia := cRdaOri

// Informacoes complementares para processamento no plsxmov
	If !Empty(cRdaOri)
		AaDd( aDados, {"RDAORI" , cRdaOri } )
		AaDd( aDados, {"ORINME" , cNomRda } )
		AaDd( aDados, {"ORITPE" , cTpCab } )
		AaDd( aDados, {"ORIDOC" , cCCCab } )
		cNomRda := ""
	EndIf

// Codigo da Operadora DESTINO
	cRegAns  := u_CPEGCONR("REGISTROANS","CABECALHO\DESTINO",aMatC,nil,nil,nil,nil,cCodPeg)
	cCnpjPres:= u_CPEGCONR("CNPJPAGADOR","CABECALHO\DESTINO",aMatC)
	If !Empty(cRegAns)
		BA0->( DbSetOrder(5) ) //BA0_FILIAL+BA0_SUSEP
		If BA0->( MsSeek( xFilial("BA0")+cRegAns ) )
			cOpeMov := BA0->(BA0_CODIDE+BA0_CODINT)
			AaDd( aDados, { "OPEMOV", cOpeMov } )
			AaDd( aDados, { "OPEINT", cOpeMov } )
		Else
			AaDd( aDados, { "OPEMOV", PlsIntPad() } )
			AaDd( aDados, { "OPEINT", PlsIntPad() } )
		EndIf
	Elseif !Empty(cCnpjPres)   /// pega pelo CNPJPAGADOR
		BA0->( DbSetOrder(4) ) //BA0_FILIAL+BA0_SUSEP
		If BA0->( MsSeek( xFilial("BA0")+cCnpjPres ) )
			cOpeMov := BA0->(BA0_CODIDE+BA0_CODINT)
			AaDd( aDados, { "OPEMOV", cOpeMov } )
			AaDd( aDados, { "OPEINT", cOpeMov } )

		Else
			AaDd( aDados, { "OPEMOV", PlsIntPad() } )
			AaDd( aDados, { "OPEINT", PlsIntPad() } )
		EndIf
	Else
		AaDd( aDados, { "OPEMOV", PlsIntPad() } )
		AaDd( aDados, { "OPEINT", PlsIntPad() } )
	Endif

// Rda e Profissiciona executante de cada guia
	Do Case

	// Consulta
	Case cTipo == "1"
		cNomCont := AllTrim( u_CPEGCONR("NOMECONTRATADO",cGuia+"\DADOSCONTRATADO",aMatM,nil,.T.,nil,nil,cCodPeg) )
		cCodRP 	 := AllTrim( u_CPEGCONR("CPF,CNPJ,CODIGOPRESTADORNAOPERADORA",cGuia+"\DADOSCONTRATADO\IDENTIFICACAO",aMatM,nil,.T.,nil,nil,cCodPeg) )
		cCodRP 	 := cCodRP+Space( TamSX3("BAU_CPFCGC")[1]-Len(cCodRP) )
		nIdx 	 := 4
		If Empty(cCodRP)
			xRdaOri  := u_CPEGCONR("CODIGOPRESTADORNAOPERADORA",cGuia+"\DADOSCONTRATADO\IDENTIFICACAO",aMatM,,.T.,nil,nil,cCodPeg)
			cRdaOri  := xRdaOri
			If Len(alltrim(xRdaOri)) > TamSX3("BAU_CODIGO")[1]
				nIdx 	 := 4
			Else
				cRdaOri := padr(cRdaOri,6)
				nIdx 	 := 1
			Endif
		EndIf

		u_CBIVRDA(cCodRP,nIdx,"E",aDados)
		U_CBXPROF("R",cCodRP,"2",cNumImp,cOrigem,nIdx,cData,cHora,"E",aDados,aMatC)

		If BAU->( Found() )
			cCodRP	  := BAU->BAU_CODIGO
			cNomRda	  := Alltrim(BAU->BAU_NOME)
		Else
			cCodRP	  := cRdaOri
		Endif
		cRdaGuia := cCodRP

		// Local de Atendimento
		cIdenfic 	:= "DADOSCONTRATADO"

		cSigla		:= u_CPEGCONR("SIGLACONSELHO",cGuia+"\PROFISSIONALEXECUTANTE\CONSELHOPROFISSIONAL",aMatM,,.T.,nil,nil,cCodPeg)
		cCrm		:= u_CPEGCONR("NUMEROCONSELHO",cGuia+"\PROFISSIONALEXECUTANTE\CONSELHOPROFISSIONAL",aMatM,,.T.,nil,nil,cCodPeg)
		cUf			:= u_CPEGCONR("UFCONSELHO",cGuia+"\PROFISSIONALEXECUTANTE\CONSELHOPROFISSIONAL",aMatM,,.T.,nil,nil,cCodPeg)
		cNome		:= u_CPEGCONR("NOMEPROFISSIONAL",cGuia+"\PROFISSIONALEXECUTANTE",aMatM,,.T.,nil,nil,cCodPeg)
		cCbos		:= u_CPEGCONR("CBOS",cGuia+"\PROFISSIONALEXECUTANTE",aMatM,nil,.T.,.F.,nil,cCodPeg)

		If ExistBlock("PLTISESP")
			aRetPe := ExecBlock( "PLTISESP",.F.,.F.,{cCbos} )
			If ValType(aRetPe) == "A"
				cCbos  := aRetPe[1]
				cEspPe := aRetPe[2]
			Endif
		EndIf

		nIdx 	:= 4

		U_CBIVPRO("",cSigla,cCrm,cUf,nIdx,"E",aDados,nil,cCbos)
		u_CBXSCU("",cSigla,cCrm,cUf,"E",aDados,nil,nil,cNome,cCbos,cData,aMatM)

		If BB0->( Found() )
			cSlgRda := BB0->BB0_CODSIG //Sigla
			cCrmRda := BB0->BB0_NUMCR  //Numero
			cEstRda := BB0->BB0_ESTADO //Estado
			cNomPre := BB0->BB0_NOME
		EndIf

		BAQ->(DbSetORder(4))
		If ExistBlock("PLTISESP")
			AaDd( aDados, {"CODESP" , cEspPe } )
		ElseIf !Empty(cCbos) .and. !Empty(cCodRP)
			If BAQ->( MsSeek( xFilial("BAQ")+cOpeMov+cCbos ) )
				cEspBD6 := BAQ->BAQ_CODESP
				If !Empty(cCodRP)
					aEsp := CBOSRda(cRdaGuia,PlsIntPad(),BAQ->BAQ_CODESP,cData,cCbos)
					If aEsp[1]
						AaDd( aDados, {"CODESP" , aEsp[3] } )
					EndIf
				EndIf
			Endif
		Endif

 	//sadt
	Case cTipo == "2"

		If cOrigem == "1"
			cNomCont := AllTrim( u_CPEGCONR("NOMECONTRATADO",cGuia+"\PRESTADOREXECUTANTE",aMatM,nil,.T.,nil,nil,cCodPeg) )
			cCodRP   := AllTrim( u_CPEGCONR("CPF,CNPJ,CODIGOPRESTADORNAOPERADORA",cGuia+"\PRESTADOREXECUTANTE\IDENTIFICACAO",aMatM,,.T.,nil,nil,cCodPeg) )
		Else
			cNomCont := AllTrim( u_CPEGCONR("NOMECONTRATADO",cGuia+"\DADOSSOLICITANTE\CONTRATADO",aMatM,,.T.,nil,nil,cCodPeg) )
			cCodRP 	 := AllTrim( u_CPEGCONR("CPF,CNPJ,CODIGOPRESTADORNAOPERADORA",cGuia+"\DADOSSOLICITANTE\CONTRATADO\IDENTIFICACAO",aMatM,,.T.,nil,nil,cCodPeg) )
		EndIf
		cCodRP := cCodRP+Space( TamSX3("BAU_CPFCGC")[1]-Len(cCodRP) )
		nIdx 	:= 4
		If Empty(cCodRP)
			If cOrigem == "1"
				cCodRP := u_CPEGCONR("CODIGOPRESTADORNAOPERADORA",cGuia+"\PRESTADOREXECUTANTE\IDENTIFICACAO",aMatM,,.T.,nil,nil,cCodPeg)
			Else
				cCodRP := u_CPEGCONR("CODIGOPRESTADORNAOPERADORA",cGuia+"\DADOSSOLICITANTE\CONTRATADO\IDENTIFICACAO",aMatM,,.T.,nil,nil,cCodPeg)
			EndIf
			nIdx := 1
		EndIf
		u_CBIVRDA(cCodRP,nIdx,,aDados)
		U_CBXPROF("R",cCodRP,"5",cNumImp,cOrigem,nIdx,cData,cHora,,aDados,aMatC)

		If BAU->( Found() )
			cConPrEx := BAU->BAU_CODIGO
			cNomRdEx := BAU->BAU_NOME
		Else
			cConPrEx := ""
			cNomRdEx := ""
		Endif

		If cOrigem == "1"

			cIdenfic := "PRESTADOREXECUTANTE"
			cSigla 	:= u_CPEGCONR("SIGLACONSELHO",cGuia+"\PRESTADOREXECUTANTE\PROFISSIONALEXECUTANTECOMPL\CONSELHOPROFISSIONAL",aMatM,,.T.,nil,nil,cCodPeg)
			cCrm 	:= u_CPEGCONR("NUMEROCONSELHO",cGuia+"\PRESTADOREXECUTANTE\PROFISSIONALEXECUTANTECOMPL\CONSELHOPROFISSIONAL",aMatM,,.T.,nil,nil,cCodPeg)
			cUf 	:= u_CPEGCONR("UFCONSELHO",cGuia+"\PRESTADOREXECUTANTE\PROFISSIONALEXECUTANTECOMPL\CONSELHOPROFISSIONAL",aMatM,,.T.,nil,nil,cCodPeg)
			cNome	:= u_CPEGCONR("NOMEEXECUTANTE",cGuia+"\PRESTADOREXECUTANTE\PROFISSIONALEXECUTANTECOMPL",aMatM,,.T.,nil,nil,cCodPeg)
			cCbos 	:= u_CPEGCONR("CODIGOCBOS",cGuia+"\PRESTADOREXECUTANTE\PROFISSIONALEXECUTANTECOMPL",aMatM,nil,.T.,.F.,nil,cCodPeg)

			If ExistBlock("PLTISESP")
				aRetPe := ExecBlock( "PLTISESP",.F.,.F.,{cCbos} )
				If ValType(aRetPe) == "A"
					cCbos  := aRetPe[1]
					cEspPe := aRetPe[2]
				Endif
			EndIf

			nIdx 	:= 4
			cCodPCPL := ""

			U_CBIVPRO("",cSigla,cCrm,cUf,nIdx,"E",aDados,nil,cCbos)
			u_CBXSCU("",cSigla,cCrm,cUf,"E",aDados,nil,nil,cNome,cCbos,cData,aMatM)

			If BB0->( Found() )
				cCodPCPL := BB0->BB0_CODIGO
			Else
				cCodPCPL := ""
			Endif

			If Empty(cCodPCPL)
				cCodRP 	:= AllTrim( u_CPEGCONR("CPF,CNPJ,CODIGOPRESTADORNAOPERADORA",cGuia+"\PRESTADOREXECUTANTE\PROFISSIONALEXECUTANTECOMPL\CODIGOPROFISSIONALCOMPL",aMatM,,.T.,nil,nil,cCodPeg) )
				cCodRP 	:= cCodRP+Space( TamSX3("BAU_CPFCGC")[1]-Len(cCodRP) )
				nIdx 	:= 3
				If Empty(cCodRP)
					cCodRP 	:= u_CPEGCONR("CODIGOPRESTADORNAOPERADORA",cGuia+"\PRESTADOREXECUTANTE\PROFISSIONALEXECUTANTECOMPL\CODIGOPROFISSIONALCOMPL",aMatM,,.T.,nil,nil,cCodPeg)
					nIdx	:= 1
					//significa que o meu cliente me mandou o BAU_CODRDA no CODIGOPRESTADORNAOPERADORA
					If Len(alltrim(cCodRP)) == 6
						nOrdBAU := BAU->(IndexOrd())
						nRecBAU := BAU->(Recno())
						BAU->(DbSetOrder(1))
						If  BAU->(MsSeek(xFilial("BAU")+padr(cCodRP,6))) .and. !Empty(BAU->BAU_CODBB0)
							cCodRP := BAU->BAU_CODBB0
						Endif
						BAU->(DbGoTo(nRecBAU))
						BAU->(DbSetOrder(nOrdBAU))
					Endif
				EndIf

				U_CBIVPRO(cCodRP,'','','',nIdx,"E",aDados,nil,cCbos)
				u_CBXSCU(cCodRP,'','','',"E",aDados,nil,nil,cNome,cCbos,cData,aMatM)

				If BB0->( Found() )
					cCodPCPL := BB0->BB0_CODIGO
				Else
					cCodPCPL := ""
				Endif

			Endif

			If !Empty(cCodPCPL)
				If BB0->( Found() )
					cCodRP  := PLSRETDAD( aDados,"CODRDA","" )
					cNomRda := PLSRETDAD( aDados,"NOMRDA","" )
					cSlgRda := BB0->BB0_CODSIG
					cCrmRda := BB0->BB0_NUMCR
					cEstRda := BB0->BB0_ESTADO
					cNomPre := BB0->BB0_NOME

					//Aqui eu faco um tratamento para que leve la para o BD7 o codigo
					//da RDA (se o profissional for uma RDA) executante no campo BD7_CDPFPR
					cCodBAU := ""
					cEspExe := ""
					nRecBAU := BAU->(Recno())
					nOrdBAU := BAU->(IndexOrd())
					BAU->(DbSetOrder(5))
					If BAU->(MsSeek(xFilial("BAU")+BB0->BB0_CODIGO))
						cCodBAU := BAU->BAU_CODBB0
						If PlsAliasExi("BQ1") .and. !Empty(cCbos)
							BAQ->(DbSetOrder(4))
							If BAQ->( MsSeek( xFilial("BAQ")+PlsIntPad()+cCbos ) )
								BQ1->(DbSetOrder(1))
								If BQ1->(MsSeek(xFilial("BQ1")+BB0->BB0_CODIGO+BAQ->BAQ_CODESP))
									cEspExe := BAQ->BAQ_CODESP
								Endif
							Endif
						Endif
					Endif
					BAU->(DbGoTo(nRecBAU))
					BAU->(DbSetOrder(nOrdBAU))

					aSlvBWT := aClone(aMatBWT)
					lEntrou := .F.
					while ( nPos := aScan( aMatBWT,{ |x|x[3]=='12' } ) ) > 0
						AaDd( aTpPRec,{ aMatBWT[nPos,2],If(Empty(cConPrEx),cCodRP,cConPrEx),If(Empty(cNomRdEx),cNomRda,cNomRdEx),cCrmRda,cSlgRda,cEstRda,cNomPre,.T.,cCodBAU,cEspExe,u_CBRetUnp(aMatBWT[nPos,2]) } )
						lEntrou := .T.

						nSize := Len(aMatBWT)
						aDel(aMatBWT,nPos)
						aSize(aMatBWT,nSize-1)
					Enddo
					If !lEntrou
						AaDd( aTpPRec,{ GetNewPar("MV_PLSNAPL","O"),If(Empty(cConPrEx),cCodRP,cConPrEx),If(Empty(cNomRdEx),cNomRda,cNomRdEx),cCrmRda,cSlgRda,cEstRda,cNomPre,.T.,cCodBAU,cEspExe,u_CBRetUnp(GetNewPar("MV_PLSNAPL","O"))  } )
					EndIf

					aMatBWT := aClone(aSlvBWT)
					AaDd( aDados, {"ATPARG" , aTpPRec } )
					aTpPRec := {}

					cNomRda := ""
					cCrmRda := ""
					cSlgRda := ""
					cEstRda := ""
					cNomPre := ""
				EndIf
			EndIf

			If ExistBlock("PLTISESP")
				AaDd(aDados,{"CODESP",cEspPe})
			ElseIf !Empty(cCbos)
				BAQ->(DbSetORder(4))
				If BAQ->( MsSeek( xFilial("BAQ")+PlsIntPad()+cCbos ) )
					If !Empty(cRdaOri)
						aEsp := CBOSRda(cRdaGuia,cOpeMov,BAQ->BAQ_CODESP,cData,cCbos)
						If aEsp[1]
							AaDd( aDados, {"CODESP" , aEsp[3] } )
						EndIf
					EndIf
				Endif
			EndIf

			cSigla 	:= u_CPEGCONR("SIGLACONSELHO",cGuia+"\DADOSSOLICITANTE\PROFISSIONAL\CONSELHOPROFISSIONAL",aMatM,nil,.T.,nil,nil,cCodPeg)
			cCrm 	:= u_CPEGCONR("NUMEROCONSELHO",cGuia+"\DADOSSOLICITANTE\PROFISSIONAL\CONSELHOPROFISSIONAL",aMatM,nil,.T.,nil,nil,cCodPeg)
			cUf 	:= u_CPEGCONR("UFCONSELHO",cGuia+"\DADOSSOLICITANTE\PROFISSIONAL\CONSELHOPROFISSIONAL",aMatM,nil,.T.,nil,nil,cCodPeg)
			cNome	:= u_CPEGCONR("NOMEPROFISSIONAL",cGuia+"\DADOSSOLICITANTE\PROFISSIONAL",aMatM,nil,.T.,nil,nil,cCodPeg)
			cCbos 	:= u_CPEGCONR("CBOS",cGuia+"\DADOSSOLICITANTE\PROFISSIONAL",aMatM,nil,.T.,.F.,nil,cCodPeg)

			nIdx 	:= 4

			U_CBIVPRO("",cSigla,cCrm,cUf,nIdx,"S",aDados,.F.,cCbos )
			u_CBXSCU("",cSigla,cCrm,cUf,"S",aDados,nil,.F.,cNome,cCbos,cData,aMatM)

		ElseIf cOrigem == "2"
			cIdenfic := "DADOSSOLICITANTE\CONTRATADO"

			cSigla 	:= u_CPEGCONR("SIGLACONSELHO",cGuia+"\DADOSSOLICITANTE\PROFISSIONAL\CONSELHOPROFISSIONAL",aMatM,nil,.T.,nil,nil,cCodPeg)
			cCrm 	:= u_CPEGCONR("NUMEROCONSELHO",cGuia+"\DADOSSOLICITANTE\PROFISSIONAL\CONSELHOPROFISSIONAL",aMatM,nil,.T.,nil,nil,cCodPeg)
			cUf 	:= u_CPEGCONR("UFCONSELHO",cGuia+"\DADOSSOLICITANTE\PROFISSIONAL\CONSELHOPROFISSIONAL",aMatM,nil,.T.,nil,nil,cCodPeg)
			cNome	:= u_CPEGCONR("NOMEPROFISSIONAL",cGuia+"\DADOSSOLICITANTE\PROFISSIONAL",aMatM,nil,.T.,nil,nil,cCodPeg)
			cCbos   := u_CPEGCONR("CBOS",cGuia+"\DADOSSOLICITANTE\PROFISSIONAL",aMatM,nil,.T.,.F.,nil,cCodPeg)

			nIdx 	:= 4

			If ExistBlock("PLTISESP")
				aRetPe := ExecBlock( "PLTISESP",.F.,.F.,{cCbos} )
				If ValType(aRetPe) == "A"
					cCbos  := aRetPe[1]
					cEspPe := aRetPe[2]
				Endif
			EndIf

			U_CBIVPRO("",cSigla,cCrm,cUf,nIdx,"S",aDados,.T.,cCbos )
			u_CBXSCU("",cSigla,cCrm,cUf,"S",aDados,nil,.T.,cNome,cCbos,cData,aMatM )

			cBAUSol := ""
			//tratamento para pegar a especialidade do solicitante
			If BB0->( Found() )
				nRecBAU := BAU->(Recno())
				nOrdBAU := BAU->(IndexOrd())
				BAU->(DbSetOrder(5))
				If BAU->(MsSeek(xFilial("BAU")+BB0->BB0_CODIGO))
					cBAUSol := BAU->BAU_CODIGO
				Endif
				BAU->(DbGoTo(nRecBAU))
				BAU->(DbSetOrder(nOrdBAU))
			EndIf

			If ExistBlock("PLTISESP")
				AaDd(aDados,{"CODESP",cEspPe})
			ElseIf !Empty(cCbos)
				BAQ->(DbSetORder(4))
				If BAQ->( MsSeek( xFilial("BAQ")+PlsIntPad()+cCbos ) )
					If BAU->( Found() ) .or. !Empty(cBAUSol)
						aEsp := CBOSRda(If(!Empty(cBAUSol),cBAUSol,cRdaGuia),PlsIntPad(),BAQ->BAQ_CODESP,cData,cCbos)
						If aEsp[1]
							AaDd( aDados, {"CODESP" , aEsp[3] } )
						EndIf
					EndIf
				Endif
			EndIf
		EndIf


	Case cTipo == "3" .And. !lHonor

		If cOrigem == "1"
			cNomCont := AllTrim( u_CPEGCONR("NOMECONTRATADO",cGuia+"\IDENTIFICACAOEXECUTANTE",aMatM,,.T.,nil,nil,cCodPeg) )
			cCodRP 	 := AllTrim( u_CPEGCONR("CPF,CNPJ,CODIGOPRESTADORNAOPERADORA",cGuia+"\IDENTIFICACAOEXECUTANTE\IDENTIFICACAO",aMatM,,.T.,nil,nil,cCodPeg) )
		Else
			cNomCont := AllTrim( u_CPEGCONR("NOMECONTRATADO",cGuia+"\DADOSSOLICITANTE\CONTRATADO",aMatM,,.T.,nil,nil,cCodPeg) )
			cCodRP 	 := AllTrim( u_CPEGCONR("CPF,CNPJ,CODIGOPRESTADORNAOPERADORA",cGuia+"\DADOSSOLICITANTE\CONTRATADO\IDENTIFICACAO",aMatM,,.T.,nil,nil,cCodPeg) )
		EndIf
		cCodRP := cCodRP+Space( TamSX3("BAU_CPFCGC")[1]-Len(cCodRP) )
		nIdx := 4

		If Empty(cCodRP)
			If cOrigem == "1"
				cCodRP := u_CPEGCONR("CODIGOPRESTADORNAOPERADORA",cGuia+"\IDENTIFICACAOEXECUTANTE\IDENTIFICACAO",aMatM,,.T.,nil,nil,cCodPeg)
			Else
				cCodRP := u_CPEGCONR("CODIGOPRESTADORNAOPERADORA",cGuia+"\DADOSSOLICITANTE\CONTRATADO\IDENTIFICACAO",aMatM,,.T.,nil,nil,cCodPeg)
			EndIf
			nIdx := 1
		EndIf

		u_CBIVRDA(cCodRP,nIdx,,aDados)
		U_CBXPROF("R",cCodRP,"5",cNumImp,cOrigem,nIdx,cData,cHora,,aDados,aMatC)

		If BAU->( Found() )
			cCodRP	  := BAU->BAU_CODIGO
			cNomRda   := AllTrim(BAU->BAU_NOME)
		Else
			cCodRP	  := cRdaOri
			cNomRda   := AllTrim(Posicione("BAU",1,xFilial("BAU")+GetNewPar("MV_PLSRDAG",'999999'),"BAU_NOME"))
		EndIf
		cRdaGuia := cCodRP

		If cOrigem == "1"
			cIdenfic := "PRESTADOREXECUTANTE"

		ElseIf cOrigem == "2"

			cSigla 	:= u_CPEGCONR("SIGLACONSELHO",cGuia+"\DADOSSOLICITANTE\PROFISSIONAL\CONSELHOPROFISSIONAL",aMatM,,.T.,nil,nil,cCodPeg)
			cCrm 	:= u_CPEGCONR("NUMEROCONSELHO",cGuia+"\DADOSSOLICITANTE\PROFISSIONAL\CONSELHOPROFISSIONAL",aMatM,,.T.,nil,nil,cCodPeg)
			cUf 	:= u_CPEGCONR("UFCONSELHO",cGuia+"\DADOSSOLICITANTE\PROFISSIONAL\CONSELHOPROFISSIONAL",aMatM,,.T.,nil,nil,cCodPeg)
			cNome	:= u_CPEGCONR("NOMEPROFISSIONAL",cGuia+"\DADOSSOLICITANTE\PROFISSIONAL",aMatM,,.T.,nil,nil,cCodPeg)
			cCbos 	:= u_CPEGCONR("CBOS",cGuia+"\DADOSSOLICITANTE\PROFISSIONAL",aMatM,nil,.T.,.F.,nil,cCodPeg)

			nIdx	:= 4

			If ExistBlock("PLTISESP")
				aRetPe := ExecBlock( "PLTISESP",.F.,.F.,{cCbos} )
				If ValType(aRetPe) == "A"
					cCbos  := aRetPe[1]
					cEspPe := aRetPe[2]
				Endif
			EndIf

			U_CBIVPRO("",cSigla,cCrm,cUf,nIdx,"S",aDados,nil,cCbos)
			u_CBXSCU("",cSigla,cCrm,cUf,"S",aDados,nil,NIL,cNome,cCbos,cData,aMatM)
			cBAUSol := ""
			//tratamento para pegar a especialidade do solicitante
			If BB0->( Found() )
				nRecBAU := BAU->(Recno())
				nOrdBAU := BAU->(IndexOrd())
				BAU->(DbSetOrder(5))
				If BAU->(MsSeek(xFilial("BAU")+BB0->BB0_CODIGO))
					cBAUSol := BAU->BAU_CODIGO
				Endif
				BAU->(DbGoTo(nRecBAU))
				BAU->(DbSetOrder(nOrdBAU))
			EndIf

			If ExistBlock("PLTISESP")
				AaDd(aDados,{"CODESP",cEspPe})
			ElseIf !Empty(cCbos)  .and. (!Empty(cCodRP) .or. !Empty(cBAUSol))
				BAQ->(DbSetORder(4))
				If BAQ->( MsSeek( xFilial("BAQ")+PlsIntPad()+cCbos ) )
					If BAU->( Found() )
						aEsp := CBOSRda(If(!Empty(cBAUSol),cBAUSol,cRdaOri),PlsIntPad(),BAQ->BAQ_CODESP,cData,cCbos)
						If aEsp[1]
							AaDd( aDados, {"CODESP" , aEsp[3] } )
						EndIf
					EndIf
				Endif
			EndIf
		EndIf

	Case cTipo == "3" .And. lHonor

		aTpPRec := {}
		cNomCont := AllTrim( u_CPEGCONR("NOMECONTRATADO",cGuia+"\CONTRATADOEXECUTANTE",aMatM,nil,.T.,nil,nil,cCodPeg) )
		cCodRP 	 := AllTrim( u_CPEGCONR("CPF,CNPJ,CODIGOPRESTADORNAOPERADORA",cGuia+"\CONTRATADOEXECUTANTE\IDENTIFICACAO",aMatM,nil,.T.,nil,nil,cCodPeg) )
		cCodRP 	 := cCodRP+Space( TamSX3("BAU_CPFCGC")[1]-Len(cCodRP) )
		nIdx 	 := 4

		If Empty(cCodRP)
			nIdx 	:= 1
			cCodRP := StrZero(Val(u_CPEGCONR("CODIGOPRESTADORNAOPERADORA",cGuia+"\CONTRATADOEXECUTANTE\IDENTIFICACAO",aMatM,nil,.T.,nil,nil,cCodPeg)),6)
		EndIf

		u_CBIVRDA(cCodRP,nIdx,,aDados)
		U_CBXPROF("R",cCodRP,"6",cNumImp,cOrigem,nIdx,cData,cHora,,aDados,aMatC)

		If BAU->( Found() )
			cCodRP	  := BAU->BAU_CODIGO
			cNomRda   := AllTrim(BAU->BAU_NOME)
		Else
			cCodRP	  := cRdaOri
			cNomRda   := AllTrim(Posicione("BAU",1,xFilial("BAU")+GetNewPar("MV_PLSRDAG",'999999'),"BAU_NOME"))
		EndIf
		cRdaGuia := cCodRP

		cIdenfic := "CONTRATADOEXECUTANTE"
		cSigla 	:= u_CPEGCONR("SIGLACONSELHO",cGuia+"\CONTRATADOEXECUTANTE\IDENTIFICACAOPROFISSIONAL\CONSELHOPROFISSIONAL",aMatM,,.T.,nil,nil,cCodPeg)
		cCrm 	:= u_CPEGCONR("NUMEROCONSELHO",cGuia+"\CONTRATADOEXECUTANTE\IDENTIFICACAOPROFISSIONAL\CONSELHOPROFISSIONAL",aMatM,,.T.,nil,nil,cCodPeg)
		cUf 	:= u_CPEGCONR("UFCONSELHO",cGuia+"\CONTRATADOEXECUTANTE\IDENTIFICACAOPROFISSIONAL\CONSELHOPROFISSIONAL",aMatM,,.T.,nil,nil,cCodPeg)
		cNome 	:= u_CPEGCONR("NOMEEXECUTANTE",cGuia+"\CONTRATADOEXECUTANTE\IDENTIFICACAOPROFISSIONAL\",aMatM,,.T.,nil,nil,cCodPeg)
		cCbos 	:= u_CPEGCONR("CODIGOCBOS",cGuia+"\CONTRATADOEXECUTANTE\IDENTIFICACAOPROFISSIONAL",aMatM,,.T.,.F.,nil,cCodPeg)

		If ExistBlock("PLTISESP")
			aRetPe := ExecBlock( "PLTISESP",.F.,.F.,{cCbos} )
			If ValType(aRetPe) == "A"
				cCbos  := aRetPe[1]
				cEspPe := aRetPe[2]
			Endif
		EndIf

		nIdx	:= 4

		U_CBIVPRO("",cSigla,cCrm,cUf,nIdx,"E",aDados,nil,cCbos)
		u_CBXSCU("",cSigla,cCrm,cUf,"E",aDados,nil,nil,cNome,cCbos,cData,aMatM)
		cCodBAU := ""
		cEspExe := ""

		If BB0->( Found() )
			cSlgRda := BB0->BB0_CODSIG
			cCrmRda := BB0->BB0_NUMCR
			cEstRda := BB0->BB0_ESTADO
			cNomPre := BB0->BB0_NOME
        	//Aqui eu faco um tratamento para que leve la para o BD7 o codigo
			//da RDA (se o profissional for uma RDA) executante no campo BD7_CDPFPR
			nRecBAU := BAU->(Recno())
			nOrdBAU := BAU->(IndexOrd())
			BAU->(DbSetOrder(5))
			If BAU->(MsSeek(xFilial("BAU")+BB0->BB0_CODIGO))
				cCodBAU := BAU->BAU_CODBB0
				If PlsAliasExi("BQ1") .and. !Empty(cCbos)
					BAQ->(DbSetOrder(4))
					If BAQ->( MsSeek( xFilial("BAQ")+PlsIntPad()+cCbos ) )
						BQ1->(DbSetOrder(1))
						If BQ1->(MsSeek(xFilial("BQ1")+BB0->BB0_CODIGO+BAQ->BAQ_CODESP))
							cEspExe := BAQ->BAQ_CODESP
						Endif
					Endif
				Endif
			Endif
			BAU->(DbGoTo(nRecBAU))
			BAU->(DbSetOrder(nOrdBAU))
		EndIf

		If ExistBlock("PLTISESP")
			AaDd(aDados,{"CODESP",cEspPe})
		ElseIf !Empty(cCbos)
			BAQ->(DbSetORder(4))
			If BAQ->( MsSeek( xFilial("BAQ")+PlsIntPad()+cCbos ) )
				aEsp := CBOSRda(cCodRP,PlsIntPad(),BAQ->BAQ_CODESP,cData,cCbos)
				If aEsp[1]
					AaDd( aDados, {"CODESP" , aEsp[3] } )
				EndIf
			Endif
		EndIf

		cPosPro := u_CPEGCONR("POSICAOPROFISSIONAL",cGuia+"\CONTRATADOEXECUTANTE",aMatM,,.T.,.F.,nil,cCodPeg)


		aSlvBWT := aClone(aMatBWT)
		lEntrou := .F.
		while ( nPos := aScan( aMatBWT,{ |x|x[3]==cPosPro } ) ) > 0
			AaDd( aTpPRec,{ aMatBWT[nPos,2],cCodRP,cNomRda,cCrmRda,cSlgRda,cEstRda,cNomPre,.T.,cCodBAU,cEspExe,u_CBRetUnp(aMatBWT[nPos,2]) } )
			lEntrou := .T.

			nSize := Len(aMatBWT)
			aDel(aMatBWT,nPos)
			aSize(aMatBWT,nSize-1)
		Enddo
		If !lEntrou
			AaDd( aTpPRec,{ GetNewPar("MV_PLSNAPL","O"),cCodRP,cNomRda,cCrmRda,cSlgRda,cEstRda,cNomPre,.T.,cCodBAU,cEspExe,u_CBRetUnp(GetNewPar("MV_PLSNAPL","O")) } )
		EndIf
		aMatBWT := aClone(aSlvBWT)

	EndCase

	If !Empty(cIdenfic)

		SIX->( DbSetOrder(1) )
		If SIX->( MsSeek("BB84") )
			cTpLograd	:= u_CPEGCONR("TIPOLOGRADOURO",cGuia+"\"+cIdenfic+"\ENDERECOCONTRATADO",aMatM,nil,.T.,.F.,nil,cCodPeg)
			cTpLograd   += Space( TamSX3("BB8_TIPLOG")[1]-Len( AllTrim(cTpLograd) ) )

			cLograd 	:= u_CPEGCONR("LOGRADOURO",cGuia+"\"+cIdenfic+"\ENDERECOCONTRATADO",aMatM,nil,.T.,.F.,nil,cCodPeg)
			cNumero 	:= u_CPEGCONR("NUMERO",cGuia+"\"+cIdenfic+"\ENDERECOCONTRATADO",aMatM,nil,.T.,.F.,nil,cCodPeg)
			cNumero   	+= Space( TamSX3("BB8_NR_END")[1]-Len( AllTrim(cNumero) ) )

			cCodUf 		:= u_CPEGCONR("CODIGOUF",cGuia+"\"+cIdenfic+"\ENDERECOCONTRATADO",aMatM,nil,.T.,.F.,nil,cCodPeg)
			cCodUf   	+= Space( TamSX3("BB8_EST")[1]-Len( AllTrim(cCodUf) ) )


			cCep 		:= strtran(strtran(u_CPEGCONR("CEP",cGuia+"\"+cIdenfic+"\ENDERECOCONTRATADO",aMatM,nil,.T.,.F.,nil,cCodPeg),'-',''),'.','')
			cCep   		+= Space( TamSX3("BB8_CEP")[1]-Len( AllTrim(cCep) ) )

			If !Empty( AllTrim(cTpLograd+cCep+cNumero+cCodUf) )

				BB8->(Dbgotop())
				lEntrou := .F.
				BB8->( DbSetOrder(4) )
				If nInd1 == 0
					nIndUt := PLSBUIND("BB8","BB8_FILIAL + BB8_TIPLOG + BB8_CEP + BB8_NR_END + BB8_EST + BB8_CODIGO + BB8_CODINT") /// Busca da Ordem do indice pela descrição
					nInd1  := nIndUt
				Endif
				BB8->( DbSetOrder(nInd1) )//BB8_FILIAL + BB8_TIPLOG + BB8_CEP + BB8_NR_END + BB8_EST + BB8_CODIGO + BB8_CODINT                                          //sempre procuro um local na rda que eu vou gerar a guia
				If BB8->( MsSeek( xFilial("BB8")+cTpLograd+cCep+cNumero+cCodUf+cRdaOri+cOpeMov ) )
					while  !BB8->(Eof()) .and. BB8->(BB8_FILIAL+BB8_TIPLOG+BB8_CEP+BB8_NR_END+BB8_EST+BB8_CODIGO+BB8_CODINT) == ;
							xFilial("BB8")+cTpLograd+cCep+cNumero+cCodUf+cRdaOri+cOpeMov
						If Empty(BB8->BB8_DATBLO)
							AaDd( aDados, { "CODLOC", BB8->BB8_CODLOC } )
							lEntrou := .T.
							exit
						Endif
						BB8->(DbSkip())
					enddo
					If !lEntrou
						BB8->( DbSetOrder(1) )//pego a primeira
						If BB8->( MsSeek( xFilial("BB8")+cRdaOri))
							while  !BB8->(Eof()) .and. BB8->(BB8_FILIAL+BB8_CODIGO) == xFilial("BB8")+cRdaOri
								If Empty(BB8->BB8_DATBLO)
									AaDd( aDados, { "CODLOC", BB8->BB8_CODLOC } )
									exit
								Endif
								BB8->(DbSkip())
							Enddo
						Endif
					Endif
				Else
					BB8->( DbSetOrder(1) )//pego a primeira
					If BB8->( MsSeek( xFilial("BB8")+cRdaOri))
						while  !BB8->(Eof()) .and. BB8->(BB8_FILIAL+BB8_CODIGO) == xFilial("BB8")+cRdaOri
							If Empty(BB8->BB8_DATBLO)
								AaDd( aDados, { "CODLOC", BB8->BB8_CODLOC } )
								exit
							Endif
							BB8->(DbSkip())
						Enddo
					Endif
				Endif
			EndIf
		EndIf
		cIdenfic := ""
	EndIf

// Dados do Beneficiario
	If cTipo == "1"
		cMatric  := u_CPEGCONR("NUMEROCARTEIRA",cGuia+"\BENEFICIARIO",aMatM,nil,nil,nil,nil,cCodPeg)
		cNomeUsu := u_CPEGCONR("NOMEBENEFICIARIO",cGuia+"\BENEFICIARIO",aMatM,nil,nil,.F.,nil,cCodPeg)
	Else
		cMatric  := u_CPEGCONR("NUMEROCARTEIRA",cGuia+"\DADOSBENEFICIARIO",aMatM,nil,nil,nil,nil,cCodPeg)
		cNomeUsu := u_CPEGCONR("NOMEBENEFICIARIO",cGuia+"\DADOSBENEFICIARIO",aMatM,,,.F.,nil,cCodPeg)
	EndIf

// Ponto de entrada para matricula
	If ExistBlock("PLSXMLMAT")
		cMatric := ExecBlock( "PLSXMLMAT",.F.,.F.,{cMatric,cNomeUsu} )
	EndIf

	If !Empty(cMatric)
		AaDd( aDados, {"USUARIO" , cMatric  } )
	Else
		aRetuGe := u_CXMLUsrGe(PlsIntPad())
		AaDd( aDados, {"USUARIO" , aRetuGe[1]  } )
	EndIf

	AaDd( aDados, {"NOMUSR" , cNomeUsu } )
	AaDd( aDados, {"VIACAR" , "" } )

// Procura pelo numero do impresso o numero da liberacao
	If ExistBlock("PLSTMLLIB")
		cNumAut := ExecBlock( "PLSTMLLIB",.F.,.F.,{ cNumSen,cOpeMov,cCodRP,cTipo,cMatric,cGuiPri,lHonor,lEvolu } )
	Else
		cNumAut := cNumSen
	EndIf

// Verifica se existe a solicitacao
	If lResInt .Or. lHonor .Or. lEvolu
		If !Empty(cNumAut)
			BE4->( DbSetOrder(2) ) //BE4_FILIAL + BE4_CODOPE + BE4_ANOINT + BE4_MESINT + BE4_NUMINT
			If BE4->( MsSeek( xFilial("BE4")+padr(cNumAut,18) ) )
				AaDd( aDados, { "NUMSOL", cNumAut } )
				AaDd( aDados, { "NUMPEG", BE4->( BE4_CODOPE+BE4_CODLDP+BE4_CODPEG+BE4_NUMERO ) } )
			Else
				BE4->( DbSetOrder(7) )
				If BE4->( MsSeek( xFilial("BE4")+padr(cNumAut,9) ) )
					AaDd( aDados, { "NUMSOL", cNumAut } )
					AaDd( aDados, { "NUMPEG", BE4->( BE4_CODOPE+BE4_CODLDP+BE4_CODPEG+BE4_NUMERO ) } )
				Endif
			Endif
		EndIf
	EndIf

// Numero do Lote
	cNumeLot := AllTrim(u_CPEGCONR("NUMEROLOTE","\LOTEGUIAS",aMatM,nil,nil,nil,nil,cCodPeg))
	cNumeSeq := AllTrim(u_CPEGCONR("SEQUENCIALTRANSACAO","\CABECALHO\IDENTIFICACAOTRANSACAO",aMatC,nil,nil,nil,nil,cCodPeg))

	If Empty(cNumeLot)
		cNumeLot := cNumeSeq
	EndIf

// Dados complementares
	AaDd( aDados, {"LOTGUI" , cNumeLot} )
	AaDd( aDados, {"SEQTRA" , cNumeSeq} )
	AaDd( aDados, {"NUMPRE"	, cNumImp } )
	AaDd( aDados, {"TIPPAR"	, aTipPart } )

// Consulta
	AaDd( aDados, {"TIPCON" , u_CPEGCONR("TIPOCONSULTA",cGuia+"\DADOSATENDIMENTO",aMatM,nil,nil,.F.,nil,cCodPeg) } )
	If cTipo=="1"
		AaDd( aDados, {"DATPRO" , u_CBAJUDAT( u_CPEGCONR("DATAATENDIMENTO",cGuia+"\DADOSATENDIMENTO",aMatM,nil,.T.,nil,nil,cCodPeg) ) } )
		AaDd( aDados, {"TIPSAI" , u_CPEGCONR("TIPOSAIDA",cGuia+"\DADOSATENDIMENTO",aMatM,nil,nil,.F.,nil,cCodPeg) } )
	Else
		AaDd( aDados, {"TIPSAI" , u_CPEGCONR("TIPOSAIDA",cGuia,aMatM,,,.F.,nil,cCodPeg) } )
	EndIf
	AaDd( aDados, {"TIPATE" , u_CPEGCONR("TIPOATENDIMENTO",cGuia,aMatM,,,.F.,nil,cCodPeg) } )
	AaDd( aDados, {"INDCLI" , u_CPEGCONR("INDICACAOCLINICA",cGuia,aMatM,,,.F.,nil,cCodPeg) } )
	AaDd( aDados, {"TIPADM" , u_CPEGCONR("CARATERATENDIMENTO",cGuia,aMatM,,,.F.,nil,cCodPeg) } )
	If cTipo == "1"
		cTagDiag := "\HIPOTESEDIAGNOSTICA"
		cTagDia2 := "\DIAGNOSTICO"
		cTagDia3 := "\HIPOTESESDIAGNOSTICAS\CIDPRINCIPAL\CID"
		cTagDia4 := "\DIAGNOSTICOGUIA"
		cTagDia5 := "\HIPOTESESDIAGNOSTICAS\CIDPRINCIPAL"
	Else
		If cVersao >= "2.01.03"
			cTagDiag := "\DIAGNOSTICOATENDIMENTO"
			cTagDia2 := "\DIAGNOSTICO"
			cTagDia3 := "\HIPOTESESDIAGNOSTICAS\CIDPRINCIPAL\CID"
			cTagDia4 := "\DIAGNOSTICOGUIA"
			cTagDia5 := "\HIPOTESESDIAGNOSTICAS\CIDPRINCIPAL"
		Else
			cTagDiag := "\DIAGNOSTICOGUIA"
			cTagDia2 := "\DIAGNOSTICO"
			cTagDia3 := "\HIPOTESESDIAGNOSTICAS\CIDPRINCIPAL\CID"
			cTagDia4 := "\DIAGNOSTICOGUIA"
			cTagDia5 := "\HIPOTESESDIAGNOSTICAS\CIDPRINCIPAL"
		EndIf
	EndIf

// tag - codigoDiagnostico
	cCid := u_CPEGCONR("CODIGODIAGNOSTICO",cGuia+cTagDiag+"\CID",aMatM,,,.F.,nil,cCodPeg)
	If Empty(cCid)
		cCid := u_CPEGCONR("CODIGODIAGNOSTICO",cGuia+cTagDia2,aMatM,,,.F.,nil,cCodPeg)
		If Empty(cCid)
			cCid := u_CPEGCONR("CODIGODIAGNOSTICO",cGuia+cTagDia3,aMatM,,,.F.,nil,cCodPeg)
			If Empty(cCid)
				cCid := u_CPEGCONR("CODIGODIAGNOSTICO",cGuia+cTagDia4+"\CID",aMatM,,,.F.,nil,cCodPeg)
				If Empty(cCid)
					cCid := u_CPEGCONR("CODIGODIAGNOSTICO",cGuia+"\DIAGNOSTICOSSAIDAINTERNACAO\DIAGNOSTICOPRINCIPAL",aMatM,,,.F.,nil,cCodPeg)
				Endif
			Endif
		Endif
	Endif
	If !Empty(cCid)
		AaDd( aDados, {"CIDPRI" , cCid } )
	Endif

// tag - tipoDoenca
	cTipDoe := u_CPEGCONR("TIPODOENCA",cGuia+cTagDiag,aMatM,,,.F.,nil,cCodPeg)
	If Empty(cTipDoe)
		cTipDoe := u_CPEGCONR("TIPODOENCA",cGuia+cTagDia4,aMatM,,,.F.,nil,cCodPeg)
		If Empty(cTipDoe)
			cTipDoe := u_CPEGCONR("TIPODOENCA",cGuia+cTagDia5,aMatM,,,.F.,nil,cCodPeg)
		Endif
	Endif
	IF !Empty(cTipDoe)
		AaDd( aDados, {"TIPDOE" , cTipDoe } )
	Endif

// tag - IndicadorAcidente
	cIndAci := u_CPEGCONR("INDICADORACIDENTE",cGuia+cTagDiag,aMatM,,,.F.,nil,cCodPeg)
	If Empty(cIndAci)
		cIndAci := u_CPEGCONR("INDICADORACIDENTE",cGuia+cTagDia2,aMatM,,,.F.,nil,cCodPeg)
		If Empty(cIndAci)
			cIndAci := u_CPEGCONR("INDICADORACIDENTE",cGuia+cTagDia3,aMatM,,,.F.,nil,cCodPeg)
			If Empty(cIndAci)
				cIndAci := u_CPEGCONR("INDICADORACIDENTE",cGuia+cTagDia5,aMatM,,,.F.,nil,cCodPeg)
			Endif
		Endif
	Endif
	If !Empty(cIndAci)
		AaDd( aDados, {"INDACI" , cIndAci } )
	Endif

// tag - unidadeTempo
	cUndDoe := u_CPEGCONR("UNIDADETEMPO",cGuia+cTagDiag+"\TEMPOREFERIDOEVOLUCAODOENCA",aMatM,,,.F.,nil,cCodPeg)
	If Empty(cUndDoe)
		cUndDoe := u_CPEGCONR("UNIDADETEMPO",cGuia+cTagDia3+"\TEMPOREFERIDOEVOLUCAODOENCA",aMatM,,,.F.,nil,cCodPeg)
		If Empty(cUndDoe)
			cUndDoe := u_CPEGCONR("UNIDADETEMPO",cGuia+cTagDia5+"\TEMPOREFERIDOEVOLUCAODOENCA",aMatM,,,.F.,nil,cCodPeg)
		Endif
	Endif
	If !Empty(cUndDoe)
		AaDd( aDados, {"UNDDOE" , cUndDoe } )
	Endif

// tag - Valor
	cTmpDoe := u_CPEGCONR("VALOR",cGuia+cTagDiag+"\TEMPOREFERIDOEVOLUCAODOENCA",aMatM,,,.F.,nil,cCodPeg)
	If Empty(cTmpDoe)
		cTmpDoe := u_CPEGCONR("VALOR",cGuia+cTagDia3+"\TEMPOREFERIDOEVOLUCAODOENCA",aMatM,,,.F.,nil,cCodPeg)
		If Empty(cTmpDoe)
			cTmpDoe := u_CPEGCONR("VALOR",cGuia+cTagDia5+"\TEMPOREFERIDOEVOLUCAODOENCA",aMatM,,,.F.,nil,cCodPeg)
		Endif
	Endif
	If !Empty(cTmpDoe)
		AaDd( aDados, {"TMPDOE" , Val( cTmpDoe ) } )
	Endif

	AaDd( aDados, {"NUMIMP" , cNumImp } )
	AaDd( aDados, {"NUMLIB" , cNumAut } )


// Internação
	If ctipo == "2"
		AaDd( aDados, {"CARSOL" , u_CPEGCONR("CARATERSOLICITACAO",cGuia,aMatM,,,.F.,nil,cCodPeg) } )
	ElseIf ctipo == "3"
		AaDd( aDados, {"AUNMED" , aUnMed } )
		AaDd( aDados, {"CARSOL" , u_CPEGCONR("CARATERINTERNACAO",cGuia,aMatM,,,.F.,nil,cCodPeg) } )

	// Evolucao/Resumo
		If lEvolu
			AaDd( aDados, {"PADCON" , u_CPEGCONR("TIPOACOMODACAO",cGuia+"\DIARIAS",aMatM,,,.F.,nil,cCodPeg) } )
			AaDd( aDados, {"QDIEVO" , u_CPEGCONR("QUANTIDADEDIARIA",cGuia+"\DIARIAS",aMatM,,,.F.,nil,cCodPeg) } )
		Else
			AaDd( aDados, {"PADCON" , u_CPEGCONR("ACOMODACAO",cGuia,aMatM,,,.F.,nil,cCodPeg) } )
		EndIf

		cDataHora 	:= U_CBDELIM( u_CPEGCONR("DATAHORASAIDAINTERNACAO",cGuia,aMatM,,,.F.,nil,cCodPeg) )

		AaDd( aDados, {"DTALTA"	, u_CBAJUDAT(SubStr(cDataHora,1,8)) } )
		AaDd( aDados, {"HRALTA"	, SubStr(cDataHora,10,6) } )

		cTipFat := u_CPEGCONR("TIPOFATURAMENTO",cGuia+"\DADOSINTERNACAO" ,aMatM,,,.F.,nil,cCodPeg)

		If cTipFat == "T"
			cDtFimFat 	:= U_CBDELIM( u_CPEGCONR("DATAFINALFATURAMENTO",cGuia,aMatM,,,.F.,nil,cCodPeg) )
			cHrFimFat 	:= U_CBDELIM( u_CPEGCONR("HORAFINALFATURAMENTO",cGuia,aMatM,,,.F.,nil,cCodPeg) )
			AaDd( aDados, {"DTALTA"	, u_CBAJUDAT(SubStr(cDtFimFat,1,8)) } )
			AaDd( aDados, {"HRALTA"	, SubStr(cHrFimFat,1,8) } )
		EndIf

		cTipInt := ""
		cGrpInt := u_CPEGCONR("TIPOINTERNACAO",cGuia,aMatM,,,.F.,nil,cCodPeg)


		cSql := " SELECT * FROM "+RetSqlName("BQR")
		cSql += " WHERE BQR_FILIAL = '"+xFilial("BQR")+"' "
		cSql += " AND BQR_CODEDI = '"+cGrpInt+"' "
		cSql += " AND D_E_L_E_T_ = ' ' "
		PlsQuery(cSql,'trbBQR')
		If trbBQR->(!Eof()) .and. !Empty(trbBQR->BQR_GRPINT)
			cTipInt := trbBQR->BQR_TIPINT
		Endif
		trbBQR->(DbCloseArea())

		AaDd( aDados, {"TPEVEN" , cGrpInt } )
		AaDd( aDados, {"TIPINT" , cTipInt } )

		cRegInt := u_CPEGCONR("REGIMEINTERNACAO",cGuia,aMatM,,,.F.,nil,cCodPeg)
		If Empty(cRegInt)
			cRegInt := '1'
		Endif
		AaDd( aDados, {"REGINT" , cRegInt } )
		AaDd( aDados, {"EMGEST" , u_CPEGCONR("EMGESTACAO",cGuia+"\INTERNACAOOBSTETRICA",aMatM,,,.F.,nil,cCodPeg) } )
		AaDd( aDados, {"ABORTO" , u_CPEGCONR("ABORTO",cGuia+"\INTERNACAOOBSTETRICA",aMatM,,,.F.,nil,cCodPeg) } )
		AaDd( aDados, {"TRAGRA" , u_CPEGCONR("TRANSTORNOMATERNORELGRAVIDEZ",cGuia+"\INTERNACAOOBSTETRICA",aMatM,,,.F.,nil,cCodPeg) } )
		AaDd( aDados, {"COMURP" , u_CPEGCONR("COMPLICACAOPERIODOPUERPERIO",cGuia+"\INTERNACAOOBSTETRICA",aMatM,,,.F.,nil,cCodPeg) } )
		AaDd( aDados, {"ATESPA" , u_CPEGCONR("ATENDIMENTORNSALAPARTO",cGuia+"\INTERNACAOOBSTETRICA",aMatM,,,.F.,nil,cCodPeg) } )
		AaDd( aDados, {"COMNAL" , u_CPEGCONR("COMPLICACAONEONATAL",cGuia+"\INTERNACAOOBSTETRICA",aMatM,,,.F.,nil,cCodPeg) } )
		AaDd( aDados, {"BAIPES" , u_CPEGCONR("BAIXOPESO",cGuia+"\INTERNACAOOBSTETRICA",aMatM,,,.F.,nil,cCodPeg) } )
		AaDd( aDados, {"PAAREO" , u_CPEGCONR("PARTOCESAREO",cGuia+"\INTERNACAOOBSTETRICA",aMatM,,,.F.,nil,cCodPeg) } )
		AaDd( aDados, {"PATNOR" , u_CPEGCONR("PARTONORMAL",cGuia+"\INTERNACAOOBSTETRICA",aMatM,,,.F.,nil,cCodPeg) } )

	// Monta numerdo de declaracaoes
		While !Empty( ( cNumeDNAux := u_CPEGCONR("NUMERODN",cGuia+"\INTERNACAOOBSTETRICA\DECLARACOESNASCIDOSVIVOS",aMatM,nil,.T.,nil,nil,cCodPeg) ) )
			cNumeDN += cNumeDNAux+","
		EndDo
		cNumeDN := Left( cNumeDN,Len(cNumeDN)-1 )
		AaDd( aDados, {"NRDCNV" , cNumeDN  } )

		AaDd( aDados, {"QTNASV" , Val(u_CPEGCONR("QTDNASCIDOSVIVOSTERMO",cGuia+"\INTERNACAOOBSTETRICA",aMatM,,,.F.,nil,cCodPeg) ) } )
		AaDd( aDados, {"QTNASM" , Val(u_CPEGCONR("QTDNASCIDOSMORTOS",cGuia+"\INTERNACAOOBSTETRICA",aMatM,,,.F.,nil,cCodPeg) ) } )
		AaDd( aDados, {"QTNASP" , Val(u_CPEGCONR("QTDVIVOSPREMATUROS",cGuia+"\INTERNACAOOBSTETRICA",aMatM,,,.F.,nil,cCodPeg) ) } )
		AaDd( aDados, {"OBTMUL" , u_CPEGCONR("OBITOMULHER",cGuia+"\INTERNACAOOBSTETRICA",aMatM,,,.F.,nil,cCodPeg) } )
		AaDd( aDados, {"QTOBTP" , Val(u_CPEGCONR("QTDEOBITOPRECOCE",cGuia+"\OBITONEONATAL",aMatM,,,.F.,nil,cCodPeg) ) } )
		AaDd( aDados, {"QTOBAR" , Val(u_CPEGCONR("QTDEOBITOTARDIO",cGuia+"\OBITONEONATAL",aMatM,,,.F.,nil,cCodPeg) ) } )

		cCid2 := u_CPEGCONR("CODIGODIAGNOSTICO",cGuia+"\DIAGNOSTICOSSAIDAINTERNACAO\DIAGNOSTICOSSECUNDARIOS\CID",aMatM,,,.F.,nil,cCodPeg)
		If !Empty(cCid2)
			AaDd( aDados, {"CID2" 	, cCid2 } )
		Endif

		AaDd( aDados, {"QDISOL"	, Val(u_CPEGCONR("DIASSOLICITADOS",cGuia,aMatM,,,.F.,nil,cCodPeg)) } )
		AaDd( aDados, {"DATPRVINT", u_CBAJUDAT( u_CPEGCONR("DATAPROVAVELADMISHOSP",cGuia,aMatM,,,.F.,nil,cCodPeg) ) } )

		AaDd( aDados, {"INDACI" , u_CPEGCONR("INDICADORACIDENTE",cGuia+"\DIAGNOSTICOSSAIDAINTERNACAO",aMatM,,,.F.,nil,cCodPeg) } )


		cTipAlt := u_CPEGCONR("MOTIVOSAIDAINTERNACAO",cGuia+"\DIAGNOSTICOSSAIDAINTERNACAO",aMatM,,,.F.,nil,cCodPeg)

		cSql := " SELECT BIY_CODSAI FROM "+RetSqlName("BIY")
		cSql += " WHERE BIY_FILIAL = '"+xFilial("BIY")+"' "
		cSql += " AND BIY_MOTSAI = '"+cTipAlt+"' "
		cSql += " AND D_E_L_E_T_ = ' ' "
		PlsQuery(cSql,'trbBiy')
		If trbBiy->(!Eof()) .and. !Empty(trbBiy->BIY_CODSAI)
			If BE4->( FieldPos("BE4_TIPALT") ) > 0
				cTipAlt:= trbBiy->BIY_CODSAI
			EndIf
		Endif
		trbBiy->(DbCloseArea())

		AaDd( aDados, {"TIPALT" ,cTipAlt } )

		AaDd( aDados, {"CIDOBT" , u_CPEGCONR("CODIGODIAGNOSTICO",cGuia+"\DIAGNOSTICOSSAIDAINTERNACAO\OBITO\CID",aMatM,,,.F.,nil,cCodPeg) } )
		AaDd( aDados, {"NRDCOB" , u_CPEGCONR("NUMERODECLARACAO",cGuia+"\DIAGNOSTICOSSAIDAINTERNACAO\OBITO",aMatM,,,.F.,nil,cCodPeg) } )
		AaDd( aDados, {"TIPFAT" , u_CPEGCONR("TIPOFATURAMENTO",cGuia,aMatM,,,.F.,nil,cCodPeg) } )
	EndIf

// Observacao
	cObs := u_CPEGCONR("OBSERVACAO",cGuia,aMatM,,,.F.,nil,cCodPeg)
	AaDd( aDados, {"MSG01" , SubStr(cObs,1,nTamObs)  } )
	AaDd( aDados, {"MSG02" , SubStr(cObs,nTamObs+1,Len(cObs)) } )
	AaDd( aDados, {"CODPEG" , cCodPeg } )

// Itens - consulta
	If cTipo =="1"
		aMatIte := {}
		AaDd( aMatIte, {"SEQMOV" , "001" } )
		cCodPad := u_CPEGCONR("CODIGOTABELA",cGuia+"\DADOSATENDIMENTO\PROCEDIMENTO",aMatM,,,.F.,nil,cCodPeg)
		cSlvPad := cCodPad
		cCodPro := u_CPEGCONR("CODIGOPROCEDIMENTO",cGuia+"\DADOSATENDIMENTO\PROCEDIMENTO",aMatM,,,nil,nil,cCodPeg)
		cCodPro := padr(cCodPro,tamsx3("BR8_CODPSA")[1])
		cSlvPro := cCodPro
		cDescric:= u_CPEGCONR("DESCRICAO",cGuia+"\DADOSATENDIMENTO\PROCEDIMENTO",aMatM,,,.F.,nil,cCodPeg)
		cSlvDes := cDescric
		dDatRea := u_CBAJUDAT(Alltrim(u_CPEGCONR("DATAATENDIMENTO",cGuia+"\DADOSATENDIMENTO\DATAATENDIMENTO",aMatM,nil,nil,nil,nil,cCodPeg)))

		If Empty(cCodPro)
			cCodPro := UPPER(u_CPEGCONR("DESCRICAOPROCEDIMENTO",cGuia+"\PROCEDIMENTOSEXECUTADOS\PROCEDIMENTO",aMatM,nil,.F.,.F.,nil,cCodPeg))
		Endif

		If Empty(cDescric)
			cDescric := UPPER(u_CPEGCONR("CODIGOPROCEDIMENTO",cGuia+"\PROCEDIMENTOSEXECUTADOS\PROCEDIMENTO",aMatM,nil,.F.,.F.,nil,cCodPeg))
		Endif
		If PLSPOSGLO(PLSINTPAD(),__aCdCri198[1],__aCdCri198[2],cLocalExec,"1",cTipoGrv)
			aRetTuss := PLSDPTUSS('E',cCodPad,cCodPro)
			If !Empty(aRetTuss[1])
				cCodPad := aRetTuss[1]
				cCodPro := aRetTuss[2]
				cCodPro := padr(cCodPro,tamsx3("BR8_CODPSA")[1])
			EndIf
		EndIf

		u_CBXPAD(@cCodPad,@cCodPro,@cDescric,,cTipGui,cVersao,dDatRea)

		BR8->(DbSetOrder(1))
		If !BR8->( MsSeek(xFilial("BR8")+cCodPad+cCodPro) ) .and. cOrigem <> '2' //nao eh uma solicitacao
			cCodPad := GetNewPar("MV_PLCDPXM","01")
			cCodPro := GetNewPar("MV_PLPSPXM","99999994")
			cCodPro := padr(cCodPro,tamsx3("BR8_CODPSA")[1])
		EndIf

		AaDd( aMatIte, {"CODPAD" , cCodPad } )
		AaDd( aMatIte, {"CODPRO" , cCodPro} )
		AaDd( aMatIte, {"ESPPE"  , cEspPe} )
		AaDd( aMatIte, {"ESPPRO" , cEspBD6} )
		AaDd( aMatIte, {"SLVPAD" , cSlvPad } )
		AaDd( aMatIte, {"SLVPRO" , cSlvPro} )
		AaDd( aMatIte, {"SLVDES" , cSlvDes} )

		AaDd( aMatIte, {"QTD"	 , 1 } )
		AaDd( aMatIte, {"QTDAUT" , 1 } )
		AaDd( aMatIte, {"VLRAPR" , 0 } )
		AaDd(aItens,aMatIte)

		cEspPe := ""
	Else

		cCont := "001"
		While !Empty( ( cCodPro := u_CPEGCONR("CODIGO",cGuia+"\PROCEDIMENTOSEXAMESSOLICITADOS",aMatM,nil,.T.,nil,nil,cCodPeg, @nLimite) ) )
			aMatIte := {}
			AaDd( aMatIte, {"SEQMOV" , cCont } )
			cCont := soma1(cCont)

			cCodPad := u_CPEGCONR("TIPOTABELA",cGuia+"\PROCEDIMENTOSEXAMESSOLICITADOS",aMatM,nil,.T.,.F.,nil,cCodPeg)
			cSlvPad := cCodPad
			cDescric:= u_CPEGCONR("DESCRICAO",cGuia+"\PROCEDIMENTOSEXAMESSOLICITADOS",aMatM,nil,.T.,.F.,nil,cCodPeg)
			cSlvDes := cDescric
			cCodPro := padr(cCodPro,tamsx3("BR8_CODPSA")[1])
			cSlvPro := cCodPro

			If PLSPOSGLO(PLSINTPAD(),__aCdCri198[1],__aCdCri198[2],cLocalExec,"1",cTipoGrv)
				aRetTuss := PLSDPTUSS('E',cCodPad,cCodPro)
				If !Empty(aRetTuss[1])
					cCodPad := aRetTuss[1]
					cCodPro := aRetTuss[2]
					cCodPro := padr(cCodPro,tamsx3("BR8_CODPSA")[1])
				EndIf
			EndIf

			u_CBXPAD(@cCodPad,@cCodPro,@cDescric,,cTipGui,cVersao)

			BR8->(DbSetOrder(1))
			If !BR8->( MsSeek(xFilial("BR8")+cCodPad+cCodPro) ) .and. cOrigem <> '2' //nao eh uma solicitacao
				cCodPad := GetNewPar("MV_PLCDPXM","01")
				cCodPro := GetNewPar("MV_PLPSPXM","99999994")
				cCodPro := padr(cCodPro,tamsx3("BR8_CODPSA")[1])
			EndIf

			AaDd( aMatIte, {"CODPAD" , cCodPad } )
			AaDd( aMatIte, {"CODPRO" , cCodPro } )
			AaDd( aMatIte, {"ESPPE"  , cEspPe} )
			AaDd( aMatIte, {"DESPRO" , cDescric } )
			AaDd( aMatIte, {"SLVPAD" , cSlvPad } )
			AaDd( aMatIte, {"SLVPRO" , cSlvPro} )
			AaDd( aMatIte, {"SLVDES" , cSlvDes} )

			cEspPe := ""

			nQtd := Val( u_CPEGCONR("QUANTIDADESOLICITADA",cGuia+"\PROCEDIMENTOSEXAMESSOLICITADOS",aMatM,,.T.,.F.,nil,cCodPeg) )
			AaDd( aMatIte, {"QTD" , nQtd } )
			AaDd( aMatIte, {"QTDAUT" , nQtd } )
			AaDd( aMatIte, {"VLRAPR" , 0 } )

			cViaAces := u_CPEGCONR("VIAACESSO",cGuia+"\PROCEDIMENTOSEXAMESSOLICITADOS",aMatM,nil,.T.,.F.,nil,cCodPeg, nLimite)
			If !Empty(cViaAces)
				cSql := " select R_E_C_N_O_ rec from "+RetSqlName("BGR")
				cSql += " where BGR_FILIAL = '"+xFilial('BGR')+"' "
				cSql += " and BGR_CODINT = '"+cOpeMov+"' "
				cSql += " and BGR_VIATIS = '"+cViaAces+"' "
				cSql += " and D_E_L_E_T_ = ' ' "
				PlsQuery(cSql,'trbBGR')
				If trbBGR->(!Eof()) .and. trbBGR->Rec > 0
					BGR->(DbGoTo(trbBGR->Rec))
					AaDd( aMatIte, {"PERVIA" , BGR->BGR_PERC } )
					AaDd( aMatIte, {"VIAACE" , BGR->BGR_CODVIA } )
				Endif
				trbBGR->(DbCloseArea())
			Endif


		// Incluir tratamento quando for EVOLUCAO (PRORROGACAO)
			If lEvolu
				AaDd( aMatIte, {"NUMIMP" , cNumImp } )
			EndIf
			If Len(aTpPRec) >0
				AaDd( aMatIte, {"ATPPAR" , aTpPRec } )
			Endif

			AaDd(aItens,aMatIte)
		EndDo

	// Procedimentos Solicitados
		While !Empty( ( cCodPro := u_CPEGCONR("CODIGO",cGuia+"\PROCEDIMENTOSSOLICITADOS",aMatM,,.T.,nil,nil,cCodPeg) ) )
			aMatIte := {}
			AaDd( aMatIte, {"SEQMOV" , cCont } )
			cCont := soma1(cCont)

			cCodPad := u_CPEGCONR("TIPOTABELA",cGuia+"\PROCEDIMENTOSSOLICITADOS",aMatM,,.T.,.F.,nil,cCodPeg)
			cSlvPad := cCodPad
			cDescric := u_CPEGCONR("DESCRICAO",cGuia+"\PROCEDIMENTOSSOLICITADOS",aMatM,,.T.,.F.,nil,cCodPeg)
			cSlvDes := cDescric
			cCodPro := padr(cCodPro,tamsx3("BR8_CODPSA")[1])
			cSlvPro := cCodPro

			If PLSPOSGLO(PLSINTPAD(),__aCdCri198[1],__aCdCri198[2],cLocalExec,"1",cTipoGrv)
				aRetTuss := PLSDPTUSS('E',cCodPad,cCodPro)
				If !Empty(aRetTuss[1])
					cCodPad := aRetTuss[1]
					cCodPro := aRetTuss[2]
					cCodPro := padr(cCodPro,tamsx3("BR8_CODPSA")[1])
				EndIf
			EndIf

			u_CBXPAD(@cCodPad,@cCodPro,@cDescric,,cTipGui,cVersao)

			BR8->(DbSetOrder(1))
			If !BR8->( MsSeek(xFilial("BR8")+cCodPad+cCodPro) ) .and. cOrigem <> '2' //nao eh uma solicitacao
				cCodPad := GetNewPar("MV_PLCDPXM","01")
				cCodPro := GetNewPar("MV_PLPSPXM","99999994")
				cCodPro := padr(cCodPro,tamsx3("BR8_CODPSA")[1])
			EndIf

			AaDd( aMatIte, {"CODPAD" , cCodPad } )
			AaDd( aMatIte, {"CODPRO" , cCodPro } )
			AaDd( aMatIte, {"DESPRO" , cDescric } )
			AaDd( aMatIte, {"ESPPE"  , cEspPe} )
			AaDd( aMatIte, {"SLVPAD" , cSlvPad } )
			AaDd( aMatIte, {"SLVPRO" , cSlvPro} )
			AaDd( aMatIte, {"SLVDES" , cSlvDes} )

			cEspPe := ""

			nQtd := Val( u_CPEGCONR("QUANTIDADESOLICITADA",cGuia+"\PROCEDIMENTOSSOLICITADOS",aMatM,,.T.,.F.,nil,cCodPeg) )
			AaDd( aMatIte, {"QTD" , nQtd } )
			AaDd( aMatIte, {"QTDAUT" , nQtd } )
			AaDd( aMatIte, {"VLRAPR" , 0 } )
			AaDd(aItens,aMatIte)
		EndDo

	// Procedimentos Realizados
		While !Empty( ( aMatPro := u_CPEGCONR("CODIGO",cGuia+"\PROCEDIMENTOSREALIZADOS",aMatM,nil,.F.,nil,.T.,cCodPeg) )[1] )
			lAchouVlr  := .F. //Reinicializa a variavel de valor apresentado
			nPosVlrApr := 0 //Reinicializa a posicao da tag CODIGO para verificar se foi informado o valor do procedimento

			cCodPro := aMatPro[1]
			cCodPro := padr(cCodPro,tamsx3("BR8_CODPSA")[1])
			cSlvPro := cCodPro
			aMatIte := {}
			AaDd( aMatIte, {"SEQMOV" , cCont } )
			cCont := soma1(cCont)

			cCodPad := u_CPEGCONR("TIPOTABELA",cGuia+"\PROCEDIMENTOSREALIZADOS",aMatM,nil,.T.,.F.,nil,cCodPeg)
			cSlvPad := cCodPad
			cDescric := u_CPEGCONR("DESCRICAO",cGuia+"\PROCEDIMENTOSREALIZADOS",aMatM,nil,.T.,.F.,nil,cCodPeg)
			cSlvDes := cDescric
			dDatRea := u_CBAJUDAT(Alltrim(u_CPEGCONR("DATAEXECUCAO",cGuia+"\PROCEDIMENTOSREALIZADOS",aMatM,nil,nil,nil,nil,cCodPeg)))

			If PLSPOSGLO(PLSINTPAD(),__aCdCri198[1],__aCdCri198[2],cLocalExec,"1",cTipoGrv)
				aRetTuss := PLSDPTUSS('E',cCodPad,cCodPro)
				If !Empty(aRetTuss[1])
					cCodPad := aRetTuss[1]
					cCodPro := aRetTuss[2]
					cCodPro := padr(cCodPro,tamsx3("BR8_CODPSA")[1])
				EndIf
			EndIf

			u_CBXPAD(@cCodPad,@cCodPro,@cDescric,,cTipGui,cVersao,dDatRea)

			BR8->(DbSetOrder(1))
			If !BR8->( MsSeek(xFilial("BR8")+cCodPad+cCodPro) ) .and. cOrigem <> '2' //nao eh uma solicitacao
				cCodPad := GetNewPar("MV_PLCDPXM","01")
				cCodPro := GetNewPar("MV_PLPSPXM","99999994")
				cCodPro := padr(cCodPro,tamsx3("BR8_CODPSA")[1])
			EndIf

			AaDd( aMatIte, {"CODPAD" , cCodPad } )
			AaDd( aMatIte, {"CODPRO" , cCodPro } )
			AaDd( aMatIte, {"DESPRO" , cDescric } )
			AaDd( aMatIte, {"ESPPE"  , cEspPe} )
			AaDd( aMatIte, {"SLVPAD" , cSlvPad } )
			AaDd( aMatIte, {"SLVPRO" , cSlvPro} )
			AaDd( aMatIte, {"SLVDES" , cSlvDes} )

			cEspPe := ""

			nQtd := Val( u_CPEGCONR("QUANTIDADEREALIZADA",cGuia+"\PROCEDIMENTOSREALIZADOS",aMatM,nil,.T.,.F.,nil,cCodPeg) )
			AaDd( aMatIte, {"QTD" , nQtd } )
			AaDd( aMatIte, {"QTDAUT" , nQtd } )

			cViaAces := u_CPEGCONR("VIAACESSO",cGuia+"\PROCEDIMENTOSREALIZADOS",aMatM,nil,.T.,.F.,nil,cCodPeg)
			If !Empty(cViaAces)
				cSql := " select R_E_C_N_O_ rec from "+RetSqlName("BGR")
				cSql += " where BGR_FILIAL = '"+xFilial("BGR")+"' "
				cSql += " and BGR_CODINT = '"+cOpeMov+"' "
				cSql += " and BGR_VIATIS = '"+cViaAces+"' "
				cSql += " and D_E_L_E_T_ = ' ' "
				PlsQuery(cSql,'trbBGR')
				If trbBGR->(!Eof()) .and. trbBGR->Rec > 0
					BGR->(DbGoTo(trbBGR->Rec))
					AaDd( aMatIte, {"PERVIA" , BGR->BGR_PERC } )
					AaDd( aMatIte, {"VIAACE" , BGR->BGR_CODVIA } )
				Endif
				trbBGR->(DbCloseArea())
			Endif
		//eu carrego todas as composicoes possiveis ou seja, vou pegar o que tiver no bd4 - nao mexer aqui - consultar daher
			aSlvTprec := aClone(aTpPRec)
			If Len(aTpPRec) == 0
				For nPos:=1 to Len (aMatBWT)
					AaDd( aTpPRec,{ aMatBWT[nPos,2],If(Empty(cConPrEx),cCodRP,cConPrEx),If(Empty(cNomRdEx),cNomRda,cNomRdEx),cCrmRda,cSlgRda,cEstRda,cNomPre,.T.,'','',u_CBRetUnp(aMatBWT[nPos,2]) } )
				Next
			Endif
			If Len(aTpPRec) > 0
				AaDd( aMatIte, {"ATPPAR" , aTpPRec } )
			Endif
			aTpPRec := aClone(aSlvTprec)

		// Verifica se foi informado valor ao procedimento processado
			nPosVlrApr := aScan (aMatM,{ |x|x[1] == "CODIGO" .and. alltrim(cSlvPro) == alltrim(x[2]) .And. "\PROCEDIMENTOSREALIZADOS" $ x[3]})
			If nPosVlrApr <> 0
				nPosVlrApr ++
				nVlrApr1 := 0
				nVlrApr  := 0
				While nPosVlrApr <= len(aMatM) .And. aMatM[nPosVlrApr][1] <> "CODIGO"

	         // Se achar a tag de valor, alimenta o array com o que foi apresentado nela dennis2
					If aMatM [nPosVlrApr][1] == "VALORTOTAL"
						nVlrTot := Val( strtran( u_CPEGCONR("VALORTOTAL",cGuia+"\PROCEDIMENTOSREALIZADOS",aMatM,nil,.T.,.F.,nil,cCodPeg),',',"." ) )
						nVlrApr1 := nVlrTot/nQtd
						AaDd( aMatIte, {"VLRAPR" , nVlrApr1 } )
						lAchouVlr := .T.
						Exit
					EndIf

					If aMatM [nPosVlrApr][1] == "VALOR"
						nVlrApr := Val( strtran( u_CPEGCONR("VALOR",cGuia+"\PROCEDIMENTOSREALIZADOS",aMatM,nil,.T.,.F.,nil,cCodPeg),',',"." ) )
					EndIf
					nDifIt := nVlrApr - nVlrApr1
					AaDd( aDados, {"VLRDIF" , nDifIt } )
					nPosVlrApr ++
				EndDo
				nDifIt := nVlrApr - nVlrApr1
				AaDd( aMatIte, {"VLRDIF" , nDifIt } )

			EndIf

		// Se nao achou a tag de valor alimenta o Array com o valor zerado
			If !lAchouVlr
				AaDd( aMatIte, {"VLRAPR" , 0 } )
			EndIf

			AaDd( aMatIte, {"HORINI" , SubStr(u_CPEGCONR("HORAINICIO",cGuia+"\PROCEDIMENTOSREALIZADOS",aMatM,nil,.T.,nil,nil,cCodPeg),1,5) } )
			AaDd( aMatIte, {"HORFIM" , SubStr(u_CPEGCONR("HORAFIM",cGuia+"\PROCEDIMENTOSREALIZADOS",aMatM,nil,.T.,nil,nil,cCodPeg),1,5) } )
			AaDd( aMatIte, {"DATPRO" , u_CBAJUDAT( u_CPEGCONR("DATA",cGuia+"\PROCEDIMENTOSREALIZADOS",aMatM,nil,.T.,nil,nil,cCodPeg) ) } )
			lMemEqui := .F.
			aTpPRe2  := {}
			aPosEnv  := {}

		// Pega o tipo de participacao e equipe
			While !Empty( (aMatEqu := u_CPEGCONR("POSICAOPROFISSIONAL",cGuia+"\PROCEDIMENTOSREALIZADOS\PROCEDIMENTOS\EQUIPE\MEMBROEQUIPE",aMatM,nil,nil,nil,.T.,cCodPeg) )[1] ) .And. aMatEqu[2] < aMatPro[2]

				cSigla 	:= ""
				cCrm 	:= ""
				cUf 	:= ""
				cNome   := ""

				AaDd( aPosEnv, aMatEqu[1]  )//posicao do profissional enviada pelo prestador

				aMatM[aMatEqu[2],1] := "*"+aMatM[aMatEqu[2],1]
				cCdMbEq := u_CPEGCONR("CPF,CNPJ,CODIGOPRESTADORNAOPERADORA",cGuia+"\PROCEDIMENTOSREALIZADOS\PROCEDIMENTOS\EQUIPE\MEMBROEQUIPE\CODIGOPROFISSIONAL",aMatM,nil,.T.,.F.,nil,cCodPeg)
				cCdMbEq := cCdMbEq+Space( TamSX3("BAU_CPFCGC")[1]-Len(cCdMbEq) )
				cCbos 	:= u_CPEGCONR("CODIGOCBOS",cGuia+"\PROCEDIMENTOSREALIZADOS\PROCEDIMENTOS\EQUIPE\MEMBROEQUIPE\IDENTIFICACAOPROFISSIONAL",aMatM,,.T.,.F.,nil,cCodPeg)
				nIdx 	:= 3

				If ExistBlock("PLTISESP")
					aRetPe := ExecBlock( "PLTISESP",.F.,.F.,{cCbos} )
					If ValType(aRetPe) == "A"
						cCbos  := aRetPe[1]
						cEspPe := aRetPe[2]
					Endif
				EndIf

				If Empty(cCdMbEq)
					cCdMbEq := u_CPEGCONR("CODIGOPRESTADORNAOPERADORA",cGuia+"\PROCEDIMENTOSREALIZADOS\PROCEDIMENTOS\EQUIPE\MEMBROEQUIPE\CODIGOPROFISSIONAL",aMatM,nil,.T.,.F.,nil,cCodPeg)
					nIdx 	:= 1
				//significa que o meu cliente me mandou o BAU_CODRDA no CODIGOPRESTADORNAOPERADORA
					If Len(alltrim(cCdMbEq)) == 6
						nOrdBAU := BAU->(IndexOrd())
						nRecBAU := BAU->(Recno())
						BAU->(DbSetOrder(1))
						If  BAU->(MsSeek(xFilial("BAU")+padr(cCdMbEq,6))) .and. !Empty(BAU->BAU_CODBB0)
							cCdMbEq := BAU->BAU_CODBB0
						Endif
						BAU->(DbGoTo(nRecBAU))
						BAU->(DbSetOrder(nOrdBAU))
					Endif
				EndIf

				U_CBIVPRO(cCdMbEq,'','','',nIdx,,aDados,nil,cCbos)
				u_CBXSCU(cCdMbEq,'','','','',NIL,nil,nil,'',cCbos,cData,aMatM)

				If BB0->( Found() )
					cCdMbEq := BB0->BB0_CODIGO
				Else
					cCdMbEq := ""
				Endif

				If Empty(cCdMbEq)
					cSigla 	:= u_CPEGCONR("SIGLACONSELHO",cGuia+"\PROCEDIMENTOSREALIZADOS\PROCEDIMENTOS\EQUIPE\MEMBROEQUIPE\CODIGOPROFISSIONAL\CONSELHOPROFISSIONAL",aMatM,,.T.,.F.,nil,cCodPeg)
					cCrm 	:= u_CPEGCONR("NUMEROCONSELHO",cGuia+"\PROCEDIMENTOSREALIZADOS\PROCEDIMENTOS\EQUIPE\MEMBROEQUIPE\CODIGOPROFISSIONAL\CONSELHOPROFISSIONAL",aMatM,,.T.,.F.,nil,cCodPeg)
					cUf 	:= u_CPEGCONR("UFCONSELHO",cGuia+"\PROCEDIMENTOSREALIZADOS\PROCEDIMENTOS\EQUIPE\MEMBROEQUIPE\CODIGOPROFISSIONAL\CONSELHOPROFISSIONAL",aMatM,,.T.,.F.,nil,cCodPeg)
					cNome   := u_CPEGCONR("NOMEEXECUTANTE",cGuia+"\PROCEDIMENTOSREALIZADOS\PROCEDIMENTOS\EQUIPE\MEMBROEQUIPE\CODIGOPROFISSIONAL",aMatM,,.T.,.F.,nil,cCodPeg)
					nIdx 	:= 4

					U_CBIVPRO("",cSigla,cCrm,cUf,nIdx,,aDados,nil,cCbos)
					u_CBXSCU("",cSigla,cCrm,cUf,"",NIL,nil,nil,cNome,cCbos,cData,aMatM)

					If BB0->( Found() )
						cCdMbEq := BB0->BB0_CODIGO
					EndIf
				EndIf

				If Empty(cCdMbEq)
					cSigla 	:= u_CPEGCONR("SIGLACONSELHO",cGuia+"\PROCEDIMENTOSREALIZADOS\PROCEDIMENTOS\EQUIPE\MEMBROEQUIPE\IDENTIFICACAOPROFISSIONAL",aMatM,,.T.,.F.,nil,cCodPeg)
					cCrm 	:= u_CPEGCONR("NUMEROCONSELHO",cGuia+"\PROCEDIMENTOSREALIZADOS\PROCEDIMENTOS\EQUIPE\MEMBROEQUIPE\IDENTIFICACAOPROFISSIONAL",aMatM,,.T.,.F.,nil,cCodPeg)
					cUf 	:= u_CPEGCONR("UFCONSELHO",cGuia+"\PROCEDIMENTOSREALIZADOS\PROCEDIMENTOS\EQUIPE\MEMBROEQUIPE\IDENTIFICACAOPROFISSIONAL",aMatM,,.T.,.F.,nil,cCodPeg)
					cNome	:= u_CPEGCONR("NOMEEXECUTANTE",cGuia+"\PROCEDIMENTOSREALIZADOS\PROCEDIMENTOS\EQUIPE\MEMBROEQUIPE",aMatM,,.T.,.F.,nil,cCodPeg)

					nIdx 	:= 4

					U_CBIVPRO("",cSigla,cCrm,cUf,nIdx,"E",aDados,nil,cCbos)
					u_CBXSCU("",cSigla,cCrm,cUf,"E",NIL,nil,nil,cNome,cCbos,cData,aMatM)

				Endif
				cCodBAU := ""
				cEspExe := ""

				If BB0->( Found() )
					cSlgRda := BB0->BB0_CODSIG
					cCrmRda := BB0->BB0_NUMCR
					cEstRda := BB0->BB0_ESTADO
					cNomPre := BB0->BB0_NOME
	      		//Aqui eu faco um tratamento para que leve la para o BD7 o codigo
				//da RDA (se o profissional for uma RDA) executante no campo BD7_CDPFPR
					nRecBAU := BAU->(Recno())
					nOrdBAU := BAU->(IndexOrd())
					BAU->(DbSetOrder(5))
					If BAU->(MsSeek(xFilial("BAU")+BB0->BB0_CODIGO))
						cCodBAU := BAU->BAU_CODBB0
						If PlsAliasExi("BQ1") .and. !Empty(cCbos)
							BAQ->(DbSetOrder(4))
							If BAQ->( MsSeek( xFilial("BAQ")+PlsIntPad()+cCbos ) )
								BQ1->(DbSetOrder(1))
								If BQ1->(MsSeek(xFilial("BQ1")+BB0->BB0_CODIGO+BAQ->BAQ_CODESP))
									cEspExe := BAQ->BAQ_CODESP
								Endif
							Endif
						Endif
					Endif
					BAU->(DbGoTo(nRecBAU))
					BAU->(DbSetOrder(nOrdBAU))
				EndIf


			// Monta o tipo de participacao conforme a tabela bwt de/para
			//manter legado... alteracao daher
				aSlvBWT := aClone(aMatBWT)
				lEntrou := .F.
				while ( nPos := aScan( aMatBWT,{ |x|x[3]==aMatEqu[1] } ) ) > 0
					AaDd( aTpPRe2,{ aMatBWT[nPos,2],If(Empty(cConPrEx),cCodRP,cConPrEx),If(Empty(cNomRdEx),cNomRda,cNomRdEx),cCrmRda,cSlgRda,cEstRda,cNomPre,.T.,cCodBAU,cEspExe,u_CBRetUnp(aMatBWT[nPos,2]) } )
					lEntrou := .T.
					nSize := Len(aMatBWT)
					aDel(aMatBWT,nPos)
					aSize(aMatBWT,nSize-1)
				Enddo
				If !lEntrou
					AaDd( aTpPRe2,{ GetNewPar("MV_PLSNAPL","O"),If(Empty(cConPrEx),cCodRP,cConPrEx),If(Empty(cNomRdEx),cNomRda,cNomRdEx),cCrmRda,cSlgRda,cEstRda,cNomPre,.T.,cCodBAU,cEspExe,u_CBRetUnp( GetNewPar("MV_PLSNAPL","O")) } )
				EndIf
				aMatBWT := aClone(aSlvBWT)

				cCdMbEq  := ""
				cCrmRda := ""
				cSlgRda := ""
				cEstRda := ""
				cNomPre := ""
			EndDo
			AaDd( aMatIte, {"POSENV" , aclone(aPosEnv) } ) //posicao profissional enviada para um determinado evento

		// Marca no Array aMatM o Procedimento utilizado
			cCodPro := u_CPEGCONR("CODIGO",cGuia+"\PROCEDIMENTOSREALIZADOS",aMatM,nil,.T.,nil,.T.,cCodPeg)
			cCodPro := padr(cCodPro,tamsx3("BR8_CODPSA")[1])
			aClonTp := {}

			If Len(aTpPRe2) > 0
				lMemEqui := .T.
			//se o cara mandou a participacao por mebro da equipe o sistema esquece todas as participacoes e so grava as participacaoes da equipe
				For nPosXX:=1 to Len(aMatIte)
					If alltrim(aMatIte[nPosXX][1]) == "ATPPAR"
						aClonTp := aClone(aMatIte[nPosXX][2])
						nSize := Len(aMatIte)
						aDel(aMatIte,nPosXX)
						aSize(aMatIte,nSize-1)
						exit
					Endif
				Next

				AaDd( aMatIte, {"ATPPAR" , aClone(aTpPRe2) } )

			// se a operadora quiser que independente dos membros de equipe o sistema sempre importe as demais unidades - referentes ao CUSTO e FILME (BD7's)
			// ela deve informar neste parametro as classes de operadora que ela deseja que esta regra seja valida.
			// IMPORTANTE - Se as classes que identificam as RDAS DE COOPERATIVAS estiverem neste parametro, pode dar problema
			// por exemplo, a COOPERATIVA DE ANESTESISTAS DE BELO HORIZONTE manda so o AUX no arquivo. Se ele entrar nesse if
			// o sistema ira importar o CUSTO e FILME por exemplo.
			// unidades referentes ao CUsto e Filme:
			// aUnidades := {"COP","COR","UCO","FIL","DOP","CRR","INC","TCR","VDI","VMD","VMT","VTX","REA"}
				If  alltrim(cTipPOr) $ GetNewPar("MV_PTRTAEV",'')
					xPt := aScan(aMatIte,{|x| x[1] == "ATPPAR"})

					aUnidades := {"COP","COR","UCO","FIL","DOP","CRR","INC","TCR","VDI","VMD","VMT","VTX","REA"}
					If ExistBlock("PLSXMLAUN")
						aUnidades := ExecBlock( "PLSXMLAUN",.F.,.F.,aUnidades )
					Endif

					For nI:=1 to Len(aClonTp)
						If (nPos := aScan(aMatIte[xPt][2],{|x| alltrim(x[1]) == alltrim(aClonTp[nI][1])})) == 0
							aadd(aMatIte[xPt][2],aClone(aClonTp[nI]))
							aMatIte[xPt][2][Len(aMatIte[xPt][2])][11] := aClone(aUnidades)
						Endif
					Next
				Endif
			Endif
		//se o prestador esta mandando participacoes que ele ja mandou de um determinado procedimento, eu sou obrigado a criar outro evento,
		//pois de fato sao 2 procedimentos distintos... mesmo que a hora e data seja a mesma (porque os hospitais erram mto a digitacao...)
			lForPro := .F.
			For nI:= 1 to Len(aPosEnv)
				If u_cRtPos('CODPAD',aMatIte) > 0 .and. u_cRtPos('CODPRO',aMatIte) > 0 .and. u_cRtPos('HORINI',aMatIte) > 0  .and. u_cRtPos('HORFIM',aMatIte) > 0 .and. ;
						u_cRtPos('DATPRO',aMatIte) > 0 .and. u_cRtPos('QTDAUT',aMatIte) > 0 .and. u_cRtPos('ATPPAR',aMatIte) > 0  .and. u_cRtPos('VLRAPR',aMatIte) > 0
		       //VARIAVEIS DE POSICIONAMENTO

					For nT := 1 To Len(aItens)
						nPCODPAD1 := u_cRtPos('CODPAD',aItens[nT])
						nPCODPAD2 := u_cRtPos('CODPAD',aMatIte)
						nPCODPRO1 := u_cRtPos('CODPRO',aItens[nT])
						nPCODPRO2 := u_cRtPos('CODPRO',aMatIte)
						nPHORINI1 := u_cRtPos('HORINI',aItens[nT])
						nPHORINI2 := u_cRtPos('HORINI',aMatIte)
						nPHORFIM1 := u_cRtPos('HORFIM',aItens[nT])
						nPHORFIM2 := u_cRtPos('HORFIM',aMatIte)
						nPDATPRO1 := u_cRtPos('DATPRO',aItens[nT])
						nPDATPRO2 := u_cRtPos('DATPRO',aMatIte)
						nPQTDAUT1 := u_cRtPos('QTDAUT',aItens[nT])
						nPQTDAUT2 := u_cRtPos('QTDAUT',aMatIte)
						xVCODPAD2 := aMatIte[nPCODPAD2,2]
						xVCODPRO2 := aMatIte[nPCODPRO2,2]
						xVHORINI2 := aMatIte[nPHORINI2,2]
						xVHORFIM2 := aMatIte[nPHORFIM2,2]
						xVDATPRO2 := aMatIte[nPDATPRO2,2]
						xVQTDAUT2 := aMatIte[nPQTDAUT2,2]

						If aItens[nT,nPCODPAD1, 2] == xVCODPAD2 .AND.;
								aItens[nT,nPCODPRO1][2] == xVCODPRO2   .and. ;//CODPRO
							aItens[nT,nPHORINI1][2] == xVHORINI2   .and. ;//HORINI
							aItens[nT,nPHORFIM1][2] == xVHORFIM2   .and. ;//HORFIN
							aItens[nT,nPDATPRO1][2] == xVDATPRO2  .and. ;//DATPRO
							aItens[nT,nPQTDAUT1][2] == xVQTDAUT2  .and. (nJ:=u_cRtPos('POSENV',aItens[nT])) > 0

							If aScan(aItens[nT][nJ][2],{|x| x == aPosEnv[nI] }) > 0

								lForPro := .T.
								exit

							Endif
						EndIf
					Next nT

				Endif
			Next

		// Indica se os eventos deverão ser aglutinados ou se ele
		// ira criar um BD6 para cada evento enviado a regra de aglutinacao eh
		// data + hora + evento + tipo tabela + qtd
		// Nao se soma a quantidade pois o cara esta informando as parta	1234icipacoes
		// em separado referente a um mesmo evento, ou seja, eh um evento so com
		// com varias participacoes
		// O PADRAO EH SEMPRE AGLUTINAR - QUANDO TEM MEMBRO DE EQUIPE
			If lMemEqui .and. !lForPro .And. GetNewPar("MV_PLTISME",.T.) .AND. !lNInfPar //TUTXA1
				If u_cRtPos('CODPAD',aMatIte) > 0 .and. u_cRtPos('CODPRO',aMatIte) > 0 .and. u_cRtPos('HORINI',aMatIte) > 0  .and. u_cRtPos('HORFIM',aMatIte) > 0 .and. ;
						u_cRtPos('DATPRO',aMatIte) > 0 .and. u_cRtPos('QTDAUT',aMatIte) > 0 .and. u_cRtPos('ATPPAR',aMatIte) > 0  .and. u_cRtPos('VLRAPR',aMatIte) > 0
					lEnAqu := .F.
					For nT:=1 to Len(aItens)

						nPCODPAD1 := u_cRtPos('CODPAD',aItens[nT])
						nPCODPAD2 := u_cRtPos('CODPAD',aMatIte)
						nPCODPRO1 := u_cRtPos('CODPRO',aItens[nT])
						nPCODPRO2 := u_cRtPos('CODPRO',aMatIte)
						nPHORINI1 := u_cRtPos('HORINI',aItens[nT])
						nPHORINI2 := u_cRtPos('HORINI',aMatIte)
						nPHORFIM1 := u_cRtPos('HORFIM',aItens[nT])
						nPHORFIM2 := u_cRtPos('HORFIM',aMatIte)
						nPDATPRO1 := u_cRtPos('DATPRO',aItens[nT])
						nPDATPRO2 := u_cRtPos('DATPRO',aMatIte)
						nPQTDAUT1 := u_cRtPos('QTDAUT',aItens[nT])
						nPQTDAUT2 := u_cRtPos('QTDAUT',aMatIte)
						// CBOS - Mateus - 25/04/18
						//nPQTDAUT2 := u_cRtPos('QTDAUT',aMatIte)
						// FIM CBOS
						xVCODPAD2 := aMatIte[nPCODPAD2,2]
						xVCODPRO2 := aMatIte[nPCODPRO2,2]
						xVHORINI2 := aMatIte[nPHORINI2,2]
						xVHORFIM2 := aMatIte[nPHORFIM2,2]
						xVDATPRO2 := aMatIte[nPDATPRO2,2]
						xVQTDAUT2 := aMatIte[nPQTDAUT2,2]

						If aItens[nT,nPCODPAD1, 2] == xVCODPAD2 .AND.;
								aItens[nT,nPCODPRO1][2] == xVCODPRO2   .and. ;//CODPRO
							aItens[nT,nPHORINI1][2] == xVHORINI2   .and. ;//HORINI
							aItens[nT,nPHORFIM1][2] == xVHORFIM2   .and. ;//HORFIN
							aItens[nT,nPDATPRO1][2] == xVDATPRO2  .and. ;//DATPRO
							aItens[nT,nPQTDAUT1][2] == xVQTDAUT2

							nPos:=nT


							aItens[nPos][u_cRtPos('VLRAPR',aItens[nPos])][2] += aMatIte[u_cRtPos('VLRAPR',aMatIte)][2]    //VLRAPR
						//nesta regra eu garanto que vou importar todas as composicoes que foram de fato enviadas pelo prestador
						//se a posicao 11 do array estiver vazia significa que o prestador me mandou esta composicao
						//sei isso por causa deste For nI:=1 to Len(aClonTp) la encima
							If (nJ:=u_cRtPos('ATPPAR',aMatIte)) > 0 .and. (xPto:=u_cRtPos('ATPPAR',aItens[nPos])) > 0
								For nP:=1 to Len(aMatIte[nJ][2])
									If  (nZo := aScan(aItens[nPos][xPto][2],{|x| alltrim(x[1]) == alltrim(aMatIte[nJ][2][nP][1]) })) > 0
										If Len(aItens[nPos][xPto][2][nZo][11]) > 0
											If Len(aMatIte[nJ][2][nP][11]) == 0
												For nE:=1 To Len(aItens[nPos][xPto][2][nZo])
													If ValType(aItens[nPos][xPto][2][nZo][nE]) <> 'A'
														aItens[nPos][xPto][2][nZo][nE] := aMatIte[nJ][2][nP][nE]
													Else
														aItens[nPos][xPto][2][nZo][nE] := aClone(aMatIte[nJ][2][nP][nE])
													Endif
												Next
											Endif
										Endif
									Else
										aadd(aItens[nPos][xPto][2],aClone(aMatIte[nJ][2][nP]))
									Endif

								Next
							Endif
						//neste array eu tenho efetivamente todas as participacoes que realmente foram enviadas para um determinado procedimento
							If (nJ:=u_cRtPos('POSENV',aItens[nPos])) > 0
								For nP:=1 to Len(aPosEnv)
									aadd(aItens[nPos][nJ][2],aPosEnv[nP])
								Next
							Endif
							lEnAqu := .T.
							exit
						Endif
					Next nT
					If !lEnAqu
						aMatIte := aSort( aMatIte,,, { |x, y| x[1] < y[1] } )
						AaDd(aItens,aClone(aMatIte))
					Endif
				Else
					aMatIte := aSort( aMatIte,,, { |x, y| x[1] < y[1] } )
					AaDd(aItens,aClone(aMatIte))
				Endif
			Else
				aMatIte := aSort( aMatIte,,, { |x, y| x[1] < y[1] } )
				AaDd(aItens,aClone(aMatIte))
			Endif
		EndDo

	// Outras Despesas
		While !Empty( ( cCodPro := u_CPEGCONR("CODIGO",cGuia+"\OUTRASDESPESAS",aMatM,nil,.F.,nil,nil,cCodPeg) ) )
			lAchouVlr  := .F. //Reinicializa a variavel de valor apresentado
			nPosVlrApr := 0 //Reinicializa a posicao da tag CODIGO para verificar se foi informado o valor do procedimento
			cCodProxml	:=	""
			aMatIte := {}
			AaDd( aMatIte, {"SEQMOV" , cCont } )
			cCont := soma1(cCont)

			cCodPad := u_CPEGCONR("TIPOTABELA",cGuia+"\OUTRASDESPESAS",aMatM,nil,.T.,.F.,nil,cCodPeg)
			cSlvPad := cCodPad
			cDescric := u_CPEGCONR("DESCRICAO",cGuia+"\OUTRASDESPESAS",aMatM,nil,.T.,.F.,nil,cCodPeg)
			cSlvDes := cDescric
			cCodPro := padr(cCodPro,tamsx3("BR8_CODPSA")[1])
			cSlvPro := cCodPro
			If PLSPOSGLO(PLSINTPAD(),__aCdCri198[1],__aCdCri198[2],cLocalExec,"1",cTipoGrv)
				aRetTuss := PLSDPTUSS('E',cCodPad,cCodPro)
				If !Empty(aRetTuss[1])
					cCodPad := aRetTuss[1]
					cCodPro := aRetTuss[2]
					cCodPro := padr(cCodPro,tamsx3("BR8_CODPSA")[1])
				EndIf
			EndIf



		// Tipo de Despesa
			cTpProc := AllTrim(Str( Val( u_CPEGCONR("TIPODESPESA",cGuia+"\OUTRASDESPESAS\DESPESA",aMatM,nil,.T.,.F.,nil,cCodPeg) ) ))
			Do Case
			Case cTpProc == "1"
				cTpProc := "7" 	//Gases Medicinais
			Case cTpProc == "2"
				cTpProc := "2" 	//Medicamento
			Case cTpProc == "3"
				cTpProc := "1" 	//Material
			Case cTpProc == "4"
				cTpProc := "3" 	//Taxas
			Case cTpProc == "5"
				cTpProc := "4" 	//Diarias
			Case cTpProc == "6"
				cTpProc := "8" 	//Alugueis
			EndCase

			dDatRea := u_CBAJUDAT( u_CPEGCONR("DATAEXECUCAO",cGuia+"\OUTRASDESPESAS\DESPESA\SERVICOSEXECUTADOS",aMatM,nil,nil,nil,nil,cCodPeg) )


			cCodProxml:=cCodPro
			u_CBXPAD(@cCodPad,@cCodPro,@cDescric,@cTpProc,cTipGui,cVersao,dDatRea)

			BR8->(DbSetOrder(1))
			If !BR8->( MsSeek(xFilial("BR8")+cCodPad+cCodPro) ) .and. cOrigem <> '2' //nao eh uma solicitacao
				cCodPad := GetNewPar("MV_PLCDPXM","01")
				cCodPro := GetNewPar("MV_PLPSPXM","99999994")
				cCodPro := padr(cCodPro,tamsx3("BR8_CODPSA")[1])
			EndIf


			AaDd( aMatIte, {"CODPAD" , cCodPad } )
			AaDd( aMatIte, {"CODPRO" , cCodPro } )
			AaDd( aMatIte, {"DESPRO" , cDescric } )

			AaDd( aMatIte, {"SLVPAD" , cSlvPad } )
			AaDd( aMatIte, {"SLVPRO" , cSlvPro} )
			AaDd( aMatIte, {"SLVDES" , cSlvDes} )

			nQtd := Val( u_CPEGCONR("QUANTIDADE",cGuia+"\OUTRASDESPESAS",aMatM,,.T.,.F.,nil,cCodPeg) )
			AaDd( aMatIte, {"QTD" , nQtd } )
			AaDd( aMatIte, {"QTDAUT" , nQtd } )

			AaDd( aMatIte, {"HORINI" , SubStr(u_CPEGCONR("HORAINICIAL",cGuia+"\OUTRASDESPESAS",aMatM,nil,.T.,nil,nil,cCodPeg),1,5) } )
			AaDd( aMatIte, {"HORFIM" , SubStr(u_CPEGCONR("HORAFINAL",cGuia+"\OUTRASDESPESAS",aMatM,,.T.,nil,nil,cCodPeg),1,5) } )
			AaDd( aMatIte, {"DATPRO" , u_CBAJUDAT( u_CPEGCONR("DATAREALIZACAO",cGuia+"\OUTRASDESPESAS\DESPESA",aMatM,,.T.,nil,nil,cCodPeg) ) } )

		//eu carrego todas as composicoes possiveis ou seja, vou pegar o que tiver no bd4 - nao mexer aqui - consultar daher
			aSlvTprec := aClone(aTpPRec)
			If Len(aTpPRec) == 0
				For nPos:=1 to Len (aMatBWT)
					AaDd( aTpPRec,{ aMatBWT[nPos,2],If(Empty(cConPrEx),cCodRP,cConPrEx),If(Empty(cNomRdEx),cNomRda,cNomRdEx),cCrmRda,cSlgRda,cEstRda,cNomPre,.T.,'','',u_CBRetUnp(aMatBWT[nPos,2]) } )
				Next
			Endif
			If Len(aTpPRec) > 0
				AaDd( aMatIte, {"ATPPAR" , aTpPRec } )
			Endif
			aTpPRec := aClone(aSlvTprec)

		// Verifica se foi informado valor da despesa processada
			nPosVlrApr := aScan (aMatM,{ |x|x[1] == "CODIGO" .and. (alltrim(cSlvPro) == alltrim(x[2]) .or. alltrim(cCodProxml) == alltrim(x[2]) ) .And. "\OUTRASDESPESAS" $ x[3]})
			If nPosVlrApr <> 0
				nPosVlrApr ++
				nVlrApr1 := 0
				nVlrApr  := 0
				While nPosVlrApr <= len(aMatM) .And. aMatM[nPosVlrApr][1] <> "CODIGO"

	          // Se achar a tag de valor, alimenta o array com o que foi apresentado nela dennis
					If aMatM [nPosVlrApr][1] == "VALORTOTAL"
						nVlrTot := Val( strtran( u_CPEGCONR("VALORTOTAL",cGuia+"\OUTRASDESPESAS",aMatM,nil,.T.,.F.,nil,cCodPeg),',',"." ) )
						nVlrApr1 := nVlrTot/nQtd
						AaDd( aMatIte, {"VLRAPR" , nVlrApr1 } )
						lAchouVlr := .T.
						Exit
					EndIf

					If aMatM [nPosVlrApr][1] == "VALORUNITARIO"
						nVlrApr := Val( strtran( u_CPEGCONR("VALORUNITARIO",cGuia+"\OUTRASDESPESAS",aMatM,nil,.T.,.F.,nil,cCodPeg),',',"." ) )
          	     //nVlrApr1 := nVlrTot/nQtd
        		 //AaDd( aMatIte, {"VLRAPR" , nVlrApr1 } )
        		 //lAchouVlr := .T.
                 //Exit
					EndIf
					nDifIt := nVlrApr - nVlrApr1
					AaDd( aDados, {"VLRDIF" , nDifIt } )
					nPosVlrApr ++
				EndDo
				nDifIt := nVlrApr - nVlrApr1
				AaDd( aMatIte, {"VLRDIF" , nDifIt } )
			EndIf

		// Se nao achou a tag de valorunitario alimenta o Array com o valor zerado
			If !lAchouVlr
				AaDd( aMatIte, {"VLRAPR" , 0 } )
			EndIf

		// Marca no Array aMatM a Despesa utilizada
			cCodPro := u_CPEGCONR("CODIGO",cGuia+"\OUTRASDESPESAS",aMatM,nil,.T.,nil,nil,cCodPeg)
			cCodPro := padr(cCodPro,tamsx3("BR8_CODPSA")[1])

			AaDd( aMatIte, {"TPPROC" , cTpProc } )
			AaDd(aItens,aMatIte)
		EndDo

	// OPM Solicitadas
		While !Empty( ( cCodPro := u_CPEGCONR("CODIGO",cGuia+"\OPMSSOLICITADAS",aMatM,,.T.,nil,nil,cCodPeg) ) )
			aMatIte := {}
			AaDd( aMatIte, {"SEQMOV" , cCont } )
			cCont := soma1(cCont)

			cCodPad := u_CPEGCONR("TIPOTABELA",cGuia+"\OPMSSOLICITADAS",aMatM,,.T.,.F.,nil,,cCodPeg)
			cSlvPad := cCodPad
			cDescric := u_CPEGCONR("DESCRICAO",cGuia+"\OPMSSOLICITADAS",aMatM,,.T.,.F.,nil,cCodPeg)
			cSlvDes := cDescric
			cCodPro := padr(cCodPro,tamsx3("BR8_CODPSA")[1])
			cSlvPro := cCodPro

			If PLSPOSGLO(PLSINTPAD(),__aCdCri198[1],__aCdCri198[2],cLocalExec,"1",cTipoGrv)
				aRetTuss := PLSDPTUSS('E',cCodPad,cCodPro)
				If !Empty(aRetTuss[1])
					cCodPad := aRetTuss[1]
					cCodPro := aRetTuss[2]
					cCodPro := padr(cCodPro,tamsx3("BR8_CODPSA")[1])
				EndIf
			EndIf

			u_CBXPAD(@cCodPad,@cCodPro,@cDescric,,cTipGui,cVersao)

			BR8->(DbSetOrder(1))
			If !BR8->( MsSeek(xFilial("BR8")+cCodPad+cCodPro) ) .and. cOrigem <> '2' //nao eh uma solicitacao
				cCodPad := GetNewPar("MV_PLCDPXM","01")
				cCodPro := GetNewPar("MV_PLPSPXM","99999994")
				cCodPro := padr(cCodPro,tamsx3("BR8_CODPSA")[1])
			EndIf

			AaDd( aMatIte, {"CODPAD" , cCodPad } )
			AaDd( aMatIte, {"CODPRO" , cCodPro } )
			AaDd( aMatIte, {"DESPRO" , cDescric } )

			AaDd( aMatIte, {"SLVPAD" , cSlvPad } )
			AaDd( aMatIte, {"SLVPRO" , cSlvPro} )
			AaDd( aMatIte, {"SLVDES" , cSlvDes} )

			nQtd := Val( u_CPEGCONR("QUANTIDADESOLICITADA",cGuia+"\OPMSSOLICITADAS",aMatM,,.T.,.F.,nil,cCodPeg) )
			AaDd( aMatIte, {"QTD" , nQtd } )
			AaDd( aMatIte, {"QTDAUT" , nQtd } )
			nVlrApr := Val( strtran( u_CPEGCONR("VALOR",cGuia+"\OPMSSOLICITADAS",aMatM,,.T.,.F.,nil,cCodPeg),',',"." ) )
			AaDd( aMatIte, {"VLRAPR" , nVlrApr } )
			AaDd(aItens,aMatIte)
		EndDo

	// OPM Solicitada
		While !Empty( ( cCodPro := u_CPEGCONR("CODIGO",cGuia+"\OPMSOLICITADA",aMatM,,.T.,nil,nil,cCodPeg) ) )
			aMatIte := {}
			AaDd( aMatIte, {"SEQMOV" , cCont } )
			cCont := soma1(cCont)

			cCodPad := u_CPEGCONR("TIPOTABELA",cGuia+"\OPMSOLICITADA",aMatM,,.T.,.F.,nil,cCodPeg)
			cSlvPad := cCodPad
			cDescric := u_CPEGCONR("DESCRICAO",cGuia+"\OPMSOLICITADA",aMatM,,.T.,.F.,nil,cCodPeg)
			cSlvDes := cDescric
			cCodPro := padr(cCodPro,tamsx3("BR8_CODPSA")[1])
			cSlvPro := cCodPro

			If PLSPOSGLO(PLSINTPAD(),__aCdCri198[1],__aCdCri198[2],cLocalExec,"1",cTipoGrv)
				aRetTuss := PLSDPTUSS('E',cCodPad,cCodPro)
				If !Empty(aRetTuss[1])
					cCodPad := aRetTuss[1]
					cCodPro := aRetTuss[2]
					cCodPro := padr(cCodPro,tamsx3("BR8_CODPSA")[1])
				EndIf
			EndIf

			u_CBXPAD(@cCodPad,@cCodPro,@cDescric,,cTipGui,cVersao)

			BR8->(DbSetOrder(1))
			If !BR8->( MsSeek(xFilial("BR8")+cCodPad+cCodPro) ) .and. cOrigem <> '2' //nao eh uma solicitacao
				cCodPad := GetNewPar("MV_PLCDPXM","01")
				cCodPro := GetNewPar("MV_PLPSPXM","99999994")
				cCodPro := padr(cCodPro,tamsx3("BR8_CODPSA")[1])
			EndIf

			AaDd( aMatIte, {"CODPAD" , cCodPad } )
			AaDd( aMatIte, {"CODPRO" , cCodPro } )
			AaDd( aMatIte, {"DESPRO" , cDescric } )

			AaDd( aMatIte, {"SLVPAD" , cSlvPad } )
			AaDd( aMatIte, {"SLVPRO" , cSlvPro} )
			AaDd( aMatIte, {"SLVDES" , cSlvDes} )

			nQtd := Val( u_CPEGCONR("QUANTIDADESOLICITADA",cGuia+"\OPMSOLICITADA",aMatM,,.T.,.F.,nil,cCodPeg) )
			AaDd( aMatIte, {"QTD" , nQtd } )
			AaDd( aMatIte, {"QTDAUT" , nQtd } )
			nVlrApr := Val( strtran( u_CPEGCONR("VALOR",cGuia+"\OPMSOLICITADA",aMatM,,.T.,.F.,nil,cCodPeg),',',"." ) )
			AaDd( aMatIte, {"VLRAPR" , nVlrApr } )
			AaDd(aItens,aMatIte)
		EndDo

	// OPM Utilizada Utilizadas
		While !Empty( ( cCodPro := u_CPEGCONR("CODIGO",cGuia+Iif(cTipo=="2","\OPMUTILIZADA","\OPMUTILIZADAS"),aMatM,nil,.T.,nil,nil,cCodPeg) ) )
			aMatIte := {}
			AaDd( aMatIte, {"SEQMOV" , cCont } )
			cCont := soma1(cCont)

			cCodPad := u_CPEGCONR("TIPOTABELA",cGuia+Iif(cTipo=="2","\OPMUTILIZADA","\OPMUTILIZADAS"),aMatM,,.T.,.F.,nil,cCodPeg)
			cSlvPad := cCodPad
			cDescric:= u_CPEGCONR("DESCRICAO",cGuia+Iif(cTipo=="2","\OPMUTILIZADA","\OPMUTILIZADAS"),aMatM,,.T.,.F.,nil,cCodPeg)
			cSlvDes := cDescric
			cCodPro := padr(cCodPro,tamsx3("BR8_CODPSA")[1])
			cSlvPro := cCodPro
			dDatRea := u_CBAJUDAT(Alltrim(u_CPEGCONR("DATAEXECUCAO",cGuia+Iif(cTipo=="2","\OPMUTILIZADA","\OPMUTILIZADAS"),aMatM,nil,nil,nil,nil,cCodPeg)))

			If PLSPOSGLO(PLSINTPAD(),__aCdCri198[1],__aCdCri198[2],cLocalExec,"1",cTipoGrv)
				aRetTuss := PLSDPTUSS('E',cCodPad,cCodPro)
				If !Empty(aRetTuss[1])
					cCodPad := aRetTuss[1]
					cCodPro := aRetTuss[2]
					cCodPro := padr(cCodPro,tamsx3("BR8_CODPSA")[1])
				EndIf
			EndIf

			u_CBXPAD(@cCodPad,@cCodPro,@cDescric,,cTipGui,cVersao,dDatRea)
			BR8->(DbSetOrder(1))
			If !BR8->( MsSeek(xFilial("BR8")+cCodPad+cCodPro) ) .and. cOrigem <> '2' //nao eh uma solicitacao
				cCodPad := GetNewPar("MV_PLCDPXM","01")
				cCodPro := GetNewPar("MV_PLPSPXM","99999994")
				cCodPro := padr(cCodPro,tamsx3("BR8_CODPSA")[1])
			EndIf

			AaDd( aMatIte, {"CODPAD" , cCodPad } )
			AaDd( aMatIte, {"CODPRO" , cCodPro } )
			AaDd( aMatIte, {"DESPRO" , cDescric } )

			AaDd( aMatIte, {"SLVPAD" , cSlvPad } )
			AaDd( aMatIte, {"SLVPRO" , cSlvPro} )
			AaDd( aMatIte, {"SLVDES" , cSlvDes} )

			nQtd := Val( u_CPEGCONR("QUANTIDADE",cGuia+Iif(cTipo=="2","\OPMUTILIZADA","\OPMUTILIZADAS"),aMatM,,.T.,.F.,nil,cCodPeg) )
			AaDd( aMatIte, {"QTD" , nQtd } )
			AaDd( aMatIte, {"QTDAUT" , nQtd } )
			nVlrApr := Val( strtran( u_CPEGCONR("VALORUNITARIO",cGuia+Iif(cTipo=="2","\OPMUTILIZADA","\OPMUTILIZADAS"),aMatM,,.T.,.F.,nil,cCodPeg),',',"." ) )
			AaDd( aMatIte, {"VLRAPR" , nVlrApr } )

		//eu carrego todas as composicoes possiveis ou seja, vou pegar o que tiver no bd4 - nao mexer aqui - consultar daher
			aSlvTprec := aClone(aTpPRec)
			If Len(aTpPRec) == 0
				For nPos:=1 to Len (aMatBWT)
					AaDd( aTpPRec,{ aMatBWT[nPos,2],If(Empty(cConPrEx),cCodRP,cConPrEx),If(Empty(cNomRdEx),cNomRda,cNomRdEx),cCrmRda,cSlgRda,cEstRda,cNomPre,.T.,'','',u_CBRetUnp(aMatBWT[nPos,2]) } )
				Next
			Endif
			If Len(aTpPRec) > 0
				AaDd( aMatIte, {"ATPPAR" , aTpPRec } )
			Endif
			aTpRec := aClone(aSlvTpRec)

			AaDd(aItens,aMatIte)
		EndDo

	// Honorario
		If lHonor
			While !Empty( ( cCodPro := u_CPEGCONR("CODIGO",cGuia+"\PROCEDIMENTOSEXAMESREALIZADOS\PROCEDIMENTOREALIZADO",aMatM,,.T.,nil,nil,cCodPeg) ) )
				aMatIte := {}
				AaDd( aMatIte, {"SEQMOV" , cCont } )
				cCont := soma1(cCont)

				cCodPad := u_CPEGCONR("TIPOTABELA",cGuia+"\PROCEDIMENTOSEXAMESREALIZADOS\PROCEDIMENTOREALIZADO",aMatM,,.T.,.F.,nil,cCodPeg)
				cSlvPad := cCodPad
				cDescric := u_CPEGCONR("DESCRICAO",cGuia+"\PROCEDIMENTOSEXAMESREALIZADOS\PROCEDIMENTOREALIZADO",aMatM,,.T.,.F.,nil,cCodPeg)
				cSlvDes := cDescric
				cCodPro := padr(cCodPro,tamsx3("BR8_CODPSA")[1])
				cSlvPro := cCodPro
				dDatRea := u_CBAJUDAT(Alltrim(u_CPEGCONR("DATAEXECUCAO",cGuia+"\PROCEDIMENTOSREALIZADOS",aMatM,nil,nil,nil,nil,cCodPeg)))

				If PLSPOSGLO(PLSINTPAD(),__aCdCri198[1],__aCdCri198[2],cLocalExec,"1",cTipoGrv)
					aRetTuss := PLSDPTUSS('E',cCodPad,cCodPro)
					If !Empty(aRetTuss[1])
						cCodPad := aRetTuss[1]
						cCodPro := aRetTuss[2]
						cCodPro := padr(cCodPro,tamsx3("BR8_CODPSA")[1])
					EndIf
				EndIf

				u_CBXPAD(@cCodPad,@cCodPro,@cDescric,,cTipGui,cVersao,dDatRea)
				BR8->(DbSetOrder(1))
				If !BR8->( MsSeek(xFilial("BR8")+cCodPad+cCodPro) ) .and. cOrigem <> '2' //nao eh uma solicitacao
					cCodPad := GetNewPar("MV_PLCDPXM","01")
					cCodPro := GetNewPar("MV_PLPSPXM","99999994")
					cCodPro := padr(cCodPro,tamsx3("BR8_CODPSA")[1])
				EndIf

				AaDd( aMatIte, {"CODPAD" , cCodPad } )
				AaDd( aMatIte, {"CODPRO" , cCodPro } )
				AaDd( aMatIte, {"DESPRO" , cDescric } )

				AaDd( aMatIte, {"SLVPAD" , cSlvPad } )
				AaDd( aMatIte, {"SLVPRO" , cSlvPro} )
				AaDd( aMatIte, {"SLVDES" , cSlvDes} )

				nQtd := Val( u_CPEGCONR("QUANTIDADEREALIZADA",cGuia+"\PROCEDIMENTOSEXAMESREALIZADOS\PROCEDIMENTOREALIZADO",aMatM,,.T.,.F.,nil,cCodPeg) )
				AaDd( aMatIte, {"QTD" , nQtd } )
				AaDd( aMatIte, {"QTDAUT" , nQtd } )

				cViaAces := u_CPEGCONR("VIAACESSO",cGuia+"\PROCEDIMENTOSEXAMESREALIZADOS",aMatM,nil,.T.,.F.,nil,cCodPeg)
				If !Empty(cViaAces)
					cSql := " select R_E_C_N_O_ rec from "+RetSqlName("BGR")
					cSql += " where BGR_FILIAL = '"+xFilial('BGR')+"' "
					cSql += " and BGR_CODINT = '"+cOpeMov+"' "
					cSql += " and BGR_VIATIS = '"+cViaAces+"' "
					cSql += " and D_E_L_E_T_ = ' ' "
					PlsQuery(cSql,'trbBGR')
					If trbBGR->(!Eof()) .and. trbBGR->Rec > 0
						BGR->(DbGoTo(trbBGR->Rec))
						AaDd( aMatIte, {"PERVIA" , BGR->BGR_PERC } )
						AaDd( aMatIte, {"VIAACE" , BGR->BGR_CODVIA } )
					Endif
					trbBGR->(DbCloseArea())
				Endif
			//no honorario individual o cara manda a participacao la no cabecalho
				If Len(aTpPRec) > 0
					AaDd( aMatIte, {"ATPPAR" , aTpPRec } )
				Endif


			// Verifica se foi informado valor ao procedimento processado
				nPosVlrApr := aScan (aMatM,{ |x|x[1] == "*CODIGO" .and. alltrim(cSlvPro) == alltrim(x[2]) .And. cGuia+"\PROCEDIMENTOSEXAMESREALIZADOS\PROCEDIMENTOREALIZADO" $ x[3]})
				If nPosVlrApr <> 0
					nPosVlrApr ++
					nVlrApr1 := 0
					nVlrApr  := 0

					While nPosVlrApr <= len(aMatM) .And. aMatM[nPosVlrApr][1] <> "CODIGO"

		         // Se achar a tag de valor, alimenta o array com o que foi apresentado nela dennis1³
						If aMatM [nPosVlrApr][1] == "VALORTOTAL"
							nVlrTot := Val( strtran( u_CPEGCONR("VALORTOTAL",cGuia+"\PROCEDIMENTOSEXAMESREALIZADOS\PROCEDIMENTOREALIZADO",aMatM,,.T.,.F.,nil,cCodPeg),',',"." ) )
							nVlrApr1 := nVlrTot/nQtd
							AaDd( aMatIte, {"VLRAPR" , nVlrApr1 } )
							lAchouVlr := .T.
							Exit
						EndIf

						If aMatM [nPosVlrApr][1] == "VALOR"
							nVlrApr := Val( strtran( u_CPEGCONR("VALOR",cGuia+"\PROCEDIMENTOSEXAMESREALIZADOS\PROCEDIMENTOREALIZADO",aMatM,,.T.,.F.,nil,cCodPeg),',',"." ) )
          	     //nVlrApr1 := nVlrTot/nQtd
        		 //AaDd( aMatIte, {"VLRAPR" , nVlrApr1 } )
        		 //lAchouVlr := .T.
                 //Exit
						EndIf
						nDifIt := nVlrApr - nVlrApr1
						AaDd( aDados, {"VLRDIF" , nDifIt } )
						nPosVlrApr ++
					EndDo
					nDifIt := nVlrApr - nVlrApr1
					AaDd( aMatIte, {"VLRDIF" , nDifIt } )

				EndIf

			// Se nao achou a tag de valor alimenta o Array com o valor zerado
				If !lAchouVlr
					AaDd( aMatIte, {"VLRAPR" , 0 } )
				EndIf
				AaDd( aMatIte, {"HORINI" , SubStr(u_CPEGCONR("HORAINICIO",cGuia+"\PROCEDIMENTOSEXAMESREALIZADOS\PROCEDIMENTOREALIZADO",aMatM,nil,.T.,nil,nil,cCodPeg),1,5) } )
				AaDd( aMatIte, {"HORFIM" , SubStr(u_CPEGCONR("HORAFIM",cGuia+"\PROCEDIMENTOSEXAMESREALIZADOS\PROCEDIMENTOREALIZADO",aMatM,,.T.,nil,nil,cCodPeg),1,5) } )
				AaDd( aMatIte, {"DATPRO" , u_CBAJUDAT( u_CPEGCONR("DATA",cGuia+"\PROCEDIMENTOSEXAMESREALIZADOS\PROCEDIMENTOREALIZADO",aMatM,,.T.,nil,nil,cCodPeg) ) } )

			// Participacao para os itens

				AaDd(aItens,aMatIte)
			EndDo
		EndIf
	EndIf


// Dados do Retorno Aux
	AaDd(aRetAux,cTpCab)								//1
	AaDd(aRetAux,cCCCab)								//2
	AaDd(aRetAux,PLSRETDAD( aDados,"CODRDA",cCodRP ))  //3
	AaDd(aRetAux,PLSRETDAD( aDados,"NOMRDA",cNomCont ))	//4
	AaDd(aRetAux,PLSRETDAD( aDados,"TPCRDA","" ))  		//5
	AaDd(aRetAux,PLSRETDAD( aDados,"CCRDA","" ))   		//6
	AaDd(aRetAux,cMatric)                           	//7
	AaDd(aRetAux,cNomeUsu)                          	//8
	AaDd(aRetAux,cNumeLot)                          	//9
	AaDd(aRetAux,cNumImp)                          		//10
	AaDd(aRetAux,lHonor)                            	//11
	AaDd(aRetAux,lResInt)                           	//12
	AaDd(aRetAux,cNumeSeq)                          	//13
	AaDd(aRetAux,u_CBAJUDAT(cData))                  	//14
	AaDd(aRetAux,cRdaOri)                           	//15
	AaDd(aRetAux,"")                           	//16 CNES
	AaDd(aRetAux,0)                           	//17 Valor Total da Guia
	AaDd(aRetAux,"")                           	//18 RN

// processa a guia
	If lOk .And. lProcLog
		cNumLib := PLSRETDAD( aDados,"NUMLIB","" )
		If !Empty( cNumLib ) .And. PLSRETDAD( aDados,"ORIGEM","" ) == '1'
			U_cbAJULIB(cNumLib,aItens)
		EndIf
		if !l974Xml
			If !lOnline .AND. !lBg
				If GetRpoRelease()=="R1.1"
					oSelf:incRegua1("RDA [" + AllTrim(cRdaOri) + "] Guia Prest. [" + cNumImp + "]")
				Else
					IncProc("Prestador [" + AllTrim(cRdaOri) + "] Guia Prest. [" + cNumImp + "]")
					ProcessMessage()
				Endif
			EndIf
		endIf
		aRet := PLSXAUTP(aDados,aItens)

	//se estou importando um XML vou alimentar a nova tabela BXV com a chave da guia que acabei de criar
		If PlsAliasExi('BXV') .and. l974Xml .and. nSeqGui > 0
			BXX->(dbSetOrder(6))//BXX_FILIAL + BXX_CODINT +  BXX_CODPEG
			If BXX->(msSeek(xFilial("BXX")+cOpeMov+cCodPeg))
				cSeqBXX   := padr(BXX->BXX_SEQUEN,tamsx3('BXV_CHVALI')[1])
			Endif

			cChvGuia := strtran(strtran(strtran(aRet[2],'-',''),space(2),''),space(1),'')
			cSeqGuia := strzero(nSeqGui,3)
			If !Empty(cSeqBXX)
				BXV->(DbSetOrder(1))
				If BXV->(MsSeek(xFilial("BXV")+"BXX"+cSeqBXX+cSeqGuia))
					While !BXV->(Eof()) .and. BXV->(BXV_FILIAL+BXV_ALIAS+BXV_CHVALI+BXV_SEQGUI) == xFilial("BXV")+"BXX"+cSeqBXX+cSeqGuia

						BXV->(Reclock("BXV",.F.))
						BXV->BXV_CHVGUI := cChvGuia
						BXV->(MsUnlock())

						BXV->(DbSkip())
					Enddo
				Endif
			Endif
		Endif
	EndIf

Return( { aRetAux,aRet } )

/*/{Protheus.doc} u_CBIVRDA
Verifica a rda e inclui o solicitante
@type function
@author TOTVS
@since 25.06.08
@version 1.0
/*/
User Function CBIVRDA(cCodRP,nIdx,cES,aDados)
	DEFAULT cES := ""

// Verifica a rda
// Ponto de Entrada PLSCODRP para se verificar se o cCodRP foi passado errado
// caso tenha sido passado errado o PE retorna a infomação desejada
	If Existblock("PLSCODRP")
		cCodRP := ExecBlock("PLSCODRP",.F.,.F.,{cCodRP,nIdx})
	Endif
	If !Empty(cCodRP)
		BAU->( DbSetOrder( nIdx ) ) //BAU_FILIAL + BAU_CPFCGC ou  BAU_CODIGO ou BAU_CODBB0
		If BAU->( MsSeek( xFilial("BAU")+cCodRP ) )

			If aDados <> NIL
				AaDd( aDados, {"CODRDA",BAU->BAU_CODIGO } )
				AaDd( aDados, {"NOMRDA",AllTrim(BAU->BAU_NOME) } )
				AaDd( aDados, {"TPCRDA",AllTrim(BAU->BAU_TIPPE) } )
				AaDd( aDados, {"CCRDA",AllTrim(BAU->BAU_CPFCGC) } )
			EndIf

			If !Empty(cES) .and. !Empty(BAU->BAU_CODBB0)
				U_CBIVPRO(BAU->BAU_CODBB0,"","","",1,cES,aDados)
				If !BAU->( Found() ) // esse item foi tratado para os casos de prestador pessoa fisica onde bau_codbb0 assim não ocasionando a critica X24, item despocionando
					BAU->( MsSeek( xFilial("BAU")+cCodRP ) )
				Endif
			EndIf

		EndIf
	EndIf

Return

/*/{Protheus.doc} U_CBIVPRO
Verifica o profissional
#tissver 2.x,3.x

@type Function
@author Alexander Santos
@since 17/03/2007
@version 1.0
/*/
User Function CBIVPRO(cCodProf,cSigla,cCrm,cUf,nIdx,cES,aDados,lInc,cCbos)
	LOCAL cChave  := ""
	LOCAL nOrdBAU := BAU->(IndexOrd())
	LOCAL nRecBAU := BAU->(Recno())
	DEFAULT cES   := ""
	DEFAULT lInc  := .F.
	DEFAULT cCbos := ''
	cUf    := upper(padr(cUf,TamSX3("BB0_ESTADO")[1]))
	cCrm   := upper(padr(cCrm,TamSX3("BB0_NUMCR")[1]))
	cSigla := upper(padr(cSigla,TamSX3("BB0_CODSIG")[1]))


// Definindo a Chave
	If nIdx == 4
		cChave := cUf+cCrm+cSigla
	Else
		cChave := cCodProf
		If Empty(cChave) .and. !Empty(cUf) .and. !Empty(cCrm) .and. !Empty(cSigla)
			cChave := cUf+cCrm+cSigla
			nIdx   := 4
		Endif
	EndIf

// Verifica o profissional
	If !Empty(cChave)
		BB0->( DbSetOrder( nIdx ) ) //BB0_FILIAL + BB0_CODIGO ou BB0_CGC ou BB0_ESTADO + BB0_NUMCR + BB0_CODSIG + BB0_CODOPE
		If BB0->( MsSeek( xFilial("BB0")+cChave ) )
			If cES == "S" .And. aDados <> NIL     //Solicitante
				AaDd( aDados, { "OPESOL" , BB0->BB0_CODOPE } )
				AaDd( aDados, { "CDPFSO" , BB0->BB0_CODIGO } )
			ElseIf cES == "E" .And. aDados <> NIL //Executante
				cCdPfEx1 := BB0->BB0_CODIGO
				xCdPfEx := U_CBXPROFS(BB0->BB0_CODIGO,NIL,NIL,NIL)
				AaDd( aDados, { "CDOPEX" , BB0->BB0_CODOPE } )
				AaDd( aDados, { "CDPFEX" , Iif(!Empty(xCdPfEx) .And. ValType(xCdPfEx) != "L",xCdPfEx,cCdPfEx1) } )
			EndIf
		EndIf
	EndIf
	BAU->(DbSetOrder(nOrdBAU))
	BAU->(DbGoTo(nRecBAU))

Return

/*/{Protheus.doc} U_CBXPROF
Verifica o profissional/RDA
#tissver 2.x,3.x

@type Function
@author Alexander Santos
@since 25/06/2008
@version 1.0
/*/
User Function CBXPROF(cTipo,cCodRP,cNum,cNumImp,cOrigem,nIdx,cData,cHora,cES,aDados,aMatC)
	DEFAULT cES    := ""
	DEFAULT aDados := {}
	DEFAULT aMatC  := {}

	If !Empty(cCodRP)

		If !BAU->( Found() )

			If GetNewPar("MV_PCRDXML",'1') == '1'//se este parametro estiver ligado se ele nao acha a rda ele sempre pega a rda do cabecalho
				If Len(aMatC) <> 0
					cRet := AllTrim( u_CPEGCONR("CPF,CNPJ,CODIGOPRESTADORNAOPERADORA","CABECALHO\ORIGEM\CODIGOPRESTADORNAOPERADORA",aMatC) )
					cRet := padr(cRet,TamSX3("BAU_CPFCGC")[1])
					nIdx 	:= 4
					If Empty(cRet)
						cRet := AllTrim( u_CPEGCONR("cnpjPagador","CABECALHO\ORIGEM",aMatC) )
						cRet := padr(cRet,TamSX3("BAU_CPFCGC")[1])
						If Empty(cRet)
							cRet     := u_CPEGCONR("CODIGOPRESTADORNAOPERADORA","CABECALHO\ORIGEM\CODIGOPRESTADORNAOPERADORA",aMatC)
							cRet     := padr(cRet,TamSX3("BAU_CPFCGC")[1])
							nIdx 	 := 1
						EndIf
					EndIf

					BAU->( DbSetOrder( nIdx ) ) //BAU_FILIAL + BAU_CPFCGC ou  BAU_CODIGO ou BAU_CODBB0
					BAU->( MsSeek( xFilial("BAU")+cRet ) )
				Endif
			Endif

			If ExistBlock("PLSXMLPROF") .and. !BAU->(Found())

				If cTipo == "R"
					If cES == "S"
						cTipo := "S"
					ElseIf cES == "E"
						cTipo := "CE"
					EndIf
				EndIf

				cCodRP := ExecBlock( "PLSXMLPROF",.F.,.F.,{cTipo,cCodRP,cNum,cNumImp,cOrigem,nIdx,u_CBAJUDAT(cData),cHora,aMatC} )

				u_CBIVRDA(cCodRP,1,cES,aDados)

				If !BAU->( Found() )
					u_CBIVRDA(GetNewPar("MV_PLSRDAG",'999999'),1,cES,aDados) //assumo RDA generica
				Endif

			Endif
		Endif
	EndIf

Return

/*/{Protheus.doc} U_CBXPROFS
Verifica se BB0_CODIGO já existe em uma outra RDA (BAU_CODIGO)
@type function
@author TOTVS
@since 10.12.14
@version 1.0
/*/
User Function CBXPROFS(cCodBAU,aCrmXml,cCbosXml,aDados)

	LOCAL   lRet			:= .F.
	LOCAL	 lCrm			:= .F.
	LOCAL   cCrmBAU			:= ""
	LOCAL	 cCodBB0		:= ""
	LOCAL	 cCdBauBb0		:= ""
	LOCAL	 cCodSigla		:= ""
	LOCAL	 cCodEstado		:= ""
	LOCAL	 cCpfCgc		:= ""
	LOCAL	 cNomeBB0		:= ""
	LOCAL 	 nOrdBAU 		:= BAU->(IndexOrd())
	LOCAL	 nRecBAU 		:= BAU->(Recno())
	LOCAL	 nIndex			:= 0
	LOCAL	 nI				:= 1
	LOCAL	 cCrmBB0		:= ""
	LOCAL 	 lAchou			:= .f.
	DEFAULT aCrmXml			:= {}
	DEFAULT cCodBAU			:= ""
	DEFAULT cCbosXml		:= ""
	DEFAULT aDados			:= {}

	If !Empty(cCodBAU)
		BAU->( DbSetOrder(1) ) //BAU_FILIAL + BAU_CODIGO
		lAchou := BAU->( MsSeek( xFilial("BAU")+cCodBAU ) )
	//se naoa chou vou buscar tambem pelo CPF/cnpj
		If !lAchou
			BAU->( DbSetOrder(4) ) //BAU_FILIAL + BAU_CPFCGC
			lAchou := BAU->( MsSeek( xFilial("BAU")+cCodBAU ) )
		Endif

		If lAchou
			cCrmBAU 	:= BAU->BAU_CONREG
			cCdBauBb0	:= BAU->BAU_CODBB0
		//so faz sentido buscar por profissional se a rda for pessoa fisica
			If BAU->BAU_TIPPE == 'F'
				BB0->( DbSetOrder(1) ) //BB0_FILIAL + BB0_CODIGO
				If BB0->( MsSeek( xFilial("BB0")+cCodBAU ) )
					cCrmBB0	:= BB0->BB0_NUMCR
					cCodBB0	:= BB0->BB0_CODIGO
					cCodSigla	:= BB0->BB0_CODSIG
					cCodEstado	:= BB0->BB0_ESTADO
					cCpfCGC	:= BB0->BB0_CGC
					cNomeBB0	:= BB0->BB0_NOME
					If (cCrmBB0 != cCrmBAU) .And. (cCodBB0 != cCdBauBb0)
						lRet := .T. // Pq eh um BB0 com o mesmo codigo de uma outra RDA
						cCodRP := cCodBAU
						cCrm	:= cCrmBAU
						cSigla := cCodSigla
						cCodUf	:= cCodEstado
					Else
						BAU->( DbSetOrder(1) ) //BAU_FILIAL + BAU_CODIGO
						If BAU->( MsSeek( xFilial("BAU")+cCodBAU ) )
							lRet := .T.
						EndIf
					EndIf
				Else
					If BB0->(MsSeek(xFilial("BB0")+cCdBauBb0))
						cCodEstado	:= BB0->BB0_ESTADO
						cCrmBB0	:= BB0->BB0_NUMCR
						cCodSigla	:= BB0->BB0_CODSIG

						If ! Empty (aCrmXml) .And. cCrmBAU == cCrmBB0 .And. Len(aCrmXml) > 1
							For nI := 1 To Len(aCrmXml)
								nIndex := aScan(aCrmXml,{|x| alltrim(x[3]) == Alltrim(cCrmBB0)})
								lRet := .F.
								If (nIndex > 0)
									If cCrmBAU == cCrmBB0
										lRet := .T.
									EndIf
								EndIF
							Next
						Else
							lRet := .T.
						EndIf

					Else
						If ! Empty (aCrmXml)
							For nI := 1 To Len(aCrmXml)
								nIndex := aScan(aCrmXml,{|x| alltrim(x[3]) == Alltrim(cCrmBau)})
								lRet := .F.
								If (nIndex > 0)
									lRet := .T.
								EndIF
							Next
						Else
							lRet := .F.
						EndIf
					EndIf
				Endif
			Else
				lRet := .T.
			EndIf
		Else
			BAU->( DbSetOrder(5) ) //BB0_FILIAL + BAU_CODBB0
			If BAU->( MsSeek( xFilial("BAU")+cCodBAU ) )
				cCodBAU := BAU->BAU_CODIGO
				BB0->( DbSetOrder(1) ) //BB0_FILIAL + BB0_CODIGO
				If BB0->( MsSeek( xFilial("BB0")+cCodBAU ) )
					cCrmBB0	:= BB0->BB0_NUMCR
					cCodBB0	:= BB0->BB0_CODIGO
					cCodSigla	:= BB0->BB0_CODSIG
					cCodEstado	:= BB0->BB0_ESTADO
					cCpfCGC	:= BB0->BB0_CGC
					cNomeBB0	:= BB0->BB0_NOME
					If (cCrmBB0 != cCrmBAU) .And. (cCodBB0 != cCdBauBb0)
						lRet := .T.
						lCrm := .T.
						cCdPfEx := cCodBB0 // Tratamento para identificar o profissional de saúde caso não seja uma RDA
						cCrm	:= cCrmBB0
						cSigla := cCodSigla
						cCodUf	:= cCodEstado
					Else
						lRet := .T.
					EndIf
				Else
					lRet := .T.
				EndIf
			Else
				BB0->( DbSetOrder(1) ) //BB0_FILIAL + BB0_CODIGO
				If BB0->( MsSeek( xFilial("BB0")+cCodBAU ) )
					lRet := .T.
				Else
					lRet := .F.
				EndIf
			EndIf
		EndIf
	EndIf

	If !lRet
		cCodRP := cCodBAU
		cCrm	:= cCrmBAU
		cSigla := cCodSigla
		cCodUf	:= cCodEstado
	EndIf
	BAU->(DbGoTo(nRecBAU))
	BAU->(DbSetOrder(nOrdBAU))
Return (IIF(lCrm,cCdPfEx,lRet))

/*/{Protheus.doc} u_CBXSCU
Verifica o crm
@type function
@author TOTVS
@since 25.06.08
@version 1.0
/*/
User Function CBXSCU(cCodProf,cSigla,cCrm,cUf,cES,aDados,cObsoleto,lInc,cNome,cCbos,cData,aMatM)
	LOCAL aRetProf   := {}
	LOCAL lCriou	 := .F.
	LOCAL aRet	 	 := {.t.,{}}
	Local cTissVer := PGETTISVER()
	DEFAULT cCodProf := ""
	DEFAULT cObsoleto:= nil
	DEFAULT lInc	 := .T.
	DEFAULT cNome	 := ""
	DEFAULT cCbos	 := ""
	DEFAULT cData	 := ""
	DEFAULT aMatM	 := {}


	cCrm  	  := UPPER(padr(cCrm,TamSx3('BB0_NUMCR')[1]))   //atencao a alteracao que havia sido feita aqui causou efeito colateral na importacao xml.. nao voltar..
	cSigla	  := UPPER(padr(cSigla,TamSx3('BB0_CODSIG')[1]))
	cUf		  := UPPER(padr(cUf,TamSx3('BB0_ESTADO')[1]))
	cCodOpe   := PlsIntPad()

	If !Empty( AllTrim(cSigla)+AllTrim(cCrm)+AllTrim(cUf) ) .Or. !Empty(cCodProf)

		If GetNewPar("MV_PLINCSO",'1') == '1'
			BB0->( DbSetOrder(4) ) //BB0_FILIAL, BB0_ESTADO, BB0_NUMCR, BB0_CODSIG, BB0_CODOPE, R_E_C_N_O_, D_E_L_E_T_
			If !Empty(cUf) .and. !BB0->( MsSeek( xFilial("BB0")+cUf+cCrm+cSigla+cCodOpe ) )
				BB0->(RecLock("BB0",.T.))
				BB0->BB0_FILIAL	:= xFilial("BB0")
				BB0->BB0_ESTADO	:= Upper(cUf)
				BB0->BB0_UF		:= Upper(cUf)
				BB0->BB0_NUMCR	:= cCrm
				BB0->BB0_CODSIG	:= cSigla
				BB0->BB0_CODOPE	:= cCodOpe
				BB0->BB0_NOME	:= If(Empty(Upper(cNome)),"PROFISSIONAL GENERICO XML",Upper(cNome))
				BB0->BB0_VINC	:= '2'
				BB0->BB0_CODIGO	:= GetSx8Num("BB0","BB0_CODIGO")
				BB0->(MsUnlock())
				ConfirmSX8()
				lCriou := .T.
			EndIf

		//Apos criar o Profissional de Saude, alimenta a tabela BQ1 (Especialidades Profissionais de Saude) com a especialidade enviada no arquivo.
			If (BB0->(Found()) .or. lCriou) .and. PLSALIASEXI('BQ1') .and. !Empty(cCbos)
				lCria := .f.

				If cTissVer >= '3'
					BQ1->(DbSetORder(1))
					BTQ->(DbSetOrder(1))
					cEspec	:= AllTrim(PLSVARVINC('24','BAQ',cCBOS))
					lCria :=  !BQ1->(MsSeek(xFilial('BQ1')+BB0->BB0_CODIGO+cEspec)) .and. BTQ->(MsSeek(xFilial("BTQ")+"24"+cCBOS))
				Else
					BQ1->(DbSetORder(1))
					BAQ->(DbSetOrder(4))
					lCria :=  BAQ->( MsSeek( xFilial("BAQ")+cCodOpe+cCbos ) ) .AND. !BQ1->(MsSeek(xFilial('BQ1')+BB0->BB0_CODIGO+BAQ->BAQ_CODESP))
					cEspec := BAQ->BAQ_CODESP
				Endif

				If lCria
					BQ1->(Reclock("BQ1",.T.))
					BQ1->BQ1_FILIAL := xFilial("BQ1")
					BQ1->BQ1_CODINT := cCodOpe
					BQ1->BQ1_CODIGO := BB0->BB0_CODIGO
					BQ1->BQ1_CODESP := cEspec
					BQ1->BQ1_DESCRI := BTQ->BTQ_DESTER
					BQ1->(MsUnlock())
				Endif

			Endif

			U_CBIVPRO("",cSigla,cCrm,cUf,4,cES,aDados)
		Else

			BB0->( DbSetOrder(4) )
			BAU->( DbSetOrder(5) )
			BBF->( DbSetOrder(1) )
			BAQ->( DbSetOrder(4) )

			If !Empty(AllTrim(cCrm)) .And. BB0->(Eof())
				cSigla := PADR(cSigla,tamsx3("BB0_CODSIG")[1])
				cCrm   := PADR(cCrm,tamsx3("BB0_NUMCR")[1])
				cUF    := PADR(cUF,tamsx3("BB0_ESTADO")[1])
				BB0->(dbSeek(xFilial("BB0")+cUf+cCrm+cSigla))
			EndIf

			If !Empty(cCodProf) .And. BB0->(Eof())
				BB0->(dbSetOrder(1))//BB0_CODIGO
				If !BB0->(dbSeek(xFilial("BB0")+cCodProf))
					BB0->(dbSetOrder(3))//BB0_FILIAL+BB0_CGC
					BB0->(dbSeek(xFilial("BB0")+cCodProf))
				EndIf
			EndIf

		//se existe a nova tabela, se eu achei o profissional, esse profissional eh uma RDA esta especialidade estah no BBF ou ele nao eh uma RDA,
		//o prestador mandou no arquivo uma especialdade, esta especialidade esta no BAQ (Cadastro da RDA)
		//eu alimento a nova tabela BQ1

			If 	PLSALIASEXI('BQ1') .and. !Empty(cUf) .and. BB0->( MsSeek( xFilial("BB0")+cUf+cCrm+cSigla+cCodOpe ) ) .and. ;
					!Empty(cCbos) .and. BAQ->( MsSeek( xFilial("BAQ")+cCodOpe+cCbos ) ) .and.;
					!BQ1->(MsSeek(xFilial('BQ1')+BB0->BB0_CODIGO+BAQ->BAQ_CODESP)) .and.;
					((BAU->(MsSeek(xFilial("BB0")+BB0->BB0_CODIGO )))) .Or. ;
					!BAU->( MsSeek( xFilial("BB0")+BB0->BB0_CODIGO ) )


				If ExistBlock("PLINCBQ1")
					ExecBlock( "PLINCBQ1",.F.,.F.,{cCodProf,cSigla,cCrm,cUf,cES,aDados,cObsoleto,lInc,cNome,cCbos} )
				Else
					BQ1->(dbSetOrder(1))
					If !BQ1->(msSeek(xFilial("BQ1")+BB0->BB0_CODIGO+BAQ->BAQ_CODESP)) .And. !BAQ->(Eof())
						BQ1->(Reclock("BQ1",.T.))
						BQ1->BQ1_FILIAL := xFilial("BQ1")
						BQ1->BQ1_CODINT := cCodOpe
						BQ1->BQ1_CODIGO := BB0->BB0_CODIGO
						BQ1->BQ1_CODESP := BAQ->BAQ_CODESP
						BQ1->BQ1_DESCRI := BAQ->BAQ_DESCRI
						BQ1->(MsUnlock())
					EndIf
				Endif
			Endif

		Endif

		If ExistBlock("PLSXMLSCU") .And. (!BB0->( Found() ) .and. !lCriou)

			aRetProf := ExecBlock( "PLSXMLSCU",.F.,.F.,{cSigla,cCrm,cUf,cCodProf,cEs,cNome,cCbos} )

			cSigla 	:= aRetProf[1]
			cCrm 	:= aRetProf[2]
			cUf 	:= aRetProf[3]

			If Len(aRetProf)>3
				cCbos 	:= aRetProf[4]
			Endif

			U_CBIVPRO("",cSigla,cCrm,cUf,4,cES,aDados)

		EndIf
	EndIf

Return aRet

/*/{Protheus.doc} u_CBXPAD
Verifica o codpad e procedimento
@type function
@author TOTVS
@since 25.06.08
@version 1.0
/*/
User Function CBXPAD(cCodPad,cCodPro,cDescric,cTpProc,cTipGui,cVersao,dDatRea)
	LOCAL aMatPad := {}
	DEFAULT cTpProc := ""
	DEFAULT cTipGui := '08'
	DEFAULT cVersao := GetNewPar("MV_TISSVER","2.02.03")
	DEFAULT dDatRea := cTod("")

	IF Empty(cTpProc)
		BR8->(DbSetOrder(1))
		If BR8->( MsSeek(xFilial("BR8")+cCodPad+cCodPro) )
			cTpProc := BR8->BR8_TPPROC
		Endif
	Endif

	If ExistBlock("PLSXMLPAD")
		aMatPad := ExecBlock( "PLSXMLPAD",.F.,.F.,{cCodPad,cCodPro,cDescric,cTpProc,cTipGui,cVersao,dDatRea} )
		If ValType(aMatPad) == "A"
			cCodPad  := aMatPad[1]
			cCodPro  := padr(aMatPad[2],tamsx3("BR8_CODPSA")[1])
			cDescric := If(Len(aMatPad)>=3,aMatPad[3],cDescric)
		Else
			cCodPad := aMatPad
		EndIf
	EndIf

Return

/*/{Protheus.doc} u_CABVE
Verifica elegibilidade
@type function
@author TOTVS
@since 25.06.08
@version 1.0
/*/
User Function CABVE(cGuia,cNomeArq,cDatHor,aMatC,aMatM,lHasAr,lHasCo,cCodPeg)
	LOCAL nIdx	   	:= 0
	LOCAL cTpCab 	:= ""
	LOCAL cCCCab 	:= ""
	LOCAL cCodRda 	:= ""
	LOCAL cNomRda 	:= ""
	LOCAL cCodRP	:= ""
	LOCAL cTpLograd	:= ""
	LOCAL cLograd 	:= ""
	LOCAL cNumero 	:= ""
	LOCAL cCodUf   	:= ""
	LOCAL cCep 		:= ""
	LOCAL cMatric 	:= ""
	LOCAL cNomeUsu	:= ""
	LOCAL cNomePla	:= ""
	LOCAL cValCar	:= ""
	LOCAL cNumeroCns:= ""
	LOCAL cIndBenf	:= ""
	LOCAL cRegAns	:= ""
	LOCAL cNumeSeq  := ""
	LOCAL cHora 	:= ""
	LOCAL dData 	:= SToD("")
	LOCAL aRet		:= {}
	LOCAL aRetAux	:= {}
	LOCAL nIndUt	:=	0
	LOCAL nInd2		:= 0
	DEFAULT cCodPeg := ""




// Dados da Solicitacao
	cNumeSeq := AllTrim(u_CPEGCONR("SEQUENCIALTRANSACAO","\CABECALHO\IDENTIFICACAOTRANSACAO",aMatC,nil,nil,nil,nil,cCodPeg))
	dData 	 := u_CBAJUDAT(u_CPEGCONR("DATAREGISTROTRANSACAO","\CABECALHO\IDENTIFICACAOTRANSACAO",aMatC,nil,nil,.F.,nil,cCodPeg))
	cHora 	 := SubStr(u_CPEGCONR("HORAREGISTROTRANSACAO","\CABECALHO\IDENTIFICACAOTRANSACAO",aMatC,nil,nil,nil,nil,cCodPeg),1,8)

// Dados da Operadora
	cRegAns  := u_CPEGCONR("REGISTROANS","CABECALHO\DESTINO",aMatC,nil,nil,nil,nil,cCodPeg)
	If !Empty(cRegAns)
		BA0->( DbSetOrder(5) ) //BA0_FILIAL+BA0_SUSEP
		If !BA0->( MsSeek( xFilial("BA0")+cRegAns ) )
			u_CABLOGX("Operadora n�o encontrada  -> ( "+cRegAns+" ) informa��o no  \CABECALHO\DESTINO ",.F.) //"Operadora não encontrada  -> ( "###" ) informação no  \CABECALHO\DESTINO "
		EndIf
	EndIf

// Local de Atendimento
	SIX->( DbSetOrder(1) )
	If SIX->( MsSeek("BB85") )
		cTpLograd	:= u_CPEGCONR("TIPOLOGRADOURO",cGuia+"\DADOSPRESTADOR\ENDERECOCONTRATADO",aMatM,,.T.,.F.,nil,cCodPeg)
		cTpLograd   += Space( TamSX3("BB8_TIPLOG")[1]-Len( AllTrim(cTpLograd) ) )

		cLograd 	:= u_CPEGCONR("LOGRADOURO",cGuia+"\DADOSPRESTADOR\ENDERECOCONTRATADO",aMatM,,.T.,.F.,nil,cCodPeg)
		cNumero 	:= u_CPEGCONR("NUMERO",cGuia+"\DADOSPRESTADOR\ENDERECOCONTRATADO",aMatM,,.T.,.F.,nil,cCodPeg)
		cNumero   	+= Space( TamSX3("BB8_NR_END")[1]-Len( AllTrim(cNumero) ) )

		cCodUf 		:= u_CPEGCONR("CODIGOUF",cGuia+"\DADOSPRESTADOR\ENDERECOCONTRATADO",aMatM,,.T.,.F.,nil,cCodPeg)
		cCodUf   	+= Space( TamSX3("BB8_EST")[1]-Len( AllTrim(cCodUf) ) )

		cCep 		:= strtran(strtran(u_CPEGCONR("CEP",cGuia+"\DADOSPRESTADOR\ENDERECOCONTRATADO",aMatM,nil,.T.,.F.,nil,cCodPeg),'-',''),'.','')
		cCep   		+= Space( TamSX3("BB8_CEP")[1]-Len( AllTrim(cCep) ) )
//	BB8->( DbSetOrder(4) )
		If nInd2 == 0
			nIndUt := PLSBUIND("BB8","BB8_FILIAL + BB8_TIPLOG + BB8_CEP + BB8_NR_END + BB8_EST + BB8_CODIGO + BB8_CODINT") /// Busca da Ordem do indice pela descrição
			nInd2  := nIndUt
		Endif
		BB8->( DbSetOrder(nInd2) )//BB8_FILIAL + BB8_TIPLOG + BB8_CEP + BB8_NR_END + BB8_EST + BB8_CODIGO + BB8_CODINT                                           //sempre procuro um local na rda que eu vou gerar a guia
		If BB8->( MsSeek( xFilial("BB8")+cTpLograd+cCep+cNumero+cCodUf ) )
			while  !BB8->(Eof()) .and. BB8->(BB8_FILIAL+BB8_TIPLOG+BB8_CEP+BB8_NR_END+BB8_EST) == ;
					xFilial("BB8")+cTpLograd+cCep+cNumero+cCodUf
				If Empty(BB8->BB8_DATBLO)
					exit
				Endif
				BB8->(DbSkip())
			enddo
		Endif
	EndIf

// RDA Contratada
	cCodRP := AllTrim( u_CPEGCONR("CPF,CNPJ,CODIGOPRESTADORNAOPERADORA","\DADOSPRESTADOR\IDENTIFICACAO",aMatM,nil,.T.,nil,nil,cCodPeg) )
	cCodRP := cCodRP+Space( TamSX3("BAU_CPFCGC")[1]-Len(cCodRP) )
	nIdx 	:= 4
	If Empty(cCodRP)
		cCodRP := u_CPEGCONR("CODIGOPRESTADORNAOPERADORA","\DADOSPRESTADOR\IDENTIFICACAO",aMatM,nil,.T.,nil,nil,cCodPeg)
		nIdx 	:= 1
	EndIf

// RDA
	u_CBIVRDA(cCodRP,nIdx,,NIL)

// Ponto de entrada
	U_CBXPROF("R",cCodRP,"2","","",nIdx,DToS(dData),cHora,,NIL,aMatC)
	If BAU->( Found() )
		cCodRda := BAU->BAU_CODIGO
		cNomRda := AllTrim(BAU->BAU_NOME)
		cTpCab  := AllTrim(BAU->BAU_TIPPE)
		cCCCab  := AllTrim(BAU->BAU_CPFCGC)
	EndIf

// Pegando dados do beneficiario
	cMatric 	:= u_CPEGCONR("NUMEROCARTEIRA",cGuia+"\DADOSBENEFICIARIO",aMatM,nil,nil,nil,nil,cCodPeg)
	cNomeUsu	:= u_CPEGCONR("NOMEBENEFICIARIO",cGuia+"\DADOSBENEFICIARIO",aMatM,nil,nil,nil,nil,cCodPeg)
	cNomePla	:= u_CPEGCONR("NOMEPLANO",cGuia+"\DADOSBENEFICIARIO",aMatM,nil,nil,nil,nil,cCodPeg)
	cValCar		:= u_CPEGCONR("VALIDADECARTEIRA",cGuia+"\DADOSBENEFICIARIO",aMatM,nil,nil,nil,nil,cCodPeg)
	cNumeroCns	:= u_CPEGCONR("NUMEROCNS",cGuia+"\DADOSBENEFICIARIO",aMatM,nil,nil,nil,nil,cCodPeg)
	cIndBenf	:= u_CPEGCONR("IDENTIFICADORBENEFICIARIO",cGuia+"\DADOSBENEFICIARIO",aMatM,nil,nil,nil,nil,cCodPeg)

// Dados do Retorno Aux
	AaDd(aRetAux,cTpCab)	//1
	AaDd(aRetAux,cCCCab)	//2
	AaDd(aRetAux,cCodRda)	//3
	AaDd(aRetAux,cNomRda)	//4
	AaDd(aRetAux,cTpCab)	//5
	AaDd(aRetAux,cCCCab)	//6
	AaDd(aRetAux,cMatric)	//7
	AaDd(aRetAux,cNomeUsu)	//8
	AaDd(aRetAux,cNumeSeq)	//9
	AaDd(aRetAux,"")		//10
	AaDd(aRetAux,.F.)		//11
	AaDd(aRetAux,.F.)		//12
	AaDd(aRetAux,cNumeSeq)	//13
	AaDd(aRetAux,dData)		//14
	AaDd(aRetAux,cCodRda)	//15
	AaDd(aRetAux,"")                           	//16 CNES
	AaDd(aRetAux,0)                           	//17 Valor Total da Guia
	AaDd(aRetAux,"")                           	//18 RN

// processa a guia
	If lOkXml
		aRet := PLSA090USR(cMatric,dData,cHora,"BE1",.F.,.T.,nil,nil,nil,nil,"","",.T.,cNomeUsu,CtoD(""),,.T.)
		aRet := { aRet[1],"","",aRet[2],{},{},0,"","",{} }
	EndIf

Return( { aRetAux,aRet } )

/*/{Protheus.doc} u_CABVEB
Verifica elegibilidade
@type function
@author TOTVS
@since 25.06.08
@version 1.0
/*/
uSER Function CABVEB(aDados)
	Local dData 		:= u_CBAJUDAT(u_CVLRTAGXML(aDados, "\CABECALHO\IDENTIFICACAOTRANSACAO\DATAREGISTROTRANSACAO"))
	Local cHora 		:= SubStr(u_CVLRTAGXML(aDados, "\CABECALHO\IDENTIFICACAOTRANSACAO\HORAREGISTROTRANSACAO"),1,8)
	Local cMatric 		:= u_CVLRTAGXML(aDados, "\VERIFICAELEGIBILIDADE\NUMEROCARTEIRA")
	Local cNomeUsu 	:= u_CVLRTAGXML(aDados, "\VERIFICAELEGIBILIDADE\NOMEBENEFICIARIO")
	Local cRegAns		:= u_CVLRTAGXML(aDados, "\CABECALHO\DESTINO\REGISTROANS")

// Dados da Operadora
	If !Empty(cRegAns)
		BA0->( DbSetOrder(5) ) //BA0_FILIAL+BA0_SUSEP
		If !BA0->( MsSeek( xFilial("BA0")+cRegAns ) )
			u_CABLOGX("Operadora n�o encontrada  -> ( "+cRegAns+" ) informa��o no  \CABECALHO\DESTINO ",.F.,,,"5006") //"Operadora não encontrada  -> ( "###" ) informação no  \CABECALHO\DESTINO "
		EndIf
	EndIf

	aRet := PLSA090USR(cMatric,dData,cHora,"BE1",.F.,.T.,nil,nil,nil,nil,"","",.T.,cNomeUsu,CtoD(""),,.T.)
	aRet := { aRet[1],"","",aRet[2],{},{},0,"","",{} }

	If ExistBlock("PLSA973VAL")
		aRet := ExecBlock( " PLSA973VAL ",.F.,.F.,{aDados,aRet,dData,cHora})
		aRet := { aRet[1],"","",aRet[2],{},{},0,"","",{} }
	EndIf

Return( { aRet } )

/*/{Protheus.doc} u_cabCG
Cancela Guia
@type function
@author TOTVS
@since 25.06.08
@version 1.0
/*/
User Function cabCG(cGuia,cNomeArq,cDatHor,aMatC,aMatM,lHasAr,lHasCo,cCodPeg)
	LOCAL nIdx	   	:= 0
	LOCAL cTpCab 	:= ""
	LOCAL cCCCab 	:= ""
	LOCAL cCodRda 	:= ""
	LOCAL cNomRda 	:= ""
	LOCAL cCodRP	:= ""
	LOCAL cTpLograd	:= ""
	LOCAL cLograd 	:= ""
	LOCAL cNumero 	:= ""
	LOCAL cCodIbgeM	:= ""
	LOCAL cCodUf   	:= ""
	LOCAL cCep 		:= ""
	LOCAL cMatric 	:= ""
	LOCAL cNomeUsu	:= ""
	LOCAL cRegAns	:= ""
	LOCAL cNumeSeq  := ""
	LOCAL cOpeMov	:= ""
	LOCAL cNumAut 	:= ""
	LOCAL cNumAutOp	:= ""
	LOCAL cMsg		:= ""
	LOCAL cRet		:= ""
	LOCAL cHora 	:= ""
	LOCAL cTipoGuia := ""
	LOCAL dData 	:= SToD("")
	LOCAL dDatPro 	:= Date()
	LOCAL aRet		:= {}
	LOCAL aRetAux	:= {}
	LOCAL nIndUt	:=	0
	LOCAL nInd3		:= 0
	DEFAULT cCodPeg := ""




// Dados da Solicitacao
	cNumeSeq := AllTrim(u_CPEGCONR("SEQUENCIALTRANSACAO","\CABECALHO\IDENTIFICACAOTRANSACAO",aMatC,nil,nil,nil,nil,cCodPeg))
	dData 	 := u_CBAJUDAT(u_CPEGCONR("DATAREGISTROTRANSACAO","\CABECALHO\IDENTIFICACAOTRANSACAO",aMatC,nil,nil,.F.,nil,cCodPeg))
	cHora 	 := SubStr(u_CPEGCONR("HORAREGISTROTRANSACAO","\CABECALHO\IDENTIFICACAOTRANSACAO",aMatC,nil,nil,nil,nil,cCodPeg),1,8)

// Codigo da Operadora
	cRegAns  := u_CPEGCONR("REGISTROANS","CABECALHO\DESTINO",aMatC)
	If !Empty(cRegAns)
		BA0->( DbSetOrder(5) ) //BA0_FILIAL+BA0_SUSEP
		If BA0->( MsSeek( xFilial("BA0")+cRegAns ) )
			cOpeMov := BA0->(BA0_CODIDE+BA0_CODINT)
		Else
			u_CABLOGX("Operadora n�o encontrada  -> ( "+cRegAns+" ) informa��o no  \CABECALHO\DESTINO ",.F.) //"Operadora não encontrada  -> ( "###" ) informação no  \CABECALHO\DESTINO "
		EndIf
	EndIf

// Local de Atendimento
	SIX->( DbSetOrder(1) )
	If SIX->( MsSeek("BB84") )
		cTpLograd	:= u_CPEGCONR("TIPOLOGRADOURO",cGuia+"\DADOSPRESTADOR\ENDERECOCONTRATADO",aMatM,nil,.T.,.F.,nil,cCodPeg)
		cTpLograd   += Space( TamSX3("BB8_TIPLOG")[1]-Len( AllTrim(cTpLograd) ) )

		cLograd 	:= u_CPEGCONR("LOGRADOURO",cGuia+"\DADOSPRESTADOR\ENDERECOCONTRATADO",aMatM,nil,.T.,.F.,nil,cCodPeg)
		cNumero 	:= u_CPEGCONR("NUMERO",cGuia+"\DADOSPRESTADOR\ENDERECOCONTRATADO",aMatM,nil,.T.,.F.,nil,cCodPeg)
		cNumero   	+= Space( TamSX3("BB8_NR_END")[1]-Len( AllTrim(cNumero) ) )

		cCodIbgeM	:= u_CPEGCONR("CODIGOIBGEMUNICIPIO",cGuia+"\DADOSPRESTADOR\ENDERECOCONTRATADO",aMatM,nil,.T.,.F.,nil,cCodPeg)

		cCodUf 		:= u_CPEGCONR("CODIGOUF",cGuia+"\DADOSPRESTADOR\ENDERECOCONTRATADO",aMatM,nil,.T.,.F.,nil,cCodPeg)
		cCodUf   	+= Space( TamSX3("BB8_EST")[1]-Len( AllTrim(cCodUf) ) )

		cCep 		:= strtran(strtran(u_CPEGCONR("CEP",cGuia+"\DADOSPRESTADOR\ENDERECOCONTRATADO",aMatM,nil,.T.,.F.,nil,cCodPeg),'-',''),'.','')
		cCep   		+= Space( TamSX3("BB8_CEP")[1]-Len( AllTrim(cCep) ) )

	// Procura o Local de Atendimento
//	BB8->( DbSetOrder(4) ) //BB8_FILIAL + BB8_TIPLOG + BB8_CEP + BB8_NR_END + BB8_EST
		If nInd3 == 0
			nIndUt := PLSBUIND("BB8","BB8_FILIAL + BB8_TIPLOG + BB8_CEP + BB8_NR_END + BB8_EST + BB8_CODIGO + BB8_CODINT") /// Busca da Ordem do indice pela descrição
			nInd3  := nIndUt
		Endif
		BB8->( DbSetOrder(nInd3) )//BB8_FILIAL + BB8_TIPLOG + BB8_CEP + BB8_NR_END + BB8_EST + BB8_CODIGO + BB8_CODINT                                          //sempre procuro um local na rda que eu vou gerar a guia
		If BB8->( MsSeek( xFilial("BB8")+cTpLograd+cCep+cNumero+cCodUf ) )
			while  !BB8->(Eof()) .and. BB8->(BB8_FILIAL+BB8_TIPLOG+BB8_CEP+BB8_NR_END+BB8_EST) == ;
					xFilial("BB8")+cTpLograd+cCep+cNumero+cCodUf
				If Empty(BB8->BB8_DATBLO)
					AaDd( aDados, {"CODLOC" , BB8->BB8_CODLOC } )
					exit
				Endif
				BB8->(DbSkip())
			enddo
		ElseIf !Empty(AllTrim(cTpLograd+cCep+cNumero+cCodUf))
			u_CABLOGX("Local de Atendimento n�o encontrado com base no Endere�o do Prestador -> ( "+cTpLograd+"-"+cCep+"-"+cNumero+"-"+cCodUf+" ) ")//"Local de Atendimento não encontrado com base no Endereço do Prestador -> ( "###" ) "
		EndIf
	EndIf

// RDA Contratada
	cCodRP := AllTrim( u_CPEGCONR("CPF,CNPJ,CODIGOPRESTADORNAOPERADORA","\DADOSPRESTADOR\IDENTIFICACAO",aMatM,nil,.T.,nil,nil,cCodPeg) )
	cCodRP := cCodRP+Space( TamSX3("BAU_CPFCGC")[1]-Len(cCodRP) )
	nIdx 	:= 4
	If Empty(cCodRP)
		cCodRP := u_CPEGCONR("CODIGOPRESTADORNAOPERADORA","\DADOSPRESTADOR\IDENTIFICACAO",aMatM,nil,.T.,nil,nil,cCodPeg)
		nIdx 	:= 1
	EndIf

// RDA
	u_CBIVRDA(cCodRP,nIdx,,NIL)

// Ponto de entrada
	U_CBXPROF("R",cCodRP,"2","","",nIdx,DToS(dData),cHora,,NIL,aMatC)
	If BAU->( Found() )
		cCodRda := BAU->BAU_CODIGO
		cNomRda := AllTrim(BAU->BAU_NOME)
		cTpCab  := AllTrim(BAU->BAU_TIPPE)
		cCCCab  := AllTrim(BAU->BAU_CPFCGC)
	EndIf

// Pegando dados da Guia
	cTipoGuia	:= u_CPEGCONR("TIPOGUIA",cGuia,aMatM,nil,nil,nil,nil,cCodPeg)
	cTipoGuia   := Iif( cTipoGuia=="1","Solicitação",Iif( cTipoGuia=="2","Faturamento",Iif( cTipoGuia=="3","Re-apresentação","" ) ) )
	cNumAutOp	:= u_CPEGCONR("NUMEROGUIAOPERADORA",cGuia,aMatM,nil,nil,nil,nil,cCodPeg)
	cNumAut		:= u_CPEGCONR("NUMEROGUIAPRESTADOR",cGuia,aMatM,nil,nil,nil,nil,cCodPeg)

	If !Empty(cNumAutOp)
		cNumAut := cNumAutOp
	EndIf

// Procura pelo numero do impresso o numero da liberacao
	If ExistBlock("PLSTMLLIB")
		cNumAut := ExecBlock( "PLSTMLLIB",.F.,.F.,{ cNumAut,cOpeMov,cCodRda,"","","" } )
	EndIf

// Posiciona na Guia
	If !Empty(cNumAut)
		BEA->( DbSetOrder(1) ) //BEA_FILIAL + BEA_OPEMOV + BEA_ANOAUT + BEA_MESAUT + BEA_NUMAUT + DTOS(BEA_DATPRO) + BEA_HORPRO
		If !BEA->( MsSeek( xFilial("BEA")+cNumAut ) )
			cRet 	:= "3" 		//Guia inexistente
			cMsg 	:= "Guia inexistente" 	//"Guia inexistente"
		Else
			dDatPro := BEA->BEA_DATPRO
		EndIf
	Else
		u_CABLOGX("Guia n�o encontrada -> ( "+cNumAut+" ) ",.F.) //"Guia não encontrada -> ( "###" ) "
	EndIf

// Dados do Retorno Aux
	AaDd(aRetAux,cTpCab)	//1
	AaDd(aRetAux,cCCCab)	//2
	AaDd(aRetAux,cCodRda)	//3
	AaDd(aRetAux,cNomRda)	//4
	AaDd(aRetAux,cTpCab)	//5
	AaDd(aRetAux,cCCCab)	//6
	AaDd(aRetAux,cMatric)	//7
	AaDd(aRetAux,cNomeUsu)	//8
	AaDd(aRetAux,cNumeSeq)	//9
	AaDd(aRetAux,cNumAut)	//10
	AaDd(aRetAux,.F.)		//11
	AaDd(aRetAux,.F.)		//12
	AaDd(aRetAux,cNumeSeq)	//13
	AaDd(aRetAux,dDatPro)	//14
	AaDd(aRetAux,cCodRda)	//15
	AaDd(aRetAux,"")                           	//16 CNES
	AaDd(aRetAux,0)                           	//17 Valor Total da Guia
	AaDd(aRetAux,"")                           	//18 RN





// processa a guia
	If Empty(cMsg)
		If lOkXml
			cMsg := PLSA090CAN(.T.)

		// Verifica o processamento do cancelamento
			If Empty(cMsg)
				cRet := "1" //Cancelado com sucesso
				cMsg := "Cancelado com sucesso" + " Guia de [ "+cTipoGuia+" ]" //"Cancelado com sucesso"
			Else
				cRet := "2" //Não cancelado
				cMsg := "N�o cancelado - [ "+cMsg+" ]" + " Guia de [ "+cTipoGuia+" ]"  //"Não cancelado - [ "###" ]"
			EndIf
			AaDd( aRet,{cRet,cMsg,"","","","",""} )
			aRet := { Iif(cRet<>"1",.F.,.T.),cNumAut,"",aRet,{},{},0,"","",{} }
		EndIf
	Else
		AaDd( aRet,{cRet,cMsg,"","","","",""} )
		aRet := { Iif(cRet<>"1",.F.,.T.),cNumAut,"",aRet,{},{},0,"","",{} }
	EndIf

Return( { aRetAux,aRet } )

/*/{Protheus.doc} u_cabCGB
Cancela Guia
@type function
@author TOTVS
@since 29.10.13
@version 1.0
/*/
User Function cabCGB(aDados)
	LOCAL nI		:= 1
	LOCAL cCodRP	:= ""
	LOCAL nIdx		:= 4
	LOCAL cCodRda	:= ""
	LOCAL cOpeMov	:= ""
	LOCAL cNumAut,cNumAut2 	:= ""
	LOCAL cMsg		:= ""
	LOCAL cRet		:= ""
	LOCAL cCodTpGuia := ""
	LOCAL cTipoGuia := ""
	LOCAL aRet		:= {}
	LOCAL aRetAux	:= {}
	LOCAL nCountTag := PLCOUNTTAG({"\NUMEROGUIAPRESTADOR"}, aDados)
	LOCAL lAchouNAut := .F.


// RDA Contratada
	cCodRP := AllTrim( u_CVLRTAGXML(aDados, "\DADOSPRESTADOR\CPFCONTRATADO,\DADOSPRESTADOR\CNPJCONTRATADO"))
	cCodRP := cCodRP+Space( TamSX3("BAU_CPFCGC")[1]-Len(cCodRP) )
	nIdx 	:= 4
	If Empty(cCodRP)
		cCodRP := u_CVLRTAGXML(aDados, "\DADOSPRESTADOR\CODIGOPRESTADORNAOPERADORA")
		nIdx 	:= 1
	EndIf

	BAU->( DbSetOrder( nIdx ) ) //BAU_FILIAL + BAU_CPFCGC ou  BAU_CODIGO ou BAU_CODBB0
	If BAU->( MsSeek( xFilial("BAU")+cCodRP ) )
		cCodRda := BAU->BAU_CODIGO
	EndIf


// Codigo da Operadora
	cRegAns  := u_CVLRTAGXML(aDados, "\CABECALHO\DESTINO\REGISTROANS")
	If !Empty(cRegAns)
		BA0->( DbSetOrder(5) ) //BA0_FILIAL+BA0_SUSEP
		If BA0->( MsSeek( xFilial("BA0")+cRegAns ) )
			cOpeMov := BA0->(BA0_CODIDE+BA0_CODINT)
		Else
			u_CABLOGX("Operadora n�o encontrada  -> ( "+cRegAns+" ) informa��o no  \CABECALHO\DESTINO ",.F.,,,"5006") //"Operadora não encontrada  -> ( "###" ) informação no  \CABECALHO\DESTINO "
		EndIf
	EndIf

// Pegando dados da Guia
	cCodTpGuia	:= u_CVLRTAGXML(aDados, "\TIPOGUIA")
	cTipoGuia   := Iif( cCodTpGuia=="1","Solicitação",Iif( cCodTpGuia=="2","Faturamento","" ) )

	For nI := 1 To nCountTag
		cRet := ""
		cMsg := ""

		cNumAut := u_CVLRTAGXML(aDados, "NUMEROGUIAPRESTADOR", nI)
		cNumAut2 := u_CVLRTAGXML(aDados, "NUMEROGUIAOPERADORA", nI)
		If !Empty(cNumAut) .OR. !Empty(cNumAut2)
			BEA->( DbSetOrder(1) ) //BEA_FILIAL + BEA_OPEMOV + BEA_ANOAUT + BEA_MESAUT + BEA_NUMAUT + DTOS(BEA_DATPRO) + BEA_HORPRO
			If !BEA->( MsSeek( xFilial("BEA")+cNumAut ) )
				If BEA->( MsSeek( xFilial("BEA")+cNumAut2 ) )
					lAchouNAut := .T.
					cNumAut := cNumAut2
				EndIf
			Else
				lAchouNAut := .T.
			EndIf
		Else
			u_CABLOGX("Guia n�o encontrada -> ( "+cNumAut+" ) ",.F.,,,"2906") //"Guia não encontrada -> ( "###" ) "
		EndIf

	// Procura pelo numero do impresso o numero da liberacao
		If ExistBlock("PLSTMLLIB")
			cNumAut := ExecBlock( "PLSTMLLIB",.F.,.F.,{ cNumAut,cOpeMov,cCodRda,"","","" } )
		EndIf

	// Posiciona na Guia
		If !lAchouNAut
			cRet 	:= "3" 		//Guia inexistente
			cMsg 	:= "Guia inexistente" 	//"Guia inexistente"
		EndIf


	// processa a guia
		If Empty(cMsg)
			If lOkXml
				cMsg := PLSA090CAN(.T.)

			// Verifica o processamento do cancelamento
				If Empty(cMsg)
					cRet := "1" //Cancelado com sucesso
					cMsg := "Cancelado com sucesso" + " Guia de [ "+cTipoGuia+" ]" //"Cancelado com sucesso"
				Else
					cRet := "2" //Não cancelado
					cMsg := "N�o cancelado - [ "+cMsg+" ]" + " Guia de [ "+cTipoGuia+" ]"  //"Não cancelado - [ "###" ]"
				EndIf
				aRetAux := { {cRet,cMsg,"","","","",""} }
				aAdd(aRet, { Iif(cRet<>"1",.F.,.T.),cNumAut,cCodTpGuia,aRetAux,{},{},0,"","",{} } )
			EndIf
		Else
			aRetAux := { {cRet,cMsg,"","","","",""} }
			aAdd(aRet, { Iif(cRet<>"1",.F.,.T.),cNumAut,cCodTpGuia,aRetAux,{},{},0,"","",{} } )
		EndIf
	Next

Return( aRet )

/*/{Protheus.doc} u_CABSP
Situacao do Protocolo
@type function
@author TOTVS
@since 25.06.08
@version 1.0
/*/
User Function CABSP(cGuia,cNomeArq,cDatHor,aMatC,aMatM,lHasAr,lHasCo,cCodPeg)
	LOCAL nIdx	   	:= 0
	LOCAL cHora 	:= ""
	LOCAL cTpCab 	:= ""
	LOCAL cCCCab 	:= ""
	LOCAL cCodRda 	:= ""
	LOCAL cNomRda 	:= ""
	LOCAL cCodRP	:= ""
	LOCAL cRegAns	:= ""
	LOCAL cNumeSeq  := ""
	LOCAL dData 	:= SToD("")
	LOCAL dDataSol	:= SToD("")
	LOCAL aRet		:= {}
	LOCAL aRetAux	:= {}
	LOCAL aMatGui	:= {}
	DEFAULT cCodPeg := ""




// Dados da Solicitacao
	cNumeSeq := AllTrim(u_CPEGCONR("SEQUENCIALTRANSACAO","\CABECALHO\IDENTIFICACAOTRANSACAO",aMatC,nil,nil,nil,nil,cCodPeg))
	dData 	 := u_CBAJUDAT(u_CPEGCONR("DATAREGISTROTRANSACAO","\CABECALHO\IDENTIFICACAOTRANSACAO",aMatC,nil,nil,.F.,nil,cCodPeg))
	cHora 	 := SubStr(u_CPEGCONR("HORAREGISTROTRANSACAO","\CABECALHO\IDENTIFICACAOTRANSACAO",aMatC,nil,nil,nil,nil,cCodPeg),1,8)

// Codigo da Operadora
	cRegAns  := u_CPEGCONR("REGISTROANS","CABECALHO\DESTINO",aMatC,nil,nil,nil,nil,cCodPeg)
	If !Empty(cRegAns)
		BA0->( DbSetOrder(5) ) //BA0_FILIAL+BA0_SUSEP
		If BA0->( MsSeek( xFilial("BA0")+cRegAns ) )
			cOpeMov := BA0->(BA0_CODIDE+BA0_CODINT)
		Else
			u_CABLOGX("Operadora n�o encontrada  -> ( "+cRegAns+" ) informa��o no  \CABECALHO\DESTINO ",.F.) //"Operadora não encontrada  -> ( "###" ) informação no  \CABECALHO\DESTINO "
		EndIf
	EndIf

// RDA contratada
	cCodRP := AllTrim( u_CPEGCONR("CPF,CNPJ,CODIGOPRESTADORNAOPERADORA","\DADOSPRESTADOR\IDENTIFICACAO",aMatM,nil,.T.,nil,nil,cCodPeg) )
	cCodRP := cCodRP+Space( TamSX3("BAU_CPFCGC")[1]-Len(cCodRP) )
	nIdx 	:= 4
	If Empty(cCodRP)
		cCodRP := u_CPEGCONR("CODIGOPRESTADORNAOPERADORA","\DADOSPRESTADOR\IDENTIFICACAO",aMatM,nil,.T.,nil,nil,cCodPeg)
		nIdx 	:= 1
	EndIf

// RDA
	u_CBIVRDA(cCodRP,nIdx,,NIL)

// Ponto de entrada
	U_CBXPROF("R",cCodRP,"2","","",nIdx,DToS(dData),cHora,,NIL,aMatC)
	If BAU->( Found() )
		cCodRda := BAU->BAU_CODIGO
		cNomRda := AllTrim(BAU->BAU_NOME)
		cTpCab  := AllTrim(BAU->BAU_TIPPE)
		cCCCab  := AllTrim(BAU->BAU_CPFCGC)
	EndIf

// Dados da Solicitacao
	dDataSol := u_CBAJUDAT(u_CPEGCONR("DATASOLICITACAO","\SOLICITACAOSTATUSPROTOCOLO",aMatM,nil,nil,nil,nil,cCodPeg))

// Numeros dos Protocolos
	If lOkXml
		SIX->( DbSetOrder(1) )
		If SIX->( MsSeek("BEA16") )
			While !Empty( ( cNumPro := u_CPEGCONR("NUMEROPROTOCOLO","\SOLICITACAOSTATUSPROTOCOLO",aMatM,nil,.T.,nil,nil,cCodPeg) ) )

				BEA->( DbSetOrder(16) ) //BEA_FILIAL + BEA_OPERDA + BEA_CODRDA + BEA_LOTGUI
				If BEA->( MsSeek( xFilial("BEA")+cOpeMov+cCodRda+cNumPro ) )

					While !BEA->( Eof() ) .And. AllTrim(BEA->(BEA_CODRDA+BEA_LOTGUI)) == AllTrim(cCodRda+cNumPro)

						lConSadt := IiF( Empty( AllTrim(BEA->(BEA_ANOINT+BEA_MESINT+BEA_NUMINT)) ),.T.,.F. )
						aRet 	 := u_CBMNTGUI( BEA->(BEA_OPEMOV+BEA_ANOAUT+BEA_MESAUT+BEA_NUMAUT) , lConSadt)

						AaDd(aMatGui,{cNumPro,aRet})

						BEA->( DbSkip() )
					EndDo

				Else
					AaDd(aMatGui,{ cNumPro,{} })
					u_CABLOGX("Lote não encontrado -> ( "+cNumPro+" ) para este Prestador ( "+cCodRda+" ) ")
				EndIf

			EndDo
		Else
			u_CABLOGX("Não existe o indice 16 na tabela BEA",.F.)
		EndIf
	EndIf

// Dados do Retorno Aux
	AaDd(aRetAux,cTpCab)	//1
	AaDd(aRetAux,cCCCab)	//2
	AaDd(aRetAux,cCodRda)  	//3
	AaDd(aRetAux,cNomRda)  	//4
	AaDd(aRetAux,cTpCab)  	//5
	AaDd(aRetAux,cCCCab)   	//6
	AaDd(aRetAux,"")        //7  //Matric
	AaDd(aRetAux,"")        //8  //NomUsr
	AaDd(aRetAux,"")        //9  //NumLote
	AaDd(aRetAux,"")        //10 //NumGuia
	AaDd(aRetAux,.F.)       //11
	AaDd(aRetAux,.F.)       //12
	AaDd(aRetAux,cNumeSeq)  //13
	AaDd(aRetAux,dDataSol)  //14
	AaDd(aRetAux,cCodRda)   //15
	AaDd(aRetAux,"")                           	//16 CNES
	AaDd(aRetAux,0)                           	//17 Valor Total da Guia
	AaDd(aRetAux,"")                           	//18 RN





Return( { aRetAux,aMatGui } )

/*/{Protheus.doc} u_CABSPB
Situacao do Protocolo
@type function
@author TOTVS
@since 29.10.13
@version 1.0
/*/
User Function CABSPB(aDados)
	LOCAL nIdx	   	:= 0
	LOCAL cCodRda 	:= ""
	LOCAL cCodRP	:= ""
	LOCAL cRegAns	:= ""
	LOCAL aRet		:= {}
	LOCAL aMatGui	:= {}
	LOCAL aValores	:= {}
	LOCAL nI 		:= 1
	LOCAL nCountTag := PLCOUNTTAG({"\NUMEROPROTOCOLO"}, aDados)
	LOCAL cTpTrans	:= u_CVLRTAGXML(aDados, "TIPOTRANSACAO")
	LOCAL cStTiss := ""

// RDA Contratada
	cCodRP := AllTrim( u_CVLRTAGXML(aDados, "\DADOSPRESTADOR\CPFCONTRATADO,\DADOSPRESTADOR\CNPJCONTRATADO"))
	cCodRP := cCodRP+Space( TamSX3("BAU_CPFCGC")[1]-Len(cCodRP) )
	nIdx 	:= 4
	If Empty(cCodRP)
		cCodRP := u_CVLRTAGXML(aDados, "\DADOSPRESTADOR\CODIGOPRESTADORNAOPERADORA")
		nIdx 	:= 1
	EndIf

	BAU->( DbSetOrder( nIdx ) ) //BAU_FILIAL + BAU_CPFCGC ou  BAU_CODIGO ou BAU_CODBB0
	If BAU->( MsSeek( xFilial("BAU")+cCodRP ) )
		cCodRda := BAU->BAU_CODIGO
	EndIf


// Codigo da Operadora
	cRegAns  := u_CVLRTAGXML(aDados, "\CABECALHO\DESTINO\REGISTROANS")
	If !Empty(cRegAns)
		BA0->( DbSetOrder(5) ) //BA0_FILIAL+BA0_SUSEP
		If BA0->( MsSeek( xFilial("BA0")+cRegAns ) )
			cOpeMov := BA0->(BA0_CODIDE+BA0_CODINT)
		Else
			u_CABLOGX("Operadora n�o encontrada  -> ( "+cRegAns+" ) informa��o no  \CABECALHO\DESTINO ",.F.,,,"5006") //"Operadora não encontrada  -> ( "###" ) informação no  \CABECALHO\DESTINO "
		EndIf
	EndIf


// Numeros dos Protocolos
	If lOkXml
		SIX->( DbSetOrder(1) )
		If SIX->( MsSeek("BEA16") )
			For nI := 1 To nCountTag
				cNumPro := u_CVLRTAGXML(aDados, "\NUMEROPROTOCOLO", nI)
				cNumPro := cNumPro+Space( TamSX3("BEA_LOTGUI")[1]-Len(cNumPro) )

				BEA->( DbSetOrder(16) ) //BEA_FILIAL + BEA_OPERDA + BEA_CODRDA + BEA_LOTGUI
				If BEA->( MsSeek( xFilial("BEA")+cOpeMov+cCodRda+cNumPro ) )

					If BCI->( FieldPos("BCI_STTISS") ) > 0
						BCI->(dbSetOrder(15))
						if(BCI->(msSeek(xFilial("BCI")+BEA->BEA_LOTGUI)))
							cStTiss := BCI->BCI_STTISS
						else
							cStTiss := "7"
						endIf
					endIf

					While !BEA->( Eof() ) .And. AllTrim(BEA->(BEA_CODRDA+BEA_LOTGUI)) == AllTrim(cCodRda+cNumPro)

						lConSadt	:= IiF( Empty( AllTrim(BEA->(BEA_ANOINT+BEA_MESINT+BEA_NUMINT)) ),.T.,.F. )
						aMatGui		:= u_CBMNTGUI( BEA->(BEA_OPEMOV+BEA_ANOAUT+BEA_MESAUT+BEA_NUMAUT) , lConSadt)

						If (cTpTrans == "SOLIC_STATUS_PROTOCOLO")
					    //             (cCodOpe,    cRdaDe,       cRdaAte,       cAno,          cMes,          cClaPre, cLocRda , cNFSSDe, cNFSSAte,cNmTitPg,cPEGDe, cPEGAte)
							aRetDad := PLSDACM(PlsIntPad(), BEA->BEA_CODRDA, BEA->BEA_CODRDA, BEA->BEA_ANOAUT, BEA->BEA_MESAUT, , , , ,,BEA->BEA_CODPEG, BEA->BEA_CODPEG, .T.)

							aValores := {}
							aAdd(aValores, aRetDad[29])//29 Valor Processado Guia 1
							aAdd(aValores, aRetDad[30])//30 Valor Liberado Guia 2
							aAdd(aValores, aRetDad[31])//31 Valor Glosa Guia 3
							aAdd(aValores, aRetDad[33])//33 Valor Processado Fatura 4
							aAdd(aValores, aRetDad[34])//34 Valor Liberado Fatura 5
							aAdd(aValores, aRetDad[35])//35 Valor Glosa Fatura 6
							aAdd(aValores, aRetDad[36])//36 Valor Processado Protocolo 7
							aAdd(aValores, aRetDad[37])//37 Valor Liberado Protocolo 8
							aAdd(aValores, aRetDad[38])//38 Valor Glosa Protocolo 9
							if(!empty(cStTiss))
								aAdd(aValores, cStTiss)    // Status Protocolo Tiss 10
							endif
						EndIf
						aAdd(aMatGui, aValores)

						aAdd(aRet, aMatGui)

						BEA->( DbSkip() )
					EndDo
				Else
					u_CABLOGX("Lote não encontrado -> ( "+cNumPro+" ) para este Prestador ( "+cCodRda+" ) ")
				EndIf
			Next
		Else
			u_CABLOGX("Não existe o indice 16 na tabela BEA",.F.)
		EndIf
	EndIf

Return( aRet )

/*/{Protheus.doc} u_cabaSA
Status Autorizacao
@type function
@author TOTVS
@since 25.06.08
@version 1.0
/*/
User Function cabaSA(cGuia,cNomeArq,cDatHor,aMatC,aMatM,lHasAr,lHasCo,cCodPeg)
	LOCAL nIdx	   	:= 0
	LOCAL cRegAns	:= ""
	LOCAL cNumeSeq  := ""
	LOCAL cMatric   := ""
	LOCAL cNumAut	:= ""
	LOCAL cNGuiOri	:= ""
	LOCAL cNomeUsu	:= ""
	LOCAL dData 	:= SToD("")
	LOCAL cHora 	:= ""
	LOCAL cTpCab 	:= ""
	LOCAL cCCCab 	:= ""
	LOCAL cCodRda 	:= ""
	LOCAL cNomRda 	:= ""
	LOCAL cCodRP	:= ""
	LOCAL dDatPro 	:= SToD("")
	LOCAL aRet		:= {}
	LOCAL aRetAux	:= {}
	DEFAULT cCodPeg	:= ""




// Dados da Solicitacao
	cNumeSeq := AllTrim(u_CPEGCONR("SEQUENCIALTRANSACAO","\CABECALHO\IDENTIFICACAOTRANSACAO",aMatC,nil,nil,nil,nil,cCodPeg))
	dData 	 := u_CBAJUDAT(u_CPEGCONR("DATAREGISTROTRANSACAO","\CABECALHO\IDENTIFICACAOTRANSACAO",aMatC,nil,nil,.F.,nil,cCodPeg))
	cHora 	 := SubStr(u_CPEGCONR("HORAREGISTROTRANSACAO","\CABECALHO\IDENTIFICACAOTRANSACAO",aMatC,nil,nil,nil,nil,cCodPeg),1,8)

// Codigo da Operadora
	cRegAns  := u_CPEGCONR("REGISTROANS","CABECALHO\DESTINO",aMatC,nil,nil,nil,nil,cCodPeg)
	If !Empty(cRegAns)
		BA0->( DbSetOrder(5) ) //BA0_FILIAL+BA0_SUSEP
		If BA0->( MsSeek( xFilial("BA0")+cRegAns ) )
			cOpeMov := BA0->(BA0_CODIDE+BA0_CODINT)
		Else
			u_CABLOGX("Operadora n�o encontrada  -> ( "+cRegAns+" ) informa��o no  \CABECALHO\DESTINO ",.F.) //"Operadora não encontrada  -> ( "###" ) informação no  \CABECALHO\DESTINO "
		EndIf
	EndIf

// Dados da Solicitacao
	cDataSol	:= u_CPEGCONR("DATASOLICITASTATUS","\SOLICITASTATUSAUTORIZACAO",aMatM,nil,nil,nil,nil,cCodPeg)
	cNumAut		:= u_CPEGCONR("NUMEROGUIAPRESTADOR",cGuia,aMatM,nil,nil,nil,nil,cCodPeg)
	cNGuiOri	:= cNumAut
	cNumAutOp	:= u_CPEGCONR("NUMEROGUIAOPERADORA",cGuia,aMatM,nil,nil,nil,nil,cCodPeg)
	If !Empty(cNumAutOp)
		cNumAut := cNumAutOp
	EndIf

// Procura pelo numero do impresso o numero da liberacao
	If ExistBlock("PLSTMLLIB")
		cNumAut := ExecBlock( "PLSTMLLIB",.F.,.F.,{ cNumAut,cOpeMov,"","","","" } )
	EndIf

// RDA Contratado Solicitante
	cCodRP := AllTrim( u_CPEGCONR("CPF,CNPJ,CODIGOPRESTADORNAOPERADORA","\PROFISSIONALSOLICITANTE\IDENTIFICACAO",aMatM,nil,.T.,nil,nil,cCodPeg) )
	cCodRP := cCodRP+Space( TamSX3("BAU_CPFCGC")[1]-Len(cCodRP) )
	nIdx 	:= 4
	If Empty(cCodRP)
		cCodRP := u_CPEGCONR("CODIGOPRESTADORNAOPERADORA","\PROFISSIONALSOLICITANTE\IDENTIFICACAO",aMatM,nil,.T.,nil,nil,cCodPeg)
		nIdx 	:= 1
	EndIf

// RDA
	u_CBIVRDA(cCodRP,nIdx,,NIL)

// Ponto de entrada
	U_CBXPROF("R",cCodRP,"2",cNumAut,"",nIdx,DToS(dData),cHora,,NIL,aMatC)
	If BAU->( Found() )
		cCodRda := BAU->BAU_CODIGO
		cNomRda := AllTrim(BAU->BAU_NOME)
		cTpCab 	:= AllTrim(BAU->BAU_TIPPE)
		cCCCab  := AllTrim(BAU->BAU_CPFCGC)
	EndIf

// Procura a Guia
	If lOkXml
		If !Empty(cNumAut)
			BEA->( DbSetOrder(1) ) //BEA_FILIAL + BEA_OPEMOV + BEA_ANOAUT + BEA_MESAUT + BEA_NUMAUT + DTOS(BEA_DATPRO) + BEA_HORPRO
			If BEA->( MsSeek( xFilial("BEA")+cNumAut ) )
				lConSadt := Iif( Empty( AllTrim(BEA->(BEA_ANOINT+BEA_MESINT+BEA_NUMINT)) ),.T.,.F. )
				aRet 	 := u_CBMNTGUI(cNumAut,lConSadt)

			// Se for atendimento de intercambio devolve a matricula antiga
				If BEA->BEA_TIPUSR == "01"
					cMatric := BEA->BEA_MATANT
				Else
					cMatric := BEA->(BEA_OPEUSR+BEA_CODEMP+BEA_MATRIC+BEA_TIPREG+BEA_DIGITO)
				EndIf
				cNomeUsu := BEA->BEA_NOMUSR
				dDatPro  := BEA->BEA_DATPRO
			Else
				u_CABLOGX("Guia n�o encontrada -> ( "+cNumAut+" ) ") //"Guia não encontrada -> ( "###" ) "
			EndIf
		Else
			u_CABLOGX("Guia n�o encontrada -> ( "+cNumAut+" ) ") //"Guia não encontrada -> ( "###" ) "
		EndIf
	EndIf

// Dados do Retorno Aux
	AaDd(aRetAux,cTpCab)	//1
	AaDd(aRetAux,cCCCab)	//2
	AaDd(aRetAux,cCodRda)	//3
	AaDd(aRetAux,cNomRda)	//4
	AaDd(aRetAux,cTpCab)	//5
	AaDd(aRetAux,cCCCab)	//6
	AaDd(aRetAux,cMatric)	//7
	AaDd(aRetAux,cNomeUsu)	//8
	AaDd(aRetAux,cNumeSeq)	//9
	AaDd(aRetAux,cNGuiOri)	//10
	AaDd(aRetAux,.F.)		//11
	AaDd(aRetAux,.F.)		//12
	AaDd(aRetAux,cNumeSeq)	//13
	AaDd(aRetAux,dDatPro)	//14
	AaDd(aRetAux,cCodRda)	//15
	AaDd(aRetAux,"")                           	//16 CNES
	AaDd(aRetAux,0)                           	//17 Valor Total da Guia
	AaDd(aRetAux,"")                           	//18 RN





Return( { aRetAux,aRet } )

/*/{Protheus.doc} u_cabaSAB
Status Autorizacao
@type function
@author TOTVS
@since 25.10.13
@version 1.0
/*/
User Function cabaSAB(aDados)
	LOCAL cRegAns	:= ""
	LOCAL cOpeMov	:= ""
	LOCAL cNumAut	:= ""
	LOCAL nI		:= 1
	LOCAL nCountTag := PLCOUNTTAG({"\IDENTIFICACAOSOLICITACAO\NUMEROGUIAPRESTADOR"}, aDados)
	LOCAL aRet		:= {}


// Dados da Operadora
	cRegAns		:= u_CVLRTAGXML(aDados, "\CABECALHO\DESTINO\REGISTROANS")
	If !Empty(cRegAns)
		BA0->( DbSetOrder(5) ) //BA0_FILIAL+BA0_SUSEP
		If BA0->( MsSeek( xFilial("BA0")+cRegAns ) )
			cOpeMov := BA0->(BA0_CODIDE+BA0_CODINT)
		Else
			u_CABLOGX("Operadora n�o encontrada  -> ( "+cRegAns+" ) informa��o no  \CABECALHO\DESTINO ",.F.,,,"5006") //"Operadora não encontrada  -> ( "###" ) informação no  \CABECALHO\DESTINO "
		EndIf
	EndIf

	For nI := 1 To nCountTag

	// Dados da Solicitacao
		cNumAut := u_CVLRTAGXML(aDados, "\IDENTIFICACAOSOLICITACAO\NUMEROGUIAPRESTADOR", nI)

	// Procura pelo numero do impresso o numero da liberacao
		If ExistBlock("PLSTMLLIB")
			cNumAut := ExecBlock( "PLSTMLLIB",.F.,.F.,{ cNumAut,cOpeMov,"","","","" } )
		EndIf

	// Procura a Guia
		If !Empty(cNumAut)
			BEA->( DbSetOrder(1) ) //BEA_FILIAL + BEA_OPEMOV + BEA_ANOAUT + BEA_MESAUT + BEA_NUMAUT + DTOS(BEA_DATPRO) + BEA_HORPRO
			If BEA->( MsSeek( xFilial("BEA")+cNumAut ) )
				lConSadt := Iif( Empty( AllTrim(BEA->(BEA_ANOINT+BEA_MESINT+BEA_NUMINT)) ),.T.,.F. )
				aAdd(aRet, u_CBMNTGUI(cNumAut,lConSadt))
			Else
				u_CABLOGX("Guia n�o encontrada -> ( "+cNumAut+" ) ",,,,"2906") //"Guia não encontrada -> ( "###" ) "
			EndIf
		Else
			u_CABLOGX("Guia n�o encontrada -> ( "+cNumAut+" ) ",,,,"2906") //"Guia não encontrada -> ( "###" ) "
		EndIf
	Next

Return( aRet )

/*/{Protheus.doc} u_cabaSRG
Recurso de glosa
@type function
@author TOTVS
@since 27.01.16
@version 1.0
/*/
User Function cabaSRG(aDados, aMatM)
	local nI		:= 1
	local cCodRP	:= ""
	local nIdx		:= 4
	local cCodRda	:= ""
	local cOpeMov	:= ""
	local cNumAut 	:= ""
	local cMsg		:= ""
	local cRet		:= ""
	local cCodTpGuia := ""
	local cTipoGuia := ""
	local aRet		:= {}
	local aRetAux	:= {}
	local nJ := 0
	local cCodPeg := ""
	local cOpeLote := ""
	local cCodLdp := ""
	local cNumLotePr := ""
	local cOriMov := ""
	local cTipGui := ""
	local cStatus := ""
	local cObjRec := ""
	local cSeqB4D := ""
	local nVlrGlo := 0
	local nVlrRec := 0
	local nVlrAct := 0
	local cSql := ""
	local cTipRec := ""
	local aRetGrv := {}
	local cPadBkp := ""
	local cCodProc := ""
	local cCodTabela := ""
	local cDescric := ""
	local cSequen := ""
	local dDatRec := stod("")
	local cDtIni := ""
	local cDtFim := ""
	local cNumGuiOpe := ""
	local aTabDup := PlsBusTerDup(SuperGetMv("MV_TISSCAB", .F. ,"87"))
	local cQtdGui := 0
	local cDesProc := ""
	local cData := ""
	local cNomRda := ""
	local nVlrTot := 0
	local aCab := {}
	local cAnoAut := ""
	local cMesAut := ""
	local aItens := {}
	local aRetorno := {}
	local cObs := ""
	local cSeqRec := ""
	local lAchou := .T.
	local cSeqProt := ""
	Local cSenha1	:= ""
	DEFAULT aMatM := {}

// RDA Contratada
	cCodRP := alltrim( u_CVLRTAGXML(aDados, "\RECURSOGLOSA\GUIARECURSOGLOSA\DADOSCONTRATADO\CPFCONTRATADO,\RECURSOGLOSA\GUIARECURSOGLOSA\DADOSCONTRATADO\CNPJCONTRATADO"))
	cCodRP := cCodRP+Space( tamSX3("BAU_CPFCGC")[1]-len(cCodRP) )
	nIdx 	:= 4

	if empty(cCodRP)
		cCodRP := u_CVLRTAGXML(aDados, "\RECURSOGLOSA\GUIARECURSOGLOSA\DADOSCONTRATADO\CODIGOPRESTADORNAOPERADORA")
		nIdx 	:= 1
		if empty(cCodRP)
			cCodRP := u_CVLRTAGXML(aDados, "\RECURSOGLOSA\GUIARECURSOGLOSA\DADOSCONTRATADO\CPFCONTRATADO")
		endif
	endif

	BAU->( dbSetOrder( nIdx ) ) //BAU_FILIAL + BAU_CPFCGC ou  BAU_CODIGO ou BAU_CODBB0
	if BAU->( MsSeek( xFilial("BAU")+cCodRP ) )
		cCodRda := BAU->BAU_CODIGO
		cNomRda := BAU->BAU_NOME
	endif


// Codigo da Operadora
	cRegAns  := u_CVLRTAGXML(aDados, "\CABECALHO\DESTINO\REGISTROANS")
	if !Empty(cRegAns)
		BA0->( DbSetOrder(5) ) //BA0_FILIAL+BA0_SUSEP
		if BA0->( MsSeek( xFilial("BA0")+cRegAns ) )
			cOpeMov := BA0->(BA0_CODIDE+BA0_CODINT)
		else
			u_CABLOGX("Operadora n�o encontrada  -> ( "+cRegAns+" ) informa��o no  \CABECALHO\DESTINO ",.F.,,,"5006") //"Operadora não encontrada  -> ( "###" ) informação no  \CABECALHO\DESTINO "
		endif
	endif

// Pegando dados do recurso     												   	³
	cRegAns   := u_CVLRTAGXML(aDados, "\RECURSOGLOSA\GUIARECURSOGLOSA\REGISTROANS")
	cNumGuiPre := u_CVLRTAGXML(aDados, "\RECURSOGLOSA\GUIARECURSOGLOSA\NUMEROGUIARECGLOSAPRESTADOR")
	cObjRec    := u_CVLRTAGXML(aDados, "\RECURSOGLOSA\GUIARECURSOGLOSA\OBJETORECURSO")
	cNumLotePr := u_CVLRTAGXML(aDados, "\RECURSOGLOSA\GUIARECURSOGLOSA\NUMEROLOTE")
	cCodPeg    := u_CVLRTAGXML(aDados, "\RECURSOGLOSA\GUIARECURSOGLOSA\NUMEROPROTOCOLO")
	nVlrRec    := val(strtran(u_CVLRTAGXML(aDados, "\RECURSOGLOSA\GUIARECURSOGLOSA\VALORTOTALRECURSADO"), ",", "."))
	dDatRec    := stod(strtran(u_CVLRTAGXML(aDados, "\RECURSOGLOSA\GUIARECURSOGLOSA\DATARECURSO"), "-", ""))
	nGlOpe     := u_CVLRTAGXML(aDados, "\RECURSOGLOSA\GUIARECURSOGLOSA\NUMEROGUIARECGLOSAOPERADORA")

	if !Empty(cOpeLote)
		BA0->( dbSetOrder(5) ) //BA0_FILIAL+BA0_SUSEP
		if BA0->( msSeek( xFilial("BA0")+cRegAns ) )
			cOpeLote := BA0->(BA0_CODIDE+BA0_CODINT)
		else
			u_CABLOGX("Operadora n�o encontrada  -> ( "+cRegAns+" ) informa��o no  \CABECALHO\DESTINO ",.F.,,,"5006") //"Operadora não encontrada  -> ( "###" ) informação no  \CABECALHO\DESTINO "
		endif
	endif

	BCI->(dbSetOrder(14))
	if !(BCI->(msSeek(xFilial("BCI")+cCodPeg)))
		u_CABLOGX("Protocolo não encontrado -> ( "+cCodPeg+" ) ",.F.,,,"1307")
	else
		if !(BCI->BCI_CODRDA == cCodRda)
			u_CABLOGX("Protocolo não encontrado para o prestador informado",.F.,,,"1203") //"Protocolo não encontrado para o prestador informado"
		else
		//recurso por protocolo
			if(empty(aMatM)) .and. cObjRec == "1"
				B4D->(dbSetOrder(5))
				if B4D->(MsSeek(xFilial("B4D")+cOpeMov+BCI->(BCI_CODLDP+BCI_CODPEG)))
					while(!B4D->(EOF()) .AND. B4D->(B4D_FILIAL+B4D_OPEMOV+B4D_CODLDP+B4D_CODPEG) == (xFilial("B4D")+cOpeMov+BCI->(BCI_CODLDP+BCI_CODPEG)))
					lAchou := .F.
					if(B4D->B4D_OBJREC == "1")
						lAchou := .T.
						exit
					endif
					B4D->(dbSkip())
				endDo

				if(lAchou)
					if(B4D->B4D_STATUS == "2")
						u_CABLOGX("O último recurso de glosa ainda está em análise",.F.,,,"2904") //"Tipo de glosa inválido"
					else
						cCodLdp := B4D->B4D_CODLDP
						cNumAut := B4D->B4D_NUMAUT
						cOriMov := B4D->B4D_ORIMOV
						cTipGui := B4D->B4D_TIPGUI
						cStatus := B4D->B4D_STATUS
						cObjRec := B4D->B4D_OBJREC
						cSeqB4D := B4D->B4D_SEQB4D
						nVlrGlo := B4D->B4D_VLRGLO
						nVlrAct := B4D->B4D_TOTACA
						nGlOpe  := B4D->B4D_NGLOPE
						nVlrTot += nVlrRec
						cTipRec := "P"
						cCodGlo   := u_CVLRTAGXML(aDados, "\RECURSOGLOSA\GUIARECURSOGLOSA\OPCAORECURSO\RECURSOPROTOCOLO\CODIGOGLOSAPROTOCOLO")
						cJust     := u_CVLRTAGXML(aDados, "\RECURSOGLOSA\GUIARECURSOGLOSA\OPCAORECURSO\RECURSOPROTOCOLO\JUSTIFICATIVAPROTOCOLO")

						BTQ->(dbSetOrder(1))
						if!(BTQ->(msSeek(xFilial("BTQ")+"38"+cCodGlo)))
							u_CABLOGX("Tipo de glosa do protocolo inválido",.F.,,,"5043") //"Tipo de glosa inválido"
						endIf

						if lOkXml
							BVO->(DbSetOrder(2))

							if(BVO->(MsSeek(xFilial("BVO")+cOpeMov+cCodLdp+cCodPeg+cNumAut)))
								cSeqRec := BVO->BVO_SEQREC
							endIf

							begin transaction
								aRetGrv := PLSAGRVREC(cOpeMov,cCodLdp,cCodPeg,cNumAut,;
									cOriMov,cTipGui,cCodRda,,,,,,,,,,nVlrGlo,,,,,,,,cStatus,;
									cJust,,"0",.F.,cSeqRec,,,nVlrAct,,cSeqB4D, nVlrRec,"P", .T., cNumLotePr, cNumGuiPre)
							end transaction

							if !empty(aRetGrv[2]) .and. !empty(aRetGrv[5])
								u_CABLOGX(aRetGrv[2],.F.,,,aRetGrv[5])
							else
								cQtdGui := alltrim(str(BCI->BCI_QTDDIG))
								aadd(aItens, {"P", cCodGlo, cJust, cQtdGui })
								cSeqProt := aRetGrv[6]
							endif
						endif
					endIf
				else
					u_CABLOGX("Glosa não encontrada",.F.,,,"2901") //"Glosa não encontrada"
				endIf
			else
				u_CABLOGX("Glosa não encontrada",.F.,,,"2901") //"Glosa não encontrada"
			endIf
		else
			B4D->(dbSetOrder(1))
			BVO->(DbSetOrder(2))
			for nI := 1 to len(aMatM)
				cNumGuiOri := u_CVLRTAGXML(aMatM[nI], "NUMEROGUIAORIGEM")
				cNumGuiOpe := u_CVLRTAGXML(aMatM[nI], "NUMEROGUIAOPERADORA")
				if B4D->(msSeek(xFilial("B4D")+cOpeMov+cNumGuiOpe))
					while B4D->(!EOF()) .and. B4D->(B4D_FILIAL+B4D_OPEMOV+B4D_ANOAUT+B4D_MESAUT+B4D_NUMAUT) == (xFilial("B4D")+cOpeMov+cNumGuiOpe)
						if B4D->B4D_CODPEG == cCodPeg
							exit
						endIf
						B4D->(dbSkip())
					enddo
					if !(B4D->B4D_CODPEG == cCodPeg)
						u_CABLOGX("A guia " + cNumGuiOpe + " não pertence ao protocolo informado",.F.,,,"1303") //"A guia " + cNumGuiOpe + " não pertence ao protocolo informado"
					else
						cSenha1      := u_CVLRTAGXML(aMatM[nI], "SENHA")
						nTagGuiComp := PLCOUNTTAG({"\CODGLOSAGUIA"}, aMatM[nI])
						cCodLdp := B4D->B4D_CODLDP
						cNumAut := B4D->B4D_NUMAUT
						cOriMov := B4D->B4D_ORIMOV
						cTipGui := B4D->B4D_TIPGUI
						cStatus := B4D->B4D_STATUS
						cObjRec := B4D->B4D_OBJREC
						cSeqB4D := B4D->B4D_SEQB4D
						nVlrGlo := B4D->B4D_VLRGLO
						nVlrAct := B4D->B4D_TOTACA
						nGlOpe  := B4D->B4D_NGLOPE

						if(cTipGui == "03") //se é uma internação verifico se possui senha
							BE4->(dbSetOrder(2))
							if(BE4->(msSeek(xFilial("BE4")+cNumGuiOpe)))
								cSenha1 := BE4->BE4_SENHA
							else
								cSenha1 := ""
							endIf
						endIf

						//RECURSO GUIA COMPLETA
						if(nTagGuiComp > 0)
							cTipRec := "G"
							for nJ := 1 to nTagGuiComp

								if(B4D->B4D_STATUS == "2")
									u_CABLOGX("O último recurso de glosa da guia " + cNumGuiOpe + " ainda está em análise",.F.,,,"2904") //"O último recurso de glosa ainda está em análise"
								else
									nVlrRec := B4D->B4D_VLRGLO //valor total da glosa na guia
									cCodGlo := u_CVLRTAGXML(aMatM[nI], "CODGLOSAGUIA", nJ)
									cJust   := u_CVLRTAGXML(aMatM[nI], "JUSTIFICATIVAGUIA", nJ)
									nVlrTot += nVlrRec
									BTQ->(dbSetOrder(1))
									if!(BTQ->(msSeek(xFilial("BTQ")+"38"+cCodGlo)))
										u_CABLOGX("Tipo de glosa da guia inválido",.F.,,,"5043") //"Tipo de glosa inválido"
									endIf

									if(BVO->(MsSeek(xFilial("BVO")+cOpeMov+cCodLdp+cCodPeg+cNumAut)))
										cSeqRec := BVO->BVO_SEQREC
									endIf

									if lOkXml
										aadd(aRetAux, { "G", cOpeMov, cCodLdp, cCodPeg, cNumAut, cOriMov,;
											cTipGui, cCodRda, nVlrGlo, dDatRec, cStatus, cJust, cSeqRec, nVlrAct,;
											nGlOpe, cSeqB4D, nVlrRec, cNumLotePr, cNumGuiOri, cNumGuiOpe, cSenha1, cCodGlo })
									endIf
								endIf
							next nJ
						else
							//RECURSO ITENS GUIA
							cTipRec := "I"
							nTagGuiProc := PLCOUNTTAG({"\CODIGOPROCEDIMENTO"}, aMatM[nI])
							for nJ := 1 to nTagGuiProc
								//cDtIni    := u_CVLRTAGXML(aMatM[nI], "DATAINICIO", nJ)
								//cDtFim    := u_CVLRTAGXML(aMatM[nI], "DATAFIM", nJ)
								cCodPad   := u_CVLRTAGXML(aMatM[nI], "CODIGOTABELA", nJ)
								cCodPro   := u_CVLRTAGXML(aMatM[nI], "CODIGOPROCEDIMENTO", nJ)
								cGrauPart := u_CVLRTAGXML(aMatM[nI], "GRAUPARTICIPACAO", nJ)
								cCodGlo   := u_CVLRTAGXML(aMatM[nI], "CODGLOSAITEM", nJ)
								nVlrRec   := val(strtran(u_CVLRTAGXML(aMatM[nI], "VALORRECURSADO", nJ), ",", "."))
								nVlrTot   += nVlrRec
								cJust     := u_CVLRTAGXML(aMatM[nI], "JUSTIFICATIVAITEM", nJ)

								cPadBkp 	:= alltrim(PLSGETVINC("BTU_CDTERM", "BR4", .F., "87",  cCodPad,.T.))
								cCodProc 	:= alltrim(PLSGETVINC("BTU_CDTERM", "BR8", .F., cCodPad,  cCodpro, .T. ,aTabDup, @cPadBkp))
								cCodTabela := cPadBkp
								cDesProc   := alltrim(PLSGETVINC("BTQ_DESTER", "BR8", .F., cCodPad,  Alltrim(cCodpro)))
			   	   				//alltrim(PLSGETVINC("BTU_CDTERM", "BR8", .F., cCodPad,  cCodpro, .T. ,aTabDup, @cPadBkp))
								If (Empty(cCodTabela))
									// NÃO PODE RETORNAR PARA O PRESTADOR QUE NÃO TEM DE/PARA POIS ESSA É UMA INFORMAÇÃO
									// PERTINENTE AO CADASTRO DA OPERADORA DEVE SER VERIFICADO DENTRO DO PLS PLSLOGFIL
									PLSLOGFIL( "TransacoesOnline: Codigo da Tabela nao encontrado no De/Para. " + Time(),DIRLOG+"ONLINELOG.TXT" )
									u_CABLOGX("Não foi possível validar o arquivo XML. Contate sua Operadora",.F.,,,"5002")
								EndIf

								If (Empty(cCodProc))
									// NÃO PODE RETORNAR PARA O PRESTADOR QUE NÃO TEM DE/PARA POIS ESSA É UMA INFORMAÇÃO
									// PERTINENTE AO CADASTRO DA OPERADORA DEVE SER VERIFICADO DENTRO DO PLS PLSLOGFIL
									PLSLOGFIL( "TransacoesOnline: Codigo do Procedimento nao encontrado no De/Para. "+BR8->(BR8_CODPAD+BR8_CODPSA) + " " + Time(),DIRLOG+"ONLINELOG.TXT" )
									u_CABLOGX("Não foi possível validar o arquivo XML. Contate sua Operadora",.F.,,,"5002")
								EndIf

								B4E->(dbsetorder(4))
								if(B4E->(msSeek(xFilial("B4E")+ cOpeMov + cNumGuiOpe + cCodTabela + cCodProc)))

									BTQ->(dbSetOrder(1))
									if!(BTQ->(msSeek(xFilial("BTQ")+"38"+cCodGlo)))
										u_CABLOGX("Tipo de glosa do item inválido",.F.,,,"5043") //"Tipo de glosa inválido"
									endIf

									if lOkXml

										if(BVO->(MsSeek(xFilial("BVO")+cOpeMov+cCodLdp+cCodPeg+cNumAut+B4E->B4E_SEQUEN)))
											cSeqRec := BVO->BVO_SEQREC
										endIf

										BD6->(dbSetOrder(6))
										//BD6_FILIAL+BD6_CODOPE+BD6_CODLDP+BD6_CODPEG+BD6_NUMERO+BD6_ORIMOV+BD6_CODPAD+BD6_CODPRO
										if(BD6->(msSeek(xFilial("BD6")+B4D->(B4D_OPEMOV+B4D_CODLDP+B4D_CODPEG+B4D_NUMAUT+B4D_ORIMOV)+B4E->(B4E_CODPAD+B4E_CODPRO))))
											cDtIni := dtos(BD6->BD6_DATPRO)
											if(!empty(cDtIni))
												cDtIni := substr(cDtIni,1,4)+"-"+substr(cDtIni,5,2)+"-"+substr(cDtIni,7,2)
											endif
											if(cTipGui == "03")
												cDtFim := dtos(BE4->BE4_DTALTA)
												if(!empty(cDtFim))
													cDtFim := substr(cDtFim,1,4)+"-"+substr(cDtFim,5,2)+"-"+substr(cDtFim,7,2)
												endIf
											endIf
										endIf

										aadd(aRetAux, { "I", cOpeMov, cCodLdp, cCodPeg, cNumAut, cOriMov,;
											cTipGui, cCodRda, cCodPad, cCodPro, B4E->B4E_SEQUEN, nVlrGlo,dDatRec,;
											cStatus,cJust, cSeqRec,nVlrAct,nGlOpe, cSeqB4D, nVlrRec, cNumLotePr,cNumGuiOri, cNumGuiOpe, cSenha1, cDtIni, cDtFim, cDesProc, cCodGlo,cCodTabela , cCodProc })
									endIf
								else
									u_CABLOGX("Procedimento " + cCodPro + ", tabela " + cCodPad + " não possui glosa",.F.,,,"2901")
								endIf

							next nJ
						endIf
					endIf
				else
					u_CABLOGX("Glosa não encontrada",.F.,,,"2901") //"Glosa não encontrada"
				endIf
			next nI

			if lOkXml
				begin transaction
					for nI := 1 to len(aRetAux)
						if(aRetAux[nI][1] == "G")

							cOpeMov := aRetAux[nI][2]
							cCodLdp := aRetAux[nI][3]
							cCodPeg := aRetAux[nI][4]
							cNumAut := aRetAux[nI][5]
							cOriMov := aRetAux[nI][6]
							cTipGui := aRetAux[nI][7]
							cCodRda := aRetAux[nI][8]
							nVlrGlo := aRetAux[nI][9]
							dDatRec := aRetAux[nI][10]
							cStatus := aRetAux[nI][11]
							cJust   := aRetAux[nI][12]
							cSeqRec := aRetAux[nI][13]
							nVlrAct := aRetAux[nI][14]
							nGlOpe  := aRetAux[nI][15]
							cSeqB4D := aRetAux[nI][16]
							nVlrRec := aRetAux[nI][17]
							cNumLotePr := aRetAux[nI][18]
							cNumGuiOri := aRetAux[nI][19]
							cNumGuiOpe := aRetAux[nI][20]
							cSenha1 := aRetAux[nI][21]
							cCodGlo := aRetAux[nI][22]
							if lOkXml
								aRetGrv := PLSAGRVREC(cOpeMov,cCodLdp,cCodPeg,cNumAut,;
									cOriMov,cTipGui,cCodRda,,,,,,,,,,nVlrGlo,,dDatRec,,,,,,;
									cStatus, cJust,,"0", .F.,cSeqRec,,,nVlrAct,,cSeqB4D,;
									nVlrRec,"G", .T., cNumLotePr, cNumGuiPre)

								if !empty(aRetGrv[2]) .and. !empty(aRetGrv[5])
									u_CABLOGX(aRetGrv[2],.F.,,,aRetGrv[5])
									disarmTransaction()
								else
									aadd(aItens, {"G", cNumGuiOri, cNumGuiOpe, cSenha1, cCodGlo, cJust })
									cSeqProt := aRetGrv[6]
								endif
							endIf
						else

							cOpeMov := aRetAux[nI][2]
							cCodLdp := aRetAux[nI][3]
							cCodPeg := aRetAux[nI][4]
							cNumAut := aRetAux[nI][5]
							cOriMov := aRetAux[nI][6]
							cTipGui := aRetAux[nI][7]
							cCodRda := aRetAux[nI][8]
							cCodPad := aRetAux[nI][9]
							cCodPro := aRetAux[nI][10]
							cSequen := aRetAux[nI][11]
							nVlrGlo := aRetAux[nI][12]
							dDatRec := aRetAux[nI][13]
							cStatus := aRetAux[nI][14]
							cJust   := aRetAux[nI][15]
							cSeqRec := aRetAux[nI][16]
							nVlrAct := aRetAux[nI][17]
							nGlOpe  := aRetAux[nI][18]
							cSeqB4D := aRetAux[nI][19]
							nVlrRec := aRetAux[nI][20]
							cNumLotePr := aRetAux[nI][21]
							cNumGuiOri := aRetAux[nI][22]
							cNumGuiOpe := aRetAux[nI][23]
							cSenha1     := aRetAux[nI][24]
							cDtIni     := aRetAux[nI][25]
							cDtFim     := aRetAux[nI][26]
							cDesProc   := aRetAux[nI][27]
							cCodGlo    := aRetAux[nI][28]
							cCodTabela := aRetAux[nI][29]
							cCodProc   := aRetAux[nI][30]
							if lOkXml
								aRetGrv := PLSAGRVREC(cOpeMov,cCodLdp,cCodPeg,cNumAut,;
									cOriMov,cTipGui,cCodRda,,,cCodTabela,cCodProc,,,cSequen,,,nVlrGlo,,dDatRec,,,,,,;
									cStatus, cJust,,"0",.F.,cSeqRec,,,nVlrAct,,cSeqB4D, nVlrRec,;
									"I", .T., cNumLotePr, cNumGuiPre)

								if !empty(aRetGrv[2]) .and. !empty(aRetGrv[5])
									u_CABLOGX(aRetGrv[2],.F.,,,aRetGrv[5])
									disarmTransaction()
								else
									aadd(aItens, {"I", cNumGuiOri, cNumGuiOpe, cSenha1, cDtIni, cDtFim,;
										cCodPad, cCodPro, cDesProc, cCodGlo, alltrim(str(nVlrRec)), cJust })
									cSeqProt := aRetGrv[6]
								endif
							endIf
						endIf
					next nI
				end transaction
			endIf
		endIf
	endif

	cData := dtos(ddatabase)
	cData := substr(cData,1,4)+"-"+substr(cData,5,2)+"-"+substr(cData,7,2)
	aAdd(aCab, {cSeqProt,cData,cData,cNumLotePr,cRegAns, alltrim(cCodRP), cNomRda, cCodPeg, cObs, alltrim(str(nVlrTot)) })
	aAdd(aRet, aCab)
	aAdd(aRet, aItens)
	aAdd(aRetorno,  aRet)
endif

Return( aRetorno )

/*/{Protheus.doc} u_CBMNTGUI
Monta dados da guia procedimento e criticas
@type function
@author TOTVS
@since 28.04.20
@version 1.0
/*/
User Function CBMNTGUI(cNumAut,lConSadt)
	LOCAL cSql    		:= ""
	LOCAL cAliasCOld	:= ""
	LOCAL cCodGlo 		:= ""
	LOCAL cDesGlo 		:= ""
	LOCAL nI      		:= 0
	LOCAL cOpeMov 		:= IiF( lConSadt ,"OPEMOV", "CODOPE" )
	LOCAL cComp   		:= IiF( lConSadt ,"AUT", "INT" )
	LOCAL aAlias  		:= IiF( lConSadt ,{"BE2"}, {"BEJ","BQV"} )
	LOCAL aAliasC 		:= IiF( lConSadt ,{"BEG"}, {"BEL","BQZ"} )
	LOCAL aRet    		:= {}
	LOCAL aEventosAut	:= {}
	LOCAL aEventosNeg	:= {}
	LOCAL aCriticas 	:= {}
	LOCAL aRetDad		:= ""
	local nProcGui 	:= 0
	LOCAL nLibGui  	:= 0
	LOCAL nGloGui  	:= 0
	LOCAL nProcFat 	:= 0
	LOCAL nLibFat  	:= 0
	LOCAL nGloFat  	:= 0
	LOCAL nProcGer 	:= 0
	LOCAL nLibGer  	:= 0
	LOCAL nGloGer  	:= 0

	BR8->( DbSetOrder(1) )//BR8_FILIAL + BR8_CODPAD + BR8_CODPSA + BR8_ANASIN

// Pega os Procedimentos
	For nI := 1 To Len(aAlias)

		cAlias  := aAlias[nI]
		cAliasC := aAliasC[nI]

		cSQL := "SELECT "+cAlias+"_SEQUEN,"+cAlias+"_CODPAD,"+cAlias+"_CODPRO,"+cAlias+"_QTDPRO,"+cAlias+"_QTDSOL,"+cAlias+"_STATUS FROM "+BE2->(RetSQLName(cAlias))+" WHERE "
		cSQL += cAlias+"_FILIAL = '"+xFilial(cAlias)+"' AND "
		cSQL += cAlias+"_"+cOpeMov+" = '"+Subs(cNumAut,1,4)+"' AND "
		cSQL += cAlias+"_ANO"+cComp+" = '"+Subs(cNumAut,5,4)+"' AND "
		cSQL += cAlias+"_MES"+cComp+" = '"+Subs(cNumAut,9,2)+"' AND "
		cSQL += cAlias+"_NUM"+cComp+" = '"+Subs(cNumAut,11,8)+"' AND "
		cSQL += "D_E_L_E_T_ = ' '"
		PLSQuery(cSQL,"TRBSQL")

	// Set indice das Criticas
		&( cAliasC+"->( DbSetOrder(1) )" )

	// Area
		While ! TRBSQL->( Eof() )
			cSeqMov := &("TRBSQL->"+cAlias+"_SEQUEN")
			cCodPad := &("TRBSQL->"+cAlias+"_CODPAD")
			cCodPro := &("TRBSQL->"+cAlias+"_CODPRO")
			nQtdAut := &("TRBSQL->"+cAlias+"_QTDPRO")
			nQtdSol := &("TRBSQL->"+cAlias+"_QTDSOL")
			lAutori := Iif(&("TRBSQL->"+cAlias+"_STATUS")=="1",.T.,.F.)
			BR8->( MsSeek(xFilial("BR8")+cCodPad+cCodPro) )

		// Eventos Autorizados
			If lAutori
				AaDd(aEventosAut,{cSeqMov,cCodPad,cCodPro,nQtdSol,BR8->BR8_DESCRI,nQtdAut,"1"})
			Else
				AaDd(aEventosNeg,{cSeqMov,cCodPad,cCodPro,nQtdSol,BR8->BR8_DESCRI,nQtdAut})

			// Criticas
				If &( cAliasC+"->( MsSeek( '"+xFilial(cAliasC)+cNumAut+"' ) )" )
					While ! &(cAliasC+"->(Eof())") .And.;
							&(cAliasC+"->("+cAliasC+"_"+cOpeMov+"+"+cAliasC+"_ANO"+cComp+"+"+cAliasC+"_MES"+cComp+"+"+cAliasC+"_NUM"+cComp+")") == cNumAut
						cCodGlo := &( cAliasC+"->"+cAliasC+"_CODGLO" )
						If !Empty(cCodGlo)
							cDesGlo := &( cAliasC+"->"+cAliasC+"_DESGLO" )
							AaDd( aCriticas,{cSeqMov,cCodGlo,cDesGlo,cCodPad,cCodPro} )
						EndIf
						&(cAliasC+"->(DbSkip())")
					EndDo
				EndIf
			EndIf

			TRBSQL->( DbSkip() )
		Enddo
		TRBSQL->( DbCloseArea() )
	Next


// Retorno
	aRet := {	Len(aEventosAut)>0,;									//1
	BEA->(BEA_OPEMOV+BEA_ANOAUT+BEA_MESAUT+BEA_NUMAUT),;	//2
	BEA->BEA_SENHA,;       									//3
	aCriticas,;            									//4
	aEventosAut,;          									//5
	aEventosNeg,;          									//6
	0,;		               									//7
	"",;            										//8
	"",;          											//9
	{}}               										//10

Return( aRet )

/*/{Protheus.doc} u_CBAJUDAT
Ajusta Data
@type function
@author TOTVS
@since 28.04.08
@version 1.0
/*/
User Function CBAJUDAT(cData)

//Quando é subimissão de XML, esta passando em varios processamentos, e por ser publico, algum lugar esta alterando a tipagem
	If ValType(cData) == "D"
		Return(cData)
	EndIf

	dData := StrTran(cData,"-","")

	If At('/',dData) == 0
		If !Empty( dData ) .And. Empty( StoD( dData ) )
			dData := CtoD(Left(dData,2)+"/"+SubStr(dData,3,2)+"/"+Right(dData,4))
		Else
			dData := StoD( dData )
		EndIf
	Else
		dData := CtoD( dData )
	EndIf

Return(dData)

/*/{Protheus.doc} u_CPEGCONR
Pega o conteudo do campo da matriz
@type function
@author TOTVS
@since 26.05.07
@version 1.0
/*/
User Function CBPEGCON(cVar,aDad,cCodPeg)
	LOCAL nPos
	LOCAL lObrig := ( Right(cVar,3) <> "_OP" )
	LOCAL lCampo := ( Left(cVar,3) == "CP_" )
	LOCAL cVal 	 := ""
	LOCAL bBlockXml   := nil
	DEFAULT cCodPeg	:= ""

//Pesquisa na matriz e pega o valor
	nPos := aScan( aDad,{|x|AllTrim(x[1]) == AllTrim(cVar) } )
	If nPos > 0
		If Len( aDad[nPos] ) >= 2
			cVal := aDad[nPos,2]
			If Empty(cVal) .And. lCampo .And. lObrig
				cVal := "NIL"
			EndIf
		ElseIf lObrig
			cVal := "NIL"
		EndIf
	ElseIf lObrig
		cVal := "NIL"
	EndIf

Return cVal

/*/{Protheus.doc} u_CPEGCONR
Pega o conteudo do campo da matriz e verifica origem
@type function
@author TOTVS
@since 26.05.07
@version 1.0
/*/
//PLSPCONGR

User Function CPEGCONR(cChave,cOrigem,aDad,cTp,lLimp,lAjus,lMat,cCodPeg,nLimitPes)
	LOCAL nI		:= 1
	LOCAL nPos		:= 0
	LOCAL nPosOld	:= 0
	LOCAL cVal 		:= ""
	LOCAL aMatPes 	:= {}
	Local nZ		:= 0

	DEFAULT cTp		:= "C"
	DEFAULT lLimp	:= .F.
	DEFAULT lMat	:= .F.
	DEFAULT lAjus	:= .T.
	DEFAULT cCodPeg	:= ""
	DEFAULT nLimitPes := 0

//Encontra o próximo procedimento da guia. Caso não seja passado o parâmetro, não faz a verificação
	If cChave == "CODIGOPROCEDIMENTO" .AND. nLimitPes > 0

	//Se o valor não é o inicial, então iremos começas de onde paramos da outra vez
		nI := nLimitPes

		While ( nZ < 2 .AND. nI <= Len(aDad) )
			if aDad[nI][1] == "CODIGOPROCEDIMENTO" .AND. aDad[nI][3] == cOrigem
				nZ++

			//Se somou no nZ duas vezes, então achou o próximo procedimento
				if nZ == 2
					exit
				EndIf
			EndIf
			nI++
		EndDo

	//Importante: para usar o nLimitPes no processo, passar o parâmetro por referência na chamado do u_CPEGCONR
		nLimitPes := nI //Guarda a posição que comça o próximo procedimento. Caso não haja próximo, guarda o tamanho do array
	EndIf

//Implementa o delimitador
	If At(",",cChave) == 0
		cChave+=","
	EndIf

//Monta matriz de pesquisa
	aMatPes :=	U_CABARRAY( cChave,"," )

//Verifica se a chave encontrada esta na origem correta
	For nI:=1 To Len(aMatPes[3])
		If ( nPos := aScan( aDad,{|x|strtran(AllTrim(x[1]),'_','') == AllTrim(aMatPes[3,nI]) .And. Iif( !Empty(cOrigem),AllTrim(cOrigem) $ strtran(AllTrim(x[3]),'\_','\'),.T.) } ) ) > 0 .and. ;
				(nLimitPes == 0 .OR. nLimitPes == 1 .or. nPos < nLimitPes)
			cVal := AllTrim(aDad[nPos,2])
			If cTp == "E"
				cVal := AllTrim(aDad[nPos,1])
			EndIf
			If lLimp
				aDad[nPos,1] := "*"+aDad[nPos,1]
			EndIf
			Exit
		EndIf
		If !Empty(cVal)
			Exit
		EndIf
	Next

// Retira caracteres especiais
	If lAjus
		cVal := U_CBDELIM(cVal)
	EndIf

Return( IiF(lMat,{cVal,nPos},cVal) )

/*/{Protheus.doc} U_CBDELIM
Retira Caracteres especiais
@type function
@author TOTVS
@since 31.05.07
@version 1.0
/*/
User Function CBDELIM(cString,cDecimal)
	LOCAL nI
	LOCAL nTam
	LOCAL cCar       := ""
	LOCAL cCaracter  := "!@#$%¨&*()_+{}^~><:;/][|\.',-"
	DEFAULT cDecimal := ""

//Verifica se foi informado com uma ou duas posicoes
	If !Empty(cDecimal)
		nPosV := Len(SubStr(cString,RAT(",",cString),Len(cString)))
		nPosP := Len(SubStr(cString,RAT(".",cString),Len(cString)))
		nTam := Iif(nPosP==nPosV,0,Iif(nPosP<nPosV, nPosP-1 , nPosV-1 ))
	EndIf

//Retira caracteres
	For nI:=1 To Len(cCaracter)
		cCar 	:= AllTrim( SubStr(cCaracter,nI,1) )
		cString := StrTran( cString,cCar,"" )
	Next

//Para valores com decimais
	If !Empty(cDecimal)
		cString := Left(cString,Len(cString)-nTam) + cDecimal + Iif( Empty(Right(cString,nTam)),"00",Right(cString,nTam) )
	EndIf

Return(cString)

/*/{Protheus.doc} u_CBPROCRES
Monta xml de retorno
@type function
@author TOTVS
@since 12.05.07
@version 1.0
/*/
User Function CBPROCRES(aRetZ,cEncod,lFault,cCodErro,cDesErro,cObsErro,cFTmp,cRdaOri,cDirOnline,lOnL,aDados, aDadRel)
	LOCAL nI,nJ,nY,nZ,nX,nX1,nX2,nX3,nX4      := 0
	LOCAL nCont		:= 0
	LOCAL lCriCab 	 	:= .F.
	LOCAL lCriDir	 	:= .T.
	LOCAL lInc		 	:= .T.
	LOCAL lFaultLoc  	:= .F.
	LOCAL cTpCab   		:= ""
	LOCAL cCCCab	 	:= ""
	LOCAL cArqRet	 	:= ""
	LOCAL cHash			:= ""
	LOCAL cPlano	 	:= ""
	LOCAL cRda	  	 	:= ""
	LOCAL cNomeRda 		:= ""
	LOCAL cMatric 	 	:= ""
	LOCAL cNomeUsu	 	:= ""
	LOCAL cNumeLot	 	:= ""
	LOCAL cNumAut 	 	:= ""
	LOCAL cNumGui 	 	:= ""
	LOCAL cNumSen 		:= ""
	LOCAL cAteRN		:= ""
	LOCAL aMatAut 	 	:= ""
	LOCAL aMatNeg 	 	:= ""
	LOCAL cStatus	 	:= ""
	LOCAL cNumeAux	 	:= ""
	LOCAL cVersao    	:= StrTran(TISVERS,"_",".")
	LOCAL cTranRet	 	:= SubStr(aRetZ[2],1,At("=",aRetZ[2])-1)
	LOCAL cTagRet	 	:= SubStr(aRetZ[2],At("=",aRetZ[2])+1)
	LOCAL cOrigem	 	:= aRetZ[4]
	LOCAL cTagOri	 	:= aRetZ[5]
	LOCAL cData   	 	:= DtoS(Date())
	LOCAL dDatPro 	 	:= SToD("")
	LOCAL cTime   	 	:= Time()
	LOCAL aMatCri	 	:= {}
	LOCAL aMatAux    	:= {}
	LOCAL aRet		 	:= {}
	LOCAL aTrb		 	:= {}
	LOCAL aValores		:= {}
	LOCAL cNumeSeq 	:= aRetZ[3]
	LOCAL cNomApl  	:= Iif(lVerTISS,aRetZ[6],"")
	LOCAL cVerApl	 	:= Iif(lVerTISS,aRetZ[7],"")
	LOCAL cFabApl	 	:= Iif(lVerTISS,aRetZ[8],"")
	LOCAL cTipoGuia 	:= ""
	Local cErro 		:= ""
	Local cAviso 		:= ""
	Local cTipGui		:= '01'
	Local nVlrUnit		:= 0
	local nVlrProcLot	:= 0
	local nVlrGlosLot	:= 0
	local nVlrLibeLot	:= 0
	Local cObs := ""
	Local cStTiss		:= ""
	Local cCnpjOpe		:= ""
	Local cCnpjCpf		:= ""
	Local lFirst		:= .T.
	Local lFecha		:= .F.
	Local nVal21		:= 0
	Local nVal22		:= 0
	Local nVal23		:= 0
	Local nVal24		:= 0
	Local aAuxDebCre	:= {}
	Local nVal29		:= 0
	Local nVal30		:= 0
	Local nVal31		:= 0
	Local nTotProtInf	:= 0
	Local nTotProtPro	:= 0
	Local nTotProtGlo	:= 0
	Local nTotProtFra	:= 0
	Local nTotProtLib	:= 0
	Local nTotCred		:= 0
	Local nTotDeb		:= 0
	Local nTotGerInf	:= 0
	Local nTotGerPro	:= 0
	Local nTotGerGlo	:= 0
	Local nTotGerFra	:= 0
	Local nTotGerLib	:= 0
	Local cCartBen		:= ""
	local cTpRec := ""
	local aMatCab  := nil
	local aMatItem := nil
	local nVlrTRec := 0
	local nVlrTAca := 0
	local nTam := 0
	DEFAULT cEncod	:= "ISO-8859-1"
	DEFAULT lFault   	:= .F.
	DEFAULT cCodErro 	:= "9999"
	DEFAULT cDesErro 	:= ""
	DEFAULT cObsErro 	:= ""
	DEFAULT cFTmp    	:= cFileTmp
	DEFAULT cRdaOri  	:= PlsIntPad()
	DEFAULT lOnL	  	:= lOnline
	DEFAULT cDirOnline	:= cDirOnl
	Default aDadRel		:= {}

// Implementa mensagens informativas
	If !lFault

		For nI:=1 To Len(aResultado)

		// Pega mensagens informativas
			If aResultado[nI,2] == 2
				If !Empty(aResultado[nI,1])
					cObsErro += AllTrim(aResultado[nI,1])+", "
				EndIf
			//seleciona sempre o primeiro codigo de erro que encontrar
				If !Empty(aResultado[nI,5]) .AND. Empty(cCodErro)
					cCodErro := aResultado[nI,5]
				EndIf

		// Pega erro no processamento
			ElseIf aResultado[nI,2] == 4
				If !Empty(aResultado[nI,1])
					cDesErro += AllTrim(aResultado[nI,1])+", "
				EndIf
			//seleciona sempre o primeiro codigo de erro que encontrar
				If !Empty(aResultado[nI,5]) .AND. Empty(cCodErro)
					cCodErro := aResultado[nI,5]
				EndIf
			EndIf
		Next

		cDesErro := AllTrim(SubStr(Left(cDesErro,Len(cDesErro)-2),1,500))
		cObsErro := AllTrim(SubStr(Left(cObsErro,Len(cObsErro)-2),1,240))

	// Se existe mensagem de erro
		If !Empty(cDesErro)
			lFault := .T.
		EndIf

	// Titulo do erro
		If Empty(cDesErro) .And. !Empty(cObsErro)
			lFaultLoc:= .T.
			cDesErro := "Mensagem Informativa"
		ElseIf !Empty(cDesErro) .And. Empty(cObsErro)
			cObsErro := "Observacao nao informada"
		EndIf

	// Pega somente os dados
		aRet := aRetZ[1]
	EndIf

// Redefine Variaveis
	cNumeLot := cNumeSeq
	cRda	 := cRdaOri
	cFileTmp := cFTmp
	lOnline  := lOnL

// Se for on-line redefino as pastas
	If lOnL .And. At(cDirOnline,cDirProce)==0
		cDirOnl		:= cDirOnline
		cDirCaiEn	:= StrTran(cDirCaiEn,cDirRaiz,cDirRaiz+cDirOnl)
		cDirCaiSa	:= StrTran(cDirCaiSa,cDirRaiz,cDirRaiz+cDirOnl)
		cDirProce	:= StrTran(cDirProce,cDirRaiz,cDirRaiz+cDirOnl)
		cDirNaPro  	:= StrTran(cDirNaPro,cDirRaiz,cDirRaiz+cDirOnl)
		cDirLog		:= StrTran(cDirLog,cDirRaiz,cDirRaiz+cDirOnl)
	EndIf

//Dados que nao devem ser diferentes
	If !lFault .And. !Len(aDadRel) > 0
		If Len(aRet) > 0 .And. Len(aRet[1]) >= 2
			cTpCab   := AllTrim(aRet[1,1,1])
			cCCCab	 := AllTrim(aRet[1,1,2])
			
			if Len(aRet[1][1]) >= 9
				cNumeLot := AllTrim(aRet[1,1,9])
				if Len(aRet[1][1]) >= 13
					cNumeSeq := AllTrim(aRet[1,1,13])
					if Len(aRet[1][1]) >= 15
						cRdaOri	 := AllTrim(aRet[1,1,15])
					EndIf
				EndIf
			EndIf
		EndIf
	Else
		If Len(aRetZ) > 0 .And. Len(aRetZ[1]) > 0
			cTpCab   := AllTrim(aRetZ[1,1,1,1])
			cCCCab	 := AllTrim(aRetZ[1,1,1,2])
			
			if Len(aRetZ[1][1]) >= 9
				cNumeLot := AllTrim(aRetZ[1,1,1,9])
				if Len(aRetZ[1][1][1]) >= 13
					cNumeSeq := AllTrim(aRetZ[1,1,1,13])
					if Len(aRetZ[1][1][1]) >= 15
						cRdaOri	 := AllTrim(aRetZ[1,1,1,15])
					EndIf
				EndIf
			EndIf
		EndIf
	EndIf

//Ajusta Data
	cData := U_CBXMLDTV(cData)

// Dados da Operadora
	BA0->( DbSetOrder(1) ) //BA0_FILIAL+BA0_CODIDE+BA0_CODINT
	BA0->( MsSeek( xFilial("BA0")+PlsIntPad() ) )

// Raiz Mais Cabecalho
	Cabecalho(cEncod,cTranRet,cNumeSeq,cData,cTime,lFault,lFaultLoc,cCodErro,cDesErro,cObsErro,AllTrim(BA0->BA0_SUSEP),cTpCab,cCCCab,cVersao,cOrigem,cTagOri)

// Dados tag principal com base no conteudo ctagret
	If (!lFault .AND. TISVERS < "3") .OR. (!lFaultLoc .AND. !lFault .AND. TISVERS >= "3")

	//Dados do corpo do xml
		Do Case

		//Dados do LOTEGUIAS
		Case cTranRet == "PROTOCOLO_RECEBIMENTO"

			//Processa guia por guia
			For nI:=1 To Len(aRet)
				aMatCri	    := {}
				aMatAux     := {}
				aMatCri 	:= {}
				aMatAut 	:= {}
				aMatNeg 	:= {}

				cRda 	 	:= AllTrim(aRet[nI,1,3])
				cNomeRda 	:= AllTrim(aRet[nI,1,4])
				cTpPessoa	:= AllTrim(aRet[nI,1,5])
				cCPFCGC	 	:= AllTrim(aRet[nI,1,6])
				cMatric 	:= aRet[nI,1,7]
				cNomeUsu	:= aRet[nI,1,8]
				cNumGui  	:= aRet[nI,1,10]
				If Len(aRet[nI,1]) > 16
					cValTot 	:= Alltrim(Str(aRet[nI,1,17]))
				Else
					cValTot 	:= "0"
				EndIf
				If Len(aRet[nI,1]) > 17
					cAtenRN 	:= AllTrim(aRet[nI,1,18])
				Else
					cAtenRN 	:= "N"
				EndIf


				//Matriz de processamento
				If Len(aRet[nI,2])>0
					cNumAut 	:= aRet[nI,2,2] 	//Numero da Autorizacao
					cNumSen 	:= aRet[nI,2,3] 	//Senha

					//Matric dados,itens e criticas
					aMatCri 	:= aRet[nI,2,4] 	//Criticas
					aMatAut 	:= aRet[nI,2,5] 	//Autorizados
					aMatNeg 	:= aRet[nI,2,6] 	//Negados

					// Ajusta criticas
					aMatAux := AjCriticas(aMatCri)
					aMatCri := aMatAux[1]
					lCriCab := aMatAux[2]
				Else
					lFault := .T.
				EndIf

				// Se o retorno do processamento foi ok
				If !lFault

					// Inclui somente uma vez
					If lInc

						// Raiz da Resposta
						CorpoRaiz(cTranRet,cTagRet,.T.)

						// Sub Raiz
						u_CBGRVXML( "A","protocoloRecebimento" )

						If TISVERS < "3"


							// Protocolo
							u_CBGRVXML( "AF","numeroProtocoloRecebimento",cNumeLot )

							// DadosOperadora
							DadosOperadora("dadosOperadora")
						Else
							u_CBGRVXML( "AF","registroANS",AllTrim(BA0->BA0_SUSEP) )
						EndIf

						// DadosPrestador
						DadosPrestador("dadosPrestador",cTpPessoa,cCPFCGC,cNomeRda,cRda)

						u_CBGRVXML( "AF","numeroLote",cNumeLot )
						u_CBGRVXML( "AF","dataEnvioLote",cData )
						If TISVERS < "3"
							u_CBGRVXML( "A","mensagemDetalheProtocolo" )
							u_CBGRVXML( "AF","numeroProtocolo",cNumeLot )
							u_CBGRVXML( "A","guias" )
						Else
							u_CBGRVXML( "A","detalheProtocolo" )
							u_CBGRVXML( "AF","numeroProtocolo",cNumeLot )
							u_CBGRVXML( "AF","valorTotalProtocolo",cValTot )
							u_CBGRVXML( "A","dadosGuiasProtocolo" )
						EndIf
						lInc := .F.
					EndIf


					// Msg de Protocolo
					u_CBGRVXML( "A","dadosGuia" + IIf(TISVERS >= "3", "s","" ))
					u_CBGRVXML( "AF","numeroGuiaPrestador",cNumGui )
					If !Empty(cNumAut)
						u_CBGRVXML( "AF","numeroGuiaOperadora",cNumAut )
					EndIf

					// Beneficiario
					Beneficiario("dadosBeneficiario",cMatric,cNomeUsu, cAtenRN)

					// Data realizacao
					u_CBGRVXML( "AF","dataRealizacao",cData )


					// Opcional somente se tiver critica da nota
					If lCriCab .AND. TISVERS >= "3"
						For nY:=1 To Len(aMatCri)
							Glosa("glosaGuia",aMatCri[nY,2],aMatCri[nY,3])
						Next
					EndIf


					// Matriz de procedimentos
					u_CBGRVXML( "A",IIf(TISVERS >= "3", "procedimentosRealizados","procedimentos" ) )

						// Procedimentos Autorizados
					For nY:=1 To Len(aMatAut)
						u_CBGRVXML( "A",IIf(TISVERS >= "3", "procedimentoRealizado","dadosProcedimento" ) )
						If TISVERS >= "3"
							u_CBGRVXML( "AF","dataExecucao", cData )
						EndIf

						cSlvPad := If(Len(aMatAut[nY])>=10,aMatAut[nY][10],'')
						cSlvPro := If(Len(aMatAut[nY])>=10,aMatAut[nY][11],'')
						Procedimento("procedimento",aMatAut[nY,3],aMatAut[nY,2],nil,aMatAut[nY,5],cVersao,cSlvPad,cSlvPro)

						u_CBGRVXML( "AF","quantidadeExecutada",AllTrim( Str( aMatAut[nY,6] ) ) )

						If TISVERS >= "3"
							nVlrUnit := u_C973VlrPro(cRda,aMatAut[nY,2],aMatAut[nY,3],cMatric)
							u_CBGRVXML( "AF","valorUnitario", Str(nVlrUnit))
							u_CBGRVXML( "AF","valorTotal", Str(nVlrUnit * aMatAut[nY,6]))
						EndIf
						u_CBGRVXML( "F",IIf(TISVERS >= "3", "procedimentoRealizado","dadosProcedimento" ) )
					Next

						// Matriz de procedimentos negados
					For nY:=1 To Len(aMatNeg)
						u_CBGRVXML( "A",IIf(TISVERS >= "3", "procedimentoRealizado","dadosProcedimento" ) )
						If TISVERS >= "3"
							u_CBGRVXML( "AF","dataExecucao", cData )
						EndIf
						cSlvPad := If(Len(aMatNeg[nY])>=10,aMatNeg[nY][10],'')
						cSlvPro := If(Len(aMatNeg[nY])>=10,aMatNeg[nY][11],'')
						Procedimento("procedimento",aMatNeg[nY,3],aMatNeg[nY,2],nil,aMatNeg[nY,5],cVersao,cSlvPad,cSlvPro)

						u_CBGRVXML( "AF","quantidadeExecutada","0" )

						If TISVERS >= "3"
							u_CBGRVXML( "AF","valorUnitario", "0")
							u_CBGRVXML( "AF","valorTotal", "0")
						EndIf

								// Se nao for critica de sistema
						If !lCriCab

									// Procura a critica correspondente
							If ( nPos := aScan(aMatCri,{|x|x[1] == AllTrim(aMatNeg[nY,1]+aMatNeg[nY,3]) } ) ) > 0
								u_CBGRVXML( "A",IIf(TISVERS >= "3", "glosasProcedimento","relacaoGlosa" ) )
								While ( nPos := aScan(aMatCri,{|x|x[1] == AllTrim(aMatNeg[nY,1]+aMatNeg[nY,3]) } ) ) > 0
									aMatCri[nPos,1] := "*"+aMatCri[nPos,1]

									If TISVERS >= "3"
										u_CBGRVXML( "A","motivoGlosa" )
										u_CBGRVXML( "AF","codigoGlosa",aMatCri[nPos,2] )
										u_CBGRVXML( "AF","descricaoGlosa",aMatCri[nPos,3] )
										u_CBGRVXML( "F","motivoGlosa" )
									Else
										Glosa("tipoGlosa",aMatCri[nPos,2],aMatCri[nPos,3])
									EndIf
								EndDo
								If TISVERS >= "3"
									u_CBGRVXML( "AF","valorGlosaProcedimento", "0")
								EndIf
								u_CBGRVXML( "F",IIf(TISVERS >= "3", "glosasProcedimento","relacaoGlosa" ) )
							EndIf
						EndIf
						u_CBGRVXML( "F",IIf(TISVERS >= "3", "procedimentoRealizado","dadosProcedimento" ) )
					Next
					u_CBGRVXML( "F",IIf(TISVERS >= "3", "procedimentosRealizados","procedimentos" ) )

					// Opcional somente se tiver critica da nota
					If lCriCab .AND. TISVERS < "3"
						For nY:=1 To Len(aMatCri)
							Glosa("codigoGlosaGuia",aMatCri[nY,2],aMatCri[nY,3])
						Next
					EndIf
					u_CBGRVXML( "F","dadosGuia" + IIf(TISVERS >= "3", "s","" ))
				EndIf
			Next
			If !lFault
				If !lInc
					u_CBGRVXML( "F","guias" )
					u_CBGRVXML( "F","mensagemDetalheProtocolo" )
					u_CBGRVXML( "F","protocoloRecebimento" )
				EndIf
			EndIf

		//Dados do Solicitacao de Servico e Status Autorizacao
		Case cTranRet $ "RESPOSTA_SOLICITACAO,STATUS_AUTORIZACAO,AUTORIZACAOPROCEDIMENTO"

			//Processa guia por guia
			For nI:=1 To Len(aRet)

				//Carga dos Dados
				aMatCri	    := {}
				aMatAux     := {}
				aMatCri 	:= {}
				aMatAut 	:= {}
				aMatNeg 	:= {}

				cRda 	 	:= AllTrim(aRet[nI,1,3])
				cNomeRda 	:= AllTrim(aRet[nI,1,4])
				cTpPessoa	:= AllTrim(aRet[nI,1,5])
				cCPFCGC	 	:= AllTrim(aRet[nI,1,6])
				If Len(aRet[nI,1]) >= 16
					cCNES	 	:= AllTrim(aRet[nI,1,16])
				Else
					cCNES	 	:= ''
				Endif
				cMatric 	:= aRet[nI,1,7]
				cNomeUsu	:= aRet[nI,1,8]
				cNumGui  	:= aRet[nI,1,10]
				dDatPro		:= aRet[nI,1,14]     //Data Procedimento
				cAteRN 		:= ""
				If Len(aRet[nI,1]) >= 18
					cAteRN 	:= AllTrim(aRet[nI,1,18])
				Endif

				//Matriz de processamento
				If Len(aRet[nI,2])> 0
					cNumAut 	:= aRet[nI,2,2] 	//Numero da Autorizacao
					cNumSen 	:= aRet[nI,2,3] 	//Senha

					//Matric dados,itens e criticas
					aMatCri 	:= aRet[nI,2,4] 	//Criticas
					aMatAut 	:= aRet[nI,2,5] 	//Autorizados
					aMatNeg 	:= aRet[nI,2,6] 	//Negados

					// Ajusta criticas
					aMatAux := AjCriticas(aMatCri)
					aMatCri := aMatAux[1]
				Else
					lFault := .T.
				EndIf

				// Se o retorno do processamento foi ok
				If !lFault

					// Inclui somente uma vez
					If lInc

						// Raiz da Resposta
						cTagAux := CorpoRaiz(cTranRet,cTagRet,.T.)
						lInc := .F.
					EndIf

					//Autorizacao de Servico
					u_CBGRVXML( "A",cTagAux )
					If (TISVERS < "3")

							// IdentificacaoAutorizacao
						IdentAutorizacao("identificacaoAutorizacao",DtoS(dDatPro),cNumGui,cNumAut)

							// Beneficiario
						Beneficiario("beneficiario",cMatric,cNomeUsu)

							// DadosPrestador
						DadosPrestador("prestadorAutorizado",cTpPessoa,cCPFCGC,cNomeRda,cRda)

							// Informa a Senha da autorizacao
						If !Empty(cNumSen)
							u_CBGRVXML( "A","dadosAutorizacao" )
							u_CBGRVXML( "AF","senhaAutorizacao",cNumSen )
							u_CBGRVXML( "F","dadosAutorizacao" )
						EndIf

							// Procedimentos
						If Len(aMatAut)>0 .Or. Len(aMatNeg) > 0
							u_CBGRVXML( "A","procedimentos" )

									// Procedimentos Autorizados
							For nY:=1 To Len(aMatAut)
								u_CBGRVXML( "A","procedimento" )

								cSlvPad := If(Len(aMatAut[nY])>=10,aMatAut[nY][10],'')
								cSlvPro := If(Len(aMatAut[nY])>=10,aMatAut[nY][11],'')
								Procedimento("identificacaoProcedimentos",aMatAut[nY,3],aMatAut[nY,2],nil,aMatAut[nY,5],cVersao,cSlvPad,cSlvPro)

								u_CBGRVXML( "AF","quantidadeSolicitada",AllTrim( Str( aMatAut[nY,4] ) ) )
								u_CBGRVXML( "AF","quantidadeAutorizada",AllTrim( Str( aMatAut[nY,6] ) ) )
								u_CBGRVXML( "AF","statusSolicitacaoProcedimento","1" )

											// Ponto de Entrada PLSOBSXML para manipulação da TAG de Observação do XML
								If Existblock("PLSOBSXML")
									cObs := ExecBlock("PLSOBSXML",.F.,.F.,{aRet})
								Endif

								If !Empty(cObs)
									u_CBGRVXML( "AF","observacao",AllTrim(cObs) )
								Endif
								u_CBGRVXML( "F","procedimento" )
							Next

									// Matriz de procedimentos negados
							For nY:=1 To Len(aMatNeg)

								u_CBGRVXML( "A","procedimento" )

								cSlvPad := If(Len(aMatNeg[nY])>=10,aMatNeg[nY][10],'')
								cSlvPro := If(Len(aMatNeg[nY])>=10,aMatNeg[nY][11],'')
								Procedimento("identificacaoProcedimentos",aMatNeg[nY,3],aMatNeg[nY,2],nil,aMatNeg[nY,5],cVersao,cSlvPad,cSlvPro)

								u_CBGRVXML( "AF","quantidadeSolicitada",AllTrim( Str( aMatNeg[nY,4] ) ) )
								u_CBGRVXML( "AF","quantidadeAutorizada","0" )

								If aScan(aMatCri,{|x|x[1] == AllTrim(aMatNeg[nY,1]+aMatNeg[nY,3]) .And. x[4] == .T. } ) > 0
									cStatus := "2"	//"Em análise"
								Else
									cStatus := "3"	//"Negado"
								EndIf

								u_CBGRVXML( "AF","statusSolicitacaoProcedimento",cStatus )

											// Procura a critica correspondente
								If ( nPos := aScan(aMatCri,{|x|x[1] == AllTrim(aMatNeg[nY,1]+aMatNeg[nY,3]) } ) ) > 0
									u_CBGRVXML( "A","glosas" )
									While ( nPos := aScan(aMatCri,{|x|x[1] == AllTrim(aMatNeg[nY,1]+aMatNeg[nY,3]) } ) ) > 0
										aMatCri[nPos,1] := "*"+aMatCri[nPos,1]
										Glosa("motivoGlosa",aMatCri[nPos,2],aMatCri[nPos,3])
									EndDo
									u_CBGRVXML( "F","glosas" )
								EndIf
								u_CBGRVXML( "F","procedimento" )
							Next
							u_CBGRVXML( "F","procedimentos" )
						EndIf
					Else
						If (nPO:= aScan(aDados,{|x| 'SP_SADT' $ alltrim(x[1]) })) > 0
							cTipGui := '02'
						Elseif (nPO:= aScan(aDados,{|x| 'INTERNACAO' $ alltrim(x[1]) })) > 0
							cTipGui := '03'
						Endif

						//If cTipGui $ '02'
						//	u_CBGRVXML( "A","autorizacaoServico" )
						//ElseIF 
						If cTipGui $ '03'
							u_CBGRVXML( "A","autorizacaoInternacao" )
						ElseIF cTipGui $ '01' .AND. cTagAux != "autorizacaoServico"
							u_CBGRVXML( "A","autorizacaoServico" )
						Endif

						If cTipGui $ '03'
							u_CBGRVXML( "A","autorizacaoDosServicos" )
						Endif

						DadosAutorizacao("dadosAutorizacao", cNumGui, cNumAut, cNumSen)
						If Empty(cAteRN)
							If (nPO:= aScan(aDados,{|x| alltrim(x[1]) == 'ATENDIMENTORN'})) > 0
								cAteRn := aDados[nPO][2]
							Else
								cAteRn := 'N'
							Endif
						Endif
						Beneficiario("dadosBeneficiario",cMatric,cNomeUsu,cAteRn)

						u_CBGRVXML( "A","prestadorAutorizado" )
						DadosPrestador("dadosContratado",cTpPessoa,cCPFCGC,cNomeRda,cRda)
						u_CBGRVXML( "AF","cnesContratado", If (Empty(cCNES), "9999999", cCNES))
						u_CBGRVXML( "F","prestadorAutorizado" )

						If (Len(aMatNeg) > 0)
							If aScan(aMatCri,{|x| x[4] == .T. } ) > 0
								cStatus := "2"	//"Em análise"
							Else
								cStatus := "3"	//"Negado"
							EndIf

							u_CBGRVXML( "AF","statusSolicitacao",cStatus )
						Else
							u_CBGRVXML( "AF","statusSolicitacao","1" )
						EndIf

						If (Len(aMatNeg) > 0 .OR. Len(aMatAut)>0)
							u_CBGRVXML( "A","servicosAutorizados" )
							If (Len(aMatNeg) > 0)

									// Matriz de procedimentos negados
								For nY:=1 To Len(aMatNeg)
								//	u_CBGRVXML( "A","servicosAutorizados" )
									u_CBGRVXML( "A","servicoAutorizado" )

									cSlvPad := If(Len(aMatNeg[nY])>=10,aMatNeg[nY][10],'')
									cSlvPro := If(Len(aMatNeg[nY])>=10,aMatNeg[nY][11],'')
									Procedimento("procedimento",aMatNeg[nY,3],aMatNeg[nY,2],nil,aMatNeg[nY,5],cVersao,cSlvPad,cSlvPro)

									u_CBGRVXML( "AF","quantidadeSolicitada",AllTrim( Str( aMatNeg[nY,4] ) ) )
									u_CBGRVXML( "AF","quantidadeAutorizada","0" )


											// Procura a critica correspondente
									u_CBGRVXML( "A", "motivosNegativa")
									If ( nPos := aScan(aMatCri,{|x|x[1] == AllTrim(aMatNeg[nY,1]+aMatNeg[nY,3]) } ) ) > 0
										While ( nPos := aScan(aMatCri,{|x|x[1] == AllTrim(aMatNeg[nY,1]+aMatNeg[nY,3]) } ) ) > 0
											aMatCri[nPos,1] := "*"+aMatCri[nPos,1]
											Glosa("motivoNegativa",aMatCri[nPos,2],aMatCri[nPos,3])
										EndDo
									EndIf
									u_CBGRVXML( "F", "motivosNegativa")

									u_CBGRVXML( "F","servicoAutorizado" )
								//	u_CBGRVXML( "F","servicosAutorizados" )
								Next

							EndIf

							If (Len(aMatAut)>0)

									// Procedimentos Autorizados

								For nY:=1 To Len(aMatAut)
								//	u_CBGRVXML( "A","servicosAutorizados" )
									u_CBGRVXML( "A","servicoAutorizado" )


									cSlvPad := If(Len(aMatAut[nY])>=10,aMatAut[nY][10],'')
									cSlvPro := If(Len(aMatAut[nY])>=10,aMatAut[nY][11],'')
									Procedimento("procedimento",aMatAut[nY,3],aMatAut[nY,2],,aMatAut[nY,5],cVersao,cSlvPad,cSlvPro)

									u_CBGRVXML( "AF","quantidadeSolicitada",AllTrim( Str( aMatAut[nY,4] ) ) )
									u_CBGRVXML( "AF","quantidadeAutorizada",AllTrim( Str( aMatAut[nY,6] ) ) )

									u_CBGRVXML( "F","servicoAutorizado" )
								//	u_CBGRVXML( "F","servicosAutorizados" )
								Next

							EndIf
							u_CBGRVXML( "F","servicosAutorizados" )

							If Existblock("PLSOBSXML")
								cObs := ExecBlock("PLSOBSXML",.F.,.F.,{aRet})
							Endif
							If !Empty(cObs)
								u_CBGRVXML( "AF","observacao",AllTrim(cObs) )
							Endif
						EndIf
						If cTipGui $ '03'
							u_CBGRVXML( "F","autorizacaoDosServicos" )
						Endif

						//If cTipGui $ '02'
						//	u_CBGRVXML( "F","autorizacaoServico" )
						//ElseIF cTipGui $ '03'
						If cTipGui $ '03'
							u_CBGRVXML( "F","autorizacaoInternacao" )
						Else
							u_CBGRVXML( "F","autorizacaoServico" )
						Endif


					EndIf

					//Autorizacao de Servico
					u_CBGRVXML( "F",cTagAux )
				EndIf
			Next

		//Dados do Solicitacao de Servico e Status Autorizacao
		Case cTranRet $ "SITUACAO_PROTOCOLO"

			//Processa guia por guia
			For nI:=1 To Len(aRet)

				//Carga dos Dados
				aMatCri	    := {}
				aMatAux     := {}
				aMatCri 	:= {}
				aMatAut 	:= {}
				aMatNeg 	:= {}

				cRda 	 	:= AllTrim(aRet[nI,1,3])
				cNomeRda 	:= AllTrim(aRet[nI,1,4])
				cTpPessoa	:= AllTrim(aRet[nI,1,5])
				cCPFCGC	 	:= AllTrim(aRet[nI,1,6])
				cNumGui  	:= aRet[nI,1,10]

				cMatric 	:= aRet[nI,1,7]
				cNomeUsu	:= aRet[nI,1,8]
				cNumeLot 	:= AllTrim(aRet[nI,1,9])
				cNumeSeq 	:= AllTrim(aRet[nI,1,13])
				dDatPro		:= aRet[nI,1,14]     //Data de envio do lote de guias de cobrança para a operadora

				//Matriz de processamento
				If Len(aRet[nI,2])>0
					cNumAut 	:= aRet[nI,2,2] 	//Numero da Autorizacao

					//Matric dados,itens e criticas
					aMatCri 	:= aRet[nI,2,4] 	//Criticas
					aMatAut 	:= aRet[nI,2,5] 	//Autorizados
					aMatNeg 	:= aRet[nI,2,6] 	//Negados

					// Ajusta criticas
					aMatAux := AjCriticas(aMatCri)
					aMatCri := aMatAux[1]

					// Valores do Protocolo, Guia
					aValores := aRet[nI,2,11]
					//1 Valor Processado Guia
					//2 Valor Liberado Guia
					//3 Valor Glosa Guia
					//4 Valor Processado Fatura
					//5 Valor Liberado Fatura
					//6 Valor Glosa Fatura
					//7 Valor Processado Protocolo
					//8 Valor Liberado Protocolo
					//9 Valor Glosa Protocolo
				Else
					lFault := .T.
				EndIf

				// Se o retorno do processamento foi ok
				If !lFault

					// Inclui somente uma vez
					If lInc

						// Raiz da Resposta
						CorpoRaiz(cTranRet,cTagRet,.T.)


						// DadosOperadora
						If (TISVERS < "3")
							DadosOperadora("identificacaoFontePagadora")
						Else
							u_CBGRVXML( "A", cTagRet)
							u_CBGRVXML( "AF","identificacaoOperadora",AllTrim(BA0->BA0_SUSEP) )
						EndIf

						// DadosPrestador
						DadosPrestador("dadosPrestador",cTpPessoa,cCPFCGC,cNomeRda,cRda)

						u_CBGRVXML( "A","lote" )
						lInc := .F.
					EndIf
					If (TISVERS < "3")

						// Detalhe do lote
						If cNumeLot <> cNumeAux
							cNumeAux := cNumeLot
							u_CBGRVXML( "A","detalheLote" )

							u_CBGRVXML( "AF","numeroProtocolo",cNumeLot )
							u_CBGRVXML( "AF","numeroLote",cNumeLot )
							cData := DtoS(dDatPro)
							cData := U_CBXMLDTV(cData)
							u_CBGRVXML( "AF","dataEnvioLote",cData )
							u_CBGRVXML( "AF","status",Iif( Len(aMatAut)==0 .And. Len(aMatNeg)==0,"7",Iif(Len(aMatNeg)>0,"2","1") ) )

							u_CBGRVXML( "A","guias")
						EndIf

						// Todos as guias do lote
						If Len(aMatAut)>0 .Or. Len(aMatNeg)>0
							u_CBGRVXML( "A","detalheguiaMedica")

								// Identificacao guia
							u_CBGRVXML( "A","identificacaoGuia")
							u_CBGRVXML( "AF","registroANS",AllTrim(BA0->BA0_SUSEP) )
							cData := DtoS(dDatPro)
							cData := U_CBXMLDTV(cData)
							u_CBGRVXML( "AF","dataEmissaoGuia", cData )
							u_CBGRVXML( "AF","numeroGuiaPrestador",cNumGui )
							If !Empty(cNumAut)
								u_CBGRVXML( "AF","numeroGuiaOperadora",cNumAut )
							EndIf
							u_CBGRVXML( "F","identificacaoGuia")

								// Procedimentos
							u_CBGRVXML( "A","procedimentosAnalisados" )

									// Procedimentos Autorizados
							For nY:=1 To Len(aMatAut)
								u_CBGRVXML( "A","procedimento" )

								cSlvPad := If(Len(aMatAut[nY])>=10,aMatAut[nY][10],'')
								cSlvPro := If(Len(aMatAut[nY])>=10,aMatAut[nY][11],'')

								Procedimento("identificacaoProcedimentos",aMatAut[nY,3],aMatAut[nY,2],nil,aMatAut[nY,5],cVersao,cSlvPad,cSlvPro)

								u_CBGRVXML( "AF","quantidadeSolicitada",AllTrim( Str( aMatAut[nY,4] ) ) )
								u_CBGRVXML( "AF","quantidadeAutorizada",AllTrim( Str( aMatAut[nY,6] ) ) )
								u_CBGRVXML( "AF","statusSolicitacaoProcedimento","1" )
								u_CBGRVXML( "F","procedimento" )
							Next

									// Matriz de procedimentos negados
							For nY:=1 To Len(aMatNeg)

								u_CBGRVXML( "A","procedimento" )

								cSlvPad := If(Len(aMatNeg[nY])>=10,aMatNeg[nY][10],'')
								cSlvPro := If(Len(aMatNeg[nY])>=10,aMatNeg[nY][11],'')

								Procedimento("identificacaoProcedimentos",aMatNeg[nY,3],aMatNeg[nY,2],nil,aMatNeg[nY,5],cVersao,cSlvPad,cSlvPro)

								u_CBGRVXML( "AF","quantidadeSolicitada",AllTrim( Str( aMatNeg[nY,4] ) ) )
								u_CBGRVXML( "AF","quantidadeAutorizada", "0")

								If aScan(aMatCri,{|x|x[1] == AllTrim(aMatNeg[nY,1]+aMatNeg[nY,3]) .And. x[4] == .T. } ) > 0
									cStatus := "2"	//"Em análise"
								Else
									cStatus := "3"	//"Negado"
								EndIf

								u_CBGRVXML( "AF","statusSolicitacaoProcedimento",cStatus )

											// Procura a critica correspondente
								If ( nPos := aScan(aMatCri,{|x|x[1] == AllTrim(aMatNeg[nY,1]+aMatNeg[nY,3]) } ) ) > 0
									u_CBGRVXML( "A","glosas" )
									While ( nPos := aScan(aMatCri,{|x|x[1] == AllTrim(aMatNeg[nY,1]+aMatNeg[nY,3]) } ) ) > 0
										aMatCri[nPos,1] := "*"+aMatCri[nPos,1]
										Glosa("motivoGlosa",aMatCri[nPos,2],aMatCri[nPos,3])
									EndDo
									u_CBGRVXML( "F","glosas" )
								EndIf
								u_CBGRVXML( "F","procedimento" )
							Next
							u_CBGRVXML( "F","procedimentosAnalisados" )
							u_CBGRVXML( "F","detalheguiaMedica")
						EndIf


						//Fecha o lote
						If Len(aRet)>=(nI+1)
							If AllTrim(aRet[nI+1,1,9]) <> cNumeAux
								u_CBGRVXML( "F","guias")
								u_CBGRVXML( "F","detalheLote" )
							EndIf
						Else
							u_CBGRVXML( "F","guias")
							u_CBGRVXML( "F","detalheLote" )
						EndIf
					Else
						If cNumeLot <> cNumeAux
							cNumeAux := cNumeLot

							u_CBGRVXML( "A", "detalheLote")
							if(len(aRet[nI,1]) > 18) .AND. !Empty(aRet[nI,1,19])
								u_CBGRVXML( "AF","statusProtocolo", aRet[nI,1,19])
							else
								u_CBGRVXML( "AF","statusProtocolo",Iif( Len(aMatAut)==0 .And. Len(aMatNeg)==0,"7",Iif(Len(aMatNeg)>0,"2","1") ) )
							endif
							u_CBGRVXML( "AF","numeroProtocolo",cNumeLot )
							u_CBGRVXML( "AF","numeroLote",cNumeLot )

							cData := DtoS(dDatPro)
							cData := U_CBXMLDTV(cData)
							u_CBGRVXML( "AF","dataEnvioLote",cData )

							nVlrProcLot := 0
							nVlrGlosLot := 0
							nVlrLibeLot := 0
							For nY := 1 To Len(aRet)
								If cNumeLot == AllTrim(aRet[nY,1,9])
									nVlrProcLot	+= aRet[nY,2,11,1]
									nVlrGlosLot	+= aRet[nY,2,11,3]
									nVlrLibeLot += aRet[nY,2,11,2]
								EndIf
							Next

							ValorTotal("valorTotalLote",Str(nVlrProcLot),Str(nVlrGlosLot),Str(nVlrLibeLot))

							u_CBGRVXML( "A", "guiasTISS")
						EndIf

						u_CBGRVXML( "A", "guiasMedicas")
						u_CBGRVXML( "A", "guias")

						u_CBGRVXML( "AF","numeroGuiaPrestador",cNumGui )
						If !Empty(cNumAut)
							u_CBGRVXML( "AF","numeroGuiaOperadora",cNumAut )
						EndIf
						Beneficiario("dadosBeneficiario",cMatric,cNomeUsu,"N")

						u_CBGRVXML( "AF", "dataRealizacao", cData)
						ValorTotal("vlInformadoGuia",Str(aValores[1]),Str(aValores[3]),Str(aValores[2]))

						If Len(aMatAut)>0 .Or. Len(aMatNeg)>0
							u_CBGRVXML( "A", "procedimentosRealizados")


									// Procedimentos Autorizados
							For nY:=1 To Len(aMatAut)
								u_CBGRVXML( "A","procedimentoRealizado" )

								u_CBGRVXML( "AF","dataExecucao", "2013-01-01")

								cSlvPad := If(Len(aMatAut[nY])>=10,aMatAut[nY][10],'')
								cSlvPro := If(Len(aMatAut[nY])>=10,aMatAut[nY][11],'')

								Procedimento("procedimento",aMatAut[nY,3],aMatAut[nY,2],nil,aMatAut[nY,5],cVersao,cSlvPad,cSlvPro)

								u_CBGRVXML( "AF","quantidadeExecutada",AllTrim( Str( aMatAut[nY,6] ) ) )

								nVlrUnit := u_C973VlrPro(cRda,aMatAut[nY,2],aMatAut[nY,3],cMatric)
								u_CBGRVXML( "AF","valorUnitario", Str(nVlrUnit))
								u_CBGRVXML( "AF","valorTotal", Str(nVlrUnit * aMatAut[nY,6]))
								u_CBGRVXML( "F","procedimentoRealizado" )
							Next


									// Matriz de procedimentos negados
							For nY:=1 To Len(aMatNeg)

								u_CBGRVXML( "A","procedimentoRealizado" )

								u_CBGRVXML( "AF","dataExecucao", )

								cSlvPad := If(Len(aMatAut[nY])>=10,aMatAut[nY][10],'')
								cSlvPro := If(Len(aMatAut[nY])>=10,aMatAut[nY][11],'')
								Procedimento("procedimento",aMatNeg[nY,3],aMatNeg[nY,2],nil,aMatAut[nY,5],cVersao,cSlvPad,cSlvPro)

								u_CBGRVXML( "AF","quantidadeExecutada",AllTrim( Str( aMatNeg[nY,6] ) ) )

								nVlrUnit := u_C973VlrPro(cRda,aMatNeg[nY,2],aMatNeg[nY,3],cMatric)
								u_CBGRVXML( "AF","valorUnitario", Str(nVlrUnit))
								u_CBGRVXML( "AF","valorTotal", Str(nVlrUnit * aMatNeg[nY,6]))

											// Procura a critica correspondente
								If ( nPos := aScan(aMatCri,{|x|x[1] == AllTrim(aMatNeg[nY,1]+aMatNeg[nY,3]) } ) ) > 0
									u_CBGRVXML( "A","glosasProcedimento" )
									While ( nPos := aScan(aMatCri,{|x|x[1] == AllTrim(aMatNeg[nY,1]+aMatNeg[nY,3]) } ) ) > 0
										aMatCri[nPos,1] := "*"+aMatCri[nPos,1]
										Glosa("motivoGlosa",aMatCri[nPos,2],aMatCri[nPos,3])
									EndDo
									u_CBGRVXML( "AF","valorGlosaProcedimento", )
									u_CBGRVXML( "F","glosasProcedimento" )
								EndIf
								u_CBGRVXML( "F","procedimentoRealizado" )
							Next

							u_CBGRVXML( "F", "procedimentosRealizados")
						EndIf

						u_CBGRVXML( "F", "guias")
						u_CBGRVXML( "F", "guiasMedicas")

						If Len(aRet)>=(nI+1)
							If AllTrim(aRet[nI+1,1,9]) <> cNumeAux
								u_CBGRVXML( "F", "guiasTISS")
							EndIf
						Else

							u_CBGRVXML( "F", "guiasTISS")
						EndIf
					EndIf
				EndIf
			Next
			If !lFault
				u_CBGRVXML( "F","detalheLote")
				u_CBGRVXML( "F","lote" )
				If (TISVERS >= "3")
					u_CBGRVXML( "F", cTagRet)
				EndIf
			EndIf

		//Dados do VERIFICA ELEGIBILIDADE
		Case cTranRet == "SITUACAO_ELEGIBILIDADE"
			cMatric 	:= aRet[1,1,7]
			cNomeUsu	:= aRet[1,1,8]

			// Raiz da Resposta
			If !lFault
				CorpoRaiz(cTranRet,cTagRet,.T.)

				If (TISVERS < "3")

					// DadosOperadora
					DadosOperadora("dadosOperadora")

					// Beneficiario
					Beneficiario("dadosBeneficiario",cMatric,cNomeUsu)

					// Resposta Solicitacao
					u_CBGRVXML( "AF","respostaSolicitacao",Iif(aRet[1,2,1],"true","false"),,,,.F. )
				Else
					u_CBGRVXML( "A", "reciboElegibilidade")

					// DadosOperadora
					u_CBGRVXML( "AF","registroANS",AllTrim(BA0->BA0_SUSEP) )

					// Beneficiario
					u_CBGRVXML( "AF","numeroCarteira",cMatric )
					u_CBGRVXML( "AF","nomeBeneficiario",cNomeUsu )

					// Resposta Solicitacao
					u_CBGRVXML( "AF","respostaSolicitacao",Iif(aRet[1,2,1],"S","N"),,,,.F. )
				EndIf

				// Pega as criticas
				If !Empty(aRet[1,2,4])
					aTrb := aRet[1,2,4]
					For nY := 1 To Len(aTrb)
						If !Empty(aTrb[nY,1])
							AaDd( aMatAux,{StrZero(nY,3),aTrb[nY,1],aTrb[nY,2],"",StrZero(nY,3),""} )
						EndIf
					Next
					aMatAux := AjCriticas(aMatAux)
					aMatCri := aMatAux[1]

					// Motivo da Negativa
					If Len(aMatCri)>=1
						If (TISVERS < "3")
							Glosa("motivoNegacao",aMatCri[1,2],aMatCri[1,3])
						Else
							Glosa("motivosNegativa_motivoNegativa",aMatCri[1,2],aMatCri[1,3])
						EndIf
					EndIf
				EndIf
				If !(TISVERS < "3")
					u_CBGRVXML( "F", "reciboElegibilidade")
				EndiF
			EndIf


		//Dados do Analise_CONTAS
		Case cTranRet == "DEMONSTRATIVO_ANALISE_CONTA"

			If (TISVERS >= "3")

    	//Até 30 Solicitações num único pedido, clono aDadRel e trabalho apenas com o vetor no momento
				IF (Len(aDadRel) = 0)  //verifico se é zero o retorno. Se sim, gerar apenas cabeçalho e sai da rotina
					CorpoRaiz(cTranRet,cTagRet,.T.)
				ELSE

					aMatAux := {}
					aMatAux := aClone(aDadRel)

					For nZ := 1 To Len (aMatAux)
						aDadRel := {}
						aAdd(aDadRel, aMatAux[nZ])
						IIF (nZ > 1, CorpoRaiz(cTranRet,cTagRet,.T.,.T.), CorpoRaiz(cTranRet,cTagRet,.T.,.F.))

						For nX := 1 To Len(aDadRel)
							If ValType(aDadRel[nX]) == 'U' .OR. Len(aDadRel[nX]) == 0
								Loop
							EndIf

							For nI := 23 To 33
								If Len(aDadRel[nX, nI]) < 1
									For nJ := Len(aDadRel[nX, nI]) + 1 To 5
										If AllTrim(Str(nI)) $ "23"
											aAdd(aDadRel[nX, nI], StoD(""))
										ElseIf AllTrim(Str(nI)) $ "28,29,30,31,32"
											aAdd(aDadRel[nX, nI], 0)
										Else
											aAdd(aDadRel[nX, nI], "")
										EndIf
									Next nJ
								EndIf
							Next nI

							For nX1 := 1 To Len(aDadRel[nX, 02])

		    			//Cabeçalho
								u_CBGRVXML( "A", "cabecalhoDemonstrativo" )
								u_CBGRVXML( "AF","registroANS", 				aDadRel[nX, 01] )
								u_CBGRVXML( "AF","numeroDemonstrativo", 		aDadRel[nX, 02, nX1] )
								u_CBGRVXML( "AF","nomeOperadora", 			aDadRel[nX, 03] )
								u_CBGRVXML( "AF","numeroCNPJ", 				STRTRAN(STRTRAN(STRTRAN(aDadRel[nX, 04],'.',''),'/',''),'-','') )
								u_CBGRVXML( "AF","dataEmissao", 				U_CBXMLDTV(DtoS(aDadRel[nX, 05, nX1])) )
								u_CBGRVXML( "F", "cabecalhoDemonstrativo" )


								u_CBGRVXML( "A", "dadosPrestador" )
								u_CBGRVXML( "A","dadosContratado" )
								IF (Len(aDadRel[nX, 06, nX1]) <= 6) //significa código
									u_CBGRVXML( "AF","codigoPrestadorNaOperadora", 		aDadRel[nX, 06, nX1] )
								ELSEIF (Len(aDadRel[nX, 06, nX1]) > 6 .AND. Len(aDadRel[nX, 06, nX1]) <= 11 )
									u_CBGRVXML( "AF","cpfContratado", 					STRTRAN(STRTRAN(aDadRel[nX, 06, nX1],'.',''),'-','') )
								ELSE
									u_CBGRVXML( "AF","cnpjContratado", 					STRTRAN(STRTRAN(STRTRAN(aDadRel[nX, 06, nX1],'.',''),'/',''),'-','') )
								ENDIF
								u_CBGRVXML( "AF","nomeContratado", 			aDadRel[nX, 07, nX1] )
								u_CBGRVXML( "F", "dadosContratado" )
								u_CBGRVXML( "AF","CNES", 			aDadRel[nX, 08, nX1] )
								u_CBGRVXML( "F", "dadosPrestador" )

								nInfGer := 0
								nProcGer := 0
								nLibGer  := 0
								nGloGer  := 0
								nInfFat := 0
								nProcFat := 0
								nLibFat  := 0
								nGloFat  := 0

								For nX2 := 1 To Len(aDadRel[nX, 9, nX1])

									//Dados do Lote/Protocolo*/
									u_CBGRVXML( "A","dadosConta" )
									u_CBGRVXML( "A","dadosProtocolo" )

									u_CBGRVXML( "AF","numeroLotePrestador",	aDadRel[nX, 9, nX1, nX2] )
									u_CBGRVXML( "AF","numeroProtocolo",		aDadRel[nX, 10, nX1, nX2] )
									u_CBGRVXML( "AF","dataProtocolo", 		U_CBXMLDTV(DtoS(aDadRel[nX, 11, nX1, nX2])) )

									IF (!Empty(aDadRel[nX, 12, nX1, nX2])) //Se preenchido, colocar código da glosa
										u_CBGRVXML( "A","GlosaProtocolo" )
										u_CBGRVXML( "AF","codigoGlosa", 			aDadRel[nX, 12, nX1, nX2] )
										u_CBGRVXML( "F","GlosaProtocolo" )
									ENDIF

									u_CBGRVXML( "AF","situacaoProtocolo", 	aDadRel[nX, 13, nX1, nX2] )

				//Dados da Guia
									For nX3 := 1 To Len(aDadRel[nX, 14, nX1,nX2])
										u_CBGRVXML( "A","relacaoGuias" )
					//Números de Guias e senhas
										u_CBGRVXML( "AF","numeroGuiaPrestador", 	aDadRel[nX, 14, nX1,nX2, nX3] )
										u_CBGRVXML( "AF","numeroGuiaOperadora", 	aDadRel[nX, 15,nX1, nX2, nX3] )
										u_CBGRVXML( "AF","senha", 				aDadRel[nX, 16, nX1,nX2, nX3] )
					//Dados do beneficiário
										u_CBGRVXML( "AF","nomeBeneficiario", 	aDadRel[nX, 17,nX1, nX2, nX3] )
										u_CBGRVXML( "AF","numeroCarteira", 		STRTRAN(STRTRAN(aDadRel[nX, 18, nX1,nX2, nX3],'.',''),'-','') )
								//Data e horas faturamento - Internação
								//Porém, no Schema da ANS é obrigatório informar a data de ionicio e os demais opcionais. Logo, se não for internação, passo a data atual
										IF ( Empty(aDadRel[nX, 19,nX1, nX2, nX3]) )
											u_CBGRVXML( "AF","dataInicioFat", U_CBXMLDTV(DtoS(dDatabase)) )
										ELSE
											u_CBGRVXML( "AF","dataInicioFat", U_CBXMLDTV(DtoS(aDadRel[nX, 19,nX1, nX2, nX3])) )
											u_CBGRVXML( "AF","horaInicioFat", aDadRel[nX, 20, nX1,nX2, nX3] )
											u_CBGRVXML( "AF","dataFimFat", U_CBXMLDTV(DtoS(aDadRel[nX, 21, nX1,nX2, nX3])) )
											u_CBGRVXML( "AF","horaFimFat", aDadRel[nX, 22, nX1,nX2, nX3] )
										ENDIF

										IF(!Empty(aDadRel[nX, 23, nX1,nX2, nX3]))
											u_CBGRVXML( "A","motivoGlosaGuia" )
											u_CBGRVXML( "AF","codigoGlosa", 			aDadRel[nX, 23, nX1,nX2, nX3] )
											u_CBGRVXML( "F","motivoGlosaGuia" )
										ENDIF

										u_CBGRVXML( "AF","situacaoGuia", 		aDadRel[nX, 24, nX1,nX2, nX3] )

						//Detalhes da Guia
										nInfGui := 0
										nProcGui := 0
										nLibGui  := 0
										nGloGui  := 0
										For nX4 := 1 To Len(aDadRel[nX, 25, nX1,nX2, nX3])
											u_CBGRVXML( "A","detalhesGuia" )
											u_CBGRVXML( "AF","dataRealizacao", 		IIf(Empty(aDadRel[nX, 25, nX1,nX2, nX3, nX4]), "", U_CBXMLDTV(DtoS(aDadRel[nX, 25, nX1,nX2, nX3, nX4]))) )

											u_CBGRVXML( "A","procedimento" )
											u_CBGRVXML( "AF","codigoTabela", 		aDadRel[nX, 26, nX1,nX2, nX3, nX4])
											u_CBGRVXML( "AF","codigoProcedimento", 	aDadRel[nX, 27, nX1,nX2, nX3, nX4])
											u_CBGRVXML( "AF","descricaoProcedimento",aDadRel[nX, 28, nX1,nX2, nX3, nX4])
											u_CBGRVXML( "F","procedimento" )

											IIF(!Empty(aDadRel[nX, 29, nX1,nX2, nX3, nX4]), u_CBGRVXML( "AF","grauParticipacao",		aDadRel[nX, 29, nX1,nX2, nX3, nX4]), "")
											u_CBGRVXML( "AF","valorInformado",		IIf(Empty(aDadRel[nX, 30, nX1, nX2, nX3, nX4]), "0.00", STRTRAN(Transform(aDadRel[nX, 30, nX1, nX2, nX3, nX4], "@E 999,999,999.99"),',','.')) )
											u_CBGRVXML( "AF","qtdExecutada",			IIf(Empty(aDadRel[nX, 31, nX1, nX2, nX3, nX4]), "", Transform(aDadRel[nX, 31, nX1, nX2, nX3, nX4], "@E 9999")) )
											u_CBGRVXML( "AF","valorProcessado",		IIf(Empty(aDadRel[nX, 32, nX1, nX2, nX3, nX4]), "", STRTRAN(Transform(aDadRel[nX, 32, nX1, nX2, nX3, nX4], "@E 999,999,999.99"),',','.')) )
											u_CBGRVXML( "AF","valorLiberado",		IIf(Empty(aDadRel[nX, 33, nX1, nX2, nX3, nX4]), "", STRTRAN(Transform(aDadRel[nX, 33, nX1, nX2, nX3, nX4], "@E 999,999,999.99"),',','.')) )

											IF(!Empty(aDadRel[nX, 34, nX1, nX2, nX3, nX4]))  //Se valor glosa for diferente de vazio
												u_CBGRVXML( "A","relacaoGlosa" )
												u_CBGRVXML( "AF","valorGlosa",			IIf(Empty(aDadRel[nX, 34, nX1, nX2, nX3, nX4]), "", STRTRAN(Transform(aDadRel[nX, 34, nX1, nX2, nX3, nX4], "@E 9,999,999.99"),',','.')) )
												u_CBGRVXML( "AF","tipoGlosa",			aDadRel[nX, 35, nX1,nX2, nX3, nX4])
												u_CBGRVXML( "F","relacaoGlosa" )
											ENDIF
											nInfGui  += aDadRel[nX, 30, nX1, nX2, nX3, nX4]
											nProcGui += aDadRel[nX, 32, nX1, nX2, nX3, nX4]
											nLibGui  += aDadRel[nX, 33, nX1, nX2, nX3, nX4]
											nGloGui  += aDadRel[nX, 34, nX1, nX2, nX3, nX4]
											u_CBGRVXML( "F","detalhesGuia" )
										Next nX4

					//Totais da Guia
										u_CBGRVXML( "AF","valorInformadoGuia",			STRTRAN(Transform(nInfGui, "@E 999,999,999.99"),',','.') )
										u_CBGRVXML( "AF","valorProcessadoGuia",			STRTRAN(Transform(nProcGui, "@E 999,999,999.99"),',','.') )
										u_CBGRVXML( "AF","valorLiberadoGuia",			STRTRAN(Transform(nLibGui, "@E 999,999,999.99"),',','.') )
										u_CBGRVXML( "AF","valorGlosaGuia",				STRTRAN(Transform(nGloGui, "@E 999,999,999.99"),',','.') )

										nInfFat += nInfGui
										nProcFat += nProcGui
										nLibFat  += nLibGui
										nGloFat  += nGloGui
										u_CBGRVXML( "F","relacaoGuias" )
									Next nX3

				//Totais do protocolo
									u_CBGRVXML( "AF","valorInformadoProtocolo",			STRTRAN(Transform(nInfFat, "@E 999,999,999.99"),',','.') )
									u_CBGRVXML( "AF","valorProcessadoProtocolo",			STRTRAN(Transform(nProcFat, "@E 999,999,999.99"),',','.') )
									u_CBGRVXML( "AF","valorLiberadoProtocolo",			STRTRAN(Transform(nLibFat, "@E 999,999,999.99"),',','.') )
									u_CBGRVXML( "AF","valorGlosaProtocolo",				STRTRAN(Transform(nGloFat, "@E 999,999,999.99"),',','.') )

									nInfGer += nInfFat
									nProcGer += nProcFat
									nLibGer  += nLibFat
									nGloGer  += nGloFat
								Next nX2
							Next nX1

							u_CBGRVXML( "F","dadosProtocolo" )
							u_CBGRVXML( "F","dadosConta" )

		//Totais gerais
							u_CBGRVXML( "AF","valorInformadoGeral",			STRTRAN(Transform(nInfGer, "@E 999,999,999.99"),',','.') )
							u_CBGRVXML( "AF","valorProcessadoGeral",			STRTRAN(Transform(nProcGer, "@E 999,999,999.99"),',','.') )
							u_CBGRVXML( "AF","valorLiberadoGeral",			STRTRAN(Transform(nLibGer, "@E 999,999,999.99"),',','.') )
							IIF (nGloGer > 0.00 , u_CBGRVXML( "AF","valorGlosaGeral", STRTRAN(Transform(nGloGer, "@E 999,999,999.99"),',','.')), "" )

						Next nX
						IF (Len(aMatAux) > 1 .AND. nZ <> Len(aMatAux))
							u_CBGRVXML( "F", "demonstrativoAnaliseConta")
						ENDIF
					Next nZ

				ENDIF
			ENDIF


		//Dados do CANCELAMENTO_GUIA_RECIBO
		Case cTranRet == "CANCELAMENTO_GUIA_RECIBO"

			//Processa guia por guia
			For nI:=1 To Len(aRet)
				aMatCri	:= {}
				dDatPro	:= aRet[nI,1,14]     //Data Procedimento
				cNumGui	:= aRet[nI,1,10]     //Numero guia prestador

				cRda 	 	:= AllTrim(aRet[nI,1,3])
				cNomeRda 	:= AllTrim(aRet[nI,1,4])
				cTpPessoa	:= AllTrim(aRet[nI,1,5])
				cCPFCGC	 	:= AllTrim(aRet[nI,1,6])
				cTipoGuia 	:= aRet[nI,2,3]


				//Matriz de processamento
				If Len(aRet[nI,2])>0

					cNumAut := aRet[nI,2,2] 	//Numero da Autorizacao

					//Matric dados,itens e criticas
					aMatCri := aRet[nI,2,4] 	//Criticas
				Else
					lFault := .T.
				EndIf

				// Se o retorno do processamento foi ok
				If !lFault

					// Inclui somente uma vez
					If lInc

						// Raiz da Resposta
						CorpoRaiz(cTranRet,cTagRet,.T.)

						// DadosOperadora
						If (TISVERS < "3")
							DadosOperadora("operadora")
						Else
							u_CBGRVXML( "A", cTagRet)
							u_CBGRVXML( "AF","registroANS",AllTrim(BA0->BA0_SUSEP) )
							DadosPrestador("dadosPrestador",cTpPessoa,cCPFCGC,cNomeRda,cRda)
						EndIf

						// operadora FIM
						u_CBGRVXML( "A","guiasCanceladas" )
						lInc := .F.
					EndIf

					// Dados da guia
					u_CBGRVXML( "A","dadosGuia" )
					If (TISVERS < "3")
						u_CBGRVXML( "A","identificacaoFontePagadora" )
						u_CBGRVXML( "AF","registroANS",AllTrim(BA0->BA0_SUSEP) )
						u_CBGRVXML( "F","identificacaoFontePagadora" )
						cData := DtoS(dDatPro)
						cData := U_CBXMLDTV(cData)
						u_CBGRVXML( "AF","dataEmissaoGuia", cData )
						u_CBGRVXML( "AF","numeroGuiaPrestador",cNumGui )
						If !Empty(cNumAut)
							u_CBGRVXML( "AF","numeroGuiaOperadora",cNumAut )
						EndIf

							// Status do cancelamento
						u_CBGRVXML( "AF","statusCancelamento",aMatCri[1,1] )
						u_CBGRVXML( "AF","observacao",Left(AllTrim(aMatCri[1,2]),240) )
					Else
						u_CBGRVXML( "AF","numeroGuiaPrestador",cNumGui )
						u_CBGRVXML( "AF","tipoGuia", cTipoGuia)
						u_CBGRVXML( "AF","statusCancelamento",aMatCri[1,1] )
					EndIf
					u_CBGRVXML( "F","dadosGuia" )
				EndIf
			Next
			If !lFault
				u_CBGRVXML( "F","guiasCanceladas" )
				u_CBGRVXML( "F", cTagRet)
			EndIf

		//Dados do DEMONSTRATIVO_PAGAMENTO
		Case cTranRet == "DEMONSTRATIVO_PAGAMENTO"
			CorpoRaiz(cTranRet,cTagRet,.T.)

			//Processa guia por guia
			For nI:=1 To Len(aDadRel)
				For nX := 14 To 32
					If Len(aDadRel[nI, nX]) < 1
						For nJ := Len(aDadRel[nI, nX]) + 1 To 32
							If AllTrim(Str(nX)) $ "14"
								aAdd(aDadRel[nI, nX], StoD(""))
							ElseIf AllTrim(Str(nX)) $ "17,18,19,20,21,22,23,24,28,29,30,31"
								aAdd(aDadRel[nI, nX], 0)
							Else
								aAdd(aDadRel[nI, nX], "")
							EndIf
						Next nJ
					EndIf
				Next nX
				For nX := 1 To Len(aDadRel[nI, 04])


					// Inclui somente uma vez
					If lInc

						// Raiz da Resposta
						cCnpjOpe := StrTran(aDadRel[nI, 04, nX],".","")
						cCnpjOpe := StrTran(cCnpjOpe,"/","")
						cCnpjOpe := StrTran(cCnpjOpe,"-","")

						u_CBGRVXML( "A","cabecalhoDemonstrativo" )
						u_CBGRVXML( "AF","registroANS",aDadRel[nI,1] ) //registro ans
						u_CBGRVXML( "AF","numeroDemonstrativo",aDadRel[nI,2] ) //nro demonstrativo
						u_CBGRVXML( "AF","nomeOperadora",aDadRel[nI,3] ) //Nome da Operadora
						u_CBGRVXML( "AF","numeroCNPJ",cCnpjOpe) //CNPJ Operadora
						u_CBGRVXML( "AF","dataEmissao",U_CBXMLDTV(DtoS(aDadRel[nI, 05, nX])) ) //"Data Emissão do Demonstrativo
						u_CBGRVXML( "F","cabecalhoDemonstrativo" )

						u_CBGRVXML( "A","dadosContratado" )

						cCnpjCpf := StrTran(aDadRel[nI, 06, nX],".","")
						cCnpjCpf := StrTran(cCnpjCpf,"-","")
						cCnpjCpf := StrTran(cCnpjCpf,"/","")

						DadosPrestador("dadosPrestador",Iif(Len(cCnpjCpf) > 11, "J","F"),cCnpjCpf,aDadRel[nI, 07, nX],"") //CPF/CNPJ e Nome do Contratado
						u_CBGRVXML( "AF","CNES",aDadRel[nI, 08, nX] ) //"CNES
						u_CBGRVXML( "F","dadosContratado" )

						u_CBGRVXML( "A","pagamentos" )

						lInc := .F.
					EndIf

					u_CBGRVXML( "A","pagamentosPorData" )

					u_CBGRVXML( "A","dadosPagamento" )
					u_CBGRVXML( "AF","dataPagamento",U_CBXMLDTV(DtoS(aDadRel[nI, 09, nX])) ) //Data do Pagamento
					u_CBGRVXML( "AF","formaPagamento",aDadRel[nI, 10, nX] ) //forma pagamento
					If !Empty(aDadRel[nI, 11, nX])
						u_CBGRVXML( "AF","banco",aDadRel[nI, 11, nX] ) //banco
						u_CBGRVXML( "AF","agencia",aDadRel[nI, 12, nX] ) //agencia
						u_CBGRVXML( "AF","nrContaCheque",aDadRel[nI, 13, nX] ) //conta
					EndIf
					u_CBGRVXML( "F","dadosPagamento" )

					u_CBGRVXML( "A","dadosResumo" )

					For nZ := 1 To Len(aDadRel[nI, 14, nX])
						If !Empty(aDadRel[nI, 14, nX, nZ])
							u_CBGRVXML( "A","relacaoProtocolos" )
							u_CBGRVXML( "AF","dataProtocolo",U_CBXMLDTV(DtoS(aDadRel[nI, 14, nX, nZ])))
							u_CBGRVXML( "AF","numeroProtocolo",aDadRel[nI, 15, nX, nZ] )
							u_CBGRVXML( "AF","numeroLote",aDadRel[nI, 16, nX, nZ] )
							u_CBGRVXML( "AF","valorInformado",Transform(aDadRel[nI, 17, nX, nZ], "@R 999999999.99") )
							u_CBGRVXML( "AF","valorProcessado",Transform(aDadRel[nI, 18, nX, nZ], "@R 999999999.99") )
							u_CBGRVXML( "AF","valorLiberado",Transform(aDadRel[nI, 19, nX, nZ], "@R 999999999.99") )
							If aDadRel[nI, 20, nX, nZ] > 0
								u_CBGRVXML( "AF","valorGlosa",Transform(aDadRel[nI, 20, nX, nZ], "@R 999999999.99") )
							EndIf
							u_CBGRVXML( "F","relacaoProtocolos" )
						EndIf
					Next nZ

					u_CBGRVXML( "F","dadosResumo" )

					u_CBGRVXML( "A","totaisBrutosPorData" )
					u_CBGRVXML( "AF","totalInformadoPorData",Transform(aDadRel[nI, 21, nX], "@R 999999999.99") )
					u_CBGRVXML( "AF","totalProcessadoPorData",Transform(aDadRel[nI, 22, nX], "@R 999999999.99") )
					u_CBGRVXML( "AF","totaLiberadoPorData",Transform(aDadRel[nI, 23, nX], "@R 999999999.99") )
					u_CBGRVXML( "AF","totalGlosaPorData",Transform(aDadRel[nI, 24, nX], "@R 999999999.99") )
					u_CBGRVXML( "F","totaisBrutosPorData" )

					For nZ := 1 To Len(aDadRel[nI, 25, nX])
						If !Empty(aDadRel[nI, 25, nX, nZ])
							If lFirst
								u_CBGRVXML( "A","debitosCreditosPorData" )
								lFirst := .F.
							EndIf
							u_CBGRVXML( "A","debitosCreditos" )
							u_CBGRVXML( "AF","indicador",aDadRel[nI, 25, nX, nZ] )
							u_CBGRVXML( "AF","tipoDebitoCredito",aDadRel[nI, 26, nX, nZ] )
							u_CBGRVXML( "AF","descricaoDbCr",aDadRel[nI, 27, nX, nZ] )
							u_CBGRVXML( "AF","valorDbCr",Transform(aDadRel[nI, 28, nX, nZ], "@R 999999999.99") )
							u_CBGRVXML( "F","debitosCreditos" )
							lFecha := .T.
						EndIf

					Next nZ

					If lFecha
						u_CBGRVXML( "F","debitosCreditosPorData" )
						lFirst := .T.
						lFecha := .F.
					EndIf

					u_CBGRVXML( "A","totaisLiquidosPorData" )
					u_CBGRVXML( "AF","totalDebitosPorData",Transform(aDadRel[nI, 29, nX], "@R 999999999.99") )
					u_CBGRVXML( "AF","totalCreditosPorData",Transform(aDadRel[nI, 30, nX], "@R 999999999.99") )
					u_CBGRVXML( "AF","liquidoPorData",Transform(aDadRel[nI, 31, nX], "@R 999999999.99") )
					u_CBGRVXML( "F","totaisLiquidosPorData" )

					u_CBGRVXML( "F","pagamentosPorData" )

					nVal21 := nVal21 + aDadRel[nI, 21, nX]
					nVal22 := nVal22 + aDadRel[nI, 22, nX]
					nVal23 := nVal23 + aDadRel[nI, 23, nX]
					nVal24 := nVal24 + aDadRel[nI, 24, nX]

					For nZ := 1 To Len(aDadRel[nI, 25, nX])
						If !Empty(aDadRel[nI, 25, nX, nZ])
							aadd(aAuxDebCre,{aDadRel[nI, 25, nX, nZ],aDadRel[nI, 26, nX, nZ],aDadRel[nI, 27, nX, nZ],aDadRel[nI, 28, nX, nZ]})
						EndIf
					Next nZ

					nVal29 := nVal29 + aDadRel[nI, 29, nX]
					nVal30 := nVal30 + aDadRel[nI, 30, nX]
					nVal31 := nVal31 + aDadRel[nI, 31, nX]

				Next nX

				If Len(aDadRel) == nI
					u_CBGRVXML( "F","pagamentos" )

					u_CBGRVXML( "A","totaisDemonstrativo" )

					u_CBGRVXML( "A","totaisBrutosDemonstrativo" )
					u_CBGRVXML( "AF","valorInformadoBruto",Transform(nVal21, "@R 999999999.99") )
					u_CBGRVXML( "AF","valorProcessadoBruto",Transform(nVal22, "@R 999999999.99") )
					u_CBGRVXML( "AF","valorLiberadoBruto",Transform(nVal23, "@R 999999999.99") )
					u_CBGRVXML( "AF","valorGlosaBruto",Transform(nVal24, "@R 999999999.99") )
					u_CBGRVXML( "F","totaisBrutosDemonstrativo" )

					For nZ := 1 To Len(aAuxDebCre)
						If lFirst
							u_CBGRVXML( "A","debitosCreditosDemonstrativo" )
							lFirst := .F.
						EndIf
						u_CBGRVXML( "AF","indicador", aAuxDebCre[nZ,1])
						u_CBGRVXML( "AF","tipoDebitoCredito", aAuxDebCre[nZ,2] )
						u_CBGRVXML( "AF","descricaoDbCr",aAuxDebCre[nZ,3] )
						u_CBGRVXML( "AF","valorDbCr",Transform(aAuxDebCre[nZ,4], "@R 999999999.99") )
						lFecha := .T.

					Next nZ

					If lFecha
						u_CBGRVXML( "F","debitosCreditosDemonstrativo" )
						lFecha := .F.
					EndIf

					u_CBGRVXML( "A","totaisLiquidosDemonstrativo" )
					u_CBGRVXML( "AF","totalDebitosDemonstrativo",Transform(nVal29, "@R 999999999.99") )
					u_CBGRVXML( "AF","totalCreditosdemonstrativo",Transform(nVal30, "@R 999999999.99") )
					u_CBGRVXML( "AF","valorLiberadoDemonstrativo",Transform(nVal31, "@R 999999999.99") )
					u_CBGRVXML( "F","totaisLiquidosDemonstrativo" )

					u_CBGRVXML( "F","totaisDemonstrativo" )

					For nZ := 1 To Len(aDadRel[nI, 32])
						If !Empty(aDadRel[nI, 32, nZ])
							MlCount(aDadRel[nI, 32, nZ], 500)
							cObs := MemoLine(aDadRel[nI, 32, nZ], 500, nZ)
							u_CBGRVXML( "AF","observacao",cObs )
						EndIf
					Next nZ
				EndIf

			Next nI


		//Dados do DEMONSTRATIVO_ODONTO
		Case cTranRet == "DEMONSTRATIVO_ODONTOLOGIA"
			CorpoRaiz(cTranRet,cTagRet,.T.)
			For nX := 1 To Len(aDadRel)
				If ValType(aDadRel[nX]) == 'U' .OR. Len(aDadRel[nX]) == 0
					Loop
				EndIf

				For nI:= 19 To 28
					If Len(aDadRel[nX, nI]) < 6
						For nJ := Len(aDadRel[nX, nI]) + 1 To 6
							If AllTrim(Str(nI)) $ "25,27,28,29,30"
								aAdd(aDadRel[nX, nI], 0)
							ElseiF AllTrim(Str(nI)) $ "24"
								aAdd(aDadRel[nX, nI], CToD(""))
							Else
								aAdd(aDadRel[nX, nI],"")
							EndIf
						Next nJ
					EndIf
				Next nI

				For nI := 43 To 46
					If Len(aDadRel[nX, nI]) < 2
						For nJ := Len(aDadRel[nX, nI]) + 1 To 2
							If AllTrim(Str(nI)) == "46"
								aAdd(aDadRel[nX, nI], 0)
							Else
								aAdd(aDadRel[nX, nI], "")
							EndIf
						Next
					EndIf
				Next nI

				For nI := 47 To 54
					If Len(aDadRel[nX, nI]) < 3
						For nJ := Len(aDadRel[nX, nI]) + 1 To 3
							If AllTrim(Str(nI)) $ "50,54"
								aAdd(aDadRel[nX, nI], 0)
							Else
								aAdd(aDadRel[nX, nI], "")
							EndIf
						Next
					EndIf
				Next nI

				For nX1 := 1 To Len(aDadRel[nX, 02])

					// Inclui somente uma vez
					nTotGerInf := 0
					nTotGerPro := 0
					nTotGerGlo := 0
					nTotGerFra := 0
					nTotGerLib := 0
					If lInc


						// Raiz da Resposta
						cCnpjOpe := StrTran(aDadRel[nX, 04, nX1],".","")
						cCnpjOpe := StrTran(cCnpjOpe,"/","")
						cCnpjOpe := StrTran(cCnpjOpe,"-","")

						u_CBGRVXML( "A","cabecalhoDemonstrativoOdonto" )
						u_CBGRVXML( "AF","registroANS",aDadRel[nX, 01] ) //registro ans
						u_CBGRVXML( "AF","numeroDemonstrativo",aDadRel[nX, 02, nX1] ) //nro demonstrativo
						u_CBGRVXML( "AF","nomeOperadora",aDadRel[nX, 03, nX1] ) //Nome da Operadora
						u_CBGRVXML( "AF","cnpjOper",cCnpjOpe) //CNPJ Operadora
						u_CBGRVXML( "A","periodoProc") //pe´riodo
						u_CBGRVXML( "AF","datainicio",U_CBXMLDTV(DtoS(aDadRel[nX, 05, nX1]))) //data inicio
						u_CBGRVXML( "AF","datafim",U_CBXMLDTV(DtoS(aDadRel[nX, 06, nX1]))) //data final
						u_CBGRVXML( "F","periodoProc") //pe´riodo
						u_CBGRVXML( "F","cabecalhoDemonstrativoOdonto" )

						u_CBGRVXML( "A","dadosPrestador" )

						u_CBGRVXML( "AF","codigoPrestador",aDadRel[nX, 07, nX1])
						u_CBGRVXML( "AF","nomePrestador",aDadRel[nX, 08, nX1])

						cCnpjCpf := StrTran(aDadRel[nX, 09, nX1],".","")
						cCnpjCpf := StrTran(cCnpjCpf,"-","")
						cCnpjCpf := StrTran(cCnpjCpf,"/","")

						u_CBGRVXML( "A","cpfCNPJContratado" )

						u_CBGRVXML( "AF",Iif(Len(cCnpjCpf) > 11, "cnpjPrestador","cpfContratado"),cCnpjCpf ) //"CPF/CNPJ Contratado

						u_CBGRVXML( "F","cpfCNPJContratado" )

						u_CBGRVXML( "F","dadosPrestador" )

						lInc := .F.
						lFirst := .T.
					EndIf

					For nX2 := 1 To Len(aDadRel[nX, 10, nX1])
						u_CBGRVXML( "A","dadosPagamentoPorData" )
						nTotProtInf := 0
						nTotProtPro := 0
						nTotProtGlo := 0
						nTotProtFra := 0
						nTotProtLib := 0
						For nX3 := 1 To Len(aDadRel[nX, 10, nX1, nX2])

							nProcLot := 0
							nGloLot  := 0
							nLibLot  := 0

							If lFirst
								u_CBGRVXML( "A","dadosPagamento" )
								u_CBGRVXML( "AF","dataPagamento",U_CBXMLDTV(DtoS(aDadRel[nX, 10, nX1, nX2, nX3])) ) //Data do Pagamento

								If !Empty(aDadRel[nX, 11, nX1, nX2, nX3])
									u_CBGRVXML( "AF","banco",aDadRel[nX, 11, nX1, nX2, nX3] ) //banco
									u_CBGRVXML( "AF","agencia",aDadRel[nX, 12, nX1, nX2, nX3] ) //agencia
									u_CBGRVXML( "AF","nrContaCheque",aDadRel[nX, 13, nX1, nX2, nX3] ) //conta
								EndIf

								u_CBGRVXML( "F","dadosPagamento" )

								u_CBGRVXML( "A","protocolos" )
								u_CBGRVXML( "AF","numeroLote",aDadRel[nX, 14, nX1, nX2, nX3]) //número do lote
								u_CBGRVXML( "AF","numeroProtocolo",aDadRel[nX, 15, nX1, nX2, nX3]) //número do lote
								u_CBGRVXML( "A","dadosPagamentoGuia" )
								u_CBGRVXML( "AF","numeroGuiaPrestador",aDadRel[nX, 16, nX1, nX2, nX3]) //número da guia no prestador
								u_CBGRVXML( "AF","numeroGuiaOperadora",aDadRel[nX, 60, nX1, nX2, nX3]) //número da guia atribuído pela operadora
								u_CBGRVXML( "AF","recurso",aDadRel[nX, 61, nX1, nX2, nX3]) //recurso
								u_CBGRVXML( "AF","nomeExecutante",aDadRel[nX, 62, nX1, nX2, nX3]) //nome do profissional executante
								cCartBen := StrTran(aDadRel[nX, 17, nX1, nX2, nX3],".","")
								cCartBen := StrTran(cCartBen,"-","")
								u_CBGRVXML( "AF","carteiraBeneficiario",cCartBen) //carteira do beneficiário
								u_CBGRVXML( "AF","nomeBeneficiario",aDadRel[nX, 18, nX1, nX2, nX3]) //nome Beneficiario
							EndIf

							For nX4 := 1 To Len(aDadRel[nX, 19, nX1, nX2, nX3])

								If lFirst
									u_CBGRVXML( "A","dadosPagamento" )
									lFirst := .F.
								EndIf
								u_CBGRVXML( "A","procedimento" )
								u_CBGRVXML( "AF","codigoTabela",aDadRel[nX, 19, nX1, nX2, nX3, nX4]) //codigo tabela
								u_CBGRVXML( "AF","codigoProcedimento",aDadRel[nX, 20, nX1, nX2, nX3, nX4]) //codigo procedimento
								u_CBGRVXML( "AF","descricaoProcedimento",aDadRel[nX, 21, nX1, nX2, nX3, nX4]) //descricao procedimento
								u_CBGRVXML( "F","procedimento")
								If !Empty(aDadRel[nX, 22, nX1, nX2, nX3, nX4])
									u_CBGRVXML( "A","denteRegiao")
									u_CBGRVXML( "AF",Iif("codDente","codDente","codRegiao"),aDadRel[nX, 22, nX1, nX2, nX3, nX4]) //codigo dente/regiao
									u_CBGRVXML( "F","denteRegiao")
								EndIf
								If !Empty(aDadRel[nX, 23, nX1, nX2, nX3, nX4])
									u_CBGRVXML( "AF","denteFace",aDadRel[nX, 23, nX1, nX2, nX3, nX4]) //dente face
								EndIf
								u_CBGRVXML( "AF","dataRealizacao",U_CBXMLDTV(DtoS(aDadRel[nX, 24, nX1, nX2, nX3, nX4]))) //data realizacao
								u_CBGRVXML( "AF","qtdProc",Transform(aDadRel[nX, 25, nX1, nX2, nX3, nX4], "99")) //qtd proc
								u_CBGRVXML( "AF","valorInformado",Transform(aDadRel[nX, 26, nX1, nX2, nX3, nX4], "@R 999999999.99")) //valor informado
								u_CBGRVXML( "AF","valorProcessado",Transform(aDadRel[nX, 27, nX1, nX2, nX3, nX4], "@R 999999999.99")) //valor processado
								u_CBGRVXML( "AF","valorGlosaEstorno",Transform(aDadRel[nX, 28, nX1, nX2, nX3, nX4], "@R 999999999.99")) //valor glosa estorno
								u_CBGRVXML( "AF","valorFranquia",Transform(aDadRel[nX, 29, nX1, nX2, nX3, nX4], "@R 999999999.99")) //valor franquia
								u_CBGRVXML( "AF","valorLiberado",Transform(aDadRel[nX, 30, nX1, nX2, nX3, nX4], "@R 999999999.99")) //valor liberado

								If !Empty(aDadRel[nX, 31, nX1, nX2, nX3, nX4])
									u_CBGRVXML( "AF","codigosGlosa",aDadRel[nX, 31, nX1, nX2, nX3, nX4]) //codigos glosas
								EndIf

								If nX4 == Len(aDadRel[nX, 19, nX1, nX2, nX3])
									u_CBGRVXML( "F","dadosPagamento" )
								EndIf

							Next nX4
							For nI := 1 To MlCount(aDadRel[nX, 32,nX1,nX2,nX3], 500)
								cObs := MemoLine(aDadRel[nX, 32,nX1,nX2,nX3], 500, nI)
								u_CBGRVXML( "AF","observacaoGuia",cObs) //observacoes guia
							Next nI

							u_CBGRVXML( "AF","valorTotalInformadoGuia",Transform(aDadRel[nX, 33, nX1, nX2, nX3], "@R 999999999.99")) //valor Total Informado Guia
							u_CBGRVXML( "AF","valorTotalProcessadoGuia",Transform(aDadRel[nX, 34, nX1, nX2, nX3], "@R 999999999.99")) //valor Total Processado Guia
							u_CBGRVXML( "AF","valorTotalGlosaGuia",Transform(aDadRel[nX, 35, nX1, nX2, nX3], "@R 999999999.99")) //valor Total Glosa Guia
							u_CBGRVXML( "AF","valorTotalFranquiaGuia",Transform(aDadRel[nX, 36, nX1, nX2, nX3], "@R 999999999.99")) //valor Total Franquia Guia
							u_CBGRVXML( "AF","valorTotalLiberadoGuia",Transform(aDadRel[nX, 37, nX1, nX2, nX3], "@R 999999999.99")) //valor Total Liberado Guia

							If nX3 == Len(aDadRel[nX, 19, nX1, nX2])
								u_CBGRVXML( "F","dadosPagamentoGuia" )
							EndIf

							u_CBGRVXML( "A","totaisPorProtocolo")
							u_CBGRVXML( "AF","valorTotalInformadoPorProtocolo",Transform(aDadRel[nX, 38, nX1, nX2], "@R 999999999.99")) //valor Total Informado Por Protocolo
							u_CBGRVXML( "AF","valorTotalProcessadoPorProtocolo",Transform(aDadRel[nX, 39, nX1, nX2], "@R 999999999.99")) //valor Total Processado Por Protocolo
							u_CBGRVXML( "AF","valorTotalGlosaPorProtocolo",Transform(aDadRel[nX, 40, nX1, nX2], "@R 999999999.99")) //valor Total Glosa Por Protocolo
							u_CBGRVXML( "AF","valorTotalFranquiaPorProtocolo",Transform(aDadRel[nX, 41, nX1, nX2], "@R 999999999.99")) //valor Total Franquia Por Protocolo
							u_CBGRVXML( "AF","valorTotalLiberadoPorProtocolo",Transform(aDadRel[nX, 42, nX1, nX2], "@R 999999999.99")) //valor Total Liberado Por Protocolo
							u_CBGRVXML( "F","totaisPorProtocolo")

							nTotProtInf := nTotProtInf + aDadRel[nX, 38, nX1, nX2]
							nTotProtPro := nTotProtPro + aDadRel[nX, 39, nX1, nX2]
							nTotProtGlo := nTotProtGlo + aDadRel[nX, 40, nX1, nX2]
							nTotProtFra := nTotProtFra + aDadRel[nX, 41, nX1, nX2]
							nTotProtLib := nTotProtLib + aDadRel[nX, 42, nX1, nX2]

							If nX3 == Len(aDadRel[nX, 19, nX1, nX2])
								u_CBGRVXML( "F","protocolos" )

								u_CBGRVXML( "A","totaisPorData")
								u_CBGRVXML( "AF","valorBrutonformadoPorData",Transform(nTotProtInf, "@R 999999999.99")) //valorBrutonformadoPorData
								u_CBGRVXML( "AF","valorBrutoProcessadoPorData",Transform(nTotProtPro, "@R 999999999.99")) //valorBrutoProcessadoPorData
								u_CBGRVXML( "AF","valorBrutoGlosaPorData",Transform(nTotProtGlo, "@R 999999999.99")) //valorBrutoGlosaPorData
								u_CBGRVXML( "AF","valorBrutoFranquiaPorData",Transform(nTotProtFra, "@R 999999999.99")) //valorBrutoFranquiaPorData
								u_CBGRVXML( "AF","valorBrutoLiberadoPorData",Transform(nTotProtLib, "@R 999999999.99")) //valorBrutoLiberadoPorData
								u_CBGRVXML( "F","totaisPorData")

								If Len(aDadRel[nX, 43, nX1]) > 0
									u_CBGRVXML( "A","debCredPorDataPagamento")
									nTotCred	:= 0
									nTotDeb		:= 0
									For nY := 1 To Len(aDadRel[nX, 43, nX1])
										If lFirst
											u_CBGRVXML( "A","decontos")
										EndIf

										u_CBGRVXML( "AF","indicador",aDadRel[nX, 43, nX1, nY]) //indicador
										u_CBGRVXML( "AF","tipoDebitoCredito",aDadRel[nX, 44, nX1, nY]) //tipo Debito Credito
										u_CBGRVXML( "AF","descricaoDbCr",aDadRel[nX, 45, nX1, nY]) //descricaoDbCr
										u_CBGRVXML( "AF","valorDbCr",Transform(aDadRel[nX, 46, nX1, nY], "@R 999999999.99")) //valorDbCr

										If aDadRel[nX, 43, nX1, nY] == "+"
											nTotCred := nTotCred + aDadRel[nX, 46, nX1, nY]
										Else
											nTotDeb := nTotDeb + aDadRel[nX, 46, nX1, nY]
										EndIf

										If nY == Len(aDadRel[nX, 43, nX1])
											u_CBGRVXML( "F","decontos")
										EndIf
									Next nY
									u_CBGRVXML( "F","debCredPorDataPagamento")
								EndIf
								u_CBGRVXML( "A","totalLiquidoPorData")
								u_CBGRVXML( "AF","valorTotalDebitosPorData",Transform(nTotDeb, "@R 999999999.99")) //valor Total Debitos Por Data
								u_CBGRVXML( "AF","valorTotalCreditosPorData",Transform(nTotCred, "@R 999999999.99")) //valor Total Creditos Por Data
								u_CBGRVXML( "AF","valorFinalAReceberPorData",Transform(nTotCred - nTotDeb, "@R 999999999.99")) //valor Final A Receber Por Data
								u_CBGRVXML( "F","totalLiquidoPorData")
							EndIf

							nTotGerInf := nTotGerInf + nTotProtInf
							nTotGerPro := nTotGerPro + nTotProtPro
							nTotGerGlo := nTotGerGlo + nTotProtGlo
							nTotGerFra := nTotGerFra + nTotProtFra
							nTotGerLib := nTotGerLib + nTotProtLib

						Next nX3

						If nX2 == Len(aDadRel[nX, 10, nX1])
							u_CBGRVXML( "F","dadosPagamentoPorData" )
						EndIf

					Next nX2

					u_CBGRVXML( "A","totaisBrutoDemonstrativo")
					u_CBGRVXML( "AF","valorInformadoPorDemonstrativoData",Transform(nTotGerInf, "@R 999999999.99")) //valor Informado Por Demonstrativo Data
					u_CBGRVXML( "AF","valorlProcessadoPorDemonstrativo",Transform(nTotGerPro, "@R 999999999.99")) //valor Processado Por Demonstrativo Data
					u_CBGRVXML( "AF","valorlGlosaPorDemonstrativo",Transform(nTotGerGlo, "@R 999999999.99")) //valor Glosa Por Demonstrativo Data
					u_CBGRVXML( "AF","valoFranquiaPorDemonstrativo",Transform(nTotGerFra, "@R 999999999.99")) //valor Franquia Por Demonstrativo Data
					u_CBGRVXML( "AF","valorLiberadoPorDemonstrativo",Transform(nTotGerLib, "@R 999999999.99")) //valor Liberado Por Demonstrativo Data
					u_CBGRVXML( "F","totaisBrutoDemonstrativo")

					If Len(aDadRel[nX, 43, nX1]) > 0
						u_CBGRVXML( "A","debCredDemonstrativo")

						For nY := 1 To Len(aDadRel[nX, 43, nX1])
							If lFirst
								u_CBGRVXML( "A","decontos")
							EndIf

							u_CBGRVXML( "AF","indicador",aDadRel[nX, 43, nX1, nY]) //indicador
							u_CBGRVXML( "AF","tipoDebitoCredito",aDadRel[nX, 43, nX1, nY]) //tipo Debito Credito
							u_CBGRVXML( "AF","descricaoDbCr",aDadRel[nX, 43, nX1, nY]) //descricaoDbCr
							u_CBGRVXML( "AF","valorDbCr",Transform(aDadRel[nX, 43, nX1, nY], "@R 999999999.99")) //valorDbCr

							If nY == Len(aDadRel[nX, 43, nX1])
								u_CBGRVXML( "F","decontos")
							EndIf
						Next nY
						u_CBGRVXML( "F","debCredPorDataPagamento")
					EndIf

					u_CBGRVXML( "AF","totalDebitosDemonstativo",Transform(nTotDeb, "@R 999999999.99")) //total Debitos Demonstativo
					u_CBGRVXML( "AF","totalCreditosDemonstrativo",Transform(nTotCred, "@R 999999999.99")) //total Creditos Demonstrativo
					u_CBGRVXML( "AF","valorRecebidoDemonstrativo",Transform(nTotCred - nTotDeb, "@R 999999999.99")) //valor Recebido Demonstrativo

					For nZ := 1 To Len(aDadRel[nX, 59])
						If !Empty(aDadRel[nX, 59, nZ])
							MlCount(aDadRel[nX, 59, nZ], 500)
							cObs := MemoLine(aDadRel[nX, 59, nZ], 500, nZ)
							u_CBGRVXML( "AF","observacaoGuia",cObs )
						EndIf
					Next nZ

				Next nX1

			Next nX



		//Dados para solicitação de status de recurso de glosa
		Case cTranRet $ "RESPOSTA_RECURSO_GLOSA"
			//Processa situacao de cada protocolo
			If !lFault
				CorpoRaiz(cTranRet,cTagRet,.T.)
				nTam := len(aRet[1][2])
				if(aRet[1][2][1] == "2")
					u_CBGRVXML( "A", "reciboGlosaStatus" )
					u_CBGRVXML( "AF","nrProtocoloRecursoGlosa", aRet[1][2][2])
					u_CBGRVXML( "AF","dataEnvioRecurso", U_CBXMLDTV(DtoS(aRet[1][2][3])))
					u_CBGRVXML( "AF","dataRecebimentoRecurso", U_CBXMLDTV(DtoS(aRet[1][2][3])))
					u_CBGRVXML( "AF","numeroLote", aRet[1][2][4])
					u_CBGRVXML( "AF","registroANS", aRet[1][2][5])
					DadosPrestador("dadosPrestador",aRet[1][2][6],aRet[1][2][7],aRet[1][2][8],aRet[1][2][9])
					u_CBGRVXML( "AF","nrProtocoloSituacaoRecursoGlosa", aRet[1][2][2])
					u_CBGRVXML( "AF","dataSituacao", U_CBXMLDTV(DtoS(Date())))
					u_CBGRVXML( "AF","situacaoProtocolo", aRet[1][2][nTam])
					u_CBGRVXML( "F", "reciboGlosaStatus" )
				else
						//montar xml completo
					u_CBGRVXML( "A", "reciboGlosa" )
					u_CBGRVXML( "AF","registroANS", aRet[1][2][5])
					u_CBGRVXML( "AF","numeroGuiaRecGlosaPrestador", aRet[1][2][10])
					u_CBGRVXML( "AF","nomeOperadora", aRet[1][2][11])
					u_CBGRVXML( "AF","objetoRecurso", iif(len(aRet[1][2][nTam]) > 0 .and. aRet[1][2][nTam][1][1] == "P", "1", "2"))
					u_CBGRVXML( "A","dadosContratado")
					u_CBGRVXML( "AF","codigoPrestador", aRet[1][2][9])
					u_CBGRVXML( "AF","nomePrestador", aRet[1][2][8] )
					u_CBGRVXML( "F","dadosContratado")
					u_CBGRVXML( "AF","numeroLote", aRet[1][2][4])
					u_CBGRVXML( "AF","numeroProtocolo",aRet[1][2][2])
					u_CBGRVXML( "A", "opcaoRecurso" )
					for nI := 1 to len(aRet[1][2][nTam])

						if aRet[1][2][nTam][nI][1] == "P"
							u_CBGRVXML( "A", "recursoProtocolo" )
							u_CBGRVXML( "AF","codigoGlosaProtocolo", aRet[1][2][nTam][nI][3])
							u_CBGRVXML( "AF","justificativaProtocolo", aRet[1][2][nTam][nI][4])
							u_CBGRVXML( "AF","recursoAcatado", aRet[1][2][nTam][nI][7])
							u_CBGRVXML( "AF","justificativaOPSnaoAcatadoProt", aRet[1][2][nTam][nI][8])
							u_CBGRVXML( "F", "recursoProtocolo" )
							nVlrTRec += aRet[1][2][nTam][nI][5]
							nVlrTAca += aRet[1][2][nTam][nI][6]
						else
							u_CBGRVXML( "A", "recursoGuia" )
							if aRet[1][2][nTam][nI][1] == "G"
								u_CBGRVXML( "A", "respostaGuia" )
								u_CBGRVXML( "AF","numeroGuiaPrestador", aRet[1][2][nTam][nI][3])
								u_CBGRVXML( "AF","numeroGuiaOperadora", aRet[1][2][nTam][nI][4])
								if(!empty(aRet[1][2][nTam][nI][5]))
									u_CBGRVXML( "AF","senha", aRet[1][2][nTam][nI][5])
								endIf
								u_CBGRVXML( "AF","codGlosa", aRet[1][2][nTam][nI][6])
								u_CBGRVXML( "AF","justificativaPrestador", aRet[1][2][nTam][nI][7])
								u_CBGRVXML( "AF","recursoGuiaAcatado", aRet[1][2][nTam][nI][10])
								u_CBGRVXML( "F", "respostaGuia" )
								nVlrTRec += aRet[1][2][nTam][nI][8]
								nVlrTAca += aRet[1][2][nTam][nI][9]
							elseif aRet[1][2][nTam][nI][1] == "I"
								u_CBGRVXML( "A", "respostaGuiaItens" )
								u_CBGRVXML( "AF","numeroGuiaPrestador", aRet[1][2][nTam][nI][3])
								u_CBGRVXML( "AF","numeroGuiaOperadora", aRet[1][2][nTam][nI][4] )
								if !empty(aRet[1][2][nTam][nI][7])
									u_CBGRVXML( "AF","senha", aRet[1][2][nTam][nI][7])
								endIf

								u_CBGRVXML( "AF","dataRealizacao", U_CBXMLDTV(DtoS(aRet[1][2][nTam][nI][5])))

								if !empty(aRet[1][2][nTam][nI][6])
									u_CBGRVXML( "AF","dataFim", U_CBXMLDTV(DtoS(aRet[1][2][nTam][nI][6])))
								endIf
								u_CBGRVXML( "A","procRecurso", )
								u_CBGRVXML( "AF","codigoTabela", aRet[1][2][nTam][nI][8])
								u_CBGRVXML( "AF","codigoProcedimento", aRet[1][2][nTam][nI][9])
								u_CBGRVXML( "AF","descricaoProcedimento", aRet[1][2][nTam][nI][10])
								u_CBGRVXML( "F","procRecurso" )
								u_CBGRVXML( "AF","codGlosa", aRet[1][2][nTam][nI][11])
								u_CBGRVXML( "AF","valorRecursado", alltrim(str(aRet[1][2][nTam][nI][12])))
								u_CBGRVXML( "AF","justificativaPrestador", aRet[1][2][nTam][nI][13])
								u_CBGRVXML( "AF","valorAcatadado", alltrim(str(aRet[1][2][nTam][nI][14])))
								if !empty(aRet[1][2][nTam][nI][15])
									u_CBGRVXML( "AF","justificativaOperadora", aRet[1][2][nTam][nI][15])
								endIf
								u_CBGRVXML( "F", "respostaGuiaItens" )
								nVlrTRec += aRet[1][2][nTam][nI][12]
								nVlrTAca += aRet[1][2][nTam][nI][14]
							endIf
							u_CBGRVXML( "F", "recursoGuia" )
						endIf
					next nI
					u_CBGRVXML( "F", "opcaoRecurso" )
					u_CBGRVXML( "AF","dataRecurso", U_CBXMLDTV(DtoS(aRet[1][2][3])))
					u_CBGRVXML( "AF","valorTotalRecursado", alltrim(str(nVlrTRec)))
					u_CBGRVXML( "AF","valorTotalAcatado", alltrim(str(nVlrTAca)))
					u_CBGRVXML( "F", "reciboGlosa" )
				endIf
			endIf

		Case cTranRet == "RECEBIMENTO_RECURSO_GLOSA"

			aMatCab  := {}
			aMatItem := {}
			aMatCab   	:= aRet[1,2,1,1]
			aMatItem  	:= aRet[1,2,2]
			cRda 	 	:= AllTrim(aRet[1,1,3])
			cNomeRda 	:= AllTrim(aRet[1,1,4])
			cTpPessoa	:= AllTrim(aRet[1,1,5])
			cCPFCGC	 	:= AllTrim(aRet[1,1,6])

			CorpoRaiz(cTranRet,cTagRet,.T.)
			u_CBGRVXML( "A", "protocoloRecebimento")
			u_CBGRVXML( "AF","nrProtocoloRecursoGlosa", aMatCab[1] )
			u_CBGRVXML( "AF","dataEnvioRecurso", aMatCab[2] )
			u_CBGRVXML( "AF","dataRecebimentoRecurso", aMatCab[3] )
			u_CBGRVXML( "AF","numeroLote", aMatCab[4] )
			u_CBGRVXML( "AF","registroANS", aMatCab[5] )
			DadosPrestador("dadosPrestador",cTpPessoa,cCPFCGC,cNomeRda,cRda)
			u_CBGRVXML( "AF","nrProtocoloRecursado", aMatCab[8] )
			if(len(aMatItem) == 1 .and. aMatItem[1][1] == "P")
				u_CBGRVXML( "A","recursoProtocolo" )
				u_CBGRVXML( "AF","codigoGlosaProtocolo", aMatItem[1][2] )
				u_CBGRVXML( "AF","justificativaProtocolo", aMatItem[1][3] )
				u_CBGRVXML( "AF","justificativaOPSnaoAcatadoProt", "" )
				u_CBGRVXML( "F","recursoProtocolo" )
				u_CBGRVXML( "AF","qtGuiasRecurso", aMatItem[1][4] )
			else
				for nI := 1 to len(aMatItem)

					u_CBGRVXML( "A", "guiasRecurso")
					u_CBGRVXML( "AF","numeroGuiaOrigem", aMatItem[nI][2] )
					u_CBGRVXML( "AF","numeroGuiaOperadora", aMatItem[nI][3] )
					if(!empty(aMatItem[nI][4]))
						u_CBGRVXML( "AF","senha", aMatItem[nI][4] )
					endIf
					u_CBGRVXML( "A", "opcaoRecursoGuia")
					if(aMatItem[nI][1] == "G" )
						u_CBGRVXML( "A", "recursoGuia")
						u_CBGRVXML( "AF","codGlosaGuia", aMatItem[nI][5] )
						u_CBGRVXML( "AF","justificativaGuia", aMatItem[nI][6] )
						u_CBGRVXML( "AF","justificativaOPSnaoAcatadoGuia", "" )
						u_CBGRVXML( "F", "recursoGuia")
					else
						u_CBGRVXML( "A", "itensGuia")
						u_CBGRVXML( "AF","dataInicio", aMatItem[nI][5] )
						if(!empty(aMatItem[nI][6]))
							u_CBGRVXML( "AF","dataFim", aMatItem[nI][6] )
						endIf
						u_CBGRVXML( "A", "procRecurso")
						u_CBGRVXML( "AF","codigoTabela", aMatItem[nI][7] )
						u_CBGRVXML( "AF","codigoProcedimento", aMatItem[nI][8] )
						u_CBGRVXML( "AF","descricaoProcedimento", aMatItem[nI][9] )
						u_CBGRVXML( "F", "procRecurso")
						u_CBGRVXML( "AF","codGlosaItem", aMatItem[nI][10] )
						u_CBGRVXML( "AF","valorRecursado", aMatItem[nI][11] )
						u_CBGRVXML( "AF","justificativaItem", aMatItem[nI][12] )
						u_CBGRVXML( "F", "itensGuia")
					endif
					u_CBGRVXML( "F", "opcaoRecursoGuia")
					u_CBGRVXML( "F", "guiasRecurso")

				next nI
			endif
			u_CBGRVXML( "AF","valorTotalRecursado", aMatCab[10] )
			u_CBGRVXML( "F","protocoloRecebimento" )
		EndCase

	// Fechamento da tag raiz do corpo
		If !lFault
		//Necessário verificar se é demonstrativo, pois se não, coloca as tags em ordem errada e o xml não é validado. Não fecha em nível correto.
			IF (cTranRet $ "DEMONSTRATIVO_ANALISE_CONTA, DEMONSTRATIVO_PAGAMENTO, DEMONSTRATIVO_ODONTOLOGIA" )
				aMtmp := {}
				aMtp := SEPARA(cTagRet, "_")
				cTagRet := aMtp[2] + "_" + aMtp[1]
			ENDIF
			CorpoRaiz(cTranRet,cTagRet,.F.)
		EndIf
	EndIf

	If ((lFault .OR. lFaultLoc) .AND. TISVERS >= "3")
		CorpoRaiz(cTranRet,cTagRet,.T.)

		If "autorizacaoProcedimento" $ cTagRet //Isso corrige o retorno do web service de solicita磯 de procedimentos, tem que ver a estrutura dos demais futuramente
			u_CBGRVXML( "A", "autorizacaoProcedimento")
		EndIf
		u_CBGRVXML( "A", "mensagemErro")
		u_CBGRVXML( "AF","codigoGlosa", cCodErro)
		u_CBGRVXML( "AF","descricaoGlosa", cDesErro + " " + cObsErro)
		u_CBGRVXML( "F", "mensagemErro")
		If "autorizacaoProcedimento" $ cTagRet
			u_CBGRVXML( "F", "autorizacaoProcedimento")
		EndIf
		CorpoRaiz(cTranRet,cTagRet,.F.)
	EndIf

// Se a origem nao foi encontrada como rda pego o conteudo do arquivo
	If cRdaOri == PlsIntPad() .And. !Empty(cOrigem)
		cRdaOri := cOrigem
	EndIf

// Epilogo
	cHash := Epilogo()

// Para garantir que o lbuffer da logfil coloca o conteudo restante abuffer no arquivo
	PlsLogFil("",cFileTmp,.F.,,.T.,cDirTemp,.F.)

// Renomeia arquivo
	If File(cDirTemp+cFileTmp)

	//Cria diretorio se nao existir
		If !ExistDir(cDirCaiSa+cRdaOri)
			If MakeDir(cDirCaiSa+cRdaOri) <> 0
				u_CABLOGX("Imposs�vel criar diretorio ( "+cDirCaiSa+cRdaOri+" ) ") //"Impossível criar diretorio ( "###" ) "
				If fREname(cDirTemp+cFileTmp , cDirLog+"XMLERROGRA.TXT" ) == -1
					u_CABLOGX("N�o foi poss�vel criar arquivo de errolog ( "+cDirLog+"XMLERROGRA.TXT ) ") //"Não foi possível criar arquivo de errolog ( "
				EndIf
				If File(cDirTemp+cFileTmp) .And. FErase(cDirTemp+cFileTmp) == -1
					u_CABLOGX("N�o foi poss�vel deletar arquivo temporario XMLTMP") //"Não foi possível deletar arquivo temporario XMLTMP"
				EndIf
				lCriDir := .F.
			EndIf
		EndIf
		If lCriDir
			cArqRet := PLSMUDSIS( cRdaOri+"\"+StrZero(Val(cNumeLot),20)+"_"+cHash+".XML" )

		// Para garantir que o arquivo ja esta fechado
			While fREname(cDirTemp+cFileTmp , cDirCaiSa+cArqRet ) == -1 .And. nCont<=10
				nCont++
			EndDo
			If nCont>10
				u_CABLOGX("N�o�foi poss�vel criar arquivo ( "+PLSMUDSIS( cDirCaiSa+cRdaOri+"\"+StrZero(Val(cNumeLot),20)+"_"+cHash ) + " ) ") //### //### //"Não foi possível criar arquivo ( "###" ) "
			EndIf

			If File(cDirTemp+cFileTmp) .And. FErase(cDirTemp+cFileTmp) == -1
				u_CABLOGX("N�o foi poss�vel deletar arquivo temporario XMLTMP") //"Não foi possível deletar arquivo temporario XMLTMP"
			EndIf
		EndIf
	EndIf

// Registra a transacao
	If SIX->( MsSeek("BSA2") )
		BSA->( DbSetOrder(2) )//BSA_FILIAL + BSA_CONTEU
		If !BSA->( MsSeek( xFilial("BSA") + AllTrim(cRdaOri) + StrZero( Val(cNumeLot),20 ) + StrZero( Val(cNumeSeq),12 ) ) )
			BSA->( RecLock("BSA",.T.) )
			BSA->BSA_FILIAL := xFilial("BSA")
			BSA->BSA_NUMSEQ := DToS( Date() ) + StrTran( Time(),":","" )
			BSA->BSA_IDENT  := "XML"
			BSA->BSA_VARIAV := ""
			BSA->BSA_CONTEU := AllTrim(cRdaOri) + StrZero( Val(cNumeLot),20 ) + StrZero( Val(cNumeSeq),12 )
			If lVerTISS .And. BSA->( FieldPos("BSA_NOMAPL") ) > 0 .And. BSA->( FieldPos("BSA_VERAPL") ) > 0 .And. BSA->( FieldPos("BSA_FABAPL") ) > 0
				BSA->BSA_NOMAPL	:= cNomApl
				BSA->BSA_VERAPL	:= cVerApl
				BSA->BSA_FABAPL	:= cFabAPl
			EndIf
			BSA->( MsUnLock() )
		EndIf
	EndIf
Return cArqRet

/*/{Protheus.doc} Cabecalho
Cabecalho do Retorno
@type function
@author TOTVS
@since 04.02.08
@version 1.0
/*/
Static function Cabecalho(cEncod,cTranRet,cNumeSeq,cData,cTime,lFault,lFaultLoc,;
		cCodErro,cDesErro,cObsErro,cSusep,cTpCab,cCCCab,cVersao,cOrigem,cTagOri)
	LOCAL cNomPLS := "Microsiga Protheus Plano de Saude - SIGAPLS"
	LOCAL cVerPLS := GetBuild()
	LOCAL cFabPLS := "TOTVS S/A"

// Raiz
	u_CBGRVXML( "A","mensagemTISS",,,.T.,cEncod )

	// Inicio CABECALHO
	u_CBGRVXML( "A","cabecalho_identificacaoTransacao" )

	// Identificacao Transacao
	u_CBGRVXML( "AF","tipoTransacao",cTranRet)
	u_CBGRVXML( "AF","sequencialTransacao",AllTrim( cNumeSeq ) )
	u_CBGRVXML( "AF","dataRegistroTransacao",cData )
	u_CBGRVXML( "AF","horaRegistroTransacao",cTime )
	u_CBGRVXML( "F","identificacaoTransacao" )

	// Falha Negocio
	If lFault .Or. lFaultLoc
		If (TISVERS < "3")
			u_CBGRVXML( "A","falhaNegocio" )
			u_CBGRVXML( "AF","codigoGlosa",AllTrim(cCodErro) )
			u_CBGRVXML( "AF","descricaoGlosa",AllTrim(cDesErro) )
			u_CBGRVXML( "AF","observacao",Left(AllTrim(cObsErro),240) )
			u_CBGRVXML( "F","falhaNegocio" )
		Else
			//5002	NAO FOI POSSIVEL VALIDAR O ARQUIVO XML
			u_CBGRVXML( "AF","falhaNegocio",Iif (AllTrim(cCodErro) == "9999", "5002", AllTrim(cCodErro)))
		EndIf
	EndIf

	// Origem
	u_CBGRVXML( "A","origem" )
	u_CBGRVXML( "AF","registroANS",cSusep )
	u_CBGRVXML( "F","origem" )

	// Destino
	If lFault
		u_CBGRVXML( "A","destino" )
		If !Empty(cOrigem)
			u_CBGRVXML( "AF",cTagOri,cOrigem )
		Else
			u_CBGRVXML( "AF","registroANS",cSusep )
		EndIf
		u_CBGRVXML( "F","destino" )

	Else
		If (TISVERS < "3")
			u_CBGRVXML( "A","destino_codigoPrestadorNaOperadora" )
		Else
			u_CBGRVXML( "A","destino_identificacaoPrestador" )
		EndIf
		If !Empty(cTpCab)
			If cTpCab == "J"
				u_CBGRVXML( "AF","CNPJ",AllTrim(cCCCab) )
			Else
				u_CBGRVXML( "AF","CPF",AllTrim(cCCCab) )
			EndIf
		EndIf
		If (TISVERS < "3")
			u_CBGRVXML( "F","codigoPrestadorNaOperadora" )
		Else
			u_CBGRVXML( "F","identificacaoPrestador" )
		EndIf
		u_CBGRVXML( "F","destino" )
	EndIf

	// Versao
	u_CBGRVXML( "AF","Padrao",cVersao )

	// Se a versao for >= 2.02.02 cria a tag identificacaoSoftwareGerador
	If lVerTISS .AND. TISVERS < "3"
		IdenSWGer("identificacaoSoftwareGerador",cNomPLS,cVerPLS,cFabPLS)
	EndIf

	// Final do CABECALHO
	u_CBGRVXML( "F","cabecalho" )

Return

/*/{Protheus.doc} CorpoRaiz
Tag Raiz inicio e fim do conteudo da resposta
@type function
@author TOTVS
@since 04.02.08
@version 1.0
/*/
Static function CorpoRaiz(cTranRet,cTagRet,lTipo,lRepet)
	LOCAL cTagAux := ""
	Default lRepet := .F.

	If lTipo

	// Dados do OperadoraParaPrestador, cTagRet  INICIO
		If cTranRet == "RESPOSTA_SOLICITACAO"
			u_CBGRVXML( "A","operadoraParaPrestador" )
			cTagAux := cTagRet
		ElseIF (!lRepet)
			u_CBGRVXML( "A","operadoraParaPrestador_"+cTagRet)

		//Status da Autorizacao
			If cTranRet == "STATUS_AUTORIZACAO"
				If (TISVERS < "3")
					cTagAux := "dadosAutorizacao"
				Else
					cTagAux := "autorizacaoServico"
				EndIf
			EndIf
		ELSEIF (cTranRet == "DEMONSTRATIVO_ANALISE_CONTA" .AND. lRepet)
			u_CBGRVXML( "A","demonstrativoAnaliseConta")
		EndIf

	Else

	// Fechamento Tag
		If cTranRet <> "RESPOSTA_SOLICITACAO"
			u_CBGRVXML( "F",cTagRet)
		EndIf

		u_CBGRVXML( "F","operadoraParaPrestador")
	EndIf

Return(cTagAux)

/*/{Protheus.doc} Epilogo
Fim do retorno
@type function
@author TOTVS
@since 04.02.08
@version 1.0
/*/
Static function Epilogo()
	LOCAL cHash := ""
	u_CBGRVXML( "A","epilogo")
	cHash := u_CBGRVXML( "AF","hash","" )
	u_CBGRVXML( "F","epilogo")
	u_CBGRVXML( "F","mensagemTISS")

Return(cHash)

/*/{Protheus.doc} Beneficiario
Implementa dados da tag Beneficiario
@type function
@author TOTVS
@since 04.02.08
@version 1.0
/*/
Static function Beneficiario(cTag,cMatric,cNomeUsu,cAtendRn)
	LOCAL cPlano := "PLANO NAO ENCONTRADO"

	DEFAULT cAtendRn := "N"

	If (TISVERS < "3")
		BA3->( DbSetOrder(1) ) //BA3_FILIAL + BA3_CODINT + BA3_CODEMP + BA3_MATRIC + BA3_CONEMP + BA3_VERCON + BA3_SUBCON + BA3_VERSUB
		If BA3->( MsSeek( xFilial("BA3")+Subs( PPLTROMAT(cMatric) ,1,14 ) ) )
			BI3->( DbSetOrder(1) )//BI3_FILIAL + BI3_CODINT + BI3_CODIGO + BI3_VERSAO
			If BI3->(MsSeek(xFilial("BI3")+BA3->(BA3_CODINT+BA3_CODPLA+BA3_VERSAO) ) )
				cPlano := AllTrim(BI3->BI3_NREDUZ)
			EndIf
		Endif
	EndIf

// Beneficiario INICIO
	u_CBGRVXML( "A",cTag )
	u_CBGRVXML( "AF","numeroCarteira",cMatric )
	If (TISVERS >= "3")
		u_CBGRVXML( "AF","atendimentoRN",cAtendRn )
	EndIf
	u_CBGRVXML( "AF","nomeBeneficiario",cNomeUsu )
	If (TISVERS < "3")
		u_CBGRVXML( "AF","nomePlano",cPlano )
	EndIf
	u_CBGRVXML( "F",cTag )

// Beneficiario Fim


Return

/*/{Protheus.doc} DadosOperadora
Implementa a tag dados da operadora
@type function
@author TOTVS
@since 04.02.08
@version 1.0
/*/
Static function DadosOperadora(cTag)

// DadosOperadora INICIO
	If !Empty(cTag)
		u_CBGRVXML( "A",cTag )
	EndIf

	If !Empty(BA0->BA0_SUSEP)
		u_CBGRVXML( "A","operadoraRegulada")
		u_CBGRVXML( "AF","registroANS",AllTrim(BA0->BA0_SUSEP) )
		u_CBGRVXML( "AF","CNPJ",AllTrim(BA0->BA0_CGC) )
		u_CBGRVXML( "AF","nomeOperadora",AllTrim(BA0->BA0_NOMINT) )
		u_CBGRVXML( "F","operadoraRegulada")
	Else
		u_CBGRVXML( "A","entidadeNaoRegulada")
		u_CBGRVXML( "AF","CNPJ",AllTrim(BA0->BA0_CGC) )
		u_CBGRVXML( "AF","nomeOperadoraEntidade",AllTrim(BA0->BA0_NOMINT) )
		u_CBGRVXML( "F","entidadeNaoRegulada")
	EndIf

	If !Empty(cTag)
		u_CBGRVXML( "F",cTag )
	EndIf

// DadosOperadora FIM


Return

/*/{Protheus.doc} DadosPrestador
Implementa a tag dados da prestador
@type function
@author TOTVS
@since 04.02.08
@version 1.0
/*/
Static function DadosPrestador(cTag,cTpPessoa,cCPFCGC,cNomeRda,cRda)

// DadosPrestador INICIO
	u_CBGRVXML( "A",cTag )
	If (TISVERS < "3")
		u_CBGRVXML( "A","identificacao" )
		If !Empty(cTpPessoa)
			If cTpPessoa == "J"
				u_CBGRVXML( "AF","CNPJ",cCPFCGC )
			Else
				u_CBGRVXML( "AF","CPF",cCPFCGC )
			Endif
		Else
			u_CBGRVXML( "AF","codigoPrestadorNaOperadora",cRda )
		EndIf
		u_CBGRVXML( "F","identificacao" )
	Else
		If !Empty(cTpPessoa)
			If cTpPessoa == "J"
				u_CBGRVXML( "AF","cnpjContratado",cCPFCGC )
			Else
				u_CBGRVXML( "AF","cpfContratado",cCPFCGC )
			Endif
		Else
			u_CBGRVXML( "AF","codigoPrestadorNaOperadora",cRda )
		EndIf
	EndIf
	u_CBGRVXML( "AF","nomeContratado",cNomeRda )
	u_CBGRVXML( "F",cTag )

Return

/*/{Protheus.doc} Procedimento
Implementa a tag de procedimento
@type function
@author TOTVS
@since 04.02.08
@version 1.0
/*/
Static function Procedimento(cTag,cCodpro,cCodPad,cOpeMov,cDescric,cVersao,cSlvPad,cSlvPro)
	LOCAL cLocalExec	:= "5"
	LOCAL cTipoGrv		:= "1"
	LOCAL cCodTabela	:= ""
	LOCAL cCodProc		:= ""
	DEFAULT cDescric	:= ''
	DEFAULT cCodpro 	:= ''
	DEFAULT cCodPad 	:= ''
	DEFAULT cOpeMov		:= PlsIntPad()
	DEFAULT cVersao     := GetNewPar("MV_TISSVER","2.02.03")
	DEFAULT cSlvPad		:= ''
	DEFAULT cSlvPro     := ''
	PRIVATE aTabDup := PlsBusTerDup(SuperGetMv("MV_TISSCAB", .F. ,"87"))

	If (TISVERS < "3")
		If PLSPOSGLO(cOpeMov,__aCdCri198[1],__aCdCri198[2],cLocalExec,"1",cTipoGrv)
			aRetTuss := PLSDPTUSS('S',cCodPad,cCodPro)
			If !Empty(aRetTuss[1])
				cCodPad := aRetTuss[1]
				cCodPro := aRetTuss[2]
				cCodPro := padr(cCodPro,tamsx3("BR8_CODPSA")[1])
			EndIf
		EndIf
		u_CBXPAD(@cCodPad,@cCodPro,@cDescric,nil,nil,cVersao)
	Endif

// Procedimento INICIO
	u_CBGRVXML( "A",cTag )
	If (TISVERS < "3")
		u_CBGRVXML( "AF","codigo",cCodpro )
		u_CBGRVXML( "AF","tipoTabela",cCodPad )
	Else
        //retorno sempre o que foi enviado no xml
		If !Empty(cSlvPad+cSlvPro)
			u_CBGRVXML( "AF","codigoTabela",  cSlvPad)
			u_CBGRVXML( "AF","codigoProcedimento", cSlvPro)
			u_CBGRVXML( "AF","descricaoProcedimento", EncodeUtf8(PLSNoAcento(Left(Alltrim(cDescric), 150))) )
		Else

			BR8->(DbSetOrder(3)) //BR8_FILIAL+BR8_CODPSA+BR8_CODPAD
			If (BR8->(MsSeek(xFilial("BR8")+cCodpro+cCodPad)))

				cPadBkp 	:= PLSGETVINC("BTU_CDTERM", "BR4", .F., "87",  cCodPad,.T.)

				cCodProc 	:= PLSGETVINC("BTU_CDTERM", "BR8", .F., cCodPad,  Alltrim(cCodPad+cCodpro), .F. ,aTabDup, @cPadBkp)
				cCodTabela  := cPadBkp
				cDescric 	:= PLSGETVINC("BTQ_DESTER", "BR8", .F., cCodTabela,  Alltrim(cCodPad+cCodpro))


				If (Empty(cCodTabela))
					// NÃO PODE RETORNAR PARA O PRESTADOR QUE NÃO TEM DE/PARA POIS ESSA É UMA INFORMAÇÃO
					// PERTINENTE AO CADASTRO DA OPERADORA DEVE SER VERIFICADO DENTRO DO PLS PLSLOGFIL
					//u_CABLOGX("Codigo da Tabela nao encontrado no De/Para.",.F.)
					PLSLOGFIL( "TransacoesOnline: Codigo da Tabela nao encontrado no De/Para. " + Time(),DIRLOG+"ONLINELOG.TXT" )
					u_CBGRVXML( "AF","codigoTabela",  cCodPad)
				Else
					u_CBGRVXML( "AF","codigoTabela",  cCodTabela)
				EndIf
				If (Empty(cCodProc))
					// NÃO PODE RETORNAR PARA O PRESTADOR QUE NÃO TEM DE/PARA POIS ESSA É UMA INFORMAÇÃO
					// PERTINENTE AO CADASTRO DA OPERADORA DEVE SER VERIFICADO DENTRO DO PLS PLSLOGFIL
					//u_CABLOGX("Codigo do Procedimento nao encontrado no De/Para. "+BR8->(BR8_CODPAD+BR8_CODPSA),.F.)
					PLSLOGFIL( "TransacoesOnline: Codigo do Procedimento nao encontrado no De/Para. "+BR8->(BR8_CODPAD+BR8_CODPSA) + " " + Time(),DIRLOG+"ONLINELOG.TXT" )
					u_CBGRVXML( "AF","codigoProcedimento", cCodPro)
					cDescric := "PROCEDIMENTO GENÉRICO"
				Else
					u_CBGRVXML( "AF","codigoProcedimento", cCodProc)
				EndIf
			Else
				//u_CABLOGX("Procedimento nao encontrado. "+cCodPad+cCodpro,.F.)
				PLSLOGFIL( "Procedimento nao encontrado. "+cCodPad+cCodpro + " " + Time(),DIRLOG+"ONLINELOG.TXT" )
			EndIf
			u_CBGRVXML( "AF","descricaoProcedimento", cDescric )
		Endif
	EndIf
	u_CBGRVXML( "F",cTag )

// Procedimento INICIO


Return

/*/{Protheus.doc} Glosa
Implementa a tag de Glosa
@type function
@author TOTVS
@since 04.02.08
@version 1.0
/*/
Static function Glosa(cTag,cCodGlo,cDesGlo)
	Local aTag := StrTokarr(cTag, "_")
	Local nI := Len(aTag)

// Glosa INICIO
	u_CBGRVXML( "A",cTag )

	u_CBGRVXML( "AF","codigoGlosa",cCodGlo )
	u_CBGRVXML( "AF","descricaoGlosa",cDesGlo )

	For nI := Len(aTag) To 1 Step -1
		u_CBGRVXML( "F",aTag[nI] )
	Next

// Glosa FIM


Return

/*/{Protheus.doc} IdentAutorizacao
Implementa a tag de Glosa
@type function
@author TOTVS
@since 04.02.08
@version 1.0
/*/
Static function IdentAutorizacao(cTag,cData,cNumGui,cNumAut)

// IdentificacaoAutorizacao INICIO
	u_CBGRVXML( "A",cTag )

	u_CBGRVXML( "A","identificacaoFontePagadora" )
	u_CBGRVXML( "AF","registroANS",AllTrim(BA0->BA0_SUSEP) )
	u_CBGRVXML( "F","identificacaoFontePagadora" )
	cData := U_CBXMLDTV(cData)
	u_CBGRVXML( "AF","dataEmissaoGuia", cData )
	u_CBGRVXML( "AF","numeroGuiaPrestador",cNumGui )
	If !Empty(cNumAut)
		u_CBGRVXML( "AF","numeroGuiaOperadora",cNumAut )
	EndIf

	u_CBGRVXML( "F",cTag )


Return

/*/{Protheus.doc} DadosAutorizacao
Implementa a tag de dadosAutorizacao
@type function
@author TOTVS
@since 25.10.13
@version 1.0
/*/
Static Function DadosAutorizacao(cTag, cNumGui, cNumAut, cNumSen)
	u_CBGRVXML( "A",cTag )
	u_CBGRVXML( "AF", "numeroGuiaPrestador", cNumGui)
	If (!Empty(cNumAut))
		u_CBGRVXML( "AF", "numeroGuiaOperadora", cNumAut)
	EndIF
	If (!Empty(cNumSen))
		u_CBGRVXML( "AF", "senha", cNumSen)
	EndIf
	u_CBGRVXML( "F",cTag )
Return

/*/{Protheus.doc} u_CBGRVXML
Grava arquivo xml
@type function
@author TOTVS
@since 31.05.07
@version 1.0
/*/
User Function CBGRVXML(cTp,cDescri,cConteudo,cNameSpace,lRaiz,cEncod,lUpper)
	LOCAL nI			:= 0
	LOCAL lHash 		:= Iif(cDescri=="hash",.T.,.F.)
	LOCAL aRet 			:= U_CABARRAY(cDescri,"_")[3]
	DEFAULT lRaiz		:= .F.
	DEFAULT cNameSpace	:= Iif(lVerTISS,"ansTISS","ans")
	DEFAULT cConteudo	:= ""
	DEFAULT cEncod	 	:= "ISO-8859-1"
	DEFAULT lUpper		:= .T.



// Cria ou abre o arquivo
	For nI:=1 To Len(aRet)
		cDescri := aRet[nI]

	// Retirna acentuacao
		If !Empty(cConteudo)
			If lUpper
				cConteudo := Upper( u_CBXMLTACE( AllTrim( cConteudo) ) )
			Else
				cConteudo := u_CBXMLTACE( AllTrim( cConteudo) )
			EndIf
		Else
			cConteudo := Upper( u_CBXMLTACE( 'NULL' ) )
		EndIf

	// Ajusta tag
		Do Case
		Case cTp == "A"
			If lRaiz
				If lVerTISS
					cDescri := '<?xml version="1.0" encoding="'+AllTrim(cEncod)+'"?>'+Chr(10)+'<'+cNameSpace+':'+cDescri+' xsi:schemaLocation="http://www.ans.gov.br/padroes/tiss/schemas http://www.ans.gov.br/padroes/tiss/schemas" xmlns:'+StrTran(cPrefANS,":","")+'="http://www.ans.gov.br/padroes/tiss/schemas" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">'
				Else
					cDescri := '<?xml version="1.0" encoding="'+AllTrim(cEncod)+'"?>'+Chr(10)+'<'+cNameSpace+':'+cDescri+' xmlns:ans="http://www.ans.gov.br/padroes/tiss/schemas">'
				EndIF
			Else
				cDescri := "<"+cNameSpace+":"+cDescri+">"
			EndIf
		Case cTp == "F"
			cDescri := "</"+cNameSpace+":"+cDescri+">"
		Case cTp == "AF"

			// Junta o conteudo para calculo do HASH
			If !Empty( cConteudo ) .And. cConteudo <> 'NULL'
				cValHash += cConteudo
			EndIf

			// Calcula o HASH
			If lHash
				cConteudo := Upper( MD5(cValHash,2) )
				cValHash  := ""
			EndIf

			// Monta elemento e conteudo
			If !Empty( cConteudo )
				cDescri := "<"+cNameSpace+":"+cDescri+">" + cConteudo + "</"+cNameSpace+":"+cDescri+">"
			Else
				cDescri := ""
			EndIf
		EndCase

	// Insere elementos e tags
		If !Empty(cDescri)
			If At("ISO",Upper(cEncod) ) > 0
				PlsLogFil(cDescri,cFileTmp,.T.,,.T.,cDirTemp,.F.)
			Else
				PlsLogFil(EncodeUtf8(cDescri),cFileTmp,.T.,,.T.,cDirTemp,.F.)
			EndIf
		EndIf
	Next





Return(cConteudo)

/*/{Protheus.doc} AjCriticas
Ajusta criticas
@type function
@author TOTVS
@since 04.02.08
@version 1.0
/*/
Static function AjCriticas(aMatCri)
	LOCAL nY 	  := 0
	LOCAL lCriCab := .F.
	LOCAL aMatAux := {}
	LOCAL aRetCri := {}

	For nY := 1 To Len(aMatCri)
		If !Empty( aMatCri[nY,2] )
			If Empty( aMatCri[nY,5] )
				lCriCab := .T.
			EndIf
			aRetCri := PLSRETCRI(aMatCri[nY,2])
			AaDd( aMatAux,{ AllTrim(aMatCri[nY,1]+aMatCri[nY,5]),aRetCri[1,1],aRetCri[1,2],aRetCri[1,3] } )
		EndIf
	Next

Return( { aMatAux,lCriCab } )

/*/{Protheus.doc} U_CBXMLDTV
Ajusta data conforme versao
@type function
@author TOTVS
@since 13.06.08
@version 1.0
/*/
User Function CBXMLDTV(cData)

	If StrTran(TISVERS,"_",".") == "2.01.03"
		cData := SubStr(cData,7,2)+"/"+SubStr(cData,5,2)+"/"+SubStr(cData,1,4)
	Else
		cData := SubStr(cData,1,4)+"-"+SubStr(cData,5,2)+"-"+SubStr(cData,7,2)
	EndIf

Return(cData)

/*/{Protheus.doc} U_CBXMLDTV
Ajusta sequen conforme liberacao
@type function
@author TOTVS
@since 13.06.08
@version 1.0
PLSAJULIB
/*/
User Function cbAJULIB(cNumLib,aItens)
	LOCAL nI	  := 0
	LOCAL cSeqMax := '001'
	LOCAL aAuxSeq := {}

// Posiciona na liberacao														³
	BEA->( DbSetOrder(1) ) //BEA_FILIAL + BEA_OPEMOV + BEA_ANOAUT + BEA_MESAUT + BEA_NUMAUT
	If BEA->( MsSeek(xFilial("BEA")+cNumLib) )
		BE2->( DbSetOrder(1) )//BE2_FILIAL + BE2_OPEMOV + BE2_ANOAUT + BE2_MESAUT + BE2_NUMAUT + BE2_SEQUEN
		If BE2->( MsSeek(xFilial("BE2")+BEA->(BEA_OPEMOV+BEA_ANOAUT+BEA_MESAUT+BEA_NUMAUT)) )

		// Limpa as sequencias															³
			For nI:=1 To Len(aItens)
				PLSPUTDAD(aItens[nI],"SEQMOV","")
			Next

		// Atualiza a sequencia														³
			While ! BE2->( Eof() ) .And. BE2->(BE2_FILIAL+BE2_OPEMOV+BE2_ANOAUT+BE2_MESAUT+BE2_NUMAUT) == ;
					xFilial("BE2")+BEA->(BEA_OPEMOV+BEA_ANOAUT+BEA_MESAUT+BEA_NUMAUT)

			// Atualiza ou limpa a sequencia												³
				For nI:=1 To Len(aItens)
					cSeqMov := PLSRETDAD(aItens[nI],"SEQMOV")

					If !Empty(cSeqMov)
						Loop
					EndIf

					cCodPad := PLSRETDAD(aItens[nI],"CODPAD")
					cCodPro := PLSRETDAD(aItens[nI],"CODPRO")

					If AllTrim( cCodPad+cCodPro ) == AllTrim( BE2->(BE2_CODPAD+BE2_CODPRO) )
						PLSPUTDAD(aItens[nI],"SEQMOV",BE2->BE2_SEQUEN)
						aAdd(aAuxSeq,BE2->BE2_SEQUEN)
						If BE2->BE2_SEQUEN > cSeqMax
							cSeqMax := BE2->BE2_SEQUEN
						EndIf
						Exit
					EndIf
				Next

				BE2->(DbSkip())
			EndDo
		EndIf

	// Verifica se tem algum item sem sequencia e coloca o max + 1					³
		aSort(aAuxSeq)
		cSeqMov := "001"

		For nI := 1 TO Len(aItens)
			If Empty(PLSRETDAD(aItens[nI],"SEQMOV"))
				cSeqMov := NextSeq(aAuxSeq,cSeqMov)
				PLSPUTDAD(aItens[nI],"SEQMOV",cSeqMov)
				cSeqMov := Soma1(cSeqMov)
			EndIf
		Next
	EndIf

Return

/*/{Protheus.doc} NextSeq
Retorna a proxima sequencia para o aItens
@type function
@author TOTVS
@since 31/08/2016
@version 1.0
/*/
Static Function NextSeq(aAuxSeq,cSeqMov)
	Local nFor	:= 0
	Default aAuxSeq := {}
	Default cSeqMov := "001"

	For nFor := 1 TO Len(aAuxSeq)
		If aScan(aAuxSeq,{|x| AllTrim (x) == AllTrim(cSeqMov)}) > 0
			cSeqMov := Soma1(cSeqMov)
		EndIf
	Next nFor

Return cSeqMov

/*/{Protheus.doc} IdenSWGer
Implementa a tag identificacaoSoftwareGerador
@type function
@author TOTVS
@since 10/12/10
@version 1.0
/*/
Static function IdenSWGer(cTag,cNomApl,cVerApl,cFabApl)

	u_CBGRVXML("A",cTag)

	u_CBGRVXML("AF","nomeAplicativo",cNomApl)
	u_CBGRVXML("AF","versaoAplicativo",cVerApl)
	u_CBGRVXML("AF","fabricanteAplicativo",cFabApl)

	u_CBGRVXML("F",cTag)

Return

/*/{Protheus.doc} ValorTotal
Implementa o ComplexType ct_valorTotal
@type function
@author TOTVS
@since 30/10/13
@version 1.0
/*/
Static function ValorTotal(cTag,cVlrProces,cVlrGlosa,cVlrLibera)

	u_CBGRVXML("A",cTag)

	u_CBGRVXML("AF","valorProcessado",cVlrProces)
	u_CBGRVXML("AF","valorGlosa",cVlrGlosa)
	u_CBGRVXML("AF","valorLiberado",cVlrLibera)

	u_CBGRVXML("F",cTag)
Return

/*/{Protheus.doc} U_CBRConTPA
Carga inicial de dados
@type function
@author TOTVS
@since 17.01.20
@version 1.0
/*/
User Function CBRConTPA()
	LOCAL aLista    := {}
	LOCAL aTpPart	:= {}

	BKC->(DbSetOrder(1))
	BD3->(DbSetOrder(1))
	BD3->(DbGotop())

	While ! BD3->(Eof())
		aLista := {}
		If BKC->(DbSeek(xFilial("BKC")+BD3->BD3_CODIGO+PLSINTPAD()))
			While ! BKC->(Eof()) .And. BKC->(BKC_FILIAL+BKC_CODIGO+BKC_CODOPE) == xFilial("BKC")+BD3->BD3_CODIGO+PLSINTPAD()
				aadd(aLista,{AllTrim(BKC->BKC_CODPAR),AllTrim(BKC->BKC_CODIGO)})
				BKC->(DbSkip())
			Enddo
		Endif
		aadd(aTpPart,{BD3->BD3_CODIGO,aLista})
		BD3->(DbSkip())
	Enddo

Return aTpPart

/*/{Protheus.doc} u_CXMLUsrGe
(long_description)
@type function
@author TOTVS
@since 17.01.20
@version 1.0
/*/
User Function CXMLUsrGe(cOpeOri)
	LOCAL cMatric
	LOCAL cCodInt
	LOCAL cCodEmp 		:= GetNewPar("MV_PLSGEIN","0001")
	LOCAL cModulo   	:= Modulo11(cOpeOri+cCodEmp+"99999999")
	LOCAL cMatrAntGen   := cOpeOri+cCodEmp+"99999999"+cModulo
	LOCAL cNomeUsr 		:= "USUARIO GENERICO"
	LOCAL aRet		    := {}

// Verifica se existe o usuario generico...
	BA1->(DbSetOrder(5))
	If ! BA1->(MsSeek(xFilial("BA1")+cMatrAntGen))

      // Se nao existir inclui...
		cCodInt := PLSINTPAD()
		cMatric := PLPROXMAT(cCodInt,cCodEmp)

		BA3->(RecLock("BA3",.T.))
		BA3->BA3_FILIAL := xFilial("BA3")
		BA3->BA3_CODINT := cCodInt
		BA3->BA3_CODEMP := cCodEmp
		BA3->BA3_ROTINA := "IMPXML"
		BA3->BA3_MATRIC := cMatric
		BA3->BA3_MATANT := cMatrAntGen
		BA3->BA3_HORACN := StrTran(SubStr(Time(),1,5),":","")
		BA3->BA3_COBNIV := "0"
		BA3->BA3_VENCTO := 0
		BA3->BA3_DATBAS := dDataBase
		BA3->BA3_DATCIV := dDataBase
		BA3->BA3_TIPOUS := "2"
		BA3->BA3_USUOPE := PLSRtCdUsr()
		BA3->BA3_MODPAG := "2"
		BA3->BA3_CODPLA := GetNewPar("MV_PLSPLPE","0001")
		BA3->BA3_VERSAO := GetNewPar("MV_PLSVRPE","0001")
		BA3->BA3_FORPAG := GetNewPar("MV_PLSFCPE","101")
		BA3->BA3_DATCON := Date()
		BA3->BA3_HORCON := StrTran(SubStr(Time(),1,5),":","")
		BA3->(MsUnLock())

		BA1->(RecLock("BA1",.T.))
		BA1->BA1_FILIAL := xFilial("BA1")
		BA1->BA1_CODINT := BA3->BA3_CODINT
		BA1->BA1_CODEMP := BA3->BA3_CODEMP
		BA1->BA1_MATRIC := BA3->BA3_MATRIC
		BA1->BA1_CONEMP := BA3->BA3_CONEMP
		BA1->BA1_VERCON := BA3->BA3_VERCON
		BA1->BA1_SUBCON := BA3->BA3_SUBCON
		BA1->BA1_VERSUB := BA3->BA3_VERSUB
		BA1->BA1_IMAGE  := "ENABLE"
		BA1->BA1_TIPREG := "00"//MUDAR
		BA1->BA1_DIGITO := Modulo11(BA1->BA1_CODINT+BA1->BA1_CODEMP+BA1->BA1_MATRIC+BA1->BA1_TIPREG)
		BA1->BA1_NOMUSR := cNomeUsr
		BA1->BA1_TIPUSU := SuperGetMv("MV_PLCDTIT")
		BA1->BA1_GRAUPA := GetMv("MV_PLCDTGP")
		If BA1->(FieldPos("BA1_ENDCLI")) > 0
			BA1->BA1_ENDCLI := "0"
		Endif
		BA1->BA1_SEXO   := ""
		BA1->BA1_MATEMP := ""
		BA1->BA1_MATANT := cMatrAntGen
		BA1->BA1_ESTCIV := ""
		BA1->BA1_CPFUSR := ""
		BA1->BA1_DRGUSR := ""
		BA1->BA1_DATINC := ctod("")
		BA1->BA1_DATNAS := ctod("")
		BA1->BA1_DATCAR := ctod("")
		BA1->BA1_CBTXAD := "1"
		BA1->BA1_OPEORI := cOpeOri
		BA1->BA1_OPEDES := cCodInt
		BA1->BA1_OPERES := cCodInt
		BA1->BA1_LOCATE := "2"
		BA1->BA1_LOCCOB := "2"
		BA1->BA1_LOCEMI := "2"
		BA1->BA1_LOCANS := "2"
		BA1->(MsUnLock())

      // Esta funcao analise a criacao de uma nova vida ou nao...
		PLSA766ANV(nil,.F.)

      // Grava no usuario a vida criada ou a ja existente...
		BA1->(RecLock("BA1",.F.))
		BA1->BA1_MATVID := BTS->BTS_MATVID
		BA1->(MsUnLock())
	Endif

Return(aRet)

/*/{Protheus.doc} u_cRtPos
@type function
@author TOTVS
@since 17.01.05
@version 1.0
/*/
User Function cRtPos(cCampo,aArray)
	LOCAL nPos := 0

Return aScan(aArray,{|x| x[1] == cCampo})

/*/{Protheus.doc} u_C973VlrPro
@type function
@author TOTVS
@since 17.01.05
@version 1.0
/*/
User Function C973VlrPro(cCodRda,cCodPad,cCodPro,cMatric)
	LOCAL nValor		:= 0
	LOCAL cAno			:= ""
	LOCAL cMes			:= ""
	LOCAL aDadUsr		:= PLSDADUSR(cMatric,'1',.F.,dDatabase,,,"NAO_VALIDAR_CARTAO")
	LOCAL aDadRDA		:= PLSDADRDA(PlsIntPad(),cCodRda,"1",dDataBase,"","")

	cAno := Alltrim(Str(Year(dDataBase)))
	cMes := Alltrim(Str(month(dDataBase)))


// Retorna Valor
	aValor := PLSCALCEVE(cCodPad,cCodPro,cMes,cAno,;
		PlsIntPad(),cCodRda,aDadRDA[15],"",;
		aDadRDA[12],1,dDataBase,"1",/*cPadInt*/ "",/*::RegAte*/,0,aDadUsr,"",;
		{},nil,nil,nil,nil,"",{},nil,"",0,{},nil,dDataBase,"",{},"",.F.,0,{},nil,;
		.F.,100,"","",1,1,{},"","",,,/*::RegInt*/,"","")

	If ValType(aValor) == "A"
		If Len(aValor) >= 2
			nValor := aValor[2]
		Endif
	Endif

Return nValor

/*/{Protheus.doc} u_CBRetUnp
Dada uma participacao retorna as unidades que estao a ela relacionadas
@type function
@author TOTVS
@since 17.01.05
@version 1.0
/*/
User Function CBRetUnp(cTipPar)
	LOCAL aRet  := {}
	LOCAL aUnds := {}

	If Type('__Xudns') == 'U'
		PUBLIC __Xudns := {}
	Endif

	nI:= aScan(__Xudns,{|x| alltrim(x[1]) == alltrim(cTipPar) })
	If nI > 0
		aRet := __Xudns[nI][2]
	Else
		cSql := " SELECT BKC_CODIGO FROM "+RetSqlName('BKC')
		cSql += " WHERE BKC_FILIAL = '"+xFilial('BKC')+"' "
		cSql += " AND BKC_CODPAR = '"+cTipPar+"' "
		cSql += " AND D_E_L_E_T_ = ' ' "
		cSql := ChangeQuery(cSql)
		dbUseArea(.T.,"TOPCONN",TCGENQRY(,,cSql),"PLBKC",.F.,.T.)

		While !PLBKC->(Eof())
			aadd(aUnds,alltrim(PLBKC->BKC_CODIGO))
			PLBKC->(DbSkip())
		Enddo
		aadd(__Xudns,{alltrim(cTipPar),aUnds})
		aRet := __Xudns[Len(__Xudns)][2]
		PLBKC->(DbCloseArea())
	Endif

Return aRet

/*/{Protheus.doc} PlsAjsArT
Ajusta a posição do Array que na TISS 2 esta dif da TISS 3
@type function
@author TOTVS
@since 15/01/14
@version 1.0
/*/
Static Function PlsAjsArT(aMatAjus, nPos)
	Local nI 		:= 0
	Local cPos2	:= ""
	Local cPos3	:= ""

	Default nPos := 0
	If nPos > 0
		For nI := 1 to Len(aMatAjus[nPos])
			cPos2	:= aMatAjus[nPos,nI,2]
			If "\" $ cPos2
				cPos3	:= aMatAjus[nPos,nI,3]
				aMatAjus[nPos,nI,2] := cPos3
				aMatAjus[nPos,nI,3] := cPos2
			EndIf
		Next nI
	Else
		For nI := 1 to Len(aMatAjus)
			cPos2	:= aMatAjus[nI,2]
			If "\" $ cPos2
				cPos3	:= aMatAjus[nI,3]
				aMatAjus[nI,2] := cPos3
				aMatAjus[nI,3] := cPos2
			EndIf
		Next nI
	EndIf

Return()

/*/{Protheus.doc} u_CBLGSP3
Processamento da importacao do XML. Prepara os dados e os envia ao PLSXMOV para gravação
#tissver 2.x,3.x

@type Function
@author PLS
@since 16/01/2014
@version 1.0
/*/
User Function CBLGSP3(cGuia,cNomeArq,cDatHor,aMatC,aMatM,lHasAr,lHasCo,lLotGui,cCodPeg,lOk,nSeqGui,aMatBWT, lBg, l974Xml)
	LOCAL nCont	  	:= 0
	LOCAL nQtd		:= 0
	LOCAL nIdx		:= 0
	LOCAL nPos		:= 1
	LOCAL nPosVlrApr:= 0
	LOCAL nPosXX	:= 1
	LOCAL cTpCab 	:= ""
	LOCAL cCCCab	:= ""
	LOCAL cTipo 	:= ""
	LOCAL cOrigem	:= ""
	LOCAL cObs		:= ""
	LOCAL cSigla  	:= ""
	LOCAL cCrm 	  	:= ""
	LOCAL cUf 	  	:= ""
	LOCAL cCodRP	:= ""
	LOCAL cCodProf	:= ""
	LOCAL cRdaPro  	:= ""
	LOCAL cRdaCon  	:= ""
	LOCAL cRdaOri  	:= ""
	LOCAL cNomRda	:= ""
	LOCAL cNomCont	:= ""
	LOCAL cMatric	:= ""
	LOCAL cNomeUsu	:= ""
	LOCAL cData		:= ""
	LOCAL cHora		:= ""
	LOCAL cDataHora := ""
	LOCAL cDtFimFat := ""
	LOCAL cHrFimFat := ""
	LOCAL cDtIniFat := ""
	LOCAL cHrIniFat := ""
	LOCAL cNumSen	:= ""
	LOCAL cNumeLot  := ""
	LOCAL cNumeSeq	:= ""
	LOCAL cNumImp	:= ""
	LOCAL cNumAut	:= ""
	LOCAL cLocalExec:= "1"
	LOCAL cTipoGrv  := "1"
	LOCAL cNumEvo	:= ""
	LOCAL cCodPad	:= ""
	LOCAL cCodPadAlt:= ""
	LOCAL cTpPessoa	:= ""
	LOCAL cCPFCGC	:= ""
	LOCAL cCNES		:= ""
	LOCAL cCodLoc		:= ""
	LOCAL cIdenfic  := ""
	LOCAL cNumImpOp	:= ""
	LOCAL cNumEvoOp := ""
	LOCAL cCrmRda   := ""
	LOCAL cSlgRda   := ""
	LOCAL cEstRda   := ""
	LOCAL cNomPre	:= ""
	LOCAL cPosPro	:= ""
	LOCAL cOpeExe	:= ""
	LOCAL cProExe	:= ""
	LOCAL cCodPro   := ""
	LOCAL cCodProAlt:= ""
	LOCAL cNumSolInt:= ""
	LOCAL cGuiPri	:= ""
	LOCAL cNumeDNAux:= ""
	LOCAL cNumeDN	:= ""
	LOCAL cTipPro	:= ""
	LOCAL cDescric	:= ""
	LOCAL cConPrEx 	:= ""
	LOCAL cNomRdEx 	:= ""
	LOCAL cTagDia2  := ""
	LOCAL cTagDia3	:= ""
	LOCAL cTagDia4	:= ""
	LOCAL cTagDia5	:= ""
	LOCAL cTipPOr	:= ""
	LOCAL cSeqBXX   := ""
	LOCAL cVersao   := StrTran(TISVERS,"_",".")
	LOCAL nTamObs   := (TamSX3("BEA_MSG01")[1])
	LOCAL cOpeMov	:= PlsIntPad()
	LOCAL cArqImp   := Left( cNomeArq,At(".",cNomeArq)-1 )
	LOCAL lEvolu	:= .F.
	LOCAL lInter	:= .F.
	LOCAL lResInt   := .F.
	LOCAL lHonor	:= .F.
	LOCAL lAchouVlr := .F.
	LOCAL lImpXml   := .T.
	LOCAL aTpPRec	:= {}
	LOCAL aRet    	:= {}
	LOCAL aRetAux	:= {}
	LOCAL aDados  	:= {}
	LOCAL aEspCbXML	:= {}
	LOCAL aMatIte 	:= {}
	LOCAL aEspItXML	:= {}
	LOCAL aItens  	:= {}
	LOCAL aRetTag	:= {}
	LOCAL aMatPro	:= {}
	LOCAL aMatEqu	:= {}
	LOCAL bBlockXml	:= nil
	Local cCodldp	:=	""
	Local cChave	:=	""
	LOCAL nIndUt	:=	0
	LOCAL nInd1		:= 0
	LOCAL nI		:= 1
	LOCAL nE		:= 1
	LOCAL nP		:= 1
	LOCAL lNMudFs	:= .F.
	LOCAL dDatAcat  := dDataBase
	LOCAL nZ		:= 0
	LOCAL nt		:= 0
	LOCAL cCnpjPres :=""
	LOCAL nJ	    :=0
	LOCAL nValorTotG:= 0
	LOCAL nVlrTotPrc:= 0
	LOCAL cPadConSol:= ""
	LOCAL cCidSol	:= ""
	LOCAL nDiasSol	:= 0
	LOCAL nRedAcr 	:= 0
	LOCAL cEspPro	:= ""
	LOCAL aRetPe		:= ""
	LOCAL cEspExe		:= ""
	LOCAL cCodEsp		:= ""
	LOCAL cEspSol	:= ""
	LOCAL cCboSol		:= ""
	LOCAL cCboExe		:= ""
	LOCAL lNInfPar	:= .F.
	Local dDataAnt := u_CBAJUDAT("")
	LOCAL lCalAcr		:= GetNewPar("MV_PLCLACR",.T.)
	Local nLimite		:= 1 //Essa variavel ira tratar se a ocorrencia da Tag esta dentro do procedimento atual.
						 			//Eh usado no u_CPEGCONR, ultimo parametro atual [nLimitPes]. Caso ocorra uma situacao
						 			//Em que uma tag de um procedimento esta sendo considerada em um outro procedimento da
						 			//Guia, verifique se este parametro esta sendo passado na chamada do u_CPEGCONR dessa tag.

	DEFAULT lLotGui	:= .F.
	DEFAULT cCodPeg := ""
	DEFAULT lOk		:= lOkXml
	DEFAULT nSeqGui := 0
	DEFAULT aMatBWT :={}
	Default lBg := .F.
	Default l974Xml	:= .F.
	
	PRIVATE lPlsCTEs := GetNewPar('MV_PLSCTES','0') == '1'
	PRIVATE aErrVarVin:= {.F., "", "", ""}
	PRIVATE aTabDup := PlsBusTerDup(SuperGetMv("MV_TISSCAB",.F.,"87"))

// Indices
	BAX->( DbSetOrder(1) ) //BAX_FILIAL + BAX_CODIGO + BAX_CODINT + BAX_CODLOC + BAX_CODESP + BAX_CODSUB
	BAQ->( DbSetOrder(4) ) //BAQ_FILIAL + BAQ_CODINT + BAQ_CBOS


// Verifica se em consulta ou sp-sadt ou internacao
	Do Case
	Case cGuia $ "GUIACONSULTA,GUIACONSULTAREAPRESENTACAO"
		cTipo 	:= "1"
		cOrigem	:= "1" //Execucao
		cTipGui	:= "01"
	Case cGuia $ "GUIASOLICITACAOSADT,SOLICITACAOSP_SADT,SOLICITACAOSP-SADT"
		cTipo 	:= "2"
		cOrigem	:= "2" //Solicitacao
		cTipGui	:= "02"
		lImpXml	:= .F.
	Case cGuia $ "GUIASP_SADT,GUIASPSADT,GUIASP-SADT,REAPRESENTACAO,GUIASP_SADTREAPRESENTACAO"
		cTipo 	:= "2"
		cOrigem	:= "1" //Execucão
		cTipGui	:= "02"
	Case cGuia $ "GUIASOLICINTERNACAO,SOLICITACAOINTERNACAO"
		lInter   := .T.
		cTipo 	:= "3"
		cOrigem	:= "2" //Solicitacao
		cTipGui	:= "03"
		lImpXml	:= .F.
	Case cGuia $ "GUIASOLICITACAOPRORROGACAO, SOLICITACAOPRORROGACAO"
		lInter   := .T.
		lEvolu   := .T.
		cTipo 	:= "3"
		cOrigem	:= "2" //Solicitacao
		cTipGui	:= "03"
		lImpXml	:= .F.
	Case cGuia $ "GUIAHONORARIOINDIVIDUAL,GUIAHONORARIOINDIVIDUALREAPRESENTACAO,GUIAHONORARIOS"
		lInter   := .T.
		lHonor	:= .T.
		cTipo 	:= "3"
		cOrigem	:= "1" //Execucao
		cTipGui	:= "06"
	Case cGuia $ "GUIARESUMOINTERNACAO,GUIARESUMOINTERNACAOREAPRESENTACAO"
		lResInt  := .T.
		cTipo 	:= "3"
		cOrigem	:= "1" //Execucao
		cTipGui	:= "05"
	Case cGuia $ "GUIAODONTOLOGIA,GUIAODONTOLOGIAREAPRESENTACAO"
	EndCase
//******** TAMANHO DO CAMPO CODIGO DA SIGLA DO CONSELHO *****//
	BTP->(DbSetOrder(1))
	If BTP->(msSeek(xFilial("BTP")+"26"))
		nTamSigla := BTP->BTP_TAMCOD
	EndIf

// Verificando se a Peg Já existe  na Importação do XML
// para não criar duas BCI para a mesma RDA com BCI_CODLDP diferentes

	If l974Xml .or. IsInCallStack('PLSIMPBATCH')	//	TUXB79

		BXX->(dbSetOrder(6))//BXX_FILIAL + BXX_CODINT +  BXX_CODPEG
		If BXX->(msSeek(xFilial("BXX")+cOpeMov+cCodPeg))
			cChave   := BXX->BXX_CHVPEG
			dDatAcat := BXX->BXX_DATMOV
		Endif

		BCI->(dbSetOrder(1))//BCI_FILIAL + BCI_CODOPE + BCI_CODLDP + BCI_CODPEG + BCI_FASE + BCI_SITUAC
		If BCI->(msSeek(xFilial("BCI")+cChave)) .and. empty(BCI->BCI_PROCES)
			cCodldp	 := BCI->BCI_CODLDP
		Endif
	//se for imp xml tem q ser igual a 5
		cLocalExec:= "5"
	Endif



// Matriz cabecalho da guia
	AaDd( aDados, {"DATACA"	, dDatAcat } )
	AaDd( aDados, {"TP_CLIENTE"	, "XML" } )											//Tipo de Transacao
	AaDd( aDados, {"CODLDP"		, If (!empty(cCodldp),cCodldp,If(PLSOBRPRDA(),PLSRETLDP(9),PLSRETLDP(2))) } )	//Local de Digitacao
	AaDd( aDados, {"IMPXML"		, lImpXml } )  										//aqui ele define se vai gravar a guia somente ou se vai ter liberacao...
	AaDd( aDados, {"AUDEMP"		, .T. } )  											//Critica da operadora se manda para auditoria
	AaDd( aDados, {"GERSEN"		, Iif(lInter .Or. lEvolu ,.F.,.T.) } )				//Gerar senha de autorizacao
	AaDd( aDados, {"TPGRV"		, "4" } )											//Tipo de Gravacao
	AaDd( aDados, {"TIPOMAT"   	, "" } )											//Matricula Procura a antiga depois a nova
	AaDd( aDados, {"LVALOR"		, .T. } ) 											//indica que o evento sera valorizado
	AaDd( aDados, {"LRETVPF"	, .T. } ) 											//indica que devera ser retornado o valor da participacao financeira
	AaDd( aDados, {"LREGPAGATO"	, .F. } ) 											//indica se ira checar regra de "pagar o evento no ato"
	AaDd( aDados, {"INCAUTIE"  	, .T. } )											//Se o usuario for de intercambio e nao existir ele inclui
	AaDd( aDados, {"TIPO"      	, AllTrim( cTipo ) } )								//Tipo de Guia
	AaDd( aDados, {"ORIGEM"    	, cOrigem } )										//Origem
	AaDd( aDados, {"CHKREG"    	, .T. } ) 											//Se vai checar regras ou nao
	AaDd( aDados, {"ARQIMP"		, cArqImp} ) 										//Nome do Arquivo+Data e Hora
	AaDd( aDados, {"NRAOPE"		, "" } )											//Numero autorizacao operadora
	AaDd( aDados, {"NRAEMP"		, "" } )    										//Numero autorizacao empresa
	AaDd( aDados, {"MSG01"		, "" } )											//Mensagem 1
	AaDd( aDados, {"MSG02"		, "" } )											//Mensagem 2
	AaDd( aDados, {"MSG03"		, "" } )											//Mensagem 3
	AaDd( aDados, {"NATJURI"	, "" } )											//Natureza juridica
	AaDd( aDados, {"AREAABR"	, "" } )								 			//Abrangencia
	AaDd( aDados, {"INTERN" 	, lInter } )										//Interncao
	AaDd( aDados, {"EVOLU"	, lEvolu } )										//Evolucao (Prorrogacao)
	AaDd( aDados, {"HORIND" 	, lHonor } )										//Honorario Individual
	AaDd( aDados, {"RESINT" 	, lResInt } )										//Resumo de Internacao
	AaDd( aDados, {"LNMUDF" 	, .F. } )										//Se nao muda fase para processamento de XML
	AaDd( aDados, {"TIPGUI" 	, cTipGui } )
	AaDd( aDados, {"XMLORIY"    , .T.} )										//origem XML	//	TUTEOE


// Data e hora
	If ExistBlock("PLSXMLDAT")
		aRetTag := ExecBlock( "PLSXMLDAT",.F.,.F.,{cGuia} )
		cData 	:= u_CPEGCONR(aRetTag[1],cGuia+AllTrim(aRetTag[2]),aMatM,nil,.F.,nil,nil,cCodPeg)
	EndIf

// Se entrou no ponto de entrada mais nao retornou nada
	If cTipo == "1" .And. Empty(cData)
		cData := u_CPEGCONR("DATAATENDIMENTO",cGuia + "\DADOSATENDIMENTO\DATAATENDIMENTO",aMatM,nil,.F.,nil,nil,cCodPeg)
	EndIf

	If cTipo $ "1,2" .Or. (cTipo == "3" .And. cOrigem == "2") .Or. lHonor
		If Empty(cData)
			cData := u_CPEGCONR("DATAEXECUCAO",cGuia + "\PROCEDIMENTOSEXECUTADOS\PROCEDIMENTOEXECUTADO",aMatM,nil,nil,nil,nil,cCodPeg)
			If Empty(cData)
				cData := u_CPEGCONR("DATAEXECUCAO",cGuia + "\OUTRASDESPESAS\DESPESA\SERVICOSEXECUTADOS",aMatM,nil,nil,nil,nil,cCodPeg)
			EndIf
			If Empty(cData)
				cData := u_CPEGCONR("DATASOLICITACAO",cGuia,aMatM,nil,nil,.F.,nil,cCodPeg)
			EndIf
			If Empty(cData)
				cData := u_CPEGCONR("DATAINICIOFATURAMENTO",cGuia,aMatM,nil,nil,.F.,nil,cCodPeg)
			EndIf
			If Empty(cData)
				cData := u_CPEGCONR("DATAEMISSAOGUIA",cGuia,aMatM,nil,nil,.F.,nil,cCodPeg)
			EndIf
		EndIf
		If Empty(cData)
			cData:=u_CPEGCONR("DATAATENDIMENTO",cGuia,aMatM,nil,nil,.F.,nil,cCodPeg)
		EndIf

		If Empty(cHora)
		// Foi retirada a inclusão da hora da guia de consulta,
		// pois como não existe tag específica, não podemos arbitrariamente informar um horário.
		// No caso do horário de transação, pode haver complicações se a operadora utilizar
		// pagamento de horário especial, pois se o prestador gerar um xml
		// dentro do horário especial, receberá o adicional indevidamente
			If cTipo $ "1,2"	  //Entendimento estendido para SADT
				cHora := ""
			Else
				cHora := u_CPEGCONR("HORAREGISTROTRANSACAO","\CABECALHO\IDENTIFICACAOTRANSACAO",aMatC,nil,nil,nil,nil,cCodPeg)
			EndIf
		EndIf
	Else
		cData := u_CPEGCONR("DATAINICIOFATURAMENTO",cGuia + "\DADOSINTERNACAO",aMatM,nil,nil,nil,nil,cCodPeg)
		cHora := u_CPEGCONR("HORAINICIOFATURAMENTO",cGuia + "\DADOSINTERNACAO",aMatM,nil,nil,nil,nil,cCodPeg)
	EndIf

// Data e Hora do Atendimento
	If Len(cHora)>8
		cHora := SubStr(cHora,1,8)
	EndIf

// Mesmo pegando a data no tratamento acima nao deixo atribuir para a matriz�
// pois a data correta e vai ser retirada da tag DADOSATENDIMENTO 		 	³
	If cTipo $ "1,2" //Estendido para SADT
		AaDd( aDados, {"DATPRO", u_CBAJUDAT(cData) } )
	EndIf
	AaDd( aDados, {"HORAPRO", cHora } )

// Numero da guia principal
	If cTipo == "2"
		cGuiPri := u_CPEGCONR("GUIAPRINCIPAL,NUMEROGUIAPRESTADOR",cGuia + "\CABECALHOGUIA\",aMatM,nil,nil,nil,nil,cCodPeg)
	ElseIf cTipo == "3" .AND. lEvolu
		cGuiPri := u_CPEGCONR("NRGUIAREFERENCIADA",cGuia,aMatM,nil,nil,nil,nil,cCodPeg)
	EndIf

	AaDd( aDados, {"GUIPRI" , cGuiPri  } )

// Identificador da guia
	If lEvolu
		cNumImp 	:= u_CPEGCONR("NUMEROGUIAPRESTADOR",cGuia,aMatM,nil,nil,nil,nil,cCodPeg)
		cNumEvo 	:= u_CPEGCONR("NUMEROGUIAPRESTADOR",cGuia,aMatM,nil,nil,nil,nil,cCodPeg)

		cNumImpOp 	:= u_CPEGCONR("NUMEROGUIAOPERADORA",cGuia,aMatM,nil,nil,nil,nil,cCodPeg)
		cNumEvoOp 	:= u_CPEGCONR("NUMEROGUIAOPERADORA",cGuia,aMatM,nil,nil,nil,nil,cCodPeg)

		If !Empty(cNumImpOp)
			cNumImp := cNumImpOp
		EndIf

		If !Empty(cNumEvoOp)
			cNumEvo := cNumEvoOp
		EndIf
	Else
		cNumImp		:= u_CPEGCONR("NUMEROGUIAPRESTADOR",cGuia,aMatM,nil,nil,nil,nil,cCodPeg)
		cNumImpOp	:= u_CPEGCONR("NUMEROGUIAOPERADORA",cGuia,aMatM,nil,nil,nil,nil,cCodPeg)
		If Empty(cNumImp) .AND. cTipo = "1"
			cNumImp		:= u_CPEGCONR("NUMEROGUIAPRESTADOR",cGuia+ "\CABECALHOCONSULTA",aMatM,nil,nil,nil,nil,cCodPeg)
		EndIf
		If Empty(cNumImp) .AND. cTipo = "2"
			cNumImp		:= u_CPEGCONR("NUMEROGUIAPRESTADOR",cGuia+ "\CABECALHOSOLICITACAO",aMatM,nil,nil,nil,nil,cCodPeg)
			If Empty(cNumImp)
				cNumImp		:= u_CPEGCONR("NUMEROGUIAPRESTADOR",cGuia+ "\CABECALHOGUIA",aMatM,nil,nil,nil,nil,cCodPeg)
			EndIf
		EndIf
		If Empty(cNumImp) .AND. cTipo = "3"
			cNumImp		:= u_CPEGCONR("NUMEROGUIAPRESTADOR",cGuia+ "\CABECALHOGUIA",aMatM,nil,nil,nil,nil,cCodPeg)
		EndIf

// Numero da Senha de autorizacao
		If (cTipo == "2" .Or. cTipo == "3") .And. cOrigem == "1"

			cNumSen := u_CPEGCONR("SENHA",cGuia+"\DADOSAUTORIZACAO",aMatM,nil,nil,nil,nil,cCodPeg)

			If cTipGui $ "02"
				If Empty(cNumSen) .and. !Empty(cNumImpOp)
					cNumSen := cNumImpOp
				Endif
			Endif

		EndIf
	EndIf

// Pega o numero da operadoRA ao inves da prestadora para gravacao
	If GetNewPar("MV_PLSNUIM",.F.)
		cNumImp := cNumImpOp
	Endif

// Pega a solicitacao de internacao
	If lResInt
	//Indica se a operadora vai trabalhar com a senha ou com nro de autorizacao na internacao
		If GetNewPar("MV_PLSENIN",'1') == '1'
			cNumSen := u_CPEGCONR("NUMEROGUIASOLICITACAOINTERNACAO",cGuia,aMatM,,.T.,nil,nil,cCodPeg)
			If Empty(cNumSen)
				cSlvTag := "\DADOSAUTORIZACAO"
				cNumSen := u_CPEGCONR("SENHA",cGuia+cSlvTag,aMatM,nil,nil,nil,nil,cCodPeg)
			Endif
		Else
			cSlvTag := "\DADOSAUTORIZACAO"
			cNumSen := u_CPEGCONR("SENHA",cGuia+cSlvTag,aMatM,nil,nil,nil,nil,cCodPeg)
			If Empty(cNumSen)
				cNumSen := u_CPEGCONR("NUMEROGUIASOLICITACAOINTERNACAO",cGuia,aMatM,,.T.)
			Endif
		Endif
	EndIf
	If lHonor
		If Empty(cNumSen)
			If !Empty(cGuiPri)
				cNumSen := cGuiPri
			Endif
			If Empty(cNumSen)
				cNumSen := u_CPEGCONR("SENHA",cGuia,aMatM,,.T.)
			EndIf
		Endif
	Endif

// Codigo da Operadora ORIGEM
	cRdaOri := u_cb973VRDA(AllTrim( u_CPEGCONR("CPF,CNPJ,CODIGOPRESTADORNAOPERADORA","CABECALHO\ORIGEM\IDENTIFICACAOPRESTADOR",aMatC,nil,nil,nil,nil,cCodPeg) ))
	If Len(alltrim(cRdaOri)) <= TamSX3("BAU_CODIGO")[1]
		cRdaOri := Right(Replicate("0", TamSX3("BAU_CODIGO")[1]) + cRdaOri, TamSX3("BAU_CODIGO")[1])
		nIdx 	 := 1
	Else
		cRdaOri := cRdaOri+Space( TamSX3("BAU_CPFCGC")[1]-Len(cRdaOri) )
		nIdx 	:= 4
	EndIf
	If Empty(cRdaOri)
		xRdaOri  := u_CPEGCONR("CODIGOPRESTADORNAOPERADORA","CABECALHO\ORIGEM\IDENTIFICACAOPRESTADOR",aMatC)
		cRdaOri  := xRdaOri
		If Len(alltrim(xRdaOri)) > TamSX3("BAU_CODIGO")[1]//se eh maior significa que o prestador mandou o cnpj na TAG  de codigo
			nIdx 	 := 4
		Else
			cRdaOri := padr(cRdaOri,6)
			nIdx 	 := 1
		Endif
	EndIf


	If !Empty(cRdaOri)
		BAW->(DbSetOrder(3))
		cRdaAnt := cRdaOri+Space( TamSX3("BAW_CODANT")[1]-Len(cRdaOri) )
		If BAW->(MsSeek(xFilial("BAW")+cOpeMov+cRdaAnt))
			cRdaOri := BAW->BAW_CODIGO
			nIdx 	:= 1
		Endif
	Endif

// RDA
	u_CBIVRDA(cRdaOri,nIdx,,aDados)
//Pego o local de atendimento de acordo com o CNES. Se nao tiver CNES na guia, continua como era, pegando o primeiro local. PL973RETLOC esta no PLSA973l
	cCnes := u_CPEGCONR("CNES",cGuia,aMatM,,.T.)
	If !Empty(cCnes)
		If Ascan(aDados,{|x| X[1] =='CODRDA'}) > 0
			cCodLoc := u_CB973RETLOC(aDados[ASCAN(ADADOS,{|x| X[1] =='CODRDA'}),2],cOpeMov,cCnes)
			AaDd( aDados, {"CODLOC" , cCodLoc } )
		Endif
	EndIf

// Ponto de entrada
	U_CBXPROF("R",cRdaOri,"1",cNumImp,cOrigem,nIdx,cData,cHora,,aDados,aMatC)
	If BAU->( Found() )
		cRdaOri	  := BAU->BAU_CODIGO
		cNomRda   := AllTrim(BAU->BAU_NOME)
		cTpCab 	  := AllTrim(BAU->BAU_TIPPE)
		cCCCab	  := AllTrim(BAU->BAU_CPFCGC)
		cTipPOr	  := AllTrim(BAU->BAU_TIPPRE)
	Else
		cRdaOri	  := GetNewPar("MV_PLSRDAG",'999999')
		cNomRda   := AllTrim(Posicione("BAU",1,xFilial("BAU")+GetNewPar("MV_PLSRDAG",'999999'),"BAU_NOME"))
		cTpCab 	  := AllTrim(BAU->BAU_TIPPE)
		cCCCab	  := AllTrim(BAU->BAU_CPFCGC)
		cTipPOr	  := AllTrim(BAU->BAU_TIPPRE)
	Endif
	cRdaGuia := cRdaOri

//Informacoes complementares para processamento no PLSXMOV
	If !Empty(cRdaOri)
		AaDd( aDados, {"RDAORI" , cRdaOri } )
		AaDd( aDados, {"ORINME" , cNomRda } )
		AaDd( aDados, {"ORITPE" , cTpCab } )
		AaDd( aDados, {"ORIDOC" , cCCCab } )
		cNomRda := ""
	EndIf

// Codigo da Operadora DESTINO
	cRegAns   := u_CPEGCONR("REGISTROANS","CABECALHO\DESTINO",aMatC,nil,nil,nil,nil,cCodPeg)
	cCnpjPres := u_CPEGCONR("CNPJ","CABECALHO\DESTINO\IDENTIFICACAOPRESTADOR",aMatC)
	If !Empty(cRegAns)
		BA0->( DbSetOrder(5) ) //BA0_FILIAL+BA0_SUSEP
		If BA0->( MsSeek( xFilial("BA0")+cRegAns ) )
			cOpeMov := BA0->(BA0_CODIDE+BA0_CODINT)
			AaDd( aDados, { "OPEMOV", cOpeMov } )
			AaDd( aDados, { "OPEINT", cOpeMov } )
		Else
			AaDd( aDados, { "OPEMOV", PlsIntPad() } )
			AaDd( aDados, { "OPEINT", PlsIntPad() } )
		EndIf
	Elseif !Empty(cCnpjPres)   /// pega pelo CNPJPAGADOR
		BA0->( DbSetOrder(4) ) //BA0_FILIAL+BA0_SUSEP
		If BA0->( MsSeek( xFilial("BA0")+cCnpjPres ) )
			cOpeMov := BA0->(BA0_CODIDE+BA0_CODINT)
			AaDd( aDados, { "OPEMOV", cOpeMov } )
			AaDd( aDados, { "OPEINT", cOpeMov } )

		Else
			AaDd( aDados, { "OPEMOV", PlsIntPad() } )
			AaDd( aDados, { "OPEINT", PlsIntPad() } )
		EndIf
	Else
		AaDd( aDados, { "OPEMOV", PlsIntPad() } )
		AaDd( aDados, { "OPEINT", PlsIntPad() } )
	Endif


//RDA e Profissional executante de cada guia
	Do Case

// Consulta
	Case cTipo == "1"
		cNomCont := AllTrim( u_CPEGCONR("NOMECONTRATADO",cGuia+"\CONTRATADOEXECUTANTE",aMatM,nil,.F.,nil,nil,cCodPeg) )
		cCodRP 	 := AllTrim( u_CPEGCONR("CPFCONTRATADO,CNPJCONTRATADO",cGuia+"\CONTRATADOEXECUTANTE",aMatM,nil,.T.,nil,nil,cCodPeg) )
		cCodRP 	 := cCodRP+Space( TamSX3("BAU_CPFCGC")[1]-Len(cCodRP) )
		dDatRea := u_CBAJUDAT(Alltrim(u_CPEGCONR("DATAEXECUCAO",cGuia+"\DADOSATENDIMENTO\DATAATENDIMENTO",aMatM,nil,nil,nil,nil,cCodPeg)))

		nIdx 	 := 4
		If Empty(cCodRP)
			xRdaOri  := Alltrim(u_CPEGCONR("CODIGOPRESTADORNAOPERADORA",cGuia+"\CONTRATADOEXECUTANTE",aMatM,,.F.,nil,nil,cCodPeg))
			If Len(xRDAOri) > TamSX3("BAU_CODIGO")[1]
				cCodRP 	 := xRdaOri+Space( TamSX3("BAU_CPFCGC")[1]-Len(cCodRP) )
				nIdx 	 := 4
				BAU->(DbSetOrder(nIdx))
				If !(BAU->(MsSeek(xFilial("BAU")+xRDAOri)))

					xRdaOri 	 := AllTrim( u_CPEGCONR("CPFCONTRATADO,CNPJCONTRATADO,CODIGOPRESTADORNAOPERADORA","",aMatC,nil,.F.,nil,nil,cCodPeg) )
					
					If Len(xRdaOri) > TamSX3("BAU_CODIGO")[1]
						cCodRP 	 := xRdaOri+Space( TamSX3("BAU_CPFCGC")[1]-Len(cCodRP) )
						nIdx 	 := 4
					else
						cRdaOri := StrZero(Val(cRdaOri),TamSX3("BAU_CODIGO")[1])
						nIdx 	 := 1
					EndIf
				EndIf
			Else
				cRdaOri := StrZero(Val(cRdaOri),TamSX3("BAU_CODIGO")[1])
				nIdx 	 := 1
			Endif
		EndIf

		If !Empty(cCodRP)
			u_CBIVRDA(cCodRP,nIdx,"E",aDados)
			U_CBXPROF("R",cCodRP,"2",cNumImp,cOrigem,nIdx,cData,cHora,"E",aDados,aMatC)
		EndIf

		If BAU->( Found() ) .AND. !Empty(cCodRP)
			cCodRP	  := BAU->BAU_CODIGO
			cNomRda	  := Alltrim(BAU->BAU_NOME)
		Else
			cCodRP	  := cRdaOri
		Endif
		cRdaGuia := cCodRP

	// Local de Atendimento
		cSigla 	:= u_CPEGCONR("CONSELHOPROFISSIONAL",cGuia+"\PROFISSIONALEXECUTANTE",aMatM,,.F.,nil,nil,cCodPeg)
		cVincBkp	:= PLSVARVINC('26', , STRZERO(VAL(cSigla),7))
		If !Empty(cVincBkp)
			cSigla := cVincBkp
		EndIf
		cCrm 	:= u_CPEGCONR("NUMEROCONSELHOPROFISSIONAL",cGuia+"\PROFISSIONALEXECUTANTE",aMatM,,.F.,nil,nil,cCodPeg)
		cUf 	:= u_CPEGCONR("UF",cGuia+"\PROFISSIONALEXECUTANTE",aMatM,,.T.,nil,nil,cCodPeg)
		cVincBkp	:= PLSVARVINC('59', nil, cUf)
		If !Empty(cVincBkp)
			cUf := cVincBkp
		EndIf

		cNome   := u_CPEGCONR("NOMEPROFISSIONAL",cGuia+"\PROFISSIONALEXECUTANTE",aMatM,,.F.,nil,nil,cCodPeg)

	//Trata a especialidade do membro
		aAdd(aEspItXML,aClone(u_CBTrCBOIMP('2',cGuia,aMatM,cOrigem,cTipGui,.F.)))
		cEspExe := aEspItXML[Len(aEspItXML)][1]
		cCboExe := aEspItXML[Len(aEspItXML)][2]

	//Trata a especialidade do Prestador contratado
		cCodEsp := u_cbRtEspPre(cOpeMov,cRdaOri,cEspExe,dDatRea,cCodLoc,lPlsCTEs,.T.)
		aAdd(aEspItXML[Len(aEspItXML)],cCodEsp)

	//Zera as informacoes para o proximo Item
		u_cbFreArr(@aEspItXML)

		aAdd(aDados,{"CODESP",cCodEsp})
		aAdd(aDados,{"ESPEXE",cEspExe})

		nIdx 	:= 4

		U_CBIVPRO("",cSigla,cCrm,cUf,nIdx,"E",aDados)
		u_CBXSCU("",cSigla,cCrm,cUf,"E",aDados,NIL,NIL,cNome,cCboExe,cData)

		If BB0->( Found() )
			cSlgRda := BB0->BB0_CODSIG //Sigla
			cCrmRda := BB0->BB0_NUMCR  //Numero
			cEstRda := BB0->BB0_ESTADO //Estado
			cNomPre := BB0->BB0_NOME
		EndIf



//SADT
	Case cTipo == "2"

		If cOrigem == "1"
			cNomCont := AllTrim( u_CPEGCONR("NOMECONTRATADO",cGuia+"\DADOSEXECUTANTE\CONTRATADOEXECUTANTE",aMatM,nil,.F.,nil,nil,cCodPeg) )
			cCodRP   := AllTrim( u_CPEGCONR("CPFCONTRATADO,CNPJCONTRATADO",cGuia+"\DADOSEXECUTANTE\CONTRATADOEXECUTANTE",aMatM,,.F.,nil,nil,cCodPeg) )
		Else
			cNomCont := AllTrim( u_CPEGCONR("NOMECONTRATADO",cGuia+"\DADOSSOLICITANTE\CONTRATADOSOLICITANTE	",aMatM,,.F.,nil,nil,cCodPeg) )
			cCodRP 	 := AllTrim( u_CPEGCONR("CPFCONTRATADO,CNPJCONTRATADO",cGuia+"\DADOSSOLICITANTE\CONTRATADOSOLICITANTE",aMatM,,.F.,nil,nil,cCodPeg) )
		EndIf
		cCodRP := cCodRP+Space( TamSX3("BAU_CPFCGC")[1]-Len(cCodRP) )
		nIdx 	:= 4
		If Empty(cCodRP)
			If cOrigem == "1"
				cCodRP := u_cb973VRDA(AllTrim(u_CPEGCONR("CODIGOPRESTADORNAOPERADORA",cGuia+"\DADOSEXECUTANTE\CONTRATADOEXECUTANTE",aMatM,,.F.,nil,nil,cCodPeg)))
			Else
				cCodRP := u_cb973VRDA(Alltrim(u_CPEGCONR("CODIGOPRESTADORNAOPERADORA",cGuia+"\DADOSEXECUTANTE\CONTRATADOEXECUTANTE",aMatM,,.F.,nil,nil,cCodPeg)))

				cSigla 	:= u_CPEGCONR("CONSELHOPROFISSIONAL",cGuia+"\DADOSSOLICITANTE\PROFISSIONALSOLICITANTE",aMatM,,.F.,.F.,nil,cCodPeg)
				cVincBkp	:= PLSVARVINC('26', , STRZERO(VAL(cSigla),7))

				dDatRea := u_CBAJUDAT(Alltrim(u_CPEGCONR("DATAEXECUCAO",cGuia+"\PROCEDIMENTOSEXECUTADOS",aMatM,nil,.F.,nil,nil,cCodPeg)))

				If !Empty(cVincBkp)
					cSigla := cVincBkp
					cVincBkp := ""
				EndIf

				cCrm 	:= u_CPEGCONR("NUMEROCONSELHOPROFISSIONAL",cGuia+"\DADOSSOLICITANTE\PROFISSIONALSOLICITANTE",aMatM,,.F.,.F.,nil,cCodPeg)
				cUf 	:= u_CPEGCONR("UF",cGuia+"\DADOSSOLICITANTE\PROFISSIONALSOLICITANTE",aMatM,,.T.,.F.,nil,cCodPeg)
				cVincBkp	:= PLSVARVINC('59', nil, cUf)

				If !Empty(cVincBkp)
					cSigla := cVincBkp
				EndIf

			//Trata a especialidade do membro
				aAdd(aEspItXML,aClone(u_CBTrCBOIMP('1',cGuia,aMatM,cOrigem,cTipGui)))
				cEspSol := aEspItXML[Len(aEspItXML)][1]
				cCboSol := aEspItXML[Len(aEspItXML)][2]

			//Trata a especialidade do Prestador contratado
				cCodEsp := u_cbRtEspPre(cOpeMov,cRdaOri,cEspExe,dDatRea,cCodLoc,lPlsCTEs,.T.)
				aAdd(aEspItXML[Len(aEspItXML)],cCodEsp)

			//Zera as informacoes para o proximo Item
				u_cbFreArr(@aEspItXML)

				aAdd(aDados,{"ESPSOL",cEspSol})

			EndIf

			nIdx := 1

			If Len(cCodRP) > TamSX3("BAU_CODIGO")[1]
				cCodRP 	 := cCodRP+Space( TamSX3("BAU_CPFCGC")[1]-Len(cCodRP) )
				BAU->(DbSetOrder(4))
				If !(BAU->(MsSeek(xFilial("BAU")+cCodRP)))
					cCodRP  := StrZero(Val(cRdaOri),TamSX3("BAU_CODIGO")[1])

				Else
					cCodRP := BAU->BAU_CODIGO

				EndIf
			Else
				cRdaOri := StrZero(Val(cCodRP),TamSX3("BAU_CODIGO")[1])
			Endif

		EndIf

		u_CBIVRDA(cCodRP,nIdx,,aDados)
		U_CBXPROF("R",cCodRP,"5",cNumImp,cOrigem,nIdx,cData,cHora,nil,aDados,aMatC)

		If BAU->( Found() )
			cConPrEx := BAU->BAU_CODIGO
			cNomRdEx := BAU->BAU_NOME
		Else
			cConPrEx := ""
			cNomRdEx := ""
		Endif

		If cOrigem == "1"

			nIdx 	:= 4
			cCodPCPL := ""

			cCodRP 	:= 	 AllTrim( u_CPEGCONR("CPFCONTRATADO,CNPJCONTRATADO",cGuia+"\DADOSEXECUTANTE\CONTRATADOEXECUTANTE",aMatM,,.F.,nil,nil,cCodPeg) )
			cCodRP 	:= cCodRP+Space( TamSX3("BAU_CPFCGC")[1]-Len(cCodRP) )
			cNome 		:= 	 AllTrim( u_CPEGCONR("NOMECONTRATADO",cGuia+"\DADOSEXECUTANTE\CONTRATADOEXECUTANTE",aMatM,,.F.,nil,nil,cCodPeg) )

			dDatRea := u_CBAJUDAT(Alltrim(u_CPEGCONR("DATAEXECUCAO",cGuia+"\PROCEDIMENTOSEXECUTADOS",aMatM,nil,.F.,nil,nil,cCodPeg)))

			nIdx 	:= 3

			If Empty(cCodRP)
				cCodRP 	:= StrZero(Val(u_CPEGCONR("CODIGOPRESTADORNAOPERADORA",cGuia+"\DADOSEXECUTANTE\CONTRATADOEXECUTANTE",aMatM,,.F.,nil,nil,cCodPeg)),6)
				nIdx	:= 1
			//Significa que foi enviado o BAU_CODRDA na TAG <CODIGOPRESTADORNAOPERADORA>
				If Len(alltrim(cCodRP)) == 6
					nOrdBAU := BAU->(IndexOrd())
					nRecBAU := BAU->(Recno())
					BAU->(DbSetOrder(1))
					If  BAU->(MsSeek(xFilial("BAU")+padr(cCodRP,6))) .and. !Empty(BAU->BAU_CODBB0)
						cCodRP := BAU->BAU_CODBB0
					Endif
					BAU->(DbGoTo(nRecBAU))
					BAU->(DbSetOrder(nOrdBAU))
				Endif
			EndIf

			U_CBIVPRO("",'','','',nIdx,"E",aDados)
			u_CBXSCU("",'','','',"E",aDados,NIL,NIL,cNome,NIL,cData,aMatM)

			If BB0->( Found() )
				cCodPCPL := BB0->BB0_CODIGO
			Else
				cCodPCPL := ""
			Endif

			If !Empty(cCodPCPL)
				If BB0->( Found() )
					cCodRP  := PLSRETDAD( aDados,"CODRDA","" )
					cNomRda := PLSRETDAD( aDados,"NOMRDA","" )
					cSlgRda := BB0->BB0_CODSIG
					cCrmRda := BB0->BB0_NUMCR
					cEstRda := BB0->BB0_ESTADO
					cNomPre := BB0->BB0_NOME

					cCodBAU := ""
					cEspExe := ""

					nRecBAU := BAU->(Recno())
					nOrdBAU := BAU->(IndexOrd())
					BAU->(DbSetOrder(5))
					If BAU->(MsSeek(xFilial("BAU")+BB0->BB0_CODIGO))
						cCodBAU := BAU->BAU_CODBB0
					//Trata a especialidade do membro
						aAdd(aEspItXML,aClone(u_CBTrCBOIMP('2',cGuia,aMatM,cOrigem,cTipGui,.F.)))
						cEspExe := aEspItXML[Len(aEspItXML)][1]
						cCboExe := aEspItXML[Len(aEspItXML)][2]

					//Trata a especialidade do Prestador contratado
						cCodEsp := u_cbRtEspPre(cOpeMov,cRdaOri,Iif(!Empty(cEspExe),cEspExe,cEspSol),dDatRea,cCodLoc,lPlsCTEs,.T.)
						aAdd(aEspItXML[Len(aEspItXML)],cCodEsp)

					//Zera as informacoes para o proximo Item
						u_cbFreArr(@aEspItXML)
					Endif
					BAU->(DbGoTo(nRecBAU))
					BAU->(DbSetOrder(nOrdBAU))

					aSlvBWT := aClone(aMatBWT)
					lEntrou := .F.

					While ( nPos := aScan( aMatBWT,{ |x|x[3]=='12' } ) ) > 0
						AaDd( aTpPRec,{ aMatBWT[nPos,2],If(Empty(cConPrEx),cCodRP,cConPrEx),If(Empty(cNomRdEx),cNomRda,cNomRdEx),cCrmRda,cSlgRda,cEstRda,cNomPre,.T.,cCodBAU,cEspExe,u_CBRetUnp(aMatBWT[nPos,2]) } )
						lEntrou := .T.

						nSize := Len(aMatBWT)
						aDel(aMatBWT,nPos)
						aSize(aMatBWT,nSize-1)
					Enddo

					If !lEntrou
						nPosGPart := IIf(Len(aMatEqu) >= 2 .AND. !Empty(aMatEqu[1]),aMatEqu[2],aScan(aMatM,{|x| 'GRAUPART' $ AllTrim(x[1])}))
						If GetNewPar("MV_PLSPART",.F.) .AND. nPosGPart <> 0
							AaDd( aTpPRec,{ aMatM[nPosGPart][2] ,If(Empty(cConPrEx),cCodRP,cConPrEx),If(Empty(cNomRdEx),cNomRda,cNomRdEx),cCrmRda,cSlgRda,cEstRda,cNomPre,.T.,cCodBAU,cEspExe,u_CBRetUnp( aMatM[nPosGPart][2])  } )
						Else
							AaDd( aTpPRec,{ GetNewPar("MV_PLSNAPL","O"),If(Empty(cConPrEx),cCodRP,cConPrEx),If(Empty(cNomRdEx),cNomRda,cNomRdEx),cCrmRda,cSlgRda,cEstRda,cNomPre,.T.,cCodBAU,cEspExe,u_CBRetUnp(GetNewPar("MV_PLSNAPL","O"))  } )
						EndIf
					EndIf

					aMatBWT := aClone(aSlvBWT)
					AaDd( aDados, {"ATPARG" , aTpPRec } )
					aTpPRec := {}

					cNomRda := ""
					cCrmRda := ""
					cSlgRda := ""
					cEstRda := ""
					cNomPre := ""
				EndIf
			EndIf

			cSigla 	:= u_CPEGCONR("CONSELHOPROFISSIONAL",cGuia+"\DADOSSOLICITANTE\PROFISSIONALSOLICITANTE",aMatM,nil,.F.,nil,nil,cCodPeg)
			cVincBkp	:= PLSVARVINC('26', , STRZERO(VAL(cSigla),7))
			If !Empty(cVincBkp)
				cSigla := cVincBkp
			EndIf
			cCrm 	:= u_CPEGCONR("NUMEROCONSELHOPROFISSIONAL",cGuia+"\DADOSSOLICITANTE\PROFISSIONALSOLICITANTE",aMatM,nil,.F.,nil,nil,cCodPeg)
			cUf 	:= u_CPEGCONR("UF",cGuia+"\DADOSSOLICITANTE\PROFISSIONALSOLICITANTE",aMatM,nil,.T.,nil,nil,cCodPeg)
			cVincBkp	:= PLSVARVINC('59', nil, cUf)
			If !Empty(cVincBkp)
				cUf := cVincBkp
			EndIf
			cNome	:= u_CPEGCONR("NOMEPROFISSIONAL",cGuia+"\DADOSSOLICITANTE\PROFISSIONALSOLICITANTE",aMatM,nil,.F.,nil,nil,cCodPeg)

		//Trata a especialidade do membro
			aAdd(aEspItXML,aClone(u_CBTrCBOIMP('1',cGuia,aMatM,cOrigem,cTipGui)))
			cEspSol := aEspItXML[Len(aEspItXML)][1]
			cCboSol := aEspItXML[Len(aEspItXML)][2]

		//Trata a especialidade do Prestador contratado
			cCodEsp := u_cbRtEspPre(cOpeMov,cRdaOri,Iif(!Empty(cEspExe),cEspExe,cEspSol),dDatRea,cCodLoc,lPlsCTEs,.T.)
			aAdd(aEspItXML[Len(aEspItXML)],cCodEsp)

		//Zera as informacoes para o proximo Item
			u_cbFreArr(@aEspItXML)

			aAdd(aDados,{"ESPSOL",cEspSol})

			nIdx 	:= 4

			U_CBIVPRO("",cSigla,cCrm,cUf,nIdx,"S",aDados,.F.)
			u_CBXSCU("",cSigla,cCrm,cUf,"S",aDados,NIL,.F.,cNome,cCboSol,cData,aMatM )

		ElseIf cOrigem == "2"
			cSigla 	:= u_CPEGCONR("CONSELHOPROFISSIONAL",cGuia+"\DADOSSOLICITANTE\PROFISSIONALSOLICITANTE",aMatM,nil,.F.,nil,nil,cCodPeg)
			cVincBkp	:= PLSVARVINC('26', , STRZERO(VAL(cSigla),7))
			If !Empty(cVincBkp)
				cSigla := cVincBkp
			EndIf
			cCrm 	:= u_CPEGCONR("NUMEROCONSELHOPROFISSIONAL",cGuia+"\DADOSSOLICITANTE\PROFISSIONALSOLICITANTE",aMatM,nil,.F.,nil,nil,cCodPeg)
			
			if empty(cUf)
				cUf 	:= u_CPEGCONR("UF",cGuia+"\DADOSSOLICITANTE\PROFISSIONALSOLICITANTE",aMatM,nil,.F.,nil,nil,cCodPeg)
			endif
			
			cVincBkp	:= PLSVARVINC('59', nil, cUf)
			If !Empty(cVincBkp)
				cUf := cVincBkp
			EndIf
			cNome	:= u_CPEGCONR("NOMEPROFISSIONAL",cGuia+"\DADOSSOLICITANTE\PROFISSIONALSOLICITANTE",aMatM,nil,.F.,nil,nil,cCodPeg)

			dDatRea := u_CBAJUDAT(Alltrim(u_CPEGCONR("DATAEXECUCAO",cGuia+"\PROCEDIMENTOSEXECUTADOS",aMatM,nil,.F.,nil,nil,cCodPeg)))

		//Trata a especialidade do membro
			aAdd(aEspItXML,aClone(u_CBTrCBOIMP('1',cGuia,aMatM,cOrigem,cTipGui)))
			cEspSol := aEspItXML[Len(aEspItXML)][1]
			cCboSol := aEspItXML[Len(aEspItXML)][2]

		//Trata a especialidade do Prestador contratado
			cCodEsp := u_cbRtEspPre(cOpeMov,cRdaOri,Iif(!Empty(cEspExe),cEspExe,cEspSol),dDatRea,cCodLoc,lPlsCTEs,.T.)
			aAdd(aEspItXML[Len(aEspItXML)],cCodEsp)

		//Zera as informacoes para o proximo Item
			u_cbFreArr(@aEspItXML)

			aAdd(aDados,{"ESPSOL",cEspSol})

			nIdx 	:= 4

			U_CBIVPRO("",cSigla,cCrm,cUf,nIdx,"S",aDados,.T.)
			u_CBXSCU("",cSigla,cCrm,cUf,"S",aDados,NIL,.T.,cNome,cCboSol,cData )
			
			cUf := ""

		EndIf

//GRI
	Case cTipo == "3" .And. !lHonor

		If cOrigem == "1"
			cNomCont	:= ""
			cCodRP 	 := AllTrim( u_CPEGCONR("CPFCONTRATADO,CNPJCONTRATADO",cGuia+"\DADOSEXECUTANTE\CONTRATADOEXECUTANTE",aMatM,,.F.,nil,nil,cCodPeg) )
		Else
			cNomCont := AllTrim( u_CPEGCONR("NOMEPROFISSIONAL",cGuia+"\IDENTIFICACAOSOLICITANTE\DADOSPROFISSIONALCONTRATADO",aMatM,,.F.,nil,nil,cCodPeg) )
			cCodRP 	 := AllTrim( u_CPEGCONR("CPFCONTRATADO,CNPJCONTRATADO",cGuia+"\IDENTIFICACAOSOLICITANTE\DADOSCONTRATADO",aMatM,,.F.,nil,nil,cCodPeg) )
		EndIf
		cCodRP := cCodRP+Space( TamSX3("BAU_CPFCGC")[1]-Len(cCodRP) )
		nIdx := 4

		If Empty(cCodRP)
			If cOrigem == "1"
				cCodRP := AllTrim(u_CPEGCONR("CODIGOPRESTADORNAOPERADORA",cGuia+"\DADOSEXECUTANTE\CONTRATADOEXECUTANTE",aMatM,,.F.,nil,nil,cCodPeg))
			Else
				cCodRP := Alltrim(u_CPEGCONR("CODIGOPRESTADORNAOPERADORA",cGuia+"\DADOSEXECUTANTE\CONTRATADOEXECUTANTE",aMatM,,.F.,nil,nil,cCodPeg))
			EndIf
			nIdx := 1
			
			If Len(cCodRP) > TamSX3("BAU_CODIGO")[1]
				cCodRP 	 := cCodRP+Space( TamSX3("BAU_CPFCGC")[1]-Len(cCodRP) )
				BAU->(DbSetOrder(4))
				If !(BAU->(MsSeek(xFilial("BAU")+cCodRP)))
					cCodRP  := StrZero(Val(cRdaOri),TamSX3("BAU_CODIGO")[1])

				Else
					cCodRP := BAU->BAU_CODIGO

				EndIf
			Else
				cRdaOri := StrZero(Val(cCodRP),TamSX3("BAU_CODIGO")[1])
			Endif
			
		EndIf

		u_CBIVRDA(cCodRP,nIdx,,aDados)
		U_CBXPROF("R",cCodRP,"5",cNumImp,cOrigem,nIdx,cData,cHora,,aDados,aMatC)

		If BAU->( Found() )
			cCodRP	  := BAU->BAU_CODIGO
			cNomRda   := AllTrim(BAU->BAU_NOME)
		Else
			cCodRP	  := cRdaOri
			cNomRda   := AllTrim(Posicione("BAU",1,xFilial("BAU")+GetNewPar("MV_PLSRDAG",'999999'),"BAU_NOME"))
		EndIf
		cRdaGuia := cCodRP

		If cOrigem == "2"

			cSigla 	:= u_CPEGCONR("CONSELHOPROFISSIONAL",cGuia+"\IDENTIFICACAOSOLICITANTE\DADOSPROFISSIONALCONTRATADO",aMatM,,.F.,nil,nil,cCodPeg)
			cVincBkp	:= PLSVARVINC('26', , STRZERO(VAL(cSigla),7))
			If !Empty(cVincBkp)
				cSigla := cVincBkp
			EndIf
			cCrm 	:= u_CPEGCONR("NUMEROCONSELHOPROFISSIONAL",cGuia+"\IDENTIFICACAOSOLICITANTE\DADOSPROFISSIONALCONTRATADO",aMatM,,.F.,nil,nil,cCodPeg)
			cUf 	:= u_CPEGCONR("UF",cGuia+"\IDENTIFICACAOSOLICITANTE\DADOSPROFISSIONALCONTRATADO",aMatM,,.T.,nil,nil,cCodPeg)
			cVincBkp	:= PLSVARVINC('59', nil, cUf)
			If !Empty(cVincBkp)
				cUf := cVincBkp
			EndIf
			cNome	:= u_CPEGCONR("NOMEPROFISSIONAL",cGuia+"\IDENTIFICACAOSOLICITANTE\DADOSPROFISSIONALCONTRATADO",aMatM,,.F.,nil,nil,cCodPeg)

			dDatRea := u_CBAJUDAT(Alltrim(u_CPEGCONR("DATAEXECUCAO",cGuia+"\PROCEDIMENTOSEXECUTADOS",aMatM,nil,.F.,nil,nil,cCodPeg)))

		//Trata a especialidade do membro
			aAdd(aEspItXML,aClone(u_CBTrCBOIMP('1',cGuia,aMatM,cOrigem,cTipGui)))
			cEspSol := aEspItXML[Len(aEspItXML)][1]
			cCboSol := aEspItXML[Len(aEspItXML)][2]

		//Trata a especialidade do Prestador contratado
			cCodEsp := u_cbRtEspPre(cOpeMov,cRdaOri,cEspExe,dDatRea,cCodLoc,lPlsCTEs,.T.)
			aAdd(aEspItXML[Len(aEspItXML)],cCodEsp)

		//Zera as informacoes para o proximo Item
			u_cbFreArr(@aEspItXML)

			aAdd(aDados,{"ESPSOL",cEspSol})

			nIdx	:= 4

			U_CBIVPRO("",cSigla,cCrm,cUf,nIdx,"S",aDados)
			u_CBXSCU("",cSigla,cCrm,cUf,"S",aDados,nil,NIL,cNome,cCboSol,cData)

		EndIf

//GHI
	Case cTipo == "3" .And. lHonor

		aTpPRec := {}
		cNomCont	:= AllTrim(u_CPEGCONR("NOMECONTRATADOEXECUTANTE",cGuia+"\DADOSCONTRATADOEXECUTANTE",aMatM,nil,.F.,nil,nil,cCodPeg))
		cCodRP		:= AllTrim(u_CPEGCONR("CODIGONAOPERADORA",cGuia+"\DADOSCONTRATADOEXECUTANTE",aMatM,nil,.F.,nil,nil,cCodPeg))
		
		If Len(cCodRP) > TamSX3("BAU_CODIGO")[1]
			cCodRP 	 := cCodRP+Space( TamSX3("BAU_CPFCGC")[1]-Len(cCodRP) )
			BAU->(DbSetOrder(4))
			If !(BAU->(MsSeek(xFilial("BAU")+cCodRP)))
				cCodRP  := StrZero(Val(cRdaOri),TamSX3("BAU_CODIGO")[1])

			Else
				cCodRP := BAU->BAU_CODIGO

			EndIf
		Else
			cRdaOri := StrZero(Val(cCodRP),TamSX3("BAU_CODIGO")[1])
		Endif
		
		nIdx 	 := 1

	//Muda o indice para procurar no BAU pelo CPF/CNPJ
		If Len(alltrim(cCodRP)) > TamSX3("BAU_CODIGO")[1]
			nIdx 	 := 4
		else
			cCodRP := padr(cCodRP,6)
		endif

		u_CBIVRDA(cCodRP,nIdx,,aDados)
		U_CBXPROF("R",cCodRP,"6",cNumImp,cOrigem,nIdx,cData,cHora,,aDados,aMatC)

		If BAU->( Found() )
			cCodRP	  := BAU->BAU_CODIGO
			cNomRda   := AllTrim(BAU->BAU_NOME)
		Else
			cCodRP	  := cRdaOri
			cNomRda   := AllTrim(Posicione("BAU",1,xFilial("BAU")+GetNewPar("MV_PLSRDAG",'999999'),"BAU_NOME"))
		EndIf
		cRdaGuia := cCodRP

	EndCase

//Tratamento para substituir o CNPJ/CPF do prestador pelo codigo do sistema
	If Len(alltrim(cCodRP)) > 6
		nOrdBAU := BAU->(IndexOrd())
		nRecBAU := BAU->(Recno())
		BAU->(DbSetOrder(4))
		If  BAU->(MsSeek(xFilial("BAU")+cCodRP))
			If !Empty(BAU->BAU_CODBB0)
				cCodRP := BAU->BAU_CODBB0
			Else
				cCodRP := BAU->BAU_CODIGO
			EndIf
		Endif
		BAU->(DbGoTo(nRecBAU))
		BAU->(DbSetOrder(nOrdBAU))
	Endif

// Dados do Beneficiario
	If lHonor
		cMatric  	:= u_CPEGCONR("NUMEROCARTEIRA",cGuia+"\BENEFICIARIO",aMatM,nil,nil,nil,nil,cCodPeg)
		cNomeUsu 	:= u_CPEGCONR("NOMEBENEFICIARIO",cGuia+"\BENEFICIARIO",aMatM,nil,nil,.F.,nil,cCodPeg)
		cAtenRN	:= u_CPEGCONR("ATENDIMENTORN",cGuia+"\BENEFICIARIO",aMatM,nil,nil,.F.,nil,cCodPeg)
	Else // 1, 2, 3
		cAtenRN	:= IIF( EmpTy( u_CPEGCONR("ATENDIMENTORN",cGuia+"\DADOSBENEFICIARIO",aMatM,nil,nil,.F.,nil,cCodPeg) ), "N", u_CPEGCONR("ATENDIMENTORN",cGuia+"\DADOSBENEFICIARIO",aMatM,nil,nil,.F.,nil,cCodPeg) )
		cMatric  := u_CPEGCONR("NUMEROCARTEIRA",cGuia+"\DADOSBENEFICIARIO",aMatM,nil,nil,nil,nil,cCodPeg)
		cNomeUsu := u_CPEGCONR("NOMEBENEFICIARIO",cGuia+"\DADOSBENEFICIARIO",aMatM,,,.F.,nil,cCodPeg)
	EndIf

//Valido para aceitar: Matricula PLS, Matricula Antiga, Matricula da Empresa
	cMatric := u_cbMatValida(cMatric)


// Ponto de entrada para matricula
	If ExistBlock("PLSXMLMAT")
		cMatric := ExecBlock( "PLSXMLMAT",.F.,.F.,{cMatric,cNomeUsu} )
	EndIf

	If !Empty(cMatric)
		AaDd( aDados, {"USUARIO" , cMatric  } )
	Else
		aRetuGe := u_CXMLUsrGe(PlsIntPad())
		If Len(aRetuGe) > 0
			AaDd( aDados, {"USUARIO" , aRetuGe[1]  } )
		EndIf
	EndIf

	AaDd( aDados, {"NOMUSR" , cNomeUsu } )
	AaDd( aDados, {"VIACAR" , "" } )

// Procura pelo numero do impresso o numero da liberacao
	If ExistBlock("PLSTMLLIB")
		cNumAut := ExecBlock( "PLSTMLLIB",.F.,.F.,{ cNumSen,cOpeMov,cCodRP,cTipo,cMatric,cGuiPri,lHonor,lEvolu } )
	Else
		cNumAut := cNumSen
	EndIf

// Verifica se existe a solicitacao
	If lResInt .Or. lHonor .Or. lEvolu
		If !Empty(cNumAut)
			BE4->( DbSetOrder(2) ) //BE4_FILIAL + BE4_CODOPE + BE4_ANOINT + BE4_MESINT + BE4_NUMINT
			If BE4->( MsSeek( xFilial("BE4")+padr(cNumAut,18) ) )
				AaDd( aDados, { "NUMSOL", cNumAut } )
				AaDd( aDados, { "NUMPEG", BE4->( BE4_CODOPE+BE4_CODLDP+BE4_CODPEG+BE4_NUMERO ) } )
			Else
				BE4->( DbSetOrder(7) )
				If BE4->( MsSeek( xFilial("BE4")+padr(cNumAut,9) ) )
					AaDd( aDados, { "NUMSOL", cNumAut } )
					AaDd( aDados, { "NUMPEG", BE4->( BE4_CODOPE+BE4_CODLDP+BE4_CODPEG+BE4_NUMERO ) } )
				Endif
			Endif
			If BE4->(Found())
				cPadConSol	:= BE4->BE4_PADINT
				cCidSol	:= BE4->BE4_CID
				nDiasSol	:= BE4->BE4_DIASIN
			EndIf
		EndIf
	EndIf

// Numero do Lote
	cNumeLot := AllTrim(u_CPEGCONR("NUMEROLOTE","\PRESTADORPARAOPERADORA\LOTEGUIAS",aMatC,nil,nil,nil,nil,cCodPeg))
	cNumeSeq := AllTrim(u_CPEGCONR("SEQUENCIALTRANSACAO","\CABECALHO\IDENTIFICACAOTRANSACAO",aMatC,nil,nil,nil,nil,cCodPeg))

	If Empty(cNumeLot)
		cNumeLot := cNumeSeq
	EndIf

// Dados complementares
	AaDd( aDados, {"LOTGUI" , cNumeLot} )
	AaDd( aDados, {"SEQTRA" , cNumeSeq} )
	AaDd( aDados, {"NUMPRE"	, cNumImp } )
	AaDd( aDados, {"TIPPAR"	, aTipPart } )

// Consulta
	cTipCon := u_CPEGCONR("TIPOCONSULTA",cGuia+"\DADOSATENDIMENTO",aMatM,nil,nil,.F.,nil,cCodPeg)
	cVincBkp	:= PLSVARVINC('52', , cTipCon)
	If !Empty(cVincBkp)
		cTipCon := cVincBkp
	EndIf
	AaDd( aDados, {"TIPCON" , cTipCon } )
	If cTipo=="1"
		AaDd( aDados, {"DATPRO" , u_CBAJUDAT( u_CPEGCONR("DATAATENDIMENTO",cGuia+"\DADOSATENDIMENTO",aMatM,nil,.F.,nil,nil,cCodPeg) ) } )
	Else
		cTipCon := u_CPEGCONR("TIPOCONSULTA",cGuia+"\DADOSATENDIMENTO",aMatM,nil,nil,.F.,nil,cCodPeg)
		cVincBkp	:= PLSVARVINC('52', , cTipCon)
		If !Empty(cVincBkp)
			cTipCon := cVincBkp
		EndIf
		AaDd( aDados, {"TIPCON" , cTipCon} )
		cTipAte := u_CPEGCONR("TIPOATENDIMENTO",cGuia+"\DADOSATENDIMENTO",aMatM,,,.F.,nil,cCodPeg)
		cVincBkp	:= PLSVARVINC('52',, cTipAte)
		If !Empty(cVincBkp)
			cTipAte := cVincBkp
		EndIf
		AaDd( aDados, {"TIPATE" ,cTipAte  } )
	EndIf

	If cTipo == "2"
		AaDd( aDados, {"INDCLI" , u_CPEGCONR("INDICACAOCLINICA",cGuia,aMatM,,,.F.,nil,cCodPeg) } )
		cCarAte := u_CPEGCONR("CARATERATENDIMENTO",cGuia,aMatM,,,.F.,nil,cCodPeg)
		cVincBkp	:= PLSVARVINC('23',, cCarAte)
		If !Empty(cVincBkp)
			cCarAte := cVincBkp
		EndIf
		AaDd( aDados, {"TIPADM" , cCarAte } )
	ElseIf cTipo == "2" // SADT Execução
		AaDd( aDados, {"INDCLI" , u_CPEGCONR("INDICACAOCLINICA",cGuia + "\DADOSSOLICITACAO",aMatM,,,.F.,nil,cCodPeg) } )
		cCarAte := u_CPEGCONR("CARATERATENDIMENTO",cGuia + "\DADOSSOLICITACAO",aMatM,,,.F.,nil,cCodPeg)
		cVincBkp	:= PLSVARVINC('23',, cCarAte)
		If !Empty(cVincBkp)
			cCarAte := cVincBkp
		EndIf

		AaDd( aDados, {"TIPADM" , cCarAte } )
	ElseIf cTipo == "3" .AND. cOrigem = "2" // Internação Solicitação
		cCarAte := u_CPEGCONR("CARATERATENDIMENTO",cGuia + "\DADOSINTERNACAO",aMatM,,,.F.,nil,cCodPeg)
		cVincBkp	:= PLSVARVINC('23',, cCarAte)
		If !Empty(cVincBkp)
			cCarAte := cVincBkp
		EndIf
		AaDd( aDados, {"TIPADM" , cCarAte } )
		AaDd( aDados, {"INDCLI" , u_CPEGCONR("INDICACAOCLINICA",cGuia + "\DADOSINTERNACAO",aMatM,,,.F.,nil,cCodPeg) } )
	ElseIf cTipo == "3" .AND. !lHonor

		cCarAte := u_CPEGCONR("CARATERATENDIMENTO",cGuia + "\DADOSINTERNACAO",aMatM,,,.F.,nil,cCodPeg)
		cVincBkp	:= PLSVARVINC('23',, cCarAte)
		If !Empty(cVincBkp)
			cCarAte := cVincBkp
		EndIf
		AaDd( aDados, {"TIPADM" , cCarAte } )

	EndIf

//<Codigo Diagnostico>
	If cTipo == "3" .AND. cOrigem == "1" .AND. !lHonor
		cCid := u_CPEGCONR("DIAGNOSTICO",cGuia+"\DADOSSAIDAINTERNACAO",aMatM,,,.F.,nil,cCodPeg)
		If Empty(cCid)
			cCid := cCidSol
		EndIf
	ElseIf cTipo == "3" .AND. !lHonor
		cCid := u_CPEGCONR("DIAGNOSTICOCID",cGuia+"\HIPOTESESDIAGNOSTICAS",aMatM,,,.F.,nil,cCodPeg)
		If Empty(cCid)
			cCid := cCidSol
		EndIf
	Else
		cCid := ""
	EndIf

	If !Empty(cCid)
		AaDd( aDados, {"CIDPRI" , cCid } )
	Endif

//<IndicadorAcidente>
	If cTipo == "1" .OR. cTipo == "2"
		cIndAci := u_CPEGCONR("INDICACAOACIDENTE",cGuia,aMatM,,,.F.,nil,cCodPeg)
		cVincBkp	:= PLSVARVINC('36',, cIndAci)
		If !Empty(cVincBkp)
			cIndAci := cVincBkp
		EndIf

	ElseIf cTipo == "3" .AND. cOrigem == "1" .AND. !lHonor
		cIndAci := u_CPEGCONR("INDICADORACIDENTE",cGuia + "\DADOSSAIDAINTERNACAO",aMatM,,,.F.,nil,cCodPeg)
		cVincBkp	:= PLSVARVINC('36',, cIndAci)
		If !Empty(cVincBkp)
			cIndAci := cVincBkp
		EndIf

	ElseIf cTipo == "3" .AND. !lHonor
		cIndAci := u_CPEGCONR("INDICADORACIDENTE",cGuia+"\HIPOTESESDIAGNOSTICAS",aMatM,,,.F.,nil,cCodPeg)
		cVincBkp	:= PLSVARVINC('36',, cIndAci)
		If !Empty(cVincBkp)
			cIndAci := cVincBkp
		EndIf
	Else
		cIndAci := ""
	EndIf

	If !Empty(cIndAci)
		AaDd( aDados, {"INDACI" , cIndAci } )
	Endif

	AaDd( aDados, {"NUMIMP" , cNumImp } )
	AaDd( aDados, {"NUMLIB" , cNumAut } )

//Internacao
	If cTipo == "2"

		cCarAte := u_CPEGCONR("CARATERATENDIMENTO",cGuia + "\DADOSSOLICITACAO",aMatM,,,.F.,nil,cCodPeg)
		cVincBkp	:= PLSVARVINC('23',, cCarAte)
		If !Empty(cVincBkp)
			cCarAte := cVincBkp
		EndIf

		AaDd( aDados, {"CARSOL" , cCarAte } )
	ElseIf ctipo == "3"
		AaDd( aDados, {"AUNMED" , aUnMed } )

		cCarAte := u_CPEGCONR("CARATERATENDIMENTO",cGuia + "\DADOSINTERNACAO",aMatM,,,.F.,nil,cCodPeg)
		cVincBkp	:= PLSVARVINC('23',, cCarAte)
		If !Empty(cVincBkp)
			cCarAte := cVincBkp
		EndIf

		AaDd( aDados, {"CARSOL" , cCarAte } )

	// Evolucao/Resumo
		If lEvolu

			cTipAco := u_CPEGCONR("TIPOACOMODACAOSOLICITADA",cGuia+"\DADOSINTERNACAO",aMatM,,,.F.,nil,cCodPeg)
			cVincBkp	:= PLSVARVINC('49',, cTipAco)
			If !Empty(cVincBkp)
				cTipAco := cVincBkp
			EndIf

			If Empty(cTipAco)
				cTipAco := cPadConSol
			EndIf
			cQtdDia := u_CPEGCONR("QTDIARIASADICIONAIS",cGuia+"\DADOSINTERNACAO",aMatM,,,.F.,nil,cCodPeg)
			If Empty(cQtdDia)
				cQtdDia := Alltrim(Str(nDiasSol))
			EndIf
			AaDd( aDados, {"PADCON" , cTipAco } )
			AaDd( aDados, {"QDIEVO" ,  cQtdDia } )
		Else
			If !Empty(cPadConSol)
				AaDd( aDados, {"PADCON" , cPadConSol } ) // Pego a informacao da Solicitaçao assim como é feito no remote quando a GRI é referenciada
			EndIf
		EndIf

		cTipInt := ""
		cGrpInt := u_CPEGCONR("TIPOINTERNACAO",cGuia + "\DADOSINTERNACAO",aMatM,,,.F.,nil,cCodPeg)
		cTipInt := PLSVARVINC('57', 'BQR', cGrpInt) // Vinculo Terminologia de TIPO de Atendimento Tabela 57 TISS

		AaDd( aDados, {"TPEVEN" , cGrpInt } )
		AaDd( aDados, {"TIPINT" , cTipInt } )

		cRegInt := u_CPEGCONR("REGIMEINTERNACAO",cGuia + "\DADOSINTERNACAO",aMatM,,,.F.,nil,cCodPeg)

		cVincBkp	:= PLSVARVINC('49',, cRegInt)
		If !Empty(cVincBkp)
			cRegInt := cVincBkp
		EndIf

		If Empty(cRegInt)
			cRegInt := '1'
		Endif

		AaDd( aDados, {"REGINT" , cRegInt } )
		AaDd( aDados, {"EMGEST" , u_CPEGCONR("EMGESTACAO",cGuia+"\INTERNACAOOBSTETRICA",aMatM,,,.F.,nil,cCodPeg) } )


	// Monta numerdo de declaracaoes
		nQtdNV 	:= 0
		nQtdNM 	:= 0
		cNumeDN 	:= ""
		cNumeOB 	:= ""
		cCidOB		:= ""

	//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	// Array criado para diferenciar a estrutura do RN ou do Paciente principal
	// da Guia pois a declaracao de obito por exemplo pode ser tanto do RN como
	// da MAE de acordo com a <IndicadorDORN> (Sim ou Nao)
	// aDeclaracoes [1] = declaracaoNascido
	// aDeclaracoes [2] = diagnosticoObito
	// aDeclaracoes [3] = declaracaoObito
	// aDeclaracoes [4] = indicadorDORN
	//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
		While !Empty( ( aMatNasc := u_CPEGCONR("DECLARACAONASCIDO",cGuia+"\DADOSINTERNACAO\DECLARACOES",aMatM,nil,.T.,nil,.T.,cCodPeg) )[1] )
			nPosDec := aMatNasc[2]
			cNumeDN += aMatNasc[1]+","
			nQtdNV ++
			aMatM[nPosDec,1] := "*"+aMatM[nPosDec,1]
		EndDo
		While !Empty( ( aMatOb := u_CPEGCONR("DIAGNOSTICOOBITO",cGuia+"\DADOSINTERNACAO\DECLARACOES",aMatM,nil,.T.,nil,.T.,cCodPeg) )[1] )
			nQtdNM ++
			cCidOB := aMatOb[1]
			nPosDec := aMatOb[2]
			For nI := (nPosDec+1) To (nPosDec + 2)
				If aMatM[nPosDec][1] == "DECLARACAOOBITO"
					cNumeOB += aMatM[nPosDec][2]+","
				EndIf
				If aMatM[nPosDec][1] == "INDICADORDORN"
					If Alltrim(Upper(aMatM[nPosDec][2])) == "S" // Quer dizer que o indicador é do RN
						nQtdNM ++
						cCidOB := ""
					EndIf
				EndIf
			Next nI
			aMatM[nPosDec,1] := "*"+aMatM[nPosDec,1]

		EndDo

		cNumeDN := Left( cNumeDN,Len(cNumeDN)-1 )
		AaDd( aDados, {"NRDCNV" , cNumeDN  } )

		cNumeOB := Left( cNumeDN,Len(cNumeOB)-1 )
		AaDd( aDados, {"NRDCOB" , cNumeOB  } )

		AaDd( aDados, {"QTNASV" , nQtdNV	} )
		AaDd( aDados, {"QTNASM" , nQtdNM 	} )

		cCid2 := u_CPEGCONR("DIAGNOSTICO",cGuia+"\DADOSSAIDAINTERNACAO",aMatM,,,.F.,nil,cCodPeg)
		If !Empty(cCid2)
			AaDd( aDados, {"CID2" 	, cCid2 } )
		Endif

		AaDd( aDados, {"QDISOL"	, Val(u_CPEGCONR("QTDIARIASSOLICITADAS",cGuia + "\DADOSINTERNACAO",aMatM,,,.F.,nil,cCodPeg)) } )
		AaDd( aDados, {"DATPRVINT", u_CBAJUDAT( u_CPEGCONR("DATASUGERIDAINTERNACAO",cGuia + "\DADOSHOSPITALSOLICITADO",aMatM,,,.F.,nil,cCodPeg) ) } )

		cIndAci := u_CPEGCONR("INDICADORACIDENTE",cGuia+"\DADOSSAIDAINTERNACAO",aMatM,,,.F.,nil,cCodPeg)
		cVincBkp	:= PLSVARVINC('36',, cIndAci)
		If !Empty(cVincBkp)
			cIndAci := cVincBkp
		EndIf
		AaDd( aDados, {"INDACI" ,  cIndAci} )

		cTipAlt := u_CPEGCONR("MOTIVOENCERRAMENTO",cGuia+"\DADOSSAIDAINTERNACAO",aMatM,,,.F.,nil,cCodPeg)
		cTipAlt := PLSVARVINC('39','BE4', cTipAlt) //Tabela 39 TISS - Motivo de encerramento

		AaDd( aDados, {"CIDOBT" , cCidOB } )
		AaDd( aDados, {"NRDCOB" , IIf(Substr(cNumeOB,Len(cNumeOB),1) == ",", Substr(cNumeOB,1,Len(cNumeOB)-1),cNumeOB) } )
		AaDd( aDados, {"TIPALT" ,cTipAlt } )

		cTipFat := alltrim(u_CPEGCONR("TIPOFATURAMENTO",cGuia+"\DADOSINTERNACAO" ,aMatM,,,.F.,nil,cCodPeg))
		cVincBkp := alltrim(PLSVARVINC('55', , cTipFat))
		If !Empty(cVincBkp)
			cTipFat := cVincBkp
		Else
		//<!--1- Parcial-->	<!--2- Final-->	<!--3- Complementar-->	<!--4- Total-->
			If cTipFat == "1"
				cTipFat := "P"
			ElseIf cTipFat == "2"
				cTipFat := "T"
			ElseIf cTipFat == "3"
				cTipFat := "P"
			ElseIf cTipFat == "4"
				cTipFat := "T"
			EndIf
		EndIf

	//A data de alta deve ser preenchida no Resumo de Internacao por mais que o resumo nao seja total, senao nao e possivel mudar a fase da guia
		cDtFimFat 	:= U_CBDELIM( u_CPEGCONR("DATAFINALFATURAMENTO",cGuia,aMatM,,,.F.,nil,cCodPeg) )
		cHrFimFat 	:= U_CBDELIM( u_CPEGCONR("HORAFINALFATURAMENTO",cGuia,aMatM,,,.F.,nil,cCodPeg) )
		AaDd( aDados, {"DTALTA"	, u_CBAJUDAT(SubStr(cDtFimFat,1,8)) } )
		AaDd( aDados, {"HRALTA"	, SubStr(cHrFimFat,1,8) } )

		AaDd( aDados, {"DTFIMFAT" , u_CBAJUDAT(SubStr(cDtFimFat,1,8)) } )
		AaDd( aDados, {"HRFIMFAT" , SubStr(cHrFimFat,1,8) } )

		cDtIniFat 	:= U_CBDELIM( u_CPEGCONR("DATAINICIOFATURAMENTO",cGuia,aMatM,,,.F.,nil,cCodPeg) )
		cHrIniFat 	:= U_CBDELIM( u_CPEGCONR("HORAINICIOFATURAMENTO",cGuia,aMatM,,,.F.,nil,cCodPeg) )
		AaDd( aDados, {"DTINIFAT" , u_CBAJUDAT(SubStr(cDtIniFat,1,8)) } )
		AaDd( aDados, {"HRINIFAT" , SubStr(cHrIniFat,1,8) } )
		AaDd( aDados, {"TIPFAT" , cTipFat } )

	EndIf

// Observacao
	cObs := u_CPEGCONR("OBSERVACAO",cGuia,aMatM,,,.F.,nil,cCodPeg)
	AaDd( aDados, {"MSG01" , SubStr(cObs,1,nTamObs)  } )
	AaDd( aDados, {"MSG02" , SubStr(cObs,nTamObs+1,Len(cObs)) } )
	AaDd( aDados, {"CODPEG" , cCodPeg } )

//Itens - CONSULTA
	If cTipo =="1"
		aMatIte := {}
		AaDd( aMatIte, {"SEQMOV" , "001" } )
		cSlvDes := ""
		cCodPad := u_CPEGCONR("CODIGOTABELA",cGuia+"\DADOSATENDIMENTO\PROCEDIMENTO",aMatM,,,.F.,nil,cCodPeg)
		cSlvPad := cCodPad
		cCodPro := u_CPEGCONR("CODIGOPROCEDIMENTO",cGuia+"\DADOSATENDIMENTO\PROCEDIMENTO",aMatM,,,nil,nil,cCodPeg)
		cCodPro := padr(cCodPro,tamsx3("BR8_CODPSA")[1])
		cSlvPro := cCodPro

		cCodPad := Alltrim(PLSVARVINC('87', 'BR4', cCodPad)) // Vinculo Terminologia de TIPO de Atendimento Tabela 57 TISS
		cCodPad := padr(cCodPad,tamsx3("BR8_CODPAD")[1])
		cCodPro := PLSVARVINC(cSlvPad, 'BR8', cCodPro,cSlvPad+cCodPro) // Vinculo Terminologia de TIPO de Atendimento Tabela 57 TISS
		cCodPro := padr(cCodPro,tamsx3("BR8_CODPSA")[1])
		dDatRea := u_CBAJUDAT(Alltrim(u_CPEGCONR("DATAEXECUCAO",cGuia+"\DADOSATENDIMENTO\DATAATENDIMENTO",aMatM,nil,nil,nil,nil,cCodPeg)))

	//Trata a especialidade do membro
		aAdd(aEspItXML,aClone(u_CBTrCBOIMP('2',cGuia,aMatM,cOrigem,cTipGui)))
		cEspExe := aEspItXML[Len(aEspItXML)][1]
		cCboExe := aEspItXML[Len(aEspItXML)][2]

	//Trata a especialidade do Prestador contratado
		cCodEsp := u_cbRtEspPre(cOpeMov,cRdaOri,cEspExe,dDatRea,cCodLoc,lPlsCTEs,.T.)
		aAdd(aEspItXML[Len(aEspItXML)],cCodEsp)

	//Zera as informacoes para o proximo Item
		u_cbFreArr(@aEspItXML)

		aAdd(aDados,{"CODESP",cCodEsp})
		aAdd(aMatIte,{"ESPEXE",cEspExe})

	// Mantido o Ponto de Entrada
		u_CBXPAD(@cCodPad,@cCodPro,@cDescric,,cTipGui,cVersao,dDatRea)

		BR8->(DbSetOrder(1))
		If !BR8->( MsSeek(xFilial("BR8")+cCodPad+cCodPro) ) .and. cOrigem <> '2'
		//Caso nao encontre com uma tabela e porque e a outra (criado por casos de mais de uma tabela padrao vinculado a mesma terminologia ex.: 01 e 02 -->> 22
			If !PChkTabDup(@cCodPad,cCodPro,cSlvPad)
				cCodPad := GetNewPar("MV_PLCDPXM","01")
				cCodPro := GetNewPar("MV_PLPSPXM","99999994")
				cCodPro := padr(cCodPro,tamsx3("BR8_CODPSA")[1])
			Else
				cDescric := Alltrim(BR8->BR8_DESCRI)
			EndIf
		Elseif Empty(cDescric)
			cDescric := Alltrim(BR8->BR8_DESCRI)
		EndIf

		AaDd( aMatIte, {"CODPAD" , cCodPad } )
		AaDd( aMatIte, {"CODPRO" , cCodPro} )
		AaDd( aMatIte, {"SLVPAD" , cSlvPad } )
		AaDd( aMatIte, {"SLVPRO" , cSlvPro} )
		AaDd( aMatIte, {"SLVDES" , cSlvDes} )
		AaDd( aMatIte, {"QTD"	 , 1 } )
		AaDd( aMatIte, {"QTDAUT" , 1 } )
		cVlrPro := StrTran( u_CPEGCONR("VALORPROCEDIMENTO",cGuia+"\DADOSATENDIMENTO\PROCEDIMENTO",aMatM,,,.F.,nil,cCodPeg),',',"." )
		AaDd( aMatIte, {"VLRAPR" , Val(cVlrPro) } )
	//::::::::::::::: Somatoria do Valor Total da Guia ::::::::::::::: \\
		nValorTotG += Val(cVlrPro)
		AaDd(aItens,aMatIte)
	Else

		cCont := "001"
		While !Empty( ( cCodPro := u_CPEGCONR("CODIGOPROCEDIMENTO",cGuia+"\PROCEDIMENTOSSOLICITADOS\PROCEDIMENTO",aMatM,nil,.T.,nil,nil,cCodPeg) ) )
			aMatIte := {}
			AaDd( aMatIte, {"SEQMOV" , cCont } )
			cCont := soma1(cCont)

			cCodPad := u_CPEGCONR("CODIGOTABELA",cGuia+"\PROCEDIMENTOSSOLICITADOS\PROCEDIMENTO",aMatM,nil,.T.,.F.,nil,cCodPeg)
			cSlvPad := cCodPad
			cDescric:= u_CPEGCONR("DESCRICAOPROCEDIMENTO",cGuia+"\PROCEDIMENTOSSOLICITADOS\PROCEDIMENTO",aMatM,nil,.T.,.F.,nil,cCodPeg)
			cSlvDes := cDescric
			cCodPro := padr(cCodPro,tamsx3("BR8_CODPSA")[1])
			cSlvPro := cCodPro

			cCodPad := Alltrim(PLSVARVINC('87', 'BR4', cCodPad)) // Vinculo Terminologia de TIPO de Atendimento Tabela 57 TISS
			cCodPad := padr(cCodPad,tamsx3("BR8_CODPAD")[1])
			cCodPro := PLSVARVINC(cSlvPad, 'BR8', cCodPro,cSlvPad+cCodPro) // Vinculo Terminologia de TIPO de Atendimento Tabela 57 TISS
			cCodPro := padr(cCodPro,tamsx3("BR8_CODPSA")[1])

			u_CBXPAD(@cCodPad,@cCodPro,@cDescric,,cTipGui,cVersao)

			BR8->(DbSetOrder(1))
			If !BR8->( MsSeek(xFilial("BR8")+cCodPad+cCodPro) ) .and. cOrigem <> '2' //nao eh uma solicitacao
				If !PChkTabDup(@cCodPad,cCodPro,cSlvPad) // Caso nao encontre com uma tabela é porque é a outra (criado por casos de mais de uma tabela padrao vinculado a mesma terminologia ex.: 01 e 02 -->> 22
					cCodPad := GetNewPar("MV_PLCDPXM","01")
					cCodPro := GetNewPar("MV_PLPSPXM","99999994")
					cCodPro := padr(cCodPro,tamsx3("BR8_CODPSA")[1])
				Else
					cDescric := Alltrim(BR8->BR8_DESCRI)
				EndIf
			Elseif Empty(cDescric)
				cDescric := Alltrim(BR8->BR8_DESCRI)
			EndIf


			AaDd( aMatIte, {"CODPAD" , cCodPad } )
			AaDd( aMatIte, {"CODPRO" , cCodPro } )
			AaDd( aMatIte, {"DESPRO" , cDescric } )
			AaDd( aMatIte, {"SLVPAD" , cSlvPad } )
			AaDd( aMatIte, {"SLVPRO" , cSlvPro} )
			AaDd( aMatIte, {"SLVDES" , cSlvDes} )

		//Verifica se o procedimento e de tipo pacote e alimenta os itens para gravacao da B43
			If BR8->( MsSeek(xFilial("BR8")+cCodPad+cCodPro) ) .And. BR8->BR8_TPPROC == "6"
				AaDd( aMatIte, {"PACPRO" , PlRetPac(PLSIntPad(),cRdaOri,cCodPad,cCodPro,,dDatRea) } )
			EndIf

			nQtd := Val( u_CPEGCONR("QUANTIDADESOLICITADA",cGuia+"\PROCEDIMENTOSSOLICITADOS",aMatM,,.T.,.F.,nil,cCodPeg) )
			AaDd( aMatIte, {"QTD" , nQtd } )
			AaDd( aMatIte, {"QTDAUT" , nQtd } )
			AaDd( aMatIte, {"VLRAPR" , 0 } )


	// Incluir tratamento quando for EVOLUCAO (PRORROGACAO)
			If lEvolu
				AaDd( aMatIte, {"NUMIMP" , cNumImp } )
			EndIf
			If Len(aTpPRec) >0
				AaDd( aMatIte, {"ATPPAR" , aTpPRec } )
			Endif

			AaDd(aItens,aMatIte)
		EndDo

	// Procedimentos Solicitados
		While !Empty( ( cCodPro := u_CPEGCONR("CODIGOPROCEDIMENTO",cGuia+"\PROCEDIMENTOSADICIONAIS\PROCEDIMENTO",aMatM,nil,.T.,nil,nil,cCodPeg) ) )
			aMatIte := {}
			AaDd( aMatIte, {"SEQMOV" , cCont } )
			cCont := soma1(cCont)
			cSlvDes := ""
			cCodPad := u_CPEGCONR("CODIGOTABELA",cGuia+"\PROCEDIMENTOSADICIONAIS\PROCEDIMENTO",aMatM,nil,.T.,.F.,nil,cCodPeg)
			cSlvPad := cCodPad

			cCodPro := padr(cCodPro,tamsx3("BR8_CODPSA")[1])
			cSlvPro := cCodPro

			cCodPad := Alltrim(PLSVARVINC('87', 'BR4', cCodPad)) // Vinculo Terminologia de TIPO de Atendimento Tabela 57 TISS
			cCodPad := padr(cCodPad,tamsx3("BR8_CODPAD")[1])
			cCodPro := PLSVARVINC(cSlvPad, 'BR8', cCodPro,cSlvPad+cCodPro) // Vinculo Terminologia de TIPO de Atendimento Tabela 57 TISS
			cCodPro := padr(cCodPro,tamsx3("BR8_CODPSA")[1])

			u_CBXPAD(@cCodPad,@cCodPro,@cDescric,,cTipGui,cVersao)

			BR8->(DbSetOrder(1))
			If !BR8->( MsSeek(xFilial("BR8")+cCodPad+cCodPro) ) .and. cOrigem <> '2' //nao eh uma solicitacao
				If !PChkTabDup(@cCodPad,cCodPro,cSlvPad) // Caso nao encontre com uma tabela é porque é a outra (criado por casos de mais de uma tabela padrao vinculado a mesma terminologia ex.: 01 e 02 -->> 22
					cCodPad := GetNewPar("MV_PLCDPXM","01")
					cCodPro := GetNewPar("MV_PLPSPXM","99999994")
					cCodPro := padr(cCodPro,tamsx3("BR8_CODPSA")[1])
				Else
					cDescric := Alltrim(BR8->BR8_DESCRI)
				EndIf
			Elseif Empty(cDescric)
				cDescric := Alltrim(BR8->BR8_DESCRI)
			EndIf

			AaDd( aMatIte, {"CODPAD" , cCodPad } )
			AaDd( aMatIte, {"CODPRO" , cCodPro } )
			AaDd( aMatIte, {"DESPRO" , cDescric } )
			AaDd( aMatIte, {"SLVPAD" , cSlvPad } )
			AaDd( aMatIte, {"SLVPRO" , cSlvPro} )
			AaDd( aMatIte, {"SLVDES" , cSlvDes} )

		//Verifica se o procedimento e de tipo pacote e alimenta os itens para gravacao da B43
			If BR8->( MsSeek(xFilial("BR8")+cCodPad+cCodPro) ) .And. BR8->BR8_TPPROC == "6"
				AaDd( aMatIte, {"PACPRO" , PlRetPac(PLSIntPad(),cRdaOri,cCodPad,cCodPro,,dDatRea) } )
			EndIf

			nQtd := Val( u_CPEGCONR("QUANTIDADESOLICITADA",cGuia+"\PROCEDIMENTOSADICIONAIS",aMatM,,.T.,.F.,nil,cCodPeg) )
			AaDd( aMatIte, {"QTD" , nQtd } )
			AaDd( aMatIte, {"QTDAUT" , nQtd } )
			AaDd( aMatIte, {"VLRAPR" , 0 } )


		// Incluir tratamento quando for EVOLUCAO (PRORROGACAO)
			If lEvolu
				AaDd( aMatIte, {"NUMIMP" , cNumImp } )
			EndIf
			If Len(aTpPRec) >0
				AaDd( aMatIte, {"ATPPAR" , aTpPRec } )
			Endif

			AaDd(aItens,aMatIte)
		EndDo
		
		cTagPart2 := ""
		If lHonor
			cTagProc 		:= "\PROCEDIMENTOSREALIZADOS\PROCEDIMENTOREALIZADO\PROCEDIMENTO"
			cTagMae		:= "\PROCEDIMENTOSREALIZADOS\PROCEDIMENTOREALIZADO"
			cTagVo			:= "\PROCEDIMENTOSREALIZADOS"
			cTagEquip		:= "\PROFISSIONAIS"
			cTagPart		:= "GRAUPARTICIPACAO"
		Else
			cTagProc 		:= "\PROCEDIMENTOSEXECUTADOS\PROCEDIMENTOEXECUTADO\PROCEDIMENTO"
			cTagMae		:= "\PROCEDIMENTOSEXECUTADOS\PROCEDIMENTOEXECUTADO"
			cTagVo			:= "\PROCEDIMENTOSEXECUTADOS"
			cTagPart		:= "GRAUPART"
			cTagPart2		:= "NOMEPROF"
			If cTipo == "2"
				cTagEquip		:= "\EQUIPESADT"
			Else
				cTagEquip		:= "\IDENTEQUIPE\IDENTIFICACAOEQUIPE"
			EndIf
		EndIf

	// Procedimentos Realizados\Executados
		While !Empty( ( aMatPro := u_CPEGCONR("CODIGOPROCEDIMENTO",cGuia+cTagProc,aMatM,nil,.F.,nil,.T.,cCodPeg, @nLimite) )[1] )
			lAchouVlr  := .F. //Reinicializa a variavel de valor apresentado
			nPosVlrApr := 0 //Reinicializa a posicao da tag CODIGO para verificar se foi informado o valor do procedimento

			cCodPro := aMatPro[1]
			cCodPro := padr(cCodPro,tamsx3("BR8_CODPSA")[1])
			cSlvPro := cCodPro
			cSlvDes := ""
			aMatIte := {}
			AaDd( aMatIte, {"SEQMOV" , cCont } )
			cCont := soma1(cCont)

			cCodPad := Alltrim(u_CPEGCONR("CODIGOTABELA",cGuia+cTagProc,aMatM,nil,.T.,.F.,nil,cCodPeg))
			cSlvPad := cCodPad

			cCodPad := Alltrim(PLSVARVINC('87', 'BR4', cCodPad)) // Vinculo Terminologia de TIPO de Atendimento Tabela 57 TISS
			cCodPad := padr(cCodPad,tamsx3("BR8_CODPAD")[1])
			cCodPro := Alltrim(PLSVARVINC(cSlvPad, 'BR8', cCodPro,cSlvPad+cCodPro)) // Vinculo Terminologia
			cCodPro := padr(cCodPro,tamsx3("BR8_CODPSA")[1])
			dDatRea := u_CBAJUDAT(Alltrim(u_CPEGCONR("DATAEXECUCAO",cGuia+cTagVo,aMatM,nil,nil,nil,nil,cCodPeg)))

			If Empty(cDescric)
				cDescric:= UPPER(u_CPEGCONR("DESCRICAOPROCEDIMENTO",cGuia+"\PROCEDIMENTOSEXECUTADOS\PROCEDIMENTO",aMatM,nil,.T.,.F.,nil,cCodPeg))
			Endif


			If Empty(cCodPro)
				cCodPro:= UPPER(u_CPEGCONR("CODIGOPROCEDIMENTO",cGuia+"\PROCEDIMENTOSEXECUTADOS\PROCEDIMENTO",aMatM,nil,.T.,.F.,nil,cCodPeg))
			Endif

			u_CBXPAD(@cCodPad,@cCodPro,@cDescric,,cTipGui,cVersao,dDatRea)

			BR8->(DbSetOrder(1))
			If !BR8->( MsSeek(xFilial("BR8")+cCodPad+cCodPro) ) .and. cOrigem <> '2'
			// Caso nao encontre com uma tabela é porque é a outra (criado por casos de mais de uma tabela padrao vinculado a mesma terminologia ex.: 01 e 02 -->> 22
				If !PChkTabDup(@cCodPad,cCodPro,cSlvPad)
					cCodPad := GetNewPar("MV_PLCDPXM","01")
					cCodPro := GetNewPar("MV_PLPSPXM","99999994")
					cCodPro := padr(cCodPro,tamsx3("BR8_CODPSA")[1])
				Else
					cDescric := Alltrim(BR8->BR8_DESCRI)
				EndIf
			Elseif Empty(cDescric)
				cDescric := Alltrim(BR8->BR8_DESCRI)
			EndIf

			AaDd( aMatIte, {"CODPAD" , cCodPad } )
			AaDd( aMatIte, {"CODPRO" , cCodPro } )
			AaDd( aMatIte, {"DESPRO" , cDescric } )
			AaDd( aMatIte, {"SLVPAD" , cSlvPad } )
			AaDd( aMatIte, {"SLVPRO" , cSlvPro} )
			AaDd( aMatIte, {"SLVDES" , cSlvDes} )

		//Verifica se o procedimento e de tipo pacote e alimenta os itens para gravacao da B43
			If BR8->( MsSeek(xFilial("BR8")+cCodPad+cCodPro) ) .And. BR8->BR8_TPPROC == "6"
				AaDd( aMatIte, {"PACPRO" , PlRetPac(PLSIntPad(),cRdaOri,cCodPad,cCodPro,,dDatRea) } )
			EndIf

			nQtd := Val( u_CPEGCONR("QUANTIDADEEXECUTADA",cGuia+cTagMae,aMatM,nil,.T.,.F.,nil,cCodPeg) )
			AaDd( aMatIte, {"QTD" , nQtd } )
			AaDd( aMatIte, {"QTDAUT" , nQtd } )
			nRedAcr := Val( u_CPEGCONR("REDUCAOACRESCIMO",cGuia+cTagMae,aMatM,nil,.T.,.F.,nil,cCodPeg) )

			cViaAces := u_CPEGCONR("VIAACESSO",cGuia+cTagMae,aMatM,nil,.T.,.F.,nil,cCodPeg, nLimite)
			cVincBkp := PLSVARVINC('61', 'BGR', cViaAces) // Vinculo Terminologia de Via de Acesso Tabela 61 TISS

			If !Empty(cVincBkp)
				cViaAces := cVincBkp
			EndIf

			If !Empty(cViaAces)
				BGR->(DbSetOrder(1))
				If BGR->(MsSeek(xFilial("BGR") + cOpeMov + cViaAces))
					AaDd( aMatIte, {"PERVIA" , BGR->BGR_PERC } )
					AaDd( aMatIte, {"VIAACE" , BGR->BGR_CODVIA } )
				EndIf
			Endif

		//	TUWSJO - Se não existir equipe de RDA no XML, vai pagar o RDA da Guia
			IF EMPTY(aMatEqu)
				cCodRP := BXX->BXX_CODRDA
				cRDAOri := cCodRP
			ENDIF

		//eu carrego todas as composicoes possiveis ou seja, vou pegar o que tiver no bd4
			aSlvTprec := aClone(aTpPRec)
			If Len(aTpPRec) == 0
				For nPos:=1 to Len (aMatBWT)
					AaDd( aTpPRec,{ aMatBWT[nPos,2],If(Empty(cConPrEx),cCodRP,cConPrEx),If(Empty(cNomRdEx),cNomRda,cNomRdEx),cCrmRda,cSlgRda,cEstRda,cNomPre,.T.,'','',u_CBRetUnp(aMatBWT[nPos,2]) } )
				Next
			Endif
			If Len(aTpPRec) > 0
				AaDd( aMatIte, {"ATPPAR" , aTpPRec } )
			Endif
			aTpPRec := aClone(aSlvTprec)

		// Verifica se foi informado valor ao procedimento processado
			nPosVlrApr := aScan (aMatM,{ |x|x[1] == "CODIGOPROCEDIMENTO" .and. alltrim(cSlvPro) == alltrim(x[2]) .And. cTagVo $ x[3]})
			If nPosVlrApr <> 0
				nPosVlrApr ++
				While nPosVlrApr <= len(aMatM) .And. aMatM[nPosVlrApr][1] <> "CODIGOPROCEDIMENTO"

				// Se achar a tag de valor, alimenta o array com o que foi apresentado nela
					If aMatM [nPosVlrApr][1] == "VALORUNITARIO"
						nVlrApr := Val( strtran( u_CPEGCONR("VALORUNITARIO",cGuia+cTagMae,aMatM,nil,.T.,.F.,nil,cCodPeg),',',"." ) )
						nVlrTotPrc := Val( strtran( u_CPEGCONR("VALORTOTAL",cGuia+cTagMae,aMatM,nil,.T.,.F.,nil,cCodPeg),',',"." ) )
						
						nVlrApr := nVlrTotPrc / nQtd //O valor apresentado unitᲩo 頯 total Dividido pela quantidade
						
						AaDd( aMatIte, {"VLRAPR" , nVlrApr } )
						lAchouVlr := .T.
						Exit
					EndIf
					nPosVlrApr ++
				EndDo
			EndIf

		// Se nao achou a tag de valor alimenta o Array com o valor zerado
			If !lAchouVlr
				AaDd( aMatIte, {"VLRAPR" , 0 } )
			EndIf

			dDataXX := u_CBAJUDAT( u_CPEGCONR("DATAEXECUCAO",cGuia+cTagMae,aMatM,nil,.T.,nil,nil,cCodPeg) )
			
			AaDd( aMatIte, {"HORINI" , SubStr(u_CPEGCONR("HORAINICIAL",cGuia+cTagMae,aMatM,nil,.T.,nil,nil,cCodPeg),1,5) } )
			AaDd( aMatIte, {"HORFIM" , SubStr(u_CPEGCONR("HORAFINAL",cGuia+cTagMae,aMatM,nil,.T.,nil,nil,cCodPeg),1,5) } )
			AaDd( aMatIte, {"DATPRO" , dDataXX} )

			If EmpTy(dDataAnt) .AND. !(Empty(dDataXX))
				AaDd( aDados, {"DATPRO" , dDataXX } ) //Adiciona a data do procedimento BD6 para a data da Guia BD5
			EndIf
			dDataAnt := dDataXX

			lMemEqui := .F.
			aTpPRe2  := {}
			aPosEnv  := {}

		// Pega o tipo de participacao e equipe
			While !Empty( (aMatEqu := u_CPEGCONR(If(Empty(cTagPart2),cTagPart,cTagPart+','+cTagPart2),cGuia+cTagMae + cTagEquip,aMatM,nil,nil,nil,.T.,cCodPeg) )[1] ) .And. VerMembro(aMatEqu[2],aMatPro[2],aMatM,cTipGui)

				cSigla 	:= ""
				cCrm 	:= ""
				cUf 	:= ""
				cNome   := ""
			//se o prestador nao mandou a posicao do profissional eu devo considerar que pode ser qualquer uma!!
				If Len(aMatEqu[1]) > 2
					aMatEqu[1] := "" //quando ele nao manda o grau de participacao eu gravo vazio para ele considerar todas
					For nJ:=0 to 13
						AaDd( aPosEnv, strzero(nJ,2)  )
					Next
				//eu pego o nome do profssional aqui pois ele vai marcar com *e nao pegar o profisisonal 2 vezes
					cNome   	:= u_CPEGCONR("NOMEPROFISSIONAL,NOMEPROF",cGuia+cTagMae + cTagEquip,aMatM,,.T.,.F.,nil,cCodPeg,aMatEqu[2]+9)
				Else
					AaDd( aPosEnv, aMatEqu[1]  )//posicao do profissional enviada pelo prestador
				//eu pego o nome do profssional aqui pois ele vai marcar com *e nao pegar o profisisonal 2 vezes
					cNome   	:= u_CPEGCONR("NOMEPROFISSIONAL,NOMEPROF",cGuia+cTagMae + cTagEquip,aMatM,,.T.,.F.,nil,cCodPeg,aMatEqu[2]+9)
				Endif

				aMatM[aMatEqu[2],1] := "*"+aMatM[aMatEqu[2],1]
				cCdMbEq := u_CPEGCONR("CPFCONTRATADO",cGuia+cTagMae + cTagEquip + "\CODPROFISSIONAL",aMatM,nil,.T.,.F.,nil,cCodPeg,aMatEqu[2]+9)
				cCdMbEq := cCdMbEq+Space( TamSX3("BAU_CPFCGC")[1]-Len(cCdMbEq) )

				If Empty(cCdMbEq)
					If !lHonor

						cSigla 	:= u_CPEGCONR("CONSELHOPROFISSIONAL,CONSELHO",cGuia+cTagMae + cTagEquip,aMatM,,.T.,.F.,nil,cCodPeg,aMatEqu[2]+9)
						cVincBkp	:= PLSVARVINC('26', , STRZERO(VAL(cSigla),7))
						If !Empty(cVincBkp)
							cSigla := cVincBkp
						EndIf
						cCrm 		:= u_CPEGCONR("NUMEROCONSELHOPROFISSIONAL",cGuia+cTagMae + cTagEquip,aMatM,,.T.,.F.,nil,cCodPeg,aMatEqu[2]+9)
						cUf 		:= u_CPEGCONR("UF",cGuia+cTagMae + cTagEquip,aMatM,,.T.,.F.,nil,cCodPeg)
						cVincBkp	:= PLSVARVINC('59',, cUf)
						If !Empty(cVincBkp)
							cUf := cVincBkp
						EndIf

					Else
						cSigla 	:= u_CPEGCONR("CONSELHOPROFISSIONAL,CONSELHO",cGuia+cTagMae + cTagEquip,aMatM,,.T.,.F.,nil,cCodPeg,aMatEqu[2]+9)
						cVincBkp	:= PLSVARVINC('26', , STRZERO(VAL(cSigla),7))
						If !Empty(cVincBkp)
							cSigla := cVincBkp
						EndIf

						cCrm 		:= u_CPEGCONR("NUMEROCONSELHOPROFISSIONAL",cGuia+cTagMae + cTagEquip,aMatM,,.T.,.F.,nil,cCodPeg,aMatEqu[2]+9)
						cUf 		:= u_CPEGCONR("UF",cGuia+cTagMae + cTagEquip,aMatM,,.T.,.F.,nil,cCodPeg)
						cVincBkp	:= PLSVARVINC('59',, cUf)
						If !Empty(cVincBkp)
							cUf := cVincBkp
						EndIf

					EndIf
					nIdx 	:= 4

					U_CBIVPRO("",cSigla,cCrm,cUf,nIdx,"E",aDados)
					u_CBXSCU("",cSigla,cCrm,cUf,"E",NIL,nil,nil,cNome,nil,cData)

					If BB0->( Found() )
						cCdMbEq := BB0->BB0_CODIGO
					EndIf
				EndIf

				If Empty(cCdMbEq)
					If !lHonor
						cSigla 	:= u_CPEGCONR("CONSELHOPROFISSIONAL",cGuia+cTagMae + cTagEquip,aMatM,,.T.,.F.,nil,cCodPeg,aMatEqu[2]+9)
						cVincBkp	:= PLSVARVINC('26', , STRZERO(VAL(cSigla),7))
						If !Empty(cVincBkp)
							cSigla := cVincBkp
						EndIf

						cCrm 		:= u_CPEGCONR("NUMEROCONSELHOPROFISSIONAL",cGuia+cTagMae + cTagEquip,aMatM,,.T.,.F.,nil,cCodPeg,aMatEqu[2]+9)
						cUf 		:= u_CPEGCONR("UF",cGuia+cTagMae + cTagEquip,aMatM,,.T.,.F.,nil,cCodPeg)
						cVincBkp	:= PLSVARVINC('59',, cUf)
						If !Empty(cVincBkp)
							cUf := cVincBkp
						EndIf

					Else
						cSigla 	:= u_CPEGCONR("CONSELHOPROFISSIONAL,CONSELHO",cGuia+cTagMae + cTagEquip,aMatM,,.T.,.F.,nil,cCodPeg,aMatEqu[2]+9)
						cVincBkp	:= PLSVARVINC('26', , STRZERO(VAL(cSigla),7))
						If !Empty(cVincBkp)
							cSigla := cVincBkp
						EndIf
						cCrm 		:= u_CPEGCONR("NUMEROCONSELHOPROFISSIONAL",cGuia+cTagMae + cTagEquip,aMatM,,.T.,.F.,nil,cCodPeg,aMatEqu[2]+9)
						cUf 		:= u_CPEGCONR("UF",cGuia+cTagMae + cTagEquip,aMatM,,.T.,.F.,nil,cCodPeg)
						cVincBkp	:= PLSVARVINC('59',, cUf)
						If !Empty(cVincBkp)
							cUf := cVincBkp
						EndIf
					EndIf

					nIdx 	:= 4

					U_CBIVPRO("",cSigla,cCrm,cUf,nIdx,"E",aDados,nil,nil)
					u_CBXSCU("",cSigla,cCrm,cUf,"E",NIL,nil,nil,cNome,nil,cData)

				Endif
				cCodBAU := ""


				If BB0->( Found() )
					cSlgRda := BB0->BB0_CODSIG
					cCrmRda := BB0->BB0_NUMCR
					cEstRda := BB0->BB0_ESTADO
					cNomPre := BB0->BB0_NOME
				//Aqui eu faco um tratamento para que leve la para o BD7 o codigo
				//da RDA (se o profissional for uma RDA) executante no campo BD7_CDPFPR
					nRecBAU := BAU->(Recno())
					nOrdBAU := BAU->(IndexOrd())
					BAU->(DbSetOrder(5))
					If BAU->(MsSeek(xFilial("BAU")+BB0->BB0_CODIGO))
						cCodBAU := BAU->BAU_CODBB0
					Endif
					BAU->(DbGoTo(nRecBAU))
					BAU->(DbSetOrder(nOrdBAU))
				EndIf

			//Trata a especialidade do membro
				aAdd(aEspItXML,aClone(u_CBTrCBOIMP('2',cGuia,aMatM,cOrigem,cTipGui)))
				cEspExe := aEspItXML[Len(aEspItXML)][1]
				cCboExe := aEspItXML[Len(aEspItXML)][2]

			//Trata a especialidade do Prestador contratado
				cCodEsp := u_cbRtEspPre(cOpeMov,cRdaOri,cEspExe,dDatRea,cCodLoc,lPlsCTEs,.T.)
				aAdd(aEspItXML[Len(aEspItXML)], IIF( ValType(cCodEsp) == "C", cCodEsp, cCodEsp[1][1]))

			// Monta o tipo de participacao conforme a tabela bwt de/para
				aSlvBWT := aClone(aMatBWT)
				lEntrou := .F.
				while Len(aMatBWT) > 0 .and. ( nPos := aScan( aMatBWT,{ |x|x[3]==aMatEqu[1] .or. Empty(aMatEqu[1]) } ) ) > 0
					AaDd( aTpPRe2,{ aMatBWT[nPos,2],If(Empty(cConPrEx),cCodRP,cConPrEx),If(Empty(cNomRdEx),cNomRda,cNomRdEx),cCrmRda,cSlgRda,cEstRda,cNomPre,.T.,cCodBAU,cEspExe,u_CBRetUnp(aMatBWT[nPos,2]) } )
				//Adiciona a participacao no array de especialidades para localizar a composicao correta na gravacao da BD7.
					aAdd(aEspItXML[Len(aEspItXML)],aMatBWT[nPos,2])
					lEntrou := .T.
					nSize := Len(aMatBWT)
					aDel(aMatBWT,nPos)
					aSize(aMatBWT,nSize-1)
				Enddo
				If !lEntrou
					nPosGPart := IIf(Len(aMatEqu) >= 2 .AND. !Empty(aMatEqu[1]),aMatEqu[2],aScan(aMatM,{|x| 'GRAUPART' $ AllTrim(x[1])}))
					If GetNewPar("MV_PLSPART",.F.) .AND. nPosGPart <> 0
						AaDd( aTpPRe2,{ aMatM[nPosGPart][2] ,If(Empty(cConPrEx),cCodRP,cConPrEx),If(Empty(cNomRdEx),cNomRda,cNomRdEx),cCrmRda,cSlgRda,cEstRda,cNomPre,.T.,cCodBAU,cEspExe,u_CBRetUnp( aMatM[nPosGPart][2] )  } )
					Else
						AaDd( aTpPRe2,{ GetNewPar("MV_PLSNAPL","O"),If(Empty(cConPrEx),cCodRP,cConPrEx),If(Empty(cNomRdEx),cNomRda,cNomRdEx),cCrmRda,cSlgRda,cEstRda,cNomPre,.T.,cCodBAU,cEspExe,u_CBRetUnp( GetNewPar("MV_PLSNAPL","O")) } )
					EndIf
				EndIf
				aMatBWT := aClone(aSlvBWT)

				cCdMbEq  := ""
				cCrmRda := ""
				cSlgRda := ""
				cEstRda := ""
				cNomPre := ""
			EndDo

		//Posicao profissional enviada para um determinado evento
			AaDd( aMatIte, {"POSENV" , aClone(aPosEnv) } )

		// Marca no Array aMatM o Procedimento utilizado
			cCodPro := u_CPEGCONR("CODIGOPROCEDIMENTO",cGuia+cTagProc,aMatM,nil,.T.,nil,nil,cCodPeg)
			cCodPro := padr(cCodPro,tamsx3("BR8_CODPSA")[1])
			aClonTp := {}

			If Len(aEspItXML) > 0
			//Especialidades dos Executantes
				aAdd(aMatIte, {"ESPXML" , aClone(aEspItXML) } )

			//Alimenta na Matriz geral que sera utilizada no aDados
				aAdd(aEspCbXML,aClone(aEspItXML))

			//Zera as informacoes para o proximo Item
				u_cbFreArr(@aEspItXML)
			EndIf

			If Len(aTpPRe2) > 0
				lMemEqui := .T.
			//Se a participacao for enviada via TAG de equiep, o sistema desconsidera todas as participacoes e so grava as participacaoes da equipe
				For nPosXX:=1 to Len(aMatIte)
					If alltrim(aMatIte[nPosXX][1]) == "ATPPAR"
						aClonTp := aClone(aMatIte[nPosXX][2])
						nSize := Len(aMatIte)
						aDel(aMatIte,nPosXX)
						aSize(aMatIte,nSize-1)
						exit
					Endif
				Next

				AaDd( aMatIte, {"ATPPAR" , aClone(aTpPRe2) } )

			// se a operadora quiser que independente dos membros de equipe o sistema sempre importe as demais unidades - referentes ao CUSTO e FILME (BD7's)
			// ela deve informar neste parametro as classes de operadora que ela deseja que esta regra seja valida.
			// IMPORTANTE - Se as classes que identificam as RDAS DE COOPERATIVAS estiverem neste parametro, pode dar problema
			// por exemplo, a COOPERATIVA DE ANESTESISTAS DE BELO HORIZONTE manda so o AUX no arquivo. Se ele entrar nesse if
			// o sistema ira importar o CUSTO e FILME por exemplo.
			// unidades referentes ao CUsto e Filme:
			// aUnidades := {"COP","COR","UCO","FIL","DOP","CRR","INC","TCR","VDI","VMD","VMT","VTX","REA"}

				If  alltrim(cTipPOr) $ GetNewPar("MV_PTRTAEV",'')
					xPt := aScan(aMatIte,{|x| x[1] == "ATPPAR"})

					aUnidades := {"COP","COR","UCO","FIL","DOP","CRR","INC","TCR","VDI","VMD","VMT","VTX","REA"}
					If ExistBlock("PLSXMLAUN")
						aUnidades := ExecBlock( "PLSXMLAUN",.F.,.F.,aUnidades )
					Endif

					For nI:=1 to Len(aClonTp)
						If (nPos := aScan(aMatIte[xPt][2],{|x| alltrim(x[1]) == alltrim(aClonTp[nI][1])})) == 0
							aadd(aMatIte[xPt][2],aClone(aClonTp[nI]))
							aMatIte[xPt][2][Len(aMatIte[xPt][2])][11] := aClone(aUnidades)
						Endif
					Next
				Endif
			Endif
		//se o prestador esta mandando participacoes que ele ja mandou de um determinado procedimento, eu sou obrigado a criar outro evento,
		//pois de fato sao 2 procedimentos distintos... mesmo que a hora e data seja a mesma (porque os hospitais erram mto a digitacao...)
			lForPro := .F.
			For nI:= 1 to Len(aPosEnv)
				If u_cRtPos('CODPAD',aMatIte) > 0 .and. u_cRtPos('CODPRO',aMatIte) > 0 .and. u_cRtPos('HORINI',aMatIte) > 0  .and. u_cRtPos('HORFIM',aMatIte) > 0 .and. ;
						u_cRtPos('DATPRO',aMatIte) > 0 .and. u_cRtPos('QTDAUT',aMatIte) > 0 .and. u_cRtPos('ATPPAR',aMatIte) > 0  .and. u_cRtPos('VLRAPR',aMatIte) > 0
				//VARIAVEIS DE POSICIONAMENTO

					For nT := 1 To Len(aItens)
						nPCODPAD1 := u_cRtPos('CODPAD',aItens[nT])
						nPCODPAD2 := u_cRtPos('CODPAD',aMatIte)
						nPCODPRO1 := u_cRtPos('CODPRO',aItens[nT])
						nPCODPRO2 := u_cRtPos('CODPRO',aMatIte)
						nPHORINI1 := u_cRtPos('HORINI',aItens[nT])
						nPHORINI2 := u_cRtPos('HORINI',aMatIte)
						nPHORFIM1 := u_cRtPos('HORFIM',aItens[nT])
						nPHORFIM2 := u_cRtPos('HORFIM',aMatIte)
						nPDATPRO1 := u_cRtPos('DATPRO',aItens[nT])
						nPDATPRO2 := u_cRtPos('DATPRO',aMatIte)
						nPQTDAUT1 := u_cRtPos('QTDAUT',aItens[nT])
						nPQTDAUT2 := u_cRtPos('QTDAUT',aMatIte)
						xVCODPAD2 := aMatIte[nPCODPAD2,2]
						xVCODPRO2 := aMatIte[nPCODPRO2,2]
						xVHORINI2 := aMatIte[nPHORINI2,2]
						xVHORFIM2 := aMatIte[nPHORFIM2,2]
						xVDATPRO2 := aMatIte[nPDATPRO2,2]
						xVQTDAUT2 := aMatIte[nPQTDAUT2,2]

						If aItens[nT,nPCODPAD1, 2] == xVCODPAD2 .AND.;
								aItens[nT,nPCODPRO1][2] == xVCODPRO2   .and. ;//CODPRO
							aItens[nT,nPHORINI1][2] == xVHORINI2   .and. ;//HORINI
							aItens[nT,nPHORFIM1][2] == xVHORFIM2   .and. ;//HORFIN
							aItens[nT,nPDATPRO1][2] == xVDATPRO2  .and. ;//DATPRO
							aItens[nT,nPQTDAUT1][2] == xVQTDAUT2  .and. (nJ:=u_cRtPos('POSENV',aItens[nT])) > 0

							If aScan(aItens[nT][nJ][2],{|x| x == aPosEnv[nI] }) > 0

								lForPro := .T.
								exit

							Endif
						EndIf
					Next nT

				Endif
			Next


		// Indica se os eventos deverão ser aglutinados ou se ele
		// ira criar um BD6 para cada evento enviado a regra de aglutinacao eh
		// data + hora + evento + tipo tabela + qtd
		// Nao se soma a quantidade pois o cara esta informando as parta	1234icipacoes
		// em separado referente a um mesmo evento, ou seja, eh um evento so com
		// com varias participacoes												 |
		// O PADRAO EH SEMPRE AGLUTINAR - QUANDO TEM MEMBRO DE EQUIPE				 |
			If lMemEqui .and. !lForPro .And. GetNewPar("MV_PLTISME",.T.) .AND. !lNInfPar	//	TUTXA1
				If u_cRtPos('CODPAD',aMatIte) > 0 .and. u_cRtPos('CODPRO',aMatIte) > 0 .and. u_cRtPos('HORINI',aMatIte) > 0  .and. u_cRtPos('HORFIM',aMatIte) > 0 .and. ;
						u_cRtPos('DATPRO',aMatIte) > 0 .and. u_cRtPos('QTDAUT',aMatIte) > 0 .and. u_cRtPos('ATPPAR',aMatIte) > 0  .and. u_cRtPos('VLRAPR',aMatIte) > 0
					lEnAqu := .F.
					For nT:=1 to Len(aItens)

						nPCODPAD1 := u_cRtPos('CODPAD',aItens[nT])
						nPCODPAD2 := u_cRtPos('CODPAD',aMatIte)
						nPCODPRO1 := u_cRtPos('CODPRO',aItens[nT])
						nPCODPRO2 := u_cRtPos('CODPRO',aMatIte)
						nPHORINI1 := u_cRtPos('HORINI',aItens[nT])
						nPHORINI2 := u_cRtPos('HORINI',aMatIte)
						nPHORFIM1 := u_cRtPos('HORFIM',aItens[nT])
						nPHORFIM2 := u_cRtPos('HORFIM',aMatIte)
						nPDATPRO1 := u_cRtPos('DATPRO',aItens[nT])
						nPDATPRO2 := u_cRtPos('DATPRO',aMatIte)
						nPQTDAUT1 := u_cRtPos('QTDAUT',aItens[nT])
						nPQTDAUT2 := u_cRtPos('QTDAUT',aMatIte)
						xVCODPAD2 := aMatIte[nPCODPAD2,2]
						xVCODPRO2 := aMatIte[nPCODPRO2,2]
						xVHORINI2 := aMatIte[nPHORINI2,2]
						xVHORFIM2 := aMatIte[nPHORFIM2,2]
						xVDATPRO2 := aMatIte[nPDATPRO2,2]
						xVQTDAUT2 := aMatIte[nPQTDAUT2,2]

						If aItens[nT,nPCODPAD1, 2] == xVCODPAD2 .AND.;
								aItens[nT,nPCODPRO1][2] == xVCODPRO2   .and. ;//CODPRO
							aItens[nT,nPHORINI1][2] == xVHORINI2   .and. ;//HORINI
							aItens[nT,nPHORFIM1][2] == xVHORFIM2   .and. ;//HORFIN
							aItens[nT,nPDATPRO1][2] == xVDATPRO2  .and. ;//DATPRO
							aItens[nT,nPQTDAUT1][2] == xVQTDAUT2

							nPos:=nT

							aItens[nPos][u_cRtPos('VLRAPR',aItens[nPos])][2] += aMatIte[u_cRtPos('VLRAPR',aMatIte)][2]    //VLRAPR
						//nesta regra eu garanto que vou importar todas as composicoes que foram de fato enviadas pelo prestador
						//se a posicao 11 do array estiver vazia significa que o prestador me mandou esta composicao
						//sei isso por causa deste For nI:=1 to Len(aClonTp) la encima
							If (nJ:=u_cRtPos('ATPPAR',aMatIte)) > 0 .and. (xPto:=u_cRtPos('ATPPAR',aItens[nPos])) > 0
								For nP:=1 to Len(aMatIte[nJ][2])
									If  (nZo := aScan(aItens[nPos][xPto][2],{|x| alltrim(x[1]) == alltrim(aMatIte[nJ][2][nP][1]) })) > 0
										If Len(aItens[nPos][xPto][2][nZo][11]) > 0 .and. Empty(aItens[nPos][xPto][2][nZo][7])//testo se o profissional ainda nao foi preenchido, se nao foi ainda significa que a participacao ta livre, entao eu uso ela
										//If Len(aMatIte[nJ][2][nP][11]) == 0 //----------------esse if aqui com passar do tempo passou a gerar problema em nao gravar todas as composicoes enviadas, mudei pelo Empty(aItens[nPos][xPto][2][nZo][7]) ali acima
											For nE:=1 To Len(aItens[nPos][xPto][2][nZo])
												If ValType(aItens[nPos][xPto][2][nZo][nE]) <> 'A'
													aItens[nPos][xPto][2][nZo][nE] := aMatIte[nJ][2][nP][nE]
												Else
													aItens[nPos][xPto][2][nZo][nE] := aClone(aMatIte[nJ][2][nP][nE])
												Endif
											Next
										//Endif
										Endif
									Else
										aadd(aItens[nPos][xPto][2],aClone(aMatIte[nJ][2][nP]))
									Endif

								Next
							Endif
						//neste array eu tenho efetivamente todas as participacoes que realmente foram enviadas para um determinado procedimento
							If (nJ:=u_cRtPos('POSENV',aItens[nPos])) > 0
								For nP:=1 to Len(aPosEnv)
									aadd(aItens[nPos][nJ][2],aPosEnv[nP])
								Next
							Endif
							lEnAqu := .T.
							exit
						Endif
					Next nT
					If !lEnAqu
						aMatIte := aSort( aMatIte,,, { |x, y| x[1] < y[1] } )
						AaDd(aItens,aClone(aMatIte))
					Endif
				Else
					aMatIte := aSort( aMatIte,,, { |x, y| x[1] < y[1] } )
					AaDd(aItens,aClone(aMatIte))
				Endif
			Else
				aMatIte := aSort( aMatIte,,, { |x, y| x[1] < y[1] } )
				AaDd(aItens,aClone(aMatIte))
			Endif
		EndDo

	// Outras Despesas
		nLimite := 1
		While !Empty( ( cCodPro := u_CPEGCONR("CODIGOPROCEDIMENTO",cGuia+"\OUTRASDESPESAS\DESPESA\SERVICOSEXECUTADOS",aMatM,nil,.F.,nil,nil,cCodPeg, @nLimite) ) )
			lAchouVlr  := .F. //Reinicializa a variavel de valor apresentado
			nPosVlrApr := 0 //Reinicializa a posicao da tag CODIGO para verificar se foi informado o valor do procedimento
			cCodProxml	:=	""
			aMatIte := {}
			AaDd( aMatIte, {"SEQMOV" , cCont } )
			cCont := soma1(cCont)

			cCodPad := u_CPEGCONR("CODIGOTABELA",cGuia+"\OUTRASDESPESAS\DESPESA\SERVICOSEXECUTADOS",aMatM,nil,.T.,.F.,nil,cCodPeg)
			cSlvPad := cCodPad
			cDescric := u_CPEGCONR("DESCRICAOPROCEDIMENTO",cGuia+"\OUTRASDESPESAS\DESPESA\SERVICOSEXECUTADOS",aMatM,nil,.T.,.F.,nil,cCodPeg)
			cSlvDes := cDescric
			cCodPro := padr(cCodPro,tamsx3("BR8_CODPSA")[1])
			cSlvPro := cCodPro

			cCodPad := PLSVARVINC('87', 'BR4', cCodPad) // Vinculo Terminologia de tipo de tabelas Tabela 87 TISS
			cCodPad := padr(cCodPad,tamsx3("BR8_CODPAD")[1])
			cCodPro := PLSVARVINC(cSlvPad, 'BR8', cCodPro,cSlvPad+cCodPro) // Vinculo Terminologia de procedimento Tabela 22 TISS

// Tipo de Despesa
			cTpProc := AllTrim(u_CPEGCONR("CODIGODESPESA",cGuia+"\OUTRASDESPESAS\DESPESA",aMatM,nil,.T.,.F.,nil,cCodPeg))
			cSlvTpPr:= cTpProc
			cVincBkp := PLSVARVINC('25', "", cTpProc) // Vinculo Terminologia de Codigo da despesa Tabela 25 TISS
			If Empty(cVincBkp) // Se nao tem terminologia executa a regra antiga
				Do Case
				Case cTpProc == "01"
					cTpProc := "7" 	//Gases Medicinais
				Case cTpProc == "02"
					cTpProc := "2" 	//Medicamento
				Case cTpProc == "03"
					cTpProc := "1" 	//Material
				Case cTpProc == "04"
					cTpProc := "3" 	//Taxas
				Case cTpProc == "05"
					cTpProc := "4" 	//Diarias
				Case cTpProc == "06"
					cTpProc := "8" 	//Alugueis
				EndCase
			Else
				cTpProc := cVincBkp
			EndIf

			cCodProxml:=cCodPro
			dDatRea := u_CBAJUDAT( u_CPEGCONR("DATAEXECUCAO",cGuia+"\OUTRASDESPESAS\DESPESA\SERVICOSEXECUTADOS",aMatM,nil,nil,nil,nil,cCodPeg) )

			If Empty(cCodPro)
				cCodPro:= UPPER(u_CPEGCONR("CODIGOPROCEDIMENTO",cGuia+"\OUTRASDESPESAS\DESPESA",aMatM,nil,.T.,.F.,nil,cCodPeg))
			Endif

			If Empty(cDescric)
				cDescric:= UPPER(u_CPEGCONR("DESCRICAOPROCEDIMENTO",cGuia+"\OUTRASDESPESAS\DESPESA",aMatM,nil,.T.,.F.,nil,cCodPeg))
			Endif

			u_CBXPAD(@cCodPad,@cCodPro,@cDescric,@cTpProc,cTipGui,cVersao,dDatRea)

			BR8->(DbSetOrder(1))
			If !BR8->( MsSeek(xFilial("BR8")+cCodPad+Alltrim(cCodPro)) ) .and. cOrigem <> '2' //nao eh uma solicitacao
				If !PChkTabDup(@cCodPad,Alltrim(cCodPro),cSlvPad) // Caso nao encontre com uma tabela é porque é a outra (criado por casos de mais de uma tabela padrao vinculado a mesma terminologia ex.: 01 e 02 -->> 22
					cCodPad := GetNewPar("MV_PLCDPXM","01")
					cCodPro := GetNewPar("MV_PLPSPXM","99999994")
					cCodPro := padr(cCodPro,tamsx3("BR8_CODPSA")[1])
				Else
					cDescric := Alltrim(BR8->BR8_DESCRI)
				EndIf
			Elseif Empty(cDescric)
				cDescric := Alltrim(BR8->BR8_DESCRI)
			EndIf

			AaDd( aMatIte, {"CODPAD" , cCodPad } )
			AaDd( aMatIte, {"CODPRO" , cCodPro } )
			AaDd( aMatIte, {"DESPRO" , cDescric } )
			AaDd( aMatIte, {"SLVPAD" , cSlvPad } )
			AaDd( aMatIte, {"SLVPRO" , cSlvPro} )
			AaDd( aMatIte, {"SLVDES" , cSlvDes} )

		//Verifica se o procedimento e de tipo pacote e alimenta os itens para gravacao da B43
			If BR8->( MsSeek(xFilial("BR8")+cCodPad+cCodPro) ) .And. BR8->BR8_TPPROC == "6"
				AaDd( aMatIte, {"PACPRO" , PlRetPac(PLSIntPad(),cRdaOri,cCodPad,cCodPro,,dDatRea) } )
			EndIf

			nQtd := Val( u_CPEGCONR("QUANTIDADEEXECUTADA",cGuia + "\OUTRASDESPESAS\DESPESA\SERVICOSEXECUTADOS",aMatM,,.T.,.F.,nil,cCodPeg) )
			AaDd( aMatIte, {"QTD" , nQtd } )
			AaDd( aMatIte, {"QTDAUT" , nQtd } )

		//garanto que o Reducao/acrescimo vai sempre ficar no formato X.XX
			nRedAcr := Val(Left(PadR(StrTran(u_CPEGCONR("REDUCAOACRESCIMO",cGuia+cTagMae,aMatM,nil,.T.,.F.,nil,cCodPeg),".",""),3,"0"),3)) / 100

			AaDd( aMatIte, {"HORINI" , SubStr(u_CPEGCONR("HORAINICIAL",cGuia+"\OUTRASDESPESAS\DESPESA\SERVICOSEXECUTADOS",aMatM,nil,.T.,nil,nil,cCodPeg),1,5) } )
			AaDd( aMatIte, {"HORFIM" , SubStr(u_CPEGCONR("HORAFINAL",cGuia+"\OUTRASDESPESAS\DESPESA\SERVICOSEXECUTADOS",aMatM,,.T.,nil,nil,cCodPeg),1,5) } )
			AaDd( aMatIte, {"DATPRO" , u_CBAJUDAT( u_CPEGCONR("DATAEXECUCAO",cGuia+"\OUTRASDESPESAS\DESPESA\SERVICOSEXECUTADOS",aMatM,,.T.,nil,nil,cCodPeg) ) } )

			aSlvTprec := aClone(aTpPRec)
			If Len(aTpPRec) == 0
				For nPos:=1 to Len (aMatBWT)
					AaDd( aTpPRec,{ aMatBWT[nPos,2],If(Empty(cConPrEx),cCodRP,cConPrEx),If(Empty(cNomRdEx),cNomRda,cNomRdEx),cCrmRda,cSlgRda,cEstRda,cNomPre,.T.,'','',u_CBRetUnp(aMatBWT[nPos,2]) } )
				Next
			Endif

			If Len(aTpPRec) == 0	//	TUUPVY
				AaDd( aTpPRec,{ GetNewPar("MV_PLSNAPL","O"),If(Empty(cConPrEx),cCodRP,cConPrEx),If(Empty(cNomRdEx),cNomRda,cNomRdEx),cCrmRda,cSlgRda,cEstRda,cNomPre,.T.,cRdaGuia,cEspExe,u_CBRetUnp( GetNewPar("MV_PLSNAPL","O")) } )
				AaDd( aDados, {"NINFEQ" , .T. } )
				lNInfPar := .T.
			Else
				AaDd( aDados, {"NINFEQ" , .F. } )
				lNInfPar := .F.
			EndIf

			If Len(aTpPRec) > 0
				AaDd( aMatIte, {"ATPPAR" , aTpPRec } )
			Endif
			aTpPRec := aClone(aSlvTprec)

		// Verifica se foi informado valor da despesa processada
			nPosVlrApr := aScan (aMatM,{ |x|x[1] == "CODIGOPROCEDIMENTO" .and. (alltrim(cSlvPro) == alltrim(x[2]) .or. alltrim(cCodProxml) == alltrim(x[2]) ) .And. "\OUTRASDESPESAS" $ x[3]})
			If nPosVlrApr <> 0
				nPosVlrApr ++
				While nPosVlrApr <= len(aMatM) .And. aMatM[nPosVlrApr][1] <> "CODIGO"

				// Se achar a tag de valor, alimenta o array com o que foi apresentado nela
					If aMatM [nPosVlrApr][1] == "VALORUNITARIO"
						nVlrApr := Val( strtran( u_CPEGCONR("VALORUNITARIO",cGuia+"\OUTRASDESPESAS\DESPESA\SERVICOSEXECUTADOS",aMatM,nil,.T.,.F.,nil,cCodPeg),',',"." ) )
						nVlrTotPrc := Val( strtran( u_CPEGCONR("VALORTOTAL",cGuia+"\OUTRASDESPESAS\DESPESA\SERVICOSEXECUTADOS",aMatM,nil,.T.,.F.,nil,cCodPeg),',',"." ) )
					//::::::::::::::: Somatoria do Valor Total da Guia ::::::::::::::: \\
		//				nValorTotG += (nQtd * nVlrApr)

						nvlrApr := nVlrTotPrc / nQtd //O valor apresentado unitᲩo 頯 total Dividido pela quantidade
						nValorTotG += nVlrTotPrc
						AaDd( aMatIte, {"VLRAPR" , nVlrApr } )
						lAchouVlr := .T.
						Exit
					EndIf
					nPosVlrApr ++
				EndDo
			EndIf

		// Se nao achou a tag de valorunitario alimenta o Array com o valor zerado
			If !lAchouVlr
				AaDd( aMatIte, {"VLRAPR" , 0 } )
			EndIf

		// Marca no Array aMatM a Despesa utilizada
			cCodPro := u_CPEGCONR("CODIGOPROCEDIMENTO",cGuia+"\OUTRASDESPESAS\DESPESA\SERVICOSEXECUTADOS",aMatM,nil,.T.,nil,nil,cCodPeg)
			cCodPro := padr(cCodPro,tamsx3("BR8_CODPSA")[1])

			AaDd( aMatIte, {"TPPROC" , cTpProc } )
			AaDd(aItens,aMatIte)
		EndDo

	// OPM Solicitadas	-- OPMESOLICITADAS\OPMESOLICITADA\IDENTIFICACAOOPME\CODIGOPROCEDIMENTO

		If cTipo == "3" .AND. cOrigem == "2"
			cTagMae 	:= "\ANEXOCLINICOPRORROGACAO"
			cTagFull	:= ""
		Else
			cTagMae 	:= "\ANEXOCLINICO"
			cTagFull	:= cTagMae + "\SOLICITACAOOPME\OPMESOLICITADAS\OPMESOLICITADA\IDENTIFICACAOOPME"
		EndIf
		While !Empty( ( cCodPro := u_CPEGCONR("CODIGOPROCEDIMENTO",cGuia+cTagFull,aMatM,,.T.,nil,nil,cCodPeg) ) )
			aMatIte := {}
			AaDd( aMatIte, {"SEQMOV" , cCont } )
			cCont := soma1(cCont)

			cCodPad := u_CPEGCONR("CODIGOTABELA",cGuia+cTagFull,aMatM,,.T.,.F.,nil,,cCodPeg)
			cSlvPad := cCodPad
			cDescric := u_CPEGCONR("DESCRICAOPROCEDIMENTO",cGuia+cTagFull,aMatM,,.T.,.F.,nil,cCodPeg)
			cSlvDes := cDescric
			cCodPro := padr(cCodPro,tamsx3("BR8_CODPSA")[1])
			cSlvPro := cCodPro

			cCodPad := PLSVARVINC('87', 'BR4', cCodPad) // Vinculo Terminologia de tipo de tabelas Tabela 87 TISS
			cCodPad := padr(cCodPad,tamsx3("BR8_CODPAD")[1])
			cCodPro := PLSVARVINC(cSlvPad, 'BR8', cCodPro,cSlvPad+cCodPro) // Vinculo Terminologia de procedimento Tabela 22 TISS

			u_CBXPAD(@cCodPad,@cCodPro,@cDescric,,cTipGui,cVersao)

			BR8->(DbSetOrder(1))
			If !BR8->( MsSeek(xFilial("BR8")+cCodPad+cCodPro) ) .and. cOrigem <> '2' //nao eh uma solicitacao
				If !PChkTabDup(@cCodPad,cCodPro,cSlvPad) // Caso nao encontre com uma tabela é porque é a outra (criado por casos de mais de uma tabela padrao vinculado a mesma terminologia ex.: 01 e 02 -->> 22
					cCodPad := GetNewPar("MV_PLCDPXM","01")
					cCodPro := GetNewPar("MV_PLPSPXM","99999994")
					cCodPro := padr(cCodPro,tamsx3("BR8_CODPSA")[1])
				Else
					cDescric := Alltrim(BR8->BR8_DESCRI)
				EndIf
			Elseif Empty(cDescric)
				cDescric := Alltrim(BR8->BR8_DESCRI)
			EndIf

			AaDd( aMatIte, {"CODPAD" , cCodPad } )
			AaDd( aMatIte, {"CODPRO" , cCodPro } )
			AaDd( aMatIte, {"DESPRO" , cDescric } )
			AaDd( aMatIte, {"SLVPAD" , cSlvPad } )
			AaDd( aMatIte, {"SLVPRO" , cSlvPro} )
			AaDd( aMatIte, {"SLVDES" , cSlvDes} )

		//Verifica se o procedimento e de tipo pacote e alimenta os itens para gravacao da B43
			If BR8->( MsSeek(xFilial("BR8")+cCodPad+cCodPro) ) .And. BR8->BR8_TPPROC == "6"
				AaDd( aMatIte, {"PACPRO" , PlRetPac(PLSIntPad(),cRdaOri,cCodPad,cCodPro,,dDatRea) } )
			EndIf

			nQtd := Val( u_CPEGCONR("QUANTIDADESOLICITADA",cGuia+cTagMae+"\SOLICITACAOOPME\OPMESOLICITADAS\OPMESOLICITADA",aMatM,,.T.,.F.,nil,cCodPeg) )
			AaDd( aMatIte, {"QTD" , nQtd } )
			AaDd( aMatIte, {"QTDAUT" , nQtd } )
			nVlrApr := Val( strtran( u_CPEGCONR("VALORSOLICITADO",cGuia+cTagMae+"\SOLICITACAOOPME\OPMESOLICITADAS\OPMESOLICITADA",aMatM,,.T.,.F.,nil,cCodPeg),',',"." ) )
			AaDd( aMatIte, {"VLRAPR" , nVlrApr } )
			AaDd(aItens,aMatIte)
		EndDo
	EndIf

	If Len(aEspCbXML) > 0
		aAdd(aDados,{"ESPXML", aClone(aEspCbXML) })
	//Zera as informacoes para o proximo Item
		u_cbFreArr(@aEspCbXML)
	EndIf

// Em alguns casos no XMOV estava indo a RDA em branco, ocasionava geração indevida de PEGs
	If Empty(PLSRETDAD( aDados,"CODRDA","" ))
		AaDd( aDados, {"CODRDA" , Iif(Empty(cCodRP),cRdaOri,cCodRP)  } )
	EndIf

	If BE4->( FieldPos("BE4_CNES") ) > 0 .AND. BD5->( FieldPos("BD5_CNES") ) > 0 // Tratamento para alguns clientes e essencial essa informação na Guia.
		AaDd( aDados, {"CNES" , u_CPEGCONR("CNES","\MENSAGEMTISS\PRESTADORPARAOPERADORA\LOTEGUIAS\GUIASTISS\GUIACONSULTA\CONTRATADOEXECUTANTE\",aMatM,nil,.T.,.F.,nil,cCodPeg) } )
	EndIf

	AaDd(aRetAux,cTpCab)								//1
	AaDd(aRetAux,cCCCab)								//2
	AaDd(aRetAux,PLSRETDAD( aDados,"CODRDA",cCodRP ))  //3
	AaDd(aRetAux,PLSRETDAD( aDados,"NOMRDA",cNomCont ))	//4
	AaDd(aRetAux,PLSRETDAD( aDados,"TPCRDA","" ))  		//5
	AaDd(aRetAux,PLSRETDAD( aDados,"CCRDA","" ))   		//6
	AaDd(aRetAux,cMatric)                           	//7
	AaDd(aRetAux,cNomeUsu)                          	//8
	AaDd(aRetAux,cNumeLot)                          	//9
	AaDd(aRetAux,cNumImp)                          		//10
	AaDd(aRetAux,lHonor)                            	//11
	AaDd(aRetAux,lResInt)                           	//12
	AaDd(aRetAux,cNumeSeq)                          	//13
	AaDd(aRetAux,u_CBAJUDAT(cData))                  	//14
	AaDd(aRetAux,cRdaOri)                           	//15
	AaDd(aRetAux,"")                           			//16 CNES
	AaDd(aRetAux, nValorTotG )                       	//17 Valor Total da Guia
	AaDd(aRetAux, cAtenRN )                       		//18 Atendimento RN

//Limpa o array com os caminhos das tags de CBOS
	aPathTag := {}

//Processa a guia
	If lOk .And. lProcLog
		cNumLib := PLSRETDAD( aDados,"NUMLIB","" )
		If !Empty( cNumLib ) .And. PLSRETDAD( aDados,"ORIGEM","" ) == '1'
			U_cbAJULIB(cNumLib,aItens)
		EndIf
		if !l974Xml
			If !lOnline .AND. !lBg
				If GetRpoRelease()=="R1.1"
					oSelf:incRegua1("RDA [" + AllTrim(cRdaOri) + "] Guia Prest. [" + cNumImp + "]")
				Else
					IncProc("Prestador [" + AllTrim(cRdaOri) + "] Guia Prest. [" + cNumImp + "]")
					ProcessMessage()
				Endif
			EndIf
		endIf
		aRet := PLSXAUTP(aDados,aItens)
		If Len(aRet) > 0 .AND. Len(aRet[10]) > 0
			If (nPos := aScan( aRet[10], {|x| Alltrim(x[1]) == "LOCAL DIGITACAO" .AND. Empty(x[2]) } )) > 0
				aRet[10,nPos,2] := PLSRETDAD( aDados,"CODLDP","" )
			EndIf
			If (nPos := aScan( aRet[10], {|x| Alltrim(x[1]) == "PROTOCOLO" .AND. Empty(x[2]) } )) > 0
				aRet[10,nPos,2] := cCodPeg
			EndIf
		EndIf

		BXX->(dbSetOrder(6))//BXX_FILIAL + BXX_CODINT +  BXX_CODPEG
		If BXX->(msSeek(xFilial("BXX")+cOpeMov+cCodPeg)) // ATUALIZO O VALOR DA BXX
			If BXX->BXX_VLRTOT == 0 .AND. nValorTotG > 0 // Atualizo o valor total
				BXX->(Reclock("BXX",.F.))
				BXX->BXX_VLRTOT := nValorTotG
				BXX->(MsUnlock())
			EndIf
		EndIf

	//se estou importando um XML vou alimentar a nova tabela BXV com a chave da guia que acabei de criar
		If PlsAliasExi('BXV') .and. l974Xml .and. nSeqGui > 0
			BXX->(dbSetOrder(6))//BXX_FILIAL + BXX_CODINT +  BXX_CODPEG
			If BXX->(msSeek(xFilial("BXX")+cOpeMov+cCodPeg))
				cSeqBXX   := Padr(BXX->BXX_SEQUEN,tamsx3('BXV_CHVALI')[1])
			Endif

			cChvGuia := strtran(strtran(strtran(aRet[2],'-',''),space(2),''),space(1),'')
			cSeqGuia := strzero(nSeqGui,3)
			If !Empty(cSeqBXX)
				BXV->(DbSetOrder(1))
				If BXV->(MsSeek(xFilial("BXV")+"BXX"+cSeqBXX+cSeqGuia))
					While !BXV->(Eof()) .and. BXV->(BXV_FILIAL+BXV_ALIAS+BXV_CHVALI+BXV_SEQGUI) == xFilial("BXV")+"BXX"+cSeqBXX+cSeqGuia

						BXV->(Reclock("BXV",.F.))
						BXV->BXV_CHVGUI := cChvGuia
						BXV->(MsUnlock())

						BXV->(DbSkip())
					Enddo
				Endif
			Endif
		Endif
	EndIf

Return( { aRetAux,aRet } )

/*/{Protheus.doc} VerMembro
Valida membro de equipe. O objetivo dessa funcao eh verificar se o membro de equipe em questao eh daquele procedimento ou nao.
@type function
@author TOTVS
@since 04/11/14
@version 1.0
/*/
static Function VerMembro(nIndMat,nIndPro,aMatM,cTipGui)
	LOCAL nI 	 := 0
	LOCAL nMenor := 0
	LOCAL nMaior := 0
	LOCAL lRet	 := .T.

	If nIndMat > nIndPro
		nMenor := nIndPro
		nMaior := nIndMat
	Else
		nMenor := nIndMat
		nMaior := nIndPro
	Endif
//percorro do menor para o maior, se todos eles tiverem dentro da TAG PROCEDIMENTOEXECUTADO significa que o membro de equipe
//faz parte daquele procedimnto
	For nI:=nMenor to nMaior                               //se eu passei pela tag codigo procedimento ja to em outro procedimento
		If cTipGui <> '06'
			If !("PROCEDIMENTOEXECUTADO" $ aMatM[nI][3]) .OR. ("CODIGOPROCEDIMENTO" $ alltrim(aMatM[nI][1]) .AND. nI <>nIndPro)
				lRet := .F.
				exit
			Endif
		else
			If !("PROCEDIMENTOREALIZADO" $ aMatM[nI][3] .AND. "PROCEDIMENTOSREALIZADOS" $ aMatM[nI][3]) .OR. ("CODIGOPROCEDIMENTO" $ alltrim(aMatM[nI][1]) .AND. nI <>nIndPro)
				lRet := .F.
				exit
			Endif
		Endif
	Next

return  lRet

/*/{Protheus.doc} CBIsSen
Valida liberacao
@type function
@author TOTVS
@since 04/11/14
@version 1.0
/*/
User Function CBIsSen(cTipo)
	Local 	lRet	:= .T.
	Local cMatXML	:= ""
	Local x	:= 0
	Local y	:= 0
	Local lGuiaSen := .F.
	
	DEFAULT cTipo 	:= '2'

	x := Len(aMapGuia)
	While x > 0 //Tem que olhar de tr᳠pra frente
		If nZaDados >= aMapGuia[x][1]
			lGuiaSen := aMapGuia[x][2]
			Exit
		EndIf
		x--
	EndDo
	
	If !lGuiaSen //Se n㯠tem senha na guia, da�erminou aqui, jᠲetorna
		lRet := .T.
		lFoundAut := .F.
		nRecnoAut := 0
		Return lRet
	EndIf
	
	//Pegamos esse do aDados pq ainda n㯠recarregamos a tag da carteirinha no aDadosUnic
	//Devido ࠯rdem das tags no XML
	for y := aMapGuia[x][1] To IIF( x >= Len(aMapGuia), Len(aDados), aMapGuia[x+1][1])
		If aDados[y][1] == "NUMEROCARTEIRA"
			cMatXML := aDados[y][3]
			Exit
		EndIf
	Next
	
	//Pegamos esse do aDadosUnic pq estamos validando a tag SENHA, ent㯠ele jᠲecarregou pro conte?do
	//certo no aDadosUnic
	CNUMSEN:= aDadosUnic[(aScan( aDadosUnic, {|x| x[1]=="SENHA"})),3] // RECARREGANDO A SENHA CNUMSEN

	If cTipo == '2'
		BEA->(DBSETORDER(1))
		If !BEA->( MSSEEK(XFILIAL('BEA')+PADR(ALLTRIM(CNUMSEN),18)))
			BEA->(DBSETORDER(14))
			If !BEA->( MSSEEK(XFILIAL('BEA')+PADR(ALLTRIM(CNUMSEN),9)))

				If BEA->(FieldPos("BEA_GUIPRE"))> 0
					cAliasTrb	:= GetNextAlias()
					BeginSql Alias cAliasTrb
						SELECT BEA.R_E_C_N_O_ FROM %table:BEA% BEA
						WHERE BEA_FILIAL = %exp:xFilial("BEA")%
						AND BEA_GUIPRE 	= %exp:cNumImp%
						AND BEA.%NotDel%
					Endsql

					If (cAliasTrb)->(Eof())
						lRet:=.F.
						lFoundAut := .f.
						nRecnoAut := 0
					Else
						BEA->(DbGoto((cAliasTrb)->R_E_C_N_O_))
						If cMatXML == AllTrim(BEA->(BEA_OPEUSR + BEA_CODEMP + BEA_MATRIC + BEA_TIPREG + BEA_DIGITO)) .OR. cMatXML == AllTrim(BEA->(BEA_MATANT))
							lFoundAut := .t.
							nRecnoAut := BEA->(Recno())
						else
							lRet:=.F.
							lFoundAut := .f.
							nRecnoAut := 0
						EndIf
						
					Endif
					(cAliasTrb)->(DbCloseArea())
				Else
					lRet:=.F.
					lFoundAut := .f.
					nRecnoAut := 0
				Endif

			Else
				If cMatXML == AllTrim(BEA->(BEA_OPEUSR + BEA_CODEMP + BEA_MATRIC + BEA_TIPREG + BEA_DIGITO)) .OR. cMatXML == AllTrim(BEA->(BEA_MATANT))
					lFoundAut := .t.
					nRecnoAut := BEA->(Recno())
				else
					lRet:=.F.
					lFoundAut := .f.
					nRecnoAut := 0
				EndIf
			Endif
		Else
			If cMatXML == AllTrim(BEA->(BEA_OPEUSR + BEA_CODEMP + BEA_MATRIC + BEA_TIPREG + BEA_DIGITO)) .OR. cMatXML == AllTrim(BEA->(BEA_MATANT))
				lFoundAut := .t.
				nRecnoAut := BEA->(Recno())
			else
				lRet:=.F.
				lFoundAut := .f.
				nRecnoAut := 0
			EndIf
		Endif
	Else
		BE4->(DbSetOrder(2))
		If !BE4->( MSSEEK( XFILIAL('BE4')+PADR(CNUMSEN,18)))
			BE4->(DbSetOrder(7))
			If !BE4->( MSSEEK( XFILIAL('BE4')+PADR(CNUMSEN,9)))
				lRet:=.F.
				lFoundAut := .f.
				nRecnoAut := 0
			Else
				if cMatXML == AllTrim(BE4->(BE4_OPEUSR + BE4_CODEMP + BE4_MATRIC + BE4_TIPREG + BE4_DIGITO)) .OR. cMatXML == AllTrim(BE4->BE4_MATANT)
					lFoundAut := .t.
					nRecnoAut := BE4->(Recno())
				else
					lRet:=.F.
					lFoundAut := .f.
					nRecnoAut := 0
				EndIf
			Endif
		Else
			if cMatXML == AllTrim(BE4->(BE4_OPEUSR + BE4_CODEMP + BE4_MATRIC + BE4_TIPREG + BE4_DIGITO)) .OR. cMatXML == AllTrim(BE4->BE4_MATANT)
				lFoundAut := .t.
				nRecnoAut := BE4->(Recno())
			else
				lRet:=.F.
				lFoundAut := .f.
				nRecnoAut := 0
			EndIf
		Endif
	Endif

return lRet

/*/{Protheus.doc} u_CBGRELWS
Demonstrativos de Contas / Procedimentos / Odontológicos
@type function
@author TOTVS
@since 31/08/2016
@version 1.0
/*/
User Function CBGRELWS(ADADOS)
	LOCAL nIdx, nI	   	:= 0
	LOCAL cCodRda 	:= ""
	LOCAL cCodRP	:= ""
	LOCAL cRegAns	:= ""
	LOCAL aRet		:= {}
	LOCAL aMatGui	:= {}
	LOCAL aValores	:= {}
	LOCAL nCountTag := PLCOUNTTAG({"\NUMEROPROTOCOLO"}, aDados)
	LOCAL cTpTrans	:= u_CVLRTAGXML(aDados, "TIPOTRANSACAO")
	LOCAL cStTiss 	:= ""
	Local cTipoDoc	:= ""
	Local cEscRel	:= ""
	Local aRetDad	:= {}

// RDA Contratada
	cCodRP := AllTrim( u_CVLRTAGXML(aDados, "\DADOSPRESTADOR\CPFCONTRATADO,\DADOSPRESTADOR\CNPJCONTRATADO"))
	cCodRP := cCodRP+Space( TamSX3("BAU_CPFCGC")[1]-Len(cCodRP) )
	nIdx 	:= 4
	If Empty(cCodRP)
		cCodRP := u_CVLRTAGXML(aDados, "\DADOSPRESTADOR\CODIGOPRESTADORNAOPERADORA")
		nIdx 	:= 1
	EndIf

	BAU->( DbSetOrder( nIdx ) ) //BAU_FILIAL + BAU_CPFCGC ou  BAU_CODIGO ou BAU_CODBB0
	If BAU->( MsSeek( xFilial("BAU")+cCodRP ) )
		cCodRda := BAU->BAU_CODIGO
	EndIf


// Codigo da Operadora
	cRegAns  := u_CVLRTAGXML(aDados, "\CABECALHO\DESTINO\REGISTROANS,\CABECALHO\ORIGEM\REGISTROANS")
	If !Empty(cRegAns)
		BA0->( DbSetOrder(5) ) //BA0_FILIAL+BA0_SUSEP
		If BA0->( MsSeek( xFilial("BA0")+cRegAns ) )
			cOpeMov := BA0->(BA0_CODIDE+BA0_CODINT)
		Else
			u_CABLOGX("Operadora n�o encontrada  -> ( "+cRegAns+" ) informa��o no  \CABECALHO\DESTINO ",.F.,,,"5006") //"Operadora não encontrada  -> ( "###" ) informação no  \CABECALHO\DESTINO "
		EndIf
	EndIf

	For nI := 1 To Len(aDados)
		IF ( ("DEMONSTRATIVOANALISE" $ aDados[ni][2]) )
			cTipoDoc := "DEMONSTRATIVOANALISE"
			cTipoRD  := "DEMONSTRATIVO_ANALISE_CONTA=demonstrativosRetorno_demonstrativoAnaliseConta"
			Exit
		ELSEIF ( ("DEMONSTRATIVOPAGAMENTO" $ aDados[ni][2]) )
			cTipoDoc := "DEMONSTRATIVOPAGAMENTO"
			cTipoRD  := "DEMONSTRATIVO_PAGAMENTO=demonstrativosRetorno_demonstrativoPagamento"
			Exit
		ENDIF
	NEXT

	IF (cTipoDoc == "DEMONSTRATIVOPAGAMENTO")
		cDtaComp	:= u_CVLRTAGXML(aDados, "\DEMONSTRATIVOPAGAMENTO\PERIODO\COMPETENCIA") //
		cDtaPag		:= u_CVLRTAGXML(aDados, "\DEMONSTRATIVOPAGAMENTO\PERIODO\DATAPAGAMENTO") //
		cDataSol	:= u_CVLRTAGXML(aDados, "\DEMONSTRATIVOPAGAMENTO\DATASOLICITACAO") //
		cTipoRel	:= u_CVLRTAGXML(aDados, "\DEMONSTRATIVOPAGAMENTO\TIPODEMONSTRATIVO") //
	Else
	//Prestador pode enviar até 30 solicitações de protocolos para obter retorno
	//Logo, verifico se a tag é NUmeroProtocolo e pego os valores
		For nI := 1 To Len(aDados)
			IF ("NUMEROPROTOCOLO" $ aDados[ni,1])
			//Verifico se o mesmo número de protocolo já não existe no array
				IIF (aScan(aMatGui, aDados[ni,3]) = 0, aAdd(aMatGui, aDados[nI,3]), "")
			ENDIF
		Next
		cDataSol	:= u_CVLRTAGXML(aDados, "\DEMONSTRATIVOANALISE\DATASOLICITACAO") //
	EndIf


// Pegar os dados para os relatórios
	If lOkXml //Se XML ok para processamento

		If (cTipoDoc == "DEMONSTRATIVOANALISE")
			For nI := 1 TO len(aMatGui)
				IF (Len(aMatGui) <= 30)
					aRet := PLSDACMB(PlsIntPad(), cCodRDA, cCodRDA, nil, nil,nil,nil,nil,nil,nil,aMatGui[nI], aMatGui[nI])
					IIF (Len(aRet) > 0, aAdd( aRetDad, aRet), "")
				Else
					Exit
				ENDIF
			Next
		ElseIf (cTipoDoc == "DEMONSTRATIVOPAGAMENTO" .AND. cTipoRel == "1" ) //Demonstrativo sem odonto
			If Empty(cDtaPag)
				aRetDad := PLSDPGTB(PlsIntPad(), cCodRDA, cCodRDA, SubStr(cDtaComp,1,4), SubStr(cDtaComp,5,2), nil, nil, nil, nil, nil, nil)
			Else
				cDtaPag := StrTran(cDtaPag,"-","")
				aRetDad := PLSDPGTB(PlsIntPad(), cCodRDA, cCodRDA, SubStr(cDtaComp,1,4), SubStr(cDtaComp,5,2), nil, nil, nil, nil, nil, nil, cDtaPag)
			EndIf
		Else//Demonstrativo odonto
			cTipoRD  := "DEMONSTRATIVO_ODONTOLOGIA=demonstrativosRetorno_demonstrativoPagamentoOdonto"
			If Empty(cDtaPag)
				aAdd(aRetDad, PLSDPGTODB(PlsIntPad(), cCodRDA, cCodRDA, SubStr(cDtaComp,1,4), SubStr(cDtaComp,5,2), nil, nil, nil, nil, nil, nil))
			Else
				cDtaPag := StrTran(cDtaPag,"-","")
				aAdd(aRetDad, PLSDPGTODB(PlsIntPad(), cCodRDA, cCodRDA, SubStr(cDtaComp,1,4), SubStr(cDtaComp,5,2), nil, nil, nil, nil, nil, nil, cDtaPag))
			EndIf
		EndIf

	EndIf

Return( aRetDad )

/*/{Protheus.doc} u_CBSTATRG
Situacao do Recurso de Glosa
@type function
@author TOTVS
@since 05.02.16
@version 1.0
/*/
User Function CBSTATRG(aDados)
	LOCAL nIdx	   		:= 0
	LOCAL cCodRda 	:= ""
	LOCAL cCodRP		:= ""
	LOCAL cRegAns		:= ""
	LOCAL aRet			:= {}
	LOCAL aStatus		:= {}
	LOCAL nI 			:= 1
	LOCAL nCountTag 	:= PLCOUNTTAG({"\NUMEROPROTOCOLO"}, aDados)
	LOCAL cTpTrans	:= u_CVLRTAGXML(aDados, "TIPOTRANSACAO")
	LOCAL cStTiss 	:= ""
	LOCAL aAux       	:= {}
	LOCAL cRet  := "1" //status guia completa
	LOCAL aItens := {}
	LOCAL cNomInt := ""
	cCodRP := AllTrim( u_CVLRTAGXML(aDados, "\DADOSPRESTADOR\CPFCONTRATADO,\DADOSPRESTADOR\CNPJCONTRATADO"))
	cCodRP := cCodRP+Space( TamSX3("BAU_CPFCGC")[1]-Len(cCodRP) )
	nIdx 	:= 4

	If Empty(cCodRP)
		cCodRP := u_CVLRTAGXML(aDados, "\DADOSPRESTADOR\CODIGOPRESTADORNAOPERADORA")
		nIdx 	:= 1
	EndIf

	BAU->( DbSetOrder( nIdx ) ) //BAU_FILIAL + BAU_CPFCGC ou  BAU_CODIGO ou BAU_CODBB0
	If BAU->( MsSeek( xFilial("BAU")+cCodRP ) )
		cCodRda := BAU->BAU_CODIGO
	EndIf

	cRegAns  := u_CVLRTAGXML(aDados, "\CABECALHO\DESTINO\REGISTROANS")

	If !Empty(cRegAns)
		BA0->( DbSetOrder(5) ) //BA0_FILIAL+BA0_SUSEP
		If BA0->( MsSeek( xFilial("BA0")+cRegAns ) )
			cOpeMov := BA0->(BA0_CODIDE+BA0_CODINT)
			cNomInt := BA0->BA0_NOMINT
		Else
			u_CABLOGX("Operadora n�o encontrada  -> ( "+cRegAns+" ) informa��o no  \CABECALHO\DESTINO ",.F.,,,"5006") //"Operadora não encontrada  -> ( "###" ) informação no  \CABECALHO\DESTINO "
		EndIf
	EndIf

	If lOkXml
		SIX->(DbSetOrder(1))
		If SIX->(MsSeek("BVO4"))
			For nI := 1 To nCountTag //Looping de protocolos solicitados

				cNumPro := u_CVLRTAGXML(aDados, "\NUMEROPROTOCOLO", nI)
				cNumPro := cNumPro + Space( (TamSX3("BVO_CODPEG")[1] + TamSX3("BVO_ENVXML")[1]) - Len(cNumPro) ) //Adiciona espaços em branco

				BVO->(DbSetOrder(4)) //BVO_FILIAL + BVO_CODPEG + BVO_ENVXML
				If BVO->(MsSeek(xFilial("BVO")+cNumPro))
					If (BVO->BVO_CODRDA == cCodRda) //Validação do código da RDA do prestador na consulta do status

					//Adiciona dados da RDA no array
					//uso alguns dados da BVO aqui pois serão comuns a todas as BVO's do BVO_ENVXML
		/*1*/  aAdd(aStatus, cRet) //guia completa ou nao <reciboGlosa> ou <reciboGlosaStatus>
		/*2*/  aAdd(aStatus, BVO->(BVO_CODPEG+BVO_ENVXML)) //Numero do protocolo - <nrProtocoloRecursoGlosa>, usado também no <nrProtocoloSituacaoRecursoGlosa>
		/*3*/  aAdd(aStatus, BVO->BVO_DATREC)	//Data do envio e recebimento da glosa, mesma data - <dataEnvioRecurso> e <dataRecebimentoRecurso>
		/*4*/  aAdd(aStatus, BVO->BVO_LOTEPR)	//Numero do lote (enviado pelo prestador) - <numeroLote>
		/*5*/  aAdd(aStatus, cRegAns)		//Registro ANS - <registroANS>
		/*6*/  aAdd(aStatus, BAU->BAU_TIPPE) //Tipo pessoa prestador
		/*7*/  aAdd(aStatus, BAU->BAU_CPFCGC) //cpf cnpj prestador
		/*8*/  aAdd(aStatus, BAU->BAU_NOME) //nome do prestador
		/*9*/  aAdd(aStatus, cCodRda)  //cod rda
		/*10*/ aAdd(aStatus, BVO->BVO_GUIGRP)  //cod rda
		/*11*/ aAdd(aStatus, cNomInt) //nome Operadora


					While !BVO->(EOF()) .And. (AllTrim(BVO->(BVO_CODPEG+BVO_ENVXML)) == AllTrim(cNumPro)) .And. (BVO->BVO_CODRDA == cCodRda)
						aAux := PLSTTIPREC(BVO->BVO_SEQB4D, BVO->BVO_SEQUEN)
						if(aAux[1] $ "1,2")
							aAdd(aStatus, aAux[1])
							aStatus[1] := "2" //guia não completa
							exit
						else
							cRet := "1" //status guia completa
							aAdd(aItens, aAux)
						endIf

						BVO->(DbSkip())
					EndDo

					if(aStatus[1] == "1")
					 aAdd(aStatus, aItens)
					endIf
					//Só guarda o último status lido
					aAdd(aRet, aStatus)
				Else
					u_CABLOGX("Protocolo não encontrado para o prestador informado",.F.,,,"1203")
				EndIf
			Else
				u_CABLOGX("Protocolo não encontrado -> ( "+cNumPro+" ) ",.F.,,,"1307")
			EndIf
		Next
	Else
		// NÃO PODE RETORNAR PARA O PRESTADOR QUE NÃO O INDICE
		// É INFORMAÇÃO PERTINENTE PARA OPERADORA E DEVE SER VERIFICADO DENTRO DO PLS PLSLOGFIL
		PLSLOGFIL( "TransacoesOnline: Não existe o indice 4 na tabela BVO " + Time(),DIRLOG+"ONLINELOG.TXT" )
		u_CABLOGX("N�o foi poss�vel validar o arquivo XML. Contate sua Operadora",.F.,,,"5002")
	EndIf
EndIf

Return( aRet )

/*/{Protheus.doc} PLSTTIPREC
Retorna um array com o informações do recurso de glosa
@type function
@author Karine Riquena Limp
@since 26.02.16
@version 1.0
/*/
					static function PLSTTIPREC(cSeqB4D, cSequenB4E)
						local aRet := {}
						local cTipRec := ""
						local cStatus := ""
						local cCodGlo := ""
						local cJust := ""
						local lAcatado := .F.
						local nVlrRec  := 0
						local nVlrAca := 0
						local dDtIni := stod("")
						local dDtFim := stod("")
						local cCodOpe := PLSINTPAD()
						local cNumGuiOpe := ""
						local cNumGuiPre := ""
						local cSenha1 := ""
						local cCodPad := ""
						local cCodPro := ""
						local cDesPro := ""
						local cJusOpe := ""
						local cPadBkp := ""
						local aTabDup := PlsBusTerDup(SuperGetMv("MV_TISSCAB", .F. ,"87"))
						default cSequenB4E := ""

						B4D->(dbSetOrder(6))
						BCT->(DbSetOrder(1))//BCT_FILIAL+BCT_CODOPE+BCT_PROPRI+BCT_CODGLO
						if B4D->(MsSeek(xFilial("B4D")+cSeqB4D))
							if B4D->B4D_OBJREC == "1"
								if B4D->B4D_STATUS $ "1,2"
									aadd(aRet, B4D->B4D_STATUS)
								else
									cTipRec := "P"
									If BCT->(MsSeek(xFilial("BCT")+cCodOpe+B4D->B4D_GLOPLS))
										cCodGlo := PLSGETVINC("BTU_CDTERM", "BCT", .F.,"38")
										cCodGlo := iif(!empty(cCodGlo),cCodGlo, BCT->BCT_GLTISS)
									EndIf
									cStatus := PLSSTTAB47(cSeqB4D,"B4D")
									cJust    := iif( empty(cJust) , alltrim(BVO->BVO_JUSRDA), cJust)
									cJustOpe := BVO->BVO_JUSOPE
									nVlrRec  := BVO->BVO_VLRREC
									nVlrAca  := BVO->BVO_VLRACA
									lAcatado := cStatus $ "3,5"
									aadd(aRet, cTipRec)
									aadd(aRet, cStatus)
									aadd(aRet, cCodGlo)
									aadd(aRet, cJust)
									aadd(aRet, nVlrRec)
									aadd(aRet, nVlrAca)
									aadd(aRet, iif(lAcatado, "S", "N"))
									aadd(aRet, cJustOpe)
								endIf
							else
								B4E->(dbSetOrder(2))

								cNumGuiOpe := B4D->B4D_GUIREF
								if B4D->B4D_TIPGUI != "03"
									BD5->(dbSetOrder(1)) //BD5_FILIAL+BD5_CODOPE+BD5_CODLDP+BD5_CODPEG+BD5_NUMERO+BD5_SITUAC+BD5_FASE+DTOS(BD5_DATPRO)+BD5_OPERDA+BD5_CODRDA
									if BD5->(msSeek(xFilial("BD5")+cCodOpe+B4D->(B4D_CODLDP+B4D_CODPEG+B4D_NUMAUT)))
										cNumGuiPre	:= iif(empty(alltrim(BD5->BD5_NUMIMP)), cNumGuiOpe, BD5->BD5_NUMIMP)
									endif
								else
									BE4->(dbSetOrder(1)) //BE4_FILIAL+BE4_CODOPE+BE4_CODLDP+BE4_CODPEG+BE4_NUMERO+BE4_SITUAC+BE4_FASE
									if BE4->(msSeek(xFilial("BE4")+cCodOpe+B4D->(B4D_CODLDP+B4D_CODPEG+B4D_NUMAUT)))
										cNumGuiPre	:= iif(empty(alltrim(BE4->BE4_NUMIMP)), cNumGuiOpe, BE4->BE4_NUMIMP)
										cSenha1 := BE4->BE4_SENHA
									endif
								endif

								if !B4E->(MsSeek(xFilial("B4E")+cSeqB4D+cSequenB4E))
									if B4D->B4D_STATUS $ "1,2"
										aadd(aRet, B4D->B4D_STATUS)
									else
										cTipRec := "G"
										If BCT->(MsSeek(xFilial("BCT")+cCodOpe+B4D->B4D_GLOPLS))
											cCodGlo := PLSGETVINC("BTU_CDTERM", "BCT", .F.,"38")
											cCodGlo := iif(!empty(cCodGlo),cCodGlo, BCT->BCT_GLTISS)
										EndIf
										cStatus := PLSSTTAB47(cSeqB4D,"B4D")
										cJust    := alltrim(BVO->BVO_JUSRDA)
										cJustOpe := alltrim(BVO->BVO_JUSOPE)
										lAcatado := cStatus $ "3,5"
										nVlrRec  := BVO->BVO_VLRREC
										nVlrAca  := BVO->BVO_VLRACA
										aadd(aRet, cTipRec)
										aadd(aRet, cStatus)
										aadd(aRet, cNumGuiPre)
										aadd(aRet, cNumGuiOpe)
										aadd(aRet, cSenha1)
										aadd(aRet, cCodGlo)
										aadd(aRet, cJust)
										aadd(aRet, nVlrRec)
										aadd(aRet, nVlrAca)
										aadd(aRet, iif(lAcatado, "S", "N"))
										aadd(aRet, cJustOpe)
									endIf
								else
									if B4E->B4E_STATUS $ "1,2"
										aadd(aRet, B4D->B4D_STATUS)
									else
										cTipRec := "I"

										BD6->(dbSetOrder(1)) //BD6_FILIAL+BD6_CODOPE+BD6_CODLDP+BD6_CODPEG+BD6_NUMERO+BD6_ORIMOV+BD6_SEQUEN+BD6_CODPAD+BD6_CODPRO
										if(BD6->(msSeek(xFilial("BD6")+cCodOpe+B4D->(B4D_CODLDP+B4D_CODPEG+B4D_NUMAUT+B4D_ORIMOV)+B4E->(B4E_SEQUEN+B4E_CODPAD+B4E_CODPRO))))
											dDtIni := BD6->BD6_DATPRO
											if B4D->B4D_TIPGUI == "03"
												dDtFim := BD6->BD6_DTALTA
											endIf
										endIf

										cPadBkp 	:= PLSGETVINC("BTU_CDTERM", "BR4", .F., "87",  BD6->BD6_CODPAD,.F.)

										CCodPro 	:= PLSGETVINC("BTU_CDTERM", "BR8", .F., CCodPad,  Alltrim(BD6->BD6_CODPAD+BD6->BD6_CODPRO), .F. ,aTabDup, @cPadBkp)
										CCodPad := cPadBkp
										CDesPro 	:= PLSGETVINC("BTQ_DESTER", "BR8", .F., CCodPad,  Alltrim(BD6->BD6_CODPAD+BD6->BD6_CODPRO))

										If BCT->(MsSeek(xFilial("BCT")+cCodOpe+B4E->B4E_CODGLO))
											cCodGlo := PLSGETVINC("BTU_CDTERM", "BCT", .F.,"38")
											cCodGlo := iif(!empty(cCodGlo),cCodGlo, BCT->BCT_GLTISS)
										EndIf
										cStatus := PLSSTTAB47(cSeqB4D+cSequenB4E,"B4E")
										nVlrRec  := BVO->BVO_VLRREC
										cJust    := alltrim(BVO->BVO_JUSRDA)
										nVlrAca  := BVO->BVO_VLRACA
										cJusOpe  := allTrim(BVO->BVO_JUSOPE)
										aadd(aRet, cTipRec)
										aadd(aRet, cStatus)
										aadd(aRet, cNumGuiPre)
										aadd(aRet, cNumGuiOpe)
										aadd(aRet, dDtIni)
										aadd(aRet, dDtFim)
										aadd(aRet, cSenha1)
										aadd(aRet, cCodPad)
										aadd(aRet, cCodPro)
										aadd(aRet, cDespro)
										aadd(aRet, cCodGlo)
										aadd(aRet, nVlrRec)
										aadd(aRet, cJust)
										aadd(aRet, nVlrAca)
										aadd(aRet, cJusOpe)
									endIf
								endif
							endif
						endif

						return aRet

/*/{Protheus.doc} PLSSTTAB47
DE/PARA do status do PLS com a tabela de dominio nº 47 da ANS
@type function
@author Rodrigo Morgon
@since 11.02.16
@version 1.0
/*/
					Static Function PLSSTTAB47(cChave,cTabela)
/*------------------------------------------------------------
	TABELA DE DOMINNIO N 47 DA ANS DETERMINA QUE:
	CD.	STATUS
	1		Recebido
	2		Em analise
	3		Liberado para pagamento
	4		Encerrado sem pagamento
	5		Analisado e aguardando liberado para o pagamento
	6		Pagamento efetuado
	7		Nao localizado
	8		Aguardando informacao complementar

	Para a tabela B4D, campo B4D_STATUS:

	B4D_STATUS						-> RETORNO
	0	Sem rec de glosa			-> 7	Nao localizado
	1	Rec Glosa Protocolado	-> 1	Recebido
	2	Rec Glosa Em Analise		-> 2	Em Analise
	3	Rec Glosa Autorizado		-> 3	Liberado para pagamento
	4	Rec Glosa Negado			-> 4	Encerrado sem pagamento
	5	Aut Parcial       		-> 3	Liberado para pagamento

	B4E_STATUS						-> RETORNO
	0	Sem rec de glosa			-> 7	Nao localizado
	1	Rec Glosa Protocolado	-> 1	Recebido
	2	Rec Glosa Em Analise		-> 2	Em Analise
	3	Rec Glosa Autorizado		-> 3	Liberado para pagamento
	4	Rec Glosa Negado			-> 4	Encerrado sem pagamento
	5	Aut Parcial       		-> 3	Liberado para pagamento
--------------------------------------------------------------*/

						Local cRet := ""

						If cTabela == "B4D"
							DbSelectArea("B4D")
							B4D->(dbSetOrder(6))
							If B4D->(MsSeek(xFilial("B4D")+cChave))
								if B4D->B4D_STATUS $ "1,2,3,4"
									cRet := B4D->B4D_STATUS
								elseif B4D->B4D_STATUS == "5"
									cRet := "3"
								elseif B4D->B4D_STATUS == "0"
									cRet := "7"
								endif
							Else
								cRet := "7" //Não localizado
							EndIf
						ElseIf cTabela == "B4E"
							B4E->(dbSetOrder(2))
							if B4E->(msSeek(xFilial("B4E")+cChave))
								if B4E->B4E_STATUS $ "1,2,3,4"
									cRet := B4E->B4E_STATUS
								elseif B4E->B4E_STATUS == "5"
									cRet := "3"
								elseif B4E->B4E_STATUS == "0"
									cRet := "7"
								endif
							else
								cRet := "7" //Não localizado
							endIf
						EndIf
						Return cRet

/*/{Protheus.doc} u_CBTrCBOIMP
Retorna os dados de CBOs e Especialidade do arquivo XML conforme tipo de dado solicitado
(Executante ou Solicitante) e origem da transação (Solicitação/Execução).

@type Function
@author victor.silva
@since 31/03/2016
@version 1.0
@return cRet, Retorno com o dado solicitado conforme parametro cTpDad
/*/
		User Function CBTrCBOIMP(cTpDad,cGuia,aMatM,cOrigem,cTipGui,lChkTag)
			Local cCamTag		:= ""
			Local cTipPro		:= ""
			Local cCboX		:= ""
			Local cEspX		:= ""
			Default lChkTag	:= .T.

//Conforme passagem de parametros, retorna o caminho da TAG
			u_cbRtCBOPath(cOrigem,cTpDad,cTipGui,@cCamTag,cGuia)

			cCboX := u_CPEGCONR(Iif(cTipGui == "06","CBO","CBOS"), cCamTag, aMatM,nil,lChkTag,.F.,nil)
			cEspX := AllTrim(PLSVARVINC('24','BAQ',cCboX))

//Ponto de Entrada para realizar o vinculo 1_CBOS->N_ESP
			If ExistBlock("PLTISESP")
				cTipPro:= Iif(cTpDad == "1","S","E")
				aRetPe := ExecBlock("PLTISESP",.F.,.F.,{"2",cTipPro,cNome,cCboX,cEspX,""})
				If ValType(aRetPe) == "A" .And. Len(aRetPe) >= 2
					cEspX := aRetPe[1]
					cCboX := aRetPe[2]
				Endif
			EndIf

			Return {cEspX,cCboX}

/*/{Protheus.doc} u_cbRtCBOPath
Utilizada pela funcao u_CBTrCBOIMP para retornar o caminho da TAG solicitada.

@type Function
@author victor.silva
@since 31/03/2016
@version 1.0
/*/
					User Function cbRtCBOPath(cOrigem,cTpDad,cTipGui,cCamTag,cGuia)

/*
Estrutura do aPathTag
	[1] - Origem da transação (1-Execucao/2-Solicitacao)
	[2] - Tipo de dado solicitado (1-Solicitante/2-Executante)
	[3] - Tipo de Guia (01-CONSULTA/02-SADT/03-GIH/05-GRI/06-GHI)
	[4] - Caminho da TAG
*/

						If Len(aPathTag) == 0
	//-- EXECUCAO --
	//Solicitante
							aAdd(aPathTag,{"1","1","02",cGuia + "\DADOSSOLICITANTE\PROFISSIONALSOLICITANTE\"})
	//Executante
							aAdd(aPathTag,{"1","2","01",cGuia + "\PROFISSIONALEXECUTANTE"})
							aAdd(aPathTag,{"1","2","02",cGuia + "\PROCEDIMENTOSEXECUTADOS\PROCEDIMENTOEXECUTADO\EQUIPESADT"})
							aAdd(aPathTag,{"1","2","05",cGuia + "\PROCEDIMENTOSEXECUTADOS\PROCEDIMENTOEXECUTADO\IDENTEQUIPE\IDENTIFICACAOEQUIPE"})
							aAdd(aPathTag,{"1","2","06",cGuia + "\PROCEDIMENTOSREALIZADOS\PROCEDIMENTOREALIZADO\PROFISSIONAIS"})

	//-- SOLICITACAO --
	//Solicitante
							aAdd(aPathTag,{"2","1","02",cGuia + "\DADOSSOLICITANTE\PROFISSIONALSOLICITANTE"})
							aAdd(aPathTag,{"2","1","03",cGuia + "\IDENTIFICACAOSOLICITANTE\DADOSPROFISSIONALCONTRATADO\"})
						EndIf

//Busca a posicao do dado solicitado
						nPos := aScan(aPathTag,{|x|(x[1]+x[2]+x[3]) == cOrigem + cTpDad + cTipGui})

						If nPos > 0
							cCamTag := aPathTag[nPos][4]
						EndIf

						Return

/*/{Protheus.doc} u_cbRtEspPre
Retorna a especialidade do prestador.
Se a especialidade do executante esta contida nas especialidades do prestador, retorna a mesma.
Se a especialidade do executante nao for informada na guia porem for guia de SADT,
considera especialidade do solicitante.
Se nenhuma das condicoes forem atendidas, retorna a especialidade principal do Prestador.

@type Function
@author victor.silva
@since 06/04/2016
@version 1.0
@return cRet, Codigo da especialidade do prestador
/*/
					User Function cbRtEspPre(cCodOpe,cCodRda,cEspPro,dDatRea,cLocEsp,lFullEsp,lImp,cTipRet,lConBlc)
						Local xRet 		:= ""
						Local cIndex		:= ""
						Local cQuery 		:= ""
						Local cEspQry		:= ""
						Local cAliasQry 	:= GetNextAlias()
						Local cSqlEspPri	:= ""
						Local cEspPla		:= GetNewPar("MV_PESPPLA","'094','055'")
						Local nPos			:= 0
						Local aEsp			:= {}
						Local cWhere		:= ""
						Local cCampos		:= "%BAX_FILIAL, BAX_CODINT, BAX_CODESP, BAX_CODIGO, BAX_ESPPRI, BAX_DATBLO%"
						Local cDatPro		:= DtoS(dDatRea)

						Default lFullEsp	:= GetNewPar('MV_PLSCTES','0') == '1'
						Default lConBlc		:= .T.
						Default cTipRet		:= "C"
						Default lImp		:= .F.

	//Prevencao de erros no conteudo da query
						cEspPla := AllTrim(cEspPla)
						cEspPla := Iif(SubStr(cEspPla,Len(cEspPla)) <> ",",cEspPla,Right(cEspPla,Len(cEspPla) - 1))
						cEspPla := StrTran(StrTran(cEspPla,"'",""),",","','")

	//Garantia que esta avaliando o Prestador Contratado correto
						If Len(AllTrim(cCodRda)) > 6
							If AllTrim(cCodRda) == AllTrim(BAU->BAU_CPFCGC)
								cCodRda := BAU->BAU_CODIGO
							Else
								BAU->(DbSetOrder(4)) //BAU_FILIAL+BAU_CPFCGC
								If BAU->(DbSeek(xFilial("BAU") + cCodRda))
									cCodRda := BAU->BAU_CODIGO
								EndIf
							EndIf
						EndIf

	//Preparando parametros da query
						If !Empty(cEspPla)
							cEspQry := cEspPla + "','" + AllTrim(cEspPro)
						Else
							cEspQry := AllTrim(cEspPro)
						EndIf

	//Inicio WHERE
						cWhere := "%"
	//O parametro MV_PLSCTES define se deve considerar as especialidades enviadas (XML + MV_PESPPLA).
						If !lFullEsp
							cWhere += "BAX_CODLOC = '" + cLocEsp + "' AND "
							cWhere += "BAX_CODESP IN ('" + cEspQry + "') AND "
							Iif(lConBlc,cWhere += "(BAX_DATBLO = ' ' OR (BAX_DATBLO <> ' ' AND BAX_DATBLO > '" + cDatPro + "')) AND ",nil)
						Else
							Iif(lConBlc,cWhere += "(BAX_DATBLO = ' ' OR (BAX_DATBLO <> ' ' AND BAX_DATBLO > '" + cDatPro + "')) AND ",nil)
						EndIf
						cWhere += "%"
	// Final WHERE

						BeginSql alias cAliasQry
							SELECT
							%exp:cCampos%
							FROM
							%table:BAX% BAX
							WHERE
							BAX_FILIAL	= 	%xFilial:BAX% AND
							BAX_CODIGO	= 	%exp:cCodRda% AND
							BAX_CODINT	= 	%exp:cCodOpe% AND
							%exp:cWhere%
							BAX.%notdel%
							ORDER BY
							%exp:cCampos%
						EndSql

						If !(cAliasQry)->(Eof())
		//Alimentando o array com os dados das especialidades encontradas na consulta
							While !(cAliasQry)->(Eof())
			/*
			Estrutura do aEsp
			[1] - Codigo da Especialidade
			[2] - Flag informando se eh a especialidade principal (0-Nao/1-Sim)
			[3] - Flag informando se eh igual a especialidade do executante (0-Nao/1-Sim)
			[4] - Flag informando se a especialidade esta bloqueada (0-Nao/1-Sim)
			*/
								aAdd(aEsp,{	(cAliasQry)->BAX_CODESP,;
									(cAliasQry)->BAX_ESPPRI,;
									Iif((cAliasQry)->BAX_CODESP == AllTrim(cEspPro),"1","0"),;
									Iif(lConBlc,"0",Iif(((Empty((cAliasQry)->BAX_DATBLO)) .Or. (!Empty((cAliasQry)->BAX_DATBLO) .And. (cAliasQry)->BAX_DATBLO > cDatPro)),"0","1"))})

			//Proximo resultado
								(cAliasQry)->(DbSkip())

							Enddo

							If cTipRet == "A"
								xRet := aClone(aEsp)
							Else
			//Ordem de prioridade
			/*
			1 - Especialidade do Executante coincide com a especialidade do Prestador
			2 - Especialidade principal do Prestador
			3 - Primeira especialidade encontrada
			*/
								nPos := aScan(aEsp,{|x|(x[3]) == "1"})
								Iif(nPos == 0,nPos := aScan(aEsp,{|x|(x[2]) == "1"}),NIL)

								If nPos > 0
				//Pega a especialidade encontrada conforme ordem de prioridade acima
									xRet := aEsp[nPos][1]
								Else
				//Pega a primeira especialidade encontrada
									(cAliasQry)->(DbGoTop())
									xRet := (cAliasQry)->BAX_CODESP
								EndIf
							EndIf

						ElseIf lImp

		//Nao achou nenhuma especialidade na importacao, retorna a principal para prevencao de inconsistencia.
							If Empty(xRet := u_cbPreEsp(cCodRda,cCodOpe,cLocEsp,cDatPro))
								BAX->(DbSetOrder(1)) //BAX_FILIAL + BAX_CODIGO + BAX_CODINT + BAX_CODLOC + BAX_CODESP + BAX_CODSUB
								If BAX->(DbSeek(xFilial("BAX") + cCodRda + cCodOpe))
									xRet := BAX->BAX_CODESP
								EndIf
							EndIf

						Endif

						IF Select(cAliasQry) > 0
							(cAliasQry)->(DbCloseArea())
						Endif

						Return xRet

/*/{Protheus.doc} u_CBXMLTACE
@type function
/*/
					User function CBXMLTACE(cCont)
						PLSDelTra(cCont)
						return cCont

/*/{Protheus.doc} u_cbMatValida
//Recebe a matricula e devolve a matricula do PLS. Aceita: Matricula do PLS, matricula antiga e Matricula da Empresa.
Se nao encontrar por nenhuma das tres opcoes devolvo o que veio no xml e entra na critica X21
@author romulo.ferrari
@since 09/12/2016
@version 12.1.7

@type function
/*/
					User Function cbMatValida(cMatXML,cNomUsr)
						Local aAreaBa1	:= BA1->(GetArea())
						Local cRetPe	:= ""
						Local cMatArq	:= cMatXML

						BA1->(DbSetOrder(2))
						If !BA1->(MsSeek(xFilial("BA1")+cMatXML))
							BA1->(DbSetOrder(5))
							IF BA1->(MsSeek(xFilial("BA1")+cMatXML)) .And. alltrim(BA1->BA1_MATANT) == cMatXML  //Somente se a busca for exata dᠮT., ficou assim pq o segundo par⭥tro do MsSeek n㯠estava funcionando
								cMatXML := BA1->(BA1_CODINT + BA1_CODEMP + BA1_MATRIC + BA1_TIPREG + BA1_DIGITO )
							Else
								BA1->(DbSetOrder(6)) //BA1_FILIAL+BA1_MATEMP
								If (BA1->(MsSeek(xFilial("BA1")+cMatXML))) .and. (AllTrim(BA1->BA1_MATEMP) == AllTrim(cMatXML))
									cMatXML := BA1->(BA1_CODINT + BA1_CODEMP + BA1_MATRIC + BA1_TIPREG + BA1_DIGITO )
								Endif
							EndIf
						EndIf

						cMatArq	:= cMatXML

//Ponto de entrada para alterar a matricula
						if ExistBlock("PLSXMLMAT")
							cRetPe := ExecBlock("PLSXMLMAT",.F.,.F.,{cMatArq,cNomUsr})
							if ValType(cRetPe) == "C" .And. !Empty(cRetPe)
								cMatXML := cRetPe
							endif
						endif

						RestArea(aAreaBa1)

						Return cMatXML
						
						/*/{Protheus.doc} u_cbPreEsp
Retorna a especialidade principal do prestador ou as especialidades do mesmo caso o parametro de Local de atendimento n�o for informado

@type function
@author victor.silva
@since 26/08/2016
@version 1.0
@param cCodRda, caracter, Codigo do Prestador
@param cCodOpe, caracter, Codigo da Operadora
@param cLocEsp, caracter, Codigo do local de atendimento
@param cDatRef, caracter, Data de Referencia para bloqueio no formato "aaaammdd"
@return xRet, 	cLocEsp informado: caracter com a especialidade principal/cLocEsp nao informado: array com as especialidades principais de cada local de atendimento
/*/
User Function cbPreEsp(cCodRda,cCodOpe,cLocEsp,cDatRef)
Local cSqlEspPri 	:= GetNextAlias()
Local xRet				:= nil
Local lConLoc 		:= .F.
Local lConBlc			:= .F.

Default cLocEsp		:= ""
Default cDatRef		:= ""

lConLoc := !Empty(cLocEsp)
lConBlc	:= !Empty(cDatRef)

If ValType(cDatRef) == "D"
	cDatRef	:= DtoS(cDatRef)
EndIf

cWhere := "%"
If lConLoc
	cWhere += "BAX_ESPPRI	= 	'1' AND "
	cWhere += "BAX_CODLOC = '" + cLocEsp + "' AND "
	Iif(lConBlc,cWhere += "(BAX_DATBLO = ' ' OR (BAX_DATBLO <> ' ' AND BAX_DATBLO > '" + cDatRef + "')) AND ",nil)
Else
	Iif(lConBlc,cWhere += "(BAX_DATBLO = ' ' OR (BAX_DATBLO <> ' ' AND BAX_DATBLO > '" + cDatRef + "')) AND ",nil)
EndIf
cWhere += "%"

BeginSql alias cSqlEspPri
	SELECT
	BAX_CODESP,BAX_CODLOC,BAX_DATBLO
	FROM
	%table:BAX% BAX
	WHERE
	BAX_FILIAL	= 	%xFilial:BAX% AND
	BAX_CODINT	= 	%exp:cCodOpe% AND
	BAX_CODIGO	= 	%exp:cCodRda% AND
	%exp:cWhere%
	BAX.%notdel%
	ORDER BY BAX_CODLOC
EndSql

If !(cSqlEspPri)->(Eof())
	If lConLoc
		xRet := (cSqlEspPri)->BAX_CODESP
	Else
		xRet := {}
		//Alimentando o array com os dados das especialidades encontradas na consulta
		While !(cSqlEspPri)->(Eof())
			/*
			Estrutura do aEsp
			[1] - Codigo da Especialidade
			[2] - Codigo do Local de atendimento
			[3] - Flag informando se a especialidade esta bloqueada (0-Nao/1-Sim)
			*/
			aAdd(xRet,{	(cSqlEspPri)->BAX_CODESP,;
				(cSqlEspPri)->BAX_CODLOC,;
				Iif(lConBlc,"0",Iif(((Empty((cSqlEspPri)->BAX_DATBLO)) .Or. (!Empty((cSqlEspPri)->BAX_DATBLO) .And. (cSqlEspPri)->BAX_DATBLO > cDatRef)),"0","1"))})
			
			//Proximo resultado
			(cSqlEspPri)->(DbSkip())
		Enddo
	EndIf
EndIf

(cSqlEspPri)->(DbCloseArea())

Return xRet

/*/{Protheus.doc} u_cbFreArr
Libera espaco utilizado em memoria pelo endereco do array informado no parametro

@type function
@author victor.silva
@since 17/08/2016
@version 1.0
/*/
User function cbFreArr(aArray)

if ValType(aArray) == "A"
	aSize(aArray,0)
	aArray := Nil
	aArray := {}
endif

return
