#INCLUDE "PROTHEUS.CH"

USER FUNCTION PL660VAR()
Local nOpc := paramixb[1]
Local lRet := .T.
Local cAssunto := "CÓPIA DE SUBCONTRATO - ALLCARE - PME"
Local cCorpoEmail := ""
Local cUsuariosPermitidos := SUPERGETMV( "MV_XALTSUB", .F., "",)

/*----------------------------------
Opção do menu que está sendo chamada
	2 - Visualizar;
	3 - Incluir;
	4 - Alterar;
	5 - Excluir;
 	6 - Nova Versão;
----------------------------------*/

IF Alltrim(FunName()) $ "CABA233" 
    IF nOpc == 3 .OR. nOpc == 4 .OR. nOpc == 5 .OR. nOpc == 6
        lRet := .F.	
        IF nOpc == 4
            U_CABA235() 
            IF ProcName(9) == "PLSA660C" //Se for rotina de cópia do sub-contrato
                cCorpoEmail := "Prezado(a)," +"<br>"+"A administradora Allcare efetuou uma cópia de sub-contrato, favor analisar o mesmo."
                cCorpoEmail += "<br><strong>Razão Social: </strong>"+BQC->BQC_DESCRI
                cCorpoEmail += "<br><strong>CNPJ: </strong>"+BQC->BQC_CNPJ
                cCorpoEmail += "<br><strong>Data do Sub-contrato: </strong>"+SUBSTR(DTOS(BQC->BQC_DATCON),7,2)+"/"+SUBSTR(DTOS(BQC->BQC_DATCON),5,2)+"/"+SUBSTR(DTOS(BQC->BQC_DATCON),1,4)
                ZA3->(DBSetOrder(1))
                IF ZA3->(DBSeek(xFilial("ZA3")+"1"+"1")) //ZA3_FILIAL+ZA3_SETOR+ZA3_NIVEL+ZA3_CODAPR
                    WHILE !ZA3->(EOF()) .And. ZA3->ZA3_FILIAL+ZA3->ZA3_SETOR+ZA3->ZA3_NIVEL == xFilial("ZA3")+"1"+"1"
                        IF EMPTY(ZA3->ZA3_VIGFIM)
                            U_CABEMAIL(ZA3->ZA3_EMAIL, , , cAssunto, cCorpoEmail)
                        ELSEIF ZA3->ZA3_VIGFIM >= DATE()
                            U_CABEMAIL(ZA3->ZA3_EMAIL, , , cAssunto, cCorpoEmail)
                        ENDIF
                        ZA3->(DBSkip())
                    END          
                ENDIF
            ENDIF
        ELSE
            U_CABA233A()
        ENDIF       
    Else
        lRet := .T.
    EndIF
ELSE
    IF nOpc == 4
        IF !(RETCODUSR() $ cUsuariosPermitidos + '|' + GetMV('MV_XGETIN'))
            lRet := .F.	
            MsgStop("Este usuário não tem permissão para alterar um Sub-Contrato.", "Acesso Negado")
        ENDIF
    ENDIF
EndIF

Return lRet
