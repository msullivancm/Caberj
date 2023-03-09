#INCLUDE "PROTHEUS.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±º Programa ³ CABA235  º Autor ³ Marcos Cantalice - 7 Consulting         º±±
º Data ³ 26/10/22                                                         º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Protheus                                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

USER FUNCTION CABA235()
Private cRazaoSocial  := " "
Private cNomeFantasia  := " "

IF Alltrim(FunName()) $ "CABA233" 

    IF ProcName(10) == "PLSA660C"
        RecLock("BQC",.F.)
            BQC->BQC_XAPROV := "0"
        MsUnlock()
    ELSEIF ALLTRIM(BQC->BQC_XAPROV ) == "4"
        MsgStop("Não é permitido alterar um sub-contrato já aprovado!", "Alteração não permitida")
        RETURN
    ENDIF

    IF !(CABA235B())
        Return
    Endif

    IF !EMPTY(cGet1)
        IF CGC(cGet1)
            IF u_CABA235A(cGet1)
                ZA5->(DBSetOrder(1))
                IF ZA5->(DBSeek(xFilial("ZA5")+cGet1)) //ZA5_FILIAL+ZA5_CNPJ                
                    IF ZA5->ZA5_APROV <> "1"
                        MsgStop("Favor, entre em contato com a área Comercial antes de cadastrar esse CNPJ em um SubContrato", "Análise CNPJ")
                        U_CABA235()
                        RETURN
                    ELSE 
                        RecLock("BQC",.F.)
                            BQC->BQC_CNPJ   := cGet1
                            BQC->BQC_DESCRI := cRazaoSocial
                            BQC->BQC_NREDUZ := cNomeFantasia
                            BQC->BQC_XAPROV := "0"
                        MsUnlock()
                    ENDIF
                ELSE
                    MsgStop("Favor, entre em contato com a área Comercial antes de cadastrar esse CNPJ em um SubContrato", "Análise CNPJ")
                    U_CABA235()
                    RETURN
                ENDIF
            ELSE
                U_CABA235()
                RETURN
            ENDIF
        ELSE
            U_CABA235()
            RETURN
        ENDIF
    ENDIF

    IF ProcName(10) == "PLSA660C"
    // IF !EMPTY(MV_PAR02)
        RecLock("BQC",.F.)
            BQC->BQC_DATCON := Stod(SUBSTR(aDate[nComboBo1], 7,4)+SUBSTR(aDate[nComboBo1], 4,2)+SUBSTR(aDate[nComboBo1], 1,2))
        MsUnlock()
    
        BQD->(DBSetOrder(1))
        IF BQD->(DBSeek(xFilial("BQD")+BQC->BQC_CODIGO+BQC->BQC_NUMCON+BQC->BQC_VERCON+BQC->BQC_SUBCON+BQC->BQC_VERSUB)) //BQD_FILIAL+BQD_CODIGO+BQD_NUMCON+BQD_VERCON+BQD_SUBCON+BQD_VERSUB+DTOS(BQD_DATINI)
            RecLock("BQD",.F.)
                BQD->BQD_DATINI := Stod(SUBSTR(aDate[nComboBo1], 7,4)+SUBSTR(aDate[nComboBo1], 4,2)+SUBSTR(aDate[nComboBo1], 1,2))
            MsUnlock()
        ENDIF
    ENDIF
    
    // IF !EMPTY(MV_PAR03)
    //     RecLock("BQC",.F.)
    //         BQC->BQC_NREDUZ := MV_PAR03
    //     MsUnlock()
    // ENDIF
    IF !EMPTY(cGet4)
        RecLock("BQC",.F.)
            BQC->BQC_NOMCAR := cGet4
        MsUnlock()
    ENDIF

    IF EMPTY(cGet1) .AND. EMPTY(MV_PAR02) .AND. EMPTY(MV_PAR03)
        MsgInfo("Nenhum campo foi alterado!", "Atenção")
    ELSE
        MsgInfo("Campo(s) Alterado(s) com sucesso!", "Atenção")
    ENDIF
ENDIF

Return

USER FUNCTION CABA235A(cCNPJ) 

    LOCAL lRet := .F.
    LOCAL cPath as char
    LOCAL oRest as object
    LOCAL cJSON as char
    LOCAL jJson
    LOCAL cParser as char

    jJson := JsonObject():new()
    oRest := FWRest():new("https://receitaws.com.br/v1/cnpj/")
    cPath := ALLTRIM(cCNPJ)

    oRest:setPath(cPath)

    if oRest:get()
        cJSON := decodeUtf8(oRest:getResult())

        cParser := jJson:fromJson(cJSON)

        if empty(cParser)            
            IF jJson["situacao"] == "ATIVA"
                cAbertura := jJson["abertura"] 
                cAbertura := SUBSTR(cAbertura, 7,4)+SUBSTR(cAbertura, 4,2)+SUBSTR(cAbertura, 1,2)

                IF DateDiffMonth(STOD(cAbertura),DATE()) >= 6                
                    lRet := .T.
                    cRazaoSocial := jJson["nome"]
                    cNomeFantasia := jJson["fantasia"]
                ELSE
                    MsgAlert("Por Favor, insira um CNPJ com no mínimo 6 meses de abertura", "ERRO")
                ENDIF
            ELSE
                MsgAlert("Por Favor, insira um CNPJ com a situação ATIVA", "ERRO")
            ENDIF
        else
            msgStop("Ocorreu um erro no retorno da API:" + CRLF + cParser, "Erro")
        endif
    else
        msgStop("Por favor, digite um CNPJ válido", "Erro")
    endif

    freeObj(oRest)

return lRet

STATIC FUNCTION CABA235B()

Local lRet := .F.
Local aDatas := CABA235C()
Local oButton2



Local oComboBo1
Local oGet1
// Local oGet2
// Local cGet2 := "Define variable value"
Local oGet4
Local oSay1
// Local oSay2
Local oSay3
Local oSay4
Static oDlg
Static cGet1 := Space(14)
Static cGet4 := Space(40)
Static nComboBo1 := 1

  DEFINE MSDIALOG oDlg TITLE "Alteracao de Subcontato" FROM 000, 000  TO 170, 350 COLORS 0, 16777215 PIXEL

    @ 016, 013 SAY oSay1 PROMPT "CNPJ*" SIZE 025, 007 OF oDlg COLORS 0, 16777215 PIXEL
    // @ 027, 003 SAY oSay2 PROMPT "Nome Reduzido" SIZE 053, 007 OF oDlg COLORS 0, 16777215 PIXEL
    @ 027, 013 SAY oSay3 PROMPT "Data do Sub-Contrato" SIZE 055, 007 OF oDlg COLORS 0, 16777215 PIXEL
    @ 039, 013 SAY oSay4 PROMPT "Nome impresso no cartao" SIZE 065, 007 OF oDlg COLORS 0, 16777215 PIXEL
    @ 013, 080 MSGET oGet1 VAR cGet1 SIZE 060, 010 OF oDlg COLORS 0, 16777215 PIXEL
    // @ 025, 070 MSGET oGet2 VAR cGet2 SIZE 060, 010 OF oDlg COLORS 0, 16777215 PIXEL
    @ 024, 080 MSCOMBOBOX oComboBo1 VAR nComboBo1 ITEMS aDatas SIZE 060, 010 OF oDlg COLORS 0, 16777215 PIXEL
    @ 036, 080 MSGET oGet4 VAR cGet4 SIZE 060, 010 OF oDlg COLORS 0, 16777215 PIXEL


    @ 065, 105 BUTTON OK PROMPT "OK" SIZE 037, 012 OF oDlg  ACTION IIF(EMPTY(cGet1) , MsgStop("Favor preencha todos os campos obrigatórios(*)", "Campo Obrigatório"),(lRet := .T.,oDlg:End())) PIXEL
    @ 065, 055 BUTTON oButton2 PROMPT "Cancelar" SIZE 037, 012 OF oDlg ACTION (lRet := .F., oDlg:End() ) PIXEL

  ACTIVATE MSDIALOG oDlg CENTERED

RETURN lRet

STATIC FUNCTION CABA235C()
Static aDate := {}

    aDate := {}

    // IF Day(Date()) > DAY(BT5->BT5_DATCON)
    //     aAdd(aDate , STRZERO(DAY(BT5->BT5_DATCON),2)+"/"+SUBSTR(DTOS(MonthSum(DATE(),1)),5,2)+"/"+SUBSTR(DTOS(MonthSum(DATE(),1)),1,4))
    // else
    //     aAdd(aDate , STRZERO(DAY(BT5->BT5_DATCON),2)+"/"+SUBSTR(DTOS(DATE()),5,2)+"/"+SUBSTR(DTOS(MonthSum(DATE(),1)),1,4))
    // endif   

    IF DateDiffDay(Date(),STOD(SUBSTR(DTOS(DATE()),1,6)+STRZERO(DAY(BT5->BT5_DATCON),2))) < 10 .or. date() > STOD(SUBSTR(DTOS(DATE()),1,6)+STRZERO(DAY(BT5->BT5_DATCON),2))
        aAdd(aDate , STRZERO(DAY(BT5->BT5_DATCON),2)+"/"+SUBSTR(DTOS(MonthSum(DATE(),1)),5,2)+"/"+SUBSTR(DTOS(MonthSum(DATE(),1)),1,4))
    ELSE
        aAdd(aDate , STRZERO(DAY(BT5->BT5_DATCON),2)+"/"+SUBSTR(DTOS(DATE()),5,2)+"/"+SUBSTR(DTOS(MonthSum(DATE(),1)),1,4))
    ENDIF

RETURN aDate
