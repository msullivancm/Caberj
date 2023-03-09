#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'PARMTYPE.CH'
#INCLUDE "APWEBSRV.CH"
#INCLUDE "TBICONN.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ WS012    บAutor  ณ Frederico O. C. Jr บ Data ณ  13/10/2021 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณWebService criado para ser utilizado no processo de FALE    บฑฑ
ฑฑบDesc.     ณCONOSCO do protocolo de atendimento.                        บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Fabrica de Software                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function WS012()

Return


WSSERVICE WS012 DESCRIPTION "Informar o acompanhante de um beneficiario internado" NAMESPACE "WS012"
	
	//-----------------------------------------------------
	//Lista dos parametros de recebimento
	//-----------------------------------------------------
	WSDATA _cEmpInc		AS STRING	// Empresa que o sistema irแ realizar login para buscar as informa็๕es
	WSDATA _cGuia		AS STRING	// Numero da guia de interna็ใo
	WSDATA _NomeCont	AS STRING	// Nome do contato do beneficiario internado
	WSDATA _TelCont		AS STRING	// Telefone de contato do beneficiario internado

	WSDATA tRet 		AS BOOLEAN	// Retorno sobre a execu็ใo do m้tido

	//-----------------------------------------------------
	//Declara็ใo dos M้todos
	//-----------------------------------------------------
	WSMETHOD WS012CONTATO	DESCRIPTION "M้todo - Informar contato do beneficiแrio sendo internado"
	
ENDWSSERVICE

/*
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Metodo para consulta do CEP informado.                     บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CABERJ - WebService                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
WSMETHOD WS012CONTATO WSRECEIVE _cEmpInc, _cGuia, _NomeCont, _TelCont  WSSEND tRet WSSERVICE WS012
	
	Local lRet			:= .T.
	
	//-----------------------------------------------------------------------------------------------
	//Validando a empresa que serแ efetruado o login (CABERJ ou INTEGRAL)
	//-----------------------------------------------------------------------------------------------
	if Empty(AllTrim(_cEmpInc)) .or. ( AllTrim(_cEmpInc) <> "01" .and. AllTrim(_cEmpInc) <> "02")
		SetSoapFault( "", "Nao foi possivel realizar login no sistema." )
		lRet := .F.
	elseif Empty(AllTrim(_cGuia))
		SetSoapFault( "", "Numero da guia nao informado." )
		lRet := .F.
	elseif Empty(AllTrim(_NomeCont))
		SetSoapFault( "", "Nome do contato nao informado." )
		lRet := .F.
	elseif Empty(AllTrim(_TelCont))
		SetSoapFault( "", "Telefone de contato nao informado." )
		lRet := .F.
	else

		// PREPARA AMBIENTE
		if FindFunction("WfPrepEnv")
			WfPrepEnv(_cEmpInc,"01")
		else
			PREPARE ENVIRONMENT EMPRESA _cEmpInc FILIAL "01"
		endif

		BE4->(DbSetOrder(2))	// BE4_FILIAL+BE4_CODOPE+BE4_ANOINT+BE4_MESINT+BE4_NUMINT
		if BE4->(DbSeek( xFilial("BE4") + _cGuia )) .and. len(AllTrim(_cGuia)) == 18

			if !empty(BE4->BE4_DATPRO)

				if empty(BE4->BE4_DTALTA)

					BE4->(RecLock("BE4", .F.))
						BE4->BE4_MSG03 := "Acompanhante: " + AllTrim(_NomeCont) + " - Telefone: " + AllTrim(_TelCont)
					BE4->(MsUnlock())

					::tRet := lRet
				
				else
					SetSoapFault( "", "Beneficiario ja se encontra com data de alta informada." )
					lRet := .F.
				endif

			else
				SetSoapFault( "", "Beneficiario ainda nao se encontra internado." )
				lRet := .F.
			endif
		
		else
			SetSoapFault( "", "Guia de internacao nao localizada no Protheus." )
			lRet := .F.
		endif
	
	endif

return lRet
