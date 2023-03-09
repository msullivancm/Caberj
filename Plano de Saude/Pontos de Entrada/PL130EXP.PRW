/*/
эээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээ
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
╠╠зддддддддддбддддддддддбдддддддбдддддддддддддддддддддддбддддддбдддддддддд©╠╠
╠╠ЁFun┤┘o    |PL130EXP  Ё Autor Ё Microsiga             Ё Data Ё 15.08.06 Ё╠╠
╠╠цддддддддддеддддддддддадддддддадддддддддддддддддддддддаддддддадддддддддд╢╠╠
╠╠ЁDescri┤┘o Ё Identifica qtd de expostos por Regra do Cliente            Ё╠╠
╠╠цддддддддддедддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд╢╠╠
╠╠Ё Uso      Ё Generico                                                   Ё╠╠
╠╠юддддддддддадддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды╠╠
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
ъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъ
/*/

User Function PL130EXP()

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Inicializa variaveis                                                     Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
Local nTemp, cChave, lContinua, aRet, lTemCob, aStruCod, nTmp, nTempor

Local cOper		:= paramixb[1]
Local cEmpIni	:= paramixb[2]
Local cEmpFim	:= paramixb[3]
Local cMatIni	:= paramixb[4]
Local cMatFim	:= paramixb[5]
Local dDatIni	:= paramixb[6]
Local dDatFim	:= paramixb[7]
Local cTipPla	:= paramixb[8]
Local dTipPla  	:= paramixb[9]
Local cGruBen  	:= paramixb[10]
Local dGruBen  	:= paramixb[11]
Local cEmpIntS 	:= paramixb[12]
Local nIndiceE  := paramixb[13]
//Local aSipExp   := paramixb[14]
Local _lLog 		:= .F.

Local cNameBA1  := RetSQLName("BA1")
Local cNameBA3  := RetSQLName("BA3")
Local cNameBG9  := RetSQLName("BG9")
Local cNameBQC  := RetSQLName("BQC")
Local cNameBCA  := RetSQLName("BCA")
Local cCodigo   := ""
Local cQryBloq  := ""
Local lBenBlo   := .F.
Local lBlqAns   := .F.
Local dDatBlo   := StoD("")
Local nCt       := 0
Local nPosVet   := 0
Local nPosaCri  := 0
Local nPosTam   := 0
LOCAL nOldi		:= 1
LOCAL nPos
Local nPosBI3   := 1
LOCAL cCodPla   := ""
LOCAL cVersao   := ""
LOCAL cKey		:= ""
Local lValBI3	:= .F.
Local nLBr8		:= 1

//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Monta array somente na primeira chamada do ponto de entrada			        Ё
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
Local aSipExp     := {}
////If nIndiceE == 4
//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Array responsavel por gravar os valores referentes aos expostos ...         Ё
//цддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд╢
//Ё Formato do Array : 													        Ё
//Ё		->Codigo do Item da Despesa											    Ё
//Ё		->Grupos de Coberturas separados por virgula, caso necessario			Ё
//Ё 	->Carencia em dias													    Ё
//Ё 	->coluna com valor zero, onde sera gravado o numero de expostos 		Ё
//Ё 		para cada item do relatorio para o Anexo II			    		    Ё
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
//Item Consultas
aadd(aSipExp,{"1.1","002",30,0})
//Exames Complementares
aadd(aSipExp,{"1.2",""   ,0,0})
//Angiografia
aadd(aSipExp,{"1.2.1.1","003,004,005,007,023,027",180,0})
//Hemodinamica
aadd(aSipExp,{"1.2.1.2","004,007,027",180,0})
//Ressonancia nuclear
aadd(aSipExp,{"1.2.1.3","003,004,027",180,0})
//Tomografia computadorizada
aadd(aSipExp,{"1.2.1.4","003,004,005,027",180,0})
//Demais exames
aadd(aSipExp,{"1.2.2","002,003,004,005,006,007,008,016,023,026,027",300,0})
//Terapias
aadd(aSipExp,{"1.3",""     ,0,0})
//Hemoterapia
aadd(aSipExp,{"1.3.1.1","003,004,005,006,007,016,023,026",180,0})
//Litotripsia
aadd(aSipExp,{"1.3.1.2","006,007",180,0})
//Quimioterapia
aadd(aSipExp,{"1.3.1.3","006,022,023",180,0})
//Radiologia
aadd(aSipExp,{"1.3.1.4","003,004,005,006,007,023",180,0})
//Radioterapia
aadd(aSipExp,{"1.3.1.5","006,007",180,0})
//Terapia renal
aadd(aSipExp,{"1.3.1.6","002,005,006,007,023",180,0})
//Demais terapias
aadd(aSipExp,{"1.3.2","002,003,005,006,007,009,010,011,012,013,016,017,023,024",180,0})
//Internacoes
aadd(aSipExp,{"1.4","",0,0})
//Internacoes com menos de 24 hs
aadd(aSipExp,{"1.4.1","",0,0})
//Internacoes com 24 hs ou mais
aadd(aSipExp,{"1.4.2","",0,0})
//Outros Atend Ambulat
aadd(aSipExp,{"1.5","001,002,003,005,006,007,012,023,024",180,0})
//Demais despesas assistenciais
aadd(aSipExp,{"1.6","002,007,015,016,017,019,021,024",180,0})
////Endif
//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Seleciona registros para processamento ...                               Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё From ...                                                                 Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
cFrom   := " FROM " + cNameBA1 + ", " + cNameBA3 + ", " + cNameBG9
If  alltrim(cTipPla) <> "1" // Tipo Plano = Coletivo
	cFrom   += ", " + cNameBQC
Endif
//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Where BA1-Usuarios ...                                                   Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
cWhere  := " WHERE BA1_FILIAL = '" + xFilial("BA1") + "' AND "
cWhere  +=       " BA1_CODINT =  '" + cOper   + "' AND "
cWhere  +=       " BA1_CODEMP >= '" + cEmpIni + "' AND "
cWhere  +=       " BA1_CODEMP <= '" + cEmpFim + "' AND "
If ! empty(cEmpIntS)
	cWhere  +=       " BA1_CODEMP NOT IN (" + cEmpIntS + ") AND "
Endif
cWhere  +=       " BA1_MATRIC >= '" + cMatIni + "' AND "
cWhere  +=       " BA1_MATRIC <= '" + cMatFim + "' AND "
cWhere  +=       " BA1_DATINC <= '" + dtos(dDatFim) + "' AND "
Do Case
	//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//Ё Beneficiarios expostos                                                   Ё
	//Ё Beneficiarios da operadora que esta enviando as informacoes e tem o      Ё
	//Ё servico fornecido majoriatariamente pela mesma                           Ё
	//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
	Case cGruBen == "1" // Beneficiarios expostos
		cWhere  += " (BA1_OPEORI = '" + cOper + "' AND BA1_OPEDES = '" + cOper + "') AND "
		cWhere  += " BA1_INFANS <> '0' "
		//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
		//Ё Expostos nao beneficiarios                                               Ё
		//Ё Beneficiarios de outra operadora mas que tem o servico fornecido         Ё
		//Ё majoritariamente pela operadora que esta enviando as informacoes         Ё
		//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
	Case cGruBen == "2" // Expostos nao beneficiarios
		cWhere  += "(BA1_OPEORI <> '" + cOper + "' AND BA1_OPEDES = '" + cOper + "') "//" (BA1_OPEORI <> '" + cOper + "' AND BA1_OPEDES = '" + cOper + "') AND "
		//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
		//Ё Beneficiarios nao expostos                                               Ё
		//Ё Beneficiarios da operadora que esta enviando as informacoes que tem o    Ё
		//Ё servico fornecido majoriatariamente por outra operadora                  Ё
		//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
	Case cGruBen == "3" // Beneficiarios nao expostos
		cWhere  += " (BA1_OPEORI = '" + cOper + "' AND BA1_OPEDES <> '" + cOper + "') AND "
		cWhere  += " BA1_INFANS <> '0' "
EndCase
cWhere  +=       " AND BA1_DATADM <= '" + Dtos(dDatFim) + "' AND "
cWhere  +=         cNameBa1 + ".D_E_L_E_T_ <> '*' AND "
//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Where BA3-Familias/Usuarios ...                                          Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
cWhere  +=       " BA3_FILIAL = '" + xFilial("BA3") + "' AND "
cWhere  +=       " BA3_CODINT = BA1_CODINT AND "
cWhere  +=       " BA3_CODEMP = BA1_CODEMP AND "
cWhere  +=       " BA3_MATRIC = BA1_MATRIC AND "
cWhere  +=         cNameBA3 + ".D_E_L_E_T_ <> '*' AND "
//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Where BG9-Grupo/Empresa ...                                              Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
cWhere  +=       " BG9_FILIAL = '" + xFilial("BG9") + "' AND "
cWhere  +=       " BG9_CODINT = BA1_CODINT AND "
cWhere  +=       " BG9_CODIGO = BA3_CODEMP AND "
cWhere  +=         cNameBG9 + ".D_E_L_E_T_ <> '*' AND "
If  alltrim(cTipPla) == "1" // Tipo Plano = Individual/Familiar
	cWhere  +=   " BG9_TIPO = '1' " // Pessoa Fisica
Else
	cWhere  +=   " BG9_TIPO = '2' " // Pessoa Juridica
Endif
//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Where BQC-SubContrato ...                                                Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
If  alltrim(cTipPla) <> "1" // Tipo Plano = Coletivo
	cWhere  +=   " AND  "
	cWhere  +=   " BQC_FILIAL = '" + xFilial("BQC") + "' AND "
	cWhere  +=   " SUBSTRING(BQC_CODIGO,1,4) = BA3_CODINT AND "
	cWhere  +=   " SUBSTRING(BQC_CODIGO,5,4) = BA3_CODEMP AND "
	cWhere  +=   " BQC_NUMCON = BA3_CONEMP AND "
	cWhere  +=   " BQC_VERCON = BA3_VERCON AND "
	cWhere  +=   " BQC_SUBCON = BA3_SUBCON AND "
	cWhere  +=   " BQC_VERSUB = BA3_VERSUB AND "
	cWhere  +=     cNameBQC + ".D_E_L_E_T_ <> '*' AND "
	If  alltrim(cTipPla) == "2" // Tipo Plano = Coletivo sem patrocinador
		cWhere  +=   " BQC_PATROC = '0' " // sem patrocinador
	Else
		cWhere  +=   " BQC_PATROC = '1' " // com patrocinador
	Endif
Endif

cOrderBy := " ORDER BY BA1_NOMUSR "

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Seleciona registros ...                                                  Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
cFiltro := "SELECT BA1_NOMUSR, BA1_CODINT, BA1_CODEMP, BA1_MATRIC, BA1_TIPREG, BA1_DATBLO, BA1_CODPLA, "
cFiltro += "BA1_VERSAO, BA3_CODPLA, BA3_VERSAO, BA1_DATCAR, " + cNameBA1 + ".R_E_C_N_O_ AS REGBA1, " + cNameBA3 + ".R_E_C_N_O_ AS REGBA3 "
cFiltro += cFrom
cFiltro += cWhere//+" AND BA1_NOMUSR LIKE 'A%' "
cFiltro += cOrderBy
PLSQuery(cFiltro,"BA1QRY")

//MsgAlert("Atencao!!! Rotina nao estА sendo gerada por completo!!!!")

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Processa registros selecionados                                          Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
nHorIniUsr := Seconds()
While ! BA1QRY->(Eof())
	IncProcG2("Calculando BeneficiАrios PE- verificando usuario: " + BA1QRY->BA1_NOMUSR)
	//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//Ё Posiciona BA1                                                            Ё
	//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды	
	//nHorIni := Seconds()	
	//BA1->(dbGoTo(BA1QRY->REGBA1))
	//BA3->(dbGoTo(BA1QRY->REGBA3))
	//PlsLogFil(Space(03)+"A-> Usr: "+BA1->BA1_NOMUSR+" DBGOTO levou "+Str(Seconds()-nHorIni),"LOG130EXP.SIP")	
	
	//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//Ё Verifica se no fim do periodo o beneficiario estava bloqueado.        Ё
	//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
	nHorIni := seconds()
	cQryBloq  := " SELECT BCA_TIPO, BCA_DATA, BCA_MOTBLO, BCA_NIVBLQ FROM " + cNameBCA
	cQryBloq  += " WHERE BCA_FILIAL = '" + xFilial("BCA") + "' AND BCA_MATRIC = '" + BA1QRY->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC) + "' AND"
	cQryBloq  += " BCA_TIPREG = '" + BA1QRY->BA1_TIPREG + "' AND"
	cQryBloq  += " BCA_DATA <= '" + dtos(dDatFim) + "' AND "
	cQryBloq  += cNameBCA + ".D_E_L_E_T_ <> '*' "
	cQryBloq  += " ORDER BY BCA_DATA, R_E_C_N_O_"
	PLSQuery(cQryBloq,"BCAQRY")
	
	
	//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//Ё Se nao existe historico de bloqueio do Usuario e                      Ё
	//Ё    a data de bloqueio do usuario eh anterior ao periodo do SIB        Ё
	//Ё    -> despreza o usuario                                              Ё
	//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
	If  BCAQRY->(eof()) .and. ;
		! empty(BA1QRY->BA1_DATBLO) .and. ;
		dtos(BA1QRY->BA1_DATBLO) < dtos(dDatIni)
		BCAQRY->(DbCloseArea())
		If _lLog
			PlsLogFil(Space(03)+"B-> Usr: "+BA1QRY->BA1_NOMUSR+" BENEFICIARIO LEVOU "+Str(seconds()-nHorIniUsr),"LOG130EXP2.SIP")	
			nHorIniUsr := Seconds()
		Endif		
		BA1QRY->(DbSkip())  
		Loop
	Endif
	//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//Ё Inicializa variaveis                                                  Ё
	//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
	lTemCob   := .F.
	lBenBlo := .F.
	lBlqAns := .F.
	dDatBlo := StoD("")
	
	BI3->(DbSetOrder(1))
	//BRV->(DbSetOrder(1))
	
	
	//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//Ё Processa historico de bloqueio                                        Ё
	//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
	While ! BCAQRY->(eof())
		lBlqAns := .F.
		Do Case
			Case BCAQRY->BCA_NIVBLQ == 'U' // Nivel de Usuario
				If  BG3->(MsSeek(xFilial("BG3")+BCAQRY->BCA_MOTBLO))
					If  ! empty(BG3->BG3_BLQANS)
						lBlqAns := .T.
					Endif
				Endif
			Case BCAQRY->BCA_NIVBLQ == 'F' // Nivel de Familia
				If  BG1->(MsSeek(xFilial("BG1")+BCAQRY->BCA_MOTBLO))
					If  ! empty(BG1->BG1_BLQANS)
						lBlqAns := .T.
					Endif
				Endif
			Case BCAQRY->BCA_NIVBLQ == 'S' // Nivel de Sub-Contrato
				If  BQU->(MsSeek(xFilial("BQU")+BCAQRY->BCA_MOTBLO))
					If  ! empty(BQU->BQU_BLQANS)
						lBlqAns := .T.
					Endif
				Endif
		EndCase
		If  lBlqAns .and. BCAQRY->BCA_TIPO == "0" // Bloqueio
			lBenBlo := .T.
			dDatBlo := BCAQRY->BCA_DATA
		Else
			lBenBlo := .F.
			dDatBlo := StoD("")
		Endif
		BCAQRY->(dbSkip())
	Enddo
	BCAQRY->(DbCloseArea())
	//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//Ё Despreza usuario bloqueado antes da data inicial                      Ё
	//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
	If  ! empty(dDatBlo) .and. dDatBlo < dDatIni
		BA1QRY->(dbSkip())
		Loop
	Endif
	If _lLog 
		PlsLogFil(Space(03)+"A-> Usr: "+BA1QRY->BA1_NOMUSR+" Processo do BCA levou "+Str(seconds()-nHorIni),"LOG130EXP.SIP")	
	Endif

	//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//Ё Acumula qtd e inicializa variaveis                                       Ё
	//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
	nHorIni := seconds()

	nTotBenef ++
	nQtdBenef ++
	nDiasCar1 := 0
	
	If Empty(BA1QRY->BA1_CODPLA)
		cCodPla := BA1QRY->BA3_CODPLA
		cVersao := BA1QRY->BA3_VERSAO
	Else
		cCodPla := BA1QRY->BA1_CODPLA
		cVersao := BA1QRY->BA1_VERSAO
	Endif
	
	i := 1
	//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//Ё Processa vetor aSIP ...                                    Ё
	//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
	While i <= len(aSipExp)
		//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
		//Ё Calcula exposto...						                   Ё
		//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
		lTemCob  := .F.
		nDiasCar := aSipExp[i,3]
		dAuxIni  := Max(BA1QRY->BA1_DATCAR + nDiasCar,dDatIni)
		dAuxFim  := Min(If(Empty(dDatBlo),dDatFim,dDatBlo),dDatFim)
		If  dAuxFim > dAuxIni
			nDiasExp := dAuxFim - dAuxIni
		Else
			nDiasExp := 0
		Endif
		If  nDiasExp > 0
			//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
			//Ё Verifica se for item da internacao 15 ou 1.5 verifica cobertura no produto do usuario	Ё
			//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
			lValBI3 := .F.
			nOldi := i
			//If aSipExp[i,1] <> "1.05"
			/*
			If ! aSipExp[i,1] $  "1.4/1.4.1/1.4.2"
				//--------------------------------------------
				BRV->(MsSeek(xFilial("BRV")+BA1->BA1_CODINT+cCodPla+cVersao))
				
				PlsLogFil(Space(03)+"-> Hora ["+seconds()+"] PE 130EXP ANTES WHILE BRV ","LOG130EXP.SIP")
				
				While ! BRV->(eof()) .AND. xFilial("BRV")+BRV->BRV_CODPLA+BRV->BRV_VERSAO == xFilial("BRV")+BA1->BA1_CODINT+cCodPla+cVersao
					
					If BRV->BRV_CODGRU $ aSipExp[i,2]
						lTemCob  := .T.
						Exit
					Endif
					
					BRV->(dbSkip())
				Enddo
				If  ! lTemCob
					nDiasExp := 0
				Endif
				//-------------------------------------------
			Else //caso seja o item internacao faz a verificacao no produto
			*/
			
				nPosBI3 := Ascan(aProcBI3,{ |x| x[1] == xFilial("BI3")+BA1QRY->BA1_CODINT+cCodPla+cVersao })
				If nPosBI3 == 0
					BI3->(MsSeek(xFilial("BI3")+BA1QRY->BA1_CODINT+cCodPla+cVersao))
					If Empty(BI3->BI3_CODSEG) .or. BI3->BI3_CODSEG $ cSegInt  //"002,003,006,007,010,011,013,014"
						lValBI3 := .T.
						lTemCob  := .T.
					Endif
					aadd(aProcBI3,{xFilial("BI3")+BA1QRY->BA1_CODINT+cCodPla+cVersao,lValBI3,BI3->BI3_CODSEG })
				Else
					If Empty(aProcBI3[nPosBI3,3]) .or. aProcBI3[nPosBI3,3] $ cSegInt //"002,003,006,007,010,011,013,014"
						lValBI3 := .T.
						lTemCob  := .T.
					Endif
				Endif
				If  ! lTemCob
					nDiasExp := 0
				Endif
			//Endif
			
		Endif
		//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
		//Ё Acumula valores no item...			                       Ё
		//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
		aSipExp[i,4] += nDiasExp
		//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
		//Ё Pula para proxima ocorrencia do vetor aSIP                 Ё
		//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
		i++
	EndDo
	If _lLog 
		PlsLogFil(Space(03)+"A-> Usr: "+BA1QRY->BA1_NOMUSR+" Processo do exposto levou "+Str(seconds()-nHorIni),"LOG130EXP.SIP")
	Endif
	
	//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//Ё Acessa proximo registro                                    Ё
	//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
	If _lLog 
		PlsLogFil(Space(03)+"B-> Usr: "+BA1QRY->BA1_NOMUSR+" BENEFICIARIO LEVOU "+Str(seconds()-nHorIniUsr),"LOG130EXP2.SIP")	
		nHorIniUsr := Seconds()
	Endif
	BA1QRY->(DbSkip())

EndDo
//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Fecha area de trabalho                                                   Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
BA1QRY->(DbCloseArea())
//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Fim da funcao - Retorna Vetor aSipExp com valores de expostos            Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды

Return(aSipExp)
