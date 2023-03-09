#include 'protheus.ch'
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³PLS625E1D ºAutor  ³Roger Cangianeli    º Data ³  21/02/08   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ P.E. antes da exclusão/cancelamento do título a receber.   º±±
±±º          ³ Visa manter o histórico de cobrança para contabilidade.    º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Módulo Plano de Saúde                                      º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function PL625E1D()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³P.E. entra com SE1 posicionado. Faz a verificação no BD6 e guarda no arquivo BMO       ³
//³todo o histórico necessário para pode refazer a contabilização, se o título vier a ser ³
//³deletado.                                                                              ³
//³O arquivo BMO é espelho do BD6, portanto o nome dos campos é identico e a gravação é   ³
//³feita por macros.                                                                      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

Local aArea	:= GetArea()         
Local cString := '' 
Local aCampos := {}
Local aPosTx1 := {}
Local aPosTx2 := {}
Local aPosVl1 := {}
Local aPosVl2 := {}
Private cDoc := ''   

//alert("PL625E1D")

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Checa se o arquivo BMO e indice existem na base de dados³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If  ! PLSALIASEX("BMO") .or. ! SIX->(msSeek("BMO1"))  .or. ! PLSALIASEX("BMK") .or. ! SIX->(msSeek("BMK1"))
	Aviso('Arquivo Inexistente','É necessário a criação do arquivo BMO e BMK para armazenar o histórico do título gerado.',{"Ok"},1,"Configuração Inadequada")
	//MsgAlert('É necessário a criação do arquivo BMO para armazenar o histórico do título gerado.')
	Return()
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Prepara variáveis para entrar no processamento³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

// String de busca para relacionamento com BD6 e BMO
cString	:= '0' + AllTrim(SE1->(E1_CODINT+E1_PLNUCOB+E1_PREFIXO+E1_NUM+E1_PARCELA+E1_TIPO+E1_CODINT+E1_CODEMP+E1_MATRIC+E1_TIPREG))

// Campos do BD6 que serão gravados no BMO
aCampos	:= BD6->(dbStruct())

// Cria Array de posicionamento de lançamentos
// Lancamento Custo Operacional - Valor
aAdd( aPosVl1, '104' )
aAdd( aPosVl1, '127' )
aAdd( aPosVl1, '134' )
aAdd( aPosVl1, '137' )
aAdd( aPosVl1, '138' )
aAdd( aPosVl1, '139' )
aAdd( aPosVl1, '140' )
aAdd( aPosVl1, '141' )
aAdd( aPosVl1, '142' )
aAdd( aPosVl1, '143' )
aAdd( aPosVl1, '144' )
aAdd( aPosVl1, '145' )
// Lancamento Custo Operacional - Taxa
aAdd( aPosTx1, '156' )
aAdd( aPosTx1, '157' )
aAdd( aPosTx1, '158' )
aAdd( aPosTx1, '159' )
aAdd( aPosTx1, '160' )
aAdd( aPosTx1, '161' )
aAdd( aPosTx1, '162' )
aAdd( aPosTx1, '163' )
aAdd( aPosTx1, '164' )
aAdd( aPosTx1, '165' )
aAdd( aPosTx1, '166' )
aAdd( aPosTx1, '167' )
// Lancamento CoParticipacao - Valor
aAdd( aPosVl2, '116' )
aAdd( aPosVl2, '' )			// Posicões 2 e 3 não são utilizadas
aAdd( aPosVl2, '' )
aAdd( aPosVl2, '147' )
aAdd( aPosVl2, '148' )
aAdd( aPosVl2, '149' )
aAdd( aPosVl2, '150' )
aAdd( aPosVl2, '151' )
aAdd( aPosVl2, '152' )
aAdd( aPosVl2, '153' )
aAdd( aPosVl2, '154' )
aAdd( aPosVl2, '155' )
// Lancamento CoParticipacao - Taxa
aAdd( aPosTx2, '168' )
aAdd( aPosTx2, '' )			// Posicões 2 e 3 não são utilizadas
aAdd( aPosTx2, '' )
aAdd( aPosTx2, '169' )
aAdd( aPosTx2, '170' )
aAdd( aPosTx2, '171' )
aAdd( aPosTx2, '172' )
aAdd( aPosTx2, '173' )
aAdd( aPosTx2, '174' )
aAdd( aPosTx2, '175' )
aAdd( aPosTx2, '176' )
aAdd( aPosTx2, '177' )

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Verifica o último número sequencial do arquivo BMO.³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cSql 	:= "SELECT MAX(BMO_RELBMK) AS MAXIMO "
cSql	+= "FROM " + RetSQLName("BMO") + " WHERE D_E_L_E_T_ = ' ' "
cSql	+= "AND BMO_FILIAL = '"+xFilial("BMO")+"' "
cSql	:= ChangeQuery(cSql)
PlsQuery(cSql, "TRBBMO")
If Empty(TRBBMO->MAXIMO)
	cDoc	:= Strzero( 1, Len(BMO->BMO_RELBMK) )
Else
	cDoc   := SomaIt(TRBBMO->MAXIMO)
EndIf
TRBBMO->(dbCloseArea())

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Posicionamento dos arquivos e índices³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
BMO->(dbSetOrder(1))
BMK->(dbSetOrder(1))


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ<¿
//³Funcao para apagar BMO e BMK, caso tenha existido um título ³
//³com essa mesma numeração anteriormente.                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ<Ù
_VeSeExclui(cString)

// INDICE NO BD6- BD6_FILIAL+BD6_STAFAT+BD6_OPEFAT+BD6_NUMFAT+BD6_NUMSE1+BD6_OPEUSR+BD6_CODEMP+BD6_MATRIC+BD6_TIPREG
BD6->(dbOrderNickName('BD6CONT'))
BD6->(dbSeek(xFilial("BD6") + cString, .F.))
While !BD6->(Eof()) .and. BD6->BD6_STAFAT == '0' .and. BD6->BD6_CODOPE == SE1->E1_CODINT .and.;
	BD6->BD6_NUMFAT == SE1->E1_PLNUCOB .and. BD6->BD6_NUMSE1 == SE1->(E1_PREFIXO+E1_NUM+E1_PARCELA+E1_TIPO)
	
	_GravaBMO(aCampos, cDoc, aPosVl1, aPosVl2, aPosTx1, aPosTx2 )
	cDoc   := SomaIt(cDoc)		//SomaIt(TRBBMO->MAXIMO)
	BD6->(dbSkip())
	
EndDo

RestArea(aArea)
Return()


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Funcao de verificação e eliminação dos arquivos BMO e BMK³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Static Function _VeSeExclui(cString)

BMK->(dbSetOrder(1))
BMO->(dbSetOrder(1))
If BMO->(dbSeek(xFilial("BMO") + cString, .F.))
	While !BMO->(Eof()) .and. BMO->(BMO_STAFAT+BMO_OPEFAT+BMO_NUMFAT+BMO_NUMSE1+BMO_OPEUSR+BMO_CODEMP+BMO_MATRIC+BMO_TIPREG) == cString
		// Verifica relacionamento a cada BMO e apaga quando encontra
		If BMK->(dbSeek(xFilial('BMK')+BMO->BMO_RELBMK, .F.))
			While !BMK->(Eof()) .and. BMK->BMK_RELBMO == BMO->BMO_RELBMK
				RecLock('BMK',.F.)
				BMK->(dbDelete())
				BMK->(msUnlock())
				BMK->(dbSkip())
			EndDo
		EndIf
		RecLock('BMO',.F.)
		BMO->(dbDelete())
		BMO->(msUnlock())
		BMO->(dbSkip())
	EndDo
EndIf

Return


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄƒ
//³Funcao de gravacao do BMO e do arquivo BMK³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄƒ
Static Function _GravaBMO(aCampos, cDoc, aPosVl1, aPosVl2, aPosTx1, aPosTx2 )

Local n, nPos, cSeq, aAreaBAU

If ValType(aCampos) <> 'A'
	Aviso('Inconsistência no processo','Erro na gravação da composição do título a excluir, afetando a contabilização do título.',{"Ok"},1,"ERRO")
	//	MsgAlert('Erro na gravação da composição do título a excluir. Afetará a contabilização do título.')
	Return()
EndIf

dbSelectArea('BMO')
RecLock('BMO',.T.)
For n := 1 to Len(aCampos)
	If FieldPos(&('"BMO'+Subs(aCampos[n,1],4)+'"')) == 0
		Loop
	EndIf
	FieldPut( FieldPos(&('"BMO'+Subs(aCampos[n,1],4)+'"')), BD6->(FieldGet( BD6->(FieldPos(aCampos[n,1]))))) 
Next
BMO->BMO_RELBMK	:= cDoc
msUnlock()

cSeq	:= StrZero( 1, Len(BMK->BMK_SEQUEN) )


// Identifica se a participação financeira é referente a Custo Operacional ou Co-Participação
If BD6->BD6_GUIACO=='1'
	// Se Custo Operacional por Compra de procedimento (C.O. em PP)
	cTipPF	:= '1'
	
ElseIf BD6->BD6_PERCOP==100 .OR. ( BD6->BD6_VLRBPF==(BD6->BD6_VLRTPF-BD6->BD6_VLRTAD ) )
	// Se lançamento de Custo Operacional em Demais Modalidades
	cTipPF	:= '0'
	
Else
	// demais trata em Co-Participação
	cTipPF	:= '2'
EndIf


// Posicionamento do BAU necessário para o P.E. PLTIPATO
aAreaBAU	:= BAU->(GetArea())
BAU->(DbSetOrder(1))
BAU->(MsSeek(xFilial("BAU")+BD6->BD6_CODRDA))


// Chama funcao que retornará array do PLTIPATO
// Parâmetro: 1-Custo Operacional  / 2-Co-Participacao
aRetPF	:= PLSTIPOCOP(cTipPF)			// Executa a chamada da PLTIPATO e retorna array com lctos.
aRetVlr	:= aRetPF[1]
aRetTxa	:= aRetPF[2]

If ValType(aRetVlr) == 'A'
	For nPos := 1 to Len(aRetVlr)
		// Verifica se há valor nessa posição do lançamento
		If aRetVlr[nPos] > 0
			// Grava BMK
			RecLock('BMK',.T.)
			BMK->BMK_FILIAL	:= xFilial('BMK')
			BMK->BMK_RELBMO	:= BMO->BMO_RELBMK
			BMK->BMK_SEQUEN	:= cSeq
			BMK->BMK_CODTIP	:= IIF(cTipPF$'0/1', aPosVl1[nPos], aPosVl2[nPos] )
			BMK->BMK_ATOCOO	:= Posicione("BFQ",1,xFilial("BFQ")+PlsIntPad()+BMK->BMK_CODTIP,"BFQ_ATOCOO")
			BMK->BMK_TIPPF	:= cTipPF
			BMK->BMK_VALOR	:= aRetVlr[nPos]
			BMK->(msUnlock())
			cSeq := SomaIt(cSeq)
		EndIf
	Next
EndIf
If ValType(aRetTxa) == 'A'
	// Muda a variavel somente para tratamento nos lançamentos
	cTipPF	:= IIf(cTipPF== '0', '5', IIf(cTipPF=='1', '3', '4' ) )
	For nPos := 1 to Len(aRetTxa)
		// Verifica se há valor nessa posição do lançamento
		If aRetTxa[nPos] > 0
			// Grava BMK
			RecLock('BMK',.T.)
			BMK->BMK_FILIAL	:= xFilial('BMK')
			BMK->BMK_RELBMO	:= BMO->BMO_RELBMK
			BMK->BMK_SEQUEN	:= cSeq
			BMK->BMK_CODTIP	:= IIF(cTipPF$'3/5', aPosTx1[nPos], aPosTx2[nPos] )
			BMK->BMK_ATOCOO	:= Posicione("BFQ",1,xFilial("BFQ")+PlsIntPad()+BMK->BMK_CODTIP,"BFQ_ATOCOO")
			BMK->BMK_TIPPF	:= cTipPF
			BMK->BMK_VALOR	:= aRetTxa[nPos]
			BMK->(msUnlock())
			cSeq := SomaIt(cSeq)
		EndIf
	Next
	// Volta valor original da variavel - NÃO É NECESSÁRIO
//	cTipPF	:= IIf(cTipPF== '3', '1', '2')
EndIf
BAU->(RestArea(aAreaBAU))

Return

