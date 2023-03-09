#Include "Protheus.Ch"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³xExpTab   ºAutor  ³ Marcelo Amaral     º Data ³  05/02/2013 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Exporta Tabelas do Protheus                                º±±
±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Uso Geral                                                  º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function xExpTab()

Local aArea := GetArea() 
Local nCont := 0
Local lPergOk := .F.

Private aTab := {}
Private aTabSel := {}
Private c_dirimp := space(100) 
Private _oDlg

DEFINE MSDIALOG _oDlg TITLE "Selecione a Pasta para Exportação" FROM C(000),C(000) TO C(100),C(250) PIXEL

@ 007,009 Say   "Diretorio"       SIZE 045,008 PIXEL OF _oDlg
@ 015,009 MSGET c_dirimp          SIZE 120,010 WHEN .F. PIXEL OF _oDlg
@ 015,140 BUTTON "..."            SIZE 013,013 PIXEL OF _oDlg ACTION (c_dirimp := cGetFile(,OemToAnsi("Exportação de Tabelas"),,"",.F.,GETF_LOCALHARD+GETF_NETWORKDRIVE+GETF_RETDIRECTORY,.F.))

@ 30,009 Button "OK" Size C(037),C(012) PIXEL OF _oDlg Action xExpTabA()
@ 30,050 Button "Cancelar" Size C(037),C(012) PIXEL OF _oDlg Action _oDlg:end()

ACTIVATE MSDIALOG _oDlg CENTERED

RestArea(aArea)

Return

Static Function xExpTabA()

Local nCont := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

If !fSelTab() 
    Return
EndIf

If Len(aTab) = 0
	MsgAlert("Nenhuma Tabela foi exibida para seleção!")
	Return
EndIf

aTabSel := {}
For nCont := 1 to Len(aTab)
	If aTab[nCont,1]
		aadd(aTabSel,aTab[nCont])
    Endif
Next
If Len(aTabSel) = 0
	MsgAlert("Nenhuma Tabela foi selecionada!")
	Return
Endif

Processa({|| xExpTabB() }, "Aguarde...", "Exportando as Tabelas Selecionadas...",.F.)

Return

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa   ³fBoxTab() ³ Autor ³ Marcelo Amaral          ³ Data ³05/02/2013³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao  ³ Montagem da ListBox                                          ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/

User Function fBoxTab()
Local oOk	:= LoadBitmap( GetResources(), "LBOK" )
Local oNo	:= LoadBitmap( GetResources(), "LBNO" )

// Carrege aqui sua array da Listbox
dbSelectArea("SX2")
SX2->(dbSetOrder(1))
SX2->(dbGoTop())
While !SX2->(EOF())
	aadd(aTab,{.F.,SX2->X2_CHAVE,SX2->X2_NOME})
	SX2->(dbSkip())
End

@ 004,003 ListBox oLstBoxTab Fields HEADER "","Chave","Nome" Size 200,150 Of oDlg Pixel ColSizes 30,50 On DBLCLICK ( aTab[oLstBoxTab:nAt,1] := !(aTab[oLstBoxTab:nAt,1]), oLstBoxTab:Refresh() )
oLstBoxTab:SetArray(aTab)

// Cria ExecBlocks das ListBoxes
oLstBoxTab:bLine := {|| {If(aTab[oLstBoxTab:nAt,1],oOk,oNo),aTab[oLstBoxTab:nAt,2],aTab[oLstBoxTab:nAt,3]}}

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFun‡„o    ³ fSelTab  º Autor ³ Marcelo Amaral     º Data ³  05/02/13   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescri‡„o ³ Seleciona as tabelas a serem exportadas                    º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Programa principal                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function fSelTab()
Local lOk := .F.
Private oDlg

Private VISUAL := .F.
Private INCLUI := .F.
Private ALTERA := .F.
Private DELETA := .F.
Private oChkTab
Private oLstBoxTab
Private lChkTab := .F.

DEFINE MSDIALOG oDlg TITLE "Tabelas para Exportação" FROM 217,238 TO 600,650 PIXEL

@ 160,004 CheckBox oChkTab Var lChkTab Prompt "Marca/Desmarca Todos" Size 100,010 PIXEL OF oDlg ON CLICK(aEval(aTab, {|x| x[1] := lChkTab}),oLstBoxTab:Refresh())
DEFINE SBUTTON FROM 160,102 TYPE 1 ENABLE ACTION (lOk := .T.,oDlg:End()) OF oDlg
DEFINE SBUTTON FROM 160,134 TYPE 2 ENABLE ACTION (oDlg:End()) OF oDlg

U_fBoxTab()

ACTIVATE MSDIALOG oDlg CENTERED

Return(lOk)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFun‡„o    ³ xExpTabB º Autor ³ Marcelo Amaral     º Data ³  05/02/13   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescri‡„o ³ Exporta as tabelas selecionadas                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Programa principal                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function xExpTabB()
Local nCont := 0
Local nTabExp := 0

ProcRegua(Len(aTabSel))

SET DELETED ON

For nCont := 1 to Len(aTabSel)
	IncProc("Exportando Tabela "+aTabSel[nCont,2]+" --- > "+Alltrim(str(nCont))+" de "+Alltrim(Str(Len(aTabSel))))
	if aTabSel[nCont,1]
		if ChkFile(aTabSel[nCont,2])
			dbSetOrder(0)
			SET FILTER TO
			cNomeArq := "\DATA\"+aTabSel[nCont,2]+Dtos(dDatabase)+Strtran(Time(),":","")+".dtc"
			Copy to &cNomeArq VIA "CTREECDX"
			if !CPYS2T(cNomeArq,Substr(c_dirimp,1,Len(c_dirimp)-1),.T.) 
				Alert("Falha na Exportação da Tabela "+aTabSel[nCont,2]+" para a pasta "+Substr(c_dirimp,1,Len(c_dirimp)-1)+"!")
				alert("Erro: "+str(ferror(),4))
			endif
			nTabExp += 1
		endif
	endif
Next

Alert("Tabelas Exportadas: "+Alltrim(Str(nTabExp)))

Return
