#Include 'RWMAKE.CH'                               
#Include 'PLSMGER.CH'
#Include 'COLORS.CH'
#Include 'TOPCONN.CH'

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABA056   ºAutor  ³ Renato Peixoto     º Data ³  19/01/12   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Rotina que realiza o rateio para AUDIMED, gerando PEG e    º±±
±±º          ³ guias no contas médicas automaticamente.                   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/  
User Function CABA056()

Private cPerg      := "CABA56"
Private cCodInt    := PLSINTPAD() 
Private cDescAudim := "Rateio Audimed gerado automaticamente"
Private cNomInt    := ""
Private cCodRDA    := ""
Private aDadosBene := {} 
Private aArray1    := {}
Private dDtEvento  := dDataBase
Private cHoraPro   := ""
Private nValorRat  := 0
Private cCodPad    := "01" 
Private cProAUD    := GETMV("MV_XPROAUD")//procedimento criado para ser utilizado no processo de rateio AUDIMED   
Private cNomProAUD := POSICIONE("BR8",1,XFILIAL("BR8")+"01"+cProAUD,"BR8_DESCRI")
Private cRDAAud	   := GetNewPar("MV_YRDAAUD","068918")//RDA a ser utilizado no rateio AUDIMED
Private nVlrAud	   := GetNewPar("MV_YVLRAUD",55000.00)//valor a ser rateado, identificado por esse parametro
Private cCodPla    := ""  
Private cCodPla1   := ""
Private cDesPla    := ""
Private cLocalBB8  := ""
Private cCodLoc    := ""
Private cDesLocBB8 := ""
Private cBB8END    := ""
Private cBB8NR_END := ""
Private cBB8COMEND := ""
Private cBB8Bairro := ""
Private cCodEsp    := ""
Private j          := 0
Private k          := 0 
Private lOk        := .F.
Private cCompet    := ""
Private cAno       := ""
Private cMes       := "" 
Private cMesGuia   := ""
Private cAnoGuia   := ""
Private cTipProd   := "Rateio Audimed"
Private aVetUsu	   := {}
Private nCont      := 0  
Private lGerouRat  := .F.
Private aVetRat    := {} 
Private cSiglaProf := ""
Private cUFProf    := ""
Private cOperProf  := ""
Private cCRMProf   := ""
Private cCodProf   := ""
Private cNomProf   := ""
Private cCodLdpRat := ""
Private cCodPegRat := ""
Private cNumGuiRat := ""
Private nTotBenRDA := 0
Private nTotRat    := 0
Private aVetRel    := {} 
Private aCritica   := {}

CriaSX1()

If !Pergunte(cPerg,.T.)
	Return
EndIf    

cAno      := MV_PAR02
cMes      := MV_PAR01
//dDtEvento := MV_PAR03
cCompet   := cMes+cAno 

cMesGuia := cMes
cAnoGuia := cAno
If cMesGuia > "01"
	cMesGuia := PadL(Val(cMes)-1,2,"0")
	cAnoGuia := cAno
Else
	cMesGuia := "12"
	cAnoGuia := AllTrim(Str(Val(cAno)-1))
EndIf


//seta a variavel publica inclui como .T. para nao ocorrer problema com o conteudo do inicializador padrao
INCLUI := .T.

DbSelectArea("PB7")
DbSetOrder(1)
If DbSeek(XFILIAL("PB7")+cMes+cAno+cRDAAud)
	If APMSGYESNO("Atenção, já existe rateio AUDIMED gerado para esta competencia. Somente serão processados beneficiários que ainda não tenham sido incluídos na PEG de rateio. Deseja continuar?","Já houve rateio nesta competência.")
		Processa({||GERAAUDIMED() },"Processando rateio AUDIMED...")
	Else
		Return
	EndIf
Else
	Processa({||GERAAUDIMED() },"Processando rateio AUDIMED...")	
EndIf

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³AdicioAudimed ºAutor  ³ Renato Peixoto º Data ³  18/09/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Geracao dos adicionais ao prestador no parametro.           º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Microsiga.                                                 º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function GERAAUDIMED()

Local z := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

Local aRet := {}
Local cSQL		:= ""
Local nProc		:= 0
Local nCont		:= 0
Local nTotReg	:= 0
Local nQtdCri	:= 0
Local nTotArr	:= 0
Local aProcAud	:= {}
Local aPlaQtd	:= {}
Local aErr		:= {}
Local lPerAud	:= .F.
Local cCodAAG   := AllTrim(GETMV("MV_XCODAAG"))

Private z       := 0
Private cCodPla	:= ""
Private cVerPla	:= ""
Private nVlrUni	:= 0
Private nVlrDif := 0//09/08/12
Private nTotQry	:= 0
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Definicao de indices para busca...                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
BA1->(DbSetOrder(2))
BA3->(DbSetOrder(1))
BD6->(DbSetOrder(1))
BQR->(DbSetOrder(1))
BI3->(DbSetOrder(1))
BR8->(DbSetOrder(1))
BID->(DbSetOrder(1))
BB8->(DbSetOrder(1))
BAU->(DbSetOrder(1))
ZZ8->(DbSetOrder(1))
//BBB->(DbSetOrder(1))
//BFM->(DbSetOrder(1))

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Montar array com procedimentos que permitem pagto Audimed...        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cSQL := " SELECT BR8_CODPSA FROM "+RetSQLName("BR8")
cSQL += " WHERE BR8_YPRAUD = '1' "
cSQL += " AND D_E_L_E_T_ = ' ' "
cSQL += " ORDER BY BR8_CODPSA "
PLSQuery(cSQL,"TRB")	

While !TRB->(Eof())
	aadd(aProcAud,Alltrim(TRB->BR8_CODPSA))
	TRB->(DbSkip())
Enddo             

TRB->(DbCloseArea())


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Consulta principal para validacao das internacoes Audimed...        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//For nCont := 1 to 2
	
//	If nCont == 1
//		cSQL := " SELECT COUNT(R_E_C_N_O_) AS TOTAL FROM "+RetSQLName("BE4")"
//	Else
	cSQL := " SELECT R_E_C_N_O_ AS REGISTRO FROM "+RetSQLName("BE4")
//	Endif		

	cSQL += " WHERE BE4_YLTAUD = ' ' "
	//cSQL += " AND BE4_ANOPAG = '"+cAnoGuia+"' " comentado por Renato Peixoto em 05/04/12 para utilizar o campo BE4_NUMLOT em vez do mespag e anopag, para captar mais guias de internacao
	//cSQL += " AND BE4_MESPAG = '"+cMesGuia+"' "comentado por Renato Peixoto em 05/04/12 para utilizar o campo BE4_NUMLOT em vez do mespag e anopag, para captar mais guias de internacao
	cSQL += " AND BE4_NUMLOT LIKE '"+cAnoGuia+cMesGuia+"%' " //Acrescentado por Renato Peixoto em 05/04/2012
	cSQL += " AND BE4_FASE = '4'"
	cSQL += " AND BE4_SITUAC = '1'"
	cSQL += " AND D_E_L_E_T_ = ' ' "
	

	PLSQuery(cSQL,"TRB")	
	COUNT TO nTotQry
	
//Next	
TRB->(DbGoTop())
//PLSQuery(cSQL,"TRB")	

ProcRegua( nTotQry )
//inicializa o vetor de criticas com os nomes das colunas
aAdd(aCritica,{"Local de Digitação","PEG","Número da guia","Motivo Rejeição" })

While ! TRB->(Eof())	

	nProc++
	IncProc("Lendo registro " + AllTrim(Str(nProc)) )

	BE4->(DbGoto(TRB->REGISTRO))
	
	dDtEvento := BE4->BE4_DATPRO//pega a data da internação para que o regime seja de internacao
	cHoraPro  := BE4->BE4_HORPRO//pega a mesma hora da internacao para que o regime seja de internacao
	
	BA1->(MsSeek(xFilial("BA1")+BE4->(BE4_OPEUSR+BE4_CODEMP+BE4_MATRIC+BE4_TIPREG)))
	BA3->(MsSeek(xFilial("BA3")+BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_CONEMP+BA1_VERCON+BA1_SUBCON+BA1_VERSUB)))

	If Empty(BA1->BA1_CODPLA)
		cCodPla := BA3->BA3_CODPLA
		cVerPla := BA3->BA3_VERSAO
	Else
		cCodPla := BA1->BA1_CODPLA
		cVerPla := BA1->BA1_VERSAO	
	Endif

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Validacoes para regra de pagto audimed...                           ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ	
	lPerAud := .F.
	If Posicione("BI3",1,xFilial("BI3")+PLSINTPAD()+cCodPla+cVerPla,"BI3_YPRAUD") == "1" //Produto
		If Posicione("BQR",1,xFilial("BQR")+BE4->(BE4_GRPINT+BE4_TIPINT),"BQR_YPRAUD") == "1" //Tipo de internacao
			BD6->(MsSeek(xFilial("BD6")+PLSINTPAD()+BE4->(BE4_CODLDP+BE4_CODPEG+BE4_NUMERO+BE4_ORIMOV)))
			
			While BE4->(BE4_CODLDP+BE4_CODPEG+BE4_NUMERO) == BD6->(BD6_CODLDP+BD6_CODPEG+BD6_NUMERO) .And. !BD6->(Eof())
			
				If Ascan(aProcAud,Alltrim(BD6->BD6_CODPRO)) > 0
					lPerAud := .T.
					Exit
				Endif
				
				BD6->(DbSkip())
				
			Enddo
			
			If !lPerAud //If acrescentado por Renato Peixoto em 05/04/12
				aAdd (aCritica, {BE4->BE4_CODLDP,BE4->BE4_CODPEG,BE4->BE4_NUMERO,"Nao entrou pq nao existe nenhum procedimento na BD6 que permite Audimed"} )
			EndIf
			
			If lPerAud        
			
				lPerAud := .F.			
				BB8->(DbSetOrder(1))
				If BB8->(MsSeek(xFilial("BB8")+BE4->BE4_CODRDA+PLSINTPAD()+BE4->(BE4_CODLOC+BE4_LOCAL)))
					If Posicione("BID",1,xFilial("BID")+BB8->BB8_CODMUN,"BID_YPRAUD") == "1"
						lPerAud := .T.				
				    Else
				    	aAdd (aCritica, {BE4->BE4_CODLDP,BE4->BE4_CODPEG,BE4->BE4_NUMERO,"Nao entrou pq o municipio do RDA não permite Audimed"} )
				    Endif
				Else
					aAdd (aCritica, {BE4->BE4_CODLDP,BE4->BE4_CODPEG,BE4->BE4_NUMERO,"Nao entrou pq nao foi encontrado local da rede de atendimento (BB8)"} )	
				Endif
			
			Endif
		Else
			aAdd (aCritica, {BE4->BE4_CODLDP,BE4->BE4_CODPEG,BE4->BE4_NUMERO,"Nao entrou pq Tipo de internação nao permite Audimed"} ) //alterado por Renato Peixoto em 05/04/12
		Endif
		
		//Inicio Alteracao Renato Peixoto em 06/06/12
		//Verifica se o usuário em questao faz parte do projeto AAG. Segundo o Dr. Sandro, se fizer parte, nao eh para entrar no rateio AUDIMED.
		If lPerAud
			DbSelectArea("BF4")
			DbSetOrder(1)
			If DbSeek(XFILIAL("BF4")+BE4->BE4_CODOPE+BE4->BE4_CODEMP+BE4->BE4_MATRIC+BE4->BE4_TIPREG+cCodAAG)
				If Empty(BF4->BF4_DATBLO)
					lPerAud := .F.
					aAdd (aCritica, {BE4->BE4_CODLDP,BE4->BE4_CODPEG,BE4->BE4_NUMERO,"Nao entrou pq o beneficiario "+BE4->BE4_MATRIC+" - "+AllTrim(BE4->BE4_NOMUSR)+" faz parte do projeto AAG"} )
				EndIf
			EndIf
		EndIf
		//Fim alteraçao Renato Peixoto em 06/06/12
	Else
		aAdd (aCritica, {BE4->BE4_CODLDP,BE4->BE4_CODPEG,BE4->BE4_NUMERO,"Nao entrou pq produto nao permite Audimed"} ) //alterado por Reanto Peixoto em 05/04/12
	Endif
	
	//Leonardo Portella - 06/09/12 - Inicio - Verificar se o beneficario possui situacao adversa pois nestes casos o sistema gera critica na inclusao pelo CM, mas pela
	//rotina nao gera BD7 - Chamado ID 3459
	
	//Situacoes adversas          
	BHH->(DbSetOrder(1))//BHH_FILIAL + BHH_CODINT + BHH_CODEMP + BHH_MATRIC + BHH_TIPREG + BHH_CODSAD
	
	If lPerAud .and. BHH->( MsSeek(xFilial('BHH') + BE4->( BE4_CODOPE + BE4_CODEMP + BE4_MATRIC + BE4_TIPREG )) )
		aAdd (aCritica, {BE4->BE4_CODLDP,BE4->BE4_CODPEG,BE4->BE4_NUMERO,"Nao entrou pq beneficiario possui situacao adversa"} )
		lPerAud := .F.
	EndIf
	
	//Leonardo Portella - 06/09/12 - Fim
	
	If lPerAud
		
		cCRMProf   := BE4->BE4_REGEXE
		cOperProf  := BE4->BE4_OPEEXE
		cNomProf   := BE4->BE4_NOMEXE
		cCodProf   := BE4->BE4_CDPFRE 
		cUFProf    := BE4->BE4_ESTEXE
		cSiglaProf := BE4->BE4_SIGLA
	
		cNomInt    := POSICIONE("BA0",1,XFILIAL("BA0")+cCodInt,"BA0_NOMINT")
		cCodRDA    := cRDAAud//BE4->BE4_CODRDA  // ou cRDAAud?
	
		DbSelectArea("BAU")
		DbSetOrder(1)
		MSSeek(XFILIAL("BAU")+cCodRDA)
		cLocalBB8  := POSICIONE("BB8",1,XFILIAL("BB8")+cCodRDA+cCodInt,"BB8_CODLOC")
		cCodLoc    := POSICIONE("BB8",1,XFILIAL("BB8")+cCodRDA+cCodInt,"BB8_LOCAL")    
		cDesLocBB8 := POSICIONE("BB8",1,XFILIAL("BB8")+cCodRDA+cCodInt,"BB8_DESLOC")
		cBB8END    := POSICIONE("BB8",3,XFILIAL("BB8")+cCodRDA+cCodInt,"BB8_END")
		cBB8NR_END := POSICIONE("BB8",3,XFILIAL("BB8")+cCodRDA+cCodInt,"BB8_NR_END")
		cBB8COMEND := POSICIONE("BB8",3,XFILIAL("BB8")+cCodRDA+cCodInt,"BB8_COMEND")
		cBB8Bairro := POSICIONE("BB8",3,XFILIAL("BB8")+cCodRDA+cCodInt,"BB8_BAIRRO")
		cCodEsp    := POSICIONE("BAX",1,XFILIAL("BAX")+cCodRDA+cCodInt+cLocalBB8,"BAX_CODESP")
 

		If Empty(cLocalBB8)
			APMSGSTOP("Atenção, não existe código de localidade cadastrado para o RDA "+cCodRDA+", operadora "+cCodInt+" e local "+cCodLoc+". Favor cadastrar antes de realizar este processo. ","Processo não pode ser realizado.")
			Return
		EndIf

		If Empty(cCodEsp)
			APMSGSTOP("Atenção, não existe especialidade cadastrada para o RDA "+cCodRDA+", operadora "+cCodInt+" e local "+cCodLoc+". Favor cadastrar antes de realizar este processo. ","Processo não pode ser realizado.")
			Return
		EndIf

		IncProc("Processando inclusão de contas médicas para rateio "+cTipProd+"...")

		cNomInt    := POSICIONE("BA0",1,XFILIAL("BA0")+cCodInt,"BA0_NOMINT")

		 /*Posicoes no array:   OBS: Atualizar posicoes
		1 - Filial 
	    2 - Codigo RDA
	    3 - Operadora RDA
	    4 - BA1_CODEMP
	    5 - BA1_MATRIC
	    6 - BF4_CODPRO  //Codigo do projeto AED
	    7 - cCodPla (codigo do plano)
	    8 - cDesPla (descrição do plano)
	    9 - BA1_CODINT
	    10 - BA1_NOMUSR
	    11 - cCodRDA
	    12 - nValorRat
	    13 - cProAUD (codigo do procedimento para inclusao guias rateio AED
	    14 - BA1_TIPREG
	    15 - BA1_DIGITO
	    16 - BA1_TELEFO
	    17 - BA1_SEXO
	    18 - BA1_MATANT
	    19 - BA1_MATVID
	    20 - BA1_CONEMP
	    21 - BA1_VERCON
	    22 - BA1_SUBCON
	    23 - BA1_VERSUB */	
		//Preencho o vetor com as informaçoes que serao utilizadas na inclusao das guias de rateio AED
		aAdd ( aArray1  , { {"FILIAL",XFILIAL("BAU")},;
			{"CODRDA",cCodRDA},;
			{"OPERDA",cCodInt},;
			{"CODINT",cCodInt},;  //No BD5 é CODOPE
			{"NOMINT",cNomInt},;
			{"DATA",dDtEvento},; 
			{"DATPRO",dDtEvento},; 
			{"HORPRO",strzero(val(cHoraPro)+1,4)/*STRTRAN(substr(time(),1,5),":","")*/},;
			{"NOMUSR",BE4->BE4_NOMUSR},;
			{"TELEFO",BA1->BA1_TELEFO},;
			{"CODESP",cCodEsp},;
			{"CODLOC",cLocalBB8},;
			{"LOCAL",cCodLoc},;
			{"SIGLA",BAU->BAU_SIGLCR},;
			{"ESTCR",BAU->BAU_ESTCR},;
			{"REGSOL",BAU->BAU_CONREG},;
			{"CDPFSO",BAU->BAU_CODBB0},;
			{"TPCON","1"},; 
			{"SEXO",BA1->BA1_SEXO},;
			{"ANOPAG",cAno},;
			{"MESPAG",cMes},;
			{"MATANT",BA1->BA1_MATANT},;    
			{"MATVID",BA1->BA1_MATVID},;
			{"OPEUSR",cCodInt},;  //codint
			{"TIPRDA",BAU->BAU_TIPPE},;
			{"MATRIC",BA1->BA1_MATRIC},;  
			{"TIPREG",BA1->BA1_TIPREG},;	   
			{"CPFRDA",BAU->BAU_CPFCGC},; 
			{"DIGITO",BA1->BA1_DIGITO},;
			{"NOMRDA",BAU->BAU_NOME},;
			{"NOMSOL",BAU->BAU_NOME},;
			{"CODEMP",BA1->BA1_CODEMP},;  
			{"CONEMP",BA1->BA1_CONEMP},;
			{"VERCON",BA1->BA1_VERCON},;
			{"SUBCON",BA1->BA1_SUBCON},;	
			{"VERSUB",BA1->BA1_VERSUB},;
			{"DATDIG",DDATABASE},;
			{"CODPAD","01"},;
			{"CODPRO",cProAUD},;
			{"TIPPRE",BAU->BAU_TIPPRE},;
			{"DTDIG1",DDATABASE},;
			{"YVLTAP", nVlrUni},;
			{"VLRAPR", nVlrUni},;
			{"QTDAPR", 1},;
			{"QTDPRO", 1},;
			{"BLOCPA", "1"},;  //bloqueia a cobranca da co-participacao
			{"DESBPF", "ROTINA AUTOMATICA RATEIO AUDIMED"/*"INFORMAR A DESCRICAO DO MOTIVO"*/},; 
			{"TIPSAI", "5"},;
			{"ORIMOV", "1"},; 
			{"DESLOC", cDesLocBB8},;
			{"ENDLOC", AllTrim(cBB8END)+"+"+AllTrim(cBB8NR_END)+"-"+AllTrim(cBB8COMEND)+"-"+AllTrim(cBB8BAIRRO)},; 
			{"MOTBPF", "999"},; //    // INFORME O CODIGO DO BLOQUEIO DA COPARTICIPACAO DE ACORDO COM A TABELA DE BLOQUEIO  Na BD5 é MOTBPG
			{"TIPATE", "06"},; //Atendimento domiciliar, pois segundo o Dr. Jose Paulo é o que melhor se enquadra ao ADU.
			{"CODPLA", cCodPla},;  //acrescentado em 05/10/11 por Renato Peixoto para atender especificacoes rateio AED.
			{"REGEXE", cCRMProf},; //ver qual vai ser o CRM
			{"OPEEXE", cOperProf},;//ver qual vai ser a operadora prof. saude
			{"NOMEXE", cNomProf},; //ver qual vai ser o nome do prof;
			{"CDPFRE", cCodProf},; //ver qual vai ser o cod prof
			{"ESTEXE", cUFProf},;  //falta ver
			{"SIGEXE", cSiglaProf},;//falta ver   BE4->BE4_SIGLA
			{"REGPRE", cCRMProf},; //falta ver
			{"NOMPRE", cNomProf},;  //falta ver
			{"INDCLI", cDescAudim },;//acrescentado em 27/12/11 por Renato Peixoto para colocar uma descrição do pagamento audimed que consta na ZZ8 de acordo com o plano do beneficiario
			{"CHAVBE4", BE4->BE4_CODOPE+BE4->BE4_CODLDP+BE4->BE4_CODPEG+Be4->Be4_NUMERO } }) 
	    	/* bd5_regexe -> CR executante
			opeexe   - operadora executante
			nomexe   - nome do executante
			cdpfre   - cod. prof. saude executante
			estexe   - UF executante
			sigexe   - sigla do executante (CRM)
			regpre   - CR executante
			nompre   - nome executante*/
	
			//GERAAUDM()
			nTotReg++
	Endif
	
	TRB->(DbSkip())
Enddo

TRB->(DbCloseArea())

//Se houver guias rejeitadas para rateio AUDIMED, pergunta se deseja emitir um relatorio em excel com as guias e o motivo de rejeição...
If Len(aCritica) > 0
	If APMSGYESNO("Existem guias que foram rejeitadas na geração do rateio AUDIMED. Deseja emitir um relatório em Excel com essas guias:","Guias rejeitadas para rateio AUDIMED.")
		DlgToExcel({{"ARRAY","Problemas com guias selecionadas para rateio AUDIMED.","",aCritica}})
	EndIf
EndIf	

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Calcular o valor individual...                                      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ	
If nTotReg > 0
	
	//09/08/12
	nVlrDif := ( nVlrAud % nTotReg )
	nVlrUni := ( nVlrAud - nVlrDif) /nTotReg
	//nVlrUni := nVlrAud/nTotReg
	
Else	
	APMSGINFO("Atenção! Nenhuma guia foi encontrada! Valor total de pagamento será zerado!","Não foi realizado o processo de rateio AUDIMED. Verifique os parâmetros!")
	nVlrAud := 0
	nVlrUni := 0
	//nQtdCri++
	Return
Endif
              
//Atualiza valores no Array gerado antes
For z := 1 to Len(aArray1)
	                                                          
	//09/08/12
	aArray1[z][42][2] := If(z == 1,nVlrUni + nVlrDif,nVlrUni)
	aArray1[z][43][2] := If(z == 1,nVlrUni + nVlrDif,nVlrUni)
	//aArray1[z][42][2] := nVlrUni
	//aArray1[z][43][2] := nVlrUni	
	
Next z



//chama a rotina que vai gerar o rateio
U_GRVGUIAUD()

//Trocar esse teste...
If Len(aVetRel) > 0
	MsgAlert("Pagamento Audimed gerado. Verifique os resultados!")
	If APMSGYESNO("Deseja imprimir o relatório do que foi gerado no rateio AUDIMED?")
		RELRATAUDM()
	EndIf
Endif


Return 


 
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³GRVGUIAUD   ³ Autor ³ Renato Peixoto       ³ Data ³ 27.12.11 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Grava dados de consulta em um PEG e GUIA para rateio AUDIMED³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function GRVGUIAUD(/*cNumAte,dDataBase*/)  //alterar aqui nessa função, fazendo um for e 1 ate 2 para gerar duas vezes caso avetusu[j][3] seja .T. alterando a data da segunda guia
Local I__f := 0
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declara variaveis da rotina...                                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
LOCAL nH := PLSAbreSem("GRVGUIAUD.SMF")
LOCAL cNumGuia
LOCAL nFor
LOCAL nTmp
LOCAL nAux
LOCAL aFiles
LOCAL cAliasAux
LOCAL nPos
LOCAL cAliasPri
LOCAL cCpoFase
LOCAL aColsAux
LOCAL cCampos
LOCAL aStruARQ    := {}

LOCAL aRetCal     := PLSXVLDCAL(MV_PAR03/*dDtEvento*/,cCodInt,.F.)    // Valida o calendario de pagamento da operadora
LOCAL cAnoBase    := aRetCal[4]
LOCAL cMesBase    := aRetCal[5]
LOCAL nHESP
LOCAL nStackSX8   := GetSx8Len()
Local aHeaderBE2  := {}

Local nQ          := 0

PRIVATE cOpeRDA   := cCodInt
//PRIVATE cCodRDA   := cCodRda já é declarada como private na função que chama esta
PRIVATE cNomRDA   := POSICIONE("BAU",1,XFILIAL("BAU")+cRDAAUD,"BAU_NOME")//aArray1[z][30][2]//BAU->BAU_NOME
//PRIVATE cTipRDA   := BAU->BAU_TIPPE
PRIVATE cFunGRV
PRIVATE cTipGRV
PRIVATE cTipoGuia
PRIVATE cGuiRel
PRIVATE cNewPEG                          //codemp          matricula            TIPREG               DIGITO
//PRIVATE aDadUSR   := PLSDADUSR(cCodInt+aArray1[z][32][2]+aArray1[z][26][2]+aArray1[z][27][2]+aArray1[z][29][2],"1",.T.,dDataBase/*dDatLan*/)  //busca dados do usuario a ser lancado
Private aArea     := GetArea() //Acrescentado por Renato Peixoto em 04/01/11 para tentar solucionar o erro "Tc_eof  - No Connection on RECLOCKED(APLIB060.PRW)"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica se existe o PEG eletronico do mes para o credenciado...         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
BCI->(DbSetOrder(4))

If !(aRetCal[1])
	APMSGSTOP("Atenção, não existe calendario de pagamento para a data em questão ou os parâmetros de pagamento desse mês não foram configurados. Favor Verificar antes de realizar este processo.","Processo não pode ser realizado.")
	Return
EndIf

nHESP := PLSAbreSem("PLSPEG1.SMF")
If ! BCI->(MsSeek(xFilial("BCI")+cOpeRDA+cRDAAUD+cAnoBase+cMesBase+"211")) //2 - incluído eletronicamente; 1-em digitacao; 1- ativo
	
	cNewPEG := PLSA175Cod(cOpeRDA,"0001")//GetNewPar("MV_PLSPEGE","0000"))
	
	BCI->(RecLock("BCI",.T.))
	BCI->BCI_FILIAL := xFilial("BCI")
	BCI->BCI_CODOPE := cOpeRDA
	BCI->BCI_PROTOC := CriaVar("BCI_PROTOC")
	BCI->BCI_CODLDP := '0017'//"0001" //GetNewPar("MV_PLSPEGE","0001")
	BCI->BCI_CODPEG := cNewPEG
	BCI->BCI_OPERDA := cOpeRDA
	BCI->BCI_CODRDA := cRDAAUD//cOpeRDA  
	BCI->BCI_NOMRDA := cNomRDA
	BCI->BCI_TIPSER := GetNewPar("MV_PLSTPSP","01")
	BCI->BCI_TIPGUI := GetNewPar("MV_PLSTPGS","02")//GetNewPar("MV_PLSTPGC","01")
	BCI->BCI_TIPPRE := BAU->BAU_TIPPRE
	
	BCL->(DbSetOrder(1))
	BCL->(MsSeek(xFilial("BCL")+cOpeRDA+BCI->BCI_TIPGUI))
	BCI->BCI_QTDDIG := Len(aArray1)
	BCI->BCI_VLRGUI := nVlrAUD //0 //REVER
	BCI->BCI_DATREC := dDataBase//Base
	//BCI->BCI_DTPRPG := ctod("")
	BCI->BCI_DTDIGI := dDtEvento
	BCI->BCI_QTDDIG := 1
	//BCI->BCI_VALDIG := 0 //REVER
	BCI->BCI_CODCOR := BCL->BCL_CODCOR
	BCI->BCI_FASE   := "1"
	BCI->BCI_SITUAC := "1"
	BCI->BCI_MES    := cMesBase
	BCI->BCI_ANO    := cAnoBase
	BCI->BCI_TIPO   := "2" 
	BCI->BCI_STATUS := "1"
	BCI->(MsUnLock())
	
	While GetSx8Len() > nStackSX8
		BCI->( ConfirmSX8() )
	EndDo
	
Else
	BCL->(DbSetOrder(1))
	BCL->(MsSeek(xFilial("BCL")+cOpeRDA+BCI->BCI_TIPGUI))
Endif
PLSFechaSem(nHESP,"PLSPEG1.SMF")

cTipoGuia := BCL->(BCL_TIPGUI)
cGuiRel   := BCL->BCL_GUIREL
cFunGRV   := BCL->BCL_FUNGRV
cTipGRV   := BCL->BCL_TIPGRV
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Inicio do processo de gravacao das guias...                              ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
aFiles := PLSA500Fil(BCI->BCI_CODOPE,BCI->BCI_TIPGUI)

ProcRegua( nTotQry )

For nQ := 1 to Len(aArray1)  //Loop para gerar uma guia para cada ususario contido no array
	
	IncProc("Processando registro " + AllTrim(Str(nQ)) + " de "+ AllTrim(Str(len(aArray1))) )
	//PB7_FILIAL+PB7_COMPET+PB7_RDA+PB7_CODINT+PB7_CODEMP+PB7_MATRIC+PB7_TIPREG+PB7_DIGITO
	/* Comentado em 10/05/12 para permitir gerar mais de uma guia para um mesmo usuario, pois isso estava dando erro no valor total do rateio...Renato Peixoto.
	DbSelectArea("PB7")
	DbSetOrder(1)	                                                                                       
	If DbSeek(XFILIAL("PB7")+cCompet+cCodRDA+cCodInt+aArray1[nQ][32][2]+aArray1[nQ][26][2]+aArray1[nQ][27][2]+aArray1[nQ][29][2])
	
		Loop
	
	EndIf
	*/
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Monta os vetores e variáveis...                                          ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	//Begin Transaction
	cAliasPri := ""
	For nFor := 1 To Len(aFiles)
		cAliasAux := aFiles[nFor,1]
		
		If Empty(cAliasPri)
			cAliasPri := aFiles[nFor,1]
			cNumGuia  := PLSA500NUM(cAliasPri,cOpeRDA,BCI->BCI_CODLDP,BCI->BCI_CODPEG)
		Endif
		If aFiles[nFor,3] == "2"
			aStruARQ := (cAliasAux)->(DbStruct())
			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Monta RegToMemory...                                                     ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			//RegToMemory(cAliasAux,.T.,.F.)
				
			Copy (cAliasAux) To Memory Blank
			
			//Dados fixos para todos os arquivos a serem procesados do contas medicas
			&("M->"+cAliasAux+"_CODOPE") := BCI->BCI_CODOPE
			&("M->"+cAliasAux+"_CODLDP") := BCI->BCI_CODLDP
			&("M->"+cAliasAux+"_CODPEG") := BCI->BCI_CODPEG
			&("M->"+cAliasAux+"_NUMERO") := cNumGuia
			&("M->"+cAliasAux+"_TIPGUI") := BCI->BCI_TIPGUI
			
			//Dados variados para cada arquivo que esta sendo processado
			For nAux := 1 To Len(aArray1[nQ])   //Processa a quantida de campos contidos no array do usuario em questao
				nPos := ascan(aStruARQ, {|x| alltrim(x[1]) = cAliasAux+"_"+aArray1[nQ,nAux,1]}) //ascan(aStruARQ,aArray1[nQ,nAux,1])   //Verifica se o campo a ser gravado nesta tabela corresponde ao do array
				If nPos > 0
					&("M->"+cAliasAux+"_"+aArray1[nQ,nAux,1]) := aArray1[nQ,nAux,2]
				Endif
			Next nAux
			
			PLUPTENC(cAliasAux,K_Incluir)
		Else
			CONOUT("Gravacao de itens nao implementada") 
		Endif
	Next nFor
	
//Next

	//Crio o vetor aHeaderBE2 com os dados do SX3 para os campos BE2_CODPAD, BE2_CODPRO e BE2_STATUS
	DbSelectArea("SX3")
	SX3->(DbSetOrder(1))
	SX3->(dbSeek("BE2"))
	_Recno := Recno()
	Do While !Eof() .And. (X3_ARQUIVO == "BE2")
		If X3_CAMPO = "BE2_CODPAD" .or. X3_CAMPO = "BE2_CODPRO" .or. X3_CAMPO = "BE2_STATUS"
			Aadd(aHeaderBE2,{Trim(X3_TITULO), X3_CAMPO, X3_PICTURE, X3_TAMANHO, X3_DECIMAL,".T.", X3_USADO, X3_TIPO, X3_ARQUIVO, X3_CONTEXT})
		Endif
		dbSkip()
	Enddo
	DbGoto(_Recno)

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Executa funcao de gravacao dos dados...                                  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If !Empty(cFunGRV)
	
		aPar   := {K_Incluir,cOpeRDA,BCI->BCI_CODLDP,BCI->BCI_CODPEG,cNumGuia,.T.,cAliasPri,"01","","1",{{cCodPad,cProAUD,"1"}}, aHeaderBE2 }//{K_Incluir,cOpeRDA,BCI->BCI_CODLDP,BCI->BCI_CODPEG,cNumGuia,.T.}
		cMacro := (AllTrim(cFunGRV)+"(aPar)")
		&(cMacro)
	Endif

	//Gravo os campos BD6_YVLTAP com o valor correspondente ao NUPRE e o campo QTDAPR
	DbSelectArea("BD6")
	RecLock("BD6",.F.)
	BD6->BD6_YVLTAP := If(nQ == 1,nVlrUni + nVlrDif,nVlrUni)//nVlrUni
	BD6->BD6_VLRAPR := If(nQ == 1,nVlrUni + nVlrDif,nVlrUni)//nVlrUni
	//BD6->BD6_QTDAPR := 1   //DESCONTINUADO P12
	BD6->BD6_QTDPRO := 1  
	BD6->BD6_BLOCPA := "1"
	BD6->BD6_DESBPF := "PAGAMENTO "+cTipProd //"RATEIO AUDIMED"
	BD6->BD6_MOTBPF := "501" 
	//Forço a gravação do plano correto do usuário, caso o sistema esteja gravando errado na BD6 e BD7 o campo CODPLA
	//Alterado em 17/03/2011 por Renato Peixoto
	If BD6->Bd6_CODPLA <> cCodPla
		BD6->BD6_CODPLA := cCodPla
	EndIf
	//Fim Alteração Renato Peixoto 
	cCodPegRat := BD6->BD6_CODPEG
	cCodLdpRat := BD6->BD6_CODLDP
	cNumGuiRat := BD6->BD6_NUMERO
	BD6->(MsUnlock())
	//Forço a gravação do plano correto do usuário, caso o sistema esteja gravando errado na BD6 e BD7 o campo CODPLA
	//Alterado em 17/03/2011 por Renato Peixoto
	DbSelectArea("BD7")
	DbSetOrder(2)
	If DbSeek(XFILIAL("BD7")+cCodInt+cCodLdpRat+cCodPegRat+cNumGuiRat)
		If BD7->BD7_CODPLA <> cCodPla
			RecLock("BD7",.F.)
			BD7->BD7_CODPLA := cCodPla
			BD7->(MsUnlock())
		EndIf
	EndIf
	//Fim alteração Renato Peixoto. 
 
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Muda a fase da guia...                                                   ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	cCpoFase := (cAliasPri+"->"+cAliasPri+"_FASE")
	
	If !Empty(BCL->BCL_FUNMFS)
	
		 //Leonardo Portella - 14/10/13 - Inicio - Virada P11: alteracao nos parametros. Incluido vetor de glosas
     
	     aPar   := {cAliasPri,"1",cOpeRDA,cTipoGuia,&cCpoFase,BCI->BCI_CODLDP,BCI->BCI_CODPEG,BCL->BCL_GUIREL,.T.,dDataBase,.F.,,,,,cAliasPri,{}}
	     //aPar   := {cAliasPri,"1",cOpeRDA,cTipoGuia,&cCpoFase,BCI->BCI_CODLDP,BCI->BCI_CODPEG,BCL->BCL_GUIREL,.T.,dDataBase,.F.,,,,,cAliasPri}
	     
	     //Leonardo Portella - 14/10/13 - Fim
	    
	     cMacro := (AllTrim(BCL->BCL_FUNMFS)+"(aPar)")
	     aRetAux := &(cMacro)
	     lGerouRat := .T. //se ao menos uma guia foi gerada por essa rotina, marco esse flag como .T.
	Endif 

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Finaliza transacao fisica...                                             ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	PLSFechaSem(nH,"GRVGUIAUD.SMF")
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Fim da Rotina...                                                         ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	//End Transaction     
	
	//registra na BE4 que a guia de internaão foi contada para o rateio AUDIMED
    DbSelectArea("BE4")
    DbSetOrder(1)
    If DbSeek(XFILIAL("BE4")+aArray1[nQ][64][2])
		RecLock("BE4",.F.)
		BE4->BE4_YLTAUD := cMes+cAno
		BE4->(MsUnLock())
	EndIf
	
	//Gravo na tabela de controle do rateio AED
	//DbSelectArea("PB7")
	//DbSetOrder(1)
	//PB7_FILIAL+PB7_COMPET+PB7_RDA+PB7_CODINT+PB7_CODEMP+PB7_MATRIC+PB7_TIPREG+PB7_DIGITO                                                                            
	
	//If !(DbSeek(XFILIAL("PB7")+cCompet+cCodRDA+cCodInt+aArray1[nQ][32][2]+aArray1[nQ][26][2]+aArray1[nQ][27][2]+aArray1[nQ][29][2]))
	//Retirei o "IF" porque pode acontecer de ter um mesmo usuário rateado para um mesmo mes de rateio... Renato Peixoto em 10/05/12
		RecLock("PB7",.T.)
		PB7->PB7_FILIAL := XFILIAL("PB7")
		PB7->PB7_COMPET := cCompet
		PB7->PB7_RDA    := cCodRDA
	    PB7->PB7_CODINT := cCodInt
	    PB7->PB7_CODEMP := aArray1[nQ][32][2]
	    PB7->PB7_MATRIC := aArray1[nQ][26][2]
	    PB7->PB7_TIPREG := aArray1[nQ][27][2]
	    PB7->PB7_DIGITO := aArray1[nQ][29][2]	
	    PB7->PB7_NOMUSR := aArray1[nQ][9][2]
	    PB7->PB7_VLRAT  := If(nQ == 1,nVlrUni + nVlrDif,nVlrUni)//nVlrUni
	    PB7->PB7_USUSIS := USRFULLNAME(__cUserId)
	    PB7->PB7_CODPRO := cProAUD
	    PB7->PB7_NOMPRO := cNomProAUD
	    PB7->(MsUnLock())
	//EndIf
	//Fim alteração Renato Peixoto
    
    aAdd ( aVetRel, { XFILIAL("PB7"), cCompet, cCodRDA, cCodInt, aArray1[nQ][32][2], aArray1[nQ][26][2], aArray1[nQ][27][2], aArray1[nQ][29][2], aArray1[nQ][9][2], If(nQ == 1,nVlrUni + nVlrDif,nVlrUni)/*nVlrUni*/, USRFULLNAME(__cUserId), cProAud, cNomProAUD } )
    
        	
Next nQ

RestArea(aArea)

Return



/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³RELRATAUDMº Autor ³ Renato Peixoto     º Data ³  17/02/12   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Relatório que vai exibir o rateio que acabou de ser reali- º±±
±±º          ³ zado para o AUDIMED.                                       º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP6 IDE                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function RELRATAUDM()


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracao de Variaveis                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

Local cDesc1        := "Este programa tem como objetivo imprimir relatorio "
Local cDesc2        := "de acordo com os parametros informados pelo usuario."
Local cDesc3        := "Rel Rateio AUDIMED"
Local cPict         := ""
Local titulo        := "Rel Rateio AUDIMED"
Local nLin          := 80
                      //0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789
Local Cabec1        := "Competencia    RDA        Empresa     Matricula      Tipo Registro   Digito    Nome Beneficiario                             Valor Rateio         Usuario Sistema     Cod. Proced.    Nome Procedimento"
Local Cabec2        := ""
Local imprime       := .T.
Local aOrd := {}
Private lEnd        := .F.
Private lAbortPrint := .F.
Private CbTxt       := ""
Private limite      := 220
Private tamanho     := "G"
Private nomeprog    := "RELRATAUDM" // Coloque aqui o nome do programa para impressao no cabecalho
Private nTipo       := 18
Private aReturn     := { "Zebrado", 1, "Administracao", 2, 2, 1, "", 1}
Private nLastKey    := 0
Private cbtxt       := Space(10)
Private cbcont      := 00
Private CONTFL      := 01
Private m_pag       := 01
Private wnrel       := "RELRATAUDM" // Coloque aqui o nome do arquivo usado para impressao em disco
Private cString     := "PB7"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta a interface padrao com o usuario...                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

wnrel := SetPrint(cString,NomeProg,"",@titulo,cDesc1,cDesc2,cDesc3,.T.,aOrd,.T.,Tamanho,,.T.)

If nLastKey == 27
	Return
Endif

SetDefault(aReturn,cString)

If nLastKey == 27
   Return
Endif

nTipo := If(aReturn[4]==1,15,18)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Processamento. RPTSTATUS monta janela com a regua de processamento. ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

RptStatus({|| RunReport(Cabec1,Cabec2,Titulo,nLin) },Titulo)
Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFun‡„o    ³RunReport º Autor ³ Renato Peixoto     º Data ³  17/02/12   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescri‡„o ³ Função que vai fazer a logica de impressao.                º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Programa principal                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function RunReport(Cabec1,Cabec2,Titulo,nLin)

Local nOrdem
Local i := 0


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ SETREGUA -> Indica quantos registros serao processados para a regua ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

SetRegua(Len(aVetRel))

For i := 1 To Len(aVetRel)

   //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
   //³ Verifica o cancelamento pelo usuario...                             ³
   //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

   If lAbortPrint
      @nLin,00 PSAY "*** CANCELADO PELO OPERADOR ***"
      Exit
   Endif

   //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
   //³ Impressao do cabecalho do relatorio. . .                            ³
   //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

   If nLin > 55 // Salto de Página. Neste caso o formulario tem 55 linhas...
      Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
      nLin := 8
   Endif

   //aVetRel { XFILIAL("PB7"), cCompet, cCodRDA, cCodInt, aArray1[nQ][32][2], aArray1[nQ][26][2], aArray1[nQ][27][2], aArray1[nQ][29][2], aArray1[nQ][9][2], nVlrUni, USRFILLNAME(__cUserId), cProAud, cNomProAUD }
   @nLin,00  PSAY aVetRel[i][2]
   @nLin,13  PSAY aVetRel[i][3]
   //@nLin,30  PSAY aVetRel[i][4]
   @nLin,28  PSAY aVetRel[i][5]
   @nLin,38  PSAY aVetRel[i][6]
   @nLin,57  PSAY aVetRel[i][7]
   @nLin,71  PSAY aVetRel[i][8]
   @nLin,79  PSAY aVetRel[i][9]
   @nLin,127 PSAY aVetRel[i][10] Picture "@E 999,999.99"
   @nLin,147 PSAY aVetRel[i][11]
   @nLin,168 PSAY aVetRel[i][12]
   @nLin,183 PSAY aVetRel[i][13]
   
   nLin := nLin + 1 // Avanca a linha de impressao

Next i

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Finaliza a execucao do relatorio...                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

SET DEVICE TO SCREEN

If aReturn[5]==1
   dbCommitAll()
   SET PRINTER TO
   OurSpool(wnrel)
Endif

MS_FLUSH()

Return



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ CriaSX1  ³ Autor ³ Renato Peixoto        ³ Data ³ 27/12/11 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Atualiza perguntas                                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ CriaSX1()                                                  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function CriaSX1()

PutSx1(cPerg,"01",OemToAnsi("Mes Pgto:")     ,"","","mv_ch1","C",02,0,0,"G","","   ","","","mv_par01",""   ,"","","",""   ,"","","","","","","","","","","",{"Defina para qual mes de Pgto sera realizado o pagto Audimed"},{""},{""})
PutSx1(cPerg,"02",OemToAnsi("Ano Pagamento:"),"","","mv_ch2","C",04,0,0,"G","","   ","","","mv_par02",""   ,"","","",""   ,"","","","","","","","","","","",{"Indique qual será o ano de pagamento..."},{""},{""})
PutSx1(cPerg,"03",OemToAnsi("Data do Evento:"),"","","mv_ch3","D",08,0,0,"G","","   ","","","mv_par03",""   ,"","","",""   ,"","","","","","","","","","","",{"Indique a data do evento para inclusao no contas medicas..."},{""},{""})
//PutSx1(cPerg,"05",OemToAnsi("Paga Bonus?")           ,"","","mv_ch5","C",01,0,0,"C","","   ","","","mv_par05","Sim","","","","Nao" ,"","","","","","","","","","","",{"Haverá pagamento de bonus? (Sim/Nao)"},{},{})
//PutSx1(cPerg,"06",OemToAnsi("Vlr Individual Bonus:") ,"","","mv_ch6","N",09,2,0,"G","","   ","","","mv_par06",""   ,"","","",""   ,"","","","","","","","","","","",{"Defina qual será o valor individual para o Pgto do bonus. "},{""},{""})

Return                     