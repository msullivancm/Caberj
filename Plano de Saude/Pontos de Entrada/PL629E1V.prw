#INCLUDE "PROTHEUS.CH"
#INCLUDE "TOPCONN.CH"
#INCLUDE "RWMAKE.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³PL629E1V  ºAutor  ³Angelo Henrique     º Data ³  04/12/19   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Ponto de entrada para validar se o titulo pode ser excluido º±±
±±º          ³ou não.                                                     º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CABERJ                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function PL629E1V()

	Local _aArea	:= GetArea()
	Local _aArSE1	:= SE1->(GetArea())
	Local _aArSF2	:= SF2->(GetArea())
	Local _aArSD2	:= SD2->(GetArea())
	Local cPrefixo	:= paramixb[1] //Prefixo
	Local cNum    	:= paramixb[2] //Numero
	Local cParcela 	:= paramixb[3] //Parcela
	Local cTipo   	:= paramixb[4] //Tipo
	Local _lErro   	:= paramixb[7] //variável que indica se ja foi encontrado algum erro para Cancelamento do Título
	Local _aErro   	:= paramixb[8] //Array com as Informações : [1]Tabela / [2] Chave (composicao) / [3] Chave (conteudo) / [4] Mensagem
	Local cLibera 	:= GetNewPar("MV_YLIBEXC","001091")

	If AllTrim(FunName()) <> "PLSA001"

		//------------------------------------------------------------------------------------------------------
		// Solicitado pelo Carlos (Financeiro) para que o mesmo possa ter acesso a excluir os titulos
		// mesmo se eles possuirem nota vinculada
		//------------------------------------------------------------------------------------------------------
		If !( __cUserID $ AllTrim(cLibera) )

			DbSelectArea("SE1")
			DbSetOrder(1) //E1_FILIAL+E1_PREFIXO+E1_NUM+E1_PARCELA+E1_TIPO
			If DbSeek(xFilial("SE1") + cPrefixo + cNum + cParcela + cTipo )

				//--------------------------------------------------------------------------
				//Se estiver preenchido é pq possui nota fiscal customizada gerada
				//--------------------------------------------------------------------------
				If !Empty(SE1->E1_XDOCNF)

					DbSelectArea("SF2")
					DbSetOrder(1) //F2_FILIAL+F2_DOC+F2_SERIE+F2_CLIENTE+F2_LOJA+F2_FORMUL+F2_TIPO
					If DbSeek(xFilial("SF2") + SE1->(E1_XDOCNF + E1_XSERNF + E1_CLIENTE + E1_LOJA) )

						If !Empty(SF2->F2_CODNFE)

							_lErro := .T.
							aAdd(_aErro,{ "SE1-Contas a Receber", "1 Prefixo+Numero+Parcela+Tipo", cPrefixo + cNum + cParcela + cTipo, "'Titulo possui nota fiscal transmitida = " + SF2->F2_SERIE + " - " + SF2->F2_DOC + "' "})

						EndIf

					EndIf

				EndIf

			EndIf

		EndIf

	Endif
	
	RestArea(_aArSD2)
	RestArea(_aArSF2)
	RestArea(_aArSE1)
	RestArea(_aArea	)

Return {_lErro,_aErro}
