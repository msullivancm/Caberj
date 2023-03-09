#include "RWMAKE.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัอออออออออออออออออออออออหออออออัออออออออออปฑฑ
ฑฑบPrograma  ณ PLTIPATO บ Autor ณ Thiago Machado Correa บ Data ณ 19/09/05 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯอออออออออออออออออออออออสออออออฯออออออออออนฑฑ
ฑฑบDescricao ณ Ponto de entrada para retornar tipo de ato cfe regras do	  บฑฑ
ฑฑบ          ณ cliente.							                          บฑฑ
ฑฑบ          ณ Este ponto de entrada ้ chamado na consolida็ใo, PLSM180   บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Unimed Tubarao                                             บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑบAlteracoesณ Inclusao do tratamento a taxa administrativa divida pelos  บฑฑ
ฑฑบ          ณ tipos de atos e tipos de servi็os prestados.               บฑฑ
ฑฑบ          ณ Roger Cangianeli - 23/01/07.                               บฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/ 

User Function PLTIPATO()

	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Inicializa variaveis                                                ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	LOCAL cAto 		:= PARAMIXB[1]
	LOCAL aRet		:= PARAMIXB[4]

	LOCAL aRetVlr 	:= {}
	LOCAL aRetTxa 	:= {}
	LOCAL cTipInt	:= GetNewPar("MV_PLSTPIN","OPE")		

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ A primeira vez que entrar no ponto de entrada, irei redefinir a estrutura padrao do Array aRet |
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

	If Type( "xx_Pb_CHBD7" ) == "U"

		Public xx_Pb_CHBD7 := ""

	EndIf


	If ValType(aRet[1]) <> "A"
		aRetVlr := aClone(aRet)
		aRetTxa := aClone(aRet)
	Else
		//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
		//ณ Auxiliar para o valor do custo / co-participacao                    ณ
		//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
		aRetVlr := aClone(aRet[1])
		//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
		//ณ Auxiliar para o valor da taxa administrativa.                       ณ
		//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
		aRetTxa := aClone(aRet[2])
	Endif

	If BD6->BD6_BLOCPA <> '1'

		If cEmpAnt == '01' .and. (BD7->BD7_NUMLOT <> ' ' .OR. BD6->BD6_FASE == '3' ).and. xx_Pb_CHBD7 <> BD7->(BD7_CODLDP + BD7_CODPEG + BD7_NUMERO + BD7_SEQUEN)

			xx_Pb_CHBD7 := BD7->(BD7_CODLDP + BD7_CODPEG + BD7_NUMERO + BD7_SEQUEN)

			If BD7->BD7_CODEMP == '0004' .OR. BD7->BD7_CODEMP == '0009'

				aRetVlr[6] += BD6->BD6_VLRPF
				aRetTxa[6] += BD6->BD6_VLRTAD

			Else

				aRetVlr[8] += BD6->BD6_VLRPF
				aRetTxa[8] += BD6->BD6_VLRTAD

			EndIf

			cAto := '0'

		ElseIf cEmpAnt == '02' .and. BD7->BD7_NUMLOT <> ' ' .and. xx_Pb_CHBD7 <> BD7->(BD7_CODLDP + BD7_CODPEG + BD7_NUMERO + BD7_SEQUEN)

			xx_Pb_CHBD7 := BD7->(BD7_CODLDP + BD7_CODPEG + BD7_NUMERO + BD7_SEQUEN)

			Do Case
				// Cooperado
			Case BAU->BAU_COPCRE == "1" .Or. BAU->BAU_TIPPRE == "PAT"
				cAto := "1" //Servicos Medicos
				If  BAU->BAU_TIPPRE == cTipInt  //
					If  Alltrim(BD7->BD7_TIPRDA) == 'F'
						// 149  Servi็os Cooperados PF Outras Operadoras (CO-

						aRetVlr[6] += BD6->BD6_VLRPF
						aRetTxa[6] += BD6->BD6_VLRTAD
						cAto := '0'

					Else
						// 150  Servi็os Cooperados PJ Outras Operadoras(CO-
						aRetVlr[7] += BD6->BD6_VLRPF
						aRetTxa[7] += BD6->BD6_VLRTAD
						cAto := '0'

					Endif
				Else
					If  BAU->BAU_CALIMP == "3" .OR. BAU->BAU_TIPPRE == "PAT"
						// 147  Produ็ใo de Cooperados/Pessoa Fํsica - Pega toda producao de consultas locais executadas por credenciados de PF.
						if BAU->BAU_TIPPRE <> "PAT"

							aRetVlr[4] += BD6->BD6_VLRPF
							aRetTxa[4] += BD6->BD6_VLRTAD
							cAto := '0'

						Else
							if BR8->BR8_ATOCOP == "1" // Se o procedimento for ato principal coloco ele como ato medico

								aRetVlr[12] += BD6->BD6_VLRPF
								aRetTxa[12] += BD6->BD6_VLRTAD
								cAto := '0'

							Else // Se nao coloco ele como sadt
								aRetVlr[2] += BD6->BD6_VLRPF
								aRetTxa[2] += BD6->BD6_VLRTAD
								cAto := '0'
							Endif
						Endif
					Else
						// 148  Produ็ใo de Cooperados/Pessoa juridica - Pega toda producao de consultas locais executadas por credenciados de PJ.
						aRetVlr[5] += BD6->BD6_VLRPF
						aRetTxa[5] += BD6->BD6_VLRTAD
						cAto := '0'
					Endif
				Endif

				// Credenciado
			Case BAU->BAU_COPCRE == "2" .And. BAU->BAU_TIPPRE <> "PAT"
				cAto := "0" //Servicos Auxiliares
				If  BAU->BAU_TIPPRE == cTipInt  // ??? COMO SABER SE EH OPERADORA ???
					// 152  Servi็os SADT de outras Unimeds
					if BR8->BR8_ATOCOP == "1"
						// 149 - Ato Principal de Outras Operadoras
						aRetVlr[6] += BD6->BD6_VLRPF
						aRetTxa[6] += BD6->BD6_VLRTAD
						cAto := '0'
					Else
						// 142 - Ato Auxiliar de Outras Operadoras
						aRetVlr[9] += BD6->BD6_VLRPF
						aRetTxa[9] += BD6->BD6_VLRTAD
						cAto := '0'
					Endif
				Else
					// 151  Servi็os Auxiliares de Diagn. E Terapia (SADT)
					aRetVlr[8] += BD6->BD6_VLRPF
					aRetTxa[8] += BD6->BD6_VLRTAD
					cAto := '0'
				Endif

				// Nao cooperado
			Case BAU->BAU_COPCRE == "4" .And. BAU->BAU_TIPPRE <> "PAT"
				cAto := "2" //Outros Servicos
				If  BAU->BAU_TIPPRE == cTipInt // ??? COMO SABER SE EH OPERADORA ???
					// 154  Prod. Nao Coop. Outras Operadoras (C.O.)
					aRetVlr[11] += BD6->BD6_VLRPF
					aRetTxa[11] += BD6->BD6_VLRTAD
					cAto := '0'
				Else
					// 153  Prod. Nao Cooperado (C.O-P.)
					aRetVlr[10] += BD6->BD6_VLRPF
					aRetTxa[10] += BD6->BD6_VLRTAD
					cAto := '0'
				Endif

			EndCase

		EndIf


	EndIf

Return({cAto,{aRetVlr,aRetTxa},.T.})
