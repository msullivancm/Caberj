#include "PROTHEUS.CH"
#include "PLSMGER.CH"
/*/
������������������������������������������������������������������������������
������������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ���
���Funcao    �CABR005  � Autor �Luzio Tavares           � Data � 10.04.08 ����
�������������������������������������������������������������������������Ĵ���
���Descricao � Lista Totais de Usuarios por Produto                       ����
�������������������������������������������������������������������������Ĵ���
���Sintaxe   � CABR005                                                    ����
�������������������������������������������������������������������������Ĵ���
��� Uso      � CABERJ                                                     ����
�������������������������������������������������������������������������Ĵ���
��� Alteracoes desde sua construcao inicial                               ����
�������������������������������������������������������������������������Ĵ���
��� Data     � BOPS � Programador � Breve Descricao                       ����
�������������������������������������������������������������������������Ĵ���
��������������������������������������������������������������������������ٱ��
������������������������������������������������������������������������������
������������������������������������������������������������������������������
/*/
//��������������������������������������������������������������������������Ŀ
//� Define nome da funcao                                                    �
//����������������������������������������������������������������������������
User Function CABR005()
//��������������������������������������������������������������������������Ŀ
//� Define variaveis padroes para todos os relatorios...                     �
//����������������������������������������������������������������������������
PRIVATE nQtdLin     := 58
PRIVATE nLimite     := 220 //132
PRIVATE cTamanho    := "G" //"M"
PRIVATE cTitulo     := "Quantidade de Usuarios por Produto Saude"
PRIVATE cDesc1      := "Este relatorio ira emitir totais de usuarios "
PRIVATE cDesc2      := "em cada produto saude, por faixa-etaria e sexo."
PRIVATE cDesc3      := ""
PRIVATE cAlias      := "BA1"
PRIVATE cPerg       := "CAR005    "
PRIVATE cRel        := "CABR005"
PRIVATE nli         := 60
PRIVATE m_pag       := 1
PRIVATE lCompres    := .F.
PRIVATE lDicion     := .F.
PRIVATE lFiltro     := .T.
PRIVATE lCrystal    := .F.
////PRIVATE aOrderns    := {"Contrato + Matricula","Contrato + Nome","Matricula do sistema antigo"}
//PRIVATE aOrderns    := {"Grupo/Empresa + Contrato + Sub-Contrato","Contrato + Sub-Contrato"}
PRIVATE aOrderns    := {}
//PRIVATE aReturn     := { "", 1,"", 2, 2, 1, "",1 }
Private aReturn     := { "Zebrado", 1, "Administracao", 2, 2, 1, "", 1}
PRIVATE lAbortPrint := .F.
PRIVATE cCabec1     := "Periodo: "
PRIVATE cCabec2     := ""  //"Grupo Descricao                                                             Tot.c/ bloq.  Antes  Excl.  Incl.   Tit.   Dep. Efetivo"
//PRIVATE cCabec2     := "Grupo Contrato         Sub-Contrato  Descricao                              Tot.c/ bloq.  Antes  Excl.  Incl.   Tit.   Dep. Efetivo"
//PRIVATE cCabec2     := "Matricula            Nome                                     Dt.Nasc. Sexo Est.Civil      Tipo Usuario   Parent.         Dt.Inicio"
PRIVATE nColuna     := 00
PRIVATE aLinha      := {}

//��������������������������������������������������������������������������Ŀ
//� Testa ambiente do relatorio somente top...                               �
//����������������������������������������������������������������������������
If ! PLSRelTop()
	Return
Endif

//��������������������������������������������������������������������������Ŀ
//� Ajusta perguntas                                                         �
//����������������������������������������������������������������������������
ValidPerg(cPerg)

//��������������������������������������������������������������������������Ŀ
//� Acessa parametros do relatorio...                                        �
//���������������������������������������������������������������������������
Pergunte(cPerg,.F.)

//If mv_par15 = 1
//	nQtdLin     := 50
//	nLimite     := 220
//	cTamanho    := "G"
//EndIf

//��������������������������������������������������������������������������Ŀ
//� Chama SetPrint (padrao)                                                  �
//����������������������������������������������������������������������������
cRel  := SetPrint(cAlias,cRel,cPerg,@cTitulo,cDesc1,cDesc2,cDesc3,lDicion,aOrderns,lCompres,cTamanho,{},lFiltro,lCrystal)

nTipo := IIF(aReturn[4]==1,15,18)
//��������������������������������������������������������������������������Ŀ
//� Verifica se foi cancelada a operacao (padrao)                            �
//����������������������������������������������������������������������������
If nLastKey  == 27
	Return
Endif

//��������������������������������������������������������������������������Ŀ
//� Configura impressora                                                     �
//����������������������������������������������������������������������������
SetDefault(aReturn,cAlias)

//��������������������������������������������������������������������������Ŀ
//� Emite relat�rio                                                          �
//����������������������������������������������������������������������������
MsAguarde({|| CABR005Imp() }, cTitulo, "", .T.)
//��������������������������������������������������������������������������Ŀ
//� Fim da rotina                                                            �
//����������������������������������������������������������������������������
Return
/*/
������������������������������������������������������������������������������
������������������������������������������������������������������������������
��������������������������������������������������������������������������Ŀ��
���Programa   � CABR005Imp  � Autor � Luzio Tavares      � Data � 10.04.08 ���
��������������������������������������������������������������������������Ĵ��
���Descricao  � Imprime detalhe do relatorio...                            ���
���������������������������������������������������������������������������ٱ�
������������������������������������������������������������������������������
/*/
Static Function CABR005Imp()

Local k := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS
Local j := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

//��������������������������������������������������������������������������Ŀ
//� Define variaveis...                                                      �
//����������������������������������������������������������������������������

LOCAL cSQL
//LOCAL nOrdSel       := aReturn[8]
LOCAL lIniCab       := .T.
LOCAL aUsuario      := {}
LOCAL aUsuBlq       := {}
PRIVATE pQuant     := "@E 999999"
PRIVATE nQtdTit    := 0
PRIVATE nQtdDep    := 0
PRIVATE nQtdUsu    := 0
PRIVATE nQtdTotGer := 0
PRIVATE nQtdTotTit := 0
PRIVATE nQtdTotDep := 0
PRIVATE nQtdTotUsu := 0
PRIVATE nQtdAnt    := 0
PRIVATE nQtdInc    := 0
PRIVATE nQtdExc    := 0
PRIVATE nQtdTotAnt := 0
PRIVATE nQtdTotInc := 0
PRIVATE nQtdTotExc := 0
PRIVATE nQtdTotTot := 0
PRIVATE nTotTitDes := 0
PRIVATE nTotDepDes := 0
PRIVATE nTotUsuDes := 0
PRIVATE ntotAntDes := 0
PRIVATE nTotIncDes := 0
PRIVATE nTotExcDes := 0
PRIVATE nTotTotDes := 0
PRIVATE nTotTit := 0
PRIVATE nTotDep := 0
PRIVATE nTotUsu := 0
PRIVATE nTotAnt := 0
PRIVATE nTotInc := 0
PRIVATE nTotExc := 0
PRIVATE nTotTot := 0
PRIVATE aSubTot     := {}
PRIVATE aTotGer     := {}
PRIVATE aLinTit     := {}
PRIVATE aLinDep     := {}
PRIVATE aLinAgr     := {}
PRIVATE aLinTotTit  := {}
PRIVATE aLinTotDep  := {}
PRIVATE aLinTotAgr  := {}
PRIVATE aValFai     := {0,0,0,0,0,0,0}
PRIVATE aValTxt     := {}
PRIVATE aValTotFai  := {0,0,0,0,0,0,0}
PRIVATE aValTotTxt  := {}
PRIVATE nFaixa      := 0
PRIVATE nScan       := 0
PRIVATE pQtdTot     := "@E 999999999"
PRIVATE nVlrTit     := 0
PRIVATE nVlrdep     := 0
PRIVATE nVlrAgr     := 0
PRIVATE nVlrTotTit  := 0
PRIVATE nVlrTotdep  := 0
PRIVATE nVlrTotAgr  := 0
PRIVATE nVlrSubTot  := 0
PRIVATE cVlrSubTot
PRIVATE nVlrTotGer  := 0
PRIVATE cVlrTotGer
PRIVATE nIdade
//��������������������������������������������������������������������������Ŀ
//� Dados do parametro...                                                    �
//����������������������������������������������������������������������������
PRIVATE nTipPes     // (PF;PJ;Ambos)
PRIVATE nAnaSin     // (Imprime Beneficiarios)
PRIVATE cOpeDe      // Codigo da Operadora de Saude de
PRIVATE cOpeAte     // Codigo da Operadora de Saude Ate
PRIVATE cDatDe      // Data Referencia Inicial
PRIVATE cDatAte     // Data Referencia Final
PRIVATE cGrupoDe    // Codigo do Grupo/Empresa de
PRIVATE cGrupoAte   // Codigo do Grupo/Empresa ate
PRIVATE cContrDe    // Codigo do Contrato de
PRIVATE cContrAte   // Codigo do Contrato ate
PRIVATE cSbConDe    // Codigo do Sub-contrato de
PRIVATE cSbConAte   // Codigo do Sub-contrato ate

cOpeDe     := mv_par01
cOpeAte    := mv_par02
nTipPes    := mv_par03
cDatDe     := mv_par04
cDatAte    := mv_par05
cGrupoDe   := mv_par06
cGrupoAte  := mv_par07
cContrDe   := mv_par08
cContrAte  := mv_par09
cSbConDe   := mv_par10
cSbConAte  := mv_par11
cProdDe    := mv_par12
cProdAte   := mv_par13

//��������������������������������������������������������������������������Ŀ
//� Exibe mensagem...                                                        �      ]
//����������������������������������������������������������������������������
MsProcTxt(PLSTR0001)

cCabec1 := "Periodo Movimentacao De: "+DtoC(mv_par04)+" a "+DtoC(mv_par05)   //+"       Operadoras De: "+Iif(Empty(cOpeDe),'Todas',cOpeDe+' a '+cOpeAte)

//��������������������������������������������������������������������������Ŀ
//� Faz filtro no arquivo de Usuarios...                                     �
//����������������������������������������������������������������������������
cSql := " SELECT DECODE(TRIM(BA1_CODPLA),NULL,BA3_CODPLA,BA1_CODPLA) AS BA1CODPLA, DECODE(BA1_VERSAO,'   ',BA3_VERSAO,BA1_VERSAO) AS BA1VERSAO, BA1.* FROM "
cSql += RetSQLName("BA1")+" BA1, "+RetSQLName("BA3")+" BA3 "
cSql += " WHERE BA1.D_E_L_E_T_ <> '*'  AND "
cSql += " BA3.D_E_L_E_T_ <> '*'  AND "
cSql += " BA1.BA1_FILIAL = '"+xFilial("BA1")+"' AND "
cSql += " BA3.BA3_FILIAL = '"+xFilial("BA3")+"' AND "
cSQL += " BA1_CODINT BETWEEN '"+cOpeDe+"' AND '"+cOpeAte+"' AND "
cSQL += " BA1_CODEMP BETWEEN '"+cGrupoDe+"' AND '"+cGrupoAte+"' AND "
cSQL += " BA3_CODINT = BA1_CODINT AND "
cSQL += " BA3_CODEMP = BA1_CODEMP AND "
cSQL += " BA3_MATRIC = BA1_MATRIC AND "
cSQL += " (BA1_DATBLO = '      ' OR BA1_DATBLO > '"+DtoS(cDatAte)+"') AND "
//cSQL += " BA1_DATINC BETWEEN '"+DtoS(cDatDe)+"' AND '"+DtoS(cDatAte)+"' AND "
cSQL += " BA1_DATINC <= '"+DtoS(cDatAte)+"' AND "
cSQL += " BA1_CODPLA BETWEEN '"+cProdDe+"' AND '"+cProdAte+"' AND "
If nTipPes == 2 // Pessoa Juridica
	cSQL += " BA1_CONEMP BETWEEN '"+cContrDe+"' AND '"+cContrAte+"' AND "
	cSQL += " BA1_SUBCON BETWEEN '"+cSbConDe+"' AND '"+cSbConAte+"' AND "
	cSQL += " BA1_CONEMP <> '  ' AND "
	cSQL += " BA1_SUBCON <> '  ' "
Elseif nTipPes == 1 // Pessoa Fisica
	cSQL += " BA1_CONEMP = '  ' AND "
	cSQL += " BA1_SUBCON = '  ' "
Elseif nTipPes == 3 // Ambas
	cSQL += " BA1_CONEMP BETWEEN '"+cContrDe+"' AND '"+cContrAte+"'  AND "
	cSQL += " BA1_SUBCON BETWEEN '"+cSbConDe+"' AND '"+cSbConAte+"' "
Endif

//��������������������������������������������������������������������������Ŀ
//� Se houver filtro executa parse para converter expressoes adv para SQL    �
//����������������������������������������������������������������������������
If ! Empty(aReturn[7])
	cSQL += " AND (" + PLSParSQL(aReturn[7])+" ) "
Endif
//��������������������������������������������������������������������������Ŀ
//� De acordo com a ordem....                                                �
//����������������������������������������������������������������������������
cSQL += "ORDER BY BA1CODPLA, BA1VERSAO, BA1_CODINT, BA1_OPEDES, BA1_CODEMP, BA1_MATRIC, BA1_CONEMP, BA1_VERCON, BA1_SUBCON, BA1_VERSUB"

memowrit("C:\CABR005.SQL",cSQL)

If Select("CABR005") > 0
	CABR005->(DbCloseArea())
EndIf

PLSQuery(cSQL,"CABR005")
CABR005->(DbGotop())
//��������������������������������������������������������������������������Ŀ
//� Inicio da impressao dos detalhes...                                      �
//����������������������������������������������������������������������������
While ! CABR005->(Eof())
	//��������������������������������������������������������������������Ŀ
	//� Verifica se foi abortada a impressao...                            �
	//����������������������������������������������������������������������
	If Interrupcao(lAbortPrint)
		nLi ++
		@nLi,00 PSAY "*** CANCELADO PELO OPERADOR ***"
		Exit
	Endif
	
	/*
	//��������������������������������������������������������������������������Ŀ
	//� Imprime cabecalho...                                                     �
	//����������������������������������������������������������������������������
	If nLi > nQtdLin
	nLi := Cabec(cTitulo,cCabec1,cCabec2,cRel,cTamanho,nTipo)
	//		++nLi
	nLi := 60
	Endif
	*/
	
	cCodInt := CABR005->BA1_CODINT
	
	//��������������������������������������������������������������������������Ŀ
	//� Atribuo valor as variaveis de controle...                                �
	//����������������������������������������������������������������������������
	//	If !Empty(CABR005->BA1CODPLA)
	cCodPla := CABR005->BA1CODPLA
	cVersao := CABR005->BA1VERSAO
	//	Else
	//	   cCodPla := CABR005->BA3_CODPLA
	//	   cVersao := CABR005->BA3_VERSAO
	//	EndIf
	
	cDesPla := ""
	BI3->(DbSetOrder(1))    // BI3_CODINT
	BI3->(DbSeek(xFilial("BI3")+cCodInt+cCodPla+cVersao))
	cDesPla := BI3->BI3_DESCRI
	
	//��������������������������������������������������������������������Ŀ
	//� Exibe mensagem...                                                  �
	//����������������������������������������������������������������������
	MsProcTXT("Produto: "+cCodPLa+" - "+cDesPla+"...")
	
	While ! CABR005->(Eof()) .And. CABR005->(BA1_CODINT+BA1CODPLA+BA1VERSAO) == cCodInt+cCodPla+cVersao
		//��������������������������������������������������������������������������Ŀ
		//� Atribuo valor as variaveis de controle...                                �
		//����������������������������������������������������������������������������
		// Total de Inclusoes
		If Dtos(CABR005->BA1_DATINC) >= Dtos(cDatDe) .And. Dtos(CABR005->BA1_DATINC) <= Dtos(cDatAte)
			nQtdInc ++
			//nQtdRep ++
		Endif
		// Total de Exclusoes
		If Dtos(CABR005->BA1_DATBLO) >= Dtos(cDatDe) .And. Dtos(CABR005->BA1_DATBLO) <= Dtos(cDatAte)
			nQtdExc ++
		Endif
		// Total de Usuarios Efetivos
		If  Dtos(CABR005->BA1_DATINC) <= Dtos(cDatAte) .And. Empty(CABR005->BA1_DATBLO) .Or.;
			(Dtos(CABR005->BA1_DATINC) <= Dtos(cDatAte) .And. Dtos(CABR005->BA1_DATBLO) > Dtos(cDatAte))
			If CABR005->BA1_TIPUSU == "T"
				nQtdTit ++
			Elseif CABR005->BA1_TIPUSU $ "D,A"
				nQtdDep ++
			Endif
			nQtdUsu ++
		Endif
		
		nQtdTotGer ++
		
		nIdade := Calc_Idade(dDataBase,CABR005->BA1_DATNAS)
		
		//��������������������������������������������������������������������������Ŀ
		//� Atribuo valores aos totalizadores...                                     �
		//����������������������������������������������������������������������������
		//		If cTotal == 1 // Imprime Resumo
		nFaixa := RetFai(nIdade)
		nScan  := aScan(aSubTot,{|x|x[1]==Alltrim(CABR005->BA1_TIPUSU) .AND. x[2]==Alltrim(CABR005->BA1_SEXO) .And. x[3]==nFaixa })
		If nScan == 0
			aadd(aSubTot,{Alltrim(CABR005->BA1_TIPUSU),Alltrim(CABR005->BA1_SEXO),nFaixa,1})
		Else
			aSubTot[nScan,4] := aSubTot[nScan,4] + 1
		Endif
		nScan  := aScan(aTotGer,{|x|x[1]==Alltrim(CABR005->BA1_TIPUSU) .AND. x[2]==Alltrim(CABR005->BA1_SEXO) .And. x[3]==nFaixa })
		If nScan == 0
			aadd(aTotGer,{Alltrim(CABR005->BA1_TIPUSU),Alltrim(CABR005->BA1_SEXO),nFaixa,1})
		Else
			aTotGer[nScan,4] := aTotGer[nScan,4] + 1
		Endif
		//		Endif
		
		CABR005->(DbSkip())
	EndDo
	//��������������������������������������������������������������������������Ŀ
	//� Atribuo valores do Sub-total...                                          �
	//����������������������������������������������������������������������������
	//Titular
	For J := 1 to 7
		For K := 1 to 2
			aadd(aLinTit,fPegaVal(aSubTot,"T",Str(K),J))
			nVlrTit := nVlrTit + Val(fPegaVal(aSubTot,"T",Str(K),J))
			aValFai[J] := aValFai[J] + Val(fPegaVal(aSubTot,"T",Str(K),J))
		Next K
	Next J
	aadd(aLinTit,Transform(nVlrTit,pQtdTot))
	
	//Depedente
	For J := 1 to 7
		For K := 1 to 2
			aadd(aLinDep,fPegaVal(aSubTot,"D",Str(K),J))
			nVlrDep := nVlrDep + Val(fPegaVal(aSubTot,"D",Str(K),J))
			aValFai[J] := aValFai[J] + Val(fPegaVal(aSubTot,"D",Str(K),J))
		Next K
	Next J
	aadd(aLinDep,Transform(nVlrDep,pQtdTot))
	
	//Agregado
	For J := 1 to 7
		For K := 1 to 2
			aadd(aLinAgr,fPegaVal(aSubTot,"A",Str(K),J))
			nVlrAgr := nVlrAgr + Val(fPegaVal(aSubTot,"A",Str(K),J))
			aValFai[J] := aValFai[J] + Val(fPegaVal(aSubTot,"A",Str(K),J))
		Next K
	Next J
	aadd(aLinAgr,Transform(nVlrAgr,pQtdTot))
	
	For J := 1 to 7
		aadd(aValTxt,Transform(aValFai[J],pQtdTot))
	Next
	
	nVlrSubTot := nVlrTit+nVlrDep+nVlrAgr
	cVlrSubTot := Transform(nVlrSubTot,pQtdTot)
	
	aadd(aValTxt,cVlrSubTot)
	
	//��������������������������������������������������������������������Ŀ
	//� Imprime Sub-Total por Produto...                                   �
	//����������������������������������������������������������������������
	ProcSubTot()
	
	aSubTot    := {}
	aLinTit    := {}
	aLinDep    := {}
	aLinAgr    := {}
	aValFai    := {0,0,0,0,0,0,0}
	aValTxt    := {}
	nVlrTit    := 0
	nVlrDep    := 0
	nVlrAgr    := 0
	nVlrSubTot := 0
Enddo

//��������������������������������������������������������������������������Ŀ
//� Atribuo valores do Total Geral...                                        �
//����������������������������������������������������������������������������
//Titular
For J := 1 to 7
	For K := 1 to 2
		aadd(aLinTotTit,fPegaVal(aTotGer,"T",Str(K),J))
		nVlrTotTit := nVlrTotTit + Val(fPegaVal(aTotGer,"T",Str(K),J))
		aValTotFai[J] := aValTotFai[J] + Val(fPegaVal(aTotGer,"T",Str(K),J))
	Next K
Next J
aadd(aLinTotTit,Transform(nVlrTotTit,pQtdTot))

//Depedente
For J := 1 to 7
	For K := 1 to 2
		aadd(aLinTotDep,fPegaVal(aTotGer,"D",Str(K),J))
		nVlrTotDep := nVlrTotDep + Val(fPegaVal(aTotGer,"D",Str(K),J))
		aValTotFai[J] := aValTotFai[J] + Val(fPegaVal(aTotGer,"D",Str(K),J))
	Next K
Next J
aadd(aLinTotDep,Transform(nVlrTotDep,pQtdTot))

//Agregado
For J := 1 to 7
	For K := 1 to 2
		aadd(aLinTotAgr,fPegaVal(aTotGer,"A",Str(K),J))
		nVlrTotAgr := nVlrTotAgr + Val(fPegaVal(aTotGer,"A",Str(K),J))
		aValTotFai[J] := aValTotFai[J] + Val(fPegaVal(aTotGer,"A",Str(K),J))
	Next K
Next J
aadd(aLinTotAgr,Transform(nVlrTotAgr,pQtdTot))

For J := 1 to 7
	aadd(aValTotTxt,Transform(aValTotFai[J],pQtdTot))
Next

nVlrTotGer := nVlrTotTit+nVlrTotDep+nVlrTotAgr
cVlrTotGer := Transform(nVlrTotGer,pQtdTot)

aadd(aValTotTxt,cVlrTotGer)
//��������������������������������������������������������������������Ŀ
//� Imprime Total Geral ...                                            �
//����������������������������������������������������������������������
ProcTotGer()

//��������������������������������������������������������������������Ŀ
//� Imprime rodape do relatorio...                                     �
//����������������������������������������������������������������������
//Roda(0,space(10),cTamanho)
//��������������������������������������������������������������������Ŀ
//� Fecha arquivo...                                                   �
//����������������������������������������������������������������������
CABR005->(DbCloseArea())
//��������������������������������������������������������������������������Ŀ
//� Libera impressao                                                         �
//����������������������������������������������������������������������������
If  aReturn[5] == 1
	Set Printer To
	//    Commit
	Ourspool(cRel)
End
//MS_FLUSH()             // Libera fila de relatorios em spool
//��������������������������������������������������������������������������Ŀ
//� Fim do Relatorio                                                         �
//����������������������������������������������������������������������������
Return

/*/
������������������������������������������������������������������������������
������������������������������������������������������������������������������
��������������������������������������������������������������������������Ŀ��
���Programa   � ValidPerg � Autor � Luzio Tavares        � Data � 08.02.08 ���
��������������������������������������������������������������������������Ĵ��
���Descricao  � Atualiza SX1                                               ���
���������������������������������������������������������������������������ٱ�
������������������������������������������������������������������������������
������������������������������������������������������������������������������
/*/

Static Function ValidPerg()

LOCAL aRegs	:= {}

aadd(aRegs,{cPerg,"01","Operadora Saude De ?        ","","","mv_ch1","C", 4,0,0,"G","","mv_par01","","","","","","","","","","","","","","","","","","","","","","","","","","B89PLS"})
aadd(aRegs,{cPerg,"02","Operadora Saude Ate ?       ","","","mv_ch2","C", 4,0,0,"G","","mv_par02","","","","","","","","","","","","","","","","","","","","","","","","","","B89PLS"})
aadd(aRegs,{cPerg,"03","Tipo de Contrato ?          ","","","mv_ch3","N", 1,0,0,"C","","mv_par03","Fisica","","","","","Juridica","","","","","Todas","","","","","","","","","","","","","","",""})
aadd(aRegs,{cPerg,"04","Data De ?                   ","","","mv_ch4","D",08,0,0,"G","","mv_par04","","","","","","","","","","","","","","","","","","","","","","","","","",""})
aadd(aRegs,{cPerg,"05","Data Ate ?                  ","","","mv_ch5","D",08,0,0,"G","","mv_par05","","","","","","","","","","","","","","","","","","","","","","","","","",""})
aadd(aRegs,{cPerg,"06","Grupo/Empresa De ?          ","","","mv_ch6","C", 4,0,0,"G","","mv_par06","","","","","","","","","","","","","","","","","","","","","","","","","","B7APLS"})
aadd(aRegs,{cPerg,"07","Grupo/Empresa Ate ?         ","","","mv_ch7","C", 4,0,0,"G","","mv_par07","","","","","","","","","","","","","","","","","","","","","","","","","","B7APLS"})
aadd(aRegs,{cPerg,"08","Contrato De ?               ","","","mv_ch8","C",12,0,0,"G","","mv_par08","","","","","","","","","","","","","","","","","","","","","","","","","","B7BPLS"})
aadd(aRegs,{cPerg,"09","Contrato Ate ?              ","","","mv_ch9","C",12,0,0,"G","","mv_par09","","","","","","","","","","","","","","","","","","","","","","","","","","B7BPLS"})
aadd(aRegs,{cPerg,"10","Subcontrato De ?            ","","","mv_cha","C", 9,0,0,"G","","mv_par10","","","","","","","","","","","","","","","","","","","","","","","","","","B7CPLS"})
aadd(aRegs,{cPerg,"11","Subcontrato Ate ?           ","","","mv_chb","C", 9,0,0,"G","","mv_par11","","","","","","","","","","","","","","","","","","","","","","","","","","B7CPLS"})
aadd(aRegs,{cPerg,"12","Produto De ?                ","","","mv_chc","C", 4,0,0,"G","","mv_par12","","","","","","","","","","","","","","","","","","","","","","","","","",""})
aadd(aRegs,{cPerg,"13","Produto Ate ?               ","","","mv_chd","C", 4,0,0,"G","","mv_par13","","","","","","","","","","","","","","","","","","","","","","","","","",""})

PlsVldPerg( aRegs )

Return

/*/
������������������������������������������������������������������������������
������������������������������������������������������������������������������
��������������������������������������������������������������������������Ŀ��
���Programa   � RetFai    � Autor � Luzio Tavares        � Data � 28.02.08 ���
��������������������������������������������������������������������������Ĵ��
���Descricao  � Retorna a faixa etaria do usuario                          ���
���������������������������������������������������������������������������ٱ�
������������������������������������������������������������������������������
/*/
Static Function RetFai(nIdade)

BL9->(DbGoTop())
While ! BL9->(Eof())
	If nIdade <= BL9->BL9_IDADEF
		nFaixa := Val(BL9->BL9_SEQUEN)
		Exit
	Endif
	BL9->(DbSkip())
Enddo

Return(nFaixa)

/*/
������������������������������������������������������������������������������
������������������������������������������������������������������������������
��������������������������������������������������������������������������Ŀ��
���Programa   � fPegaVal  � Autor � Luzio Tavares        � Data � 29.02.08 ���
��������������������������������������������������������������������������Ĵ��
���Descricao  � Retorna valor de cada faixa                                ���
���������������������������������������������������������������������������ٱ�
������������������������������������������������������������������������������
/*/
Static Function fPegaVal(aSubTot,cTipUsu,cSexo,nFaixa)

Local nScan
nScan := aScan(aSubTot,{|x|x[1]==Alltrim(cTipUsu) .AND. x[2]==Alltrim(cSexo) .And. x[3]==nFaixa})
If nScan == 0
	Return(Transform(0,pQuant))
Else
	Return(Transform(aSubTot[nScan,4],pQuant))
Endif

Return

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Fun��o    �ProcSubTot� Autor � Luzio Tavares         � Data �26.02.2008���
�������������������������������������������������������������������������Ĵ��
���Descri��o �Processa Sub-Total                                          ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
*/
Static Function ProcSubTot()

Local aL := Array(13)

//��������������������������������������������������������������������������Ŀ
//� Imprime cabecalho...                                                     �
//����������������������������������������������������������������������������
If nLi > nQtdLin
	nLi := Cabec(cTitulo,cCabec1,cCabec2,cRel,cTamanho,nTipo)
	++nLi
//	@ nLi,00 Psay "|                                                     | Titular   |###,###,###.##|###,###,###.##|###,###,###.##|###,###,###.##|###,###,###.##|###,###,###.##|###,###,###.##|###,###,###.##|###,###,###.##|###,###,###.##|###,###,###.##|###,###,###.##|###,###,###.##|###,###,###.##|###,###,###.##|"
//	++nLi
	aL[01] :="+===============================================================================================================================================================================+"
	aL[02] :="|                                             Faixas Etarias - Padrao ANS                                                                                                       |"
	aL[03] :="+=====================================================+=========================================================================================================================+"
	aL[04] :="|                                                     | Idade     |   0  - 17   |   18 - 29   |   30 - 39   |   40 - 49   |   50 - 59   |   60 - 69   |  70 - 999   |  TOTAIS   |"
	aL[05] :="|                                                     +-----------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+-----------+"
	aL[06] :="|                                                     | Sexo      |  M   |  F   |  M   |  F   |  M   |  F   |  M   |  F   |  M   |  F   |  M   |  F   |  M   |  F   |           |"
	aL[07] :="+-----------------------------------------------------+-----------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+-----------+"
	FmtLin({},aL[01],,,@nLi)
	FmtLin({},aL[02],,,@nLi)
	FmtLin({},aL[03],,,@nLi)
	FmtLin({},aL[04],,,@nLi)
	FmtLin({},aL[05],,,@nLi)
	FmtLin({},aL[06],,,@nLi)
	FmtLin({},aL[07],,,@nLi)
Endif

aL[08]:="|                                                     | Titular   |######|######|######|######|######|######|######|######|######|######|######|######|######|######| ##########|"
aL[09]:="|                                                     | Dependente|######|######|######|######|######|######|######|######|######|######|######|######|######|######| ##########|"
aL[10]:="|                                                     | Agregado  |######|######|######|######|######|######|######|######|######|######|######|######|######|######| ##########|"
aL[11]:="|                                                     +-----------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+-----------+"
aL[12]:="|                                                     | TOTAIS    |    #########|    #########|    #########|    #########|    #########|    #########|    #########| ##########|"
aL[13]:="|-----------------------------------------------------+-----------+-------------+-------------+-------------+-------------+-------------+-------------+-------------+-----------+"

@ nLi,01 Psay cCodPla+' - '+Substr(cDesPla,1,45)
FmtLin(aLinTit,aL[08],,,@nLi)
FmtLin(aLinDep,aL[09],,,@nLi)
FmtLin(aLinAgr,aL[10],,,@nLi)
FmtLin({},aL[11],,,@nLi)
FmtLin(aValTxt,aL[12],,,@nLi)
FmtLin({},aL[13],,,@nLi)

Return()

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Fun��o    �ProcTotGer� Autor � Luzio Tavares         � Data �26.02.2008���
�������������������������������������������������������������������������Ĵ��
���Descri��o �Processa Total Geral                                        ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
*/
Static Function ProcTotGer()

Local aL := Array(09)

//
//       12345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
aL[01]:="+===============================================================================================================================================================================+"
aL[02]:="| Resumo Geral                                                                                                                                                                  |"
aL[03]:="+===============================================================================================================================================================================+"
aL[04]:="|                                                     | Titular   |######|######|######|######|######|######|######|######|######|######|######|######|######|######| ##########|"
aL[05]:="|                                                     | Dependente|######|######|######|######|######|######|######|######|######|######|######|######|######|######| ##########|"
aL[06]:="|                                                     | Agregado  |######|######|######|######|######|######|######|######|######|######|######|######|######|######| ##########|"
aL[07]:="|                                                     +-----------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+-----------+"
aL[08]:="|                                                     | TOTAIS    |    #########|    #########|    #########|    #########|    #########|    #########|    #########|  #########|"
aL[09]:="|-----------------------------------------------------+-----------+-------------+-------------+-------------+-------------+-------------+-------------+-------------+-----------+"

//��������������������������������������������������������������������������Ŀ
//� Imprime cabecalho...                                                     �
//����������������������������������������������������������������������������
If nLi > nQtdLin
	nLi := Cabec(cTitulo,cCabec1,cCabec2,cRel,cTamanho,nTipo)
	++nLi
Endif

FmtLin({},aL[01],,,@nLi)
FmtLin({},aL[02],,,@nLi)
FmtLin({},aL[03],,,@nLi)
FmtLin(aLinTotTit,aL[04],,,@nLi)
FmtLin(aLinTotDep,aL[05],,,@nLi)
FmtLin(aLinTotAgr,aL[06],,,@nLi)
FmtLin({},aL[07],,,@nLi)
FmtLin(aValTotTxt,aL[08],,,@nLi)
FmtLin({},aL[09],,,@nLi)

Return()