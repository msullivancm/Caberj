#include "protheus.ch"
#include "rwmake.ch"
#include "topconn.ch"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ PLBOWBTADD ºAutor ³ Fred O. C. Jr     º Data ³  08/06/22   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³  Manipular menu do protocolo de reembolso                  º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function PLBOWBTADD

Local aArea    := GetArea()
Local aRet     := {}
Local cSuperv  := SuperGetMv("MV_XSUPEEM", .F., "001727")
Local nPos     := 0

// retirar opções de incluir e excluir protocolos
nPos  := aScan(aRotina,{|x| x[1] == 'Incluir'})
if nPos > 0
	aRotina[nPos,2] := 'U_CBPRTR01(1)'
endif

nPos  := aScan(aRotina,{|x| x[1] == 'Excluir'})
if nPos > 0
	aRotina[nPos,2] := 'U_CBPRTR01(2)'
endif

// supervisores não tem filtro aplicado direto no browse
if (RetCodUsr() $ AllTrim(cSuperv))
   aAdd(aRet, {"Designar Resp.", 'U_CBPRTR02', 0, 0 } )
endif

aAdd(aRet, {"Visual. Aut. Reemb.", 'U_CBPRTR05()'  , 0, 0 } )
aAdd(aRet, {"Cancelar"           , 'U_CanProtR(2)' , 0, 0 } )
//aAdd(aRet, {"Conhecimento"     , "MSDOCUMENT" 	, 0, 4 } )
aAdd(aRet, {"Conhecimento"       , "U_CBPRTR06()" 	, 0, 4 } )

RestArea(aArea)

return aRet



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ CBPRTR01 ºAutor ³ Fred O. C. Jr       º Data ³  08/06/22   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³  Desabilitar inclusão e exclusao do menu                   º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function CBPRTR01( nOp )

MsgInfo("A " + iif(nOp == 1, "inclusão", "exclusão") + " do reembolso deve ser feito pela rotina de Protocolo de Reembolso!" )

return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ CBPRTR02 ºAutor ³ Fred O. C. Jr       º Data ³  08/06/22   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³  Abrir tela para permitir atribuir analista responsável    º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function CBPRTR02

Local oDlgRet
Local oAnalis
Local cNomAna     := UsrRetName(BOW->BOW_XRESPO)
Local cOldAna		:= ""
Local nOpcRet		:= 0

Local oSay
Local oFont			:= TFont():New('Arial', 10,, .T.)

Private cAnalis	:= BOW->BOW_XRESPO

// 1=Protocolado;2=Em analise;3=Deferido;4=Indeferido;5=Em digitação;6=Lib. financeiro;7=Não lib. financeiro;8=Glosado;9=Auditoria
if BOW->BOW_STATUS $ '1|2|3|4'

   DEFINE MSDIALOG oDlgRet TITLE "Alteração de responsável:" FROM 000,000 TO 105,350 PIXEL

      oSay := tSay():New(008,020,{||'Analista:'}	,oDlgRet,,oFont,,,,.T.,CLR_HBLUE,,,)
      @ 008,070 MSGET oAnalis			VAR cAnalis    VALID VldCbPr02(cAnalis, @cNomAna)			F3 "USUREE"		SIZE 050,008	PIXEL OF oDlgRet
      oSay := tSay():New(022,070,{|| cNomAna}      ,oDlgRet,,oFont,,,,.T.,CLR_HRED,,,)

      @ 035,030 Button "OK"				 		Size 050,012		PIXEL OF oDlgRet 	Action (nOpcRet := 1, oDlgRet:End())
      @ 035,090 Button "CANCELAR"			 	Size 050,012		PIXEL OF oDlgRet 	Action (oDlgRet:End())

	ACTIVATE MSDIALOG oDlgRet CENTERED

	if nOpcRet == 1

		if !empty(cAnalis)

         cOldAna	:= AllTrim(BOW->BOW_XRESPO)

         if AllTrim(cAnalis) <> AllTrim(cOldAna)

            Reclock("BOW",.F.)
               BOW->BOW_XRESPO	:= cAnalis
            BOW->(MsUnlock())

            MsgInfo("Protocolo de reembolso atribuído com sucesso!")

         else
            MsgInfo("O novo responsável é o mesmo já direcionado!")
         endif

		endif

	endif

else
   MsgInfo("Status não permite informar/alterar analista responsável!")
endif

return


// Validar analista selecionado
Static Function VldCbPr02(cAnalis, cNomAna)

Local lRet     := .T.

cNomAna  := UsrRetName(cAnalis)

if empty(cNomAna)
   MsgInfo("Analista não localizado!")
   lRet  := .F.
endif

return lRet





/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ CBPRTR03 º Autor ³ Frederico O. C. Jr º Data ³  29/09/17   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³   Consulta de analistas de reembolso                       º±±
±±º          ³  					                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function CBPRTR03()

Local cTitulo	:= "Analistas de Reembolso"
Local oOk		:= LoadBitmap( GetResources(), "LBOK" )		//carrega bitmap quadrado com X
Local oNo		:= LoadBitmap( GetResources(), "LBNO" )		//carrega bitmap soh o quadrado
Local cAux		:= Space(6)
Local aUsuari  := StrTokArr2( SuperGetMv("MV_XANAREE", .F., "001727"), "|" )
Local i        := 0

Private lChk	:= .F.
Private oLbx	:= Nil
Private aVetor	:= {}
Private oDlg

cAnalis	:= space(6)

for i := 1 to len(aUsuari)
	aAdd( aVetor, { .F., AllTrim(aUsuari[i]), AllTrim( UsrRetName(AllTrim(aUsuari[i])) ) })
next

if len(aVetor) > 0

   aVetor	:= aSort(aVetor,,, {|x,y| x[3] < y[3]} )

   DEFINE MSDIALOG oDlg TITLE cTitulo FROM 0,0 TO 240,500 PIXEL

      //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
      //³ Se houver duplo clique, recebe ele mesmo negando, depois da um refresh³
      //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
      @ 10,10 LISTBOX oLbx VAR cVar FIELDS HEADER " ", "Codigo","Descriçao";
      SIZE 230,095 OF oDlg PIXEL ON dblClick(aVetor[oLbx:nAt,1] := !aVetor[oLbx:nAt,1], oLbx:Refresh())
      oLbx:SetArray( aVetor )
      oLbx:bLine := {|| {Iif(aVetor[oLbx:nAt,1],oOk,oNo),	aVetor[oLbx:nAt,2],	aVetor[oLbx:nAt,3] }}
      
      DEFINE SBUTTON FROM 107,213 TYPE 1 ACTION (cAux := CBPRTR04()) ENABLE OF oDlg

   ACTIVATE MSDIALOG oDlg CENTER

else
   MsgInfo("Sem analista de reembolso parametrizado")
endif

cAnalis := cAux

return .T.


Static Function CBPRTR04()

Local _i       := 0
Local cRet     := space(6)
Local nCont    := 0

for _i := 1 to len(aVetor)
   if aVetor[_i, 1]
      nCont++
      cRet := aVetor[_i, 2]
   endif
next

if nCont > 1
   cRet     := space(6)
   MsgInfo("Permitido informar somente um analista responsável por protocolo!")
else
   oDlg:End()
endif

return cRet


// Mostrar cálculo do protocolo de reembolso
User Function CBPRTR05()

Local aArea       := GetArea()
Local aAreaB44    := B44->(GetArea())

B44->(DbSetOrder(4))    // B44_FILIAL+B44_PROTOC
if B44->(DbSeek( xFilial("B44") + BOW->BOW_PROTOC ))

   PL001MOV("B44", B44->(RECNO()), 2)

else
   MsgInfo("Protocolo sem Autorização de Reembolso calculada!")
endif

restArea(aAreaB44)
restArea(aArea)

return



// Mostrar banco de conhecimento
User Function CBPRTR06()

ZZQ->(DbSetOrder(1))
if ZZQ->(DbSeek( xFilial("ZZQ") + BOW->BOW_YCDPTC ))

   MsDocument("ZZQ", ZZQ->(recno()), 3)

endif

return
