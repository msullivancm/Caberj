#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'TOTVS.CH'
#INCLUDE 'FONT.CH'
#INCLUDE 'TOPCONN.CH'
#INCLUDE 'Tbiconn.ch' 

#DEFINE cEnt chr(10)+chr(13)
/*****************************************************************************/
/** FABIO BIANCHINI - 14/02/2019											**/
/** AS FUNÇÕES ABAIXO SERÃO DESTINADAS A UMA PARTE DO PROCESSO QUE DEVE     **/
/** SER EXECUTADO APÓS INTEGRAR AO TAF, A FOLHA JÁ GERADA					**/
/*****************************************************************************/

/*****************************************************************************/
/** FABIO BIANCHINI - 14/02/2019											**/
/** FUNÇÃO: TXT_C91_T6W													    **/
/** DESCRIÇÃO: LÊ ARQUIVO TXT CONTENDO CPF DO TRABALHADOR E CNPJ DA  		**/
/** INSTITUIÇÃO QUE RETÉM COMO SENDO OUTRAS FONTES							**/
/** GERA INFORMAÇÕES COMPLEMENTARES PARA C91 E T6W							**/
/*****************************************************************************/
User Function CABA617() 
	Local oButton1
	Local oButton2
	Local oGet1
	Local oGet2
	Local oGet3
	Local oGroup1  
	Local oGroup2
	Local oSay1
	Local oSay2
	Local oSay3
	Local oSay4
	Local oSay5
	Private cGet1 := Space(6)
	Private cGet2 := Space(6)
	Private cGet3 := Space(120)

	Private cEstab:= Space(6)

	Static oDlg

	DEFINE MSDIALOG oDlg TITLE "AJUSTE CNPJ OUTRAS FONTES - C91 & T6W" FROM 000, 000  TO 200, 600 COLORS 0, 16777215 PIXEL

	//Codigos de Estabelecimento TAF - Com Recibo
	//Caberj   --000012   (000012 - Com Recibo)
	//Integral --000007   (000001 - Com Recibo)
	If cEmpAnt == "01"
		cEstab := "000012"
	Else
		cEstab := "000007"
	Endif

	cGet1 := cEstab

	@ 003, 002 GROUP oGroup1 TO 031, 297 OF oDlg COLOR 0, 16777215 PIXEL
	@ 015, 015 SAY oSay1 PROMPT "EXECUTAR SOMENTE APÓS INTEGRAR A FOLHA COM O TAF, ANTES DA TRANSMISSÃO AO GOVERNO" SIZE 267, 008 OF oDlg COLORS 0, 16777215 PIXEL
	@ 031, 001 GROUP oGroup2 TO 097, 297 OF oDlg COLOR 0, 16777215 PIXEL
	@ 041, 018 SAY oSay2 PROMPT "Cod.Estabel.(999999):" SIZE 060, 007 OF oDlg COLORS 0, 16777215 PIXEL
	@ 039, 075 MSGET oGet1 VAR @cGet1 SIZE 6, 010 OF oDlg COLORS 0, 16777215 PIXEL
	@ 041, 110 SAY oSay3 PROMPT "Caberj: 000012 / Integral: 000007" SIZE 100, 007 OF oDlg COLORS 0, 16777215 PIXEL
	@ 056, 018 SAY oSay4 PROMPT "Periodo(AAAAMM):" SIZE 047, 007 OF oDlg COLORS 0, 16777215 PIXEL
	@ 054, 075 MSGET oGet2 VAR cGet2 SIZE 6, 010 OF oDlg COLORS 0, 16777215 PIXEL
	@ 071, 018 SAY oSay5 PROMPT "Arquivo:" SIZE 025, 007 OF oDlg COLORS 0, 16777215 PIXEL
	@ 069, 047 MSGET oGet3 VAR cGet3 SIZE 203, 010 OF oDlg COLORS 0, 16777215 PIXEL
	@ 083, 194 BUTTON oButton1 PROMPT "&Carregar >>>" SIZE 037, 012 OF oDlg ACTION(GRV_C91_T6W(cGet3,cGet2)) PIXEL
	@ 083, 245 BUTTON oButton2 PROMPT "Sai&r" SIZE 037, 012 OF oDlg ACTION oDlg:End() PIXEL
	DEFINE SBUTTON oSButton1 FROM 069, 256 TYPE 14 OF oDlg ACTION BuscaArq() ENABLE 

	ACTIVATE MSDIALOG oDlg CENTERED 

Return

Static Function BuscaArq()
	cGet3 := cGetFile( 'Arquivos TXT|*.txt|Arquivos CSV|*.csv' , 'Selecionar Arquivo...', 1, 'C:\', .F., GETF_LOCALHARD,.F., .T. )
Return 

/*****************************************************************************/
/** FABIO BIANCHINI - 14/02/2019											**/
/** FUNÇÃO: GRV_C91_T6W													    **/
/** DESCRIÇÃO: GRAVA C91 E T6W BASEADO NO ARQUIVO TXT CONTENDO CPF DO 		**/
/** TRABALHADOR E CNPJ DA INSTITUIÇÃO QUE RETÉM COMO SENDO OUTRAS FONTES	**/
/** GERA INFORMAÇÕES COMPLEMENTARES PARA C91 E T6W							**/
/*****************************************************************************/
Static Function GRV_C91_T6W(cDirImp,cPeriodo) 
	Local lContinua := .F.
	Local nRecC91	:= 0
	Local nRecT6W	:= 0
	Local nQtdLin	:= 0
	Local nCont     := 1
	Local cQtdLin   := ''
	Local cIdTrabal := ''
	Local aLinha    := {}
	Local aDados	:= {}
	Local aLog		:= {}
	//Variaveis para Gravar o LOG
	//Local cDir    := "C:\TEMP\"
	//Local cArqLog := "LOGTAF_" + DTOS(Date()) + ".CSV"
	//Local nHandle := FCreate(cDir+cArqLog)

	Local nCount  := 0
	Local cUpdSql := ""
	Local nSALBAS := GetMv('MV_SALBAS')
	Local cQryBBC := ""
	Local cAliasBBC := GetNextAlias()
	Local cIDC91  := ""
	Local cVersaoC91 := ""
	Local cTexto  := ""
	
	If !Empty(cGet1)

		If cEmpAnt == "01" //CABERJ
			//Ajusta C9K
			cUpdSql := "UPDATE SIGA.C9K010 SET C9K_ESTABE = '"+cGet1+"'" + cEnt
			cUpdSql += " WHERE C9K_FILIAL = '01' " + cEnt
			cUpdSql += "   AND C9K_ESTABE = ' '  " + cEnt
			cUpdSql += "   AND D_E_L_E_T_ = ' '  " + cEnt  

			If TcSqlExec(cUpdSql ) < 0
				Alert("CABA617 - Erro ao Salvar C9K")
			EndIf	

			//Ajusta C9M
			cUpdSql := "UPDATE SIGA.C9M010 SET C9M_ESTABE = '"+cGet1+"'" + cEnt
			cUpdSql += "  WHERE C9M_FILIAL = '01' " + cEnt
			cUpdSql += "   AND C9M_ESTABE = ' '   " + cEnt
			cUpdSql += "   AND D_E_L_E_T_ = ' '   " + cEnt
			cUpdSql += "   AND C9M_ID IN (SELECT C9K_ID       " + cEnt 
			cUpdSql += "                    FROM SIGA.C9K010  " + cEnt
			cUpdSql += "                   WHERE C9K_FILIAL = '01' " + cEnt
			cUpdSql += "                     AND C9K_ESTABE = '"+cGet1+"'" + cEnt
			cUpdSql += "                     AND D_E_L_E_T_ = ' ') " + cEnt

			If TcSqlExec(cUpdSql ) < 0
				Alert("CABA617 - Erro ao Salvar C9M")
			EndIf	 

			//Ajusta C9L	  
			cUpdSql := "UPDATE SIGA.C9L010 SET C9L_ESTABE = '"+cGet1+"'" + cEnt
			cUpdSql += " WHERE C9L_FILIAL = '01' " + cEnt
			cUpdSql += "   AND C9L_ESTABE = ' '  " + cEnt
			cUpdSql += "   AND D_E_L_E_T_ = ' '  " + cEnt
			cUpdSql += "   AND C9L_ID IN (SELECT C9K_ID            " + cEnt
			cUpdSql += "                    FROM SIGA.C9K010       " + cEnt
			cUpdSql += "                   WHERE C9K_FILIAL = '01' " + cEnt
			cUpdSql += "                     AND C9K_ESTABE = '"+cGet1+"'" + cEnt
			cUpdSql += "                     AND D_E_L_E_T_ = ' ') " + cEnt

			If TcSqlExec(cUpdSql ) < 0
				Alert("CABA617 - Erro ao Salvar C9L")
			EndIf		
		Else //INTEGRAL
			//Ajusta C9K
			cUpdSql := "UPDATE SIGA.C9K020 SET C9K_ESTABE = '"+cGet1+"'" + cEnt
			cUpdSql += " WHERE C9K_FILIAL = '01' " + cEnt
			cUpdSql += "   AND C9K_ESTABE = ' '  " + cEnt
			cUpdSql += "   AND D_E_L_E_T_ = ' '  " + cEnt  

			If TcSqlExec(cUpdSql ) < 0
				Alert("CABA617 - Erro ao Salvar C9K")
			EndIf	

			//Ajusta C9M
			cUpdSql := "UPDATE SIGA.C9M020 SET C9M_ESTABE = '"+cGet1+"'" + cEnt
			cUpdSql += "  WHERE C9M_FILIAL = '01' " + cEnt
			cUpdSql += "   AND C9M_ESTABE = ' '   " + cEnt
			cUpdSql += "   AND D_E_L_E_T_ = ' '   " + cEnt
			cUpdSql += "   AND C9M_ID IN (SELECT C9K_ID       " + cEnt 
			cUpdSql += "                    FROM SIGA.C9K020  " + cEnt
			cUpdSql += "                   WHERE C9K_FILIAL = '01' " + cEnt
			cUpdSql += "                     AND C9K_ESTABE = '"+cGet1+"'" + cEnt
			cUpdSql += "                     AND D_E_L_E_T_ = ' ') " + cEnt

			If TcSqlExec(cUpdSql ) < 0
				Alert("CABA617 - Erro ao Salvar C9M")
			EndIf	 

			//Ajusta C9L	  
			cUpdSql := "UPDATE SIGA.C9L020 SET C9L_ESTABE = '"+cGet1+"'" + cEnt
			cUpdSql += " WHERE C9L_FILIAL = '01' " + cEnt
			cUpdSql += "   AND C9L_ESTABE = ' '  " + cEnt
			cUpdSql += "   AND D_E_L_E_T_ = ' '  " + cEnt
			cUpdSql += "   AND C9L_ID IN (SELECT C9K_ID            " + cEnt
			cUpdSql += "                    FROM SIGA.C9K020       " + cEnt
			cUpdSql += "                   WHERE C9K_FILIAL = '01' " + cEnt
			cUpdSql += "                     AND C9K_ESTABE = '"+cGet1+"'" + cEnt
			cUpdSql += "                     AND D_E_L_E_T_ = ' ') " + cEnt

			If TcSqlExec(cUpdSql ) < 0
				Alert("CABA617 - Erro ao Salvar C9L")
			EndIf
		Endif
		Alert('Codigos de Estabelecimento Ajustados!')
	Endif

	//Se o Caminho de Arquivo NÃO estiver vazio, este será levado em conta para ajustar as retenções
	//por outras fontes. 

	IF !Empty(cDirImp)
		If MSGYESNO("Confirma Carga do Arquivo?" ,"Atenção")
			lContinua := .T.
			FT_FUSE(cDirImp)
			FT_FGOTOP()
		Endif
	Else
		If MSGYESNO("Confirma Uso das Parametrizações do Prestador?" ,"Atenção")
			lContinua := .F.
		Endif
	Endif     

	If lContinua //lContinua == .T. ===> Significa que vai ler de uma pasta um arquivo CSV ou TXT contendo CPF do Medico e CNPJ da outra fonte
		nQtdLin := FT_FLASTREC()
		cQtdLin := allTrim(Transform(nQtdLin,'@E 999,999,999'))

		ProcRegua(nQtdLin)

		nQtdLin := 0

		While !FT_FEOF()

			IncProc('Processando linha ' + allTrim(Transform(++nQtdLin,'@E 999,999,999')) + ' de ' + cQtdLin) //incrementa a regua de processamento...

			cBuffer   := FT_FREADLN()
			aLinha := SEPARA(cBuffer,';')
			aAdd(aDados,aLinha) 

			FT_FSKIP()

		Enddo

		FT_FUSE()

	Else //lContinua == .F. ===> Significa que vai ler direto da tabela BBC se possui retenção por outras fontes

		cQryBBC := " SELECT BAU_CODIGO, BAU_CPFCGC, BAU_NOME, BBC_CNPJ, BBC_VLDINI, BBC_VLDFIM, BBC_VALOR " + cEnt
		cQryBBC += "   FROM "+RetSqlName("BAU")+" BAU ," +RetSqlName("BBC")+" BBC " 						+ cEnt
		cQryBBC += "  WHERE BAU_FILIAL = '" + xFilial("BAU") +"' " 											+ cEnt
		cQryBBC += "    AND BBC_FILIAL = '" + xFilial("BAU") +"' " 											+ cEnt
		cQryBBC += "    AND BAU_TIPPE = 'F' "					 											+ cEnt
		cQryBBC += "    AND BAU_CODIGO = BBC_CODIGO " 														+ cEnt
		cQryBBC += "    AND BBC_CODSER = '050' " 															+ cEnt
		cQryBBC += "    AND BBC_CNPJ   <> ' ' " 															+ cEnt
		cQryBBC += "    AND TO_CHAR(SYSDATE,'YYYYMMDD') BETWEEN BBC_VLDINI AND BBC_VLDFIM " 				+ cEnt 
		cQryBBC += "    AND BAU.D_E_L_E_T_ = ' ' " 															+ cEnt
		cQryBBC += "    AND BBC.D_E_L_E_T_ = ' ' " 															+ cEnt
		cQryBBC += "  ORDER BY BAU_CPFCGC, BBC_VLDINI " 													+ cEnt

		memowrite('c:\temp\caba617.sql',cQryBBC)

		dbUseArea(.T.,'TOPCONN',TcGenQry(,,cQryBBC),cAliasBBC,.T.,.T.)

		DbSelectArea(cAliasBBC)

		nContRegua := (cAliasBBC)->(RecCount())

		While !(cAliasBBC)->(EOF())
			aAdd(aDados,{AllTrim((cAliasBBC)->BAU_CPFCGC),AllTrim((cAliasBBC)->BBC_CNPJ)})
			(cAliasBBC)->(DbSkip())
		Enddo

		(cAliasBBC)->(DbCloseArea())

	Endif	

	For nCont := 1 to Len(aDados)
		If Len(aDados[ncont]) > 0
			DbSelectArea("C9V")
			DbSetOrder(3)
			If DbSeek(xFilial("C9V")+aDados[nCont][1]+'1')
				While !EOF() .and. C9V->(C9V_FILIAL+C9V_CPF+C9V_ATIVO) == xFilial("C9V")+aDados[nCont][1]+'1' 
					If C9V->C9V_STATUS == '4' .OR. EMPTY(C9V->C9V_STATUS)
						cIdTrabal := C9V->C9V_ID
						Exit
					Endif
					C9V->(DbSkip())
				Enddo
			Endif
			C9V->(DbCloseArea())

			If !Empty(cIdTrabal)
				DbSelectArea("C91")
				DbSetOrder(4)
				If DbSeek(xFilial("C91")+cIdTrabal) //+'1')
					While !EOF() .and. C91->(C91_FILIAL+C91_TRABAL+C91_ATIVO) == xFilial("C91")+cIdTrabal+'1'  
						If (C91->C91_EVENTO == 'I') .AND. (C91->C91_PERAPU == cPeriodo) 
							cIDC91     := AllTrim(C91->C91_ID)
							cVersaoC91 := CVALTOCHAR(AllTrim(C91->C91_VERSAO))
							RecLock('C91',.F.)
							C91->C91_INDMVI := '3'
							C91->C91_EVENTO := 'I'
							MsUnlock()
							nRecC91 := C91->(RECNO())
							Exit
						Endif
						C91->(DbSkip())
					Enddo
				Endif
				C91->(DbCloseArea())

				If !Empty(cIDC91) .and. !Empty(cVersaoC91) 
					DbSelectArea("T6W")
					DbSetOrder(1)		
					If !DbSeek(xFilial("T6W")+cIDC91+cVersaoC91)
						RecLock('T6W',.T.)
						T6W->T6W_FILIAL := xFilial("T6W")
						T6W->T6W_ID		:= cIDC91
						T6W->T6W_VERSAO := cVersaoC91
						T6W->T6W_TPINSC := '1'
						T6W->T6W_NRINSC := aDados[nCont][2]
						T6W->T6W_CODCAT := '000017'
						T6W->T6W_VLREMU := nSalBas
						MsUnlock()
						nRecT6W := T6W->(RECNO())
					Else
						RecLock('T6W',.F.)
						T6W->T6W_TPINSC := '1'
						T6W->T6W_NRINSC := aDados[nCont][2]
						T6W->T6W_CODCAT := '000017'
						T6W->T6W_VLREMU := nSalBas
						MsUnlock()	
						nRecT6W := T6W->(RECNO())	
					Endif
					T6W->(DbCloseArea())
				Else
				    cTexto += cIdTrabal + ' - ' + Posicione("C9V",2,xFilial("C9V")+cIdTrabal+'1',"C9V_NOME") + cEnt
					//Alert('Trabalhador '+cIdTrabal+' sem registro na C91')
				Endif
			Endif
			//aAdd(aLog,{R_E_C_N_O_C91+ ' - ' +cValToChar(nRecC91),R_E_C_N_O_TW6+ ' - ' +cValToChar(nRecTW6)})
			//nRecC91 := 0
			//nRecTW6 := 0
		Endif
	Next nCont 
	
	If !Empty(cTexto)
		memowrite('c:\temp\caba617log.txt',cTexto)
		Alert('Existe Log de Trabalhadores que não foram atualizados em c:\temp\caba617log.txt.  Verifique se há SRA')
	Endif

	//Gerando Log 
	/*
	If nHandle < 0
	MsgAlert("Erro durante criação do arquivo.")
	Else
	For nCont := 1 to Len(aLog)
	FWrite(nHandle, "Gravando linha....; " + aLog[nCont][1] + ';' + aLog[nCont][2] + CRLF)
	Next nCont
	FClose(nHandle)
	EndIf
	*/
	ALERT("CONCLUIDO")

Return