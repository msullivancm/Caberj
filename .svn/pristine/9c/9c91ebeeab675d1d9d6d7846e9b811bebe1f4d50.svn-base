#INCLUDE "PROTHEUS.CH"
#include "PLSMGER.CH"
#include "COLORS.CH"
#include "TOPCONN.CH"
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³PLS090MATRºAutor  ³Raquel Casemiro     º Data ³  05/06/07   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Ponto de entrada para buscar matricula do sistema Microsiga º±±
±±º          ³caso seja informada a matricula do convenio.                º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function PLS090MATR()

Local aRet			:= {"",""} //1-Matricula Atual / 2-BA1_MATANT
Local aAreaBA1		:= BA1->(GetArea())
Local cMatric		:= PARAMIXB[1]
Local lFound		:= .F.
Local d_DatProc		:= StoD("")
Local cQry			:= ""
Local cAlias		:= GetNextAlias()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³												 OBSERVACAO IMPORTANTE!!!                                                        ³
//³                                                                                                                              ³
//³ A rotina padrao PLSA090USR chama este PE (PLSA090MATR) e depois, por default, busca primeiro a matricula antiga e            ³
//³ depois a matricula nova.                                                                                                     ³
//³ Neste PE ja eh feita a busca da matricula mais antiga, tornando redundante fazer novamente a busca. Alem disso o padrao      ³
//³ busca primeiro a matricula antiga retornada no segundo indice do vetor aRet deste PE. Isso faz com que ele busque a matricula³
//³ antiga depois de ter sido retornada a matricula correta por este PE, alterando para uma matricula antiga.                    ³
//³ Se a matricula antiga retornar Ok, ele nao busca a matricula nova, alterando para matricula antiga.                          ³
//³ Para fazer com que o padrao busque a matricula antiga (ja eh feito neste PE), deve passar '1' no ultimo parametro da funcao, ³
//³ conforme  abaixo:                                                                                                            ³
//³ PLSA090USR(M->BD5_USUARI,M->BD5_DATPRO,M->BD5_HORPRO,"BD5",nil,nil,nil,"2",,,,'1'/*Busca somente matricula atual*/)          ³
//³ Retornar vazio na matricula anterior no aRet talvez resolvesse, todavia a rotina padrao atualiza os Gets e iria apagar a ma- ³
//³ tricula antiga, podendo impactar em outros processos.                                                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

BA1->(DbSetOrder(2))
BA1->(MsSeek(xFilial('BA1') + cMatric))

if AllTrim(GetNewPar("MV_XLOGINT", '0')) == '1'
	if FunName() == "PLSA092"
		U_LogMatInt(M->BE4_USUARI, M->BE4_NOMUSR, "PLS090MATR - 1 - cmatric: " + cMatric)
	endif
endif

//Leonardo Portella - 16/07/12 - Inicio - Buscar a matricula vigente na data do procedimento
if Alltrim(FunName()) == "PLSA498"			// Digitacao do Conta Medica

	// Leonardo Portella - 14/08/12 - Inicio - Buscar a matricula vigente na data do procedimento quando for digitada a matricula de repasse - Chamado ID 2969
	if substr(cMatric,1,3) == '801'		// Bianchini - 21/12/2012 - Tratamento porque a CABESP (contrato 801) possui matricula de repasse e matricula carteira.
										//                          O campo BA1_YMTREP est[á povoado com a carteira mas o faturamento é mandado com a matricula de repasse
		if !BA1->(Found())
			BA1->(DbOrderNickName("BA1_YMTREP"))
			BA1->(MsSeek(xFilial("BA1") + substr(cMatric,4,8)))		// Bianchini - 21/12/2012 - PEGAR SOMENTE A MATRICULA FIXA DO ASSISTIDO NA CABESP
		endif
	
	else

		if !BA1->(Found())
			BA1->(DbOrderNickName("BA1_YMTREP"))
			BA1->(MsSeek(xFilial("BA1") + cMatric))
		endif
	
	endif
	// Leonardo Portella - 14/08/12 - Fim

	if (lMatValid := BA1->(Found()) )

		if Type('M->BD5_DATPRO') <> 'U'
			d_DatProc	:= M->BD5_DATPRO
			c_HorProc	:= M->BD5_HORPRO
		elseif Type('BD5->BD5_DATPRO') <> 'U'
			d_DatProc	:= BD5->BD5_DATPRO
			c_HorProc	:= BD5->BD5_HORPRO
		elseIf Type('M->BE4_DATPRO') <> 'U'
			d_DatProc	:= M->BE4_DATPRO
			c_HorProc	:= M->BE4_HORPRO
		else
			d_DatProc	:= BE4->BE4_DATPRO
			c_HorProc	:= BE4->BE4_HORPRO
		endif

		if empty(d_DatProc)
			lMatValid := .F.
		endif
	
	endif
	
	if lMatValid

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Leonardo Portella - 07/01/13 - Inicio                                 ³
		//³ Verifico se a matricula digitada encontra-se em regime de internacao e³
		//³ em caso positivo mantenho a mesma.                                    ³
		//³ Chamado ID: 4834                                                      ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		aInter := PLSUSRINTE(cMatric,d_DatProc,c_HorProc,.T.,.F.,"BD5")

		if type("aInter") == "A"

			if len(aInter) > 0 .and. aInter[1]
				lFound	:= .T.
				aRet	:= {BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG+BA1_DIGITO),BA1->BA1_MATANT}
			endif
		
		endif

		cQry := " SELECT BA1_CODINT||BA1_CODEMP||BA1_MATRIC||BA1_TIPREG||BA1_DIGITO MATRIC_NA_DATA, BA1_NOMUSR, BA1_DTVLCR, BA1_DATINC, "	+;
						DtoS(d_DatProc) + " DATA_EVENTO, BA1_DATBLO, BA3_DATBAS, BA3_DATBLO, BA3_VALID, BA1.R_E_C_N_O_ RECBA1,"				+;
						" BA3.R_E_C_N_O_ RECBA3"																							+ CRLF
		cQry += " FROM " + RetSqlName('BTS') + " BTS"																						+ CRLF
		cQry +=   " INNER JOIN " + RetSqlName('BA1') + " BA1 ON BA1.D_E_L_E_T_ = ' '"														+ CRLF
		cQry +=		  " AND BA1_FILIAL = '" + xFilial('BA1') + "'"																			+ CRLF
		cQry +=       " AND BA1_MATVID = BTS_MATVID"																						+ CRLF
		cQry +=       " AND BA1_DATINC <= '" + DtoS(d_DatProc) + "'"																		+ CRLF
		cQry +=       " AND (BA1_DATBLO = ' ' OR ('" + DtoS(d_DatProc) + "' <= BA1_DATBLO ) )"												+ CRLF

		// Leonardo Portella - 22/09/16 - Não retornar matrícula da agenda
		cQry +=       " AND BA1_XTPBEN <> 'RECIPR'"																							+ CRLF

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Leonardo Portella - 17/10/12 - Chamado ID 3865                                                                                  ³
		//³ Data de validade da carteirinha deve ser maior ou igual a data do evento, caso contrario ira cair em glosa de "data de validade ³
		//³ do cartao magnetico vencido". Obs: Glosa do padrao.                                                                             ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		cQry +=       " AND BA1_DTVLCR >= '" + DtoS(d_DatProc) + "'"																		+ CRLF

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Leonardo Portella - 19/10/12 - Inicio - Chamado ID 3890                                                                         ³
		//³ Considerar a familia na troca de matricula, verificando a data de inclusao, data de bloqueio e validade. Obs: A data do evento e³
		//³ de bloqueio na familia esta com menor pois no caso citado no chamado o evento era na data do bloqueio e o sistema estava        ³
		//³ glosando por familia bloqueada.                                                                                                 ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		cQry +=   " INNER JOIN " + RetSqlName('BA3') + " BA3 ON BA3.D_E_L_E_T_ = ' '"														+ CRLF
		cQry +=     " AND BA3_FILIAL = '" + xFilial('BA3') + "'"																			+ CRLF
		cQry +=     " AND BA3_CODINT = BA1_CODINT"																							+ CRLF
		cQry +=     " AND BA3_CODEMP = BA1_CODEMP"																							+ CRLF
		cQry +=     " AND BA3_MATRIC = BA1_MATRIC"																							+ CRLF
		cQry +=     " AND BA3_DATBAS <= '" + DtoS(d_DatProc) + "'"																			+ CRLF
		cQry +=     " AND (BA3_DATBLO = ' ' OR ('" + DtoS(d_DatProc) + "' < BA3_DATBLO ) )"													+ CRLF
		cQry +=     " AND BA3_VALID >= '" + DtoS(d_DatProc) + "'"																			+ CRLF
		//Leonardo Portella - 19/10/12 - Fim - Chamado ID 3890

		cQry += " WHERE BTS.D_E_L_E_T_ = ' '"																								+ CRLF
		cQry +=   " AND BTS_FILIAL = '" + xFilial('BTS') + "'"																				+ CRLF
		cQry +=   " AND BTS_MATVID = '" + BA1->BA1_MATVID + "'"																				+ CRLF

		TcQuery cQry New Alias cAlias

		if !cAlias->(EOF()) .and. !lFound

			// Leonardo Portella - 01/08/12 - Inicio - Caso exista mais de uma matricula valida na data e uma delas for a digitada, manter a digitada (matr. Odonto)
			lAchouOri := .F.

			while !cAlias->(EOF())
				if cMatric == cAlias->(MATRIC_NA_DATA)
					lAchouOri	:= .T.
					exit
				endif

				cAlias->(DbSkip())
			end

			if !lAchouOri
				cAlias->(DbGoTop())
			endif
			// Leonardo Portella - 01/08/12 - Fim

			BA1->(DbGoTo(cAlias->RECBA1))
			lFound	:= .T.
			aRet	:= {BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG+BA1_DIGITO),BA1->BA1_MATANT}
		
		endif

		cAlias->(DbCloseArea())
	
	endif

endif

// Bianchini - 21/12/2012 - Tratamento porque a CABESP (contrato 801) possui matricula de repasse e matricula carteira.
if SubStr(cMatric,1,3) == '801'

	if AllTrim(GetNewPar("MV_XLOGINT", '0') ) == '1'
		if FunName() == "PLSA092"
			U_LogMatInt(M->BE4_USUARI, M->BE4_NOMUSR, "PLS090MATR - 4 - cmatric: " + cMatric )
		endif
	endif

	BA1->( dbOrderNickName( "BA1_YMTREP" ) )					// O campo BA1_YMTREP est[á povoado com a carteira mas o faturamento é mandado com a matricula de repasse
	if BA1->(MsSeek(xFilial("BA1") + substr(cMatric,4,8)))		// Bianchini - 21/12/2012 - PEGAR SOMENTE A MATRICULA FIXA DO ASSISTIDO NA CABESP
		lFound	:=.T.
		aRet	:= {BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG+BA1_DIGITO),BA1->BA1_MATANT}
	endif

elseif !Empty(BA1->BA1_YMTREP)

	BA1->( dbOrderNickName( "BA1_YMTREP" ) )
	if BA1->(MsSeek(xFilial("BA1")+cMatric))

		lFound	:=.T.

		// Mateus Medeiros - Incluido o Lopping por estar carregando a matricula de repasse errada. - 28/12/2017
		while BA1->(!EOF()) .and. AllTrim(BA1->BA1_YMTREP) == AllTrim(cMatric) .and. BA1->BA1_FILIAL == xFilial("BA1")

			if !empty(d_DatProc)
				if BA1->BA1_DATINC <= d_DatProc
					aRet	:= {BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG+BA1_DIGITO),BA1->BA1_MATANT}
				endif
			else
				if BA1->BA1_DATINC <= ddatabase
					aRet	:= {BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG+BA1_DIGITO),BA1->BA1_MATANT}
				endif
			endif

			BA1->(dbskip())
		end
	
	endif

endif

if AllTrim( GetNewPar("MV_XLOGINT", '0') ) == '1'
	if FunName() == "PLSA092"
		U_LogMatInt(M->BE4_USUARI, M->BE4_NOMUSR, "PLS090MATR - 5 - cmatric: " + cMatric)
	endif
endif

if AllTrim( GetNewPar("MV_XLOGINT", '0') ) == '1'
	if FunName() == "PLSA092"
		U_LogMatInt(M->BE4_USUARI, M->BE4_NOMUSR, "PLS090MATR - 6 - cmatric: " + cMatric)
	endif
endif

RestArea(aAreaBA1)

return iif(lFound, aRet, cMatric)
