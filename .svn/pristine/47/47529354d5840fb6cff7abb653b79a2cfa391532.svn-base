#INCLUDE "PROTHEUS.CH"
#INCLUDE "TOTVS.CH"
#INCLUDE "TOPCONN.CH"

#define __aCdCri025 {"025", GetAdvFVal("BCT", "BCT_DESCRI", xFilial("BCT") + PlsIntPad() + "025", 1)}
#DEFINE __aCdCri109 {"066", GetAdvFVal("BCT", "BCT_DESCRI", xFilial("BCT") + PlsIntPad() + "066", 1)}
#DEFINE __aCdCri110 {"067", GetAdvFVal("BCT", "BCT_DESCRI", xFilial("BCT") + PlsIntPad() + "067", 1)}
#DEFINE __aCdCri111 {"068", GetAdvFVal("BCT", "BCT_DESCRI", xFilial("BCT") + PlsIntPad() + "068", 1)}

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³PLSAUT02  ºAutor  ³Microsiga           º Data ³  02/12/07   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Rotina destinada a implementar criticas relativas a mudanca º±±
±±º          ³de fase e autorizacoes.                                     º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function PLSAUT02

Local aArea			:= GetArea()
Local aAreaBD5		:= BD5->(GetArea())
Local aAreaBD6		:= BD6->(GetArea())
Local aAreaBD7		:= BD7->(GetArea())
Local aAreaBE4		:= BE4->(GetArea())
Local aAreaBR8		:= BR8->(GetArea())
Local aAreaBKD		:= BKD->(GetArea())
Local aAreaB19		:= B19->(GetArea())
Local aAreaSD1		:= SD1->(GetArea())
Local aAreaBAU		:= BAU->(GetArea())
Local aAreaBDX		:= BDX->(GetArea())
Local aAreaBBK		:= BBK->(GetArea())
Local aAreaBCT		:= BCT->(GetArea())

Local aRetPad		:= aClone(ParamIxb[1])		// O que o sistema já criticou com as regras padrões
Local dData			:= ParamIxb[2]				// Data do Evento
Local cHora			:= ParamIxb[3]				// Hora do Evento
Local cCdTbPd		:= ParamIxb[4]				// Codigo do Tipo de Tabela
Local cCodPro		:= ParamIxb[5]				// Codigo do Procedimento
Local nQtd			:= ParamIxb[6]				// Quantidade
Local cCid			:= ParamIxb[7]				// CID
Local cLocalExec	:= ParamIxb[8]				// "1" - Via atendimento | "2" Via contas médicas (mudanca de fase)
Local cOpeSol		:= ParamIxb[9]				// Operadora do Solicitante
Local cCodPRFSol	:= ParamIxb[10]				// Codigo do Profissional de Saude do Medico Solicitante
Local cOpeRDA		:= ParamIxb[11]				// Operadora da RDA
Local cCodRDA		:= ParamIxb[12]				// Codigo da RDA
Local cCodLoc		:= ParamIxb[13]				// Codigo do Local de Atendimento
Local cLocal		:= ParamIxb[14]				// Local
Local cCodEsp		:= ParamIxb[15]				// Codigo da Especialidade
Local cOpeUsr		:= ParamIxb[16]				// Codigo da Operadora do Usuario
Local cMatricUsr	:= ParamIxb[17]				// Matricula do Usuario
Local cPadInt		:= ParamIxb[18]				// Padrao de internação
Local aDadUsr		:= aClone(ParamIxb[19])		// Dados Gerais do Usuário
Local aDadRda		:= PLSGETRDA()				// aClone(ParamIxb[20])			// Dados Gerais da RDA
Local cTipGuia		:= ParamIxb[23]				// Tipo da Guia
Local cChavGui		:= ParamIxb[24]				// Chave da Guia
Local cChavLib		:= ParamIxb[25]				// Chave de Liberação
Local cNumGuia		:= ParamIxb[26]				// Numero da Guia

Local lSistemaAut	:= aRetPad[1]				// O sistema no padrão autorizou ou negou o procedimento
Local lTemNFE		:= .F.
Local aCriticas		:= {}
Local aRetFuncao	:= aClone(aRetPad)			// retorno padrao desta funcao
Local cChave		:= ""
Local cSenInt		:= ""
Local dDatGui		:= CtoD("")
Local cAlias		:= ""
Local lInter		:= .F.
Local cRegAte		:= ""
Local nCont			:= 0
Local lExcAudit		:= .F.
Local aIntern		:= {}
Local cNomPro   	:= ""						// Acrescentado por Renato Peixoto em 05/10/10

Local _cUltDia		:= ""						// Angelo Henrique - data: 13/03/2018
Local _lCrit9N		:= .F.						// Angelo Henrique - data: 13/03/2018
Local _cMatricUsr 	:= aDadUsr[2]				// Bianchini - 18/10/2018 - RDM 315
Local _cCodEmp		:= Subs(_cMatricUsr,5,4)	// Bianchini - 18/10/2018 - RDM 315
Local _cMatric		:= Subs(_cMatricUsr,9,6)	// Bianchini - 18/10/2018 - RDM 315
Local _cTipReg		:= Subs(_cMatricUsr,15,2)	// Bianchini - 18/10/2018 - RDM 315
Local cPadCon		:= Iif(BD6->BD6_ORIMOV=="2",BE4->BE4_PADCON,BD5->BD5_PADCON)	// Bianchini - 06/06/2019 - Adequação P12
Local cHorPro		:= BD6->BD6_HORPRO			// Bianchini - 06/06/2019 - Adequação P12
Local aRdas			:= {}						// Bianchini - 06/06/2019 - Adequação P12
Local aValor 		:= {}						// Bianchini - 06/06/2019 - Adequação P12
Local nQtdVal		:= 0						// Bianchini - 06/06/2019 - Adequação P12
Local nVlrRea		:= 0						// Bianchini - 06/06/2019 - Adequação P12
Local nSomaProc		:= 0						// Bianchini - 06/06/2019 - Adequação P12

Local cSexo   		:= aDadUsr[25]
Local nIdade  		:= aDadUsr[27]
Local cMatrUsr		:= cMatricUsr
Local cCodInt		:= cOpeUsr
Local dDatCar 		:= aDadUsr[28]
Local nRegBD6 		:= BD6->(RECNO())
Local nPerioPer		:= 0
Local cUniPerio 	:= ""
Local lTratRDA    	:= GetNewPar("MV_PLSMODA","1") == "1" //.t.
Local lTratSolic	:= ""
Local lTratExe		:= .T.
Local cGuiaOpe    	:= ""
Local cGuiaEmp    	:= ""
Local cCodPla		:= aDadUsr[11]
Local cVersao		:= aDadUsr[12]
Local cNumeroGuia	:= ""
Local cTpLocExec	:= ""
Local cFaces		:= ""
Local aQtd    		:= {}
Local aPerio	 	:= {}
Local cGrpInt		:= ""
Local aObsolet	    := ""
Local cRdaEDI     	:= ""
Local cAreaAbr		:= ""
Local cDente	    := ""
Local aFaces		:= {}
Local aQtdBrow		:= {}
Local aVldGen  		:= {}
Local cSequen		:= ""
Local aBD7			:= {}	
Local cEspSol		:= ''
Local cEspExe		:= ''
Local lBR8_UNIMIN	:= BR8->(FieldPos('BR8_UNIMIN')) > 0
Local lBR8_UNIMAX	:= BR8->(FieldPos('BR8_UNIMAX')) > 0	
Local aRetFun		:= {}
Local cRegInt		:= ""
Local cTipoProc		:= ""
Local lIntPort		:= .F.
Local aRetPro		:= {}
Local lWeb			:=(AllTrim(funName())=="RPC")
Local _ni			:= 0
Local cQuery		:= ""
Local aNiveis		:= PLSESPNIV(cCdTbPd)
Local cAliasQry		:= GetNextAlias()
Local cAutori		:= ""
Local cPrdCbt		:= ""

Private _cCodPad	:= cCdTbPd
Private _cCodPro	:= cCodPro
Private _dDatPro	:= dData
Private cCodCriEsp	:= "702"  //Codigo de sua critica especifica...
Private cDesCriEsp	:= "Procedimento ja cobrado na mesma data na mesma senha, em guia diferente. Chave da duplicidade:"  //Descricao de sua critica especifica...
Private cNivel	 	:= "" //Nunca Alterar (Falha na cobranca de copart)...
Private cOriMov		:= ""
Private _cCodRBS	:= ""
Private cCodLdp		:= BD6->BD6_CODLDP

//------------------------------------------------------------------------------//
// FRED - Buscar parametrização do procedimento: BG8 (Grupo de Cobertura) 		//
//------------------------------------------------------------------------------//
cQuery := " select BG8_AUTORI, BG8_CODGRU, BG8_CODPSA"
cQuery += " from " + RetSqlName("BRV") + " BRV"
cQuery +=	" inner join " + RetSqlName("BG8") + " BG8"
cQuery +=	  " on (    BG8_FILIAL = BRV_FILIAL"
cQuery +=		  " and BG8_CODINT = substr(BRV_CODPLA,1,4)"
cQuery +=		  " and BG8_CODGRU = BRV_CODGRU"
cQuery +=		  " and BG8_CODPAD = '" + cCdTbPd + "')"
cQuery += " where BRV.D_E_L_E_T_ = ' ' and BG8.D_E_L_E_T_ = ' '"
cQuery +=	" and BRV_FILIAL = '" + xFilial("BRV") + "'"
cQuery +=	" and BRV_CODPLA = '" + PLSINTPAD() + aDadUsr[11] + "'"
cQuery +=	" and BRV_VERSAO = '" + aDadUsr[12] + "'"
cQuery +=	" and " + PLREQNI("BG8", "BG8_CODPSA", aNiveis[2], allTrim(cCodPro))
cQuery +=	    " BG8_BENUTL = '1'"
cQuery += " order by BG8_NIVEL DESC"

if Select(cAliasQry) > 0
	DbSelectArea(cAliasQry)
	(cAliasQry)->(dbCloseArea())
endif

TcQuery cQuery New Alias (cAliasQry)

DbSelectArea(cAliasQry)
if !(cAliasQry)->(EOF())
	cAutori := (cAliasQry)->BG8_AUTORI
endif
(cAliasQry)->(DbCloseArea())

// FRED - se não achou parametrização no Grupo de Cobertura buscar na Tabela Padrão
BR8->(DbSetOrder(1))
if BR8->(MsSeek(xFilial("BR8") + cCdTbPd + cCodPro))

	cRegAte		:= BR8->BR8_REGATD
	cNomPro		:= BR8->BR8_DESCRI
	nPerioPer	:= BR8->BR8_PERIOD
	cUniPerio	:= BR8->BR8_UNPERI
	aQtd		:= PlRetPaQtd("BR8")
	aPerio		:= PlRetPaPer("BR8")

	if empty(cAutori)
		cAutori	:= BR8->BR8_AUTORI
	endif

endif
// FRED - fim da busca de parametrizações

If Len(aRetFuncao) < 3

	cGrpInt		:= M->BE4_GRPINT
	cRegInt		:= M->BE4_REGINT
	lTratSolic	:= !Empty(M->BE4_REGSOL)
	lTratExe	:= !Empty(M->BE4_REGEXE)

	aRetPro		:= PLSAUTPDIR(	cOpeUsr,cMatrUsr,cCdTbPd,cCodPro,aDadUsr,dData,cHora,nRegBD6,aDadRda,;
								lTratRDA,cCid,nQtd,cLocalExec,cOpeSol,cCodPRFSol,cGuiaOpe,cGuiaEmp,;
								cCodPla,cVersao,.t.,nil,nil,cSequen,cNumeroGuia,cTpLocExec,cFaces,;
								cGrpInt,aObsolet,cRdaEDI,cAreaAbr,cDente,aFaces,cCodEsp,aQtdBrow,;
								aVldGen,cChavGui,lTratSolic,lTratExe,aBD7,cEspSol,cEspExe,cRegInt,,cTipoProc,lIntPort)
	
	If Len(aRetPro) > 2

		//-------------------------------------------------------------------
		//Inicio - Angelo Henrique - Data: 12/08/2021
		//-------------------------------------------------------------------
		//Após aplicação do Path da totvs o vetor reduziu de tamanho
		//colocando aqui para preencher a critica que ja veio no vetor
		//original caso não encontre
		//-------------------------------------------------------------------
		//aRetFuncao := aClone(aRetPro)
		//cChavLib 	:= aRetFuncao[4]

		If Len(aRetFuncao) < 3

			aadd(aRetFuncao,aRetPro[3])
			aadd(aRetFuncao,aRetPro[4])
		
		EndIf

		cChavLib 	:= aRetPro[4]
		//-------------------------------------------------------------------
		//Fim - Angelo Henrique - Data: 12/08/2021
		//-------------------------------------------------------------------
	
	Endif

Else
	cChavLib 	:= aRetPad[4]
Endif

If len(aRetPad) > 2 .and. Empty(cChavLib)
	cChavLib 	:= aRetPad[4]
Endif

aRetFun := PLSVLDAut(	nIdade,BR8->BR8_IDAMIN,BR8->BR8_IDAMAX,BR8->BR8_SEXO,cSexo,;
						{BR8->BR8_UNCAR,BR8->BR8_CARENC,"1",BR8->BR8_CLACAR,cCodInt,dDatCar,.f.},dData,cHora,dDatCar,;
						cCdTbPd,cCodPro,nRegBD6,cOpeUsr,cMatrUsr,aDadUsr,cCid,nQtd,BR8->BR8_NIVEL,;
						BR8->BR8_QTD,BR8->BR8_UNCA,nPerioPer,cUniPerio,BR8->BR8_AUTORI,;
						cLocalExec,aDadRDA,cOpeSol,cCodPRFSol,lTratRda,cGuiaOpe,cGuiaEmp,cCodPla,cVersao,cNumeroGuia,cTpLocExec,;
						cFaces,"BR8",BR8->(BR8_FILIAL+BR8_CODPAD+BR8_CODPSA),aQtd,aPerio,cRdaEDI,cAreaAbr,cDente,aFaces,aQtdBrow,;
						aVldGen,cChavGui,cSequen,aBD7,cEspSol,cEspExe,;
						iIf(lBR8_UNIMIN,BR8->BR8_UNIMIN,''),iIf(lBR8_UNIMAX,BR8->BR8_UNIMAX,''),cChavLib)


//---------------------------------------------------------------------------------------
// FRED - geração de critica '025' (enviar para auditoria) quando procedimento esta
// parametrizado e por falha sistemica o mesmo não foi gerado
//---------------------------------------------------------------------------------------
if cLocalExec == "1" .and. ProcName(18) <> "PLSA498"		// somente na liberação (não chama no contas médicas)

	// Verificar se procedimento está parametrizado para necessitar auditoria e está autorizado
	if cAutori == "3" .and. aRetPad[1]
	
		//----------------------------------------------------------------------------------------------------------//
		// * Estou verificando se não possui crítica genericamente e não especificamente a 025 (auditoria)			//
		// Faço isso devido a ter críticas que 'inibem' a geração de outras críticas (Ex.: 035 - não ter cobertura)	//
		// -> nCont	:= aScan(aCriticas,{ |x| x[1] == "025"})														//
		//----------------------------------------------------------------------------------------------------------//
		
		if PLSPOSGLO(PlsIntPad(), __aCdCri025[1], __aCdCri025[2], cLocalExec)
		
			aAdd(aCriticas, {__aCdCri025[1], __aCdCri025[2], cCdTbPd + "-" + iif(!empty(cPrdCbt),cPrdCbt,cCodPro), BCT->BCT_NIVEL, BCT->BCT_TIPO, cCdTbPd, cCodPro})

			if len(aRetPro) >= 4
				PLSCOMPCRI(aCriticas, aRetPro[3], aRetPro[4])
				aRetFuncao := { .F., aCriticas, aRetPro[3], aRetPro[4] }
			else
				PLSCOMPCRI(aCriticas, "BR8", cCdTbPd + cCodPro )
				aRetFuncao := { .F., aCriticas, "BR8", cCdTbPd + cCodPro }
			endif

		endif
		
	endif

endif
// FRED - fim da geração da critica '025'

If alltrim( GetNewPar("MV_XLOGINT", '0') ) == '1'

	If FunName() == "PLSA092"
	
		u_LogMatInt(M->BE4_USUARI, M->BE4_NOMUSR, "PLSAUT02 - 1")
	
	EndIf

EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Nao permitir este tratamento na rotina de reembolso...                   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If Alltrim(FunName())=="PLSA987"

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Funcao de usuario para obter nivel de autorizacao no reembolso...        ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	U_NivAutRee()

	If alltrim( GetNewPar("MV_XLOGINT", '0') ) == '1'

		If FunName() == "PLSA092"

			u_LogMatInt(M->BE4_USUARI, M->BE4_NOMUSR, "PLSAUT02 - 2")
		
		EndIf
	
	EndIf

	Return(aRetFuncao)

ElseIf Alltrim(FunName()) $ "PLSA001|PLSA001A"

	// Fabio Bianchini - 19/10/2020 - GLPI 70745 e 70557
	// Retirar Critica de Auditoria(Perícia Medica), se houver registro do GEPRE na tabela PBI
	If Empty (M->B44_YSENHA)
	
		PBI->(DbSetOrder(2))
		If PBI->(DbSeek(xFilial("PBI")+M->(B44_OPEUSR+B44_CODEMP+B44_MATRIC+B44_TIPREG+B44_DIGITO)))

			If PBI->PBI_ATEDOI == '1' .AND. M->B45_DATPRO >= PBI->PBI_VIGINI .AND. (M->B45_DATPRO <= PBI->PBI_VIGFIN .OR. EMPTY(PBI->PBI_VIGFIN))

				aRetFuncao := aRetCri('025', aRetFuncao, aRetPad, @lSistemaAut)
			
			Endif
		
		Endif

		PBI->(DbCloseArea())
	Endif

EndIf

//Leonardo Portella - 15/04/15 - Inicio - Nao glosa com a critica 09N em casos especificos
If !lSistemaAut

	cMacro		:= BCL->BCL_ALIAS + '->' + BCL->BCL_ALIAS + '_CODLDP'
	cCodLDP		:= &cMacro
	cMacro		:= BCL->BCL_ALIAS + '->' + BCL->BCL_ALIAS + '_CODRDA'
	cCodRDA		:= &cMacro
	lTira09N	:= .F.

	If Alltrim(FunName()) $ "PLSA001|PLSA001A"
		cCodLDP := B44->B44_CODLDP
	EndIf

	Do Case

		Case ( cCodLDP == '9000' )

			//Leonardo Portella - 26/11/15 - Inicio - Chamado ID 20430

			//So ira criticar reembolso com critica 09N se a data de realização do
			//procedimento for maior que 365 dias
			If 	( dDataBase - M->B44_DATPRO ) <= 365

				//Retira a critica 09N. Se a mesma não existir não altera o vetor
				aRetFuncao := aRetCri('09N', aRetFuncao, aRetPad, @lSistemaAut)
			
			EndIf

			//Leonardo Portella - 26/11/15 - Fim - Chamado ID 20430
			//Leonardo Portella - 29/12/15 - Início - Crítica de perícia médica em Reembolso deve ser excluída.
			
			//Retira a critica 025. Se a mesma não existir não altera o vetor
			aRetFuncao := aRetCri('025', aRetFuncao, aRetPad, @lSistemaAut)

			//Leonardo Portella - 29/12/15 - Fim
		
		Case ( Alltrim(FunName()) == 'PLSA498' .or. IsInCallStack("PLSA175FAS") )

			//------------------------------------------------------
			// Inicio - Angelo Henrique - Data: 13/03/2018
			//------------------------------------------------------
			//Fatura 60/90 Dias - Chamado: 47856
			//------------------------------------------------------
			_cUltDia := LastDay(MonthSub(dDataBase,1))

			BAU->(DbSetOrder(1))
			If BAU->(DbSeek(xFilial("BAU") + BD6->BD6_CODRDA))	// BAU_CODIGO = BD6_CODRDA

				If !(Empty(AllTrim(BAU->BAU_XPRENT)))

					If ((_cUltDia - BD6->BD6_DATPRO) < Val(BAU->BAU_XPRENT))

						// Retira a critica 09N. Se a mesma não existir não altera o vetor
						aRetFuncao := aRetCri('09N', aRetFuncao, aRetPad, @lSistemaAut)
						_lCrit9N := .T.
					
					EndIf
				
				EndIf
			
			EndIf
			//------------------------------------------------------
			// Fim - Angelo Henrique - Data: 13/03/2018
			//------------------------------------------------------

			If !_lCrit9N //Caso não tenha validado antes

				If ( cEmpAnt == '01' ) .and. ( BD6->BD6_CODEMP $ '0004|0009' )

					//Retira a critica 09N. Se a mesma não existir não altera o vetor
					aRetFuncao := aRetCri('09N', aRetFuncao, aRetPad, @lSistemaAut)
				
				ElseIf ( cCodLDP == '0010' )//Local de Recurso de Glosas (0010)

					//Retira a critica 09N. Se a mesma não existir não altera o vetor
					aRetFuncao := aRetCri('09N', aRetFuncao, aRetPad, @lSistemaAut)
					
				//Leonardo Portella - 23/09/15 - Inicio - Chamado ID 20415
				ElseIf lExcecMax(cCodRDA)//Excecoes solicitadas pelo Max

					//Retira a critica 09N. Se a mesma não existir não altera o vetor
					aRetFuncao := aRetCri('09N', aRetFuncao, aRetPad, @lSistemaAut)
				
				EndIf
			
			EndIf
			//Leonardo Portella - 23/09/15 - Fim - Chamado ID 20415
		
		Case ( Alltrim(FunName()) == 'PLSA092' ) .And. !_lCrit9N // Prorrogacao

			//Retira a critica 09N. Se a mesma não existir não altera o vetor
			aRetFuncao := aRetCri('09N', aRetFuncao, aRetPad, @lSistemaAut)
		
	End Case

EndIf
//Leonardo Portella - 15/04/15 - Fim

If Alltrim(FunName()) == "PLSA094B"

	cChave	:= BEA->(BEA_CODLDP+BEA_CODPEG+BEA_NUMGUI+BEA_ORIMOV)
	cOriMov	:= BEA->BEA_ORIMOV
	cSenInt	:= IIf(cOriMov=="1",M->BE1_YSENIN,BE4->BE4_SENHA)
	cAlias	:= "BD5"

ElseIf Alltrim(FunName()) $ "PLSA092"

	cChave := BE4->(BE4_CODLDP+BE4_CODPEG+BE4_NUMERO+BE4_ORIMOV)
	cOriMov := BE4->BE4_ORIMOV
	cSenInt	:= IIf(cOriMov=="1",M->BE4_SENHA,BE4->BE4_SENHA)
	cAlias	:= "BE4"

Else

	cChave  := BD6->(BD6_CODLDP+BD6_CODPEG+BD6_NUMERO+BD6_ORIMOV)
	cOriMov := BD6->BD6_ORIMOV
	cSenInt	:= IIf(cOriMov=="1",BD5->BD5_YSENIN,BE4->BE4_SENHA)
	cAlias	:= "BD5"

EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Insere critica de procedimento de internacao cobrado em guia ambulatorial³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//aIntern[] - retorno
//[1] = lInternado
//[2] = BE4->BE4_CODOPE
//[3] = BE4->BE4_CODLDP
//[4] = BE4->BE4_CODPEG
//[5] = BE4->BE4_NUMERO
//[6] = BE4->BE4_PADINT

aIntern := PLSUSRINTE(aDadUsr[2],dData,cHora,.T.,.F.,cAlias)

//Leonardo Portella - 11/11/13 - Virada P11 - Inicio - GHI estava recebendo logico ao inves de vetor
c_TipInter := ValType(aIntern)

//Leonardo Portella - 21/07/14 - Em alguns casos aIntern estava vindo vazio, fazendo com que criticasse indevidamente por regime de atendimento.
If ( c_TipInter == 'L' ) .or. ( ( c_TipInter == 'A' ) .and. empty(aIntern) )

	//If ValType(aIntern) == 'L'
	aIntern := PLSUSRINTE(aDadUsr[2],dData,cHora,.T.,.T.,cAlias,.T.)
	c_TipInter := ValType(aIntern)

EndIf
//Leonardo Portella - 11/11/13 - Virada P11 - Fim

If ( c_TipInter == 'L' )//Leonardo Portella - 21/07/14

	lInter := aIntern

ElseIf ( c_TipInter == 'A' ) .and. ( Len(aIntern) > 0 )

	lInter := aIntern[1]

EndIf

//*************************************************************************************************************
//*Leonardo Portella - 21/11/12 - Chamado ID 4281 - Inicio
//*Caso o Local de digitacao seja 0016 entao veio de uma guia na BE4, portanto trata-se de internacao.
//*Motivo: Nao criticar indevidamente internacoes geradas pela importacao por "regime de atendimento invalido"
//*************************************************************************************************************
/*
If BD6->BD6_CODLDP == '0016'
lInter := .T.
EndIf
*/
//Leonardo Portella - 21/11/12 - Fim

//*** Caso a funcao seja autoriza SADT, forca usuario internado! ***//

lCritRegProc := .F.	//Leonardo Portella - 25/08/14 - Estava criticando 2 vezes o mesmo procedimento pelo mesmo motivo, gerando 2 linhas na BDX (glosas)
/*
If (Alltrim(FunName()) == "PLSA092") .or. (Alltrim(FunName()) == "TMKA271") //Se for rotina de Aut Internacao Via PLS ou via Call Center
lInter := .T.
EndIf
*/

If 	( BCI->BCI_CODPEG == '00553434' )										.or.  ;
	( Alltrim(FunName()) == 'PLSA498' .or. IsInCallStack("PLSA175FAS") )	.and. ;
	( BAU->BAU_CODOPE $ GetNewPar("MV_YOPAVLC","") 	.or. ( BD6->BD6_CODLDP == '0017' ) )

	//So altero se o sistema nao autorizou
	If !lSistemaAut

		//Leonardo Portella - 29/08/12 - Chamado ID 3301 - Critica de regime de atendimento deve ser mantida inclusive em reciprocidade (impacto no SIP)
		If !( ( Type('aRetPad[2][1][1]') == 'C') .and. ( aRetPad[2][1][1] == '706' ) ) //BCT: 706 => Critica de Regime de atendimento

			//Bianchini - 04/09/2019 - Limpar Criticas se For Convenio desde que não seja Regime de Atendimento
			aRetFuncao := {.T.,{},aRetPad[3],aRetPad[4]}  //BIANCHINI - 29/10/2018 - Ajustando conteudo de posição do Array.  Coparts Ainda se perdem

			If alltrim( GetNewPar("MV_XLOGINT", '0') ) == '1'
				If FunName() == "PLSA092"
					u_LogMatInt(M->BE4_USUARI, M->BE4_NOMUSR, "PLSAUT02 - 3")
				EndIf
			EndIf

			Return(aRetFuncao)
		
		EndIf
	
	EndIf

EndIf
//Leonardo Portella - 27/04/15 - Fim

If !lWeb
	If AllTrim(FunName()) == "PLSA092"
		If Altera
			If cOriMov == "2" .and. !lInter

				If (Empty(BE4->BE4_HRALTA).Or.Empty(BE4->BE4_TIPALT)) .and. ( !Empty(BE4->BE4_DTALTA) )
					CritDtAlta(_cCodPad,_cCodPro,@aCriticas,@aRetFuncao)
				EndIf
			
			EndIf
		Endif
	EndIf
Endif
// Fim da critica de procedimento de internacao cobrado em guia ambulatorial

If !Empty(cSenInt) .and. !IsInCallStack("PROCONLINE")

	//Bianchini - 01/04/2019 - V12 - Inibindo Reembolso deste trecho, por não haver necessidade de checar os criterios abaixo
	If !(Alltrim(FunName()) $ "PLSA001|PLSA001A")

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Corrigir data de procedimento, caso seja mud. fase na dig. cts. medicas. ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If ! Alltrim(FunName()) $ "PLSA094B,PLSA092"
			_dDatPro := IIf(Empty(BD6->BD6_DATPRO),_dDatPro,BD6->BD6_DATPRO)
		Else
			If Alltrim(FunName()) == "PLSA092" .and. Type("M->BQV_CODPRO") == "C"
				_dDatPro := M->BQV_DATPRO
			EndIf
		EndIf

		cSQL := " SELECT BD5_CODLDP, BD5_CODPEG, BD5_NUMERO, BD5_ORIMOV, BD5_DATPRO, BD5_YSENIN, BD5_FASE, BD5_SITUAC, BD5_GUESTO, "
		cSQL += " BD5_CODRDA, BD5_OPEUSR, BD5_CODEMP, BD5_MATRIC, BD5_TIPREG FROM "+ RetSQLName("BD5")
		cSQL += " WHERE BD5_FILIAL = '"+xFilial("BD5")+"' AND "
		cSQL += " BD5_CODOPE = '"+plsintpad()+"' AND "
		cSQL += " BD5_YSENIN = '"+cSenInt+"' AND "
		cSQL += " BD5_SITUAC IN ('1','3') AND "
		cSQL += " BD5_FASE IN ('3','4') AND "
		cSQL += " BD5_GUESTO = ' ' AND "
		
		//Leonardo Portella - 07/04/15 - Excluir local de Recurso de glosas (0010) e de Rateio (0017)
		cSQL += " BD5_CODLDP NOT IN ('0010','0017') AND "
		cSQL += RetSQLName("BD5")+".D_E_L_E_T_ = ' ' "

		PLSQuery(cSQL,"TRBBD5")

		BD6->(DbSetOrder(6))
		BD7->(DbSetOrder(1))
		BE4->(DbSetOrder(7))
		BR8->(DbSetOrder(1))

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Em todas as guias de servicos, buscar o procedimento ja cobrado...       ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		While !TRBBD5->(Eof()) .and. alltrim(TRBBD5->BD5_YSENIN) == alltrim(cSenInt)

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Observar somente guias diferentes da guia em analise...                  ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If TRBBD5->BD5_FASE $ "3,4" .and. TRBBD5->BD5_SITUAC $ "1,3"

				If cChave <> TRBBD5->(BD5_CODLDP+BD5_CODPEG+BD5_NUMERO+BD5_ORIMOV)

					dDatGui := TRBBD5->BD5_DATPRO

					If !( Left(cChave,4) $ '0010|0017' )//Leonardo Portella - 07/04/15 - Excluir local de Recurso de glosas (0010) e de Rateio (0017)

						//-----------------------------------------------------------------------
						//Inicio - Angelo Henrique - Data: 18/08/2021
						//-----------------------------------------------------------------------
						//Após aplicação do Path da totvs o vetor reduziu de tamanho
						//colocando aqui para preencher a critica que ja veio no vetor
						//original caso não encontre
						//-----------------------------------------------------------------------
						If Len(aRetFuncao) < 3 .And. Len(aRetPad) > 3

							aadd(aRetFuncao,aRetPad[3])
							aadd(aRetFuncao,aRetPad[4])

						EndIf
						//-----------------------------------------------------------------------
						//Fim - Angelo Henrique - Data: 18/08/2021
						//-----------------------------------------------------------------------

						u_CritRecob(PLSINTPAD()+TRBBD5->(BD5_CODLDP+BD5_CODPEG+BD5_NUMERO+BD5_ORIMOV)+_cCodPad+_cCodPro,dDatGui,@aCriticas,@aRetFuncao,cCodRda,cOpeUsr,_cCodEmp,_cMatric,_cTipReg)
				
					EndIf
			
				EndIf
		
			EndIf

			TRBBD5->(DbSkip())
		Enddo
		TRBBD5->(DbCloseArea())

		BE4->(MsSeek(xFilial("BE4")+cSenInt))
		While !BE4->(Eof()) .and. BE4->BE4_SENHA == cSenInt

			dDatGui := BE4->BE4_DATPRO

			If cChave <> BE4->(BE4_CODLDP+BE4_CODPEG+BE4_NUMERO+BE4_ORIMOV)

				If BE4->BE4_SITUAC == "1,3" .and. BE4->BE4_FASE $ "3,4" .and. Empty(BE4->BE4_GUESTO)

					If !( Left(cChave,4) $ '0010|0017' )//Leonardo Portella - 07/04/15 - Excluir local de Recurso de glosas (0010) e de Rateio (0017)

						//-----------------------------------------------------------------------
						//Inicio - Angelo Henrique - Data: 18/08/2021
						//-----------------------------------------------------------------------
						//Após aplicação do Path da totvs o vetor reduziu de tamanho
						//colocando aqui para preencher a critica que ja veio no vetor
						//original caso não encontre
						//-----------------------------------------------------------------------
						If Len(aRetFuncao) < 3 .And. Len(aRetPad) > 3

							aadd(aRetFuncao,aRetPad[3])
							aadd(aRetFuncao,aRetPad[4])

						EndIf
						//-----------------------------------------------------------------------
						//Fim - Angelo Henrique - Data: 18/08/2021
						//-----------------------------------------------------------------------

						u_CritRecob(PLSINTPAD()+BE4->(BE4_CODLDP+BE4_CODPEG+BE4_NUMERO+BD4_ORIMOV)+_cCodPad+_cCodPro,dDatGui,@aCriticas,@aRetFuncao,cCodRda,cOpeUsr,_cCodEmp,_cMatric,_cTipReg)
					
					EndIf
				
				EndIf
			
			EndIf

			BE4->(DbSkip())
		Enddo

		//---------------------------------------------------------------------------------------------
		//Angelo Henrique - Data: 06/09/2018
		//---------------------------------------------------------------------------------------------
		//Restaurando a area aqui pois o processo continua e a BD4 estava desponterado
		//---------------------------------------------------------------------------------------------
		RestArea(aAreaBE4)

	Endif

Else   // BIANCHINI - 18/10/2018 - RDM315 - Só tratava em internação. Max solicita que exames sejam tratados

	//Bianchini - 01/04/2019 - V12 - Inibindo Reembolso deste trecho, por não haver necessidade de checar os criterios abaixo
	If !(Alltrim(FunName()) $ "PLSA001|PLSA001A")
	
		If (AllTrim(FunName()) $ "PLSA498|PLSA720") .OR. (IsInCallStack("PLSA175FAS"))

			//Seleção de todas as guias que este benificário possui para este
			cSQL := " SELECT BD5_CODLDP, BD5_CODPEG, BD5_NUMERO, BD5_ORIMOV, BD5_DATPRO, BD5_YSENIN, BD5_FASE, BD5_SITUAC, BD5_GUESTO " +CRLF
			cSQL += " BD5_CODRDA, BD5_OPEUSR, BD5_CODEMP, BD5_MATRIC, BD5_TIPREG " +CRLF
			cSQL += " FROM "+ RetSQLName("BD5") +" BD5 " +CRLF
			cSQL += " WHERE BD5_FILIAL = '"+xFilial("BD5")+"' AND " +CRLF
			cSQL += " BD5_CODOPE = '"+plsintpad()+"' AND " +CRLF
			cSQL += " BD5_CODRDA = '"+cCodRda    +"' AND " +CRLF
			cSQL += " BD5_OPEUSR = '"+cOpeUsr    +"' AND " +CRLF
			cSQL += " BD5_CODEMP = '"+_cCodEmp   +"' AND " +CRLF
			cSQL += " BD5_MATRIC = '"+_cMatric   +"' AND " +CRLF
			cSQL += " BD5_TIPREG = '"+_cTipReg   +"' AND " +CRLF
			cSQL += " BD5_SITUAC IN ('1','3') AND " +CRLF
			cSQL += " BD5_VLRGLO = 0 AND " +CRLF
			cSQL += " BD5_GUESTO = ' ' AND " +CRLF
			cSQL += " BD5_CODLDP NOT IN ('0000','0010','0017','0020') AND " +CRLF
			cSQL += " BD5.D_E_L_E_T_ = ' ' " +CRLF

			MEMOWRITE('c:\temp\rdm315.sql',cSQL)

			PLSQuery(cSQL,"TRBBD5")

			While !TRBBD5->(EOF())

				If !( Left(cChave,4) $ '0000|0010|0017' )//Leonardo Portella - 07/04/15 - Excluir local de Recurso de glosas (0010) e de Rateio (0017)

					//-------------------------------------------------------------------------
					//Inicio - Angelo Henrique - Data: 18/08/2021
					//-------------------------------------------------------------------------
					//Após aplicação do Path da totvs o vetor reduziu de tamanho
					//colocando aqui para preencher a critica que ja veio no vetor
					//original caso não encontre
					//-------------------------------------------------------------------------
					If Len(aRetFuncao) < 3 .And. Len(aRetPad) > 3

						aadd(aRetFuncao,aRetPad[3])
						aadd(aRetFuncao,aRetPad[4])

					EndIf
					//-------------------------------------------------------------------------
					//Fim - Angelo Henrique - Data: 18/08/2021
					//-------------------------------------------------------------------------

					u_CritRecob(PLSINTPAD()+TRBBD5->(BD5_CODLDP+BD5_CODPEG+BD5_NUMERO+BD5_ORIMOV)+_cCodPad+_cCodPro,dDatGui,@aCriticas,@aRetFuncao,cCodRda,cOpeUsr,_cCodEmp,_cMatric,_cTipReg)
				
				EndIf

				TRBBD5->(DbSkip())
			Enddo
			TRBBD5->(DbCloseArea())

		Endif
	
	Endif

EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Caso seja mud. fase de guias de servico, e procedimento OPME, deve fazer ³
//³ a critica conforme realizado na guia de internacao...                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If cAlias == "BD5"

	If BR8->(FieldPos("BR8_ALTCUS")) > 0 .and. PLSPOSGLO(PLSINTPAD(),__aCdCri109[1],__aCdCri109[2],cLocalExec,"1") .and. ; // Critica "066" Ativa
		PLSPOSGLO(PLSINTPAD(),__aCdCri110[1],__aCdCri110[2],cLocalExec,"1") .and. ; // Critica "067" Ativa
		PLSPOSGLO(PLSINTPAD(),__aCdCri111[1],__aCdCri111[2],cLocalExec,"1")         // Critica "068" Ativa

		If (BR8->BR8_ALTCUS == "1") .AND. BD6->BD6_CODLDP <> "0013" // Se eh Material/Procedimento de Alto Custo E CODLPD DE OPME OU FARMACIA

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Pesquisa tabela de relacionamento entre NF Entrada x Guias Internacao ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			B19->(dbSetOrder(2))
			lTemNFE := B19->(MsSeek(xFilial("B19")+BD6->(BD6_CODOPE+BD6_CODLDP+BD6_CODPEG+BD6_NUMERO+BD6_ORIMOV+BD6_SEQUEN)))

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Se encontrou o relacionamento, busca a NF Entrada para obter o valor a cobrar/pagar ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If lTemNFE
				SD1->(dbSetOrder(1)) // D1_FILIAL+D1_DOC+D1_SERIE+D1_FORNECE+D1_LOJA+D1_COD+D1_ITEM
				lTemNFE := SD1->(MsSeek(xFilial("SD1")+B19->(B19_DOC+B19_SERIE+B19_FORNEC+B19_LOJA+B19_COD+B19_ITEM)))
			EndIf

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Se encontrou NF de Entrada:                                             ³
			//³ O valor a pagar/cobrar sera o valor da NF de Entrada e deve bloquear o  ³
			//³ pagamento deste material/procedimento de alto custo.                    ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If lTemNFE

				PLSPOSGLO(PLSINTPAD(),__aCdCri109[1],__aCdCri109[2],cLocalExec,"1")
				CriOPMSADT(_cCodPad,_cCodPro,@aCriticas,@aRetFuncao,"066","Evento de alto custo. O valor a ser cobrado/pago deve ser analisado.")

				BD6->(RecLock("BD6", .F.))
					BD6->BD6_VLRAPR := SD1->(D1_TOTAL/D1_QUANT)
				BD6->(MsUnlock())

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Se nao encontrou NF Entrada:                                            ³
			//³ O valor a pagar/cobrar devera ser informado (digitado pelo usuario).    ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			Else

				PLSPOSGLO(PLSINTPAD(),__aCdCri110[1],__aCdCri110[2],cLocalExec,"1")
				CriOPMSADT(_cCodPad,_cCodPro,@aCriticas,@aRetFuncao,"067","Evento de alto custo. NF de Entrada nao foi Localizada. O valor a ser cobrado/pago deve ser atualizado manualmente.")

			EndIf
		
		EndIf
	
	EndIf

EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Se nao encontrou NF Entrada:                                            ³
//³ O valor a pagar/cobrar devera ser informado (digitado pelo usuario).    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Manter esta funcionalidade em ultimo lugar,devido a tratar-se de 	    ³
//³ exclusao de critica de auditoria ja realizada em GIH.					³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If Alltrim(FunName()) $ "PLSA001|PLSA001A"

	lLimpou := .F. ///Variavel de Controle
	If !aRetFuncao[1]

		For nCont := 1 to Len(aRetFuncao[2])

			If aRetFuncao[2,nCont,1]=="025" //.or. !Empty(aRetFuncao[2,nCont,2])

				If lInter

					//Query Para ver se o Procedimento Pertence à Senha informada e se foi auditado
					cSQL := " SELECT BVX.* "
					cSQL += " FROM "+RetSQLName("BVX")+" BVX, "+RetSQLName("BE4")+" BE4 "
					cSQL += " WHERE BVX_FILIAL = '"+xFilial("BVX")+"' "
					cSQL += " AND BE4_FILIAL = '"+xFilial("BE4")+"' "
					cSQL += " AND BE4_CODOPE = '"+aIntern[2]+"' "
					cSQL += " AND BE4_CODLDP = '"+aIntern[3]+"' "
					cSQL += " AND BE4_CODPEG = '"+aIntern[4]+"' "
					cSQL += " AND BE4_NUMERO = '"+aIntern[5]+"' "
					cSQL += " AND BE4_SENHA  = '"+cSenInt+"' "
					cSQL += " AND BE4_ORIMOV = '2' "
					cSQL += " AND BVX_OPEMOV = BE4_CODOPE "
					cSQL += " AND BVX_ANOAUT = BE4_ANOINT "
					cSQL += " AND BVX_MESAUT = BE4_MESINT "
					cSQL += " AND BVX_NUMAUT = BE4_NUMINT "
					//BIANCHINI - 12/02/2021 - Retirada temporária da validação de procedimentos em internação
					//            Casos em que o hospital não entregue documentação da cirurgia estão emperrando
					//            o processo de reembolso podendo gerar NIP
					//            A SOLUÇÃO DEFINITIVA depende da RR compilar uma função no PLSA001
					//cSQL += " AND BVX_CODPAD = '"+_cCodPad+"' "
					//cSQL += " AND BVX_CODPRO = '"+_cCodPro+"' "
					cSQL += " AND BVX.D_E_L_E_T_ = ' ' "
					cSQL += " AND BE4.D_E_L_E_T_ = ' ' "
				
				else  //BIANCHINI - 25/03/2014 - Funcionalidade para tratar Eventos Auditados provenientes do LIBERA (Reg Amb.)

					cSQL := " SELECT BVX.* "
					cSQL += " FROM "+RetSQLName("BVX")+" BVX, "+RetSQLName("BEA")+" BEA "
					cSQL += " WHERE BVX_FILIAL = '"+xFilial("BVX")+"' "
					cSQL += " AND BEA_FILIAL = '"+xFilial("BEA")+"' "
					cSQL += " AND BEA_ORIMOV <> '2' "
					cSQL += " AND BVX_OPEMOV = BEA_OPEMOV "
					cSQL += " AND BVX_ANOAUT = BEA_ANOAUT "
					cSQL += " AND BVX_MESAUT = BEA_MESAUT "
					cSQL += " AND BVX_NUMAUT = BEA_NUMAUT "
					cSQL += " AND BEA_SENHA  = '"+M->B44_YSENHA+"' "
					//BIANCHINI - 12/02/2021 - Retirada temporária da validação de procedimentos em internação
					//            Casos em que o hospital não entregue documentação da cirurgia estão emperrando
					//            o processo de reembolso podendo gerar NIP
					//            A SOLUÇÃO DEFINITIVA depende da RR compilar uma função no PLSA001
					//SQL += " AND BVX_CODPAD = '"+_cCodPad+"' "
					//cSQL += " AND BVX_CODPRO = '"+_cCodPro+"' "
					cSQL += " AND BVX.D_E_L_E_T_ = ' ' "
					cSQL += " AND BEA.D_E_L_E_T_ = ' ' "
				
				EndIf

				PLSQuery(cSQL,"TRBAUT02")

				If TRBAUT02->BVX_PARECE == "0"

					aDel(aRetFuncao[2],nCont)
					asize(aRetFuncao[2],Len(aRetFuncao[2])-1)

					//BIANCHINI - 14/01/2014 - Acrescentado este IF para remover tambem a linha descritiva do nivel de Critica. a Versao 11 preenche o Array
					//com 2 linhas e impede a evolução do calculo de reembolso    Ex.: "Nível: BRV - Planos e Grupos de Cobertura ".
					If  aRetFuncao[2,nCont,2] <> ' '
						aDel(aRetFuncao[2],nCont)
						asize(aRetFuncao[2],Len(aRetFuncao[2])-1)
					EndIf
					//BIANCHINI - FIM

					lExcAudit := .T.
					nCont := 9999
					lLimpou := .T.
					TRBAUT02->(DbCloseArea())
				
				EndIf

				//BIANCHINI - 16/06/2014
				//CHAMADO 12025 - UM PROCEDIMENTO QUE NECESSITA DE PERICIA MEDICA NAO TINHA LINHAS NA AUDITORIA QUE SERVISSE COMO REFERENCIA
				//PARA A ROTINA.  POR ISSO TRATO A EXCECAO ABAIXO, VERIFICANDO SE NA AUTORIZACAO OU NA PRORROGACAO TENHO O PROCEDIMENTO JA LIBERADO PARA
				//ELIMINAR A CRITICA DO VETOR DE CRITICAS.
				If !lLimpou

					If lInter

						If empty(TRBAUT02->BVX_PARECE)

							cSQL := "  SELECT BEJ_SEQUEN SEQUEN "
							cSQL += "       , BEJ_CODPAD CODPAD "
							cSQL += "       , BEJ_CODPRO CODPRO "
							cSQL += "	    , BEJ_DESPRO DESPRO "
							cSQL += "	    , BEJ_NIVCRI NIVCRI "
							cSQL += "	    , BEJ_AUDITO AUDITO "
							cSQL += "	    , BEJ_STATUS STATUS "
							cSQL += "	 FROM "+RetSQLName("BE4")+" BE4 "
							cSQL += "	    , "+RetSQLName("BEJ")+" BEJ "
							cSQL += "   WHERE BE4_FILIAL = '"+xFilial("BE4")+"' "
							cSQL += "     AND BEJ_FILIAL = '"+xFilial("BEJ")+"' "
							cSQL += "	  AND BE4_CODOPE = '0001' "
							cSQL += "	  AND BE4_ORIMOV = '2'    "
							cSQL += "	  AND BE4_SENHA = '"+cSenInt+"'"
							cSQL += "	  AND BE4_CODOPE = BEJ_CODOPE   "
							cSQL += "	  AND BE4_ANOINT = BEJ_ANOINT   "
							cSQL += "	  AND BE4_MESINT = BEJ_MESINT   "
							cSQL += "	  AND BE4_NUMINT = BEJ_NUMINT   "
							//BIANCHINI - 12/02/2021 - Retirada temporária da validação de procedimentos em internação
							//            Casos em que o hospital não entregue documentação da cirurgia estão emperrando
							//            o processo de reembolso podendo gerar NIP
							//            A SOLUÇÃO DEFINITIVA depende da RR compilar uma função no PLSA001
							//cSQL += "     AND BEJ_CODPAD = '"+_cCodPad+"' "
							//cSQL += "     AND BEJ_CODPRO = '"+_cCodPro+"' "
							//cSQL += "     AND BEJ_STATUS = '1'			"
							cSQL += "	  AND BE4.D_E_L_E_T_ = ' '      "
							cSQL += "	  AND BEJ.D_E_L_E_T_ = ' '      "

							cSQL += "	UNION ALL                       "

							cSQL += "  SELECT BQV_SEQUEN SEQUEN "
							cSQL += "       , BQV_CODPAD CODPAD "
							cSQL += "       , BQV_CODPRO CODPRO "
							cSQL += "	    , BQV_DESPRO DESPRO "
							cSQL += "	    , BQV_NIVCRI NIVCRI "
							cSQL += "	    , BQV_AUDITO AUDITO "
							cSQL += "	    , BQV_STATUS STATUS "
							cSQL += "	 FROM "+RetSQLName("BE4")+" BE4 "
							cSQL += "	    , "+RetSQLName("B4Q")+" B4Q "
							cSQL += "	    , "+RetSQLName("BQV")+" BQV "
							cSQL += "   WHERE BE4_FILIAL = '"+xFilial("BE4")+"' "
							cSQL += "     AND B4Q_FILIAL = '"+xFilial("B4Q")+"' "
							cSQL += "     AND BQV_FILIAL = '"+xFilial("BQV")+"' "
							cSQL += "	  AND BE4_CODOPE = '0001'       "
							cSQL += "	  AND BE4_ORIMOV = '2'          "
							cSQL += "	  AND BE4_SENHA = '"+cSenInt+"'"
							cSQL += "	  AND BE4_CODOPE = SUBSTR(B4Q_GUIREF,1,4)   "
							cSQL += "	  AND BE4_ANOINT = SUBSTR(B4Q_GUIREF,5,4)   "
							cSQL += "	  AND BE4_MESINT = SUBSTR(B4Q_GUIREF,9,2)   "
							cSQL += "	  AND BE4_NUMINT = SUBSTR(B4Q_GUIREF,11,8)   "
							cSQL += "	  AND B4Q_OPEMOV = BQV_CODOPE   "
							cSQL += "	  AND B4Q_ANOAUT = BQV_ANOINT   "
							cSQL += "	  AND B4Q_MESAUT = BQV_MESINT   "
							cSQL += "	  AND B4Q_NUMAUT = BQV_NUMINT   "
							//BIANCHINI - 12/02/2021 - Retirada temporária da validação de procedimentos em internação
							//            Casos em que o hospital não entregue documentação da cirurgia estão emperrando
							//            o processo de reembolso podendo gerar NIP
							//            A SOLUÇÃO DEFINITIVA depende da RR compilar uma função no PLSA001
							//cSQL += "     AND BQV_CODPAD = '"+_cCodPad+"' "
							//cSQL += "     AND BQV_CODPRO = '"+_cCodPro+"' "
							cSQL += "     AND BQV_STATUS = '1'			"
							cSQL += "	  AND BE4.D_E_L_E_T_ = ' '      "
							cSQL += "	  AND B4Q.D_E_L_E_T_ = ' '      "
							cSQL += "	  AND BQV.D_E_L_E_T_ = ' '      "

							TRBAUT02->(DbCloseArea())

							PLSQuery(cSQL,"TRBAUT02")
						
						EndIf
					
					Else  ///Se nao estiver internado(ambulatorial)

						If empty(TRBAUT02->BVX_PARECE)

							cSQL := "  SELECT BE2_SEQUEN SEQUEN "
							cSQL += "       , BE2_CODPAD CODPAD "
							cSQL += "       , BE2_CODPRO CODPRO "
							cSQL += "	    , BE2_DESPRO DESPRO "
							cSQL += "	    , BE2_NIVCRI NIVCRI "
							cSQL += "	    , BE2_AUDITO AUDITO "
							cSQL += "	    , BE2_STATUS STATUS "
							cSQL += "	 FROM "+RetSQLName("BEA")+" BEA "
							cSQL += "	    , "+RetSQLName("BE2")+" BE2 "
							cSQL += "   WHERE BEA_FILIAL = '"+xFilial("BEA")+"' "
							cSQL += "     AND BE2_FILIAL = '"+xFilial("BE2")+"' "
							cSQL += "	  AND BEA_OPEMOV = '0001' "
							cSQL += "	  AND BEA_ORIMOV <> '2'   "
							cSQL += "	  AND BEA_SENHA = '"+cSenInt+"'"
							cSQL += "	  AND BEA_OPEMOV = BE2_OPEMOV   "
							cSQL += "	  AND BEA_ANOAUT = BE2_ANOAUT   "
							cSQL += "	  AND BEA_MESAUT = BE2_MESAUT   "
							cSQL += "	  AND BEA_NUMAUT = BE2_NUMAUT   "
							//BIANCHINI - 12/02/2021 - Retirada temporária da validação de procedimentos em internação
							//            Casos em que o hospital não entregue documentação da cirurgia estão emperrando
							//            o processo de reembolso podendo gerar NIP
							//            A SOLUÇÃO DEFINITIVA depende da RR compilar uma função no PLSA001
							//cSQL += "     AND BE2_CODPAD = '"+_cCodPad+"' "
							//cSQL += "     AND BE2_CODPRO = '"+_cCodPro+"' "
							cSQL += "	  AND BEA.D_E_L_E_T_ = ' '      "
							cSQL += "	  AND BE2.D_E_L_E_T_ = ' '      "

							TRBAUT02->(DbCloseArea())

							PLSQuery(cSQL,"TRBAUT02")
						
						EndIf
					
					EndIf

					//If (TRBAUT02->STATUS == '1') .and. (EMPTY(TRBAUT02->NIVCRI))
					//Fabio Bianchini - 18/11/2020 - Chamado 71765 - O tratamento do Status de Auditoria passou ficar na Query para garantir uma unica linha
					If !(TRBAUT02->(EOF()))

						aDel(aRetFuncao[2],nCont)
						asize(aRetFuncao[2],Len(aRetFuncao[2])-1)

						//BIANCHINI - 14/01/2014 - Acrescentado este IF para remover tambem a linha descritiva do nivel de Critica. a Versao 11 preenche o Array
						//com 2 linhas e impede a evolução do calculo de reembolso    Ex.: "Nível: BRV - Planos e Grupos de Cobertura ".
						If  aRetFuncao[2,nCont,2] <> ' '
							aDel(aRetFuncao[2],nCont)
							asize(aRetFuncao[2],Len(aRetFuncao[2])-1)
						EndIf
						//BIANCHINI - FIM

						lExcAudit := .T.
						nCont := 9999
						lLimpou := .T.

						TRBAUT02->(DbCloseArea())
					EndIf
					//FIM CHAMADO 12025
				
				EndIf
			
			EndIf
		
		Next
	
	EndIf

	If lExcAudit
		If Len(aRetFuncao[2]) == 0
			aRetFuncao[1] := .T.
		EndIf
	EndIf

	//Retira a critica 09N. Se a mesma não existir não altera o vetor
	aRetFuncao := aRetCri('09N', aRetFuncao, aRetPad, @lSistemaAut)

Else

	If !(cEmpAnt == '01' .And. BD6->BD6_CODEMP == '0004') .And. ALLTRIM(UPPER(FUNNAME())) <> "PLSA094B"
	
		RestArea(aAreaBD6)
		//------------------------------------------------------
		// Inicio - Angelo Henrique - Data: 13/03/2018
		//------------------------------------------------------
		//Fatura 60/90 Dias - Chamado: 47856
		//------------------------------------------------------
		If BD6->BD6_CODLDP $ "0002|0001"

			_aArBAU	:= BAU->(GetArea())

			DbSelectArea("BAU")
			DbSetOrder(1)
			If DbSeek(xFilial("BAU") + BD6->BD6_CODRDA) //BAU_CODIGO = BD6_CODRDA

				If UPPER(AllTrim(BAU->BAU_TIPPRE)) != "OPE"

					If !(Empty(AllTrim(BAU->BAU_XPRENT)))

						_cUltDia := LastDay(MonthSub(dDataBase,1))

						If ((_cUltDia - BD6->BD6_DATPRO) > Val(BAU->BAU_XPRENT))

							_aRetNv1 := {}
							_aRetNv1 := {	"09N",;
											"Data de entrega fora do prazo",;
											"",;
											"2",;
											"1",;
											"16",;
											AllTrim(BD6->BD6_CODPRO)}
							_aRetNv2 := {}
							_aRetNv2 := {	" ",;
											"Nivel BEA - Complementos Movimentações",;
											"02 - Esta é uma Crítica de atendimento e não possui caminho.",;
											NIL,;
											"",;
											"",;
											""}
							
							If Len(aRetFuncao) > 0

								If  !aRetFuncao[1]
									aAdd(aRetFuncao[2], _aRetNv1)
									aAdd(aRetFuncao[2], _aRetNv2)
								Else

									//BIANCHINI - 27/11/2018 - ALTERADO MOMENTANEAMENTE, POIS AS COPARTS SE PERDEM APOS ANALISE DE GLOSAS
									//						   NÃO SE PODE FORÇAR A CHAVE DE NIVEL BEA COM CODIGO DE PROCEDIMENTO PORQUE NEM SEMPRE CAIRA COMO
									//						   INTERNAÇÃO, ALÉM DO QUE ESTA POSIÇÃO DE ARRAY INDICA O NIVEL DE OND EO SISTEMA PEGA A COPART
									//aRetFuncao := {.F.,{_aRetNv1,_aRetNv2},"BEA",AllTrim("0"+cCdTbPd+cCodPro)}
									aRetFuncao[1] := .F.
									aRetFuncao[2] := {_aRetNv1,_aRetNv2}
								
								EndIf
							
							Else

								//BIANCHINI - 27/11/2018 - ALTERADO MOMENTANEAMENTE, POIS AS COPARTS SE PERDEM APOS ANALISE DE GLOSAS
								//						   NÃO SE PODE FORÇAR A CHAVE DE NIVEL BEA COM CODIGO DE PROCEDIMENTO PORQUE NEM SEMPRE CAIRA COMO
								//						   INTERNAÇÃO, ALÉM DO QUE ESTA POSIÇÃO DE ARRAY INDICA O NIVEL DE OND EO SISTEMA PEGA A COPART
								//aRetFuncao := {.F.,{_aRetNv1,_aRetNv2},"BEA",AllTrim("0"+cCdTbPd+cCodPro)}
								aRetFuncao[1] := .F.
								aRetFuncao[2] := {_aRetNv1,_aRetNv2}
							
							EndIf

							_aArBDX	:= BDX->(GetArea())

							DbSelectArea("BDX")
							DbSetOrder(1) //BDX_FILIAL+BDX_CODOPE+BDX_CODLDP+BDX_CODPEG+BDX_NUMERO+BDX_ORIMOV+BDX_CODPAD+BDX_CODPRO+BDX_SEQUEN+BDX_CODGLO
							If !(DbSeek(xFilial("BDX")+BD6->(BD6_CODOPE+BD6_CODLDP+BD6_CODPEG+BD6_NUMERO+BD6_ORIMOV+BD6_CODPAD+BD6_CODPRO+BD6_SEQUEN+"09N")))

								If BD6->BD6_VLRPAG == 0

									aValor := PLSCALCEVE(	BD6->BD6_CODPAD,BD6->BD6_CODPRO,BD6->BD6_MESPAG,BD6->BD6_ANOPAG,;
															PLSINTPAD(),BD6->BD6_CODRDA,BD6->BD6_CODESP,BD6->BD6_SUBESP,;
															BD6->BD6_CODLOC,BD6->BD6_QTDPRO,_dDatPro,aDadUsr[48],cPadInt,cRegAte,BD6->BD6_VLRAPR,aDadUsr,cPadCon,;
															{},nil,nil,nil,nil,cHorPro,aRdas,nil,BD6->BD6_PROREL,BD6->BD6_PRPRRL,; //1o parametro = aQtdPer
															{},nil,_dDatPro,cHorPRo,{},BD6->BD6_TIPGUI,.F.,BD6->BD6_VLRAPR,{},nil,; //1o parametro = aValAcu / 5o = aUnidsBlo / 9o = aVlrBloq
															.F.,0,BD6->BD6_REGPAG,BD6->BD6_REGCOB) //1o- lCirurgico / 2o - nPerVia
									
									If !Empty(aValor)

										For nQtdVal := 1 to Len(aValor[1])

											If AllTrim(aValor[1][nQtdVal][1]) <> "PA"

												If Len(aValor[1][nQtdVal][5]) > 0

													nVlrRea   := aValor[1][nQtdVal][5][1][1] * aValor[1][nQtdVal][5][1][3]
													nSomaProc := nSomaProc + nVlrRea
												
												Else

													nSomaProc := nSomaProc + (BD6->BD6_VLRAPR * BD6->BD6_QTDPRO)
												
												Endif
											
											Endif
										
										Next nQtdVal
									
									Endif
								
								Endif

								For _ni := 1 To 2

									_aArBR8 := BR8->(GetArea())

									BDX->(Reclock("BDX",.T.))

										BDX->BDX_FILIAL := xFilial('BDX')
										BDX->BDX_IMGSTA := 'BR_VERMELHO'
										BDX->BDX_CODOPE := BD6->BD6_CODOPE
										BDX->BDX_CODLDP := BD6->BD6_CODLDP
										BDX->BDX_CODPEG	:= BD6->BD6_CODPEG
										BDX->BDX_NUMERO := BD6->BD6_NUMERO
										BDX->BDX_ORIMOV := BD6->BD6_ORIMOV
										BDX->BDX_CODPAD := BD6->BD6_CODPAD
										BDX->BDX_CODPRO := BD6->BD6_CODPRO
										BDX->BDX_SEQUEN := BD6->BD6_SEQUEN
										BDX->BDX_CODGLO	:= "09N"
										BDX->BDX_VLRAPR := BD6->BD6_VLRAPR
										BDX->BDX_VLRAP2 := BD6->BD6_VLRAPR
										BDX->BDX_VLRBPR := BD6->BD6_VLRBPR
										BDX->BDX_VLRBP2 := BD6->BD6_VLRBPR
										
										//Bianchini - 06/06/2019 - Zerando Valores indevidamente na P12
										//BDX->BDX_VLRMAN := BD6->BD6_VLRMAN
										If BDX->BDX_VLRMAN  == 0
											BDX->BDX_VLRMAN  := IIF(BD6->BD6_VLRAPR <= nSomaProc,BD6->BD6_VLRAPR * BD6->BD6_QTDPRO,nSomaProc)
										Else
											BDX->BDX_VLRMAN  := BD6->BD6_VLRMAN
										Endif
										//Bianchini - 06/06/2019 - Zerando Valores indevidamente na P12
										//BDX->BDX_VLRMA2 := BD6->BD6_VLRMAN
										If BDX->BDX_VLRMA2  == 0
											BDX->BDX_VLRMA2  := IIF(BD6->BD6_VLRAPR <= nSomaProc,BD6->BD6_VLRAPR * BD6->BD6_QTDPRO,nSomaProc)
										Else
											BDX->BDX_VLRMA2  := BD6->BD6_VLRMAN
										Endif

										//Bianchini - 06/06/2019 - Zerando Valores indevidamente na P12
										//BDX->BDX_VLRPAG := IIF(BDX->BDX_VLRGL2 >= BD6->BD6_VLRMAN,0,BD6->BD6_VLRMAN-BDX->BDX_VLRGL2)
										If BD6->BD6_VLRPAG == 0
											BDX->BDX_VLRPAG := IIF(BD6->BD6_VLRAPR <= nSomaProc,BD6->BD6_VLRAPR * BD6->BD6_QTDPRO,nSomaProc)
										Else
											BDX->BDX_VLRPAG := BD6->BD6_VLRPAG
										Endif

										BDX->BDX_PERGLO := BDX->BDX_PERGL2
										BDX->BDX_VLRGLO := BDX->BDX_VLRGL2
										BDX->BDX_DESPRO := Posicione("BR8",1,xFilial("BR8")+BD6->(BD6_CODPAD + BD6_CODPRO),"BR8_DESCRI")
										BDX->BDX_GLOSIS := "09N"
										//BDX->BDX_DTACAO := dDataBase
										BDX->BDX_DATPRO	:= BD6->BD6_DATPRO
										BDX->BDX_QTDPRO	:= BD6->BD6_QTDPRO
										BDX->BDX_TIPGLO	:= '1'

										If _ni = 1

											BDX->BDX_NIVEL 	:= '2'
											BDX->BDX_DESGLO	:= "Data de entrega fora do prazo"
											BDX->BDX_INFGLO := ""
											BDX->BDX_TIPREG := "1"
											BDX->BDX_CRIANA	:= '0'
											BDX->BDX_VLRAPR := BD6->BD6_VLRAPR

										Else

											BDX->BDX_NIVEL 	:= ''
											BDX->BDX_DESGLO	:= "Nivel: BEA - Complementos Movimentacoes "
											BDX->BDX_INFGLO := "02 - Esta e uma Critica de atendimento e nao possui caminho."
											BDX->BDX_TIPREG := "2"
											BDX->BDX_VLRAPR := 0

										EndIf
									
									BDX->(MsUnlock())

									RestArea(_aArBR8)
								
								Next _ni
							
							EndIf

							RestArea(_aArBDX)
						EndIf
					
					EndIf
				
				Else

					//-----------------------------------------------------------------
					//Caso o padrão coloque a critica, a mesma será retirada.
					//-----------------------------------------------------------------
					If Len(aRetFuncao) > 0
						aRetFuncao := aRetCri('09N', aRetFuncao, aRetPad, @lSistemaAut)
					EndIf
				
				EndIf
			
			EndIf

			RestArea(_aArBAU)
		EndIf
	
	EndIf
	//------------------------------------------------------
	// Fim - Angelo Henrique - Data: 13/03/2018
	//------------------------------------------------------

EndIf

If alltrim( GetNewPar("MV_XLOGINT", '0') ) == '1'
	If FunName() == "PLSA092"
		u_LogMatInt(M->BE4_USUARI, M->BE4_NOMUSR, "PLSAUT02 - 4")
	EndIf
EndIf

RestArea(aAreaBD5)
RestArea(aAreaBD6)
RestArea(aAreaBD7)
RestArea(aAreaBE4)
RestArea(aAreaBR8)
RestArea(aAreaBKD)
RestArea(aAreaB19)
RestArea(aAreaSD1)
RestArea(aAreaBAU)
RestArea(aAreaBDX)
RestArea(aAreaBBK)
RestArea(aAreaBCT)

Return(aRetFuncao)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CritDtAltaºAutor  ³Microsiga           º Data ³  11/09/07   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Gera critica caso seja informada data de alta, porem sem    º±±
±±º          ³hora ou tipo de alta.                                       º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function CritDtAlta(cCodPad,cCodPro,aCrit,aRetF)

	Local cCodCri := "707"
	Local cDesCri := "Informada dt. de alta mas nao possui hora de alta e/ou tipo de alta"
	Local cNivel := aRetF[3] //Nunca Alterar (Falha na cobranca de copart)...
	Local cChaAut	:= aRetF[4] //Nunca Alterar (Falha na cobranca de copart)...

	aAdd(aCrit,{cCodCri,cDesCri,BD6->BD6_CODLDP+"."+BD6->BD6_CODPEG+"."+BD6->BD6_NUMERO,BCT->BCT_NIVEL,BCT->BCT_TIPO,cCodPad,cCodPro})

	aRetF := {.F.,aCrit,cNivel,cChaAut,.F.}

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³PLSAUT02  ºAutor  ³CriOPMSADT			  º Data ³  05/05/09   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function CriOPMSADT(cCodPad,cCodPro,aCrit,aRetF,cCodCrit,cDescCrit)

	Local cCodCri	:= cCodCrit
	Local cDesCri	:= cDescCrit
	Local cNivel	:= iif(len(aRetF) >= 3, aRetF[3], "BR8")				// FRED: se não tem critica - nivel na Tab. Padrão
	Local cChaAut	:= iif(len(aRetF) >= 4, aRetF[4], cCodPad+cCodPro)		// FRED: se não tem critica - nivel na Tab. Padrão

	aAdd(aCrit,{cCodCri,cDesCri,BD6->BD6_CODLDP+"."+BD6->BD6_CODPEG+"."+BD6->BD6_NUMERO+"-"+BD6->BD6_SEQUEN,BCT->BCT_NIVEL,BCT->BCT_TIPO,cCodPad,cCodPro})

	aRetF := {.F.,aCrit,cNivel,cChaAut,.F.}

Return

//---------------------------------------------------------------------------------
//Verifica os tipos de redes de atendimento vinculados ao RDA (BBK e BI5)
//---------------------------------------------------------------------------------
Static Function cTipRedAte(c_CodRDA)

	Local aArea 		:= GetArea()
	Local aAreaBBK		:= BBK->(GetArea())
	Local cTipsRedAt 	:= ''

	BBK->(DbSetOrder(1))//BBK_FILIAL, BBK_CODIGO, BBK_CODINT, BBK_CODLOC

	If BBK->(DbSeek(xFilial('BBK') + c_CodRDA))

		While !BBK->(EOF()) .and. ( BBK->BBK_CODIGO == c_CodRDA )

			cTipsRedAt += BBK->BBK_CODRED + '|'

			BBK->(DbSkip())

		EndDo

	EndIf

	BBK->(RestArea(aAreaBBK))
	RestArea(aArea)

Return cTipsRedAt


//-------------------------------------------------------------------------------------------
//Verifica se deve a guia se enquadra no caso de glosa das empresas do Estaleiro
//-------------------------------------------------------------------------------------------
User Function aCriEstaleiro

	Local lCritica 	:= .F.
	Local lPagar	:= .F.
	Local nPerCop	:= 0
	Local cPEGsExc	:= ''

	//Mudanca de escopo: Max informou que devem ser as PEGs abaixo independente da data de realizacao
	cPEGsExc := '00091011|00091014|00091052|00091054|00091055|00091067|00091075|00091053|'
	cPEGsExc += '00091068|00091069|00091070|00091285|00091286|'
	cPEGsExc += '00093071|00093072|'
	cPEGsExc += '00091068|00093429|00093422|00093421|00093420|00093419|00093417|00093401|00093254|00091286|00091285|00091070|00091069'
	cPEGsExc += '00091566|00093129|00093130|00093131|00093132|00093162|00093163|00093167|00093168|00093338|00093339|00093366|00093367|00093368|00093411|00093412|00093413|00093414'

	lCritica := 	( cEmpAnt == '02' ) .and. /*Integral*/;
		( BCL->BCL_ALIAS == 'BD5' ) .and. ;
		( Alltrim(FunName()) $ 'PLSA498|PLSA475' .or. IsInCallStack("PLSA175FAS") .or. IsInCallStack("PLS720IBD7") ) .and. /*Rotinas da Digitacao CM ou Mudanca fase lote ou inclusao de BD7 (quando cria a composicao do evento)*/;
		( BD5->BD5_CODEMP $ GetNewPar('MV_XEMPEST','0180|0183|0188|0189|0190')/*EMPresas ESTaleiro*/ ) .and. ;
		( BD5->BD5_REGATE == "2" )/*BD5_REGATE => 1=Internacao; 2=Ambulatorial*/ .and. ;
		( GetNewPar('MV_XTRDEST','13') $ cTipRedAte(BD5->BD5_CODRDA) )//MV_XTRDEST: Tipo ReDe ESTaleiro - BI5020: 13 => CPPS

	//--------------------------------------
	//Angelo Henrique - 28/08/2015
	//--------------------------------------
	lCaber := 	( cEmpAnt == '01' ) .and. ;
		( BCL->BCL_ALIAS == 'BD5' ) .and. ;
		( Alltrim(FunName()) $ 'PLSA498|PLSA475' .or. IsInCallStack("PLSA175FAS") .or. IsInCallStack("PLS720IBD7") ) .and. /*Rotinas da Digitacao CM ou Mudanca fase lote ou inclusao de BD7 (quando cria a composicao do evento)*/;
		( BD5->BD5_CODEMP $ GetNewPar('MV_XEMPEST','5000|5002')/*Empresas Estaleiro CABERJ*/ ) .and. ;
		( BD5->BD5_REGATE == "2" )/*BD5_REGATE => 1=Internacao; 2=Ambulatorial*/ .and. ;
		( GetNewPar('MV_XTRDEST','13') $ cTipRedAte(BD5->BD5_CODRDA) )//MV_XTRDEST: Tipo ReDe ESTaleiro - BI5020: 13 => CPPS


	//Leonardo Portella - 30/06/15 - Inicio - Tratamento especifico para estaleiro conforme regra Dr Jose Paulo


	_cGrpCb := u_BuscaGrupCob(BD6->BD6_CODOPE, BD6->BD6_CODPAD, BD6->BD6_CODPRO)

	If lCritica //.and. ( BD5->BD5_CODRDA $ '074934,009989,011100,118923,044237' )//HOSP SANTA MARIA MADALENA; HOSP DE CLINS DR BALBINO LT; CASA DE SAUDE SAO JOSE; CENTROMEDE CTO DE MEDICINA ESPECIALIZADA; CS SAO JOSE DOS LIRIOS

		If 	( BD5->BD5_CODLDP = '0001' ) .and. ;
				( BD5->BD5_CODPEG $ cPEGsExc )
			lPagar 	:= .T.
			nPerCop	:= 0

			//Chamado - ID: 18657 : Max informou que alem das PEGs tudo com atendimento entre 01/03/15 e 31/05/15
			//deve pagar e coparticipar 0 nos RDAs mencionados no chamado.
		ElseIf 	( BD5->BD5_CODRDA $ '044237|118923|011100|009989|140350' ) ;
				.and. ( BD5->BD5_DATPRO >= StoD('20150301') ) .and. ( BD5->BD5_DATPRO <= StoD('20150531') )
			lPagar 	:= .T.
			nPerCop	:= 0

			//Angelo Henrique - data:31/08/2015 - Incluído validação para não alterar quando for consulta, somente poderá alterar
			// quando for exame, por ser a porcentagem.
		ElseIf _cGrpCb $ "003|004" .AND. ( BD5->BD5_DATPRO >= StoD('20150801') ) .and. ( BD5->BD5_DATPRO <= StoD('20151231') )
			lPagar 	:= .T.
			nPerCop	:= 10

		EndIf

	EndIf

	//Angelo Henrique - Data: 28/08/2015
	If lCaber

		If _cGrpCb $ "003|004" .AND. ( BD5->BD5_DATPRO >= StoD('20150801') )

			If 	BD6->BD6_CODRDA $ '125970|136204|131903' //Centros Médicos CABERJ

				lPagar 	:= .T.
				nPerCop	:= 40

			ElseIf BD6->BD6_CODRDA $ '009989|011100|118923|044237'

				lPagar 	:= .T.
				nPerCop	:= 10

			EndIf

		EndIf

	EndIf

	//Leonardo Portella - 30/06/15 - Fim - Tratamento especifico para estaleiro conforme regra Dr Jose Paulo

Return {lCritica,lPagar,nPerCop}


//---------------------------------------------------------------------------------------------------------------------------
// Leonardo Portella - 22/11/14
//---------------------------------------------------------------------------------------------------------------------------
// Glosar sem cair em conferencia caso entre na regra do estaleiro. Apos virada da TISS 3,
// pontos de entrada pararam de funcionar. Por urgencia tive que fazer desse jeito.
// Verifica se deve glosar e glosa na marra o valor de pagamento de guias do Estaleiro. Nao eh para enviar
// para conferencia.
// Retorna se caiu na Critica do Estaleiro ou nao.
// Verifica se o valor a pagar eh maior que zero para nao ficar gravando varias vezes.
// Considera ponteirado na BCL e BD5.
//---------------------------------------------------------------------------------------------------------------------------
User Function lBlPgEstaleiro

	Local aArea 		:= GetArea()
	Local aArBD5 		:= BD5->(GetArea())
	Local aArBD6 		:= BD6->(GetArea())
	Local aArBD7 		:= BD7->(GetArea())
	Local c_ChaveGui
	Local c_ChaveProc
	Local nVlrGloBD6	:= 0
	Local nVlrGloBD7	:= 0
	Local lCritEstalei	:= .F.
	Local aCritEst		:= IIF((cEmpAnt=='01' .and. BD5->BD5_CODEMP $ '5000|5001|5002') .or. (cEmpAnt=='02' .and. BD5->BD5_CODEMP $ '0180|0183|0188|0189|0190|0259 '),u_aCriEstaleiro(),{.f.,.f.,0})

	//BIANCHINI - 09/05/2019 - P12 - RETIRADO DO PLSA720 PARA COMPOR NOVA ESTRUTURA DE ARRAY
	local lBDX_VLRGTX	:= BDX->( fieldPos("BDX_VLRGTX") ) > 0
	local lBDX_VLTXPG 	:= BDX->( fieldPos("BDX_VLTXPG") ) > 0
	local lGloAut		:= .f.

	lCritEstalei	:= aCritEst[1] .and. !aCritEst[2] //Leonardo Portella - 30/06/15 - Caiu na regra estaleiro e nao e para pagar

	aItensGlo 		:= {}

	If ( BCL->BCL_ALIAS == 'BD5' ) .and. ( BD5->BD5_VLRPAG > 0 ) .and. lCritEstalei

		c_ChaveGui 	:= BD5->(BD5_CODOPE + BD5_CODLDP + BD5_CODPEG + BD5_NUMERO)

		BD6->(DbSetOrder(1))//BD6_FILIAL+BD6_CODOPE+BD6_CODLDP+BD6_CODPEG+BD6_NUMERO+BD6_ORIMOV+BD6_SEQUEN+BD6_CODPAD+BD6_CODPRO

		If BD6->(MsSeek(xFilial("BD6") + c_ChaveGui ))

			While 	!BD6->(EOF()) .and. ;
					( BD6->(BD6_FILIAL + BD6_CODOPE + BD6_CODLDP + BD6_CODPEG + BD6_NUMERO) == xFilial("BD6") + c_ChaveGui )

				c_ChaveProc	:= c_ChaveGui + BD6->(BD6_ORIMOV+BD6_SEQUEN )

				BD7->(DbSetOrder(1))//BD7_FILIAL+BD7_CODOPE+BD7_CODLDP+BD7_CODPEG+BD7_NUMERO+BD7_ORIMOV+BD7_SEQUEN+BD7_CODUNM+BD7_NLANC

				If BD7->(MsSeek(xFilial("BD7") + c_ChaveProc ))

					nVlrGloBD7 := 0

					While 	!BD7->(Eof()) .and. ;
							( BD7->(BD7_FILIAL+BD7_CODOPE+BD7_CODLDP+BD7_CODPEG+BD7_NUMERO+BD7_ORIMOV+BD7_SEQUEN) == xFilial("BD7")+c_ChaveProc )

						BD7->(Reclock('BD7',.F.))

						BD7->BD7_VLRGLO := If(BD7->BD7_VLRAPR > 0,BD7->BD7_VLRAPR,BD7->BD7_VLRMAN)
						BD7->BD7_VLRPAG := 0

						BD7->(MsUnlock())

						nVlrGloBD7 += BD7->BD7_VLRGLO

						BD7->(DbSkip())

					EndDo

				EndIf

				BD6->(Reclock('BD6',.F.))

				BD6->BD6_VLRGLO := BD6->BD6_VLRMAN
				BD6->BD6_VLRPAG := 0

				//Leonardo Portella - 16/04/15 - Se zerar este campo, quando for REA ele calcula o percentual
				//de glosa zerado e paga tudo.
				//BD6->BD6_VLRMAN := 0

				BD6->BD6_VLRBPR := 0
				BD6->BD6_VLRPF  := 0
				BD6->BD6_VLRBPF := 0
				BD6->BD6_VLRTPF := 0

				//BD6->BD6_XROBD6 := 1//Campo nao utilizado mais (internacao SADT) reutilizado para saber se houve glosa automatica

				BD6->(MsUnlock())

				nVlrGloBD6 += BD6->BD6_VLRGLO

				u_IncBDX('GLOSA_AUTO: ESTALEIRO - CPPS','EST','GLOSA_AUTO: ESTALEIRO - CPPS')
				/*
				aAdd(aItensGlo,;
				{;
				BD6->BD6_SEQUEN,;
				BD6->BD6_VLRPAG,;
				BD6->BD6_VLRGLO,;
				"0",;
				0,;
				0,;
				"1",; // Acao = Sempre 1, glosar!
				"1",;
				"",;
				0;
				})
				*/
				//BIANCHINI - Mudança P12 - Aumento do Array
				lGloAut :=  BDX->BDX_TIPGLO == '3'
				aadd(aItensGlo,{BDX->BDX_SEQUEN,;												//01
					BDX->BDX_VLRPAG,;	//BDX->BDX_VLRMAN - Valor Contratado(TDE)	//02
					BDX->BDX_VLRGLO,;												//03
					BDX->BDX_ACAOTX,;						 						//04
					iIf(lBDX_VLRGTX, BDX->BDX_VLRGTX, 0),; 							//05
					BDX->BDX_TIPGLO,;												//06
					iIf(empty(BDX->BDX_ACAO), BDX->BDX_GLACAO, BDX->BDX_ACAO),;		//07
					iIf(empty(BDX->BDX_ACAO), "2", "1"),;							//08
					BDX->BDX_CODTPA,; 												//09
					BDX->BDX_QTDGLO,; 	   											//10
					BDX->BDX_TIPREG,;												//11
					BDX->BDX_CODGLO,;												//12
					BDX->BDX_VLRPAG,;												//13
					BDX->BDX_PERGLO,;												//14
					iIf(lBDX_VLTXPG,BDX->BDX_VLTXPG,0),;							//15
					lGloAut})

				BD6->(DbSkip())

			EndDo

			//Muda a fase da guia para pronta
			PLSXMUDFAS('BD5',"3","",BCL->BCL_TIPGUI,CtoD(""),.F.,"3",nil,nil,.T.,aItensGlo,nil,nil,nil)

			BD6->(DbSetOrder(1))//BD6_FILIAL+BD6_CODOPE+BD6_CODLDP+BD6_CODPEG+BD6_NUMERO+BD6_ORIMOV+BD6_SEQUEN+BD6_CODPAD+BD6_CODPRO

			If BD6->(MsSeek(xFilial("BD6") + c_ChaveGui ))

				While 	!BD6->(EOF()) .and. ;
						( BD6->(BD6_FILIAL + BD6_CODOPE + BD6_CODLDP + BD6_CODPEG + BD6_NUMERO) == xFilial("BD6") + c_ChaveGui )

					u_IncBDX('GLOSA_AUTO: ESTALEIRO - CPPS','EST','GLOSA_AUTO: ESTALEIRO - CPPS')

					BD6->(DbSkip())

				EndDo

			EndIf

		EndIf

	EndIf

	BD5->(RestArea(aArBD5))
	BD6->(RestArea(aArBD6))
	BD7->(RestArea(aArBD7))
	RestArea(aArea)

Return lCritEstalei

//----------------------------------------------------------------------------------------------------
//Cria glosa na BDX. Se informar RECNO BD6 ira ponteirar, caso contrario considera ponteirado
//----------------------------------------------------------------------------------------------------
User Function IncBDX(cInfGlo,cCodGlo,cDesGlo,nRecBD6)

	Local aArea 	:= GetArea()
	Local aArBDX 	:= BDX->(GetArea())
	Local aArBR8 	:= BR8->(GetArea())
	Local aArBD6

	Default nRecBD6 := 0

	If nRecBD6 > 0
		aArBD6 	:= BD6->(GetArea())
		BD6->(DbGoTo(nRecBD6))
	EndIf

	BDX->(Reclock("BDX",.T.))

	BDX->BDX_INFGLO := cInfGlo

	BDX->BDX_FILIAL := xFilial('BDX')
	BDX->BDX_IMGSTA := 'BR_VERMELHO'
	BDX->BDX_CODOPE := BD6->BD6_CODOPE
	BDX->BDX_CODLDP := BD6->BD6_CODLDP
	BDX->BDX_CODPEG	:= BD6->BD6_CODPEG
	BDX->BDX_NUMERO := BD6->BD6_NUMERO
	BDX->BDX_ORIMOV := BD6->BD6_ORIMOV
	BDX->BDX_CODPAD := BD6->BD6_CODPAD
	BDX->BDX_CODPRO := BD6->BD6_CODPRO
	BDX->BDX_SEQUEN := BD6->BD6_SEQUEN
	BDX->BDX_NIVEL 	:= '1'
	BDX->BDX_CODGLO	:= cCodGlo
	BDX->BDX_DESGLO	:= cDesGlo

	BDX->BDX_VLRAPR := BD6->BD6_VLRAPR
	BDX->BDX_VLRAP2 := BD6->BD6_VLRAPR
	BDX->BDX_VLRBPR := BD6->BD6_VLRBPR
	BDX->BDX_VLRBP2 := BD6->BD6_VLRBPR
	BDX->BDX_VLRMAN := BD6->BD6_VLRMAN
	BDX->BDX_VLRMA2 := BD6->BD6_VLRMAN
	BDX->BDX_VLRPAG := If(BDX->BDX_VLRGL2 >= BD6->BD6_VLRMAN,0,BD6->BD6_VLRMAN-BDX->BDX_VLRGL2)
	BDX->BDX_PERGLO := BDX->BDX_PERGL2
	BDX->BDX_VLRGLO := BDX->BDX_VLRGL2
	BDX->BDX_DESPRO := Posicione("BR8",1,xFilial("BR8")+BD6->(BD6_CODPAD + BD6_CODPRO),"BR8_DESCRI")
	BDX->BDX_GLOSIS := BDX->BDX_CODGLO
	BDX->BDX_DTACAO := dDataBase

	BDX->(MsUnlock())

	If nRecBD6 > 0
		BD6->(RestArea(aArBD6))
	EndIf

	BDX->(RestArea(aArBDX))
	BR8->(RestArea(aArBR8))

	RestArea(aArea)

Return

//----------------------------------------
//Excecoes solicitadas pelo Max
//----------------------------------------
Static Function lExcecMax(cCodRDA)

	Local l_Tira09N := .F.

	If ( 	( cCodRDA $ '111414|111406|134210|140171|140040|124796|140139|140147|140155' ) 	.and. ;
			( Year(BD6->BD6_DATPRO) == 2015 ) 												.and. ;
			( Month(BD6->BD6_DATPRO) >= 3 ) 												.and. ;
			( Month(BD6->BD6_DATPRO) <= 7 ) )

		l_Tira09N := .T.

	ElseIf ( cEmpAnt == '01' )

		//Solicitado por Max em 29/09/15 por telefone e e-mail
		If 	( cCodRDA == '111414' ) .and. ( BD6->BD6_CODPEG $ ( '00537164|00537162|00537167|00537171|00537166|00537170|00537168|00537180|00537181|00537201|00537194|00537187|00537189|00537172|00537165|00538189|00538188|00538185|00538194|00538191|00538193|00538190|00538670|00538671|00538672|00538673|00538676|00538677|00538678' ) )
			l_Tira09N := .T.
		EndIf

		//Solicitado por Max em 29/09/15 pessoalmente e e-mail
		If 	( cCodRDA == '134210' ) .and. ( BD6->BD6_CODPEG $ ( '00098626|00098625|00098624|00098611|00538499|00538495' ) )
			l_Tira09N := .T.
		EndIf

		//Autorizado por Max em 10/03/2016 e-mail - Chamado - ID: 25680
		If 	( cCodRDA == '059536' ) .and. ( BD6->BD6_CODPEG $ ( '00576836|00576837|00576838' ) )
			l_Tira09N := .T.
		EndIf

		//Autorizado por Max - Chamado - ID: 22039 - SERGIO CUNHA 18/11/2015
		If 	( cCodRDA == '138460' ) 							.and. 	;
				(															;
				( 														;
				( Year(BD6->BD6_DATPRO) == 2014 ) 			.and. 	;
				( Month(BD6->BD6_DATPRO) >= 09 ) 			.and. 	;
				( Month(BD6->BD6_DATPRO) <= 12 ) 					;
				)          												;
				.or.	;
				(														;
				( Year(BD6->BD6_DATPRO) == 2015 ) 			.and. 	;
				( Month(BD6->BD6_DATPRO) >= 1 ) 			.and. 	;
				( Month(BD6->BD6_DATPRO) <= 6 )						;
				)														;
				)

			l_Tira09N := .T.
		EndIf
		//Chamado - ID: 22257 - Sergio Cunha - Autorizado MAX por e-mail - 26/11/2015
		If (( cCodRDA == '032883' )    .and. ;
				( Year(BD6->BD6_DATPRO) == 2015 )  .and. ;
				( Month(BD6->BD6_DATPRO) >= 5 )  .and. ;
				( Month(BD6->BD6_DATPRO) <= 9 )    ;
				)

			l_Tira09N := .T.
		EndIf
		//Chamado - ID: 20645
		If (( cCodRDA == '111406' ) 			.and. ;
				( Year(BD6->BD6_DATPRO) == 2015 ) 	.and. ;
				( Month(BD6->BD6_DATPRO) >= 2 ) 	.and. ;
				( Month(BD6->BD6_DATPRO) <= 7 ) )

			l_Tira09N := .T.
		EndIf

		//PEGs da INTEGRAL que nao poderao ter a critica 09N (Conforme Max por telefone e e-mail em 24/09/15)
	ElseIf 	cEmpAnt == '02'

		Do Case

			Case 	( cCodRDA == '140350' ) .and. ( BD6->BD6_CODPEG $ ( '00096963|00096965' ) )

				l_Tira09N := .T.

			Case 	( cCodRDA == '044237' ) .and. ;
					( BD6->BD6_CODPEG $ ( '00097187|00097331|00096964|00097181|00096393|00097181|00096973|00096967' ) )

				l_Tira09N := .T.

				//Chamado - ID: 20493 - Autorizado pelo Max por telefone
			Case 	( cCodRDA == '040703' )

				l_Tira09N := .T.

		EndCase

	EndIf

Return l_Tira09N

//--------------------------------------------------------
// Leonardo Portella - 15/01/16
// Remove criticas. Testado com a 09N e 025
//--------------------------------------------------------
Static Function aRetCri(cCritica, aCrit, aRetPad, lSistemaAut)

	Local aRet 		:= aCrit
	Local nPosCri 	:= 0

	//If !lSistemaAut .and. (   ( ( nPosCri := aScan(aRet[2],{|x|x[1] == cCritica}) ) > 0 ) .or. ( ( nPosCri := aScan(aRet[2],{|x|x[1] == " "}) ) > 0 )  )
	If !lSistemaAut .and. ( ( nPosCri := aScan(aRet[2],{|x|x[1] == cCritica}) ) > 0 )

		If Len(aRet[2]) > 2
			//Se houver mais criticas alem da contida na variável cCritica
			aDel(aRet[2],nPosCri)	//Critica
			If !Empty((aRet[2],nPosCri+1))
				aDel(aRet[2],nPosCri+1)	//Descricao da critica
			Endif
			aSize(aRet[2],Len(aRet[2])-2)
		Else
			//Só uma critica
			//aRet 		:= {.T.,{},aRetPad[3],aRetPad[4]}
			aRet 		:= {.T.,{}}
			lSistemaAut	:= .T.
		EndIf

	EndIf

Return aRet
