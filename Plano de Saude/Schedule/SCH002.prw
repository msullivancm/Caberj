#Include 'Protheus.ch'
#INCLUDE 'APWEBSRV.CH'
#INCLUDE 'AP5MAIL.CH'

/*/{Protheus.doc} SCH002

Rotina para trocar os bloqueios temporários para definitivo e encaminhar e-mail.
Utilizado na CABERJ para Mater e Afinidade contendo o código de bloqueio 893

-----------------------------------------------------------------------------------------
                            A T E N Ç A O
-----------------------------------------------------------------------------------------
Nesse momento essa rotina só é executada para a CABERJ visando atender somente
MATER e AFINIDADE, atenção no momento da parametrização da SCHEDULE
-----------------------------------------------------------------------------------------
                    ROTINAS DE BLOQUEIO / DESBLOQUEIO
-----------------------------------------------------------------------------------------
Bloqueio e desbloqueio da familia e grupo familiar
-----------------------------------------------------------------------------------------
PL260BLOCO(cAlias,nReg,nOpc,lDireto,cMotivo,dData,cBloFat,nP20,aLog,lGrav,lblqAut, lMsg)
PlsGrpFam(.T.,.F.,BA1->BA1_CODINT + BA1->BA1_CODEMP + BA1->BA1_MATRIC)
-----------------------------------------------------------------------------------------

@type function
@version 1.0
@author angelo.cassago
@since 26/09/2022
/*/
User function SCH002(aParSched)

	SCH002A()
    /*
	Local  nH := 0

	RpcSetType(3)
	RpcSetEnv(aParSched[1], aParSched[2],,,'PLS',,)

	QOut("Processo Mudança Tipo Bloqueio - SCH002 - Iniciado" )

	nH := PLSAbreSem("SCH002" + aParSched[1] + ".SMF", .F.)

	if nH != 0

		SCH002A()

		PLSFechaSem(nH, "SCH001.SMF")

	Else

		QOut("Processo Mudança Tipo Bloqueio - SCH002 - Problema ao abrir semaforo" )

	endif

	QOut("Processo Mudança Tipo Bloqueio - SCH002 - Finalizado" )

	RpcClearEnv()
    */
Return

/*/{Protheus.doc} SCH002A
Rotina que irá iniciar a checagem dos beneficiários e executar o processo caso algum seja encontrado
@type function
@version 1.0
@author angelo.cassago
@since 26/09/2022
/*/
Static Function SCH002A()

	Local cAliasTRB     := GetNextAlias()

	Private _aVtErro    := {}
	Private _aVtOk      := {}
	Private _cQuery     := ""
	Private _cMail	    := GETMV("MV_XSCH02A") //Parametro que contém o email dos responsaveis
	Private _cEmpBlq	:= GETMV("MV_XSCH02B") //Parametro que contém as empresas que serão pesquisadas
	Private _cMotBlq	:= GETMV("MV_XSCH02C") //893 -- Parametro que contem o motivo de bloqueio a ser pesquisado
	Private _cDesBlq	:= GETMV("MV_XSCH02D") //881 -- Parametro que contem o motivo de desbloqueio para o processo de mudança
	Private _cNewBlq	:= GETMV("MV_XSCH02E") //003 -- Parametro que contem o novo codigo de bloqueio (Bloqueio Definitivo)

	//---------------------------------------------------------------------
	//Montagem da Query
	//Na rotina abaixo é o momento em que a variável _cQuery é preenchida
	//---------------------------------------------------------------------
	SCH002B()

	dbUseArea(.T.,"TOPCONN",TcGenQry(,,_cQuery),cAliasTRB,.T.,.T.)

	dbSelectArea(cAliasTRB)
	(cAliasTRB)->(dbgotop())

	If (cAliasTRB)->(Eof())

		QOut("Processo Mudança Tipo Bloqueio - SCH002 - Nao foram encontrados dados para efetuar o processo" )

	Else

		While  !(cAliasTRB)->(Eof())

			DbSelectArea("BA1")
			DbSetOrder(2)
			If DbSeek(xFilial("BA1")+(cAliasTRB)->MATRICULA)

				//---------------------------------------------------------------------------------------------------
				//Etapas:
				//---------------------------------------------------------------------------------------------------
				//- Primeiro efetuar o desbloqueio (Utilizar acerto cadastral ou similar)
				//- Segundo bloquear com o novo código
				//---------------------------------------------------------------------------------------------------
				PL260BLOCO("BA1", BA1->(Recno()),4,.T.,_cDesBlq,dDataBase,"2",,,,.F.,.F.)

				PlsGrpFam(.T.,.F.,BA1->BA1_CODINT + BA1->BA1_CODEMP + BA1->BA1_MATRIC)

				RecLock("BCA", .F.)

				BCA->BCA_OBS := "Desbloqueio efetuado automaticamente rotina SCH002"

				BCA->(MsUnlock())

				RecLock("BC3", .F.)

				BC3->BC3_OBS := "Desbloqueio efetuado automaticamente rotina SCH002"

				BC3->(MsUnlock())

				If Empty(BA1->BA1_DATBLO)

					PL260BLOCO("BA1", BA1->(Recno()),4,.T.,_cNewBlq,dDataBase,"1",,,,.F.,.F.)

					PlsGrpFam(.F.,.T.,BA1->BA1_CODINT + BA1->BA1_CODEMP + BA1->BA1_MATRIC)

					RecLock("BCA", .F.)

					BCA->BCA_OBS := "Bloqueio efetuado automaticamente rotina SCH002"

					BCA->(MsUnlock())

					RecLock("BC3", .F.)

					BC3->BC3_OBS := "Bloqueio efetuado automaticamente rotina SCH002"

					BC3->(MsUnlock())

					If !Empty(BA1->BA1_DATBLO)

						AADD(_aVtOk,{(cAliasTRB)->MATRICULA,  (cAliasTRB)->NOME , "Processo executado com sucesso na matricula informada"})

					Else

						AADD(_aVtErro,{(cAliasTRB)->MATRICULA,  (cAliasTRB)->NOME , "Não foi possivel realizar a segunda etapa do processo (bloqueio) na matricula informada"})

					EndIf

				Else

					AADD(_aVtErro,{(cAliasTRB)->MATRICULA, (cAliasTRB)->NOME , "Não foi possivel realizar a primeira etapa do processo (desbloqueio) na matricula informada"})

				EndIf

			Else

				AADD(_aVtErro,{(cAliasTRB)->MATRICULA, (cAliasTRB)->NOME , "Não foi possivel localizar a matricula informada"})

			EndIf

			(cAliasTRB)->(DbSkip())

		Enddo

		//-----------------------------------------------
		//Envio de e-mail com os bloqueios efetuados
		//-----------------------------------------------
		If Len(_aVtOk) > 0

			SCH002C()

		EndIF

	EndIf

Return

/*/{Protheus.doc} SCH002B
Rotina utilizada para montar a query, deixando ela de fora dos processos executados
facilitando asim sua manutenção.
@type function
@version 1.0
@author angelo.cassago
@since 26/09/2022
/*/
Static Function SCH002B

	_cQuery += " SELECT 		" + CRLF
	_cQuery += " 	 DISTINCT 	" + CRLF
	_cQuery += "     BA1.BA1_CODINT||BA1.BA1_CODEMP||BA1_MATRIC||BA1_TIPREG||BA1_DIGITO MATRICULA, " + CRLF
	_cQuery += "     TRIM(BA1.BA1_NOMUSR) NOME 			" + CRLF
	_cQuery += " FROM 									" + CRLF
	_cQuery += "     " + RetSqlName("SE1") + " SE1 		" + CRLF
	_cQuery += "	 " + CRLF
	_cQuery += "     INNER JOIN " + CRLF
	_cQuery += "         " + RetSqlName("BA3") + " BA3 	" + CRLF
	_cQuery += "     ON  " + CRLF
	_cQuery += "         BA3.BA3_FILIAL      = '" + xFilial("BA3") + "' " + CRLF
	_cQuery += "         AND BA3.BA3_CODINT  = SE1.E1_CODINT 			" + CRLF
	_cQuery += "         AND BA3.BA3_CODEMP  = SE1.E1_CODEMP 			" + CRLF
	_cQuery += "         AND BA3.BA3_MATRIC  = SE1.E1_MATRIC 			" + CRLF
	//_cQuery += "         AND BA3.BA3_MOTBLO  = '" + _cMotBlq + "' 	" + CRLF
	_cQuery += "         AND BA3.D_E_L_E_T_  = ' ' " + CRLF
	_cQuery += "      " + CRLF
	_cQuery += "     INNER JOIN " + CRLF
	_cQuery += "         " + RetSqlName("BA1") + " BA1 " + CRLF
	_cQuery += "     ON  " + CRLF
	_cQuery += "         BA1.BA1_FILIAL      = '" + xFilial("BA1") + "' " + CRLF
	_cQuery += "         AND BA1.BA1_CODINT  = BA3.BA3_CODINT 			" + CRLF
	_cQuery += "         AND BA1.BA1_CODEMP  = BA3.BA3_CODEMP 			" + CRLF
	_cQuery += "         AND BA1.BA1_MATRIC  = BA3.BA3_MATRIC 			" + CRLF
	_cQuery += "         AND BA1.BA1_MOTBLO  = BA3.BA3_MOTBLO 			" + CRLF
	_cQuery += "         AND BA1.BA1_TIPUSU  = 'T' 						" + CRLF
	_cQuery += "         AND BA1.D_E_L_E_T_  = ' ' 						" + CRLF
	_cQuery += "         " + CRLF
	/*
	_cQuery += "     INNER JOIN " + CRLF
	_cQuery += "         " + RetSqlName("SE1") + " SE1_INT " + CRLF
	_cQuery += "     ON  " + CRLF
	_cQuery += "         SE1_INT.E1_FILIAL       = SE1.E1_FILIAL 		" + CRLF
	_cQuery += "         AND SE1_INT.E1_CODINT   = SE1.E1_CODINT 		" + CRLF
	_cQuery += "         AND SE1_INT.E1_CODEMP   = SE1.E1_CODEMP 		" + CRLF
	_cQuery += "         AND SE1_INT.E1_MATRIC   = SE1.E1_MATRIC 		" + CRLF
	_cQuery += "         AND SE1_INT.E1_SALDO    = 0 					" + CRLF
	_cQuery += "         AND SE1_INT.D_E_L_E_T_  = ' ' 					" + CRLF
	_cQuery += "         AND SYSDATE - TO_DATE(TRIM(SE1_INT.E1_BAIXA), 'YYYYMMDD')  >= 121	" + CRLF
	_cQuery += "         AND SE1_INT.E1_BAIXA  = ( 		" + CRLF
	_cQuery += "             SELECT 					" + CRLF
	_cQuery += "                 MAX(SE1_MAX.E1_BAIXA) 	" + CRLF
	_cQuery += "             FROM 						" + CRLF
	_cQuery += "                 " + RetSqlName("SE1") + "  SE1_MAX " + CRLF
	_cQuery += "             WHERE 												" + CRLF
	_cQuery += "                 SE1_MAX.E1_FILIAL       = SE1_INT.E1_FILIAL 	" + CRLF
	_cQuery += "                 AND SE1_MAX.E1_CODINT   = SE1_INT.E1_CODINT 	" + CRLF
	_cQuery += "                 AND SE1_MAX.E1_CODEMP   = SE1_INT.E1_CODEMP 	" + CRLF
	_cQuery += "                 AND SE1_MAX.E1_MATRIC   = SE1_INT.E1_MATRIC 	" + CRLF
	_cQuery += "                 AND SE1_MAX.E1_SALDO    = 0                    " + CRLF
	_cQuery += "                 AND SE1_MAX.D_E_L_E_T_  = ' '                 	" + CRLF
	_cQuery += "         )       " + CRLF
	_cQuery += "         " + CRLF
	*/
	_cQuery += " WHERE 	 " + CRLF
	_cQuery += "     SE1.E1_FILIAL       = '" + xFilial("SE1") + "' 	" + CRLF
	_cQuery += "     AND SE1.E1_CODINT   = '0001' 						" + CRLF
	_cQuery += "     AND SE1.E1_CODEMP IN (" + _cEmpBlq + ") 			" + CRLF
	_cQuery += "     AND SE1.E1_SALDO    > 0 							" + CRLF
	//remover depois a linha de baixo
	_cQuery += "     AND SE1.E1_MATRIC   = '022840' 					" + CRLF

	_cQuery += "     AND SE1.E1_VENCREA  > TO_CHAR(SYSDATE,'yyyymmdd') 	" + CRLF
	_cQuery += "     AND SE1.D_E_L_E_T_  = ' ' 							" + CRLF

Return

/*/{Protheus.doc} SCH002C
Rotina que irá disparar os email dos beneficiarios bloqueados
@type function
@version  1.0
@author angelo.cassago
@since 28/09/2022
/*/
Static Function SCH002C(_cParam)

	Local _cTxTot	:= ""
	Local a_HtmTot  := "\HTML\BLOQ893.HTML" //Variavel que irá receber o template do HTML a ser utilizado.
	Local c_ToTot	:= ""
	Local c_CCTot	:= ""
	Local c_AssTot := "Bloqueio 893 CABERJ - MATER e AFINIDADE"
	Local a_MsgTot	:= {}
	Local _ni       := 0

	DEFAULT _cParam := "1"

	//Varrer o vetor dos beneficiários que foram bloqueados
	For _ni := 1 to len(_aVtOk)

		If _ni == 1

			If  _cParam = "1"

				_cTitulo := "Benefici&aacute;rios bloqueados &cedil; rotina autom&aacute;tica - 893: "

			Else

				_cTitulo := "Benefici&aacute;rios n&atilde;o bloqueados &cedil; rotina autom&aacute;tica - 893: "

			EndIF

			If  _cParam = "1"

				_cTxTot += '<br>' + CRLF
				_cTxTot += '<span data-mce-style="font-size: 16pt;">Abaixo est&atilde;o listados todos os benefici&aacute;rios que foram bloqueados pela rotina autom&aacute;tica.</span></div>' + CRLF
				_cTxTot += '<br>' + CRLF

			Else

				_cTxTot += '<br>' + CRLF
				_cTxTot += '<span data-mce-style="font-size: 16pt;">Abaixo est&atilde;o listados todos os benefici&aacute;rios que n&atilde;o foram bloqueados pela rotina autom&aacute;tica.</span></div>' + CRLF
				_cTxTot += '<br>' + CRLF

			EndIf

			//-----------------------------------
			//Criando a tabela
			//-----------------------------------
			_cTxTot += '<TABLE BORDER=1>				' + CRLF
			_cTxTot += '<TR style="font-weight:bold">	' + CRLF
			_cTxTot += '<TD>MATRICULA</TD>				' + CRLF
			_cTxTot += '<TD>NOME</TD>			        ' + CRLF
			_cTxTot += '</TR>							' + CRLF

		EndIf

		_cTxTot += '<TR>' + CRLF
		_cTxTot += '<TD>' + _aVtOk[_ni][1] 				+ '</TD>' + CRLF
		_cTxTot += '<TD>' + _aVtOk[_ni][2] 				+ '</TD>' + CRLF
		_cTxTot += '</TR>' + CRLF

		If _ni == Len(_aVtOk)

			_cTxTot += '</TABLE>' + CRLF

		EndIf

	Next _ni

	//--------------------------------------------------------------
	//Acrescentando aqui o vetor das variáveis da página web
	//--------------------------------------------------------------
	aAdd( a_MsgTot, { "_cTexto"	, _cTxTot })

	//c_ToTot := GetNewPar("MV_XEMAIPA","teste@caberj.com.br")
	c_ToTot := "angelo.cassago@caberj.com.br" //teste

	//-----------------------------------------------------
	//Função para envio de e-mail
	//-----------------------------------------------------
	If Env_1(a_HtmTot, c_ToTot, c_CCTot, c_AssTot, a_MsgTot )

		QOut("Processo Mudança Tipo Bloqueio - SCH002 - Disparo de Email efetuado" )

	EndIf

	//--------------------------------------------
	//Zerando as variáveis para não dar problema
	//--------------------------------------------
	a_MsgTot := {}
	_cTxTot  := ""

Return

/*/{Protheus.doc} Env_1
Dispara o email que foi montado
@type function
@version  1.0
@author angelo.cassago
@since 28/09/2022
@param c_ArqTxt, character, contem o nome do HTML
@param c_To, character, Email para onde sera enviado
@param c_CC, character, Email do copia oculta
@param c_Assunto, character, assunto do email
@param a_Msg, array, Contem as informações que serão montadas no corpo do email
/*/
Static Function Env_1(c_ArqTxt, c_To, c_CC, c_Assunto, a_Msg )

	Local n_It 			:= 0

	Local _cError     	:= ""
	Local l_Result    	:= .F.                   		// resultado de uma conexão ou envio
	Local nHdl        	:= fOpen(c_ArqTxt,68)
	Local c_Body      	:= space(99999)

	Private _cServer  	:= Trim(GetMV("MV_RELSERV")) 	// smtp.ig.com.br ou 200.181.100.51

	Private _cUser    	:= GetNewPar("MV_XMAILPA", "protocolodeatendimento@caberj.com.br")
	Private _cPass    	:= GetNewPar("MV_XPSWPA" , "Caberj2017@!")

	Private _cFrom    	:= "CABERJ PROTHEUS"
	Private cMsg      	:= ""

	If !(nHdl == -1)

		nBtLidos := fRead(nHdl,@c_Body,99999)
		fClose(nHdl)

		For n_It:= 1 to Len( a_Msg )

			c_Body  := StrTran(c_Body, a_Msg[n_It][1] , a_Msg[n_It][2])

		Next

		// Tira quebras de linha para nao dar problema no WebMail da Caberj
		c_Body  := StrTran(c_Body,CHR(13)+CHR(10) , "")

		// Contecta o servidor de e-mail
		CONNECT SMTP SERVER _cServer ACCOUNT _cUser PASSWORD _cPass RESULT l_Result

		If !l_Result

			GET MAIL ERROR _cError

			DISCONNECT SMTP SERVER RESULT lOk

		Else

			SEND MAIL FROM _cUser TO c_To SUBJECT c_Assunto BODY c_Body  RESULT l_Result

			If !l_Result

				GET MAIL ERROR _cError

			Endif

		EndIf

	Endif

Return l_Result
