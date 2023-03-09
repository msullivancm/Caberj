#include 'protheus.ch'
#include 'parmtype.ch'

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³PLS790GR    ºAutor  ³Angelo Henrique   º Data ³  15/03/17   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Ponto de entrada utilizado quando o auditor autoriza ou negaº±±
±±º          ³a internação para atualizar o status da internação OPME.    º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CABERJ                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

user function PLS790GR()

	Local _aArB53 	:= B53->(GetArea())
	Local _aArB72 	:= B72->(GetArea())
	Local _aArBE4 	:= BE4->(GetArea())
	Local _aArBEL 	:= BEL->(GetArea())

	Local _lAnls	:= .F.
	Local _lAtu 	:= .F.		

	//------------------------------------------------------
	//Se negou ou autorizou é necessário varrer toda 
	//a tabela B72 para visualizar todos os processos 
	//para saber seus respectivos status
	//------------------------------------------------------	
	BEL->(DbGoTop())
	DbSelectArea("BEL")				  
	DbSetOrder(1) //BEL_FILIAL + BEL_CODOPE + BEL_ANOINT + BEL_MESINT + BEL_NUMINT + BEL_SEQUEN
	If DbSeek(xFilial("BEL") + B53->B53_NUMGUI)

		While BEL->(!EOF()) .And. B53->B53_NUMGUI ==  BEL->(BEL_CODOPE + BEL_ANOINT + BEL_MESINT + BEL_NUMINT)

			If BEL->BEL_PENDEN == '1' .Or. Empty(AllTrim(BEL->BEL_PENDEN))//EM ANALISE

				_lAnls := .T.
				Exit //Se tiver algum item em analise não precisa varrer o resto

			EndIf			

			BEL->(DbSkip())

		EndDo


		If _lAnls //Achou Algum Item com status de Em Analise

			DbSelectArea("BE4")
			DbSetOrder(2) //BE4_FILIAL+BE4_CODOPE+BE4_ANOINT+BE4_MESINT+BE4_NUMINT
			If DbSeek(xFilial("BE4") + B53->B53_NUMGUI)
				if B72->B72_PARECE == '2' // Em análise - Mateus Medeiros - 11/01/2018 - Validação feita por estar alterando BE4 de forma errada
					RecLock("BE4", .F.)
						BE4->BE4_YSOPME := "4" //Exigencia Aud.
					BE4->(MsUnLock())
				endif 

			EndIf

		Else

			DbSelectArea("BE4")
			DbSetOrder(2) //BE4_FILIAL+BE4_CODOPE+BE4_ANOINT+BE4_MESINT+BE4_NUMINT
			If DbSeek(xFilial("BE4") + B53->B53_NUMGUI)

				RecLock("BE4", .F.)

				If !(Empty(BE4->BE4_SENHA))
															
					BE4->BE4_YSOPME := "A" //INTERNAÇÃO LIBERADA, pois entende-se que foi uma internação de Urgência.

				Else

					If  BE4->BE4_SITUAC <> "3"

						//---------------------------------
						//Utiliza OPME - SIM ou Não
						//---------------------------------
						If BE4->BE4_YOPME = "1" //Não 
							
							BE4->BE4_YSOPME := "9" //AGUARDANDO LIBERAÇÃO - Pois não tem OPME

						Else

							BE4->BE4_YSOPME := "7" //ANALIS. OPME

						EndIf

					Else
											
						BE4->BE4_YSOPME := "C" //Negado

					EndIf

				EndIf


				BE4->(MsUnLock())

			EndIf

		Endif		

	Else

		//Não possui mais nenhuma critica BEL para ser analisada
		DbSelectArea("BE4")
		DbSetOrder(2) //BE4_FILIAL+BE4_CODOPE+BE4_ANOINT+BE4_MESINT+BE4_NUMINT
		If DbSeek(xFilial("BE4") + B53->B53_NUMGUI)

			RecLock("BE4", .F.)

			If !Empty(BE4->BE4_SENHA)
				
				BE4->BE4_YSOPME := "A" //INTERNAÇÃO LIBERADA, pois entende-se que foi uma internação de Urgência.

			Else

				//---------------------------------
				//Utiliza OPME - SIM ou Não
				//---------------------------------
				If BE4->BE4_YOPME = "1" //Não
					
					BE4->BE4_YSOPME := "9" //AGUARDANDO LIBERAÇÃO

				Else

					BE4->BE4_YSOPME := "7" //ANALIS. OPME

				EndIf

			EndIf

			BE4->(MsUnLock())

		EndIf

	EndIf

	RestArea(_aArBEL)
	RestArea(_aArBE4)
	RestArea(_aArB72)
	RestArea(_aArB53)

return