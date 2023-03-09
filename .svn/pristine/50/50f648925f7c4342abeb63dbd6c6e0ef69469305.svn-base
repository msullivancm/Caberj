#INCLUDE "PLSMGER.CH"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "RWMAKE.CH"
#INCLUDE "TOPCONN.CH"

#define K_Confirma	6
#DEFINE cEnt chr(10)+chr(13)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ CRJP100 ³ Autor ³ Thiago Machado Correa³ Data ³ 23.02.08 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Alteracao Cadastral na Vida ou Cliente                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ Caberj           			                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

User Function CRJP100()

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Declaracao de variaveis...                                          ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	PRIVATE aRotina      := { 	{ "Pesquisar" ,'AxPesqui'	, 0 ,K_Pesquisar 	},;
		{ "Visualizar"		,'U_CRJPMOV'					, 0 ,K_Visualizar	},;
		{ "Incluir"	  		,'U_CRJPMOV'					, 0 ,K_Incluir   	},;
		{ "Alterar"   		,'U_CRJPMOV'					, 0 ,K_Alterar		},;
		{ "Excluir"   		,'U_CRJPMOV'					, 0 ,K_Excluir   	},;
		{ "Confirmar" 		,'U_CRJPMOV'					, 0 ,K_Confirma 	},;
		{ "Libera Registro" ,'U_CRJP100A()'					, 0 ,0 				},;
		{ "Legenda"   		,'U_CRJPLEG'					, 0 ,K_Incluir   	} }

	PRIVATE cCadastro 	:= "Alteração Cadastral na Vida ou Cliente"

	PRIVATE	aCores := 	{ { "SZZ->ZZ_STATUS='1'", 'BR_AMARELO'    },;
		{ "SZZ->ZZ_STATUS='2'", 'BR_VERDE' } }

	PRIVATE aCdCores  := { 	{ 'BR_AMARELO',"Cadastrado" },;
		{ 'BR_VERDE'  ,"Confirmado" } }

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Chama funcao de Browse...                                           ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

	dbselectarea("SZZ")
	SZZ->(dbGoTop())
	SZZ->(mBrowse(06,01,22,75,'SZZ',,,,,,aCores,,,,, .F. ))

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Fim da Rotina Principal...                                          ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Return Nil

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ CRJPMOV  ³ Autor ³ Thiago Machado Correa ³ Data ³ 23.02.08 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Manutencao do cadastro					                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ PL280MOV(cAlias,nReg,nOpc)                                 ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

User Function CRJPMOV(cAlias,nReg,nOpc)

	Local _nH
	Local I__f := 0 

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Uso na enchoice...                                                  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	LOCAL nOpca    := 0
	LOCAL aSize    := {}
	LOCAL aPosObj  := {}
	LOCAL aInfo    := {}
	Local aObjects := {}
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Dados da Enchoice...                                                ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	PRIVATE aTELA[0][0]
	PRIVATE aGETS[0]
	PRIVATE oEncSZZ
	PRIVATE oDlg

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Genericos...                                                        ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	PRIVATE nOpcx := nOpc

	// INICIO - SERGIO CUNHA - Chamado - ID: 26414
	PRIVATE cAutCon := GetNewPar("MV_YAPUDAD","000843")

	If nopc== K_Confirma .and. !( RetCodUsr() $ AllTrim(cAutCon) )
		MsgAlert("Acesso permitido somente aos usuarios do setor de cadastrado. Caso necessite aprovação imediata entrar em contato com a equipe do Cadastro", "AVISO" )
		Return .F.
	Endif
	// FIM - SERGIO CUNHA - Chamado - ID: 26414

	aSize := MsAdvSize(.T.)
	aObjects := {}

	AAdd( aObjects, { 315,  30, .T., .T. } )
	AAdd( aObjects, { 100,  70, .T., .T. } )

	aInfo   := { aSize[ 1 ], aSize[ 2 ], aSize[ 3 ], aSize[ 4 ], 3, 3 }
	aPosObj := MsObjSize( aInfo, aObjects, .T.)

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Valida Alteracao...                                                 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If nOpc = 4
		If SZZ->ZZ_STATUS == "2"
			MsgStop("Registro não pode ser alterado pois já está confirmado!")
			Return .F.
		Endif
	Endif

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Valida Exclusao...                                                  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If nOpc = 5
		If SZZ->ZZ_STATUS == "2"
			MsgStop("Registro não pode ser excluído pois já está confirmado!")
			Return .F.
		Endif
	Endif

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Monta Dialogo...                                                    ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	//DEFINE MSDIALOG oDlg TITLE cCadastro FROM aSize[7],0 To aSize[6],aSize[5] OF GetWndDefault() Pixel
	DEFINE MSDIALOG oDlg TITLE cCadastro FROM aSize[7],00 To aSize[6],aSize[5] OF oMainWnd Pixel

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Define folder...                                                    ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	//@ aPosObj[1][1],aPosObj[1][2] FOLDER oFolder SIZE aPosObj[1][3],aPosObj[1][4] OF oDlg PIXEL PROMPTS  OemtoAnsi(cCadastro)
	@ aPosObj[2][2],aPosObj[2][2] FOLDER oFolder SIZE aPosObj[2][3],aPosObj[2][4] OF oDlg PIXEL PROMPTS  OemtoAnsi(cCadastro)

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ ENCHOICE	                                                        ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If nOpcx == K_Incluir
		Copy "SZZ" TO Memory Blank
	Else
		Copy "SZZ" TO Memory
	Endif

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ MSMGET				                                                ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	//cAlias:="SZZ"
	//nReg:=SZZ->(RecNo())

	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	//Angelo Henrique - Data:24/01/2018
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	//Corrigindo o tamanho da tela
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	oFolder:nRight := oFolder:nHeight

	//oEncSZZ := MSMGet():New(cAlias,nReg,nOpcx,,,,,{aPosObj[1][1]-13,aPosObj[1][2],aPosObj[1][4]-15,aPosObj[1][3]-3},,,,,,oFolder:aDialogs[1],,,.F.)
	oEncSZZ := MSMGet():New(cAlias,nReg,nOpcx,,,,,{aPosObj[2,2],aPosObj[2,2],aPosObj[2,3],aPosObj[2,4]},,,,,,oFolder:aDialogs[1],,,.F.)

	//-----------------------------------------------------------------------------------------------
	//Angelo Henrique - Data: 28/01/2022
	//-----------------------------------------------------------------------------------------------
	//Para atender ao chamado: 82472
	//Onde os DAdos unificados será chamado diretamente pelo protocolo de atendimento
	//-----------------------------------------------------------------------------------------------
	If UPPER(AllTrim(FUNNAME())) == "CABA069"

		DbSelectArea("BA1")
		DbSetOrder(2)
		If Dbseek(xFilial("BA1")+ M->ZX_USUARIO)

			M->ZZ_CODVID 	:= BA1->BA1_MATVID
			M->ZZ_MATRIC 	:= BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG+ BA1_DIGITO)
			M->ZZ_NOME		:= BA1->BA1_NOMUSR
			M->ZZ_CEPUSR	:= BA1->BA1_CEPUSR
			M->ZZ_ENDERE	:= BA1->BA1_ENDERE
			M->ZZ_NR_END	:= BA1->BA1_NR_END
			M->ZZ_COMEND	:= BA1->BA1_COMEND
			M->ZZ_BAIRRO	:= BA1->BA1_BAIRRO
			M->ZZ_CODMUN	:= BA1->BA1_CODMUN
			M->ZZ_MUNICI	:= BA1->BA1_MUNICI
			M->ZZ_ESTADO	:= BA1->BA1_ESTADO
			M->ZZ_XDDD		:= BA1->BA1_XDDD
			M->ZZ_NROCEL	:= BA1->BA1_YCEL
			M->ZZ_DDD		:= BA1->BA1_DDD
			M->ZZ_TELEFO	:= BA1->BA1_TELEFO
			M->ZZ_SEGTEL	:= BA1->BA1_YTEL2
			M->ZZ_EMAIL		:= BA1->BA1_EMAIL

		EndIf

	EndIf



	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Ativa Dialog                                                        ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	ACTIVATE MSDIALOG oDlg ON INIT(CRJPInit(oDlg,{|| nOpca := 1,if(Obrigatorio(aGets,aTela) .And. VldInc() .And. CRJPDel(nOpc), Eval({|| oDlg:End()}) ,(nOpca:=3,.F.))},{|| nOpca := 3,oDlg:End()}))

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Inicio da Rotina de Gravacao dos Dados...                           ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If 	nOpca == K_OK

		If nOpcx <> K_Visualizar

			If nOpcx == K_Confirma
				U_CRJPCNF()
			Else

				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Abre semaforo...                                                         ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				_nH := PLSAbreSem("CRJP100.SMF",.F.)

				If _nH == 0
					msgalert("Rotina em uso por outro usuario. Tente novamente.")
					Return()
				Endif

				TCREFRESH(RetSqlName("SZZ"))

				BEGIN TRANSACTION

					//-----------------------------------------------------------------------------------------------
					//Angelo Henrique - Data: 28/01/2022
					//-----------------------------------------------------------------------------------------------
					//Para atender ao chamado: 82472
					//Onde os DAdos unificados será chamado diretamente pelo protocolo de atendimento
					//-----------------------------------------------------------------------------------------------
					If UPPER(AllTrim(FUNNAME())) == "CABA069"

						nReg:=SZZ->(RecNo())

					EndIf

					SZZ->(DbGoTo(nReg))

					If nOpcx == K_Incluir
						M->ZZ_SEQUEN := ProxReg()
					Endif

					PLUPTENC("SZZ",nOpcx)

				END TRANSACTION

				TCREFRESH(RetSqlName("SZZ"))

				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Fecha semaforo...                                                        ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				PLSFechaSem(_nH,"CRJP100.SMF")

			Endif

		Endif
	Endif

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Fim da Rotina Principal					                            ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ CRJPInit  ³ Autor ³ Thiago Machado Correa³ Data ³ 23.02.08 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Barra de Ferramentas                                       ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function CRJPInit(oDlg,bOk,bCancel,lMessageDel)
	LOCAL aButtons    := {}
Return(EnchoiceBar(oDlg,bOk,bCancel,.F.,aButtons))

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ CRJPDel ³ Autor ³ Thiago Machado Correa³ Data ³ 23.02.08 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Validacao de delecao do cadastro 			            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function CRJPDel(nOpc)

	LOCAL lRet := .T.

	If nOpc # K_Excluir
		Return .T.
	Endif

	If SZZ->ZZ_STATUS == "2"
		MsgStop("Registro não pode ser excluído pois já está confirmado!")
		lRet := .F.
	Endif

Return(lRet)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ ProxReg ³ Autor ³ Thiago Machado Correa³ Data ³ 23.02.08 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Retorna proximo codigo sequencial 			            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ProxReg()

	Local cRet := ""
	Local cSql := ""

	//---------------------------------------------------------------------------------------------
	//Inicio - Angelo Henrique - Data: 05/08/2015
	//Alterado a query, pois as inclusões oriundas da internet estavam vindo sem o zeros na frente
	//causando assim a inconsistência e perda do sequencial correto.
	//---------------------------------------------------------------------------------------------

	//cSql := " SELECT MAX(ZZ_SEQUEN) SEQ FROM " + RetSqlName("SZZ")

	//---------------------------------------------------------------------------------------------
	//Fim - Angelo Henrique - Data: 05/08/2015
	//---------------------------------------------------------------------------------------------

	cSql := " SELECT MAX(TO_NUMBER(TRIM(ZZ_SEQUEN))) SEQ FROM " + RetSqlName("SZZ")
	cSql += " WHERE ZZ_FILIAL = '" + xFilial("SZZ") + "' AND D_E_L_E_T_ <> '*' "

	PLSQuery(cSql,"SZZSEQ")

	//cRet := StrZero((Val(SZZSEQ->SEQ)+1),8) -- Angelo Henrique - Data: 05/08/2015

	cRet := StrZero((SZZSEQ->SEQ+1),8)

	SZZSEQ->(DbCloseArea())

Return cRet

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ VldSZZ01³ Autor ³ Thiago Machado Correa³ Data ³ 23.02.08 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Valida campo ZZ_CODVID						            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function VldSZZ01(cCodBTS,cTipAlt)

	Local lRet := .T.
	Local lCPF := .F.
	Local aCPF := {}
	Local nTmp := 0

	BTS->(DbSetOrder(1))
	If ! BTS->(MsSeek(xFilial("BTS")+cCodBTS))
		MsgStop("Vida não cadastrada: "+cCodBTS+" !")
		Return .F.
	Endif

	BA1->(DbSetOrder(7))
	If ! BA1->(MsSeek(xFilial("BA1")+cCodBTS))
		MsgStop("Usuário não cadastrado com a vida: "+cCodBTS+" !")
		Return .F.
	Endif

	BA3->(DbSetOrder(1))
	If ! BA3->(MsSeek(xFilial("BA1")+BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC)))
		MsgStop("Usuário sem família cadastrada!")
		Return .F.
	Endif

	M->ZZ_TPPES := IIF(BA3->BA3_TIPOUS=="1","PF","PJ")

	If cTipAlt == "3"

		While BA1->BA1_MATVID == cCodBTS .and. ! BA1->(Eof())
			If ! Empty(BA1->BA1_CPFUSR)
				aAdd(aCPF,Alltrim(BA1->BA1_CPFUSR))
			Endif
			BA1->(DbSkip())
		EndDo

		SA1->(DbSetOrder(3))

		For nTmp := 1 to Len(aCPF)
			If SA1->(MsSeek(xFilial("SA1")+aCPF[nTmp]))
				lCPF := .T.
				Exit
			Endif
		Next

		If ! lCPF
			MsgStop("Cliente não cadastrado com a vida: "+cCodBTS+" !")
			Return .F.
		Endif

	Endif

Return lRet

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ VldSZZ02³ Autor ³ Thiago Machado Correa³ Data ³ 23.02.08 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Valida campo ZZ_CODCLI						            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function VldSZZ02(cCodSA1,cTipAlt)

	Local lRet := .T.

	SA1->(DbSetOrder(1))
	If ! SA1->(MsSeek(xFilial("SA1")+cCodSA1))
		MsgStop("Cliente não cadastrado: "+cCodSA1+" !")
		Return .F.
	Endif

	M->ZZ_TPPES := SA1->A1_PESSOA

	If cTipAlt == "3"

		If Empty(SA1->A1_CGC)
			MsgStop("Cliente sem CNPJ/CPF cadastrado: "+cCodSA1+" !")
			Return .F.
		Else

			BA1->(DbSetOrder(4))
			If ! BA1->(MsSeek(xFilial("BA1")+Alltrim(SA1->A1_CGC)))
				MsgStop("Usuário não cadastrado com o cliente: "+cCodSA1+" !")
				Return .F.
			Endif

			BTS->(DbSetOrder(1))
			If ! BTS->(MsSeek(xFilial("BTS")+BA1->BA1_MATVID))
				MsgStop("Vida não cadastrada com o cliente: "+cCodSA1+" !")
				Return .F.
			Endif

		Endif
	Endif

Return lRet

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ VldSZZ03³ Autor ³ Thiago Machado Correa³ Data ³ 23.02.08 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Valida campo ZZ_TIPALT						            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function VldSZZ03()

	M->ZZ_CODCLI := Space(06)
	M->ZZ_CODVID := Space(08)
	M->ZZ_NOME   := Space(50)

Return .T.

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ VldInc  ³ Autor ³ Thiago Machado Correa³ Data ³ 23.02.08 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Valida campos ZZ_CODCLI E ZZ_CODVID		                ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function VldInc()

	Local lRet := .T.
	Local cMsg := ""

	If Empty(M->ZZ_CODVID) .and. Empty(M->ZZ_CODCLI)
		MsgStop("Informe o código do Cliente ou da Vida!")
		lRet := .F.
	Endif

	/*
	//---------------------------------------------------------------------------------------
	//Angelo Henrique - Data:07/07/2016
	//Chamado 28856 - Solicitado que não seja permitido a inclusão da vida sem o CNS
	//---------------------------------------------------------------------------------------
	If Empty(M->ZZ_NRCRNA)

		MsgStop("Informe o Número do CNS!")
		lRet := .F.

	EndIf
	*/

	// FABIO BIANCHINI - 13/06/2020
	If M->ZZ_DEBAUT=='1' .AND. EMPTY(M->ZZ_BCOCLI) .AND. EMPTY(M->ZZ_AGECLI).AND. EMPTY(M->ZZ_CTACLI).AND. EMPTY(M->ZZ_VENCTO)
		cMsg := 'PARA DÉBITO AUTOMÁTICO TODOS OS CAMPOS REFERENTE À CONTA DEVEM ESTAR PREENCHIDOS' + cEnt
		cMsg += 'VERIFIQUE INFORMAÇÕES DE BANCO/AGENCIA/CONTA/VENCIMENTO'
		MsgAlert(cMsg,"AVISO")
		lRet := .F.
	Endif
	// FIM -
Return lRet

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ CRJPLEG ³ Autor ³ Thiago Machado Correa³ Data ³ 23.02.08 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Legenda										            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function CRJPLEG()

	Local aLegenda := { 	{ aCdCores[1,1],aCdCores[1,2] },;
		{ aCdCores[2,1],aCdCores[2,2] } }

	BrwLegenda(cCadastro,"Status" ,aLegenda)

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ CRJPCNF ³ Autor ³ Thiago Machado Correa³ Data ³ 23.02.08 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Confirma cadastro							            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function CRJPCNF()
	local CODVID := ' '
	Local cAlias := getNextalias() // Mateus Medeiros - Data: 28/12/2017
	Local lPrep  := .F.     	   // Mateus Medeiros - Data: 28/12/2017

	Local _cCodCli	:= "" //Angelo Henrique - Data: 29/09/2017

	Local _lDebt	:= .T.

	If SZZ->ZZ_STATUS == "2"
		MsgStop("Registro já confirmado!")
		Return .F.
	Endif

	If ! MsgYesNo("Deseja confirmar a alteração cadastral ?","Confirmação")
		Return .F.
	Endif

	//Inicia Transacao
	BEGIN TRANSACTION

		//Caso seja debito automático pula todo o resto, executa somente o necessário para
		//atualização das informações importantes
		IF AllTrim(SZZ->ZZ_DEBAUT) == "1"

			_lDebt := DebAutom()

			//Caso tenha dado erro é necessário sair da transação

			If !( _lDebt )

				DisarmTRANSACTION()

			EndIf

		Else

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Atualiza Cliente						                            ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If ! Empty(SZZ->ZZ_CODCLI)

				_cCodCli := StrZero(Val(SZZ->ZZ_CODCLI), TAMSX3("A1_COD")[1]) //Angelo Henrique - Data: 29/09/2017

				SA1->(DbSetOrder(1))
				//------------------------------------------------
				//Angelo Henrique - Data:29/09/2017
				//------------------------------------------------
				//Correção para achar o cliente correto
				//Em alguns casos vinha com menos caracteres
				//------------------------------------------------
				//If SA1->(MsSeek(xFilial("SA1")+SZZ->ZZ_CODCLI))

				If SA1->(MsSeek(xFilial("SA1") + _cCodCli))

					SA1->(RecLock("SA1",.F.))
					SA1->A1_END     := IIF(Empty(SZZ->ZZ_ENDERE),SA1->A1_END    ,Alltrim(SZZ->ZZ_ENDERE)+" "+Alltrim(SZZ->ZZ_NR_END)+" "+Alltrim(SZZ->ZZ_COMEND)) //Endereco
					SA1->A1_MUN     := IIF(Empty(SZZ->ZZ_MUNICI),SA1->A1_MUN    ,SZZ->ZZ_MUNICI) //Municipio
					SA1->A1_EST     := IIF(Empty(SZZ->ZZ_ESTADO),SA1->A1_EST    ,SZZ->ZZ_ESTADO) //Estado
					SA1->A1_BAIRRO  := IIF(Empty(SZZ->ZZ_BAIRRO),SA1->A1_BAIRRO ,SZZ->ZZ_BAIRRO) //Bairro
					SA1->A1_CEP     := IIF(Empty(SZZ->ZZ_CEPUSR),SA1->A1_CEP    ,SZZ->ZZ_CEPUSR) //CEP
					SA1->A1_DDI     := IIF(Empty(SZZ->ZZ_DDI)   ,SA1->A1_DDI    ,SZZ->ZZ_DDI)    //DDI
					SA1->A1_DDD     := IIF(Empty(SZZ->ZZ_DDD)   ," "    ,SZZ->ZZ_DDD)    //DDD
					SA1->A1_TEL     := IIF(Empty(SZZ->ZZ_TELEFO)," "    ,strtran( SZZ->ZZ_TELEFO, "-", "")) //Telefone
					SA1->A1_TELEX   := IIF(Empty(SZZ->ZZ_NROCEL),SA1->A1_TELEX  ,strtran( SZZ->ZZ_NROCEL , "-", "")) //Telex --//Conforme solicitado foi trocado a utilização deste campo para receber o celular
					SA1->A1_FAX     := IIF(Empty(SZZ->ZZ_FAX)   ,SA1->A1_FAX    ,strtran( SZZ->ZZ_FAX, "-", ""))    //Fax
					SA1->A1_CONTATO := IIF(Empty(SZZ->ZZ_CONTAT),SA1->A1_CONTATO,SZZ->ZZ_CONTAT) //Contato
					SA1->A1_CGC     := IIF(Empty(SZZ->ZZ_CGC)   ,SA1->A1_CGC    ,SZZ->ZZ_CGC)    //CNPJ/CPF
					SA1->A1_INSCR   := IIF(Empty(SZZ->ZZ_INSCR) ,SA1->A1_INSCR  ,SZZ->ZZ_INSCR)  //Ins.Estad.
					SA1->A1_DTNASC  := IIF(Empty(SZZ->ZZ_DTABNA),SA1->A1_DTNASC ,SZZ->ZZ_DTABNA) //Dt.Aber/Nasc
					SA1->A1_EMAIL   := IIF(Empty(SZZ->ZZ_EMAIL) ,SA1->A1_EMAIL  ,SZZ->ZZ_EMAIL)  //E-Mail
					SA1->A1_XDDD    := IIF(Empty(SZZ->ZZ_XDDD)  ,SA1->A1_XDDD   ,SZZ->ZZ_XDDD )  //DDD do Celular
					SA1->(MsUnlock())

					If SZZ->ZZ_TIPALT == "3" .and. ! Empty(SA1->A1_CGC)

						// Validação quando o cpf for do preposto
						cQuery := " SELECT COUNT(*) CONT FROM "+RetSqlName("SA1")+" WHERE A1_CGC = '"+SA1->A1_CGC+"' AND D_E_L_E_T_ = ' ' AND A1_MSBLQL IN (' ','2')"

						PLSQuery(cQuery,cAlias)

						if (cAlias)->CONT > 1 // VALIDA A EXISTÊNCIA DE MAIS DE UM CLIENTE
							lPrep := .T.
						Endif

						if select(cAlias) > 0
							dbselectarea(cAlias)
							dbclosearea()
						endif

						// 28/12/2017 - Mateus Medeiros - chamado 45937
						// Devido os beneficiários que possuem o campo BA1_CPFPRE (preposto) preenchido
						//  não possuirem o mesmo cpf do cadastro de beneficiários e no cadastro de clientes,
						// foi realizado o ajuste para pesquisar o beneficiário pelo  Nome ao invés do CPF
						if lPrep
							BA1->(DbSetOrder(3))
							BA1->(MsSeek(xFilial("BA1")+Alltrim(SA1->A1_NOME)))
						else
							BA1->(DbSetOrder(4))
							BA1->(MsSeek(xFilial("BA1")+Alltrim(SA1->A1_CGC)))
						endif

						While BA1->(!Eof()) .and. ( BA1->BA1_CPFUSR == Alltrim(SA1->A1_CGC) .OR. Alltrim(SA1->A1_NOME) == Alltrim(BA1->BA1_NOMUSR))

							BA1->(RecLock("BA1",.F.))
							BA1->BA1_CEPUSR := IIF(Empty(SZZ->ZZ_CEPUSR),BA1->BA1_CEPUSR,SZZ->ZZ_CEPUSR) //CEP
							BA1->BA1_ENDERE := IIF(Empty(SZZ->ZZ_ENDERE),BA1->BA1_ENDERE,SZZ->ZZ_ENDERE) //Endereco
							BA1->BA1_NR_END := IIF(Empty(SZZ->ZZ_NR_END),BA1->BA1_NR_END,SZZ->ZZ_NR_END) //Numero
							BA1->BA1_COMEND := IIF(Empty(SZZ->ZZ_COMEND)," ",SZZ->ZZ_COMEND) //Complemento
							BA1->BA1_BAIRRO := IIF(Empty(SZZ->ZZ_BAIRRO),BA1->BA1_BAIRRO,SZZ->ZZ_BAIRRO) //Bairro
							BA1->BA1_CODMUN := IIF(Empty(SZZ->ZZ_CODMUN),BA1->BA1_CODMUN,SZZ->ZZ_CODMUN) //Cd Municipio
							BA1->BA1_MUNICI := IIF(Empty(SZZ->ZZ_MUNICI),BA1->BA1_MUNICI ,SZZ->ZZ_MUNICI) //Municipio
							BA1->BA1_ESTADO := IIF(Empty(SZZ->ZZ_ESTADO),BA1->BA1_ESTADO,SZZ->ZZ_ESTADO) //Estado
							BA1->BA1_DDD    := IIF(Empty(SZZ->ZZ_DDD)   ," "   ,SZZ->ZZ_DDD)    //DDD
							BA1->BA1_TELEFO := IIF(Empty(SZZ->ZZ_TELEFO)," ",strtran( SZZ->ZZ_TELEFO,"-", ""))//Telefone
							BA1->BA1_MAE    := IIF(Empty(SZZ->ZZ_MAE)   ,BA1->BA1_MAE   ,SZZ->ZZ_MAE)    //Mae
							BA1->BA1_CPFMAE := IIF(Empty(SZZ->ZZ_CPFMAE),BA1->BA1_CPFMAE,SZZ->ZZ_CPFMAE) //CPF Mae
							BA1->BA1_NOMPRE := IIF(Empty(SZZ->ZZ_NOMPRE),BA1->BA1_NOMPRE,SZZ->ZZ_NOMPRE) //Nm.Preposto
							BA1->BA1_CPFPRE := IIF(Empty(SZZ->ZZ_CPFPRE),BA1->BA1_CPFPRE,SZZ->ZZ_CPFPRE) //CPF Preposto
							BA1->BA1_XDDD   := IIF(Empty(SZZ->ZZ_XDDD)  ,BA1->BA1_XDDD  ,SZZ->ZZ_XDDD )  //DDD do Celular
							BA1->BA1_YCEL   := IIF(Empty(SZZ->ZZ_NROCEL),BA1->BA1_YCEL  ,strtran( SZZ->ZZ_NROCEL,"-", "" )) //No Celular
							BA1->BA1_YTEL2  := IIF(Empty(SZZ->ZZ_SEGTEL),BA1->BA1_YTEL2 ,strtran( SZZ->ZZ_SEGTEL,"-", "" )) //2o Telefone
							BA1->BA1_EMAIL  := IIF(Empty(SZZ->ZZ_EMAIL) ,BA1->BA1_EMAIL ,SZZ->ZZ_EMAIL)  //Email
							BA1->BA1_XSMAIL := IIF(Empty(SZZ->ZZ_XSMAIL),BA1->BA1_XSMAIL,SZZ->ZZ_XSMAIL) //Possui Email
							BA1->(MsUnlock())

							BTS->(DbSetOrder(1))
							BTS->(MsSeek(xFilial("BTS")+BA1->BA1_MATVID))

							While BTS->BTS_MATVID == BA1->BA1_MATVID .and. ! BTS->(Eof())

								BTS->(RecLock("BTS",.F.))
								BTS->BTS_CEPUSR := IIF(Empty(SZZ->ZZ_CEPUSR),BTS->BTS_CEPUSR,SZZ->ZZ_CEPUSR) //CEP
								BTS->BTS_ENDERE := IIF(Empty(SZZ->ZZ_ENDERE),BTS->BTS_ENDERE,SZZ->ZZ_ENDERE) //Endereco
								BTS->BTS_NR_END := IIF(Empty(SZZ->ZZ_NR_END),BTS->BTS_NR_END,SZZ->ZZ_NR_END) //Numero
								BTS->BTS_COMEND := IIF(Empty(SZZ->ZZ_COMEND)," ",SZZ->ZZ_COMEND) //Complemento
								BTS->BTS_BAIRRO := IIF(Empty(SZZ->ZZ_BAIRRO),BTS->BTS_BAIRRO,SZZ->ZZ_BAIRRO) //Bairro
								BTS->BTS_CODMUN := IIF(Empty(SZZ->ZZ_CODMUN),BTS->BTS_CODMUN,SZZ->ZZ_CODMUN) //Cd Municipio
								BTS->BTS_MUNICI := IIF(Empty(SZZ->ZZ_MUNICI),BTS->BTS_MUNICI,SZZ->ZZ_MUNICI) //Municipio
								BTS->BTS_ESTADO := IIF(Empty(SZZ->ZZ_ESTADO),BTS->BTS_ESTADO,SZZ->ZZ_ESTADO) //Estado
								BTS->BTS_DDD    := IIF(Empty(SZZ->ZZ_DDD)   ," "   ,SZZ->ZZ_DDD)    //DDD
								BTS->BTS_TELEFO := IIF(Empty(SZZ->ZZ_TELEFO)," ",strtran( SZZ->ZZ_TELEFO,"-", "" )) //Telefone
								BTS->BTS_MAE    := IIF(Empty(SZZ->ZZ_MAE)   ,BTS->BTS_MAE   ,SZZ->ZZ_MAE)    //Mae
								BTS->BTS_CPFMAE := IIF(Empty(SZZ->ZZ_CPFMAE),BTS->BTS_CPFMAE,SZZ->ZZ_CPFMAE) //CPF Mae
								BTS->BTS_DATMAE := IIF(Empty(SZZ->ZZ_DATMAE),BTS->BTS_DATMAE,SZZ->ZZ_DATMAE) //CPF Mae
								BTS->BTS_NOMPRE := IIF(Empty(SZZ->ZZ_NOMPRE),BTS->BTS_NOMPRE,SZZ->ZZ_NOMPRE) //Nm.Preposto
								BTS->BTS_CPFPRE := IIF(Empty(SZZ->ZZ_CPFPRE),BTS->BTS_CPFPRE,SZZ->ZZ_CPFPRE) //CPF Preposto
								BTS->BTS_XDDD   := IIF(Empty(SZZ->ZZ_XDDD)  ,BTS->BTS_XDDD  ,SZZ->ZZ_XDDD )  //DDD do Celular
								BTS->BTS_YCEL   := IIF(Empty(SZZ->ZZ_NROCEL),BTS->BTS_YCEL  ,strtran( SZZ->ZZ_NROCEL,"-", "" )) //No Celular
								BTS->BTS_YTEL2  := IIF(Empty(SZZ->ZZ_SEGTEL),BTS->BTS_YTEL2 ,strtran( SZZ->ZZ_SEGTEL,"-", "" )) //2o Telefone
								BTS->BTS_EMAIL  := IIF(Empty(SZZ->ZZ_EMAIL) ,BTS->BTS_EMAIL ,SZZ->ZZ_EMAIL)  //E-Mail
								BTS->BTS_NRCRNA := IIF(Empty(SZZ->ZZ_NRCRNA),BTS->BTS_NRCRNA ,SZZ->ZZ_NRCRNA) //Nr Cart Nac. -- Angelo Henrique - Data: 04/08/2015
								BTS->BTS_XSMAIL := IIF(Empty(SZZ->ZZ_XSMAIL),BTS->BTS_XSMAIL ,SZZ->ZZ_XSMAIL) //Possui E-mail
								BTS->(MsUnlock())

								BTS->(DbSkip())
							EndDo

							If BA1->BA1_TIPUSU == "T"

								BA3->(DbSetOrder(1))
								If BA3->(MsSeek(xFilial("BA3")+BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC)))

									BA3->(RecLock("BA3",.F.))
									BA3->BA3_CEP    := IIF(Empty(SZZ->ZZ_CEPUSR),BA3->BA3_CEP   ,SZZ->ZZ_CEPUSR) //CEP
									BA3->BA3_END    := IIF(Empty(SZZ->ZZ_ENDERE),BA3->BA3_END   ,SZZ->ZZ_ENDERE) //Endereco
									BA3->BA3_NUMERO := IIF(Empty(SZZ->ZZ_NR_END),BA3->BA3_NUMERO,SZZ->ZZ_NR_END) //Numero
									BA3->BA3_COMPLE := IIF(Empty(SZZ->ZZ_COMEND)," ",SZZ->ZZ_COMEND) //Complemento
									BA3->BA3_BAIRRO := IIF(Empty(SZZ->ZZ_BAIRRO),BA3->BA3_BAIRRO,SZZ->ZZ_BAIRRO) //Bairro
									BA3->BA3_CODMUN := IIF(Empty(SZZ->ZZ_CODMUN),BA3->BA3_CODMUN,SZZ->ZZ_CODMUN) //Cd Municipio
									BA3->BA3_DESMUN := IIF(Empty(SZZ->ZZ_MUNICI),BA3->BA3_DESMUN,SZZ->ZZ_MUNICI) //Municipio
									BA3->BA3_MUN    := IIF(Empty(SZZ->ZZ_MUNICI),BA3->BA3_MUN   ,SZZ->ZZ_MUNICI) //Municipio
									BA3->BA3_ESTADO := IIF(Empty(SZZ->ZZ_ESTADO),BA3->BA3_ESTADO,SZZ->ZZ_ESTADO) //Estado
									BA3->(MsUnlock())

								Endif
							Endif

							BA1->(DbSkip())
						EndDo

					Endif
				Endif
			Endif

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Atualiza Vida/Usuario					                            ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If ! Empty(SZZ->ZZ_CODVID) .And. SZZ->ZZ_TIPALT $ ("2|3")
				CODVID := StrZero(val(SZZ->ZZ_CODVID), 8)

				BTS->(DbSetOrder(1))
				//BTS->(MsSeek(xFilial("BTS")+SZZ->ZZ_CODVID))
				BTS->(MsSeek(xFilial("BTS")+CODVID ))

				While BTS->BTS_MATVID == CODVID  .and. ! BTS->(Eof())

					BTS->(RecLock("BTS",.F.))
					BTS->BTS_CEPUSR := IIF(Empty(SZZ->ZZ_CEPUSR),BTS->BTS_CEPUSR,SZZ->ZZ_CEPUSR) //CEP
					BTS->BTS_ENDERE := IIF(Empty(SZZ->ZZ_ENDERE),BTS->BTS_ENDERE,SZZ->ZZ_ENDERE) //Endereco
					BTS->BTS_NR_END := IIF(Empty(SZZ->ZZ_NR_END),BTS->BTS_NR_END,SZZ->ZZ_NR_END) //Numero
					BTS->BTS_COMEND := IIF(Empty(SZZ->ZZ_COMEND)," ",SZZ->ZZ_COMEND) //Complemento
					BTS->BTS_BAIRRO := IIF(Empty(SZZ->ZZ_BAIRRO),BTS->BTS_BAIRRO,SZZ->ZZ_BAIRRO) //Bairro
					BTS->BTS_CODMUN := IIF(Empty(SZZ->ZZ_CODMUN),BTS->BTS_CODMUN,SZZ->ZZ_CODMUN) //Cd Municipio
					BTS->BTS_MUNICI := IIF(Empty(SZZ->ZZ_MUNICI),BTS->BTS_MUNICI,SZZ->ZZ_MUNICI) //Municipio
					BTS->BTS_ESTADO := IIF(Empty(SZZ->ZZ_ESTADO),BTS->BTS_ESTADO,SZZ->ZZ_ESTADO) //Estado
					BTS->BTS_DDD    := IIF(Empty(SZZ->ZZ_DDD)   ," "   ,SZZ->ZZ_DDD)    //DDD
					BTS->BTS_TELEFO := IIF(Empty(SZZ->ZZ_TELEFO)," ",strtran( SZZ->ZZ_TELEFO,"-", "" )) //Telefone
					BTS->BTS_MAE    := IIF(Empty(SZZ->ZZ_MAE)   ,BTS->BTS_MAE   ,SZZ->ZZ_MAE)    //Mae
					BTS->BTS_CPFMAE := IIF(Empty(SZZ->ZZ_CPFMAE),BTS->BTS_CPFMAE,SZZ->ZZ_CPFMAE) //CPF Mae
					BTS->BTS_DATMAE := IIF(Empty(SZZ->ZZ_DATMAE),BTS->BTS_DATMAE,SZZ->ZZ_DATMAE) //CPF Mae
					BTS->BTS_NOMPRE := IIF(Empty(SZZ->ZZ_NOMPRE),BTS->BTS_NOMPRE,SZZ->ZZ_NOMPRE) //Nm.Preposto
					BTS->BTS_CPFPRE := IIF(Empty(SZZ->ZZ_CPFPRE),BTS->BTS_CPFPRE,SZZ->ZZ_CPFPRE) //CPF Preposto
					BTS->BTS_XDDD   := IIF(Empty(SZZ->ZZ_XDDD)  ,BTS->BTS_XDDD  ,SZZ->ZZ_XDDD )  //DDD do Celular
					BTS->BTS_YCEL   := IIF(Empty(SZZ->ZZ_NROCEL),BTS->BTS_YCEL  ,strtran( SZZ->ZZ_NROCEL,"-", "" )) //No Celular
					BTS->BTS_YTEL2  := IIF(Empty(SZZ->ZZ_SEGTEL),BTS->BTS_YTEL2 ,strtran( SZZ->ZZ_SEGTEL,"-", "" )) //2o Telefone
					BTS->BTS_EMAIL  := IIF(Empty(SZZ->ZZ_EMAIL) ,BTS->BTS_EMAIL ,SZZ->ZZ_EMAIL)  //E-Mail
					BTS->BTS_NRCRNA := IIF(Empty(SZZ->ZZ_NRCRNA),BTS->BTS_NRCRNA ,SZZ->ZZ_NRCRNA) //Nr Cart Nac. -- Angelo Henrique - Data: 04/08/2015
					BTS->BTS_XSMAIL := IIF(Empty(SZZ->ZZ_XSMAIL),BTS->BTS_XSMAIL ,SZZ->ZZ_XSMAIL) //Possui E-mail
					BTS->(MsUnlock())

					BTS->(DbSkip())
				EndDo

				BA1->(DbSetOrder(7))
				//BA1->(MsSeek(xFilial("BA1")+SZZ->ZZ_CODVID)) -- Angelo Henrique - Data:29/09/2017

				BA1->(MsSeek(xFilial("BA1") + CODVID))

				//While BA1->BA1_MATVID == SZZ->ZZ_CODVID .and. ! BA1->(Eof()) -- Angelo Henrique - Data:29/09/2017
				While BA1->BA1_MATVID == CODVID .and. ! BA1->(Eof())

					BA1->(RecLock("BA1",.F.))
					BA1->BA1_CEPUSR := IIF(Empty(SZZ->ZZ_CEPUSR),BA1->BA1_CEPUSR,SZZ->ZZ_CEPUSR) //CEP
					BA1->BA1_ENDERE := IIF(Empty(SZZ->ZZ_ENDERE),BA1->BA1_ENDERE,SZZ->ZZ_ENDERE) //Endereco
					BA1->BA1_NR_END := IIF(Empty(SZZ->ZZ_NR_END),BA1->BA1_NR_END,SZZ->ZZ_NR_END) //Numero
					BA1->BA1_COMEND := IIF(Empty(SZZ->ZZ_COMEND)," ",SZZ->ZZ_COMEND) //Complemento
					BA1->BA1_BAIRRO := IIF(Empty(SZZ->ZZ_BAIRRO),BA1->BA1_BAIRRO,SZZ->ZZ_BAIRRO) //Bairro
					BA1->BA1_CODMUN := IIF(Empty(SZZ->ZZ_CODMUN),BA1->BA1_CODMUN,SZZ->ZZ_CODMUN) //Cd Municipio
					BA1->BA1_MUNICI := IIF(Empty(SZZ->ZZ_MUNICI),BA1->BA1_MUNICI,SZZ->ZZ_MUNICI) //Municipio
					BA1->BA1_ESTADO := IIF(Empty(SZZ->ZZ_ESTADO),BA1->BA1_ESTADO,SZZ->ZZ_ESTADO) //Estado
					BA1->BA1_DDD    := IIF(Empty(SZZ->ZZ_DDD)   ," "   ,SZZ->ZZ_DDD)    //DDD
					BA1->BA1_TELEFO := IIF(Empty(SZZ->ZZ_TELEFO)," ",strtran( SZZ->ZZ_TELEFO,"-", "" )) //Telefone
					BA1->BA1_MAE    := IIF(Empty(SZZ->ZZ_MAE)   ,BA1->BA1_MAE   ,SZZ->ZZ_MAE)    //Mae
					BA1->BA1_CPFMAE := IIF(Empty(SZZ->ZZ_CPFMAE),BA1->BA1_CPFMAE,SZZ->ZZ_CPFMAE) //CPF Mae
					BA1->BA1_NOMPRE := IIF(Empty(SZZ->ZZ_NOMPRE),BA1->BA1_NOMPRE,SZZ->ZZ_NOMPRE) //Nm.Preposto
					BA1->BA1_CPFPRE := IIF(Empty(SZZ->ZZ_CPFPRE),BA1->BA1_CPFPRE,SZZ->ZZ_CPFPRE) //CPF Preposto
					BA1->BA1_XDDD   := IIF(Empty(SZZ->ZZ_XDDD)  ,BA1->BA1_XDDD  ,SZZ->ZZ_XDDD )  //DDD do Celular
					BA1->BA1_YCEL   := IIF(Empty(SZZ->ZZ_NROCEL),BA1->BA1_YCEL  ,strtran( SZZ->ZZ_NROCEL,"-", "" )) //No Celular
					BA1->BA1_YTEL2  := IIF(Empty(SZZ->ZZ_SEGTEL),BA1->BA1_YTEL2 ,strtran( SZZ->ZZ_SEGTEL,"-", "" )) //2o Telefone
					BA1->BA1_EMAIL  := IIF(Empty(SZZ->ZZ_EMAIL) ,BA1->BA1_EMAIL ,SZZ->ZZ_EMAIL)  //Email
					BA1->BA1_XSMAIL  := IIF(Empty(SZZ->ZZ_XSMAIL) ,BA1->BA1_XSMAIL ,SZZ->ZZ_XSMAIL)  //Possui Email
					BA1->(MsUnlock())

					//Leonardo Portella - 13/05/11 - Inicio

					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³Somente altera os dados da familia (BA3) caso deseje alterar ³
					//³o cliente pois os dados de cobranca para a familia sao os da ³
					//³BA3 e nao os da SA1. (ZZ_TIPALT == "2" -> Vida somente)      ³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

					If BA1->BA1_TIPUSU == "T" .and. SZZ->ZZ_TIPALT <> "2"
						//If BA1->BA1_TIPUSU == "T"

						//Leonardo Portella - 13/05/11 - Fim

						BA3->(DbSetOrder(1))
						If BA3->(MsSeek(xFilial("BA3")+BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC)))

							BA3->(RecLock("BA3",.F.))
							BA3->BA3_CEP    := IIF(Empty(SZZ->ZZ_CEPUSR),BA3->BA3_CEP   ,SZZ->ZZ_CEPUSR) //CEP
							BA3->BA3_END    := IIF(Empty(SZZ->ZZ_ENDERE),BA3->BA3_END   ,SZZ->ZZ_ENDERE) //Endereco
							BA3->BA3_NUMERO := IIF(Empty(SZZ->ZZ_NR_END),BA3->BA3_NUMERO,SZZ->ZZ_NR_END) //Numero
							BA3->BA3_COMPLE := IIF(Empty(SZZ->ZZ_COMEND)," ",SZZ->ZZ_COMEND) //Complemento
							BA3->BA3_BAIRRO := IIF(Empty(SZZ->ZZ_BAIRRO),BA3->BA3_BAIRRO,SZZ->ZZ_BAIRRO) //Bairro
							BA3->BA3_CODMUN := IIF(Empty(SZZ->ZZ_CODMUN),BA3->BA3_CODMUN,SZZ->ZZ_CODMUN) //Cd Municipio
							BA3->BA3_DESMUN := IIF(Empty(SZZ->ZZ_MUNICI),BA3->BA3_DESMUN,SZZ->ZZ_MUNICI) //Municipio
							BA3->BA3_MUN    := IIF(Empty(SZZ->ZZ_MUNICI),BA3->BA3_MUN   ,SZZ->ZZ_MUNICI) //Municipio
							BA3->BA3_ESTADO := IIF(Empty(SZZ->ZZ_ESTADO),BA3->BA3_ESTADO,SZZ->ZZ_ESTADO) //Estado
							BA3->(MsUnlock())

						Endif
					Endif

					If ! Empty(BA1->BA1_CPFUSR)  .and. SZZ->ZZ_TIPALT != "2"

						SA1->(DbSetOrder(3))
						SA1->(MsSeek(xFilial("SA1")+Alltrim(BA1->BA1_CPFUSR)))

						While Alltrim(SA1->A1_CGC) == Alltrim(BA1->BA1_CPFUSR) .and. ! SA1->(Eof())

							SA1->(RecLock("SA1",.F.))
							SA1->A1_END     := IIF(Empty(SZZ->ZZ_ENDERE),SA1->A1_END    ,Alltrim(SZZ->ZZ_ENDERE)+" "+Alltrim(SZZ->ZZ_NR_END)+" "+Alltrim(SZZ->ZZ_COMEND)) //Endereco
							SA1->A1_COD_MUN := IIF(Empty(SZZ->ZZ_CODMUN),SA1->A1_COD_MUN ,SUBSTR(ALLTRIM(SZZ->ZZ_CODMUN),3,LEN(ALLTRIM(SZZ->ZZ_CODMUN)))) //Municipio
							SA1->A1_MUN     := IIF(Empty(SZZ->ZZ_MUNICI),SA1->A1_MUN    ,SZZ->ZZ_MUNICI) //Municipio
							SA1->A1_EST     := IIF(Empty(SZZ->ZZ_ESTADO),SA1->A1_EST    ,SZZ->ZZ_ESTADO) //Estado
							SA1->A1_BAIRRO  := IIF(Empty(SZZ->ZZ_BAIRRO),SA1->A1_BAIRRO ,SZZ->ZZ_BAIRRO) //Bairro
							SA1->A1_CEP     := IIF(Empty(SZZ->ZZ_CEPUSR),SA1->A1_CEP    ,SZZ->ZZ_CEPUSR) //CEP
							SA1->A1_DDI     := IIF(Empty(SZZ->ZZ_DDI)   ,SA1->A1_DDI    ,SZZ->ZZ_DDI)    //DDI
							SA1->A1_DDD     := IIF(Empty(SZZ->ZZ_DDD)   ," "    ,SZZ->ZZ_DDD)    //DDD
							SA1->A1_TEL     := IIF(Empty(SZZ->ZZ_TELEFO)," "    ,strtran( SZZ->ZZ_TELEFO,"-", "" )) //Telefone
							SA1->A1_XDDD    := IIF(Empty(SZZ->ZZ_XDDD)  ,SA1->A1_XDDD   ,SZZ->ZZ_XDDD )  //DDD do Celular
							SA1->A1_TELEX   := IIF(Empty(SZZ->ZZ_TELEX) ,SA1->A1_TELEX  ,strtran( SZZ->ZZ_TELEX,"-", "" ))  //Telex -- VIROU CELULAR
							SA1->A1_FAX     := IIF(Empty(SZZ->ZZ_FAX)   ,SA1->A1_FAX    ,SZZ->ZZ_FAX)    //Fax
							SA1->A1_CONTATO := IIF(Empty(SZZ->ZZ_CONTAT),SA1->A1_CONTATO,SZZ->ZZ_CONTAT) //Contato
							SA1->A1_CGC     := IIF(Empty(SZZ->ZZ_CGC)   ,SA1->A1_CGC    ,SZZ->ZZ_CGC)    //CNPJ/CPF
							SA1->A1_INSCR   := IIF(Empty(SZZ->ZZ_INSCR) ,SA1->A1_INSCR  ,SZZ->ZZ_INSCR)  //Ins.Estad.
							SA1->A1_DTNASC  := IIF(Empty(SZZ->ZZ_DTABNA),SA1->A1_DTNASC ,SZZ->ZZ_DTABNA) //Dt.Aber/Nasc
							SA1->A1_EMAIL   := IIF(Empty(SZZ->ZZ_EMAIL) ,SA1->A1_EMAIL  ,SZZ->ZZ_EMAIL)  //E-Mail
							SA1->(MsUnlock())

							SA1->(DbSkip())
						EndDo

					Endif

					BA1->(DbSkip())
				EndDo

			Endif

			SZZ->(RecLock("SZZ",.F.))
			SZZ->ZZ_USRCON := cUserName
			SZZ->ZZ_DATCON := Date()
			SZZ->ZZ_HORCON := Time()
			SZZ->ZZ_STATUS := "2"
			SZZ->(MsUnlock())

		EndIf

		//Finaliza Transacao
	END TRANSACTION

	If _lDebt

		MsgInfo("Cadastro atualizado com sucesso!")

	Else

		MsgInfo("Houve um erro e o processo não foi finalizado.")

	EndIf

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ CRJP100Z³ Autor ³ Angelo Henrique      ³ Data ³ 04.08.15 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Gatilho para preenchimento do campo CPF após a digitação ³±±
±±³Descri‡„o ³ do codigo do cliente                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ Caberj           			                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

User Function CRJP100Z(_nOpc)

	Local _aArea 	:= GetArea()
	Local _aAreA1	:= SA1->(GetArea())
	Local _aArBTS	:= BTS->(GetArea())
	Local _cCGC		:= ""

	Default _nOpc 	:= 1

	If _nOpc = 1

		DbSelectArea("SA1")
		DbSetOrder(1)
		If DbSeek(xFilial("SA1")+M->ZZ_CODCLI+M->ZZ_LOJACLI)

			_cCGC := SA1->A1_CGC

		EndIf

	Else

		DbSelectArea("BTS")
		DbSetOrder(1)
		If DbSeek(xFilial("BTS")+M->ZZ_CODVID)

			_cCGC := BTS->BTS_CPFUSR

		EndIf

	EndIf

	RestArea(_aArBTS)
	RestArea(_aAreA1)
	RestArea(_aArea)

Return _cCGC


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ CRJP100Y³ Autor ³ Angelo Henrique      ³ Data ³ 04.08.15 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Validacao do campo Nome na tabela SZZ quando a emrpesa   ³±±
±±³Descri‡„o ³ for prefeitura                                           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ Caberj           			                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

User Function CRJP100Y

	Local _aArea 	:= GetArea()
	Local _aAreA1	:= SA1->(GetArea())
	Local _aArBA1	:= BA1->(GetArea())
	Local _lRet		:= .F.
	Local _cMvPrf	:= GetMV("MV_XEMPPRF") //Parametro que contém as empresas da prefeitura


	DbSelectArea("BA1")
	DbSetOrder(7)
	If DbSeek(xFilial("BA1")+M->ZZ_CODVID)

		If AllTrim(BA1->BA1_CODEMP) $ _cMvPrf

			_lRet	:= .T.

		EndIf

	EndIf


	RestArea(_aArBA1)
	RestArea(_aAreA1)
	RestArea(_aArea)

Return _lRet


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ CRJP100W³ Autor ³ Angelo Henrique      ³ Data ³ 07.08.15 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Validacao do campo CPF para verificar se o mesmo já      ³±±
±±³Descri‡„o ³ existe na base.                                          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ Caberj           			                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

User Function CRJP100W

	Local _aArea 	:= GetArea()
	Local _aAreA1	:= SA1->(GetArea())
	Local _aAreBA1	:= BA1->(GetArea())
	Local _lRet		:= .T.
	Local _cEOL    	:= CHR(13)+CHR(10)

	DbSelectArea("SA1")
	DbSetOrder(3)
	If DbSeek(xFilial("SA1")+M->ZZ_CGC)

		Aviso("Atenção","O CPF informado já encontra-se cadastrado no seguinte cliente: " + _cEOL;
			+ "Nome: " + AllTrim(SA1->A1_NOME) + _cEOL + "Codigo: " + SA1->A1_COD, {"OK"})

		_lRet := .F.

	EndIf

	If _lRet

		DbSelectArea("BA1")
		DbSetOrder(4)
		If DbSeek(xFilial("SA1")+M->ZZ_CGC)

			Aviso("Atenção","O CPF informado já encontra-se cadastrado no seguinte beneficiário: " + _cEOL;
				+ "Nome: " + AllTrim(BA1->BA1_NOMUSR) + _cEOL + "Matric. Vida: " + BA1->BA1_MATVID, {"OK"})

			_lRet := .F.

		EndIf

	EndIf

	RestArea(_aAreBA1)
	RestArea(_aAreA1)
	RestArea(_aArea)

Return _lRet


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ CRJP100X³ Autor ³ Angelo Henrique      ³ Data ³ 07.08.15 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Validacao do campo CNS para verificar se o mesmo já      ³±±
±±³Descri‡„o ³ existe na base.                                          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ Caberj           			                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

User Function CRJP100X

	Local _aArea 	:= GetArea()
	Local _aAreBTS	:= BTS->(GetArea())
	Local _lRet		:= .T.
	Local _cEOL    	:= CHR(13)+CHR(10)
	Local _cAlias	:= GetNextAlias()
	Local _cNR		:= M->ZZ_NRCRNA
	Local _cMtVd	:= M->ZZ_CODVID

	BeginSql Alias _cAlias
		%noparser%

		SELECT
			BTS_MATVID,
			BTS_NOMUSR,
			BTS_CPFUSR,
			BTS_NRCRNA
		FROM
			%table:BTS% BTS
		WHERE
			BTS_FILIAL = %xFilial:BTS%
			AND BTS_NRCRNA = %Exp:_cNR%
			AND BTS_MATVID <> %Exp:_cMtVd%
			AND BTS_NRCRNA <> ' '
			AND BTS.%notDel%
	EndSql

	If !(_cAlias)->(Eof())

		Aviso("Atenção","O Nr Cart Nac. informado já encontra-se cadastrado no seguinte beneficiário: " + _cEOL;
			+ "Nome: " + AllTrim((_cAlias)->BTS_NOMUSR) + _cEOL + "Matric. Vida: " + (_cAlias)->BTS_MATVID, {"OK"})

		_lRet := .F.

	EndIf

	RestArea(_aAreBTS)
	RestArea(_aArea)

Return _lRet


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ CRJP100A³ Autor ³ Angelo Henrique      ³ Data ³ 31/01/18 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descrição ³ Rotina utilizada para desbloquear os registros locados   ³±±
±±³          ³ pela rotina CABA116 e CABA069, ambas rotinas são         ³±±
±±³          ³ executadas pelo atendimento pois envolvem o protocolo de ³±±
±±³          ³ atendimento e estava ficando com o registro locado.      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ Caberj           			                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

User Function CRJP100A()

	Local _aArea := GetArea()
	Local _aASZZ := SZZ->(GetArea())

	//-------------------------------------------------------------------
	//Se estiver locado é realizado o desbloqueio do registro,
	//pois o mesmo só foi criado pelo Protocolo de Atendimento
	//e não esta sendo utilizado
	//-------------------------------------------------------------------
	If !(DBRLock(SZZ->(RECNO())))

		DBRUnlock(SZZ->(RECNO()))

		Aviso("Atenção","Registro liberado para movimentação.",{"OK"})

	Else

		Aviso("Atenção","Este registro não esta travado por nenhum uruário.",{"OK"})

	EndIf

	RestArea(_aASZZ)
	RestArea(_aArea)

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ DebAutom³ Autor ³ Angelo Henrique      ³ Data ³ 10/06/20 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descrição ³ Rotina utilizada para atualizar as informações sobre o   ³±±
±±³          ³ debito automático vindo do site				            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ Caberj           			                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function DebAutom()

	Local _aArea 	:= GetArea()
	Local _aArBA1	:= BA1->(GetArea())
	Local _aArBI3	:= BI3->(GetArea())
	Local _aArBA3	:= BA3->(GetArea())
	Local _aArSZZ	:= SZZ->(GetArea())
	Local _aArSA1	:= SA1->(GetArea())
	Local cQuery	:= ""
	Local _cEOL    	:= CHR(13)+CHR(10)
	Local cAlias	:= GetNextAlias()
	Local _lRet		:= .T.
	Local _cGrpCob	:= ""
	//--------------------------------------------------------------------------
	//SERÁ ENCAMINHADO A MATRICULA DO BENEFICIÁRIO E O SEU CLIENTE JÁ PELO SITE
	//--------------------------------------------------------------------------
	DbSelectArea("BA1")
	DbSetOrder(2)
	if DbSeek(xFilial("BA1") + SZZ->ZZ_MATRIC)

		DbSelectArea("BI3")
		DbSetOrder(1) //BI3_FILIAL+BI3_CODINT+BI3_CODIGO+BI3_VERSAO
		if DbSeek(xFilial("BI3") + BA1->(BA1_CODINT+BA1_CODPLA))

			DbSelectArea("BA3")
			DbSetOrder(1) //BA3_FILIAL+BA3_CODINT+BA3_CODEMP+BA3_MATRIC+BA3_CONEMP+BA3_VERCON+BA3_SUBCON+BA3_VERSUB
			if DbSeek(xFilial("BA3") + BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_CONEMP+BA1_VERCON+BA1_SUBCON+BA1_VERSUB))

				cQuery := " SELECT										" + _cEOL
				cQuery += " 	SA6.A6_COD,								" + _cEOL
				cQuery += " 	SA6.A6_AGENCIA,							" + _cEOL
				cQuery += " 	SA6.A6_NUMCON							" + _cEOL
				cQuery += " FROM										" + _cEOL
				cQuery += " 	" + RetSqlName("SA6") + " SA6			" + _cEOL
				cQuery += " WHERE										" + _cEOL
				cQuery += " 	SA6.A6_COD = '" + SZZ->ZZ_BCOCLI + 	"'	" + _cEOL
				cQuery += " 	AND SA6.A6_XDEBAUT = '1'				" + _cEOL
				cQuery += " 	AND SA6.D_E_L_E_T_ = ' '				" + _cEOL

				PLSQuery(cQuery,cAlias)

				If !( (cAlias)->(EOF()) )

					//COlocar aqui para validar o cliente
					DbSelectArea("SA1")
					DbSetOrder(1) //A1_FILIAL+A1_COD+A1_LOJA
					If DbSeek(xFilial("SA1") + SZZ->ZZ_CODCLI + "01")

						//IIF(SE FOR DIA 25 = 0009, SENÃO MATER = 0002, AFINIDADE = 0003)
						If SZZ->ZZ_VENCTO = "25"

							//-----------------------------------------------------------------
							//Se for publico da PREVI, vai para um grupo distinto
							//-----------------------------------------------------------------
							If BA3->BA3_XHIST = '1' //BA3->BA3_TIPPAG $ ('01','08')

								_cGrpCob := "1002"

							Else

								_cGrpCob := "0009"

							EndIf

						elseif BI3->BI3_CODSEG = '004' //produto odonto

							_cGrpCob := "5007"

						elseIf BA3->BA3_CODEMP = '0001'

							//-----------------------------------------------------------------
							//Se for publico da PREVI, vai para um grupo distinto
							//-----------------------------------------------------------------
							If BA3->BA3_XHIST = '1' //BA3->BA3_TIPPAG $ ('01','08')

								_cGrpCob := "1001"

							Else

								_cGrpCob := "0002"

							EndIf

						else

							_cGrpCob := "0003"

						Endif

						//------------------------------------------------------------------
						//REALIZANDO AS ALTERAÇOES NA FAMILIA
						//------------------------------------------------------------------
						RecLock("BA3", .F.)

						//------------------------------------------------------------------
						//INFORMAÇÕES VINDAS DOS DADOS UNIFICADOS CONFORME CLIENTE PREENCHER
						//------------------------------------------------------------------
						BA3->BA3_TIPPAG := '06'//forma de cobrança vira 06
						BA3->BA3_BCOCLI := SZZ->ZZ_BCOCLI
						BA3->BA3_AGECLI := SZZ->ZZ_AGECLI
						BA3->BA3_CTACLI := SZZ->ZZ_CTACLI
						BA3->BA3_XBOLDG := ' ' //REMOVER MARCAÇÃO BOLETO DIGITAL
						BA3->BA3_XCMPDG := ' ' //REMOVER MARCAÇÃO BOLETO DIGITAL

						//------------------------------------------------------------------
						//INFORMAÇÕES PREENCHIDAS NA CABERJ PARA O PROCESSO DE DEBITO
						//------------------------------------------------------------------
						BA3->BA3_PORTAD := SZZ->ZZ_BCOCLI
						BA3->BA3_AGEDEP := (cAlias)->A6_AGENCIA
						BA3->BA3_CTACOR := (cAlias)->A6_NUMCON
						BA3->BA3_VENCTO := VAL(AllTrim(SZZ->ZZ_VENCTO))
						BA3->BA3_GRPCOB := _cGrpCob

						BA3->(MsUnlock())

						//------------------------------------------------------------------
						//Autualizando os dados do Cliente
						//------------------------------------------------------------------
						RecLock("SA1", .F.)

						SA1->A1_XBANCO := SZZ->ZZ_BCOCLI
						SA1->A1_XAGENC := SZZ->ZZ_AGECLI
						SA1->A1_XCONTA := SUBSTR(ALLTRIM(SZZ->ZZ_CTACLI),1,LEN(ALLTRIM(SZZ->ZZ_CTACLI)) - 1)
						SA1->A1_XDGCON := SUBSTR(ALLTRIM(SZZ->ZZ_CTACLI),LEN(ALLTRIM(SZZ->ZZ_CTACLI)),1)

						SA1->(MsUnlock())

						//------------------------------------------------------------------
						//Autualizando os dados unificados
						//------------------------------------------------------------------
						SZZ->(RecLock("SZZ",.F.))

						SZZ->ZZ_USRCON := cUserName
						SZZ->ZZ_DATCON := Date()
						SZZ->ZZ_HORCON := Time()
						SZZ->ZZ_STATUS := "2"

						SZZ->(MsUnlock())

					Else

						_lRet := .F.

						Aviso("Atenção","Favor rever o cliente, pois não foi encontrado o cliente selecionado no sistema.",{"OK"})

					EndIf

				else

					_lRet := .F.

					Aviso("Atenção","Favor rever os dados bancários, pois não foi encontrado banco cadastrado no sistema.",{"OK"})

				Endif

				if select(cAlias) > 0
					dbselectarea(cAlias)
					dbclosearea()
				endif

			endif

		EndIf


	endif

	RestArea(_aArSA1)
	RestArea(_aArSZZ)
	RestArea(_aArBA3)
	RestArea(_aArBI3)
	RestArea(_aArBA1)
	RestArea(_aArea )

Return _lRet
