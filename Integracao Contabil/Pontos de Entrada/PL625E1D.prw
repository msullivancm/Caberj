#include 'protheus.ch'
/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �PLS625E1D �Autor  �Roger Cangianeli    � Data �  21/02/08   ���
�������������������������������������������������������������������������͹��
���Desc.     � P.E. antes da exclus�o/cancelamento do t�tulo a receber.   ���
���          � Visa manter o hist�rico de cobran�a para contabilidade.    ���
�������������������������������������������������������������������������͹��
���Uso       � M�dulo Plano de Sa�de                                      ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

User Function PL625E1D()

//���������������������������������������������������������������������������������������Ŀ
//�P.E. entra com SE1 posicionado. Faz a verifica��o no BD6 e guarda no arquivo BMO       �
//�todo o hist�rico necess�rio para pode refazer a contabiliza��o, se o t�tulo vier a ser �
//�deletado.                                                                              �
//�O arquivo BMO � espelho do BD6, portanto o nome dos campos � identico e a grava��o �   �
//�feita por macros.                                                                      �
//�����������������������������������������������������������������������������������������

Local aArea	:= GetArea()         
Local cString := '' 
Local aCampos := {}
Local aPosTx1 := {}
Local aPosTx2 := {}
Local aPosVl1 := {}
Local aPosVl2 := {}
Private cDoc := ''   

//alert("PL625E1D")

//��������������������������������������������������������Ŀ
//�Checa se o arquivo BMO e indice existem na base de dados�
//����������������������������������������������������������
If  ! PLSALIASEX("BMO") .or. ! SIX->(msSeek("BMO1"))  .or. ! PLSALIASEX("BMK") .or. ! SIX->(msSeek("BMK1"))
	Aviso('Arquivo Inexistente','� necess�rio a cria��o do arquivo BMO e BMK para armazenar o hist�rico do t�tulo gerado.',{"Ok"},1,"Configura��o Inadequada")
	//MsgAlert('� necess�rio a cria��o do arquivo BMO para armazenar o hist�rico do t�tulo gerado.')
	Return()
Endif

//����������������������������������������������Ŀ
//�Prepara vari�veis para entrar no processamento�
//������������������������������������������������

// String de busca para relacionamento com BD6 e BMO
cString	:= '0' + AllTrim(SE1->(E1_CODINT+E1_PLNUCOB+E1_PREFIXO+E1_NUM+E1_PARCELA+E1_TIPO+E1_CODINT+E1_CODEMP+E1_MATRIC+E1_TIPREG))

// Campos do BD6 que ser�o gravados no BMO
aCampos	:= BD6->(dbStruct())

// Cria Array de posicionamento de lan�amentos
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
aAdd( aPosVl2, '' )			// Posic�es 2 e 3 n�o s�o utilizadas
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
aAdd( aPosTx2, '' )			// Posic�es 2 e 3 n�o s�o utilizadas
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

//���������������������������������������������������Ŀ
//�Verifica o �ltimo n�mero sequencial do arquivo BMO.�
//�����������������������������������������������������
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

//�������������������������������������Ŀ
//�Posicionamento dos arquivos e �ndices�
//���������������������������������������
BMO->(dbSetOrder(1))
BMK->(dbSetOrder(1))


//�������������������������������������������������������������<�
//�Funcao para apagar BMO e BMK, caso tenha existido um t�tulo �
//�com essa mesma numera��o anteriormente.                     �
//�������������������������������������������������������������<�
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


//���������������������������������������������������������Ŀ
//�Funcao de verifica��o e elimina��o dos arquivos BMO e BMK�
//�����������������������������������������������������������
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


//������������������������������������������ă
//�Funcao de gravacao do BMO e do arquivo BMK�
//������������������������������������������ă
Static Function _GravaBMO(aCampos, cDoc, aPosVl1, aPosVl2, aPosTx1, aPosTx2 )

Local n, nPos, cSeq, aAreaBAU

If ValType(aCampos) <> 'A'
	Aviso('Inconsist�ncia no processo','Erro na grava��o da composi��o do t�tulo a excluir, afetando a contabiliza��o do t�tulo.',{"Ok"},1,"ERRO")
	//	MsgAlert('Erro na grava��o da composi��o do t�tulo a excluir. Afetar� a contabiliza��o do t�tulo.')
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


// Identifica se a participa��o financeira � referente a Custo Operacional ou Co-Participa��o
If BD6->BD6_GUIACO=='1'
	// Se Custo Operacional por Compra de procedimento (C.O. em PP)
	cTipPF	:= '1'
	
ElseIf BD6->BD6_PERCOP==100 .OR. ( BD6->BD6_VLRBPF==(BD6->BD6_VLRTPF-BD6->BD6_VLRTAD ) )
	// Se lan�amento de Custo Operacional em Demais Modalidades
	cTipPF	:= '0'
	
Else
	// demais trata em Co-Participa��o
	cTipPF	:= '2'
EndIf


// Posicionamento do BAU necess�rio para o P.E. PLTIPATO
aAreaBAU	:= BAU->(GetArea())
BAU->(DbSetOrder(1))
BAU->(MsSeek(xFilial("BAU")+BD6->BD6_CODRDA))


// Chama funcao que retornar� array do PLTIPATO
// Par�metro: 1-Custo Operacional  / 2-Co-Participacao
aRetPF	:= PLSTIPOCOP(cTipPF)			// Executa a chamada da PLTIPATO e retorna array com lctos.
aRetVlr	:= aRetPF[1]
aRetTxa	:= aRetPF[2]

If ValType(aRetVlr) == 'A'
	For nPos := 1 to Len(aRetVlr)
		// Verifica se h� valor nessa posi��o do lan�amento
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
	// Muda a variavel somente para tratamento nos lan�amentos
	cTipPF	:= IIf(cTipPF== '0', '5', IIf(cTipPF=='1', '3', '4' ) )
	For nPos := 1 to Len(aRetTxa)
		// Verifica se h� valor nessa posi��o do lan�amento
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
	// Volta valor original da variavel - N�O � NECESS�RIO
//	cTipPF	:= IIf(cTipPF== '3', '1', '2')
EndIf
BAU->(RestArea(aAreaBAU))

Return

