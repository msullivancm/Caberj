#INCLUDE "PROTHEUS.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³PLSFTMCB  ºAutor  ³Marcela Coimbra     º Data ³  25/09/15   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Permitir a iversão da ordem da cobrança                    º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/


/*
Ponto de Entrada PLSFTMCB na função PLSBUSFAI. Verifica valores de cobrança para o usuário.

Objetivo: No momento do faturamento ou de solicitação de valor de cobrança de uma família com este ponto de entrada é possível informar se será
possível realizar um faturamento para a família informada.
*/

User Function PLSFTMCB()

	Local lBloFat 	:= .F.

	Private c_Nivel	:= ParamIxb[1]
	Private c_Chave := ParamIxb[2]
	Private c_Ano   := ParamIxb[3]
	Private c_Mes   := ParamIxb[4] //ligue a variável lBloFat de acordo com sua regra de negocio Return(lBloFat)
	Private c_While := ""
	Private _aArSE5	:= SE5->(GetArea()) //Angelo Henrique - Data: 21/06/2019

	If c_Nivel == "1" // Empresa
		c_While := "BBT->(BBT_CODOPE + BBT_CODEMP)"
	ElseIf c_Nivel == "2" //Nivel contrato
		c_While := "BBT->(BBT_CODOPE + BBT_CODEMP+BBT_CONEMP+BBT_VERCON)"
	ElseIf c_Nivel == "3"  //Nivel subcontrato
		c_While := "BBT->(BBT_CODOPE + BBT_CODEMP+BBT_CONEMP+BBT_VERCON+BBT_SUBCON+BBT_VERSUB)"
	ElseIf c_Nivel == "4" //Nivel familia
		c_While := "BBT->(BBT_CODOPE + BBT_CODEMP+BBT_MATRIC)"
	ElseIf c_Nivel == "5" //Usuario
		c_While := "BBT->(BBT_CODOPE + BBT_CODEMP+BBT_MATRIC)"
	EndIf

	//---------------------------------------------------------------------------------------------
	//Angelo Henrique - Data: 06/01/2023
	//---------------------------------------------------------------------------------------------
	//Todas as validações foram passadas para essa função, pois foi necessário
	//reforçar esse bloqueio de faturamento dentro do PE PLSVLRFM
	//---------------------------------------------------------------------------------------------
	lBloFat := u_VLDBLQFT("1")

	RestArea(_aArSE5) //Angelo Henrique - Data: 21/06/2019

Return lBloFat


/*/{Protheus.doc} VLDBLQFT
Validação para saber se o beneficiário será cobrado ou não.
@type function
@version 1.0
@author angelo.cassago
@since 06/01/2023
@param _cParam, variant, Nesse parametro é encaminhado por
qual ponto de entrada (PE) esta sendo chamada a função, pois
para o principal PLSFTMCB faz a validação sobre títulos
@return variant, retorna verdadeiro ou falso para bloquear o faturamento
/*/
User Function VLDBLQFT(_cParam)

	Local lBloFat	:= .F.
	Local _aAreBA3	:= BA3->(GetArea())
	Local _aAreBBT	:= BBT->(GetArea())
	Local _aAreBDC	:= BDC->(GetArea())
	Local _aAreSE5	:= SE5->(GetArea())
	Local nRecnoBDC	:= 0
	Local _lCanc 	:= .T. //Angelo Henrique - Data: 21/06/2019

	DEFAULT _cParam := "1"

	If _cParam == "1"

		//**'Regra Padrão'**

		BBT->(DbSetOrder(Val(c_Nivel)))
		nRecnoBDC:= BDC->(Recno())
		BDC->(DbSetOrder(1))//BDC_FILIAL, BDC_CODOPE, BDC_NUMERO
		If BBT->(MsSeek(xFilial("BBT")+c_Nivel+c_Chave+c_Ano+c_Mes))
			While BBT->BBT_FILIAL == xFilial("BBT") .and. BBT->BBT_NIVEL == c_Nivel .and. &(c_While) == c_Chave .and. BBT->BBT_ANOTIT==c_Ano .and. BBT->BBT_MESTIT == c_Mes
				If Empty(BBT->BBT_NUMCOB) .Or.;
						(GetNewPar("MV_PLSNFBR","0")=="1" .And. BBT->BBT_PREFIX == GetNewPar("MV_PLSPRCP","CPP"))
					BBT->(Dbskip())
					Loop
				Endif

				//--------------------------------------------------------------------------------------------------------------
				//³ Tratamento para Faturar Novamente quando somente ja tiver Fatura Reembolso ou pagamento no ato...
				//--------------------------------------------------------------------------------------------------------------
				SE1->(dbSeek(Xfilial("SE1")+ BBT->(BBT_PREFIX+BBT_NUMTIT+BBT_PARCEL+BBT_TIPTIT)))

				//--------------------------------------------------------------------------------------------------------------
				//Inicio - Angelo Henrique - Data: 21/06/2019
				//--------------------------------------------------------------------------------------------------------------
				//A rotina de cancelamento em alguns momentos na deletava as informações na tabela BBT
				//Para resolver isso foi necessário olhar a movimentação bancária (SE5) e ver se o título foi cancelado
				//não entrando assim
				//--------------------------------------------------------------------------------------------------------------

				_lCanc := .F.

				DbSelectArea("SE5")
				DbSetOrder(7) //E5_FILIAL+E5_PREFIXO+E5_NUMERO+E5_PARCELA+E5_TIPO+E5_CLIFOR+E5_LOJA+E5_SEQ
				If DbSeek(xFilial("SE5") + SE1->(E1_PREFIXO+E1_NUM+E1_PARCELA+E1_TIPO+E1_CLIENTE+E1_LOJA))

					If Upper(AllTrim(SE5->E5_MOTBX)) = "CAN"

						_lCanc := .T.

					EndIf

				EndIf
				//--------------------------------------------------------------------------------------------------------------
				//Fim - Angelo Henrique - Data: 21/06/2019
				//--------------------------------------------------------------------------------------------------------------

				If !_lCanc

					If BDC->(FieldPos("BDC_REEMB")) > 0

						If BDC->(MsSeek(xFilial("BDC")+BBT->BBT_NUMCOB)) .And. (BDC->BDC_REEMB <> "1" .AND. Alltrim(SE1->E1_ORIGEM) <>"PLSA090")// Somente Reembolso

							lBloFat := .T.

						Endif

						//----------------------------------------------------------------------------------------------------
						//³ Volta Recno BDC para nao ficar disposicionado...
						//----------------------------------------------------------------------------------------------------

						BDC->(DbGoto(nRecnoBDC))

					Else

						lBloFat := .T.

					Endif

				EndIf

				BBT->(Dbskip())

			Enddo

		EndIf

	EndIf

	//--------------------------------------------------------------------------------------------------------------
	//**' Inicio - Marcela Coimbra - GLPI 28567 - Data: 21/06/2016'**
	//--------------------------------------------------------------------------------------------------------------

	If (BA3->BA3_CODEMP $ GetNewPar("MV_XEMPSUS","0182||0222||0250||0265") .AND. BA3->BA3_MOTBLO $ GetNewPar("MV_XBLOSUS","765")) ;
			.OR. BA3->BA3_MOTBLO $ GetNewPar("MV_XBLOFT","642")

		lBloFat := .T.

	ElseIf cEmpAnt == '02' .and. BA3->BA3_MOTBLO == '009'

		dbSelectArea("BQC")
		dbSetOrder(1) //BQC_BQC_FILIAL+BQC_CODIGO+BQC_NUMCON+BQC_VERCON+BQC_SUBCON+BQC_VERSUB
		iF 	DbSeek(xFilial("BQC")+BA3->BA3_CODINT+BA3->BA3_CODEMP+BA3->BA3_CONEMP+BA3->BA3_VERCON+BA3->BA3_SUBCON+BA3->BA3_VERSUB)

			If BQC->BQC_CODBLO == '009'

				lBloFat := .T.

			EndIf

		EndIf

	Endif

	//**' Fim - Marcela Coimbra - GLPI 28567 - Data: 21/06/2016'**

	//Teste faturamento QV
	If cEmpAnt == '02' .and. BA3->BA3_MOTBLO == '765' .and. BA3->BA3_CODEMP = '0296'

		lBloFat := .F.

	EndIf

	If cEmpAnt == '02' .and. BA3->BA3_MOTBLO == '765' .and. !(BA3->BA3_CODEMP = '0296')

		lBloFat := .T.

	EndIf

	If cEmpAnt == '02' .and. BA3->BA3_MOTBLO == '995'

		lBloFat := .T.

	EndIf

	RestArea(_aAreBA3)
	RestArea(_aAreBBT)
	RestArea(_aAreBDC)
	RestArea(_aAreSE5)

Return lBloFat
