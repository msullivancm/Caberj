#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'PARMTYPE.CH'
#INCLUDE 'APWEBSRV.CH'
#INCLUDE 'TBICONN.CH'
#INCLUDE 'TOPCONN.CH'
#INCLUDE 'RWMAKE.CH'
#INCLUDE 'AP5MAIL.CH'
#INCLUDE 'FONT.CH'
#INCLUDE 'COLORS.CH'

#DEFINE c_ent CHR(13) + CHR(10)
/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  � CABV062 �Autor  �Anderson Rangel     � Data � OUTUBRO/2021 ���
�������������������������������������������������������������������������͹��
���Desc.     �Valida se o usu�rio tem acesso ao tipo de servico especifico���
���          �															  ���
�������������������������������������������������������������������������͹��
���Uso       �CABERJ e INTEGRAL                                           ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

User Function CABV062()

	Local _ChaveZX 	:= M->ZX_USUARIO
	Local _ChaveZY 	:= M->ZY_TIPOSV
	Local _cServ	:= U_CABA583I(_ChaveZY)
	Local _pUsuPerm	:= GetMV('MV_XPROCBC') // Usu�rios permitidos para registrar protocolos com o tipos de servi�os especificados no MV_XPRCDSE.
	Local _pCodServ	:= GetMV('MV_XPRCDSE') // Tipo de Servi�o "1092" e "1093"
	Local _pCodSeco	:= GetMV('MV_XPRSECO') // Tipo de Servi�o "1005" (Exclus�o de Plano)
	local lRet 		:= .T.
	
	If (_ChaveZY $ _pCodServ)
	
		If (!RetCodUsr() $ AllTrim(_pUsuPerm))

			MsgStop("O Servi�o "+AllTrim(_cServ)+" e o Hist�rico Padr�o foram criados somente para as a��es da equipe Carteira Bem Cuidada.",AllTrim(SM0->M0_NOMECOM))
			M->ZY_TIPOSV := ""	
			M->ZY_SERV	:= ""
			lRet := .f.

		EndIf
	
	elseif (_ChaveZY $ _pCodSeco) .and. Substr(_ChaveZX,5,4) = '0003' // Valida��o para abertura de protocolos de atendimento com a matricula 0003 (colaborador) e o tipo de servi�o do parametro MV_XPRSECO 

		MsgStop("O Servi�o "+AllTrim(_cServ)+" n�o est� disponivel para baneficiario COLABORADOR. Favor solicitar ao Beneficiario entrar em contato com o nosso RH.",AllTrim(SM0->M0_NOMECOM))
		M->ZY_TIPOSV := ""	
		M->ZY_SERV	:= ""
		lRet := .F.

	EndIf



return lret

//Valida��o usada na SX1 da CABA595
User Function CBV62RN(_Chave)

	local lRet 		:= .T.
	
	If Substr(_Chave,5,4) = '0003' // Valida��o para abertura de protocolos de atendimento com a matricula 0003 (colaborador) e o tipo de servi�o do parametro MV_XPRSECO 

		MsgStop("A rotina de cancelamento RN412 n�o est� disponivel para baneficiario COLABORADOR. Favor entrar em contato com o nosso RH.",AllTrim(SM0->M0_NOMECOM))
		lRet := .F.

	EndIf

return lret
