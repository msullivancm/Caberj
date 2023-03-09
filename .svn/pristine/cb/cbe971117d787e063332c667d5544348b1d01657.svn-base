#Include "PROTHEUS.CH"
#Include "TOPCONN.CH"
#Include "TBICONN.CH"
#Include "AP5MAIL.CH"
#Include "UTILIDADES.CH"

#DEFINE cEnt chr(10)+chr(13)

/*
#############################################################################
#############################################################################
###Programa | CABA611   |Autor: MATEUS              | Data:10/04/2018     ###
#############################################################################
##Desc.     |  IMPORTADOR DOS ANEXOS 				                      ###
##          |  ( ANEXOS DE GUIAS ANEXADOS NA OPERATIVA )                  ###
#############################################################################
##Uso       | INTEGRAÇÃO PROTHEUS X OPERATIVA                             ###
#############################################################################
#############################################################################
#############################################################################
*/

******************************************************************************************************

******************************************************************************************************

User Function CABA611(lSchedule)
	// retorna vetor empresa - filial
	Local aEmpresas     := {"01","02"}

	Default lSchedule 	:= .T.

	conout("INÍCIO PROCESSAMENTO - SCHEDULE CABA611 - "+Time())
	/*
	******************************************
	*'Executa a busca pelos anexos das guias'*
	******************************************
	*/
	//For nX := 1 to len(aEmpresas)
	execAnexo(lSchedule/*,aEmpresas[nX]*/)
	//Next Nx
	******************************************

	conout("FIM PROCESSAMENTO - SCHEDULE CABA611 - "+Time())

Return

/*
#############################################################################
#############################################################################
###Programa | CABA610   |Autor: MATEUS              | Data:10/04/2018     ###
#############################################################################
##Desc.     |  Função para buscar os anexos vinculados as guias operativa ###
#############################################################################
##Uso       | INTEGRAÇÃO PROTHEUS X OPERATIVA                             ###
#############################################################################
#############################################################################
#############################################################################
*/

Static Function execAnexo(lSchedule)

	Local cAlias1 := GetNextAlias()
	Local cRegAns := ''
	Local nRecno  := 0
	Local cServDes  := ''
	Private nX	  := 0

	RpcSetType(3)
	RpcClearEnv()
	RpcSetEnv(lSchedule[1],lSchedule[2])

	//	If lSchedule

	// Query buscar as informações dos arquivo
	if cEmpAnt == '01'
		cRegAns := '324361'
		conout("INÍCIO PROCESSAMENTO - SCHEDULE CABA611 - CABERJ - "+Time())
	else
		cRegAns :=  '415774'
		conout("INÍCIO PROCESSAMENTO - SCHEDULE CABA611 - INTEGRAL - "+Time())
	endif

	cAlias1 := GetNextAlias()
	//cServDes  :=  "E:\Totvs\P12\Protheus_Data" // PROD // 'E:\Totvs_Desenv\P11\Protheus_Data' // TESTE
	cServDes:= "\\"+AllTrim(GetMv("MV_XSRVTOP"))+"\P12\Protheus_Data"   /*P12R27 - Virada*/

	BeginSql Alias cAlias1
		SELECT
			PROC.TISS_REGISTRO_ANS,
			TISS_NUM_AUT_EMPRESA,
			B.R_E_C_N_O_ BEARECNO,
			PROC.ID_AUT,
			ANEX.ID_ANEXO,
			REPLACE(ANEX.NOME_ANEXO, ' ', '') NOME_ANEXO
		FROM
			OPERATIVA.AUT_PROCEDIMENTOS_ANX ANEX,
			OPERATIVA.AUT_PROCEDIMENTOS PROC,
			%table:BEA% B
		WHERE
			PROC.ID_AUT = ANEX.ID_AUT
			AND ANEX.PROCESSADO = 'N'
			AND PROC.TISS_REGISTRO_ANS = %exp:cRegAns%
			AND BEA_FILIAL = ' '
			AND BEA_OPEMOV = '0001'
			AND BEA_ANOAUT = SUBSTR(TISS_NUM_AUT_EMPRESA, 1, 4)
			AND BEA_MESAUT = SUBSTR(TISS_NUM_AUT_EMPRESA, 5, 2)
			AND BEA_NUMAUT = SUBSTR(TISS_NUM_AUT_EMPRESA, 7, 8)
			AND BEA_TIPO = '2'
			AND B.D_E_L_E_T_ = ' ' //UNION ALL
	ENDSQL
	///else

	/*BeginSql Alias cAlias1

				SELECT '02' EMPRESA,PROC.TISS_REGISTRO_ANS,TISS_NUM_AUT_EMPRESA,B.R_E_C_N_O_ BEARECNO,
				PROC.ID_AUT,ANEX.ID_ANEXO,REPLACE(ANEX.NOME_ANEXO,' ','')
				FROM OPERATIVA.AUT_PROCEDIMENTOS_ANX ANEX,
				OPERATIVA.AUT_PROCEDIMENTOS PROC,
				BEA020 B
				WHERE PROC.ID_AUT = ANEX.ID_AUT
				AND PROC.TISS_REGISTRO_ANS = %exp:cAnsInt%
				AND ANEX.PROCESSADO = 'N'
				AND BEA_FILIAL = ' '
				AND BEA_OPEMOV = '0001'
				AND BEA_ANOAUT = SUBSTR(TISS_NUM_AUT_EMPRESA,1,4)
				AND BEA_MESAUT = SUBSTR(TISS_NUM_AUT_EMPRESA,5,2)
				AND BEA_NUMAUT = SUBSTR(TISS_NUM_AUT_EMPRESA,7,8)
				AND BEA_TIPO   = '2'
				AND B.D_E_L_E_T_ = ' '

	EndSql*/

	//Endif

	do while (cAlias1)->(!Eof())

		// chamar função que executará a conversão do arquivo e a movimentação
		// para a pasta dirdoc

		//RpcClearEnv() // limpa o ambiente - Reset Environment
		//if RpcSetEnv(alltrim((cAlias1)->EMPRESA))  // Prepara o ambiente para processamento

		dbselectarea("BEA") // abre a área de trabalho
		BEA->(dbgoto((cAlias1)->BEARECNO)) // Posiciona no registro da BEA

		cAlias2 := GetNextAlias()

		cIdAut   := "%"+cvaltochar((cAlias1)->ID_AUT)+"%"
		cIdAnexo := "%"+cvaltochar((cAlias1)->ID_ANEXO)+"%"

		BEGINSQL ALIAS cAlias2
			SELECT
				OPERATIVA.EXTRAIR_ANEXO(%exp:cIdAut%,%exp:cIdAnexo%) ARQEXP
			FROM
				DUAL
		ENDSQL

		if (cAlias2)->(Eof())
			//If TcSqlExec(cQuery) <> 0
			cErro := " - Erro na execucao da procedure " + CRLF + Space(3) + cQuery + CRLF + Space(3) + 'TcSqlError [ ' + TcSqlError() + ' ]'
			ConOut(cErro)
			lOk := .F.
		Else
			//\\10.19.1.10\Totvs_Desenv\P11\Protheus_Data\dirdoc\co01\shared
			// função que montará a .bat que copiará o arquivo no diretório do oracle para o dirdoc


			cNomeBat := MontaBat(	strtran(strtran((cAlias2)->ARQEXP,'/',''),' ',''),'\dirdoc\co'+cEmpAnt+'\shared')

			// executa bat que foi criada anteriormente
			lResWait := WaitRunSrv( cServDes+lower(cNomeBat) , .T. , cServDes+'\dirdoc\co'+cEmpAnt+'\shared\' )

			// apaga bat criada, para evitar que fique lixo na pasta
			//fErase(cNomeBat)

			If !lResWait .AND. !File('\dirdoc\co'+cEmpAnt+'\shared'+alltrim((cAlias2)->ARQEXP) )
				Alert("Erro na copia do arquivo de Log !! ")
			Else
				//Alert("Arquivo Log Criado em " + cDirLog + " ! ")
				CONOUT("MOVEU O ARQUIVO")

				// Neste momento sempre será "001" - de acordo com a pré-definição da área de negócio
				nX :=  Soma1(STRZERO(0,3))

				nRecno := (cAlias1)->BEARECNO

				GravaAnx(alltrim(strtran(strtran((cAlias1)->NOME_ANEXO,'/',''),' ','')),(cAlias1)->TISS_NUM_AUT_EMPRESA)

				cQuery := "UPDATE OPERATIVA.AUT_PROCEDIMENTOS_ANX SET PROCESSADO = 'S' "
				cQuery += "WHERE ID_ANEXO = "+cvaltochar((cAlias1)->ID_ANEXO)+""

				tcSqlExec(cQuery)
			EndIf
		EndIf

		//	endif

		// passa para o próximo registro
		(cAlias1)->(dbskip())

	enddo

	//**********************************************/
	//*'Verifica a existência do alias temporário  //
	//*' e o fecha. 							   //
	//**********************************************/
	if select(cAlias1) > 0
		dbselectarea(cAlias1)
		(cAlias1)->(dbclosearea())
	endif


	//	EndIf

Return

//*****************//
//* GRAVA ANEXO   *//
//*****************//
Static Function GravaAnx(cDoc,cChaveAnx)

	Local lRet      := .T.									
	Local _cNumAnx	:= "" //Angelo Henrique - Data:04/04/2018
	Local _lGrAC9 	:= .F.

	Default cDoc		:= ''
	Default	cChaveAnx 	:= ''

	_cNumAnx := GetSx8Num("ACB","ACB_CODOBJ")
	ConfirmSX8() //Angelo Henrique - Data:04/04/2018

	//-----------------------------------------------------------------------------------------
	//Angelo Henrique - Data:27/09/2021
	//-----------------------------------------------------------------------------------------
	//Tentativa de contornar problema de numeração sendo perdida entre as integrações
	//-----------------------------------------------------------------------------------------
	DbSelectArea("ACB")
	DbSetORder(1) //AC9_FILIAL+AC9_CODOBJ+AC9_ENTIDA+AC9_FILENT+AC9_CODENT
	If !(DbSeek(xFilial("ACB") + _cNumAnx ))

		_lGrAC9 := .T.

	Else

		While !_lGrAC9

			_cNumAnx := GetSx8Num("ACB","ACB_CODOBJ")
			ConfirmSX8() //Angelo Henrique - Data:04/04/2018

			DbSelectArea("ACB")
			DbSetORder(1) //ACB_FILIAL+ACB_CODOBJ
			If !(DbSeek(xFilial("ACB") + _cNumAnx ))

				_lGrAC9 := .T.

			Else

				_lGrAC9 := .F.

			EndIf

		EndDo

	EndIf
	//-----------------------------------------------------------------------------------------

	If 	_lGrAC9

		RecLock("AC9",.T.)
		AC9->AC9_FILIAL := xFilial("AC9")
		AC9->AC9_FILENT := xFilial("BE2")
		AC9->AC9_ENTIDA	:= "BE2"
		AC9->AC9_CODOBJ	:= _cNumAnx
		AC9->AC9_CODENT	:= BEA->(BEA_FILIAL+BEA_OPEMOV+BEA_ANOAUT+BEA_MESAUT+BEA_NUMAUT)+(nX)
		AC9->AC9_XUSU	:= 'OPERATIVA'
		AC9->AC9_XDTINC := ddatabase
		AC9->AC9_HRINC  := STRTRAN(TIME(),":","")
		AC9->(MsUnLock())


		RecLock("ACB",.T.)
		ACB->ACB_FILIAL := xFilial("ACB")
		ACB->ACB_CODOBJ	:= _cNumAnx
		ACB->ACB_OBJETO	:= cDoc
		ACB->ACB_DESCRI	:= cDoc
		ACB->(MsUnLock())

	EndIf

Return lRet


*************************************************************************************************************

//************************************************
//Função para criar arquivo BAT que será utilizado para copiar os
//arquivos da Operativa.
//************************************************

Static Function MontaBat(cArq,cArqDes)

	Local cConteudo := ""
	//Bianchini - 07/07/2020 - P12-R27 - Adequação de URL´s para MV´s
	//Local cServArq  := '\\10.19.1.12\utl' // caminho do servidor de banco protheus
	//Local cServDes  :=  "\\10.19.1.8\p12\Protheus_Data" // caminho do servidor DbAcess
	Local cServArq  := "\\"+AllTrim(GetMv("MV_XSRVBD"))+"\utl" // caminho do servidor de banco protheus
	Local cServDes  := "\\"+AllTrim(GetMv("MV_XSRVTOP"))+"\p12\Protheus_Data" // caminho do servidor DbAcess

	Local cNomArq  := ''

	cNomArq := '\data\'+strtran(left(cArq,len(alltrim(cArq))-4),'/','')+'.Bat'

	cConteudo :='RoboCopy '+cServArq+' '+alltrim(cServDes)+cArqDes+' '+ALLTRIM(strtran(cArq,'/',''))+cEnt

	MemoWrite( STRTRAN(cNomArq,'-','') ,cConteudo )

Return STRTRAN(cNomArq,'-','')