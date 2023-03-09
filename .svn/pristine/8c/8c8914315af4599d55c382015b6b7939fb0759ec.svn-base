#include 'rwmake.ch'
#Include "Protheus.ch"
#include "PLSMGER.CH"
#Include "Topconn.ch"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ CABA253  º Autor ³ Marcos Cantalice   º Data ³  26/12/22   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Tela de Manutenção do Prazo de Entrega RDA                 º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP7                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function CABA253()

Local aArea		:= GetArea()
Local cCodUsr 	:= RetCodUsr()
Local cPrent    := ""
Local _cAlt	    := SuperGetMv('MV_XPRENT')

DbSelectArea("ZA7") 
	
	If !(cCodUsr $ _cAlt )		
        MsgStop("Você não tem permissão para alterar o campo de Prazo de Entrega", "Acesso negado")
    elseif !EMPTY(cPrent := Prazo_Entrega())
        RecLock("ZA7", .T.)
            ZA7->ZA7_FILIAL := xFilial("ZA7")
            ZA7->ZA7_CODRDA := BAU->BAU_CODIGO
            ZA7->ZA7_DIAANT := BAU->BAU_XPRENT
            ZA7->ZA7_DIAATU := cPrent
            ZA7->ZA7_NOMUSR := UsrRetName(RetCodUsr())
            ZA7->ZA7_DATA   := Date()
            ZA7->ZA7_HORA   := time()
        MsUnlock()

        RecLock("BAU", .F.)
            BAU->BAU_XPRENT := cPrent
        MsUnlock()
    Endif


RestArea(aArea)

return

Static Function Prazo_Entrega()

Local oButton2
Local cGet1 := SPACE(3)
Local OK
Local oSay1
Static oDlg

DEFINE MSDIALOG oDlg TITLE "Prazo de Entrega" FROM 000, 000  TO 150, 190 COLORS 0, 16777215 PIXEL

    @ 017, 010 SAY oSay1 PROMPT "Informe o novo prazo de entrega:" SIZE 100, 009 OF oDlg COLORS 0, 16777215 PIXEL
    @ 032, 010 MSGET cGet1 SIZE 80, 012 OF oDlg COLORS 0, 16777215 PIXEL 
    @ 055, 053 BUTTON OK PROMPT "OK" SIZE 037, 012 OF oDlg  ACTION IIF(EMPTY(cGet1), MsgStop("Favor informe o novo prazo de entrega", "Campo Obrigatório"),oDlg:End()) PIXEL
    @ 055, 010 BUTTON oButton2 PROMPT "Cancelar" SIZE 037, 012 OF oDlg ACTION oDlg:End() PIXEL

  ACTIVATE MSDIALOG oDlg CENTERED

Return cGet1

USER FUNCTION CABA253B()

Local aCabZA7  := {}
Local aDadZA7 := {}                                          
Local aTrbZA7 := {}
Local nOpca   := 1
Local oBrwZA7   
Local oDlg

ZA7->(DbSetOrder(1)) //ZA7_FILIAL+ZA7_CODRDA
If  ZA7->(MsSeek(xFilial("ZA7")+BAU->(BAU_CODIGO)))
	DEFINE MSDIALOG oDlg TITLE 'Historico Alteracao Prazo de Entrega' FROM 009,010 TO 029,110 OF GetWndDefault()
       Store Header "ZA7" TO aCabZA7 For .T. 
       Store COLS 	"ZA7" TO aDadZA7 From aCabZA7 VETTRAB aTrbZA7 While xFilial("ZA7")+ZA7->(ZA7_CODRDA) == xFilial("BAU")+BAU->(BAU_CODIGO)
       oBrwZA7  := TPLSBrw():New(030 ,001 ,395 ,150 ,nil ,oDlg ,nil ,{|| nil } ,nil ,nil  ,nil , .T., nil, .T. , nil ,aCabZA7 ,aDadZA7 ,.F. ,"ZA7" ,K_Visualizar,"Historico Alteracao Prazo de Entrega",nil,nil,nil,aTrbZA7,,,) 
	ACTIVATE MSDIALOG oDlg ON INIT EnchoiceBar( oDlg, {|| nOpca := 1,oDlg:End()}, {|| nOpca := 2,oDlg:End()} )
Else
    MsgStop("Não existe historico de alteração para essa RDA", "Acesso Negado")
Endif
	
Return  
