#INCLUDE "FINA200.CH"            
#include "fileio.ch"
#Include "PROTHEUS.CH"

Static __nExeProc  := 0
Static lFWCodFil := FindFunction("FWCodFil")


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABT200   ºAutor  ³Marcela Coimbra     º Data ³  30/03/10   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Adaptação da rotina de retorno de cnab pra tratar retorno  º±±
±±º          ³ de títulos antigos e novos.                                º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CABERJ                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/




// 17/08/2009 - Compilacao para o campo filial de 4 posicoes
// 18/08/2009 - Compilacao para o campo filial de 4 posicoes


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ FinA200  ³ Autor ³ Wagner Xavier         ³ Data ³ 26/05/92 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Retorno da comunica‡„o banc ria                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ FinA200()                                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³			ATUALIZACOES SOFRIDAS                              			  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Claudio   	³13/07/00³xxxxxx³ Retirar todas as chamadas a WriteSx2    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function CABT200(nPosArotina)
Local lPanelFin := If (FindFunction("IsPanelFin"),IsPanelFin(),.F.)
Local lPergunte := .F.

Private cPerg	:= "AFI200"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Realiza ajustes no grupo de perguntas ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
AjustaSX1(cPerg)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas selecionadas    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If lPanelFin
	lPergunte := PergInPanel(cPerg,.T.)
Else
   lPergunte := pergunte(cPerg,.T.)
Endif

If !lPergunte
	Return
Endif	
MV_PAR04 := UPPER(MV_PAR04)

PRIVATE cLotefin := Space(TamSX3("EE_LOTE")[1]),nTotAbat := 0,cConta := " "
PRIVATE nHdlBco:= 0,nHdlConf := 0,nSeq := 0 ,cMotBx := "NOR"
PRIVATE nValEstrang := 0
PRIVATE cMarca := GetMark()
PRIVATE aRotina := MenuDef()
PRIVATE VALOR  := 0
PRIVATE nHdlPrv := 0
PRIVATE nOtrGa	:= 0
PRIVATE nTotAGer:=0
PRIVATE ABATIMENTO := 0
Private lOracle	:= "ORACLE"$Upper(TCGetDB())

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define o cabecalho da tela de baixas ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
PRIVATE cCadastro := OemToAnsi("Comunica‡„o Banc ria-Retorno" )  //"Comunica‡„o Banc ria-Retorno" 

public dxDataCred  // Adicionado por Luiz Otavio para identificar o arquivo retorno do Banco do Brasil 

DEFAULT nPosArotina := 0

If nPosArotina > 0
	dbSelectArea('SE1')
	bBlock := &( "{ |a,b,c,d,e| " + aRotina[ nPosArotina,2 ] + "(a,b,c,d,e) }" )
	Eval( bBlock, Alias(), (Alias())->(Recno()),nPosArotina)
Else
	mBrowse( 6, 1,22,75,"SE1")
Endif	

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Fecha os Arquivos ASCII ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
FCLOSE(nHdlBco)
FCLOSE(nHdlConf)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ fA200Ger ³ Autor ³ Wagner Xavier         ³ Data ³ 26/05/92 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Comunicacao Bancaria - Retorno                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ fA200Ger()                   	                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ FinA200                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function fa200gera(cAlias)
__nExeProc++
// Como esta rotina eh chamada duas vezes pela mBrowse, controlar
// as chamadas para nao ocorrer duplo processamento
If (__nExeProc%2)==0
	Return .T.
Endif  

//If upper(ALLTRIM( mv_par05 )) <> "112175.2RR"             
      
//	Processa({|lEnd| fa200Ger(cAlias)})  // Chamada com regua
                                                         
//Else

	Processa({|lEnd| ffa200Ger(cAlias)})  // Chamada com regua
                      
//EndIf

Return .T.

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ fA200Gera³ Autor ³ Wagner Xavier         ³ Data ³ 26/05/92 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Comunicacao Bancaria - Retorno                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ fA200Ger()                                                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ FinA200                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function ffA200Ger(cAlias)
Local cPosNum,cPosData,cPosDesp,cPosDesc,cPosAbat,cPosPrin,cPosJuro,cPosMult
Local cPosOcor,cPosTipo,cPosCC,cPosDtCC,cPosMot
Local lPosNum  :=.f.,lPosData:=.f.,lPosMot  :=.f.
Local lPosDesp :=.f.,lPosDesc:=.f.,lPosAbat :=.f.
Local lPosPrin :=.f.,lPosJuro:=.f.,lPosMult :=.f.
Local lPosOcor :=.f.,lPosTipo:=.f.,lPosOutrD:= .F.
Local lPosCC   :=.f.,lPosDtCC:=.f.,lPosNsNum:=.f.
Local nLidos,nLenNum,nLenData,nLenDesp,nLenDesc,nLenAbat,nLenMot, nTamDet
Local nLenPrin,nLenJuro,nLenMult,nLenOcor,nLenTipo,nLenCC,nLenDtCC
Local cArqConf,cArqEnt,xBuffer
Local lDesconto,lContabiliza
Local cData
Local cPosNsNum , nLenNsNum , cPosOutrD, nLenOutrD
Local lUmHelp 	:= .F.
Local cTabela 	:= "17"
Local lPadrao 	:= .f.
Local lBaixou 	:= .f.
Local nSavRecno:= Recno()
Local nPos
Local aTabela 	:= {}
Local lRecicl	:= GetMv("MV_RECICL")
Local lNaoExiste:= .f.
Local cIndex	:= " "
LOCAL lFina200 := ExistBlock("FINA200" ) 
LOCAL l200Pos  := ExistBlock("FA200POS" ) 
LOCAL lT200Pos := ExistTemplate("FA200POS" ) 
LOCAL lFa200Fil:= ExistBlock("FA200FIL") 
LOCAL lFa200F1 := ExistBlock("FA200F1" ) 
LOCAL lF200Tit := ExistBlock("F200TIT" ) 
LOCAL lF200Fim := ExistBlock("F200FIM" ) 
LOCAL lTF200Fim := ExistTemplate("F200FIM" ) 
LOCAL lF200Var := ExistBlock("F200VAR" ) 
LOCAL lF200Avl := ExistBlock("F200AVL" ) 
LOCAL l200Fil  := .F.
LOCAL lFirst	:= .F.
//Local cMotBan	:= Space(10)				// motivo da ocorrencia no banco
Local nCont, cMotivo, lSai := .f.
Local aLeitura := {}
Local lFa200_02 := ExistBlock("FA200_02")
Local aValores := {}
LOCAL lBxCnab  := GetMv("MV_BXCNAB") == "S"
LOCAL cNomeArq
LOCAL aCampos  := {}
Local lAchouTit:= .F.
Local nX := 0
Local nRegSE5 := 0
Local lPosDtVc := .F.
Local nLenDtVc
Local cPosDtVc
Local lF200ABAT := ExistBlock("F200ABAT")
Local lFI0InDic := AliasInDic("FI0")
Local nLastLn	 := 0
Local nUltLinProc := 1
Local lReproc := .T.
Local cTrailler
Local cIdArq	
Local nRegEmp	:= SM0->(Recno())
Local lF200PORT := ExistBlock("F200PORT")
Local lAltPort := .T.
Local nTotAbImp := 0
Local cFilOrig  := cFilAnt	// Salva a filial para garantir que nao seja alterada em customizacao
Local lNewIndice := FaVerInd()  //Verifica a existencia dos indices de IDCNAB sem filial
Local nTamPre	:= TamSX3("E1_PREFIXO")[1]
Local nTamNum	:= TamSX3("E1_NUM")[1] 
Local nTamPar	:= TamSX3("E1_PARCELA")[1]
Local nTamTit	:= nTamPre+nTamNum+nTamPar
Local aArqConf	:= {}		// Atributos do arquivo de configuracao
Local lCtbExcl	:= !Empty( xFilial("CT2") )
Local lProcessa := .T.

Private cMotBan	:= Space(10) // motivo da ocorrencia no banco //Adicionado por Luiz Otavio p/ gravar no F200TIT em 22/12/2021
Private cOcorr

If ExistBlock("F200CNAB")
	lBxCnab:=ExecBlock("F200CNAB",.F.,.F.,{lBxCnab,cAlias})
EndIf	

nHdlBco   	:= 0
nHdlConf   	:= 0
nSeq       	:= 0 
cMotBx     	:= "NOR"
nTotAGer   	:= 0
nTotDesp   	:= 0 // Total de Despesas para uso com MV_BXCNAB
nTotOutD   	:= 0 // Total de outras despesas para uso com MV_BXCNAB
nTotValCC   := 0 // Total de outros creditos para uso com MV_BXCNAB
nValEstrang := 0
VALOR    	:= 0
nHdlPrv  	:= 0
ABATIMENTO  := 0

Private cBanco
Private cAgencia
Private cConta
Private cHist070
Private lAut:=.f.,nTotAbat := 0
Private cArquivo
Private dDataCred
Private lCabec := .f.
Private cPadrao
Private nTotal := 0
Private cModSpb := "1"  // Informado apenas para nao dar problemas nas rotinas de baixa
Private nAcresc
Private nDecresc
Private aFlagCTB		:= {}
Private lUsaFlag		:= SuperGetMV( "MV_CTBFLAG" , .T. /*lHelp*/, .F. /*cPadrao*/)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Deleta Chave Unica do Arquivo Log de Detalhes do CNAB        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
AjustaSX2()

// Se existir o arquivo de LOG, forca sua abertura antes do inicio da transacao
If lFI0InDic
	DbSelectArea("FI0")
	DbSelectArea("FI1")
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Posiciona no Banco indicado                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cBanco  := mv_par06
cAgencia:= mv_par07
cConta  := mv_par08
cSubCta := mv_par09
lDigita := IIF(mv_par01==1,.T.,.F.)
lAglut  := IIF(mv_par02==1,.T.,.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica se existe inidce IDCNAB para multiplas filiais ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If mv_par13 == 2

	If !lNewIndice                                                                 
	        
		// Não foi encontrado o índice por IDCNAB sem Filial. ### Executar o compatibizador do ambiente Financeiro (U_UPDFIN).
		PutHelp( "PNOIDCNAB",	{"Não foi encontrado o índice por IDCNAB", "sem Filial."},;
								{"The index IDCNAB without Branch not found." },;
								{"No encontro el indice por IDCNAB sin", "Sucursal."} )
								
		PutHelp( "SNOIDCNAB",	{"Executar o compatibizador do ambiente", "Financeiro (U_UPDFIN)."},;
								{"Run the compatibility Financial ", "(U_UPDFIN)." },;
								{"Ejecutar el compatibilizador del entorno", "Financeiro (U_UPDFIN)."} )
	
		Help( "  ", 1, "NOIDCNAB" )
	
		Return .F.
	
	Else

		If lCtbExcl
			c_STR0015:= "A Contabilidade está em modo exclusivo e foi solicitado o processamento de todas as filiais."
			c_STR0012:= "Neste caso, o sistema não realiza a contabilização on-line. Confirma mesmo assim?"
			
			If ! MsgYesNo( c_STR0015, c_STR0012 )
				Return .F.
			EndIf	
		EndIf	

	EndIf	

EndIf

dbSelectArea("SA6")
DbSetOrder(1)
SA6->( dbSeek(xFilial("SA6")+cBanco+cAgencia+cConta) )

dbSelectArea("SEE")
DbSetOrder(1)
SEE->( dbSeek(xFilial("SEE")+cBanco+cAgencia+cConta+cSubCta) )
If !SEE->( found() )
	Help(" ",1,"PAR150")
	Return .F.
Endif

If lBxCnab // Baixar arquivo recebidos pelo CNAB aglutinando os valores
	If Empty(SEE->EE_LOTE)
		cLoteFin := StrZero( 1, TamSX3("EE_LOTE")[1] )
	Else
		cLoteFin := If (FindFunction("FinSomaLote"),FinSomaLote(SEE->EE_LOTE),Soma1(SEE->EE_LOTE))
	EndIf
EndIf
nTamDet := Iif( Empty (SEE->EE_NRBYTES), 400 , SEE->EE_NRBYTES )
nTamDet+=2  // ajusta tamanho do detalhe para ler o CR+LF
cTabela := Iif( Empty(SEE->EE_TABELA), "17" , SEE->EE_TABELA )
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica se a tabela existe           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea( "SX5" )
If !SX5->( dbSeek( cFilial + cTabela ) )
	Help(" ",1,"PAR150")
   Return .F.
Endif

//Altero banco da baixa pelo portador ?
If lF200PORT
	lAltPort := ExecBlock("F200PORT",.F.,.F.)
Endif

While !SX5->(Eof()) .and. SX5->X5_TABELA == cTabela
	AADD(aTabela,{Alltrim(X5Descri()),AllTrim(SX5->X5_CHAVE)})
	SX5->(dbSkip( ))
Enddo

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica o numero do Lote                                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
PRIVATE cLote
dbSelectArea("SX5")
dbSeek(cFilial+"09FIN")
cLote := Substr(X5Descri(),1,4)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica se ‚ um EXECBLOCK e caso sendo, executa-o							³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If At(UPPER("EXEC"),X5Descri()) > 0
	cLote := &(X5Descri())
Endif

If ( MV_PAR12 == 1 )
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Abre arquivo de configuracao ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	cArqConf:=mv_par05
	IF !FILE(cArqConf)
		Help(" ",1,"NOARQPAR")
		Return .F.
	Else
		nHdlConf:=FOPEN(cArqConf,0+64)
	EndIF

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Lˆ arquivo de configuracao ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	nLidos:=0
	FSEEK(nHdlConf,0,0)
	nTamArq:=FSEEK(nHdlConf,0,2)
	FSEEK(nHdlConf,0,0)

	While nLidos <= nTamArq
    
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Verifica o tipo de qual registro foi lido ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		xBuffer:=Space(85)
		FREAD(nHdlConf,@xBuffer,85)
		IF SubStr(xBuffer,1,1) == CHR(1)
			nLidos+=85
			Loop
		EndIF
		IF SubStr(xBuffer,1,1) == CHR(3)
			nLidos+=85
			Exit
		EndIF

		IF !lPosNum
			cPosNum:=Substr(xBuffer,17,10)
			nLenNum:=1+Int(Val(Substr(xBuffer,20,3)))-Int(Val(Substr(xBuffer,17,3)))
			lPosNum:=.t.
			nLidos+=85
			Loop
		EndIF
		IF !lPosData
			cPosData:=Substr(xBuffer,17,10)
			nLenData:=1+Int(Val(Substr(xBuffer,20,3)))-Int(Val(Substr(xBuffer,17,3)))
			lPosData:=.t.
			nLidos+=85
			Loop
		End
		IF !lPosDesp
			cPosDesp:=Substr(xBuffer,17,10)
			nLenDesp:=1+Int(Val(Substr(xBuffer,20,3)))-Int(Val(Substr(xBuffer,17,3)))
			lPosDesp:=.t.
			nLidos+=85
			Loop
		End
		IF !lPosDesc
			cPosDesc:=Substr(xBuffer,17,10)
			nLenDesc:=1+Int(Val(Substr(xBuffer,20,3)))-Int(Val(Substr(xBuffer,17,3)))
			lPosDesc:=.t.
			nLidos+=85
			Loop
		End
		IF !lPosAbat
			cPosAbat:=Substr(xBuffer,17,10)
			nLenAbat:=1+Int(Val(Substr(xBuffer,20,3)))-Int(Val(Substr(xBuffer,17,3)))
			lPosAbat:=.t.
			nLidos+=85
			Loop
		EndIF
		IF !lPosPrin
			cPosPrin:=Substr(xBuffer,17,10)
			nLenPrin:=1+Int(Val(Substr(xBuffer,20,3)))-Int(Val(Substr(xBuffer,17,3)))
			lPosPrin:=.t.
			nLidos+=85
			Loop
		EndIF
		IF !lPosJuro
			cPosJuro:=Substr(xBuffer,17,10)
			nLenJuro:=1+Int(Val(Substr(xBuffer,20,3)))-Int(Val(Substr(xBuffer,17,3)))
			lPosJuro:=.t.
			nLidos+=85
			Loop
		EndIF
		IF !lPosMult
			cPosMult:=Substr(xBuffer,17,10)
			nLenMult:=1+Int(Val(Substr(xBuffer,20,3)))-Int(Val(Substr(xBuffer,17,3)))
			lPosMult:=.t.
			nLidos+=85
			Loop
		EndIF
		IF !lPosOcor
			cPosOcor:=Substr(xBuffer,17,10)
			nLenOcor:=1+Int(Val(Substr(xBuffer,20,3)))-Int(Val(Substr(xBuffer,17,3)))
			lPosOcor:=.t.
			nLidos+=85
			Loop
		EndIF
		IF !lPosTipo
			cPosTipo:=Substr(xBuffer,17,10)
			nLenTipo:=1+Int(Val(Substr(xBuffer,20,3)))-Int(Val(Substr(xBuffer,17,3)))
			lPosTipo:=.t.
			nLidos+=85
			Loop
		EndIF
		IF !lPosOutrD
			cPosOutrD:=Substr(xBuffer,17,10)
			nLenOutrD:=1+Int(Val(Substr(xBuffer,20,3)))-Int(Val(Substr(xBuffer,17,3)))
			lPosOutrD:=.t.
			nLidos+=85
			Loop
		EndIF	
		IF !lPosCC
			cPosCC:=Substr(xBuffer,17,10)
			nLenCC:=1+Int(Val(Substr(xBuffer,20,3)))-Int(Val(Substr(xBuffer,17,3)))
			lPosCC:=.t.
			nLidos+=85
			Loop
		EndIF
		IF !lPosDtCc
			cPosDtCc:=Substr(xBuffer,17,10)
			nLenDtCc:=1+Int(Val(Substr(xBuffer,20,3)))-Int(Val(Substr(xBuffer,17,3)))
			lPosDtCc:=.t.
			nLidos+=85
			Loop
		EndIF
		IF !lPosNsNum
			cPosNsNum := Substr(xBuffer,17,10)
			nLenNsNum := 1+Int(Val(Substr(xBuffer,20,3)))-Int(Val(Substr(xBuffer,17,3)))
			lPosNsNum := .t.
			nLidos += 85
			Loop
		EndIF
		IF !lPosMot									// codigo do motivo da ocorrencia
			cPosMot:=Substr(xBuffer,17,10)
			nLenMot:=1+Int(Val(Substr(xBuffer,20,3)))-Int(Val(Substr(xBuffer,17,3)))
			lPosMot:=.t.
			nLidos+=85
			Loop
		EndIF
		If !lPosDtVc
			cPosDtVc:=Substr(xBuffer,17,10)
			nLenDtVc:=1+Int(Val(Substr(xBuffer,20,3)))-Int(Val(Substr(xBuffer,17,3)))
			lPosDtVc:=.t.
			nLidos+=85
			Loop
		Endif
	EndDo

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ fecha arquivo de configuracao ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	Fclose(nHdlConf)
EndIf
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Abre arquivo enviado pelo banco ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cArqEnt:=mv_par04
IF !FILE(cArqEnt)
	Help(" ",1,"NOARQENT")
	Return .F.
Else
	nHdlBco:=FOPEN(cArqEnt,0+64)
EndIF

If lRecicl
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Filtra o arquivo por E1_NUMBCO - caso exista reciclagem      ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	dbSelectArea("SE1")
	cIndex	:= CriaTrab(nil,.f.)
	cChave	:= IndexKey()
	IndRegua("SE1",cIndex,"E1_FILIAL+E1_NUMBCO",,Fa200ChecF(),OemToAnsi("Selecionando Registros..."))  //"Selecionando Registros..."
	nIndex := RetIndex("SE1")
	dbSelectArea("SE1")
	#IFNDEF TOP
		dbSetIndex(cIndex+OrdBagExt())
	#ENDIF
	dbSetOrder(nIndex+1)
    
	dbGoTop()
	IF BOF() .and. EOF()
		Help(" ",1,"RECNO")
		Return
	EndIf
EndIf

// Se nao tiver o arquivo de LOG no dicionario, verifica se o arquivo ja foi processado anteriormente
If ! lFI0InDic     
	If !(Chk200File())
		Return .F.
	Endif	
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Chama a SumAbatRec antes do Controle de transa‡Æo para abrir o alias ³
//³ auxiliar __SE1																		 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
SumAbatRec( "", "", "", 1, "")

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Gera arquivo de Trabalho                                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
AADD(aCampos,{"FILMOV","C",IIf( lFWCodFil, FWGETTAMFILIAL, 2 ),0})
AADD(aCampos,{"DATAC","D",08,0})
AADD(aCampos,{"TOTAL","N",17,2})

cNomeArq:=CriaTrab(aCampos)
dbUseArea( .T., __cRDDNTTS, cNomeArq, "TRB", if(.F. .Or. .F., !.F., NIL), .F. )
IndRegua("TRB",cNomeArq,"FILMOV+Dtos(DATAC)",,,"")

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Lˆ arquivo enviado pelo banco ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
nLidos:=0
FSEEK(nHdlBco,0,0)
nTamArq:=FSEEK(nHdlBco,0,2)
FSEEK(nHdlBco,0,0)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Desenha o cursor e o salva para poder moviment -lo ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
ProcRegua( nTamArq/nTamDet , 24 )

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Carrega atributos do arquivo de configuracao                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
aArqConf := Directory(MV_PAR05)

lFirst := .F.
nTotAger := 0
nCtDesp := 0
nCtOutCrd := 0 

// Se existir o arquivo de LOG, grava as informacoes pertinentes, referente ao cabecalho do arquivo
// Para futuro reprocessamento se preciso for.
If lFI0InDic
	cTrailler := LeTrailler(nHdlBco) // Obtem o Trailler do Arquivo para gerar o CheckSum
	cIdArq	 := Str(MsCrc32(cTrailler),10) 
	lReproc	 := Fa200GrvLog(1, cArqEnt, cBanco, cAgencia, cConta, @nUltLinProc,,,,cIdArq)
Endif

Begin Transaction

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿               	
//³ Inicializa a gravacao dos lancamentos do SIGAPCO          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
PcoIniLan("000004")
While lReproc .And. nLidos <= nTamArq
	IncProc()
	nLastLn ++
	// Se tiver o arquivo de LOG, avanca ate a proxima linha, apos a ultima processada

	lFI0InDic := .f.  
	
	If lFI0InDic 
		If nLastLn < nUltLinProc
			// Avanca uma linha do arquivo retorno
			nLidos+=nTamDet
			fReadLn(nHdlBco,,(nTamDet)) // Posiciona proxima linha
			Loop
		Endif
		// Grava a ultima linha lida do arquivo
		FI0->(RecLock("FI0"))
		FI0->FI0_LASTLN	:= nLastLn
		MsUnlock()
	Endif	
	
	nDespes :=0
	nDescont:=0
	nAbatim :=0
	nValRec :=0
	nJuros  :=0
	nMulta  :=0
	nValCc  :=0
	nCM     :=0
	nOutrDesp :=0   

	// Template GEM
	nCm1     := 0
	nProRata := 0

	cFilAnt := cFilOrig					// sempre restaura a filial original   
	
	If ( MV_PAR12 == 1 )
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Tipo qual registro foi lido ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		xBuffer:=Space(nTamDet)
		FREAD(nHdlBco,@xBuffer,nTamDet)    
    
		IF SubStr(xBuffer,1,1) $ "0#A"
			nLidos+=nTamDet
			Loop
		EndIF
		IF SubStr(xBuffer,1,1) $ "1#F#J#7#2"
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Lˆ os valores do arquivo Retorno ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			
			cNumTit :=Substr(xBuffer,Int(Val(Substr(cPosNum, 1,3))),15 )

			dbSelectArea("SE1")
            dbSetOrder(1)
            If !dbSeek(xFilial("SE1") + cNumTit ) 
            	
            	c_Prefixo := substr( cNumTit, 1,3)
            	c_Num 	  := substr( cNumTit, 4,6) + space(3)
            	c_Tipo    := substr( cNumTit, 7,3)
            	cNumTit   := c_Prefixo + c_Num + c_Tipo
            
            EndIf
			
			cData   :=Substr(xBuffer,Int(Val(Substr(cPosData,1,3))),nLenData)
			cData   :=ChangDate(cData,SEE->EE_TIPODAT)
			dBaixa  :=Ctod(Substr(cData,1,2)+"/"+Substr(cData,3,2)+"/"+Substr(cData,5,2),"ddmmyy")
			cTipo   :=Substr(xBuffer,Int(Val(Substr(cPosTipo, 1,3))),nLenTipo )
			cTipo   := Iif(Empty(cTipo),"NF ",cTipo)		// Bradesco
			cNsNum  := " "
			cEspecie:= "   "
			dDataCred := Ctod("//")
			dDtVc := Ctod("//")
			IF !Empty(cPosDesp)
				nDespes:=Round(Val(Substr(xBuffer,Int(Val(Substr(cPosDesp,1,3))),nLenDesp))/100,2)
			EndIF
			IF !Empty(cPosDesc)
				nDescont:=Round(Val(Substr(xBuffer,Int(Val(Substr(cPosDesc,1,3))),nLenDesc))/100,2)
			EndIF
			IF !Empty(cPosAbat)
				nAbatim:=Round(Val(Substr(xBuffer,Int(Val(Substr(cPosAbat,1,3))),nLenAbat))/100,2)
			EndIF
			IF !Empty(cPosPrin)
				nValRec :=Round(Val(Substr(xBuffer,Int(Val(Substr(cPosPrin,1,3))),nLenPrin))/100,2)
			EndIF
			IF !Empty(cPosJuro)
				nJuros  :=Round(Val(Substr(xBuffer,Int(Val(Substr(cPosJuro,1,3))),nLenJuro))/100,2)
			EndIF
			IF !Empty(cPosMult)
				nMulta  :=Round(Val(Substr(xBuffer,Int(Val(Substr(cPosMult,1,3))),nLenMult))/100,2)
			EndIF
			IF !Empty(cPosOutrd)
				nOutrDesp  :=Round(Val(Substr(xBuffer,Int(Val(Substr(cPosOutrd,1,3))),nLenOutrd))/100,2)
			EndIF
			IF !Empty(cPosCc)
				nValCc :=Round(Val(Substr(xBuffer,Int(Val(Substr(cPosCc,1,3))),nLenCc))/100,2)
			EndIF
			IF !Empty(cPosDtCc)
				cData  :=Substr(xBuffer,Int(Val(Substr(cPosDtCc,1,3))),nLenDtCc)
				cData    := ChangDate(cData,SEE->EE_TIPODAT)
				dDataCred:=Ctod(Substr(cData,1,2)+"/"+Substr(cData,3,2)+"/"+Substr(cData,5,2),"ddmmyy")
				dDataUser:=dDataCred
			End
			IF !Empty(cPosNsNum)
				cNsNum  :=Substr(xBuffer,Int(Val(Substr(cPosNsNum,1,3))),nLenNsNum)
			End
			If nLenOcor == 2
				cOcorr  :=Substr(xBuffer,Int(Val(Substr(cPosOcor,1,3))),nLenOcor) + " "
			Else
				cOcorr  :=Substr(xBuffer,Int(Val(Substr(cPosOcor,1,3))),nLenOcor)
			EndIf	
			If !Empty(cPosMot)
				cMotBan:=Substr(xBuffer,Int(Val(Substr(cPosMot,1,3))),nLenMot)
			EndIf
			IF !Empty(cPosDtVc)
				cDtVc :=Substr(xBuffer,Int(Val(Substr(cPosDtVc,1,3))),nLenDtVc)
				cDtVc := ChangDate(cDtVc,SEE->EE_TIPODAT)
				dDtVc :=Ctod(Substr(cDtVc,1,2)+"/"+Substr(cDtVc,3,2)+"/"+Substr(cDtVc,5,2),"ddmmyy")
			EndIf


			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ o array aValores ir  permitir ³
			//³ que qualquer exce‡„o ou neces-³
			//³ sidade seja tratado no ponto  ³
			//³ de entrada em PARAMIXB        ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			// Estrutura de aValores
			//	Numero do T¡tulo	- 01
			//	data da Baixa		- 02
			// Tipo do T¡tulo		- 03
			// Nosso Numero		- 04
			// Valor da Despesa	- 05
			// Valor do Desconto	- 06
			// Valor do Abatiment- 07
			// Valor Recebido    - 08
			// Juros					- 09
			// Multa					- 10
			// Outras Despesas	- 11
			// Valor do Credito	- 12
			// Data Credito		- 13
			// Ocorrencia			- 14
			// Motivo da Baixa 	- 15
			// Linha Inteira		- 16
			// Data de Vencto	   - 17
			
			aValores := ( { cNumTit, dBaixa, cTipo, cNsNum, nDespes, nDescont, nAbatim, nValRec, nJuros, nMulta, nOutrDesp, nValCc, dDataCred, cOcorr, cMotBan, xBuffer,dDtVc,{} })
         
			If ExistBlock("200GEMBX")
				ExecBlock("200GEMBX", .F., .F., {aValores}) 
			EndIf
			
			// Template GEM
			If lF200Var
				ExecBlock("F200VAR",.F.,.F.,{aValores})
			ElseIf ExistTemplate("GEMBaixa")
				ExecTemplate("GEMBaixa",.F.,.F.,)
			Endif

			If Empty(cNumTit)
				nLidos += nTamDet
				Loop
			EndIf

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Verifica especie do titulo    ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			nPos := Ascan(aTabela, {|aVal|aVal[1] == Substr(cTipo,1,2)})
			If nPos != 0
				cEspecie := aTabela[nPos][2]
			Else
				cEspecie	:= "  "
			EndIf								
			If cEspecie $ MVABATIM			// Nao lˆ titulo de abatimento
				nLidos += nTamDet
				Loop
			Endif
		Else
			nLidos += nTamDet
			Loop
	Endif
	Else
		aLeitura := ReadCnab2(nHdlBco,MV_PAR05,nTamDet,aArqConf)
		cNumTit  := SubStr(aLeitura[1],1,nTamTit)
		
		cData    := aLeitura[04]
		cData    := ChangDate(cData,SEE->EE_TIPODAT)
		dBaixa   := Ctod(Substr(cData,1,2)+"/"+Substr(cData,3,2)+"/"+Substr(cData,5,2),"ddmmyy")
		cTipo    := aLeitura[02]
		cTipo    := Iif(Empty(cTipo),"NF ",cTipo)		// Bradesco
		cNsNum   := aLeitura[11]

		dbSelectArea("SE1")
        dbSetOrder(1)
        If !dbSeek(xFilial("SE1") + cNsNum )    //chave para 6 
            
            dbSetOrder(1)                  
            If dbSeek(xFilial("SE1") + cNumTit )
            	
         	c_Prefixo 	:= SE1->E1_PREFIXO
           	c_Num 	  	:= SE1->E1_NUM
           	c_Tipo    	:= SE1->E1_TIPO
            cNsNum   	:= c_Prefixo + c_Num + c_Tipo
		    cTipo 		:= c_Tipo
		    
		    Else
         	
	         	c_Prefixo 	:= substr( cNsNum, 1,3)
	           	c_Num 	  	:= substr( cNsNum, 4,6) + space(3)
	           	c_Tipo    	:= substr( cNsNum, 7,3)
	            cNsNum   	:= c_Prefixo + c_Num + c_Tipo
			    cTipo 		:= c_Tipo
	
			EndIf
			        
        Else//chave para 9 
        
	        cTipo 		:= substr( cNsNum, 14,2 )       
        
        EndIf                

		nDespes  := aLeitura[06]
		nDescont := aLeitura[07]                     
		nAbatim  := aLeitura[08]
		nValRec  := aLeitura[05]
		nJuros   := aLeitura[09]
		nMulta   := aLeitura[10]
		cOcorr   := PadR(aLeitura[03],3)
		nValOutrD:= aLeitura[12]
		nValCC   := aLeitura[13]
		cData    := aLeitura[14]
		cData    := ChangDate(cData,SEE->EE_TIPODAT)
		dDataCred:= Ctod(Substr(cData,1,2)+"/"+Substr(cData,3,2)+"/"+Substr(cData,5,2),"ddmmyy")
		dDataUser:= dDataCred
		cMotBan  := aLeitura[15]
		xBuffer  := aLeitura[17] // Segmentos concatenados
		aBuffer  := aLeitura[19] // Segmentos separados
		dDtVc		:= CTOD("//")

		aValores := ( { cNumTit, dBaixa, cTipo, cNsNum, nDespes, nDescont, nAbatim, nValRec, nJuros, nMulta, nVaLOutrD, nValCc, dDataCred, cOcorr, cMotBan, xBuffer, dDtVc, aBuffer })
	
		If ExistBlock("200GEMBX")
  			ExecBlock("200GEMBX", .F., .F., {aValores}) 
		EndIf
		
		// Template GEM
		If lF200Var
			ExecBlock("F200VAR",.F.,.F.,{aValores})
		ElseIf ExistTemplate("GEMBaixa")
			ExecTemplate("GEMBaixa",.F.,.F.,)
		Endif
		
		If Empty(cNumTit)
			nLidos += nTamDet
			Loop
		Endif		

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Verifica especie do titulo    ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		nPos := Ascan(aTabela, {|aVal|aVal[1] == Alltrim(Substr(cTipo,1,3))})
		If nPos != 0
			cEspecie := aTabela[nPos][2]
		Else
			cEspecie	:= "  "
		EndIf
		If cEspecie $ MVABATIM			// Nao lˆ titulo de abatimento
			Loop
		EndIf
	EndIf   
	If lF200Avl .And. !ExecBlock("F200AVL",.F.,.F.,{aValores} ) 
		Loop
	Endif
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifica codigo da ocorrencia ³
	//³ ¡ndice: Filial+banco+cod banco³
	//³ +tipo                         ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	dbSelectArea("SEB")
	If !(dbSeek(xFilial("SEB")+mv_par06+cOcorr+"R"))
		Help(" ",1,"FA200OCORR",,mv_par06+"-"+cOcorr+"R",4,1)
	Endif
	lHelp 		:= .F.
	lNaoExiste  := .F.				// Verifica se registro de reciclagem existe no SE1
	If lT200pos
		ExecTemplate("FA200POS",.F.,.F.,{aValores})
	Endif
	If l200pos
		Execblock("FA200POS",.F.,.F.,{aValores})
	Endif
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifica se existe o titulo no SE1. Caso este titulo nao seja ³
	//³ localizado, passa-se para a proxima linha do arquivo retorno. ³
	//³ O texto do help sera' mostrado apenas uma vez, tendo em vista ³
	//³ a possibilidade de existirem muitos titulos de outras filiais.³
	//³ OBS: Sera verificado inicialmente se nao existe outra chave   ³
	//³ igual para tipos de titulo diferentes.                        ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	dbSelectArea("SE1")
	IF ExistBlock("FA200SEB")
		lProcessa := ExecBlock("FA200SEB",.F.,.F.)
		lProcessa := IIF(ValType(lProcessa) != "L",.T., lProcessa)
	ENDIF

	IF lProcessa
		If SEB->EB_OCORR != "39"		// cod 39 -> indica reciclagem
			dbSetOrder(1)
			lAchouTit := .F.
						
			cNumBkp := cNumTit			
	
			If lFa200Fil
				l200Fil := .T.
				Execblock("FA200FIL",.F.,.F.,aValores)
			Else
	
				If (mv_par13 == 2 .And. lNewIndice) .And. !Empty(xFilial("SE1"))
					//Busca por IdCnab (sem filial)
					SE1->(dbSetOrder(19)) // IdCnab
					If SE1->(MsSeek(Substr(cNumTit,1,10)))
						cFilAnt	:= SE1->E1_FILIAL
						If lCtbExcl
							mv_par11 := 2  //Desligo contabilizacao on-line
						Endif
					Endif
				Else
					//Busca por IdCnab
					SE1->(dbSetOrder(16)) // Filial+IdCnab
					SE1->(MsSeek(xFilial("SE1")+	Substr(cNumTit,1,10)))
				Endif
	
				//Se nao achou, utiliza metodo antigo (titulo)
				If SE1->(!Found())
					SE1->(dbSetOrder(1))			
					// Busca por chave antiga como retornado pelo banco
					If dbSeek(xFilial("SE1")+Substr(cNumTit,1,nTamTit)+cEspecie)
						
						lAchouTit := .T.
						nPos   := 1
					Endif
	 
					While !lAchouTit
						// Busca por chave antiga
						dbSetOrder(1)
						If !dbSeek(xFilial("SE1")+Pad(cNumTit,nTamTit)+cEspecie)
							nPos := Ascan(aTabela, {|aVal|aVal[1] == Substr(cTipo,1,2)},nPos+1)
							If nPos != 0
								cEspecie := aTabela[nPos][2]
							Else
								Exit
							Endif
						Else
							lAchouTit := .T.
						Endif
					Enddo	 
					             
  					If !lAchouTit .AND. cEmpAnt == '02'

						SE1->(dbSetOrder(30))			
						// Busca por chave antiga como retornado pelo banco
						If dbSeek(xFilial("SE1")+cNumTit)
							
							lAchouTit := .T.
							nPos   := 1
						Endif
						
					EndIf			
				      
					If !lAchouTit
					// Busca por chave antiga adaptada para o tamanho de 9 posicoes para numero de NF
			   				// Isto ocorre quando titulo foi enviado com 6 posicoes para numero de NF e retornou com o
			   				// campo ja atualizado para 9 posicoes
						cNumTit := SubStr(cNumTit,1,nTamPre)+Padr(Substr(cNumtit,4,6),nTamNum)+SubStr(cNumTit,10,nTamPar)
						If !Empty(cNumTit) .And. dbSeek(xFilial("SE1")+Substr(cNumTit,1,nTamTit))
							cEspecie := SE1->E1_TIPO
							lAchouTit := .T.
							nPos   := 1
		    			Endif
	
			  					                   
						While !lAchouTit
							// Busca por chave antiga
							dbSetOrder(1)
							If !dbSeek(xFilial("SE1")+Pad(cNumTit,nTamTit)+cEspecie)
								nPos := Ascan(aTabela, {|aVal|aVal[1] == Substr(cTipo,1,2)},nPos+1)
								If nPos != 0
									cEspecie := aTabela[nPos][2]
								Else
									Exit
								Endif
							Else
								lAchouTit := .T.
							Endif
						Enddo
					Endif					
				Else
					nPos := 1
				Endif
				
				//-------------------------------------------------------------------------------
				//Inicio - Angelo Henrique - Data:27/04/2019
				//-------------------------------------------------------------------------------
				//Caso não tenha achado o titulo por algum motivo trato diretamente a variável
				//-------------------------------------------------------------------------------
				If !lAchouTit
				
					DbSelectArea("SE1")
					DbSetOrder(1)
					If DbSeek(xFilial("SE1") + cNumBkp )
					
						cEspecie 	:= SE1->E1_TIPO
						lAchouTit 	:= .T.
						nPos   		:= 1
					
					EndIf
				
				EndIf
				//-------------------------------------------------------------------------------
				//Fim - Angelo Henrique - Data:27/04/2019
				//-------------------------------------------------------------------------------
				
				If nPos == 0
					lHelp := .T.
				EndIF
				If !lUmHelp .And. lHelp
					Help(" ",1,"NOESPECIE",,cNumTit+" "+cEspecie,5,1)
					lUmHelp := .T.
				Endif
			EndIf
		Else
			If lRecicl
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Mesmo que nao exista o registro no SE1, ele ser  criado no 	³
				//³ arquivo de reclicagem                                         ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				dbSetOrder(nIndex+1)
				If !dbSeek(xFilial("SE1")+cNsNum)
					If !lFirst
						Fa200Recic()				// Abre arquivo de reciclagem
						lFirst := .T.
					EndIf
					Fa200GrRec(cNsNum)
					lNaoExiste := .T.				// Registro nao existente no SE1 -> portanto nao deve gravar nada no SE1!!
				Endif
			Else			//  uma rejeicao porem o registro nao foi cadastrado no SE1
				Help(" ",1,"NOESPECIE",,cNumTit+" "+cEspecie,5,1)
				lNaoExiste := .T.
			EndIf	
		EndIF	
	ENDIF

	If !lHelp .And. !lNaoExiste
		lSai := .f.
		IF SEB->EB_OCORR $ "03ü15ü16ü17ü40ü41ü42ü52ü53"		//Registro rejeitado
			For nCont := 1 To Len(cMotBan) Step 2
				cMotivo := Substr(cMotBan,nCont,2)
				If fa200Rejei(cMotivo)
					lSai := .T.
					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³ Trata tarifas da retirada do titulo do banco	³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			      If lBxCnab
			      	nTotDesp += nDespes
						nTotOutD += nOutrDesp
			      Else
						IF nDespes > 0 .or. nOutrDesp > 0		//Tarifas diversas
							Fa200Tarifa()
						Endif
					Endif
					Exit
				EndIf
			Next nCont
			If lSai
				If ( MV_PAR12 == 1 )
					nLidos += nTamDet
				Endif
				Loop
			EndIf
		Endif

		IF SEB->EB_OCORR $ "06ü07ü08ü36ü37ü38ü39"		//Baixa do Titulo
			cPadrao:=fA070Pad()
			lPadrao:=VerPadrao(cPadrao)
			lContabiliza:= Iif(mv_par11==1,.T.,.F.)
                
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Monta Contabilizacao.         ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If !lCabec .and. lPadrao .and. lContabiliza
				nHdlPrv := HeadProva( cLote,;
				                      "FINA200",;
				                      substr( cUsuario, 7, 6 ),;
				                      @cArquivo )

				lCabec := .T.
			End
			nValEstrang := SE1->E1_SALDO
			lDesconto   := Iif(mv_par10==1,.T.,.F.)
			
			nTotAbImp	:= 0
			nTotAbat		:= SumAbatRec(SE1->E1_PREFIXO,SE1->E1_NUM,SE1->E1_PARCELA, SE1->E1_MOEDA,"S",dBaixa,@nTotAbImp)
			ABATIMENTO 	:= nTotAbat

			If .F.
				cBanco      := Iif(Empty(SE1->E1_PORTADO),cBanco,SE1->E1_PORTADO)
				cAgencia    := Iif(Empty(SE1->E1_AGEDEP),cAgencia,SE1->E1_AGEDEP)
				cConta      := Iif(Empty(SE1->E1_CONTA),cConta,SE1->E1_CONTA)
			Endif
			
			cHist070    := OemToAnsi("Valor recebido s/ Titulo")  //"Valor recebido s/ Titulo"
			
			//Ponto de entrada para tratamento de abatimento e desconto que voltam na mesma posicao
			//Bradesco
			If lF200ABAT
				ExecBlock("F200ABAT",.F.,.F.)
			Endif
				
			SA6->(DbSetOrder(1))
			SA6->(MSSeek(xFilial("SA6")+cBanco+cAgencia+cConta))

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Verifica se a despesa est     ³
			//³ descontada do valor principal ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If SEE->EE_DESPCRD == "S"
				nValRec := nValRec+nDespes + nOutrDesp - nValCC
			EndIf
			// Calcula a data de credito, se esta estiver vazia
			If dDataCred == Nil .Or. Empty(dDataCred)
				dDataCred := dBaixa // Assume a data da baixa
				For nX := 1 To SA6->A6_Retenca // Para todos os dias de retencao
														 // valida a data

					// O calculo eh feito desta forma, pois os dias de retencao
					// sao dias uteis, e se fosse apenas somado dDataCred+A6_Retenca
					// nao sera verdadeiro quando a data for em uma quinta-feira, por
					// exemplo e, tiver 2 dias de retencao.
					dDataCred := DataValida(dDataCred+1,.T.)
				Next
			EndIf
			dDataUser := dDataCred
			If dDataCred > dBaixa
				cModSpb := "3"   // COMPE
			Endif
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Possibilita alterar algumas das  ³
			//³ vari veis utilizadas pelo CNAB.  ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If lFina200
				aValores[8] := nValRec
				ExecBlock("FINA200",.F.,.F., { aValores, nTotAbat, nTotAbImp } )
			Endif
			
			// Serao usadas na Fa070Grv para gravar a baixa do titulo, considerando os acrescimos e decrescimos
			nAcresc     := Round(NoRound(xMoeda(SE1->E1_SDACRES,SE1->E1_MOEDA,1,dBaixa,3),3),2)
			nDecresc    := Round(NoRound(xMoeda(SE1->E1_SDDECRE,SE1->E1_MOEDA,1,dBaixa,3),3),2)

			nDescont := nDescont - nDecresc
			nJuros	:= nJuros - nAcresc

			lBaixou:=fA070Grv(lPadrao,lDesconto,lContabiliza,cNsNum,.T.,dDataCred,.f.,cArqEnt,SEB->EB_OCORR)

			If lBaixou

				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Grava os lancamentos nas contas orcamentarias SIGAPCO    ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				If SE1->E1_SITUACA == "0"	// Carteira
					PcoDetLan("000004","01","FINA070")
				ElseIf SE1->E1_SITUACA == "1"	// Simples
					PcoDetLan("000004","02","FINA070")
				ElseIf SE1->E1_SITUACA == "2"	// Descontada
					PcoDetLan("000004","03","FINA070")
				ElseIf SE1->E1_SITUACA == "4"	// Vinculada
					PcoDetLan("000004","04","FINA070")
				ElseIf SE1->E1_SITUACA == "5"	// c/Advogado
					PcoDetLan("000004","05","FINA070")
				ElseIf SE1->E1_SITUACA == "6"	// Judicial
					PcoDetLan("000004","06","FINA070")
				ElseIf SE1->E1_SITUACA == "7"	// Caucionada Descontada
					PcoDetLan("000004","08","FINA070")
				EndIf
							
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³Integracao Protheus X RM Classis Net (RM Sistemas)³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				if GetNewPar("MV_RMCLASS", .F.)
					//Replica a baixa do titulo para o RM Classis Net (RM Sistemas)
					ClsProcBx(SE1->(Recno()),'1',"FIN200")
				endif
				
				nTotAGer+=nValRec

				//Para baixa totalizadora somente gravo o movimento de titulos que
				//nao estejam em carteira descontada (2 ou 7) pois este movimento bancario
				//já foi gerado no momento da transferencia ou montagem do bordero
				IF !(SE1->E1_SITUACA $ "2/7")
					dbSelectArea("TRB")
					If !(dbSeek(xFilial("SE5")+Dtos(dDataCred)))
						Reclock("TRB",.T.)
						Replace FILMOV With xFilial("SE5")
						Replace DATAC With dDataCred
					Else
						Reclock("TRB",.F.)
					Endif
					Replace TOTAL WITH TOTAL + nValRec
					MsUnlock()
				Endif
			Endif	

			If lBxCnab
				nTotValCc += nValCC
			Else
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Grava Outros Cr‚ditos, se houver valor                 ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				If nValcc > 0
					fa200Outros()
				Endif
			Endif
			
			If lCabec .and. lPadrao .and. lContabiliza .and. lBaixou
				nTotal += DetProva( nHdlPrv,;
				                    cPadrao,;
				                    "FINA200" /*cPrograma*/,;
				                    cLote,;
				                    /*nLinha*/,;
				                    /*lExecuta*/,;
				                    /*cCriterio*/,;
				                    /*lRateio*/,;
				                    /*cChaveBusca*/,;
				                    /*aCT5*/,;
				                    /*lPosiciona*/,;
				                    @aFlagCTB,;
				                    /*aTabRecOri*/,;
				                    /*aDadosProva*/ )
			Endif

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Credito em C.Corrente -> gera ³
			//³ arquivo de reciclagem         ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If SEB->EB_OCORR $ "39"
				If lRecicl
					If !lFirst
						Fa200Recic()
						lFirst := .T.
					EndIf
					Fa200GrRec(cNsNum)
					dbSelectArea("SE1")
					RecLock("SE1")
					Replace E1_OCORREN With "02"
					MsUnlock()
				EndIf	
			EndIf
		Endif

      If lBxCnab
      	nTotDesp += nDespes
			nTotOutD += nOutrDesp
      Else
			IF nDespes > 0 .or. nOutrDesp > 0		//Tarifas diversas
				Fa200Tarifa()
			Endif
		Endif			

		If SEB->EB_OCORR == "02"			// Confirma‡„o
			RecLock("SE1")
			SE1->E1_OCORREN := "01"
			If Empty(SE1->E1_NUMBCO)
				SE1->E1_NUMBCO  := cNsNUM
			EndIf
			MsUnLock()
			If lFa200_02
				ExecBlock("FA200_02",.f.,.f.)
			Endif
		Endif

		//Grava alteracao da data de vencto quando for o caso
		If SEB->EB_OCORR $ "14" .and. !Empty(dDtVc)  //Alteracao de Vencto
			RecLock("SE1")
			Replace SE1->E1_VENCTO With dDtVc
			Replace SE1->E1_VENCREA With DataValida(dDtVc,.T.)
			MsUnlock()
		Endif
		
		// Se baixou o titulo e existir o arquivo de LOG, grava as informacoes pertinentes
		// Para futuro reprocessamento se preciso for.
		If lBaixou .And. lFI0InDic
			Fa200GrvLog(2, cArqEnt, cBanco, cAgencia, cConta, nLastLn,If(Empty(SE1->E1_IDCNAB), SE1->(E1_PREFIXO+E1_NUM+E1_PARCELA+E1_TIPO), SE1->E1_IDCNAB), SEB->EB_REFBAN, SEB->EB_OCORR, cIdArq)
		Endif
	Endif
	// Avanca uma linha do arquivo retorno
	nLidos+=nTamDet

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Possibilita alterar algumas das  ³
	//³ vari veis utilizadas pelo CNAB.  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If lF200Tit
		ExecBlock("F200TIT",.F.,.F.)
	Endif

Enddo

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Finaliza a gravacao dos lancamentos do SIGAPCO ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
PcoFinLan("000004")

If lCabec .and. lPadrao .and. lContabiliza 
	dbSelectArea("SE1")
	dbGoBottom()
	dbSkip()
	VALOR := nTotAger
	ABATIMENTO := 0
	//nTotal+=DetProva(nHdlPrv,cPadrao,"FINA200",cLote)
	nTotal += DetProva( nHdlPrv,;
	                    cPadrao,;
	                    "FINA200" /*cPrograma*/,;
	                    cLote,;
	                    /*nLinha*/,;
	                    /*lExecuta*/,;
	                    /*cCriterio*/,;
	                    /*lRateio*/,;
	                    /*cChaveBusca*/,;
	                    /*aCT5*/,;
	                    /*lPosiciona*/,;
	                    @aFlagCTB,;
	                    /*aTabRecOri*/,;
	                    /*aDadosProva*/ )


Endif

If l200Fil .and. lfa200F1
	Execblock("FA200F1",.f.,.f.)
Endif

If lTF200Fim
	ExecTemplate("F200FIM",.f.,.f.)
Endif
If lF200Fim
	Execblock("F200FIM",.f.,.f.)
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Grava no SEE o n£mero do £ltimo lote recebido e gera ³
//³ movimentacao bancaria											³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If !Empty(cLoteFin) .and. lBxCnab
	RecLock("SEE",.F.)
	SEE->EE_LOTE := cLoteFin
	MsUnLock()
	If TRB->(Reccount()) > 0
		dbSelectArea("TRB")
		dbGoTop()
		While !Eof()
			cFilAnt := TRB->FILMOV
			Reclock( "SE5" , .T. )
			SE5->E5_FILIAL := xFilial("SE5")
			SE5->E5_DATA   := TRB->DATAC
			SE5->E5_VALOR  := TRB->TOTAL
			SE5->E5_RECPAG := "R"
			SE5->E5_DTDIGIT:= TRB->DATAC
			SE5->E5_BANCO  := cBanco
			SE5->E5_AGENCIA:= cAgencia
			SE5->E5_CONTA  := cConta
			SE5->E5_DTDISPO:= TRB->DATAC
			SE5->E5_LOTE   := cLoteFin
			SE5->E5_HISTOR := "Baixa por Retorno CNAB / Lote :" + " " + cLoteFin // "Baixa por Retorno CNAB / Lote :"
			If SpbInUse()
				SE5->E5_MODSPB := "1"
			Endif
			MsUnlock()

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Gravacao complementar dos dados da baixa aglutinada  ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If ExistBlock("F200BXAG")                               
				Execblock("F200BXAG",.f.,.f.)
			Endif

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Atualiza saldo bancario.      ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			AtuSalBco(cBanco,cAgencia,cConta,SE5->E5_DATA,SE5->E5_VALOR,"+")
			dbSelectArea("TRB")
			dbSkip()
		Enddo
	Endif
	If nTotDesp > 0 .Or. nTotOutD > 0
		Fa200Tarifa(nTotDesp, nTotOutD)
	Endif		
	If nTotValCC > 0
		fa200Outros(nTotValCC)
	Endif		
EndIf

cFilAnt := cFilOrig					// sempre restaura a filial original 

//Contabilizo totalizador das despesas bancárias e outros creditos
If !lBxCnab

	VALOR2 := nCtDesp
	VALOR3 := nCtOutCrd

	dbSelectArea("SE5")
	nRegSE5 := SE5->(Recno())
	dbGoBottom()
	dbSkip()

	lPadrao:=VerPadrao("562")		// Movimentacao Banc ria a Pagar
	lContabiliza:= Iif(mv_par11==1,.T.,.F.)

	If !lCabec .and. lPadrao .and. lContabiliza
		nHdlPrv := HeadProva( cLote,;
		                      "FINA200",;
		                      substr( cUsuario, 7, 6 ),;
		                      @cArquivo )
		lCabec := .T.
	Endif

	If lCabec .and. lPadrao .and. lContabiliza
		//Total de Despesas e Outras despesas
		nTotal += DetProva( nHdlPrv,;
		                    "562",;
		                    "FINA200" /*cPrograma*/,;
		                    cLote,;
		                    /*nLinha*/,;
		                    /*lExecuta*/,;
		                    /*cCriterio*/,;
		                    /*lRateio*/,;
		                    /*cChaveBusca*/,;
		                    /*aCT5*/,;
		                    /*lPosiciona*/,;
		                    @aFlagCTB,;
		                    /*aTabRecOri*/,;
		                    /*aDadosProva*/ )

		//Total de Outros Créditos 
		nTotal += DetProva( nHdlPrv,;
		                    "563",;
		                    "FINA200" /*cPrograma*/,;
		                    cLote,;
		                    /*nLinha*/,;
		                    /*lExecuta*/,;
		                    /*cCriterio*/,;
		                    /*lRateio*/,;
		                    /*cChaveBusca*/,;
		                    /*aCT5*/,;
		                    /*lPosiciona*/,;
		                    @aFlagCTB,;
		                    /*aTabRecOri*/,;
		                    /*aDadosProva*/ )

	Endif
	VALOR2 := VALOR3 := 0
	dbSelectArea("SE5")
	dbGoto(nRegSE5)
Endif

IF lCabec .and. nTotal > 0
	RodaProva(  nHdlPrv,;
				nTotal )

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Envia para Lancamento Contabil                      ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	cA100Incl( cArquivo,;
	           nHdlPrv,;
	           3 /*nOpcx*/,;
	           cLote,;
	           lDigita,;
	           lAglut,;
	           /*cOnLine*/,;
	           /*dData*/,;
	           /*dReproc*/,;
	           @aFlagCTB,;
	           /*aDadosProva*/,;
	           /*aDiario*/ )

	aFlagCTB := {}  // Limpa o coteudo apos a efetivacao do lancamento
Endif

End Transaction

If lRecicl
	If lFirst
		dbSelectArea("cTemp")
		dbCloseArea()
	Endif	
	If cIndex != " "
		RetIndex("SE1")
		Set Filter To
		FErase (cIndex+OrdBagExt())
	EndIf	
Endif

dbSelectArea("TRB")
dbCloseArea()
Ferase(cNomeArq+GetDBExtension())         // Elimina arquivos de Trabalho
Ferase(cNomeArq+OrdBagExt())	 			   // Elimina arquivos de Trabalho

VALOR := 0
ABATIMENTO := 0

SM0->(dbGoTo(nRegEmp))
cFilAnt := SM0->M0_CODFIL

dbSelectArea( "SE1" )
dbSetOrder(1)
dbGoTo( nSavRecno )
If ExistBlock("F200IMP")
	ExecBlock("F200IMP",.F.,.F.)
Endif

Return .F.

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³fA200Par  ³ Autor ³ Wagner Xavier         ³ Data ³ 26/05/92 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Aciona parametros do Programa                               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function fA200Par()
Pergunte( cPerg )
MV_PAR04 := UPPER(MV_PAR04)
Return .T.

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³fA200Rejei³ Autor ³ Wagner Xavier         ³ Data ³ 26/05/92 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Trata titulo rejeitado.                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³fa200Rejei                                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function fa200Rejei(cMotivo)
Local cAlias := Alias()
Local lRet := .F.
Local lPadrao := .f.
Local cNumBor := " "
Private cSituant := "0"									// Private para permitir condicionamento para contabilização

dbSelectArea("SEB")
// Procura pela chave completa->filial+banco+ocorrencia+tipo+motivo banco
If dbSeek(xFilial("SEB")+mv_par06+cOcorr+"R"+cMotivo)
	IF SEB->EB_MOTSIS == "01" .OR. EMPTY(SEB->EB_MOTSIS)	// Titulo protestado ou nao pago
		dbSelectArea("SEA")											// Retorna p/ carteira
		dbSetOrder(1)
		If dbSeek(xFilial("SEA")+SE1->E1_NUMBOR+SE1->E1_PREFIXO+SE1->E1_NUM+SE1->E1_PARCELA+SE1->E1_TIPO)
			Reclock( "SEA" , .F. , .T.)
			SEA->(dbDelete( ))
			MsUnlock()
		EndIf
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ PONTO DE ENTRADA FA280RE2                                     ³
		//³ Tratamento de dados de titulo rejeitado antes de "zerar" os 	³
		//³ dados do mesmo.                                               ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If ExistBlock("FA200RE2")
			Execblock("FA200RE2",.F.,.F.)
		Endif	
		cSituant := SE1->E1_SITUACA
		cNumBor := SE1->E1_NUMBOR
		Reclock( "SE1" )
		SE1->E1_SITUACA := "0"
		SE1->E1_PORTADO := Space(Len(SE1->E1_PORTADO) )
		SE1->E1_AGEDEP  := Space(Len(SE1->E1_AGEDEP ) )
		SE1->E1_CONTA   := Space(Len(SE1->E1_CONTA  ) )
		SE1->E1_DATABOR := CtoD ( "" )
		SE1->E1_NUMBOR  := Space(Len(SE1->E1_NUMBOR ) )
		SE1->E1_NUMBCO  := Space(Len(SE1->E1_NUMBCO ) )
		SE1->E1_OCORREN := "01"
		lRet := .T.
		MsUnlock()

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Efetua a contabilizacao da transferencia para carteira, caso   ³
		//³exista este lancamento padrao, pois se nao for feito neste mo- ³
		//³mento nao havera registro da rejeicao.                         ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		lPadrao:=VerPadrao("540")
		If !lCabec .and. lPadrao
			nHdlPrv := HeadProva( cLote,;
			                      "FINA200",;
			                      substr( cUsuario, 7, 6 ),;
			                      @cArquivo )

			lCabec := .T.
		Endif

		If lCabec .and. lPadrao
			nTotal += DetProva( nHdlPrv,;
			                    "540",;
			                    "FINA200" /*cPrograma*/,;
			                    cLote,;
			                    /*nLinha*/,;
			                    /*lExecuta*/,;
			                    /*cCriterio*/,;
			                    /*lRateio*/,;
			                    /*cChaveBusca*/,;
			                    /*aCT5*/,;
			                    /*lPosiciona*/,;
			                    @aFlagCTB,;
			                    /*aTabRecOri*/,;
			                    /*aDadosProva*/ )

			// Forca a contabilizacao da rejeicao on-line pois nao e registrada
			// a transferencia para a carteira
			lDigita := .T.  
		Endif
		
		If cSituAnt == "2"			//  'Se cobranca descontada e rejeita gera um movimento a pagar"
			Reclock("SE5", .T. )
			Replace E5_FILIAL         With xFilial()
			Replace E5_BANCO       With cBanco
			Replace E5_AGENCIA    With cAgencia
			Replace E5_CONTA        With cConta
			Replace E5_VALOR        With nValrec
			Replace E5_HISTOR        With "EST. " + cNumBor+" "+SE1->E1_PREFIXO+" "+SE1->E1_NUM+" "+SE1->E1_PARCELA+" "+SE1->E1_TIPO
			Replace E5_VLMOED2    With nValrec
			Replace E5_RECPAG      With "P"
			Replace E5_DATA           With dBaixa
			Replace E5_DTDIGIT        With dDataBase
			Replace E5_DTDISPO      With dBaixa
			If SpbInUse()
				SE5->E5_MODSPB := "1"
			Endif
			MsUnlock()
			AtuSalBco(cBanco,cAgencia,cConta,SE5->E5_DATA,SE5->E5_VALOR,"-") 

			lPadrao:=VerPadrao("562")
			If !lCabec .and. lPadrao
				nHdlPrv := HeadProva( cLote,;
				                      "FINA200",;
				                      substr( cUsuario, 7, 6 ),;
				                      @cArquivo )
				lCabec := .T.
			Endif

			If lCabec .and. lPadrao
				nTotal += DetProva( nHdlPrv,;
				                    "562",;
				                    "FINA200" /*cPrograma*/,;
				                    cLote,;
				                    /*nLinha*/,;
				                    /*lExecuta*/,;
				                    /*cCriterio*/,;
				                    /*lRateio*/,;
				                    /*cChaveBusca*/,;
				                    /*aCT5*/,;
				                    /*lPosiciona*/,;
				                    @aFlagCTB,;
				                    /*aTabRecOri*/,;
				                    /*aDadosProva*/ )

				// Forca a contabilizacao da rejeicao on-line pois nao e registrada
				// a transferencia para a carteira
				lDigita := .T.  
			Endif
		EndIf
   Endif

	//DDA - Debito Direto Autorizado
	If Alltrim(cOcorr) $ "53/52"
		Reclock("SE1")
		SE1->E1_OCORREN := cOcorr
		MsUnlock()
	Endif

EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ PONTO DE ENTRADA FA280REJ                                     ³
//³ Tratamento de dados de titulo rejeitado                     	³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If ExistBlock("FA200REJ")
	Execblock("FA200REJ",.F.,.F.)
Endif	
MsUnlock()
dbSelectArea( cAlias )
Return lRet

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³fA200Tarif³ Autor ³ Wagner Xavier         ³ Data ³ 26/05/92 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³Trata uma determinada tarifa.                               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³fa200Tarifa( )                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³Generico                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function fa200Tarifa(nTotDesp, nTotOutD)

Local cAlias := Alias()
Local lPadrao
Local lContabiliza
Local cNat
Local lSpbInUse := SpbInUse()
Local nX := 0

nDespes   := If(nTotDesp == Nil, nDespes  , nTotDesp)
nOutrDesp := If(nTotOutD == Nil, nOutrDesp, nTotOutD)

If nDespes == 0 .and. nOutrDesp == 0
	Return
EndIf	

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Calcula a data de credito, se esta estiver vazia			³
//³ Se aplica apenas nos casos de confirma‡Æo de entrada do	³
//³ titulo e tenha lancamento de Despesas Banc rias, pois 	³
//³ nas ocorrencias de baixa, essa data ja estara calculada ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If dDataCred == Nil .Or. Empty(dDataCred)
	dDataCred := If(!Empty(dBaixa),dBaixa,SE5->E5_DATA)  // Assume a data da baixa ou a data do movimento totalizador
	dBaixa := If(!Empty(dBaixa),dBaixa,SE5->E5_DATA)		
	For nX := 1 To Sa6->A6_Retenca // Para todos os dias de retencao
											 // valida a data
			// O calculo eh feito desta forma, pois os dias de retencao
			// sao dias uteis, e se fosse apenas somado dDataCred+A6_Retenca
			// nao sera verdadeiro quando a data for em uma quinta-feira, por
			// exemplo e, tiver 2 dias de retencao.
		dDataCred := DataValida(dDataCred+1,.T.)
	Next
EndIf

If nDespes > 0
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Gera registro na movimenta‡„o ³
	//³ bancaria.                     ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	cNat := &(GetMv("MV_NATDPBC"))
	Reclock( "SE5" , .T. )
	SE5 -> E5_FILIAL := xFilial()
	SE5 -> E5_DATA   := dBaixa
	SE5 -> E5_VALOR  := nDespes
	SE5 -> E5_NATUREZ:= Iif(!Empty(cNat) .Or. nTotDesp # Nil,cNat,SE1 -> E1_NATUREZ)
	SE5 -> E5_RECPAG := "P"
	SE5 -> E5_DTDIGIT:= dDataBase
	SE5 -> E5_BANCO  := SA6 -> A6_COD
	SE5 -> E5_AGENCIA:= SA6 -> A6_AGENCIA
	SE5 -> E5_CONTA  := SA6 -> A6_NUMCON
	SE5 -> E5_DTDISPO:= dDataCred
	SE5 -> E5_TIPODOC:= "DB"		// Despesas Banc rias
	SE5 -> E5_MOTBX  := "NOR"		// Normal
	If nTotDesp # Nil
		SE5->E5_LOTE   := cLoteFin
		SE5->E5_HISTOR := "Baixa por Retorno CNAB / Lote :" + " " + cLoteFin // "Baixa por Retorno CNAB / Lote :"
	Else
		SE5 -> E5_PREFIXO:= SE1 -> E1_PREFIXO
		SE5 -> E5_NUMERO := SE1 -> E1_NUM
		SE5 -> E5_PARCELA:= SE1 -> E1_PARCELA
		SE5 -> E5_TIPO   := SE1 -> E1_TIPO
		SE5 -> E5_CLIFOR := SE1 -> E1_CLIENTE
		SE5 -> E5_LOJA   := SE1 -> E1_LOJA
		SE5 -> E5_HISTOR := SEB -> EB_DESCRI
	Endif
	If lSpbInUse
		SE5->E5_MODSPB := "1"
	Endif
	
	MsUnlock()

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ PONTO DE ENTRADA F200DB1                                    ³
	//³ Serve para tratamento complementar das despesas bancarias.  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	IF ExistBlock("F200DB1")
		ExecBlock("F200DB1",.F.,.F.)
	Endif

	AtuSalBco(SE5->E5_BANCO,SE5->E5_AGENCIA,SE5->E5_CONTA,SE5->E5_DATA,SE5->E5_VALOR,"-")

	lPadrao:=VerPadrao("562")		// Movimentacao Banc ria a Pagar
	lContabiliza:= Iif(mv_par11==1,.T.,.F.)

	If !lCabec .and. lPadrao .and. lContabiliza
		nHdlPrv := HeadProva( cLote,;
		                      "FINA200",;
		                      substr( cUsuario, 7, 6 ),;
		                      @cArquivo )

		lCabec := .T.
	Endif

	dbSelectArea("SE5")

	If lCabec .and. lPadrao .and. lContabiliza
		nTotal += DetProva( nHdlPrv,;
		                    "562",;
		                    "FINA200" /*cPrograma*/,;
		                    cLote,;
		                    /*nLinha*/,;
		                    /*lExecuta*/,;
		                    /*cCriterio*/,;
		                    /*lRateio*/,;
		                    /*cChaveBusca*/,;
		                    /*aCT5*/,;
		                    /*lPosiciona*/,;
		                    @aFlagCTB,;
		                    /*aTabRecOri*/,;
		                    /*aDadosProva*/ )

		If lUsaFlag // Armazena em aFlagCTB para atualizar no modulo Contabil
			aAdd( aFlagCTB, { "E5_LA", "S", "SE5", SE5->( RecNo() ), 0, 0, 0} )
		EndIf
	Endif
	nCtDesp += nDespes
Endif

If nOutrDesp > 0
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Gera registro na movimenta‡„o ³
	//³ bancaria.                     ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	cNat := &(GetMv("MV_NATDPBC"))
	Reclock( "SE5" , .T. )
	SE5 -> E5_FILIAL := xFilial()
	SE5 -> E5_DATA   := dBaixa
	SE5 -> E5_VALOR  := nOutrDesp
	SE5 -> E5_NATUREZ:= Iif(!Empty(cNat) .Or. nTotOutD # Nil,cNat,SE1 -> E1_NATUREZ)
	SE5 -> E5_RECPAG := "P"
	SE5 -> E5_DTDIGIT:= dDataBase
	SE5 -> E5_DTDISPO:= dDataCred
	SE5 -> E5_TIPODOC:= "OD"		//Outras Despesas
	SE5 -> E5_MOTBX  := "NOR"		//Normal
	If nTotOutD # Nil
		SE5->E5_LOTE    := cLoteFin
		SE5->E5_HISTOR  := "Baixa por Retorno CNAB / Lote :" + " " + cLoteFin // "Baixa por Retorno CNAB / Lote :"
		SE5->E5_BANCO   := SA6 -> A6_COD
		SE5->E5_AGENCIA := SA6 -> A6_AGENCIA
		SE5->E5_CONTA   := SA6 -> A6_NUMCON
	Else
		SE5 -> E5_PREFIXO:= SE1 -> E1_PREFIXO
		SE5 -> E5_NUMERO := SE1 -> E1_NUM
		SE5 -> E5_PARCELA:= SE1 -> E1_PARCELA
		SE5 -> E5_TIPO   := SE1 -> E1_TIPO
		SE5 -> E5_CLIFOR := SE1 -> E1_CLIENTE
		SE5 -> E5_LOJA   := SE1 -> E1_LOJA
		SE5 -> E5_HISTOR := SEB -> EB_DESCRI
		SE5 -> E5_BANCO  := SE1 -> E1_PORTADO
		SE5 -> E5_AGENCIA:= SE1 -> E1_AGEDEP
		SE5 -> E5_CONTA  := SE1 -> E1_CONTA
	Endif
	If lSpbInUse
		SE5->E5_MODSPB := "1"
	Endif
	
	MsUnlock()

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ PONTO DE ENTRADA F200DB2                                    ³
	//³ Serve para tratamento complementar de outras despesas.      ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	IF ExistBlock("F200DB2")
		ExecBlock("F200DB2",.F.,.F.)
	Endif

	AtuSalBco(SE5->E5_BANCO,SE5->E5_AGENCIA,SE5->E5_CONTA,SE5->E5_DATA,SE5->E5_VALOR,"-")

	lPadrao:=VerPadrao("562")		// Movimentacao Banc ria a Pagar
	lContabiliza:= Iif(mv_par11==1,.T.,.F.)

	If !lCabec .and. lPadrao .and. lContabiliza
		nHdlPrv := HeadProva( cLote,;
		                      "FINA200",;
		                      substr( cUsuario, 7, 6 ),;
		                      @cArquivo )

		lCabec := .T.
	Endif

	dbSelectArea("SE5")
	If lCabec .and. lPadrao .and. lContabiliza
		nTotal += DetProva( nHdlPrv,;
		                    "562",;
		                    "FINA200" /*cPrograma*/,;
		                    cLote,;
		                    /*nLinha*/,;
		                    /*lExecuta*/,;
		                    /*cCriterio*/,;
		                    /*lRateio*/,;
		                    /*cChaveBusca*/,;
		                    /*aCT5*/,;
		                    /*lPosiciona*/,;
		                    @aFlagCTB,;
		                    /*aTabRecOri*/,;
		                    /*aDadosProva*/ )

		If lUsaFlag // Armazena em aFlagCTB para atualizar no modulo Contabil
			aAdd( aFlagCTB, { "E5_LA", "S", "SE5", SE5->( RecNo() ), 0, 0, 0} )
		EndIf
	Endif
	nCtDesp += nOutrDesp
Endif
dbSelectArea(cAlias)
Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³fA200Outro³ Autor ³ Wagner Xavier         ³ Data ³ 26/05/92 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³Trata uma determinada tarifa.                               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³fa200Tarifa( )                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³Generico                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function fa200Outros( nTotValcc )
Local cAlias := Alias()
Local cNat
Local nX := 0

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Gera registro na movimenta‡„o ³
//³ bancaria.                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

nValCC := If(nTotValCC = Nil, nValCC, nTotValCC)

If nValCC = 0
	Return .T.
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Calcula a data de credito, se esta estiver vazia			³
//³ Se aplica apenas nos casos de confirma‡Æo de entrada do	³
//³ titulo e tenha lancamento de Despesas Banc rias, pois 	³
//³ nas ocorrencias de baixa, essa data ja estara calculada ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If dDataCred == Nil .Or. Empty(dDataCred)
	dDataCred := If(!Empty(dBaixa),dBaixa,SE5->E5_DATA)  // Assume a data da baixa ou a data do movimento totalizador
	dBaixa := If(!Empty(dBaixa),dBaixa,SE5->E5_DATA)
	For nX := 1 To Sa6->A6_Retenca // Para todos os dias de retencao
											 // valida a data
			// O calculo eh feito desta forma, pois os dias de retencao
			// sao dias uteis, e se fosse apenas somado dDataCred+A6_Retenca
			// nao sera verdadeiro quando a data for em uma quinta-feira, por
			// exemplo e, tiver 2 dias de retencao.
		dDataCred := DataValida(dDataCred+1,.T.)
	Next
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Gera registro na movimenta‡„o ³
//³ bancaria.                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cNat := &(GetMv("MV_NATDPBC"))
Reclock( "SE5" , .T. )
SE5->E5_FILIAL := xFilial()
SE5->E5_DATA   := dBaixa
SE5->E5_VALOR  := nValcc
SE5->E5_TIPODOC:= "DB"		//Outros Cr‚ditos
SE5->E5_NATUREZ:= Iif(!Empty(cNat) .Or. nTotValCC # Nil,cNat,SE1 -> E1_NATUREZ)
SE5->E5_RECPAG := "R"
SE5->E5_DTDIGIT:= dDataBase
SE5->E5_BANCO  := SA6->A6_COD
SE5->E5_AGENCIA:= SA6->A6_AGENCIA
SE5->E5_CONTA  := SA6->A6_NUMCON
SE5->E5_DTDISPO:= dDataCred
SE5->E5_MOTBX  := "NOR"	// Normal
If nTotValCC # Nil
	SE5->E5_LOTE    := cLoteFin
	SE5->E5_HISTOR  := "Baixa por Retorno CNAB / Lote :" + " " + cLoteFin // "Baixa por Retorno CNAB / Lote :"
Else 	
	SE5->E5_PREFIXO:= SE1->E1_PREFIXO
	SE5->E5_NUMERO := SE1->E1_NUM
	SE5->E5_PARCELA:= SE1->E1_PARCELA
	SE5->E5_TIPO   := SE1->E1_TIPO
	SE5->E5_CLIFOR := SE1->E1_CLIENTE
	SE5->E5_LOJA   := SE1->E1_LOJA
	SE5->E5_HISTOR := SEB->EB_DESCRI
Endif
If SpbInUse()
	SE5->E5_MODSPB := "1"
Endif

MsUnlock()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ PONTO DE ENTRADA F200OCR                                    ³
//³ Serve para tratamento complementar de outros creditos.      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
IF ExistBlock("F200OCR")
	ExecBlock("F200OCR",.F.,.F.)
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Atualiza saldo bancario.      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
AtuSalBco(cBanco,cAgencia,cConta,dBaixa,nValcc,"+")

lPadrao:=VerPadrao("563")		// Movimentacao Banc ria a Receber
lContabiliza:= Iif(mv_par11==1,.T.,.F.)

If !lCabec .and. lPadrao .and. lContabiliza
	nHdlPrv := HeadProva( cLote,;
	                      "FINA200",;
	                      substr( cUsuario, 7, 6 ),;
	                      @cArquivo )

	lCabec := .T.
Endif

dbSelectArea("SE5")

If lCabec .and. lPadrao .and. lContabiliza
	nTotal += DetProva( nHdlPrv,;
	                    "563",;
	                    "FINA200" /*cPrograma*/,;
	                    cLote,;
	                    /*nLinha*/,;
	                    /*lExecuta*/,;
	                    /*cCriterio*/,;
	                    /*lRateio*/,;
	                    /*cChaveBusca*/,;
	                    /*aCT5*/,;
	                    /*lPosiciona*/,;
	                    @aFlagCTB,;
	                    /*aTabRecOri*/,;
	                    /*aDadosProva*/ )

	If lUsaFlag // Armazena em aFlagCTB para atualizar no modulo Contabil
		aAdd( aFlagCTB, { "E5_LA", "S", "SE5", SE5->( RecNo() ), 0, 0, 0} )
	EndIf
Endif
nCtOutCrd := nValcc
dbSelectArea( cAlias )
Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³Fa200Recic³ Autor ³ Pilar S. Albaladejo   ³ Data ³ 22/05/97 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³Cria o arquivo de reciclagem                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³fa200Recic( )	                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³Generico                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function Fa200Recic()
Local nTempNnum := TamSX3("E1_NUMBCO")[1]
Local cDbf , aCampos
cDbf := "RECICL" + SubStr(cNumEmp,1,2)

If !File(cDbf+GetDBExtension())
	aCampos:={ {"FILIAL  ","C",IIf( lFWCodFil, FWGETTAMFILIAL, 2 ),0},;
              {"NOSSONUM","C",nTempNnum,0}}
	If (Select("cTemp") <> 0 )
		dbSelectArea ( "cTemp" )
		dbCloseArea ()
	Endif
	dbCreate(cDbf,aCampos)
   dbUseArea(.T.,,cDbf,"cTemp",NIL,.F.)
Endif

dbUseArea(.T.,,cDbf,"cTemp",NIL,.F.)
IndRegua("cTemp",cDbf,"FILIAL+NOSSONUM",,,OemToAnsi("Selecionando Registros..."))  //"Selecionando Registros..."
Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³Fa200GrRec³ Autor ³ Pilar S. Albaladejo   ³ Data ³ 22/05/97 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³Grava registros no arquivo de reciclagem                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³fa200GrRec( )	                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³Generico                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function Fa200GrRec(cNsNum)
Local cAlias := Alias()
dbSelectArea("cTemp")
If !dbSeek(xFilial("SE1")+cNsNum)
	RecLock("cTemp",.T.)
	Replace FILIAL		With xFilial("SE1")
	Replace NOSSONUM 	With cNsNum
	MsUnlock()
EndIf
dbSelectArea(cAlias)
Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o	 ³Fa200ChecF³ Autor ³ Pilar S Albaladejo    ³ Data ³ 22/05/97 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³Retorna Expresao para Indice Condicional						  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe	 ³Fa200ChecF() 															  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso		 ³Generico																	  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function FA200ChecF()
Local cFiltro := ""
cFiltro := 'E1_FILIAL == "'+xFilial("SE1")+'" .And. E1_SALDO > 0'
Return cFiltro

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o	 ³Chk200File³ Autor ³ Mauricio Pequim Jr    ³ Data ³ 24/11/97 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³Checa se arquivo de TB j  foi processado anteriormente		  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe	 ³Chk200File()  															  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso		 ³Fina200																	  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function Chk200File()
LOCAL cFile := "TB"+cNumEmp+".VRF"
LOCAL lRet	:= .F.
LOCAL aFiles:= {}
LOCAL cString
LOCAL nTam
LOCAL nHdlFile

If !FILE(cFile)
	nHdlFile := fCreate(cFile)
ELSE
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Tenta abrir o arquivo em modo exclusivo e Leitura/Gravacao ³	
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	While (nHdlFile := fOpen(cFile,FO_READWRITE+FO_EXCLUSIVE))==-1 .AND. ;
			MsgYesNo( "Empresa"+cNumEmp+"", "" )
//			MsgYesNo( STR0013+cNumEmp+STR0014, STR0012 )

	End
Endif

If nHdlFile > 0

	nTam := TamSx1("AFI200","04")[1] // Tamanho do parametro
	xBuffer := SPACE(nTam)
	// Le o arquivo e adiciona na matriz
	While fReadLn(nHdlFile,@xBuffer,nTam) 
		Aadd(aFiles, Trim(xBuffer))
	Enddo	

	If ASCAN(aFiles,Trim(MV_PAR04)) > 0
		Help(" ",1,"CHK200FILE")       // Arquivo de Trans.Banc. j  processado
	Else
		fSeek(nHdlFile,0,2) // Posiciona no final do arquivo
		cString := Alltrim(mv_par04)+Chr(13)+Chr(10)
		fWrite(nHdlFile,cString)	// Grava nome do arquivo a ser processado
		lRet := .T.
	endif	
	fClose (nHdlFile)
Else
   Help(" ", 1, "CHK200ERRO") // Erro na leitura do arquivo de entrada
EndIf	
Return lRet

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o	 ³Fa200GrvLog³ Autor ³ Claudio Donizete      ³ Data ³ 25/07/05 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³Grava LOG de processamento do arquivo retorno					   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe	 ³Fa200GrvLog   															   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso		 ³Fina200																	   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function Fa200GrvLog(nTipo, cArquivo, cBanco, cAgencia, cConta, nLastLn, cIdTit,;
									 cOcoBco, cOcoSis, cIdArq)
Local cSeq := "00"
Local lRet := .T.
Local nLastRec
Local cBarra	:= If(isSrvUnix(),"/","\")
Local nBarra 	:= Rat(cBarra,cArquivo)
Local aUsuario

// Obtem o nome do arquivo apenas, desprezando o path
cArquivo := If(nBarra > 0, SubStr(cArquivo,nBarra+1), cArquivo)

If nTipo == 1 // Cabecalho
	// Se o arquivo ja foi processado, a ultima linha sera a ultima
	// gravada no arquivo
	If FI0->(MsSeek(xFilial("FI0")+Pad(cIdArq,Len(FI0_IDARQ))+cBanco+cAgencia+cConta))
		While FI0->(FI0_FILIAL+Pad(FI0_IDARQ,Len(FI0_IDARQ))+FI0_BCO+FI0_AGE+FI0_CTA) == xFilial("FI0")+Pad(cIdArq,Len(FI0->FI0_IDARQ))+cBanco+cAgencia+cConta
			nLastLn	:= FI0->FI0_LASTLN
			cSeq	  	:= FI0->FI0_SEQ
			nLastRec := FI0->(Recno())
			FI0->(DbSkip())
		End
		FI0->(MsGoto(nLastRec))
		PswOrder(1)
		PswSeek(FI0->FI0_USU)
		aUsuario := PswRet()
		lRet := ApMsgYesNo("Arquivo retorno já processado anteriormente em " +;
								 DTOC(FI0->FI0_DTPRC) + " às " + FI0->FI0_HRPRC + Chr(13)+Chr(10)+;
								 "Processado com o nome : " + AllTrim(FI0->FI0_ARQ)+ Chr(13)+Chr(10)+ ;
								 "Usuário que processou : " + Alltrim(aUsuario[1][2])+ Chr(13)+Chr(10)+;
								 "A ultima linha lida do arquivo foi: " +	Transform(FI0->FI0_LASTLN, "")+ Chr(13)+Chr(10) +;
								 "O arquivo já foi processado " + Str(Val(FI0->FI0_SEQ),3) +;
								 If(Val(FI0->FI0_SEQ)<=1," vez", " vezes")+". Deseja  reprocessá-lo?")
	Endif
	If lRet
		FI0->(RecLock("FI0", .T.))	
		FI0->FI0_FILIAL	:= xFilial("FI0")
		FI0->FI0_ARQ		:= cArquivo
		FI0->FI0_IDARQ		:= cIdArq
		FI0->FI0_DTPRC		:= dDataBase
		FI0->FI0_HRPRC		:= Left(Time(), 6) // Grava a HH:MM do processamento
		FI0->FI0_BCO		:= cBanco
		FI0->FI0_AGE		:= cAgencia
		FI0->FI0_CTA		:= cConta
		FI0->FI0_USU		:= RetCodUsr()
		FI0->FI0_LASTLN	:= nLastLn
		FI0->FI0_SEQ		:= Soma1(cSeq)
		MsUnlock()
		FKCOMMIT()
	Endif
Elseif nTipo == 2 // Detalhe dos titulos processados
	FI1->(RecLock("FI1", .T.))
	FI1->FI1_FILIAL	:= xFilial("FI1")
	FI1->FI1_IDARQ		:= cIdArq
	FI1->FI1_IDTIT		:= cIdTit
	FI1->FI1_OCORB		:= cOcoBco
	FI1->FI1_OCORS		:= cOcoSis
	If FI1->(FieldPos("FI1_SEQ")) > 0
		FI1->FI1_SEQ		:= FI0->FI0_SEQ
	Endif	
	MsUnlock()
	FKCOMMIT()
Endif

Return lRet

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o	 ³LeTrailler | Autor ³ Claudio Donizete      ³ Data ³ 18/08/05 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³Le as ultimas linhas do arquivo texto para gerar checksum		|±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe	 ³LeTrailler(nHdlBco)													   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso		 ³Fina200																	   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function LeTrailler(nHdlBco)
Local cRet		:= ""
Local cBuffer	:= Space(402)
Local nOffSet	:= fSeek(nHdlBco,0,FS_RELATIVE) // Sera utilizado para retornar o ponteiro do arquivo a posicao original
Local nTamArq	:= fSeek(nHdlBco,0,FS_END) // Obtem o tamanho do arquivo

fSeek(nHdlBco,-804,FS_END) // Volta 804 bytes para compor o CheckSum

// Le o arquivo ate final
While fReadLn(nHdlBco,@cBuffer,402)
	cRet += cBuffer
End

fSeek(nHdlBco,nOffSet,FS_SET) // Retorna o ponteiro para a posicao original

Return cRet+Transform(nTamArq,"")

/*/
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ AjustaSX2    ³ Autor ³ Ricardo A. Canteras	³ Data ³ 07/08/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Ajusta campos do SX2                                           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ AjustaSx2( )                                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ Nenhum                                                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ .T.                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso		 ³ FINA200                                                        ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
STATIC Function AjustaSx2()

Local aArea := GetArea()

DbSelectArea("SX2")
DbSetOrder(1)

//Procura e deleta chave unica do arquivo log de detalhes cnab
If MsSeek("FI1")
	If !Empty(X2_UNICO)
		RecLock("SX2",.F.)
		Replace X2_UNICO   With ""
		MsUnlock()
	Endif
Endif

RestArea(aArea)

Return .T.

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ AjustaSX1 º Autor ³ Gustavo Henrique  º Data ³  16/02/09   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Realizar ajustes nos grupos de pergunta do dicionario SX1  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºParametros³ EXPC1 - Nome do grupo de perguntas utilizado.              º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Retorno CNAB a Receber                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
STATIC Function AjustaSX1(cPerg)

Local aHelpPor, aHelpSpa, aHelpEng

// Inclusão de pergunta "Processa Filial?"
SX1->( dbSetOrder( 1 ) )

If !SX1->( dbSeek( PadR( cPerg, Len( X1_GRUPO 	) ) + "13" ) )

	PutSx1( cPerg, "13","Processa Filial?","¿Processa Sucursal?","Processa Branch?","mv_chD","N",1,0,1,"C","","","","",;
		"mv_par13","Filial Atual","Sucursal Atual","Actual Branch","","Todas Filiais","Todas Sucursais","All Branchs","","","","","","","","","",,,,".AFI20013.")
	
	aHelpPor := {}
	aHelpSpa := {}
	aHelpEng := {}
	
	Aadd(aHelpPor,{	"Indicar se o processamento de retorno",;
					"deve considerar somente os títulos da",;
					"Filial Atual ou os títulos de Todas as",;
					"Filiais, se utilizado o recurso IDCNAB.",;
					"Na opção Todas as Filiais, se a",;
					"contabilidade estiver em modo exclusivo, ",;
					"a contabilização deve ser realizada em",;
					"modo off-line." })
                   
	Aadd(aHelpSpa,{	"Indicar si el proceso de retorno",;
					"considerará únicamente los títulos",;
					"de la Sucursal actual o los títulos de",;
					"Todas las sucursales, si utilizar lo",;
					"recurso IDCNAB. En la opción Todas",;
					"las Sucursales, si la contabilidad ",;
					"estuviera en modo exclusivo, la ",;
					"contabilizacion debe hacerse en modo ",;
					"off-line." })
                  	
	Aadd(aHelpEng,{	"Indicates if the receipt transaction",;
					"have to consider only the bills of ",;
					"current branch or all branchs, if used",;
					"resource IDCNAB. If you select all",;
					"branchs and the accounting is in ",;
					"exclusive mode, you have to use the",;
					"off-line accounting routine." })
	
	PutHelp("P.AFI20013.",aHelpPor[1],aHelpEng[1],aHelpSpa[1])

EndIf

Return .T.

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³MenuDef   ³ Autor ³ Ana Paula N. Silva     ³ Data ³23/11/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Utilizacao de menu Funcional                               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³Array com opcoes da rotina.                                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³Parametros do array a Rotina:                               ³±±
±±³          ³1. Nome a aparecer no cabecalho                             ³±±
±±³          ³2. Nome da Rotina associada                                 ³±±
±±³          ³3. Reservado                                                ³±±
±±³          ³4. Tipo de Transa‡„o a ser efetuada:                        ³±±
±±³          ³		1 - Pesquisa e Posiciona em um Banco de Dados     ³±±
±±³          ³    2 - Simplesmente Mostra os Campos                       ³±±
±±³          ³    3 - Inclui registros no Bancos de Dados                 ³±±
±±³          ³    4 - Altera o registro corrente                          ³±±
±±³          ³    5 - Remove o registro corrente do Banco de Dados        ³±±
±±³          ³5. Nivel de acesso                                          ³±±
±±³          ³6. Habilita Menu Funcional                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   DATA   ³ Programador   ³Manutencao efetuada                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³          ³               ³                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function MenuDef()
Local aRotina:= { {OemToAnsi("Parametros"    ) ,"U_fA200Par" , 0 , 1},;  // "Parametros"    
                    {OemToAnsi("Visualizar"     ) ,"AxVisual" , 0 , 2},;  // "Visualizar"     
                    {OemToAnsi("Receber Arquivo") ,"u_fA200Gera", 0 , 3} }  // "Receber Arquivo"
Return(aRotina)  
