#include "RWMAKE.CH"
#include "PLSMGER.CH"
#include "COLORS.CH"
#include "TOPCONN.CH"
#DEFINE CRLF Chr(13)+Chr(10)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±º Programa ³ PL498LIBPG º Autor ³ Marcos Cantalice º Data ³  27/09/22   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Validar liberação de pagamento						      º±±
±±º          ³ 									                          º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Protheus                                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function PL498LIBPG

Local aArea			:= GetArea()
Local aAreaBD7	:= BD7->(GetArea())
Local aAreaBD6	:= BD6->(GetArea())
Local lRet			:= .T.
Local cError        := ""
Local nVlrPag       := 0
Local nVlrGlo       := 0
Local nVlrTx        := 0
Local cGuia         := ""

IF Alltrim(FunName()) $ "PLSA498"

    BD7->(DBSetOrder(1))
    IF BD7->(DBSeek(xFilial("BD7")+BCI->BCI_CODOPE+BCI->BCI_CODLDP+BCI->BCI_CODPEG))

        While !BD7->(EOF()) .And. BD7->(BD7_FILIAL+BD7_CODOPE+BD7_CODLDP+BD7_CODPEG) == xFilial("BD7")+BCI->BCI_CODOPE+BCI->BCI_CODLDP+BCI->BCI_CODPEG
            
            IF BD7->BD7_SITUAC = "2" .OR. BD7->BD7_SITUAC = "3" //Tratamento para pular guias canceladas ou guias bloqueadas
                BD7->(DBSkip())
            ELSE
                IF BD7->BD7_FASE != "3"

                    lRet    := .F.
                    cError  := "Não será possível liberar para pagamento! Todas as guias devem estar com a situação ativa e a fase pronta."
                    EXIT
                    
                ENDIF

                nVlrPag := nVlrPag + BD7->BD7_VLRPAG
                nVlrGlo := nVlrGlo + BD7->BD7_VLRGLO
                nVlrTx  := nVlrTx  + BD7->BD7_VLTXPG

                IF BD7->BD7_VLRPAG-BD7->BD7_VLTXPG+BD7->BD7_VLRGLO != BD7->BD7_VALORI
                    cGuia += CRLF + "* A guia de número: "+cValtoChar(BD7->BD7_NUMERO)+" Sequência: "+cValtoChar(BD7->BD7_SEQUEN)+" Valor Pagto: "+cValToChar(BD7->BD7_VLRPAG)+" Valor Glosa: "+cValToChar(BD7->BD7_VLRGLO)+" Total do valor Apresentado: "+cvaltochar(BD7->BD7_VALORI)+CRLF
                ENDIF
            
                BD7->(DBSkip())
            ENDIF
        END

        IF BCI->BCI_VALORI != nVlrPag-nVlrTx+nVlrGlo
            lRet    := .F.
            cError  := "Não será possível liberar para pagamento! O somatório do valor de pagamento com o valor da glosa de cada guia deve ser igual ao apresentado."
            cError += CRLF+cGuia

        ENDIF

    ENDIF
    BD7->(RestArea(aAreaBD7))

    nVlrPag       := 0
    nVlrGlo       := 0
    nVlrTx        := 0

    BD6->(DBSetOrder(1))
    IF BD6->(DBSeek(xFilial("BD6")+BCI->BCI_CODOPE+BCI->BCI_CODLDP+BCI->BCI_CODPEG))

        While !BD6->(EOF()) .And. BD6->(BD6_FILIAL+BD6_CODOPE+BD6_CODLDP+BD6_CODPEG) == xFilial("BD6")+BCI->BCI_CODOPE+BCI->BCI_CODLDP+BCI->BCI_CODPEG
            
            IF BD6->BD6_SITUAC = "2" .OR. BD6->BD6_SITUAC = "3" //Tratamento para pular guias canceladas ou guias bloqueadas
                BD6->(DBSkip())
            ELSE
                IF BD6->BD6_FASE != "3"

                    lRet    := .F.
                    cError  := "Não será possível liberar para pagamento! Todas as guias devem estar com a situação ativa e a fase pronta."
                    EXIT
                    
                ENDIF

                nVlrPag := nVlrPag + BD6->BD6_VLRPAG
                nVlrGlo := nVlrGlo + BD6->BD6_VLRGLO
                nVlrTx  := nVlrTx  + BD6->BD6_VLTXPG

                    IF BD6->BD6_VLRPAG-BD6->BD6_VLTXPG+BD6->BD6_VLRGLO != BD6->BD6_VALORI
                        cGuia += CRLF + "* A guia de número: "+cValtoChar(BD6->BD6_NUMERO)+" Sequência: "+cValtoChar(BD6->BD6_SEQUEN)+" Valor Pagto: "+cValToChar(BD6->BD6_VLRPAG)+" Valor Glosa: "+cValToChar(BD6->BD6_VLRGLO)+" Total do valor Apresentado: "+cvaltochar(BD6->BD6_VALORI)+CRLF
                    ENDIF
    	
                BD6->(DBSkip())
            ENDIF
        END

        IF BCI->BCI_VALORI != nVlrPag-nVlrTx+nVlrGlo
            lRet    := .F.
            cError  := "Não será possível liberar para pagamento! O somatório do valor de pagamento com o valor da glosa de cada guia deve ser igual ao apresentado."
            cError += CRLF+cGuia

        ENDIF

    ENDIF
    BD6->(RestArea(aAreaBD6))
    


ENDIF

restArea(aArea)


RETURN {lRet, cError}
    