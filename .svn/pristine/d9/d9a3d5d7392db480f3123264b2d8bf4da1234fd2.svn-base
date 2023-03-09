#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'PARMTYPE.CH'
#INCLUDE "APWEBSRV.CH"
#INCLUDE "TBICONN.CH"

#DEFINE cEnt Chr(13)+Chr(10)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ WS003    บAutor  ณAngelo Henrique     บ Data ณ  22/03/2017 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณWebService criado para atender a RN412 ANS.                 บฑฑ
ฑฑบ          ณProcesso de Cancelamento de Plano e retorno de relat๓rio    บฑฑ
ฑฑบ          ณe realiza a inser็ใo do protocolo de atendimento e o envio  บฑฑ
ฑฑบ          ณdo mesmo para o beneficiแrio no site da CABERJ.             บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบM้todos.  ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณCABERJ                                                      บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function WS003()

Return

//------------------------------------------------------
// Inicio - Estruturas utilizadas no m้todo RN_412
// Para ser encaminhada no retorno
//------------------------------------------------------

//-------------------------------------------------------------------------------------
//Estrutura que irแ retornar no Webservice:
//-------------------------------------------------------------------------------------
// 1 - Protocolo de Atendimento Criado
// 2 - Array contendo as informa็๕es pertinentes aos titulos em aberto
//-------------------------------------------------------------------------------------
WSSTRUCT oRetRn

	WSDATA  _cProt		AS STRING

ENDWSSTRUCT

WSSERVICE WS003 DESCRIPTION "Cancelamento de Plano - <b>RN 412</b>"

	WSDATA _cChvBenf 	AS STRING 	//Matricula do Beneficiแrio
	WSDATA _oRet 		AS oRetRn	//Retorno do Webservice

	WSDATA _cEmpLog		AS STRING	//Empresa para realizar login (CABERJ/INTEGRAL) - Utilizado no Lista Protocolos

	WSMETHOD WS003BLQ DESCRIPTION "Metodo que ira bloquear e gerar o protocolo."

ENDWSSERVICE

/*
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Metodo para listar os boletos disponiveis                  บฑฑ
ฑฑบ          ณ atendimento.                                               บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CABERJ - WebService                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

WSMETHOD WS003BLQ WSRECEIVE _cChvBenf, _cEmpLog WSSEND _oRet WSSERVICE WS003

	Local _cPrtc	:= ""
	Local lRet		:= .T.

	If Empty(AllTrim(_cEmpLog)) .OR. !(AllTrim(_cEmpLog) $ "01|02")

		SetSoapFault( ProcName() , "Nใo foi possivel realizar login no sistema de protocolos." )
		lRet := .F.

	Else

		//------------------
		//PREPARA AMBIENTE
		//------------------
		If FindFunction("WfPrepEnv")

			WfPrepEnv(_cEmpLog,"01")

		Else

			PREPARE ENVIRONMENT EMPRESA _cEmpLog FILIAL "01"

		EndIf

		DbSelectArea("BA1")
		DbSetOrder(2)
		If DbSeek(xFilial("BA1") + _cChvBenf)

			If Empty(BA1->BA1_DATBLO)

				//-----------------------------------------------------
				//Rotina que realiza o bloqueio do beneficiแrio
				//-----------------------------------------------------
				u_CABA595D(_cChvBenf)							

				If !(Empty(BA1->BA1_DATBLO))

					//-----------------------------------------------------------------
					//Integral necessแrio continuar gerando tudo automแtico
					//-----------------------------------------------------------------
					If _cEmpLog = '02'

						//-----------------------------------------------------
						//Rotina que irแ gerar o protocolo de atendimento
						//-----------------------------------------------------
						//Porta de Entrada = WEB (000012)
						//Canal = Fale Conosco (000005)
						//-----------------------------------------------------
						_cPrtc := u_CABA595E(_cChvBenf, "000012", "000005")

						If !Empty(_cPrtc)

							::_oRet:_cProt := _cPrtc

						Else

							SetSoapFault( ProcName() , "Beneficiแrio bloqueado, por้m nใo foi gerado protocolo de atendimento." )
							lRet := .F.

						EndIf

					Else	
						
						//------------------------------------------------------------------------
						//Na caberj devido a necessidade de se colocar os dados bancแrios
						//o site esta chamando separadamente a cria็ใo do protocolo 
						//de atendimento
						//------------------------------------------------------------------------

						_cPrtc := "OK"
						::_oRet:_cProt := _cPrtc

					EndIf

				Else

					SetSoapFault( ProcName() , "Nใo existem boletos para a matricula informada." )
					lRet := .F.

				EndIf

			Else

				SetSoapFault( ProcName() , "Beneficiแrio jแ bloqueado." )
				lRet := .F.

			EndIf

		EndIf

	EndIf

Return lRet
