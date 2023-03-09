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
User Function CABA007C()
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta matriz com as opcoes do browse...                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
PRIVATE aRotina   	:=	{	{ "Pesquisar"	, 'AxPesqui'	    , 0 , K_Pesquisar  },;
{ "Visualizar"	 , 'AxVisual'	    , 0 , K_Visualizar },;
{ "I&mportar"	 , 'U_CB007B1INS'   , 0 , K_Incluir    },;
{ "C&riticar"	 , 'U_CB007B1C'   , 0 , K_Incluir    },;
{ "&Excluir"	 , 'U_CB007B1E'   , 0 , K_Excluir    },;
{ "&Inserir BD" ,  'U_CB007B1APP'   , 0 , K_Incluir    },;
{ "Ex&portar"	 , 'U_CB007B1X'   , 0 , K_Incluir    },;
{ "&Gerar rel." ,  'U_CB007B1REL'   , 0 , K_Incluir    },;
{ "&Composicao" ,  'U_CB007B1M'   , 0 , K_Incluir    },;
{ "Legenda"     ,  "U_CB007B1LEG(1)", 0 , K_Incluir    },;
{ "Historico"   ,  "U_CB007B1PES"   , 0 , K_Pesquisar  } }

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
User Function CB007B1APP(cAlias,nReg,nOpc)

Local n := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

Local cDirExp	:= "\interface\importa\itaubenef\recebidos\financeiro\"
Local cNomeArq	:= ""
Local cEOL		:= CHR(13)+CHR(10)
Local cCpo		:= ""
local ncont := 0

Private cArqDbf
Private aLancBSQ := {}
PRIVATE nHdl

If ZZ0->ZZ0_STATUS == "2"
	ZZ1->(DbSetOrder(2))
	If ZZ1->(DbSeek(xFilial("ZZ1")+ZZ0->ZZ0_SEQUEN))
		
		If Select("TmpBSQ") > 0
			DbSelectArea("TmpBSQ")
			TmpBSQ->(DbCloseArea())
			Ferase("TmpBSQ")
		Endif
		
		cArqDbf := Alltrim(cDirExp+"TmpBSQ.DBF")
		
		For nCont := Len(alltrim(cArqdbf)) to 0 step -1
			cChar := Substr(cArqdbf,nCont,1)
			If cChar $ "/\"
			Exit
			Endif
		Next
		cArqTmp := Substr(cArqDbf,nCont+1)
				
		dbUseArea(.T.,"DBFCDXADS",cArqDbf,"TMPBSQ",.T.,.F.)   //"TOPCONN"
				
		cNomeArq := cDirExp+"usuadesb.TXT"
		
		If U_Cria_TXT(cNomeArq)
			
			nCont := 0
			While !ZZ1->(EOF()) .And. ZZ1->ZZ1_SEQUEN == ZZ0->ZZ0_SEQUEN
				If alltrim(ZZ1->ZZ1_OPER) == "03" //Bloqueio de beneficiario.
					AlteraUsr(3)   //Exclusao de beneficiario
				Endif
				
				//			If nCont > 500 //Len(aLancBSQ) > 3
				//				Exit
				//			EndIf
				ZZ1->(DbSkip())
				nCont += 1
			Enddo
			U_Fecha_TXT()
			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Mudo o status do arquivo colocando como Inserido no BD                ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			ZZ0->(RecLock("ZZ0",.F.))
			ZZ0->ZZ0_STATUS := "3"
			ZZ0->ZZ0_DTINSB := dDatabase
			ZZ0->(MsUnlock())
			
		Endif
		TmpBSQ->(DbCloseArea())
		
		If Len(aLancBSQ) > 0
			
			cNomeArq := cDirExp+"TmpBSQ.TXT"
			
			If U_Cria_TXT(cNomeArq)
				
				For n = 1 to Len(aLancBSQ)
					
					cLin := Space(1)+cEOL
					cCpo :=	aLancBSQ[n,1]+";"
					cCpo :=	aLancBSQ[n,2]+";"
					cCpo :=	aLancBSQ[n,3]+";"
					cCpo :=	aLancBSQ[n,4]+";"
					cCpo :=	aLancBSQ[n,5]+";"
					cCpo :=	aLancBSQ[n,6]+";"
					cCpo :=	aLancBSQ[n,7]+";"
					cCpo :=	aLancBSQ[n,8]+";"
					cCpo :=	aLancBSQ[n,9]+";"
					cCpo :=	aLancBSQ[n,10]+";"
					cCpo :=	aLancBSQ[n,11]+";"
					cCpo :=	aLancBSQ[n,12]+";"
					cCpo :=	aLancBSQ[n,13]+";"
					cCpo :=	aLancBSQ[n,14]+";"
					cCpo :=	aLancBSQ[n,15]+";"
					cCpo :=	aLancBSQ[n,16]+";"
					cCpo :=	aLancBSQ[n,17]+";"
					cCpo :=	aLancBSQ[n,18]+";"
					cCpo :=	aLancBSQ[n,19]+";"
					cCpo :=	aLancBSQ[n,20]+";"
					cCpo :=	aLancBSQ[n,21]+";"
					cCpo :=	aLancBSQ[n,22]+";"
					cCpo :=	aLancBSQ[n,23]+";"
					cCpo :=	aLancBSQ[n,24]+";"
					cCpo :=	aLancBSQ[n,25]+";"
					cCpo :=	aLancBSQ[n,26]+";"
					cCpo :=	aLancBSQ[n,27]+";"
					cCpo :=	aLancBSQ[n,28]+";"
					cCpo :=	aLancBSQ[n,29]
					
					If !(U_GrLinha_TXT(cCpo,cLin))
						MsgAlert("ATENÇÃO! NÃO FOI POSSIVEL GRAVAR CORRETAMENTE O REGISTRO TRAILLER! OPERAÇÃO ABORTADA!")
						Return
					Endif
					
				Next
				U_Fecha_TXT()
			EndIf
		EndIf
	EndIf
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
User Function CB007B1INS(cAlias,nReg,nOpc)

Local I__f := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

LOCAL oDlg
LOCAL nOpca   := 0
LOCAL oEnc
LOCAL aRet
LOCAL bOK     := {|| nOpca := 1, oDlg:End()}
LOCAL bCancel := {|| nOpca := 0, oDlg:End()}
Local CSqlArq := ""
Local cUSqArq := ""

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
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Inclui movimento...                                                 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	M->ZZ0_QTDLID := CB007IMP(oEnc:aGets,oEnc:aTela,M->ZZ0_NOMARQ,oDlg)
	M->ZZ0_DTIMPO := dDatabase
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
±±³Programa  ³ CB007IMP   ³ Autor ³ Luzio Tavares     ³ Data ³ 15.05.2006 ³±±
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

Local nTipArq
Local _aArea    := GetArea()
Local cArqTmp	:= ""
Local nCont		:= 0
Local cChar     := space(0)

Private cArqDbf

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
cDirLido  := GetNewPar("MV_XPATHCL","\interface\importa\itaubenef\processados\")
cDirErro  := GetNewPar("MV_XPATHCE","\interface\importa\itaubenef\erro\")

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

If Select("EXCLUIR") > 0
	DbSelectArea("EXCLUIR")
	REATIVAR->(DbCloseArea())
	Ferase(cNomeArq)
Endif

cArqDbf := Alltrim(cPath+M->ZZ0_NOMARQ)
nPos := AT(".DBF",Upper(cArqDbf))
If !File(cArqDbf)
	MsgBox('Arquivo '+cArqDbf+' nao encontrado. Verifique.','Erro no Processo','ALERT')
	Return
EndIf
If nPos == 0
	MsgBox('Arquivo '+cArqDbf+' invalido. So eh possivel importar arquivo com a extensao DBF. Verifique.','Erro no Processo','ALERT')
	Return
EndIf

For nCont := Len(alltrim(cArqdbf)) to 0 step -1
	cChar := Substr(cArqdbf,nCont,1)
	If cChar $ "/\"
		Exit
	Endif
Next
//cArqTmp := Substr(cArqDbf,nCont+1)
cArqTmp := Substr(cArqDbf,nCont+1)

cFileDest := Alltrim(cDirLido+alltrim(cArqTmp))

dbUseArea(.T.,"DBFCDXADS",cArqDbf,"EXCLUIR",.F.,.F.)

EXCLUIR->(DBGOTOP())

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Defino o tamanho da linha mais os 2 caracteres de fim de linha      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
nTamLinha := M->ZZ0_NROBYT+2

cRet := "00"
nNumLin := 0

M->ZZ0_CTREMP := EXCLUIR->CONTR
//M->ZZ0_LINHA  := SubStr(cBuffer, 1,1000)
//M->ZZ0_SEQARQ := SubStr(cBuffer,88,6)
M->ZZ0_DATGER := "26/02/2010"  //SubStr(cBuffer,97,10)  //Data da geracao do Arquivo
M->ZZ0_HORGER := "160000"   //SubStr(cBuffer,107,6)  //Hora da geracao do Arquivo
M->ZZ0_CODEMP := "0010"

While ( ! EXCLUIR->(EOF()) )
	
	nNumLin += 1
	
	ZZ1->(RecLock("ZZ1",.T.))
	ZZ1->ZZ1_OPER   := EXCLUIR->OPER
	ZZ1->ZZ1_SEQUEN := M->ZZ0_SEQUEN
	ZZ1->ZZ1_NUMLIN := strzero(nNumLin,6,0)
	ZZ1->ZZ1_FUNC   := EXCLUIR->FUNCIO
	ZZ1->ZZ1_DEPEND := EXCLUIR->DEPEND
	ZZ1->ZZ1_BENEF  := EXCLUIR->BENEF
	ZZ1->ZZ1_CDBENE := EXCLUIR->CDBENE              //Condicao do Beneficario
	ZZ1->ZZ1_DTDESL := EXCLUIR->DTDESL
	ZZ1->ZZ1_CONTR  := EXCLUIR->CONTR
	ZZ1->ZZ1_FILIT  := EXCLUIR->FILIT
	ZZ1->ZZ1_PADRAO := EXCLUIR->PADRAO
	ZZ1->ZZ1_CODEMP := EXCLUIR->CODEMP
	//	ZZ1->ZZ1_INDCAR := EXCLUIR->A
	
	cAcao := ""
	ZZ1->ZZ1_OPERSI := VEROPER(@cAcao)
	ZZ1->ZZ1_DESOPE := cAcao
	
	ZZ1->(MsUnlock())
	
	nRet++
	
	EXCLUIR->(DbSkip())
	
Enddo

M->ZZ0_LINT := Strzero(nRet,6,0)

EXCLUIR->(DbCloseArea())

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
User Function CB007B1E(cAlias,nReg,nOpc)

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
±±³Programa  ³ CB007CRI   ³ Autor ³ Luzio Tavares     ³ Data ³ 16.05.2006 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Critica Arquivo ja importado                               ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function CB007B1C(cAlias,nReg,nOpc)

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
	
	ZZ1->(DbSetOrder(2))
	If ZZ1->(DbSeek(xFilial("ZZ1")+ZZ0->ZZ0_SEQUEN))
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
			If At(Alltrim(ZZ1->ZZ1_OPER),'01_02_03_04_05_06') == 0
				cErro := cErro + "001"   //Tipo Operacao Invalido
				aadd(aErro, {ZZ0->ZZ0_SEQUEN, ZZ1->ZZ1_NUMLIN, "001", "Tipo Operacao Invalido"})
			EndIf
			If Type(ZZ1->ZZ1_FUNC) != 'N'
				cErro := cErro + "002"  //Funcional Invalida
				aadd(aErro, {ZZ0->ZZ0_SEQUEN, ZZ1->ZZ1_NUMLIN, "002", "Funcional Invalida"})
			EndIf
			
			If !VerFami(ZZ1->ZZ1_FUNC)
				cErro := cErro + "003"   //Funcional nao existe na Base
				aadd(aErro, {ZZ0->ZZ0_SEQUEN, ZZ1->ZZ1_NUMLIN, "003", "Funcional nao existe na Base"})
			EndIf
			
			If !ZZ1->ZZ1_DEPEND >= '00' .And. !ZZ1->ZZ1_DEPEND <= '99'
				cErro := cErro + "004"   //Codigo Dependente Invalido
				aadd(aErro, {ZZ0->ZZ0_SEQUEN, ZZ1->ZZ1_NUMLIN, "004", "Codigo Dependente Invalido"})
			EndIf
			
			If !(alltrim(ZZ1->ZZ1_OPER) $ '01_04') .and.;
				(!VerFunc(Iif(ZZ1->ZZ1_CDBENE == 'T',ZZ1->ZZ1_FUNC+'00',ZZ1->(ZZ1_FUNC+ZZ1_DEPEND))) .or.;
				!VerBA1(ZZ1->(ZZ1_FUNC+ZZ1_DEPEND)))
				cErro := cErro + "005"  //Codigo Dependente nao Existe na Base
				aadd(aErro, {ZZ0->ZZ0_SEQUEN, ZZ1->ZZ1_NUMLIN, "005", "Codigo Dependente nao Existe na Base"})
			EndIf
			
			If Empty(AllTrim(ZZ1->ZZ1_BENEF))
				cErro := cErro + "006"  //Nome do Beneficiario Invalido
				aadd(aErro, {ZZ0->ZZ0_SEQUEN, ZZ1->ZZ1_NUMLIN, "006", "Nome do Beneficiario Invalido"})
			EndIf
			
			If At(Alltrim(ZZ1->ZZ1_TPBENE),'01_02_03_04_05_06_07_08_09') == 0
				cErro := cErro + "013"   // Tipo Beneficiario Invalido
				aadd(aErro, {ZZ0->ZZ0_SEQUEN, ZZ1->ZZ1_NUMLIN, "013", "Tipo Beneficiario Invalido"})
			EndIf
			If At(Alltrim(ZZ1->ZZ1_CDBENE),'T_L_A') == 0
				cErro := cErro + "014"  //Condicao Beneficiario Invalido
				aadd(aErro, {ZZ0->ZZ0_SEQUEN, ZZ1->ZZ1_NUMLIN, "014", "Condicao Beneficiario Invalido"})
			EndIf
			
			If Empty(AllTrim(ZZ1->ZZ1_CONTR))
				cErro := cErro + "027"  //Codigo do Contrato Invalido
				aadd(aErro, {ZZ0->ZZ0_SEQUEN, ZZ1->ZZ1_NUMLIN, "027", "Codigo do Contrato Invalido"})
			EndIf
			If !chkPadrao(ZZ1->ZZ1_PADRAO,ZZ1->ZZ1_OPER,ZZ1->ZZ1_FUNC,ZZ1->ZZ1_DEPEND,DParaTpBnf(ZZ1->ZZ1_CDBENE))  //Verifica em qual produto Saude ira alocar o beneficiario
				cErro := cErro + "028"   //Codigo Padrao Invalido - 0001 - Apartamento, 0002 - Enfermaria
				aadd(aErro, {ZZ0->ZZ0_SEQUEN, ZZ1->ZZ1_NUMLIN, "028", "Codigo Padrao Invalido - 0001 - Apartamento, 0002 - Enfermaria"})
			EndIf
			
			If alltrim(ZZ1->ZZ1_OPER) == '03' .and. !chkData(ZZ1->ZZ1_FUNC,ZZ1->ZZ1_DEPEND,ZZ1->ZZ1_CDBENE,ZZ1->ZZ1_DTDESL,3) .and. !Empty(ctod(ZZ1->ZZ1_DTDESL))
				cErro := cErro + "036"   //Data da Exclusao no Plano Invalida
				aadd(aErro, {ZZ0->ZZ0_SEQUEN, ZZ1->ZZ1_NUMLIN, "036", "Data da Exclusao no Plano Invalida"})
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
			
			ZZ1->(RecLock("ZZ1",.F.))
			ZZ1->ZZ1_TABERR := cErro
			cAcao := ""
			ZZ1->ZZ1_OPERSI := VEROPER(@cAcao)
			ZZ1->ZZ1_DESOPE := cAcao
			ZZ1->(MsUnlock())
			
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
±±³Funcao    ³ CB007LEG   ³ Autor ³ Wagner Mobile Costa ³ Data ³ 28.08.03 ³±±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±±
±±³Descricao ³ Exibe a legenda...                                         ³±±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function CB007B1LEG(nTipo)
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
±±³Funcao    ³ CB007CMP   ³ Autor ³ Luzio Tavares       ³ Data ³ 28.08.03 ³±±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±±
±±³Descricao ³ Mostra Composicao do Arquivo                               ³±±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function CB007B1M
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
	lRet := .F.
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
Static Function VerFami(cMatric)
Local nOrdBA3 := BA3->(IndexOrd())
Local lRet    := .T.

BA3->(dbSetOrder(5))
If !BA3->(dbSeek(xFilial("BA3")+ZZ0->ZZ0_CODEMP+cMatric))
	lRet := .F.
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
Static Function VerBA1(cMatric,cOper)
Local nOrdBA1 := BA1->(IndexOrd())
Local lRet    := .T.

BA1->(dbSetOrder(6))
If !BA1->(DbSeek(xFilial("ZZ1")+cMatric))
	lRet := .F.
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

if ZZ0->ZZ0_CODEMP == "0010"  // Itau
	if ! (cPadrao $ "0109_0208_0307_0406_0218_0317_0327")
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
	
	If !(cPadrao $ cTempPadrao)  // Se nao encontrou o produto para o referido grupo empresa
		Return (.F.)
	Endif
Endif

//Busca o produto na familia
//Somente quando for operacao diferente de inclusao ou transferencia
//Deve verificar somente para os caso de inclusao, transferencia entre planos, trasnferencia entre operadoras, mas somente para dependentes.
If !(alltrim(cOper) $ "01")
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
		cProduto := "0055"
	Endif
Elseif cPadrao == "0208"
	if cTipo == "A"
		cProduto := "0016"
	EndIf
Elseif cPadrao == "0218"
	if cTipo != "A"
		cProduto := "0056"
	EndIf
Elseif cPadrao == "0307"
	if cTipo == "A"
		cProduto := "0015"
	EndIf
Elseif cPadrao == "0317"
	if cTipo != "A"
		cProduto := "0057"
	endIf
Elseif cPadrao == "0327"
	if cTipo != "A"
		cProduto := "0058"
	Endif
Elseif cPadrao == "0406"
	if cTipo == "A"
		cProduto := "0014"
	Else
		cProduto := "0059"
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
If cTipo == "L"   //Legal
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
Local cSql := space(0)
Local cEOL := CHR(13)+CHR(10)
Local cCpo := ""
Local cLin := Space(1)+cEOL

If nMatric <> NIL
	cChave := ZZ1->ZZ1_FUNANT
EndIf

lTit := ZZ1->ZZ1_CDBENE == 'T'   //Se o beneficiario for o Titular do contrato

If lTit
	cSql := "SELECT * FROM "+RetSqlName("BA3")
	cSql += " Where BA3_FILIAL = '"+xFilial("BA3")+"' "
	cSql += " AND BA3_CODINT = '"+ZZ0->ZZ0_CODOPE+"'"
	cSql += " AND BA3_CODEMP = '"+ZZ0->ZZ0_CODEMP+"'"
	//	cSql += " AND BA3_CONEMP = '"+cNumCon+"'"
	//	cSql += " AND BA3_VERCON = '001' "
	//	cSql += " AND BA3_SUBCON = '"+cSubCon+"' "
	//	cSql += " AND BA3_VERSUB = '001' "
	cSql += " AND BA3_MATEMP = '"+AllTrim(ZZ1->ZZ1_FUNC)+"' "
	cSql += " AND BA3_DATBLO = ' ' "
	cSql += " AND D_E_L_E_T_ = ' ' "
	cSql += " ORDER BY R_E_C_N_O_ DESC "
	PLsQuery(cSql,"TMPBA3")
	If !TMPBA3->(EOF())
		While !TMPBA3->(EOF())
			//BA3->(dbSetOrder(5))
			//If BA3->(dbSeek(xFilial("BA1")+ZZ0->ZZ0_CODEMP+cChave)) .And. lTit  //Somente se o beneficiario for o Titular do contrato
			BA3->(dbgoto(TMPBA3->R_E_C_N_O_))
			BA3->(RecLock("BA3",.F.))
			BA3->BA3_MOTBLO	:=	iif(!Empty(CtoD(alltrim(ZZ1->ZZ1_MOTEXC))),dParaBlq(ZZ1->ZZ1_MOTEXC),"009")
			BA3->BA3_DATBLO	:=	ctod(ZZ1->ZZ1_DTDESL)
			BA3->(MsUnlock())
			ExcluiBA3(nTipo,.F.)

			cCpo :=	"F"+";"+ZZ1->ZZ1_FUNC+";"+ZZ1->ZZ1_DEPEND+";"+ZZ1->ZZ1_CDBENE+";"+ZZ1->ZZ1_SEQUEN+";"+ZZ1->ZZ1_NUMLIN+";"+ZZ1->ZZ1_BENEF+";"+BA3->BA3_CODINT+";"+BA3->BA3_CODEMP+";"+BA3->BA3_MATRIC+";;;"+BA3->BA3_CONEMP+";"+BA3->BA3_SUBCON+";"+strzero(TMPBA3->R_E_C_N_O_,12,0)
		
			If !(U_GrLinha_TXT(cCpo,cLin))
				MsgAlert("ATENÇÃO! NÃO FOI POSSIVEL GRAVAR CORRETAMENTE O REGISTRO TRAILLER! OPERAÇÃO ABORTADA!")
				Return
			Endif
			TMPBA3->(DbSkip())

		EndDo
	Endif
	TMPBA3->(DbCloseArea())
EndIf

cSql := "SELECT * FROM "+RetSqlName("BA1")
cSql += " Where BA1_FILIAL = '"+xFilial("BA1")+"' "
cSql += " AND BA1_CODINT = '"+ZZ0->ZZ0_CODOPE+"'"
cSql += " AND BA1_CODEMP = '"+ZZ0->ZZ0_CODEMP+"'"
//cSql += " AND BA1_CONEMP = '"+cNumCon+"'"
//cSql += " AND BA1_VERCON = '001' "
//cSql += " AND BA1_SUBCON = '"+cSubCon+"' "
//cSql += " AND BA1_VERSUB = '001' "
cSql += " AND BA1_MATEMP = '"+AllTrim(ZZ1->ZZ1_FUNC)+AllTrim(ZZ1->ZZ1_DEPEND)+"' "
cSql += " AND BA1_DATBLO = ' ' "
cSql += " AND D_E_L_E_T_ = ' ' "
cSql += " ORDER BY R_E_C_N_O_ DESC "
PLsQuery(cSql,"TMPBA1")
If !TMPBA1->(EOF())
	While !TMPBA1->(EOF())
		BA1->(dbgoto(TMPBA1->R_E_C_N_O_))
		//BA1->(dbSetOrder(6))
		//If BA1->(dbSeek(xFilial("BA1")+cChave+ZZ1->ZZ1_DEPEND))
		BA1->(RecLock("BA1",.F.))
		BA1->BA1_MOTBLO := iif(!Empty(Alltrim(ZZ1->ZZ1_MOTEXC)),dParaBlq(ZZ1->ZZ1_MOTEXC),"009")
		BA1->BA1_DATBLO := CtoD("01/03/2010")  //ZZ1->ZZ1_DTDESL)
		BA1->BA1_IMAGE  := 'DISABLE'
		BA1->BA1_CONSID := "U"
		BA1->BA1_BLOFAT := "1"
		BA1->BA1_IMPORT := ZZ1->ZZ1_SEQUEN + ZZ1->ZZ1_NUMLIN
		BA1->(MsUnlock())
		ExcluiBA1(nTipo,lTit)
		
		ZZ1->(RecLock("ZZ1",.F.))
		ZZ1->ZZ1_FUNANT := BA1->(BA1_MATRIC+BA1_TIPREG)
		ZZ1->(MsUnlock())

		cCpo :=	"U"+";"+ZZ1->ZZ1_FUNC+";"+ZZ1->ZZ1_DEPEND+";"+ZZ1->ZZ1_CDBENE+";"+ZZ1->ZZ1_SEQUEN+";"+ZZ1->ZZ1_NUMLIN+";"+ZZ1->ZZ1_BENEF+";"+BA1->BA1_CODINT+";"+BA1->BA1_CODEMP+";"+BA1->BA1_MATRIC+";"+BA1->BA1_TIPREG+";"+BA1->BA1_DIGITO+";"+BA1->BA1_CONEMP+";"+BA1->BA1_SUBCON+";"+strzero(TMPBA1->R_E_C_N_O_,12,0)
		
		If !(U_GrLinha_TXT(cCpo,cLin))
			MsgAlert("ATENÇÃO! NÃO FOI POSSIVEL GRAVAR CORRETAMENTE O REGISTRO TRAILLER! OPERAÇÃO ABORTADA!")
			Return
		Endif
		TMPBA1->(DbSkip())

	EndDo
Endif
TMPBA1->(DbCloseArea())

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
Static Function ExcluiBA3(nTipo,lAcao)
//Historico de Bloqueio
BloqFam(BA3->(BA3_CODINT+BA3_CODEMP+BA3_MATRIC),BA3->BA3_MATANT,CtoD(ZZ1->ZZ1_DTDESL),iif(!Empty(alltrim(ZZ1->ZZ1_MOTEXC)),dParaBlq(ZZ1->ZZ1_MOTEXC),"009"),BA3->BA3_MATEMP)
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
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function ExcluiBA1(nTipo,lTit,lAcao,cCobRetro)
//Historico de Bloqueio
BloqUsu(BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC),BA1->BA1_TIPREG,BA1->BA1_MATANT, CtoD(ZZ1->ZZ1_DTDESL), iif(!Empty(Alltrim(ZZ1->ZZ1_MOTEXC)),dParaBlq(ZZ1->ZZ1_MOTEXC),"009"))

//Estorna o valor da mensalidade gerada para cobrança futura, via lancamento de debito/credito
EstBM1(BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC),BA1->BA1_TIPREG)
Return

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
Static Function LOGERRO()
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
Static Function VEROPER(cAcao)
Local cTipo := ""

nRecno := BA1->(Recno())
nOrder := BA1->(IndexOrd())
BA1->(dbSetOrder(6))

If ctod(ZZ1->ZZ1_DTDESL) < dDatabase
	cTipo := "08"   //Exclusão retroativa
	cAcao := "Exclusão retroativa"
Elseif ctod(ZZ1->ZZ1_DTDESL) == dDatabase
	cTipo := "07"  //Exclusão normal
	cAcao := "Exclusão normal"
Else
	cTipo := "09"  //Exclusão posterior / Futura
	cAcao := "Exclusão posterior / Futura"
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
User Function CB007B1X(cAlias,nReg,nOpc)
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
				cCpo += TMPZZ1->ZZ1_DTDESL
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
		
		//		u_EnviaEmail(alltrim(ZZ0->ZZ0_NOMARQ),nReg,nQtdErros)
		
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
Static Function RELREGIMP(cAlias,nReg,nOpc)

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
cSql += " AND BM1_ANO||BM1_MES >= '"+ cAnoFat + "' "
cSql += " AND BM1_CODTIP = '101' "
cSql += " AND D_E_L_E_T_ = ' ' "

PLsQuery(cSql,"BM1TRB")
BM1TRB->(dbGoTop())

Do While !BM1TRB->(Eof())
	
	BM1->(DbGoTo(BM1TRB->RECBM1))
	
	//	If DtoS(BA1->BA1_DATBLO) > BM1->(BM1_ANO+BM1_MES)+"01"
	If BM1->(BM1_ANO+BM1_MES)+"01" >= DtoS(BA1->BA1_DATBLO)
		
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
				
				lGravou := GerAdNeg(aDadosPar,aDadosUsr,"")
				
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
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³GerAdNeg  ºAutor  ³Microsiga           º Data ³  10/19/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Gera adicionais de debito ao usuario, conforme negociacao   º±±
±±º          ³financeira (customizacao de baixa) ou ret. Rio Previdencia. º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CABERJ.                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function GerAdNeg(aDadosPar,aDadosUsr,cNumTit,cNumLot)
Local lRet	:= .F.
Local nCont	:= 0
Local cNivel := ""
Local lCalcNivCob := .F.
Local cA,cB

Private _cNroLote	:= ""
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Legenda Matriz aDadosPar[N,X]                                         ³
//³ 1-AnoMes - Caractere - 006 posicoes                                   ³
//³ 2-VlrPar - Numerico  - 017,4                                          ³
//³ 3-Mes/Ano- Caractere - 007 posicoes (MM/AAAA)                         ³
//³ 4-CodLan - Caractere - 003 posicoes                                   ³
//³ 5-CCusto - Numerico  - 009 posicoes                                   ³
//³ 6-IteCta - Caractere - 009 posicoes                                   ³
//³ 7-Observ - Caractere - 100 posicoes                                   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Legenda Vetor aDadosUsr[]                                             ³
//³ 1-CodInt - Caractere - 04 posicoes                                    ³
//³ 2-CodEmp - Caractere - 04 posicoes                                    ³
//³ 3-Matric - Caractere - 06 posicoes                                    ³
//³ 4-ConEmp - Caractere - 12 posicoes                                    ³
//³ 5-VerCon - Caractere - 03 posicoes                                    ³
//³ 6-SubCon - Caractere - 09 posicoes                                    ³
//³ 7-VerSub - Caractere - 03 posicoes                                    ³
//³ 8-NivCob - Caractere - 01 posicao (opcional)                          ³
//³ 9-CodUsu - Caractere - 17 posicao (opcional - mat.completa usr)       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

BSP->(DbSetOrder(1))
BSQ->(DbSetOrder(1))

_cNroLote := cNumLot

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Obtem nivel de cobranca, caso nao esteja na matriz de usuarios        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If Len(aDadosUsr) > 7
	If Empty(aDadosUsr[8])
		lCalcNivCob := .T.
	Endif
Else
	lCalcNivCob := .T.
Endif

If lCalcNivCob
	If !Empty(aDadosUsr[3])
		cNivel := '5'
		
	Elseif !Empty(aDadosUsr[6])
		cNivel := '3'
		
	Elseif !Empty(aDadosUsr[4])
		cNivel := '2'
		
	Elseif !Empty(aDadosUsr[2])
		cNivel := '1'
	Endif
Else
	cNivel := aDadosUsr[8]
Endif

For nCont := 1 to Len(aDadosPar)
	If BSP->(MsSeek(xFilial("BSP")+aDadosPar[nCont,4]))
		
		If aDadosPar[nCont,2] > 0
			
			if Len(aDadosUsr) > 8
				cA := aDadosUsr[9]
				cB := "5"
			EndIf
			If fPesqMovBsq(Substr(aDadosPar[nCont,1],5,2),Substr(aDadosPar[nCont,1],1,4),cNumTit)
//				aadd(aLancBSQ,{PLSA625Cd("BSQ_CODSEQ","BSQ",1,"D_E_L_E_T_"," "),aDadosUsr[1],aDadosUsr[2],aDadosUsr[3],aDadosUsr[4],aDadosUsr[5],aDadosUsr[6],aDadosUsr[7],cNivel,;
//				cA,cB,Substr(aDadosPar[nCont,1],1,4),;
//				Substr(aDadosPar[nCont,1],5,2),aDadosPar[nCont,4],	aDadosPar[nCont,2],"1",	aDadosPar[nCont,5],aDadosPar[nCont,6],	aDadosPar[nCont,7],	"1",BSP->BSP_TIPSER,"2","1",cNumTit})

				TMPBSQ->(Reclock("TMPBSQ",.T.))
				TMPBSQ->BSQ_FILIAL	:= xFilial("BSQ")
				TMPBSQ->BSQ_CODSEQ	:= PLSA625Cd("BSQ_CODSEQ","BSQ",1,"D_E_L_E_T_"," ")
				TMPBSQ->BSQ_CODINT  := aDadosUsr[1]
				TMPBSQ->BSQ_CODEMP	:= aDadosUsr[2]
				TMPBSQ->BSQ_MATRIC	:= aDadosUsr[3]
				TMPBSQ->BSQ_CONEMP	:= aDadosUsr[4]
				TMPBSQ->BSQ_VERCON	:= aDadosUsr[5]
				TMPBSQ->BSQ_SUBCON	:= aDadosUsr[6]
				TMPBSQ->BSQ_VERSUB	:= aDadosUsr[7]
				TMPBSQ->BSQ_COBNIV := cNivel
				If Len(aDadosUsr) > 8
					TMPBSQ->BSQ_USUARI	:= aDadosUsr[9]
					//Conforme regra de inclusao de debito/credito,
					//quando eh informado o campo BSQ_USUARI, o
					//nivel devera sempre ser 5
					TMPBSQ->BSQ_COBNIV := '5'
				Endif
				TMPBSQ->BSQ_ANO	:= Substr(aDadosPar[nCont,1],1,4)
				TMPBSQ->BSQ_MES	:= Substr(aDadosPar[nCont,1],5,2)
				TMPBSQ->BSQ_CODLAN	:= aDadosPar[nCont,4]
				TMPBSQ->BSQ_VALOR	:= aDadosPar[nCont,2]
				TMPBSQ->BSQ_NPARCE	:= "1"
				TMPBSQ->BSQ_CC		:= aDadosPar[nCont,5]
				TMPBSQ->BSQ_ITECTA	:= aDadosPar[nCont,6]
				TMPBSQ->BSQ_OBS	:= aDadosPar[nCont,7]
				TMPBSQ->BSQ_AUTOMA	:= "1"
				TMPBSQ->BSQ_TIPO	:= BSP->BSP_TIPSER
				TMPBSQ->BSQ_TIPEMP	:= "2"
				TMPBSQ->BSQ_ATOCOO	:= "1"
				TMPBSQ->BSQ_YNMSE1	:= cNumTit 
				TMPBSQ->BSQ_YABASE   := SE1->E1_ANOBASE 
				TMPBSQ->BSQ_YMBASE   := SE1->E1_MESBASE				
				If Type("_cNroLote") <> "U"
					TMPBSQ->BSQ_YNMLOT	:= _cNroLote
				Endif
				TMPBSQ->(MsUnlock())
			Endif
			lRet := .T.
		Endif
	Else
		lRet := .F.
		nCont := Len(aDadosPar)
	Endif
	
Next
//Conforme regra de inclusao de debito/credito,
//					//quando eh informado o campo BSQ_USUARI, o
//					//nivel devera sempre ser 5
//					'5',
//				Endif
//				Iif(Type("_cNroLote") <> "U",_cNroLote)

Return lRet

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³FUNCOES   ºAutor  ³Microsiga           º Data ³  10/17/08   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function fPesqMovBsq(_cMes,_cAno,cChave)
Local cQuery := " "
Local lRet   := .T.

cQuery := " SELECT COUNT(*) QTD FROM " + RetSqlName("BSQ")
cQuery += " WHERE "
cQuery += " BSQ_YNMSE1 = '" + cChave + "' AND "
cQuery += " BSQ_MES    = '" + _cMes  + "' AND "
cQuery += " BSQ_ANO    = '" + _cAno  + "' AND "
cQuery += " D_E_L_E_T_ = ' ' "

If Select("TRB2") >0
	dbSelectArea("TRB2")
	dbclosearea()
Endif

TCQuery cQuery Alias "TRB2" New

dbSelectArea("TRB2")

If TRB2->QTD > 0
	lRet := .F.
	Alert( " O TITULO " + cChave + ", NAO PODE SER GRAVADO NO MOVIMENTO DEBITO/CREDITO , FAVOR VERIFICAR SE EXISTE DUPLICIDADE !!!" )
Endif

Return lRet

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
User Function CB007B1REL(cAlias,nReg,nOpc)

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
±±³Programa   ³ BloqUsu  ³ Autor ³ Luzio Tavares         ³ Data ³ 13/01/09 ³±±
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

If (ZZ1->ZZ1_OPER == "02" .AND. ZZ1->ZZ1_OPERSI == "04")
	BCA->BCA_DATA := CtoD(ZZ1->ZZ1_DTINCO)-1
ElseIf ZZ1->ZZ1_OPER == "03"
	BCA->BCA_DATA := dDatBlo
Else
	BCA->BCA_DATA := iif(ZZ1->ZZ1_OPER $ "04_05",CtoD(ZZ1->ZZ1_DTINPD)-1,CtoD(ZZ1->ZZ1_DTINCT)-1)
EndIf
BCA->BCA_TIPO   := "0"
BCA->BCA_MOTBLO := "009"
BCA->BCA_OBS    := "Importado:"+ AllTrim(ZZ0->ZZ0_NOMARQ) +"-"+ZZ1->ZZ1_SEQUEN+"."+ ZZ1->ZZ1_NUMLIN

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
±±³Programa   ³ BloqFam  ³ Autor ³ Luzio tavaers         ³ Data ³ 13/01/0 9³±±
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
//BC3->BC3_OBS    := "Bloqueado pela Importacao, arquivo:"+ ZZ0->ZZ0_NOMARQ
BC3->BC3_OBS    := "Importado:"+ ZZ0->ZZ0_NOMARQ + ZZ1->ZZ1_SEQUEN + ZZ1->ZZ1_NUMLIN
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

Static Function enviaemail(cNomArq,nQtdReg,nQtdErros)
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
