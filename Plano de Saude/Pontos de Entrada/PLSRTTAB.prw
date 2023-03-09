#include "PROTHEUS.CH"
#include 'TOTVS.CH'
#include 'TOPCONN.CH'

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³PLSRTTAB  ºAutor  ³Microsiga           º Data ³  15/07/09   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Modificar a tabela do reembolso caso seja relativa ao OPME. º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function PLSRTTAB

//----------------------------- Define variaveis da rotina -----------------------------//
// ParamIXB[1]	Caracter	Codigo do Tipo de Tabela                     	 			//
// ParamIXB[2]	Caracter	Alias da Tabela                    				 			//
// ParamIXB[3]	Caracter	Codigo Tipo Tabela                    			 			//
// ParamIXB[4]	Caracter	Codigo do Procedimento                    		 			//
// ParamIXB[5]	Data		Data base para checagem                    			 		//
// ParamIXB[6]	Caracter	Codigo da Operadora                    			 			//
// ParamIXB[7]	Caracter	Codigo da Rede de Atendimento                    			//
// ParamIXB[8]	Caracter	Codigo da especialidade que a RDA executou					//
// ParamIXB[9]	Caracter	Codigo da sub-especialidade que a RDA executou				//
// ParamIXB[10]	Caracter	Codigo do Local de Atendimento da RDA        				//
// ParamIXB[11]	Data		Data do Procedimento                    		 			//
// ParamIXB[12]	Caracter	1-Pagar / 2-Receber                    		 				//
// ParamIXB[13]	Caracter	Operadora Original                    		 				//
// ParamIXB[14]	Caracter	Código do Produto                    		 				//
// ParamIXB[15]	Caracter	1-Inclusão Nota via atendimento ou dig. conta  / 2-PTU		//
// ParamIXB[16]	Caracter	1-Inclusão de evento / 2-Valorização         				//
// ParamIXB[17]	Lógico		Reembolso                    					 			//
//--------------------------------------------------------------------------------------//

Local aArea			:= GetArea()
Local aAreaBA3 		:= BA3->(GetArea())

Local _cCodTab		:= paramixb[1]
Local _cAlias		:= paramixb[2]
Local _cCodPad		:= paramixb[3]
Local _cCodPro		:= paramixb[4]

Local aDadUsr		:= PLSGETUSR()
Local aTbReem		:= {}
Local cTpEve		:= ""
Local cAcomod		:= ""
Local dDatPro		:= StoD("")

if AllTrim( GetNewPar("MV_XLOGINT", '0') ) == '1' .and. FunName() == "PLSA092"
	U_LogMatInt(M->BE4_USUARI, M->BE4_NOMUSR, "PLSRTTAB - 1")
endif

if Alltrim(FunName()) $ "PLSA001|PLSA001A"		// reembolso

	if len(aDadUsr) > 0

		if AllTrim(funname()) == "PLSA001A"

			cTpEve	:= BOW->BOW_XTPEVE
			cAcomod	:= BOW->BOW_PADINT
			dDatPro	:= BOW->BOW_XDTEVE
		
		endif

		// BUSCAR PARAMETRIZAÇÃO DE REEMBOLSO (PDC -> B7T)
		aTbReem		:= U_RtTbReem(aDadUsr, "", _cCodPad, _cCodPro, cTpEve, cAcomod, dDatPro)

		if aTbReem[1] <> 0

			if !empty(aTbReem[2][1])

				_cAlias		:= "BD4"
				_cCodTab	:= aTbReem[2][1]

			endif
		
		endif

	endif

endif

if AllTrim( GetNewPar("MV_XLOGINT", '0') ) == '1' .and. FunName() == "PLSA092"
	U_LogMatInt(M->BE4_USUARI, M->BE4_NOMUSR, "PLSRTTAB - 2")
endif

RestArea(aAreaBA3)
RestArea(aArea)

return({_cCodTab,_cAlias})



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ RtTbReem  ºAutor  ³ Fred O C Jr       º Data ³  05/05/22   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Buscar parametrização de pagamento do Reembolso			  º±±
±±º          ³ 									                          º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function RtTbReem(aUsuario, cGrpCob, cCodPad, cCodPro, cTpEve, cAcomod, dDatPro)

Local aRet			:= {0, {"", 0, 0, 0, 0, 0, 0}}
Local cQuery		:= ""
Local cAliasQry		:= GetNextAlias()

Default aUsuario	:= {}
Default cGrpCob		:= ""
Default cCodPad		:= ""
Default cCodPro		:= ""
Default cTpEve		:= "1"		// TDE de HM / Eventos
Default cAcomod		:= "2"		// Coletivo / Enfermaria
Default dDatPro		:= dDataBase

if len(aUsuario) > 0

	if empty(cGrpCob)
		cGrpCob	:= U_BuscaGrupCob(PLSINTPAD(), cCodPad, cCodPro)
	endif

	cAcomod	:= AllTrim(cAcomod)

	cQuery := " select     case when (PDC_CODEMP <> ' ' and PDC_NUMCON <> ' ' and PDC_SUBCON <> ' ' and PDC_CODPLA <> ' ' and PDC_CODGRU <> ' ') then 1"  +;
					" else case when (PDC_CODEMP <> ' ' and PDC_NUMCON <> ' ' and PDC_SUBCON <> ' ' and PDC_CODPLA <> ' ' and PDC_CODGRU =  ' ') then 2"  +;
					" else case when (PDC_CODEMP <> ' ' and PDC_NUMCON <> ' ' and PDC_SUBCON <> ' ' and PDC_CODPLA =  ' ' and PDC_CODGRU <> ' ') then 3"  +;
					" else case when (PDC_CODEMP <> ' ' and PDC_NUMCON <> ' ' and PDC_SUBCON <> ' ' and PDC_CODPLA =  ' ' and PDC_CODGRU =  ' ') then 4"  +;
					" else case when (PDC_CODEMP <> ' ' and PDC_NUMCON <> ' ' and PDC_SUBCON =  ' ' and PDC_CODPLA <> ' ' and PDC_CODGRU <> ' ') then 5"  +;
					" else case when (PDC_CODEMP <> ' ' and PDC_NUMCON <> ' ' and PDC_SUBCON =  ' ' and PDC_CODPLA <> ' ' and PDC_CODGRU =  ' ') then 6"  +;
					" else case when (PDC_CODEMP <> ' ' and PDC_NUMCON <> ' ' and PDC_SUBCON =  ' ' and PDC_CODPLA =  ' ' and PDC_CODGRU <> ' ') then 7"  +;
					" else case when (PDC_CODEMP <> ' ' and PDC_NUMCON <> ' ' and PDC_SUBCON =  ' ' and PDC_CODPLA =  ' ' and PDC_CODGRU =  ' ') then 8"  +;
					" else case when (PDC_CODEMP <> ' ' and PDC_NUMCON =  ' ' and PDC_SUBCON =  ' ' and PDC_CODPLA <> ' ' and PDC_CODGRU <> ' ') then 9"  +;
					" else case when (PDC_CODEMP <> ' ' and PDC_NUMCON =  ' ' and PDC_SUBCON =  ' ' and PDC_CODPLA <> ' ' and PDC_CODGRU =  ' ') then 10" +;
					" else case when (PDC_CODEMP <> ' ' and PDC_NUMCON =  ' ' and PDC_SUBCON =  ' ' and PDC_CODPLA =  ' ' and PDC_CODGRU <> ' ') then 11" +;
					" else case when (PDC_CODEMP <> ' ' and PDC_NUMCON =  ' ' and PDC_SUBCON =  ' ' and PDC_CODPLA =  ' ' and PDC_CODGRU =  ' ') then 12" +;
					" else case when (PDC_CODEMP =  ' ' and PDC_NUMCON =  ' ' and PDC_SUBCON =  ' ' and PDC_CODPLA <> ' ' and PDC_CODGRU <> ' ') then 13" +;
					" else case when (PDC_CODEMP =  ' ' and PDC_NUMCON =  ' ' and PDC_SUBCON =  ' ' and PDC_CODPLA <> ' ' and PDC_CODGRU =  ' ') then 14" +;
					" else case when (PDC_CODEMP =  ' ' and PDC_NUMCON =  ' ' and PDC_SUBCON =  ' ' and PDC_CODPLA =  ' ' and PDC_CODGRU <> ' ') then 15" +;
					" else case when (PDC_CODEMP =  ' ' and PDC_NUMCON =  ' ' and PDC_SUBCON =  ' ' and PDC_CODPLA =  ' ' and PDC_CODGRU =  ' ') then 16" +;
					" else 99 end end end end end end end end end end end end end end end end as REGRA,"
	cQuery +=	" 1 as TP_TABELA,"
	cQuery +=	" " + iif(cTpEve  == '1', "PDC_TABREE", "PDC_PTANES") + " as TABELA,"
	cQuery +=	" " + iif(cAcomod == '1', "PDC_FATMUL", "PDC_FTCOLE") + " as FT_MULT,"
	cQuery +=	" PDC_BANDA as BANDA,"
	cQuery +=	" PDC_VALUS as VALOR_US,"
	cQuery +=	" PDC_UCO   as UCO,"
	cQuery +=	" PDC_FILME as FILME"
	cQuery += " from " + RetSqlName("PDC") + " PDC"
	cQuery +=	" inner join " + RetSqlName("BA8") + " BA8"
	cQuery +=	  " on (    BA8_FILIAL = '" + xFilial("BA8") + "'"
	cQuery +=		  " and BA8_CODTAB = '" + PlsIntPad() + "'||" + iif(cTpEve == '1', "PDC_TABREE", "PDC_PTANES")
	cQuery +=		  " and BA8_CDPADP = '" + cCodPad + "'"
	cQuery +=		  " and BA8_CODPRO = '" + cCodPro + "')"
	cQuery += " where PDC.D_E_L_E_T_ = ' ' and BA8.D_E_L_E_T_ = ' '"
	cQuery +=	" and PDC_FILIAL = '" + xFilial("PDC") + "'"
	cQuery +=	" and (PDC_CODEMP  = ' ' or PDC_CODEMP = '" + SubStr(aUsuario[2],5,4) + "')"
	cQuery +=	" and ((PDC_NUMCON = ' ' and PDC_VERCON = ' ') or (PDC_NUMCON = '" + aUsuario[9]  + "' and PDC_VERCON = '" + aUsuario[39] + "'))"
	cQuery +=	" and ((PDC_SUBCON = ' ' and PDC_VERSUB = ' ') or (PDC_SUBCON = '" + aUsuario[41] + "' and PDC_VERSUB = '" + aUsuario[42] + "'))"
	cQuery +=	" and ((PDC_CODPLA = ' ' and PDC_VERPLA = ' ') or (PDC_CODPLA = '" + aUsuario[11] + "' and PDC_VERPLA = '" + aUsuario[12] + "'))"
	cQuery +=	" and (PDC_CODGRU  = ' ' or PDC_CODGRU = '" + cGrpCob + "')"
	cQuery +=	" and (PDC_VIGINI <> ' ' and PDC_VIGINI <= '" +  DtoS(dDatPro) + "')"
	cQuery +=	" and (PDC_VIGFIN  = ' ' or (PDC_VIGFIN <> ' ' and PDC_VIGFIN >= '" + DtoS(dDatPro) + "'))"
	cQuery +=	" and " + iif(cTpEve == '1', "PDC_TABREE", "PDC_PTANES") + " <> ' '"

	if cTpEve  == '1'

		cQuery += " union all"
		cQuery += " select     case when (PDC_CODEMP <> ' ' and PDC_NUMCON <> ' ' and PDC_SUBCON <> ' ' and PDC_CODPLA <> ' ' and PDC_CODGRU <> ' ') then 1"  +;
						" else case when (PDC_CODEMP <> ' ' and PDC_NUMCON <> ' ' and PDC_SUBCON <> ' ' and PDC_CODPLA <> ' ' and PDC_CODGRU =  ' ') then 2"  +;
						" else case when (PDC_CODEMP <> ' ' and PDC_NUMCON <> ' ' and PDC_SUBCON <> ' ' and PDC_CODPLA =  ' ' and PDC_CODGRU <> ' ') then 3"  +;
						" else case when (PDC_CODEMP <> ' ' and PDC_NUMCON <> ' ' and PDC_SUBCON <> ' ' and PDC_CODPLA =  ' ' and PDC_CODGRU =  ' ') then 4"  +;
						" else case when (PDC_CODEMP <> ' ' and PDC_NUMCON <> ' ' and PDC_SUBCON =  ' ' and PDC_CODPLA <> ' ' and PDC_CODGRU <> ' ') then 5"  +;
						" else case when (PDC_CODEMP <> ' ' and PDC_NUMCON <> ' ' and PDC_SUBCON =  ' ' and PDC_CODPLA <> ' ' and PDC_CODGRU =  ' ') then 6"  +;
						" else case when (PDC_CODEMP <> ' ' and PDC_NUMCON <> ' ' and PDC_SUBCON =  ' ' and PDC_CODPLA =  ' ' and PDC_CODGRU <> ' ') then 7"  +;
						" else case when (PDC_CODEMP <> ' ' and PDC_NUMCON <> ' ' and PDC_SUBCON =  ' ' and PDC_CODPLA =  ' ' and PDC_CODGRU =  ' ') then 8"  +;
						" else case when (PDC_CODEMP <> ' ' and PDC_NUMCON =  ' ' and PDC_SUBCON =  ' ' and PDC_CODPLA <> ' ' and PDC_CODGRU <> ' ') then 9"  +;
						" else case when (PDC_CODEMP <> ' ' and PDC_NUMCON =  ' ' and PDC_SUBCON =  ' ' and PDC_CODPLA <> ' ' and PDC_CODGRU =  ' ') then 10" +;
						" else case when (PDC_CODEMP <> ' ' and PDC_NUMCON =  ' ' and PDC_SUBCON =  ' ' and PDC_CODPLA =  ' ' and PDC_CODGRU <> ' ') then 11" +;
						" else case when (PDC_CODEMP <> ' ' and PDC_NUMCON =  ' ' and PDC_SUBCON =  ' ' and PDC_CODPLA =  ' ' and PDC_CODGRU =  ' ') then 12" +;
						" else case when (PDC_CODEMP =  ' ' and PDC_NUMCON =  ' ' and PDC_SUBCON =  ' ' and PDC_CODPLA <> ' ' and PDC_CODGRU <> ' ') then 13" +;
						" else case when (PDC_CODEMP =  ' ' and PDC_NUMCON =  ' ' and PDC_SUBCON =  ' ' and PDC_CODPLA <> ' ' and PDC_CODGRU =  ' ') then 14" +;
						" else case when (PDC_CODEMP =  ' ' and PDC_NUMCON =  ' ' and PDC_SUBCON =  ' ' and PDC_CODPLA =  ' ' and PDC_CODGRU <> ' ') then 15" +;
						" else case when (PDC_CODEMP =  ' ' and PDC_NUMCON =  ' ' and PDC_SUBCON =  ' ' and PDC_CODPLA =  ' ' and PDC_CODGRU =  ' ') then 16" +;
						" else 99 end end end end end end end end end end end end end end end end as REGRA,"
		cQuery +=	" 2 as TP_TABELA,"
		cQuery +=	" PDC_TBDESP as TABELA,"
		cQuery +=	" " + iif(cAcomod == '1', "PDC_FATMUL", "PDC_FTCOLE") + " as FT_MULT,"
		cQuery +=	" PDC_BANDA as BANDA,"
		cQuery +=	" PDC_VALUS as VALOR_US,"
		cQuery +=	" PDC_UCO   as UCO,"
		cQuery +=	" PDC_FILME as FILME"
		cQuery += " from " + RetSqlName("PDC") + " PDC"
		cQuery +=	" inner join " + RetSqlName("BA8") + " BA8"
		cQuery +=	  " on (    BA8_FILIAL = '" + xFilial("BA8") + "'"
		cQuery +=		  " and BA8_CODTAB = '" + PlsIntPad() + "'||PDC_TBDESP"
		cQuery +=		  " and BA8_CDPADP = '" + cCodPad + "'"
		cQuery +=		  " and BA8_CODPRO = '" + cCodPro + "')"
		cQuery += " where PDC.D_E_L_E_T_ = ' ' and BA8.D_E_L_E_T_ = ' '"
		cQuery +=	" and PDC_FILIAL = '" + xFilial("PDC") + "'"
		cQuery +=	" and (PDC_CODEMP  = ' ' or PDC_CODEMP = '" + SubStr(aUsuario[2],5,4) + "')"
		cQuery +=	" and ((PDC_NUMCON = ' ' and PDC_VERCON = ' ') or (PDC_NUMCON = '" + aUsuario[9]  + "' and PDC_VERCON = '" + aUsuario[39] + "'))"
		cQuery +=	" and ((PDC_SUBCON = ' ' and PDC_VERSUB = ' ') or (PDC_SUBCON = '" + aUsuario[41] + "' and PDC_VERSUB = '" + aUsuario[42] + "'))"
		cQuery +=	" and ((PDC_CODPLA = ' ' and PDC_VERPLA = ' ') or (PDC_CODPLA = '" + aUsuario[11] + "' and PDC_VERPLA = '" + aUsuario[12] + "'))"
		cQuery +=	" and (PDC_CODGRU  = ' ' or PDC_CODGRU = '" + cGrpCob + "')"
		cQuery +=	" and (PDC_VIGINI <> ' ' and PDC_VIGINI <= '" +  DtoS(dDatPro) + "')"
		cQuery +=	" and (PDC_VIGFIN  = ' ' or (PDC_VIGFIN <> ' ' and PDC_VIGFIN >= '" + DtoS(dDatPro) + "'))"
		cQuery +=	" and PDC_TBDESP <> ' '"

	endif

	cQuery += " order by REGRA, TP_TABELA"

	TcQuery cQuery New Alias (cAliasQry)

	if (cAliasQry)->(!EOF())						// pego somente o primeiro registro retornado (regra mais especifica já vem ordenada)

		aRet[1]		:= 1																	// Encontrou regra de reembolso na PDC
		aRet[2][1]	:= (cAliasQry)->TABELA													// TDE Reemb.
		aRet[2][2]	:= (cAliasQry)->FT_MULT													// Fator multiplicador
		aRet[2][3]	:= (cAliasQry)->VALOR_US												// Valor US
		aRet[2][4]	:= (cAliasQry)->UCO														// UCO
		aRet[2][5]	:= (cAliasQry)->FILME													// Filme
		aRet[2][6]	:= (cAliasQry)->BANDA													// Banda
		aRet[2][7]	:= iif(cTpEve == '2', 2, iif((cAliasQry)->TP_TABELA == 1, 1, 3 ) )		// 1=HM | 2=PA | 3 Demais eventos
	
	endif
	(cAliasQry)->(DbCloseArea())

	if aRet[1] == 0

		//Busca Tabela de Reembolso na Operadora
		B7T->(DbSetOrder(1))	// B7T_FILIAL+B7T_CODINT+B7T_CODPAD+B7T_TABREE+B7T_TABPRE
		if B7T->(DbSeek(xFilial("B7T") + PLSINTPAD() + cCodPad)) .and. !empty(cCodPad)

			while B7T->(!EOF()) .and. B7T->(B7T_CODINT+B7T_CODPAD) == (PLSINTPAD() + cCodPad)

				BA8->(DbSetOrder(1))	// BA8_FILIAL+BA8_CODTAB+BA8_CDPADP+BA8_CODPRO
				if BA8->(DbSeek(xFilial("BA8") + B7T->(B7T_CODINT+B7T_TABREE) + cCodPad + cCodPro ))

					BD4->(DbSetOrder(1))	// BD4_FILIAL+BD4_CODTAB+BD4_CDPADP+BD4_CODPRO+BD4_CODIGO+DTOS(BD4_VIGINI)
					if BD4->(DbSeek(xFilial("BD4") + BA8->(BA8_CODTAB+BA8_CDPADP+BA8_CODPRO) ))

						while BD4->(!EOF()) .and. BD4->(BD4_CODTAB+BD4_CDPADP+BD4_CODPRO) == BA8->(BA8_CODTAB+BA8_CDPADP+BA8_CODPRO)

							if !empty(BD4->BD4_VIGINI) .and. BD4->BD4_VIGINI <= dDatPro .and. (empty(BD4->BD4_VIGFIM) .or. (!empty(BD4->BD4_VIGFIM) .and. BD4->BD4_VIGFIM >= dDatPro)) .and. BD4->BD4_VALREF > 0

								aRet[1]		:= 2						// pegou regra nas tabelas de reembolso da operadora
								aRet[2][1]	:= B7T->B7T_TABREE			// TDE Reemb.
								aRet[2][7]	:= 4						// TDE Reemb. na Operadora

								exit

							endif

							BD4->(DbSkip())
						end

					endif

				endif

				B7T->(DbSkip())
			end

		endif

	endif

endif

return aRet
