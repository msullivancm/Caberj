#include 'rwmake.ch'
#Include "Protheus.ch"
#include "PLSMGER.CH"
#Include "Topconn.ch"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ CABA238  º Autor ³ Frederico O. C. Jr º Data ³  29/11/22   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Cadastro de aprovador de contrato		                  º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP7                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
//------------------------------------------------------//
// Aprovação do comercial                               //
//------------------------------------------------------//
User Function CABA238A()

Local aArea		:= GetArea()
Private	cMsg	:= "Cadastro de Aprovador de SubContrato (Comercial)"
Private cAlias	:= "ZA3"

DbSelectArea(cAlias)
DbSetOrder(1)

AxCadastro(cAlias, cMsg, ".F.", ".T.")

RestArea(aArea)

return


//------------------------------------------------------//
// Aprovação do cadastro                                //
//------------------------------------------------------//
User Function CABA238B()

Local aArea		:= GetArea()
Private	cMsg	:= "Cadastro de Aprovador de SubContrato (Cadastro)"
Private cAlias	:= "ZA3"

DbSelectArea(cAlias)
DbSetOrder(1)

AxCadastro(cAlias, cMsg, ".F.", ".T.")

RestArea(aArea)

return

//------------------------------------------------------//
// Rotina de aprovação do subcontrato                   //
//------------------------------------------------------//
User Function CABA238C()

Local cIdAprov		:= RetCodUsr()
LOCAL cMsg          := ""
Local cSetor        := ""
Local cNivelAprov        := ""
Local aAprov        := {}
Local cAssunto := ""
Local cCorpoEmail := ""

if BQC->BQC_XAPROV == '0' .OR. BQC->BQC_XAPROV == '5'   // pendente aprovação (ver nivel 1 - comercial) ou Reprovado

    cSetor        := "1"    //Comercial
    cNivelAprov        := "1"    //Operacional
    aAprov := BuscaAprov(cSetor, cNivelAprov)	

    if aAprov[1]

        IF BQC->BQC_XAPROV == '0' 
            cMsg := "Confirma a aprovação do subcontrato (comercial - operacional)?"
        ELSEIF BQC->BQC_XAPROV == '5'
            cMsg := "Este subcontrato encontra-se REPROVADO. Confirma a aprovação do subcontrato (comercial - operacional)?"
        ENDIF

        if MsgYesNo(cMsg)
            Begin Transaction
                RecLock("BQC", .F.)
                    BQC->BQC_XAPROV	:= "1"
                MsUnlock()

                RecLock("ZA4", .T.)
                    ZA4->ZA4_FILIAL := xFilial("ZA4")
                    ZA4->ZA4_CODINT := SubStr(BQC->BQC_CODIGO,1,4)
                    ZA4->ZA4_CODEMP := SubStr(BQC->BQC_CODIGO,5,4)
                    ZA4->ZA4_NUMCON := BQC->BQC_NUMCON
                    ZA4->ZA4_VERCON := BQC->BQC_VERCON
                    ZA4->ZA4_SUBCON := BQC->BQC_SUBCON
                    ZA4->ZA4_VERSUB := BQC->BQC_VERSUB
                    ZA4->ZA4_SETOR  := cSetor
                    ZA4->ZA4_NIVEL  := cNivelAprov
                    ZA4->ZA4_CODOPE := cIdAprov
                    ZA4->ZA4_NOMOPE := aAprov[2]
                    ZA4->ZA4_ACAO   := "1"
                    ZA4->ZA4_DATA   := Date()
                    ZA4->ZA4_HORA   := time()
                MsUnlock()

            End Transaction

            cAssunto := "APROVAÇÃO DE SUBCONTRATO"
            cCorpoEmail := "Prezado(a)," +"<br>"+"O sub-contrato foi aprovado pelo setor comercial a nivel operacional, favor analisar o mesmo."
            cCorpoEmail += "<br><strong>Razão Social: </strong>"+BQC->BQC_DESCRI
            cCorpoEmail += "<br><strong>CNPJ: </strong>"+BQC->BQC_CNPJ
            cCorpoEmail += "<br><strong>Data do Sub-contrato: </strong>"+SUBSTR(DTOS(BQC->BQC_DATCON),7,2)+"/"+SUBSTR(DTOS(BQC->BQC_DATCON),5,2)+"/"+SUBSTR(DTOS(BQC->BQC_DATCON),1,4)
            
            ZA3->(DBSetOrder(1))
            IF ZA3->(DBSeek(xFilial("ZA3")+"1"+"2")) //ZA3_FILIAL+ZA3_SETOR+ZA3_NIVEL+ZA3_CODAPR
                WHILE !ZA3->(EOF()) .And. ZA3->ZA3_FILIAL+ZA3->ZA3_SETOR+ZA3->ZA3_NIVEL == xFilial("ZA3")+"1"+"2"
                    IF EMPTY(ZA3->ZA3_VIGFIM)
                        U_CABEMAIL(ZA3->ZA3_EMAIL, , , cAssunto, cCorpoEmail)
                    ELSEIF ZA3->ZA3_VIGFIM >= DATE()
                        U_CABEMAIL(ZA3->ZA3_EMAIL, , , cAssunto, cCorpoEmail)
                    ENDIF
                    ZA3->(DBSkip())
                END          
            ENDIF

            MsgInfo("Aprovado com sucesso!")
            oDlgFolder:End()
        endif
    
    else
        MsgStop("Sem permissão para aprovação do subcontrato (comercial - operacional)!", "Aprovação não permitida")
    endif

elseif BQC->BQC_XAPROV == '1'   // aprovado comercial - operacional

    cSetor        := "1"    //Comercial
    cNivelAprov        := "2"    //Gestao
    aAprov := BuscaAprov(cSetor, cNivelAprov)	

    if aAprov[1]    

        if MsgYesNo("Confirma a aprovação do subcontrato (nível comercial - gestao)?")

            Begin Transaction

                RecLock("BQC", .F.)
                    BQC->BQC_XAPROV	:= "2"
                MsUnlock()

                RecLock("ZA4", .T.)
                    ZA4->ZA4_FILIAL := xFilial("ZA4")
                    ZA4->ZA4_CODINT := SubStr(BQC->BQC_CODIGO,1,4)
                    ZA4->ZA4_CODEMP := SubStr(BQC->BQC_CODIGO,5,4)
                    ZA4->ZA4_NUMCON := BQC->BQC_NUMCON
                    ZA4->ZA4_VERCON := BQC->BQC_VERCON
                    ZA4->ZA4_SUBCON := BQC->BQC_SUBCON
                    ZA4->ZA4_VERSUB := BQC->BQC_VERSUB
                    ZA4->ZA4_SETOR  := cSetor
                    ZA4->ZA4_NIVEL  := cNivelAprov
                    ZA4->ZA4_CODOPE := cIdAprov
                    ZA4->ZA4_NOMOPE := aAprov[2]
                    ZA4->ZA4_ACAO   := "1"
                    ZA4->ZA4_DATA   := Date()
                    ZA4->ZA4_HORA   := time()
                MsUnlock()

            End Transaction

            cAssunto := "APROVAÇÃO DE SUBCONTRATO"
            cCorpoEmail := "Prezado(a)," +"<br>"+"O setor comercial aprovou um sub-contrato."
            cCorpoEmail += "<br><strong>Razão Social: </strong>"+BQC->BQC_DESCRI
            cCorpoEmail += "<br><strong>CNPJ: </strong>"+BQC->BQC_CNPJ
            cCorpoEmail += "<br><strong>Data do Sub-contrato: </strong>"+SUBSTR(DTOS(BQC->BQC_DATCON),7,2)+"/"+SUBSTR(DTOS(BQC->BQC_DATCON),5,2)+"/"+SUBSTR(DTOS(BQC->BQC_DATCON),1,4)

            ZA3->(DBSetOrder(1))
            IF ZA3->(DBSeek(xFilial("ZA3")+"2"+"1")) //ZA3_FILIAL+ZA3_SETOR+ZA3_NIVEL+ZA3_CODAPR
                WHILE !ZA3->(EOF()) .And. ZA3->ZA3_FILIAL+ZA3->ZA3_SETOR+ZA3->ZA3_NIVEL == xFilial("ZA3")+"2"+"1"
                    IF EMPTY(ZA3->ZA3_VIGFIM)
                        U_CABEMAIL(ZA3->ZA3_EMAIL, , , cAssunto, cCorpoEmail)
                    ELSEIF ZA3->ZA3_VIGFIM >= DATE()
                        U_CABEMAIL(ZA3->ZA3_EMAIL, , , cAssunto, cCorpoEmail)
                    ENDIF
                    ZA3->(DBSkip())
                END          
            ENDIF

            MsgInfo("Aprovado com sucesso!")
            oDlgFolder:End()

        endif
    
    else
        MsgStop("Sem permissão para aprovação do subcontrato (nível comercial)!", "Aprovação não permitida")
    endif

elseif BQC->BQC_XAPROV == '2'   // aprovado por comercial - operacional e gestao

    cSetor        := "2"    //Cadastro
    cNivelAprov        := "1"    //Operacional
    aAprov := BuscaAprov(cSetor, cNivelAprov)	

    if aAprov[1]    

        if MsgYesNo("Confirma a aprovação do subcontrato (nível cadastro - operacional)?")

            Begin Transaction

                RecLock("BQC", .F.)
                    BQC->BQC_XAPROV	:= "3"
                MsUnlock()

                RecLock("ZA4", .T.)
                    ZA4->ZA4_FILIAL := xFilial("ZA4")
                    ZA4->ZA4_CODINT := SubStr(BQC->BQC_CODIGO,1,4)
                    ZA4->ZA4_CODEMP := SubStr(BQC->BQC_CODIGO,5,4)
                    ZA4->ZA4_NUMCON := BQC->BQC_NUMCON
                    ZA4->ZA4_VERCON := BQC->BQC_VERCON
                    ZA4->ZA4_SUBCON := BQC->BQC_SUBCON
                    ZA4->ZA4_VERSUB := BQC->BQC_VERSUB
                    ZA4->ZA4_SETOR  := cSetor
                    ZA4->ZA4_NIVEL  := cNivelAprov
                    ZA4->ZA4_CODOPE := cIdAprov
                    ZA4->ZA4_NOMOPE := aAprov[2]
                    ZA4->ZA4_ACAO   := "1"
                    ZA4->ZA4_DATA   := Date()
                    ZA4->ZA4_HORA   := time()
                MsUnlock()

            End Transaction

            cAssunto := "APROVAÇÃO DE SUBCONTRATO"
            cCorpoEmail := "Prezado(a)," +"<br>"+"O sub-contrato foi aprovado pelo setor cadastro a nivel operacional, favor analisar o mesmo."
            cCorpoEmail += "<br><strong>Razão Social: </strong>"+BQC->BQC_DESCRI
            cCorpoEmail += "<br><strong>CNPJ: </strong>"+BQC->BQC_CNPJ
            cCorpoEmail += "<br><strong>Data do Sub-contrato: </strong>"+SUBSTR(DTOS(BQC->BQC_DATCON),7,2)+"/"+SUBSTR(DTOS(BQC->BQC_DATCON),5,2)+"/"+SUBSTR(DTOS(BQC->BQC_DATCON),1,4)

            ZA3->(DBSetOrder(1))
            IF ZA3->(DBSeek(xFilial("ZA3")+"2"+"2")) //ZA3_FILIAL+ZA3_SETOR+ZA3_NIVEL+ZA3_CODAPR
                WHILE !ZA3->(EOF()) .And. ZA3->ZA3_FILIAL+ZA3->ZA3_SETOR+ZA3->ZA3_NIVEL == xFilial("ZA3")+"2"+"2"
                    IF EMPTY(ZA3->ZA3_VIGFIM)
                        U_CABEMAIL(ZA3->ZA3_EMAIL, , , cAssunto, cCorpoEmail)
                    ELSEIF ZA3->ZA3_VIGFIM >= DATE()
                        U_CABEMAIL(ZA3->ZA3_EMAIL, , , cAssunto, cCorpoEmail)
                    ENDIF
                    ZA3->(DBSkip())
                END          
            ENDIF

            MsgInfo("Aprovado com sucesso!")
            oDlgFolder:End()

        endif
    
    else
        MsgStop("Sem permissão para aprovação do subcontrato (nível cadastro)!", "Aprovação não permitida")
    endif

elseif BQC->BQC_XAPROV == '3'   // aprovado por cadastro - operacional

    cSetor        := "2"    //Cadastro
    cNivelAprov        := "2"    //Operacional
    aAprov := BuscaAprov(cSetor, cNivelAprov)	

    if aAprov[1]    

        if MsgYesNo("Confirma a aprovação do subcontrato (nível cadastro - gestao)?")

            Begin Transaction

                RecLock("BQC", .F.)
                    BQC->BQC_XAPROV	:= "4"
                MsUnlock()

                RecLock("ZA4", .T.)
                    ZA4->ZA4_FILIAL := xFilial("ZA4")
                    ZA4->ZA4_CODINT := SubStr(BQC->BQC_CODIGO,1,4)
                    ZA4->ZA4_CODEMP := SubStr(BQC->BQC_CODIGO,5,4)
                    ZA4->ZA4_NUMCON := BQC->BQC_NUMCON
                    ZA4->ZA4_VERCON := BQC->BQC_VERCON
                    ZA4->ZA4_SUBCON := BQC->BQC_SUBCON
                    ZA4->ZA4_VERSUB := BQC->BQC_VERSUB
                    ZA4->ZA4_SETOR  := cSetor
                    ZA4->ZA4_NIVEL  := cNivelAprov
                    ZA4->ZA4_CODOPE := cIdAprov
                    ZA4->ZA4_NOMOPE := aAprov[2]
                    ZA4->ZA4_ACAO   := "1"
                    ZA4->ZA4_DATA   := Date()
                    ZA4->ZA4_HORA   := time()
                MsUnlock()

            End Transaction

            cAssunto := "APROVAÇÃO DE SUBCONTRATO"
            cCorpoEmail := "Prezado(a)," +"<br>"+"O sub-contrato foi aprovado em todos os níveis de aprovação."
            cCorpoEmail += "<br><strong>Razão Social: </strong>"+BQC->BQC_DESCRI
            cCorpoEmail += "<br><strong>CNPJ: </strong>"+BQC->BQC_CNPJ
            cCorpoEmail += "<br><strong>Data do Sub-contrato: </strong>"+SUBSTR(DTOS(BQC->BQC_DATCON),7,2)+"/"+SUBSTR(DTOS(BQC->BQC_DATCON),5,2)+"/"+SUBSTR(DTOS(BQC->BQC_DATCON),1,4)

            // ZA3->(DBSetOrder(1))
            // IF ZA3->(DBSeek(xFilial("ZA3")+"2"+"2")) //ZA3_FILIAL+ZA3_SETOR+ZA3_NIVEL+ZA3_CODAPR
            //     WHILE !ZA3->(EOF()) .And. ZA3->ZA3_FILIAL+ZA3->ZA3_SETOR+ZA3->ZA3_NIVEL == xFilial("ZA3")+"2"+"2"
            //         IF EMPTY(ZA3->ZA3_VIGFIM)
                        U_CABEMAIL("oliveiramarcos55@hotmail.com", , , cAssunto, cCorpoEmail)
            //         ELSEIF ZA3->ZA3_VIGFIM >= DATE()
            //             U_CABEMAIL(ZA3->ZA3_EMAIL, , , cAssunto, cCorpoEmail)
            //         ENDIF
            //         ZA3->(DBSkip())
            //     END          
            // ENDIF

            MsgInfo("Aprovado com sucesso!")
            oDlgFolder:End()

        endif
    
    else
        MsgStop("Sem permissão para aprovação do subcontrato (nível cadastro)!", "Aprovação não permitida")
    endif    

elseif EMPTY(BQC->BQC_XAPROV)   // não necessita aprovação
    MsgInfo("Este subcontrato não necessita aprovação!")
endif

return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±±
±±³Funcao    ³ CABA238D ³ Autor ³ Marcos Cantalice      ³ Data ³ 01.12.98 ³±±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±±
±±³Descricao ³ Consulta o historico de (Des)aprovação do Subcontrato      ³±±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

USER FUNCTION CABA238D()

Local aCabZA4  := {}
Local aDadZA4 := {}                                          
Local aTrbZA4 := {}
Local nOpca   := 1
Local oBrwZA4   
Local oDlg

ZA4->(DbSetOrder(3)) //ZA4_FILIAL+ZA4_CODINT+ZA4_CODEMP+ZA4_NUMCON+ZA4_VERCON+ZA4_SUBCON+ZA4_VERSUB+ZA4_ACAO+ZA4_CODOPE
If  ZA4->(MsSeek(xFilial("ZA4")+BQC->(BQC_CODINT+BQC_CODEMP+BQC_NUMCON+BQC_VERCON+BQC_SUBCON+BQC_VERSUB)))
	DEFINE MSDIALOG oDlg TITLE 'Historico (Des)Aprovação' FROM 009,010 TO 029,110 OF GetWndDefault()
       Store Header "ZA4" TO aCabZA4 For .T. 
       Store COLS 	"ZA4" TO aDadZA4 From aCabZA4 VETTRAB aTrbZA4  While xFilial("ZA4")+ZA4->(ZA4_CODINT+ZA4_CODEMP+ZA4_NUMCON+ZA4_VERCON+ZA4_SUBCON+ZA4_VERSUB) == xFilial("BQC")+BQC->(BQC_CODINT+BQC_CODEMP+BQC_NUMCON+BQC_VERCON+BQC_SUBCON+BQC_VERSUB) 
       oBrwZA4  := TPLSBrw():New(030 ,001 ,395 ,150 ,nil ,oDlg ,nil ,{|| nil } ,nil ,nil  ,nil , .T., nil, .T. , nil ,aCabZA4 ,aDadZA4 ,.F. ,"ZA4" ,K_Visualizar,"Histórico de (Des)Aprovação do Sub-Contrato",nil,nil,nil,aTrbZA4,,,) 
	ACTIVATE MSDIALOG oDlg ON INIT EnchoiceBar( oDlg, {|| nOpca := 1,oDlg:End()}, {|| nOpca := 2,oDlg:End()} )
	
Else
    Aviso( "Aprovação de Sub-Contrato", "Não existe Histórico de (Des)Aprovação para este Sub-Contrato.",{ "Ok" }, 2 )
Endif
	
Return  

//------------------------------------------------------//
// Rotina de Reprovação do subcontrato                  //
//------------------------------------------------------//
User Function CABA238E()

Local cIdAprov		:= RetCodUsr()
Local cObs          := ""

if BQC->BQC_XAPROV == '0' .OR. BQC->BQC_XAPROV == '1' .OR. BQC->BQC_XAPROV == '2' .OR. BQC->BQC_XAPROV == '3' .OR. BQC->BQC_XAPROV == '4'

    cSetor        := ""    
    cNivelAprov        := ""    
    aAprov := BuscaAprov(cSetor, cNivelAprov)	

    if aAprov[1]  
	
        if MsgYesNo("Confirma a Reprovação do subcontrato ?")

            cObs := Tela_Reprov()

            IF EMPTY(cObs)
                Return
            Endif

            Begin Transaction

                RecLock("BQC", .F.)
                    BQC->BQC_XAPROV	:= "5"
                MsUnlock()

                RecLock("ZA4", .T.)
                    ZA4->ZA4_FILIAL := xFilial("ZA4")
                    ZA4->ZA4_CODINT := SubStr(BQC->BQC_CODIGO,1,4)
                    ZA4->ZA4_CODEMP := SubStr(BQC->BQC_CODIGO,5,4)
                    ZA4->ZA4_NUMCON := BQC->BQC_NUMCON
                    ZA4->ZA4_VERCON := BQC->BQC_VERCON
                    ZA4->ZA4_SUBCON := BQC->BQC_SUBCON
                    ZA4->ZA4_VERSUB := BQC->BQC_VERSUB
                    ZA4->ZA4_SETOR  := aAprov[3]
                    ZA4->ZA4_NIVEL  := aAprov[4]
                    ZA4->ZA4_CODOPE := cIdAprov
                    ZA4->ZA4_NOMOPE := aAprov[2]
                    ZA4->ZA4_ACAO   := "3"
                    ZA4->ZA4_DATA   := Date()
                    ZA4->ZA4_HORA   := time()
                    ZA4->ZA4_OBS    := cObs
                MsUnlock()

            End Transaction

            cAssunto := "REPROVAÇÃO DE SUBCONTRATO"
            cCorpoEmail := "Prezado(a)," +"<br>"+"O sub-contrato não foi aprovado, favor entrar em contato."
            cCorpoEmail += "<br><strong>Razão Social: </strong>"+BQC->BQC_DESCRI
            cCorpoEmail += "<br><strong>CNPJ: </strong>"+BQC->BQC_CNPJ
            cCorpoEmail += "<br><strong>Data do Sub-contrato: </strong>"+SUBSTR(DTOS(BQC->BQC_DATCON),7,2)+"/"+SUBSTR(DTOS(BQC->BQC_DATCON),5,2)+"/"+SUBSTR(DTOS(BQC->BQC_DATCON),1,4)

            U_CABEMAIL("oliveiramarcos55@hotmail.com", , , cAssunto, cCorpoEmail)

            MsgInfo("Reprovado com sucesso!")
            oDlgFolder:End()

        endif
    
    else
        MsgInfo("Sem permissão para reprovação do subcontrato!")
    endif

endif

return

Static Function Tela_Reprov()

Local oButton2
Local cGet1 := SPACE(60)
Local OK
Local oSay1
Static oDlg

DEFINE MSDIALOG oDlg TITLE "Reprovação de Sub-Contrato" FROM 000, 000  TO 150, 550 COLORS 0, 16777215 PIXEL

    @ 017, 010 SAY oSay1 PROMPT "Motivo da Reprovação:" SIZE 097, 009 OF oDlg COLORS 0, 16777215 PIXEL
    @ 032, 011 MSGET cGet1 SIZE 250, 012 OF oDlg COLORS 0, 16777215 PIXEL 
    @ 055, 210 BUTTON OK PROMPT "OK" SIZE 037, 012 OF oDlg  ACTION IIF(EMPTY(cGet1), MsgStop("Favor descreva o motivo da Reprovação", "Campo Obrigatório"),oDlg:End()) PIXEL
    @ 055, 167 BUTTON oButton2 PROMPT "Cancelar" SIZE 037, 012 OF oDlg ACTION oDlg:End() PIXEL

  ACTIVATE MSDIALOG oDlg CENTERED

Return cGet1

Static Function BuscaAprov(cSetor, cNivelAprov)
Local cQuery		:= ""
local cAliasQuery	:= GetNextAlias()
Local cIdAprov		:= RetCodUsr()
local aRet          := {}

    cQuery := " SELECT ZA3_NOMAPR, ZA3_SETOR, ZA3_NIVEL"
	cQuery += " FROM " + RetSqlName("ZA3")
    cQuery += " WHERE D_E_L_E_T_ = ' '"
    IF !EMPTY(cSetor)
	    cQuery +=   " AND ZA3_SETOR  = '"+cSetor+"'"
    ENDIF
    IF !EMPTY(cNivelAprov)
	    cQuery +=   " AND ZA3_NIVEL  = '"+cNivelAprov+"'"
    ENDIF
	cQuery +=   " AND ZA3_CODAPR = '" + cIdAprov + "'"
	cQuery +=   " AND ZA3_VIGINI <= '" + DtoS(date()) + "'"
	cQuery +=   " AND (ZA3_VIGFIM = ' ' OR ZA3_VIGFIM >= '" + DtoS(date()) + "')"

	dbUseArea( .T., "TOPCONN", TcGenQry( ,, cQuery ) , cAliasQuery, .F., .T. )

	if (cAliasQuery)->(!EOF())
        AAdd( aret , .T. )
        AAdd( aret , (cAliasQuery)->ZA3_NOMAPR )
        AAdd( aret , (cAliasQuery)->ZA3_SETOR )
        AAdd( aret , (cAliasQuery)->ZA3_NIVEL )
    else
        AAdd( aret , .F. )
    endif

    (cAliasQuery)->(DbCloseArea())

Return aret
