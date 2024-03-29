#include "RWMAKE.CH"

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  � PLTIPATO � Autor � Thiago Machado Correa � Data � 19/09/05 ���
�������������������������������������������������������������������������͹��
���Descricao � Ponto de entrada para retornar tipo de ato cfe regras do	  ���
���          � cliente.							                          ���
���          � Este ponto de entrada � chamado na consolida��o, PLSM180   ���
�������������������������������������������������������������������������͹��
���Uso       � Unimed Tubarao                                             ���
�������������������������������������������������������������������������ͼ��
���Alteracoes� Inclusao do tratamento a taxa administrativa divida pelos  ���
���          � tipos de atos e tipos de servi�os prestados.               ���
���          � Roger Cangianeli - 23/01/07.                               ���
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/ 

User Function PLTIPATO()

	//���������������������������������������������������������������������Ŀ
	//� Inicializa variaveis                                                �
	//�����������������������������������������������������������������������
	LOCAL cAto 		:= PARAMIXB[1]
	LOCAL aRet		:= PARAMIXB[4]

	LOCAL aRetVlr 	:= {}
	LOCAL aRetTxa 	:= {}
	LOCAL cTipInt	:= GetNewPar("MV_PLSTPIN","OPE")		

//������������������������������������������������������������������������������������������������Ŀ
//� A primeira vez que entrar no ponto de entrada, irei redefinir a estrutura padrao do Array aRet |
//��������������������������������������������������������������������������������������������������

	If Type( "xx_Pb_CHBD7" ) == "U"

		Public xx_Pb_CHBD7 := ""

	EndIf


	If ValType(aRet[1]) <> "A"
		aRetVlr := aClone(aRet)
		aRetTxa := aClone(aRet)
	Else
		//���������������������������������������������������������������������Ŀ
		//� Auxiliar para o valor do custo / co-participacao                    �
		//�����������������������������������������������������������������������
		aRetVlr := aClone(aRet[1])
		//���������������������������������������������������������������������Ŀ
		//� Auxiliar para o valor da taxa administrativa.                       �
		//�����������������������������������������������������������������������
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
						// 149  Servi�os Cooperados PF Outras Operadoras (CO-

						aRetVlr[6] += BD6->BD6_VLRPF
						aRetTxa[6] += BD6->BD6_VLRTAD
						cAto := '0'

					Else
						// 150  Servi�os Cooperados PJ Outras Operadoras(CO-
						aRetVlr[7] += BD6->BD6_VLRPF
						aRetTxa[7] += BD6->BD6_VLRTAD
						cAto := '0'

					Endif
				Else
					If  BAU->BAU_CALIMP == "3" .OR. BAU->BAU_TIPPRE == "PAT"
						// 147  Produ��o de Cooperados/Pessoa F�sica - Pega toda producao de consultas locais executadas por credenciados de PF.
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
						// 148  Produ��o de Cooperados/Pessoa juridica - Pega toda producao de consultas locais executadas por credenciados de PJ.
						aRetVlr[5] += BD6->BD6_VLRPF
						aRetTxa[5] += BD6->BD6_VLRTAD
						cAto := '0'
					Endif
				Endif

				// Credenciado
			Case BAU->BAU_COPCRE == "2" .And. BAU->BAU_TIPPRE <> "PAT"
				cAto := "0" //Servicos Auxiliares
				If  BAU->BAU_TIPPRE == cTipInt  // ??? COMO SABER SE EH OPERADORA ???
					// 152  Servi�os SADT de outras Unimeds
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
					// 151  Servi�os Auxiliares de Diagn. E Terapia (SADT)
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
