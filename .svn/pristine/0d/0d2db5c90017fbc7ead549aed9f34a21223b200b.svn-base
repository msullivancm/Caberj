#INCLUDE "PROTHEUS.CH"
#INCLUDE "TOPCONN.CH"
#INCLUDE "PLSMGER.CH"
#INCLUDE "UTILIDADES.CH"
#INCLUDE "SIGAWIN.CH"
#INCLUDE "TBICONN.CH"
#INCLUDE "FILEIO.CH"
#INCLUDE "RWMAKE.CH"
#INCLUDE "PLSMGER.CH"
#INCLUDE "COLORS.CH"

Static nInclui		:= 1
Static nAltera		:= 2
Static nBloqueia 	:= 3

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABA336   ºAutor  ³Bianchini/Marcela   º Data ³  25/07/08   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Importa usuarios de empresas incluindo alterando e excluindoº±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³PLS                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ºPrograma  ³CABA336   ºAutor  ³Angelo Henrique   - Listagem das Rotinas º±±
±±ºCABA336A  ³Realiza o processo de bloqueio dos beneficiários.           º±±
±±ºCABA336B  ³Realiza a contagem das inclusões e exclusões no arquivo     º±±
±±ºCABA336C  ³Realiza a transferência dos beneficiários.                  º±±
±±ºCABA336D  ³Realiza a validação do processo de transferência.           º±±
±±ºCABA336E  ³Rotina utilizada para validar se o plano já não foi inseridoº±±
±±ºCABA336F  ³Rotina utilizada para validar se mesmo criticado o          º±±
±±º          ³beneficiário irá passar pela transferência.                 º±±
±±ºCABA336G  ³Rotina utilizada para validar o processo de reativação do   º±±
±±º          ³beneficiário.                                               º±±
±±ºCABA336H  ³Rotina utilizada para realizar a reativação do beneficiario º±±
±±ºCABA336I  ³Rotina para validar a operação de bloqueio.                 º±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/                                                           

User Function CABA336()

	Private cCadastro 	:= "Importacao de Arquivos com Massa de Vida"

	Private aRotina   	:=	{	{ "Pesquisar"		, 'AxPesqui'	    , 0 , K_Pesquisar  },;
	{ "Visualizar"	 		, 'AxVisual'   		, 0 , K_Visualizar },;
	{ "I&mportar"	 		, 'U_CAB336INS'   	, 0 , K_Incluir    },;
	{ "C&riticar"			, 'U_CAB336CRI'   	, 0 , K_Incluir    },;
	{ "Vis. Critica" 		, 'U_CAB336VCRI'  	, 0 , K_Incluir    },;
	{ "&Excluir"	 		, 'U_CAB336EXC'   	, 0 , K_Excluir    },;
	{ "&Inserir BD"  		, 'U_CAB336APP'   	, 0 , K_Incluir    },;
	{ "Ex&portar"	 		, 'U_CAB336ENV'   	, 0 , K_Incluir    },;
	{ "&Gerar rel."  		, 'U_CAB336REL'   	, 0 , K_Incluir    },;
	{ "&Composicao"  		, 'U_CAB336CMP'   	, 0 , K_Incluir    },;
	{ "Legenda"      		, 'U_CAB336LEG(1)'	, 0 , K_Incluir    },;
	{ "Planilha Analise"	, 'U_CABR221'   	, 0 , K_Pesquisar  },;
	{ "Historico"    		, 'U_CB336PES'   	, 0 , K_Pesquisar  } }

	Private aCdCores  	:= { 	{ 'BR_CINZA'	, 'Arquivo Importado' 	},;
	{ 'BR_AMARELO'  , 'Arquivo Analisado SEM Criticas' 				},;
	{ 'BR_VERMELHO' , 'Arquivo Analisado COM Críticas'  			},;
	{ 'BR_VERDE'   	, 'Arquivo Totalmente Inserido na Base'      	},;
	{ 'BR_LARANJA'  , 'Arquivo Parcialmente Inserido na Base'    	},;
	{ 'BR_AZUL'    	, 'Arquivo Exportado'             				} }

	Private aCores      := { 	{ 'PBT_STATUS = "1"'	, aCdCores[1,1] },;
	{ 'PBT_STATUS = "2"'	, aCdCores[2,1] },;
	{ 'PBT_STATUS = "3"'	, aCdCores[3,1] },;
	{ 'PBT_STATUS = "4"'	, aCdCores[4,1] },;
	{ 'PBT_STATUS = "5"'	, aCdCores[5,1] },;
	{ 'PBT_STATUS = "6"'	, aCdCores[6,1] }}

	Private cPath     	:= ""
	Private aErro_		:= {}
	Private aHeader   	:= {}
	Private aTrailler 	:= {}
	Private aOk		  	:= {}

	//Variavel l_Voltou setada como TRUE no looping para inclusao do Odontologico. Tera papel importante para
	//controlar qual subcontrato sera setado para inclusao.
	Private l_Voltou	  := .F.

	//Private cConEmpOdonto := space(12)
	Private cSubConOdonto 	:= space(9)
	Private cCodpro	  		:= ""

	PBT->(DBSetOrder(1))
	PBT->(mBrowse(006,001,022,075,"PBT" , , , , , Nil    , aCores, , , ,nil, .T.))
	PBU->(DbClearFilter())

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³
³ Autor ³ Bianchini/Marcela ³ Data ³ 15.05.2006 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Importa Arquivo de Usuario para Layout Padrao PBT          ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function CAB336INS(cAlias, nReg, nOpc)

	Local oDlg
	Local nOpca   	:= 0
	Local oEnc
	Local aRet
	Local bOK     	:= {|| nOpca := 1, oDlg:End()}
	Local bCancel 	:= {|| nOpca := 0, oDlg:End()}
	Local CSqlArq 	:= ""
	Local cUSqArq 	:= ""
	Local cSQL 		:= ""
	Local cSequen 	:= 0
	Local I__f 		:= 0

	aSize 			:= MsAdvSize()
	aInfo 			:= {aSize[1], aSize[2], aSize[3], aSize[4], 3, 3}

	aObjects		:= {}
	aAdd( aObjects, { 100 , 100	, .T., .T. } )

	aPosObj 	:= MsObjSize( aInfo, aObjects,.T.)

	cAlias 		:= "PBT"

	DEFINE MSDIALOG oDlg TITLE cCadastro FROM aSize[7],00 To aSize[6],aSize[5] PIXEL

	Copy cAlias To Memory Blank

	oEnc := PBT->(MsMGet():New(cAlias,nReg,nOpc,,,,,{aPosObj[1][1],aPosObj[1][2],aPosObj[1][3]-15,aPosObj[1][4]-3},,,,,,oDlg,,,.F.))

	ACTIVATE MSDIALOG oDlg ON INIT EnchoiceBar(oDlg,bOK,bCancel,.F.,{})

	If nOpca == K_OK

		// Verifica se a sequencia corresponde a esperada
		cSql := " SELECT MAX(PBT.PBT_SEQUEN) SEQUEN "
		cSql += " FROM  "+RetSqlName("PBT")+" PBT "
		cSql += " WHERE D_E_L_E_T_ = ' ' "
		cSql += " AND   PBT.PBT_FILIAL = '  ' "
		cSql += " ORDER BY PBT_SEQUEN "

		PlsQuery(cSql,"TMPSEQ")

		If !TMPSEQ->(EOF())
			While !TMPSEQ->(EOF())
				cSequen := Strzero(val(TMPSEQ->SEQUEN) + 1,6)
				TMPSEQ->(DbSkip())
			Enddo
		EndIf

		TMPSEQ->(DbCloseArea())

		M->PBT_SEQUEN := cSequen

		Processa({||M->PBT_QTDLID := CB336IMP(oEnc:aGets,oEnc:aTela,M->PBT_NOMARQ,oDlg)},'Processando Importacao...')

		M->PBT_DTIMPO := dDatabase

		If M->PBT_QTDLID > 0
			PBT->(PLUPTENC("PBT",K_Incluir))
		EndIf
	EndIf

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ CB336IMP   ³ Autor ³ Bianchini/Marcela ³ Data ³ 15.05.2006 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Trata rotina externa                                       ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function CB336IMP(aGets,aTela,cNomArq,oDlg)

	Local aCamposImp  	:= {}
	Local nRet        	:= 0
	Local cBuffer     	:= ''
	Local nHandle
	Local cAcao       	:= ""
	Local cSQL        	:= Space(0)
	Local cTempPadrao 	:= Space(0)
	Local cWhere      	:= Space(0)
	Local nNumLin 		:= 0
	Local cNumLin 		:= Space(0)
	Local n_QtdLin 	 	:= 0

	Local cESTCIVIL		:=	'O'//Leonardo Portella - 08/06/15 - Iniciar como Outros. Erro de variavel nao existe.

	Private nBytes   := 0
	Private cFile
	Private cFileDest
	Private cFileErro
	Private cDirFiles
	Private cDirLido
	Private cDirErro
	Private cCodOpe := Space(0)

	If !Obrigatorio(aGets,aTela)
		Return(nRet)
	EndIf

	If Empty(M->PBT_NOMARQ)
		Help(" ",1,"NOFLEIMPOR")
		Return(nRet)
	End

	cPath     := GetNewPar("MV_YPATHCR","\interface\importa\prefeitura\recebidos\")
	cDirLido  := GetNewPar("MV_XPATHCL","\interface\importa\prefeitura\processados\")
	cDirErro  := GetNewPar("MV_XPATHCE","\interface\importa\prefeitura\erro\")

	If Substr(cPath,Len(cPath),1) <> "\"
		cPath := cPath + "\"
	EndIf

	cFile     := AllTrim(cPath+M->PBT_NOMARQ)
	cFileDest := AllTrim(cDirLido+M->PBT_NOMARQ)
	cFileErro := AllTrim(cDirErro+M->PBT_NOMARQ)

	cSql := "SELECT PBT_NOMARQ "
	cSql += " FROM  "+RetSqlName("PBT")+" PBT "
	cSql += " WHERE PBT_FILIAL = '  '"
	cSql += " AND PBT_NOMARQ = '"+ AllTrim(M->PBT_NOMARQ) + "' "
	cSql += " AND D_E_L_E_T_ = ' ' "

	PlsQuery(cSql,"PBTTRB")
	PBTTRB->(dbGoTop())

	If !PBTTRB->(EOF())
		PBTTRB->(DbCloseArea())
		Help(" ",1,"FILEJAEXISTE")
		Return(nRet)
	EndIf

	PBTTRB->(DbCloseArea())

	If (nHandle := FT_FUse( cFile )) == -1
		Help(" ",1,"NOFLEIMPOR")
		Return(nRet)
	EndIf

	FT_FGOTOP()

	//³ Defino o tamanho da linha mais os 2 caracteres de fim de linha      ³
	nTamLinha := M->PBT_NROBYT + 2

	////³ Vou para o inicio do arquivo
	cRet := "00"

	*'********************************************************************************************************'*
	*'INICIO LAYOUT 1
	*'********************************************************************************************************'*

	If Empty(M->PBT_LAYOUT) .or. M->PBT_LAYOUT == '1' //Layout 1 - Layout Padrao da PREVIRIO

		n_TotLin := FT_FLASTREC()
		c_QtdLin := AllTrim(Transform(n_TotLin,'@E 999,999,999'))

		ProcRegua(n_TotLin)

		nNumLin := 0

		While !FT_FEOF()

			IncProc('Processando linha ' + AllTrim(Transform(++n_QtdLin,'@E 999,999,999')) + ' de ' + c_QtdLin) //incrementa a regua de processamento...

			cBuffer := AllTrim(FT_FREADLN())
			cBuffer := REPLACE(trim(cBuffer),'"','')

			aBuffer := Separa(cBuffer,';',.T.)

			If n_QtdLin == 1 .or. empty(aBuffer)//Header
				FT_FSKIP()
				Loop
			EndIf


			If substr(cBuffer, 2, 1) <> ';'

				FT_FSKIP()
				Loop

			EndIf


			//Tipo de Movimento ==> 0 - Arquivo Espelho / 1 - Inclusao no Plano / 2 - Alteracoes Cadastrais e Transferencias / 3 - Exclusao

			//** CARGA DE VARIAVEIS DO VETOR DE LINHA **//
			cTIPO_REGISTRO 			:= AllTrim(aBuffer[1])
			cCPF 		   				:= PadL(aBuffer[2],11,'0')
			cCPF_SEGURADO				:= PadL(aBuffer[3],11,'0')
			cMATRICULA1    			:= aBuffer[4]
			cNUMPENS1	 				:= aBuffer[5]
			cMATRICULA2 				:= aBuffer[6]
			cNUMPENS2					:= aBuffer[7]
			cNOME		 				:= AllTrim(upper(aBuffer[8]))
			cNOMESOCIAL    			:= AllTrim(upper(aBuffer[9]))
			cSEXO 						:= AllTrim(upper(aBuffer[10]))

			Do Case

				Case AllTrim(upper(aBuffer[11])) == 'CASADO'
				cESTCIVIL	:=	'C'

				Case AllTrim(upper(aBuffer[11])) $ 'DESQUITADO/SEPARADO'
				cESTCIVIL	:=	'Q'

				Case AllTrim(upper(aBuffer[11])) $ 'DIVORCIADO'
				cESTCIVIL	:=	'D'

				Case AllTrim(upper(aBuffer[11])) $ 'SOLTEIRO'
				cESTCIVIL	:=	'S'

				Case AllTrim(upper(aBuffer[11])) $ 'UNIAO ESTAVEL'
				cESTCIVIL	:=	'M'

				Case AllTrim(upper(aBuffer[11])) $ 'VIUVO'
				cESTCIVIL	:=	'V'

				Case AllTrim(upper(aBuffer[11])) $ 'NAO INFORMADO'
				cESTCIVIL	:=	'O'

			EndCase

			cDTNASC		 				:= aBuffer[12]
			cNR_DECLARACAONASCIDOVIVO 	:= aBuffer[13]
			cNR_CNS						:= aBuffer[14]
			cTIPOLOGENDER				:= AllTrim(upper(aBuffer[15]))
			cNOMELOGENDER				:= AllTrim(upper(Posicione("BC9",1,xFilial("BC9")+AllTrim(aBuffer[22]),"BC9_END")))

			If Empty(AllTrim(cNOMELOGENDER))

				cNOMELOGENDER	:= upper(trim(aBuffer[16]))
			EndIf

			cNUMENDER	   				:= AllTrim(aBuffer[17])
			cCOMPLENDER				:= AllTrim(upper(aBuffer[18]))
			cBAIRROENDER   			:= AllTrim(upper(aBuffer[19]))
			cCIDADEENDER 				:= AllTrim(upper(aBuffer[20]))
			cUFENDER					:= AllTrim(upper(aBuffer[21]))
			cCEPENDER					:= REPLACE(trim(aBuffer[22]),'-','')
			cTELEFONE	   				:= replace(aBuffer[23],' ','')
			cTX_TEL_COMERCIAL			:= replace(aBuffer[24],' ','')
			cNUMTEL_CELULAR 			:= replace(aBuffer[25],' ','')
			cTX_EMAIL					:= AllTrim(lower(aBuffer[26]))

			If AllTrim(aBuffer[1]) == '3' //Se for Dependente

				Do Case

					Case AllTrim(upper(aBuffer[27])) == 'COMPANHEIRO'

					cPARENTESCO	:=	'03'

					Case AllTrim(upper(aBuffer[27])) == 'CONJUGE' .and. AllTrim(upper(aBuffer[10])) == 'F'

					cPARENTESCO	:=	'02'

					Case AllTrim(upper(aBuffer[27])) == 'CONJUGE' .and. AllTrim(upper(aBuffer[10])) == 'M'
					cPARENTESCO	:=	'04'

					Case AllTrim(upper(aBuffer[27])) == 'FILHO' .and. AllTrim(upper(aBuffer[10])) == 'F'
					cPARENTESCO	:=	'06'

					Case AllTrim(upper(aBuffer[27])) == 'FILHO' .and. AllTrim(upper(aBuffer[10])) == 'M'
					cPARENTESCO	:=	'05'

					Case AllTrim(upper(aBuffer[27])) $ 'GENITOR|GUARDA E POSSE'
					cPARENTESCO	:=	'11'

					Case AllTrim(upper(aBuffer[27])) == 'IRMAO' .and. AllTrim(upper(aBuffer[10])) == 'F'
					cPARENTESCO	:=	'15'

					Case AllTrim(upper(aBuffer[27])) == 'IRMAO' .and. AllTrim(upper(aBuffer[10])) == 'M'
					cPARENTESCO	:=	'14'

					Case AllTrim(upper(aBuffer[27])) == 'NETO' .and. AllTrim(upper(aBuffer[10])) == 'F'
					cPARENTESCO	:=	'18'

					Case AllTrim(upper(aBuffer[27])) == 'NETO' .and. AllTrim(upper(aBuffer[10])) == 'M'
					cPARENTESCO	:=	'17'

					Case AllTrim(upper(aBuffer[27])) == 'TUTELAS/CURATELA'
					cPARENTESCO	:=	'23'

					Otherwise
					cPARENTESCO	:=	'11'

				EndCase

			Else
				cPARENTESCO	:=	'01' //TITULAR
			EndIf

			cMAE		 				:= AllTrim(upper(aBuffer[28]))
			cTIPO_MOVIMENTO				:= AllTrim(aBuffer[29])
			cDT_MOVIMENTO  				:= aBuffer[30]
			cDT_EFEITO					:= aBuffer[31]
			cDATA_COBERTURA	 			:= aBuffer[32]
			cCD_PLANO					:= aBuffer[33]
			cDS_PLANO					:= upper(aBuffer[34])
			cCARENCIA					:= aBuffer[35]
			cCD_CNPJ					:= '4218217000084'//aBuffer[36]
			cDATA_HORA					:= aBuffer[37]
			//		cQTD						:= aBuffer[38]
			//		cMOTIVO						:= aBuffer[38]
			cMOTIVO						:= ""//aBuffer[38]

			//** FIM DA CARGA DE VARIAVEIS DO VETOR DE LINHA **//

			M->PBT_OPER		:= cTIPO_MOVIMENTO
			M->PBT_LINHA  	:= SubStr(cBuffer, 1,1000)  //Linha
			If PBT->(FieldPos("PBT_DATGER")) > 0
				M->PBT_DATGER := SubStr(cDATA_HORA,1,10)  //Data da geracao do Arquivo
			EndIf
			If PBT->(FieldPos("PBT_HORGER")) > 0
				M->PBT_HORGER := SubStr(cDATA_HORA,12,5)  //Hora da geracao do Arquivo
			EndIf

			nNumLin += 1

			/*INICIO DE GRAVACAO EM PBU (DETALHE)*/
			PBU->(RecLock("PBU",.T.))

			PBU->PBU_OPER   := cTIPO_MOVIMENTO//M->PBT_OPER
			PBU->PBU_SEQUEN := M->PBT_SEQUEN
			PBU->PBU_NUMLIN := StrZero(nNumLin,6,0)

			If cTIPO_REGISTRO $ '0|1|2'
				PBU->PBU_FUNC	:= cCPF
				PBU->PBU_CDBENE	:= 'T'			//Condicao do Beneficario
			ElseIf cTIPO_REGISTRO $ '3'
				PBU->PBU_FUNC	:= cCPF_SEGURADO
				PBU->PBU_CDBENE	:= 'D'			//Condicao do Beneficario
			EndIf

			PBU->PBU_DEPEND	:= ''
			PBU->PBU_BENEF	:= STRTRAN(cNOME,"'","")
			PBU->PBU_NOMSOC	:= cNOMESOCIAL
			PBU->PBU_IDGPF	:= ''
			PBU->PBU_IDCONV	:= ''
			PBU->PBU_IDDEP	:= ''
			PBU->PBU_DTNASC	:= iif(substr(cDTNASC,5,1) == "-", substr(cDTNASC,9,2)+'/'+substr(cDTNASC,6,2)+'/'+substr(cDTNASC,1,4), cDTNASC )// MARCELA - FEITO POIS QUANDO ABERTO NO EXCEL MUDA O PADRAO DE DATA
			PBU->PBU_UFNASC	:= ''
			PBU->PBU_TPDOC	:= ''
			PBU->PBU_NRODOC	:= ''
			PBU->PBU_TPPARE	:= cPARENTESCO
			PBU->PBU_TPREGI	:= cTIPO_REGISTRO
			PBU->PBU_TPBENE	:= ''			//Tipo do Beneficiario

			PBU->PBU_SEXO	:= cSEXO		// Sexo Beneficiario
			PBU->PBU_ESTCIV	:= cESTCIVIL	// Estado Civil do Beneficiario
			PBU->PBU_CPF 	:= cCPF			// Numero CPF com DV do Beneficiario
			PBU->PBU_PIS	:= ''			// Numero PIS com DV do Beneficiario
			PBU->PBU_BANCO	:= ''			// Codigo do Banco
			PBU->PBU_AGENC	:= ''			// Codigo da Agencia
			PBU->PBU_NUMCC	:= ''			// Numero da Conta Corrente
			PBU->PBU_DTADMI	:= ''			//Data de Admissao

			If cTIPO_MOVIMENTO == '3'
				PBU->PBU_DTDESL := iif(substr(cDATA_COBERTURA,5,1) == "-", substr(cDATA_COBERTURA,9,2)+'/'+substr(cDATA_COBERTURA,6,2)+'/'+substr(cDATA_COBERTURA,1,4), cDATA_COBERTURA )// MARCELA - FEITO POIS QUANDO ABERTO NO EXCEL MUDA O PADRAO DE DATA		// Data de Desligamento do Beneficiario
			EndIf

			PBU->PBU_NOMMAE	:= cMAE			//Nome da Mae do beneficiario
			PBU->PBU_CONTR := ''

			If cTIPO_MOVIMENTO == '1' .or. cTIPO_MOVIMENTO == '0'
				//If cTIPO_MOVIMENTO == '1'
				PBU->PBU_DTINCT	:= iif(substr(cDATA_COBERTURA,5,1) == "-", substr(cDATA_COBERTURA,9,2)+'/'+substr(cDATA_COBERTURA,6,2)+'/'+substr(cDATA_COBERTURA,1,4), cDATA_COBERTURA )    //Dt Inicio Contrato
			EndIf



			PBU->PBU_FILIT := ''
			PBU->PBU_PADRAO := cCD_PLANO		//Codigo do Plano na Prefeitura

			If cTIPO_MOVIMENTO <> '3'
				PBU->PBU_DTINPD	:= iif(substr(cDATA_COBERTURA,5,1) == "-", substr(cDATA_COBERTURA,9,2)+'/'+substr(cDATA_COBERTURA,6,2)+'/'+substr(cDATA_COBERTURA,1,4), cDATA_COBERTURA )
			EndIf

			If cTIPO_MOVIMENTO == '3'
				PBU->PBU_DTFIPD := iif(substr(cDATA_COBERTURA,5,1) == "-", substr(cDATA_COBERTURA,9,2)+'/'+substr(cDATA_COBERTURA,6,2)+'/'+substr(cDATA_COBERTURA,1,4), cDATA_COBERTURA )		//Dt Fim Padrao
			EndIf

			PBU->PBU_DTBASE := ''		//Base de Calculo
			PBU->PBU_CODEMP := M->PBT_CODEMP	//Codigo Empresa
			PBU->PBU_NOMEMP	:= POSICIONE("BG9",1,xFilial("BG9")+PLSINTPAD()+M->PBT_CODEMP,"BG9_DESCRI")	//Nome Empresa
			PBU->PBU_CODLOT	:= ''		//Codigo Lotacao
			PBU->PBU_ORGAO	:= ''		//Orgao Funcionario
			PBU->PBU_UFLOT	:= ''		//UF Lotacao
			PBU->PBU_CDUNI	:= ''		//CDUNIREG

			If cTIPO_MOVIMENTO == '3'
				PBU->PBU_DTEXC	:= iif(substr(cDATA_COBERTURA,5,1) == "-", substr(cDATA_COBERTURA,9,2)+'/'+substr(cDATA_COBERTURA,6,2)+'/'+substr(cDATA_COBERTURA,1,4), cDATA_COBERTURA )		//Data Exclusao   - Data de Exclusao do Plano
				PBU->PBU_MOTEXC	:= '????'				//Motivo Exclusao - Motivo da Exclusao do Plano
			EndIf

			If cTIPO_MOVIMENTO $ '1' //'0_1'  ///REVER: ESPELHO NAO INCLUIRA
				PBU->PBU_DTINCO := DTOS(dDatabase)		//Data Inclusao OPeradora   //Data da Operacao do Registro pela Operadora
			EndIf

			PBU->PBU_INDENV	:= ''		//Envio Inform. - Indicador Envio de Informacoes I-Interno ou C-Correio
			PBU->PBU_LOGRAD	:= cNOMELOGENDER		//Logradouro - Logradourodo
			PBU->PBU_NUMERO	:= cNUMENDER			//Numero - Numero do Logradouro
			PBU->PBU_COMPLE	:= cCOMPLENDER			//Complemento
			PBU->PBU_BAIRRO	:= cBAIRROENDER			//Bairro
			PBU->PBU_CEP	:= cCEPENDER			//CEP
			PBU->PBU_CIDADE	:= cCIDADEENDER			//Cidade
			PBU->PBU_UF		:= cUFENDER				//UF

			cTmpDDD 		:= ''
			cTmpCodMun		:= Posicione("BC9",1,xFilial("BC9")+trim(aBuffer[22]),"BC9_CODMUN")

			If !Empty(cTmpCodMun)
				cTmpDDD := Posicione("BID",1,xFilial("BID")+trim(cTmpCodMun),"BID_YDDD")
				PBU->PBU_DDDRES	:= cTmpDDD					//DDD da Residencia
				PBU->PBU_DDDCOM	:= cTmpDDD					//DDD Telefone Comercial
			EndIf

			PBU->PBU_TELRES	:= cTELEFONE			//Telefone Residencial
			PBU->PBU_TELCOM	:= cTX_TEL_COMERCIAL	//Telefone Comercial
			PBU->PBU_RAMAL	:= ''					//Ramal
			PBU->PBU_DDDCEL	:= ''					//DDD Celular
			PBU->PBU_TELCEL	:= cNUMTEL_CELULAR		//Celular
			PBU->PBU_EMAIL	:= cTX_EMAIL			//Email
			PBU->PBU_NROCNS	:= cNR_CNS              //Numero Cartao Nacional de Saude
			PBU->PBU_DENAVI	:= cNR_DECLARACAONASCIDOVIVO  //Numero da Declaracao de Nascido vivo(Nascidos a partir de 1 de Janeiro de 2010)

			If cTIPO_MOVIMENTO == '2'
				PBU->PBU_FUNANT	:= ''   //Funcional Aterior
				PBU->PBU_INDTRA	:= ''  //Indicador de Transferencia
				PBU->PBU_DTTRAN	:= ''  //Data da Transferencia
				PBU->PBU_PADANT	:= ''  //Codigo Padrao anterior
			EndIf

			//		PBU->PBU_OUTROS := SubStr(cBuffer,735,46)  //Outros   (Desabilitado pelo Itau)
			PBU->PBU_CIDORG	:= ''  				//Nome da Cidade do Orgao
			PBU->PBU_PADTIT	:= ''  				//Codigo do Padrao do Beneficiario
			PBU->PBU_ESTCVT	:= cESTCIVIL		//Estado Civil do Titular
			PBU->PBU_CODSUB	:= ''				//Codigo do Subsidio - uso interno nas Caixas/Fundacao
			PBU->PBU_INDCAR	:= cCARENCIA  //Indicador de Carencia
			PBU->PBU_CODSRV	:= ''  //codigo do Servico solicitado
			PBU->PBU_CODLAY	:= ''  //codigo layout
			PBU->PBU_CDSRV1	:= ''  //Codigo Servico
			PBU->PBU_SITEST	:= ''  //Indicador de Estudante universitario
			PBU->PBU_DEPINV	:= ''  //Indicador de dependencia Invalido
			PBU->PBU_ASSMED	:= ''  //Indicador assistencia medica emergencial
			PBU->PBU_TPASSI	:= ''  //Tipo Assistencia Saude
			PBU->PBU_DOCIDE	:= ''  //Documento Identidade
			PBU->PBU_ORGEXP	:= ''  //Orgao Expedidor documento Identidade
			PBU->PBU_PAISEX	:= ''  //Pais do Orgao Emissor documento Identidade
			PBU->PBU_CDORGL	:= ''  //Codigo Orgao Lotacao
			PBU->PBU_EMPCOL	:= ''  //Indicador Origem empresa colaborador
			PBU->PBU_SEQREG	:= ''  //Sequencia de ordem  (O Itau Nao esta enviando este registro no novo layout)
			//		PBU->PBU_TABERR := SubStr(cBuffer,941,60)  //Tabela de Erro

			cAcao := ""

			PBU->PBU_OPERSI := cTIPO_MOVIMENTO //VEROPER(@cAcao)
			/*
			Do Case

			Case cTIPO_MOVIMENTO == "0"
			cAcao := "Arquivo Espelho"

			Case cTIPO_MOVIMENTO == "1"
			cAcao := "Inclusao no Plano"

			Case cTIPO_MOVIMENTO == "2"
			cAcao := "Alteracoes / Transferencias"

			Case cTIPO_MOVIMENTO == "3"
			cAcao := "Exclusao Plano"

			Otherwise
			cAcao := "Acao Inesperada!!! Rever coluna de Tipo de Movimento na Planilha"

			EndCase
			*/
			PBU->PBU_DESOPE := cMOTIVO

			PBU->PBU_IDLOGR := ''
			PBU->PBU_CODLOG := ''
			PBU->PBU_MUNLOG := ''
			PBU->PBU_ENDLOG := ''
			PBU->PBU_COMLOG := ''
			PBU->PBU_BAILOG := ''
			PBU->PBU_CITLOG := ''
			PBU->PBU_ESTLOG := ''

			FT_FSKIP()

			PBU->(MsUnlock())
			/*FIM DE GRAVACAO EM PBU (DETALHE)*/

			nRet++
		Enddo

		FT_FUSE()

		*'********************************************************************************************************'*
		*'FIM LAYOUT 1
		*'********************************************************************************************************'*

		//********************************************************************************************************'*
		//INICIO LAYOUT 2
		//********************************************************************************************************'*

	ElseIf M->PBT_LAYOUT == '2'

		M->PBT_OPER		:= val(Substr(cBuffer,  3, 2))
		M->PBT_LINHA  	:= SubStr(cBuffer, 1,1004)  //Linha

		If PBT->(FieldPos("PBT_DATGER")) > 0
			M->PBT_DATGER := SubStr(cBuffer,97,10)  //Data da geracao do Arquivo
		EndIf
		If PBT->(FieldPos("PBT_HORGER")) > 0
			M->PBT_HORGER := SubStr(cBuffer,107,6)  //Hora da geracao do Arquivo
		EndIf

		n_TotLin := FT_FLASTREC()
		c_QtdLin := AllTrim(Transform(n_TotLin,'@E 999,999,999'))

		ProcRegua(n_TotLin)

		nNumLin := 0

		While !FT_FEOF()

			IncProc('Processando linha ' + AllTrim(Transform(++n_QtdLin,'@E 999,999,999')) + ' de ' + c_QtdLin) //incrementa a regua de processamento...

			cBuffer := AllTrim(FT_FREADLN())

			cNumLin := Substr(cBuffer,894,6)

			If Substr(cBuffer,1,1) $ '0|9'

				FT_FSKIP()
				Loop

			EndIf

			//-------------------------------------------------------------------
			//Angelo Henrique - Data: 18/02/2016
			//Caso esteja em branco a linha irá pular pois estava dando erro
			//-------------------------------------------------------------------
			If Empty(cBuffer)

				FT_FSKIP()
				Loop

			EndIf

			c_EstCiv := SubStr(cBuffer,163,1)
			c_RETEC := ""

			If c_EstCiv == "S"
				c_RETEC	:=	"S"
			ElseIf ZZ1->ZZ1_ESTCIV == "C"
				c_RETEC	:=	"C"
			ElseIf ZZ1->ZZ1_ESTCIV == "R"
				c_RETEC	:=	"D"
			ElseIf ZZ1->ZZ1_ESTCIV == "V"
				c_RETEC	:=	"V"
			ElseIf ZZ1->ZZ1_ESTCIV == "M"
				c_RETEC	:=	"M"
			ElseIf ZZ1->ZZ1_ESTCIV == "J"
				c_RETEC	:=	"Q"
			EndIf

			nNumLin += 1

			PBU->(RecLock("PBU",.T.))
			// marcela coimbra 28/05/2015 - PBU->PBU_OPER   := val(Substr(cBuffer,  3, 2))
			PBU->PBU_OPER   := ' ' + Substr(cBuffer,  4, 1)
			PBU->PBU_SEQUEN := M->PBT_SEQUEN
			PBU->PBU_NUMLIN := StrZero(nNumLin,6,0)
			PBU->PBU_FUNC   := Substr(cBuffer,5,9)
			PBU->PBU_DEPEND := Substr(cBuffer,14,2)
			PBU->PBU_BENEF  := SubStr(cBuffer,16, 80)
			PBU->PBU_IDGPF  := SubStr(cBuffer,96,10)		//brancos
			PBU->PBU_IDCONV := SubStr(cBuffer,106,15)		//brancos
			PBU->PBU_IDDEP  := SubStr(cBuffer,121,4)		//brancos

			PBU->PBU_DTNASC := SubStr(cBuffer,125,10)
			PBU->PBU_UFNASC := SubStr(cBuffer,135,2)

			PBU->PBU_TPDOC  := SubStr(cBuffer,137,3)
			PBU->PBU_NRODOC := SubStr(cBuffer,140,15)

			PBU->PBU_TPPARE := SubStr(cBuffer,155,4)

			PBU->PBU_TPBENE := substr(cBuffer,159,2)            //Tipo do Beneficiario

			PBU->PBU_CDBENE := iif(SubStr(cBuffer,161,1) == 'T', 'T','D')            //Condicao do Beneficario

			PBU->PBU_SEXO 	:= SubStr(cBuffer,162,1)              // Sexo Beneficiario

			PBU->PBU_ESTCIV := c_RETEC// MBC SubStr(cBuffer,163,1)            // Estado Civil do Beneficiario

			PBU->PBU_CPF 	:= SubStr(cBuffer,164,11)              // Numero CPF com DV do Beneficiario Titular

			PBU->PBU_PIS 	:= SubStr(cBuffer,175,11)              // Numero PIS com DV do Beneficiario Titular

			PBU->PBU_BANCO  := SubStr(cBuffer,186,3)           // Codigo do Banco Titular

			PBU->PBU_AGENC  := SubStr(cBuffer,189,4)            // Codigo da Agencia Titular

			PBU->PBU_NUMCC  := SubStr(cBuffer,193,11)           // Numero da Conta Corrente Titutar

			// Data de Adminssao do Beneficiario Titular na Empresa
			PBU->PBU_DTADMI := SubStr(cBuffer,204,10)    //Ctod(SubStr(cBuffer, 204,2)+"/"+SubStr(cBuffer,207,2)+"/"+SubStr(cBuffer, 210,4))

			// Data de Desligamento do Beneficiario Titular na Empresa
			PBU->PBU_DTDESL := SubStr(cBuffer,214,10)   //Ctod(SubStr(cBuffer, 214,2)+"/"+SubStr(cBuffer,216,2)+"/"+SubStr(cBuffer, 218,4))

			PBU->PBU_NOMMAE := Upper(AllTrim(SubStr(cBuffer,224,60)))    //Nome da Mae do beneficiario

			PBU->PBU_CONTR 	:= AllTrim(SubStr(cBuffer,284,5))

			PBU->PBU_DTINCT := SubStr(cBuffer,289,10)    //Ctod(SubStr(cBuffer,289,2)+"/"+SubStr(cBuffer,291,2)+"/"+SubStr(cBuffer, 293,4)) //Dt Inicio Contrato

			PBU->PBU_FILIT  := SubStr(cBuffer,299,5)

			PBU->PBU_PADRAO := SubStr(cBuffer,775,4)

			PBU->PBU_DTINPD := SubStr(cBuffer,308,10)    //Ctod(SubStr(cBuffer,308,2)+"/"+SubStr(cBuffer,310,2)+"/"+SubStr(cBuffer,312,4)) //Dt Inicio Padrao

			PBU->PBU_DTFIPD := SubStr(cBuffer,318,10)    //Ctod(SubStr(cBuffer,318,2)+"/"+SubStr(cBuffer,320,2)+"/"+SubStr(cBuffer,322,4)) //Dt Fim Padrao

			PBU->PBU_DTBASE := SubStr(cBuffer,328,11)     //Ctod(SubStr(cBuffer,328,2)+"/"+SubStr(cBuffer,330,2)+"/"+SubStr(cBuffer,332,4)) //Base de Calculo

			PBU->PBU_CODEMP := SubStr(cBuffer,339,4) //Codigo Empresa

			PBU->PBU_NOMEMP := SubStr(cBuffer,343,30) //Nome Empresa

			PBU->PBU_CODLOT := SubStr(cBuffer,373,17) //Codigo Lotacao

			PBU->PBU_ORGAO  := SubStr(cBuffer,390,30) //Orgao Funcionario

			PBU->PBU_UFLOT  := SubStr(cBuffer,420,2) //UF Lotacao

			PBU->PBU_CDUNI  := SubStr(cBuffer,422,3)     //CDUNIREG

			PBU->PBU_DTEXC  := SubStr(cBuffer,425,10)   //Data Exclusao   - Data de Exclusao do Plano             //Ctod(SubStr(cBuffer,425,2)+"/"+SubStr(cBuffer,425,2)+"/"+SubStr(cBuffer,425,4)) //Data Exclusao
			PBU->PBU_MOTEXC := SubStr(cBuffer,435,3)   //Motivo Exclusao - Motivo da Exclusao do Plano

			//Data Inclusao OPeradora   //Data da Operacao do Registro pela Operadora
			PBU->PBU_DTINCO := SubStr(cBuffer,438,10)   //Ctod(SubStr(cBuffer,438,2)+"/"+SubStr(cBuffer,440,2)+"/"+SubStr(cBuffer,442,4)) //Dt Inclusao Oper.

			PBU->PBU_INDENV := SubStr(cBuffer,448,1)    //Envio Inform. - Indicador Envio de Informacoes I-Interno ou C-Correio

			PBU->PBU_LOGRAD := SubStr(cBuffer,449,50) //Logradouro - Logradourodo Titular
			PBU->PBU_NUMERO := SubStr(cBuffer,499,5)  //Numero - Numero do Logradouro do Titular

			PBU->PBU_COMPLE := SubStr(cBuffer,504,10) //Complemento
			PBU->PBU_BAIRRO := SubStr(cBuffer,514,40) //Bairro
			PBU->PBU_CEP    := SubStr(cBuffer,554,9)  //CEP

			PBU->PBU_CIDADE := SubStr(cBuffer,563,40)  //Cidade

			PBU->PBU_UF 	:= SubStr(cBuffer,603,2)  //UF

			PBU->PBU_DDDRES := SubStr(cBuffer,605,4)  //DDD da Residencia
			PBU->PBU_TELRES := SubStr(cBuffer,609,8)  //Telefone Residencial

			PBU->PBU_DDDCOM := SubStr(cBuffer,617,4)  //DDD Telefone Comercial
			PBU->PBU_TELCOM := SubStr(cBuffer,621,8)  //telefona Comercial

			PBU->PBU_RAMAL 	:= SubStr(cBuffer,629,5)  //Ramal

			PBU->PBU_DDDCEL := SubStr(cBuffer,634,4)  //DDD Celular
			PBU->PBU_TELCEL := SubStr(cBuffer,638,8)  //Celular

			PBU->PBU_EMAIL 	:= SubStr(cBuffer,646,80)  //Email

			PBU->PBU_FUNANT := SubStr(cBuffer,726,9)   //Funcional Aterior
			//		PBU->PBU_OUTROS := SubStr(cBuffer,735,46)  //Outros   (Desabilitado pelo Itau)

			PBU->PBU_CIDORG := SubStr(cBuffer,735,40)  //Nome da Cidade do Orgao
			PBU->PBU_PADTIT := SubStr(cBuffer,775,4)  //Codigo do Padrao do Beneficiario Titular
			PBU->PBU_ESTCVT := SubStr(cBuffer,779,1)  //Estado Civil do Titular
			PBU->PBU_CODSUB := SubStr(cBuffer,780,1)  //Codigo do Subsidio - uso interno nas Caixas/Fundacao
			PBU->PBU_INDCAR := SubStr(cBuffer,781,1)  //Indicador de Carencia
			PBU->PBU_INDTRA := SubStr(cBuffer,782,1)  //Indicador de Transferencia
			PBU->PBU_DTTRAN := SubStr(cBuffer,783,10)  //Data da Transferencia
			PBU->PBU_ASSMED := SubStr(cBuffer,1004,1)  //Indicador assistencia medica emergencial

			cAcao := ""

			PBU->PBU_OPERSI := ' ' + Substr(cBuffer,4,1) //VEROPER(@cAcao)

			Do Case

				Case val(Substr(cBuffer,3,2)) == 0
				cAcao := "Arquivo Espelho"

				Case val(Substr(cBuffer,3,2)) == 1
				cAcao := "Inclusao no Plano"

				Case val(Substr(cBuffer,3,2)) == 2
				cAcao := "Alteracoes / Transferencias"

				Case val(Substr(cBuffer,3,2)) == 3
				cAcao := "Exclusao Plano"

				Otherwise
				cAcao := "Acao Inesperada!!! Rever coluna de Tipo de Movimento na Planilha"
			EndCase

			PBU->PBU_DESOPE := cAcao

			PBU->PBU_PLAODO := Substr(cBuffer,1005,4)

			//-------------------------------------------------------------------------------------------------
			//Angelo Henrique - Data: 23/02/2016
			//-------------------------------------------------------------------------------------------------
			//Após comunicado da ANS a informação do CNS passou a ser obrigatório, logo os arquivos
			//oriundos deste layout passaram a receber a informação do CNS
			//Posição 1009 do arquivo, tamanho do CNS 15
			//-------------------------------------------------------------------------------------------------

			PBU->PBU_NROCNS := Substr(cBuffer,1009,15) //Numero Cartao Nacional de Saude

			//-------------------------------------------------------------------------------------------------

			//PBU->PBU_OPERSI := VEROPER(@cAcao)
			//PBU->PBU_DESOPE := cAcao

			PBU->(MsUnlock())

			nRet++

			FT_FSKIP()

		Enddo
		FT_FUSE()

	EndIf

	//********************************************************************************************************'*
	//FIM LAYOUT 2
	//********************************************************************************************************'*

	COPY FILE &cFile TO &cFileDest

	// Apaga fisicamente arquivo da pasta de origem apos ser copiado.
	fErase(cFile)

Return(nRet)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ CAB336CRI  ³ Autor ³ Bianchini/Marcela ³ Data ³ 16.05.2006 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Critica Arquivo ja importado                               ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function CAB336CRI(c_Alias, n_Reg, n_Opc)

	Processa({||PCAB336CRI(c_Alias, n_Reg, n_Opc)},'Criticando arquivo...')

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ PCAB336CRI ³ Autor ³ Bianchini/Marcela ³ Data ³ 16.05.2006 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Rotina de criticas                                         ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function PCAB336CRI(cAlias, nReg, nOpc)

	Local aCampos 		:= {}
	Local l1vez   		:= .F.
	Local nSeqErro 		:= 0
	Local cSeq     		:= 0
	Local cErro 		:= space(0)
	Local aErro 		:= {}
	Local aArqErro 		:= {}
	Local cSql 			:= ""
	Local cTipCri 		:= ""
	Local aChkPadrao 	:= {}
	Local lVerEmp 		:= .F.
	Local nElemento 	:= 0
	Local aVerEmp 		:= {}
	Local n				:= 0
	Local nI			:= 0
	Local nCriticados	:= 0
	Local cUpdOper		:= ''
	Local lAchouCrit	:= .F.
	Local _cMsg			:= "" //Angelo Henrique - Data: 29/02/2016
	Local _cSubcon		:= "" //Angelo Henrique - Data: 08/08/2016
	Local _lTrns		:= .T.	

	Private cCodOpe 	:= AllTrim(PBT->PBT_CODOPE)
	Private cCodEmp 	:= AllTrim(PBT->PBT_CODEMP)
	Private l_PlaIg 	:= .F.

	ProcRegua(0)

	For nI := 1 to 5
		IncProc('Aguarde...')
	Next

	If PBT->PBT_STATUS $ '1|2|3' //Permite criticar arquivos importados e/ou criticados

		//Leonardo Portella - 09/06/15 - Inicio - Temporario - O tipo de operacao espelho (0)
		//esta sendo tratado como inclusao (1) conforme informado pela Marcia.
		//Tem que ser fora do While principal pois o PBU_OPER faz parte do indice e altera-lo
		//enquanto percorre faz com que o sistema se perca

		cUpdOper := "UPDATE " + RetSqlName('PBU') 					+ CRLF
		cUpdOper += "  SET PBU_OPER = '1'" 							+ CRLF
		cUpdOper += "WHERE PBU_FILIAL = '" + xFilial("PBU") + "'" 	+ CRLF
		cUpdOper += "  AND PBU_SEQUEN = '" + PBT->PBT_SEQUEN + "'" 	+ CRLF
		cUpdOper += "  AND PBU_OPER = '0'" 							+ CRLF
		cUpdOper += "  AND D_E_L_E_T_ = ' '" 						+ CRLF

		If TcSqlExec(cUpdOper) < 0
			MsgStop("Falha na atualização PBU_OPER [ " + TcSqlError() + " ]",AllTrim(SM0->M0_NOMECOM))
			Return
		Endif

		//Leonardo Portella - 09/06/15 - Fim - Temporario

		PBU->(DbSetOrder(2))

		If PBU->(DbSeek(xFilial("PBU")+PBT->PBT_SEQUEN))

			BEGIN TRANSACTION

				cSQL := "DELETE FROM " + RetSQLName("PBV")+" "
				cSQL += "WHERE PBV_SEQUEN = '"+PBT->PBT_SEQUEN+"' AND D_E_L_E_T_ = ' '"

				PLSSQLEXEC(cSQL)

			END TRANSACTION

			cCodOpe := AllTrim(PBT->PBT_CODOPE)
			cCodEmp := AllTrim(PBT->PBT_CODEMP)

			While !PBU->(EOF()) .and. ( PBU->PBU_SEQUEN == PBT->PBT_SEQUEN )

				nCriticados++

				aErro 		:= {}
				cErro 		:= Space(0)
				cDescr 		:= Space(0)
				cCtrProc 	:= "S"

				lVerEmp 	:= .F.
				nElemento 	:= aScan(aVerEmp,{ |x| AllTrim(x[1]) == AllTrim(PBU->PBU_CODEMP) })

				If nElemento > 0
					lVerEmp := .T.
				EndIf

				If At(AllTrim(PBU->PBU_OPER),'1|2|3|4') == 0
					cCtrProc 	:= "E"
					cErro 		:= cErro + "001"   //Tipo Operacao Invalido
					aAdd(aErro, {PBT->PBT_SEQUEN, PBU->PBU_NUMLIN, "001", "Tipo Operacao Invalido","E"})
				EndIf

				If Type(PBU->PBU_FUNC) <> 'N'
					cCtrProc 	:= "E"
					cErro 		:= cErro + "002"  //Funcional Invalida
					aAdd(aErro, {PBT->PBT_SEQUEN, PBU->PBU_NUMLIN, "002", "Funcional Invalida","E"})
				EndIf

				If (AllTrim(PBU->PBU_OPER) $ '2|3|4') .and. VerFunc(PBT->PBT_CODEMP,PBU->PBU_FUNC + '-' + PBU->PBU_CPF ,PBU->PBU_CDBENE)//M
					cCtrProc 	:= "E"
					cErro 		:= cErro + "003"   //Funcional nao existe na Base
					aAdd(aErro, {PBT->PBT_SEQUEN, PBU->PBU_NUMLIN, "003", "Funcional nao existe na Base","E"})
				EndIf

				If (AllTrim(PBU->PBU_OPER) $ '1') .and. VerFunc(PBT->PBT_CODEMP,PBU->PBU_FUNC + '-' + PBU->PBU_CPF,PBU->PBU_CDBENE)
					cCtrProc := "E"
					cErro := cErro + "004"   //Funcional Ja existe na Base
					aAdd(aErro, {PBT->PBT_SEQUEN, PBU->PBU_NUMLIN, "004", "Funcional Ja Existente na Base","E"})
				EndIf

				If Empty(AllTrim(PBU->PBU_BENEF))
					cCtrProc := "E"
					cErro := cErro + "006"  //Nome do Beneficiario Invalido
					aAdd(aErro, {PBT->PBT_SEQUEN, PBU->PBU_NUMLIN, "006", "Nome do Beneficiario Invalido","E"})
				EndIf

				If Empty(PBU->PBU_DTNASC) .or. ( CtoD(PBU->PBU_DTNASC) == StoD(' ') )
					cCtrProc := "E"
					cErro := cErro + "009" //Data de Nascimento Invalida
					aAdd(aErro, {PBT->PBT_SEQUEN, PBU->PBU_NUMLIN, "009", "Data de Nascimento Invalido","E"})
				EndIf

				If PBU->PBU_CDBENE <> 'T' .and. At(AllTrim(PBU->PBU_TPPARE),If( PBT->PBT_LAYOUT == '1', '02_03_04_05_06_11_14_15_17_18_23', 'O_E_L_C_M_F_I_T_F_P')) == 0
					cCtrProc := "E"
					cErro := cErro + "012"   //Tipo Parentesco Invalido
					aAdd(aErro, {PBT->PBT_SEQUEN, PBU->PBU_NUMLIN, "012", "Tipo Parentesco Invalido","E"})
				EndIf

				If At(AllTrim(PBU->PBU_CDBENE),'T_D_A_L') == 0
					cCtrProc := "E"
					cErro := cErro + "014"  //Condicao Beneficiario Invalido
					aAdd(aErro, {PBT->PBT_SEQUEN, PBU->PBU_NUMLIN, "014", "Condicao Beneficiario Invalido","E"})
				EndIf

				If At(AllTrim(PBU->PBU_SEXO),'F_M') == 0
					cCtrProc := "E"
					cErro := cErro + "015"   //Sexo Invalido
					aAdd(aErro, {PBT->PBT_SEQUEN, PBU->PBU_NUMLIN, "015", "Sexo Invalido","E"})
				EndIf

				If At(AllTrim(PBU->PBU_ESTCIV),If( PBT->PBT_LAYOUT == '1', 'C_Q_D_S_M_V_O_T', 'C||D||M||O||Q||S||V')) == 0
					cCtrProc := "E"
					cErro := cErro + "016"  //Estado civil invalido
					aAdd(aErro, {PBT->PBT_SEQUEN, PBU->PBU_NUMLIN, "016", "Estado civil invalido","W"})
				EndIf

				If  AllTrim(PBU->PBU_OPER) $ '1|2' .and. ;
				( u_nCalcIdade(CtoD(PBU->PBU_DTNASC)) >= 18 ) .and. ;
				( Empty(PBU->PBU_CPF) .or. !CGC(PBU->PBU_CPF,,.F.)/*!chkCPF(PBU->PBU_CPF)*/ )

					cCtrProc := "E"
					cErro := cErro + "017"   //CPF Invalido
					aAdd(aErro, {PBT->PBT_SEQUEN, PBU->PBU_NUMLIN, "017", "CPF Maior 18 Invalido","E"})
				EndIf

				If 	AllTrim(PBU->PBU_OPER) <> "3" .and. ;
				( Empty(AllTrim(PBU->PBU_DTINPD)) .or. CtoD(PBU->PBU_DTINPD) == StoD(' ') )

					cCtrProc := "E"
					cErro := cErro + "034"   //Data Inclusao Invalida
					aAdd(aErro, {PBT->PBT_SEQUEN, PBU->PBU_NUMLIN, "034", "Data Inclusao Invalida","E"})
				EndIf

				If 	AllTrim(PBU->PBU_OPER) $ '1|2' .and. ;
				!chkLogradouro(AllTrim(PBU->PBU_LOGRAD),AllTrim(PBU->PBU_NUMERO),'T')

					cCtrProc := "E"
					cErro := cErro + "038"   //Logradouro Invalido
					aAdd(aErro, {PBT->PBT_SEQUEN, PBU->PBU_NUMLIN, "038", "Logradouro Invalido","E"})
				EndIf

				If !chkCEP(PBU->PBU_CEP)
					cCtrProc := "E"
					cErro := cErro + "039"  //CEP Invalido
					aAdd(aErro, {PBT->PBT_SEQUEN, PBU->PBU_NUMLIN, "039", "CEP Invalido","E"})
				EndIf

				If 	( AllTrim(PBU->PBU_OPER) $ '1' ) .and. ;
				ChkPBUQtdCPF(AllTrim(PBU->PBU_OPER),PBU->PBU_SEQUEN,PBU->PBU_CPF,'03')

					cCtrProc := "E"
					cErro := cErro + "068"  //Maiores de 18 anos c/CPF Dupl. no Arq.de Imp.
					aAdd(aErro, {PBT->PBT_SEQUEN, PBU->PBU_NUMLIN, "068", "Maiores de 18 anos c/CPF Dupl. no Arq.de Imp.",cCtrProc})
				EndIf

				If 	AllTrim(PBU->PBU_OPER) $ '1' .and. ;
				!ExeBA1PBU(PBU->PBU_FUNC,'T',AllTrim(PBU->PBU_OPER),PBU->PBU_SEQUEN)

					cCtrProc := "E"
					cErro := cErro + "069"   //Depdt. s/ Tit.(Base ou Arquivo)
					aAdd(aErro, {PBT->PBT_SEQUEN, PBU->PBU_NUMLIN, "069", "Depdt. s/ Tit.(Base ou Arquivo)",cCtrProc})
				EndIf

				If 	AllTrim(PBU->PBU_OPER) $ '1' .and. ;
				chkCriTit(AllTrim(PBU->PBU_OPER),PBU->PBU_SEQUEN,PBU->PBU_FUNC,'T')

					cCtrProc := "E"
					cErro := cErro + "070"   //Depdt. c/ Titular Criticado no Arquivo
					aAdd(aErro, {PBT->PBT_SEQUEN, PBU->PBU_NUMLIN, "070", "Depdt. c/ Titular Criticado no Arquivo",cCtrProc})
				EndIf

				If 	( AllTrim(PBT->PBT_SEQUEN) == AllTrim(PBU->PBU_SEQUEN) .and. ;
				AllTrim(PBT->PBT_CODEMP) <> AllTrim(PBU->PBU_CODEMP) )

					cCtrProc 	:= "E"
					cErro 		:= cErro + "071"   //Cod Empresa Divergente entre Parametro e Arquivo Importado
					aAdd(aErro, {PBT->PBT_SEQUEN, PBU->PBU_NUMLIN, "071", "Cod Emp. Diverge no Param. e Arq.Importado",cCtrProc})
				EndIf

				//Leonardo Portella - 09/06/15 - Inicio - Emergencial - Tipreg vazio na mesma familia
				//estourando erro e parando o processamento

				If AllTrim(PBU->PBU_CDBENE) <> 'T'

					aArTpReg	:= GetArea()
					aArTpRegBA1	:= BA1->(GetArea())
					cMatEmpTpRg	:= AllTrim(PBU->PBU_FUNC)
					cMatChv		:= ''

					BA1->(DbSetOrder(6))

					If BA1->( DbSeek(xFilial('BA1') + cMatEmpTpRg ))

						While !BA1->(EOF()) .and. ( Left(BA1->BA1_MATEMP,len(cMatEmpTpRg)) == cMatEmpTpRg )
							If cCodEmp == AllTrim(PBT->PBT_CODEMP)
								cMatChv := BA1->(BA1_FILIAL + BA1_CODINT + BA1_CODEMP + BA1_MATRIC)
								Exit
							EndIf
							BA1->(DbSkip())
						EndDo

						BA1->(DbSetOrder(1))

						If !empty(cMatChv) .and. BA1->( DbSeek(cMatChv))

							While !BA1->(EOF()) .and. ( BA1->(BA1_FILIAL + BA1_CODINT + BA1_CODEMP + BA1_MATRIC) == cMatChv )
								If empty(BA1->BA1_TIPREG)
									cCtrProc 	:= "E"
									cErro 		:= cErro + "X01"
									aAdd(aErro, {PBT->PBT_SEQUEN, PBU->PBU_NUMLIN, "X01", "TIPREG vazio", cCtrProc})
								EndIf
								BA1->(DbSkip())
							EndDo

						EndIf

					EndIf

					BA1->(RestArea(aArTpRegBA1))
					RestArea(aArTpReg)

				EndIf

				//Leonardo Portella - 09/06/15 - Fim - Emergencial

				If !(Empty(PBU->PBU_PADRAO))

					If 	( AllTrim(PBU->PBU_CDBENE) <> 'T' )

						If AllTrim(PBU->PBU_OPER) $ '1' .and. !lTitPlano(PBU->PBU_FUNC,PBU->PBU_SEQUEN,PBU->PBU_PADRAO,PBU->PBU_CODEMP,'MED')

							cCtrProc 	:= "E"
							cErro 		:= cErro + "X02"
							aAdd(aErro, {PBT->PBT_SEQUEN, PBU->PBU_NUMLIN, "X02", "Depend. s/ tit. no mesmo plano.","E"})

						EndIf

						/*						If AllTrim(PBU->PBU_OPER) $ '12' .and. ( PBT->PBT_LAYOUT == '1' ) .and. !lTitPlano(PBU->PBU_FUNC,PBU->PBU_SEQUEN,PBU->PBU_PADRAO,PBU->PBU_CODEMP,'ODO')

						cCtrProc 	:= "E"
						cErro 		:= cErro + "X03"
						aAdd(aErro, {PBT->PBT_SEQUEN, PBU->PBU_NUMLIN, "X03", "Depend. s/ tit. mesmo plano [Odonto]","E"})
						*/
					EndIf

				Else

					cCtrProc 	:= "E"
					cErro 		:= cErro + "X04"
					aAdd(aErro, {PBT->PBT_SEQUEN, PBU->PBU_NUMLIN, "X04", "Plano nao informado","E"})

				EndIf

				//If 	AllTrim(PBU->PBU_OPER) $ '12' .and. lUsuExiste(PBU->PBU_FUNC,PBU->PBU_CPF,PBU->PBU_PADRAO,PBU->PBU_CODEMP,'MED', @l_PlaIg, '000000001')
				If cCodEmp $ "0024|0027"

					_cSubcon := "000000003"

				ElseIf cCodEmp = "0025|0028"

					_cSubcon := "000000005"

				EndIf

				If 	AllTrim(PBU->PBU_OPER) $ '12' .and. lUsuExiste(PBU->PBU_FUNC,PBU->PBU_CPF,PBU->PBU_PADRAO,PBU->PBU_CODEMP,'MED', @l_PlaIg, _cSubcon)

					cCtrProc 	:= "E"
					cErro 		:= cErro + "X05"

					//------------------------------------------------------------------------------------
					//INICIO - Angelo Henrique - Data:  29/02/2016
					//Alterando a mensagem, pois estava confuso para entendimento do usuário.
					//------------------------------------------------------------------------------------
					//aAdd(aErro, {PBT->PBT_SEQUEN, PBU->PBU_NUMLIN, "X05", "Dupl. SAUDE [Func,CPF,Plano,Emp] " + iif(l_PlaIg, "Mesmo Plano", "Plano Diferente") + "","E"})

					_cMsg := ""

					_cMsg := "TRANSFERÊNCIA - Beneficiário já cadastrado, "

					If l_PlaIg

						_cMsg += "esta no mesmo plano que o informado no arquivo."

						aAdd(aErro, {PBT->PBT_SEQUEN, PBU->PBU_NUMLIN, "X05", _cMsg,"E"})

					Else

						//-------------------------------------------------------------------------------
						//Primeira validação saber se o titular esta no arquivo quando for dependente
						//-------------------------------------------------------------------------------
						_lTrns := CABA336D(PBU->PBU_SEQUEN,PBU->PBU_FUNC,PBU->PBU_CDBENE, "1")

						If !(_lTrns)

							//-----------------------------------------------------
							//Segunda validação
							//-----------------------------------------------------
							//Não achou o títular no arquivo, logo deverá 
							//validar se o titular e esta ativo na base
							//-----------------------------------------------------
							_lTrns := CABA336D(PBU->PBU_SEQUEN,PBU->PBU_FUNC,PBU->PBU_CDBENE, "2")

							If !(_lTrns)

								_cMsg += "Não foi achado o títular no arquivo para transferência e o titular esta bloqueado no sistema"

								aAdd(aErro, {PBT->PBT_SEQUEN, PBU->PBU_NUMLIN, "X05", _cMsg,"E"})

							Else

								//-----------------------------------------------------
								//Terceira validação
								//-----------------------------------------------------
								//Não achou o títular no arquivo, ele esta Ativo  								
								//no sistema e agora irá validar se esta no plano
								//em que o arquivo esta sugerindo a transferência
								//-----------------------------------------------------
								_lTrns := CABA336D(PBU->PBU_SEQUEN,PBU->PBU_FUNC,PBU->PBU_CDBENE, "3")

								If !(_lTrns)

									_cMsg += "Não foi achado o títular no arquivo para transferência " 
									_cMsg += "e no sistema esta em plano diferente do informado para transferir "

									aAdd(aErro, {PBT->PBT_SEQUEN, PBU->PBU_NUMLIN, "X05", _cMsg,"E"})

								Else

									//--------------------------------------
									//X13  - pode realizar a transferência
									//--------------------------------------
									_cMsg += "esta em plano diferente, é aconselhado realizar a transferência."
									aAdd(aErro, {PBT->PBT_SEQUEN, PBU->PBU_NUMLIN, "X13", _cMsg,"E"})

								EndIf

							EndIf

						Else

							//--------------------------------------
							//X13  - pode realizar a transferência
							//--------------------------------------
							_cMsg += "esta em plano diferente, é aconselhado realizar a transferência."
							aAdd(aErro, {PBT->PBT_SEQUEN, PBU->PBU_NUMLIN, "X13", _cMsg,"E"})

						EndIf

					EndIf

					//------------------------------------------------------------------------------------
					//FIM - Angelo Henrique - Data:  29/02/2016
					//------------------------------------------------------------------------------------

				EndIf

				//---------------------------------------------------------------------------------------
				//Não pode validar o plano para as coligadas, uma vez que elas são encaminhadas pelo CBI
				//---------------------------------------------------------------------------------------
				If cCodEmp = "0024"

					//If AllTrim(PBU->PBU_OPER) $ '12' .and. empty(ConvPlano(trim(PBU->PBU_PADRAO),'MED','C'))
					If AllTrim(PBU->PBU_OPER) $ '12' .and. Empty(ConvPlano(trim(PBU->PBU_PADRAO),Alltrim(PBU->PBU_CDBENE),1))

						cCtrProc 	:= "E"
						cErro 		:= cErro + "X07"
						aAdd(aErro, {PBT->PBT_SEQUEN, PBU->PBU_NUMLIN, "X07", "Plano informado nao localizado","E"})

					EndIf

				EndIf

				If AllTrim(PBU->PBU_OPER) $ '12' .and. !lValidMae(PBU->PBU_NOMMAE)
					cCtrProc 	:= "E"
					cErro 		:= cErro + "X08"
					aAdd(aErro, {PBT->PBT_SEQUEN, PBU->PBU_NUMLIN, "X08", "Nome da mae invalido","E"})
				EndIf

				If  AllTrim(PBU->PBU_OPER) $ '1|2' .and. ;
				!Empty(PBU->PBU_CPF) .and. ;
				!CGC(PBU->PBU_CPF,,.F.)

					//Difere da critica 017 pois valida se o CPF informado eh valido. A critica 017 so valida
					//se for maior de idade.

					cCtrProc := "E"
					cErro := cErro + "X09"
					aAdd(aErro, {PBT->PBT_SEQUEN, PBU->PBU_NUMLIN, "X09", "CPF Invalido","E"})
				End

				If AllTrim(PBU->PBU_OPER) $ '12' .and. lBA3SemSub(PBT->PBT_CODEMP,PBU->PBU_FUNC)
					cCtrProc 	:= "E"
					cErro 		:= cErro + "X10"
					aAdd(aErro, {PBT->PBT_SEQUEN, PBU->PBU_NUMLIN, "X10", "Subcontrato familia em branco","E"})
				EndIf

				If AllTrim(PBU->PBU_OPER) $ '12' .and. lBA3SemPla(PBT->PBT_CODEMP,PBU->PBU_FUNC)
					cCtrProc 	:= "E"
					cErro 		:= cErro + "X11"
					aAdd(aErro, {PBT->PBT_SEQUEN, PBU->PBU_NUMLIN, "X11", "Plano familia em branco","E"})
				EndIf

				If  AllTrim(PBU->PBU_OPER) $ '13' .and. CrIncExcAr( PBT->PBT_SEQUEN, PBU->PBU_FUNC, PBU->PBU_BENEF, PBU->PBU_OPER )

					cCtrProc 	:= "E"
					cErro 		:= cErro + "X12"
					aAdd(aErro, {PBT->PBT_SEQUEN, PBU->PBU_NUMLIN, "X12", "Inclusao e exclusao no mesmo arquivo","E"})

				EndIf

				//-----------------------------------------------------------------------------
				//Inicio - Angelo Henrique - Data: 26/08/2016
				//-----------------------------------------------------------------------------
				//Inicio das validações para o processo de Reativação do Beneficiário
				//-----------------------------------------------------------------------------
				If  AllTrim(PBU->PBU_OPER) = "4"

					_cMsg := u_CABA336G(PBU->PBU_FUNC,PBU->PBU_CPF,PBU->PBU_PADRAO,PBU->PBU_CODEMP, _cSubcon)

					If !Empty(_cMsg)

						cCtrProc 	:= "E"
						cErro 		:= cErro + "X15"
						aAdd(aErro, {PBT->PBT_SEQUEN, PBU->PBU_NUMLIN, "X15", _cMsg,"E"})

					EndIf

				EndIf
				//-----------------------------------------------------------------------------
				//Fim - Angelo Henrique - Data: 26/08/2016
				//-----------------------------------------------------------------------------

				//-----------------------------------------------------------------------------
				//Angelo Henrique - Data: 28/10/2016
				//-----------------------------------------------------------------------------
				//Inicio - Validação para o tipo de movimento exclusão (Bloqueio no sistema)
				//-----------------------------------------------------------------------------
				If  AllTrim(PBU->PBU_OPER) = "3"

					_cMsg := CABA336I(PBU->PBU_CPF, PBU->PBU_CODEMP, PBU->PBU_FUNC)

					If !Empty(_cMsg)
						
						aAdd(aErro, {PBT->PBT_SEQUEN, PBU->PBU_NUMLIN, "X16", _cMsg,"E"})

					EndIf

				EndIf
				//-----------------------------------------------------------------------------
				//Fim - Validação para o tipo de movimento exclusão (Bloqueio no sistema)
				//-----------------------------------------------------------------------------

				nSeqErro := 0

				If Len(aErro) > 0

					//Critica de logradouro desabilitada temporariamente 038
					nPosErro := aScan(aErro,{|x| x[3] == '038'})

					If ( nPosErro > 0 )
						aDel(aErro,nPosErro)
						aSize(aErro,Len(aErro)-1)
					EndIf

					For n := 1 to Len(aErro)

						lAchouCrit 	:= .T.
						nSeqErro 	+= 1

						aAdd(aArqErro, {aErro[n,1],aErro[n,2], StrZero(nSeqErro,3), aErro[n,3],aErro[n,4],aErro[n,5]})

						PBV->(RecLock("PBV",.T.))

						PBV->PBV_SEQUEN := aErro[n,1]
						PBV->PBV_NUMLIN := aErro[n,2]
						PBV->PBV_SEQERR := StrZero(nSeqErro,3)
						PBV->PBV_CODERR := aErro[n,3]
						PBV->PBV_DESERR := aErro[n,4]
						PBV->PBV_CTRPRC := aErro[n,5]

						PBV->(MsUnlock())

						If aErro[n,5] != "W"
							cCtrProc := "E"
						EndIf

					Next

				EndIf

				PBU->(RecLock("PBU",.F.))

				If Len(aErro) > 0
					PBU->PBU_TABERR := cErro
					PBU->PBU_STATUS := cCtrProc
				Else
					//Limpo o arquivo criticado anteriormente caso esteja com critica.
					PBU->PBU_TABERR := ''
					PBU->PBU_STATUS := ''
				EndIf

				PBU->PBU_OPERSI := PBU->PBU_OPER         // mbctrocar

				Do Case

					Case AllTrim(PBU->PBU_OPER) == "0"
					cAcao := "Arquivo Espelho"

					Case AllTrim(PBU->PBU_OPER) == "1"
					cAcao := "Inclusao no Plano"

					Case AllTrim(PBU->PBU_OPER) == "2"
					cAcao := "Alteracoes / Transferencias"

					Case AllTrim(PBU->PBU_OPER) == "3"
					cAcao := "Exclusao Plano"

					Case AllTrim(PBU->PBU_OPER) == "4" //Angelo Henrique - Data: 25/08/2016
					cAcao := "Reativação do Plano"

					Otherwise
					cAcao := "Acao Inesperada!!! Rever coluna de Tipo de Movimento na Planilha"

				EndCase

				//PBU->PBU_DESOPE := cAcao
				PBU->(MsUnlock())

				PBU->(dbSkip())

			Enddo

			If Len(aArqErro) > 0

				cArqOut := Substr(cPath+AllTrim(PBT->PBT_NOMARQ),1,Len(AllTrim(PBT->PBT_NOMARQ))- At(AllTrim(PBT->PBT_NOMARQ),"."))+".ret"
				nHOut 	:= FCreate(cArqOut)

				For N := 1 to Len(aArqErro)

					cLinha := aArqErro[n,1]+aArqErro[n,2]+aArqErro[n,3]+aArqErro[n,4]
					FWrite(nHOut,cLinha+ Chr(13) + Chr(10),Len(cLinha)+2)
					cLinha := ""

				Next N

				FClose(nHOut)

			EndIf

			//Mudo o status do arquivo colocando como criticado
			PBT->(RecLock("PBT",.F.))

			If lAchouCrit
				PBT->PBT_STATUS := "3"//3 - Arquivo Analisado COM Críticas
			Else
				PBT->PBT_STATUS := "2"//2 - Arquivo Analisado SEM Criticas
			EndIf

			PBT->PBT_DTCRIT := dDatabase

			PBT->(MsUnlock())

			If PBT->PBT_QTDLID <> nCriticados
				MsgStop("[ ERRO ] Registros analisados: " + AllTrim(Transform(nCriticados,'@E 999,999,999')),AllTrim(SM0->M0_NOMECOM) )
			Else
				MsgInfo("Registros analisados: " + AllTrim(Transform(nCriticados,'@E 999,999,999')),AllTrim(SM0->M0_NOMECOM) )
			EndIf

		EndIf

	Else
		MsgInfo("Somente e possivel criticar arquivos com status importado!")
	EndIf

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ CAB336EXC   ³ Autor ³ Bianchini/Marcela ³ Data ³ 16.05.2006 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Exclui o arquivo e sua composicao                          ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function CAB336EXC(cAlias,nReg,nOpc)

	Local oDlg
	Local nOpca   	:= 0
	Local I__f   	:= 0
	Local oEnc
	Local bOK     	:= { || nOpca := 1, oDlg:End() }
	Local bCancel 	:= { || oDlg:End() }
	Local cSeq 		:= PBT->PBT_SEQUEN
	Local cSQL
	Local lDeleta
	Local _aAreaPBU	:= PBU->(GetArea()) //Angelo Henrique - Data: 03/03/2016
	Local _aAreaPBT	:= PBT->(GetArea()) //Angelo Henrique - Data: 03/03/2016

	aSize 			:= MsAdvSize()
	aInfo 			:= {aSize[1], aSize[2], aSize[3], aSize[4], 3, 3}

	aObjects		:= {}
	aAdd( aObjects, { 100 , 100	, .T., .T. } )

	aPosObj 	:= MsObjSize( aInfo, aObjects,.T.)

	DEFINE MSDIALOG oDlg TITLE cCadastro FROM aSize[7],00 To aSize[6],aSize[5] PIXEL

	Copy cAlias To Memory Blank

	oEnc := PBT->(MsMGet():New(cAlias,nReg,K_Visualizar,,,,,{aPosObj[1][1],aPosObj[1][2],aPosObj[1][3]-15,aPosObj[1][4]-3},,,,,,oDlg,,,.F.))

	ACTIVATE MSDIALOG oDlg ON INIT EnchoiceBar(oDlg,bOK,bCancel,.F.,{})

	If nOpca == K_OK

		If M->PBT_STATUS $ "4|5"
			MsgInfo("Nao e possivel excluir pois este arquivo ja foi inserido no BD !")
			lDeleta := .F.
		Else
			lDeleta := .T.
		EndIf

		If lDeleta

			BEGIN TRANSACTION

				//-------------------------------------------------------------------------------------
				//INICIO - Angelo Henrique - Data: 03/03/2016
				//-------------------------------------------------------------------------------------
				//Retirando o delete via banco, pois assim eram perdidos o
				//histórico dos arquivos importados, ficando somente o cabeçalho (Tabela PBT)
				//passando para o delete via DBDELETE, assim este histórico é preservado.
				//-------------------------------------------------------------------------------------
				/*
				cSQL := "DELETE FROM " + PBU->(RetSQLName("PBU"))+" "
				cSQL += "WHERE PBU_SEQUEN = '" + cSeq + "' AND D_E_L_E_T_ = ' '"
				PLSSQLEXEC(cSQL)

				cSQL := "DELETE FROM " + RetSQLName("PBV")+" "
				cSQL += "WHERE PBV_SEQUEN = '" + cSeq + "' AND D_E_L_E_T_ = ' '"
				PLSSQLEXEC(cSQL)
				*/

				DbSelectArea("PBU")
				DbSetOrder(1)
				If DbSeek(xFilial("PBU") + PADR(AllTrim(cSeq),TAMSX3("PBU_SEQUEN")[1]))

					While PBU->(!EOF()) .And. PADR(AllTrim(cSeq),TAMSX3("PBU_SEQUEN")[1]) == PBU->PBU_SEQUEN

						RecLock("PBU",.F.)
						DbDelete()
						MsUnLock()

						PBU->(DbSkip())

					EndDo

				EndIf


				DbSelectArea("PBV")
				DbSetOrder(1)
				If DbSeek(xFilial("PBV") + PADR(AllTrim(cSeq),TAMSX3("PBV_SEQUEN")[1]))

					While PBV->(!EOF()) .And. PADR(AllTrim(cSeq),TAMSX3("PBV_SEQUEN")[1]) == PBV->PBV_SEQUEN

						RecLock("PBV",.F.)
						DbDelete()
						MsUnLock()

						PBV->(DbSkip())

					EndDo

				EndIf

				//-------------------------------------------------------------------------------------
				//FIM - Angelo Henrique - Data: 03/03/2016
				//-------------------------------------------------------------------------------------

				PBT->(PLUPTENC("PBT",K_Excluir))

			END TRANSACTION

		EndIf

	EndIf

	RestArea(_aAreaPBT)	 //Angelo Henrique - Data: 03/03/2016
	RestArea(_aAreaPBU)	 //Angelo Henrique - Data: 03/03/2016

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ CAB336APP  ³ Autor ³ Bianchini/Marcela ³ Data ³ 16.05.2006 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Insere Arquivo Criticado                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function CAB336APP(cAlias,nReg,nOpc)

	Local c_AlQry 	:= GetNextAlias()
	Local cQry		:= ''
	Local nQtdReg	:= 0

	cQry := "SELECT COUNT(*) QTD" 							+ CRLF
	cQry += "FROM " + RetSqlName('PBU') 					+ CRLF
	cQry += "WHERE PBU_FILIAL = '" + xFilial('PBU') + "'" 	+ CRLF
	cQry += "  AND PBU_SEQUEN = '" + PBT->PBT_SEQUEN + "'" 	+ CRLF
	cQry += "  AND D_E_L_E_T_ = ' '" 						+ CRLF

	TcQuery cQry New Alias c_AlQry

	If !c_AlQry->(EOF())
		nQtdReg := c_AlQry->(QTD)

		Processa({||PCA336APP(cAlias,nReg,nOpc,nQtdReg)},'Processando inclusão no banco...')
	Else
		MsgStop('Não foram localizados registros na PBU. Verifique!',AllTrim(SM0->M0_NOMECOM))
	EndIf

	c_AlQry->( dbCloseArea() )

Return

Static Function PCA336APP(cAlias,nReg,nOpc,nQtdReg)

	Local aCampos			:= {}
	Local nPassou			:= 0
	Local nOrdPBU			:= If( PBT->PBT_LAYOUT == '1', 5, 6 )
	Local cOperac			:= ''  //Variavel criada porque ao chegar fim de arquivo na virada do loop não temos referencia ao campo PBU->PBU_OPER
	Local nAux				:= 0
	Local nProc			:= 0
	Local cMsg				:= ''
	Local cSubConOdonto 	:= ''
	Local nCriticados		:= 0
	Local cMsg				:= ''

	/*If PBT->PBT_LAYOUT == '1'
	cSubConOdonto 	:= chkSubOdonto()
	EndIf*/

	l_Voltou := .F.

	//Somente Prefeitura 0024 pode inserir arquivo com criticas
	If ( PBT->PBT_STATUS == "2" ) .or. ( ( PBT->PBT_STATUS == "3" ) .and. ( PBT->PBT_CODEMP == '0024' ) )

		//ProcRegua(nQtdReg * If(PBT->PBT_LAYOUT == '1',2,1)) -- Angelo Henrique - Data: 01/08/2016 - Novos planos
		ProcRegua(nQtdReg)

		PBU->(DbSetOrder(nOrdPBU))

		If PBU->(DbSeek(xFilial("PBU") + PBT->PBT_SEQUEN))

			While !PBU->(EOF()) .and. ( PBU->PBU_SEQUEN == PBT->PBT_SEQUEN )

				cMsg := 'Incluindo linha ' + AllTrim(Transform(++nAux,'@E 999,999,999')) + ;
				' de ' + AllTrim(Transform(nQtdReg,'@E 999,999,999'))

				IncProc(cMsg)

				//--------------------------------------------------------------------------------------------------------------------
				//Angelo Henrique - Data:14/06/2016
				//--------------------------------------------------------------------------------------------------------------------
				//Acrescentado validação para o processo de transferência, pois
				//foi necessário deixar constar como critica para que o cadastro
				//possa visualizar quais foram transferidos
				//--------------------------------------------------------------------------------------------------------------------
				//OR. (CABA336F(PBU->PBU_SEQUEN, PBU->PBU_NUMLIN, AllTrim(PBU->PBU_OPER) .And. AllTrim(PBU->PBU_OPER) = "2")
				//--------------------------------------------------------------------------------------------------------------------
				If Empty(PBU->PBU_STATUS) .OR. (u_CABA336F(PBU->PBU_SEQUEN, PBU->PBU_NUMLIN, AllTrim(PBU->PBU_OPER)) .And. AllTrim(PBU->PBU_OPER) = "2")

					cOperac := AllTrim(PBU->PBU_OPER)

					Do Case

						Case cOperac == "1" //Incluir beneficiario.

						If PBT->PBT_LAYOUT == '1' .and. !l_Voltou
							//cCodPro := ConvPlano(trim(PBU->PBU_PADRAO),'MED','C')
							cCodPro := ConvPlano(trim(PBU->PBU_PADRAO),Alltrim(PBU->PBU_CDBENE),1) //Chamando o novo

						ElseIf PBT->PBT_LAYOUT == '2' .and. !l_Voltou

							cCodPro := PBU->PBU_PADRAO

						Else

							cCodPro := PBU->PBU_PLAODO

						EndIf

						IncluiUsr(cCodPro)
						nProc++

						Case cOperac == "2"

						//-------------------------------------------------------------------------------------------------
						//Angelo Henrique - Data: 26/05/2016
						//-------------------------------------------------------------------------------------------------
						// Ajustando o processo de Alteração, que para a prefeitura a única alteração existente no
						// momento é a troca de plano, logo será executado o processo de bloqueio da matricula
						//anterior e criação da nova matricula, fazendo o processo semelhante a transferência do padrão
						//-------------------------------------------------------------------------------------------------

						CABA336C(PBU->PBU_CPF, PBU->PBU_CODEMP,PBT->PBT_LAYOUT,PBU->PBU_PADRAO, PBU->PBU_PLAODO, IIF(PBU->PBU_INDCAR == '1', 'S','N'),PBU->PBU_FUNC, PBU->PBU_SEQUEN)										

						nProc++

						Case cOperac == "3" //Bloqueio de beneficiario. -- Angelo Henrique - Data: 09/05/2016

						//-----------------------------------------------------
						//Rotina que irá realizar o bloqueio
						//validando se o beneficiário é titular ou não
						//Rotina esta espelhando o mesmo processo
						//da rotina padrão, PLSA260
						//-----------------------------------------------------
						CABA336A(PBU->PBU_CPF, PBU->PBU_CODEMP, PBU->PBU_FUNC)

						nProc++

						Case cOperac == "x4" //Reativação do Beneficiario - Angelo Henrique 29/08/2016

						//------------------------------------------------------
						//Rotina irá realizar o processo de reativação
						//Utilizando o mesmo processo listado no bloqueio
						//------------------------------------------------------
						CABA336H(PBU->PBU_CPF, PBU->PBU_CODEMP, PBU->PBU_FUNC, PBU->PBU_PADRAO)

						nProc++

					EndCase

				Else
					nCriticados++
				EndIf

				PBU->(DbSkip())

				If ( PBU->(EOF()) .or. PBT->PBT_SEQUEN <> PBU->PBU_SEQUEN )

					mm:= 1

				EndIf
				//Este trecho fara voltar ao inicio da PBU para incluir o Odontologico.  O arquivo sera lido 2 vezes
				//Fixado somente para inclusao , por enquanto
				/*
				If nPassou == 0  .and. ( PBU->(EOF()) .or. PBT->PBT_SEQUEN <> PBU->PBU_SEQUEN )
				//mbcodo	If PBT->PBT_LAYOUT == '1' .and. nPassou == 0 .and. cOperac $ "1" .and. ( PBU->(EOF()) .or. PBT->PBT_SEQUEN <> PBU->PBU_SEQUEN )

				PBU->(DbGoTop())
				PBU->(DbSetOrder( IIF( PBT->PBT_LAYOUT == '1', 5, 6 ) ))
				PBU->(DbSeek(xFilial("PBU")+PBT->PBT_SEQUEN))

				//l_Voltou := .T.
				//nPassou := 1
				*/
				If PBT->PBT_LAYOUT == '1' .and. ( PBU->(EOF()) .or. PBT->PBT_SEQUEN <> PBU->PBU_SEQUEN ) .and. nPassou == 1 .and. cOperac $ "1"
					AjustaMat()  //Fazer De/Para de matriculas Odonto na matricula Medica
				EndIf

			Enddo

		EndIf

		//Mudo o status do arquivo colocando como Inserido no BD
		PBT->(RecLock("PBT",.F.))

		If nCriticados > 0
			PBT->PBT_STATUS := "5"//5 - Arquivo Parcialmente Inserido na Base
		Else
			PBT->PBT_STATUS := "4"//4 - Arquivo Totalmente Inserido na Base
		EndIf

		PBT->PBT_DTINSB := dDatabase
		PBT->(MsUnlock())

		cMsg := "Regs a processar SAUDE: " + AllTrim(Transform(nQtdReg,'@E 999,999,999')) 									+ CRLF
		cMsg += " - Criticados: " + AllTrim(Transform(nCriticados/If(!empty(cSubConOdonto),2,1),'@E 999,999,999'))										+ CRLF
		cMsg += 																											  CRLF

		/*If !empty(cSubConOdonto)
		cMsg += "Regs a processar ODONTO: " + AllTrim(Transform(nQtdReg,'@E 999,999,999')) 								+ CRLF
		cMsg += " - Criticados: " + AllTrim(Transform(nCriticados/If(!empty(cSubConOdonto),2,1),'@E 999,999,999'))									+ CRLF
		cMsg += 																										  CRLF
		EndIf*/

		cMsg += "Regs a processar TOTAL: " + AllTrim(Transform( nQtdReg * If(!empty(cSubConOdonto),2,1),'@E 999,999,999')) 	+ CRLF
		cMsg += 																				 							  CRLF
		cMsg += "Regs Processados: " + AllTrim(Transform(nProc,'@E 999,999,999')) 											+ CRLF
		cMsg += 																											  CRLF
		cMsg += "Diferença: " + AllTrim(Transform( nQtdReg * If(!empty(cSubConOdonto),2,1) - nProc,'@E 999,999,999')) 		+ CRLF

		If ( ( ( nQtdReg  - nCriticados ) * If(!empty(cSubConOdonto),2,1) ) == nProc )
			MsgInfo(cMsg,AllTrim(SM0->M0_NOMECOM))
		Else
			MsgStop(cMsg,AllTrim(SM0->M0_NOMECOM))
		EndIf

	Else
		MsgInfo("Somente e possivel inserir no BD arquivos com status criticado!")
	EndIf

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±±
±±³Funcao    ³ CAB336LEG  ³ Autor ³ Wagner Mobile Costa ³ Data ³ 28.08.03 ³±±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±±
±±³Descricao ³ Exibe a legenda...                                         ³±±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

User Function CAB336LEG(nTipo)

	Local aLegenda

	//---------------------------------
	//Angelo Henrique - Data:04/03/2016
	//---------------------------------
	Local _aArea 		:= GetArea()
	Local _aAreaPBU	:= PBU->(GetArea())
	Local _aAreaPBT	:= PBT->(GetArea())
	//---------------------------------

	If nTipo == 1
		aLegenda := { 	{ aCdCores[1,1],aCdCores[1,2] },;
		{ aCdCores[2,1],aCdCores[2,2] },;
		{ aCdCores[3,1],aCdCores[3,2] },;
		{ aCdCores[4,1],aCdCores[4,2] },;
		{ aCdCores[5,1],aCdCores[5,2] },;
		{ aCdCores[6,1],aCdCores[6,2] } }
	Else
		aLegenda := { 	{ aCdCores[1,1],aCdCores[1,2] },;
		{ aCdCores[2,1],aCdCores[2,2] }}
	EndIf

	BrwLegenda(cCadastro,"Status" ,aLegenda)

	RestArea(_aAreaPBU)
	RestArea(_aAreaPBT)

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±±
±±³Funcao    ³ CAB336CMP  ³ Autor ³ Bianchini/Marcela   ³ Data ³ 28.08.03 ³±±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±±
±±³Descricao ³ Mostra Composicao do Arquivo                               ³±±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

User Function CAB336CMP()

	Private aFilAdic 	:= {.T.,"('01','02')"}

	Private aRotina   	:=	{	{ "Pesquisar" , 'AxPesqui'	    , 0 , K_Pesquisar  },;
	{ "Visualizar", 'AxVisual'	    , 0 , K_Visualizar },;
	{ "Erros"     , 'u_F336ERR'	 	, 0 , K_Visualizar },;
	{ "Legenda"   , "U_CAB336LEG(2)"	, 0 , K_Incluir    } } //Angelo Henrique - Data:04/03/2016

	//-----------------------------------------------------------------------
	//Angelo Henrique - Data: 04/03/2016
	//-----------------------------------------------------------------------
	//Retirado a chamada desta função de legenda pois estava dando erro
	//acrescentado a legenda já utilizada por outras rotinas aqui
	//da importação
	//{ "Legenda"   , "U_CBIMPLEG(2)"	, 0 , K_Incluir    } }
	//-----------------------------------------------------------------------

	Private cAlias   := "PBU"
	Private cChave   := PBT->(PBT_SEQUEN)
	Private aCdCores := { 	{ 'BR_VERDE'    ,'Linha OK' },{ 'BR_VERMELHO'     ,'Linha Criticada' }}
	//Private aCores   := { { 'Empty(AllTrim(PBU_TABERR)) = ""',aCdCores[1,1] },{ 'AllTrim(PBU_TABERR) > ""',aCdCores[2,1] }}
	Private aCores   := { { 'Empty(AllTrim(PBU_TABERR))',aCdCores[1,1] },{ '!Empty(AllTrim(PBU_TABERR))',aCdCores[2,1] }}

	#IFDEF TOP
	Private cFil := "@PBU_FILIAL = '"+xFilial("PBU")+"'"
	cFil += " AND PBU_SEQUEN = '"+PBT->PBT_SEQUEN+"' AND D_E_L_E_T_ = ' '"
	#Else
	Private cFil := "PBU_FILIAL = '"+xFilial("PBU")+"'"
	cFil += " .and. PBU_SEQUEN = '"+PBT->PBT_SEQUEN+"'"
	#EndIf

	PBU->(DBSetOrder(1))
	DbSelectArea("PBU")
	SET FILTER TO &cFil

	PBU->(mBrowse(006,001,022,075,"PBU" ,nil ,nil ,nil ,nil , 4    , aCores,nil ,nil ,nil ,,.T.,nil))
	PBU->(DbClearFilter())

	//Processa( { || Executa() }, 'Processando...', '', .T. )
Return

Static Function VerFunc(cCodemp,cMatric,cTipusu)

	Local lRet := .F.
	Local cSQL := ' '

	cSQL := "SELECT COUNT(*) QTD "
	cSQL += "  FROM "+RetSQLName("BA1")+ " BA1 "
	cSQL += " WHERE BA1_FILIAL = '"+xFilial("BA1")+"'"
	cSQL += "   AND BA1_CODINT = '"+PLSINTPAD()+"'"
	cSQL += "   AND BA1_CODEMP = '"+cCodemp+"'"
	cSQL += "   AND BA1_MATEMP LIKE '"+cMatric+"%'"
	cSQL += "   AND BA1_TIPUSU = '"+cTipusu+"'"
	cSQL += "   AND BA1_DATBLO = ' ' "
	cSQL += "   AND D_E_L_E_T_ = ' ' "

	PlsQuery(cSQL,"TRBFUNC")

	If !Empty(TRBFUNC->QTD) .or. (TRBFUNC->QTD > 0)
		lRet := .T.
	EndIf

	TRBFUNC->(dbCloseArea())

Return(lRet)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±±
±±³Funcao    ³ VerFami    ³ Autor ³ Bianchini/Marcela   ³ Data ³ 16.01.09 ³±±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±±
±±³Descricao ³ Verifica se a funcional esta cadastra no BA3               ³±±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function VerFami(cMatric, cTipo)

	Local nOrdBA3 	:= BA3->(IndexOrd())
	Local lRet    	:= .F.
	Local c_MaxMat 	:= ""

	/*
	cTipo ===> 0 - Espelho / 1 - Inclusao Plano / 2 - Alteracao/Troca de Plano / 3 - Exclusao
	*/

	BA3->(dbSetOrder(5))
	If BA3->(dbSeek(xFilial("BA3")+PBT->PBT_CODEMP+cMatric)) //cMatric vem como PBT_FUNC (Funcional)

		While !BA3->( EOF() ) .and. AllTrim( BA3->BA3_CODEMP + BA3->BA3_MATEMP ) == AllTrim( PBT->PBT_CODEMP+cMatric )

			If 	(	Empty( BA3->BA3_DATBLO ) 	.and. 	cTipo <> '3'	) .or.;
			(	cTipo == '3' 				.and. 	BA3->BA3_CODEMP + BA3->BA3_MATRIC >  c_MaxMat)

				c_MaxMat := BA3->BA3_CODEMP + BA3->BA3_MATRIC

				lRet := .T.

			EndIf

			BA3->( dbSkip() )

		EndDo

	EndIf

	BA3->(dbSetOrder(nOrdBA3))

Return(lRet)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±±
±±³Funcao    ³ VerBA1     ³ Autor ³ Bianchini/Marcela   ³ Data ³ 01.12.08 ³±±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±±
±±³Descricao ³ Verifica a existencia do beneficiario no BA1 atraves da    ³±±±
±±³          ³ Matricula Funcional+Dependencia Itau                       ³±±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function VerBA1(cMatric,cTipo)

	Local nOrdBA1 := BA1->(IndexOrd())
	Local lRet    := .F.
	Local c_MaxMat:= ""

	BA1->(dbSetOrder(6))
	If BA1->(DbSeek(xFilial("PBU")+cMatric))

		While !BA1->( EOF() ) .and. AllTrim(  BA1->BA1_MATEMP ) == AllTrim( cMatric )

			If 	PBT->PBT_CODEMP == BA1->BA1_CODEMP .and. ( ;
			(	Empty( BA1->BA1_DATBLO ) 	.and. 	cTipo <> '03'	) .or.;
			(	cTipo == '03' 				.and. 	BA1->BA1_CODEMP + BA1->BA1_MATRIC >  c_MaxMat)   )

				c_MaxMat:= BA1->BA1_CODEMP + BA1->BA1_MATRIC

				lRet	:= .T.

			EndIf

			BA1->( dbSkip() )

		EndDo

		lRet := .T.
	EndIf
	////If !Empty(BA1->BA1_DATBLO) .or. !Empty(BA1->BA1_MOTBLO)
	//If !Empty(BA1->BA1_DATBLO) .and. !Empty(BA1->BA1_MOTBLO)  //alterado pelo Luzio para que nao rejeite se estiver apenas com um dos campos preenchidos
	//	lRet := .F.
	//EndIf
	BA1->(dbSetOrder(nOrdBA1))

Return(lRet)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±±
±±³Funcao    ³ ExeBA1     ³ Autor ³ Bianchini/Marcela   ³ Data ³ 01.12.08 ³±±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±±
±±³Descricao ³ Verifica a existencia do beneficiario no BA1 atraves da    ³±±±
±±³          ³ Matricula Funcional+Dependencia Itau                       ³±±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function ExeBA1(cMatric,cOper)

	Local nOrdBA1 := BA1->(IndexOrd())
	Local lRet    := .F.

	BA1->(dbSetOrder(6))

	If BA1->(DbSeek(xFilial("BA1")+cMatric)) .and. (!Empty(BA1->BA1_DATBLO) .or. !Empty(BA1->BA1_MOTBLO))
		lRet := .T.
	EndIf

	BA1->(dbSetOrder(nOrdBA1))

Return(lRet)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±±
±±³Funcao    ³ ChkData    ³ Autor ³ Bianchini/Marcela   ³ Data ³ 16.05.06 ³±±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±±
±±³Descricao ³ Checa a Data olhando no cadastro                           ³±±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function chkData(cMatric,cDepend,cCdbene,cData,nTipo)

	Local nRecnoBA1 := 0

	If !Empty(AllTrim(cMatric)) .and. cMatric != NIL
		BA3->(dbSetOrder(5))
		If BA3->(dbSeek(xFilial("BA1")+PBT->PBT_CODEMP+cMatric))
			**'Inicio - Marcela Coimbra Data: 13/05/10' **
			While !BA3->( EOF() ) .and. BA3->BA3_FILIAL + BA3->BA3_CODEMP + BA3->BA3_MATEMP =  xFilial("BA1")+PBT->PBT_CODEMP+cMatric
				If Empty( BA3->BA3_DATBLO )
					**'Fim - Marcela Coimbra Data: 13/05/10' **
					If nTipo == 1 .or. nTipo == 2     //Inclusao
						Return(ctod(cData) >= BA3->BA3_DATBAS)
					ElseIf nTipo == 2
						Return(ctod(cData) >= BA3->BA3_DATBAS)
					ElseIf nTipo == 3     // para o caso de exclusao
						If cCdbene == 'T'
							Return(ctod(cData) >= BA3->BA3_DATBAS)        //Data da Exclusao maior que a data de cadastrammento da familia (Se for maior retorna .T., se for menor retorna .F.)
						Else
							//				BA1->(dbSetOrder(6))
							//				If BA1->(dbSeek(xFilial("BA1")+cMatric+cDepend))
							//					Return(ctod(cData) >= BA1->BA1_DATINC)     // Verificar se a data de bloqueio eh menor que a data de inclusao do beneficiario no contrato/produto
							//				EndIf
							nRecnoBA1 := ProMatEmp(AllTrim(PBT->PBT_CODOPE),AllTrim(PBT->PBT_CODEMP),cMatric,AllTrim(PBU->PBU_DEPEND))    //Verifica se a data de bloqueio eh menor que a data de inclusao do beneficiario no contrato/produto
							If nRecnoBA1 > 0
								BA1->(dbGoTo(nRecnoBA1))
								Return(ctod(cData) >= BA1->BA1_DATINC)
							EndIf
						EndIf
					EndIf
					**'Inicio - Marcela Coimbra Data: 13/05/10' **
					Exit
				EndIf
				BA3->( dbSkip() )
			EndDo
			**'Fim - Marcela Coimbra Data: 13/05/10' **

		EndIf
	Else
		//	  Return(dtoc(ctod(cData) <> "  /  /  "))
		Return(.F.)
	EndIf

Return(.T.)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±±
±±³Funcao    ³ ChkCEP     ³ Autor ³ Bianchini/Marcela      ³ Data ³ 17.05.06 ³±±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±±
±±³Descricao ³ Checa o CEP olhando no cadastro                            ³±±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function chkCEP(cCEP)

	Local lValida := .T.

	cCep := AllTrim(Replace(cCEP,'-',''))

	BC9->(DbSetOrder(1))

	If !BC9->(DbSeek(xFilial("BC9")+PADR(cCEP,8,' '))) .and. Len(cCep) <> 8
		lValida := .F.   //Return(.F.)
	EndIf

Return lValida

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±±
±±³Funcao    ³ ChkCidade  ³ Autor ³ Bianchini/Marcela   ³ Data ³ 17.05.06 ³±±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±±
±±³Descricao ³ Checa a Cidade olhando no cadastro                         ³±±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function chkCidade(cCep,cCidade,nTipo)

	Local cRetorno

	If At("-",cCep) > 0
		cCep := Substr(cCep,1,5)+Substr(cCep,7,3)
	EndIf

	BC9->(DbSetOrder(1))

	If nTipo == 1   //Valida se existe a cidade
		If !BC9->(DbSeek(xFilial("BC9")+cCEP))
			If AllTrim(cCidade) != AllTrim(BC9->BC9_MUN)
				Return(.T.)   //Return(.F.)
			EndIf
		EndIf
		cRetorno := .T.
	Else  //busca o nome da cidade
		If BC9->(DbSeek(xFilial("BC9")+cCEP))
			cRetorno :=AllTrim(BC9->BC9_MUN)
		EndIf
	EndIf

Return(cRetorno)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±±
±±³Funcao    ³ ChkPadrao  ³ Autor ³ Bianchini/Marcela   ³ Data ³ 17.05.06 ³±±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±±
±±³Descricao ³ Verifica qual produto saude ira alocar para o beneficiario ³±±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function chkPadrao(cPadrao,cOper,cMatric,cCdDepe,cTpBnf)

	Local n				:= 0
	Local SQL          	:= space(0)
	Local lDiferente   	:= .F.
	Local nOrdBA1      	:= BA1->(IndexOrd())
	Local lRet         	:= .T.
	Local cTempPadrao  	:= Space(0)
	//Local cCdBnf       := AllTrim(DParaTpBnf(cPadrao, cTpBnf))
	Local cCodBnf      	:= Space(0)
	//Local cCodPro      := Space(0)
	Local cVerPro      	:= Space(0)
	Local ccodInt      	:= Space(0)
	Local aProduto     	:= {}
	//Local cCodContrato := AllTrim(ChkContrato())

	Private cCodOpe := AllTrim(PBT->PBT_CODOPE)
	Private cCodEmp := AllTrim(PBT->PBT_CODEMP)

	cCodInt  := cCodOpe

	If AllTrim(cOper) == "03"
		aAdd(aProduto,{"0"})
		Return(aProduto)
	EndIf

	If Empty(AllTrim(cMatric))
		aAdd(aProduto,{"5"})
		Return(aProduto)
	EndIf

	aProduto := dParaPrd()

	//If Len(aProduto) <= 0
	//	Return(.F.)
	//EndIf

	For n := 1 to Len(aProduto)
		If aProduto[n,1] <> "0"
			Return(aProduto)
		EndIf
		cCodPro := aProduto[n,2]
		cVerPro := aProduto[n,3]
		cNumCon := aProduto[n,4]
		cVerCon := aProduto[n,5]
		cSubCon := aProduto[n,6]
		cVerSub := aProduto[n,7]
		cCodBnf := aProduto[n,8]
		cCodInt := aProduto[n,9]
	Next

	/*
	cSql := "SELECT DISTINCT BT6_CODPRO
	cSql += " FROM "+RetSqlName("BT6")+" BT6 "
	cSql += " WHERE D_E_L_E_T_ = ' ' "
	cSql += " AND BT6_CODPTU = " + AllTrim(cPadrao)
	cSql += " AND BT6_CODPTU = " + AllTrim(cPadrao)
	*/

	/*
	cSql := "SELECT DISTINCT BT6_CODPRO "
	cSql += " FROM "+RetSqlName("BT0")+" BT0, "+ RetSqlName("BQC")+" BQC "
	cSql += " WHERE BT0.d_e_l_e_t_ = ' ' "
	cSql += " AND BT0_YCDEDI = " + AllTrim(PBU->PBU_PADRAO)
	cSql += " AND BT0_YTPUSR = " + AllTrim(PBU->PBU_CDBENE)
	cSql += " AND BQC.d_e_l_e_t_ = ' ' "
	cSql += " AND BQC_CODIGO = BT0_CODIGO "
	cSql += " AND BQC_NUMCON = BT0_NUMCON "
	cSql += " AND BQC_VERCON = BT0_VERCON "
	cSql += " AND BQC_SUBCON = BT0_SUBCON "
	cSql += " AND BQC_VERSUB = BT0_VERSUB "
	cSql += " AND BQC_YCDCON = " + AllTrim(PBU->PBU_CONTR)
	cSql += " AND BQC_ANTCON = " + AllTrim(PBU->PBU_FILIT)

	PlsQuery(cSql,"TMPBT6")

	If !TMPBT6->(EOF())
	While !TMPBT6->(EOF())
	cTempPadrao := cTempPadrao + AllTrim(TMPBT6->BT6_CODPRO) + "_"
	cCodPro := AllTrim(TMPBT6->BT6_CODPRO)
	TMPBT6->(DbSkip())
	Enddo
	EndIf
	TMPBT6->(DbCloseArea())

	cTempPadrao := Substr(cTempPadrao,1,Len(cTempPadrao)-1)

	If Len(AllTrim(cTempPadrao)) <= 0  //Se nao encontrou o produto enviado pela empresa em nenhum produto de nenhuma empresa
	Return (.F.)
	EndIf
	*/

	//Busca o produto na familia
	//Somente quando for operacao diferente de inclusao ou transferencia
	//Deve verificar somente para os caso de inclusao, transferencia entre planos, trasnferencia entre operadoras, mas somente para dependentes.
	If !(AllTrim(cOper) $ "01")   //.and. PBU->PBU_CDBENE != "A"
		BA3->(dbSetOrder(5))
		If BA3->(dbSeek(xFilial("BA3")+PBT->PBT_CODEMP+cMatric))
			While !BA3->(Eof()) .and. BA3->(BA3_FILIAL+BA3_CODEMP+AllTrim(BA3_MATEMP)) == xFilial("BA3")+PBT->PBT_CODEMP+AllTrim(cMatric)
				If Empty(BA3->BA3_DATBLO)
					If BA3->BA3_CODPLA == cCodPro    //dParaPrd(cPadrao,cTpBnf)

						lRet := .T. // Marcela Coimbra
						exit // Marcela Coimbra

					EndIf
				EndIf
				BA3->(DbSkip())
			EndDo
		EndIf
	EndIf

	**'Inicio - Marcela Coimbra Data: 09/04/10' **

	If !lRet

		aProduto := {}
		aAdd(aProduto,{"4"})

	EndIf

	**'Fim - Marcela Coimbra Data: 09/04/10'**

	/*
	//If !(AllTrim(PBU->PBU_OPER) $ "01_04_05") .and. PBU->PBU_DEPEND != "00"   // Somente para dependentes
	If !(AllTrim(cOper) $ "01_04_05")
	If !Empty(AllTrim(cMatric))
	BA1->(dbSetOrder(6))
	If BA1->(DbSeek(xFilial("BA1")+AllTrim(cMatric)+AllTrim(cCdDepe)))
	While !BA1->(Eof()) .and. BA1->BA1_FILIAL+AllTrim(BA1->BA1_MATEMP) == xFilial("BA1")+AllTrim(cMatric)+AllTrim(cCdDepe)
	If Empty(BA3->BA3_DATBLO)
	If BA1->BA1_CODPLA <> dParaPrd(cPadrao,cTpBnf) .and. BA1->BA1_TIPUSU == DParaTpBnf(PBU->PBU_CDBENE)
	Return(.F.)
	EndIf
	EndIf
	BA1->(DbSkip())
	EndDo
	EndIf
	BA1->(dbSetOrder(nOrdBA1))

	/*
	BA3->(dbSetOrder(5))
	If BA3->(dbSeek(xFilial("BA3")+PBT->PBT_CODEMP+cMatric))
	While !BA3->(Eof()) .and. BA3->(BA3_FILIAL+BA3_CODEMP+BA3_CODEMP) == xFilial("BA3")+PBT->PBT_CODEMP+cMatric
	If Empty(BA3->BA3_DATBLO)
	If BA3->BA3_CODPLA <> dParaPrd(cPadrao,cTpBnf)
	lDiferente := .T.
	Else
	lDiferente := .F.
	EndIf
	EndIf
	BA3->(DbSkip())
	EndDo

	If AllTrim(PBU->PBU_OPER) $ "02"
	PBU->(RecLock("PBU",.F.))
	PBU->PBU_OPERSI := "06"
	PBU->PBU_DESOPE := "ALTERACAO DE PLANO / PRODUTO"
	PBU->(MsUnlock())
	Else
	Return(.F.)
	EndIf
	EndIf
	EndIf
	EndIf
	EndIf
	EndIf
	*/
Return(aProduto)   //lRet)	

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³DParaPrd  ºAutor  ³Luzio Tavares       º Data ³  17/05/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Retorna o Depara dos Produtos ITAU                         º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function dParaPrd(cPadrao,cTipo)

	Local cProduto := Space(0)
	Local cVerPro  := Space(0)
	Local cNumCon  := Space(0)
	Local cVerCon  := Space(0)
	Local cSubCon  := Space(0)
	Local cVerSub  := Space(0)
	Local cTipUsr  := Space(0)
	Local cCodInt  := Space(0)  //cCodOpe
	Local cSql     := space(0)
	Local aRet     := {}
	Local cQuery   := space(0)

	//If cTipo == "L"   //Legal
	//	cTipo := "D"
	//EndIf

	/*
	cSql := "SELECT DISTINCT BT0_CODPRO "
	cSql += " FROM "+RetSqlName("BT0")+" BT0 "
	cSql += " WHERE D_E_L_E_T_ = ' ' "
	cSql += " AND BT0_YCDEDI = " + AllTrim(cPadrao)
	cSql += " AND BT0_YTPUSR = " + AllTrim(cTipo)
	*/
	/*
	cSql := "SELECT DISTINCT BT0_CODPRO, BT0_VERSAO, BT0_NUMCON, BT0_VERCON, BT0_SUBCON, BT0_VERSUB, BT0_TIPUSR "
	cSql += " FROM "+RetSqlName("BT0")+" BT0, "+ RetSqlName("BQC")+" BQC "
	cSql += " WHERE BT0.d_e_l_e_t_ = ' ' "
	cSql += " AND BT0_YCDEDI = " + AllTrim(PBU->PBU_PADRAO)
	cSql += " AND BT0_YTPUSR = " + AllTrim(PBU->PBU_CDBENE)
	cSql += " AND BQC.d_e_l_e_t_ = ' ' "
	cSql += " AND BQC_CODIGO = BT0_CODIGO "
	cSql += " AND BQC_NUMCON = BT0_NUMCON "
	cSql += " AND BQC_VERCON = BT0_VERCON "
	cSql += " AND BQC_SUBCON = BT0_SUBCON "
	cSql += " AND BQC_VERSUB = BT0_VERSUB "
	cSql += " AND BQC_YCDCON = " + AllTrim(PBU->PBU_CONTR)
	cSql += " AND BQC_ANTCON = " + AllTrim(PBU->PBU_FILIT)

	PlsQuery(cSql,"TMPBT6")
	*/

	//cAliasBT0 := GetNextAlias()
	//cAliasBQC := cAliasBT0

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Inicio do Embedded SQL                                                  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	cQuery := "BT0.BT0_YCDEDI = '"+AllTrim(PBU->PBU_PADRAO)+"' AND "
	cQuery += "BT0.BT0_YTPUSR = '"+AllTrim(PBU->PBU_CDBENE)+"' AND "
	cQuery += "BQC.BQC_YCDCON = '"+AllTrim(PBU->PBU_CONTR)+"' AND "
	cQuery += "BQC.BQC_ANTCON = '"+AllTrim(PBU->PBU_CODEMP)+"' "  //	BQC.BQC_ANTCON = %exp:AllTrim(PBU->PBU_FILIT)%
	cQuery := "%" + cQuery + "%"

	BeginSql Alias "TMPBT0"

	%noparser%
	SELECT DISTINCT BT0_CODIGO, BT0_CODPRO, BT0_VERSAO, BT0_NUMCON, BT0_VERCON, BT0_SUBCON, BT0_VERSUB, BT0_TIPUSR
	FROM %table:BT0% BT0,%table:BQC% BQC
	WHERE BT0.BT0_FILIAL= %xfilial:BTO% AND
	BQC.BQC_FILIAL= %xfilial:BTQ% AND
	BT0.%NotDel%							AND
	BQC.%NotDel%							AND

	BQC.BQC_CODIGO = BT0_CODIGO AND
	BQC.BQC_NUMCON = BT0_NUMCON AND
	BQC.BQC_VERCON = BT0_VERCON AND
	BQC.BQC_SUBCON = BT0_SUBCON AND
	BQC.BQC_VERSUB = BT0_VERSUB AND
	%exp:cQuery%

	EndSql

	DbSelectArea( "TMPBT0" )

	TMPBT0->(DbGoTop())

	While !TMPBT0->(EOF())

		cProduto 	:= AllTrim(TMPBT0->BT0_CODPRO)
		cVerPro 	:= AllTrim(TMPBT0->BT0_VERSAO)
		cNumCon 	:= AllTrim(TMPBT0->BT0_NUMCON)
		cVerCon 	:= AllTrim(TMPBT0->BT0_VERCON)
		cSubCon 	:= AllTrim(TMPBT0->BT0_SUBCON)
		cVerSub 	:= AllTrim(TMPBT0->BT0_VERSUB)
		cTipUsr 	:= AllTrim(TMPBT0->BT0_TIPUSR)
		cCodInt 	:= SubStr(AllTrim(TMPBT0->BT0_CODIGO),1,4)

		aAdd(aRet,{"0",cProduto,cVerPro,cNumCon,cVerCon,cSubCon,cVerSub,cTipUsr,cCodInt})

		TMPBT0->(DbSkip())

	EndDo

	/*
	If !TMPBT0->(EOF())
	While !TMPBT0->(EOF())
	cProduto := AllTrim(TMPBT0->BT0_CODPRO)
	cVerPro := AllTrim(TMPBT0->BT0_VERSAO)
	cNumCon := AllTrim(TMPBT0->BT0_NUMCON)
	cVerCon := AllTrim(TMPBT0->BT0_VERCON)
	cSubCon := AllTrim(TMPBT0->BT0_SUBCON)
	cVerSub := AllTrim(TMPBT0->BT0_VERSUB)
	cTipUsr := AllTrim(TMPBT0->BT0_TIPUSR)
	cCodInt := SubStr(AllTrim(TMPBT0->BT0_CODIGO),1,4)

	aAdd(aRet,{"0",cProduto,cVerPro,cNumCon,cVerCon,cSubCon,cVerSub,cTipUsr,cCodInt})

	TMPBT0->(DbSkip())
	Enddo
	Else
	//cQuery += "BT0.BT0_YTPUSR = ' ' AND "
	cQuery := "BQC.BQC_YCDCON = '"+AllTrim(PBU->PBU_CONTR)+"' AND "
	cQuery += "BQC.BQC_ANTCON = '"+AllTrim(PBU->PBU_CODEMP)+"' AND "  //	BQC.BQC_ANTCON = %exp:AllTrim(PBU->PBU_FILIT)%
	cQuery += "BQC.BQC_CODINT = '"+AllTrim(PBT->PBT_CODOPE)+"' AND "
	cQuery += "BQC.BQC_CODEMP = '"+AllTrim(PBT->PBT_CODEMP)+"' "
	cQuery := "%" + cQuery + "%"

	BeginSql Alias "TMPBT0A"
	%noparser%
	//	SELECT DISTINCT BT0_CODIGO, BT0_CODPRO, BT0_VERSAO, BT0_NUMCON, BT0_VERCON, BT0_SUBCON, BT0_VERSUB, BT0_TIPUSR
	SELECT DISTINCT BT0_YCDEDI, BT0_YTPUSR, BQC_YCDCON, BQC_ANTCON, BT0_CODIGO, BT0_CODPRO, BT0_VERSAO, BT0_NUMCON, BT0_VERCON, BT0_SUBCON, BT0_VERSUB, BT0_TIPUSR
	FROM %table:BT0% BT0,%table:BQC% BQC
	WHERE BT0.BT0_FILIAL= %xfilial:BTO% AND
	BQC.BQC_FILIAL= %xfilial:BTQ% AND
	BT0.%NotDel% AND
	BQC.%NotDel% AND

	BQC.BQC_CODIGO = BT0_CODIGO AND
	BQC.BQC_NUMCON = BT0_NUMCON AND
	BQC.BQC_VERCON = BT0_VERCON AND
	BQC.BQC_SUBCON = BT0_SUBCON AND
	BQC.BQC_VERSUB = BT0_VERSUB AND
	%exp:cQuery%
	//ORDER BY BT0.BT0_CODPRO, BT0.BT0_TIPUSR
	EndSql
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Abertura do arquivo de trabalho                              |
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	dbSelectArea( "TMPBT0A" )

	TMPBT0A->(DbGoTop())

	If !TMPBT0A->(EOF())
	While !TMPBT0A->(EOF())
	//			cProduto := AllTrim(TMPBT0A->BT0_CODPRO)
	//			cVerPro  := AllTrim(TMPBT0A->BT0_VERSAO)
	//			cNumCon  := AllTrim(TMPBT0A->BT0_NUMCON)
	//			cVerCon  := AllTrim(TMPBT0A->BT0_VERCON)
	//			cSubCon  := AllTrim(TMPBT0A->BT0_SUBCON)
	//			cVerSub  := AllTrim(TMPBT0A->BT0_VERSUB)
	//			cTipUsr  := AllTrim(TMPBT0A->BT0_TIPUSR)
	//			cCodInt  := SubStr(AllTrim(TMPBT0A->BT0_CODIGO),1,4)

	If Empty(AllTrim(TMPBT0A->BT0_YTPUSR)+AllTrim(TMPBT0A->BT0_YCDEDI))
	aAdd(aRet,{"1",cProduto,cVerPro,cNumCon,cVerCon,cSubCon,cVerSub,cTipUsr,cCodInt})  //Falta parametrizar o produto e o tipo de usuario nos sub-contratos
	ElseIf AllTrim(TMPBT0A->BT0_YCDEDI) == AllTrim(PBU->PBU_PADRAO) .and. Empty(AllTrim(TMPBT0A->BT0_YTPUSR))
	aAdd(aRet,{"2",cProduto,cVerPro,cNumCon,cVerCon,cSubCon,cVerSub,cTipUsr,cCodInt})  //Falta parametrizar o tipo de usuario nos sub-contratos
	ElseIf AllTrim(TMPBT0A->BT0_YTPUSR) == AllTrim(PBU->PBU_CDBENE) .and. Empty(AllTrim(TMPBT0A->BT0_YCDEDI))
	aAdd(aRet,{"3",cProduto,cVerPro,cNumCon,cVerCon,cSubCon,cVerSub,cTipUsr,cCodInt})  //Falta parametrizar o produto nos sub-contratos
	EndIf
	TMPBT0A->(DbSkip())
	Enddo

	TMPBT0A->(DbCloseArea())
	EndIf
	EndIf
	*/

	TMPBT0->(DbCloseArea())

	If Len(aRet) <= 0
		aAdd(aRet,{"4",cProduto,cVerPro,cNumCon,cVerCon,cSubCon,cVerSub,cTipUsr,cCodInt})  //A empresa enviou um beneficiario ou produto que nao corresponde ao contratado.
	EndIf

	/*
	If cPadrao == "0109"
	If cTipo == "A"
	cProduto := "0017"
	Else
	cProduto := "0013"
	EndIf
	ElseIf cPadrao == "0208"
	If cTipo == "A"
	cProduto := "0016"
	Else
	cProduto := "0012"
	EndIf
	ElseIf cPadrao == "0307"
	If cTipo == "A"
	cProduto := "0015"
	Else
	cProduto := "0011"
	EndIf
	ElseIf cPadrao == "0406"
	If cTipo == "A"
	cProduto := "0014"
	Else
	cProduto := "0010"
	EndIf
	EndIf
	*/

Return(aRet)


Static Function ConvPlano(cPadrao, _cTipUsu, _nOpc)

	Local cSql	:= " "
	Local cRet	:= " "

	cSQL := "SELECT " 												+ CRLF
	cSQL += "	PLANO_PREF CD_PREVIRIO, DS_PREVIRIO, "				+ CRLF
	cSQL += "	PLANO_MEDICO CODPLA, TIP_USU, DS_MEDICO"			+ CRLF
	cSQL += "FROM " 													+ CRLF
	cSQL += "	PLANO_PREF_CAB_NV "									+ CRLF
	cSQL += "WHERE "													+ CRLF
	cSQL += "	TRIM(PLANO_PREF) = '" + AllTrim(cPadrao) + "'"	+ CRLF

	If AllTrim(cPadrao) $ "283|284"

		cSQL += "	AND TIP_USU = '" + _cTipUsu + "'" 				+ CRLF

	EndIf

	TcQuery cSQL ALIAS "TMPPLA" NEW

	dbSelectArea( "TMPPLA" )

	If !TMPPLA->(EOF())

		If _nOpc = 1

			cRet := Trim(TMPPLA->CODPLA)

		ElseIf _nOpc = 2

			cRet := Trim(TMPPLA->DS_MEDICO)

		EndIf

	EndIf

	TMPPLA->(DbCloseArea())

Return cRet	

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³AjustaMat ºAutor  ³Bianchini/Marcela   º Data ³  17/05/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Grava DE/PARA de Matricula Odonto na Matric Medica PREFEIT.º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function AjustaMat(cCPFUsr)

	Local cSQL 		:= ' '

	Default cCPFUsr := ''

	cSQL := " SELECT BA1MED.BA1_CODINT||BA1MED.BA1_CODEMP||BA1MED.BA1_MATRIC||BA1MED.BA1_TIPREG||BA1MED.BA1_DIGITO MATRIC " + CRLF
	cSQL += "      , BA1MED.BA1_CPFUSR CPF                                                                                " + CRLF
	cSQL += "      , BA1MED.BA1_NOMUSR NOME                                                                               " + CRLF
	cSQL += "      , BA1MED.BA1_YMTODO MAT_ODONTO                                                                         " + CRLF
	cSQL += "      , BA1MED.BA1_MATEMP FUNCIONAL                                                                          " + CRLF
	cSQL += "      , BA1MED.R_E_C_N_O_ REC_BA1MED                                                                         " + CRLF

	//Leonardo Portella - 29/05/15 - Incluido recno da matricula odontologica
	cSQL += "      , BA1ODO.R_E_C_N_O_ REC_BA1ODO                                                                         " + CRLF

	cSQL += "      , BA1ODO.BA1_CODINT||BA1ODO.BA1_CODEMP||BA1ODO.BA1_MATRIC||BA1ODO.BA1_TIPREG||BA1ODO.BA1_DIGITO MATODO " + CRLF
	cSQL += "   FROM (SELECT BA1010.*                                                                                     " + CRLF
	cSQL += "         FROM BA1010                                                                                         " + CRLF
	cSQL += "         INNER JOIN PBU010 PBU ON PBU_FILIAL = ' '                                                           " + CRLF
	cSQL += "           AND PBU_SEQUEN = '" + PBT->PBT_SEQUEN + "'                                      				  " + CRLF
	cSQL += "           AND PBU_CPF = BA1_CPFUSR                                      									  " + CRLF
	cSQL += "           AND PBU.D_E_L_E_T_ = ' '                                     									  " + CRLF
	cSQL += "          WHERE BA1_FILIAL = ' '                                                                             " + CRLF
	cSQL += "            AND BA1_CODEMP IN ('0024')                                                                       " + CRLF
	cSQL += "            AND BA1_CODPLA IN ('0092','0093','0094','0095','0096','0097')                                    " + CRLF
	cSQL += "            AND (BA1_DATBLO = ' ' OR TO_DATE(TRIM(BA1_DATBLO),'YYYYMMDD') > SYSDATE)                         " + CRLF
	cSQL += "            AND BA1010.D_E_L_E_T_ = ' ') BA1MED                                                              " + CRLF
	cSQL += "      , (SELECT BA1010.*                                                                                     " + CRLF
	cSQL += "         FROM BA1010                                                                                         " + CRLF
	cSQL += "         INNER JOIN PBU010 PBU ON PBU_FILIAL = ' '                                                           " + CRLF
	cSQL += "           AND PBU_SEQUEN = '" + PBT->PBT_SEQUEN + "'                                      				  " + CRLF
	cSQL += "           AND PBU_CPF = BA1_CPFUSR                                      									  " + CRLF
	cSQL += "           AND PBU.D_E_L_E_T_ = ' '                                     									  " + CRLF
	cSQL += "          WHERE BA1_FILIAL = ' '                                                                             " + CRLF
	cSQL += "            AND BA1_CODEMP IN ('0024')                                                                       " + CRLF
	cSQL += "            AND BA1_CODPLA IN ('0098','0099')                                                                " + CRLF
	cSQL += "            AND (BA1_DATBLO = ' ' OR TO_DATE(TRIM(BA1_DATBLO),'YYYYMMDD') > SYSDATE)                         " + CRLF
	cSQL += "            AND BA1010.D_E_L_E_T_ = ' ') BA1ODO                                                              " + CRLF
	cSQL += "  WHERE BA1MED.BA1_CODINT = BA1ODO.BA1_CODINT                                                                " + CRLF
	cSQL += "    AND BA1MED.BA1_CODEMP = BA1ODO.BA1_CODEMP                                                                " + CRLF
	cSQL += "    AND BA1MED.BA1_CPFUSR = BA1ODO.BA1_CPFUSR                                                                " + CRLF
	cSQL += "    AND BA1MED.BA1_MATVID = BA1ODO.BA1_MATVID                                                                " + CRLF
	cSQL += "    AND BA1MED.BA1_DATNAS = BA1ODO.BA1_DATNAS                                                                " + CRLF
	cSQL += "    AND BA1MED.BA1_TIPREG = BA1ODO.BA1_TIPREG 																  " + CRLF
	cSQL += "    AND BA1MED.BA1_TIPUSU = BA1ODO.BA1_TIPUSU																  " + CRLF

	If !empty(cCPFUsr)

		cSQL += "    AND BA1MED.BA1_MATRIC IN																		  	  " + CRLF
		cSQL += "    (														  	  										  " + CRLF
		cSQL += "    SELECT DISTINCT BA1_MATRIC														  	  			  " + CRLF
		cSQL += "    FROM BA1010 B														  	                           " + CRLF
		cSQL += "    WHERE B.BA1_FILIAL = ' '														  	                  " + CRLF
		cSQL += "      AND B.BA1_CPFUSR = '" + cCPFUsr + "'														  	      " + CRLF
		cSQL += "      AND B.BA1_CODINT = BA1MED.BA1_CODINT														  	      " + CRLF
		cSQL += "      AND B.BA1_CODEMP = BA1MED.BA1_CODEMP														  	      " + CRLF
		cSQL += "      AND B.D_E_L_E_T_ = ' '														  	                  " + CRLF
		cSQL += "    )														  	                                          " + CRLF

	EndIf

	cSQL += "  ORDER BY BA1MED.BA1_CPFUSR, BA1MED.BA1_GRAUPA                                                              " + CRLF

	TCQUERY cSQL ALIAS "TMPODO" NEW

	dbSelectArea( "TMPODO" )

	TMPODO->(DbGoTop())

	While !TMPODO->(EOF())

		DbSelectArea("BA1")

		BA1->(DbGoTo(TMPODO->REC_BA1MED))

		BA1->(RecLock("BA1",.F.))
		BA1->BA1_YMTODO := TMPODO->MATODO
		BA1->(MsUnlock())

		//Leonardo Portella - 29/05/15 - Inicio - Gravacao do tipo de beneficiario como Odontologico.
		//O campo BA1_XTPBEN originalmente foi idealizado para identificar matriculas vindas da agenda mas
		//como estes casos nao vem da agenda utilizo para identificar matriculas odontologicas no Browse.

		BA1->(DbGoTo(TMPODO->REC_BA1ODO))

		BA1->(RecLock("BA1",.F.))
		BA1->BA1_XTPBEN := 'ODONTO'
		BA1->(MsUnlock())

		//Leonardo Portella - 29/05/15 - Fim

		BA1->(DbCloseArea())

		TMPODO->(DbSkip())
	Enddo

	TMPODO->(DbCloseArea())

Return	

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³DPTpBnfbd   ºAutor  ³Paulo Motta         º Data ³  17/05/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Retorna o Depara dos Tipos de Benef ITAU (apenas para gra-   º±±
±±º          ³ vacao pois o Agregado e marcado como T (titular)             º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                           º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function DPTpBnfbd(cTipo)

	If cTipo == "L"
		cTipo := "D"
	EndIf
	/*apenas para gravacao pois o Agregado e marcado como T (titular) */
	If cTipo == "A"
		cTipo := "T"
	EndIf

Return( cTipo )

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³DParaBlq  ºAutor  ³Bianchini/Marcela   º Data ³  18/05/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Retorna o Depara dos Bloqueios de Benef ITAU               º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function DParaBlq(cBlq)

	cBlq := "017"

	If cBlq == "001"
		cBlq := "018"
	ElseIf cBlq == "002"
		cBlq := "018"
	ElseIf cBlq == "003"
		cBlq := "020"
	ElseIf cBlq == "004"
		cBlq := "003"
	ElseIf cBlq == "005"
		cBlq := "001"
	ElseIf cBlq == "006"
		cBlq := "019"
	ElseIf cBlq == "007"
		cBlq := "006"
	ElseIf cBlq == "008"
		cBlq := "019"
	ElseIf cBlq == "999"
		cBlq := "017"
	EndIf

Return(cBlq)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³DParaGrauPºAutor  ³Bianchini/Marcela   º Data ³  17/05/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Retorna o Depara dos Graus de Parentescos                  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function DParaGrauP(cGrauPa,cSexo)

	cGrauPa := AllTrim(cGrauPa)

	If cGrauPa == ""
		cGrauPa := "01"
	ElseIf cGrauPa == "C"   //Conjuge
		If cSexo == "1"
			cGrauPa := "04"
		Else
			cGrauPa := "02"
		EndIf
	ElseIf cGrauPa == "F"   //Filho
		If cSexo == "1"
			cGrauPa := "05"
		Else
			cGrauPa := "06"
		EndIf
	ElseIf cGrauPa == "T"   //
		cGrauPa := "01"
	ElseIf cGrauPa == "E"   //Enteado
		cGrauPa := "24"
	ElseIf cGrauPa == "O"   //
		cGrauPa := "11"
	ElseIf cGrauPa == "P"   //Pai
		cGrauPa := "07"
	ElseIf cGrauPa == "M"   //Mae
		cGrauPa := "08"
	ElseIf cGrauPa == "I"   //Irmao
		cGrauPa := "14"
	ElseIf cGrauPa == "H"
		cGrauPa := "03"
	ElseIf cGrauPa == "S"
		cGrauPa := "09"
	ElseIf cGrauPa == "G"
		cGrauPa := "10"
	EndIf

Return(cGrauPa)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±±
±±³Funcao    ³ lValidMae     ³ Autor ³ Bianchini/Marcela ³ Data ³ 12.12.2008 ³±±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±±
±±³Descricao ³ Checa para ver se o nome da mae eh obrigatorio ou nao se se³±±±
±±³          ³ causa rejeicao da operacao a ser realziada no registro     ³±±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function lValidMae(cNomMae)

	Local nRecnoBA1 := 0
	Local lRet 		:= .T.
	Local nI		:= 0

	cNomMae := AllTrim(cNomMae)

	If AllTrim(PBU->PBU_OPER) $ '1|2' //Inclusao e alteracao

		Do Case

			Case Empty(cNomMae) //Critica SIB
			lRet := .F.

			Case Len(cNomMae) <= 3 //Critica SIB
			lRet := .F.

		EndCase

		If lRet

			For nI := 1 to len(cNomMae)

				If Substr(cNomMae,nI,1) $ '0123456789@' //Critica SIB
					lRet := .F.
					Exit
				EndIf

			Next

		EndIf

	EndIf

Return lRet


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³IncluiUsr ºAutor  ³Bianchini/Marcela   º Data ³  18/05/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Funcao que trata a linha tipo inclusao                     º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function IncluiUsr(cCodPro)

	Local lTitCad 	:= .F.
	Local lUsuCad 	:= .F.
	Local cMatTit 	:= ""
	Local cMatUsr 	:= ""
	Local lFamCad 	:= .F.
	Local aProduto 	:= {}
	Local cVerPro 	:= '001'
	Local cCodBnf 	:= PBU->PBU_CDBENE
	Local cCodInt 	:= ''
	Local cCodOpe 	:= PBT->PBT_CODOPE
	Local lRet 		:= .F.
	Local cSql 		:= ''
	Local lNovaVida	:= .F.
	Local cQryVida	:= ''
	Local cAlVida	:= ''
	Local aArea

	Private lTit    	:= .F.
	Private lAgr    	:= .F.
	Private cNumCon 	:= ""
	Private cSubCon 	:= ""
	Private cNovaMatric := ""

	If AllTrim(PBU->PBU_OPER) $ '1' .and. PBU->PBU_CDBENE == 'T'
		cNovaMatric := PLPROXMAT(PBT->PBT_CODOPE,PBT->PBT_CODEMP)
	Else
		BA3->(dbSetOrder(5))

		If (BA3->(dbSeek(xFilial("BA1")+PBT->PBT_CODEMP+PBU->PBU_FUNC)))//Ja existe a familia cadastrada

			While !BA3->( EOF() ) .and. BA3->BA3_FILIAL + BA3->BA3_CODEMP + BA3->BA3_MATEMP =  xFilial("BA1")+PBT->PBT_CODEMP+PBU->PBU_FUNC
				If Empty( BA3->BA3_DATBLO ) //.and. ( BA3->BA3_CODPLA == cCodPro ) -- Angelo Henrique - Data: 01/09/2016 - Multi-planos prefeitura
					lFamCad := .T.
					Exit
				EndIf
				BA3->( dbSkip() )
			EndDo

			If !lFamCad
				cNovaMatric := PLPROXMAT(PBT->PBT_CODOPE,PBT->PBT_CODEMP)
			EndIf

		Else
			cNovaMatric := PLPROXMAT(PBT->PBT_CODOPE,PBT->PBT_CODEMP)
		EndIf
	EndIf

	cSql := "SELECT BA1_CODINT, BA1_CODEMP, BA1_MATRIC, BA1_TIPREG, BA1_TIPUSU, BA1.R_E_C_N_O_ AS BA1RECNO, BA1_MATEMP " 	+ CRLF
	cSql += "FROM "+RetSqlName("BA1")+" BA1, "+RetSqlName("BQC")+" BQC " 													+ CRLF
	cSql += "WHERE BA1_FILIAL = '"+xFilial("BA1")+"' " 																		+ CRLF
	cSql += "  AND BQC_FILIAL = '"+xFilial("BQC")+"' " 																		+ CRLF
	cSql += "  AND BQC.D_E_L_E_T_  = ' ' " 																					+ CRLF
	cSql += "  AND BA1.D_E_L_E_T_ = ' ' " 																					+ CRLF
	cSql += "  AND BQC.BQC_CODINT = BA1.BA1_CODINT " 																		+ CRLF
	cSql += "  AND BQC.BQC_CODEMP = BA1.BA1_CODEMP " 																		+ CRLF
	cSql += "  AND BQC.BQC_NUMCON = BA1.BA1_CONEMP " 																		+ CRLF
	cSql += "  AND BQC.BQC_VERCON = BA1.BA1_VERCON " 																		+ CRLF
	cSql += "  AND BQC.BQC_SUBCON = BA1.BA1_SUBCON " 																		+ CRLF
	cSql += "  AND BQC.BQC_VERSUB = BA1.BA1_VERSUB " 																		+ CRLF
	cSql += "  AND BA1.BA1_CODINT = '" + AllTrim(PBT->PBT_CODOPE) +"' " 													+ CRLF
	cSql += "  AND BA1.BA1_CODEMP = '" + AllTrim(PBT->PBT_CODEMP) +"' " 													+ CRLF

	If PBT->PBT_LAYOUT == '1'

		If AllTrim(PBU->PBU_CDBENE) == 'T'
			cSql += "  AND BA1.BA1_MATEMP LIKE '" + AllTrim(PBU->PBU_FUNC) + '-' + AllTrim(PBU->PBU_FUNC) + "%' " 			+ CRLF
		Else
			cSql += "  AND BA1.BA1_MATEMP LIKE '%-" + AllTrim(PBU->PBU_FUNC) + "%' " 										+ CRLF
		EndIf

		cSql += "  AND BA1.BA1_TIPUSU = '" + AllTrim(PBU->PBU_CDBENE)+"' " 													+ CRLF
	Else
		cSql += "  AND BA1.BA1_MATEMP = '" + AllTrim(PBU->PBU_FUNC)+"' " 													+ CRLF
		cSql += "  AND BA1.BA1_TIPREG = '" + AllTrim(PBU->PBU_DEPEND)+"' " 													+ CRLF
	EndIf

	cSql += "  AND BA1.BA1_CPFUSR = '" + AllTrim(PBU->PBU_CPF)+"' " 															+ CRLF
	cSql += "  AND BA1.BA1_CODPLA = '" + cCodPro + "' " 																		+ CRLF
	cSql += "  AND BA1.BA1_DATBLO = ' ' " 																					+ CRLF
	cSql += "ORDER BY BA1_MATEMP, BA1_CODINT, BA1_CODEMP, BA1_MATRIC, BA1_TIPREG, BA1.R_E_C_N_O_ " 							+ CRLF

	PlsQuery(cSql,"TMPBA1")

	TmpBA1->(DbGoTop())

	While !TmpBA1->(Eof())
		lUsuCad := .T.
		cMatUsr := TmpBA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG)
		TmpBA1->(DbSkip())
	Enddo

	TmpBA1->(DbCloseArea())

	If !lFamCad  // Familia Nao Cadastrada, deve-se cadastrar
		BI3->(DbSetOrder(1))

		If BI3->(DbSeek(xFilial("BI3")+cCodOpe+cCodPro+cVerPro))
			lFamCad := .T.
			//Criar Cliente Para levar para a Familia - PREFEITURA
			cCodcli := PreSA1(PBU->PBU_CPF,1)
			BA3->(RecLock("BA3",.T.))
			PreBA3(1,.T.,cCodcli)
			BA3->(MsUnlock())
		EndIf
	EndIf

	If !lUsuCad .and. lFamCad /// Esse usuario nao esta cadastrado

		BTS->(DBSetOrder(3))

		BTS->(DbSeek(xFilial("BTS") + AllTrim(PBU->PBU_CPF)) )

		lNovaVida	:= !BTS->(Found()) .or. ( BTS->BTS_DATNAS <> CtoD(PBU->PBU_DTNASC) )

		If lNovaVida .and. BTS->(Found())

			//Prefeitura tem encaminhado mudanca de CPF sem sequer informar o tipo de operacao. Tento verificar se deve
			//criar outra vida por aproximacao do nome em ultima instancia.

			aArea		:= GetArea()

			cAlVida		:= GetNextAlias()

			cQryVida 	:= "SELECT UTL_MATCH.JARO_WINKLER_SIMILARITY(" 														+ CRLF
			cQryVida 	+= "       ALFA_NUM_EXCECAO_PARAMETRO('" + Upper(AllTrim(PBU->PBU_BENEF)) + "')," 					+ CRLF
			cQryVida 	+= "       ALFA_NUM_EXCECAO_PARAMETRO('" + Upper(AllTrim(BTS->BTS_NOMUSR)) + "')) SIMILARIDADE" 	+ CRLF
			cQryVida 	+= "FROM DUAL" 																						+ CRLF

			TcQuery cQryVida New Alias cAlVida

			lNovaVida := ( cAlVida->SIMILARIDADE < 85 )

			cAlVida->(DbCloseArea())

			RestArea(aArea)

		EndIf

		If lNovaVida
			BTS->(RecLock("BTS",.T.))
			PreBTS(1,lTit,.T.)
			BTS->(MsUnlock())
		EndIf

		BA1->(RecLock("BA1",.T.))
		PreBA1(1, lTit, cCodPro, cVerPro, cCodBnf)

		BA1->(MsUnlock())
	EndIf

	AtuOpc( lFamCad )
	AtuAdesao()
	AtuProd()
	//AtuPbu()

	u_GerCarUsr(BA1->BA1_SUBCON, BA1->BA1_CODINT, BA1->BA1_CODEMP, BA1->BA1_MATRIC, BA1->BA1_TIPREG, BA1->BA1_CODPLA, BA1->BA1_DATINC, iif(PBU->PBU_INDCAR == '1', 'S','N'))

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³AltSub    ºAutor  ³Bianchini/Marcela   º Data ³  05/06/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Funcao que altera o subcontrato de uma familia             º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function AltSub(cTipo)

	Local lTit		:= .F.
	Local aRetorno	:= {}
	Local nRegBA1	:= 0
	Local cMatDes	:= ""
	Local _cMatAnt	:= ""
	Local aTmpFam	:= {}
	Local aTmpUsu	:= {}
	Local aVetTit	:= {}
	Local nCont		:= 0
	Local nCont2	:= 0
	Local lAgr		:= .F.
	Local cChave 	:= ""
	Local cChaveFun := ""
	Local cFunc 	:= ""
	Local aProduto 	:= {}
	//Local cCodPro := Space(0)
	Local cVerPro 	:= Space(0)
	Local cCodBnf 	:= Space(0)
	Local cSubCon 	:= Space(0)
	Local cCodInt 	:= Space(0)
	Local dDatBlo 	:= CtoD("  /  /    ")
	Local cMotBlo 	:= Space(0)
	Local n			:= 0

	Private cCodOpe := AllTrim(PBT->PBT_CODOPE)
	Private cCodEmp := AllTrim(PBT->PBT_CODEMP)

	cCodInt  := cCodOpe

	cSubCon   := ""

	If cTipo == 1
		cFunc     := PBU->PBU_FUNC
		cChave    := PBT->PBT_CODEMP+PBU->PBU_FUNC
		cChaveFun := PBU->(PBU_FUNC+PBU_DEPEND)
	ElseIf cTipo = 2
		cFunc     := PBU->PBU_FUNANT
		cChave    := PBT->PBT_CODEMP+PBU->PBU_FUNANT
		cChaveFun := PBU->(PBU_FUNANT+PBU_DEPEND)
	EndIf

	lTit := PBU->PBU_CDBENE == 'T'  //cria uma nova familia para o titular
	lAgr := PBU->PBU_CDBENE == 'A'  //cria uma nova familia para o agregado ou inclui em uma ja existente

	If lTit
		aAdd(aVetTit,cFunc)
	EndIf

	BA3->(dbSetOrder(5))   // Pesquiso a familia do titular ou do agregado
	If BA3->(dbSeek(xFilial("BA3")+cchave)) .and. (lTit .Or. lAgr)  //Nao pesquisa se for depedente.
		If lTit   //Somente para titular
			//Pesquiso a familia do titular e guardo a que nao esta bloqueada.
			While !BA3->(Eof()) .and. AllTrim(BA3->(BA3_CODEMP+BA3_MATEMP)) == AllTrim(cChave)
				//While !BA3->(Eof()) .and. AllTrim(BA3->(BA3_CODEMP+BA3_MATEMP)) == AllTrim(PBT->PBT_CODEMP+PBU->PBU_FUNC)
				If Empty(BA3->BA3_DATBLO)
					aAdd(aTmpFam,BA3->(RECNO()))
				EndIf
				BA3->(DbSkip())
			Enddo
		Else   // somente para agregado
			If ascan(aVetTit,cFunc) == 0 //TESTE ANT
				While !BA3->(Eof()) .and. AllTrim(BA3->(BA3_CODEMP+BA3_MATEMP)) == AllTrim(cChave)   //AllTrim(PBT->PBT_CODEMP+PBU->PBU_FUNC)
					//While !BA3->(Eof()) .and. AllTrim(BA3->(BA3_CODEMP+BA3_MATEMP)) == AllTrim(PBT->PBT_CODEMP+PBU->PBU_FUNCANT)
					If Empty(BA3->BA3_DATBLO)

						BA1->(DbSetOrder(1))
						BA1->(MsSeek(xFilial("BA1")+BA3->(BA3_CODINT+BA3_CODEMP+BA3_MATRIC)))

						While !BA1->(Eof()) .and. BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC) == BA3->(BA3_CODINT+BA3_CODEMP+BA3_MATRIC)

							If AllTrim(BA1->BA1_MATEMP) == AllTrim(cChaveFun) .and. Empty(BA1->BA1_DATBLO)
								aAdd(aTmpFam,BA3->(RECNO()))
								Exit
							EndIf

							BA1->(DbSkip())

						Enddo
					EndIf
					BA3->(DbSkip())
				Enddo
			EndIf
		EndIf

		For nCont := 1 to Len(aTmpFam)

			BA3->(DbGoTo(aTmpFam[nCont]))

			/*
			If AllTrim(PBT->PBT_CTREMP) == "01115"  //Beneficiarios Ativos
			cNumCon := "000000000001"
			ElseIf AllTrim(PBT->PBT_CTREMP) == "01123" //Beneficiarios Inativos
			cNumCon := "000000000002"
			//TORNAR GENÉRICA
			ElseIf AllTrim(PBT->PBT_CODEMP) <> "0006"
			cNumCon := PBT->PBT_NUMCON
			EndIf

			cSql := "SELECT * FROM "+RetSqlName("BQC")+" Where BQC_CODIGO = '"+PBT->PBT_CODOPE+PBT->PBT_CODEMP+"'"
			cSql += " AND BQC_NUMCON = '"+cNumCon+"'"
			cSql += " AND BQC_VERCON = '001'
			cSql += " AND BQC_ANTCON = '"+PBU->PBU_CODEMP+"' AND D_E_L_E_T_ = ' '"
			PlsQuery(cSql,"TMPBQC")
			If !TMPBQC->(EOF())
			While !TMPBQC->(EOF())
			BT0->(DbSetOrder(1))
			lPode   := .F.
			//cSubCon := ""
			If BT0->(DbSeek(xFilial("BT0")+PBT->(PBT_CODOPE+PBT_CODEMP)+cNumCon+"001"+TMPBQC->(BQC_SUBCON+BQC_VERSUB)+dParaPrd(PBU->PBU_PADRAO,dParaTpBnf(PBU->PBU_CDBENE))+"001"))
			lPode   := .T.
			While !BT0->(EOF()) .and. BT0->(BT0_FILIAL+BT0_CODIGO+BT0_NUMCON+BT0_VERCON+BT0_SUBCON+BT0_VERSUB+BT0_CODPRO+BT0_VERSAO) == PBT->PBT_FILIAL+PBT->PBT_CODOPE+PBT->PBT_CODEMP+cNumCon+"001"+TMPBQC->BQC_SUBCON+TMPBQC->BQC_VERSUB+dParaPrd(PBU->PBU_PADRAO,dParaTpBnf(PBU->PBU_CDBENE))+"001"
			If BT0->BT0_TIPUSR == dParaTpBnf(PBU->PBU_CDBENE) .and. BT0->BT0_ATIVO == "1"
			lPode := .T.
			ElseIf BT0->BT0_TIPUSR == DParaTpBnf(PBU->PBU_CDBENE) .and. BT0->BT0_ATIVO == "2"
			lPode := .F.
			EndIf
			BT0->(DbSkip())
			Enddo
			EndIf
			If lPode
			cSubCon := TMPBQC->BQC_SUBCON
			EndIf
			TMPBQC->(DbSkip())
			Enddo
			EndIf
			TMPBQC->(DbCloseArea())

			If cSubCon == ""
			cSubCon := "000000001" // 18/5/07
			EndIf
			*/

			/*
			cSql := "SELECT DISTINCT BTO_CODINT, BT0_CODPRO, BT0_VERSAO, BT0_NUMCON, BT0_VERCON, BT0_SUBCON, BT0_VERSUB "
			cSql += " FROM "+RetSqlName("BT0")+" BT0, "+ RetSqlName("BQC")+" BQC "
			cSql += " WHERE BT0.d_e_l_e_t_ = ' ' "
			cSql += " AND BT0_YCDEDI = " + AllTrim(PBU->PBU_PADRAO)
			cSql += " AND BT0_YTPUSR = " + AllTrim(PBU->PBU_CDBENE)
			cSql += " AND BQC.d_e_l_e_t_ = ' ' "
			cSql += " AND BQC_CODIGO = BT0_CODIGO "
			cSql += " AND BQC_NUMCON = BT0_NUMCON "
			cSql += " AND BQC_VERCON = BT0_VERCON "
			cSql += " AND BQC_SUBCON = BT0_SUBCON "
			cSql += " AND BQC_VERSUB = BT0_VERSUB "
			cSql += " AND BQC_YCDCON = " + AllTrim(PBU->PBU_CONTR)
			cSql += " AND BQC_ANTCON = " + AllTrim(PBU->PBU_FILIT)
			PlsQuery(cSql,"TMPBT0")

			If !TMPBT0->(EOF())
			While !TMPBT6->(EOF())
			cProduto += AllTrim(TMPBT0->BT0_CODPRO) + "_"
			cVerPro += AllTrim(TMPBT0->BT0_VERSAO) + "_"
			cNumCon += AllTrim(TMPBT0->BT0_NUMCON) + "_"
			cVerCon += AllTrim(TMPBT0->BT0_VERCON) + "_"
			cSubCon += AllTrim(TMPBT0->BT0_SUBCON) + "_"
			cVerSub += AllTrim(TMPBT0->BT0_VERSUB) + "_"
			cCodInt += SubStr(AllTrim(TMPBT0->BT0_CODINT),1,4) + "_"
			TMPBT0->(DbSkip())
			Enddo
			EndIf
			TMPBT0->(DbCloseArea())

			cProduto := Substr(cProduto,1,Len(AllTrim(cProduto))-1)
			cVerPro  := Substr(cVerPro,1,Len(AllTrim(cVerPro))-1)
			cNumCon  := Substr(cNumCon,1,Len(AllTrim(cNumCon))-1)
			cVerCon  := Substr(cVerCon,1,Len(AllTrim(cVerCon))-1)
			cSubCon  := Substr(cSubCon,1,Len(AllTrim(cSubCon))-1)
			cVerSub  := Substr(cVerSub,1,Len(AllTrim(cVerSub))-1)
			*/

			aProduto := dParaPrd()
			//		If Len(aProduto) <= 0
			//			Return(.F.)
			//		EndIf

			For n := 1 to Len(aProduto)
				If aProduto[n,1] <> "0"
					Return(.F.)
				EndIf
				cCodPro := aProduto[n,2]
				cVerPro := aProduto[n,3]
				cNumCon := aProduto[n,4]
				cVerCon := aProduto[n,5]
				cSubCon := aProduto[n,6]
				cVerSub := aProduto[n,7]
				cCodBnf := aProduto[n,8]
				cCodInt := aProduto[n,9]
			Next


			BI3->(DbSetOrder(1))  //Tabela de Produtos Saude
			//		If BI3->(DbSeek(xFilial("BT6")+BT6->BT6_CODINT+dParaPrd(PBU->PBU_PADRAO,dParaTpBnf(PBU->PBU_CDBENE))+"001"))
			If BI3->(DbSeek(xFilial("BI3")+cCodInt+cCodPro+cVerPro))

				aRetorno := CopiaReg("BA3")  //bloqueia a familia anterior

				cNovaMatric := PLPROXMAT(PBT->PBT_CODOPE,PBT->PBT_CODEMP)
				_cMatAnt := BA3->BA3_MATRIC

				//Insere a nova familia
				BA3->(RecLock("BA3",.F.))
				BA3->BA3_CONEMP := cNumCon
				BA3->BA3_VERCON := cVerCon
				BA3->BA3_SUBCON := cSubCon
				BA3->BA3_VERSUB := cVerSub
				BA3->BA3_MATRIC	:= cNovaMatric
				BA3->BA3_CODPLA	:= cCodPro //cProduto
				BA3->BA3_VERSAO	:= cVerPro
				BA3->BA3_TIPCON	:= BI3->BI3_TIPCON
				BA3->BA3_SEGPLA	:= BI3->BI3_CODSEG
				BA3->BA3_MODPAG	:= BI3->BI3_MODPAG
				BA3->BA3_TXUSU	:= '0'
				BA3->BA3_APLEI	:= BI3->BI3_APOSRG
				BA3->BA3_CODACO	:= BI3->BI3_CODACO
				BA3->BA3_ABRANG	:= BI3->BI3_ABRANG
				//BA3->BA3_DATBAS := ctod(PBU->PBU_DTINPD)// Marcela Coimbra em 13/09/10
				BA3->BA3_DATBAS := ctod(PBU->PBU_DTINCT)// Marcela Coimbra em 26/10/10 - Conforme contato ITAU
				// BA3->BA3_DATBAS := ctod(PBU->PBU_DTINCO) Marcela Coimbra em 13/10/10 PBU_DTINPD
				//BA3->BA3_TIPPAG	:=	"07" //MOTTA 19/03/12
				BA3->BA3_TIPPAG	:=	"09" //Angelo Henrique - Data: 02/08/2016
				BA3->(MsUnlock())

				//Bloquear registro anterior
				dDatBlo         := Iif(!Empty(AllTrim(PBU->PBU_DTEXC)),ctod(PBU->PBU_DTEXC),iif(!Empty(AllTrim(PBU->PBU_DTFIPD)),ctod(PBU->PBU_DTFIPD),MSDATE()))
				cMotBlo         := Iif(!Empty(CtoD(AllTrim(PBU->PBU_MOTEXC))),dParaBlq(PBU->PBU_MOTEXC),"009")

				BA3->(DbGoTo(aRetorno[1]))
				BA3->(RecLock("BA3",.F.))
				//			BA3->BA3_DATBLO := (dDataBase - 1)
				BA3->BA3_MOTBLO := GetNewPar("MV_YMTBLTI","006")
				//			BA3->BA3_MOTBLO	:= cMotBlo   //iif(!Empty(CtoD(AllTrim(PBU->PBU_MOTEXC))),dParaBlq(PBU->PBU_MOTEXC),"009") // sera lancado valor default Paulo Motta 18/01/07
				BA3->BA3_DATBLO	:= dDatBlo   //iif(!Empty(AllTrim(PBU->PBU_DTEXC)),ctod(PBU->PBU_DTEXC),MSDATE())
				BA3->(MsUnlock())

				//Historico de Bloqueio
				BloqFam(BA3->(BA3_CODINT+BA3_CODEMP+BA3_MATRIC),BA3->BA3_MATANT,BA3->BA3_DATBLO,BA3->BA3_MOTBLO)

				BC3->(Reclock("BC3",.T.))
				BC3->BC3_FILIAL := xFilial("BC3")
				BC3->BC3_MATRIC := BA3->(BA3_CODINT+BA3_CODEMP+BA3_MATRIC)
				BC3->BC3_TIPO   := "0"
				BC3->BC3_DATA   := BA3->BA3_DATBLO
				BC3->BC3_MOTBLO := BA3->BA3_MOTBLO
				BC3->BC3_OBS    := "Historico de transferencia"
				BC3->BC3_MATANT := BA3->BA3_MATANT
				BC3->BC3_BLOFAT := "1"
				BC3->BC3_NIVBLQ := "F"
				BC3->BC3_USUOPE := cUserName
				BC3->(MsUnlock())

				BA3->(DbGoTo(aTmpFam[nCont]))

				AtuProd()
				AtuOpc()
				AtuAdesao()

				aTmpUsu := {}

				BA1->(dbSetOrder(1))
				If BA1->(dbSeek(xFilial("BA1")+BA3->BA3_CODINT+BA3->BA3_CODEMP+_cMatAnt))

					While !BA1->(EOF()) .and. BA1->BA1_FILIAL+BA1->BA1_CODINT+BA1->BA1_CODEMP+BA1->BA1_MATRIC == 	BA3->BA3_FILIAL+BA3->BA3_CODINT+BA3->BA3_CODEMP+_cMatAnt
						If Empty(BA1->BA1_DATBLO)
							aAdd(aTmpUsu,BA1->(RECNO()))
						EndIf
						BA1->(DbSkip())
					Enddo

					For nCont2 := 1 to Len(aTmpUsu)

						BA1->(DbGoTo(aTmpUsu[nCont2]))

						//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
						//³ Cond. implementada para evitar laco infinito nos novos regs.        ³
						//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
						If BA1->BA1_IMPORT <> "HISTITAU"
							aRetorno := CopiaReg("BA1")  //Bloqueia a familia anterior

							BA1->(RecLock("BA1",.F.))
							BA1->BA1_CONEMP := cNumCon
							BA1->BA1_VERCON := cVerCon
							BA1->BA1_SUBCON := cSubCon
							BA1->BA1_VERSUB := cVerSub
							BA1->BA1_MATRIC := cNovaMatric   //BA3->BA3_MATRIC
							//BA1->BA1_TIPREG	// NAO NECESSARIO MODIFICAR POIS EH COPIA DO BA1 ANTERIOR...
							BA1->BA1_DIGITO :=	Modulo11(BA1->BA1_CODINT+BA1->BA1_CODEMP+BA1->BA1_MATRIC+BA1->BA1_TIPREG)
							BA1->BA1_CODPLA := cCodPro //cProduto    //dParaPrd(PBU->PBU_PADRAO,dParaTpBnf(PBU->PBU_CDBENE))   //BA3->BA3_CODPLA
							BA1->BA1_VERSAO := cVerPro     //BA3->BA3_VERSAO
							BA1->BA1_TRAORI := aRetorno[2]
							BA1->BA1_DATTRA := dDataBase
							BA1->BA1_DATINC := BA1->BA1_DATTRA

							//Trecho de código inserido por Luzio em 14/07/09 para que insira o codigo do produto do beneficiario transferido de dependencia.
							BA1->BA1_DATINC := ctod(PBU->PBU_DTINCO)
							BA1->BA1_DTVLCR := ctod("  /  /    ")
							BA1->BA1_EMICAR := " "
							BA1->BA1_VIACAR := 0

							BA1->BA1_LOCANS	:=	'1'
							BA1->BA1_INFSIB	:=	'1'
							BA1->BA1_INFANS	:=	'1'

							BA1->BA1_LOCSIB	:=	'0'

							BA1->BA1_ATUSIB :=  '1'
							BA1->BA1_INCANS := CTOD("  /  /    ")
							BA1->BA1_ENVANS := CTOD("  /  /    ")
							BA1->BA1_EXCANS := CTOD("  /  /    ")

							BA1->(MsUnlock())

							//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
							//³ Integridade entre matricula antiga / origem e destino.              ³
							//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
							cMatDes := BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG+BA1_DIGITO)

							BA1->(DbGoTo(aRetorno[1])) //Posiciona no novo registro da matricula de historico.
							BA1->(RecLock("BA1",.F.))
							BA1->BA1_TRADES := cMatDes
							BA1->(MsUnlock())

							BA1->(DbGoTo(aTmpUsu[nCont2]))

						EndIf

					Next
				EndIf
			EndIf

			AtuProd()
			AtuOpc()
			AtuAdesao()
		Next

	EndIf

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³AltSubUsu ºAutor  ³Bianchini/Marcela   º Data ³  05/06/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Funcao que altera o subcontrato de um beneficiario         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function AltSubUsu()

	Local aRetorno 	:= {}
	Local nRegBA1 	:= 0
	Local cMatDes 	:= ""
	Local nRecnoBA1 := 0
	Local n			:= 0

	**'--Início: Marcela Coimbra -Data: 19/05/10 -----------------'**

	Private cTipUsr := ""

	**'--Início: Marcela Coimbra -Data: 19/05/10 -----------------'**
	cSubCon := ""

	//BA1->(dbSetOrder(6))
	//If BA1->(dbSeek(xFilial("BA1")+PBU->PBU_FUNC+"00"))  //Pesquisa o titular da Familia pela funcional

	**'--Início: Marcela Coimbra -Data: 18/05/10 -----------------'**

	// nRecnoBA1 := ProMatEmp(AllTrim(PBT->PBT_CODOPE),AllTrim(PBT->PBT_CODEMP),cMatric,AllTrim(PBU->PBU_DEPEND))    //Verifica se a data de bloqueio eh menor que a data de inclusao do beneficiario no contrato/produto
	nRecnoBA1 := ProMatEmp(AllTrim(PBT->PBT_CODOPE),AllTrim(PBT->PBT_CODEMP),AllTrim(PBU->PBU_FUNC),AllTrim(PBU->PBU_DEPEND))    //Verifica se a data de bloqueio eh menor que a data de inclusao do beneficiario no contrato/produto

	**'--Fim: Marcela Coimbra -Data: 18/05/10 --------------------'**
	If nRecnoBA1 > 0
		BA1->(dbGoTo(nRecnoBA1))

		BA3->(dbSetOrder(1))
		If BA3->(dbSeek(xFilial("BA3")+BA3->BA3_CODINT+BA3->BA3_CODEMP+BA3->BA3_MATRIC))
			/*
			If AllTrim(PBT->PBT_CTREMP) == "01115"  //Ativos
			cNumCon := "000000000001"
			ElseIf AllTrim(PBT->PBT_CTREMP) == "01123"  //Inativos
			cNumCon := "000000000002"
			ElseIf AllTrim(PBT->PBT_CODEMP) <> "0006"
			cNumCon := PBT->PBT_SUBCON
			//TORNAR GENÉRICA
			EndIf

			cSql := "SELECT * FROM "+RetSqlName("BQC")+" Where BQC_CODIGO = '"+PBT->PBT_CODOPE+PBT->PBT_CODEMP+"'"
			cSql += " AND BQC_NUMCON = '"+cNumCon+"'"
			cSql += " AND BQC_VERCON = '001' "
			cSql += " AND BQC_ANTCON = '"+PBU->PBU_CODEMP+"' AND D_E_L_E_T_ = ' '"
			PlsQuery(cSql,"TMPBQC")
			If !TMPBQC->(EOF())
			While !TMPBQC->(EOF())
			BT0->(DbSetOrder(1))
			lPode   := .F.
			//cSubCon := ""
			If BT0->(DbSeek(xFilial("BT0")+PBT->PBT_CODOPE+PBT->PBT_CODEMP+cNumCon+"001"+TMPBQC->BQC_SUBCON+TMPBQC->BQC_VERSUB+dParaPrd(PBU->PBU_PADRAO,dParaTpBnf(PBU->PBU_CDBENE))+"001"))
			lPode   := .T.
			While !BT0->(EOF()) .and. BT0->(BT0_FILIAL+BT0_CODIGO+BT0_NUMCON+BT0_VERCON+BT0_SUBCON+BT0_VERSUB+BT0_CODPRO+BT0_VERSAO) == PBT->PBT_FILIAL+PBT->PBT_CODOPE+PBT->PBT_CODEMP+cNumCon+"001"+TMPBQC->BQC_SUBCON+TMPBQC->BQC_VERSUB+dParaPrd(PBU->PBU_PADRAO,dParaTpBnf(PBU->PBU_CDBENE))+"001"
			If BT0->BT0_TIPUSR == dParaTpBnf(PBU->PBU_CDBENE) .and. BT0->BT0_ATIVO == "1"
			lPode := .T.
			ElseIf BT0->BT0_TIPUSR == DParaTpBnf(PBU->PBU_CDBENE) .and. BT0->BT0_ATIVO == "2"
			lPode := .F.
			EndIf
			BT0->(DbSkip())
			Enddo
			EndIf
			If lPode
			cSubCon := TMPBQC->BQC_SUBCON
			EndIf
			TMPBQC->(DbSkip())
			Enddo
			EndIf
			TMPBQC->(DbCloseArea())

			If cSubCon == ""
			cSubCon := "000000001"
			EndIf
			*/

			/*
			cSql := "SELECT DISTINCT BT0_CODPRO, BT0_VERSAO, BT0_NUMCON, BT0_VERCON, BT0_SUBCON, BT0_VERSUB, BT0_TIPUSR "
			cSql += " FROM "+RetSqlName("BT0")+" BT0, "+ RetSqlName("BQC")+" BQC "
			cSql += " WHERE BT0.d_e_l_e_t_ = ' ' "
			cSql += " AND BT0_YCDEDI = " + AllTrim(PBU->PBU_PADRAO)
			cSql += " AND BT0_YTPUSR = " + AllTrim(PBU->PBU_CDBENE)
			cSql += " AND BQC.d_e_l_e_t_ = ' ' "
			cSql += " AND BQC_CODIGO = BT0_CODIGO "
			cSql += " AND BQC_NUMCON = BT0_NUMCON "
			cSql += " AND BQC_VERCON = BT0_VERCON "
			cSql += " AND BQC_SUBCON = BT0_SUBCON "
			cSql += " AND BQC_VERSUB = BT0_VERSUB "
			cSql += " AND BQC_YCDCON = " + AllTrim(PBU->PBU_CONTR)
			cSql += " AND BQC_ANTCON = " + AllTrim(PBU->PBU_FILIT)
			PlsQuery(cSql,"TMPBT0")

			If !TMPBT0->(EOF())
			While !TMPBT0->(EOF())
			cProduto += AllTrim(TMPBT0->BT0_CODPRO) + "_"
			cVerPro += AllTrim(TMPBT0->BT0_VERSAO) + "_"
			cNumCon += AllTrim(TMPBT0->BT0_NUMCON) + "_"
			cVerCon += AllTrim(TMPBT0->BT0_VERCON) + "_"
			cSubCon += AllTrim(TMPBT0->BT0_SUBCON) + "_"
			cVerSub += AllTrim(TMPBT0->BT0_VERSUB) + "_"
			cTipUsr += AllTrim(TMPBT0->BT0_TIPUSR) + "_"
			TMPBT0->(DbSkip())
			Enddo
			EndIf
			TMPBT0->(DbCloseArea())

			cProduto := Substr(cProduto,1,Len(AllTrim(cProduto))-1)
			cVerPro  := Substr(cVerPro,1,Len(AllTrim(cVerPro))-1)
			cNumCon  := Substr(cNumCon,1,Len(AllTrim(cNumCon))-1)
			cVerCon  := Substr(cVerCon,1,Len(AllTrim(cVerCon))-1)
			cSubCon  := Substr(cSubCon,1,Len(AllTrim(cSubCon))-1)
			cVerSub  := Substr(cVerSub,1,Len(AllTrim(cVerSub))-1)
			cTipUsr  := Substr(cTipUsr,1,Len(AllTrim(cTipUsr))-1)
			*/

			aProduto := dParaPrd()
			//		If Len(aProduto) <= 0
			//			Return(.F.)
			//		EndIf

			For n := 1 to Len(aProduto)
				If aProduto[n,1] <> "0"
					Return(.F.)
				EndIf
				cCodPro := aProduto[n,2]
				cVerPro := aProduto[n,3]
				cNumCon := aProduto[n,4]
				cVerCon := aProduto[n,5]
				cSubCon := aProduto[n,6]
				cVerSub := aProduto[n,7]
				cCodBnf := aProduto[n,8]
				cCodInt := aProduto[n,9]
			Next

			BI3->(DbSetOrder(1))
			//		If BI3->(DbSeek(xFilial("BI3")+cCodOpe+cProduto+cVerPro))  //dParaPrd(PBU->PBU_PADRAO,dParaTpBnf(PBU->PBU_CDBENE))+"001"))
			If BI3->(DbSeek(xFilial("BI3")+cCodOpe+cCodPro+cVerPro))  //dParaPrd(PBU->PBU_PADRAO,dParaTpBnf(PBU->PBU_CDBENE))+"001"))

				// Verifico se o Contrato desse usuario agora é diferente da Familia
				If BA3->BA3_CONEMP <> cNumCon .Or. BA3->BA3_SUBCON <> cSubCon
					cNovaMatric := PLPROXMAT(PBT->PBT_CODOPE,PBT->PBT_CODEMP)

					//Crio uma nova familia para este beneficiario
					BA3->(RecLock("BA3",.T.))
					PreBA3(1,.T.)
					BA3->(MsUnlock())

					//				BA1->(dbSetOrder(6))
					//				If BA1->(dbSeek(xFilial("BA1")+PBU->PBU_FUNC+PBU->PBU_DEPEND))

					nRecnoBA1 := ProMatEmp(AllTrim(PBT->PBT_CODOPE),AllTrim(PBT->PBT_CODEMP),AllTrim(PBU->PBU_FUNC),AllTrim(PBU->PBU_DEPEND))    //Verifica se a data de bloqueio eh menor que a data de inclusao do beneficiario no contrato/produto
					If nRecnoBA1 > 0
						BA1->(dbGoTo(nRecnoBA1))

						aRetorno := CopiaReg("BA1")

						BA1->(RecLock("BA1",.F.))
						BA1->BA1_CODINT	:= BA3->BA3_CODINT
						BA1->BA1_CODEMP	:= BA3->BA3_CODEMP
						BA1->BA1_MATRIC	:= BA3->BA3_MATRIC
						BA1->BA1_TIPREG	:= Iif(PBU->PBU_CDBENE == 'A',"00", VerTipReg(BA3->BA3_CODINT + BA3->BA3_CODEMP + BA3->BA3_MATRIC, dParaGrauP(PBU->PBU_TPPARE,iif(PBU->PBU_SEXO =="M","1","2")), PBU->PBU_DEPEND, cTipUsr))  //DParaTpBnf(PBU->PBU_PADRAO, PBU->PBU_CDBENE)))  //PBU->PBU_DEPEND
						BA1->BA1_CONEMP	:= cNumCon   //CBA3->BA3_CONEMP
						BA1->BA1_VERCON	:= cVerCon   //BA3->BA3_VERCON
						BA1->BA1_SUBCON	:= cSubCon   //BA3->BA3_SUBCON
						BA1->BA1_VERSUB	:= cVerSub   //BA3->BA3_VERSUB
						BA1->BA1_TIPUSU := cTipUsr
						BA1->BA1_GRAUPA := dParaGrauP(PBU->PBU_TPPARE,iif(PBU->PBU_SEXO =="M","1","2"))
						BA1->BA1_IMAGE	:=	'ENABLE'

						BA1->BA1_DATBLO := BA3->BA3_DATBLO
						BA1->BA1_MOTBLO := BA3->BA3_MOTBLO

						BA1->BA1_DIGITO := Modulo11( BA1->BA1_CODINT + BA1->BA1_CODEMP + BA1->BA1_MATRIC + BA1->BA1_TIPREG )
						BA1->BA1_TRAORI := aRetorno[2]
						BA1->BA1_DATTRA := dDataBase

						//Trecho de código inserido por Luzio em 11/05/09 para que insira o codigo do produto do beneficiario transferido de dependencia.
						BA1->BA1_DATINC := ctod(PBU->PBU_DTINCO)
						BA1->BA1_DTVLCR := ctod("  /  /    ")
						BA1->BA1_CODPLA	:= cCodPro   //cProduto   //dParaPrd(PBU->PBU_PADRAO,dParaTpBnf(PBU->PBU_CDBENE))
						BA1->BA1_VERSAO	:= cVerPro    //"001"

						BA1->(MsUnlock())

						//Trecho de fonte comentado por Luzio em 21/01/2009, O Bloqueio do usuario ja foi realizado pela funcao COPIAREG chamada acima
						//					//Historico de Bloqueio
						//					BloqUsu(BA1->(BA1_CODINT + BA1_CODEMP + BA1_MATRIC),BA1->BA1_TIPREG, BA1->BA1_MATANT, BA1->BA1_DATBLO, BA1->BA1_MOTBLO)

						//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
						//³ Integridade entre matricula antiga / origem e destino.              ³
						//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
						nRegBA1 := BA1->(Recno())
						cMatDes := BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG+BA1_DIGITO)

						BA1->(DbGoTo(aRetorno[1])) //Posiciona no novo registro da matricula de historico.
						BA1->(RecLock("BA1",.F.))
						BA1->BA1_TRADES := cMatDes
						BA1->(MsUnlock())
						BA1->(DbGoTo(nRegBA1)) //Retorna o BA1 a posicao original, e prossegue a execucao da rotina.

					EndIf
				Else
					//				BA1->(dbSetOrder(6))
					//				If BA1->(dbSeek(xFilial("BA1")+PBU->PBU_FUNC+PBU->PBU_DEPEND))  //TESTE ANT
					//If BA1->(dbSeek(xFilial("BA1")+PBU->PBU_FUNANT+PBU->PBU_DEPEND))
					nRecnoBA1 := ProMatEmp(AllTrim(PBT->PBT_CODOPE),AllTrim(PBT->PBT_CODEMP),AllTrim(PBU->PBU_FUNC),AllTrim(PBU->PBU_DEPEND))    //Verifica se a data de bloqueio eh menor que a data de inclusao do beneficiario no contrato/produto
					If nRecnoBA1 > 0
						BA1->(dbGoTo(nRecnoBA1))

						If BA3->BA3_CONEMP <> BA1->BA1_CONEMP .Or. BA3->BA3_SUBCON <> BA1->BA1_SUBCON

							aRetorno := CopiaReg("BA1")

							BA1->(RecLock("BA1",.F.))
							BA1->BA1_CODINT	:=	BA3->BA3_CODINT
							BA1->BA1_CODEMP	:=	BA3->BA3_CODEMP
							BA1->BA1_MATRIC	:=	BA3->BA3_MATRIC
							BA1->BA1_TIPREG	:=	Iif(PBU->PBU_CDBENE == 'A',"00",VerTipReg(BA3->BA3_CODINT + BA3->BA3_CODEMP + BA3->BA3_MATRIC, dParaGrauP(PBU->PBU_TPPARE,iif(PBU->PBU_SEXO =="M","1","2")), PBU->PBU_DEPEND, cTipUsr ))   //DParaTpBnf(PBU->PBU_CDBENE)))  //PBU->PBU_DEPEND
							//						BA1->BA1_TIPREG := VerTipReg(BA3->BA3_CODINT + BA3->BA3_CODEMP + BA3->BA3_MATRIC, dParaGrauP(PBU->PBU_TPPARE,iif(PBU->PBU_SEXO =="M","1","2")), PBU->PBU_DEPEND, DParaTpBnf(PBU->PBU_CDBENE))
							BA1->BA1_CONEMP	:=	BA3->BA3_CONEMP
							BA1->BA1_VERCON	:=	BA3->BA3_VERCON
							BA1->BA1_SUBCON	:=	BA3->BA3_SUBCON
							BA1->BA1_VERSUB	:=	BA3->BA3_VERSUB
							BA1->BA1_IMAGE	 :=	'ENABLE'

							//						BA1->BA1_TIPREG := VerTipReg(BA3->BA3_CODINT + BA3->BA3_CODEMP + BA3->BA3_MATRIC, dParaGrauP(PBU->PBU_TPPARE,iif(PBU->PBU_SEXO =="M","1","2")), PBU->PBU_DEPEND, DParaTpBnf(PBU->PBU_CDBENE))
							BA1->BA1_TIPREG	:=	Iif(PBU->PBU_CDBENE == 'A',"00",VerTipReg(BA3->BA3_CODINT + BA3->BA3_CODEMP + BA3->BA3_MATRIC, dParaGrauP(PBU->PBU_TPPARE,iif(PBU->PBU_SEXO =="M","1","2")), PBU->PBU_DEPEND, cTipUsr ))  //DParaTpBnf(PBU->PBU_CDBENE)))  //PBU->PBU_DEPEND

							BA1->BA1_DIGITO := Modulo11( BA1->BA1_CODINT + BA1->BA1_CODEMP + BA1->BA1_MATRIC + BA1->BA1_TIPREG )
							BA1->BA1_TRAORI := aRetorno[2]
							BA1->BA1_DATTRA := dDataBase


							BA1->BA1_DIGITO := Modulo11( BA1->BA1_CODINT + BA1->BA1_CODEMP + BA1->BA1_MATRIC + BA1->BA1_TIPREG )
							BA1->BA1_TIPUSU := cTipUsr   //DParaTpBnf(PBU->PBU_PADRAO, PBU->PBU_CDBENE)    //DPTpBnfbd(PBU->PBU_CDBENE)
							BA1->BA1_GRAUPA := dParaGrauP(PBU->PBU_TPPARE,iif(PBU->PBU_SEXO =="M","1","2"))

							If (PBU->PBU_OPERSI == "04" .and. PBU->PBU_OPER == "02")
								BA1->BA1_DATINC := ctod(PBU->PBU_DTINCO)
							Else
								BA1->BA1_DATINC := iif(PBU->PBU_OPER $ "04_05",ctod(PBU->PBU_DTINPD),ctod(PBU->PBU_DTINPD))  //ctod(PBU->PBU_DTINCT))
							EndIf
							BA1->BA1_DTVLCR := ctod("  /  /    ")
							BA1->BA1_CODPLA := cCodPro    //cProduto  //dParaPrd(PBU->PBU_PADRAO,dParaTpBnf(PBU->PBU_CDBENE))   //BA3->BA3_CODPLA  //BI3->BI3_CODIGO
							BA1->BA1_VERSAO := cVerPro   //"001"                                                   //BA3->BA3_VERSAO
							BA1->(MsUnlock())

							//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
							//³ Integridade entre matricula antiga / origem e destino.              ³
							//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
							nRegBA1 := BA1->(Recno())
							cMatDes := BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG+BA1_DIGITO)

							BA1->(DbGoTo(aRetorno[1])) //Posiciona no novo registro da matricula de historico.
							BA1->(RecLock("BA1",.F.))
							BA1->BA1_TRADES := cMatDes
							BA1->(MsUnlock())
							BA1->(DbGoTo(nRegBA1)) //Retorna o BA1 a posicao original, e prossegue a execucao da rotina.

						EndIf
					EndIf
				EndIf
			EndIf
			AtuProd()
			AtuOpc(nRegBA1)
			AtuAdesao()
		EndIf
	EndIf

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³AtuProd   ºAutor  ³Bianchini/Marcela   º Data ³  12/05/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Atualiza Faixa etaria de cobranca e os descontos			  º±±
±±ºDesc.     ³ de acordo com o a empresa								  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function AtuProd()

	// Limpo as tabelas para nao ter problema na alteracao
	TCSQLEXEC("DELETE FROM "+RetSqlName("BJK")+" WHERE BJK_CODINT = '"+BA3->BA3_CODINT+"' AND BJK_CODEMP = '"+BA3->BA3_CODEMP+"' AND BJK_MATRIC = '"+BA3->BA3_MATRIC+"' AND BJK_CODFOR = '"+BA3->BA3_FORPAG+"'")
	TCSQLEXEC("DELETE FROM "+RetSqlName("BBU")+" WHERE BBU_CODope = '"+BA3->BA3_CODINT+"' AND BBU_CODEMP = '"+BA3->BA3_CODEMP+"' AND BBU_MATRIC = '"+BA3->BA3_MATRIC+"' AND BBU_CODFOR = '"+BA3->BA3_FORPAG+"'")
	/*
	BT9->(DbSetOrder(1))
	BJK->(DbSetOrder(1))
	//remover
	If BT9->(dbSeek(xFilial("BT9")+BA3->(BA3_CODINT+BA3_CODEMP+BA3_CONEMP+BA3_VERCON+BA3_SUBCON+BA3_VERSUB+BA3_CODPLA+BA3_VERSAO+BA3_FORPAG)))

	BJK->(RecLock("BJK",!BJK->(DbSeek(xFilial("BJK")+BA3->BA3_CODINT+BA3->BA3_CODEMP+BA3->BA3_MATRIC))))
	BJK->BJK_FILIAL := xFilial("BJK")
	BJK->BJK_CODOPE := BA3->BA3_CODINT
	BJK->BJK_CODEMP := BA3->BA3_CODEMP
	BJK->BJK_MATRIC := BA3->BA3_MATRIC
	BJK->BJK_CODFOR := BA3->BA3_FORPAG
	BJK->BJK_AUTOMA := "1"
	BJK->(MSUNLOCK())
	EndIf

	//remove - trocar bdk
	//Inclui as Faixas de Cobranca
	BTN->(DbSetOrder(1))
	If BTN->(dbSeek(xFilial("BTN")+BA3->(BA3_CODINT+BA3_CODEMP+BA3_CONEMP+BA3_VERCON+BA3_SUBCON+BA3_VERSUB+BA3_CODPLA+BA3_VERSAO+BA3_FORPAG)))
	While ! BTN->(EOF()) .and. BTN->(BTN_FILIAL+BTN_CODIGO+BTN_NUMCON+BTN_VERCON+BTN_SUBCON+BTN_VERSUB+BTN_CODPRO+BTN_VERPRO+BTN_CODFOR) == BA3->(BA3_FILIAL+BA3_CODINT+BA3_CODEMP+BA3_CONEMP+BA3_VERCON+BA3_SUBCON+BA3_VERSUB+BA3_CODPLA+BA3_VERSAO+BA3_FORPAG)

	BBU->(RecLock("BBU",!BBU->(DbSeek(xFilial("BBU")+BA3->BA3_CODINT+BA3->BA3_CODEMP+BA3->BA3_MATRIC+BA3->BA3_FORPAG+BTN->BTN_CODFAI))))
	BBU->BBU_FILIAL := xFilial("BBU")
	BBU->BBU_CODOPE := BA3->BA3_CODINT
	BBU->BBU_CODEMP := BA3->BA3_CODEMP
	BBU->BBU_MATRIC := BA3->BA3_MATRIC
	BBU->BBU_CODFOR := BA3->BA3_FORPAG
	BBU->BBU_CODFAI := BTN->BTN_CODFAI
	BBU->BBU_TABVLD := BTN->BTN_TABVLD
	BBU->BBU_TIPUSR := BTN->BTN_TIPUSR
	BBU->BBU_GRAUPA := BTN->BTN_GRAUPA
	BBU->BBU_SEXO   := BTN->BTN_SEXO
	BBU->BBU_IDAINI := BTN->BTN_IDAINI
	BBU->BBU_IDAFIN := BTN->BTN_IDAFIN
	BBU->BBU_VALFAI := BTN->BTN_VALFAI
	BBU->BBU_FAIFAM := BTN->BTN_FAIFAM
	BBU->BBU_QTDMIN := BTN->BTN_QTDMIN
	BBU->BBU_QTDMAX := BTN->BTN_QTDMAX
	BBU->BBU_REJAPL := BTN->BTN_REJAPL
	BBU->BBU_AUTOMA := "1"
	BBU->BBU_PERREJ := BTN->BTN_PERREJ
	BBU->BBU_ANOMES := BTN->BTN_ANOMES
	BBU->BBU_VLRANT := BTN->BTN_VLRANT
	BBU->(MsUnlock())
	BTN->(DbSkip())
	Enddo
	EndIf

	//remover
	//Inclui as Faixas de Desconto
	BTN->(DbSetOrder(1))
	If BTN->(dbSeek(xFilial("BTN")+BA3->(BA3_CODINT+BA3_CODEMP+BA3_CONEMP+BA3_VERCON+BA3_SUBCON+BA3_VERSUB+BA3_CODPLA+BA3_VERSAO+BA3_FORPAG)))
	While ! BTN->(EOF()) .and. BTN->(BTN_FILIAL+BTN_CODIGO+BTN_NUMCON+BTN_VERCON+BTN_SUBCON+BTN_VERSUB+BTN_CODPRO+BTN_VERPRO+BTN_CODFOR) == BA3->(BA3_FILIAL+BA3_CODINT+BA3_CODEMP+BA3_CONEMP+BA3_VERCON+BA3_SUBCON+BA3_VERSUB+BA3_CODPLA+BA3_VERSAO+BA3_FORPAG)
	BFY->(RecLock("BFY",!BFY->(DbSeek(xFilial("BFY")+BA3->BA3_CODINT+BA3->BA3_CODEMP+BA3->BA3_MATRIC+BA3->BA3_FORPAG+BTN->BTN_CODFAI))))
	BFY->BFY_FILIAL := xFilial("BFY")
	BFY->BFY_CODOPE := BA3->BA3_CODINT
	BFY->BFY_CODEMP := BA3->BA3_CODEMP
	BFY->BFY_MATRIC := BA3->BA3_MATRIC
	BFY->BFY_CODFOR := BA3->BA3_FORPAG
	BFY->BFY_CODFAI := BTN->BTN_CODFAI
	BFY->BFY_TIPUSR := BTN->BTN_TIPUSR
	BFY->BFY_GRAUPA := BTN->BTN_GRAUPA
	BFY->BFY_QTDDE  := BTN->BTN_QTDMIN
	BFY->BFY_QTDATE := BTN->BTN_QTDMAX
	BFY->BFY_VALOR  := IiF((BA3->BA3_CODPLA =='0092' .AND. BTN->BTN_TIPUSR == "T") , 7.56, 11.43 ) //mbcmig
	//BFY->BFY_VALOR  := 9.00
	BFY->BFY_AUTOMA := "1"
	BFY->BFY_TIPO   := "1"
	BFY->BFY_DATDE  := BA3->BA3_DATBAS
	BFY->(MsUnlock())
	BTN->(DbSkip())
	Enddo
	EndIf*/

	//Inclui as Faixas de Cobranca
	DbSelectArea("BTN")
	DbSetOrder(1)
	If DbSeek(xFilial("BTN")+BA1->(BA1_CODINT+BA1_CODEMP+BA1_CONEMP+BA1_VERCON+BA1_SUBCON+BA1_VERSUB+BA1_CODPLA+BA1_VERSAO)+BA3->BA3_FORPAG)
		While ! BTN->(EOF()) .and. BTN->(BTN_FILIAL+BTN_CODIGO+BTN_NUMCON+BTN_VERCON+BTN_SUBCON+BTN_VERSUB+BTN_CODPRO+BTN_VERPRO+BTN_CODFOR) == BA1->(BA1_FILIAL+BA1_CODINT+BA1_CODEMP+BA1_CONEMP+BA1_VERCON+BA1_SUBCON+BA1_VERSUB+BA1_CODPLA+BA1_VERSAO)+BA3->BA3_FORPAG

			DbSelectArea("BDK")
			DbSetOrder(2)//BDK_FILIAL+BDK_CODINT+BDK_CODEMP+BDK_MATRIC+BDK_TIPREG
			BDK->(RecLock("BDK",!BDK->(DbSeek(xFilial("BDK")+BA1->BA1_CODINT+BA1->BA1_CODEMP+BA1->BA1_MATRIC+BA1->BA1_TIPREG+BTN->BTN_CODFAI))))

			BDK->BDK_FILIAL 	:= xFilial("BDK")
			BDK->BDK_CODFAI 	:= BTN->BTN_CODFAI
			BDK->BDK_IDAINI 	:= BTN->BTN_IDAINI
			BDK->BDK_IDAFIN 	:= BTN->BTN_IDAFIN
			BDK->BDK_VALOR 	:= BTN->BTN_VALFAI
			BDK->BDK_CODINT 	:= BA3->BA3_CODINT
			BDK->BDK_CODEMP 	:= BA3->BA3_CODEMP
			BDK->BDK_MATRIC 	:= BA3->BA3_MATRIC
			BDK->BDK_TIPREG	:= BA1->BA1_TIPREG
			BDK->BDK_ANOMES 	:= BTN->BTN_ANOMES
			BDK->BDK_VLRANT 	:= BTN->BTN_VLRANT
			BDK->BDK_RGIMP 	:= "1" //IMPORTADO 1=SIM E 2=NAO
			BDK->BDK_TABVLD 	:= BTN->BTN_TABVLD

			BDK->(MsUnlock())

			BTN->(DbSkip())

		Enddo

	EndIf

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  |AtuAdesao ºAutor  ³Raquel    			 º Data ³  25/10/07   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Atualiza Taxa de adesao na familia pegando da empresa      º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function AtuAdesao()

	// Limpo as tabelas para nao ter problema na alteracao
	TCSQLEXEC("DELETE FROM "+RetSqlName("BJL")+" WHERE BJL_CODINT = '"+BA3->BA3_CODINT+"' AND BJL_CODEMP = '"+BA3->BA3_CODEMP+"' AND BJL_MATRIC = '"+BA3->BA3_MATRIC+"' AND BJL_CODFOR = '"+BA3->BA3_FORCTX+"'")
	TCSQLEXEC("DELETE FROM "+RetSqlName("BRX")+" WHERE BRX_CODINT = '"+BA3->BA3_CODINT+"' AND BRX_CODEMP = '"+BA3->BA3_CODEMP+"' AND BRX_MATRIC = '"+BA3->BA3_MATRIC+"' AND BRX_CODFOR = '"+BA3->BA3_FORCTX+"'")

	BTK->(DbSetOrder(1))
	BJL->(DbSetOrder(1))

	If BTK->(dbSeek(xFilial("BTK")+BA3->(BA3_CODINT+BA3_CODEMP+BA3_CONEMP+BA3_VERCON+BA3_SUBCON+BA3_VERSUB+BA3_CODPLA+BA3_VERSAO+BA3_FORCTX)))

		BJL->(RecLock("BJL",!BJL->(DbSeek(xFilial("BJL")+BA3->BA3_CODINT+BA3->BA3_CODEMP+BA3->BA3_MATRIC))))
		BJL->BJL_FILIAL := xFilial("BJL")
		BJL->BJL_CODOPE := BA3->BA3_CODINT
		BJL->BJL_CODEMP := BA3->BA3_CODEMP
		BJL->BJL_MATRIC := BA3->BA3_MATRIC
		BJL->BJL_CODFOR := BA3->BA3_FORCTX
		BJL->BJL_AUTOMA := "1"
		BJL->(MSUNLOCK())
	EndIf

	If BR6->(dbSeek(xFilial("BR6")+BA3->(BA3_CODINT+BA3_CODEMP+BA3_CONEMP+BA3_VERCON+BA3_SUBCON+BA3_VERSUB+BA3_CODPLA+BA3_VERSAO+BA3_FORCTX)))
		While ! BR6->(EOF()) .and. BR6->(BR6_FILIAL+BR6_CODIGO+BR6_NUMCON+BR6_VERCON+BR6_SUBCON+BR6_VERSUB+BR6_CODPRO+BR6_VERPRO+BR6_CODFOR) == BA3->(BA3_FILIAL+BA3_CODINT+BA3_CODEMP+BA3_CONEMP+BA3_VERCON+BA3_SUBCON+BA3_VERSUB+BA3_CODPLA+BA3_VERSAO+BA3_FORCTX)

			BRX->(RecLock("BRX",!BRX->(DbSeek(xFilial("BRX")+BA3->BA3_CODINT+BA3->BA3_CODEMP+BA3->BA3_MATRIC+BA3->BA3_FORCTX+BR6->BR6_CODFAI))))
			BRX->BRX_FILIAL := xFilial("BRX")
			BRX->BRX_CODOPE := BA3->BA3_CODINT
			BRX->BRX_CODEMP := BA3->BA3_CODEMP
			BRX->BRX_MATRIC := BA3->BA3_MATRIC
			BRX->BRX_CODFOR := BA3->BA3_FORCTX
			BRX->BRX_CODFAI := BR6->BR6_CODFAI
			BRX->BRX_TIPUSR := BR6->BR6_TIPUSR
			BRX->BRX_GRAUPA := BR6->BR6_GRAUPA
			BRX->BRX_VLRADE := BR6->BR6_VLRADE
			BRX->BRX_PERADE := BR6->BR6_PERADE
			BRX->BRX_SEXO   := BR6->BR6_SEXO
			BRX->BRX_IDAINI := BR6->BR6_IDAINI
			BRX->BRX_IDAFIN := BR6->BR6_IDAFIN
			BRX->BRX_AUTOMA := "1"
			BRX->BRX_ANOMES := BR6->BR6_ANOMES
			BRX->BRX_VLRANT :=BR6->BR6_VLRANT
			BRX->(MsUnlock())

			BR6->(DbSkip())
		Enddo
	EndIf

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³AtuOPC    ºAutor  ³Bianchini/Marcela   º Data ³  12/05/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Atualiza Opcionais na familia pegando da empresa           º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function AtuOpc(lFamCad)

	//Static Function AtuOpcional()
	Local cCodOpc := ""
	Local a_AreaBa1 := GetArea("BA1")
	Local a_AreaBa3 := GetArea("BA3")

	If BA1->BA1_SUBCON == "000000002" .and. PBT->PBT_LAYOUT == '2'

		cCodOpc := BA1->BA1_CODPLA

		PosicMatMed(  BA1->BA1_CODEMP, BA1->BA1_CONEMP, "000000001", BA1->BA1_MATEMP )

	EndIf
	//remover
	If !lFamCad

		TCSQLEXEC("DELETE FROM "+RetSqlName("BF1")+" WHERE BF1_CODINT = '"+BA3->BA3_CODINT+"' AND BF1_CODEMP = '"+BA3->BA3_CODEMP+"' AND BF1_MATRIC = '"+BA3->BA3_MATRIC+"'")
		TCSQLEXEC("DELETE FROM "+RetSqlName("BK0")+" WHERE BK0_CODINT = '"+BA3->BA3_CODINT+"' AND BK0_CODEMP = '"+BA3->BA3_CODEMP+"' AND BK0_MATRIC = '"+BA3->BA3_MATRIC+"'")
		TCSQLEXEC("DELETE FROM "+RetSqlName("BBY")+" WHERE BBY_CODINT = '"+BA3->BA3_CODINT+"' AND BBY_CODEMP = '"+BA3->BA3_CODEMP+"' AND BBY_MATRIC = '"+BA3->BA3_MATRIC+"'")
		TCSQLEXEC("DELETE FROM "+RetSqlName("BG0")+" WHERE BG0_CODINT = '"+BA3->BA3_CODINT+"' AND BG0_CODEMP = '"+BA3->BA3_CODEMP+"' AND BG0_MATRIC = '"+BA3->BA3_MATRIC+"'")

	EndIf

	TCSQLEXEC("DELETE FROM "+RetSqlName("BF4")+" WHERE BF4_CODINT = '"+BA3->BA3_CODINT+"' AND BF4_CODEMP = '"+BA3->BA3_CODEMP+"' AND BF4_MATRIC = '"+BA3->BA3_MATRIC+"' AND BF4_TIPREG = '" + BA1->BA1_TIPREG + "'")
	TCSQLEXEC("DELETE FROM "+RetSqlName("BYX")+" WHERE BYX_CODINT = '"+BA3->BA3_CODINT+"' AND BYX_CODEMP = '"+BA3->BA3_CODEMP+"' AND BYX_MATRIC = '"+BA3->BA3_MATRIC+"' AND BYX_TIPREG = '" + BA1->BA1_TIPREG + "'")
	TCSQLEXEC("DELETE FROM "+RetSqlName("BZX")+" WHERE BZX_CODINT = '"+BA3->BA3_CODINT+"' AND BZX_CODEMP = '"+BA3->BA3_CODEMP+"' AND BZX_MATRIC = '"+BA3->BA3_MATRIC+"' AND BZX_TIPREG = '" + BA1->BA1_TIPREG + "'")

	/*
	BI3->(dbGoTop())
	Do While !BI3->(Eof())

	If	(BI3->BI3_GRUPO != '002') .or. (BI3->BI3_GRUPO == '002' .and. !EMPTY(BI3->BI3_DATBLO))
	BI3->(dbSkip())
	Loop
	EndIf
	*/
	If PBT->PBT_LAYOUT == '1'

		//cCodPro := ConvPlano(trim(PBU->PBU_PADRAO),'ODO','C')
		cCodPro := ConvPlano(trim(PBU->PBU_PADRAO),Alltrim(PBU->PBU_CDBENE),1)

	EndIf

	//Angelo Henrique - Novos planos Prefeitura
	/*If cCodPro == '0098'		//CODIGO DO PRODUTO DENTAL ESSENCIAL
	cCodOpc := '0103'		//CODIGO DO OPCIONAL DENTAL ESSENCIAL
	ElseIf cCodPro == '0099'	//CODIGO DO PRODUTO DENTAL MULTI
	cCodOpc := '0105'		//CODIGO DO OPCIONAL DENTAL MULTI
	EndIf*/

	//Verificar se existe o Opcional no Subcontrato
	BHS->( dbSetorder(1) )
	If  !BHS->( dbSeek(xFilial("BHS")+BA3->(BA3_CODINT+BA3_CODEMP+BA3_CONEMP+BA3_VERCON+BA3_SUBCON+BA3_VERSUB+BA3_CODPLA+BA3_VERSAO)) )

		RestArea( a_AreaBa1 )
		RestArea( a_AreaBa3 )
		Return
	EndIf

	While !BHS->( Eof() ) .and. BHS->(BHS_CODINT+BHS_CODIGO+BHS_NUMCON+BHS_VERCON+BHS_SUBCON+BHS_VERSUB+BHS_CODPRO+BHS_VERPRO)==;
	BA3->(BA3_CODINT+BA3_CODEMP+BA3_CONEMP+BA3_VERCON+BA3_SUBCON+BA3_VERSUB+BA3_CODPLA+BA3_VERSAO)

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Compara o codigo do opcional                                        ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		//If BHS->BHS_CODPLA <> BI3->BI3_CODIGO
		/*
		If (BHS->BHS_CODPLA <> BI3->BI3_CODIGO)
		BHS->( dbSkip() )
		Loop
		EndIf
		*/

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Grava o opcional...                                                 ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		//If (BHS->BHS_TIPVIN == '1') .or. (BHS->BHS_TIPVIN <> '1' .and. PBU->PBU_ASSMED == 'S')
		//If (BHS->BHS_TIPVIN == '1') .or. (BHS->BHS_TIPVIN <> '1' .and. BHS->BHS_CODPLA == cCodOpc) -- Angelo Henrique - Data:29/07/2016
		If (BHS->BHS_TIPVIN == '1')

			BF1->( dbSetorder(1) )
			If !BF1->( dbSeek(xFilial("BF1")+BA3->(BA3_CODINT+BA3_CODEMP+BA3_MATRIC)+BHS->BHS_CODPLA) )
				BF1->( RecLock("BF1",.T.) )
				BF1->BF1_FILIAL := xFilial("BF1")
				BF1->BF1_CODEMP := BA3->BA3_CODEMP
				BF1->BF1_CODINT := BA3->BA3_CODINT
				BF1->BF1_MATRIC := BA3->BA3_MATRIC
				BF1->BF1_CODPRO := BHS->BHS_CODPLA
				BF1->BF1_VERSAO := BHS->BHS_VERPLA
				BF1->BF1_DATBAS	:= BA3->BA3_DATBAS
				BF1->BF1_TIPVIN := BHS->BHS_TIPVIN
				BF1->( msUnlock() )

				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Grava suas formas de cobranca...                                    ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				If BHS->BHS_TIPVIN <> '1' //.and. PBU->PBU_ASSMED == 'S'
					BJW->( dbSetorder(1) )
					If BJW->( dbSeek(xFilial("BJW")+BA3->(BA3_CODINT+BA3_CODEMP+BA3_CONEMP+;
					BA3_VERCON+BA3_SUBCON+BA3_VERSUB+BA3_CODPLA+BA3_VERSAO)            +;
					BHS->(BHS_CODPLA+BHS_VERPLA) ) )

						BK0->( dbSetorder(1) )
						If !BK0->( dbSeek(xFilial("BK0")+BA3->(BA3_CODINT+BA3_CODEMP+BA3_MATRIC)+;
						BHS->BHS_CODPLA+BHS->BHS_VERPLA ) )

							BK0->( RecLock("BK0", .T.) )
							BK0->BK0_FILIAL := xFilial("BK0")
							BK0->BK0_CODOPE := BA3->BA3_CODINT
							BK0->BK0_CODEMP := BA3->BA3_CODEMP
							BK0->BK0_MATRIC := BA3->BA3_MATRIC
							BK0->BK0_CODOPC := BJW->BJW_CODOPC
							BK0->BK0_VEROPC := BJW->BJW_VEROPC
							BK0->BK0_CODFOR := BJW->BJW_CODFOR
							BK0->( MsUnlock() )

							BA3->( RecLock("BA3", .F.) )
							BA3->BA3_FORCOP := BJW->BJW_CODFOR
							BA3->( MsUnlock() )
						EndIf

						//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
						//³ Le faixas de Opcionais do subcontrato e grava suas faixas de valores de cobranca na familia...    ³
						//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
						cSql := "SELECT * FROM "+RetSqlName("BBX")+" WHERE BBX_FILIAL = '"+xFilial("BBX")+"' "
						cSql += "AND BBX_CODIGO = '"+BA3->BA3_CODINT+BA3->BA3_CODEMP+"' "
						cSql += "AND BBX_NUMCON = '"+BA3->BA3_CONEMP+"' "
						cSql += "AND BBX_VERCON = '"+BA3->BA3_VERCON+"' "
						cSql += "AND BBX_SUBCON = '"+BA3->BA3_SUBCON+"' "
						cSql += "AND BBX_VERSUB = '"+BA3->BA3_VERSUB+"' "
						cSql += "AND BBX_CODPRO = '"+BA3->BA3_CODPLA+"' "
						cSql += "AND BBX_VERPRO = '"+BA3->BA3_VERSAO+"' "
						cSql += "AND BBX_CODOPC = '"+BJW->BJW_CODOPC+"' "
						cSql += "AND BBX_VEROPC = '"+BJW->BJW_VEROPC+"' "
						cSql += "AND BBX_CODFOR = '"+BJW->BJW_CODFOR+"' "
						cSql += "AND BBX_TIPUSR = DECODE('"+BA3->BA3_CODPLA+"', '0092', '"+Iif(BA1->BA1_TIPREG == '00', 'T', 'D')+"', ' ' ) " //mbcmig
						cSql += "AND D_E_L_E_T_ <> '*' "
						PlsQuery(cSql, "TRB1")

						TRB1->( dbGotop())
						While !TRB1->( Eof() )
							If ! BBY->( dbSeek(xFilial("BBY")+BA3->BA3_CODINT+BA3->BA3_CODEMP+BA3->BA3_MATRIC+TRB1->BBX_CODOPC+TRB1->BBX_VEROPC+;
							TRB1->BBX_CODFOR+TRB1->BBX_CODFAI) )
								BBY->( RecLock("BBY", .T.) )
								BBY->BBY_FILIAL := xFilial("BBY")
								BBY->BBY_CODOPE := BA3->BA3_CODINT
								BBY->BBY_CODEMP := BA3->BA3_CODEMP
								BBY->BBY_MATRIC := BA3->BA3_MATRIC
								BBY->BBY_CODOPC := TRB1->BBX_CODOPC
								BBY->BBY_VEROPC := TRB1->BBX_VEROPC
								BBY->BBY_CODFOR := TRB1->BBX_CODFOR
								BBY->BBY_CODFAI	:= TRB1->BBX_CODFAI
								BBY->BBY_TIPUSR := TRB1->BBX_TIPUSR
								BBY->BBY_GRAUPA := TRB1->BBX_GRAUPA
								BBY->BBY_SEXO	:= TRB1->BBX_SEXO
								BBY->BBY_IDAINI	:= TRB1->BBX_IDAINI
								BBY->BBY_IDAFIN := TRB1->BBX_IDAFIN
								BBY->BBY_VALFAI := TRB1->BBX_VALFAI
								BBY->BBY_FAIFAM := TRB1->BBX_FAIFAM
								BBY->BBY_QTDMIN := TRB1->BBX_QTDMIN
								BBY->BBY_QTDMAX := TRB1->BBX_QTDMAX
								BBY->BBY_AUTOMA := '1'
								BBY->BBY_ANOMES	:= TRB1->BBX_ANOMES
								BBY->BBY_VLRANT := TRB1->BBX_VLRANT
								BBY->( msUnlock() )
							EndIf
							TRB1->( dbSkip() )
						Enddo
						TRB1->( dbClosearea() )

						//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
						//³ Le faixas de Opcionais(descontos) do subcontrato e Grava suas faixas de descontos de cobranca...        ³
						//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
						cSql := "SELECT * FROM "+RetSqlName("BGW")+" WHERE BGW_FILIAL = '"+xFilial("BGW")+"' "
						cSql += "AND BGW_CODIGO = '"+BA3->BA3_CODINT+BA3->BA3_CODEMP+"' "
						cSql += "AND BGW_NUMCON = '"+BA3->BA3_CONEMP+"' "
						cSql += "AND BGW_VERCON = '"+BA3->BA3_VERCON+"' "
						cSql += "AND BGW_SUBCON = '"+BA3->BA3_SUBCON+"' "
						cSql += "AND BGW_VERSUB = '"+BA3->BA3_VERSUB+"' "
						cSql += "AND BGW_CODPRO = '"+BA3->BA3_CODPLA+"' "
						cSql += "AND BGW_VERPRO = '"+BA3->BA3_VERSAO+"' "
						cSql += "AND BGW_CODOPC = '"+BJW->BJW_CODOPC+"' "
						cSql += "AND BGW_VEROPC = '"+BJW->BJW_VEROPC+"' "
						cSql += "AND BGW_CODFOR = '"+BJW->BJW_CODFOR+"' "
						cSql += "AND D_E_L_E_T_ <> '*' "
						PlsQuery(cSql, "TRB1")

						TRB1->( dbGotop())
						If ! BG0->( dbSeek(xFilial("BG0")+BA3->BA3_CODINT+BA3->BA3_CODEMP+BA3->BA3_MATRIC+TRB1->BGW_CODOPC+TRB1->BGW_VEROPC+;
						TRB1->BGW_CODFOR+TRB1->BGW_CODFAI) )
							While !TRB1->( Eof() )
								BG0->( RecLock("BG0", .T.) )
								BG0->BG0_FILIAL := xFilial("BG0")
								BG0->BG0_CODOPE := BA3->BA3_CODINT
								BG0->BG0_CODEMP := BA3->BA3_CODEMP
								BG0->BG0_MATRIC := BA3->BA3_MATRIC
								BG0->BG0_CODOPC := TRB1->BGW_CODOPC
								BG0->BG0_VEROPC := TRB1->BGW_VEROPC
								BG0->BG0_CODFOR := TRB1->BGW_CODFOR
								BG0->BG0_CODFAI	:= TRB1->BGW_CODFAI
								BG0->BG0_TIPUSR := TRB1->BGW_TIPUSR
								BG0->BG0_GRAUPA := TRB1->BGW_GRAUPA
								BG0->BG0_PERCEN := TRB1->BGW_PERCEN
								BG0->BG0_VALOR  := TRB1->BGW_VALOR
								BG0->BG0_QTDDE	:= TRB1->BGW_QTDDE
								BG0->BG0_QTDATE := TRB1->BGW_QTDATE
								BG0->BG0_TIPO	:= TRB1->BGW_TIPO
								BG0->BG0_AUTOMA := '1'
								BG0->( msUnlock() )
								TRB1->( dbSkip() )
							Enddo
						EndIf
						TRB1->( dbClosearea() )
					EndIf
				EndIf
			EndIf
		EndIf
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Inicia atualizacoes do usuario...                                   ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

		//BA1->( dbSetorder(2) )
		//If BA1->(dbSeek(xFilial("BA1")+BA3->(BA3_CODINT+BA3_CODEMP+BA3_MATRIC+"00")) )

		//	While !BA1->( Eof() ) .and. BA1->BA1_FILIAL == xFilial("BA1")  .and.;
		//	BA1->BA1_CODINT == BA3->BA3_CODINT .and.;
		//	BA1->BA1_CODEMP == BA3->BA3_CODEMP .and.;
		//	BA1->BA1_MATRIC == BA3->BA3_MATRIC

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Opcionais...                                                        ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		//If (BHS->BHS_TIPVIN == '1') .or. (BHS->BHS_TIPVIN <> '1' .and. PBU->PBU_ASSMED == 'S')
		If (BHS->BHS_TIPVIN == '1') .or. (BHS->BHS_TIPVIN <> '1' .and. BHS->BHS_CODPLA == cCodOpc)

			If !BF4->( dbSeek(xFilial("BF4")+BA1->BA1_CODINT+BA1->BA1_CODEMP+BA1->BA1_MATRIC+BA1->BA1_TIPREG+BHS->BHS_CODPLA) )

				BF4->( RecLock("BF4", .T.) )
				BF4->BF4_FILIAL := xFilial("BF1")
				BF4->BF4_CODEMP := BA3->BA3_CODEMP
				BF4->BF4_CODINT := BA3->BA3_CODINT
				BF4->BF4_MATRIC := BA3->BA3_MATRIC
				BF4->BF4_TIPREG := BA1->BA1_TIPREG

				BF4->BF4_DATBAS := BA3->BA3_DATBAS
				BF4->BF4_MOTBLO := BA3->BA3_MOTBLO
				BF4->BF4_DATBLO := BA3->BA3_DATBLO

				BF4->BF4_CODPRO := BHS->BHS_CODPLA
				BF4->BF4_VERSAO := BHS->BHS_VERPLA
				BF4->BF4_TIPVIN := BHS->BHS_TIPVIN

				BF4->( MsUnlock() )

				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Suas formas de cobranca...                                          ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				If BHS->BHS_TIPVIN <> '1' //.and. PBU->PBU_ASSMED == 'S'
					BK0->( dbSetorder(01) )
					If BK0->( dbSeek(xFilial("BK0")+BA3->(BA3_CODINT+BA3_CODEMP+BA3_MATRIC)+;
					BHS->BHS_CODPLA+BHS->BHS_VERPLA ) )

						BYX->( RecLock("BYX", .T.) )
						BYX->BYX_FILIAL := xFilial("BK0")
						BYX->BYX_CODOPE := BA3->BA3_CODINT
						BYX->BYX_CODEMP := BA3->BA3_CODEMP
						BYX->BYX_MATRIC := BA3->BA3_MATRIC
						BYX->BYX_CODOPC := BK0->BK0_CODOPC
						BYX->BYX_VEROPC := BK0->BK0_VEROPC
						BYX->BYX_CODFOR := BK0->BK0_CODFOR
						BYX->BYX_TIPREG := BA1->BA1_TIPREG
						BYX->BYX_RGIMP  := '1'
						BYX->( MsUnlock() )

						//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
						//³ A tabela de precos...                                               ³
						//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
						cSql := "SELECT * FROM "+RetSqlName("BBY")+" WHERE BBY_FILIAL = '"+xFilial("BBY")+"' "
						cSql += "AND BBY_CODOPE = '"+BA1->BA1_CODINT+"' "
						cSql += "AND BBY_CODEMP = '"+BA1->BA1_CODEMP+"' "
						cSql += "AND BBY_MATRIC = '"+BA1->BA1_MATRIC+"' "
						cSql += "AND BBY_CODOPC = '"+BHS->BHS_CODPLA+"' "
						cSql += "AND BBY_VEROPC = '"+BHS->BHS_VERPLA+"' "
						cSql += "AND D_E_L_E_T_ <> '*' "
						PlsQuery(cSql, "TRB1")

						TRB1->( dbGotop() )
						While !TRB1->( Eof() )
							BZX->( RecLock("BZX", .T.) )
							BZX->BZX_FILIAL := xFilial("BK0")
							BZX->BZX_CODOPE := BA3->BA3_CODINT
							BZX->BZX_CODEMP := BA3->BA3_CODEMP
							BZX->BZX_MATRIC := BA3->BA3_MATRIC
							BZX->BZX_TIPREG := BA1->BA1_TIPREG
							BZX->BZX_CODOPC := TRB1->BBY_CODOPC
							BZX->BZX_VEROPC := TRB1->BBY_VEROPC
							BZX->BZX_CODFOR := TRB1->BBY_CODFOR
							BZX->BZX_VALFAI := TRB1->BBY_VALFAI
							BZX->BZX_IDAINI := TRB1->BBY_IDAINI
							BZX->BZX_IDAFIN := TRB1->BBY_IDAFIN
							BZX->BZX_RGIMP := '1'
							BZX->BZX_ANOMES := TRB1->BBY_ANOMES
							BZX->BZX_VLRANT := TRB1->BBY_VLRANT
							BZX->BZX_CODFAI := TRB1->BBY_CODFAI
							BZX->( MsUnlock() )
							TRB1->( dbSkip() )
						Enddo
						TRB1->( dbCloseArea() )
					EndIf
				EndIf
			EndIf
		EndIf
		//	BA1->( dbSkip() )
		//Enddo
		//EndIf

		BHS->( dbSkip() )
	Enddo
	/*
	BI3->(dbSkip())
	EndDo
	*/

	RestArea( a_AreaBa1 )
	RestArea( a_AreaBa3 )

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³PreSA1    ºAutor  ³Fabio Bianchini     º Data ³  28/08/14   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Inclui Cliente por EXECAUTO. Esta funcao pode			  º±±
±±º          ³ retornar um Codigo de cliente ou um logico dependendo do   º±±
±±º          ³ nTipo passado pelo parametro.							  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function PreSA1(cCPF,nTipo)

	Local aVetSA1 		:= {}

	Private lMsErroAuto := .F.

	//PREPARE ENVIRONMENT EMPRESA "99" FILIAL "01" MODULO "FAT" TABLES "SA1"

	cTmpCep := iif(At("-",PBU->PBU_CEP) > 0,Substr(PBU->PBU_CEP,1,5)+Substr(PBU->PBU_CEP,7,3),PBU->PBU_CEP)

	If nTipo == 1

		cCodcli := " "

		SA1->(dbSetOrder(3))
		If SA1->(dbSeek(xFilial("SA1")+PBU->PBU_CPF))
			cCodcli := SA1->A1_COD
		Else
			cCodCli := GetSx8Num("SA1","A1_COD")

			BC9->(DbSetOrder(1))
			If BC9->(DbSeek(xFilial("BC9")+cTmpCep))

				aAdd(aVetSA1, {"A1_COD"		,cCodCli           		,Nil})
				aAdd(aVetSA1, {"A1_LOJA"	,"01"    				,Nil})
				aAdd(aVetSA1, {"A1_NOME" 	,UPPER(PBU->PBU_BENEF)	,Nil})
				aAdd(aVetSA1, {"A1_PESSOA" 	,"F"					,Nil})
				aAdd(aVetSA1, {"A1_NREDUZ" 	,UPPER(SUBSTR(PBU->PBU_BENEF,1,20))	,Nil})
				aAdd(aVetSA1, {"A1_CGC" 	,PBU->PBU_CPF			,Nil})
				aAdd(aVetSA1, {"A1_TIPO" 	,"F"					,Nil})
				aAdd(aVetSA1, {"A1_END"    	,AllTrim(UPPER(TRIM(BC9->BC9_END))+" "+TRIM(PBU->PBU_NUMERO)+" "+UPPER(TRIM(PBU->PBU_COMPLE))),Nil})
				aAdd(aVetSA1, {"A1_MUN"  	,UPPER(BC9->BC9_MUN)	,Nil})
				aAdd(aVetSA1, {"A1_EST"		,UPPER(BC9->BC9_EST)	,Nil})
				aAdd(aVetSA1, {"A1_BAIRRO"	,UPPER(BC9->BC9_BAIRRO)	,Nil})
				aAdd(aVetSA1, {"A1_CEP"		,cTmpCep				,Nil})
				aAdd(aVetSA1, {"A1_DDD"  	,TRIM(PBU->PBU_DDDRES)	,Nil})
				aAdd(aVetSA1, {"A1_TEL"		,TRIM(PBU->PBU_TELRES)	,Nil})
				aAdd(aVetSA1, {"A1_ENDCOB"	,AllTrim(UPPER(TRIM(BC9->BC9_END))+" "+TRIM(PBU->PBU_NUMERO)+" "+UPPER(TRIM(PBU->PBU_COMPLE))),Nil})
				aAdd(aVetSA1, {"A1_BAIRROC"	,UPPER(BC9->BC9_BAIRRO)	,Nil})
				aAdd(aVetSA1, {"A1_CEPC"	,cTmpCep				,Nil})
				aAdd(aVetSA1, {"A1_MUNC"	,UPPER(BC9->BC9_MUN)	,Nil})
				aAdd(aVetSA1, {"A1_ESTC"	,UPPER(BC9->BC9_EST)	,Nil})

			Else

				aAdd(aVetSA1, {"A1_COD"  	,cCodCli           		,Nil})
				aAdd(aVetSA1, {"A1_LOJA"	,"01"               	,Nil})
				aAdd(aVetSA1, {"A1_NOME"	,UPPER(PBU->PBU_BENEF)	,Nil})
				aAdd(aVetSA1, {"A1_PESSOA" 	,"F"					,Nil})
				aAdd(aVetSA1, {"A1_NREDUZ"	,UPPER(SUBSTR(PBU->PBU_BENEF,1,20))	,Nil})
				aAdd(aVetSA1, {"A1_CGC" 	,PBU->PBU_CPF			,Nil})
				aAdd(aVetSA1, {"A1_TIPO" 	,"F"					,Nil})
				aAdd(aVetSA1, {"A1_END"		,UPPER(TRIM(PBU->PBU_LOGRAD))+" "+TRIM(PBU->PBU_NUMERO)+" "+UPPER(PBU->PBU_COMPLE),Nil})
				aAdd(aVetSA1, {"A1_MUN"		,UPPER(PBU->PBU_CIDADE)	,Nil})
				aAdd(aVetSA1, {"A1_EST"		,UPPER(PBU->PBU_UF)		,Nil})
				aAdd(aVetSA1, {"A1_BAIRRO"	,UPPER(PBU->PBU_BAIRRO)	,Nil})
				aAdd(aVetSA1, {"A1_CEP"		,PBU->PBU_CEP			,Nil})
				aAdd(aVetSA1, {"A1_DDD"		,TRIM(PBU->PBU_DDDRES)	,Nil})
				aAdd(aVetSA1, {"A1_TEL"		,TRIM(PBU->PBU_TELRES)	,Nil})
				aAdd(aVetSA1, {"A1_ENDCOB"	,UPPER(TRIM(PBU->PBU_LOGRAD))+" "+PBU->PBU_NUMERO+" "+UPPER(PBU->PBU_COMPLE)  ,Nil})
				aAdd(aVetSA1, {"A1_BAIRROC"	,UPPER(PBU->PBU_BAIRRO)	,Nil})
				aAdd(aVetSA1, {"A1_CEPC"	,PBU->PBU_CEP			,Nil})
				aAdd(aVetSA1, {"A1_MUNC"	,UPPER(PBU->PBU_CIDADE)	,Nil})
				aAdd(aVetSA1, {"A1_ESTC"	,UPPER(PBU->PBU_UF)    	,Nil})

			EndIf

			MSExecAuto({|x,y| Mata030(x,y)},aVetSA1,3)

			If lMsErroAuto
				//MostraErro() //Ao inves de mostrar o erro estou gravando um campo na PBU pra investigar as causas do erro depois da importacao
				PBU->(RecLock("PBU",.F.))
				PBU->PBU_ERRCLI := '1'
				PBU->(MsUnlock())
				cCodCli := " "
			Else
				ConfirmSX8()
			EndIf
		EndIf
	EndIf

	If nTipo == 2

		cCodcli := .F.

		SA1->(dbSetOrder(3))
		If SA1->(dbSeek(xFilial("SA1")+PBU->PBU_CPF))
			cCodcli := .T.
		EndIf
	EndIf

Return cCodCli

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³PreBA3    ºAutor  ³Microsiga           º Data ³  05/15/07   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function PreBA3(nTipo,lAcao,cCodCli)

	Local dDatBlo := CtoD("  /  /    ")
	Local cMotBlo := space(0)

	//BA3->(RecLock("BA3",lAcao))

	If nTipo == nInclui // Somente na Inclusao

		BA3->BA3_FILIAL := xFilial("BA3")
		BA3->BA3_CODINT := PBT->PBT_CODOPE
		BA3->BA3_CODEMP := PBT->PBT_CODEMP

		If !l_Voltou //Se .F. indica que ainda nao fez looping para incluir Odonto
			BA3->BA3_CONEMP := PBT->PBT_NUMCON
			BA3->BA3_VERCON := "001"
			BA3->BA3_SUBCON := PBT->PBT_SUBCON
			BA3->BA3_VERSUB := "001"
		Else        //Se .T. esta incluindo Odonto

			If empty(cSubConOdonto) //mbcodo .and. ( PBT->PBT_LAYOUT == '1' )
				cSubConOdonto 	:= chkSubOdonto()
			EndIf

			BA3->BA3_CONEMP := PBT->PBT_NUMCON
			BA3->BA3_VERCON := "001"
			BA3->BA3_SUBCON := cSubConOdonto
			BA3->BA3_VERSUB := "001"
		EndIf

		BA3->BA3_MATRIC	:=	cNovaMatric
		BA3->BA3_MATEMP	:=	Trim(PBU->PBU_FUNC)
		BA3->BA3_HORACN	:=	StrTran(Time(),':','')
		BA3->BA3_FORPAG := "101"
		BA3->BA3_CODPLA := BI3->BI3_CODIGO
		BA3->BA3_VERSAO := "001"
		BA3->BA3_TIPCON := BI3->BI3_TIPCON
		BA3->BA3_SEGPLA := BI3->BI3_CODSEG
		BA3->BA3_MODPAG := BI3->BI3_MODPAG
		BA3->BA3_TXUSU  := '0'
		BA3->BA3_AGMTFU := cNovaMatric
		BA3->BA3_APLEI  := BI3->BI3_APOSRG
		BA3->BA3_CODACO := BI3->BI3_CODACO
		BA3->BA3_ABRANG := BI3->BI3_ABRANG
		BA3->BA3_DATBAS := ctod(PBU->PBU_DTINCT)
		//BA3->BA3_TIPPAG	:= "07" -- Angelo Henrique - Data:02/08/2016
		BA3->BA3_TIPPAG	:= "09"         
		
		**'Inicio - Marcela Coimbra - 23/01/2017 - GLPI 0021417 - Inclusão de informações de LOG'**     

		BA3->BA3_USUOPE := __cUserId
		BA3->BA3_DATCON := date()
		BA3->BA3_HORCON := time() 

		**'Fim    - Coimbra - 23/01/2017 - GLPI 0021417 - Inclusão de informações de LOG'**

	EndIf

	If ( nTipo == nInclui ) .or. ( nTipo == nAltera )//Somente na Inclusao e Alteracao

		BA3->BA3_TIPOUS	:=	'2'
		BA3->BA3_FAIDES	:=	''
		BA3->BA3_VALSAL	:=	0
		BA3->BA3_ENDCOB	:=	'2'
	  //	BA3->BA3_USUOPE	:=	"Importa"
		BA3->BA3_RGIMP	:=	'1'
		BA3->BA3_DEMITI	:=	iif(Empty(ctod(PBU->PBU_DTDESL)),"0","1")
		BA3->BA3_DATDEM	:=	ctod(PBU->PBU_DTDESL)
		BA3->BA3_LIMATE	:=	Ctod( '' )
		BA3->BA3_INFCOB	:=	'0'
		BA3->BA3_INFGCB	:=	'0'
		BA3->BA3_NUMCER	:=	''
		BA3->BA3_COBUSU	:=	'0'
		BA3->BA3_DATALT	:=	dDataBase
		BA3->BA3_OUTLAN	:=	'0'
		BA3->BA3_ROTINA	:=	'PLSPORFAI'
		BA3->BA3_VALID	:=	Ctod( '' )
		BA3->BA3_DESLIG	:=	''
		BA3->BA3_DATDES	:=	Ctod( '' )
		BA3->BA3_BLOFAT	:=	'1'
		BA3->BA3_COBRAT := ' '
		BA3->BA3_COBRET := '0'
		BA3->BA3_RATMAI := '0'
		BA3->BA3_RATSAI := '0'
		BA3->BA3_COBNIV	:= '0'

		//VINCULACAO DE CLIENTE NAS FAMILIAS - INICIO

		BA3->BA3_CODCLI := cCodcli
		BA3->BA3_LOJA	:= '01'
		BA3->BA3_NATURE := '30'

		cTmpCep := If(At("-",PBU->PBU_CEP) > 0,Substr(PBU->PBU_CEP,1,5)+Substr(PBU->PBU_CEP,7,3),PBU->PBU_CEP)

		SA1->(dbSetOrder(1))

		If SA1->(dbSeek(xFilial("SA1")+cCodcli))

			BC9->(DbSetOrder(1))

			If BC9->(DbSeek(xFilial("BC9")+cTmpCep))

				BA3->BA3_CEP	:=	SA1->A1_CEPC
				BA3->BA3_END	:=	SA1->A1_ENDCOB
				BA3->BA3_BAIRRO	:=	SA1->A1_BAIRROC
				BA3->BA3_CODMUN	:=	BC9->BC9_CODMUN
				BA3->BA3_MUN	:= 	SA1->A1_MUNC
				BA3->BA3_ESTADO	:=	SA1->A1_ESTC

			EndIf

		EndIf

		//VINCULACAO DE CLIENTE NAS FAMILIAS - FIM

	EndIf

	If ( nTipo == nBloqueia )//Somente no Bloqueio

		dDatBlo         := If(!Empty(AllTrim(PBU->PBU_DTEXC)),ctod(PBU->PBU_DTEXC),iif(!Empty(AllTrim(PBU->PBU_DTFIPD)),ctod(PBU->PBU_DTFIPD),MSDATE()))
		cMotBlo         := If(!Empty(CtoD(AllTrim(PBU->PBU_MOTEXC))),dParaBlq(PBU->PBU_MOTEXC),"009")
		BA3->BA3_MOTBLO	:= cMotBlo
		BA3->BA3_DATBLO	:= dDatBlo

		//Historico de Bloqueio
		BloqFam(BA3->(BA3_CODINT+BA3_CODEMP+BA3_MATRIC),BA3->BA3_MATANT,dDatBlo,cMotBlo,BA3->BA3_MATEMP)

	EndIf

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³PreBTS    ºAutor  ³Microsiga           º Data ³  05/15/07   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function PreBTS(nTipo,lTit,lAcao)

	If nTipo == 1
		If empty(BTS->BTS_MATVID) //BIANCHINI - 24/07/2014 - GARANTINDO QUE A VIDA JA EXISTENTE SEJA REAPROVEITADA
			BTS->BTS_FILIAL	:=	xFilial("BTS")
			BTS->BTS_MATVID := GetSx8Num("BTS","BTS_MATVID")
			ConfirmSx8()
		EndIf
	EndIf

	If nTipo <= 2
		BTS->BTS_NOMUSR	:=	PBU->PBU_BENEF
		BTS->BTS_SOBRN	:=	SUBS( PBU->PBU_BENEF, AT( ' ', PBU->PBU_BENEF ) + 1 )
		//BTS->BTS_NOMCAR	:=	SUBS( PBU->PBU_BENEF, 01, AT( ' ', PBU->PBU_BENEF ) - 1 ) //Jean - Alterado em 24/11/07
		BTS->BTS_NOMCAR	:=	PBU->PBU_BENEF
		BTS->BTS_DATNAS	:=	ctod(PBU->PBU_DTNASC)
		BTS->BTS_SEXO	:=	iif(PBU->PBU_SEXO =="M","1","2")
		BTS->BTS_ESTCIV	:=	IIF(EMPTY(PBU->PBU_ESTCIV), 'S', PBU->PBU_ESTCIV ) // MARCELA COIMBRA - cONFORME ORIENTADO PELA MARCIA    POIS NAO VAI PRA ANS
		BTS->BTS_CPFUSR	:=	PBU->PBU_CPF//iif(lTit,PBU->PBU_CPF,"")
		BTS->BTS_PISPAS := 	iif(lTit .or. AllTrim( PBU->PBU_PIS ) <> '341' ,PBU->PBU_PIS,"")
		BTS->BTS_CEPUSR	:=	iif(At("-",PBU->PBU_CEP) > 0,Substr(PBU->PBU_CEP,1,5)+Substr(PBU->PBU_CEP,7,3),PBU->PBU_CEP)

		BC9->(DbSetOrder(1))
		If BC9->(DbSeek(xFilial("BC9")+BTS->BTS_CEPUSR))
			BTS->BTS_ENDERE	:= BC9->BC9_END
			BTS->BTS_NR_END := PBU->PBU_NUMERO
			BTS->BTS_COMEND := PBU->PBU_COMPLE
			BTS->BTS_BAIRRO	:=	BC9->BC9_BAIRRO
			BTS->BTS_CODMUN	:=	BC9->BC9_CODMUN
			BTS->BTS_MUNICI	:=	BC9->BC9_MUN
			BTS->BTS_ESTADO	:=	BC9->BC9_EST
		Else
			BTS->BTS_ENDERE	:= PBU->PBU_LOGRAD
			BTS->BTS_NR_END := PBU->PBU_NUMERO
			BTS->BTS_COMEND := PBU->PBU_COMPLE
			BTS->BTS_BAIRRO	:= PBU->PBU_BAIRRO
			BTS->BTS_MUNICI	:= PBU->PBU_CIDADE
			BTS->BTS_ESTADO	:= PBU->PBU_UF
		EndIf
		BTS->BTS_MAE		:= PBU->PBU_NOMMAE
		BTS->BTS_DDD    	:= PBU->PBU_DDDRES
		BTS->BTS_TELEFO		:= PBU->PBU_TELRES
		BTS->BTS_EMAIL		:= PBU->PBU_EMAIL
		BTS->BTS_YCEL		:= PBU->PBU_TELCEL

		//Angelo Henrique - Data:23/02/2016
		//Acrescentando o número do CNS

		BTS->BTS_NRCRNA := PBU->PBU_NROCNS

	EndIf
	//BTS->(MsUnlock())

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³PreBA1    ºAutor  ³Microsiga           º Data ³  04/12/07   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function PreBA1(nTipo, lTit, cProduto, cVerPro, cTipUsr)

	Local dDatBlo := CtoD("  /  /    ")
	Local cMotBlo := Space(0)
	Local cTipRegTmp := ' '

	//BA1->(RecLock("BA1",lAcao))

	If nTipo == 1
		BA1->BA1_CODINT := BA3->BA3_CODINT
		BA1->BA1_CODEMP := BA3->BA3_CODEMP
		BA1->BA1_MATRIC := BA3->BA3_MATRIC
		BA1->BA1_CONEMP := BA3->BA3_CONEMP
		BA1->BA1_VERCON := BA3->BA3_VERCON
		BA1->BA1_SUBCON := BA3->BA3_SUBCON
		BA1->BA1_VERSUB := BA3->BA3_VERSUB
		BA1->BA1_IMAGE	:= 'ENABLE'

		BA1->BA1_TIPUSU	:=	trim(PBU->PBU_CDBENE)
		BA1->BA1_GRAUPA	:=	IIF(PBT->PBT_LAYOUT == '1', trim(PBU->PBU_TPPARE) , dParaGrauP(PBU->PBU_TPPARE,iif(PBU->PBU_SEXO =="M","1","2"))  )

		//GERAR TIPREG SEQUENCIAL.  A FUNCAO PADRAO ESTAVA DEIXANDO TIPREG EM BRANCO - INICIO
		Do Case

			Case AllTrim(PBU->PBU_CDBENE) == 'T'

			cTipRegTmp := '00'

			Otherwise

			//Leonardo Portella - 09/06/15 - Inicio - Nao gerar erro na importacao quando o TIPREG nao
			//existir ou nao houver titular. Feita critica para este tipo de caso, mas o caso que ja
			//existem na base serao tratados posteriormente enquanto os beneficiarios devem ser
			//importados com urgencia

			//cQryTpReg := " SELECT LPAD(MAX(BA1_TIPREG)+1,2,'0') TIPREG "
			cQryTpReg := " SELECT LPAD(NVL(MAX(BA1_TIPREG),0)+1,2,'0') TIPREG "

			//Leonardo Portella - 09/06/15 - Fim

			cQryTpReg += " FROM "+RetSqlName("BA1")+" BA1 "
			cQryTpReg += " WHERE BA1_FILIAL = '"+xFilial("BA1")+"' "
			cQryTpReg += " AND BA1.BA1_CODINT = '"+BA1->BA1_CODINT+"' "
			cQryTpReg += " AND BA1.BA1_CODEMP = '"+BA1->BA1_CODEMP+"' "
			cQryTpReg += " AND BA1.BA1_MATRIC = '"+BA1->BA1_MATRIC+"' "
			cQryTpReg += " AND BA1.D_E_L_E_T_ = ' ' "

			//Leonardo Portella - 09/06/15 - Inicio - Nao gerar erro na importacao por causa do TIPREG
			cQryTpReg += " AND BA1.BA1_TIPREG <> ' ' "

			TCQUERY cQryTpReg ALIAS "TMPTPREG" NEW

			dbSelectArea( "TMPTPREG" )

			cTipRegTmp := TMPTPREG->TIPREG

			TMPTPREG->(DbCloseArea())

		EndCase
		//GERAR TIPREG SEQUENCIAL.  A FUNCAO PADRAO ESTAVA DEIXANDO TIPREG EM BRANCO - FIM

		BA1->BA1_TIPREG	:=	IIF(PBT->PBT_LAYOUT == '1', cTipRegTmp, PBU->PBU_DEPEND )
		BA1->BA1_DIGITO	:=	Modulo11( BA1->BA1_CODINT + BA1->BA1_CODEMP + BA1->BA1_MATRIC + BA1->BA1_TIPREG )
		BA1->BA1_DATINC	:= ctod( PBU->PBU_DTINCT ) // Marcela Coimbra	ctod(PBU->PBU_DTINPD) // PAULO MOTTA 26/04/07
		BA1->BA1_DTVLCR	:= ctod("  /  /    ")
		//A inclusao do produto no beneficiario somente devera ocorrer quando for inclusao de usuario
		//Quando for troca de plano (operacao 05) devera ser criado uma nova familia e bloqueada a anterior.

		BA1->BA1_CODPLA := cProduto    //dParaPrd(PBU->PBU_PADRAO,dParaTpBnf(PBU->PBU_CDBENE))   //BA3->BA3_CODPLA  //BI3->BI3_CODIGO
		BA1->BA1_VERSAO := cVerPro     //"001"                                                   //BA3->BA3_VERSAO
		**'--Início: Marcela Coimbra -Data: 29/06/10 -----------------'**
		BA1->BA1_VIACAR	:=	0
		**'--Fim: Marcela Coimbra -Data: 29/06/10 --------------------'**

	EndIf

	If nTipo <= 2 // Somente na Inclusao ou Alteracao

		BA1->BA1_CPFUSR	:=	PBU->PBU_CPF
		BA1->BA1_PISPAS	:=  BTS->BTS_PISPAS
		BA1->BA1_DRGUSR	:=	BTS->BTS_DRGUSR
		BA1->BA1_ORGEM	:=	BTS->BTS_ORGEM
		BA1->BA1_MATVID	:=	BTS->BTS_MATVID
		BA1->BA1_NOMUSR	:=	BTS->BTS_NOMUSR
		BA1->BA1_NREDUZ	:=	BTS->BTS_NOMCAR
		BA1->BA1_DATNAS	:=	BTS->BTS_DATNAS
		BA1->BA1_SEXO		:=	iif(PBU->PBU_SEXO =="M","1","2")
		BA1->BA1_ESTCIV	:=	BTS->BTS_ESTCIV
		BA1->BA1_DATADM	:=	ctod(PBU->PBU_DTADMI)
		BA1->BA1_RECNAS	:=	Iif( dDataBase - BTS->BTS_DATNAS <= 60, '1', '0' )
		BA1->BA1_CEPUSR	:=	BTS->BTS_CEPUSR
		BA1->BA1_ENDERE	:=	BTS->BTS_ENDERE
		BA1->BA1_NR_END	:=	BTS->BTS_NR_END //PAULO MOTTA 20/09/06
		BA1->BA1_COMEND	:=	BTS->BTS_COMEND //PAULO MOTTA 20/09/06
		BA1->BA1_BAIRRO	:=	BTS->BTS_BAIRRO
		BA1->BA1_CODMUN	:=	BTS->BTS_CODMUN
		BA1->BA1_MUNICI	:=	BTS->BTS_MUNICI
		BA1->BA1_ESTADO	:=	BTS->BTS_ESTADO
		BA1->BA1_DDD		:=	BTS->BTS_DDD // PAULO MOTTA 20/09/06
		BA1->BA1_TELEFO	:=	BTS->BTS_TELEFO
		BA1->BA1_YCEL   	:=  BTS->BTS_YCEL // PAULO MOTTA 20/09/06
		// BA1->BA1_DATCAR	:=	if(PBU->PBU_INDCAR == "S",ctod(PBU->PBU_DTINCT),ctod(PBU->PBU_DTINPD))
		BA1->BA1_MATEMP	:=	Trim(PBU->PBU_FUNC) + iIf( PBT->PBT_LAYOUT == '1', '-' + PBU->PBU_CPF, PBU->PBU_DEPEND)
		BA1->BA1_DATCAR	:=	ctod(PBU->PBU_DTINPD) //if(PBU->PBU_INDCAR == "S",ctod(PBU->PBU_DTINPD),CtoD("01/11/03"))//Paulo Motta 22/3/07 carencia data contrato
		//BA1->BA1_CONSID	:=	'U'
		BA1->BA1_COEFIC	:=	1
		BA1->BA1_MUDFAI	:=	"1"
		BA1->BA1_CORNAT	:=	BTS->BTS_CORNAT
		BA1->BA1_SANGUE	:=	BTS->BTS_SANGUE
		**'--Início: Marcela Coimbra -Data: 29/06/10 -----------------'**
		//	BA1->BA1_VIACAR	:=	0
		**'--Fim: Marcela Coimbra -Data: 29/06/10 --------------------'**
		BA1->BA1_CODFUN	:=	BTS->BTS_CODFUN
		BA1->BA1_INSALU	:=	BTS->BTS_INSALU
		BA1->BA1_CODSET	:=	BTS->BTS_CODSET
		BA1->BA1_PESO	:=	BTS->BTS_PESO
		BA1->BA1_ALTURA	:=	BTS->BTS_ALTURA
		BA1->BA1_OBESO	:=	BTS->BTS_OBESO
		BA1->BA1_RGIMP	:=	'1'
		BA1->BA1_JACOBR	:=	'0'
		BA1->BA1_INFCOB	:=	'0'
		BA1->BA1_INFGCB	:=	'0'
		BA1->BA1_INFPRE	:=	'0'
		BA1->BA1_NSUBFT	:=	''
		BA1->BA1_USRVIP	:=	'0'
		BA1->BA1_UNIVER := '0'
		BA1->BA1_INTERD := '0'
		BA1->BA1_10ANOS := '0'
		BA1->BA1_INSALU := '0'
		BA1->BA1_COBNIV := '0'
		BA1->BA1_ESCOLA := '0'
		BA1->BA1_CB1AMS := '0'
		BA1->BA1_BANCO	:=	''
		BA1->BA1_AGENCI	:=	''
		BA1->BA1_CONTA	:=	''
		BA1->BA1_LOCCOB := '1'
		BA1->BA1_LOCATE := '1'
		BA1->BA1_LOCEMI	:=	'1'
		BA1->BA1_LOCANS	:=	'1'
		BA1->BA1_INFSIB	:=	'1'
		BA1->BA1_INFANS	:=	'1'
		BA1->BA1_ATUSIB :=  '1'

		If nTipo == 1
			BA1->BA1_LOCSIB	:=	'0'
		ElseIf !Empty( BA1->BA1_CODCCO )
			BA1->BA1_LOCSIB	:=	'1'
		EndIf

		BA1->BA1_OK		:= ''
		BA1->BA1_ESCOLA	:=	''
		BA1->BA1_CDORIG	:=	''
		BA1->BA1_PSORIG	:=	''
		BA1->BA1_OUTLAN := '0'
		BA1->BA1_LANREJ := '0'
		BA1->BA1_STAEDI := '1'
		BA1->BA1_SOBRN	:=	BTS->BTS_SOBRN
		BA1->BA1_FILIAL	:=	xFilial("BA1")
		BA1->BA1_TIPINC	:=	''
		BA1->BA1_LOTTRA	:=	''
		BA1->BA1_FORPAG	:=	'101'
		BA1->BA1_OPEORI	:=	PBT->PBT_CODOPE
		BA1->BA1_OPEDES	:=	PBT->PBT_CODOPE
		BA1->BA1_OPERES	:=	PBT->PBT_CODOPE
		BA1->BA1_MAE	:=  BTS->BTS_MAE
		BA1->BA1_IMPORT := "PREFEITURA: " + PBT->PBT_SEQUEN //Angelo Henrique - Data: 04/03/2016 - Acrescentado informação prefeitura
		BA1->BA1_YLOTAC := PBU->PBU_CODLOT
		BA1->BA1_YNOMLO := PBU->PBU_ORGAO
		BA1->BA1_YINDEN := PBU->PBU_INDENV
		BA1->BA1_YDTDIG := dDataBase
		//Campos Customizados Prefeitura
		BA1->BA1_YTPRGP	:= AllTrim(PBU->PBU_TPREGI) //0 - Titular Efetivo ; 1 - Titular Estranho aos Quadros ; 2 - Titular Pensionista / 3 - Dependente
		BA1->BA1_YNMSOC	:= AllTrim(PBU->PBU_NOMSOC) //NOME SOCIAL
		BA1->BA1_YCPLAP	:= AllTrim(PBU->PBU_PADRAO) //CODIGO DOS PLANOS NA PREFEITURA

		//Angelo Henrique - Mudança nos planos
		/*If cProduto $ '0092|0093|0094|0095|0096|0097'
		BA1->BA1_YDPLAP	:= ConvPlano(trim(PBU->PBU_PADRAO),'MED','N')		//DESC.QUE VAI PRA CARTEIRA NA PREFEITURA
		ElseIf cProduto $ '0098|0099'
		BA1->BA1_YDPLAP	:= ConvPlano(trim(PBU->PBU_PADRAO),'ODO','N')    	//DESC.QUE VAI PRA CARTEIRA NA PREFEITURA
		EndIf  //ConvPlano(trim(PBU->PBU_PADRAO),Alltrim(PBU->PBU_CDBENE),1)*/
		//BA1->BA1_YDPLAP	:= ConvPlano(trim(PBU->PBU_PADRAO),'ODO','N')
		BA1->BA1_YDPLAP	:= ConvPlano(trim(PBU->PBU_PADRAO),Alltrim(PBU->PBU_CDBENE),2)
	EndIf

	If nTipo == 3	// Somente no Bloqueio
		dDatBlo         := Iif(!Empty(AllTrim(PBU->PBU_DTEXC)),ctod(PBU->PBU_DTEXC),iif(!Empty(AllTrim(PBU->PBU_DTFIPD)),ctod(PBU->PBU_DTFIPD),MSDATE()))
		cMotBlo         := Iif(!Empty(CtoD(AllTrim(PBU->PBU_MOTEXC))),dParaBlq(PBU->PBU_MOTEXC),"009")

		BA1->BA1_MOTBLO := cMotBlo   //iif(!Empty(AllTrim(PBU->PBU_MOTEXC)),dParaBlq(PBU->PBU_MOTEXC),"009")
		BA1->BA1_DATBLO := dDatBlo   //iif(!Empty(CtoD(AllTrim(PBU->PBU_DTEXC))),CtoD(PBU->PBU_DTEXC),MSDATE())
		BA1->BA1_IMAGE  := 'DISABLE'
		BA1->BA1_CONSID := "U"
		BA1->BA1_BLOFAT := "1"
		//Verifica se é uma reativação de beneficiario
		If PBU->PBU_OPERSI $ ("11_03_01")
			BA1->BA1_MOTBLO := " "
			BA1->BA1_DATBLO := StoD("        ")
			BA1->BA1_IMAGE  := 'ENABLE'
		EndIf

		//Historico de Bloqueio
		BloqUsu(BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC),BA1->BA1_TIPREG,BA1->BA1_MATANT, dDatBlo, cMotBlo)
		//Estorna o valor da mensalidade gerada para cobrança futura, via lancamento de debito/credito
		If AllTrim(PBU->PBU_OPER) $ ("03")   //Exclusao de Beneficiario
			EstBM1(BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC),BA1->BA1_TIPREG)
		EndIf
	EndIf
	//BA1->(MsUnlock())
Return



/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±±
±±³Funcao    ³ LOGERRO    ³ Autor ³ Bianchini/Marcela   ³ Data ³ 28.08.03 ³±±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±±
±±³Descricao ³ Mostra Composicao do Log de Erros                          ³±±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

User Function F336ERR()

	//Private aRotina   	:=	{}
	Private aRotina   	:=	{{ "Legenda"   , "U_CAB336LEG(2)", 0 , K_Incluir    }}
	Private cAlias    	:= "PBV"


	Private aCdCores 	:= { { 'BR_VERDE','Registro Processado Com Erro, Movto Acatado (alerta)' },{ 'BR_VERMELHO','Registro Processado Com Erro, Movto Acatado (rejeitado)' }}
	//Private aCores := { { 'Empty(AllTrim(PBU_TABERR)) = ""',aCdCores[1,1] },{ 'AllTrim(PBU_TABERR) > ""',aCdCores[2,1] }}
	Private aCores   	:= { { 'Empty(AllTrim(PBV_FILIAL))',aCdCores[1,1] }}

	#IFDEF TOP
	Private cFil := "@PBV_FILIAL = '"+xFilial("PBV")+"'"
	cFil += " AND PBV_SEQUEN = '"+PBU->PBU_SEQUEN+"' AND PBV_NUMLIN = '"+PBU->PBU_NUMLIN+"' AND D_E_L_E_T_ = ' '"
	#Else
	Private cFil := "PBV_FILIAL = '"+xFilial("PBV")+"'"
	cFil += " .and. PBU_SEQUEN = '"+PBT->PBT_SEQUEN+"' .and. PBV_NUMLIN = '"+PBU->PBU_NUMLIN+"'"
	#EndIf

	PBV->(DBSetOrder(1))
	DbSelectArea("PBV")
	SET FILTER TO &cFil

	PBV->(mBrowse(006,001,022,075,"PBV" ,nil ,nil ,nil ,nil ,4, aCores,nil ,nil ,nil ,,.T.,nil))
	PBV->(DbClearFilter())

Return	

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±±
±±³Funcao    ³ VEROPER    ³ Autor ³ Bianchini/Marcela   ³ Data ³ 28.08.03 ³±±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±±
±±³Descricao ³ Verifica qual operacao sera executada sibre o registro     ³±±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
01-	Inclusão normal
02-	Inclusão retroativa
03-	Alteração cadastral normal
04-	Alteração do tipo de usuário
05-	Alteração da data de nascimento
06-	Alteração de plano
07-	Exclusão normal
08-	Exclusão retroativa
09-	Exclusão posterior / Futura
10-	Troca de empresas/sub-contratos
11-	Reativação do usuário
/*/

Static Function VEROPER(cAcao)

	Local cTipo 	:= ""
	Local aProduto 	:= {}
	Local cTipUsr  	:= Space(0)
	Local lRet 		:= .F.
	Local cSql 		:= Space(0)
	Local n			:= 0

	aProduto := DParaPrd()
	//If Len(aProduto) <= 0
	//	cAcao := ""
	//	Return(cTipo)
	//EndIf

	For n := 1 to Len(aProduto)
		If aProduto[n,1] <> "0"
			cTipo := "00"   //AllTrim(PBU->PBU_OPER)
			cAcao := "Atencao! Contrato nao parametrizado pela CABERJ"
			Return(cTipo)
		EndIf
		cTipUsr := aProduto[n,8]
	Next

	cSql := "SELECT BA1_CODINT, BA1_CODEMP, BA1_CONEMP, BA1_VERCON, BA1_SUBCON, BA1_VERSUB, BA1_MATRIC, BA1_TIPREG, BA1_TIPUSU, BA1_DATBLO, BA1_DATNAS, BA1.R_E_C_N_O_ AS BA1RECNO "
	cSql += " FROM "+RetSqlName("BA1")+" BA1, "+RetSqlName("BQC")+" BQC "
	cSql += " WHERE BA1_FILIAL = '"+xFilial("BA1")+"' "
	cSql += " AND BQC_FILIAL = '"+xFilial("BQC")+"' "
	cSql += " AND BQC.d_e_l_e_t_ = ' ' "
	cSql += " AND BA1.d_e_l_e_t_ = ' ' "
	cSql += " AND BQC.BQC_CODINT = BA1.BA1_CODINT "
	cSql += " AND BQC.BQC_CODEMP = BA1.BA1_CODEMP "
	cSql += " AND BQC.BQC_NUMCON = BA1.BA1_CONEMP "
	cSql += " AND BQC.BQC_VERCON = BA1.BA1_VERCON "
	cSql += " AND BQC.BQC_SUBCON = BA1.BA1_SUBCON "
	cSql += " AND BQC.BQC_VERSUB = BA1.BA1_VERSUB "
	cSql += " AND BQC.BQC_YCDCON = '" + AllTrim(PBU->PBU_CONTR)+"' "   //in ('01115','01123') "
	cSql += " AND BA1.BA1_MATEMP = '" + AllTrim(PBU->PBU_FUNC)+AllTrim(PBU->PBU_DEPEND)+"' "
	cSql += " ORDER BY BA1_MATEMP, BA1_CODINT, BA1_CODEMP, BA1_MATRIC, BA1_TIPREG, BA1.R_E_C_N_O_ "

	PlsQuery(cSql,"TMPBA1")

	TmpBA1->(DbGoTop())

	If TmpBA1->(Eof())
		lRet := .T.
	EndIf

	If PBU->PBU_OPER == "01"   //Inclusao de Cadastro
		If !TmpBA1->(Eof())   //Pesquiso para verificar se existe o beneficiario, nao titular.
			While !TmpBA1->(Eof())
				//			If !(AllTrim(PBU->PBU_CDBENE) $ "T_A")
				If !Empty(TmpBA1->BA1_DATBLO)
					cTipo := "11"  //Reativacao do usuario
					cAcao := "Reativação do usuario"
				Else
					cTipo := "03"      //Alteração cadastral normal
					cAcao := "Alteracao cadastral normal"
				EndIf
				//			EndIf
				TmpBA1->(DbSkip())
			EndDo
		ElseIf ctod(PBU->PBU_DTINPD) < dDatabase
			cTipo := "02"  //Inclusao Retroativa
			cAcao := "Inclusao Retroativa"
		Else
			cTipo := "01"  //Inclusao Normal
			cAcao := "Inclusao Normal"
		EndIf
	ElseIf PBU->PBU_OPER == "02"   //Alteracao de Cadastro
		If !TmpBA1->(Eof())         //Pesquiso para verificar se existe o beneficiario, nao titular.
			While !TmpBA1->(Eof())
				If !Empty(TmpBA1->BA1_DATBLO)
					cTipo := "11"  //Reativacao do usuario
					cAcao := "Reativação do usuario"
				EndIf
				If TmpBA1->BA1_TIPUSU <> cTipUsr    //DParaTpBnf(PBU->PBU_PADRAO, PBU->PBU_CDBENE)  //DPTpBnfbd(PBU->PBU_CDBENE)  // Verifico se houve mudanca no tipo de beneficiario. Se houve verifico se mantem na mesma familia.
					cTipo := "04"  //Alteração do tipo de usuário
					cAcao := "Alteração do tipo de usuário"
				ElseIf TmpBA1->BA1_DATNAS <> CTOD(PBU->PBU_DTNASC)
					cTipo := "05"  //Alteração da data de nascimento
					cAcao := "Alteração da data de nascimento"
					//		ElseIf BA1->BA1_CODPLA <> dParaPrd(PBU->PBU_PADRAO,DParaTpBnf(PBU->PBU_CDBENE)) // Verifica o produto do beneficiario e diferente do atual. Se nao for verifico se mantem na mesma familia.
					//			cTipo := "10"  //Troca de empresas/sub-contratos
					//			cAcao := "Troca de empresas/sub-contratos"
					////			cTipo := "06"
					////			cAcao := "Alteração de plano"
					/*
					ElseIf !Empty(ctod(PBU->PBU_DTEXC))   //Solicitacao de exclusao de beneficiario com operacao incorreta
					If ctod(PBU->PBU_DTEXC) < dDatabase
					cTipo := "08"   //Exclusão retroativa
					cAcao := "Exclusão retroativa"
					ElseIf ctod(PBU->PBU_DTEXC) == dDatabase
					cTipo := "07"  //Exclusão normal
					cAcao := "Exclusão normal"
					Else
					cTipo := "09"  //Exclusão posterior / Futura
					cAcao := "Exclusão posterior / Futura"
					EndIf
					*/
				Else
					cTipo := "03"      //Alteração cadastral normal
					cAcao := "Alteração cadastral normal"
				EndIf
				TmpBA1->(DbSkip())
			EndDo
		Else
			If ctod(PBU->PBU_DTINPD) < dDatabase
				cTipo := "02"  //Inclusao Retroativa
				cAcao := "Inclusao Retroativa"
			Else
				cTipo := "01"  //Inclusao Normal
				cAcao := "Inclusao Normal"
			EndIf
		EndIf
	ElseIf PBU->PBU_OPER == "03"   //Encerramento do Convenio (providenciar devolucao de cobranca)
		If ctod(PBU->PBU_DTEXC) < dDatabase
			cTipo := "08"   //Exclusão retroativa
			cAcao := "Exclusão retroativa"
		ElseIf ctod(PBU->PBU_DTEXC) == dDatabase
			cTipo := "07"  //Exclusão normal
			cAcao := "Exclusão normal"
		Else
			cTipo := "09"  //Exclusão posterior / Futura
			cAcao := "Exclusão posterior / Futura"
		EndIf
	ElseIf PBU->PBU_OPER == "04"   //Transferencia Entre Empresas no Conglomerado
		cTipo := "10"  //Troca de empresas/sub-contratos
		cAcao := "Troca de empresas/sub-contratos"
	ElseIf PBU->PBU_OPER == "05"   //Transferencia entre Planos
		//Pesquiso para verificar se existe o beneficiario, nao titular.
		If !TmpBA1->(Eof())         //Pesquiso para verificar se existe o beneficiario, nao titular.
			While !TmpBA1->(Eof())
				If AllTrim(PBU->PBU_CDBENE) $ "A" .and. TmpBA1->BA1_TIPUSU != cTipUsr
					cTipo := "04"  //Alteração do tipo de usuário
					cAcao := "Alteração do tipo de usuário"
				Else
					cTipo := "06"  //Alteração de plano
					cAcao := "Alteração de plano"
				EndIf
				TmpBA1->(DbSkip())
			EndDo
		EndIf
	ElseIf PBU->PBU_OPER == "06"  //Reativacao do Beneficiario
		cTipo := "11"  //Reativação do usuário
		cAcao := "Reativação do usuário"
	EndIf

	TmpBA1->(DbCloseArea())

	/*
	nRecno := BA1->(Recno())
	nOrder := BA1->(IndexOrd())
	BA1->(dbSetOrder(6))
	If PBU->PBU_OPER == "01"   //Inclusao de Cadastro
	//Pesquiso para verificar se existe o beneficiario, nao titular.
	If BA1->(DbSeek(xFilial("BA1")+PBU->PBU_FUNC+PBU->PBU_DEPEND)) .and. !(AllTrim(PBU->PBU_CDBENE) $ "T_A") .and. !Empty(BA1->BA1_DATBLO)   //Beneficario bloqueado
	While !BA1->(Eof()) .and. xFilial("BA1")+PBU->PBU_FUNC+PBU->PBU_DEPEND == xFilial("BA1")+AllTrim(BA1->BA1_MATEMP)
	If !Empty(BA1->BA1_DATBLO)
	cTipo := "11"  //Reativacao do usuario
	cAcao := "Reativação do usuario"
	Else
	cTipo := "03"      //Alteração cadastral normal
	cAcao := "Alteração cadastral normal"
	EndIf
	BA1->(DbSkip())
	EndDo
	ElseIf ctod(PBU->PBU_DTINPD) < dDatabase
	cTipo := "02"  //Inclusao Retroativa
	cAcao := "Inclusao Retroativa"
	Else
	cTipo := "01"  //Inclusao Normal
	cAcao := "Inclusao Normal"
	EndIf
	ElseIf PBU->PBU_OPER == "02"   //Alteracao de Cadastro
	If BA1->(dbSeek(xFilial("BA1")+PBU->PBU_FUNC+PBU->PBU_DEPEND))  //Pesquiso para verificar se existe o beneficiario
	If BA1->BA1_TIPUSU <> cTipUsr    //DParaTpBnf(PBU->PBU_PADRAO, PBU->PBU_CDBENE)  //DPTpBnfbd(PBU->PBU_CDBENE)  // Verifico se houve mudanca no tipo de beneficiario. Se houve verifico se mantem na mesma familia.
	//			If BA1->BA1_TIPUSU <> DParaTpBnf(PBU->PBU_CDBENE)
	cTipo := "04"  //Alteração do tipo de usuário
	cAcao := "Alteração do tipo de usuário"
	ElseIf BA1->BA1_DATNAS <> CTOD(PBU->PBU_DTNASC)
	cTipo := "05"  //Alteração da data de nascimento
	cAcao := "Alteração da data de nascimento"
	//		ElseIf BA1->BA1_CODPLA <> dParaPrd(PBU->PBU_PADRAO,DParaTpBnf(PBU->PBU_CDBENE)) // Verifica o produto do beneficiario e diferente do atual. Se nao for verifico se mantem na mesma familia.
	//			cTipo := "10"  //Troca de empresas/sub-contratos
	//			cAcao := "Troca de empresas/sub-contratos"
	////			cTipo := "06"
	////			cAcao := "Alteração de plano"
	/*
	ElseIf !Empty(ctod(PBU->PBU_DTEXC))   //Solicitacao de exclusao de beneficiario com operacao incorreta
	If ctod(PBU->PBU_DTEXC) < dDatabase
	cTipo := "08"   //Exclusão retroativa
	cAcao := "Exclusão retroativa"
	ElseIf ctod(PBU->PBU_DTEXC) == dDatabase
	cTipo := "07"  //Exclusão normal
	cAcao := "Exclusão normal"
	Else
	cTipo := "09"  //Exclusão posterior / Futura
	cAcao := "Exclusão posterior / Futura"
	EndIf
	*/
	/*
	Else
	cTipo := "03"      //Alteração cadastral normal
	cAcao := "Alteração cadastral normal"
	EndIf
	Else
	If ctod(PBU->PBU_DTINPD) < dDatabase
	cTipo := "02"  //Inclusao Retroativa
	cAcao := "Inclusao Retroativa"
	Else
	cTipo := "01"  //Inclusao Normal
	cAcao := "Inclusao Normal"
	EndIf
	EndIf
	ElseIf PBU->PBU_OPER == "03"   //Encerramento do Convenio (providenciar devolucao de cobranca)
	If ctod(PBU->PBU_DTEXC) < dDatabase
	cTipo := "08"   //Exclusão retroativa
	cAcao := "Exclusão retroativa"
	ElseIf ctod(PBU->PBU_DTEXC) == dDatabase
	cTipo := "07"  //Exclusão normal
	cAcao := "Exclusão normal"
	Else
	cTipo := "09"  //Exclusão posterior / Futura
	cAcao := "Exclusão posterior / Futura"
	EndIf
	ElseIf PBU->PBU_OPER == "04"   //Transferencia Entre Empresas no Conglomerado
	cTipo := "10"  //Troca de empresas/sub-contratos
	cAcao := "Troca de empresas/sub-contratos"
	ElseIf PBU->PBU_OPER == "05"   //Transferencia entre Planos
	//Pesquiso para verificar se existe o beneficiario, nao titular.
	If BA1->(dbSeek(xFilial("BA1")+PBU->PBU_FUNC+PBU->PBU_DEPEND)) .and. AllTrim(PBU->PBU_CDBENE) $ "A" .and. BA1->BA1_TIPUSU != cTipUsr   //DParaTpBnf(PBU->PBU_CDBENE)
	cTipo := "04"  //Alteração do tipo de usuário
	cAcao := "Alteração do tipo de usuário"
	Else
	cTipo := "06"  //Alteração de plano
	cAcao := "Alteração de plano"
	EndIf
	ElseIf PBU->PBU_OPER == "06"  //Reativacao do Beneficiario
	cTipo := "11"  //Reativação do usuário
	cAcao := "Reativação do usuário"
	EndIf
	BA1->(dbSetOrder(nOrder))
	BA1->(DbGoto(nRecno))
	*/

Return(cTipo)


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CopiaReg  ºAutor  ³Microsiga           º Data ³  13/04/07   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Copia registro da tabela repassada por parametro, cria um   º±±
±±º          ³novo registro na tabela identico (bloqueado) e mantem o     º±±
±±º          ³posicionamento anterior ao processo.                        º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ MP8                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function CopiaReg(cTabela)

	Local aStru := {}
	Local nCont := 0
	Local aCampos := {}
	Local aAreaBA1 := BA1->(GetArea())
	Local aAreaBA3 := BA3->(GetArea())
	Local aAreaBCA := BCA->(GetArea())
	Local cDBStruct := cTabela+"->(DbStruct())"
	Local aRet := {0,""}

	Local cInstruc := ""

	aStru := &cDBStruct

	For nCont := 1 to Len(aStru)
		If aStru[nCont,2] $ "C,N,D"
			aAdd(aCampos,{cTabela+"->"+aStru[nCont,1],aStru[nCont,2],&(cTabela+"->"+aStru[nCont,1])}) //aCampos[X,Y,Z]  = X = Nome Campo, Y = Tipo, Z=Conteudo campo
		EndIf
	Next

	Begin Transaction

		&(cTabela+'->(RecLock("'+cTabela+'",.T.))')
		For nCont := 1 to Len(aCampos)

			Do Case
				Case aCampos[nCont,2] == "C"
				cConteudo := '"'+aCampos[nCont,3]+'"'
				Case aCampos[nCont,2] == "D"
				cConteudo := 'CtoD("'+DtoC(aCampos[nCont,3])+'") '
				Case aCampos[nCont,2] == "N"
				cConteudo := Str(aCampos[nCont,3])//+'") '  'Val("'+
			EndCase

			cInstruc := aCampos[nCont,1]+" := "+cConteudo
			&cInstruc

		Next
		cInstruc := cTabela+'->'+cTabela+'_DATBLO := CtoD("'+DtoC(dDataBase)+'" ) '       //ctod(PBU->PBU_DTADMI)
		&cInstruc
		cInstruc := cTabela+'->'+cTabela+'_MOTBLO := "'+GetNewPar("MV_YMTBLTI","006")+'" '
		&cInstruc
		cInstruc := cTabela+'->'+cTabela+'_IMPORT := "HISTITAU" '
		&cInstruc

		If cTabela == "BA1"
			cInstruc := cTabela+'->'+cTabela+'_IMAGE := "DISABLE" '
			&cInstruc
			aRet[2] := BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG+BA1_DIGITO)

			//Historico de Bloqueio
			BloqUsu(BA1->(BA1_CODINT + BA1_CODEMP + BA1_MATRIC),BA1->BA1_TIPREG, BA1->BA1_MATANT, BA1->BA1_DATBLO, BA1->BA1_MOTBLO)
			If AllTrim(PBU->PBU_OPER) $ ("05")   //Transferencia do beneficiario
				EstBM1(BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC),BA1->BA1_TIPREG)
			EndIf
		EndIf
		&(cTabela+'->(MsUnlock())')

		aRet[1] := &(cTabela+'->(Recno())')

	End Transaction

	RestArea(aAreaBA1)
	RestArea(aAreaBA3)
	RestArea(aAreaBCA)

Return aRet


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ CAB336EXP   ³ Autor ³ Bianchini/Marcela ³ Data ³ 26.12.2008 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Exportar Arquivo Criticado                                 ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function CAB336ENV(cAlias,nReg,nOpc)

	Local cNomeArq	:= ""
	//Local cPath    := GetNewPar("MV_YEXBIT","N:\Protheus_data\interface\importa\itaubenef\Envio\")
	Local cPath    := GetNewPar("MV_YEXBIT","\interface\importa\itaubenef\Envio\")
	Local cLin     := Space(1)+CHR(13)+CHR(10)
	Local nReg     := 0
	Local lGrav    := .F.
	Local nQtdErros := 0

	Private nHdl

	cNomeArq := cPath+"R_"+AllTrim(PBT->PBT_NOMARQ)

	If PBT->PBT_STATUS $ ("2|3|4|5")
		cSql := "SELECT * FROM "+RetSqlName("PBU")+" Where PBU_SEQUEN = '"+PBT->PBT_SEQUEN+"'"
		cSql += " AND D_E_L_E_T_ = ' '"
		PlsQuery(cSql,"TMPPBU")
		If !TMPPBU->(EOF())
			If U_Cria_TXT(cNomeArq)
				// header
				cCpo := '01'
				cCpo += substr(PBT->PBT_CTREMP,1,5)
				cCpo += iif(AllTrim(PBT->PBT_CTREMP) == '01115','04697','04705')//FILIAL
				cCpo += 'CABERJ'+Replicate(' ',44)
				cCpo += '42182170000184'//CGC
				cCpo +=  Replicate(' ',10)//SAP
				cCpo +=  '0'
				cCpo +=  Substr(PBT->PBT_LINHA, 88, 06)   //PBT->PBT_SEQARQ
				cCpo += '001'//versao
				//			cCpo += Substr(DToC(dDatabase),1,2)+'.'+Substr(DToC(dDatabase),4,2)+'.'+Substr(DToC(dDatabase),7,4)
				//			cCpo += StrTran(Time(),':','')
				cCpo += Substr(PBT->PBT_LINHA, 97, 10)  //PBT_DATGER
				cCpo += Substr(PBT->PBT_LINHA, 107, 6)  //PBT_HORGER
				cCpo += Space(888)
				If !(U_GrLinha_TXT(cCpo,cLin))
					MsgAlert("ATENÇÃO! NÃO FOI POSSÍVEL GRAVAR CORRETAMENTE A LINHA ATUAL! OPERAÇÃO ABORTADA!")
					Return
				EndIf
				// detalhe
				While !TMPPBU->(EOF())
					cCpo := '10'
					cCpo += TMPPBU->PBU_OPER
					cCpo += TMPPBU->PBU_FUNC
					cCpo += TMPPBU->PBU_DEPEND
					cCpo += TMPPBU->PBU_BENEF
					cCpo += TMPPBU->PBU_IDGPF
					cCpo += TMPPBU->PBU_IDCONV
					cCpo += TMPPBU->PBU_IDDEP
					cCpo += TMPPBU->PBU_DTNASC
					cCpo += TMPPBU->PBU_UFNASC
					cCpo += TMPPBU->PBU_TPDOC
					cCpo += TMPPBU->PBU_NRODOC
					cCpo += TMPPBU->PBU_TPPARE
					cCpo += TMPPBU->PBU_TPBENE
					cCpo += TMPPBU->PBU_CDBENE
					cCpo += TMPPBU->PBU_SEXO
					cCpo += TMPPBU->PBU_ESTCIV
					cCpo += TMPPBU->PBU_CPF
					cCpo += TMPPBU->PBU_PIS
					cCpo += TMPPBU->PBU_BANCO
					cCpo += TMPPBU->PBU_AGENC
					cCpo += TMPPBU->PBU_NUMCC
					cCpo += TMPPBU->PBU_DTADMI
					cCpo += TMPPBU->PBU_DTDESL
					cCpo += TMPPBU->PBU_NOMMAE
					cCpo += TMPPBU->PBU_CONTR
					cCpo += TMPPBU->PBU_DTINCT
					cCpo += TMPPBU->PBU_FILIT
					cCpo += TMPPBU->PBU_PADRAO
					cCpo += TMPPBU->PBU_DTINPD
					cCpo += TMPPBU->PBU_DTFIPD
					cCpo += TMPPBU->PBU_DTBASE
					cCpo += TMPPBU->PBU_CODEMP
					cCpo += TMPPBU->PBU_NOMEMP
					cCpo += TMPPBU->PBU_CODLOT
					cCpo += TMPPBU->PBU_ORGAO
					cCpo += TMPPBU->PBU_UFLOT
					cCpo += TMPPBU->PBU_CDUNI
					cCpo += TMPPBU->PBU_DTEXC
					cCpo += TMPPBU->PBU_MOTEXC
					cCpo += TMPPBU->PBU_DTINCO
					cCpo += TMPPBU->PBU_INDENV
					cCpo += TMPPBU->PBU_LOGRAD
					cCpo += TMPPBU->PBU_NUMERO
					cCpo += TMPPBU->PBU_COMPLE
					cCpo += TMPPBU->PBU_BAIRRO
					cCpo += TMPPBU->PBU_CEP
					cCpo += TMPPBU->PBU_CIDADE
					cCpo += TMPPBU->PBU_UF
					cCpo += TMPPBU->PBU_DDDRES
					cCpo += TMPPBU->PBU_TELRES
					cCpo += TMPPBU->PBU_DDDCOM
					cCpo += TMPPBU->PBU_TELCOM
					cCpo += TMPPBU->PBU_RAMAL
					cCpo += TMPPBU->PBU_DDDCEL
					cCpo += TMPPBU->PBU_TELCEL
					cCpo += TMPPBU->PBU_EMAIL
					cCpo += TMPPBU->PBU_FUNANT
					cCpo += Space(46)
					cCpo += TMPPBU->PBU_INDCAR
					cCpo += TMPPBU->PBU_INDTRA
					cCpo += TMPPBU->PBU_DTTRAN
					cCpo += space(95)
					cCpo += iif(Empty(AllTrim(TMPPBU->PBU_TABERR)),"S","E")
					cCpo += TMPPBU->PBU_SEQREG
					cCpo += space(41)
					cCpo += TMPPBU->PBU_TABERR

					**'---------------------------------------------'**
					**'-- Marcela Coimbra ----Data: 29/06/2010 -----'**
					**'-INI-----------------------------------------'**
					cLograd := ""
					cLograd += TMPPBU->PBU_IDLOGR
					cLograd += TMPPBU->PBU_CODLOG
					cLograd += TMPPBU->PBU_MUNLOG
					cLograd += SubStr(TMPPBU->PBU_ENDLOG, 1, 60)
					cLograd += TMPPBU->PBU_COMLOG
					cLograd += TMPPBU->PBU_BAILOG
					cLograd += TMPPBU->PBU_CITLOG
					cLograd += TMPPBU->PBU_ESTLOG
					/*
					If !Empty( cLograd )

					cCpo += cLograd

					Else

					cCpo += space(499)

					EndIf

					If Len(cCpo) < 1500

					cCpo := padr(cCpo, 1499)

					EndIf
					*/
					**'---------------------------------------------'**
					**'-- Marcela Coimbra ----Data: 29/06/2010 -----'**
					**'-FIM-------------------

					nReg += 1
					If !Empty(TMPPBU->PBU_TABERR)
						nQtdErros += 1
					EndIf
					If !(U_GrLinha_TXT(cCpo,cLin))
						MsgAlert("ATENÇÃO! NÃO FOI POSSÍVEL GRAVAR CORRETAMENTE A LINHA ATUAL! OPERAÇÃO ABORTADA!")
						Return
					EndIf
					TMPPBU->(DbSkip())
				Enddo
				// trailler
				cCpo := '99'
				cCpo += SubStr(PBT->PBT_CTREMP,1,5)
				cCpo += iif(AllTrim(PBT->PBT_CTREMP) == '01115','04697','04705')    //FILIAL
				cCpo += StrZero(nReg,9,0)
				cCpo += Space(979)
				If !(U_GrLinha_TXT(cCpo,cLin))
					MsgAlert("ATENÇÃO! NÃO FOI POSSÍVEL GRAVAR CORRETAMENTE A LINHA ATUAL! OPERAÇÃO ABORTADA!")
					Return
				EndIf
				U_Fecha_TXT()
				lGrav := .T.
			EndIf
		EndIf
		TMPPBU->(DbCloseArea())
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Mudo o status do arquivo colocando como exportado no BD               ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

		If lGrav == .T.
			PBT->(RecLock("PBT",.F.))
			PBT->PBT_STATUS := "6"
			PBT->PBT_DTINSB := dDatabase
			PBT->(MsUnlock())

			EnviaEmail(AllTrim(PBT->PBT_NOMARQ),nReg,nQtdErros)

			MsgAlert("Arquivo gravado com sucesso!!")
		EndIf
	Else
		MsgInfo("Somente e possivel inserir no BD arquivos com status inserido bd!")
	EndIf
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Fim da Rotina...                                                    ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

Return	

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ RELREGIMP  ³ Autor ³ Luzio             ³ Data ³ 26.12.2008 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Imprime rel. Arquivo                                       ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function RELREGIMP(cAlias,nReg,nOpc)

	Private cCRPar:="1;0;1;RESUMO DE IMPORTACAO DO ARQUIVO ITAU"
	/*Conjunto de opções para nao mostrar a tela da SetPrint, composta por x;y;z;w, onde
	x = vídeo(1) ou impressora(3)
	y = Atualiza(0) ou não(1) os dados
	z = Número de cópias
	w = Título do relatorio.
	*/

	If PBT->PBT_STATUS >= "3"
		//³ CHAMADA DO RELATORIO - PASSANDO O PARAMETRO DO REL.                   ³
		CallCrys("RESITA",PBT->PBT_NOMARQ,cCRPar)
	Else
		MsgInfo("Somente e possivel imprimir rel. de arquivos com status inserido bd!")
	EndIf

Return	

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±±
±±³Funcao    ³ VerTipReg  ³ Autor ³ Bianchini/Marcela   ³ Data ³ 12.12.08 ³±±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±±
±±³Descricao ³ Verifica se ja existe o codigo de dependencia do           ³±±±
±±³          ³ beneficiario                                               ³±±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function VerTipReg(cMatric,cGrauPa,cTipReg,cTipUsu)

	Local nOrdBA1 := BA1->(IndexOrd())

	If cTipUsu == "T"  //Se for titular
		Return(cTipReg)
	EndIf

	cDepend := PLS260Cha(1,cGrauPa,cTipReg,cTipUsu,cMatric)

Return(cDepend)	

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ PLS260Cha  ³ Autor ³ Michele Tatagiba    ³ Data ³ 19.12.01 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Chama a funcao PLSTIPREG no gatilho dos campos BA1_GRAUPA e|±±
±±³          ³ BA1_TIPUSU                                                 ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function PLS260Cha(cTipo,cGrauPa,cTipReg,cTipUsu,cMatric)

	Local cRet
	Local aArea := GetArea()

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Tipo = 1 -> Retorna o TipoReg do usuario                                             |
	//³ Tipo = 2 -> Retorna True caso o Tipreg retorne correto                               |
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	cRet := Eval( {|aEl| aEl[1]}, PLSTipReg(cGrauPa,cTipReg,cTipUsu,cMatric, .T.))
	RestArea(aArea)

Return(cRet)	

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ PLSTipReg  ³ Autor ³ Bianchini/Marcela   ³ Data ³ 12.12.08 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Calcula o proximo tipo de registro de cada usuario .       |±±
±±³          ³ Utilizado no gatilho do campo BA1_GRAUPA e BA1_TIPUSU      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Alteracoes desde sua construcao inicial.                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Data     ³ BOPS ³ Programador ³ Breve Descricao                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function PLSTipReg(cGrauPa,cTipReg,cTipUsu,cMatric, lConsiste)

	Local aArea := GetArea()
	Local cSeqIni 	:= "00"
	Local cSeqFim 	:= "00"
	Local cSeq    	:= cTipReg
	Local lRet    	:= .T.
	Local lExitFor	:= .F.
	Local nInd    	:= 1
	Local aRetTpUsr := {}
	Local cSql := ""

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Parametro que indica qual o modelo a ser utilizado pela Instituicao de saude  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	Local cModelo := GetMv("MV_PLTITCD")

	If cTipReg == "00"
		RestArea(aArea)
		Return({cSeq,lRet})
	EndIf

	cSql := "SELECT BA1_TIPREG "
	cSql += " FROM  "+RetSqlName("BA1")+" BA1 "
	cSql += " WHERE BA1_FILIAL = '  '"
	cSql += " AND BA1_CODINT||BA1_CODEMP||BA1_MATRIC = '"+ cMatric + "' "
	cSql += " AND D_E_L_E_T_ = ' ' "

	PlsQuery(cSql,"BA1TRB")
	BA1TRB->(dbGoTop())

	While !BA1TRB->(EOF())
		aAdd(aRetTpUsr,{BA1TRB->(BA1_TIPREG)})
		BA1TRB->(DbSkip())
	EndDo
	BA1TRB->(DbCloseArea())

	nPos := Ascan(aRetTpUsr,{ |x| x[1] == cSeq })
	If nPos == 0
		RestArea(aArea)
		Return({cSeq,lRet})
	EndIf

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifico se o grau de parentesco pesquisado, possui sequencia inicial e final ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If Empty(cGrauPa)
		RestArea(aArea)
		Return({cSeq,lRet})
	EndIf

	BT2->(DBSetOrder(1))
	lRet := BT2->(MsSeek(xFilial("BT2")+cGrauPa))

	If lRet
		cSeqIni := BT2->BT2_SEQDE
		cSeqFim := BT2->BT2_SEQATE
		cSeq    := cSeqIni

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Pesquiso no aCols do usuario, algum usuario com o grau de parentesco que estou pesquisando³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

		//		cSeq := StrZero((Val(cSeq)+1),2)
		While .T.
			nPos := Ascan(aRetTpUsr,{ |x| x[1] == cSeq })
			If nPos == 0
				lExitFor := .T.
				Exit
			Else
				cSeq := StrZero((Val(cSeq)+1),2)
			EndIf
		Enddo
	EndIf

	RestArea(aArea)

Return({cSeq,lRet})


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ EstBM1     ³ Autor ³ Bianchini/Marcela   ³ Data ³ 12.12.08 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Estorna a cobranca de mensalidades com vencimentos apos a  ³±±
±±³          ³ data da exclusao                                           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Alteracoes desde sua construcao inicial.                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Data     ³ BOPS ³ Programador ³ Breve Descricao                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function EstBM1(cMatric,cDepend)

	Local aArea := GetArea()
	Local lRet    	:= .T.
	Local aRetTpUsr := {}
	Local cSql := ""
	Local aNivCob	:= {}
	Local aDadosPar := {}
	Local aDadosUsr := {}
	Local nVlDesc	:= 0
	Local cMatSiga	:= cMatric
	Local lGravou	:= .F.
	Local lRepete	:= .F.

	cAnoFat := SubStr(DtoS(BA1->BA1_DATBLO),1,6)

	cSql := "SELECT BM1.R_E_C_N_O_ RECBM1 "
	cSql += " FROM  "+RetSqlName("BM1")+" BM1 "
	cSql += " WHERE BM1_FILIAL = '  '"
	cSql += " AND BM1_CODINT||BM1_CODEMP||BM1_MATRIC||BM1_TIPREG = '"+ cMatric+cDepend + "' "
	cSql += " AND BM1_ANO||BM1_MES > '"+ cAnoFat + "' "
	cSql += " AND BM1_CODTIP = '101' "
	cSql += " AND D_E_L_E_T_ = ' ' "

	PlsQuery(cSql,"BM1TRB")
	BM1TRB->(dbGoTop())

	Do While !BM1TRB->(Eof())

		BM1->(DbGoTo(BM1TRB->RECBM1))

		//	If DtoS(BA1->BA1_DATBLO) > BM1->(BM1_ANO+BM1_MES)+"01"
		If BM1->(BM1_ANO+BM1_MES)+"01" > DtoS(BA1->BA1_DATBLO)

			cAnoAdi := BM1->BM1_ANO
			cMesAdi := BM1->BM1_MES

			nVlDesc := BM1->BM1_VALOR

			aNivCob := U_RetNivCob(BM1->(BM1_CODINT+BM1_CODEMP+BM1_MATRIC+BM1_TIPREG+BM1_DIGITO))

			If Len(aNivCob) > 0

				aAdd(aDadosPar,{cAnoAdi+cMesAdi,nVlDesc,cMesAdi+"/"+cAnoAdi,GetNewPar("MV_YESTMES","018"),"","","_"+ AllTrim(BA1->BA1_MATEMP)+" - "+BM1->(BM1_CODINT+BM1_CODEMP+BM1_MATRIC+BM1_TIPREG+BM1_DIGITO)+" - LANCTO AUTOMATICO ESTORNO DE MENSALIDADE ITAU"})

				aAdd(aDadosUsr,BM1->BM1_CODINT)
				aAdd(aDadosUsr,BM1->BM1_CODEMP)
				aAdd(aDadosUsr,"")				   //BM1->BM1_MATRIC)
				aAdd(aDadosUsr,BM1->BM1_CONEMP)
				aAdd(aDadosUsr,BM1->BM1_VERCON)
				aAdd(aDadosUsr,BM1->BM1_SUBCON)
				aAdd(aDadosUsr,BM1->BM1_VERSUB)
				aAdd(aDadosUsr,aNivCob[1,1])
				//			aAdd(aDadosUsr,"")               //BM1->(BM1_CODINT+BM1_CODEMP+BM1_MATRIC+BM1_TIPREG+BM1_DIGITO))

				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Valida se ja existe adicional para o usuario, do mesmo tipo para o mes...³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				If BSQ->(MsSeek(xFilial("BSQ")+BM1->(BM1_CODINT+BM1_CODEMP+BM1_CONEMP+BM1_VERCON)+cAnoAdi+cMesAdi))

					While !BSQ->(Eof()) .and. BSQ->(BSQ_CODINT+BSQ_CODEMP+BSQ_CONEMP+BSQ_VERCON+BSQ_ANO+BSQ_MES) == BM1->(BM1_CODINT+BM1_CODEMP+BM1_CONEMP+BM1_VERCON)+cAnoAdi+cMesAdi

						If BSQ->BSQ_MATRIC == BM1->BM1_MATRIC .and. BSQ->BSQ_COBNIV == aNivCob[1,1] .and. BSQ->BSQ_CODLAN == GetNewPar("MV_YESTMES","014")
							lRepete := .T.
						EndIf
						BSQ->(DbSkip())

					Enddo

				EndIf

				If !lRepete

					lGravou := U_GerAdNeg(aDadosPar,aDadosUsr,"")

					If !lGravou
						aAdd(aErro_,{"Não foi possível gerar o adicional para o mês solicitado! Usuário: "+cMatSiga})
					Else
						aAdd(aOk,{BA1->BA1_CODINT+"."+BA1->BA1_CODEMP+"."+BA1->BA1_MATRIC+"."+BA1->BA1_TIPREG+"-"+BA1->BA1_DIGITO,Substr(BA1->BA1_NOMUSR,1,30),Transform(nVlDesc,"@E 999,999,999.99")})
					EndIf
				Else
					aAdd(aErro_,{"Já existe adicional gravado nestes parâmetros no mês solicitado! Usuário: "+cMatSiga})
				EndIf
			Else
				aAdd(aErro_,{"Não foi encontrado nível de cobrança para o usuário "+cMatSiga})
			EndIf
		EndIf
		BM1TRB->(DbSkip())
	EndDo

	DbSelectArea("BM1TRB")
	BM1TRB->(DbCloseArea())

	RestArea(aArea)

Return()	

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ CAB336REL   ³ Autor ³ Bianchini/Marcela ³ Data ³ 12.12.2008 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Relatorio de conferencia dos dados do arquivo              ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function CAB336REL(cAlias,nReg,nOpc)

	Local oDlg
	Local nOpca   := 0
	Local oEnc
	Local bOK     := { || nOpca := 1, oDlg:End() }
	Local bCancel := { || oDlg:End() }
	Local cSeq := PBT->PBT_SEQUEN
	Local cSQL, lDeleta

	Private nQtdLin     := 60
	Private nLimite     := 220  //132
	Private cTamanho    := "G"  //"M"
	Private cTitulo     := "Relatorio por Classe da Rede de Atendimento"
	Private cDesc1      := "Emitir a Quantidade de Rede de Atendimento por Classe."
	Private cDesc2      := ""
	Private cDesc3      := ""
	Private cAlias      := "BAU"
	Private cPerg       := "CABR17"
	Private cRel        := "CABR017"
	Private nli         := 61
	Private m_pag       := 1
	Private lCompres    := .T.   //.F.  // Habilita/Desabilita o Formato Comprimido/Expandido
	Private lDicion     := .F.
	Private lFiltro     := .T.
	Private lCrystal    := .F.
	//Private aOrderns    := {}
	Private aOrdens     := {"Classe da RDA + Especialidade","Especialidade + UF + Cidade","UF + Especialidade","Cidade + Regiao"}
	Private nTipo		  := 15
	Private aReturn := { "Zebrado", 1,"Administracao", 1, 1, 1, "",1 }

	Private lAbortPrint := .F.
	Private cCabec1     := "Classe                                          Especialidade                             UF Cidade            Regiao                         CEP       Bairro                         Total"
	Private cCabec2     := ""
	Private nColuna     := 01
	Private aLinha      := {}

	Private cCodRedDe  := mv_par01 // Codigo da Rede de atendimento de
	Private cCodRedAte := mv_par02 // Codigo da Rede de atendimento ate
	Private cCodEspDe  := mv_par03 //
	Private cCodEspAte := mv_par04 //
	Private cDistribuido := MV_PAR16
	Private nAtivo     := mv_par03 // Somente ativos (Sim;Nao;Ambos)

	If ! PLSRelTop()
		Return
	EndIf

	AjustaSX1(cPerg)
	Pergunte(cPerg,.F.)

	cRel  := SetPrint(cAlias,cRel,cPerg,@cTitulo,cDesc1,cDesc2,cDesc3,lDicion,aOrdens,lCompres,cTamanho,{},lFiltro,lCrystal)

	If  nLastKey == 27
		Set Filter To
		Return
	End

	cCodClaDe    := Mv_Par01
	cCodClaAte   := Mv_Par02
	cCodRdaDe    := mv_par03 // Codigo da Rede de atendimento de
	cCodRdaAte   := mv_par04 // Codigo da Rede de atendimento ate
	cCodEspDe    := mv_par05
	cCodEspAte   := mv_par06
	cCodUFDe     := Mv_Par07
	cCodUFAte    := Mv_Par08
	cCodCEPDe    := Mv_Par09
	cCodCEPAte   := Mv_Par10
	cCodMunDe    := Mv_Par11
	cCodMunAte   := Mv_Par12
	cCodRegDe    := Mv_Par13
	cCodRegAte   := Mv_Par14
	cSepBairro   := Mv_Par15
	cDistribuido := MV_PAR16
	nAnaSin      := MV_PAR17
	nTipEnd      := MV_PAR18

	nAtivo     	 := mv_par05

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Configura impressora (padrao)                                            ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	SetDefault(aReturn,cAlias)

	If  nLastKey == 27
		Set Filter To
		Return
	End

	nTipo := If(aReturn[4]==1,15,18)

	Processa({|| CB007IMP() }, "Processando Informacoes...", "", .T.)

	Set Filter To

	If  aReturn[5] == 1
		Set Printer To
		Commit
		Ourspool(cRel)    // Chamada do Spool de Impressao
	EndIf

	MS_FLUSH()             // Libera fila de relatorios em spool

Return	

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa   ³CBR336Imp³ Autor ³ Luzio tavaers         ³ Data ³ 07/11/08 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao  ³ Imprime detalhe do relatorio...                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
/*/

Static Function CBR336Imp()

	Local cArqTrab  := CriaTrab(nil,.F.)
	Local cArqTrab1 := CriaTrab(nil,.F.)

	Local cSQL
	Local nOrdem  := aReturn[8]

	Local cBAUName := RetSQLName("BAU")

	Local cCodRed
	Local cCampX3
	Local cCampCb
	Local cContX3
	Local cTypeX3
	Local cArqOrd
	Local cArqSek
	Local cSx3Sek
	Local cCampBx
	Local cResuBx
	Local lAux
	Local cOper  := ""

	Local nTotal   := 0    // recebe o n total de registros
	Local nProc    := 1    // incrementado por unidade de registro
	Local	Npercent := 0
	Local aQtdClaRda := {}

	Local aStruct  := { {"CLARDA", "C", 3, 0}, {"CODESP", "C", 3, 0}, {"BAIRRO", "C", 20, 0}, {"CODMUN", "C", 07, 0}, {"CODUF", "C", 02, 0}, {"REGIAO", "C", 08, 0}, {"CODCEP", "C", 08, 0}, {"QTDPRF", "N", 10, 0} }
	Local cArqTot  := CriaTrab(aStruct, .T.)
	////dbUseArea(,,cArqTot,"TOT",.F.)
	//DBUSEAREA( .T., "TOPCONN", "AC8010", "TMP", .T., .F.)
	DBUSEAREA(.T., __LocalDriver, cArqTot, "TOT", .F., .F.)

	////DBUSEAREA( ,__LocalDriver, cArqTot, "TOT",.F.,.F.)
	IndRegua ( "TOT",cArqTot,"CLARDA+CODESP+CODUF+CODMUN+REGIAO+BAIRRO+CODCEP",,,"Selecionando Registros...")
	//IndRegua ( "TOT",Left(cArqTot,7)+"B","CLARDA+CODUF+CODMUN+REGIAO+CODESP+BAIRRO+CODCEP",,,"Selecionando Registros...")
	//IndRegua ( "TOT",Left(cArqTot,7)+"C","CODUF+CLARDA+CODMUN+REGIAO+CODESP+BAIRRO+CODCEP",,,"Selecionando Registros...")
	//IndRegua ( "TOT",Left(cArqTot,7)+"D","CODUF+CODMUN+CLARDA+REGIAO+CODESP+BAIRRO+CODCEP",,,"Selecionando Registros...")

	//dbSelectArea("TOT")
	//dbClearIndex()
	//dbSetIndex(Left(cArqTot,7)+"A"+OrdBagExt())
	//dbSetIndex(Left(cArqTot,7)+"B"+OrdBagExt())
	//dbSetIndex(Left(cArqTot,7)+"C"+OrdBagExt())
	//dbSetIndex(Left(cArqTot,7)+"D"+OrdBagExt())
	//dbSetOrder(1)

	////ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	////³ Exibe mensagem...                                                        ³
	////ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	//MsProcTxt(PLSTR0001)

	//cDistribuido := 2

	If cDistribuido == 2   //!Empty(cClaRDAAte)  // So considerada a separacao por Classe da Rede de Atendimento
		cCabec1 := "Classe                                            Total"
	EndIf

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Faz filtro no arquivo...                                                 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	cSQL := "SELECT * "
	If !Empty(cCodEspAte) .and. Val(cCodEspAte) > 0 .and. cDistribuido == 2
		cSQL += "FROM "+RetSQLName("BAU")+" BAU, "+RetSQLName("BBF")+" BBF, "+RetSQLName("BID")+" BID "
	Else
		cSQL += "FROM "+RetSQLName("BAU")+" BAU, "+RetSQLName("BID")+" BID "
	EndIf
	cSQL += "WHERE BAU_FILIAL = '"+xFilial("BAU")+"' "
	cSQL += "AND BAU_CODIGO BETWEEN '"+cCodRDADe+"' AND '"+cCodRDAAte+"' "
	cSQL += "AND BAU_TIPPRE BETWEEN '"+cCodClaDe+"' AND '"+cCodClaAte+"' "
	cSQL += "AND BAU.D_E_L_E_T_ = ' ' "
	cSQL += "AND BID_CODMUN = BAU_MUN "
	cSQL += "AND BID.D_E_L_E_T_ = ' ' "

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ De acordo com parametro mv_par03 : bloqueado ou nao                      ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	//If      nAtivo == 1 //ativo
	//	cSQL += " AND BAU_CODBLO = ' ' "
	//ElseIf  nAtivo == 2 //bloqueado
	//	cSQL += " AND BAU_CODBLO <> ' ' "
	//EndIf
	If !Empty(cCodEspAte) .and. Val(cCodEspAte) > 0  .and. cDistribuido == 2
		cSQL += " AND BBF_CODIGO = BAU_CODIGO "
		cSQL += " AND BBF_CODESP BETWEEN '"+cCodEspDe+"' AND '"+cCodEspAte+"' "
	EndIf

	If nTipEnd = 1
		If !Empty(cCodUfAte)
			cSelect2 += "AND BAU_EST BETWEEN '"+cCodUfDe+"' AND '"+cCodUfAte+"' "
		ElseIf !Empty(cCodCEPAte)
			cSelect2 += "AND BAU_CEP BETWEEN '"+cCodCEPDe+"' AND '"+cCodCEPAte+"' "
		ElseIf !Empty(cCodMunAte)
			cSelect2 += "AND BAU_CODMUN BETWEEN '"+cCodMunDe+"' AND '"+cCodMunAte+"' "
			//         ElseIf !Empty(cCodRegAte)
			//				cSelect2 += "BB8_EST BETWEEN '"+cCodRegDe+"' AND '"+cCodRegAte+"' AND "
		ElseIf !Empty(cCodRegAte)   ///.and. !cCodRegAte $ ('zzzz_ZZZZ')
			cSelect2 += "AND BID_YAREA BETWEEN '"+cCodRegDe+"' AND '"+cCodRegAte+"' "
			//         ElseIf !Empty(cCodRegAte)
			//				cSelect2 += "BB8_EST BETWEEN '"+cCodRegDe+"' AND '"+cCodRegAte+"' AND "
		EndIf
	EndIf
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Se houver filtro executa parse para converter expressoes adv para SQL    ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If ! Empty(aReturn[7])
		cSQL += " AND (" + PLSParSQL(aReturn[7])+" ) "
	EndIf

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ De acordo com a ordem....                                                ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	//If      nOrdSel == 1
	//	cSQL += "ORDER BY BAU_TIPPRE, BAU_MUN, BAU_EST, BAU_BAIRRO "
	//ElseIf  nOrdSel == 2
	//	cSQL += "ORDER BY BAU_TIPPRE "
	//EndIf
	cSQL += "ORDER BY BAU_TIPPRE, BAU_MUN, BAU_EST, BAU_BAIRRO "

	//memowrit("C:\CABR017_1.SQL",cSQL)

	PlsQuery(cSQL,cArqTrab)
	(cArqTrab)->(DbGotop())

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Monta regua                                                                        ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	(cArqTrab)->(DBEval( { | | nTotal++ }))
	(cArqTrab)->( DbGotop())
	ProcRegua(nTotal)

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Inicio da impressao dos detalhes...                                      ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	While (cArqTrab)->(! Eof())

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Exibe mensagem...                                                  ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		Npercent := (nProc/nTotal)*100
		IncProc("Processando: " + Transform(Npercent,"@E 9,999.9") + "  % do Total de: "+ Transform(nTotal,"@E 9999999"))
		ProcessMessage()

		nProc++

		//Agrupa por Classe da Rede de Atendimento
		cClaRDA    := (cArqTrab)->BAU_TIPPRE
		cCodUF     := (cArqTrab)->BAU_EST
		cCodMun    := (cArqTrab)->BAU_MUN
		cCodBairro := (cArqTrab)->BAU_BAIRRO

		If TOT->( !DbSeek(cClaRDA))
			//		IncRegua()
			dbSelectArea("TOT")
			TOT->(dbAppend())
			TOT->CLARDA 		:= cClaRDA
			TOT->CODESP 		:= ""
			TOT->BAIRRO    	:= ""
			TOT->CODMUN    	:= ""
			TOT->CODUF   		:= ""
			TOT->REGIAO 		:= ""
			TOT->CODCEP 		:= ""
			TOT->QTDPRF  		+= 1
		Else
			TOT->QTDPRF 		+= 1
		EndIf

		If cDistribuido == 2   //!Empty(cClaRDAAte)  // So considerada a separacao por Classe da Rede de Atendimento
			//		nPosCod  := aScan(aQtdClaRda,{|x|x[1] == cClaRDA})
			//		If nPosCod == 0
			//			aAdd( aQtdClaRDA, {cClaRDA,"","","","","","",1} )
			//		Else
			//			aQtdClaRDA[nPosCod,8] := aQtdClaRDA[nPosCod,8]+1
			//		EndIf

		ElseIf !Empty(cCodEspAte) .or. !Empty(cCodUfAte) .or. !Empty(cCodCEPAte) .or. !Empty(cCodMunAte)
			cSelect1 := "SELECT * FROM "+RetSQLName("BAX")+" BAX "
			If !Empty(cCodUfAte) .or. !Empty(cCodCEPAte) .or. !Empty(cCodMunAte) // .or. !Empty(cCodRegAte)
				cSelect1 := "SELECT BB8_CODMUN, BB8_EST, BB8_CEP, BB8_DATBLO, BB8_BAIRRO, BID_YAREA, BAX.* FROM "+RetSQLName("BAX")+" BAX, "+RetSQLName("BB8")+" BB8, "+RetSQLName("BID")+" BID "
				cSelect2 := "AND BB8_FILIAL = '"+xFilial("BB8")+"' "
				cSelect2 += "AND BB8_CODIGO = BAX_CODIGO "
				cSelect2 += "AND BB8_CODLOC = BAX_CODLOC "
				cSelect2 += "AND BB8_DATBLO = '        ' "
				cSelect2 += "AND BB8.D_E_L_E_T_ = ' ' "
				cSelect2 += "AND BID_CODMUN = BB8_CODMUN "
				cSelect2 += "AND BID.D_E_L_E_T_ = ' ' "
				If !Empty(cCodUfAte)
					cSelect2 += "AND BB8_EST BETWEEN '"+cCodUfDe+"' AND '"+cCodUfAte+"' "
				ElseIf !Empty(cCodCEPAte)
					cSelect2 += "AND BB8_CEP BETWEEN '"+cCodCEPDe+"' AND '"+cCodCEPAte+"' "
				ElseIf !Empty(cCodMunAte)
					cSelect2 += "AND BB8_CODMUN BETWEEN '"+cCodMunDe+"' AND '"+cCodMunAte+"' "
					//         ElseIf !Empty(cCodRegAte)
					//				cSelect2 += "BB8_EST BETWEEN '"+cCodRegDe+"' AND '"+cCodRegAte+"' AND "
				ElseIf !Empty(cCodRegAte)   ///.and. !cCodRegAte $ ('zzzz_ZZZZ')
					cSelect2 += "AND BID_YAREA BETWEEN '"+cCodRegDe+"' AND '"+cCodRegAte+"' "
					//         ElseIf !Empty(cCodRegAte)
					//				cSelect2 += "BB8_EST BETWEEN '"+cCodRegDe+"' AND '"+cCodRegAte+"' AND "
				EndIf
			EndIf
			cSQL := "WHERE BAX_FILIAL = '"+xFilial("BAX")+"' "
			cSQL += "AND BAX_CODIGO = '"+(cArqTrab)->BAU_CODIGO+"' "
			//		cSQL += "AND BAX_CODINT = '"+(cArqTrab)->BAU_CODINT+"' "
			cSQL += "AND BAX_CODESP BETWEEN '"+cCodEspDe+"' AND '"+cCodEspAte+"' "
			//		cSQL += "AND BAX_CODSUB = '"+BFN->BFN_CODSUB+"' "
			cSQL += "AND BAX_DATBLO = '       ' "
			cSQL += "AND BAX.D_E_L_E_T_ = ' ' "

			//		memowrit("C:\CABR017_"+(cArqTrab)->BAU_CODIGO+".SQL",cSelect1+cSQL+cSelect2)
			//		memowrit("C:\CABR017_2.SQL",cSelect1+cSQL+cSelect2)

			PlsQuery(cSelect1+cSQL+cSelect2,"BAXTRB")
			BAXTRB->(DbGotop())

			While !BAXTRB->(Eof())
				/*
				aQtdClaRDA[1] = Codigo da Classe da Rede de Atendimento
				aQtdClaRDA[2] = Codigo da Especialidade
				aQtdClaRDA[3] = Codigo da Bairro
				aQtdClaRDA[4] = Codigo da Municipio
				aQtdClaRDA[5] = Codigo da UF
				aQtdClaRDA[6] = Codigo da Regiao
				aQtdClaRDA[7] = CEP
				aQtdClaRDA[8] = Quantidade de Profissionais
				*/
				cCodEsp    := BAXTRB->BAX_CODESP

				cCodUF     := BAXTRB->BB8_EST
				cCodMun    := BAXTRB->BB8_CODMUN
				cCodBairro := IIf(cSepBairro == 1,BAXTRB->BB8_BAIRRO,"")
				cCodRegiao := IIf(cDistribuido == 1,BAXTRB->BID_YAREA,"")
				cCodCep    := ""  //BAXTRB->BB8_CEP

				//			nPosCod  := aScan(aQtdClaRda,{|x|x[1]+x[2]+x[3]+x[4]+x[5]+x[6]+x[7] == cClaRDA+cCodEsp+cCodBairro+cCodMun+cCodUF+cCodRegiao+cCodCep})

				//			If nPosCod == 0
				//				aAdd( aQtdClaRDA, {cClaRDA,cCodEsp,cCodBairro,cCodMun,cCodUf,cCodRegiao,cCodCep,1} )
				//			Else
				//				aQtdClaRDA[nPosCod,8] := aQtdClaRDA[nPosCod,8]+1
				//			EndIf

				If TOT->( !DbSeek(cClaRDA+cCodEsp))
					//					IncRegua()
					TOT->(dbAppend())
					TOT->CLARDA 		:= cClaRDA
					TOT->CODESP 		:= cCodEsp
					TOT->BAIRRO    	:= ""
					TOT->CODMUN    	:= ""
					TOT->CODUF   		:= ""
					TOT->REGIAO 		:= ""
					TOT->CODCEP 		:= ""
					TOT->QTDPRF  		+= 1
				Else
					TOT->QTDPRF 		+= 1
				EndIf

				If TOT->( !DbSeek(cClaRDA+cCodEsp+cCodUF+cCodMun+cCodRegiao+cCodBairro+cCodCep))
					TOT->(dbAppend())
					TOT->CLARDA 		:= cClaRDA
					TOT->CODESP 		:= cCodEsp
					TOT->BAIRRO    	:= cCodBairro
					TOT->CODMUN    	:= cCodMun
					TOT->CODUF   		:= cCodUF
					TOT->REGIAO 		:= cCodRegiao
					TOT->CODCEP 		:= cCodCEP
					TOT->QTDPRF  		+= 1
				Else
					TOT->QTDPRF 		+= 1
				EndIf

				DbSelectArea("BAXTRB")
				BAXTRB->(DbSkip())
			EndDo

			BAXTRB->(DbCloseArea())
		EndIf

		DbSelectArea(cArqTrab)
		(cArqTrab)->(DbSkip())
	Enddo

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Ordena array aTitulos                                               ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If  nOrdem == 1
		dbSetOrder(1)
		//		aSort(aQtdClaRda,,, { |x,y| x[1]+x[2]+x[5]+x[4]+x[6]+x[7]+x[3] < y[1]+y[2]+y[5]+y[4]+y[6]+y[7]+y[3] })
	ElseIf nOrdem == 2
		dbSetOrder(2)
		//		aSort(aQtdClaRda,,, { |x,y| x[1]+x[2]+x[5]+x[4]+x[6]+x[7]+x[3] < y[1]+y[2]+y[5]+y[4]+y[6]+y[7]+y[3] })
	EndIf

	nTotal   := 0    // recebe o n total de registros
	nProc    := 1    // incrementado por unidade de registro
	npercent := 0

	dbSelectArea("TOT")
	TOT->( DbGotop())

	TOT->(DBEval( { | | nTotal++ }))
	TOT->( DbGotop())
	ProcRegua(nTotal)

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Inicio da impressao dos detalhes...                                      ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	While TOT->(! Eof())

		Npercent := (nProc/nTotal)*100
		IncProc("Fase 2 - Processando: " + Transform(Npercent,"@E 9,999.9") + "  % do Total de: "+ Transform(nTotal,"@E 9999999"))
		ProcessMessage()

		nProc++

		cClaRDA := TOT->CLARDA

		IncProc("Imprimindo...")
		ProcessMessage()

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Verifica se foi abortada a impressao...                            ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If Interrupcao(lAbortPrint)
			nLi ++
			@ nLi, nColuna pSay PLSTR0002
			Exit
		EndIf
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Imprime cabecalho...                                                     ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If nLi > nQtdLin
			nLi := Cabec(cTitulo,cCabec1,cCabec2,cRel,cTamanho,nTipo)
			nLi ++
		EndIf

		@ nLi, 000 pSay cClaRDA+" - "+AllTrim(Posicione("BAG",1,xFilial("BAG")+AllTrim(cClaRDA),"BAG_DESCRI"))
		@ nLi, 050 pSay Transform(TOT->QTDPRF,"@E 999999")   //Total
		nLi ++

		While TOT->(! Eof()) .and. 	TOT->CLARDA == cClaRDA .and. cDsitribuido == 1
			cEspRDA := TOT->CODESP
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Imprime cabecalho...                                                     ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If nLi > nQtdLin
				nLi := Cabec(cTitulo,cCabec1,cCabec2,cRel,cTamanho,nTipo)
				nLi ++
			EndIf

			@ nLi, 005 pSay Posicione("BAQ",1,xFilial("BAQ")+PLSINTPAD()+cEspRDA,"BAQ_DESCRI")  //Especialidade
			@ nLi, 050 pSay Transform(nQtdEspRDA,"@E 999999")   //Total
			nLi ++

			While TOT->(! Eof()) .and. TOT->CLARDA == cClaRDA .and. TOT->ESPRDA == cEspRDA
				cCodUF     := CodUF
				While TOT->(! Eof()) .and. TOT->CLARDA == cClaRDA .and. TOT->ESPRDA == cEspRDA .and. TOT->CODUF == cCodUF
					nQtdUF += 1
					TOT->(DbSkip())
				EndDo
				If nQtdUF > 0
					@ nLi, 010 pSay cCodUF    //Posicione("BAQ",1,xFilial("BAQ")+PLSINTPAD()+cUF,"BAQ_DESCRI")  //UF
					@ nLi, 050 pSay Transform(nQtdUF,"@E 999999")   //Total
				EndIf
			EndDo


			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Imprime Classe...                                                  ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ                              1                                                                                                   2
			//0....+....1....+....2....+....3....+....4....+....5....+....6....+....7....+....8....+....9....+....0....+....1....+....2....+....3....+....4....+....5....+....6....+....7....+....8....+....9....+....0....+....1....+....2
			//Classe                                          Especialidade                             UF Cidade                          Regiao                         CEP       Bairro                         Total
			//CLI - CLINICAS MEDICAS                          CLINICA MEDICA                            RJ RIO DE JANEIRO                  123456789012345678901234567890 01000-000 123456789012345678901234567890 123456
			//Classe                                            Total
			//CLI - CLINICAS MEDICAS                            999999
			//     PEDIATRIA 												 	                                                                                        ....+....1....+....2....+....3....+....4....+....5
			//          RIO DE JANEIRO

			////			@ nLi, 048 pSay Posicione("BAQ",1,xFilial("BAQ")+PLSINTPAD()+AllTrim(aQtdClaRda[n,2]),"BAQ_DESCRI")  //Especialidade
			////			@ nLi, 090 pSay aQtdClaRda[n,5]   //UF
			//			@ nLi, 093 pSay Posicione("BID",1,xFilial("BID")+AllTrim(aQtdClaRda[n,4]),"BID_DESCRI")  //Cidade
			//			@ nLi, 125 pSay aQtdClaRda[n,6]  //Regiao
			//			@ nLi, 156 pSay aQtdClaRda[n,7]  //CEP
			//			@ nLi, 166 pSay aQtdClaRda[n,3]  //Bairro
			//			@ nLi, 197 pSay Transform(aQtdClaRda[n,8],"@E 999999")   //Total
			//			nLi ++
			//		Else
			//			@ nLi, 050 pSay Transform(aQtdClaRda[n,8],"@E 999999")   //Total
			//		nLi ++
		EndDo
	EndDo
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Imprime rodape do relatorio...                                     ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	Roda(0,space(10),cTamanho)

	(cArqTrab)->(DbCloseArea())

	dbSelectArea("TOT")
	dbCloseArea()
	FERASE(cArqTot+GetDBExtension())
	Ferase(cArqTot+OrdBagExt())

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa   ³ BloqUsu ³ Autor ³ Luzio tavaers         ³ Data  ³ 13/01/09 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao  ³ Insere o Historico de Bloqueio do Beneficiario             ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
/*/

Static Function BloqUsu(cMatric,cDepend,cMatAnt,dDatBlo,cMotBlo)

	BCA->(RecLock("BCA",.T.))

	BCA->BCA_FILIAL := xFilial("BCA")
	BCA->BCA_MATRIC := cMatric
	BCA->BCA_TIPREG := cDepend

	If PBU->PBU_OPERSI $("07_08_09_10_06_04")   //PBU->PBU_OPER == "03"

		If (PBU->PBU_OPER == "02" .and. PBU->PBU_OPERSI == "04") // Doc Marcela Alteração do tipo de Usuário
			BCA->BCA_DATA := CtoD(PBU->PBU_DTINCO)-1
		ElseIf PBU->PBU_OPER == "03"
			BCA->BCA_DATA := dDatBlo
		Else
			BCA->BCA_DATA := iif(PBU->PBU_OPER $ "04_05",CtoD(PBU->PBU_DTINPD)-1,CtoD(PBU->PBU_DTINCT)-1)
		EndIf
		BCA->BCA_TIPO   := "0"
		BCA->BCA_MOTBLO := cMotBlo
		BCA->BCA_OBS    := "Bloqueado pela Importacao, arquivo:"+ cPath + PBT->PBT_NOMARQ

	ElseIf PBU->PBU_OPERSI $ ("11_03_01")   //PBU->PBU_OPER == "06"

		BCA->BCA_TIPO   := "1"
		BCA->BCA_DATA   := dDataBase
		BCA->BCA_OBS    := "Desbloqueado pela Importacao, arquivo:"+ cPath + PBT->PBT_NOMARQ

	EndIf

	BCA->BCA_MATANT := cMatAnt
	BCA->BCA_BLOFAT := "1"
	BCA->BCA_NIVBLQ := "U"
	BCA->BCA_USUOPE := cUserName

	BCA->(MsUnlock())

Return()


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa   ³ BloqFam  ³ Autor ³ Luzio tavaers         ³ Data  ³ 13/01/09 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao  ³ Insere o Historico de Bloqueio da Familia                  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
/*/

Static Function BloqFam(cMatric,cMatAnt,dDatBlo,cMotBlo,cMatEmp)

	BC3->(Reclock("BC3",.T.))

	BC3->BC3_FILIAL := xFilial("BC3")
	BC3->BC3_MATRIC := cMatric
	BC3->BC3_TIPO   := "0"
	BC3->BC3_DATA   := dDatBlo
	BC3->BC3_MOTBLO := cMotBlo
	BC3->BC3_OBS    := "Historico de transferencia"
	BC3->BC3_MATANT := cMatAnt
	BC3->BC3_BLOFAT := "1"
	BC3->BC3_NIVBLQ := "F"
	BC3->BC3_USUOPE := cUserName

	BC3->(MsUnlock())

Return()	

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³EMAIL     ºAutor  ³Bianchini/Marcela   º Data ³  28/02/09   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Envia email de notificação ao responsável quando o arquivo º±±
±±º          ³ de retorno do Itau eh gerado                               º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ MICROSIGA                                                  º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function enviaemail(cNomArq,nQtdReg,nQtdErros)

	Local lRet       := .F.
	Local cMsg       := ""
	Local cEmail 	  := ""
	Local cEmailCoor := ""
	Local lCoSemMail := .F.		// Indica se as pessoas estão sem e-mail
	Local cAttach    := ""
	Local cProcNam := "GERA_HELPDESK_ITAU"

	Local cAssunto := "Movimento Itau " + cNomArq + " - Data " + DtoC(dDataBase)

	aResult := {}
	aResult := TCSPExec("GERA_HELPDESK_ITAU",cNomArq)

	If !Empty(aResult)
		lRet := .T.
	EndIf

Return( lRet )	

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±±
±±³Funcao    ³ VerEmp     ³ Autor ³ Bianchini/Marcela   ³ Data ³ 10.02.10 ³±±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±±
±±³Descricao ³ Verifica a existencia do beneficiario no BA1 atraves da    ³±±±
±±³          ³ Matricula Funcional+Dependencia Itau                       ³±±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function VerEmp(cCodEmp)

	Local lRet    := .T.
	Local cSql := Space(0)

	cSql := "SELECT BQC_ANTCON "
	cSql += " FROM "+RetSqlName("BQC")+" BQC "
	cSql += " WHERE BQC_FILIAL = '"+xFilial("BQC")+"' "
	cSql += " AND BQC.d_e_l_e_t_ = ' ' "
	cSql += " AND BQC_YCDCON = '" + AllTrim(PBU->PBU_CONTR)+"' "
	cSql += " AND BQC_ANTCON = '" + AllTrim(PBU->PBU_CODEMP)+"' "

	PlsQuery(cSql,"TMPBQC")

	TmpBQC->(DbGoTop())

	If TmpBQC->(Eof())
		lRet := .F.
	EndIf

	TmpBQC->(DbCloseArea())

Return(lRet)	

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±±
±±³Funcao    ³ VerProd    ³ Autor ³ Bianchini/Marcela   ³ Data ³ 10.02.10 ³±±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±±
±±³Descricao ³ Verifica a parametrizacao dos produtos da CAERJ            ³±±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function VerProd()

	Local lRet    := .F.
	Local cQuery := Space(0)

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Inicio do Embedded SQL                                                  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	cQuery := "BT0.BT0_YCDEDI = '"+AllTrim(PBU->PBU_PADRAO)+"' AND "
	cQuery += "BT0.BT0_YTPUSR = '"+AllTrim(PBU->PBU_CDBENE)+"' AND "
	cQuery += "BQC.BQC_YCDCON = '"+AllTrim(PBU->PBU_CONTR)+"' AND "
	cQuery += "BQC.BQC_ANTCON = '"+AllTrim(PBU->PBU_CODEMP)+"' "
	cQuery := "%" + cQuery + "%"

	BeginSql Alias "TMPBT0"

	%noparser%

	SELECT DISTINCT BT0_CODIGO, BT0_CODPRO, BT0_VERSAO, BT0_NUMCON, BT0_VERCON, BT0_SUBCON, BT0_VERSUB, BT0_TIPUSR
	FROM %table:BT0% BT0,%table:BQC% BQC
	WHERE BT0.BT0_FILIAL = %xfilial:BT0% AND //Leonardo Portella - 07/12/11 - Filial da BT0 ao inves da BTO
	BQC.BQC_FILIAL = %xfilial:BTQ% AND
	BT0.%NotDel% AND
	BQC.%NotDel% AND

	BQC.BQC_CODIGO = BT0_CODIGO AND
	BQC.BQC_NUMCON = BT0_NUMCON AND
	BQC.BQC_VERCON = BT0_VERCON AND
	BQC.BQC_SUBCON = BT0_SUBCON AND
	BQC.BQC_VERSUB = BT0_VERSUB AND

	%exp:cQuery%

	EndSql

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Abertura do arquivo de trabalho                              |
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	dbSelectArea( "TMPBT0" )

	TMPBT0->(DbGoTop())

	If !TMPBT0->(EOF())
		lRet := .T.
	EndIf

	TmpBT0->(DbCloseArea())

Return(lRet)	

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±±
±±³Funcao    ³ ChkFunc    ³ Autor ³ Bianchini/Marcela   ³ Data ³ 16.05.06 ³±±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±±
±±³Descricao ³ Verifica a existencia da matricula funcional no cadastro de³±±±
±±³          ³ de usuario                                                 ³±±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function ChkFunc(cContrato,cMatric,cDepend)

	Local lRet := .F.
	Local cSql := Space(0)

	cSql := "SELECT BA1_MATRIC "
	cSql += " FROM "+RetSqlName("BA1")+" BA1, "+RetSqlName("BQC")+" BQC "
	cSql += " WHERE BA1_FILIAL = '"+xFilial("BA1")+"' "
	cSql += " AND BQC_FILIAL = '"+xFilial("BQC")+"' "
	cSql += " AND BQC.d_e_l_e_t_ = ' ' "
	cSql += " AND BA1.d_e_l_e_t_ = ' ' "
	cSql += " AND BQC.BQC_CODINT = BA1.BA1_CODINT "
	cSql += " AND BQC.BQC_CODEMP = BA1.BA1_CODEMP "
	cSql += " AND BQC.BQC_NUMCON = BA1.BA1_CONEMP "
	cSql += " AND BQC.BQC_VERCON = BA1.BA1_VERCON "
	cSql += " AND BQC.BQC_SUBCON = BA1.BA1_SUBCON "
	cSql += " AND BQC.BQC_VERSUB = BA1.BA1_VERSUB "
	cSql += " AND BQC.BQC_YCDCON = '" + AllTrim(cContrato)+"' "   //in ('01115','01123') "
	cSql += " AND BA1.BA1_MATEMP = '" + AllTrim(cMatric)+AllTrim(cDepend)+"' "
	cSql += " AND BA1.BA1_DATBLO = ' ' "

	PlsQuery(cSql,"TMPBA1")

	TmpBA1->(DbGoTop())

	If !TmpBA1->(Eof())
		lRet := .T.
	EndIf

	TmpBA1->(DbCloseArea())

Return(lRet)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±±
±±³Funcao    ³ ProMatemp  ³ Autor ³ Bianchini/Marcela   ³ Data ³ 16.05.06 ³±±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±±
±±³Descricao ³ Verifica a existencia da matricula funcional no cadastro de³±±±
±±³          ³ de usuario                                                 ³±±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function ProMatEmp(cCodOpe, cCodEmp, cMatric, cDepend)

	Local lRet := .T.
	Local cSql := Space(0)
	Local nRecnoBA1 := 0

	cSql := "SELECT BA1_CODINT, BA1_CODEMP, BA1_MATRIC, BA1_TIPREG, BA1_TIPUSU, BA1.R_E_C_N_O_ AS BA1RECNO, "
	cSql += " BA1_CONEMP, BA1_VERCON, BA1_SUBCON, BA1_VERSUB, BA1_DATBLO, BA1_MATEMP "
	cSql += " FROM "+RetSqlName("BA1")+" BA1, "+RetSqlName("BQC")+" BQC "
	cSql += " WHERE BA1_FILIAL = '"+xFilial("BA1")+"' "
	cSql += " AND BQC_FILIAL = '"+xFilial("BQC")+"' "
	cSql += " AND BQC.d_e_l_e_t_ = ' ' "
	cSql += " AND BA1.d_e_l_e_t_ = ' ' "
	cSql += " AND BQC.BQC_CODINT = BA1.BA1_CODINT "
	cSql += " AND BQC.BQC_CODEMP = BA1.BA1_CODEMP "
	cSql += " AND BQC.BQC_NUMCON = BA1.BA1_CONEMP "
	cSql += " AND BQC.BQC_VERCON = BA1.BA1_VERCON "
	cSql += " AND BQC.BQC_SUBCON = BA1.BA1_SUBCON "
	cSql += " AND BQC.BQC_VERSUB = BA1.BA1_VERSUB "
	cSql += " AND BQC.BQC_YCDCON = '" + AllTrim(PBU->PBU_CONTR) +"' "
	cSql += " AND BA1.BA1_CODINT = '" + AllTrim(cCodOpe) +"' "
	cSql += " AND BA1.BA1_CODEMP = '" + AllTrim(cCodEmp) +"' "
	cSql += " AND BA1.BA1_MATEMP = '" + AllTrim(cMatric) + AllTrim(cDepend)+"' "
	cSql += " ORDER BY BA1_MATEMP, BA1_CODINT, BA1_CODEMP, BA1_MATRIC, BA1_TIPREG, BA1.R_E_C_N_O_ "

	PlsQuery(cSql,"TMPBA1")

	TmpBA1->(DbGoTop())

	If !TmpBA1->(Eof())   //O Arquivo nao esta vaio, portanto encontrou a Matricula e retorna o recno do registro no BA1
		While !TmpBA1->(Eof())
			nRecnoBA1 := TmpBA1->BA1RECNO
			TmpBA1->(DbSkip())
		Enddo
	EndIf

	TmpBA1->(DbCloseArea())

Return(nRecnoBA1)

//	**'Marcela Coimbra'**

Static Function PonteraBA3( c_CodEmp, c_MatEmp )

	Local c_Qry := ""
	Local l_Ret := .F.

	c_Qry += " SELECT R_E_C_N_O_ REC "
	c_Qry += " FROM " + RETSQLNAME("BA3") + " BA3 "
	c_Qry += " WHERE 		BA3_FILIAL = '" + xFilial("BA3") +  "' "
	c_Qry += " 			AND BA3_CODINT = '0001' "
	c_Qry += " 			AND BA3_CODEMP = '" + c_CodEmp + "' "
	c_Qry += " 			AND BA3_MATEMP = '" + c_MatEmp + "' "
	c_Qry += " 			AND BA3_DATBLO = ' ' "
	c_Qry += " 			AND D_E_L_E_T_ = ' ' "

	PlsQuery( c_Qry, "VERBA3" )

	If !VERBA3->( EOF() )

		dbSelectArea("BA3")
		dbGoTo( VERBA3->REC )

		l_Ret := .T.

	EndIf

	VERBA3->( dbCloseArea() )

Return l_Ret


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±±
±±³Funcao    ³ ChkPBUQtdCPF ³ Autor ³ Fabio Bianchini   ³ Data ³ 17.05.06 ³±±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±±
±±³Descricao ³ Checa em PBU se exist emais de uma ocorrencia do mesmo CPF ³±±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function ChkPBUQtdCPF(cOper,cSequen,cCPF,cOpcao,cCodEmp)

	Local lRet := .F.

	/*******************************************************************************/
	/***	cOper : 1 - Inclusao / 2 - Alteração / 3 - Exclusao					 ***/
	/***	cSequen: Sequencial de Importação									 ***/
	/***	cCPF: CPF do Usuário												 ***/
	/***	cOpcao: 01 - Testa na BA1 / 02 - Testa na VIDA / 03 - Testa na PBU	 ***/
	/*******************************************************************************/
	If cOpcao == '01'

		cSql := "SELECT COUNT(*) QTD "
		cSql += " FROM "+RetSqlName("BA1")+" BA1 "
		cSql += "    , "+RetSqlName("BTS")+" BTS "
		cSql += " WHERE BA1_FILIAL = '" + xFilial("BA1") + "'"
		cSql += " AND BTS_FILIAL = '" + xFilial("BTS") + "'"
		cSql += " AND BA1_MATVID = BTS_MATVID "
		cSql += " AND BA1_CPFUSR = BTS_CPFUSR "
		cSql += " AND BA1_DATBLO = ' ' "
		cSql += " AND BA1_CPFUSR = '" + cCPF + "'"
		cSql += " AND BA1_CODEMP = '" + cCodEmp + "' "
		cSql += " AND BA1.D_E_L_E_T_ = ' ' "
		cSql += " AND BTS.D_E_L_E_T_ = ' ' "

		PlsQuery(cSql,"TMPBA1BTS")

		//If (!Empty(TMPBA1BTS->QTD)) .or. (TMPBA1BTS->QTD > 1)
		If ( TMPBA1BTS->QTD > 2 )//Saude e Odonto
			lRet := .T.
		EndIf

		TMPBA1BTS->(DbCloseArea())

	EndIf

	If cOpcao == '03'

		cSql := "SELECT COUNT(*) QTD "
		cSql += " FROM "+RetSqlName("PBU")+" PBU "
		cSql += " WHERE PBU_FILIAL = '"+xFilial("PBU")+"'"
		cSql += " and length(trim(PBU_DTNASC)) = 10 "
		cSql += " and PBU_oper = '"+cOper+"'"
		cSql += " and PBU_sequen = '"+cSequen+"'"
		cSql += " and PBU_cpf = '"+cCPF+"'"
		cSql += " and idade_s(to_char(to_date(PBU_dtnasc,'dd/mm/yyyy'),'yyyymmdd')) >= 18 "
		cSql += " AND D_E_L_E_T_ = ' ' "

		PlsQuery(cSql,"TMPPBU")

		If TMPPBU->QTD > 1
			lRet := .T.
		EndIf

		TMPPBU->(DbCloseArea())

	EndIf

Return(lRet)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±±
±±³Funcao    ³ ExeBA1PBU  ³ Autor ³ Fabio Bianchini     ³ Data ³ 01.12.08 ³±±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±±
±±³Descricao ³ Verifica a existencia do Titular no BA1 atraves da    	  ³±±±
±±³          ³ Matricula Funcional e no proprio PBU			              ³±±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function ExeBA1PBU(cMatric,cTipUsu,cOper,cSequen)

	Local nOrdBA1 := BA1->(IndexOrd())
	Local lRet    := .F.

	If cTipUsu == 'T'
		lRet := .T.
	Else
		BA1->(dbSetOrder(6))
		If  BA1->(DbSeek(xFilial("BA1")+cMatric))
			While !EOF() .and. BA1->BA1_MATEMP == cMATRIC
				If (Empty(BA1->BA1_DATBLO) .or. Empty(BA1->BA1_MOTBLO)) .and. BA1->BA1_TIPUSU == 'T'
					If (cEmpAnt == '01' .and. !(BA1->BA1_CODEMP $ '0004|0009')) .or. cEmpAnt == '02'
						lRet := .T.
					EndIf
				EndIf
				BA1->(DbSkip())
			Enddo
		Else  //Se nao tem no BA1 TITULAR ATIVO, procuro ao menos no PBU o titular
			cSql := "SELECT COUNT(*) QTD "
			cSql += " FROM "+RetSqlName("PBU")+" PBU "
			cSql += " WHERE PBU_FILIAL = '"+xFilial("PBU")+"'"
			cSql += " and PBU_oper   = '"+cOper+"'"
			cSql += " and PBU_sequen = '"+cSequen+"'"
			cSql += " and PBU_func   = '"+cMatric+"'"
			cSql += " and PBU_CDBENE = '"+cTipUsu+"'"
			cSql += " AND D_E_L_E_T_ = ' ' "

			PlsQuery(cSql,"TMPPBUx")
			//Se tem um titular ao menos dentro do arquivo
			If TMPPBUx->QTD > 0
				lRet := .T.
			EndIf

			TMPPBUx->(DbCloseArea())
		EndIf
		BA1->(dbSetOrder(nOrdBA1))
	EndIf

Return(lRet)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±±
±±³Funcao    ³ chkCriTit  ³ Autor ³ Fabio Bianchini     ³ Data ³ 01.12.08 ³±±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±±
±±³Descricao ³ Verifica a existencia de criticas do beneficiario titular  ³±±±
±±³          ³ dentro do array aErro								      ³±±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function chkCriTit(cOper,cSequen,cMatric, cTipUsu)

	Local lRet    := .F.

	If cTipUsu == 'T'
		lRet := .F.
	Else
		//Se tem critica que não seja por funcional ja existente(065), pois preciso deixar o dependente entrar caso exista titular.
		cSql := " Select count(*) QTD "
		cSql += " from "+RetSqlName("PBU")+" PBU, " +RetSqlName("PBV")+" PBV "
		cSql += " where PBU_filial = '"+xFilial("PBU")+"'"
		cSql += " and PBV_filial = '"+xFilial("PBV")+"'"
		cSql += " and PBU_sequen = PBV_sequen
		cSql += " and PBU_numlin = PBV_numlin
		cSql += " and PBU_oper = '"+cOper+"'"
		cSql += " and PBU_sequen = '"+cSequen+"'"
		cSql += " and PBU_func = '"+cMatric+"'"
		cSql += " and PBU_CDBENE = '"+cTipUsu+"'"
		cSql += " and PBV_coderr not in ('065','066','067','068') "
		cSql += " and PBU.d_e_l_e_t_ = ' '
		cSql += " and PBV.d_e_l_e_t_ = ' '

		PlsQuery(cSql,"TMPCRI")

		If TMPCRI->QTD > 0
			lRet := .T.
		EndIf

		TMPCRI->(DbCloseArea())
	EndIf

Return(lRet)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±±
±±³Funcao    ³ chkLogradouro  ³ Autor ³ Fabio Bianchini     ³ Data ³ 21.05.15 ³±±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±±
±±³Descricao ³ Verifica se o Logradouro esta preenchido					  	  ³±±±
±±³          ³ 														      	  ³±±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function chkLogradouro(cLogradouro,cNumeroLog,cDepend)

	//O PARAMETRO cDEPEND passa quem eu olharei como referencia do endereco.
	//Ex.: Se quero confrontar o endereco do dependente com o do titular passo T para que eu olhe para o titular.
	Local lRet    := .T.

	If AllTrim(PBU->PBU_CDBENE) == 'T'  //Se for titular
		If Empty(cLogradouro) .OR. Empty(cNumeroLog) .or. val(cNumeroLog) == 0  //Se endereco ou numero do endereco estiver vazio
			lRet := .F.
		EndIf
	Else  //Se for Dependente
		//Se a query abaixo retornar
		cSql := " Select count(*) QTD "
		cSql += " from "+RetSqlName("PBU")+" PBU, " +RetSqlName("PBV")+" PBV "
		cSql += " where PBU_filial = '"+xFilial("PBU")+"'"
		cSql += " and PBV_filial = '"+xFilial("PBV")+"'"
		cSql += " and PBU_sequen = PBV_sequen "
		cSql += " and PBU_numlin = PBV_numlin "
		cSql += " and PBU_oper   = '"+PBU->PBU_OPER  +"'"
		cSql += " and PBU_sequen = '"+PBU->PBU_SEQUEN+"'"
		cSql += " and PBU_func   = '"+PBU->PBU_FUNC  +"'"
		cSql += " and PBU_CDBENE = '"+cDepend+"'"
		cSql += " and PBV_coderr in ('038') "
		cSql += " and PBU.d_e_l_e_t_ = ' ' "
		cSql += " and PBV.d_e_l_e_t_ = ' ' "

		PlsQuery(cSql,"TMPCRI")

		If TMPCRI->QTD > 0 //Titular criticado com Endereco Invalido
			lRet := .F.
		EndIf

		TMPCRI->(DbCloseArea())

	EndIf

Return(lRet)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±±
±±³Funcao    ³ chkSubOdonto   ³ Autor ³ Fabio Bianchini     ³ Data ³ 22.05.15 ³±±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±±
±±³Descricao ³ VERIFICA SE O SUB ESCOLHIDO EH ODONTO OU NAO. IMPORTANTE PARA  ³±±±
±±³          ³ PREFEITURA QUE POSSUI SUBCONTRATOS CASADOS(1 MEDICO E 1 ODONTO)³±±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function chkSubOdonto

	Local cRet := ''

	cFilial := xFilial("PBT")

	cCodemp := PBT->PBT_CODEMP
	cNumCon := PBT->PBT_NUMCON
	cSubCon := PBT->PBT_SUBCON

	cSql := " SELECT BQC_YSUBOD, BQC_YODONT, BQC_DATBLO "
	cSql += "   FROM "+RetSqlName("BQC")+" BQC "
	cSql += "  WHERE BQC_FILIAL = '"+xFilial("PBT")+"'"
	cSql += "    AND BQC_CODEMP = '"+cCodemp+"'"
	cSql += "    AND BQC_NUMCON = '"+cNumCon+"'
	cSql += "    AND BQC_VERCON = '001'"
	cSql += "    AND BQC_SUBCON = '"+cSubCon+"'"
	cSql += "    AND BQC_VERSUB = '001'"
	cSql += "    AND D_E_L_E_T_ = ' '"

	PlsQuery(cSql,"TMPBQC")

	If !TMPBQC->(EOF())
		If !Empty(TMPBQC->BQC_DATBLO)
			Alert("Subcontrato BLOQUEADO!!! Importacao CANCELADA!!!")
			TMPBQC->(DbCloseArea())
			Return
		EndIf

		If TMPBQC->BQC_YODONT == '1' //Verifica se contrato eh odontologico
			Alert("Este SubContrato é Odontológico e NÃO pode ser carregado desta Forma!!!")
			Alert("Favor Importar o Subcontrato Médico primeiro. O Odonto será Processado automaticamente!!!")
			TMPBQC->(DbCloseArea())
			Return
		ElseIf !Empty(TMPBQC->BQC_YSUBOD) .OR. TMPBQC->BQC_YODONT == '0' //Caso nao seja odontologico
			cRet := TMPBQC->BQC_YSUBOD //Atribui Subcontrato Odontologico
			//Else
			//	Alert("AVISO!! Não haverá inclusão de Contrato Odontologico. Sem vinculo no Subcontrato!!!") //Aviso padrao para todos os subcontratos normais
		EndIf
	EndIf

	TMPBQC->(DbCloseArea())

Return cRet

User Function AcertaOpc()

	Local n_Count := 0
	Local c_Qry := ""

	c_Qry += " select BYX_CODOPE, BYX_codemp, BYX_matric, BYX_tipreg, count(*) qtd "
	c_Qry += " from BYX010    "
	c_Qry += " where BYX_codemp = '0024'  "
	c_Qry += " and d_e_l_e_t_ = ' '"
	c_Qry += " group by BYX_CODOPE, BYX_codemp, BYX_matric, BYX_tipreg  "
	c_Qry += " having count(*) > 1"

	c_Qry += " order by 1,2,3, 4 "

	TCQUERY c_Qry ALIAS "TMPBYX" NEW

	While !TMPBYX->( EOF() )

		dbSelectArea("BYX")
		dbSetOrder(1)//BYX_FILIAL+BYX_CODOPE+BYX_CODEMP+BYX_MATRIC+BYX_TIPREG+BYX_CODOPC+BYX_VEROPC+BYX_CODFOR+BYX_CODFAI
		If dbSeek(xFilial("BYX") + TMPBYX->( BYX_CODOPE+BYX_CODEMP+BYX_MATRIC+BYX_TIPREG ) )


			For n_Count := 1 to (TMPBYX->qtd) - 1

				If TMPBYX->(BYX_MATRIC+BYX_TIPREG)  == BYX->(BYX_MATRIC+BYX_TIPREG)
					RecLock("BYX",.F.)
					//	BYX->BYX_ANOMES := '201506'  // Usuario Que Excluiu a NF
					dbdelete()
					Msunlock("BYX")
				EndIf

				BYX->( dbSkip() )

			Next

		EndIf


		TMPBYX->( dbSkip() )

	EndDo

Return

Static Function PosicMatMed( c_CodEmp, c_Conemp, c_Subcon, c_MatEmp )

	Local l_Ret := .F.

	dbSelectArea("BA3")
	BA3->(dbOrderNickName("BA3EMCOSUB"))

	If dbSeek(xFilial("BA3") + c_CodEmp + c_Conemp + "001" + c_Subcon + "001" + substr(c_MatEmp, 1, Len(TRIM(c_MatEmp)) - 2) )
		l_Ret := .T.
	EndIf

	dbSelectArea("BA1")
	BA1->(dbOrderNickName("BA1EMCOSUB"))

	If dbSeek(xFilial("BA1") + c_CodEmp + c_Conemp + "001" + c_Subcon + "001" + c_MatEmp )
		l_Ret := .T.
	EndIf

Return l_Ret

//Leonardo Portella - 09/06/15 - Emergencial - Inclusao na marra de arquivo que deu erro.

User Function XCAB336APP(nRecPBU,nOpcaInc,lMsgFim)
	//nOpcaInc: 1 - Ambos, 2 - Odonto, 3 - Saude

	Local aCampos 	:= {}
	Local nPassou 	:= 0
	Local nLoop		:= 0
	Local lProces		:= .F.
	Local cOperac 	:= ''  //Variavel criada porque ao chegar fim de arquivo na virada do loop não temos referencia ao campo PBU->PBU_OPER

	Local _cSubcon	:= "" //Angelo Henrique - Data: 08/08/2016

	Default lMsgFim	:= .T.

	Private l_Voltou	:= .F.

	DbSelectArea('PBU')
	PBU->(DbGoTo(nRecPBU))

	DbSelectArea('PBT')
	PBT->(DbSetOrder(1))

	If PBT->(DbSeek(xFilial('PBT') + PBU->PBU_SEQUEN ))

		cSubConOdonto := If( PBT->PBT_LAYOUT == '1' , chkSubOdonto() , '' )

		For nLoop := 1 to 2

			If nOpcaInc == 2 .and. !l_Voltou
				l_Voltou := .T.
				nPassou := 1
				Loop
			ElseIf nOpcaInc == 3 .and. l_Voltou
				Exit
			EndIf

			cOperac := AllTrim(PBU->PBU_OPER)

			If PBT->PBT_LAYOUT == '1' .and. !l_Voltou
				//cCodPro := ConvPlano(trim(PBU->PBU_PADRAO),'MED','C')
				cCodPro := ConvPlano(trim(PBU->PBU_PADRAO),Alltrim(PBU->PBU_CDBENE),1)
				/*ElseIf PBT->PBT_LAYOUT == '1' .and. l_Voltou
				cCodPro := ConvPlano(trim(PBU->PBU_PADRAO),'ODO','C')*/
			Else
				cCodPro := PBU->PBU_PADRAO
			EndIf

			//If  ( ( nOpcaInc == 1 .or. nOpcaInc == 3 ) .and. !lUsuExiste(PBU->PBU_FUNC,PBU->PBU_CPF,PBU->PBU_PADRAO,PBU->PBU_CODEMP,'MED', @l_PlaIg, '000000001') ) ;
			If cCodEmp $ "0024|0027"

				_cSubcon := "000000003"

			ElseIf cCodEmp = "0025|0028"

				_cSubcon := "000000005"

			EndIf

			If  ( ( nOpcaInc == 1 .or. nOpcaInc == 3 ) .and. !lUsuExiste(PBU->PBU_FUNC,PBU->PBU_CPF,PBU->PBU_PADRAO,PBU->PBU_CODEMP,'MED', @l_PlaIg, _cSubcon) ) ;
			.or. ;
			( ( nOpcaInc == 1 .or. nOpcaInc == 2 ) .and. !lUsuExiste(PBU->PBU_FUNC,PBU->PBU_CPF,PBU->PBU_PADRAO,PBU->PBU_CODEMP,'ODO', @l_PlaIg, '000000002') )

				//If !empty(ConvPlano(trim(PBU->PBU_PADRAO),'MED','C'))
				If !empty(ConvPlano(trim(PBU->PBU_PADRAO),Alltrim(PBU->PBU_CDBENE),1))
					IncluiUsr(cCodPro)
					lProces := .T.
				EndIf

			EndIf

			//Este trecho fara voltar ao inicio da PBU para incluir o Odontologico.  O arquivo sera lido 2 vezes
			//Fixado somente para inclusao , por enquanto
			If PBT->PBT_LAYOUT == '1' .and. nPassou == 0 .and. cOperac $ "1|0" //.and. ( PBU->(EOF()) .or. PBT->PBT_SEQUEN <> PBU->PBU_SEQUEN )
				PBU->(DbGoTo(nRecPBU))
				l_Voltou := .T.
				nPassou := 1
			ElseIf PBT->PBT_LAYOUT == '1' .and. nPassou == 1 .and. cOperac $ "1|0"
				AjustaMat(BTS->BTS_CPFUSR)  //Fazer De/Para de matriculas Odonto na matricula Medica
			EndIf

		Next

		If lMsgFim
			MsgInfo('Finalizado - ' + If(lProces,'Processado','Nao processou [ var lProces = .F. ]'))
		EndIf

	Else
		MsgStop('PBT nao localizada com base PBU','Verifique...')
	EndIf

Return

User Function AjusOdo(nRecBA1)

	Local cSequen 	:= ''
	Local cCPFUsr	:= ''

	BA1->(DbGoTo(nRecBA1))

	cCPFUsr := BA1->BA1_CPFUSR
	cSequen	:= Substr(BA1->BA1_IMPORT,12,6)

	PBT->(DbSetOrder(1))

	If PBT->(DbSeek(xFilial('PBT') + cSequen ))
		AjustaMat(cCPFUsr)
		MsgInfo('Odonto ajustado!')
	Else
		Alert('Nenhum registro processado...')
	EndIf

Return

User Function IncPBUs

	Processa({||PIncPBUs()},'Incluindo...')

Return

Static Function PIncPBUs

	Local nI		:= 0
	Local aRecsPBU 	:= {;
	43465,304395,193,40953,55403,58312,49227,55173,51937,43755,45688,53280,58760,17855,51412,53279,125361,44507,42329,51951,47101,55636,45285,53627,124906,54046,45696,57675,39424,51636,52455,41034,41035,303411,50356,52128,44903,41895,40715,51950,49278,58073,56599,46769,57083,41921,49263,20188,53638,1393,47821,44033,44678,56546,304085,46814,52942,46248,18777,46360,304360,43500,28797,56263,39417,49330,42822,12328,40762,48824,44026;
	}

	If MsgYesNo(cValToChar(len(aRecsPBU)) + ' recnos! Confirma?')

		ProcRegua(len(aRecsPBU))

		For nI := 1 to len(aRecsPBU)
			IncProc('Processando ' + cValToChar(nI) + ' de ' + cValToChar(len(aRecsPBU)))
			U_XCAB336APP(aRecsPBU[nI],3,.F.)
		Next

	EndIf

	MsgInfo('Processados ' + cValToChar(len(aRecsPBU)) + ' registros')

Return

Static Function lTitPlano(cCPFTit,cSequen,cPadrao,cCodEmp,cTipo)

	Local lExistTit := .T.
	Local aArea		:= GetArea()
	Local aArPBU	:= PBU->(GetArea())
	Local cQry		:= ''
	Local cAlias	:= GetNextAlias()
	//Local cCodPla	:= ConvPlano(AllTrim(cPadrao),cTipo,'C')	
	Local cCodPla	:= ConvPlano(trim(cPadrao),Alltrim(PBU->PBU_CDBENE),1)
	Local cChvPBU	:= ''
		
	//Angelo Henrique - Data:08/08/2016
	//Validação para as coligadas, para o caso do multiplano - 0112 e 0113

	If cCodEmp <> "0024"

		If cPadrao == "0114"

			cCodPla := "0112"
			cPadrao := "0112" //Recebe o código do plano do títular para validar se no arquivo esta com o títular

		ElseIf cPadrao == "0115"

			cCodPla := "0113"
			cPadrao := "0113" //Recebe o código do plano do títular para validar se no arquivo esta com o títular
			
		Else

			cCodPla := trim(cPadrao)
			
		EndIf

	ElseIf cCodEmp = "0024"

		If cCodPla == "0114"

			cCodPla := "0112"

		ElseIf cCodPla == "0115"

			cCodPla := "0113"

		EndIf

	EndIf

	cCPFTit := AllTrim(cCPFTit)

	cQry += "SELECT BA1_MATEMP" 																	+ CRLF
	cQry += "FROM " + RetSqlName('BA1') + " BA1" 													+ CRLF
	cQry += "INNER JOIN " + RetSqlName('BA3') + " BA3 ON BA3_FILIAL = '" + xFilial('BA3') + "'" 	+ CRLF
	cQry += "  AND BA3_CODINT = BA1_CODINT" 														+ CRLF
	cQry += "  AND BA3_CODEMP = BA1_CODEMP" 														+ CRLF
	cQry += "  AND BA3_MATRIC = BA1_MATRIC" 														+ CRLF
	cQry += "  AND BA3_CODPLA = BA1_CODPLA" 														+ CRLF
	cQry += "  AND BA3.D_E_L_E_T_ = ' '" 															+ CRLF
	cQry += "WHERE BA1_FILIAL = '" + xFilial('BA1') + "'" 											+ CRLF
	// Marcela Coimbra em 06/07/2015
	cQry += "  AND TRIM(BA3_MATEMP) = '" + cCPFTit +  "'" 									+ CRLF
	//	cQry += "  AND BA1_MATEMP = '" + cCPFTit + "-" + cCPFTit + "'" 									+ CRLF
	cQry += "  AND BA1_CODINT = '" + PLSINTPAD() + "'" 												+ CRLF
	cQry += "  AND BA1_CODEMP = '" + cCodEmp + "'" 													+ CRLF
	cQry += "  AND BA1_TIPUSU = 'T'" 																+ CRLF
	cQry += "  AND BA1_DATBLO = ' '" 																+ CRLF
	cQry += "  AND BA1_CODPLA = '" + cCodPla + "'" 													+ CRLF
	cQry += "  AND BA1.D_E_L_E_T_ = ' '" 															+ CRLF

	TcQuery cQry New Alias cAlias

	lExistTit := !cAlias->(EOF())

	cAlias->(DbCloseArea())

	If !lExistTit

		cChvPBU := xFilial('PBU') + cSequen + cCPFTit

		PBU->(DbGoTop())
		PBU->(DbSetOrder(6))//PBU_FILIAL, PBU_SEQUEN, PBU_FUNC, PBU_DEPEND

		If PBU->(DbSeek(xFilial('PBU') + cSequen + cCPFTit))

			While !PBU->(EOF()) .and. ( Left(PBU->(PBU_FILIAL + PBU_SEQUEN + PBU_FUNC),len(cChvPBU)) == cChvPBU )

				//O titular esta no arquivo sendo processado
				If ( PBU->PBU_CDBENE == 'T' ) .and. ( PBU->PBU_PADRAO == cPadrao )
					lExistTit := .T.
					Exit
				EndIf

				PBU->(DbSkip())

			EndDo

		EndIf

	EndIf

	PBU->(RestArea(aArPBU))
	RestArea(aArea)

Return lExistTit

Static Function lUsuExiste(cFuncional,cCPF,cPadrao,cCodEmp,cTipo, l_PlaIg, c_Subcon)

	Local lExiste 	:= .F.
	Local aArea		:= GetArea()
	Local cQry			:= ''
	Local cAlias		:= GetNextAlias()
	//Local cCodPla	:= ConvPlano(AllTrim(cPadrao),cTipo,'C')
	Local cCodPla		:= ConvPlano(trim(cPadrao),Alltrim(PBU->PBU_CDBENE),1)
	Local cChvPBU		:= ''
	Local lExistTit 	:= .F.

	l_PlaIg := .F.

	cFuncional 	:= AllTrim(cFuncional)
	cCPF 		:= AllTrim(cCPF)

	cQry += "SELECT BA1_CODPLA" 																	+ CRLF
	//cQry += "SELECT BA1_MATEMP" 																	+ CRLF
	cQry += "FROM " + RetSqlName('BA1') + " BA1" 													+ CRLF

	//---------------------------------------------------------------------------------------------------------
	//Angelo Henrique - Data: 01/08/2016
	//---------------------------------------------------------------------------------------------------------
	//Com a existência dos Multi-Planos no Standard nem sempre é possível realizar o link com
	//a família, pois o plano do dependente é diferente do plano do títular
	//---------------------------------------------------------------------------------------------------------
	If !(cCodPla $ "0114|0115")

		cQry += "INNER JOIN " + RetSqlName('BA3') + " BA3 ON BA3_FILIAL = '" + xFilial('BA3') + "'" 	+ CRLF
		cQry += "  AND BA3_CODINT = BA1_CODINT" 														+ CRLF
		cQry += "  AND BA3_CODEMP = BA1_CODEMP" 														+ CRLF
		cQry += "  AND BA3_MATRIC = BA1_MATRIC" 														+ CRLF
		cQry += "  AND BA3_CODPLA = BA1_CODPLA" 														+ CRLF
		cQry += "  AND BA3.D_E_L_E_T_ = ' '" 															+ CRLF

	EndIf
	cQry += "WHERE BA1_FILIAL = '" + xFilial('BA1') + "'" 											+ CRLF
	//cQry += "  AND TRIM(BA3_MATEMP) = '" + ALLTRIM(cFuncional) + "'" 									+ CRLF
	cQry += "  AND BA1_CPFUSR = '" + cCPF + "'"     	            								+ CRLF
	cQry += "  AND BA1_CODINT = '" + PLSINTPAD() + "'" 												+ CRLF
	cQry += "  AND BA1_CODEMP = '" + cCodEmp + "'" 													+ CRLF
	cQry += "  AND BA1_SUBCON = '" + c_Subcon + "'" 													+ CRLF
	cQry += "  AND BA1_DATBLO = ' '" 																+ CRLF
	//cQry += "  AND BA1_CODPLA = '" + cCodPla + "'" 													+ CRLF
	cQry += "  AND BA1.D_E_L_E_T_ = ' '" 															+ CRLF

	TcQuery cQry New Alias cAlias

	If !cAlias->(EOF())

		l_PlaIg := cAlias->BA1_CODPLA == cCodPla
		lExistTit := .T.

	EndIf

	cAlias->(DbCloseArea())

	RestArea(aArea)

Return lExistTit


//Leonardo Portella - 09/06/15 - Visualiza criticas do arquivo ponteirado

User Function CAB336VCRI

	Local aArea	:= GetArea()
	Local c_Alias	:= GetNextAlias()
	Local cQry		:= ""
	Local aErros	:= {}
	Local aBrowse	:= {}
	Local _aItnRl	:= {}
	local _aArray	:= {}
	Local oBrowse	:= Nil
	Local _lAchou := .F.

	cQry += "SELECT TRIM(PBV_SEQUEN) || '-' || TRIM(PBV_NUMLIN) SEQ_LIN," 											+ CRLF
	cQry += "	TRIM(PBV_SEQERR) || '-' || TRIM(PBV_CODERR) || ' [ ' || TRIM(UPPER(PBV_DESERR)) || ' ]' ERRO," 	+ CRLF
	cQry += "	TRIM(PBU_BENEF) BENEF,TRIM(PBU_CPF) CPF,TRIM(UPPER(PBU_DESOPE)) OPER, TRIM(PBU_BENEF) NOME" 		+ CRLF

	//------------------------------------------------------------------------------------------------------------------
	//Angelo Henrique - Data: 01/03/2016
	//------------------------------------------------------------------------------------------------------------------
	//Acrescentando algumas informações separadas para mudar a forma de visualização dos erros
	//------------------------------------------------------------------------------------------------------------------
	cQry += "	,TRIM(PBV_NUMLIN) LINHA, TRIM(PBV_CODERR) CODERRO, TRIM(UPPER(PBV_DESERR)) DESCERRO " 				+ CRLF
	cQry += "	,TRIM(UPPER(PBU_DESOPE)) DESCOPER " 				+ CRLF
	//------------------------------------------------------------------------------------------------------------------

	cQry += "FROM " + RetSqlName('PBV') + " PBV" 																			+ CRLF
	cQry += "INNER JOIN " + RetSqlName('PBU') + " PBU ON PBU_FILIAL = '" + xFilial('PBU') + "'" 					+ CRLF
	cQry += "  AND PBU_SEQUEN = PBV_SEQUEN" 																				+ CRLF
	cQry += "  AND PBU_NUMLIN = PBV_NUMLIN" 																				+ CRLF
	cQry += "  AND PBU.D_E_L_E_T_ = ' '" 																					+ CRLF
	cQry += "WHERE PBV_FILIAL = '" + xFilial('PBV') + "'" 																+ CRLF
	cQry += "  AND PBV_SEQUEN = '" + PBT->PBT_SEQUEN + "'" 																+ CRLF
	cQry += "  AND PBV.D_E_L_E_T_ = ' '" 																					+ CRLF
	cQry += "ORDER BY 1,2" 	  																								+ CRLF

	TcQuery cQry New Alias c_Alias

	aAdd(_aItnRl,{"LINHA", "NOME", "CPF", "ERRO", "DESCRICAO", "OPERACAO" })

	While !c_Alias->(EOF())

		If aScan(aErros,c_Alias->SEQ_LIN) <= 0
			aAdd(aErros,c_Alias->SEQ_LIN)
		EndIf

		aAdd(aBrowse,{c_Alias->LINHA,  c_Alias->NOME, c_Alias->CPF, c_Alias->CODERRO, c_Alias->DESCERRO, c_Alias->DESCOPER})

		aAdd(_aItnRl,{c_Alias->LINHA,  c_Alias->NOME, c_Alias->CPF, c_Alias->CODERRO, c_Alias->DESCERRO, c_Alias->DESCOPER})

		_lAchou := .T.

		c_Alias->(DbSkip())

	EndDo

	//-------------------------------------------------------
	//Angelo Henrique - Data:08/03/2016
	//-------------------------------------------------------
	//Quando não achar nenhum registro na tabela
	//preencher os vetores com brancos para não dar
	//erro na rotina
	//-------------------------------------------------------
	If !_lAchou

		aAdd(aBrowse,{" ", " ", " ", " ", " ", " "})

		aAdd(_aItnRl,{" ", " ", " ", " ", " ", " "})

	EndIf

	DEFINE DIALOG oDlg TITLE "Visualização das Criticas" FROM 100,050 TO 800,1200 PIXEL

	@ 005,010 SAY "Arquivo: " + AllTrim(PBT->PBT_NOMARQ) 						SIZE 150,07 OF oDlg PIXEL

	@ 005,110 SAY "Quantidade de Criticas: " 	+ cValToChar(Len(aErros)) 		SIZE 105,07 OF oDlg PIXEL

	@ 005,190 SAY "Inclusões Previstas: "  	+ CABA336B(PBT->PBT_SEQUEN,"1")	SIZE 105,07 OF oDlg PIXEL

	@ 005,260 SAY "Alterações Previstas: " 	+ CABA336B(PBT->PBT_SEQUEN,"2")	SIZE 105,07 OF oDlg PIXEL

	@ 005,330 SAY "Exclusões Previstas: "		+ CABA336B(PBT->PBT_SEQUEN,"3")	SIZE 105,07 OF oDlg PIXEL

	@ 005,400 SAY "Reativações Previstas: "	+ CABA336B(PBT->PBT_SEQUEN,"4")	SIZE 105,07 OF oDlg PIXEL

	@ 005,500 SAY "Sequência: " + PBT->PBT_SEQUEN 								SIZE 150,07 OF oDlg PIXEL

	//-----------------
	// Cria Browse
	//-----------------
	oBrowse := TCBrowse():New( 20 , 01, 573, 300,,;
	{"Linha", "Nome do Beneficiário", "CPF", "Codigo do Erro", "Descricao do Erro", "Operacao" },{20,50,50,50},;
	oDlg,,,,,{||},,,,,,,.F.,,.T.,,.F.,,, )

	//-----------------------------
	// Seta vetor para a browse
	//-----------------------------
	oBrowse:SetArray(aBrowse)

	//-----------------------------------------
	// Monta a linha a ser exibina no Browse
	//-----------------------------------------
	oBrowse:bLine := {||{ aBrowse[oBrowse:nAt,01],;
	aBrowse[oBrowse:nAt,02],;
	aBrowse[oBrowse:nAt,03],;
	aBrowse[oBrowse:nAT,04],;
	aBrowse[oBrowse:nAT,05],;
	aBrowse[oBrowse:nAT,06]} }

	TButton():New( 330, 010, "Relatório Excel"	, oDlg,{|| DlgToExcel({{"ARRAY","Criticas arquivo " + AllTrim(PBT->PBT_NOMARQ),_aArray, _aItnRl}} )},45,010,,,.F.,.T.,.F.,,.F.,,,.F. )

	ACTIVATE DIALOG oDlg CENTERED

	c_Alias->(DbCloseArea())

	RestArea(aArea)

Return

Static Function lBA3SemSub(c_CodEmp, c_MatEmp)

	Local c_Qry 		:= ""
	Local lExiste		:= .F.
	Local cAlBA3Sub 	:= GetNextAlias()

	c_Qry := "SELECT R_E_C_N_O_ REC" 							+ CRLF
	c_Qry += "FROM " + RetSqlName("BA3") + " BA3" 				+ CRLF
	c_Qry += "WHERE BA3_FILIAL = '" + xFilial("BA3") +  "'" 	+ CRLF
	c_Qry += "  AND BA3_CODINT = '0001'" 						+ CRLF
	c_Qry += "  AND BA3_CODEMP = '" + c_CodEmp + "'" 			+ CRLF
	c_Qry += "  AND BA3_MATEMP = '" + c_MatEmp + "'" 			+ CRLF
	c_Qry += "  AND BA3_DATBLO = ' '" 							+ CRLF
	c_Qry += "  AND BA3_SUBCON = ' '" 							+ CRLF
	c_Qry += "  AND D_E_L_E_T_ = ' '" 							+ CRLF

	TcQuery c_Qry New Alias cAlBA3Sub

	lExiste := !cAlBA3Sub->(EOF())

	cAlBA3Sub->(DbCloseArea())

Return lExiste

Static Function lBA3SemPla(c_CodEmp, c_MatEmp)

	Local c_Qry 		:= ""
	Local lExiste		:= .F.
	Local cAlBA3Pla 	:= GetNextAlias()

	c_Qry := "SELECT R_E_C_N_O_ REC" 							+ CRLF
	c_Qry += "FROM " + RetSqlName("BA3") + " BA3" 				+ CRLF
	c_Qry += "WHERE BA3_FILIAL = '" + xFilial("BA3") +  "'" 	+ CRLF
	c_Qry += "  AND BA3_CODINT = '0001'" 						+ CRLF
	c_Qry += "  AND BA3_CODEMP = '" + c_CodEmp + "'" 			+ CRLF
	c_Qry += "  AND BA3_MATEMP = '" + c_MatEmp + "'" 			+ CRLF
	c_Qry += "  AND BA3_DATBLO = ' '" 							+ CRLF
	c_Qry += "  AND BA3_CODPLA = ' '" 							+ CRLF
	c_Qry += "  AND D_E_L_E_T_ = ' '" 							+ CRLF

	TcQuery c_Qry New Alias cAlBA3Pla

	lExiste := !cAlBA3Pla->(EOF())

	cAlBA3Pla->(DbCloseArea())

Return lExiste

Static Function CrIncExcAr( c_Sequen, c_Func, c_Benef, c_Oper )

	Local c_Qry := ""
	Local l_Ret := .F.

	If c_Benef == "JULY ANE TAVARES SIAS MARTINS"

		_aaa := ""

	EndIf

	c_Qry := "SELECT PBU_BENEF "
	c_Qry += "                             FROM PBU010 A "
	c_Qry += "                             WHERE PBU_SEQUEN = '" + c_Sequen + "' "
	c_Qry += "                             AND PBU_OPER = '1' "
	c_Qry += "                             AND  EXISTS (SELECT * "
	c_Qry += "                                           FROM PBU010 B "
	c_Qry += "                                           WHERE B.PBU_SEQUEN = A.PBU_SEQUEN "
	c_Qry += "                                           AND B.PBU_BENEF = A.PBU_BENEF "
	c_Qry += "                                           AND B.PBU_OPER = '3'  "
	c_Qry += "                                           ) "
	c_Qry += "                             AND PBU_FUNC = '" + c_Func + "' "
	c_Qry += "                             AND PBU_BENEF = '" + c_Benef + "' "

	TcQuery c_Qry New Alias "TMPIE"

	If !TMPIE->( EOF() )

		l_Ret := .T.

	EndIf

	TMPIE->( dbCloseArea() )

Return l_Ret


Static Function AtuPbu()

	PBU->(RecLock("PBU",.F.))

	PBU->PBU_STATUS := iif( l_Voltou, 'I', 'P' )

	PBU->(MsUnlock())

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ºAutor  ³Angelo Henrique     º Data ³  09/05/16   			º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Rotina utilizada para bloquear os beneficiário.             º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³PLS                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function CABA336A(cCPF,cCodEmp, c_Funcional)

	Local _aArea 	:= GetArea()
	Local (cAliQry) := GetNextAlias()
	Local cQry		:= ""

	cQry += "SELECT " 	+ CRLF
	cQry += "	BA1.BA1_CODINT, BA1.BA1_CODEMP, BA1.BA1_MATRIC, BA1.BA1_TIPREG, BA1.BA1_DIGITO, BA1.BA1_TIPUSU," 	+ CRLF
	cQry += "	BA1.R_E_C_N_O_ RECNO " 																		+ CRLF
	cQry += "FROM " + RetSqlName('BA1') + " BA1" 															+ CRLF
	cQry += "INNER JOIN " + RetSqlName('BA3') + " BA3 ON BA3_FILIAL = '" + xFilial('BA3') + "'" 	+ CRLF
	cQry += "  AND BA3.BA3_CODINT = BA1.BA1_CODINT" 														+ CRLF
	cQry += "  AND BA3.BA3_CODEMP = BA1.BA1_CODEMP" 														+ CRLF
	cQry += "  AND BA3.BA3_MATRIC = BA1.BA1_MATRIC" 														+ CRLF
	cQry += "  AND BA3.D_E_L_E_T_ = ' '" 																	+ CRLF
	cQry += "WHERE BA1.BA1_FILIAL = '" + xFilial('BA1') + "'" 											+ CRLF
	cQry += "  AND BA1.BA1_CPFUSR = '" + cCPF + "'"     	            									+ CRLF
	cQry += "  AND BA1.BA1_CODINT = '" + PLSINTPAD() + "'" 												+ CRLF
	cQry += "  AND BA1.BA1_CODEMP = '" + cCodEmp + "'" 													+ CRLF
	cQry += "  AND TRIM(BA3.BA3_MATEMP) = '" + alltrim(c_Funcional )+ "'" 							+ CRLF //MBCMIG
	cQry += "  AND BA1.BA1_DATBLO = ' '" 																	+ CRLF
	cQry += "  AND BA1.D_E_L_E_T_ = ' '" 																	+ CRLF

	TcQuery cQry New Alias (cAliQry)

	While !(cAliQry)->(EOF())

		DbSelectArea("BA1")
		DbSetOrder(2)
		If DbSeek(xFilial("BA1") + (cAliQry)->BA1_CODINT + (cAliQry)->BA1_CODEMP + (cAliQry)->BA1_MATRIC + (cAliQry)->BA1_TIPREG + (cAliQry)->BA1_DIGITO)

			//-------------------------------------------------------------------------------
			//Refoçando aqui a validação do bloqueio, porque sea primeira linha for títular
			//a rotina irá bloquear toda a familia logo não haverá necessidade de executar
			//a rotina de bloqueia para o dependente.
			//-------------------------------------------------------------------------------
			If Empty(BA1->BA1_DATBLO)

				If BA1->BA1_TIPUSU == "T"

					//---------------------------------------------------------------------------------------------------
					//Bloqueio e desbloqueio da familia e grupo familiar
					//---------------------------------------------------------------------------------------------------
					//PL260BLOCO(cAlias,nReg,nOpc,lDireto,cMotivo,dData,cBloFat,nP20,aLog,lGrav,lblqAut, lMsg)
					//---------------------------------------------------------------------------------------------------
					// cMotivo - Visualizar a tabela de Motivo de bloqueio Familia (BG1)
					//---------------------------------------------------------------------------------------------------
					PL260BLOCO("BA1", BA1->(Recno()),4,.T.,"007",/*CTOD("31/05/2016")*/LastDate(dDataBase),"1",,,,.F.)

					//----------------------------------------------------------------------------------
					//Efetua o bloqueio e desbloqueio de familias que fazem parte do grupo familiar
					//----------------------------------------------------------------------------------
					PlsGrpFam(.F.,.T.,BA1->BA1_CODINT + BA1->BA1_CODEMP + BA1->BA1_MATRIC)

				Else

					//---------------------------------------------------------------------------------------------------
					//Bloquear/Desbloquear Usuario
					//---------------------------------------------------------------------------------------------------
					//PL260BLOUS(cAlias,nReg,nOpc,lDireto,cMotivo,dData,cBloFat,lFiltro,nP20,aLog,lGrav,lMsg)
					//---------------------------------------------------------------------------------------------------
					// cMotivo - Visualizar a tabela de Motivo de bloqueio Usuário (BG3)
					//---------------------------------------------------------------------------------------------------
					PL260BLOUS("BA1", BA1->(Recno()), 4, .T.,"007",/*CTOD("31/05/2016")*/LastDate(dDataBase),"1")

				EndIf

			EndIf

		EndIf

		(cAliQry)->(DbSkip())

	EndDo

	(cAliQry)->(DbCloseArea())

	RestArea(_aArea)

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABA336B  ºAutor  ³Angelo Henrique     º Data ³  10/05/16   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Rotina utilizada para contar as inclusões e exclusões       º±±
±±ºDesc.     ³que são enviadas no arquivo.                                º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³PLS                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function CABA336B(_cSeq,_cParam)

	Local _aArea 		:= GetArea()
	Local _cAli 		:= GetNextAlias()
	Local cQry			:= ""
	Local _cRet		:= ""

	//--------------------------------------------------
	//Utilizado para saber qual filtro sera feito,
	//se será para total de inclusões previstas
	//ou total de exclusões previstas
	//--------------------------------------------------
	Default _cParam	:= ""

	cQry += "SELECT COUNT(*) TOTAL" 							+ CRLF
	cQry += "FROM " + RetSqlName('PBU') + " PBU" 		+ CRLF
	cQry += " WHERE PBU_SEQUEN = '" + _cSeq + "' "	+ CRLF
	cQry += "  AND D_E_L_E_T_ = ' '" 					+ CRLF

	If _cParam == "1"

		cQry += "  AND TRIM(PBU_OPER) = '1'"			+ CRLF //INCLUSÃO

	ElseIf _cParam == "2"

		cQry += "  AND TRIM(PBU_OPER) = '2'"			+ CRLF //ALTERAÇÃO

	ElseIf _cParam == "3"

		cQry += "  AND TRIM(PBU_OPER) = '3'"			+ CRLF //EXCLUSÃO

	ElseIf _cParam == "4"

		cQry += "  AND TRIM(PBU_OPER) = '4'"			+ CRLF //REATIVAÇÃO

	EndIf

	TcQuery cQry New Alias _cAli


	If !_cAli->(EOF())

		_cRet := cValToChar(_cAli->TOTAL)

	EndIf

	_cAli->(DbCloseArea())

	RestArea(_aArea)

Return _cRet


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABA336C  ºAutor  ³Angelo Henrique     º Data ³  09/05/16   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Rotina utilizada para transferir os beneficiários.          º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³PLS                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function CABA336C(cCPF, cCodEmp	, _cLayt, cProd, _cplOdo, cIndCar, c_Func, _cSeqn)

	Local _aArea 		:= GetArea()
	Local cAliQry 	:= GetNextAlias()
	Local cQry			:= ""
	Local _aArTit		:= {}
	Local _cQry1		:= GetNextAlias()
	Local _cMatric	:= ""
	Local lFamCad		:= .F.
	Local _cChvBa3 	:= ""
	Local _cOldMat 	:= ""
	Local _cChvBa1	:= ""
	Local lPrim 		:= .T.
	Local _cYdlap 	:= ""
	Local _aArRec		:= {}
	Local _dData		:= STOD(" ")
	Local _cPlanCd	:= ""
	Local _cQry2		:= GetNextAlias()
	Local _cMatOdo	:= ""
	Local _cChvTit	:= ""
	Local _cCodOri 	:= ""
	Local _cEmpOri 	:= ""
	Local _cTipOri 	:= ""
	Local _cDigNov 	:= ""

	//-----------------------------------
	//Ponterando no beneficiário
	//-----------------------------------
	cQry := "SELECT " 																						+ CRLF
	cQry += "	BA1.BA1_CODINT, BA1.BA1_CODEMP, BA1.BA1_MATRIC, BA1.BA1_TIPREG, " 						+ CRLF
	cQry += "	BA1.BA1_DIGITO, BA1.BA1_TIPUSU,BA1.R_E_C_N_O_ RECNO, BA1.BA1_SUBCON, "				+ CRLF
	cQry += "	BA1.BA1_CONEMP "																				+ CRLF
	cQry += "FROM " + RetSqlName('BA1') + " BA1" 															+ CRLF
	cQry += "INNER JOIN " + RetSqlName('BA3') + " BA3 ON BA3_FILIAL = '" + xFilial('BA3') + "'" 	+ CRLF
	cQry += "  AND BA3.BA3_CODINT = BA1.BA1_CODINT" 														+ CRLF
	cQry += "  AND BA3.BA3_CODEMP = BA1.BA1_CODEMP" 														+ CRLF
	cQry += "  AND BA3.BA3_MATRIC = BA1.BA1_MATRIC" 														+ CRLF
	cQry += "  AND BA3.BA3_CODPLA = BA1.BA1_CODPLA" 														+ CRLF
	cQry += "  AND BA3.D_E_L_E_T_ = ' '" 																	+ CRLF
	cQry += "WHERE BA1.BA1_FILIAL = '" + xFilial('BA1') + "'" 											+ CRLF
	cQry += "  AND BA1.BA1_CPFUSR = '" + cCPF + "'"     	            									+ CRLF
	cQry += "  AND BA1.BA1_CODINT = '" + PLSINTPAD() + "'" 												+ CRLF
	cQry += "  AND BA1.BA1_CODEMP = '" + cCodEmp + "'" 													+ CRLF
	cQry += "  AND TRIM(BA3.BA3_MATEMP) = '" + AllTrim(c_Func) + "'" 									+ CRLF
	cQry += "  AND BA1.BA1_DATBLO = ' '" 																	+ CRLF
	cQry += "  AND BA1.D_E_L_E_T_ = ' '" 																	+ CRLF

	If Select(cAliQry)>0
		(cAliQry)->(DbCloseArea())
	EndIf

	DbUseArea(.T.,"TopConn",TcGenQry(,,cQry),cAliQry,.T.,.T.)

	DbSelectArea(cAliQry)

	While !((cAliQry)->(EOF()))

		If _cLayt == "1" .and. (cAliQry)->BA1_SUBCON == "000000003"

			//*_cPlanCd := ConvPlano(trim(cProd),"MED","C")
			_cPlanCd := ConvPlano(trim(cProd),Alltrim((cAliQry)->BA1_TIPUSU),1)

			/*ElseIf _cLayt == "1" .and. (cAliQry)->BA1_SUBCON == "000000002"

			_cPlanCd := ConvPlano(trim(cProd),"ODO","C")*/

		ElseIf _cLayt == "2" .and. lPrim

			_cPlanCd := cProd

			lPrim := .F.

		Else

			_cPlanCd := _cplOdo

		EndIf


		//---------------------------
		//Restaurando variaveis
		//---------------------------
		lFamCad := .F.

		//------------------------------------------------------------------------------------
		//Achando o beneficiário tenho os dois subcontratos nesta query(Saude e o Dental)
		//Alem disso tenho a matricula onde posso ponterar no títular, para poder prosseguir
		//com o processo e também filtrar somente os dependentes ativos
		//------------------------------------------------------------------------------------

		cQry := " SELECT " 	+ CRLF
		cQry += "  	BA1.BA1_TIPUSU, BA1.BA1_CPFUSR, DECODE(BA1.BA1_TIPUSU,'T',1,'D',2 ) TIPO,  " 	+ CRLF
		cQry += "		BA1.BA1_CODINT, BA1.BA1_CODEMP, BA1.BA1_MATRIC, BA1.BA1_TIPREG, " 			+ CRLF
		cQry += "		BA1.BA1_DIGITO, BA1.BA1_TIPUSU, BA1.R_E_C_N_O_ RECNO, BA1.BA1_SUBCON " 		+ CRLF
		cQry += " FROM " + RetSqlName('BA1') + " BA1" 												+ CRLF
		cQry += " WHERE D_E_L_E_T_ = ' '" 															+ CRLF
		cQry += "  	AND BA1.BA1_CODINT = '" + (cAliQry)->BA1_CODINT + "'" 							+ CRLF
		cQry += " 		AND BA1.BA1_CODEMP = '" + (cAliQry)->BA1_CODEMP + "'" 						+ CRLF
		cQry += " 		AND BA1.BA1_MATRIC = '" + (cAliQry)->BA1_MATRIC + "'"						+ CRLF
		cQry += " 		AND BA1.BA1_SUBCON = '" + (cAliQry)->BA1_SUBCON + "'"						+ CRLF
		cQry += " 		AND BA1.BA1_CONEMP = '" + (cAliQry)->BA1_CONEMP + "'"						+ CRLF
		cQry += "  	AND BA1.BA1_DATBLO = ' '" 														+ CRLF
		cQry += " ORDER BY 3	"

		If Select(_cQry1)>0
			(_cQry1)->(DbCloseArea())
		EndIf

		DbUseArea(.T.,"TopConn",TcGenQry(,,cQry),_cQry1,.T.,.T.)

		DbSelectArea(_cQry1)

		While !((_cQry1)->(EOF()))

			//-------------------------------------------------------------------------------------------------------
			//Agora tenho todos os beneficiário ativos desta familia com isso faço o bloqueio de familia que em uma
			//unica vez bloqueio todos da forma correta, tenho um ganho assim de performance e passo a ir direto
			//para as novas inclusões
			//-------------------------------------------------------------------------------------------------------
			DbSelectArea("BA1")
			DbSetOrder(2)
			If DbSeek(xFilial("BA1") + (_cQry1)->BA1_CODINT + (_cQry1)->BA1_CODEMP + (_cQry1)->BA1_MATRIC + (_cQry1)->BA1_TIPREG + (_cQry1)->BA1_DIGITO)

				_cChvBa1 := xFilial("BA1") + (_cQry1)->BA1_CODINT + (_cQry1)->BA1_CODEMP + (_cQry1)->BA1_MATRIC + (_cQry1)->BA1_TIPREG + (_cQry1)->BA1_DIGITO

				//------------------------------------------------------------------------------------
				//Validação para saber se esta no mesmo plano, não gerando assim a transferência
				//------------------------------------------------------------------------------------
				If !CABA336E(_cPlanCd)

					//-------------------------------------------------------------------------------
					//Refoçando aqui a validação do bloqueio, porque sea primeira linha for títular
					//a rotina irá bloquear toda a familia logo não haverá necessidade de executar
					//a rotina de bloqueia para o dependente.
					//-------------------------------------------------------------------------------
					If Empty(BA1->BA1_DATBLO)

						_aArTit := BA1->(GetArea())

						If BA1->BA1_TIPUSU == "T"

							_cChvTit := _cChvBa1

						Else

							DbSelectArea("BA1")
							DbSetOrder(2)
							DbSeek(_cChvTit) //Ponterando no títular para realizar o bloqueio

						EndIf

						//---------------------------------------------------------------------------------------------------
						//Bloqueio e desbloqueio da familia e grupo familiar
						//---------------------------------------------------------------------------------------------------
						//PL260BLOCO(cAlias,nReg,nOpc,lDireto,cMotivo,dData,cBloFat,nP20,aLog,lGrav,lblqAut, lMsg)
						//---------------------------------------------------------------------------------------------------
						// cMotivo - Visualizar a tabela de Motivo de bloqueio Familia (BG1)
						//---------------------------------------------------------------------------------------------------

						PL260BLOCO("BA1", BA1->(Recno()),4,.T.,"019",/*CTOD("31/05/2016")*/LastDate(dDataBase),"1",,,,.F.)

						//----------------------------------------------------------------------------------
						//Efetua o bloqueio e desbloqueio de familias que fazem parte do grupo familiar
						//----------------------------------------------------------------------------------
						PlsGrpFam(.F.,.T.,BA1->BA1_CODINT + BA1->BA1_CODEMP + BA1->BA1_MATRIC)

						RestArea(_aArTit)

					EndIf

					//----------------------------------------------------------------------
					//Realizo o processo de inclusão
					//Nesta etapa irei varrer a BA1 e a BA3 para criar os novos cadastros
					//Para replicar as informações e mudando somente aquelas referente
					//ao processo de transferência (Downgrade e Upgrade) de plano
					//----------------------------------------------------------------------


					//--------------------------------------
					//Iniciando pela familia (BA3)
					//--------------------------------------

					DbSelectArea("BI3")
					DbSetOrder(1)
					DbSeek(xFilial("BI3") + BA1->BA1_CODINT + _cPlanCd + "001")

					If BA1->BA1_TIPUSU == "T"

						//----------------------------
						//Pegando nova matricula
						//----------------------------
						_cMatric := PLPROXMAT(BA1->BA1_CODINT, BA1->BA1_CODEMP)

						DbSelectArea("BA3")
						DBsetOrder(1)
						If DbSeek(xFilial("BA3")+BA1->BA1_CODINT+BA1->BA1_CODEMP+BA1->BA1_MATRIC+BA1->BA1_CONEMP+BA1->BA1_VERCON+BA1->BA1_SUBCON+BA1->BA1_VERSUB)

							_cChvBa3 := xFilial("BA3")+BA3->BA3_CODINT+BA3->BA3_CODEMP+BA3->BA3_MATRIC+BA3->BA3_CONEMP+BA3->BA3_VERCON+BA3->BA3_SUBCON+BA3->BA3_VERSUB
							_cOldMat := BA3->BA3_MATRIC

							Reclock("BA3", .F.)

							BA3->BA3_TRADES := _cMatric

							BA3->(MsUnlock())

						EndIf


						Reclock("BA3",.T.)

						DbSelectArea("SX3")
						DbSetOrder(1)
						DbSeek("BA3",.T.)

						While SX3->X3_ARQUIVO = "BA3" .and. !Eof()

							DbSelectArea("BA3")

							If SX3->X3_CONTEXT != "V" //Não pode ser campo virtual

								If AllTrim(UPPER(SX3->X3_CAMPO)) == "BA3_MATRIC"

									FieldPut(FieldPos(SX3->X3_CAMPO),_cMatric)

								ElseIf AllTrim(UPPER(SX3->X3_CAMPO)) == "BA3_AGMTFU"

									FieldPut(FieldPos(SX3->X3_CAMPO),_cMatric)

								ElseIf AllTrim(UPPER(SX3->X3_CAMPO)) == "BA3_MOTBLO"

									FieldPut(FieldPos(SX3->X3_CAMPO)," ")

								ElseIf AllTrim(UPPER(SX3->X3_CAMPO)) == "BA3_DATBLO"

									FieldPut(FieldPos(SX3->X3_CAMPO),StoD("        "))

								ElseIf AllTrim(UPPER(SX3->X3_CAMPO)) == "BA3_CODPLA"

									FieldPut(FieldPos(SX3->X3_CAMPO),_cPlanCd)

								ElseIf AllTrim(UPPER(SX3->X3_CAMPO)) == "BA3_TIPCON"

									FieldPut(FieldPos(SX3->X3_CAMPO),BI3->BI3_TIPCON)

								ElseIf AllTrim(UPPER(SX3->X3_CAMPO)) == "BA3_SEGPLA"

									FieldPut(FieldPos(SX3->X3_CAMPO),BI3->BI3_CODSEG)

								ElseIf AllTrim(UPPER(SX3->X3_CAMPO)) == "BA3_MODPAG"

									FieldPut(FieldPos(SX3->X3_CAMPO),BI3->BI3_MODPAG)

								ElseIf AllTrim(UPPER(SX3->X3_CAMPO)) == "BA3_APLEI"

									FieldPut(FieldPos(SX3->X3_CAMPO),BI3->BI3_APOSRG)

								ElseIf AllTrim(UPPER(SX3->X3_CAMPO)) == "BA3_CODACO"

									FieldPut(FieldPos(SX3->X3_CAMPO),BI3->BI3_CODACO)

								ElseIf AllTrim(UPPER(SX3->X3_CAMPO)) == "BA3_ABRANG"

									FieldPut(FieldPos(SX3->X3_CAMPO),BI3->BI3_ABRANG)

								ElseIf AllTrim(UPPER(SX3->X3_CAMPO)) == "BA3_TRAORI"

									FieldPut(FieldPos(SX3->X3_CAMPO),_cOldMat)

								ElseIf AllTrim(UPPER(SX3->X3_CAMPO)) == "BA3_TRADES"

									FieldPut(FieldPos(SX3->X3_CAMPO)," ")

								ElseIf AllTrim(UPPER(SX3->X3_CAMPO)) == "BA3_DATBAS"

									If dDatabase == FirstDate(dDatabase)

										_dData := dDataBase

									Else

										_dData := FirstDate(MonthSum(dDatabase,1))

									EndIf

									FieldPut(FieldPos(SX3->X3_CAMPO),_dData)

								Else

									_aArRec := BA3->(GetArea())

									_cPsX3 := POSICIONE("BA3",1,_cChvBa3,SX3->X3_CAMPO)

									RestArea(_aArRec)

									DbSelectArea("BA3")
									FieldPut(FieldPos(SX3->X3_CAMPO),_cPsX3)

								EndIf

							EndIf

							DbSelectArea("SX3")
							DbSkip()

						EndDo

						BA3->(MsUnlock())

					EndIf

					//------------------------------------------------------
					//Validação para saber se realmente criou matricula 
					//------------------------------------------------------
					If !Empty(AllTrim(_cMatric))

						_cYdlap := ConvPlano(trim(cProd),Alltrim((cAliQry)->BA1_TIPUSU),2)

						Reclock("BA1",.T.)

						DbSelectArea("SX3")
						DbSetOrder(1)
						DbSeek("BA1",.T.)

						While SX3->X3_ARQUIVO = "BA1" .and. !Eof()

							DbSelectArea("BA1")

							If SX3->X3_CONTEXT != "V" //Não pode ser campo virtual

								If AllTrim(UPPER(SX3->X3_CAMPO)) == "BA1_MATRIC"

									FieldPut(FieldPos(SX3->X3_CAMPO),_cMatric)

								ElseIf AllTrim(UPPER(SX3->X3_CAMPO)) == "BA1_IMAGE"

									FieldPut(FieldPos(SX3->X3_CAMPO),"ENABLE")

								ElseIf AllTrim(UPPER(SX3->X3_CAMPO)) == "BA1_MOTBLO"

									FieldPut(FieldPos(SX3->X3_CAMPO), " " )

								ElseIf AllTrim(UPPER(SX3->X3_CAMPO)) == "BA1_DATBLO"

									FieldPut(FieldPos(SX3->X3_CAMPO),StoD("        "))

								ElseIf AllTrim(UPPER(SX3->X3_CAMPO)) == "BA1_YDPLAP"

									FieldPut(FieldPos(SX3->X3_CAMPO),_cYdlap)

								ElseIf AllTrim(UPPER(SX3->X3_CAMPO)) == "BA1_YCPLAP"

									FieldPut(FieldPos(SX3->X3_CAMPO),cProd)

								ElseIf AllTrim(UPPER(SX3->X3_CAMPO)) == "BA1_CODPLA"

									//-----------------------------------------------------------
									//Reforçando para trazer o plano correto do beneficiário
									//Estava dando erro no multi-produto (0112/0113)
									//Estava sempre levando o plano do títular, pois ficava 
									//marcado para _cPlanCD no inicio da transferência
									//quando chegava nesse ponto não era visualziado se é 
									//títular ou dependente.
									//-----------------------------------------------------------																
									_aArRec := BA1->(GetArea())

									_cPsX3 := POSICIONE("BA1",2,_cChvBa1,"BA1_TIPUSU")
									_cPlanCd := ConvPlano(trim(cProd),Alltrim(_cPsX3),1)

									RestArea(_aArRec)

									DbSelectArea("BA1")															
									FieldPut(FieldPos(SX3->X3_CAMPO),_cPlanCd)

								ElseIf AllTrim(UPPER(SX3->X3_CAMPO)) == "BA1_LOCSIB"

									FieldPut(FieldPos(SX3->X3_CAMPO),"0")

								ElseIf AllTrim(UPPER(SX3->X3_CAMPO)) == "BA1_ENVANS"

									FieldPut(FieldPos(SX3->X3_CAMPO),StoD("        "))

								ElseIf AllTrim(UPPER(SX3->X3_CAMPO)) == "BA1_CODCCO"

									FieldPut(FieldPos(SX3->X3_CAMPO)," ")

								ElseIf AllTrim(UPPER(SX3->X3_CAMPO)) == "BA1_DATINC"

									If dDatabase == FirstDate(dDatabase)

										_dData := dDataBase

									Else

										_dData := FirstDate(MonthSum(dDatabase,1))

									EndIf

									FieldPut(FieldPos(SX3->X3_CAMPO),_dData)

								ElseIf AllTrim(UPPER(SX3->X3_CAMPO)) == "BA1_DATTRA"

									//-----------------------------
									//Data de Transferência
									//-----------------------------
									FieldPut(FieldPos(SX3->X3_CAMPO),dDataBase)

								ElseIf AllTrim(UPPER(SX3->X3_CAMPO)) == "BA1_DIGITO"

									//-----------------------------
									//Calculo do Digito
									//-----------------------------
									_aArRec := BA1->(GetArea())

									_cCodOri := POSICIONE("BA1",2,_cChvBa1,"BA1_CODINT")
									_cEmpOri := POSICIONE("BA1",2,_cChvBa1,"BA1_CODEMP")
									_cTipOri := POSICIONE("BA1",2,_cChvBa1,"BA1_TIPREG")

									_cDigNov := Modulo11(_cCodOri + _cEmpOri + _cMatric + _cTipOri)

									RestArea(_aArRec)

									DbSelectArea("BA1")
									FieldPut(FieldPos(SX3->X3_CAMPO),_cDigNov)

								ElseIf AllTrim(UPPER(SX3->X3_CAMPO)) == "BA1_YMTODO"

									FieldPut(FieldPos(SX3->X3_CAMPO)," ")

								ElseIf AllTrim(UPPER(SX3->X3_CAMPO)) == "BA1_IMPORT"

									FieldPut(FieldPos(SX3->X3_CAMPO),"PREF TRANS: " + AllTrim(_cSeqn))

								Else

									_aArRec := BA1->(GetArea())

									_cPsX3 := POSICIONE("BA1",2,_cChvBa1,SX3->X3_CAMPO)

									RestArea(_aArRec)

									DbSelectArea("BA1")
									FieldPut(FieldPos(SX3->X3_CAMPO),_cPsX3)

								EndIf

							EndIf

							DbSelectArea("SX3")
							DbSkip()

						EndDo

						BA1->(MsUnlock())

						//------------------------------------------------------
						//A tabela de Vida (BTS) não é necessário atualizar
						//pois permanecerá com as mesmas informações
						//------------------------------------------------------
						//Inciando a montagem dos opcionais:
						//Funções abaixo foram retiradas da rotina de incluir
						//deste mesmo fonte.
						//------------------------------------------------------

						AtuOpc( lFamCad )

						lFamCad := .T. //Depois de Realizar a primeira vez, a nova familia já irá existir

						AtuAdesao()
						AtuProd()

						u_GerCarUsr(BA1->BA1_SUBCON, BA1->BA1_CODINT, BA1->BA1_CODEMP, BA1->BA1_MATRIC, BA1->BA1_TIPREG, BA1->BA1_CODPLA, BA1->BA1_DATINC, cIndCar)

					EndIf					

				Else

					//-----------------------------------------------
					//LIMPANDO TABELAS DE COBRANÇA E OPCIONAL
					//-----------------------------------------------
					_aArRec := BA1->(GetArea())

					//BYX_FILIAL+BYX_CODOPE+BYX_CODEMP+BYX_MATRIC+BYX_TIPREG+BYX_CODOPC+BYX_VEROPC+BYX_CODFOR
					DbSelectArea("BYX")
					DbSetOrder(1)
					If DBSeek(xFilial("BYX")+BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG))

						While !EOF() .And. BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG) == BYX->(BYX_CODOPE+BYX_CODEMP+BYX_MATRIC+BYX_TIPREG)

							RecLock("BYX", .F.)

							DbDelete()

							BYX->(MsUnLock())

							BYX->(DbSkip())

						EndDo

					EnDIf

					DbSelectArea("BZX")
					DbSetOrder(1) //BZX_FILIAL+BZX_CODOPE+BZX_CODEMP+BZX_MATRIC+BZX_TIPREG+BZX_CODOPC+BZX_VEROPC+BZX_CODFOR+BZX_CODFAI
					If DBSeek(xFilial("BZX")+BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG))

						While !EOF() .And. BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG) == BZX->(BZX_CODOPE+BZX_CODEMP+BZX_MATRIC+BZX_TIPREG)

							RecLock("BZX", .F.)

							DbDelete()

							BZX->(MsUnLock())

							BZX->(DbSkip())

						EndDo

					EnDIf

					//-----------------------------------------------------------------------
					//Ponterando na BA3 para que a rotina funcione corretamente
					//-----------------------------------------------------------------------
					DbSelectArea("BA3")
					DbSetOrder(1)
					If DBSeek(xFilial("BA3")+BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_CONEMP+BA1_VERCON+BA1_SUBCON+BA1_VERSUB))

						AtuOpc(.F.)

					EndIf

					//---------------------------------------------------
					//Atualizando a Data de inclusão correta do opcional
					//---------------------------------------------------
					DbSelectArea("BF4")
					DbSetOrder(1) //BF4_FILIAL+BF4_CODINT+BF4_CODEMP+BF4_MATRIC+BF4_TIPREG+BF4_CODPRO
					If DBSeek(xFilial("BF4")+BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG))

						If dDatabase == FirstDate(dDatabase)

							_dData := dDataBase

						Else

							_dData := FirstDate(MonthSum(dDatabase,1))

						EndIf

						While !EOF() .And. BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG) == BF4->(BF4_CODINT+BF4_CODEMP+BF4_MATRIC+BF4_TIPREG)

							RecLock("BF4", .F.)

							BF4->BF4_DATBAS := _dData

							BF4->(MsUnLock())

							BF4->(DbSkip())

						EndDo

					EnDIf

					RestArea(_aArRec)

				EndIf

			EndIf

			(_cQry1)->(DbSkip())

		EndDo

		(cAliQry)->(DbSkip())

	EndDo

	If Select(_cQry1) > 0

		(_cQry1)->(DbCloseArea())

	EndIf

	If Select(cAliQry) > 0

		(cAliQry)->(DbCloseArea())

	EndIf

	RestArea(_aArea)

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABA336D  ºAutor  ³Angelo Henrique     º Data ³  10/05/16   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Rotina utilizada para validar se o titular esta no arquivo  º±±
±±ºDesc.     ³para o processo de transferência.                           º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³PLS                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function CABA336D(_cSeq,_cFunc,_cCdBen,_cParam)

	Local _aArea 		:= GetArea()
	Local _cAli 		:= GetNextAlias()
	Local cQry			:= ""
	Local _lRet			:= .T.

	Default _cParam		:= "1" //Parametro utilizado para saber qual validação realizar

	If UPPER(AllTrim(_cCdBen)) != "T"

		//----------------------------------------------
		//Primeira validação:
		//Saber se o titular esta no mesmo arquivo
		//---------------------------------------------- 
		If _cParam = "1"

			cQry += "SELECT PBU_FUNC, PBU_CDBENE"				+ CRLF
			cQry += "FROM " + RetSqlName('PBU') + " PBU" 		+ CRLF
			cQry += " WHERE PBU_SEQUEN 	= '" + _cSeq + "' "	+ CRLF
			cQry += "  AND D_E_L_E_T_ 	= ' '" 				+ CRLF
			cQry += "  AND PBU_FUNC 	= '" + _cFunc + "'" 	+ CRLF
			cQry += "  AND PBU_CDBENE 	= 'T'"	+ CRLF

			TcQuery cQry New Alias _cAli

			If _cAli->(EOF())

				_lRet := .F.

			EndIf

			_cAli->(DbCloseArea())

		EndIf

		//----------------------------------------------
		//Segunda validação:
		//Saber se o titular esta ativo no sistema
		//---------------------------------------------- 
		If _cParam = "2"

			cQry := "SELECT " 			+ CRLF
			cQry += "	BA3_DATBLO " 	+ CRLF
			cQry += "FROM 	" 			+ CRLF
			cQry += "	" + RetSqlName("BA3") + " BA3 " 		+ CRLF
			cQry += "WHERE " 									+ CRLF
			cQry += "	BA3_FILIAL = '" + xFilial("BA3") + "' "	+ CRLF
			cQry += "  	AND BA3_CODINT = '0001' " 				+ CRLF
			cQry += "  	AND BA3_CODEMP = '0024' " 				+ CRLF
			cQry += "  	AND BA3_MATEMP = '" + _cFunc + "' "		+ CRLF
			cQry += "  	AND BA3_DATBLO = ' ' " 					+ CRLF			
			cQry += "  	AND D_E_L_E_T_ = ' ' " 					+ CRLF

			TcQuery cQry New Alias _cAli

			If _cAli->(EOF())

				_lRet := .F.

			EndIf

			_cAli->(DbCloseArea())

		EndIf

		//----------------------------------------------
		//Terceira validação:
		//Saber se o plano informado para a transferência
		//é o mesmo do títular na base
		//---------------------------------------------- 
		If _cParam = "3"

			cQry := " SELECT  													" + CRLF
			cQry += "	TRIM(PBU.PBU_FUNC) FUNC, 								" + CRLF
			cQry += "	TRIM(PBU.PBU_CDBENE) CDBENEF,							" + CRLF
			cQry += "	TRIM(PBU.PBU_STATUS) STATUS, 							" + CRLF
			cQry += "	TRIM(PBU.PBU_PADRAO) PADRAO, 							" + CRLF
			cQry += "	TRIM(BA3.BA3_MATEMP) MATEMP, 							" + CRLF
			cQry += "	TRIM(BA3.BA3_CODINT) CODINT, 							" + CRLF
			cQry += "	TRIM(BA3.BA3_CODEMP) CODEMP, 							" + CRLF
			cQry += "	TRIM(BA3.BA3_MATRIC) MATRIC, 							" + CRLF
			cQry += "	TRIM(BA3.BA3_CODPLA) CODPLA, 							" + CRLF
			cQry += "	TRIM(PREF.PLANO_PREF) PLANO_PREF, 						" + CRLF
			cQry += "	TRIM(PREF.PLANO_MEDICO) PLANO_MEDICO, 					" + CRLF
			cQry += "	TRIM(PREF.TIP_USU) TIP_USU 								" + CRLF
			cQry := " FROM  													" + CRLF
			cQry += "	" + RetSqlName("PBU") + " PBU 							" + CRLF 
			cQry += "		INNER JOIN " + RetSqlName("BA3") + " BA3 			" + CRLF
			cQry += "			ON BA3.BA3_FILIAL = '" + xFilial("BA3") + "'	" + CRLF
			cQry += "			AND BA3.BA3_MATEMP = PBU.PBU_FUNC 				" + CRLF  
			cQry += "			AND BA3_DATBLO = ' ' 							" + CRLF
			cQry += "			AND BA3.D_E_L_E_T_ = ' ' 						" + CRLF
			cQry += "		INNER JOIN SIGA.PLANO_PREF_CAB_NV PREF				" + CRLF
			cQry += "			ON PREF.PLANO_PREF = TRIM(PBU.PBU_PADRAO)		" + CRLF
			cQry += "			AND PREF.TIP_USU = '" + _cCdBen + "'			" + CRLF
			cQry += " WHERE 													" + CRLF
			cQry += " 	PBU.PBU_FILIAL = '" + xFilial("PBU") + "'				" + CRLF
			cQry += " 	AND PBU.PBU_SEQUEN = '" + _cSeq + "'					" + CRLF
			cQry += " 	AND PBU.PBU_FUNC = '" + _cFunc + "'						" + CRLF
			cQry += " 	AND PBU.PBU_OPER IN ('1','2') 							" + CRLF

			TcQuery cQry New Alias _cAli

			If _cAli->(EOF())

				_lRet := .F.

			Else

				//---------------------------------------------
				//Se o plano for 0114 o títular deve ser 
				//obrigatoriamente 0112 no sistema
				//---------------------------------------------
				If _cAli->(PLANO_MEDICO) = '0114'

					If _cAli->(CODPLA) != "0112"

						_lRet := .F.	

					EndIf

				ElseIf _cAli->(PLANO_MEDICO) = '0115'

					//---------------------------------------------
					//Se o plano for 0115 o títular deve ser 
					//obrigatoriamente 0113 no sistema
					//---------------------------------------------
					If _cAli->(CODPLA) != "0113"

						_lRet := .F.	

					EndIf

				ElseIf !(_cAli->(PLANO_MEDICO) $ ('0114|0115'))

					//---------------------------------------------
					//Nos demais planos o plano do dependente 
					//deve ser igual ao plano do titular
					//---------------------------------------------
					If _cAli->(PLANO_MEDICO) != _cAli->(CODPLA)

						_lRet := .F.	

					EndIf

				EndIf 

			EndIf

			_cAli->(DbCloseArea())

		EndIf

	EndIf

	RestArea(_aArea)

Return _lRet


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABA336E  ºAutor  ³Angelo Henrique     º Data ³  10/05/16   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Rotina utilizada para validar se o plano já não foi inseridoº±±
±±ºDesc.     ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³PLS                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function CABA336E(_cPlanCd)


	Local _lRet 	:= .F.
	Local cQry		:= ""
	Local _cQry1 	:= GetNextAlias()

	cQry := " SELECT " 	+ CRLF
	cQry += "  	BA1.BA1_CPFUSR,  " 	+ CRLF
	cQry += "		BA1.BA1_CODINT, BA1.BA1_CODEMP, BA1.BA1_MATRIC, BA1.BA1_TIPREG, " 	+ CRLF
	cQry += "		BA1.BA1_DIGITO, BA1.R_E_C_N_O_ RECNO " 				+ CRLF
	cQry += " FROM " + RetSqlName('BA1') + " BA1" 										+ CRLF
	cQry += " WHERE D_E_L_E_T_ = ' '" 														+ CRLF
	cQry += "  	AND BA1_CODINT = '" + BA1->BA1_CODINT 	+ "'" 						+ CRLF
	cQry += " 		AND BA1_CODEMP = '" + BA1->BA1_CODEMP 	+ "'" 						+ CRLF
	cQry += " 		AND BA1_CPFUSR = '" + BA1->BA1_CPFUSR 	+ "'"						+ CRLF
	cQry += " 		AND BA1_TIPREG = '" + BA1->BA1_TIPREG 	+ "'"						+ CRLF
	cQry += " 		AND BA1_CODPLA = '" + _cPlanCd 			+ "'"						+ CRLF
	cQry += " 		AND BA1_DATBLO = ' '" + CRLF

	If Select(_cQry1)>0
		(_cQry1)->(DbCloseArea())
	EndIf

	DbUseArea(.T.,"TopConn",TcGenQry(,,cQry),_cQry1,.T.,.T.)

	DbSelectArea(_cQry1)

	If !((_cQry1)->(EOF()))

		_lRet := .T.

	EndIf

	If Select(_cQry1)>0
		(_cQry1)->(DbCloseArea())
	EndIf

Return _lRet


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABA336F  ºAutor  ³Angelo Henrique     º Data ³  14/06/16   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Rotina utilizada para validar se o beneficiário irá poder   º±±
±±ºDesc.     ³realizar o processo de transferência ou não.                º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³PLS                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function CABA336F(_cSeqn, _cNmLin, _cOper)

	Local cQry		:= ""
	Local _cQry1 	:= GetNextAlias()
	Local _nErro	:= 0
	Local _lTrans	:= .F.
	Local _lPlan	:= .F.

	//-----------------------------------------
	//Somente no processo de Alteração
	//-----------------------------------------
	If _cOper = "2"

		//---------------------------------------------------------------------------------------------
		//Query para validar se o registro selecionado não possui mais de um erro, pois só deverá
		//executar a rotina quando o erro gerado é de transferência
		//---------------------------------------------------------------------------------------------
		cQry := "SELECT PBV_CODERR" 								+ CRLF
		cQry += " FROM " + RetSqlName('PBV') + " PBV" 			+ CRLF
		cQry += " WHERE PBV_FILIAL = '" + xFilial('PBV') + "'"	+ CRLF
		cQry += "  AND PBV_SEQUEN  = '" + _cSeqn  + "'" 			+ CRLF
		cQry += "  AND PBV_NUMLIN  = '" + _cNmLin + "'" 			+ CRLF
		cQry += "  AND D_E_L_E_T_  = ' '" 							+ CRLF

		If Select(_cQry1)>0
			(_cQry1)->(DbCloseArea())
		EndIf

		DbUseArea(.T.,"TopConn",TcGenQry(,,cQry),_cQry1,.T.,.T.)

		DbSelectArea(_cQry1)

		//------------------------------------------------------------------------------------
		//Avaliar se é código X13 que foram criados para a situação de transferência		
		//------------------------------------------------------------------------------------
		While !((_cQry1)->(EOF()))

			If (_cQry1)->PBV_CODERR = "X13"

				_lTrans := .T.

			Else

				_nErro ++

			EndIf

			(_cQry1)->(DbSkip())

		EndDo

		//---------------------------------------------------------------------------------------
		//Se nas inconsistências o beneficiário possuir outro erro além dos de transferência
		//não irá realizar a rotina de transferência
		//---------------------------------------------------------------------------------------
		If _nErro > 0

			_lTrans := .F.

		ElseIf _lTrans

			_lTrans := .T.

		ElseIf !_lTrans

			_lTrans := .F. //Reforço aqui que não deverá executar a rotina de transferência

		EndIf

		If Select(_cQry1)>0
			(_cQry1)->(DbCloseArea())
		EndIf

	EndIf

Return _lTrans


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABA336G  ºAutor  ³Angelo Henrique     º Data ³  26/08/16   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Rotina utilizada para validar o processo de reativação do   º±±
±±ºDesc.     ³beneficiario.                                               º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³PLS                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function CABA336G(_cFunc,cCPF,cPadrao,cCodEmp, c_Subcon)

	Local _aArea 		:= GetArea()
	Local _cQry		:= ''
	Local _cAlias		:= GetNextAlias()
	Local cCodPla		:= ConvPlano(trim(cPadrao),Alltrim(PBU->PBU_CDBENE),1)
	Local _cMsg 		:= ""
	Local _cAli 		:= GetNextAlias()
	Local _aArBA1		:= BA1->(GetArea())
	Local _lReat 		:= .T.
	Local _cAliQry	:= GetNextAlias()

	_cQry := "SELECT BA1_CODINT, BA1_CODEMP, BA1_MATRIC, BA1_TIPREG, "	+ CRLF
	_cQry += "BA1_DIGITO, BA1_DATBLO, BA1_TIPUSU" 						+ CRLF
	_cQry += "FROM " + RetSqlName('BA1') + " BA1" 						+ CRLF
	_cQry += "INNER JOIN " + RetSqlName('BA3') + " BA3 "				+ CRLF
	_cQry += "ON BA3_FILIAL = '" + xFilial('BA3') + "' " 				+ CRLF
	_cQry += "  AND BA3_CODINT = BA1_CODINT" 							+ CRLF
	_cQry += "  AND BA3_CODEMP = BA1_CODEMP" 							+ CRLF
	_cQry += "  AND BA3_MATRIC = BA1_MATRIC" 							+ CRLF
	_cQry += "  AND BA3.D_E_L_E_T_ = ' '" 								+ CRLF
	_cQry += "WHERE BA1_FILIAL = '" + xFilial('BA1') + "'" 				+ CRLF
	_cQry += "  AND TRIM(BA3_MATEMP) = '" + ALLTRIM(_cFunc) + "'"		+ CRLF
	_cQry += "  AND BA1_CPFUSR = '" + cCPF + "'"     	            	+ CRLF
	_cQry += "  AND BA1_CODINT = '" + PLSINTPAD() + "'" 				+ CRLF
	_cQry += "  AND BA1_CODEMP = '" + cCodEmp + "'" 					+ CRLF
	_cQry += "  AND BA1_SUBCON = '" + c_Subcon + "'" 					+ CRLF
	_cQry += "  AND BA1_CODPLA = '" + cCodPla + "'" 					+ CRLF
	_cQry += "  AND BA1.D_E_L_E_T_ = ' '" 								+ CRLF

	TcQuery _cQry New Alias _cAlias

	If !_cAlias->(EOF())

		While !EOF()

			//---------------------------------------------------------------------------
			//Validação para saber se o beneficiário informado esta realmente bloqueado
			//---------------------------------------------------------------------------
			If Empty(_cAlias->BA1_DATBLO)

				_cMsg := "Reativacao - Beneficiario nao esta bloqueado para ser reativado"

				Exit

			EndIf

			//---------------------------------------------------------------------------
			//Validação para caso seja dependente, validar se o títular esta bloqueado
			//---------------------------------------------------------------------------
			If AllTrim(UPPER(_cAlias->BA1_TIPUSU)) == "D"

				DbSelectArea("BA1")
				DbSetOrder(1) //BA1_FILIAL+BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPUSU+BA1_TIPREG+BA1_DIGITO
				If DbSeek(xFilial("BA1")+_cAlias->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC)+"T"+_cAlias->(BA1_TIPREG+BA1_DIGITO))

					If !Empty(BA1->BA1_DATBLO)

						//---------------------------------------------------------------------
						//Validação para saber se o títular esta no arquivo para ser reativado
						//---------------------------------------------------------------------
						_cQry += "SELECT PBU_FUNC, PBU_CDBENE, PBU_OPER"				+ CRLF
						_cQry += "FROM " + RetSqlName('PBU') + " PBU" 				+ CRLF
						_cQry += " WHERE PBU_SEQUEN = '" + PBU->PBU_SEQUEN 	+ "' "	+ CRLF
						_cQry += "  AND D_E_L_E_T_ 	= ' '" 							+ CRLF
						_cQry += "  AND PBU_FUNC 	= '" + PBU->PBU_FUNC 	+ "' "	+ CRLF
						_cQry += "  AND PBU_CDBENE 	= '" + PBU->PBU_CDBENE 	+ "' "	+ CRLF

						TcQuery cQry New Alias _cAli

						If _cAli->(EOF())

							_cMsg := "Reativacao - Titular nao encontrado no arquivo para reativacao, titular bloqueado no sistema. "

						Else

							While !(_cAli->(EOF()))

								If _cAli->PBU_OPER == "4"

									_lReat := .T.

									Exit

								EndIf

								_cAli->(DbSkip())

							EndDo

						EndIf

						If !_lReat

							_cMsg := "Reativacao - Titular no arquivo esta com movimentacao diferente de reativacao"

						EndIf

						_cAli->(DbCloseArea())

					EndIf

				EndIf

			EndIf

			//----------------------------------------------------------------------------
			//Validação para saber se o plano encaminhado é o ultimo para o beneficiário
			//Se não for existe a necessidade de criticar
			//----------------------------------------------------------------------------
			_cQry := "SELECT BA1_CODINT, BA1_CODEMP, BA1_MATRIC, BA1_TIPREG, "	+ CRLF
			_cQry += "BA1_DIGITO, BA1_DATBLO, BA1_TIPUSU" 						+ CRLF
			_cQry += "FROM " + RetSqlName('BA1') + " BA1" 						+ CRLF
			_cQry += "INNER JOIN " + RetSqlName('BA3') + " BA3 "					+ CRLF
			_cQry += "ON BA3_FILIAL = '" + xFilial('BA3') + "' " 				+ CRLF
			_cQry += "  AND BA3_CODINT = BA1_CODINT" 								+ CRLF
			_cQry += "  AND BA3_CODEMP = BA1_CODEMP" 								+ CRLF
			_cQry += "  AND BA3_MATRIC = BA1_MATRIC" 								+ CRLF
			_cQry += "  AND BA3.D_E_L_E_T_ = ' '" 									+ CRLF
			_cQry += "WHERE BA1_FILIAL = '" + xFilial('BA1') + "'" 				+ CRLF
			_cQry += "  AND TRIM(BA3_MATEMP) = '" + ALLTRIM(_cFunc) + "'"		+ CRLF
			_cQry += "  AND BA1_CPFUSR = '" + cCPF + "'"     	            	+ CRLF
			_cQry += "  AND BA1_CODINT = '" + PLSINTPAD() + "'" 					+ CRLF
			_cQry += "  AND BA1_CODEMP = '" + cCodEmp + "'" 						+ CRLF
			_cQry += "  AND BA1_SUBCON = '" + c_Subcon + "'" 					+ CRLF
			_cQry += "  AND BA1_CODPLA <> '" + cCodPla + "'" 					+ CRLF
			_cQry += "  AND BA1.D_E_L_E_T_ = ' '" 									+ CRLF

			TcQuery _cQry New Alias _cAliQry

			While !(_cAliQry->(EOF()))

				If Empty(_cAliQry->BA1_DATBLO)

					_cMsg := "Reativacao - Existe para este beneficiário uma matricula Ativa."

					Exit

				EndIf

				If BA1->BA1_DATBLO < CTOD(_cAliQry->BA1_DATBLO)

					_cMsg := "Reativacao - Plano Informado não é o ultimo disponível para este beneficiario"

					Exit

				EndIf

				_cAliQry->(DbSkip())

			EndDo

			_cAliQry->(DbCloseArea())

			_cAlias->(DbSkip())

		EndDo

	Else

		_cMsg := "Reativacao - Beneficiario nao encontrado para ser reativado"

	EndIf

	_cAlias->(DbCloseArea())

	RestArea(_aArBA1)
	RestArea(_aArea)

Return _cMsg

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ºAutor  ³Angelo Henrique     º Data ³  09/05/16   		  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Rotina utilizada para reativar os beneficiário.             º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³PLS                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function CABA336H(cCPF, cCodEmp, c_Funcional, cPadrao)

	Local _aArea 		:= GetArea()
	Local (cAliQry) 	:= GetNextAlias()
	Local cQry			:= ""
	Local _cMatPos		:= ""
	Local _aArBa1		:= BA1->(GetArea())
	Local _aArBca		:= BCA->(GetArea())
	Local _lTitRet 		:= .F.
	Local _dDtBlq		:= CTOD(" / / ")
	Local cCodPla		:= ConvPlano(trim(cPadrao),Alltrim(PBU->PBU_CDBENE),1)

	cQry += "SELECT " 	+ CRLF
	cQry += "	DECODE(BA1.BA1_TIPUSU,'T',1,'D',2 ) TIPO, BA1.BA1_CODINT, BA1.BA1_CODEMP, " 			+ CRLF
	cQry += "	BA1.BA1_MATRIC, BA1.BA1_TIPREG, BA1.BA1_DIGITO, BA1.BA1_TIPUSU, " 						+ CRLF
	cQry += "	BA1.R_E_C_N_O_ RECNO " 																		+ CRLF
	cQry += "FROM " + RetSqlName("BA1") + " BA1" 															+ CRLF
	cQry += "INNER JOIN " + RetSqlName("BA3") + " BA3 ON BA3_FILIAL = '" + xFilial("BA3") + "'" 	+ CRLF
	cQry += "  AND BA3.BA3_CODINT = BA1.BA1_CODINT" 														+ CRLF
	cQry += "  AND BA3.BA3_CODEMP = BA1.BA1_CODEMP" 														+ CRLF
	cQry += "  AND BA3.BA3_MATRIC = BA1.BA1_MATRIC" 														+ CRLF	
	cQry += "  AND BA3.D_E_L_E_T_ = ' '" 																	+ CRLF
	cQry += "WHERE BA1.BA1_FILIAL = '" + xFilial("BA1") + "'" 											+ CRLF
	cQry += "  AND BA1.BA1_CPFUSR = '" + cCPF + "'"     	            									+ CRLF
	cQry += "  AND BA1.BA1_CODINT = '" + PLSINTPAD() + "'" 												+ CRLF
	cQry += "  AND BA1.BA1_CODEMP = '" + cCodEmp + "'" 													+ CRLF
	cQry += "  AND TRIM(BA3.BA3_MATEMP) = '" + alltrim(c_Funcional )+ "'" 							+ CRLF //MBCMIG
	cQry += "  AND BA1.BA1_DATBLO <> ' '" 																	+ CRLF
	cQry += "  AND BA1.BA1_SUBCON = '" + PBT->PBT_SUBCON + "'"											+ CRLF
	cQry += "  AND BA1_CODPLA = '" + cCodPla + "'" 														+ CRLF
	cQry += "  AND BA1.D_E_L_E_T_ = ' '" 																	+ CRLF
	cQry += "  ORDER BY 1              " 																	+ CRLF

	TcQuery cQry New Alias (cAliQry)

	While !(cAliQry)->(EOF())

		_cMatPos := (cAliQry)->BA1_CODINT + (cAliQry)->BA1_CODEMP + (cAliQry)->BA1_MATRIC

		DbSelectArea("BA1")
		DbSetOrder(2)
		If DbSeek(xFilial("BA1") + (cAliQry)->BA1_CODINT + (cAliQry)->BA1_CODEMP + (cAliQry)->BA1_MATRIC + (cAliQry)->BA1_TIPREG + (cAliQry)->BA1_DIGITO)

			//-------------------------------------------------------------------------------
			//Refoçando aqui a validação do bloqueio, porque sea primeira linha for títular
			//a rotina irá bloquear toda a familia logo não haverá necessidade de executar
			//a rotina de bloqueia para o dependente.
			//-------------------------------------------------------------------------------
			If !Empty(BA1->BA1_DATBLO)

				//-------------------------------------------
				//Pegando o ultimo bloqueio efetuado
				//-------------------------------------------
				_dDtBlq := CTOD(" / / ")

				DbSelectArea("BCA")
				DbSetOrder(1) //BCA_FILIAL+BCA_MATRIC+BCA_TIPREG
				If DbSeek(xFilial("BCA")+BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG))

					While BCA->(!EOF()) .And. BCA->(BCA_MATRIC+BCA_TIPREG) = BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG)

						If Empty(AllTrim(_dDtBlq))

							_dDtBlq := BCA->BCA_DATA

						EndIf

						If _dDtBlq < BCA->BCA_DATA

							_dDtBlq := BCA->BCA_DATA

						EndIf

						BCA->(DbSkip())

					EndDo

				EndIf

				If Empty(_dDtBlq)

					_dDtBlq := LastDate(dDataBase)

				EndIf


				If BA1->BA1_TIPUSU == "T"

					_lTitRet := .T.

					//---------------------------------------------------------------------------------------------------
					//Bloqueio e desbloqueio da familia e grupo familiar
					//---------------------------------------------------------------------------------------------------
					//PL260BLOCO(cAlias,nReg,nOpc,lDireto,cMotivo,dData,cBloFat,nP20,aLog,lGrav,lblqAut, lMsg)
					//---------------------------------------------------------------------------------------------------
					// cMotivo - Visualizar a tabela de Motivo de bloqueio Familia (BG1)
					//---------------------------------------------------------------------------------------------------
					PL260BLOCO("BA1", BA1->(Recno()),4,.T.,"004",_dDtBlq,"1",,,,.F.)

					//----------------------------------------------------------------------------------
					//Efetua o bloqueio e desbloqueio de familias que fazem parte do grupo familiar
					//----------------------------------------------------------------------------------
					PlsGrpFam(.F.,.T.,BA1->BA1_CODINT + BA1->BA1_CODEMP + BA1->BA1_MATRIC)

				Else

					//---------------------------------------------------------------------------------------------------
					//Bloquear/Desbloquear Usuario
					//---------------------------------------------------------------------------------------------------
					//PL260BLOUS(cAlias,nReg,nOpc,lDireto,cMotivo,dData,cBloFat,lFiltro,nP20,aLog,lGrav,lMsg)
					//---------------------------------------------------------------------------------------------------
					// cMotivo - Visualizar a tabela de Motivo de bloqueio Usuário (BG3)
					//---------------------------------------------------------------------------------------------------
					PL260BLOUS("BA1", BA1->(Recno()), 4, .T.,"004",_dDtBlq,"1")

				EndIf

			EndIf

		EndIf

		(cAliQry)->(DbSkip())

	EndDo

	//----------------------------------------------------------------------------------------------------
	//Na rotina padrão não é possível desbloquear apenas um usuário caso seja este títular
	//a rotina não entende que é para desbloquar o títular e a BA3(Familia)
	//então após a ativação da familia toda, é necessário bloquear os beneficiários
	//que não estão no arquivo, validando se o títular esta para a reativação, pois assim entendemos que
	//o mesmo estava bloqueado e sua família toda estava bloqueada
	//----------------------------------------------------------------------------------------------------
	If _lTitRet

		BA1->(DbGoTop())
		DbSelectArea("BA1")
		DbSetOrder(2)
		If DbSeek(xFilial("BA1") + _cMatPos) //Ponterando no primeiro Registro desta matricula nesta empresa para validar a situação

			If BA1->BA1_TIPUSU <> "T"

				While !EOF() .And. _cMatPos == BA1->(BA1_CODINT + BA1_CODEMP + BA1_MATRIC)

					_cQry += "SELECT PBU_FUNC, PBU_CDBENE, PBU_OPER"				+ CRLF
					_cQry += "FROM " + RetSqlName("PBU") + " PBU" 				+ CRLF
					_cQry += "WHERE PBU_SEQUEN 	= '" + PBU->PBU_SEQUEN 	+ "' "	+ CRLF
					_cQry += "  AND D_E_L_E_T_ 	= ' '" 							+ CRLF
					_cQry += "  AND PBU_FUNC 	= '" + PBU->PBU_FUNC 	+ "' "	+ CRLF
					_cQry += "  AND PBU_CPF 		= '" + BA1->BA1_CPFUSR 	+ "' "	+ CRLF
					_cQry += "  AND PBU_OPER		= '4' "							+ CRLF

					TcQuery cQry New Alias (cAliQry)

					//-------------------------------------------------------------------------
					//Caso não seja encontrado no arquivo encaminhado pela prefeitura
					//o beneficiário será bloqueado novamente, pois quando o titular
					//esta para ser reativado entende-se que sua familia esta bloqueada
					//e quando a familia é desbloqueada os dependentes também são
					//desbloqueados
					//-------------------------------------------------------------------------
					If (cAliQry)->(EOF())

						//-------------------------------------------
						//Pegando o ultimo bloqueio efetuado
						//-------------------------------------------
						_dDtBlq := CTOD(" / / ")

						DbSelectArea("BCA")
						DbSetOrder(1) //BCA_FILIAL+BCA_MATRIC+BCA_TIPREG
						If DbSeek(xFilial("BCA")+BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG))

							While BCA->(!EOF()) .And. BCA->(BCA_MATRIC+BCA_TIPREG) = BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG)

								If Empty(AllTrim(_dDtBlq))

									_dDtBlq := BCA->BCA_DATA

								EndIf

								If _dDtBlq < BCA->BCA_DATA

									_dDtBlq := BCA->BCA_DATA

								EndIf

								BCA->(DbSkip())

							EndDo

						EndIf

						//Caso não ache BCA cadastrada para o beneficiário por algum erro de cadastro
						If Empty(_dDtBlq)

							_dDtBlq := LastDate(dDataBase)

						EndIf

						//---------------------------------------------------------------------------------------------------
						//Bloquear/Desbloquear Usuario
						//---------------------------------------------------------------------------------------------------
						//PL260BLOUS(cAlias,nReg,nOpc,lDireto,cMotivo,dData,cBloFat,lFiltro,nP20,aLog,lGrav,lMsg)
						//---------------------------------------------------------------------------------------------------
						// cMotivo - Visualizar a tabela de Motivo de bloqueio Usuário (BG3)
						//---------------------------------------------------------------------------------------------------
						PL260BLOUS("BA1", BA1->(Recno()), 4, .T.,"004",_dDtBlq,"1")

					EndIf

					BA1->(DbSkip())

				EndDo

			EndIf

		EndIf

	EndIf

	(cAliQry)->(DbCloseArea())

	RestArea(_aArBca)
	RestArea(_aArBa1)
	RestArea(_aArea)

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABA336I	ºAutor  ³Angelo Henrique     º Data ³  09/05/16	  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Rotina utilizada para validar o bloqueio dos beneficiários. º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³PLS                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function CABA336I(cCPF, cCodEmp, c_Funcional)

	Local _aArea 	:= GetArea() 
	Local _cMsg 	:= ""
	Local (cAliQry) := GetNextAlias()
	Local cQry		:= ""

	cQry += "SELECT " 	+ CRLF
	cQry += "	BA1.BA1_CODINT, BA1.BA1_CODEMP, BA1.BA1_MATRIC, BA1.BA1_TIPREG, BA1.BA1_DIGITO, BA1.BA1_TIPUSU," 	+ CRLF
	cQry += "	BA1.R_E_C_N_O_ RECNO " 																		+ CRLF
	cQry += "FROM " + RetSqlName('BA1') + " BA1" 															+ CRLF
	cQry += "INNER JOIN " + RetSqlName('BA3') + " BA3 ON BA3_FILIAL = '" + xFilial('BA3') + "'" 			+ CRLF
	cQry += "  AND BA3.BA3_CODINT = BA1.BA1_CODINT" 														+ CRLF
	cQry += "  AND BA3.BA3_CODEMP = BA1.BA1_CODEMP" 														+ CRLF
	cQry += "  AND BA3.BA3_MATRIC = BA1.BA1_MATRIC" 														+ CRLF	
	cQry += "  AND BA3.D_E_L_E_T_ = ' '" 																	+ CRLF
	cQry += "WHERE BA1.BA1_FILIAL = '" + xFilial('BA1') + "'" 												+ CRLF
	cQry += "  AND BA1.BA1_CPFUSR = '" + cCPF + "'"     	            									+ CRLF
	cQry += "  AND BA1.BA1_CODINT = '" + PLSINTPAD() + "'" 													+ CRLF
	cQry += "  AND BA1.BA1_CODEMP = '" + cCodEmp + "'" 														+ CRLF
	cQry += "  AND TRIM(BA3.BA3_MATEMP) = '" + alltrim(c_Funcional )+ "'" 									+ CRLF //MBCMIG	
	cQry += "  AND BA1.D_E_L_E_T_ = ' '" 																	+ CRLF
	
	//Leonardo Portella - 29/11/16 - Início - Chamado ID 32859 - Inclusão do ORDER BY pois estava trazendo o bloqueado primeiro e 
	//criticando sempre os novos bloqueios, mesmo quando havia uma matrícula ativa
	
	cQry += "ORDER BY BA1_DATBLO" 																			+ CRLF

	//Leonardo Portella - 29/11/16 - Fim
	 
	TcQuery cQry New Alias (cAliQry)

	If !(cAliQry)->(EOF())

		DbSelectArea("BA1")
		DbSetOrder(2)
		If DbSeek(xFilial("BA1") + (cAliQry)->BA1_CODINT + (cAliQry)->BA1_CODEMP + (cAliQry)->BA1_MATRIC + (cAliQry)->BA1_TIPREG + (cAliQry)->BA1_DIGITO)

			//-------------------------------------------------------------------------------
			//Refoçando aqui a validação do bloqueio, porque se a primeira linha for títular
			//a rotina irá bloquear toda a familia logo não haverá necessidade de executar
			//a rotina de bloqueia para o dependente.
			//-------------------------------------------------------------------------------
			If Empty(BA1->BA1_DATBLO)

				If BA1->BA1_DATINC > LastDate(dDataBase)

					_cMsg := "BLOQUEIO - Beneficiário com data de inclusão futura."					

				EndIf

			Else

				_cMsg := "BLOQUEIO - Beneficiário já bloqueado."

			EndIf

		EndIf

	EndIf

	(cAliQry)->(DbCloseArea())

Return _cMsg
