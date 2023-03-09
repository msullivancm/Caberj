#include "PROTHEUS.CH"
#include "TOPCONN.CH"
#include "TBICONN.CH"
                         
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ IMPSDC  ³ Autor ³ Ricardo Mansi			³ Data ³ 08/04/05 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Importa as guias dos prestadores segundo                   ³±±
±±³          ³ lay out do sistema SDC.                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Observacao³ Rotina nao pode utilizar o conceito de Begin e End 		  ³±±
±±³          ³ transacion devido a inclusao automatica de usuarios de 	  ³±±
±±³          ³ intercambio eventual.								 	  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ Unimed Tubarao								              ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function IMPSDC

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Inicializa variaveis                                                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local nOpca       := 0
Local aSays       := {}
Local aButtons    := {}

Private cCadastro := "Importa movimentação de guias"
Private cPerg     := "IMPSDC"
Private cMaxName  := RetSQLName("BD7")
Private cArquivo  := ""
Private cOper4    := ""
Private cDir      := ""
Private cArq      := ""
Private cCodLdp   := ""
Private cCodigo   := ""
Private cPlano    := ""
Private cSubVer   := ""
Private cSubCon   := ""
Private cVersao   := ""
Private cCont     := ""
Private cVerpla   := ""
Private cCodRda   := ""
Private cNomArq   := ""
Private nProc     := 0
Private lRet      := .T.

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Ajusta perguntas...                                                      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
AjustaSX1(cPerg)
Pergunte(cPerg,.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta texto para janela de processamento                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
aAdd(aSays,"Esta rotina efetua a importação da movimentação de guias, conforme")
aAdd(aSays,"parâmetros informados, gerando uma PEG para cada tipo de guia.")
aAdd(aSays,"                                 ")
aAdd(aSays,"Permite 3 tipos de processamento:")
aAdd(aSays,"   Validar          >> Emite relatório e log de críticas")
aAdd(aSays,"   Imp Registros OK >> Valida e importa as guias sem críticas")
aAdd(aSays,"   Imp Arquivo   OK >> Valida e importa apenas se não houver nenhuma crítica")

aAdd(aButtons, { 5,.T.,{|| Pergunte(cPerg,.T. ) } } )
aAdd(aButtons, { 1,.T.,{|| nOpca:=1, If(ConaOk() .and. Ver_Perg(), FechaBatch(), nOpca:=0 ) }} )
aAdd(aButtons, { 2,.T.,{|| FechaBatch()}} )

FormBatch(cCadastro,aSays,aButtons)
	
If ! ValPerg()
	MsgAlert("Parâmetros incorretos!")
	Return
Endif

If nOpca == 1
	Proc_ImpCta()		// Executa a importacao de fato
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Fim da funcao                                                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Return
	
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ Ver_Perg ³ Autor ³ Thiago Machado Correa ³ Data ³ 08/04/05 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Verifica se parametros estao ok                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ Ver_Perg()                                                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ nenhum                                                     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function Ver_perg

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica se o arquivo existe no diretorio informado.                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

cArq := cGetFile("Arquivos de Importação (*.*) | *.*",OemToAnsi("Selecione o Arquivo"),,"",.F.,)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Atualiza parametros                                                      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cOper4   := mv_par01
cArquivo := alltrim(cArq)
//cCodRda  := mv_par04
nProc    := mv_par05
cCodLdp  := GetNewPar("MV_YCODLDP","0002")

If File(cArquivo)
	lRet := .T.
Else
	lRet := .F.
EndIf

Return(lRet)
	
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ Proc_ImpCta ³ Autor ³ Ricardo Mansi³ Data ³ 08/04/05 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Processa importacao da movimentacao de guias                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ Proc_ImpCta()                                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ nenhum                                                       ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function Proc_ImpCta()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define variaveis padroes para todos os relatorios...                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Private cOper3       := substr(cOper4,2,3)
Private cMaxName     := RetSQLName("BCI")
Private cMaxName1    := RetSQLName("BA3")
Private cMaxName2    := RetSQLName("BD5")
Private cMaxName3    := RetSQLName("BD6")
Private cCodPad      := ""
Private cCodPres     := ""
Private cNomPres     := ""
Private cTipPres     := ""
Private cTipPre      := ""
Private cEspPres     := ""
Private cCidDef      := ""
Private cOpeSol      := ""
Private cCodSol      := ""
Private cNomSol      := ""
Private cSiglaS      := ""
Private cCodExec     := ""
Private cNomeExec    := ""
Private _cPeg 		 := ""
Private cCodEmp      := ""
Private cCont        := ""
Private cVersao      := ""
Private cSubCon      := ""
Private cSubVer      := ""
Private cEstSol      := ""
Private cAno         := ""
Private cMes         := ""
Private cLocal       := ""
Private cCodLoc      := ""
Private cDesLoc      := ""
Private cEndLoc      := ""
Private cTipNot      := ""
Private cOriMov      := ""
Private cNumero      := ""
Private cHorPro      := ""
Private cHorAlt      := ""
Private cHorInt      := ""
Private cTipNas      := ""
Private cTipAlt      := ""
Private cNumDoc	   := ""
Private dDatPro      := StoD("")
Private dDatAlt      := StoD("")
Private dDatInt      := StoD("")
Private dDatDig      := StoD("")
Private nQtdReg      := 0
Private nTamLin      := 0
Private nTotBD5      := 0
Private nTotBD6      := 0
Private nGuiErr      := 0
Private nIteErr      := 0
Private aLog         := {}
Private aReg         := {}
Private aImp         := {}
Private aRelacao     := {}
Private aTipAco      := {}

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Le arquivo texto                                                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If ! Importa()
	Return
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica se existem registros a serem importados                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If nQtdReg == 0
	DbCloseArea("TRB")
	Return
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Valida o movimento                                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Processa({|| Valida() }, "Validando o movimento ...", "", .T.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Grava guias                                                         ³
//³ nProc = 1 -> apenas validar                                         ³
//³ nProc = 2 -> importa registros ok                                   ³
//³ nProc = 3 -> importa somente se o arquivo inteiro esta ok           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If nProc <> 1 .and. Len(aReg) > 0
	If (nIteErr == 0) .or. (nProc == 2)
		Processa({|| Grava() }, "Incluindo guias ...", "", .T.)
	EndIf
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Grava log                                                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Processa({|| Grava_Log() }, "Gravando log de ocorrências ...", "", .T.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Imprime relatorio de log                                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Imprime_Log()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Fecha arquivo de trabalho                                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
TRB->(DBCLoseArea("TRB"))

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Fim do programa                                                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Return
	
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ IMPORTA  ³ Autor ³ Ricardo Mansi ³ Data ³ 08/04/05 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Le arquivo texto e grava arquivo temporario                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ Importa()                                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ nenhum                                                     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function Importa()

Local cUltLin := ""
Local cNLin   := ""
Local cArqTmp := ""
Local nPos    := 0
Local nTmp    := 0 
Local _lArqErro:= .F.

//SZ9->(DbSetOrder(1))
BI4->(DbSetOrder(1))

For nTmp := 1 to Len(cArquivo)
	If substr(cArquivo,(Len(cArquivo)-nTmp)+1,1) == "\"
		Exit
	Endif
	cNomArq := substr(cArquivo,(Len(cArquivo)-nTmp)+1,1) + cNomArq
Next

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Abertura do arquivo texto                                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
nHdl := fOpen(cArquivo,68)

If nHdl == -1
	MsgAlert("O arquivo "+cArquivo+" não pode ser aberto! Verifique os parâmetros.","Atenção!")
	Return .F.
EndIf

cEOL    := CHR(13)+CHR(10)
nTamFile:= 0
cBuffer := " "
cLinha1 := " "
nBtLidos:= 0

nTamFile := fSeek(nHdl,0,2)
fSeek(nHdl,0,0)

nTamLin := 314 // 297

cBuffer  := Space(nTamLin) // Variavel para criacao da linha do registro para leitura
nBtLidos := fRead(nHdl,@cBuffer,nTamLin) // Leitura da primeira linha do arquivo texto

cLinha1 := cBuffer
cLayout := SubStr(cLinha1,127,3)

fSeek(nHdl,0,0)
/*
Do Case
	Case cLayout == "300"
	   //	nTamLin := AT(cEOL,cBuffer)+1
		If (nTamLin <> 313) .and. (nTamLin <> 314)
			MsgAlert("Arquivo Fora do Padrão. Solicite novamente o arquivo " + cArquivo,"Erro no Arquivo")
			fClose(cArquivo)
			Return .F.
		Endif
	Case cLayOut $ "500,600"
		If substr(cBuffer,289,2) == cEOL
			nTamLin := 290
		Else
			nTamLin := 289
		Endif
	Otherwise
		If substr(cBuffer,289,2) == cEOL
			nTamLin := 290
		Else
			nTamLin := 296
		Endif
EndCase

cBuffer  := Space(nTamLin) // Variavel para criacao da linha do registro para leitura
nBtLidos := fRead(nHdl,@cBuffer,nTamLin) // Leitura da primeira linha do arquivo texto
cLinha1  := cBuffer
_lArqErro:= .F.
cArqTmp  := cBuffer

While nBtLidos == nTamLin
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Grava os campos obtendo os valores da linha lida do arquivo texto.  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If Len(cBuffer) <> nTamLin
		_lArqErro:= .T.
		Exit
	EndIf
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Leitura da proxima linha do arquivo texto.                          ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	fRead(nHdl,@cBuffer,nTamLin)
	nBtLidos := Len(Alltrim(cBuffer))
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Agrava ultima linha...												³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If nBtLidos == nTamLin .or. substr(cBuffer,1,6) == "999999"
		cUltLin := cBuffer
	Endif   
	
	cArqTmp += cBuffer
	
	dbSkip()
End

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Testa Final de arquivo...											³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If substr(cUltLin,1,6) <> "999999"
	_lArqErro := .T.
Endif

*/

fClose(cArquivo)  

If _lArqErro
	MsgAlert("Arquivo com erro de Layout. Solicite novamente o arquivo " + cArquivo,"Erro no Arquivo")
	Return .F.
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Cria arquivo de trabalho conforme layout...								 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Do Case
	Case cLayOut $ "300/500/600"
		aStruc := {	{"NUMREG","C",  6,0},{"DATENV","C",  8,0},{"CODRDA","C",  8,0},;
		{"LOTE"  ,"C",  7,0},{"DOC"   ,"C",  7,0},{"DOCORI","C",  7,0},;
		{"UNIORI","C",  3,0},{"ANOCOM","C",  4,0},{"MESCOM","C",  2,0},;
		{"TIPGUI","C",  1,0},{"EMISSA","C",  8,0},{"INTERN","C",  8,0},;
		{"SAIDA" ,"C",  8,0},{"HORINT","C",  4,0},{"HORSAI","C",  4,0},;
		{"CODOPE","C",  3,0},{"CODEMP","C",  4,0},{"MATRIC","C",  6,0},;
		{"TIPREG","C",  2,0},{"NOMUSR","C", 25,0},{"VERLAY","C",  4,0},;
		{"ESTSOL","C",  2,0},{"CODSOL","C",  8,0},{"CIDDIA","C",  7,0},;
		{"CIDDEF","C",  7,0},{"TIPALT","C",  1,0},{"TIPOBT","C",  1,0},;
		{"TIPTRA","C",  1,0},{"UFHTRA","C",  2,0},{"HOSTRA","C",  8,0},;
		{"CARINT","C",  1,0},{"PROPRI","C",  7,0},{"TIPACO","C",  4,0},;
		{"TIPINT","C",  1,0},{"TIPPLA","C",  1,0},{"DATPRO","C",  8,0},;
		{"HORPRO","C",  4,0},{"CIRVID","C",  1,0},{"UNIEXE","C",  3,0},;
		{"CODEXE","C",  8,0},{"TIPPAR","C",  1,0},{"CODPRO","C",  8,0},;
		{"QTDPRO","N",  8,0},{"VALOR" ,"N",  8,0},{"TIPVIA","C",  1,0},;
		{"SENHA" ,"C",  9,0},{"TIPNAS","C",  1,0},{"TIPPAC","C",  1,0},;
		{"RESERV","C", 29,0},{"SEXO"  ,"C",  1,0},{"DATNAS","C",  8,0},;
		{"MOEDA" ,"C",  2,0},{"GLOSA" ,"N",  8,0},{"CODUSR","C",  3,0},;
		{"CODANT","C",  7,0}}
		
	Case cLayOut == "304" .and. nTamLin == 313
		aStruc := {	{"NUMREG","C",  6,0},{"DATENV","C",  8,0},{"CODRDA","C",  8,0},;
		{"LOTE"  ,"C",  7,0},{"DOC"   ,"C",  7,0},{"DOCORI","C",  7,0},;
		{"UNIORI","C",  3,0},{"ANOCOM","C",  4,0},{"MESCOM","C",  2,0},;
		{"TIPGUI","C",  1,0},{"EMISSA","C",  8,0},{"INTERN","C",  8,0},;
		{"SAIDA" ,"C",  8,0},{"HORINT","C",  4,0},{"HORSAI","C",  4,0},;
		{"CODOPE","C",  3,0},{"CODEMP","C",  4,0},{"MATRIC","C",  6,0},;
		{"TIPREG","C",  2,0},{"NOMUSR","C", 25,0},{"VERLAY","C",  4,0},;
		{"ESTSOL","C",  2,0},{"CODSOL","C",  8,0},{"CIDDIA","C",  7,0},;
		{"CIDDEF","C",  7,0},{"TIPALT","C",  1,0},{"TIPOBT","C",  1,0},;
		{"TIPTRA","C",  1,0},{"UFHTRA","C",  2,0},{"HOSTRA","C",  8,0},;
		{"CARINT","C",  1,0},{"PROPRI","C",  7,0},{"TIPACO","C",  4,0},;
		{"TIPINT","C",  1,0},{"TIPPLA","C",  1,0},{"DATPRO","C",  8,0},;
		{"HORPRO","C",  4,0},{"CIRVID","C",  1,0},{"UNIEXE","C",  3,0},;
		{"CODEXE","C",  8,0},{"TIPPAR","C",  1,0},{"CODPRO","C",  7,0},;
		{"QTDPRO","N",  8,0},{"VALOR" ,"N",  8,0},{"TIPVIA","C",  1,0},;
		{"SENHA" ,"C",  9,0},{"TIPNAS","C",  1,0},{"QTDFIL","C",  6,0},;
		{"VLRFIL","N",  8,0},{"VLRCO" ,"N",  8,0},{"VLRHON","N",  8,0},;
		{"SEXO"  ,"C",  1,0},{"DATNAS","C",  8,0},{"MOEDA" ,"C",  2,0},;
		{"GLOSA" ,"N",  8,0},{"CODUSR","C",  3,0},{"CODANT","C",  7,0}}
		
	Case cLayOut == "301" .and. nTamLin == 313
		aStruc := {	{"NUMREG","C",  6,0},{"DATENV","C",  8,0},{"CODRDA","C",  8,0},;
		{"LOTE"  ,"C",  7,0},{"DOC"   ,"C",  7,0},{"DOCORI","C",  7,0},;
		{"UNIORI","C",  3,0},{"ANOCOM","C",  4,0},{"MESCOM","C",  2,0},;
		{"TIPGUI","C",  1,0},{"EMISSA","C",  8,0},{"INTERN","C",  8,0},;
		{"SAIDA" ,"C",  8,0},{"HORINT","C",  4,0},{"HORSAI","C",  4,0},;
		{"CODOPE","C",  3,0},{"CODEMP","C",  4,0},{"MATRIC","C",  6,0},;
		{"TIPREG","C",  2,0},{"NOMUSR","C", 25,0},{"VERLAY","C",  4,0},;
		{"ESTSOL","C",  2,0},{"CODSOL","C",  8,0},{"CIDDIA","C",  7,0},;
		{"CIDDEF","C",  7,0},{"TIPALT","C",  1,0},{"TIPOBT","C",  1,0},;
		{"TIPTRA","C",  1,0},{"UFHTRA","C",  2,0},{"HOSTRA","C",  8,0},;
		{"CARINT","C",  1,0},{"PROPRI","C",  7,0},{"TIPACO","C",  4,0},;
		{"TIPINT","C",  1,0},{"TIPPLA","C",  1,0},{"DATPRO","C",  8,0},;
		{"HORPRO","C",  4,0},{"CIRVID","C",  1,0},{"UNIEXE","C",  3,0},;
		{"CODEXE","C",  8,0},{"TIPPAR","C",  1,0},{"CODPRO","C",  7,0},;
		{"QTDPRO","N",  8,0},{"VALOR" ,"N",  8,0},{"TIPVIA","C",  1,0},;
		{"SENHA" ,"C",  9,0},{"TIPNAS","C",  1,0},{"QTDFIL","C",  6,0},;
		{"VLRFIL","N",  8,0},{"VLRCO" ,"N",  8,0},{"VLRHON","N",  8,0},;
		{"SEXO"  ,"C",  1,0},{"DATNAS","C",  8,0},{"MOEDA" ,"C",  2,0},;
		{"GLOSA" ,"N",  8,0},{"TMPCIR","C",  7,0},{"CODUSR","C",  3,0},;
		{"CODANT","C",  7,0}}
		
	Otherwise
		aStruc := {	{"NUMREG","C",  6,0},{"DATENV","C",  8,0},{"CODRDA","C",  8,0},;
		{"LOTE"  ,"C",  7,0},{"DOC"   ,"C",  7,0},{"DOCORI","C",  7,0},;
		{"UNIORI","C",  3,0},{"ANOCOM","C",  4,0},{"MESCOM","C",  2,0},;
		{"TIPGUI","C",  1,0},{"EMISSA","C",  8,0},{"INTERN","C",  8,0},;
		{"SAIDA" ,"C",  8,0},{"HORINT","C",  4,0},{"HORSAI","C",  4,0},;
		{"CODOPE","C",  3,0},{"CODEMP","C",  4,0},{"MATRIC","C",  6,0},;
		{"TIPREG","C",  2,0},{"NOMUSR","C", 25,0},{"VERLAY","C",  4,0},;
		{"ESTSOL","C",  2,0},{"CODSOL","C",  8,0},{"CIDDIA","C",  7,0},;
		{"CIDDEF","C",  7,0},{"TIPALT","C",  1,0},{"TIPOBT","C",  1,0},;
		{"TIPTRA","C",  1,0},{"UFHTRA","C",  2,0},{"HOSTRA","C",  8,0},;
		{"CARINT","C",  1,0},{"PROPRI","C",  7,0},{"TIPACO","C",  4,0},;
		{"TIPINT","C",  1,0},{"NASVIV","N",  1,0},{"NASMOR","N",  1,0},;
		{"NASVIP","N",  1,0},{"CIDNA1","C",  7,0},{"CIDNA2","C",  7,0},;
		{"CODEXE","C",  8,0},{"TIPPAR","C",  1,0},{"CODPRO","C",  7,0},;
		{"QTDPRO","N",  8,0},{"VALOR" ,"N",  8,0},{"TIPVIA","C",  1,0},;
		{"SENHA" ,"C",  9,0},{"QTDFIL","C",  7,0},{"VLRFIL","N",  8,0},;
		{"VLRCO" ,"N",  8,0},{"VLRHON","N",  8,0},{"SEXO"  ,"C",  1,0},;
		{"DATNAS","C",  8,0},{"MOEDA" ,"C",  2,0},{"GLOSA" ,"N",  8,0},;
		{"CODUSR","C",  3,0},{"CODANT","C",  7,0}}
EndCase

cTRB := CriaTrab(aStruc,.T.)
DbUseArea(.T.,,cTRB,"TRB",.T.)
DbSelectArea("TRB")

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Copia arquivo da origem para o SigaAdv para usar o Append...		³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
/*
FT_FUse()  
nH := FCreate("\TEMP\"+cNomArq)
FWrite(nH,nHdl,Len(nHdl))
FClose(nH)
*/
fClose(nHdl)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Joga arquivo em area de trabalho...                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//cArquivo := "\TEMP\"+cNomArq

Append From &cArquivo SDF

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Apaga temporario...                       					    	³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Ferase("\TEMP\"+cNomArq)

nQtdReg := TRB->(RecCount())

If nQtdReg == 0
	msgstop("Arquivo vazio","Não existem registros a serem processados.")
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Alimenta array com relacionamentos....                              ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
BKC->(DbSetOrder(1))
BKC->(DbGoTop())

While ! BKC->(Eof())
	
	If BKC->BKC_CODOPE == cOper4
		nPos := Ascan(aRelacao,{|x| substr(BKC->BKC_CODPAR,1,1) == x[1] })
		If nPos = 0
			aadd(aRelacao,{substr(BKC->BKC_CODPAR,1,1),Alltrim(BKC->BKC_CODIGO)})
		Else
			aRelacao[nPos][2] := aRelacao[nPos][2] + "," + Alltrim(BKC->BKC_CODIGO)
		Endif
	Endif
	
	BKC->(DbSkip())
EndDo

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Alimenta array com tipos de acomodacao....                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//SZ9->(DbSeek(xFilial("SZ9")+cOper4))

BI4->(DbSeek(xFilial("BI4")+cOper4))


While BI4->BI4_FILIAL==xFilial("BI4")  .and. ! BI4->(Eof())
	
	aadd(aTipAco,BI4->BI4_CODACO)
	
 BI4->(DbSkip())
EndDo 
*/

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Fim da funcao                                                       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Return .T.
	
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ Valida   ³ Autor ³ Ricardo Mansi ³ Data ³ 08/04/05 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Valida os registros importados do arquivo texto            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ Valida()                                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ nenhum                                                     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function Valida()

Local dDatEmi := StoD("")
Local dDatAte := StoD("")
Local dDatNas := StoD("")
Local cLayout := ""
Local cChaInt := ""
Local cNumDoc := ""
Local cTmp    := ""
Local cGuiAnt := ""
Local cCodUsr := ""
Local cAcoDig := ""
Local cLocDig := GetNewPar("MV_YCODLDP","0002")
Local cAMB    := GetNewPar("MV_PLSTBPD","01")
Local cCBHPM  := GetNewPar("MV_YCBHPM","02")
Local lAutori := .F.
Local lVerIte := .F.
Local lTmp    := .F.
Local lParto  := .F.
Local nTmp    := 1
Local nTotCon := 0
Local nRegBA0 := 0
Local aVetErr := {}
Local cInd    := CriaTrab(Nil,.F.)
Local cBW0Ord := "BW0_FILIAL+BW0_CODPD2+BW0_CODPR2"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Seleciona indices                                                   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
BAU->(DbSetOrder(1)) // Codigo RDA
BBF->(DbSetOrder(01)) // Especialidade da RDA
BT5->(DbSetOrder(02)) // Contratos
BQC->(DbSetOrder(01)) // Subcontrato
BT6->(DbSetOrder(01)) // Subcontratos x Produtos
BA9->(DbSetOrder(01)) // CID
BR8->(DbSetOrder(01)) // Procedimentos
BA3->(DbSetOrder(01)) // Familia
BB8->(DbSetOrder(01)) // Local de Atendimento
BI3->(DbSetOrder(01)) // Produtos
BB0->(DbSetOrder(01)) // Profissional da Saude
BED->(DbSetOrder(01)) // Emissao de Cartao do Usuario
BEW->(DbSetOrder(01)) // Tipo de nascimento
BA0->(DbSetOrder(01)) // Operadora
BW0->(DbSetOrder(01)) // De/Para

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Cria indice na tabela de/para... 			 							 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
IndRegua("BW0",cInd,cBW0Ord,,,)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta tamanho da regua                                              ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
ProcRegua(nQtdReg)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Posiciona arquivo de trabalho                                       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
TRB->(DbGoTop())

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Processa arquivo de trabalho com os registros importados            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
While ! TRB->(EOF())
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Movimenta regua                                                     ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	IncProc()
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Despreza registro trailler                                          ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If  TRB->NUMREG = "999999"
		Exit
	EndIf
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Alimenta variaveis de controle...			            	        ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If TRB->DOC <> cNumDoc
		cCodUsr := "0"+TRB->CODOPE+"."+TRB->CODEMP+"."+TRB->MATRIC+"."+TRB->TIPREG
		cNumDoc := TRB->DOC
		nTotCon := 0      
		aVetErr := {}
		nTotBD5++
	Endif
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Inicializa variaveis...			                                    ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	lErro   := .F.
	lParto  := .F.
	cLayOut := Substr(TRB->VERLAY,2,3)
	nTotBD6++

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Posiciona Operadora do Usuario...                                   ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If ! BA0->(DbSeek(xFilial("BA0")+"0"+TRB->CODOPE))
		If Ascan(aVetErr,"00") == 0
			aAdd(aLog,{TRB->NUMREG,"ERRO",TRB->DOC,cCodUsr,"Operadora do Usuário Inválida: "+TRB->CODOPE})
			Aadd(aVetErr,"00")
		Endif
		lErro := .T.
	Endif
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Valida cadastro Tipo de Tabela x Operadora...		       	        ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
	BR8->(DbsetOrder(3))
	If ! BR8->(DbSeek(xFilial("BR8")+TRB->CODPRO))
		If Ascan(aVetErr,"46") == 0
			aAdd(aLog,{TRB->NUMREG,"ERRO",TRB->DOC,cCodUsr,"Procedimento Inválido: "+BR8->BR8_CODPSA})
			Aadd(aVetErr,"46")
		Endif
		lErro := .T.
	Endif 
	cCodPad := BR8->BR8_CODPAD

	If ! BR4->(DbSeek(xFilial("BR4")+BR8->BR8_CODPAD))
		If Ascan(aVetErr,"46") == 0
			aAdd(aLog,{TRB->NUMREG,"ERRO",TRB->DOC,cCodUsr,"Operadora com Tipo de Tabela Inválido: "+BA0->BA0_YCDPAD})
			Aadd(aVetErr,"46")
		Endif
		lErro := .T.
	Endif

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Alimenta Tabela conforme Operadora...			               	    ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	
  
  
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifica se deve alterar codigo do procedimento (de/para)...		³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
	BR8->(DbsetOrder(1))
    If ! BR8->(DbSeek(xFilial("BR8")+cCodPad+TRB->CODPRO))

		If cCodPad == cAMB
		
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Localiza codigo correspondente no de/para...						³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			BW0->(DbSetOrder(0))
			BW0->(DbSeek(xFilial("BW0")+cCBHPM+TRB->CODPRO))

			If ! BW0->(Found())
				aAdd(aLog,{TRB->NUMREG,"ERRO",TRB->DOC,cCodUsr,"Procedimento não Cadastrado: "+cCodPad+"."+TRB->CODPRO})
				lErro := .T.
			Else
			    If ! BR8->(DbSeek(xFilial("BR8")+cCodPad+BW0->BW0_CODPR1))
					aAdd(aLog,{TRB->NUMREG,"ERRO",TRB->DOC,cCodUsr,"Procedimento não Cadastrado: "+cCodPad+"."+TRB->CODPRO})
					lErro := .T.
				else    
					TRB->(RecLock("TRB",.F.))
					TRB->CODPRO := BW0->BW0_CODPR1
					TRB->(MsUnlock())
				endif
			Endif
						
		Else

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Localiza codigo correspondente no de/para...						³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			BW0->(DbSetOrder(1))
			BW0->(DbSeek(xFilial("BW0")+cAMB+TRB->CODPRO))

			If ! BW0->(Found())
				aAdd(aLog,{TRB->NUMREG,"ERRO",TRB->DOC,cCodUsr,"Procedimento não Cadastrado: "+cCodPad+"."+TRB->CODPRO})
				lErro := .T.
			Else
			    If ! BR8->(DbSeek(xFilial("BR8")+cCodPad+BW0->BW0_CODPR2))
					aAdd(aLog,{TRB->NUMREG,"ERRO",TRB->DOC,cCodUsr,"Procedimento não Cadastrado: "+cCodPad+"."+TRB->CODPRO})
					lErro := .T.
				else    
					TRB->(RecLock("TRB",.F.))
					TRB->CODPRO := BW0->BW0_CODPR2
					TRB->(MsUnlock())
				endif
			Endif

		Endif
	
    Endif
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Valida tipo de guia...			             	                    ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If ! (TRB->TIPGUI $ "I,A,E")
		If Ascan(aVetErr,"01") == 0
			aAdd(aLog,{TRB->NUMREG,"ERRO",TRB->DOC,cCodUsr,"Tipo da Guia Inválido: "+TRB->TIPGUI})
			Aadd(aVetErr,"01")
		Endif
		lErro := .T.
	EndIf

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Adequa horario, conforme PLS...			                        	³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If TRB->TIPGUI == "A"
		TRB->(RecLock("TRB",.F.))
		TRB->HORINT := "0800"
		TRB->HORSAI := "0800"
		TRB->(MsUnlock())
	Else
		If substr(TRB->HORINT,1,2) == "00"
			TRB->(RecLock("TRB",.F.))
			TRB->HORINT := "24"+substr(TRB->HORINT,3,2)
			TRB->(MsUnlock())
		Endif
	
		If substr(TRB->HORSAI,1,2) == "00"
			TRB->(RecLock("TRB",.F.))
			TRB->HORSAI := "24"+substr(TRB->HORSAI,3,2)
			TRB->(MsUnlock())
		Endif
	Endif
	
	If cLayout $ "300/400/500/600"
		If substr(TRB->HORPRO,1,2) == "00"
			TRB->(RecLock("TRB",.F.))
			TRB->HORPRO := "24"+substr(TRB->HORPRO,3,2)  
		  	TRB->(MsUnlock())
		Endif                
	Endif
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Valida Rda...					                   		            ³  
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
    TRB->(RecLock("TRB",.F.))
	TRB->CODRDA := SubStr(TRB->CODRDA,3,6)
  	TRB->CODSOL := SubStr(TRB->CODSOL,3,6)
	TRB->CODEXE := SubStr(TRB->CODEXE,3,6)
	TRB->(MsUnlock())
  /*
  	If AllTrim(cCodRda) <> AllTrim(TRB->CODRDA)
		If Ascan(aVetErr,"02") == 0
			aAdd(aLog,{TRB->NUMREG,"ERRO",TRB->DOC,cCodUsr,"Código da Rda diferente do Informado: "+TRB->CODRDA})
    		Aadd(aVetErr,"02")
   		Endif
		lErro := .T.
	Endif
 */	
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Valida nro da guia...			                     	            ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If Val(TRB->DOC) == 0
		If Ascan(aVetErr,"03") == 0
			aAdd(aLog,{TRB->NUMREG,"ERRO",TRB->DOC,cCodUsr,"Número da guia zerado"})
			Aadd(aVetErr,"03")
		Endif
		lErro := .T.
	Else
		cTmp := Alltrim(TRB->DOC)
		For nTmp := 1 to Len(cTmp)
			If substr(cTmp,nTmp,1) < "0" .or. substr(cTmp,nTmp,1) > "9"
				lTmp := .T.
			Endif
		Next
		If lTmp
			If Ascan(aVetErr,"04") == 0
				aAdd(aLog,{TRB->NUMREG,"ERRO",TRB->DOC,cCodUsr,"Número da guia inválido"})
				Aadd(aVetErr,"04")
			Endif
			lErro := .T.
		Endif
	EndIf
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Valida Competencia...			                         	        ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If (TRB->ANOCOM + TRB->MESCOM) <> (mv_par03 + mv_par02)
		If Ascan(aVetErr,"05") == 0
			aAdd(aLog,{TRB->NUMREG,"ERRO",TRB->DOC,cCodUsr,"Arquivo com Competência Inválida: "+TRB->MESCOM+"/"+TRB->ANOCOM})
			Aadd(aVetErr,"05")
		Endif
		lErro := .T.
	EndIf
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Valida datas...			 		                           	        ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	dDatInt := StoD(Substr(TRB->INTERN,05,04)+Substr(TRB->INTERN,03,02)+Substr(TRB->INTERN,01,02))
	cHorInt := TRB->HORINT
	dDatAlt := StoD(Substr(TRB->SAIDA,05,04)+Substr(TRB->SAIDA,03,02)+Substr(TRB->SAIDA,01,02))
	cHorAlt := TRB->HORSAI
	If cLayout $ "300/400/500/600"
		dDatPro := StoD(TRB->DATPRO)//StoD(Substr(TRB->DATPRO,05,04)+Substr(TRB->DATPRO,03,02)+Substr(TRB->DATPRO,01,02))
		cHorPro := TRB->HORPRO
		If BR8->(DbSeek(xFilial("BR8")+cCodPad+TRB->CODPRO))
			If VldMatMed(cCodPad,TRB->CODPRO)
				dDatPro := StoD(TRB->EMISSA)//StoD(Substr(TRB->EMISSA,05,04)+Substr(TRB->EMISSA,03,02)+Substr(TRB->EMISSA,01,02))
			Endif
		Endif
	Else
		dDatPro := StoD(TRB->EMISSA)//StoD(Substr(TRB->EMISSA,05,04)+Substr(TRB->EMISSA,03,02)+Substr(TRB->EMISSA,01,02))
		cHorPro := cHorInt
	Endif
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Valida Data do procedimento...			 		           			³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If Empty(dDatPro) .or. dDatPro > dDatabase
		If Ascan(aVetErr,"48") == 0
			aAdd(aLog,{TRB->NUMREG,"ERRO",TRB->DOC,cCodUsr,"Data do atendimento inválida: "+DtoC(dDatPro)})
			Aadd(aVetErr,"48")
		Endif
		lErro := .T.
	Endif

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Valida Hora do Procedimento...										³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If Substr(cHorPro,1,2) <= "00" .or. Substr(cHorPro,1,2) > "24" .or. ;
		Substr(cHorPro,3,2) < "00" .or. Substr(cHorPro,3,2) > "59"

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Somente para Internacoes ou Consulta de Emergencia...				³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If (TRB->TIPGUI == "I") .or. ((cCodPad+TRB->CODPRO) $ GetNewPar("MV_YCDCOEM","0100010073,0210101039"))

			If Ascan(aVetErr,"49") == 0
				aAdd(aLog,{TRB->NUMREG,"ERRO",TRB->DOC,cCodUsr,"Horário do atendimento inválido: "+cHorPro})
				Aadd(aVetErr,"49")
			Endif

			lErro := .T.
		Endif
	Endif
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Valida internacao...			 		            				³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If TRB->TIPGUI == "I"
		If Empty(dDatInt)
			If Ascan(aVetErr,"06") == 0
				aAdd(aLog,{TRB->NUMREG,"AVISO",TRB->DOC,cCodUsr,"Guia de internação sem data de entrada"})
				Aadd(aVetErr,"06")
			Endif
		Endif
		If Val(cHorInt) == 0
			If Ascan(aVetErr,"07") == 0
				aAdd(aLog,{TRB->NUMREG,"AVISO",TRB->DOC,cCodUsr,"Guia de internação sem horário de entrada"})
				Aadd(aVetErr,"07")
			Endif
		Endif
		If Empty(dDatAlt)
			If Ascan(aVetErr,"08") == 0
				aAdd(aLog,{TRB->NUMREG,"AVISO",TRB->DOC,cCodUsr,"Guia de internação sem data de saída"})
				Aadd(aVetErr,"08")
			Endif
		Endif
		If Val(cHorAlt) == 0
			If Ascan(aVetErr,"09") == 0
				aAdd(aLog,{TRB->NUMREG,"AVISO",TRB->DOC,cCodUsr,"Guia de internação sem horário de saída"})
				Aadd(aVetErr,"09")
			Endif
		Endif
	Endif
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Valida data de internacao...			 		           			³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If dDatInt > dDataBase
		If Ascan(aVetErr,"11") == 0
			aAdd(aLog,{TRB->NUMREG,"ERRO",TRB->DOC,cCodUsr,"Data de internação Inválida: "+DtoC(dDatInt)})
			Aadd(aVetErr,"11")
		Endif
		lErro := .T.
	EndIf
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Valida data de saida...			 		              		     	³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If dDatAlt > dDataBase
		If Ascan(aVetErr,"12") == 0
			aAdd(aLog,{TRB->NUMREG,"ERRO",TRB->DOC,cCodUsr,"Data de alta Inválida: "+DtoC(dDatAlt)})
			Aadd(aVetErr,"12")
		Endif
		lErro := .T.
	EndIf
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Valida data do procedimento x data de entrada...           			³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If TRB->TIPGUI == "I"
		If dDatPro < dDatInt
			aAdd(aLog,{TRB->NUMREG,"ERRO",TRB->DOC,cCodUsr,"Data do procedimento ("+DtoC(dDatPro)+") anterior a data de entrada ("+DtoC(dDatInt)+")"})
			lErro := .T.
		EndIf
	Endif
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Valida data do procedimento x data de alta...       		    	³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If TRB->TIPGUI == "I"
		If dDatPro > dDatAlt
			aAdd(aLog,{TRB->NUMREG,"ERRO",TRB->DOC,cCodUsr,"Data do procedimento ("+DtoC(dDatPro)+") posterior a data de alta ("+DtoC(dDatAlt)+")"})
			lErro := .T.
		EndIf
	Endif
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Valida data de internacao x saida...			 		    		³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If ! Empty(dDatInt) .and. ! Empty(dDatAlt)
		If dDatInt > dDatAlt
			If Ascan(aVetErr,"13") == 0
				aAdd(aLog,{TRB->NUMREG,"ERRO",TRB->DOC,cCodUsr,"Data Internação ("+DtoC(dDatInt)+") posterior a data de alta ("+DtoC(dDatAlt)+")"})
				Aadd(aVetErr,"13")
			Endif
			lErro := .T.
		EndIf
	EndIf
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Valida data do evento...			 		              			³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If dDatPro > dDataBase
		aAdd(aLog,{TRB->NUMREG,"ERRO",TRB->DOC,cCodUsr,"Data do evento Inválida: "+DtoC(dDatPro)})
		lErro := .T.
	EndIf
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Valida procedimento se for Hospital Dia...		                    ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If VldHosDia()
		aAdd(aLog,{TRB->NUMREG,"ERRO",TRB->DOC,cCodUsr,"Procedimento de Diária executado em Hospital Dia: "+TRB->CODPRO})
		lErro := .T.
	Endif

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Zera valor do procedimento se nao for Material/Medicamento...		³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
    /*
	If VldMatMed(cCodPad,TRB->CODPRO)
		If TRB->VALOR == 0
			aAdd(aLog,{TRB->NUMREG,"ERRO",TRB->DOC,cCodUsr,"Procedimento sem valor informado: "+TRB->CODPRO})
			lErro := .T.
		Endif
	Else
		If TRB->VALOR <> 0
			TRB->(RecLock("TRB",.F.))
			TRB->VALOR := 0
			TRB->(MsUnlock())
		Endif
	Endif
   */
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Corrige CID...		                   								³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	TRB->(RecLock("TRB",.F.))
	TRB->CIDDIA := Upper(TRB->CIDDIA)
	TRB->CIDDEF := Upper(TRB->CIDDEF)
	TRB->(MsUnlock())
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Valida Tipo de nascimento...					             		³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If TRB->TIPGUI == "I"
		If cLayout $ "300/400/500/600"
			If ! BEW->(DbSeek(xFilial("BEW")+cOper4+TRB->TIPNAS))
				If Ascan(aVetErr,"14") == 0
					aAdd(aLog,{TRB->NUMREG,"ERRO",TRB->DOC,cCodUsr,"Tipo de Nascimento não cadastrado: "+TRB->TIPNAS})
					Aadd(aVetErr,"14")
				Endif
				lErro := .T.
			Else
				If lParto .and. TRB->TIPNAS == "0"
					If Ascan(aVetErr,"15") == 0
						aAdd(aLog,{TRB->NUMREG,"ERRO",TRB->DOC,cCodUsr,"Tipo de Nascimento inválido: "+TRB->TIPNAS})
						Aadd(aVetErr,"15")
					Endif
					lErro := .T.
				Endif
			Endif
		Else
			If Ascan(aVetErr,"16") == 0
				aAdd(aLog,{TRB->NUMREG,"ERRO",TRB->DOC,cCodUsr,"Versão do SDC inválida para guias de internação"})
				Aadd(aVetErr,"16")
			Endif
			lErro := .T.
		Endif
	Endif
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Prazo para entrega das guias: 3 meses, conforme Willian...			³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
    /*
	If (dDataBase - dDatPro) > 90
		If Ascan(aVetErr,"17") == 0
			aAdd(aLog,{TRB->NUMREG,"ERRO",TRB->DOC,cCodUsr,"Limite para apresentação da guia ultrapassado. Data: "+DtoC(dDatPro)})
			Aadd(aVetErr,"17")
		Endif
		lErro := .T.
	EndIf
	*/
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Valida Hora de Internacao...										³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If TRB->TIPGUI == "I"
		If Substr(cHorInt,1,2) <= "00" .or. Substr(cHorInt,1,2) > "24"
			If Ascan(aVetErr,"18") == 0
				aAdd(aLog,{TRB->NUMREG,"ERRO",TRB->DOC,cCodUsr,"Horário de internação inválido: "+cHorInt})
				Aadd(aVetErr,"18")
			Endif
			lErro := .T.
		Else
			If Substr(cHorInt,3,2) < "00" .or. Substr(cHorInt,3,2) > "59"
				If Ascan(aVetErr,"18") == 0
					aAdd(aLog,{TRB->NUMREG,"ERRO",TRB->DOC,cCodUsr,"Horário de internação inválido: "+cHorInt})
					Aadd(aVetErr,"18")
				Endif
				lErro := .T.
			EndIf
		EndIf
	EndIf
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Valida Hora de Alta...												³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If TRB->TIPGUI == "I"
		If Substr(cHorAlt,1,2) <= "00" .or. Substr(cHorAlt,1,2) > "24"
			If Ascan(aVetErr,"19") == 0
				aAdd(aLog,{TRB->NUMREG,"ERRO",TRB->DOC,cCodUsr,"Horário de alta inválido: "+cHorAlt})
				Aadd(aVetErr,"19")
			Endif
			lErro := .T.
		Else
			If Substr(cHorAlt,3,2) < "00" .or. Substr(cHorAlt,3,2) > "59"
				If Ascan(aVetErr,"19") == 0
					aAdd(aLog,{TRB->NUMREG,"ERRO",TRB->DOC,cCodUsr,"Horário de alta inválido: "+cHorAlt})
					Aadd(aVetErr,"19")
				Endif
				lErro := .T.
			EndIf
		EndIf
	EndIf

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Valida Hora de Internacao x Alta...									³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If TRB->TIPGUI == "I"

		If substr(cHorInt,1,2)=="24"
			cHorInt := "00" + substr(cHorInt,3,2)
		Endif
		If substr(cHorAlt,1,2)=="24"
			cHorInt := "00" + substr(cHorAlt,3,2)
		Endif

		If dDatInt == dDatAlt
			If cHorInt > cHorAlt
				If Ascan(aVetErr,"20") == 0
					aAdd(aLog,{TRB->NUMREG,"ERRO",TRB->DOC,cCodUsr,"Horário Internação ("+cHorInt+") posterior ao horário de alta ("+cHorAlt+")"})
					Aadd(aVetErr,"20")
				Endif
				lErro := .T.
			EndIf
		EndIf

		If substr(cHorInt,1,2)=="00"
			cHorInt := "24" + substr(cHorInt,3,2)
		Endif
		If substr(cHorAlt,1,2)=="00"
			cHorInt := "24" + substr(cHorAlt,3,2)
		Endif

	EndIf
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Valida quantidade apresentada...									³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If TRB->QTDPRO <= 0
		aAdd(aLog,{TRB->NUMREG,"ERRO",TRB->DOC,cCodUsr,"Quantidade do procedimento inválida: "+Alltrim(str(TRB->QTDPRO))})
		lErro := .T.
	Else
		If TRB->TIPGUI == "I"
			If TRB->QTDPRO > 9999999
				aAdd(aLog,{TRB->NUMREG,"ERRO",TRB->DOC,cCodUsr,"Quantidade do procedimento inválida: "+Alltrim(str(TRB->QTDPRO))})
				lErro := .T.
			Endif
		Else
			If TRB->QTDPRO > 99999
				aAdd(aLog,{TRB->NUMREG,"ERRO",TRB->DOC,cCodUsr,"Quantidade do procedimento inválida: "+Alltrim(str(TRB->QTDPRO))})
				lErro := .T.
			Endif
		Endif
	EndIf
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Valida quantidade de consulta...									³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If (cCodPad+TRB->CODPRO) $ GetNewPar("MV_YCDCOEL","0100010014,0210101012")
		If TRB->QTDPRO/100 > 1
			aAdd(aLog,{TRB->NUMREG,"AVISO",TRB->DOC,cCodUsr,"Quantidade da consulta inválida: "+Alltrim(str(TRB->QTDPRO/100))})
		Endif
		nTotCon++
	EndIf
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Valida tipo da participacao para consultas...						³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If ((cCodPad+TRB->CODPRO) $ GetNewPar("MV_YCDCOEL","0100010014,0210101012")) .or. ;
		((cCodPad+TRB->CODPRO) $ GetNewPar("MV_YCDCOEM","0100010073,0210101039"))
		
		If TRB->TIPPAR <> "M"
			TRB->(RecLock("TRB",.F.))
			TRB->TIPPAR := "M"
			TRB->(MsUnlock())
		Endif
		
	Endif
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Valida tipo da saida...												³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If TRB->TIPGUI == "I"
		If ! (TRB->TIPALT >= "1" .and. TRB->TIPALT <= "8")
			If Ascan(aVetErr,"21") == 0
				aAdd(aLog,{TRB->NUMREG,"ERRO",TRB->DOC,cCodUsr,"Tipo de Alta Inválida: "+TRB->TIPALT})
				Aadd(aVetErr,"21")
			Endif
			lErro := .T.
		EndIf
	Endif
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Procura Rda...                                    	 				³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If ! BAU->(DbSeek(xFilial("BAU")+TRB->CODRDA))
		If Ascan(aVetErr,"23") == 0
			aAdd(aLog,{TRB->NUMREG,"ERRO",TRB->DOC,TRB->TIPACO,"RDA não cadastrada: "+TRB->CODRDA})
			Aadd(aVetErr,"23")
		Endif
		lErro := .T.
	Else
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Grava nome do Prestador...                                     		³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		cNomPres := BAU->BAU_NOME
	    cTipPre  := BAU->BAU_TIPPRE
		cCodRda := BAU->BAU_CODIGO
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Acessa BBF-Especialidade da RDA                                     ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If ! BBF->(DbSeek(xFilial("BBF")+AllTrim(BAU->BAU_CODIGO)+AllTrim(cOper4)))
			If Ascan(aVetErr,"24") == 0
				aAdd(aLog,{TRB->NUMREG,"ERRO",TRB->DOC,cCodUsr,"Especialidade não cadastrada para a RDA: "+BAU->BAU_CODIGO})
				Aadd(aVetErr,"24")
			Endif
			lErro := .T.
		EndIf
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Acessa BB8-Local de Atendimento                                     ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If  ! BB8->(DbSeek(xFilial("BB8")+BAU->BAU_CODIGO+cOper4))
			If Ascan(aVetErr,"25") == 0
				aAdd(aLog,{TRB->NUMREG,"ERRO",TRB->DOC,cCodUsr,"Local de Atendimento não cadastrado para a RDA: "+BAU->BAU_CODIGO})
				Aadd(aVetErr,"25")
			Endif
			lErro := .T.
		EndIf
		
	EndIf
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifica se Rda esta bloqueada...                    				³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If RdaBloq(TRB->CODRDA,dDatPro)
		If Ascan(aVetErr,"26") == 0
			aAdd(aLog,{TRB->NUMREG,"ERRO",TRB->DOC,cCodUsr,"Rda Bloqueada: "+TRB->CODRDA})
			Aadd(aVetErr,"26")
		Endif
		lErro := .T.
	Endif
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifica se Executante esta bloqueado...                   	 		³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If TRB->CODEXE <> TRB->CODRDA
		If RdaBloq(TRB->CODEXE,dDatPro)
			aAdd(aLog,{TRB->NUMREG,"ERRO",TRB->DOC,cCodUsr,"Executante Bloqueado: "+TRB->CODEXE})
			lErro := .T.
		Endif
	Endif
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Valida solicitante...					                  			³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If BAU->(DbSeek(xFilial("BAU")+TRB->CODSOL))
		If ! BB0->(DbSeek(xFilial("BB0")+BAU->BAU_CODBB0))
			If Ascan(aVetErr,"27") == 0
				aAdd(aLog,{TRB->NUMREG,"ERRO",TRB->DOC,cCodUsr,"Solicitante não Cadastrado como Profissional de Saúde: "+TRB->CODSOL})
				Aadd(aVetErr,"27")
			Endif
			//lErro := .T.
		Endif
	Else
		If Ascan(aVetErr,"28") == 0
			aAdd(aLog,{TRB->NUMREG,"ERRO",TRB->DOC,cCodUsr,"Solicitante não Cadastrado: "+TRB->CODSOL})
			Aadd(aVetErr,"28")
		Endif
		//lErro := .T.
   Endif

	If TRB->CODSOL <> TRB->CODRDA
		If BAU->(Found()) .and. BB0->(Found())
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Verifica se Solicitante esta bloqueado...               	     	³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If RdaBloq(TRB->CODSOL,dDatPro)
				If Ascan(aVetErr,"30") == 0
					aAdd(aLog,{TRB->NUMREG,"ERRO",TRB->DOC,cCodUsr,"Solicitante Bloqueado: "+TRB->CODSOL})
					Aadd(aVetErr,"30")
				Endif
				lErro := .T.
			Endif
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Valida Data Atendimento x Data Inclusao Solicitante...             	³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		        /*
		    	If VeDatAte(TRB->CODSOL,dDatPro)
				If Ascan(aVetErr,"31") == 0
					aAdd(aLog,{TRB->NUMREG,"ERRO",TRB->DOC,cCodUsr,"Data de Atendimento ("+DtoC(dDatPro)+") anterior a inclusão do Solicitante: "+TRB->CODSOL})
					Aadd(aVetErr,"31")
				Endif
				lErro := .T.
		    	Endif
		    	*/
		Endif
	Endif
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Valida Data Atendimento x Data Inclusao Rda...                    	³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	/*
	If VeDatAte(TRB->CODRDA,dDatPro)
		If Ascan(aVetErr,"32") == 0
			aAdd(aLog,{TRB->NUMREG,"ERRO",TRB->DOC,cCodUsr,"Data de Atendimento ("+DtoC(dDatPro)+") anterior a inclusão da Rda: "+TRB->CODRDA})
			Aadd(aVetErr,"32")
		Endif
		lErro := .T.
	Endif
	*/
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Valida Data Atendimento x Data Inclusao Executante...              	³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	/*
	If TRB->CODEXE <> TRB->CODRDA
		If VeDatAte(TRB->CODEXE,dDatPro)
			aAdd(aLog,{TRB->NUMREG,"ERRO",TRB->DOC,cCodUsr,"Data de Atendimento ("+DtoC(dDatPro)+") anterior a inclusão do Executante: "+TRB->CODEXE})
			lErro := .T.
		Endif
	Endif 
	*/
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Acessa Profissionais de Saude - Executante...                       ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If TRB->CODEXE == TRB->CODRDA
		If BAU->BAU_TIPPE == "F"
			If ! BB0->(DbSeek(xFilial("BB0")+BAU->BAU_CODBB0))
				aAdd(aLog,{TRB->NUMREG,"ERRO",TRB->DOC,cCodUsr,"Executante não cadastrada como Profissional de Saúde: "+BAU->BAU_CODIGO})
				lErro := .T.
			EndIf
		Endif
	Else
		If ! BAU->(DbSeek(xFilial("BAU")+TRB->CODEXE))
			aAdd(aLog,{TRB->NUMREG,"ERRO",TRB->DOC,cCodUsr,"Executante não cadastrado: "+TRB->CODEXE})
			lErro := .T.
		Else
			If ! BB0->(DbSeek(xFilial("BB0")+BAU->BAU_CODBB0))
				aAdd(aLog,{TRB->NUMREG,"ERRO",TRB->DOC,cCodUsr,"Executante não cadastrado como Profissional de Saúde: "+TRB->CODEXE})
				lErro := .T.
			EndIf
		EndIf
		BAU->(DbSeek(xFilial("BAU")+TRB->CODRDA))
	EndIf
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Pesquisa usuario...							        			      ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	lTemBA1 := .F.
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Procura usuario com matricula do sistema antigo...					  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	BA1->(DbSetorder(5))
	
	If ! lTemBA1
		If BA1->(DbSeek(xFilial("BA1")+"0"+TRB->CODOPE+TRB->CODEMP+TRB->MATRIC+TRB->TIPREG))
			lTemBa1 := .T.
			TRB->(RecLock("TRB",.F.))
			TRB->CODUSR := "ANT"
			TRB->(MsUnlock())
		EndIf
   Endif
   
	If ! lTemBA1
		If BA1->(DbSeek(xFilial("BA1")+TRB->CODOPE+TRB->CODEMP+TRB->MATRIC+TRB->TIPREG))
			lTemBa1 := .T.
			TRB->(RecLock("TRB",.F.))
			TRB->CODUSR := "ANT"
			TRB->(MsUnlock())
		EndIf
	Endif
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Procura usuario com matricula anterior do sistema antigo...			  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	BA1->(DbSetorder(10))
	
	If ! lTemBa1
		If BA1->(DbSeek(xFilial("BA1")+"0"+TRB->CODOPE+TRB->CODEMP+TRB->MATRIC+TRB->TIPREG))
			lTemBa1 := .T.
			TRB->(RecLock("TRB",.F.))
			TRB->CODUSR := "USB"
			TRB->(MsUnlock())
		EndIf
	Endif

	If ! lTemBa1
		If BA1->(DbSeek(xFilial("BA1")+TRB->CODOPE+TRB->CODEMP+TRB->MATRIC+TRB->TIPREG))
			lTemBa1 := .T.
			TRB->(RecLock("TRB",.F.))
			TRB->CODUSR := "USB"
			TRB->(MsUnlock())
		EndIf
	Endif
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Procura usuario com matricula no microsiga...						  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	BA1->(DbSetorder(2))
	
	If ! lTemBa1
		If BA1->(DbSeek(xFilial("BA1")+"0"+TRB->CODOPE+TRB->CODEMP+TRB->MATRIC+TRB->TIPREG))
			lTemBa1 := .T.
			TRB->(RecLock("TRB",.F.))
			TRB->CODUSR := "BA1"
			TRB->(MsUnlock())
		EndIf
	Endif
	
	If ! lTemBA1
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Se usuario eh da operadora gera erro...                               ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If TRB->CODOPE == cOper3 .or. TRB->CODOPE == "000"
			If Ascan(aVetErr,"33") == 0
				aAdd(aLog,{TRB->NUMREG,"ERRO",TRB->DOC,cCodUsr,"Usuário não cadastrado"})
				Aadd(aVetErr,"33")
			Endif
			lErro := .T.
		Else
			If ! BT5->(DbSeek(xFilial("BT5")+cOper4+"1"+GetNewPar("MV_PLSCDIE","04")+"1"))
				If Ascan(aVetErr,"34") == 0
					aAdd(aLog,{TRB->NUMREG,"ERRO",TRB->DOC,cCodUsr,"Contrato de Intercâmbio Eventual não cadastrado"})
					Aadd(aVetErr,"34")
				Endif
				lErro := .T.
			Else
				cCodigo := BT5->BT5_CODIGO
				cCont   := BT5->BT5_NUMCON
				cVersao := BT5->BT5_VERSAO
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Pesquisa subcontrato de intercambio para a operadora                  ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				If ! BQC->(DbSeek(xFilial("BQC")+cOper4+cCodigo+cCont+cVersao))
					If Ascan(aVetErr,"35") == 0
						aAdd(aLog,{TRB->NUMREG,"ERRO",TRB->DOC,cCodUsr,"Subcontrato de Intercâmbio Eventual não cadastrado"})
						Aadd(aVetErr,"35")
					Endif
					lErro := .T.
				Else
					cSubCon := BQC->BQC_SUBCON
					cSubVer := BQC->BQC_VERSUB
				EndIf
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Pesquisa o produto                                                    ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				If ! BT6 ->(DbSeek(xFilial("BT6")+cOper4+cCodigo+cCont+cVersao+cSubCon+cSubVer))
					If Ascan(aVetErr,"36") == 0
						aAdd(aLog,{TRB->NUMREG,"ERRO",TRB->DOC,cCodUsr,"Não existe produto cadastrado para o Sub-Contrato de Intercâmbio"})
						Aadd(aVetErr,"36")
					Endif
					lErro := .T.
				Else
					cPlano  := BT6->BT6_CODPRO
					cVerpla := BT6->BT6_VERSAO
					TRB->(RecLock("TRB",.F.))
					TRB->CODUSR := "INT"
					TRB->(MsUnlock())
				EndIf
			EndIf
		EndIf
	Else
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Verifica se usuario esta bloqueado...                                 ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If U_VeBlqUsr(BA1->BA1_CODINT,BA1->BA1_CODEMP,BA1->BA1_MATRIC,BA1->BA1_TIPREG,dDatPro)
			If Ascan(aVetErr,"37") == 0
				aAdd(aLog,{TRB->NUMREG,"ERRO",TRB->DOC,cCodUsr,"Usuário Bloqueado"})
				Aadd(aVetErr,"37")
			Endif
			lErro := .T.
		Endif
	EndIf

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Valida data de nascimento...			 		  			        ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If ! lTemBA1
		dDatNas := StoD(TRB->DATNAS)//StoD(Substr(TRB->DATNAS,05,04)+Substr(TRB->DATNAS,03,02)+Substr(TRB->DATNAS,01,02))
    Else
		dDatNas := BA1->BA1_DATNAS
    Endif
    
	If Empty(dDatNas)
		If Ascan(aVetErr,"50") == 0
			aAdd(aLog,{TRB->NUMREG,"ERRO",TRB->DOC,cCodUsr,"Data de Nascimento Inválida: "+DtoC(dDatNas)})
			Aadd(aVetErr,"50")
		Endif
		lErro := .T.
	Endif
	
	If dDatNas > dDataBase
		If Ascan(aVetErr,"10") == 0
			aAdd(aLog,{TRB->NUMREG,"ERRO",TRB->DOC,cCodUsr,"Data de Nascimento posterior a data atual: "+DtoC(dDatNas)})
			Aadd(aVetErr,"10")
		Endif
		lErro := .T.
	Else
		If dDatNas > dDatPro
			aAdd(aLog,{TRB->NUMREG,"ERRO",TRB->DOC,cCodUsr,"Data de Nascimento ("+DtoC(dDatNas)+") posterior a execução do procedimento ("+DtoC(dDatPro)+")"})
			lErro := .T.
		Endif
	EndIf
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifica se internacao foi autorizada...							³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If TRB->TIPGUI == "I"
		
		lAutori := .F.
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Verifica Nro Impresso + Usuario...									³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		BE4->(DbSetOrder(6))
		BE4->(DbSeek(xFilial("BE4")+TRB->DOC))
		
		While (BE4->BE4_FILIAL+substr(BE4->BE4_NUMIMP,10,7))==(xFilial("BE4")+TRB->DOC) .and. ! BE4->(Eof())
			
			If BE4->(BE4_OPEUSR+BE4_CODEMP+BE4_MATRIC+BE4_TIPREG) == BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG)
				lAutori := .T.
				Exit
			EndIf
			
			BE4->(DbSkip())
		EndDo

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Verifica Senha + Usuario...											³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If ! lAutori
		
			BE4->(DbSetOrder(7))
			BE4->(DbSeek(xFilial("BE4")+TRB->SENHA))
	
			While BE4->(BE4_FILIAL+BE4_SENHA)==(xFilial("BE4")+TRB->SENHA) .and. ! BE4->(Eof())
				
				If BE4->(BE4_OPEUSR+BE4_CODEMP+BE4_MATRIC+BE4_TIPREG) == BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG)
					lAutori := .T.
					Exit
				EndIf
	
				BE4->(DbSkip())
			EndDo
        
        Endif
        
		If ! lAutori
			If Ascan(aVetErr,"38") == 0
				aAdd(aLog,{TRB->NUMREG,"ERRO",TRB->DOC,cCodUsr,"Guia de Internação sem Autorização"})
				Aadd(aVetErr,"38")
			Endif
			lErro := .T.
		Else
			
			If BE4->BE4_SITUAC == "2"
				If Ascan(aVetErr,"39") == 0
					aAdd(aLog,{TRB->NUMREG,"ERRO",TRB->DOC,cCodUsr,"Guia de Internação ("+BE4->BE4_CODOPE+"."+BE4->BE4_CODLDP+"."+BE4->BE4_CODPEG+"."+BE4->BE4_NUMERO+") com Situação Inválida ("+BE4->BE4_SITUAC+")"})
					Aadd(aVetErr,"39")
				Endif
				lErro := .T.
			Else
				If BE4->BE4_SITUAC == "1"
					If BE4->BE4_FASE <> "1"
						If Ascan(aVetErr,"40") == 0
							aAdd(aLog,{TRB->NUMREG,"ERRO",TRB->DOC,cCodUsr,"Guia de Internação ("+BE4->BE4_CODOPE+"."+BE4->BE4_CODLDP+"."+BE4->BE4_CODPEG+"."+BE4->BE4_NUMERO+") com Fase Inválida ("+BE4->BE4_FASE+")"})
							Aadd(aVetErr,"40")
						Endif
						lErro := .T.
					Endif
				Endif
			Endif
			
		EndIf

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Valida tipo da acomodacao...										³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If lAutori
			If ascan(aTipAco,TRB->TIPACO) = 0
				If Ascan(aVetErr,"22") == 0
					aAdd(aLog,{TRB->NUMREG,"ERRO",TRB->DOC,cCodUsr,"Tipo de Acomodação Inválida: "+TRB->TIPACO})
					Aadd(aVetErr,"22")
				Endif
				lErro := .T.
			Else
	
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Posiciona Tipo de Acomodacao SDC...									³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			  BI4->(DbSetOrder(1))
			SZ9->(DbSeek(xFilial("SZ9")+TRB->TIPACO))
				
				cAcoDig := BI4->BI4_CODACO
	
				If cAcoDig <> BE4->BE4_PADINT
					If Ascan(aVetErr,"47") == 0
						aAdd(aLog,{TRB->NUMREG,"AVISO",TRB->DOC,cCodUsr,"Tipo de Acomodação Digitada ("+Alltrim(cAcoDig)+") diferente da Autorizada ("+Alltrim(BE4->BE4_PADINT)+")"})
						Aadd(aVetErr,"47")
					Endif
				Endif
	
			Endif
	   Endif
	Else
		
		lAutori	:= .F.
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Verifica Nro Impresso + Usuario...									³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		BD5->(DbSetOrder(6))
		BD5->(DbSeek(xFilial("BD5")+TRB->DOC))
		
		While (BD5->BD5_FILIAL+substr(BD5->BD5_NUMIMP,10,7))==(xFilial("BD5")+TRB->DOC) .and. ! BD5->(Eof())
			
			If BD5->(BD5_OPEUSR+BD5_CODEMP+BD5_MATRIC+BD5_TIPREG) == BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG)
				lAutori := .T.
				Exit
			EndIf
			
			BD5->(DbSkip())
		EndDo

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Verifica (Senha + Usuario)...										³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If ! lAutori 
		   If Val(TRB->SENHA) > 0     //Inlcuido por Otacilio
		
				BD5->(DbSetOrder(7))
				BD5->(DbSeek(xFilial("BD5")+TRB->SENHA))
		
				While BD5->(BD5_FILIAL+BD5_SENHA)==(xFilial("BD5")+TRB->SENHA) .and. ! BD5->(Eof())
		
					If BD5->(BD5_OPEUSR+BD5_CODEMP+BD5_MATRIC+BD5_TIPREG) == BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG)
						lAutori := .T.
						Exit
					EndIf
		
					BD5->(DbSkip())
				EndDo
	       EndIf
		Endif
		
		If lAutori
			
			If BD5->BD5_SITUAC == "2"
				If Ascan(aVetErr,"41") == 0
					aAdd(aLog,{TRB->NUMREG,"ERRO",TRB->DOC,cCodUsr,"Guia de Serviço ("+BD5->BD5_CODOPE+"."+BD5->BD5_CODLDP+"."+BD5->BD5_CODPEG+"."+BD5->BD5_NUMERO+") com Situação Inválida ("+BD5->BD5_SITUAC+")"})
					Aadd(aVetErr,"41")
				Endif
				lErro := .T.
			Else
				If BD5->BD5_SITUAC == "1"
					If BD5->BD5_FASE <> "1"
						If Ascan(aVetErr,"42") == 0
							aAdd(aLog,{TRB->NUMREG,"ERRO",TRB->DOC,cCodUsr,"Guia de Serviço ("+BD5->BD5_CODOPE+"."+BD5->BD5_CODLDP+"."+BD5->BD5_CODPEG+"."+BD5->BD5_NUMERO+") com Fase Inválida ("+BD5->BD5_FASE+")"})
							Aadd(aVetErr,"42")
						Endif
						lErro := .T.
					Endif
				Endif
			Endif
			
		Endif
		
	EndIf
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Posiciona familia                                                     ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	BA3->(DbSeek(xFilial("BA3")+BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC)))
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Pesquisa produto                                                      ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If lTemBA1
		If ! BI3->(DbSeek(xFilial("BI3")+BA1->(BA1_CODINT+BA1_CODPLA+BA1_VERSAO)))
			If ! BI3->(DbSeek(xFilial("BI3")+BA3->(BA3_CODINT+BA3_CODPLA+BA3_VERSAO)))
				If Ascan(aVetErr,"43") == 0
					aAdd(aLog,{TRB->NUMREG,"ERRO",TRB->DOC,cCodUsr,"Família/Usuário com produto inválido"})
					Aadd(aVetErr,"43")
				Endif
				lErro := .T.
			Endif
		Endif
	Endif
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Acessa CID                                                 	  	    ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If ! Empty(TRB->CIDDEF) .and. TRB->CIDDEF <> "0000000"
		If ! BA9->(DbSeek(xFilial("BA9")+TRB->CIDDEF))
			If Ascan(aVetErr,"44") == 0
				aAdd(aLog,{TRB->NUMREG,"ERRO",TRB->DOC,cCodUsr,"CID Definitivo não cadastrado: "+TRB->CIDDEF})
				Aadd(aVetErr,"44")
			Endif
			lErro := .T.
		Endif
	EndIf
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Acessa BR8-Procedimento                                             ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	BR8->(DbSeek(xFilial("BR8")+cCodPad+TRB->CODPRO))
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifica se esta bloqueado...                                       ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If BR8->BR8_PROBLO == "1"
		aAdd(aLog,{TRB->NUMREG,"ERRO",TRB->DOC,cCodUsr,"Procedimento bloqueado na Tabela Padrão: "+TRB->CODPRO})
		lErro := .T.
	EndIf
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifica se procedimento exige autorizacao...                       ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	lVerIte := .F.

	If lAutori
		
		If TRB->TIPGUI == "I"
			cChaInt := BE4->(BE4_FILIAL+BE4_CODOPE+BE4_CODLDP+BE4_CODPEG+BE4_NUMERO+BE4_ORIMOV) + cCodPad + TRB->CODPRO
		Else
			cChaInt := BD5->(BD5_FILIAL+BD5_CODOPE+BD5_CODLDP+BD5_CODPEG+BD5_NUMERO+BD5_ORIMOV) + cCodPad + TRB->CODPRO
		Endif
		
		BD6->(DbSetOrder(6))
		
		If ! BD6->(DbSeek(cChaInt))
			lVerIte := .T.
		Endif
		
	Else
		lVerIte := .T.
	EndIf
	
	If lVerIte
		If PrecisaAut()
			aAdd(aLog,{TRB->NUMREG,"ERRO",TRB->DOC,cCodUsr,"Procedimento não Autorizado: "+TRB->CODPRO})
			lErro := .T.
		Endif
	Endif
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Valida procedimentos de consulta na mesma guia...					³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If nTotCon > 1
		If Ascan(aVetErr,"45") == 0
			aAdd(aLog,{TRB->NUMREG,"ERRO",TRB->DOC,cCodUsr,"Guia com mais de um procedimento de consulta"})
			Aadd(aVetErr,"45")
		Endif
		lErro := .T.
	Endif
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Monta vetor com registros a serem importados                        ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If ! lErro
		If (cCodPad+TRB->CODPRO) $ GetNewPar("MV_YCDCOEL","0100010014,0210101012")
			cTipGui := "01" // Consultas
		Else
			If TRB->TIPGUI == "I"
				cTipGui := "03" // Internacao
			Else
				cTipGui := "02" // Servicos
			EndIf
		EndIf
		aAdd(aReg,{TRB->CODRDA,cTipGui,TRB->DOC,TRB->(RecNo())})
	EndIf

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Totaliza erros encontrados...                                       ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If TRB->DOC <> cGuiAnt
		cGuiAnt := TRB->DOC
		If lErro
			nGuiErr++
		Endif
	Endif
	If lErro
		nIteErr++
	Endif
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Acessa proximo registro                                             ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ


TRB->(DbSkip())
Enddo

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Fim da funcao                                                       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Return
	
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ Grava    ³ Autor ³ Ricardo Mansi ³ Data ³ 08/04/05 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Grava os registros importados do arquivo texto             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ Grava()                                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ nenhum                                                     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function Grava()

Local x := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

Local cCodUsu := ""
Local nCtrl   := 1
Local nRegBA0 := 0
Local nTotDig := 0
Local lTemBBM := .F.

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Seleciona indices                                                   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
BAU->(DbSetOrder(01)) // Codigo da Rda
BBF->(DbSetOrder(01)) // Especialidade da RDA
BT5->(DbSetOrder(02)) // Contratos
BQC->(DbSetOrder(01)) // Subcontrato
BT6->(DbSetOrder(01)) // Subcontratos x Produtos
BA3->(DbSetOrder(01)) // Familia
BTS->(DbSetOrder(02)) // Vidas
BR8->(DbSetOrder(01)) // Tabela Padrao
BB8->(DbSetOrder(01)) // Local de Atendimento
BAX->(DbSetOrder(01)) // Especialidade x Rda
BB0->(DbSetOrder(01)) // Profissional da Saude
BR4->(DbSetOrder(01)) // Tipo de Tabela
BBM->(DbSetOrder(01)) // Especialidade x Procedimento

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta tamanho da regua                                              ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
ProcRegua(len(aReg)+1)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Movimenta regua                                                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
IncProc()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Ordena vetor aReg por RDA + Doc                                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
aSort(aReg,,, { |x,y| x[1]+x[3] < y[1]+y[3] })

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Valida o tipo da guia para todos os itens...                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
While nCtrl <= len(aReg)
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Inicializa variaveis para um numero de guia                         ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	cDocAnt := aReg[nCtrl,1]+aReg[nCtrl,3]
	lServ   := .F.
	lInt    := .F.
	lCons   := .F.
	ii      := nCtrl
	nTip    := 0
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifica o tipo de cada item da guia                                ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	While nCtrl <= len(aReg) .and. aReg[nCtrl,1]+aReg[nCtrl,3] == cDocAnt
		Do Case
			Case aReg[nCtrl,2] == "01"
				If ! lCons
					nTip++
				EndIf
				lCons := .T.
			Case aReg[nCtrl,2] == "02"
				If ! lServ
					nTip++
				EndIf
				lServ := .T.
			Case aReg[nCtrl,2] == "03"
				If ! lInt
					nTip++
				EndIf
				lInt  := .T.
		EndCase
		nCtrl++
	EndDo
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifica se encontrou mais de um tipo de item na mesma guia         ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If nTip > 1
		Do Case
			Case lInt
				cTip := "03"
			Case lServ
				cTip := "02"
			Otherwise
				cTip := "01"
		EndCase
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Muda o tipo de guia de cada item da guia                            ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		For x := ii to (nCtrl - 1)
			aReg[x,2] := cTip
		Next
	EndIf
	
EndDo

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Ordena vetor aReg para gerar uma PEG para cada tipo de guia         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
aSort(aReg,,, { |x,y| x[1]+x[2]+x[3] < y[1]+y[2]+y[3] })

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Processa vetor com identificacao dos registros a serem importados   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
nCtrl := 1
TRB->(DbGoTo(aReg[nCtrl][4]))

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Inicializa variavies                                                ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cMes 	  := mv_par02
cAno 	  := mv_par03
nQtdPro   := 0
nQtdItens := 0
nQtdGrv   := 0
nVlrGui   := 0

While nCtrl <= len(aReg)
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Inicializa variavies                                                ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	nTotDig := 0
	lTemBBM := .F. 
    _lAchou:= .F.


	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Acessa BAU-Rede de Atendimento                                      ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	BAU->(DbSeek(xFilial("BAU")+TRB->CODRDA))
	cCodPres := BAU->BAU_CODIGO
	cTipPres := BAU->BAU_TIPPE
	cCpfPres := BAU->BAU_CPFCGC
    cNomPres := BAU->BAU_NOME 
    cTipPre  := BAU->BAU_TIPPRE
    cCodRda := BAU->BAU_CODIGO
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Acessa BR8-Tabela Padrao		                                    ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
    BR8->(DbSetOrder(3))
    BR8->(DbSeek(xFilial("BR8")+TRB->CODPRO))
    BR8->(DbSetOrder(1))

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Acessa BR4-Tipo de Tabela		                                    ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
    BR4->(DbSeek(xFilial("BR4")+BR8->BR8_CODPAD))
	cCodPad := BR4->BR4_CODPAD
	While BR4->BR4_CODPAD == BR8->BR8_CODPAD .and. ! BR4->(Eof())    

        nTotDig += Val(BR4->BR4_DIGITO)
        
		If BR4->BR4_CODNIV == BR8->BR8_NIVEL
			Exit
		Endif
		
    	BR4->(DbSkip())
    EndDo
    
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Acessa BAX-Especialidade da RDA                                     ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If nTotDig > 0

		BAX->(DbSeek(xFilial("BAX")+cCodPres+cOper4))
	
		While BAX->(BAX_CODIGO+BAX_CODINT)==(cCodPres+cOper4) .and. ! BAX->(Eof())
			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Acessa BBM-Especialidade x Procedimento                             ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If BBM->(DbSeek(xFilial("BBM")+BAX->(BAX_CODINT+BAX_CODESP)+BR8->BR8_CODPAD+Substr(TRB->CODPRO,1,nTotDig)))
				lTemBBM := .T.
				Exit
	        Endif
			
			BAX->(DbSkip())
		EndDo
	
	Endif

	If lTemBBM
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Alimenta especialidade				                                ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		cEspPres := BAX->BAX_CODESP
	
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Alimenta local conforme especialidade                               ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		BB8->(DbSeek(xFilial("BB8")+BAX->(BAX_CODIGO+BAX_CODINT+BAX_CODLOC)))
		cLocal  := BB8->BB8_LOCAL
		cCodLoc := BB8->BB8_CODLOC
		cDesLoc := BB8->BB8_DESLOC
		cEndLoc := BB8->BB8_END

	Else

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Acessa BBF-Especialidade da RDA                                     ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		BBF->(DbSeek(xFilial("BBF")+cCodPres+cOper4))
	    cEspPres := BBF->BBF_CDESP

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Acessa BB8-Local de Atendimento                                     ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		BB8->(DbSeek(xFilial("BB8")+BAU->BAU_CODIGO+cOper4))
		cLocal  := BB8->BB8_LOCAL
		cCodLoc := BB8->BB8_CODLOC
		cDesLoc := BB8->BB8_DESLOC
		cEndLoc := BB8->BB8_END
	
		
	Endif

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Processa todas as guias da RDA                                      ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	cRdaAnt := aReg[nCtrl,1]
	
	While nCtrl <= len(aReg) .and. aReg[nCtrl,1] == cRdaAnt
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Acessa BBF-Especialidade da RDA                                     ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		BBF->(DbSeek(xFilial("BBF")+cCodPres+cOper4))//Incluida esta validacao Otacilio 14/07/2005
		cEspPres := BBF->BBF_CDESP
	    _lAchou:= .F.
	    
		While !BBF->(Eof()) .And. (xFilial("BBF")+cCodPres+cOper4) == BBF->(xFilial("BBF")+BBF_CODIGO+BBF_CODINT) .And. !_lAchou
	
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Acessa BBM-Especialidade x Procedimento                             ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			BBM->(DbSetOrder(3))
			BBM->(DbSeek(xFilial("BBM")+BBF->(BBF_CODINT+BBF_CDESP)+"01"+SubStr(TRB->CODPRO,1,2)))
			While !BBM->(Eof()) .AND. BBM->BBM_CODESP == BBF->BBF_CDESP
			      If BBM->BBM_NIVEL == "1" .And. BBM->BBM_ATIVO == '1'
			         If SubStr(TRB->CODPRO,1,2) == SubStr(BBM->BBM_CODPSA,1,2) 
			            cEspPres:= BBM->BBM_CODESP
			            _lAchou := .T.
			            Exit 
			         EndIf   
			      EndIf  
			      If BBM->BBM_NIVEL == "2" .And. BBM->BBM_ATIVO == '1'
	              	 If SubStr(TRB->CODPRO,1,4) == SubStr(BBM->BBM_CODPSA,1,4)
				  	 	cEspPres:= BBM->BBM_CODESP
			            _lAchou := .T.
				  	 	Exit
				  	 EndIf
				  EndIf 
				  
				  If BBM->BBM_NIVEL == "3" .And. BBM->BBM_ATIVO == '1'
	                 If Alltrim(TRB->CODPRO) == Substr(BBM->BBM_CODPSA,1,7)
				     	cEspPres:= BBM->BBM_CODESP
			            _lAchou := .T.
			            Exit
				     EndIf	  
				  EndIf   
				BBM->(DbSkip())
			EndDo
	
			BBF->(dbSkip())
		EndDo 
        // ate aqui  Otacilio 14/07/2005
        
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Inicializa variaveis                                                ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		nQtdPro   := 0
		nQtdItens := 0
		nQtdGrv   := 0 
		nVlrGui	  := 0

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Grava usuario de intercambio                                          ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If TRB->CODUSR == "INT"
			Grava_Usu()
		EndIf
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Posiciona Usuario...                          						  ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		Do Case
			Case TRB->CODUSR == "BA1"
				BA1->(DbSetorder(02))
			Case TRB->CODUSR $ "ANT,INT"
				BA1->(DbSetorder(05))
			Case TRB->CODUSR == "USB"
				BA1->(DbSetorder(10))
		EndCase
		
		If ! BA1->(DbSeek(xFilial("BA1")+"0"+TRB->CODOPE+TRB->CODEMP+TRB->MATRIC+TRB->TIPREG))
			BA1->(DbSeek(xFilial("BA1")+TRB->CODOPE+TRB->CODEMP+TRB->MATRIC+TRB->TIPREG))			
		Endif
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Posiciona Operadora do usuario...                          			  ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		BA0->(DbSeek(xFilial("BA0")+"0"+TRB->CODOPE))

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Alimenta Tabela conforme Operadora...			  		            ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	  //	cCodPad := BA0->BA0_YCDPAD

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Posiciona BA3-Familia...                          					  ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		BA3->(DbSeek(xFilial("BA3")+BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC)))

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Grava PEG se for o caso...											³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		Grava_Peg("I",aReg[nCtrl,2])

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Processa todos os itens da guia                                     ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		cDocAnt := aReg[nCtrl,3]
		
		While nCtrl <= len(aReg) .and. aReg[nCtrl,1] == cRdaAnt .and. aReg[nCtrl,3] == cDocAnt
			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Movimenta regua                                                     ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			IncProc()
			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Gravo o tipo da Guia...			                                    ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			cTipAnt := aReg[nCtrl,2]
			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Acessa BB0-Profissionais de Saude - Solicitante                     ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			cOpeSol := ""
			cCodSol := ""
			cNomSol := ""
			cSigSol := ""
			cRegSol := ""
			cEstSol := ""
			
			If ! Empty(TRB->CODSOL)

				If TRB->CODSOL <> TRB->CODRDA
					If !BAU->(DbSeek(xFilial("BAU")+TRB->CODSOL))
					    BAU->(DbSetOrder(1))
						BAU->(DbSeek(xFilial("BAU")+"000510")) //RDA SOLICITANTE GENERICA
					EndIf
				EndIf
				If BAU->BAU_TIPPE == "F"
					BB0->(DbSeek(xFilial("BB0")+BAU->BAU_CODBB0))
					cCodSol := BB0->BB0_CODIGO
					cNomSol := BB0->BB0_NOME
					cSigSol := BB0->BB0_CODSIG
					cRegSol := BB0->BB0_NUMCR
					cEstSol := BB0->BB0_ESTADO
					cSigSol := BB0->BB0_CODSIG
     			EndIf 
     			
				If TRB->CODSOL <> TRB->CODRDA
				    BAU->(DbSetOrder(01))
					BAU->(DbSeek(xFilial("BAU")+TRB->CODRDA))
				EndIf

			EndIf
			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Acessa BB0-Profissionais de Saude - Executante...                   ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			cCodExe := ""
			cNomExe := ""
			cSigExe := ""
			cRegExe := ""
			cEstExe := ""
			
			If ! Empty(TRB->CODEXE)
				
				If TRB->CODEXE <> TRB->CODRDA
					
					BAU->(DbSeek(xFilial("BAU")+TRB->CODEXE))
					
					BB0->(DbSeek(xFilial("BB0")+BAU->BAU_CODBB0))
					
					cCodExe := BB0->BB0_CODIGO
					cNomExe := BB0->BB0_NOME
					cSigExe := BB0->BB0_CODSIG
					cRegExe := BB0->BB0_NUMCR
					cEstExe := BB0->BB0_ESTADO
					
					BAU->(DbSeek(xFilial("BAU")+TRB->CODRDA))
					
				EndIf
				
			EndIf
			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Grava item da guia                                                  ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			Grava_Item()
			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Acumula valores                                                     ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			nQtdPro   += TRB->QTDPRO //TRB->QTDPRO/100
			nQtdItens ++
			cCodUsu := "0"+TRB->CODOPE+TRB->CODEMP+TRB->MATRIC+TRB->TIPREG+Modulo11("0"+TRB->CODOPE+TRB->CODEMP+TRB->MATRIC+TRB->TIPREG)
			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Acessa proximo registro valido                                      ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			nCtrl++
			
			If nCtrl <= len(aReg)
				TRB->(DbGoTo(aReg[nCtrl,4]))
			EndIf
		EndDo
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Grava cabecalho da Guia                                             ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		Grava_Guia()

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Grava vetor com guia processadas                                    ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		aAdd(aImp,{cDocAnt,_cPeg,cNumero,cCodUsu,BA1->BA1_NOMUSR,nQtdItens})
				
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Grava PEG - complementa informacoes                                 ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		Grava_Peg("A")

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Caso seja Rda Generica, altera informacoes                          ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		AltRdaGen()

	EndDo
EndDo

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Fim da funcao                                                       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ Grava_Usu³ Autor ³ Ricardo Mansi ³ Data ³ 08/04/05 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Grava Usuario de Intercambio                               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ Grava_Usu                                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ nenhum                                                     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function Grava_Usu()

Local cCdGeIe := GetNewPar("MV_PLSGEIN","9998")
Local cLayOut := Substr(TRB->VERLAY,1,3)
Local dDatInc := StoD("")

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Calcula data de inclusao...											³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If cLayout $ "301/400/500/600"
	dDatInc := (StoD(Substr(TRB->DATPRO,05,04)+Substr(TRB->DATPRO,03,02)+Substr(TRB->DATPRO,01,02))-365)
Else
	dDatInc := (StoD(Substr(TRB->EMISSA,05,04)+Substr(TRB->EMISSA,03,02)+Substr(TRB->EMISSA,01,02))-365)
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Seleciona indices                                                   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
BT5->(DbSetOrder(2)) // Contratos
BQC->(DbSetOrder(1)) // Subcontrato
BT6->(DbSetOrder(1)) // Subcontratos x Produtos
BTS->(DbSetOrder(2)) // Vida
BA1->(DbSetOrder(5)) // Usuario
BA3->(DbSetOrder(1)) // Familia

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Posiciona Contrato...												  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
BT5->(DbSeek(xFilial("BT5")+cOper4+"1"+GetNewPar("MV_PLSCDIE","04")+"1"))

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Posiciona Sub-Contrato...											  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
BQC->(DbSeek(xFilial("BQC")+BT5->(BT5_CODINT+BT5_CODIGO+BT5_NUMCON+BT5_VERSAO)))

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Posiciona Produto x Sub-Contrato...									  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
BT6 ->(DbSeek(xFilial("BT6")+BQC->(BQC_CODINT+BQC_CODEMP+BQC_NUMCON+BQC_VERCON+BQC_SUBCON+BQC_VERSUB)))

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica se a vida ja existe                                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
lTemBTS := .F.
dDatNas := StoD(Substr(TRB->DATNAS,05,04)+Substr(TRB->DATNAS,03,02)+Substr(TRB->DATNAS,01,02))

BTS->(DbSeek(xFilial("BTS")+alltrim(TRB->NOMUSR)))
While BTS->BTS_FILIAL == xFilial("BTS") .and. Alltrim(BTS->BTS_NOMUSR) == alltrim(TRB->NOMUSR) .and. ! BTS->(eof())
	If  BTS->BTS_DATNAS == dDatNas
		lTemBts := .T.
		Exit
	End
	BTS->(DbSkip())
Enddo

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Grava BTS-Vidas                                                       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If ! lTemBTS
	BTS->(RecLock("BTS",.T.))
	BTS->BTS_FILIAL := xFilial("BTS")
	BTS->BTS_MATVID := GetSx8Num("BTS","BTS_MATVID")
	BTS->BTS_NOMUSR := Alltrim(TRB->NOMUSR)
	BTS->BTS_NOMCAR := Alltrim(TRB->NOMUSR)
	BTS->BTS_SEXO   := IIF(TRB->SEXO = "M","1","2")
	BTS->BTS_DATNAS := dDatNas
	BTS->BTS_ESTCIV := "S"
	BTS->BTS_DRGUSR := "1"
	BTS->BTS_CEPUSR := Posicione("BA0",1,xFilial("BA0")+"0"+TRB->CODOPE,"BA0->BA0_CEP")
	BTS->(MsUnlock())
	ConfirmSx8()
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica se a familia ja existe                                       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
lTemBA3 := .F.

If BA1->(DbSeek(xFilial("BA1")+"0"+TRB->CODOPE+TRB->CODEMP+TRB->MATRIC))
	If BA3->(DbSeek(xFilial("BA3")+BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC)))
		lTemBA3 := .T.
	EndIf
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica se deve criar familia                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If ! lTemBA3
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Identifica numero da matricula                                        ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	cMatric := PLPROXMAT(cOper4,cCdGeIe)
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Grava BA3-Familia/Usuario                                             ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	BA3->(Reclock("BA3",.T.))
	BA3->BA3_FILIAL := xFilial("BA3")
	BA3->BA3_CODINT := BQC->BQC_CODINT
	BA3->BA3_CODEMP := BQC->BQC_CODEMP
	BA3->BA3_CONEMP := BQC->BQC_NUMCON
	BA3->BA3_VERCON := BQC->BQC_VERCON
	BA3->BA3_SUBCON := BQC->BQC_SUBCON
	BA3->BA3_VERSUB := BQC->BQC_VERSUB
	BA3->BA3_MATRIC := cMatric
	BA3->BA3_MATANT := "0"+TRB->CODOPE+TRB->CODEMP+TRB->MATRIC
	BA3->BA3_HORACN := StrTran(Time(),":","")
	BA3->BA3_COBNIV := "0"
	BA3->BA3_VENCTO := 0
	BA3->BA3_DATBAS := dDatInc
	BA3->BA3_TIPOUS := "2"
	BA3->BA3_CODPLA := BT6->BT6_CODPRO
	BA3->BA3_VERSAO := BT6->BT6_VERSAO
	BA3->BA3_FORPAG := GetNewPar("MV_PLSFCPE","101")
	BA3->BA3_DATCON := Date()
	BA3->BA3_HORCON := SubStr(Time(),1,5)
	BA3->(MsUnlock())
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica se o usuario ja existe                                       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
lTemBA1 := .F.

If BA1->(DbSeek(xFilial("BA1")+"0"+TRB->CODOPE+TRB->CODEMP+TRB->MATRIC+TRB->TIPREG))
	lTemBA1 := .T.
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Grava BA1-Usuario                                                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If ! lTemBA1
	BA1->(RecLock("BA1",.T.))
	BA1->BA1_FILIAL := xFilial("BA1")
	BA1->BA1_CODINT := BA3->BA3_CODINT
	BA1->BA1_CODEMP := BA3->BA3_CODEMP
	BA1->BA1_MATRIC := BA3->BA3_MATRIC
	BA1->BA1_TIPREG := TRB->TIPREG
	BA1->BA1_DIGITO := Modulo11(BA1->BA1_CODINT+BA1->BA1_CODEMP+BA1->BA1_MATRIC+BA1->BA1_TIPREG)
	BA1->BA1_CONEMP := BA3->BA3_CONEMP
	BA1->BA1_VERCON := BA3->BA3_VERCON
	BA1->BA1_SUBCON := BA3->BA3_SUBCON
	BA1->BA1_VERSUB := BA3->BA3_VERSUB
	BA1->BA1_IMAGE  := "ENABLE"
	BA1->BA1_MATVID := BTS->BTS_MATVID
	BA1->BA1_NOMUSR := BTS->BTS_NOMUSR
	BA1->BA1_TIPUSU := IIF(TRB->TIPREG == "00","T","D")
	BA1->BA1_SEXO   := IIF(TRB->SEXO == "M","1","2")
	BA1->BA1_MATANT := "0"+TRB->CODOPE+TRB->CODEMP+TRB->MATRIC+TRB->TIPREG+Modulo11("0"+TRB->CODOPE+TRB->CODEMP+TRB->MATRIC+TRB->TIPREG)
	BA1->BA1_DATINC := dDatInc
	BA1->BA1_DATNAS := BTS->BTS_DATNAS
	BA1->BA1_COEFIC := 1
	BA1->BA1_CBTXAD := "1"
	BA1->BA1_OPEORI := "0" + TRB->CODOPE
	BA1->BA1_OPEDES := "0" + TRB->CODOPE
	BA1->BA1_OPERES := "0" + TRB->CODOPE
	BA1->BA1_LOCATE := "2"
	BA1->BA1_LOCCOB := "2"
	BA1->BA1_LOCEMI := "2"
	BA1->BA1_LOCANS := "2"
	BA1->BA1_MAE    := "USUARIO DE INTERCAMBIO EVENTUAL"
	BA1->BA1_DATCAR := BA1->BA1_DATINC
	BA1->BA1_ESTCIV := "S"
	BA1->BA1_GRAUPA := IIF(BA1->BA1_TIPREG=="00","01","11")
	BA1->(MsUnlock())
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Fim da funcao                                                       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ Grava_Item ³ Autor ³ Ricardo Mansi ³ Data ³ 08/04/05 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Grava item da guia                                           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ Grava_Item                                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ nenhum                                                       ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function Grava_Item()

Local cTipPar := ""
Local cEstPre := ""
Local cSigla  := ""
Local cNomRda := ""
Local cSeq    := ""
Local nPos    := 0
Local lAtual  := .F.
Local lRet    := .F.
Local cLayOut := Substr(TRB->VERLAY,1,3)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Atualiza variaveis...												³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dDatInt := StoD(TRB->INTERN)//StoD(Substr(TRB->INTERN,05,04)+Substr(TRB->INTERN,03,02)+Substr(TRB->INTERN,01,02))
cHorInt := TRB->HORINT
dDatAlt := StoD(TRB->SAIDA)//StoD(Substr(TRB->SAIDA,05,04)+Substr(TRB->SAIDA,03,02)+Substr(TRB->SAIDA,01,02))
cHorAlt := TRB->HORSAI

If cLayout $ "301/400/500/600"
	dDatPro := StoD(TRB->DATPRO)//StoD(Substr(TRB->DATPRO,05,04)+Substr(TRB->DATPRO,03,02)+Substr(TRB->DATPRO,01,02))
	cHorPro := TRB->HORPRO
	If VldMatMed(cCodPad,TRB->CODPRO)
		dDatPro := StoD(TRB->DATPRO)// StoD(Substr(TRB->EMISSA,05,04)+Substr(TRB->EMISSA,03,02)+Substr(TRB->EMISSA,01,02))
	Endif
Else
	dDatPro := StoD(TRB->EMISSA)//StoD(Substr(TRB->EMISSA,05,04)+Substr(TRB->EMISSA,03,02)+Substr(TRB->EMISSA,01,02))
	cHorPro := cHorInt
Endif

dDatDig := dDataBase
cCodPro := alltrim(TRB->CODPRO)
cCidDef := TRB->CIDDEF
cNumDoc := TRB->DOC
cTipAlt := TRB->TIPALT
If cLayout $ "300/400/500/600"
	cTipNas := TRB->TIPNAS
Else
	cTipNas := ""
Endif
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Acessa BI3                                                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If ! BI3->(DbSeek(xFilial("BI3")+BA1->(BA1_CODINT+BA1_CODPLA+BA1_VERSAO)))
	BI3->(DbSeek(xFilial("BI3")+BA3->(BA3_CODINT+BA3_CODPLA+BA3_VERSAO)))
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Acessa BR8                                                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
BR8->(DbSeek(xFilial("BR8")+cCodPad+cCodPro))
cCodPro := BR8->BR8_CODPSA

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Grava BD6                                                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
BD6->(DbsetOrder(6))

If BD6->(DbSeek(xFilial("BD6")+cOper4+cCodLdp+_cPeg+cNumero+cOriMov+cCodPad+cCodPro))
	
	If cTipAnt <> "03"
		BD6->(Reclock("BD6",.F.))
		BD6->BD6_SITUAC := "1"
		BD6->(MsUnlock())
	Endif
	
Else
	
	lRet := .T.
	cSeq := ProxSeq(cOper4 ,  cCodLdp, _cPeg, cNumero, cOriMov)
	
	BD6->(DbsetOrder(12))
	BD6->(Reclock("BD6",.T.))
	BD6->BD6_FILIAL := xFilial("BD6")
	BD6->BD6_CODOPE := cOper4
	BD6->BD6_CODLDP := cCodLdp
	BD6->BD6_CODPEG := _cPeg
	BD6->BD6_NUMERO := cNumero
	BD6->BD6_SEQUEN := cSeq
	BD6->BD6_NUMIMP := StrZero(Val(cNumDoc),16)
	BD6->BD6_CODPAD := cCodPad
	BD6->BD6_CODPRO := cCodPro
	BD6->BD6_QTDPRO := TRB->QTDPRO//TRB->QTDPRO/100
	BD6->BD6_VLRAPR := IIF(TRB->VALOR>0,TRB->VALOR/100,0)
	BD6->BD6_DESPRO := Posicione("BR8",1,xFilial("BR8")+cCodPad+cCodPro,"BR8_DESCRI")
	BD6->BD6_LOCAL  := cLocal
	BD6->BD6_CODESP := cEspPres
	BD6->BD6_OPEUSR := BA1->BA1_CODINT
	BD6->BD6_CODEMP := BA1->BA1_CODEMP
	BD6->BD6_MATRIC := BA1->BA1_MATRIC
	BD6->BD6_TIPREG := BA1->BA1_TIPREG
	BD6->BD6_CONEMP := BA1->BA1_CONEMP
	BD6->BD6_MATVID := BA1->BA1_MATVID
	BD6->BD6_FASE   := "1"
	BD6->BD6_SITUAC := "1"
	BD6->BD6_MESPAG := cMes
	BD6->BD6_ANOPAG := cAno
	BD6->BD6_OPERDA := cOper4
	BD6->BD6_CODRDA := cCodPres
	BD6->BD6_DATPRO := dDatPro
	BD6->BD6_DTDIGI := dDatDig
	BD6->BD6_ANOINT := Substr(TRB->INTERN,5,4)
	BD6->BD6_MESINT := Substr(TRB->INTERN,3,2)
	BD6->BD6_NUMINT := cNumero
	BD6->BD6_TPGRV  := "4"
	BD6->BD6_STATUS := "1"
	BD6->BD6_SIGLA  := cSigSol
	BD6->BD6_ESTSOL := cEstSol
	BD6->BD6_NOMSOL := cNomSol
	BD6->BD6_CODLOC := cCodLoc
	BD6->BD6_CDPFSO := cCodSol
	BD6->BD6_DIGITO := BA1->BA1_DIGITO
	BD6->BD6_ATEAMB := IIF(TRB->TIPGUI=="I","0","1")
	If ! Empty(TRB->CIDDEF) .and. TRB->CIDDEF <> "0000000"
		BD6->BD6_CID := TRB->CIDDEF
	Endif
	BD6->BD6_CPFRDA := cCpfPres
	BD6->BD6_DATNAS := BA1->BA1_DATNAS
	BD6->BD6_DESLOC := cDesLoc
	BD6->BD6_ENDLOC := cEndLoc
	BD6->BD6_IDUSR  := BA1->BA1_DRGUSR
	BD6->BD6_NOMRDA := cNomPres
	BD6->BD6_NOMUSR := BA1->BA1_NOMUSR
	BD6->BD6_REGSOL := cRegSol
	BD6->BD6_TIPGUI := cTipAnt
	BD6->BD6_TIPRDA := cTipPres
	BD6->BD6_MATUSA := IIF(TRB->CODUSR == "BA1","1","2")
	BD6->BD6_MATANT := BA1->BA1_MATANT
	BD6->BD6_CODPLA := BI3->BI3_CODIGO
	BD6->BD6_GUIORI := TRB->DOC
	BD6->BD6_REGEXE := cRegExe
	BD6->BD6_CDPFRE := cCodExe
	BD6->BD6_ESTEXE := cEstExe
	BD6->BD6_SIGEXE := cSigExe
	BD6->BD6_ORIMOV := IIF(BD6->BD6_TIPGUI ="03","2","1")
	BD6->BD6_GUIACO := "0"
	BD6->BD6_NIVEL  := BR8->BR8_NIVEL
	BD6->BD6_TIPUSR := BA3->BA3_TIPOUS
	BD6->BD6_MODCOB := BA3->BA3_MODPAG
	BD6->BD6_INTERC := IIF(TRB->CODUSR == "INT","1","0")
	BD6->BD6_PROCCI := IIF(BR8->BR8_TIPEVE=="2","1","0")
	BD6->BD6_VIA    := IIF(BR8->BR8_CTREQU=="1","1","0")
	BD6->BD6_CDPDRC := cCodPad
	BD6->BD6_PERVIA := IIF(cTipAnt=="03",100,0)
	BD6->BD6_TIPINT := IIF(TRB->CODUSR == "INT","1","")
	M->BD6_CDNV01   := ""
	M->BD6_CDNV02   := ""
	M->BD6_CDNV03   := ""
	M->BD6_CDNV04   := ""
	PLSGatNiv(cCodPad,cCodPro,"BD6")
	BD6->BD6_CDNV01 := M->BD6_CDNV01
	BD6->BD6_CDNV02 := M->BD6_CDNV02
	BD6->BD6_CDNV03 := M->BD6_CDNV03
	BD6->BD6_CDNV04 := M->BD6_CDNV04
	aCodTab := PLSRETTAB(BD6->BD6_CODPAD,BD6->BD6_CODPRO,BD6->BD6_DATPRO,;
	BD6->BD6_CODOPE,BD6->BD6_CODRDA,BD6->BD6_CODESP,BD6->BD6_SUBESP,BD6->(BD6_CODLOC+BD6_LOCAL))
	If aCodTab[1]
		BD6->BD6_CODTAB := aCodTab[3]
		BD6->BD6_ALIATB := aCodTab[4]
	EndIf
	BD6->BD6_CONEMP := BA1->BA1_CONEMP
	BD6->BD6_VERCON := BA1->BA1_VERCON
	BD6->BD6_SUBCON := BA1->BA1_SUBCON
	BD6->BD6_VERSUB := BA1->BA1_VERSUB
	BD6->BD6_OPEORI := cOper4
	If BD6->BD6_QTD1 = 0
		BD6->BD6_QTD1  := 1
		BD6->BD6_PERC1 := 100
	EndIf
	BD6->(MsUnlock())

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Grava BD7                                                           ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	nPos := BAU->(Recno())

	BAU->(DbSetOrder(01))
	BAU->(DbSeek(xFilial("BAU")+TRB->CODEXE))

	If BD6->BD6_CODRDA <> BAU->BAU_CODIGO
		cRda := BAU->BAU_CODIGO
		cCrm := BAU->BAU_CONREG
		cBB0 := BAU->BAU_CODBB0
	Else
		cRda := BD6->BD6_CODRDA
		cCrm := BAU->BAU_CONREG
		cBB0 := BAU->BAU_CODBB0
	EndIf

	BAU->(DbGoTo(nPos))
	
	PLS720IBD7("0",BD6->BD6_VLPGMA,BD6->BD6_CODPAD,BD6->BD6_CODPRO,BD6->BD6_CODTAB,;
	BD6->BD6_CODOPE,CRDA,BD6->BD6_REGEXE,BD6->BD6_SIGEXE,;
	BD6->BD6_ESTEXE,BD6->BD6_CDPFRE,BD6->BD6_CODESP,BD6->BD6_CODLOC,;
	"1",BD6->BD6_SEQUEN,BD6->BD6_ORIMOV,BD6->BD6_TIPGUI)
	
	nQtdGrv++
	
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Atualiza informacoes em BD7...                                      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cTipPar := TRB->TIPPAR

Do Case
	Case cTipPar == "L"
		If ! (cLayout $ "400/500/600")
			cTipPar := "0"
		EndIf
	Case cTipPar $ "M/P/I"
		cTipPar := "0"
EndCase

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Alimenta codigo da Rda...                                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
BAU->(DbSetOrder(01))
BAU->(DbSeek(xFilial("BAU")+TRB->CODEXE))

cRda	  := BAU->BAU_CODIGO
cNomRda := BAU->BAU_NOME
cBB0 	  := BAU->BAU_CODBB0
cCrm 	  := BAU->BAU_CONREG
cEstPre := BAU->BAU_SIGLCR
cSigla  := BAU->BAU_ESTCR

cChaveGui := BD6->(BD6_CODOPE+BD6_CODLDP+BD6_CODPEG+BD6_NUMERO+BD6_ORIMOV+BD6_SEQUEN)

BD7->(DbSetOrder(1))
BD7->(DbSeek(xFilial("BD7")+cChaveGui))

While BD7->(BD7_FILIAL+BD7_CODOPE+BD7_CODLDP+BD7_CODPEG+BD7_NUMERO+BD7_ORIMOV+BD7_SEQUEN) == xFilial("BD7")+cChaveGui .and. ! BD7->(Eof())
	
	nPos := Ascan(aRelacao,{|x| cTipPar == x[1] .and. AllTrim(BD7->BD7_CODUNM) $ x[2] })
	
	If nPos > 0
		
		BD7->(RecLock("BD7",.F.))
		BD7->BD7_CODRDA := cRda
		BD7->BD7_REGPRE := cCrm
		BD7->BD7_CDPFPR := cBB0
		BD7->BD7_ESTPRE := cEstPre
		BD7->BD7_SIGLA  := cSigla
		BD7->BD7_NOMPRE := cNomRda
		BD7->BD7_NOMRDA := cNomRda
		BD7->BD7_CODTPA := cTipPar
		If ! lAtual
			BD7->BD7_VLRAPR := TRB->VALOR/100
			lAtual := .T.
		Endif
		BD7->(MsUnLock())
		
	EndIf
	
	BD7->(DbSkip())
Enddo

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Fim da funcao                                                       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Return lRet
	
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ Grava_Peg³ Autor ³ Ricardo Mansi ³ Data ³ 08/04/05 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Grava BCI - PEG											  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ Grava_Peg()                                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ nenhum                                                     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function Grava_Peg(cOpcao,cTipGui)

Local cChaBCI := ""
Local cLdpPad := GetNewPar("MV_YCODLDP","0002")
Local lTemBCI := .F.
Local lAchou  := .F.

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Grava BCI-PEG                                                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If cOpcao == "I"
	
	If TRB->TIPGUI == "I"

		lAchou := .F.
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Posiciona Nro Impresso + Usuario...									³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		BE4->(DbSetOrder(6))
		BE4->(DbSeek(xFilial("BE4")+TRB->DOC))
		
		While (BE4->BE4_FILIAL+substr(BE4->BE4_NUMIMP,10,7))==(xFilial("BE4")+TRB->DOC) .and. ! BE4->(Eof())
			
			If BE4->(BE4_OPEUSR+BE4_CODEMP+BE4_MATRIC+BE4_TIPREG) == BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG)
				lAchou := .T.
				Exit
			EndIf
			
			BE4->(DbSkip())
		EndDo

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Pocisiona Senha + Usuario...										³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If ! lAchou

			If Val(TRB->SENHA) > 0
			
				BE4->(DbSetOrder(7))
				BE4->(DbSeek(xFilial("BE4")+TRB->SENHA))
		
				While BE4->(BE4_FILIAL+BE4_SENHA)==(xFilial("BE4")+TRB->SENHA) .and. ! BE4->(Eof())
					
					If BE4->(BE4_OPEUSR+BE4_CODEMP+BE4_MATRIC+BE4_TIPREG) == BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG)
						Exit
					EndIf
		
					BE4->(DbSkip())
				EndDo
		    
			Endif
			
		Endif
		
		_cPeg   := BE4->BE4_CODPEG
		cCodLdp := BE4->BE4_CODLDP
		cNumero := BE4->BE4_NUMERO
		cOriMov := BE4->BE4_ORIMOV
	
		BCI->(DbSetOrder(1))
		BCI->(DbSeek(xFilial("BCI")+BE4->(BE4_CODOPE+BE4_CODLDP+BE4_CODPEG)))
		
		BR8->(DbSeek(xFilial("BR8")+cCodPad+alltrim(TRB->CODPRO)))
		cCodPro := BR8->BR8_CODPSA
		
		BD6->(DbsetOrder(6))
		BD6->(DbSeek(xFilial("BD6")+BE4->(BE4_CODOPE+BE4_CODLDP+BE4_CODPEG+BE4_NUMERO+BE4_ORIMOV)))
		
	Else
		
		lAchou := .F.
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Verifica Nro Impresso + Usuario...									³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		BD5->(DbSetOrder(6))
		BD5->(DbSeek(xFilial("BD5")+TRB->DOC))
		
		While (BD5->BD5_FILIAL+substr(BD5->BD5_NUMIMP,10,7))==(xFilial("BD5")+TRB->DOC) .and. ! BD5->(Eof())
			
			If BD5->(BD5_OPEUSR+BD5_CODEMP+BD5_MATRIC+BD5_TIPREG) == BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG)
				lAchou := .T.
				Exit
			EndIf
			
			BD5->(DbSkip())
		EndDo

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Verifica Senha + Usuario...											³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If ! lAchou
		
			If Val(TRB->SENHA) > 0      //Incluida esta linha Otacilio 14/07/2005
				BD5->(DbSetOrder(7))
				BD5->(DbSeek(xFilial("BD5")+TRB->SENHA))
		
				While BD5->(BD5_FILIAL+BD5_SENHA)==(xFilial("BD5")+TRB->SENHA) .and. ! BD5->(Eof())
		
					If BD5->(BD5_OPEUSR+BD5_CODEMP+BD5_MATRIC+BD5_TIPREG) == BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG)
						lAchou := .T.
						Exit
					EndIf
		
					BD5->(DbSkip())
				EndDo
		    EndIf
		Endif
		
		If lAchou

			_cPeg   := BD5->BD5_CODPEG
			cCodLdp := BD5->BD5_CODLDP
			cNumero := BD5->BD5_NUMERO
			cOriMov := BD5->BD5_ORIMOV
			
			BCI->(DbSetOrder(1))
			BCI->(DbSeek(xFilial("BCI")+BD5->(BD5_CODOPE+BD5_CODLDP+BD5_CODPEG)))
			
			BR8->(DbSeek(xFilial("BR8")+cCodPad+alltrim(TRB->CODPRO)))
			cCodPro := BR8->BR8_CODPSA
			
			BD6->(DbsetOrder(6))
			BD6->(DbSeek(xFilial("BD6")+BD5->(BD5_CODOPE+BD5_CODLDP+BD5_CODPEG+BD5_NUMERO+BD5_ORIMOV)))
			
		Else
			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Verifica se cria PEG...            			 						  ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			cChaBCI := cOper4 + cCodPres + cAno + cMes + "2"
			
			BCI->(DbSetOrder(4))
			BCI->(DbSeek(xFilial("BCI")+cChaBCI))
			
			While BCI->(BCI_OPERDA+BCI_CODRDA+BCI_ANO+BCI_MES+BCI_TIPO)==cChaBCI .and. ! BCI->(Eof())
				
				If BCI->BCI_TIPGUI == cTipGui .and. BCI->BCI_CODLDP == cLdpPad .and. BCI->BCI_SITUAC == "1" .and. BCI->BCI_FASE <= "3"
					lTemBCI := .T.
					Exit
				Endif
				
				BCI->(DbSkip())
			EndDo
			
			If lTemBCI
				
				If BCI->BCI_FASE == "3"
					BCI->(RecLock("BCI",.F.))
					BCI->BCI_FASE := "1"
					BCI->(MsUnlock())
				Endif
				
			Else
				
				BCI->(RecLock("BCI",.T.))
				BCI->BCI_FILIAL := xFilial("BCI")
				BCI->BCI_CODOPE := cOper4
				BCI->BCI_CODLDP := cLdpPad
				BCI->BCI_CODPEG := PLSA175COD(cOper4,cCodLdp)
				BCI->BCI_OPERDA := cOper4
				BCI->BCI_CODRDA := cCodPres
				BCI->BCI_NOMRDA := cNomPres
				BCI->BCI_MES    := cMes
				BCI->BCI_ANO    := cAno
				BCI->BCI_TIPGUI := cTipGui
				BCI->BCI_CODCOR := Posicione("BCL",1,xFilial("BCL")+cOper4+cTipGui,"BCL_CODCOR")
				BCI->BCI_TIPSER := GetNewPar("MV_PLSTPSP","01")
				BCI->BCI_DATREC := dDataBase
				BCI->BCI_DTDIGI := dDataBase
				BCI->BCI_STATUS := "1"
				BCI->BCI_FASE   := "1"
				BCI->BCI_SITUAC := "1"
				BCI->BCI_TIPO   := "2"
				BCI->BCI_QTDEVE := 0
				BCI->BCI_QTDEVD := 0
				BCI->BCI_TIPPRE := cTipPre
				BCI->(MsUnlock())
				
			EndIf
			
			_cPeg   := BCI->BCI_CODPEG
			cCodLdp := BCI->BCI_CODLDP
			cOriMov := "1"
			cNumero := ProxBD5(BCI->BCI_CODOPE,BCI->BCI_CODLDP,BCI->BCI_CODPEG)
			
		EndIf
	EndIf
	
Else
	BCI->(RecLock("BCI",.F.))
	BCI->BCI_QTDEVE := BCI->BCI_QTDEVE + nQtdGrv
	BCI->BCI_QTDEVD := BCI->BCI_QTDEVE + nQtdGrv  
	BCI->(MsUnlock())
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Fim da funcao                                                       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ Grava_Guia ³ Autor ³ Ricardo Mansi ³ Data ³ 08/04/05 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Grava Guia - BE4 (Internacao) ou BD5 (Consultas/Servicos)    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ Grava_Guia()                                                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ nenhum                                                       ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function Grava_Guia()

Local cCodLdp := GetNewPar("MV_YCODLDP","0002")

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Grava Cabecalho da Guia somente para as guias importadas...			³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If BCI->BCI_CODLDP == cCodLdp
	
	BD5->(DbSetOrder(1))
	If ! BD5->(DbSeek(xFilial("BD5")+BD6->(BD6_CODOPE+BD6_CODLDP+BD6_CODPEG+BD6_NUMERO)))
		
		BD5->(RecLock("BD5",.T.))
		BD5->BD5_FILIAL := xFilial("BD5")
		BD5->BD5_CODOPE := cOper4
		BD5->BD5_TIPPAC := "1"
		BD5->BD5_CODLDP := cCodLdp
		BD5->BD5_CODPEG := _cPeg
		BD5->BD5_NUMERO := cNumero
		BD5->BD5_NUMIMP := StrZero(Val(cNumDoc),16)
		BD5->BD5_DATPRO := dDatPro
		BD5->BD5_HORPRO := cHorPro
		BD5->BD5_OPEUSR := cOper4
		BD5->BD5_MATANT := BA1->BA1_MATANT
		BD5->BD5_NOMUSR := BA1->BA1_NOMUSR
		BD5->BD5_CODRDA := cCodPres
		BD5->BD5_OPERDA := cOper4
		BD5->BD5_TIPRDA := cTipPres
		BD5->BD5_NOMRDA := cNomPres
		BD5->BD5_DESLOC := cDesLoc
		BD5->BD5_ENDLOC := cEndLoc
		BD5->BD5_CODESP := cEspPres
		BD5->BD5_CID    := cCidDef
		BD5->BD5_ESTSOL := cEstSol
		BD5->BD5_OPESOL := cOpeSol
		BD5->BD5_SIGLA  := cSigSol
		BD5->BD5_REGSOL := cRegSol
		BD5->BD5_NOMSOL := cNomSol
		BD5->BD5_TIPCON := IIF(TRB->TIPGUI=="E","2","1")
		BD5->BD5_TIPGUI := cTipAnt
		BD5->BD5_ATEAMB := "1"
		BD5->BD5_CDPFSO := cCodSol
		BD5->BD5_CODEMP := BA1->BA1_CODEMP
		BD5->BD5_MATRIC := BA1->BA1_MATRIC
		BD5->BD5_TIPREG := BA1->BA1_TIPREG
		BD5->BD5_CPFUSR := BA1->BA1_CPFUSR
		BD5->BD5_IDUSR  := BA1->BA1_DRGUSR
		BD5->BD5_DATNAS := BA1->BA1_DATNAS
		BD5->BD5_CPFRDA := cCpfPres
		BD5->BD5_FASE   := "1"
		BD5->BD5_SITUAC := "1"
		BD5->BD5_DIGITO := BA1->BA1_DIGITO
		BD5->BD5_CONEMP := BA1->BA1_CONEMP
		BD5->BD5_VERCON := BA1->BA1_VERCON
		BD5->BD5_SUBCON := BA1->BA1_SUBCON
		BD5->BD5_VERSUB := BA1->BA1_VERSUB
		BD5->BD5_LOCAL  := cLocal
		BD5->BD5_CODLOC := cCodLoc
		BD5->BD5_MATVID := BA1->BA1_MATVID
		BD5->BD5_DTDIGI := dDatDig
		BD5->BD5_MATUSA := IIF(TRB->CODUSR == "BA1","1","2")
		BD5->BD5_QTDEVE := nQtdPro
		BD5->BD5_REGEXE := cRegExe
		BD5->BD5_CDPFRE := cCodExe
		BD5->BD5_ESTEXE := cEstExe
		BD5->BD5_SIGEXE := cSigExe
		BD5->BD5_ORIMOV := IIF(BD6->BD6_TIPGUI ="03","2","1")
		BD5->BD5_MESPAG := cMes
		BD5->BD5_ANOPAG := cAno
		BD5->BD5_GUIACO := "0"
		BD5->BD5_SENHA  := IIF(Val(TRB->SENHA)>0,TRB->SENHA,"")
	   //BD5->BD5_YUSIMP := cUserName
		BD5->BD5_ESTEXE := GetNewPar("MV_PLSESPD","SC")
	  //	BD5->BD5_YIMPOR := "1"
		BD5->(MsUnlock())
		
	EndIf
	
Else
	
	If cTipAnt == "03"
		
		BE4->(DbSetOrder(1))
		If BE4->(DbSeek(xFilial("BE4")+BD6->(BD6_CODOPE+BD6_CODLDP+BD6_CODPEG+BD6_NUMERO)))
		 
			BE4->(RecLock("BE4",.F.))
			BE4->BE4_DATPRO := dDatInt
			BE4->BE4_HORPRO := cHorInt
			BE4->BE4_DTALTA := dDatAlt
			BE4->BE4_HRALTA := cHorAlt
			BE4->BE4_TIPALT := IIF(cTipAlt=="8","A",cTipAlt)
		   //	BE4->BE4_YUSIMP := cUserName
			BE4->BE4_PADINT := Posicione("BI4",1,xFilial("BI4")+TRB->TIPACO,"BI4_CODACO")
			BE4->BE4_TIPNAS := cTipNas
		  //	BE4->BE4_YIMPOR := "1"
			BE4->(MsUnlock())
		
		EndIf
		
	Else
		BD5->(DbSetOrder(1))
		If BD5->(DbSeek(xFilial("BD5")+BD6->(BD6_CODOPE+BD6_CODLDP+BD6_CODPEG+BD6_NUMERO)))
			BD5->(RecLock("BD5",.F.))
		   //	BD5->BD5_YUSIMP := cUserName
		  //	BD5->BD5_YIMPOR := "1"
			BD5->(MsUnlock())
		Endif
	Endif
	
EndIf

If cTipAnt == "03"
	BE4->(RecLock("BE4",.F.))
	BE4->BE4_FASE   := "1"
	BE4->BE4_SITUAC := "1"
  //	BE4->BE4_YIMPOR := "1"
	BE4->(MsUnlock())
Else
	BD5->(RecLock("BD5",.F.))
	BD5->BD5_FASE   := "1"
	BD5->BD5_SITUAC := "1"
  //	BD5->BD5_YIMPOR := "1"
	BD5->(MsUnlock())
Endif
	
BCI->(RecLock("BCI",.F.))
BCI->BCI_STATUS := "1"
BCI->BCI_FASE   := "1"
BCI->BCI_SITUAC := "1"
BCI->(MsUnlock())
	
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Fim da funcao                                                       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ Grava_Log³ Autor ³ Ricardo Mansi ³ Data ³ 08/04/05 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Grava arquivo com log de ocorrencias                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ Grava_Log()                                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ nenhum                                                     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function Grava_Log()

Local i := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

Local nTotIte := 0

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Cria arquivo de trabalho para gravar log                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
aStruc := {{"CAMPO","C", 132,0}}
cLOG := CriaTrab(aStruc,.T.)
DbUseArea(.T.,,cLOG,"LOG",.T.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Grava cabecalho                                                       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
LOG->(RecLock("LOG",.T.))
LOG->CAMPO := replicate("=",132)
LOG->(MsUnLock())
LOG->(RecLock("LOG",.T.))
LOG->CAMPO := "Arquivo: " + cNomArq
LOG->(MsUnLock())
LOG->(RecLock("LOG",.T.))
LOG->CAMPO :=  "Competência: "+mv_par02+"/"+mv_par03
LOG->(MsUnLock())
LOG->(RecLock("LOG",.T.))
LOG->CAMPO := "Data: " + dtoc(date()) + "   Hora: " + time() + "   Usuario: " + substr(cUsuario,7,15)
LOG->(MsUnLock())
LOG->(RecLock("LOG",.T.))
LOG->CAMPO := "Rda: " + Alltrim(cNomPres)
LOG->(MsUnLock())
LOG->(RecLock("LOG",.T.))
LOG->CAMPO := replicate("-",132)
LOG->(MsUnLock())

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica se houveram criticas                                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If  len(aLog) > 0
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Grava cabecalho                                                       ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	LOG->(RecLock("LOG",.T.))
	LOG->CAMPO := ""
	LOG->(MsUnLock())
	LOG->(RecLock("LOG",.T.))
	LOG->CAMPO := "=> Log de Criticas"
	LOG->(MsUnLock())
	LOG->(RecLock("LOG",.T.))
	LOG->CAMPO := ""
	LOG->(MsUnLock())
	LOG->(RecLock("LOG",.T.))
	LOG->CAMPO := "Seq     Tipo    Doc.     Usuário              Mensagem"
	LOG->(MsUnLock())
	LOG->(RecLock("LOG",.T.))
	LOG->CAMPO := "------  ------  -------  -------------------  ------------------------------------------------------------------------------------------"
	LOG->(MsUnLock())
	
	ProcRegua(len(aLog),"Gravando Log de Críticas")
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Lista criticas                                                        ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	For i := 1 to len(aLog)
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Movimenta regua                                                     ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		IncProc()
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Grava registro                                                      ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		cSeq      := aLog[i,1] + space(8 - len(aLog[i,1]))
		cCampo    := aLog[i,2] + space(8 - len(aLog[i,2]))
		cDoc      := aLog[i,3] + space(9 - len(aLog[i,3]))
		cConteudo := aLog[i,4] + space(21 - len(aLog[i,4]))
		cMsg      := aLog[i,5]
		LOG->(RecLock("LOG",.T.))
		LOG->CAMPO := cSeq + cCampo + cDoc + cConteudo + cMsg
		LOG->(MsUnLock())
	Next
	LOG->(RecLock("LOG",.T.))
	LOG->CAMPO := ""
	LOG->(MsUnLock())
	LOG->(RecLock("LOG",.T.))
	LOG->CAMPO := "Total de Críticas: " +Alltrim(Str(Len(aLog)))
	LOG->(MsUnLock())
Else
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Grava cabecalho                                                       ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	LOG->(RecLock("LOG",.T.))
	LOG->CAMPO := ""
	LOG->(MsUnLock())
	LOG->(RecLock("LOG",.T.))
	LOG->CAMPO := "=> Nenhuma inconsistência foi encontrada"
	LOG->(MsUnLock())
	LOG->(RecLock("LOG",.T.))
	LOG->CAMPO := ""
	LOG->(MsUnLock())
EndIf

LOG->(RecLock("LOG",.T.))
LOG->CAMPO := replicate("-",132)
LOG->(MsUnLock())

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica se houveram importacoes                                      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If  len(aImp) > 0
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Grava cabecalho                                                       ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	LOG->(RecLock("LOG",.T.))
	LOG->CAMPO := ""
	LOG->(MsUnLock())
	LOG->(RecLock("LOG",.T.))
	LOG->CAMPO := "=> Log de Importação"
	LOG->(MsUnLock())
	LOG->(RecLock("LOG",.T.))
	LOG->CAMPO := ""
	LOG->(MsUnLock())
	LOG->(RecLock("LOG",.T.))
	LOG->CAMPO := "PEG       Guia      Cod Usuario            Nome Usuario                        Qtd Itens"
	LOG->(MsUnLock())
	LOG->(RecLock("LOG",.T.))
	LOG->CAMPO := "--------  --------  ---------------------  ----------------------------------  ---------"
	LOG->(MsUnLock())
	
	ProcRegua(len(aImp),"Gravando Log de Importações")
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Lista importacoes                                                     ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	For i := 1 to len(aImp)
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Movimenta regua                                                     ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		IncProc()
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Grava registro                                                      ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		cCampo := aImp[i,1] + space(2)
		cCampo := aImp[i,2] + "  " + aImp[i,3] + space(2)
		cCampo += transform(aImp[i,4],"@R 9999.9999.999999.99-9") + space(2)
		cCampo += substr(aImp[i,5],1,40) + space(2)
		cCampo += transform(aImp[i,6],"@E 999")
		LOG->(RecLock("LOG",.T.))
		LOG->CAMPO := cCampo
		LOG->(MsUnLock())
		nTotIte += aImp[i,6]
	Next
	LOG->(RecLock("LOG",.T.))
	LOG->CAMPO := Replicate("-",132)
	LOG->(MsUnLock())
	LOG->(RecLock("LOG",.T.))
	LOG->CAMPO := "Resumo do Processo de Importação"
	LOG->(MsUnLock())
	LOG->(RecLock("LOG",.T.))
	LOG->CAMPO := Replicate("-",132)
	LOG->(MsUnLock())
	LOG->(RecLock("LOG",.T.))
	LOG->CAMPO := ""
	LOG->(MsUnLock())
	LOG->(RecLock("LOG",.T.))
	LOG->CAMPO := "Total de Guias Importadas: " +Alltrim(Str(Len(aImp)))
	LOG->(MsUnLock())
	LOG->(RecLock("LOG",.T.))
	LOG->CAMPO := "Total de Itens Importados: " +Alltrim(Str(nTotIte))
	LOG->(MsUnLock())
	LOG->(RecLock("LOG",.T.))
	LOG->CAMPO := ""
	LOG->(MsUnLock())
	LOG->(RecLock("LOG",.T.))
	LOG->CAMPO := "Total de Guias do Arquivo: " +Alltrim(Str(nTotBD5))
	LOG->(MsUnLock())
	LOG->(RecLock("LOG",.T.))
	LOG->CAMPO := "Total de Itens do Arquivo: " +Alltrim(Str(nTotBD6))
	LOG->(MsUnLock())
	LOG->(RecLock("LOG",.T.))
	LOG->CAMPO := ""
	LOG->(MsUnLock())
	LOG->(RecLock("LOG",.T.))
	LOG->CAMPO := "Total de Guias com Erro: " +Alltrim(Str(nGuiErr))
	LOG->(MsUnLock())
	LOG->(RecLock("LOG",.T.))
	LOG->CAMPO := "Total de Itens com Erro: " +Alltrim(Str(nIteErr))
	LOG->(MsUnLock())
Else
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Grava cabecalho                                                       ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	LOG->(RecLock("LOG",.T.))
	LOG->CAMPO := Replicate("-",132)
	LOG->(MsUnLock())
	LOG->(RecLock("LOG",.T.))
	LOG->CAMPO := "Resumo do Processo de Importação"
	LOG->(MsUnLock())
	LOG->(RecLock("LOG",.T.))
	LOG->CAMPO := Replicate("-",132)
	LOG->(MsUnLock())
	LOG->(RecLock("LOG",.T.))
	LOG->CAMPO := ""
	LOG->(MsUnLock())
	LOG->(RecLock("LOG",.T.))
	LOG->CAMPO := "=> Nenhuma guia foi importada"
	LOG->(MsUnLock())
	LOG->(RecLock("LOG",.T.))
	LOG->CAMPO := ""
	LOG->(MsUnLock())
	LOG->(RecLock("LOG",.T.))
	LOG->CAMPO := "Total de Guias do Arquivo: " +Alltrim(Str(nTotBD5))
	LOG->(MsUnLock())
	LOG->(RecLock("LOG",.T.))
	LOG->CAMPO := "Total de Itens do Arquivo: " +Alltrim(Str(nTotBD6))
	LOG->(MsUnLock())
	LOG->(RecLock("LOG",.T.))
	LOG->CAMPO := ""
	LOG->(MsUnLock())
	LOG->(RecLock("LOG",.T.))
	LOG->CAMPO := "Total de Guias com Erro: " +Alltrim(Str(nGuiErr))
	LOG->(MsUnLock())
	LOG->(RecLock("LOG",.T.))
	LOG->CAMPO := "Total de Itens com Erro: " +Alltrim(Str(nIteErr))
	LOG->(MsUnLock())
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Grava rodape                                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
LOG->(RecLock("LOG",.T.))
LOG->CAMPO := replicate("=",132)
LOG->(MsUnLock())

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Gera arquivo texto com o log                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cFile := Alltrim(mv_par06)
cFile += FileNoExt(cNomArq)+".log"
DbSelectArea("LOG")
Copy To &cFile SDF
DbCloseArea("LOG")

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Fim da funcao                                                       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ Imprime_Log ³ Autor ³ Ricardo Mansi ³ Data ³ 08/04/05 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Imprime relatorio de criticas                                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ Imprime_Log()                                                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ nenhum                                                        ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function Imprime_Log()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define variaveis padroes para todos os relatorios...                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Private cNomeProg   := "IMPCTA"
Private nCaracter   := 15
Private cTamanho    := "M"
Private cTitulo     := "Relatório de Ocorrências na Importação de Guias"
Private cDesc1      := "Emite relatório das ocorrências durante o processo de"
Private cDesc2      := "importação do movimento de guias."
Private cDesc3      := ""
Private cCabec1     := "Rda: " + Alltrim(cNomPres) + "  -  Competência: "+mv_par02+"/"+mv_par03+"  -  Arquivo: " + cNomArq
Private cCabec2     := "Seq     Campo  Doc.     Conteudo         Mensagem"
Private cAlias      := "BCI"
Private cPerg       := "IMPCTA"
Private wnRel       := "IMPCTA"
Private Li         	:= 99
Private m_pag       := 1
Private aReturn     := {"Zebrado", 1,"Administracao", 1, 1, 1, "",1 }
Private lAbortPrint := .F.
Private aOrdens     := ""
Private lDicion     := .F.
Private lCompres    := .F.
Private lCrystal    := .F.
Private lFiltro     := .T.

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Chama SetPrint                                                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
wnRel := SetPrint(cAlias,wnRel,"",@cTitulo,cDesc1,cDesc2,cDesc3,lDicion,aOrdens,lCompres,cTamanho,{},lFiltro,lCrystal)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica se foi cancelada a operacao                                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If  nLastKey  == 27
	Return
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Configura impressora                                                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
SetDefault(aReturn,cAlias)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Emite relat¢rio                                                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
RptStatus({|lEnd| Impr_Log() }, "Imprimindo relatório de ocorrências ...", "", .T.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Fim do programa                                                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ Impr_Log ³ Autor ³ Ricardo Mansi ³ Data ³ 08/04/05 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Imprime relatorio de criticas                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ Impr_Log()                                                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ nenhum                                                     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function Impr_Log()

Local i := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS
Local j := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define variaveis...                                                      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local nQtdLin   := 58
Local nColuna   := 00
Local nLimite   := 132
Local nOrdSel   := aReturn[8]
Local nTotIte   := 0
Local cSeq      := ""
Local cCampo    := ""
Local cDoc      := ""
Local cConteudo := ""
Local cMsg      := ""

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Inicializa variaveis                                                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cTitulo := "Relatório de Críticas"
cCabec2 := "Seq.    Tipo    Doc.     Usuário              Mensagem"
Li := 99

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta regua                                                              ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
SetRegua(len(aLog))

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Processa vetor com log de criticas                                       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
For i := 1 to len(aLog)
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifica se foi cancelada a impressao                                 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If  Interrupcao(lAbortPrint)
		Li ++
		@ Li, nColuna pSay OemToAnsi("ABORTADO PELO OPERADOR...")

		Exit
	EndIf
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Movimenta regua                                                       ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	IncRegua()
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Imprime cabecalho                                                 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If  Li > nQtdLin
		Cabec(cTitulo,cCabec1,cCabec2,wnRel,cTamanho,IIF(aReturn[4]==1,GetMv("MV_COMP"),GetMv("MV_NORM")))
	EndIf
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Imprime linha de detalhe                                          ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	cSeq      := aLog[i,1] + space(8 - len(aLog[i,1]))
	cCampo    := aLog[i,2] + space(8 - len(aLog[i,2]))
	cDoc      := aLog[i,3] + space(9 - len(aLog[i,3]))
	cConteudo := aLog[i,4] + space(21 - len(aLog[i,4]))
	cMsg      := aLog[i,5]
	
	@ Li, 00 pSay cSeq + cCampo + cDoc + cConteudo + cMsg
	Li ++
	
Next

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Imprime cabecalho                                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If  Li > nQtdLin
	Cabec(cTitulo,cCabec1,cCabec2,wnRel,cTamanho,IIF(aReturn[4]==1,GetMv("MV_COMP"),GetMv("MV_NORM")))
EndIf

If Len(aLog) > 0
	Li ++
	@ Li, 0 pSay "Total de Críticas: " + alltrim(str(Len(aLog)))
	Li ++
Else
	@ Li, 0 pSay "Nenhuma inconsistência encontrada."
	Li ++
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Inicializa variaveis                                                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Li      := 99
cTitulo := "Relatório de Importação de Guias"
cCabec2 := "Guia     Peg/Guia Gerada    Cod Usuário            Nome Usuário                        Qtd Itens"
_aPeg   := {}
If Len(aImp) > 0
   _cPeg:= aImp[1,2]
EndIf
_nPeg   := 0
_nPos   := 0

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta regua                                                              ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
SetRegua(len(aImp))

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Processa vetor com importacoes                                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
For i := 1 to len(aImp)
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifica se foi cancelada a impressao                                 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If  Interrupcao(lAbortPrint)
		Li ++
		@ Li, nColuna pSay OemToAnsi("ABORTADO PELO OPERADOR...")

		Exit
	EndIf
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Movimenta regua                                                       ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	IncRegua()
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Imprime cabecalho                                                 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If  Li > nQtdLin
		Cabec(cTitulo,cCabec1,cCabec2,wnRel,cTamanho,IIF(aReturn[4]==1,GetMv("MV_COMP"),GetMv("MV_NORM")))
	EndIf

	If (_nPos:= Ascan(_aPeg,{|x| x[1]== aImp[i,2]})) == 0
	   AADD(_aPeg,{aImp[i,2],1,1})
	Else
	   _aPeg[_nPos][2]++
	   _aPeg[_nPos][3]++
	EndIf
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Imprime linha de detalhe                                          ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	@ Li,  0 pSay aImp[i,1]
	@ Li,  9 pSay aImp[i,2] + "/" + aImp[i,3]
	@ Li, 28 pSay transform(aImp[i,4],"@R 9999.9999.999999.99-9")
	@ Li, 51 pSay substr(aImp[i,5],1,40)
	@ Li, 93 pSay transform(aImp[i,6],"@E 999")
	Li ++
	nTotIte += aImp[i,6]
Next

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Imprime cabecalho                                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If  Li > nQtdLin
	Cabec(cTitulo,cCabec1,cCabec2,wnRel,cTamanho,IIF(aReturn[4]==1,GetMv("MV_COMP"),GetMv("MV_NORM")))
EndIf

Li ++
@ Li, 0 pSay replicate("-",132)
Li ++
@ Li, 0 pSay "Resumo do Processo de Importação"
Li ++
@ Li, 0 pSay replicate("-",132)

If Len(aImp) > 0
	Li ++
	@ Li, 0 pSay "Total de Guias Importadas: " + alltrim(str(Len(aImp)))
	Li ++
	@ Li, 0 pSay "Total de Itens Importados: " + alltrim(str(nTotIte))
Else
	Li ++
	@ Li, 0 pSay "Nenhuma guia foi importada."
EndIf

Li ++
Li ++
@ Li, 0 pSay "Total de Guias do Arquivo: " + alltrim(str(nTotBD5))
Li ++
@ Li, 0 pSay "Total de Itens do Arquivo: " + alltrim(str(nTotBD6))
Li ++
Li ++
@ Li, 0 pSay "Total de Guias com Erro: " + alltrim(str(nGuiErr))
Li ++
@ Li, 0 pSay "Total de Itens com Erro: " + alltrim(str(nIteErr))

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Imprime cabecalho                                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If  Li > nQtdLin
	Cabec(cTitulo,cCabec1,cCabec2,wnRel,cTamanho,IIF(aReturn[4]==1,GetMv("MV_COMP"),GetMv("MV_NORM")))
EndIf

If Len(aImp) > 0
	Li ++   
	@ Li, 0 pSay "RESUMO POR PEG "
	Li ++	
	@ Li, 0 pSay "   PEG             Qtd.Guias    Qtd.Itens"
				//  012345678901234567890123456789012345678901234567890
				//  0         1         2         3         4         5
	Li ++	       
	For j:= 1 to Len(_aPeg)
		@ Li, 0 pSay _aPeg[J,1]
		@ Li,25 pSay _aPeg[J,2]
		@ Li,38 pSay _aPeg[J,3]
		_nPeg++
		Li ++   		
	Next
	@ Li, 0 pSay "Total de Peg Importadas: " + alltrim(str(_nPeg))
	Li ++
EndIf


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Libera impressao                                                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If  aReturn[5] == 1
	Set Printer To
	Ourspool(wnRel)
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Fim da funcao                                                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³AjustaSX1 ºAutor  ³ Ricardo Mansiº Data ³ 08/04/05  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Cria / ajusta as perguntas da rotina                       º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function AjustaSX1(cPerg)

Local aHelpPor := {}
Local aHelpEng := {}
Local aHelpSpa := {}
Local aTam

aHelpPor := {}
aAdd( aHelpPor, "Informe a operadora.                    " )
aAdd( aHelpPor, "Utilize F3 para pesquisar.              " )
aAdd( aHelpPor, "                                        " )
aTam := {04,00}
PutSx1(cPerg,"01","Operadora"           ,"","","mv_ch1","C",aTam[1],aTam[2],0,"G","","B89","","","mv_par01","","","","","","","","","","","","","","","","",aHelpPor,{},{})

aHelpPor := {}
aAdd( aHelpPor, "Informe o mês da competência.           " )
aAdd( aHelpPor, "                                        " )
aAdd( aHelpPor, "                                        " )
aTam := {02,00}
PutSx1(cPerg,"02","Mes      "           ,"","","mv_ch2","C",aTam[1],aTam[2],0,"G","","","","","mv_par02","","","","","","","","","","","","","","","","",aHelpPor,{},{})

aHelpPor := {}
aAdd( aHelpPor, "Informe o ano da competência.           " )
aAdd( aHelpPor, "                                        " )
aAdd( aHelpPor, "                                        " )
aTam := {04,00}
PutSx1(cPerg,"03","Ano      "           ,"","","mv_ch3","C",aTam[1],aTam[2],0,"G","","","","","mv_par03","","","","","","","","","","","","","","","","",aHelpPor,{},{})

/*
aHelpPor := {}
aAdd( aHelpPor, "Informe o codigo da Rda.                " )
aAdd( aHelpPor, "Utilize F3 para pesquisar.              " )
aAdd( aHelpPor, "                                        " )
aTam := {06,00}
PutSx1(cPerg,"04","Codigo da Rda"       ,"","","mv_ch4","C",aTam[1],aTam[2],0,"G","","BA0","","","mv_par04","","","","","","","","","","","","","","","","",aHelpPor,{},{})
*/ 

aHelpPor := {}
aAdd( aHelpPor, "Informe o tipo de processamento:        " )
aAdd( aHelpPor, "  -Consistir                            " )
aAdd( aHelpPor, "  -Importar Registro OK                 " )
aAdd( aHelpPor, "  -Importar Arquivo OK                  " )
aTam := {01,00}
PutSx1(cPerg,"05","Processamento"       ,"","","mv_ch5","N",aTam[1],aTam[2],1,"C","","","","","mv_par05","Consistir","","","","Imp Registro OK","","","Imp Arquivo OK","","","","","","","","",aHelpPor,{},{})

aHelpPor := {}
aAdd( aHelpPor, "Informe o diretório para gravação do    " )
aAdd( aHelpPor, "arquivo de Log.                         " )
aAdd( aHelpPor, "                                        " )
aTam := {40,00}
PutSx1(cPerg,"06","Diretório do Arquivo de Log","","","mv_ch6","C",aTam[1],aTam[2],1,"G","","","","","mv_par06","","","","","","","","","","","","","","","","",aHelpPor,{},{})

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³RetNumBd6 ºAutor  ³Ricardo Mansiº Data ³  08/04/05   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Retorna o ultimo numero de guia mais 1.					   º±±
±±º          ³                                                             º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                          º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function GetNumBd6

Local cQuery
Local cRet

cQuery := " SELECT TOP 1 BD6_NUMERO "
cQuery += "      FROM " + RetSqlName("BD6") + " BD6 "
cQuery += "          WHERE BD6.BD6_FILIAL = '" + xFilial("BD6") + "' "
cQuery += "              AND BD6.BD6_CODOPE = '" + cOper4 + "' "
cQuery += "              AND BD6.BD6_CODLDP = '" + cCodLdp + "' "
cQuery += "              AND BD6.BD6_CODPEG = '" + _cPeg + "' "
cQuery += "              AND BD6.D_E_L_E_T_ <> '*' "
cQuery += " ORDER BY BD6_NUMERO DESC "

TCQuery cQuery Alias TmpBd6 New

cRet := val(TmpBd6->BD6_NUMERO)+1

TmpBd6->(dbCloseArea())

Return cRet

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ ProxBD5  ³ Autor ³ Ricardo Mansi ³ Data ³ 08/04/05 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Retorna o proximo numero disponivel                        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ Unimed Tubarao			                                  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ProxBD5(cCodOpe,cCodLdp,cCodPeg)

Local cRet := ""

BD5->(DbSetOrder(1))
BD5->(DbSeek(xFilial("BD5")+cCodOpe+cCodLDP+cCodPeg+"99999999",.T.))
BD5->(DbSkip(-1))

If BD5->(BD5_FILIAL+BD5_CODOPE+BD5_CODLDP+BD5_CODPEG) == (xFilial("BD5")+cCodOpe+cCodLdp+cCodPeg)
	cRet := Strzero(Val(BD5->BD5_NUMERO)+1,8)
Else
	cRet := StrZero(1,8)
Endif

Return cRet

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ ProxSeq  ³ Autor ³ Ricardo Mansi ³ Data ³ 08/04/05 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Retorna o proximo numero disponivel                        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ Unimed Tubarao			                                  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ProxSeq(cCodOpe , cCodLdp, cCodPeg, cNumero, cOriMov)

Local cRet := ""

BD6->(DbSetOrder(1))
BD6->(DbSeek(xFilial("BD6")+cCodOpe+cCodLdp+cCodPeg+cNumero+cOriMov+"999",.T.))
BD6->(DbSkip(-1))

If BD6->(BD6_FILIAL+BD6_CODOPE+BD6_CODLDP+BD6_CODPEG+BD6_NUMERO+BD6_ORIMOV) == (xFilial("BD6")+cCodOpe+cCodLdp+cCodPeg+cNumero+cOriMov)
	cRet := Strzero(Val(BD6->BD6_SEQUEN)+1,3)
Else
	cRet := StrZero(1,3)
Endif

Return cRet

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ ValPerg  ³ Autor ³ Ricardo Mansi ³ Data ³ 08/04/05 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Valida os parametros								          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ Unimed Tubarao			                                  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ValPerg()

Local lRet := .T.

BA0->(DbSetOrder(1))

If ! BA0->(DbSeek(xFilial("BA0")+mv_par01))
	lRet := .F.
Endif

If mv_par02 < "01" .or. mv_par02 > "12"
	lRet := .F.
Endif

If Len(alltrim(mv_par03)) <> 4
	lRet := .F.
Endif

Return lRet

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ VldHosDia³ Autor ³ Ricardo Mansi ³ Data ³ 21/06/05 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Valida procedimento se for hospital dia					  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ Unimed Criciuma	                                  	      ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function VldHosDia()

Local cTabDia := GetNewPar("MV_YPLTBDI","016") // TDE de Diarias
Local nEnt    := 0
Local nSai    := 0
Local nTot    := 0
Local lRet    := .F.

BA8->(DbSetOrder(1))

If TRB->TIPGUI == "I"
	If dDatInt == dDatAlt

		nEnt   := (Val(substr(cHorInt,1,2))*60)
		nEnt   += (Val(substr(cHorInt,3,2)))
		nSai   := (Val(substr(cHorAlt,1,2))*60)
		nSai   += (Val(substr(cHorAlt,3,2)))
		nTot   := ((nSai - nEnt)/60) // Horas Internado

		If nTot <= 6
			If BA8->(DbSeek(xFilial("BA8")+cOper4+cTabDia+cCodPad+TRB->CODPRO))
				lRet := .T.
			Endif
		Endif        

	Endif
Endif

Return lRet

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³PrecisaAut³ Autor ³ Ricardo Mansi ³ Data ³ 16/04/05 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Verifica se procedimento necessita de autorizacao  		  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ Unimed Tubarao		                                      ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function PrecisaAut()

Local cChave  := xFilial("BRV") + cOper4 + BI3->(BI3_CODIGO+BI3_VERSAO)
Local lRet    := .F.
Local aVetTmp := {}
Local nTmp    := 1

BRV->(DbSetOrder(1))
BRV->(DbSeek(cChave))

While BRV->(BRV_FILIAL+BRV_CODPLA+BRV_VERSAO)==cChave .and. ! BRV->(Eof())
	aadd(aVetTmp,BRV->BRV_CODGRU)
	BRV->(DbSkip())
EndDo

For nTmp := 1 to Len(aVetTmp)
	If BG8->(DbSeek(xFilial("BG8")+cOper4+aVetTmp[nTmp]+cCodPad+TRB->CODPRO))
		If BG8->BG8_AUTORI $ "2,3,4,5,6"
			lRet := .T.
		Endif
	Endif
Next

If BR8->(DbSeek(xFilial("BR8")+cCodPad+TRB->CODPRO))
	If BR8->BR8_AUTORI $ "2,3,4,5,6"
		lRet := .T.
	Endif
Endif

Return lRet

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ VldDatPro³ Autor ³ Ricardo Mansi ³ Data ³ 18/04/05 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Validacoes na digitacao de notas							  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ Unimed Tubarao		                              	      ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function VldDatPro(cParam)

Local lRet := .T.

Do Case
	Case cParam == "BD5"
		If (dDataBase - M->BD5_DATPRO) > 365
			MsgAlert("Data de Atendimento Antiga!")
			lRet := .F.
		Else
			If (dDataBase - M->BD5_DATPRO) > 90
				MsgAlert("Data de Atendimento Antiga!")
			Endif
		Endif
	Case cParam == "BE4"
		If (dDataBase - M->BE4_DATPRO) > 365
			MsgAlert("Data de Atendimento Antiga!")
			lRet := .F.
		Else
			If (dDataBase - M->BE4_DATPRO) > 90
				MsgAlert("Data de Atendimento Antiga!")
			Endif
		Endif        
		//Motta 28/06/16 Impedir senha com datas com mais de 90 dias 
		//conforme email Dr Jose Paulo Macedo
		If (M->BE4_DATPRO - dDataBase) > 90
			MsgAlert("Data de Atendimento Futura!")
			lRet := .F.
		Endif
	Case cParam == "QTD"
		If substr(M->BD6_CODPRO,1,8) $ GetNewPar("MV_YCDCOEL","0100010014,0210101012")
		        If M->BD6_QTDPRO/100 > 1
				MsgAlert("Quantidade da consulta inválida!")
			Endif
		Endif
EndCase

Return lRet
	
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ VeBlqUsr ³ Autor ³ Ricardo Mansi 		³ Data ³ 20/04/05 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Verifica se usuario esta bloqueado						  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ Unimed Tubarao		                           	          ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function VeBlqUsr(cCodInt,cCodEmp,cMatric,cTipReg,dDatAte)

Local cNameBCA := RetSQLName("BCA")
Local dDatBlo  := StoD("")
Local cQryBlq  := ""
Local lRet     := .F.

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica se na data o beneficiario estava bloqueado...		          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cQryBlq  := " SELECT BCA_TIPO, BCA_DATA FROM " + cNameBCA
cQryBlq  += " WHERE BCA_MATRIC = '" + cCodInt + cCodEmp + cMatric + "' AND"
cQryBlq  += " BCA_TIPREG = '" + cTipReg + "' AND"
cQryBlq  += " BCA_DATA <= '" + dtos(dDatAte) + "' AND "
cQryBlq  += " BCA_FILIAL = '" + xFilial("BCA") + "' AND "
cQryBlq  += cNameBCA + ".D_E_L_E_T_ <> '*' "
cQryBlq  += " ORDER BY BCA_DATA, R_E_C_N_O_"

PLSQuery(cQryBlq,"BCAQRY")

While ! BCAQRY->(eof())
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Caso a data do (des)bloqueio seja maior que a data final, ignoro.     ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If BCAQRY->BCA_DATA > dDatAte
		BCAQRY->(dbSkip())
		Loop
	Endif
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifica Bloqueio...                                                  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If BCAQRY->BCA_TIPO == "0"
		dDatBlo := BCAQRY->BCA_DATA
	Else
		dDatBlo := StoD("")
	Endif
	
	BCAQRY->(dbSkip())
Enddo

BCAQRY->(DbCloseArea())

If ! Empty(dDatBlo)
	lRet := .T.
Endif

Return lRet
	
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ RdaBloq  ³ Autor ³ Ricardo Mansi ³ Data ³ 20/04/05 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Verifica se rda esta bloqueado							  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ Unimed Tubarao		                           	          ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function RdaBloq(cCodOri,dDatAte)

Local lRet     := .T.
Local aAreaBAU := BAU->(GetArea())

BAU->(DbSetOrder(01))

If BAU->(DbSeek(xFilial("BAU")+cCodOri))
	If Empty(BAU->BAU_DATBLO)
		lRet := .F.
	Else
		If dDatAte < BAU->BAU_DATBLO
			lRet := .F.
		Endif
	Endif
Endif
	
RestArea(aAreaBAU)
		
Return lRet
		
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ VeDatAte ³ Autor ³ Ricardo Mansi ³ Data ³ 20/04/05 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Verifica Data de Atendimento x Inclusao da Rda			  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ Unimed Criciuma	                                 	      ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function VeDatAte(cCodOri,dDatAte)

Local lRet     := .T.
Local aAreaBAU := BAU->(GetArea())

BAU->(DbSetOrder(01))

If BAU->(DbSeek(xFilial("BAU")+cCodOri))
	If dDatAte >= BAU->BAU_DTINCL
		lRet := .F.
	Endif
Endif

RestArea(aAreaBAU)

Return lRet

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ VldMatMed³ Autor ³ Ricardo Mansi ³ Data ³ 25/04/05 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Valida se eh material ou medicamento						  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ Unimed Criciuma		                                      ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function VldMatMed(cCodPad,cCodPro)

Local lRet    := .F.
Local cCodMat := GetNewPar("MV_YPLTBMA","013")
Local cCodMed := GetNewPar("MV_YPLTBME","014")

BA8->(DbSetOrder(1))

//Materiais
If BA8->(DbSeek(xFilial("BR8")+cOper4+cCodMat+cCodPad+cCodPro))
	lRet := .T.
Endif

//Medicamentos
If BA8->(DbSeek(xFilial("BR8")+cOper4+cCodMed+cCodPad+cCodPro))
	lRet := .T.
Endif

Return lRet

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ VldCodPro³ Autor ³ Ricardo Mansi 		³ Data ³ 26/04/05 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Altera procedimento se for hospital dia					  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ Unimed Tubarao		                                 	  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function VldCodPro()

Local cTabDia := GetNewPar("MV_YPLTBDI","016")      // TDE de Diarias
Local cCodPro := GetNewPar("MV_YPLTXOB","80031501") // Taxa de Observacao
Local nEnt    := 0
Local nSai    := 0
Local nTot    := 0
Local lRet    := .T.
Local lAltera := .F.

BA8->(DbSetOrder(1))

If BCI->BCI_TIPGUI == "03"
	If M->BE4_DATPRO == M->BE4_DTALTA

		nEnt   := (Val(substr(M->BE4_HORPRO,1,2))*60)
		nEnt   += (Val(substr(M->BE4_HORPRO,3,2)))
		nSai   := (Val(substr(M->BE4_HRALTA,1,2))*60)
		nSai   += (Val(substr(M->BE4_HRALTA,3,2)))
		nTot   := ((nSai - nEnt)/60) // Horas Internado

		If nTot <= 6
			If BA8->(DbSeek(xFilial("BA8")+BCI->BCI_CODOPE+cTabDia+M->(BD6_CODPAD+BD6_CODPRO)))
				lAltera := .T.
			Endif
		Endif        

	Endif
Endif

If lAltera
	lRet := .F.
	M->BD6_CODPRO := cCodPro
	MsgAlert("Procedimento alterado para Taxa de Observação!")
Endif

Return lRet

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ VldRdaGen| Autor ³ Ricardo Mansi ³ Data ³ 26/04/05 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Faz validacao caso seja Rda Generica	  					  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ Unimed Tubarao		                        	          ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function VldRdaGen()

Local lRet := .T.

If M->BE1_CODRDA == GetNewPar("MV_PLSRDAG","000510")
	lRet := PLSA090RDA(M->BE1_OPERDA,M->BE1_CODRDA,"1",M->BE1_DATPRO,M->BE1_USUARI,"","","BE1")
Endif

Return lRet

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ AltRdaGen| Autor ³ Ricardo Mansi			³ Data ³ 11/05/05 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Altera informacoes qdo for Rda Generica					  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ Unimed Tubarao		                                 	  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function AltRdaGen()

Local cQuery   := ""
Local cNumero  := ""
Local cCodPeg  := ""
Local cCodLdp  := ""
Local cCodOpe  := ""
Local cNomRda  := ""
Local cCodLoc  := ""
Local cLocal   := ""
Local cDesLoc  := ""
Local cEndLoc  := ""
Local cCodEsp  := ""
Local cDesEsp  := ""
Local cChaBCI  := ""
Local cNumGui  := ""
Local cOpeAnt  := ""
Local cLdpAnt  := ""
Local cPegAnt  := ""
Local cGuiAnt  := ""
Local cMovAnt  := ""
Local lTemBCI  := .F.
Local cLdpPad  := "0000" // LDP de Atendimento
Local cNameBEA := RetSQLName("BEA")

BEA->(DbSetOrder(01))
BAU->(DbSetOrder(01))
BB8->(DbSetOrder(01))
BAX->(DbSetOrder(01))
BE2->(DbSetOrder(01))
BD5->(DbSetOrder(01))
BD6->(DbSetOrder(01))
BD7->(DbSetOrder(01))

If cTipAnt <> "03" // Internacao

	If BD5->BD5_CODLDP == cLdpPad // LDP de Atendimento

		If BD5->BD5_CODRDA == GetNewPar("MV_PLSRDAG","000510") // Rda Generica
	
			cCodOpe  := BD5->BD5_CODOPE
			cCodLdp  := BD5->BD5_CODLDP
			cCodPeg  := BD5->BD5_CODPEG
			cNumero  := BD5->BD5_NUMERO
			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Busca Liberacao...													  ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			cQuery := " SELECT TOP 1 BEA_OPEMOV, BEA_ANOAUT, BEA_MESAUT, BEA_NUMAUT FROM " + cNameBEA
			cQuery += " WHERE BEA_NUMGUI = '" + cNumero + "' AND"
			cQuery += " BEA_CODPEG = '" + cCodPeg + "' AND "
			cQuery += " BEA_CODLDP = '" + cCodLdp + "' AND "
			cQuery += " BEA_OPEMOV = '" + cCodOpe + "' AND "
			cQuery += " BEA_FILIAL = '" + xFilial("BEA") + "' AND "
			cQuery += cNameBEA + ".D_E_L_E_T_ <> '*' "
			
			PLSQuery(cQuery,"BEAQRY")
			
			If ! BEAQRY->(Eof())
	
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Alimenta informacoes...		   		      							  ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				BAU->(DbSeek(xFilial("BAU")+cCodRda))
				BB8->(DbSeek(xFilial("BB8")+cCodRda+cOper4))
				BAX->(DbSeek(xFilial("BAX")+cCodRda+cOper4+BB8->BB8_CODLOC))
				
				cOpeAnt  := BD5->BD5_CODOPE
				cLdpAnt  := BD5->BD5_CODLDP
				cPegAnt  := BD5->BD5_CODPEG
				cGuiAnt  := BD5->BD5_NUMERO
				cMovAnt  := BD5->BD5_ORIMOV
				cNomRda := BAU->BAU_NOME
				cCodLoc := BB8->BB8_CODLOC
				cLocal  := BB8->BB8_LOCAL
				cDesLoc := BB8->BB8_DESLOC
				cEndLoc := Alltrim(BB8->BB8_END)+"+"+Alltrim(BB8->BB8_NR_END)+"--"+Alltrim(BB8->BB8_BAIRRO)
				cCodEsp := BAX->BAX_CODESP
				cDesEsp := Posicione("BAQ",1,xFilial("BAQ")+BAX->(BAX_CODINT+BAX_CODESP),"BAQ_DESCRI")
	
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Verifica se deve criar nova PEG...		         					  ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				cChaBCI := cOper4 + cCodRda + cAno + cMes + "2"
				
				BCI->(DbSetOrder(4))
				BCI->(DbSeek(xFilial("BCI")+cChaBCI))
				
				While BCI->(BCI_OPERDA+BCI_CODRDA+BCI_ANO+BCI_MES+BCI_TIPO)==cChaBCI .and. ! BCI->(Eof())
					
					If BCI->BCI_TIPGUI == cTipAnt .and. BCI->BCI_CODLDP == cLdpPad .and. BCI->BCI_SITUAC == "1" .and. BCI->BCI_FASE <= "3"
						lTemBCI := .T.
						Exit
					Endif
					
					BCI->(DbSkip())
				EndDo
				
				If ! lTemBCI
					
					BCI->(RecLock("BCI",.T.))
					BCI->BCI_FILIAL := xFilial("BCI")
					BCI->BCI_CODOPE := cOper4
					BCI->BCI_CODLDP := cLdpPad
					BCI->BCI_CODPEG := PLSA175COD(cOper4,cLdpPad)
					BCI->BCI_OPERDA := cOper4
					BCI->BCI_CODRDA := cCodRda
					BCI->BCI_NOMRDA := cNomRda
					BCI->BCI_MES    := cMes
					BCI->BCI_ANO    := cAno
					BCI->BCI_TIPGUI := cTipAnt
					BCI->BCI_CODCOR := Posicione("BCL",1,xFilial("BCL")+cOper4+cTipAnt,"BCL_CODCOR")
					BCI->BCI_TIPSER := GetNewPar("MV_PLSTPSP","01")
					BCI->BCI_DATREC := dDataBase
					BCI->BCI_DTDIGI := dDataBase
					BCI->BCI_STATUS := "1"
					BCI->BCI_FASE   := "1"
					BCI->BCI_SITUAC := "1"
					BCI->BCI_TIPO   := "2"
					BCI->BCI_QTDEVE := 0
					BCI->BCI_QTDEVD := 0
					BCI->(MsUnlock())
					
				EndIf
				
				cCodPeg := BCI->BCI_CODPEG
				cNumGui := ProxBD5(cOper4,cLdpPad,cCodPeg)
							
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Altera cabecalho da Liberacao...		         					  ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				BEA->(DbSeek(xFilial("BEA")+BEAQRY->(BEA_OPEMOV+BEA_ANOAUT+BEA_MESAUT+BEA_NUMAUT)))
				
				BEA->(RecLock("BEA",.F.))
				BEA->BEA_OPEMOV := cOper4
				BEA->BEA_CODLDP := cLdpPad
				BEA->BEA_CODPEG := cCodPeg
				BEA->BEA_NUMGUI := cNumGui
				BEA->BEA_CODRDA := cCodRda
				BEA->BEA_NOMRDA := cNomRda
				BEA->BEA_CODLOC := cCodLoc
				BEA->BEA_LOCAL  := cLocal
				BEA->BEA_DESLOC := cDesLoc
				BEA->BEA_ENDLOC := cEndLoc
				BEA->BEA_CODESP := cCodEsp
				BEA->BEA_DESESP := cDesEsp
				BEA->(MsUnlock())
				
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Altera itens da Liberacao...		         						  ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				BE2->(DbSeek(xFilial("BE2")+BEA->(BEA_OPEMOV+BEA_ANOAUT+BEA_MESAUT+BEA_NUMAUT)))
	
				While BE2->(BE2_OPEMOV+BE2_ANOAUT+BE2_MESAUT+BE2_NUMAUT) == BEA->(BEA_OPEMOV+BEA_ANOAUT+BEA_MESAUT+BEA_NUMAUT) .and. ! BE2->(Eof())
					
					BE2->(RecLock("BE2",.F.))
					BE2->BE2_OPEMOV := cOper4
					BE2->BE2_CODLDP := cLdpPad
					BE2->BE2_CODPEG := cCodPeg
					BE2->BE2_NUMERO := cNumGui
					BE2->BE2_CODRDA := cCodRda
					BE2->BE2_CODLOC := cCodLoc
					BE2->BE2_LOCAL  := cLocal
					BE2->BE2_CODESP := cCodEsp
					BE2->BE2_ENDLOC := cEndLoc
					BE2->BE2_DESLOC := cDesLoc
					BE2->(MsUnlock())
						
					BE2->(DbSkip())
				EndDo
	
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Altera cabecalho da nota...			         						  ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				BD5->(RecLock("BD5",.F.))
				BD5->BD5_CODOPE := cOper4
				BD5->BD5_CODLDP := cLdpPad
				BD5->BD5_CODPEG := cCodPeg
				BD5->BD5_NUMERO := cNumGui
				BD5->BD5_CODRDA := cCodRda
				BD5->BD5_NOMRDA := cNomRda
				BD5->BD5_TIPRDA := BAU->BAU_TIPPE
				BD5->BD5_DESLOC := cDesLoc
				BD5->BD5_ENDLOC := cEndLoc
				BD5->BD5_CODESP := cCodEsp
				BD5->BD5_CPFRDA := BAU->BAU_CPFCGC
				BD5->BD5_LOCAL  := cLocal
				BD5->BD5_CODLOC := cCodLoc
			  //	BD5->BD5_YIMPOR := "1"
				BD5->(MsUnlock())

				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Altera itens da nota...			         							  ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				BD6->(DbSeek(xFilial("BD6")+cOpeAnt+cLdpAnt+cPegAnt+cGuiAnt+cMovAnt))
	
				While BD6->(BD6_CODOPE+BD6_CODLDP+BD6_CODPEG+BD6_NUMERO+BD6_ORIMOV) == (cOpeAnt+cLdpAnt+cPegAnt+cGuiAnt+cMovAnt) .and. ! BD6->(Eof())
	
					BD6->(RecLock("BD6",.F.))
					BD6->BD6_CODOPE := cOper4
					BD6->BD6_CODLDP := cLdpPad
					BD6->BD6_CODPEG := cCodPeg
					BD6->BD6_NUMERO := cNumGui
					BD6->BD6_LOCAL  := cLocal
					BD6->BD6_CODESP := cCodEsp
					BD6->BD6_CODRDA := cCodRda
					BD6->BD6_CODLOC := cCodLoc
					BD6->BD6_CPFRDA := BAU->BAU_CPFCGC
					BD6->BD6_DESLOC := cDesLoc
					BD6->BD6_ENDLOC := cEndLoc
					BD6->BD6_NOMRDA := cNomRda
					BD6->BD6_TIPRDA := BAU->BAU_TIPPE 
					BD6->(MsUnlock())			            
					
					BD6->(DbSkip())
				EndDo
	
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Altera sub-itens da nota...			         						  ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				BD7->(DbSeek(xFilial("BD7")+cOpeAnt+cLdpAnt+cPegAnt+cGuiAnt+cMovAnt))
	
				While BD7->(BD7_CODOPE+BD7_CODLDP+BD7_CODPEG+BD7_NUMERO+BD7_ORIMOV) == (cOpeAnt+cLdpAnt+cPegAnt+cGuiAnt+cMovAnt) .and. ! BD7->(Eof())
	
					BD7->(RecLock("BD7",.F.))
					BD7->BD7_CODOPE := cOper4
					BD7->BD7_CODLDP := cLdpPad
					BD7->BD7_CODPEG := cCodPeg
					BD7->BD7_NUMERO := cNumGui
					BD7->BD7_CODRDA := cCodRda
					BD7->BD7_NOMRDA := cNomRda
					BD7->BD7_CODESP := cCodEsp
					BD7->BD7_DESESP := cDesEsp
					BD7->(MsUnlock())			            
					
					BD7->(DbSkip())
				EndDo
				
			EndIf
			
			BEAQRY->(DbCloseArea())
			
		Endif
	Endif
Endif		

Return