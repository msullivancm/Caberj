#Include 'Protheus.ch'
#Include 'FWMVCDEF.ch'
#Include 'RestFul.CH'
#INCLUDE "TBICONN.CH"
#INCLUDE "tryexception.ch"

WSRESTFUL PROTOCOLORESTSERVICE DESCRIPTION "Serviço REST para retornar o sequencial de Protocolo de Atendimento"

WSMETHOD GET DESCRIPTION "Obtém o próximo sequencial de Numero de protocolo de PA" WSSYNTAX "/GETNUMPA"

END WSRESTFUL

WSMETHOD GET WSSERVICE PROTOCOLORESTSERVICE
   
    Local bError := { |oError| RetTratEr( oError ) }
	Local oError
    Local cSeq := ''
    local lRetorno :=  .T.

    QOut("WSREST GET SEQUENCIAL DE PROTOCOLO DE ATENDIMENTO "+ DTOC(DATE()) +" "+ TIME())


    TRYEXCEPTION USING bError

        If FindFunction("WfPrepEnv")
                
            WfPrepEnv("02","01")
                
        Else
            
            PREPARE ENVIRONMENT EMPRESA "02" FILIAL "01"
            
        EndIf

        ::SetContentType("application/json")

        cSeq := U_GERNUMPA()

        cJSONRet := '{"cSeq": "'+cSeq+'" }'

        ::SetResponse(cSeq)

    CATCHEXCEPTION USING oError

        lRetorno := .F.
        SetRestFault(001,oError:Description) 

	ENDEXCEPTION 

Return(lRetorno)

Static Function RetTratEr(oError)

	QOut("Erro na macroexecução: " + oError:Description + Chr(13))
	BREAK
	
Return (NIL)
