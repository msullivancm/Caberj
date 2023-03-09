#INCLUDE 'RWMAKE.CH'
#INCLUDE 'PROTHEUS.CH'
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³PLA092FIM ºAutor  ³Renato Peixoto      º Data ³  22/11/10   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³  Ponto de Entrada para enviar e-mail aos gestores quando   º±±
±±º          ³  for incluída uma internação.                              º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function PLA092FIM()

	//Local cSenhaInt	  := Paramixb[1]
	//Local cMatricula  := Paramixb[2]
	//Local cSenha	  := Paramixb[3]
	//Local oDlg	
	Local nOpca     := 0		
	//Local cSQL      := ""
	//Local cSQL2     := ""
	//Local cCodPla   := ""
	//Local nFatMul   := 0
	//Local nChReem   := 0
	//Local bLinhaIni := .F.
	//Local nValReem  := 0

	Local _aArBAU	:= BAU->(GetArea())

	/*
	Local cQuery    := ""
	Local cArqQry   := GetNextAlias()
	Local c_Htm 	:= "HTML\INTERNACAO.html"
	Local c_To 		:= "" //GetMv("MV_GESTINT")//e-mail dos gestores que receberão aviso quando houver uma inclusão de internação.
	Local c_CC 	    := " "
	Local c_Assunto := "Aviso de inclusão/autorização de internação. "
	Local a_Msg     := {}
	//Local c_Projeto := GetMv("MV_PROMAIL")  //Pega o tipo de projeto que deve ser verificado no caso de inclusão/autorização de internação.
	Local lEnvMail  := .F.  //Define se irá ou não enviar o e-mail.
	Local cMatricula:= M->BE4_USUARI
	Local cNome     := M->BE4_NOMUSR
	Local cTelefone := ""
	Local cIdade    := ""
	Local cProjeto  := M->BE4_YDSPRO
	Local cHospital := M->BE4_DESLOC
	Local cTel_Hosp := ""
	Local cSenhaInt := ParamIxb[3] //Foi criado mais um parâmetro para atender esta demanda. Passa a ter acesso à senha gerada. Renato Peixoto em 05/01/11
	Local cHora     := Time()
	Local cExecut   := M->BE4_NOMEXE
	Local cIntern   := ""
	Local cAcomod   := M->BE4_DESPAD
	Local cIndCli   := M->BE4_INDCLI
	Local cExecMail := GetMv("MV_XEXMAIL") //irá determinar o envio de e-mail quando o CR deste parâmetro for o correspondente ao executante na internação (Terapias Int. Nupre Niteroi)
	Local cRDATerap := GetMv("MV_XMAILTE") //endereços de e-mail dos responsáveis pelo RDA 125970 (terapias int.)

	//Por enquanto só irá executar a rotina de envio de e-mail quando for o RDA 125970 (Terapias Int.) - NUPRE Niteroi
	If M->BE4_REGEXE <> cExecMail
		Return
	EndIf
	*/

	//Teste para preenchimento automático da data e hora da alta no caso do regime de internação ser hospital-dia
	//----JA ESTAVA COMENTADO. NAO DESCOMENTAR
	/*
	If M->BE4_REGINT = '2'
		RecLock("BE4",.F.)
		BE4->BE4_DTALTA := DDATABASE
		BE4->BE4_HRALTA := "2359"
		BE4->(MsUnlock())
	EndIf */
	//  Comentado para aguardar aprovação para subir Produção.
	//Se o conteúdo do parâmetro que define se será enviado e-mail na inclusão de internação estiver diferente de "S", a rotina de envio de e-mail não será executada.
	/*
	If AllTrim(GetMv("MV_MAILINT")) <> "S" .OR. !INCLUI
		Return
	Else
		lEnvMail := .T.
		c_To := cRDATerap
	EndIf

	If AllTrim(M->BE4_GRPINT) = "1"
		cIntern := "Internacao Clinica"
	Elseif AllTrim(M->BE4_GRPINT) = "2"
		cIntern := "Internacao Cirurgica"
	Elseif AllTrim(M->BE4_GRPINT) = "3"
		cIntern := "Internacao Obstetrica"
	Elseif AllTrim(M->BE4_GRPINT) = "4"
		cIntern := "Internacao Pediatrica"
	Else
		cIntern := "Internacao Psiquiatrica"
	EndIf

	//Busca o telefone e idade do usuário
	DbSelectArea("BA1")
	DbSetOrder(1)
	If DbSeek(XFILIAL("BA1")+SUBSTR(M->BE4_USUARI,1,14))
		cTelefone := BA1_TELEFO
		cIdade    := STR(CALC_IDADE(ddatabase,BA1->BA1_DATNAS))
	EndIf

	//Busca o telefone da RDA
	DbSelectArea("BAU")
	DbSetOrder(1)
	If DbSeek(XFILIAL("BAU")+M->BE4_CODRDA)
		cTel_Hosp := BAU->BAU_TEL
	EndIf
	*/
	//----JA ESTAVA COMENTADO. NAO DESCOMENTAR
	/*
	cQuery := "SELECT * "
	cQuery += "FROM "+RetSqlName("BF4")+" BF4 "
	cQuery += "WHERE  BF4_FILIAL = ' ' "
	cQuery += "AND BF4_CODINT || BF4_CODEMP ||  BF4_MATRIC || BF4_TIPREG= '"+SUBSTR(M->BE4_USUARI,1,16)+"' "  //0001000103487101
	cQuery += "AND d_e_l_e_t_ <> '*' "

	If Select(cArqQry) <> 0
		(cArqQry)->(DbCloseArea())
	Endif

	DbUseArea(.T.,"TopConn",TcGenQry(,,cQuery),cArqQry,.T.,.T.)

	If (cArqQry)->(Eof())

		Return

	Else

		While !((cArqQry)->(Eof()))
			If AllTrim((cArqQry)->BF4_CODPRO) = AllTrim(c_Projeto)
				lEnvMail := .T.
			EndIf
			(cArqQry)->(DbSKip())
		EndDo

	EndIf
	*/
	/*
	**'-- Preenchimento do vetor a_Msg para Envio de e-mail ------------------'**
	If !lEnvMail

		Return

	Else
		//Carrega o vetor com os campos que serão substituídos no html
		aadd( a_Msg, { "matricula"		, cMatricula			    })
		aadd( a_Msg, { "nome"	        , cNome 					})
		aadd( a_Msg, { "telefone"	    , cTelefone					})
		aadd( a_Msg, { "idade"      	, cIdade                 	})
		aadd( a_Msg, { "projetos"		, cProjeto 					})
		aadd( a_Msg, { "hospital"   	, cHospital     			})
		aadd( a_Msg, { "tel_hospital"  	, cTel_Hosp     			})
		aadd( a_Msg, { "senha"	        , cSenhaInt        			})
		aadd( a_Msg, { "hora"	        , cHora         			})
		aadd( a_Msg, { "executante"   	, cExecut        			})
		aadd( a_Msg, { "tp_internacao"	, cIntern       			})
		aadd( a_Msg, { "acomodacao"  	, cAcomod       			})
		aadd( a_Msg, { "ind_clinica"	, cIndCli        			})

		// Função genérica encontrada no arquico FUNCSGENERICAS.prw para envio de e-mail.
		//u_GEnvMail(c_Htm, c_To, c_CC, c_Assunto, a_Msg )

	EndIf
	*/

	/*
	cSQL := "SELECT BEJ.*,BR8_TPPROC "
	cSQL += "FROM "+RetSQLName("BEJ")+" BEJ, "+RetSQLName("BR8")+" BR8 "
	cSQL += "WHERE BEJ_FILIAL  = '"+xFilial("BEJ")+"' "
	cSQL += "  AND BR8_FILIAL  = '"+xFilial("BR8")+"' "
	cSQL += "  AND BR8_CODPAD  = BEJ_CODPAD "
	cSQL += "  AND BR8_CODPSA  = BEJ_CODPRO "
	cSQL += "  AND BEJ_CODOPE  = '"+ BE4->BE4_CODOPE+"' "
	cSQL += "  AND BEJ_ANOINT  = '"+ BE4->BE4_ANOINT+"' "
	cSQL += "  AND BEJ_MESINT  = '"+ BE4->BE4_MESINT+"' "
	cSQL += "  AND BEJ_NUMINT  = '"+ BE4->BE4_NUMINT+"' "
	cSQL += "  AND BEJ.D_E_L_E_T_  = ' ' AND BR8.D_E_L_E_T_  = ' ' "
	cSQL += "ORDER BY BEJ_QTDPRO DESC"
	*/

	///SOLUCAO FOI PARA O FUNCOES.PRW
	/*
	cSQL := "SELECT BEJ_CODPAD, BEJ_CODPRO, BEJ_DESPRO, BR8_TPPROC, BD4_VALREF, BKF_COEFIC "
	cSQL += " FROM "+ RetSQLName("BEJ")+" BEJ, "+RetSQLName("BR8")+" BR8, "+RetSQLName("BD4")+" BD4, "+RetSQLName("BKF")+" BKF "
	cSQL += " WHERE BEJ_FILIAL = '"+xFilial("BEJ")+"' "
	cSQL += "  AND BR8_FILIAL = '"+xFilial("BR8")+"' "
	cSQL += "  AND BD4_FILIAL = '"+xFilial("BD4")+"' "
	cSQL += "  AND BKF_FILIAL = '"+xFilial("BKF")+"' "
	cSQL += "  AND BR8_CODPAD = BEJ_CODPAD "
	cSQL += "  AND BR8_CODPSA = BEJ_CODPRO "
	cSQL += "  AND BR8_CODPAD = BD4_CDPADP "
	cSQL += "  AND BR8_CODPSA = BD4_CODPRO "
	cSQL += "  AND BKF_CODINT = BEJ_CODOPE "
	cSQL += "  AND BKF_CODTAB = SUBSTR(BD4_CODTAB,5,3) "
	cSQL += "  AND BKF_SEQPOR = BD4_VALREF "
	cSQL += "  AND BD4_CODIGO IN ('PA','PAP') "
	cSQL += "  AND BD4_VIGFIM = ' ' "
	cSQL += "  AND BEJ_CODOPE  = '"+ BE4->BE4_CODOPE+"' "
	cSQL += "  AND BEJ_ANOINT  = '"+ BE4->BE4_ANOINT+"' "
	cSQL += "  AND BEJ_MESINT  = '"+ BE4->BE4_MESINT+"' "
	cSQL += "  AND BEJ_NUMINT  = '"+ BE4->BE4_NUMINT+"' "
	cSQL += "  AND BEJ.D_E_L_E_T_ = ' ' "
	cSQL += "  AND BR8.D_E_L_E_T_ = ' ' "
	cSQL += "  AND BD4.D_E_L_E_T_ = ' ' "
	cSQL += "  AND BKF.D_E_L_E_T_ = ' ' "

	cSQL += "UNION "

	cSQL += "SELECT BQV_CODPAD, BQV_CODPRO, BQV_DESPRO, BR8_TPPROC, BD4_VALREF, BKF_COEFIC "
	cSQL += " FROM "+ RetSQLName("BQV")+" BQV, "+RetSQLName("BR8")+" BR8, "+RetSQLName("BD4")+" BD4, "+RetSQLName("BKF")+" BKF "
	cSQL += " WHERE BQV_FILIAL = '"+xFilial("BQV")+"' "
	cSQL += "  AND BR8_FILIAL = '"+xFilial("BR8")+"' "
	cSQL += "  AND BD4_FILIAL = '"+xFilial("BD4")+"' "
	cSQL += "  AND BKF_FILIAL = '"+xFilial("BKF")+"' "
	cSQL += "  AND BR8_CODPAD  = BQV_CODPAD "
	cSQL += "  AND BR8_CODPSA  = BQV_CODPRO "
	cSQL += "  AND BR8_CODPAD  = BD4_CDPADP "
	cSQL += "  AND BR8_CODPSA  = BD4_CODPRO "
	cSQL += "  AND BKF_CODINT  = BQV_CODOPE "
	cSQL += "  AND BKF_CODTAB  = SUBSTR(BD4_CODTAB,5,3) "
	cSQL += "  AND BKF_SEQPOR  = BD4_VALREF "
	cSQL += "  AND BD4_CODIGO IN ('PA','PAP') "
	cSQL += "  AND BD4_VIGFIM  = ' ' "
	cSQL += "  AND BQV_CODOPE  = '"+ BE4->BE4_CODOPE+"' "
	cSQL += "  AND BQV_ANOINT  = '"+ BE4->BE4_ANOINT+"' "
	cSQL += "  AND BQV_MESINT  = '"+ BE4->BE4_MESINT+"' "
	cSQL += "  AND BQV_NUMINT  = '"+ BE4->BE4_NUMINT+"' "
	cSQL += "  AND BQV.D_E_L_E_T_  = ' ' "
	cSQL += "  AND BR8.D_E_L_E_T_  = ' ' "
	cSQL += "  AND BD4.D_E_L_E_T_  = ' ' "
	cSQL += "  AND BKF.D_E_L_E_T_  = ' ' "

	cSQL += " ORDER BY BD4_VALREF DESC"

	PLSQuery(cSQL,"PLSBEJ")

	//COUNT TO nQtdRegBEJ

	//_nQtdPro := 0
	//aValor   := {}

	cCodpla := Posicione("BA1",1,xFilial("BA1")+BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG+BA1_DIGITO),"BA1_CODPLA")
	if cCodPla = " "
		cCodpla := Posicione("BA3",1,xFilial("BA3")+BA3->(BA3_CODINT+BA3_CODEMP+BA3_MATRIC+BA3_CONEMP+BA3_VERCON+BA3_SUBCON+BA3_VERSUB),"BA3_CODPLA")
	endif

	cSQL2 += "SELECT DISTINCT ZZZ_DESCRI, ZZZ_VLRUS, ZZZ_FATMUL, ZZZ_CODPLA"
	cSQL2 += " FROM "+ RetSQLName("ZZZ")+" ZZZ "
	cSQL2 += " WHERE ZZZ_FILIAL = '"+xFilial("ZZZ")+"' "
	cSQL2 += "  AND ZZZ_DESCRI LIKE '%ANESTESIA%' "
	cSQL2 += "  AND ZZZ_VIGFIN = ' ' "
	cSQL2 += "  AND ZZZ_CODPLA = " + cCodpla
	cSQL2 += "  AND D_E_L_E_T_ = ' ' "
	cSQL2 += "ORDER BY ZZZ_CODPLA "

	PLSQuery(cSQL2,"PLSZZZ")

	nFatMul := PLSZZZ->(ZZZ_FATMUL)

	nChReem := PLSZZZ->(ZZZ_VLRUS)

	bLinhaIni := .T.

	PLSBEJ->( dbGoTop() )
	while PLSBEJ->( !Eof() )
		// BR8 - Tabela de Tipos de procedimentos     Campo = BR8_TPPROC
		// 0=Procedimento;1=Material;2=Medicamento;3=Taxas;4=Diárias;5=Órtese/Prótese;6=Pacote;7=Gases Medicinais;8=Aluguéis
		if PLSBEJ->BR8_TPPROC == '0'
			//BIANCHINI - INICIO
			if bLinhaIni == .T.
				nValReem += (PLSBEJ->BKF_COEFIC * nChReem) * nFatMul     //100%
				bLinhaIni := .F.
			else
				nValReem += ((PLSBEJ->BKF_COEFIC * nChReem) * nFatMul) * 0.7  //70%
			endif
			//BIANCHINI - FIM
			//_nQtdPro += PLSBEJ->( BEJ_QTDPRO )
		endif
		PLSBEJ->( dbSkip() )
	enddo

	if nValReem > 0
		DEFINE FONT oFont NAME "Arial" SIZE 000,-016 BOLD
		DEFINE MSDIALOG oDlg TITLE "Informe Estimado de Anestesia" FROM 008.2,003.3 TO 016,055 OF GetWndDefault()
		@ 18,  10  Say   oSay PROMPT "Valor Médio Estimado : "	SIZE 160,10 OF oDlg FONT oFont COLOR CLR_HBLUE PIXEL
		@ 18, 120  MSGET oGet VAR nValReem                      SIZE  40,10	OF oDlg FONT oFont PICTURE "@RE 99999.00" WHEN .F. PIXEL
		bInAl   := TButton():New(38, 85,'Ok',,{ || nOpca := 0 , oDlg:End() } , 040, 012 ,,,,.T.)
		//bFechar := TButton():New(38,140,'Rejeitar'   ,,{ || nOpca := 2 , oDlg:End() } , 040, 012 ,,,,.T.)
		ACTIVATE MSDIALOG oDlg CENTERED

		if (nOpca == 0) .and. (BE4->BE4_YMEDAN <> nValReem)
			//MsgStop ( "Neste ponto fará a gravação do calculo da media de anestesia..." )

			BE4->( RecLock("BE4", .F.) )
			BE4->BE4_YMEDAN := round(nValReem,0)
			BE4->( MsUnLock() )
			lRefresh := .T.

		endif
	else
		MsgAlert( "Nao ha valor médio para anestesia...Verifique !!" )
	endif


	PLSBEJ->(DbCloseArea())
	PLSZZZ->(DbCloseArea())     */
	If alltrim( GetNewPar("MV_XLOGINT", '0') ) == '1'
		If FunName() == "PLSA092"

			u_LogMatInt(M->BE4_USUARI, M->BE4_NOMUSR, "PLA092FIM - 1")

		EndIf
	EndIf

	if (nOpca == 0)

		BE4->( RecLock("BE4", .F.) )
		BE4->BE4_YMEDAN := u_PreviAn(BE4->BE4_CODOPE, BE4->BE4_ANOINT, BE4->BE4_MESINT, BE4->BE4_NUMINT, nOpca, BA1->BA1_CODINT, BA1->BA1_CODEMP, BA1->BA1_MATRIC, BA1->BA1_TIPREG, BA1->BA1_DIGITO, BA3->BA3_CONEMP, BA3->BA3_VERCON, BA3->BA3_SUBCON, BA3->BA3_VERSUB, FUNNAME())
		BE4->( MsUnLock() )
		lRefresh := .T.

	endif

	If alltrim( GetNewPar("MV_XLOGINT", '0') ) == '1'
		If FunName() == "PLSA092"

			u_LogMatInt(M->BE4_USUARI, M->BE4_NOMUSR, "PLA092FIM - 2 -- be4->be4_matric" + BE4->BE4_MATRIC  )

		EndIf
	EndIf

	//--------------------------------------------------------------------------------------------------------
	//INICIO - Angelo Henrique - Data: 29/06/2017
	//--------------------------------------------------------------------------------------------------------
	//Projeto OPME
	//--------------------------------------------------------------------------------------------------------
	//Conforme solicitado:
	//Fazer com que o campo data da Validade seja calculado a partir da data de liberação da senha
	//--------------------------------------------------------------------------------------------------------
	If !(Empty(BE4->BE4_DATPRO))

		BE4->( RecLock("BE4", .F.))

		BE4->BE4_DATVAL := BE4->BE4_DATPRO + GetMV("MV_PLPRZLB")

		BE4->( MsUnLock() )

	EndIf

	//------------------------------------------------------------------------------------
	//Conforme solicitado, quando a internação for de psiquiatria ou regime domiciliar
	//a tela de opme não irá ser apresentada
	//------------------------------------------------------------------------------------
	If !(BE4->BE4_REGINT = "3")

		//----------------------------------------------------------------------------------------
		//Solicitado que nos casos de internação domiciliar , psiquiátrica e reciprocidade
		//não seja exibida a tela de OPME
		//----------------------------------------------------------------------------------------
		If !(BE4->BE4_GRPINT = "5")

			If !(BE4->BE4_REGINT = '3')

				DbSelectArea("BAU")
				DbSetOrder(1)
				If DbSeek(xFilial("BAU") + BE4->BE4_CODRDA)

					If!( BAU->BAU_TIPPRE $ "OPE|REC") 

						u_PLSM3A() 

					EndIf

				EndIf

			EndIf

		EndIf

	EndIf
	//--------------------------------------------------------------------------------------------------------
	//FIM - Angelo Henrique - Data: 29/06/2017
	//--------------------------------------------------------------------------------------------------------

	//-----------------------------------------------------------------------------------------------
	//Angelo Henrique - Data: 19/10/2017
	//Criando aqui validação para quando a rotina padrão não criar os itens eda auditoria
	//-----------------------------------------------------------------------------------------------

	u_CB181AUD()

	//-----------------------------------------------------------------------------------------------
	//-----------------------------------------------------------------------------------------------


	//--------------------------------------------------------------------------------------------------------
	//Inicio - Angelo Henrique - Data: 03/10/2017
	//--------------------------------------------------------------------------------------------------------
	//Chamada para a validação do projeto de psiquiatria.
	//--------------------------------------------------------------------------------------------------------
	/*
	If BE4->BE4_GRPINT = "5" //Internação Psiquiatrica

	u_CABA601("1")

	EndIf
	*/
	//--------------------------------------------------------------------------------------------------------
	//Fim - Angelo Henrique - Data: 03/10/2017
	//--------------------------------------------------------------------------------------------------------
	

	//--------------------------------------------------------------------------------------------------------
	//Inicio - Angelo Henrique - Data: 03/10/2021
	//--------------------------------------------------------------------------------------------------------
	//Chamada para a disparo de email para prestador quando for emergencia/urgencia
	//--------------------------------------------------------------------------------------------------------
	If AllTrim(BE4->BE4_TIPADM) $ ("4,5") 
		
		U_CABA099(BE4->(BE4_FILIAL+BE4_CODOPE+BE4_ANOINT+BE4_MESINT+BE4_NUMINT)) 

	EndIf

	RestArea(_aArBAU)

Return