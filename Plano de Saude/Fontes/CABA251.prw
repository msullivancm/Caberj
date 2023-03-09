#include 'rwmake.ch'
#Include "Protheus.ch"
#include "PLSMGER.CH"
#Include "Topconn.ch"

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  � CABA251  � Autor � Marcos Cantalice   � Data �  16/12/22   ���
�������������������������������������������������������������������������͹��
���Desc.     � Cadastro de CNPJ de SubContrato                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP7                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/


*---------------------*
User Function CABA251()
*---------------------*
// LOCAL aCores  := {{ 'ZA5->ZA5_BLOFIM==" "' , 'ENABLE'  },;    // Ativo
//                   { 'ZA5->ZA5_BLOFIM<>" "' , 'DISABLE' }}    // Inativo
Private cCadastro   := "Cadastro de CNPJ - SubContrato"
Private cDelFunc    := ".F." // Validacao para a exclusao. Pode-se utilizar ExecBlock
Private aRotina     := { { "Pesquisar"  , "AxPesqui"    , 00, 01 } ,;
    		             { "Visualizar" , "AxVisual"    , 00, 02 } ,;
            		     { "Incluir"    , "AxInclui"    , 00, 03 } ,;
    		             { "Alterar"    , "AxAltera"    , 00, 04 } ,;
            		     { "Excluir"    , "AxDeleta"    , 00, 05 }  }

AADD(aRotina, { "Aprova CNPJ"     , "U_CABA251C" , 0, 6 })
AADD(aRotina, { "Reprova CNPJ"     , "U_CABA251D" , 0, 7 })
AADD(aRotina, { "Historico Aprovacao"     , "U_CABA251E" , 0, 8 })

DbSelectArea( "ZA5" )
DbSetOrder( 01 )
mBrowse( 06, 01, 22, 75, "ZA5",,,,,,)//aCores )

Return

// User Function CABA251()

// Local aArea		:= GetArea()
// Private	cMsg	:= "Cadastro de CNPJ - SubContrato"
// Private cAlias	:= "ZA5"

// DbSelectArea(cAlias)
// DbSetOrder(1)

// AxCadastro(cAlias, cMsg, ".F.", ".T.")

// RestArea(aArea)

// return

USER FUNCTION CABA251A(cCNPJ) 
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
                ELSE
                    MsgAlert("Por Favor, insira um CNPJ com no m�nimo 6 meses de abertura", "ERRO")
                ENDIF
            ELSE
                MsgAlert("Por Favor, insira um CNPJ com a situa��o ATIVA", "ERRO")
            ENDIF
        else
            msgStop("Ocorreu um erro no retorno da API:" + CRLF + cParser, "Erro")
        endif

    else
        msgStop("Por favor, digite um CNPJ v�lido", "Erro")

    endif

    freeObj(oRest)

return lRet

USER FUNCTION CABA251B(cCNPJ) 
    LOCAL cRazaoSocial := ""
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
                cRazaoSocial := jJson["nome"]
            ENDIF
        else
            msgStop("Ocorreu um erro no retorno da API:" + CRLF + cParser, "Erro")
        endif
    endif

    freeObj(oRest)

return cRazaoSocial

USER FUNCTION CABA251C()

Local cArpovadOr    :=  SuperGetMv("MV_XZA5APR")
Local cIdAprov		:= RetCodUsr()

dbSelectArea('ZA6')

IF cIdAprov $ cArpovadOr
    IF ZA5->ZA5_APROV <> "1"
        IF MsgYesNo("Confirma a Aprova��o do CNPJ? A partir desse momento ser� poss�vel utiliz�-lo para a cria��o de um subcontrato.", "APROVA��O DE CNPJ")

            Begin Transaction

                RecLock("ZA5", .F.)
                    ZA5->ZA5_APROV := "1"
                MsUnlock()

                RecLock("ZA6", .T.)
                        ZA6->ZA6_FILIAL := xFilial("ZA6")
                        ZA6->ZA6_CNPJ   := ZA5->ZA5_CNPJ
                        ZA6->ZA6_CODOPE := cIdAprov
                        ZA6->ZA6_NOMOPE := UsrRetName(cIdAprov)
                        ZA6->ZA6_ACAO   := "1"
                        ZA6->ZA6_DATA   := Date()
                        ZA6->ZA6_HORA   := time()
                        // ZA6->ZA6_OBS    := cObs
                    MsUnlock()

            End Transaction   

            MsgInfo("CNPJ Aprovado com �xito!", "SUCESSO")                     
        ENDIF
    ELSE
        MsgStop("Esse CNPJ j� foi aprovado!", "Aprova��o n�o realizada")
    ENDIF
ELSE
    MsgStop("Este usu�rio n�o tem permiss�o para aprovar o CNPJ", "Acesso Negado")
ENDIF

RETURN

USER FUNCTION CABA251D()

Local cArpovadOr    :=  SuperGetMv("MV_XZA5APR")
Local cIdAprov		:= RetCodUsr()

IF cIdAprov $ cArpovadOr
    IF ZA5->ZA5_APROV <> "2"
        IF MsgYesNo("Confirma a Reprova��o do CNPJ? ", "REPROVA��O DE CNPJ")

            cObs := Tela_Reprov()

            IF EMPTY(cObs)
                Return
            Endif

            Begin Transaction

                RecLock("ZA5", .F.)
                    ZA5->ZA5_APROV := "2"
                MsUnlock()

                RecLock("ZA6", .T.)
                        ZA6->ZA6_FILIAL := xFilial("ZA6")
                        ZA6->ZA6_CNPJ   := ZA5->ZA5_CNPJ
                        ZA6->ZA6_CODOPE := cIdAprov
                        ZA6->ZA6_NOMOPE := UsrRetName(cIdAprov)
                        ZA6->ZA6_ACAO   := "2"
                        ZA6->ZA6_DATA   := Date()
                        ZA6->ZA6_HORA   := time()
                        ZA6->ZA6_OBS    := cObs
                    MsUnlock()

            End Transaction      

            MsgInfo("CNPJ Reprovado com �xito!", "SUCESSO")                     

        ENDIF
    ELSE
        MsgStop("Esse CNPJ j� foi reprovado!", "Reprova��o n�o realizada")
    ENDIF
ELSE
    MsgStop("Este usu�rio n�o tem permiss�o para reprovar o CNPJ", "Acesso Negado")
ENDIF

RETURN

USER FUNCTION CABA251E()

Local aCabZA6  := {}
Local aDadZA6 := {}                                          
Local aTrbZA6 := {}
Local nOpca   := 1
Local oBrwZA6   
Local oDlg

ZA6->(DbSetOrder(1)) //ZA6_FILIAL+ZA6_CNPJ+ZA6_DATA+ZA6_HORA
If  ZA6->(MsSeek(xFilial("ZA6")+ZA5->ZA5_CNPJ))
	DEFINE MSDIALOG oDlg TITLE 'Historico Aprova��o' FROM 009,010 TO 029,110 OF GetWndDefault()
       Store Header "ZA6" TO aCabZA6 For .T. 
       Store COLS 	"ZA6" TO aDadZA6 From aCabZA6 VETTRAB aTrbZA6  While xFilial("ZA6")+ZA6->ZA6_CNPJ == xFilial("ZA5")+ZA5->ZA5_CNPJ
       oBrwZA6  := TPLSBrw():New(030 ,001 ,395 ,150 ,nil ,oDlg ,nil ,{|| nil } ,nil ,nil  ,nil , .T., nil, .T. , nil ,aCabZA6 ,aDadZA6 ,.F. ,"ZA6" ,K_Visualizar,"Hist�rico de (Des)Aprova��o do Sub-Contrato",nil,nil,nil,aTrbZA6,,,) 
	ACTIVATE MSDIALOG oDlg ON INIT EnchoiceBar( oDlg, {|| nOpca := 1,oDlg:End()}, {|| nOpca := 2,oDlg:End()} )
	
Else
    Aviso( "Aprova��o de CNPJ PME", "N�o existe Hist�rico de Aprova��o/Reprova��o para este CNPJ.",{ "Ok" }, 2 )
Endif

RETURN

Static Function Tela_Reprov()

Local oButton2
Local cGet1 := SPACE(60)
Local OK
Local oSay1
Static oDlg

DEFINE MSDIALOG oDlg TITLE "Reprova��o de cnpj" FROM 000, 000  TO 150, 550 COLORS 0, 16777215 PIXEL

    @ 017, 010 SAY oSay1 PROMPT "Motivo da Reprova��o:" SIZE 097, 009 OF oDlg COLORS 0, 16777215 PIXEL
    @ 032, 011 MSGET cGet1 SIZE 250, 012 OF oDlg COLORS 0, 16777215 PIXEL 
    @ 055, 210 BUTTON OK PROMPT "OK" SIZE 037, 012 OF oDlg  ACTION IIF(EMPTY(cGet1), MsgStop("Favor descreva o motivo da Reprova��o", "Campo Obrigat�rio"),oDlg:End()) PIXEL
    @ 055, 167 BUTTON oButton2 PROMPT "Cancelar" SIZE 037, 012 OF oDlg ACTION oDlg:End() PIXEL

  ACTIVATE MSDIALOG oDlg CENTERED

Return cGet1
