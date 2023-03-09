#INCLUDE "RWMAKE.CH"
#INCLUDE "PLSMGER.CH"
#INCLUDE "PLSMLIB.CH"
#INCLUDE "COLORS.CH"
#INCLUDE "TOPCONN.CH"

#DEFINE c_ent CHR(13) + CHR(10)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออออหออออออัอออออออออออปฑฑ
ฑฑบPrograma  ณ PREPCART บ Autor ณ Jean Schulz          บ Data ณ 11/11/06  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออออสออออออฯอออออออออออนฑฑ
ฑฑบDescricao ณ Rotina para preparacao e manipulacao do arquivo de cartao  บฑฑ
ฑฑบ          ณ de identificacao, conforme necessidade do cliente.         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
User Function PREPCART
	
	Local cCodPla := Space(0)
	
	Private oLeTxt
	Private lAbortPrint 	:= .F.
	Private lLotac 		:= .F.
	
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Declaracao de Variaveis                                             ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	PRIVATE cNomeProg   := "PREPCART"
	PRIVATE cPerg       := "PREPCA"
	PRIVATE nQtdLin     := 68
	PRIVATE nLimite     := 132
	PRIVATE cControle   := 15
	PRIVATE cAlias      := "BA1"
	PRIVATE cTamanho    := "G"
	PRIVATE cTitulo     := "Prepara emissao do cartao"
	PRIVATE cDesc1      := ""
	PRIVATE cDesc2      := ""
	PRIVATE cDesc3      := ""
	PRIVATE nRel        := "RELIMPFAR"
	PRIVATE nlin        := 100
	PRIVATE nOrdSel     := 1
	PRIVATE m_pag       := 1
	PRIVATE lCompres    := .F.
	PRIVATE lDicion     := .F.
	PRIVATE lFiltro     := .T.
	PRIVATE lCrystal    := .F.
	PRIVATE aOrdens     := {}
	PRIVATE aReturn     := { "", 1,"", 1, 1, 1, "",1 }
	PRIVATE lAbortPrint := .F.
	PRIVATE cCabec1     := "Beneficiarios exportados no arquivo"
	PRIVATE cCabec2     := "C๓digo do Beneficiแrio  Nome                                       Validade Cartใo"
	PRIVATE nColuna     := 00
	PRIVATE nOrdSel     := 0
	PRIVATE nTipo		:= GetMv("MV_COMP")
	PRIVATE nHdl
	
	@ 200,1 TO 380,380 DIALOG oLeTxt TITLE OemToAnsi("Leitura de Arquivo Texto")
	@ 02,10 TO 65,180
	@ 10,018 Say " Este programa ira preparar a exporta็ใo do arquivo de cartao  "
	@ 18,018 Say " de identifica็ใo, a fim de inserir e ordenar o arquivo de     "
	@ 26,018 Say " acordo com a necessidade da Caberj.                           "
	@ 70,098 BMPBUTTON TYPE 05 ACTION AjustaSX1(cPerg)
	@ 70,128 BMPBUTTON TYPE 01 ACTION OkLeTxt()
	@ 70,158 BMPBUTTON TYPE 02 ACTION Close(oLeTxt)
	
	Activate Dialog oLeTxt Centered
	
Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFuno    ณ OKLETXT  บ Autor ณ                    บ Data ณ  09/04/03   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescrio ณ Funcao chamada pelo botao OK na tela inicial de processamenบฑฑ
ฑฑบ          ณ to. Executa a leitura do arquivo texto.                    บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Programa principal                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/

Static Function OkLeTxt
	
	Local nCont			:= 0
	
	PRIVATE cNomeArq	:= ""
	PRIVATE nOrdem		:= 0
	
	Pergunte(cPerg,.F.)
	
	cNomeArq	:= mv_par01
	nOrdem		:= mv_par02
	
	If !File(cNomeArq)
		MsgStop("Arquivo Invแlido! Programa encerrado.")
		Close(oLeTxt)
		Return
	End
	
	WnRel   := SetPrint(cAlias,nRel,cPerg,cTitulo,cDesc1,cDesc2,cDesc3,lDicion,aOrdens,lCompres,cTamanho,{},lFiltro,lCrystal)
	
	If nLastKey == 27
		Return
	Endif
	
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Seleciona tabelas...                                                     ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	BA1->(DbSetOrder(2))
	
	//Manda imprimir...
	SetDefault(aReturn,"BA1")
	
	Processa({|| Processa1() }, cTitulo)
	//MsAguarde({|| Processa1() }, cTitulo, "", .T.)
	
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Libera impressao                                                         ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	If  aReturn[5] == 1
		Set Printer To
		Ourspool(nRel)
	End
	
	MS_FLUSH()
	
Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFuno    ณ PROCESSA1บ Autor ณ Jean Schulz        บ Data ณ  23/03/07   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescrio ณ Funcao auxiliar chamada pela PROCESSA.  A funcao PROCESSA  บฑฑ
ฑฑบ          ณ monta a janela com a regua de processamento.               บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Programa principal                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
Static Function Processa1()
	
	Local n_I 			:= 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS
	
	Local aStruc 		:= {}
	Local nLinha 		:= 0
	Local cTipReg		:= ""
	Local aImpCart	:= {}
	Local nCont		:= 0
	Local nCont2		:= 0
	Local cLin			:= ""
	Local cNomeArq2	:= GetNewPar("MV_YDEXCAR","\Interface\Exporta\Cartao\")
	Local cArqTmp		:= ""
	Local cEOL			:= CHR(13)+CHR(10)
	Local nColuna		:= 0
	Local nPos			:= 0
	Local _cTexto 	:= ""
	Local aHeader   	:= {}
	Local aTrailler 	:= {}
	Local aOrdena		:= {}
	Local aImp			:= {}
	Local lPrima		:= .T.
	
	//----------------------------------------------------
	//INICIO - Angelo Henrique - Data: 24/03/2016
	//----------------------------------------------------
	//Variแveis utilizadas no processo de corre็ใo:
	//Data de validade
	//Numero CNS dos dependentes
	//Nome do Tํtular do Beneficiแrio
	//Corre็ใo de Car๊ncia
	//----------------------------------------------------
	Local _ni			:= 0
	Local _aLinha		:= {}
	Local _nx			:= 0
	Local _cMatLt		:= ""
	Local _cNmCns 		:= ""
	Local _cCdDep 		:= ""
	Local _cEmDep 		:= ""
	Local _cMtDep 		:= ""
	Local _cQuery		:= ""
	Local _cTpReg 		:= ""
	Local _cDgDep 		:= ""
	LOcal _cSexo		:= ""
	Local _cCdPla		:= ""
	Local _aArCar		:= GetNextAlias()
	Local _aArCr1		:= GetNextAlias()
	Local _cMtOdo		:= ""
	Local _cVrsao		:= ""
	Local _dDtCar		:= CTOD(" / / ")
	Local _aLine		:= {}
	Local cPlaOdo		:= ""
	Local cAbrang		:= ''
	//----------------------------------------------------
	//FIM - Angelo Henrique - Data: 24/03/2016
	//----------------------------------------------------
	
	Local _lEstFn 	:= .F. //Quando for estaleiro as posi็๕es da carteira sใo alteradas
	
	Private cTrbPos
	
	cNomeArq 	:= Alltrim(cNomeArq)
	nCont 		:= Len(cNomeArq)
	
	ProcRegua(nCont)
	
	While nCont <> 0
		
		IncProc('Analisando arquivo...')
		
		If Substr(cNomeArq,nCont,1)	<> "\"
			cArqTmp := Substr(cNomeArq,nCont,1)+cArqTmp
		Else
			nCont := 0
			Exit
		Endif
		
		nCont--
		
	Enddo
	
	cNomeArq2 += cArqTmp
	
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Criacao do arquivo temporario...                                    ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	aAdd(aStruc,{"CAMPO","C",500,0})
	
	//nHdl := fOpen(cArquivo,68)
	cTrbPos := CriaTrab(aStruc,.T.)
	
	If Select("TrbPos") <> 0
		TrbPos->(dbCloseArea())
	End
	
	DbUseArea(.T.,,cTrbPos,"TrbPos",.T.)
	
	ProcRegua(0)
	
	For n_I := 1 to 5
		IncProc("Atualizando Arquivo...")
	Next
	
	//MsgRun("Atualizando Arquivo...",,{|| PLSAppTmp(),CLR_HBLUE})
	PLSAppTmp()
	
	TRBPOS->(DbGoTop())
	
	If TRBPOS->(EOF())
		MsgStop("Arquivo Vazio!")
		TRBPOS->(DBCLoseArea())
		Close(oLeTxt)
		lRet := .F.
		Return
	End
	
	nTot := TRBPOS->(LastRec())
	
	ProcRegua(nTot)
	
	TRBPOS->(DbGoTop())
	
	While !TRBPOS->(Eof())
		
		nLinha++
		IncProc("Processando Linha ... " + strzero(nLinha,6))
		
		cString := StrTran(TRBPOS->CAMPO,'"',"")
		aadd(aImpCart,cString)
		
		TRBPOS->(DbSkip())
		
	Enddo
	
	//Leonardo Portella - 09/04/12 - Inicio - Pegar a quantidade maxima de colunas
	
	ProcRegua(len(aImpCart))
	
	nTamArrMax 	:= 0
	
	For n_I := 1 to len(aImpCart)
		
		IncProc('Selecionando quantidade mแxima de colunas...')
		
		nPosAnt := 0
		cBuffer := aImpCart[n_I]
		nTamArr	:= 0
		
		While ( ( nPosAnt := At(';',cBuffer) ) > 0 )
			nTamArr++
			cBuffer := Substr(cBuffer,nPosAnt + 1,len(cBuffer))
		EndDo
		
		nTamArrMax := If(nTamArrMax < nTamArr, nTamArr, nTamArrMax)
		
	Next
	
	nTamArrMax := If(nTamArrMax < 23,23,nTamArrMax)
	
	//Leonardo Portella - 09/04/12 - Fim
	
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Montar array para ordenacao conforme solicitado...                       ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	
	ProcRegua(Len(aImpCart))
	
	nColuna	:= 0
	For nCont := 1 to Len(aImpCart)
		
		IncProc('Processando...')
		
		nColuna := 0
		cCodPla := ""
		While .T.
			nPos := At(";",aImpCart[nCont])
			If nPos > 0
				nColuna ++
				
				//Leonardo Portella - 09/04/12 - Inicio - Dimensionar o array aOrdena dinamicamente pois o seu tamanho pode variar, visto que vem da rotina padrao para
				//gerar o lote de carteirinhas e a quantidade de itens separados por ';' no txt pode variar. Apesar disto, esta rotina pega apenas os itens que
				//interessam, os excedentes serao carregados no vetor e nao serao utilizados. Mantem a ordem da coluna.
				
				If nColuna == 1
					
					aAdd(aOrdena,Array(nTamArrMax))
					
					For n_I := 1 to nTamArrMax
						aOrdena[nCont][n_I] := If(n_I == 1,Substr(aImpCart[nCont],1,nPos-1),"")
					Next
					
					//aAdd(aOrdena,{Substr(aImpCart[nCont],1,nPos-1),"","","","","","","","","","","","","","","","","","","",""})
					
					//Leonardo Portella - 09/04/12 - Fim
					
				Else
					//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
					//ณ Corrigir grafia caso coluna de acomodacao apresente-se com nome incompl. ณ
					//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
					If nColuna == 10 .And. (Substr(aImpCart[nCont],1,nPos-1) $ "APARTAMENT|INDIVIDUAL")
						aOrdena[Len(aOrdena),nColuna] := "ACOMODAวรO INDIVIDUAL"
						//ElseIf nColuna == 10 .And. (Substr(aImpCart[nCont],1,nPos-1) == "COLETIVO") -- Angelo Henrique - Data:14/04/2016
					ElseIf nColuna == 10 .And. (Substr(aImpCart[nCont],1,nPos-1) $ "COLETIVO|COLETIVA")
						aOrdena[Len(aOrdena),nColuna] := "ACOMODACAO COLETIVA"
					ElseIf nColuna == 08
						cCodPla := AllTrim(Substr(aImpCart[nCont],1,nPos-1))
						aOrdena[Len(aOrdena),nColuna] := Substr(aImpCart[nCont],1,nPos-1)
					ElseIf nColuna == 09
						//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
						//ณ Posiciona Produto do usuario... 									ณ
						//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
						aOrdena[Len(aOrdena),nColuna] := Substr(aImpCart[nCont],1,nPos-1)
						BI3->(DbSetOrder(1))
						If BI3->(msSeek(xFilial("BI3")+PLSINTPAD()+cCodPla))
							If !Empty(BI3->BI3_DESCAR) .AND. AllTrim(BI3->BI3_DESCAR) != "CABERJ" .AND. AllTrim(BI3->BI3_DESCAR) != "INTEGRAL"
								aOrdena[Len(aOrdena),nColuna] := AllTrim(BI3->BI3_DESCAR)
							EndIf
						Endif
					Else
						aOrdena[Len(aOrdena),nColuna] := Substr(aImpCart[nCont],1,nPos-1)
					Endif
				Endif
				aImpCart[nCont] := Substr(aImpCart[nCont],nPos+1)
			Else
				aOrdena[Len(aOrdena),20] := Alltrim(aImpCart[nCont])
				aImpCart[nCont] := ""
				Exit
			Endif
		Enddo
		
	Next
	
	ProcRegua(Len(aOrdena))
	
	For nCont := 1 to Len(aOrdena)
		
		IncProc('Processando...')
		
		_cTexto := space(0)
		cCodBAT := alltrim(aOrdena[nCont,17])
		
		If cCodBAT $ "SEM CARENCIA"
			_cTexto := "SEM CARENCIA"
			aOrdena[nCont,20] := _cTexto
		ElseIf At("_0",cCodBat) > 0 .or. At("_1",cCodBat) > 0 .or. At("_2",cCodBat) > 0 .or. At("_3",cCodBat) > 0 .or. SubStr(cCodBat,1,1) $ "0/1/2/3/4/5/6/7/8/9"
			nElem := 11
			nElem2 := 20
			While .T.
				_cCodCar := SubStr(alltrim(cCodBat),1,3)
				If !Empty(_cCodCar)
					BAT->(dbsetOrder(1))
					If BAT->(msSeek(xFilial("BAT")+PLSINTPAD()+_cCodCar))
						//Bianchini - 14/10/2014
						//_cTexto := _cTexto + Alltrim(BAT->BAT_DESCRI) + " ATE "+ aOrdena[nCont,nElem]  //+";"
						_cTexto := Alltrim(BAT->BAT_DESCRI) + " ATE "+ aOrdena[nCont,nElem]
					EndIf
				Endif
				npos := at("_",Alltrim(cCodBAT))
				If npos > 0
					cCodBAT := SubStr(Alltrim(cCodBAT),at("_",cCodBAT)+1)
					//			EndIf
					//			If Empty(Alltrim(cCodBat))
				Else
					Exit
				EndIf
				//Bianchini - 14/10/2014
				//_cTexto := _cTexto +";"
				aOrdena[nCont,nElem] := _cTexto
				nElem := nElem + 1
				nElem2 := nElem2 + 1
			EndDo
			//Bianchini - 14/10/2014
			//aOrdena[nCont,20] := _cTexto
		EndIf
		aOrdena[nCont,17] := ""
	Next
	
	aImpCart := {}
	
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Ordenar array...                                                         ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	ProcRegua(Len(aOrdena))
	
	If nOrdem == 1
		//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
		//ณ Buscar de BA1 o campo YLOTAC para realizar a ordenacao Itau.             ณ
		//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
		BA1->(DbSetOrder(2))
		For nCont := 1 to Len(aOrdena)
			
			IncProc("Ajustando registro "+StrZero(nCont,6)+" de "+StrZero(Len(aOrdena),6))
			
			cCodBA1 := StrTran(aOrdena[nCont,7],".","")
			cCodBA1	:= StrTran(cCodBA1,"-","")
			
			If BA1->(MsSeek(xFilial("BA1")+cCodBA1))
				aOrdena[nCont,21] := BA1->BA1_YLOTAC
				aOrdena[nCont,6]  := AllTrim(BA1->BA1_NOMUSR)
			Else
				MsgAlert("Nใo foi encontrado o usuario: "+aOrdena[nCont,7]+" no cadastro. Verifique!")
			Endif
			
		Next
		cCabec2     := "Lotacao           C๓digo do Beneficiแrio  Nome                                       Validade Cartใo"
		
		//Leonardo Portella - 20/12/12 - Comentado ELSE para nao exibir a mensagem de debug ao usuario
		//Bianchini - 13/08/2014 - Descomentado ELSE e implementado a fim de atender uma necessidade dos estaleiros que estao entrando. Matricula Funcional
		//            Estou implemtando para que seja criada mais uma dimensao ARRAY aOrdena contendo a Funcional do BA1 (BA1_MATEMP)
	Else
		//MsgAlert("Ponto para ser escrita a l๓gica da ordem nro 2 para a rotina de ajuste de cartใo!")
		//If (cEmpAnt =='02' .and. aOrdena[1,2] $ GetMv("MV_CARCOFU"))  //Apenas empresas do Estaleiro. Sugiro um MV_PAR.
		
		For nCont := 1 to Len(aOrdena)
			
			IncProc("Ajustando registro "+StrZero(nCont,6)+" de "+StrZero(Len(aOrdena),6))
			
			cCodBA3  := StrTran(aOrdena[nCont,7],".","")
			cCodBA3	 := StrTran(cCodBA3,"-","")
			cCodBA3	 := Substr(cCodBA3,1,14)
			
			cCodBA1  := StrTran(aOrdena[nCont,7],".","")
			cCodBA1	 := StrTran(cCodBA1,"-","")
			
			cCodBA1T := cCodBA3+'00'
			
			//BIANCHINI - Posiciono na BA3 para ajustar PLANO, NOME DE CARTEIRA DO SUBCONTRATO e FUNCIONAL NO ARRAY aOrdena
			BA3->(DbSetOrder(1))
			BA3->(MsSeek(xFilial("BA3")+cCodBA3))
			
			BQC->(DbSetOrder(1))//BQC_FILIAL + BQC_CODIGO + BQC_NUMCON + BQC_VERCON + BQC_SUBCON + BQC_VERSUB
			BQC->(MsSeek(xFilial("BQC") + BA3->(BA3_CODINT + BA3_CODEMP + BA3_CONEMP + BA3_VERCON + BA3_SUBCON + BA3_VERSUB)))
			
			aOrdena[nCont,3] := TRIM(BQC->BQC_NOMCAR)
			
			//---------------------------------------------------------------------------------------------------------
			//Inicio - Angelo Henrique - data:27/07/2016
			//---------------------------------------------------------------------------------------------------------
			//Alterado para contemplar o plano no nํvel do usuแrio, corrigindo assim
			//a situa็ใo dos planos da prefeitura, onde o tํtular possui plano diferente do dependente
			//em alguns casos
			//---------------------------------------------------------------------------------------------------------
			//aOrdena[nCont,9] := TRIM(Posicione("BI3", 1, xFilial("BI3")+BA3->(BA3_CODINT+BA3_CODPLA), "BI3_DESCRI"))
			
			BA1->(DbSetOrder(2))
			BA1->(MsSeek(xFilial("BA1")+cCodBA1))
			
			//			aOrdena[nCont,9] := AllTrim(Posicione("BI3", 1, xFilial("BI3")+BA1->(BA1_CODINT+BA1_CODPLA), "BI3_DESCRI"))   -- altamiro - 23/11/2016 - chamado 32716 e 32717
			aOrdena[nCont,9] := AllTrim(Posicione("BI3", 1, xFilial("BI3")+BA1->(BA1_CODINT+BA1_CODPLA), "BI3_DESCAR"))
			
			//-----------------------------------------------------------------------------------
			// Inicio - Angelo Henrique - Data:08/04/2016
			//-----------------------------------------------------------------------------------
			//Ap๓s a reuniใo das regras de inadimpl๊ncia a sequencia abaixo deixa de valer
			//----------------------------------------------6-------------------------------------
			/*
			If !empty(DTOS(BA1->BA1_YDTLIM)) .AND. !empty(DTOS(BA1->BA1_DTVLCR)) .AND. BA1->BA1_YDTLIM < BA1->BA1_DTVLCR
				
				//Leonardo Portella - 02/04/15 - Inicio - Transformar para string pois este vetor sera
				//usado para concatenar com string.
				
				//aOrdena[nCont,4]  := BA1->BA1_YDTLIM
				//aOrdena[nCont,14] := BA1->BA1_YDTLIM
				aOrdena[nCont,4]  := DtoC(BA1->BA1_YDTLIM)
				aOrdena[nCont,14] := DtoC(BA1->BA1_YDTLIM)
				
				//Leonardo Portella - 02/04/15 - Fim
				
			Endif
			*/
			//-----------------------------------------------------------------------------------
			// Fim - Angelo Henrique - Data:08/04/2016
			//-----------------------------------------------------------------------------------
			
			//Sobrescrevo o nome do Dependente de acordo com a Matricula. O Padrao monta errado de forma Intermitente
			aOrdena[nCont,6]  := AllTrim(BA1->BA1_NOMUSR)
			aAreaBA1 := BA1->(GetArea())
				//Sobrescrevo o nome do Titular de acordo com a Matricula. O Padrao monta errado de forma Intermitente
				BA1->(DbSetOrder(2))
				BA1->(MsSeek(xFilial("BA1")+cCodBA1T))
				
				aOrdena[nCont,5]  := AllTrim(BA1->BA1_NOMUSR)
			RestArea(aAreaBA1)
			//	If (cEmpAnt =='02' .and. aOrdena[1,2] $ GetMv("MV_CARCOFU"))  //Apenas empresas do Estaleiro. Sugiro um MV_PAR.
			//Roberto Meirelles - 11/08/2015(Carteira do Estaleiro com Funcional na CABERJ)
			If (cEmpAnt $'01|02' .and. aOrdena[1,2] $ GetMv("MV_CARCOFU"))  //Apenas empresas do Estaleiro na CABERJ. Sugiro um MV_PAR.
				If !EMPTY(BA3->BA3_MATEMP)//BA3->(MsSeek(xFilial("BA3")+cCodBA3))
					aadd(aOrdena[nCont],TRIM(BQC->BQC_DESCRI))
					aadd(aOrdena[nCont],TRIM(BA3->BA3_MATEMP))
					
					_lEstFn := .T.
					
				Else
					MsgAlert("Nใo foi encontrado o usuario: "+aOrdena[nCont,7]+" no cadastro. Verifique!")
				Endif
				
			Endif
			
			//BIANCHINI -> 03/02/2015 - Inclusao de coluna com a Rede do Plano
			cSQL := " SELECT BB6_CODRED CODRED "
			cSQL += "      , TRIM(BI5_DESCRI) DESRED "
			cSQL += "   FROM " +RetSqlName("BB6")+ " BB6 "
			cSQL += "      , " +RetSqlName("BI5")+ " BI5 "
			cSQL += "  WHERE BB6_FILIAL = '"+xFilial("BB6")+"'"
			cSQL += "    AND BI5_FILIAL = '"+xFilial("BI5")+"'"
			cSQL += "    AND BB6_CODIGO = '" + BA3->(BA3_CODINT+BA3_CODPLA) + "'"
			cSQL += "    AND BB6_ATIVO = '1' "
			cSQL += "    AND BB6_CODRED = BI5_CODRED "
			cSQL += "    AND BB6.D_E_L_E_T_ = ' ' "
			cSQL += "    AND BI5.D_E_L_E_T_ = ' ' "
			
			PlsQuery(cSQL, "TRBRED")
			
			If !Empty(TRBRED->DESRED)
				aadd(aOrdena[nCont],TRIM(TRBRED->DESRED))
			Else
				aadd(aOrdena[nCont],'')
			Endif
			
			TRBRED->(DbCloseArea())
			
			//SERGIO CUNHA -> 05/01/2016 - Inclusao de coluna CNS - CARTAO NACIONAL DE SAUDE
			
			cSQL := " SELECT SUBSTR(TRIM(BTS_NRCRNA),1,3)||' '||SUBSTR(TRIM(BTS_NRCRNA),4,4)||' '||SUBSTR(TRIM(BTS_NRCRNA),8,4)||' '||SUBSTR(TRIM(BTS_NRCRNA),12,4) NUMCNS "
			cSQL += " FROM " +RetSqlName("BTS")+ " BTS "
			cSQL += " WHERE BTS_FILIAL = '" + BA1->(BA1->BA1_FILIAL) + "'"
			cSQL += " AND TRIM(BTS_MATVID) = '" + BA1->(BA1->BA1_MATVID) +   "'"
			cSQL += " AND BTS.D_E_L_E_T_ <> '*'                          "
			
			
			PlsQuery(cSQL, "TRBCNS")
			
			If !Empty(TRBCNS->NUMCNS)
				aadd(aOrdena[nCont],TRIM(TRBCNS->NUMCNS))
			Else
				aadd(aOrdena[nCont],'')
			Endif
			
			TRBCNS->(DbCloseArea())
			
			
			//BIANCHINI -> 09/04/2015 - Inclusao de coluna com TEXTO "EMERGENCIA DOMICILIAR - 3233-1020" baseado no opcional ADU
			cCodint		:=	BA1->BA1_CODINT
			cCodemp		:=	BA1->BA1_CODEMP
			cMatric		:=	BA1->BA1_MATRIC
			cTipreg		:=	BA1->BA1_TIPREG
			cConemp		:=	BA1->BA1_CONEMP
			cVercon		:=	BA1->BA1_VERCON
			cSubcon		:=	BA1->BA1_SUBCON
			cVersub		:=	BA1->BA1_VERSUB
			cCodpla		:=	BA3->BA3_CODPLA
			_cMtOdo     :=  BA1->BA1_YMTODO // Mateus Medeiros - 25/09/2017
			cVerpla		:=	BA3->BA3_VERSAO
			cOpcional	:=	'0023'
			cVeropc		:=	'001'
			
			If u_ChkOpc(cCodint, cCodemp, cMatric, cTipreg, cConemp, cVercon, cSubcon, cVersub, cCodpla, cVerpla, cOpcional, cVeropc)
				aadd(aOrdena[nCont],GetMV("MV_YMSGADU"))
			Else
				aadd(aOrdena[nCont],'')
			Endif
			If BA1->(FieldPos("BA1_YNMSOC")) > 0
				If !Empty(BA1->BA1_YNMSOC) //Nome Social
					aadd(aOrdena[nCont],BA1->BA1_YNMSOC)
				Else
					aadd(aOrdena[nCont],'')
				Endif
			Endif
			BI3->(DbSetOrder(1))
			If BI3->(msSeek(xFilial("BI3")+PLSINTPAD()+cCodPla))
				
				cSusep  := AllTrim(BI3->BI3_SUSEP)
				If cPlaOdo <> "004"
				aadd(aOrdena[nCont],Alltrim(cSusep))
				EndIf
				cPlaOdo := AllTrim(BI3->BI3_CODSEG) // 0004 - ODONTO
				cAbrang := AllTrim(BI3->BI3_ABRANG) // TIPO DE ABRANGENCIA
			Endif
			
			If cEmpAnt == '01' .And. cCodEmp $ GetMV("MV_YEPFRIO")
				
				If cCodEmp $ GetMV("MV_YEPFRIO") .AND. BA1->(FieldPos("BA1_YMTODO")) > 0
				
					//PRECISA REVER PARA AS DEMAIS EMPRESAS
					cSQL := " SELECT MAT_ODO.BA1_CODINT||MAT_ODO.BA1_CODEMP||MAT_ODO.BA1_MATRIC||MAT_ODO.BA1_TIPREG||MAT_ODO.BA1_DIGITO MAT_ODONT "
					cSQL += "      , TRIM(MAT_ODO.BA1_YDPLAP) PLANO_ODONTO "
					cSQL += "      FROM 									"
					cSQL += "      (    									"
					cSQL += "      SELECT *			  "
					cSQL += "      FROM BA1010 		  "
					cSQL += "      WHERE BA1_FILIAL = ' ' "
					cSQL += "      AND BA1_CODEMP = '0024' "
					cSQL += "      AND BA1_CONEMP = '000000000001' "
					cSQL += "      AND BA1_SUBCON = '000000001' "
					cSQL += "      AND D_E_L_E_T_ = ' '  "
					cSQL += "      ) MAT_MED,            "
					cSQL += "      (                     "
					cSQL += "      SELECT *              "
					cSQL += "      FROM BA1010           "
					cSQL += "      WHERE BA1_FILIAL = ' ' "
					cSQL += "      AND BA1_CODEMP = '0024' "
					cSQL += "      AND BA1_CONEMP = '000000000001' "
					cSQL += "      AND BA1_SUBCON = '000000002'    "
					cSQL += "      AND D_E_L_E_T_ = ' '  "
					cSQL += "      ) MAT_ODO             "
					cSQL += "      WHERE MAT_MED.BA1_YMTODO = MAT_ODO.BA1_CODINT||MAT_ODO.BA1_CODEMP||MAT_ODO.BA1_MATRIC||MAT_ODO.BA1_TIPREG||MAT_ODO.BA1_DIGITO   "
					cSQL += "      AND MAT_MED.BA1_CODINT = '"+cCodint+"'"
					cSQL += "      AND MAT_MED.BA1_CODEMP = '"+cCodemp+"'"
					cSQL += "      AND MAT_MED.BA1_MATRIC = '"+cMatric+"'"
					cSQL += "      AND MAT_MED.BA1_TIPREG = '"+cTipreg+"'"
					
					PlsQuery(cSQL, "TRBODO")
					
					aadd(aOrdena[nCont],Transform(TRIM(TRBODO->PLANO_ODONTO),PesqPict("BA1","BA1_YMTODO")))
					
					TRBODO->(DbCloseArea())
					
				EndIf
				
				//------------------------------------------------------------------------
				// Mateus Medeiros - 22/09/2017
				// Tratamento para Odonto MetLife
				// TRATAMENTO PARA INFORMAวรO DE DADOS DO PLANO ODONTOLOGICO METLIFE
				// A MATRICULA ODONTOLOGICA ESTARม NA MESMA TUPLA DA MATRICULA MษDICA
				// NO CAMPO BA1_YMTODO - ODONTO NO PRODUTO = 004
				//------------------------------------------------------------------------
			ElseIf  cPlaOdo == "004"/*cCodEmp $ SuperGetMV("MV_YEPMTLF",,"5007")*/ .AND. BA1->(FieldPos("BA1_YMTODO")) > 0 .AND. cEmpAnt == '01'
				
				aadd(aOrdena[nCont],Transform(Alltrim(_cMtOdo),PesqPict("BA1","BA1_YMTODO")))
				aadd(aOrdena[nCont],Alltrim(cSusep))
				
				cQuery := ""
				// VALIDA CำDIGO DOS PLANOS DENTAL INTEGRAL
			ElseIf !Empty(_cMtOdo) .and. BA1->(FieldPos("BA1_YMTODO")) > 0 .AND. cEmpAnt == '02'
				
				aadd(aOrdena[nCont],Transform(Alltrim(_cMtOdo),PesqPict("BA1","BA1_YMTODO")))
				aadd(aOrdena[nCont],Alltrim(cSusep))
				
				cQuery := ""
				// Fim Mateus Medeiros -  22/09/2017
			Endif
			
			// Tipo de abrang๊ncia - 30/07/18 
			if !Empty(alltrim(cAbrang)) 
					
				aadd(aOrdena[nCont],Alltrim(GetAdvFVal("BF7","BF7_DESORI",xFilial("BF7")+cAbrang,1)))
			
			endif 
			
		Next
		//cCabec2     := "Lotacao           C๓digo do Beneficiแrio  Nome                                       Validade Cartใo"
		
		////Endif
	Endif
	
	//Leonardo Portella - 21/12/12 - O cartao ja sai ordenado pelo PE PLS264OB visto que a carteirinha pode ser impressa direto na Caberj, sem preparacao do arquivo.
	//aSort(aOrdena,,, { |x,y| x[21]+x[7] < y[21]+y[7] })
	
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Buscar de BA1 o campo YLOTAC para realizar a ordenacao Itau.             ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	
	//If (cEmpAnt =='02' .and. aOrdena[1,2] $ GetMv("MV_CARCOFU"))  //Ordenar Vetor por Subcontrato,Funcional e Matricula
	//Roberto Meirelles - 11/08/2015(Carteira do Estaleiro com Funcional na CABERJ)
	If (cEmpAnt $'01|02' .and. aOrdena[1,2] $ GetMv("MV_CARCOFU"))  //Ordenar Vetor por Subcontrato,Funcional e Matricula
		aSort(aOrdena,,,{|x,y| (x[24])<(y[24]),(x[25])<(y[25]),(x[7])<(y[7]) })
	Else
		aSort(aOrdena,,,{|x,y| (x[7])<(y[7])}) //senao ordena por matriculas de acordo com a familia
	Endif
	
	ProcRegua(Len(aOrdena))
	
	BA1->(DbSetOrder(2))//BA1_FILIAL+BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG+BA1_DIGITO
	
	For nCont := 1 to Len(aOrdena)
		
		IncProc('Processando...')
		
		cString := StrZero(nCont,11)+";"
		
		//Leonardo Portella - 20/12/12 - Inicio - Armazenando dados para exibir a lotacao no relatorio
		
		If cEmpAnt == '01'
			
			cCodBA1 := StrTran(aOrdena[nCont,7],".","")
			cCodBA1	:= StrTran(cCodBA1,"-","")
			
			BA1->(MsSeek(xFilial("BA1") + cCodBA1))
			
			If substr(cCodBA1,5,4) $ '0006|0010'
				
				aAdd(aImp,	{	aOrdena[nCont,7]	,;
					aOrdena[nCont,6]	,;
					aOrdena[nCont,4]	,;
					aOrdena[nCont,21]	,;
					If(BA1->(Found()) .and. !empty(BA1->BA1_YLOTAC),AllTrim(BA1->BA1_YLOTAC) + ' - ' + AllTrim(BA1->BA1_YNOMLO),'-');
					})
				
				If !lLotac .and. ( aImp[len(aImp)][5] <> '-' )
					//Arquivo tem pelo menos uma informacao de lotacao
					lLotac := .T.
				EndIf
				
			Else
				aAdd(aImp,	{	aOrdena[nCont,7]	,;
					aOrdena[nCont,6]	,;
					aOrdena[nCont,4]	,;
					aOrdena[nCont,21]	,;
					"";
					})
				
				
				lLotac := .F.
				
			Endif
			
		Else
			
			//Leonardo Portella - 20/12/12 - Fim
			//Bianchini - Condicao nova para o Estaleiro na Integral
			//Roberto Meirelles - 11/08/2015(Carteira do Estaleiro com Funcional na CABERJ)
			//If (cEmpAnt =='02' .and. aOrdena[1,2] $ GetMv("MV_CARCOFU"))  //Apenas empresas do Estaleiro. Sugiro um MV_PAR.
			If (cEmpAnt $'01|02' .and. aOrdena[1,2] $ GetMv("MV_CARCOFU"))  //Apenas empresas do Estaleiro. Sugiro um MV_PAR.
				aAdd(aImp,{aOrdena[nCont,7],aOrdena[nCont,6],aOrdena[nCont,4],aOrdena[nCont,21],aOrdena[nCont,24]})
			Else //Bianchini - 13/08/2014 - Este aADD era o original
				aAdd(aImp,{aOrdena[nCont,7],aOrdena[nCont,6],aOrdena[nCont,4],aOrdena[nCont,21]})
			Endif
			
			
		EndIf //Leonardo Portella - 20/12/12
		
		//For nCont2 := 2 To (Len(aOrdena[nCont])-1)
		For nCont2 := 2 To Len(aOrdena[nCont])
			//BIANCHINI - 13/10/2014 - GAMBIARRA pra pular dimensoes que foram limpas lแ no bloco da carencia. Fez-se necessario porque
			//                         os dados de carencia foram concatenados numa so dimensao de ARRAY
			//if (nCont2 == 12) .and. (!empty(aOrdena[nCont,nCont2-1])) .and. (empty(aOrdena[nCont,nCont2])) .and. (empty(aOrdena[nCont,nCont2+1]))
			//   nCont2 := nCont2 + 2
			//EndIf
			
			cString+=aOrdena[nCont,nCont2]+";"
			
		Next
		
		aAdd(aImpCart,cString)
		
	Next
	
	cLin := Space(1)+cEOL
	
	//----------------------------------------------------------------
	//Inicio - Angelo Henrique - Data: 23/03/2016
	//----------------------------------------------------------------
	//Colocar data de validade correta
	//pois em alguns casos a rotina padrใo estava se perdendo
	//colocando assim uma data totalmente aleat๓ria, nใo trazendo
	//o que esta gravado no cadastro do beneficiแrio (BA1).
	//----------------------------------------------------------------
	For _ni := 1 To Len(aImpCart)
		
		_aLinha := StrTokArr( Replace(aImpCart[_ni],";","+;"), ";" )
		
		For _nx := 1 to Len(_aLinha)
			
			_cMatLt := Replace(Replace(Replace(_aLinha[_nx],".",""),"-",""),"+","")
			
			If Len(_cMatLt) >= 14
				
				DbSelectArea("BA1")
				DbSetOrder(2)
				If DbSeek(xFilial("BA1") + _cMatLt)
					
					//--------------------------------------------------------------------------
					//Angelo Henrique - Data: 08/08/2016
					//Solicitado para quando for prefeitura deixar com 4 digitos o ano
					//--------------------------------------------------------------------------
					//If BA1->BA1_CODEMP = "0024"
					If BA1->BA1_CODEMP = "0024" .OR. (cEmpAnt == '02' .and.  BA1->BA1_CODEMP = "0325")//SERGIO CUNHA PARA TRATAMENTO DATA DE NASCIMENTO CMB - SOLICITACAO ESTHER
						
						//--------------------------------------------------------------------------------------------
						//Para resolver a limita็ใo de usuแrios que estใo configurados para ter ano com 2 digitos
						//--------------------------------------------------------------------------------------------
						
						_aLinha[4]  := SUBSTR(DTOC(BA1->BA1_DTVLCR),1,2) + "/" + SUBSTR(DTOC(BA1->BA1_DTVLCR),4,2) + "/" + cValToChar(YEAR(BA1->BA1_DTVLCR))
						_aLinha[14] := SUBSTR(DTOC(BA1->BA1_DTVLCR),1,2) + "/" + SUBSTR(DTOC(BA1->BA1_DTVLCR),4,2) + "/" + cValToChar(YEAR(BA1->BA1_DTVLCR))
						_aLinha[15] := SUBSTR(DTOC(BA1->BA1_DATNAS),1,2) + "/" + SUBSTR(DTOC(BA1->BA1_DATNAS),4,2) + "/" + cValToChar(YEAR(BA1->BA1_DATNAS))
						_aLinha[16] := SUBSTR(DTOC(BA1->BA1_DATNAS),1,2) + "/" + SUBSTR(DTOC(BA1->BA1_DATNAS),4,2) + "/" + cValToChar(YEAR(BA1->BA1_DATNAS))
						
					Else
						
						_aLinha[4]  := DTOC(BA1->BA1_DTVLCR)
						_aLinha[16] := DTOC(BA1->BA1_DATNAS)
						
					EndIf
					
					_cCdDep := BA1->BA1_CODINT
					_cEmDep := BA1->BA1_CODEMP
					_cMtDep := BA1->BA1_MATRIC
					_cTpReg := BA1->BA1_TIPREG
					_cDgDep := BA1->BA1_DIGITO
					_cSexo	:= BA1->BA1_SEXO
					_cCdPla := BA1->BA1_CODPLA
					_cMtOdo := BA1->BA1_YMTODO
					_cVrsao := BA1->BA1_VERSAO
					_dDtCar := BA1->BA1_DATCAR
					
					//----------------------------------------------------------
					//Corrigindo o N๚mero CNS
					//----------------------------------------------------------
					//Pois na primeira vez que a rotina alimenta este campo
					//ela preenche o CNS com a informa็ใo do Titular
					//replicando assim esta informa็ใo nos dependentes
					//----------------------------------------------------------
					If Len(_aLinha) >=17
						
						DbSelectArea("BTS")
						DbSetOrder(1)
						If DbSeek(xFilial("BTS") + BA1->BA1_MATVID)
							
							_cNmCns := SUBSTR(TRIM(BTS->BTS_NRCRNA),1,3)
							_cNmCns += " " + SUBSTR(TRIM(BTS->BTS_NRCRNA),4,4)
							_cNmCns += " " + SUBSTR(TRIM(BTS->BTS_NRCRNA),8,4)
							_cNmCns += " " + SUBSTR(TRIM(BTS->BTS_NRCRNA),12,4)
							
							//-------------------------------------------------------------------------
							//Valida็ใo, para corre็ใo da montagem da carteira
							//Alguns beneficiแrios estavam saindo sem CNS, nesno estando na base
							//O arquivo no padrใo nใo estava alimentando esses beneficiแrios
							//-------------------------------------------------------------------------
							
							If _lEstFn //Estaleiro as posi็๕es sใo alteradas
								
								_aLinha[27] := _cNmCns
								
							Else
								
								_aLinha[25] := _cNmCns
								
							EndIf
							
							//-----------------------------------------------------------------------------------
							//Nome do tํtular estava vindo em branco, causando problemas para identifica็ใo
							//do registro, no momento de mandar para a grแfica e para a gera็ใo de carteiras.
							//-----------------------------------------------------------------------------------
							If Empty(Replace(Replace(_aLinha[5],"-",""),"+",""))
								
								DbSelectArea("BA1")
								DbSetOrder(1)
								If DbSeek(xFilial("BA1") + _cCdDep + _cEmDep + _cMtDep + "T")
									
									_aLinha[5] := AllTrim(BA1->BA1_NOMUSR) //Nome do Tํtular
									
								EndIf
								
							EndIf
							
							//----------------------------------------------
							//Validando  car๊ncia
							//----------------------------------------------
							//Posi็๕es das car๊ncias:
							//[11] [12] [13] - Atualmente
							//s๓ esta vindo as datas e nใo as descri็๕es
							//----------------------------------------------
							
							//If !Empty(Replace(_aLinha[11],"-",""))
							
							//-----------------------------------------------
							//Limpando as informa็๕es das car๊ncias
							//para que venham as datas corretas no arquivo
							//-----------------------------------------------
							_aLinha[11] := ""
							_aLinha[12] := ""
							_aLinha[13] := ""
							
							//---------------------------------------------------
							//Valida็ใo para saber se ้ CABERJ ou INTEGRAL
							//---------------------------------------------------
							If cEmpAnt == "01" //CABERJ
								
								//-------------------------------------------------------------------
								//Fun็ใo CARENCIA_BENEF
								//Responsแvel pela pelo retorno das car๊ncias dos beneficiแrios
								//o resultado vem em uma string separadas por pipe (||)
								//-------------------------------------------------------------------
								_cQuery := " SELECT " + c_ent
								_cQuery += "	CARENCIA_BENEF('CABERJ','" + _cCdDep + _cEmDep + _cMtDep + _cTpReg + _cDgDep + "',3) CARENC" + c_ent
								_cQuery += " FROM DUAL " + c_ent
								
								If Select(_aArCar) > 0
									dbSelectArea(_aArCar)
									dbCloseArea()
								EndIf
								
								dbUseArea(.T.,"TOPCONN",TcGenQry(,,_cQuery),_aArCar,.T.,.T.)
								
								While (_aArCar)->(!Eof())
									
									//-------------------------------------------------------------
									//Fun็ใo criada pelo portela, irแ encaminhar as car๊ncias
									//separadas por ||(Pipe)
									//-------------------------------------------------------------
									_aLine := Separa((_aArCar)->CARENC,'|',.T.)
									
									If !Empty(_aLine[1])
										
										_aLinha[11] := AllTrim(_aLine[1])
										
										If Len(_aLine) > 1
											
											_aLinha[12] := AllTrim(_aLine[2])
											
										EndIf
										
										If Len(_aLine) > 2
											
											_aLinha[13] := AllTrim(_aLine[3])
											
										EndIf
										
									EndIf
									
									(_aArCar)->(DbSkip())
									
								EndDo
								
								If Select(_aArCar) > 0
									dbSelectArea(_aArCar)
									dbCloseArea()
								EndIf
								
							ElseIf cEmpAnt == "02" //INTEGRAL
								
								//-------------------------------------------------------------------
								//Fun็ใo CARENCIA_BENEF
								//Responsแvel pela pelo retorno das car๊ncias dos beneficiแrios
								//o resultado vem em uma string separadas por pipe (||)
								//-------------------------------------------------------------------
								_cQuery := " SELECT " + c_ent
								_cQuery += "	CARENCIA_BENEF('INTEGRAL','" + _cCdDep + _cEmDep + _cMtDep + _cTpReg + _cDgDep + "',3) CARENC" + c_ent
								_cQuery += " FROM DUAL " + c_ent
								
								If Select(_aArCar) > 0
									dbSelectArea(_aArCar)
									dbCloseArea()
								EndIf
								
								dbUseArea(.T.,"TOPCONN",TcGenQry(,,_cQuery),_aArCar,.T.,.T.)
								
								While (_aArCar)->(!Eof())
									
									//-------------------------------------------------------------
									//Fun็ใo criada pelo portela, irแ encaminhar as car๊ncias
									//separadas por ||(Pipe)
									//-------------------------------------------------------------
									_aLine := Separa((_aArCar)->CARENC,'|',.T.)
									
									If !Empty(_aLine[1])
										
										_aLinha[11] := AllTrim(_aLine[1])
										
										If Len(_aLine) > 1
											
											_aLinha[12] := AllTrim(_aLine[2])
											
										EndIf
										
										If Len(_aLine) > 2
											
											_aLinha[13] := AllTrim(_aLine[3])
											
										EndIf
										
									EndIf
									
									(_aArCar)->(DbSkip())
									
								EndDo
								
								If Select(_aArCar) > 0
									dbSelectArea(_aArCar)
									dbCloseArea()
								EndIf
								
							EndIf
							
							//EndIf
							
							//----------------------------------------------------------------
							//Verificando opcionais (ADU) - Codigo 0023
							//Tendo em vista que foi solicitado essa valida็ใo para
							//os seguintes planos:
							// - Mater Basico 	- 0004
							// - Mater Basico I 	- 0064
							//----------------------------------------------------------------
							//No arquivo ele fica na posi็ใo 26
							//----------------------------------------------------------------
							If !Empty(Replace(Replace(_aLinha[26],"-",""),"+","")) .And. _cCdPla $ ("0004|0064")
								
								_cQuery := "SELECT BF4.BF4_MATRIC, BF4.BF4_CODPRO, BZX.BZX_MATRIC, BZX.BZX_CODOPC  "	+ c_ent
								_cQuery += "FROM " + RetSqlName('BF4') + " BF4, " + RetSqlName('BZX') + " BZX "			+ c_ent
								_cQuery += "WHERE BF4.D_E_L_E_T_ = ' '" 														+ c_ent
								_cQuery += "	AND BZX.D_E_L_E_T_ = ' '" 														+ c_ent
								_cQuery += "	AND BF4.BF4_FILIAL = '" + xFilial('BF4')  + "'"								+ c_ent
								_cQuery += "	AND BZX.BZX_FILIAL = '" + xFilial('BZX')  + "'"								+ c_ent
								_cQuery += "	AND BF4.BF4_CODINT = '" + _cCdDep 			+ "'"  							+ c_ent
								_cQuery += "	AND BF4.BF4_CODEMP = '" + _cEmDep			+ "'" 								+ c_ent
								_cQuery += "	AND BF4.BF4_MATRIC = '" + _cMtDep			+ "'" 								+ c_ent
								_cQuery += "	AND BF4.BF4_TIPREG = '" + _cTpReg			+ "'" 								+ c_ent
								_cQuery += "	AND BF4.BF4_MOTBLO = ' '" 		   												+ c_ent
								_cQuery += "	AND BF4.BF4_CODPRO = '0023'"	   												+ c_ent
								_cQuery += "	AND BZX.BZX_CODOPC = BF4.BF4_CODPRO "	   										+ c_ent
								_cQuery += "	AND BZX.BZX_CODOPE = BF4.BF4_CODINT "	   										+ c_ent
								_cQuery += "	AND BZX.BZX_CODEMP = BF4.BF4_CODEMP "	   										+ c_ent
								_cQuery += "	AND BZX.BZX_MATRIC = BF4.BF4_MATRIC "	   										+ c_ent
								_cQuery += "	AND BZX.BZX_TIPREG = BF4.BF4_TIPREG "	   										+ c_ent
								_cQuery += "	AND BZX.BZX_VALFAI <> 0 "	   													+ c_ent
								
								If Select(_aArCr1) > 0
									dbSelectArea(_aArCr1)
									dbCloseArea()
								EndIf
								
								dbUseArea(.T.,"TOPCONN",TcGenQry(,,_cQuery),_aArCr1,.T.,.T.)
								
								//----------------------------------------------------
								//Caso nใo ache este opcional no nivel do usuแrio
								//serแ zerada a linha, assim nใo gerando incorreto.
								//----------------------------------------------------
								If (_aArCr1)->(Eof())
									
									_aLinha[26] := ""
									
								EndIf
								
								If Select(_aArCr1) > 0
									dbSelectArea(_aArCr1)
									dbCloseArea()
								EndIf
								
							EndIf
							
							//-------------------------------------------------------------------
							//Angelo Henrique - Data: 10/08/2016
							//-------------------------------------------------------------------
							//Validando se o plano tem vinculo com o ADU
							//no processo da prefeitura e coligadas
							//-------------------------------------------------------------------
							If _cEmDep $ "0024|0025|0027|0028" .And. cEmpAnt == "01"
								
								DbSelectArea("BT3")
								DbSetOrder(1) //BT3_FILIAL+BT3_CODIGO+BT3_VERSAO+BT3_CODPLA+BT3_VERPLA
								If DbSeek(xFilial("BT3") + _cCdDep + _cCdPla + _cVrsao + "0023" )
									
									If BT3->BT3_TIPVIN != "1"
										
										_aLinha[26] := ""
										
									Else
										
										_aLinha[26] := GetMV("MV_YMSGADU") //Mensagem do ADU
										
									EndIf
									
								EndIf
								
							EndIf
							
							//-----------------------------------------------------
							//Angelo Henrique - Data: 01/07/2016
							//-----------------------------------------------------
							//Chamado 28857 - Contratos Reciprocidade
							//Deve-se remover a mensagem de ADU
							//-----------------------------------------------------
							If _cEmDep == "0004" .And. cEmpAnt == "01"
								
								For _nA := 1 to Len(_aLinha)
									
									If AT("EMERGENCIA", ALLTRIM(UPPER(_aLinha[_nA]))) > 0
										
										_aLinha[_nA] := ""
										
									EndIf
									
								Next _nA
								
							EndIf
							
							
							//---------------------------------------------------------------------
							//Corrigindo a palavra acomoda็ใo pois o cadastro toda vez que vai
							//gerar a carteira, tem que corrigir antes de imprimir
							//---------------------------------------------------------------------s
							_aLinha[10] := Replace(_aLinha[10],'ว','C')
							_aLinha[10] := Replace(_aLinha[10],'ร','A')
							
							/*
							//----------------------------------------------------------------------
							//Inicio do processo de corre็ใo carteiras Odontol๓gicas Prefeitura
							//----------------------------------------------------------------------
							If cEmpAnt == "01" .And. AllTrim(_cEmDep) $ "0024|0025|0027|0028" .And. !Empty(_cMtOdo) //Prefeitura
								
								//Colocando Valida็ใo, pois em alguns casos o array vai at้ a posi็ใo 27
								If Len(_aLinha) > 28 .OR. Len(_aLinha) = 28
									
									_aLinha[28] := "" //Limpando esta posi็ใo
									
								EndIf
								BA1->(DbGoTop())
								
								DbSelectArea("BA1")
								DbSetORder(2)
								If DbSeek(xFilial("BA1") + _cMtOdo)
									
									_aLinha[27] := AllTrim(BA1->BA1_YDPLAP)
									
								EndIf
								
							EndIf
							*/
							
							//------------------------------------------------------
							//Angelo henrique - data: 20/07/2016
							//Novo layout da carteira para prefeitura
							//------------------------------------------------------
							If cEmpAnt == "01" .And. AllTrim(_cEmDep) $ "0024|0025|0027|0028"
								
								If Len(_aLinha) > 28 .OR. Len(_aLinha) = 28
									
									_aLinha[28] := "" //Limpando esta posi็ใo
									
								EndIf
								
								_aLinha[27] := ""
								
								BI3->(DbGoTop())
								
								DbSelectArea("BI3")
								DbSetORder(1)
								If DbSeek(xFilial("BI3") + _cCdDep + _cCdPla)
									
									If BI3->BI3_CODSEG == "013"
										
										_aLinha[27] := "SEGMENTACAO: AMB/HOSP/OBST/ODONTO"
										
									Else
										
										DbSelectArea("BI6")
										DbSetORder(1)
										If DbSeek(xFilial("BI6") + BI3->BI3_CODSEG)
											
											_aLinha[27] := "SEGMENTACAO: " + AllTrim(BI6->BI6_DESCRI)
											
										EndIf
										
									EndIf
									
								EndIf
								
								aAdd(_aLinha, "SUJEITO A ELEGIBILIDADE")
								
							EndIf
							
							//-----------------------------------------------------------------------------------
							//Zerando para colocar as posi็๕es corretas
							//-----------------------------------------------------------------------------------
							aImpCart[_ni] := ""
							
							For _nk := 1 To Len(_aLinha)
								
								aImpCart[_ni] += Replace(_aLinha[_nk],"+","") + ";"
								
							Next _nk
							
							Exit
							
						EndIf
						
					EndIf
					
					Exit
					
				EndIf
				
			EndIf
			
		Next
		
	Next _ni
	//----------------------------------------------------------------
	//Fim - Angelo Henrique - Data: 23/03/2016
	//----------------------------------------------------------------
	
	If U_Cria_TXT(cNomeArq2)
		
		ProcRegua(Len(aImpCart))
		
		For nCont := 1 to Len(aImpCart)
			
			IncProc('Gravando...')
			
			If !(U_GrLinha_TXT(aImpCart[nCont],cLin))
				MsgAlert("ATENวรO! NรO FOI POSSอVEL GRAVAR CORRETAMENTE O CONTEฺDO! OPERAวรO ABORTADA!")
				Return
			Endif
			
		Next
		
		U_Fecha_TXT()
		
		//--------------------------------------------------------------------||
		//Angelo Henrique - Data: 16/10/2015 - Chamado: 19693					||
		//--------------------------------------------------------------------||
		//Rotina que irแ separar por bairro os dados								||
		//--------------------------------------------------------------------||
		//Parametros:																	||
		//--------------------------------------------------------------------||
		// 1 - Nome do arquivo														||
		// 2 - Array contendo os dados a serem filtrados 						||
		//--------------------------------------------------------------------||
		If MSGYESNO("Deseja gerar arquivos separados por lote de localiza็ใo?", "Gera็ใo em lote/localiza็ใo")
			
			u_PREPCAR2(cNomeArq2,aImpCart)
			
		EndIf
		
	Endif
	
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Impressao do protocolo de exportacao.	  ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	
	ProcRegua(Len(aImp))
	
	If lLotac
		cCabec2 += '   Lotacao'
	EndIf
	
	For nCont := 1 To Len(aImp)
		
		IncProc('Gerando arquivo...')
		
		If nLin > nQtdLin
			nLin := Cabec(cTitulo,cCabec1,cCabec2,cNomeProg,cTamanho,nTipo)
		Endif
		
		If lPrima
			@ nLin,000 PSay "Arquivo a ser enviado: " + cNomeArq2
			nLin++
			lPrima := .F.
		Endif
		
		If nOrdem == 1
			@ nLin,000 PSay aImp[nCont,4]+Space(3)+aImp[nCont,1]+Space(3)+aImp[nCont,2]+Space(40-Len(aImp[nCont,2]))+Space(3)+aImp[nCont,3] ;
				+ If(lLotac,Space(8) + aImp[nCont,5],' ')
		Else
			@ nLin,000 PSay aImp[nCont,1]+Space(3)+aImp[nCont,2]+Space(40-Len(aImp[nCont,2]))+Space(3)+aImp[nCont,3] ;
				+ If(lLotac,Space(8) + aImp[nCont,5],' ')
		EndIf
		
		nLin++
		
	Next
	
	TRBPOS->(DbCloseArea())
	
Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFuncao    ณPLSAppend บ Autor ณ Rafael             บ Data ณ  29/10/04   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescrio ณ Funcao de append no arquivo TXT para o arquivo de trabalho.บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ                                                            บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/

Static Function PLSAppTmp()
	
	DbSelectArea("TRBPOS")
	Append From &(cNomeArq) SDF
	
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ AjustaSX1บAutor  ณ Jean Schulz        บ Data ณ  11/11/06   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Ajusta os parametros                                       บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function AjustaSX1(cPerg)
	
	Local aHelpPor := {}
	
	PutSx1(cPerg,"01",OemToAnsi("Arquivo Padrใo ")				,"","","mv_ch1","C",60,0,0,"G","U_fGetFile('Txt     (*.Txt)            | *.Txt | ')","","","","mv_par01","","","","","","","","","","","","","","","","",aHelpPor,{},{})
	PutSx1(cPerg,"02",OemToAnsi("Ordem do arquivo:") 			,"","","mv_ch2","N",01,0,0,"C","","","","","mv_par02","Lota็ใo","","","","Ordem 2","","","","","","","","","","","",{},{},{})
	
	Pergunte(cPerg,.T.)
	
Return



User Function PLS264REE
Return .T.