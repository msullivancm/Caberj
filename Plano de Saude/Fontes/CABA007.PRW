#Include 'RWMAKE.CH'
#Include 'PLSMGER.CH'
#Include 'COLORS.CH'
#Include 'TOPCONN.CH'
#INCLUDE "Protheus.ch"
#INCLUDE "Sigawin.ch"
#INCLUDE "Tbiconn.ch"
#INCLUDE "Fileio.ch"

#define CRLF	Chr(13)+Chr(10)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABA007   ºAutor  ³Luzio Tavares       º Data ³  25/07/08   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Importa usuarios de empresas incluindo alterando e excluindo±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ PLS                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function CABA007()
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta matriz com as opcoes do browse...                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
PRIVATE aRotina   	:=	{	{ "Pesquisar"	, 'AxPesqui'	    , 0 , K_Pesquisar  },;
{ "Visualizar"	 , 'AxVisual'	    , 0 , K_Visualizar },;
{ "I&mportar"	 , 'U_CB007INS'   , 0 , K_Incluir    },;
{ "C&riticar"	 , 'U_CB007CRI'   , 0 , K_Incluir    },;
{ "&Excluir"	 , 'U_CB007EXC'   , 0 , K_Excluir    },;
{ "&Inserir BD" , 'U_CB007APP'   , 0 , K_Incluir    },;
{ "Ex&portar"	 , 'U_CB007EXP'   , 0 , K_Incluir    },;
{ "&Gerar rel." , 'U_CB007REL'   , 0 , K_Incluir    },;
{ "&Composicao" , 'U_CB007CMP'   , 0 , K_Incluir    },;
{ "Legenda"     , "U_CB007LEG(1)", 0 , K_Incluir    },;
{ "Historico"   , "U_CB007PES"   , 0 , K_Pesquisar  } }

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Titulo e variavies para indicar o status do arquivo                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
PRIVATE cCadastro 	:= "Importacao de Arquivos com Massa de Vida"
PRIVATE aCdCores  	:= { 	{ 'BR_VERMELHO', 'Arquivo Importado' },;
{ 'BR_AMARELO' , 'Arquivo Importado e Criticado' },;
{ 'BR_VERDE'   , 'Arquivo Inserido na Base'      },;
{ 'BR_AZUL'    , 'Arquivo Exportado'             } }
PRIVATE aCores      := { { 'ZZ0_STATUS = "1"',aCdCores[1,1] },;
{ 'ZZ0_STATUS = "2"',aCdCores[2,1] },;
{ 'ZZ0_STATUS = "3"',aCdCores[3,1] },;
{ 'ZZ0_STATUS = "4"',aCdCores[4,1] }}
PRIVATE cPath  := ""
PRIVATE aErro_	:= {}
PRIVATE aHeader   := {}
PRIVATE aTrailler := {}
PRIVATE aOk			:= {}

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Starta mBrowse...                                                   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
ZZ0->(DBSetOrder(1))
ZZ0->(mBrowse(006,001,022,075,"ZZ0" , , , , , Nil    , aCores, , , ,nil, .T.))
ZZ1->(DbClearFilter())

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ CB007APP   ³ Autor ³ Luzio Tavares     ³ Data ³ 16.05.2006 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Insere Arquivo Criticado                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function CB007APP(cAlias,nReg,nOpc)
Local aCampos := {}

if ZZ0->ZZ0_STATUS == "2"
	ZZ1->(DbSetOrder(2))
	if ZZ1->(DbSeek(xFilial("ZZ1")+ZZ0->ZZ0_SEQUEN))
		While !ZZ1->(EOF()) .And. ZZ1->ZZ1_SEQUEN == ZZ0->ZZ0_SEQUEN
			if Empty(AllTrim(ZZ1->ZZ1_TABERR))
				if alltrim(ZZ1->ZZ1_OPER) == "01" //Incluir beneficiario.
					IncluiUsr()
				Elseif alltrim(ZZ1->ZZ1_OPER) == "02"   //.and. !(alltrim(ZZ1->ZZ1_OPERSI) $ '04_06') //Alteracoes de endereco, nome, plano, etc
					AlteraUsr(2)
					//				Elseif alltrim(ZZ1->ZZ1_OPER) == "02"   //.and. (alltrim(ZZ1->ZZ1_OPERSI) $ '04_06')  //MUDANCA DE TIPO DE DEPENDENTE (Muda o subcontrato - transferir).
					//					AltSub(1)
				Elseif alltrim(ZZ1->ZZ1_OPER) == "03" //Bloqueio de beneficiario.
					AlteraUsr(3)   //Exclusao de beneficiario
				Elseif alltrim(ZZ1->ZZ1_OPER) == "04" //Mudanca de empresa (modificar o subcontrato - transferir)                 
				
					AlteraUsr(3,1)    //PreBA3(3,.F.)  //Exclusao de beneficiario
					IncluiUsr(.F.)    //Inclusao do Novo beneficiario
				Elseif alltrim(ZZ1->ZZ1_OPER) == "05" //Mudanca de plano (tranferir)
					//					If alltrim(ZZ1->ZZ1_OPERSI) $ '04'
					//						AlteraUsr(2)
					//					Else
					AltSub(1)
					//					EndIf
				Elseif alltrim(ZZ1->ZZ1_OPER) == "06" //Desbloqueio de beneficiario.
					AlteraUSr(3)
				Endif
			Endif
			ZZ1->(DbSkip())
		Enddo
	Endif
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Mudo o status do arquivo colocando como Inserido no BD                ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	ZZ0->(RecLock("ZZ0",.F.))
	ZZ0->ZZ0_STATUS := "3"
	ZZ0->ZZ0_DTINSB := dDatabase
	ZZ0->(MsUnlock())
	
	Relest()
Else
	MsgInfo("Somente e possivel inserir no BD arquivos com status criticado!")
Endif
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Fim da Rotina...                                                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ CB007INS   ³ Autor ³ Luzio Tavares     ³ Data ³ 15.05.2006 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Importa Arquivo de Usuario para Layout Padrao ZZ0          ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function CB007INS(cAlias,nReg,nOpc)

Local I__f := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

LOCAL oDlg
LOCAL nOpca   := 0
LOCAL oEnc
LOCAL aRet
LOCAL bOK     := {|| nOpca := 1, oDlg:End()}
LOCAL bCancel := {|| nOpca := 0, oDlg:End()}
Local CSqlArq := ""
Local cUSqArq := ""
Local cSQL := ""
Local cSequen := 0

cAlias := "ZZ0"
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define dialogo...                                                   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
DEFINE MSDIALOG oDlg TITLE cCadastro FROM ndLinIni,000 TO ndLinFin,ndColFin OF GetWndDefault()
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Enchoice...                                                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Copy cAlias To Memory Blank

oEnc := ZZ0->(MsMGet():New(cAlias,nReg,nOpc,,,,,{015,004,192,390},,,,,,oDlg,,,.F.))
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Ativa o dialogo...                                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
ACTIVATE MSDIALOG oDlg ON INIT EnchoiceBar(oDlg,bOK,bCancel,.F.,{})
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define tratamento de acordo com a opcao...                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If nOpca == K_OK
	//
	// Verifica se a sequencia corresponde a esperada
	//
	cSql := "SELECT MAX(ZZ0.ZZ0_SEQUEN) SEQUEN "
	cSql += " FROM  "+RetSqlName("ZZ0")+" ZZ0 "
	cSql += " WHERE D_E_L_E_T_ = ' ' "
	cSql += " AND   ZZ0.ZZ0_FILIAL = '  ' "
	cSql += " ORDER BY ZZ0_SEQUEN "
	PLsQuery(cSql,"TMPSEQ")
	If !TMPSEQ->(EOF())
		While !TMPSEQ->(EOF())
			cSequen := Strzero(val(TMPSEQ->SEQUEN) + 1,6)
			TMPSEQ->(DbSkip())
		Enddo
	Endif
	TMPSEQ->(DbCloseArea())
	M->ZZ0_SEQUEN := cSequen

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Inclui movimento...                                                 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	M->ZZ0_QTDLID := CB007IMP(oEnc:aGets,oEnc:aTela,M->ZZ0_NOMARQ,oDlg)
	M->ZZ0_DTIMPO := dDatabase
	//	M->ZZ0_CTREMP :=
	//	M->ZZ0_LINHA  :=
	//	M->ZZ0_LINT   :=
	If M->ZZ0_QTDLID > 0
		ZZ0->(PLUPTENC("ZZ0",K_Incluir))
	EndIf
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Fim da Rotina...                                                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ CB007IMP ³ Autor ³ Luzio Tavares     ³ Data ³ 15.05.2006 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Trata rotina externa                                       ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function CB007IMP(aGets,aTela,cNomArq,oDlg)
Local aCamposImp := {}
Local nRet       := 0
Local cBuffer    := ''
Local nHandle
Local cAcao      := ""

Private nBytes   := 0
Private cFile
Private cFileDest
Private cFileErro
Private cDirFiles
Private cDirLido
Private cDirErro

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Testa campos obrigatorios...                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If !Obrigatorio(aGets,aTela)
	Return(nRet)
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifico se esta em branco o campo e se existe o arquivo            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If Empty(M->ZZ0_NOMARQ)
	Help(" ",1,"NOFLEIMPOR")
	Return(nRet)
End

cPath := GetNewPar("MV_YPATHCR","\interface\importa\itaubenef\recebidos\")
//cDirFiles := GetNewPar("MV_XPATHCR","\Protheus_Data\interface\importa\itaubenef\")

//cDirFiles := GetNewPar("MV_XPATHCR","SERVIDOR\INTERFACE\IMPORTA\ITAUBENEF")
cDirLido  := GetNewPar("MV_XPATHCL","\interface\importa\itaubenef\processados\")
cDirErro  := GetNewPar("MV_XPATHCE","\interface\importa\itaubenef\erro\")

/*
cPath := GetNewPar("MV_YPATHCR","C:\Protheus8\Protheus_Data\interface\importa\itaubenef\")
//cDirFiles := GetNewPar("MV_XPATHCR","\Protheus_Data\interface\importa\itaubenef\")

//cDirFiles := GetNewPar("MV_XPATHCR","SERVIDOR\INTERFACE\IMPORTA\ITAUBENEF")
cDirLido  := GetNewPar("MV_XPATHCL","c:\Protheus8\Protheus_Data\interface\importa\itaubenef\processados\")
cDirErro  := GetNewPar("MV_XPATHCE","c:\Protheus8\Protheus_Data\interface\importa\itaubenef\")
*/

If Substr(cPath,Len(cPath),1) <> "\"
	cPath := cPath + "\"
Endif

cFile     := Alltrim(cPath+M->ZZ0_NOMARQ)
cFileDest := Alltrim(cDirLido+M->ZZ0_NOMARQ)
cFileErro := Alltrim(cDirErro+M->ZZ0_NOMARQ)

cSql := "SELECT ZZ0_NOMARQ "
cSql += " FROM  "+RetSqlName("ZZ0")+" ZZ0 "
cSql += " WHERE ZZ0_FILIAL = '  '"
cSql += " AND ZZ0_NOMARQ = '"+ Alltrim(M->ZZ0_NOMARQ) + "' "
cSql += " AND D_E_L_E_T_ = ' ' "

PLsQuery(cSql,"ZZ0TRB")
ZZ0TRB->(dbGoTop())

If !ZZ0TRB->(EOF())
	ZZ0TRB->(DbCloseArea())
	Help(" ",1,"FILEJAEXISTE")
	Return(nRet)
Endif
ZZ0TRB->(DbCloseArea())

//nHdlImp := FOpen(cPath+M->ZZ0_NOMARQ,64)
If (nHandle := FT_FUse( cFile )) == -1
	Help(" ",1,"NOFLEIMPOR")
	Return(nRet)
Endif
FT_FGOTOP()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Preencho a matriz com os campos da Importacao                       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//PreencheCmp(@aCamposImp)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Defino o tamanho da linha mais os 2 caracteres de fim de linha      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
nTamLinha := M->ZZ0_NROBYT+2

////ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
////³ Vou para o inicio do arquivo                                        ³
////ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//nTamArq:= FSeek(nHdlImp,0,2)
//FSeek(nHdlImp,0,0)
cRet := "00"

While ( ! FT_FEOF() )
	
	cBuffer := AllTrim(FT_FREADLN())
	
	cNumLin := Substr(cBuffer,894,6)
	cZZ1OPER := SubStr(cBuffer,1, 2)
	
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Uso a matriz de campos para preencher arquivos da importacao        ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If cZZ1OPER == '01'   // Grava dados no arquivo ZZ0
		//		cZZ1SEQARQ := Substr(cBuffer, 88,6)
		M->ZZ0_CTREMP := SubStr(cBuffer, 3,5)  //Codigo do Contrato
		// 		M->ZZ0_SEQUEN := SubStr(cBuffer, 3,5)  //Codigo do Contrato
		M->ZZ0_LINHA  := SubStr(cBuffer, 1,1000)  //Linha
		M->ZZ0_SEQARQ := SubStr(cBuffer,88,6)
		If ZZ0->(FieldPos("ZZ0_DATGER")) > 0
			M->ZZ0_DATGER := SubStr(cBuffer,97,10)  //Data da geracao do Arquivo
		EndIf
		If ZZ0->(FieldPos("ZZ0_HORGER")) > 0
			M->ZZ0_HORGER := SubStr(cBuffer,107,6)  //Hora da geracao do Arquivo
		Endif
		
	ElseIf cZZ1OPER == '10' // Grava dados no ar
		
		ZZ1->(RecLock("ZZ1",.T.))
		ZZ1->ZZ1_OPER   := Substr(cBuffer,  3, 2)
		ZZ1->ZZ1_SEQUEN := M->ZZ0_SEQUEN
		ZZ1->ZZ1_NUMLIN := cNumLin
		ZZ1->ZZ1_FUNC   := Substr(cBuffer,  5, 13)
		ZZ1->ZZ1_DEPEND := Substr(cBuffer, 14,  2)
		ZZ1->ZZ1_BENEF  := SubStr(cBuffer, 16, 80)
		ZZ1->ZZ1_IDGPF  := SubStr(cBuffer,96,10)
		ZZ1->ZZ1_IDCONV := SubStr(cBuffer,106,15)
		ZZ1->ZZ1_IDDEP  := SubStr(cBuffer,121,004)
		
		ZZ1->ZZ1_DTNASC := SubStr(cBuffer,125,010)
		ZZ1->ZZ1_UFNASC := SubStr(cBuffer,135,002)
		
		ZZ1->ZZ1_TPDOC  := SubStr(cBuffer,137,003)
		ZZ1->ZZ1_NRODOC := SubStr(cBuffer,140,015)
		
		ZZ1->ZZ1_TPPARE := SubStr(cBuffer,155,004)
		
		
		ZZ1->ZZ1_TPBENE := substr(cBuffer, 159,2)            //Tipo do Beneficiario
		
		ZZ1->ZZ1_CDBENE := SubStr(cBuffer, 161,1)            //Condicao do Beneficario
		
		ZZ1->ZZ1_SEXO := SubStr(cBuffer, 162,1)              // Sexo Beneficiario
		
		ZZ1->ZZ1_ESTCIV := SubStr(cBuffer, 163,1)            // Estado Civil do Beneficiario
		
		ZZ1->ZZ1_CPF := SubStr(cBuffer, 164,11)              // Numero CPF com DV do Beneficiario Titular
		
		ZZ1->ZZ1_PIS := SubStr(cBuffer, 186,3)              // Numero PIS com DV do Beneficiario Titular
		
		ZZ1->ZZ1_BANCO := SubStr(cBuffer, 186,3)           // Codigo do Banco Titular
		
		ZZ1->ZZ1_AGENC  := SubStr(cBuffer, 189,4)            // Codigo da Agencia Titular
		
		ZZ1->ZZ1_NUMCC  := SubStr(cBuffer, 193,11)           // Numero da Conta Corrente Titutar
		
		// Data de Adminssao do Beneficiario Titular na Empresa
		ZZ1->ZZ1_DTADMI := SubStr(cBuffer, 204,10)    //Ctod(SubStr(cBuffer, 204,2)+"/"+SubStr(cBuffer,207,2)+"/"+SubStr(cBuffer, 210,4))
		
		// Data de Desligamento do Beneficiario Titular na Empresa
		ZZ1->ZZ1_DTDESL := SubStr(cBuffer, 214,10)   //Ctod(SubStr(cBuffer, 214,2)+"/"+SubStr(cBuffer,216,2)+"/"+SubStr(cBuffer, 218,4))
		
		ZZ1->ZZ1_NOMMAE := Upper(Alltrim(SubStr(cBuffer, 224,60)))    //Nome da Mae do beneficiario
		
		ZZ1->ZZ1_CONTR := Alltrim(SubStr(cBuffer, 284,5))
		
		ZZ1->ZZ1_DTINCT := SubStr(cBuffer,289,10)    //Ctod(SubStr(cBuffer,289,2)+"/"+SubStr(cBuffer,291,2)+"/"+SubStr(cBuffer, 293,4)) //Dt Inicio Contrato
		
		ZZ1->ZZ1_FILIT := SubStr(cBuffer,299,5)
		
		ZZ1->ZZ1_PADRAO := SubStr(cBuffer,304,4)
		
		ZZ1->ZZ1_DTINPD := SubStr(cBuffer,308,10)    //Ctod(SubStr(cBuffer,308,2)+"/"+SubStr(cBuffer,310,2)+"/"+SubStr(cBuffer,312,4)) //Dt Inicio Padrao
		
		ZZ1->ZZ1_DTFIPD := SubStr(cBuffer,318,10)    //Ctod(SubStr(cBuffer,318,2)+"/"+SubStr(cBuffer,320,2)+"/"+SubStr(cBuffer,322,4)) //Dt Fim Padrao
		
		ZZ1->ZZ1_DTBASE := SubStr(cBuffer,328,10)     //Ctod(SubStr(cBuffer,328,2)+"/"+SubStr(cBuffer,330,2)+"/"+SubStr(cBuffer,332,4)) //Base de Calculo
		
		ZZ1->ZZ1_CODEMP := SubStr(cBuffer,339,4) //Codigo Empresa
		
		ZZ1->ZZ1_NOMEMP := SubStr(cBuffer,343,30) //Nome Empresa
		
		ZZ1->ZZ1_CODLOT := SubStr(cBuffer,373,17) //Codigo Lotacao
		
		ZZ1->ZZ1_ORGAO := SubStr(cBuffer,390,30) //Orgao Funcionario
		
		ZZ1->ZZ1_UFLOT := SubStr(cBuffer,420,2) //UF Lotacao
		
		ZZ1->ZZ1_CDUNI := SubStr(cBuffer,422,3) //CDUNIREG
		
		ZZ1->ZZ1_DTEXC := SubStr(cBuffer,425,10)   //Ctod(SubStr(cBuffer,425,2)+"/"+SubStr(cBuffer,425,2)+"/"+SubStr(cBuffer,425,4)) //Data Exclusao
		
		ZZ1->ZZ1_DTINCO := SubStr(cBuffer,438,10)   //Ctod(SubStr(cBuffer,438,2)+"/"+SubStr(cBuffer,440,2)+"/"+SubStr(cBuffer,442,4)) //Dt Inclusao Oper.
		
		ZZ1->ZZ1_INDENV := SubStr(cBuffer,448,1) //Ind. Envio Inform.
		
		ZZ1->ZZ1_LOGRAD := SubStr(cBuffer,449,50) //Logradouro
		ZZ1->ZZ1_NUMERO := SubStr(cBuffer,499,5) //Numero
		
		ZZ1->ZZ1_COMPLE := SubStr(cBuffer,504,10) //Complemento
		ZZ1->ZZ1_BAIRRO := SubStr(cBuffer,514,40) //Bairro
		ZZ1->ZZ1_CEP    := SubStr(cBuffer,554,9)  //CEP
		
		ZZ1->ZZ1_CIDADE := SubStr(cBuffer,563,40)  //Cidade
		
		ZZ1->ZZ1_UF := SubStr(cBuffer,603,2)  //UF
		
		ZZ1->ZZ1_DDDRES := SubStr(cBuffer,605,4)  //DDD da Residencia
		ZZ1->ZZ1_TELRES := SubStr(cBuffer,609,8)  //Telefone Residencial
		
		ZZ1->ZZ1_DDDCOM := SubStr(cBuffer,617,4)  //DDD Telefone Comercial
		ZZ1->ZZ1_TELCOM := SubStr(cBuffer,621,8)  //telefona Comercial
		
		ZZ1->ZZ1_RAMAL := SubStr(cBuffer,629,5)  //Ramal
		
		ZZ1->ZZ1_DDDCEL := SubStr(cBuffer,634,4)  //DDD Celular
		ZZ1->ZZ1_TELCEL := SubStr(cBuffer,638,8)  //Celular
		
		ZZ1->ZZ1_EMAIL := SubStr(cBuffer,646,80)  //Email
		
		ZZ1->ZZ1_FUNANT := SubStr(cBuffer,726,9)   //Funcional Aterior
		ZZ1->ZZ1_OUTROS := SubStr(cBuffer,735,46)  //Outros
		
		ZZ1->ZZ1_INDCAR := SubStr(cBuffer,781,1)  //Indicador de Carencia
		ZZ1->ZZ1_INDTRA := SubStr(cBuffer,782,1)  //Indicador de Transferencia
		ZZ1->ZZ1_DTTRAN := SubStr(cBuffer,783,10)  //Data da Transferencia
		
		ZZ1->ZZ1_SEQREG := SubStr(cBuffer,889,11)  //Sequencia de ordem
		//		ZZ1->ZZ1_TABERR := SubStr(cBuffer,941,60)  //Tabela de Erro  
		
		
		**'---------------------------------------------'**
		**'-- Marcela Coimbra ----Data: 29/06/2010 -----'**
		**'-INICIO--------------------------------------'**
		
		
		If !Empty( SubStr(cBuffer,1001, 01 ) )          
		
			ZZ1->ZZ1_IDLOGR := SubStr(cBuffer,1001, 01 )
			ZZ1->ZZ1_CODLOG := SubStr(cBuffer,1002, 05 )
			ZZ1->ZZ1_MUNLOG := SubStr(cBuffer,1007, 05 )
			ZZ1->ZZ1_ENDLOG := SubStr(cBuffer,1012, 12 )
			
			FT_FSKIP()			
			cBuffer := FT_FREADLN()
			
			ZZ1->ZZ1_ENDLOG := ZZ1->ZZ1_ENDLOG + SubStr(cBuffer,0, 48 )
			ZZ1->ZZ1_COMLOG := SubStr(cBuffer,049, 60 ) 
			ZZ1->ZZ1_BAILOG := SubStr(cBuffer,109, 20 )
			ZZ1->ZZ1_CITLOG := SubStr(cBuffer,129, 40 )
			ZZ1->ZZ1_ESTLOG := SubStr(cBuffer,169, 02 ) 
			
		EndIf

		**'---------------------------------------------'**
		**'-- Marcela Coimbra ----Data: 29/06/2010 -----'**
		**'-FIM-----------------------------------------'**
		                                        
		
		cAcao := ""
		ZZ1->ZZ1_OPERSI := U_VEROPER(@cAcao)
		ZZ1->ZZ1_DESOPE := cAcao
		
		ZZ1->(MsUnlock())
		
		nRet++
		
	ElseIf cZZ1OPER == '99'   // Grava dados no ar
		M->ZZ0_LINT := SubStr(cBuffer, 1,1000)  //Linha Totalizadora
	EndIf
	
	FT_FSKIP()
	
Enddo

FT_FUSE()

COPY FILE &cFile TO &cFileDest

// Apaga fisicamente arquivo da pasta de origem apos ser copiado.
fErase(cFile)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Fim da Rotina...                                                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Return(nRet)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ CB007EXC   ³ Autor ³ Luzio Tavares     ³ Data ³ 16.05.2006 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Exclui o arquivo e sua composicao                          ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function CB007EXC(cAlias,nReg,nOpc)

Local I__f := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

LOCAL oDlg
LOCAL nOpca   := 0
LOCAL oEnc
LOCAL bOK     := { || nOpca := 1, oDlg:End() }
LOCAL bCancel := { || oDlg:End() }
LOCAL cSeq := ZZ0->ZZ0_SEQUEN
LOCAL cSQL, lDeleta
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define dialogo...                                                   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
DEFINE MSDIALOG oDlg TITLE cCadastro FROM ndLinIni,000 TO ndLinFin,ndColFin OF GetWndDefault()
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Enchoice...                                                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Copy cAlias To Memory

oEnc := ZZ0->(MsMGet():New(cAlias,nReg,K_Visualizar,,,,,{015,004,192,390},,,,,,oDlg,,,.F.))
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Ativa o dialogo...                                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
ACTIVATE MSDIALOG oDlg ON INIT EnchoiceBar(oDlg,bOK,bCancel,.F.,{})
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define tratamento de acordo com a opcao...                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If nOpca == K_OK
	
	if M->ZZ0_STATUS == "3"
		MsgInfo("Nao e possivel excluir pois este arquivo ja foi inserido no BD !")
		lDeleta := .F.
	eLSE
		lDeleta := .T.
	Endif
	
	If lDeleta
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Deleta todas as linhas do arquivo exluido..                         ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		BEGIN TRANSACTION
		
		cSQL := "DELETE FROM " + ZZ1->(RetSQLName("ZZ1"))+" "
		cSQL += "WHERE ZZ1_SEQUEN = '"+cSeq+"' AND D_E_L_E_T_ = ' '"
		PLSSQLEXEC(cSQL)
		
		cSQL := "DELETE FROM " + RetSQLName("ZZ2")+" "
		cSQL += "WHERE ZZ2_SEQUEN = '"+cSeq+"' AND D_E_L_E_T_ = ' '"
		PLSSQLEXEC(cSQL)
		
		ZZ0->(PLUPTENC("ZZ0",K_Excluir))
		END TRANSACTION
	Endif
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Fim da Rotina...                                                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ CB007CRI ³ Autor ³ Luzio Tavares     ³ Data ³ 16.05.2006 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Critica Arquivo ja importado                               ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function CB007CRI(cAlias,nReg,nOpc)

Local n := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

Local aCampos := {}
Local l1vez   := .F.
Local nSeqErro := 0
Local cSeq     := 0
Local cErro := space(0)
Local aErro := {}
Local aArqErro := {}
Local cSql := ""
local cTipCri := ""

// Inicio o processo de criticas
if val(ZZ0->ZZ0_STATUS) <=  2  //"1"  //Permite criticar arquivos importados e/ou criticados
	//
	// Verifica se a sequencia corresponde a esperada
	//
	//	If empty(ZZ0->ZZ0_SEQARQ)
	cSql := "SELECT MAX(Z1.ZZ0_SEQARQ) SEQMAX "
	cSql += " FROM  "+RetSqlName("ZZ0")+" Z1 "
	cSql += " WHERE D_E_L_E_T_=' '"
	cSql += " AND   Z1.ZZ0_FILIAL = '  '"
	cSql += " AND   Z1.ZZ0_CTREMP = '" + ZZ0->ZZ0_CTREMP + "' "
	cSql += " AND   Z1.ZZ0_SEQUEN <> '" +ZZ0->ZZ0_SEQUEN + "' "
	PLsQuery(cSql,"TMPSEQ")
	If !TMPSEQ->(EOF())
		While !TMPSEQ->(EOF())
			cSeq := val(TMPSEQ->SEQMAX) + 1
			TMPSEQ->(DbSkip())
		Enddo
	Endif
	TMPSEQ->(DbCloseArea())
	
	If Val(ZZ0->ZZ0_SEQARQ) <> cSeq
		If !(MsgBox("A sequencia esperada "+STRZERO(cSeq,6)+" difere da processada "+ZZ0->ZZ0_SEQARQ+" , prossegue?","Importação de Arquivo Itau","YESNO"))
			Return
		Endif
	Endif
	//	EndIf
	
	ZZ1->(DbSetOrder(2))
	if ZZ1->(DbSeek(xFilial("ZZ1")+ZZ0->ZZ0_SEQUEN))
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Deleta todas as linhas do arquivo exluido..                         ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		BEGIN TRANSACTION
		
		cSQL := "DELETE FROM " + RetSQLName("ZZ2")+" "
		cSQL += "WHERE ZZ2_SEQUEN = '"+ZZ0->ZZ0_SEQUEN+"' AND D_E_L_E_T_ = ' '"
		PLSSQLEXEC(cSQL)
		
		END TRANSACTION
		
		While !ZZ1->(EOF()) .And. ZZ1->ZZ1_SEQUEN == ZZ0->ZZ0_SEQUEN
			aErro := {}
			cErro := Space(0)
			cDescr := Space(0)
			
			//Iniciar o processo de criticas campo por campo
			
			If At(Alltrim(ZZ1->ZZ1_OPER),'01_02_03_04_05_06') = 0
				cErro := cErro + "001"   //Tipo Operacao Invalido
				aadd(aErro, {ZZ0->ZZ0_SEQUEN, ZZ1->ZZ1_NUMLIN, "001", "Tipo Operacao Invalido"})
			EndIf
			If Type(ZZ1->ZZ1_FUNC) != 'N'
				cErro := cErro + "002"  //Funcional Invalida
				aadd(aErro, {ZZ0->ZZ0_SEQUEN, ZZ1->ZZ1_NUMLIN, "002", "Funcional Invalida"})
			EndIf
			
			If !(alltrim(ZZ1->ZZ1_OPER) $ '01_04') .and. !VerFami(ZZ1->ZZ1_FUNC, ZZ1->ZZ1_OPER)
				cErro := cErro + "003"   //Funcional nao existe na Base
				aadd(aErro, {ZZ0->ZZ0_SEQUEN, ZZ1->ZZ1_NUMLIN, "003", "Funcional nao existe na Base"})
			EndIf
			
			/*
			If !(alltrim(ZZ1->ZZ1_OPER) $ '01_04' .And. VerFunc(ZZ1->ZZ1_FUNC+ZZ1->ZZ1_DEPEND)
			cErro := cErro + "003"   //Funcional nao existe na Base
			aadd(aErro, {ZZ0->ZZ0_SEQUEN, ZZ1->ZZ1_NUMLIN, "003", "Funcional nao existe na Base"})
			EndIf
			*/
			
			If !ZZ1->ZZ1_DEPEND >= '00' .And. !ZZ1->ZZ1_DEPEND <= '99'
				cErro := cErro + "004"   //Codigo Dependente Invalido
				aadd(aErro, {ZZ0->ZZ0_SEQUEN, ZZ1->ZZ1_NUMLIN, "004", "Codigo Dependente Invalido"})
			EndIf
			
			If !(alltrim(ZZ1->ZZ1_OPER) $ '01_04') .and.;
				(!VerFunc(Iif(ZZ1->ZZ1_CDBENE == 'T',ZZ1->ZZ1_FUNC+'00',ZZ1->(ZZ1_FUNC+ZZ1_DEPEND))) .or.;
				!VerBA1(ZZ1->(ZZ1_FUNC+ZZ1_DEPEND), ZZ1->ZZ1_OPER))
				cErro := cErro + "005"  //Codigo Dependente nao Existe na Base
				aadd(aErro, {ZZ0->ZZ0_SEQUEN, ZZ1->ZZ1_NUMLIN, "005", "Codigo Dependente nao Existe na Base"})
			EndIf
			//aadd(aCamposImp[1,2,2,Len(aCamposImp[1,2,2]),6],{"iif((ZZ1->ZZ1_OPER > '01' .and. ZZ1->ZZ1_OPER <> '04'),VerFunc(Iif(ZZ1->ZZ1_CDBENE=='T',ZZ1->ZZ1_FUNC,ZZ1->ZZ1_FUNC+€),ZZ1->ZZ1_CDBENE),.T.)","005"})
			
			//aadd(aCamposImp[1,2,2,Len(aCamposImp[1,2,2]),	marce6],{"iif( ZZ1->ZZ1_OPER == '04',VerFunc(Iif(ZZ1->ZZ1_CDBENE=='T',ZZ1->ZZ1_FUNANT,ZZ1->ZZ1_FUNANT+€),ZZ1->ZZ1_CDBENE),.T.)","005"})
			
			/*
			If alltrim(ZZ1->ZZ1_OPER) # '01' .and. ZZ1->ZZ1_CDBENE != 'T' .and.;
			(!VerFunc(ZZ1->(ZZ1_FUNC+ZZ1_DEPEND),ZZ1->ZZ1_CDBENE,,.T.) .or. !VerBA1(ZZ1->(ZZ1_FUNC+ZZ1_DEPEND)))  //VerFunc(ZZ1->(ZZ1_FUNC+ZZ1_CDBENE))
			//			If ZZ1->ZZ1_OPER == '01' .AND. ZZ1->ZZ1_CDBENE != 'T' .and. !VerFunc(ZZ1->ZZ1_FUNC+'00',ZZ1->ZZ1_CDBENE)
			cErro := cErro + "003"  //Funcional nao existe na Base
			aadd(aErro, {ZZ0->ZZ0_SEQUEN, ZZ1->ZZ1_NUMLIN, "003", "Funcional nao existe na Base"})
			EndIf
			*/
			
			If Empty(AllTrim(ZZ1->ZZ1_BENEF))
				cErro := cErro + "006"  //Nome do Beneficiario Invalido
				aadd(aErro, {ZZ0->ZZ0_SEQUEN, ZZ1->ZZ1_NUMLIN, "006", "Nome do Beneficiario Invalido"})
			EndIf
			//	aadd(aCamposImp[1,2,2,Len(aCamposImp[1,2,2]),6],{"!Type(ZZ1_IDCONV) == 'N'","007"})
			//	aadd(aCamposImp[1,2,2,Len(aCamposImp[1,2,2]),6],{"ZZ1_IDDEPE > ''","008"})
			If Empty(ZZ1->ZZ1_DTNASC)
				cErro := cErro + "009" //Data de Nascimento Invalido
				aadd(aErro, {ZZ0->ZZ0_SEQUEN, ZZ1->ZZ1_NUMLIN, "009", "Data de Nascimento Invalido"})
			EndIf
			If ZZ1->ZZ1_CDBENE != 'T' .and. at(Alltrim(ZZ1->ZZ1_TPPARE),'C_F_T_E_O_P_M_I_H_S_G') == 0
				cErro := cErro + "012"   //Tipo Parentesco Invalido
				aadd(aErro, {ZZ0->ZZ0_SEQUEN, ZZ1->ZZ1_NUMLIN, "012", "Tipo Parentesco Invalido"})
			EndIf
			If At(Alltrim(ZZ1->ZZ1_TPBENE),'01_02_03_04_05_06_07_08_09') == 0
				cErro := cErro + "013"   // Tipo Beneficiario Invalido
				aadd(aErro, {ZZ0->ZZ0_SEQUEN, ZZ1->ZZ1_NUMLIN, "013", "Tipo Beneficiario Invalido"})
			EndIf
			If At(Alltrim(ZZ1->ZZ1_CDBENE),'T_L_A') == 0
				cErro := cErro + "014"  //Condicao Beneficiario Invalido
				aadd(aErro, {ZZ0->ZZ0_SEQUEN, ZZ1->ZZ1_NUMLIN, "014", "Condicao Beneficiario Invalido"})
			EndIf
			If At(Alltrim(ZZ1->ZZ1_SEXO),'F_M') == 0
				cErro := cErro + "015"   //Sexo Invalido
				aadd(aErro, {ZZ0->ZZ0_SEQUEN, ZZ1->ZZ1_NUMLIN, "015", "Sexo Invalido"})
			EndIf
			If At(Alltrim(ZZ1->ZZ1_ESTCIV),'S_C_R_V_M_J') == 0
				cErro := cErro + "016"  //Estado civil invalido
				aadd(aErro, {ZZ0->ZZ0_SEQUEN, ZZ1->ZZ1_NUMLIN, "016", "Estado civil invalido"})
			EndIf                                                                                                  
			
			If  alltrim(ZZ1->ZZ1_OPER) == '01' .and. (u_fCalcIdade(CTOD(zz1->ZZ1_DTNASC)) >= 18 .and. ( Empty(ZZ1->ZZ1_CPF) .or. !chkCPF(ZZ1->ZZ1_CPF) ))
//			If ZZ1->ZZ1_CDBENE == 'T' .and. !chkCPF(ZZ1->ZZ1_CPF)
				cErro := cErro + "017"   //CPF Invalido
				aadd(aErro, {ZZ0->ZZ0_SEQUEN, ZZ1->ZZ1_NUMLIN, "017", "CPF Invalido"})
			End
			
			//aadd(aCamposImp[1,2,2,Len(aCamposImp[1,2,2]),6],{"iif(ZZ1->ZZ1_CDBENE <> 'T',.T.,chPIS(ZZ1_PIS))","018"}) não criticar - Motta
			If ZZ1->ZZ1_CDBENE == 'T'
				If Empty(Alltrim(ZZ1->ZZ1_BANCO))
					cErro := cErro + "019"  //Codigo do Banco Invalido
					aadd(aErro, {ZZ0->ZZ0_SEQUEN, ZZ1->ZZ1_NUMLIN, "019", "Codigo do Banco Invalido"})
				EndIf
				//				If chkBanco(ZZ1_BANCO)
				//					cErro := cErro + "020"  //Codigo do Banco Inexistente
				//					aadd(aErro, {ZZ0->ZZ0_SEQUEN, ZZ1->ZZ1_NUMLIN, "020", "Codigo do Banco Inexistente"})
				//				EndIf
				If Empty(AllTrim(ZZ1->ZZ1_AGENC))
					cErro := cErro + "021"  //Codigo da Agencia Invalido
					aadd(aErro, {ZZ0->ZZ0_SEQUEN, ZZ1->ZZ1_NUMLIN, "021", "Codigo da Agencia Invalido"})
				EndIf
				//				If chkAgencia(ZZ1->ZZ1_BANCO,ZZ1->ZZ1_AGENC)
				//					cErro := cErro + "022"  //Codigo da agencia Inexistente
				//					aadd(aErro, {ZZ0->ZZ0_SEQUEN, ZZ1->ZZ1_NUMLIN, "020", "Codigo da agencia Inexistente"})
				//				EndIf
				If Empty(AllTrim(ZZ1->ZZ1_NUMCC))
					cErro := cErro + "023"  //Numero Conta Corrente Invalido
					aadd(aErro, {ZZ0->ZZ0_SEQUEN, ZZ1->ZZ1_NUMLIN, "023", "Numero Conta Corrente Invalido"})
				EndIf
				
				//Comentado a pedido da Raquel em 25/06/2009 as 16:46 devido ao fato do alexandre do Itau ter dito que a data
				// de admissão não ser obrigatorio
				//				If ZZ1->ZZ1_OPER $ '01_04' .and. Empty(ZZ1->ZZ1_DTADMI)
				//					cErro := cErro + "024"  // Data de Admissao Invalida
				//					aadd(aErro, {ZZ0->ZZ0_SEQUEN, ZZ1->ZZ1_NUMLIN, "024", "Data de Admissao Invalida"})
				//				EndIf
				
				// Comentado por Luzio em 16/01/09, para validar exclusoes que nao sejam operacao igual 03
				//				If !(alltrim(ZZ1->ZZ1_OPER) $ '01') .and. !chkData(ZZ1->ZZ1_FUNC,ZZ1->ZZ1_DEPEND,ZZ1->ZZ1_CDBENE,ZZ1->ZZ1_DTDESL,3) .and. !Empty(ctod(ZZ1->ZZ1_DTDESL))
				//					cErro := cErro + "025"   // Data de Demissao Invalida
				//					aadd(aErro, {ZZ0->ZZ0_SEQUEN, ZZ1->ZZ1_NUMLIN, "025", "Data de Demissao Invalida"})
				//				EndIf
				
			EndIf
			
			//Verifica se o preenchimento do nome da mae causa ou nao a rejeicao do registro dependendo da operação a ser realizada.
			If !chkMae(Alltrim(ZZ1->ZZ1_NOMMAE), ZZ1->(ZZ1_FUNC+ZZ1_DEPEND)) .and. alltrim(ZZ1->ZZ1_OPER) != "03"
				cErro := cErro + "026"
				aadd(aErro, {ZZ0->ZZ0_SEQUEN, ZZ1->ZZ1_NUMLIN, "026", "Nome da Mae Invalido"})
			EndIf
			
			If Empty(AllTrim(ZZ1->ZZ1_CONTR))
				cErro := cErro + "027"  //Codigo do Contrato Invalido
				aadd(aErro, {ZZ0->ZZ0_SEQUEN, ZZ1->ZZ1_NUMLIN, "027", "Codigo do Contrato Invalido"})
			EndIf
			//aadd(aCamposImp[1,2,2,Len(aCamposImp[1,2,2]),6],{"iif(ZZ1->ZZ1_OPER > '01',chkData(ZZ1->ZZ1_FUNC,ZZ1_DTINCT,1),.T.)","029"}) critica retirada - Motta
			
			//			If chkPadrao(ZZ1->ZZ1_PADRAO,ZZ1->ZZ1_OPER,ZZ1->ZZ1_FUNC+ZZ1->ZZ1_DEPEND,DParaTpBnf(ZZ1->ZZ1_CDBENE))  //Verifica em qual produto Saude ira alocar o beneficiario
			If !chkPadrao(ZZ1->ZZ1_PADRAO,ZZ1->ZZ1_OPER,ZZ1->ZZ1_FUNC,ZZ1->ZZ1_DEPEND,DParaTpBnf(ZZ1->ZZ1_CDBENE))  //Verifica em qual produto Saude ira alocar o beneficiario
				cErro := cErro + "028"   //Codigo Padrao Invalido - 0001 - Apartamento, 0002 - Enfermaria
				aadd(aErro, {ZZ0->ZZ0_SEQUEN, ZZ1->ZZ1_NUMLIN, "028", "Codigo Padrao Invalido - 0001 - Apartamento, 0002 - Enfermaria"})
			EndIf
			
			If Empty(Alltrim(ZZ1->ZZ1_NOMEMP))
				cErro := cErro + "033"   //Nome do Orgao Invalido
				aadd(aErro, {ZZ0->ZZ0_SEQUEN, ZZ1->ZZ1_NUMLIN, "033", "Nome do Orgao Invalido"})
			EndIf
			
			//aadd(aCamposImp[1,2,2,Len(aCamposImp[1,2,2]),6],{"ZZ1_ORGAO >''","033"}) - esta critica nao existe - Motta
			If alltrim(ZZ1->ZZ1_OPER) == '03' .and. !chkData(ZZ1->ZZ1_FUNC,ZZ1->ZZ1_DEPEND,ZZ1->ZZ1_CDBENE,ZZ1->ZZ1_DTEXC,3) .and. !Empty(ctod(ZZ1->ZZ1_DTEXC))
				cErro := cErro + "036"   //Data da Exclusao no Plano Invalida
				aadd(aErro, {ZZ0->ZZ0_SEQUEN, ZZ1->ZZ1_NUMLIN, "036", "Data da Exclusao no Plano Invalida"})
			EndIf
			//aadd(aCamposImp[1,2,2,Len(aCamposImp[1,2,2]),6],{"iif(ZZ1->ZZ1_OPER == '03',ZZ1_MOTEXC >'',.T.)","037"}) // critica retirada , sera lancado valor default Paulo Motta 18/01/07
			
			/*
			If !chkData(ZZ1->ZZ1_FUNC,ZZ1->ZZ1_DEPEND,ZZ1->ZZ1_CDBENE,ZZ1->ZZ1_DTINCO,4)  // Melhorar esta critica
			cErro := cErro + "034"   //Data Inclusao Invalida
			aadd(aErro, {ZZ0->ZZ0_SEQUEN, ZZ1->ZZ1_NUMLIN, "034", "Data Inclusao Invalida"})
			EndIf
			*/
			
			//			If !chkData(ZZ1->ZZ1_FUNC,ZZ1->ZZ1_DEPEND,ZZ1->ZZ1_CDBENE,ZZ1->ZZ1_DTINCT,1)
			If !chkData(ZZ1->ZZ1_FUNC,ZZ1->ZZ1_DEPEND,ZZ1->ZZ1_CDBENE,ZZ1->ZZ1_DTINPD,1) .and. AllTrim(ZZ1->ZZ1_OPER) != "03"
				cErro := cErro + "034"   //Data Inclusao Invalida
				aadd(aErro, {ZZ0->ZZ0_SEQUEN, ZZ1->ZZ1_NUMLIN, "034", "Data Inclusao Invalida"})
			EndIf
			
			If Empty(Alltrim(ZZ1->ZZ1_LOGRAD))
				cErro := cErro + "038"   //Logradouro Invalido
				aadd(aErro, {ZZ0->ZZ0_SEQUEN, ZZ1->ZZ1_NUMLIN, "038", "Logradouro Invalido"})
			endIf
			If !chkCEP(ZZ1->ZZ1_CEP)
				cErro := cErro + "039"  //CEP Invalido
				aadd(aErro, {ZZ0->ZZ0_SEQUEN, ZZ1->ZZ1_NUMLIN, "039", "CEP Invalido"})
			EndIf
			/*
			//Desabilitado por Luzio, pois somente deverá ser validado o CEP, sendo o nome da cidade adquirido do BC9
			If !chkCidade(ZZ1->ZZ1_CEP,ZZ1->ZZ1_CIDADE)
			cErro := cErro + "041"   //Nome da Cidade Invalido
			aadd(aErro, {ZZ0->ZZ0_SEQUEN, ZZ1->ZZ1_NUMLIN, "041", "Nome da Cidade Invalido"})
			EndIf
			*/
			//aadd(aCamposImp[1,2,2,Len(aCamposImp[1,2,2]),6],{"iif(ZZ1->ZZ1_DDDRES > '',ZZ1_TELRES>'',.T.)","042"}) - criticas retiradas Motta
			//aadd(aCamposImp[1,2,2,Len(aCamposImp[1,2,2]),6],{"iif(ZZ1_TELRES > '',ZZ1->ZZ1_DDDRES>'',.T.)","043"})
			If !Empty(AllTrim(ZZ1->ZZ1_DDDCOM)) .and. Empty(AllTrim(ZZ1->ZZ1_TELCOM))
				cErro := cErro + "044"   //DDD - Comercial Informado e Telefone Nao Informado
				aadd(aErro, {ZZ0->ZZ0_SEQUEN, ZZ1->ZZ1_NUMLIN, "044", "DDD - Comercial Informado e Telefone Nao Informado"})
			EndIf
			If Empty(Alltrim(ZZ1->ZZ1_DDDCOM)) .and. !Empty(AllTrim(ZZ1->ZZ1_TELCOM))
				cErro := cErro + "045"  //DDD - Comercial Nao Informado e Telefone Informado
				aadd(aErro, {ZZ0->ZZ0_SEQUEN, ZZ1->ZZ1_NUMLIN, "045", "DDD - Comercial Nao Informado e Telefone Informado"})
			EndIf
			If !Empty(AllTrim(ZZ1->ZZ1_RAMAL)) .and. Empty(AllTrim(ZZ1->ZZ1_TELCOM))
				cErro := cErro + "046"   //Ramal Informado e Telefone Nao Informado
				aadd(aErro, {ZZ0->ZZ0_SEQUEN, ZZ1->ZZ1_NUMLIN, "046", "Ramal Informado e Telefone Nao Informado"})
			EndIf
			If !Empty(alltrim(ZZ1->ZZ1_DDDCEL)) .and. Empty(alltrim(ZZ1->ZZ1_TELCEL))
				cErro := cErro + "047"   //DDD - Celular Informado e Telefone nao Informado
				aadd(aErro, {ZZ0->ZZ0_SEQUEN, ZZ1->ZZ1_NUMLIN, "047", "DDD - Celular Informado e Telefone nao Informado"})
			EndIf
			If !Empty(alltrim(ZZ1->ZZ1_TELCEL)) .and. Empty(Alltrim(ZZ1->ZZ1_DDDCEL))
				cErro := cErro + "048"   //DDD - Celular Nao Informado e Telefone Informado
				aadd(aErro, {ZZ0->ZZ0_SEQUEN, ZZ1->ZZ1_NUMLIN, "048", "DDD - Celular Nao Informado e Telefone Informado"})
			EndIf
			//aadd(aCamposImp[1,2,2,Len(aCamposImp[1,2,2]),6],{"iif(ZZ1->ZZ1_OPER == '04' ,VerFunc(ZZ1_FUNANT+ZZ1->ZZ1_DEPEND),.T.)","003"})
			
			If alltrim(ZZ1->ZZ1_OPER) == '04'
				If Empty(Alltrim(ZZ1->ZZ1_FUNANT))
					cErro := cErro + "063"  //funcional Anterior Invalida
					aadd(aErro, {ZZ0->ZZ0_SEQUEN, ZZ1->ZZ1_NUMLIN, "063", "Funcional Anterior Invalida"})
				Else
					If (!VerFunc(ZZ1->(ZZ1_FUNANT+ZZ1_DEPEND)) .or. !VerBA1(ZZ1->(ZZ1_FUNANT+ZZ1_DEPEND), ZZ1->ZZ1_OPER))
						cErro := cErro + "064"  //funcional Anterior nao existe na base
						aadd(aErro, {ZZ0->ZZ0_SEQUEN, ZZ1->ZZ1_NUMLIN, "064", "Funcional Anterior nao existe na base"})
						//					Else
						//						cErro := cErro + "065"  //Funcional Ja existe na base
						//						aadd(aErro, {ZZ0->ZZ0_SEQUEN, ZZ1->ZZ1_NUMLIN, "065", "Funcional Ja existe na base"})
					EndIf
				EndIf
			EndIf
			
			//			If alltrim(ZZ1->ZZ1_OPER) == '01' .and. !VerFunc(ZZ1->ZZ1_FUNC+ZZ1->ZZ1_DEPEND,ZZ1->ZZ1_CDBENE,nil,.T.)
			//			If alltrim(ZZ1->ZZ1_OPER) == '01' .and. VerFunc(ZZ1->ZZ1_FUNC+ZZ1->ZZ1_DEPEND,ZZ1->ZZ1_CDBENE,nil,.F.)
			If alltrim(ZZ1->ZZ1_OPER) == '01_06' .and. ExeBA1(ZZ1->(ZZ1_FUNC+ZZ1_DEPEND),'01')
				cErro := cErro + "065"  //Funcional Ja existe na base
				aadd(aErro, {ZZ0->ZZ0_SEQUEN, ZZ1->ZZ1_NUMLIN, "065", "Funcional Ja existe na base"})
			EndIf
			
			nSeqErro := 0
			If Len(aErro) > 0
				For n = 1 to Len(aErro)
					nSeqErro += 1
					aadd(aArqErro, {aErro[n,1],aErro[n,2], StrZero(nSeqErro,3), aErro[n,3],aErro[n,4]})
					ZZ2->(RecLock("ZZ2",.T.))
					ZZ2->ZZ2_SEQUEN := aErro[n,1]
					ZZ2->ZZ2_NUMLIN := aErro[n,2]
					ZZ2->ZZ2_SEQERR := StrZero(nSeqErro,3)
					ZZ2->ZZ2_CODERR := aErro[n,3]
					ZZ2->ZZ2_DESERR := aErro[n,4]
					ZZ2->(MsUnlock())
				Next
			EndIf
			
			//			If !Empty(AllTrim(cErro))
			//				if Len(AllTrim(ZZ1->ZZ1_TABERR)) < 57
			ZZ1->(RecLock("ZZ1",.F.))
			ZZ1->ZZ1_TABERR := cErro
			cAcao := ""
			ZZ1->ZZ1_OPERSI := U_VEROPER(@cAcao)
			ZZ1->ZZ1_DESOPE := cAcao
			ZZ1->(MsUnlock())
			//				Endif
			//			EndIf
			
			ZZ1->(dbSkip())
			
		Enddo
		
		If Len(aArqErro) > 0
			cArqOut := Substr(cPath+AllTRim(ZZ0->ZZ0_NOMARQ),1,Len(AllTRim(ZZ0->ZZ0_NOMARQ))- At(Alltrim(ZZ0->ZZ0_NOMARQ),"."))+".ret"
			nHOut := FCreate(cArqOut)
			For N := 1 to Len(aArqErro)
				cLinha := aArqErro[n,1]+aArqErro[n,2]+aArqErro[n,3]+aArqErro[n,4]
				fWrite(nHOut,cLinha+ Chr(13) + Chr(10),Len(cLinha)+2)
				cLinha := ""
			Next N
			fClose(nHOut)
		EndIf
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Mudo o status do arquivo colocando como criticado                     ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		ZZ0->(RecLock("ZZ0",.F.))
		ZZ0->ZZ0_STATUS := "2"
		ZZ0->ZZ0_DTCRIT := dDatabase
		//		If Empty(ZZ0->ZZ0_SEQARQ)
		//			ZZ0->ZZ0_SEQARQ := STRZERO(cSeq,6)
		//		EndIf
		ZZ0->(MsUnlock())
		
	Endif
	
Else
	MsgInfo("Somente e possivel criticar arquivos com status importado!")
Endif
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Fim da Rotina...                                                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Return


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±±
±±³Funcao    ³ CB007LEG ³ Autor ³ Wagner Mobile Costa ³ Data ³ 28.08.03 ³±±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±±
±±³Descricao ³ Exibe a legenda...                                         ³±±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function CB007LEG(nTipo)
Local aLegenda

if nTipo == 1
	aLegenda := { 	{ aCdCores[1,1],aCdCores[1,2] },;
	{ aCdCores[2,1],aCdCores[2,2] },;
	{ aCdCores[3,1],aCdCores[3,2] },;
	{ aCdCores[4,1],aCdCores[4,2] }  }
Else
	aLegenda := { 	{ aCdCores[1,1],aCdCores[1,2] },;
	{ aCdCores[2,1],aCdCores[2,2] }}
Endif

BrwLegenda(cCadastro,"Status" ,aLegenda)

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±±
±±³Funcao    ³ CB007CMP ³ Autor ³ Luzio Tavares       ³ Data ³ 28.08.03 ³±±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±±
±±³Descricao ³ Mostra Composicao do Arquivo                               ³±±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function CB007CMP()
Private aFilAdic := {.T.,"('01','02')"}
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta matriz com as opcoes do browse...                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
PRIVATE aRotina   	:=	{	{ "Pesquisar" , 'AxPesqui'	    , 0 , K_Pesquisar  },;
{ "Visualizar", 'AxVisual'	    , 0 , K_Visualizar },;
{ "Erros"     , 'U_LOGERRO'	 , 0 , K_Visualizar },;
{ "Legenda"   , "U_CBIMPLEG(2)", 0 , K_Incluir    } }

PRIVATE cAlias   := "ZZ1"
PRIVATE cChave   := ZZ0->(ZZ0_SEQUEN)
PRIVATE aCdCores := { 	{ 'BR_VERDE'    ,'Linha OK' },{ 'BR_VERMELHO'     ,'Linha Criticada' }}
//PRIVATE aCores   := { { 'Empty(AllTrim(ZZ1_TABERR)) = ""',aCdCores[1,1] },{ 'AllTrim(ZZ1_TABERR) > ""',aCdCores[2,1] }}
PRIVATE aCores   := { { 'Empty(AllTrim(ZZ1_TABERR))',aCdCores[1,1] },{ '!Empty(AllTrim(ZZ1_TABERR))',aCdCores[2,1] }}

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Chama funcao de Browse...                                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
#IFDEF TOP
	PRIVATE cFil := "@ZZ1_FILIAL = '"+xFilial("ZZ1")+"'"
	cFil += " AND ZZ1_SEQUEN = '"+ZZ0->ZZ0_SEQUEN+"' AND D_E_L_E_T_ = ' '"
#ELSE
	PRIVATE cFil := "ZZ1_FILIAL = '"+xFilial("ZZ1")+"'"
	cFil += " .AND. ZZ1_SEQUEN = '"+ZZ0->ZZ0_SEQUEN+"'"
#ENDIF

ZZ1->(DBSetOrder(1))
DbSelectArea("ZZ1")
SET FILTER TO &cFil

ZZ1->(mBrowse(006,001,022,075,"ZZ1" ,nil ,nil ,nil ,nil , 4    , aCores,nil ,nil ,nil ,,.T.,nil))
ZZ1->(DbClearFilter())

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Fim da Rotina...                                                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//Processa( { || Executa() }, 'Processando...', '', .T. )
Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±±
±±³Funcao    ³ VerFunc    ³ Autor ³ Antonio de Padua    ³ Data ³ 16.05.06 ³±±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±±
±±³Descricao ³ Verifica o cadastro de uma Matricula funcional             ³±±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function VerFunc(cMatric,cTipo,cDepend,lvArq)
Local nOrdBA1 := BA1->(IndexOrd())
Local lRet    := .T.
Local nOrd    := ZZ1->(IndexOrd())
Local nRecno  := ZZ1->(Recno())

If cTipo <> "T" .And. !lvArq  //se for inclusao de beneficiario novo ou uma reativacao de beneficario excluido anteriormente
	ZZ1->(DbSetOrder(3))
	If ZZ1->(DbSeek(xFilial("ZZ1")+cMatric))
		ZZ1->(dbSetOrder(nOrd))
		ZZ1->(dbgoto(nRecno))
		Return(.T.)
	Endif
Endif

ZZ1->(dbSetOrder(nOrd))
ZZ1->(dbgoto(nRecno))

BA1->(dbSetOrder(6))
If !BA1->(DbSeek(xFilial("BA1")+cMatric))
	// 	If dParaTpBnf(cTipo) == BA1->BA1_TIPUSU .and. alltrim(ZZ1->ZZ1_OPERSI) # "01_02"  ///alltrim(ZZ1->ZZ1_OPER) != '01'
	lRet := .F.
	//	   EndIf
EndIf
BA1->(dbSetOrder(nOrdBA1))

Return(lRet)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±±
±±³Funcao    ³ VerFam     ³ Autor ³ Luzio Tavares       ³ Data ³ 16.01.09 ³±±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±±
±±³Descricao ³ Verifica se a funcional esta cadastra no BA3               ³±±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function VerFami(cMatric, cTipo )
Local nOrdBA3 	:= BA3->(IndexOrd())
Local lRet    	:= .F.     
Local c_MaxMat 	:= ""

BA3->(dbSetOrder(5))
If BA3->(dbSeek(xFilial("BA3")+ZZ0->ZZ0_CODEMP+cMatric))

	While !BA3->( EOF() ) .AND. AllTrim( BA3->BA3_CODEMP + BA3->BA3_MATEMP ) == AllTrim( ZZ0->ZZ0_CODEMP+cMatric )
	
			If 	(	Empty( BA3->BA3_DATBLO ) 	.and. 	cTipo <> '03'	) .or.;
				(	cTipo == '03' 				.and. 	BA3->BA3_CODEMP + BA3->BA3_MATRIC >  c_MaxMat)  
				
				c_MaxMat := BA3->BA3_CODEMP + BA3->BA3_MATRIC
			
				lRet := .T.	
			     
			EndIf 
			
			BA3->( dbSkip() ) 
	
	EndDo
	
EndIf
BA3->(dbSetOrder(nOrdBA3))

Return(lRet)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±±
±±³Funcao    ³ VerBA1     ³ Autor ³ Luzio Tavares       ³ Data ³ 01.12.08 ³±±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±±
±±³Descricao ³ Verifica a existencia do beneficiario no BA1 atraves da    ³±±±
±±³          ³ Matricula Funcional+Dependencia Itau                       ³±±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function VerBA1(cMatric,cTipo)
Local nOrdBA1 := BA1->(IndexOrd())
Local lRet    := .F.     
Local c_MaxMat:= ""

BA1->(dbSetOrder(6))
If BA1->(DbSeek(xFilial("ZZ1")+cMatric))   

	While !BA1->( EOF() ) .AND. AllTrim(  BA1->BA1_MATEMP ) == AllTrim( cMatric )
	
			If 	ZZ0->ZZ0_CODEMP == BA1->BA1_CODEMP .AND. ( ;
				(	Empty( BA1->BA1_DATBLO ) 	.and. 	cTipo <> '03'	) .or.;
				(	cTipo == '03' 				.and. 	BA1->BA1_CODEMP + BA1->BA1_MATRIC + BA1->BA1_TIPREG >  c_MaxMat)   )
				
				c_MaxMat:= BA1->BA1_CODEMP + BA1->BA1_MATRIC + BA1->BA1_TIPREG
			                                      	
				lRet	:= .T.	
			     
			EndIf 
			
			BA1->( dbSkip() ) 
	
	EndDo

	lRet := .T.
EndIf
////If !Empty(BA1->BA1_DATBLO) .or. !Empty(BA1->BA1_MOTBLO)
//If !Empty(BA1->BA1_DATBLO) .and. !Empty(BA1->BA1_MOTBLO)  //alterado pelo Luzio para que nao rejeite se estiver apenas com um dos campos preenchidos
//	lRet := .F.
//EndIf
BA1->(dbSetOrder(nOrdBA1))

Return(lRet)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±±
±±³Funcao    ³ ExeBA1     ³ Autor ³ Luzio Tavares       ³ Data ³ 01.12.08 ³±±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±±
±±³Descricao ³ Verifica a existencia do beneficiario no BA1 atraves da    ³±±±
±±³          ³ Matricula Funcional+Dependencia Itau                       ³±±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ExeBA1(cMatric,cOper)
Local nOrdBA1 := BA1->(IndexOrd())
Local lRet    := .F.

BA1->(dbSetOrder(6))
If BA1->(DbSeek(xFilial("ZZ1")+cMatric)) .and. (!Empty(BA1->BA1_DATBLO) .or. !Empty(BA1->BA1_MOTBLO))
	lRet := .T.
EndIf
BA1->(dbSetOrder(nOrdBA1))

Return(lRet)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±±
±±³Funcao    ³ ChkData    ³ Autor ³ Antonio de Padua    ³ Data ³ 16.05.06 ³±±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±±
±±³Descricao ³ Checa a Data olhando no cadastro                           ³±±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function chkData(cMatric,cDepend,cCdbene,cData,nTipo)
If !Empty(Alltrim(cMatric)) .and. cMatric != NIL
	BA3->(dbSetOrder(5))
	If BA3->(dbSeek(xFilial("BA1")+ZZ0->ZZ0_CODEMP+cMatric))
		If nTipo == 1 .or. nTipo == 2     //Inclusao
			Return(ctod(cData) >= BA3->BA3_DATBAS)
		Elseif nTipo == 2
			Return(ctod(cData) >= BA3->BA3_DATBAS)
		Elseif nTipo == 3     // para o caso de exclusao
			If cCdbene == 'T'
				Return(ctod(cData) >= BA3->BA3_DATBAS)        //Data da Exclusao maior que a data de cadastrammento da familia (Se for maior retorna .T., se for menor retorna .F.)
			Else
				BA1->(dbSetOrder(6))
				if BA1->(dbSeek(xFilial("BA1")+cMatric+cDepend))
					Return(ctod(cData) >= BA1->BA1_DATINC)     // Verificar se a data de bloqueio eh menor que a data de inclusao do beneficiario no contrato/produto
				EndIf
			EndIf
		Endif
	Endif
Else
	//	  Return(dtoc(ctod(cData) <> "  /  /  "))
	Return(.F.)
Endif
Return(.T.)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±±
±±³Funcao    ³ ChkBanco   ³ Autor ³ Antonio de Padua    ³ Data ³ 16.05.06 ³±±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±±
±±³Descricao ³ Checa o banco olhando no cadastro                          ³±±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function chkBanco(cBanco,nTipo)
// Aceitando Sempre True por causa do Itau
Return(.T.)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±±
±±³Funcao    ³ ChkCEP     ³ Autor ³ Antonio de Padua    ³ Data ³ 17.05.06 ³±±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±±
±±³Descricao ³ Checa o CEP olhando no cadastro                            ³±±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function chkCEP(cCEP)
if At("-",cCep) > 0
	cCep := Substr(cCep,1,5)+Substr(cCep,7,3)
Endif
BC9->(DbSetOrder(1))
if ! BC9->(DbSeek(xFilial("BC9")+cCEP))
	Return(.T.)   //Return(.F.)
Endif
Return(.T.)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±±
±±³Funcao    ³ ChkCidade  ³ Autor ³ Antonio de Padua    ³ Data ³ 17.05.06 ³±±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±±
±±³Descricao ³ Checa a Cidade olhando no cadastro                         ³±±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function chkCidade(cCep,cCidade,nTipo)
Local cRetorno

if At("-",cCep) > 0
	cCep := Substr(cCep,1,5)+Substr(cCep,7,3)
Endif
BC9->(DbSetOrder(1))
If nTipo == 1   //Valida se existe a cidade
	If !BC9->(DbSeek(xFilial("BC9")+cCEP))
		If Alltrim(cCidade) != Alltrim(BC9->BC9_MUN)
			Return(.T.)   //Return(.F.)
		Endif
	Endif
	cRetorno := .T.
Else  //busca o nome da cidade
	if BC9->(DbSeek(xFilial("BC9")+cCEP))
		cRetorno :=Alltrim(BC9->BC9_MUN)
	EndIf
EndIf
Return(cRetorno)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±±
±±³Funcao    ³ ChkPadrao  ³ Autor ³ Antonio de Padua    ³ Data ³ 17.05.06 ³±±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±±
±±³Descricao ³ Verifica qual produto saude ira alocar para o beneficiario ³±±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function chkPadrao(cPadrao,cOper,cMatric,cCdDepe,cTpBnf)
Local lDiferente := .F.
Local nOrdBA1 := BA1->(IndexOrd())
Local lRet := .T.

cTempPadrao := ""

if Empty(AllTrim(cPadrao))
	Return(.F.)
Endif
If Alltrim(cOper) == "03"
	Return(.T.)
Endif
If Empty(AllTrim(cMatric))
	Return(.F.)
EndIf

	if ZZ0->ZZ0_CODEMP == "0006"  // Itau
	if ! (cPadrao $ "0109_0208_0307_0406")
		Return (.F.)
	Endif
else
	//tornar genérica
	cSql := "SELECT DISTINCT BT6_CODPRO
	cSql += " FROM  "+RetSqlName("BT6")+" BT6 "
	cSql += " WHERE D_E_L_E_T_=' '
	cSql += " AND BT6_CODINT="+ZZ0->ZZ0_CODOPE
	cSql += " AND BT6_NUMCON="+ZZ0->ZZ0_NUMCON
	cSql += " AND BT6_SUBCON="+ZZ0->ZZ0_SUBCON
	cSql += " AND BT6_CODIGO="+ZZ0->ZZ0_CODEMP
	PLsQuery(cSql,"TMPBT6")
	
	If !TMPBT6->(EOF())
		While !TMPBT6->(EOF())
			cTempPadrao := cTempPadrao + TMPBT6->BT6_CODPRO + "_"
			TMPBT6->(DbSkip())
		Enddo
	Endif
	cTempPadrao := Substr(cTempPadrao,1,Len(cTempPadrao)-1)
	TMPBT6->(DbCloseArea())
	
	if !(cPadrao $ cTempPadrao)  // Se nao encontrou o produto para o referido grupo empresa
		Return (.F.)
	Endif
Endif

//Busca o produto na familia
//Somente quando for operacao diferente de inclusao ou transferencia
//Deve verificar somente para os caso de inclusao, transferencia entre planos, trasnferencia entre operadoras, mas somente para dependentes.
If !(alltrim(cOper) $ "01")   //.and. ZZ1->ZZ1_CDBENE != "A"
	BA3->(dbSetOrder(5))
	If BA3->(dbSeek(xFilial("BA3")+ZZ0->ZZ0_CODEMP+cMatric))
		While !BA3->(Eof()) .and. BA3->(BA3_FILIAL+BA3_CODEMP+BA3_CODEMP) == xFilial("BA3")+ZZ0->ZZ0_CODEMP+cMatric
			If Empty(BA3->BA3_DATBLO)
				If BA3->BA3_CODPLA <> dParaPrd(cPadrao,cTpBnf)
					lRet := .F.
				Else
					lRet := .T.
				EndIf
			Endif
			BA3->(DbSkip())
		EndDo
	EndIf
Endif

/*
//If !(alltrim(ZZ1->ZZ1_OPER) $ "01_04_05") .and. ZZ1->ZZ1_DEPEND != "00"   // Somente para dependentes
If !(alltrim(cOper) $ "01_04_05")
If !Empty(AllTrim(cMatric))
BA1->(dbSetOrder(6))
If BA1->(DbSeek(xFilial("BA1")+Alltrim(cMatric)+Alltrim(cCdDepe)))
While !BA1->(Eof()) .and. BA1->BA1_FILIAL+alltrim(BA1->BA1_MATEMP) == xFilial("BA1")+Alltrim(cMatric)+Alltrim(cCdDepe)
If Empty(BA3->BA3_DATBLO)
If BA1->BA1_CODPLA <> dParaPrd(cPadrao,cTpBnf) .and. BA1->BA1_TIPUSU == DParaTpBnf(ZZ1->ZZ1_CDBENE)
Return(.F.)
EndIf
EndIf
BA1->(DbSkip())
EndDo
EndIf
BA1->(dbSetOrder(nOrdBA1))

/*
BA3->(dbSetOrder(5))
If BA3->(dbSeek(xFilial("BA3")+ZZ0->ZZ0_CODEMP+cMatric))
While !BA3->(Eof()) .and. BA3->(BA3_FILIAL+BA3_CODEMP+BA3_CODEMP) == xFilial("BA3")+ZZ0->ZZ0_CODEMP+cMatric
If Empty(BA3->BA3_DATBLO)
If BA3->BA3_CODPLA <> dParaPrd(cPadrao,cTpBnf)
lDiferente := .T.
Else
lDiferente := .F.
EndIf
EndIf
BA3->(DbSkip())
EndDo

If Alltrim(ZZ1->ZZ1_OPER) $ "02"
ZZ1->(RecLock("ZZ1",.F.))
ZZ1->ZZ1_OPERSI := "06"
ZZ1->ZZ1_DESOPE := "ALTERACAO DE PLANO / PRODUTO"
ZZ1->(MsUnlock())
Else
Return(.F.)
EndIf
Endif
EndIf
Endif
Endif
Endif
*/
Return(lRet)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³DParaPrd  ºAutor  ³Antonio de Padua    º Data ³  17/05/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Retorna o Depara dos Produtos ITAU                         º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function dParaPrd(cPadrao,cTipo)
cProduto := ""
if cPadrao == "0109"
	if cTipo == "A"
		cProduto := "0017"
	Else
		cProduto := "0013"
	Endif
Elseif cPadrao == "0208"
	if cTipo == "A"
		cProduto := "0016"
	Else
		cProduto := "0012"
	Endif
Elseif cPadrao == "0307"
	if cTipo == "A"
		cProduto := "0015"
	Else
		cProduto := "0011"
	Endif
Elseif cPadrao == "0406"
	if cTipo == "A"
		cProduto := "0014"
	Else
		cProduto := "0010"
	Endif
Endif

Return(cProduto)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³DParaTpBnfºAutor  ³Antonio de Padua    º Data ³  17/05/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Retorna o Depara dos Tipos de Benef ITAU                   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function DParaTpBnf(cTipo)
if cTipo == "L"   //Legal
	cTipo := "D"
Endif                   



/* Apenas para gravacao pois o Agregado eh marcado como T (Titular) */
//If cTipo == "A"   //Agregado
//	cTipo := "T"
//Endif

Return(cTipo)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³DPTpBnfbd   ºAutor  ³Paulo Motta         º Data ³  17/05/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Retorna o Depara dos Tipos de Benef ITAU (apenas para gra-   º±±
±±º          ³ vacao pois o Agregado e marcado como T (titular)             º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                           º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function DPTpBnfbd(cTipo)
if cTipo == "L"
	cTipo := "D"
Endif
/*apenas para gravacao pois o Agregado e marcado como T (titular) */
If cTipo == "A"
	cTipo := "T"
Endif

Return(cTipo)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³DParaBlq  ºAutor  ³Antonio de Padua    º Data ³  18/05/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Retorna o Depara dos Bloqueios de Benef ITAU               º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function DParaBlq(cBlq)

cBlq := "017"

if cBlq == "001"
	cBlq := "018"
Elseif cBlq == "002"
	cBlq := "018"
Elseif cBlq == "003"
	cBlq := "020"
Elseif cBlq == "004"
	cBlq := "003"
Elseif cBlq == "005"
	cBlq := "001"
Elseif cBlq == "006"
	cBlq := "019"
Elseif cBlq == "007"
	cBlq := "006"
Elseif cBlq == "008"
	cBlq := "019"
Elseif cBlq == "999"
	cBlq := "017"
Endif

Return(cBlq)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³DParaGrauPºAutor  ³Antonio de Padua    º Data ³  17/05/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Retorna o Depara dos Graus de Parentescos                  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function DParaGrauP(cGrauPa,cSexo)
cGrauPa := AllTrim(cGrauPa)
if cGrauPa == ""
	cGrauPa := "01"
Elseif cGrauPa == "C"   //Conjuge
	if cSexo == "1"
		cGrauPa := "04"
	Else
		cGrauPa := "02"
	Endif
Elseif cGrauPa == "F"   //Filho
	if cSexo == "1"
		cGrauPa := "05"
	Else
		cGrauPa := "06"
	Endif
Elseif cGrauPa == "T"   //
	cGrauPa := "23"
Elseif cGrauPa == "E"   //Enteado
	cGrauPa := "24"
Elseif cGrauPa == "O"   //
	cGrauPa := "11"
Elseif cGrauPa == "P"   //Pai
	cGrauPa := "07"
Elseif cGrauPa == "M"   //Mae
	cGrauPa := "08"
Elseif cGrauPa == "I"   //Irmao
	cGrauPa := "14"
Elseif cGrauPa == "H"
	cGrauPa := "03"
Elseif cGrauPa == "S"
	cGrauPa := "09"
Elseif cGrauPa == "G"
	cGrauPa := "10"
Endif
Return(cGrauPa)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±±
±±³Funcao    ³ ChkMae     ³ Autor ³ Luzio Tavares     ³ Data ³ 12.12.2008 ³±±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±±
±±³Descricao ³ Checa para ver se o nome da mae eh obrigatorio ou nao se se³±±±
±±³          ³ causa rejeicao da operacao a ser realziada no registro     ³±±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function chkMae(cNomMae,cMatric)

If !Empty(Alltrim(cNomMae)) .and. cNomMae != NIL
	Return(.T.)
Else
	If !(Alltrim(ZZ1->ZZ1_OPER) == "03")   //fatal. E necessario o nome da mae
		Return(.F.)
	Else
		BA1->(dbSetOrder(6))
		if BA1->(dbSeek(xFilial("BA1")+cMatric)) .and. !Empty(BA1->BA1_MAE)
			Return(.T.)
		Else
			Return(.F.)
		EndIf
	Endif
EndIf
Return(.T.)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³IncluiUsr ºAutor  ³Antonio de Padua    º Data ³  18/05/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Funcao que trata a linha tipo inclusao                     º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function IncluiUsr(cCobRetro)
Local lTitCad := .F.
Local lUsuCad := .F.
Local cMatTit := ""
Local cMatUsr := ""
Local lFamCad := .F.
Private lTit    := .F.
Private lAgr    := .F. // 10/07/07
Private cNumCon := ""
Private cSubCon := ""
Private cNovaMatric := ""

lTit := ZZ1->ZZ1_CDBENE == 'T'
lAgr := ZZ1->ZZ1_CDBENE == 'A' // 10/07/07

if lAgr                                                                // 10/07/07
	
	cNovaMatric := PLPROXMAT(ZZ0->ZZ0_CODOPE,ZZ0->ZZ0_CODEMP)           // 10/07/07    
	
else 

	BA3->(dbSetOrder(5))   
	if (BA3->(dbSeek(xFilial("BA3")+ZZ0->ZZ0_CODEMP+ZZ1->ZZ1_FUNC)))    
	
	 While !BA3->( EOF() ) .AND. AllTrim( BA3->BA3_CODEMP + BA3->BA3_MATEMP ) == AllTrim( ZZ0->ZZ0_CODEMP+ZZ1->ZZ1_FUNC )

		If Empty( BA3->BA3_DATBLO ) 
		
			lFamCad := .T.  
			
			Exit
					
		EndIf
	 
		BA3->( dbSkip() ) 
			
	 EndDo
	 
	EndIf
	
	If !lFamCad
	
		cNovaMatric := PLPROXMAT(ZZ0->ZZ0_CODOPE,ZZ0->ZZ0_CODEMP)
	
	Endif

Endif

BA1->(dbSetOrder(6))
if (BA1->(dbSeek(xFilial("BA1")+ZZ1->ZZ1_FUNC+ZZ1->ZZ1_DEPEND)))    

	While !BA1->( EOF() ) .AND. AllTrim( BA1->BA1_MATEMP ) == ZZ1->ZZ1_FUNC+ZZ1->ZZ1_DEPEND

		If Empty( BA1->BA1_DATBLO )  
		
			lUsuCad := .T.
			cMatUsr := BA1->BA1_CODINT+BA1->BA1_CODEMP+BA1->BA1_MATRIC+BA1->BA1_TIPREG
			
		EndIf     
		
		BA1->( dbSkip() )
		
	EndDo

Endif

if !lFamCad  // Familia Nao Cadastrada, deve-se cadastrar
	// Verifico o Contrato Selecionado para encontrar produto
	if AllTrim(ZZ0->ZZ0_CTREMP) == "01115"
		cNumCon := "000000000001"
	Elseif AllTRim(ZZ0->ZZ0_CTREMP) == "01123"
		cNumCon := "000000000002"
		//tornar genérica
	Elseif AllTRim(ZZ0->ZZ0_CODEMP) <> "0006"
		cNumCon := ZZ0->ZZ0_NUMCON
		//tornar genérica
	Endif
	
	cSql := "SELECT * FROM "+RetSqlName("BQC")+" Where BQC_CODIGO = '"+ZZ0->ZZ0_CODOPE+ZZ0->ZZ0_CODEMP+"'"
	cSql += " AND BQC_NUMCON = '"+cNumCon+"'"
	cSql += " AND BQC_VERCON = '001' "
	cSql += " AND BQC_ANTCON = '"+ZZ1->ZZ1_CODEMP+"' AND D_E_L_E_T_ = ' '"
	PLsQuery(cSql,"TMPBQC")
	If !TMPBQC->(EOF())
		While !TMPBQC->(EOF())
			BT0->(DbSetOrder(1))
			lPode   := .F.
			//cSubCon := ""
			if BT0->(DbSeek(xFilial("BT0")+ZZ0->ZZ0_CODOPE+ZZ0->ZZ0_CODEMP+cNumCon+"001"+TMPBQC->BQC_SUBCON+TMPBQC->BQC_VERSUB+dParaPrd(ZZ1->ZZ1_PADRAO,dParaTpBnf(ZZ1->ZZ1_CDBENE))+"001"))
				lPode   := .T.
				While !BT0->(EOF()) .And. BT0->(BT0_FILIAL+BT0_CODIGO+BT0_NUMCON+BT0_VERCON+BT0_SUBCON+BT0_VERSUB+BT0_CODPRO+BT0_VERSAO) == ZZ0->ZZ0_FILIAL+ZZ0->ZZ0_CODOPE+ZZ0->ZZ0_CODEMP+cNumCon+"001"+TMPBQC->BQC_SUBCON+TMPBQC->BQC_VERSUB+dParaPrd(ZZ1->ZZ1_PADRAO,dParaTpBnf(ZZ1->ZZ1_CDBENE))+"001"
					if BT0->BT0_TIPUSR == dParaTpBnf(ZZ1->ZZ1_CDBENE) .And. BT0->BT0_ATIVO == "1"
						lPode := .T.
					Elseif BT0->BT0_TIPUSR == DParaTpBnf(ZZ1->ZZ1_CDBENE) .And. BT0->BT0_ATIVO == "2"
						lPode := .F.
					Endif
					BT0->(DbSkip())
				Enddo
			Endif
			if lPode
				cSubCon := TMPBQC->BQC_SUBCON
			Endif
			TMPBQC->(DbSkip())
		Enddo
	Endif
	TMPBQC->(DbCloseArea())
	
	//TORNAR GENÉRICA
	
	if ALLTRIM(ZZ0->ZZ0_CODEMP)<>"0006"
		cSubCon := ZZ0->ZZ0_SUBCON
	endif
	
	
	if cSubCon == ""
		cSubCon := "000000001" // 18/5/07
	endif
	
	BI3->(DbSetOrder(1))
	if BI3->(DbSeek(xFilial("BT6")+BT6->BT6_CODINT+dParaPrd(ZZ1->ZZ1_PADRAO,dParaTpBnf(ZZ1->ZZ1_CDBENE))+"001"))
		lFamCad := .T.
		BA3->(RecLock("BA3",.T.))
		PreBA3(1,.T.)
		BA3->(MsUnlock())
	Endif
Endif

if ! lUsuCad .And. lFamCad /// Esse usuario nao esta cadastrado
	
	BTS->(RecLock("BTS",.T.))
	PreBTS(1,lTit,.T.)
	BTS->(MsUnlock())
	
	BA1->(RecLock("BA1",.T.))
	PreBA1(1,lTit,.T.,cCobRetro)
	BA1->(MsUnlock())
Endif

if lFamCad
	AtuProd()
	AtuOpc()
	AtuAdesao()
Endif
Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³AlteraUsr ºAutor  ³Antonio de Padua    º Data ³  18/05/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Funcao que trata a linha tipo Alteracao                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function AlteraUsr(nTipo, nMatric)
Local lTit := .F.
Local cChave := ZZ1->ZZ1_FUNC   
Local cXXEmp:= ""

If nMatric <> NIL
	cChave := ZZ1->ZZ1_FUNANT
EndIf

lTit := ZZ1->ZZ1_CDBENE == 'T'   //Se o beneficiario for o Titular do contrato

c_MaxMat := ""

BA3->(dbSetOrder(5))
if BA3->(dbSeek(xFilial("BA3")+ZZ0->ZZ0_CODEMP+cChave)) .And. lTit  //Somente se o beneficiario for o Titular do contrato

    While !BA3->( EOF() ) .AND. AllTrim( BA3->BA3_CODEMP + BA3->BA3_MATEMP ) == AllTrim( ZZ0->ZZ0_CODEMP+cChave )

		If Empty( BA3->BA3_DATBLO ) .and. nTipo <> 3 
		
			BA3->(RecLock("BA3",.F.)) 
	
			PreBA3(nTipo,.F.)
	
			BA3->(MsUnlock())  
			
			exit  
			
		ElseIf nTipo == 3 
		
			If BA3->BA3_CODEMP + BA3->BA3_MATRIC >  c_MaxMat
			
				c_MaxMat := BA3->BA3_CODEMP + BA3->BA3_MATRIC
			
			EndIf
		     
		EndIf 
		
		BA3->( dbSkip() )
		
	EndDo    
	
	If nTipo == 3  
	       
	    dbSelectArea("BA3")
	    dbSetOrder(1) 
		If BA3->(dbSeek(xFilial("BA3")+'0001'+c_MaxMat))   
		
		     
			BA3->(RecLock("BA3",.F.)) 
	
				PreBA3(nTipo,.F.)
	
			BA3->(MsUnlock()) 
		
		EndIf
	
	EndIf
	
Endif  

c_MaxMat := ""
c_MaxTip := ""

BA1->(dbSetOrder(6)) //6
if BA1->(dbSeek(xFilial("BA1")+cChave+ZZ1->ZZ1_DEPEND))


	While !BA1->( EOF() ) .AND. AllTrim( BA1->BA1_MATEMP ) == AllTrim( cChave )+ZZ1->ZZ1_DEPEND
//	While !BA1->( EOF() ) .AND. AllTrim( BA1->BA1_CODEMP + BA1->BA1_MATEMP ) == AllTrim( ZZ0->ZZ0_CODEMP+cChave )+ZZ1->ZZ1_DEPEND

		If Empty( BA1->BA1_DATBLO ) .and. nTipo <> 3 .and. BA1->BA1_CODEMP == ZZ0->ZZ0_CODEMP
		
			
			BTS->(DBSetOrder(1))
			If BTS->(dbSeek(xFilial("BTS")+BA1->BA1_MATVID))
				BTS->(RecLock("BTS",.F.))
				PreBTS(nTipo,lTit,.F.)   //Esta funcionado corretamente para alteracao de usuario
				BTS->(MsUnlock())
			Else
				BTS->(RecLock("BTS",.T.))
				PreBTS(1,lTit,.T.)
				BTS->(MsUnlock())
			Endif
			
			BA1->(RecLock("BA1",.F.))
			PreBA1(nTipo,lTit)
			BA1->(MsUnlock())
			
			If alltrim(ZZ1->ZZ1_OPERSI) $ ("04_06")   //Alteração do tipo de usuário.
				AltSubUsu()  //Transfere o beneficiario de sub-contrato.
				//	Else
				//		PreBA1(nTipo,lTit,.F.)
			Endif
 		     
	 	     
	 		Exit
	 	
	 	ElseIf nTipo == 3 .and. BA1->BA1_CODEMP == ZZ0->ZZ0_CODEMP
		
			If BA1->BA1_CODEMP + BA1->BA1_MATRIC + BA1->BA1_TIPREG >  c_MaxMat
			
				c_MaxMat := BA1->BA1_CODEMP + BA1->BA1_MATRIC + BA1->BA1_TIPREG
				
			EndIf
	 	
	 	EndIf	
	 	
	 	BA1->( dbSkip() )
EndDo   

	If nTipo == 3          
	
	    dbSelectArea("BA1")
	    dbSetOrder(2) 
		If BA1->(dbSeek(xFilial("BA1")+'0001'+c_MaxMat))    
//		If BA1->(dbSeek(xFilial("BA1")+'0001'+c_MaxMat+c_MaxTip))    
		     
			BTS->(DBSetOrder(1))
			If BTS->(dbSeek(xFilial("BTS")+BA1->BA1_MATVID))
				BTS->(RecLock("BTS",.F.))
				PreBTS(nTipo,lTit,.F.)   //Esta funcionado corretamente para alteracao de usuario
				BTS->(MsUnlock())
			Else
				BTS->(RecLock("BTS",.T.))
				PreBTS(1,lTit,.T.)
				BTS->(MsUnlock())
			Endif
			
			BA1->(RecLock("BA1",.F.))
			PreBA1(nTipo,lTit)
			BA1->(MsUnlock())
			
			If alltrim(ZZ1->ZZ1_OPERSI) $ ("04_06")   //Alteração do tipo de usuário.
				AltSubUsu()  //Transfere o beneficiario de sub-contrato.
				//	Else
				//		PreBA1(nTipo,lTit,.F.)
			Endif
		
		EndIf
	
	EndIf

Endif

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³AltSub    ºAutor  ³Antonio de Padua    º Data ³  05/06/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Funcao que altera o subcontrato de uma familia             º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function AltSub(cTipo)
Local lTit		:= .F.
Local aRetorno	:= {}
Local nRegBA1	:= 0
Local cMatDes	:= ""
Local _cMatAnt	:= ""
Local aTmpFam	:= {}
Local aTmpUsu	:= {}
Local aVetTit	:= {}
Local nCont		:= 0
Local nCont2	:= 0
Local lAgr		:= .F.
Local cChave := ""
Local cChaveFun := ""
Local cFunc := ""

cSubCon   := ""

If cTipo = 1
	cFunc := ZZ1->ZZ1_FUNC
	cChave := ZZ0->ZZ0_CODEMP+ZZ1->ZZ1_FUNC
	cChaveFun := ZZ1->(ZZ1_FUNC+ZZ1_DEPEND)
ElseIf cTipo = 2
	cFunc := ZZ1->ZZ1_FUNANT
	cChave := ZZ0->ZZ0_CODEMP+ZZ1->ZZ1_FUNANT
	cChaveFun := ZZ1->(ZZ1_FUNANT+ZZ1_DEPEND)
EndIf

lTit := ZZ1->ZZ1_CDBENE == 'T'  //cria uma nova familia para o titular
lAgr := ZZ1->ZZ1_CDBENE == 'A'  //cria uma nova familia para o agregado ou inclui  em uma ja existente

If lTit
	aadd(aVetTit,cFunc)
Endif

BA3->(dbSetOrder(5))   // Pesquiso a familia do titular ou do agregado
If BA3->(dbSeek(xFilial("BA3")+cchave)) .And. (lTit .Or. lAgr)  //Nao pesquisa se for depedente.
	If lTit   //Somente para titular
		//Pesquiso a familia do titular e guardo a que nao esta bloqueada.
		While !BA3->(Eof()) .And. Alltrim(BA3->(BA3_CODEMP+BA3_MATEMP)) == Alltrim(cChave)
			//While !BA3->(Eof()) .And. Alltrim(BA3->(BA3_CODEMP+BA3_MATEMP)) == Alltrim(ZZ0->ZZ0_CODEMP+ZZ1->ZZ1_FUNC)
			If Empty(BA3->BA3_DATBLO)
				aadd(aTmpFam,BA3->(RECNO()))
			Endif
			BA3->(DbSkip())
		Enddo
	Else   // somente para agregado
		If ascan(aVetTit,cFunc) == 0 //TESTE ANT
			While !BA3->(Eof()) .And. Alltrim(BA3->(BA3_CODEMP+BA3_MATEMP)) == Alltrim(cChave)   //Alltrim(ZZ0->ZZ0_CODEMP+ZZ1->ZZ1_FUNC)
				//While !BA3->(Eof()) .And. Alltrim(BA3->(BA3_CODEMP+BA3_MATEMP)) == Alltrim(ZZ0->ZZ0_CODEMP+ZZ1->ZZ1_FUNCANT)
				If Empty(BA3->BA3_DATBLO)
					
					BA1->(DbSetOrder(1))
					BA1->(MsSeek(xFilial("BA1")+BA3->(BA3_CODINT+BA3_CODEMP+BA3_MATRIC)))
					
					While !BA1->(Eof()) .And. BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC) == BA3->(BA3_CODINT+BA3_CODEMP+BA3_MATRIC)
						
						If Alltrim(BA1->BA1_MATEMP) == Alltrim(cChaveFun) .And. Empty(BA1->BA1_DATBLO)
							aadd(aTmpFam,BA3->(RECNO()))
							Exit
						Endif
						
						BA1->(DbSkip())
						
					Enddo
				Endif
				BA3->(DbSkip())
			Enddo
		EndIf
	Endif
	
	For nCont := 1 to Len(aTmpFam)
		
		BA3->(DbGoTo(aTmpFam[nCont]))
		
		If AllTrim(ZZ0->ZZ0_CTREMP) == "01115"  //Beneficiarios Ativos
			cNumCon := "000000000001"
		Elseif AllTRim(ZZ0->ZZ0_CTREMP) == "01123" //Beneficiarios Inativos
			cNumCon := "000000000002"
			//TORNAR GENÉRICA
		Elseif AllTRim(ZZ0->ZZ0_CODEMP) <> "0006"
			cNumCon := ZZ0->ZZ0_NUMCON
		Endif
		
		cSql := "SELECT * FROM "+RetSqlName("BQC")+" Where BQC_CODIGO = '"+ZZ0->ZZ0_CODOPE+ZZ0->ZZ0_CODEMP+"'"
		cSql += " AND BQC_NUMCON = '"+cNumCon+"'"
		cSql += " AND BQC_VERCON = '001'
		cSql += " AND BQC_ANTCON = '"+ZZ1->ZZ1_CODEMP+"' AND D_E_L_E_T_ = ' '"
		PLsQuery(cSql,"TMPBQC")
		If !TMPBQC->(EOF())
			While !TMPBQC->(EOF())
				BT0->(DbSetOrder(1))
				lPode   := .F.
				//cSubCon := ""
				if BT0->(DbSeek(xFilial("BT0")+ZZ0->(ZZ0_CODOPE+ZZ0_CODEMP)+cNumCon+"001"+TMPBQC->(BQC_SUBCON+BQC_VERSUB)+dParaPrd(ZZ1->ZZ1_PADRAO,dParaTpBnf(ZZ1->ZZ1_CDBENE))+"001"))
					lPode   := .T.
					While !BT0->(EOF()) .And. BT0->(BT0_FILIAL+BT0_CODIGO+BT0_NUMCON+BT0_VERCON+BT0_SUBCON+BT0_VERSUB+BT0_CODPRO+BT0_VERSAO) == ZZ0->ZZ0_FILIAL+ZZ0->ZZ0_CODOPE+ZZ0->ZZ0_CODEMP+cNumCon+"001"+TMPBQC->BQC_SUBCON+TMPBQC->BQC_VERSUB+dParaPrd(ZZ1->ZZ1_PADRAO,dParaTpBnf(ZZ1->ZZ1_CDBENE))+"001"
						if BT0->BT0_TIPUSR == dParaTpBnf(ZZ1->ZZ1_CDBENE) .And. BT0->BT0_ATIVO == "1"
							lPode := .T.
						Elseif BT0->BT0_TIPUSR == DParaTpBnf(ZZ1->ZZ1_CDBENE) .And. BT0->BT0_ATIVO == "2"
							lPode := .F.
						Endif
						BT0->(DbSkip())
					Enddo
				Endif
				if lPode
					cSubCon := TMPBQC->BQC_SUBCON
				Endif
				TMPBQC->(DbSkip())
			Enddo
		Endif
		TMPBQC->(DbCloseArea())
		
		if cSubCon == ""
			cSubCon := "000000001" // 18/5/07
		endif
		
		BI3->(DbSetOrder(1))  //Tabela de Produtos Saude
		If BI3->(DbSeek(xFilial("BT6")+BT6->BT6_CODINT+dParaPrd(ZZ1->ZZ1_PADRAO,dParaTpBnf(ZZ1->ZZ1_CDBENE))+"001"))
			
			aRetorno := CopiaReg("BA3")  //bloqueia a familia anterior
			
			cNovaMatric := PLPROXMAT(ZZ0->ZZ0_CODOPE,ZZ0->ZZ0_CODEMP)
			_cMatAnt := BA3->BA3_MATRIC
			
			//Insere a nova familia
			BA3->(RecLock("BA3",.F.))
			BA3->BA3_CONEMP := cNumCon
			BA3->BA3_VERCON := "001"
			BA3->BA3_SUBCON := cSubCon
			BA3->BA3_VERSUB := "001"
			BA3->BA3_MATRIC	:= cNovaMatric
			BA3->BA3_CODPLA	:=	BI3->BI3_CODIGO
			BA3->BA3_VERSAO	:=	"001"
			BA3->BA3_TIPCON	:=	BI3->BI3_TIPCON
			BA3->BA3_SEGPLA	:=	BI3->BI3_CODSEG
			BA3->BA3_MODPAG	:=	BI3->BI3_MODPAG
			BA3->BA3_TXUSU	   :=	'0'
			BA3->BA3_APLEI	   :=	BI3->BI3_APOSRG
			BA3->BA3_CODACO	:=	BI3->BI3_CODACO
			BA3->BA3_ABRANG	:=	BI3->BI3_ABRANG
			BA3->BA3_DATBAS := ctod(ZZ1->ZZ1_DTINCT) 
			BA3->BA3_TIPPAG	:=	"07" //MOTTA 19/03/12
			BA3->(MsUnlock())
			
			//Bloquear registro anterior
			BA3->(DbGoTo(aRetorno[1]))
			BA3->(RecLock("BA3",.F.))
			BA3->BA3_DATBLO := (dDataBase - 1)
			BA3->BA3_MOTBLO := GetNewPar("MV_YMTBLTI","006")
			BA3->(MsUnlock())
			
			//Historico de Bloqueio
			BloqFam(BA3->(BA3_CODINT+BA3_CODEMP+BA3_MATRIC),BA3->BA3_MATANT,BA3->BA3_DATBLO,BA3->BA3_MOTBLO)
			
			BC3->(Reclock("BC3",.T.))
			BC3->BC3_FILIAL := xFilial("BC3")
			BC3->BC3_MATRIC := BA3->(BA3_CODINT+BA3_CODEMP+BA3_MATRIC)
			BC3->BC3_TIPO   := "0"
			BC3->BC3_DATA   := BA3->BA3_DATBLO
			BC3->BC3_MOTBLO := BA3->BA3_MOTBLO
			BC3->BC3_OBS    := "Historico de transferencia"
			BC3->BC3_MATANT := BA3->BA3_MATANT
			BC3->BC3_BLOFAT := "1"
			BC3->BC3_NIVBLQ := "F"
			BC3->BC3_USUOPE := cUserName
			BC3->(MsUnlock())
			
			BA3->(DbGoTo(aTmpFam[nCont]))
			
			AtuProd()
			AtuOpc()
			AtuAdesao()
			
			aTmpUsu := {}
			
			BA1->(dbSetOrder(1))
			IF BA1->(dbSeek(xFilial("BA1")+BA3->BA3_CODINT+BA3->BA3_CODEMP+_cMatAnt))
				
				While !BA1->(EOF()) .AND. BA1->BA1_FILIAL+BA1->BA1_CODINT+BA1->BA1_CODEMP+BA1->BA1_MATRIC == 	BA3->BA3_FILIAL+BA3->BA3_CODINT+BA3->BA3_CODEMP+_cMatAnt
					
					If Empty(BA1->BA1_DATBLO)
						aadd(aTmpUsu,BA1->(RECNO()))
					Endif
					
					BA1->(DbSkip())
					
				Enddo
				
				For nCont2 := 1 to Len(aTmpUsu)
					
					BA1->(DbGoTo(aTmpUsu[nCont2]))
					
					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³ Cond. implementada para evitar laco infinito nos novos regs.        ³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					If BA1->BA1_IMPORT <> "HISTITAU"
						aRetorno := CopiaReg("BA1")  //Bloqueia a familia anterior
						
						BA1->(RecLock("BA1",.F.))
						BA1->BA1_CONEMP := cNumCon
						BA1->BA1_VERCON := "001"
						BA1->BA1_SUBCON := cSubCon
						BA1->BA1_VERSUB := "001"
						BA1->BA1_MATRIC := cNovaMatric   //BA3->BA3_MATRIC
						//BA1->BA1_TIPREG	// NAO NECESSARIO MODIFICAR POIS EH COPIA DO BA1 ANTERIOR...
						BA1->BA1_DIGITO :=	Modulo11(BA1->BA1_CODINT+BA1->BA1_CODEMP+BA1->BA1_MATRIC+BA1->BA1_TIPREG)
						BA1->BA1_CODPLA := dParaPrd(ZZ1->ZZ1_PADRAO,dParaTpBnf(ZZ1->ZZ1_CDBENE))   //BA3->BA3_CODPLA
						BA1->BA1_VERSAO := "001"                                                   //BA3->BA3_VERSAO
						BA1->BA1_TRAORI := aRetorno[2]
						BA1->BA1_DATTRA := dDataBase
						BA1->BA1_DATINC := BA1->BA1_DATTRA
						
						//Trecho de código inserido por Luzio em 14/07/09 para que insira o codigo do produto do beneficiario transferido de dependencia.
						BA1->BA1_DATINC := ctod(ZZ1->ZZ1_DTINCO)
						BA1->BA1_DTVLCR := ctod("  /  /    ")
						BA1->BA1_EMICAR := " "
						BA1->BA1_VIACAR := 0
						BA1->BA1_CODPLA	:= dParaPrd(ZZ1->ZZ1_PADRAO,dParaTpBnf(ZZ1->ZZ1_CDBENE))
						BA1->BA1_VERSAO	:= "001"
						
						BA1->BA1_LOCANS	:=	'1'
						BA1->BA1_INFSIB	:=	'1'
						BA1->BA1_INFANS	:=	'1'
						
						BA1->BA1_LOCSIB	:=	'0'
						
						BA1->BA1_ATUSIB :=  '1'
						BA1->BA1_INCANS := CTOD("  /  /    ")
						BA1->BA1_ENVANS := CTOD("  /  /    ")
						BA1->BA1_EXCANS := CTOD("  /  /    ")
						
						BA1->(MsUnlock())
						
						//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
						//³ Integridade entre matricula antiga / origem e destino.              ³
						//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
						cMatDes := BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG+BA1_DIGITO)
						
						BA1->(DbGoTo(aRetorno[1])) //Posiciona no novo registro da matricula de historico.
						BA1->(RecLock("BA1",.F.))
						BA1->BA1_TRADES := cMatDes
						BA1->(MsUnlock())
						
						BA1->(DbGoTo(aTmpUsu[nCont2]))
						
					Endif
					
				Next
			Endif
		Endif
		
		AtuProd()
		AtuOpc()
		AtuAdesao()
	Next
	
Endif
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³AltSubUsu ºAutor  ³Antonio de Padua    º Data ³  05/06/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Funcao que altera o subcontrato de um beneficiario         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function AltSubUsu()
Local aRetorno := {}
Local nRegBA1 := 0
Local cMatDes := ""

cSubCon := ""

BA1->(dbSetOrder(6))
If BA1->(dbSeek(xFilial("BA1")+ZZ1->ZZ1_FUNC+"00"))  //Pesquisa o titular da Familia pela funcional
	BA3->(dbSetOrder(1))
	If BA3->(dbSeek(xFilial("BA3")+BA3->BA3_CODINT+BA3->BA3_CODEMP+BA3->BA3_MATRIC))
		
		If AllTrim(ZZ0->ZZ0_CTREMP) == "01115"  //Ativos
			cNumCon := "000000000001"
		Elseif AllTRim(ZZ0->ZZ0_CTREMP) == "01123"  //Inativos
			cNumCon := "000000000002"
		Elseif AllTRim(ZZ0->ZZ0_CODEMP) <> "0006"
			cNumCon := ZZ0->ZZ0_SUBCON
			//TORNAR GENÉRICA
		Endif
		
		cSql := "SELECT * FROM "+RetSqlName("BQC")+" Where BQC_CODIGO = '"+ZZ0->ZZ0_CODOPE+ZZ0->ZZ0_CODEMP+"'"
		cSql += " AND BQC_NUMCON = '"+cNumCon+"'"
		cSql += " AND BQC_VERCON = '001' "
		cSql += " AND BQC_ANTCON = '"+ZZ1->ZZ1_CODEMP+"' AND D_E_L_E_T_ = ' '"
		PLsQuery(cSql,"TMPBQC")
		If !TMPBQC->(EOF())
			While !TMPBQC->(EOF())
				BT0->(DbSetOrder(1))
				lPode   := .F.
				//cSubCon := ""
				if BT0->(DbSeek(xFilial("BT0")+ZZ0->ZZ0_CODOPE+ZZ0->ZZ0_CODEMP+cNumCon+"001"+TMPBQC->BQC_SUBCON+TMPBQC->BQC_VERSUB+dParaPrd(ZZ1->ZZ1_PADRAO,dParaTpBnf(ZZ1->ZZ1_CDBENE))+"001"))
					lPode   := .T.
					While !BT0->(EOF()) .And. BT0->(BT0_FILIAL+BT0_CODIGO+BT0_NUMCON+BT0_VERCON+BT0_SUBCON+BT0_VERSUB+BT0_CODPRO+BT0_VERSAO) == ZZ0->ZZ0_FILIAL+ZZ0->ZZ0_CODOPE+ZZ0->ZZ0_CODEMP+cNumCon+"001"+TMPBQC->BQC_SUBCON+TMPBQC->BQC_VERSUB+dParaPrd(ZZ1->ZZ1_PADRAO,dParaTpBnf(ZZ1->ZZ1_CDBENE))+"001"
						if BT0->BT0_TIPUSR == dParaTpBnf(ZZ1->ZZ1_CDBENE) .And. BT0->BT0_ATIVO == "1"
							lPode := .T.
						Elseif BT0->BT0_TIPUSR == DParaTpBnf(ZZ1->ZZ1_CDBENE) .And. BT0->BT0_ATIVO == "2"
							lPode := .F.
						Endif
						BT0->(DbSkip())
					Enddo
				Endif
				if lPode
					cSubCon := TMPBQC->BQC_SUBCON
				Endif
				TMPBQC->(DbSkip())
			Enddo
		Endif
		TMPBQC->(DbCloseArea())
		
		If cSubCon == ""
			cSubCon := "000000001"
		Endif
		
		BI3->(DbSetOrder(1))
		if BI3->(DbSeek(xFilial("BT6")+BT6->BT6_CODINT+dParaPrd(ZZ1->ZZ1_PADRAO,dParaTpBnf(ZZ1->ZZ1_CDBENE))+"001"))
			
			// Verifico se o Contrato desse usuario agora é diferente da Familia
			If BA3->BA3_CONEMP <> cNumCon .Or. BA3->BA3_SUBCON <> cSubCon
				cNovaMatric := PLPROXMAT(ZZ0->ZZ0_CODOPE,ZZ0->ZZ0_CODEMP)
				
				//Crio uma nova familia para este beneficiario
				BA3->(RecLock("BA3",.T.))
				PreBA3(1,.T.)
				BA3->(MsUnlock())
				
				BA1->(dbSetOrder(6))
				If BA1->(dbSeek(xFilial("BA1")+ZZ1->ZZ1_FUNC+ZZ1->ZZ1_DEPEND))
					aRetorno := CopiaReg("BA1")
					
					BA1->(RecLock("BA1",.F.))
					BA1->BA1_CODINT	:=	BA3->BA3_CODINT
					BA1->BA1_CODEMP	:=	BA3->BA3_CODEMP
					BA1->BA1_MATRIC	:=	BA3->BA3_MATRIC
					BA1->BA1_CONEMP	:=	BA3->BA3_CONEMP
					BA1->BA1_VERCON	:=	BA3->BA3_VERCON
					BA1->BA1_SUBCON	:=	BA3->BA3_SUBCON
					BA1->BA1_VERSUB	:=	BA3->BA3_VERSUB
					BA1->BA1_TIPUSU := DPTpBnfbd(ZZ1->ZZ1_CDBENE)
					BA1->BA1_GRAUPA := dParaGrauP(ZZ1->ZZ1_TPPARE,iif(ZZ1->ZZ1_SEXO =="M","1","2"))
					BA1->BA1_IMAGE	:=	'ENABLE'
					
					BA1->BA1_DATBLO := BA3->BA3_DATBLO
					BA1->BA1_MOTBLO := BA3->BA3_MOTBLO
					
					BA1->BA1_TIPREG	:=	Iif(ZZ1->ZZ1_CDBENE == 'A',"00",VerTipReg(BA3->BA3_CODINT + BA3->BA3_CODEMP + BA3->BA3_MATRIC, dParaGrauP(ZZ1->ZZ1_TPPARE,iif(ZZ1->ZZ1_SEXO =="M","1","2")), ZZ1->ZZ1_DEPEND, DParaTpBnf(ZZ1->ZZ1_CDBENE)))  //ZZ1->ZZ1_DEPEND
					
					BA1->BA1_DIGITO := Modulo11( BA1->BA1_CODINT + BA1->BA1_CODEMP + BA1->BA1_MATRIC + BA1->BA1_TIPREG )
					BA1->BA1_TRAORI := aRetorno[2]
					BA1->BA1_DATTRA := dDataBase
					
					//Trecho de código inserido por Luzio em 11/05/09 para que insira o codigo do produto do beneficiario transferido de dependencia.
					BA1->BA1_DATINC := ctod(ZZ1->ZZ1_DTINCO)
					BA1->BA1_DTVLCR := ctod("  /  /    ")
					BA1->BA1_CODPLA	:= dParaPrd(ZZ1->ZZ1_PADRAO,dParaTpBnf(ZZ1->ZZ1_CDBENE))
					BA1->BA1_VERSAO	:= "001"
					
					BA1->(MsUnlock())
					
					//Trecho de fonte comentado por Luzio em 21/01/2009, O Bloqueio do usuario ja foi realizado pela funcao COPIAREG chamada acima
					//					//Historico de Bloqueio
					//					BloqUsu(BA1->(BA1_CODINT + BA1_CODEMP + BA1_MATRIC),BA1->BA1_TIPREG, BA1->BA1_MATANT, BA1->BA1_DATBLO, BA1->BA1_MOTBLO)
					
					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³ Integridade entre matricula antiga / origem e destino.              ³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					nRegBA1 := BA1->(Recno())
					cMatDes := BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG+BA1_DIGITO)
					
					BA1->(DbGoTo(aRetorno[1])) //Posiciona no novo registro da matricula de historico.
					BA1->(RecLock("BA1",.F.))
					BA1->BA1_TRADES := cMatDes
					BA1->(MsUnlock())
					BA1->(DbGoTo(nRegBA1)) //Retorna o BA1 a posicao original, e prossegue a execucao da rotina.
					
				Endif
			Else
				BA1->(dbSetOrder(6))
				if BA1->(dbSeek(xFilial("BA1")+ZZ1->ZZ1_FUNC+ZZ1->ZZ1_DEPEND))  //TESTE ANT
					//if BA1->(dbSeek(xFilial("BA1")+ZZ1->ZZ1_FUNANT+ZZ1->ZZ1_DEPEND))
					if BA3->BA3_CONEMP <> BA1->BA1_CONEMP .Or. BA3->BA3_SUBCON <> BA1->BA1_SUBCON
						
						aRetorno := CopiaReg("BA1")
						
						BA1->(RecLock("BA1",.F.))
						BA1->BA1_CODINT	:=	BA3->BA3_CODINT
						BA1->BA1_CODEMP	:=	BA3->BA3_CODEMP
						BA1->BA1_MATRIC	:=	BA3->BA3_MATRIC
						BA1->BA1_CONEMP	:=	BA3->BA3_CONEMP
						BA1->BA1_VERCON	:=	BA3->BA3_VERCON
						BA1->BA1_SUBCON	:=	BA3->BA3_SUBCON
						BA1->BA1_VERSUB	:=	BA3->BA3_VERSUB
						BA1->BA1_IMAGE	 :=	'ENABLE'
						
						//						BA1->BA1_TIPREG := VerTipReg(BA3->BA3_CODINT + BA3->BA3_CODEMP + BA3->BA3_MATRIC, dParaGrauP(ZZ1->ZZ1_TPPARE,iif(ZZ1->ZZ1_SEXO =="M","1","2")), ZZ1->ZZ1_DEPEND, DParaTpBnf(ZZ1->ZZ1_CDBENE))
						BA1->BA1_TIPREG	:=	Iif(ZZ1->ZZ1_CDBENE == 'A',"00",VerTipReg(BA3->BA3_CODINT + BA3->BA3_CODEMP + BA3->BA3_MATRIC, dParaGrauP(ZZ1->ZZ1_TPPARE,iif(ZZ1->ZZ1_SEXO =="M","1","2")), ZZ1->ZZ1_DEPEND, DParaTpBnf(ZZ1->ZZ1_CDBENE)))  //ZZ1->ZZ1_DEPEND
						
						BA1->BA1_DIGITO := Modulo11( BA1->BA1_CODINT + BA1->BA1_CODEMP + BA1->BA1_MATRIC + BA1->BA1_TIPREG )
						BA1->BA1_TRAORI := aRetorno[2]
						BA1->BA1_DATTRA := dDataBase
						
						BA1->BA1_TIPREG	:=	Iif(ZZ1->ZZ1_CDBENE == 'A',"00",VerTipReg(BA3->BA3_CODINT + BA3->BA3_CODEMP + BA3->BA3_MATRIC, dParaGrauP(ZZ1->ZZ1_TPPARE,iif(ZZ1->ZZ1_SEXO =="M","1","2")), ZZ1->ZZ1_DEPEND, DParaTpBnf(ZZ1->ZZ1_CDBENE)))  //ZZ1->ZZ1_DEPEND
						//						BA1->BA1_TIPREG := VerTipReg(BA3->BA3_CODINT + BA3->BA3_CODEMP + BA3->BA3_MATRIC, dParaGrauP(ZZ1->ZZ1_TPPARE,iif(ZZ1->ZZ1_SEXO =="M","1","2")), ZZ1->ZZ1_DEPEND, DParaTpBnf(ZZ1->ZZ1_CDBENE))
						
						BA1->BA1_DIGITO := Modulo11( BA1->BA1_CODINT + BA1->BA1_CODEMP + BA1->BA1_MATRIC + BA1->BA1_TIPREG )
						BA1->BA1_TIPUSU := DPTpBnfbd(ZZ1->ZZ1_CDBENE)
						BA1->BA1_GRAUPA := dParaGrauP(ZZ1->ZZ1_TPPARE,iif(ZZ1->ZZ1_SEXO =="M","1","2"))
						
						If (ZZ1->ZZ1_OPERSI == "04" .AND. ZZ1->ZZ1_OPER == "02")
							BA1->BA1_DATINC := ctod(ZZ1->ZZ1_DTINCO)
						Else
							BA1->BA1_DATINC := iif(ZZ1->ZZ1_OPER $ "04_05",ctod(ZZ1->ZZ1_DTINPD),ctod(ZZ1->ZZ1_DTINPD))  //ctod(ZZ1->ZZ1_DTINCT))
						EndIf
						BA1->BA1_DTVLCR := ctod("  /  /    ")
						BA1->BA1_CODPLA := dParaPrd(ZZ1->ZZ1_PADRAO,dParaTpBnf(ZZ1->ZZ1_CDBENE))   //BA3->BA3_CODPLA  //BI3->BI3_CODIGO
						BA1->BA1_VERSAO := "001"                                                   //BA3->BA3_VERSAO
						BA1->(MsUnlock())
						
						//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
						//³ Integridade entre matricula antiga / origem e destino.              ³
						//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
						nRegBA1 := BA1->(Recno())
						cMatDes := BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG+BA1_DIGITO)
						
						BA1->(DbGoTo(aRetorno[1])) //Posiciona no novo registro da matricula de historico.
						BA1->(RecLock("BA1",.F.))
						BA1->BA1_TRADES := cMatDes
						BA1->(MsUnlock())
						BA1->(DbGoTo(nRegBA1)) //Retorna o BA1 a posicao original, e prossegue a execucao da rotina.
						
					Endif
				Endif
			Endif
		Endif
		AtuProd()
		AtuOpc()
		AtuAdesao()
	Endif
Endif

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³AtuProd   ºAutor  ³Antonio de Padua    º Data ³  12/05/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Atualiza Faixa etaria de cobranca de acordo com o a empresaº±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function AtuProd()

// Limpo as tabelas para nao ter problema na alteracao
TCSQLEXEC("DELETE FROM "+RetSqlName("BJK")+" WHERE BJK_CODINT = '"+BA3->BA3_CODINT+"' AND BJK_CODEMP = '"+BA3->BA3_CODEMP+"' AND BJK_MATRIC = '"+BA3->BA3_MATRIC+"' AND BJK_CODFOR = '"+BA3->BA3_FORPAG+"'")
TCSQLEXEC("DELETE FROM "+RetSqlName("BBU")+" WHERE BBU_CODINT = '"+BA3->BA3_CODINT+"' AND BBU_CODEMP = '"+BA3->BA3_CODEMP+"' AND BBU_MATRIC = '"+BA3->BA3_MATRIC+"' AND BBU_CODFOR = '"+BA3->BA3_FORPAG+"'")

BT9->(DbSetOrder(1))
BJK->(DbSetOrder(1))

if BT9->(dbSeek(xFilial("BT9")+BA3->(BA3_CODINT+BA3_CODEMP+BA3_CONEMP+BA3_VERCON+BA3_SUBCON+BA3_VERSUB+BA3_CODPLA+BA3_VERSAO+BA3_FORPAG)))
	
	BJK->(RecLock("BJK",!BJK->(DbSeek(xFilial("BJK")+BA3->BA3_CODINT+BA3->BA3_CODEMP+BA3->BA3_MATRIC))))
	BJK->BJK_FILIAL := xFilial("BJK")
	BJK->BJK_CODOPE := BA3->BA3_CODINT
	BJK->BJK_CODEMP := BA3->BA3_CODEMP
	BJK->BJK_MATRIC := BA3->BA3_MATRIC
	BJK->BJK_CODFOR := BA3->BA3_FORPAG
	BJK->BJK_AUTOMA := "1"
	BJK->(MSUNLOCK())
Endif

if BTN->(dbSeek(xFilial("BTN")+BA3->(BA3_CODINT+BA3_CODEMP+BA3_CONEMP+BA3_VERCON+BA3_SUBCON+BA3_VERSUB+BA3_CODPLA+BA3_VERSAO+BA3_FORPAG)))
	While ! BTN->(EOF()) .And. BTN->(BTN_FILIAL+BTN_CODIGO+BTN_NUMCON+BTN_VERCON+BTN_SUBCON+BTN_VERSUB+BTN_CODPRO+BTN_VERPRO+BTN_CODFOR) == BA3->(BA3_FILIAL+BA3_CODINT+BA3_CODEMP+BA3_CONEMP+BA3_VERCON+BA3_SUBCON+BA3_VERSUB+BA3_CODPLA+BA3_VERSAO+BA3_FORPAG)
		
		BBU->(RecLock("BBU",!BBU->(DbSeek(xFilial("BBU")+BA3->BA3_CODINT+BA3->BA3_CODEMP+BA3->BA3_MATRIC+BA3->BA3_FORPAG+BTN->BTN_CODFAI))))
		BBU->BBU_FILIAL := xFilial("BBU")
		BBU->BBU_CODOPE := BA3->BA3_CODINT
		BBU->BBU_CODEMP := BA3->BA3_CODEMP
		BBU->BBU_MATRIC := BA3->BA3_MATRIC
		BBU->BBU_CODFOR := BA3->BA3_FORPAG
		BBU->BBU_CODFAI := BTN->BTN_CODFAI
		BBU->BBU_TABVLD := BTN->BTN_TABVLD
		BBU->BBU_TIPUSR := BTN->BTN_TIPUSR
		BBU->BBU_GRAUPA := BTN->BTN_GRAUPA
		BBU->BBU_SEXO   := BTN->BTN_SEXO
		BBU->BBU_IDAINI := BTN->BTN_IDAINI
		BBU->BBU_IDAFIN := BTN->BTN_IDAFIN
		BBU->BBU_VALFAI := BTN->BTN_VALFAI
		BBU->BBU_FAIFAM := BTN->BTN_FAIFAM
		BBU->BBU_QTDMIN := BTN->BTN_QTDMIN
		BBU->BBU_QTDMAX := BTN->BTN_QTDMAX
		BBU->BBU_REJAPL := BTN->BTN_REJAPL
		BBU->BBU_AUTOMA := "1"
		BBU->BBU_PERREJ := BTN->BTN_PERREJ
		BBU->BBU_ANOMES := BTN->BTN_ANOMES
		BBU->BBU_VLRANT := BTN->BTN_VLRANT
		BBU->(MsUnlock())
		
		BTN->(DbSkip())
	Enddo
Endif

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  AtuAdesao   ºAutor  ³Raquel    º Data ³  25/10/07   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Atualiza Taxa de adesao na familia pegando da empresa      º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function AtuAdesao()

// Limpo as tabelas para nao ter problema na alteracao
TCSQLEXEC("DELETE FROM "+RetSqlName("BJL")+" WHERE BJL_CODINT = '"+BA3->BA3_CODINT+"' AND BJL_CODEMP = '"+BA3->BA3_CODEMP+"' AND BJL_MATRIC = '"+BA3->BA3_MATRIC+"' AND BJL_CODFOR = '"+BA3->BA3_FORCTX+"'")
TCSQLEXEC("DELETE FROM "+RetSqlName("BRX")+" WHERE BRX_CODINT = '"+BA3->BA3_CODINT+"' AND BRX_CODEMP = '"+BA3->BA3_CODEMP+"' AND BRX_MATRIC = '"+BA3->BA3_MATRIC+"' AND BRX_CODFOR = '"+BA3->BA3_FORCTX+"'")

BTK->(DbSetOrder(1))
BJL->(DbSetOrder(1))

if BTK->(dbSeek(xFilial("BTK")+BA3->(BA3_CODINT+BA3_CODEMP+BA3_CONEMP+BA3_VERCON+BA3_SUBCON+BA3_VERSUB+BA3_CODPLA+BA3_VERSAO+BA3_FORCTX)))
	
	BJL->(RecLock("BJL",!BJL->(DbSeek(xFilial("BJL")+BA3->BA3_CODINT+BA3->BA3_CODEMP+BA3->BA3_MATRIC))))
	BJL->BJL_FILIAL := xFilial("BJL")
	BJL->BJL_CODOPE := BA3->BA3_CODINT
	BJL->BJL_CODEMP := BA3->BA3_CODEMP
	BJL->BJL_MATRIC := BA3->BA3_MATRIC
	BJL->BJL_CODFOR := BA3->BA3_FORCTX
	BJL->BJL_AUTOMA := "1"
	BJL->(MSUNLOCK())
Endif

if BR6->(dbSeek(xFilial("BR6")+BA3->(BA3_CODINT+BA3_CODEMP+BA3_CONEMP+BA3_VERCON+BA3_SUBCON+BA3_VERSUB+BA3_CODPLA+BA3_VERSAO+BA3_FORCTX)))
	While ! BR6->(EOF()) .And. BR6->(BR6_FILIAL+BR6_CODIGO+BR6_NUMCON+BR6_VERCON+BR6_SUBCON+BR6_VERSUB+BR6_CODPRO+BR6_VERPRO+BR6_CODFOR) == BA3->(BA3_FILIAL+BA3_CODINT+BA3_CODEMP+BA3_CONEMP+BA3_VERCON+BA3_SUBCON+BA3_VERSUB+BA3_CODPLA+BA3_VERSAO+BA3_FORCTX)
		
		BRX->(RecLock("BRX",!BRX->(DbSeek(xFilial("BRX")+BA3->BA3_CODINT+BA3->BA3_CODEMP+BA3->BA3_MATRIC+BA3->BA3_FORCTX+BR6->BR6_CODFAI))))
		BRX->BRX_FILIAL := xFilial("BRX")
		BRX->BRX_CODOPE := BA3->BA3_CODINT
		BRX->BRX_CODEMP := BA3->BA3_CODEMP
		BRX->BRX_MATRIC := BA3->BA3_MATRIC
		BRX->BRX_CODFOR := BA3->BA3_FORCTX
		BRX->BRX_CODFAI := BR6->BR6_CODFAI
		BRX->BRX_TIPUSR := BR6->BR6_TIPUSR
		BRX->BRX_GRAUPA := BR6->BR6_GRAUPA
		BRX->BRX_VLRADE := BR6->BR6_VLRADE
		BRX->BRX_PERADE := BR6->BR6_PERADE
		BRX->BRX_SEXO   := BR6->BR6_SEXO
		BRX->BRX_IDAINI := BR6->BR6_IDAINI
		BRX->BRX_IDAFIN := BR6->BR6_IDAFIN
		BRX->BRX_AUTOMA := "1"
		BRX->BRX_ANOMES := BR6->BR6_ANOMES
		BRX->BRX_VLRANT :=BR6->BR6_VLRANT
		BRX->(MsUnlock())
		
		BR6->(DbSkip())
	Enddo
Endif

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³AtuOPC  B ºAutor  ³Antonio de Padua    º Data ³  12/05/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Atualiza Opcionais na familia pegando da empresa           º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function AtuOpc()

TCSQLEXEC("DELETE FROM "+RetSqlName("BF1")+" WHERE BF1_CODINT = '"+BA3->BA3_CODINT+"' AND BF1_CODEMP = '"+BA3->BA3_CODEMP+"' AND BF1_MATRIC = '"+BA3->BA3_MATRIC+"'")
TCSQLEXEC("DELETE FROM "+RetSqlName("BK0")+" WHERE BK0_CODOPE = '"+BA3->BA3_CODINT+"' AND BK0_CODEMP = '"+BA3->BA3_CODEMP+"' AND BK0_MATRIC = '"+BA3->BA3_MATRIC+"'")
TCSQLEXEC("DELETE FROM "+RetSqlName("BBY")+" WHERE BBY_CODOPE = '"+BA3->BA3_CODINT+"' AND BBY_CODEMP = '"+BA3->BA3_CODEMP+"' AND BBY_MATRIC = '"+BA3->BA3_MATRIC+"'")
TCSQLEXEC("DELETE FROM "+RetSqlName("BG0")+" WHERE BG0_CODOPE = '"+BA3->BA3_CODINT+"' AND BG0_CODEMP = '"+BA3->BA3_CODEMP+"' AND BG0_MATRIC = '"+BA3->BA3_MATRIC+"'")
TCSQLEXEC("DELETE FROM "+RetSqlName("BF4")+" WHERE BF4_CODINT = '"+BA3->BA3_CODINT+"' AND BF4_CODEMP = '"+BA3->BA3_CODEMP+"' AND BF4_MATRIC = '"+BA3->BA3_MATRIC+"'")
TCSQLEXEC("DELETE FROM "+RetSqlName("BYX")+" WHERE BYX_CODOPE = '"+BA3->BA3_CODINT+"' AND BYX_CODEMP = '"+BA3->BA3_CODEMP+"' AND BYX_MATRIC = '"+BA3->BA3_MATRIC+"'")
TCSQLEXEC("DELETE FROM "+RetSqlName("BZX")+" WHERE BZX_CODOPE = '"+BA3->BA3_CODINT+"' AND BZX_CODEMP = '"+BA3->BA3_CODEMP+"' AND BZX_MATRIC = '"+BA3->BA3_MATRIC+"'")

BI3->(dbGoTop())
Do While !BI3->(Eof())
	
	If	BI3->BI3_GRUPO != '002'
		BI3->(dbSkip())
		Loop
	EndIf
	
	BHS->( dbSetorder(01) )
	If !BHS->( dbSeek(xFilial("BHS")+BA3->(BA3_CODINT+BA3_CODEMP+BA3_CONEMP+;
		BA3_VERCON+BA3_SUBCON+BA3_VERSUB+BA3_CODPLA+BA3_VERSAO)) )
		Return
	Endif
	
	While !BHS->( Eof() ) .and. BHS->(BHS_CODINT+BHS_CODIGO+BHS_NUMCON+BHS_VERCON+BHS_SUBCON+BHS_VERSUB+BHS_CODPRO+BHS_VERPRO)==;
		BA3->(BA3_CODINT+BA3_CODEMP+BA3_CONEMP+BA3_VERCON+BA3_SUBCON+BA3_VERSUB+BA3_CODPLA+BA3_VERSAO)
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Compara o codigo do opcional                                        ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If BHS->BHS_CODPLA <> BI3->BI3_CODIGO
			BHS->( dbSkip() )
			Loop
		Endif
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Grava o opcional...                                                 ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		BF1->( dbSetorder(01) )
		If !BF1->( dbSeek(xFilial("BF1")+BA3->(BA3_CODINT+BA3_CODEMP+BA3_MATRIC)+BHS->BHS_CODPLA) )
			BF1->( RecLock("BF1",.T.) )
			BF1->BF1_FILIAL := xFilial("BF1")
			BF1->BF1_CODEMP := BA3->BA3_CODEMP
			BF1->BF1_CODINT := BA3->BA3_CODINT
			BF1->BF1_MATRIC := BA3->BA3_MATRIC
			BF1->BF1_CODPRO := BHS->BHS_CODPLA
			BF1->BF1_VERSAO := BHS->BHS_VERPLA
			BF1->BF1_DATBAS := BA3->BA3_DATBAS
			BF1->BF1_TIPVIN := '0'
			BF1->( msUnlock() )
			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Grava suas formas de cobranca...                                    ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If BHS->BHS_TIPVIN <> 'S'
				BJW->( dbSetorder(01) )
				If BJW->( dbSeek(xFilial("BK0")+BA3->(BA3_CODINT+BA3_CODEMP+BA3_CONEMP+;
					BA3_VERCON+BA3_SUBCON+BA3_VERSUB+;
					BA3_CODPLA+BA3_VERSAO)          +;
					BHS->BHS_CODPLA+BHS->BHS_VERPLA ) )
					
					BK0->( dbSetorder(01) )
					If !BK0->( dbSeek(xFilial("BK0")+BA3->(BA3_CODINT+BA3_CODEMP+BA3_MATRIC)+;
						BHS->BHS_CODPLA+BHS->BHS_VERPLA ) )
						
						BK0->( RecLock("BK0", .T.) )
						BK0->BK0_FILIAL := xFilial("BK0")
						BK0->BK0_CODOPE := BA3->BA3_CODINT
						BK0->BK0_CODEMP := BA3->BA3_CODEMP
						BK0->BK0_MATRIC := BA3->BA3_MATRIC
						BK0->BK0_CODOPC := BJW->BJW_CODOPC
						BK0->BK0_VEROPC := BJW->BJW_VEROPC
						BK0->BK0_CODFOR := BJW->BJW_CODFOR
						BK0->( MsUnlock() )
						
						BA3->( RecLock("BA3", .F.) )
						BA3->BA3_FORCOP := BJW->BJW_CODFOR
						BA3->( MsUnlock() )
					Endif
					
					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³ Grava suas faixas de valores de cobranca...                         ³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					cSql := "SELECT * FROM "+RetSqlName("BBX")+" WHERE BBX_FILIAL = '"+xFilial("BBX")+"' "
					cSql += "AND BBX_CODIGO = '"+BA3->BA3_CODINT+BA3->BA3_CODEMP+"' "
					cSql += "AND BBX_NUMCON = '"+BA3->BA3_CONEMP+"' "
					cSql += "AND BBX_VERCON = '"+BA3->BA3_VERCON+"' "
					cSql += "AND BBX_SUBCON = '"+BA3->BA3_SUBCON+"' "
					cSql += "AND BBX_VERSUB = '"+BA3->BA3_VERSUB+"' "
					cSql += "AND BBX_CODPRO = '"+BA3->BA3_CODPLA+"' "
					cSql += "AND BBX_VERPRO = '"+BA3->BA3_VERSAO+"' "
					cSql += "AND BBX_CODOPC = '"+BJW->BJW_CODOPC+"' "
					cSql += "AND BBX_VEROPC = '"+BJW->BJW_VEROPC+"' "
					cSql += "AND BBX_CODFOR = '"+BJW->BJW_CODFOR+"' "
					cSql += "AND D_E_L_E_T_ <> '*' "
					PlsQuery(cSql, "TRB1")
					
					TRB1->( dbGotop())
					While !TRB1->( Eof() )
						If ! BBY->( dbSeek(xFilial("BBY")+BA3->BA3_CODINT+BA3->BA3_CODEMP+BA3->BA3_MATRIC+TRB1->BBX_CODOPC+TRB1->BBX_VEROPC+;
							TRB1->BBX_CODFOR+TRB1->BBX_CODFAI) )
							BBY->( RecLock("BBY", .T.) )
							BBY->BBY_FILIAL := xFilial("BBY")
							BBY->BBY_CODOPE := BA3->BA3_CODINT
							BBY->BBY_CODEMP := BA3->BA3_CODEMP
							BBY->BBY_MATRIC := BA3->BA3_MATRIC
							BBY->BBY_CODOPC := TRB1->BBX_CODOPC
							BBY->BBY_VEROPC := TRB1->BBX_VEROPC
							BBY->BBY_CODFOR := TRB1->BBX_CODFOR
							BBY->BBY_CODFAI	:= TRB1->BBX_CODFAI
							BBY->BBY_TIPUSR := TRB1->BBX_TIPUSR
							BBY->BBY_GRAUPA := TRB1->BBX_GRAUPA
							BBY->BBY_SEXO	:= TRB1->BBX_SEXO
							BBY->BBY_IDAINI	:= TRB1->BBX_IDAINI
							BBY->BBY_IDAFIN := TRB1->BBX_IDAFIN
							BBY->BBY_VALFAI := TRB1->BBX_VALFAI
							BBY->BBY_FAIFAM := TRB1->BBX_FAIFAM
							BBY->BBY_QTDMIN := TRB1->BBX_QTDMAX
							BBY->BBY_QTDMAX := TRB1->BBX_QTDMAX
							BBY->BBY_AUTOMA := '1'
							BBY->BBY_ANOMES	:= TRB1->BBX_ANOMES
							BBY->BBY_VLRANT := TRB1->BBX_VLRANT
							BBY->( msUnlock() )
						Endif
						TRB1->( dbSkip() )
					Enddo
					TRB1->( dbClosearea() )
					
					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³ Grava suas faixas de descontos de cobranca...                       ³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					cSql := "SELECT * FROM "+RetSqlName("BGW")+" WHERE BGW_FILIAL = '"+xFilial("BGW")+"' "
					cSql += "AND BGW_CODIGO = '"+BA3->BA3_CODINT+BA3->BA3_CODEMP+"' "
					cSql += "AND BGW_NUMCON = '"+BA3->BA3_CONEMP+"' "
					cSql += "AND BGW_VERCON = '"+BA3->BA3_VERCON+"' "
					cSql += "AND BGW_SUBCON = '"+BA3->BA3_SUBCON+"' "
					cSql += "AND BGW_VERSUB = '"+BA3->BA3_VERSUB+"' "
					cSql += "AND BGW_CODPRO = '"+BA3->BA3_CODPLA+"' "
					cSql += "AND BGW_VERPRO = '"+BA3->BA3_VERSAO+"' "
					cSql += "AND BGW_CODOPC = '"+BJW->BJW_CODOPC+"' "
					cSql += "AND BGW_VEROPC = '"+BJW->BJW_VEROPC+"' "
					cSql += "AND BGW_CODFOR = '"+BJW->BJW_CODFOR+"' "
					cSql += "AND D_E_L_E_T_ <> '*' "
					PlsQuery(cSql, "TRB1")
					
					TRB1->( dbGotop())
					If ! BG0->( dbSeek(xFilial("BG0")+BA3->BA3_CODINT+BA3->BA3_CODEMP+BA3->BA3_MATRIC+TRB1->BGW_CODOPC+TRB1->BGW_VEROPC+;
						TRB1->BGW_CODFOR+TRB1->BGW_CODFAI) )
						While !TRB1->( Eof() )
							BG0->( RecLock("BG0", .T.) )
							BG0->BG0_FILIAL := xFilial("BG0")
							BG0->BG0_CODOPE := BA3->BA3_CODINT
							BG0->BG0_CODEMP := BA3->BA3_CODEMP
							BG0->BG0_MATRIC := BA3->BA3_MATRIC
							BG0->BG0_CODOPC := TRB1->BGW_CODOPC
							BG0->BG0_VEROPC := TRB1->BGW_VEROPC
							BG0->BG0_CODFOR := TRB1->BGW_CODFOR
							BG0->BG0_CODFAI	:= TRB1->BGW_CODFAI
							BG0->BG0_TIPUSR := TRB1->BGW_TIPUSR
							BG0->BG0_GRAUPA := TRB1->BGW_GRAUPA
							BG0->BG0_PERCEN := TRB1->BGW_PERCEN
							BG0->BG0_VALOR  := TRB1->BGW_VALOR
							BG0->BG0_QTDDE	:= TRB1->BGW_QTDDE
							BG0->BG0_QTDATE := TRB1->BGW_QTDATE
							BG0->BG0_TIPO	:= TRB1->BGW_TIPO
							BG0->BG0_AUTOMA := '1'
							BG0->( msUnlock() )
							TRB1->( dbSkip() )
						Enddo
					Endif
					TRB1->( dbClosearea() )
				Endif
			Endif
		Endif
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Inicia atualizacoes do usuario...                                   ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		BA1->( dbSetorder(02) )
		If BA1->(dbSeek(xFilial("BA1")+BA3->(BA3_CODINT+BA3_CODEMP+BA3_MATRIC+"00")) )
			
			While !BA1->( Eof() ) .and. BA1->BA1_FILIAL == xFilial("BA1")  .and.;
				BA1->BA1_CODINT == BA3->BA3_CODINT .and.;
				BA1->BA1_CODEMP == BA3->BA3_CODEMP .and.;
				BA1->BA1_MATRIC == BA3->BA3_MATRIC
				
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Opcionais...                                                        ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				If !BF4->( dbSeek(xFilial("BF4")+BA1->BA1_CODINT+BA1->BA1_CODEMP+BA1->BA1_MATRIC+BA1->BA1_TIPREG+BHS->BHS_CODPLA) )
					
					BF4->( RecLock("BF4", .T.) )
					BF4->BF4_FILIAL := xFilial("BF1")
					BF4->BF4_CODEMP := BA3->BA3_CODEMP
					BF4->BF4_CODINT := BA3->BA3_CODINT
					BF4->BF4_MATRIC := BA3->BA3_MATRIC
					BF4->BF4_TIPREG := BA1->BA1_TIPREG
					
					BF4->BF4_DATBAS := BA3->BA3_DATBAS
					BF4->BF4_MOTBLO := BA3->BA3_MOTBLO
					BF4->BF4_DATBLO := BA3->BA3_DATBLO
					
					BF4->BF4_CODPRO := BHS->BHS_CODPLA
					BF4->BF4_VERSAO := BHS->BHS_VERPLA
					BF4->BF4_TIPVIN := '0'
					
					BF4->( MsUnlock() )
					
					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³ Suas formas de cobranca...                                          ³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					If BHS->BHS_TIPVIN <> '1'
						BK0->( dbSetorder(01) )
						If BK0->( dbSeek(xFilial("BK0")+BA3->(BA3_CODINT+BA3_CODEMP+BA3_MATRIC)+;
							BHS->BHS_CODPLA+BHS->BHS_VERPLA ) )
							
							BYX->( RecLock("BYX", .T.) )
							BYX->BYX_FILIAL := xFilial("BK0")
							BYX->BYX_CODOPE := BA3->BA3_CODINT
							BYX->BYX_CODEMP := BA3->BA3_CODEMP
							BYX->BYX_MATRIC := BA3->BA3_MATRIC
							BYX->BYX_CODOPC := BK0->BK0_CODOPC
							BYX->BYX_VEROPC := BK0->BK0_VEROPC
							BYX->BYX_CODFOR := BK0->BK0_CODFOR
							BYX->BYX_TIPREG := BA1->BA1_TIPREG
							BYX->BYX_RGIMP  := '1'
							BYX->( MsUnlock() )
							
							//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
							//³ A tabela de precos...                                               ³
							//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
							cSql := "SELECT * FROM "+RetSqlName("BBY")+" WHERE BBY_FILIAL = '"+xFilial("BBY")+"' "
							cSql += "AND BBY_CODOPE = '"+BA1->BA1_CODINT+"' "
							cSql += "AND BBY_CODEMP = '"+BA1->BA1_CODEMP+"' "
							cSql += "AND BBY_MATRIC = '"+BA1->BA1_MATRIC+"' "
							cSql += "AND BBY_CODOPC = '"+BHS->BHS_CODPLA+"' "
							cSql += "AND BBY_VEROPC = '"+BHS->BHS_VERPLA+"' "
							cSql += "AND D_E_L_E_T_ <> '*' "
							PlsQuery(cSql, "TRB1")
							
							TRB1->( dbGotop() )
							While !TRB1->( Eof() )
								BZX->( RecLock("BZX", .T.) )
								BZX->BZX_FILIAL := xFilial("BK0")
								BZX->BZX_CODOPE := BA3->BA3_CODINT
								BZX->BZX_CODEMP := BA3->BA3_CODEMP
								BZX->BZX_MATRIC := BA3->BA3_MATRIC
								BZX->BZX_TIPREG := BA1->BA1_TIPREG
								BZX->BZX_CODOPC := TRB1->BBY_CODOPC
								BZX->BZX_VEROPC := TRB1->BBY_VEROPC
								BZX->BZX_CODFOR := TRB1->BBY_CODFOR
								BZX->BZX_VALFAI := TRB1->BBY_VALFAI
								BZX->BZX_IDAINI := TRB1->BBY_IDAINI
								BZX->BZX_IDAFIN := TRB1->BBY_IDAFIN
								BZX->BZX_RGIMP := '1'
								BZX->BZX_ANOMES := TRB1->BBY_ANOMES
								BZX->BZX_VLRANT := TRB1->BBY_VLRANT
								BZX->BZX_CODFAI := TRB1->BBY_CODFAI
								BZX->( MsUnlock() )
								TRB1->( dbSkip() )
							Enddo
							TRB1->( dbCloseArea() )
						Endif
					Endif
				Endif
				BA1->( dbSkip() )
			Enddo
		Endif
		BHS->( dbSkip() )
	Enddo
	BI3->(dbSkip())
EndDo

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³PreBA3    ºAutor  ³Microsiga           º Data ³  05/15/07   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function PreBA3(nTipo,lAcao)
//BA3->(RecLock("BA3",lAcao))

if nTipo == 1 // Somente na Inclusao
	BA3->BA3_FILIAL := xFilial("BA3")
	BA3->BA3_CODINT := ZZ0->ZZ0_CODOPE
	BA3->BA3_CODEMP := ZZ0->ZZ0_CODEMP
	BA3->BA3_CONEMP := cNumCon
	BA3->BA3_VERCON := "001"
	BA3->BA3_SUBCON := cSubCon
	BA3->BA3_VERSUB := "001"
	BA3->BA3_MATRIC	:=	cNovaMatric
	BA3->BA3_MATEMP	:=	ZZ1->ZZ1_FUNC
	BA3->BA3_HORACN	:=	StrTran(Time(),':','')
	BA3->BA3_FORPAG := "101"
	if ZZ0->ZZ0_CODEMP<>"0006"
		BA3->BA3_FORCTX  := "103"
	EndIf
	BA3->BA3_CODPLA := BI3->BI3_CODIGO
	BA3->BA3_VERSAO := "001"
	BA3->BA3_TIPCON := BI3->BI3_TIPCON
	BA3->BA3_SEGPLA := BI3->BI3_CODSEG
	BA3->BA3_MODPAG := BI3->BI3_MODPAG
	BA3->BA3_TXUSU  := '0'
	BA3->BA3_AGMTFU := cNovaMatric
	BA3->BA3_APLEI  := BI3->BI3_APOSRG
	BA3->BA3_CODACO := BI3->BI3_CODACO
	BA3->BA3_ABRANG := BI3->BI3_ABRANG
	//	BA3->BA3_DATBAS := ctod(ZZ1->ZZ1_DTINPD)    //iif(ZZ1->ZZ1_OPER =="05",ctod(ZZ1->ZZ1_DTINPD),ctod(ZZ1->ZZ1_DTINCT))
	// Alterado por Luzio em 11/05/09 para que considere a data de inclusao da familia a data do inicio de contrato do titular
	BA3->BA3_DATBAS := ctod(ZZ1->ZZ1_DTINCT)
    BA3->BA3_TIPPAG	:=	"07" //MOTTA 19/03/12
Endif

if nTipo <= 2 // Somente na Inclusao e Alteracao
	BA3->BA3_TIPOUS	:=	'2'
	BA3->BA3_FAIDES	:=	''
	BA3->BA3_VALSAL	:=	0
	BA3->BA3_ENDCOB	:=	'2'
	BA3->BA3_USUOPE	:=	"Importa"
	BA3->BA3_RGIMP	:=	'1'
	BA3->BA3_DEMITI	:=	iif(Empty(ctod(ZZ1->ZZ1_DTDESL)),"0","1")
	BA3->BA3_DATDEM	:=	ctod(ZZ1->ZZ1_DTDESL)
	BA3->BA3_LIMATE	:=	Ctod( '' )
	BA3->BA3_INFCOB	:=	'0'
	BA3->BA3_INFGCB	:=	'0'
	BA3->BA3_NUMCER	:=	''
	BA3->BA3_COBUSU	:=	'0'
	BA3->BA3_DATALT	:=	dDataBase
	BA3->BA3_OUTLAN	:=	'0'
	BA3->BA3_ROTINA	:=	'PLSPORFAI'
	BA3->BA3_VALID	:=	Ctod( '' )
	BA3->BA3_DESLIG	:=	''
	BA3->BA3_DATDES	:=	Ctod( '' )
	BA3->BA3_BLOFAT	:=	'1'
	BA3->BA3_COBRAT := '0'
	BA3->BA3_COBRET := '0'
	BA3->BA3_RATMAI := '0'
	BA3->BA3_RATSAI := '0'
	BA3->BA3_COBNIV	:= '0'
	BA3->BA3_BCOCLI := ZZ1->ZZ1_BANCO
	BA3->BA3_AGECLI := ZZ1->ZZ1_AGENC
	BA3->BA3_CTACLI := ZZ1->ZZ1_NUMCC
Endif
If nTipo == 3	// Somente no Bloqueio
	BA3->BA3_MOTBLO	:=	iif(!Empty(CtoD(alltrim(ZZ1->ZZ1_MOTEXC))),dParaBlq(ZZ1->ZZ1_MOTEXC),"009") // sera lancado valor default Paulo Motta 18/01/07
	BA3->BA3_DATBLO	:=	iif(!Empty(alltrim(ZZ1->ZZ1_DTEXC)),ctod(ZZ1->ZZ1_DTEXC),MSDATE())
	
		//Verifica se é uma reativação de beneficiario
	If ZZ1->ZZ1_OPERSI $ ("11_03_01")
		BA3->BA3_MOTBLO := " "
		BA3->BA3_DATBLO := StoD("        ")
	EndIf

	
	//Historico de Bloqueio
	BloqFam(BA3->(BA3_CODINT+BA3_CODEMP+BA3_MATRIC),BA3->BA3_MATANT,iif(!Empty(CtoD(Alltrim(ZZ1->ZZ1_DTEXC))),CtoD(ZZ1->ZZ1_DTEXC),MSDATE()),iif(!Empty(alltrim(ZZ1->ZZ1_MOTEXC)),dParaBlq(ZZ1->ZZ1_MOTEXC),"009"),BA3->BA3_MATEMP)
	
Endif

//BA3->(MsUnlock())
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³PreBTS    ºAutor  ³Microsiga           º Data ³  05/15/07   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function PreBTS(nTipo,lTit,lAcao)
//BTS->(RecLock("BTS",lAcao))

if nTipo == 1
	BTS->BTS_FILIAL	:=	xFilial("BTS")
	BTS->BTS_MATVID := GetSx8Num("BTS","BTS_MATVID")
	ConfirmSx8()
Endif
if nTipo <= 2
	BTS->BTS_NOMUSR	:=	ZZ1->ZZ1_BENEF
	BTS->BTS_SOBRN	:=	SUBS( ZZ1->ZZ1_BENEF, AT( ' ', ZZ1->ZZ1_BENEF ) + 1 )
	//BTS->BTS_NOMCAR	:=	SUBS( ZZ1->ZZ1_BENEF, 01, AT( ' ', ZZ1->ZZ1_BENEF ) - 1 ) //Jean - Alterado em 24/11/07
	BTS->BTS_NOMCAR	:=	ZZ1->ZZ1_BENEF
	BTS->BTS_DATNAS	:=	ctod(ZZ1->ZZ1_DTNASC)
	BTS->BTS_SEXO	:=	iif(ZZ1->ZZ1_SEXO =="M","1","2")
	if ZZ1->ZZ1_ESTCIV == "S"
		BTS->BTS_ESTCIV	:=	"S"
	Elseif ZZ1->ZZ1_ESTCIV == "C"
		BTS->BTS_ESTCIV	:=	"C"
	Elseif ZZ1->ZZ1_ESTCIV == "R"
		BTS->BTS_ESTCIV	:=	"D"
	Elseif ZZ1->ZZ1_ESTCIV == "V"
		BTS->BTS_ESTCIV	:=	"V"
	Elseif ZZ1->ZZ1_ESTCIV == "M"
		BTS->BTS_ESTCIV	:=	"M"
	Elseif ZZ1->ZZ1_ESTCIV == "J"
		BTS->BTS_ESTCIV	:=	"Q"
	Endif
	BTS->BTS_CPFUSR	:=	ZZ1->ZZ1_CPF
//	BTS->BTS_CPFUSR	:=	iif(lTit,ZZ1->ZZ1_CPF,"")
	BTS->BTS_PISPAS := 	iif(lTit .or. alltrim( ZZ1->ZZ1_PIS ) <> '341' ,ZZ1->ZZ1_PIS,"")
	BTS->BTS_CEPUSR	:=	iif(At("-",ZZ1->ZZ1_CEP) > 0,Substr(ZZ1->ZZ1_CEP,1,5)+Substr(ZZ1->ZZ1_CEP,7,3),ZZ1->ZZ1_CEP)
	
	BC9->(DbSetOrder(1))
	if BC9->(DbSeek(xFilial("BC9")+BTS->BTS_CEPUSR))
		BTS->BTS_ENDERE	:= BC9->BC9_END
		BTS->BTS_NR_END := ZZ1->ZZ1_NUMERO
		BTS->BTS_COMEND := ZZ1->ZZ1_COMPLE
		BTS->BTS_BAIRRO	:=	BC9->BC9_BAIRRO
		BTS->BTS_CODMUN	:=	BC9->BC9_CODMUN
		BTS->BTS_MUNICI	:=	BC9->BC9_MUN
		BTS->BTS_ESTADO	:=	BC9->BC9_EST
	Else
		BTS->BTS_ENDERE	:= ZZ1->ZZ1_LOGRAD
		BTS->BTS_NR_END := ZZ1->ZZ1_NUMERO
		BTS->BTS_COMEND := ZZ1->ZZ1_COMPLE
		BTS->BTS_BAIRRO	:= ZZ1->ZZ1_BAIRRO
		BTS->BTS_MUNICI	:= ZZ1->ZZ1_CIDADE
		BTS->BTS_ESTADO	:= ZZ1->ZZ1_UF
	Endif
	BTS->BTS_MAE		:= ZZ1->ZZ1_NOMMAE
	BTS->BTS_DDD    	:= ZZ1->ZZ1_DDDRES
	BTS->BTS_TELEFO		:= ZZ1->ZZ1_TELRES
	BTS->BTS_EMAIL		:= ZZ1->ZZ1_EMAIL
	BTS->BTS_YCEL		:= ZZ1->ZZ1_TELCEL
Endif
//BTS->(MsUnlock())

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³PreBA1    ºAutor  ³Microsiga           º Data ³  04/12/07   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function PreBA1(nTipo,lTit,lAcao,cCobRetro)
//BA1->(RecLock("BA1",lAcao))

If nTipo == 1
	BA1->BA1_CODINT := BA3->BA3_CODINT
	BA1->BA1_CODEMP := BA3->BA3_CODEMP
	BA1->BA1_MATRIC := BA3->BA3_MATRIC
	BA1->BA1_CONEMP := BA3->BA3_CONEMP
	BA1->BA1_VERCON := BA3->BA3_VERCON
	BA1->BA1_SUBCON := BA3->BA3_SUBCON
	BA1->BA1_VERSUB := BA3->BA3_VERSUB
	BA1->BA1_IMAGE	 := 'ENABLE'
	
	BA1->BA1_TIPREG	:=	Iif(ZZ1->ZZ1_CDBENE == 'A',"00",VerTipReg(BA3->BA3_CODINT + BA3->BA3_CODEMP + BA3->BA3_MATRIC, dParaGrauP(ZZ1->ZZ1_TPPARE,iif(ZZ1->ZZ1_SEXO =="M","1","2")), ZZ1->ZZ1_DEPEND, DParaTpBnf(ZZ1->ZZ1_CDBENE)))  //ZZ1->ZZ1_DEPEND
	//	BA1->BA1_TIPREG	:=	VerTipReg(BA3->BA3_CODINT + BA3->BA3_CODEMP + BA3->BA3_MATRIC, dParaGrauP(ZZ1->ZZ1_TPPARE,iif(ZZ1->ZZ1_SEXO =="M","1","2")), ZZ1->ZZ1_DEPEND, DParaTpBnf(ZZ1->ZZ1_CDBENE))
	
	BA1->BA1_DIGITO :=	Modulo11( BA1->BA1_CODINT + BA1->BA1_CODEMP + BA1->BA1_MATRIC + BA1->BA1_TIPREG )
	
	BA1->BA1_TIPUSU	:=	DPTpBnfbd(ZZ1->ZZ1_CDBENE)
	//	BA1->BA1_TIPUSU :=	DParaTpBnf(ZZ1->ZZ1_CDBENE)
	BA1->BA1_GRAUPA :=	dParaGrauP(ZZ1->ZZ1_TPPARE,iif(ZZ1->ZZ1_SEXO =="M","1","2"))
	
	//BA1->BA1_DATINC	:=	ctod(ZZ1->ZZ1_DTINPD) // PAULO MOTTA 26/04/07
	//BA1->BA1_DATINC	:=	iif(ZZ1->ZZ1_OPER == "05",ctod(ZZ1->ZZ1_DTINPD),ctod(ZZ1->ZZ1_DTINCT))   // PAULO MOTTA 26/04/07
	If (ZZ1->ZZ1_OPERSI == "04" .AND. ZZ1->ZZ1_OPER == "02")
		BA1->BA1_DATINC	:=	ctod(ZZ1->ZZ1_DTINCO)
	Else
		BA1->BA1_DATINC	:=	iif(ZZ1->ZZ1_OPER $ "04_05",ctod(ZZ1->ZZ1_DTINPD),ctod(ZZ1->ZZ1_DTINPD))  //ctod(ZZ1->ZZ1_DTINCT))
	EndIf
	BA1->BA1_DTVLCR := ctod("  /  /    ")
	//A inclusao do produto no beneficiario somente devera ocorrer quando for inclusao de usuario
	//Quando for troca de plano (operacao 05) devera ser criado uma nova familia e bloqueada a anterior.
	
	BA1->BA1_CODPLA := dParaPrd(ZZ1->ZZ1_PADRAO,dParaTpBnf(ZZ1->ZZ1_CDBENE))   //BA3->BA3_CODPLA  //BI3->BI3_CODIGO
	BA1->BA1_VERSAO := "001"                                                   //BA3->BA3_VERSAO
	  
	**'--Início: Marcela Coimbra -Data: 29/06/10 -----------------'** 	
	BA1->BA1_VIACAR	:=	0
	**'--Fim: Marcela Coimbra -Data: 29/06/10 --------------------'** 
	
Endif

if nTipo <= 2 // Somente na Inclusao ou Alteracao
	
	BA1->BA1_CPFUSR	:=	ZZ1->ZZ1_CPF// iif( lTit,ZZ1->ZZ1_CPF,"")
	BA1->BA1_PISPAS	:=	iif( alltrim( BTS->BTS_PISPAS ) <> '341', BTS->BTS_PISPAS, " " )
	BA1->BA1_DRGUSR	:=	BTS->BTS_DRGUSR
	BA1->BA1_ORGEM	   :=	BTS->BTS_ORGEM
	BA1->BA1_MATVID	:=	BTS->BTS_MATVID
	BA1->BA1_NOMUSR	:=	BTS->BTS_NOMUSR
	BA1->BA1_NREDUZ	:=	BTS->BTS_NOMCAR
	BA1->BA1_DATNAS	:=	BTS->BTS_DATNAS
	BA1->BA1_SEXO	:=	iif(ZZ1->ZZ1_SEXO =="M","1","2")
	// PAULO MOTTA 20/09/06
	// BA1->BA1_TIPUSU	:=	DParaTpBnf(ZZ1->ZZ1_CDBENE)
	// BA1->BA1_TIPUSU	:=	DPTpBnfbd(ZZ1->ZZ1_CDBENE) //Modificado posicionamento para dentro da funcao AltSubUsu()
	
	BA1->BA1_ESTCIV	:=	BTS->BTS_ESTCIV
	BA1->BA1_DATADM	:=	ctod(ZZ1->ZZ1_DTADMI)
	BA1->BA1_RECNAS	:=	Iif( dDataBase - BTS->BTS_DATNAS <= 60, '1', '0' )
	BA1->BA1_CEPUSR	:=	BTS->BTS_CEPUSR
	BA1->BA1_ENDERE	:=	BTS->BTS_ENDERE
	BA1->BA1_NR_END	:=	BTS->BTS_NR_END //PAULO MOTTA 20/09/06
	BA1->BA1_COMEND	:=	BTS->BTS_COMEND //PAULO MOTTA 20/09/06
	BA1->BA1_BAIRRO	:=	BTS->BTS_BAIRRO
	BA1->BA1_CODMUN	:=	BTS->BTS_CODMUN
	BA1->BA1_MUNICI	:=	BTS->BTS_MUNICI
	BA1->BA1_ESTADO	:=	BTS->BTS_ESTADO
	BA1->BA1_DDD	:=	BTS->BTS_DDD // PAULO MOTTA 20/09/06
	BA1->BA1_TELEFO	:=	BTS->BTS_TELEFO
	BA1->BA1_YCEL   :=  BTS->BTS_YCEL // PAULO MOTTA 20/09/06
	// BA1->BA1_DATCAR	:=	if(ZZ1->ZZ1_INDCAR == "S",ctod(ZZ1->ZZ1_DTINCT),ctod(ZZ1->ZZ1_DTINPD))
	BA1->BA1_MATEMP	:=	ZZ1->ZZ1_FUNC+ZZ1->ZZ1_DEPEND
	BA1->BA1_DATCAR	:=	if(ZZ1->ZZ1_INDCAR == "S",ctod(ZZ1->ZZ1_DTINPD),CtoD("01/11/03"))//Paulo Motta 22/3/07 carencia data contrato
	//BA1->BA1_CONSID	:=	'U'
	BA1->BA1_COEFIC	:=	1
	BA1->BA1_MUDFAI	:=	"1"
	BA1->BA1_CORNAT	:=	BTS->BTS_CORNAT
	BA1->BA1_SANGUE	:=	BTS->BTS_SANGUE

	**'--Início: Marcela Coimbra -Data: 29/06/10 -----------------'** 	
	//BA1->BA1_VIACAR	:=	0
	**'--Fim: Marcela Coimbra -Data: 29/06/10 --------------------'** 

	BA1->BA1_CODFUN	:=	BTS->BTS_CODFUN
	BA1->BA1_INSALU	:=	BTS->BTS_INSALU
	BA1->BA1_CODSET	:=	BTS->BTS_CODSET
	BA1->BA1_PESO	:=	BTS->BTS_PESO
	BA1->BA1_ALTURA	:=	BTS->BTS_ALTURA
	BA1->BA1_OBESO	:=	BTS->BTS_OBESO
	BA1->BA1_RGIMP	:=	'1'
	BA1->BA1_JACOBR	:=	'0'
	BA1->BA1_INFCOB	:=	'0'
	BA1->BA1_INFGCB	:=	'0'
	BA1->BA1_INFPRE	:=	'0'
	BA1->BA1_NSUBFT	:=	''
	BA1->BA1_USRVIP	:=	'0'
	BA1->BA1_UNIVER := '0'
	BA1->BA1_INTERD := '0'
	BA1->BA1_10ANOS := '0'
	BA1->BA1_INSALU := '0'
	BA1->BA1_COBNIV := '0'
	BA1->BA1_ESCOLA := '0'
	BA1->BA1_CB1AMS := '0'
	BA1->BA1_BANCO	:=	''
	BA1->BA1_AGENCI	:=	''
	BA1->BA1_CONTA	:=	''
	BA1->BA1_LOCCOB := '1'
	BA1->BA1_LOCATE := '1'
	BA1->BA1_LOCEMI	:=	'1'
	BA1->BA1_LOCANS	:=	'1'
	BA1->BA1_INFSIB	:=	'1'
	BA1->BA1_INFANS	:=	'1'
	BA1->BA1_ATUSIB :=  '1'
	If nTipo == 1
		BA1->BA1_LOCSIB	:=	'0'
	Else
		BA1->BA1_LOCSIB	:=	'1'
	EndIf
	BA1->BA1_OK		:= ''
	BA1->BA1_ESCOLA	:=	''
	BA1->BA1_CDORIG	:=	''
	BA1->BA1_PSORIG	:=	''
	BA1->BA1_OUTLAN := '0'
	BA1->BA1_LANREJ := '0'
	BA1->BA1_STAEDI := '1'
	BA1->BA1_SOBRN	:=	BTS->BTS_SOBRN
	BA1->BA1_FILIAL	:=	xFilial("BA1")
	BA1->BA1_TIPINC	:=	''
	BA1->BA1_LOTTRA	:=	''
	BA1->BA1_FORPAG	:=	'101'
	BA1->BA1_OPEORI	:=	ZZ0->ZZ0_CODOPE
	BA1->BA1_OPEDES	:=	ZZ0->ZZ0_CODOPE
	BA1->BA1_OPERES	:=	ZZ0->ZZ0_CODOPE
	BA1->BA1_MAE	:=  BTS->BTS_MAE
	BA1->BA1_IMPORT := "IMPORTADO: " + ZZ0->ZZ0_SEQUEN
	// 18/01/2006 Paulo Motta
	BA1->BA1_YLOTAC := ZZ1->ZZ1_CODLOT
	BA1->BA1_YNOMLO := ZZ1->ZZ1_ORGAO
	BA1->BA1_YINDEN := ZZ1->ZZ1_INDENV
	BA1->BA1_YDTDIG := dDataBase
Endif
If nTipo == 3	// Somente no Bloqueio
	BA1->BA1_MOTBLO := iif(!Empty(Alltrim(ZZ1->ZZ1_MOTEXC)),dParaBlq(ZZ1->ZZ1_MOTEXC),"009")
	BA1->BA1_DATBLO := iif(!Empty(CtoD(Alltrim(ZZ1->ZZ1_DTEXC))),CtoD(ZZ1->ZZ1_DTEXC),MSDATE())
	BA1->BA1_IMAGE  := 'DISABLE'
	BA1->BA1_CONSID := "U"
	BA1->BA1_BLOFAT := "1"
	//Verifica se é uma reativação de beneficiario
	If ZZ1->ZZ1_OPERSI $ ("11_03_01")
		BA1->BA1_MOTBLO := " "
		BA1->BA1_DATBLO := StoD("        ")
		BA1->BA1_IMAGE  := 'ENABLE'
	EndIf
	
	//Historico de Bloqueio
	BloqUsu(BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC),BA1->BA1_TIPREG,BA1->BA1_MATANT, iif(!Empty(CtoD(Alltrim(ZZ1->ZZ1_DTEXC))),CtoD(ZZ1->ZZ1_DTEXC),MSDATE()), iif(!Empty(Alltrim(ZZ1->ZZ1_MOTEXC)),dParaBlq(ZZ1->ZZ1_MOTEXC),"009"))
	//Estorna o valor da mensalidade gerada para cobrança futura, via lancamento de debito/credito
	If alltrim(ZZ1->ZZ1_OPER) $ ("03")   //Exclusao de Beneficiario
		EstBM1(BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC),BA1->BA1_TIPREG)
	EndIf
Endif
//BA1->(MsUnlock())
Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o	 ³MudaStr 	³ Autor ³ Luzio Tavares 		³ Data ³ 24/10/08 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Muda o conteudo da variavel string						  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso		 ³ Generico 												  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß/*/
Static Function MudaStr(cStrP,cStrM,nPos,nTam)
Local cTempE := ""
Local cTempD := ""

cTempE := Substr(cStrP,1,nPos-1)
cTempD := Substr(cStrP,nPos+nTam,Len(cStrP)-(nPos+nTam-1))

cStrP := cTempE + Substr(cStrM,1,nTam)  + cTempD

Return(cStrP)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o	 ³ChkPIS 	³ Autor ³ Marcos A. Stiefano	³ Data ³ 29.06.95 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Verifica PIS												  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso		 ³ Generico 												  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß/*/
Static FUNCTION CHPIS(cPIS)
Local nPis01 := nPis02 := nPis03 := nPis04 := nPis05 := 0
Local nPis06 := nPis07 := nPis08 := nPis09 := nPis10 := nPis11 := 0
Local nXpis  := nYpis  := nKpis	:= 0
Local nPis	 := 0

nPis01 := Val(SubStr(cPIS,01,01))
nPis02 := Val(SubStr(cPIS,02,01))
nPis03 := Val(SubStr(cPIS,03,01))
nPis04 := Val(SubStr(cPIS,04,01))
nPis05 := Val(SubStr(cPIS,05,01))
nPis06 := Val(SubStr(cPIS,06,01))
nPis07 := Val(SubStr(cPIS,07,01))
nPis08 := Val(SubStr(cPIS,08,01))
nPis09 := Val(SubStr(cPIS,09,01))
nPis10 := Val(SubStr(cPIS,10,01))
nPis11 := Val(SubStr(cPIS,11,01))

nXpis := (nPis01 * 3) + (nPis02 * 2) + (nPis03 * 9) + (nPis04 * 8) + (nPis05 * 7)
nXpis += (nPis06 * 6) + (nPis07 * 5) + (nPis08 * 4) + (nPis09 * 3) + (nPis10 * 2)
nYpis := (nXpis * 10)
nKpis := Mod(nYpis,11)

nPis	:= nPis01+nPis02+nPis03+nPis04+nPis05+nPis06+nPis07+nPis08+nPis09+nPis10+nPis11

If nKpis >= 10
	nKpis := 0
Endif

IF nKpis # nPis11 .Or. Len(Alltrim(cPis)) < 11
	Return (.F.)
Endif

IF nPis = 0
	Return (.F.)
Endif

Return ( .T. )

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±±
±±³Funcao    ³ LOGERRO    ³ Autor ³ Antonio de Padua    ³ Data ³ 28.08.03 ³±±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±±
±±³Descricao ³ Mostra Composicao do Log de Erros                          ³±±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function LOGERRO()
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta matriz com as opcoes do browse...                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
PRIVATE aRotina   	:=	{}
//	{ "Pesquisar"	    , 'AxPesqui'	  , 0 , K_Pesquisar  }},;
//{ "Visualizar"	, 'AxVisual'	  , 0 , K_Visualizar }}
PRIVATE cAlias    := "ZZ2"
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Chama funcao de Browse...                                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
#IFDEF TOP
	PRIVATE cFil := "@ZZ2_FILIAL = '"+xFilial("ZZ2")+"'"
	cFil += " AND ZZ2_SEQUEN = '"+ZZ1->ZZ1_SEQUEN+"' AND ZZ2_NUMLIN = '"+ZZ1->ZZ1_NUMLIN+"' AND D_E_L_E_T_ = ' '"
#ELSE
	PRIVATE cFil := "ZZ2_FILIAL = '"+xFilial("ZZ2")+"'"
	cFil += " .AND. ZZ1_SEQUEN = '"+ZZ0->ZZ0_SEQUEN+"' .AND. ZZ2_NUMLIN = '"+ZZ1->ZZ1_NUMLIN+"'"
#ENDIF

ZZ2->(DBSetOrder(1))
DbSelectArea("ZZ2")
SET FILTER TO &cFil

ZZ2->(mBrowse(006,001,022,075,"ZZ2" ,nil ,nil ,nil ,nil , 4    , ,nil ,nil ,nil ,,.T.,nil))
ZZ2->(DbClearFilter())
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Fim da Rotina...                                                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±±
±±³Funcao    ³ VEROPER    ³ Autor ³ Antonio de Padua    ³ Data ³ 28.08.03 ³±±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±±
±±³Descricao ³ Verifica qual operacao sera executada sibre o registro     ³±±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
01-	Inclusão normal
02-	Inclusão retroativa
03-	Alteração cadastral normal
04-	Alteração do tipo de usuário
05-	Alteração da data de nascimento
06-	Alteração de plano
07-	Exclusão normal
08-	Exclusão retroativa
09-	Exclusão posterior / Futura
10-	Troca de empresas/sub-contratos
11-	Reativação do usuário
/*/
User Function VEROPER(cAcao)
Local cTipo := "" 
Local l_Encontrou := .F.

nRecno := BA1->(Recno())
nOrder := BA1->(IndexOrd())
BA1->(dbSetOrder(6))
If ZZ1->ZZ1_OPER == "01"   //Inclusao de Cadastro     admin	ADMIN
	//Pesquiso para verificar se existe o beneficiario, nao titular.
	If BA1->(dbSeek(xFilial("BA1")+ZZ1->ZZ1_FUNC+ZZ1->ZZ1_DEPEND))

 		While !BA1->( EOF() ) .AND. AllTrim( BA1->BA1_MATEMP ) == ZZ1->ZZ1_FUNC+ZZ1->ZZ1_DEPEND
			
			If Empty(BA1->BA1_DATBLO).and. !(alltrim(ZZ1->ZZ1_CDBENE) $ "T_A") .and. !empty(BA1->BA1_DATBLO)   //Beneficario bloqueado
			
				cTipo := "11"  //Reativacao do usuario
				cAcao := "Reativação do usuario" 
				
				Exit
			
			ElseIf ctod(ZZ1->ZZ1_DTINPD) < dDatabase
			
				cTipo := "02"  //Inclusao Retroativa
				cAcao := "Inclusao Retroativa"
			
			Else
			
				cTipo := "01"  //Inclusao Normal
				cAcao := "Inclusao Normal"
			
			Endif   
		
		   
		
	   		BA1->( dbSkip() )
		
  		EndDo  
	
	EndIf
	
Elseif ZZ1->ZZ1_OPER == "02"   //Alteracao de Cadastro
	
	If BA1->(dbSeek(xFilial("BA1")+ZZ1->ZZ1_FUNC+ZZ1->ZZ1_DEPEND))  //Pesquiso para verificar se existe o beneficiario
	   
		While !BA1->( EOF() ) .AND. AllTrim( BA1->BA1_MATEMP ) == ZZ1->ZZ1_FUNC+ZZ1->ZZ1_DEPEND
	        
			If Empty(Ba1->BA1_DATBLO)
			
				l_Encontrou := .T.  
				
				If BA1->BA1_TIPUSU <> DPTpBnfbd(ZZ1->ZZ1_CDBENE)  // Verifico se houve mudanca no tipo de beneficiario. Se houve verifico se mantem na mesma familia.
					//			If BA1->BA1_TIPUSU <> DParaTpBnf(ZZ1->ZZ1_CDBENE)
					cTipo := "04"  //Alteração do tipo de usuário
					cAcao := "Alteração do tipo de usuário"
				Elseif BA1->BA1_DATNAS <> CTOD(ZZ1->ZZ1_DTNASC)
					cTipo := "05"  //Alteração da data de nascimento
					cAcao := "Alteração da data de nascimento"
					//		Elseif BA1->BA1_CODPLA <> dParaPrd(ZZ1->ZZ1_PADRAO,DParaTpBnf(ZZ1->ZZ1_CDBENE)) // Verifica o produto do beneficiario e diferente do atual. Se nao for verifico se mantem na mesma familia.
					//			cTipo := "10"  //Troca de empresas/sub-contratos
					//			cAcao := "Troca de empresas/sub-contratos"
					////			cTipo := "06"
					////			cAcao := "Alteração de plano"
					/*
					ElseIf !Empty(ctod(ZZ1->ZZ1_DTEXC))   //Solicitacao de exclusao de beneficiario com operacao incorreta
					If ctod(ZZ1->ZZ1_DTEXC) < dDatabase
					cTipo := "08"   //Exclusão retroativa
					cAcao := "Exclusão retroativa"
					Elseif ctod(ZZ1->ZZ1_DTEXC) == dDatabase
					cTipo := "07"  //Exclusão normal
					cAcao := "Exclusão normal"
					Else
					cTipo := "09"  //Exclusão posterior / Futura
					cAcao := "Exclusão posterior / Futura"
					Endif
					*/
				Else    
				
					cTipo := "03"      //Alteração cadastral normal
					cAcao := "Alteração cadastral normal"   
					
				Endif  
			
			EndIf
				
			BA1->( dbSKip() )   
			
		EndDo        
	
	EndIf
		
	If !l_Encontrou
	
		If ctod(ZZ1->ZZ1_DTINPD) < dDatabase
			cTipo := "02"  //Inclusao Retroativa
			cAcao := "Inclusao Retroativa"
		Else
			cTipo := "01"  //Inclusao Normal
			cAcao := "Inclusao Normal"
		Endif
	
	Endif

Elseif ZZ1->ZZ1_OPER == "03"   //Encerramento do Convenio (providenciar devolucao de cobranca)
	If ctod(ZZ1->ZZ1_DTEXC) < dDatabase
		cTipo := "08"   //Exclusão retroativa
		cAcao := "Exclusão retroativa"
	Elseif ctod(ZZ1->ZZ1_DTEXC) == dDatabase
		cTipo := "07"  //Exclusão normal
		cAcao := "Exclusão normal"
	Else
		cTipo := "09"  //Exclusão posterior / Futura
		cAcao := "Exclusão posterior / Futura"
	Endif
Elseif ZZ1->ZZ1_OPER == "04"   //Transferencia Entre Empresas no Conglomerado
	cTipo := "10"  //Troca de empresas/sub-contratos
	cAcao := "Troca de empresas/sub-contratos"
Elseif ZZ1->ZZ1_OPER == "05"   //Transferencia entre Planos
	//Pesquiso para verificar se existe o beneficiario, nao titular.
	If BA1->(dbSeek(xFilial("BA1")+ZZ1->ZZ1_FUNC+ZZ1->ZZ1_DEPEND)) .and. alltrim(ZZ1->ZZ1_CDBENE) $ "A" .and. BA1->BA1_TIPUSU != DParaTpBnf(ZZ1->ZZ1_CDBENE)
		cTipo := "04"  //Alteração do tipo de usuário
		cAcao := "Alteração do tipo de usuário"
	Else
		cTipo := "06"  //Alteração de plano
		cAcao := "Alteração de plano"
	EndIf
Elseif ZZ1->ZZ1_OPER == "06"  //Reativacao do Beneficiario
	cTipo := "11"  //Reativação do usuário
	cAcao := "Reativação do usuário"
Endif
BA1->(dbSetOrder(nOrder))
BA1->(DbGoto(nRecno))

Return(cTipo)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CopiaReg  ºAutor  ³Microsiga           º Data ³  13/04/07   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Copia registro da tabela repassada por parametro, cria um   º±±
±±º          ³novo registro na tabela identico (bloqueado) e mantem o     º±±
±±º          ³posicionamento anterior ao processo.                        º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ MP8                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function CopiaReg(cTabela)
Local aStru := {}
Local nCont := 0
Local aCampos := {}
Local aAreaBA1 := BA1->(GetArea())
Local aAreaBA3 := BA3->(GetArea())
Local aAreaBCA := BCA->(GetArea())
Local cDBStruct := cTabela+"->(DbStruct())"
Local aRet := {0,""}

Local cInstruc := ""

aStru := &cDBStruct

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Carga dos campos do registro posicionado na tabela desejada.        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
For nCont := 1 to Len(aStru)
	If aStru[nCont,2] $ "C,N,D"
		Aadd(aCampos,{cTabela+"->"+aStru[nCont,1],aStru[nCont,2],&(cTabela+"->"+aStru[nCont,1])}) //aCampos[X,Y,Z]  = X = Nome Campo, Y = Tipo, Z=Conteudo campo
	Endif
Next

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Inicio da transacao de controle                                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Begin Transaction

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Cria novo registro na tabela, conforme dados obtidos previamente.   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
&(cTabela+'->(RecLock("'+cTabela+'",.T.))')
For nCont := 1 to Len(aCampos)
	
	Do Case
		Case aCampos[nCont,2] == "C"
			cConteudo := '"'+aCampos[nCont,3]+'"'
		Case aCampos[nCont,2] == "D"
			cConteudo := 'CtoD("'+DtoC(aCampos[nCont,3])+'") '
		Case aCampos[nCont,2] == "N"
			cConteudo := Str(aCampos[nCont,3])//+'") '  'Val("'+
	EndCase
	
	cInstruc := aCampos[nCont,1]+" := "+cConteudo
	&cInstruc
	
Next
cInstruc := cTabela+'->'+cTabela+'_DATBLO := CtoD("'+DtoC(dDataBase)+'" ) '       //ctod(ZZ1->ZZ1_DTADMI)
&cInstruc
cInstruc := cTabela+'->'+cTabela+'_MOTBLO := "'+GetNewPar("MV_YMTBLTI","006")+'" '
&cInstruc
cInstruc := cTabela+'->'+cTabela+'_IMPORT := "HISTITAU" '
&cInstruc

If cTabela == "BA1"
	cInstruc := cTabela+'->'+cTabela+'_IMAGE := "DISABLE" '
	&cInstruc
	aRet[2] := BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG+BA1_DIGITO)
	
	//Historico de Bloqueio
	BloqUsu(BA1->(BA1_CODINT + BA1_CODEMP + BA1_MATRIC),BA1->BA1_TIPREG, BA1->BA1_MATANT, BA1->BA1_DATBLO, BA1->BA1_MOTBLO)
	If alltrim(ZZ1->ZZ1_OPER) $ ("05")   //Transferencia do beneficiario
		EstBM1(BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC),BA1->BA1_TIPREG)
	EndIf
Endif
&(cTabela+'->(MsUnlock())')

aRet[1] := &(cTabela+'->(Recno())')

End Transaction

RestArea(aAreaBA1)
RestArea(aAreaBA3)
RestArea(aAreaBCA)

Return aRet

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ CB007EXP   ³ Autor ³ Luzio Tavares     ³ Data ³ 26.12.2008 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Exportar Arquivo Criticado                                 ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function CB007EXP(cAlias,nReg,nOpc)
Local cNomeArq	:= ""
//Local cPath    := GetNewPar("MV_YEXBIT","N:\Protheus_data\interface\importa\itaubenef\Envio\")
Local cPath    := GetNewPar("MV_YEXBIT","\interface\importa\itaubenef\Envio\")
Local cLin     := Space(1)+CHR(13)+CHR(10)
Local nReg     := 0
Local lGrav    := .F.
Local nQtdErros := 0

PRIVATE nHdl

cNomeArq := cPath+"R_"+alltrim(ZZ0->ZZ0_NOMARQ)

if ZZ0->ZZ0_STATUS $ ("3_4")
	cSql := "SELECT * FROM "+RetSqlName("ZZ1")+" Where ZZ1_SEQUEN = '"+ZZ0->ZZ0_SEQUEN+"'"
	cSql += " AND D_E_L_E_T_ = ' '"
	PLsQuery(cSql,"TMPZZ1")
	If !TMPZZ1->(EOF())
		If U_Cria_TXT(cNomeArq)
			// header
			cCpo := '01'
			cCpo += substr(ZZ0->ZZ0_CTREMP,1,5)
			cCpo += iif(alltrim(ZZ0->ZZ0_CTREMP) == '01115','04697','04705')//FILIAL
			cCpo += 'CABERJ'+Replicate(' ',44)
			cCpo += '42182170000184'//CGC
			cCpo +=  Replicate(' ',10)//SAP
			cCpo +=  '0'
			cCpo +=  Substr(ZZ0->ZZ0_LINHA, 88, 06)   //ZZ0->ZZ0_SEQARQ
			cCpo += '001'//versao
			//			cCpo += Substr(DToC(dDatabase),1,2)+'.'+Substr(DToC(dDatabase),4,2)+'.'+Substr(DToC(dDatabase),7,4)
			//			cCpo += StrTran(Time(),':','')
			cCpo += Substr(ZZ0->ZZ0_LINHA, 97, 10)  //ZZ0_DATGER
			cCpo += Substr(ZZ0->ZZ0_LINHA, 107, 6)  //ZZ0_HORGER
			cCpo += Space(888)
			If !(U_GrLinha_TXT(cCpo,cLin))
				MsgAlert("ATENÇÃO! NÃO FOI POSSÍVEL GRAVAR CORRETAMENTE A LINHA ATUAL! OPERAÇÃO ABORTADA!")
				Return
			Endif
			// detalhe
			While !TMPZZ1->(EOF())
				cCpo := '10'
				cCpo += TMPZZ1->ZZ1_OPER
				cCpo += TMPZZ1->ZZ1_FUNC
				cCpo += TMPZZ1->ZZ1_DEPEND
				cCpo += TMPZZ1->ZZ1_BENEF
				cCpo += TMPZZ1->ZZ1_IDGPF
				cCpo += TMPZZ1->ZZ1_IDCONV
				cCpo += TMPZZ1->ZZ1_IDDEP
				cCpo += TMPZZ1->ZZ1_DTNASC
				cCpo += TMPZZ1->ZZ1_UFNASC
				cCpo += TMPZZ1->ZZ1_TPDOC
				cCpo += TMPZZ1->ZZ1_NRODOC
				cCpo += TMPZZ1->ZZ1_TPPARE
				cCpo += TMPZZ1->ZZ1_TPBENE
				cCpo += TMPZZ1->ZZ1_CDBENE
				cCpo += TMPZZ1->ZZ1_SEXO
				cCpo += TMPZZ1->ZZ1_ESTCIV
				cCpo += TMPZZ1->ZZ1_CPF
				cCpo += TMPZZ1->ZZ1_PIS
				cCpo += TMPZZ1->ZZ1_BANCO
				cCpo += TMPZZ1->ZZ1_AGENC
				cCpo += TMPZZ1->ZZ1_NUMCC
				cCpo += TMPZZ1->ZZ1_DTADMI
				cCpo += TMPZZ1->ZZ1_DTDESL
				cCpo += TMPZZ1->ZZ1_NOMMAE
				cCpo += TMPZZ1->ZZ1_CONTR
				cCpo += TMPZZ1->ZZ1_DTINCT
				cCpo += TMPZZ1->ZZ1_FILIT
				cCpo += TMPZZ1->ZZ1_PADRAO
				cCpo += TMPZZ1->ZZ1_DTINPD
				cCpo += TMPZZ1->ZZ1_DTFIPD
				cCpo += TMPZZ1->ZZ1_DTBASE
				cCpo += TMPZZ1->ZZ1_CODEMP
				cCpo += TMPZZ1->ZZ1_NOMEMP
				cCpo += TMPZZ1->ZZ1_CODLOT
				cCpo += TMPZZ1->ZZ1_ORGAO
				cCpo += TMPZZ1->ZZ1_UFLOT
				cCpo += TMPZZ1->ZZ1_CDUNI
				cCpo += TMPZZ1->ZZ1_DTEXC
				cCpo += TMPZZ1->ZZ1_MOTEXC
				cCpo += TMPZZ1->ZZ1_DTINCO
				cCpo += TMPZZ1->ZZ1_INDENV
				cCpo += TMPZZ1->ZZ1_LOGRAD
				cCpo += TMPZZ1->ZZ1_NUMERO
				cCpo += TMPZZ1->ZZ1_COMPLE
				cCpo += TMPZZ1->ZZ1_BAIRRO
				cCpo += TMPZZ1->ZZ1_CEP
				cCpo += TMPZZ1->ZZ1_CIDADE
				cCpo += TMPZZ1->ZZ1_UF
				cCpo += TMPZZ1->ZZ1_DDDRES
				cCpo += TMPZZ1->ZZ1_TELRES
				cCpo += TMPZZ1->ZZ1_DDDCOM
				cCpo += TMPZZ1->ZZ1_TELCOM
				cCpo += TMPZZ1->ZZ1_RAMAL
				cCpo += TMPZZ1->ZZ1_DDDCEL
				cCpo += TMPZZ1->ZZ1_TELCEL
				cCpo += TMPZZ1->ZZ1_EMAIL
				cCpo += TMPZZ1->ZZ1_FUNANT
				cCpo += Space(46)
				cCpo += TMPZZ1->ZZ1_INDCAR
				cCpo += TMPZZ1->ZZ1_INDTRA
				cCpo += TMPZZ1->ZZ1_DTTRAN
				cCpo += space(95)
				cCpo += iif(Empty(AllTRim(TMPZZ1->ZZ1_TABERR)),"S","E")
				cCpo += TMPZZ1->ZZ1_SEQREG
				cCpo += space(41)
				cCpo += TMPZZ1->ZZ1_TABERR
				
				**'---------------------------------------------'**
				**'-- Marcela Coimbra ----Data: 29/06/2010 -----'**
				**'-INI-----------------------------------------'**
                cLograd := ""        
				cLograd += TMPZZ1->ZZ1_IDLOGR 
				cLograd += TMPZZ1->ZZ1_CODLOG 
				cLograd += TMPZZ1->ZZ1_MUNLOG 
				cLograd += SubStr(TMPZZ1->ZZ1_ENDLOG, 1, 60)
  				cLograd += TMPZZ1->ZZ1_COMLOG 
				cLograd += TMPZZ1->ZZ1_BAILOG 
				cLograd += TMPZZ1->ZZ1_CITLOG 
				cLograd += TMPZZ1->ZZ1_ESTLOG 
                
                /*
                if !Empty( cLograd )
                
                	cCpo += cLograd
               
                Else
                
                	cCpo += space(500)

                EndIf
				*/
				 	
				**'---------------------------------------------'**
				**'-- Marcela Coimbra ----Data: 29/06/2010 -----'**
				**'-FIM-----------------------------------------'**
				
				nReg += 1
				If !Empty(TMPZZ1->ZZ1_TABERR)
					nQtdErros += 1
				EndIf
				If !(U_GrLinha_TXT(cCpo,cLin))
					MsgAlert("ATENÇÃO! NÃO FOI POSSÍVEL GRAVAR CORRETAMENTE A LINHA ATUAL! OPERAÇÃO ABORTADA!")
					Return
				Endif
				TMPZZ1->(DbSkip())
			Enddo
			// trailler
			cCpo := '99'
			cCpo += SubStr(ZZ0->ZZ0_CTREMP,1,5)
			cCpo += iif(alltrim(ZZ0->ZZ0_CTREMP) == '01115','04697','04705')    //FILIAL
			cCpo += StrZero(nReg,9,0)
			cCpo += Space(979)
			If !(U_GrLinha_TXT(cCpo,cLin))
				MsgAlert("ATENÇÃO! NÃO FOI POSSÍVEL GRAVAR CORRETAMENTE A LINHA ATUAL! OPERAÇÃO ABORTADA!")
				Return
			Endif
			U_Fecha_TXT()
			lGrav := .T.
		Endif
	Endif
	TMPZZ1->(DbCloseArea())
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Mudo o status do arquivo colocando como exportado no BD               ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If lGrav == .T.
		ZZ0->(RecLock("ZZ0",.F.))
		ZZ0->ZZ0_STATUS := "4"
		ZZ0->ZZ0_DTINSB := dDatabase
		ZZ0->(MsUnlock())
		
		u_EnviaEmail(alltrim(ZZ0->ZZ0_NOMARQ),nReg,nQtdErros)
		
		MsgAlert("Arquivo gravado com sucesso!!")
	Endif
Else
	MsgInfo("Somente e possivel inserir no BD arquivos com status inserido bd!")
Endif
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Fim da Rotina...                                                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ RELREGIMP  ³ Autor ³ Luzio             ³ Data ³ 26.12.2008 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Imprime rel. Arquivo                                       ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function RELREGIMP(cAlias,nReg,nOpc)

Private cCRPar:="1;0;1;RESUMO DE IMPORTACAO DO ARQUIVO ITAU"
/*Conjunto de opções para nao mostrar a tela da SetPrint, composta por x;y;z;w, onde
x = vídeo(1) ou impressora(3)
y = Atualiza(0) ou não(1) os dados
z = Número de cópias
w = Título do relatorio.
*/

if ZZ0->ZZ0_STATUS >= "3"
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ CHAMADA DO RELATORIO - PASSANDO O PARAMETRO DO REL.                   ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	CallCrys("RESITA",ZZ0->ZZ0_NOMARQ,cCRPar)
Else
	MsgInfo("Somente e possivel imprimir rel. de arquivos com status inserido bd!")
Endif
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Fim da Rotina...                                                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Return

/*
/*/
//ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
//±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
//±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
//±±³Programa  ³ CB007PES   ³ Autor ³ Luzio Tavares     ³ Data ³ 12.12.2008 ³±±
//±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄ´±±
//±±³Descri‡„o ³ Pesquisa um beneficiario nos arquivos importados           ³±±
//±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
//±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
//ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function CB007PES(cAlias,nReg,nOpc)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define variaveis...                                                      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
LOCAL oDlg
LOCAL cCadastro := "Pesquisar Arquivo/Beneficiario"
LOCAL bOK       := {|| nTipo := oFolder:NOPTION,oDlg:End() }
LOCAL bCancel   := {|| oDlg:End() }
LOCAL cCodOpe   := PLSINTPAD()
LOCAL nTamPEG   := Len(ZZ0_SEQUEN)
LOCAL nTamRDA   := Len(ZZ1_FUNC)
LOCAL cPEG      := Space( TamSX3("ZZ0_SEQUEN")[1] )
LOCAL cCodRDA   := Space( TamSX3("ZZ1_FUNC")[1]+TamSX3("ZZ1_DEPEND")[1] )
LOCAL cNomRDA   := Space( TamSX3("ZZ1_BENEF")[1] )
LOCAL cTipGui	:= ""
LOCAL oCombGui

LOCAL oPesquisa
LOCAL oNil
LOCAL cNil  := ""
LOCAL nTipo := 0
LOCAL oFolder
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define dialogo...                                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
DEFINE MSDIALOG oDlg TITLE cCadastro FROM 008.2,008.3 TO 020,060 OF GetWndDefault()
oDlg:lEscClose := .F.
odlg:nwidth    := 603
odlg:ntop      := 155
odlg:nleft     := 100

@ 014,003 FOLDER oFolder SIZE 196,069 OF oDlg PIXEL PROMPTS "Sequencia do Arquivo <F5>",;
"Funcional do Beneficiario <F6>",;
"Nome do Beneficiario <F7>"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Configura Keys...                                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
SetKey(VK_F5 ,{|| oFolder:SetOption(1) })
SetKey(VK_F6 ,{|| oFolder:SetOption(2) })
SetKey(VK_F7 ,{|| oFolder:SetOption(3) })
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Folder Sequencia do Arquivo...                                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

cCODLDP := BCI->BCI_CODLDP

@ 020,005 SAY "Numero do Arquivo      :" SIZE 100,010 PIXEL OF oFolder:aDialogs[1] //
@ 018,075 MSGET oPes01 VAR cPEG PICTURE "@!"  SIZE 035,010 PIXEL OF oFolder:aDialogs[1]

@ 005,005 SAY "Codigo Operadora       :" SIZE 100,010 PIXEL OF oFolder:aDialogs[1] //
@ 003,075 MSGET oPes02 VAR cCodOpe PICTURE "@R !.!!!" SIZE 010,010 PIXEL OF oFolder:aDialogs[1] F3 "B89" hasbutton

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Folder Codigo do Beneficiario...                                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
@ 020,005 SAY "Codigo Rede Atend.  :" SIZE 100,010 PIXEL OF oFolder:aDialogs[2] //
@ 018,075 MSGET oPes04 VAR cCodRDA PICTURE "@!"  SIZE 035,010 PIXEL OF oFolder:aDialogs[2]

@ 005,005 SAY "Codigo Operadora       :" SIZE 100,010 PIXEL OF oFolder:aDialogs[2] //
@ 003,075 MSGET oPes05 VAR cCodOpe PICTURE "@R !.!!!" SIZE 010,010 PIXEL OF oFolder:aDialogs[2] F3 "B89" hasbutton
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Folder Nome do Beneficiario...                                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
@ 005,005 SAY "Nome da Rede Atend.   :" SIZE 100,010 PIXEL OF oFolder:aDialogs[3] //
@ 003,075 MSGET oPes06 VAR cNomRDA PICTURE "@!" SIZE 100,010 PIXEL OF oFolder:aDialogs[3]

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Ativa dialogo...                                                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

ACTIVATE MSDIALOG oDlg ON INIT Eval( { || EnChoiceBar(oDlg,bOK,bCancel,.F.,{}) }) CENTERED
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Desativa keys...                                                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
SET KEY VK_F5  TO
SET KEY VK_F6  TO
SET KEY VK_F7  TO

If nTipo <> 0
	Do Case
		Case nTipo == 1
			CB007LOC(cCodOpe,nTamPEG,cNumSeq,"1")
		Case nTipo == 2
			CB007LOC(cCodOpe,nil,nil,"2",cCodRDA,nil,nTamBen)
		Case nTipo == 3
			CB007LOC(nil,nil,nil,"3",nil,cNomRDA)
	EndCase
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Fim da Rotina...                                                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Return

/*/
//ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
//±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
//±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
//±±³Programa  ³ CB007LOC ³ Autor ³ Luzio Tavares       ³ Data ³ 12.12.2008 ³±±
//±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄ´±±
//±±³Descri‡„o ³ Localiza os registros que atendem ao criterio informado    ³±±
//±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
//±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
//ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function CB007LOC(cCodOpe,nTamPEG,cNumSeq,cTipo,cCodBen,cNomBen)

LOCAL cSQL
LOCAL cCodPeg
LOCAL cAlias
LOCAL cChave
LOCAL cNumAux
LOCAL lRet 		 := .T.
LOCAL cNumero	 := ""

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Sequencia...                                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If cTipo == "1" .And. ! Empty(cNumSeq)
	DbSelectArea("ZZ0")
	DbSetOrder(1)
	lRet := MsSeek(xFilial("ZZ0")+StrZero(Val(cNumSeq),nTamPEG))
	If !lRet
		Help("",1,"PLSA498LOC")
	Endif
ElseIf cTipo == "2" .And. !Empty(cCodBen)
	DbSelectArea("ZZ1")
	DbSetOrder(5)
	lRet := MsSeek(xFilial("ZZ1")+StrZero(Val(cCodBen),nTamBen))
	If !lRet
		Help("",1,"PLSA498LOC")
	Endif
ElseIf cTipo == "3" .And. !Empty(cNomBen)
	DbSelectArea("ZZ1")
	DbSetOrder(6)
	lRet := MsSeek(xFilial("ZZ1")+AllTrim(cNomBen))
	If !lRet
		Help("",1,"PLSA498LOC")
	Endif
Endif
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Fim da Rotina...                                                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Return(lRet)
*/

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±±
±±³Funcao    ³ VerTipReg  ³ Autor ³ Luzio Tavares       ³ Data ³ 12.12.08 ³±±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±±
±±³Descricao ³ Verifica se ja existe o codigo de dependencia do           ³±±±
±±³          ³ beneficiario                                               ³±±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function VerTipReg(cMatric,cGrauPa,cTipReg,cTipUsu)
Local nOrdBA1 := BA1->(IndexOrd())

If cTipUsu == "T"  //Se for titular
	Return(cTipReg)
Endif

cDepend := PLS260Cha(1,cGrauPa,cTipReg,cTipUsu,cMatric)

Return(cDepend)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ PLS260Cha  ³ Autor ³ Michele Tatagiba    ³ Data ³ 19.12.01 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Chama a funcao PLSTIPREG no gatilho dos campos BA1_GRAUPA e|±±
±±³          ³ BA1_TIPUSU                                                 ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function PLS260Cha(cTipo,cGrauPa,cTipReg,cTipUsu,cMatric)
LOCAL cRet
Local aArea := GetArea()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Tipo = 1 -> Retorna o TipoReg do usuario                                             |
//³ Tipo = 2 -> Retorna True caso o Tipreg retorne correto                               |
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cRet := Eval( {|aEl| aEl[1]}, PLSTipReg(cGrauPa,cTipReg,cTipUsu,cMatric, .T.))
RestArea(aArea)

Return(cRet)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ PLSTipReg  ³ Autor ³ Luzio Tavares       ³ Data ³ 12.12.08 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Calcula o proximo tipo de registro de cada usuario .       |±±
±±³          ³ Utilizado no gatilho do campo BA1_GRAUPA e BA1_TIPUSU      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Alteracoes desde sua construcao inicial.                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Data     ³ BOPS ³ Programador ³ Breve Descricao                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function PLSTipReg(cGrauPa,cTipReg,cTipUsu,cMatric, lConsiste)
Local aArea := GetArea()
LOCAL cSeqIni 	:= "00"
LOCAL cSeqFim 	:= "00"
LOCAL cSeq    	:= cTipReg
LOCAL lRet    	:= .T.
LOCAL lExitFor	:= .F.
LOCAL nInd    	:= 1
LOCAL aRetTpUsr := {}
Local cSql := ""

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Parametro que indica qual o modelo a ser utilizado pela Instituicao de saude  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
LOCAL cModelo := GetMv("MV_PLTITCD")

If cTipReg == "00"
	RestArea(aArea)
	Return({cSeq,lRet})
EndIf

cSql := "SELECT BA1_TIPREG "
cSql += " FROM  "+RetSqlName("BA1")+" BA1 "
cSql += " WHERE BA1_FILIAL = '  '"
cSql += " AND BA1_CODINT||BA1_CODEMP||BA1_MATRIC = '"+ cMatric + "' "
cSql += " AND D_E_L_E_T_ = ' ' "

PLsQuery(cSql,"BA1TRB")
BA1TRB->(dbGoTop())

While !BA1TRB->(EOF())
	aadd(aRetTpUsr,{BA1TRB->(BA1_TIPREG)})
	BA1TRB->(DbSkip())
EndDo
BA1TRB->(DbCloseArea())

nPos := Ascan(aRetTpUsr,{ |x| x[1] == cSeq })
If nPos == 0
	RestArea(aArea)
	Return({cSeq,lRet})
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifico se o grau de parentesco pesquisado, possui sequencia inicial e final ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If Empty(cGrauPa)
	RestArea(aArea)
	Return({cSeq,lRet})
Endif

BT2->(DBSetOrder(1))
lRet := BT2->(MsSeek(xFilial("BT2")+cGrauPa))

If lRet
	cSeqIni := BT2->BT2_SEQDE
	cSeqFim := BT2->BT2_SEQATE
	cSeq    := cSeqIni
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Pesquiso no aCols do usuario, algum usuario com o grau de parentesco que estou pesquisando³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	
	//		cSeq := StrZero((Val(cSeq)+1),2)
	While .T.
		nPos := Ascan(aRetTpUsr,{ |x| x[1] == cSeq })
		If nPos == 0
			lExitFor := .T.
			Exit
		Else
			cSeq := StrZero((Val(cSeq)+1),2)
		Endif
	Enddo
EndIf

RestArea(aArea)

Return({cSeq,lRet})

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ EstBM1     ³ Autor ³ Luzio Tavares       ³ Data ³ 12.12.08 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Estorna a cobranca de mensalidades com vencimentos apos a  ³±±
±±³          ³ data da exclusao                                           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Alteracoes desde sua construcao inicial.                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Data     ³ BOPS ³ Programador ³ Breve Descricao                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function EstBM1(cMatric,cDepend)
Local aArea := GetArea()
LOCAL lRet    	:= .T.
LOCAL aRetTpUsr := {}
Local cSql := ""
Local aNivCob	:= {}
Local aDadosPar := {}
Local aDadosUsr := {}
Local nVlDesc	:= 0
Local cMatSiga	:= cMatric
Local lGravou	:= .F.
Local lRepete	:= .F.

cAnoFat := SubStr(DtoS(BA1->BA1_DATBLO),1,6)

cSql := "SELECT BM1.R_E_C_N_O_ RECBM1 "
cSql += " FROM  "+RetSqlName("BM1")+" BM1 "
cSql += " WHERE BM1_FILIAL = '  '"
cSql += " AND BM1_CODINT||BM1_CODEMP||BM1_MATRIC||BM1_TIPREG = '"+ cMatric+cDepend + "' "
cSql += " AND BM1_ANO||BM1_MES > '"+ cAnoFat + "' "
cSql += " AND BM1_CODTIP = '101' "
cSql += " AND D_E_L_E_T_ = ' ' "

PLsQuery(cSql,"BM1TRB")
BM1TRB->(dbGoTop())

Do While !BM1TRB->(Eof())
	
	BM1->(DbGoTo(BM1TRB->RECBM1))
	
	//	If DtoS(BA1->BA1_DATBLO) > BM1->(BM1_ANO+BM1_MES)+"01"
	If BM1->(BM1_ANO+BM1_MES)+"01" > DtoS(BA1->BA1_DATBLO)
		
		cAnoAdi := BM1->BM1_ANO
		cMesAdi := BM1->BM1_MES
		
		nVlDesc := BM1->BM1_VALOR
		
		aNivCob := U_RetNivCob(BM1->(BM1_CODINT+BM1_CODEMP+BM1_MATRIC+BM1_TIPREG+BM1_DIGITO))
		
		If Len(aNivCob) > 0
			
			aadd(aDadosPar,{cAnoAdi+cMesAdi,nVlDesc,cMesAdi+"/"+cAnoAdi,GetNewPar("MV_YESTMES","018"),"","","_"+ alltrim(BA1->BA1_MATEMP)+" - "+BM1->(BM1_CODINT+BM1_CODEMP+BM1_MATRIC+BM1_TIPREG+BM1_DIGITO)+" - LANCTO AUTOMATICO ESTORNO DE MENSALIDADE ITAU"})
			
			aadd(aDadosUsr,BM1->BM1_CODINT)
			aadd(aDadosUsr,BM1->BM1_CODEMP)
			aadd(aDadosUsr,"")				   //BM1->BM1_MATRIC)
			aadd(aDadosUsr,BM1->BM1_CONEMP)
			aadd(aDadosUsr,BM1->BM1_VERCON)
			aadd(aDadosUsr,BM1->BM1_SUBCON)
			aadd(aDadosUsr,BM1->BM1_VERSUB)
			aadd(aDadosUsr,aNivCob[1,1])
			//			aadd(aDadosUsr,"")               //BM1->(BM1_CODINT+BM1_CODEMP+BM1_MATRIC+BM1_TIPREG+BM1_DIGITO))
			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Valida se ja existe adicional para o usuario, do mesmo tipo para o mes...³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If BSQ->(MsSeek(xFilial("BSQ")+BM1->(BM1_CODINT+BM1_CODEMP+BM1_CONEMP+BM1_VERCON)+cAnoAdi+cMesAdi))
				
				While !BSQ->(Eof()) .And. BSQ->(BSQ_CODINT+BSQ_CODEMP+BSQ_CONEMP+BSQ_VERCON+BSQ_ANO+BSQ_MES) == BM1->(BM1_CODINT+BM1_CODEMP+BM1_CONEMP+BM1_VERCON)+cAnoAdi+cMesAdi
					
					If BSQ->BSQ_MATRIC == BM1->BM1_MATRIC .And. BSQ->BSQ_COBNIV == aNivCob[1,1] .And. BSQ->BSQ_CODLAN == GetNewPar("MV_YESTMES","014")
						lRepete := .T.
					Endif
					BSQ->(DbSkip())
					
				Enddo
				
			Endif
			
			If !lRepete
				
				lGravou := U_GerAdNeg(aDadosPar,aDadosUsr,"")
				
				If !lGravou
					aadd(aErro_,{"Não foi possível gerar o adicional para o mês solicitado! Usuário: "+cMatSiga})
				Else
					aadd(aOk,{BA1->BA1_CODINT+"."+BA1->BA1_CODEMP+"."+BA1->BA1_MATRIC+"."+BA1->BA1_TIPREG+"-"+BA1->BA1_DIGITO,Substr(BA1->BA1_NOMUSR,1,30),Transform(nVlDesc,"@E 999,999,999.99")})
				Endif
			Else
				aadd(aErro_,{"Já existe adicional gravado nestes parâmetros no mês solicitado! Usuário: "+cMatSiga})
			Endif
		Else
			aadd(aErro_,{"Não foi encontrado nível de cobrança para o usuário "+cMatSiga})
		Endif
	EndIf
	BM1TRB->(DbSkip())
EndDo

DbSelectArea("BM1TRB")
BM1TRB->(DbCloseArea())

RestArea(aArea)

Return()

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ CB007REL   ³ Autor ³ Luzio Tavares     ³ Data ³ 12.12.2008 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Relatorio de conferencia dos dados do arquivo              ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function CB007REL(cAlias,nReg,nOpc)

LOCAL oDlg
LOCAL nOpca   := 0
LOCAL oEnc
LOCAL bOK     := { || nOpca := 1, oDlg:End() }
LOCAL bCancel := { || oDlg:End() }
LOCAL cSeq := ZZ0->ZZ0_SEQUEN
LOCAL cSQL, lDeleta

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define variaveis padroes para todos os relatorios...                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
PRIVATE nQtdLin     := 60
PRIVATE nLimite     := 220  //132
PRIVATE cTamanho    := "G"  //"M"
PRIVATE cTitulo     := "Relatorio por Classe da Rede de Atendimento"
PRIVATE cDesc1      := "Emitir a Quantidade de Rede de Atendimento por Classe."
PRIVATE cDesc2      := ""
PRIVATE cDesc3      := ""
PRIVATE cAlias      := "BAU"
PRIVATE cPerg       := "CABR17"
PRIVATE cRel        := "CABR017"
PRIVATE nli         := 61
PRIVATE m_pag       := 1
PRIVATE lCompres    := .T.   //.F.  // Habilita/Desabilita o Formato Comprimido/Expandido
PRIVATE lDicion     := .F.
PRIVATE lFiltro     := .T.
PRIVATE lCrystal    := .F.
//PRIVATE aOrderns    := {}
PRIVATE aOrdens     := {"Classe da RDA + Especialidade","Especialidade + UF + Cidade","UF + Especialidade","Cidade + Regiao"}
Private nTipo		  := 15
Private aReturn := { "Zebrado", 1,"Administracao", 1, 1, 1, "",1 }

PRIVATE lAbortPrint := .F.
PRIVATE cCabec1     := "Classe                                          Especialidade                             UF Cidade            Regiao                         CEP       Bairro                         Total"
PRIVATE cCabec2     := ""
PRIVATE nColuna     := 01
PRIVATE aLinha      := {}
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Dados do parametro...                                                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
PRIVATE cCodRedDe  := mv_par01 // Codigo da Rede de atendimento de
PRIVATE cCodRedAte := mv_par02 // Codigo da Rede de atendimento ate
PRIVATE cCodEspDe  := mv_par03 //
PRIVATE cCodEspAte := mv_par04 //
PRIVATE cDistribuido := MV_PAR16
PRIVATE nAtivo     := mv_par03 // Somente ativos (Sim;Nao;Ambos)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Testa ambiente do relatorio somente top...                               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If ! PLSRelTop()
	Return
Endif
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas selecionadas                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
AjustaSX1(cPerg)
Pergunte(cPerg,.F.)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Chama SetPrint (padrao)                                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cRel  := SetPrint(cAlias,cRel,cPerg,@cTitulo,cDesc1,cDesc2,cDesc3,lDicion,aOrdens,lCompres,cTamanho,{},lFiltro,lCrystal)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica se foi cancelada a operacao (padrao)                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If  nLastKey == 27
	Set Filter To
	Return
End
cCodClaDe    := Mv_Par01
cCodClaAte   := Mv_Par02
cCodRdaDe    := mv_par03 // Codigo da Rede de atendimento de
cCodRdaAte   := mv_par04 // Codigo da Rede de atendimento ate
cCodEspDe    := mv_par05
cCodEspAte   := mv_par06
cCodUFDe     := Mv_Par07
cCodUFAte    := Mv_Par08
cCodCEPDe    := Mv_Par09
cCodCEPAte   := Mv_Par10
cCodMunDe    := Mv_Par11
cCodMunAte   := Mv_Par12
cCodRegDe    := Mv_Par13
cCodRegAte   := Mv_Par14
cSepBairro   := Mv_Par15
cDistribuido := MV_PAR16
nAnaSin      := MV_PAR17
nTipEnd      := MV_PAR18

nAtivo     := mv_par05

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Configura impressora (padrao)                                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
SetDefault(aReturn,cAlias)

If  nLastKey == 27
	Set Filter To
	Return
End

nTipo := If(aReturn[4]==1,15,18)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Processa relatorio                                                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Processa({|| CB007IMP() }, "Processando Informacoes...", "", .T.)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Libera spool                                                                       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Set Filter To
If  aReturn[5] == 1
	Set Printer To
	Commit
	Ourspool(cRel)    // Chamada do Spool de Impressao
Endif
MS_FLUSH()             // Libera fila de relatorios em spool

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Fim da rotina                                                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa   ³CABR017Imp³ Autor ³ Luzio tavaers         ³ Data ³ 07/11/08 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao  ³ Imprime detalhe do relatorio...                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
/*/
Static Function CBR007Imp()
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define variaveis...                                                      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local cArqTrab  := CriaTrab(nil,.F.)
Local cArqTrab1 := CriaTrab(nil,.F.)

LOCAL cSQL
LOCAL nOrdem  := aReturn[8]
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Cadastro da Rede de Atendimento...                                       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
LOCAL cBAUName := RetSQLName("BAU")
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define variaveis de trabalho...                                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
LOCAL cCodRed
LOCAL cCampX3
LOCAL cCampCb
LOCAL cContX3
LOCAL cTypeX3
LOCAL cArqOrd
LOCAL cArqSek
LOCAL cSx3Sek
LOCAL cCampBx
LOCAL cResuBx
LOCAL lAux
LOCAL cOper  := ""

Local nTotal   := 0    // recebe o n total de registros
Local nProc    := 1    // incrementado por unidade de registro
Local	Npercent := 0
Local aQtdClaRda := {}

Local aStruct  := { {"CLARDA", "C", 3, 0}, {"CODESP", "C", 3, 0}, {"BAIRRO", "C", 20, 0}, {"CODMUN", "C", 07, 0}, {"CODUF", "C", 02, 0}, {"REGIAO", "C", 08, 0}, {"CODCEP", "C", 08, 0}, {"QTDPRF", "N", 10, 0} }
Local cArqTot  := CriaTrab(aStruct, .T.)
////dbUseArea(,,cArqTot,"TOT",.F.)
//DBUSEAREA( .T., "TOPCONN", "AC8010", "TMP", .T., .F.)
DBUSEAREA(.T., __LocalDriver, cArqTot, "TOT", .F., .F.)

////DBUSEAREA( ,__LocalDriver, cArqTot, "TOT",.F.,.F.)
IndRegua ( "TOT",cArqTot,"CLARDA+CODESP+CODUF+CODMUN+REGIAO+BAIRRO+CODCEP",,,"Selecionando Registros...")
//IndRegua ( "TOT",Left(cArqTot,7)+"B","CLARDA+CODUF+CODMUN+REGIAO+CODESP+BAIRRO+CODCEP",,,"Selecionando Registros...")
//IndRegua ( "TOT",Left(cArqTot,7)+"C","CODUF+CLARDA+CODMUN+REGIAO+CODESP+BAIRRO+CODCEP",,,"Selecionando Registros...")
//IndRegua ( "TOT",Left(cArqTot,7)+"D","CODUF+CODMUN+CLARDA+REGIAO+CODESP+BAIRRO+CODCEP",,,"Selecionando Registros...")

//dbSelectArea("TOT")
//dbClearIndex()
//dbSetIndex(Left(cArqTot,7)+"A"+OrdBagExt())
//dbSetIndex(Left(cArqTot,7)+"B"+OrdBagExt())
//dbSetIndex(Left(cArqTot,7)+"C"+OrdBagExt())
//dbSetIndex(Left(cArqTot,7)+"D"+OrdBagExt())
//dbSetOrder(1)

////ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
////³ Exibe mensagem...                                                        ³
////ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//MsProcTxt(PLSTR0001)

//cDistribuido := 2

If cDistribuido == 2   //!Empty(cClaRDAAte)  // So considerada a separacao por Classe da Rede de Atendimento
	cCabec1 := "Classe                                            Total"
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Faz filtro no arquivo...                                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cSQL := "SELECT * "
If !Empty(cCodEspAte) .and. Val(cCodEspAte) > 0 .and. cDistribuido == 2
	cSQL += "FROM "+RetSQLName("BAU")+" BAU, "+RetSQLName("BBF")+" BBF, "+RetSQLName("BID")+" BID "
Else
	cSQL += "FROM "+RetSQLName("BAU")+" BAU, "+RetSQLName("BID")+" BID "
EndIf
cSQL += "WHERE BAU_FILIAL = '"+xFilial("BAU")+"' "
cSQL += "AND BAU_CODIGO BETWEEN '"+cCodRDADe+"' AND '"+cCodRDAAte+"' "
cSQL += "AND BAU_TIPPRE BETWEEN '"+cCodClaDe+"' AND '"+cCodClaAte+"' "
cSQL += "AND BAU.D_E_L_E_T_ = ' ' "
cSQL += "AND BID_CODMUN = BAU_MUN "
cSQL += "AND BID.D_E_L_E_T_ = ' ' "

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ De acordo com parametro mv_par03 : bloqueado ou nao                      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//If      nAtivo == 1 //ativo
//	cSQL += " AND BAU_CODBLO = ' ' "
//ElseIf  nAtivo == 2 //bloqueado
//	cSQL += " AND BAU_CODBLO <> ' ' "
//Endif
If !Empty(cCodEspAte) .and. Val(cCodEspAte) > 0  .and. cDistribuido == 2
	cSQL += " AND BBF_CODIGO = BAU_CODIGO "
	cSQL += " AND BBF_CODESP BETWEEN '"+cCodEspDe+"' AND '"+cCodEspAte+"' "
EndIf

If nTipEnd = 1
	If !Empty(cCodUfAte)
		cSelect2 += "AND BAU_EST BETWEEN '"+cCodUfDe+"' AND '"+cCodUfAte+"' "
	ElseIf !Empty(cCodCEPAte)
		cSelect2 += "AND BAU_CEP BETWEEN '"+cCodCEPDe+"' AND '"+cCodCEPAte+"' "
	ElseIf !Empty(cCodMunAte)
		cSelect2 += "AND BAU_CODMUN BETWEEN '"+cCodMunDe+"' AND '"+cCodMunAte+"' "
		//         ElseIf !Empty(cCodRegAte)
		//				cSelect2 += "BB8_EST BETWEEN '"+cCodRegDe+"' AND '"+cCodRegAte+"' AND "
	ElseIf !Empty(cCodRegAte)   ///.and. !cCodRegAte $ ('zzzz_ZZZZ')
		cSelect2 += "AND BID_YAREA BETWEEN '"+cCodRegDe+"' AND '"+cCodRegAte+"' "
		//         ElseIf !Empty(cCodRegAte)
		//				cSelect2 += "BB8_EST BETWEEN '"+cCodRegDe+"' AND '"+cCodRegAte+"' AND "
	EndIf
EndIf
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Se houver filtro executa parse para converter expressoes adv para SQL    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If ! Empty(aReturn[7])
	cSQL += " AND (" + PLSParSQL(aReturn[7])+" ) "
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ De acordo com a ordem....                                                ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//If      nOrdSel == 1
//	cSQL += "ORDER BY BAU_TIPPRE, BAU_MUN, BAU_EST, BAU_BAIRRO "
//ElseIf  nOrdSel == 2
//	cSQL += "ORDER BY BAU_TIPPRE "
//Endif
cSQL += "ORDER BY BAU_TIPPRE, BAU_MUN, BAU_EST, BAU_BAIRRO "

//memowrit("C:\CABR017_1.SQL",cSQL)

PLSQuery(cSQL,cArqTrab)
(cArqTrab)->(DbGotop())

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta regua                                                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
(cArqTrab)->(DBEval( { | | nTotal++ }))
(cArqTrab)->( DbGotop())
ProcRegua(nTotal)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Inicio da impressao dos detalhes...                                      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
While (cArqTrab)->(! Eof())
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Exibe mensagem...                                                  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	Npercent := (nProc/nTotal)*100
	IncProc("Processando: " + Transform(Npercent,"@E 9,999.9") + "  % do Total de: "+ Transform(nTotal,"@E 9999999"))
	ProcessMessage()
	
	nProc++
	
	//Agrupa por Classe da Rede de Atendimento
	cClaRDA    := (cArqTrab)->BAU_TIPPRE
	cCodUF     := (cArqTrab)->BAU_EST
	cCodMun    := (cArqTrab)->BAU_MUN
	cCodBairro := (cArqTrab)->BAU_BAIRRO
	
	If TOT->( !DbSeek(cClaRDA))
		//		IncRegua()
		dbSelectArea("TOT")
		TOT->(dbAppend())
		TOT->CLARDA 		:= cClaRDA
		TOT->CODESP 		:= ""
		TOT->BAIRRO    	:= ""
		TOT->CODMUN    	:= ""
		TOT->CODUF   		:= ""
		TOT->REGIAO 		:= ""
		TOT->CODCEP 		:= ""
		TOT->QTDPRF  		+= 1
	Else
		TOT->QTDPRF 		+= 1
	EndIf
	
	If cDistribuido == 2   //!Empty(cClaRDAAte)  // So considerada a separacao por Classe da Rede de Atendimento
		//		nPosCod  := aScan(aQtdClaRda,{|x|x[1] == cClaRDA})
		//		If nPosCod == 0
		//			Aadd( aQtdClaRDA, {cClaRDA,"","","","","","",1} )
		//		Else
		//			aQtdClaRDA[nPosCod,8] := aQtdClaRDA[nPosCod,8]+1
		//		EndIf
		
	ElseIf !Empty(cCodEspAte) .or. !Empty(cCodUfAte) .or. !Empty(cCodCEPAte) .or. !Empty(cCodMunAte)
		cSelect1 := "SELECT * FROM "+RetSQLName("BAX")+" BAX "
		If !Empty(cCodUfAte) .or. !Empty(cCodCEPAte) .or. !Empty(cCodMunAte) // .or. !Empty(cCodRegAte)
			cSelect1 := "SELECT BB8_CODMUN, BB8_EST, BB8_CEP, BB8_DATBLO, BB8_BAIRRO, BID_YAREA, BAX.* FROM "+RetSQLName("BAX")+" BAX, "+RetSQLName("BB8")+" BB8, "+RetSQLName("BID")+" BID "
			cSelect2 := "AND BB8_FILIAL = '"+xFilial("BB8")+"' "
			cSelect2 += "AND BB8_CODIGO = BAX_CODIGO "
			cSelect2 += "AND BB8_CODLOC = BAX_CODLOC "
			cSelect2 += "AND BB8_DATBLO = '        ' "
			cSelect2 += "AND BB8.D_E_L_E_T_ = ' ' "
			cSelect2 += "AND BID_CODMUN = BB8_CODMUN "
			cSelect2 += "AND BID.D_E_L_E_T_ = ' ' "
			If !Empty(cCodUfAte)
				cSelect2 += "AND BB8_EST BETWEEN '"+cCodUfDe+"' AND '"+cCodUfAte+"' "
			ElseIf !Empty(cCodCEPAte)
				cSelect2 += "AND BB8_CEP BETWEEN '"+cCodCEPDe+"' AND '"+cCodCEPAte+"' "
			ElseIf !Empty(cCodMunAte)
				cSelect2 += "AND BB8_CODMUN BETWEEN '"+cCodMunDe+"' AND '"+cCodMunAte+"' "
				//         ElseIf !Empty(cCodRegAte)
				//				cSelect2 += "BB8_EST BETWEEN '"+cCodRegDe+"' AND '"+cCodRegAte+"' AND "
			ElseIf !Empty(cCodRegAte)   ///.and. !cCodRegAte $ ('zzzz_ZZZZ')
				cSelect2 += "AND BID_YAREA BETWEEN '"+cCodRegDe+"' AND '"+cCodRegAte+"' "
				//         ElseIf !Empty(cCodRegAte)
				//				cSelect2 += "BB8_EST BETWEEN '"+cCodRegDe+"' AND '"+cCodRegAte+"' AND "
			EndIf
		EndIf
		cSQL := "WHERE BAX_FILIAL = '"+xFilial("BAX")+"' "
		cSQL += "AND BAX_CODIGO = '"+(cArqTrab)->BAU_CODIGO+"' "
		//		cSQL += "AND BAX_CODINT = '"+(cArqTrab)->BAU_CODINT+"' "
		cSQL += "AND BAX_CODESP BETWEEN '"+cCodEspDe+"' AND '"+cCodEspAte+"' "
		//		cSQL += "AND BAX_CODSUB = '"+BFN->BFN_CODSUB+"' "
		cSQL += "AND BAX_DATBLO = '       ' "
		cSQL += "AND BAX.D_E_L_E_T_ = ' ' "
		
		//		memowrit("C:\CABR017_"+(cArqTrab)->BAU_CODIGO+".SQL",cSelect1+cSQL+cSelect2)
		//		memowrit("C:\CABR017_2.SQL",cSelect1+cSQL+cSelect2)
		
		PLSQuery(cSelect1+cSQL+cSelect2,"BAXTRB")
		BAXTRB->(DbGotop())
		
		While !BAXTRB->(Eof())
			/*
			aQtdClaRDA[1] = Codigo da Classe da Rede de Atendimento
			aQtdClaRDA[2] = Codigo da Especialidade
			aQtdClaRDA[3] = Codigo da Bairro
			aQtdClaRDA[4] = Codigo da Municipio
			aQtdClaRDA[5] = Codigo da UF
			aQtdClaRDA[6] = Codigo da Regiao
			aQtdClaRDA[7] = CEP
			aQtdClaRDA[8] = Quantidade de Profissionais
			*/
			cCodEsp    := BAXTRB->BAX_CODESP
			
			cCodUF     := BAXTRB->BB8_EST
			cCodMun    := BAXTRB->BB8_CODMUN
			cCodBairro := IIf(cSepBairro == 1,BAXTRB->BB8_BAIRRO,"")
			cCodRegiao := IIf(cDistribuido == 1,BAXTRB->BID_YAREA,"")
			cCodCep    := ""  //BAXTRB->BB8_CEP
			
			//			nPosCod  := aScan(aQtdClaRda,{|x|x[1]+x[2]+x[3]+x[4]+x[5]+x[6]+x[7] == cClaRDA+cCodEsp+cCodBairro+cCodMun+cCodUF+cCodRegiao+cCodCep})
			
			//			If nPosCod == 0
			//				Aadd( aQtdClaRDA, {cClaRDA,cCodEsp,cCodBairro,cCodMun,cCodUf,cCodRegiao,cCodCep,1} )
			//			Else
			//				aQtdClaRDA[nPosCod,8] := aQtdClaRDA[nPosCod,8]+1
			//			EndIf
			
			If TOT->( !DbSeek(cClaRDA+cCodEsp))
				//					IncRegua()
				TOT->(dbAppend())
				TOT->CLARDA 		:= cClaRDA
				TOT->CODESP 		:= cCodEsp
				TOT->BAIRRO    	:= ""
				TOT->CODMUN    	:= ""
				TOT->CODUF   		:= ""
				TOT->REGIAO 		:= ""
				TOT->CODCEP 		:= ""
				TOT->QTDPRF  		+= 1
			Else
				TOT->QTDPRF 		+= 1
			EndIf
			
			If TOT->( !DbSeek(cClaRDA+cCodEsp+cCodUF+cCodMun+cCodRegiao+cCodBairro+cCodCep))
				TOT->(dbAppend())
				TOT->CLARDA 		:= cClaRDA
				TOT->CODESP 		:= cCodEsp
				TOT->BAIRRO    	:= cCodBairro
				TOT->CODMUN    	:= cCodMun
				TOT->CODUF   		:= cCodUF
				TOT->REGIAO 		:= cCodRegiao
				TOT->CODCEP 		:= cCodCEP
				TOT->QTDPRF  		+= 1
			Else
				TOT->QTDPRF 		+= 1
			EndIf
			
			DbSelectArea("BAXTRB")
			BAXTRB->(DbSkip())
		EndDo
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Fecha arquivo...                                                   ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		BAXTRB->(DbCloseArea())
	EndIf
	
	DbSelectArea(cArqTrab)
	(cArqTrab)->(DbSkip())
Enddo

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Ordena array aTitulos                                               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If  nOrdem == 1
	dbSetOrder(1)
	//		aSort(aQtdClaRda,,, { |x,y| x[1]+x[2]+x[5]+x[4]+x[6]+x[7]+x[3] < y[1]+y[2]+y[5]+y[4]+y[6]+y[7]+y[3] })
ElseIf nOrdem == 2
	dbSetOrder(2)
	//		aSort(aQtdClaRda,,, { |x,y| x[1]+x[2]+x[5]+x[4]+x[6]+x[7]+x[3] < y[1]+y[2]+y[5]+y[4]+y[6]+y[7]+y[3] })
Endif

nTotal   := 0    // recebe o n total de registros
nProc    := 1    // incrementado por unidade de registro
npercent := 0

dbSelectArea("TOT")
TOT->( DbGotop())

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta regua                                                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
TOT->(DBEval( { | | nTotal++ }))
TOT->( DbGotop())
ProcRegua(nTotal)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Inicio da impressao dos detalhes...                                      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
While TOT->(! Eof())
	
	Npercent := (nProc/nTotal)*100
	IncProc("Fase 2 - Processando: " + Transform(Npercent,"@E 9,999.9") + "  % do Total de: "+ Transform(nTotal,"@E 9999999"))
	ProcessMessage()
	
	nProc++
	
	cClaRDA := TOT->CLARDA
	
	IncProc("Imprimindo...")
	ProcessMessage()
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifica se foi abortada a impressao...                            ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If Interrupcao(lAbortPrint)
		nLi ++
		@ nLi, nColuna pSay PLSTR0002
		Exit
	Endif
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Imprime cabecalho...                                                     ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If nLi > nQtdLin
		nLi := Cabec(cTitulo,cCabec1,cCabec2,cRel,cTamanho,nTipo)
		nLi ++
	Endif
	
	@ nLi, 000 pSay cClaRDA+" - "+Alltrim(Posicione("BAG",1,xFilial("BAG")+Alltrim(cClaRDA),"BAG_DESCRI"))
	@ nLi, 050 pSay Transform(TOT->QTDPRF,"@E 999999")   //Total
	nLi ++
	
	While TOT->(! Eof()) .AND. 	TOT->CLARDA == cClaRDA .and. cDsitribuido == 1
		cEspRDA := TOT->CODESP
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Imprime cabecalho...                                                     ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If nLi > nQtdLin
			nLi := Cabec(cTitulo,cCabec1,cCabec2,cRel,cTamanho,nTipo)
			nLi ++
		Endif
		
		@ nLi, 005 pSay Posicione("BAQ",1,xFilial("BAQ")+PLSINTPAD()+cEspRDA,"BAQ_DESCRI")  //Especialidade
		@ nLi, 050 pSay Transform(nQtdEspRDA,"@E 999999")   //Total
		nLi ++
		
		While TOT->(! Eof()) .and. TOT->CLARDA == cClaRDA .and. TOT->ESPRDA == cEspRDA
			cCodUF     := CodUF
			While TOT->(! Eof()) .and. TOT->CLARDA == cClaRDA .and. TOT->ESPRDA == cEspRDA .and. TOT->CODUF == cCodUF
				nQtdUF += 1
				TOT->(DbSkip())
			EndDo
			If nQtdUF > 0
				@ nLi, 010 pSay cCodUF    //Posicione("BAQ",1,xFilial("BAQ")+PLSINTPAD()+cUF,"BAQ_DESCRI")  //UF
				@ nLi, 050 pSay Transform(nQtdUF,"@E 999999")   //Total
			EndIf
		EndDo
		
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Imprime Classe...                                                  ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ                              1                                                                                                   2
		//0....+....1....+....2....+....3....+....4....+....5....+....6....+....7....+....8....+....9....+....0....+....1....+....2....+....3....+....4....+....5....+....6....+....7....+....8....+....9....+....0....+....1....+....2
		//Classe                                          Especialidade                             UF Cidade                          Regiao                         CEP       Bairro                         Total
		//CLI - CLINICAS MEDICAS                          CLINICA MEDICA                            RJ RIO DE JANEIRO                  123456789012345678901234567890 01000-000 123456789012345678901234567890 123456
		//Classe                                            Total
		//CLI - CLINICAS MEDICAS                            999999
		//     PEDIATRIA 												 	                                                                                        ....+....1....+....2....+....3....+....4....+....5
		//          RIO DE JANEIRO
		
		////			@ nLi, 048 pSay Posicione("BAQ",1,xFilial("BAQ")+PLSINTPAD()+Alltrim(aQtdClaRda[n,2]),"BAQ_DESCRI")  //Especialidade
		////			@ nLi, 090 pSay aQtdClaRda[n,5]   //UF
		//			@ nLi, 093 pSay Posicione("BID",1,xFilial("BID")+Alltrim(aQtdClaRda[n,4]),"BID_DESCRI")  //Cidade
		//			@ nLi, 125 pSay aQtdClaRda[n,6]  //Regiao
		//			@ nLi, 156 pSay aQtdClaRda[n,7]  //CEP
		//			@ nLi, 166 pSay aQtdClaRda[n,3]  //Bairro
		//			@ nLi, 197 pSay Transform(aQtdClaRda[n,8],"@E 999999")   //Total
		//			nLi ++
		//		Else
		//			@ nLi, 050 pSay Transform(aQtdClaRda[n,8],"@E 999999")   //Total
		//		nLi ++
	EndDo
EndDo
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Imprime rodape do relatorio...                                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Roda(0,space(10),cTamanho)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Fecha arquivo...                                                   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
(cArqTrab)->(DbCloseArea())

dbSelectArea("TOT")
dbCloseArea()
FERASE(cArqTot+GetDBExtension())
Ferase(cArqTot+OrdBagExt())

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Fim do Relat¢rio                                                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa   ³ BloqUsu ³ Autor ³ Luzio tavaers         ³ Data  ³ 13/01/09 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao  ³ Insere o Historico de Bloqueio do Beneficiario             ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
/*/
Static Function BloqUsu(cMatric,cDepend,cMatAnt,dDatBlo,cMotBlo)

BCA->(RecLock("BCA",.T.))
BCA->BCA_FILIAL := xFilial("BCA")
BCA->BCA_MATRIC := cMatric
BCA->BCA_TIPREG := cDepend
If ZZ1->ZZ1_OPERSI $("07_08_09_10_06_04")   //ZZ1->ZZ1_OPER == "03"
	
	If (ZZ1->ZZ1_OPER == "02" .AND. ZZ1->ZZ1_OPERSI == "04")
		BCA->BCA_DATA := CtoD(ZZ1->ZZ1_DTINCO)-1
	ElseIf ZZ1->ZZ1_OPER == "03"
		BCA->BCA_DATA := dDatBlo
	Else
		BCA->BCA_DATA := iif(ZZ1->ZZ1_OPER $ "04_05",CtoD(ZZ1->ZZ1_DTINPD)-1,CtoD(ZZ1->ZZ1_DTINCT)-1)
	EndIf
	BCA->BCA_TIPO   := "0"
	BCA->BCA_MOTBLO := cMotBlo
	BCA->BCA_OBS    := "Bloqueado pela Importacao, arquivo:"+ cPath + ZZ0->ZZ0_NOMARQ
Elseif ZZ1->ZZ1_OPERSI $ ("11_03_01")   //ZZ1->ZZ1_OPER == "06"
	BCA->BCA_TIPO   := "1"
	BCA->BCA_DATA   := dDataBase
	BCA->BCA_OBS    := "Desbloqueado pela Importacao, arquivo:"+ cPath + ZZ0->ZZ0_NOMARQ
Endif
BCA->BCA_MATANT := cMatAnt
BCA->BCA_BLOFAT := "1"
BCA->BCA_NIVBLQ := "U"
BCA->BCA_USUOPE := cUserName
BCA->(MsUnlock())

Return()

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa   ³ BloqFam ³ Autor ³ Luzio tavaers         ³ Data  ³ 13/01/09 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao  ³ Insere o Historico de Bloqueio da Familia                  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
/*/
Static Function BloqFam(cMatric,cMatAnt,dDatBlo,cMotBlo,cMatEmp)

BC3->(Reclock("BC3",.T.))
BC3->BC3_FILIAL := xFilial("BC3")
BC3->BC3_MATRIC := cMatric
BC3->BC3_TIPO   := "0"
BC3->BC3_DATA   := dDatBlo
BC3->BC3_MOTBLO := cMotBlo
BC3->BC3_OBS    := "Historico de transferencia"
BC3->BC3_MATANT := cMatAnt
BC3->BC3_BLOFAT := "1"
BC3->BC3_NIVBLQ := "F"
BC3->BC3_USUOPE := cUserName
BC3->(MsUnlock())

Return()

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFuncao    ³RelEst    º Autor ³ Luzio Tavares      º Data ³  15/10/08   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescri‡„o ³ Funcao para imprimir os lancamentos de debitos.            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³                                                            º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
//Static Function RelEst(aHeader,aTrailler)
Static Function RelEst()

Local nLin := 80
Local nImp := 1

PRIVATE nQtdLin     := 60
PRIVATE nLimite     := 220  //132
PRIVATE cTamanho    := "G"  //"M"
PRIVATE cTitulo     := "Lancamentos de Creditos Realizados para beneficiarios do Excluidos"
PRIVATE cDesc1      := "Apresentar os beneficiarios excluidos que tiveram lancamento de credito gerado pela rotina."
PRIVATE cDesc2      := ""
PRIVATE cDesc3      := ""
PRIVATE cAlias      := "ZZ1"
//PRIVATE cPerg       := "CABR17"
Private cNomeprog    := "CABR007"
PRIVATE cRel        := "CABA007"
PRIVATE nli         := 61
PRIVATE m_pag       := 1
PRIVATE lCompres    := .T.   //.F.  // Habilita/Desabilita o Formato Comprimido/Expandido
PRIVATE lDicion     := .F.
PRIVATE lFiltro     := .T.
PRIVATE lCrystal    := .F.
//PRIVATE aOrdens     := {"Classe da RDA + Especialidade","Especialidade + UF + Cidade","UF + Especialidade","Cidade + Regiao"}
Private nTipo		  := 15
Private aReturn := { "Zebrado", 1,"Administracao", 1, 1, 1, "",1 }

PRIVATE lAbortPrint := .F.
//PRIVATE cCabec1     := "Classe                                          Especialidade                             UF Cidade            Regiao                         CEP       Bairro                         Total"
PRIVATE cCabec1     := "Cod. Usuario            Nome Usuário                   Vlr. Desconto"
PRIVATE cCabec2     := ""
PRIVATE nColuna     := 01

nTipo:=GetMv("MV_COMP")

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Imprime cabecalho...                                                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
For nImp := 1 to Len(aHeader)
	
	If nLin > nQtdLin
		Cabec(cTitulo,cCabec1,cCabec2,cNomeProg,cTamanho,nTipo)
		nLin := 9
	Endif
	
	@ nLin, 000 PSay aHeader[nImp,1]+aHeader[nImp,2]
	nLin++
Next

@ nLin, 000 PSay replicate("-",132)
nLin++

nLin := 80

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Imprime titulos, com valores de mensalidade e coparticipacao.    		 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cCabec2     := "Cod. Usuario            Nome Usuário                   Vlr. Desconto"
For nImp := 1 to Len(aOk)
	
	If nLin > nQtdLin
		Cabec(cTitulo,cCabec1,cCabec2,cNomeProg,cTamanho,nTipo)
		nLin := 9
	Endif
	
	@ nLin, 000 PSay aOk[nImp,1]+Space(2)+aOk[nImp,2]+Space(2)+aOk[nImp,3]
	nLin++
	
Next

@ nLin,   000 PSay replicate("-",132)
nLin := 80

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Imprime relatorio de adicionais de debito criados pela imp. convenio...  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cCabec2     := "Totalizador / Trailler do Arquivo"
For nImp := 1 to Len(aTrailler)
	
	If nLin > nQtdLin
		Cabec(cTitulo,cCabec1,cCabec2,cNomeProg,cTamanho,nTipo)
		nLin := 9
	Endif
	
	@ nLin, 000 PSay aTrailler[nImp,1]+Space(2)+Iif(aTrailler[nImp,3],Transform(aTrailler[nImp,2],"@E 999,999,999.99"),"")
	nLin++
	
Next
nLin := 80

cCabec2     := "Erros encontrados no estorno de mensalidade do beneficiario."
For nImp := 1 to Len(aErro_)
	
	If nLin > nQtdLin
		Cabec(cTitulo,cCabec1,cCabec2,cNomeProg,cTamanho,nTipo)
		nLin := 9
	Endif
	
	@ nLin, 000 PSay aErro[nImp,1]
	nLin++
	
Next

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³EMAIL     ºAutor  ³Luzio Tavares       º Data ³  28/02/09   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Envia email de notificação ao responsável quando o arquivo º±±
±±º          ³ de retorno do Itau eh gerado                               º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ MICROSIGA                                                  º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function enviaemail(cNomArq,nQtdReg,nQtdErros)
Local lRet       := .F.
Local cMsg       := ""
Local cEmail 	  := ""
Local cEmailCoor := ""
Local lCoSemMail := .F.		// Indica se as pessoas estão sem e-mail
Local cAttach    := ""
Local cProcNam := "GERA_HELPDESK_ITAU"

Local cAssunto := "Movimento Itau " + cNomArq + " - Data " + DtoC(dDataBase)

aResult := {}
aResult := TCSPExec("GERA_HELPDESK_ITAU",cNomArq)
If !Empty(aResult)
	lRet := .T.
EndIf

Return( lRet )

/*

cMsg := "Processado o arquivo Itau " + cNomArq
cMsg += CRLF + CRLF
cMsg += "Total Reg. " + StrZero(nQtdReg,6) + ", processados com erro " + StrZero(nQtdErros,6)

//cEmail := "desenvolvimento@caberj.com.br" + ";"
cEmail := "luzio@rrsistema.com.br" + ";"
// Adciona os destinatarios para copia
//cEmailCoor += "piumbim@caberj.com.br;casemiro@caberj.com.br;motta@caberj.com.br" + ";"

If ! Empty( cEmail ) .or. ! Empty( cEmailCoor )
//	lRet := ACSendMail( ,,,, cEmail + cEmailCoor, cAssunto, cMsg )
lRet := ACSendMail('microsiga@caberj.com.br','micro123','10.19.7.13',, cEmail+cEmailCoor, cAssunto, cMsg )
EndIf

Return( lRet )
*/
