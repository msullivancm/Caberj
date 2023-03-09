#Define CRLF Chr(13)+Chr(10)
#Include "PLSR240.CH"
#Include "PROTHEUS.CH"
#Include "PLSMGER.CH"
#Include "rwmake.ch"
#Include "Topconn.ch"
#Include "RPTDEF.CH"
#Include "Ap5Mail.Ch"
#INCLUDE "COLORS.ch"
#Include "TbiCode.ch"
//#include "Msole.CH"


#DEFINE c_ent CHR(13) + CHR(10)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ?BOL_BRADES?Autor ?Rafael Fernandes     ?Data ?10.10.13  ³±?
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄ´±± 
±±³Descricao ?Impressao boleto bancario BADESCO / BASEADO ROTINA BOL_ITAU ³±?
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±?Uso      ?Advanced Protheus                                           ³±?
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±³Atualizções ?22/10/13 - Vitor Sbano                                    ³±?
±±?           ?variable does not exist CDIGITO on U_RETDADOS(RET_CBA     ³±?
±±?           ?variable does not exist ADADOSBANCO on CNABTIPO7(         ³±?
±±?           ?                                                          ³±?
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Atualizções ? 27/11/13 - Roberto Mendes                                ³±?
±±?           ?                                                          ³±?
±±?           ?                                                          ³±?
±±?           ?                                                          ³±?
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Atualizções ?28/11/13 - Vitor Sbano                                    ³±?
±±?           ?- Correcao de Nosso Numero / Calculo DV                   ³±?
±±?           ?                                                          ³±?
±±?           ?                                                          ³±?
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Atualizções ?03/12/13 - Vitor Sbano                                    ³±?
±±?           ?- Correcao de Posicionamento de Cad. Clientes (SA1)       ³±?
±±?           ?- Correcao de Identificacao de Numero Convenio            ³±?
±±?           ?                                                          ³±?
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Atualizções ?05/12/13 - Vitor Sbano                                    ³±?
±±?           ?- Correcao de Identificacao Carteira (reimpressao)        ³±?
±±?           ?- Carteira 06 - conforme informção Allan                  ³±?
±±?           ?- parâmetro MV_PAR17                                      ³±?
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Atualizções ?10/12/13 - Vitor Sbano                                    ³±?
±±?           ?- Correcao de Identificacao Especie Documento (           ³±?
±±?           ?- reimpressao                                             ³±?
±±?           ?                                                          ³±?
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Atualizções ?13/12/13 - Vitor Sbano                                    ³±?
±±?           ?- Correcao de Calculo DV - CalcDVBrad(cStr)               ³±?
±±?           ?                                                          ³±?
±±?           ?                                                          ³±?
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Atualizções ?20/02/15 - Altamiro                                       ³±?
±±?           ?- Criado mensagem "As informações sobre reembolso de      ³±?
±±?           ?      despesas médicas estão disponíveis no site na área  ³±?
±±?           ?      restrita ao associado www.caberj.com.br"            ³±?
±±?           ?      Conforme email da Sra. Denize                       ³±?
±±?           ?                                                          ³±?
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±

/*/

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//?Define nome da funcao                                                    ?
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
User Function BOL_BRADES(nRegSE1, a_Anexos, l_SV)
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//?Define variaveis padroes para todos os relatorios...                     ?
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	
	Private nQtdLin		:= 60
	Private cTamanho	:= "G"
	Private cTitulo		:= "Emissao dos boletos de cobranca  - BRADESCO"
	Private cDesc1		:= STR0002 //"Emissao dos boletos de cobranca de acordo com os parametros selecionados."
	Private cDesc2		:= "Grupo CABERJ - Versão 13.12.2013"
	Private cDesc3		:= ""
	Private cAlias		:= "SE1"
	Private cPerg		:= "BOLBRADES"
	Private cRel		:= "BOL_BRADES"//"BOLITAU"
	Private nli			:= 80
	Private m_pag		:= 1
	Private lCompres	:= .F.
	Private lDicion		:= .F.
	Private lFiltro		:= .T.
	Private lCrystal	:= .F.
	Private aOrderns	:= {}
	Private aReturn		:= { "", 1,"", 1, 1, 1, "",1 }
	Private lAbortPrint	:= .F.
	Private aCritica	:= {}
	Private _cSeqNom	:= ""
	Private cNumProc	:= ""
	Private  cText      := ""
	Private cfamilia 	:= ""
	private cvalmat     := ""
	Private cCartCob	:= ""
	Private cConvenio	:= ""
	Private c_LogGer    := ""
	Private n_SeqCNAB   := GetMV("MV_YSEQCNA")
	Private c_Nome 		:= ""
	Private c_Email 	:= ""
	
	Private a_Anexo 	:={}
	
	Private l_DisableSetup  	:= .T.
	Private l_AdjustToLegacy 	:= .T.
	Private l_Segunda	:= l_SV
	
	Default nRegSE1		:= 0
	
	Default a_Anexos	:= {}
	
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//?Chama Pergunte Invariavelmente                                           ?
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	CriaSX1(cPerg)
	
	If nRegSE1 == 0  .AND. (FunName() <> "CABA615" .AND. FunName() <> "CFGX019" .AND. FunName() <> "CABA091")
		Pergunte(cPerg,.T.)
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//?Opcao de impressao por Faturas.                                          ?
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If MV_PAR29 == 2 // Fatura
			If MV_PAR17 == 2  // 175 - Reimpressão
				// Boletos tipo fatura são emitidos por outro programa.
				U_CABFTBRAD()
				Return
			Else
				Aviso( "Tipo de Impresso Incorreto!", "Boleto Tipo Fatura apenas pode ser emitido para Tipo de Impresso = 175!", {"Ok"} )
				Return
			EndIf
		EndIf
		
	EndIf
	
	If !l_Segunda
		cRel := SetPrint(	cAlias	, cRel		, cPerg		,  @cTitulo	,;
			cDesc1	, cDesc2	, cDesc3	, lDicion	,;
			aOrderns, lCompres	, cTamanho	, {}		,;
			lFiltro	, lCrystal)
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//?Verifica se foi cancelada a operacao (padrao)                            ?
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If nLastKey  == 27
			Return
		EndIf
		
	EndIf
	
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//?Definicao de variaveis a serem utilizadas no programa...                 ?
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If nRegSE1 > 0
		
		SE1->(DbGoTo(nRegSE1))
		
		cCliDe		:= Space(6)
		cLojDe		:= Space(2)
		cCliAte		:= Replicate("Z",6)
		cLojAte		:= Replicate("Z",2)
		cOpeDe		:= Space(4)
		cOpeAte		:= Replicate("Z",4)
		cEmpDe		:= Space(4)
		cEmpAte		:= Replicate("Z",4)
		cConDe		:= Space(12)
		cConAte		:= Replicate("Z",12)
		cSubDe		:= Space(9)
		cSubAte		:= Replicate("Z",9)
		cMatDe		:= Space(6)
		cMatAte		:= Replicate("Z",6)
		cMesTit		:= SE1->E1_MESBASE
		cAnoTit		:= SE1->E1_ANOBASE
		nTipCob		:= iIf(l_Segunda, 4, 2  )
		cPrefDe		:= SE1->E1_PREFIXO
		cPrefAte	:= SE1->E1_PREFIXO
		cNumDe		:= SE1->E1_NUM
		cNumAte		:= SE1->E1_NUM
		cParcDe		:= SE1->E1_PARCELA
		cParcAte	:= SE1->E1_PARCELA
		cTipoDe		:= SE1->E1_TIPO
		cTipoAte	:= SE1->E1_TIPO
		c_Banco     := SE1->E1_PORTADO
		c_Agencia	:= SE1->E1_AGEDEP
		c_Conta     := SE1->E1_CONTA
		c_Subconta	:= '001' //Comentado por Luiz Otavio Campos em 12/03/2021

		/*Adicionado para buscar a carteira da subconta corretamente  por Luiz Otavio Campos em 12/03/2021*/
		DbSelectArea("SEA")
		DbSetOrder(1)	
		If DbSeek(xFilial("SEA")+SE1->E1_NUMBOR+SE1->E1_PREFIXO+SE1->E1_NUM+SE1->E1_PARCELA+SE1->E1_TIPO)
			
			If Empty(SEA->EA_XSUBCON)		
				c_Subconta:= SEA->EA_XSUBCON
			Else
				c_Subconta := "001"
			EndIf	
		EndIf

		/*************************************************************/
		cNmBorDe	:= Space(6)
		cNmBorAt	:= Replicate("Z",6)
		
	ElseIf FunName() == "CABA615" .or. FunName() == "CFGX019" .Or. FunName() == "CABA091"
		
		
		cCliDe		:= " "
		cLojDe		:= " "
		cCliAte		:= "ZZZZZZ"
		cLojAte		:= "ZZ"
		cOpeDe		:= " "
		cOpeAte		:= "ZZZZ"
		cEmpDe		:= " "
		cEmpAte		:= "ZZZZ"
		cConDe		:= " "
		cConAte		:= "ZZZZZZZZZZZZ"
		cSubDe		:= " "
		cSubAte		:= "ZZZZZZZZZ"
		cMatDe		:= " "
		cMatAte		:= "ZZZZZZ"
		cMesTit		:= MV_PAR02
		cAnoTit		:= MV_PAR01
		nTipCob		:= 4
		cPrefDe		:= " "
		cPrefAte	:= "ZZZ"
		cNumDe		:= " "
		cNumAte		:= "zzzzzzzzz"
		cParcDe		:= " "
		cParcAte	:= "ZZ"
		cTipoDe		:= " "
		cTipoAte	:= "ZZ"
		cNmBorDe	:= MV_PAR03
		cNmBorAt	:= MV_PAR04
		
		c_Banco     := " "
		c_Agencia	:= " "
		c_Conta     := " "
		c_Subconta	:= " "
		
	Else
		
		cCliDe		:= mv_par01
		cLojDe		:= mv_par02
		cCliAte		:= mv_par03
		cLojAte		:= mv_par04
		cOpeDe		:= mv_par05
		cOpeAte		:= mv_par06
		cEmpDe		:= mv_par07
		cEmpAte		:= mv_par08
		cConDe		:= mv_par09
		cConAte		:= mv_par10
		cSubDe		:= mv_par11
		cSubAte		:= mv_par12
		cMatDe		:= mv_par13
		cMatAte		:= mv_par14
		cMesTit		:= mv_par15
		cAnoTit		:= mv_par16
		nTipCob		:= Iif(FunName() == "PLSA730",2,mv_par17)
		cPrefDe		:= mv_par18
		cPrefAte	:= mv_par19
		cNumDe		:= mv_par20
		cNumAte		:= mv_par21
		cParcDe		:= mv_par22
		cParcAte	:= mv_par23
		cTipoDe		:= mv_par24
		cTipoAte	:= mv_par25
		cNmBorDe	:= mv_par27
		cNmBorAt	:= mv_par28
		
		c_Banco     := mv_par30
		c_Agencia	:= mv_par31
		c_Conta     := mv_par32
		c_Subconta	:= mv_par33
		
		
	EndIf
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//?Configura impressora (padrao)                                            ?
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If !l_Segunda
		SetDefault(aReturn,cAlias)
	EndIf
	/*
	If cEmpAnt == '02'
		
		Alert("Rotina não pode ser executada na Integral. Favor chamar a rotina de boleto integral (Bol_integral)!")
		Return
		
	EndIf
	*/
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//?Emite relat¢rio                                                          ?
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	Processa({|| GeraBol() }, cTitulo, "", .T.)
	
Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa   ?R240Imp  ?Autor ?Rafael M. Quadrotti   ?Data ?14.06.02 ³±?
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao  ?Imprime detalhe do relatorio...                            ³±?
±±ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
/*/

Static Function GeraBol()
	
	Local nForc 	:= 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS
	Local nPCont 	:= 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS
	Local nPCont1 	:= 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//?Define variaveis...                                                      ?
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	Local cSQL			:= ""							// Select deste relatorio
	Local cSE1Name 		:= SE1->(RetSQLName("SE1"))	// Retorna o nome do alias no TOP
	Local cSA1Name 		:= SA1->(RetSQLName("SA1"))	// Retorna o nome do alias no TOP
	Local cPrefixo 		:= ""							// Prefixo do titulo
	Local cTitulo 		:= ""							// Titulo
	Local cParcela 		:= ""							// Parcela do titulo
	Local cTipo 		:= ""							// E1_TIPO
	Local aDadosEmp		:= {}							// Array com os dados da empresa.
	Local aDadosTit		:= {}							// Array com os dados do titulo
	Local aDatSacado	:= {}							// Array com os dados do Sacado.
	Local aBmp			:= { "" }						// Vetor para Bmp.
	Local cOperadora    := BX4->(PLSINTPAD())			// Retorna a operadora do usuario.
	Local aBfq			:= {}
	Local aDependentes	:= {}							// Array com os dependentes do sacado.
	Local aOpenMonth	:= {}							// Array com os meses em aberto.
	Local aObservacoes  := {}							// Array com as observacoes do extrato.
	Local aMsgBoleto    := {}							// Array com as mensagens do boleto.
	Local nPos			:= 0							// Variavel auxiliar para ascan.
	Local cSA6Key		:= ""							// Chave de pesquisa do SA6 Cadastro de bancos,
	Local aCobranca		:= {}
	Local cUsuAnt       := ""
	Local lNome			:= .T.
	Local cNumAtu		:= ""
	Local lPrima		:= .T.
	Local cString		:= ""
	Local _cNomRDA		:= ""
	Local lNewIndice 	:= FaVerInd()
	
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//?Variaveis necessarias para a mensagem de reajuste / ANS...               ?
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	Local cPerRea		:= ""
	Local cCodPla		:= ""
	Local cNomPRe		:= ""
	Local cNumANS		:= ""
	Local cPatroc		:= ""
	Local cContANS		:= ""
	Local aPlaRea		:= {}
	Local cOfiANS		:= GetNewPar("MV_YPOFANS","")
	Local cEleImp		:= ""
	Local nReg			:= 0
	Local nRegCab		:= 0
	Local aMatExi		:= {}
	Local _cSQLUti		:= ""
	Local _cCodFamUti	:= ""
	Local _nPosTmp		:= 0
	Local aNewBFQ		:= {}
	
	Local _nRegPro		:= 0
	Local _nTotSE1		:= 0
	Local nRegs			:= 0
	Local nVlrTotBol	:= 0
	Local 	cQrySE1
	Local 	cArqSE1		:= GetNextAlias()
	
	Private aDadosBanco   := {}							// Array com os dados do banco - alteração de escopo local para private - Rafael Fernandes 24/10/2013
	Private CB_RN_NN  	:= {}							// Array com as informacoes do Nosso Numero, Codigo de Barras, e Linha digitavel.
	Private cSeqArq		:= "000001"
	Private cEOL		:= CHR(13)+CHR(10)
	Private nHdl
	
	Private lMosRea		:= .F.
	
	Private aMsgRea		:= {}
	Private lFoundSE1	:= .F.
	Private	cDirExp		:= GETNEWPAR("MV_YBOLGR","\Exporta\ANLGRAF\")
	Private cCart		    := ""							// Carteira do titulo
	
	Private lIntegral		:= (cEmpAnt == '02')//.F.
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//?Array para impressao do analitico (opcao 3)...                           ?
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	
	Private aImp 		:= {}
	Private a1_40ca4	:= {}
	Private a1_102ca3	:= {}
	Private a1_102mca32	:= {}
	
	Private a2_40ca4	:= {}
	Private a2_102ca3	:= {}
	Private a2_102mca32	:= {}
	Private a3_40ca4	:= {}
	Private a3_102ca3	:= {}
	Private a3_102mca32	:= {}
	
	Private a4_40ca4	:= {}
	Private a4_102ca3	:= {}
	Private a4_102mca32	:= {}
	
	Private aMatUti		:= {}
	
	Private cArray		:= ""
	
	Private _aErrAnlt	:= {}
	
	Private cQtdEx      := '000000'
	
	Private c_XTitulo := ""
	
	Private _cAliQry		:= GetNextAlias() //Angelo Henrique - Data:18/08/2015
	
	
	DbSelectArea("SEE")
	If DBSeek(xFilial("SEE")+c_Banco+c_Agencia+c_Conta+c_Subconta)
		
		//Leonardo Portella - 25/03/14 - Chamado ID 10833 - Inicio - Com o fonte pegando da SEE (parametros de bancos - CNAB), nao estava trazendo a  Conta e o DV da Conta,
		//fazendo com que as linhas tipo 1 ficassem com menos colunas, sendo rejeitadas pela Interway.
		
		//cConvenio	:=	alltrim(SEE->EE_CODEMP)				&& 00090336900088951
		cConvenio	:=	PadR(Alltrim(SEE->EE_CODEMP),12) + PadR(Alltrim(SEE->EE_CONTA),4) + PadR(Alltrim(SEE->EE_DVCTA),1)
		
		//Leonardo Portella - 25/03/14 - Chamado ID - Fim
		
	ElseIf (ALLTRIM(FunName()) <> "CABA615"  .and.  ALLTRIM(FunName())  <> "CFGX019" .and.  ALLTRIM(FunName())  <> "CABA091")
		msginfo(" Atenção: Parametro de Banco nao encontrado ! ("+c_Banco+" "+c_Agencia+" "+c_Conta+" "+c_Subconta+")","Convenio Cobranca")
		return
	Else
		//-----------------------------------------------------------------------
		//Angelo Henrique - Data: 04/06/2021
		//-----------------------------------------------------------------------
		//Acrescentado para validar demais problemas quando os parametros bancários 
		//não é encontrado
		//-----------------------------------------------------------------------
		msginfo(" Atenção: Parametro de Banco nao encontrado ! ("+c_Banco+" "+c_Agencia+" "+c_Conta+" "+c_Subconta+")","Convenio Cobranca")
		return
	Endif
	
	
	//
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Fazendo a verificacao da existencia do RDMAKE antes do processa-?
	//³mento.                                                          ?
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If !ExistBlock("RETDADOS")
		MsgInfo(STR0056)
		Return NIL
	EndIf
	//
	//  *** Preenchimento de E1_NUMBCO e E1_IDCNAB em Tabela SE1
	//
	cQrySE1 := 	"SELECT SE1.E1_FILIAL, SE1.E1_PREFIXO, SE1.E1_NUM, SE1.E1_PARCELA, SE1.E1_TIPO, SE1.E1_CLIENTE, SE1.E1_LOJA, SE1.E1_NUMBOR, SE1.E1_IDCNAB, SE1.E1_NUMBCO,SE1.R_E_C_N_O_ "+CRLF
	cQrySE1 += 	" FROM "+cSE1Name+" SE1, "+cSA1Name+" SA1 "+CRLF
	cQrySE1 += 	" WHERE E1_FILIAL = '" + xFilial("SE1") + "' AND "+CRLF
	cQrySE1 += 	" E1_CLIENTE||E1_LOJA >= '"+cCliDe+cLojDe+"' AND "+CRLF
	cQrySE1 += 	" E1_CLIENTE||E1_LOJA <= '"+cCliAte+cLojAte+"' AND "+CRLF
	cQrySE1 += 	" A1_FILIAL = '"+xFilial("SA1")+"' AND "+CRLF
	cQrySE1 += 	" E1_CLIENTE = A1_COD AND "+CRLF
	cQrySE1 += 	" E1_LOJA = A1_LOJA AND "+CRLF
	cQrySE1 += 	" E1_PREFIXO >= '"+cPrefDe+"' AND E1_PREFIXO <= '"+cPrefAte+"' AND "+CRLF
	cQrySE1 += 	" E1_NUM >= '"+cNumDe+"' AND E1_NUM <= '"+cNumAte+"' AND "+CRLF
	cQrySE1 += 	" E1_PARCELA >= '"+cParcDe+"' AND E1_PARCELA <= '"+cParcAte+"' AND "+CRLF
	cQrySE1 += 	" E1_TIPO >= '"+cTipoDe+"' AND E1_TIPO <= '"+cTipoAte+"' AND "+CRLF
	cQrySE1 += 	" E1_CODINT >= '"+cOpeDe+"' AND E1_CODINT <= '"+cOpeAte+"' AND "+CRLF
	cQrySE1 += 	" E1_CODEMP >= '"+cEmpDe+"' AND E1_CODEMP <= '"+cEmpAte+"' AND "+CRLF
	cQrySE1 += 	" E1_CONEMP >= '"+cConDe+"' AND E1_CONEMP <= '"+cConAte+"' AND "+CRLF
	cQrySE1 += 	" E1_SUBCON >= '"+cSubDe+"' AND E1_SUBCON <= '"+cSubAte+"' AND "+CRLF
	cQrySE1 += 	" E1_MATRIC >= '"+cMatDe+"' AND E1_MATRIC <= '"+cMatAte+"' AND "+CRLF
	cQrySE1 += 	" E1_ANOBASE||E1_MESBASE = '"+cAnoTit+cMesTit+"' AND "+CRLF
	cQrySE1 += 	" E1_PARCELA <> '" + StrZero(0, Len(SE1->E1_PARCELA)) + "' AND " +CRLF
	cQrySE1 += 	" E1_NUMBOR >= '"+cNmBorDe+"' AND E1_NUMBOR <= '"+cNmBorAt+"' AND "  +CRLF
	cQrySE1 += 	" E1_PORTADO = '237' AND "  +CRLF
	//cQrySE1 += 	" E1_SITUACA <> '0' AND "+CRLF
	**'INI - Marcela Coimbra - 16/05/2014. Pegar títulos com baixa parcial'**
	cQrySE1 += 	" E1_SALDO > 0 AND "+CRLF
	
	**'FIM - Marcela Coimbra - 16/05/2014. Pegar títulos com baixa parcial'**
	
	cQrySE1 += " E1_NUM NOT IN ('006216','006250','006256','006261','006262','006450','006436') AND "+CRLF
	//cQrySE1 += 	" E1_ORIGEM = 'PLSA510' AND "+CRLF
	
	**'INI - Marcela Coimbra - 16/05/2014. Pegar títulos com baixa parcial'**
	//cQrySE1 += 	" E1_SALDO = E1_VALOR AND "+CRLF // Motta Julho09 evitar erro diferença caso o título seja movimentado
	**'FIM - Marcela Coimbra - 16/05/2014. Pegar títulos com baixa parcial'**
	
	**'INI - Marcela Coimbra - 09/12/2015. S?pegar boletos prefeitura'**
	
	//cQrySE1 += 	" ( (E1_CODEMP = '0024' AND E1_XSERNF  = 'BOL') OR  E1_CODEMP <> '0024' ) AND "  + CRLF
	//cQrySE1 += 	" ( ( E1_CODEMP <> '0024' and E1_FORMREC in ( '"+GetNewPar("MV_YRCCNAB","04")+"' , '03') ) OR (E1_CODEMP = '0024' AND E1_FORMREC = '09' )) AND " +CRLF//Inserido para evitar re-impressao em tipo diferente...
	**'FIM - Marcela Coimbra - 09/12/2015. S?pegar boletos prefeitura'**
	//cQrySE1 += 	" E1_FORMREC = '"+GetNewPar("MV_YRCCNAB","04")+"' AND " +CRLF//Inserido para evitar re-impressao em tipo diferente...
	//cQrySE1 += 	" ( E1_FORMREC IN ('01','02','06','08') OR (E1_FORMREC = '04' AND E1_YEXANLT = '1' ) ) AND "+CRLF
	cQrySE1 += 	" E1_NUMBOR <> ' ' AND  E1_PREFIXO <> 'RLE'  "+CRLF
	//
	If ! Empty(aReturn[7])
		cQrySE1 += PLSParSQL(aReturn[7]) + " AND "+CRLF
	Endif
	cQrySE1 += "AND SE1.D_E_L_E_T_ = ' ' AND "+CRLF
	cQrySE1 += "SA1.D_E_L_E_T_ = ' ' "+CRLF
	
	// Mateus Medeiros - 25/01/2019 - somente enviar?boletos que não estiverem sido enviado e não
	// constam na tabela de log de envio de email.
	if Upper(Alltrim(FUNNAME())) == "CABA615" .OR. Upper(Alltrim(FUNNAME())) == "CABA091" .OR. Upper(Alltrim(FUNNAME())) == "CFGX019"
		cQrySE1 += "AND NOT EXISTS	"+CRLF
		cQrySE1 += "("+CRLF
		cQrySE1 += "SELECT * FROM SIGA.LOG_ENVIO_BOLETO_EMAIL WHERE TITULO = E1_NUM"+CRLF
		
		//cQrySE1 += "AND SUBSTR(MATRICULA,1,14) = E1_CODINT||E1_CODEMP||E1_MATRIC"+CRLF
		cQrySE1 += "AND TRIM(SIGA.LOG_ENVIO_BOLETO_EMAIL.COMPETENCIA) = '"+cAnoTit+cMesTit+"'"+CRLF
		cQrySE1 += "AND SIGA.LOG_ENVIO_BOLETO_EMAIL.ENVIADO = 'SIM'"+CRLF
		cQrySE1 += ")"+CRLF
	endif
	cQrySE1 += "ORDER BY " + StrTran(SE1->(IndexKey()),"+",",") +CRLF
	//
	MemoWrite("C:\Temp1\BOL_BRAD_359.txt",cQrySE1)
	//
	
	If Select(cArqSE1) > 0
		dbSelectArea(cArqSE1)
		dbCloseArea()
	EndIf
	
	
	
	DbUseArea(.T., 'TOPCONN', TCGenQry(,,cQrySE1), cArqSE1, .F., .T.)
	dbSelectArea(cArqSE1)
	
	(cArqSE1)->(dbEval({||nRegs++}))
	(cArqSE1)->(dbGoTop())
	//ProcRegua((cArqSE1)->(RecCount()))
	
	ProcRegua(nRegs)
	//
	Do While !(cArqSE1)->( eof() )
		//
		cIdCnab		:=	""
		_nE1RECN	:=	(cArqSE1)->R_E_C_N_O_
		_cIDCNAB	:=	(cArqSE1)->E1_IDCNAB
		_cNUMBCO	:=	(cArqSE1)->E1_NUMBCO
		lAltera	:= .f.
		
		c_Nome 		:= ""
		c_Email 	:= ""
		
		//
		If empty(_cIDCNAB)			&& Atualizacao IDCNAB
			//
			cIdCnab := GetSxENum("SE1", "E1_IDCNAB","E1_IDCNAB"+cEmpAnt,Iif(lNewIndice,19,16))
			ConfirmSx8()
			lAltera	:= .t.
			//
		Else
			//
			cIdCnab	:=	_cIDCNAB
			//
		Endif
		//
		//
		If empty(_cNUMBCO)			&& Atualizacao Nosso  NUmero
			//
			//	PutSx1(cPerg,"30",OemToAnsi("Banco")				,"","","mv_chu","C",03,0,0,"G","","SA6","","","mv_par30","","","","","","","","","","","","","","","","",{},{},{})
			//	PutSx1(cPerg,"31",OemToAnsi("Agencia")				,"","","mv_chw","C",05,0,0,"G","",""   ,"","","mv_par31","","","","","","","","","","","","","","","","",{},{},{})
			//	PutSx1(cPerg,"32",OemToAnsi("Conta")				,"","","mv_chx","C",10,0,0,"G","",""   ,"","","mv_par32","","","","","","","","","","","","","","","","",{},{},{})
			//	PutSx1(cPerg,"33",OemToAnsi("SubConta")				,"","","mv_chy","C",03,0,0,"G","",""   ,"","","mv_par33","","","","","","","","","","","","","","","","",{},{},{})
			//
			DbSelectArea("SEE")
			If DBSeek(xFilial("SEE")+MV_PAR30+MV_PAR31+MV_PAR32+MV_PAR33)
				//
				_cNUMBCO 	:= SEE->EE_FAXATU
				//INCREMENTA O NOSSO NUMERO
				cNumAtu := soma1(Substr(SEE->EE_FAXATU,1,Len(Alltrim(SEE->EE_FAXATU))))
				SEE->(RecLock("SEE",.F.))
				SEE->EE_FAXATU := cNumAtu
				SEE->(MsUnlock())
				//
			Endif
			//
			lAltera	:= .t.
			//
		Else
			//
			cIdCnab	:=	_cIDCNAB
			//
		Endif
		//
		If lAltera
			//
			DbSelectArea("SE1")
			DbGoto(_nE1RECN)
			Reclock("SE1",.F.)
			SE1->E1_IDCNAB 	:= 	cIdCnab
			SE1->E1_NUMBCO	:=	_cNUMBCO
			MsUnlock()
			//
		Endif
		//
		(cArqSE1)->(DbSkip())
		//
	Enddo
	
	
	
	
	//
	//
	// *****************************************************************************
	//
	SE1->(DbSetOrder(1))
	BAU->(DbSetOrder(1))
	
	If nTipCob <> 1
		
		oPrint:= TMSPrinter():New( STR0003 ) //"Boleto Laser"
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Verifica se as configuracoes de impressora foram definidas para ?
		//³que o objeto possa ser trabalhado.                              ?
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		
		If !(oPrint:IsPrinterActive())
			Aviso(STR0041,STR0042,{"OK"})   //"Impressora"###"As configurações da impressora não foram encontradas. Por favor, verifique as configurações para utilizar este relatório. "
			oPrint:Setup()
			Return (.F.)
		EndIf
		
	Endif
	
	
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//?Monta query...                                                           ?
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	For nForC := 1 to 2
		
		If nForC == 1
			cSQL := 	"SELECT COUNT(SE1.R_E_C_N_O_) AS TOTSE1"+CRLF
		Else
			//		cSQL := 	"SELECT SE1.* , A1_CEP, E1_SALDO SALDO "+CRLF
			cSQL := 	"SELECT SE1.* , A1_CEP, E1_SALDO SALDO "+CRLF
			//		cSQL := 	"SELECT SE1.* , A1_CEP, DECODE( E1_CODEMP, '0024', (SELECT SALDO FROM tmpsalse1 WHERE tmpsalse1.E1_NUM = SE1.E1_NUM and rownum = 1), E1_SALDO) SALDO "+CRLF
		Endif
		
		cSQL += 	" FROM "+cSE1Name+" SE1, "+cSA1Name+" SA1 "+CRLF
		cSQL += 	" WHERE E1_FILIAL = '" + xFilial("SE1") + "' AND "+CRLF
		cSQL += 	" E1_CLIENTE||E1_LOJA >= '"+cCliDe+cLojDe+"' AND "+CRLF
		cSQL += 	" E1_CLIENTE||E1_LOJA <= '"+cCliAte+cLojAte+"' AND "+CRLF
		cSQL += 	" A1_FILIAL = '"+xFilial("SA1")+"' AND "+CRLF
		cSQL += 	" E1_CLIENTE = A1_COD AND "+CRLF
		cSQL += 	" E1_LOJA = A1_LOJA AND "+CRLF
		cSQL += 	" E1_PREFIXO >= '"+cPrefDe+"' AND E1_PREFIXO <= '"+cPrefAte+"' AND "+CRLF
		cSQL += 	" E1_NUM >= '"+cNumDe+"' AND E1_NUM <= '"+cNumAte+"' AND "+CRLF
		cSQL += 	" E1_PARCELA >= '"+cParcDe+"' AND E1_PARCELA <= '"+cParcAte+"' AND "+CRLF
		cSQL += 	" E1_TIPO >= '"+cTipoDe+"' AND E1_TIPO <= '"+cTipoAte+"' AND "+CRLF
		cSQL += 	" E1_CODINT >= '"+cOpeDe+"' AND E1_CODINT <= '"+cOpeAte+"' AND "+CRLF
		cSQL += 	" E1_CODEMP >= '"+cEmpDe+"' AND E1_CODEMP <= '"+cEmpAte+"' AND "+CRLF
		cSQL += 	" E1_CONEMP >= '"+cConDe+"' AND E1_CONEMP <= '"+cConAte+"' AND "+CRLF
		cSQL += 	" E1_SUBCON >= '"+cSubDe+"' AND E1_SUBCON <= '"+cSubAte+"' AND "+CRLF
		cSQL += 	" E1_MATRIC >= '"+cMatDe+"' AND E1_MATRIC <= '"+cMatAte+"' AND "+CRLF
		cSQL += 	" E1_ANOBASE||E1_MESBASE = '"+cAnoTit+cMesTit+"' AND "+CRLF
		cSQL += 	" E1_PARCELA <> '" + StrZero(0, Len(SE1->E1_PARCELA)) + "' AND " +CRLF
		cSQL += 	" E1_NUMBOR >= '"+cNmBorDe+"' AND E1_NUMBOR <= '"+cNmBorAt+"' AND "  +CRLF
		//Incluido por Rafael Fernandes - 15/10/13
		// Filtro para buscar apenas títulos do bradesco
		cSQL += 	" E1_PORTADO = '237' AND "  +CRLF
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//?Nova regra: caso seja analitico, permitir impressao mesmo com saldo 0 e  ?
		//?titulos nao transferidos (carteira). Data: 8/11/07.                      ?
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If nTipCob <> 3
			//		alert("Situac")
			//cSQL += 	" E1_SITUACA <> '0' AND "+CRLF
			//cSQL += 	" E1_PLNUCOB in( '000100011792', '000100011794', '000100011795' ) AND "
			cSQL += 	" E1_SALDO > 0 AND "+CRLF
			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//?Nova regra: detectada inconsistencia na consolidacao (consolidado, re-   ?
			//?valorizado e nao re-consolidado). Nestes casos, os extratos estao        ?
			//?diferentes do valor cobrado. Nao imprimir extrato de utilizacao.         ?
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			cSQL += " E1_NUM NOT IN ('006216','006250','006256','006261','006262','006450','006436') AND "+CRLF
		Endif
		
		//Verificado que usuarios do financeiro estavam imprimindo titulos
		//migrados, e esta impressao nao eh suportada. Inserida validacao
		//para negar tais situacoes (fixo prefixo PLS).
		**'Marcela Coimbra - IMPRESSÃO DE BOLETOS DE FATURA'**
		//	cSQL += 	" E1_ORIGEM = 'PLSA510' AND "+CRLF
		//  cSQL += 	" ( E1_ORIGEM = 'PLSA510' OR ( E1_ORIGEM <> 'PLSA510' AND E1_TIPO = 'FT' ) ) AND "+CRLF
		cSQL += 	" E1_NUMBOR <> ' ' AND "+CRLF
		
		If nTipCob == 1 //CNAB 112
			
			cSQL += 	" E1_SALDO > 0 AND "+CRLF // Motta Julho09 evitar erro diferença caso o título seja movimentado
			
		ElseIf nTipCob == 4 //Envio de Boleto em lote apenas para 112
			
			cSQL += 	" E1_FORMREC = '04' AND "+CRLF
			
		Endif
		
		If ! Empty(aReturn[7])
			cSQL += PLSParSQL(aReturn[7]) + " AND "+CRLF
		Endif
		cSQL += "SE1.D_E_L_E_T_ = ' ' AND "+CRLF
		cSQL += "SA1.D_E_L_E_T_ = ' ' "+CRLF
		
		// Mateus Medeiros - 25/01/2019 - somente enviar?boletos que não estiverem sido enviado e não
		// constam na tabela de log de envio de email.		
		if Upper(Alltrim(FUNNAME())) == "CABA615" .OR. Upper(Alltrim(FUNNAME())) == "CABA091" .OR. Upper(Alltrim(FUNNAME())) == "CFGX019"
			cSQL += "AND NOT EXISTS	"+CRLF
			cSQL += "("+CRLF
			cSQL += "SELECT * FROM SIGA.LOG_ENVIO_BOLETO_EMAIL WHERE TITULO = E1_NUM"+CRLF
			
			//cQrySE1 += "AND SUBSTR(MATRICULA,1,14) = E1_CODINT||E1_CODEMP||E1_MATRIC"+CRLF
			cSQL += "AND TRIM(SIGA.LOG_ENVIO_BOLETO_EMAIL.COMPETENCIA) = '"+cAnoTit+cMesTit+"'"+CRLF
			cSQL += "AND SIGA.LOG_ENVIO_BOLETO_EMAIL.ENVIADO = 'SIM'"+CRLF
			cSQL += ")"+CRLF
		endif
		
		If nForC == 1
			PLSQuery(cSQL,"R240Imp")
			_nTotSE1 := R240Imp->(TOTSE1)
			R240Imp->(DbCloseArea())
		Else
			If nTipCob == 3
				cSQL += "ORDER BY E1_FORMREC, A1_CEP "+CRLF
			Else
				cSQL += "ORDER BY " + StrTran(SE1->(IndexKey()),"+",",") +CRLF
			Endif
		Endif
		
	Next
	
	MemoWrit("C:\temp\BORD.TXT", cSQL)
	
	PLSQuery(cSQL,"R240Imp")
	
	If R240Imp->(Eof())
		R240Imp->(DbCloseArea())
		Help("",1,"RECNO")
		Return
	Endif
	
	//alert("oie8")
	
	If nTipCob == 2 .or. nTipCob == 4
		oPrint:SetPortrait() // ou SetLandscape()
		oPrint:StartPage()   // Inicia uma nova página
	Endif
	
	/*
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//?Exibe mensagem...                                                        ?
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	MsProcTxt(PLSTR0001)//#include "PLSMGER.CH"
	*/
	
	BA0->(DbSeek(xFilial("BA0") + cOperadora))
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//?Inicio da impressao dos detalhes...                                      ?
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	
	SE1->(DbSetOrder(1))
	BM1->(DbSetOrder(4))
	BA1->(DbSetOrder(2))
	SEE->(dbSetOrder(1))
	SA1->(dbSetOrder(1))
	BA3->(DbSetOrder(1))
	BQC->(DbSetOrder(1))
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
	//³Busca Bmp da empresa.?/ Logo
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
	If File("lgrl" + SM0->M0_CODIGO + SM0->M0_CODFIL + ".Bmp")
		aBMP := { "lgrl" + SM0->M0_CODIGO + SM0->M0_CODFIL + ".Bmp" }
	ElseIf File("lgrl" + SM0->M0_CODIGO + ".Bmp")
		aBMP := { "lgrl" + SM0->M0_CODIGO + ".Bmp" }
	Endif
	
	ProcRegua(_nTotSE1)
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ??
	//³Inicia laco para a impressao  dos boletos.?
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ??
	lMosNumBco := .F.
	
	While ! R240Imp->(Eof())
		
		_nRegPro++
		IncProc("Registro: "+StrZero(_nRegPro,8)+"/"+StrZero(_nTotSE1,8))
		
		lDetMens := .T.
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//?Nova implementacao: Caso titulo cancelado, e extrato (999) nao considerar?
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		
		If nTipCob == 3
			
			cSQLTMP := " SELECT MAX(R_E_C_N_O_) AS REGSE5 "
			cSQLTMP += " FROM "+RetSQLName("SE5")+" "
			cSQLTMP += " WHERE E5_FILIAL = '"+xFilial("SE5")+"' "
			cSQLTMP += " AND E5_PREFIXO = '"+R240Imp->E1_PREFIXO+"'"
			cSQLTMP += " AND E5_NUMERO = '"+R240Imp->E1_NUM+"' "
			cSQLTMP += " AND E5_PARCELA = '"+R240Imp->E1_PARCELA+"' "
			cSQLTMP += " AND E5_TIPO = '"+R240Imp->E1_TIPO+"' "
			cSQLTMP += " AND D_E_L_E_T_ = ' ' "
			
			PLSQuery(cSQLTMP,"TRBSE5")
			
			If TRBSE5->REGSE5 > 0
				SE5->(DbGoTo(TRBSE5->REGSE5))
				
				If SE5->E5_MOTBX == "CAN"
					TRBSE5->(DbCloseArea())
					R240Imp->(DbSkip())
					Loop
				Endif
			Endif
			
			TRBSE5->(DbCloseArea())
			
		Endif
		
		
		aCobranca		:= {}
		cPrefixo		:= R240Imp->E1_PREFIXO
		cTitulo			:= R240Imp->E1_NUM
		cParcela		:= R240Imp->E1_PARCELA
		cTipo			:= R240Imp->E1_TIPO
		cCliR240Imp		:=	R240Imp->E1_CLIENTE			&& 03/12/13 - Vitor Sbano
		cLojR240Imp		:=	R240Imp->E1_LOJA			&& 03/12/13 - Vitor Sbano
		
		aDependentes	:= {}
		
		BM1->(DbSeek(xFilial("BM1") + cPrefixo + cTitulo + cParcela + cTipo))
		BA3->(DbSeek(xFilial("BA3") + BM1->BM1_CODINT + BM1->BM1_CODEMP + BM1->BM1_MATRIC))
		SA1->(DbSeek(xFilial("SA1") + cCliR240Imp + cLojR240Imp))
		
		//
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//?Questionar a impressao caso Tipo de Pagto <> "05" e tp.cobr = 175...	 ?
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		//Reativado em 31/1/08
		/*
		If R240Imp->E1_FORMREC <> "05" .And. nTipCob == 2
			If !MsgBox("Título: "+R240Imp->(E1_PREFIXO+E1_NUM+E1_PARCELA+E1_TIPO)+" possui forma de cobrança "+R240Imp->E1_FORMREC+" O modelo de impressão selecionado ?o 175. Possível duplicidade de cobrança. Deseja continuar?", "CONFIRMA O PROCESSAMENTO?","YESNO")
				R240Imp->(DbSkip())
				Loop
			Endif
		Endif
		*/
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//?Nova implementacao: evitar que o sistema imprima titulos com numero do	 ?
		//?banco igual a 15 sejam impressos (regra para 175).                    	 ?
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If ( nTipCob == 2 .or. nTipCob == 4 ) .And. Len(Alltrim(R240Imp->E1_NUMBCO)) = 15
			If !lMosNumBco
				MsgAlert("Atencao! Número do banco inválido no título em questão! Verifique titulo de SISDEB ! Esta mensagem ser?demonstrada apenas 1 vez!")
				lMosNumBco := .T.
			Endif
			R240Imp->(DbSkip())
			Loop
		Endif
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//?Nao imprimir caso existam mais de 2 debitos pendentes para 112...		 ?
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		nContPar := 0
		**'INI - Marcela Coimbra - 16/05/2014. Gerar boleto para inadimplentes conf solicitado por Alan Lemos'**
		/*
		If nTipCob == 1
			
			SE1->(DbSetOrder(8)) //E1_FILIAL+E1_CLIENTE+E1_LOJA+E1_STATUS+DTOS(E1_VENCREA)
			SE1->(MsSeek(xFilial("SE1")+R240Imp->(E1_CLIENTE+E1_LOJA)+"A"))
			
			nContPar := 0
			While ! SE1->(Eof()) .And. SE1->(E1_CLIENTE+E1_LOJA)+"A" == R240Imp->(E1_CLIENTE+E1_LOJA)+"A"
				If SE1->E1_VENCREA < dDataBase .And. SE1->E1_SALDO > 0
					nContPar++
				Endif
				SE1->(DbSkip())
			Enddo
			SE1->(DbSetOrder(1))
			
			If nContPar <= 2 .and. R240Imp->E1_SALDO = R240Imp->E1_VALOR
				R240Imp->(DbSkip())
				Loop
			Endif
		Endif
		*/
		**'FIM - Marcela Coimbra - 16/05/2014. Gerar boleto para inadimplentes conf solicitado por Alan Lemos'**
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
		//³Em caso de pessoa juridica, nao emite os dependentes.?
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
		If BA3->BA3_TIPOUS == '1' //Pessoa Fisica
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Busca de dependentes para impressao dos dados.?
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			DbSelectArea("BA1")
			If DbSeek(xFilial("BA1") + BM1->BM1_CODINT + BM1->BM1_CODEMP + BM1->BM1_MATRIC)
				
				While 	(BA1->(!EOF()) .And.;
						xFilial("BA1")  == BA1->BA1_FILIAL .And.;
						BA1->BA1_CODINT == BM1->BM1_CODINT .And.;
						BA1->BA1_CODEMP == BM1->BM1_CODEMP .And.;
						BA1->BA1_MATRIC == BM1->BM1_MATRIC)
					
					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³Identifica os usuarios que fazem parte do titulo posicionado. ?
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					If 	(SubStr(DtoS(BA1->BA1_DATINC),1,6) <= R240Imp->E1_ANOBASE+R240Imp->E1_MESBASE) .and. ;
							(Empty(BA1->BA1_MOTBLO))
						
						Aadd(aDependentes, {BA1->BA1_TIPREG,BA1->BA1_NOMUSR})
					EndIf
					
					BA1->(DbSkip())
				End
			EndIf
		EndIf
		//DbSelectArea("R240Imp")
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
		//³Caso nao exita o banco e agencia no SE1 busca informacoes do SEA.?
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
		If ((Empty(R240Imp->E1_PORTADO) .OR. Empty(R240Imp->E1_AGEDEP)) .AND. !Empty(R240Imp->E1_NUMBOR) )
			SEA->(DbSeek(xFilial("SEA")+R240Imp->E1_NUMBOR+ cPrefixo + cTitulo + cParcela + cTipo      ))
			cSA6Key:=SEA->EA_PORTADO+SEA->EA_AGEDEP+SEA->EA_NUMCON
		ElseIf !Empty(R240Imp->E1_PORTADO) .AND. !Empty(R240Imp->E1_AGEDEP)
			cSA6Key:=R240Imp->E1_PORTADO+R240Imp->E1_AGEDEP+R240Imp->E1_CONTA
		EndIf
		
		SA6->(DbSetOrder(1))
		SA6->(MsSeek(xFilial("SA6")+cSA6Key,.T.))
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
		//³Dados bancarios...         ?
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
		//DbSelectArea("R240Imp")
		
		//Alterado por Rafael Fernandes - 24/10/2013
		//aDadosBanco  := {	SA6->A6_COD                                          	,;  //Numero do Banco
		// 					SA6->A6_NOME                                        	,;  //Nome do Banco
		//					SA6->A6_AGENCIA					                       	,;  //Agencia
		//					Subs(SA6->A6_NUMCON,1,IIf(AT("-",SA6->A6_NUMCON)>0,AT("-",SA6->A6_NUMCON)-1,Len(alltrim(SA6->A6_NUMCON))-1))	,; 	//Conta Corrente
		//					Subs(SA6->A6_NUMCON,IIf(AT("-",SA6->A6_NUMCON)>0,AT("-",SA6->A6_NUMCON)+1,Len(Alltrim(SA6->A6_NUMCON))))		}   //Dígito da conta corrente
		
		aDadosBanco  := {	SA6->A6_COD                                          	,;  //Numero do Banco
		SA6->A6_NOME                                        	,;  //Nome do Banco
		SA6->A6_AGENCIA					                       	,;  //Agencia
		SA6->A6_NUMCON											,; 	//Conta Corrente
		SA6->A6_DVCTA											,; 	//Dígito da conta corrente
		SA6->A6_CONTATO											,;   //cÓDIGO DA EMPRESA NO BANCO
		SA6->A6_CARTEIR											}   //cÓDIGO DA EMPRESA NO BANCO
		
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
		//³Retorna os meses em aberto do sacado.?
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
		If GetNewPar("MV_YIMMESA","1") == "1"//GetNewPar("MV_YIMMESA","0") == "1"
			aOpenMonth:=PLR240MES(R240Imp->E1_CLIENTE,R240Imp->E1_LOJA,R240Imp->E1_MESBASE,R240Imp->E1_ANOBASE)
		Endif
		lFoundSE1 := SE1->(MsSeek(xFilial("SE1")+R240Imp->(E1_PREFIXO+E1_NUM+E1_PARCELA+E1_TIPO)))
		
		If lFoundSE1 .And. ( nTipCob == 2 .or. nTipCob == 4 )
			//If GetNewPar("MV_YFLGBL","N") = "S"
			// U_fLogBol() //Edilson Leal 24/01/08 : Log de Impressao
			//Endif
			SE1->(RecLock("SE1",.F.))
			SE1->E1_YTPEXP := "D" //IMPRESSO 175 - TABELA K1
			SE1->E1_YTPEDSC	:= Posicione("SX5", 1, xFilial("SX5")+"K1"+"D", "X5_DESCRI")
			SE1->(MsUnlock())
		Endif
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
		//³Caso necessario, grava nro do banco no titulo... ?
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
		If Empty(R240Imp->(E1_NUMBCO))
			
			If lFoundSE1
				
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
				//³Verifica se deve observar cadastros de banco, somente se for 175...  ?
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
				//
				If nTipCob == 2 .or. nTipCob == 4
					
					If SEE->(dbSeek(xFilial("SEE")+aDadosBanco[1]+aDadosBanco[3]+aDadosBanco[4]+aDadosBanco[5]+"001"))
						
						cNumAtu := SEE->EE_FAXATU
						cCartCob	:=	SEE->EE_CODCART		&&	Código Carteira Cobranca (Tabela SEE)
						//
						If MV_PAR17 = 2		&& Reimpressao
							//
							cCartCob	:=	"06"		&&	Código Carteira Cobranca Reimpressao
							//
						Endif
						//
						SE1->(RecLock("SE1",.F.))
						SE1->E1_NUMBCO := cNumAtu
						//SE1->E1_FORMREC := "05"
						SE1->(MsUnlock())
						
						//INCREMENTA O NxOSSO NUMERO
						cNumAtu := soma1(Substr(SEE->EE_FAXATU,1,Len(Alltrim(SEE->EE_FAXATU))))
						SEE->(RecLock("SEE",.F.))
						SEE->EE_FAXATU := cNumAtu
						SEE->(MsUnlock())
						
					Endif
					
				Endif
				
			Endif
			
		Endif
		
		lImpBM1 := .F.
		_cCodFamUti := ""
		lIntegral := .F.
		aMsgRea := {}
		aMsgReaj := {}
		aObservacoes := {}
		cMsgRea := ''
		cPerRea := ""
		lMosRea := .F.
		
		l_NivFam := BA3->BA3_COBNIV == '1'
		
		While 	!BM1->(Eof()) 					.And.;
				BM1->BM1_PREFIX = cPrefixo 		.And.;
				BM1->BM1_NUMTIT = cTitulo 		.And.;
				BM1->BM1_PARCEL = cParcela 		.And.;
				BM1->BM1_TIPTIT $ (cTipo + ",NCC") //BM1->BM1_TIPTIT = cTipo -- Angelo Henrique -- Data:28/09/2020 - Release 27
			
			If BM1->BM1_CODTIP $ "127,116,104,117,120,121,122,123,124,125,141,151,152,149,139"
				lImpBM1 := .F.
			Else
				lImpBM1 := .T.
			Endif
			
			If BM1->BM1_CODINT+BM1->BM1_CODEMP+BM1->BM1_MATRIC+BM1->BM1_TIPREG == cUsuAnt
				lNome := .F.
			Else
				cUsuAnt := BM1->BM1_CODINT+BM1->BM1_CODEMP+BM1->BM1_MATRIC+BM1->BM1_TIPREG
				lNome:= .T.
			EndIf
			
			_cCodFamUti := BM1->BM1_CODINT+BM1->BM1_CODEMP+BM1->BM1_MATRIC
			
			//Se for CNAB, sempre enviar nome do usuario...
			If nTipCob == 1
				lNome := .T.
			Endif
			
			If lImpBM1 .And. Substr(cNumEmp,1,2) == "02" //Verifica se eh integral, na variavel publica de numero de empresa...
				lIntegral := .T.
				//			lNome := .F.  Altamiro em 17/11/09
			Endif
			// alterado para conteplar emissao de coparte da integral
			//		If Substr(cNumEmp,1,2) == "02"
			
			l_FamBlo := .F.
			
			If !EMPTY(ba3->ba3_DATBLO)
				
				l_FamBlo := .T.
				
			EndIf
			
			If lImpBM1
				/////////////////altmairo 03/12/2010 - solicitado keila - claudia vicente
				
				If !lIntegral
					
					If BA3->BA3_COBNIV == '1'
						
						Aadd(aCobranca,{Iif(lNome,BM1->BM1_NOMUSR,""),;
							"",;
							"",;
							"",;
							BM1->BM1_CODTIP,;
							BuscaDescr(BM1->BM1_CODTIP, BM1->BM1_DESTIP, BM1->BM1_ALIAS, BM1->BM1_ORIGEM),; //BM1->BM1_DESTIP,; //Alterar descricao conforme regra da operadora... (IIf(BM1->BM1_CODTIP $ MV_YABCDE,Condicao1,Condicao2)
						Iif(BM1->BM1_CODTIP $ "104;116;120;121;123;124","",BM1->BM1_VALOR),; //135 Outros  ? Motta
						"",;
							BM1->(BM1_CODINT+BM1_CODEMP+BM1_MATRIC+BM1_TIPREG+BM1_DIGITO),;
							'1',;
							"",;
							BM1->BM1_TIPO,;
							BA3->BA3_COBNIV})
						
					Else
						
						_nPosTmp := Ascan(aCobranca,{|x| x[5]==BM1->BM1_CODTIP})
						
						If _nPosTmp == 0
							Aadd(aCobranca,{se1->e1_nomcli,;
								"",;
								"",;
								"",;
								BM1->BM1_CODTIP,;
								BuscaDescr(BM1->BM1_CODTIP, BM1->BM1_DESTIP, BM1->BM1_ALIAS, BM1->BM1_ORIGEM),; //BM1->BM1_DESTIP,; //Alterar descricao conforme regra da operadora... (IIf(BM1->BM1_CODTIP $ MV_YABCDE,Condicao1,Condicao2)
							BM1->BM1_VALOR,;
								"",;
								"101",;  //mbcint
							'1',;
								"",;
								BM1->BM1_TIPO,;
								BA3->BA3_COBNIV})
						Else
							aCobranca[_nPosTmp,7] += BM1->BM1_VALOR
						Endif
					Endif
				Else
					If BA3->BA3_COBNIV == '1'
						// trecho de codigo replicado do de cima , ATENÇÃO AO ALTERAR//
						Aadd(aCobranca,{Iif(lNome,BM1->BM1_NOMUSR,""),;
							"",;
							"",;
							"",;
							BM1->BM1_CODTIP,;
							BuscaDescr(BM1->BM1_CODTIP, BM1->BM1_DESTIP, BM1->BM1_ALIAS, BM1->BM1_ORIGEM),; //BM1->BM1_DESTIP,; //Alterar descricao conforme regra da operadora... (IIf(BM1->BM1_CODTIP $ MV_YABCDE,Condicao1,Condicao2)
						Iif(BM1->BM1_CODTIP $ "104;116;120;121;123;124","",BM1->BM1_VALOR),; //135 Outros  ? Motta
						"",;
							BM1->(BM1_CODINT+BM1_CODEMP+BM1_MATRIC+BM1_TIPREG+BM1_DIGITO),;
							'1',;
							"",;
							BM1->BM1_TIPO,;
							BA3->BA3_COBNIV})
					Else
						_nPosTmp := Ascan(aCobranca,{|x| x[5]==BM1->BM1_CODTIP})
						
						If _nPosTmp == 0
							Aadd(aCobranca,{se1->e1_nomcli,;
								"",;
								"",;
								"",;
								BM1->BM1_CODTIP,;
								BuscaDescr(BM1->BM1_CODTIP, BM1->BM1_DESTIP, BM1->BM1_ALIAS, BM1->BM1_ORIGEM),; //BM1->BM1_DESTIP,; //Alterar descricao conforme regra da operadora... (IIf(BM1->BM1_CODTIP $ MV_YABCDE,Condicao1,Condicao2)
							BM1->BM1_VALOR,;
								"",;
								"101",;  //mbcint
							'1',;
								"",;
								BM1->BM1_TIPO,;
								BA3->BA3_COBNIV})
						Else
							aCobranca[_nPosTmp,7] += BM1->BM1_VALOR
						Endif
					Endif
				Endif
				
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//?Obtencao de dados para impressao da mensagem de reajuste / ANS...                          ?
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				BA3->(MsSeek(xFilial("BA3")+BM1->(BM1_CODINT+BM1_CODEMP+BM1_MATRIC)))
				
				If R240Imp->E1_MESBASE <> '01'
					
					c_AnoMes := R240Imp->E1_ANOBASE + ba3->ba3_mesrea
					
				Else
					
					c_AnoMes := str(val(R240Imp->E1_ANOBASE)- 1)  + ba3->ba3_mesrea
					
				EndIf
				
				//			 If (R240Imp->E1_ANOBASE + R240Imp->E1_MESBASE $ '201709' .and. c_AnoMes $ '201707||201708||201709' ) .and. GetNewPar("MV_YMSREA","0") == "1"
				//If (R240Imp->E1_ANOBASE + R240Imp->E1_MESBASE == c_AnoMes ) .and. !lIntegral  .and. GetNewPar("MV_YMSREA","0") == "1"
				If (R240Imp->E1_ANOBASE + R240Imp->E1_MESBASE $ '202009' .And. c_AnoMes $ '202007||202008||20209' ) .and. !lIntegral  //.and. GetNewPar("MV_YMSREA","0") == "1"
					
					//cPerRea := PercReajuste( c_AnoMes ,BM1->(BM1_CODINT+BM1_CODEMP+BM1_MATRIC+BM1_TIPREG+BM1_DIGITO))
					cPerRea := Perc2014( c_AnoMes ,BM1->(BM1_CODINT+BM1_CODEMP+BM1_MATRIC), BA3->BA3_INDREA)
					
					If !Empty(cPerRea)
						
						lMosRea := .T.//!Empty( cPerRea )
						
					EndIf
					
				EndIf
				
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//?Controle para imprimir msg. reaj. somente quando percentual > 0 e titulo de mensalidade	   ?
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				If lMosRea .and. GetNewPar("MV_YMSREA","0") == "1"
					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//?Montar matriz de produtos da PF, para utilizacao nas mensagens de reajuste. 	 ?
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					cCodPla := BA3->BA3_CODPLA
					
					aAreaBI3  := BI3->(GetArea())
					BI3->(DbSetOrder(1))
					BI3->(MsSeek(xFilial("BI3")+PLSINTPAD()+BA3->(BA3_CODPLA+BA3_VERSAO)))
					
					cNomPRe  := ALLTRIM( BI3->BI3_NREDUZ )
					cNumANS  := ALLTRIM( BI3->BI3_SUSEP  )
					cPatroc  := ""
					cContANS := ""
					
					If !Empty(BA3->BA3_SUBCON)
						cPatroc  := Posicione("BQC",1,xFilial("BQC")+BA3->(BA3_CODINT+BA3_CODEMP+BA3_CONEMP+BA3_VERCON+BA3_SUBCON+BA3_VERSUB),"BQC_PATROC")
						cContANS := ALLTRIM( BA3->BA3_SUBCON )
					EndIf
					
					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
					//³LegEnda para matriz de produtos.								?
					//? - Codigo do Produto										?
					//? - Nome do Produto											?
					//? - Nro do Produto na ANS									?
					//? - Percentual reajustado									?
					//? - Nro oficio ANS que liberou o reajuste.					?
					//? - Nro do contrato ou apolice (nro subcontrato - PJ)		?
					//? - Plano coletivo com (1) ou sem (0) patrocinador - PJ)		?
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
					If Ascan(aPlaRea,{|x| x[1]==cCodPla}) = 0
						Aadd(aPlaRea,{cCodPla,cNomPRe,cNumANS,cPerRea,cOfiANS,cContANS,cPatroc})
					EndIf
					
					RestArea(aAreaBI3)
					
					BA1->(MsSeek(xFilial("BA1")+BM1->(BM1_CODINT+BM1_CODEMP+BM1_MATRIC+BM1_TIPREG+BM1_DIGITO)))
					
					
					//				While ! BA1->(Eof()) .and. BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC)==BM1->(BM1_CODINT+BM1_CODEMP+BM1_MATRIC+BM1_TIPREG+BM1_DIGITO)
					**'Marcela Coimbra - Acerto da rotina'**
					While ! BA1->(Eof()) .and. BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG+BA1_DIGITO)==BM1->(BM1_CODINT+BM1_CODEMP+BM1_MATRIC+BM1_TIPREG+BM1_DIGITO)
						
						
						If !Empty(BA1->BA1_CODPLA) .AND. BA1->BA1_CODPLA <> cCodPla
							
							cPerRea := ""
							
						EndIf
						
						BA1->(DbSkip())
						
					Enddo
					
					If Empty( cPerRea )
						
						cPerRea:= ". Em caso de duvida ligue 3233-8855"
						
					Else
						
						cPerRea := " " + cPerRea
						
					EndIf
		/* - altamiro - 09/11/20 - retirado pela suspenção ans - retornar quando conveniente 
					cMsgRea := "Plano " + cNomPRe+ " -  Registro n?" + cNumANS + " - Contrato n?" + cContANS
					cMsgRea += " - Coletivo por adesao. Percentual de reajuste aplicado" + cPerRea
					cMsgRea += ". O reajuste sera comunicado a ANS em data pre-determinada."
					cMsgRea += space(300)
					
					aMsgReaj := JustificaTxt(cMsgRea, 100)
		*/
					cQuery  := " insert into log_imp_extrato values ( '" + R240Imp->E1_CODINT + "', '" + R240Imp->E1_CODEMP + "', '" + R240Imp->E1_MATRIC + "', "
					cQuery  += " '" + BM1->BM1_TIPREG + "', '" + R240Imp->E1_NUM + "', '" + R240Imp->E1_ANOBASE + "', '" + R240Imp->E1_MESBASE + "', ' " + cMsgRea + " ', '" + dtos(date()) + "', '" + FunName() + "')  "
					
					TcSqlExec(cQuery) >= 0
					
					aPlaRea := {}
					aObservacoes:=JustificaTxt(cMsgRea, 100)
					
					
				EndIf
				
				aPlaRea := {}
				
			Endif
			
			BM1->(DbSkip())
		End
		
		If  GetNewPar("MV_YGRIMVZ","0") == "1" .AND. VerAdp(R240Imp->E1_CODEMP, R240Imp->E1_MATRIC)  .AND. R240Imp->E1_MESBASE = '05'  // .and. .f.
			
			cMsg1 := "Declaramos a quitacao do ano de  " + cvaltochar(year(ddatabase)-1) + ", a mesma substitui todos os recibos de pagamento do ano de "
			cMsg2 := "" + cvaltochar(year(ddatabase)-1) + ". Debitos prorrogados ou negociados para períodos futuros não estao contemplados."
			
			cQuery  := " insert into log_imp_extrato values ( '0001', '" + BA3->BA3_CODEMP + "', '" + BA3->BA3_MATRIC + "', "
			cQuery  += " '00', '" + R240Imp->E1_NUM + "', '" + R240Imp->E1_ANOBASE + "', '" + R240Imp->E1_MESBASE + "', ' " + cMsg1 + " ', '" + dtos(date()) + "', '" + FunName() + "')  "
			
			TcSqlExec(cQuery) >= 0
			
			
			aObservacoes:=JustificaTxt(cMsg1 + cMsg2 , 100)
			
		EndIf
		
		/* retirado conforme GLPI: 41954
		If  R240Imp->E1_CODEMP == '0024'
			
			cMsg1 := "Prezado Servidor, esse boleto corresponde ao saldo residual entre o valor do plano de saúde e do"
			cMsg2 := " desconto em folha."
			
			
			aObservacoes:=JustificaTxt(cMsg1 + cMsg2 , 100)
			
		EndIf
		*/
		
		If .t.//!lIntegral .or. ( lIntegral .and. BA3->BA3_COBNIV == '1' )
			
			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
			//³Nova implementacao em 8/11/07 - tratar geracao de ana- ?
			//³litico caso exista na utilizacao do beneficiario guias ?
			//³marcadas como bloqueio odontologico.                   ?
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
			_cSQLUti := " SELECT Sum(BD6_VLRTPF) AS VLRTOT FROM "+RetSQLName("BD6")+" "
			_cSQLUti += " WHERE BD6_FILIAL = '"+xFilial("BD6")+"' "
			_cSQLUti += " AND BD6_OPEUSR = '"+Substr(_cCodFamUti,1,4)+"' "
			_cSQLUti += " AND BD6_CODEMP = '"+Substr(_cCodFamUti,5,4)+"' "
			_cSQLUti += " AND BD6_MATRIC = '"+Substr(_cCodFamUti,9)+"' "
			
			**'-Incicio Marcela Coimbra - Data: 17/03/09-'**
			
			_cSQLUti += " AND BD6_PREFIX = '"+R240Imp->E1_PREFIXO+"' AND BD6_NUMTIT ='"+R240Imp->E1_NUM+"' AND BD6_PARCEL ='"+R240Imp->E1_PARCELA+"' AND BD6_TIPTIT = '"+R240Imp->E1_TIPO+"' "
			
			**'-Fim Marcela Coimbra - Data: 17/03/09-'**
			
			
			/*
			**'-Incicio Marcela Coimbra - Data: 17/03/09-'**
			
			_cSQLUti += " AND ( BD6_NUMSE1 = '"+R240Imp->(E1_PREFIXO+SUBSTR(E1_NUM,1,6)+E1_PARCELA+E1_TIPO)+"' "
			_cSQLUti += "       OR 	 BD6_PREFIX||BD6_NUMTIT||BD6_PARCEL||BD6_TIPTIT = '"+R240Imp->(E1_PREFIXO+E1_NUM+E1_PARCELA+E1_TIPO)+"') "
			
			//_cSQLUti += " AND BD6_NUMSE1 = '"+R240Imp->(E1_PREFIXO+SUBSTR(E1_NUM,1,6)+E1_PARCELA+E1_TIPO)+"' " //GEDILSON
			
			**'-Fim Marcela Coimbra - Data: 17/03/09-'**
			*/
			
			//_cSQLUti += " AND BD6_NUMSE1 = '"+R240Imp->(E1_PREFIXO+E1_NUM+E1_PARCELA+E1_TIPO)+"' " //GEDILSON 24/02/2010
			
			_cSQLUti += " AND BD6_NUMFAT = 'BLQODONT' "
			_cSQLUti += " AND D_E_L_E_T_ = ' ' "
			
			MemoWrit("C:\BORD2.TXT", _cSQLUti)
			
			PLSQUERY(_cSQLUti,"TRBUTI")
			
			If TRBUTI->VLRTOT > 0
				
				Aadd(aCobranca,{"",;
					"",;
					"",;
					"",;
					"952",;
					"LCTO CRED PARCEL. ODONTOLOGICO",; //Alterar descricao conforme regra da operadora... (IIf(BM1->BM1_CODTIP $ MV_YABCDE,Condicao1,Condicao2)
				TRBUTI->VLRTOT,;
					"",;
					_cCodFamUti+"00"+Modulo11(_cCodFamUti+"00"),;
					'1',;
					"",;
					"2",;
					BA3->BA3_COBNIV}) //CREDITO
				
			Endif
			TRBUTI->(DbCloseArea())
			
			cAnoMesPgt := PLSDIMAM(R240Imp->(E1_ANOBASE),R240Imp->(E1_MESBASE),"0")
			cAnoMesPgt := PLSDIMAM(Substr(cAnoMesPgt,1,4),Substr(cAnoMesPgt,5,2),"0")
			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
			//³Movido este trecho do fonte para evitar repeticao de   ?
			//³itens caso exista mais de um lancamento de faturamento ?
			//³do tipo de co-participacao.                z            ?
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
			_cSQLUti := " SELECT * FROM "+RetSQLName("BD6")
			_cSQLUti += " WHERE BD6_FILIAL = '"+xFilial("BD6")+"' "
			_cSQLUti += " AND BD6_OPEUSR = '"+Substr(_cCodFamUti,1,4)+"' "
			_cSQLUti += " AND BD6_CODEMP = '"+Substr(_cCodFamUti,5,4)+"' "
			
			If BA3->BA3_COBNIV=="1"
				
				_cSQLUti += " AND BD6_MATRIC = '"+Substr(_cCodFamUti,9)+"' "
				
			EndIf
			
			**'-Incicio Marcela Coimbra - Data: 13/04/09-'**
			
			_cSQLUti += " AND ( ( BD6_PREFIX = '"+R240Imp->E1_PREFIXO+"' AND BD6_NUMTIT ='"+R240Imp->E1_NUM+"' AND BD6_PARCEL ='"+R240Imp->E1_PARCELA+"' AND BD6_TIPTIT = '"+R240Imp->E1_TIPO+"' "
			
			**'-Fim Marcela Coimbra - Data: 13/04/09-'**
			
			_cSQLUti += " AND BD6_VLRTPF > 0 ) OR "
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
			//³Em 28/08/08, modificado este trecho para contemplar a  ?
			//³nova caracteristica de imprimir no extrato do benefici-?
			//³ario informacoes sobre o valor pago pela Caberj.       ?
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
			_cSQLUti += " ( (BD6_VLRTPF = 0 OR BD6_BLOCPA = '1' ) AND BD6_VLRPAG > 0 AND SUBSTR(BD6_NUMLOT,1,6) = '"+cAnoMesPgt+"' ) ) "
			
			_cSQLUti += " AND BD6_NUMFAT =  '" + R240Imp->E1_PLNUCOB  + "' "
			
			_cSQLUti += " AND "+RetSQLName("BD6")+".D_E_L_E_T_ <> '*' "
			_cSQLUti += " ORDER BY BD6_OPEUSR, BD6_CODEMP, BD6_MATRIC, BD6_TIPREG, BD6_DATPRO"//, BD6_NOMRDA, BD6_CODPRO "
			
			MemoWrit("C:\Temp\BORD3.TXT", _cSQLUti)
			
			
			PLSQUERY(_cSQLUti,"TRBUTI")
			
			DbSelectArea("TRBUTI")
			n_QtdItens := 0
			COUNT TO n_QtdItens
			
			TRBUTI->( dbGoTop() )
			
			//If n_QtdItens < 19  //mbc19
			While !TRBUTI->(Eof())
				
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
				//³Para emissao Itau (112), deve-se sempre obter o nome do?
				//³usuario. Na reimpressao, nao eh necessario...          ?
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
				nPosBD6 := 0
				If nTipCob == 2 .or. nTipCob == 4
					nPosBD6 := Ascan(aCobranca, {|x| x[09] == TRBUTI->BD6_CODOPE+TRBUTI->BD6_CODEMP+;
						TRBUTI->BD6_MATRIC+TRBUTI->BD6_TIPREG+;
						TRBUTI->BD6_DIGITO} )
				Endif
				
				If TRBUTI->BD6_CODLDP == '0012'
					_cNomRDA := TRBUTI->BD6_NOMSOL
				Else
					_cNomRDA := TRBUTI->BD6_NOMRDA
					If Empty(_cNomRDA)
						_cNomRDA := Posicione("BAU",1,xFilial("BD6")+TRBUTI->BD6_CODRDA,"BAU_NOME")
					Endif
				EndIf
				
				nVlrTotBol := TRBUTI->BD6_VLRBPF
				If TRBUTI->BD6_VLRTPF = 0 .Or. TRBUTI->BD6_BLOCPA = '1'
					nVlrTotBol := TRBUTI->BD6_VLRPAG
				Endif
				
				a_AreaBa3 := GetArea("BA3")
				/*
				//Altamiro - Ajuste para nao sair copart para cobrança na integral
				if ( (Substr(cNumEmp,1,2) == "02" ) .and. (BM1->BM1_CODTIP $ "127,116,104,117,120,121,122,123,124,125,141,151,152")) ;
						.AND. BA3->(MsSeek(xFilial("BA3")+BM1->(BM1_CODINT+BM1_CODEMP+BM1_MATRIC))) .AND. BA3->BA3_COBNIV == "0"
					
					aa:= " "
					
				Else
					// Fim - Altamiro
					*/  // If n_QtdItens < 19
					If BA3->BA3_COBNIV=="1"
						
						Aadd(aCobranca,{	Iif(nPosBD6==0,TRBUTI->BD6_NOMUSR,''),;
							_cNomRDA,;
							DtoS(TRBUTI->BD6_DATPRO),;
							TRBUTI->BD6_NUMERO,;
							TRBUTI->BD6_CODPRO,;
							TRBUTI->BD6_DESPRO,;
							Iif(TRBUTI->BD6_BLOCPA == "1",0,TRBUTI->BD6_VLRTPF),;
							TRBUTI->BD6_IDUSR ,;
							TRBUTI->(BD6_CODOPE+BD6_CODEMP+BD6_MATRIC+BD6_TIPREG+BD6_DIGITO) ,;
							'2',;
							nVlrTotBol,;
							"1",;
							BA3->BA3_COBNIV}) //Atribuido fixo 1 pois sera sempre debito de co-part.
						
					Else    //mbcint
						
						nPos := Ascan( aCobranca, { |x| x[09] == "COPART" } )
						If nPos == 0
							/*
							Aadd(aCobranca,{	Iif(nPosBD6==0,TRBUTI->BD6_NOMUSR,''),;
								_cNomRDA,;
								DtoS(TRBUTI->BD6_DATPRO),;
								TRBUTI->BD6_NUMERO,;
								TRBUTI->BD6_CODPRO,;
								TRBUTI->BD6_DESPRO,;
								Iif(TRBUTI->BD6_BLOCPA == "1",0,TRBUTI->BD6_VLRTPF),;
								TRBUTI->BD6_IDUSR ,;
								"COPART",;
								'2',;
								nVlrTotBol,;
								"1",;
								BA3->BA3_COBNIV}) //Atribuido fixo 1 pois sera sempre debito de co-part.
							*/
							Aadd(aCobranca,{	" ",;
								" ",;
								" ",;
								TRBUTI->BD6_NUMERO,;
								"CO",;
								"PARTICIPAÇÃO",;
								Iif(TRBUTI->BD6_BLOCPA == "1",0,TRBUTI->BD6_VLRTPF),;
								TRBUTI->BD6_IDUSR ,;
								"COPART",;
								'2',;
								0,;//
							"1",;
								BA3->BA3_COBNIV}) //Atribuido fixo 1 pois sera sempre debito de co-part.
							
						Else
							
							aCobranca[nPos,11] += 0//nVlrTotBol
							aCobranca[nPos,7]  += TRBUTI->BD6_VLRTPF
							
						EndIf
						
						
						
					EndIf
					// EndIf
					// EndIf
					
					RestArea( a_AreaBa3 )
					
					TRBUTI->(DbSkip())
					
				Enddo
				
				TRBUTI->(DbCloseArea())
			Endif
			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
			//³Ordena array pela matricula do usuario...            ?
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
			aSort( aCobranca,,,{|x,y| x[9]+X[10]+x[3]+x[5] < y[9]+Y[10]+y[3]+y[5]} )
			
			//aBfq := RetornaBfq(R240Imp->E1_CODINT, "199")
			If R240Imp->E1_IRRF > 0
				//altamiro  em 11/11/2009 - sujeira no campo despesa retirada a referencia aBfq[2] da possição 11 do vetor
				Aadd(aCobranca,{	"",	"",	"", "",	"199", "IR",	R240Imp->E1_IRRF,	"",	"",	"", "", "2", BA3->BA3_COBNIV})
				// Aadd(aCobranca,{	"",	"",	"", "",	aBfq[1],AllTrim(aBfq[3])+" (-) ", R240Imp->E1_IRRF,	"",	"",	"",	"", "", BA3->BA3_COBNIV})
			Endif
			//altamiro  em 26/11/2009 - Inclusao no boleto das linhas referentes ao impostos , Iss , pis , cofins e csll se incidente
			If R240Imp->E1_ISS > 0
				Aadd(aCobranca,{	"",	"",	"",	"",	"199", "Iss" + " (-) ", R240Imp->E1_ISS, "", "", "","","2",  BA3->BA3_COBNIV})
			Endif
			If R240Imp->E1_CSLL > 0
				Aadd(aCobranca,{	"",	"",	"",	"",	"199","Csll" +  " (-) ", R240Imp->E1_CSLL, "", "", "","","2",  BA3->BA3_COBNIV})
			Endif
			If R240Imp->E1_COFINS > 0
				Aadd(aCobranca,{	"",	"",	"",	"",	"199","Cofins" + " (-) ", R240Imp->E1_COFINS, "", "", "","","2",  BA3->BA3_COBNIV})
			Endif
			If R240Imp->E1_PIS > 0
				Aadd(aCobranca,{	"",	"",	"",	"",	"199", "Pis" + " (-) ", R240Imp->E1_PIS, "", "", "","","2",  BA3->BA3_COBNIV})
			Endif
			//
			//	aDadosEmp	:= {	BA0->BA0_NOMINT                                                           	,; //Nome da Empresa
			//						BA0->BA0_END                                                              	,; //Endereço
			//						AllTrim(BA0->BA0_BAIRRO)+", "+AllTrim(BA0->BA0_CIDADE)+", "+BA0->BA0_EST 	,; //Complemento
			//						STR0045+Subs(BA0->BA0_CEP,1,5)+"-"+Subs(BA0->BA0_CEP,6,3)             		,; //CEP //"CEP: "
			//						STR0046+BA0->BA0_TELEF1                                           		,; //Telefones //"PABX/FAX: "
			//						STR0047+Subs(BA0->BA0_CGC,1,2)+"."+Subs(BA0->BA0_CGC,3,3)+"."+; //"CNPJ.: "
			// 						Subs(BA0->BA0_CGC,6,3)+"/"+Subs(BA0->BA0_CGC,9,4)+"-"+;
				//						Subs(BA0->BA0_CGC,13,2)                                                    	,; //CGC
			//						STR0043 + BA0->BA0_SUSEP }  //I.E //"ANS : "
			//
			
			aDadosEmp	:= {	BA0->BA0_NOMINT                                                           	,; //Nome da Empresa
			alltrim(BA0->BA0_END)+","+alltrim(BA0->BA0_NUMEND)                        	,; //Endereço
			AllTrim(BA0->BA0_BAIRRO)+", "+AllTrim(BA0->BA0_CIDADE)+", "+BA0->BA0_EST 	,; //Complemento
			STR0045+Subs(BA0->BA0_CEP,1,5)+"-"+Subs(BA0->BA0_CEP,6,3)             		,; //CEP //"CEP: "
			"Tel.: "+alltrim(BA0->BA0_TELEF2)+" Demais Localidades : "+alltrim(BA0->BA0_TELEF3),; //Telefones //"PABX/FAX: "
			STR0047+Subs(BA0->BA0_CGC,1,2)+"."+Subs(BA0->BA0_CGC,3,3)+"."+; //"CNPJ.: "
			Subs(BA0->BA0_CGC,6,3)+"/"+Subs(BA0->BA0_CGC,9,4)+"-"+;
				Subs(BA0->BA0_CGC,13,2)                                                    	,; //CGC
			STR0043 + BA0->BA0_SUSEP }  //I.E //"ANS : "
			
			
			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ??
			//³Carrega mensagens para boleto.?
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ??
			//aObservacoes := {}
			//aObservacoes := PLR240TEXT(2 ,R240Imp->E1_CODINT	,R240Imp->E1_CODEMP,R240Imp->E1_CONEMP	,;
				//                             R240Imp->E1_SUBCON	,R240Imp->E1_MATRIC ,R240Imp->E1_ANOBASE+R240Imp->E1_MESBASE)
			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
			//³Carrega mensagens de Ir     ano base 2009              ?
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
			If cAnotit + cMesTit == '202003'
				//       cText:= u_IR2007()
				c_IR := IR2009(aObservacoes) //  mbc
				/*ALTAMIRO INCLUISAO MENSAGEM DE IR NO BOLETO - 02/2013 */
				/*If !Empty( c_IR )
				
				Aadd(aObservacoes, c_IR )
				
			EndIf*/
			// ATE AKI 02/2013
			//       Alert(aObservacoes[4])
		EndIF
		
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
		//³Carrega mensagens de reajuste para analitico do boleto.?
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
		/*	If Len(aMsgRea) > 0 // .And. nTipCob == 2   // Msg Rea Motta
		For nCont := 1 to Len(aMsgRea)
			Aadd(aObservacoes,Substr(aMsgRea[nCont],1,100))
		Next
	Endif
	*/
	aMsgBoleto   := PLR240TEXT(1					,R240Imp->E1_CODINT	,R240Imp->E1_CODEMP,R240Imp->E1_CONEMP	,;
		R240Imp->E1_SUBCON	,R240Imp->E1_MATRIC ,R240Imp->E1_ANOBASE+R240Imp->E1_MESBASE)
	
	SA1->(DbSeek(xFilial("SA1") + R240Imp->E1_CLIENTE + R240Imp->E1_LOJA))


	/*Adicionado para buscar a carteira da subconta corretamente  por Luiz Otavio Campos em 12/03/2021*/
	c_Subconta:="001"
	DbSelectArea("SEA")
	DbSetOrder(1)	
	If DbSeek(xFilial("SEA")+ R240Imp->E1_NUMBOR+R240Imp->E1_PREFIXO+R240Imp->E1_NUM+R240Imp->E1_PARCELA+R240Imp->E1_TIPO)
		c_Subconta:= SEA->EA_XSUBCON

		If Empty(c_Subconta)
			c_Subconta:="001"
		EndIf
	EndIf
	/*****************************************************************************************************/
	

	dbSelectArea("SEE")
	dbSetOrder(1)
	If SEE->(dbSeek(xFilial("SEE")+aDadosBanco[1]+aDadosBanco[3]+aDadosBanco[4]+c_Subconta))
		
		//If Subs(aDadosBanco[1],1,3) == '001' //Banco do Brasil
		//cCart := '18'
		//ElseIf Subs(aDadosBanco[1],1,3) == '104' //CEF
		//cCart := '82'
		//ElseIf Subs(aDadosBanco[1],1,3) == '341' //Itau
		//cCart := '175'
		//ElseIf Subs(aDadosBanco[1],1,3) == '237' //Itau
		//cCart := '175'
		//EndIf
		if !Empty(SEE->EE_CODCART)
			cCart := alltrim(SEE->EE_CODCART)
		else
			cCart :="009"
		endif
	Else
		cCart :="009"
	EndIf
	
	/*
	If nTipCob == 2	&&	Reimpressao
		//
		cCart :="006"
		//
	Else
		cCart :="009"
		//
	Endif
	*/
	//cCart :="009"
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Somente verificar codigo de barras, se nao for 175 (modelo <> 1)		 ?
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If nTipCob == 2 .or. nTipCob == 4
		
		CB_RN_NN    := 	Ret_cBarra(	Subs(aDadosBanco[1],1,3),;
			aDadosBanco[3],;
			aDadosBanco[4],;
			aDadosBanco[5],;
			Strzero(Val(Alltrim(R240Imp->E1_NUM)),6)+StrZERO(Val(Alltrim(R240Imp->E1_PARCELA)),2),;
			R240Imp->SALDO - R240Imp->E1_IRRF - R240Imp->E1_CSLL - R240Imp->E1_COFINS - R240Imp->E1_PIS - R240Imp->E1_ISS - R240Imp->E1_DECRESC,; //1// MARCELA COIMBRA EM 22/04/2014 R240Imp->E1_VALOR - R240Imp->E1_IRRF - R240Imp->E1_CSLL - R240Imp->E1_COFINS - R240Imp->E1_PIS - R240Imp->E1_ISS,; //1
		R240Imp->E1_PREFIXO,;
			R240Imp->E1_NUM,;
			R240Imp->E1_PARCELA,;
			R240Imp->E1_TIPO,;
			cCart)
		
		///R240Imp->E1_SALDO - R240Imp->E1_IRRF,; //1
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Testar o retorno do rdmake de layout do boleto...                     ?
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If Empty(CB_RN_NN)
			If !MsgYesNo(STR0055) // //"Deseja continuar ?"
				Return NIL
			Else
				R240Imp->(DbSkip())
				Loop
			EndIf
		EndIf
		
	Endif
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
	//³Dados do Titulo?
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
	
	**'Marcela Coimbra - Ajuste da montagem do aDadosTit para acertar o valor do boleto'**
	
	**'Marcela Coimbra - Inicio do Bloco Comentado'**
	/*
	aDadosTit   :=  {	AllTrim(R240Imp->E1_NUM)+AllTrim(R240Imp->E1_PARCELA),; 	//Numero do título
	R240Imp->E1_EMISSAO,;             				//Data da emissão do título
	dDataBase,;             				//Data da emissão do boleto
	R240Imp->E1_VENCTO,;             				//Data do vencimento
	R240Imp->E1_VALOR - R240Imp->E1_IRRF - R240Imp->E1_CSLL - R240Imp->E1_COFINS - R240Imp->E1_PIS - R240Imp->E1_ISS,;					//Valor do título =- ALTAMIRO INCLUSAO DOS IMPOSOTS PIS COFINS CSLL E ISS
	Iif(nTipCob==1,"",Iif(nTipCob==2,CB_RN_NN[3],"")) }							//Nosso numero (Ver fórmula para calculo)
	*/
	**'Marcela Coimbra - Fim do Bloco Comentado'**
	
	//				R240Imp->E1_SALDO - R240Imp->E1_IRRF - R240Imp->E1_CSLL - R240Imp->E1_COFINS - R240Imp->E1_PIS - R240Imp->E1_ISS,;					//Valor do título =- ALTAMIRO INCLUSAO DOS IMPOSOTS PIS COFINS CSLL E ISS
	
	aDadosTit   :=  {	AllTrim(R240Imp->E1_NUM)+AllTrim(R240Imp->E1_PARCELA),; 	//Numero do título
	R240Imp->E1_EMISSAO,;             				//Data da emissão do título
	dDataBase,;             				//Data da emissão do boleto
	R240Imp->E1_VENCREA/*R240Imp->E1_VENCTO*/,;             				//Data do vencimento
	R240Imp->SALDO - R240Imp->E1_IRRF - R240Imp->E1_CSLL - R240Imp->E1_COFINS - R240Imp->E1_PIS - R240Imp->E1_ISS - R240Imp->E1_DECRESC,;					//Valor do título =- ALTAMIRO INCLUSAO DOS IMPOSOTS PIS COFINS CSLL E ISS
	Iif(nTipCob==1,"",Iif(nTipCob==2,CB_RN_NN[3],"" )) }							//Nosso numero (Ver fórmula para calculo)
	
	**'Marcela Coimbra - Ajuste da montagem do aDadosTit para acertar o valor do boleto'**
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
	//³Dados Sacado   ?
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
	aDatSacado   := {	AllTrim(SA1->A1_NOME)                            ,;      //Razão Social
	AllTrim(SA1->A1_COD )                            ,;      //Código
	AllTrim(SA1->A1_END ) 							 ,;		  //Endereco
	Alltrim(SA1->A1_BAIRRO)							 ,;      //Bairro
	AllTrim(SA1->A1_MUN )                            ,;      //Cidade
	SA1->A1_EST                                      ,;      //Estado
	SA1->A1_CEP                                      ,;       //CEP
	Transform(alltrim(SA1->A1_CGC) ,IIF( SA1->A1_PESSOA == 'F','@R 999.999.999-99' , '@R 99.999.999/9999-99' ) )	     }       //CEP
	
	If nTipCob == 1
		
		// Preencher SE1->E1_YTPEXP com "B"
		
		ImpCNAB(	aCobranca	,R240Imp->E1_SDDECRE		,R240Imp->E1_SDACRES	,.T.			,;
			aBMP		,aDadosEmp					,aDadosTit				,aDadosBanco	,;
			aDatSacado	,aMsgBoleto					,""						,aOpenMonth		,;
			aDependentes,aObservacoes				,cCart 					,cPrefixo		,;
			cTitulo		,R240Imp->E1_CODEMP			,R240Imp->E1_MATRIC		,lPrima			)
		
		If lPrima
			lPrima := .F.
		Endif
		
	ElseIf nTipCob == 2 .and.  !l_Segunda
		
		// Preencher SE1->E1_YTPEXP com "D"
		
		ImpGraf(	aCobranca	,R240Imp->E1_SDDECRE		,R240Imp->E1_SDACRES	,oPrint			,;
			aBMP		,aDadosEmp					,aDadosTit				,aDadosBanco	,;
			aDatSacado	,aMsgBoleto					,CB_RN_NN				,aOpenMonth		,;
			aDependentes,aObservacoes				,cCart 					,cPrefixo		,;
			cTitulo		,R240Imp->E1_CODEMP			,R240Imp->E1_MATRIC)
		
		
	ElseIf  nTipCob == 4 .or.( nTipCob == 2   .and.  l_Segunda )
		
		dbSelectArea("BA1")
		dbSetOrder(1)
		If 	BA1->(DbSeek(xFilial("BA1") + "0001" + R240Imp->E1_CODEMP + R240Imp->E1_MATRIC + "T"))
			
			c_Nome 	:= BA1->BA1_NOMUSR
			c_Email := BA1->BA1_EMAIL
			
		EndIf
		
		
		ImpGrafPdf(	aCobranca	,R240Imp->E1_SDDECRE		,R240Imp->E1_SDACRES	,oPrint			,;
			aBMP		,aDadosEmp					,aDadosTit				,aDadosBanco	,;
			aDatSacado	,aMsgBoleto					,CB_RN_NN				,aOpenMonth		,;
			aDependentes,aObservacoes				,cCart 					,cPrefixo		,;
			cTitulo		,R240Imp->E1_CODEMP			,R240Imp->E1_MATRIC     , c_Nome, c_Email, @a_Anexo ,;
			( R240Imp->E1_YTPEXP $ 'L||D||H' ) )
		
		l_Mail := .T.
		
	ElseIf nTipCob == 3
		ImpAnlt(	aCobranca	,R240Imp->E1_SDDECRE		,R240Imp->E1_SDACRES	,.T.			,;
			aBMP		,aDadosEmp					,aDadosTit				,aDadosBanco	,;
			aDatSacado	,aMsgBoleto					,""						,aOpenMonth		,;
			aDependentes,aObservacoes				,cCart 					,cPrefixo		,;
			cTitulo		,R240Imp->E1_CODEMP			,R240Imp->E1_MATRIC		,lPrima	)
		
		
	Endif
	
	R240Imp->(DbSkip())
End

c_LogGer := ""

//?-------------------------------------------------------------------?
//| Fecha arquivos...                                                  |
//?-------------------------------------------------------------------?
R240Imp->(DbCloseArea())

If nTipCob == 1
	
	If Type("nHdl") <> "U"
		
		cString := CNABTRAILLER()
		
		cLin := Space(1)+cEOL
		cCpo := cString
		
		If !(U_GrLinha_TXT(cCpo,cLin))
			MsgAlert("ATENÇÃO! NÃO FOI POSSÍVEL GRAVAR CORRETAMENTE O TRAILLER! OPERAÇÃO ABORTADA!")
			Return Nil
		Endif
		
		U_Fecha_TXT()
		PutMV("MV_YSEQCNA", n_SeqCNAB+1)
		
	Else
		MsgAlert("Nenhum registro gerado no arquivo CNAB!","Atenção!")
	Endif
	
ElseIf nTipCob == 2  .and. !l_Segunda
	
	//?-------------------------------------------------------------------------?
	//| Libera impressao                                                         |
	//?-------------------------------------------------------------------------?
	oPrint:EndPage()     // Finaliza a página
	//	oPrint:Setup()
	//	oPrint:Print()
	oPrint:Preview()     // Visualiza antes de imprimir
	
ElseIf nTipCob == 3
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//?Nova Critica: nao gerar arquivo caso existam   ?
	//?inconsistencias na geracao.(Data: 8/11/07)     ?
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If Len(_aErrAnlt) > 0
		PLSCRIGEN(_aErrAnlt,{ {"Cod. Beneficiário","@C",150},{"Descrição","@C",300}},"Críticas encontradas na exportação! Arquivo exportação analítico não ser?gerado!",.T.)
		_aErrAnlt := {}
	EndIf
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//?Definir nome do arquivo, cfme convencionado... ?
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	nPCont := 1
	nPCont1 := 1
	
	For nPCont := 1 to Len(aMatUti)
		
		cNomeArq := cDirExp+"extat"+cMesTit+Substr(cAnoTit,3,2)+Substr(aMatUti[nPCont],2)+".TXT"
		nReg := 1
		nRegCab := 0
		
		cQtdEx := '000000'
		
		//Raios - modificar este ponto para imprimir mais rapidamente, atraves de temporario...
		If U_Cria_TXT(cNomeArq)
			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
			//?Impressao das linhas do arquivo...   	  ?
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
			cArray := aMatUti[nPCont]
			cLin := Space(1)+cEOL
			
			
			For nPCont1 := 1 to Len(&cArray)
				
				cEleImp := cArray+"[nPCont1]"
				
				If !(U_GrLinha_TXT(&cEleImp+StrZero(nReg,5),cLin))
					MsgAlert("ATENÇÃO! NÃO FOI POSSÍVEL GRAVAR CORRETAMENTE O CABEÇALHO! OPERAÇÃO ABORTADA!")
					Return
				Endif
				nReg++
				
				If Substr(&cEleImp,1,1) == "1"
					nRegCab++
					cQtdEx := soma1( cQtdEx )
				Endif
				
			Next
			
			c_LogGer += "Arquivo " + "extat"+cMesTit+Substr(cAnoTit,3,2)+Substr(aMatUti[nPCont],2)+": Gerados " + cQtdEx + " extratos. " + cEOL
			c_LogGer += "________________________________________________________________________________" + cEOL
			c_LogGer += " " + cEOL
			c_LogGer += " " + cEOL
			
			
			U_Fecha_TXT()
			
			aadd(aMatExi,{cNomeArq,Str(nRegCab)})
			
		Endif
		
	Next
	
	If Len(aMatExi) > 0
		PLSCRIGEN(aMatExi,{ {"Nome Arquivo","@C",150},{"Qtd. Familias","@C",60} },"Exportação concluída! Verifique os resultados.",.T.)
	Endif
	
	//Endif
	
Endif

If !Empty( c_LogGer )
	
	cNomeArq := cDirExp+"LOG_EXTRATO"+cMesTit+Substr(cAnoTit,3,2)+".TXT"
	
	MemoWrit(cNomeArq,  c_LogGer)
	
EndIf

If Len(aCritica) > 0
	PLSCRIGEN(aCritica,{ {"Descrição da inconsistência","@C",200},{"Chave do título","@C",100}},"Críticas encontradas na exportação! Arquivo exportação CNAB não ser?gerado!",.T.)
	//	FErase(GETNEWPAR("MV_YDIBOL","\CNAB\Exporta\")+_cSeqNom+".txt")
	
	// tirarmbc Libera_CNAB(_cSeqNom)
	
Else
	If nTipCob == 1
		MsgAlert("Arquivo gerado com sucesso! Verifique o resultado.","Atenção!")
		MsgAlert("Arquivo : ("+_CSEQNOM+")","Atenção!")
	Endif
Endif
aCritica := {}

//?-------------------------------------------------------------------------?
//| Fim do Relat¢rio                                                         |
//?-------------------------------------------------------------------------?
Return


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa   ?ImpGraf  ?Autor ?Rafael M. Quadrotti   ?Data ?08.10.03 ³±?
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao  ?Imprime Boleto modo grafico                                ³±?
±±ÚÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Alteracoes ?Data     ³Motivo                                           ³±?
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
/*/

Static Function ImpGraf(	aCobranca		,nAbatim		,nAcrescim		,oPrint		,;
		aBMP			,aDadosEmp		,aDadosTit		,aDadosBanco,;
		aDatSacado		,aMsgBoleto		,CB_RN_NN		,aOpenMonth	,;
		aDependentes	,aObservacoes	,cCart			,cPrefixo	,;
		cTitulo			,cGrupoEmp 		,cMatric)
	
	Local oFont8	// --?
	Local oFont10	// 	 |
	Local oFont11n	// 	 |
	Local oFont13	// 	 |
	Local oFont13n	// 	 |
	Local oFont15n	// 	 ? Fontes para impressao do relatorio grafico.
	Local oFont16	// 	 |
	Local oFont16n	// 	 |
	Local oFont21	// --?
	Local aCoords1 	:= {2000,1900,2100,2300}
	Local aCoords2 	:= {2270,1900,2340,2300}
	Local oBrush
	// 17 linha de extrato
	Local aLinhas	:= {}
	Local aLin1 	:= { 805, 850, 900, 950, 1000, 1050, 1100, 1150, 1200, 1250 ,1300 ,1350 ,1400 ,1450 ,1500 ,1550 ,1600 }
	Local aLin2		:= { 805, 850, 900, 950, 1000, 1050, 1100, 1150, 1200, 1250 ,1300 ,1350 ,1400 ,1450 ,1500 ,1550 ,1600,;
		1650,1700,1750,1800,1850,1900,1950, 2000, 2050, 2100 ,2150 ,2200 , 2250 , 2300 , 2350 ,2400 ,2450}
	
	Local nI		:= 0	// Contador do laco para impressao de dependentes.
	Local nMsg      := 0    // Contador para as mensagens
	Local cMoeda	:= "9"  // Moeda do boleto.
	Local nTamCorp	:= 1	// Tipo do corpo do extrato 1 = noraml 2 = Grande.
	Local nCob		:= 0	// Contador para for do extrato.
	Local lNovaPg	:= .F.	// Nova pagina. Controle de quebra do extrato.
	Local nLin		:= 1	// Linha atual da impressao
	
	//Parâmetros de TFont.New()
	//1.Nome da Fonte (Windows)
	//3.Tamanho em Pixels
	//5.Bold (T/F)
	oFont8  := TFont():New("Arial",9,8 ,.T.,.F.,5,.T.,5,.T.,.F.)
	oFont10 := TFont():New("Arial",9,10,.T.,.T.,5,.T.,5,.T.,.F.)
	oFont11 := TFont():New("Courier",9,10,.T.,.T.,5,.T.,5,.T.,.F.)
	
	oFont11n:= TFont():New("Arial",9,11,.T.,.T.,5,.T.,5,.T.,.F.)
	
	oFont13 := TFont():New("Arial",9,13,.T.,.T.,5,.T.,5,.T.,.F.)
	oFont13n:= TFont():New("Arial",9,13,.T.,.F.,5,.T.,5,.T.,.F.)
	oFont15n:= TFont():New("Arial",9,15,.T.,.F.,5,.T.,5,.T.,.F.)
	oFont16 := TFont():New("Arial",9,16,.T.,.T.,5,.T.,5,.T.,.F.)
	oFont16n:= TFont():New("Arial",9,16,.T.,.F.,5,.T.,5,.T.,.F.)
	oFont21 := TFont():New("Arial",9,21,.T.,.T.,5,.T.,5,.T.,.F.)
	
	oBrush := TBrush():New("",4)
	
	oPrint:StartPage()   // Inicia uma nova página
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
	//³Analiza se sera necessario usar mais de um pagina... ?
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
	If Len(aCobranca) <= 17
		aLinhas 	:= aClone(aLin1)
		nTamCorp    := 1
	Else
		aLinhas 	:= aClone(aLin2)
		nTamCorp    := 2
		lNovaPg 	:= .T.
	Endif
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
	//³Imprime o cabecalho do boleto...               ?
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
	R240HEADER(@oPrint,aDadosEmp,oFont8,oFont11n,oFont10,aBmp, aDadosTit, aDadosBanco, aDatSacado, aDependentes, aOPenMonth, oBrush, nTamCorp)
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
	//³Imprime detalhes do extratos com dados para cobranca.?
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
	nTotLin := 1600 //Ultima linha do extrato padrao. A partir desta linha sera adicionada + 50 pixeis e a
	//ficha de compensacao sera gerada em uma nova pagina.
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
	//³Imprime detalhes do extrato...                       ?
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
	For nCob := 1 To Len(aCobranca)
		If Iif(nTamCorp == 1, nLin > 17, nLin > 34)
			oPrint:EndPage()			// Finaliza a pagina
			oPrint:StartPage()			// Inicializo nova pagina
			
			nTamCorp := Iif(((Len(aCobranca)-nCob) <= 17), 1, 2)
			aLinhas	 := Iif(nTamCorp == 1, aClone(aLin1), aClone(aLin2) )
			
			R240HEADER(@oPrint,aDadosEmp,oFont8,oFont11n,oFont10,aBmp, aDadosTit, aDadosBanco, aDatSacado, aDependentes, aOPenMonth, oBrush)
			
			oPrint:Say (aLinhas[1],0110 ,SubStr(Alltrim(aCobranca[nCob][1]),1,21),oFont8 )
			oPrint:Say (aLinhas[1],0510 ,Substr(Alltrim(aCobranca[nCob][2]),1,30),oFont8 )
			oPrint:Say (aLinhas[1],1060 ,Iif(Empty(aCobranca[nCob][3]),"",DtoC(StoD(aCobranca[nCob][3]))),oFont8 )
			oPrint:Say (aLinhas[1],1260 ,SubStr(Alltrim(aCobranca[nCob][5])+"-"+aCobranca[nCob][6],1,40),oFont8 )
			oPrint:Say (aLinhas[1],1810 ,Iif(Empty(aCobranca[nCob][11]),"",Trans(aCobranca[nCob][11], "@E 999,999.99")),oFont8 )
			oPrint:Say (aLinhas[1],2110 ,Iif(Empty(aCobranca[nCob][7]),"",Trans(aCobranca[nCob][7], "@E 999,999.99")),oFont8 )
			
			nLin := 2
		Else
			oPrint:Say (aLinhas[nLin],0110 ,SubStr(Alltrim(aCobranca[nCob][1]),1,21),oFont8 )
			oPrint:Say (aLinhas[nLin],0510 ,Substr(Alltrim(aCobranca[nCob][2]),1,30),oFont8 )
			oPrint:Say (aLinhas[nLin],1060 ,Iif(Empty(aCobranca[nCob][3]),"",DtoC(StoD(aCobranca[nCob][3]))),oFont8 )
			oPrint:Say (aLinhas[nLin],1260 ,SubStr(Alltrim(aCobranca[nCob][5])+"-"+aCobranca[nCob][6],1,40),oFont8 )
			oPrint:Say (aLinhas[nLin],1830 ,Iif(Empty(aCobranca[nCob][11]),"",Trans(aCobranca[nCob][11], "@E 999,999.99")),oFont8 )
			oPrint:Say (aLinhas[nLin],2110 ,Iif(Empty(aCobranca[nCob][7]),"",Trans(aCobranca[nCob][7], "@E 999,999.99")),oFont8 )
			
			nLin ++
		EndIf
	Next
	
	//multinat
	
	//If SE1->E1_PREFIXO == 'FIN'
	dbSelectArea("SEV")
	dbSetOrder(1)
	If dbSeek(xFilial("SEV") + SE1->E1_PREFIXO + SE1->E1_NUM + SE1->E1_PARCELA + SE1->E1_TIPO)
		
		While !SEV->( EOF() ) .and. SEV->( EV_FILIAL+EV_PREFIXO+EV_NUM+EV_PARCELA+EV_TIPO) == xFilial("SE1") + SE1->E1_PREFIXO + SE1->E1_NUM + SE1->E1_PARCELA + SE1->E1_TIPO
			
			c_DescEv := ALLTRIM( POSICIONE("SED", 1, XFILIAL("SED") + SEV->EV_NATUREZ, "ED_DESCRIC") )
			
			oPrint:Say (aLinhas[nLin],0110 , c_DescEv + space(50 - LEN(c_DescEv))  ,oFont8 )
			oPrint:Say (aLinhas[nLin],0580 , "R$ " + Transform(SEV->EV_VALOR,"@E 999,999,999.99") ,oFont8 )
			
			nLin ++
			
			SEV->( dbSkip() )
			
		EndDo
		
	EndIf
	
	// EndIf
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Caso tenha ocorrido a quebra de pagina emite a?
	//³ficha de compensacao em uma nova folha.       ?
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If lNovaPg
		oPrint:EndPage()			// Finaliza a pagina
		oPrint:StartPage()			// Inicializo nova pagina
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Imprime novo cabecalho de pagina?
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		R240HEADER(@oPrint,aDadosEmp,oFont8,oFont11n,oFont10,aBmp, aDadosTit, aDadosBanco, aDatSacado, aDependentes, aOPenMonth, oBrush)
	EndIf
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Impressao da observacao.?
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	nMsg:=1650
	oPrint:Say  (1625,105,STR0014                ,oFont8 ) //"Observação"
	For nI := 1 To len(aObservacoes)
		oPrint:Say  (nMsg,105,aObservacoes[nI]        ,oFont11 )
		
		nMsg+=31
		If nI > 5
			Exit
		EndIf
	Next nI
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Emissao da ficha de compensacao.?
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	//Demonstrar vencimento e valor do titulo.
	//oPrint:FillRect(aCoords1,oBrush)
	//oPrint:FillRect(aCoords2,oBrush)
	
	oPrint:Line (2000,100,2000,2300)
	oPrint:Line (2000,550,1920,550 )
	oPrint:Line (2000,770,1920,770 )
	oPrint:Say  (1934,100,Substr(aDadosBanco[2],1,14),oFont13n )
	oPrint:Say  (1912,567,aDadosBanco[1]+"-"+Modulo11(aDadosBanco[1]),oFont21 )
	oPrint:Say  (1934,790,CB_RN_NN[2],oFont13n)
	
	oPrint:Line (2100,100,2100,2300 )
	oPrint:Line (2200,100,2200,2300 )
	oPrint:Line (2270,100,2270,2300 )
	oPrint:Line (2340,100,2340,2300 )
	
	oPrint:Line (2200,500,2340,500)
	oPrint:Line (2270,750,2340,750)
	oPrint:Line (2200,1000,2340,1000)
	oPrint:Line (2200,1350,2270,1350)
	oPrint:Line (2200,1550,2340,1550)
	
	oPrint:Say  (2000,100 ,STR0015                             ,oFont8) //"Local de Pagamento"
	
	//-----------------------------------------------------
	// INÍCIO - MATEUS MEDEIROS - GLPI 54208
	// COMENTADO
	//	oPrint:Say  (2040,100 ,"At?o vencimento, preferencialmente no Bradesco. Após o vencimento, somente no Bradesco"        ,oFont10) //"Qualquer banco at?a data do vencimento"
	// FIM - MATEUS MEDEIROS - GLPI 54208
	oPrint:Say  (2040,100 ,"Pagável preferencialmente na rede Bradesco ou no Bradesco Expresso."        ,oFont10) //"Qualquer banco at?a data do vencimento"
	
	oPrint:Say  (2000,1910,STR0008                                     ,oFont8) //"Vencimento"
	oPrint:Say  (2040,2010,Substr(DTOS(aDadosTit[4]),7,2)+"/"+Substr(DTOS(aDadosTit[4]),5,2)+"/"+Substr(DTOS(aDadosTit[4]),1,4)  ,oFont10)
	
	oPrint:Say  (2100,100 ,STR0017                                        ,oFont8) //"Cedente"
	oPrint:Say  (2140,100 ,AllTrim(aDadosEmp[1]) +  "  " + aDadosEmp[6]            ,oFont10)
	
	oPrint:Say  (2100,1910,STR0012                         ,oFont8) //"Agência/Código Cedente"
	//oPrint:Say  (2140,2010,aDadosBanco[3]+"/"+aDadosBanco[4]+"-"+aDadosBanco[5],oFont10)
	oPrint:Say  (2140,1950,aDadosBanco[3]+"/"+alltrim(aDadosBanco[4])+"-"+alltrim(aDadosBanco[5]),oFont10)
	
	oPrint:Say  (2200,100 ,STR0018                              ,oFont8) //"Data do Documento"
	oPrint:Say  (2230,100 ,DTOC(aDadosTit[3])                               ,oFont10)
	
	oPrint:Say  (2200,505 ,STR0019                                  ,oFont8) //"Nro.Documento"
	oPrint:Say  (2230,605 ,aDadosTit[1]                                     ,oFont10)
	
	oPrint:Say  (2200,1005,STR0020                                   ,oFont8) //"Espécie Doc."
	oPrint:Say  (2230,1005,"  DM"                                      ,oFont10)   		&& 10/12/13 - Impressao Especie Documento
	
	oPrint:Say  (2200,1355,STR0021                                   ,oFont8) //"Aceite"
	oPrint:Say  (2230,1455,"N"                                       ,oFont10)
	
	oPrint:Say  (2200,1555,STR0022                          ,oFont8) //"Data do Processamento"
	oPrint:Say  (2230,1655,DTOC(aDadosTit[2])                               ,oFont10)
	
	oPrint:Say  (2200,1910,STR0013                                   ,oFont8) //"Nosso Número"
	//oPrint:Say  (2230,2010,cCart+"/"+aDadosTit[6]+"-"+U_Calc_DigCab(aDadosBanco[3]+aDadosBanco[4]+cCart+aDadosTit[6])                ,oFont10)
	
	//oPrint:Say  (2230,1950,cCart+"/"+aDadosTit[6]+"-"+U_Calc_DigCab(aDadosBanco[3]+aDadosBanco[4]+cCart+aDadosTit[6])                ,oFont10)		&& Vitor Sbano 05/12/13
	
	oPrint:Say  (2230,1950,alltrim(cCart)+"/"+aDadosTit[6]+"-"+U_CalcDVBrad(substr(alltrim(cCart),1,2)+aDadosTit[6])          ,oFont10)		&& Vitor Sbano 10/12/13
	
	oPrint:Say  (2270,100 ,STR0023                                   ,oFont8) //"Uso do Banco"
	
	oPrint:Say  (2270,505 ,STR0024                                       ,oFont8) //"Carteira"
	oPrint:Say  (2300,555 ,cCart                                   ,oFont10)
	
	oPrint:Say  (2270,755 ,STR0025                                        ,oFont8) //"Espécie"
	oPrint:Say  (2300,805 ,STR0026                                             ,oFont10) //"R$"
	
	oPrint:Say  (2270,1005,STR0027                                     ,oFont8) //"Quantidade"
	oPrint:Say  (2270,1555,STR0028                                          ,oFont8) //"Valor"
	
	oPrint:Say  (2270,1910,STR0029                          ,oFont8) //"(=)Valor do Documento"
	oPrint:Say  (2300,2010,AllTrim(Transform(aDadosTit[5],"@E 999,999,999.99")),oFont10)
	
	oPrint:Say  (2340,100 ,"Instruções (Todas as informações deste bloqueto são de exclusiva responsabilidade do cedente)",oFont8) //"Instruções/Texto de responsabilidade do cedente"
	
	nMsg:=2390
	For nI := 1 To len(aMsgBoleto)
		oPrint:Say  (nMsg,120,aMsgBoleto[nI]                ,oFont10 )
		nMsg+=50
		If nI > 6
			Exit
		EndIf
	Next nI
	
	oPrint:Say  (2340,1910,STR0031                         ,oFont8) //"(-)Desconto/Abatimento"
	oPrint:Say  (2370,2010,AllTrim(Transform(nAbatim,"@ZE 999,999,999.99")),oFont10)
	
	oPrint:Say  (2410,1910,STR0032                             ,oFont8) //"(-)Outras Deduções"
	oPrint:Say  (2480,1910,STR0033                                  ,oFont8) //"(+)Mora/Multa"
	oPrint:Say  (2550,1910,STR0034                           ,oFont8) //"(+)Outros Acréscimos"
	oPrint:Say  (2570,2010,AllTrim(Transform(nAcrescim,"@ZE 999,999,999.99")),oFont10)
	// oPrint:Say  (2240,2010,AllTrim(Transform(nAcrescim,"@ZE 999,999,999.99")),oFont10) // Marcela coimbra - Alterada Posição - Chamado GLPI 2813
	oPrint:Say  (2620,1910,STR0035                               ,oFont8) //"(-)Valor Cobrado"
	
	oPrint:Say  (2690,100 ,STR0036                                         ,oFont8) //"Sacado"
	oPrint:Say  (2720,400 ,aDatSacado[1]+" - CPF/CNPJ: " + aDatSacado[8]       ,oFont10)
	oPrint:Say  (2773,400 ,aDatSacado[3]                                    ,oFont10)
	oPrint:Say  (2826,400 ,aDatSacado[4]+" - "+aDatSacado[5]+" - "+aDatSacado[6] ,oFont10)
	oPrint:Say  (2879,400 ,Substr(aDatSacado[7],1,5) + "-" + Substr(aDatSacado[7],6,3)  ,oFont10)
	
	oPrint:Say  (2895,100 ,STR0037                               ,oFont8) //"Sacador/Avalista"
	oPrint:Say  (2935,1500,STR0038                        ,oFont8) //"Autenticação Mecânica -"
	oPrint:Say  (2935,1850,STR0039                           ,oFont10) //"Ficha de Compensação"
	
	oPrint:Line (2000,1900,2690,1900 )
	oPrint:Line (2410,1900,2410,2300 )
	oPrint:Line (2480,1900,2480,2300 )
	oPrint:Line (2550,1900,2550,2300 )
	oPrint:Line (2620,1900,2620,2300 )
	oPrint:Line (2690,100 ,2690,2300 )
	oPrint:Line (2930,100,2930,2300  )
	
	
	//MSBAR("INT25",36,1.5,CB_RN_NN[1],oPrint,.F.,Nil,Nil,0.025,1.2,Nil,Nil,"A",.F.)
	//MSBAR3("INT25",21.5,1,CB_RN_NN[1],oPrint,.F.,Nil,Nil,0.025,1.2,Nil,Nil,"A",.F.)
	cNmPrnTmp := UPPER(PrnGetName())
	cNomePrint := ""
	nCtNome := Len(Alltrim(cNmPrnTmp))
	
	While .T.
		If Substr(cNmPrnTmp,nCtNome,1) $ "\:"
			cNomePrint := Alltrim(Substr(cNmPrnTmp,nCtNome+1,Len(Alltrim(cNmPrnTmp))))
			nCtNome := 0
		Endif
		nCtNome--
		
		If nCtNome <= 0
			Exit
		Endif
	Enddo
	
	//junho 2009 tratar "lixo" no nome da printer - Motta
	nCtNome := Len(Alltrim(cNmPrnTmp))
	cNmPrnTmp := cNomePrint
	
	While .T.
		If Substr(cNmPrnTmp,nCtNome,1) $ "["
			cNomePrint := Alltrim(Substr(cNmPrnTmp,1,nCtNome-1))
			nCtNome := 0
		Endif
		nCtNome--
		
		If nCtNome <= 0
			Exit
		Endif
	Enddo
	
	//Do case
	//	Case cNomePrint $ Upper(Alltrim(GetNewPar("MV_YPRINTP","4050_OPERACAO1"))) .or.;
		//	 cNomePrint $ Upper(Alltrim(GetNewPar("MV_YPRINT2"," "))) .OR.  ;
		//	  cNomePrint $ Upper(Alltrim(GetNewPar("MV_YPRINT3"," ")))
	MSBAR3("INT25",25,1.5,CB_RN_NN[1],oPrint,.F.,Nil,Nil,0.025,1.2,Nil,Nil,"A",.F.) //4050
	//	OtherWise
	//		MSBAR3("INT25",12.6,1,CB_RN_NN[1],oPrint,.F.,Nil,Nil,0.025,1.2,Nil,Nil,"A",.F.) //SEATE2 - em testes (Jean - 05/12/07)
	//EndCase
	
	oPrint:EndPage() // Finaliza a página
	
Return Nil

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ?
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±?
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±?
±±ºFuncao    ³PLR240MES ºAutor  ³Rafael M. Quadrotti ?Data ? 02/04/04   º±?
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±?
±±ºDesc.     ³Retorna os meses em aberto do sacado.                       º±?
±±?         ?                                                           º±?
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±?
±±ºUso       ?AP6                                                        º±?
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±?
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±?
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß?
*/
Static Function PLR240MES(cCliente,cLoja,cMesBase,cAnoBase)
	Local aMeses 	:= {} 							//Retorno da funcao.
	Local cSQL      := ""							//Query
	Local cSE1Name 	:= SE1->(RetSQLName("SE1"))	//retorna o alias no TOP.
	
	SE1->(DbSetOrder(1))
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//?Monta query...                                                           ?
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	cSQL := "SELECT * FROM "+cSE1Name+" WHERE E1_FILIAL = '" + xFilial("SE1") + "' AND "
	cSQL += "			E1_CLIENTE = '"+cCliente+"' AND "
	cSQL += "			E1_LOJA    = '"+cLoja+"' AND "
	cSQL += "			E1_SALDO > 0 AND "
	cSQL += "			E1_PREFIXO IN ('ANT','PLS') AND "
	cSQL += "			E1_TIPO <> 'PR ' AND "
	cSQL += "			E1_PARCELA <> '" + StrZero(0, Len(SE1->E1_PARCELA)) + "' AND "
	cSQL += "         E1_ANOBASE||E1_MESBASE < '" + cAnoBase+cMesBase + "' AND "// aberto
	cSQL += cSE1Name+".D_E_L_E_T_ = ' ' "
	cSQL += "ORDER BY 1,2,3,4,5,6" //+ SE1->(IndexKey())  //aberto
	
	PLSQuery(cSQL,STR0040) //"Meses"
	
	If Meses->(Eof())
		Meses->(DbCloseArea())
	Else
		While 	Meses->(!Eof()) .And.;
				Meses->E1_CLIENTE == cCliente .And.;
				Meses->E1_LOJA ==	cLoja
			//If (cMesBase<>E1_MESBASE .And. cAnoBase<>E1_ANOBASE) // aberto
			if ! empty (Meses->(E1_ANOBASE+E1_MESBASE))  // altmairo - tratar tit de impostos que sao gerados sem mesbase , anobase
				If (cAnoBase+cMesBase<>Meses->(E1_ANOBASE+E1_MESBASE))
					Aadd(aMeses,Meses->E1_MESBASE+"/"+Meses->E1_ANOBASE)
				EndIf
			EndIf
			Meses->(DbSkip())
		End
		Meses->(DbCloseArea())
	EndIf
Return (aMeses)


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ?
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±?
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±?
±±ºFuncao    ³PLR240TEXTºAutor  ³Rafael M. Quadrotti ?Data ? 02/04/04   º±?
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±?
±±ºDesc.     ³Retorna as mensagens para impressao.                        º±?
±±?         ?                                                           º±?
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±?
±±?         ?Esta funcao executa uma selecao em tres tabelas para       º±?
±±?         ?encontrar a msg relacionada ao sacado.                     º±?
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±?
±±ºUso       ?AP6                                                        º±?
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±?
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±?
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß?
*/
Static Function PLR240TEXT(	nTipo	,cCodInt	,cCodEmp	,cConEmp,;
		cSubCon	,cMatric	,cBase	)//cBase = Ano+mes
	Local cQuery	:= ""
	Local cNTable1	:= "" // Nome da tabela no SQL
	Local cNTable2	:= "" // Nome da tabela no SQL
	Local cNTable3	:= "" // Nome da tabela no SQL
	Local aMsg		:= {} // Array de mensagens
	Local nCont		:= 0
	Local cMsg01    := ""
	Local nLimite   := 100 // Motta 08/07/08 para agosto/08 // 90 // limite linha msg Motta 16/8/07
	
	
	If funname() ==  "PLSA730"
		
		nLimite   := 101
		
	EndIf
	
	DbSelectArea("BH1")
	DbSetOrder(2)
	cNTable1 := RetSqlName("BH1")
	cNTable2 := RetSqlName("BA3")
	cNTable3 := RetSqlName("BH2")
	
	cQuery := "SELECT BH1.* ,BH2.* "
	If !Empty(cMatric)
		cQuery += " ,BA3.BA3_CODPLA,BA3.BA3_FILIAL,BA3.BA3_CODINT,BA3.BA3_CODEMP,BA3.BA3_MATRIC,BA3.BA3_CONEMP,BA3.BA3_VERCON,BA3.BA3_SUBCON,BA3.BA3_VERSUB "
	Endif
	cQuery += " FROM " +cNTable1+ " BH1 , " +cNTable3 +" BH2 "
	If !Empty(cMatric)
		cQuery += " , "+cNTable2 +" BA3 "
	Endif
	
	//BH1
	cQuery += "WHERE BH1.BH1_FILIAL='"	+	xFilial("BH1")		+	"'    AND "
	cQuery += "		 BH1.BH1_CODINT='"	+	cCodInt				+	"'    AND "
	cQuery += "		 BH1.BH1_TIPO='"	+	Transform(nTipo,"9")+	"'    AND "
	If !Empty(cCodEmp)
		cQuery += "(('"+cCodEmp +"' BETWEEN BH1.BH1_EMPDE   AND BH1.BH1_EMPATE) OR (BH1.BH1_EMPATE='' AND BH1.BH1_EMPDE='') ) AND "
	EndIf
	If !Empty(cConEmp)
		cQuery += "(('"+cConEmp +"' BETWEEN BH1.BH1_CONDE   AND BH1.BH1_CONATE)  OR (BH1.BH1_CONATE='' AND BH1.BH1_CONDE='') ) AND "
	EndIf
	If !Empty(cSubCon)
		cQuery += "(('"+cSuBCon +"' BETWEEN BH1.BH1_SUBDE   AND BH1.BH1_SUBATE)  OR (BH1.BH1_SUBATE='' AND BH1.BH1_SUBDE='') ) AND "
	EndIf
	If !Empty(cMatric)
		cQuery += "(('"+cMatric +"' BETWEEN BH1.BH1_MATDE   AND BH1.BH1_MATATE)  OR (BH1.BH1_MATATE='' AND BH1.BH1_MATDE='') ) AND "
	EndIf
	If !Empty(cBase)
		cQuery += "(('"+cBase   +"' BETWEEN BH1.BH1_BASEIN AND BH1.BH1_BASEFI) OR (BH1.BH1_BASEIN='' AND BH1.BH1_BASEFI='') ) AND "
	EndIf
	//BA3 PARA ENCONTRAR O PLANO, CASO MATRICULA SEJA INFORMADA!
	If !Empty(cMatric)
		cQuery += "		 BA3.BA3_FILIAL='"	+	xFilial("BA3")	+	"'    AND "
		cQuery += "		 BA3.BA3_CODINT='"	+	cCodInt  		+	"'    AND "
		cQuery += "		 BA3.BA3_CODEMP='"	+	cCodEmp  		+	"'    AND "
		cQuery += "		 BA3.BA3_MATRIC='"	+	cMatric  		+	"'    AND "
		cQuery += "		((BA3.BA3_CODPLA BETWEEN BH1.BH1_PLAINI AND BH1.BH1_PLAFIM) OR (BH1.BH1_PLAINI='' AND BH1.BH1_PLAFIM='') ) AND "
	Endif
	
	//BH2 MENSAGENS PARA IMPRESSAO
	cQuery += "		 BH2.BH2_FILIAL = '"	+	xFilial("BH2")	+	"'    AND "
	cQuery += "		 BH2.BH2_CODIGO = BH1.BH1_CODIGO  AND "
	
	cQuery += "		BH1.D_E_L_E_T_<>'*' AND BH2.D_E_L_E_T_<>'*' "
	
	If !Empty(cMatric)
		cQuery += " AND BA3.D_E_L_E_T_<>'*' "
	Endif
	
	cQuery += "ORDER BY " + BH1->(IndexKey())
	
	
	//fim mensagem cpf duplicidade
	PLSQuery(cQuery,"MSG")
	
	If MSG->(Eof())
		MSG->(DbCloseArea())
		Aadd(aMSG,"")
	Else
		While !MSG->(Eof())
			If Iif(BH1->(FieldPos("BH1_CONDIC")) > 0 , (Empty(MSG->BH1_CONDIC) .or. (&(MSG->BH1_CONDIC))), .T.)
				If MSG->BH1_TIPO == '2' // Observacao
					cMsg01 := MSG->BH2_MSG01
					//Alteração Roberto Mendes - 27/11/13
					cMsg01 := StrTran(cMsg01, "ITAU", "BRADESCO" )
					//Fim Alteração Roberto Mendes
					Aadd(aMSG,Substr(cMsg01,1,nLimite)) // Paulo Motta 16/8/7
					Aadd(aMSG,Substr(cMsg01,(nLimite + 1),nLimite))
					Aadd(aMSG,Substr(cMsg01,(2*nLimite + 1),nLimite))
					//Aadd(aMSG,Substr(cMsg01,(3*nLimite + 1),nLimite)) // Paulo Motta 8/7/08
					//Aadd(aMSG,Substr(cMsg01,(4*nLimite + 1),nLimite)) // Paulo Motta 8/7/08
				Else
					//Alteração Roberto Mendes - 27/11/13
					//Aadd(aMSG,&(MSG->BH2_MSG01))
					cMsg01 := StrTran(&(MSG->BH2_MSG01), "ITAU", "BRADESCO" )
					Aadd(aMSG,cMsg01)
					//Fim - Alteração Roberto Mendes
				Endif
			Endif
			MSG->(DbSkip()) //DbSkip()
		Enddo
		If Len(aMSG) == 0
			Aadd(aMSG,"")
		Endif
		MSG->(DbCloseArea())
	EndIf
	
Return aMsg


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ?
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±?
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±?
±±³Programa  ³Ret_cBarra?Autor ?Rafael M. Quadrotti   ?Data ?13/10/03 ³±?
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±?
±±³Descri‡…o ?IMPRESSAO DO BOLETO                                        ³±?
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±?
±±³Uso       ?Especifico para Clientes Microsiga                         ³±?
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±?
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±?
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß?
/*/
Static Function Ret_cBarra(	cBanco	,cAgencia	,cConta		,cDacCC		,;
		cNroDoc	,nValor		,cPrefixo	,cNumero	,;
		cParcela	,cTipo	,cCart)
	Local cMsg     := ""
	Local aArea		:= GetArea()
	Local aCodBar	:= {}
	Local cMoeda	:= "9"
	
	DbSelectArea("SE1")
	DbSetOrder(1)
	If MsSeek(xFilial("SE1")+cPrefixo+cNumero+cParcela+cTipo)
		If !ExistBlock("RETDADOS")
			MsgInfo(STR0056)  //"O RDMAKE, RETDADOS, referente ao layout do boleto, não foi encontrado no repositório"
		Else
			aCodBar:=U_RetDados(	cPrefixo	,cNumero	,cParcela	,cTipo	,;
				cBanco		,cAgencia	,cConta		,cDacCC	,;
				cNroDoc		,nValor		,cCart		,cMoeda	)
			If Len(aCodBar)=3
				If Empty(aCodBar[1])
					cMsg     += STR0057  		//"[1]codigo de barra "
				EndIf
				If Empty(aCodBar[2])
					cMsg     += STR0058  		//"[2]linha digitavel "
				EndIf
				If Empty(aCodBar[3])
					cMsg     += STR0059 		//"[3]nosso numero "
				EndIf
				If !empty(cMsg)
					MsgInfo(STR0060+cMsg )  	//"Erro no(s) campo(s): "
					aCodBar	:= {}
				EndIf
			EndIf
		Endif
	EndIf
	RestArea(aArea)
Return aCodBar

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ?
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±?
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±?
±±ºFuncao    ³R240HeaderºAutor  ³Rafael M. Quadrotti ?Data ? 03/11/04   º±?
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±?
±±ºDesc.     ³Emite um novo cabecalho devido a quebra de pagina.          º±?
±±?         ?                                                           º±?
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±?
±±ºUso       ?AP6 PLS                                                    º±?
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±?
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±?
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß?
*/
Static Function R240HEADER(oPrint,aDadosEmp,oFont8,oFont11n,oFont10,aBitMap, aDadosTit, aDadosBanco, aDatSacado, aDependentes, aOPenMonth, oBrush, nTamCorp)
	Local ni
	
	DEFAULT nTamCorp := 1
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
	//³Dados da empresa....                                 ?
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
	//Jean - modificado em 06/12/07 para contemplar todas as impressoras...
	/*
	oPrint:Say  (050	,500	,aDadosEmp[1]	,oFont11n)
	oPrint:Say  (090	,500	,aDadosEmp[2] 	,oFont8 )
	oPrint:Say  (125	,500	,aDadosEmp[3] 	,oFont8 )
	oPrint:Say  (160	,500	,aDadosEmp[4] 	,oFont8 )
	oPrint:Say  (195	,500	,aDadosEmp[5] 	,oFont8 )
	oPrint:Say  (230	,500	,aDadosEmp[6] 	,oFont8 )
	*/
	//oPrint:Say  (050	,500	,	,oFont11n)
	oPrint:Say  (090	,500	,aDadosEmp[1] 	,oFont11n )
	oPrint:Say  (125	,500	,aDadosEmp[2]+"- "+aDadosEmp[3] 	,oFont8 )
	oPrint:Say  (160	,500	,aDadosEmp[4] 	,oFont8 )
	oPrint:Say  (195	,500	,aDadosEmp[5] 	,oFont8 )
	oPrint:Say  (230	,500	,aDadosEmp[6] 	,oFont8 )
	
	
	//ÚÄÄÄÄÄÄÄÄÄÄ¿
	//³Bmp da ANS?
	//ÀÄÄÄÄÄÄÄÄÄÄÙ
	If File(SuperGetMv("MV_PLSLANS", .F., "ANS.BMP"))
		oPrint:SayBitmap (050 ,1825,SuperGetMv("MV_PLSLANS", .F., "ANS.BMP"),470 ,150)
	Else
		oPrint:Say  (250,500,aDadosEmp[7] ,oFont10)
	Endif
	
	oPrint:Say  (250,1780,STR0044 + R240Imp->E1_MESBASE+" / "+R240Imp->E1_ANOBASE ,oFont10) //"Mês de competência: "
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
	//³Logo tipo da empresa...                              ?
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
	oPrint:SayBitmap (50 ,100,aBitMap[1],350 ,200 ) //coluna inicial / linha inical, bitmap,  coluna final / linha final.
	
	//Linhas do extrato.
	If nTamCorp = 1
		oPrint:Box  (300,100,1852,2300)
		oPrint:Line (400,0100,400,2300)
		oPrint:Line (700,0100,700,2300)
		oPrint:Line (300,0400,400,0400)
		oPrint:Line (300,0800,400,0800)
		oPrint:Line (300,1150,700,1150)
		oPrint:Line (300,1500,400,1500)
		oPrint:Line (300,1900,700,1900)
		
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
		//³Impressao das colunas do extrato de utilizacao.?
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
		oPrint:Line (750,0100,750,2300) // Linha horizontal do cabecalho do extrato. // Extrato de utilizacao
		
		If SE1->E1_PREFIXO == 'PLS'
			
			oPrint:Line (750,0500,1625,0500) // Linha divisória de colunas //usuario/prestador
			oPrint:Line (750,1050,1625,1050) // Linha divisória de colunas //prestador/data
			oPrint:Line (750,1250,1625,1250) // Linha divisória de colunas //data/lote
			//	oPrint:Line (750,1550,1625,1550) // Linha divisória de colunas //lote/nro guia
			oPrint:Line (750,1800,1625,1800) // Linha divisória de colunas //lote/nro guia
			oPrint:Line (750,2100,1625,2100) // Linha divisória de colunas //nro guia/vlr total
			oPrint:Line (800,0100,800,2300) // Linha horizontal do cabecalho do extrato.
			
		EndIf
		/*
		oPrint:Line (750,0500,1625,0500) // Linha divisória de colunas //usuario/prestador
		oPrint:Line (750,1050,1625,1050) // Linha divisória de colunas //prestador/data
		oPrint:Line (750,1250,1625,1250) // Linha divisória de colunas //data/lote
		//	oPrint:Line (750,1550,1625,1550) // Linha divisória de colunas //lote/nro guia
		oPrint:Line (750,1800,1625,1800) // Linha divisória de colunas //lote/nro guia
		oPrint:Line (750,2100,1625,2100) // Linha divisória de colunas //nro guia/vlr total
		oPrint:Line (800,0100,800,2300) // Linha horizontal do cabecalho do extrato.
		*/
		oPrint:Line  (1902,100,1902,2300)// Tracejado para destaque do boleto.
		oPrint:Line (1625,100,1625,2300)// Limite para observacao
		
	Else
		oPrint:Box  (300,100,3200,2300)		// Caixa principal do corpo do boleto
		oPrint:Line (400,0100,400,2300)		// Cabecalho 1                                                         1
		oPrint:Line (700,0100,700,2300)		// Cabecalho 2
		
		oPrint:Line (300,0400,400,0400)
		oPrint:Line (300,0800,400,0800)
		
		oPrint:Line (300,1150,700,1150)
		oPrint:Line (300,1500,400,1500)
		oPrint:Line (300,1900,700,1900)
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
		//³Impressao das colunas do extrato de utilizacao.?
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
		oPrint:Line (750,0100,750,2300) // Linha horizontal do cabecalho do extrato. // Extrato de utilizacao
		oPrint:Line (800,0100,800,2300) // Linha horizontal do cabecalho do extrato.
		oPrint:Line (750,0500,3200,0500) // Linha divisória de colunas
		oPrint:Line (750,1050,3200,1050) // Linha divisória de colunas
		oPrint:Line (750,1250,3200,1250) // Linha divisória de colunas
		//	oPrint:Line (750,1550,3200,1550) // Linha divisória de colunas
		oPrint:Line (750,1800,3200,1800)
		oPrint:Line (750,2100,3200,2100) // Linha divisória de colunas
		
	Endif
	
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
	//³Textos  das colunas do extrato de utilizacao.  ?
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
	If SE1->E1_PREFIXO == 'PLS'
		
		oPrint:Say  (760,0110,STR0049      ,oFont8 )
		oPrint:Say  (760,0510,STR0054      ,oFont8 )
		oPrint:Say  (760,1060,STR0052      ,oFont8 )
		//oPrint:Say  (760,1260,STR0053      ,oFont8 )
		oPrint:Say  (760,1260,"Descrição do serviço",oFont8 )
		//oPrint:Say  (760,1560,STR0061      ,oFont8 )
		oPrint:Say  (760,1810,"Despesa    " ,oFont8 )
		oPrint:Say  (760,2110,"A Pagar"      ,oFont8 )
		oPrint:Say  (710,((2300-21)/2),STR0048      ,oFont8 ) //21 = Len de "Extrato de utilizacao"  Calculo para centralizar //"Extrato de utilização"
		oPrint:FillRect({705,100,750,2300},oBrush)
		
	Else
		
		oPrint:Say  (760,0110,"Descrição"      ,oFont8 )
		oPrint:FillRect({705,100,750,2300},oBrush)
		
	EndIf
	/*
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
	//³Textos  das colunas do extrato de utilizacao.  ?
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
	oPrint:Say  (760,0110,STR0049      ,oFont8 )
	oPrint:Say  (760,0510,STR0054      ,oFont8 )
	oPrint:Say  (760,1060,STR0052      ,oFont8 )
	//oPrint:Say  (760,1260,STR0053      ,oFont8 )
	oPrint:Say  (760,1260,"Descrição do serviço",oFont8 )
	//oPrint:Say  (760,1560,STR0061      ,oFont8 )
	oPrint:Say  (760,1810,"Despesa    " ,oFont8 )
	oPrint:Say  (760,2110,"A Pagar"      ,oFont8 )
	oPrint:Say  (710,((2300-21)/2),STR0048      ,oFont8 ) //21 = Len de "Extrato de utilizacao"  Calculo para centralizar //"Extrato de utilização"
	oPrint:FillRect({705,100,750,2300},oBrush)
	*/
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
	//³Imprime os dados do cabecalho...               ?
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
	oPrint:Say  (300,105,STR0008                   		,oFont8 ) //"Vencimento"
	oPrint:Say  (345,205,DTOC(aDadosTit[4])             ,oFont10)
	
	oPrint:Say  (300,405,STR0009                     	,oFont8 ) //"Valor R$"
	oPrint:Say  (345,505,AllTrim(Transform(aDadosTit[5],"@E 999,999,999.99")),oFont10)
	
	oPrint:Say  (300,805,STR0010             			,oFont8 ) //"Data de Emissão"
	oPrint:Say  (345,905,DTOC(aDadosTit[3])             ,oFont10)
	
	oPrint:Say  (300,1155,STR0011            			,oFont8 ) //"Nro.do Documento"
	oPrint:Say  (345,1255,aDadosTit[1]                  ,oFont10)
	
	oPrint:Say  (300,1505,STR0012      					,oFont8 ) //"Agência/Código Cedente"
	//oPrint:Say  (345,1555,aDadosBanco[3]+"/"+aDadosBanco[4]+"-"+aDadosBanco[5],oFont10)
	oPrint:Say  (345,1555,aDadosBanco[3]+"/"+alltrim(aDadosBanco[4])+"-"+alltrim(aDadosBanco[5]),oFont10)				&& 05/12/13 - Vitor Sbano
	
	oPrint:Say  (300,1905,STR0013                		,oFont8 ) //"Nosso Numero"
	oPrint:Say  (345,1950,aDadosTit[6]                  ,oFont10)
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Emissao dos dados do sacado.?
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	oPrint:Say  (400,105 ,STR0004             					,oFont8 ) //"Dados do Sacado"
	oPrint:Say  (470,115 ,aDatSacado[1]	,oFont10)                // sacado
	oPrint:Say  (505,115 ,aDatSacado[3]                     	,oFont10)
	oPrint:Say  (540,115 ,aDatSacado[4]                      	,oFont10)
	oPrint:Say  (540,700 ,aDatSacado[5]+"   "+aDatSacado[6]	,oFont10)
	oPrint:Say  (575,115 ,Substr(aDatSacado[7],1,5) + "-" + Substr(aDatSacado[7],6,3) ,oFont10)
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
	//³Em pessoa fisica, imprime os dependentes da familia..|
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
	oPrint:Say  (400,1155 ,STR0005+Iif(BA3->BA3_TIPOUS == '1',(" ("+R240Imp->E1_CODINT+"."+R240Imp->E1_CODEMP+"."+R240Imp->E1_MATRIC+")"),"") ,oFont8 ) //"Usuários"
	nContLn := 455
	For nI := 1 To Len(aDependentes)
		If nI == 1
			oPrint:Say  (nContLn,1165 ,aDependentes[nI,1]+" - "+Alltrim(aDependentes[nI,2])+STR0006		      ,oFont8) //" (Titular)"
		Else
			oPrint:Say  (nContLn,1165 ,aDependentes[nI,1]+" - "+aDependentes[nI,2]			      ,oFont8)
		EndIf
		nContLn+=25
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Emite somente os 5 primeiros dependentes devido ao espaco no boleto.?
		//³Foi utilizado for e estrutura de array para facilitar a customizacao?
		//³para impressao de mais dependentes.								   ?
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If  nI > 9
			Exit
		EndIf
	Next nI
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
	//³Imprime os meses em aberto deste cliente/contrato... ?
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
	oPrint:Say  (400,1905 ,STR0007                  ,oFont8 ) //"Meses em aberto"
	nContLn := 455
	nColuna := 1905
	For nI := 1 To Len(aOpenMonth)
		oPrint:Say  (nContLn,nColuna ,aOPenMonth[nI] ,oFont8)
		nContLn+=25
		
		//Alterna as colunas
		/*If nColuna == 1905
		nColuna := 1955
	ElseIf nColuna == 1955
		nColuna := 1905
	EndIf
	
	If nI > 18
		Exit
	EndIf aberto */
	
	if nI > 10
		Exit
	Endif
Next nI

Return .T.

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa   ?ImpCNAB  ?Autor ?Jean Schulz           ?Data ?12.10.06 ³±?
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao  ?Imprime Boleto / Exportacao CNAB Itau - Caberj.            ³±?
±±ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
/*/

Static Function ImpCNAB(	aCobranca		,nAbatim		,nAcrescim		,oPrint		,;
		aBMP			,aDadosEmp		,aDadosTit		,aDadosBanco,;
		aDatSacado		,aMsgBoleto		,CB_RN_NN		,aOpenMonth	,;
		aDependentes	,aObservacoes	,cCart			,cPrefixo	,;
		cTitulo			,cGrupoEmp 		,cMatric		,lPrima		)
	
	
	Local nI		:= 0	// Contador do laco para impressao de dependentes.
	Local nMsg      := 0    // Contador para as mensagens
	Local cMoeda	:= "9"  // Moeda do boleto.
	Local nTamCorp	:= 1	// Tipo do corpo do extrato 1 = normal 2 = Grande.
	Local nCob		:= 0	// Contador para for do extrato.
	Local cString	:= ""
	Local cNomeArq	:= ""
	Local _cSQLTmp	:= ""
	Local _nSeqCnab := supergetMv("MV_XSEQCNB",.F.,-1)      //Incluído por Roberto Mendes - 27/11/13
	
	if _nSeqCnab == -1
		MsgAlert("ATENÇÃO! CRIAR PARAMETRO NUMERICO MV_XSEQCNB PARA CONTROLE DE SEQUENCIAL DO ARQUIVO CNAB!")
		Return Nil
	EndIf
	
	If lPrima
		//Comentado por Roberto Mendes - 27/11/2013
		//Controle de numeração passar?a ser controlado pelo parâmetro MV_XSEQCNB
		/*
		_cSQLTmp := " SELECT Substr(MAX(E1_YAREXPO),9,8) AS MAXCNAB "
		_cSQLTmp += " FROM "+RetSQLName("SE1")+" SE1 "
		_cSQLTmp += " WHERE E1_FILIAL = '"+xFilial("SE1")+"' "
		_cSQLTmp += " AND E1_YTPEXP = 'B' " //CNAB 112 - ENVIO
		_cSQLTmp += " AND SE1.D_E_L_E_T_ = ' ' "
		PLSQuery(_cSQLTmp,"TRBCNA")
		
		_cSeqNom := DtoS(dDataBase)+StrZero(Val(TRBCNA->MAXCNAB)+1,8)
		
		TRBCNA->(DbCloseArea())
		*/
		
		
		_cSeqNom := DtoS(dDataBase)+StrZero(_nSeqCnab,8)                  //Roberto Mendes - 27/11/2013
		putMV("MV_XSEQCNB",_nSeqCnab+1)                                   //Roberto Mendes - 27/11/2013: parâmetro recebe próxima numeração disponível
	Endif
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
	//³Seta tabelas e indices a serem utilizados...             ?
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
	SEE->(DbSetOrder(1))
	BA0->(DbSetOrder(1))
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
	//³Cria arquivo no Local padrao CNAB...                     ?
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
	If lPrima
		cNomeArq := GETNEWPAR("MV_YDIBOL","interface\exporta\ANLGRAF_INTEGRAL\")+_cSeqNom+".txt"
		
		If !U_Cria_TXT(cNomeArq)
			Return Nil
		Endif
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
		//³Cria o Header do arquivo...                    ?
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
		cString := CNABHEADER(aDadosBanco)
		
		cLin := Space(1)+cEOL
		cCpo := cString
		
		If !(U_GrLinha_TXT(cCpo,cLin))
			MsgAlert("ATENÇÃO! NÃO FOI POSSÍVEL GRAVAR CORRETAMENTE O CABEÇALHO! OPERAÇÃO ABORTADA!")
			Return Nil
		Endif
	Endif
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
	//³Cria registros do tipo 1 / CNAB.               ?
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
	cString := CNABTIPO1(aDadosBanco)
	
	cLin := Space(1)+cEOL
	cCpo := cString
	
	If !(U_GrLinha_TXT(cCpo,cLin))
		MsgAlert("ATENÇÃO! NÃO FOI POSSÍVEL GRAVAR CORRETAMENTE O CABEÇALHO! OPERAÇÃO ABORTADA!")
		Return Nil
	Endif
	
	///CNABTIPO7(aCobranca) //
	CNABTIPO7(aCobranca,aObservacoes,aOpenMonth, aDadosBanco) //Paulo Motta //aberto
	
Return Nil


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ?
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±?
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±?
±±ºPrograma  ³CNABHEADERºAutor  ?Jean Schulz        ?Data ? 11/10/06   º±?
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±?
±±ºDesc.     ³Cria Header para arquivo CNAB Itau.                         º±?
±±?         ?                                                           º±?
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±?
±±ºUso       ?AP                                                         º±?
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±?
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±?
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß?
*/
Static Function CNABHEADER(aDadosBanco)
	Local cString	:= ""
	Local cCodBan	:= aDadosBanco[1]
	Local cAgencia	:= Transform(Val(aDadosBanco[3]),"9999")
	Local cConta	:= StrZero(Val(aDadosBanco[4]),5)
	Local cDigit	:= alltrim(aDadosBanco[5])// Marcela Coimbra
	Local cDiaGer	:= DtoS(dDataBase)
	
	cString := "0" 											 				//001 a 001 - Identificação do Registro
	cString += "1" 											   				//002 a 002 - Identificação do Arquivo Remessa
	cString += "REMESSA" 									   				//003 a 009 - Literal Remessa
	cString += "01" 										   				//010 a 011 - Código de Serviço
	cString += PADR("COBRANCA",15)											//012 a 026 - Literal Serviço
	
	If cEmpAnt == '02' // Marcela Coimbra em 14/07/2015
		
		//	cString += Replicate("0",14)+Alltrim(GetMV("MV_XACESCR"))   			//027 a 046 - Código da Empresa
		
	EndIf
	
	**'17/08/2018 - Marcela Coimbra - Criação de nova conta no bradesco'  **
	//cString += STRZero(val(Alltrim(GetMV("MV_XACESCR"))),20)     			//027 a 046 - Código da Empresa
	cString += STRZero(val(Alltrim(aDadosBanco[6])),20)     			//027 a 046 - Código da Empresa
	cString += SubStr(UPPER(SM0->M0_NOMECOM),1,30)   				//047 a 076 - Nome da Empresa
	//cString += SubStr(Alltrim(UPPER(SM0->M0_NOMECOM)),1,30)   				//047 a 076 - Nome da Empresa
	cString += "237" 														//077 a 079 - Número do Bradesco na Câmara de Compensação
	cString += PADR("BRADESCO",15)											//080 a 094 - Nome do Banco por Extenso
	cString += Substr(cDiaGer,7,2)+Substr(cDiaGer,5,2)+Substr(cDiaGer,3,2) 	//095 a 100 - Data da Gravação do Arquivo
	cString += SPACE(8) 													//101 a 108 - Branco
	cString += "MX" 														//109 a 110 - Identificação do sistema
	// Marcela Coimbra - Sequencial automático -
	// cString += STRZERO(Val(cSeqArq),7)										//111 a 117 - N?Seqüencial de Remessa
	cString += STRZERO(n_SeqCNAB,7)										//111 a 117 - N?Seqüencial de Remessa
	cString += SPACE(277) 													//118 a 394 - Branco
	cString += "000001" 													//395 a 400 - N?Seqüencial do Registro de Um em Um
	
	cSeqArq := Soma1(cSeqArq)
	
Return cString

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ?
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±?
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±?
±±ºPrograma  ³CNABTIPO1 ºAutor  ³Jean Schulz         ?Data ? 11/10/06   º±?
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±?
±±ºDesc.     ³Imprime registro detalhe CNAB Tipo 1                        º±?
±±?         ?                                                           º±?
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±?
±±ºUso       ?Caberj                                                     º±?
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±?
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±?
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß?
*/
Static Function CNABTIPO1(aDadosBanco)
	Local cString	:= ""
	Local cDatEmi	:= DtoS(R240Imp->E1_EMISSAO)
	Local cDatVen	:= DtoS(R240Imp->E1_VENCREA)
	Local cValor	:= StrZero(R240Imp->(SALDO-E1_IRRF-E1_DECRESC)*100,13)
	
	cDatVen	:= Substr(cDatVen,7,2)+Substr(cDatVen,5,2)+Substr(cDatVen,3,2)
	cDatEmi := Substr(cDatEmi,7,2)+Substr(cDatEmi,5,2)+Substr(cDatEmi,3,2)
	
	SA1->(MsSeek(xFilial("SA1")+R240Imp->(E1_CLIENTE+E1_LOJA)))
	
	//Informacoes "amarradas" em codigo foram confirmadas por Sr. Paulo Motta (Caberj)...
	
	cString := "1" 		//001 a 001 - Identificação do Registro
	cString += SPACE(5) //002 a 006 - Agência de Débito (opcional)
	cString += SPACE(1) //007 a 007 - Dígito da Agência de Débito (opcional)
	cString += SPACE(5) //008 a 012 - Razão da Conta Corrente (opcional)
	cString += SPACE(7) //013 a 019 - Conta Corrente (opcional)
	cString += SPACE(1) //020 a 020 - Dígito da Conta Corrente (opcional)
	
	//021 a 037 - Identificação da Empresa Beneficiária no Banco - Zero, Carteira, Agência e Conta
	//Comentado provisóriamente por Roberto Mendes - 27/11/2013
	//Para teste de correção do layout CNAB Bradesco.
	/*
	dbSelectArea("SEE")
	dbSetOrder(1)
	If SEE->(dbSeek(xFilial("SEE")+aDadosBanco[1]+aDadosBanco[3]+aDadosBanco[4]+"001"))
		
		//If Subs(aDadosBanco[1],1,3) == '001' //Banco do Brasil
		//cCart := '18'
		//ElseIf Subs(aDadosBanco[1],1,3) == '104' //CEF
		//cCart := '82'
		//ElseIf Subs(aDadosBanco[1],1,3) == '341' //Itau
		//cCart := '175'
		//ElseIf Subs(aDadosBanco[1],1,3) == '237' //Itau
		//cCart := '175'
		//EndIf
		
		//cString += STRZERO(SEE->EE_CODCART,3)
		cString += STRZERO(val(SEE->EE_CODCART),3)
		
	EndIf
	
	cString += Transform(Val(aDadosBanco[3]),"99999")	//códigos da Agência Beneficiários, sem o dígito
	cString += Transform(Val(aDadosBanco[4]),"9999999")	//Contas Corrente
	cString += Substr(aDadosBanco[5],1,1)				//dígitos da Conta
	
	// Incluído por Rafael Fernandes
	// Fixo temporariamente, pois não existem dados válidos para colocar através da rotina acima.
	//If Alltrim(cEmpAnt) == "01"
	//	cString += "0" 										//Zero
	//	cString += "009"	 //Carteira
	//	cString += "03369"	//códigos da Agência Beneficiários, sem o dígito
	//	cString += "0008895"//Contas Corrente
	//	cString += "1"   	//dígitos da Conta
	//ElseIf Alltrim(cEmpAnt) == "02"
	//	cString += "0" 										//Zero
	//	cString += "009"	 //Carteira
	//	cString += "03369"	//códigos da Agência Beneficiários, sem o dígito
	//	cString += "0008898"//Contas Corrente
	//	cString += "1"   	//dígitos da Conta
	//EndIf
	*/
	//Fim Comentário Roberto Mendes - 27/11/2013
	
	// cString += "00090336900088951"
	//
	cString += cConvenio						&& 03/12/13 - Vitor Sbano	- Cod Convenio - SEE->EE_CODEMP
	//
	
	
	
	//cString += SPACE(25)			//038 a 062 - N?Controle do Participante		--->>>  E1_IDCNAB
	//
	cString += substr(R240Imp->E1_IDCNAB,1,10)+space(15)			//038 a 062 - N?Controle do Participante
	cString += "000" 				   								//063 a 065 - Código do Banco a ser debitado na Câmara de Compensação
	cString += "0" 													//066 a 066 - Campo de Multa
	cString += Replicate("0",4) 									//067 a 070 - Percentual de multa
	
	cNosso := Alltrim(R240Imp->E1_NUMBCO)
	cDigNosso  := u_fDigNosBra(aDadosBanco[7],cNosso)
	
	cString += STRZERO(Val(R240Imp->E1_NUMBCO),11)								//071 a 081 - Identificação do Título no Banco
	cString += cDigNosso 				  										//082 a 082 - Digito de Auto Conferencia do Número Bancário.
	cString += Replicate("0",10)     											//083 a 092 - Desconto Bonificação por dia
	cString += "2"        														//093 a 093 - Condição para Emissão da Papeleta de Cobrança
	cString += "N" 																//094 a 094 - Ident. se emite Boleto para Débito Automático
	cString += SPACE(10) 				   										//095 a 104 - Identificação da Operação do Banco
	cString += SPACE(1) 														//105 a 105 - Indicador Rateio Crédito (opcional)
	cString += SPACE(1) 														//106 a 106 - Endereçamento para Aviso do Débito Automático em Conta Corrente (opcional)
	cString += SPACE(2) 														//107 a 108 - Branco
	cString += "01" 															//109 a 110 - Identificação da ocorrência
	cString += STRZERO(val(R240Imp->E1_NUM),10) 								//111 a 120 - N?do Documento
	cString += cDatVen 															//121 a 126 - Data do Vencimento do Título
	cString += STRZERO((R240Imp->(SALDO-E1_DECRESC) * 100),13)   				//127 a 139 - Valor do Título
	// Marcela Coimbra - 22/04/2014  cString += STRZERO((R240Imp->E1_VALOR * 100),13)							//127 a 139 - Valor do Título
	cString += '000'//SPACE(3)															//140 a 142 - Banco Encarregado da Cobrança
	cString += '00000'//SPACE(5)															//143 a 147 - Agência Depositária
	cString += "01"																//148 a 149 - Espécie de Título
	cString += "N" 																//150 a 150 - Identificação
	cString += cDatEmi 															//151 a 156 - Data da emissão do Título
	cString += '00'//SPACE(2) 														//157 a 158 - 1?instrução
	cString += SPACE(2) 														//159 a 160 - 2?instrução
	cString += Replicate("0",13)												//161 a 173 - Valor a ser cobrado por Dia de Atraso
	cString += cDatVen                    										//174 a 179 - Data Limite P/Concessão de Desconto
	cString += Replicate("0",13) 												//180 a 192 - Valor Desconto
	cString += Replicate("0",13) 												//193 a 205 - Valor do IOF
	cString += Replicate("0",13) 												//206 a 218 - Valor do Abatimento a ser concedido ou cancelado
	cString += Iif(SA1->A1_PESSOA =="F","01","02") 								//219 a 220 - Identificação do Tipo de Inscrição do Pagador
	cString += Replicate("0",14-Len(Alltrim(SA1->A1_CGC)))+Alltrim(SA1->A1_CGC)	//221 a 234 - N?Inscrição do Pagador
	cString += PADR(SA1->A1_NOME,40) 											//235 a 274 - Nome do Pagador
	cString += PADR(SA1->A1_END,40)		 										//275 a 314 - Endereço Completo
	cString += SPACE(12) 														//315 a 326 - 1?Mensagem
	cString += Substr(SA1->A1_CEP,1,5)											//327 a 331 - CEP
	cString += Substr(SA1->A1_CEP,6,3)											//332 a 334 - Sufixo do CEP
	//
	cString += SPACE(60) 														//335 a 394 - Sacador/Avalista ou 2?Mensagem
	cString += cSeqArq            												//395 a 400 - N?Seqüencial do Registro
	
	cSeqArq := Soma1(cSeqArq)
	
Return cString


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ?
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±?
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±?
±±ºPrograma  ³CriaSX1   ºAutor  ?Jean Schulz        ?Data ? 10/10/06   º±?
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±?
±±ºDesc.     ³Cria / atualiza parametros solicitados na geracao do boleto.º±?
±±?         ?                                                           º±?
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±?
±±ºUso       ?Caberj.                                                    º±?
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±?
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±?
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß?
*/
Static Function CriaSX1(cPerg)
	
	PutSx1(cPerg,"01",OemToAnsi("Cliente De")			,"","","mv_ch1","C",06,0,0,"G","","","","","mv_par01","","","","","","","","","","","","","","","","",{},{},{})
	PutSx1(cPerg,"02",OemToAnsi("Loja De")				,"","","mv_ch2","C",02,0,0,"G","","","","","mv_par02","","","","","","","","","","","","","","","","",{},{},{})
	PutSx1(cPerg,"03",OemToAnsi("Cliente Ate")			,"","","mv_ch3","C",06,0,0,"G","","","","","mv_par03","","","","","","","","","","","","","","","","",{},{},{})
	PutSx1(cPerg,"04",OemToAnsi("Lota Ate")				,"","","mv_ch4","C",02,0,0,"G","","","","","mv_par04","","","","","","","","","","","","","","","","",{},{},{})
	PutSx1(cPerg,"05",OemToAnsi("Operadora De")			,"","","mv_ch5","C",04,0,0,"G","","","","","mv_par05","","","","","","","","","","","","","","","","",{},{},{})
	PutSx1(cPerg,"06",OemToAnsi("Operadora Ate")		,"","","mv_ch6","C",04,0,0,"G","","","","","mv_par06","","","","","","","","","","","","","","","","",{},{},{})
	PutSx1(cPerg,"07",OemToAnsi("Empresa De")			,"","","mv_ch7","C",04,0,0,"G","","","","","mv_par07","","","","","","","","","","","","","","","","",{},{},{})
	PutSx1(cPerg,"08",OemToAnsi("Empresa Ate")			,"","","mv_ch8","C",04,0,0,"G","","","","","mv_par08","","","","","","","","","","","","","","","","",{},{},{})
	PutSx1(cPerg,"09",OemToAnsi("Contrato De")			,"","","mv_ch9","C",12,0,0,"G","","","","","mv_par09","","","","","","","","","","","","","","","","",{},{},{})
	PutSx1(cPerg,"10",OemToAnsi("Contrato Ate")			,"","","mv_cha","C",12,0,0,"G","","","","","mv_par10","","","","","","","","","","","","","","","","",{},{},{})
	PutSx1(cPerg,"11",OemToAnsi("SubContrato De")		,"","","mv_chb","C",09,0,0,"G","","","","","mv_par11","","","","","","","","","","","","","","","","",{},{},{})
	PutSx1(cPerg,"12",OemToAnsi("SubContrato Ate")		,"","","mv_chc","C",09,0,0,"G","","","","","mv_par12","","","","","","","","","","","","","","","","",{},{},{})
	PutSx1(cPerg,"13",OemToAnsi("Matricula De?")		,"","","mv_chd","C",06,0,0,"G","","BA1NUS","","","mv_par13","","","","","","","","","","","","","","","","",{},{},{})
	PutSx1(cPerg,"14",OemToAnsi("Matricula Ate")		,"","","mv_che","C",06,0,0,"G","","BA1NUS","","","mv_par14","","","","","","","","","","","","","","","","",{},{},{})
	PutSx1(cPerg,"15",OemToAnsi("Mes Titulo")			,"","","mv_chf","C",02,0,0,"G","","","","","mv_par15","","","","","","","","","","","","","","","","",{},{},{})
	PutSx1(cPerg,"16",OemToAnsi("Ano Titulo")			,"","","mv_chg","C",04,0,0,"G","","","","","mv_par16","","","","","","","","","","","","","","","","",{},{},{})
	PutSx1(cPerg,"17",OemToAnsi("Tipo de Impresso")		,"","","mv_chh","N",01,0,0,"C","","","","","mv_par17","112-CNAB Bradesco","","","","175-Reimpressao","","","999-Analítico","","","","","","","","",{},{},{})
	PutSx1(cPerg,"18",OemToAnsi("Prefixo De")			,"","","mv_chi","C",03,0,0,"G","","","","","mv_par18","","","","","","","","","","","","","","","","",{},{},{})
	PutSx1(cPerg,"19",OemToAnsi("Prefixo Ate")			,"","","mv_chj","C",03,0,0,"G","","","","","mv_par19","","","","","","","","","","","","","","","","",{},{},{})
	PutSx1(cPerg,"20",OemToAnsi("Numero De")			,"","","mv_chk","C",09,0,0,"G","","","","","mv_par20","","","","","","","","","","","","","","","","",{},{},{})
	PutSx1(cPerg,"21",OemToAnsi("Numero Ate")			,"","","mv_chl","C",09,0,0,"G","","","","","mv_par21","","","","","","","","","","","","","","","","",{},{},{})
	PutSx1(cPerg,"22",OemToAnsi("Parcela De")			,"","","mv_chm","C",01,0,0,"G","","","","","mv_par22","","","","","","","","","","","","","","","","",{},{},{})
	PutSx1(cPerg,"23",OemToAnsi("Parcela Ate")			,"","","mv_chn","C",01,0,0,"G","","","","","mv_par23","","","","","","","","","","","","","","","","",{},{},{})
	PutSx1(cPerg,"24",OemToAnsi("Tipo De")				,"","","mv_cho","C",03,0,0,"G","","","","","mv_par24","","","","","","","","","","","","","","","","",{},{},{})
	PutSx1(cPerg,"25",OemToAnsi("Tipo Ate")				,"","","mv_chp","C",03,0,0,"G","","","","","mv_par25","","","","","","","","","","","","","","","","",{},{},{})
	PutSx1(cPerg,"26",OemToAnsi("Data da instrução")	,"","","mv_chq","D",08,0,0,"G","","","","","mv_par26","","","","","","","","","","","","","","","","",{},{},{})
	PutSx1(cPerg,"27",OemToAnsi("Bordero De")			,"","","mv_chr","C",06,0,0,"G","","","","","mv_par27","","","","","","","","","","","","","","","","",{},{},{})
	PutSx1(cPerg,"28",OemToAnsi("Bordero Ate")			,"","","mv_chs","C",06,0,0,"G","","","","","mv_par28","","","","","","","","","","","","","","","","",{},{},{})
	PutSx1(cPerg,"29",OemToAnsi("Boleto Tipo Fatura ?")	,"","","mv_cht","N",01,0,0,"C","","","","","mv_par29","Nao","","","","Sim","","","","","","","","","","","",{},{},{})
	//
	PutSx1(cPerg,"30",OemToAnsi("Banco")				,"","","mv_chu","C",03,0,0,"G","","SA6","","","mv_par30","","","","","","","","","","","","","","","","",{},{},{})
	PutSx1(cPerg,"31",OemToAnsi("Agencia")				,"","","mv_chw","C",05,0,0,"G","",""   ,"","","mv_par31","","","","","","","","","","","","","","","","",{},{},{})
	PutSx1(cPerg,"32",OemToAnsi("Conta")				,"","","mv_chx","C",10,0,0,"G","",""   ,"","","mv_par32","","","","","","","","","","","","","","","","",{},{},{})
	PutSx1(cPerg,"33",OemToAnsi("SubConta")				,"","","mv_chy","C",03,0,0,"G","",""   ,"","","mv_par33","","","","","","","","","","","","","","","","",{},{},{})
	
Return



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ?
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±?
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±?
±±ºPrograma  ³CNABTRAILLERºAutor  ³Jean Schulz       ?Data ? 12/10/06   º±?
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±?
±±ºDesc.     ³Cria registro Trailler para arquivo CNAB Itau - Caberj.     º±?
±±?         ?                                                           º±?
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±?
±±ºUso       ?Caberj.                                                    º±?
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±?
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±?
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß?
*/
Static Function CNABTRAILLER()
	Local cString := ""
	
	cString := "9"+Replicate(" ",393)+cSeqArq
	
Return cString



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ?
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±?
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±?
±±ºPrograma  ³CNABTIPO7   ºAutor  ³Jean Schulz       ?Data ? 13/10/06   º±?
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±?
±±ºDesc.     ³Imprime detalhamento de fatura CABERJ - Itau.               º±?
±±?         ?                                                           º±?
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±?
±±ºUso       ?Caberj.                                                    º±?
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±?
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±?
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß?
*/
Static Function CNABTIPO7(aCobranca,aObservacoes,aOpenMonth, aDadosBanco)  //aberto
	
	Local nAbcnt := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS
	
	Local cCodUsu	:= ""
	Local cDatPro	:= ""
	Local cNomUsu	:= ""
	Local cDesPro	:= ""
	Local cVlrBPF	:= ""
	Local cVlrMen	:= ""
	Local cVlrTPF	:= ""
	Local nCont		:= 0
	Local nCont2	:= 0
	Local cString	:= ""
	Local aTexto	:= {}
	Local aTextoCmp	:= {} // MBC Projeto Extrato
	Local aMensa	:= {}
	Local nVlrTPF	:= 0
	Local nPos		:= 0
	Local nLinha	:= 6
	Local nTexto	:= 0
	Local lPrima	:= .T.
	Local nVlrMen	:= 0
	Local nVlrOut	:= 0
	Local cTipLanAn	:= ""
	Local lExt112	:= .F.
	Local nVlrTmp	:= 0
	
	Local aArSE1	:= {}
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//?Definir matriz com espacos em branco e numero de linhas...               ?
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	For nCont := 1 to 57
		//aadd(aTexto,{Space(100),nCont})				&& BOX_29/11
		aadd(aTexto,{Space(100),nCont," "})				&& BOX
		aadd(aTextoCmp,{Space(100),nCont,.F.})
	Next
	
	BFQ->(DbSetOrder(1))
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//?Imprimir neste laco somente quando for co-participacao e afins...        ?// Outros (parcelamento etc) Motta
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	For nCont := 1 to Len(aCobranca)
		
		//Nova implementacao - Inverter sinal caso lancamento seja de credito...
		If !Empty(aCobranca[nCont,02]) //.or. n_QtdItens >= 19   //Legenda: se for co-participacao...
			
			If !Empty(Substr(aCobranca[nCont,09],5,4))
				
				cCodUsu	:= Substr(aCobranca[nCont,09],1,4)+"."+Substr(aCobranca[nCont,09],5,4)+"."+Substr(aCobranca[nCont,09],9,6)+"."+Substr(aCobranca[nCont,09],15,2)+"-"+Substr(aCobranca[nCont,09],17,1)
				
			Else
				
				cCodUsu	:= space(21)
				
			EndIf
			
			//	cCodUsu	:= Substr(aCobranca[nCont,09],1,4)+"."+Substr(aCobranca[nCont,09],5,4)+"."+Substr(aCobranca[nCont,09],9,6)+"."+Substr(aCobranca[nCont,09],15,2)+"-"+Substr(aCobranca[nCont,09],17,1)
			cDatPro	:= DtoC(StoD(aCobranca[nCont,03]))
			//cNomUsu	:= Substr(aCobranca[nCont,01],1,25)
			cNomUsu	:= Substr(aCobranca[nCont,02],1,25)
			cDesPro	:= Substr(aCobranca[nCont,06],1,24)
			cVlrBPF	:= Transform(aCobranca[nCont,11],"@E 99,999.99")
			cVlrTPF	:= Transform(aCobranca[nCont,07],"@E 99,999.99")
			
			nVlrTPF += aCobranca[nCont,07]
			
			If !lExt112
				
				//aTexto[nLinha,1] :=  Substr(cCodUsu+Space(1)+cDatPro+Space(1)+cNomUsu+Space(1)+cDesPro+Space(1)+cVlrBPF+Space(1)+cVlrTPF,1,100)
				If n_QtdItens < 19 .and. aCobranca[nCont, 13] == '1'
					
					aTexto[nLinha,1] :=  Substr(cCodUsu+Space(1)+cDatPro+Space(1)+cNomUsu+Space(1)+cDesPro+Space(1)+cVlrBPF+cVlrTPF,1,100)
					aTexto[nLinha,3] :=  "1"					&& BOX
					aTextoCmp[nLinha,1] :=  Substr(cCodUsu+Space(1)+cDatPro+Space(1)+cNomUsu+Space(1)+cDesPro+Space(1)+cVlrBPF+cVlrTPF,1,100)
					aTextoCmp[nLinha,3] :=  .T.
					nLinha++
					
				ElseIf lDetMens  .and. aCobranca[nCont, 13] == '1'
					
					lDetMens := .F.
					
					aTexto[nLinha,1]    := "O detalhamento da coparticipacao sera informado no extrato de utilizacao enviado pelos correios."
					aTexto[nLinha,3]    :=  "1"					&& BOX
					aTextoCmp[nLinha,1] :=  Substr(cCodUsu+Space(1)+cDatPro+Space(1)+cNomUsu+Space(1)+cDesPro+Space(1)+cVlrBPF+cVlrTPF,1,100)
					aTextoCmp[nLinha,3] :=  .T.
					nLinha++
					
					aTexto[nLinha,1]    := "O extrato tambem podera ser obtido atraves do nosso site na area restrita associado."
					aTexto[nLinha,3]    :=  "1"					&& BOX
					aTextoCmp[nLinha,1] :=  Substr(cCodUsu+Space(1)+cDatPro+Space(1)+cNomUsu+Space(1)+cDesPro+Space(1)+cVlrBPF+cVlrTPF,1,100)
					aTextoCmp[nLinha,3] :=  .T.
					nLinha++
					
					aArSE1 := SE1->(GetArea())
					SE1->(DbSetOrder(1))
					SE1->(MsSeek(xFilial("SE1")+R240Imp->(E1_PREFIXO+E1_NUM+E1_PARCELA+E1_TIPO)))
					// SE1->(MsSeek(xFilial("SE1")+R240Imp->(E1_PREFIXO+SUBSTR(E1_NUM,1,6)+E1_PARCELA+E1_TIPO)))
					If SE1->E1_YEXANLT <> "1"
						SE1->(RecLock("SE1",.F.))
						SE1->E1_YEXANLT := "1"
						SE1->(MsUnlock())
					Endif
					
					RestArea(aArSE1)
					
					//exit
					
				EndIf
				/*
				If nLinha > 24 .And. !lExt112
					lExt112 := .T.
					
					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//?Marcar caso estoure o limite de linhas no boleto 112...                  ?
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					aArSE1 := SE1->(GetArea())
					SE1->(DbSetOrder(1))
					SE1->(MsSeek(xFilial("SE1")+R240Imp->(E1_PREFIXO+E1_NUM+E1_PARCELA+E1_TIPO)))
					//    SE1->(MsSeek(xFilial("SE1")+R240Imp->(E1_PREFIXO+SUBSTR(E1_NUM,1,6)+E1_PARCELA+E1_TIPO)))
					If SE1->E1_YEXANLT <> "1"
						SE1->(RecLock("SE1",.F.))
						SE1->E1_YEXANLT := "1"
						SE1->(MsUnlock())
					Endif
					
					RestArea(aArSE1)
				Endif
				*/
			Endif
			
			If aCobranca[nCont,5] <> '199'
				If aCobranca[nCont,13] == "1"  // Nivel Familia
					
					nPos := Ascan( aMensa, { |x| x[6] == aCobranca[nCont,09] } )
					If nPos = 0
						aadd(aMensa,{aCobranca[nCont,09],"",aCobranca[nCont,01],0,aCobranca[nCont,07], aCobranca[nCont,09]})
					Else
						aMensa[nPos,05] += aCobranca[nCont,07]
					Endif
					
				Else
					
					If aCobranca[nCont,13] == "1" // nivel familia
						
						//	nPos := Ascan( aMensa, { |x| x[6] == aCobranca[nCont,09] } )
						If Len( aMensa ) == 0
							aadd(aMensa,{aCobranca[nCont,09],"",aCobranca[nCont,01],0,aCobranca[nCont,07], aCobranca[nCont,09]})
						Else
							aMensa[1,05] += aCobranca[nCont,07]
						Endif
						
					Else
						
						nPos := Ascan( aMensa, { |x| x[6] == aCobranca[nCont,09] } )
						If nPos == 0
							aadd(aMensa,{aCobranca[nCont,09],"EMP",aCobranca[nCont,01],0,aCobranca[nCont,07], aCobranca[nCont,09]})
						Else
							aMensa[nPos,05] += aCobranca[nCont,07]
						Endif
						
					EndIf
					
				EndIf
				
			EndIf
		Else //Legenda: se for mensalidade...
			
			
			//Nova implementacao - Inserir linhas para outros debitos/creditos...
			If aCobranca[nCont,05] $ PLSRETLADC()
				
				//cCodUsu	:= Substr(aCobranca[nCont,09],1,4)+"."+Substr(aCobranca[nCont,09],5,4)+"."+Substr(aCobranca[nCont,09],9,6)+"."+Substr(aCobranca[nCont,09],15,2)+"-"+Substr(aCobranca[nCont,09],17,1)
				
				If !Empty(Substr(aCobranca[nCont,09],5,4))
					
					cCodUsu	:= Substr(aCobranca[nCont,09],1,4)+"."+Substr(aCobranca[nCont,09],5,4)+"."+Substr(aCobranca[nCont,09],9,6)+"."+Substr(aCobranca[nCont,09],15,2)+"-"+Substr(aCobranca[nCont,09],17,1)
					
				Else
					
					cCodUsu	:= space(21)
					
				EndIf
				cDatPro	:= Space(08)
				cNomUsu	:= Substr(aCobranca[nCont,01],1,25)
				cDesPro	:= Substr(aCobranca[nCont,06],1,24)
				cVlrBPF	:= Space(09)
				cVlrTPF	:= Transform(aCobranca[nCont,07],"@E 99,999.99")
				
				If ! lExt112
					//aTexto[nLinha,1] :=  Substr(cCodUsu+Space(1)+cDatPro+Space(1)+cNomUsu+Space(1)+cDesPro+Space(1)+cVlrBPF+Space(1)+cVlrTPF,1,100)
					aTexto[nLinha,1] :=  Substr(cCodUsu+Space(1)+cDatPro+Space(1)+cNomUsu+Space(1)+cDesPro+Space(1)+cVlrBPF+cVlrTPF,1,100)
					
					aTexto[nLinha,3] :=  "1"
					aTextoCmp[nLinha,1] :=  Substr(cCodUsu+Space(1)+cDatPro+Space(1)+cNomUsu+Space(1)+cDesPro+Space(1)+cVlrBPF+cVlrTPF,1,100)
					nLinha++
					
					If nLinha > 24 .And. !lExt112
						
						lExt112 := .T.
						
						//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
						//?Marcar caso estoure o limite de linhas no boleto 112...                  ?
						//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
						aArSE1 := SE1->(GetArea())
						SE1->(DbSetOrder(1))
						//SE1->(MsSeek(xFilial("SE1")+R240Imp->(E1_PREFIXO+E1_NUM+E1_PARCELA+E1_TIPO)))
						SE1->(MsSeek(xFilial("SE1")+R240Imp->(E1_PREFIXO+E1_NUM+E1_PARCELA+E1_TIPO)))
						If SE1->E1_YEXANLT <> "1"
							SE1->(RecLock("SE1",.F.))
							SE1->E1_YEXANLT := "1"
							SE1->(MsUnlock())
						Endif
						
						RestArea(aArSE1)
					Endif
					
				Endif
				
			Endif
			//Fim - nova implementacao / Debitos/Creditos no corpo do 112
			
			cTipLanAn := Posicione("BFQ",1,xFilial("BFQ")+PLSINTPAD()+aCobranca[nCont,5],"BFQ_YTPANL")
			
			If cTipLanAn == "M"
				nVlrMen += Iif(aCobranca[nCont,12]=="1",(1),(-1))*aCobranca[nCont,07]
				
			ElseIf cTipLanAn == "C"
				nVlrTPF += Iif(aCobranca[nCont,12]=="1",(1),(-1))*aCobranca[nCont,07]
				
			Else
				nVlrOut += Iif(aCobranca[nCont,12]=="1",(1),(-1))*aCobranca[nCont,07]
				
			Endif
			If aCobranca[nCont,5] <> '199'
				
				//Ajuste: somar conforme definicao do tipo de lancamento.
				If !lIntegral      // mbc
					
					nPos := Ascan( aMensa, { |x| x[1] == aCobranca[nCont,09] } )
					
					nVlrTmp := Iif(aCobranca[nCont,12]=="1",(1),(-1))*aCobranca[nCont,07]
					
					If nPos = 0
						aadd(aMensa,{	aCobranca[nCont,09],;
							"",;
							aCobranca[nCont,01],;
							Iif(cTipLanAn <> "C",nVlrTmp,0),;
							Iif(cTipLanAn == "C",nVlrTmp,0),;
							aCobranca[nCont,09]})
					Else
						aMensa[nPos,Iif(cTipLanAn <> "C",04,05)] += nVlrTmp
					Endif
					
				Else      // ?integral
					
					If aCobranca[nCont,13] == "1" // nivel familia
						nPos := Ascan( aMensa, { |x| x[6] == aCobranca[nCont,09] } )
						
						nVlrTmp := Iif(aCobranca[nCont,12]=="1",(1),(-1))*aCobranca[nCont,07]
						
						If nPos == 0 .and. aCobranca[nCont,09] <> 'COPART'
							aadd(aMensa,{	iif( aCobranca[nCont,09] == '1',aCobranca[nCont,05], aCobranca[nCont,06]) ,;
								"" ,;
								aCobranca[nCont,01] ,;
								Iif(cTipLanAn <> "C",nVlrTmp,0) ,;
								Iif(cTipLanAn == "C",nVlrTmp,0) ,;
								aCobranca[nCont,09] } )
						Else
							aMensa[nPos,Iif(cTipLanAn <> "C",04,05)] += nVlrTmp
						Endif
						
					Else //nivel empresa
						
						nPos := Ascan( aMensa, { |x| x[1] == aCobranca[nCont,05] } )
						
						nVlrTmp := Iif(aCobranca[nCont,12]=="1",(1),(-1))*aCobranca[nCont,07]
						
						If nPos = 0
							aadd(aMensa,{	iif( aCobranca[nCont,09] == '1',aCobranca[nCont,05], aCobranca[nCont,06]) ,;
								"EMP" ,;
								aCobranca[nCont,01] ,;
								Iif(cTipLanAn <> "C",nVlrTmp,0) ,;
								Iif(cTipLanAn == "C",nVlrTmp,0) ,;
								aCobranca[nCont,09] } )
						Else
							aMensa[nPos,Iif(cTipLanAn <> "C",04,05)] += nVlrTmp
						Endif
						
						
					EndIf
					
					
				EndIf
				
			EndIf
			//Fim da nova implementacao - Inverter sinal caso lancamento seja de credito...
			
		Endif
		
	Next
	
	nEntrou := 0
	/*     mbc
	If nLinha > 24
		
		For n_Msg := 1 to Len ( aTexto )
			
			If aTextoCmp[ n_Msg ][ 3 ]
				
				aTexto[ n_Msg ][1] := space(100)
				nEntrou++
				
			EndIf
			
		Next
		
		aTexto[24,1] :=  GetNewPar("MV_YMSGAN", 'M E N S A G E M ')
		
	EndIf
	*/
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//?Finalizar matriz aTexto com valores de mensalidade...                    ?
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	nLinha := 41
	lExt112 := .F.
	For nCont := 1 to Len(aMensa)
		
		If aMensa[nCont][2]  == ""
			
			If !lExt112
				
				If aMensa[1,6] == '1'
					
					cCodUsu := Substr(aMensa[nCont,1],1,4)+"."+Substr(aMensa[nCont,1],5,4)+"."+Substr(aMensa[nCont,1],9,6)+"."+Substr(aMensa[nCont,1],15,2)+"-"+Substr(aMensa[nCont,1],17,1)
					cNomUsu := Substr(aMensa[nCont,3],1,38)
					
				Else
					
					cCodUsu := aMensa[nCont,1]//+"."+Substr(aMensa[nCont,1],5,4)+"."+Substr(aMensa[nCont,1],9,6)+"."+Substr(aMensa[nCont,1],15,2)+"-"+Substr(aMensa[nCont,1],17,1)
					cNomUsu := Substr(aMensa[nCont,3],1,38)
					
				EndIf
				
				
				//Jean - Alterado conforme questionamento Paulo Motta.
				//Segundo argumentacao, o valor deveria ser mensalidade e valor da copart.
				cVlrMen := Transform(aMensa[nCont,04],"@E 9,999,999.99")
				cVlrTPF := Transform(aMensa[nCont,05],"@E 9,999,999.99")
				
				aTexto[nLinha,1] := Substr(cCodUsu+Space(1)+cNomUsu+Space(1)+cVlrMen+Space(1)+cVlrTPF,1,100)
				aTexto[nLinha,1] += Space(100-Len(aTexto[nLinha,1]))
				aTexto[nLinha,3] :=  "4"                  			&& BOX
				nLinha++
				
				If nLinha > 55 .And. !lExt112
					MsgAlert("Impossivel inserir mais linhas neste boleto! Enviar via relatorio analítico!","Atenção")
					lExt112 := .T.
				Endif
				
			Endif
			
		Else
			
			aTexto[nLinha,1] := substr(aMensa[nCont][1], 1, 30) + Transform(aMensa[nCont,04],"@E 9,999,999.99")
			aTexto[nLinha,3] :=  "4"
			nLinha++
			
		EndIf
	Next
	
	If type("aMensa[1][2]") <>  'U' .and. 	aMensa[1][2] <> ""
		
		aTexto[nLinha,1] := "Outros" + Transform(nVlrOut,"@E 9,999,999.99")
		aTexto[nLinha,3] :=  "4"
		nLinha++
		
	EndIf
	
	
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//?Acertos gerais nas linhas a serem impressas                              ?
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	
	aTexto[1,1]  := Space(74)+MesExt(R240Imp->E1_MESBASE)+ "    "+R240Imp->E1_ANOBASE
	aTexto[1,1]  += Space(100-Len(aTexto[1,1]))
	aTexto[1,3]  := "0"// D marcela 11/02/16
	
	aTexto[37,1] := space(4) + Transform(nVlrMen,"@E 9,999,999.99")+Space(15)+Transform(nVlrTPF,"@E 9,999,999.99")+Space(10)+Transform(nVlrOut,"@E 9,999,999.99")+Space(11)+Transform(nVlrMen+nVlrTPF+nVlrOut,"@E 9,999,999.99")
	aTexto[37,1] += Space(100-Len(aTexto[37,1]))
	aTexto[37,3]  := "3"
	
	If Len(aMensa) > 0
		
		If aMensa[1,6] == '1'
			
			aTexto[57,1] := Substr(aMensa[1,1],1,4)+"."+Substr(aMensa[1,1],5,4)+"."+Substr(aMensa[1,1],9,6)+"."+Substr(aMensa[1,1],15,2)+"-"+Substr(aMensa[1,1],17,1)
			
		Else
			
			aTexto[57,1] := aMensa[1,3]
			
		EndIf
		aTexto[57,3] := "5"
		aTexto[1,3]  := "0"
		
	EndIf
	
	aTexto[57,1] := substr(aTexto[57,1], 1, 26) + Space(3)+Substr(R240Imp->E1_NUMBCO,1,15)+Space(6)+DtoC(R240Imp->E1_VENCREA)+Space(15)+Transform(R240Imp->(SALDO-E1_IRRF-E1_DECRESC),"@E 9,999,999.99")
	// aTexto[57,1] := substr(aTexto[57,1], 1, 26) + Space(3)+Substr(R240Imp->E1_NUMBCO,1,8)+Space(13)+DtoC(R240Imp->E1_VENCREA)+Space(15)+Transform(R240Imp->(SALDO-E1_IRRF),"@E 9,999,999.99") Marcela Coimbra em 20/06/2016 Escrever nosso numero completo no rodape do boleto
	aTexto[57,1] += Space(100-Len(aTexto[57,1]))
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//?Obter linhas livres no boleto X faixa repassada para msg reajuste...     ?
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	nCont := 41
	While nCont <= 55 //Linhas 41 X 55 - Faixa de usuarios (Mensalidade)
		If Empty(Alltrim(aTexto[nCont,1]))
			Exit
		Endif
		nCont++
	Enddo
	
	//----------------------------------------------
	//Inicio - Angelo Henrique - Data:18/08/2015
	//----------------------------------------------
	//Chamado 19151 - Solicitação referente a RCA
	//Solicitado por Alan Jefferson - GEFIN
	//----------------------------------------------
	If R240Imp->E1_SALDO != R240Imp->E1_VALOR
		
		_cQuery  := "SELECT E5_DOCUMEN, E5_PREFIXO, E5_NUMERO, E5_PARCELA, E5_CLIFOR, E5_LOJA "
		_cQuery  += "FROM " + RETSQLNAME("SE5") 	+ " SE5 "
		_cQuery  += "WHERE SE5.E5_FILIAL = '"		+ xFilial("SE5")			+ "' "
		_cQuery  += "AND SE5.E5_PREFIXO = '" 		+ R240Imp->E1_PREFIXO 	+ "' "
		_cQuery  += "AND SE5.E5_NUMERO = '" 		+ R240Imp->E1_NUM 		+ "' "
		_cQuery  += "AND SE5.E5_PARCELA = '" 		+ R240Imp->E1_PARCELA 	+ "' "
		_cQuery  += "AND SE5.E5_CLIFOR = '" 		+ R240Imp->E1_CLIENTE 	+ "' "
		_cQuery  += "AND SE5.E5_LOJA = '" 			+ R240Imp->E1_LOJA 		+ "' "
		_cQuery  += "AND SE5.E5_TIPODOC = 'CP' "
		_cQuery  += "AND SUBSTR(SE5.E5_DOCUMEN,1,3) = 'RAC' "
		_cQuery  += "AND SE5.D_E_L_E_T_ = ' ' "
		
		*'-----------------------------'*
		*'Valida se o Alias esta em uso'*
		*'-----------------------------'*
		If Select(_cAliQry) > 0
			dbSelectArea(_cAliQry)
			(_cAliQry)->(dbCloseArea())
		EndIf
		
		dbUseArea(.T., "TOPCONN", TcGenQry(,,_cQuery), _cAliQry, .T., .F.)
		
		DbSelectArea(_cAliQry)
		
		If !((_cAliQry)->(EOF()))
			
			cMsg1 := "Prezado(a) Associado(a), informamos que houve uma compensação de créditos na sua cobrança, sendo enviado apenas o saldo do título."
			
			_aJustMsg := JustificaTxt(cMsg1 , 100)
			
			For _ni := 1 To Len(_aJustMsg)
				
				aAdd(aObservacoes,_aJustMsg[_ni])
				
			Next _ni
			
		EndIf
		
		*'-----------------------------'*
		*'Valida se o Alias esta em uso'*
		*'-----------------------------'*
		If Select(_cAliQry) > 0
			dbSelectArea(_cAliQry)
			(_cAliQry)->(dbCloseArea())
		EndIf
		
	EndIf
	
	//----------------------------------------------
	//  Fim  - Angelo Henrique - Data:18/08/2015
	//----------------------------------------------
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//?Inserir mensagem de reajuste no boleto a ser impresso...                 ?
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	
	//nCont := 32 -- Angelo Henrique - Data:18/08/2015 - Mudado para poder ter 3 linhas de informações.
	nCont := 31
	
	For nCont2 := 1 to Len(aObservacoes)  // Paulo Motta
		aTexto[nCont,1] := aObservacoes[nCont2]
		aTexto[nCont,1] += Space(100-Len(aTexto[nCont,1]))
		**'Marcela Coimbra - Alterado para exibir as mensagens no boleto bradesco'**
		//  aTexto[nCont,3] := "G"
		aTexto[nCont,3] := "2"
		If nCont >= 33  // - Faixa de usuarios (Mensalidade)
			nCont2 := Len(aObservacoes)
		Endif
		
		nCont++
		
	Next
	
	If nCont < 33 .and. GetNewPar( "MV_YMESAB", 1 ) == 0
		cMsgAbt := ""
		For nAbcnt := 1 to Len(aOpenMonth)
			If nAbcnt == 1
				cMsgAbt := "MES(ES) EM ABERTO : "
			End if
			cMsgAbt += AllTrim(aOPenMonth[nAbcnt]) + " "
		Next nAbcnt
		if cMsgAbt <> ""
			aTexto[nCont,1] := cMsgAbt+Space(100-Len(cMsgAbt))
			**'In?- Marcela Coimbra - 16/05/2014 - Mudança no quadrante dos meses em aberto'**
			aTexto[nCont,3] := "2"					&& BOX
			**'Fim - Marcela Coimbra - 16/05/2014 - Mudança no quadrante dos meses em aberto'**
			nCont++
			
		end if
	EndIf
	
	
	/*BEGINDOC
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
	//³Mensagem de títulos em aberto - em teste ABERTO?
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
ENDDOC*/

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//?Nova implementacao: validacao do boleto gerado X base de dados. Soh      ?
//?exportar caso nao haja inconsistencia...                                 ?
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If len(aCobranca) > 0 .and. nVlrMen+nVlrTPF+nVlrOut <> R240Imp->SALDO .and. R240Imp->E1_TIPO <> 'FT'
	Aadd(aCritica,{"Valor do Saldo do título não confere com o total do analítico! Arquivo não devera ser enviado!",R240Imp->(E1_PREFIXO+E1_NUM+E1_PARCELA+E1_TIPO)})
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//?Gravar registro como enviado CNAB, e amarrar o nome do arquivo...        ?
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
SE1->(MsSeek(xFilial("SE1")+R240Imp->(E1_PREFIXO+E1_NUM+E1_PARCELA+E1_TIPO)))
If GetNewPar("MV_YFLGBL","N") = "S"
	U_fLogBol() //Edilson Leal 24/01/08 : Log de Impressao
Endif
SE1->(RecLock("SE1",.F.))
SE1->E1_YTPEXP	:= "B" //CNAB 112 - ENVIO - TABELA K1
SE1->E1_YTPEDSC	:= Posicione("SX5", 1, xFilial("SX5")+"K1"+"B", "X5_DESCRI")
//mbctirar SE1->E1_YAREXPO	:= _cSeqNom
SE1->(MsUnlock())

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//?Gerar linhas ja tratadas no .TXT                                         ?
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
nTexto := 1
For nCont := 1 to Len(aTexto)
	
	If !Empty(aTexto[nCont,1])
		If nTexto == 1
			
			If lPrima
				lPrima := .F.
			Else
				
				cString += cSeqArq
				cSeqArq := Soma1(cSeqArq)
				
				cLin := Space(1)+cEOL
				cCpo := cString
				
				If !(U_GrLinha_TXT(cCpo,cLin))
					MsgAlert("ATENÇÃO! NÃO FOI POSSÍVEL GRAVAR CORRETAMENTE A MENSAGEM! OPERAÇÃO ABORTADA!")
					Return Nil
				Endif
			Endif
			
			cString := "2" //Tipo do Registro
			//cString += "KAZ" //Flash
			
		Endif
		
		//cString += StrZero(aTexto[nCont,2],2) //Numero da linha
		
		//cString += PADR(Alltrim(aTexto[nCont,1]),320) //Mensagem 1, 2, 3 e 4			&& 29/11 - Vitor
		//
		cString += PADR(Alltrim(aTexto[nCont,1]),319) //Mensagem 1, 2, 3 e 4
		cString += aTexto[nCont,3]									&& BOX
		cString += Replicate("0",6) //Data limite para concessão de Desconto 2
		cString += Replicate("0",13) //Valor do Desconto
		cString += Replicate("0",6) //Data limite para concessão de Desconto 3
		cString += Replicate("0",13) //Valor do Desconto
		//cString += Space(28) //Brancos
		cString += "FILLER "
		//Comentado Roberto Mendes
		/*
		dbSelectArea("SEE")
		dbSetOrder(1)
		If SEE->(dbSeek(xFilial("SEE")+aDadosBanco[1]+aDadosBanco[3]+aDadosBanco[4]+"001"))
			cString += STRZERO(Val(SEE->EE_CODCART),3)
		EndIf
		
		cString += Transform(Val(aDadosBanco[3]),"99999")	//códigos da Agência Beneficiários, sem o dígito
		cString += Transform(Val(aDadosBanco[4]),"9999999")	//Contas Corrente
		cString += Substr(aDadosBanco[5],1,1)				//dígitos da Conta
		*/
		cString +=substr(cConvenio, 2, 16)//"0090336900088951"
		//Fim Comnetário Roberto Mendes
		
		// Incluído por Rafael Fernandes
		// Fixo temporariamente, pois não existem dados válidos para colocar através da rotina acima.
		//If Alltrim(cEmpAnt) == "01"
		//	cString += "009"	 //Carteira
		//	cString += "03369"	//códigos da Agência Beneficiários, sem o dígito
		//	cString += "0008895"//Contas Corrente
		//	cString += "1"   	//dígitos da Conta
		//ElseIf Alltrim(cEmpAnt) == "02"
		//	cString += "009"	 //Carteira
		//	cString += "03369"	//códigos da Agência Beneficiários, sem o dígito
		//	cString += "0008898"//Contas Corrente
		//	cString += "1"   	//dígitos da Conta
		//EndIf
		
		cNosso := Alltrim(R240Imp->E1_NUMBCO)
		cDigNosso  := u_fDigNosBra(aDadosBanco[7],cNosso)
		
		cString += StrZero(Val(cNosso),11)
		cString += cDigNosso
		
		//If nTexto <= 2
		//	nTexto++
		//Else
		nTexto := 1
	Endif
	
Next

cString += cSeqArq
cSeqArq := Soma1(cSeqArq)

cLin := Space(1)+cEOL
cCpo := cString

If !(U_GrLinha_TXT(cCpo,cLin))
	MsgAlert("ATENÇÃO! NÃO FOI POSSÍVEL GRAVAR CORRETAMENTE A MENSAGEM! OPERAÇÃO ABORTADA!")
Return Nil
Endif

Return Nil



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ?
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±?
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±?
±±ºPrograma  ³MesExten  ºAutor  ³Jean Schulz         ?Data ? 13/10/06   º±?
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±?
±±ºDesc.     ³Transforma o mes repassado por parametro para extenso...    º±?
±±?         ?                                                           º±?
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±?
±±ºUso       ?AP                                                         º±?
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±?
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±?
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß?
*/
Static Function MesExt(cMes)
	Local cString := Space(11)
	
	Do case
	Case cMes == "01"
		cString := "Janeiro    "
	Case cMes == "02"
		cString := "Fevereiro  "
	Case cMes == "03"
		cString := "Marco      "
	Case cMes == "04"
		cString := "Abril      "
	Case cMes == "05"
		cString := "Maio       "
	Case cMes == "06"
		cString := "Junho      "
	Case cMes == "07"
		cString := "Julho      "
	Case cMes == "08"
		cString := "Agosto     "
	Case cMes == "09"
		cString := "Setembro   "
	Case cMes == "10"
		cString := "Outubro    "
	Case cMes == "11"
		cString := "Novembro   "
	Case cMes == "12"
		cString := "Dezembro   "
	EndCase
	
Return cString


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ?
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±?
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±?
±±ºPrograma  ³UNIFUNC   ºAutor  ?Jean Schulz        ?Data ? 09/10/05   º±?
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±?
±±ºDesc.     ?Funcao para inclusao da mensagem do boleto de reajuste.    º±?
±±?         ?Rotina reescrita em junho/09                          	  º±?
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±?
±±ºUso       ?SIGAPLS                                                    º±?
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±?
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±?
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß?
*/
// Em uso no fonte BOL_ITAU

//User Function NMenReaj(aProdutos,cTipPes, c_AnoMes, cPerRea, cIndRea)
//Local aMsg		:= {}
//Local nCont		:= 0
//Local cMsgComp	:= GetNewPar("MV_PLYMSRE","Comunicação de reajuste ser?protocolada na ANS at?trinta dias após aplicação, cfme RN 99/05.")
//Local cMsg     := ""


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Legenda para matriz de produtos.	         						?
//? - Codigo do Produto									  				?
//? - Nome do Produto										  				?
//? - Nro do Produto na ANS								  				?
//? - Percentual reajustado								  				?
//? - Nro oficio ANS que liberou o reajuste.						?
//? - Nro do contrato ou apolice (nro subcontrato - PJ)			?
//? - Plano coletivo com (1) ou sem (0) patrocinador - PJ)		?
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

// Obter mensagem do plano

If  cEmpAnt == "01" // Caberj
	SZI->(DbSetOrder(1))
	SZI->(MsSeek(xFilial("SZI")+BA3->BA3_CODINT+BA3->BA3_CODEMP))
	While ! SZI->(Eof())
		
		If c_AnoMes >= SZI->ZI_REFDE .AND. c_AnoMes <= SZI->ZI_REFATE .AND. cIndRea == SZI->ZI_INDREA
			If BA3->BA3_CODPLA >= SZI->ZI_PLADE .AND. BA3->BA3_CODPLA <= SZI->ZI_PLAATE .AND. cIndRea == SZI->ZI_INDREA
				Exit
			Endif
		Endif
		
		**'-Marcela Coimbra - 05/07/2010 -----------------'**
		**'-Inclusao de dbSkip para tratar loop infinito--'**
		**'-Inicio ---------------------------------------'**
		
		SZI->( dbSkip() )
		
		**'-Marcela Coimbra - 05/07/2010 -----------------'**
		**'-Fim ------------------------------------------'**
		
	Enddo
	
	If SZI->ZI_NPARCE > 1
		cNumProc := Str((Val(BA3->BA3_MESREA) + 1) - Val(BA3->BA3_YMESRE))
	Endif
	
	If !Empty(SZI->ZI_MENSAGE)
		cMsg := &(SZI->ZI_MENSAGE)
		cMsg := strTran( cMsg, 'XXX', cPerRea )
	Endif
	nCont := 0
	
	aMsg := justificatxt(cMsg, 92 )
	
	/*
	
	While (Len(Trim(cMsg)) > 0)
		Aadd(aMsg,{Substr(cMsg,1,92),"","","","","",""}) //Motta jun/2009
		nCont++
		cMsg := Trim(Substr(cMsg,93,100))
		
	Enddo  */
	
Endif

Return aMsg


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ?
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±?
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±?
±±ºPrograma  ³PercReajuste ºAutor  ³Jean Schulz      ?Data ? 02/12/05   º±?
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±?
±±ºDesc.     ³Funcao que busca o percentual de reajuste referente a comp. º±?
±±?         ³passada por parametro.                           			  º±?
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±?
±±ºUso       ?AP                                                         º±?
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±?
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±?
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß?
*/

Static Function PercReajuste(cAnoMes,cMatric)
	Local nPerRea	:= 0
	Local cTipPess	:= "J"
	
	BHW->(DbSetOrder(2)) //Tabela de aplicacao de reajuste
	BYC->(DbSetOrder(2)) //Reajustes Fx. Etaria X Subcontrato
	BP7->(DbSetOrder(2)) //Reajustes Fx. Etaria X Familia
	BYB->(DbSetOrder(2)) //Reajustes Fx. Etaria X Usuario
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
	//?Encarar como fisica todos que o nivel de cobranca seja na familia.	?
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
	If BA3->BA3_COBNIV == "1"
		cTipPess := "F"
	Endif
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
	//?Buscar reajustes aplicados no mes...                              	?
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
	
	If BHW->(MsSeek(xFilial("BHW")+cAnoMes+PLSINTPAD()))
		
		While ! BHW->(Eof()) .And. BHW->(BHW_ANOMES+BHW_CODINT) == cAnoMes+PLSINTPAD()
			
			If Substr(cMatric,5,4) >= BHW->(BHW_EMPDE) .And. Substr(cMatric,5,4) <= BHW->(BHW_EMPATE)
				If cTipPess == "J"
					//BYC_FILIAL+BYC_OPEREA+BYC_CODREA+BYC_CODOPE+BYC_CODEMP+BYC_CONEMP+BYC_CONEMP+BYC_VERCON+BYC_SUBCON+BYC_VERSUB+BYC_CODPRO+BYC_VERPRO+BYC_CODFOR
					If BYC->(MsSeek(xFilial("BYC")+PLSINTPAD()+BHW->BHW_CODREA+BA3->(BA3_CODINT+BA3_CODEMP+BA3_CONEMP+BA3_VERCON+BA3_SUBCON+BA3_VERSUB+BA3_CODPLA+BA3_VERSAO)))
						nPerRea := BYC->BYC_PERREA
					Endif
					
				Else
					//BP7_OPEREA + BP7_CODREA + BP7_CODOPE + BP7_CODEMP + BP7_MATRIC + BP7_CODFAI
					If BP7->(MsSeek(xFilial("BP7")+PLSINTPAD()+BHW->BHW_CODREA+Substr(cMatric,1,14)))
						nPerRea := BP7->BP7_PERREA
					Endif
					
					//BYB_OPEREA + BYB_CODREA + BYB_CODOPE + BYB_CODEMP + BYB_MATRIC + BYB_TIPREG + BYB_CODFAI
					If BYB->(MsSeek(xFilial("BYB")+cMatric))
						nPerRea := BYB->BYB_PERREA
					Endif
					
				Endif
			Endif
			
			BHW->(DbSkip())
			
		Enddo
		
	Endif
	
Return nPerRea


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa   ?ImpAnlt  ?Autor ?Jean Schulz           ?Data ?08.02.07 ³±?
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao  ?Imprime analitico para impressao em grafica.               ³±?
±±ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
/*/

Static Function ImpAnlt(	aCobranca		,nAbatim		,nAcrescim		,oPrint		,;
		aBMP			,aDadosEmp		,aDadosTit		,aDadosBanco,;
		aDatSacado		,aMsgBoleto		,CB_RN_NN		,aOpenMonth	,;
		aDependentes	,aObservacoes	,cCart			,cPrefixo	,;
		cTitulo			,cGrupoEmp 		,cMatric		,lPrima	 	)
	
	Local nPCont 	:= 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS
	Local nAbcnt 	:= 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS
	Local nPCont1 	:= 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS
	
	Local nI		:= 0	// Contador do laco para impressao de dependentes.
	Local nMsg      := 0    // Contador para as mensagens
	Local cMoeda	:= "9"  // Moeda do boleto.
	Local nTamCorp	:= 1	// Tipo do corpo do extrato 1 = normal 2 = Grande.
	Local nCob		:= 0	// Contador para for do extrato.
	Local cString	:= ""
	Local cNomeArq	:= ""
	
	Local nPosC		:= At("-",aDatSacado[3])
	Local cEndereco	:= Substr(aDatSacado[3],1,Iif(nPosC>0,nPosC-1,Len(aDatSacado[3])))
	//Local cBairro	:= Iif(nPosC>0,Substr(aDatSacado[4],nPosC+1),"")
	Local cBairro	:= aDatSacado[4]
	Local cMunici	:= aDatSacado[5]
	Local cEstado	:= aDatSacado[6]
	Local cCEP		:= aDatSacado[7]
	
	Local cCpo 		:= ""
	Local aNomeMes	:= { "Janeiro", "Fevereiro", "Março", "Abril", "Maio", "Junho", "Julho", "Agosto", "Setembro", "Outubro", "Novembro", "Dezembro" }
	Local aArBA1	:= BA1->(GetArea())
	Local aArSA1	:= SA1->(GetArea())
	
	Local nTotCopUsr := 0
	Local _nPosTotC	:= 0
	
	Local cTipLanAn	:= ""
	Local nTotRtContr := 0
	Local nTotContr := 0
	Local nTotCopar	:= 0
	Local nTotBPF	:= 0
	Local nTotOutr	:= 0
	Local nRegBA1	:= 0
	Local nRegTitu	:= 0
	Local lEntrou	:= .F.
	Local aTotUsr	:= {}
	Local nTotContUsr := 0
	Local nTotOutrUsr := 0
	
	Private cMsg1	:= ""
	Private cMsg2	:= ""
	Private cMsg3	:= ""
	
	Private nPCont 	:= 0
	Private nPCont1	:= 0
	Private nPass	:= 0
	
	
	If Len(aCobranca) <= 0
		Return Nil
	Endif
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//?Buscar dados do titular...                                               ?
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	BA1->(DbSetOrder(2))
	BA1->(MsSeek(xFilial("BA1")+Substr(aCobranca[1,9],1,14)+"00"))
	nRegTitu := BA1->(RecNo())
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//?Somente exportar quando existir utilizacao...                            ?
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	//cEndereco := aDatSacado[3]
	cEndereco := Substr(cEndereco,1,40)
	cCompet := aNomeMes[Val(R240Imp->E1_MESBASE)]+" de "+R240Imp->E1_ANOBASE
	
	BA3->(DbSetOrder(1))
	BA3->(MsSeek(xFilial("BA3")+Substr(aCobranca[1,9],1,14)))
	
	If BA3->BA3_COBNIV == "1"
		
		aArSA1 := SA1->(GetArea())
		SA1->(DbSetOrder(1))
		SA1->(MsSeek(xFilial("BA3")+Substr(aCobranca[1,9],1,14)))
		//cEndereco := Substr(SA1->A1_END,1,40)
		RestArea(aArSA1)
	Endif
	
	aadd(aImp,{Substr(BA1->BA1_CEPUSR,1,5)+"-"+Substr(BA1->BA1_CEPUSR,6,3),aCobranca[1,9],"",{},{},R240Imp->E1_FORMREC})
	BFQ->(DbSetOrder(1))
	
	//Obter valor de coparticipacao individualizado...
	//Montar array para impressao posterior
	cMatAnt := aCobranca[1,9]
	
	//Pendente: ordenar matriz...
	
	For nPCont := 1 To Len(aCobranca)
		
		If aCobranca[nPCont,9] <> cMatAnt
			aadd(aTotUsr,{aCobranca[nPCont-1,9],nTotCopUsr,nTotContUsr,nTotOutrUsr, nTotRtContr})
			cMatAnt := aCobranca[nPCont,9]
			nTotCopUsr := 0
			nTotContUsr := 0
			nTotOutrUsr := 0
		Endif
		
		If Len(Alltrim(aCobranca[nPCont,5])) == 3
			cTipLanAn := Posicione("BFQ",1,xFilial("BFQ")+PLSINTPAD()+aCobranca[nPCont,5],"BFQ_YTPANL")
		Else
			cTipLanAn := "C"
		Endif
		
		
		If cTipLanAn == "M"
			nTotContr	+= Iif(aCobranca[nPCont,12]=="1",(1),(-1))*aCobranca[nPCont,07]
			nTotContUsr += Iif(aCobranca[nPCont,12]=="1",(1),(-1))*aCobranca[nPCont,07]
		Else
			
			If cTipLanAn == "C"
				
				VarTst := aCobranca[nPCont,11]
				nTotCopUsr	+= Iif(aCobranca[nPCont,12]=="1",(1),(-1))*aCobranca[nPCont,07]
				nTotCopar	+= Iif(aCobranca[nPCont,12]=="1",(1),(-1))*aCobranca[nPCont,07]
				If Type("VarTst") == "N"
					nTotBPF		+= Iif(aCobranca[nPCont,12]=="1",(1),(-1))*aCobranca[nPCont,11]
					nVlrBPF		:= Iif(aCobranca[nPCont,12]=="1",(1),(-1))*aCobranca[nPCont,11]
				Else
					nVlrBPF 	:= 0
				Endif
				
			Else
				nTotOutr	+= Iif(aCobranca[nPCont,12]=="1",(1),(-1))*aCobranca[nPCont,07]
				nTotOutrUsr += Iif(aCobranca[nPCont,12]=="1",(1),(-1))*aCobranca[nPCont,07]
				nVlrBPF 	:= 0
			Endif
			
			_cDatTmp	:= Iif(Empty(aCobranca[nPCont,3]),Space(10),Substr(aCobranca[nPCont,3],7,2)+"/"+Substr(aCobranca[nPCont,3],5,2)+"/"+Substr(aCobranca[nPCont,3],1,4))
			
			cCpo :=	"3"+;
				"2"+;
				Substr(aCobranca[nPCont,9],1,4)+"."+Substr(aCobranca[nPCont,9],5,4)+"."+Substr(aCobranca[nPCont,9],9,6)+"."+Substr(aCobranca[nPCont,9],15,2)+"-"+Substr(aCobranca[nPCont,9],17,1)+;
				_cDatTmp+;
				Space(20)+;
				Alltrim(Substr(aCobranca[nPCont,2],1,20))+Space(20-Len(Alltrim(Substr(aCobranca[nPCont,2],1,20))))+;
				Alltrim(Substr(aCobranca[nPCont,6],1,30))+Space(30-Len(Alltrim(Substr(aCobranca[nPCont,6],1,30))))+;
				Iif(nVlrBPF > 0,Transform(aCobranca[nPCont,11],"@E 999,999.99"),Space(10))+;
				Transform(aCobranca[nPCont,07],"@E 999,999.99")+;
				Space(1)+;
				Space(428)
			
			Aadd(aImp[1,5],cCpo)
		Endif
		
	Next
	
	//Busca o ultimo registro.
	If Len(aCobranca) > 0 .And. (nTotCopUsr<> 0 .Or. nTotContUsr <> 0 .Or. nTotOutrUsr <> 0 )
		aadd(aTotUsr,{aCobranca[Len(aCobranca),9],nTotCopUsr,nTotContUsr,nTotOutrUsr, nTotRtContr})
		nTotCopUsr := 0
		nTotContUsr := 0
		nTotOutrUsr := 0
	Endif
	
	/*aberto*/
	
	If Len(aOpenMonth) > 0
		cCpo :=	"4"+;
			"MESES EM ABERTO"+Space(86)+;
			Space(450)
		Aadd(aImp[1,5],cCpo)
	End if
	
	For nAbcnt := 1 to Len(aOpenMonth)
		cCpo :=	"4"+;
			aOPenMonth[nAbcnt]+Space((100-Length(aOPenMonth[nAbcnt])))+;
			Space(451)	//Motta
		Aadd(aImp[1,5],cCpo)
	Next nAbcnt
	
	cMsqTmp := ""
	
	If GetNewPar("MV_YGRIMVZ","0") == "1" .and. VerAdp(BA3->ba3_CODEMP, BA3->BA3_MATRIC) .AND. R240Imp->E1_MESBASE = '05'
		
		cMsg1 	:= "Declaramos a quitacao do ano de 2018, a mesma substitui todos os recibos de pagamento do ano de "
		cMsg2 	:= "2018. Debitos prorrogados ou negociados para períodos futuros não estao contemplados."
		
		cQuery  := " insert into log_imp_extrato values ( '0001', '" + BA3->BA3_CODEMP + "', '" + BA3->BA3_MATRIC + "', "
		cQuery  += " '00', '" + R240Imp->E1_NUM + "', '" + R240Imp->E1_ANOBASE + "', '" + R240Imp->E1_MESBASE + "', ' " + cMsg1 + " ', '" + dtos(date()) + "', '" + FunName() + "')  "
		
		TcSqlExec(cQuery) >= 0
		
		
		//Aadd(aImp[1,5],cCpo)
		
	EndIf
	
	
	For nPCont := 1 to Len(aTotUsr)
		
		nRegBa1 := BA1->(Recno())
		BA1->(MsSeek(xFilial("BA1")+aTotUsr[nPCont,1]))
		
		cCpo :=	"2"+;
			"1"+;
			BA1->BA1_CODINT+"."+BA1->BA1_CODEMP+"."+BA1->BA1_MATRIC+"."+BA1->BA1_TIPREG+"-"+BA1->BA1_DIGITO+;
			Substr(BA1->BA1_NOMUSR,1,30)+;
			Space(10)+; //Nao enviar
		Space(2)+; //Nao enviar
		Space(12)+; //Nao enviar
		Transform(aTotUsr[nPCont,3],"@E 9,999.99")+; //Valor Contraprestacao - Motta Jan/2012
		Transform(aTotUsr[nPCont,2]+aTotUsr[nPCont,4],"@E 999,999.99")+; //Valor Coparticipacao + Valor Outros
		Space(443)
		
		/*
		cCpo :=	"2"+;
			"1"+;
			BA1->BA1_CODINT+"."+BA1->BA1_CODEMP+"."+BA1->BA1_MATRIC+"."+BA1->BA1_TIPREG+"-"+BA1->BA1_DIGITO+;
			Substr(BA1->BA1_NOMUSR,1,30)+;
			Space(10)+; //Nao enviar
		Space(2)+; //Nao enviar
		Space(20)+; //Nao enviar
		Transform(aTotUsr[nPCont,3],"@E 9,999,999.99")+; //Valor Contraprestacao
		Transform(aTotUsr[nPCont,2]+aTotUsr[nPCont,4],"@E 9,999,999.99")+; //Valor Coparticipacao + Valor Outros
		Space(443)       */
		
		Aadd(aImp[1,4],cCpo)
		
	Next
	
	
	//For nPCont := 1 To Len(aMsgBoleto)
	//	cNomVar := "cMsg"+StrZero(nPCont,1)
	//	&cNomVar := aMsgBoleto[nPCont]
	//	If nPCont > 3
	//		Exit
	//	EndIf
	//Next   Paulo Motta -- Reajuste
	
	cContr := 0
	
	For nPCont := 1 To Len(aObservacoes)
		
		cNomVar := "cMsg"+StrZero(nPCont,1)
		
		If !Empty(cMsqTmp)
			
			&cNomVar := cMsqTmp
			cMsqTmp  := ""
			cContr   := 1
			
		Else
			
			&cNomVar := aObservacoes[nPCont - cContr]
			
		EndIf
		
		If nPCont > 3
			Exit
		EndIf
		
	Next
	
	BA1->(DbGoTo(nRegTitu))
	
	cCpo :=	"1"+;    //1
	"2"+;    //2
	BA1->BA1_CODINT+"."+BA1->BA1_CODEMP+"."+BA1->BA1_MATRIC+"."+BA1->BA1_TIPREG+"-"+BA1->BA1_DIGITO+;  //20
	StrZero(Val(BA1->BA1_MATEMP),18)+; //38
	Substr(aDatSacado[1],1,30)+Space(30-Len(aDatSacado[1]))+;//
	Substr(cEndereco,1,40)+Space(40-Len(cEndereco))+;
		Substr(cBairro,1,20)+Space(20-Len(cBairro))+;
		Substr(cMunici,1,20)+Space(20-Len(cMunici))+;
		Substr(cCEP,1,5)+"-"+Substr(cCEP,6,3)+;
		cEstado+;
		cCompet+Space(30-Len(cCompet))+;
		Transform(nTotContr,"@E 9,999,999.99")+; //Total Contraprestacao '+' + Transform(nTotRtContr,"@E 999.99")+; //Total Retroativo
	Transform(nTotCopar,"@E 9,999,999.99")+; //Total Participacao
	Transform(nTotOutr,"@E 9,999,999.99")+; //Total Outras
	Transform(nTotContr+nTotCopar+nTotOutr,"@E 9,999,999.99")+; //Total Geral
	Space(4)+cMsg1+Space(100-Len(cMsg1))+; //Mensagem 1
	cMsg2+Space(100-Len(cMsg2))+;  //Mensagem 2
	cMsg3+Space(100-Len(cMsg3))+;  //Mensagem 3
	space(100)
	
	/*
	cCpo :=	"1"+;
		"2"+;
		BA1->BA1_CODINT+"."+BA1->BA1_CODEMP+"."+BA1->BA1_MATRIC+"."+BA1->BA1_TIPREG+"-"+BA1->BA1_DIGITO+;
		StrZero(Val(BA1->BA1_MATEMP),18)+;
		Substr(aDatSacado[1],1,30)+Space(30-Len(aDatSacado[1]))+;
		Substr(cEndereco,1,40)+Space(40-Len(cEndereco))+;
		Substr(cBairro,1,20)+Space(20-Len(cBairro))+;
		Substr(cMunici,1,20)+Space(20-Len(cMunici))+;
		Substr(cCEP,1,5)+"-"+Substr(cCEP,6,3)+;
		cEstado+;
		cCompet+Space(30-Len(cCompet))+;
		Transform(nTotContr,"@E 9,999,999.99")+; //Total Contraprestacao
	Transform(nTotCopar,"@E 9,999,999.99")+; //Total Participacao
	Transform(nTotOutr,"@E 9,999,999.99")+; //Total Outras
	Transform(nTotContr+nTotCopar+nTotOutr,"@E 9,999,999.99")+; //Total Geral
	cMsg1+Space(100-Len(cMsg1))+; //Mensagem 1
	cMsg2+Space(100-Len(cMsg2))+; //Mensagem 2
	cMsg3+Space(100-Len(cMsg3))+; //Mensagem 3
	Transform(nTotBPF,"@E 9,999,999.99") //Total Base Part. Financeira
	*/
	
	
	
	aImp[1,3] := cCpo
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//?Inserida validacao para criticar caso o valor do titulo	nao seja igual ao?
	//?valor total da exportacao... (Data: 8/11/07).                            ?
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If nTotContr+nTotCopar+nTotOutr <> R240Imp->E1_VALOR
		
		aadd(_aErrAnlt,{BA1->BA1_CODINT+"."+BA1->BA1_CODEMP+"."+BA1->BA1_MATRIC+"."+BA1->BA1_TIPREG+"-"+BA1->BA1_DIGITO,"Tot. Analítico: "+Transform((nTotContr+nTotCopar+nTotOutr),"@E 999,999,999.99")+" Valor Título: "+Transform(R240Imp->SALDO,"@E 999,999,999.99")})
		//MARCELA COIMBRA EM 22/04/2014	aadd(_aErrAnlt,{BA1->BA1_CODINT+"."+BA1->BA1_CODEMP+"."+BA1->BA1_MATRIC+"."+BA1->BA1_TIPREG+"-"+BA1->BA1_DIGITO,"Tot. Analítico: "+Transform((nTotContr+nTotCopar+nTotOutr),"@E 999,999,999.99")+" Valor Título: "+Transform(R240Imp->E1_VALOR,"@E 999,999,999.99")})
		
	Endif
	
	RestArea(aArBA1)
	
	aSort(aImp,,, { |x,y| x[6]+x[1]+x[2] < y[6]+y[1]+y[2] })
	nReg := 1
	nPCont := 1
	
	For nPCont := 1 to Len(aImp)
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//?Somente exportar quando existir utilizacao...                            ?
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If !l_FamBlo .and.  ( ( Len(aImp[nPCont,5]) > 0 .Or. GetNewPar("MV_YGRIMVZ","0") == "1" ))  // imprime_todos      )
			//	If !l_FamBlo .and.  (lMosRea  .OR. ( Len(aImp[nPCont,5]) > 0 .Or. GetNewPar("MV_YGRIMVZ","0") == "1" ))  // imprime_todos      )
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//?Realizar controle de matriz x qtd linhas, necessario para o arquivo...   ?
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			cNomArr := "a"
			
			Do Case
			Case aImp[nPCont,6] == "01" //Arquivo Rio Previdencia...
				cNomArr += "1"
				
			Case aImp[nPCont,6] == "02" //Banco em liquidacao...
				cNomArr += "2"
				
			Case aImp[nPCont,6] == "06" //Debito em conta...
				cNomArr += "3"
				
			Case aImp[nPCont,6] == "04" //112
				cNomArr += "4"
				
			Case aImp[nPCont,6] == "08" //Arquivo Rio Previdencia...
				cNomArr += "1"
				
				
			EndCase
			
			Do Case
				
			Case Len(aImp[nPCont,5]) <= 40
				cNomArr += "_40ca4"
				
			Case Len(aImp[nPCont,5]) > 40 .And. Len(aImp[nPCont,5]) <= 102
				cNomArr += "_102ca3"
				
			Case Len(aImp[nPCont,5]) > 102
				cNomArr += "_102mca32"
				
			EndCase
			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//?Incluir array utilizado na matriz de utilizacao...                       ?
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If ascan(aMatUti,cNomArr) == 0
				aadd(aMatUti,cNomArr)
			Endif
			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//?Atribuir conteudo da matriz para impressao posterior...                  ?
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			//Raios - modificacao para geracao mais veloz utilizando arq. temporario...
			
			/*
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//?Cria arquivo de trabalho conforme layout...								 ?
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			Do Case
			Case cLayOut $ "400/500/600"
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
					{"SENHA" ,"C",  9,0},{"TIPNAS","C",  1,0},{"TIPPAC","C",  1,0},;
					{"RESERV","C", 29,0},{"SEXO"  ,"C",  1,0},{"DATNAS","C",  8,0},;
					{"MOEDA" ,"C",  2,0},{"GLOSA" ,"N",  8,0},{"CODUSR","C",  3,0},;
					{"CODANT","C",  7,0},{"CODPAD","C",  2,0},{"CHAGUI","C", 25,0}}
				
			Case cLayOut == "301" .and. nTamLin > 290
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
					{"CODANT","C",  7,0},{"CODPAD","C",  2,0},{"CHAGUI","C", 25,0}}
				
			Case cLayOut == "301"
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
					{"GLOSA" ,"N",  8,0},{"CODUSR","C",  3,0},{"CODANT","C",  7,0},;
					{"CODPAD","C",  2,0},{"CHAGUI","C", 25,0}}
				
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
					{"CODUSR","C",  3,0},{"CODANT","C",  7,0},{"CODPAD","C",  2,0},;
					{"CHAGUI","C", 25,0}}
			EndCase
			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
			//?Verifica se eh layout proprio...									?
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
			If cLayOut == "301" .and. nTamLin > 290
				lLayPro := .T.
			Else
				lLayPro := .F.
			Endif
			
			cTRB := CriaTrab(aStruc,.T.)
			DbUseArea(.T.,,cTRB,"TRB",.T.)
			DbSelectArea("TRB")
			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
			//?Copia arquivo da origem para o SigaAdv para usar o Append...		?
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
			FT_FUse()
			nH := FCreate("P:\AP7\TMP\"+cNomArq)
			
			For nLinTmp := 1 to Len(aArqTmp)
				FWrite(nH,aArqTmp[nLinTmp],Len(aArqTmp[nLinTmp]))
			Next
			
			FClose(nH)
			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
			//?Joga arquivo em area de trabalho...                                 ?
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
			cArquivo := "P:\AP7\TMP\"+cNomArq
			
			Append From &cArquivo SDF
			
			*/
			
			aadd(&cNomArr,aImp[nPCont,3])
			
			nPCont1 := 1
			For nPCont1 := 1 To Len(aImp[nPCont,4])
				aadd(&cNomArr,aImp[nPCont,4,nPCont1])
			Next
			
			nPCont1 := 1
			For nPCont1 := 1 To Len(aImp[nPCont,5])
				aadd(&cNomArr,aImp[nPCont,5,nPCont1])
			Next
			
		Endif
		
	Next
	
	aImp := {}
	
Return Nil


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ?
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±?
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±?
±±ºPrograma  | FRMMANT  ºAutor  ³Motta               ?Data ? 08/24/07   º±?
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±?
±±ºDesc.     ?Formata Matricula antiga do Sistema                        º±?
±±?         ?                                                           º±?
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±?
±±ºUso       ?AP                                                         º±?
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±?
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±?
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß?
*/

Static Function FRMMANT(cMatAnt)
	
	cMatAnt := Zeros(11 - Len(AllTrim(cMatAnt))) + AllTrim(cMatAnt)
	cMatant := Substr(cMatant,1,3)+"."+Substr(cMatant,4,5)+"."+Substr(cMatant,9,2)+"-"+Substr(cMatant,11,1)
	
Return cMatAnt


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ?
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±?
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±?
±±ºPrograma  |Libera_CNABºAutor  ³Jean Schulz        ?Data ? 27/10/07   º±?
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±?
±±ºDesc.     ?Libera campo personalizado da exportacao CNAB.             º±?
±±?         ?                                                           º±?
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±?
±±ºUso       ?AP                                                         º±?
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±?
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±?
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß?
*/
Static Function Libera_CNAB(cArqCNAB)
	Local cSQLTmp := ""
	Local aAreaSE1 := SE1->(GetArea())
	
	cSQLTmp := " SELECT R_E_C_N_O_ REGSE1"
	cSQLTmp += " FROM "+RetSQLName("SE1")
	cSQLTmp += " WHERE E1_YTPEXP = 'B' " //CNAB 112 ENVIO - TABELA K1
	cSQLTmp += " AND E1_YAREXPO = '"+cArqCNAB+"' "
	cSQLTmp += " AND D_E_L_E_T_ = ' ' "
	
	PLSQuery(cSQLTmp,"TRBLIB")
	
	While !TRBLIB->(Eof())
		
		SE1->(DbGoTo(TRBLIB->REGSE1))
		If GetNewPar("MV_YFLGBL","N") = "S"
			U_fLogBol() //Edilson Leal 24/01/08 : Log de Impressao
		Endif
		SE1->(RecLock("SE1",.F.))
		SE1->E1_YTPEXP	:= "" // CNAB 112 - TABELA K1
		SE1->E1_YTPEDSC	:= ""
		SE1->E1_YAREXPO	:= ""
		SE1->(MsUnlock())
		TRBLIB->(DbSkip())
		
	Enddo
	
	TRBLIB->(DbCloseArea())
	
	RestArea(aAreaSE1)
	
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ?
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±?
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±?
±±ºPrograma  ³BuscaDesBSQºAutor  ³Jean Schulz        ?Data ? 11/12/07   º±?
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±?
±±ºDesc.     ³Melhoria para demonstrar a observacao do lancamento de debi-º±?
±±?         ³to/credito quando for originario de BSQ.                    º±?
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±?
±±ºUso       ?Caberj                                                     º±?
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±?
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±?
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß?
*/
Static Function BuscaDescr(cLanFat, cDesBM1, cAlias, cOrigem)
	
	Local cDescri	:= cDesBM1
	Local aAreaBSQ	:= BSQ->(GetArea())
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//?Caso seja odonto, e origem BSQ, muda descricao...                        ?
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If BM1->BM1_CODTIP $ GetNewPar("MV_YDESBSQ","939") .And. cAlias == "BSQ"
		BSQ->(DbSetOrder(1))
		If BSQ->(MsSeek(xFilial("BSQ")+AllTrim(cOrigem)))
			If !Empty(BSQ->BSQ_OBS)
				cDescri := BSQ->BSQ_OBS
			EndIf
		EndIf
	EndIf
	
	// Parcelamento
	If BM1->BM1_CODTIP $ GetNewPar("MV_YPARBSQ","935") .And. cAlias == "BSQ"
		BSQ->(DbSetOrder(1))
		If BSQ->(MsSeek(xFilial("BSQ")+AllTrim(cOrigem)))
			If !Empty(BSQ->BSQ_OBS) .And.;
					(BSQ->BSQ_CODLAN == SuperGetMv("MV_XXNEGDE",,"991") .Or.;
					BSQ->BSQ_CODLAN == SuperGetMv("MV_XXNEGCR",,"990"))
				
				cDescri := FORMPARC(BSQ->BSQ_OBS)
			EndIf
		EndIf
	EndIf

	// FRED: Parcelamento de vacinas
	If cAlias == "BSQ" .and. BM1->BM1_CODTIP == "977"
		BSQ->(DbSetOrder(1))
		If BSQ->(MsSeek(xFilial("BSQ")+AllTrim(cOrigem)))
			If !Empty(BSQ->BSQ_OBS)
				cDescri := FORMPARC(BSQ->BSQ_OBS)
			EndIf
		EndIf
	EndIf
	
	//Mes e Ano Ref. Baixa em atraso.  Incluido por Gedilson Rangel
	If BM1->BM1_CODTIP == "937" .And. cAlias == "BSQ"
		BSQ->(DbSetOrder(1))
		If BSQ->(MsSeek(xFilial("BSQ")+AllTrim(cOrigem)))
			If !Empty(BSQ->BSQ_OBS).And. BSQ->BSQ_CODLAN == GetNewPar("MV_YPAR2BSQ","993")
				cDescri := AllTrim(BM1->BM1_DESTIP)+"  REF:" + BSQ->BSQ_YMBASE + "/" +SUBSTR(BSQ->BSQ_YABASE,3,2)
			EndIf
		EndIf
	EndIf

	If cEmpAnt = "01" //CABERJ

		_cCodLanc := "973|974"
	
	Else

		_cCodLanc := "926|927"

	EndIf

	If BM1->BM1_CODTIP $ (_cCodLanc) .And. cAlias == "BSQ"
		BSQ->(DbSetOrder(1))
		If BSQ->(MsSeek(xFilial("BSQ")+AllTrim(cOrigem)))
			If !Empty(BSQ->BSQ_OBS)
				cDescri := BSQ->BSQ_OBS
			EndIf
		EndIf
	EndIf
	
	RestArea(aAreaBSQ)
	
Return cDescri


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ?
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±?
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±?
±±ºPrograma  ³FORMPARC  ºAutor  ³Microsiga           ?Data ? 02/27/09   º±?
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±?
±±ºDesc.     ?FORMATA MENSAGEM DE PARCELAMENTO O NUMERO DA PARCELA       º±?
±±?         ?PODE CONTER UM ALFA , ESTA FUNCAO AJUSTA ISTO              º±?
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±?
±±ºUso       ?AP                                                         º±?
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±?
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±?
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß?
*/
Static Function FormParc(cBsqObs)
	
	Local cRetObs		:= AllTrim(cBsqObs)
	Local cObs			:= Upper(cRetObs)
	Local nPosParc		:= At("PARCELA", cObs) + 8
	Local nPosDe		:= At("DE", cObs)
	Local cParc			:= SubStr(cRetObs, nPosParc, nPosDe - (nPosParc + 1))
	Local cTotParc		:= SubStr(cRetObs, nPosDe + 3)
	Local nPosSpace		:= At(" ", cTotParc) - 1
	
	nPosSpace	:= If(nPosSpace < 1, Len(cTotParc), nPosSpace)
	cTotParc	:= SubStr(cTotParc, 1, nPosSpace)
	nTotParc	:= Val(cTotParc)
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Em alguns casos antigos as letras maisculas foram usadas antes?
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If nTotParc < 36
		cParc := Lower(cParc)
	EndIf
	
	If !(Len(cParc) > 1)
		cPesq := "123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
		cParc := AllTrim(StrZero(At(cParc, cPesq), 2))
		cRetObs := SubStr(cRetObs, 1, nPosParc - 1) + cParc + " DE " + StrZero(nTotParc, 2)
		cRetObs := StrTran(cRetObs, ":", "")
	EndIf
	
Return cRetObs


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ?
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±?
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±?
±±ºPrograma  ³MSREAFXET ºMotta  ³Caberj              ?Data ? julho/09   º±?
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±?
±±ºDesc.     ? Monta mensagem de mudança de faixa etária                 º±?
±±?         ?                                                           º±?
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±?
±±ºUso       ?AP                                                         º±?
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±?
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±?
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß?
*/
Static Function MSREAFXET
	
	Local cMsFxEtr := " "
	/*
	cSQLFXE := " SELECT TRIM(SUBSTR(VERIFICA_REAJ_FX_ETARIA('"
	cSQLFXE += BA3->BA3_CODINT + "','"
	cSQLFXE += BA3->BA3_CODEMP + "','"
	cSQLFXE += BA3->BA3_MATRIC + "','"
	cSQLFXE += SE1->E1_ANOBASE + "','"
	cSQLFXE += SE1->E1_MESBASE + "'),1,20)) TIPREG "
	cSQLFXE += " FROM DUAL "
	*/
	
	cSQLFXE := " SELECT BM1A.BM1_TIPREG TIPREG "
	cSQLFXE += "         FROM   " + RetSqlName("BM1") +  " BM1A , " + RetSqlName("BM1") +  " BM1B "
	cSQLFXE += "        WHERE  BM1A.BM1_FILIAL = '" + XfILIAL("BM1") + "' "
	cSQLFXE += "        AND    BM1A.BM1_CODINT = '" + BA3->BA3_CODINT + "' "
	cSQLFXE += "        AND    BM1A.BM1_CODEMP = '" + BA3->BA3_CODEMP + "' "
	cSQLFXE += "        AND    BM1A.BM1_MATRIC = '" + BA3->BA3_MATRIC + "' "
	cSQLFXE += "        AND    BM1A.BM1_CODTIP = '101'   "
	cSQLFXE += "        AND    BM1A.BM1_ANO    = " + SE1->E1_ANOBASE + " "
	cSQLFXE += "        AND    BM1A.BM1_MES    = " + SE1->E1_MESBASE + " "
	cSQLFXE += "        AND    BM1B.BM1_FILIAL = BM1A.BM1_FILIAL "
	cSQLFXE += "        AND    BM1B.BM1_CODINT = BM1A.BM1_CODINT "
	cSQLFXE += "        AND    BM1B.BM1_CODEMP = BM1A.BM1_CODEMP "
	cSQLFXE += "        AND    BM1B.BM1_MATRIC = BM1A.BM1_MATRIC "
	cSQLFXE += "        AND    BM1B.BM1_TIPREG = BM1A.BM1_TIPREG "
	cSQLFXE += "        AND    BM1B.BM1_CODTIP = BM1A.BM1_CODTIP "
	cSQLFXE += "        AND    BM1B.BM1_ANO    = DECODE(BM1A.BM1_MES,'01',LPAD(BM1A.BM1_ANO-1,4,'0'),BM1A.BM1_ANO) "
	cSQLFXE += "       AND    BM1B.BM1_MES    = DECODE(BM1A.BM1_MES,'01','12',LPAD(BM1A.BM1_MES-1,2,'0'))  "
	cSQLFXE += "        AND    (BM1A.BM1_CODFAI > BM1B.BM1_CODFAI)    "
	cSQLFXE += "        AND    BM1A.D_E_L_E_T_ = ' '    "
	cSQLFXE += "        AND    BM1B.D_E_L_E_T_ = ' '    "


	PLSQuery(cSQLFXE,"TRBFXE")


	If !Empty(TRBFXE->TIPREG)
		cMsFxEtr := "EM DECORRENCIA DE MUDANCA DE FAIXA ETARIA(" + alltrim(TRBFXE->TIPREG) + ") SEU PLANO ESTA SENDO REAJUSTADO. LEI 9656/98"
	EndIf

	
	TRBFXE->(DbCloseArea())

Return cMsFxEtr

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ?
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±?
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±?
±±ºPrograma  ³IR2009    ºMotta  ³Caberj              ?Data ? 11/01/08   º±?
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±?
±±ºDesc.     ?rETORNA A LINHA COM TOTAL DE IR 2007                       º±?
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±?
±±ºUso       ?AP                                                         º±?
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±?
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±?
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß?
*/
Static  Function IR2009( a_Observacao )

Local cLinIR 	:= " "
Local cSqlIR 	:= " "
Local a_ObsL 	:= {}
Local nI 		:= 1 //Leonardo Portella - 20/02/15

Local a_AreaBa1 := GetArea("BA1")

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ??
//³Supõe que a BA3 j?esteja ponteirada?
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ??

cSqlIR := "SELECT CODINT,CODEMP,MATRIC,TIPREG,BA1_NOMUSR, BA1_DATINC,  sum(VALOR) VALOR "
cSqlIR += " FROM   ir_benef_separ_fat  , " + RetSqlName( "BA1" ) + " "
cSqlIR += " WHERE  CODINT = '" + BA3->BA3_CODINT + "' "
cSqlIR += " AND    CODEMP = '" + BA3->BA3_CODEMP + "' "
cSqlIR += " AND    MATRIC = '" + BA3->BA3_MATRIC + "' "
cSqlIR += " AND    ANOBASEIR = '2019' "

cSqlIR += " AND D_E_L_E_T_ = ' ' "
cSqlIR += " AND BA1_FILIAL = ' ' "
cSqlIR += " AND BA1_CODINT = CODINT "
cSqlIR += " AND BA1_CODEMP = CODEMP "
cSqlIR += " AND BA1_MATRIC = MATRIC "
cSqlIR += " AND BA1_TIPREG = TIPREG "

cSqlIR += " GROUP BY CODINT,CODEMP,MATRIC,TIPREG ,BA1_NOMUSR, BA1_DATINC "

cSqlIR += " ORDER BY 4 "

PLSQuery(cSqlIR,"TIR")

cLinIR := ""

While !TIR->(EOF())
	If TIR->(VALOR) > 0
		cLinIR += SUBSTR(TIR->BA1_NOMUSR, 1, 19) + " R$" + Transform(TIR->VALOR,"@E 99,999.99") + "; "
		
	endif
	TIR->( dbSkip() )
	
EndDo
If !Empty( cLinIR )
	
	If Val_cpf (BA3->BA3_CODINT+ BA3->BA3_CODEMP+ BA3->BA3_MATRIC )
		
		IF DTOS(POSICIONE("BA1", 1, XFILIAL("BA1") + BA3->BA3_CODINT+ BA3->BA3_CODEMP+ BA3->BA3_MATRIC + 'T', "BA1_DATINC")) < '20190101'
			
			cLinIR := "IR 2019: " + SubStr(cLinIR, 1, Len(cLinIR)-2 )
			cLinIR += " -informacoes sobre reembolso disponiveis no site"
			
		ELSE
			
			c_Qry:= " Select BA12.BA1_matric "
			c_Qry+= " from ba1010 ba11 inner join ba1010 ba12 on ba12.ba1_filial = ' '  "
			c_Qry+= "                           and BA12.BA1_CPFUSR = BA11.BA1_CPFUSR "
			c_Qry+= "                            and BA12.BA1_TIPUSU = 'T'       "
			c_Qry+= "                            and BA12.BA1_codemp in ('0001', '0002', '0005')"
			c_Qry+= "                            and BA12.BA1_matric < BA11.BA1_matric  "
			c_Qry+= "                            AND BA12.BA1_DATBLO >= '20190101' "
			c_Qry+= "                            and BA12.D_E_L_E_T_ = ' '   "
			c_Qry+= "	where ba11.ba1_filial = ' ' "
			c_Qry+= "	and ba11.ba1_codint = '" + BA3->BA3_CODINT + "' "
			c_Qry+= "   and ba11.ba1_codemp = '" + BA3->BA3_CODEMP + "' "
			c_Qry+= "   AND BA11.BA1_MATRIC = '" + BA3->BA3_MATRIC + "' "
			c_Qry+= "   and BA11.BA1_TIPUSU = 'T' "
			c_Qry+= "   and ba11.ba1_datinc < '20200101' "
			c_Qry+= "   and ba11.d_e_l_e_t_ = ' ' "
			
			TCQuery c_Qry Alias "TMPDUPMAT" New
			
			If TMPDUPMAT->( EOF() )
				
				cLinIR := "IR 2019: " + SubStr(cLinIR, 1, Len(cLinIR)-2 )
				cLinIR += " -informacoes sobre reembolso disponiveis no site"
				
			Else
				
				cLinIR := "Para obtencao do informe de Imposto de Renda 2019, acesse o site www.caberj.com.br"
				
			EndIf
			
			TMPDUPMAT->( dbCloseArea() )
			
			
		ENDIF
		
		//cLinIR += " As informações sobre reembolso de despesas médicas estão disponíveis no site na área restrita ao associado www.caberj.com.br"
	Else
		
		cLinIR := "Identificamos duplicidade no cadastro de seu CPF em nosso sistema, impedindo a geracao do Informe do IR. Entre em contato para atualizacao cadastral."
		
	EndIf
	
	//Leonardo Portella - 20/02/15 - Inicio - Acertar espacos entre fim de uma linha e espaco de outra, visto que no demonstrativo
	//a ultima letra da da linha superior concatena com a primeira da linha posterior
	
	//a_Observacao := justIficatxt(cLinIR, 100 )
	If len(trim( cLinIR ) ) > 297
		
		cLinIR := "Identificamos duplicidade no cadastro de seu CPF em nosso sistema, impedindo a "
		cLinIR += "geracao do Informe do IR. Entre em contato para atualizacao cadastral"
		
	EndIf
	
	a_Observacao := justIficatxt(cLinIR, 99 )
	
	For nI := 1 to len(a_Observacao)
		a_Observacao[nI] := PadR(a_Observacao[nI],100)
	Next
	
	cQuery  := " insert into log_imp_extrato values ( '0001', '" + BA3->BA3_CODEMP + "', '" + BA3->BA3_MATRIC + "', "
	cQuery  += " '00', '" + R240Imp->E1_NUM + "', '" + R240Imp->E1_ANOBASE + "', '" + R240Imp->E1_MESBASE + "', ' " + cLinIR + " ', '" + dtos(date()) + "', '" + FunName() + "')  "
	
	TcSqlExec(cQuery) >= 0
	
	//Leonardo Portella - 20/02/15 - Fim
	
	// 16 + 19 + 3 + 9 + 2 = 49
	// 33
Else
	
	//------------------------------------------------------------------------------------------
	// Angelo Henrique - Data: 22/02/2019
	//------------------------------------------------------------------------------------------
	// Vasculhar se o beneficiário não trocou de plano na virada do ano ou algo do tipo
	//------------------------------------------------------------------------------------------
	c_Qry := " SELECT     													 " + c_ent
	c_Qry += "     CODINT,													 " + c_ent
	c_Qry += "     CODEMP,                                                   " + c_ent
	c_Qry += "     MATRIC,                                                   " + c_ent
	c_Qry += "     TIPREG,                                                   " + c_ent
	c_Qry += "     BA12.BA1_NOMUSR,                                          " + c_ent
	c_Qry += "     SUM(VALOR) VALOR                                          " + c_ent
	c_Qry += " FROM                                                          " + c_ent
	c_Qry += "     BA1010 BA11                                               " + c_ent
	c_Qry += "                                                               " + c_ent
	c_Qry += "     INNER JOIN                                                " + c_ent
	c_Qry += "         BA1010 BA12                                           " + c_ent
	c_Qry += "     ON                                                        " + c_ent
	c_Qry += "         BA12.BA1_FILIAL = ' '                                 " + c_ent
	c_Qry += "         AND BA12.BA1_CPFUSR = BA11.BA1_CPFUSR                 " + c_ent
	c_Qry += "         AND BA12.BA1_TIPUSU = 'T'                             " + c_ent
	c_Qry += "         AND BA12.BA1_CODEMP IN ('0001', '0002', '0005')       " + c_ent
	c_Qry += "         AND BA12.BA1_MATRIC < BA11.BA1_MATRIC                 " + c_ent
	c_Qry += "         AND BA12.BA1_DATBLO BETWEEN '20180101' AND '20181231' " + c_ent
	c_Qry += "         AND BA12.D_E_L_E_T_ = ' '                             " + c_ent
	c_Qry += "                                                               " + c_ent
	c_Qry += "     INNER JOIN                                                " + c_ent
	c_Qry += "         IR_BENEF_SEPAR_FAT                                    " + c_ent
	c_Qry += "     ON                                                        " + c_ent
	c_Qry += "         CODINT          = BA12.BA1_CODINT                     " + c_ent
	c_Qry += "         AND CODEMP      = BA12.BA1_CODEMP                     " + c_ent
	c_Qry += "         AND MATRIC      = BA12.BA1_MATRIC                     " + c_ent
	c_Qry += "         AND ANOBASEIR   = '2018'                              " + c_ent
	c_Qry += "                                                               " + c_ent
	c_Qry += " WHERE                                                         " + c_ent
	c_Qry += "                                                               " + c_ent
	c_Qry += "     BA11.BA1_FILIAL = ' ' 	                                 " + c_ent
	c_Qry += "     AND BA11.BA1_CODINT = '" + BA3->BA3_CODINT + "'           " + c_ent
	c_Qry += "     AND BA11.BA1_CODEMP = '" + BA3->BA3_CODEMP + "'			 " + c_ent
	c_Qry += "     AND BA11.BA1_MATRIC = '" + BA3->BA3_MATRIC + "'           " + c_ent
	c_Qry += "     AND BA11.BA1_TIPUSU = 'T'                                 " + c_ent
	c_Qry += "     AND BA11.D_E_L_E_T_ = ' '                                 " + c_ent
	c_Qry += "                                                               " + c_ent
	c_Qry += " GROUP BY                                                      " + c_ent
	c_Qry += "     BA11.BA1_MATRIC,                                          " + c_ent
	c_Qry += "     BA12.BA1_MATRIC,                                          " + c_ent
	c_Qry += "     CODINT,                                                   " + c_ent
	c_Qry += "     CODEMP,                                                   " + c_ent
	c_Qry += "     MATRIC,                                                   " + c_ent
	c_Qry += "     TIPREG,                                                   " + c_ent
	c_Qry += "     BA12.BA1_NOMUSR                                           " + c_ent
	
	PLSQuery(c_Qry,"TAR")
	
	While !TAR->(EOF())
		
		If TAR->(VALOR) > 0
			
			cLinIR := SUBSTR(TAR->BA1_NOMUSR, 1, 19) + " R$" + Transform(TAR->VALOR,"@E 99,999.99") + "; "
			cLinIR := "IR 2018: " + SubStr(cLinIR, 1, Len(cLinIR)-2 )
			
		Endif
		
		TAR->( DbSkip() )
		
	EndDo
	
	TAR->(DbCloseArea())
	
	
	a_Observacao := justIficatxt(cLinIR, 99 )
	
	For nI := 1 to len(a_Observacao)
		a_Observacao[nI] := PadR(a_Observacao[nI],100)
	Next
	
	cQuery  := " insert into log_imp_extrato values ( '0001', '" + BA3->BA3_CODEMP + "', '" + BA3->BA3_MATRIC + "', "
	cQuery  += " '00', '" + R240Imp->E1_NUM + "', '" + R240Imp->E1_ANOBASE + "', '" + R240Imp->E1_MESBASE + "', ' " + cLinIR + " ', '" + dtos(date()) + "', '" + FunName() + "')  "
	
	TcSqlExec(cQuery) >= 0
	
Endif

//Alert(cLinIR)

TIR->(DbCloseArea())

Return cLinIR


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ?
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±?
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±?
±±ºPrograma  ³valcpf    ºaltamiro³Caberj             ?Data ? 21/12/11   º±?
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±?
±±ºDesc.     ?Verifica se a duplicidade de CPF para matricula passada    º±?
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±?
±±ºUso       ?AP                                                         º±?
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±?
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±?
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß?
*/
Static Function Val_cpf( cFamilia )
	
	Local l_Ret := .F.
	
	cQuery :=" SELECT B1.BA1_CODINT|| B1.BA1_CODEMP|| B1.BA1_MATRIC || B1.BA1_TIPREG MATRICULA1 "
	cQuery +="      , B1.BA1_CPFUSR CPF "
	cQuery +="      , B1.BA1_DATNAS     "
	cQuery +="   from  ba1010 b1  ,bts010  b2   , ba3010 b3 , sa1010 sa1 "
	cQuery +="  WHERE B1.BA1_FILIAL=' ' "
	cQuery +="    AND B3.BA3_FILIAL = ' '"
	cQuery +="    AND BTS_FILIAL=' ' "
	cQuery +="    AND A1_FILIAL = ' ' "
	cQuery +="    AND B1.D_E_L_E_T_=' '"
	cQuery +="    AND B2.D_E_L_E_T_=' ' "
	cQuery +="    AND B3.D_E_L_E_T_=' ' "
	cQuery +="    AND SA1.D_E_L_E_T_=' ' "
	
	cQuery += "   AND b1.BA1_CPFUSR <> ' '    "
	cQuery += "   AND VAL_CPF(TRIM(b1.BA1_CPFUSR)) = 1   "
	
	cQuery +="    AND IDADE_S(TRIM(B1.BA1_DATNAS),'20181231') < 8 "
	cQuery +="    AND B1.BA1_CODINT|| B1.BA1_CODEMP|| B1.BA1_MATRIC = '" + cFamilia + "'" // &PARAM
	cQuery +="    AND BA1_MATVID=BTS_MATVID AND (B1.BA1_DATBLO=' ' OR B1.BA1_DATBLO> TO_CHAR (SYSDATE,'yyyymmdd'))  "
	cQuery +="    AND B1.BA1_CODINT = B3.BA3_CODINT AND B1.BA1_CODEMP = B3.BA3_CODEMP AND B1.BA1_MATRIC = B3.BA3_MATRIC AND BA3_CODCLI = A1_COD  "
	cQuery +="    AND B1.BA1_CPFUSR IN (SELECT BA1_CPFUSR FROM  BA1010 B1 WHERE B1.BA1_FILIAL=' ' AND B1.D_E_L_E_T_=' '  "
	cQuery +="    						AND (B1.BA1_DATBLO=' ' OR B1.BA1_DATBLO > TO_CHAR (SYSDATE,'yyyymmdd')) AND B1.BA1_CPFUSR<>' ' "
	cQuery +="    						AND IDADE_S(TRIM(B1.BA1_DATNAS),'20181231') < 8 "
	cQuery +="    						AND B1.BA1_CODEMP NOT IN('0004','0006','0010','0009') GROUP BY BA1_CPFUSR HAVING COUNT(*)>1 )  "
	cQuery +="    AND B1.BA1_CPFUSR<>' ' AND B1.BA1_CODEMP NOT IN('0004','0006','0010','0009')  "
	cQuery +="  ORDER BY  2,1"
	
	If Select("TMP") > 0
		dbSelectArea("TMP")
		dbclosearea()
	Endif
	
	TCQuery cQuery Alias "TMP" New
	
	TMP->( dbGoTop() )
	
	If TMP->( EOF() )
		
		l_Ret := .T.
		
	EndIf
	
	TMP->( dbCloseArea() )
	
Return l_Ret


**'Marcela Coimbra 12/06/12 - Termo de quitação de débito'**
Static Function VerAdp( c_CodEmp, c_Matric )
	
	Local l_Ret := .F.
		
	c_Qry := " SELECT * "
	c_Qry += " FROM MATRICULA_QUITACAO"
	c_Qry += " WHERE codint = '0001' "
	c_Qry += " and codemp = '" + c_CodEmp + "' "
	c_Qry += " and matric = '" + c_Matric + "' "
		
	PLSQuery(c_Qry, "QRYAD")
	
	If !(QRYAD->( eof() ))
		
		l_Ret := .T.
		
	EndIf
	
	QRYAD->( dbCloseArea() )
	
Return l_Ret
//
// ******************************************************************************************************************
// ******************************************************************************************************************
// ******************************************************************************************************************
//
//
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ?
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±?
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±?
±±ºPrograma  ³fDigNosBra ºAutor  ?Vitor Sbano       ?Data ? 28/11/13   º±?
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±?
±±ºDesc.     ?Calculo DV Nosso Numero - BRADESCO (SE1->E1_NUMBCO)        º±?
±±?         ?                                                           º±?
±±?         ?                                                           º±?
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±?
±±ºUso       ?AP                                                        º±?
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±?
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±?
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß?
*/


*----------------------------------------------------------------------------------------*
User Function fDigNosBra(cCartCob,cNosNum)
	*----------------------------------------------------------------------------------------*
	* calculo do digito do BRADESCO
	*----------------------------------------------------------------------------------------*
	
	Local nRes1 	:= 0
	Local nRes2 	:= 0
	Local nRes3 	:= 0
	Local nRes4 	:= 0
	Local nRes5 	:= 0
	Local nRes6 	:= 0
	Local nRes7 	:= 0
	Local nRes8 	:= 0
	Local nRes9 	:= 0
	Local nRes10 	:= 0
	Local nRes11 	:= 0
	Local nRes12 	:= 0
	Local nRes13 	:= 0
	Local nTotDG	:= 0
	Local nResDG	:= 0
	Local nRstDG	:= 0
	
	//
	If empty(cCartCob)
		cCartCob	:= "09"
	Endif
	nRes1	:=	val(substr(cCartCob,1,1)) * 2
	nRes2	:=	val(substr(cCartCob,2,1)) * 7
	nRes3	:=	val(substr(cNosNum,1,1))  * 6
	nRes4	:=	val(substr(cNosNum,2,1))  * 5
	nRes5	:=	val(substr(cNosNum,3,1))  * 4
	nRes6	:=	val(substr(cNosNum,4,1))  * 3
	nRes7	:=	val(substr(cNosNum,5,1))  * 2
	nRes8	:=	val(substr(cNosNum,6,1))  * 7
	nRes9	:=	val(substr(cNosNum,7,1))  * 6
	nRes10	:=	val(substr(cNosNum,8,1))  * 5
	nRes11	:=	val(substr(cNosNum,9,1))  * 4
	nRes12	:=	val(substr(cNosNum,10,1)) * 3
	nRes13	:=	val(substr(cNosNum,11,1)) * 2
	//
	nTotDG	:=	nRes1 + nRes2 + nRes3 + nRes4 + nRes5 + nRes6 + nRes7 + nRes8 + nRes9 + nRes10 + nRes11 + nRes12 + nRes13
	//
	nResDG	:=	int(nTotDg / 11)
	nRstDG	:=	nTotDG -  (nResDG * 11)
	//
	nDig	:=	11 - nRstDG
	//
	Do Case
	Case nRstDG =  1
		cDig	:= "P"
	Case nRstDG =  0
		cDig	:= "0"
	Otherwise
		cDig	:= alltrim(str(nDig))
	Endcase
	//
Return cDig
//
// **********************************************************************************************************************************
// **********************************************************************************************************************************
// **********************************************************************************************************************************
//

User Function CalcDVBrad(cStr)
	Local i, nMult := 2,nModulo := 0, cChar
	
	cStr := AllTrim(cStr)
	For i := Len(cStr) to 1 Step -1
		cChar := Substr(cStr,i,1)
		if isAlpha(cChar)
			Help(" ", 1, "ONLYNUM")
			Return .f.
		endif
		nModulo += Val(cChar)*nMult
		nMult:= if(nMult==7,2,nMult+1)
	Next
	nRest := nModulo % 11
	//nRest := if(nRest==0,nRest,11-nRest)
	nRest := IIf(nRest==0 .or. nRest==1,0,11-nRest)
	//
	cRest	:=	alltrim(str(nRest))
	//
	If cRest = "0"
		cRest	:= "P"
	Endif
	//
	//	if nRest <> Val(cDigito)
	//		Help(" ",1,"MODULO11")
	//		lRet := .f.
	//	else
	//		lRet := .t.
	//	endif
	//
Return(cRest)

/// Reajsute 2014
Static Function Perc2014(cAnoMes, cMatric )
	
	Local a_Area := GetArea('BA3')
	Local c_Ret  := ""
	
	dbSelectArea("BA3")
	dbSetOrder(1)
	If dbSeek(xFilial("BA3") + cMatric)
		/*
		Do Case
			
		Case BA3->BA3_INDREA == "000033"
			
			c_Ret := "19.21%"
			
		Case BA3->BA3_INDREA == "000034"
			
			c_Ret := " 21.69%"
			
		Case BA3->BA3_INDREA == "000035"
			
			c_Ret := "16.02%"
			
		EndCase
		
		
		Do Case
			
		Case BA3->BA3_INDREA == '000047' //BA3->BA3_XGRPR == "0042"
			
			c_Ret := " 18,81%"
			
		Case BA3->BA3_INDREA == '000048'
			
			c_Ret := " 13,35%"
			
		Case BA3->BA3_INDREA == '000049'
			
			c_Ret := " 13,15%"
			
		EndCase
		*/
		
		DbSelectArea("AAE")
		DbSetOrder(1) //AAE_FILIAL+AAE_CODIND+DTOS(AAE_DATA)
		If DbSeek(xFilial("AAE") + BA3->BA3_INDREA)
			
			c_Ret := cValToChar(AAE->AAE_INDICE) + " %"
			
		EndIf
		
	EndIf
	
	RestArea(a_Area)
	
Return c_Ret


Static Function ImpGrafPdf(	aCobranca		,nAbatim		,nAcrescim		,oPrint		,;
		aBMP			,aDadosEmp		,aDadosTit		,aDadosBanco,;
		aDatSacado		,aMsgBoleto		,CB_RN_NN		,aOpenMonth	,;
		aDependentes	,aObservacoes	,cCart			,cPrefixo	,;
		cTitulo			,cGrupoEmp 		,cMatric			,;
		c_Nome, c_Email , a_Anexo, l_Registrado )
	
	Local oFont8	// --?
	Local oFont10	// 	 |
	Local oFont11n	// 	 |
	Local oFont13	// 	 |
	Local oFont13n	// 	 |
	Local oFont15n	// 	 ? Fontes para impressao do relatorio grafico.
	Local oFont16	// 	 |
	Local oFont16n	// 	 |
	Local oFont21	// --?
	Local aCoords1 	:= {2000,1900,2100,2300}
	Local aCoords2 	:= {2270,1900,2340,2300}
	Local oBrush
	// 17 linha de extrato
	Local aLinhas	:= {}
	Local aLin1 	:= { 795, 840, 890, 940, 990, 1040, 1090, 1140, 1190, 1240 ,1290 ,1340 ,1390 ,1440 ,1490 ,1540 ,1590 }
	Local aLin2		:= { 795, 840, 890, 940, 990, 1040, 1090, 1140, 1190, 1240 ,1290 ,1340 ,1390 ,1440 ,1490 ,1540 ,1590,;
		1640,1690,1740,1790,1840,1890,1940, 1990, 2040, 2090 ,2140 ,2190 , 2240 , 2290 , 2340 ,2390 ,2440}
	
	Local nI		:= 0	// Contador do laco para impressao de dependentes.
	Local nMsg      := 0    // Contador para as mensagens
	Local cMoeda	:= "9"  // Moeda do boleto.
	Local nTamCorp	:= 1	// Tipo do corpo do extrato 1 = noraml 2 = Grande.
	Local nCob		:= 0	// Contador para for do extrato.
	Local lNovaPg	:= .F.	// Nova pagina. Controle de quebra do extrato.
	Local nLin		:= 1	// Linha atual da impressao
	
	Private c_Path	:= iIf( .F.,  AjuBarPath('\PDF_BOLETO\'), AjuBarPath('\PDF_BOLETO_LOTE\') )
	
	
	//Parâmetros de TFont.New()
	//1.Nome da Fonte (Windows)
	//3.Tamanho em Pixels
	//5.Bold (T/F)
	/*
	oFont8  := TFont():New("Arial",9,8 ,.T.,.F.,5,.T.,5,.T.,.F.)
	oFont10 := TFont():New("Arial",9,10,.T.,.T.,5,.T.,5,.T.,.F.)
	oFont11 := TFont():New("Courier",9,10,.T.,.T.,5,.T.,5,.T.,.F.)
	
	oFont11n:= TFont():New("Arial",9,11,.T.,.T.,5,.T.,5,.T.,.F.)
	
	oFont13 := TFont():New("Arial",9,13,.T.,.T.,5,.T.,5,.T.,.F.)
	oFont13n:= TFont():New("Arial",9,13,.T.,.F.,5,.T.,5,.T.,.F.)
	oFont15n:= TFont():New("Arial",9,15,.T.,.F.,5,.T.,5,.T.,.F.)
	oFont16 := TFont():New("Arial",9,16,.T.,.T.,5,.T.,5,.T.,.F.)
	oFont16n:= TFont():New("Arial",9,16,.T.,.F.,5,.T.,5,.T.,.F.)
	oFont21 := TFont():New("Arial",9,21,.T.,.T.,5,.T.,5,.T.,.F.)
	*/
	
	oFont8  := TFont():New("Arial",11,10 ,.T.,.F.,5,.T.,5,.T.,.F.)
	oFontx  := TFont():New("Arial",11,09 ,.T.,.F.,5,.T.,5,.T.,.F.)
	oFont10 := TFont():New("Arial",12,11,.T.,.T.,5,.T.,5,.T.,.F.)
	oFont11 := TFont():New("Courier",11,10,.T.,.T.,5,.T.,5,.T.,.F.)
	
	oFont11n:= TFont():New("Arial",10,12,.T.,.T.,5,.T.,5,.T.,.F.)
	
	oFont13 := TFont():New("Arial",10,15,.T.,.T.,5,.T.,5,.T.,.F.)
	oFont13n:= TFont():New("Arial",15,18,.T.,.F.,5,.T.,5,.T.,.F.)//
	oFont15n:= TFont():New("Arial",10,15,.T.,.F.,5,.T.,5,.T.,.F.)
	oFont16 := TFont():New("Arial",10,16,.T.,.T.,5,.T.,5,.T.,.F.)
	oFont16n:= TFont():New("Arial",10,16,.T.,.F.,5,.T.,5,.T.,.F.)
	oFont21 := TFont():New("Arial",10,21,.T.,.T.,5,.T.,5,.T.,.F.)
	
	oBrush := TBrush():New("",4)
	
	c_NomeArq := "boleto_" + aDadosTit[1]
	
	oPrint 	:= FwMsPrinter():New(c_NomeArq, IMP_PDF, l_AdjustToLegacy, c_Path, l_DisableSetup)// Ordem obrigátoria de configuração do relatório
	oPrint:SetMargin(15,15,15,15) //Define margens de impressão
	//oPrint:SetResolution(72)
	//oPrint:SetPortrait()
	//oPrint:SetPaperSize(DMPAPER_A4)
	oPrint:cPathPDF := c_Path
	
	oPrint:StartPage()   // Inicia uma nova página
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
	//³Analiza se sera necessario usar mais de um pagina... ?
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
	If Len(aCobranca) <= 17
		aLinhas 	:= aClone(aLin1)
		nTamCorp    := 1
	Else
		aLinhas 	:= aClone(aLin2)
		nTamCorp    := 2
		//	lNovaPg 	:= .T.
	Endif
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
	//³Imprime o cabecalho do boleto...               ?
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
	PDFHEADER(@oPrint,aDadosEmp,oFont8,oFont11n,oFont10,aBmp, aDadosTit, aDadosBanco, aDatSacado, aDependentes, aOPenMonth, oBrush, nTamCorp)
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
	//³Imprime detalhes do extratos com dados para cobranca.?
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
	nTotLin := 1590 //Ultima linha do extrato padrao. A partir desta linha sera adicionada + 50 pixeis e a
	//ficha de compensacao sera gerada em uma nova pagina.
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
	//³Imprime detalhes do extrato...                       ?
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
	
	For nCob := 1 To Len(aCobranca)
		If Iif(nTamCorp == 1, nLin > 17, nLin > 34)
			oPrint:EndPage()			// Finaliza a pagina
			oPrint:StartPage()			// Inicializo nova pagina
			
			nTamCorp := Iif(((Len(aCobranca)-nCob) <= 17), 1, 2)
			aLinhas	 := Iif(nTamCorp == 1, aClone(aLin1), aClone(aLin2) )
			
			PDFHEADER(@oPrint,aDadosEmp,oFont8,oFont11n,oFont10,aBmp, aDadosTit, aDadosBanco, aDatSacado, aDependentes, aOPenMonth, oBrush, nTamCorp)
			
			oPrint:Say (aLinhas[1]+15,0110 ,SubStr(Alltrim(aCobranca[nCob][1]),1,21),oFont8 )
			oPrint:Say (aLinhas[1]+15,0510 ,Substr(Alltrim(aCobranca[nCob][2]),1,30),oFont8 )
			oPrint:Say (aLinhas[1]+15,1060 ,Iif(Empty(aCobranca[nCob][3]),"",DtoC(StoD(aCobranca[nCob][3]))),oFont8 )
			oPrint:Say (aLinhas[1]+15,1260 ,SubStr(Alltrim(aCobranca[nCob][5])+"-"+aCobranca[nCob][6],1,30),oFont8 )
			oPrint:Say (aLinhas[1]+15,1810 ,Iif(Empty(aCobranca[nCob][11]),"",Trans(aCobranca[nCob][11], "@E 99,999.99")),oFont8 )
			oPrint:Say (aLinhas[1]+15,2110 ,Iif(Empty(aCobranca[nCob][7]),"",Trans(aCobranca[nCob][7], "@E 999,999.99")),oFont8 )
			
			
			
			nLin := 2
			
		Else
			
			oPrint:Say (aLinhas[nLin]+15,0110 ,SubStr(Alltrim(aCobranca[nCob][1]),1,21),oFont8 )
			oPrint:Say (aLinhas[nLin]+15,0510 ,Substr(Alltrim(aCobranca[nCob][2]),1,30),oFont8 )
			oPrint:Say (aLinhas[nLin]+15,1060 ,Iif(Empty(aCobranca[nCob][3]),"",DtoC(StoD(aCobranca[nCob][3]))),oFont8 )
			oPrint:Say (aLinhas[nLin]+15,1260 ,SubStr(Alltrim(aCobranca[nCob][5])+"-"+aCobranca[nCob][6],1,30),oFont8 )
			oPrint:Say (aLinhas[nLin]+15,1830 ,Iif(Empty(aCobranca[nCob][11]),"",Trans(aCobranca[nCob][11], "@E 99,999.99")),oFont8 )
			oPrint:Say (aLinhas[nLin]+15,2110 ,Iif(Empty(aCobranca[nCob][7]),"",Trans(aCobranca[nCob][7], "@E 999,999.99")),oFont8 )
			
			If nLin > 17
				
				lNovaPg := .T.
				
			EndIf
			
			nLin ++
		EndIf
	Next
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Caso tenha ocorrido a quebra de pagina emite a?
	//³ficha de compensacao em uma nova folha.       ?
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If lNovaPg
		oPrint:EndPage()			// Finaliza a pagina
		oPrint:StartPage()			// Inicializo nova pagina
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Imprime novo cabecalho de pagina?
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		PDFHEADER(@oPrint,aDadosEmp,oFont8,oFont11n,oFont10,aBmp, aDadosTit, aDadosBanco, aDatSacado, aDependentes, aOPenMonth, oBrush)
	EndIf
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Impressao da observacao.?
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	nMsg:=1625
	oPrint:Say  (1605,105,STR0014                ,oFont8 ) //"Observação"
	For nI := 1 To len(aObservacoes)
		oPrint:Say  (nMsg,105,aObservacoes[nI]        ,oFont11 )
		
		nMsg+=31
		If nI > 5
			Exit
		EndIf
	Next nI
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Emissao da ficha de compensacao.?
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	//Demonstrar vencimento e valor do titulo.
	//oPrint:FillRect(aCoords1,oBrush)
	//oPrint:FillRect(aCoords2,oBrush)
	
	oPrint:Line (2000,100,2000,2300)
	oPrint:Line (2000,550,1920,550 )
	oPrint:Line (2000,770,1920,770 )
	
	n_lin := 1934
	oPrint:Say  (n_lin + 28,100,Substr(aDadosBanco[2],1,14),oFont13n , , 2)
	oPrint:Say  (n_lin + 28,567,aDadosBanco[1]+"-"+Modulo11(aDadosBanco[1]),oFont21 , , 3)
	oPrint:Say  (n_lin + 28,790,CB_RN_NN[2],oFont13n, , 1)
	
	oPrint:Line (2100,100,2100,2300 )
	oPrint:Line (2200,100,2200,2300 )
	oPrint:Line (2270,100,2270,2300 )
	oPrint:Line (2340,100,2340,2300 )
	
	oPrint:Line (2200,500,2340,500)
	oPrint:Line (2270,750,2340,750)
	oPrint:Line (2200,1000,2340,1000)
	oPrint:Line (2200,1350,2270,1350)
	oPrint:Line (2200,1550,2340,1550)
	
	n_lin := n_lin + 85//2000
	oPrint:Say  (n_lin,100 ,STR0015                             ,oFont8) //"Local de Pagamento"
	
	//oPrint:Say  (n_lin + 40,100 ,"At?o vencimento, preferencialmente no Bradesco. Após o vencimento, somente no Bradesco"        ,oFont10) //"Qualquer banco at?a data do vencimento"
	oPrint:Say  (n_lin + 40,100 ,"Pagável preferencialmente na rede Bradesco ou no Bradesco Expresso."        ,oFont10) //"Qualquer banco at?a data do vencimento"
	
	oPrint:Say  (n_lin,1910,STR0008                                     ,oFont8) //"Vencimento"
	oPrint:Say  (n_lin + 40,2010,Substr(DTOS(aDadosTit[4]),7,2)+"/"+Substr(DTOS(aDadosTit[4]),5,2)+"/"+Substr(DTOS(aDadosTit[4]),1,4)  ,oFont10)
	
	n_lin := n_lin + 100
	
	oPrint:Say  (n_lin,100 ,STR0017                                        ,oFont8) //"Cedente"
	oPrint:Say  (n_lin + 40,100 ,aDadosEmp[1]                                     ,oFont10)
	
	oPrint:Say  (n_lin,1910,STR0012                         ,oFont8) //"Agência/Código Cedente"
	//oPrint:Say  (2140,2010,aDadosBanco[3]+"/"+aDadosBanco[4]+"-"+aDadosBanco[5],oFont10)
	oPrint:Say  (n_lin + 40,1950,aDadosBanco[3]+"/"+alltrim(aDadosBanco[4])+"-"+alltrim(aDadosBanco[5]),oFont10)
	
	n_lin := n_lin + 100
	
	oPrint:Say  (n_lin,100 ,STR0018                              ,oFont8) //"Data do Documento"
	oPrint:Say  (n_lin + 30,100 ,DTOC(aDadosTit[3])                               ,oFont10)
	
	oPrint:Say  (n_lin,505 ,STR0019                                  ,oFont8) //"Nro.Documento"
	oPrint:Say  (n_lin + 30,605 ,aDadosTit[1]                                     ,oFont10)
	
	oPrint:Say  (n_lin,1005,STR0020                                   ,oFont8) //"Espécie Doc."
	oPrint:Say  (n_lin + 30,1005,"  DM"                                      ,oFont10)   		&& 10/12/13 - Impressao Especie Documento
	
	oPrint:Say  (n_lin,1355,STR0021                                   ,oFont8) //"Aceite"
	oPrint:Say  (n_lin + 30,1455,"N"                                       ,oFont10)
	
	oPrint:Say  (n_lin,1555,STR0022                          ,oFont8) //"Data do Processamento"
	oPrint:Say  (n_lin + 30,1655,DTOC(aDadosTit[2])                               ,oFont10)
	
	oPrint:Say  (n_lin,1910,STR0013                                   ,oFont8) //"Nosso Número"
	//oPrint:Say  (2230,2010,cCart+"/"+aDadosTit[6]+"-"+U_Calc_DigCab(aDadosBanco[3]+aDadosBanco[4]+cCart+aDadosTit[6])                ,oFont10)
	
	//oPrint:Say  (2230,1950,cCart+"/"+aDadosTit[6]+"-"+U_Calc_DigCab(aDadosBanco[3]+aDadosBanco[4]+cCart+aDadosTit[6])                ,oFont10)		&& Vitor Sbano 05/12/13
	
	oPrint:Say  (n_lin + 30,1950,cCart+"/"+aDadosTit[6]+"-"+u_CalcDVBrad(substr(cCart,2,2)+aDadosTit[6])          ,oFont10)		&& Vitor Sbano 10/12/13
	
	n_lin := n_lin + 70
	
	// parei
	oPrint:Say  (n_lin,100 ,STR0023                                   ,oFont8) //"Uso do Banco"   //2270
	
	
	
	oPrint:Say  (n_lin,505 ,STR0024                                       ,oFont8) //"Carteira"
	oPrint:Say  (n_lin + 30,555 ,cCart                                   ,oFont10)
	
	oPrint:Say  (n_lin,755 ,STR0025                                        ,oFont8) //"Espécie"
	oPrint:Say  (n_lin + 30,805 ,STR0026                                             ,oFont10) //"R$"
	
	oPrint:Say  (n_lin,1005,STR0027                                     ,oFont8) //"Quantidade"
	oPrint:Say  (n_lin,1555,STR0028                                          ,oFont8) //"Valor"
	
	oPrint:Say  (n_lin,1910,STR0029                          ,oFont8) //"(=)Valor do Documento"
	oPrint:Say  (n_lin + 30,2010,AllTrim(Transform(aDadosTit[5],"@E 999,999,999.99")),oFont10)
	
	n_lin += n_lin + 120
	
	oPrint:Say  (n_lin,100 ,"Instruções (Todas as informações deste bloqueto são de exclusiva responsabilidade do cedente)",oFont8) //"Instruções/Texto de responsabilidade do cedente"
	
	nMsg:=2390
	For nI := 1 To len(aMsgBoleto)
		oPrint:Say  (nMsg,120,aMsgBoleto[nI]                ,oFont10 )
		nMsg+=50
		If nI > 6
			Exit
		EndIf
	Next nI
	
	oPrint:Say  (2360,1910,STR0031                         ,oFont8) //"(-)Desconto/Abatimento"
	oPrint:Say  (2390,2010,AllTrim(Transform(nAbatim,"@ZE 999,999,999.99")),oFont10)
	
	oPrint:Say  (2425,1910,STR0032                             ,oFont8) //"(-)Outras Deduções"
	oPrint:Say  (2500,1910,STR0033                                  ,oFont8) //"(+)Mora/Multa"
	oPrint:Say  (2570,1910,STR0034                           ,oFont8) //"(+)Outros Acréscimos"
	oPrint:Say  (2585,2010,AllTrim(Transform(nAcrescim,"@ZE 999,999,999.99")),oFont10)
	// oPrint:Say  (2240,2010,AllTrim(Transform(nAcrescim,"@ZE 999,999,999.99")),oFont10) // Marcela coimbra - Alterada Posição - Chamado GLPI 2813
	oPrint:Say  (2635,1910,STR0035                               ,oFont8) //"(-)Valor Cobrado"
	
	
	oPrint:Say  (2710,105 ,STR0036                                         ,oFont8) //"Sacado"
	oPrint:Say  (2720,400 ,aDatSacado[1]+" - CPF/CNPJ: " + aDatSacado[8]            ,oFont10)
	oPrint:Say  (2753,400 ,aDatSacado[3]                                    ,oFont10)
	oPrint:Say  (2786,400 ,aDatSacado[4]+" - "+aDatSacado[5]+" - "+aDatSacado[6] ,oFont10)
	oPrint:Say  (2819,400 ,Substr(aDatSacado[7],1,5) + "-" + Substr(aDatSacado[7],6,3)  ,oFont10)
	
	oPrint:Say  (2875,100 ,STR0037                               ,oFontx) //"Sacador/Avalista"
	oPrint:Say  (2910,1740,STR0038                               ,oFontX) //"Autenticação Mecânica -"
	oPrint:Say  (2910,1990,STR0039                               ,oFont10) //"Ficha de Compensação"
	
	oPrint:Line (2000,1900,2690,1900 )
	oPrint:Line (2410,1900,2410,2300 )
	oPrint:Line (2480,1900,2480,2300 )
	oPrint:Line (2550,1900,2550,2300 )
	oPrint:Line (2620,1900,2620,2300 )
	oPrint:Line (2690,100 ,2690,2300 )
	oPrint:Line (2885,100,2885,2300  )
	
	
	//MSBAR("INT25",36,1.5,CB_RN_NN[1],oPrint,.F.,Nil,Nil,0.025,1.2,Nil,Nil,"A",.F.)
	//MSBAR3("INT25",21.5,1,CB_RN_NN[1],oPrint,.F.,Nil,Nil,0.025,1.2,Nil,Nil,"A",.F.)
	cNmPrnTmp := UPPER(PrnGetName())
	cNomePrint := ""
	nCtNome := Len(Alltrim(cNmPrnTmp))
	
	While .T.
		If Substr(cNmPrnTmp,nCtNome,1) $ "\:"
			cNomePrint := Alltrim(Substr(cNmPrnTmp,nCtNome+1,Len(Alltrim(cNmPrnTmp))))
			nCtNome := 0
		Endif
		nCtNome--
		
		If nCtNome <= 0
			Exit
		Endif
	Enddo
	
	//junho 2009 tratar "lixo" no nome da printer - Motta
	nCtNome := Len(Alltrim(cNmPrnTmp))
	cNmPrnTmp := cNomePrint
	
	While .T.
		If Substr(cNmPrnTmp,nCtNome,1) $ "["
			cNomePrint := Alltrim(Substr(cNmPrnTmp,1,nCtNome-1))
			nCtNome := 0
		Endif
		nCtNome--
		
		If nCtNome <= 0
			Exit
		Endif
	Enddo
	
	c_NomeArq := "boleto_" + aDadosTit[1]
	//c_Path			:= '\PDF_BOLETO\'
	
	c_ArquivoPDF	:= oPrint:cPathPDF+ c_NomeArq + '.PDF'
	
	
	//Do case
	//	Case cNomePrint $ Upper(Alltrim(GetNewPar("MV_YPRINTP","4050_OPERACAO1"))) .or.;
		//	 cNomePrint $ Upper(Alltrim(GetNewPar("MV_YPRINT2"," "))) .OR.  ;
		//	  cNomePrint $ Upper(Alltrim(GetNewPar("MV_YPRINT3"," ")))
	
	
	// oPrint:FwMSBAR( "INT25",40,2,CB_RN_NN[1],oPrint,.F.,Nil,Nil,0.018,1.2,Nil,Nil,"A",.F. )
	
	oPrint:FwMSBAR( "INT25",68,2,CB_RN_NN[1],oPrint,.F.,Nil,Nil,0.025 ,1,Nil,Nil,"A",.F. )
	
	//		MSBAR3("INT25",25,1.5,CB_RN_NN[1],oPrint,.F.,Nil,Nil,0.028,1.2,Nil,Nil,"A",.F.,,,, 1) //4050
	
	// MSBAR3("INT25",25,1.5,CB_RN_NN[1],oPrint,.F.,Nil,Nil,0.025,1.2,Nil,Nil,"A",.F.) //4050
	//	OtherWise
	//		MSBAR3("INT25",12.6,1,CB_RN_NN[1],oPrint,.F.,Nil,Nil,0.025,1.2,Nil,Nil,"A",.F.) //SEATE2 - em testes (Jean - 05/12/07)
	//EndCase
	
	oPrint:EndPage() // Finaliza a página
	
	oPrint:lViewPDF := .F.
	
//Angelo Henrique - Teste Senha
		ShellExecute( "Open", "\\10.19.1.8\p12\bin\smartclient\printer.exe", "\PDF_BOLETO_LOTE\" + c_NomeArq + ".rel PDF_WITH_PASSWORD senhauser 123456","\PDF_BOLETO_LOTE", 1 )

	oPrint:Print()
	
	c_Dest := "  "
	c_Email := 	posicione("BA1", 2, xFilial("BA1") + '0001'+cGrupoEmp+cMatric+'00', "BA1_EMAIL")
	
	
	If l_Segunda
		
		aadd(a_Anexos, {'\PDF_BOLETO_LOTE\'+c_NomeArq + '.PDF', ;
			c_Email ,;
			'0001'+cGrupoEmp+cMatric+'00',;
			MesExtenso(val(R240Imp->E1_MESBASE))+"/"+R240Imp->E1_ANOBASE,;
			AllTrim(Transform(aDadosTit[5], "@E 999,999,999.99")),;
			c_Nome})
	EndIf
	
	If nTipCob == 4    .and. !l_Segunda
		
		//ParSX1Mail()
		
		c_Bar := replace(CB_RN_NN[2], '.', '')
		c_Bar := replace(c_Bar, ' ', '')
		 		
		If !Empty( c_Email )//c_Email
			
			u_fEnviaBol(MesExtenso(val(R240Imp->E1_MESBASE))+"/"+R240Imp->E1_ANOBASE, ;
				c_Nome,;
				DTOC(aDadosTit[4]), ;
				'0001'+cGrupoEmp+cMatric+'00',;
				"\HTML\BLT_LOTE.html" ,;
				'\PDF_BOLETO_LOTE\'+c_NomeArq + '.PDF',  ;
				AllTrim(Transform(aDadosTit[5], "@E 999,999,999.99")),;
				c_Bar,;
				c_Email,;
				R240Imp->e1_anobase+R240Imp->e1_mesbase,;
				R240Imp->E1_NUM,;
				l_Registrado)
			
		EndIf
		
	ElseIf nTipCob == 5
		
	EndIf
	
	//c_NomeArq := substr(c_NomeArq, 1, 16 )
	
	//c_Dest := "coimbra.marcela@gmail.com"
	
Return Nil

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ?
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±?
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±?
±±ºFuncao    ³R240HeaderºAutor  ³Rafael M. Quadrotti ?Data ? 03/11/04   º±?
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±?
±±ºDesc.     ³Emite um novo cabecalho devido a quebra de pagina.          º±?
±±?         ?                                                           º±?
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±?
±±ºUso       ?AP6 PLS                                                    º±?
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±?
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±?
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß?
*/
Static Function PDFHEADER(oPrint,aDadosEmp,oFont8,oFont11n,oFont10,aBitMap, aDadosTit, aDadosBanco, aDatSacado, aDependentes, aOPenMonth, oBrush, nTamCorp)
	Local ni
	Local oFontEx  := TFont():New("Arial",11,10 ,.T.,.F.,5,.T.,5,.T.,.F.)
	DEFAULT nTamCorp := 1
	
	oFontEx:Bold := .T.
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
	//³Dados da empresa....                                 ?
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
	
	oPrint:Say  (090	,500	,aDadosEmp[1] 	,oFont11n )
	oPrint:Say  (125	,500	,aDadosEmp[2]+"- "+aDadosEmp[3] 	,oFont8 )
	oPrint:Say  (160	,500	,aDadosEmp[4] 	,oFont8 )
	oPrint:Say  (195	,500	,aDadosEmp[5] 	,oFont8 )
	oPrint:Say  (230	,500	,aDadosEmp[6] 	,oFont8 )
	
	//ÚÄÄÄÄÄÄÄÄÄÄ¿
	//³Bmp da ANS?
	//ÀÄÄÄÄÄÄÄÄÄÄÙ
	If File(SuperGetMv("MV_PLSLANS", .F., "ANS.BMP"))
		oPrint:SayBitmap (060 ,1825,SuperGetMv("MV_PLSLANS", .F., "ANS.BMP"),470 ,150)
	Else
		oPrint:Say  (260,500,aDadosEmp[7] ,oFont10)
	Endif
	
	n_linha := 290
	oPrint:Say  (n_linha,1900,STR0044 + R240Imp->E1_MESBASE+" / "+R240Imp->E1_ANOBASE ,oFont10) //"Mês de competência: "
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
	//³Logo tipo da empresa...                              ?
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
	oPrint:SayBitmap (60 ,100,aBitMap[1],350 ,200 ) //coluna inicial / linha inical, bitmap,  coluna final / linha final.
	
	//Linhas do extrato.
	If nTamCorp = 1
		oPrint:Box  (300,100,1852,2300)
		oPrint:Line (375,0100,375,2303)
		oPrint:Line (650,0100,650,2303)
		
		oPrint:Line (300,0400,375,0400)// Linha divisória de colunas //Vencimento | Valor R$
		oPrint:Line (300,0800,375,0800)// Linha divisória de colunas //Valor R$   | Data de Emissão
		oPrint:Line (300,1150,650,1150)// Linha divisória de colunas //Data de Emissão | Nro. do Documento
		oPrint:Line (300,1500,375,1500)// Linha divisória de colunas //agência/Código | Nosso Número
		oPrint:Line (300,1900,650,1900)// Linha divisória de colunas //Vencimento | Valor R$
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
		//³Impressao das colunas do extrato de utilizacao.?
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
		oPrint:Line (710,100,710,2303) // Linha horizontal do cabecalho do extrato. // Extrato de utilizacao
		
		oPrint:Line (710,0500,1580,0500) // Linha divisória de colunas //usuario/prestador
		oPrint:Line (710,1050,1580,1050) // Linha divisória de colunas //prestador/data
		oPrint:Line (710,1250,1580,1250) // Linha divisória de colunas //data/lote
		//	oPrint:Line (750,1550,1625,1550) // Linha divisória de colunas //lote/nro guia
		oPrint:Line (710,1800,1580,1800) // Linha divisória de colunas //lote/nro guia
		oPrint:Line (710,2100,1580,2100) // Linha divisória de colunas //nro guia/vlr total
		
		oPrint:Line (745,0100,745,2303) // Linha horizontal do cabecalho do extrato.
		
		oPrint:Line  (1890,100,1890,2303)// Tracejado para destaque do boleto.
		oPrint:Line (1580,100,1580,2303)// Limite para observacao
		
	Else
		oPrint:Box  (300,0100,2470,2300)      //1852
		oPrint:Line (375,0100,0375,2303)
		oPrint:Line (650,0100,0650,2303)
		
		oPrint:Line (300,0400,375,0400)// Linha divisória de colunas //Vencimento | Valor R$
		oPrint:Line (300,0800,375,0800)// Linha divisória de colunas //Valor R$   | Data de Emissão
		oPrint:Line (300,1150,650,1150)// Linha divisória de colunas //Data de Emissão | Nro. do Documento
		oPrint:Line (300,1500,375,1500)// Linha divisória de colunas //agência/Código | Nosso Número
		oPrint:Line (300,1900,650,1900)// Linha divisória de colunas //Vencimento | Valor R$
		
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
		//³Impressao das colunas do extrato de utilizacao.?
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
		oPrint:Line (710,100,710,2303) // Linha horizontal do cabecalho do extrato. // Extrato de utilizacao
		
		oPrint:Line (710,0500,2470,0500) // Linha divisória de colunas //usuario/prestador
		oPrint:Line (710,1050,2470,1050) // Linha divisória de colunas //prestador/data
		oPrint:Line (710,1250,2470,1250) // Linha divisória de colunas //data/lote
		//	oPrint:Line (750,1550,2470,1550) // Linha divisória de colunas //lote/nro guia
		oPrint:Line (710,1800,2470,1800) // Linha divisória de colunas //lote/nro guia
		oPrint:Line (710,2100,2470,2100) // Linha divisória de colunas //nro guia/vlr total
		
		oPrint:Line (760,0100,760,2303) // Linha horizontal do cabecalho do extrato.
		
		
	Endif
	
	n_linha := n_linha + 30  //310
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
	//³Imprime os dados do cabecalho...               ?
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
	oPrint:Say  (n_linha,105,STR0008                   		,oFont8 ) //"Vencimento"
	oPrint:Say  (n_linha + 45 ,205,DTOC(aDadosTit[4])             ,oFont10)
	
	oPrint:Say  (n_linha,405,STR0009                     	,oFont8 ) //"Valor R$"
	oPrint:Say  (n_linha + 45,505,AllTrim(Transform(aDadosTit[5],"@E 999,999,999.99")),oFont10)
	
	oPrint:Say  (n_linha,805,STR0010             			,oFont8 ) //"Data de Emissão"
	oPrint:Say  (n_linha + 45,905,DTOC(aDadosTit[3])             ,oFont10)
	
	oPrint:Say  (n_linha,1155,STR0011            			,oFont8 ) //"Nro.do Documento"
	oPrint:Say  (n_linha + 45,1255,aDadosTit[1]                  ,oFont10)
	
	oPrint:Say  (n_linha,1505,STR0012      					,oFont8 ) //"Agência/Código Cedente"
	//oPrint:Say  (345,1555,aDadosBanco[3]+"/"+aDadosBanco[4]+"-"+aDadosBanco[5],oFont10)
	oPrint:Say  (n_linha + 45,1555,aDadosBanco[3]+"/"+alltrim(aDadosBanco[4])+"-"+alltrim(aDadosBanco[5]),oFont10)				&& 05/12/13 - Vitor Sbano
	
	oPrint:Say  (n_linha,1905,STR0013                		,oFont8 ) //"Nosso Numero"
	oPrint:Say  (n_linha + 45,1950,aDadosTit[6]                  ,oFont10)
	
	n_linha := n_linha + 100  //420
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Emissao dos dados do sacado.?
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	oPrint:Say  (n_linha,105 ,STR0004             					,oFont8 ) //"Dados do Sacado"
	oPrint:Say  (n_linha,1155 ,STR0005+Iif(BA3->BA3_TIPOUS == '1',(" ("+R240Imp->E1_CODINT+"."+R240Imp->E1_CODEMP+"."+R240Imp->E1_MATRIC+")"),"") ,oFont8 ) //"Usuários"
	oPrint:Say  (n_linha,1905 ,STR0007                  ,oFont8 ) //"Meses em aberto"
	
	oPrint:Say  (470,115 ,aDatSacado[1]+" ("+aDatSacado[2]+")"	,oFont10)
	oPrint:Say  (505,115 ,aDatSacado[3]                     	,oFont10)
	oPrint:Say  (540,115 ,aDatSacado[4]                      	,oFont10)
	oPrint:Say  (540,700 ,aDatSacado[5]+"   "+aDatSacado[6]	,oFont10)
	oPrint:Say  (575,115 ,Substr(aDatSacado[7],1,5) + "-" + Substr(aDatSacado[7],6,3) ,oFont10)
	
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
	//³Textos  das colunas do extrato de utilizacao.  ?
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
	
	n_linha := n_linha + 320  //300
	
	oPrint:Say  (n_linha,0110,STR0049      ,oFont8 )
	oPrint:Say  (n_linha,0510,STR0054      ,oFont8 )
	oPrint:Say  (n_linha,1060,STR0052      ,oFont8 )
	oPrint:Say  (n_linha,1260,"Descrição do serviço",oFont8 )
	oPrint:Say  (n_linha,1810,"Despesa    " ,oFont8 )
	oPrint:Say  (n_linha,2110,"A Pagar"      ,oFont8 )
	
	//oPrint:FillRect({705,100,750,2300},oBrush)
	oPrint:Say  (690,1040,STR0048      ,oFontEx ,,8) //21 = Len de "Extrato de utilizacao"  Calculo para centralizar //"Extrato de utilização"
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
	//³Em pessoa fisica, imprime os dependentes da familia..|
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
	
	nContLn := 400
	For nI := 1 To Len(aDependentes)
		If nI == 1
			oPrint:Say  (nContLn,1165 ,aDependentes[nI,1]+" - "+Alltrim(aDependentes[nI,2])+STR0006		      ,oFont8) //" (Titular)"
		Else
			oPrint:Say  (nContLn,1165 ,aDependentes[nI,1]+" - "+aDependentes[nI,2]			      ,oFont8)
		EndIf
		nContLn+=25
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Emite somente os 5 primeiros dependentes devido ao espaco no boleto.?
		//³Foi utilizado for e estrutura de array para facilitar a customizacao?
		//³para impressao de mais dependentes.								   ?
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If  nI > 9
			Exit
		EndIf
	Next nI
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
	//³Imprime os meses em aberto deste cliente/contrato... ?
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
	
	nContLn := 455
	nColuna := 1905
	For nI := 1 To Len(aOpenMonth)
		oPrint:Say  (nContLn,nColuna ,aOPenMonth[nI] ,oFont8)
		nContLn+=25
		
		//Alterna as colunas
		/*If nColuna == 1905
		nColuna := 1955
	ElseIf nColuna == 1955
		nColuna := 1905
	EndIf
	
	If nI > 18
		Exit
	EndIf aberto */
	
	if nI > 10
		Exit
	Endif
Next nI

Return .T.

User Function fEnviaBol(c_AnoMes, c_Nome, c_Vento, c_Matricula, c_Modelo, c_Anexo , c_Valor, c_CodBar, c_Email, c_Comp, c_NumTit, l_Registrado)
	**'---------------------------------------------------------------------'**
	Local cHtmlModelo  	:= " "
	Local cCodProcesso 	:= "000001"
	Local c_Assunto		:= " "
	Local c_ItGuias		:= " "
	Local c_ItApro		:= " "
	Local c_ItFin 		:= " "
	Local c_Html        := " "
	Local c_Empr		:= " "
	
	Local c_To			:= c_Email
	
	//	c_To := "coimbra.marcela@gmail.com;esther_csm@hotmail.com;carlos.santos@caberj.com.br;"//;esther_csm@hotmail.com;alanjpl@yahoo.com.br"
	//	c_To := "coimbra.marcela@gmail.com"//;esther_csm@hotmail.com;alanjpl@yahoo.com.br"
	//c_To := "coimbra.marcela@gmail.com;esther_csm@hotmail.com;alanjpl@yahoo.com.br"
	
	If l_Registrado
		cHtmlModelo  	:= c_Modelo
		c_Assunto		:= "Boleto Caberj Competência: "    + c_AnoMes
		
		oProcess := TWFProcess():New(cCodProcesso, c_Assunto)
		oProcess:NewTask(c_Assunto, cHtmlModelo)
		
		If Substr(c_Matricula,5,TAMSX3("BA1_CODEMP")[1]) <> "5007"
			
			c_Empr := "de sa&uacute;de"
			
		Else
			
			c_Empr := "odontol&oacute;gico"
			
		Endif
		
		oProcess:oHtml:ValByName( "c_Empresa" 	, c_Empr	)
		oProcess:oHtml:ValByName( "c_Nome" 		, c_Nome 	)
		oProcess:oHtml:ValByName( "c_AnoMes" 	, c_AnoMes 	)
		oProcess:oHtml:ValByName( "c_Vento" 	, c_Vento 	)
		oProcess:oHtml:ValByName( "c_Valor" 	, c_Valor 	)
		oProcess:oHtml:ValByName( "c_Matricula" , c_Matricula )
		oProcess:oHtml:ValByName( "c_CodBar" 	, c_CodBar 	)

		nRet := oProcess:AttachFile(c_Anexo)
		
		//	xRet := oProces	s:AttachFile(c_PDF)
		
		
		oProcess:cSubject := c_Assunto
		oProcess:cTo := c_To
		//oProcess:cBCC := "coimbra.marcela@gmail.com"
		
		cMailID := oProcess:Start("\workflow\boleto_lote")
		
		//c_Processo    := oProcess:fProcessID
		
		oProcess:Finish()
		
	EndIf
	c_Log := " insert into siga.log_envio_boleto_email  values ( "
	c_Log += " '" + iIf( cEmpAnt =='01', 'C', 'I' )     + "', "
	c_Log += " ' ', "
	c_Log += " '" + alltrim( dtos( date()))  + "', "
	c_Log += " '" + alltrim(time())        + "', "
	c_Log += " '" + AllTrim(c_Email) + "', "
	
	If !l_Registrado
		
		c_Log += " 'NAO'                  , "
		c_Log += " 'NAO REGISTRADO', "
		
		
	ElseIf empty(c_Email)
		
		c_Log += " 'NAO'                  , "
		c_Log += " 'EMAIL EM BRANCO', "
		
	Else
		
		c_Log += " 'SIM' ,"
		c_Log += " ' ', "
		
	EndIf
	
	
	
	c_Valor :=  replace(c_Valor, '.', '')
	c_Valor :=  replace(c_Valor, ',', '.')
	
	c_Log += "            '" + c_Comp + "', "
	c_Log += "            '" + c_NumTit + "', "
	c_Log += "            " +  replace(c_Valor, ',', '.')  +", "
	c_Log += "            '" + c_Vento + "', ' ', '" + c_Matricula + "') "
	
	TCSqlExec( c_Log )
	
	//	RESET ENVIRONMENT
	
	//	C:= 1 + AAAA
	
Return

