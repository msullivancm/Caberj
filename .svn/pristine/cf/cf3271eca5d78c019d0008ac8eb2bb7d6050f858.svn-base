#include "PROTHEUS.CH"
#include "topconn.CH"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ PLSFATMP º Autor ³ Antonio de Pádua 	  º Data ³ 13/02/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Ponto de entrada para alterar Fator Multiplicador	      º±±
±±º          ³                                    					      º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ MP8                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function PLSFATMP

Local aArea			:= GetArea()

Local cCodPad		:= paramixb[1]		// Codigo tipo de procedimento
Local cCodPro		:= paramixb[2]		// Codigo do procedimento
//Local cCodInt		:= paramixb[3]		// Operadora padrao
Local cCodRDA		:= paramixb[4]		// Codigo da RDA
Local cCodEsp		:= paramixb[5]		// Codigo da Especialidade
Local cCodLoc		:= paramixb[6]		// Codigo do local de atendimento
//Local nQtd		:= paramixb[7]		// Quantidade
Local cPadInt		:= paramixb[8]		// Padrao de internacao vazio indica que eh guia de servico (nao vazio eh gih)
Local cRegAte		:= paramixb[9]		// Regime de atendimento
Local aDadUsr		:= paramixb[10]		// Matriz com diversos dados do usuario
//Local cPadCon		:= paramixb[11]		// Padrao de conforto
//Local lCobCoPart	:= paramixb[12]		// .T. Cobranca .F. Pagamento
//Local dDatCir		:= paramixb[13]		// Data
//Local cHorCir		:= paramixb[14]		// Hora
//Local cTipoGuia	:= paramixb[15]		// Tipo de Guia
//Local lCompra		:= paramixb[16]		// E um calculo para calcular uma compra de procedimentos .T. ou .F.
Local cConsFt		:= paramixb[17]		// Vai considerar o fator multiplicador??? 0=Nao ou 1=Sim
Local cCdProduto	:= paramixb[18]		// Codigo do produto do usuario
//Local cVrProduto	:= paramixb[19]		// Versao do produto do usuario
Local nFatMul		:= paramixb[20]		// Fator multiplicador encontrado pelo sistema com base em suas regras.

Local cMatric		:= aDadUsr[2]
Local dDatPro		:= StoD("")
Local cHorPro		:= ""
Local i				:= 0				// Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS
Local aRet1			:= {}
Local cTpEve		:= ""
Local cAcomod		:= ""

//Caso reembolso, utilizar fator multiplicador conforme parametrizado...
if Alltrim(FunName()) $ "PLSA001|PLSA001A"

	// Parametro base (considera fator - e pega fator da )
	cConsFt		:= "1"
	nFatMul		:= iif( M->B45_YFTREE <> 0, M->B45_YFTREE, 1 )
	
	if len(aDadUsr) > 0

		if AllTrim(funname()) == "PLSA001A"

			cTpEve	:= BOW->BOW_XTPEVE
			cAcomod	:= BOW->BOW_PADINT
			dDatPro	:= BOW->BOW_XDTEVE
		
		endif

		// BUSCAR PARAMETRIZAÇÃO DE REEMBOLSO (PDC -> ZZZ -> B7T)
		aTbReem		:= U_RtTbReem(aDadUsr, "", cCodPad, cCodPro, cTpEve, cAcomod, dDatPro)

		if aTbReem[1] <> 0

			if aTbReem[2][2] <> 0

				if M->B45_YFTREE <> 0 .and. M->B45_YFTREE <> aTbReem[2][2]

					if MsgYesNo("O fator de reembolso informado no cálculo está como: "	+ AllTrim(str(M->B45_YFTREE)) + Chr(13)+Chr(10)					  +;
								"Porém o parametrizado na Matriz de Reembolso é: "		+ AllTrim(str(aTbReem[2][2])) + Chr(13)+Chr(10) + Chr(13)+Chr(10) +;
								"Deseja substituir o atualmente informado pelo parametrizado na Matriz de Reembolso?"									  )
					
						nFatMul	:= aTbReem[2][2]

					endif
				
				else

					nFatMul	:= aTbReem[2][2]
				
				endif
			
			endif
		
		endif
	
	endif

	M->B45_YFTREE	:= nFatMul

else

	// Devido ao padrao do sistema repassar o parametro de forma errada, posicionar e buscar diretamente de BR8 (nao observa BD3)
	cConsFt := Posicione("BR8",1,xFilial("BR8")+cCodPad+cCodPro,"BR8_CONSFT")

	// O Fator Multiplicador sera considerado somente se o cConsFt for "1"
	if cConsFt == "1"

		// Determina o fator multiplicador, caso GS em internacao
		if empty(cPadInt)		// cPadInt vazio indica que eh guia de servico (nao vazio eh gih)

			dDatPro := iif( Empty(BD6->BD6_DATPRO), BD5->BD5_DATPRO, BD6->BD6_DATPRO)
			cHorPro	:= iif( Empty(BD6->BD6_HORPRO), BD5->BD5_HORPRO, BD6->BD6_HORPRO)

			if cRegAte == "1"  // cRegAte = "1" regime de internacao / "2" ambulatorial

				// Leonardo Portella - 30/09/14 - Inicio - Tratamento de condicao em que o PLSUSRINTE retorna logico
				aRet1		:= PLSUSRINTE(cMatric,dDatPro,cHorPro,.T.)

				// Esta internado e esta em apartamento
				l_FatMul	:= ( ValType(aRet1) == 'A' .and. len(aRet1) >= 1 .and. aRet1[1] .and. Alltrim(aRet1[6]) == "1" )

				if !l_FatMul

					aRet1 		:= PLSUSRINTE(cMatric,dDatPro,cHorPro,.T.,.T.)
					l_FatMul 	:= ( ValType(aRet1) == 'L' .and. aRet1 )

					if l_FatMul
						c_VarPadInt := BCL->BCL_ALIAS + "->" + BCL->BCL_ALIAS + "_PADINT"
						l_FatMul 	:= &(c_VarPadInt) == '1'								// Esta internado e esta em apartamento
					endif
				
				endif
				//Leonardo Portella - 30/09/14 - Fim

				if l_FatMul

					//Bianchini - 04/06/2014
					//INICIO - Problemas de COPART nos convenios que dobrava o que já estava em aprtamento. Tratamento pontual para RECIPROCIDADES
					if cEmpAnt == '01' .and. BD6->BD6_CODEMP $ ('0004|0009') .and. BD6->BD6_CONEMP <> '000000000022'
						nFatMul := 1
					//FIM
					else
						nFatMul := 2  // Linha que ja existia antes da modificacao de 04/06/2014
					endif
				
				endif
			
			endif
		
		endif

		// Conforme cadastro auxiliar, verificar regras e aplicar fat. diferente
		cSql := " SELECT *"
		cSql += " FROM " + RetSqlName("BYZ")
		cSql += " WHERE (BYZ_CODRDA = '"				+ cCodRda					+ "'"
		cSql +=		" OR BYZ_CODLOC = '"				+ cCodLoc					+ "'"
		cSql +=		" OR BYZ_CODESP = '"				+ cCodEsp					+ "'"
		cSql +=		" OR BYZ_NUMCON = '"				+ aDadUsr[9]				+ "'"
		CsQL +=		" OR BYZ_VERCON = '"				+ aDadUsr[12]				+ "'"
		cSql +=		" OR BYZ_SUBCON = '"				+ aDadUsr[41]				+ "'"
		cSql +=		" OR BYZ_VERSUB = '"				+ aDadUsr[42]				+ "'"
		cSql +=		" OR BYZ_CODPRO = '"				+ cCodPro					+ "'"
		cSql +=		" OR BYZ_CDPROD = '"				+ cCdProduto				+ "'"
		CsQL +=		" OR BYZ_MATVID = '"				+ aDadUsr[5]				+ "'"
		cSql +=		" OR BYZ_MATRIC = '"				+ Substr(aDadUsr[2],9,6)	+ "'"
		cSql +=		" OR SUBSTR(BYZ_REGATE,1,2) = '"	+ Substr(cRegAte,1,2)		+ "'"
		cSql +=		" OR BYZ_PADINT = '"				+ cPadInt					+ "'"
		cSql +=		" OR BYZ_CODPAD = '"				+ cCodPad					+ "')"
		cSql +=		" AND " + RetSQLName("BYZ") + ".D_E_L_E_T_ = ' '"
		cSql += " ORDER BY BYZ_CODESP||BYZ_CODRDA||BYZ_CODLOC||BYZ_REGATE||BYZ_PADINT||BYZ_CODPAD||BYZ_CODTDE||BYZ_CODPRO||BYZ_NUMCON||BYZ_VERCON||BYZ_SUBCON||BYZ_VERSUB||BYZ_CDPROD||BYZ_MATVID||BYZ_MATRIC DESC"
		
		TCQUERY cSQL NEW Alias "BYZA"

		while !BYZA->(EOF())

			aFtCmp := {}
			cIfCmp := ""
			
			aadd(aFtCmp, {BYZA->BYZ_CODESP, cCodEsp,					!Empty(BYZA->BYZ_CODESP)	})
			aadd(aFtCmp, {BYZA->BYZ_CODRDA, cCodRda,					!Empty(BYZA->BYZ_CODRDA)	})
			aadd(aFtCmp, {BYZA->BYZ_CODLOC, cCodLoc,					!Empty(BYZA->BYZ_CODLOC)	})
			aadd(aFtCmp, {BYZA->BYZ_REGATE, cRegAte,					!Empty(BYZA->BYZ_REGATE)	})
			aadd(aFtCmp, {BYZA->BYZ_PADINT, cPadInt,					!Empty(BYZA->BYZ_PADINT)	})
			aadd(aFtCmp, {BYZA->BYZ_CODPAD, cCodPad,					!Empty(BYZA->BYZ_CODPAD)	})
			aadd(aFtCmp, {BYZA->BYZ_CODPRO, cCodPro,					!Empty(BYZA->BYZ_CODPRO)	})
			aadd(aFtCmp, {BYZA->BYZ_NUMCON, aDadUsr[9],					!Empty(BYZA->BYZ_NUMCON)	})
			aadd(aFtCmp, {BYZA->BYZ_VERCON, aDadUsr[12],				!Empty(BYZA->BYZ_VERCON)	})
			aadd(aFtCmp, {BYZA->BYZ_SUBCON, aDadUsr[41],				!Empty(BYZA->BYZ_SUBCON)	})
			aadd(aFtCmp, {BYZA->BYZ_VERSUB, aDadUsr[42],				!Empty(BYZA->BYZ_VERSUB)	})
			aadd(aFtCmp, {BYZA->BYZ_CDPROD, cCdProduto,					!Empty(BYZA->BYZ_CDPROD)	})
			aadd(aFtCmp, {BYZA->BYZ_MATVID, aDadUsr[5],					!Empty(BYZA->BYZ_MATVIDA)	})
			aadd(aFtCmp, {BYZA->BYZ_MATRIC, Substring(aDadUsr[2],9,6),	!Empty(BYZA->BYZ_MATVIDA)	})

			for i := 1 to Len(aFtCmp)

				if aFtCmp[I,3]
					if cIFCmp > ""
						cIfCmp += " .AND. '"+Alltrim(aFtCmp[I,1])+"' == '"+Alltrim(aFtCmp[I,2])+ "' "
					else
						cIfCmp := "'"+Alltrim(aFtCmp[I,1])+"' == '"+Alltrim(aFtCmp[I,2])+"'"
					endif
				endif
			
			next I

			if &cIfCmp
				nFatMul := BYZA->BYZ_FATORM
				exit
			else

				// Codigo do procedimento tratamento do grupo / subgrupo / item
				if !Empty(BYZA->BYZ_CODPRO)

					if !Empty(cCodRDA)

						if cCodRDA <> BYZA->BYZ_CODRDA
							BYZA->(DbSkip())
							Loop
						endif
					endif

					if SubStr(BYZA->BYZ_CODPRO,3,5) == "00000"

						if SubStr(cCodPro,1,2) == SubStr(BYZA->BYZ_CODPRO,1,2)
							nFatMul := BYZA->BYZ_FATORM
							exit
						endIf
					
					elseif SubStr(BYZA->BYZ_CODPRO,5,3) == "000"
					
						if SubStr(cCodPro,1,4) == SubStr(BYZA->BYZ_CODPRO,1,4)
							nFatMul := BYZA->BYZ_FATORM
							exit
						endif
					else

						if AllTrim(cCodPro) == AllTrim(BYZA->BYZ_CODPRO)
							nFatMul := BYZA->BYZ_FATORM
							exit
						endif
					
					endif
				
				endif
			
			endif
			
			BYZA->(dbSkip())
		end
		BYZA->(DbCloseArea())
	
	endif

endif

RestArea(aArea)

return ({nFatMul,cConsFt})
