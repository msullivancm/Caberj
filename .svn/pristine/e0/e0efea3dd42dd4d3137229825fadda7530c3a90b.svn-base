#include "protheus.ch"
#include "topconn.ch"
#include "rwmake.ch"
#include "plsmger.ch"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ CABI0022  บAutor  ณ Fred O. C. Jr     บ Data ณ  25/06/21   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ   Carga de Tabelas Dinamicas de Eventos (TDE's)	  	      บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function CABI022()

Local cAlias	:= "ZRJ"
Local aCores	:= {{"ZRJ_STATUS == '0'", "BR_BRANCO"	},;
					{"ZRJ_STATUS == '1'", "BR_VERDE"	},;
					{"ZRJ_STATUS == '2'", "BR_AZUL"		},;
					{"ZRJ_STATUS == '3'", "BR_VERMELHO"	},;
					{"ZRJ_STATUS == '4'", "BR_PRETO"	}}

Private cCadastro := "Importa็ใo de Tab. Dinโmica de Eventos (TDE's)"
Private aRotina	:= {{OemToAnsi("Pesquisar")			, "AxPesqui"		,0, 1},;
					{OemToAnsi("Visualizar")		, "U_CABI022B"		,0, 2},;
					{OemToAnsi("Incluir")			, "U_CABI022B"		,0, 3},;
					{OemToAnsi("Alterar")			, "U_CABI022B"		,0, 4},;
					{OemToAnsi("Excluir")			, "U_CABI022B"		,0, 5},;
					{OemToAnsi("Efetivar Import.")	, "U_CABI022B"		,0, 6},;
					{OemToAnsi("Legenda")			, "U_CABI022A"		,0, 2}}

dbSelectArea(cAlias)
dbSetOrder(1)

mBrowse(6,1,22,75,cAlias,,,,,,aCores)

return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ CABI022A บAutor  ณ Fred O. C. Jr      บ Data ณ  25/06/21   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ     Legenda das cores da tela                              บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function CABI022A()

Local aCorDesc := {	{"BR_BRANCO"	, "Pendente Processamento"		},;
					{"BR_VERDE"		, "Importado com Sucesso" 		},;
					{"BR_AZUL"		, "Importado Parcialmente" 		},;
					{"BR_VERMELHO"	, "Erro na Importa็ใo" 			},;
					{"BR_PRETO"		, "Importa็ใo Excluํda"			}}

BrwLegenda( "Legenda: Importa็ใo das TDE's","Legenda", aCorDesc )

return .T.


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ CABI022B บ Autor ณ Fred O. C. Jr      บ Data ณ  25/06/21   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ     Visualiza็ใo / Altera็ใo / Inclusใo / Processamento    บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function CABI022B(cAlias, nReg, nOpc )

Local aArea			:= GetArea()
Local cLote			:= ""

Local aSize			:= MsAdvSize()
Local aObjects		:= {}
Local aInfo			:= {}
Local aPosObj		:= {}

Local oDlg
Local oEnchoice
Local nOpca			:= 0
Local bOK			:= {|| iif(Obrigatorio(oEnchoice:aGets,oEnchoice:aTela) .and. chkGrav(nOpc), nOpca := 1, nOpca := 2 ), iif(nOpca == 1, oDlg:End(), .F.) }
Local bCancel		:= {|| iif( nOpc == 3, RollBackSX8(), .T. ), oDlg:End() }

aAdd( aObjects, { 100, 100, .T., .T. } )

aInfo	:= { aSize[ 1 ], aSize[ 2 ], aSize[ 3 ], aSize[ 4 ], 3, 3 }
aPosObj	:= MsObjSize( aInfo, aObjects)

if nOpc == K_Incluir .or. nOpc == 3
	ZRJ->(RegToMemory("ZRJ",.T.))
else
	ZRJ->(RegToMemory("ZRJ",.F.))
endif

if nOpc == 4 .and. M->ZRJ_STATUS <> '0'	// S๓ posso alterar se status igual a 'pendente processamento'
	nOpc	:= 2
	Alert("A altera็ใo somente ้ possํvel para importa็๕es nใo processadas!")
endif

if nOpc == 5
	if M->ZRJ_STATUS == '4'				// S๓ posso excluir se jแ nใo estiver excluํdo
		nOpc	:= 2
		Alert("O processamento jแ foi excluํdo!")
	elseif M->ZRJ_TIPIMP == '3'				// nใo permitido excluir CBHPM
		nOpc	:= 2
		Alert("Nใo permitido a exclusใo de importa็๕es da CBHPM!")
	elseif M->ZRJ_STATUS == '3'			// Nใo import. (com erros)
		MsgInfo("O processamento nใo teve registros importados, o registro serแ excluํdo completamente (sem manuten็ใo de log).")
	elseif M->ZRJ_STATUS == '0'			// Nใo efetivado - deleto os registros
		MsgInfo("Como processamento ainda nใo foi efetivado, o registro serแ excluํdo completamente (sem manuten็ใo de log).")
	endif
endif

if nOpc == 6 .and. M->ZRJ_STATUS <> '0'	// S๓ posso importar se status igual a 'pendente processamento'
	nOpc	:= 2
	Alert("O processamento " + iif(M->ZRJ_STATUS == '4', "foi excluํdo!", "jแ foi importado!") )
endif

DEFINE MSDIALOG oDlg TITLE cCadastro FROM aSize[7],0 To aSize[6],aSize[5] of oMainWnd PIXEL

	oEnchoice := MsMGet():New(cAlias,nReg,nOpc,,,,,{aPosObj[1][1],aPosObj[1][2],aPosObj[1][3],aPosObj[1][4]},,,,,,oDlg,,,.F.)

ACTIVATE MSDIALOG oDlg CENTERED ON INIT Eval( { || EnChoiceBar(oDlg,bOK,bCancel,.F.,{}) })

if nOpca == 1

	if nOpc != K_Visualizar

		cLote		:= M->ZRJ_SEQUEN
		
		if nOpc == 3 .or. nOpc == 4			// Incluir ou Alterar

			PLUPTENC("ZRJ", nOpc)
			if nOpc == 3
				ZRJ->(ConfirmSX8())
			endif
		
		elseif nOpc == 5		// Excluir
		
			if M->ZRJ_STATUS == '0' .or. M->ZRJ_STATUS == '3'		// Ainda nใo efetivado ou erro no processamento
			
				PLUPTENC("ZRJ", nOpc)
			
			else						// Jแ importado / validar se pode excluir e efetuar
			
				CABI022C(cLote)
			
			endif
		
		elseif nOpc == 6		// Efetivar importa็ใo
		
			CABI022D(cLote)
		
		endif

	endif

endif

RestArea(aArea)

return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ CABI022C บAuthor ณ Fred O. C. Jr      บ Date ณ  25/06/21   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ  Efetuar o rollback (exclusใo da carga)		              บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUse       ณ                                                            บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function CABI022C(cLote)

Local cQuery	:= ""
Local cAliasQry	:= GetNextAlias()

// Validar se algum procedimento possui composi็๕es posteriores a da carga sendo excluํda
cQuery := " SELECT SUBSTR(BD4_CODTAB,5,3) as BD4_CODTAB, BD4_CDPADP, BD4_CODPRO, BD4_CODIGO, BD4_VIGINI, BD4_VIGFIM, BD4_VALREF"
cQuery += " FROM " + RetSQLName("BD4") + " BD4"
cQuery += " WHERE BD4.D_E_L_E_T_ = ' '"
cQuery +=	" AND BD4.BD4_XLOTE = '" + cLote + "'"
cQuery +=	" AND EXISTS (SELECT BDZ.BD4_FILIAL"
cQuery +=				" FROM " + RetSqlName("BD4") + " BDZ"
cQuery +=				" WHERE BDZ.D_E_L_E_T_ = ' '"
cQuery +=				  " AND BDZ.BD4_FILIAL = BD4.BD4_FILIAL"
cQuery +=				  " AND BDZ.BD4_CODTAB = BD4.BD4_CODTAB"
cQuery +=				  " AND BDZ.BD4_CDPADP = BD4.BD4_CDPADP"
cQuery +=				  " AND BDZ.BD4_CODPRO = BD4.BD4_CODPRO"
cQuery +=				  " AND BDZ.BD4_CODPRO = BD4.BD4_CODPRO"
cQuery +=				  " AND BDZ.BD4_VIGINI > BD4.BD4_VIGINI)"
cQuery += " ORDER BY BD4_FILIAL, BD4_CODTAB, BD4_CDPADP,BD4_CODPRO, BD4_CODIGO"

cQuery := ChangeQuery(cQuery)

TcQuery cQuery New Alias (cAliasQry)

if (cAliasQry)->(!EOF())

	if MsgYesNo("A exclusใo nใo foi permitida por existirem composi็๕es incluํdas posteriormente a importa็ใo deste lote." + CHR(13)+CHR(10) +;
				"Deseja gerar um log dos procedimentos nesta situa็ใo?")
	
		Processa({|| ImpLog(cAliasQry)}, "Aguarde...")
		
	endif

else

	(cAliasQry)->(DbCloseArea())
	
	cQuery := " SELECT SUBSTR(BD4_CODTAB,5,3) as BD4_CODTAB, BD4_CDPADP, BD4_CODPRO, BD4_CODIGO, BD4_VIGINI, BD4_VIGFIM,"
	cQuery +=	" BD4_VALREF, BD4.R_E_C_N_O_ as BD4REC"
	cQuery += " FROM " + RetSQLName("BD4") + " BD4"
	cQuery += " WHERE BD4.D_E_L_E_T_ = ' '"
	cQuery +=	" AND BD4.BD4_XLOTE = '" + cLote + "'"
	cQuery += " ORDER BY BD4_FILIAL, BD4_CODTAB, BD4_CDPADP, BD4_CODPRO, BD4_CODIGO"
	
	cQuery := ChangeQuery(cQuery)
	
	TcQuery cQuery New Alias (cAliasQry)
	
	if (cAliasQry)->(!EOF())
	
		if MsgYesNo("Deseja gerar um log das composi็๕es que serใo excluํdas?")
		
			Processa({|| ImpLog(cAliasQry)}, "Aguarde...")
		
		endif
		
		Processa({|| ExcImp(cAliasQry)}, "Aguarde...")
		
		MsgInfo("Exclusใo Efetuada com Sucesso!")
		
	else
		MsgInfo("Nใo existem composi็๕es vinculadas a este lote para serem excluํdas!")
	endif
	
endif
(cAliasQry)->(DbCloseArea())

return



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ ImpLog   บAuthor ณ Fred O. C. Jr      บ Date ณ  25/06/21   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ  Imprimir log de proced. impediram exclusใo			      บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUse       ณ                                                            บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function ImpLog(cAliasQry)

Local nTotSeq		:= 0
Local nContSq		:= 0
Local aHeader		:= {"TIPO TABELA", "TAB. HONORARIO", "COD. PROCEDIMENTO", "UN. MED. VALOR", "VALOR", "VIG. INICIAL", "VIG. FINAL"}

Local aAux			:= {}
Local nHdl			:= 0
Local cArq			:= ""

Local cPerg			:= "CABI022"

aAux	:= U_ImpCabXML(cPerg)
nHdl	:= aAux[1]
cArq	:= aAux[2]

if nHdl <> -1 .and. !empty(cArq)

	(cAliasQry)->(DbGoTop())
	while (cAliasQry)->(!EOF())
		nTotSeq++
		(cAliasQry)->(DbSkip())
	end
		
	ProcRegua(nTotSeq)

	U_ImpPriXML(nHdl, aHeader)
	
	(cAliasQry)->(DbGoTop())
	while (cAliasQry)->(!Eof())

		nContSq++
		IncProc("Processando..." + CHR(13)+CHR(10) + "Registro: " + AllTrim(Str(nContSq)) + " / " + AllTrim(Str(nTotSeq)) )
		
		// Inicio da Impressใo da linha
		cLinha := "<Row>" + CHR(13)+CHR(10)
		cLinha += U_ImpLinXML( (cAliasQry)->BD4_CDPADP					, 1)
		cLinha += U_ImpLinXML( (cAliasQry)->BD4_CODTAB					, 1)
		cLinha += U_ImpLinXML( (cAliasQry)->BD4_CODPRO					, 1)
		cLinha += U_ImpLinXML( (cAliasQry)->BD4_CODIGO					, 1)
		cLinha += U_ImpLinXML( (cAliasQry)->BD4_VALREF					, 2)
		cLinha += U_ImpLinXML( StoD((cAliasQry)->BD4_VIGINI)			, 3)
		cLinha += U_ImpLinXML( StoD((cAliasQry)->BD4_VIGFIM)			, 3)
		cLinha += '</Row>' + CHR(13)+CHR(10)
		
		FWRITE ( nHdl , cLinha )
		
		(cAliasQry)->(DbSkip())
	end
	
	cArq := U_ImpRodXML(nHdl, cArq)
	
	if ApOleClient("MsExcel")
	
        IncProc("Aguarde... Abrindo Excel")
        
        oExcelApp := MsExcel():New()
		oExcelApp:WorkBooks:Open(cArq)
		oExcelApp:SetVisible(.T.)
		oExcelApp:Destroy()
		
	else
		MsgStop("Microsoft Excel nใo instalado." + CHR(13)+CHR(10) + "Arquivo: " + cArq )
	endif

else
	MsgStop("O arquivo nใo pode ser criado!")
	return
endif

return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ ExcImp   บAuthor ณ Fred O. C. Jr      บ Date ณ  27/01/20   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ  Excluir procedimentos do lote						      บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUse       ณ                                                            บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function ExcImp(cAliasQry)

Local nTotSeq		:= 0
Local nContSq		:= 0
Local cChave		:= ""

(cAliasQry)->(DbGoTop())
while (cAliasQry)->(!EOF())
	nTotSeq++
	(cAliasQry)->(DbSkip())
end

ProcRegua(nTotSeq)

Begin Transaction

	(cAliasQry)->(DbGoTop())
	while (cAliasQry)->(!Eof())
	
		nContSq++
		IncProc("Processando..." + CHR(13)+CHR(10) + "Registro: " + AllTrim(Str(nContSq)) + " / " + AllTrim(Str(nTotSeq)) )
		
		BD4->(DbSetOrder(1))
		BD4->(DbGoTo( (cAliasQry)->BD4REC ))
		
		cChave := BD4->(BD4_FILIAL+BD4_CODTAB+BD4_CDPADP+BD4_CODPRO+BD4_CODIGO)
		
		BD4->(Reclock('BD4',.F.))
			BD4->(DbDelete())
		BD4->(MsUnlock())
		
		BD4->(DbSkip(-1))
		
		// Se registro anterior for referente ao mesmo procedimento - reabrir a vig๊ncia
		if cChave == BD4->(BD4_FILIAL+BD4_CODTAB+BD4_CDPADP+BD4_CODPRO+BD4_CODIGO)
		
			BD4->(Reclock('BD4',.F.))
				BD4->BD4_VIGFIM	:= StoD(" ")
			BD4->(MsUnlock())

			BA8->(DbSetOrder(1))	// BA8_FILIAL+BA8_CODTAB+BA8_CDPADP+BA8_CODPRO
			if BA8->(DbSeek( xFilial("BA8") + BD4->(BD4_CODTAB+BD4_CDPADP+BD4_CODPRO) ))

				BA8->(Reclock('BA8',.F.))
					BA8->BA8_XEDICA	:= BD4->BD4_YEDICA
				BA8->(MsUnlock())

			endif

		endif
		
		(cAliasQry)->(DbSkip())
	end
	
	ZRJ->(Reclock('ZRJ',.F.))
		ZRJ->ZRJ_STATUS	:= '4'			// Excluํda
		ZRJ->ZRJ_DTEXCL	:= date()
		ZRJ->ZRJ_HREXCL	:= time()
		ZRJ->ZRJ_USEXCL	:= StrTran(cUserName, "CABERJ\", "")
	ZRJ->(MsUnlock())

End Transaction

return



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ CABI022D บAuthor ณ Fred O. C. Jr      บ Date ณ  25/06/21   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ  Efetuar o importa็ใo da(s) TDE(s)					      บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUse       ณ                                                            บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function CABI022D(cLote)

Local aRet		:= {0, {}}
Local aArqAux	:= {}

ZRJ->(DbSetOrder(1))
if ZRJ->(DbSeek(xFilial("ZRJ") + cLote ))

	if ZRJ->ZRJ_STATUS == "0"		// pendente processamento
	
		aArqAux := Directory(AllTrim(ZRJ->ZRJ_ARQUIV))
		if len(aArqAux) > 0
		
			Begin Transaction
			
				if ZRJ->ZRJ_TIPIMP == '1'		// Simpro
				
					Processa({|| aRet := ImpSimp( AllTrim(ZRJ->ZRJ_ARQUIV) )}, "Aguarde...")
				
				elseif ZRJ->ZRJ_TIPIMP == '2'	// Brasindice
				
					Processa({|| aRet := ImpBras( AllTrim(ZRJ->ZRJ_ARQUIV) )}, "Aguarde...")
				
				elseif ZRJ->ZRJ_TIPIMP == '3'	// CBHPM
				
					Processa({|| aRet := ImpCBHPM( AllTrim(ZRJ->ZRJ_ARQUIV) )}, "Aguarde...")
				
				endif

				if val(aRet[1]) > 0		// Processamento executado

					ZRJ->(RecLock("ZRJ",.F.))
						ZRJ->ZRJ_STATUS := aRet[1]
						ZRJ->ZRJ_DTIMPO	:= date()
						ZRJ->ZRJ_HRIMPO	:= time()
						ZRJ->ZRJ_USIMPO	:= StrTran(cUserName, "CABERJ\", "")
					ZRJ->(MsUnlock())
					
					if aRet[1] == '1'
					
						MsgInfo("Importa็ใo finalizada com sucesso!")
					
					elseif len(aRet[2]) > 0
					
						if MsgYesNo("A importa็ใo foi finalizada, por้m " +;
									iif(aRet[1] == '2',	"alguns registros apresentaram problemas",;
														"nenhum registro foi importado") +;
									". Deseja gerar um log das inconsist๊ncias?")
							ImpLog2(aRet[2])
						endif
					
					endif
					
				endif

			End Transaction
		
		else
		
			Alert("O arquivo [ " + AllTrim(ZRJ->ZRJ_ARQUIV) + " ] informado para carregar na tabela [ " + ZRJ->ZRJ_CODTAB + " ] " +;
					"nใo foi localizado no referido diret๓rio. A importa็ใo serแ ignorada!")
		
		endif
		
	endif
	
endif

return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ ImpSimp  บAuthor ณ Fred O. C. Jr      บ Date ณ  25/06/21   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ  Importar procedimentos do SIMPRO					      บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUse       ณ                                                            บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function ImpSimp(cArquivo)

Local aRet		:= {}
Local lImpOK	:= .F.
Local nPos		:= 0
Local cAux		:= ""
Local aAux		:= {}
Local aRetNv	:= {}
Local aRtNv2	:= {}
Local _i		:= 0
Local nTabQtd	:= 0
Local nTbQtd2	:= 0
Local nHdl		:= 0
Local nTotSeq	:= 0
Local nContSq	:= 0
Local cBuffer	:= ""
Local cCodTUSS	:= ""
Local cCodTISS	:= ""
Local aCabec	:= {"CD_USUARIO", "CD_FRACAO",  "DESCRICAO",  "VIGENCIA",   "IDENTIF",    "PC_EM_FAB",  "PC_EM_VEN",  "PC_EM_USU", "PC_FR_FAB",;
					"PC_FR_VEN",  "PC_FR_USU",  "TP_EMBAL",   "TP_FRACAO",  "QTDE_EMBAL", "QTDE_FRAC",  "PERC_LUCR",  "TIP_ALT"  ,;
					"FABRICA",    "CD_SIMPRO",  "CD_MERCADO", "PERC_DESC",  "VLR_IPI",    "CD_REG_ANV", "DT_REG_ANV", "CD_BARRA" ,;
					"LISTA",      "HOSPITALAR", "FRACIONAR",  "CD_TUSS",    "CD_CLASSIF", "CD_REF_PRO", "GENERICO"  , "DIVERSOS" }

Local cCodPad	:= ZRJ->ZRJ_CODPAD
Local cCodTab	:= ZRJ->(ZRJ_CODOPE+ZRJ_CODTAB)
Local cCdPad2	:= ZRJ->ZRJ_CDPAD2
Local cCdTab2	:= ZRJ->(ZRJ_CODOPE+ZRJ_CDTAB2)

Local cCodPro	:= ""
Local cDesPro	:= ""
Local cNivel	:= ""
Local cAnaSin	:= ""
Local cNivel2	:= ""
Local cAnSin2	:= ""
Local nValRef	:= 0
Local cLabora	:= ""
Local dVigIni	:= ZRJ->ZRJ_DTPUBL
Local dVigFim	:= StoD("")
Local cAnvisa	:= ""
Local lErroCmp	:= .F.

nPos := AT(".CSV", Upper(cArquivo))
if nPos == 0
	Alert('A extensใo do arquivo [' + cArquivo + '] ้ invแlida. A mesma deve ser obrigatoriamente: CSV')
	aAdd(aRet, {0, 'A extensao do arquivo [' + cArquivo + '] e invalida. A mesma deve ser obrigatoriamente: CSV.'})
	return aRet
endif

// Preencher ANALITICO/SINTETICO e NIVEL de forma generica - Buscando atraves do Tipo de Tabela
BR4->(DbSetOrder(1))	// BR4_FILIAL + BR4_CODPAD + BR4_SEGMEN
if BR4->(DbSeek( xFilial("BR4") + ZRJ->ZRJ_CODPAD )) .and. !empty(ZRJ->ZRJ_CODPAD)

	cAux	:= BR4->BR4_CODPAD
	nPos	:= 1
	
	while !BR4->(EOF()) .and. BR4->BR4_CODPAD == ZRJ->ZRJ_CODPAD
	
		nTabQtd += val(BR4->BR4_DIGITO)
		
		if BR4->BR4_DIGVER <> "1"
			aAdd(aAux, {nPos, BR4->BR4_DIGITO, BR4->BR4_CODNIV})
			nPos += val(BR4->BR4_DIGITO)
		endif
		
		BR4->(DbSkip())
	end
	
	aAdd(aRetNv, {cAux, {} })
	for _i := len(aAux) to 1 step (-1)
		aAdd(aRetNv[len(aRetNv)][2], aAux[_i] )
	next

elseif !empty(ZRJ->ZRJ_CODPAD)
	Alert("Tipo de Tabela TUSS informado nใo localizado no Protheus!")
	aAdd(aRet, {0, 'Tipo de Tabela TUSS informado nao localizado no Protheus.'})
	return aRet
endif
// Fim da montagem da estrutura

// Preencher ANALITICO/SINTETICO e NIVEL de forma generica - Buscando atraves do Tipo de Tabela
BR4->(DbSetOrder(1))	// BR4_FILIAL + BR4_CODPAD + BR4_SEGMEN
if BR4->(DbSeek( xFilial("BR4") + ZRJ->ZRJ_CDPAD2 )) .and. !empty(ZRJ->ZRJ_CDPAD2)

	cAux	:= BR4->BR4_CODPAD
	nPos	:= 1
	aAux	:= {}
	
	while !BR4->(EOF()) .and. BR4->BR4_CODPAD == ZRJ->ZRJ_CDPAD2
	
		nTbQtd2 += val(BR4->BR4_DIGITO)
		
		if BR4->BR4_DIGVER <> "1"
			aAdd(aAux, {nPos, BR4->BR4_DIGITO, BR4->BR4_CODNIV})
			nPos += val(BR4->BR4_DIGITO)
		endif
		
		BR4->(DbSkip())
	end
	
	aAdd(aRtNv2, {cAux, {} })
	for _i := len(aAux) to 1 step (-1)
		aAdd(aRtNv2[len(aRtNv2)][2], aAux[_i] )
	next

elseif !empty(ZRJ->ZRJ_CDPAD2)
	Alert("Tipo de Tabela TISS informado nใo localizado no Protheus!")
	aAdd(aRet, {0, 'Tipo de Tabela TISS informado nao localizado no Protheus.'})
	return aRet
endif
// Fim da montagem da estrutura


nHdl	:= FT_FUse(cArquivo)

if nHdl <> -1

	nTotSeq	:= FT_FLastRec()	// Retorna o n๚mero de linhas do arquivo
	
	ProcRegua(nTotSeq)
	
	FT_FGoTop()
	while !FT_FEOF()
	
		nContSq++
		IncProc("Processando..." + CHR(13)+CHR(10) + "Registro: " + AllTrim(Str(nContSq)) + " / " + AllTrim(Str(nTotSeq)) )
		
		cBuffer	:= FT_FReadLn() // Retorna a linha corrente
		aAux	:= StrTokArr2 (cBuffer, ';', .T.)
		
		if len(aAux) == len(aCabec)

			// CD_MERCADO == '50' -> Medicamentos (nใo importar no SIMPRO)
			if AllTrim( aAux[ aScan( aCabec, {|x| AllTrim(x) == "CD_MERCADO"} ) ] ) == '50'
				Ft_FSkip()
				Loop
			
			// Regra 'importada' do CABI003 (importador existente na Caberj antes deste fonte)
			elseif AllTrim( Upper (aAux[ aScan( aCabec, {|x| AllTrim(x) == "IDENTIF"} ) ] ) ) $ "L|A|D"
				Ft_FSkip()
				Loop
			
			endif

			cCodTUSS	:= iif(!empty(ZRJ->ZRJ_CODPAD), AllTrim( aAux[ aScan( aCabec, {|x| AllTrim(x) == "CD_TUSS"  } ) ] ), "")
			cCodTISS	:= iif(!empty(ZRJ->ZRJ_CDPAD2), AllTrim( aAux[ aScan( aCabec, {|x| AllTrim(x) == "CD_SIMPRO"} ) ] ), "")

			// Validar se importa็ใo deve ocorrer com base no c๓digo do procedimento
			if !((!empty(ZRJ->ZRJ_CODPAD) .and. !empty(cCodTUSS)) .or. (!empty(ZRJ->ZRJ_CDPAD2) .and. !empty(cCodTISS)))
				Ft_FSkip()
				Loop
			endif

			// Garantir que tenha um c๓digo vแlido (TUSS)
			if !empty(ZRJ->ZRJ_CODPAD) .and. !empty(cCodTUSS) .and. (val(cCodTUSS) == 0 .or. len(cCodTUSS) <> nTabQtd)
				aAdd(aRet, {nContSq, 'O codigo TUSS do procedimento [' + cCodTUSS + '] invalido.'})
				cCodTUSS	:= ""
			endif

			// Garantir que tenha um c๓digo vแlido (TISS)
			if !empty(ZRJ->ZRJ_CDPAD2) .and. !empty(cCodTISS) .and. (val(cCodTISS) == 0 .or. len(cCodTISS) <> nTbQtd2)
				aAdd(aRet, {nContSq, 'O codigo TISS do procedimento [' + cCodTISS + '] invalido.'})
				cCodTISS	:= ""
			endif

			// Se c๓digo for invแlido (fora da mascara) eu zero... se ambos zerados (nใo tem o que importar)
			if empty(cCodTUSS) .and. empty(cCodTISS)
				Ft_FSkip()
				Loop
			else
				cCodPro	:= iif(!empty(cCodTUSS),cCodTUSS,cCodTISS)		// para log de processamento
			endif

			// tratar filtro de evento: ZRJ_FILEVE - 1=Dietas;2=Solucoes;3=Quimioterapicos;4=Monoclonais;5=Imunobiologicos;6=Demais
			if !empty(ZRJ->ZRJ_FILEVE)

				if !empty(cCodTUSS)

					BR8->(DbSetOrder(1))	// BR8_FILIAL+BR8_CODPAD+BR8_CODPSA+BR8_ANASIN
					if BR8->(DbSeek( xFilial("BR8") + cCodPad + cCodTUSS ))
						if	(!empty(BR8->BR8_XTPEVE) .and. !(BR8->BR8_XTPEVE $ ZRJ->ZRJ_FILEVE)) .or.;
							(empty(BR8->BR8_XTPEVE)  .and. !('6' $ ZRJ->ZRJ_FILEVE))
							cCodTUSS	:= ""		// nใo importar
						endif
					elseif !('6' $ ZRJ->ZRJ_FILEVE)	// se nใo contem de 'outros proced.' (s๓ especifico) - nใo importar
						cCodTUSS		:= ""
					endif

				endif

				if !empty(cCodTISS)

					BR8->(DbSetOrder(1))	// BR8_FILIAL+BR8_CODPAD+BR8_CODPSA+BR8_ANASIN
					if BR8->(DbSeek( xFilial("BR8") + cCdPad2 + cCodTISS ))
						if	(!empty(BR8->BR8_XTPEVE) .and. !(BR8->BR8_XTPEVE $ ZRJ->ZRJ_FILEVE)) .or.;
							(empty(BR8->BR8_XTPEVE)  .and. !('6' $ ZRJ->ZRJ_FILEVE))
							cCodTISS	:= ""		// nใo importar
						endif
					elseif !('6' $ ZRJ->ZRJ_FILEVE)	// se nใo contem de 'outros proced.' (s๓ especifico) - nใo importar
						cCodTUSS		:= ""
					endif

				endif

				if empty(cCodTUSS) .and. empty(cCodTISS)
					Ft_FSkip()
					Loop
				else
					cCodPro	:= iif(!empty(cCodTUSS),cCodTUSS,cCodTISS)		// para log de processamento
				endif

			endif

			cDesPro	:= Upper( AllTrim( aAux[ aScan( aCabec, {|x| AllTrim(x) == "DESCRICAO"} ) ] ) )

			if empty(cDesPro)
				aAdd(aRet, {nContSq, 'A descricao do procedimento [' + cCodPro + '] esta em branco.'})
				Ft_FSkip()
				Loop
			endif
			
			cLabora	:= Upper( AllTrim( aAux[ aScan( aCabec, {|x| AllTrim(x) == "FABRICA"  } ) ] ) )
			cAnvisa := AllTrim( aAux[ aScan( aCabec, {|x| AllTrim(x) == "CD_REG_ANV"  } ) ] )

			// Busca de nivel de forma automatica (TUSS)
			nPos := aScan( aRetNv,{|x| x[1] == cCodPad } )
			if nPos <> 0
				for _i := 1 to len(aRetNv[nPos][2])
					if SubStr( cCodTUSS, aRetNv[nPos][2][_i][1], val(aRetNv[nPos][2][_i][2]) ) <> Replicate("0", val(aRetNv[nPos][2][_i][2]) )
						cNivel	:= aRetNv[nPos][2][_i][3]
						cAnaSin	:= iif(cNivel == aRetNv[nPos][2][1][3], "1", "2")
						exit
					endif
				next
			endif

			// Busca de nivel de forma automatica (TISS)
			nPos := aScan( aRtNv2,{|x| x[1] == cCdPad2 } )
			if nPos <> 0
				for _i := 1 to len(aRtNv2[nPos][2])
					if SubStr( cCodTISS, aRtNv2[nPos][2][_i][1], val(aRtNv2[nPos][2][_i][2]) ) <> Replicate("0", val(aRtNv2[nPos][2][_i][2]) )
						cNivel2	:= aRtNv2[nPos][2][_i][3]
						cAnSin2	:= iif(cNivel2 == aRtNv2[nPos][2][1][3], "1", "2")
						exit
					endif
				next
			endif

			// Identificar o valor de referencia da composi็ใo
			// Importa็ใo SIMPRO nใo considera Pre็o M้dio ao Consumidor, serแ sempre Pre็o de Fแbrica

			// Regra: (base CABI002) - Quando o IDENTIF estiver com o conte๚do 'V' ou 'F'
			// considerar o valor da caluna PC_FR_FAB, se este campo for zero, considerar o campo PC_EM_FAB
			if AllTrim( Upper (aAux[ aScan( aCabec, {|x| AllTrim(x) == "IDENTIF"} ) ] ) ) $ "V|F"
				nValRef	:= val( aAux[ aScan( aCabec, {|x| AllTrim(x) == "PC_FR_FAB"} ) ] ) / 100
				if nValRef == 0
					nValRef	:= val( aAux[ aScan( aCabec, {|x| AllTrim(x) == "PC_EM_FAB"} ) ] ) / 100
				endif
			endif

			// Regra de tabelas distintas para fracionados e embalagem nใo se aplica na Caberj
			/*
			nValRef	:= val( aAux[ aScan( aCabec, {|x| AllTrim(x) == "PC_EM_FAB"} ) ] ) / 100
			if ZRJ->ZRJ_EMBFRA == '2' .and. AllTrim( aAux[ aScan( aCabec, {|x| AllTrim(x) == "FRACIONAR"} ) ] ) == 'S'
				nValRef	:= nValRef / ( val( aAux[ aScan( aCabec, {|x| AllTrim(x) == "QTDE_EMBAL"} ) ] ) / 100 )
			endif
			*/
			
			if nValRef == 0
				aAdd(aRet, {nContSq, 'O valor de referencia do procedimento [' + cCodPro + '] esta zerado.'})
				Ft_FSkip()
				Loop
			endif
			
			cAux	:= AllTrim( aAux[ aScan( aCabec, {|x| AllTrim(x) == "VIGENCIA"} ) ] )
			dVigIni	:= iif( empty(cAux), ZRJ->ZRJ_DTPUBL, StoD( SubStr(cAux,5,4) + SubStr(cAux,3,2) + SubStr(cAux,1,2) ) )

			// data fim de vig๊ncia acrescido de 1825 dias (5 x 365 dias) -> 5 anos
			cAux	:= AllTrim( aAux[ aScan( aCabec, {|x| AllTrim(x) == "DT_REG_ANV"} ) ] )
			dVigFim	:= iif( val(cAux) <> 0, StoD( SubStr(cAux,5,4) + SubStr(cAux,3,2) + SubStr(cAux,1,2) ) + 1825, StoD("") )
			
			if !empty(cCodTUSS)

				// Rotina para a grava็ใo do procedimento na TDE (BA8), replica็ใo na Tab. Padrใo (BR8) e Terminologia (BTQ e BTU)
				AtuProc(cCodPad, cCodTab, cCodTUSS, cDesPro, cAnaSin, cNivel, cLabora, dVigIni, dVigFim, cAnvisa)
				
				// Grava็ใo da composi็ใo (BD4)
				lErroCmp	:= CriaComp(cCodPad, cCodTab, cCodTUSS, dVigIni, dVigFim, nValRef)

				if lErroCmp
					aAdd(aRet, {nContSq, 'A data de inicio da vigencia do procedimento TUSS: [' + cCodTUSS + '] e menor ou igual que a atualmente no cadastro.'})
				else
					lImpOK	:= .T.
				endif

			endif

			if !empty(cCodTISS)

				// Rotina para a grava็ใo do procedimento na TDE (BA8), replica็ใo na Tab. Padrใo (BR8) e Terminologia (BTQ e BTU)
				AtuProc(cCdPad2, cCdTab2, cCodTISS, cDesPro, cAnSin2, cNivel2, cLabora, dVigIni, dVigFim, cAnvisa)
				
				// Grava็ใo da composi็ใo (BD4)
				lErroCmp	:= CriaComp(cCdPad2, cCdTab2, cCodTISS, dVigIni, dVigFim, nValRef)

				if lErroCmp
					aAdd(aRet, {nContSq, 'A data de inicio da vigencia do procedimento TISS: [' + cCodTISS + '] e menor ou igual que a atualmente no cadastro.'})
				else
					lImpOK	:= .T.
				endif

			endif
			
		else
			aAdd(aRet, {nContSq, 'Esta linha nao esta de acordo com o layout de importacao do SIMPRO.'})
		endif
		
		FT_FSkip()	// Pula para pr๓xima linha
	end
	
	FT_FUse()

else
	alert("Erro na abertura do arquivo. Verifique se o mesmo nใo se encontra aberto. Processamento nใo foi possํvel!")
	aAdd(aRet, {0, 'Erro na abertura do arquivo para importacao.'})
endif

if len(aRet) == 0 .and. lImpOK
	aRet	:= {'1', {}}
elseif len(aRet) == 0 .and. !lImpOK
	aAdd(aRet, {0, 'Nenhum registro no arquivo para importacao.'})
	aRet	:= {'3', aRet}
elseif len(aRet) > 0 .and. lImpOK
	aRet	:= {'2', aRet}
else
	aRet	:= {'3', aRet}
endif

return aRet


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ ImpBras  บAuthor ณ Fred O. C. Jr      บ Date ณ  25/06/21   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ  Importar procedimentos do Brasindice				      บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUse       ณ                                                            บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function ImpBras(cArquivo)

Local aRet		:= {}
Local lImpOK	:= .F.
Local nPos		:= 0
Local cAux		:= ""
Local aAux		:= {}
Local aRetNv	:= {}
Local aRtNv2	:= {}
Local _i		:= 0
Local nTabQtd	:= 0
Local nTbQtd2	:= 0
Local nHdl		:= 0
Local nTotSeq	:= 0
Local nContSq	:= 0
Local cBuffer	:= ""
Local cCodTUSS	:= ""
Local cCodTISS	:= ""
Local aCabec	:= {{1,	{	"COD_LABOR",  "NOME_LABOR", "COD_PROCED", "NOME_PROCED", "COD_APRES",  "NOME_APRES"	,;		// Material
							"PRECO_PROC", "QTD_FRAC",   "TP_PRECO",   "VLR_FRAC",    "EDIC_VALOR", "IPI_PROC"  	,;
							"PIS_COFINS", "COD_TISS",   "COD_TUSS"												}},;
					{2,{	"COD_LABOR",  "NOME_LABOR", "COD_PROCED", "NOME_PROCED", "COD_APRES",  "NOME_APRES"	,;		// Medicamento
							"PRECO_PROC", "QTD_FRAC",   "TP_PRECO",   "VLR_FRAC",    "EDIC_VALOR", "IPI_PROC"  	,;
							"PIS_COFINS", "COD_EAN",    "COD_TISS",   "GENERIC",     "COD_TUSS"					}},;
					{3,	{	"COD_LABOR",  "NOME_LABOR", "COD_PROCED", "NOME_PROCED", "COD_APRES",  "NOME_APRES"	,;		// Solu็ใo
							"PRECO_PROC", "QTD_FRAC",   "TP_PRECO",   "VLR_FRAC",    "EDIC_VALOR", "IPI_PROC"  	,;
							"PIS_COFINS", "COD_EAN",    "COD_TISS",   "COD_TUSS"								}} }
Local nTpCab	:= 0
Local cTpPreco	:= ""

Local cCodPad	:= ZRJ->ZRJ_CODPAD
Local cCodTab	:= ZRJ->(ZRJ_CODOPE+ZRJ_CODTAB)
Local cCdPad2	:= ZRJ->ZRJ_CDPAD2
Local cCdTab2	:= ZRJ->(ZRJ_CODOPE+ZRJ_CDTAB2)

Local cCodPro	:= ""
Local cDesPro	:= ""
Local cAprese	:= ""
Local cNivel	:= ""
Local cAnaSin	:= ""
Local cNivel2	:= ""
Local cAnSin2	:= ""
Local nValRef	:= 0
Local cLabora	:= ""
Local dVigIni	:= ZRJ->ZRJ_DTPUBL
Local dVigFim	:= StoD("")
Local cEdicao	:= ""
Local cAnvisa	:= ""
Local lErroCmp	:= .F.

nPos := AT(".TXT", Upper(cArquivo))
if nPos == 0
	Alert('A extensใo do arquivo [' + cArquivo + '] ้ invแlida. A mesma deve ser obrigatoriamente: TXT')
	aAdd(aRet, {0, 'A extensao do arquivo [' + cArquivo + '] e invalida. A mesma deve ser obrigatoriamente: TXT.'})
	return aRet
endif

// Preencher ANALITICO/SINTETICO e NIVEL de forma generica - Buscando atraves do Tipo de Tabela
BR4->(DbSetOrder(1))	// BR4_FILIAL + BR4_CODPAD + BR4_SEGMEN
if BR4->(DbSeek( xFilial("BR4") + ZRJ->ZRJ_CODPAD )) .and. !empty(ZRJ->ZRJ_CODPAD)

	cAux	:= BR4->BR4_CODPAD
	nPos	:= 1
	
	while !BR4->(EOF()) .and. BR4->BR4_CODPAD == ZRJ->ZRJ_CODPAD
	
		nTabQtd += val(BR4->BR4_DIGITO)
		
		if BR4->BR4_DIGVER <> "1"
			aAdd(aAux, {nPos, BR4->BR4_DIGITO, BR4->BR4_CODNIV})
			nPos += val(BR4->BR4_DIGITO)
		endif
		
		BR4->(DbSkip())
	end
	
	aAdd(aRetNv, {cAux, {} })
	for _i := len(aAux) to 1 step (-1)
		aAdd(aRetNv[len(aRetNv)][2], aAux[_i] )
	next

elseif !empty(ZRJ->ZRJ_CODPAD)
	Alert("Tipo de Tabela TUSS informado nใo localizado no Protheus!")
	aAdd(aRet, {0, 'Tipo de Tabela TUSS informado nao localizado no Protheus.'})
	return aRet
endif
// Fim da montagem da estrutura

// Preencher ANALITICO/SINTETICO e NIVEL de forma generica - Buscando atraves do Tipo de Tabela
BR4->(DbSetOrder(1))	// BR4_FILIAL + BR4_CODPAD + BR4_SEGMEN
if BR4->(DbSeek( xFilial("BR4") + ZRJ->ZRJ_CDPAD2 )) .and. !empty(ZRJ->ZRJ_CDPAD2)

	cAux	:= BR4->BR4_CODPAD
	nPos	:= 1
	aAux	:= {}
	
	while !BR4->(EOF()) .and. BR4->BR4_CODPAD == ZRJ->ZRJ_CDPAD2
	
		nTbQtd2 += val(BR4->BR4_DIGITO)
		
		if BR4->BR4_DIGVER <> "1"
			aAdd(aAux, {nPos, BR4->BR4_DIGITO, BR4->BR4_CODNIV})
			nPos += val(BR4->BR4_DIGITO)
		endif
		
		BR4->(DbSkip())
	end
	
	aAdd(aRtNv2, {cAux, {} })
	for _i := len(aAux) to 1 step (-1)
		aAdd(aRtNv2[len(aRtNv2)][2], aAux[_i] )
	next

elseif !empty(ZRJ->ZRJ_CDPAD2)
	Alert("Tipo de Tabela TISS informado nใo localizado no Protheus!")
	aAdd(aRet, {0, 'Tipo de Tabela TISS informado nao localizado no Protheus.'})
	return aRet
endif
// Fim da montagem da estrutura

nTpCab := val(ZRJ->ZRJ_TIPEVE)
if nTpCab < 1 .or. nTpCab > 3
	Alert("Tipo de Procedimento nใo informado!")
	aAdd(aRet, {0, 'Tipo de Procedimento nao informado.'})
	return aRet
endif

nHdl	:= FT_FUse(cArquivo)

if nHdl <> -1

	nTotSeq	:= FT_FLastRec()	// Retorna o n๚mero de linhas do arquivo
	
	ProcRegua(nTotSeq)
	
	FT_FGoTop()
	while !FT_FEOF()
	
		nContSq++
		IncProc("Processando..." + CHR(13)+CHR(10) + "Registro: " + AllTrim(Str(nContSq)) + " / " + AllTrim(Str(nTotSeq)) )
		
		cBuffer	:= FT_FReadLn() // Retorna a linha corrente
		
		cBuffer	:= SubStr(cBuffer, 2, len(cBuffer)-2)
		aAux	:= StrTokArr2 (cBuffer, '","', .T.)
		
		if len(aAux) == len(aCabec[nTpCab][2])
		
			cCodTUSS	:= iif(!empty(ZRJ->ZRJ_CODPAD), AllTrim( aAux[ aScan( aCabec[nTpCab][2], {|x| AllTrim(x) == "COD_TUSS"} ) ] ), "")
			cCodTISS	:= iif(!empty(ZRJ->ZRJ_CDPAD2), AllTrim( aAux[ aScan( aCabec[nTpCab][2], {|x| AllTrim(x) == "COD_TISS"} ) ] ), "")

			// Validar se importa็ใo deve ocorrer com base no c๓digo do procedimento
			if !((!empty(ZRJ->ZRJ_CODPAD) .and. !empty(cCodTUSS)) .or. (!empty(ZRJ->ZRJ_CDPAD2) .and. !empty(cCodTISS)))
				Ft_FSkip()
				Loop
			endif

			// Garantir que tenha um c๓digo vแlido (TUSS)
			if !empty(ZRJ->ZRJ_CODPAD) .and. !empty(cCodTUSS) .and. (val(cCodTUSS) == 0 .or. len(cCodTUSS) <> nTabQtd)
				aAdd(aRet, {nContSq, 'O codigo TUSS do procedimento [' + cCodTUSS + '] invalido.'})
				cCodTUSS	:= ""
			endif

			// Garantir que tenha um c๓digo vแlido (TISS)
			if !empty(ZRJ->ZRJ_CDPAD2) .and. !empty(cCodTISS) .and. (val(cCodTISS) == 0 .or. len(cCodTISS) <> nTbQtd2)
				aAdd(aRet, {nContSq, 'O codigo TISS do procedimento [' + cCodTISS + '] invalido.'})
				cCodTISS	:= ""
			endif

			// Se c๓digo for invแlido (fora da mascara) eu zero... se ambos zerados (nใo tem o que importar)
			if empty(cCodTUSS) .and. empty(cCodTISS)
				Ft_FSkip()
				Loop
			else
				cCodPro	:= iif(!empty(cCodTUSS),cCodTUSS,cCodTISS)		// para log de processamento
			endif

			// tratar filtro de evento: ZRJ_FILEVE - 1=Dietas;2=Solucoes;3=Quimioterapicos;4=Monoclonais;5=Imunobiologicos;6=Demais
			if !empty(ZRJ->ZRJ_FILEVE)

				if !empty(cCodTUSS)

					BR8->(DbSetOrder(1))	// BR8_FILIAL+BR8_CODPAD+BR8_CODPSA+BR8_ANASIN
					if BR8->(DbSeek( xFilial("BR8") + cCodPad + cCodTUSS ))
						if	(!empty(BR8->BR8_XTPEVE) .and. !(BR8->BR8_XTPEVE $ ZRJ->ZRJ_FILEVE)) .or.;
							(empty(BR8->BR8_XTPEVE)  .and. !('6' $ ZRJ->ZRJ_FILEVE))
							cCodTUSS	:= ""		// nใo importar
						endif
					elseif !('6' $ ZRJ->ZRJ_FILEVE)	// se nใo contem de 'outros proced.' (s๓ especifico) - nใo importar
						cCodTUSS		:= ""
					endif

				endif

				if !empty(cCodTISS)

					BR8->(DbSetOrder(1))	// BR8_FILIAL+BR8_CODPAD+BR8_CODPSA+BR8_ANASIN
					if BR8->(DbSeek( xFilial("BR8") + cCdPad2 + cCodTISS ))
						if	(!empty(BR8->BR8_XTPEVE) .and. !(BR8->BR8_XTPEVE $ ZRJ->ZRJ_FILEVE)) .or.;
							(empty(BR8->BR8_XTPEVE)  .and. !('6' $ ZRJ->ZRJ_FILEVE))
							cCodTISS	:= ""		// nใo importar
						endif
					elseif !('6' $ ZRJ->ZRJ_FILEVE)	// se nใo contem de 'outros proced.' (s๓ especifico) - nใo importar
						cCodTUSS		:= ""
					endif

				endif

				if empty(cCodTUSS) .and. empty(cCodTISS)
					Ft_FSkip()
					Loop
				else
					cCodPro	:= iif(!empty(cCodTUSS),cCodTUSS,cCodTISS)		// para log de processamento
				endif

			endif

			cDesPro	:= Upper( AllTrim( aAux[ aScan( aCabec[nTpCab][2], {|x| AllTrim(x) == "NOME_PROCED"} ) ] ) )

			if empty(cDesPro)
				aAdd(aRet, {nContSq, 'A descricao do procedimento [' + cCodPro + '] esta em branco.'})
				Ft_FSkip()
				Loop
			endif

			cAprese	:= Upper( AllTrim( aAux[ aScan( aCabec[nTpCab][2], {|x| AllTrim(x) == "NOME_APRES" } ) ] ) )
			cLabora	:= Upper( AllTrim( aAux[ aScan( aCabec[nTpCab][2], {|x| AllTrim(x) == "NOME_LABOR" } ) ] ) )
			cEdicao	:= aAux[ aScan( aCabec[nTpCab][2], {|x| AllTrim(x) == "EDIC_VALOR"  } ) ]
			
			// Busca de nivel de forma automatica (TUSS)
			nPos := aScan( aRetNv,{|x| x[1] == cCodPad } )
			if nPos <> 0
				for _i := 1 to len(aRetNv[nPos][2])
					if SubStr( cCodTUSS, aRetNv[nPos][2][_i][1], val(aRetNv[nPos][2][_i][2]) ) <> Replicate("0", val(aRetNv[nPos][2][_i][2]) )
						cNivel	:= aRetNv[nPos][2][_i][3]
						cAnaSin	:= iif(cNivel == aRetNv[nPos][2][1][3], "1", "2")
						exit
					endif
				next
			endif

			// Busca de nivel de forma automatica (TISS)
			nPos := aScan( aRtNv2,{|x| x[1] == cCdPad2 } )
			if nPos <> 0
				for _i := 1 to len(aRtNv2[nPos][2])
					if SubStr( cCodTISS, aRtNv2[nPos][2][_i][1], val(aRtNv2[nPos][2][_i][2]) ) <> Replicate("0", val(aRtNv2[nPos][2][_i][2]) )
						cNivel2	:= aRtNv2[nPos][2][_i][3]
						cAnSin2	:= iif(cNivel2 == aRtNv2[nPos][2][1][3], "1", "2")
						exit
					endif
				next
			endif

			cTpPreco := AllTrim( aAux[ aScan( aCabec[nTpCab][2], {|x| AllTrim(x) == "TP_PRECO" } ) ] )
			if ZRJ->ZRJ_TPPREC <> '3'

				if cTpPreco == "PFB" .and. ZRJ->ZRJ_TPPREC <> '1'
					aAdd(aRet, {nContSq, 'Parametrizou a carga para PMC, mas o procedimento [' + cCodPro + '] esta informado como PFB.'})
					Ft_FSkip()
					Loop
				elseif cTpPreco == "PMC" .and. ZRJ->ZRJ_TPPREC <> '2'
					aAdd(aRet, {nContSq, 'Parametrizou a carga para PFB, mas o procedimento [' + cCodPro + '] esta informado como PMC.'})
					Ft_FSkip()
					Loop
				endif

			endif

			// Nใo ้ considerado o pre็o da embalagem (somente o da fra็ใo)
			// nValRef	:= val( aAux[ aScan( aCabec[nTpCab][2], {|x| AllTrim(x) == "PRECO_PROC"} ) ] )
			nValRef	:= val( aAux[ aScan( aCabec[nTpCab][2], {|x| AllTrim(x) == "VLR_FRAC"  } ) ] )
			
			if nValRef == 0
				aAdd(aRet, {nContSq, 'O valor de referencia do procedimento [' + cCodPro + '] esta zerado.'})
				Ft_FSkip()
				Loop
			endif

			if cTpPreco == "PFB"
				nValRef	:= nValRef * 1.3824
			endif
			
			if !empty(cCodTUSS)

				// Rotina para a grava็ใo do procedimento na TDE (BA8), replica็ใo na Tab. Padrใo (BR8) e Terminologia (BTQ e BTU)
				AtuProc(cCodPad, cCodTab, cCodTUSS, cDesPro, cAnaSin, cNivel, cLabora, dVigIni, dVigFim, cAnvisa, cAprese, cEdicao)
				
				// Grava็ใo da composi็ใo (BD4)
				lErroCmp	:= CriaComp(cCodPad, cCodTab, cCodTUSS, dVigIni, dVigFim, nValRef, cEdicao, cTpPreco)

				if lErroCmp
					aAdd(aRet, {nContSq, 'A data de inicio da vigencia do procedimento TUSS: [' + cCodTUSS + '] e menor ou igual que a atualmente no cadastro.'})
				else
					lImpOK	:= .T.
				endif

			endif

			if !empty(cCodTISS)

				// Rotina para a grava็ใo do procedimento na TDE (BA8), replica็ใo na Tab. Padrใo (BR8) e Terminologia (BTQ e BTU)
				AtuProc(cCdPad2, cCdTab2, cCodTISS, cDesPro, cAnSin2, cNivel2, cLabora, dVigIni, dVigFim, cAnvisa, cAprese, cEdicao)
				
				// Grava็ใo da composi็ใo (BD4)
				lErroCmp	:= CriaComp(cCdPad2, cCdTab2, cCodTISS, dVigIni, dVigFim, nValRef, cEdicao, cTpPreco)

				if lErroCmp
					aAdd(aRet, {nContSq, 'A data de inicio da vigencia do procedimento TISS: [' + cCodTISS + '] e menor ou igual que a atualmente no cadastro.'})
				else
					lImpOK	:= .T.
				endif

			endif

		else
			aAdd(aRet, {nContSq, 'Esta linha nao esta de acordo com o layout de importacao do Brasindice (' +;
										AllTrim(X3Combo("ZRJ_TIPEVE", ZRJ->ZRJ_TIPEVE )) + ').'})
		endif
		
		FT_FSkip()	// Pula para pr๓xima linha
	end
	
	FT_FUse()

else
	alert("Erro na abertura do arquivo. Verifique se o mesmo nใo se encontra aberto. Processamento nใo foi possํvel!")
	aAdd(aRet, {0, 'Erro na abertura do arquivo para importacao.'})
endif

if len(aRet) == 0 .and. lImpOK
	aRet	:= {'1', {}}
elseif len(aRet) == 0 .and. !lImpOK
	aAdd(aRet, {0, 'Nenhum registro no arquivo para importacao.'})
	aRet	:= {'3', aRet}
elseif len(aRet) > 0 .and. lImpOK
	aRet	:= {'2', aRet}
else
	aRet	:= {'3', aRet}
endif

return aRet



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ ImpCBHPM บAuthor ณ Fred O. C. Jr      บ Date ณ  27/01/20   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ  Importar procedimentos da CBHPM						      บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUse       ณ                                                            บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function ImpCBHPM(cArquivo)

Local aRet		:= {}
Local lImpOK	:= .F.
Local nPos		:= 0
Local cAux		:= ""
Local aAux		:= {}
Local aRetNv	:= {}
Local _i		:= 0
Local nTabQtd	:= 0
Local nHdl		:= 0
Local nTotSeq	:= 0
Local nContSq	:= 0
Local cBuffer	:= ""
Local aCabec	:= {"CODIGO", "DESCRICAO",;				// Identifica็ใo
					"PERC_PORTE", "IGNORAR1", "PORTE",;	// Porte		-> BD4_CODIGO: 'PPM' / BD4_VALREF: perc_porte / BD4_PORMED -> porte
					"UCO",;								// UCO			-> BD4_CODIGO: 'UCO' / BD4_VALREF: uco
					"AUXILIAR",;						// Auxiliar		-> BD4_CODIGO: 'AUX' / BD4_VALREF: auxiliar
					"PORTE_ANES",;						// Porte Anest.	-> BD4_CODIGO: 'PAP' / BD4_VALREF: porte_anes
					"FILME",;							// Filme		-> BD4_CODIGO: 'FIL' / BD4_VALREF: filme
					"IGNORAR2", "IGNORAR3"}				// Nใo mapeados para importa็ใo

Local nPetPor	:= 0
Local cPorte	:= ""
Local nUCO		:= 0
Local nAuxili	:= 0
Local nPorAne	:= 0
Local nFilme	:= 0

Local cCodPad	:= ZRJ->ZRJ_CODPAD
Local cCodTab	:= ZRJ->(ZRJ_CODOPE+ZRJ_CODTAB)

Local cCodPro	:= ""
Local cDesPro	:= ""
Local cNivel	:= ""
Local cAnaSin	:= ""
Local cLabora	:= ""
Local dVigIni	:= ZRJ->ZRJ_DTPUBL
Local dVigFim	:= StoD("")
Local cAnvisa	:= ""
Local lErroCmp	:= .F.
Local lAux		:= .F.

// Validar se tem porte de procedimento parametrizado
BW4->(DbSetOrder(1))	// BW4_FILIAL+BW4_CODOPE+BW4_CODTAB+BW4_PORTE
if !BW4->(DbSeek( XFilial("BW4") + cCodTab ))
	if !MsgYesNo("A TDE [" + ZRJ->ZRJ_CODTAB + "] nใo possui nenhum porte de procedimento parametrizado."		+ chr(13)+chr(10) + chr(13)+chr(10) +;
				"Desta forma, TODOS os procedimentos que possuํrem porte na composi็ใo NรO serใo importados."	+ chr(13)+chr(10) + chr(13)+chr(10) +;
				"Deseja efetivar o processamento mesmo assim?")
		
		aRet	:= {'0', {}}
		return aRet
	endif
endif

// Validar se tem porte anestesico parametrizado
BKF->(DbSetOrder(1))	// BKF_FILIAL+BKF_CODINT+BKF_CODTAB
if !BKF->(DbSeek( XFilial("BKF") + cCodTab ))
	if !MsgYesNo("A TDE [" + ZRJ->ZRJ_CODTAB + "] nใo possui nenhum porte anest้sico parametrizado."						+ chr(13)+chr(10) + chr(13)+chr(10) +;
				"Desta forma, TODOS os procedimentos que possuํrem porte anest้sico na composi็ใo NรO serใo importados."	+ chr(13)+chr(10) + chr(13)+chr(10) +;
				"Deseja efetivar o processamento mesmo assim?")
		
		aRet	:= {'0', {}}
		return aRet
	endif
endif

// Validar se tem auxiliar parametrizado
BP1->(DbSetOrder(1))	// BP1_FILIAL+BP1_CODINT+BP1_CODTAB+BP1_CODFUN
if !BP1->(DbSeek( XFilial("BP1") + cCodTab + "AUX" ))
	if !MsgYesNo("A TDE [" + ZRJ->ZRJ_CODTAB + "] nใo possui nenhum auxiliar parametrizado."						+ chr(13)+chr(10) + chr(13)+chr(10) +;
				"Desta forma, TODOS os procedimentos que possuํrem auxiliar na composi็ใo NรO serใo importados."	+ chr(13)+chr(10) + chr(13)+chr(10) +;
				"Deseja efetivar o processamento mesmo assim?")
		
		aRet	:= {'0', {}}
		return aRet
	endif
endif


nPos := AT(".TXT", Upper(cArquivo))
if nPos == 0
	Alert('A extensใo do arquivo [' + cArquivo + '] ้ invแlida. A mesma deve ser obrigatoriamente: TST')
	aAdd(aRet, {0, 'A extensao do arquivo [' + cArquivo + '] e invalida. A mesma deve ser obrigatoriamente: TST.'})
	return aRet
endif

// Preencher ANALITICO/SINTETICO e NIVEL de forma generica - Buscando atraves do Tipo de Tabela
BR4->(DbSetOrder(1))	// BR4_FILIAL + BR4_CODPAD + BR4_SEGMEN
if BR4->(DbSeek( xFilial("BR4") + ZRJ->ZRJ_CODPAD )) .and. !empty(ZRJ->ZRJ_CODPAD)

	cAux	:= BR4->BR4_CODPAD
	nPos	:= 1
	
	while !BR4->(EOF()) .and. BR4->BR4_CODPAD == ZRJ->ZRJ_CODPAD
	
		nTabQtd += val(BR4->BR4_DIGITO)
		
		if BR4->BR4_DIGVER <> "1"
			aAdd(aAux, {nPos, BR4->BR4_DIGITO, BR4->BR4_CODNIV})
			nPos += val(BR4->BR4_DIGITO)
		endif
		
		BR4->(DbSkip())
	end
	
	aAdd(aRetNv, {cAux, {} })
	for _i := len(aAux) to 1 step (-1)
		aAdd(aRetNv[len(aRetNv)][2], aAux[_i] )
	next

elseif !empty(ZRJ->ZRJ_CODPAD)
	Alert("Tipo de Tabela TUSS informado nใo localizado no Protheus!")
	aAdd(aRet, {0, 'Tipo de Tabela TUSS informado nao localizado no Protheus.'})
	return aRet
endif
// Fim da montagem da estrutura


nHdl	:= FT_FUse(cArquivo)

if nHdl <> -1

	nTotSeq	:= FT_FLastRec()	// Retorna o n๚mero de linhas do arquivo
	
	ProcRegua(nTotSeq)
	
	FT_FGoTop()
	while !FT_FEOF()
	
		nContSq++
		IncProc("Processando..." + CHR(13)+CHR(10) + "Registro: " + AllTrim(Str(nContSq)) + " / " + AllTrim(Str(nTotSeq)) )
		
		cBuffer	:= FT_FReadLn() // Retorna a linha corrente
		aAux	:= StrTokArr2 (cBuffer, ';', .T.)
		
		if len(aAux) == len(aCabec)

			cCodPro	:= AllTrim( aAux[ aScan( aCabec, {|x| AllTrim(x) == "CODIGO"  } ) ] )
			
			// Garantir que tenha um c๓digo vแlido (TUSS)
			if empty(cCodPro) .or. val(cCodPro) == 0 .or. len(cCodPro) <> nTabQtd
				aAdd(aRet, {nContSq, 'O codigo TUSS do procedimento [' + cCodPro + '] invalido ou vazio.'})
				Ft_FSkip()
				Loop
			endif

			// tratar filtro de evento: ZRJ_FILEVE - 1=Dietas;2=Solucoes;3=Quimioterapicos;4=Monoclonais;5=Imunobiologicos;6=Demais
			if !empty(ZRJ->ZRJ_FILEVE)
				BR8->(DbSetOrder(1))	// BR8_FILIAL+BR8_CODPAD+BR8_CODPSA+BR8_ANASIN
				if BR8->(DbSeek( xFilial("BR8") + cCodPad + cCodPro ))
					if	(!empty(BR8->BR8_XTPEVE) .and. !(BR8->BR8_XTPEVE $ ZRJ->ZRJ_FILEVE)) .or.;
						(empty(BR8->BR8_XTPEVE)  .and. !('6' $ ZRJ->ZRJ_FILEVE))
						Ft_FSkip()
						Loop
					endif
				elseif !('6' $ ZRJ->ZRJ_FILEVE)	// se nใo contem de 'outros proced.' (s๓ especifico) - nใo importar
					Ft_FSkip()
					Loop
				endif
			endif

			cDesPro	:= Upper( AllTrim( aAux[ aScan( aCabec, {|x| AllTrim(x) == "DESCRICAO"} ) ] ) )

			if empty(cDesPro)
				aAdd(aRet, {nContSq, 'A descricao do procedimento [' + cCodPro + '] esta em branco.'})
				Ft_FSkip()
				Loop
			endif
			
			// Busca de nivel de forma automatica (TUSS)
			nPos := aScan( aRetNv,{|x| x[1] == cCodPad } )
			if nPos <> 0
				for _i := 1 to len(aRetNv[nPos][2])
					if SubStr( cCodPro, aRetNv[nPos][2][_i][1], val(aRetNv[nPos][2][_i][2]) ) <> Replicate("0", val(aRetNv[nPos][2][_i][2]) )
						cNivel	:= aRetNv[nPos][2][_i][3]
						cAnaSin	:= iif(cNivel == aRetNv[nPos][2][1][3], "1", "2")
						exit
					endif
				next
			endif

			// Verificar se procedimento tem ao menos uma composi็ใo com valor de refer๊ncia
			nUCO	:= val( StrTran( aAux[ aScan( aCabec, {|x| AllTrim(x) == "UCO"		 } ) ], ",", ".") )
			nFilme	:= val( StrTran( aAux[ aScan( aCabec, {|x| AllTrim(x) == "FILME"	 } ) ], ",", ".") )
			
			cPorte	:= AllTrim(		 aAux[ aScan( aCabec, {|x| AllTrim(x) == "PORTE"	 } ) ] )
			nPetPor	:= val( StrTran( aAux[ aScan( aCabec, {|x| AllTrim(x) == "PERC_PORTE"} ) ], ",", ".") )
			if !empty(cPorte)
				BW4->(DbSetOrder(1))	// BW4_FILIAL+BW4_CODOPE+BW4_CODTAB+BW4_PORTE
				if BW4->(DbSeek( XFilial("BW4") + cCodTab + cPorte ))
					nPetPor	:= iif(nPetPor == 0 , 1, nPetPor)
				else
					aAdd(aRet, {nContSq, 'A unidade de porte do procedimento [' + cCodPro + '] e invalida.'})
					Ft_FSkip()
					Loop
				endif
			endif

			nPorAne	:= val( StrTran( aAux[ aScan( aCabec, {|x| AllTrim(x) == "PORTE_ANES"} ) ], ",", ".") )
			if nPorAne > 0
				lAux	:= .F.
				BKF->(DbSetOrder(1))	// BKF_FILIAL+BKF_CODINT+BKF_CODTAB
				if BKF->(DbSeek( XFilial("BKF") + cCodTab ))
					while BKF->(!EOF()) .and. BKF->(BKF_CODINT+BKF_CODTAB) == cCodTab .and. !lAux
						if BKF->BKF_SEQPOR == nPorAne
							lAux	:= .T.
						endif
						BKF->(DbSkip())
					end
				endif

				if !lAux
					aAdd(aRet, {nContSq, 'O porte anest้sico do procedimento [' + cCodPro + '] e invalido.'})
					Ft_FSkip()
					Loop
				endif
			endif

			nAuxili	:= val( StrTran( aAux[ aScan( aCabec, {|x| AllTrim(x) == "AUXILIAR"} ) ], ",", ".") )
			if nAuxili > 0
				lAux	:= .F.
				BP1->(DbSetOrder(1))	// BP1_FILIAL+BP1_CODINT+BP1_CODTAB+BP1_CODFUN
				if BP1->(DbSeek( XFilial("BP1") + cCodTab + "AUX" ))
					while BP1->(!EOF()) .and. BP1->(BP1_CODINT+BP1_CODTAB+BP1_CODFUN) == (cCodTab + "AUX") .and. !lAux
						if BP1->BP1_NUMAUX == nAuxili
							lAux	:= .T.
						endif
						BP1->(DbSkip())
					end
				endif

				if !lAux
					aAdd(aRet, {nContSq, 'O auxiliar do procedimento [' + cCodPro + '] e invalido.'})
					Ft_FSkip()
					Loop
				endif
			endif
			
			if	empty(cPorte) .and. nUCO == 0 .and. nAuxili == 0 .and. nPorAne == 0 .and. nFilme == 0
				aAdd(aRet, {nContSq, 'O procedimento [' + cCodPro + '] nao possui nenhuma composicao para importar.'})
				Ft_FSkip()
				Loop
			endif

			// Rotina para a grava็ใo do procedimento na TDE (BA8), replica็ใo na Tab. Padrใo (BR8) e Terminologia (BTQ e BTU)
			AtuProc(cCodPad, cCodTab, cCodPro, cDesPro, cAnaSin, cNivel, cLabora, dVigIni, dVigFim, cAnvisa)

			// Grava็ใo da composi็ใo (BD4)
			lErroCmp	:= CompCBHPM(cCodPad, cCodTab, cCodPro, dVigIni, dVigFim, cPorte, nPetPor, nUCO, nAuxili, nPorAne, nFilme)

			if lErroCmp
				aAdd(aRet, {nContSq, 'A data de inicio da vigencia do procedimento TUSS: [' + cCodPro + '] e menor ou igual que a atualmente no cadastro.'})
			else
				lImpOK	:= .T.
			endif

		else
			aAdd(aRet, {nContSq, 'Esta linha nao esta de acordo com o layout de importacao do CBHPM.'})
		endif
		
		FT_FSkip()	// Pula para pr๓xima linha
	end
	
	FT_FUse()

else
	alert("Erro na abertura do arquivo. Verifique se o mesmo nใo se encontra aberto. Processamento nใo foi possํvel!")
	aAdd(aRet, {0, 'Erro na abertura do arquivo para importacao.'})
endif

if len(aRet) == 0 .and. lImpOK
	aRet	:= {'1', {}}
elseif len(aRet) == 0 .and. !lImpOK
	aAdd(aRet, {0, 'Nenhum registro no arquivo para importacao.'})
	aRet	:= {'3', aRet}
elseif len(aRet) > 0 .and. lImpOK
	aRet	:= {'2', aRet}
else
	aRet	:= {'3', aRet}
endif

return aRet


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ AtuProc  บAuthor ณ Fred O. C. Jr      บ Date ณ  28/01/20   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ  Fun็ใo para a grava็ใo da BA8, BR8 e terminologias		  บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUse       ณ                                                            บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function AtuProc(cCodPad, cCodTab, cCodPro, cDesPro, cAnaSin, cNivel, cLabora, dVigIni, dVigFim, cAnvisa, cAprese, cEdicao)

Local cTabTerm	:= ""
Local cDesTerm	:= ""
Local cDescri	:= iif(ZRJ->ZRJ_TIPIMP == '1', cDesPro + " - " + cLabora, iif(ZRJ->ZRJ_TIPIMP == '2', cDesPro + " " + cAprese, cDesPro) )

Default cAprese	:= ""
Default cEdicao	:= ""

// Buscar descri็ใo da terminologia
BTU->(DbSetOrder(1))	// BTU_FILIAL+BTU_CODTAB+BTU_ALIAS+BTU_VLRBUS
if BTU->(DbSeek( xFilial("BTU") + "87" + "BR4" + cCodPad ))
	cTabTerm	:= AllTrim(BTU->BTU_CDTERM)
	
	BTQ->(DbSetOrder(1))	// BTQ_FILIAL+BTQ_CODTAB+BTQ_CDTERM
	if BTQ->(DbSeek( xFilial("BTQ") + cTabTerm + cCodPro ))
		cDesTerm	:= AllTrim(BTQ->BTQ_DESTER)
		cDesTerm	+= iif(ZRJ->ZRJ_TIPIMP == '1', BTQ->BTQ_LABORA, iif(ZRJ->ZRJ_TIPIMP == '2', BTQ->BTQ_APRESE, ""))
	endif
	
endif

// Grava็ใo do evento na TDE
BA8->(DbSetOrder(1))	// BA8_FILIAL+BA8_CODTAB+BA8_CDPADP+BA8_CODPRO
if !BA8->(DbSeek( xFilial("BA8") + cCodTab + cCodPad + cCodPro ))

	BA8->(RecLock("BA8",.T.))
		BA8->BA8_FILIAL := xFilial("BA8")
		BA8->BA8_CDPADP := cCodPad
		BA8->BA8_CODPAD := cCodPad
		BA8->BA8_CODTAB := cCodTab
		BA8->BA8_CODPRO := cCodPro
		BA8->BA8_DESCRI := iif(!empty(cDesTerm), cDesTerm, cDescri)
		BA8->BA8_ANASIN := cAnaSin
		BA8->BA8_NIVEL  := cNivel
		BA8->BA8_NMFABR	:= cLabora
		BA8->BA8_RGANVI	:= cAnvisa
		BA8->BA8_XEDICA	:= iif(!empty(cEdicao), cEdicao, ZRJ->ZRJ_EDICAO)
	BA8->(MsUnlock())

else
	
	BA8->(RecLock("BA8",.F.))
		BA8->BA8_DESCRI := iif(!empty(cDesTerm), cDesTerm, cDescri)
		BA8->BA8_ANASIN := cAnaSin
		BA8->BA8_NIVEL  := cNivel
		BA8->BA8_NMFABR	:= cLabora
		BA8->BA8_RGANVI	:= cAnvisa
		BA8->BA8_XEDICA	:= iif(!empty(cEdicao), cEdicao, ZRJ->ZRJ_EDICAO)
	BA8->(MsUnlock())

endif

BF8->(DbSetOrder(1))	// BF8_FILIAL+BF8_CODINT+BF8_CODIGO
if BF8->(DbSeek( xFilial("BF8") + cCodTab ))

	if BF8->BF8_ESPTPD == '1'	// Espelha na Tab. Padrใo
	
		BR8->(DbSetOrder(1))	// BR8_FILIAL+BR8_CODPAD+BR8_CODPSA+BR8_ANASIN
		if !BR8->(DbSeek(xFilial("BR8") + cCodPad + cCodPro ))
		
			BR8->(RecLock("BR8",.T.))
				BR8->BR8_FILIAL := xFilial("BR8")
				BR8->BR8_CODPAD := cCodPad
				BR8->BR8_CODPSA := cCodPro
				BR8->BR8_DESCRI := iif(!empty(cDesTerm), cDesTerm, cDescri)
				BR8->BR8_NIVEL  := cNivel
				BR8->BR8_ANASIN := cAnaSin
				BR8->BR8_BENUTL := "1"				// Jแ entra ativo
				BR8->BR8_AUTORI := "1"				// Automatica
				BR8->BR8_CLASSE := ZRJ->ZRJ_CLASSE
				BR8->BR8_TPPROC := ZRJ->ZRJ_TPPROC
				BR8->BR8_PROBLO	:= "0"				// Proced. Nใo Bloqueado
				BR8->BR8_REGATD := "3"				// regime atendimento: (1=Ambulatorial;2=Internacao;3=Ambos)
				BR8->BR8_LEMBRE := iif(ZRJ->ZRJ_TIPIMP == '1', 'SIMPRO', iif(ZRJ->ZRJ_TIPIMP == '2', 'BRASINDICE', "CBHPM") ) +;
									' - Divulga็ใo: ' + DTOC(ZRJ->ZRJ_DTPUBL) + " - Importa็ใo: " + DtoC(Date())
			BR8->(MSUnLock())
			
		else
		
			BR8->(RecLock("BR8",.F.))
				BR8->BR8_DESCRI := iif(!empty(cDesTerm), cDesTerm, cDescri)
				BR8->BR8_NIVEL  := cNivel
				BR8->BR8_ANASIN := cAnaSin
				BR8->BR8_LEMBRE := iif(ZRJ->ZRJ_TIPIMP == '1', 'SIMPRO', iif(ZRJ->ZRJ_TIPIMP == '2', 'BRASINDICE', "CBHPM") ) +;
									' - Divulga็ใo: ' + DTOC(ZRJ->ZRJ_DTPUBL) + " - Importa็ใo: " + DtoC(Date())
			BR8->(MSUnLock())
		
		endif
		
		if !empty(cTabTerm)

			if cTabTerm == '00'		// s๓ crio terminologia se tabela pr๓pria
			
				BTQ->(DbSetOrder(1))	// BTQ_FILIAL+BTQ_CODTAB+BTQ_CDTERM
				if !BTQ->(DbSeek( xFilial("BTQ") + cTabTerm + cCodPro ))

					BTQ->(RecLock("BTQ", .T.))
						BTQ->BTQ_FILIAL := xFilial("BTQ")
						BTQ->BTQ_CODTAB := cTabTerm
						BTQ->BTQ_CDTERM := cCodPro
						BTQ->BTQ_DESTER := cDesPro
						BTQ->BTQ_LABORA := cLabora
						BTQ->BTQ_DATFIM	:= dVigIni
						BTQ->BTQ_VIGDE  := dVigIni
						BTQ->BTQ_VIGATE	:= dVigFim
						BTQ->BTQ_HASVIN := "1"				// Possui vinculo (se nใo tiver - criarei)
						BTQ->BTQ_APRESE	:= cAprese
					BTQ->(MsUnlock())
				
				else
				
					BTQ->(RecLock("BTQ", .F.))
						BTQ->BTQ_DESTER := cDesPro
						BTQ->BTQ_LABORA := cLabora
						BTQ->BTQ_DATFIM	:= iif(!empty(BTQ->BTQ_DATFIM), BTQ->BTQ_DATFIM, dVigIni)
						BTQ->BTQ_VIGDE  := iif(!empty(BTQ->BTQ_VIGDE ), BTQ->BTQ_VIGDE , dVigIni)
						BTQ->BTQ_VIGATE	:= iif(!empty(BTQ->BTQ_VIGATE), BTQ->BTQ_VIGATE, dVigFim)
						BTQ->BTQ_HASVIN := "1"				// Possui vinculo (se nใo tiver - criarei)
						BTQ->BTQ_APRESE	:= cAprese
					BTQ->(MsUnlock())
				
				endif
			
			endif

			BTQ->(DbSetOrder(1))	// BTQ_FILIAL+BTQ_CODTAB+BTQ_CDTERM
			if BTQ->(DbSeek( xFilial("BTQ") + cTabTerm + cCodPro ))

				BTU->(DbSetOrder(3))	// BTU_FILIAL+BTU_CODTAB+BTU_ALIAS+BTU_CDTERM
				if !BTU->(DbSeek( xFilial("BTU") + BTQ->BTQ_CODTAB + "BR8" + cCodPro ))
				
					BTU->(RecLock("BTU", .T.))
						BTU->BTU_FILIAL := xFilial("BTU")
						BTU->BTU_CODTAB := BTQ->BTQ_CODTAB
						BTU->BTU_VLRSIS := xFilial("BR8") + cCodPad + cCodPro
						BTU->BTU_VLRBUS := cCodPro
						BTU->BTU_CDTERM := cCodPro
						BTU->BTU_ALIAS  := "BR8"
					BTU->(MsUnlock())
				
				endif

			endif
		
		endif
	
	endif

endif

return



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ CriaComp บAuthor ณ Fred O. C. Jr      บ Date ณ  28/01/20   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ  Fun็ใo para a grava็ใo da composi็ใo					  บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUse       ณ                                                            บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function CriaComp(cCodPad, cCodTab, cCodPro, dVigIni, dVigFim, nValRef, cEdicao, cTpPreco)

Local lImport		:= .T.
Local lExiste		:= .F.
Local lErro			:= .F.
Local dVgFim2		:= dVigIni - 1

Default cEdicao		:= ""
Default cTpPreco	:= ""

BD4->(DbSetOrder(1))	// BD4_FILIAL+BD4_CODTAB+BD4_CDPADP+BD4_CODPRO+BD4_CODIGO+DTOS(BD4_VIGINI)
if BD4->(DbSeek( xFilial("BD4") + cCodTab + cCodPad + PadR(cCodPro, 16) + ZRJ->ZRJ_UNSAUD ))

	lExiste	:= .T.
	
	// Ir at้ a ๚ltima composi็ใo do procedimento
	while BD4->(!EOF()) .and. BD4->(BD4_CODTAB+BD4_CDPADP+BD4_CODPRO+BD4_CODIGO) == (cCodTab + cCodPad + PadR(cCodPro, 16) + ZRJ->ZRJ_UNSAUD)
		BD4->(DbSkip())
	end
	BD4->(DbSkip(-1))
	
	if BD4->BD4_VIGINI >= dVigIni		// A vig๊ncia na base ้ maior ou igual que a sendo importada
		lImport := .F.
		lErro	:= .T.
	elseif BD4->BD4_VALREF == nValRef	// Nใo houve altera็ใo de pre็o
		lImport := .F.
	endif

endif

if lImport

	if lExiste

		if empty(BD4->BD4_VIGFIM) .or. BD4->BD4_VIGFIM > dVgFim2
		
			// Se jแ existe composi็ใo - estแ ponteirado na ๚ltima (que a vig. inicial tem que ser menor que a que serแ importada)
			BD4->(RecLock("BD4",.F.))
				BD4->BD4_VIGFIM := dVgFim2
			BD4->(MsUnLock())
		
		endif
	
	endif
	
	BD4->(RecLock("BD4",.T.))
		BD4->BD4_FILIAL := xFilial("BD4")
		BD4->BD4_CDPADP := cCodPad
		BD4->BD4_CODTAB := cCodTab
		BD4->BD4_CODPRO := cCodPro
		BD4->BD4_CODIGO := ZRJ->ZRJ_UNSAUD
		BD4->BD4_VALREF := nValRef
		BD4->BD4_VIGINI := dVigIni
		BD4->BD4_VIGFIM := dVigFim
		BD4->BD4_CODTPA	:= ZRJ->ZRJ_TIPPAR
		BD4->BD4_XLOTE	:= ZRJ->ZRJ_SEQUEN
		BD4->BD4_YEDICA	:= iif(!empty(cEdicao), cEdicao, ZRJ->ZRJ_EDICAO)
		BD4->BD4_YDTIMP	:= date()
		BD4->BD4_YUSUR  := StrTran(cUserName, "CABERJ\", "")
		BD4->BD4_XTPREC := iif(cTpPreco == 'PMC', '1', iif(cTpPreco == 'PFB', '2', ''))		// 1=PMC;2=PFB
		BD4->BD4_XVLFAB := iif(cTpPreco == 'PFB', nValRef, 0)
		BD4->BD4_YTBIMP := iif(ZRJ->ZRJ_TIPIMP == '1', 'SIMPRO', 'BRASINDICE') + ' - Divulga็ใo: ' + DTOC(ZRJ->ZRJ_DTPUBL) + " - Importa็ใo: " + DtoC(Date())
		BD4->BD4_YPERIM	:= iif(cTpPreco == 'PFB', 38.24, 0)
	BD4->(MsUnLock())

endif

return lErro



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ CompCBHPM บAuthor ณ Fred O. C. Jr     บ Date ณ  28/01/20   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ  Fun็ใo para a grava็ใo da composi็ใo (CBHPM)			  บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUse       ณ                                                            บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function CompCBHPM(cCodPad, cCodTab, cCodPro, dVigIni, dVigFim, cPorte, nPetPor, nUCO, nAuxili, nPorAne, nFilme)

Local lImport		:= .T.
Local lExiste		:= .F.
Local lErro			:= .F.
Local dVgFim2		:= dVigIni - 1

Default cEdicao		:= ""
Default cTpPreco	:= ""

BD4->(DbSetOrder(1))	// BD4_FILIAL+BD4_CODTAB+BD4_CDPADP+BD4_CODPRO+BD4_CODIGO+DTOS(BD4_VIGINI)
if BD4->(DbSeek( xFilial("BD4") + cCodTab + cCodPad + PadR(cCodPro, 16) ))

	lExiste	:= .T.
	
	// Ir at้ a ๚ltima composi็ใo do procedimento
	while BD4->(!EOF()) .and. BD4->(BD4_CODTAB+BD4_CDPADP+BD4_CODPRO) == (cCodTab + cCodPad + PadR(cCodPro, 16))

		if BD4->BD4_VIGINI >= dVigIni		// A vig๊ncia na base ้ maior ou igual que a sendo importada
			lImport := .F.
			lErro	:= .T.
		endif

		BD4->(DbSkip())
	end
	BD4->(DbSkip(-1))

endif

if lImport

	if lExiste

		// Encerrar TODAS as vig๊ncias abertas
		BD4->(DbSetOrder(1))	// BD4_FILIAL+BD4_CODTAB+BD4_CDPADP+BD4_CODPRO+BD4_CODIGO+DTOS(BD4_VIGINI)
		if BD4->(DbSeek( xFilial("BD4") + cCodTab + cCodPad + PadR(cCodPro, 16) ))

			while BD4->(!EOF()) .and. BD4->(BD4_CODTAB+BD4_CDPADP+BD4_CODPRO) == (cCodTab + cCodPad + PadR(cCodPro, 16))

				if empty(BD4->BD4_VIGFIM) .or. BD4->BD4_VIGFIM > dVgFim2
				
					// Se jแ existe composi็ใo - estแ ponteirado na ๚ltima (que a vig. inicial tem que ser menor que a que serแ importada)
					BD4->(RecLock("BD4",.F.))
						BD4->BD4_VIGFIM := dVgFim2
					BD4->(MsUnLock())
				
				endif

				BD4->(DbSkip())
			end
			BD4->(DbSkip(-1))

		endif
	
	endif

	// Criar novas composi็๕es
	if !empty(cPorte)

		BD4->(RecLock("BD4",.T.))
			BD4->BD4_FILIAL := xFilial("BD4")
			BD4->BD4_CDPADP := cCodPad
			BD4->BD4_CODTAB := cCodTab
			BD4->BD4_CODPRO := cCodPro
			BD4->BD4_CODIGO := "PPM"
			BD4->BD4_VALREF := nPetPor
			BD4->BD4_PORMED	:= cPorte
			BD4->BD4_VIGINI := dVigIni
			BD4->BD4_VIGFIM := dVigFim
			BD4->BD4_CODTPA	:= ZRJ->ZRJ_TIPPAR
			BD4->BD4_XLOTE	:= ZRJ->ZRJ_SEQUEN
			BD4->BD4_YEDICA	:= iif(!empty(cEdicao), cEdicao, ZRJ->ZRJ_EDICAO)
			BD4->BD4_YDTIMP	:= date()
			BD4->BD4_YUSUR  := StrTran(cUserName, "CABERJ\", "")
			BD4->BD4_YTBIMP := "CBHPM" + ' - Divulga็ใo: ' + DTOC(ZRJ->ZRJ_DTPUBL) + " - Importa็ใo: " + DtoC(Date())
		BD4->(MsUnLock())

	endif

	if nUCO > 0

		BD4->(RecLock("BD4",.T.))
			BD4->BD4_FILIAL := xFilial("BD4")
			BD4->BD4_CDPADP := cCodPad
			BD4->BD4_CODTAB := cCodTab
			BD4->BD4_CODPRO := cCodPro
			BD4->BD4_CODIGO := "UCO"
			BD4->BD4_VALREF := nUCO
			BD4->BD4_VIGINI := dVigIni
			BD4->BD4_VIGFIM := dVigFim
			BD4->BD4_CODTPA	:= ZRJ->ZRJ_TIPPAR
			BD4->BD4_XLOTE	:= ZRJ->ZRJ_SEQUEN
			BD4->BD4_YEDICA	:= iif(!empty(cEdicao), cEdicao, ZRJ->ZRJ_EDICAO)
			BD4->BD4_YDTIMP	:= date()
			BD4->BD4_YUSUR  := StrTran(cUserName, "CABERJ\", "")
			BD4->BD4_YTBIMP := "CBHPM" + ' - Divulga็ใo: ' + DTOC(ZRJ->ZRJ_DTPUBL) + " - Importa็ใo: " + DtoC(Date())
		BD4->(MsUnLock())

	endif

	if nAuxili > 0

		BD4->(RecLock("BD4",.T.))
			BD4->BD4_FILIAL := xFilial("BD4")
			BD4->BD4_CDPADP := cCodPad
			BD4->BD4_CODTAB := cCodTab
			BD4->BD4_CODPRO := cCodPro
			BD4->BD4_CODIGO := "AUX"
			BD4->BD4_VALREF := nAuxili
			BD4->BD4_VIGINI := dVigIni
			BD4->BD4_VIGFIM := dVigFim
			BD4->BD4_CODTPA	:= ZRJ->ZRJ_TIPPAR
			BD4->BD4_XLOTE	:= ZRJ->ZRJ_SEQUEN
			BD4->BD4_YEDICA	:= iif(!empty(cEdicao), cEdicao, ZRJ->ZRJ_EDICAO)
			BD4->BD4_YDTIMP	:= date()
			BD4->BD4_YUSUR  := StrTran(cUserName, "CABERJ\", "")
			BD4->BD4_YTBIMP := "CBHPM" + ' - Divulga็ใo: ' + DTOC(ZRJ->ZRJ_DTPUBL) + " - Importa็ใo: " + DtoC(Date())
		BD4->(MsUnLock())

	endif

	if nPorAne > 0

		BD4->(RecLock("BD4",.T.))
			BD4->BD4_FILIAL := xFilial("BD4")
			BD4->BD4_CDPADP := cCodPad
			BD4->BD4_CODTAB := cCodTab
			BD4->BD4_CODPRO := cCodPro
			BD4->BD4_CODIGO := "PAP"
			BD4->BD4_VALREF := nPorAne
			BD4->BD4_VIGINI := dVigIni
			BD4->BD4_VIGFIM := dVigFim
			BD4->BD4_CODTPA	:= ZRJ->ZRJ_TIPPAR
			BD4->BD4_XLOTE	:= ZRJ->ZRJ_SEQUEN
			BD4->BD4_YEDICA	:= iif(!empty(cEdicao), cEdicao, ZRJ->ZRJ_EDICAO)
			BD4->BD4_YDTIMP	:= date()
			BD4->BD4_YUSUR  := StrTran(cUserName, "CABERJ\", "")
			BD4->BD4_YTBIMP := "CBHPM" + ' - Divulga็ใo: ' + DTOC(ZRJ->ZRJ_DTPUBL) + " - Importa็ใo: " + DtoC(Date())
		BD4->(MsUnLock())

	endif

	if nFilme > 0

		BD4->(RecLock("BD4",.T.))
			BD4->BD4_FILIAL := xFilial("BD4")
			BD4->BD4_CDPADP := cCodPad
			BD4->BD4_CODTAB := cCodTab
			BD4->BD4_CODPRO := cCodPro
			BD4->BD4_CODIGO := "FIL"
			BD4->BD4_VALREF := nFilme
			BD4->BD4_VIGINI := dVigIni
			BD4->BD4_VIGFIM := dVigFim
			BD4->BD4_CODTPA	:= ZRJ->ZRJ_TIPPAR
			BD4->BD4_XLOTE	:= ZRJ->ZRJ_SEQUEN
			BD4->BD4_YEDICA	:= iif(!empty(cEdicao), cEdicao, ZRJ->ZRJ_EDICAO)
			BD4->BD4_YDTIMP	:= date()
			BD4->BD4_YUSUR  := StrTran(cUserName, "CABERJ\", "")
			BD4->BD4_YTBIMP := "CBHPM" + ' - Divulga็ใo: ' + DTOC(ZRJ->ZRJ_DTPUBL) + " - Importa็ใo: " + DtoC(Date())
		BD4->(MsUnLock())

	endif

endif

return lErro


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ ImpLog2  บAuthor ณ Fred O. C. Jr      บ Date ณ  27/01/20   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ  Imprimir log de proced. nใo importados				      บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUse       ณ                                                            บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function ImpLog2(aLogImp)

Local aHeader		:= {"LINHA", "LOG DE CARGA"}
Local i				:= 1

Local aAux			:= {}
Local nHdl			:= 0
Local cArq			:= ""

Local cPerg			:= "CABI022"

aAux	:= U_ImpCabXML(cPerg)
nHdl	:= aAux[1]
cArq	:= aAux[2]

if nHdl <> -1 .and. !empty(cArq)

	ProcRegua( len(aLogImp) )
	
	U_ImpPriXML(nHdl, aHeader)
	
	for i := 1 to len(aLogImp)

		IncProc("Processando..." + CHR(13)+CHR(10) + "Registro: " + AllTrim(Str(i)) + " / " + AllTrim(Str(len(aLogImp))) )
		
		// Inicio da Impressใo da linha
		cLinha := "<Row>" + CHR(13)+CHR(10)
		cLinha += U_ImpLinXML( aLogImp[i][1]				, 2)
		cLinha += U_ImpLinXML( aLogImp[i][2]				, 1)
		cLinha += '</Row>' + CHR(13)+CHR(10)
		
		FWRITE ( nHdl , cLinha )
	
	next
	
	cArq := U_ImpRodXML(nHdl, cArq)
	
	if ApOleClient("MsExcel")
	
        IncProc("Aguarde... Abrindo Excel")
        
        oExcelApp := MsExcel():New()
		oExcelApp:WorkBooks:Open(cArq)
		oExcelApp:SetVisible(.T.)
		oExcelApp:Destroy()
		
	else
		MsgStop("Microsoft Excel nใo instalado." + CHR(13)+CHR(10) + "Arquivo: " + cArq )
	endif

else
	MsgStop("O arquivo nใo pode ser criado!")
	return
endif

return



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออออหอออออออัออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ CABI022Z   บAutor  ณMicrosiga         บ Data ณ  25/06/2021 บฑฑ
ฑฑฬออออออออออุออออออออออออสอออออออฯออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ  Validar arquivo informado para a carga				      บฑฑ
ฑฑบ          ณ  										                  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function CABI022Z(cTpImp, cArqTxt)

Local lRet		:= .T.
Local cNomArq	:= AllTrim(cArqTxt)
Local aArqAux	:= {}
Local nPos		:= 0

if !empty(AllTrim(cTpImp))

	if !empty(cNomArq)
	
		aArqAux := Directory(cNomArq)
		if len(aArqAux) <> 0

			if cTpImp == '1'				// SIMPRO

				nPos := AT(".CSV", Upper(cNomArq))
				if nPos == 0
					lRet	:= .F.
					Alert('A extensใo do arquivo [' + cNomArq + '] ้ invแlida. A mesma deve ser obrigatoriamente: CSV')
				endif

			elseif cTpImp == '2' .or. cTpImp == '3'			// BRASINDICE ou CBHPM

				nPos := AT(".TXT", Upper(cNomArq))
				if nPos == 0
					lRet	:= .F.
					Alert('A extensใo do arquivo [' + cNomArq + '] ้ invแlida. A mesma deve ser obrigatoriamente: TXT')
				endif

			endif

		else
			
			lRet	:= .F.
			alert("O arquivo informado nใo foi encontrado.")
		
		endif
		
	else
		lRet	:= .F.
		Alert("Nome do arquivo estแ vazio. O preenchimento ้ obrigat๓rio!")
	endif

else
	M->ZRJ_ARQUIV := space(200)
	Alert("Informe primeiro qual o tipo de importa็ใo primeiro!")
	lRet	:= .T.
endif

return lRet

//----------------------------------------------------------------------------------//
//			Regras adicionais de valida็ใo da tela									//
//----------------------------------------------------------------------------------//
Static Function chkGrav(nOpc)

Local lRet		:= .T.

if nOpc == 3 .or. nOpc == 4		// Inclusใo ou altera็ใo

	if empty(M->ZRJ_CODPAD) .and. empty(M->ZRJ_CDPAD2)
		Alert("Nenhum tipo de tabela foi informado!")
		lRet	:= .F.
	elseif !empty(M->ZRJ_CODPAD) .and. empty(M->ZRJ_CODTAB)
		Alert("O c๓digo da TDE do TUSS nใo foi informado!")
		lRet	:= .F.
	elseif !empty(M->ZRJ_CDPAD2) .and. empty(M->ZRJ_CDTAB2)
		Alert("O c๓digo da TDE do TISS nใo foi informado!")
		lRet	:= .F.
	endif

endif

return lRet


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ CABI022Y   บAutor  ณFrederico O. C. Jrบ Data ณ  31/08/21   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ   Consulta padrใo no campo de filtro de procedimentos	  บฑฑ
ฑฑบ          ณ  										                  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function CABI022Y()

Local cTitulo	:= "Tipos de Procedimentos"
Local oOk		:= LoadBitmap( GetResources(), "LBOK" )		// carrega bitmap quadrado com X
Local oNo		:= LoadBitmap( GetResources(), "LBNO" )		// carrega bitmap soh o quadrado
Local cRetorn	:= ""

Private lChk	:= .F.
Private oLbx	:= Nil
Private aVetor	:= {}
Private oDlg

aAdd( aVetor, { .F., "1", "Dietas"					})
aAdd( aVetor, { .F., "2", "Solucoes"				})
aAdd( aVetor, { .F., "3", "Quimioterapicos"			})
aAdd( aVetor, { .F., "4", "Monoclonais"				})
aAdd( aVetor, { .F., "5", "Imunobiologicos"			})
aAdd( aVetor, { .F., "6", "Demais Procedimentos"	})

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Monta a tela para usuario visualizar consulta						  ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
If Len( aVetor ) == 0
	Aviso( cTitulo, "Nใo existem dados parametrizados para o filtro!", {"Ok"} )
	return
Endif

DEFINE MSDIALOG oDlg TITLE cTitulo FROM 0,0 TO 240,500 PIXEL

	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Se houver duplo clique, recebe ele mesmo negando, depois da um refreshณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	@ 10,10 LISTBOX oLbx VAR cVar FIELDS HEADER " ", "Codigo","Descri็ใo";
		SIZE 230,095 OF oDlg PIXEL ON dblClick(aVetor[oLbx:nAt,1] := !aVetor[oLbx:nAt,1], oLbx:Refresh())
	oLbx:SetArray( aVetor )
	oLbx:bLine := {|| {Iif(aVetor[oLbx:nAt,1],oOk,oNo),	aVetor[oLbx:nAt,2],	aVetor[oLbx:nAt,3] }}

	DEFINE SBUTTON FROM 107,213 TYPE 1 ACTION (cRetorn := U_CABI022W()) ENABLE OF oDlg

ACTIVATE MSDIALOG oDlg CENTER

M->ZRJ_FILEVE := cRetorn

return .T.


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ CABI022W บAutor  ณ Frederico O. C. Jr บ Data ณ  31/07/17   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ    Montar retorno das sele็๕es 					          บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function CABI022W()

Local _nCont	:= 0
Local _i		:= 0
Local cRet		:= ""

for _i := 1 to len(aVetor)

	if aVetor[_i, 1]
	
		_nCont++
		if _nCont > 1
			cRet += ";"
		endif
		cRet += aVetor[_i, 2]
	
	endif

next

cRet := AllTrim(cRet) + Space( 15 - len(cRet) )

oDlg:End()

return cRet
