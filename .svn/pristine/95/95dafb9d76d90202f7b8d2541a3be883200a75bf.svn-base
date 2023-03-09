#Include 'Protheus.ch'
#include "PLSMGER.CH"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±±
±±³Funcao    ³ MSPORTAL01 ³ Autor ³ Geraldo Felix       ³ Data ³ 23/05/2015 ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±±
/*/

User Function MSUSR01A(aEmp)
	Local nOpca       	:= 0
	Local aSays       	:= {}
	Local aButtons 		:= {}
	local cPerg			:= "MSX01I"

	Private nModulo 	:= 33 // modulo SIGAPLS
	Private cMessage
	Private cCadastro	:= "Rotina de geração de usuários do portal"
	Private cChamado 	:= "Mobile Saúde"
	Private cRef     	:= ""
	Private cEmpDe		:= ""
	Private cEmpAte		:= ""
	Private nIdadeMin	:= 0
	Private lSched      := .F.//Motta 2/4/19

	//GLPI 51809
	// Mateus Medeiros - 31/08/18 - Valida se a tabela SX6 está aberta
	If Select("SX6") == 0

		lSched := .T.

	EndIf
	// Fim - Mateus

	if lSched

		RPCSetType(3)  // Nao utiliza licenca
		RpcSetEnv(aEmp[1],"01")

	endif

	Set Dele On

	CriaSX1(cPerg)


	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Monta texto para janela de processamento                                   ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	aadd(aSays,"Esta rotina irá criar ou bloquear usuários do portal com base no cadastro de beneficiários.")
	aadd(aSays, " ")
	aadd(aSays,"Mobile Saúde")
	aadd(aSays," ")
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Monta botoes para janela de processamento                                  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	Pergunte(cPerg,.F.)

	aadd(aButtons, { 5,.T.,{|| nOpca := 0, Pergunte(cPerg,.T.) }} )
	aadd(aButtons, { 1,.T.,{|| nOpca := 1, FechaBatch() }} )
	aadd(aButtons, { 2,.T.,{|| nOpca := 0, FechaBatch() }} )
	//GLPI 51809
	If lSched // valida se é schedule - Mateus Medeiros - 31/08/18 -

		conout("MSUSR01A - "+iif(cEmpAnt=='01','CABERJ','Integral'))
		cEmpDe		:= mv_par01
		cEmpAte		:= mv_par02
		nIdadeMin	:= mv_par03

		MS01CRIA(.T.)

	else
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Exibe janela de processamento                                              ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		FormBatch( cCadastro, aSays, aButtons,, 230 )

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Processa calculo                                                           ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If  nOpca == 1
			cEmpDe		:= mv_par01
			cEmpAte	:= mv_par02
			nIdadeMin	:= mv_par03

			If Empty(cEmpAte)
				MsgStop("Informe um intervalo de empresas válido")

				Return
			Endif

			If nIdadeMin == 0
				nIdadeMin := GetNewPar("MV_MSIDAMI", 18)
			Endif

			If  Aviso("Mobile Saúde", "Confirma o processamento ?", {"Sim","Não"}) == 1
				Processa({||MS01CRIA(.T.)},"Processando","Aguarde, criando usuários",.F.)
			Endif
		Endif

	Endif

Return


//-------------------------------------------------------------------
/*/{Protheus.doc} MSUSR01B
Rotina utilizada para criar usuários na mobile saúde
via schedule
@author  Angelo Henrique
@since   date 07/01/2022
@type function
@version 1.0
/*/
//-------------------------------------------------------------------
User Function MSUSR01B(aParSched)

	Local  nH := 0

	RpcSetType(3)
	RpcSetEnv(aParSched[1], aParSched[2],,,'PLS',,)

	Conout("Processo de Criacao de usuarios no portal Mobile Saude - Empresa" + cEmpAnt + " - MSUSR01B - Iniciado" )

	nH := PLSAbreSem("MSUSR01B" + aParSched[1] + ".SMF", .F.)

	if nH == 0
		Conout("MSUSR01B - Finalizado por trava no semaforo")
		RpcClearEnv()
		return()
	endif

	//MS01CRIA(.F.)
	USUSCHED()

	Conout("Processo de Criacao de usuarios no portal Mobile Saude - Empresa" + cEmpAnt + " - MSUSR01B - Finalizado")

	PLSFechaSem(nH, "SCH001.SMF")

	RpcClearEnv()

Return

/*/
	ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
	±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
	±±ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
	±±³Programa   ³ R036Imp  ³ Autor ³ Eduardo Motta         ³ Data ³ 21.11.03 ³±±
	±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
	±±³Descricao  ³ Emite relatorio de Notas de Debito                         ³±±
	±±ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
	±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
	ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
/*/
Static Function MS01CRIA(lFull)

	LOCAL cSql 			:= ""
	LOCAL cAcesso		:= GetNewPar("MV_MSCDACE", "000001")
	LOCAL cTitular 		:= GETNEWPAR("MV_MBTIT", "T")
	LOCAL nDiasExpira	:= GetNewPar("MV_MSDIAEX", 60)
	LOCAL cConjuge 		:= GETNEWPAR("MV_MBCONJ", "")

	// Primeiro trata as inclusões
	cSql := "SELECT BA1_GRAUPA, BA1_TIPUSU, BA1_NOMUSR, BA1_CPFUSR, BA1_EMAIL, BA1_DATNAS, "
	cSql += "BA1_CODINT, BA1_CODEMP, BA1_MATRIC, BA1_TIPREG, BA1_DIGITO, BA1_CONEMP, BA1_VERCON, BA1_SUBCON, BA1_VERSUB "
	cSql += "FROM "+RetSqlName("BA1")+" WHERE BA1_FILIAL = '"+xFilial("BA1")+"' "

	If !lFull
		// Se a carga incremental só considera incluidos 15 dias pra cá.
		cSql += "AND (BA1_DATINC >= '"+dTos(dDataBa-15)+"' "

	Else
		cSql += "AND BA1_CODEMP >= '"+cEmpDe+"' and BA1_CODEMP <= '"+cEmpAte+"' "

	Endif

	//------------------------------------------------------------------------------
	// Inicio - Angelo Henrique - Data: 10/12/2019
	//Colocando aqui para pegar os beneficiários com bloqueio temporário
	//------------------------------------------------------------------------------
	cSql += "AND (BA1_DATBLO = ' ' OR "
	cSql += " (BA1_DATBLO > '" + dTos(Date()) + "'  AND"

	_cMotBlo := IIF(cEmpAnt = '01','509','765')

	cSql += " BA1_MOTBLO <> '" + _cMotBlo + "' ))"
	//------------------------------------------------------------------------------
	// Fim - Angelo Henrique - Data: 10/12/2019
	//Colocando aqui para pegar os beneficiários com bloqueio temporário
	//------------------------------------------------------------------------------

	cSql += " AND D_E_L_E_T_ = ' ' "
	cSql += "ORDER BY BA1_CODINT, BA1_CODEMP, BA1_MATRIC, BA1_TIPREG "

	PlsQuery(cSql, "TRB1")

	BSW->( dbSetorder(01) )
	B49->( dbSetorder(01) )
	BQC->( dbSetorder(01) )

	While !TRB1->( Eof())
		cCodint := TRB1->BA1_CODINT
		cCodEmp := TRB1->BA1_CODEMP
		cMatric := TRB1->BA1_MATRIC
		cTipReg := TRB1->BA1_TIPREG
		cDigito := TRB1->BA1_DIGITO
		//mOTTA MAR ABR 22
		cCPFUsr := TRB1->BA1_CPFUSR

		If BQC->( dbSeek(xFilial("BQC")+TRB1->(BA1_CODINT+BA1_CODEMP+BA1_CONEMP+BA1_VERCON+BA1_SUBCON+BA1_VERSUB)) )
			If BQC->BQC_YUSRPT <> "1"
				TRB1->( dbSkip() )
				Loop
			Endif
		Endif

		If TRB1->BA1_TIPUSU == cTitular
			// Se não tiver a idade minima não cria acesso
			If Calc_Idade(dDataBase, TRB1->BA1_DATNAS) < nIdadeMin
				TRB1->( dbSkip() )
				Loop
			Endif

			// Se não tiver CPF não cria o acesso
			If Empty(TRB1->BA1_CPFUSR)
				TRB1->( dbSkip() )
				Loop
			Endif

			// Cria o acesso do usuário na tabela BSW
			//?mOTTA MAR ABR 22
			//If !BSW->( dbSeek(xFilial("BSW")+cCodInt+cCodEmp+cMatric+cTipReg+cDigito) )
			If !BSW->( dbSeek(xFilial("BSW")+cCPFUsr) )
				AddBsw(cCodInt+cCodEmp+cMatric+cTipReg+cDigito, cAcesso, dDataBase, nDiasExpira)

				// Cria registro na B49
				If !B49->( dbSeek(xFilial("B49") + BSW->BSW_CODUSR) )
					AddB49(cCodInt+cCodEmp+cMatric+cTipReg+cDigito)

				ElseIf  !(cCodInt+cCodEmp+cMatric+cTipReg+cDigito = B49->B49_BENEFI)

					UpdB49(cCodInt+cCodEmp+cMatric+cTipReg+cDigito)

				Endif

			Else

				B49->( dbSeek(xFilial("B49") + BSW->BSW_CODUSR) )

				If !(cCodInt+cCodEmp+cMatric+cTipReg+cDigito = B49->B49_BENEFI)

					UpdB49(cCodInt+cCodEmp+cMatric+cTipReg+cDigito)

				Endif

			Endif

		Elseif TRB1->BA1_TIPUSU != cTitular .and. (TRB1->BA1_GRAUPA $ cConjuge)

			// Se tiver idade suficiente e se tiver o CPF, cria o acesso dele tmb.
			If Calc_Idade(dDataBase, TRB1->BA1_DATNAS) > nIdadeMin .and. !Empty(TRB1->BA1_CPFUSR)

				// Cria o acesso do usuário na tabela BSW
				//Motta mar abr 22
				//If !BSW->( dbSeek(xFilial("BSW")+cCodInt+cCodEmp+cMatric+cTipReg+cDigito) )
				If !BSW->( dbSeek(xFilial("BSW")+cCPFUsr) )
					AddBsw(cCodInt+cCodEmp+cMatric+cTipReg+cDigito, cAcesso, dDataBase, nDiasExpira)

					// Cria o próprio usuário na B49
					If !B49->( dbSeek(xFilial("B49") + BSW->BSW_CODUSR) )
						AddB49(cCodInt+cCodEmp+cMatric+cTipReg+cDigito)
					ElseIf  !(cCodInt+cCodEmp+cMatric+cTipReg+cDigito = B49->B49_BENEFI)
						UpdB49(cCodInt+cCodEmp+cMatric+cTipReg+cDigito)
					Endif

				Else

					B49->( dbSeek(xFilial("B49") + BSW->BSW_CODUSR) )

					If !(cCodInt+cCodEmp+cMatric+cTipReg+cDigito = B49->B49_BENEFI)

						UpdB49(cCodInt+cCodEmp+cMatric+cTipReg+cDigito)

					Endif

				Endif

			Endif

		Else
			// Se tiver idade suficiente e se tiver o CPF, cria o acesso dele tmb.
			If Calc_Idade(dDataBase, TRB1->BA1_DATNAS) > nIdadeMin .and. !Empty(TRB1->BA1_CPFUSR)

				// Cria o acesso do usuário na tabela BSW
				//Motta mar abr 22
				//If !BSW->( dbSeek(xFilial("BSW")+cCodInt+cCodEmp+cMatric+cTipReg+cDigito))
				If !BSW->( dbSeek(xFilial("BSW")+cCPFUsr))
					AddBsw(cCodInt+cCodEmp+cMatric+cTipReg+cDigito, cAcesso, dDataBase, nDiasExpira)

					// Cria registro na B49
					If !B49->( dbSeek(xFilial("B49") + BSW->BSW_CODUSR) )
						AddB49(cCodInt+cCodEmp+cMatric+cTipReg+cDigito)
					ElseIf  !(cCodInt+cCodEmp+cMatric+cTipReg+cDigito = B49->B49_BENEFI)
						UpdB49(cCodInt+cCodEmp+cMatric+cTipReg+cDigito)
					Endif

				Else

					B49->( dbSeek(xFilial("B49") + BSW->BSW_CODUSR) )

					If !(cCodInt+cCodEmp+cMatric+cTipReg+cDigito = B49->B49_BENEFI)

						UpdB49(cCodInt+cCodEmp+cMatric+cTipReg+cDigito)

					Endif
				Endif
			Endif

		Endif

		TRB1->( dbSkip() )
	Enddo

	TRB1->( dbCloseArea() )

Return nil


Static Function AddBsw(cMatricula, cAcesso, dDataBase, nDiasExpira)

Local cSql	:= ""

	cSql := " SELECT MAX(BSW_CODUSR) AS COD"
	cSql += " FROM  "+RetsqlName("BSW") + " "
	cSql += " WHERE D_E_L_E_T_= ' ' "

	dbUseArea(.T.,"TOPCONN",TCGenQry(,,cSql),"TEMP",.F.,.T.)

	DbSelectArea("TEMP")
	cCod := Soma1(TEMP->COD)
	TEMP->(dbCloseArea())

	BSW->( RecLock("BSW", .T.) )
		BSW->BSW_FILIAL := xFilial("BSW")
		BSW->BSW_CODUSR	:= cCod
		BSW->BSW_LOGUSR := Iif(!Empty(TRB1->BA1_CPFUSR),TRB1->BA1_CPFUSR,cMatricula)
		BSW->BSW_NOMUSR := TRB1->BA1_NOMUSR

		/*Motta 25/7/19 estava "6" mudança regra segurança*/
		BSW->BSW_SENHA	:= PLSCRIDEC(1,Left(TRB1->BA1_CPFUSR,8))
		BSW->BSW_EMAIL	:= Alltrim(TRB1->BA1_EMAIL)
		BSW->BSW_CODACE	:= cAcesso
		BSW->BSW_TIPCAR	:= "0"
		BSW->BSW_BIOMET	:= ""
		BSW->BSW_TPPOR	:= "3"

		// Especificos Mobile Saúde
		BSW->BSW_YCPF		:= TRB1->BA1_CPFUSR
		//	BSW->BSW_YEXPPS	:= (dDataBase-1)
		BSW->BSW_YPRIAC	:= "N"
		BSW->BSW_YATUCD	:= "N"
	BSW->( MsUnlock() )
	
Return cCod

Static Function AddB49(cMatric)

	// Já cria o B49 para o usuário recem incluido.
	B49->( RecLock("B49", .T.) )
		B49->B49_FILIAL := xFilial("B49")
		B49->B49_CODUSR := BSW->BSW_CODUSR
		B49->B49_BENEFI := cMatric
	B49->( MsUnlock() )

Return

Static Function UpdB49(cMatric)

	// Atualiza o B49 com a nova matricula
	B49->( RecLock("B49", .F.) )
		B49->B49_BENEFI := cMatric
	B49->( MsUnlock() )

Return

Static Function CriaSX1(cPerg)

	Local aRegs	:=	{}

	aadd(aRegs,{cPerg,"01","Empresa De"         ,"","","mv_ch1","C", 4,0,0,"G","","mv_par01",""             ,"","","","",""               ,"","","","",""              ,"","","","",""       ,"","","","",""       ,"","","","",""})
	aadd(aRegs,{cPerg,"02","Empresa Ate"        ,"","","mv_ch2","C", 4,0,0,"G","","mv_par02",""             ,"","","","",""               ,"","","","",""              ,"","","","",""       ,"","","","",""       ,"","","","",""})
	aadd(aRegs,{cPerg,"03","Idade Minima"		  ,"","","mv_ch3","N", 2,0,0,"G","","mv_par03",""             ,"","","","",""               ,"","","","",""              ,"","","","",""       ,"","","","",""       ,"","","","",""})

	PlsVldPerg( aRegs )

Return

//-------------------------------------------------------------------
/*/{Protheus.doc} function USUSCHED
Rotina responsável por criar os usuários do portal via schedule
@author  Angelo Henrique
@since   22/08/2022
@version 1.0
@type function
/*/
//-------------------------------------------------------------------
Static FuncTion USUSCHED()

	Local cSql 			:= ""
	Local nIdadeMin		:= GetNewPar("MV_MSIDAMI", 18)
	Local cAcesso		:= GetNewPar("MV_MSCDACE", "000001")
	Local nDiasExpira	:= GetNewPar("MV_MSDIAEX", 60)
	Local cCodint 		:= ""
	Local cCodEmp 		:= ""
	Local cMatric 		:= ""
	Local cTipReg 		:= ""
	Local cDigito 		:= ""
	Local cCPFUsr 		:= ""//Motta mar abr 22
	Local _cMotBlo		:= iif(cEmpAnt = '01','509','765')
	Local cCodBSW		:= ""

	cSql += " SELECT BA1.BA1_GRAUPA,"
	cSql +=		   " BA1.BA1_TIPUSU,"
	cSql +=		   " BA1.BA1_NOMUSR,"
	cSql +=		   " BA1.BA1_CPFUSR,"
	cSql +=		   " BA1.BA1_EMAIL, "
	cSql +=		   " BA1.BA1_DATNAS,"
	cSql +=		   " BA1.BA1_CODINT,"
	cSql +=		   " BA1.BA1_CODEMP,"
	cSql +=		   " BA1.BA1_MATRIC,"
	cSql +=		   " BA1.BA1_TIPREG,"
	cSql +=		   " BA1.BA1_DIGITO,"
	cSql +=		   " BA1.BA1_CONEMP,"
	cSql +=		   " BA1.BA1_VERCON,"
	cSql +=		   " BA1.BA1_SUBCON,"
	cSql +=		   " BA1.BA1_VERSUB "
	cSql += " FROM " + RetSqlName("BA1") + " BA1"
	cSql +=	  " INNER JOIN " + RetSqlName("BQC") + " BQC"
	cSql +=	    " ON (    BQC.BQC_FILIAL = BA1.BA1_FILIAL"
	cSql +=         " AND BQC.BQC_CODIGO = BA1.BA1_CODINT||BA1.BA1_CODEMP"
	cSql +=         " AND BQC.BQC_NUMCON = BA1.BA1_CONEMP"
	cSql +=         " AND BQC.BQC_VERCON = BA1.BA1_VERCON"
	cSql +=         " AND BQC.BQC_SUBCON = BA1.BA1_SUBCON"
	cSql +=         " AND BQC.BQC_VERSUB = BA1.BA1_VERSUB)"
	cSql +=	  " INNER JOIN " + RetSqlName("BI3") + " BI3"
	cSql +=	    " ON (    BI3.BI3_FILIAL = BA1.BA1_FILIAL"
	cSql +=         " AND BI3.BI3_CODINT = BA1.BA1_CODINT"
	cSql +=         " AND BI3.BI3_CODIGO = BA1.BA1_CODPLA"
	cSql +=         " AND BI3.BI3_VERSAO = BA1.BA1_VERSAO)"
	cSql += " WHERE BA1.D_E_L_E_T_ = ' ' AND BQC.D_E_L_E_T_ = ' ' AND BI3.D_E_L_E_T_ = ' '"
	cSql +=   " AND BA1.BA1_FILIAL = '" + xFilial("BA1") + "'"
	cSql +=   " AND BI3.BI3_CODSEG <> '004'"
	cSql +=   " AND BQC.BQC_YUSRPT = '1'"
	cSql +=   " AND BA1.BA1_DATINC <= TO_CHAR(SYSDATE,'YYYYMMDD')"
	cSql +=   " AND (BA1.BA1_DATBLO = ' ' OR (BA1_DATBLO >= TO_CHAR(SYSDATE,'YYYYMMDD') OR BA1.BA1_MOTBLO = '" + _cMotBlo + "'))"
	cSql +=   " AND BA1.BA1_CPFUSR <> ' '"
	cSql +=   " AND IDADE(TO_DATE(TRIM(BA1.BA1_DATNAS),'YYYYMMDD')) > " + cValToChar(nIdadeMin)
	cSql +=   " AND NOT EXISTS (SELECT NULL"
	cSql +=					  " FROM " + RetSqlName("BSW") + " BSW"
	cSql +=						" INNER JOIN " + RetSqlName("B49") + " B49"
	cSql +=						  " ON (    B49_FILIAL = BSW_FILIAL"
	cSql +=							  " AND B49_CODUSR = BSW_CODUSR)"
	cSql +=					  " WHERE BSW.D_E_L_E_T_ = ' ' AND B49.D_E_L_E_T_ = ' '"
	cSql +=						" AND BSW_FILIAL = BA1.BA1_FILIAL"
	cSql +=						" AND (   BSW.BSW_LOGUSR = BA1.BA1_CPFUSR"
	cSql +=						     " OR BSW.BSW_LOGUSR = BA1_CODINT||BA1_CODEMP||BA1_MATRIC||BA1_TIPREG||BA1_DIGITO)"
	cSql +=						" AND B49_BENEFI = BA1_CODINT||BA1_CODEMP||BA1_MATRIC||BA1_TIPREG||BA1_DIGITO )"
	cSql += " ORDER BY BA1.BA1_CODINT, BA1.BA1_CODEMP, BA1.BA1_MATRIC, BA1.BA1_TIPREG"
	
	PlsQuery(cSql, "TRB1")

	TRB1->(DbGoTop())
	while TRB1->(!EOF())

		cCodint := AllTrim(TRB1->BA1_CODINT)
		cCodEmp := AllTrim(TRB1->BA1_CODEMP)
		cMatric := AllTrim(TRB1->BA1_MATRIC)
		cTipReg := AllTrim(TRB1->BA1_TIPREG)
		cDigito := AllTrim(TRB1->BA1_DIGITO)
		cCPFUsr := AllTrim(TRB1->BA1_CPFUSR)
		cCodBSW	:= ""

		if len(cCodInt+cCodEmp+cMatric+cTipReg+cDigito) == 17

			// Cria o acesso do usuário na tabela BSW
			BSW->( dbSetorder(01) )	// BSW_FILIAL+BSW_LOGUSR
			if BSW->( dbSeek(xFilial("BSW") + cCPFUsr) )
				cCodBSW	:= BSW->BSW_CODUSR
			else

				BSW->( dbSetorder(01) )	// BSW_FILIAL+BSW_LOGUSR
				if BSW->( dbSeek(xFilial("BSW") + cCodInt+cCodEmp+cMatric+cTipReg+cDigito) )
					cCodBSW	:= BSW->BSW_CODUSR
				else
					cCodBSW := AddBsw(cCodInt+cCodEmp+cMatric+cTipReg+cDigito, cAcesso, dDataBase, nDiasExpira)
				endif
			
			endif

			BSW->( dbSetorder(5) )	// BSW_FILIAL+BSW_CODUSR
			if BSW->( dbSeek(xFilial("BSW") + cCodBSW) ) .and. !empty(cCodBSW)

				B49->( dbSetorder(01))	// B49_FILIAL+B49_CODUSR+B49_BENEFI
				if !B49->( dbSeek(xFilial("B49") + BSW->BSW_CODUSR + cCodInt+cCodEmp+cMatric+cTipReg+cDigito ) )

					AddB49(cCodInt+cCodEmp+cMatric+cTipReg+cDigito)
				
				endif

			endif
		
		endif

		TRB1->( dbSkip() )
	end
	TRB1->( dbCloseArea() )

Return
