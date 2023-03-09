#INCLUDE "rwmake.ch"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³  Chamados de TI                                                           ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³ Programa   ³ NK_ChamaTI³ Autor ³ Christian Moura        ³ Data ³          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Descri‡…o  ³ Tela de Chamados de TI.                                      ³±±
±±³            ³                                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Parametros ³                                                              ³±±
±±³            ³                                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Obs        ³                                                              ³±±
±±³            ³                                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Retorno    ³                                                              ³±±
±±³            ³                                                              ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function NK_ChamaTI

/*/
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³ Declaracao de Variaveis                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
/*/
Private cCadastro := "Chamados de TI"
Private aRotina   := {	{"Pesquisar" , "AxPesqui"   , 0, 1},;
						{"Visualizar", "AxVisual"   , 0, 2},;
						{"Incluir"   , "AxInclui" , 0, 3},;
						{"Alterar"   , "U_TIAltera" , 0, 4},;
						{"Encerrar"  , "U_TIEncerra", 0, 4},;
						{"Cancelar"  , "U_TICancela", 0, 4},;
						{"Validacao"  , "U_CHAMVALID", 0, 4},;
						{"Legenda"   , "U_TILegenda", 0, 2}  }

Private cDelFunc := ".T."	// Validacao para a exclusao. Pode-se utilizar ExecBlock
Private cAlias   := "Z1A"

aCores := {{"Z1A->Z1A_STATUS == '1'", "BR_VERDE"}, {"Z1A->Z1A_STATUS == '2'", "BR_VERMELHO"}, {"Z1A->Z1A_STATUS == '3'", "BR_AMARELO"}, {"Z1A->Z1A_STATUS == '4'", "BR_AZUL"}, {"Z1A->Z1A_STATUS == '5'", "BR_BRANCO"}}

Z1A->(dbSetOrder(1))

mBrowse(6, 1, 22, 105, cAlias, , , , , 2, aCores)

Return


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³ Programa   ³ TIAltera  ³ Autor ³ Christian Moura        ³ Data ³          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Descri‡…o  ³ Altera o chamado de TI.                                      ³±±
±±³            ³                                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Parametros ³                                                              ³±±
±±³            ³                                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Obs        ³                                                              ³±±
±±³            ³                                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Retorno    ³                                                              ³±±
±±³            ³                                                              ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function TIAltera(cAlias, nReg, nOpc)

// Local _MEMO    := " "
Local aArea    := GetArea()
Local aAreaZ1A := Z1A->(GetArea())

If Z1A->Z1A_STATUS != "1"
	MsgStop("O chamado não está pendente, portanto não é possível alterá-lo!", "Operação Não Permitida")
	Return
EndIf

nOpca := 0
nOpca := AxAltera(cAlias, nReg, nOpc, , , , , ".T.")

RestArea(aAreaZ1A)
RestArea(aArea)

Return


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³ Programa   ³ TICancela ³ Autor ³ Christian Moura        ³ Data ³          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Descri‡…o  ³ Cancela o chamado de TI.                                     ³±±
±±³            ³                                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Parametros ³                                                              ³±±
±±³            ³                                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Obs        ³                                                              ³±±
±±³            ³                                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Retorno    ³                                                              ³±±
±±³            ³                                                              ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function TICancela()

Local lResp

If Z1A->Z1A_STATUS != "1"
	Alert("O chamado não está pendente!")
	Return
EndIf

lResp := MsgYesNo("Confirma Cancelamento do Chamado?", "" )

If lResp
	RecLock("Z1A", .F.)
		Z1A->Z1A_DTENC  := dDataBase
		Z1A->Z1A_HRENC  := SubStr(Time(), 1, 5)                                                                                                              
		Z1A->Z1A_STATUS := "3"	// Cancelado
	MsUnlock()
EndIf

Return


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³ Programa   ³ TIEncerra ³ Autor ³ Christian Moura        ³ Data ³          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Descri‡…o  ³ Encerra o chamado de TI.                                     ³±±
±±³            ³                                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Parametros ³                                                              ³±±
±±³            ³                                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Obs        ³                                                              ³±±
±±³            ³                                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Retorno    ³                                                              ³±±
±±³            ³                                                              ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function TIEncerra()

Local dEncTI  := dDataBase
Local cHoraTI := SubStr(Time(), 1, 5)
Local lResp   := .F.
Local oDlgEnc, oSay1, oGetData, oSay3, oGetHora, oGrp5, oSBtn7, oBtnCancel

If Z1A->Z1A_STATUS != "1"
	Alert("O chamado não está pendente!")
	Return
EndIf

oDlgEnc           := MsDialog():Create()
oDlgEnc:cName     := "oDlgEnc"
oDlgEnc:cCaption  := "Encerramento"
oDlgEnc:nLeft     := 0
oDlgEnc:nTop      := 0
oDlgEnc:nWidth    := 194
oDlgEnc:nHeight   := 176
oDlgEnc:lShowHint := .F.
oDlgEnc:lCentered := .T.

oSay1                 := TSay():Create(oDlgEnc)
oSay1:cName           := "oSay1"
oSay1:cCaption        := "Data:"
oSay1:nLeft           := 26
oSay1:nTop            := 35
oSay1:nWidth          := 37
oSay1:nHeight         := 17
oSay1:lShowHint       := .F.
oSay1:lReadOnly       := .F.
oSay1:Align           := 0
oSay1:lVisibleControl := .T.
oSay1:lWordWrap       := .F.
oSay1:lTransparent    := .F.

oGetData                 := TGet():Create(oDlgEnc)
oGetData:cName           := "oGetData"
oGetData:nLeft           := 64
oGetData:nTop            := 32
oGetData:nWidth          := 80
oGetData:nHeight         := 21
oGetData:lShowHint       := .F.
oGetData:lReadOnly       := .F.
oGetData:Align           := 0
oGetData:cVariable       := "dEncTI"
oGetData:bSetGet         := {|u| If(PCount() > 0, dEncTI := u, dEncTI)}
oGetData:lVisibleControl := .T.
oGetData:lPassword       := .F.
oGetData:Picture         := "@D"
oGetData:lHasButton      := .T.

oSay3                 := TSay():Create(oDlgEnc)
oSay3:cName           := "oSay3"
oSay3:cCaption        := "Hora:"
oSay3:nLeft           := 26
oSay3:nTop            := 65
oSay3:nWidth          := 37
oSay3:nHeight         := 17
oSay3:lShowHint       := .F.
oSay3:lReadOnly       := .F.
oSay3:Align           := 0
oSay3:lVisibleControl := .T.
oSay3:lWordWrap       := .F.
oSay3:lTransparent    := .F.

oGetHora                 := TGet():Create(oDlgEnc)
oGetHora:cName           := "oGetHora"
oGetHora:nLeft           := 64
oGetHora:nTop            := 62
oGetHora:nWidth          := 80
oGetHora:nHeight         := 21
oGetHora:lShowHint       := .F.
oGetHora:lReadOnly       := .F.
oGetHora:Align           := 0
oGetHora:cVariable       := "cHoraTI"
oGetHora:bSetGet         := {|u| If(PCount() > 0, cHoraTI := u, cHoraTI)}
oGetHora:lVisibleControl := .T.
oGetHora:lPassword       := .F.
oGetHora:Picture         := "99:99"
oGetHora:lHasButton      := .F.

oGrp5                 := TGroup():Create(oDlgEnc)
oGrp5:cName           := "oGrp5"
oGrp5:nLeft           := 14
oGrp5:nTop            := 21
oGrp5:nWidth          := 151
oGrp5:nHeight         := 74
oGrp5:lShowHint       := .F.
oGrp5:lReadOnly       := .F.
oGrp5:Align           := 0
oGrp5:lVisibleControl := .T.

oSBtn7                 := SButton():Create(oDlgEnc)
oSBtn7:cName           := "oSBtn7"
oSBtn7:cCaption        := "OK"
oSBtn7:nLeft           := 39
oSBtn7:nTop            := 105
oSBtn7:nWidth          := 55
oSBtn7:nHeight         := 22
oSBtn7:lShowHint       := .F.
oSBtn7:lReadOnly       := .F.
oSBtn7:Align           := 0
oSBtn7:lVisibleControl := .T.
oSBtn7:nType           := 1
oSBtn7:bLClicked       := {|| lResp := .T., oDlgEnc:End()}

oBtnCancel                 := SButton():Create(oDlgEnc)
oBtnCancel:cName           := "oBtnCancel"
oBtnCancel:cCaption        := "Cancelar"
oBtnCancel:nLeft           := 110
oBtnCancel:nTop            := 105
oBtnCancel:nWidth          := 55
oBtnCancel:nHeight         := 22
oBtnCancel:lShowHint       := .F.
oBtnCancel:lReadOnly       := .F.
oBtnCancel:Align           := 0
oBtnCancel:lVisibleControl := .T.
oBtnCancel:nType           := 2
oBtnCancel:bLClicked       := {|| oDlgEnc:End()}

oDlgEnc:Activate()

If lResp
	RecLock("Z1A", .F.)
		Z1A->Z1A_DTENC  := dEncTI
		Z1A->Z1A_HRENC  := cHoraTI                                                                                                        
		Z1A->Z1A_STATUS := "2"	// Encerrado
	MsUnlock()
EndIf

Return

#include "Rwmake.ch"        
#include "Msole.CH"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CHAMVALID     º Autor ³ Christian Moura        ³ Data ³     ³±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Geração de documento Word para Impressão de Chamados do    º±±
±±º          ³ FILDSERVICE                                                º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CHAMVALID                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

************************************************************
User Function CHAMVALID(cCham)
************************************************************        
Local cChamado:=cCham
Local aArea:=GetArea()
SetPrvt("CCADASTRO,ASAYS,ABUTTONS,NOPCA,CTYPE,CARQUIVO")
SetPrvt("NVEZ,OWORD,CINICIO,CFIM,CFIL,CXINSTRU,CXLOCAL")

If Z1A->Z1A_STATUS=='2'
	Processa({|| WORDIMP(cChamado)})  // Chamada do Processamento// Substituido pelo assistente de conversao do AP5 IDE em 14/02/00 ==> 	Processa({|| Execute(WORDIMP)})  // Chamada do Processamento
Else
 Alert("Chamado não Encerrado")
EndIf	
RestArea(aArea)

Return

**********************************************************************
Static FUNCTION WORDIMP(cChamado)
**********************************************************************
// Local cGrava   := 'M:\RDMakes\configurador'
// Local cItens   := ""
// Local cItens2   := ""
// Local cNomCli 
// Local cCNPJ   

cArquivo := 'M:\RDMakes\configurador\Modelo Chamado.dot' 


// Inicia o Word 
nVez := 1

// Inicializa o Ole com o MS-Word 97 ( 8.0 )	
oWord := OLE_CreateLink('TMsOleWord97')		

OLE_NewFile(oWord,cArquivo)
OLE_SetProperty( oWord, oleWdVisible,   .F. )
OLE_SetProperty( oWord, oleWdPrintBack, .T. ) 

DbSelectArea("Z1A")
DbSetOrder(1)
While !Eof() .AND. SubStr(cChamado,1,Len(Z1A->Z1A_NUM))==Z1A->Z1A_NUM
	If Z1A->Z1A_STATUS='2'
         cChamado:= Z1A->Z1A_NUM
	EndIf
	DbSkip()
EndDo 
//Cabeçalho do Documento de Aceite
OLE_SetDocumentVar(oWord,"cDia"   ,SubStr(DtoS(dDataBase),7,2))
OLE_SetDocumentVar(oWord,"cMes"   ,MesExtenso(SubStr(DtoS(dDataBase),5,2)))
OLE_SetDocumentVar(oWord,"cAno"   ,SubStr(DtoS(dDataBase),1,4))
//Corpo do Documento de Aceite
OLE_SetDocumentVar(oWord,"cChamado"   ,Z1A->Z1A_NUM)
OLE_SetDocumentVar(oWord,"cDescCli"   ,Capital(Z1A->Z1A_USUARIO))
OLE_SetDocumentVar(oWord,"cAreaCli"   ,Capital(Z1A->Z1A_AREA))
//OLE_SetDocumentVar(oWord,"cDesc"   ,Capital(ABK->ABK_CODPRB+" - "+Posicione("AAG",1,xFilial("AAG")+ABK->ABK_CODPRB,"AAG_DESCRI")))
OLE_SetDocumentVar(oWord,"cMemo"   ,Z1A->Z1A_OBS)
OLE_SetDocumentVar(oWord,"cItens"   ,Z1A->Z1A_DESCRI)
OLE_SetDocumentVar(oWord,"cItens2"   ,Capital((Dtoc(Z1A->Z1A_DTSOLIC)+Space(8))+"| "+TRANSFORM(Z1A->Z1A_HRSOLIC,"@99:99")+" "+Space(12)+"| "+(Dtoc(Z1A->Z1A_DTENC)+Space(10))+"| "+TRANSFORM(Z1A->Z1A_HRENC,"@99:99")+Space(8)))
OLE_SetDocumentVar(oWord,"cTecnico"   ,Capital(Z1A->Z1A_IDENTIF))                                                                                     
/*OLE_SetDocumentVar(oWord,"dEmissao" ,dEmissao)
OLE_SetDocumentVar(oWord,"cCodCli"  ,cCodCli)
// // OLE_SetDocumentVar(oWord,"cNomCli"  ,cNomCli)
OLE_SetDocumentVar(oWord,"cnpj"     ,cCNPJ)
OLE_SetDocumentVar(oWord,"cMun"     ,cMun)
OLE_SetDocumentVar(oWord,"cEst"     ,cEst)

//Itens da NF
cItens := ""
For I:=1 to Len(aItens) 	 
	cItens += aItens[I,1,1]+ Space(16 - Len(aItens[I,1,1])) //cODIGO DO PRODUTO
	cItens += aItens[I,1,2]+ Space(39 - Len(aItens[I,1,2])) //DECRICAO DO PRODUTO
	cItens += aItens[I,1,3]+ Space(2)
	cItens += aItens[I,1,4]+ Space(9 -  Len(aItens[I,1,4]))
	cItens += aItens[I,1,5]+ Space(12 - Len(aItens[I,1,5]))
	cItens += aItens[I,1,6]+ Space(12 - Len(aItens[I,1,6]))
	cItens += Space(80)+CHR(13)
Next

OLE_SetDocumentVar(oWord,"cItens"     ,cItens) 
  */
//--Atualiza Variaveis
OLE_UpDateFields(oWord)
Ole_PrintFile(oWord,"ALL",,,1)
//-- Imprime as variaveis				
//OLE_SaveAsFile( oWord, cGrava+"Chamado -" + cChamado + ".doc" )
                         
WaitPrt(10)
OLE_CloseFile( oWord )
OLE_CloseLink( oWord ) 			// Fecha o Documento
               

Return
//Waint para carragar Spool do Word
Static Function WaitPRT(nTime)
Local oDlgPrt,oTimer
	DEFINE MSDIALOG oDlgPrt FROM 0,0 TO 50,100 TITLE "Imprimindo!" PIXEL
		oTimer := TTimer():New( nTime * 1000, {|| oDlgPrt:END() }, oDlgPrt )
		@1,1  SAY "Aguarde..."
		oTimer:lActive   := .T.
	ACTIVATE MSDIALOG oDlgPrt CENTERED
Return                             

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³ Programa   ³ TILegenda ³ Autor ³ Christian Moura        ³ Data ³          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Descri‡…o  ³ Exibe as legendas do browse.                                 ³±±
±±³            ³                                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Parametros ³                                                              ³±±
±±³            ³                                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Obs        ³                                                              ³±±
±±³            ³                                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Retorno    ³                                                              ³±±
±±³            ³                                                              ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function TILegenda()

BrwLegenda(cCadastro, "Legenda", {	{"BR_VERDE"   , "Chamado Pendente"                    },;
									{"BR_VERMELHO", "Chamado Encerrado"                   },;
									{"BR_AZUL"    , "Chamado aberto no HelpDesk Microsiga"},;
									{"BR_BRANCO"  , "Chamado com BOPS vinculado"          },;
									{"BR_AMARELO" , "Chamado Cancelado"}  })

Return
