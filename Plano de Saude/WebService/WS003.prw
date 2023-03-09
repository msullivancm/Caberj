#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'PARMTYPE.CH'
#INCLUDE "APWEBSRV.CH"
#INCLUDE "TBICONN.CH"

#DEFINE cEnt Chr(13)+Chr(10)

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  � WS003    �Autor  �Angelo Henrique     � Data �  22/03/2017 ���
�������������������������������������������������������������������������͹��
���Desc.     �WebService criado para atender a RN412 ANS.                 ���
���          �Processo de Cancelamento de Plano e retorno de relat�rio    ���
���          �e realiza a inser��o do protocolo de atendimento e o envio  ���
���          �do mesmo para o benefici�rio no site da CABERJ.             ���
�������������������������������������������������������������������������͹��
���M�todos.  �                                                            ���
���          �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       �CABERJ                                                      ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

User Function WS003()

Return

//------------------------------------------------------
// Inicio - Estruturas utilizadas no m�todo RN_412
// Para ser encaminhada no retorno
//------------------------------------------------------

//-------------------------------------------------------------------------------------
//Estrutura que ir� retornar no Webservice:
//-------------------------------------------------------------------------------------
// 1 - Protocolo de Atendimento Criado
// 2 - Array contendo as informa��es pertinentes aos titulos em aberto
//-------------------------------------------------------------------------------------
WSSTRUCT oRetRn

	WSDATA  _cProt		AS STRING

ENDWSSTRUCT

WSSERVICE WS003 DESCRIPTION "Cancelamento de Plano - <b>RN 412</b>"

	WSDATA _cChvBenf 	AS STRING 	//Matricula do Benefici�rio
	WSDATA _oRet 		AS oRetRn	//Retorno do Webservice

	WSDATA _cEmpLog		AS STRING	//Empresa para realizar login (CABERJ/INTEGRAL) - Utilizado no Lista Protocolos

	WSMETHOD WS003BLQ DESCRIPTION "Metodo que ira bloquear e gerar o protocolo."

ENDWSSERVICE

/*
�������������������������������������������������������������������������͹��
���Desc.     � Metodo para listar os boletos disponiveis                  ���
���          � atendimento.                                               ���
�������������������������������������������������������������������������͹��
���Uso       � CABERJ - WebService                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

WSMETHOD WS003BLQ WSRECEIVE _cChvBenf, _cEmpLog WSSEND _oRet WSSERVICE WS003

	Local _cPrtc	:= ""
	Local lRet		:= .T.

	If Empty(AllTrim(_cEmpLog)) .OR. !(AllTrim(_cEmpLog) $ "01|02")

		SetSoapFault( ProcName() , "N�o foi possivel realizar login no sistema de protocolos." )
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
				//Rotina que realiza o bloqueio do benefici�rio
				//-----------------------------------------------------
				u_CABA595D(_cChvBenf)							

				If !(Empty(BA1->BA1_DATBLO))

					//-----------------------------------------------------------------
					//Integral necess�rio continuar gerando tudo autom�tico
					//-----------------------------------------------------------------
					If _cEmpLog = '02'

						//-----------------------------------------------------
						//Rotina que ir� gerar o protocolo de atendimento
						//-----------------------------------------------------
						//Porta de Entrada = WEB (000012)
						//Canal = Fale Conosco (000005)
						//-----------------------------------------------------
						_cPrtc := u_CABA595E(_cChvBenf, "000012", "000005")

						If !Empty(_cPrtc)

							::_oRet:_cProt := _cPrtc

						Else

							SetSoapFault( ProcName() , "Benefici�rio bloqueado, por�m n�o foi gerado protocolo de atendimento." )
							lRet := .F.

						EndIf

					Else	
						
						//------------------------------------------------------------------------
						//Na caberj devido a necessidade de se colocar os dados banc�rios
						//o site esta chamando separadamente a cria��o do protocolo 
						//de atendimento
						//------------------------------------------------------------------------

						_cPrtc := "OK"
						::_oRet:_cProt := _cPrtc

					EndIf

				Else

					SetSoapFault( ProcName() , "N�o existem boletos para a matricula informada." )
					lRet := .F.

				EndIf

			Else

				SetSoapFault( ProcName() , "Benefici�rio j� bloqueado." )
				lRet := .F.

			EndIf

		EndIf

	EndIf

Return lRet
