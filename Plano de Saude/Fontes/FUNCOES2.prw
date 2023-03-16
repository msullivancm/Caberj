#Include "protheus.ch"
#Include "rwmake.ch"
#Include "topconn.ch"
#INCLUDE "plsmcon.ch"
#include "TCBROWSE.CH"
#include "PLSMGER.CH"
#include "ap5mail.ch"
#Include "totvs.ch"
#Include "TbiConn.Ch"
#include 'shell.ch'

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ VeFechCtb  ºAutor  ³ Leandro Brandao  º Data ³  30/04/07   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³funcao que critica se a data de atendimento esta compreendi-º±±
±±º          ³do dentro de um período de internacao.                      º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Caberj                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User function VeFechCtb(cAno,cMes,nOpcao,lMostraMsg)
	Local aAreaSZ9 := SZ9->(GetArea())
	Local lRetorno := .T.
	DEFAULT nOpcao := K_Excluir

	//Estrutura SZ9
	//FILIAL = C,2,
	//ANOCTB = C,4, REAL, ALTERAR, BROWSE, OBRIGATORIO, USADO, "ANO CONTABIL"
	//MESCTB = C,2, REAL, ALTERAR, BROWSE, OBRIGATORIO, USADO, "MES CONTABIL"
	//USUSIS = C,20,REAL, VISUALIZAR, RELACAO=CUSERNAME, USADO, BROWSE, "RESPONSAVEL"
	//INDICE:Z9_FILIAL+Z9_ANOCTB+Z9_MESCTB

	If nOpcao == K_Incluir .Or. nOpcao == K_Excluir

		SZ9->(DbSetOrder(1)) //Z9_FILIAL+Z9_ANOCTB+Z9_MESCTB
		If SZ9->(MsSeek(xFilial("SZ9")+cAno+cMes))
			//**'Marcela Coimbra -----------------------'**

			//lRetorno := .F.
			If ALLTRIM(SZ9->Z9_FECHOU) $ "S| "
				lRetorno := .F.
			EndIf

			//**' Fim Marcela Coimbra ------------------'**

		Endif

	Endif

	If !lRetorno .And. lMostraMsg
		MsgAlert("Competência contábil já encerrada. Impossível prosseguir.")
	Endif

	RestArea(aAreaSZ9)

Return lRetorno


/*/
	ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
	±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
	±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
	±±³Funcao    ³ PLSPSQLIB  ³ Autor ³ Tulio Cesar        ³ Data ³ 16.01.02 ³±±
	±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
	±±³Descricao ³ Pesquisa generica de senhas...                            ³±±
	±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
	±±³            ATUALIZACOES SOFRIDAS DESDE A CONSTRU€AO INICIAL          ³±±
	±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
	±±³Programador ³ Data   ³ BOPS ³  Motivo da Altera‡„o                    ³±±
	±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
	±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
	±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
	ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function PLSPSQLIB(cChaveDef)
	//Funcao baseada no PLSPESUSER()
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Define variaveis...                                                      ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	LOCAL cChave     := Space(100)
	LOCAL oDlgPesUsr
	LOCAL oTipoPes
	LOCAL oSayUsr
	LOCAL nOpca      := 0
	LOCAL aBrowAut   := {}
	LOCAL aVetPad    := { {"ENABLE","","","","","","","","","",""} }
	LOCAL oBrowAut
	LOCAL bRefresh   := { || If(!Empty(cChaveDef),PSQCODLIB(AllTrim(cChaveDef),aVetPad,oBrowAut,@aBrowAut),.T.), .T.   }
	LOCAL cValid     := "{|| Eval(bRefresh) }"
	LOCAL bOK        := { || IF(!Empty(cChaveDef),(nLin := oBrowAut:nAt, nOpca := 1,oDlgPesUsr:End()),Help("",1,"PLSMCON")) }
	LOCAL bCanc      := { || nOpca := 3,oDlgPesUsr:End() }
	LOCAL nReg
	LOCAL oGetChave
	//LOCAL aTipoPes   := {"1-Nome do Usuario","2-Matricula","3-Matricula Antiga","4-Matricula Empresa","5-Nome do Pai","6-Nome da Mae"}
	LOCAL aTipoPes   := {}
	LOCAL nOrdem     := 1
	LOCAL cTipoPes   := ""
	LOCAL oChkChk
	LOCAL lChkChk    := .F.
	LOCAL nLin       := 1
	//LOCAL aButtons 	 := {}
	LOCAL aButtons   := { {"RELATORIO",{ || MostraTela(cChaveDef,aBrowAut[oBrowAut:NAT,9]) } ,"Atendimentos"} }

	LOCAL nRecBD6  := 0
	LOCAL nRecBA1  := 0
	LOCAL nRecBDX  := 0
	LOCAL nRecAli  := 0
	LOCAL nOrdBD6  := 0
	LOCAL nOrdBA1  := 0
	LOCAL nOrdBDX  := 0
	LOCAL nOrdAli  := 0
	Local bBotao01 := {|| MostraTela(cChaveDef,aBrowAut[nLin,9]) }

	Public __cRetYB44AU := ""
	//DEFAULT cCodOpe  := PLSINTPAD()

	PRIVATE aOpcoes  := {}

	If type("aBrowAut") == "U"
		aBrowAut := aClone(aVetPad)
	Endif

	BX8->(DBSetOrder(1))
	If BX8->(DBSeek(xFilial("BX8")+'PLSPESUSR'))
		While !BX8->(EOF()) .And. xFilial("BX8")+'PLSPESUSR' == BX8->(BX8_FILIAL+BX8_RDMAKE)
			aadd(aTipoPes,AllTrim(Str(nOrdem,2))+"-"+BX8->BX8_OPCAO)
			aadd(aOpcoes,{AllTrim(BX8->BX8_CHAVE)})
			nOrdem ++
			BX8->(DBSkip())
		Enddo
	Else

		aTipoPes   := {"Beneficiario"}

		aadd(aOpcoes,{"BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG"})
		aadd(aOpcoes,{""})

	Endif

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Define dialogo...                                                        ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	DEFINE MSDIALOG oDlgPesUsr TITLE STR0008 FROM 008.2,000 TO 025,ndColFin OF GetWndDefault() //"Pesquisa de Beneficiarios"
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Monta objeto que recebera o a chave de pesquisa  ...                     ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	oGetChave := TGet():New(020,103,{ | U | IF( PCOUNT() == 0, cChaveDef, cChaveDef := U ) },oDlgPesUsr,210,008 ,"@!S30",&cValid,nil,nil,nil,nil,nil,.T.,nil,.F.,nil,.F.,nil,nil,.F.,nil,nil,cChaveDef)
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Monta Browse...                                                          ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	oBrowAut := TcBrowse():New( 043, 008, 378, 075,,,, oDlgPesUsr,,,,,,,,,,,, .F.,, .T.,, .F., )

	// {"Ano","Mes","Num.Aut","Cod.RDA","Nom.RDA","Dat.Aut","Hor.Aut","Regime"}
	oBrowAut:AddColumn(TcColumn():New("",nil,;
		nil,nil,nil,nil,015,.T.,.F.,nil,nil,nil,.T.,nil))
	oBrowAut:ACOLUMNS[1]:BDATA     := { || aBrowAut[oBrowAut:nAt,1] }
	oBrowAut:AddColumn(TcColumn():New("Cod.RDA",nil,;
		nil,nil,nil,nil,055,.F.,.F.,nil,nil,nil,.F.,nil))
	oBrowAut:ACOLUMNS[2]:BDATA     := { || aBrowAut[oBrowAut:nAt,2] }
	oBrowAut:AddColumn(TcColumn():New("Nome RDA",nil,;
		nil,nil,nil,nil,055,.F.,.F.,nil,nil,nil,.F.,nil))
	oBrowAut:ACOLUMNS[3]:BDATA     := { || aBrowAut[oBrowAut:nAt,3] }
	oBrowAut:AddColumn(TcColumn():New("Senha",nil,;
		nil,nil,nil,nil,055,.F.,.F.,nil,nil,nil,.F.,nil))
	oBrowAut:ACOLUMNS[4]:BDATA     := { || aBrowAut[oBrowAut:nAt,9] }
	oBrowAut:AddColumn(TcColumn():New("Ano Aut.",nil,;
		nil,nil,nil,nil,040,.F.,.F.,nil,nil,nil,.F.,nil))
	oBrowAut:ACOLUMNS[5]:BDATA     := { || aBrowAut[oBrowAut:nAt,5] }
	oBrowAut:AddColumn(TcColumn():New("Mes Aut.",nil,;
		nil,nil,nil,nil,040,.F.,.F.,nil,nil,nil,.F.,nil))
	oBrowAut:ACOLUMNS[6]:BDATA     := { || aBrowAut[oBrowAut:nAt,6] }
	oBrowAut:AddColumn(TcColumn():New("Regime",nil,;
		nil,nil,nil,nil,030,.F.,.F.,nil,nil,nil,.F.,nil))
	oBrowAut:ACOLUMNS[7]:BDATA     := { || aBrowAut[oBrowAut:nAt,7] }
	oBrowAut:AddColumn(TcColumn():New("Data Aut.",nil,;
		nil,nil,nil,nil,040,.F.,.F.,nil,nil,nil,.F.,nil))
	oBrowAut:ACOLUMNS[8]:BDATA     := { || aBrowAut[oBrowAut:nAt,4] }
	oBrowAut:AddColumn(TcColumn():New("Prev.Anest.",nil,;
		nil,nil,nil,nil,70,.F.,.F.,nil,nil,nil,.F.,nil))
	oBrowAut:ACOLUMNS[9]:BDATA     := { || aBrowAut[oBrowAut:nAt,10] }


	@ 020,008 COMBOBOX oTipoPes  Var cTipoPes ITEMS aTipoPes SIZE 090,010 OF oDlgPesUsr PIXEL COLOR CLR_HBLUE
	@ 020,319 CHECKBOX oChkChk   Var lChkChk PROMPT STR0017 PIXEL SIZE 080, 010 OF oDlgPesUsr //"Pesquisar Palavra Chave"

	oBrowAut:SetArray(aBrowAut)
	oBrowAut:BLDBLCLICK := bOK
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Ativa o Dialogo...                                                       ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	ACTIVATE MSDIALOG oDlgPesUsr ON INIT Eval({ || EnChoiceBar(oDlgPesUsr,bOK,bCanc,.F.,aButtons) })

	If nOpca == K_OK

		BEA->(DbGoBottom())
		BE4->(DbGoBottom())

		__cRetYB44AU := ""

		If !Empty(aBrowAut[nLin,2])
			If aBrowAut[nLin,7] == "A"
				BEA->(DbGoTo(aBrowAut[nLin,8]))
				__cRetYB44AU := BEA->BEA_SENHA
			Else
				BE4->(DbGoTo(aBrowAut[nLin,8]))
				__cRetYB44AU := BE4->BE4_SENHA
			Endif
		Endif

	Endif
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Retorno da Funcao...                                                     ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Return(nOpca==K_OK)
/*/
	ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
	±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
	±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
	±±³Funcao    ³ PLSA300PQ  ³ Autor ³ Tulio Cesar        ³ Data ³ 18.12.01 ³±±
	±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
	±±³Descricao ³ Pesquisa a usuarios na base de dados ...                  ³±±
	±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
	±±³            ATUALIZACOES SOFRIDAS DESDE A CONSTRU€AO INICIAL          ³±±
	±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
	±±³Programador ³ Data   ³ BOPS ³  Motivo da Altera‡„o                    ³±±
	±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
	±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
	±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
	ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function PSQCODLIB(cChave,aVetPad,oBrowAut,aBrowAut)
	Local aArea     := GetArea()
	LOCAL cSQL      := ""

	Local cCodOpe := Substr(cChave,01,04)
	Local cCodEmp := Substr(cChave,05,04)
	Local cMatric := Substr(cChave,09,06)
	Local cTipreg := Substr(cChave,15,02)

	If '"' $ cChave .Or. ;
			"'" $ cChave
		Aviso( "Caracter Invalido", ;
			"Existem caracteres invalidos em sua pesquisa.",;
			{ "Ok" }, 2 )
		Return(.F.)
	Endif

	//cRetBA1 := BA1->(RetSQLName("BA1"))
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Limpa resultado...                                                       ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	aBrowAut := {}
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Efetua busca...                                                          ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

	cSQL := " SELECT 'ENABLE' IMAGEM, BEA_ANOAUT ANOAUT, BEA_MESAUT MESAUT, BEA_NUMAUT NUMAUT, BEA_CODRDA CODRDA, BEA_NOMRDA NOMRDA, BEA_DATPRO DATPRO, BEA_HORPRO HORPRO, 'A' REGIME, BEA_SENHA SENHA, BEA.R_E_C_N_O_ RECNO_, 0 PRV_ANEST  "
	cSQL += " FROM "+RetSQLName("BEA")+" BEA "
	cSQL += " WHERE BEA_FILIAL = '"+xFilial("BEA")+"' "
	cSQL += " AND BEA_OPEUSR = '"+cCodOpe+"' "
	cSQL += " AND BEA_CODEMP = '"+cCodEmp+"' "
	cSQL += " AND BEA_MATRIC = '"+cMatric+"' "
	cSQL += " AND BEA_TIPREG = '"+cTipReg+"' "
	cSQL += " AND BEA_ORIMOV <> '2' "
	cSQL += " AND BEA_SENHA <> ' ' "
	cSQL += " AND BEA.D_E_L_E_T_ = ' ' "

	cSQL += " UNION ALL  "

	cSQL += " SELECT 'ENABLE' IMAGEM, BE4_ANOINT ANOAUT, BE4_MESINT MESAUT, BE4_NUMINT NUMAUT, BE4_CODRDA CODRDA, BE4_NOMRDA NOMRDA, BE4_DATPRO DATPRO, BE4_HORPRO HORPRO, 'I' REGIME, BE4_SENHA SENHA, BE4.R_E_C_N_O_ RECNO_, BE4_YMEDAN PRV_ANEST  "
	cSQL += " FROM "+RetSQLName("BE4")+" BE4 "
	cSQL += " WHERE BE4_FILIAL = '"+xFilial("BE4")+"' "
	cSQL += " AND BE4_OPEUSR = '"+cCodOpe+"' "
	cSQL += " AND BE4_CODEMP = '"+cCodEmp+"' "
	cSQL += " AND BE4_MATRIC = '"+cMatric+"' "
	cSQL += " AND BE4_TIPREG = '"+cTipReg+"'  "
	cSQL += " AND BE4_SENHA <> ' ' "
	cSQL += " AND BE4.D_E_L_E_T_ = ' ' "

	PLSQuery(cSQL,"TrbPes")

	TrbPes->(DbGoTop())
	While ! TrbPes->(Eof())
		TrbPes->(aadd(aBrowAut,{IMAGEM, ;
			CODRDA,;
			NOMRDA,;
			StoD(DATPRO),;
			ANOAUT,;
			MESAUT,;
			REGIME,;
			RECNO_,;
			SENHA,;
			PRV_ANEST }))
		TrbPes->(DbSkip())
	Enddo

	TrbPes->(DbCloseArea())
	RestArea(aArea)
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Testa resultado da pesquisa...                                           ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If Len(aBrowAut) == 0
		aBrowAut := aClone(aVetPad)
	Endif
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Atualiza browse...                                                       ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	oBrowAut:nAt := 1 // Configuro nAt para um 1 pois estava ocorrendo erro de "array out of bound" qdo se fazia
	// uma pesquisa mais abrangante e depois uma uma nova pesquisa menos abrangente
	// Exemplo:
	// 1a. Pesquisa: "A" - Tecle <END> para ir ao final e retorne ate a primeira linha do browse
	// (via seta para cima ou clique na primeira linha)
	// 2a. Pesquisa: "AV" - Ocorria o erro
	oBrowAut:SetArray(aBrowAut)
	oBrowAut:Refresh()
	oBrowAut:SetFocus()
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Fim da Rotina...                                                         ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Return(.T.)


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³FUNCOES2  ºAutor  ³Microsiga           º Data ³  11/13/08   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function VldSenhRee(cSenhaRee)
	Local lRet := .F.
	Local aAreaBE4 := BE4->(GetArea())
	Local aAreaBEA := BEA->(GetArea())

	BE4->(DbSetOrder(7))
	BEA->(DbSetOrder(14))
	If BE4->(MsSeek(xFilial("BE4")+cSenhaRee))
		lRet := .T.
	Else
		lRet := BEA->(MsSeek(xFilial("BEA")+cSenhaRee))
	Endif

	RestArea(aAreaBE4)
	RestArea(aAreaBEA)

Return lRet

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³MOSTRATELAºAutor  ³Jean Schulz         º Data ³  18/11/08   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function MostraTela(cChave,_cSenha)

	Local nRecBD6  := 0
	Local nRecBA1  := 0
	Local nRecBDX  := 0
	Local nRecBE4  := 0
	Local nRecAli  := 0
	Local nOrdBD6  := 0
	Local nOrdBA1  := 0
	Local nOrdBDX  := 0
	Local nOrdBE4  := 0
	Local nOrdAli  := 0
	Local cAliPsq  := Alias()
	Local bAliVar  := {|| nRecBD6  := BD6->(Recno())  ,;
		nRecBA1  := BA1->(Recno())   ,;
		nRecBDX  := BDX->(Recno())   ,;
		nRecBE4  := BE4->(Recno())   ,;
		nRecAli  := &(cAliPsq+"->(Recno())"),;
		nOrdBD6  := BD6->(IndexOrd()),;
		nOrdBA1  := BA1->(IndexOrd()),;
		nOrdBDX  := BDX->(IndexOrd()),;
		nOrdBE4  := BE4->(IndexOrd()),;
		nOrdAli  := &(cAliPsq+"->(IndexOrd())")}

	Local bRest	   := {|| /*If(cFilAli<>"###",If(cAliPsq == "BD5", BD5->(DbSetFilter({||&cFilAli},cFilAli)) , BE4->(DbSetFilter({||&cFilAli},cFilAli))),nil) ,*/;
		BA1->(DbSetOrder(nOrdBA1)),;
		BA1->(DbGoTo(nRecBA1))    ,;
		BD6->(DbSetOrder(nOrdBD6)),;
		BD6->(DbGoTo(nRecBD6))    ,;
		BDX->(DbSetOrder(nOrdBDX)),;
		BDX->(DbGoTo(nRecBDX))    ,;
		BE4->(DbSetOrder(nOrdBE4)),;
		BE4->(DbGoTo(nRecBE4))    ,;
		&(cAliPsq+"->(DbSetOrder("+alltrim(str(nOrdAli))+"))"),;
		&(cAliPsq+"->(DbGoTo("+alltrim(str(nRecAli))+"))") }

	Local bBotaoPsq:= Eval( { || BE4->(DbSetOrder(7)),BE4->(MsSeek(xFilial("BE4")+_cSenha)),BD5->(DbSetOrder(7)),BD5->(MsSeek(xFilial("BD5")+_cSenha)),;
		BA1->(DbSetOrder(2)), BA1->(MsSeek(xFilial("BA1")+cChave)),;
		Eval(bAliVar),IIf(BE4->(Found()),;
		PLSA092Mov("BE4",BE4->(Recno()),2),;
		PLSA090Mov("BD5",BD5->(Recno()),2)),;
		Eval(bRest) } )


Return nil



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³BusPgtRee ºAutor  ³Microsiga           º Data ³  19/05/09   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Busca campos para demonstrar na tela do reembolso informaco-º±±
±±º          ³es sobre contas a pagar (data, vencimento, etc).            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function BusPgtRee(cChaveSE1, cCampo)

Local _cSQL		:= ""
Local cRetorno	:= ""
Local Ret

_cSQL := " SELECT E2_PREFIXO, E2_NUM, E2_PARCELA, E2_TIPO, E2_EMISSAO, E2_VENCREA, E2_BAIXA, E2_VALOR, E1_EMIS1, E1_VENCREA, E1_BAIXA"
_cSQL += " FROM " + RetSQLName("SE2") + " SE2"
_cSQL +=   " INNER JOIN " + RetSQLName("SE1") + " SE1"
_cSQL +=     " ON (    E2_FILIAL  = '" + xFilial("SE2") + "'"
_cSQL +=		 " AND E2_TITORIG = E1_PREFIXO||E1_NUM||E1_PARCELA||E1_TIPO"
_cSQL +=		 " AND E2_TITORIG <> ' ')"
_cSQL += " WHERE SE2.D_E_L_E_T_ = ' ' AND SE1.D_E_L_E_T_ = ' '"
_cSQL +=   " AND E1_FILIAL  = '" +     xFilial("SE1")     + "'"
_cSQL +=   " AND E1_PREFIXO = '" + Substr(cChaveSE1,1,3)  + "'"
_cSQL +=   " AND E1_NUM     = '" + Substr(cChaveSE1,4,9)  + "'"
_cSQL +=   " AND E1_PARCELA = '" + Substr(cChaveSE1,13,1) + "'"
_cSQL +=   " AND E1_TIPO    = '" + Substr(cChaveSE1,14,3) + "'"

MemoWrite("C:\TEMP\BUSPGTREE.TXT",_cSQL)

PlsQuery(_cSQL,"TRBRBS")

cRetorno := "TRBRBS->("+cCampo+")"

Ret := &cRetorno

TRBRBS->(DbCloseArea())

Return Ret


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³RetDtChq  ºAutor  ³Microsiga           º Data ³  09/14/09   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Retorna data para entrega do cheque para empresa CABERJ.    º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function RetDtChq
	Local dRetorno := StoD("")
	Local dPrev
	Local aAreaZZQ := ZZQ->(GetArea())

	ZZQ->(DbSetOrder(1)) //ZZQ_FILIAL+ZZQ_SEQUEN

	dPrev := U_BUSPGTREE(B44->(B44_PREFIX+B44_NUM+B44_PARCEL+B44_TIPO), "E2_VENCREA")

	If !Empty(dPrev)
		If Posicione("ZZQ",1,xFilial("ZZQ")+B44->B44_YCDPTC,"ZZQ_XTPRGT") == "2" //CHEQUE!!!
			dRetorno := dPrev + 2
			//dRetorno := dPrev
		Endif
	Endif

	RestArea(aAreaZZQ)

Return dRetorno


/*/
	ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
	±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
	±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
	±±ºPrograma  ³VALIDLANC º Autor ³ Romulo Ferrari     º Data ³  18/05/07   º±±
	±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
	±±ºDescricao ³ Validacao para evitar debitos e crdeitos com o tipo de     º±±
	±±º			 | lançamento de faturamento bloqueado.					      º±±
	±±º			 | (campo customizado BFQ_ XBLOQ estiver como 1 - SIM).       º±±
	±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
	±±ºUso       ³ CABERJ                                                     º±±
	±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
	±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
	ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

User Function VALIDLANC(cCodLan)
	Local cSQL := ""
	Local cBloq:= ""
	Local aArea := GetArea()

	//**-'Inicio - Marcela Coimbra'-**
	Local l_Ret := .T.
	//**-'Fim    - Marcela Coimbra'-**

	cSQL += " SELECT BFQ_XBLOQ FROM " + RetSQLName("BFQ") + " BFQ, "+RetSQLName("BSP")+ " BSP "
	cSQL += " WHERE BFQ_FILIAL = '"+xFilial("BFQ")+"' AND BSP_CODLAN = BFQ_PROPRI||BFQ_CODLAN "
	cSQL += " AND BSP.D_E_L_E_T_ = ' ' AND BFQ.D_E_L_E_T_ = ' ' "
	cSQL += " AND BSP_CODSER = '"+AllTrim(cCodLan)+"' "
	PlsQuery(cSQL, "TRB_")
	cBloq:= TRB_->BFQ_XBLOQ
	TRB_->(DbCloseArea())
	RestArea(aArea)

	l_Ret := !(cBloq == "1")

	If !l_Ret

		Alert("Código de lançamento bolqueado")

	EndIf

RETURN l_Ret

//altmairo

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ VeSitAdv  ºAutor  ³ Altamiro          º Data ³  02/09/14   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³funcao que Verifica Situiação Adversa no Sub-contrato       º±±
±±º          ³Criado para atender contrato do estaleiro.                  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Integral Saude                                             º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User function VeSitAdv(cMatUsuC__)

	Local cCodInta 	:= substr(cMatUsuC__,1,4)
	Local cCodEmpa 	:= substr(cMatUsuC__,5,4)
	Local cMatrica 	:= substr(cMatUsuC__,9,6)
	Local cTipRega 	:= substr(cMatUsuC__,15,2)
	Local cFilBA1a 	:= xFilial("BA1")
	Local dData   	:= dDataBase
	Local aSituac 	:= {}
	Local lFirst  	:= .F.
	LOCAL cOpeUsr  	:= ' '
	LOCAL cMatrUsr 	:= ' '
	LOCAL cCodPro  	:= ' '
	LOCAL cVerPro  	:= ' '
	LOCAL cCodEmp  	:= ' '
	LOCAL cMatric  	:= ' '
	LOCAL cTipReg  	:= ' '
	LOCAL cConEmp  	:= ' '
	LOCAL cVerCon  	:= ' '
	LOCAL cSubCon  	:= ' '
	LOCAL cVerSub  	:= ' '

	Local dDatBloq	:= CTOD(" / / ")

	Default dData := dDataBase

	dbSelectArea("BA1")
	aAreaBA1 := BA1->(GetArea())
	BA1->(dbSetOrder(2))
	If BA1->(dbSeek(cFilBA1a+cCodInta+cCodEmpa+cMatrica+cTipRega))
		cConEmp := BA1->BA1_CONEMP
		cVerCon := BA1->BA1_VERCON
		cSubCon := BA1->BA1_SUBCON
		cVerSub := BA1->BA1_VERSUB
		cDigito	:= BA1->BA1_DIGITO
		cCodPro := BA1->BA1_CODPLA
		cVerPro := ba1->ba1_versao


		cOpeUsr  		:= BA1->BA1_opeori // aDadUsr[37]
		cMatrUsr 		:= BA1->BA1_opeori + BA1->BA1_opedes // cOpeUsr+aDadUsr[38]
		cCodPro  		:= BA1->BA1_CODPLA // aDadUsr[11]
		cVerPro  		:= ba1->ba1_versao // aDadUsr[12]
		cCodEmp  		:= ba1->ba1_codemp // Subs(cMatrUsr,atCodEmp[1],atCodEmp[2])
		cMatric  		:= BA1->BA1_matric // Subs(cMatrUsr,atMatric[1],atMatric[2])
		cTipReg  		:= BA1->BA1_tipreg // Subs(cMatrUsr,atTipReg[1],atTipReg[2])
		cConEmp  		:= BA1->BA1_CONEMP // aDadUsr[09]
		cVerCon  		:= BA1->BA1_VERCON // aDadUsr[39]
		cSubCon  		:= BA1->BA1_SUBCON // aDadUsr[41]
		cVerSub  		:= BA1->BA1_VERSUB // aDadUsr[42]
		dDatBloq        := BA1->BA1_DATBLO // aDadUsr[42]
		///


		IF BA1->BA1_USRVIP = '1' .and. BA1->BA1_CODEMP = '0325'
			MsgAlert("Este usuário é VIP-CMB!!", "Usuário VIP")
		ENDIF

	EndIf
	RestArea(aAreaBA1)



	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Busca as situacoes adversas informadas no produto...                     ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	BGX->(DbSetOrder(1))

	BGZ->(DbSetOrder(1))
	If BGZ->(MsSeek(xFilial("BGZ")+cOpeUsr+cCodPro+cVerPro))
		While ! BGZ->( Eof() ) .And. BGZ->(BGZ_FILIAL+BGZ_CODINT+BGZ_CODIGO+BGZ_VERSAO) == xFilial("BGZ")+cOpeUsr+cCodPro+cVerPro

			If BGX->( MsSeek(xFilial("BGX")+BGZ->(BGZ_CODINT+BGZ_CODSAD)) ) .And. PLSINTVAL("BGZ","BGZ_VIGDE","BGZ_VIGATE",dData)

				AaDd(aSituac,{BGX->BGX_CODSAD,BGX->BGX_DESCRI})

				If !Empty(BGX->BGX_OBS1)
					AaDd(aSituac,{"",BGX->BGX_OBS1})
				EndIf

				If !Empty(BGX->BGX_OBS2)
					AaDd(aSituac,{"",BGX->BGX_OBS2})
				EndIf

				If !Empty(BGX->BGX_OBS3)
					AaDd(aSituac,{"",BGX->BGX_OBS3})
				EndIf

				If !Empty(BGX->BGX_OBS4)
					AaDd(aSituac,{"",BGX->BGX_OBS4})
				EndIf

				If !Empty(BGX->BGX_OBS5)
					AaDd(aSituac,{"",BGX->BGX_OBS5})
				EndIf

				If !Empty(BGX->BGX_OBS6)
					AaDd(aSituac,{"",BGX->BGX_OBS6})
				EndIf
			Endif

			BGZ->(DbSkip())
		Enddo
	Endif
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ controlar se já passou no while devido o campo versão de produto não estar no índice ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	lFirst:=.T.
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Busca as situacoes adversas informadas no subcontrato...                 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	BHN->(DbSetOrder(1))
	If BHN->(MsSeek(xFilial("BHN")+cOpeUsr+cCodEmp+cConEmp+cVerCon+cSubCon+cVerSub+cCodPro))

		While BHN->( !Eof() ).And. xFilial("BHN")+cOpeUsr+cCodEmp+cConEmp+cVerCon+cSubCon+cVerSub+cCodPro == ;
				BHN->(BHN_FILIAL + BHN_CODINT + BHN_CODIGO + BHN_NUMCON + BHN_VERCON + BHN_SUBCON + BHN_VERSUB + BHN_CODPRO)

			If BHN->BHN_VERPRO <> cVerPro
				BHN->(DbSkip())
				Loop
			Endif

			If BGX->(MsSeek(xFilial("BGX")+BHN->(BHN_CODINT+BHN_CODSAD))) .And. PLSINTVAL("BHN","BHN_VIGDE","BHN_VIGATE",dData)

				If lFirst
					aSituac:={}
					lFirst := .F.
				Endif

				AaDd(aSituac,{BGX->BGX_CODSAD,BGX->BGX_DESCRI})

				If !Empty(BGX->BGX_OBS1)
					AaDd(aSituac,{"",BGX->BGX_OBS1})
				EndIf

				If !Empty(BGX->BGX_OBS2)
					AaDd(aSituac,{"",BGX->BGX_OBS2})
				EndIf

				If !Empty(BGX->BGX_OBS3)
					AaDd(aSituac,{"",BGX->BGX_OBS3})
				EndIf

				If !Empty(BGX->BGX_OBS4)
					AaDd(aSituac,{"",BGX->BGX_OBS4})
				EndIf

				If !Empty(BGX->BGX_OBS5)
					AaDd(aSituac,{"",BGX->BGX_OBS5})
				EndIf

				If !Empty(BGX->BGX_OBS6)
					AaDd(aSituac,{"",BGX->BGX_OBS6})
				EndIf
			EndIf

			BHN->(DbSkip())
		EndDo

	Endif

	lFirst:=.T.
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Busca as situacoes adversas do usuario...                                ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	BHH->( DbSetOrder(1) )
	If BHH->(MsSeek(xFilial("BHH")+cOpeUsr+cCodEmp+cMatric+cTipReg))

		While ! BHH->(Eof()) .And. BHH->(BHH_FILIAL + BHH_CODINT + BHH_CODEMP + BHH_MATRIC + BHH_TIPREG) == ;
				xFilial("BHH")+cOpeUsr+cCodEmp+cMatric+cTipReg

			If !Empty(AllTrim(BHH->BHH_CODSAD))

				If BGX->(MsSeek(xFilial("BGX")+BHH->(BHH_CODINT+BHH_CODSAD))) //.And. PLSINTVAL("BHH","BHH_VIGDE","BHH_VIGATE",dData)

					If lFirst
						aSituac := {}
						lFirst  := .F.
					Endif

					AaDd(aSituac,{BGX->BGX_CODSAD,BGX->BGX_DESCRI})

					If !Empty(BHH->BHH_OBS1)
						AaDd(aSituac,{"",BHH->BHH_OBS1})
					EndIf

					If !Empty(BHH->BHH_OBS2)
						AaDd(aSituac,{"",BHH->BHH_OBS2})
					EndIf

					If !Empty(BHH->BHH_OBS3)
						AaDd(aSituac,{"",BHH->BHH_OBS3})
					EndIf

					If !Empty(BHH->BHH_OBS4)
						AaDd(aSituac,{"",BHH->BHH_OBS4})
					EndIf

					If !Empty(BHH->BHH_OBS5)
						AaDd(aSituac,{"",BHH->BHH_OBS5})
					EndIf
					If !Empty(BHH->BHH_OBS6)
						AaDd(aSituac,{"",BHH->BHH_OBS6})
					EndIf
					If !Empty(BHH->BHH_OBS7)
						AaDd(aSituac,{"",BHH->BHH_OBS7})
					EndIf
					If !Empty(BHH->BHH_OBS8)
						AaDd(aSituac,{"",BHH->BHH_OBS8})
					EndIf
					If !Empty(BHH->BHH_OBS9)
						AaDd(aSituac,{"",BHH->BHH_OBS9})
					EndIf
					If !Empty(BHH->BHH_OBS10)
						AaDd(aSituac,{"",BHH->BHH_OBS10})
					EndIf
					If !Empty(BHH->BHH_OBS11)
						AaDd(aSituac,{"",BHH->BHH_OBS11})
					EndIf
					If !Empty(BHH->BHH_OBS12)
						AaDd(aSituac,{"",BHH->BHH_OBS12})
					EndIf

				EndIf

			EndIf

			BHH->(DbSkip())
		EndDo
	EndIf
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Exibe msg caso exista...                                                 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If Len(aSituac) > 0 //.And. lHelp
		//PLSCRIGEN(aSituac,{ {STR0020,"@C",30} , {STR0021,"@C",50 } },STR0022) //"Codigo"###"Descricao"###"Situacoes Adversas"
		PLSCRIGEN(aSituac,{ {"CODIGO","@C",30} , {"DESCRICAO","@C",50 } },"SITUACAO ADVERSA") //"Codigo"###"Descricao"###"Situacoes Adversas"
	Endif
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Fim da Rotina...                                                         ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

	//--------------------------------------------------------------------------------------------------------
	//Solicitado que a tela de situações adversas seja apresentada também na tela de protocolo de reembolso
	//Chamado: 39414
	//--------------------------------------------------------------------------------------------------------
	If Alltrim(UPPER(FUNNAME())) == "CDPROTREE"

		cAutJus   := GetNewPar("MV_XREAUTJ","S") // liberação judicial
		//----------------------------------------------------------
		//Mudo aqui a estrutura para utilizar na outra rotina
		//----------------------------------------------------------
		aSituac := .T.

		// --------------------------------------------------------------------
		// Inicio
		// --------------------------------------------------------------------
		// Mateus Medeiros Muniz - 17/01/2018
		// Validação para configuração do período determinado de reembolso.
		// Somente será permitido pedir reembolso de eventos realizados em
		// até 1 ano.
		// Para Beneficiários bloqueados, só serão reembolsados de eventos
		// executados antes da data de bloqueio.
		// --------------------------------------------------------------------
		if !Empty(dDatBloq)  // Beneficiário bloqueado.

			if dDatBloq <= ddatabase

				if M->ZZQ_DTEVEN < dDatBloq

					nTotDias := ddatabase - M->ZZQ_DTEVEN
					if nTotDias > 365 .and. alltrim(cAutJus) == 'N'
						aSituac := .F.
						AVISO("Reemb. N. Permit", "Solicitação de reembolso superior a 12 meses, a partir da data de execução do evento.", { "OK" }, 1)
					endif
				else
					aSituac := .F.
					AVISO("Reemb. N. Permit", "Data do evento superior a data de bloqueio do beneficiário. Data de bloqueio do beneficiário "+cvaltochar(dDatBloq), { "OK" }, 1)

				endif

			endif

		else // Beneficiario Ativo

			nTotDias := ddatabase - M->ZZQ_DTEVEN

			if nTotDias > 365 .and. alltrim(cAutJus) == 'N'
				aSituac := .F.
				AVISO("Reemb. N. Permit", "Solicitação de reembolso superior a 12 meses, a partir da data de execução do evento.", { "OK" }, 1)
			endif

		endif


	EndIf

Return(aSituac)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Funcao usada para retornar o codigo da BB0 no PLSRETCP.               ³
//³Na rotina HISTAED eh utilizada para retornar o status do profissional.³
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Trecho deslocado do PLSRETCP para dentro desta funcao.                ³
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Unificado em uma funcao para manter a mesma logica.                   ³
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³O PLSRETCP busca baseado no REGSOL. A parametrizacao do HISTAED eh    |
//³feita pelo BB0_CODIGO. Andreia no HISTAED acredita estar parametri-   |
//³um profissional mas o PLSRETCP na busca encontra outro. O objetivo eh |
//³identificar esses casos na tela de cadastro do HISTAED.               |
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//³28/11/2019 - BIANCHINI - Função trazida para o FUNCOES2.PRW para ser  |
//³             centralizada.  Esta função passou a ser chamada também   |
//³				pelo P.E. PLSXMLSCU.PRW									 |
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 

User Function StatBB0(c_RegSol,d_DatPro,c_CodBB0,d_DatBlo,c_Sigla,c_UF)

	Local aRet 		:= {' ',' ',.F.,' '}
	Local a_Area 	:= GetArea()
	Local a_ArBB0	:= BB0->(GetArea())
	
	If ( c_RegSol == Nil )
		c_RegSol := Posicione('BB0',1,xFilial('BB0') + c_CodBB0,'BB0_NUMCR')
		c_Sigla  := AllTrim(BB0->BB0_CODSIG)
		c_UF	 := AllTrim(BB0->BB0_ESTADO)
	Else
		c_RegSol := AllTrim(c_RegSol)
		c_Sigla  := AllTrim(c_Sigla)
		c_UF	 := AllTrim(c_UF)
	EndIf

	//Angelo Henrique - Data:07/04/2016
	//ESTE FUNNAME MALDITO FOI COLOCADO PORQUE A MELHORIA FEITA EM SEGUIDA PARA O CONTAS MEDICAS FICOU MUITO PESADA PARA A ROTINA HISTAED

	If FunName() == "HISTAED"

		cQuery := " SELECT BB0_CODIGO, ' ' ZZF_TPPROF 					  "	+ CRLF
		cQuery += "   FROM " + RetSqlName("BB0") + " BB0				  " + CRLF
		cQuery += " WHERE BB0_FILIAL = '" + xFilial('BB0') + "'           " + CRLF
		If !empty(c_RegSol)
			cQuery += " AND lpad(trim(BB0_NUMCR),10,'0') = lpad(trim(' " + c_RegSol + " '),10,'0')" 			+ CRLF
		EndIf
		cQuery += " AND (BB0_DATBLO = ' ' or BB0_DATBLO >= '" + DtoS(d_DatPro)+ "')"   			   				+ CRLF
		cQuery += " AND BB0.D_E_L_E_T_ = ' ' 							  " + CRLF

		TcQuery cQuery Alias "BB0ZZ1" New

		DbSelectArea("BB0ZZ1")

	Else

		cQuery := " SELECT BB0_VINC, 								  "	+ CRLF
		cQuery += "        BB0_CODIGO,								  "	+ CRLF
		cQuery += "        BB0_NOME, 								  "	+ CRLF
		cQuery += "        BB0_CODSIG,                                "	+ CRLF
		cQuery += "        BB0_NUMCR,                                 "	+ CRLF
		cQuery += "        BB0_ESTADO,                                "	+ CRLF
		cQuery += "        BB0_CGC,                                   "	+ CRLF
		cQuery += "        BB0_DATBLO,                                "	+ CRLF
		cQuery += "        ZZF_TPPROF			                      "	+ CRLF
		cQuery += "  FROM " + RetSqlName("BB0") + " BB0				  " + CRLF
		cQuery += "     , " + RetSqlName("ZZF") + " ZZF               "	+ CRLF
		cQuery += " WHERE BB0_FILIAL = '" + xFilial("BB0") + " '      "	+ CRLF
		cQuery += "   AND ZZF_FILIAL = '" + xFilial("ZZF") + " '      "	+ CRLF
		cQuery += "   AND BB0_ESTADO = '"+c_UF+ "'                    "	+ CRLF
		cQuery += "   AND "	+ CRLF
		/*
		cQuery += "   ( "	+ CRLF //Angelo Henrique - Data:07/04/2016
		cQuery += "   LTRIM(TRIM(BB0_NUMCR),0) = LTRIM(TRIM(SUBSTR(LPAD(TRIM(REMOVE_ALFA(REMOVE_CARACTERS_ESPEC_II('"+c_RegSol+"'))),10,'0'),(LENGTH(LPAD(TRIM(REMOVE_ALFA(REMOVE_CARACTERS_ESPEC_II('"+c_RegSol+"'))),10,'0'))-6)+1,LENGTH(LPAD(TRIM(REMOVE_ALFA(REMOVE_CARACTERS_ESPEC_II('"+c_RegSol+"'))),10,'0')))),0)"	+ CRLF
		cQuery += "   OR "	+ CRLF //Angelo Henrique - Data:07/04/2016
		cQuery += "   LTRIM(TRIM(BB0_NUMCR),0) = LTRIM(TRIM(REMOVE_ALFA(REMOVE_CARACTERS_ESPEC_II('"+c_RegSol+"'))),0) "	+ CRLF //Angelo Henrique - Data:07/04/2016
		cQuery += "   OR "	+ CRLF //Fabio Bianchini - Data:02/03/2020
		cQuery += "   LTRIM(TRIM(BB0_NUMCR),0) = LTRIM(TRIM(SUBSTR(LPAD(TRIM(REMOVE_ALFA(REMOVE_CARACTERS_ESPEC_II('52"+c_RegSol+"'))),10,'0'),(LENGTH(LPAD(TRIM(REMOVE_ALFA(REMOVE_CARACTERS_ESPEC_II('52"+c_RegSol+"'))),10,'0'))-6)+1,LENGTH(LPAD(TRIM(REMOVE_ALFA(REMOVE_CARACTERS_ESPEC_II('52"+c_RegSol+"'))),10,'0')))),0)"	+ CRLF
		cQuery += "   OR "	+ CRLF //Fabio Bianchini - Data:02/03/2020
		cQuery += "   LTRIM(TRIM(BB0_NUMCR),0) = LTRIM(TRIM(REMOVE_ALFA(REMOVE_CARACTERS_ESPEC_II('52"+c_RegSol+"'))),0) "	+ CRLF //Fabio Bianchini - Data:02/03/2020
		cQuery += "   OR "	+ CRLF //Fabio Bianchini - Data:02/03/2020
		cQuery += "   LTRIM(TRIM(BB0_NUMCR),0) = LTRIM(TRIM(SUBSTR(LPAD(TRIM(REMOVE_ALFA(REMOVE_CARACTERS_ESPEC_II('052"+c_RegSol+"'))),10,'0'),(LENGTH(LPAD(TRIM(REMOVE_ALFA(REMOVE_CARACTERS_ESPEC_II('052"+c_RegSol+"'))),10,'0'))-6)+1,LENGTH(LPAD(TRIM(REMOVE_ALFA(REMOVE_CARACTERS_ESPEC_II('052"+c_RegSol+"'))),10,'0')))),0)"	+ CRLF
		cQuery += "   OR "	+ CRLF //Fabio Bianchini - Data:02/03/2020
		cQuery += "   LTRIM(TRIM(BB0_NUMCR),0) = LTRIM(TRIM(REMOVE_ALFA(REMOVE_CARACTERS_ESPEC_II('052"+c_RegSol+"'))),0) "	+ CRLF //Fabio Bianchini - Data:02/03/2020
		cQuery += "   OR "	+ CRLF //Fabio Bianchini - Data:02/03/2020
		cQuery += "   LTRIM(TRIM(BB0_NUMCR),0) = LTRIM(TRIM(SUBSTR(LPAD(TRIM(REMOVE_ALFA(REMOVE_CARACTERS_ESPEC_II('0052"+c_RegSol+"'))),10,'0'),(LENGTH(LPAD(TRIM(REMOVE_ALFA(REMOVE_CARACTERS_ESPEC_II('0052"+c_RegSol+"'))),10,'0'))-6)+1,LENGTH(LPAD(TRIM(REMOVE_ALFA(REMOVE_CARACTERS_ESPEC_II('0052"+c_RegSol+"'))),10,'0')))),0)"	+ CRLF
		cQuery += "   OR "	+ CRLF //Fabio Bianchini - Data:02/03/2020
		cQuery += "   LTRIM(TRIM(BB0_NUMCR),0) = LTRIM(TRIM(REMOVE_ALFA(REMOVE_CARACTERS_ESPEC_II('0052"+c_RegSol+"'))),0) "	+ CRLF //Fabio Bianchini - Data:02/03/2020
		cQuery += "   ) "	+ CRLF //Fabio Bianchini - Data:02/03/2020
		*/
		cQuery += "   ( "	+ CRLF //Angelo Henrique - Data:07/04/2016
		cQuery += "   LTRIM(TRIM(BB0_NUMCR),0) = LTRIM(TRIM(SUBSTR(LPAD(REMOVE_CARACTERS_ESPEC_III('"+c_RegSol+"'),10,'0'),(LENGTH(LPAD(REMOVE_CARACTERS_ESPEC_III('"+c_RegSol+"'),10,'0'))-6)+1,LENGTH(LPAD(REMOVE_CARACTERS_ESPEC_III('"+c_RegSol+"'),10,'0')))),0)"	+ CRLF
		cQuery += "   OR "	+ CRLF //Angelo Henrique - Data:07/04/2016
		cQuery += "   LTRIM(TRIM(BB0_NUMCR),0) = LTRIM(REMOVE_CARACTERS_ESPEC_III('"+c_RegSol+"'),0) "	+ CRLF //Angelo Henrique - Data:07/04/2016
		cQuery += "   OR "	+ CRLF //Fabio Bianchini - Data:02/03/2020
		cQuery += "   LTRIM(TRIM(BB0_NUMCR),0) = LTRIM(TRIM(SUBSTR(LPAD(REMOVE_CARACTERS_ESPEC_III('52"+c_RegSol+"'),10,'0'),(LENGTH(LPAD(REMOVE_CARACTERS_ESPEC_III('52"+c_RegSol+"'),10,'0'))-6)+1,LENGTH(LPAD(REMOVE_CARACTERS_ESPEC_III('52"+c_RegSol+"'),10,'0')))),0)"	+ CRLF
		cQuery += "   OR "	+ CRLF //Fabio Bianchini - Data:02/03/2020
		cQuery += "   LTRIM(TRIM(BB0_NUMCR),0) = LTRIM(REMOVE_CARACTERS_ESPEC_III('52"+c_RegSol+"'),0) "	+ CRLF //Fabio Bianchini - Data:02/03/2020
		cQuery += "   OR "	+ CRLF //Fabio Bianchini - Data:02/03/2020
		cQuery += "   LTRIM(TRIM(BB0_NUMCR),0) = LTRIM(TRIM(SUBSTR(LPAD(REMOVE_CARACTERS_ESPEC_III('052"+c_RegSol+"'),10,'0'),(LENGTH(LPAD(REMOVE_CARACTERS_ESPEC_III('052"+c_RegSol+"'),10,'0'))-6)+1,LENGTH(LPAD(REMOVE_CARACTERS_ESPEC_III('052"+c_RegSol+"'),10,'0')))),0)"	+ CRLF
		cQuery += "   OR "	+ CRLF //Fabio Bianchini - Data:02/03/2020
		cQuery += "   LTRIM(TRIM(BB0_NUMCR),0) = LTRIM(REMOVE_CARACTERS_ESPEC_III('052"+c_RegSol+"'),0) "	+ CRLF //Fabio Bianchini - Data:02/03/2020
		cQuery += "   OR "	+ CRLF //Fabio Bianchini - Data:02/03/2020
		cQuery += "   LTRIM(TRIM(BB0_NUMCR),0) = LTRIM(TRIM(SUBSTR(LPAD(REMOVE_CARACTERS_ESPEC_III('0052"+c_RegSol+"'),10,'0'),(LENGTH(LPAD(REMOVE_CARACTERS_ESPEC_III('0052"+c_RegSol+"'),10,'0'))-6)+1,LENGTH(LPAD(REMOVE_CARACTERS_ESPEC_III('0052"+c_RegSol+"'),10,'0')))),0)"	+ CRLF
		cQuery += "   OR "	+ CRLF //Fabio Bianchini - Data:02/03/2020
		cQuery += "   LTRIM(TRIM(BB0_NUMCR),0) = LTRIM(REMOVE_CARACTERS_ESPEC_III('0052"+c_RegSol+"'),0) "	+ CRLF //Fabio Bianchini - Data:02/03/2020
		cQuery += "   ) "	+ CRLF //Fabio Bianchini - Data:02/03/2020

		cQuery += "   AND BB0_CODSIG = '"+c_Sigla+"'                  "	+ CRLF
		cQuery += "   AND BB0_CODOPE = '"+PLSINTPAD()+"'              "	+ CRLF
		cQuery += "   AND BB0_CODIGO = ZZF_CODIGO                     "	+ CRLF
		cQuery += "   AND (BB0_DATBLO = ' ' or BB0_DATBLO >= '" + DtoS(d_DatPro)+ "')"	+ CRLF
		cQuery += "   AND (ZZF_DATBLO = ' ' or ZZF_DATBLO >= '" + DtoS(d_DatPro)+ "')"	+ CRLF
		cQuery += "   AND ZZF.D_E_L_E_T_ = ' '                        "	+ CRLF
		cQuery += "   AND BB0.D_E_L_E_T_ = ' '                        "	+ CRLF

		memowrite("c:\TEMP\STATBB0.SQL",cQuery)

		TcQuery cQuery Alias "BB0ZZ1" New

		DbSelectArea("BB0ZZ1")

	Endif

	If !Eof()
		aRet[1]	:= BB0ZZ1->BB0_CODIGO
		aRet[2]	:= 'Prof. Saúde [ ' + BB0ZZ1->BB0_CODIGO + ' ]' + If(c_CodBB0 <> Nil,If(AllTrim(c_CodBB0) == AllTrim(BB0ZZ1->BB0_CODIGO),' ',' diferente do parametrizado [ ' + AllTrim(c_CodBB0) + ' ] busca '),' localizado ') + 'com base no Solicitante (REGSOL) [ ' + c_RegSol + ' ]'
		aRet[3]	:= .T.
		aRet[4]	:= BB0ZZ1->ZZF_TPPROF
	EndIf

	If ( d_DatBlo <> Nil ) .and. !empty(d_DatBlo)
		aRet[2] :=	'Bloqueado em [ ' + DtoC(d_DatBlo) + ' ] - ' + aRet[2]
	EndIf

	BB0ZZ1->(DbCloseArea())
	BB0->(RestArea(a_ArBB0))
	RestArea(a_Area)

Return aRet

//--------------------------------------------------------------------------------------
//FUNÇÃO BLOQ12M - Fabio Bianchini - Data: 10/12/2019									|
//--------------------------------------------------------------------------------------
// DECISÃO DE FORUM EM 14/10/2019 - A PARTIR DE 01/11/2019 COBRAR COPART REFERENTE A    |
// 12 MESES ENTRE ADATA DE PROCESSAMENTO E A DATA DO EVENTO. SOMENTE MATER E  			|
// AFINIDADE(CABERJ)																	|
//--------------------------------------------------------------------------------------
// Função chamada pelos PE´s PLS720G1 e PLSREVPC										|
//--------------------------------------------------------------------------------------

User Function Bloq12M(cChvGuiaBD6)
	Local aAreaBD6 := BD6->(GetArea())
	Local nDifData := 0
	Local cCodBlo  := " "
	Local cDesBlo  := " "
	Local lRet 	   := .T.

	BD6->(DbGoTop())
	DbSelectArea("BD6")
	BD6->(DbSetOrder(1))//BD6_FILIAL+BD6_CODOPE+BD6_CODLDP+BD6_CODPEG+BD6_NUMERO+BD6_ORIMOV+BD6_SEQUEN+BD6_CODPAD+BD6_CODPRO
	If BD6->(DbSeek(cChvGuiaBD6))
		While !(BD6->(EOF())) .and. BD6->(BD6_FILIAL+BD6_CODOPE+BD6_CODLDP+BD6_CODPEG+BD6_NUMERO+BD6->BD6_ORIMOV) == cChvGuiaBD6

			If cEmpAnt == '01' .and. BD6->BD6_CODEMP $ '0001|0002|0005' .and. BD6->BD6_VLRTPF > 0 .and. SUBS(DTOS(DATE()),1,6) >= '201911'
				nDifData := 0
				nDifData := STOD(SUBS(DTOS(DATE()),1,6)+'01') - BD6->BD6_DATPRO
				cCodBlo  := IIF(cEmpant == '01','791','' )
				cDesBlo  := IIF(cEmpant == '01','BLQ_CP_12_MESES_FORUM_14/10/19','')
				If nDifData > 365
					u_BLOCPABD6(BD6->(BD6_CODOPE+BD6_CODLDP+BD6_CODPEG+BD6_NUMERO+BD6_ORIMOV+BD6_SEQUEN),cCodBlo,cDesBlo, .T.,.F.)
				Endif
			Endif

			BD6->(DbSkip())
		Enddo
	Endif

	RestArea(aAreaBD6)

Return lRet

/*/{Protheus.doc} BLOCPABD6
Bloqueio do BD6
@type function
@author Fabio Bianchini
@since 21/08/19
@version 1.0
/*/
User Function BLOCPABD6(cChave,cCodCri,cDesCri, lBlq, lBlqPag)
	LOCAL aAreaBD6	:= BD6->(GetArea())
	LOCAL aAreaBD7	:= BD7->(GetArea())
	LOCAL lBloq		:= lBlq
	LOCAL lBloqPag  := lBlqPag

	If BD6->( IndexOrd() ) <> 1
		BD6->( DbSetOrder(1) ) //BD6_FILIAL + BD6_CODOPE + BD6_CODLDP + BD6_CODPEG + BD6_NUMERO + BD6_ORIMOV + BD6_SEQUEN + BD6_CODUNM + BD6_NLANC
	EndIf

	If BD6->( MsSeek( xFilial("BD6")+cChave ) )

		While !BD6->( Eof() ) .And. xFilial("BD6")+cChave == BD6->(BD6_FILIAL+BD6_CODOPE+BD6_CODLDP+BD6_CODPEG+BD6_NUMERO+BD6_ORIMOV+BD6_SEQUEN)
			// Bloqueio/Desbloqueio da cobranca se o Pagamento for bloqueado/desbloqueado
			If lBloq
				If BD6->BD6_BLOCPA <> "1" .or. BD6->BD6_BLOPAG <> "1"
					BD6->( RecLock("BD6",.F.) )
					BD6->BD6_ENVCON := "1"

					If lBloqPag
						BD6->BD6_BLOPAG := "1"
						BD6->BD6_MOTBPG := cCodCri
						BD6->BD6_DESBPG := cDesCri
					Endif

					BD6->BD6_BLOCPA := "1"
					BD6->BD6_MOTBPF := cCodCri
					BD6->BD6_DESBPF := cDesCri
					BD6->( MsUnLock() )
				Endif
			Else
				If BD6->BD6_BLOCPA == "1" .or. BD6->BD6_BLOPAG == "1"
					BD6->( RecLock("BD6",.F.) )
					BD6->BD6_ENVCON := "0"

					If !lBloqPag
						BD6->BD6_BLOPAG := "0"
						BD6->BD6_MOTBPG := ""
						BD6->BD6_DESBPG := ""
					Endif

					BD6->BD6_BLOCPA := "0"
					BD6->BD6_MOTBPF := ""
					BD6->BD6_DESBPF := ""
					BD6->( MsUnLock() )
				Endif
			EndIf

			BD6->( DbSkip() )
		EndDo

	EndIf

	// Log do procedimento bloqueado
	PlsLogFil(Space(03)+"PROCEDIMENTO [ "+BD6->BD6_CODPAD+" - "+AllTrim(BD6->BD6_CODPRO)+" ] BLOQUEADO NA CONTA MEDICA" ,__PLSFLOGX)

	RestArea(aAreaBD6)
	RestArea(aAreaBD7)
Return

//--------------------------------------------------------------------------------------
//FUNÇÃO ChkCopBDH - Fabio Bianchini - Data: 17/03/2020									|
//--------------------------------------------------------------------------------------
// Função que buscará se uma determinada Guia sem copart possui BDH gerada, SEM TITULO  |
//--------------------------------------------------------------------------------------
// Função chamada pelos PE´s PLS720G1 e PLSREVPC										|
//--------------------------------------------------------------------------------------

User Function ChkCopBDH(cChvGuiaBD6)
	Local aAreaBD6 := BD6->(GetArea())
	Local lRet 	   := .T.
	Local nVlrtpf  := 0
	Local cMespag  := ""
	Local cAnopag  := ""
	Local cChvBDH  := ""
	Local cMatric  := ""
	Local cNomUsr  := ""	
	Local aRecBD6	:= {}
	Local nX		:= 0

	//If Empty(BD5->BD5_GUESTO)
	DbSelectArea("BD6")
	BD6->(DbGoTop())
	BD6->(DbSetOrder(1))//BD6_FILIAL+BD6_CODOPE+BD6_CODLDP+BD6_CODPEG+BD6_NUMERO+BD6_ORIMOV+BD6_SEQUEN+BD6_CODPAD+BD6_CODPRO
	If BD6->(DbSeek(cChvGuiaBD6))
		nVlrtpf := 0
		cMespag := BD6->BD6_MESPAG
		cAnopag := BD6->BD6_ANOPAG
		cChvBDH := BD6->(BD6_OPEUSR+BD6_CODEMP+BD6_MATRIC+BD6_TIPREG+BD6_ANOPAG+BD6_MESPAG)
		cMatric := BD6->(BD6_OPEUSR+BD6_CODEMP+BD6_MATRIC+BD6_TIPREG+BD6_DIGITO)
		cNomUSr := BD6->BD6_NOMUSR

		While !(BD6->(EOF())) .and. BD6->(BD6_FILIAL+BD6_CODOPE+BD6_CODLDP+BD6_CODPEG+BD6_NUMERO+BD6->BD6_ORIMOV) == cChvGuiaBD6
			If BD6->BD6_BLOCPA <> '1'
				aAdd(aRecBD6,{BD6->(Recno())})
				nVlrtpf += BD6->BD6_VLRTPF
			Endif
			BD6->(DbSkip())
		Enddo

		DbSelectArea("BDH")
		BDH->(DbGoTop())
		BDH->(DbSetOrder(1)) //BDH_FILIAL, BDH_CODINT, BDH_CODEMP, BDH_MATRIC, BDH_TIPREG, BDH_ANOFT, BDH_MESFT, BDH_STATUS, BDH_TIPPAC, R_E_C_N_O_, D_E_L_E_T_
		If DbSeek(xFilial("BDH")+cChvBDH)
			If (nVlrTpf <> BDH->BDH_VALOR5 .OR. nVlrTpf <> BDH->BDH_VLCOPA)
				//While !BDH->(EOF()) .and. BDH->(BDH_FILIAL+BDH_CODINT+BDH_CODEMP+BDH_MATRIC+BDH_TIPREG+BDH_ANOFT+BDH_MESFT) == xFilial("BDH")+cChvBDH
				//BIANCHINI - 20/03/2020 - Por enquanto somente trato os casos em que há isenção de COPART
				//                         e que ja tivesse tido consolidação previamente
				If nVlrTpf == 0 .and. EMPTY(BDH->BDH_NUMFAT) .and. EMPTY(BDH->BDH_NUMTIT)
					For nX := 1 to len(aRecBD6)
						BD6->(dbGoTo(aRecBD6[nX,1]))
						If !EMPTY(BD6->BD6_SEQPF) .and. EMPTY(BD6->BD6_NUMFAT) .and. EMPTY(BD6->BD6_NUMTIT)
							BD6->(Reclock("BD6",.F.))
							BD6->BD6_SEQPF = ' '
							BD6->(MsUnlock())
						Endif
					Next nX

					Reclock("BDH",.F.)
					BDH->(DbDelete())
					BDH->(MsUnlock())
				Endif
/*
						If nVlrTpf <> 0 //.and. EMPTY(BDH->BDH_NUMFAT) .and. EMPTY(BDH->BDH_NUMTIT)
							_cAssunto := "GUIAS REVALORIZADAS - CONSOLIDAR MANUALMENTE - ROT.AUTOMATICA"

							_cMensagem := DtoC( Date() ) + Chr(13) + Chr(10) + Chr(13) + Chr(10)      
							_cMensagem += Chr(13) + Chr(10) + Chr(13) + Chr(10) +'Empresa : '+(iif(cEmpAnt == "01", "CABERJ", "INTEGRAL" ))
							_cMensagem += Chr(13) + Chr(10) + Chr(13) + Chr(10) +"GUIAS REVALORIZADAS PARA CORREÇÃO DE COPART! NECESSÁRIO CONSOLIDAR INDIVIDUALMENTE O CASO ABAIXO" 
							_cMensagem += Chr(13) + Chr(10)
							_cMensagem += Chr(13) + Chr(10) + PADR("MATRICULA",30,'_') + PADR("NOME",50,'_')  + PADR("GUIA",30,'_')      + PADR("MES",5,'_')   + PADR("ANO",5,'_')
							_cMensagem += Chr(13) + Chr(10) + "__________________________________________________________________________________________________________________________"
							_cMensagem += Chr(13) + Chr(10) 
							_cMensagem += Chr(13) + Chr(10) + PADR(cMatric,30,'_')     + PADR(cNomUsr,50,'_') + PADR(cChvGuiaBD6,30,'_') + PADR(cMesPag,5,'_') + PADR(cAnoPag,5,'_')

							//U_ENVMAIL(_pcOrigem,_pcDestino,_pcSubject,_pcBody,_pcArquivo,_plAutomatico,_pcBcc)
							U_ENVMAIL(NIL,"fabio.bianchini@caberj.com.br",_cAssunto,_cMensagem,NIL,NIL,"")
						Endif
*/
				//BDH->(DbSkip())
				//Enddo
			Endif
		Endif
		BDH->(DbCloseArea())
	Endif
	//Endif
	RestArea(aAreaBD6)

Return lRet

//CALCULA A IDADE DE BENEFICIARIO COM BASE EM 2 DATAS
User function idadeBen(dDatRef1,dDatRef2)
	local idade:=0

	idade:=year(dDatRef1)-year(dDatRef2)
	if (((month(dDatRef2)*100) + day(dDatRef2))> ((month(dDatRef1)*100)+day(dDatRef1)))
		idade:=idade-1
	endif

return(idade)

//BUSCA CH NOS NIVEIS BC6, BC0, BFM
User Function BuscaCH()
	Local cQuery   := ""
	Local cAliQry1 := "TRBCH"
	Local nVlrUs   := 0
	Local nVlrRea  := 0
	Local aRet 	   := {}
	Local _cAlias  := ""

/*
  Retorno

  aRet[1][1] - Valor de US
  aRet[1][2] - Valor em Real 
  aRet[1][3] - Alias
*/

	//1a. Busca - BC6 Por Plano
	cQuery := " SELECT BC6_FILIAL,BC6_CODINT,BC6_CODRDA,BC6_CODTAB,BC6_CODPAD,BC6_CODPRO,BC6_VIGFIM,BC6_USPCO,BC6_VRPCO,BC6_TPLANP, BC6_CODPLA "
	cQuery += " FROM " + RetSqlName("BC6")+ " BC6 INNER JOIN " + RETSQLNAME("BC5") + " BC5 ON "
	cQuery += "                                   BC5_FILIAL = '" + XFILIAL("BC5") + "' "
	cQuery += "                                   AND BC5_CODINT = BC6_CODINT "
	cQuery += "                                   AND BC5_CODRDA = BC6_CODRDA "
	cQuery += "                                   AND BC5_CODTAB = BC6_CODTAB "
	cQuery += "                                   AND (('" + DTOS( BD7->BD7_DATPRO ) + "' between BC5_DATINI AND BC5_DATFIM) OR (BC5_DATFIM = ' ' AND '" + DTOS( BD7->BD7_DATPRO ) + "' > BC5_DATINI)) "
	cQuery += "                                   AND BC5.D_E_L_E_T_ = ' ' "
	cQuery += " WHERE BC6.D_E_L_E_T_ = ' ' "
	cQuery += " AND BC6_FILIAL = '" + xFilial("BC6")  + "' "
	cQuery += " AND BC6_CODINT = '" + BD7->BD7_CODOPE + "' "
	cQuery += " AND BC6_CODRDA = '" + BD7->BD7_CODRDA + "' "
	cQuery += " AND BC6_CODPAD = '" + BD7->BD7_CODPAD + "' "
	If ALLTRIM(BD7->BD7_CODPAD) $ '00|02|15|16|17|18|19|20|98' //5 Níveis
		cQuery += " AND ( (BC6_CODPRO = '" + BD7->BD7_CODPRO + "' AND BC6_NIVEL = '4') OR "
		cQuery += "       (SUBSTR(BC6_CODPRO,1,5) = '" + SUBS(BD7->BD7_CODPRO,1,5) + "' AND BC6_NIVEL = '3') OR "
		cQuery += "       (SUBSTR(BC6_CODPRO,1,3) = '" + SUBS(BD7->BD7_CODPRO,1,3) + "' AND BC6_NIVEL = '2') OR "
		cQuery += "       (SUBSTR(BC6_CODPRO,1,1) = '" + SUBS(BD7->BD7_CODPRO,1,1) + "' AND BC6_NIVEL = '1') ) "
	ElseIf ALLTRIM(BD7->BD7_CODPAD) $ '01|04|06|07|26' .or. ALLTRIM(BD7->BD7_CODPAD) $ '05|09|23|24' //4 ou 3 Níveis, respectivamente
		cQuery += " AND ( (BC6_CODPRO = '" + BD7->BD7_CODPRO + "' AND BC6_NIVEL = '3') OR "
		cQuery += "       (SUBSTR(BC6_CODPRO,1,3) = '" + SUBS(BD7->BD7_CODPRO,1,3) + "' AND BC6_NIVEL = '2') OR "
		cQuery += "       (SUBSTR(BC6_CODPRO,1,1) = '" + SUBS(BD7->BD7_CODPRO,1,1) + "' AND BC6_NIVEL = '1') ) "
	Endif
	cQuery += " AND BC6_CODPLA = '" + BD7->BD7_CODPLA + "' "
	cQuery += " AND (('" + DTOS( BD7->BD7_DATPRO ) + "' between BC6_VIGINI AND BC6_VIGFIM) OR (BC6_VIGFIM = ' ' AND '" + DTOS( BD7->BD7_DATPRO ) + "' > BC6_VIGINI)) "
	cQuery += " AND ( BC6_VRPCO <> 0 OR BC6_USPCO <> 0 )"

	If Select(cAliQry1)>0
		(cAliQry1)->(DbCloseArea())
	EndIf

	DbUseArea(.T.,"TopConn",TcGenQry(,,cQuery),cAliQry1,.T.,.T.)

	DbSelectArea(cAliQry1)

	IF !(cAliQry1)->(EOF())
		If (cAliQry1)->BC6_USPCO <> 0
			nVlrUs := (cAliQry1)->BC6_USPCO
		Endif

		If (cAliQry1)->BC6_VRPCO <> 0
			nVlrRea := (cAliQry1)->BC6_VRPCO
		Endif
		_cAlias := "BC6"
	Else
		//2a. Busca - BC6 Sem Plano
		cQuery := " SELECT BC6_FILIAL,BC6_CODINT,BC6_CODRDA,BC6_CODTAB,BC6_CODPAD,BC6_CODPRO,BC6_VIGFIM,BC6_USPCO,BC6_VRPCO,BC6_TPLANP, BC6_CODPLA "
		cQuery += " FROM " + RetSqlName("BC6")+ " BC6 INNER JOIN " + RETSQLNAME("BC5") + " BC5 ON "
		cQuery += "                                   BC5_FILIAL = '" + XFILIAL("BC5") + "' "
		cQuery += "                                   AND BC5_CODINT = BC6_CODINT "
		cQuery += "                                   AND BC5_CODRDA = BC6_CODRDA "
		cQuery += "                                   AND BC5_CODTAB = BC6_CODTAB "
		cQuery += "                                   AND (('" + DTOS( BD7->BD7_DATPRO ) + "' between BC5_DATINI AND BC5_DATFIM) OR (BC5_DATFIM = ' ' AND '" + DTOS( BD7->BD7_DATPRO ) + "' > BC5_DATINI)) "
		cQuery += "                                   AND BC5.D_E_L_E_T_ = ' ' "
		cQuery += " WHERE BC6.D_E_L_E_T_ = ' ' "
		cQuery += " AND BC6_FILIAL = '" + xFilial("BC6")  + "' "
		cQuery += " AND BC6_CODINT = '" + BD7->BD7_CODOPE + "' "
		cQuery += " AND BC6_CODRDA = '" + BD7->BD7_CODRDA + "' "
		cQuery += " AND BC6_CODPAD = '" + BD7->BD7_CODPAD + "' "
		If ALLTRIM(BD7->BD7_CODPAD) $ '00|02|15|16|17|18|19|20|98' //5 Níveis
			cQuery += " AND ( (BC6_CODPRO = '" + BD7->BD7_CODPRO + "' AND BC6_NIVEL = '4') OR "
			cQuery += "       (SUBSTR(BC6_CODPRO,1,5) = '" + SUBS(BD7->BD7_CODPRO,1,5) + "' AND BC6_NIVEL = '3') OR "
			cQuery += "       (SUBSTR(BC6_CODPRO,1,3) = '" + SUBS(BD7->BD7_CODPRO,1,3) + "' AND BC6_NIVEL = '2') OR "
			cQuery += "       (SUBSTR(BC6_CODPRO,1,1) = '" + SUBS(BD7->BD7_CODPRO,1,1) + "' AND BC6_NIVEL = '1') ) "
		ElseIf ALLTRIM(BD7->BD7_CODPAD) $ '01|04|06|07|26' .or. ALLTRIM(BD7->BD7_CODPAD) $ '05|09|23|24' //4 ou 3 Níveis, respectivamente
			cQuery += " AND ( (BC6_CODPRO = '" + BD7->BD7_CODPRO + "' AND BC6_NIVEL = '3') OR "
			cQuery += "       (SUBSTR(BC6_CODPRO,1,3) = '" + SUBS(BD7->BD7_CODPRO,1,3) + "' AND BC6_NIVEL = '2') OR "
			cQuery += "       (SUBSTR(BC6_CODPRO,1,1) = '" + SUBS(BD7->BD7_CODPRO,1,1) + "' AND BC6_NIVEL = '1') ) "
		Endif
		cQuery += " AND (('" + DTOS( BD7->BD7_DATPRO ) + "' between BC6_VIGINI AND BC6_VIGFIM) OR (BC6_VIGFIM = ' ' AND '" + DTOS( BD7->BD7_DATPRO ) + "' > BC6_VIGINI)) "
		cQuery += " AND ( BC6_VRPCO <> 0 OR BC6_USPCO <> 0 )"

		If Select(cAliQry1)>0
			(cAliQry1)->(DbCloseArea())
		EndIf

		DbUseArea(.T.,"TopConn",TcGenQry(,,cQuery),cAliQry1,.T.,.T.)

		DbSelectArea(cAliQry1)

		IF !(cAliQry1)->(EOF())
			If (cAliQry1)->BC6_USPCO <> 0
				nVlrUs := (cAliQry1)->BC6_USPCO
			Endif

			If (cAliQry1)->BC6_VRPCO <> 0
				nVlrRea :=  (cAliQry1)->BC6_VRPCO
			Endif

			_cAlias := "BC6"
		Else
			//3a. Busca - BC0
			cQuery := " SELECT BC0_FILIAL,BC0_CODINT,BC0_CODLOC,BC0_CODESP,BC0_CODTAB,BC0_CODPAD,BC0_CODOPC,BC0_VALCH,BC0_VALREA "
			cQuery += " FROM " + RetSqlName("BC0")+ " BC0  "
			cQuery += " WHERE BC0.D_E_L_E_T_ = ' ' "
			cQuery += " AND BC0_FILIAL = '" + xFilial("BC0")  + "' "
			cQuery += " AND BC0_CODINT = '" + BD7->BD7_CODOPE + "' "
			cQuery += " AND BC0_CODLOC = '" + BD7->BD7_CODLOC + "' "
			cQuery += " AND BC0_CODESP = '" + BD7->BD7_CODESP + "' "
			cQuery += " AND BC0_CODIGO = '" + BD7->BD7_CODRDA + "' "
			cQuery += " AND BC0_CODPAD = '" + BD7->BD7_CODPAD + "' "
			If ALLTRIM(BD7->BD7_CODPAD) $ '00|02|15|16|17|18|19|20|98' //5 Níveis
				cQuery += " AND ( (BC0_CODOPC = '" + BD7->BD7_CODPRO + "' AND BC0_NIVEL = '4') OR "
				cQuery += "       (SUBSTR(BC0_CODOPC,1,5) = '" + SUBS(BD7->BD7_CODPRO,1,5) + "' AND BC0_NIVEL = '3') OR "
				cQuery += "       (SUBSTR(BC0_CODOPC,1,3) = '" + SUBS(BD7->BD7_CODPRO,1,3) + "' AND BC0_NIVEL = '2') OR "
				cQuery += "       (SUBSTR(BC0_CODOPC,1,1) = '" + SUBS(BD7->BD7_CODPRO,1,1) + "' AND BC0_NIVEL = '1') ) "
			ElseIf ALLTRIM(BD7->BD7_CODPAD) $ '01|04|06|07|26' .or. ALLTRIM(BD7->BD7_CODPAD) $ '05|09|23|24' //4 ou 3 Níveis, respectivamente
				cQuery += " AND ( (BC0_CODOPC = '" + BD7->BD7_CODPRO + "' AND BC0_NIVEL = '3') OR "
				cQuery += "       (SUBSTR(BC0_CODOPC,1,3) = '" + SUBS(BD7->BD7_CODPRO,1,3) + "' AND BC0_NIVEL = '2') OR "
				cQuery += "       (SUBSTR(BC0_CODOPC,1,1) = '" + SUBS(BD7->BD7_CODPRO,1,1) + "' AND BC0_NIVEL = '1') ) "
			Endif
			cQuery += " AND (('" + DTOS( BD7->BD7_DATPRO ) + "' between BC0_VIGDE AND BC0_VIGATE) OR (BC0_VIGATE = ' ' AND '" + DTOS( BD7->BD7_DATPRO ) + "' > BC0_VIGDE)) "
			cQuery += " AND ( BC0_VALREA <> 0 OR BC0_VALCH <> 0 )"

			If Select(cAliQry1)>0
				(cAliQry1)->(DbCloseArea())
			EndIf

			DbUseArea(.T.,"TopConn",TcGenQry(,,cQuery),cAliQry1,.T.,.T.)

			DbSelectArea(cAliQry1)

			IF !(cAliQry1)->(EOF())
				If (cAliQry1)->BC0_VALCH <> 0
					nVlrUs := (cAliQry1)->BC0_VALCH
				Endif

				If (cAliQry1)->BC0_VALREA <> 0
					nVlrRea :=  (cAliQry1)->BC0_VALREA
				Endif

				_cAlias := "BC0"
			Else
				//4a.Busca - Tabela de Preço (B23)
				cQuery := " SELECT B29_CODIGO, B29_TABPRE, B29_VIGINI, B29_VIGFIN, B22_DESCRI, B22_DATINI, B22_DATFIM, B23.* "
				cQuery += "   FROM " + RetSqlName('B29') + " B29 "
				cQuery += " 	 , " + RetSqlName('B22') + " B22 "
				cQuery += " 	 , " + RetSqlName('B23') + " B23 "
				cQuery += "  WHERE B29_FILIAL = '" + xFilial("B29") + "' "
				cQuery += "    AND B22_FILIAL = '" + xFilial("B22") + "' "
				cQuery += "    AND B23_FILIAL = '" + xFilial("B23") + "' "
				cQuery += "    AND B29_CODIGO = '" + BD7->BD7_CODRDA + "' "
				cQuery += "    AND B29_CODINT = B22_CODINT "
				cQuery += "    AND B29_TABPRE = B22_CODTAB "
				cQuery += "    AND B22_CODINT = B23_CODINT "
				cQuery += "    AND B22_CODTAB = B23_CODTAB "
				cQuery += "    AND B23_CODPAD = '" + BD7->BD7_CODPAD + "' "
				cQuery += "    AND '" + BD7->BD7_CODPRO + "' BETWEEN B23_CDPRO1 AND B23_CDPRO2 "
				cQuery += "    AND (('" + DTOS( BD7->BD7_DATPRO ) + "' BETWEEN B29_VIGINI AND B29_VIGFIN) OR (B29_VIGFIN = ' ' AND '" + DTOS( BD7->BD7_DATPRO ) + "' > B29_VIGINI)) "
				cQuery += "    AND ( B23_VRPCO <> 0 OR B23_USPCO <> 0 )"
				cQuery += "    AND B29.D_E_L_E_T_ = ' ' "
				cQuery += "    AND B22.D_E_L_E_T_ = ' ' "
				cQuery += "    AND B23.D_E_L_E_T_ = ' ' "
				cQuery += "  ORDER BY  B29_CODIGO, B29_TABPRE, B29_VIGINI, B23_CODPAD, B23_CODPRO "

				If Select(cAliQry1)>0
					(cAliQry1)->(DbCloseArea())
				EndIf

				DbUseArea(.T.,"TopConn",TcGenQry(,,cQuery),cAliQry1,.T.,.T.)

				DbSelectArea(cAliQry1)

				IF !(cAliQry1)->(EOF())
					If (cAliQry1)->B23_USPCO <> 0
						nVlrUs := (cAliQry1)->B23_USPCO
					Endif

					If (cAliQry1)->B23_VRPCO <> 0
						nVlrRea :=  (cAliQry1)->B23_VRPCO
					Endif

					_cAlias := "B23"
				Else
					//5a.Busca - Especialidades Médicas
					cQuery := " SELECT BBM_FILIAL,BBM_CODINT,BBM_CODESP,BBM_CODPAD,BBM_CODPSA,BBM_VALCH,BBM_VALREA "
					cQuery += " FROM " + RetSqlName("BBM")+ " BBM "
					cQuery += " WHERE BBM.D_E_L_E_T_ = ' ' "
					cQuery += " AND BBM_FILIAL = '" + xFilial("BBM")  + "' "
					cQuery += " AND BBM_CODINT = '" + BD7->BD7_CODOPE + "' "
					cQuery += " AND BBM_CODESP = '" + BD7->BD7_CODESP + "' "
					cQuery += " AND BBM_CODPAD = '" + BD7->BD7_CODPAD + "' "
					cQuery += " AND BBM_ATIVO = '1' "
					If ALLTRIM(BD7->BD7_CODPAD) $ '00|02|15|16|17|18|19|20|98' //5 Níveis
						cQuery += " AND ( (BBM_CODPSA = '" + BD7->BD7_CODPRO + "' AND BBM_NIVEL = '4') OR "
						cQuery += "       (SUBSTR(BBM_CODPSA,1,5) = '" + SUBS(BD7->BD7_CODPRO,1,5) + "' AND BBM_NIVEL = '3') OR "
						cQuery += "       (SUBSTR(BBM_CODPSA,1,3) = '" + SUBS(BD7->BD7_CODPRO,1,3) + "' AND BBM_NIVEL = '2') OR "
						cQuery += "       (SUBSTR(BBM_CODPSA,1,1) = '" + SUBS(BD7->BD7_CODPRO,1,1) + "' AND BBM_NIVEL = '1') ) "
					ElseIf ALLTRIM(BD7->BD7_CODPAD) $ '01|04|06|07|26' .or. ALLTRIM(BD7->BD7_CODPAD) $ '05|09|23|24' //4 ou 3 Níveis, respectivamente
						cQuery += " AND ( (BBM_CODPSA = '" + BD7->BD7_CODPRO + "' AND BBM_NIVEL = '3') OR "
						cQuery += "       (SUBSTR(BBM_CODPSA,1,3) = '" + SUBS(BD7->BD7_CODPRO,1,3) + "' AND BBM_NIVEL = '2') OR "
						cQuery += "       (SUBSTR(BBM_CODPSA,1,1) = '" + SUBS(BD7->BD7_CODPRO,1,1) + "' AND BBM_NIVEL = '1') ) "
					Endif
					cQuery += " AND (('" + DTOS( BD7->BD7_DATPRO ) + "' <= BBM_DATVAL) OR (BBM_DATVAL = ' ')) "
					cQuery += " AND ( BBM_VALREA <> 0 OR BBM_VALCH <> 0 )"

					If Select(cAliQry1)>0
						(cAliQry1)->(DbCloseArea())
					EndIf

					DbUseArea(.T.,"TopConn",TcGenQry(,,cQuery),cAliQry1,.T.,.T.)

					DbSelectArea(cAliQry1)

					IF !(cAliQry1)->(EOF())
						If (cAliQry1)->BBM_VALCH <> 0
							nVlrUs := (cAliQry1)->BBM_VALCH
						Endif

						If (cAliQry1)->BBM_VALREA <> 0
							nVlrRea :=  (cAliQry1)->BBM_VALREA
						Endif

						_cAlias := "BBM"
					Else
						//6a.Busca - Parâmetros Mensais
						cQuery := "SELECT NVL(BFM_VALRDA,0) AS USPAG FROM "+RetSQLName("BFM")+" WHERE "
						cQuery += "BFM_FILIAL = '"+xFilial("BFM")+"' AND "
						cQuery += "BFM_ANO||BFM_MES = '" + SUBSTR(DTOS(BD6->BD6_DATPRO),1,6) + "' AND "
						cQuery += "D_E_L_E_T_ = ' ' "

						If Select(cAliQry1)>0
							(cAliQry1)->(DbCloseArea())
						EndIf

						DbUseArea(.T.,"TopConn",TcGenQry(,,cQuery),cAliQry1,.T.,.T.)

						DbSelectArea(cAliQry1)

						IF !(cAliQry1)->(EOF())
							If (cAliQry1)->USPAG <> 0
								nVlrUs := (cAliQry1)->USPAG
							Endif

							_cAlias := "BFM"
						Endif
					Endif
				Endif
			Endif
		Endif
	Endif
	memowrite('C:\TEMP\BuscaCH.SQL',cQuery )
	aAdd(aRet,{nVlrUs,nVlrRea,_cAlias})

Return aRet
/*
***********************************************
* Progrma: EnvMail      Autor: Fabio Bianchini*
* Descrição: Rotina para envio de emails.     *
* Data: 18/03/2020                            *
* Parametros: EMail Origem, EMail Destino,    *
*             Subject, Body, Anexo, .T., Bcc  *
***********************************************
*/ 

User Function ENVMAIL(_pcOrigem,_pcDestino,_pcSubject,_pcBody,_pcArquivo,_plAutomatico,_pcBcc)
	// Variaveis da função
	//**************************************************************
	Local _nAux := 0

	Private _nTentativas := 0
	//Private _cSMTPServer := GetMV("MV_WFSMTP")
	//Private _cAccount    := GetMV("MV_WFMAIL")
	//Private _cPassword   := GetMV("MV_WFPASSW")
	Private _cSMTPServer := GetMv(  "MV_RELSERV" )
	Private _cAccount    := GetMv( "MV_EMCONTA")
	Private _cPassword   := GetMv( "MV_EMSENHA" )
	Private _lEnviado    := .F.
	Private _cUsuario    := Upper(AllTrim(cUserName))

	// Validação dos campos do email
	//**************************************************************
	If _pcBcc == NIL
		_pcBcc := ""
	EndIf

	_pcBcc := StrTran(_pcBcc," ","")

	If _pcOrigem == NIL
		//_pcOrigem := GetMV("MV_WFMAIL")
		_pcOrigem :=GetMv( "MV_EMCONTA")
	EndIf

	_pcOrigem := StrTran(_pcOrigem," ","")

	If _pcDestino == NIL
		_pcDestino := "seuemail@dominio.com.br"
	EndIf

	_pcDestino := StrTran(_pcDestino," ","")

	If _pcSubject == NIL
		_pcSubject := "Sem Subject (ENVMAIL)"
	EndIf

	If _pcBody == NIL
		_pcBody := "Sem Body (ENVMAIL)"
	EndIf

	If _pcArquivo == NIL
		_pcArquivo := ""
	EndIf

	For _nAux := 1 To 10
		_pcOrigem := StrTran(_pcOrigem," ;","")
		_pcOrigem := StrTran(_pcOrigem,"; ","")
	Next

	If _plAutomatico == NIL
		_plAutomatico := .F.
	EndIf

	// Executa a função, mostrando a tela de envio (.T.) ou não (.F.)
	//**************************************************************
	If !_plAutomatico
		Processa({||EnviaEmail(_pcOrigem,_pcDestino,_pcSubject,_pcBody,_pcArquivo,_plAutomatico,_pcBcc)},"Enviando EMail(s)...")
	Else
		EnviaEmail(_pcOrigem,_pcDestino,_pcSubject,_pcBody,_pcArquivo,_plAutomatico,_pcBcc)
	EndIf

	If !_plAutomatico
		If !_lEnviado
			MsgStop("Atenção: Erro no envio de EMail!!!")
		EndIf
	Else
		QOut("Atenção: Erro no envio de Email!")
	Endif

Return _lEnviado

/*
***********************************************
* Progrma: EnviaEmail   Autor: Fabio Bianchini*
* Descrição: Subrotina para envio de email.   *
* Data: 18/03/2020                            *
* Parametros: EMail Origem, EMail Destino,    *
*             Subject, Body, Anexo, .T., Bcc  *
***********************************************
*/ 
Static Function EnviaEmail(_pcOrigem,_pcDestino,_pcSubject,_pcBody,_pcArquivo,_plAutomatico,_pcBcc)

	Local _nTentMax := 50  // Tentativas máximas
	Local _nSecMax  := 30  // Segundos máximos
	Local _cTime    := (Val(Substr(Time(),1,2))*60*60)+(Val(Substr(Time(),4,2))*60)+Val(Substr(Time(),7,2))
	Local _nTentativas := 0

	//**************************************************************
	// O que ocorrer primeiro (segundos ou tentativas), ele para.
	//**************************************************************
	_cTime += _nSecMax

	If !_plAutomatico
		ProcRegua(_nTentMax)
	EndIf

	//**************************************************************
	// Exibe mensagem no console/Log
	//**************************************************************
	QOut("ENVMAIL=> ***** Envio de Email ***** "+AllTrim("DE:"+_pcOrigem)+"*"+AllTrim("P/:"+_pcDestino)+"*"+AllTrim("S:"+_pcSubject)+"*"+AllTrim("A:"+_pcArquivo))

	For _nTentativas := 1 To _nTentMax

		If !_plAutomatico
			IncProc("Tentativa "+AllTrim(Str(_nTentativas)))
		EndIf
		QOut("ENVMAIL=> ***** Tentativa "+AllTrim(Str(_nTentativas))+" ***** "+AllTrim("DE:"+_pcOrigem)+"*"+AllTrim("P/:"+_pcDestino)+"*"+AllTrim("S:"+_pcSubject)+"*"+AllTrim("A:"+_pcArquivo))

		CONNECT SMTP SERVER _cSMTPServer ACCOUNT _cAccount PASSWORD _cPassword RESULT _lEnviado

		If _lEnviado
			If Empty(_pcBcc)
				If Empty(_pcArquivo)
					SEND MAIL FROM _pcOrigem TO _pcDestino SUBJECT _pcSubject BODY _pcBody /*FORMAT TEXT*/ RESULT _lEnviado
				Else
					SEND MAIL FROM _pcOrigem TO _pcDestino SUBJECT _pcSubject BODY _pcBody ATTACHMENT _pcArquivo /*FORMAT TEXT*/ RESULT _lEnviado
				EndIf
			Else
				If Empty(_pcArquivo)
					SEND MAIL FROM _pcOrigem TO _pcDestino BCC _pcBcc SUBJECT _pcSubject BODY _pcBody /*FORMAT TEXT*/ RESULT _lEnviado
				Else
					SEND MAIL FROM _pcOrigem TO _pcDestino BCC _pcBcc SUBJECT _pcSubject BODY _pcBody ATTACHMENT _pcArquivo /*FORMAT TEXT*/ RESULT _lEnviado
				EndIf
			EndIf
			DISCONNECT SMTP SERVER
		EndIf

		If _lEnviado .Or. _cTime <= (Val(Substr(Time(),1,2))*60*60)+(Val(Substr(Time(),4,2))*60)+Val(Substr(Time(),7,2))
			_nTentativas := _nTentMax
		EndIf
	Next

	QOut("ENVMAIL=> ***** Resultado de Envio "+IIf(_lEnviado,"T","F")+" / "+AllTrim(Str(_nTentativas))+" ***** "+AllTrim("DE:"+_pcOrigem)+"*"+AllTrim("P/:"+_pcDestino)+"*"+AllTrim("S:"+_pcSubject)+"*"+AllTrim("A:"+_pcArquivo))

Return

User function fFltCom()

	local cQuery2    := " "
	local cTitulos   := ''
	local cTitulos1  := ''
	lOCAL cAliastmp2 := GetNextAlias()



	cQuery2 :=  " SELECT distinct bxq1.BXQ_E2FORN , "
	cQuery2 += CRLF+ "                   bxq1.BXQ_E2PREF , "
	cQuery2 += CRLF+ "                   bxq1.BXQ_E2NUM  , "
	cQuery2 += CRLF+ "                   bxq1.BXQ_E2PARC , "
	cQuery2 += CRLF+ "                   bxq1.BXQ_E2TIPO , "
	cQuery2 += CRLF+ "                   bxq1.BXQ_E2LOJA   "

	cQuery2 += CRLF+ "  from  " + RetSqlName("SE2") +" SE2 ,"

	cQuery2 += CRLF+ "  (SELECT distinct BXQ_E2FORN , "
	cQuery2 += CRLF+ "                   BXQ_E2PREF , "
	cQuery2 += CRLF+ "                   BXQ_E2NUM  , "
	cQuery2 += CRLF+ "                   BXQ_E2PARC , "
	cQuery2 += CRLF+ "                   BXQ_E2TIPO , "
	cQuery2 += CRLF+ "                   BXQ_E2LOJA   "

	cQuery2 += CRLF+ "  from " + RetSqlName("BXQ") + " BXQ "
	cQuery2 += CRLF+ "   WHERE  BXQ_FILIAL     = '"+xFilial('BXQ')+ "'  and BXQ.D_E_L_E_T_ = ' ' "

	cQuery2 += CRLF+ "   and bxq_e2num <>  ' ' "
	cQuery2 += CRLF+ "   AND BXQ_CODVEN NOT in ('000174','000172','000171','000191','000177','000215' )) bxq1 "

	cQuery2 += CRLF+ " WHERE SE2.d_e_l_e_t_ = ' ' AND E2_FILIAL = '"+xFilial('SE2')+ "' "

	cQuery2 += CRLF+ "   and E2_FORNECE = bxq1.BXQ_E2FORN "
	cQuery2 += CRLF+ "   and E2_PREFIXO = bxq1.BXQ_E2PREF "

	cQuery2 += CRLF+ "   and E2_NUM     = bxq1.BXQ_E2NUM  "
	cQuery2 += CRLF+ "   and E2_PARCELA = bxq1.BXQ_E2PARC "
	cQuery2 += CRLF+ "   and E2_TIPO    = bxq1.BXQ_E2TIPO "
	cQuery2 += CRLF+ "   and E2_LOJA    = bxq1.BXQ_E2LOJA "
	cQuery2 += CRLF+ "   and e2_baixa   = ' ' and e2_saldo > 0 "

	cQuery2 += CRLF + "    AND nvl(( SELECT COUNT(*) QTDA "
	cQuery2 += CRLF + "                FROM siga."+RetSQLName("PDT")+" PDT  "
	cQuery2 += CRLF + "               WHERE PDT_FILIAL = '" + xFilial('PDT') + "'
	cQuery2 += CRLF + "                 AND D_e_l_e_t_ = ' ' "
	cQuery2 += CRLF + "                 AND PDT_PREFIX = se2.e2_prefixo "
	cQuery2 += CRLF + "                 AND PDT_NUM    = se2.e2_num "
	cQuery2 += CRLF + "                 AND PDT_PARCEL = se2.e2_parcela "
	cQuery2 += CRLF + "                 AND PDT_TIPO   = se2.e2_tipo  "
	cQuery2 += CRLF + "                 AND PDT_FORNEC = se2.e2_fornece "
	cQuery2 += CRLF + "                 and pdt_aprov  = '000047'),0) > 0 "

	cQuery2 += CRLF + "    AND nvl(( SELECT COUNT(*) QTDA "
	cQuery2 += CRLF + "                FROM siga."+RetSQLName("PDT")+" PDT  "
	cQuery2 += CRLF + "               WHERE PDT_FILIAL = '" + xFilial('PDT') + "'
	cQuery2 += CRLF + "                 AND D_e_l_e_t_ = ' ' "
	cQuery2 += CRLF + "                 AND PDT_PREFIX = se2.e2_prefixo "
	cQuery2 += CRLF + "                 AND PDT_NUM    = se2.e2_num "
	cQuery2 += CRLF + "                 AND PDT_PARCEL = se2.e2_parcela "
	cQuery2 += CRLF + "                 AND PDT_TIPO   = se2.e2_tipo  "
	cQuery2 += CRLF + "                 AND PDT_FORNEC = se2.e2_fornece "
	cQuery2 += CRLF + "                 and pdt_aprov  = '001495'),0) > 0 "


	If Select((cAliastmp2)) <> 0
		(cAliastmp2)->(DbCloseArea())
	Endif

	TCQuery cQuery2 New Alias (cAliastmp2)

	(cAliastmp2)->( DbGoTop() )

	While !(cAliastmp2)->(Eof())


		cTitulos  += trim((cAliastmp2)->BXQ_E2NUM) +"|"

		(cAliastmp2)->(DbSkip())

	Enddo

	cTitulos1 := FormatIn(cTitulos ,"|")

	If Select((cAliastmp2)) <> 0
		(cAliastmp2)->(DbCloseArea())
	Endif

Return (cTitulos1)



User Function DlgToCSV(aExport)

	Local aArea		 := GetArea()
	Local cDirDocs   := MsDocPath()
	Local cPath		 := AllTrim(GetTempPath())
	Local ny		 := 0
	Local nX         := 0
	Local nz		 := 0
	Local cBuffer   := ""
	//Local oExcelApp := Nil
	Local nHandle   := 0
	Local cArquivo  := CriaTrab(,.F.)
	Local aCfgTab	:= {50}
	Local aHeader	:= {}
	Local aCols		:= {}
	Local aGets     := {}
	Local aTela     := {}
	Local cAuxTxt
	Local aParamBox	:= {}
	LOcal aRet		:= {}
	Local aList
	Local cGetDb
	Local cTabela	
	Local lArqLocal := ExistBlock("DIRDOCLOC")
	Local nPosPrd	:= 0

	If !VerSenha(170)
		Help(" ",1,"SEMPERM")
		Return
	Endif

	If Type("cCadastro") == "U"
		cCadastro := ""
	EndIf

	For nz := 1 to Len(aExport)
		cAuxTxt := If(nz==1,"Selecione os dados :","") //"Selecione os dados :"
		Do Case
		Case aExport[nz,1] == "CABECALHO"
			aCols	:= aExport[nz,4]
			If !Empty(aCols)
				If Empty(aExport[nz,2])
					aAdd(aParamBox,{4,cAuxTxt,.T.,"Cabecalho",90,,.F.}) //"Cabecalho"
				Else
					aAdd(aParamBox,{4,cAuxTxt,.T.,AllTrim(aExport[nz,2]),90,,.F.})
				EndIf
			EndIf
		Case aExport[nz,1] == "ENCHOICE"
			If Empty(aExport[nz,2])
				aAdd(aParamBox,{4,cAuxTxt,.T.,"Campos",90,,.F.}) //"Campos"
			Else
				aAdd(aParamBox,{4,cAuxTxt,.T.,AllTrim(aExport[nz,2]),90,,.F.})
			EndIf
		Case aExport[nz,1] == "GETDADOS"
			aCols	:= aExport[nz,4]
			If !Empty(aCols)
				If Empty(aExport[nz,2])
					aAdd(aParamBox,{4,cAuxTxt,.T.,"Lista de Itens",90,,.F.}) //"Lista de Itens"
				Else
					aAdd(aParamBox,{4,cAuxTxt,.T.,AllTrim(aExport[nz,2]),90,,.F.})
				EndIf
			EndIf
		Case aExport[nz,1] == "ARRAY"
			aList		:= aExport[nz,4]
			If !Empty(aList)
				If Empty(aExport[nz,2])
					aAdd(aParamBox,{4,cAuxTxt,.T.,"Detalhes",90,,.F.}) //"Detalhes"
				Else
					aAdd(aParamBox,{4,cAuxTxt,.T.,AllTrim(aExport[nz,2]),90,,.F.})
				EndIf
			EndIf
		Case aExport[nz,1] == "GETDB"
			If Empty(aExport[nz,2])
				aAdd(aParamBox,{4,cAuxTxt,.T.,"Lista de Itens",90,,.F.}) // "Lista de Itens"
			Else
				aAdd(aParamBox,{4,cAuxTxt,.T.,AllTrim(aExport[nz,2]),90,,.F.})
			EndIf
		Case aExport[nz,1] == "TABELA"
			If Empty(aExport[nz,2])
				aAdd(aParamBox,{4,cAuxTxt,.T.,"Lista de Itens",90,,.F.}) // "Lista de Itens"
			Else
				aAdd(aParamBox,{4,cAuxTxt,.T.,AllTrim(aExport[nz,2]),90,,.F.})
			EndIf
		EndCase
	Next nz

	SAVEINTER()

	If Len(aExport)==1 .Or. ParamBox(aParamBox,"Exportar para Planilha",aRet,,,,,,,,.F.)  //"Exportar para MS-Excel"
		// gera o arquivo em formato .CSV
		cArquivo += ".CSV"

		If lArqLocal
			nHandle := FCreate(cPath + "\" + cArquivo)
		Else
			nHandle := FCreate(cDirDocs + "\" + cArquivo)
		Endif

		If nHandle == -1
			MsgStop("Erro na criacao do arquivo na estacao local. Contate o administrador do sistema") //"Erro na criacao do arquivo na estacao local. Contate o administrador do sistema"
			RESTINTER()
			Return
		EndIf

		For nz := 1 to Len(aExport)
			If Len(aExport)>1 .And. !aRet[nz]
				Loop
			EndIf
			Do Case
			Case aExport[nz,1] == "CABECALHO"
				cBuffer := AllTrim(cCadastro)
				FWrite(nHandle, cBuffer)
				FWrite(nHandle, CRLF)
				FWrite(nHandle, CRLF)
				cBuffer	:= ""
				aHeader	:= aExport[nz,3]
				aCols	:= aExport[nz,4]
				If !Empty(aCols)
					cBuffer := AllTrim(aExport[nz,2]	)
					FWrite(nHandle, cBuffer)
					FWrite(nHandle, CRLF)
					FWrite(nHandle, CRLF)
					cBuffer	:= ""
					For nx := 1 To Len(aHeader)
						If nx == Len(aHeader)
							cBuffer += ToXlsFormat(aHeader[nx])
						Else
							cBuffer += ToXlsFormat(aHeader[nx]) + ";"
						EndIf
					Next nx
					FWrite(nHandle, cBuffer)
					FWrite(nHandle, CRLF)
					cBuffer	:= ""
					For nx := 1 To Len(aCols)
						If nx == Len(aCols)
							cBuffer += ToXlsFormat(aCols[nx])
						Else
							cBuffer += ToXlsFormat(aCols[nx]) + ";"
						EndIf
					Next nx
					FWrite(nHandle, cBuffer)
					FWrite(nHandle, CRLF)
					FWrite(nHandle, CRLF)
				EndIf
			Case aExport[nz,1] == "ENCHOICE"
				cBuffer := AllTrim(cCadastro)
				FWrite(nHandle, cBuffer)
				FWrite(nHandle, CRLF)
				FWrite(nHandle, CRLF)
				cBuffer := AllTrim(aExport[nz,2]	)
				FWrite(nHandle, cBuffer)
				FWrite(nHandle, CRLF)
				FWrite(nHandle, CRLF)
				cBuffer	:= ""
				aGets := aExport[nz,3]
				aTela := aExport[nz,3]
				For nx := 1 to Len(aGets)
					dbSelectArea("SX3")
					dbSetOrder(2)
					dbSeek(Substr(aGets[nx],9,10))
					If nx == Len(aGets)
						cBuffer += ToXlsFormat(Alltrim(X3TITULO()))
					Else
						cBuffer += ToXlsFormat(Alltrim(X3TITULO())) + ";"
					EndIf
				Next nx
				FWrite(nHandle, cBuffer)
				FWrite(nHandle, CRLF)
				cBuffer := ""
				For nx := 1 to Len(aGets)
					If nx == Len(aGets)
						cBuffer += ToXlsFormat(  &("M->"+AllTrim(Substr(aGets[nx],9,10))), Substr(aGets[nx],9,10) )
					Else
						cBuffer += ToXlsFormat( &("M->"+AllTrim(Substr(aGets[nx],9,10))) ,Substr(aGets[nx],9,10) ) + ";"
					EndIf
				Next nx
				FWrite(nHandle, cBuffer)
				FWrite(nHandle, CRLF)
				FWrite(nHandle, CRLF)
				cBuffer := ""
			Case aExport[nz,1] == "GETDADOS"
				cBuffer	:= ""
				aHeader	:= aExport[nz,3]
				aCols		:= aExport[nz,4]
				nPosPrd := aScan(aHeader, {|x| Alltrim(x[2]) $ "C1_PRODUTO*C7_PRODUTO"})
				If !Empty(aCols)
					cBuffer := AllTrim(aExport[nz,2]	)
					FWrite(nHandle, cBuffer)
					FWrite(nHandle, CRLF)
					FWrite(nHandle, CRLF)
					cBuffer	:= ""
					For nx := 1 To Len(aHeader)
						If nx == Len(aHeader)
							cBuffer += ToXlsFormat(Alltrim(aHeader[nx,1]))
						Else
							cBuffer += ToXlsFormat(Alltrim(aHeader[nx,1])) + ";"
						EndIf
					Next nx
					FWrite(nHandle, cBuffer)
					FWrite(nHandle, CRLF)
					cBuffer := ""
					For nx := 1 to Len(aCols)
						If Valtype(aCols[nx][Len(aCols[nx])]) # "L" .Or. (Valtype(aCols[nx][Len(aCols[nx])]) == "L" .And. !aCols[nx][Len(aCols[nx])])
							For ny := 1 to Len(aCols[nx])-1
								If ny == Len(aCols[nx])-1
									cBuffer += ToXlsFormat(aCols[nx,ny],aHeader[ny,2])
								ElseIf nPosPrd > 0 .And. ny == nPosPrd
									cBuffer += "=" + ToXlsFormat(aCols[nx,ny],aHeader[ny,2]) + ";"
								Else
									cBuffer += ToXlsFormat(aCols[nx,ny],aHeader[ny,2]) + ";"
								EndIf
							Next ny
							FWrite(nHandle, cBuffer)
							FWrite(nHandle, CRLF)
							cBuffer := ""
						EndIf
					Next nx
					FWrite(nHandle, CRLF)
				EndIf
			Case aExport[nz,1] == "ARRAY"
				cBuffer := AllTrim(cCadastro)
				FWrite(nHandle, cBuffer)
				FWrite(nHandle, CRLF)
				FWrite(nHandle, CRLF)
				cBuffer	:= ""
				aHeader	:= aExport[nz,3]
				aList		:= aExport[nz,4]
				If !Empty(aList)
					cBuffer := AllTrim(aExport[nz,2]	)
					FWrite(nHandle, cBuffer)
					FWrite(nHandle, CRLF)
					FWrite(nHandle, CRLF)
					cBuffer	:= ""
					For nx := 1 To Len(aHeader)
						If nx == Len(aHeader)
							cBuffer += ToXlsFormat(Alltrim(aHeader[nx]))
						Else
							cBuffer += ToXlsFormat(Alltrim(aHeader[nx])) + ";"
						EndIf
					Next nx
					FWrite(nHandle, cBuffer)
					FWrite(nHandle, CRLF)
					cBuffer := ""
					For nx := 1 to Len(aList)
						For ny := 1 to Len(aList[nx])
							If ny == Len(aList[nx])
								cBuffer += ToXlsFormat(aList[nx,ny])
							Else
								cBuffer += ToXlsFormat(aList[nx,ny]) + ";"
							EndIf
						Next ny
						FWrite(nHandle, cBuffer)
						FWrite(nHandle, CRLF)
						cBuffer := ""
					Next nx
					FWrite(nHandle, CRLF)
				EndIf
			Case aExport[nz,1] == "GETDB"
				cBuffer	:= ""
				aHeader	:= aExport[nz,3]
				cGetDb	:= aExport[nz,4]
				cBuffer := AllTrim(aExport[nz,2]	)
				FWrite(nHandle, cBuffer)
				FWrite(nHandle, CRLF)
				FWrite(nHandle, CRLF)
				cBuffer	:= ""
				For nx := 1 To Len(aHeader)
					If nx == Len(aHeader)
						cBuffer += ToXlsFormat(Alltrim(aHeader[nx,1]))
					Else
						cBuffer += ToXlsFormat(Alltrim(aHeader[nx,1])) + ";"
					EndIf
				Next nx
				FWrite(nHandle, cBuffer)
				FWrite(nHandle, CRLF)
				cBuffer := ""
				dbSelectArea(cGetDb)
				aAuxArea	:= GetArea()
				dbGotop()
				While !Eof()
					For nx := 1 to Len(aHeader)
						If nx == Len(aHeader)
							cBuffer += ToXlsFormat(FieldGet(ColumnPos(AllTrim(aHeader[nx,2]))),AllTrim(aHeader[nx,2]))
						Else
							cBuffer += ToXlsFormat(FieldGet(ColumnPos(AllTrim(aHeader[nx,2]))),AllTrim(aHeader[nx,2]))+";"
						EndIf
					Next
					FWrite(nHandle, cBuffer)
					FWrite(nHandle, CRLF)
					cBuffer := ""
					dbSkip()
				End
				FWrite(nHandle, CRLF)
				RestArea(aAuxArea)
			Case aExport[nz,1] == "TABELA"
				if !ParamBox( { { 1,"STR0051" ,50,"@E 99999" 	 ,""  ,""    ,"" ,30 ,.T. } }, "STR0052", aCfgTab ,,,,,,,,.F.)
					RESTINTER()
					Return
				endif
				cBuffer	:= ""
				aHeader	:= aExport[nz,3]
				cTabela	:= aExport[nz,4]
				cBuffer := AllTrim(aExport[nz,2]	)
				FWrite(nHandle, cBuffer)
				FWrite(nHandle, CRLF)
				FWrite(nHandle, CRLF)
				cBuffer	:= ""
				For nx := 1 To Len(aHeader)
					//	If aHeader[nx,3]
					If nx == Len(aHeader)
						cBuffer += ToXlsFormat(Alltrim(aHeader[nx,1]))
					Else
						cBuffer += ToXlsFormat(Alltrim(aHeader[nx,1])) + ";"
					EndIf
					//	EndIf
				Next nx
				FWrite(nHandle, cBuffer)
				FWrite(nHandle, CRLF)
				cBuffer := ""
				dbSelectArea(cTabela)
				aAuxArea	:= GetArea()
				While !Eof() .And. aCfgTab[1] > 0
					For nx := 1 to Len(aHeader)
						//	If aHeader[nx,3]
						If nx == Len(aHeader)
							cBuffer += ToXlsFormat(FieldGet(ColumnPos(AllTrim(aHeader[nx,2]))),AllTrim(aHeader[nx,2]))
						Else
							cBuffer += ToXlsFormat(FieldGet(ColumnPos(AllTrim(aHeader[nx,2]))),AllTrim(aHeader[nx,2]))+";"
						EndIf
						//	EndIf
					Next
					FWrite(nHandle, cBuffer)
					FWrite(nHandle, CRLF)
					cBuffer := ""
					dbSkip()
					aCfgTab[1]--
				End
				FWrite(nHandle, CRLF)
				RestArea(aAuxArea)
			EndCase
		Next nz

		FClose(nHandle)

		// copia o arquivo do servidor para o remote
		If !lArqLocal
			CpyS2T(cDirDocs + "\" + cArquivo, cPath, .T.)
		Endif

		//If ApOleClient("MsExcel")
		//	oExcelApp := MsExcel():New()
		//	oExcelApp:WorkBooks:Open(cPath + "\" + cArquivo)
		//	oExcelApp:SetVisible(.T.)
		//	oExcelApp:Destroy()
		//Else


		ShellExecute('open',cPath + "\" + cArquivo,"","",SW_NORMAL)

		MsgInfo("Planilha Gerada em:" +  cPath + " \ " + cArquivo ,"Atenção")

		//EndIf

	EndIf

	RESTINTER()

	RestArea(aArea)
Return
