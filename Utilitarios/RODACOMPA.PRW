#INCLUDE 'PROTHEUS.CH'
#INCLUDE "shell.ch"
#DEFINE SIMPLES Char( 39 )
#DEFINE DUPLAS  Char( 34 )
#Define cEnt Chr(13) + Chr(10)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบ Programa ณ RodaCompa บ Autor ณ Mateus Medeiros	บ Data ณ  07/05/2013   ฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบ Descricaoณ Funcao para rodar compatibilizadores					      ณฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑบ                                                                       บฑฑ
ฑฑบ                ATUALIZACOES                                           บฑฑ
ฑฑบ                                                                       บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบ 09/07/13ณ  Vitor Sbano  - Geracao de arquivo de Log de Processamento  ณฑฑ
ฑฑบ          ณ               (pasta C:\SIGACFG\LOG_UPD.TXT                บฑฑ
ฑฑบ          ณ               para mensurar o Tempo processamento          บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบ         ณ                                                             ณฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบ         ณ                                                             ณฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบ         ณ                                                             ณฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
//
//
*/
User Function RodaCompa()

Private oMainWnd  := NIL
Private oProcess  := NIL
Private aArray		:= {}
Private aDiretorio:={}

#IFDEF TOP
    TCInternal( 5, '*OFF' ) // Desliga Refresh no Lock do Top
#ENDIF

__cInterNet := NIL
__lPYME     := .F.

Set Dele On

	//*******************************************
	//	  Fun็ใo que irแ abrir uma janela,
	//	  para receber as informa็๕es que
	// 	  que serใo usadas no Programa.
	//*******************************************
	aDiretorio := DirArquivo()

/*
	Importar()
	fun็ใo que farแ leitura de um arquivo(.txt / .csv)
	com os compatibilizadores que deverใo ser rodados na base
	Recebe como parโmetro o caminho e o nome do arquivo com o nome
	dos compatibilizadores.
*/

	aArray := u_Importar(aDiretorio[1,1])
	//***************************************************************************
	//	  Fun็ใo que irแ executar o SmartClient
	// 		Parโmetros:
	//		  1) Array com as informa็๕es dos compatibilizadores
	/// 	  2) Diret๓rio Onde estแ localizada a instala็ใo do Smatcliente.Exe
	//		  3) Ambiente onde serแ rodado os compatibilizadores
    //		  4) Comunica็ใo que serแ usada para rodar os compatibilizadores
	//***************************************************************************
	FSTProc(aArray,aDiretorio[1,2],aDiretorio[1,3],aDiretorio[1,4])

Return NIL

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบ Programa ณ FSTProc  บ Autor ณ TOTVS Protheus     บ Data ณ  17/08/2011 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบ Descricaoณ Fun็ใo que irแ executar o SmartClient, e consequentemente  ณฑฑ
ฑฑบ          ณ irแ executar todos os compatibilizadores, de acordo        บฑฑ
ฑฑบ          ณ com o que foi importado na rotina Importar()					บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑณ Uso      ณ FSTProc    - Gerado por EXPORDIC / Upd. V.4.5.2 EFS        ณฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function FSTProc(aDados,cDir,cAmb,cComunica)
Local   aInfo     := {}
Local   aRecnoSM0 := {}
Local   cAux      := ''
Local   cFile     := ''
Local   cFileLog  := ''
Local   cTexto    := ''
Local   cTopBuild := ''
Local   lOpen     := .F.
Local   lRet      := .T.
Local   nI        := 0
Local   nPos      := 0
Local   nRecno    := 0
Local   nX        := 0
Local   oDlg      := NIL
Local   oFont     := NIL
Local   oMemo     := NIL
Local 	cFunName	:= ""
Local 	cMsgPrc	:= "Todos os compatibilizadores foram rodados!"
Local	cMsg		:= "Aten็ใo!!"
Local 	i 			:= 0
Local	cMensag		:=	""
Local	cHrIni1	:= Time()
Private c_dirimp 	:= space(100)
Private aArqUpd   := {}
_cMsg	:= ""
_cArqLog	:= cDir+"\LOGCOMP.TXT"
//
RpcClearEnv()

For i := 1 to Len(aDados)
	Tone() // alerta sonoro
	lPergunta := .T.
	While lPergunta
		lPergunta := .F.
		cHrIni	:= Time()
		//_cMsg	+=	aDados[i][1]+" -  Inicio:  "+cHrIni+" / "+chr(13) + chr(10)
		//MemoWrite("C:\SIGACFG\RODACOMP.txt",_cMsg)
		//
		If MsgYesNo("Deseja Rodar o compatbilizador "+aDados[i][1]+" ?","Roda Compatibilizador")

// abre uma aplica็ใo externa e aguarda at้ que ela finalize.
			WaitRun( ALLTRIM(cDir)+" -Q -P="+ALLTRIM(aDados[i][1])+" -C= "+ALLTRIM(cComunica)+" -E= "+ALLTRIM(cAmb)+" -m", SW_SHOWNORMAL )

			// se o compatibilizador for o RHUPDMOD, ้ preciso abri-lo mais de uma vez,
			// pois o usuแrio pode ter a necessidade de rodar o rhupdmod mais de uma vez.

			If ALLTRIM(aDados[i][1]) = "RHUPDMOD"
				lPergunta := .T.
			Endif

		EndIf
	Enddo
	cHrFim	:= Time()
	_cMsg	+=	"|"+aDados[i][1]+"|Hr. Inicio:  |"+cHrIni+"| Hr. Fim |"+cHrFim+"|"+chr(13) + chr(10)
	MemoWrite("\DATA\LOG_RodaCompa.TXT",_cMsg)
	//
Next i


Return lRet

*---------------------------------------------------------------------------------------------*
USer Function Importar(c_dirimp)
*---------------------------------------------------------------------------------------------*
* Descricao: Irแ importar o arquivo CSV/TXT com as informa็๕es dos compatibilizadores            *
*---------------------------------------------------------------------------------------------*
Local lImp 		:= .F.
Local _nLinAtu 	:= 0
Local _nTotal 	    := 0
Local cBuffer		:= ""
Local aCab 		    := {}
Local aInfo		    := {}
Local xPos		    := ""
Local aTmpDados		:= {}
Local aArea         := GetArea()
Local nDados        := 0

Private cArquiv 	:= c_dirimp

 // adicionar linha

If empty(c_dirimp)
	Alert("Escolha o arquivo que sera Importado...")
Else

	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณAbre o Arquivo Textoณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	FT_FUSE(cArquiv)
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณVai para o Inicio do Arquivo e Define o numero de Linhas para a Barra de Processamento.ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	FT_FGOTOP()
	ProcRegua(FT_FLASTREC())
	_nTotal := FT_FLASTREC()
	_nLinAtu := 01
	cBuffer := FT_FREADLN()

	aCab := {}
	cBuffer := FT_FREADLN()
	//cBuffer := U_SemAcentos(cBuffer)
	xPos := AT(";",cBuffer)
	While xPos <> 0
		aInfo  := Alltrim(SubStr(cBuffer , 1, xPos-1 ))
		aAdd( aCab , aInfo )
		cBuffer:= SubStr(cBuffer , xPos+1, Len(cBuffer)-xPos)
		xPos := AT(";",cBuffer)
	Enddo
	if Len(cBuffer) > 0
		aInfo  := Alltrim(SubStr(cBuffer , 1, Len(cBuffer) ))
		aAdd( aCab , aInfo )
	endif
	IncProc("Aguarde...")
	//FT_FSKIP()
	FT_FGOTOP()

	ProcRegua(FT_FLASTREC())
	aDados := {}
	While !FT_FEOF() //Percorre todo os itens do arquivo CSV.
		IncProc("Aguarde...")
		//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
		//ณFaz a Leitura da Linha do Arquivo e atribui a Variavel cBufferณ
		//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
		cBuffer := FT_FREADLN()
		aTmpDados := {}

		//Se jแ passou por todos os registros da planilha "CSV" sai do While.
		If Empty(cBuffer)
			Exit
		Endif

		xPos := AT(";",cBuffer)
		if !Empty(SubStr(cBuffer , 1, xPos-1 ))

			While xPos <> 0
				aInfo  := Alltrim(SubStr(cBuffer , 1, xPos-1 ))
				aAdd( aTmpDados , aInfo )
				cBuffer:= SubStr(cBuffer , xPos+1, Len(cBuffer)-xPos)
				xPos := AT(";",cBuffer)
			Enddo
			if Len(cBuffer) > 0
				aInfo  := Alltrim(SubStr(cBuffer , 1, Len(cBuffer) ))
				aAdd( aTmpDados , aInfo )
			endif
			aAdd( aDados , aTmpDados )
			nDados++
			lImp := .T. //O item serแ importado
		endif


		//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
		//ณIncrementa a Barra de Rolagem e vai para a Proxima Linha do Arquivoณ
		//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
		_nLinAtu++
		FT_FSKIP()
	Enddo

	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณFecha o Arquivo Texto e apaga o mesmo.ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	FT_FUSE()
	*---------------------------------------------------------------------------*

	RestArea(aArea)

Endif

Return(aDados)

Static Function DirArquivo()

Local oDlg := Nil
Local  c_dirimp 	:= ""
Local cDir 		:= GetClientDir()+"SmartClient.exe"
Local cAmb	 		:= GetEnvServer()
Local cComunica   := Space(500)
**********************************
Local aDir			:= {}

***aDir[1][1] -- Diretorio do arquivo a ser lido
***aDir[1][2] -- Diretorio do SmartClient
***aDir[1][3] -- Nome do Ambiente
***aDir[1][4] -- Comunica็ใo do Ambiente
**********************************

While Len(aDir) == 0

	DEFINE MSDIALOG oDlg TITLE "Arquivo para Importar" FROM 000,000 TO 230,320 PIXEL //230 alt 320 larg
	@ 010,009 Say   "Diret๓rio do Arquivo"  PIXEL OF oDlg   //030
	@ 018,009 MSGET  c_dirimp          Size 120,010 WHEN .F. PIXEL OF oDlg  //038

*-----------------------------------------------------------------------------------------------------------------*
*Buscar o arquivo no diretorio desejado.                                                                          *
*Comando para selecionar um arquivo.                                                                              *
*Parametro: GETF_LOCALFLOPPY - Inclui o floppy drive local.                                                       *
*           GETF_LOCALHARD   - Inclui o Harddisk local.                                                           *
*-----------------------------------------------------------------------------------------------------------------*
	@ 018,140 BUTTON "..."   SIZE 013,013 PIXEL OF oDlg   Action(c_dirimp := cGetFile("*.csv|*.csv|*.txt|*.txt","Importacao de Dados",0, ,.T.,GETF_LOCALHARD,.T., .T. ))

	@ 033,009 Say   "SmartClient"       Size 045,008 PIXEL OF oDlg   //030
	@ 041,009 MSGET cdir          Size 120,010 WHEN .F. PIXEL OF oDlg  //038
	@ 041,140 BUTTON "..."   SIZE 013,013 PIXEL OF oDlg   Action(cdir := cGetFile("SmartClient.exe|SmartClient.exe","Importacao de Dados",0, ,.T.,GETF_LOCALHARD,.T., .T. ))
	//ambiente que serแ rodado os compatibilizadores
	@ 055,009 Say   "Ambiente(Environment)"       Size 095,008 PIXEL OF oDlg   //030
	@ 063,009 MSGET cAmb          Size 120,010 PIXEL OF oDlg  //038
	//comunica็ใo do ambiente
	@ 077,009 Say   "Comunica็ใo"       Size 095,008 PIXEL OF oDlg   //030
	@ 086,009 MSGET cComunica           Size 120,010 PIXEL OF oDlg  //038
*-----------------------------------------------------------------------------------------------------------------*

	@ 105,30 Button "OK"       Size 037,012 PIXEL OF oDlg Action(  Iif(!Empty(c_dirimp) .And. !Empty(cDir) .And. !Empty(cAmb) .And. !Empty(cComunica),AAdd(aDir,{c_dirimp,cDir,cAmb,cComunica}),Alert("Preencha todos os campos")),oDlg:End())
	@ 105,90 Button "Cancelar" Size 037,012 PIXEL OF oDlg Action (Final(OemtoAnsi('Processo Encerrado')),oDlg:end())
	ACTIVATE MSDIALOG oDlg CENTERED

EndDo

Return aDir
