#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'PARMTYPE.CH'

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³PLSDEPTO  ºAutor  ³Angelo Henrique     º Data ³  07/03/17   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³  Ponto de Entrada utilizado para personalizar a gravação   º±±
±±º          ³  do campo de departamento resposavel pela auditoria.       º±±
±±º          ³  Neste momento estou chamando a tela para preenchimento de º±±
±±º          ³  informações pertinentes a procedimentos de OPME.          º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CABERJ                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function PLSDEPTO()
	
	Local _aArea := GetArea()
	Local _aAr54 := B54->(GetArea())
	Local _aAr53 := B53->(GetArea())
	Local _aArAU := BAU->(GetArea())
	Local _cRet	 := B53->B53_CODDEP //Codigo do departamento
	Local _lPsiq := .F. 
	
	//Fabio Bianchini - 03/11/2020 - Tratando para não ser chamado pelo HAT, pois existem controles visuais 
	//                               não utilizáveis em rotina chamada por Schedule
	//If !(AllTrim(FUNNAME()) $ 'WFLAUNCHER|PLENVHATSC|PLENVHAT|PLSHATSYNC')
		//-------------------------------------------------------------
		//Colocando validação para que a rotina não seja chamada
		//pela função de liberação de internação.
		//-------------------------------------------------------------
		If !(UPPER(AllTrim(FUNNAME())) $ "PLSA094B|PLSA001") 
			
			//----------------------------------------------------------------------------------------
			//Solicitado que nos casos de internação domiciliar , psiquiátrica e reciprocidade
			//não seja exibida a tela de OPME
			//----------------------------------------------------------------------------------------
			If !(BE4->BE4_GRPINT = "5")
				
				If !(BE4->BE4_REGINT = '3')
					
					DbSelectArea("BAU")
					DbSetOrder(1)
					If DbSeek(xFilial("BAU") + BE4->BE4_CODRDA)
						
						If !( BAU->BAU_TIPPRE $ "OPE|REC")
							
							u_PLSM3A()
							
						EndIf
						
					EndIf
				
				Else
				
					_lPsiq := .T.
					
				EndIf
				
			Else
			
				_lPsiq := .T.
				
			EndIf
			
		ElseIf UPPER(AllTrim(FUNNAME())) == "PLSA094B"
			
			//------------------------------------------------------------
			//Conforme solicitado pela ANS quando ocorre internação
			//é necessário que um protocolo de atendimento seja
			//criado
			//------------------------------------------------------------
			If Empty(BEA->BEA_XPROTC)//Criar campo para armazenar o protocolo
				
				//Rotina responsável por criar o protocolo de atendimento
				U_PLSM3C("2")
				
			EndIf
			
			
		EndIf
		
		//-------------------------------------------------------------------------------------------
		//Se for as situações de internação domiciliar , psiquiátrica e reciprocidade
		//o campo BE4_YSOPME deve permanecer em branco.
		//-------------------------------------------------------------------------------------------
		If _lPsiq
		
			RecLock("BE4", .F.)
			
			BE4->BE4_YSOPME := " "
			
			BE4->(MsUnLock())
		
		EndIf
	//Endif

	//--------------------------------------------------------------------------------------------------------
	//Inicio - Angelo Henrique - Data: 03/10/2021
	//--------------------------------------------------------------------------------------------------------
	//Chamada para a disparo de email para prestador quando for emergencia/urgencia
	//--------------------------------------------------------------------------------------------------------
	If AllTrim(BE4->BE4_TIPADM) $ ("4,5") 
		
		U_CABA099(BE4->(BE4_FILIAL+BE4_CODOPE+BE4_ANOINT+BE4_MESINT+BE4_NUMINT)) 

	EndIf
	
	RestArea(_aArAU)
	RestArea(_aAr53)
	RestArea(_aAr54)
	RestArea(_aArea)
	
Return _cRet