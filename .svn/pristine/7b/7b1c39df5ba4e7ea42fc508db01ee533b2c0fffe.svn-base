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
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ CABV062 ºAutor  ³Anderson Rangel     º Data ³ OUTUBRO/2021 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Valida se o usuário tem acesso ao tipo de servico especificoº±±
±±º          ³															  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³CABERJ e INTEGRAL                                           º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function CABV062()

	Local _ChaveZX 	:= M->ZX_USUARIO
	Local _ChaveZY 	:= M->ZY_TIPOSV
	Local _cServ	:= U_CABA583I(_ChaveZY)
	Local _pUsuPerm	:= GetMV('MV_XPROCBC') // Usuários permitidos para registrar protocolos com o tipos de serviços especificados no MV_XPRCDSE.
	Local _pCodServ	:= GetMV('MV_XPRCDSE') // Tipo de Serviço "1092" e "1093"
	Local _pCodSeco	:= GetMV('MV_XPRSECO') // Tipo de Serviço "1005" (Exclusão de Plano)
	local lRet 		:= .T.
	
	If (_ChaveZY $ _pCodServ)
	
		If (!RetCodUsr() $ AllTrim(_pUsuPerm))

			MsgStop("O Serviço "+AllTrim(_cServ)+" e o Histórico Padrão foram criados somente para as ações da equipe Carteira Bem Cuidada.",AllTrim(SM0->M0_NOMECOM))
			M->ZY_TIPOSV := ""	
			M->ZY_SERV	:= ""
			lRet := .f.

		EndIf
	
	elseif (_ChaveZY $ _pCodSeco) .and. Substr(_ChaveZX,5,4) = '0003' // Validação para abertura de protocolos de atendimento com a matricula 0003 (colaborador) e o tipo de serviço do parametro MV_XPRSECO 

		MsgStop("O Serviço "+AllTrim(_cServ)+" não está disponivel para baneficiario COLABORADOR. Favor solicitar ao Beneficiario entrar em contato com o nosso RH.",AllTrim(SM0->M0_NOMECOM))
		M->ZY_TIPOSV := ""	
		M->ZY_SERV	:= ""
		lRet := .F.

	EndIf



return lret

//Validação usada na SX1 da CABA595
User Function CBV62RN(_Chave)

	local lRet 		:= .T.
	
	If Substr(_Chave,5,4) = '0003' // Validação para abertura de protocolos de atendimento com a matricula 0003 (colaborador) e o tipo de serviço do parametro MV_XPRSECO 

		MsgStop("A rotina de cancelamento RN412 não está disponivel para baneficiario COLABORADOR. Favor entrar em contato com o nosso RH.",AllTrim(SM0->M0_NOMECOM))
		lRet := .F.

	EndIf

return lret
