#include "RWMAKE.CH"
#include "TOPCONN.CH"

Static CRLF := CHR(13) + CHR(10)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ PLSMUDFS º Autor ³ Jean Schulz           º Data ³ 29/11/06 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Ponto de entrada apos mudanca de fase					  º±±
±±º          ³ 									                          º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Protheus                                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function PLSMUDFS()

	Local nCont := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

	Local cTipGui	:= ParamIxb[1]
	Local cChave 	:= ""
	Local cCodLdp	:= ""
	Local cSeqImp	:= ""
	Local aArea		:= GetArea()
	Local aAreaBE4	:= BE4->(GetArea())
	Local aAreaBD5	:= BD5->(GetArea())
	Local aAreaBD6	:= BD6->(GetArea())
	Local aAreaBD7	:= BD7->(GetArea())
	Local aAreaBR8	:= BR8->(GetArea())

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Variaveis de utilizacao na rotina...                              		 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	Local cSeq		:= ""
	Local cSeqPac	:= ""
	Local cLocal	:= ""
	Local cEspPres	:= ""
	Local cOpeUsr	:= ""
	Local cCodEmp	:= ""
	Local cMatric	:= ""
	Local cTipReg	:= ""
	Local cDigito	:= ""
	Local cConEmp	:= ""
	Local cMatVid	:= ""
	Local cMesPag	:= ""
	Local cAnoPag	:= ""
	Local cOpeRDA	:= ""
	Local cCodRDA	:= ""
	Local dDatPro	:= CtoD("")
	Local cHorPro	:= ""
	Local dDatDig	:= ""
	Local cAnoInt	:= ""
	Local cMesInt	:= ""
	Local cNumInt	:= ""
	Local cOpeInt	:= ""
	Local cSigla	:= ""
	Local cEstSol	:= ""
	Local cNomSol	:= ""
	Local cCodLoc	:= ""
	Local cCdPfSo	:= ""
	Local cAteAmb	:= ""
	Local cCid		:= ""
	Local cCPFRDA	:= ""
	Local cDatNas	:= ""
	Local cDesLoc	:= ""
	Local cEndLoc	:= ""
	Local cIdUsr	:= ""
	Local cNomRDA	:= ""
	Local cNomUsr	:= ""
	Local cRegSol	:= ""
	Local cTipRDA	:= ""
	Local cMatUsa	:= ""
	Local cMatAnt	:= ""
	Local cCodPla	:= ""
	Local cGuiOri	:= ""
	Local cRegExe	:= ""
	Local cCdPFRe	:= ""
	Local cEstExe	:= ""
	Local cSigExe	:= ""
	Local cGuiAco	:= ""
	Local cNivel	:= ""
	Local cTipUsr	:= ""
	Local cModCob	:= ""
	Local cInterc	:= ""
	Local cTipInt	:= ""
	Local cProCCi	:= ""
	Local cVia		:= ""
	Local nPerVia	:= ""
	Local cCdPdRc	:= ""
	Local cCodTab 	:= ""
	Local cVerCon	:= ""
	Local cSubCon	:= ""
	Local cVerSub	:= ""
	Local cOpeOri	:= ""
	Local cSequen	:= ""
	Local cOriMov	:= ""
	Local cNumDoc	:= ""
	Local VlPgMa	:= ""
	Local lCriou	:= .F.
	Local aSeqPac	:= {}
	Local nRegBD6	:= 0


	//Variáveis declaradas em 27/05/11. Renato Peixoto
	Local nVlTADBD5 := 0
	Local nVlCopBD5 := 0
	Local lCopOPME  := .F.
	Local cProOPME  := GetMv("MV_XPROOPM")
	Local cQuery    := ""
	Local cAliasQry := GetNextAlias()
	Local cAliQry1  := GetNextAlias() //Angelo Henrique - Data:02/09/2015
	Local _nVlrCalc := 0 //Angelo Henrique - Data:02/09/2015
	Local _lCalc 	  := .F. //Angelo Henrique - Data:02/09/2015
	Local _nPerc 	  := 0 //Angelo Henrique - Data:06/01/2016
	Local _nVlrPf	  := 0 //Angelo Henrique - Data:06/01/2016
	Local cAliQry2  := GetNextAlias() //Angelo Henrique - Data:06/01/2016
	Local cSQLCop   := "" //Angelo Henrique - Data:06/01/2016
	Local _nValRpf  := 0 //Angelo Henrique - Data:20/09/2016
	
	M->BD6_CDNV01   := ""
	M->BD6_CDNV02   := ""
	M->BD6_CDNV03   := ""
	M->BD6_CDNV04   := ""
	
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Alimenta Variaveis...		 											 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	//Bianchini - 19/02/2019 - 
	//Acrescentado o TipGui 05, pois em guias de resumo, estava desponteirando, pegando uma guia qualquer em BD5
	If cTipGui $ "03|05"
		cCodLdp := BE4->BE4_CODLDP
		cChave  := BE4->(BE4_CODOPE+BE4_CODLDP+BE4_CODPEG+BE4_NUMERO+BE4_ORIMOV)
		dDatGui := BE4->BE4_DATPRO
		cSeqImp := BE4->BE4_SEQIMP
		cPeg	:= BE4->BE4_CODPEG
		cNumero	:= BE4->BE4_NUMERO
		cNumDoc	:= BE4->BE4_NUMIMP
	Else
		cCodLdp := BD5->BD5_CODLDP
		cChave  := BD5->(BD5_CODOPE+BD5_CODLDP+BD5_CODPEG+BD5_NUMERO+BD5_ORIMOV)
		dDatGui := BD5->BD5_DATPRO
		cSeqImp := BD5->BD5_SEQIMP
		cPeg	:= BD5->BD5_CODPEG
		cNumero	:= BD5->BD5_NUMERO
		cNumDoc	:= BD5->BD5_NUMIMP
		
		If cTipGui == "06"
			Reclock("BD5",.F.)
			BD5->BD5_PADINT := BE4->BE4_PADINT
			BD5->BD5_PADCON := BE4->BE4_PADCON
			BD5->(MsUnLock())
		endif
		
	Endif

	BD6->(dbSeek(xFilial("BD6")+cChave))

	//Leonardo Portella - 11/01/13 - Inicio

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Padrao esta bloqueando as BD7 quando cai em conferencia,              ³
	//³obrigando os analistas do contas a entrarem BD7 por BD7 para          ³
	//³desbloquear, quando a glosa eh parcial ou totalmente reconsiderada.   ³
	//³Isto ocorre somente na importacao TISS, nao ocorre na digitacao       ³
	//³manual. Conforme combinado com Totvs (Vitor Sbano) e Caberj (Marcia), ³
	//³este tratamento sera feito por PE ao inves de alterar o padrao.       ³
	//³Chamados IDs: 3345, 3427, 3322 e 3333.                                ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

	If IsInCallStack('PLSA973')

		BD7->(DbSetOrder(2))//BD7_FILIAL + BD7_CODOPE + BD7_CODLDP + BD7_CODPEG + BD7_NUMERO + BD7_ORIMOV + BD7_CODPAD + BD7_CODPRO + BD7_CODUNM + BD7_NLANC

		If BD7->(MsSeek(xFilial('BD7') + cChave))

			While !BD7->(EOF()) .and. ( BD7->(BD7_FILIAL + BD7_CODOPE + BD7_CODLDP + BD7_CODPEG + BD7_NUMERO + BD7_ORIMOV) == ( xFilial('BD7') + cChave ) )

				//Nao eh PA e nao eh BD7 origem
				If ( AllTrim(Upper(BD7->BD7_CODUNM)) <> 'PA' ) .and. empty(BD7->BD7_XRDBD7) .and. ( AllTrim(BD7->BD7_BLOPAG) <> '0' )

					BD7->(RecLock("BD7",.F.))
					BD7->BD7_BLOPAG	:= "0"//Desbloqueado
					BD7->(MsUnlock())
				//BIANCHINI - 16/05/2019 - ELIMINANDO BLOQUEIO/DESBLOQUEIO VIA PE
				//ElseIf ( AllTrim(Upper(BD7->BD7_CODUNM)) == 'PA' ) .and. ( AllTrim(BD7->BD7_BLOPAG) <> '1' )
					//BD7->(RecLock("BD7",.F.))
					//BD7->BD7_BLOPAG	:= "1"//Bloqueado
					//BD7->(MsUnlock())
				EndIf

				BD7->(DbSkip())

			EndDo

		EndIf
	Else
		BD7->(DbSetOrder(2))//BD7_FILIAL + BD7_CODOPE + BD7_CODLDP + BD7_CODPEG + BD7_NUMERO + BD7_ORIMOV + BD7_CODPAD + BD7_CODPRO + BD7_CODUNM + BD7_NLANC

		If BD7->(MsSeek(xFilial('BD7') + cChave))

			While !BD7->(EOF()) .and. ( BD7->(BD7_FILIAL + BD7_CODOPE + BD7_CODLDP + BD7_CODPEG + BD7_NUMERO + BD7_ORIMOV) == ( xFilial('BD7') + cChave ) )

				If BD7->BD7_BLOPAG == "1"
					//BIANCHINI - 21/08/2019 - Se Desbloqueio Pagamento, desbloqueio Cobrança. E vice versa
					u_BLOCPABD6(BD7->(BD7_CODOPE+BD7_CODLDP+BD7_CODPEG+BD7_NUMERO+BD7_ORIMOV+BD7_SEQUEN),BD7->BD7_MOTBLO,BD7->BD7_DESBLO, .T.,.T.)
				Else
					//BIANCHINI - 21/08/2019 - Se Desbloqueio Pagamento, desbloqueio Cobrança. E vice versa
					u_BLOCPABD6(BD7->(BD7_CODOPE+BD7_CODLDP+BD7_CODPEG+BD7_NUMERO+BD7_ORIMOV+BD7_SEQUEN),BD7->BD7_MOTBLO,BD7->BD7_DESBLO, .F.,.F.)
				EndIf

				BD7->(DbSkip())

			EndDo

		EndIf	
	EndIf
	//Leonardo Portella - 11/01/13 - Fim

	//Leonardo Portella - 17/03/15 - Sera feito no PLS720G1
	//Leonardo Portella - 22/11/14 - Glosar sem cair em conferencia caso entre na regra do estaleiro.

	//If BCL->BCL_ALIAS == 'BD5' 
	If BCL->BCL_ALIAS == 'BD5' .and. ((cEmpAnt=='01' .and. BD5->BD5_CODEMP $ '5000|5001|5002') .or. (cEmpAnt=='02' .and. BD5->BD5_CODEMP $ '0180|0183|0188|0189|0190|0259 '))
		u_lBlPgEstaleiro()
	EndIf

	//--------------------------------------------------------------------------------------
	//Inicio - Angelo Henrique - Data:06/11/2015
	//--------------------------------------------------------------------------------------
	//Tratamento de coparticipação quando o procedimento estiver parametrizado no nivel do
	//usuário, independente do regime. - Colocado este trecho também no P.E. PLSRETC2 e
	//no P.E. PLSCOMEV (Este P.E. é chamado na revalorização.)
	//porém no PLSRETC2 não faz atualização via RECLOCK somente passagem das variaveis
	//de coparticipação.
	//Ex: codigo: 81080042 - Diária global em enfermaria psiquiatrica
	//--------------------------------------------------------------------------------------
	DbSelectArea("BD6")
	DbSetOrder(1) //BD6_FILIAL+BD6_OPEUSR+BD6_CODEMP+BD6_MATRIC+BD6_TIPREG+BD6_DIGITO+BD6_ANOPAG+BD6_MESPAG+BD6_CODPRO
	BD6->(dbSeek(xFilial("BD6")+cChave))

	While !EOF() .And. cChave == BD6->(BD6_CODOPE + BD6_CODLDP + BD6_CODPEG + BD6_NUMERO + BD6_ORIMOV)

		cSQLCop := " SELECT BVM.BVM_PERCOP PERC, BVM.BVM_VALCOP VALOR "
		cSQLCop += "   FROM " + RetSqlName("BFG") + " BFG "
		cSQLCop += "      , " + RetSqlName("BVM") + " BVM "
		cSQLCop += "  WHERE BFG.BFG_FILIAL = '" + xFilial("BFG") + "' "
		cSQLCop += "    AND BVM.BVM_FILIAL = '" + xFilial("BVM") + "' "
		cSQLCop += "    AND BFG.BFG_CODINT = BVM.BVM_CODINT "
		cSQLCop += "    AND BFG.BFG_CODEMP = BVM.BVM_CODEMP "
		cSQLCop += "    AND BFG.BFG_MATRIC = BVM.BVM_MATRIC "
		cSQLCop += "    AND BFG.BFG_TIPREG = BVM.BVM_TIPREG "
		cSQLCop += "    AND BFG.BFG_CODPAD = BVM.BVM_CODPAD "
		cSQLCop += "    AND BFG.BFG_CODPSA = BVM.BVM_CODPSA "
		cSQLCop += "    AND BFG.BFG_BENUTL = '1'        "
		cSQLCop += "    AND BFG.BFG_CODINT = '" + BD6->BD6_CODOPE + "' "
		cSQLCop += "    AND BFG.BFG_CODEMP = '" + BD6->BD6_CODEMP + "'"
		cSQLCop += "    AND BFG.BFG_MATRIC = '" + BD6->BD6_MATRIC + "'"
		cSQLCop += "    AND BFG.BFG_TIPREG = '" + BD6->BD6_TIPREG + "'"
		cSQLCop += "    AND BVM.BVM_CODPAD = '" + BD6->BD6_CODPAD + "'"
		cSQLCop += "    AND BVM.BVM_CODPSA = '" + BD6->BD6_CODPRO + "'"
		cSQLCop += "    AND ( ('" + DTOS(BD6->BD6_DATPRO) + "' BETWEEN BVM.BVM_VIGDE AND BVM.BVM_VIGATE AND BVM.BVM_VIGATE <> ' ') OR "
		cSQLCop += "          ('" + DTOS(BD6->BD6_DATPRO) + "' >= BVM.BVM_VIGDE  AND BVM.BVM_VIGATE = ' ')  OR "
		cSQLCop += "          ('" + DTOS(BD6->BD6_DATPRO) + "' <= BVM.BVM_VIGATE AND BVM.BVM_VIGDE = ' ')  OR "
		cSQLCop += "          (BVM.BVM_VIGATE = ' ' AND BVM.BVM_VIGDE = ' ')  ) "
		cSQLCop += "    AND BFG.D_E_L_E_T_ = ' ' "
		cSQLCop += "    AND BVM.D_E_L_E_T_ = ' ' "

		If Select(cAliQry2)>0
			(cAliQry2)->(DbCloseArea())
		EndIf

		DbUseArea(.T.,"TopConn",TcGenQry(,,cSQLCop),cAliQry2,.T.,.T.)

		DbSelectArea(cAliQry2)

		If !((cAliQry2)->(EOF()))

			If (cAliQry2)->PERC <> 0 //Percentual

				_nPerc 	:= (cAliQry2)->PERC
				_nVlrPf	:= BD6->BD6_VLRBPF * (_nPerc/100)

			Else //Valor

				_nPerc 	:= 0
				_nVlrPf	:= (cAliQry2)->VALOR * BD6->BD6_QTDPRO

			EndIf

			//----------------------------------
			//Atualizando o valor correto BD6
			//----------------------------------
			RecLock("BD6", .F.)

			BD6->BD6_PERCOP 	:= _nPerc
			BD6->BD6_VLRPF 		:= _nVlrPf

			//-----------------------------------------------------------------------------------------------------
			//Angelo Henrique - Data:11/01/2017
			//-----------------------------------------------------------------------------------------------------
			//Em algum momento antes de chegar neste ponto o protheus estava calculando o valor incorreto 
			//para o campo Total PF, com base no entendimento o campo BD6_VLRPF e BD6_VLRTPF devem possuir
			//o mesmo valor quando ocorre este tipo de parametrização;
			//Ex: Hideo Goto - matrícula: 00010001037746009, tem liminar judicial
			//-----------------------------------------------------------------------------------------------------
			BD6->BD6_VLRTPF 	:= _nVlrPf

			BD6->(MsUnLock())
					
		Endif
		
		BD6->(DbSkip()) //Angelo Henrique - Data:19/04/2017

	EndDo

	//---------------------------------------------------------------------------
	//Angelo Henrique - Data: 11/07/2016
	//---------------------------------------------------------------------------
	//Conforme alinhamento com Márcia e Élina
	//Solicitação encaminhada por Dr José Paulo, o percentual de coparticipação
	//deverá contemplar a taxa de pagamento. Processo de Reciprocidade
	//---------------------------------------------------------------------------
	/*
	** 'Marcela Coimbra - Retirar de produção - 11/11/2016' **  

	If .F.

	DbSelectArea("BD6")
	DbSetOrder(1) //BD6_FILIAL+BD6_OPEUSR+BD6_CODEMP+BD6_MATRIC+BD6_TIPREG+BD6_DIGITO+BD6_ANOPAG+BD6_MESPAG+BD6_CODPRO
	BD6->(dbSeek(xFilial("BD6")+cChave))

	While !EOF() .And. cChave == BD6->(BD6_CODOPE + BD6_CODLDP + BD6_CODPEG + BD6_NUMERO + BD6_ORIMOV)

	If BD6->BD6_VLTXPG > 0

	//------------------------------------------------------
	//Atualizando o valor correto de coparticipação da BD6
	//quando possuir taxa de pagamento
	//------------------------------------------------------
	RecLock("BD6", .F.)

	_nValRpf := BD6->BD6_VLRPF + ((BD6->BD6_VLTXPG * BD6->BD6_PERCOP) / 100)

	BD6->BD6_VLRPF 	:= _nValRpf
	BD6->BD6_VLRTPF := _nValRpf

	BD6->(MsUnLock())

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Atualizar os registros da BD7 conforme calculo da taxa      				 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

	_aAreBD7 := BD7->(GetArea())

	DbSelectArea("BD7")
	DbSetOrder(1) //BD7_FILIAL+BD7_CODOPE+BD7_CODLDP+BD7_CODPEG+BD7_NUMERO+BD7_ORIMOV+BD7_SEQUEN
	If DbSeek(xFilial("BD7")+BD6->(BD6_CODOPE + BD6_CODLDP + BD6_CODPEG + BD6_NUMERO + BD6_ORIMOV + BD6_SEQUEN))

	While BD6->(BD6_CODOPE+BD6_CODLDP+BD6_CODPEG+BD6_NUMERO+BD6_ORIMOV+BD6_SEQUEN) == BD7->(BD7_CODOPE+BD7_CODLDP+BD7_CODPEG+BD7_NUMERO+BD7_ORIMOV+BD7_SEQUEN) .And. !BD7->(Eof())

	_nValRpf := BD7->BD7_VLRTPF + ((BD7->BD7_VLTXPG * BD7->BD7_PERPF) / 100)

	BD7->(RecLock("BD7",.F.))

	BD7->BD7_VLRTPF 	:= _nValRpf

	BD7->(MsUnlock())

	BD7->(DbSkip())

	Enddo

	EndIf

	RestArea(_aAreBD7)

	EndIf

	BD6->(DbSkip())

	EndDo

	EndIf
	*/

	//---------------------------------------------------------------------------
	//Angelo Henrique - Data: 11/07/2016
	//---------------------------------------------------------------------------

	If Select(cAliQry2)>0
		(cAliQry2)->(DbCloseArea())
	EndIf

	//--------------------------------------------------------------------------------------
	//Fim - Angelo Henrique - Data:06/11/2015
	//--------------------------------------------------------------------------------------
	RestArea(aAreaBE4)
	RestArea(aAreaBD5)
	RestArea(aAreaBD6)
	RestArea(aAreaBD7)
	RestArea(aAreaBR8)
	RestArea(aArea)

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ ProxSeq  ³ Autor ³ Thiago Machado Correa ³ Data ³ 08/04/05 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Retorna o proximo numero disponivel                        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ Unimed Tubarao		                                      ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ProxSeq(cCodOpe, cCodLdp, cCodPeg, cNumero, cOriMov)

	Local nCont := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

	Local cRet := ""
	Local aAreaBD6 := BD6->(GetArea())

	BD6->(DbSetOrder(1))
	BD6->(dbSeek(xFilial("BD6")+cCodOpe+cCodLdp+cCodPeg+cNumero+cOriMov+"999",.T.))
	BD6->(DbSkip(-1))

	If BD6->(BD6_FILIAL+BD6_CODOPE+BD6_CODLDP+BD6_CODPEG+BD6_NUMERO+BD6_ORIMOV) == (xFilial("BD6")+cCodOpe+cCodLdp+cCodPeg+cNumero+cOriMov)
		cRet := Strzero(Val(BD6->BD6_SEQUEN)+1,3)
	Else
		cRet := StrZero(1,3)
	Endif

	RestArea(aAreaBD6)

Return cRet


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³GrvVlrPag ºAutor  ³Microsiga           º Data ³  17/12/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function GrvVlrPag()
	Local aBD6	:= BD6->(GetArea())
	Local aBAU	:= BAU->(GetArea())
	Local aBA8	:= BA8->(GetArea())
	Local aBD4	:= BD4->(GetArea())
	Local aBD7	:= BD7->(GetArea())
	Local cPadInt	:= ""
	Local cRegAte	:= ""
	Local dDatPro	:= BD6->BD6_DATPRO
	Local cHorPro	:= BD6->BD6_HORPRO
	Local cPadCon	:= Iif(BD6->BD6_ORIMOV=="2",BE4->BE4_PADCON,"")
	Local aRdas		:= {}
	Local nInd		:= 0
	Local aRetFun	:= {}
	Local aDadUsr	:= PLSGETUSR()
	Local lCompRea	:= .F.
	Local nVlrAnt	:= 0
	Local nVlrNovo	:= 0
	Local aAux		:= {}
	Local cChave	:= ""
	Local nPerPac	:= 0
	Local nVlrPgBD7	:= 0
	Local aCri		:= {}


	aadd(aRdas,{"REA",;
		BD6->BD6_CODRDA,;
		BD6->BD6_CODLOC,;
		BD6->BD6_CODESP,;
		0,;
		Posicione("BAU",1,xFilial("BAU")+BD6->BD6_CODRDA,"BAU_TIPPRE"),;
		0,;
		0})

	If BD6->BD6_ORIMOV == "2"
		cPadInt := BE4->BE4_PADINT
		cRegAte := "1"
	Else
		cRegAte := IF(PLSUSRINTE(BD6->(BD6_OPEUSR+BD6_CODEMP+BD6_MATRIC+BD6_TIPREG+BD6_DIGITO),dDatPro,cHorPro),"1","2")
	Endif

	If Empty(dDatPro)
		If BD6->BD6_ORIMOV == "2"
			dDatPro := BD5->BD5_DATPRO
		Else
			dDatPro := BE4->BE4_DATPRO
		Endif
	Endif

	If Empty(cHorPro)
		If BD6->BD6_ORIMOV == "2"
			cHorPro := BD5->BD5_HORPRO
		Else
			cHorPro := BE4->BE4_HORPRO
		Endif
	Endif

	BD4->(DbSetOrder(2)) //BD4_FILIAL+BD4_CODPRO+BD4_CODTAB+BD4_CODIGO    

	//----------------------------------------------------------------------------
	//Angelo Henrique - data:29/03/2018
	//----------------------------------------------------------------------------
	//Projeto Otimização da rotina - Mudança de Fase 
	//If BD4->(dbSeek(xFilial("BD4")+BD6->BD6_CODPRO))
	//----------------------------------------------------------------------------
	If BD4->(dbSeek(xFilial("BD4")+BD6->(BD6_CODPRO+BD6_CODOPE+BD6_CODTAB)))
		lCompRea := Iif(BD4->BD4_CODIGO $ "REA,RE1,VTX,VDI,VMT,VMD",.T.,.F.)
	Endif

	
	If BD6->BD6_ORIMOV == "2"
		cPadInt := BE4->BE4_PADINT
		cRegAte := "1"
	Else
		cRegAte := IF(PLSUSRINTE(BD6->(BD6_OPEUSR+BD6_CODEMP+BD6_MATRIC+BD6_TIPREG+BD6_DIGITO),dDatPro,cHorPro),"1","2")
	Endif
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Utilizar funcao padrao caso comp. pacote possua itens HM...				 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	aValor := PLSCALCEVE(BD6->BD6_CODPAD,BD6->BD6_CODPRO,BD6->BD6_MESPAG,BD6->BD6_ANOPAG,;
		PLSINTPAD(),BD6->BD6_CODRDA,BD6->BD6_CODESP,BD6->BD6_SUBESP,;
		BD6->BD6_CODLOC,BD6->BD6_QTDPRO,dDatPro,aDadUsr[48],cPadInt,cRegAte,BD6->BD6_VLRAPR,aDadUsr,cPadCon,;
		{},nil,nil,nil,nil,cHorPro,aRdas,nil,BD6->BD6_PROREL,BD6->BD6_PRPRRL,; //1o parametro = aQtdPer
	{},nil,dDatPro,cHorPRo,{},BD6->BD6_TIPGUI,.F.,BD6->BD6_VLRAPR,{},nil,; //1o parametro = aValAcu / 5o = aUnidsBlo / 9o = aVlrBloq
	.F.,0,BD6->BD6_REGPAG,BD6->BD6_REGCOB) //1o- lCirurgico / 2o - nPerVia

	For nInd := 1 To Len(aValor[1])
		If ! Empty(aValor[1][nInd][4])
			aadd(aCri,{aValor[1][nInd][6],aValor[1][nInd][4],"","","",BD6->BD6_CODPAD,BD6->BD6_CODPRO,BD6->BD6_SEQUEN})
		Endif
	Next

	//Raios
	If Len(aCri) > 0
		PLSCRIGEN(aCri,{ {"aValor1,x,6","@C",30},{"aValor1,x,4","@C",30},{"cCodPad","@C",50},{"cCodPro","@C",50},{"cSequen","@C",50}},"Criticas...",.T.)
	Endif

	//Deverao ser modificados os 2 retornos seguintes:
	If lCompRea

		nPerPac := BD6->BD6_YPERPC
		aArBD6 := BD6->(GetArea())
		BD6->(DbSetOrder(1)) //BD6_FILIAL+BD6_CODOPE+BD6_CODLDP+BD6_CODPEG+BD6_NUMERO+BD6_ORIMOV+BD6_SEQUEN+BD6_CODPAD+BD6_CODPRO
		cChave := BD6->(BD6_CODOPE+BD6_CODLDP+BD6_CODPEG+BD6_NUMERO+BD6_ORIMOV+BD6_YSEQPC)

		BD6->(dbSeek(xFilial("BD6")+cChave))
		nVlrAnt		:= BD6->BD6_YVLRPC
		nVlrNovo 	:= U_PerPacote(nVlrAnt,nPerPac)

		RestArea(aArBD6)

		aValor[2]		:= nVlrNovo
		aValor[4]		:= "PAC"

	Endif

	BD6->(RecLock("BD6",.F.))
	BD6->BD6_VLRPAG := aValor[2]
	BD6->BD6_CODTAB := aValor[3]
	BD6->BD6_ALIATB := aValor[4]
	BD6->BD6_PERHES := aValor[5]
	BD6->BD6_VLRMAN := aValor[2]
	BD6->BD6_VLRBPR := aValor[2]
	//BD6->BD6_VALORI := BD6->BD6_VLRAPR * BD6->BD6_QTDPRO
	
	//BD6->BD6_YVLRPC	:= aValor[2]
	BD6->(MsUnLock())

	If aValor[2] > 0
		aAux     := aClone(aValor[1])
	Endif

	If Len(aValor[1]) > 0
		aRetFun := PLSA720BD7(aAux,aValor[2],Iif(BD6->BD6_CODLDP == "0000","1","2"),0,{},0,NIL,0)

	Else
		aRetFun := PLSA720BD7({},aValor[2],Iif(BD6->BD6_CODLDP == "0000","1","2"),0,{},0,NIL,0)
	Endif

	If lCompRea

		BD7->(dbSeek(xFilial("BD7")+BD6->(BD6_CODOPE+BD6_CODLDP+BD6_CODPEG+BD6_NUMERO+BD6_ORIMOV+BD6_SEQUEN)))
		While ! BD7->(Eof()) .And. BD7->(BD7_CODOPE+BD7_CODLDP+BD7_CODPEG+BD7_NUMERO+BD7_ORIMOV+BD7_SEQUEN)==BD6->(BD6_CODOPE+BD6_CODLDP+BD6_CODPEG+BD6_NUMERO+BD6_ORIMOV+BD6_SEQUEN)

			If BD7->BD7_CODUNM $ "REA,RE1,VTX,VDI,VMT,VMD"

				nVlrPgBD7 := (aValor[2]*BD7->BD7_PERCEN)/100

				BD7->(RecLock("BD7",.F.))
				BD7->BD7_VLRPAG := nVlrPgBD7
				BD7->BD7_COEFUT := nVlrPgBD7
				BD7->BD7_VLRBPR := nVlrPgBD7
			    BD7->BD7_VLRMAN := nVlrPgBD7
				BD7->BD7_ALIAUS := "PAC"
				//BD7->BD7_VALORI := nVlrPgBD7
				BD7->(MsUnlock())

			Endif
			BD7->(DbSkip())

		Enddo
	Endif

	RestArea(aBD6)
	RestArea(aBAU)
	RestArea(aBA8)
	RestArea(aBD4)
	RestArea(aBD7)

Return Nil
