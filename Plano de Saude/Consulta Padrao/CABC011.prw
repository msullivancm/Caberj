#INCLUDE "RWMAKE.CH"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "TOPCONN.CH"
#INCLUDE "FONT.CH"
#INCLUDE "TBICONN.CH"

#DEFINE c_ent CHR(13) + CHR(10)

User Function CABC011()

Local cTitulo	:= "Subespecialidade"
Local oOk		:= LoadBitmap( GetResources(), "LBOK" )
Local oNo		:= LoadBitmap( GetResources(), "LBNO" )
//Local oChk		:= Nil
//Local cAlias	:= GetNextAlias()

Private lChk	:= .F.
Private oLbx	:= Nil
Private aVetor	:= {}
Private oDlg

Public cSub		:= space(150)

BFN->(DbSetOrder(1))	// BFN_FILIAL+BFN_CODINT+BFN_CODESP+BFN_CODSUB
if BFN->(DbSeek( xFilial("BFN") + PlsIntPad() + M->BAX_CODESP ))

	while BFN->(!EOF()) .and. BFN->BFN_CODESP == M->BAX_CODESP

		aAdd( aVetor, { .F., BFN->BFN_CODSUB, AllTrim(BFN->BFN_DESCRI) })

		BFN->(DbSkip())
	end

endif

IF !LEN(aVetor) > 0
    MsgAlert("Não existem Subespecialidades para esse tipo de Especialidade")
    else

        DEFINE MSDIALOG oDlg TITLE cTitulo FROM 0,0 TO 240,500 PIXEL

        //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
        //³ Se houver duplo clique, recebe ele mesmo negando, depois da um refresh³
        //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
        @ 10,10 LISTBOX oLbx VAR cVar FIELDS HEADER " ", "Codigo","Descriçao";
        SIZE 230,095 OF oDlg PIXEL ON dblClick(aVetor[oLbx:nAt,1] := !aVetor[oLbx:nAt,1], oLbx:Refresh())
        oLbx:SetArray( aVetor )
        oLbx:bLine := {|| {Iif(aVetor[oLbx:nAt,1],oOk,oNo),	aVetor[oLbx:nAt,2],	aVetor[oLbx:nAt,3] }}

        DEFINE SBUTTON FROM 107,213 TYPE 1 ACTION (cSub := CABC011A()) ENABLE OF oDlg

        ACTIVATE MSDIALOG oDlg CENTER
endif

Return(.T.)



Static Function CABC011A()

Local _i		:= 0
Local cRet		:= ""

for _i := 1 to len(aVetor)
	if aVetor[_i, 1]
		cRet += aVetor[_i, 2] + ","
	endif
next

cRet := iif(SubStr(cRet,len(cRet),1) == ",", SubStr(cRet,1,len(cRet)-1), cRet)
cRet := AllTrim(cRet) + Space(150-len(cRet))

oDlg:End()

return cRet
Return lRet
