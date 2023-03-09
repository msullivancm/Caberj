#Include "rwmake.ch"
#Include "plsmger.ch"
#Include "colors.ch"
#Include "topconn.ch"

/*/
ээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээ
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
╠╠зддддддддддбдддддддддбдддддддбддддддддддддддддддддддддбддддддбдддддддддд©╠╠╠
╠╠ЁFuncao    Ё CRJ999  Ё Autor Ё Geraldo Felix Junior.  Ё Data Ё 05/12/07 Ё╠╠╠
╠╠цддддддддддедддддддддадддддддаддддддддддддддддддддддддаддддддадддддддддд╢╠╠╠
╠╠ЁDescricao Ё Relatorio de Usuarios por Grupo/Empresa                    Ё╠╠╠
╠╠цддддддддддедддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд╢╠╠╠
╠╠ЁSintaxe   Ё PLSR256()                                                  Ё╠╠╠
╠╠цддддддддддедддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд╢╠╠╠
╠╠Ё Uso      Ё Advanced Protheus                                          Ё╠╠╠
╠╠цддддддддддадддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд╢╠╠╠
╠╠Ё Alteracoes desde sua construcao inicial                               Ё╠╠╠
╠╠цддддддддддбддддддбдддддддддддддбддддддддддддддддддддддддддддддддддддддд╢╠╠╠
╠╠Ё Data     Ё BOPS Ё Programador Ё Breve Descricao                       Ё╠╠╠
╠╠цддддддддддеддддддедддддддддддддеддддддддддддддддддддддддддддддддддддддд╢╠╠╠
╠╠Ё 26/08/05 Ё      Ё Clarice     Ё Alteracoes para tratar debito/credito Ё╠╠╠
╠╠Ё 08/05    Ё      Ё Geraldo     Ё Alteracoes p/ tratar o q foi cobrado  Ё╠╠╠
╠╠Ё 08/06    Ё      Ё AndrИ MendesЁ AdequaГУes para Utilizar como Extrato Ё╠╠╠
╠╠юддддддддддаддддддадддддддддддддаддддддддддддддддддддддддддддддддддддддды╠╠╠
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
ъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъ
/*/
//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Define nome da funcao...                                                 Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
User Function CRJR999()
	LOCAL aCriticas := {}
	
	//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//Ё Define variavaoeis...                                                    Ё
	//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
	PRIVATE nQtdLin := 50 //74 -- Angelo Henrique - Data: 02/10/2018 - Reduzido tamanho para quebra de pАgina
	PRIVATE cNomeProg   := "CRJ999"
	PRIVATE nCaracter   := 15
	PRIVATE nLimite     := 132
	PRIVATE cTamanho    := "M"
	PRIVATE cTitulo     := "Relatorio da Cobranca"
	PRIVATE cDesc1      := "Relatorio da Cobranca"
	PRIVATE cDesc2      := ""
	PRIVATE cDesc3      := ""
	PRIVATE cCabec1     := ""
	PRIVATE cCabec2     := ""
	PRIVATE cAlias      := "BA3"
	PRIVATE cPerg       := "CRJ999"
	PRIVATE cRel        := "CRJ999"
	PRIVATE nLi         := 01
	PRIVATE m_pag       := 1
	PRIVATE aReturn     := { "Zebrado", 2,"Administracao", 2, 1, 1, "",1 }
	PRIVATE lAbortPrint := .F.
	PRIVATE aOrdens     := {}
	PRIVATE lDicion     := .F.
	PRIVATE lCompres    := .F.
	PRIVATE lCrystal    := .F.
	PRIVATE lFiltro     := .T.
	PRIVATE nCredito 	  := 0
	PRIVATE nDebito     := 0
	PRIVATE a_uni_flag := .t.
	private cFat := " "
	private nSinal := " "
	Private lContRot := .T. // variАvel de controle para reabertura da tela.
	
	
	//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//Ё Recebe parametros                                                        Ё
	//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
	//Pergunte( cPerg ,  .F.)
	While lcontRot
		
		CriaSX1()
		
		If !Pergunte(cPerg,.T.)
			Return
		Endif
		
		nCompara := mv_par01
		_cMes    := mv_par02
		_cAno    := mv_par03
		cOpe     := mv_par04
		nTipCon  := mv_par05
		cGrupIni := mv_par06
		cGrupFim := mv_par07
		cContDe  := mv_par08
		cContAte := mv_par09
		cSubConI := mv_par10
		cSubConF := mv_par11
		cMatrIni := mv_par12
		cMatrFin := mv_par13
		cMtAnIni := mv_par14
		cMtAnFin := mv_par15
		cDatFin  := mv_par16
		cGrpCIni := mv_par17
		cGrpCFin := mv_par18
		nTipRel  := mv_par19
		nFamZer  := mv_par20
		lDetCO	:= mv_par21
		cLoteCb	:= mv_par22
		_cAnoFin := ""
		_cMesFin := ""
		
		aReturn     := { "Zebrado", 2,"Administracao", 2, 1, 1, "",1 }
		m_pag       := 1
		
		If !Empty(mv_par24)
			_cAnoFin := Substr(mv_par24,1,4)
			_cMesFin := Substr(mv_par24,5,2)
		Endif
		
		cTitulo :=  cTitulo +" "+ _cMes + "/" + _cAno
		
		cCabec1 := "         Matricula Usuario    Tp Nome Usuario                    Cod  Descricao                                           Valor"
		cCabec2 := "Data     Nome do Prestador              Proced   DescriГЦo AMB                              L.Dg. PEG     Numero          Valor"
		/*      10        20        30        40        50        60        70        80        90       100       110       120       130       140       150       160       170       180       190       200       210       220
		1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
		*/
		//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
		//Ё Chama SetPrint                                                           Ё
		//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
		cRel := SetPrint(cAlias,cRel,"",     @cTitulo,cDesc1,cDesc2,cDesc3,lDicion,aOrdens,lCompres,cTamanho,{},lFiltro,lCrystal)
		
		//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
		//Ё Verifica se foi cancelada a operacao                                     Ё
		//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
		If nLastKey  == 27
			Return
		Endif
		
		//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
		//Ё Configura Impressora                                                     Ё
		//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
		SetDefault(aReturn,cAlias)
		//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
		//Ё Monta RptStatus...                                                       Ё
		//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
		MsAguarde( {|| aCriticas := RImp256() }  , "Imprimindo...", "" , .T. )
		
		//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
		//Ё Caso tenha critica...                                                    Ё
		//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
		If Len(aCriticas) > 0
			PLSCRIGEN(aCriticas,{ {"Matricula","@C",70},{"Critica","@C",170 } },"Criticas do relatorio.")
		Endif
		
		if !MsgYesNo("Deseja gerar novamente este relatСrio?","Acesso")
			lContRot := .F.
		endif
		
	EndDo
	//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//Ё Fim da Rotina Principal...                                               Ё
	//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
Return


/*/
ээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээ
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
╠╠зддддддддддбдддддддддбдддддддбддддддддддддддддддддддддбддддддбдддддддддд©╠╠╠
╠╠ЁFuncao    Ё RImp256 Ё Autor Ё Geraldo Felix Junior   Ё Data Ё 24.11.02 Ё╠╠╠
╠╠цддддддддддедддддддддадддддддаддддддддддддддддддддддддаддддддадддддддддд╢╠╠╠
╠╠ЁDescricao Ё Relatorio de contratos.                                    Ё╠╠╠
╠╠юддддддддддадддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды╠╠╠
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
ъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъ
/*/
//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Define nome da funcao                                                    Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
Static Function RImp256()
	
	Local _nCont := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS
	
	//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//Ё Variaveis do IndRegua...                                                 Ё
	//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
	LOCAL	nFor
	LOCAL	lTemUsr
	Local	lPrimeiro	:= .T.
	LOCAL	aVlrFam 		:= {}
	LOCAL	aVlrCO  		:= {}
	LOCAL	aCriticas 	:= {}
	LOCAL	aUsuarios 	:= {}
	LOCAL	nColCO		:= 0
	LOCAL	lImp 			:= .T.
	LOCAL	cFatura 		:= ''
	LOCAL cMatFam		:= ''
	LOCAL nQtdMeses 	:= 1
	
	PRIVATE cFor
	PRIVATE cOrdem
	PRIVATE cInd    	:= CriaTrab(Nil,.F.)
	//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//Ё Inicios de colunas...                                                    Ё
	//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
	PRIVATE nColEmp := 00
	PRIVATE nColCon := 03
	PRIVATE nColSub := 06
	PRIVATE nColuna := 00
	PRIVATE nColUsr := 09
	//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//Ё Controles de quebars...                                                  Ё
	//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
	PRIVATE cCodEmp := ""
	PRIVATE cCodCon := ""
	PRIVATE cCodSub := ""
	//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//Ё Variaveis de uso generico...                                             Ё
	//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
	PRIVATE cLinha  := Space(00)
	PRIVATE pMoeda  := "@E 99,999,999.99"
	PRIVATE aValor
	
	//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//Ё Exibe mensagem informativa...                                            Ё
	//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
	MsProcTXT("Aguarde. Buscando dados no servidor...")
	ProcessMessage()
	
	//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//Ё Totalizadores por Empresa...                                             Ё
	//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
	PRIVATE nTotCobEmp := 0
	PRIVATE nTotRegEmp := 0
	Private aQtdusrEmp := 0
	//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//Ё Totalizadores por Contrato...                                            Ё
	//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
	PRIVATE nTotCobCon := 0
	PRIVATE nTotRegCon := 0
	Private aQtdusrCon := 0
	//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//Ё Totalizadores por SubContrato...                                         Ё
	//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
	PRIVATE nTotCobSub := 0
	PRIVATE nTotRegSub := 0
	PRIVATE nVlrCob    := 0
	Private aQtdusrSub := 0
	
	
	//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//Ё Monta Expressao de filtro...                                             Ё
	//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
	cFor := "SELECT * FROM "+RetSqlName("BA3")+" WHERE BA3_FILIAL = '"+xFilial("BA3")+"' "
	cFor += "And BA3_CODINT = '"+cOpe+"' "
	cFor += "And BA3_CODEMP >= '"+cGrupIni+"' "
	cFor += "And BA3_CODEMP <= '"+cGrupFim+"' "
	cFor += "And BA3_DATBAS <= '"+DTOS(cDatFin)+"' "
	cFor += "And BA3_CONEMP >= '"+cContDe+"' "
	cFor += "And BA3_CONEMP <= '"+cContAte+"' "
	cFor += "And BA3_MATRIC >= '"+cMatrIni+"' "
	cFor += "And BA3_MATRIC <= '"+cMatrFin+"' "
	cFor += "And BA3_MATANT >= '"+cMtAnIni+"' "
	cFor += "And BA3_MATANT <= '"+cMtAnFin+"' "
	cFor += "And BA3_SUBCON >= '"+cSubConI+"' "
	cFor += "And BA3_SUBCON <= '"+cSubConF+"' "
	cFor += "And D_E_L_E_T_ = ' ' "
	cFor += "Order by BA3_CODINT+BA3_CODEMP+BA3_CONEMP+BA3_SUBCON+BA3_MATRIC "
	
	PlsQuery(cFor, "TRBBA3")
	
	//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//Ё Monta chaves de quebra...                                     .          Ё
	//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
	cCodEmp := ""
	cCodCon := ""
	cCodSub := ""
	
	
	//Jean - 13/2/08
	//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//Ё Obtem quantidade de meses que devem ser impressos por familia...		 Ё
	//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
	If !Empty(_cAnoFin)
		
		**'Marcela Coimbra - Inicio RDM 001/2011'**
		// nQtdMeses := Int((StoD(_cAnoFin+_cMesFin+"15")-StoD(_cAno+_cMes+"15"))/30, 0 )
		
		nQtdMeses := round((StoD(_cAnoFin+_cMesFin+"15")-StoD(_cAno+_cMes+"15"))/30, 0 )
		
		**'Marcela Coimbra - Fim RDM 001/2011'**
		
	Endif
	
	BQC->(DbSetOrder(1))
	
	BA3->( dbGoto(TRBBA3->R_E_C_N_O_) )
	R256Cab(.F.)
	
	
	While ! TRBBA3->(Eof())
		
		//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
		//Ё Apresenta mensagem em tela...                                            Ё
		//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
		MsProcTXT("Familia - "+BA3->BA3_CODINT+"."+BA3->BA3_CODEMP+"."+BA3->BA3_MATRIC)
		ProcessMessage()
		
		//Jean - inicio da alteracao para demonstrar por mes...
		_cMes := mv_par02
		_cAno := mv_par03
		
		If nQtdMeses > 1
			R256Cab(.T.)
		Endif
		
		For _nCont := 1 to nQtdMeses
			
			
			If _nCont > 1
				cAux := PLSDIMAM(_cAno,_cMes,"1")
				_cAno := Substr(cAux,1,4)
				_cMes := Substr(cAux,5,2)
			Endif
			
			
			//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
			//Ё Posiciona o BA3.                                                         Ё
			//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
			BA3->( dbGoto(TRBBA3->R_E_C_N_O_) )
			lPF := (BA3->BA3_TIPOUS == "1")
			
			//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
			//Ё Verifica tipo de contrato selecionado                              Ё
			//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
			If  nTipCon <> 3 .and. ;
					BA3->BA3_TIPOUS <> strzero(nTipCon,1)
				
				// Motta Fev/09 Loop do _nCont := 1 to nQtdMeses // TRBBA3->(DbSkip())
				Loop
			EndIf
			
			//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
			//Ё Se for pessoa juridica, verifica se pertence ao grupo de           Ё
			//Ё    cobranca informado nos parametros                               Ё
			//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
			
			//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS - CRJR999.PRW(329)   Command has no effect
			//BA3->BA3_TIPOUS == "2"
			
			If  BA3->BA3_TIPOUS == "2"
				If  BA3->(BA3_CODINT+BA3_CODEMP+BA3_CONEMP+BA3_VERCON+BA3_SUBCON+BA3_VERSUB) <> ;
						BQC->(BQC_CODIGO+BQC_NUMCON+BQC_VERCON+BQC_SUBCON+BQC_VERSUB)
					If  ! BQC->(msSeek(xFilial("BQC")+BA3->(BA3_CODINT+BA3_CODEMP+BA3_CONEMP+BA3_VERCON+BA3_SUBCON+BA3_VERSUB)))
						Aadd(aCriticas, {BA3->BA3_CODINT+"."+BA3->BA3_CODEMP+"."+BA3->BA3_MATRIC,;
							"Sub-contrato nao encontrado"})
						// Motta Fev/09 Loop do _nCont := 1 to nQtdMeses // TRBBA3->(DbSkip())
						Loop
					EndIf
				Endif
				
				If TRBBA3->BA3_COBNIV == "1"
					If TRBBA3->BA3_GRPCOB < cGrpCIni .or. ;
							TRBBA3->BA3_GRPCOB > cGrpCFin
						// Motta Fev/09 Loop do _nCont := 1 to nQtdMeses // TRBBA3->(DbSkip())
						Loop
					EndIf
				Else
					If BQC->BQC_GRPCOB < cGrpCIni .or. ;
							BQC->BQC_GRPCOB > cGrpCFin
						// Motta Fev/09 Loop do _nCont := 1 to nQtdMeses // TRBBA3->(DbSkip())
						Loop
					EndIf
				Endif
				
			Endif
			
			//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
			//Ё Verifica se foi abortada a impressao...                            Ё
			//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
			If  Interrupcao(lAbortPrint)
				Exit
			Endif
			
			//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
			//Ё Trata quebras de instituicao...                                    Ё
			//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
			If  BA3->BA3_CODEMP <> cCodEmp
				
				//здддддддддддддддддддддддддддддддддддддддддддддддддддд©
				//ЁAlteracoes efetuadas por Clarice em 26/08/05        Ё
				//Ёpara atender Debito/Credito consedidos para empresasЁ
				//Ёverificar com Geraldo como tratar isso no padrao do Ё
				//Ёsistema.                                            Ё
				//юдддддддддддддддддддддддддддддддддддддддддддддддддддды
				
				//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
				//Ё Imprime totais gerais...                                           Ё
				//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
				If  nTotRegSub > 0 .And. !lPF
					R256Tot(nColSub,nTotCobSub,"Total do Sub-contrato")
					nTotCobSub := 0
					nTotRegSub := 0
					lPF := .F.
				Endif
				If  nTotRegCon > 0 .And. !lPF
					nTotCobCon := 0
					nTotRegCon := 0
					lPF := .F.
				Endif
				
				If  nTotRegEmp > 0
					nTotCobEmp := 0
					nTotRegEmp := 0
					R256Cab(.F.)//Finaliza pagina Clarice
				Endif
				//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
				//Ё Remonta dados de quebra...                                         Ё
				//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
				cCodEmp    := BA3->BA3_CODEMP
				nTotRegEmp := 0
				nTotCobEmp := 0
				If  lPrimeiro
					lPrimeiro := .F.
				Endif
				
				if mv_par23 = 1 //sim quebra linha
					nLi ++ //; @ nLi, nColEmp pSay RetFatura (mv_par04,mv_par22)
				endif
				
				if a_uni_flag = .f.
					R256Cab(.F.)//Finaliza pagina Clarice
				endif
				
				a_uni_flag := .f.
				
			Endif
			
			//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
			//Ё Trata quebras de empresas...                                       Ё
			//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
			If  BA3->BA3_CONEMP <> cCodCon .and. BA3->BA3_TIPOUS == "2"
				//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
				//Ё Imprime totais gerais...                                           Ё
				//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
				If  nTotRegSub > 0 .And. !lPF
					R256Tot(nColSub,nTotCobSub,"Total do Sub-contrato")
					nTotCobSub := 0
					nTotRegSub := 0
					lPF := .F.
					R256Cab(.F.)//Finaliza pagina Clarice
				Endif
				
				If  nTotRegCon > 0 .And. !lPF
					nTotCobCon := 0
					nTotRegCon := 0
					lPF := .F.
					R256Cab(.F.)//Finaliza pagina Clarice
				Endif
				//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
				//Ё Remonta dados da quebra...                                         Ё
				//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
				cCodCon    := BA3->BA3_CONEMP
				nTotCobCon := 0
				nTotRegCon := 0
				
				nLi ++ ; @ nLi, nColCon pSay "Contrato: "+cCodCon
			Endif
			//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
			//Ё Trata quebras de Sub-Contrato...                                   Ё
			//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
			If  BA3->BA3_SUBCON <> cCodSub .and. BA3->BA3_TIPOUS == "2"
				
				
				//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
				//Ё Imprime totais gerais...                                           Ё
				//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
				If  nTotRegSub > 0 .And. !lPF
					nCredito:= RetDeCre(cOpe,cCodEmp,cCodCon,cCodSub,_cAno, _cMes ,"130",mv_par04,mv_par22)
					nDebito := RetDeCre(cOpe,cCodEmp,cCodCon,cCodSub,_cAno,_cMes,"128",mv_par04,mv_par22)//alterado por nelson 24/09/05 inclusao da linha alterando o codigo do lancamento
					
					IF nCredito >0
						R256Tot(nColSub,nCredito,"Total de Creditos ") //de Mensalidades Retroativas
						nTotCobSub -=nCredito
						nTotCobEmp -=nCredito
						nTotCobCon -=nCredito
					EndIf
					If nDebito >0
						
						R256Tot(nColSub,nDebito ,  "Total de Debito ")//de Mensalidades Retroativas
						
						nTotCobSub +=nDebito
						nTotCobEmp +=nDebito
						nTotCobCon +=nDebito
					EndIf
					
					R256Tot(nColSub,nTotCobSub,"Total do Sub-contrato")
					nTotCobSub := 0
					nTotRegSub := 0
					lPF := .F.
					
					R256Cab(.F.)//Finaliza pagina Clarice
				Endif
				//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
				//Ё Remonta dados de quebra...                                         Ё
				//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
				cCodSub    := BA3->BA3_SUBCON
				nTotCobSub := 0
				nTotRegSub := 0
				
			Endif
			//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
			//Ё Incrementa a regua...                                              Ё
			//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
			MsPROCTxt("Familia "+BA3->(BA3_CODINT+"."+BA3_CODEMP+"-"+BA3_MATRIC)+"-Mes/Ano: "+_cMes+"/"+_cAno)
			ProcessMessage()
			
			//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
			//Ё Posiciona o usuario...                                             Ё
			//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
			BA1->(DbSetOrder(2))
			BA1->(msSeek(xFilial("BA1")+BA3->(BA3_CODINT+BA3_CODEMP+BA3_MATRIC)))
			
			aUsuarios := 	U_UNILOADUSR(TRBBA3->BA3_CODINT,TRBBA3->BA3_CODEMP,TRBBA3->BA3_MATRIC,_cAno,_cMes)
			
			if !(Len(aUsuarios)==0)
				a_uni_flag = .t.
			endif
			
			//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
			//Ё Apura o valor de cobranca da familia...                            Ё
			//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
			aVlrFam := PLSVLRFAM(BA3->(BA3_CODINT+BA3_CODEMP+BA3_MATRIC),_cAno,_cMes,,,.T.,,,.T.)
			
			//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
			//Ё Monta matriz com valor de cobranca total.                          Ё
			//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
			aValor := aClone(aVlrFam[2])
			
			If  Type('aValor') <> "A"
				CONOUT("[SIGAPLS] Retorno da funcao PLSVLRFAM invalida matricula "+BA3->(BA3_CODINT+BA3_CODEMP+BA3_MATRIC))
				// Motta Fev/09 Loop do _nCont := 1 to nQtdMeses // TRBBA3->(DbSkip())
				Loop
			Endif
			lValor := .F.
			lVlrCo := .F.
			If aValor[1]
				lValor := .T.
				aValor := aValor[2]
			Else
				// Motta Fev/09 Loop do _nCont := 1 to nQtdMeses // TRBBA3->(DbSkip())
				Loop
			Endif
			nTotFam   := 0
			lTemUsr   := .F.
			cLinFam   := BA3->(BA3_CODINT+"."+BA3_CODEMP+"-"+BA3_MATRIC)+"-"
			While (!BA1->(EOF())) .And. (BA1->BA1_CODINT+BA1->BA1_CODEMP+BA1->BA1_MATRIC == BA3->BA3_CODINT+BA3->BA3_CODEMP+BA3->BA3_MATRIC)
				If  nLi > nQtdLin
					R256Cab(.F.)
				Endif
				cMatEmp := IIF(!Empty(BA1->BA1_MATEMP),Substr(Alltrim(BA1->BA1_MATEMP),1,6),Space(6))
				cLinUsr := BA1->BA1_TIPREG+Space(2)+BA1->BA1_TIPUSU+Space(02)+Substr(BA1->BA1_NOMUSR,1,25)+Space(1)+cMatEmp+ Space(2)
				nTotUsr := 0
				nTotUsr := 0
				cMatFam := BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC)
				cFatura := ''
				cNumTit := "'"
				
				If lValor
					For nFor := 1 To Len(aValor)
						If  aValor[nFor,7] == BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG+BA1_DIGITO) //.And. ! aValor[nFor,9]
							
							// Faz filtro por lote de cobranca se for informado nos paramentros.
							//					If !Empty(mv_par02) .and. Len(aValor[nFor]) > 19 //alterei porque lote Иo parametro 22 AndrИ 03082006
							
							If !Empty(mv_par22) .and. Len(aValor[nFor]) > 19
								If aValor[nFor,20] <> mv_par04+mv_par22
									Loop //original
								Endif
							Endif
							
							//Alexandre 07-12-09: Alterado para inibir os registros de reembolso
							If aValor[nFor,4] = '108'
								Loop
							Endif
							
							// Pega o numero da fatura no BM1.
							If Len(aValor[nFor]) > 18
								cFatura := aValor[nFor,19]
								cNumTit := cNumTit + iif( cNumTit == "'", cFatura, "','" + cFatura )
							Endif
							
							aValCopart := aValor[nFor,2]
							//imprime detalhe bm1
							If  nTipRel == 1 // relatorio analitico
								If  aValor[nFor,1] == '1'
									nSinal := '+'
								Else
									nSinal := '-'
								EndIf
								nLi ++
								@ nLi, nColUsr pSay cLinFam + cLinUsr + substr(aValor[nFor,4]+"-"+aValor[nFor,5]+Space(100),1,52)+TransForm(aValCopart,PLPMONEY_P)+space(01)+nSinal
								cLinUsr := space(41)
							Endif
							// fim da impressao bm1
							If  aValor[nFor,1] == '1'
								nTotUsr += aValCopart //aValor[nFor,2]
							Else
								nTotUsr -= aValCopart //aValor[nFor,2]
							Endif
							
						Endif
					Next
				EndIf
				
				cNumTit := cNumTit + "'"
				
				//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
				//ЁSelecionando dados da movimentacao do usuario quando ha cobranca de co-participacaoЁ
				//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
				cFat:=(substr(cFatura,1,10)+ substr(cFatura,14,3))
				//     		aVlrCO := PLSVLRPF(cMatFam,_cAno,_cMes,{},{},.T.,.T.,cFatura, BA1->BA1_TIPREG)
				//    		aVlrCO := PLSVLRPF(cMatFam,_cAno,_cMes,{},{},.T.,.T.,cFatura, BA1->BA1_TIPREG)
				
				nQtd:= 0
				
				//////////altamiro 02/03/10 opcao ao funГЦo acima
				**'InМcio Marcela - 03/12/2013'**
				If cNumTit <> "''"
					**'Fim Marcela - 03/12/2013'**
					
					cFor := " SELECT R_E_C_N_O_ FROM "+RetSqlName("BD6")+" WHERE BD6_FILIAL = '"+xFilial("BD6")+"' "
					cFor += " AND D_E_L_E_T_ = ' ' AND BD6_CODEMP =  '"+SUBSTR(cmatFam,5,4)+"'  AND BD6_MATRIC = '"+SUBSTR(cmatFam,9,6)+"' AND BD6_TIPREG  = '"+BA1->BA1_TIPREG +"'"
					// Motta 30/1/2012 - query fazia a busca com prefixo = ' '
					
					// Marcela Coimbra - Inicio 03/05/2011
					
					cFor += " AND (( BD6_PREFIX || BD6_NUMTIT || BD6_PARCEL || BD6_TIPTIT in ( " + cNumTit + " ) "
					// cFor += " AND ((BD6_PREFIX <> ' ' AND BD6_PREFIX = '"+ substr(cFatura,1,3)+"' AND  BD6_NUMTIT = '"+substr(cFatura,4,9)+"   ' AND  BD6_PARCEL = '"+substr(cFatura,13,1)+"' "
					// cFor += " AND   BD6_TIPTIT = '"+substr(cFatura,14,3)+"')  OR (BD6_NUMSE1 <> ' ' AND BD6_NUMSE1  = '"+cFat +"' )) "
					
					// Marcela Coimbra - Fim 03/05/2011
					
					cFor += "  OR (BD6_NUMSE1 <> ' ' AND BD6_NUMSE1  = '"+cFat +"' ))) "
					cFor += " AND BD6_BLOCPA <> '1' AND BD6_SITUAC = '1'  AND  BD6_VLRPF  > 0  "
					
					//MemoWrite("c:\sql.txt",cFor)
					//msgAlert (cFatura)
					
					PlsQuery(cFor, "TRBBA4")
					
					If lDetCO == 1
						While ! TRBBA4->(Eof())
							If  nTipRel == 1 // relatorio analitico
								If  nLi > nQtdLin
									R256Cab(.F.)
								Endif
								// Posiciona o BD6...
								BD6->(dbGoto(TRBBA4->R_E_C_N_O_) )
								vCopart := BD6->BD6_VLRTPF
								// Imprime os detalhes...bd6
								nLi ++
								@ nLi, nColCO pSay dToc(BD6->BD6_DATPRO)+" "+;
									Substr(BD6->BD6_NOMRDA,1,30)+" "+;
									Alltrim(Transform(BD6->BD6_CODPRO,PesqPict("BD6","BD6_CODPRO")))+" "+;
									Substr(BD6->BD6_DESPRO,1,43)+"  "+; //Alterado por AndrИ
								BD6->BD6_CODLDP+"  "+;
									BD6->BD6_CODPEG+" "+;
									BD6->BD6_NUMERO+"   "+;
									Transform(vCopart, "@R 9,999,999.99")+"*"
							Endif
							TRBBA4->(DbSkip())
						ENDDO
					Endif
					
					TRBBA4->( dbClosearea() )
					
					**'Inicio Marcela - 03/12/2013'**
				EndIf
				**'Fim Marcela - 03/12/2013'**
				//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
				//Ё Imprime a utilizacao em CO do usuario...                           Ё
				//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
				/*			If lDetCO == 1
				For nCnt := 1 To Len(aVlrCO)
					If  nTipRel == 1 // relatorio analitico
						If  aVlrCO[nCnt,2] <> BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG+BA1_DIGITO) //.And. ! aValor[nFor,9]
							Loop
						Endif
						If  nLi > nQtdLin
							R256Cab(.F.)
						Endif
						
						// Posiciona o BD6...
						BD6->( dbGoto(aVlrCO[nCnt][1]) )
						vCopart := BD6->BD6_VLRTPF
						
						// Imprime os detalhes...
						nLi ++ ; @ nLi, nColCO pSay dToc(BD6->BD6_DATPRO)+" "+;
							Substr(BD6->BD6_NOMRDA,1,30)+" "+;
							Alltrim(Transform(BD6->BD6_CODPRO,PesqPict("BD6","BD6_CODPRO")))+" "+;
							Substr(BD6->BD6_DESPRO,1,43)+"  "+; //Alterado por AndrИ
						BD6->BD6_CODLDP+"  "+;
							BD6->BD6_CODPEG+" "+;
							BD6->BD6_NUMERO+"   "+;
							Transform(vCopart, "@R 9,999,999.99")
					Endif
				Next
			Endif
			*/
			nTotFam += nTotUsr
			lTemUsr := .T.
			lImp := .T.
			BA1->(DbSkip())
		EndDo
		
		If  nTipRel == 1 // relatorio analitico
			If  lTemUsr  // tem usuario na familia
				If  nTotFam > 0 .or. nFamZer == 1  // Familia tem valor ou eh para imprimir familia sem valor
					cLinFam := space(17)
					nLi ++ ; @ nLi, nColUsr pSay    cLinFam + space(07) + "Total da Familia"+replicate(".",70)+TransForm(nTotFam,PLPMONEY_P)
					
					if mv_par23 = 1 //sim quebra linha
						nLi ++ ; @ nLi, nColUsr pSay cLinFam + space(07) + RetFatura (mv_par04,mv_par22,_cMes,_cAno)
					endif
					nLi ++
					@ nLi, nColUsr pSay "* Detalhamento da utilizaГЦo "
					
					nLi ++
					
					if mv_par23 = 1 //sim quebra linha
						nTotCobEmp := 0
						nTotCobCon := 0
						nTotCobSub := 0
						R256Cab(.F.)//Finaliza pagina Clarice
					endif
					
					
				Endif
			Endif
			If  nCompara == 1
				nLi ++ ; @ nLi, nColUsr pSay cLinFam   + space(07) + "TOTAL SIST ANTIGO:"+Space(66)+TransForm(BA3->BA3_VALANT,PLPMONEY_P)
				nLi ++ ; @ nLi, nColUsr pSay space(17) + space(07) + "DIFERENCA        :"+Space(66)+TransForm((nTotFam-BA3->BA3_VALANT),PLPMONEY_P)
				nLi ++ ; @ nLi, nColUsr pSay space(17) + space(07) + "MATRICULA ANTIGA :"+Space(66)+BA3->BA3_MATANT
			Endif
		Endif
		nTotCobEmp += nTotFam
		nTotCobCon += nTotFam
		nTotCobSub += nTotFam
		nTotRegEmp += 1
		nTotRegCon += 1
		nTotRegSub += 1
		//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
		//Ё Reimprime cabecalho se necessario...                               Ё
		//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
		If  nLi > nQtdLin
			R256Cab(.F.)
		Endif
	Next
	
	//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//Ё Proxima familia...                                                 Ё
	//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
	lPF := (BA3->BA3_TIPOUS == "1")
	TRBBA3->(DbSkip())
	//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//Ё Fim do laco...                                                     Ё
	//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
Enddo

nCredito:= RetDeCre(cOpe,cCodEmp,cCodCon,cCodSub,_cAno,_cMes,"130",mv_par04,mv_par22)
nDebito := RetDeCre(cOpe,cCodEmp,cCodCon,cCodSub,_cAno,_cMes,"128",mv_par04,mv_par22)
IF nDebito = 0
	nDebito := RetDeCre(cOpe,cCodEmp,cCodCon,cCodSub,_cAno,_cMes,"113",mv_par04,mv_par22)
endif

IF nCredito >0
	R256Tot(nColSub,nCredito,"Total de Creditos de Mensalidades Retroativas")
	nTotCobSub -=nCredito
	nTotCobEmp -=nCredito
	nTotCobCon -=nCredito
EndIf
If nDebito >0
	
	if (BA3->BA3_CODEMP $"3335") .OR. (BA3->BA3_CODEMP >="3339" .AND. BA3->BA3_CODEMP <="3384")
		R256Tot(nColSub,nDebito ,  "Total de Debito de PPRA")
	ELSE
		R256Tot(nColSub,nDebito ,  "Total de Debito de Mensalidades Retroativas")
	ENDIF
	nTotCobSub +=nDebito
	nTotCobEmp +=nDebito
	nTotCobCon +=nDebito
EndIf

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Imprime totais...                                                  Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды

if !mv_par23 = 1 //sim quebra linha mas nЦo gera totais
	R256Tot(nColSub,nTotCobSub,"Total do Sub-contrato")
endif

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Imprime rodape...                                                  Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
//Roda(0,Space(10))
//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Fecha area de trabalho...                                          Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
BA3->(DbClearFilter())
BA3->(RetIndex("BA3"))

TRBBA3->( dbClosearea() )
//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Libera impressao                                                         Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
If  aReturn[5] == 1
	Set Printer To
	Ourspool(crel)
Endif

MS_FLUSH()
//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Fim da impressao do relatorio...                                         Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
Return(aCriticas)

/*/
ээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээ
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
╠╠зддддддддддбдддддддддбдддддддбддддддддддддддддддддддддбддддддбдддддддддд©╠╠╠
╠╠ЁFuncao    Ё R256Cab Ё Autor Ё Geraldo Felix Junior   Ё Data Ё 24.11.02 Ё╠╠╠
╠╠цддддддддддедддддддддадддддддаддддддддддддддддддддддддаддддддадддддддддд╢╠╠╠
╠╠ЁDescricao Ё Cabecalho do relatorio.                                    Ё╠╠╠
╠╠юддддддддддадддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды╠╠╠
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
ъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъ
/*/

Static Function R256Cab(lPriVez)
	
	nLi := cabec(cTitulo,cCabec1,cCabec2,cNomeProg,cTamanho,IIF(aReturn[4]==1,GetMv("MV_COMP"),GetMv("MV_NORM")))
	
	nLi ++ ; @ nLi, nColCon pSay "Contrato: "+BA3->BA3_CONEMP+ "   Empresa: "+ BA3->BA3_CODEMP+ " - " + Posicione("BG9",1,xFilial("BG9")+BA3->BA3_CODINT+BA3->BA3_CODEMP,"BG9_DESCRI")
	nLi ++ ; @ nLi, nColSub pSay "Sub-Contrato: "+BA3->BA3_SUBCON+" - "+Posicione("BQC",1,xFilial("BQC")+BA3->BA3_CODINT+BA3->BA3_CODEMP+BA3->BA3_CONEMP+BA3->BA3_VERCON+BA3->BA3_SUBCON+BA3->BA3_VERSUB,"BQC_DESCRI")
	
Return

/*/
ээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээ
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
╠╠зддддддддддбдддддддддбдддддддбддддддддддддддддддддддддбддддддбдддддддддд©╠╠╠
╠╠ЁFuncao    Ё R256Tot Ё Autor Ё Geraldo Felix Junior   Ё Data Ё 24.11.02 Ё╠╠╠
╠╠цддддддддддедддддддддадддддддаддддддддддддддддддддддддаддддддадддддддддд╢╠╠╠
╠╠ЁDescricao Ё Imprime totais...                                          Ё╠╠╠
╠╠юддддддддддадддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды╠╠╠
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
ъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъ
/*/

Static Function R256Tot(nColImp,nTotCob,cTit)
	
	nLi ++
	@ nLi, nColImp pSay cTit
	@ nLi,113      pSay Transform(nTotCob,"@E 999,999,999.99")
	
Return
/*/
ээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээ
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
╠╠зддддддддддбдддддддддбдддддддбддддддддддддддддддддддддбддддддбдддддддддд©╠╠╠
╠╠ЁFuncao    Ё RetDeCreЁ Autor Ё Geraldo Felix Junior.  Ё Data Ё 26.08.05 Ё╠╠╠
╠╠цддддддддддедддддддддадддддддаддддддддддддддддддддддддаддддддадддддддддд╢╠╠╠
╠╠ЁDescricao Ё Retorna Debito e Credito consedidos a Empresa              Ё╠╠╠
╠╠юддддддддддадддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды╠╠╠
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
ъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъ
/*/

Static Function RetDeCre(cOpe,cGrup,cCodCon,cCodSub,_cAno,_cMes,cCodTip,mv_par04,mv_par22)
	nTotDebCre:= 0
	cDebCre := "SELECT Sum(BM1_VALOR) DEB_CRED FROM "+RetSqlName("BM1")+" WHERE BM1_FILIAL = '"+xFilial("BM1")+"' "
	cDebCre += "And BM1_CODINT = '"+cOpe+"' "
	cDebCre += "And BM1_CODEMP = '"+cGrup+"' "
	cDebCre += "And BM1_MATRIC = ' ' "
	cDebCre += "And BM1_TIPREG = ' ' "
	cDebCre += "And BM1_ANO = '"+_cAno+"' "
	
	IF !Empty(_cMes)
		cDebCre += "And BM1_MES = '"+_cMes+"' "
	endif
	
	cDebCre += "And BM1_CODTIP = '"+cCodTip+"' "
	
	IF !Empty(mv_par22)
		cDebCre += "And BM1_PLNUCO = '"+mv_par04+mv_par22+"' "
	ENDIF
	cDebCre += "And BM1_CONEMP = '"+cCodCon+"' "
	cDebCre += "And BM1_SUBCON = '"+cCodSub+"' "
	cDebCre += "And D_E_L_E_T_ = ' ' "
	
	memowrite("c:\cla256.txt",cDebCre)
	
	if (Select("TRBBM1") <> 0)
		dbSelectArea("TRBBM1")
		dbCloseArea()
	EndIf
	
	PlsQuery(cDebCre, "TRBBM1")
	
	TRBBM1->(DbGotop())
	While ! TRBBM1->(Eof())
		nTotDebCre += TRBBM1->DEB_CRED
		TRBBM1->(dbSkip())
	EndDo
	TRBBM1->( dbClosearea() )
Return(nTotDebCre)
/*/
ээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээ
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
╠╠здддддддддддбдддддддддддбдддддддбддддддддддддддддддддддбддддддбдддддддддд©╠╠
╠╠ЁPrograma   Ё `   Ё Autor Ё Geraldo Felix junior.Ё Data Ё 03.02.05 Ё╠╠
╠╠цдддддддддддедддддддддддадддддддаддддддддддддддддддддддаддддддадддддддддд╢╠╠
╠╠ЁDescricao  Ё Atualiza SX1                                               Ё╠╠
╠╠юдддддддддддадддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды╠╠
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
/*/

Static Function CriaSX1()
	
	Local aRegs	:=	{}
	
	aadd(aRegs,{cPerg,"19","Tipo Relatorio"     		,"","","mv_chj","N", 1,0,0,"C","","mv_par19","Analitico"  	,"","","","","Sintetico"      ,"","","","","","","","","","","","","","","","","","","",""})
	aadd(aRegs,{cPerg,"20","Lista Fam s/vlr"    		,"","","mv_chk","N", 1,0,0,"C","","mv_par20","Sim"        	,"","","","","Nao"            ,"","","","","","","","","","","","","","","","","","","",""})
	aadd(aRegs,{cPerg,"21","Lista movimetacao" 			,"","","mv_chl","N", 1,0,0,"C","","mv_par21","Sim"        	,"","","","","Nao"            ,"","","","","","","","","","","","","","","","","","","",""})
	aadd(aRegs,{cPerg,"22","Lote de cobranca"			,"","","mv_chm","C", 8,0,0,"G","","mv_par22",""         	,"","","","","Nao"            ,"","","","","","","","","","","","","","","","","","","BJ7",""})
	aadd(aRegs,{cPerg,"23","Separa por Grupo"    		,"","","mv_cho","N", 1,0,0,"C","","mv_par23","Sim"        	,"","","","","Nao"            ,"","","","","","","","","","","","","","","","","","","",""})
	aadd(aRegs,{cPerg,"24","AnoMes Final:"  	  		,"","","mv_chp","C", 6,0,0,"G","","mv_par24",""        	,"","","","",""            ,"","","","","","","","","","","","","","","","","","","",""})
	
	PlsVldPerg( aRegs )
	
Return


/*/
ээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээ
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
╠╠здддддддддддбдддддддддддбдддддддбддддддддддддддддддддддбддддддбдддддддддд©╠╠
╠╠Ёtraz titulo do financeiroЁ╠╠
╠╠цдддддддддддедддддддддддадддддддаддддддддддддддддддддддаддддддадддддддддд╢╠╠

╠╠юдддддддддддадддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды╠╠
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
/*/

Static Function RetFatura( _mv_par04, _mv_par22, cMes, cAno )
	
	Local cAlias1  	:= GetNextAlias()
	Local cResutado	:= "" //Angelo Henrique - Data:25/10/2021
	
	cDebFatura := " SELECT E1_PREFIXO,E1_NUM, E1_PARCELA,E1_TIPO, E1_NOMCLI, E1_EMISSAO, E1_VENCTO, E1_VENCREA, E1_VALOR, E1_BAIXA ,E1_STATUS, E1_MESBASE, E1_ANOBASE  "
	cDebFatura += " FROM "+RetSqlName("SE1")+ " SE1 WHERE E1_FILIAL = '"+xFilial("SE1")+"' "
	
	IF !Empty(mv_par22)
		cDebFatura += " And E1_PLNUCOB = '"+_mv_par04 + _mv_par22+"' "
	ENDIF
	
	cDebFatura += " AND ( E1_CLIENTE =  '" + BQC -> BQC_CODCLI+"' OR E1_CLIENTE = '"+BA3->BA3_CODCLI+ "') "  //OPERADORA MAIS LOTE DE COBRANгA
	
	//Jean - alterado provisoriamente a pedido de Raquel em 11/02/09
	cDebFatura += " AND E1_CODINT = '"+BA3->BA3_CODINT+"' "
	cDebFatura += " AND E1_CODEMP = '"+BA3->BA3_CODEMP+"' "
	cDebFatura += " AND E1_MATRIC = '"+BA3->BA3_MATRIC+"' "
	
	cDebFatura += " AND E1_MESBASE = '"+cMes+"' "
	cDebFatura += " AND E1_ANOBASE = '"+cAno+"' "
	cDebFatura += " And SE1.D_E_L_E_T_ = ' '  "
	
	If (Select("TRBSE1") <> 0)
		dbSelectArea("TRBSE1")
		dbCloseArea()
	EndIf
	
	//msgAlert (cDebFatura)
	
	PlsQuery(cDebFatura, "TRBSE1")
	
	dbSelectArea("TRBSE1")
	
	//	cResutado := "TМtulo: "+TRBSE1 -> E1_PREFIXO + TRBSE1->E1_NUM +" Mes/Ano:"+TRBSE1->(E1_MESBASE+"/"+E1_ANOBASE)+"- Cliente: "+ TRBSE1-> E1_NOMCLI +" Status: "+TRBSE1->E1_STATUS+" Dt Bx: "+dtoc(TRBSE1->E1_BAIXA)//+TRBSE1->E1_EMISSAO+TRBSE1-> E1_VENCTO+ TRBSE1->E1_VENCREA+TRBSE1->E1_VALOR+TRBSE1->E1_BAIXA
	// -------------------------------------------
	// 20/12/2018 - Mateus Medeiros - GLPI - 54873
	// -------------------------------------------
	// correГЦo p/ impedir que seja colocado no
	// relatСrio tМtulos cancelados
	// -------------------------------------------
	do While TRBSE1->(!eof())
		
		BEGINSQL ALIAS cAlias1
			SELECT E5_MOTBX FROM %table:SE5% SE5
			WHERE
			E5_NUMERO = %exp:TRBSE1->E1_NUM%
			AND E5_PREFIXO = %exp:TRBSE1->E1_PREFIXO%
			AND E5_TIPO = %exp:TRBSE1->E1_TIPO%
			//AND E5_MOTBX <> 'CAN'
			AND SE5.D_E_L_E_T_ = ' '
		ENDSQL
		
		if (cAlias1)->(!EOF())
			if (cAlias1)->E5_MOTBX # "CAN"
				cResutado := "TМtulo: "+TRBSE1 -> E1_PREFIXO + TRBSE1->E1_NUM +" Mes/Ano:"+TRBSE1->(E1_MESBASE+"/"+E1_ANOBASE)+"- Cliente: "+ TRBSE1-> E1_NOMCLI +" Status: "+TRBSE1->E1_STATUS+" Dt Bx: "+dtoc(TRBSE1->E1_BAIXA)//+TRBSE1->E1_EMISSAO+TRBSE1-> E1_VENCTO+ TRBSE1->E1_VENCREA+TRBSE1->E1_VALOR+TRBSE1->E1_BAIXA
			endif 
		else
			cResutado := "TМtulo: "+TRBSE1 -> E1_PREFIXO + TRBSE1->E1_NUM +" Mes/Ano:"+TRBSE1->(E1_MESBASE+"/"+E1_ANOBASE)+"- Cliente: "+ TRBSE1-> E1_NOMCLI +" Status: "+TRBSE1->E1_STATUS+" Dt Bx: "+dtoc(TRBSE1->E1_BAIXA)//+TRBSE1->E1_EMISSAO+TRBSE1-> E1_VENCTO+ TRBSE1->E1_VENCREA+TRBSE1->E1_VALOR+TRBSE1->E1_BAIXA 
		endif
		
		if select(cAlias1) > 0
			dbselectarea(cAlias1)
			dbclosearea()
		endif
		
		TRBSE1->(dbskip())
	EndDo
	
	TRBSE1->( dbClosearea() )
	
Return( cResutado )



/*/
ээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээ
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
╠╠зддддддддддбддддддддддддбдддддддбдддддддддддддддддддбддддддбдддддддддддд©╠╠
╠╠ЁPrograma  Ё PLSLOADUSR Ё Autor Ё Tulio Cesar       Ё Data Ё 15.02.2004 Ё╠╠
╠╠цддддддддддеддддддддддддадддддддадддддддддддддддддддаддддддадддддддддддд╢╠╠
╠╠ЁDescri┤└o Ё Le todos os usuarios de uma familia...                     Ё╠╠
╠╠цддддддддддедддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд╢╠╠
╠╠ЁUso       Ё Advanced Protheus                                          Ё╠╠
╠╠цддддддддддадддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд╢╠╠
╠╠Ё            ATUALIZACOES SOFRIDAS DESDE A CONSTRU─AO INICIAL           Ё╠╠
╠╠цддддддддддддбддддддддбддддддбдддддддддддддддддддддддддддддддддддддддддд╢╠╠
╠╠ЁProgramador Ё Data   Ё BOPS Ё  Motivo da Altera┤└o                     Ё╠╠
╠╠цддддддддддддеддддддддеддддддедддддддддддддддддддддддддддддддддддддддддд╢╠╠
╠╠юддддддддддддаддддддддаддддддадддддддддддддддддддддддддддддддддддддддддды╠╠
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
ъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъ
/*/
user Function UNILOADUSR(cOpeFam,cCodEmp,cMatric,cAno,cMes,cTipReg)
	LOCAL cSQL
	LOCAL cFilBA1   := xFilial("BA1")
	LOCAL cNameBA1  := RetSQLName("BA1")
	LOCAL aUsuarios := {}
	LOCAL nRecBA0   := BA0->(Recno())
	LOCAL nOrdBA0   := BA0->(IndexOrd())
	LOCAL nRecBA3   := BA3->(Recno())
	LOCAL nOrdBA3   := BA3->(IndexOrd())
	LOCAL nRecBQC   := BQC->(Recno())
	LOCAL nOrdBQC   := BQC->(IndexOrd())
	LOCAL nRecBI3   := BI3->(Recno())
	LOCAL nOrdBI3   := BI3->(IndexOrd())
	LOCAL nRecBT6   := BT6->(Recno())
	LOCAL nOrdBT6   := BT6->(IndexOrd())
	LOCAL dDatAux1  := ''
	LOCAL cCodPla
	LOCAL cDesPla
	LOCAL cForTax
	LOCAL lCobProRat:= .F.
	LOCAL lCobRet   := .F.
	LOCAL nDiaRet   := 0
	LOCAL nDiaRetOpe:= 0
	LOCAL bRest     := { || BA3->(DbSetOrder(nOrdBA3)), BA3->(DbGoTo(nRecBA3)), ;
		BI3->(DbSetOrder(nOrdBI3)), BI3->(DbGoTo(nRecBI3)),;
		BA0->(DbSetOrder(nOrdBA0)), BA0->(DbGoTo(nRecBA0)),;
		BQC->(DbSetOrder(nOrdBQC)), BQC->(DbGoTo(nRecBQC)),;
		BT6->(DbSetOrder(nOrdBT6)), BT6->(DbGoTo(nRecBT6)) }
	LOCAL bFaiCob   := { || IF(BA1->(FieldPos("BA1_FAICOB"))>0,BA1_FAICOB,"") }
	
	cTipReg := ''
	
	BA0->(DbSetOrder(1))
	BA0->(DbSeek(xFilial("BA0")+cOpeFam))
	nDiaRetOpe := IF(BA0->(FieldPos("BA0_DIARET"))>0,BA0->BA0_DIARET,0)
	
	BA3->(DbSetOrder(1))
	BA3->(DbSeek(xFilial("BA3")+cOpeFam+cCodEmp+cMatric))
	
	BI3->(DbSetOrder(1))
	BI3->(DbSeek(xFilial("BI3")+BA3->(BA3_CODINT+BA3_CODPLA+BA3_VERSAO)))
	
	If BI3->(Found())
		cCodPla := BI3->BI3_CODIGO
		cDesPla := BI3->BI3_DESCRI
		cForTax := BA3->BA3_FORCTX
	Else
		cCodPla := "???"
		cDesPla := "Produto nao encontrado no cadastro"
		cForTax := "???"
	Endif
	
	If BA3->BA3_TIPOUS == "2" ///PJ
		BT6->(DbSetOrder(1))
		BT6->(DbSeek(xFilial("BT6")+BA3->(BA3_CODINT+BA3_CODEMP+BA3_CONEMP+BA3_VERCON+BA3_SUBCON+BA3_VERSUB+BA3_CODPLA)))
		If BA3->BA3_COBRAT <> "1"
			lCobProRat := BT6->(Found()) .And. BT6->BT6_COBRAT=="1"
		Else
			lCobProRat := .T.
		Endif
		BQC->(DbSetOrder(1))
		BQC->(DbSeek(xFilial("BQC")+BA3->(BA3_CODINT+BA3_CODEMP+BA3_CONEMP+BA3_VERCON+BA3_SUBCON+BA3_VERSUB)))
		lCobRet := BQC->(Found()) .And. BQC->BQC_COBRET=="1"
		nDiaRet := BQC->BQC_DIARET
		If nDiaRet == 0
			nDiaRet := nDiaRetOpe
		Endif
		
		If lCobRet
			dDatAux1 := cAno+cMes + StrZero(BQC->BQC_DIARET,2)
		Endif
	Else
		If BA3->BA3_COBRAT <> "1"
			lCobProRat := BI3->BI3_COBRAT=="1"
		Else
			lCobProRat := .T.
			dDatAux1 := cAno+cMes+StrZero(BA3->BA3_DIARET,2)
		Endif
	Endif
	
	Eval(bRest)
	
	cSQL := "SELECT BA1_MUDFAI, BA1_DATINC, BA1_CODEMP,BA1_MATRIC,BA1_CODINT,BA1_DIGITO,BA1_CBTXAD,BA1_TIPUSU, BA1_NOMUSR, BA1_TIPREG, "
	cSQL += "BA1_DATNAS, R_E_C_N_O_ REG, BA1_SEXO, BA1_GRAUPA "
	
	If BA1->(FieldPos("BA1_FAICOB")) > 0
		cSQL += ", BA1_FAICOB "
	Endif
	
	cSQL += "FROM "+cNameBA1+" WHERE "
	cSQL += "BA1_FILIAL = '"+cFilBA1+"' AND "
	cSQL += "BA1_CODINT = '"+cOpeFam+"' AND "
	cSQL += "BA1_CODEMP = '"+cCodEmp+"' AND "
	cSQL += "BA1_MATRIC = '"+cMatric+"' AND "
	//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//Ё Tratamento por usuario...                                           Ё
	//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
	If !Empty(cTipReg)
		cSQL += "BA1_TIPREG = '"+cTipReg+"' AND "
	Endif
	
	//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//Ё Tratamento dos bloqueios...                                         Ё
	//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
	If lCobRet .or. lCobProRat  // Somente se houver regra para pro-rata ou cobranca retroativa...
		//	cSql += "( "
	Endif
	
	cSql += " ( BA1_DATBLO = ' ' OR BA1_DATBLO > '"+ DtoS(cDatFin) +"' ) "  // Sempre filtra usuarios bloqueados...
	
	//If lCobRet .or. lCobProRat  // Somente se houver regra para pro-rata ou cobranca retroativa...
	//	cSql += " OR BA1_DATBLO > '"+ cDatFin +"') "  //Geraldo Felix Junior... tratar usuarios bloqueados...
	//Endif
	
	cSQL += " AND D_E_L_E_T_ = ' ' "
	cSQL += " ORDER BY BA1_FILIAL,BA1_CODINT,BA1_CODEMP,BA1_MATRIC,BA1_TIPREG,BA1_DIGITO"
	//MSGALERT(cSql)
	PLSQuery(cSQL,"PLSBUSFAI")
	
	PLSBUSFAI->(DBEval( { | | aadd(aUsuarios, {BA1_TIPREG,;
		BA1_DATNAS,;
		BA1_NOMUSR,;
		REG,;
		BA1_SEXO,;
		BA1_GRAUPA,;
		BA1_TIPUSU,;
		cCodPla,;
		cDesPla,;
		cForTax,;
		BA1_CBTXAD,;
		BA1_DIGITO,;
		BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG+BA1_DIGITO,;
		BA1_DATINC,;
		lCobProRat,;
		If(lCobProRat,Subs(dtos(BA1_DATINC),1,6)==cAno+cMes,.F.),;
		lCobRet,;
		nDiaRet,;
		BA1_MUDFAI,;
		Eval(bFaiCob)})},;
		{|| cAno+cMes>=Subs(dtos(BA1_DATINC),1,6)} ))
	PLSBUSFAI->(DbCloseArea())
	
Return(aUsuarios)

