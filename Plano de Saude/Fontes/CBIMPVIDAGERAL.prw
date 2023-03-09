#INCLUDE 'RWMAKE.CH'
#INCLUDE 'PLSMGER.CH'
#INCLUDE 'COLORS.CH'
#INCLUDE 'TOPCONN.CH'
#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'TBICONN.CH'

#DEFINE cEnt Chr(13)+Chr(10)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ IMPVIDA  ºAutor  ³ Antonio de Padua   º Data ³  10/05/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Importa usuarios de empresas incluindo alterando e 		  º±±
±±º          ³   excluindo.                                           	  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

// Dominio do campo ZZ1_OPER
// ZZ1_OPER == "01" // Incluir
// ZZ1_OPER == "02" // Alteracoes
// ZZ1_OPER == "03" // Bloqueio de beneficiario
// ZZ1_OPER == "04" // Mudanca de empresa (modificar o subcontrato - transferir)
// ZZ1_OPER == "05" // Mudanca de plano (tranferir)
// ZZ1_OPER == "06" // Desbloqueio de beneficiario.
// ZZ1_OPER == "07" // Transferencia de beneficiario.

User Function IMPVIDA()
	
	Private aRotina := {	{ "Pesquisar"	, 'AxPesqui'	, 0 , K_Pesquisar  },;
							{ "Visualizar"	, 'AxVisual'	, 0 , K_Visualizar },;
							{ "I&mportar"	, 'U_IMPINS'    , 0 , K_Incluir    },;
							{ "&Excluir"	, 'U_IMPEXC'    , 0 , K_Excluir    },;
							{ "C&riticar"	, 'U_IMPCRI'    , 0 , K_Incluir    },;
							{ "&Vis. Crit."	, 'U_IMPVCRI'   , 0 , K_Incluir    },;
							{ "&Inserir BD"	, 'U_IMPAPP'    , 0 , K_Incluir    },;
							{ "Ex&portar"	, 'U_IMPEXP'    , 0 , K_Incluir    },;
							{ "&Composicao"	, 'U_IMPCMP'    , 0 , K_Incluir    },;
							{ "Rel. Status"	, 'U_CABR244()' , 0 , K_Visualizar },;
							{ "Legenda"     , "U_IMPLEG(1)"	, 0 , K_Incluir     } }
	
	Private cCadastro 	:= "Importacao de Arquivos com Massa de Vida"
	
	Private aCdCores  	:= { 	{ 'BR_CINZA'	, 'Arquivo Importado' 							},;
								{ 'BR_AMARELO'  , 'Arquivo Analisado SEM Criticas' 				},;
								{ 'BR_VERMELHO' , 'Arquivo Analisado COM Criticas'  			},;
								{ 'BR_VERDE'   	, 'Arquivo Totalmente Inserido na Base'      	},;
								{ 'BR_LARANJA'  , 'Arquivo Parcialmente Inserido na Base'    	},;
								{ 'BR_AZUL'    	, 'Arquivo Exportado'             				} }
	
	Private aCores      := { 	{ 'ZZ0_STATUS = "1"'	, aCdCores[1,1] },;
								{ 'ZZ0_STATUS = "2"'	, aCdCores[2,1] },;
								{ 'ZZ0_STATUS = "3"'	, aCdCores[3,1] },;
								{ 'ZZ0_STATUS = "4"'	, aCdCores[4,1] },;
								{ 'ZZ0_STATUS = "5"'	, aCdCores[5,1] },;
								{ 'ZZ0_STATUS = "6"'	, aCdCores[6,1] }}
	
	Private cPath  		:= ""
	Private cArt3031 	:= ""
	
	//BIANCHINI - 06/03/2015 - Localiza no Cadastro de Operador do Sistema se tem amarracao com a empresa para restringir o Browse
	cSql := " SELECT TRIM(BXR_CODEMP) CODEMP "
	cSql += "   FROM "+RetSQLName("BX4")+" BX4 "
	cSql += "      , "+RetSQLName("BXR")+" BXR "
	cSql += "  WHERE BX4_FILIAL = '"+xFilial("BX4")+"'"
	cSql += "    AND BXR_FILIAL = '"+xFilial("BXR")+"'"
	cSql += "    AND BX4_CODINT = '"+PlsIntPad()+"'"
	cSql += "    AND BX4_CODOPE = '"+RetCodUsr()+"'"
	cSql += "    AND BX4_CODINT = BXR_CODINT "
	cSql += "    AND BX4_CODOPE = BXR_CODOPE "
	cSql += "    AND BXR_ACEEMP = '1'        "
	cSql += "    AND BX4.D_E_L_E_T_ = ' '    "
	cSql += "    AND BXR.D_E_L_E_T_ = ' ' "  "
	
	PLSQuery(cSql,"SqlCor")
	
	If Empty(SqlCor->CODEMP)
		cEmpCorretor := ''
	Else
		cEmpCorretor := SqlCor->CODEMP
	EndIf
	
	SqlCor->(DBCloseArea())
	
	ZZ0->(DBSetOrder(1))
	
	//BIANCHINI - 06/03/2015 - Controle de Empresa do Usuario logado para filtrar o Browse
	If !Empty(cEmpCorretor)
		cFilter := "ZZ0_CODEMP == '"+cEmpCorretor+"'"
		ZZ0->(DbSetFilter({||&cFilter},cFilter))
	EndIf
	
	ZZ0->(mBrowse(006,001,022,075,"ZZ0" , , , , , Nil    , aCores, , , ,nil, .T.))
	
	ZZ1->(DbClearFilter())
	
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ IMPINS   ºAutor  ³ Antonio de Padua   º Data ³  10/05/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Importa Arquivo de Usuario para Layout Padrao ZZ0 		  º±±
±±º          ³   			                                        	  º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function IMPINS(cAlias,nReg,nOpc)
	
	Local I__f		:= 0		//	Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS
	
	Local oDlg
	Local nOpca   	:= 0
	Local oEnc
	Local bOK     	:= { || nOpca := 1, oDlg:End() }
	Local bCancel 	:= { || nOpca := 0, oDlg:End() }
	Local c__Sequen	:= ''
	
	aSize 			:= MsAdvSize()
	aInfo 			:= {aSize[1], aSize[2], aSize[3], aSize[4], 3, 3}
	
	aObjects		:= {}
	aAdd( aObjects, { 100 , 100	, .T., .T. } )
	
	aPosObj 		:= MsObjSize( aInfo, aObjects,.T.)
	
	cAlias := "ZZ0"
	
	DEFINE MSDIALOG oDlg TITLE cCadastro FROM aSize[7],00 To aSize[6],aSize[5] PIXEL
	
	Copy cAlias To Memory Blank
	
	oEnc := ZZ0->(MsMGet():New(cAlias,nReg,nOpc,,,,,{aPosObj[1][1],aPosObj[1][2],aPosObj[1][3]-15,aPosObj[1][4]-3},,,,,,oDlg,,,.F.))
	
	ACTIVATE MSDIALOG oDlg ON INIT EnchoiceBar(oDlg,bOK,bCancel,.F.,{})
	
	If nOpca == K_OK
		
		M->ZZ0_QTDLID 	:= IMPIMP(oEnc:aGets,oEnc:aTela,M->ZZ0_NOMARQ,oDlg)
		M->ZZ0_DTIMPO 	:= dDatabase
		
		c__Sequen 		:= M->ZZ0_SEQUEN
		
		ZZ0->(PLUPTENC("ZZ0",K_Incluir))
		
		ZZ0->(DbCommit())	// Leonardo Portella - 16/02/17 - Em alguns casos nao localizava o ZZ0 recém incluído.
		ZZ1->(DbCommit())	// Leonardo Portella - 16/02/17 - Em alguns casos nao localizava o ZZ1 recém incluído.
		
	EndIf
	
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ IMPIMP   ºAutor  ³ Antonio de Padua   º Data ³  10/05/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Trata rotina externa								 		  º±±
±±º          ³   			                                        	  º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function IMPIMP(aGets,aTela,cNomArq,oDlg)
	
	Local j				:= 0	// Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS
	Local i				:= 0	// Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS
	
	Local aCamposImp	:= {}
	Local nRet			:= 0
	
	Private nBytes		:= 0
	
	If !Obrigatorio(aGets,aTela)
		Return(nRet)
	EndIf
	
	If Empty(M->ZZ0_NOMARQ)
		Help(" ",1,"NOFLEIMPOR")
		Return(nRet)
	End
	
	cCodUsr	:= RetCodUsr()
	
	// Fabio Bianchini - 05/03/2015 - Estipulando pasta no C:\IMP_CORRETORES para usuarios que acessam protheus via TERMINAL
	If cCodUsr == '001349' .or. cCodUsr == '001727'		//001349 - carlos.qualivida e 001727 - FRED (GETIN) para testes
		cPath := "C:\IMP_CORRETORES\"
	Else
		// Fabio Bianchini - 20/09/2010 - Apesar deste nome sugerir INTEGRAL, foi criado com mesmo nome na CABERJ
		// para nao ter que efetuar nenhuma alteracao na rotina em face a prazo que esta expirado.
		cPath := GetNewPar("MV_YIMPIN","C:\")
	EndIf
	
	If Substr(cPath,Len(cPath),1) <> "\"
		cPath := cPath + "\"
	EndIf
	
	nHdlImp := FOpen(cPath+M->ZZ0_NOMARQ,64)
	
	If nHdlImp == -1
		Help(" ",1,"NOFLEIMPOR")
		Return(nRet)
	EndIf
	
	//Preencho a matriz com os campos da Importacao
	PreencheCmp(@aCamposImp)
	
	xBuffer   :=  ""
	
	nTamArq:= FSeek(nHdlImp,0,2)
	
	FSeek(nHdlImp,0,0)			// Vou para o inicio do arquivo
	
	cRet 	:= "00"
	
	nCont 	:= 0
	
	ProcRegua(nTamArq)
	
	While nBytes < nTamArq		// Leonardo Portella - 17/02/16
		
		// Leonardo Portella - 09/06/16 - Inicio - Implementacao para tamanho dinamico de linha e com possibilidade de
		// linha com mais de 1024 bytes (nao da pra usar as funcoes FT_ por limitacao das mesmas)
		
		//xBuffer	:= Space(nTamLinha)
		//FREAD(nHdlImp,@xBuffer,nTamLinha)
		
		nTamLinha 	:= 3000					// Defino o tamanho da linha alto para pegar a quebra de linha
		xBuffer		:= Space(nTamLinha)
		FREAD(nHdlImp, @xBuffer, nTamLinha)
		
		nTamLinha 	:= At(CHR(10), xBuffer) // Acho a quebra de linha
		FSeek(nHdlImp, nBytes, 0)			// Volto para o ultimo byte lido
		
		xBuffer		:= Space(nTamLinha)
		FREAD(nHdlImp, @xBuffer, nTamLinha)	// Leio a quantidade de bytes dinamicamente conforme a quebra
		// Leonardo Portella - 09/06/16 - Fim
		
		//Uso a matriz de campos para preencher arquivos da importacao
		For I:= 1 to Len(aCamposImp[1])
			
			If Substr(xBuffer,1,Len(aCamposImp[1,I,1])) == aCamposImp[1,I,1]
				
				If aCamposImp[1,I,3] > "" .and. aCamposImp[1,I,3] <> "M"
					&(aCamposImp[1,I,3]+"->(RecLock('"+aCamposImp[1,I,3]+"',.T.))")
					&(aCamposImp[1,I,3]+"->ZZ1_SEQUEN := M->ZZ0_SEQUEN")
					&(aCamposImp[1,I,3]+"->ZZ1_NUMLIN := StrZero(nBytes/nTamLinha,6)")
				EndIf
				
				For J:= 1 to Len(aCamposImp[1,I,2])
					
					xBuffer := LIMPALIN(xBuffer) // Paulo Motta 15/02/07
					
					&(aCamposImp[1,I,3]+"->"+aCamposImp[1,I,2,J,4]) := Substr(xBuffer,aCamposImp[1,I,2,J,2],aCamposImp[1,I,2,J,3])
					
				Next J
				
				If aCamposImp[1,I,3] > "" .and. aCamposImp[1,I,3] <> "M"
					&(aCamposImp[1,I,3]+"->ZZ1_OPERSI := U_VEROPE()")
				EndIf
				
			EndIf
			
		Next I
		
		For I:= 1 to Len(aCamposImp[1])
			
			If aCamposImp[1,I,3] > "" .and. Substr(xBuffer,1,Len(aCamposImp[1,I,1])) == aCamposImp[1,I,1] .and. aCamposImp[1,I,3] <> "M"
				&(aCamposImp[1,I,3]+"->(MsUnlock())")
			EndIf
			
		Next I
		
		nBytes += nTamLinha
		nRet++
		
	EndDo
	
	//Fecha o Arquivo
	FCLOSE(nHdlImp)
	
Return(nRet)


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ IMPEXC   ºAutor  ³ Antonio de Padua   º Data ³  10/05/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Exclui o arquivo e sua composicao				 		  º±±
±±º          ³   			                                        	  º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function IMPEXC(cAlias,nReg,nOpc)
	
	Local I__f		:= 0			// Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS
	Local oDlg
	Local nOpca		:= 0
	Local oEnc
	Local bOK		:= { || nOpca := 1, oDlg:End() }
	Local bCancel	:= { || oDlg:End() }
	Local cSeq		:= ZZ0->ZZ0_SEQUEN
	Local cSQL, lDeleta
	
	DEFINE MSDIALOG oDlg TITLE cCadastro FROM ndLinIni,000 TO ndLinFin,ndColFin OF GetWndDefault()
	
	Copy cAlias To Memory
	
	oEnc := ZZ0->(MsMGet():New(cAlias,nReg,K_Visualizar,,,,,{015,004,192,390},,,,,,oDlg,,,.F.))
	
	ACTIVATE MSDIALOG oDlg ON INIT EnchoiceBar(oDlg,bOK,bCancel,.F.,{})
	
	If nOpca == K_OK
		
		If M->ZZ0_STATUS $ "4|5"
			MsgInfo("Nao e possivel excluir pois este arquivo ja foi inserido no BD !")
			lDeleta := .F.
		Else
			lDeleta := .T.
		EndIf
		
		If lDeleta
			
			BEGIN TRANSACTION
				
				//-------------------------------------------------------------------
				//INICIO - Angelo Henrique - Data: 11/10/2017
				//-------------------------------------------------------------------
				// Atendendo a solicitacao do cadastro, irei deixar deletado os arquivos
				// pois no modelo atual nao fica registro historico para analise
				//-------------------------------------------------------------------
				
				cSQL := "UPDATE " + RetSQLName("ZZ1") + " SET D_E_L_E_T_ = '*'"
				cSQL += "WHERE ZZ1_SEQUEN = '"+cSeq+"' AND D_E_L_E_T_ = ' '"
				PLSSQLEXEC(cSQL)
				
				cSQL := "UPDATE " + RetSQLName("ZZ2") + " SET D_E_L_E_T_ = '*'"
				cSQL += "WHERE ZZ2_SEQUEN = '"+cSeq+"' AND D_E_L_E_T_ = ' '"
				PLSSQLEXEC(cSQL)
				
				cSQL := "UPDATE " + RetSQLName("ZZ0") + " SET D_E_L_E_T_ = '*', ZZ0_USUEXC = '" + CUSERNAME + "', "
				cSQL += " ZZ0_DTEXC = '" + DTOS(dDatabase) + "'"				// Angelo Henrique - Data: 11/10/2017
				cSQL += "WHERE ZZ0_SEQUEN = '"+cSeq+"' AND D_E_L_E_T_ = ' '"
				PLSSQLEXEC(cSQL)
				
				//-------------------------------------------------------------------
				//FIM - Angelo Henrique - Data: 11/10/2017
				//-------------------------------------------------------------------
				
			END TRANSACTION
			
		EndIf
		
	EndIf
	
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ IMPCRI   ºAutor  ³ Antonio de Padua   º Data ³  10/05/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Critica Arquivo ja importado						 		  º±±
±±º          ³   			                                        	  º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function IMPCRI(cAlias,nReg,nOpc)
	
	Local n 			:= 0					// Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS
	Local aCampos 		:= {}
	Local l1vez   		:= .F.
	Local nSeqErro 		:= 0
	Local cSeq     		:= 0
	Local cErro 		:= space(0)
	Local aErro 		:= {}
	Local aArqErro 		:= {}
	Local cSql 			:= ""
	Local cTipCri 		:= ""
	Local lAchouCrit	:= .F.
	Local _cFamDsb		:= ""					// Angelo Henrique - Data:16/12/2016
	Local _cGrauPA		:= ""					// Angelo Henrique - Data:09/06/2017
	Local _aAreZZ1		:= Nil					// Angelo Henrique - Data:09/06/2017
	Local _aArBA1		:= Nil					// Angelo Henrique - Data:03/07/2017
	Local _cLibBlq 		:= GETMV("MV_XLIBBLQ")	//Angelo Henrique - Data: 01/09/2017
	Local _cAlias1		:= GetNextAlias()
	
	// Inicio o processo de criticas
	If Val(ZZ0->ZZ0_STATUS) <= 3 //Permite criticar arquivos importados e/ou criticados
		
		// Verifica se a sequencia corresponde a esperada
		cSql := "SELECT MAX(Z0.ZZ0_SEQARQ) SEQMAX "
		cSql += " FROM  "+RetSqlName("ZZ0")+" Z0 "
		cSql += " WHERE D_E_L_E_T_=' '"
		cSql += " AND   Z0.ZZ0_FILIAL = '  '"
		cSql += " AND   Z0.ZZ0_CTREMP = '" + ZZ0->ZZ0_CTREMP + "' "
		cSql += " AND   Z0.ZZ0_SEQUEN <> '" +ZZ0->ZZ0_SEQUEN + "' "
		
		PLsQuery(cSql,"TMPSEQ")
		
		If !TMPSEQ->(EOF())
			cSeq := Val(TMPSEQ->SEQMAX) + 1
		EndIf
		
		TMPSEQ->(DbCloseArea())
		
		ZZ1->(DbCommit())		//Leonardo Portella - Chamado 33135 - Intermitente: Nao está gravando a composicao com a tela aberta, somente apos fechar.
		ZZ1->(DbSetOrder(2))
		ZZ1->(DbGoTop())
		If !ZZ1->(DbSeek(xFilial("ZZ1") + ZZ0->ZZ0_SEQUEN))
			MsgStop('Nao foi localizada composicao para o arquivo com sequencial [ ' + cValToChar(ZZ0->ZZ0_SEQUEN) + ' ]',Alltrim(SM0->M0_NOMECOM))
		Else
			
			//FABIO BIANCHINI - 30/07/2014
			//PEGAR VERSAO DO CONTRATO E DO SUBCONTRATO DA EMPRESA NO ARQUIVO DE IMPORTACAO
			cVerCon := chkVerConSub(ZZ0->ZZ0_CODOPE,ZZ0->ZZ0_CODEMP,ZZ0->ZZ0_NUMCON,ZZ0->ZZ0_SUBCON,'C')
			cVerSub := chkVerConSub(ZZ0->ZZ0_CODOPE,ZZ0->ZZ0_CODEMP,ZZ0->ZZ0_NUMCON,ZZ0->ZZ0_SUBCON,'S')
			//FIM
			
			//Deleta todas as linhas de erro anteriores do arquivo...
			BEGIN TRANSACTION
				
				cSQL := "DELETE FROM " + RetSQLName("ZZ2")+" "
				cSQL += "WHERE ZZ2_SEQUEN = '"+ZZ0->ZZ0_SEQUEN+"' AND D_E_L_E_T_ = ' '"
				PLSSQLEXEC(cSQL)
				
			END TRANSACTION
			
			While !ZZ1->(EOF()) .and. ( ZZ1->ZZ1_SEQUEN == ZZ0->ZZ0_SEQUEN )
				
				aErro 		:= {}
				cErro 		:= Space(0)
				cDescr 		:= Space(0)
				cCtrProc 	:= Space(0)
				
				//Iniciar o processo de criticas campo por campo
				
				If !( AllTrim(ZZ1->ZZ1_OPER) $ '01_02_03_04_05_06_07' )
					cCtrProc 	:= "E"
					cErro 		:= cErro + "001"   //Tipo Operacao Invalido
					aAdd(aErro, {ZZ0->ZZ0_SEQUEN, ZZ1->ZZ1_NUMLIN, "001", "Tipo Operacao Invalido",cCtrProc})
				EndIf
				//BIANCHINI - 16/10/2019 - Tratamento para aceitar Alfanuméricos na empresa 0330 da Integral
				//If Type(ZZ1->ZZ1_FUNC) <> 'N'
				If Type(ZZ1->ZZ1_FUNC) <> 'N' .AND. !(cEmpAnt == "02" .AND. ZZ1->ZZ1_CODEMP == "0330")
					cCtrProc 	:= "E"
					cErro 		:= cErro + "002"  //Funcional Invalida
					aAdd(aErro, {ZZ0->ZZ0_SEQUEN, ZZ1->ZZ1_NUMLIN, "002", "Funcional Invalida",cCtrProc})
				EndIf
				
				If !( AllTrim(ZZ1->ZZ1_OPER) $ '01_06_07' ) .and. ( !lExisteBA3(AllTrim(ZZ1->ZZ1_FUNC)) .or. !lExisteBA1(AllTrim(ZZ1->(ZZ1_FUNC+ZZ1_DEPEND)),'01') )
					cCtrProc 	:= "E"
					cErro 		:= cErro + "003"   //Func. Inexist. ou Ja Bloqueada no Subcontrato
					aAdd(aErro, {ZZ0->ZZ0_SEQUEN, ZZ1->ZZ1_NUMLIN, "003", "Func. Inexist. ou Ja Bloqueada no Subcontrato",cCtrProc})
				EndIf
				
				If !( ZZ1->ZZ1_DEPEND >= '00' .and. ZZ1->ZZ1_DEPEND <= '99' )
					cCtrProc 	:= "E"
					cErro 		:= cErro + "004"   //Codigo Dependente Invalido
					aAdd(aErro, {ZZ0->ZZ0_SEQUEN, ZZ1->ZZ1_NUMLIN, "004", "Codigo Dependente Invalido",cCtrProc})
				EndIf
				
				//----------------------------------------------------------------------------------
				//INICIO - Angelo Henrique - Data: 09/06/2017
				//Colocado GetArea pois, em alguns momentos estava se predendo na ZZ1
				//----------------------------------------------------------------------------------
				_aAreZZ1 := ZZ1->(GetArea())
				
				If !( AllTrim(ZZ1->ZZ1_OPER) $ '01_04_07' ) .and. ;
						( 	;
						!lVerFunc(If(ZZ1->ZZ1_CDBENE == 'T',AllTrim(ZZ1->ZZ1_FUNC)+'00',AllTrim(ZZ1->(ZZ1_FUNC+ZZ1_DEPEND))),ZZ1->ZZ1_CDBENE, , ,ZZ1->(ZZ1_SEQUEN+AllTrim(ZZ1_FUNC)+ZZ1_OPER)) ;
						.or.;
						!lVerBA1(AllTrim(ZZ1->(ZZ1_FUNC+ZZ1_DEPEND))) ;
						)
					cCtrProc 	:= "E"
					cErro 		:= cErro + "005"  //Codigo Dependente nao Existe na Base
					aAdd(aErro, {ZZ0->ZZ0_SEQUEN, ZZ1->ZZ1_NUMLIN, "005", "Codigo Dependente nao Existe na Base",cCtrProc})
				EndIf
				
				RestArea(_aAreZZ1)
				
				//----------------------------------------------------------------------------------
				//FIM - Angelo Henrique - Data: 09/06/2017
				//----------------------------------------------------------------------------------
				
				If ( AllTrim(ZZ1->ZZ1_OPER) $ '01_02_07' ) .and. Empty(AllTrim(ZZ1->ZZ1_BENEF))
					cCtrProc 	:= "E"
					cErro 		:= cErro + "006"  //Nome do Beneficiario Invalido
					aAdd(aErro, {ZZ0->ZZ0_SEQUEN, ZZ1->ZZ1_NUMLIN, "006", "Nome do Beneficiario Invalido",cCtrProc})
				EndIf
				
				If ( AllTrim(ZZ1->ZZ1_OPER) $ '01_02_07' ) .and. !(lStrData(ZZ1->ZZ1_DTNASC))
					cCtrProc 	:= "E"
					cErro 		:= cErro + "009" //Data de Nascimento Invalido
					aAdd(aErro, {ZZ0->ZZ0_SEQUEN, ZZ1->ZZ1_NUMLIN, "009", "Data de Nascimento Invalido",cCtrProc})
				EndIf
				
				//Leonardo Portella - 25/01/17 - Incluï¿½dos U (tio) e N (neto) e B (sobrinho)
				If ( AllTrim(ZZ1->ZZ1_OPER) $ '01_02_07' ) .and. ( ZZ1->ZZ1_CDBENE <> 'T' ) .and. ( At(AllTrim(ZZ1->ZZ1_TPPARE),'C_F_T_E_O_P_M_I_H_S_G_U_N_B_Q') <= 0 )
					cCtrProc 	:= "E"
					cErro 		:= cErro + "012"   //Tipo Parentesco Invalido
					aAdd(aErro, {ZZ0->ZZ0_SEQUEN, ZZ1->ZZ1_NUMLIN, "012", "Tipo Parentesco Invalido",cCtrProc})
				EndIf
				
				If ( AllTrim(ZZ1->ZZ1_OPER) $ '01_02_07' ) .and. ( At(AllTrim(ZZ1->ZZ1_TPBENE),'01_02_03_04_05_06_07_08_09') <= 0 )
					cCtrProc 	:= "E"
					cErro 		:= cErro + "013"   // Tipo Beneficiario Invalido
					aAdd(aErro, {ZZ0->ZZ0_SEQUEN, ZZ1->ZZ1_NUMLIN, "013", "Tipo Beneficiario Invalido",cCtrProc})
				EndIf
				
				If ( AllTrim(ZZ1->ZZ1_OPER) $ '01_02_07' ) .and. ( At(AllTrim(ZZ1->ZZ1_CDBENE),'T_L_A') <= 0 )
					cCtrProc 	:= "E"
					cErro 		:= cErro + "014"  //Condicao Beneficiario Invalido
					aAdd(aErro, {ZZ0->ZZ0_SEQUEN, ZZ1->ZZ1_NUMLIN, "014", "Condicao Beneficiario Invalido",cCtrProc})
				EndIf
				
				If ( AllTrim(ZZ1->ZZ1_OPER) $ '01_02_07' ) .and. ( At(AllTrim(ZZ1->ZZ1_SEXO),'F_M') <= 0 )
					cCtrProc 	:= "E"
					cErro 		:= cErro + "015"   //Sexo Invalido
					aAdd(aErro, {ZZ0->ZZ0_SEQUEN, ZZ1->ZZ1_NUMLIN, "015", "Sexo Invalido",cCtrProc})
				EndIf
				
				If ( AllTrim(ZZ1->ZZ1_OPER) $ '01_02_07' ) .and. ( At(AllTrim(ZZ1->ZZ1_ESTCIV),'S_C_R_V_M_J') <= 0 )
					cCtrProc 	:= "E"
					cErro 		:= cErro + "016"  //Estado civil invalido
					aAdd(aErro, {ZZ0->ZZ0_SEQUEN, ZZ1->ZZ1_NUMLIN, "016", "Estado civil invalido",cCtrProc})
				EndIf
				
				If 	( AllTrim(ZZ1->ZZ1_OPER) $ '01_02_07' )
					
					//Leonardo Portella - 17/08/16 - CPF do titular, dependente ou preposto sao informados no campo ZZ1_CPF. Nao importa qual seja, deve
					//sempre ser informado e ser valido. - Iníio
					
					If ( Empty(ZZ1->ZZ1_CPF) .or. !CGC(ZZ1->ZZ1_CPF,,.F.) )
						
						cCtrProc 	:= "E"
						
						If AllTrim(ZZ1->ZZ1_CPFPRE) <> 'S'
							cErro 		:= cErro + "017"
							aAdd(aErro, {ZZ0->ZZ0_SEQUEN, ZZ1->ZZ1_NUMLIN, "017", "CPF Invalido",cCtrProc})
						Else
							cErro 		:= cErro + "018"
							aAdd(aErro, {ZZ0->ZZ0_SEQUEN, ZZ1->ZZ1_NUMLIN, "018", "CPF Preposto Invalido",cCtrProc})
						EndIf
						
					EndIf
					
					//Leonardo Portella - 17/08/16 - Fim
					
				EndIf
				
				//Leonardo Portella - 13/07/16 - Inicio
				
				If ( Empty(ZZ1->ZZ1_PIS) )
					
					If ( ( AllTrim(ZZ1->ZZ1_OPER) <> "03" ) .and. !chkMae(AllTrim(ZZ1->ZZ1_NOMMAE), AllTrim(ZZ1->(ZZ1_FUNC+ZZ1_DEPEND))) )
						cCtrProc 	:= "E"
						cErro 		:= cErro + "025"
						aAdd(aErro, {ZZ0->ZZ0_SEQUEN, ZZ1->ZZ1_NUMLIN, "025", "PIS Invalido. Verifique PIS/Nome Mae",cCtrProc})
					EndIf
					
				ElseIf ( len(AllTrim(ZZ1->ZZ1_PIS)) <> 11 )
					
					cCtrProc 	:= "E"
					cErro 		:= cErro + "025"
					aAdd(aErro, {ZZ0->ZZ0_SEQUEN, ZZ1->ZZ1_NUMLIN, "025", "Tamanho PIS Invalido. Verifique PIS",cCtrProc})
					
				ElseIf !U_lVldPisPasep(AllTrim(ZZ1->ZZ1_PIS))//( AllTrim(ZZ1->ZZ1_PIS) $ '00000000000|11111111111|22222222222|33333333333|44444444444|55555555555|66666666666|77777777777|88888888888|99999999999' )
					
					cCtrProc 	:= "E"
					cErro 		:= cErro + "025"
					aAdd(aErro, {ZZ0->ZZ0_SEQUEN, ZZ1->ZZ1_NUMLIN, "025", "PIS/PASEP Invalido. Verifique",cCtrProc})
					
					// Leonardo Portella - 16/11/16 - PIS/PASEP nao é obrigatï¿½rio (exceto quando nao houver nome da mae).
					// Quando nao preenchido, o CBI povoa com zeros mas isso gera erro no SIB.
					
				ElseIf !empty(AllTrim(ZZ1->ZZ1_NOMMAE)) .and. ( At('0',ZZ1->ZZ1_PIS) > 0 ) .and. empty(Replace(ZZ1->ZZ1_PIS,'0',''))
					
					ZZ1->(Reclock('ZZ1',.F.))
					ZZ1->ZZ1_PIS := ''
					ZZ1->(MsUnlock())
					
				EndIf
				
				//Leonardo Portella - 13/07/16 - Fim
				
				//Verifica se o preenchimento do nome da mae causa ou nao a rejeicao do registro dependendo da operacao a ser realizada.
				If !chkMae(AllTrim(ZZ1->ZZ1_NOMMAE), AllTrim(ZZ1->(ZZ1_FUNC+ZZ1_DEPEND))) .and. ( AllTrim(ZZ1->ZZ1_OPER) <> "03" )
					cCtrProc 	:= "E"
					cErro 		:= cErro + "026"
					aAdd(aErro, {ZZ0->ZZ0_SEQUEN, ZZ1->ZZ1_NUMLIN, "026", "Nome da Mae Invalido",cCtrProc})
				EndIf
				
				If Empty(AllTrim(ZZ1->ZZ1_CONTR))
					cCtrProc 	:= "E"
					cErro 		:= cErro + "027"  //Codigo do Contrato Invalido
					aAdd(aErro, {ZZ0->ZZ0_SEQUEN, ZZ1->ZZ1_NUMLIN, "027", "Codigo do Contrato Invalido",cCtrProc})
				EndIf
				
				If ( AllTrim(ZZ1->ZZ1_OPER) $ '01_02_07' ) .and. ;
						!chkPadrao(ZZ1->ZZ1_PADRAO,ZZ1->ZZ1_OPER,AllTrim(ZZ1->ZZ1_FUNC),ZZ1->ZZ1_DEPEND,DParaTpBnf(ZZ1->ZZ1_CDBENE))  //Verifica em qual produto Saude ira alocar o beneficiario
					cCtrProc 	:= "E"
					cErro 		:= cErro + "028"   //Codigo Padrao Invalido - 0001 - Apartamento, 0002 - Enfermaria
					aAdd(aErro, {ZZ0->ZZ0_SEQUEN, ZZ1->ZZ1_NUMLIN, "028", "Codigo Padrao Invalido - 0001 - Apartamento, 0002 - Enfermaria",cCtrProc})
				EndIf
				
				If ( AllTrim(ZZ1->ZZ1_OPER) $ '01_02_07' ) .and. Empty(AllTrim(ZZ1->ZZ1_NOMEMP))
					cCtrProc 	:= "E"
					cErro 		:= cErro + "033"   //Nome do Orgao Invalido
					aAdd(aErro, {ZZ0->ZZ0_SEQUEN, ZZ1->ZZ1_NUMLIN, "033", "Nome do Orgao Invalido",cCtrProc})
				EndIf
				
				If ( AllTrim(ZZ1->ZZ1_OPER) == '03' ) .and. ;
						!chkData(AllTrim(ZZ1->ZZ1_FUNC),ZZ1->ZZ1_DTEXC,3) .and. ;
						Empty(ctod(ZZ1->ZZ1_DTEXC) )
					
					cCtrProc := "E"
					cErro := cErro + "036"   //Data da Exclusao no Plano Invalida
					aAdd(aErro, {ZZ0->ZZ0_SEQUEN, ZZ1->ZZ1_NUMLIN, "036", "Data da Exclusao no Plano Invalida",cCtrProc})
				EndIf
				
				If ( AllTrim(ZZ1->ZZ1_OPER) $ '01_02_07') .and. ;
						!chkData(AllTrim(ZZ1->ZZ1_FUNC),ZZ1->ZZ1_DTINPD,1) .and. ;
						Empty(ctod(ZZ1->ZZ1_DTINPD) )
					
					cCtrProc 	:= "E"
					cErro 		:= cErro + "034"   //Data Inclusao Invalida
					aAdd(aErro, {ZZ0->ZZ0_SEQUEN, ZZ1->ZZ1_NUMLIN, "034", "Data Inclusao Invalida",cCtrProc})
				EndIf
				
				If ( AllTrim(ZZ1->ZZ1_OPER) $ '01_02_07' ) .and. Empty(AllTrim(ZZ1->ZZ1_LOGRAD))
					cCtrProc 	:= "E"
					cErro 		:= cErro + "038"   //Logradouro Invalido
					aAdd(aErro, {ZZ0->ZZ0_SEQUEN, ZZ1->ZZ1_NUMLIN, "038", "Logradouro Invalido",cCtrProc})
				EndIf
				
				If ( AllTrim(ZZ1->ZZ1_OPER) $ '01_02_07' ) .and. !lCEPOk(ZZ1->ZZ1_CEP)
					cCtrProc 	:= "E"
					cErro 		:= cErro + "039"  //CEP Invalido
					aAdd(aErro, {ZZ0->ZZ0_SEQUEN, ZZ1->ZZ1_NUMLIN, "039", "CEP Invalido",cCtrProc})
				EndIf
				
				If ( AllTrim(ZZ1->ZZ1_OPER) $ '01_02_07' ) .and. !Empty(AllTrim(ZZ1->ZZ1_DDDCOM)) .and. Empty(AllTrim(ZZ1->ZZ1_TELCOM))
					cCtrProc 	:= "E"
					cErro 		:= cErro + "044"   //DDD - Comercial Informado e Telefone Nao Informado
					aAdd(aErro, {ZZ0->ZZ0_SEQUEN, ZZ1->ZZ1_NUMLIN, "044", "DDD - Comercial Informado e Telefone Nao Informado",cCtrProc})
				EndIf
				
				If ( AllTrim(ZZ1->ZZ1_OPER) $ '01_02_07' ) .and. Empty(AllTrim(ZZ1->ZZ1_DDDCOM)) .and. !Empty(AllTrim(ZZ1->ZZ1_TELCOM))
					cCtrProc 	:= "E"
					cErro 		:= cErro + "045"  //DDD - Comercial Nao Informado e Telefone Informado
					aAdd(aErro, {ZZ0->ZZ0_SEQUEN, ZZ1->ZZ1_NUMLIN, "045", "DDD - Comercial Nao Informado e Telefone Informado",cCtrProc})
				EndIf
				
				If (AllTrim(ZZ1->ZZ1_OPER) $ '01_02_07') .and. !Empty(AllTrim(ZZ1->ZZ1_RAMAL)) .and. Empty(AllTrim(ZZ1->ZZ1_TELCOM))
					cCtrProc 	:= "E"
					cErro 		:= cErro + "046"   //Ramal Informado e Telefone Nao Informado
					aAdd(aErro, {ZZ0->ZZ0_SEQUEN, ZZ1->ZZ1_NUMLIN, "046", "Ramal Informado e Telefone Nao Informado",cCtrProc})
				EndIf
				
				If (AllTrim(ZZ1->ZZ1_OPER) $ '01_02_07') .and. !Empty(AllTrim(ZZ1->ZZ1_DDDCEL)) .and. Empty(AllTrim(ZZ1->ZZ1_TELCEL))
					cCtrProc 	:= "E"
					cErro 		:= cErro + "047"   //DDD - Celular Informado e Telefone nao Informado
					aAdd(aErro, {ZZ0->ZZ0_SEQUEN, ZZ1->ZZ1_NUMLIN, "047", "DDD do Celular Informado e Numero nao Informado",cCtrProc})
				EndIf
				
				If (AllTrim(ZZ1->ZZ1_OPER) $ '01_02_07') .and. !Empty(AllTrim(ZZ1->ZZ1_TELCEL)) .and. Empty(AllTrim(ZZ1->ZZ1_DDDCEL))
					cCtrProc 	:= "E"
					cErro 		:= cErro + "048"   //DDD - Celular Nao Informado e Telefone Informado
					aAdd(aErro, {ZZ0->ZZ0_SEQUEN, ZZ1->ZZ1_NUMLIN, "048", "DDD do Celular Nao Informado e Numero Informado",cCtrProc})
				EndIf
				
				If AllTrim(ZZ1->ZZ1_OPER) == '04'
					
					If Empty(AllTrim(ZZ1->ZZ1_FUNANT))
						cCtrProc 	:= "E"
						cErro 		:= cErro + "063"  //funcional Anterior Invalida
						aAdd(aErro, {ZZ0->ZZ0_SEQUEN, ZZ1->ZZ1_NUMLIN, "063", "Funcional Anterior Invalida",cCtrProc})
					Else
						
						//----------------------------------------------------------------------------------
						//INICIO - Angelo Henrique - Data: 09/06/2017
						//Colocado GetArea pois, em alguns momentos estava se predendo na ZZ1
						//----------------------------------------------------------------------------------
						_aAreZZ1 := ZZ1->(GetArea())
						
						If (!lVerFunc(ZZ1->(ZZ1_FUNANT+ZZ1_DEPEND)) .or. !lVerBA1(ZZ1->(ZZ1_FUNANT+ZZ1_DEPEND)))
							cCtrProc 	:= "E"
							cErro 		:= cErro + "064"  //funcional Anterior nao existe na base
							aAdd(aErro, {ZZ0->ZZ0_SEQUEN, ZZ1->ZZ1_NUMLIN, "064", "Funcional Anterior nao existe na base",cCtrProc})
						EndIf
						
						RestArea(_aAreZZ1)
						//----------------------------------------------------------------------------------
						//FIM - Angelo Henrique - Data: 09/06/2017
						//----------------------------------------------------------------------------------
						
					EndIf
					
				EndIf
				
				//If ( AllTrim(ZZ1->ZZ1_OPER) $ '01_06' ) .and. lExisteBA1(ZZ1->(ZZ1_FUNC+ZZ1_DEPEND),'01')
				If ( AllTrim(ZZ1->ZZ1_OPER) $ '01_07' ) .and. lExisteBA1(AllTrim(ZZ1->(ZZ1_FUNC+ZZ1_DEPEND)),'01')
					cCtrProc 	:= "E"
					cErro 		:= cErro + "065"  //Funcional Ja existe na base
					aAdd(aErro, {ZZ0->ZZ0_SEQUEN, ZZ1->ZZ1_NUMLIN, "065", "Funcional Ja existe na base",cCtrProc})
				EndIf
				
				If ( AllTrim(ZZ1->ZZ1_OPER) $ '01_07' ) .and. ChkZZ1QtdCPF(AllTrim(ZZ1->ZZ1_OPER),ZZ1->ZZ1_SEQUEN,ZZ1->ZZ1_CPF,'01')
					cCtrProc 	:= "E"
					cErro 		:= cErro + "066"  //Maiores de 18 anos c/CPF Dupl. na Familia(Arq.de Imp.)
					aAdd(aErro, {ZZ0->ZZ0_SEQUEN, ZZ1->ZZ1_NUMLIN, "066", "CPF Dupl.no Cadastro de Usuario e/ou Vida",cCtrProc})
				EndIf
				
				//			If AllTrim(ZZ1->ZZ1_OPER) $ '01' .and. ChkZZ1QtdCPF(AllTrim(ZZ1->ZZ1_OPER),ZZ1->ZZ1_SEQUEN,ZZ1->ZZ1_CPF,'02')
				//				//cCtrProc := "W"
				//				cCtrProc := "E"
				//				cErro := cErro + "067"  //CPF Dupl.na Vida - Revise Vida e Vinc.C/Usuario
				//				aAdd(aErro, {ZZ0->ZZ0_SEQUEN, ZZ1->ZZ1_NUMLIN, "067", "CPF Dupl.na Vida - Revise Vida e Vinc.C/Usuario",cCtrProc})
				//			EndIf
				
				//Leonardo Portella - 24/11/16 - Inï¿½cio - Chamado - ID: 29130 - CPF duplicados

				If AllTrim(ZZ1->ZZ1_OPER) $ '01_07' .and. lCPFDupl(ZZ1->ZZ1_CPF, ZZ1->ZZ1_BENEF, ( AllTrim(ZZ1->ZZ1_CPFPRE) == 'S' ))
					
					cCtrProc 	:= "E"
					cErro 		:= cErro + "067" //Inclusao e existe CPF com nome diferente na vida
					aAdd(aErro, {ZZ0->ZZ0_SEQUEN, ZZ1->ZZ1_NUMLIN, "067", "Inclusao e existe CPF com nome diferente na vida",cCtrProc})
					
				EndIf
				//Leonardo Portella - 24/11/16 - Fim
				If AllTrim(ZZ1->ZZ1_OPER) $ '01_07' .and. ChkZZ1QtdCPF(AllTrim(ZZ1->ZZ1_OPER),ZZ1->ZZ1_SEQUEN,ZZ1->ZZ1_CPF,'03')
					cCtrProc := "E"
					cErro := cErro + "068"  //Maiores de 18 anos c/CPF Dupl. no Arq.de Imp.
					aAdd(aErro, {ZZ0->ZZ0_SEQUEN, ZZ1->ZZ1_NUMLIN, "068", "Maiores de 18 anos c/CPF Dupl. no Arq.de Imp.",cCtrProc})
				EndIf

				If AllTrim(ZZ1->ZZ1_OPER) $ '01_07' .and. !lExBA1ZZ1(AllTrim(ZZ1->ZZ1_FUNC)+'00',ZZ1->ZZ1_DEPEND,'01',ZZ1->ZZ1_SEQUEN)
					cCtrProc 	:= "E"
					cErro 		:= cErro + "069"   //Depdt. s/ Tit.(Base ou Arquivo)
					aAdd(aErro, {ZZ0->ZZ0_SEQUEN, ZZ1->ZZ1_NUMLIN, "069", "Dependente s/ Tit.(Base ou Arquivo)",cCtrProc})
				EndIf
				
				If AllTrim(ZZ1->ZZ1_OPER) $ '01_07' .and. chkCriTit(ZZ1->ZZ1_OPER,ZZ1->ZZ1_SEQUEN,AllTrim(ZZ1->ZZ1_FUNC)+'00',ZZ1->ZZ1_DEPEND)
					cCtrProc 	:= "E"
					cErro 		:= cErro + "070"   //Depdt. c/ Titular Criticado no Arquivo
					aAdd(aErro, {ZZ0->ZZ0_SEQUEN, ZZ1->ZZ1_NUMLIN, "070", "Dependente c/ Titular Criticado no Arquivo",cCtrProc})
				EndIf
				
				If ( AllTrim(ZZ0->ZZ0_SEQUEN) == AllTrim(ZZ1->ZZ1_SEQUEN) .and. AllTrim(ZZ0->ZZ0_CODEMP) <> AllTrim(ZZ1->ZZ1_CODEMP) )
					cCtrProc 	:= "E"
					cErro 		:= cErro + "071"   //Cod Empresa Divergente entre Parametro e Arquivo Importado
					aAdd(aErro, {ZZ0->ZZ0_SEQUEN, ZZ1->ZZ1_NUMLIN, "071", "Cod Emp. Diverge no Param. e Arq. Importado",cCtrProc})
				EndIf
				
				If AllTrim(ZZ1->ZZ1_OPER) $ '01_07' .and. ;
						!chkVlrADUSub(ZZ0->ZZ0_CODOPE, ZZ1->ZZ1_CODEMP, ZZ0->ZZ0_NUMCON, cVerCon, ZZ0->ZZ0_SUBCON, cVerSub, ZZ1->ZZ1_PADRAO ) .and.;
						ZZ1->ZZ1_ASSMED == 'S'
					cCtrProc := "E"
					cErro := cErro + "072"   //Sem Vlr de ADU na Forma de Cobr.no SubC.
					aAdd(aErro, {ZZ0->ZZ0_SEQUEN, ZZ1->ZZ1_NUMLIN, "072", "Sem Vlr de ADU na Forma de Cobr.no SubC.",cCtrProc})
				EndIf
				
				If AllTrim(ZZ1->ZZ1_OPER) $ '01_06_07' .and. chkFuncZZ1(AllTrim(ZZ1->(ZZ1_FUNC+ZZ1_DEPEND)),AllTrim(ZZ1->ZZ1_OPER),AllTrim(ZZ0->ZZ0_SEQUEN))
					cCtrProc := "E"
					cErro := cErro + "073"  //Funcional Duplic.na Importacao
					aAdd(aErro, {ZZ0->ZZ0_SEQUEN, ZZ1->ZZ1_NUMLIN, "073", "Funcional Duplic. na Importacao",cCtrProc})
				EndIf
				
				If AllTrim(ZZ1->ZZ1_OPER) $ '01_07' .and. lExisteHIS(AllTrim(ZZ1->(ZZ1_FUNC+ZZ1_DEPEND)),AllTrim(ZZ1->ZZ1_OPER))
					cCtrProc 	:= "E"
					cErro 		:= cErro + "074"  //FUNC+TIPREG Ja Usado Antes.Rever Planilha
					aAdd(aErro, {ZZ0->ZZ0_SEQUEN, ZZ1->ZZ1_NUMLIN, "074", "FUNC+TIPREG Ja Usado Antes - Rever Planilha",cCtrProc})
				EndIf
				
				If ( AllTrim(ZZ1->ZZ1_OPER) == '03' ) .and. ;
						!( (ZZ1->ZZ1_CDBENE <> 'T' .and. chkMotBlo(ZZ1->ZZ1_MOTEXC)) .or. (ZZ1->ZZ1_CDBENE == 'T' .and. fchkMotBlo(ZZ1->ZZ1_MOTEXC)) )
					
					cCtrProc 	:= "E"
					cErro 		:= cErro + "075"   //Motivo de Bloqueio Invalido
					aAdd(aErro, {ZZ0->ZZ0_SEQUEN, ZZ1->ZZ1_NUMLIN, "075", "Motivo de Bloqueio Invalido",cCtrProc})
				EndIf
				
				If (AllTrim(ZZ1->ZZ1_OPER) $ '01_02_07') .and. !(lStrData(ZZ1->ZZ1_DTADMI))
					cCtrProc 	:= "E"
					cErro 		:= cErro + "076" //Data de Admissao Invalida
					aAdd(aErro, {ZZ0->ZZ0_SEQUEN, ZZ1->ZZ1_NUMLIN, "076", "Data de Admissao Vazia ou Invalida",cCtrProc})
				EndIf
				
				If AllTrim(ZZ1->ZZ1_OPER) $ '03' .and. !chkData(AllTrim(ZZ1->ZZ1_FUNC),ZZ1->ZZ1_DTFIPD,3) .and. Empty(ctod(ZZ1->ZZ1_DTFIPD))
					cCtrProc := "E"
					cErro := cErro + "077" //Data do Padrao de Conforto Invalida
					aAdd(aErro, {ZZ0->ZZ0_SEQUEN, ZZ1->ZZ1_NUMLIN, "077", "Data Fim do Padrao Conforto Invalida",cCtrProc})
				EndIf
				
				//Leonardo Portella - 14/11/16 - Inicio
			
				If ( AllTrim(ZZ1->ZZ1_OPER) $ '01_02_07' ) .and. ( empty(ZZ1->ZZ1_CNS) .or. !U_lCNSValido(ZZ1->ZZ1_CNS) )
					cCtrProc 	:= "E"
					cErro 		:= cErro + "078" //CNS Invalido
					aAdd(aErro, {ZZ0->ZZ0_SEQUEN, ZZ1->ZZ1_NUMLIN, "078", "CNS Invalido",cCtrProc})
				EndIf
			
				//Chamado - ID: 32276
				If ( AllTrim(ZZ1->ZZ1_OPER) $ '01_02_07' )
					
					If !empty(ZZ1->ZZ1_NASVIV)
						
						//Leonardo Portella - 23/11/16 - Inï¿½cio - Validacao de somente numeros no nascido vivo
						
						cNasViv := Alltrim(ZZ1->ZZ1_NASVIV)
						cNasViv := Replace(cNasViv,'0','')
						cNasViv := Replace(cNasViv,'1','')
						cNasViv := Replace(cNasViv,'2','')
						cNasViv := Replace(cNasViv,'3','')
						cNasViv := Replace(cNasViv,'4','')
						cNasViv := Replace(cNasViv,'5','')
						cNasViv := Replace(cNasViv,'6','')
						cNasViv := Replace(cNasViv,'7','')
						cNasViv := Replace(cNasViv,'8','')
						cNasViv := Replace(cNasViv,'9','')
						
						If !empty(cNasViv)
							
							cCtrProc 	:= "E"
							cErro 		:= cErro + "079" //Decl. Nascido Vivo invalida
							aAdd(aErro, {ZZ0->ZZ0_SEQUEN, ZZ1->ZZ1_NUMLIN, "079", "Decl. Nasc. Vivo invalida (somente numeros)",cCtrProc})
							
							//Leonardo Portella - 23/11/16 - Fim - Validacao de somente numeros no nascido vivo
							
						Else
							
							//Leonardo Portella - 23/11/16 - Inicio - Se a DN tiver até 11 digitos completa com zeros a esquerda
							
							If ( Val(ZZ1->ZZ1_NASVIV) > 0 ) .and. ( Val(ZZ1->ZZ1_NASVIV) <= 99999999999 )
								
								ZZ1->(Reclock('ZZ1',.F.))
								ZZ1->ZZ1_NASVIV := StrZero(Val(ZZ1->ZZ1_NASVIV),11)
								ZZ1->(MsUnlock())
								
							EndIf
							
							//Leonardo Portella - 23/11/16 - Fim
							
							//Leonardo Portella - 16/11/16 - Nascido vivo nao é obrigatorio. Quando nao preenchido, o CBI povoa com zeros mas isso gera erro no SIB.
							
							If ( At('0',ZZ1->ZZ1_NASVIV) > 0 ) .and. empty(Replace(ZZ1->ZZ1_NASVIV,'0',''))
								
								ZZ1->(Reclock('ZZ1',.F.))
								ZZ1->ZZ1_NASVIV := ''
								ZZ1->(MsUnlock())
								
								//Baseado no algoritmo do SIB disponibilizado pela ANS
							ElseIf 	len(AllTrim(ZZ1->ZZ1_NASVIV)) <> 11 	.or.;
									empty(Replace(ZZ1->ZZ1_NASVIV,'0','')) 	.or.;
									empty(Replace(ZZ1->ZZ1_NASVIV,'1','')) 	.or.;
									empty(Replace(ZZ1->ZZ1_NASVIV,'2','')) 	.or.;
									empty(Replace(ZZ1->ZZ1_NASVIV,'3','')) 	.or.;
									empty(Replace(ZZ1->ZZ1_NASVIV,'4','')) 	.or.;
									empty(Replace(ZZ1->ZZ1_NASVIV,'5','')) 	.or.;
									empty(Replace(ZZ1->ZZ1_NASVIV,'6','')) 	.or.;
									empty(Replace(ZZ1->ZZ1_NASVIV,'7','')) 	.or.;
									empty(Replace(ZZ1->ZZ1_NASVIV,'8','')) 	.or.;
									empty(Replace(ZZ1->ZZ1_NASVIV,'9',''))
								
								cCtrProc 	:= "E"
								cErro 		:= cErro + "079" //Decl. Nascido Vivo invï¿½lida
								aAdd(aErro, {ZZ0->ZZ0_SEQUEN, ZZ1->ZZ1_NUMLIN, "079", "Decl. Nascido Vivo invalida",cCtrProc})
								
							EndIf
							
						EndIf
						
					EndIf
					
				EndIf
				
				//Leonardo Portella - 14/11/16 - Fim
				
				//-----------------------------------------------------------------------------------------------------------
				//Leonardo Portella - 16/11/16 - Inicio
				//-----------------------------------------------------------------------------------------------------------
				//Validacao da idade do preposto para possuir o CPF após 16 anos de idade
				//-----------------------------------------------------------------------------------------------------------
				//Angelo Henrique - Data: 03/08/2017 - Chamado: 40801 - Idade reduzida para 12 anos(Receita Federal)
				//-----------------------------------------------------------------------------------------------------------
				//Angelo Henrique - Data: 13/12/2017 - Chamado: 45073 - Idade reduzida para 8 anos(Receita Federal)
				//-----------------------------------------------------------------------------------------------------------
				If ( AllTrim(ZZ1->ZZ1_OPER) $ '01_02_07' ) .and. ( AllTrim(ZZ1->ZZ1_CPFPRE) == 'S' ) .and. ( u_nCalcIdade(CtoD(ZZ1->ZZ1_DTNASC)) > 7 )
					cCtrProc 	:= "E"
					cErro 		:= cErro + "080"
					aAdd(aErro, {ZZ0->ZZ0_SEQUEN, ZZ1->ZZ1_NUMLIN, "080", "CPF marcado como preposto e idade maior ou igual a 8",cCtrProc})
				EndIf
				//-----------------------------------------------------------------------------------------------------------
				//Leonardo Portella - 16/11/16 - Fim
				//-----------------------------------------------------------------------------------------------------------
				
				//Leonardo Portella - 05/12/16 - Inï¿½cio
				
				If ( AllTrim(ZZ1->ZZ1_OPER) == '06' ) //Desbloqueio
					
					a_InfoUsr := aLimContr() //Retorna os limites do contrato de uma funcional (inï¿½cio e bloqueio)
					
					If empty(a_InfoUsr)
						
						cCtrProc 	:= "E"
						cErro 		:= cErro + "081" //Exclusï¿½o e nï¿½o foi localizada a funcional
						aAdd(aErro, {ZZ0->ZZ0_SEQUEN, ZZ1->ZZ1_NUMLIN, "081", "Exclusao e nao foi localizada a funcional",cCtrProc})
						
					Else
						
						Do Case
							
						Case empty(a_InfoUsr[2])
							
							cCtrProc 	:= "E"
							cErro 		:= cErro + "082" //Desbloqueio e beneficiario encontra-se ativo
							aAdd(aErro, {ZZ0->ZZ0_SEQUEN, ZZ1->ZZ1_NUMLIN, "082", "Desbloqueio e benef. ativo",cCtrProc})
							
						Case ( Date() - StoD(a_InfoUsr[2]) ) > 60
							
							cCtrProc 	:= "E"
							cErro 		:= cErro + "083" //Desbloqueio com usuario bloqueado a mais de 60 dias
							aAdd(aErro, {ZZ0->ZZ0_SEQUEN, ZZ1->ZZ1_NUMLIN, "083", "Desbloqueio e benef. bloq. > 60 dias",cCtrProc})
							
						Case A260BloqSubCtr(a_InfoUsr[4])
							
							cCtrProc 	:= "E"
							cErro 		:= cErro + "084" //Desbloqueio com Subcontrato bloqueado
							aAdd(aErro, {ZZ0->ZZ0_SEQUEN, ZZ1->ZZ1_NUMLIN, "084", "Desbloqueio com subcontrato bloqueado",cCtrProc})
							
						Case a_InfoUsr[5] == 'SIM'
							
							cCtrProc 	:= "E"
							cErro 		:= cErro + "085" //Usuï¿½rio bloqueado por transferï¿½ncia
							aAdd(aErro, {ZZ0->ZZ0_SEQUEN, ZZ1->ZZ1_NUMLIN, "085", "Usuario bloqueado por transferencia",cCtrProc})
							
						Case !empty(StoD(a_InfoUsr[6])) .and. ( ( Date() - StoD(a_InfoUsr[6]) ) > 60 )
							
							cCtrProc 	:= "E"
							cErro 		:= cErro + "086" //Desbloqueio com famï¿½lia bloqueada a mais de 60 dias
							aAdd(aErro, {ZZ0->ZZ0_SEQUEN, ZZ1->ZZ1_NUMLIN, "086", "Desbloqueio e familia. bloq. > 60 dias",cCtrProc})
							
						Case CtoD(Replace(ZZ1->ZZ1_DTEXC,'.','/')) < StoD(a_InfoUsr[2])
							
							cCtrProc 	:= "E"
							cErro 		:= cErro + "086" //Desbloqueio com data anterior ao bloqueio
							aAdd(aErro, {ZZ0->ZZ0_SEQUEN, ZZ1->ZZ1_NUMLIN, "086", "Desbloqueio com data anterior ao bloqueio",cCtrProc})
							
						Case CtoD(Replace(ZZ1->ZZ1_DTEXC,'.','/')) < StoD(a_InfoUsr[1])
							
							cCtrProc 	:= "E"
							cErro 		:= cErro + "086" //Desbloqueio com data anterior a inclusao
							aAdd(aErro, {ZZ0->ZZ0_SEQUEN, ZZ1->ZZ1_NUMLIN, "086", "Desbloqueio com data anterior a inclusao",cCtrProc})
							
						EndCase
						
					EndIf
					
				EndIf
				
				//Leonardo Portella - 05/12/16 - Fim
				
				//------------------------------------------------------
				//Inicio - Angelo Henrique - data: 13/12/2016
				//Solicitado validacao para produtos suspensos
				//------------------------------------------------------
				If ( AllTrim(ZZ1->ZZ1_OPER) $ '01_07' ) .And. ZZ1->ZZ1_DEPEND == '00'
					
					BI3->(DbSetOrder(1))
					If BI3->(DbSeek(xFilial("BI3")+ZZ0->ZZ0_CODOPE+dParaProd(ZZ1->ZZ1_PADRAO,dParaTipoBnf(ZZ1->ZZ1_CDBENE))+"001"))
						
						//Produto Bloqueado
						If BI3->BI3_STATUS = "2"
							
							cCtrProc 	:= "E"
							cErro 		:= cErro + "087" //Produto Bloqueado
							aAdd(aErro, {ZZ0->ZZ0_SEQUEN, ZZ1->ZZ1_NUMLIN, "087", "Prod. Bloq. nao pode incluir beneficiario",cCtrProc})
							
						EndIf
						
						//Produto com Comercializacao suspensa ou cancelado
						// FRED: 10/05/22 - retirado tratamento de produto com comercialização suspensa - refeito seguindo nova regra - critica 101
						If BI3->BI3_SITCOM == "3" .or. BI3->BI3_SITANS == "3"	// mantido somente tratamento para produto cancelado
							
							If  cEmpAnt == '02' .And. BI3->BI3_CODIGO $ ("0072|0078")
								
								//--------------------------------------------------------
								//Conforme chamado: 33148
								//Para os produtos ESSENCIAL A(0078) e MULTI A (0072)
								//a Regra deve valer apartir de 09/12/2016
								//--------------------------------------------------------
								If CTOD(ZZ1->ZZ1_DTINCT) > CTOD('09/12/2016')
									
									cCtrProc 	:= "E"
									cErro 		:= cErro + "088" //Produto cancelado
									aAdd(aErro, {ZZ0->ZZ0_SEQUEN, ZZ1->ZZ1_NUMLIN, "088", "Prod. cancelado e data de inclusao maior que 09/12/2016.",cCtrProc})
									
								EndIf
								
							Else
								
								cCtrProc 	:= "E"
								cErro 		:= cErro + "088" //Produto cancelado
								aAdd(aErro, {ZZ0->ZZ0_SEQUEN, ZZ1->ZZ1_NUMLIN, "088", "Prod. cancelado",cCtrProc})
								
							EndIf
							
						EndIf
						
					EndIf
					
				ElseIf ( AllTrim(ZZ1->ZZ1_OPER) $ '01_07' )
					
					//---------------------------------------------------------------------------
					//a ANS permite a inclusao somente de dependente, onde ja conste o
					//titular no Plano que esta suspenso, portanto a empresa, nesse caso,
					//podera utilizar o produto suspenso pela ANS
					//---------------------------------------------------------------------------
					
					//-------------------------------------------
					//Validando se o Titular esta na base
					//-------------------------------------------
					//Forcanco a atualizacao das variaveis
					
					If ZZ1->ZZ1_DEPEND != '00'
						
						cVerCon := chkVerConSub(ZZ0->ZZ0_CODOPE,ZZ0->ZZ0_CODEMP,ZZ0->ZZ0_NUMCON,ZZ0->ZZ0_SUBCON,'C')
						cVerSub := chkVerConSub(ZZ0->ZZ0_CODOPE,ZZ0->ZZ0_CODEMP,ZZ0->ZZ0_NUMCON,ZZ0->ZZ0_SUBCON,'S')
						
						_aArBA3 := BA3->(GetArea())
						_lAchfam := .F.
						_lBlqFam := .F.
						
						BA3->(dbOrderNickName("BA3EMCOSUB"))
						BA3->(dbSeek(xFilial("BA1")+ZZ0->ZZ0_CODEMP+ZZ0->ZZ0_NUMCON+cVerCon+ZZ0->ZZ0_SUBCON+cVerSub+AllTrim(ZZ1->ZZ1_FUNC)))
						
						While BA3->( !EOF() ) .And. ;
								AllTrim(BA3->(BA3_FILIAL+BA3_CODEMP+BA3_CONEMP+BA3_VERCON+BA3_SUBCON+BA3_VERSUB+BA3_MATEMP)) == AllTrim(xFilial("BA1")+ZZ0->ZZ0_CODEMP+ZZ0->ZZ0_NUMCON+cVerCon+ZZ0->ZZ0_SUBCON+cVerSub+AllTrim(ZZ1->ZZ1_FUNC))
							
							If Empty(BA3->BA3_DATBLO)//Familia tem cadastro ativo
								
								_lAchfam 	:= .T.
								_cFamDsb	:= BA3->(BA3_CODINT+BA3_CODEMP+BA3_MATRIC)
								
							Else
								
								_lBlqFam := .T.
								
							EndIf
							
							BA3->(DbSkip())
							
						EndDo
						
						//Se achou a familia, validar se no usuï¿½rio esta tudo OK
						If _lAchfam
							
							_aArBA1 := BA1->(GetArea())
							
							DbSelectArea("BA1")
							DbSetOrder(1) //BA1_FILIAL+BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPUSU+BA1_TIPREG+BA1_DIGITO
							If DbSeek(xFilial("BA1") + _cFamDsb + "T")
								
								If ( !Empty(BA1->BA1_DATBLO) .or. !Empty(BA1->BA1_MOTBLO) )
									
									cCtrProc 	:= "E"
									cErro 		:= cErro + "089" //Produto com Comercializacao suspensa ou cancelado para dependente
									aAdd(aErro, {ZZ0->ZZ0_SEQUEN, ZZ1->ZZ1_NUMLIN, "089", "Titular bloqueado no sistema, dependente nao incluido.",cCtrProc})
									
								EndIf
								
							EndIf
							
							RestArea(_aArBA1)
							
						Else
							
							//--------------------------------------------------------------------------------
							//Caso nao tenha achado titular e familia validar o titular novamente para
							//saber se nao possui critica para ele e acrescentar no dependente
							//--------------------------------------------------------------------------------
							
							_aArZZ1 := ZZ1->(GetArea())
							_dDtZZ1 := CTOD(ZZ1->ZZ1_DTINCT)
							_cLinZ1 := ZZ1->ZZ1_NUMLIN
							
							If !_lBlqFam
								
								//Fazer validacao da funcional mais sequencial do impvida
								//pois em alguns momentos ele pegou um usuario com o mesmo funcional
								//vindo de outra empresa e acabou validando o produto errado, caindo aqui nesta validacao.
								//Pontero no titular por query adicionando assim o sequencial do arquivo lido no momento
								
								_cQuery := " SELECT									 			" + cEnt
								_cQuery += "     ZZ1.ZZ1_FUNC,									" + cEnt
								_cQuery += "     ZZ1.ZZ1_PADRAO,								" + cEnt
								_cQuery += "     ZZ1.ZZ1_CDBENE									" + cEnt
								_cQuery += " FROM 												" + cEnt
								_cQuery += "     " + RetSqlName("ZZ1") + " ZZ1 					" + cEnt
								_cQuery += " WHERE												" + cEnt
								_cQuery += "     ZZ1.D_E_L_E_T_ = ' '							" + cEnt
								_cQuery += "     AND ZZ1.ZZ1_FILIAL = '" + xFilial("ZZ1")  + "' " + cEnt
								_cQuery += "     AND ZZ1.ZZ1_FUNC 	= '" + ZZ1->ZZ1_FUNC   + "'	" + cEnt
								_cQuery += "     AND ZZ1.ZZ1_SEQUEN	= '" + ZZ0->ZZ0_SEQUEN + "'	" + cEnt
								_cQuery += "     AND ZZ1.ZZ1_DEPEND	= '00'						" + cEnt
								
								If Select(_cAlias1) > 0
									(_cAlias1)->(DbCloseArea())
								EndIf
								
								PLSQuery(_cQuery,_cAlias1)
								
								If !(_cAlias1)->(EOF())
									
									BI3->(DbSetOrder(1))
									If BI3->(DbSeek(xFilial("BI3")+ ZZ0->ZZ0_CODOPE + dParaProd((_cAlias1)->ZZ1_PADRAO,dParaTipoBnf((_cAlias1)->ZZ1_CDBENE)) + "001")) //+dParaProd(ZZ1->ZZ1_PADRAO,dParaTipoBnf(ZZ1->ZZ1_CDBENE))+"001"))
										
										//Produto Bloqueado
										If BI3->BI3_STATUS = "2"
											
											cCtrProc 	:= "E"
											cErro 		:= cErro + "090" //Produto Bloqueado
											aAdd(aErro, {ZZ0->ZZ0_SEQUEN, _cLinZ1, "090", "Produt Bloq, dependente nao incluido, titular criticado",cCtrProc})
											
										EndIf
										
										// Produto cancelado (FRED: com Comercializacao suspensa levado para outro tratamento)
										If BI3->BI3_SITCOM == "3" .or. BI3->BI3_SITANS == "3"
											
											If  cEmpAnt == '02' .And. BI3->BI3_CODIGO $ ("0072|0078")
												
												//--------------------------------------------------------
												//Conforme chamado: 33148
												//Para os produtos ESSENCIAL A(0078) e MULTI A (0072)
												//a Regra deve valer apartir de 09/12/2016
												//--------------------------------------------------------
												If _dDtZZ1 > CTOD('09/12/2016')
													
													cCtrProc 	:= "E"
													cErro 		:= cErro + "091" //Produto cancelado
													aAdd(aErro, {ZZ0->ZZ0_SEQUEN, _cLinZ1, "091", "Dependente nao incluido, titular criticado",cCtrProc})
													
												EndIf
												
											Else
												
												cCtrProc 	:= "E"
												cErro 		:= cErro + "092" //Produto cancelado
												aAdd(aErro, {ZZ0->ZZ0_SEQUEN, _cLinZ1, "092", "Dependente nao incluido, titular criticado",cCtrProc})
												
											EndIf
											
										EndIf
										
									EndIf
									
								EndIf
								
								If Select(_cAlias1) > 0
									(_cAlias1)->(DbCloseArea())
								EndIf
								
							Else
								
								//-----------------------------------------------------------------------------------------------------
								//Se achou a familia, porem esta bloqueada, verificar se o titular esta no arquivo para ser incluido.
								//-----------------------------------------------------------------------------------------------------
								_aArZ0Vl := ZZ0->(GetArea())
								_aArZ1Vl := ZZ1->(GetArea())
								_cFuncDp := ZZ1->ZZ1_FUNC //Funcional ponterado no momento antes do DbSelectArea
								_lTitFuc := .F. //Titular da Funcional
								
								DbSelectArea("ZZ1")
								DbSetOrder(1)
								If DbSeek(xFilial("ZZ1") + ZZ0->ZZ0_SEQUEN )
									
									While !EOF() .And. ZZ0->ZZ0_SEQUEN == ZZ1->ZZ1_SEQUEN
										
										//----------------------------------------------------------------
										//Se for o titular podera dar continuidade ao processo.
										//----------------------------------------------------------------
										If _cFuncDp == ZZ1->ZZ1_FUNC .And. ZZ1->ZZ1_DEPEND == '00'
											
											_lTitFuc := .T.
											Exit
											
										EndIf
										
										ZZ1->(DbSkip())
										
									EndDo
									
								EndIf
								
								RestArea(_aArZ1Vl)
								RestArea(_aArZ0Vl)
								
								If !_lTitFuc
									
									//Achou a familia porem esta bloqueado no sistema logo nao podera inserir o dependente na base
									cCtrProc 	:= "E"
									cErro 		:= cErro + "093" //Familia esta bloqueada para ser inserida
									aAdd(aErro, {ZZ0->ZZ0_SEQUEN, _cLinZ1, "093", "Familia bloqueada, dependente nao inserido",cCtrProc})
									
								EndIf
								
							EndIf
							
							RestArea(_aArZZ1)
							
						EndIf
						
						//Restauro aqui a variï¿½vel para nï¿½o prejudicar qualquer validaï¿½ï¿½o
						RestArea(_aArBA3)
						
					EndIf
					
				EndIf
				//------------------------------------------------------
				//Fim - Angelo Henrique - data: 13/12/2016
				//------------------------------------------------------
				
				//---------------------------------------------------------------------------
				//INICIO - Angelo Henrique - Data: 08/06/2017 - Chamado: 39352
				//Validacao da idade permitida para inclusao no plano.
				//---------------------------------------------------------------------------
				If AllTrim(ZZ1->ZZ1_OPER) $ '01_07'
					
					//********************************************************************************************************************************************
					//Rotina VldIdade - Angelo Henrique - Data: 09/06/2017
					//********************************************************************************************************************************************
					//Parametros:
					//********************************************************************************************************************************************
					//_cProdt	:= "" //Codigo do Produto da BT0 	--||-- ZZ1->ZZ1_PADRAO
					//_cGraPt	:= "" //Grau de Parentesco 			--||-- DParaGrauPar(ZZ1->ZZ1_TPPARE,iIf(ZZ1->ZZ1_SEXO =="M","1","2"), ZZ1->ZZ1_DEPEND)
					//_cCodBqc	:= "" //Codigo da BQC				--||-- (ZZ0->(ZZ0_CODOPE+ZZ0_CODEMP))
					//_cContra	:= "" //Numero do Contrato			--||-- ZZ0->ZZ0_NUMCON
					//_cSubCon	:= "" //Numero do SubContrato		--||-- ZZ0->ZZ0_SUBCON
					//_cDtNasc  := "" //Data de Nascimento			--||-- ZZ1->ZZ1_DTNASC
					//********************************************************************************************************************************************
					
					_cGrauPA := DParaGrauPar(ZZ1->ZZ1_TPPARE,IIf(ZZ1->ZZ1_SEXO =="M","1","2"), ZZ1->ZZ1_DEPEND)
					
					If !(VldIdade(ZZ1->ZZ1_PADRAO, _cGrauPA, ZZ0->(ZZ0_CODOPE+ZZ0_CODEMP), ZZ0->ZZ0_NUMCON, ZZ0->ZZ0_SUBCON, ZZ1->ZZ1_DTNASC))
						
						cCtrProc 	:= "E"
						cErro 		:= cErro + "094"   // Idade nï¿½o permitida
						aAdd(aErro, {ZZ0->ZZ0_SEQUEN, ZZ1->ZZ1_NUMLIN, "094", "Idade nao permitida na inclusao no contrato",cCtrProc})
						
					EndIf
					
				EndIf
				//---------------------------------------------------------------------------
				//FIM - Angelo Henrique - Data: 08/06/2017 - Chamado: 39352
				//---------------------------------------------------------------------------
				
				//---------------------------------------------------------------------------
				//INICIO - Angelo Henrique - Data: 03/07/2017 - Chamado: 39293
				//Validacao da data de bloqueio para nao ser retroativa
				//---------------------------------------------------------------------------
				//Caso seja o gestor do cadastro essa validacao nao sera executada
				//---------------------------------------------------------------------------
				If GetNewPar("MV_XRETR",.T.)
					
					If cEmpAnt == "02"
						
						If !( __cUserID $ AllTrim(_cLibBlq) )
							
							If AllTrim(ZZ1->ZZ1_OPER) = '03'
								
								_aArBA1 := BA1->(GetArea())
								
								If ZZ0->ZZ0_CODEMP $ "0182|0282"
									
									If CTOD(REPLACE(ZZ1->ZZ1_DTEXC,'.','/')) < DaySub(dDatabase,1)
										
										cCtrProc 	:= "E"
										cErro 		:= cErro + "095"   // Data de exclusao nao permitida
										aAdd(aErro, {ZZ0->ZZ0_SEQUEN, ZZ1->ZZ1_NUMLIN, "095", "Dt bloq. inferior a dt atual, nao pode bloquear.",cCtrProc})
										
									EndIf
									
									BA1->(DbOrderNickName("BA1EMCOSUB"))
									If BA1->(DbSeek(xFilial("BA1")+ZZ1->ZZ1_CODEMP+ZZ0->ZZ0_NUMCON+cVerCon+ZZ0->ZZ0_SUBCON+cVerSub+AllTrim(ZZ1->ZZ1_FUNC)+ZZ1->ZZ1_DEPEND))
										
										If CTOD(REPLACE(ZZ1->ZZ1_DTEXC,'.','/')) < BA1->BA1_DATINC
											
											cCtrProc 	:= "E"
											cErro 		:= cErro + "096"   // Data de exclusï¿½o nï¿½o permitida
											aAdd(aErro, {ZZ0->ZZ0_SEQUEN, ZZ1->ZZ1_NUMLIN, "096", "Dt bloq. inferior a dt de inclusao, nao pode bloquear.",cCtrProc})
											
										EndIf
										
									EndIf
									
								EndIf
								
								RestArea(_aArBA1)
								
							EndIf
							
						EndIf
						
					EndIf
					
				EndIf
				//---------------------------------------------------------------------------
				//FIM - Angelo Henrique - Data: 03/07/2017 - Chamado: 39293
				//---------------------------------------------------------------------------
				
				//----------------------------------------------------------------------------------------------------------
				//Fechando a entrada de titular menor de 12 anos
				//----------------------------------------------------------------------------------------------------------
				//Conforme e-mail encaminhado pela Marcia:
				//"A regra é para nao permitir a inclusao de menores de 12 anos como titular nos contratos de Adesao."
				//----------------------------------------------------------------------------------------------------------
				
				If cEmpAnt == "02"
					
					//If ZZ0->ZZ0_CODEMP $ GETNEWPAR("MV_XEMP12",'0262,0220,0222,0010,0260,0250,0251,0252,0253,0254,0255,0256,0270,0271,0272,0274,0282')
					If ZZ0->ZZ0_CODEMP $ GETNEWPAR("MV_XEMP12",'0010,0220,0250,0253,0254,0255,0256,0260,0262,0270,0274,0282,0182,0149')
						
						If ZZ1->ZZ1_OPER == "01" .And. ZZ1->ZZ1_CDBENE = "T" .And. u_nCalcIdade(CtoD(ZZ1->ZZ1_DTNASC)) < 12
							
							cCtrProc 	:= "E"
							cErro 		:= cErro + "097"
							aAdd(aErro, {ZZ0->ZZ0_SEQUEN, ZZ1->ZZ1_NUMLIN, "097", "Menor de 12 anos nao pode ser cadastrado como Titular.",cCtrProc})
							
						EndIf
						
					EndIf
					
				EndIf
				
				//----------------------------------------------------------------------------------------------------------
				//Angelo Henrique - Data: 26/03/2018
				//----------------------------------------------------------------------------------------------------------
				//Chamado: 48267 - CPF Duplicado quando nao é selecionado a opcao preposto, sistema deve criticar
				//----------------------------------------------------------------------------------------------------------
				
				If AllTrim(ZZ1->ZZ1_OPER) $ '01_07' .And. !(Empty(ZZ1->ZZ1_CPF))
					
					If AllTrim(ZZ1->ZZ1_CPFPRE) <> 'S'
						If !(u_VldCPFDp(ZZ1->ZZ1_SEQUEN,ZZ1->ZZ1_CPF))
							cCtrProc 	:= "E"
							cErro 		:= cErro + "098"
							aAdd(aErro, {ZZ0->ZZ0_SEQUEN, ZZ1->ZZ1_NUMLIN, "098", "CPF duplicado no arquivo.",cCtrProc})
						EndIf
					EndIf
					
				EndIF
				
				//----------------------------------------------------------------------------------------------------------
				//Angelo Henrique - Data: 12/06/2018
				//----------------------------------------------------------------------------------------------------------
				//Chamado: 50423 - Nï¿½o permitir data de inclusï¿½o menor que a data do subcontrato
				//----------------------------------------------------------------------------------------------------------
				If AllTrim(ZZ1->ZZ1_OPER) $ ('01|02|07')
					
					//-------------------------------
					//Ponterando no subcontrato
					//-------------------------------
					
					//PEGAR VERSAO DO CONTRATO E DO SUBCONTRATO DA EMPRESA NO ARQUIVO DE IMPORTACAO
					cVerCon := chkVerConSub(ZZ0->ZZ0_CODOPE,ZZ0->ZZ0_CODEMP,ZZ0->ZZ0_NUMCON,ZZ0->ZZ0_SUBCON,'C')
					cVerSub := chkVerConSub(ZZ0->ZZ0_CODOPE,ZZ0->ZZ0_CODEMP,ZZ0->ZZ0_NUMCON,ZZ0->ZZ0_SUBCON,'S')
					
					DbSelectArea("BQC")
					DbSetOrder(1) //BQC_FILIAL+BQC_CODIGO+BQC_NUMCON+BQC_VERCON+BQC_SUBCON+BQC_VERSUB
					If DbSeek(xFilial("BQC") + ZZ0->(ZZ0_CODOPE + ZZ0_CODEMP + ZZ0_NUMCON)+ cVerCon + ZZ0->ZZ0_SUBCON + cVerSub )
						
						If CTOD(ZZ1->ZZ1_DTINCT) < BQC->BQC_DATCON
							
							cCtrProc 	:= "E"
							cErro 		:= cErro + "099"
							aAdd(aErro, {ZZ0->ZZ0_SEQUEN, ZZ1->ZZ1_NUMLIN, "099", "Data de inclusao menor que data de vigencia do Sub.",cCtrProc})
							
						EndIf
						
						If !(Empty(BQC->BQC_DATBLO))
							
							cCtrProc 	:= "E"
							cErro 		:= cErro + "100"
							aAdd(aErro, {ZZ0->ZZ0_SEQUEN, ZZ1->ZZ1_NUMLIN, "100", "SubContrato bloqueado.",cCtrProc})
							
						EndIf
						
					EndIf
					
				EndIf

				// FRED: 10/05/22 - chamado 79.996 - produto ativo com comercialização suspensa
				cVerCon := chkVerConSub(ZZ0->ZZ0_CODOPE,ZZ0->ZZ0_CODEMP,ZZ0->ZZ0_NUMCON,ZZ0->ZZ0_SUBCON,'C')
				cVerSub := chkVerConSub(ZZ0->ZZ0_CODOPE,ZZ0->ZZ0_CODEMP,ZZ0->ZZ0_NUMCON,ZZ0->ZZ0_SUBCON,'S')

				DbSelectArea("BQC")
				BQC->(DbSetOrder(1))	// BQC_FILIAL+BQC_CODIGO+BQC_NUMCON+BQC_VERCON+BQC_SUBCON+BQC_VERSUB
				if BQC->(DbSeek(xFilial("BQC") + ZZ0->(ZZ0_CODOPE + ZZ0_CODEMP + ZZ0_NUMCON)+ cVerCon + ZZ0->ZZ0_SUBCON + cVerSub ))

					BI3->(DbSetOrder(1))	// BI3_FILIAL+BI3_CODINT+BI3_CODIGO+BI3_VERSAO
					if BI3->(DbSeek(xFilial("BI3") + ZZ0->ZZ0_CODOPE + dParaProd(ZZ1->ZZ1_PADRAO, dParaTipoBnf(ZZ1->ZZ1_CDBENE)) + "001"))

						if (BI3->BI3_SITCOM == '2' .or. BI3->BI3_SITANS == '2') .and. BI3->BI3_XDTSUS < BQC->BQC_DATCON .and. !empty(BI3->BI3_XDTSUS)

							cCtrProc 	:= "E"
							cErro 		:= cErro + "101"
							aAdd(aErro, {ZZ0->ZZ0_SEQUEN, ZZ1->ZZ1_NUMLIN, "101", "Produto com comercialização suspensa.",cCtrProc})

						endif

					endif

				endif
				// FRED: final

				nSeqErro := 0
				
				If Len(aErro) > 0
					
					For n = 1 to Len(aErro)
						
						lAchouCrit 	:= .T.
						nSeqErro 	+= 1
						
						aAdd(aArqErro, {aErro[n,1],aErro[n,2], StrZero(nSeqErro,3), aErro[n,3],aErro[n,4],aErro[n,5]})
						
						ZZ2->(RecLock("ZZ2",.T.))
						
						ZZ2->ZZ2_SEQUEN := aErro[n,1]
						ZZ2->ZZ2_NUMLIN := aErro[n,2]
						ZZ2->ZZ2_SEQERR := StrZero(nSeqErro,3)
						ZZ2->ZZ2_CODERR := aErro[n,3]
						ZZ2->ZZ2_DESERR := aErro[n,4]
						
						If ZZ2->(FieldPos("ZZ2_CTRPRC")) > 0
							ZZ2->ZZ2_CTRPRC := aErro[n,5]
						EndIf
						
						ZZ2->(MsUnlock())
						
					Next
					
				EndIf
				
				ZZ1->(RecLock("ZZ1",.F.))
				
				ZZ1->ZZ1_TABERR := cErro
				cAcao := ""
				ZZ1->ZZ1_OPERSI := U_VEROPER(@cAcao)
				ZZ1->ZZ1_DESOPE := cAcao
				ZZ1->(MsUnlock())
				
				ZZ1->(dbSkip())
				
			EndDo
			
			If Len(aArqErro) > 0
				cArqOut := Substr(cPath+AllTrim(ZZ0->ZZ0_NOMARQ),1,Len(AllTrim(ZZ0->ZZ0_NOMARQ))- At(AllTrim(ZZ0->ZZ0_NOMARQ),"."))+".ret"
				nHOut := FCreate(cArqOut)
				For N := 1 to Len(aArqErro)
					cLinha := aArqErro[n,1]+aArqErro[n,2]+aArqErro[n,3]+aArqErro[n,4]
					fWrite(nHOut,cLinha+ Chr(13) + Chr(10),Len(cLinha)+2)
					cLinha := ""
				Next N
				fClose(nHOut)
			EndIf
			
			// Mudo o status do arquivo colocando como criticado
			ZZ0->(RecLock("ZZ0",.F.))
			
			If !lAchouCrit
				ZZ0->ZZ0_STATUS := "2"
			Else
				ZZ0->ZZ0_STATUS := "3"
			EndIf
			
			ZZ0->ZZ0_DTCRIT := dDatabase
			
			ZZ0->(MsUnlock())
			
	EndIf
		
	Else
		MsgAlert("Somente é possível criticar arquivos com status importado ou criticado!",AllTrim(SM0->M0_NOMECOM))
	EndIf
	
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ IMPAPP   ºAutor  ³ Antonio de Padua   º Data ³  10/05/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Insere Arquivo Criticado							 		  º±±
±±º          ³   			                                        	  º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function IMPAPP(cAlias,nReg,nOpc)
	
	Local aCampos 	:= {}
	Local lWarning 	:= .F.
	
	// Preencho os campos novamente agora para inserir na base
	PreencheCmp(@aCampos)
	
	If ZZ0->ZZ0_STATUS $ "2|3"
		
		ZZ1->(dbOrderNickName("SEQFUN"))
		
		If ZZ1->(DbSeek(xFilial("ZZ1")+ZZ0->ZZ0_SEQUEN))
			
			Private cFuncPesq := ' '//Variavel para armazenar a funcional a ser pesquisada
			
			While !ZZ1->(EOF()) .and. ZZ1->ZZ1_SEQUEN == ZZ0->ZZ0_SEQUEN
				
				If Empty(AllTrim(ZZ1->ZZ1_TABERR))
					
					Do Case
						
					Case ZZ1->ZZ1_OPER == "01" //Incluir beneficiario.
						IncluiUsuar()
						
					Case ZZ1->ZZ1_OPER == "02" //Alteracoes de endereco, nome, etc e MUDANCA DE TIPO DE DEPENDENTE (Muda o subcontrato - transferir).
						AlteraUsuar(2)
						
					Case ZZ1->ZZ1_OPER == "03" //Bloqueio de beneficiario.
						AlteraUsuar(3)
						
					Case ZZ1->ZZ1_OPER == "04" //Mudanca de empresa (modificar o subcontrato - transferir)
						AltSubCont()
						
					Case ZZ1->ZZ1_OPER == "05" //Mudanca de plano  (tranferir)
						AltSubCont()
						
					Case ZZ1->ZZ1_OPER == "06" //Desbloqueio de beneficiario.
						IMPDesbloq() //Leonardo Portella - 06/12/16 - Desbloqueio utilizando rotinas padrï¿½o
						
					Case ZZ1->ZZ1_OPER == "07" //Transferï¿½ncia de Beneficiï¿½rio
						CBITRANS() //Angelo Henrique - 26/12/2018 - Transferï¿½ncia utilizando a rotina padrï¿½o
						
					EndCase
					
				EndIf
				
				
				ZZ1->(DbSkip())
				
			EndDo
			
		EndIf
		
		// Mudo o status do arquivo colocando como Inserido no BD
		ZZ0->(RecLock("ZZ0",.F.))
		
		If ZZ0->ZZ0_STATUS == '2' //Analisado SEM Criticas
			ZZ0->ZZ0_STATUS := "4" //Totalmente Inserido na Base
		Else
			ZZ0->ZZ0_STATUS := "5" //Parcialmente Inserido na Base
		EndIf
		
		ZZ0->ZZ0_DTINSB := dDatabase
		
		ZZ0->(MsUnlock())
		
	Else
		MsgInfo("Somente e possivel inserir no BD arquivos com status criticado!")
	EndIf
	
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ PreencheCmp ºAutor ³ Antonio de Padua º Data ³  10/05/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Preenche matriz passada com os campos da importacao 		  º±±
±±º          ³   			                                        	  º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function PreencheCmp(aCamposImp)
	
	//Crio primeiramente as linhas e em quais arquivos as mesmas vao gravar
	aAdd(aCamposImp,{{"01",{},"M","ZZ0","H"},{"10",{},"ZZ1","","D"},{"99",{},"M","ZZ0","T"}})
	
	//Crio uma posicao na matriz pra cada campo com sua posicao no arquivo e qual o campo que sera gravado
	aAdd(aCamposImp[1,1,2],{"Sequencial",88,6,"ZZ0_SEQARQ","C",{}})
	aAdd(aCamposImp[1,1,2],{"Cod Contrato",3,5,"ZZ0_CTREMP","C",{}})
	aAdd(aCamposImp[1,1,2],{"Linha",1,1000,"ZZ0_LINHA","C",{}})
	
	//Linha totalizadora
	aAdd(aCamposImp[1,3,2],{"Linha",1,1000,"ZZ0_LINT","C",{}})
	
	aAdd(aCamposImp[1,2,2],{"Operacao",3,2,"ZZ1_OPER","C",{}})
	
	//Quando ouver critica esse registro abaixo eh inserido informando como eh a critica e o codigo de erro
	aAdd(aCamposImp[1,2,2,Len(aCamposImp[1,2,2]),6],{"ï¿½ $ '01#02#03#04#05#06'","001"})
	
	aAdd(aCamposImp[1,2,2],{"Funcional",5,9,"ZZ1_FUNC","C",{}})
	aAdd(aCamposImp[1,2,2,Len(aCamposImp[1,2,2]),6],{"Type(ï¿½) == 'N'","002"})
	aAdd(aCamposImp[1,2,2,Len(aCamposImp[1,2,2]),6],{"iIf(ZZ1->ZZ1_OPER > '01',lVerFunc(ZZ1->ZZ1_CODEMP+ï¿½+ZZ1->ZZ1_DEPEND),.T.)","003"})
	aAdd(aCamposImp[1,2,2,Len(aCamposImp[1,2,2]),6],{"iIf(ZZ1->ZZ1_OPER == '01',!lVerFunc(ZZ1->ZZ1_CODEMP+ï¿½+ZZ1->ZZ1_DEPEND,ZZ1->ZZ1_CDBENE, ,.T.,ZZ1->( ZZ1_SEQUEN+ZZ1_FUNC+ZZ1_OPER )),.T.)","065"})
	
	aAdd(aCamposImp[1,2,2],{"Dependente	",14,2,"ZZ1_DEPEND","C",{}})
	aAdd(aCamposImp[1,2,2,Len(aCamposImp[1,2,2]),6],{"ï¿½ >= '00' .and. ï¿½ <= '99'","004"})
	
	//Alterado em 12/01/07, pois o criterio de busca observava tipo de dependente no BA1_MATEMP,
	//que nao esta sendo gravado. Tratado para o titular.
	//aAdd(aCamposImp[1,2,2,Len(aCamposImp[1,2,2]),6],{"iIf(ZZ1->ZZ1_OPER > '01',lVerFunc(ZZ1->ZZ1_FUNC+ï¿½,ZZ1->ZZ1_CDBENE),.T.)","005"})
	aAdd(aCamposImp[1,2,2,Len(aCamposImp[1,2,2]),6],{"iIf(ZZ1->ZZ1_OPER > '01',lVerFunc(IIf(ZZ1->ZZ1_CDBENE=='T',ZZ1->ZZ1_CODEMP+ZZ1->ZZ1_FUNC,ZZ1->ZZ1_CODEMP+ZZ1->ZZ1_FUNC+ï¿½),ZZ1->ZZ1_CDBENE),.T.)","005"})
	
	//    aAdd(aCamposImp[1,2,2,Len(aCamposImp[1,2,2]),6],{"iIf(ZZ1->ZZ1_OPER == '01' .and. ZZ1->ZZ1_CDBENE <> 'T',lVerFunc(ZZ1->ZZ1_CODEMP+ZZ1->ZZ1_FUNC+'00',ZZ1->ZZ1_CDBENE),.T.)","003"}) //bem
	aAdd(aCamposImp[1,2,2,Len(aCamposImp[1,2,2]),6],{"iIf(ZZ1->ZZ1_OPER == '01' .and. ZZ1->ZZ1_CDBENE <> 'T',lVerFunc(ZZ1->ZZ1_CODEMP+ZZ1->ZZ1_FUNC+'00',ZZ1->ZZ1_CDBENE, , , ZZ1->( ZZ1_SEQUEN+ZZ1_FUNC+ZZ1_OPER ) ),.T.)","003"})//bem
	
	aAdd(aCamposImp[1,2,2],{"BeneficiArio",16,80,"ZZ1_BENEF","C",{}})
	aAdd(aCamposImp[1,2,2,Len(aCamposImp[1,2,2]),6],{"ï¿½ > ''","006"})
	
	aAdd(aCamposImp[1,2,2],{"Ident. Gp Familiar",96,10,"ZZ1_IDGPF","C",{}})
	
	aAdd(aCamposImp[1,2,2],{"Ident. ConvEnio",106,	15,"ZZ1_IDCONV","C",{}})
	//	aAdd(aCamposImp[1,2,2,Len(aCamposImp[1,2,2]),6],{"!Type(ï¿½) == 'N'","007"})
	
	aAdd(aCamposImp[1,2,2],{"Ident. Conv. Dep.",121,4,"ZZ1_IDDEP","C",{}})
	//	aAdd(aCamposImp[1,2,2,Len(aCamposImp[1,2,2]),6],{"ï¿½ > ''","008"})
	
	aAdd(aCamposImp[1,2,2],{"Data Nascimento",125,10,"ZZ1_DTNASC","D",{}})
	aAdd(aCamposImp[1,2,2,Len(aCamposImp[1,2,2]),6],{"dtoc(ctod(ï¿½)) <> '  /  /  '","009"})
	
	aAdd(aCamposImp[1,2,2],{"UF de Nascimento",135,2,"ZZ1_UFNASC","D",{}})
	aAdd(aCamposImp[1,2,2],{"Tipo Documento	",137,3,"ZZ1_TPDOC","C",{}})
	aAdd(aCamposImp[1,2,2],{"Nro Documento",140,15,"ZZ1_NRODOC","C",{}})
	
	//Leonardo Portella - 25/01/17 - Incluï¿½dos U (tio) e N (neto) e B (sobrinho)
	aAdd(aCamposImp[1,2,2],{"Tipo Parentesco",155,4,"ZZ1_TPPARE","C",{}})
	aAdd(aCamposImp[1,2,2,Len(aCamposImp[1,2,2]),6],{"iIf(ZZ1->ZZ1_CDBENE == 'T',.T.,ï¿½ $ 'C#F#T#E#O#P#M#I#H#S#G#U#N#B#Q')","012"})
	
	aAdd(aCamposImp[1,2,2],{"Tipo Beneficiario",159,2,"ZZ1_TPBENE","C",{}})
	aAdd(aCamposImp[1,2,2,Len(aCamposImp[1,2,2]),6],{"ï¿½ $ '01#02#03#04#05#06#07#08#09'","013"})
	
	aAdd(aCamposImp[1,2,2],{"Cond. Beneficiario",161,1,"ZZ1_CDBENE","C",{}})
	aAdd(aCamposImp[1,2,2,Len(aCamposImp[1,2,2]),6],{"ï¿½ $ 'T#L#A'","014"})
	
	aAdd(aCamposImp[1,2,2],{"SeXo",162,1,"ZZ1_SEXO","C",{}})
	aAdd(aCamposImp[1,2,2,Len(aCamposImp[1,2,2]),6],{"ï¿½ $ 'F#M'","015"})
	
	aAdd(aCamposImp[1,2,2],{"Estado Civil",163,1,"ZZ1_ESTCIV","C",{}})
	aAdd(aCamposImp[1,2,2,Len(aCamposImp[1,2,2]),6],{"ï¿½ $ 'S#C#R#V#M#J'","016"})
	
	aAdd(aCamposImp[1,2,2],{"CPF",164,11,"ZZ1_CPF","C",{}})
	aAdd(aCamposImp[1,2,2,Len(aCamposImp[1,2,2]),6],{"iIf(ZZ1->ZZ1_CDBENE <> 'T',.T.,chkCPF(ï¿½))","017"})
	
	aAdd(aCamposImp[1,2,2],{"PIS",175,11,"ZZ1_PIS","C",{}})
	//aAdd(aCamposImp[1,2,2,Len(aCamposImp[1,2,2]),6],{"iIf(ZZ1->ZZ1_CDBENE <> 'T',.T.,ChkPIS(ï¿½))","018"}) nï¿½o criticar - Motta
	
	aAdd(aCamposImp[1,2,2],{"Banco",186,3,"ZZ1_BANCO","C",{}})
	aAdd(aCamposImp[1,2,2,Len(aCamposImp[1,2,2]),6],{"iIf(ZZ1->ZZ1_CDBENE <> 'T',.T.,chkBancos(ï¿½,1))","019"})
	aAdd(aCamposImp[1,2,2,Len(aCamposImp[1,2,2]),6],{"iIf(ZZ1->ZZ1_CDBENE <> 'T',.T.,chkBancos(ï¿½,2))","020"})
	
	aAdd(aCamposImp[1,2,2],{"Agencia",189,4,"ZZ1_AGENC","C",{}})
	aAdd(aCamposImp[1,2,2],{"Nï¿½mero Conta",193,11,"ZZ1_NUMCC","C",{}})
	
	aAdd(aCamposImp[1,2,2],{"Dt  Admissao",204,10,"ZZ1_DTADMI","D",{}})
	//aAdd(aCamposImp[1,2,2,Len(aCamposImp[1,2,2]),6],{"iIf(ZZ1->ZZ1_OPER > '01',chkData(ZZ1->ZZ1_FUNC,ï¿½,1),.T.)","024"}) critica retirada - Motta
	
	aAdd(aCamposImp[1,2,2],{"Dt  Desligamento",214,10,"ZZ1_DTDESL","D",{}})
	//aAdd(aCamposImp[1,2,2,Len(aCamposImp[1,2,2]),6],{"iIf(ZZ1->ZZ1_OPER > '01',chkData(ZZ1->ZZ1_FUNC,ï¿½,1),.T.)","025"}) critica retirada - Motta
	
	aAdd(aCamposImp[1,2,2],{"Nome Mae",224,60,"ZZ1_NOMMAE","C",{}})
	//	aAdd(aCamposImp[1,2,2,Len(aCamposImp[1,2,2]),6],{"ï¿½ > ''","025"}
	
	aAdd(aCamposImp[1,2,2],{"Contrato",284,5,"ZZ1_CONTR","C",{}})
	aAdd(aCamposImp[1,2,2,Len(aCamposImp[1,2,2]),6],{"ï¿½ >''","027"})
	
	aAdd(aCamposImp[1,2,2],{"Dt Inicio Contrato",289,10,"ZZ1_DTINCT","D",{}})
	//aAdd(aCamposImp[1,2,2,Len(aCamposImp[1,2,2]),6],{"iIf(ZZ1->ZZ1_OPER > '01',chkData(ZZ1->ZZ1_FUNC,ï¿½,1),.T.)","029"}) critica retirada - Motta
	
	aAdd(aCamposImp[1,2,2],{"Filial	",299,5,"ZZ1_FILIT","C",{}})
	
	aAdd(aCamposImp[1,2,2],{"Padrao	",775,4,"ZZ1_PADRAO","C",{}})
	
	aAdd(aCamposImp[1,2,2,Len(aCamposImp[1,2,2]),6],{"chkPadroes(ï¿½,ZZ1->ZZ1_OPER,ZZ1->ZZ1_FUNC+ZZ1->ZZ1_DEPEND,DParaTipoBnf(ZZ1->ZZ1_CDBENE))","028"})
	
	
	aAdd(aCamposImp[1,2,2],{"Dt Inicio Padrao",308,10,"ZZ1_DTINPD","D",{}})
	aAdd(aCamposImp[1,2,2],{"Dt Fim Padrao",318,10,"ZZ1_DTFIPD","D",{}})
	
	aAdd(aCamposImp[1,2,2],{"Base de Calculo",328,	11,"ZZ1_DTBASE","D",{}})
	
	aAdd(aCamposImp[1,2,2],{"Codigo Empresa	",339,4,"ZZ1_CODEMP","C",{}})
	aAdd(aCamposImp[1,2,2,Len(aCamposImp[1,2,2]),6],{"ï¿½ >''","033"})
	
	aAdd(aCamposImp[1,2,2],{"Nome Empresa",343,30,"ZZ1_NOMEMP","C",{}})
	
	aAdd(aCamposImp[1,2,2],{"Codigo Lotacao	",373,17,"ZZ1_CODLOT","C",{}})
	aAdd(aCamposImp[1,2,2],{"Orgao Funcionario",390,30,"ZZ1_ORGAO","C",{}})
	//aAdd(aCamposImp[1,2,2,Len(aCamposImp[1,2,2]),6],{"ï¿½ >''","033"}) - esta critica nao existe - Motta
	
	aAdd(aCamposImp[1,2,2],{"UF Lotacao	",420,2,"ZZ1_UFLOT","C",{}})
	aAdd(aCamposImp[1,2,2],{"CDUNIREG",422,3,"ZZ1_CDUNI","C",{}})
	
	aAdd(aCamposImp[1,2,2],{"Data EXclusao",425,10,"ZZ1_DTEXC","D",{}})
	aAdd(aCamposImp[1,2,2,Len(aCamposImp[1,2,2]),6],{"iIf(ZZ1->ZZ1_OPER == '03',chkData(ZZ1->ZZ1_FUNC,ï¿½,3),.T.)","036"})
	
	// critica retirada , sera lancado valor default Paulo Motta 18/01/07
	aAdd(aCamposImp[1,2,2],{"Motivo Exclusao",435,3,"ZZ1_MOTEXC","C",{}})
	aAdd(aCamposImp[1,2,2,Len(aCamposImp[1,2,2]),6],{"iIf(ZZ1->ZZ1_OPER == '03',ï¿½ >'',.T.)","037"})
	
	aAdd(aCamposImp[1,2,2],{"Dt Inclusao Oper.",438,10,"ZZ1_DTINCO","C",{}})
	aAdd(aCamposImp[1,2,2,Len(aCamposImp[1,2,2]),6],{"chkData(ZZ1->ZZ1_FUNC,ï¿½,3)","034"})
	
	aAdd(aCamposImp[1,2,2],{"Ind. Envio Inform.	",448,1,"ZZ1_INDENV","C",{}})
	
	aAdd(aCamposImp[1,2,2],{"Logradouro	",449,50,"ZZ1_LOGRAD","C",{}})
	aAdd(aCamposImp[1,2,2,Len(aCamposImp[1,2,2]),6],{"ï¿½ >''","038"})
	
	aAdd(aCamposImp[1,2,2],{"Numero	",499,5,"ZZ1_NUMERO","C",{}})
	aAdd(aCamposImp[1,2,2],{"Complemento",504,10,"ZZ1_COMPLE","C",{}})
	aAdd(aCamposImp[1,2,2],{"Bairro	",514,40,"ZZ1_BAIRRO","C",{}})
	
	
	aAdd(aCamposImp[1,2,2],{"CEP",554,	9,"ZZ1_CEP","C",{}})
	aAdd(aCamposImp[1,2,2,Len(aCamposImp[1,2,2]),6],{"lCEPOkS(ï¿½)","039"})
	
	aAdd(aCamposImp[1,2,2],{"Cidade	",563,40,"ZZ1_CIDADE","C",{}})
	aAdd(aCamposImp[1,2,2,Len(aCamposImp[1,2,2]),6],{"chkCidades(ZZ1->ZZ1_CEP,ï¿½)","041"}	)
	
	aAdd(aCamposImp[1,2,2],{"UF	",603,2,"ZZ1_UF","C",{}})
	
	aAdd(aCamposImp[1,2,2],{"DDD-Resid.",605,4,"ZZ1_DDDRES","C",{}})
	aAdd(aCamposImp[1,2,2],{"Telefone-Resid.",609,8,"ZZ1_TELRES","C",{}})
	//aAdd(aCamposImp[1,2,2,Len(aCamposImp[1,2,2]),6],{"iIf(ZZ1->ZZ1_DDDRES > '',ï¿½>'',.T.)","042"}) - criticas retiradas Motta
	//aAdd(aCamposImp[1,2,2,Len(aCamposImp[1,2,2]),6],{"iIf(ï¿½ > '',ZZ1->ZZ1_DDDRES>'',.T.)","043"})
	
	aAdd(aCamposImp[1,2,2],{"DDD-Comercial",617,4,"ZZ1_DDDCOM","C",{}})
	aAdd(aCamposImp[1,2,2],{"Telef. Comercial",621,8,"ZZ1_TELCOM","C",{}})
	aAdd(aCamposImp[1,2,2,Len(aCamposImp[1,2,2]),6],{"iIf(AllTrim(ZZ1->ZZ1_DDDCOM) > '',ï¿½>'',.T.)","044"})
	aAdd(aCamposImp[1,2,2,Len(aCamposImp[1,2,2]),6],{"iIf(AllTrim(ï¿½) > '',ZZ1->ZZ1_DDDCOM>'',.T.)","045"})
	
	aAdd(aCamposImp[1,2,2],{"Ramal",629,5,"ZZ1_RAMAL","C",{}})
	aAdd(aCamposImp[1,2,2,Len(aCamposImp[1,2,2]),6],{"iIf(ï¿½ > '',ZZ1->ZZ1_TELCOM>'',.T.)","046"})
	
	aAdd(aCamposImp[1,2,2],{"DDD Celular",634,4,"ZZ1_DDDCEL","C",{}})
	aAdd(aCamposImp[1,2,2],{"Celular",638,8,"ZZ1_TELCEL","C",{}})
	aAdd(aCamposImp[1,2,2,Len(aCamposImp[1,2,2]),6],{"iIf(AllTrim(ZZ1->ZZ1_DDDCEL) > '',ï¿½>'',.T.)","047"})
	aAdd(aCamposImp[1,2,2,Len(aCamposImp[1,2,2]),6],{"iIf(AllTrim(ï¿½) > '',ZZ1->ZZ1_DDDCEL>'',.T.)","048"})
	
	aAdd(aCamposImp[1,2,2],{"E-mail	",647,79,"ZZ1_EMAIL","C",{}})
	
	aAdd(aCamposImp[1,2,2],{"Funcional Anterior	",726,9,"ZZ1_FUNANT","C",{}})
	//	aAdd(aCamposImp[1,2,2,Len(aCamposImp[1,2,2]),6],{"ï¿½ >''","063"})
	
	aAdd(aCamposImp[1,2,2],{"Outros",735,46,"ZZ1_OUTROS","C",{}})
	aAdd(aCamposImp[1,2,2],{"Indicador Carencia	",781,1,"ZZ1_INDCAR","C",{}})
	aAdd(aCamposImp[1,2,2],{"Indicador Transf.",782,1,"ZZ1_INDTRA","C",{}})
	aAdd(aCamposImp[1,2,2],{"Data Transferencia	",783,10,"ZZ1_DTTRAN","C",{}})
	aAdd(aCamposImp[1,2,2],{"Tabela Erro",941,60,"ZZ1_TABERR","C",{}})
	aAdd(aCamposImp[1,2,2],{"Seq. Ord.",889,11,"ZZ1_SEQREG","C",{}})//MOTTA 27/7/07
	//aAdd(aCamposImp[1,2,2],{"Ope. Origem",900,4,"ZZ1_OPEORI","C",{}})//BIANCHINI 26/10/12
	aAdd(aCamposImp[1,2,2],{"OPC.ADU",1004,1,"ZZ1_ASSMED","C",{}})//BIANCHINI 29/08/14
	
	aAdd(aCamposImp[1,2,2],{"CNS"		,1009	,15	,"ZZ1_CNS"		,"C",{}})	//Leonardo Portella - 06/06/16
	aAdd(aCamposImp[1,2,2],{"NASVIV"	,1024	,16	,"ZZ1_NASVIV"	,"C",{}})	//Leonardo Portella - 06/06/16 - Obs: BTS_DENAVI com 16 dï¿½gitos
	
	aAdd(aCamposImp[1,2,2,Len(aCamposImp[1,2,2]),6],{"iIf(ZZ1->ZZ1_OPER == '03',chkData(ZZ1->ZZ1_FUNC,ï¿½,3),.T.)","036"})
	
	aAdd(aCamposImp[1,2,2],{"CPFPREP"	,793	,1	,"ZZ1_CPFPRE"	,"C",{}})	//Leonardo Portella - 18/07/16
	
	aAdd(aCamposImp[1,2,2],{"MATREP"	,1040	,20	,"ZZ1_MATREP"	,"C",{}})	//Fabio Bianchini- 11/07/1977 - Matricula de Repasse
	aAdd(aCamposImp[1,2,2],{"PORTABILIDADE"	,1060	,1	,"ZZ1_PORTAB"	,"C",{}})	//Fabio Bianchini- 11/07/1977 - Portabilidade: "S/N"

	aAdd(aCamposImp[1,2,2],{"TPCARE"	,1081	,1	,"ZZ1_TPCARE"	,"C",{}})	// Fred - 19/11/21 - tipo de carencia
	aAdd(aCamposImp[1,2,2],{"DTCONC"	,1082	,10	,"ZZ1_DTCONC"	,"D",{}})	// Fred - 19/11/21 - data vinc. concorrencia

	aAdd(aCamposImp[1,2,2],{"CASAME"	,1092	,10	,"ZZ1_CASAME"	,"D",{}})	// Fred - 16/03/22 - data casamento
	
	
Return

/*/
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ä¿ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½Funcao    ï¿½   IMPLEG   ï¿½ Autor ï¿½ Wagner Mobile Costa ï¿½ Data ï¿½ 28.08.03 ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ä´ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½Descricao ï¿½ Exibe a legenda...                                         ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ù±ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
/*/

User Function IMPLEG(nTipo)
	
	Local aLegenda
	
	If nTipo == 1
		aLegenda := { 	{ aCdCores[1,1],aCdCores[1,2] },;
			{ aCdCores[2,1],aCdCores[2,2] },;
			{ aCdCores[3,1],aCdCores[3,2] },;
			{ aCdCores[4,1],aCdCores[4,2] },;
			{ aCdCores[5,1],aCdCores[5,2] },;
			{ aCdCores[6,1],aCdCores[6,2] }  }
	Else
		aLegenda := { 	{ aCdCores[1,1],aCdCores[1,2] },;
			{ aCdCores[2,1],aCdCores[2,2] }}
	EndIf
	
	BrwLegenda(cCadastro,"Status" ,aLegenda)
	
Return

/*/
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ä¿ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½Funcao    ï¿½   IMPCMP   ï¿½ Autor ï¿½ Antonio de Padua    ï¿½ Data ï¿½ 28.08.03 ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ä´ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½Descricao ï¿½ Mostra Composicao do Arquivo                               ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ù±ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
/*/

User Function IMPCMP()
	
	Local cFil := "ZZ1_FILIAL = '" + xFilial("ZZ1") + "' .AND. ZZ1_SEQUEN = '" + ZZ0->ZZ0_SEQUEN + "'"
	
	//Monta matriz com as opcoes do browse...
	Private aRotina   	:=	{	{ "Pesquisar"	    , 'AxPesqui'	  	, 0 , K_Pesquisar  	},;
		{ "Visualizar"		, 'AxVisual'	  	, 0 , K_Visualizar 	},;
		{ "Erros"			, 'U_IMPLGER'	  	, 0 , K_Visualizar 	},;
		{ "Legenda"     	, "U_IMPLEG(2)"		, 0 , K_Incluir     } }
	
	Private aCdCores 	:= { 	{ 'BR_VERDE'    ,'Linha OK' 		},;
		{ 'BR_VERMELHO'	,'Linha Criticada' 	}}
	
	Private aCores      := { 	{ 'AllTrim(ZZ1_TABERR) = ""'	,aCdCores[1,1] },;
		{ 'AllTrim(ZZ1_TABERR) > ""'	,aCdCores[2,1] }}
	
	DbSelectArea("ZZ1")
	DBSetOrder(1)
	
	SET FILTER TO &cFil
	
	//Bianchini - Versï¿½o 11
	mBrowse(006,001,022,075,"ZZ1" ,nil ,nil ,nil ,nil , 4  , aCores,nil ,nil ,nil ,   ,.T.,nil)
	
Return

/*/
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ä¿ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½Funcao    ï¿½ lVerFunc    ï¿½ Autor ï¿½ Antonio de Padua    ï¿½ Data ï¿½ 16.05.06 ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ä´ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½Descricao ï¿½ Verifica o cadastro de uma Matricula funcional             ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ù±ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
/*/

Static Function lVerFunc(cMatric, cTipo, cDepend, lvArq, cSequen)
	
	Local nOrdBA1 := BA1->(IndexOrd())
	Local lRet    := .T.
	Local nOrd    := ZZ1->(IndexOrd())
	Local nRecno  := ZZ1->(Recno())
	
	If cTipo <> "T" .and. !lvArq  //se for inclusao de beneficiario novo ou uma reativacao de beneficario excluido anteriormente
		ZZ1->(DbSetOrder(3))
		If ZZ1->(DbSeek(xFilial("ZZ1")+cMatric))
			ZZ1->(DbSetOrder(nOrd))
			ZZ1->(Dbgoto(nRecno))
			Return .T.
		EndIf
	EndIf
	
	ZZ1->(DbSetOrder(nOrd))
	ZZ1->(Dbgoto(nRecno))
	
	BA1->(DbSetOrder(6))
	lRet := BA1->(DbSeek(xFilial("BA1")+cMatric))
	
	BA1->(DbSetOrder(nOrdBA1))
	
Return lRet

/*
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Í»ï¿½ï¿½
ï¿½ï¿½ï¿½Programa  ï¿½DParaTpBnfï¿½Autor  ï¿½Antonio de Padua    ï¿½ Data ï¿½  17/05/06   ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Í¹ï¿½ï¿½
ï¿½ï¿½ï¿½Desc.     ï¿½ Retorna o Depara dos Tipos de Benef ITAU                   ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Í¹ï¿½ï¿½
ï¿½ï¿½ï¿½Uso       ï¿½ AP                                                         ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Í¼ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
*/

Static Function DParaTpBnf(cTipo)
	
	If cTipo == "L"   //Legal
		cTipo := "D"
	EndIf
	
Return(cTipo)

/*/
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ä¿ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½Funcao    ï¿½ ChkData    ï¿½ Autor ï¿½ Antonio de Padua    ï¿½ Data ï¿½ 16.05.06 ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ä´ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½Descricao ï¿½ Checa a Data olhando no cadastro                           ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ù±ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
/*/

Static Function chkData(cMatric,cData,nTipo)
	
	Local _aAreBA3 := BA3->(GetArea()) //Angelo Henrique - Data: 09/06/2017
	
	If cMatric > ""
		
		BA3->(dbSetOrder(5))
		If BA3->(dbSeek(xFilial("BA1")+ZZ0->ZZ0_CODEMP+cMatric))
			
			If nTipo == 1
				Return(ctod(cData) <= BA3->BA3_DATBAS)
			ElseIf nTipo == 2
				Return(ctod(cData) <= BA3->BA3_DATBAS)
			EndIf
			
		EndIf
		
	Else
		
		If (dtoc(ctod(cData) <> "  /  /  ")) <> nil
			Return(.T.)
		Else
			Return(.F.)
		EndIf
		
	EndIf
	
	RestArea(_aAreBA3) //Angelo Henrique - Data: 09/06/2017
	
Return .F.

/*/
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ä¿ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½Funcao    ï¿½ ChkBancos  ï¿½ Autor ï¿½ Antonio de Padua    ï¿½ Data ï¿½ 16.05.06 ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ä´ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½Descricao ï¿½ Checa o banco olhando no cadastro                          ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ù±ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
/*/

Static Function chkBancos(cBanco,nTipo)
	// Aceitando Sempre True por causa do Itau
Return(.T.)

/*/
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ä¿ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½Funcao    ï¿½ lCEPOk    ï¿½ Autor ï¿½ Antonio de Padua    ï¿½ Data ï¿½ 17.05.06 ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ä´ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½Descricao ï¿½ Checa o CEP olhando no cadastro                            ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ù±ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
/*/

Static Function lCEPOk(cCEP)
	
	Local lValida := .T.
	
	cCep := Replace(cCEP,'-','')
	
	BC9->(DbSetOrder(1))
	
	If !BC9->(DbSeek(xFilial("BC9")+cCEP))
		lValida := .F.
	EndIf
	
Return lValida

/*/
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ä¿ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½Funcao    ï¿½ ChkCidades ï¿½ Autor ï¿½ Antonio de Padua    ï¿½ Data ï¿½ 17.05.06 ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ä´ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½Descricao ï¿½ Checa a Cidade olhando no cadastro                         ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ù±ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
/*/

Static Function chkCidades(cCep,cCidade)
	
	If At("-",cCep) > 0
		cCep := Substr(cCep,1,5)+Substr(cCep,7,3)
	EndIf
	
	BC9->(DbSetOrder(1))
	If ! BC9->(DbSeek(xFilial("BC9")+cCEP))
		If cCidade <> BC9->BC9_MUN
			Return(.T.)
		EndIf
	EndIf
	
Return(.T.)

/*/
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ä¿ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½Funcao    ï¿½ ChkPadroes ï¿½ Autor ï¿½ Antonio de Padua    ï¿½ Data ï¿½ 17.05.06 ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ä´ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½Descricao ï¿½ Checa o Padrao                                             ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ù±ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
/*/

Static Function chkPadroes(cPadrao,cOper,cMatric,cTpBnf)
	
	Local _aAreBA3 := BA3->(GetArea()) //Angelo Henrique - Data:09/06/2017
	
	cTempPadrao := ""
	
	If Empty(AllTrim(cPadrao))
		Return(.F.)
	EndIf
	
	
	cSql := "SELECT DISTINCT BT6_CODPRO "
	cSql += " FROM  "+RetSqlName("BT6") + " "
	cSql += " WHERE D_E_L_E_T_=' ' "
	cSql += " AND BT6_CODINT='"+ZZ0->ZZ0_CODOPE+"'"
	cSql += " AND BT6_NUMCON='"+ZZ0->ZZ0_NUMCON+"'"
	cSql += " AND BT6_SUBCON='"+ZZ0->ZZ0_SUBCON+"'"
	cSql += " AND BT6_CODIGO='"+ZZ0->ZZ0_CODEMP+"'"
	PLsQuery(cSql,"TMPBT6")
	
	If !TMPBT6->(EOF())
		While !TMPBT6->(EOF())
			cTempPadrao:=cTempPadrao+TMPBT6->BT6_CODPRO+"#"
			TMPBT6->(DbSkip())
		EndDo
	EndIf
	cTempPadrao:=Substr(cTempPadrao,1,Len(cTempPadrao)-1)
	TMPBT6->(DbCloseArea())
	
	If ! (cPadrao $ cTempPadrao)
		Return (.F.)
	EndIf
	
	If Empty(AllTrim(cPadrao))
		Return(.F.)
	EndIf
	
	If cOper > "01"
		If !Empty(AllTrim(cMatric))
			BA3->(dbSetOrder(5))
			If BA3->(dbSeek(xFilial("BA3")+ZZ0->ZZ0_CODEMP+cMatric))
				If BA3->BA3_CODPLA <> dParaProd(cPadrao,cTpBnf)
					Return(.F.)
				EndIf
			EndIf
		EndIf
	EndIf
	
	RestArea(_aAreBA3) //Angelo Henrique - Data: 09/06/2017
	
Return(.T.)

/*
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Í»ï¿½ï¿½
ï¿½ï¿½ï¿½Programa  ï¿½DParaProd  ï¿½Autor  ï¿½Antonio de Padua    ï¿½ Data ï¿½  17/05/06   ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Í¹ï¿½ï¿½
ï¿½ï¿½ï¿½Desc.     ï¿½ Retorna o Depara dos Produtos ITAU                         ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Í¹ï¿½ï¿½
ï¿½ï¿½ï¿½Uso       ï¿½ AP                                                         ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Í¼ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
*/

Static Function dParaProd(cPadrao,cTipo)
	
	cProduto := ""
	cProduto := cPadrao
	
Return(cProduto)

/*
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Í»ï¿½ï¿½
ï¿½ï¿½ï¿½Programa  ï¿½DParaTipoBnfï¿½Autor  ï¿½Antonio de Padua    ï¿½ Data ï¿½  17/05/06   ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Í¹ï¿½ï¿½
ï¿½ï¿½ï¿½Desc.     ï¿½ Retorna o Depara dos Tipos de Benef ITAU                   ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Í¹ï¿½ï¿½
ï¿½ï¿½ï¿½Uso       ï¿½ AP                                                         ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Í¼ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
*/

Static Function DParaTipoBnf(cTipo)
	
	If cTipo == "L"
		cTipo := "D"
	EndIf
	
Return(cTipo)


/*
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Í»ï¿½ï¿½
ï¿½ï¿½ï¿½Programa  ï¿½DPTipoBnfbd ï¿½Autor  ï¿½Paulo Motta         ï¿½ Data ï¿½  17/05/06   ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Í¹ï¿½ï¿½
ï¿½ï¿½ï¿½Desc.     ï¿½ Retorna o Depara dos Tipos de Benef ITAU (apenas para gra-   ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½          ï¿½ vacao pois o Agregado e marcado como T (titular)             ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Í¹ï¿½ï¿½
ï¿½ï¿½ï¿½Uso       ï¿½ AP                                                           ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Í¼ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
*/

Static Function DPTipoBnfbd(cTipo)
	
	If cTipo == "L"
		cTipo := "D"
	EndIf
	
	/*apenas para gravacao pois o Agregado e marcado como T (titular) */
	
	//Se for Tipo A ï¿½ para permanecer como agregado no protheus tbm.
	/*If cTipo == "A"
	cTipo := "T"
EndIf*/


Return(cTipo)

/*
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Í»ï¿½ï¿½
ï¿½ï¿½ï¿½Programa  ï¿½DParaBloq ï¿½Autor  ï¿½Antonio de Padua    ï¿½ Data ï¿½  18/05/06   ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Í¹ï¿½ï¿½
ï¿½ï¿½ï¿½Desc.     ï¿½ Retorna o Depara dos Bloqueios de Benef ITAU               ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Í¹ï¿½ï¿½
ï¿½ï¿½ï¿½Uso       ï¿½ AP                                                         ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Í¼ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
*/
/*
Static Function DParaBloq(cBlq)
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
	Else
		cBlq := "017" // Paulo Motta 10-02-2007
	EndIf
Return(cBlq)
*/

/*
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Í»ï¿½ï¿½
ï¿½ï¿½ï¿½Programa  ï¿½DParaGrauParï¿½Autor  ï¿½Antonio de Padua    ï¿½ Data ï¿½  17/05/06   ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Í¹ï¿½ï¿½
ï¿½ï¿½ï¿½Desc.     ï¿½ Retorna o Depara dos Graus de Parentescos                  ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Í¹ï¿½ï¿½
ï¿½ï¿½ï¿½Uso       ï¿½ AP                                                         ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Í¼ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
*/

Static Function DParaGrauPar(cGrauPa,cSexo, cDepend)
	
	cGrauPa := AllTrim(cGrauPa)
	
	If cGrauPa == "" .or. ( cGrauPa == "T" .and. cDepend = '00')
		cGrauPa := "01"
	ElseIf cGrauPa == "C"
		If cSexo == "1"
			cGrauPa := "04"
		Else
			cGrauPa := "02"
		EndIf
	ElseIf cGrauPa == "F"
		If cSexo == "1"
			cGrauPa := "05"
		Else
			cGrauPa := "06"
		EndIf
	ElseIf cGrauPa == "T"
		cGrauPa := "23"
	ElseIf cGrauPa == "E"
		cGrauPa := "24"
	ElseIf cGrauPa == "O"
		cGrauPa := "11"
	ElseIf cGrauPa == "P"
		cGrauPa := "07"
	ElseIf cGrauPa == "M"
		cGrauPa := "08"
	ElseIf cGrauPa == "I"
		cGrauPa := "14"
	ElseIf cGrauPa == "H"
		cGrauPa := "03"
	ElseIf cGrauPa == "S"
		cGrauPa := "09"
	ElseIf cGrauPa == "G"
		cGrauPa := "10"
	ElseIf cGrauPa == "U" //Leonardo Portella - 25/01/17 - Chamado 34628
		cGrauPa := "26"
	ElseIf cGrauPa == "N" //Leonardo Portella - 25/01/17 - Solicitado pelo Alexandre
		cGrauPa := "17"
	ElseIf cGrauPa == "B" //Leonardo Portella - 25/01/17 - Chamado 34628
		cGrauPa := "27"
	ElseIf cGrauPa == "Q" //Angelo Henrique - 19/10/18 - Chamado 53594
		cGrauPa := "25"
	EndIf
	
Return(cGrauPa)

/*
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Í»ï¿½ï¿½
ï¿½ï¿½ï¿½Programa  ï¿½IncluiUsuarï¿½Autor  ï¿½Antonio de Padua    ï¿½ Data ï¿½  18/05/06   ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Í¹ï¿½ï¿½
ï¿½ï¿½ï¿½Desc.     ï¿½ Funcao que trata a linha tipo inclusao                     ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½          ï¿½                                                            ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Í¹ï¿½ï¿½
ï¿½ï¿½ï¿½Uso       ï¿½ AP                                                         ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Í¼ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
*/

Static Function IncluiUsuar()
	
	Local lTitCad := .F.
	Local l_UsuCad := .F.
	Local cMatTit := ""
	Local cMatUsr := ""
	Local lFamCad := .F.
	Private lTit    := .F.
	Private lAgr    := .F. // 10/07/07
	Private cNumCon := ""
	Private cSubCon := ""
	Private cEquipe := ""
	Private cVendedor:=""
	Private cVendedo2:=""
	Private cNovaMatric := ""
	
	lTit := ZZ1->ZZ1_CDBENE == 'T'
	lAgr := ZZ1->ZZ1_CDBENE == 'A' // 10/07/07
	
	//FABIO BIANCHINI - 30/07/2014
	//PEGAR VERSAO DO CONTRATO E DO SUBCONTRATO DA EMPRESA NO ARQUIVO DE IMPORTACAO
	cVerCon := chkVerConSub(ZZ0->ZZ0_CODOPE,ZZ0->ZZ0_CODEMP,ZZ0->ZZ0_NUMCON,ZZ0->ZZ0_SUBCON,'C')
	cVerSub := chkVerConSub(ZZ0->ZZ0_CODOPE,ZZ0->ZZ0_CODEMP,ZZ0->ZZ0_NUMCON,ZZ0->ZZ0_SUBCON,'S')
	//FIM
	
	/*If lAgr                                                                // 10/07/07
	cNovaMatric := PLPROXMAT(ZZ0->ZZ0_CODOPE,ZZ0->ZZ0_CODEMP)           // 10/07/07
Else*/
	/*
	BA3->(dbSetOrder(5))
	If BA3->(dbSeek(xFilial("BA1")+ZZ0->ZZ0_CODEMP+ZZ1->ZZ1_FUNC))
		lFamCad := .T.
	Else
		cNovaMatric := PLPROXMAT(ZZ0->ZZ0_CODOPE,ZZ0->ZZ0_CODEMP)
	EndIf
	*/
	
	BA3->(dbOrderNickName("BA3EMCOSUB"))
	
	If 	( cFuncPesq == AllTrim(ZZ1->ZZ1_FUNC) )
		lFamCad := .T.//Familia tem cadastro ativo pq ja Verifiquei antes. Se tiver q ser incluido, foi incluido na iteracao anterior.
	ElseIf BA3->(dbSeek(xFilial("BA1")+ZZ0->ZZ0_CODEMP+ZZ0->ZZ0_NUMCON+cVerCon+ZZ0->ZZ0_SUBCON+cVerSub+AllTrim(ZZ1->ZZ1_FUNC)))
		
		/**'Marcela Coimbra - 03/09/15'**/
		
		While BA3->( !EOF() ) .and. ;
				AllTrim(BA3->(BA3_FILIAL+BA3_CODEMP+BA3_CONEMP+BA3_VERCON+BA3_SUBCON+BA3_VERSUB+BA3_MATEMP)) == AllTrim(xFilial("BA1")+ZZ0->ZZ0_CODEMP+ZZ0->ZZ0_NUMCON+cVerCon+ZZ0->ZZ0_SUBCON+cVerSub+AllTrim(ZZ1->ZZ1_FUNC))
			
			If empty(ba3->ba3_datblo)//Familia tem cadastro ativo
				
				lFamCad 	:= .T.
				exit
				
			EndIf
			
			BA3->( dbSkip() )
			
			
		EndDo
		
		/**'Fim Marcela Coimbra'**/
	Else
		lFamCad 	:= .F.
	EndIf
	
	If !lFamCad//Se familia nao tem cadastro
		cNovaMatric 	:= PLPROXMAT(ZZ0->ZZ0_CODOPE,ZZ0->ZZ0_CODEMP)
		cFuncPesq 		:= AllTrim(ZZ1->ZZ1_FUNC)
	EndIf
	
	//EndIf
	/*
	If !lFamCad
		cNovaMatric := PLPROXMAT(ZZ0->ZZ0_CODOPE,ZZ0->ZZ0_CODEMP)
	EndIf
	*/
	//BA1->(dbSetOrder(20))
	/*
	BA1->(dbOrderNickName("BA1MATEMP"))
	If BA1->(dbSeek(xFilial("BA1")+ZZ1->ZZ1_CODEMP+ZZ1->ZZ1_FUNC+ZZ1->ZZ1_DEPEND))
		l_UsuCad := .T.
		cMatUsr := BA1->BA1_CODINT+BA1->BA1_CODEMP+BA1->BA1_MATRIC+BA1->BA1_TIPREG
	EndIf
	*/
	BA1->(dbOrderNickName("BA1EMCOSUB"))
	
	
	If BA1->(dbSeek(xFilial("BA1")+ZZ1->ZZ1_CODEMP+ZZ0->ZZ0_NUMCON+cVerCon+ZZ0->ZZ0_SUBCON+cVerSub+AllTrim(ZZ1->ZZ1_FUNC)+ZZ1->ZZ1_DEPEND))
		If empty(BA1->BA1_DATBLO) //SE USUARIO ESTA ATIVO
			l_UsuCad := .T.
			cMatUsr := BA1->BA1_CODINT+BA1->BA1_CODEMP+BA1->BA1_MATRIC+BA1->BA1_TIPREG
		EndIf
	EndIf
	
	
	If !lFamCad  // Familia Nao Cadastrada, deve-se cadastrar
		cNumCon := ZZ0->ZZ0_NUMCON
		
		cSql := " SELECT * FROM "+RetSqlName("BQC") + ""
		cSql += " Where BQC_CODIGO = '"+ZZ0->ZZ0_CODOPE+ZZ0->ZZ0_CODEMP+"'"
		cSql += " AND BQC_NUMCON = '"+cNumCon+"'"
		cSql += " AND BQC_VERCON = '"+cVercon+"' "
		cSql += " AND BQC_SUBCON = '"+ZZ0->ZZ0_SUBCON+"' "
		cSql += " AND BQC_VERSUB = '"+cVerSub+"' "
		cSql += " AND D_E_L_E_T_ = ' '"
		
		PLsQuery(cSql,"TMPBQC")
		
		If !TMPBQC->(EOF())
			cEquipe:=TMPBQC->BQC_EQUIPE
			cVendedor:=TMPBQC->BQC_CODVEN
			cVendedo2:=TMPBQC->BQC_CODVE2
			//GLPI:13011 - BIANCHINI - 27/08/2014
			If !Empty(TMPBQC->BQC_YSTSCO)
				cArt3031 := TMPBQC->BQC_YSTSCO
			EndIf
		EndIf
		TMPBQC->(DbCloseArea())
		
		cSubCon := ZZ0->ZZ0_SUBCON
		
		
		If cSubCon == ""
			cSubCon := "000000001" // 18/5/07
		EndIf
		
		BI3->(DbSetOrder(1))
		If BI3->(DbSeek(xFilial("BT6")+BT6->BT6_CODINT+dParaProd(ZZ1->ZZ1_PADRAO,dParaTipoBnf(ZZ1->ZZ1_CDBENE))+"001"))
			lFamCad := .T.
			//BIANCHINI - 28/08/2014 - Gerar Cliente quando o subcontrato for Art.30/31
			If (cArt3031 == ZZ0->ZZ0_ART30) .and. !empty(cArt3031) .and. !empty(ZZ0->ZZ0_ART30)
				cCodcli := GerPreSA1(ZZ1->ZZ1_CPF,1)
				BA3->(RecLock("BA3",.T.))
				GerPreBA3(1,cCodcli)
				BA3->(MsUnlock())
			Else
				BA3->(RecLock("BA3",.T.))
				GerPreBA3(1,nil)
				BA3->(MsUnlock())
			EndIf
			
		EndIf
	EndIf
	
	If ! l_UsuCad .and. lFamCad /// Esse usuario nao esta cadastrado
		
		//Leonardo Portella - Inï¿½cio - 21/02/17
		
		BTS->(DBSetOrder(3))
		
		BTS->(DbSeek(xFilial("BTS") + AllTrim(ZZ1->ZZ1_CPF)) )
		
		lNovaVida	:= !BTS->(Found()) .or. ( BTS->BTS_DATNAS <> CtoD(ZZ1->ZZ1_DTNASC) )
		
		If lNovaVida .and. BTS->(Found())
			
			//Tento verificar se deve criar outra vida por aproximacao do nome em ultima instancia.
			
			aArea		:= GetArea()
			
			cAlVida		:= GetNextAlias()
			
			cQryVida 	:= "SELECT UTL_MATCH.JARO_WINKLER_SIMILARITY(" 														+ CRLF
			cQryVida 	+= "       ALFA_NUM_EXCECAO_PARAMETRO('" + Upper(AllTrim(ZZ1->ZZ1_BENEF)) + "')," 					+ CRLF
			cQryVida 	+= "       ALFA_NUM_EXCECAO_PARAMETRO('" + Upper(AllTrim(BTS->BTS_NOMUSR)) + "')) SIMILARIDADE" 	+ CRLF
			cQryVida 	+= "FROM DUAL" 																						+ CRLF
			
			TcQuery cQryVida New Alias cAlVida
			
			lNovaVida := ( cAlVida->SIMILARIDADE < 85 )
			
			cAlVida->(DbCloseArea())
			
			RestArea(aArea)
			
		EndIf
		
		//BTS->(RecLock("BTS",.T.))
		BTS->(RecLock("BTS",lNovaVida))//Insere ou atualiza a vida encontrada anteriormente
		GerPreBTS(1,lTit)
		BTS->(MsUnlock())
		
		//Leonardo Portella - Fim - 21/02/17
		
		BA1->(RecLock("BA1",.T.))
		GerPreBA1(1,lTit)
		BA1->(MsUnlock())
		
		U_GerCarBen( BA1->(RECNO()), 2 )	// Fred - 19/11/21 - tratamento de carencia
		//U_GerDtLim( BA1->(RECNO()), 3 )	// Fred - 03/01/21 - tratamento da data limite
	
	EndIf
	
	If lFamCad
		AtuProduto()
		AtuOpcional() ////essa funcao precisa mexer, colocando ADU indiscriminadamente - BIANCHINI - 30/07/2014
		AtuAdesao()
	EndIf
	
	//----------------------------------------------------------------
	//Angelo Henrique - Data: 07/01/2019
	//Rotina para aplicar carï¿½ncia no processo de migraï¿½ï¿½o
	//da empresa A4.
	//----------------------------------------------------------------
	If cEmpAnt == '02'
		AtuCar()
	EndIf
	
Return

/*
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Í»ï¿½ï¿½
ï¿½ï¿½ï¿½Programa  AlteraUsuar ï¿½Autor  ï¿½Antonio de Padua    ï¿½ Data ï¿½  18/05/06   ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Í¹ï¿½ï¿½
ï¿½ï¿½ï¿½Desc.     ï¿½ Funcao que trata a linha tipo Alteracao                    ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Í¼ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
*/

Static Function AlteraUsuar(nTipo)
	
	Local lTit 		:= .F.
	Local _cQuery	:= "" //Angelo Henrique - Data: 05/06/2017
	Local _cAlias1	:= GetNextAlias() //Angelo Henrique - Data: 05/06/2017
	Local _aArBA3	:= Nil
	Local _aArBA1	:= Nil
	
	lTit := ZZ1->ZZ1_CDBENE == 'T'
	
	//FABIO BIANCHINI - 30/07/2014
	//PEGAR VERSAO DO CONTRATO E DO SUBCONTRATO DA EMPRESA NO ARQUIVO DE IMPORTACAO
	cVerCon := chkVerConSub(ZZ0->ZZ0_CODOPE,ZZ0->ZZ0_CODEMP,ZZ0->ZZ0_NUMCON,ZZ0->ZZ0_SUBCON,'C')
	cVerSub := chkVerConSub(ZZ0->ZZ0_CODOPE,ZZ0->ZZ0_CODEMP,ZZ0->ZZ0_NUMCON,ZZ0->ZZ0_SUBCON,'S')
	//FIM
	
	//BIANCHINI - 30/07/2014 - Implementacao de Funcional por subcontrato
	//BA3->(dbSetOrder(5))
	//If BA3->(dbSeek(xFilial("BA1")+ZZ0->ZZ0_CODEMP+ZZ1->ZZ1_FUNC)) .and. lTit
	BA3->(dbOrderNickName("BA3EMCOSUB"))
	If BA3->(dbSeek(xFilial("BA1")+ZZ0->ZZ0_CODEMP+ZZ0->ZZ0_NUMCON+cVerCon+ZZ0->ZZ0_SUBCON+cVerSub+AllTrim(ZZ1->ZZ1_FUNC))) .and. lTit
		
		//-------------------------------------------------------------------------------------------
		//INICIO - Angelo Henrique - Data: 02/06/2017
		//-------------------------------------------------------------------------------------------
		//Correï¿½ï¿½o de Bloqueio indevido, para
		//matriculas jï¿½ bloqueadas
		//-------------------------------------------------------------------------------------------
		//CHAMADO: 36741
		//-------------------------------------------------------------------------------------------
		If nTipo == 3
			
			//----------------------------------------------------------
			//Ponterar na familia correta, pois no dbseek ele traz o
			//primeiro resutado valido
			//----------------------------------------------------------
			_cQuery := " SELECT									 			" + cEnt
			_cQuery += "     BA3.BA3_CODINT,								" + cEnt
			_cQuery += "     BA3.BA3_CODEMP,								" + cEnt
			_cQuery += "     BA3.BA3_CONEMP,								" + cEnt
			_cQuery += "     BA3.BA3_VERCON,								" + cEnt
			_cQuery += "     BA3.BA3_SUBCON,								" + cEnt
			_cQuery += "     BA3.BA3_VERSUB,								" + cEnt
			_cQuery += "     BA3.BA3_MATEMP,								" + cEnt
			_cQuery += "     BA3.BA3_MATRIC 								" + cEnt
			_cQuery += " FROM 												" + cEnt
			_cQuery += "     " + RetSqlName("BA3") + " BA3 					" + cEnt
			_cQuery += " WHERE												" + cEnt
			_cQuery += "     BA3.D_E_L_E_T_ = ' '							" + cEnt
			_cQuery += "     AND BA3.BA3_FILIAL = '" + xFilial("BA3")  + "' " + cEnt
			_cQuery += "     AND BA3.BA3_CODEMP = '" + ZZ0->ZZ0_CODEMP + "'	" + cEnt
			_cQuery += "     AND BA3.BA3_CONEMP = '" + ZZ0->ZZ0_NUMCON + "'	" + cEnt
			_cQuery += "     AND BA3.BA3_VERCON = '" + cVerCon + "'			" + cEnt
			_cQuery += "     AND BA3.BA3_SUBCON = '" + ZZ0->ZZ0_SUBCON + "'	" + cEnt
			_cQuery += "     AND BA3.BA3_VERSUB = '" + cVerSub + "'			" + cEnt
			_cQuery += "     AND BA3.BA3_MATEMP = '" + AllTrim(ZZ1->ZZ1_FUNC) + "' 	" + cEnt
			_cQuery += "     AND BA3.BA3_DATBLO = ' '   					" + cEnt
			
			If Select(_cAlias1) > 0
				(_cAlias1)->(DbCloseArea())
			EndIf
			
			PLSQuery(_cQuery,_cAlias1)
			
			//---------------------------------------------------------------------------------
			//Caso seja o bloqueio, ï¿½ realizado aqui a validaï¿½ï¿½o da Data de bloqueio
			//pois em alguns casos estava trazendo matriculas jï¿½ bloqueadas
			//---------------------------------------------------------------------------------
			If !(_cAlias1)->(EOF())
				
				_aArBA3	:= BA3->(GetArea())
				
				DbSelectArea("BA3")
				DbSetOrder(1)
				If DbSeek(xFilial("BA3") + (_cAlias1)->(BA3_CODINT+BA3_CODEMP+BA3_MATRIC+BA3_CONEMP+BA3_VERCON+BA3_SUBCON+BA3_VERSUB))
					
					BA3->(RecLock("BA3",.F.))
					GerPreBA3(nTipo)
					BA3->(MsUnlock())
					
				EndIf
				
				RestArea(_aArBA3)
				
			EndIf
			
			If Select(_cAlias1) > 0
				(_cAlias1)->(DbCloseArea())
			EndIf
			
		Else
			
			BA3->(RecLock("BA3",.F.))
			GerPreBA3(nTipo)
			BA3->(MsUnlock())
			
		EndIf
		//-------------------------------------------------------------------------------------------
		//FIM - Angelo Henrique - Data: 02/06/2017
		//-------------------------------------------------------------------------------------------
		
	EndIf
	
	//BIANCHINI - 30/07/2014 - Implementacao de Funcional por subcontrato
	//BA1->(dbOrderNickName("BA1MATEMP"))
	//If BA1->(dbSeek(xFilial("BA1")+ZZ1->ZZ1_CODEMP+ZZ1->ZZ1_FUNC+ZZ1->ZZ1_DEPEND))
	BA1->(dbOrderNickName("BA1EMCOSUB"))
	If BA1->(dbSeek(xFilial("BA1")+ZZ1->ZZ1_CODEMP+ZZ0->ZZ0_NUMCON+cVerCon+ZZ0->ZZ0_SUBCON+cVerSub+AllTrim(ZZ1->ZZ1_FUNC)+ZZ1->ZZ1_DEPEND))
		
		BTS->(DBSetOrder(1))
		If BTS->(dbSeek(xFilial("BTS")+BA1->BA1_MATVID))
			BTS->(RecLock("BTS",.F.))
			GerPreBTS(nTipo,lTit)
			BTS->(MsUnlock())
		EndIf
		
		If (nTipo == 3 .and. BA1->BA1_TIPREG == "00")
			
			//-------------------------------------------------------------------------------------------
			//INICIO - Angelo Henrique - Data: 02/06/2017
			//-------------------------------------------------------------------------------------------
			//Correï¿½ï¿½o de Bloqueio indevido, para
			//matriculas jï¿½ bloqueadas
			//-------------------------------------------------------------------------------------------
			//CHAMADO: 36741
			//-------------------------------------------------------------------------------------------
			_cQuery := " SELECT									 							" + cEnt
			_cQuery += "     BA1.BA1_CODINT,												" + cEnt
			_cQuery += "     BA1.BA1_CODEMP,												" + cEnt
			_cQuery += "     BA1.BA1_MATRIC,												" + cEnt
			_cQuery += "     BA1.BA1_CONEMP,												" + cEnt
			_cQuery += "     BA1.BA1_VERCON,												" + cEnt
			_cQuery += "     BA1.BA1_SUBCON,												" + cEnt
			_cQuery += "     BA1.BA1_VERSUB,												" + cEnt
			_cQuery += "     BA1.BA1_TIPREG,												" + cEnt
			_cQuery += "     BA1.BA1_DIGITO 												" + cEnt
			_cQuery += " FROM 																" + cEnt
			_cQuery += "     " + RetSqlName("BA1") + " BA1 									" + cEnt
			_cQuery += " WHERE																" + cEnt
			_cQuery += "     BA1.D_E_L_E_T_ = ' '											" + cEnt
			_cQuery += "     AND BA1.BA1_FILIAL = '" + xFilial("BA1") + " '					" + cEnt
			_cQuery += "     AND BA1.BA1_CODEMP = '" + ZZ1->ZZ1_CODEMP + "'					" + cEnt
			_cQuery += "     AND BA1.BA1_CONEMP = '" + ZZ0->ZZ0_NUMCON+ "'					" + cEnt
			_cQuery += "     AND BA1.BA1_VERCON = '" + cVerCon + "'							" + cEnt
			_cQuery += "     AND BA1.BA1_SUBCON = '" + ZZ0->ZZ0_SUBCON + "'					" + cEnt
			_cQuery += "     AND BA1.BA1_VERSUB = '" + cVerSub 						+ "'	" + cEnt
			_cQuery += "     AND BA1.BA1_MATEMP = '" + AllTrim(ZZ1->(ZZ1_FUNC + ZZ1_DEPEND)) + "'	" + cEnt
			_cQuery += "     AND BA1.BA1_DATBLO = ' '   									" + cEnt
			
			If Select(_cAlias1) > 0
				(_cAlias1)->(DbCloseArea())
			EndIf
			
			PLSQuery(_cQuery,_cAlias1)
			
			If !(_cAlias1)->(EOF())
				
				_aArBA1	:= BA1->(GetArea())
				
				DbSelectArea("BA1")
				DbSetOrder(2)
				If DbSeek(xFilial("BA1") + (_cAlias1)->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG+BA1_DIGITO))
					
					GerPreBA1(nTipo,lTit)
					
				EndIf
				
				RestArea(_aArBA1)
				
			EndIf
			
			If Select(_cAlias1) > 0
				(_cAlias1)->(DbCloseArea())
			EndIf
			
		Else
			
			//-------------------------------------------------------------------------------------------
			//INICIO - Angelo Henrique - Data: 02/06/2017
			//-------------------------------------------------------------------------------------------
			//Correï¿½ï¿½o de Bloqueio indevido, para
			//matriculas jï¿½ bloqueadas
			//-------------------------------------------------------------------------------------------
			//CHAMADO: 36741
			//-------------------------------------------------------------------------------------------
			If nTipo == 3
				
				_cQuery := " SELECT									 							" + cEnt
				_cQuery += "     BA1.BA1_CODINT,												" + cEnt
				_cQuery += "     BA1.BA1_CODEMP,												" + cEnt
				_cQuery += "     BA1.BA1_MATRIC,												" + cEnt
				_cQuery += "     BA1.BA1_CONEMP,												" + cEnt
				_cQuery += "     BA1.BA1_VERCON,												" + cEnt
				_cQuery += "     BA1.BA1_SUBCON,												" + cEnt
				_cQuery += "     BA1.BA1_VERSUB,												" + cEnt
				_cQuery += "     BA1.BA1_TIPREG,												" + cEnt
				_cQuery += "     BA1.BA1_DIGITO 												" + cEnt
				_cQuery += " FROM 																" + cEnt
				_cQuery += "     " + RetSqlName("BA1") + " BA1 									" + cEnt
				_cQuery += " WHERE																" + cEnt
				_cQuery += "     BA1.D_E_L_E_T_ = ' '											" + cEnt
				_cQuery += "     AND BA1.BA1_FILIAL = '" + xFilial("BA1") + " '					" + cEnt
				_cQuery += "     AND BA1.BA1_CODEMP = '" + ZZ1->ZZ1_CODEMP + "'					" + cEnt
				_cQuery += "     AND BA1.BA1_CONEMP = '" + ZZ0->ZZ0_NUMCON+ "'					" + cEnt
				_cQuery += "     AND BA1.BA1_VERCON = '" + cVerCon + "'							" + cEnt
				_cQuery += "     AND BA1.BA1_SUBCON = '" + ZZ0->ZZ0_SUBCON + "'					" + cEnt
				_cQuery += "     AND BA1.BA1_VERSUB = '" + cVerSub 						+ "'	" + cEnt
				_cQuery += "     AND BA1.BA1_MATEMP = '" + AllTrim(ZZ1->(ZZ1_FUNC + ZZ1_DEPEND)) + "'	" + cEnt
				_cQuery += "     AND BA1.BA1_DATBLO = ' '   									" + cEnt
				
				If Select(_cAlias1) > 0
					(_cAlias1)->(DbCloseArea())
				EndIf
				
				PLSQuery(_cQuery,_cAlias1)
				
				If !(_cAlias1)->(EOF())
					
					_aArBA1	:= BA1->(GetArea())
					
					DbSelectArea("BA1")
					DbSetOrder(2)
					If DbSeek(xFilial("BA1") + (_cAlias1)->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG+BA1_DIGITO))
						
						BA1->(RecLock("BA1",.F.))
						GerPreBA1(nTipo,lTit)
						BA1->(MsUnlock())
						
					EndIf
					
					RestArea(_aArBA1)
					
				EndIf
				
				If Select(_cAlias1) > 0
					(_cAlias1)->(DbCloseArea())
				EndIf
				
			Else
				
				BA1->(RecLock("BA1",.F.))
				GerPreBA1(nTipo,lTit)
				BA1->(MsUnlock())
				
			EndIf
			//-------------------------------------------------------------------------------------------
			//FIM - Angelo Henrique - Data: 02/06/2017
			//-------------------------------------------------------------------------------------------
			
		EndIf
		//-------------------------------------------------------------------------------------------
		//FIM - Angelo Henrique - Data: 02/06/2017
		//-------------------------------------------------------------------------------------------
		
	EndIf
	
	If ZZ1->ZZ1_OPERSI == "04"
		AltSubUsuar()
	EndIf
	
Return

/*
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Í»ï¿½ï¿½
ï¿½ï¿½ï¿½Programa   AltSubContï¿½Autor  ï¿½Antonio de Padua    ï¿½ Data ï¿½  05/06/06   ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Í¹ï¿½ï¿½
ï¿½ï¿½ï¿½Desc.     ï¿½ Funcao que altera o subcontrato de uma familia             ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Í¼ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
*/

Static Function AltSubCont()
	
	Local lTit		:= .F.
	Local aRetorno	:= {}
	Local nRegBA1	:= 0
	Local cMatDes	:= ""
	Local _cMatAnt	:= ""
	Local aTmpFam	:= {}
	Local aTmpUsu	:= {}
	Local nCont		:= 0
	Local nCont2	:= 0
	Local aVetTit	:= {}
	Local lAgr		:= .F.
	
	cSubCon   := ""
	lTit := ZZ1->ZZ1_CDBENE == 'T'
	lAgr := ZZ1->ZZ1_CDBENE == 'A'
	
	//FABIO BIANCHINI - 30/07/2014
	//PEGAR VERSAO DO CONTRATO E DO SUBCONTRATO DA EMPRESA NO ARQUIVO DE IMPORTACAO
	cVerCon := chkVerConSub(ZZ0->ZZ0_CODOPE,ZZ0->ZZ0_CODEMP,ZZ0->ZZ0_NUMCON,ZZ0->ZZ0_SUBCON,'C')
	cVerSub := chkVerConSub(ZZ0->ZZ0_CODOPE,ZZ0->ZZ0_CODEMP,ZZ0->ZZ0_NUMCON,ZZ0->ZZ0_SUBCON,'S')
	//FIM
	
	If lTit
		aAdd(aVetTit,AllTrim(ZZ1->ZZ1_FUNC))
	EndIf
	
	//BA3->(dbSetOrder(5))
	//If BA3->(dbSeek(xFilial("BA1")+ZZ0->ZZ0_CODEMP+ZZ1->ZZ1_FUNC)) .and. (lTit .Or. lAgr)
	BA3->(dbOrderNickName("BA3EMCOSUB"))
	If BA3->(dbSeek(xFilial("BA1")+ZZ0->ZZ0_CODEMP+ZZ0->ZZ0_NUMCON+cVerCon+ZZ0->ZZ0_SUBCON+cVerSub+AllTrim(ZZ1->ZZ1_FUNC))) .and. (lTit .Or. lAgr)
		
		If lTit
			//While !BA3->(Eof()) .and. AllTrim(BA3->(BA3_CODEMP+BA3_MATEMP)) == AllTrim(ZZ0->ZZ0_CODEMP+ZZ1->ZZ1_FUNC)
			While !BA3->(Eof()) .and. AllTrim(BA3->(BA3_CODEMP+BA3_CONEMP+BA3_VERCON+BA3_SUBCON+BA3_VERSUB+BA3_MATEMP)) == AllTrim(ZZ0->ZZ0_CODEMP+ZZ0->ZZ0_NUMCON+cVerCon+ZZ0->ZZ0_SUBCON+cVerSub+AllTrim(ZZ1->ZZ1_FUNC))
				If Empty(BA3->BA3_DATBLO)
					aAdd(aTmpFam,BA3->(RECNO()))
				EndIf
				BA3->(DbSkip())
			EndDo
		Else
			If ascan(aVetTit,AllTrim(ZZ1->ZZ1_FUNC)) == 0
				
				//While !BA3->(Eof()) .and. AllTrim(BA3->(BA3_CODEMP+BA3_MATEMP)) == AllTrim(ZZ0->ZZ0_CODEMP+ZZ1->ZZ1_FUNC)
				While !BA3->(Eof()) .and. AllTrim(BA3->(BA3_CODEMP+BA3_CONEMP+BA3_VERCON+BA3_SUBCON+BA3_VERSUB+BA3_MATEMP)) == AllTrim(ZZ0->ZZ0_CODEMP+ZZ0->ZZ0_NUMCON+cVerCon+ZZ0->ZZ0_SUBCON+cVerSub+AllTrim(ZZ1->ZZ1_FUNC))
					If Empty(BA3->BA3_DATBLO)
						
						BA1->(DbSetOrder(1))
						BA1->(MsSeek(xFilial("BA1")+BA3->(BA3_CODINT+BA3_CODEMP+BA3_MATRIC)))
						
						While BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC) == BA3->(BA3_CODINT+BA3_CODEMP+BA3_MATRIC) .and. !BA1->(Eof())
							
							If AllTrim(BA1->BA1_MATEMP) == AllTrim(ZZ1->(ZZ1_FUNC+ZZ1_DEPEND)) .and. Empty(BA1->BA1_DATBLO)
								aAdd(aTmpFam,BA3->(RECNO()))
								Exit
							EndIf
							
							BA1->(DbSkip())
							
						EndDo
					EndIf
					BA3->(DbSkip())
				EndDo
				
			EndIf
			
		EndIf
		
		For nCont := 1 to Len(aTmpFam)
			
			BA3->(DbGoTo(aTmpFam[nCont]))
			
			cNumCon := ZZ0->ZZ0_NUMCON
			
			cSql := "SELECT * FROM "+RetSqlName("BQC")+" Where BQC_CODIGO = '"+ZZ0->ZZ0_CODOPE+ZZ0->ZZ0_CODEMP+"'"
			cSql += " AND BQC_NUMCON = '"+cNumCon+"'"
			//cSql += " AND BQC_VERCON = '001' "
			cSql += " AND BQC_VERCON = '"+cVercon+"' "
			cSql += " AND BQC_SUBCON = '"+ZZ0->ZZ0_SUBCON+"' "
			cSql += " AND BQC_VERSUB = '"+cVerSub+"' "
			cSql += " AND D_E_L_E_T_ = ' '"
			PLsQuery(cSql,"TMPBQC")
			
			If !TMPBQC->(EOF())
				cEquipe:=TMPBQC->BQC_EQUIPE
				cVendedor:=TMPBQC->BQC_CODVEN
				cVendedo2:=TMPBQC->BQC_CODVE2
				//GLPI:13011 - BIANCHINI - 27/08/2014
				If !Empty(TMPBQC->BQC_YSTSCO)
					cArt3031 := TMPBQC->BQC_YSTSCO
				EndIf
			EndIf
			
			TMPBQC->(DbCloseArea())
			
			cSubCon := ZZ0->ZZ0_SUBCON
			
			
			If cSubCon == ""
				cSubCon := "000000001" // 18/5/07
			EndIf
			
			BI3->(DbSetOrder(1))
			If BI3->(DbSeek(xFilial("BT6")+BT6->BT6_CODINT+dParaProd(ZZ1->ZZ1_PADRAO,dParaTipoBnf(ZZ1->ZZ1_CDBENE))+"001"))
				
				aRetorno := CopiaReg("BA3")
				
				cNovaMatric := PLPROXMAT(ZZ0->ZZ0_CODOPE,ZZ0->ZZ0_CODEMP)
				_cMatAnt := BA3->BA3_MATRIC
				
				BA3->(RecLock("BA3",.F.))
				BA3->BA3_CONEMP := cNumCon
				BA3->BA3_VERCON := cVercon //"001"
				BA3->BA3_SUBCON := cSubCon
				BA3->BA3_VERSUB := cVersub //"001"
				BA3->BA3_MATRIC	:= cNovaMatric
				BA3->BA3_CODPLA	:=	BI3->BI3_CODIGO
				BA3->BA3_VERSAO	:=	"001"
				BA3->BA3_TIPCON	:=	BI3->BI3_TIPCON
				BA3->BA3_SEGPLA	:=	BI3->BI3_CODSEG
				BA3->BA3_MODPAG	:=	BI3->BI3_MODPAG
				BA3->BA3_TXUSU	:=	'0'
				BA3->BA3_APLEI	:=	BI3->BI3_APOSRG
				BA3->BA3_CODACO	:=	BI3->BI3_CODACO
				BA3->BA3_ABRANG	:=	BI3->BI3_ABRANG
				BA3->BA3_EQUIPE := cEquipe
				BA3->BA3_CODVEN := cVendedor
				
				BA3->BA3_CODVE2 := cVendedo2
				
				BA3->(MsUnlock())
				
				//Bloquear registro anterior
				BA3->(DbGoTo(aRetorno[1]))
				BA3->(RecLock("BA3",.F.))
				BA3->BA3_DATBLO	:= (dDataBase - 1)
				BA3->BA3_MOTBLO	:= GetNewPar("MV_YMTBLTI","006")
				BA3->(MsUnlock())
				
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
				
				//Angelo Henrique - Data: 16/05/2017
				BC3->BC3_DATLAN := dDataBase
				BC3->BC3_HORLAN := TIME()
				//Angelo Henrique - Data: 16/05/2017
				
				BC3->(MsUnlock())
				
				BA3->(DbGoTo(aTmpFam[nCont]))
				
				AtuProduto()
				AtuOpcional()
				AtuAdesao()
				
				aTmpUsu := {}
				
				BA1->(dbSetOrder(1))
				If BA1->(dbSeek(xFilial("BA1")+BA3->BA3_CODINT+BA3->BA3_CODEMP+_cMatAnt))
					
					While !BA1->(EOF()) .and. BA1->BA1_FILIAL+BA1->BA1_CODINT+BA1->BA1_CODEMP+BA1->BA1_MATRIC == 	BA3->BA3_FILIAL+BA3->BA3_CODINT+BA3->BA3_CODEMP+_cMatAnt
						
						If Empty(BA1->BA1_DATBLO)
							aAdd(aTmpUsu,BA1->(RECNO()))
						EndIf
						
						BA1->(DbSkip())
						
					EndDo
					
					For nCont2 := 1 to Len(aTmpUsu)
						
						BA1->(DbGoTo(aTmpUsu[nCont2]))
						
						//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ä¿
						//ï¿½ Cond. implementada para evitar laco infinito nos novos regs.        ï¿½
						//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
						If BA1->BA1_IMPORT <> "HISTITAU"
							aRetorno := CopiaReg("BA1")
							
							BA1->(RecLock("BA1",.F.))
							BA1->BA1_CONEMP := cNumCon
							BA1->BA1_VERCON := "001"
							BA1->BA1_SUBCON := cSubCon
							BA1->BA1_VERSUB := "001"
							BA1->BA1_MATRIC := BA3->BA3_MATRIC
							//BA1->BA1_TIPREG	// NAO NECESSARIO modificar POIS EH COPIA DO BA1 ANTERIOR...
							BA1->BA1_DIGITO :=	Modulo11(BA1->BA1_CODINT+BA1->BA1_CODEMP+BA1->BA1_MATRIC+BA1->BA1_TIPREG)
							BA1->BA1_CODPLA	:=	BA3->BA3_CODPLA
							BA1->BA1_VERSAO	:=	BA3->BA3_VERSAO
							BA1->BA1_TRAORI	:= aRetorno[2]
							BA1->BA1_DATTRA := dDataBase
							BA1->BA1_DATINC := BA1->BA1_DATTRA
							BA1->BA1_EQUIPE := cEquipe
							BA1->BA1_CODVEN := cVendedor
							
							BA1->BA1_CODVE2 := cVendedo2
							
							BA1->YDTDIG     := MSDATE()
							BA1->(MsUnlock())
							
							//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ä¿
							//ï¿½ Integridade entre matricula antiga / origem e destino.              ï¿½
							//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
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
			
			AtuProduto()
			AtuOpcional()
			AtuAdesao()
		Next
		
	EndIf
	
Return

/*
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Í»ï¿½ï¿½
ï¿½ï¿½ï¿½Programa  ï¿½AltSubUsuar ï¿½Autor  ï¿½Antonio de Padua    ï¿½ Data ï¿½  05/06/06   ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Í¹ï¿½ï¿½
ï¿½ï¿½ï¿½Desc.     ï¿½ Funcao que altera o subcontrato de uma usuario             ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Í¼ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
*/

Static Function AltSubUsuar()
	
	Local aRetorno 	:= {}
	Local nRegBA1 	:= 0
	Local cMatDes 	:= ""
	
	cSubCon := ""
	
	//FABIO BIANCHINI - 30/07/2014
	//PEGAR VERSAO DO CONTRATO E DO SUBCONTRATO DA EMPRESA NO ARQUIVO DE IMPORTACAO
	cVerCon := chkVerConSub(ZZ0->ZZ0_CODOPE,ZZ0->ZZ0_CODEMP,ZZ0->ZZ0_NUMCON,ZZ0->ZZ0_SUBCON,'C')
	cVerSub := chkVerConSub(ZZ0->ZZ0_CODOPE,ZZ0->ZZ0_CODEMP,ZZ0->ZZ0_NUMCON,ZZ0->ZZ0_SUBCON,'S')
	//FIM
	
	// 	Encontro a Familia do Titular
	//BA1->(dbOrderNickName("BA1MATEMP"))
	//If BA1->(dbSeek(xFilial("BA1")+ZZ1->ZZ1_CODEMP+ZZ1->ZZ1_FUNC+"00"))
	BA1->(dbOrderNickName("BA1EMCOSUB"))
	If BA1->(dbSeek(xFilial("BA1")+ZZ1->ZZ1_CODEMP+ZZ0->ZZ0_NUMCON+cVerCon+ZZ0->ZZ0_SUBCON+cVerSub+AllTrim(ZZ1->ZZ1_FUNC)+"00"))
		
		BA3->(dbSetOrder(1))
		If BA3->(dbSeek(xFilial("BA3")+BA3->BA3_CODINT+BA3->BA3_CODEMP+BA3->BA3_MATRIC))
			
			cNumCon := ZZ0->ZZ0_SUBCON
			
			cSql := "SELECT * FROM "+RetSqlName("BQC")+" Where BQC_CODIGO = '"+ZZ0->ZZ0_CODOPE+ZZ0->ZZ0_CODEMP+"'"
			cSql += " AND BQC_NUMCON = '"+cNumCon+"'"
			//cSql += " AND BQC_VERCON = '001' "
			cSql += " AND BQC_VERCON = '"+cVercon+"' "
			cSql += " AND BQC_SUBCON = '"+ZZ0->ZZ0_SUBCON+"' "
			cSql += " AND BQC_VERSUB = '"+cVerSub+"' "
			cSql += " AND D_E_L_E_T_ = ' '"
			
			PLsQuery(cSql,"TMPBQC")
			
			If !TMPBQC->(EOF())
				cEquipe:=TMPBQC->BQC_EQUIPE
				cVendedor:=TMPBQC->BQC_CODVEN
				cVendedo2:=TMPBQC->BQC_CODVE2
				//GLPI:13011 - BIANCHINI - 27/08/2014
				If !Empty(TMPBQC->BQC_YSTSCO)
					cArt3031 := TMPBQC->BQC_YSTSCO
				EndIf
			EndIf
			TMPBQC->(DbCloseArea())
			
			cSubCon := ZZ0->ZZ0_SUBCON
			
			If cSubCon == ""
				cSubCon := "000000001" // 18/5/07
			EndIf
			
			
			BI3->(DbSetOrder(1))
			If BI3->(DbSeek(xFilial("BT6")+BT6->BT6_CODINT+dParaProd(ZZ1->ZZ1_PADRAO,dParaTipoBnf(ZZ1->ZZ1_CDBENE))+"001"))
				
				// VerIfico se o Contrato desse usuario agora ï¿½ dIferente da Familia
				If BA3->BA3_CONEMP <> cNumCon .Or. BA3->BA3_SUBCON <> cSubCon
					cNovaMatric := PLPROXMAT(ZZ0->ZZ0_CODOPE,ZZ0->ZZ0_CODEMP)
					
					BA3->(RecLock("BA3",.T.))
					GerPreBA3(1)
					BA3->(MsUnlock())
					
					//BA1->(dbOrderNickName("BA1MATEMP"))
					//If BA1->(dbSeek(xFilial("BA1")+ZZ1->ZZ1_CODEMP+ZZ1->ZZ1_FUNC+ZZ1->ZZ1_DEPEND))
					BA1->(dbOrderNickName("BA1EMCOSUB"))
					If BA1->(dbSeek(xFilial("BA1")+ZZ1->ZZ1_CODEMP+ZZ0->ZZ0_NUMCON+cVerCon+ZZ0->ZZ0_SUBCON+cVerSub+AllTrim(ZZ1->ZZ1_FUNC)+ZZ1->ZZ1_DEPEND))
						
						aRetorno := CopiaReg("BA1")
						
						BA1->(RecLock("BA1",.F.))
						BA1->BA1_CODINT	:=	BA3->BA3_CODINT
						BA1->BA1_CODEMP	:=	BA3->BA3_CODEMP
						BA1->BA1_MATRIC	:=	BA3->BA3_MATRIC
						BA1->BA1_CONEMP	:=	BA3->BA3_CONEMP
						BA1->BA1_VERCON	:=	BA3->BA3_VERCON
						BA1->BA1_SUBCON	:=	BA3->BA3_SUBCON
						BA1->BA1_VERSUB	:=	BA3->BA3_VERSUB
						BA1->BA1_TIPUSU	:=	DPTipoBnfbd(ZZ1->ZZ1_CDBENE) //Inserido na alteracao do historico
						BA1->BA1_GRAUPA	:=	DParaGrauPar(ZZ1->ZZ1_TPPARE,iIf(ZZ1->ZZ1_SEXO =="M","1","2"), ZZ1->ZZ1_DEPEND) //Inserido na alteracao do historico
						BA1->BA1_IMAGE	:=	'ENABLE'
						BA1->BA1_DATBLO := BA3->BA3_DATBLO //PM 20/7/07
						BA1->BA1_MOTBLO := BA3->BA3_MOTBLO //PM 20/7/07
						BA1->BA1_TIPREG	:= RetTpReg(BA3->(BA3->BA3_CODINT+BA3->BA3_CODEMP+BA3->BA3_MATRIC) , ZZ1->ZZ1_DEPEND ) //ZZ1->ZZ1_DEPEND -- Angelo Henrique - Data: 19/02/2020
						BA1->BA1_DIGITO := Modulo11( BA1->BA1_CODINT + BA1->BA1_CODEMP + BA1->BA1_MATRIC + BA1->BA1_TIPREG )
						BA1->BA1_TRAORI := aRetorno[2]
						BA1->BA1_DATTRA := dDataBase
						BA1->BA1_EQUIPE := cEquipe
						BA1->BA1_CODVEN := cVendedor
						
						BA1->BA1_CODVE2 := cVendedo2
						
						BA1->(MsUnlock())
						
						//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ä¿
						//ï¿½ Integridade entre matricula antiga / origem e destino.              ï¿½
						//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
						nRegBA1 := BA1->(Recno())
						cMatDes := BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG+BA1_DIGITO)
						
						BA1->(DbGoTo(aRetorno[1])) //Posiciona no novo registro da matricula de historico.
						BA1->(RecLock("BA1",.F.))
						BA1->BA1_TRADES := cMatDes
						BA1->(MsUnlock())
						BA1->(DbGoTo(nRegBA1)) //Retorna o BA1 a posicao original, e prossegue a execucao da rotina.
						
					EndIf
				Else
					//BA1->(dbOrderNickName("BA1MATEMP"))
					//If BA1->(dbSeek(xFilial("BA1")+ZZ1->ZZ1_CODEMP+ZZ1->ZZ1_FUNC+ZZ1->ZZ1_DEPEND))
					BA1->(dbOrderNickName("BA1EMCOSUB"))
					If BA1->(dbSeek(xFilial("BA1")+ZZ1->ZZ1_CODEMP+ZZ0->ZZ0_NUMCON+cVerCon+ZZ0->ZZ0_SUBCON+cVerSub+AllTrim(ZZ1->ZZ1_FUNC)+ZZ1->ZZ1_DEPEND))
						
						If BA3->BA3_CONEMP <> BA1->BA1_CONEMP .Or. BA3->BA3_SUBCON <> BA1->BA1_SUBCON
							
							aRetorno := CopiaReg("BA1")
							
							BA1->(RecLock("BA1",.F.))
							BA1->BA1_CODINT	:=	BA3->BA3_CODINT
							BA1->BA1_CODEMP	:=	BA3->BA3_CODEMP
							BA1->BA1_MATRIC	:=	BA3->BA3_MATRIC
							BA1->BA1_CONEMP	:=	BA3->BA3_CONEMP
							BA1->BA1_VERCON	:=	BA3->BA3_VERCON
							BA1->BA1_SUBCON	:=	BA3->BA3_SUBCON
							BA1->BA1_VERSUB	:=	BA3->BA3_VERSUB
							BA1->BA1_IMAGE	:=	'ENABLE'
							BA1->BA1_TIPREG	:=	ZZ1->ZZ1_DEPEND
							BA1->BA1_DIGITO :=	Modulo11( BA1->BA1_CODINT + BA1->BA1_CODEMP + BA1->BA1_MATRIC + BA1->BA1_TIPREG )
							BA1->BA1_TRAORI := aRetorno[2]
							BA1->BA1_DATTRA := dDataBase
							BA1->BA1_EQUIPE := cEquipe
							BA1->BA1_CODVEN := cVendedor
							
							BA1->BA1_CODVE2 := cVendedo2
							
							BA1->(MsUnlock())
							
							//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ä¿
							//ï¿½ Integridade entre matricula antiga / origem e destino.              ï¿½
							//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
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
			AtuProduto()
			AtuOpcional()
			AtuAdesao()
		EndIf
	EndIf
	
Return

/*
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Í»ï¿½ï¿½
ï¿½ï¿½ï¿½Programa  |AtuProdutoï¿½Autor  ï¿½Antonio de Padua    ï¿½ Data ï¿½  12/05/06   ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Í¹ï¿½ï¿½
ï¿½ï¿½ï¿½Desc.     ï¿½ Atualiza Produtos na familia pegando da empresa            ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½          ï¿½                                                            ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Í¹ï¿½ï¿½
ï¿½ï¿½ï¿½Uso       ï¿½ AP                                                        ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Í¼ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
*/

Static Function AtuProduto()

Local cQuery	:= ""
Local nBA1Rec	:= BA1->(RECNO())

// Limpo as tabelas para nao ter problema na alteracao
cQuery := " DELETE FROM " + RetSqlName("BJK")					// forma de cobrança da família
cQuery += " WHERE BJK_FILIAL = '" + xFilial("BJK") + "'"
cQuery +=	" AND BJK_CODOPE = '" + BA3->BA3_CODINT + "'"
cQuery +=	" AND BJK_CODEMP = '" + BA3->BA3_CODEMP + "'"
cQuery +=	" AND BJK_MATRIC = '" + BA3->BA3_MATRIC + "'"
TCSQLEXEC(cQuery)

cQuery := " DELETE FROM " + RetSqlName("BBU")					// faixas na família
cQuery += " WHERE BBU_FILIAL = '" + xFilial("BBU") + "'"
cQuery +=	" AND BBU_CODOPE = '" + BA3->BA3_CODINT + "'"
cQuery +=	" AND BBU_CODEMP = '" + BA3->BA3_CODEMP + "'"
cQuery +=	" AND BBU_MATRIC = '" + BA3->BA3_MATRIC + "'"
TCSQLEXEC(cQuery)

cQuery := " DELETE FROM " + RetSqlName("BFY")					// desconto da faixa na família
cQuery += " WHERE BFY_FILIAL = '" + xFilial("BFY") + "'"
cQuery +=	" AND BFY_CODOPE = '" + BA3->BA3_CODINT + "'"
cQuery +=	" AND BFY_CODEMP = '" + BA3->BA3_CODEMP + "'"
cQuery +=	" AND BFY_MATRIC = '" + BA3->BA3_MATRIC + "'"
TCSQLEXEC(cQuery)

cQuery := " DELETE FROM " + RetSqlName("BDK")					// faixa no usuário
cQuery += " WHERE BDK_FILIAL = '" + xFilial("BDK") + "'"
cQuery +=	" AND BDK_CODINT = '" + BA3->BA3_CODINT + "'"
cQuery +=	" AND BDK_CODEMP = '" + BA3->BA3_CODEMP + "'"
cQuery +=	" AND BDK_MATRIC = '" + BA3->BA3_MATRIC + "'"
TCSQLEXEC(cQuery)

cQuery := " DELETE FROM " + RetSqlName("BDQ")					// desconto da faixa no usuário
cQuery += " WHERE BDQ_FILIAL = '" + xFilial("BDQ") + "'"
cQuery +=	" AND BDQ_CODINT = '" + BA3->BA3_CODINT + "'"
cQuery +=	" AND BDQ_CODEMP = '" + BA3->BA3_CODEMP + "'"
cQuery +=	" AND BDQ_MATRIC = '" + BA3->BA3_MATRIC + "'"
TCSQLEXEC(cQuery)

BT9->(DbSetOrder(1))	// BT9_FILIAL+BT9_CODIGO+BT9_NUMCON+BT9_VERCON+BT9_SUBCON+BT9_VERSUB+BT9_CODPRO+BT9_VERSAO+BT9_CODFOR
if BT9->(DbSeek(xFilial("BT9") + BA3->(BA3_CODINT+BA3_CODEMP+BA3_CONEMP+BA3_VERCON+BA3_SUBCON+BA3_VERSUB+BA3_CODPLA+BA3_VERSAO+BA3_FORPAG)))

	BJK->(DbSetOrder(1))
	BJK->(RecLock("BJK", .T.))

		BJK->BJK_FILIAL := xFilial("BJK")
		BJK->BJK_CODOPE := BA3->BA3_CODINT
		BJK->BJK_CODEMP := BA3->BA3_CODEMP
		BJK->BJK_MATRIC := BA3->BA3_MATRIC
		BJK->BJK_CODFOR := BA3->BA3_FORPAG
		BJK->BJK_AUTOMA := "1"
	
	BJK->(MsUnlock())

	BTN->(DbSetOrder(1))	// BTN_FILIAL+BTN_CODIGO+BTN_NUMCON+BTN_VERCON+BTN_SUBCON+BTN_VERSUB+BTN_CODPRO+BTN_VERPRO+BTN_CODFOR+BTN_CODQTD+DTOS(BTN_TABVLD)+BTN_CODFAI
	if BTN->(DbSeek(xFilial("BTN") + BA3->(BA3_CODINT+BA3_CODEMP+BA3_CONEMP+BA3_VERCON+BA3_SUBCON+BA3_VERSUB+BA3_CODPLA+BA3_VERSAO+BA3_FORPAG)))

		while BTN->(!EOF()) .and. BTN->(BTN_FILIAL+BTN_CODIGO+BTN_NUMCON+BTN_VERCON+BTN_SUBCON+BTN_VERSUB+BTN_CODPRO+BTN_VERPRO+BTN_CODFOR) == BA3->(BA3_FILIAL+BA3_CODINT+BA3_CODEMP+BA3_CONEMP+BA3_VERCON+BA3_SUBCON+BA3_VERSUB+BA3_CODPLA+BA3_VERSAO+BA3_FORPAG)

			if empty(BTN->BTN_TABVLD)	// Não pegar com validade encerrada

				BBU->(DbSetOrder(1))	// BBU_FILIAL+BBU_CODOPE+BBU_CODEMP+BBU_MATRIC+BBU_CODFOR+BBU_CODFAI
				BBU->(RecLock("BBU", .T.))
					BBU->BBU_FILIAL := xFilial("BBU")
					BBU->BBU_CODOPE := BA3->BA3_CODINT
					BBU->BBU_CODEMP := BA3->BA3_CODEMP
					BBU->BBU_MATRIC := BA3->BA3_MATRIC
					BBU->BBU_CODFOR := BA3->BA3_FORPAG
					BBU->BBU_CODFAI := BTN->BTN_CODFAI
					BBU->BBU_TABVLD := BTN->BTN_TABVLD
					BBU->BBU_TIPUSR := BTN->BTN_TIPUSR
					BBU->BBU_GRAUPA := BTN->BTN_GRAUPA
					BBU->BBU_SEXO	:= BTN->BTN_SEXO
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
			
			endif

			BTN->(DbSkip())
		end

		BFT->(DbSetOrder(1))	// BFT_FILIAL+BFT_CODIGO+BFT_NUMCON+BFT_VERCON+BFT_SUBCON+BFT_VERSUB+BFT_CODPRO+BFT_VERPRO+BFT_CODFOR+BFT_CODQTD+BFT_CODFAI
		if BFT->(DbSeek( xFilial("BFT") + BA3->(BA3_CODINT+BA3_CODEMP+BA3_CONEMP+BA3_VERCON+BA3_SUBCON+BA3_VERSUB+BA3_CODPLA+BA3_VERSAO+BA3_FORPAG) ))

			while BFT->(!EOF()) .and. BFT->(BFT_FILIAL+BFT_CODIGO+BFT_NUMCON+BFT_VERCON+BFT_SUBCON+BFT_VERSUB+BFT_CODPRO+BFT_VERPRO+BFT_CODFOR) == BA3->(BA3_FILIAL+BA3_CODINT+BA3_CODEMP+BA3_CONEMP+BA3_VERCON+BA3_SUBCON+BA3_VERSUB+BA3_CODPLA+BA3_VERSAO+BA3_FORPAG)

// -------------[ chamado 86996 - inicio - gus ]---------------------------------------------------
//				if empty(BFT->BFT_DATATE)	// Não pegar com validade encerrada
// ------------------------------------------------------------------------------------------------
				if empty( BFT->BFT_DATATE )            .OR.  ;
                        ( BFT->BFT_DATDE  <= dDatabase .AND. ;
                          BFT->BFT_DATATE >= dDatabase )
// -------------[ chamado 86996 - fim - gus ]------------------------------------------------------

					BFY->(DbSetOrder(1))	// BFY_FILIAL+BFY_CODOPE+BFY_CODEMP+BFY_MATRIC+BFY_CODFOR+BFY_CODFAI
					BFY->(RecLock("BFY", .T.))
						BFY->BFY_FILIAL	:= xFilial("BFY")
						BFY->BFY_CODOPE	:= BA3->BA3_CODINT
						BFY->BFY_CODEMP	:= BA3->BA3_CODEMP
						BFY->BFY_MATRIC	:= BA3->BA3_MATRIC
						BFY->BFY_CODFOR	:= BA3->BA3_FORPAG
						BFY->BFY_CODFAI	:= BFT->BFT_CODFAI
						BFY->BFY_TIPUSR	:= BFT->BFT_TIPUSR
						BFY->BFY_GRAUPA	:= BFT->BFT_GRAUPA
						BFY->BFY_PERCEN	:= BFT->BFT_PERCEN
						BFY->BFY_VALOR	:= BFT->BFT_VALOR
						BFY->BFY_QTDDE	:= BFT->BFT_QTDDE
						BFY->BFY_QTDATE	:= BFT->BFT_QTDATE
						BFY->BFY_TIPO	:= BFT->BFT_TIPO
						BFY->BFY_DATDE	:= BFT->BFT_DATDE
						BFY->BFY_DATATE	:= BFT->BFT_DATATE
						BFY->BFY_AUTOMA	:= "1"
					BFY->(MsUnlock())

				endif

				BFT->(DbSkip())
			end

		endif

		// Angelo Henrique - Data: 6/04/2020
		// Atendendo ao chamado: 66317 - Algumas empresas na INTEGRAL não tem nivel de usuario cadastrado
		if cEmpAnt == '01' .or. (cEmpAnt == "02" .and. !(BA3->BA3_CODEMP $ GETNEWPAR("MV_XEMPUSU","0313,0314,0315,0316,0319,0320,0321,0322,0323")) )

			BA1->(DbSetOrder(2))	// BA1_FILIAL+BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG+BA1_DIGITO
			if BA1->(DbSeek( xFilial("BA1") + BA3->(BA3_CODINT+BA3_CODEMP+BA3_MATRIC) ))

				while BA1->(!EOF()) .and. BA3->(BA3_CODINT+BA3_CODEMP+BA3_MATRIC) == BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC)

					BTN->(DbSetOrder(1))	// BTN_FILIAL+BTN_CODIGO+BTN_NUMCON+BTN_VERCON+BTN_SUBCON+BTN_VERSUB+BTN_CODPRO+BTN_VERPRO+BTN_CODFOR+BTN_CODQTD+DTOS(BTN_TABVLD)+BTN_CODFAI
					if BTN->(DbSeek( xFilial("BTN") + BA1->(BA1_CODINT+BA1_CODEMP+BA1_CONEMP+BA1_VERCON+BA1_SUBCON+BA1_VERSUB+BA1_CODPLA+BA1_VERSAO)+BA3->BA3_FORPAG))

						while BTN->(!EOF()) .and. BTN->(BTN_FILIAL+BTN_CODIGO+BTN_NUMCON+BTN_VERCON+BTN_SUBCON+BTN_VERSUB+BTN_CODPRO+BTN_VERPRO+BTN_CODFOR) == BA1->(BA1_FILIAL+BA1_CODINT+BA1_CODEMP+BA1_CONEMP+BA1_VERCON+BA1_SUBCON+BA1_VERSUB+BA1_CODPLA+BA1_VERSAO)+BA3->BA3_FORPAG

							if empty(BTN->BTN_TABVLD)	// Não pegar com validade encerrada

								BDK->(DbSetOrder(2))	// BDK_FILIAL+BDK_CODINT+BDK_CODEMP+BDK_MATRIC+BDK_TIPREG
								BDK->(RecLock("BDK", .T.))
								
									BDK->BDK_FILIAL	:= xFilial("BDK")
									BDK->BDK_CODINT	:= BA3->BA3_CODINT
									BDK->BDK_CODEMP	:= BA3->BA3_CODEMP
									BDK->BDK_MATRIC	:= BA3->BA3_MATRIC
									BDK->BDK_TIPREG	:= BA1->BA1_TIPREG
									BDK->BDK_CODFAI	:= BTN->BTN_CODFAI
									BDK->BDK_IDAINI	:= BTN->BTN_IDAINI
									BDK->BDK_IDAFIN	:= BTN->BTN_IDAFIN
									BDK->BDK_VALOR	:= BTN->BTN_VALFAI
									BDK->BDK_ANOMES	:= BTN->BTN_ANOMES
									BDK->BDK_VLRANT	:= BTN->BTN_VLRANT
									BDK->BDK_RGIMP	:= "1"
									BDK->BDK_TABVLD	:= BTN->BTN_TABVLD
								
								BDK->(MsUnlock())

							endif
							
							BTN->(DbSkip())
						end

						BFT->(DbSetOrder(1))	// BFT_FILIAL+BFT_CODIGO+BFT_NUMCON+BFT_VERCON+BFT_SUBCON+BFT_VERSUB+BFT_CODPRO+BFT_VERPRO+BFT_CODFOR+BFT_CODQTD+BFT_CODFAI
						if BFT->(DbSeek( xFilial("BFT") + BA1->(BA1_CODINT+BA1_CODEMP+BA1_CONEMP+BA1_VERCON+BA1_SUBCON+BA1_VERSUB+BA1_CODPLA+BA1_VERSAO)+BA3->BA3_FORPAG ))

							while BFT->(!EOF()) .and. BFT->(BFT_CODIGO+BFT_NUMCON+BFT_VERCON+BFT_SUBCON+BFT_VERSUB+BFT_CODPRO+BFT_VERPRO+BFT_CODFOR) == BA1->(BA1_CODINT+BA1_CODEMP+BA1_CONEMP+BA1_VERCON+BA1_SUBCON+BA1_VERSUB+BA1_CODPLA+BA1_VERSAO)+BA3->BA3_FORPAG

// -----------------------------[ chamado 86996 - inicio - gus ]-----------------------------------
//								if empty(BFT->BFT_DATATE)	// Não pegar com validade encerrada
// ------------------------------------------------------------------------------------------------
                                if empty( BFT->BFT_DATATE )            .OR.  ;
                                        ( BFT->BFT_DATDE  <= dDatabase .AND. ;
                                          BFT->BFT_DATATE >= dDatabase )
// -----------------------------[ chamado 86996 - fim - gus ]--------------------------------------

									BDQ->(DbSetOrder(1))	// BDQ_FILIAL+BDQ_CODINT+BDQ_CODEMP+BDQ_MATRIC+BDQ_TIPREG+BDQ_CODFAI
									BDQ->(RecLock("BDQ", .T.))

										BDQ->BDQ_FILIAL	:= xFilial("BDQ")
										BDQ->BDQ_CODINT	:= BA1->BA1_CODINT
										BDQ->BDQ_CODEMP	:= BA1->BA1_CODEMP
										BDQ->BDQ_MATRIC	:= BA1->BA1_MATRIC
										BDQ->BDQ_TIPREG	:= BA1->BA1_TIPREG
										BDQ->BDQ_CODFAI	:= BFT->BFT_CODFAI
										BDQ->BDQ_TIPUSR	:= BFT->BFT_TIPUSR
										BDQ->BDQ_GRAUPA	:= BFT->BFT_GRAUPA
										BDQ->BDQ_PERCEN	:= BFT->BFT_PERCEN
										BDQ->BDQ_VALOR	:= BFT->BFT_VALOR
										BDQ->BDQ_QTDDE	:= BFT->BFT_QTDDE
										BDQ->BDQ_QTDATE	:= BFT->BFT_QTDATE
										BDQ->BDQ_TIPO	:= BFT->BFT_TIPO
										BDQ->BDQ_DATDE	:= BFT->BFT_DATDE
										BDQ->BDQ_DATATE	:= BFT->BFT_DATATE
// -------------------------------------[ chamado 86996 - inicio - gus ]---------------------------
                                        BDQ->BDQ_QTDMAX := 999
// -------------------------------------[ chamado 86996 - fim - gus ]------------------------------

										
									BDQ->(MsUnlock())

								endif
							
								BFT->(DbSkip())
							end

						endif
					
					endif

					BA1->(DbSkip())
				end

			endif

			BA1->(DbGoTo(nBA1Rec))

		endif

	endif

endif

return


/*
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Í»ï¿½ï¿½
ï¿½ï¿½ï¿½Programa  |AtuAdesao ï¿½Autor  ï¿½Raquel              ï¿½ Data ï¿½  25/10/07   ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Í¹ï¿½ï¿½
ï¿½ï¿½ï¿½Desc.     ï¿½ Atualiza Taxa de adesao na familia pegando da empresa      ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½          ï¿½                                                            ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Í¹ï¿½ï¿½
ï¿½ï¿½ï¿½Uso       ï¿½ AP                                                         ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Í¼ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
*/

Static Function AtuAdesao()
	
	// Limpo as tabelas para nao ter problema na alteracao
	TCSQLEXEC("DELETE FROM "+RetSqlName("BJL")+" WHERE BJL_CODOPE = '"+BA3->BA3_CODINT+"' AND BJL_CODEMP = '"+BA3->BA3_CODEMP+"' AND BJL_MATRIC = '"+BA3->BA3_MATRIC+"' AND BJL_CODFOR = '"+BA3->BA3_FORCTX+"'")
	TCSQLEXEC("DELETE FROM "+RetSqlName("BRX")+" WHERE BRX_CODOPE = '"+BA3->BA3_CODINT+"' AND BRX_CODEMP = '"+BA3->BA3_CODEMP+"' AND BRX_MATRIC = '"+BA3->BA3_MATRIC+"' AND BRX_CODFOR = '"+BA3->BA3_FORCTX+"'")
	
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
		EndDo
	EndIf
	
Return


/*
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Í»ï¿½ï¿½
ï¿½ï¿½ï¿½Programa  AtuOpcionalï¿½Autor  ï¿½Antonio de Padua    ï¿½ Data ï¿½  12/05/06   ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Í¹ï¿½ï¿½
ï¿½ï¿½ï¿½Desc.     ï¿½ Atualiza Opcionais na familia pegando da empresa           ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½          ï¿½                                                            ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Í¹ï¿½ï¿½
ï¿½ï¿½ï¿½Uso       ï¿½ AP                                                         ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Í¼ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
*/

Static Function AtuOpcional()
	
	TCSQLEXEC("DELETE FROM "+RetSqlName("BF1")+" WHERE BF1_CODINT = '"+BA3->BA3_CODINT+"' AND BF1_CODEMP = '"+BA3->BA3_CODEMP+"' AND BF1_MATRIC = '"+BA3->BA3_MATRIC+"'")
	TCSQLEXEC("DELETE FROM "+RetSqlName("BK0")+" WHERE BK0_CODOPE = '"+BA3->BA3_CODINT+"' AND BK0_CODEMP = '"+BA3->BA3_CODEMP+"' AND BK0_MATRIC = '"+BA3->BA3_MATRIC+"'")
	TCSQLEXEC("DELETE FROM "+RetSqlName("BBY")+" WHERE BBY_CODOPE = '"+BA3->BA3_CODINT+"' AND BBY_CODEMP = '"+BA3->BA3_CODEMP+"' AND BBY_MATRIC = '"+BA3->BA3_MATRIC+"'")
	TCSQLEXEC("DELETE FROM "+RetSqlName("BG0")+" WHERE BG0_CODOPE = '"+BA3->BA3_CODINT+"' AND BG0_CODEMP = '"+BA3->BA3_CODEMP+"' AND BG0_MATRIC = '"+BA3->BA3_MATRIC+"'")
	TCSQLEXEC("DELETE FROM "+RetSqlName("BF4")+" WHERE BF4_CODINT = '"+BA3->BA3_CODINT+"' AND BF4_CODEMP = '"+BA3->BA3_CODEMP+"' AND BF4_MATRIC = '"+BA3->BA3_MATRIC+"'")
	TCSQLEXEC("DELETE FROM "+RetSqlName("BYX")+" WHERE BYX_CODOPE = '"+BA3->BA3_CODINT+"' AND BYX_CODEMP = '"+BA3->BA3_CODEMP+"' AND BYX_MATRIC = '"+BA3->BA3_MATRIC+"'")
	TCSQLEXEC("DELETE FROM "+RetSqlName("BZX")+" WHERE BZX_CODOPE = '"+BA3->BA3_CODINT+"' AND BZX_CODEMP = '"+BA3->BA3_CODEMP+"' AND BZX_MATRIC = '"+BA3->BA3_MATRIC+"'")
	
	BI3->(dbGoTop())
	Do While !BI3->(Eof())
		
		If	(BI3->BI3_GRUPO != '002') .or. (BI3->BI3_GRUPO == '002' .and. !EMPTY(BI3->BI3_DATBLO))
			BI3->(dbSkip())
			Loop
		EndIf
		
		BHS->( dbSetorder(1) )
		If  !BHS->( dbSeek(xFilial("BHS")+BA3->(BA3_CODINT+BA3_CODEMP+BA3_CONEMP+BA3_VERCON+BA3_SUBCON+BA3_VERSUB+BA3_CODPLA+BA3_VERSAO)) )
			Return
		EndIf
		
		While !BHS->( Eof() ) .and. BHS->(BHS_CODINT+BHS_CODIGO+BHS_NUMCON+BHS_VERCON+BHS_SUBCON+BHS_VERSUB+BHS_CODPRO+BHS_VERPRO)==;
				BA3->(BA3_CODINT+BA3_CODEMP+BA3_CONEMP+BA3_VERCON+BA3_SUBCON+BA3_VERSUB+BA3_CODPLA+BA3_VERSAO)
			
			//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ä¿
			//ï¿½ Compara o codigo do opcional                                        ï¿½
			//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
			If BHS->BHS_CODPLA <> BI3->BI3_CODIGO
				BHS->( dbSkip() )
				Loop
			EndIf
			
			//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ä¿
			//ï¿½ Grava o opcional...                                                 ï¿½
			//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
			If (BHS->BHS_TIPVIN == '1') .or. (BHS->BHS_TIPVIN <> '1' .and. ZZ1->ZZ1_ASSMED == 'S')
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
					BF1->BF1_TIPVIN := '0'
					BF1->( msUnlock() )
					
					//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ä¿
					//ï¿½ Grava suas formas de cobranca...                                    ï¿½
					//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
					If BHS->BHS_TIPVIN <> '1' .and. ZZ1->ZZ1_ASSMED == 'S'
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
							
							//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ä¿
							//ï¿½ Le faixas de Opcionais do subcontrato e grava suas faixas de valores de cobranca na familia...    ï¿½
							//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
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
									BBY->BBY_FAIfAM := TRB1->BBX_FAIfAM
									BBY->BBY_QTDMIN := TRB1->BBX_QTDMAX
									BBY->BBY_QTDMAX := TRB1->BBX_QTDMAX
									BBY->BBY_AUTOMA := '1'
									BBY->BBY_ANOMES	:= TRB1->BBX_ANOMES
									BBY->BBY_VLRANT := TRB1->BBX_VLRANT
									BBY->( msUnlock() )
								EndIf
								TRB1->( dbSkip() )
							EndDo
							TRB1->( dbClosearea() )
							
							//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ä¿
							//ï¿½ Le faixas de Opcionais(descontos) do subcontrato e Grava suas faixas de descontos de cobranca...        ï¿½
							//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
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
								EndDo
							EndIf
							TRB1->( dbClosearea() )
						EndIf
					EndIf
				EndIf
			EndIf
			//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ä¿
			//ï¿½ Inicia atualizacoes do usuario...                                   ï¿½
			//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
			BA1->( dbSetorder(2) )
			If BA1->(dbSeek(xFilial("BA1")+BA3->(BA3_CODINT+BA3_CODEMP+BA3_MATRIC+"00")) )
				
				While !BA1->( Eof() ) .and. BA1->BA1_FILIAL == xFilial("BA1")  .and.;
						BA1->BA1_CODINT == BA3->BA3_CODINT .and.;
						BA1->BA1_CODEMP == BA3->BA3_CODEMP .and.;
						BA1->BA1_MATRIC == BA3->BA3_MATRIC
					
					//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ä¿
					//ï¿½ Opcionais...                                                        ï¿½
					//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
					If (BHS->BHS_TIPVIN == '1') .or. (BHS->BHS_TIPVIN <> '1' .and. ZZ1->ZZ1_ASSMED == 'S')
						If !BF4->( dbSeek(xFilial("BF4")+BA1->BA1_CODINT+BA1->BA1_CODEMP+BA1->BA1_MATRIC+BA1->BA1_TIPREG+BHS->BHS_CODPLA) )
							
							BF4->( RecLock("BF4", .T.) )
							BF4->BF4_FILIAL := xFilial("BF1")
							BF4->BF4_CODEMP := BA3->BA3_CODEMP
							BF4->BF4_CODINT := BA3->BA3_CODINT
							BF4->BF4_MATRIC := BA3->BA3_MATRIC
							BF4->BF4_TIPREG := BA1->BA1_TIPREG
							
							BF4->BF4_DATBAS	:= BA3->BA3_DATBAS
							BF4->BF4_MOTBLO := BA3->BA3_MOTBLO
							BF4->BF4_DATBLO := BA3->BA3_DATBLO
							
							BF4->BF4_CODPRO := BHS->BHS_CODPLA
							BF4->BF4_VERSAO := BHS->BHS_VERPLA
							BF4->BF4_TIPVIN := '0'
							
							BF4->( MsUnlock() )
							
							//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ä¿
							//ï¿½ Suas formas de cobranca...                                          ï¿½
							//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
							//BIANCHINI - 13/09/2019 - COMENTADO PORQUE NÃO FAZ SENTIDO ESTA CONDIÇÃO JA QUE ESTA TABELA VINCULA BA1 COM BF4
							//                         E A CONDIÇÃO QUE FEZ CHEGAR ATE AQUI JA INCLUI A BF4
							/////If BHS->BHS_TIPVIN <> '1' .and. ZZ1->ZZ1_ASSMED == 'S'
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
								
								//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ä¿
								//ï¿½ A tabela de precos...                                               ï¿½
								//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
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
								EndDo
								TRB1->( dbCloseArea() )
							EndIf
							/////EndIf
						EndIf
					EndIf
					BA1->( dbSkip() )
				EndDo
			EndIf
			BHS->( dbSkip() )
		EndDo
		BI3->(dbSkip())
	EndDo
	
Return


/* COPIA DA Function

Static Function AtuOpcional()
	
	TCSQLEXEC("DELETE FROM "+RetSqlName("BF1")+" WHERE BF1_CODINT = '"+BA3->BA3_CODINT+"' AND BF1_CODEMP = '"+BA3->BA3_CODEMP+"' AND BF1_MATRIC = '"+BA3->BA3_MATRIC+"'")
	TCSQLEXEC("DELETE FROM "+RetSqlName("BK0")+" WHERE BK0_CODINT = '"+BA3->BA3_CODINT+"' AND BK0_CODEMP = '"+BA3->BA3_CODEMP+"' AND BK0_MATRIC = '"+BA3->BA3_MATRIC+"'")
	TCSQLEXEC("DELETE FROM "+RetSqlName("BBY")+" WHERE BBY_CODINT = '"+BA3->BA3_CODINT+"' AND BBY_CODEMP = '"+BA3->BA3_CODEMP+"' AND BBY_MATRIC = '"+BA3->BA3_MATRIC+"'")
	TCSQLEXEC("DELETE FROM "+RetSqlName("BG0")+" WHERE BG0_CODINT = '"+BA3->BA3_CODINT+"' AND BG0_CODEMP = '"+BA3->BA3_CODEMP+"' AND BG0_MATRIC = '"+BA3->BA3_MATRIC+"'")
	TCSQLEXEC("DELETE FROM "+RetSqlName("BF4")+" WHERE BF4_CODINT = '"+BA3->BA3_CODINT+"' AND BF4_CODEMP = '"+BA3->BA3_CODEMP+"' AND BF4_MATRIC = '"+BA3->BA3_MATRIC+"'")
	TCSQLEXEC("DELETE FROM "+RetSqlName("BYX")+" WHERE BYX_CODINT = '"+BA3->BA3_CODINT+"' AND BYX_CODEMP = '"+BA3->BA3_CODEMP+"' AND BYX_MATRIC = '"+BA3->BA3_MATRIC+"'")
	TCSQLEXEC("DELETE FROM "+RetSqlName("BZX")+" WHERE BZX_CODINT = '"+BA3->BA3_CODINT+"' AND BZX_CODEMP = '"+BA3->BA3_CODEMP+"' AND BZX_MATRIC = '"+BA3->BA3_MATRIC+"'")
	
	BI3->(dbGoTop())
	Do While !BI3->(Eof())
		
		If	BI3->BI3_GRUPO != '002'
			BI3->(dbSkip())
			Loop
		EndIf
		
		BHS->( dbSetorder(01) )
		If !BHS->( dbSeek(xFilial("BHS")+BA3->(BA3_CODINT+BA3_CODEMP+BA3_CONEMP+;
				BA3_VERCON+BA3_SUBCON+BA3_VERSUB+;
				BA3_CODPLA+BA3_VERSAO)) )
			Return
		EndIf
		
		While !BHS->( Eof() ) .and. BHS->(BHS_CODINT+BHS_CODIGO+BHS_NUMCON+BHS_VERCON+BHS_SUBCON+BHS_VERSUB+BHS_CODPRO+BHS_VERPRO)==;
				BA3->(BA3_CODINT+BA3_CODEMP+BA3_CONEMP+BA3_VERCON+BA3_SUBCON+BA3_VERSUB+BA3_CODPLA+BA3_VERSAO)
			
			//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ä¿
			//ï¿½ Compara o codigo do opcional                                        ï¿½
			//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
			If BHS->BHS_CODPLA <> BI3->BI3_CODIGO
				BHS->( dbSkip() )
				Loop
			EndIf
			
			//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ä¿
			//ï¿½ Grava o opcional...                                                 ï¿½
			//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
			BF1->( dbSetorder(01) )
			If !BF1->( dbSeek(xFilial("BF1")+BA3->(BA3_CODINT+BA3_CODEMP+BA3_MATRIC)+BHS->BHS_CODPLA) )
				BF1->( RecLock("BF1",.T.) )
				BF1->BF1_FILIAL := xFilial("BF1")
				BF1->BF1_CODEMP := BA3->BA3_CODEMP
				BF1->BF1_CODINT := BA3->BA3_CODINT
				BF1->BF1_MATRIC := BA3->BA3_MATRIC
				BF1->BF1_CODPRO := BHS->BHS_CODPLA
				BF1->BF1_VERSAO := BHS->BHS_VERPLA
				BF1->BF1_DATBAS	:= BA3->BA3_DATBAS
				BF1->BF1_TIPVIN := '0'
				BF1->( msUnlock() )
				
				//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ä¿
				//ï¿½ Grava suas formas de cobranca...                                    ï¿½
				//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
				If BHS->BHS_TIPVIN <> 'S'
					BJW->( dbSetorder(01) )
					If BJW->( dbSeek(xFilial("BK0")+BA3->(BA3_CODINT+BA3_CODEMP+BA3_CONEMP+;
							BA3_VERCON+BA3_SUBCON+BA3_VERSUB+;
							BA3_CODPLA+BA3_VERSAO)          +;
							BHS->BHS_CODPLA+BHS->BHS_VERPLA ) )
						
						BK0->( dbSetorder(01) )
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
						
						//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ä¿
						//ï¿½ Grava suas faixas de valores de cobranca...                         ï¿½
						//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
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
								BBY->BBY_FAIfAM := TRB1->BBX_FAIfAM
								BBY->BBY_QTDMIN := TRB1->BBX_QTDMAX
								BBY->BBY_QTDMAX := TRB1->BBX_QTDMAX
								BBY->BBY_AUTOMA := '1'
								BBY->BBY_ANOMES	:= TRB1->BBX_ANOMES
								BBY->BBY_VLRANT := TRB1->BBX_VLRANT
								BBY->( msUnlock() )
							EndIf
							TRB1->( dbSkip() )
						EndDo
						TRB1->( dbClosearea() )
						
						//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ä¿
						//ï¿½ Grava suas faixas de descontos de cobranca...                       ï¿½
						//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
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
							EndDo
						EndIf
						TRB1->( dbClosearea() )
					EndIf
				EndIf
			EndIf
			
			//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ä¿
			//ï¿½ Inicia atualizacoes do usuario...                                   ï¿½
			//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
			BA1->( dbSetorder(02) )
			If BA1->(dbSeek(xFilial("BA1")+BA3->(BA3_CODINT+BA3_CODEMP+BA3_MATRIC+"00")) )
				
				While !BA1->( Eof() ) .and. BA1->BA1_FILIAL == xFilial("BA1")  .and.;
						BA1->BA1_CODINT == BA3->BA3_CODINT .and.;
						BA1->BA1_CODEMP == BA3->BA3_CODEMP .and.;
						BA1->BA1_MATRIC == BA3->BA3_MATRIC
					
					//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ä¿
					//ï¿½ Opcionais...                                                        ï¿½
					//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
					If !BF4->( dbSeek(xFilial("BF4")+BA1->BA1_CODINT+BA1->BA1_CODEMP+BA1->BA1_MATRIC+BA1->BA1_TIPREG+BHS->BHS_CODPLA) )
						
						BF4->( RecLock("BF4", .T.) )
						BF4->BF4_FILIAL := xFilial("BF1")
						BF4->BF4_CODEMP := BA3->BA3_CODEMP
						BF4->BF4_CODINT := BA3->BA3_CODINT
						BF4->BF4_MATRIC := BA3->BA3_MATRIC
						BF4->BF4_TIPREG := BA1->BA1_TIPREG
						
						BF4->BF4_DATBAS	:= BA3->BA3_DATBAS
						BF4->BF4_MOTBLO := BA3->BA3_MOTBLO
						BF4->BF4_DATBLO := BA3->BA3_DATBLO
						
						BF4->BF4_CODPRO := BHS->BHS_CODPLA
						BF4->BF4_VERSAO := BHS->BHS_VERPLA
						BF4->BF4_TIPVIN := '0'
						
						BF4->( MsUnlock() )
						
						//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ä¿
						//ï¿½ Suas formas de cobranca...                                          ï¿½
						//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
						If BHS->BHS_TIPVIN <> '1'
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
								
								//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ä¿
								//ï¿½ A tabela de precos...                                               ï¿½
								//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
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
								EndDo
								TRB1->( dbCloseArea() )
							EndIf
						EndIf
					EndIf
					BA1->( dbSkip() )
				EndDo
			EndIf
			BHS->( dbSkip() )
		EndDo
		BI3->(dbSkip())
	EndDo
	
Return
*/


/*/
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ä¿ï¿½ï¿½
ï¿½ï¿½ï¿½Descricao ï¿½ Atualiza perguntas                                         ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ä´ï¿½ï¿½
ï¿½ï¿½ï¿½Sintaxe   ï¿½ CriaSX1()                                                  ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ù±ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
/*/

Static Function CriaSX1()
	
	Local j := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS
	Local i := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS
	
	//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ä¿
	//ï¿½ Iniciliza variaveis                                                      ï¿½
	//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
	Local aRegs	:=	{}
	cPerg := "CBIMPV"
	_sAlias := Alias()
	dbSelectArea("SX1")
	dbSetOrder(1)
	aRegs:={}
	aAdd(aRegs,{cPerg,"01","Arquivo      ?","","","mv_ch1","C",04,0,0,"G","","mv_par01","","","","","","","","","","","","","","","","","","","","","","","","",""})
	aAdd(aRegs,{cPerg,"02","Operadora    ?","","","mv_ch2","C",04,0,0,"G","","mv_par02","","","","","","","","","","","","","","","","","","","","","","","","","B89"})
	aAdd(aRegs,{cPerg,"03","Grupo/Empresa?","","","mv_ch3","C",04,0,0,"G","","mv_par03","","","","","","","","","","","","","","","","","","","","","","","","","B7A"})
	aAdd(aRegs,{cPerg,"04","Contrato     ?","","","mv_ch4","C",12,0,0,"G","","mv_par04","","","","","","","","","","","","","","","","","","","","","","","","","B7B"})
	aAdd(aRegs,{cPerg,"05","Versao       ?","","","mv_ch5","C",03,0,0,"G","","mv_par05","","","","","","","","","","","","","","","","","","","","","","","","",""})
	aAdd(aRegs,{cPerg,"06","SubContrato  ?","","","mv_ch6","C",09,0,0,"G","","mv_par06","","","","","","","","","","","","","","","","","","","","","","","","","B7C"})
	aAdd(aRegs,{cPerg,"07","Versao       ?","","","mv_ch7","C",03,0,0,"G","","mv_par07","","","","","","","","","","","","","","","","","","","","","","","","","B7C"})
	
	For i:=1 to Len(aRegs)
		If !dbSeek(cPerg+aRegs[i,2])
			RecLock("SX1",.T.)
		Else
			RecLock("SX1",.F.)
		EndIf
		
		For j:=1 to FCount()
			If j <= Len(aRegs[i])
				If !Empty(aRegs[i,j])
					FieldPut(j,aRegs[i,j])
				EndIf
			EndIf
		Next
		MsUnlock()
	Next
	dbSelectArea(_sAlias)
	
Return


/*
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Í»ï¿½ï¿½
ï¿½ï¿½ï¿½Programa  ï¿½GerPreBA3 ï¿½Autor  ï¿½Microsiga           ï¿½ Data ï¿½  05/15/07   ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Í¹ï¿½ï¿½
ï¿½ï¿½ï¿½Desc.     ï¿½                                                            ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½          ï¿½                                                            ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Í¹ï¿½ï¿½
ï¿½ï¿½ï¿½Uso       ï¿½ AP                                                        ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Í¼ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
*/

Static Function GerPreBA3(nTipo,cCodcli)
	
	If nTipo == 1 // Somente na Inclusao
		
		BA3->BA3_FILIAL := xFilial("BA3")
		BA3->BA3_CODINT := ZZ0->ZZ0_CODOPE
		BA3->BA3_CODEMP := ZZ0->ZZ0_CODEMP
		BA3->BA3_CONEMP := cNumCon
		BA3->BA3_VERCON := "001"
		BA3->BA3_SUBCON := cSubCon
		BA3->BA3_VERSUB := "001"
		BA3->BA3_MATRIC	:=	cNovaMatric
		BA3->BA3_MATEMP	:=	AllTrim(ZZ1->ZZ1_FUNC)
		BA3->BA3_HORACN	:=	StrTran(Time(),':','')
		BA3->BA3_FORPAG  := "101"
		BA3->BA3_FORCTX  := "103"
		BA3->BA3_EQUIPE := cEquipe
		BA3->BA3_CODVEN := cVendedor
		
		BA3->BA3_CODVE2 := cVendedo2

		//------------------------------------------------------------------------------------------
		//Angelo Henrique - Data: 08/02/2021
		//------------------------------------------------------------------------------------------
		//No campo criado pela TOTVS no Protheus 12 - Release 27
		//Campo para atender a compensação automática, gerando um título DP e um NCC
		//------------------------------------------------------------------------------------------
		BA3->BA3_COMAUT := "1" //SIM
		
	EndIf
	
	If nTipo <= 2 // Somente na Inclusao e Alteracao
		
		BA3->BA3_DATBAS	:= iIf(ZZ1->ZZ1_OPER =="05",ctod(ZZ1->ZZ1_DTINPD),ctod(ZZ1->ZZ1_DTINCT)) // PAULO MOTTA 20/07/07
		BA3->BA3_TIPOUS	:=	'2'
		
		If nTipo == 1	// Somente na Inclusao
			BA3->BA3_CODPLA	:=	BI3->BI3_CODIGO
			BA3->BA3_VERSAO	:=	"001"
			BA3->BA3_TIPCON	:=	BI3->BI3_TIPCON
			BA3->BA3_SEGPLA	:=	BI3->BI3_CODSEG
			BA3->BA3_MODPAG	:=	BI3->BI3_MODPAG
			BA3->BA3_TXUSU	:=	'0'
			//BA3->BA3_AGMTFU	:=	cNovaMatric
			BA3->BA3_APLEI	:=	BI3->BI3_APOSRG
			BA3->BA3_CODACO	:=	BI3->BI3_CODACO
			BA3->BA3_ABRANG	:=	BI3->BI3_ABRANG
		EndIf
		
		BA3->BA3_FAIDES	:=	''
		BA3->BA3_VALSAL	:=	0
		BA3->BA3_ENDCOB	:=	'2'
		BA3->BA3_USUOPE	:=	"Importa"
		BA3->BA3_RGIMP	:=	'1'
		BA3->BA3_DEMITI	:=	iIf(dtoc(ctod(ZZ1->ZZ1_DTDESL)) == "  /  /  ","0","1")
		BA3->BA3_DATDEM	:=	ctod(ZZ1->ZZ1_DTDESL)
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
		
		//BIANCHINI - 28/08/2014 - Associar Cliente quando o subcontrato for Art.30/31
		If (cArt3031 == ZZ0->ZZ0_ART30) .and. !empty(cArt3031) .and. !empty(ZZ0->ZZ0_ART30)
			
			BA3->BA3_COBNIV := '1'
			BA3->BA3_VENCTO := 10
			BA3->BA3_CODCLI := cCodcli
			BA3->BA3_LOJA	:= '01'
			BA3->BA3_NATURE := '30'
			BA3->BA3_TIPPAG := '04'
			
			cTmpCep := iIf(At("-",ZZ1->ZZ1_CEP) > 0,Substr(ZZ1->ZZ1_CEP,1,5)+Substr(ZZ1->ZZ1_CEP,7,3),ZZ1->ZZ1_CEP)
			
			SA1->(dbSetOrder(1))
			If SA1->(dbSeek(xFilial("SA1")+cCodcli))
				BC9->(DbSetOrder(1))
				If BC9->(DbSeek(xFilial("BC9")+cTmpCep))
					BA3->BA3_CEP	:=	SA1->A1_CEPC
					BA3->BA3_END	:=	SA1->A1_ENDCOB
					//BA3->BA3_NUMERO	:=	' '
					//BA3->BA3_COMPLE	:=	' '
					BA3->BA3_BAIRRO	:=	SA1->A1_BAIRROC
					BA3->BA3_CODMUN	:=	BC9->BC9_CODMUN
					BA3->BA3_MUN	:= 	SA1->A1_MUNC
					BA3->BA3_ESTADO	:=	SA1->A1_ESTC
				EndIf
			EndIf
			
		Else
			
			BA3->BA3_COBNIV	:= '0'
			
		EndIf
		BA3->BA3_BCOCLI := ZZ1->ZZ1_BANCO
		BA3->BA3_AGECLI := ZZ1->ZZ1_AGENC
		BA3->BA3_CTACLI := ZZ1->ZZ1_NUMCC
		
	EndIf
	
	If nTipo == 3	// Somente no Bloqueio
		
		If ZZ1->ZZ1_DEPEND == '00'  //1o. - Checa se eh titular, Ao bloquear um titular bloqueio a familia
			
			BA3->BA3_MOTBLO	:=	ZZ1->ZZ1_MOTEXC
			BA3->BA3_DATBLO	:=	iIf(ZZ1->ZZ1_MOTEXC>"",CTOD(REPLACE(ZZ1->ZZ1_DTEXC,'.','/')),"")
			BC3->(RecLock("BC3",.T.))
			BC3->BC3_FILIAL := xFilial("BC3")
			**'Marcela Coimbra - 24/11/2015 - Nao esta ponterado na BA1. Alterado pois estava criando o bloqueio apenas na matricula 00010007000001'**
			BC3->BC3_MATRIC := BA3->(BA3_CODINT+BA3_CODEMP+BA3_MATRIC)
			//	    BC3->BC3_MATRIC := BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC)
			//	BC3->BC3_TIPREG := BA1->(BA1_TIPREG)
			If ZZ1->ZZ1_OPER == "03"
				BC3->BC3_TIPO   := "0"
				BC3->BC3_DATA   := iIf(ZZ1->ZZ1_MOTEXC>"",CTOD(REPLACE(ZZ1->ZZ1_DTEXC,'.','/')),"")
				BC3->BC3_MOTBLO := ZZ1->ZZ1_MOTEXC
				BC3->BC3_OBS    := "Bloq. Import, arqv:" + AllTrim(ZZ0->ZZ0_NOMARQ) + " Data: " + DTOC(dDataBase)
			ElseIf ZZ1->ZZ1_OPER == "06"
				BC3->BC3_TIPO   := "1"
				BC3->BC3_DATA   := dDataBase
				BC3->BC3_OBS    := "Desbloq. Import, arqv:" + AllTrim(ZZ0->ZZ0_NOMARQ) + " Data: " + DTOC(dDataBase)
			EndIf
			
			//Angelo Henrique - Data: 16/05/2017
			BC3->BC3_DATLAN := dDataBase
			BC3->BC3_HORLAN := TIME()
			//Angelo Henrique - Data: 16/05/2017
			
			BC3->BC3_MATANT := BA3->BA3_MATANT
			BC3->BC3_BLOFAT := "1"
			BC3->BC3_NIVBLQ := "F"
			BC3->BC3_USUOPE := cUserName
			BC3->(MsUnlock())
			
		EndIf
	EndIf
	
Return


/*
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Í»ï¿½ï¿½
ï¿½ï¿½ï¿½Programa  ï¿½GerPreBTS ï¿½Autor  ï¿½Microsiga           ï¿½ Data ï¿½  05/15/07   ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Í¹ï¿½ï¿½
ï¿½ï¿½ï¿½Desc.     ï¿½                                                            ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½          ï¿½                                                            ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Í¹ï¿½ï¿½
ï¿½ï¿½ï¿½Uso       ï¿½ AP                                                        ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Í¼ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
*/

Static Function GerPreBTS(nTipo,lTit)
	
	If nTipo == 1
		If empty(BTS->BTS_MATVID) //BIANCHINI - 24/07/2014 - GARANTINDO QUE A VIDA JA EXISTENTE SEJA REAPROVEITADA
			BTS->BTS_FILIAL	:=	xFilial("BTS")
			BTS->BTS_MATVID := GetSx8Num("BTS","BTS_MATVID")
			ConfirmSx8()
		EndIf
	EndIf
	
	If nTipo <= 2
		BTS->BTS_NOMUSR	:=	UPPER(ZZ1->ZZ1_BENEF)
		BTS->BTS_SOBRN	:=	UPPER(SUBS( ZZ1->ZZ1_BENEF, AT( ' ', ZZ1->ZZ1_BENEF ) + 1 ))
		//BTS->BTS_NOMCAR	:=  SUBS( RTRIM(ZZ1->ZZ1_BENEF), 01, 30 )
		BTS->BTS_NOMCAR	:=  UPPER(SUBS( RTRIM(ZZ1->ZZ1_BENEF), 01, 50 ))   //RAQUEL - SO PODE MUDAR PRA ISSO QDO SALVAR O CAMPO
		BTS->BTS_DATNAS	:=	ctod(ZZ1->ZZ1_DTNASC)
		BTS->BTS_SEXO	:=	iIf(ZZ1->ZZ1_SEXO =="M","1","2")
		If ZZ1->ZZ1_ESTCIV == "S"
			BTS->BTS_ESTCIV	:=	"S"
		ElseIf ZZ1->ZZ1_ESTCIV == "C"
			BTS->BTS_ESTCIV	:=	"C"
		ElseIf ZZ1->ZZ1_ESTCIV == "R"
			BTS->BTS_ESTCIV	:=	"D"
		ElseIf ZZ1->ZZ1_ESTCIV == "V"
			BTS->BTS_ESTCIV	:=	"V"
		ElseIf ZZ1->ZZ1_ESTCIV == "M"
			BTS->BTS_ESTCIV	:=	"M"
		ElseIf ZZ1->ZZ1_ESTCIV == "J"
			BTS->BTS_ESTCIV	:=	"Q"
		EndIf
		
		BTS->BTS_CPFUSR	:=	If(ZZ1->ZZ1_CPF<>" ",ZZ1->ZZ1_CPF,BTS->BTS_CPFUSR)  //iIf(lTit,ZZ1->ZZ1_CPF,"")
		
		BTS->BTS_PISPAS := 	iIf(ZZ1->ZZ1_PIS<>" ",ZZ1->ZZ1_PIS,BTS->BTS_PISPAS)  //iIf(lTit,ZZ1->ZZ1_PIS,"")
		BTS->BTS_CEPUSR	:=	iIf(At("-",ZZ1->ZZ1_CEP) > 0,Substr(ZZ1->ZZ1_CEP,1,5)+Substr(ZZ1->ZZ1_CEP,7,3),ZZ1->ZZ1_CEP)
		
		BC9->(DbSetOrder(1))
		If BC9->(DbSeek(xFilial("BC9")+BTS->BTS_CEPUSR))
			BTS->BTS_ENDERE	:= UPPER(BC9->BC9_END)
			BTS->BTS_NR_END := ZZ1->ZZ1_NUMERO // PAULO MOTTA 20/09/06
			BTS->BTS_COMEND := UPPER(ZZ1->ZZ1_COMPLE) // PAULO MOTTA 20/09/06
			BTS->BTS_BAIRRO	:=	UPPER(BC9->BC9_BAIRRO)
			BTS->BTS_CODMUN	:=	BC9->BC9_CODMUN
			BTS->BTS_MUNICI	:=	UPPER(BC9->BC9_MUN)
			BTS->BTS_ESTADO	:=	UPPER(BC9->BC9_EST)
			//BIANCHINI - 02/02/15 - Isso aqui nao funciona mais porque a critica foi corrigida.  Quando o CEP nao existir na BC9, nem sequer passa da critica
			/*
		Else
			BTS->BTS_ENDERE	:= UPPER(ZZ1->ZZ1_LOGRAD)
			BTS->BTS_NR_END := ZZ1->ZZ1_NUMERO // PAULO MOTTA 20/09/06
			BTS->BTS_COMEND := UPPER(ZZ1->ZZ1_COMPLE) // PAULO MOTTA 20/09/06
			BTS->BTS_BAIRRO	:= UPPER(ZZ1->ZZ1_BAIRRO)
			BTS->BTS_MUNICI	:= UPPER(ZZ1->ZZ1_CIDADE)
			BTS->BTS_ESTADO	:= UPPER(ZZ1->ZZ1_UF) */
		EndIf
		BTS->BTS_MAE		:= UPPER(ZZ1->ZZ1_NOMMAE)
		BTS->BTS_DDD    	:= ZZ1->ZZ1_DDDRES
		BTS->BTS_TELEFO		:= ZZ1->ZZ1_TELRES
		BTS->BTS_EMAIL		:= UPPER(ZZ1->ZZ1_EMAIL)  // PAULO MOTTA 20/09/06
		BTS->BTS_YCEL		:= ZZ1->ZZ1_TELCEL // PAULO MOTTA 20/09/06
		
		BTS->BTS_NRCRNA 	:= AllTrim(ZZ1->ZZ1_CNS)	//Leonardo Portella - 06/06/16
		BTS->BTS_DENAVI 	:= AllTrim(ZZ1->ZZ1_NASVIV)	//Leonardo Portella - 06/06/16
		
	EndIf
	
	If nTipo == 2
		
		If (cArt3031 == ZZ0->ZZ0_ART30) .and. !empty(cArt3031) .and. !empty(ZZ0->ZZ0_ART30)
			If GerPreSA1(ZZ1->ZZ1_CPF,2)
				SA1->(RecLock("SA1",.F.))
				SA1->A1_END		:=	UPPER(TRIM(ZZ1->ZZ1_LOGRAD))+" "+ZZ1->ZZ1_NUMERO+" "+UPPER(ZZ1->ZZ1_COMPLE)
				SA1->A1_MUN		:=	UPPER(ZZ1->ZZ1_CIDADE)
				SA1->A1_EST		:=	UPPER(ZZ1->ZZ1_UF)
				SA1->A1_BAIRRO	:=	UPPER(ZZ1->ZZ1_BAIRRO)
				SA1->A1_CEP		:=	ZZ1->ZZ1_CEP
				SA1->A1_DDD		:=	TRIM(ZZ1->ZZ1_DDDRES)
				SA1->A1_TEL		:=	TRIM(ZZ1->ZZ1_TELRES)
				SA1->A1_ENDCOB	:=	UPPER(TRIM(ZZ1->ZZ1_LOGRAD))+" "+ZZ1->ZZ1_NUMERO+" "+UPPER(ZZ1->ZZ1_COMPLE)
				SA1->A1_BAIRROC	:=	UPPER(ZZ1->ZZ1_BAIRRO)
				SA1->A1_CEPC	:=	ZZ1->ZZ1_CEP
				SA1->A1_MUNC	:=	UPPER(ZZ1->ZZ1_CIDADE)
				SA1->A1_ESTC	:=	UPPER(ZZ1->ZZ1_UF)
				SA1->(MsUnlock())
			EndIf
		EndIf
		
	EndIf
	
Return


/*
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Í»ï¿½ï¿½
ï¿½ï¿½ï¿½Programa  ï¿½GerPreBA1 ï¿½Autor  ï¿½Microsiga           ï¿½ Data ï¿½  04/12/07   ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Í¹ï¿½ï¿½
ï¿½ï¿½ï¿½Desc.     ï¿½                                                            ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½          ï¿½                                                            ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Í¹ï¿½ï¿½
ï¿½ï¿½ï¿½Uso       ï¿½ AP                                                        ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Í¼ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
*/
Static Function GerPreBA1(nTipo,lTit)
	
	Local _cMotBlq	:= "" //Angelo Henrique - Data:10/05/2017
	Local _lOk 		:= .T.//Angelo Henrique - Data:25/04/2018
	
	//Bianchini 25/10/2012 - Como convenios nao sao vendidos, Equipe e vendedor ficam em branco. Por isso trato mais abaixo BA1_TIPINC com 0(ZERO)
	/*If cEmpAnt == '01'
	cEquipe := ""
	cVendedor := ""
	cVendedo2 := ""
EndIf     */

If nTipo == 1
	BA1->BA1_CODINT	:=	BA3->BA3_CODINT
	BA1->BA1_CODEMP	:=	BA3->BA3_CODEMP
	BA1->BA1_MATRIC	:=	BA3->BA3_MATRIC
	BA1->BA1_CONEMP	:=	BA3->BA3_CONEMP
	BA1->BA1_VERCON	:=	BA3->BA3_VERCON
	BA1->BA1_SUBCON	:=	BA3->BA3_SUBCON
	BA1->BA1_VERSUB	:=	BA3->BA3_VERSUB
	BA1->BA1_IMAGE	:=	'ENABLE'
	BA1->BA1_TIPREG	:=	RetTpReg(BA3->(BA3->BA3_CODINT+BA3->BA3_CODEMP+BA3->BA3_MATRIC) , ZZ1->ZZ1_DEPEND )// ZZ1->ZZ1_DEPEND -- Angelo Henrique - Data: 19/02/2020
	BA1->BA1_DIGITO :=	Modulo11( BA1->BA1_CODINT + BA1->BA1_CODEMP + BA1->BA1_MATRIC + BA1->BA1_TIPREG )
	BA1->BA1_TIPUSU	:=	UPPER(DPTipoBnfbd(ZZ1->ZZ1_CDBENE))
	BA1->BA1_GRAUPA	:=	UPPER(DParaGrauPar(ZZ1->ZZ1_TPPARE,iIf(ZZ1->ZZ1_SEXO =="M","1","2"), ZZ1->ZZ1_DEPEND))
	BA1->BA1_EQUIPE := cEquipe
	BA1->BA1_CODVEN := BQC->BQC_CODVEN
	
	BA1->BA1_CODVE2 := BQC->BQC_CODVE2
	
	If cEmpAnt == '01'
		//BA1->BA1_TIPINC := "0" //Bianchini 25/10/2012 - Convenios Reciprocidade nao geram comissao
		//Angelo Henrique - Data: 17/10/2018 - COnforme alinhado com Altamiro, para comissï¿½o este campo  necessita estar como 1, pois existem empresas na caberj que geram comissï¿½o
		BA1->BA1_TIPINC := "1"
	Else
		BA1->BA1_TIPINC := "1" // Motta 29/11/07 para que o sistema calcule a comissï¿½o para novos usuï¿½rios (plano novo)
	EndIf
	
	BA1->BA1_YDTDIG := dDataBase
	
EndIf

If nTipo <= 2 // Somente na Inclusao Alteracao
	
	cQuery := " SELECT ZZ1_OPER, ZZ1_FUNC, ZZ1_DEPEND, ZZ1_BENEF, ZZ1_CPF FROM " + RetSqlName("ZZ1")
	cQuery += " WHERE ZZ1_FILIAL = '" + xFilial('ZZ1') + "'"
	cQuery += " AND ZZ1_FUNC = '" + ZZ1->(ZZ1_FUNC) + "'"
	cQuery += " AND ZZ1_DEPEND = '00' "
	cQuery += " AND ZZ1_SEQUEN = '" + ZZ1->ZZ1_SEQUEN + "'"
	cQuery += " AND D_E_L_E_T_ = ' ' "
	
	TCQuery cQuery Alias "TRBZZ1" New
	
	DbSelectArea("TRBZZ1")
	
	If BA1->BA1_TIPREG == '00' //Titular sempre deve ter o CPF
		BA1->BA1_CPFUSR	:= If(!empty(ZZ1->ZZ1_CPF),ZZ1->ZZ1_CPF,BA1->BA1_CPFUSR)
	EndIf
	
	//Leonardo Portella - 17/08/16 - Inï¿½cio - Validaï¿½ï¿½o do CPF do Preposto conforme controle no CBI - Chamado - ID: 29510
	//Alinhado com o Altamiro por causa da DMED.
	
	//-----------------------------------------------------------------------------------------------------------
	//-----------------------------------------------------------------------------------------------------------
	//Angelo Henrique - Data: 03/08/2017 - Chamado: 40801 - A Data reduziu para 12 anos(Receita Federal)
	//-----------------------------------------------------------------------------------------------------------
	//If ( AllTrim(ZZ1->ZZ1_CPFPRE) == 'S' ) .and. ( u_nCalcIdade(CtoD(ZZ1->ZZ1_DTNASC)) < 18 )
	//-----------------------------------------------------------------------------------------------------------
	//-----------------------------------------------------------------------------------------------------------
	//Angelo Henrique - Data: 13/12/2017 - Chamado: 45073 - Idade reduzida para 8 anos(Receita Federal)
	//-----------------------------------------------------------------------------------------------------------
	//If ( AllTrim(ZZ1->ZZ1_CPFPRE) == 'S' ) .and. ( u_nCalcIdade(CtoD(ZZ1->ZZ1_DTNASC)) < 12 )
	//-----------------------------------------------------------------------------------------------------------
	//-----------------------------------------------------------------------------------------------------------
	If ( AllTrim(ZZ1->ZZ1_CPFPRE) == 'S' ) .and. ( u_nCalcIdade(CtoD(ZZ1->ZZ1_DTNASC)) < 8 )
		BA1->BA1_CPFPRE := ZZ1->ZZ1_CPF
		BA1->BA1_NOMPRE := Upper(TRBZZ1->ZZ1_BENEF)
		
		//Leonardo Portella - 16/11/16 - Inï¿½cio
		
		//Se for preposto, preciso limpar pois o SIB pega o BA1_CPFUSR que estarï¿½ em duplicidade e critica (cod. critica SIB 0410). O
		//padrï¿½o caso o cpf esteja vazio pega o cpf do preposto.
		
		If BA1->BA1_TIPREG == '00' //Titular sempre deve ter o CPF
			BA1->BA1_CPFUSR	:= ZZ1->ZZ1_CPF
		Else
			BA1->BA1_CPFUSR	:= ""
		EndIf
		
		//Leonardo Portella - 16/11/16 - Fim
		
	Else
		BA1->BA1_CPFPRE := ""
		BA1->BA1_NOMPRE := ""
		BA1->BA1_CPFUSR	:= ZZ1->ZZ1_CPF
	EndIf
	
	/*
	If int( (dDataBase - BTS->BTS_DATNAS)/365 ) >= 18
		BA1->BA1_CPFUSR	:=	If(ZZ1->ZZ1_CPF <> "",ZZ1->ZZ1_CPF,BA1->BA1_CPFUSR)  //iIf(lTit,ZZ1->ZZ1_CPF,"")
		BA1->BA1_CPFPRE  := " "
		BA1->BA1_NOMPRE  := " "
	Else
		BA1->BA1_CPFUSR	:= If(ZZ1->ZZ1_CPF <> "",ZZ1->ZZ1_CPF,BA1->BA1_CPFUSR)
		
		BA1->BA1_CPFPRE  := TRBZZ1->ZZ1_CPF
		
		BA1->BA1_NOMPRE  := UPPER(TRBZZ1->ZZ1_BENEF)
	EndIf
	*/
	
	//Leonardo Portella - 17/08/16 - Fim
	
	TRBZZ1->(DbCloseArea())
	
	BA1->BA1_PISPAS	:=	BTS->BTS_PISPAS
	BA1->BA1_DRGUSR	:=	BTS->BTS_DRGUSR
	BA1->BA1_ORGEM	:=	BTS->BTS_ORGEM
	BA1->BA1_MATVID	:=	BTS->BTS_MATVID
	BA1->BA1_NOMUSR	:=	UPPER(BTS->BTS_NOMUSR)
	BA1->BA1_NREDUZ	:=	UPPER(BTS->BTS_NOMCAR)
	BA1->BA1_DATNAS	:=	BTS->BTS_DATNAS
	BA1->BA1_SEXO	:=	iIf(ZZ1->ZZ1_SEXO =="M","1","2")
	// PAULO MOTTA 20/09/06
	// BA1->BA1_TIPUSU	:=	DParaTipoBnf(ZZ1->ZZ1_CDBENE)
	// BA1->BA1_TIPUSU	:=	DPTipoBnfbd(ZZ1->ZZ1_CDBENE) //ModIficado posicionamento para dentro da funcao AltSubUsuar()
	BA1->BA1_ESTCIV	:=	BTS->BTS_ESTCIV
	//BA1->BA1_GRAUPA	:=	DParaGrauPar(ZZ1->ZZ1_TPPARE,iIf(ZZ1->ZZ1_SEXO =="M","1","2")) //ModIficado posicionamento para dentro da funcao AltSubUsuar()
	//BA1->BA1_DATINC	:=	ctod(ZZ1->ZZ1_DTINPD) // PAULO MOTTA 26/04/07
	BA1->BA1_DATINC	:=	iIf(ZZ1->ZZ1_OPER =="05",ctod(ZZ1->ZZ1_DTINPD),ctod(ZZ1->ZZ1_DTINCT)) // PAULO MOTTA 26/04/07
	BA1->BA1_DATADM	:=	ctod(ZZ1->ZZ1_DTADMI)
	BA1->BA1_RECNAS	:=	IIf( dDataBase - BTS->BTS_DATNAS <= 60, '1', '0' )
	BA1->BA1_CEPUSR	:=	BTS->BTS_CEPUSR
	BA1->BA1_ENDERE	:=	UPPER(BTS->BTS_ENDERE)
	BA1->BA1_NR_END	:=	BTS->BTS_NR_END //PAULO MOTTA 20/09/06
	BA1->BA1_COMEND	:=	BTS->BTS_COMEND //PAULO MOTTA 20/09/06
	BA1->BA1_BAIRRO	:=	UPPER(BTS->BTS_BAIRRO)
	BA1->BA1_CODMUN	:=	BTS->BTS_CODMUN
	BA1->BA1_MUNICI	:=	UPPER(BTS->BTS_MUNICI)
	BA1->BA1_ESTADO	:=	UPPER(BTS->BTS_ESTADO)
	BA1->BA1_DDD	:=	BTS->BTS_DDD // PAULO MOTTA 20/09/06
	BA1->BA1_TELEFO	:=	BTS->BTS_TELEFO
	BA1->BA1_YCEL   :=  BTS->BTS_YCEL // PAULO MOTTA 20/09/06
	BA1->BA1_MATEMP	:=	AllTrim(ZZ1->ZZ1_FUNC)+ZZ1->ZZ1_DEPEND
	//BA1->BA1_MATEMP	:=	AllTrim(ZZ1->ZZ1_FUNC)+ZZ1->ZZ1_DEPEND
	// BA1->BA1_DATCAR	:=	If(ZZ1->ZZ1_INDCAR == "S",ctod(ZZ1->ZZ1_DTINCT),ctod(ZZ1->ZZ1_DTINPD))
	// BA1->BA1_DATCAR	:=	If(ZZ1->ZZ1_INDCAR == "S",ctod(ZZ1->ZZ1_DTINPD),CtoD("01/11/03"))//Paulo Motta 22/3/07 carencia data contrato
	BA1->BA1_DATCAR	:=  ctod(ZZ1->ZZ1_DTINCT) //BIANCHINI - 30/10/12 - ASSUME-SE A PARTIR DAQUI QUE A DATA DE CARENCIA ï¿½ PELO MENOS A DATA DE INCLUSAO DO ASSISTIDO
	//BA1->BA1_CONSID	:= 'U'
	BA1->BA1_COEFIC	:= 1
	BA1->BA1_MUDFAI	:= "1"
	BA1->BA1_CORNAT	:= BTS->BTS_CORNAT
	BA1->BA1_SANGUE	:= BTS->BTS_SANGUE
	
	If nTipo < 2
		
		BA1->BA1_VIACAR	:= 0
		
	EndIf
	
	BA1->BA1_CODFUN	:= BTS->BTS_CODFUN
	BA1->BA1_INSALU	:= BTS->BTS_INSALU
	BA1->BA1_CODSET	:= BTS->BTS_CODSET
	BA1->BA1_PESO	:= BTS->BTS_PESO
	BA1->BA1_ALTURA	:= BTS->BTS_ALTURA
	BA1->BA1_OBESO	:= BTS->BTS_OBESO
	BA1->BA1_RGIMP	:= '1'
	BA1->BA1_JACOBR	:= '0'
	BA1->BA1_INFCOB	:= '0'
	BA1->BA1_INFGCB	:= '0'
	BA1->BA1_INFPRE	:= '0'
	BA1->BA1_NSUBFT	:= ''
	BA1->BA1_USRVIP	:= '0'
	BA1->BA1_UNIVER := '0'
	BA1->BA1_INTERD := '0'
	BA1->BA1_10ANOS := '0'
	BA1->BA1_INSALU := '0'
	BA1->BA1_COBNIV := '0'
	BA1->BA1_ESCOLA := '0'
	BA1->BA1_CB1AMS := '0'
	BA1->BA1_BANCO	:= ''
	BA1->BA1_AGENCI	:= ''
	BA1->BA1_CONTA	:= ''
	BA1->BA1_LOCCOB := '1'
	BA1->BA1_LOCATE := '1'
	BA1->BA1_LOCEMI	:= '1'
	BA1->BA1_LOCANS	:= '1'
	
	// 19-03-2020 - TRATAMENTO DA EMPRESA 0346 NA INTEGRAL NAO IR PARA O SIB
	
	If ((cEmpant == '01') .and. (BA3->BA3_CODEMP $ '0004|0009') ;
			.OR. (cEmpant == '02') .and. (BA3->BA3_CODEMP $ '0346'))
		BA1->BA1_INFSIB	:= '0'
		BA1->BA1_INFANS	:= '0'
		BA1->BA1_ATUSIB := '0'
	Else
		BA1->BA1_INFSIB	:= '1'
		BA1->BA1_INFANS	:= '1'
		BA1->BA1_ATUSIB := '1'
	EndIf
	
	If (BA1->BA1_CODCCO = ' ' .and. DTOS(BA1->BA1_DATBLO) = ' ' )
		BA1->BA1_LOCSIB	:=	'0'
	EndIf
	
	
	// altamiro - 19-03-2020 - tratamento para os campos de residente no exterior
	// e tipo de endereço exigidos no SIB apos a virada da v12
	
	ba1->ba1_resext := '0'
	ba1->ba1_tipend := '2'
	//
	
	BA1->BA1_OK		:=	''
	BA1->BA1_ESCOLA	:=	''
	BA1->BA1_CDORIG	:=	''
	BA1->BA1_PSORIG	:=	''
	BA1->BA1_OUTLAN := '0'
	BA1->BA1_LANREJ := '0'
	//BA1->BA1_ENDTIT := '1' campo excluido na build nova
	//BA1->BA1_ENDCLI := '0' campo excluido na build nova
	BA1->BA1_STAEDI := '1'
	BA1->BA1_ORIEND :='4'
	BA1->BA1_SOBRN	:=	UPPEr(BTS->BTS_SOBRN)
	BA1->BA1_FILIAL	:=	xFilial("BA1")
	If nTipo == 1
		//BIANCHINI - 23/07/2019 - A CASA DA MOEDA (CMB) poderï¿½ ter planos diferentes entre os membros da familia
		If (cEmpAnt == "02") .and. (ZZ0->ZZ0_CODEMP == '0325')
			BA1->BA1_CODPLA	:=	ZZ1->ZZ1_PADRAO
		Else
			BA1->BA1_CODPLA	:=	BA3->BA3_CODPLA //10/07/07
		Endif
		BA1->BA1_VERSAO	:=	BA3->BA3_VERSAO //10/07/07 nao sofre alteracao via movimento 2
	EndIf
	//	BA1->BA1_TIPINC	:=	''
	BA1->BA1_LOTTRA	:=	''
	BA1->BA1_FORPAG	:=	'101'
	If ZZ0->ZZ0_OPEORI <> ' '
		BA1->BA1_OPEORI	:=	ZZ0->ZZ0_OPEORI
	Else
		BA1->BA1_OPEORI	:= '0001'
	EndIf
	//BA1->BA1_OPEORI	:=	ZZ1->ZZ1_OPEORI
	
	If ZZ0->ZZ0_OPEDES <> ' '
		BA1->BA1_OPEDES	:=	ZZ0->ZZ0_OPEDES
	Else
		BA1->BA1_OPEDES	:=	'0001'
	EndIf
	//BA1->BA1_OPEDES	:=	ZZ0->ZZ0_CODOPE
	
	BA1->BA1_OPERES	:=	ZZ0->ZZ0_CODOPE
	BA1->BA1_MAE	:=  UPPER(BTS->BTS_MAE)
	BA1->BA1_IMPORT := "IMPORTADO: " + ZZ0->ZZ0_SEQUEN + "DATA IMPORTACAO: " + DTOC(ZZ0->ZZ0_DTIMPO)
	// 18/01/2006 Paulo Motta
	BA1->BA1_YLOTAC := ZZ1->ZZ1_CODLOT
	BA1->BA1_YNOMLO := ZZ1->ZZ1_ORGAO
	BA1->BA1_YINDEN := ZZ1->ZZ1_INDENV
	
	//Bianchini - 11/07/2019 - MATRICULA REPASSE E PORTABILIDADE
	BA1->BA1_YMTREP := ZZ1->ZZ1_MATREP
	BA1->BA1_YPORTA := ZZ1->ZZ1_PORTAB

	// Fred - 19/11/21 - tratamento da carencia
	BA1->BA1_XTPCAR	:= iif(ZZ1->ZZ1_TPCARE == 'S', "0", iif(ZZ1->ZZ1_TPCARE == 'N', "2", iif(ZZ1->ZZ1_TPCARE == 'C', "3", "1")))
	if ZZ1->ZZ1_TPCARE == 'C' .and. SubStr(ZZ1->ZZ1_DTCONC,7,4) >= '1900'
		BA1->BA1_XDTCON	:= CtoD(ZZ1->ZZ1_DTCONC)
	endif
	if SubStr(ZZ1->ZZ1_CASAME,7,4) >= '1900'
		BA1->BA1_DATCAS	:= CtoD(ZZ1->ZZ1_CASAME)
	endif

EndIf
If (nTipo == 3) //.and. (EMPTY(BA1->BA1_DATBLO))  	// Somente no Bloqueio
	
	If BA1->BA1_TIPREG == "00"
		
		//		cQuery := " select * from " + RetSqlName("BA1")
		//		cQuery += " WHERE BA1_FILIAL = '" + xFilial('BA1') + "'"
		//		cQuery += " AND BA1_MATEMP = '" + AllTrim(ZZ1->(ZZ1_FUNC + ZZ1_DEPEND) + "'"
		//		cQuery += " AND BA1_CODEMP = '" + ZZ1->ZZ1_CODEMP + "'"
		//
		//		**'Marcela Coimbra - INICIO - Inclusï¿½o de contrato/subcontrato na seleï¿½ï¿½o'**
		//
		//		cQuery += " AND BA1_CONEMP = '" + ZZ0->ZZ0_NUMCON + "'"
		//		cQuery += " AND BA1_SUBCON = '" + ZZ0->ZZ0_SUBCON + "'"
		//
		//		**'Marcela Coimbra - FIM -  Inclusï¿½o de contrato/subcontrato na seleï¿½ï¿½o'**
		//
		//		**'Marcela Coimbra - Nï¿½o alterar data de bloqueio de quem jï¿½ foi bloqueado'**
		//		cQuery += " AND BA1_DATBLO = ' ' "
		//		**'Marcela Coimbra - FIm - Nï¿½o alterar data de bloqueio de quem jï¿½ foi bloqueado'**
		//
		//		cQuery += " AND D_E_L_E_T_ = ' ' "
		//		cQuery += " ORDER BY BA1_TIPREG "  //2o. - Ponteiro na BA1 pra ver se tem dependentes bloqueados
		
		cQuery := " SELECT 																	" + cEnt
		cQuery += "     BA1.*																" + cEnt
		cQuery += " FROM																	" + cEnt
		cQuery += "     " + RetSqlName("BA1") + " BA1 										" + cEnt
		cQuery += "     																	" + cEnt	
		cQuery += "     INNER JOIN															" + cEnt
		cQuery += "         " + RetSqlName("BA3") + " BA3									" + cEnt	
		cQuery += "     ON      															" + cEnt
		cQuery += "         BA3.BA3_FILIAL = BA1.BA1_FILIAL									" + cEnt
		cQuery += "         AND BA3.BA3_CODINT = BA3.BA3_CODINT								" + cEnt
		cQuery += "         AND BA3.BA3_CODEMP = BA1.BA1_CODEMP								" + cEnt
		cQuery += "         AND BA3.BA3_MATRIC = BA1.BA1_MATRIC								" + cEnt
		cQuery += "         AND BA3.BA3_CONEMP = BA1.BA1_CONEMP								" + cEnt
		cQuery += "         AND BA3.BA3_SUBCON = BA1.BA1_SUBCON								" + cEnt
		cQuery += "         AND TRIM(BA3.BA3_MATEMP) = '" + AllTrim(ZZ1->ZZ1_FUNC) + "'		" + cEnt
		cQuery += "         AND BA3.D_E_L_E_T_ = BA1.D_E_L_E_T_								" + cEnt
		cQuery += "         																" + cEnt
		cQuery += " WHERE 																	" + cEnt
		cQuery += "     BA1_FILIAL = '" + xFilial('BA1') + "' 								" + cEnt
		cQuery += " 	AND BA1_CODEMP = '" + ZZ1->ZZ1_CODEMP + "'							" + cEnt
		cQuery += " 	AND BA1_CONEMP = '" + ZZ0->ZZ0_NUMCON + "'							" + cEnt
		cQuery += " 	AND BA1_SUBCON = '" + ZZ0->ZZ0_SUBCON + "'							" + cEnt
		cQuery += "     AND BA1_DATBLO = ' '  												" + cEnt
		cQuery += "     AND BA1.D_E_L_E_T_ = ' ' 											" + cEnt
		cQuery += " ORDER BY BA1_TIPREG 													" + cEnt
		
		TCQuery cQuery Alias "TRBBA1" New
		
		dbSelectArea("TRBBA1")
		
		TRBBA1->(dbGoTop())
		
		WHILE TRBBA1->(!EOF())
			If EMPTY(TRBBA1->BA1_DATBLO)
				dbSelectArea("BA1")
				dbSetOrder(2)
				dbSeek(xFilial("BA1")+TRBBA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG+BA1_DIGITO))
				BA1->(RecLock("BA1",.F.))
				BA1->BA1_MOTBLO	:=	ZZ1->ZZ1_MOTEXC
				BA1->BA1_DATBLO	:=	iIf(ZZ1->ZZ1_MOTEXC>"",CTOD(REPLACE(ZZ1->ZZ1_DTEXC,'.','/')),"")
				BA1->BA1_IMAGE :=	'DISABLE'
				BA1->BA1_CONSID := "F"
				BA1->BA1_BLOFAT := "1"
				BCA->(RecLock("BCA",.T.))
				BCA->BCA_FILIAL := xFilial("BCA")
				BCA->BCA_MATRIC := TRBBA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC)
				BCA->BCA_TIPREG := TRBBA1->(BA1_TIPREG)
				If ZZ1->ZZ1_OPER == "03"
					BCA->BCA_TIPO   := "0"
					BCA->BCA_DATA   := iIf(ZZ1->ZZ1_MOTEXC>"",CTOD(REPLACE(ZZ1->ZZ1_DTEXC,'.','/')),"")
					BCA->BCA_MOTBLO := ZZ1->ZZ1_MOTEXC
					BCA->BCA_OBS    := "Bloq. Import, arqv:" + AllTrim(ZZ0->ZZ0_NOMARQ) + " Data: " + DTOC(dDataBase)
				ElseIf ZZ1->ZZ1_OPER == "06"
					BCA->BCA_TIPO   := "1"
					BCA->BCA_DATA   := dDataBase
					BCA->BCA_OBS    := "Desbloq. Import, arqv:" + AllTrim(ZZ0->ZZ0_NOMARQ) + " Data: " + DTOC(dDataBase)
				EndIf
				
				**'Marcela Coimbra - Log de data de inclusï¿½o'**
				BCA->BCA_DATLAN := dDataBase
				**'Marcela Coimbra - Log de data de inclusï¿½o'**
				
				//Inicio - Angelo Henrique - Data: 04/05/2017 - Chamado: 37820
				BCA->BCA_HORLAN := TIME()
				//Fim - Angelo Henrique - Data: 04/05/2017 - Chamado: 37820
				
				
				BCA->BCA_MATANT := TRBBA1->BA1_MATANT
				BCA->BCA_BLOFAT := "1"
				BCA->BCA_NIVBLQ := "F"
				BCA->BCA_USUOPE := cUserName
				BCA->(MsUnlock())
				BA1->(MsUnlock())
			EndIf
			TRBBA1->(dbSkip())
		EndDo
		TRBBA1->(dbCloseArea())
		BA1->(dbCloseArea())
	Else
		If empty(BA1->BA1_MOTBLO) .or. empty(BA1->BA1_DATBLO) .or. BA1->BA1_MOTBLO <> ZZ1->ZZ1_MOTEXC
			//BA1->BA1_MOTBLO	:=	iIf(ZZ1->ZZ1_MOTEXC>"",DParaBloq(ZZ1->ZZ1_MOTEXC),"009") // sera lancado valor default Paulo Motta 18/01/07
			
			_lOk := .T. //Angelo Henrique - Data:25/04/2018
			
			//--------------------------------------------------------------------------------------
			//Angelo Henrique - Data: 10/05/2017 - Conforme mudanï¿½a no bloqueio
			//atravï¿½s da RN 412 houve a necessidade de alterar o cï¿½digo do bloqueio
			//neste momento valido qual o cï¿½digo que irï¿½ ser gravado no npivel do usuï¿½rio.
			//--------------------------------------------------------------------------------------
			//If ZZ1->ZZ1_MOTEXC == GETMV("MV_XBQFUSU")MV_XBQFFAM
			If AllTrim(ZZ1->ZZ1_MOTEXC) == AllTrim(GETMV("MV_XBQFFAM"))
				
				If VldMtExc(ALLTRIM(ZZ1->ZZ1_SEQUEN), ALLTRIM(ZZ1->ZZ1_FUNC), ZZ1->ZZ1_DEPEND, ZZ1->ZZ1_CODEMP)
					
					//Angelo Henrique - Se for bloqueio do tï¿½tular nï¿½o ï¿½ criado a tabela BCA (Nivel usuï¿½rio)
					_lOk := .F.
					//_cMotBlq :=	ZZ1->ZZ1_MOTEXC
					
				Else
					
					//----------------------------------------------------------------
					//Pegando o bloqueio no nï¿½vel do usuï¿½rio
					//Neste momento o bloqueio jï¿½ ï¿½ o Final, sem
					//necessitar de passar pelo processo de "Bloqueio Temporï¿½rio"
					//----------------------------------------------------------------
					_cMotBlq :=	GETMV("MV_XBQFUSU")
					
				EndIf
				
			Else
				
				//--------------------------------------------------------
				//INICIO - Angelo Henrique - Data: 10/05/2017
				//--------------------------------------------------------
				
				/*
				
				//---------------------------------------------------------------------
				//INICIO - Angelo Henrique - Data: 06/06/2017
				//Retirado aqui para pegar o motivo de bloqueio que vem no arquivo
				//---------------------------------------------------------------------
				
				If cEmpAnt == '01'
					
					//BA1->BA1_MOTBLO	:= '007' //para convenios sempre como solicitaï¿½ï¿½o de convenio
					_cMotBlq := '007' //para convenios sempre como solicitaï¿½ï¿½o de convenio
					
				Else
					
					//BA1->BA1_MOTBLO	:=	ZZ1->ZZ1_MOTEXC //para Integral, coloque o que for enviado
					_cMotBlq :=	ZZ1->ZZ1_MOTEXC //para Integral, coloque o que for enviado
				EndIf
				
				//---------------------------------------------------------------------
				//FIM - Angelo Henrique - Data: 06/06/2017
				//---------------------------------------------------------------------
				*/
				
				_cMotBlq :=	ZZ1->ZZ1_MOTEXC //para Integral, coloque o que for enviado
				
			EndIf
			
			//--------------------------------------------------------
			//FIM - Angelo Henrique - Data: 10/05/2017
			//--------------------------------------------------------
			
			//--------------------------------------------------------------------------------------
			//Fabio Bianchini - Data: 19/07/2019 - Bloqueio por Portabilidade.  Trataivas semelhantes
			//ï¿½ RN 412.  Houve a necessidade de alterar o cï¿½digo do bloqueio
			//neste momento valido qual o cï¿½digo que irï¿½ ser gravado no nivel do usuï¿½rio.
			//--------------------------------------------------------------------------------------
			If AllTrim(ZZ1->ZZ1_MOTEXC) == AllTrim(GETMV("MV_XBQPOFM"))
				
				If VldMtExc(ALLTRIM(ZZ1->ZZ1_SEQUEN), ALLTRIM(ZZ1->ZZ1_FUNC), ZZ1->ZZ1_DEPEND, ZZ1->ZZ1_CODEMP)
					
					//Angelo Henrique - Se for bloqueio do tï¿½tular nï¿½o ï¿½ criado a tabela BCA (Nivel usuï¿½rio)
					_lOk := .F.
					
				Else
					
					//----------------------------------------------------------------
					//Pegando o bloqueio no nï¿½vel do usuï¿½rio
					//Neste momento o bloqueio jï¿½ ï¿½ o Final, sem
					//necessitar de passar pelo processo de "Bloqueio Temporï¿½rio"
					//----------------------------------------------------------------
					_cMotBlq :=	GETMV("MV_XBQPOUS")
					
				EndIf
				
			Else
				
				_cMotBlq :=	ZZ1->ZZ1_MOTEXC //para Integral, coloque o que for enviado
				
			EndIf
			
			//--------------------------------------------------------
			//FIM - Fabio Bianchini - Data: 19/07/2019
			//--------------------------------------------------------
			
			BA1->BA1_MOTBLO := _cMotBlq //Angelo Henrique - Data: 10/05/2017
			BA1->BA1_DATBLO	:=	iIf(ZZ1->ZZ1_MOTEXC>"",CTOD(REPLACE(ZZ1->ZZ1_DTEXC,'.','/')),"")
			BA1->BA1_IMAGE :=	'DISABLE' // Motta 11/2/07
			BA1->BA1_CONSID := "U"
			BA1->BA1_BLOFAT := "1" // Paulo Motta 20/8/07
			
			If _lOk .Or. ZZ1->ZZ1_OPER == "06"
				
				BCA->(RecLock("BCA",.T.))
				BCA->BCA_FILIAL := xFilial("BCA")
				BCA->BCA_MATRIC := BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC)
				BCA->BCA_TIPREG := BA1->(BA1_TIPREG)
				If ZZ1->ZZ1_OPER == "03"
					BCA->BCA_TIPO   := "0"
					//BCA->BCA_DATA   := BA1->BA1_DATBLO
					//BCA->BCA_MOTBLO := BA1->BA1_MOTBLO
					BCA->BCA_DATA   := iIf(ZZ1->ZZ1_MOTEXC>"",CTOD(REPLACE(ZZ1->ZZ1_DTEXC,'.','/')),"")
					
					//--------------------------------------------------------
					//INICIO - Angelo Henrique - Data: 10/05/2017
					//--------------------------------------------------------
					BCA->BCA_MOTBLO := _cMotBlq
					
					//BCA->BCA_MOTBLO := ZZ1->ZZ1_MOTEXC
					
					//--------------------------------------------------------
					//FIM - Angelo Henrique - Data: 10/05/2017
					//--------------------------------------------------------
					
					BCA->BCA_OBS    := "Bloq. Import, arqv:" + ZZ0->ZZ0_NOMARQ + " Data: " + DTOC(dDataBase)
				ElseIf ZZ1->ZZ1_OPER == "06"
					BCA->BCA_TIPO   := "1"
					BCA->BCA_DATA   := dDataBase
					BCA->BCA_OBS    := "Desbloq. Import, arqv:" + AllTrim(ZZ0->ZZ0_NOMARQ) + " Data: " + DTOC(dDataBase)
				EndIf
				
				**'Marcela Coimbra - Log de data de inclusï¿½o'**
				BCA->BCA_DATLAN := dDataBase
				**'Marcela Coimbra - Log de data de inclusï¿½o'**
				BCA->BCA_HORLAN := TIME() //Fim - Angelo Henrique - Data: 04/05/2017 - Chamado: 37820
				
				BCA->BCA_MATANT := BA1->BA1_MATANT
				BCA->BCA_BLOFAT := "1"
				BCA->BCA_NIVBLQ := "U"
				BCA->BCA_USUOPE := cUserName
				BCA->(MsUnlock())
				
			EndIf
			
		EndIf
	EndIf
		
EndIf
Return



Static Function TrocaStr(cStrP,cStrM,nPos,nTam)
	
	Local cTempE := ""
	Local cTempD := ""
	
	cTempE := Substr(cStrP,1,nPos-1)
	cTempD := Substr(cStrP,nPos+nTam,Len(cStrP)-(nPos+nTam-1))
	
	cStrP := cTempE + Substr(cStrM,1,nTam)  + cTempD
	
Return(cStrP)

/*
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Í»ï¿½ï¿½
ï¿½ï¿½ï¿½Programa  ï¿½GerPreSA1 ï¿½Autor  ï¿½Fabio Bianchini     ï¿½ Data ï¿½  28/08/14   ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Í¹ï¿½ï¿½
ï¿½ï¿½ï¿½Desc.     ï¿½ Inclui Cliente (Art 30 e 31) por EXECAUTO. Esta funcao podeï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½          ï¿½ retornar um Codigo de cliente ou um logico dependendo do   ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½          ï¿½ nTipo passado pelo parametro.							  ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Í¹ï¿½ï¿½
ï¿½ï¿½ï¿½Uso       ï¿½ AP                                                         ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Í¼ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
*/

Static Function GerPreSA1(cCPF,nTipo)
	
	Local aVetSA1 := {}
	
	Private lMsErroAuto := .F.
	//| Abertura do ambiente                                         |
	//PREPARE ENVIRONMENT EMPRESA "99" FILIAL "01" MODULO "FAT" TABLES "SA1"
	
	cTmpCep := iIf(At("-",ZZ1->ZZ1_CEP) > 0,Substr(ZZ1->ZZ1_CEP,1,5)+Substr(ZZ1->ZZ1_CEP,7,3),ZZ1->ZZ1_CEP)
	
	If nTipo == 1
		
		cCodcli := " "
		
		SA1->(dbSetOrder(3))
		If SA1->(dbSeek(xFilial("SA1")+ZZ1->ZZ1_CPF))
			cCodcli := SA1->A1_COD
		Else
			cCodCli := GetSx8Num("SA1","A1_COD")
			
			BC9->(DbSetOrder(1))
			If BC9->(DbSeek(xFilial("BC9")+cTmpCep))
				
				aAdd(aVetSA1, {"A1_COD"		,cCodCli           		,Nil})
				aAdd(aVetSA1, {"A1_LOJA"	,"01"    				,Nil})
				aAdd(aVetSA1, {"A1_NOME" 	,UPPER(ZZ1->ZZ1_BENEF)	,Nil})
				aAdd(aVetSA1, {"A1_PESSOA" 	,"F"					,Nil})
				aAdd(aVetSA1, {"A1_NREDUZ" 	,UPPER(SUBSTR(ZZ1->ZZ1_BENEF,1,20))	,Nil})
				aAdd(aVetSA1, {"A1_CGC" 	,ZZ1->ZZ1_CPF			,Nil})
				aAdd(aVetSA1, {"A1_TIPO" 	,"F"					,Nil})
				aAdd(aVetSA1, {"A1_END"    	,UPPER(TRIM(BC9->BC9_END))+" "+ZZ1->ZZ1_NUMERO+" "+UPPER(ZZ1->ZZ1_COMPLE),Nil})
				aAdd(aVetSA1, {"A1_MUN"  	,UPPER(BC9->BC9_MUN)	,Nil})
				aAdd(aVetSA1, {"A1_EST"		,UPPER(BC9->BC9_EST)	,Nil})
				aAdd(aVetSA1, {"A1_BAIRRO"	,UPPER(BC9->BC9_BAIRRO)	,Nil})
				aAdd(aVetSA1, {"A1_CEP"		,cTmpCep				,Nil})
				aAdd(aVetSA1, {"A1_DDD"  	,TRIM(ZZ1->ZZ1_DDDRES)	,Nil})
				aAdd(aVetSA1, {"A1_TEL"		,TRIM(ZZ1->ZZ1_TELRES)	,Nil})
				aAdd(aVetSA1, {"A1_ENDCOB"	,UPPER(TRIM(BC9->BC9_END))+" "+ZZ1->ZZ1_NUMERO+" "+UPPER(ZZ1->ZZ1_COMPLE),Nil})
				aAdd(aVetSA1, {"A1_BAIRROC"	,UPPER(BC9->BC9_BAIRRO)	,Nil})
				aAdd(aVetSA1, {"A1_CEPC"	,cTmpCep				,Nil})
				aAdd(aVetSA1, {"A1_MUNC"	,UPPER(BC9->BC9_MUN)	,Nil})
				aAdd(aVetSA1, {"A1_ESTC"	,UPPER(BC9->BC9_EST)	,Nil})
				
			Else
				
				aAdd(aVetSA1, {"A1_COD"  	,cCodCli           		,Nil})
				aAdd(aVetSA1, {"A1_LOJA"	,"01"               	,Nil})
				aAdd(aVetSA1, {"A1_NOME"	,UPPER(ZZ1->ZZ1_BENEF)	,Nil})
				aAdd(aVetSA1, {"A1_PESSOA" 	,"F"					,Nil})
				aAdd(aVetSA1, {"A1_NREDUZ"	,UPPER(SUBSTR(ZZ1->ZZ1_BENEF,1,20))	,Nil})
				aAdd(aVetSA1, {"A1_CGC" 	,ZZ1->ZZ1_CPF			,Nil})
				aAdd(aVetSA1, {"A1_TIPO" 	,"F"					,Nil})
				aAdd(aVetSA1, {"A1_END"		,UPPER(TRIM(ZZ1->ZZ1_LOGRAD))+" "+ZZ1->ZZ1_NUMERO+" "+UPPER(ZZ1->ZZ1_COMPLE),Nil})
				aAdd(aVetSA1, {"A1_MUN"		,UPPER(ZZ1->ZZ1_CIDADE)	,Nil})
				aAdd(aVetSA1, {"A1_EST"		,UPPER(ZZ1->ZZ1_UF)		,Nil})
				aAdd(aVetSA1, {"A1_BAIRRO"	,UPPER(ZZ1->ZZ1_BAIRRO)	,Nil})
				aAdd(aVetSA1, {"A1_CEP"		,ZZ1->ZZ1_CEP			,Nil})
				aAdd(aVetSA1, {"A1_DDD"		,TRIM(ZZ1->ZZ1_DDDRES)	,Nil})
				aAdd(aVetSA1, {"A1_TEL"		,TRIM(ZZ1->ZZ1_TELRES)	,Nil})
				aAdd(aVetSA1, {"A1_ENDCOB"	,UPPER(TRIM(ZZ1->ZZ1_LOGRAD))+" "+ZZ1->ZZ1_NUMERO+" "+UPPER(ZZ1->ZZ1_COMPLE)  ,Nil})
				aAdd(aVetSA1, {"A1_BAIRROC"	,UPPER(ZZ1->ZZ1_BAIRRO)	,Nil})
				aAdd(aVetSA1, {"A1_CEPC"	,ZZ1->ZZ1_CEP			,Nil})
				aAdd(aVetSA1, {"A1_MUNC"	,UPPER(ZZ1->ZZ1_CIDADE)	,Nil})
				aAdd(aVetSA1, {"A1_ESTC"	,UPPER(ZZ1->ZZ1_UF)    	,Nil})
				
			EndIf
			
			MSExecAuto({|x,y| Mata030(x,y)},aVetSA1,3)
			
			If lMsErroAuto
				MostraErro()
			Else
				ConfirmSX8()
			EndIf
		EndIf
	EndIf
	
	If nTipo == 2
		
		cCodcli := .F.
		
		SA1->(dbSetOrder(3))
		If SA1->(dbSeek(xFilial("SA1")+ZZ1->ZZ1_CPF))
			cCodcli := .T.
		EndIf
	EndIf
	
Return cCodCli


/*
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Í»ï¿½ï¿½
ï¿½ï¿½ï¿½Programa  |AtualizaFamCob ï¿½Autor  ï¿½Fabio Bianchini     ï¿½ Data ï¿½  28/08/14   ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Í¹ï¿½ï¿½
ï¿½ï¿½ï¿½Desc.     ï¿½ Atualiza Familia e Usuario Apos criacao do cliente              ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½          ï¿½ Nos casos de Art 30 e 31                            		       ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Í¹ï¿½ï¿½
ï¿½ï¿½ï¿½Uso       ï¿½ AP                                                        	   ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Í¼ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
*/
Static Function AtualizaFamCob (cCodOpe,cFunc)
	
	Local _aAreBA3 := BA3->(GetArea()) //Angelo Henrique - Data: 09/06/2017
	
	BA3->(DbSetOrder(5))
	
	If BA3->(DbSeek(xFilial("BA3")+cCodOpe+cFunc))
		BA3->(RecLock("BA3",.F.))
		BA3->BA3_COBNIV := '1'
		BA3->BA3_VENCTO := '10'
		BA3->BA3_CODCLI := cCodcli
		BA3->BA3_NATURE := '30'
		BA3->BA3_TIPPAG := '04'
		BA3->(MsUnlock())
	EndIf
	
	RestArea(_aAreBA3)  //Angelo Henrique - Data: 09/06/2017
	
Return


/*/
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ä¿ï¿½ï¿½
ï¿½ï¿½ï¿½Funï¿½ï¿½o	 ï¿½ChkPIS 	ï¿½ Autor ï¿½ Marcos A. Stiefano	ï¿½ Data ï¿½ 29.06.95 ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ä´ï¿½ï¿½
ï¿½ï¿½ï¿½Descriï¿½ï¿½o ï¿½ Verifica PIS												  ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ä´ï¿½ï¿½
ï¿½ï¿½ï¿½ Uso		 ï¿½ Generico 												  ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ù±ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½/*/

Static Function ChkPIS(cPIS)
	
	Local nPis01 := nPis02 := nPis03 := nPis04 := nPis05 := 0
	Local nPis06 := nPis07 := nPis08 := nPis09 := nPis10 := nPis11 := 0
	Local nXpis  := nYpis  := nKpis	:= 0
	Local nPis	 := 0
	
	nPis01 := Val(SubStr(cPIS,01,01))
	nPis02 := Val(SubStr(cPIS,02,01))
	nPis03 := Val(SubStr(cPIS,03,01))
	nPis04 := Val(SubStr(cPIS,04,01))
	nPis05 := Val(SubStr(cPIS,05,01))
	nPis06 := Val(SubStr(cPIS,06,01))
	nPis07 := Val(SubStr(cPIS,07,01))
	nPis08 := Val(SubStr(cPIS,08,01))
	nPis09 := Val(SubStr(cPIS,09,01))
	nPis10 := Val(SubStr(cPIS,10,01))
	nPis11 := Val(SubStr(cPIS,11,01))
	
	nXpis := (nPis01 * 3) + (nPis02 * 2) + (nPis03 * 9) + (nPis04 * 8) + (nPis05 * 7)
	nXpis += (nPis06 * 6) + (nPis07 * 5) + (nPis08 * 4) + (nPis09 * 3) + (nPis10 * 2)
	nYpis := (nXpis * 10)
	nKpis := Mod(nYpis,11)
	
	nPis	:= nPis01+nPis02+nPis03+nPis04+nPis05+nPis06+nPis07+nPis08+nPis09+nPis10+nPis11
	
	If nKpis >= 10
		nKpis := 0
	EndIf
	
	If nKpis # nPis11 .Or. Len(AllTrim(cPis)) < 11
		Return (.F.)
	EndIf
	
	If nPis = 0
		Return (.F.)
	EndIf
	
Return ( .T. )


/*/
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ä¿ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½Funcao    ï¿½   IMPLGER  ï¿½ Autor ï¿½ Antonio de Padua    ï¿½ Data ï¿½ 28.08.03 ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ä´ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½Descricao ï¿½ Mostra Composicao do Log de Erros                          ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ù±ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
/*/

User Function IMPLGER()
	
	Local cFil := 	"ZZ2_FILIAL = '" + xFilial("ZZ2") + "' .AND. ZZ2_SEQUEN = '" + ZZ0->ZZ0_SEQUEN +;
		"' .AND. ZZ2_NUMLIN = '" + ZZ1->ZZ1_NUMLIN + "'"
	
	Private aRotina   	:=	{	{ "Pesquisar"	, 'AxPesqui'	  , 0 , K_Pesquisar  },;
		{ "Visualizar"	, 'AxVisual'	  , 0 , K_Visualizar }}
	
	DbSelectArea("ZZ2")
	DBSetOrder(1)
	
	SET FILTER TO &cFil
	
	mBrowse(006,001,022,075,"ZZ2" ,nil ,nil ,nil ,nil , 4    , ,nil ,nil ,nil ,,.T.,nil)
	
Return


/*/
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ä¿ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½Funcao    ï¿½ VEROPE   ï¿½ Autor ï¿½ Antonio de Padua    ï¿½ Data ï¿½ 28.08.03 ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ä´ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½Descricao ï¿½ Verifica a Operacao do Sistema que ira executar            ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ù±ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
01-	Inclusï¿½o normal
02-	Inclusï¿½o retroativa
03-	Alteraï¿½ï¿½o cadastral normal
04-	Alteraï¿½ï¿½o do tipo de usuï¿½rio
05-	Alteraï¿½ï¿½o da data de nascimento
06-	Alteraï¿½ï¿½o de plano
07-	Exclusï¿½o normal
08-	Exclusï¿½o retroativa
09-	Exclusï¿½o posterior / Futura
10-	Troca de empresas/sub-contratos
11-	Reativaï¿½ï¿½o do usuï¿½rio
/*/

User Function VEROPE()
	
	Local _aAreaBA1 := BA1->(GetArea()) //Angelo Henrique - Data:09/06/2017
	
	Local cTipo := ""
	If ZZ1->ZZ1_OPER == "01"
		If ctod(ZZ1->ZZ1_DTINPD) < dDatabase
			cTipo := "02"
		Else
			cTipo := "01"
		EndIf
	ElseIf ZZ1->ZZ1_OPER == "02"
		nRecno := BA1->(Recno())
		nOrder := BA1->(IndexOrd())
		//BA1->(dbSetOrder(20))
		BA1->(dbOrderNickName("BA1MATEMP"))
		If BA1->(dbSeek(xFilial("BA1")+ZZ1->ZZ1_CODEMP+AllTrim(ZZ1->ZZ1_FUNC)+ZZ1->ZZ1_DEPEND))
			If BA1->BA1_TIPUSU <> DPTipoBnfbd(ZZ1->ZZ1_CDBENE) // PAULO MOTTA 20/09/06
				cTipo := "04"
			ElseIf BA1->BA1_DATNAS <> CTOD(ZZ1->ZZ1_DTNASC)
				cTipo := "05"
			Else
				cTipo := "03"
			EndIf
		EndIf
		BA1->(dbSetOrder(nOrder))
		BA1->(DbGoto(nRecno))
	ElseIf ZZ1->ZZ1_OPER == "03"
		If ctod(ZZ1->ZZ1_DTEXC) < dDatabase
			cTipo := "08"
		ElseIf ctod(ZZ1->ZZ1_DTEXC) == dDatabase
			cTipo := "07"
		Else
			cTipo := "09"
		EndIf
	ElseIf ZZ1->ZZ1_OPER == "04"
		cTipo := "10"
	ElseIf ZZ1->ZZ1_OPER == "05"
		cTipo := "06"
	ElseIf ZZ1->ZZ1_OPER == "06"
		cTipo := "11"
	EndIf
	
	RestArea(_aAreaBA1) //Angelo Henrique - Data:09/06/2017
	
Return(cTipo)


/*
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Í»ï¿½ï¿½
ï¿½ï¿½ï¿½Programa  ï¿½LIMPALIN  ï¿½Autor  ï¿½Microsiga           ï¿½ Data ï¿½  15/02/07   ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½          ï¿½          ï¿½Motta  ï¿½                    ï¿½      ï¿½             ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Í¹ï¿½ï¿½
ï¿½ï¿½ï¿½Desc.     ï¿½ Retorna a string limpa de alguns caracters                 ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½          ï¿½                                                            ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Í¹ï¿½ï¿½
ï¿½ï¿½ï¿½Uso       ï¿½ AP                                                         ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Í¼ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
*/

Static Function LIMPALIN(cLinha)
	
Return (StrTran(cLinha,"'"," "))


/*
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Í»ï¿½ï¿½
ï¿½ï¿½ï¿½Programa  ï¿½CopiaReg  ï¿½Autor  ï¿½Microsiga           ï¿½ Data ï¿½  13/04/07   ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Í¹ï¿½ï¿½
ï¿½ï¿½ï¿½Desc.     ï¿½Copia registro da tabela repassada por parametro, cria um   ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½          ï¿½novo registro na tabela identico (bloqueado) e mantem o     ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½          ï¿½posicionamento anterior ao processo.                        ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Í¹ï¿½ï¿½
ï¿½ï¿½ï¿½Uso       ï¿½ MP8                                                        ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Í¼ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
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
	
	//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ä¿
	//ï¿½ Carga dos campos do registro posicionado na tabela desejada.        ï¿½
	//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
	For nCont := 1 to Len(aStru)
		If aStru[nCont,2] $ "C,N,D"
			aAdd(aCampos,{cTabela+"->"+aStru[nCont,1],aStru[nCont,2],&(cTabela+"->"+aStru[nCont,1])}) //aCampos[X,Y,Z]  = X = Nome Campo, Y = Tipo, Z=Conteudo campo
		EndIf
	Next
	
	//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ä¿
	//ï¿½ Inicio da transacao de controle                                     ï¿½
	//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
	Begin Transaction
		
		//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ä¿
		//ï¿½ Cria novo registro na tabela, conforme dados obtidos previamente.   ï¿½
		//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
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
		cInstruc := cTabela+'->'+cTabela+'_DATBLO := CtoD("'+DtoC(dDataBase)+'" ) '       //ctod(ZZ1->ZZ1_DTADMI)
		&cInstruc
		cInstruc := cTabela+'->'+cTabela+'_MOTBLO := "'+GetNewPar("MV_YMTBLTI","006")+'" '
		&cInstruc
		cInstruc := cTabela+'->'+cTabela+'_IMPORT := "HISTITAU" '
		&cInstruc
		
		If cTabela == "BA1"
			cInstruc := cTabela+'->'+cTabela+'_IMAGE := "DISABLE" '
			&cInstruc
			aRet[2] := BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG+BA1_DIGITO)
		EndIf
		&(cTabela+'->(MsUnlock())')
		
		
		aRet[1] := &(cTabela+'->(Recno())')
		
		
		If cTabela == "BA1"
			
			BCA->(Reclock("BCA",.T.))
			BCA->BCA_FILIAL := xFilial("BCA")
			BCA->BCA_MATRIC := BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC)
			BCA->BCA_TIPREG := BA1->BA1_TIPREG
			BCA->BCA_TIPO   := "0"
			BCA->BCA_DATA   := BA1->BA1_DATBLO
			BCA->BCA_MOTBLO := BA1->BA1_MOTBLO
			BCA->BCA_OBS    := "Historico de transferencia"
			BCA->BCA_MATANT := BA1->BA1_MATANT
			BCA->BCA_BLOFAT := "1"
			BCA->BCA_NIVBLQ := "U"
			BCA->BCA_USUOPE := cUserName
			BCA->(MsUnlock())
			
		EndIf
		
	End Transaction
	
	RestArea(aAreaBA1)
	RestArea(aAreaBA3)
	RestArea(aAreaBCA)
	
Return aRet


/*
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ä¿ï¿½ï¿½
ï¿½ï¿½ï¿½Programa  ï¿½   IMPEXP   ï¿½ Autor ï¿½ Motta             ï¿½ Data ï¿½ 27.0702007 ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ä´ï¿½ï¿½
ï¿½ï¿½ï¿½Descriï¿½ï¿½o ï¿½ Exporta Arquivo Criticado                                  ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ù±ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
*/
User Function IMPEXP(cAlias,nReg,nOpc)
	
	Local cNomeArq	:= ""
	Local cPath := GetNewPar("MV_YEXBIT","M:\Protheus_Data\interface\exporta\itaubenef")
	Local cCpo		:= ""
	Local cLin := Space(1)+CHR(13)+CHR(10)
	Local nReg  := 0
	Local lGrav := .F.
	Private nHdl
	
	cNomeArq := cPath+"\R_"+AllTrim(ZZ0->ZZ0_NOMARQ)
	
	If ZZ0->ZZ0_STATUS $ "4|5"
		cSql := "SELECT * FROM "+RetSqlName("ZZ1")+" Where ZZ1_SEQUEN = '"+ZZ0->ZZ0_SEQUEN+"'"
		cSql += " AND D_E_L_E_T_ = ' '"
		PLsQuery(cSql,"TMPZZ1")
		If !TMPZZ1->(EOF())
			If U_Cria_TXT(cNomeArq)
				// header
				cCpo := '01'
				cCpo += ZZ0->ZZ0_CTREMP
				cCpo += iIf(ZZ0->ZZ0_CTREMP == '01115','04697','04705')//FILIAL
				cCpo += 'CABERJ'+Replicate(' ',44)
				cCpo += '42182170000184'//CGC
				cCpo +=  Replicate(' ',10)//SAP
				cCpo +=  '0'
				cCpo +=  ZZ0->ZZ0_SEQARQ
				cCpo += '001'//versao
				cCpo += Substr(DToC(dDatabase),1,2)+'.'+Substr(DToC(dDatabase),4,2)+'.'+Substr(DToC(dDatabase),7,4)
				cCpo += StrTran(Time(),':','')
				cCpo += Space(888)
				If !(U_GrLinha_TXT(cCpo,cLin))
					MsgAlert("ATENï¿½ï¿½O! Nï¿½O FOI POSSï¿½VEL GRAVAR CORRETAMENTE A LINHA ATUAL! OPERAï¿½ï¿½O ABORTADA!")
					Return
				EndIf
				// detalhe
				While !TMPZZ1->(EOF())
					cCpo := '10'
					cCpo += TMPZZ1->ZZ1_OPER
					cCpo += AllTrim(TMPZZ1->ZZ1_FUNC)
					cCpo += TMPZZ1->ZZ1_DEPEND
					cCpo += TMPZZ1->ZZ1_BENEF
					cCpo += TMPZZ1->ZZ1_IDGPF
					cCpo += TMPZZ1->ZZ1_IDCONV
					cCpo += TMPZZ1->ZZ1_IDDEP
					cCpo += TMPZZ1->ZZ1_DTNASC
					cCpo += TMPZZ1->ZZ1_UFNASC
					cCpo += TMPZZ1->ZZ1_TPDOC
					cCpo += TMPZZ1->ZZ1_NRODOC
					cCpo += TMPZZ1->ZZ1_TPPARE
					cCpo += TMPZZ1->ZZ1_TPBENE
					cCpo += TMPZZ1->ZZ1_CDBENE
					cCpo += TMPZZ1->ZZ1_SEXO
					cCpo += TMPZZ1->ZZ1_ESTCIV
					cCpo += TMPZZ1->ZZ1_CPF
					cCpo += TMPZZ1->ZZ1_PIS
					cCpo += TMPZZ1->ZZ1_BANCO
					cCpo += TMPZZ1->ZZ1_AGENC
					cCpo += TMPZZ1->ZZ1_NUMCC
					cCpo += TMPZZ1->ZZ1_DTADMI
					cCpo += TMPZZ1->ZZ1_DTDESL
					cCpo += TMPZZ1->ZZ1_NOMMAE
					cCpo += TMPZZ1->ZZ1_CONTR
					cCpo += TMPZZ1->ZZ1_DTINCT
					cCpo += TMPZZ1->ZZ1_FILIT
					cCpo += TMPZZ1->ZZ1_PADRAO
					cCpo += TMPZZ1->ZZ1_DTINPD
					cCpo += TMPZZ1->ZZ1_DTFIPD
					cCpo += TMPZZ1->ZZ1_DTBASE
					cCpo += TMPZZ1->ZZ1_CODEMP
					cCpo += TMPZZ1->ZZ1_NOMEMP
					cCpo += TMPZZ1->ZZ1_CODLOT
					cCpo += TMPZZ1->ZZ1_ORGAO
					cCpo += TMPZZ1->ZZ1_UFLOT
					cCpo += TMPZZ1->ZZ1_CDUNI
					cCpo += TMPZZ1->ZZ1_DTEXC
					cCpo += TMPZZ1->ZZ1_MOTEXC
					cCpo += TMPZZ1->ZZ1_DTINCO
					cCpo += TMPZZ1->ZZ1_INDENV
					cCpo += TMPZZ1->ZZ1_LOGRAD
					cCpo += TMPZZ1->ZZ1_NUMERO
					cCpo += TMPZZ1->ZZ1_COMPLE
					cCpo += TMPZZ1->ZZ1_BAIRRO
					cCpo += TMPZZ1->ZZ1_CEP
					cCpo += TMPZZ1->ZZ1_CIDADE
					cCpo += TMPZZ1->ZZ1_UF
					cCpo += TMPZZ1->ZZ1_DDDRES
					cCpo += TMPZZ1->ZZ1_TELRES
					cCpo += TMPZZ1->ZZ1_DDDCOM
					cCpo += TMPZZ1->ZZ1_TELCOM
					cCpo += TMPZZ1->ZZ1_RAMAL
					cCpo += TMPZZ1->ZZ1_DDDCEL
					cCpo += TMPZZ1->ZZ1_TELCEL
					cCpo += TMPZZ1->ZZ1_EMAIL
					cCpo += TMPZZ1->ZZ1_FUNANT
					cCpo += Space(46)
					cCpo += TMPZZ1->ZZ1_INDCAR
					cCpo += TMPZZ1->ZZ1_INDTRA
					cCpo += TMPZZ1->ZZ1_DTTRAN
					cCpo += space(95)
					cCpo += iIf(Empty(AllTrim(TMPZZ1->ZZ1_TABERR)),"S","E")
					cCpo += TMPZZ1->ZZ1_SEQREG
					cCpo += space(41)
					cCpo += TMPZZ1->ZZ1_TABERR
					//cCpo += TMPZZ1->ZZ1_OPEORI
					nReg += 1
					If !(U_GrLinha_TXT(cCpo,cLin))
						MsgAlert("ATENï¿½ï¿½O! Nï¿½O FOI POSSï¿½VEL GRAVAR CORRETAMENTE A LINHA ATUAL! OPERAï¿½ï¿½O ABORTADA!")
						Return
					EndIf
					TMPZZ1->(DbSkip())
				EndDo
				// trailler
				cCpo := '99'
				cCpo += ZZ0->ZZ0_CTREMP
				cCpo += iIf(ZZ0->ZZ0_CTREMP == '01115','04697','04705')//FILIAL
				cCpo += str(nReg,9)
				cCpo += Space(979)
				If !(U_GrLinha_TXT(cCpo,cLin))
					MsgAlert("ATENï¿½ï¿½O! Nï¿½O FOI POSSï¿½VEL GRAVAR CORRETAMENTE A LINHA ATUAL! OPERAï¿½ï¿½O ABORTADA!")
					Return
				EndIf
				U_Fecha_TXT()
				lGrav := .T.
			EndIf
		EndIf
		TMPZZ1->(DbCloseArea())
		//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ä¿
		//ï¿½ Mudo o status do arquivo colocando como exportado no BD               ï¿½
		//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
		If lGrav == .T.
			ZZ0->(RecLock("ZZ0",.F.))
			ZZ0->ZZ0_STATUS := "6"
			ZZ0->ZZ0_DTINSB := dDatabase
			ZZ0->(MsUnlock())
			MsgAlert("Arquivo gravado com sucesso!!")
		EndIf
	Else
		MsgInfo("Somente e possivel inserir no BD arquivos com status inserido bd!")
	EndIf
	//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ä¿
	//ï¿½ Fim da Rotina...                                                    ï¿½
	//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
Return


/*
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ä¿ï¿½ï¿½
ï¿½ï¿½ï¿½Programa  ï¿½   IMPREL   ï¿½ Autor ï¿½ Motta             ï¿½ Data ï¿½ 27.0702007 ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ä´ï¿½ï¿½
ï¿½ï¿½ï¿½Descriï¿½ï¿½o ï¿½ Imprime rel. Arquivo                                       ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ù±ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
*/

User Function IMPREL(cAlias,nReg,nOpc)
	
	Alert("Funcao nao disponivel !!")
	
	//Private cCRPar:="1;0;1;RESUMO DE IMPORTACAO DO ARQUIVO ITAU"
	/*Conjunto de opï¿½ï¿½es para nao mostrar a tela da SetPrint, composta por x;y;z;w, onde
	x = vï¿½deo(1) ou impressora(3)
	y = Atualiza(0) ou nï¿½o(1) os dados
	z = Nï¿½mero de cï¿½pias
	w = Tï¿½tulo do relatorio.
	*/
	
	//If ZZ0->ZZ0_STATUS >= "3"
	//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ä¿
	//ï¿½ CHAMADA DO RELATORIO - PASSANDO O PARAMETRO DO REL.                   ï¿½
	//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
	//  CallCrys("RESITA",ZZ0->ZZ0_NOMARQ,cCRPar)
	//Else
	//  MsgInfo("Somente e possivel imprimir rel. de arquivos com status inserido bd!")
	//EndIf
	//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ä¿
	//ï¿½ Fim da Rotina...                                                    ï¿½
	//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
Return


/*/
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ä¿ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½Funcao    ï¿½ ChkMae     ï¿½ Autor ï¿½ Luzio Tavares     ï¿½ Data ï¿½ 12.12.2008 ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ä´ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½Descricao ï¿½ Checa para ver se o nome da mae eh obrigatorio ou nao se seï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½          ï¿½ causa rejeicao da operacao a ser realziada no registro     ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ù±ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
/*/

Static Function chkMae(cNomMae,cMatric)
	
	Local _aAreBA1 := BA1->(GetArea())  //Angelo Henrique - Data: 09/06/2017
	
	If !Empty(AllTrim(cNomMae)) .and. cNomMae != NIL
		Return(.T.)
	Else
		If !(AllTrim(ZZ1->ZZ1_OPER) == "03")   //fatal. E necessario o nome da mae
			Return(.F.)
		Else
			BA1->(dbSetOrder(6))
			If BA1->(dbSeek(xFilial("BA1")+cMatric)) .and. !Empty(BA1->BA1_MAE)
				Return(.T.)
			Else
				Return(.F.)
			EndIf
		EndIf
	EndIf
	
	RestArea(_aAreBA1) //Angelo Henrique - Data: 09/06/2017
	
Return(.T.)


/*/
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ä¿ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½Funcao    ï¿½ lExisteBA3 ï¿½ Autor ï¿½ Luzio Tavares       ï¿½ Data ï¿½ 16.01.09 ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ä´ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½Descricao ï¿½ Verifica se a funcional esta cadastra no BA3               ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ù±ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
/*/

Static Function lExisteBA3(cMatric)
	
	Local nOrdBA3 := BA3->(IndexOrd())
	Local lRet    := .F.
	
	BA3->(DbSetOrder(5))
	lRet := BA3->(dbSeek(xFilial("BA3")+ZZ0->ZZ0_CODEMP+cMatric))
	
	BA3->(DbSetOrder(nOrdBA3))
	
Return(lRet)


/*/
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ä¿ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½Funcao    ï¿½ lVerBA1     ï¿½ Autor ï¿½ Luzio Tavares       ï¿½ Data ï¿½ 01.12.08 ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ä´ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½Descricao ï¿½ Verifica a existencia do beneficiario no BA1 atraves da    ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½          ï¿½ Matricula Funcional+Dependencia Itau                       ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ù±ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
/*/

Static Function lVerBA1(cMatric,cOper)
	
	Local nOrdBA1 := BA1->(IndexOrd())
	Local lRet    := .T.
	
	BA1->(DbSetOrder(6))
	lRet := BA1->(DbSeek(xFilial("ZZ1")+cMatric))
	
	BA1->(DbSetOrder(nOrdBA1))
	
Return lRet


/*/
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ä¿ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½Funcao    ï¿½ lExisteBA1     ï¿½ Autor ï¿½ Luzio Tavares   ï¿½ Data ï¿½ 01.12.08 ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ä´ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½Descricao ï¿½ Verifica a existencia do beneficiario no BA1 atraves da    ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½          ï¿½ Matricula Funcional+Dependencia Itau                       ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ù±ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
/*/

Static Function lExisteBA1(cMatric,cOper)
	
	Local lRet    := .F.
	
	BA1->(DbOrderNickName("BA1EMCOSUB"))
	
	If BA1->(DbSeek(xFilial("BA1")+ZZ1->ZZ1_CODEMP+ZZ0->ZZ0_NUMCON+cVerCon+ZZ0->ZZ0_SUBCON+cVerSub+cMatric))
		
		**'Marcela Coimbra - Inico - 04/07/2017'**
		
		While !BA1->(EOF()) .and. ( ZZ1->ZZ1_CODEMP+ZZ0->ZZ0_NUMCON+cVerCon+ZZ0->ZZ0_SUBCON+cVerSub+cMatric == AllTrim(BA1->(BA1_CODEMP+BA1_CONEMP+BA1_VERCON+BA1_SUBCON+BA1_VERSUB+BA1_MATEMP)))
			//While !BA1->(EOF()) .and. ( ZZ1->(ZZ1_FUNC+ZZ1_DEPEND) == AllTrim(BA1->BA1_MATEMP) )
			
			**'Marcela Coimbra - Fim - 04/07/2017'**
			
			If ( Empty(BA1->BA1_DATBLO) .or. Empty(BA1->BA1_MOTBLO) )
				lRet := .T.
				Exit
			EndIf
			
			BA1->(DbSkip())
			
		EndDo
		
	EndIf
	
Return lRet


/*/
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ä¿ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½Funcao    ï¿½ lExisteBA1HIS  ï¿½ Autor ï¿½ Fabio Bianchini     ï¿½ Data ï¿½ 01.12.08 ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ä´ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½Descricao ï¿½ Verifica se em algum momento a FUNCIONAL + DEPEND(Futuro	  ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½          ï¿½ TIPREG) ja foi utilizado.  Ocorreram casos em que pessoas  ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½          ï¿½ DIferentes foram informadas com a mesma funcional e TIPREG ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ù±ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
/*/

Static Function lExisteHIS(cMatric,cOper)
	
	Local lRet    	:= .F.
	Local _aArBA1	:= BA1->(GetArea()) //Angelo Henrique - Data: 09/06/2017
	
	BA1->(dbOrderNickName("BA1EMCOSUB"))
	
	If BA1->(dbSeek(xFilial("BA1")+ZZ1->ZZ1_CODEMP+ZZ0->ZZ0_NUMCON+cVerCon+ZZ0->ZZ0_SUBCON+cVerSub+cMatric))
		If !BA1->(EOF()) .and. EMPTY(BA1->BA1_DATBLO)
			lRet := .T.
		EndIf
	EndIf
	
	RestArea(_aArBA1)
	
Return(lRet)


/*/
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ä¿ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½Funcao    ï¿½ ChkBanco   ï¿½ Autor ï¿½ Antonio de Padua    ï¿½ Data ï¿½ 16.05.06 ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ä´ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½Descricao ï¿½ Checa o banco olhando no cadastro                          ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ù±ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
/*/
Static Function chkBanco(cBanco,nTipo)
	// Aceitando Sempre True por causa do Itau
Return(.T.)


/*/
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ä¿ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½Funcao    ï¿½ ChkCidade  ï¿½ Autor ï¿½ Antonio de Padua    ï¿½ Data ï¿½ 17.05.06 ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ä´ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½Descricao ï¿½ Checa a Cidade olhando no cadastro                         ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ù±ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
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
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ä¿ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½Funcao    ï¿½ ChkPadrao  ï¿½ Autor ï¿½ Antonio de Padua    ï¿½ Data ï¿½ 17.05.06 ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ä´ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½Descricao ï¿½ Verifica qual produto saude ira alocar para o beneficiario ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ù±ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
/*/

Static Function chkPadrao(cPadrao,cOper,cMatric,cCdDepe,cTpBnf)
	
	Local lDIferente := .F.
	Local nOrdBA1 := BA1->(IndexOrd())
	Local lRet := .T.
	
	cTempPadrao := ""
	
	If Empty(AllTrim(cPadrao))
		Return(.F.)
	EndIf
	If AllTrim(cOper) == "03"
		Return(.T.)
	EndIf
	If Empty(AllTrim(cMatric))
		Return(.F.)
	EndIf
	
	If ZZ0->ZZ0_CODEMP == "0006"  // Itau
		If ! (cPadrao $ "0109_0208_0307_0406")
			Return (.F.)
		EndIf
	Else
		//tornar genï¿½rica
		cSql := "SELECT DISTINCT BT6_CODPRO
		cSql += " FROM  "+RetSqlName("BT6")+" BT6 "
		cSql += " WHERE D_E_L_E_T_=' '
		cSql += " AND BT6_CODINT='"+ZZ0->ZZ0_CODOPE+"'"
		cSql += " AND BT6_NUMCON='"+ZZ0->ZZ0_NUMCON+"'"
		cSql += " AND BT6_VERCON='"+cVerCon+"'"
		cSql += " AND BT6_SUBCON='"+ZZ0->ZZ0_SUBCON+"'"
		cSql += " AND BT6_VERSUB='"+cVerSub+"'"
		cSql += " AND BT6_CODIGO='"+ZZ0->ZZ0_CODEMP+"'"
		PLsQuery(cSql,"TMPBT6")
		
		If !TMPBT6->(EOF())
			While !TMPBT6->(EOF())
				cTempPadrao := cTempPadrao + TMPBT6->BT6_CODPRO + "_"
				TMPBT6->(DbSkip())
			EndDo
		EndIf
		cTempPadrao := Substr(cTempPadrao,1,Len(cTempPadrao)-1)
		TMPBT6->(DbCloseArea())
		
		If !(cPadrao $ cTempPadrao)  // Se nao encontrou o produto para o referido grupo empresa
			Return (.F.)
		EndIf
	EndIf
	
	//BIANCHINI - 23/07/2019 - Bypass da verificaï¿½ï¿½o, porque os usuarios poderao ter planos diferentes dentro da familia
	//            Tratamento para permitir Que a empresa CASA DA MOEDA (CMB) use planos diferentes entre os usuarios(BA1)
	If (cEmpAnt == "02") .and. (ZZ0->ZZ0_CODEMP == '0325')
		Return (.T.)
	Else
		//Busca o produto na familia
		//Somente quando for operacao dIferente de inclusao ou transferencia
		//Deve Verificar somente para os caso de inclusao, transferencia entre planos, trasnferencia entre operadoras, mas somente para dependentes.
		If !(AllTrim(cOper) $ "01")   //.and. ZZ1->ZZ1_CDBENE != "A"
			BA3->(dbSetOrder(5))
			If BA3->(dbSeek(xFilial("BA3")+ZZ0->ZZ0_CODEMP+cMatric))
				While !BA3->(Eof()) .and. BA3->(BA3_FILIAL+BA3_CODEMP+BA3_CODEMP) == xFilial("BA3")+ZZ0->ZZ0_CODEMP+cMatric
					If Empty(BA3->BA3_DATBLO)
						If BA3->BA3_CODPLA <> dParaPrd(cPadrao,cTpBnf)
							lRet := .F.
						Else
							lRet := .T.
						EndIf
					EndIf
					BA3->(DbSkip())
				EndDo
			EndIf
		EndIf
	Endif
	
Return(lRet)


/*/
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ä¿ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½Funcao    ï¿½ ChkZZ1QtdCPF ï¿½ Autor ï¿½ Fabio Bianchini   ï¿½ Data ï¿½ 17.05.06 ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ä´ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½Descricao ï¿½ Checa em ZZ1 se exist emais de uma ocorrencia do mesmo CPF ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ù±ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
/*/

Static Function ChkZZ1QtdCPF(cOper,cSequen,cCPF,cOpcao)
	
	Local lRet := .F.
	
	/*******************************************************************************/
	/***	cOper : 1 - Inclusao / 2 - Aleterï¿½ï¿½o / 3 - Exclusao					 ***/
	/***	cSequen: Sequencial de Importaï¿½ï¿½o									 ***/
	/***	cCPF: CPF do Usuï¿½rio												 ***/
	/***	cOpcao: 01 - Testa na BA1 / 02 - Testa na VIDA / 03 - Testa na ZZ1	 ***/
	/*******************************************************************************/
	
	If cOpcao == '01'
		
		cSql := "SELECT COUNT(*) QTD "
		cSql += " FROM "+RetSqlName("BA1")+" BA1 "
		cSql += "    , "+RetSqlName("BTS")+" BTS "
		cSql += " WHERE BA1_FILIAL = '"+xFilial("BA1")+"'"
		cSql += " AND BTS_FILIAL = '"+xFilial("BTS")+"'"
		cSql += " AND BA1_MATVID = BTS_MATVID "
		cSql += " AND BA1_CPFUSR = BTS_CPFUSR "
		cSql += " AND BA1_DATBLO = ' ' "
		cSql += " AND BA1_CPFUSR = '"+cCPF+"'"
		
		If cEmpAnt == '01'
			
			cSql += " AND BA1_CODEMP <> '0009' "
			
		EndIf
		
		//----------------------------------------------------------------------------
		//Angelo Henrique - Data: 03/08/2017
		//----------------------------------------------------------------------------
		// Atendendo ao chamado 40801 - Idade reduziu para 12 (receita federal)
		//----------------------------------------------------------------------------
		//cSql += " AND IDADE_S(NVL(TRIM(BA1_DATNAS),BTS_DATNAS)) >= 18 "
		cSql += " AND IDADE_S(NVL(TRIM(BA1_DATNAS),BTS_DATNAS)) >= 12 "
		//----------------------------------------------------------------------------
		// FIM - Angelo Henrique - Data: 03/08/2017
		//----------------------------------------------------------------------------
		
		cSql += " AND BA1.D_E_L_E_T_ = ' ' "
		cSql += " AND BTS.D_E_L_E_T_ = ' ' "
		
		PLsQuery(cSql,"TMPBA1BTS")
		
		If TMPBA1BTS->QTD > 1
			lRet := .T.
		EndIf
		
		TMPBA1BTS->(DbCloseArea())
		
	ElseIf cOpcao == '03'
		
		cSql := "SELECT COUNT(*) QTD "
		cSql += " FROM "+RetSqlName("ZZ1")+" ZZ1 "
		cSql += " WHERE ZZ1_FILIAL = '"+xFilial("ZZ1")+"'"
		cSql += " AND LENGTH(TRIM(ZZ1_DTNASC)) = 10 "
		cSql += " AND ZZ1_OPER = '"+cOper+"'"
		cSql += " AND ZZ1_SEQUEN = '"+cSequen+"'"
		cSql += " AND ZZ1_CPF = '"+cCPF+"'"
		
		//----------------------------------------------------------------------------
		// Inicio - Angelo Henrique - Data: 03/08/2017
		//----------------------------------------------------------------------------
		// Atendendo ao chamado 40801 - Idade reduziu para 12 (receita federal)
		//----------------------------------------------------------------------------
		//cSql += " AND IDADE_S(TO_CHAR(TO_DATE(REPLACE(ZZ1_DTNASC,'.','/'),'DD/MM/YYYY'),'YYYYMMDD')) >= 18"
		cSql += " AND IDADE_S(TO_CHAR(TO_DATE(REPLACE(ZZ1_DTNASC,'.','/'),'DD/MM/YYYY'),'YYYYMMDD')) >= 12 "
		//----------------------------------------------------------------------------
		// FIM - Angelo Henrique - Data: 03/08/2017
		//----------------------------------------------------------------------------
		
		cSql += " AND D_E_L_E_T_ = ' ' "
		
		PLsQuery(cSql,"TMPZZ1")
		
		If TMPZZ1->QTD > 1
			lRet := .T.
		EndIf
		
		TMPZZ1->(DbCloseArea())
		
	EndIf
	
Return lRet


/*/
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ä¿ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½Funcao    ï¿½ lExBA1ZZ1  ï¿½ Autor ï¿½ Fabio Bianchini     ï¿½ Data ï¿½ 01.12.08 ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ä´ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½Descricao ï¿½ Verifica a existencia do beneficiario no BA1 atraves da    ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½          ï¿½ Matricula Funcional+Dependencia e no proprio ZZ1           ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ù±ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
/*/

Static Function lExBA1ZZ1(cMatric,cDepend,cOper,cSequen)
	
	Local nOrdBA1 := BA1->(IndexOrd())
	Local lRet    := .F.
	
	If cDepend == '00'
		lRet := .T.
	Else
		//BA1->(dbOrderNickName("BA1MATEMP"))
		
		//If BA1->(dbSeek(xFilial("BA1")+ZZ1->ZZ1_CODEMP+cMatric)) .and. (Empty(BA1->BA1_DATBLO) .or. Empty(BA1->BA1_MOTBLO))
		
		BA1->(dbOrderNickName("BA1EMCOSUB"))
		
		**'Marcela Coimbra - Pegar segunda famï¿½lia'**
		
		If BA1->(dbSeek(xFilial("BA1")+ZZ1->ZZ1_CODEMP+ZZ0->ZZ0_NUMCON+cVerCon+ZZ0->ZZ0_SUBCON+cVerSub+cMatric))
			
			While 	!BA1->( EOF() ) .and. trim(BA1->(BA1_FILIAL+BA1_CODEMP+BA1_CONEMP+BA1_VERCON+BA1_SUBCON+BA1_VERSUB+BA1_MATEMP)) == trim(xFilial("BA1")+ZZ1->ZZ1_CODEMP+ZZ0->ZZ0_NUMCON+cVerCon+ZZ0->ZZ0_SUBCON+cVerSub+cMatric)
				
				If (Empty(BA1->BA1_DATBLO) .or. Empty(BA1->BA1_MOTBLO))
					
					lRet := .T.
					Exit
					
				EndIf
				
				BA1->(dbSkip())
				
			EndDo
		EndIf
		
		If !lRet//Se nao tem no BA1 TITULAR ATIVO, procuro ao menos no ZZ1 o titular
			cSql := "SELECT COUNT(*) QTD "
			cSql += " FROM "+RetSqlName("ZZ1")+" ZZ1 "
			cSql += " WHERE ZZ1_FILIAL = '"+xFilial("ZZ1")+"'"
			cSql += " and zz1_oper = '"+cOper+"'"
			cSql += " and zz1_sequen = '"+cSequen+"'"
			cSql += " and trim(zz1_func)||zz1_depend = '"+cMatric+"'"
			cSql += " AND D_E_L_E_T_ = ' ' "
			
			PLsQuery(cSql,"TMPZZ1x")
			//Se tem um titular ao menos dentro do arquivo
			If TMPZZ1x->QTD > 0
				lRet := .T.
			EndIf
			
			TMPZZ1x->(DbCloseArea())
		EndIf
		
		/*
		If BA1->(dbSeek(xFilial("BA1")+ZZ1->ZZ1_CODEMP+ZZ0->ZZ0_NUMCON+cVerCon+ZZ0->ZZ0_SUBCON+cVerSub+cMatric)) .and. (Empty(BA1->BA1_DATBLO) .or. Empty(BA1->BA1_MOTBLO))
			lRet := .T.
		Else  //Se nao tem no BA1 TITULAR ATIVO, procuro ao menos no ZZ1 o titular
			cSql := "SELECT COUNT(*) QTD "
			cSql += " FROM "+RetSqlName("ZZ1")+" ZZ1 "
			cSql += " WHERE ZZ1_FILIAL = '"+xFilial("ZZ1")+"'"
			cSql += " and zz1_oper = '"+cOper+"'"
			cSql += " and zz1_sequen = '"+cSequen+"'"
			cSql += " and zz1_func||zz1_depend = '"+cMatric+"'"
			cSql += " AND D_E_L_E_T_ = ' ' "
			
			PLsQuery(cSql,"TMPZZ1x")
			//Se tem um titular ao menos dentro do arquivo
			If TMPZZ1x->QTD > 0
				lRet := .T.
			EndIf
			
			TMPZZ1x->(DbCloseArea())
		EndIf
		*/
		BA1->(dbSetOrder(nOrdBA1))
	EndIf
	
Return(lRet)


/*/
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ä¿ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½Funcao    ï¿½ chkCriTit  ï¿½ Autor ï¿½ Fabio Bianchini     ï¿½ Data ï¿½ 01.12.08 ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ä´ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½Descricao ï¿½ Verifica a existencia de criticas do beneficiario titular  ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½          ï¿½ dentro do array aErro								      ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ù±ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
/*/

Static Function chkCriTit(cOper,cSequen,cMatric, cDepend)
	
	Local lRet    := .F.
	
	If cDepend == '00'
		lRet := .F.
	Else
		//Se tem critica que nï¿½o seja por funcional ja existente(065), pois preciso deixar o dependente entrar caso exista titular.
		cSql := " Select count(*) QTD "
		cSql += " from "+RetSqlName("ZZ1")+" ZZ1, " +RetSqlName("ZZ2")+" ZZ2 "
		cSql += " where zz1_filial = '"+xFilial("ZZ1")+"'"
		cSql += " and zz1_filial = '"+xFilial("ZZ2")+"'"
		cSql += " and zz1_sequen = zz2_sequen
		cSql += " and zz1_numlin = zz2_numlin
		cSql += " and zz1_oper = '"+cOper+"'"
		cSql += " and zz1_sequen = '"+cSequen+"'"
		cSql += " and trim(zz1_func)||zz1_depend = '"+cMatric+"'"
		cSql += " and zz2_coderr not in ('065','066','067','068') "
		cSql += " and zz1.d_e_l_e_t_ = ' '
		cSql += " and zz2.d_e_l_e_t_ = ' '
		
		PLsQuery(cSql,"TMPCRI")
		
		If TMPCRI->QTD > 0
			lRet := .T.
		EndIf
		
		TMPCRI->(DbCloseArea())
	EndIf
	
Return(lRet)


/*/
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ä¿ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½Funcao    ï¿½ lStrData ï¿½ Autor ï¿½ Fabio Bianchini     ï¿½ Data ï¿½ 01.12.08 ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ä´ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½Descricao ï¿½ Valida Formato de Data da importaï¿½ï¿½o						  ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½          ï¿½ 														      ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ù±ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
/*/

Static Function lStrData(cDataimp)
	
	Local x := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS
	
	Local lRet := .T.
	
	cDataimp := replace(AllTrim(cDataimp),'.','')
	
	If empty(cDataimp)
		lRet := .F.
	Else
		If len(cDataimp) == 8
			For x := 1  to 8
				If !( substr(cDataimp,x,1) $ '0123456789' )
					lRet := .F.
					exit
				EndIf
			Next
		Else
			lRet := .F.
		EndIf
		
		If lRet
			cDataimp 	:= Right(cDataimp,4) + Substr(cDataimp,3,2) + Left(cDataimp,2)
			lRet 		:= ( ValType(StoD(cDataimp)) == 'D' )
		EndIf
	EndIf
	
Return lRet


/*/
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ä¿ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½Funcao    ï¿½ chkVerConSub ï¿½ Autor ï¿½ Fabio Bianchini   ï¿½ Data ï¿½ 01.12.08 ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ä´ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½Descricao ï¿½ Retorna Versoes de Contrato e Subcontrato				  ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½          ï¿½ 														      ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ù±ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
/*/

Static Function chkVerConSub(cCodOpe,cCodemp,cConEmp,cSubCon,cOpcao)
	
	/*
	cOpcao = 'C' ---> Contrato: Pegar Versao do contrato
	cOpcao = 'S' ---> SubContrato: Pegar Versao do subcontrato
	*/
	
	If cOpcao $ 'C|S'
		cSql := " SELECT BQB_VERSAO "
		cSql += " 	FROM "+RetSqlName("BQB")+" BQB "
		cSql += "  WHERE BQB_FILIAL = '"+xFilial("BQB")+"'"
		cSql += " 	 AND BQB_CODIGO = '"+cCodOpe+cCodemp+"'"
		cSql += " 	 AND BQB_NUMCON = '"+cConEmp+"'"
		cSql += " 	 AND BQB_DATINI <> ' ' "
		cSql += " 	 AND BQB_DATFIN = ' ' "
		cSql += " 	 AND D_E_L_E_T_ = ' ' "
		
		PLsQuery(cSql,"QRYVER")
		
		cRet := QRYVER->BQB_VERSAO
		
		QRYVER->(DbCloseArea())
	EndIf
	
	If cOpcao == 'S'
		cSql := " SELECT BQD_VERSUB "
		cSql += " 	FROM "+RetSqlName("BQD")+" BQD "
		cSql += "  WHERE BQD_FILIAL = '"+xFilial("BQD")+"'"
		cSql += " 	 AND BQD_CODIGO = '"+cCodOpe+cCodemp+"'"
		cSql += " 	 AND BQD_NUMCON = '"+cConEmp+"'"
		cSql += " 	 AND BQD_VERCON = '"+cRet+"'"
		cSql += " 	 AND BQD_SUBCON = '"+cSubCon+"'"
		cSql += " 	 AND BQD_DATINI <> ' ' "
		cSql += " 	 AND BQD_DATFIN = ' ' "
		cSql += " 	 AND D_E_L_E_T_ = ' ' "
		
		PLsQuery(cSql,"QRYVER")
		
		cRet := QRYVER->BQD_VERSUB
		
		QRYVER->(DbCloseArea())
	EndIf
	
Return cRet


/*/
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ä¿ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½Funcao    ï¿½ chkVlrADUSub ï¿½ Autor ï¿½ Fabio Bianchini   ï¿½ Data ï¿½ 01.12.08 ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ä´ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½Descricao ï¿½ Verifica valor de Opcional Nao Vinculado no subcontrato	  ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½          ï¿½ 														      ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ù±ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
/*/

Static Function chkVlrADUSub(cCodOpe,cCodemp,cConEmp,cVerCon,cSubCon,cVerSub,cCodPla)
	
	Local cRet := .F.
	
	cSql := "SELECT BBX_VALFAI FROM "+RetSqlName("BBX")+" WHERE BBX_FILIAL = '"+xFilial("BBX")+"' "
	cSql += "AND BBX_CODIGO = '"+cCodOpe+cCodemp+"' "
	cSql += "AND BBX_NUMCON = '"+cConEmp+"' "
	cSql += "AND BBX_VERCON = '"+cVerCon+"' "
	cSql += "AND BBX_SUBCON = '"+cSubCon+"' "
	cSql += "AND BBX_VERSUB = '"+cVerSub+"' "
	cSql += "AND BBX_CODPRO = '"+cCodPla+"' "
	cSql += "AND BBX_VERPRO = '001'  "
	cSql += "AND BBX_CODOPC = '0023' "
	cSql += "AND BBX_VEROPC = '001'  "
	cSql += "AND D_E_L_E_T_ <> '*' "
	
	PLsQuery(cSql,"QRYADU")
	
	If !EMPTY(QRYADU->BBX_VALFAI)
		cRet := .T.
	EndIf
	
	QRYADU->(DbCloseArea())
	
Return cRet


/*/
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ä¿ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½Funcao    ï¿½ chkFuncZZ1 ï¿½ Autor ï¿½ Fabio Bianchini     ï¿½ Data ï¿½ 01.12.08 ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ä´ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½Descricao ï¿½ Verifica a existencia de mais de uma ocorrencia da mesma   ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½          ï¿½ Matricula Funcional+Dependencia em ZZ1                     ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ù±ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
/*/
Static Function chkFuncZZ1(cMatric,cOper,cSequen)
	
	Local lRet    := .F.
	
	cSql := "SELECT COUNT(*) QTD "
	cSql += " FROM "+RetSqlName("ZZ1")+" ZZ1 "
	cSql += " WHERE ZZ1_FILIAL = '"+xFilial("ZZ1")+"'"
	cSql += " and zz1_oper = '"+cOper+"'"
	cSql += " and zz1_sequen = '"+cSequen+"'"
	cSql += " and trim(zz1_func)||zz1_depend = '"+cMatric+"'"
	cSql += " AND D_E_L_E_T_ = ' ' "
	
	PLsQuery(cSql,"TMPZZ1x")
	//Se tem um titular ao menos dentro do arquivo
	If TMPZZ1x->QTD > 1
		lRet := .T.
	EndIf
	
	TMPZZ1x->(DbCloseArea())
	
Return(lRet)


/*/
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ä¿ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½Funcao    ï¿½ chkMotBlo  ï¿½ Autor ï¿½ Fabio Bianchini     ï¿½ Data ï¿½ 04.03.15 ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ä´ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½Descricao ï¿½ Verifica se o motivo de bloqueio eh valido                 ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½          ï¿½                                                            ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ù±ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
/*/

Static Function chkMotBlo(cMotblo)
	
	Local lRet    	:= .T.
	Local _cUsuMt	:= GETMV("MV_XBQFUSU") //Angelo Henrique - Data: 10/05/2017 - RN 412
	Local _cFamMt	:= GETMV("MV_XBQFFAM") //Angelo Henrique - Data: 10/05/2017 - RN 412
	Local _cBG3		:= IIF(cMotblo = _cFamMt, _cUsuMt, cMotblo) //Angelo Henrique - Data: 10/05/2017 - RN 412
	
	If empty(cMotblo)
		lRet := .F.
	Else
		
		
		
		cSql := "SELECT COUNT(*) QTD "
		cSql += " FROM "+RetSqlName("BG3")+" BG3 "
		cSql += " WHERE BG3_FILIAL = '"+xFilial("BG3")+"'"
		cSql += " and BG3_TIPBLO = '0' "
		
		//---------------------------------------------------------------------------------------------
		//Angelo Henrique - Alterado para validar o motivo do bloqueio, pois no arquivo
		//de importaï¿½ï¿½o sï¿½ esta vindo o motivo de bloqueio da familia e aqui na BG3
		//estï¿½o os codigos de bloqueio no nï¿½vel do usuï¿½rio
		//---------------------------------------------------------------------------------------------
		//cSql += " and BG3_CODBLO = '"+cMotblo+"'" //Angelo Henrique - Data: 10/05/2017 - RN 412
		cSql += " and BG3_CODBLO = '" + _cBG3 + "'" //Angelo Henrique - Data: 10/05/2017 - RN 412
		
		cSql += " AND D_E_L_E_T_ = ' ' "
		
		PLsQuery(cSql,"TMPBG3")
		
		If ( TMPBG3->QTD == 0 )
			lRet := .F.
		EndIf
		
		If !lRet
			
			cSql := "SELECT COUNT(*) QTD "
			cSql += " FROM " + RetSqlName("BG1") + " BG1 "
			cSql += " WHERE BG1_FILIAL = '" + xFilial("BG1") + "'"
			cSql += " AND BG1_TIPBLO = '0' "
			cSql += " AND BG1_CODBLO = '" + cMotblo + "'"
			cSql += " AND D_E_L_E_T_ = ' ' "
			
			PLsQuery(cSql,"TMPBG1")
			
			If ( TMPBG1->QTD <> 0 )
				lRet := .T.
			EndIf
			
			TMPBG1->(DbCloseArea())
			
		EndIf
		
		TMPBG3->(DbCloseArea())
		
	EndIf
	
Return lRet



/*/
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ä¿ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½Funcao    ï¿½ chkMotBlo  ï¿½ Autor ï¿½ Marcela Coimbra    ï¿½ Data ï¿½ 04.03.15 ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ä´ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½Descricao ï¿½ Verifica se o motivo de bloqueio eh valido para familia    ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½          ï¿½                                                            ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ù±ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
/*/
Static Function fchkMotBlo(cMotblo)
	
	Local lRet    := .T. //.F.//Leonardo Portella - 28/11/16
	
	If empty(cMotblo)
		lRet := .F.
	Else
		
		//Leonardo Portella - 28/11/16 - Inï¿½cio - Replace de BG3 para BG1
		
		cSql := "SELECT COUNT(*) QTD "
		cSql += " FROM " + RetSqlName("BG1") + " BG1 "
		cSql += " WHERE BG1_FILIAL = '" + xFilial("BG1") + "'"
		cSql += " AND BG1_TIPBLO = '0' "
		cSql += " AND BG1_CODBLO = '" + cMotblo + "'"
		cSql += " AND D_E_L_E_T_ = ' ' "
		
		//Leonardo Portella - 28/11/16 - Fim
		
		PLsQuery(cSql,"TMPBG1")
		
		If ( TMPBG1->QTD == 0 )
			lRet := .F.//.T.//Leonardo Portella - 28/11/16
		EndIf
		
		
		
		
		TMPBG1->(DbCloseArea())
		
	EndIf
	
Return lRet



Static Function lCPFTitDupl(cCPF, cSequen, cLinha, cOper, cTipUsr, cTipo)
	
	Local lOk 		:= .T.
	Local cQry		:= ''
	Local aArea		:= GetArea()
	Local cAlias	:= GetNextAlias()
	
	If ( cTipo == 'ZZ1' )
		
		cQry := "SELECT ZZ1_OPER, ZZ1_SEQUEN, ZZ1_NUMLIN, ZZ1_CDBENE" 	+ CRLF
		cQry += "FROM " + RetSqlName("ZZ1") + " ZZ1" 					+ CRLF
		cQry += "WHERE ZZ1_FILIAL = '" + xFilial("ZZ1") + "'" 			+ CRLF
		cQry += "	AND ZZ1_SEQUEN = '" + cSequen + "'" 				+ CRLF
		cQry += "	AND ZZ1_CPF = '" + cCPF + "'" 						+ CRLF
		cQry += "	AND ZZ1_NUMLIN <> '" + cLinha + "'" 				+ CRLF
		cQry += "	AND D_E_L_E_T_ = ' '" 								+ CRLF
		
		TcQuery cQry New Alias cAlias
		
		//Se nï¿½o encontrar nenhum com mesmo CPF no mesmo arquivo e em linha diferente, entï¿½o estï¿½ Ok na ZZ1
		lOk := cAlias->(EOF())
		/*
	ElseIf ( cTipo == 'BA1' )
		
		If cOper == '01'
			
			
			
		EndIf
		*/
	EndIf
	
	cAlias->(DbCloseArea())
	
	RestArea(aArea)
	
Return lOk



//Verifica se existe algum CPF na vida com um nome diferente, ou seja, se na inclusï¿½o jï¿½ existir alguma vida com mesmo
//CPF mas com nome aproximado muito diferente do que estï¿½ tentando incluir, entï¿½o ele rejeita.
//Considera o nome com similaridade menor a 90 como diferente

Static Function lCPFDupl(c_CPF, c_Nome, l_Preposto)
	
	Local lExiste 	:= .F.
	Local aArea 	:= GetArea()
	Local cQry		:= ""
	Local cAlias	:= GetNextAlias()
	
	c_CPF 	:= AllTrim(c_CPF)
	c_Nome 	:= AllTrim(Upper(c_Nome))
	
	If !empty(c_CPF) .and. ( ZZ1->ZZ1_OPER == '01' ) //INCLUSï¿½O
		
		If !l_Preposto
			
			cQry += "SELECT COUNT(*) QTD" 																				+ CRLF
			cQry += "FROM " + RetSqlName('BTS') 																		+ CRLF
			cQry += "WHERE BTS_FILIAL = '" + xFilial('BTS') + "'" 														+ CRLF
			cQry += "  AND BTS_CPFUSR = '" + c_CPF + "'" 																+ CRLF
			cQry += "  AND D_E_L_E_T_ = ' '" 																			+ CRLF
			cQry += "  AND SYS.UTL_MATCH.JARO_WINKLER_SIMILARITY('" + c_Nome + "',TRIM(BTS_NOMUSR)) < 90"				+ CRLF
			cQry += "  AND IDADE_S(BTS_DATNAS) >= 18 /*Nï¿½O CONSIDERA PREPOSTO*/"										+ CRLF
			
			TcQuery cQry New Alias cAlias
			
			If ( cAlias->QTD > 0 )
				lExiste := .T. //Jï¿½ existe pelo menos 1 CPF na vida com nome diferente: por isso considera essa nova inclusï¿½o como duplicidade
			EndIf
			
			cAlias->(DbCloseArea())
			
		EndIf
		
	EndIf
	
	RestArea(aArea)
	
Return lExiste



//Retorna os limites do contrato de uma funcional (inï¿½cio e bloqueio)

Static Function aLimContr
	
	Local aArea 	:= GetArea()
	Local aRet 		:= {}
	Local cQry		:= ''
	Local cAlias	:= GetNextAlias()
	
	cQry := "SELECT BA1_DATINC, BA1_DATBLO, BA1_CODINT||BA1_CODEMP||BA1_MATRIC||BA1_TIPREG||BA1_DIGITO MATRIC,"			+ CRLF
	cQry += "       BA1_CODINT||BA1_CODEMP||BA1_CONEMP||BA1_VERCON||BA1_SUBCON||BA1_VERSUB SUBCON, BA3_DATBLO,"			+ CRLF
	cQry += "       CASE WHEN TRIM(BA1_TRADES) IS NULL THEN 'NAO' ELSE"													+ CRLF
	cQry += "       NVL(("																								+ CRLF
	cQry += "       	SELECT 'SIM'"																					+ CRLF
	cQry += "       	FROM " + RetSqlName('BA1') + " B"																+ CRLF
	cQry += "       	WHERE B.BA1_FILIAL = '" + xFilial('BA1') + "'"													+ CRLF
	cQry += "       		AND B.BA1_CODINT||B.BA1_CODEMP||B.BA1_MATRIC||B.BA1_TIPREG||B.BA1_DIGITO = BA1.BA1_TRADES"	+ CRLF
	cQry += "       		AND B.D_E_L_E_T_ = ' '"																		+ CRLF
	cQry += "       ),'NAO') END BLOQ_POR_TRANSF"																		+ CRLF
	cQry += "FROM " + RetSqlName('BA1') + " BA1"																		+ CRLF
	cQry += "INNER JOIN " + RetSqlName('BA3') + " BA3 ON BA3_FILIAL = '" + xFilial('BA3') + "'"							+ CRLF
	cQry += "	AND BA3_CODINT = BA1_CODINT" 																			+ CRLF
	cQry += "	AND BA3_CODEMP = BA1_CODEMP" 																			+ CRLF
	cQry += "	AND BA3_MATRIC = BA1_MATRIC" 																			+ CRLF
	cQry += "	AND BA3.D_E_L_E_T_ = ' '" 																				+ CRLF
	cQry += "WHERE BA1_FILIAL = '" + xFilial('BA1') + "'" 																+ CRLF
	cQry += "	AND BA1_CODEMP = '" + ZZ1->ZZ1_CODEMP + "'" 															+ CRLF
	cQry += "	AND BA1_CONEMP = '" + ZZ0->ZZ0_NUMCON + "'" 															+ CRLF
	cQry += "	AND BA1_SUBCON = '" + ZZ0->ZZ0_SUBCON + "'" 															+ CRLF
	cQry += "	AND BA1_MATEMP = '" + AllTrim(ZZ1->(ZZ1_FUNC+ZZ1_DEPEND)) + "'" 										+ CRLF
	cQry += "	AND BA1.D_E_L_E_T_ = ' '" 																				+ CRLF
	cQry += "ORDER BY BA1.R_E_C_N_O_ DESC" 																				+ CRLF
	
	TcQuery cQry New Alias cAlias
	
	If !cAlias->(EOF())
		
		aRet := { 										;
			cAlias->BA1_DATINC, 				;
			cAlias->BA1_DATBLO, 				;
			cAlias->MATRIC, 					;
			xFilial('BQC') + cAlias->SUBCON, 	;
			cAlias->BLOQ_POR_TRANSF, 			;
			cAlias->BA3_DATBLO					;
			}
		
	EndIf
	
	cAlias->(DbCloseArea())
	
	RestArea(aArea)
	
Return aRet



Static Function IMPDesbloq
	
	Local aArea 	:= GetArea()
	Local cAliQry 	:= GetNextAlias()
	Local cQry		:= ""
	Local dDesbloq
	Local lDesbFam	:= .F.
	
	cQry += "SELECT BA1_CODINT, BA1_CODEMP, BA1_MATRIC, BA1_TIPREG, BA1_DIGITO, BA1_TIPUSU, TRIM(BA1_NOMUSR) BA1_NOMUSR, BA1.R_E_C_N_O_ RECNO," + CRLF
	cQry += "		NVL(("																							+ CRLF
	cQry += "			SELECT 'NAO'" 																				+ CRLF
	cQry += "			FROM " + RetSqlName('BA1') + " B"															+ CRLF
	cQry += "			WHERE B.BA1_FILIAL = '" + xFilial('BA1') + "'"												+ CRLF
	cQry += "  				AND B.BA1_CODINT = BA3_CODINT" 															+ CRLF
	cQry += "  				AND B.BA1_CODEMP = BA3_CODEMP" 															+ CRLF
	cQry += "  				AND B.BA1_MATRIC = BA3_MATRIC" 															+ CRLF
	cQry += "  				AND B.BA1_TIPREG <> BA1.BA1_TIPREG"														+ CRLF
	cQry += "  				AND ROWNUM = 1"																			+ CRLF
	cQry += "  			),'SIM') UNICO_FAMILIA, BA3_DATBLO, BA1_DATBLO"												+ CRLF
	cQry += "FROM " + RetSqlName('BA1') + " BA1" 																	+ CRLF
	cQry += "INNER JOIN " + RetSqlName('BA3') + " BA3 ON BA3_FILIAL = '" + xFilial('BA3') + "'" 					+ CRLF
	cQry += "  AND BA3_CODINT = BA1_CODINT" 																		+ CRLF
	cQry += "  AND BA3_CODEMP = BA1_CODEMP" 																		+ CRLF
	cQry += "  AND BA3_MATRIC = BA1_MATRIC" 																		+ CRLF
	cQry += "  AND BA3.D_E_L_E_T_ = ' '" 																			+ CRLF
	cQry += "WHERE BA1_FILIAL = '" + xFilial('BA1') + "'" 															+ CRLF
	cQry += "  AND BA1_CPFUSR = '" + ZZ1->ZZ1_CPF + "'"     	        											+ CRLF
	cQry += "  AND BA1_CODINT = '" + PlsIntPad() + "'" 																+ CRLF
	cQry += "  AND BA1_CODEMP = '" + ZZ1->ZZ1_CODEMP + "'" 															+ CRLF
	cQry += "  AND TRIM(BA3.BA3_MATEMP) = '" + AllTrim(ZZ1->ZZ1_FUNC)+ "'" 											+ CRLF
	cQry += "  AND BA1_DATBLO <> ' '" 																				+ CRLF
	cQry += "  AND TRIM(BA1.BA1_MOTBLO) = '" + AllTrim(ZZ1->ZZ1_MOTEXC)+ "'"										+ CRLF
	cQry += "  AND BA1.D_E_L_E_T_ = ' '" 																			+ CRLF
	
	TcQuery cQry New Alias cAliQry
	
	While !cAliQry->(EOF())
		
		BA1->(DbSetOrder(2))
		
		If BA1->(DbSeek(xFilial("BA1") + cAliQry->(BA1_CODINT + BA1_CODEMP + BA1_MATRIC + BA1_TIPREG + BA1_DIGITO)) )
			
			BA3->(DbSetOrder(1))
			BA3->(xFilial("BA3") + BA1->(BA1_CODINT + BA1_CODEMP + BA1_MATRIC))
			
			If A260BloqFamilia(xFilial("BA3") + BA1->(BA1_CODINT + BA1_CODEMP + BA1_MATRIC)) //Famï¿½lia estï¿½ bloqueada
				lDesbFam := .T.
			EndIf
			
			If lDesbFam
				
				dDesbloq := STOD(cAliQry->BA3_DATBLO)
				
				//---------------------------------------------------------------------------------------------------
				//Bloqueio e desbloqueio da familia e grupo familiar
				//---------------------------------------------------------------------------------------------------
				//PL260BLOCO(cAlias,nReg,nOpc,lDireto,cMotivo,dData,cBloFat,nP20,aLog,lGrav,lblqAut, lMsg)
				//---------------------------------------------------------------------------------------------------
				// cMotivo - Visualizar a tabela de Motivo de bloqueio Familia (BG1) - 004 - ACERTO DE DEBITOS
				//---------------------------------------------------------------------------------------------------
				PL260BLOCO("BA1", BA1->(Recno()),4,.T.,"004",dDesbloq,"2",,,,.F.)
				
				//---------------------------------------------------------------------------------------------------
				//Atualizar tabelas de bloqueio BC3 E BCA
				//---------------------------------------------------------------------------------------------------
				DbSelectArea("BC3")
				dbSetOrder(1) //BC3_FILIAL+BC3_MATRIC+DTOS(BC3_DATA)+BC3_TIPO
				If DbSeek(xFilial("BC3") + BA1->(BA1_CODINT + BA1_CODEMP + BA1_MATRIC) + DTOS(dDesbloq) + "1")
					
					While !EOF() .And. BA1->(BA1_CODINT + BA1_CODEMP + BA1_MATRIC) == BC3->BC3_MATRIC .And. dDesbloq == BC3->BC3_DATA
						
						If Empty(AllTrim(BC3->BC3_OBS))
							
							RecLock("BC3", .F.)
							
							BC3->BC3_OBS  := "Desbloq. Import. " + AllTrim(ZZ0->ZZ0_NOMARQ) + " Data: " + DTOC(dDataBase)
							
							BC3->(MsUnlock())
							
						EndIf
						
						BC3->(DbSkip())
						
					EndDo
					
				EndIf
				
				DbSelectArea("BCA")
				dbSetOrder(1) //BCA_FILIAL+BCA_MATRIC+BCA_TIPREG+DTOS(BCA_DATA)+BCA_TIPO
				If DbSeek(xFilial("BCA") + BA1->(BA1_CODINT + BA1_CODEMP + BA1_MATRIC + BA1_TIPREG) + DTOS(dDesbloq) + "1")
					
					While !EOF() .And. BA1->(BA1_CODINT + BA1_CODEMP + BA1_MATRIC + BA1_TIPREG) == BCA->(BCA_MATRIC + BCA_TIPREG) .And. dDesbloq == BCA->BCA_DATA
						
						If Empty(AllTrim(BCA->BCA_OBS))
							
							RecLock("BCA", .F.)
							
							BCA->BCA_OBS  := "Desbloq. Import. " + AllTrim(ZZ0->ZZ0_NOMARQ) + " Data: " + DTOC(dDataBase)
							
							BCA->(MsUnlock())
							
						EndIf
						
						BCA->(DbSkip())
						
					EndDo
					
				EndIf
				
			EndIf
			
			//O desbloqueio da famï¿½lia desbloqueia os beneficiï¿½rios se o motivo de bloqueio deles for o mesmo da famï¿½lia. Por
			//isso a verificaï¿½ï¿½o novamente se estï¿½ bloqueado
			
			If !empty(BA1->BA1_DATBLO)
				
				dDesbloq := STOD(cAliQry->BA1_DATBLO)
				
				//---------------------------------------------------------------------------------------------------
				//Bloquear/Desbloquear Usuario
				//---------------------------------------------------------------------------------------------------
				//PL260BLOUS(cAlias,nReg,nOpc,lDireto,cMotivo,dData,cBloFat,lFiltro,nP20,aLog,lGrav,lMsg)
				//---------------------------------------------------------------------------------------------------
				// cMotivo - Visualizar a tabela de Motivo de bloqueio Usuï¿½rio (BG3) - 004 - ACERTO DE DEBITOS
				//---------------------------------------------------------------------------------------------------
				PL260BLOUS("BA1", BA1->(Recno()), 4, .T.,"004",dDesbloq,"2")
				
				//---------------------------------------------------------------------------------------------------
				//Atualizar tabelas de bloqueio BCA
				//---------------------------------------------------------------------------------------------------
				DbSelectArea("BCA")
				dbSetOrder(1) //BCA_FILIAL+BCA_MATRIC+BCA_TIPREG+DTOS(BCA_DATA)+BCA_TIPO
				If DbSeek(xFilial("BCA") + BA1->(BA1_CODINT + BA1_CODEMP + BA1_MATRIC + BA1_TIPREG) + DTOS(dDesbloq) + "1")
					
					While !EOF() .And. BA1->(BA1_CODINT + BA1_CODEMP + BA1_MATRIC + BA1_TIPREG) == BCA->(BCA_MATRIC + BCA_TIPREG) .And. dDesbloq == BCA->BCA_DATA
						
						If Empty(AllTrim(BCA->BCA_OBS))
							
							RecLock("BCA", .F.)
							
							BCA->BCA_OBS  := "Desbloq. Import. " + AllTrim(ZZ0->ZZ0_NOMARQ) + " Data: " + DTOC(dDataBase)
							
							BCA->(MsUnlock())
							
						EndIf
						
						BCA->(DbSkip())
						
					EndDo
					
				EndIf
				
			EndIf
			
		EndIf
		
		cAliQry->(DbSkip())
		
	EndDo
	
	cAliQry->(DbCloseArea())
	
	RestArea(aArea)
	
Return



User Function IMPVCRI
	
	Local aArea		:= GetArea()
	Local c_Alias	:= GetNextAlias()
	Local cQry		:= ""
	Local aErros	:= {}
	Local aBrowse	:= {}
	Local _aItnRl	:= {}
	local _aArray	:= {}
	Local oBrowse	:= Nil
	Local _lAchou 	:= .F.
	
	Private oFont 	:= TFont():New("Courier New",,15,,.T.,,,,,.F.)
	Private oFont2 	:= TFont():New("Courier New",,15,,.F.,,,,,.F.)
	
	cQry += "SELECT TRIM(ZZ2_SEQUEN) || '-' || TRIM(ZZ2_NUMLIN) SEQ_LIN," 											+ CRLF
	cQry += "	TRIM(ZZ2_SEQERR) || '-' || TRIM(ZZ2_CODERR) || ' [ ' || TRIM(UPPER(ZZ2_DESERR)) || ' ]' ERRO," 		+ CRLF
	cQry += "	TRIM(ZZ1_BENEF) BENEF,TRIM(ZZ1_CPF) CPF,TRIM(UPPER(ZZ1_DESOPE)) OPER, TRIM(ZZ1_BENEF) NOME" 		+ CRLF
	cQry += "	,TRIM(ZZ2_NUMLIN) LINHA, TRIM(ZZ2_CODERR) CODERRO, TRIM(UPPER(ZZ2_DESERR)) DESCERRO " 				+ CRLF
	cQry += "	,TRIM(UPPER(ZZ1_DESOPE)) DESCOPER " 																+ CRLF
	cQry += "FROM " + RetSqlName('ZZ2') + " ZZ2" 																	+ CRLF
	cQry += "INNER JOIN " + RetSqlName('ZZ1') + " ZZ1 ON ZZ1_FILIAL = '" + xFilial('ZZ1') + "'" 					+ CRLF
	cQry += "  AND ZZ1_SEQUEN = ZZ2_SEQUEN" 																		+ CRLF
	cQry += "  AND ZZ1_NUMLIN = ZZ2_NUMLIN" 																		+ CRLF
	cQry += "  AND ZZ1.D_E_L_E_T_ = ' '" 																			+ CRLF
	cQry += "WHERE ZZ2_FILIAL = '" + xFilial('ZZ2') + "'" 															+ CRLF
	cQry += "  AND ZZ2_SEQUEN = '" + ZZ0->ZZ0_SEQUEN + "'" 															+ CRLF
	cQry += "  AND ZZ2.D_E_L_E_T_ = ' '" 																			+ CRLF
	cQry += "ORDER BY 1,2" 	  																						+ CRLF
	
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
	
	If !_lAchou
		
		aAdd(aBrowse,{" ", " ", " ", " ", " ", " "})
		
		aAdd(_aItnRl,{" ", " ", " ", " ", " ", " "})
		
	EndIf
	
	DEFINE DIALOG oDlg TITLE "Visualização das Criticas" FROM 100,050 TO 780,1200 PIXEL
	
	oSay   := TSay():New(05,010,{||'Arquivo: '}					,oDlg,,oFont	,,,,.T.,CLR_BLUE	,,200,08)
	oSay   := TSay():New(05,040,{||AllTrim(ZZ0->ZZ0_NOMARQ)}	,oDlg,,oFont2	,,,,.T.,CLR_BLUE	,,200,08)
	
	oSay   := TSay():New(05,200,{||'Quantidade de Criticas: '}	,oDlg,,oFont	,,,,.T.,CLR_BLUE	,,200,08)
	oSay   := TSay():New(05,283,{||cValToChar(Len(aErros))}		,oDlg,,oFont2	,,,,.T.,CLR_BLUE	,,200,08)
	
	oSay   := TSay():New(05,340,{||'Sequencia: '}				,oDlg,,oFont	,,,,.T.,CLR_BLUE	,,200,08)
	oSay   := TSay():New(05,378,{||ZZ0->ZZ0_SEQUEN}				,oDlg,,oFont2	,,,,.T.,CLR_BLUE	,,200,08)
	
	oBrowse := 	TCBrowse():New( 20 , 03, 573, 290,,;
		{"Linha", "Nome do Beneficiario", "CPF", "Codigo do Erro", "Descricao do Erro", "Operacao" },{20,50,50,50},;
		oDlg,,,,,{||},,,,,,,.F.,,.T.,,.F.,,, )
	
	oBrowse:SetArray(aBrowse)
	
	oBrowse:bLine := {||{;
		aBrowse[oBrowse:nAt,01],;
		aBrowse[oBrowse:nAt,02],;
		aBrowse[oBrowse:nAt,03],;
		aBrowse[oBrowse:nAT,04],;
		aBrowse[oBrowse:nAT,05],;
		aBrowse[oBrowse:nAT,06];
		} }
	
	TButton():New( 320, 010, "Relatorio Excel"	, oDlg,{|| DlgToExcel({{"ARRAY","Criticas arquivo " + AllTrim(ZZ0->ZZ0_NOMARQ),_aArray, _aItnRl}} )},45,010,,,.F.,.T.,.F.,,.F.,,,.F. )
	
	ACTIVATE DIALOG oDlg CENTERED
	
	c_Alias->(DbCloseArea())
	
	RestArea(aArea)
	
Return

/*
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Í»ï¿½ï¿½
ï¿½ï¿½ï¿½Programa  ï¿½  VldMtExcï¿½Autor  ï¿½Angelo Henrique     ï¿½ Data ï¿½  06/06/17   ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Í¹ï¿½ï¿½
ï¿½ï¿½ï¿½Desc.     ï¿½ Validaï¿½ï¿½o do motivo de exclusï¿½o no arquivo, para validar se ï¿½ï¿½
ï¿½ï¿½ï¿½          ï¿½ o titular esta no arquivo para saber qual motivo utilizar. ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Í¹ï¿½ï¿½
ï¿½ï¿½ï¿½Uso       ï¿½ AP                                                         ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½          ï¿½                                                            ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Í¼ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
*/

Static Function VldMtExc(_cSeq, _cFunc, _cDepend, _cCodEmp)
	
	Local _lRet 	:= .F.
	Local _cQuery	:= ""
	Local _aArZ1	:= GetNextAlias()
	
	_cQuery := " SELECT ZZ1_OPER, ZZ1_FUNC, ZZ1_DEPEND, ZZ1_BENEF, ZZ1_CPF FROM " + RetSqlName("ZZ1")
	_cQuery += " WHERE ZZ1_FILIAL = '" + xFilial('ZZ1') + "'"
	_cQuery += " AND trim(ZZ1_FUNC) = '" + _cFunc + "'"
	_cQuery += " AND ZZ1_DEPEND = '00' "
	_cQuery += " AND ZZ1_CODEMP = '" + _cCodEmp + "'"
	_cQuery += " AND ZZ1_SEQUEN = '" + _cSeq + "'"
	_cQuery += " AND ZZ1_OPER = '03'"
	_cQuery += " AND D_E_L_E_T_ = ' ' "
	
	TCQuery _cQuery New Alias _aArZ1
	
	_lRet := .F.
	
	//Se achar o titular no arquivo retorna T
	//assim serï¿½ utilizado o motivo encaminhado no arquivo de importaï¿½ï¿½o
	If !(_aArZ1->(EOF()))
		
		_lRet := .T.
		
	EndIF
	
	_aArZ1->(DbCloseArea())
	
Return _lRet


/*
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Í»ï¿½ï¿½
ï¿½ï¿½ï¿½Programa  ï¿½ VldIdade ï¿½Autor  ï¿½Angelo Henrique     ï¿½ Data ï¿½  09/06/17   ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Í¹ï¿½ï¿½
ï¿½ï¿½ï¿½Desc.     ï¿½ Validaï¿½ï¿½o da idade maxima permitida para inclusï¿½o do        ï¿½ï¿½
ï¿½ï¿½ï¿½          ï¿½ beneficiario no subcontrato.                               ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Í¹ï¿½ï¿½
ï¿½ï¿½ï¿½Uso       ï¿½ AP                                                         ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½          ï¿½                                                            ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Í¼ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
*/

Static Function VldIdade(_cProdt, _cGraPt, _cCodBqc, _cContra, _cSubCon, _cDtNasc)
	
	Local _lRet 		:= .T.
	Local _cQuery		:= ""
	Local _aArBQC		:= GetNextAlias()
	Local _aArBT1		:= GetNextAlias()
	
	Default _cProdt		:= "" //Codigo do Produto da BT0
	Default _cGraPt		:= "" //Grau de Parentesco
	Default _cCodBqc	:= "" //Codigo da BQC
	Default _cContra	:= "" //Numero do Contrato
	Default _cSubCon	:= "" //Numero do SubContrato
	Default _cDtNasc	:= "" //Data de Nascimento
	
	_cQuery := " SELECT										 			" + cEnt
	_cQuery += "     BQC.BQC_CODIGO,                         			" + cEnt
	_cQuery += "     BQC.BQC_NUMCON,                         			" + cEnt
	_cQuery += "     BQC.BQC_VERCON,                         			" + cEnt
	_cQuery += "     BQC.BQC_CODINT,                         			" + cEnt
	_cQuery += "     BQC.BQC_CODEMP,                         			" + cEnt
	_cQuery += "     BQC.BQC_SUBCON,                         			" + cEnt
	_cQuery += "     BQC.BQC_VERSUB,                         			" + cEnt
	_cQuery += "     BQC.BQC_DESCRI,                         			" + cEnt
	_cQuery += "     BT0.BT0_CODPRO,                         			" + cEnt
	_cQuery += "     BT0.BT0_GRAUPA,                         			" + cEnt
	_cQuery += "     BT0.BT0_IDAMAX                          			" + cEnt
	_cQuery += " FROM                                        			" + cEnt
	_cQuery += "     " + RetSqlName("BQC") + " BQC           			" + cEnt
	_cQuery += "     INNER JOIN                              			" + cEnt
	_cQuery += "         " + RetSqlName("BT0") + " BT0       			" + cEnt
	_cQuery += "     ON                                      			" + cEnt
	_cQuery += "         BT0.D_E_L_E_T_ = ' '                			" + cEnt
	_cQuery += "         AND BT0.BT0_FILIAL = BQC.BQC_FILIAL 			" + cEnt
	_cQuery += "         AND BT0.BT0_CODIGO = BQC.BQC_CODIGO 			" + cEnt
	_cQuery += "         AND BT0.BT0_NUMCON = BQC.BQC_NUMCON 			" + cEnt
	_cQuery += "         AND BT0.BT0_VERCON = BQC.BQC_VERCON 			" + cEnt
	_cQuery += "         AND BT0.BT0_SUBCON = BQC.BQC_SUBCON 			" + cEnt
	_cQuery += "         AND BT0.BT0_VERSUB = BQC.BQC_VERSUB 			" + cEnt
	_cQuery += "         AND BT0.BT0_CODPRO = '" + _cProdt + "' 		" + cEnt
	_cQuery += "         AND BT0.BT0_VERSAO = '001'          			" + cEnt
	_cQuery += "         AND BT0.BT0_GRAUPA = '" + _cGraPt + "' 		" + cEnt
	_cQuery += " WHERE                                       			" + cEnt
	_cQuery += "     BQC.D_E_L_E_T_ = ' '                    			" + cEnt
	_cQuery += "     AND BQC.BQC_FILIAL = '" + xFilial("BQC") + "'      " + cEnt
	_cQuery += "     AND BQC.BQC_CODIGO = '" + _cCodBqc + "'    		" + cEnt
	_cQuery += "     AND BQC.BQC_NUMCON = '" + _cContra + "'    		" + cEnt
	_cQuery += "     AND BQC.BQC_VERCON = '001'              			" + cEnt
	_cQuery += "     AND BQC.BQC_SUBCON = '" + _cSubCon + "' 			" + cEnt
	_cQuery += "     AND BQC.BQC_VERSUB = '001'              			" + cEnt
	
	TCQuery _cQuery New Alias _aArBQC
	
	If !(_aArBQC->(EOF()))
		
		//-------------------------------------------
		//Rotina padrï¿½o para calcular a idade
		//-------------------------------------------
		If Calc_Idade(dDataBase,CTOD(_cDtNasc)) > _aArBQC->BT0_IDAMAX
			
			_lRet := .F.
			
		EndIf
		
	Else
		
		//---------------------------------------------------------------------------------
		//Se nï¿½o achar nenhum resultado foi solicitado pela CADASTRO (JUDY)
		//que olhe tambï¿½m o nï¿½vel do produto, pois entende-se que ele segue a regra
		//jï¿½ parametrizada no produto e nï¿½o no subcontrato.
		//---------------------------------------------------------------------------------
		_cQuery := " SELECT										 			" + cEnt
		_cQuery += "     BT1.BT1_CODIGO,                         			" + cEnt
		_cQuery += "     BT1.BT1_VERSAO,                         			" + cEnt
		_cQuery += "     BT1.BT1_TIPUSR,                         			" + cEnt
		_cQuery += "     BT1.BT1_GRAUPA,                         			" + cEnt
		_cQuery += "     BT1.BT1_IDAMAX                          			" + cEnt
		_cQuery += " FROM                                        			" + cEnt
		_cQuery += "     " + RetSqlName("BT1") + " BT1           			" + cEnt
		_cQuery += " WHERE                                       			" + cEnt
		_cQuery += "     BT1.D_E_L_E_T_ = ' '                    			" + cEnt
		_cQuery += "     AND BT1.BT1_FILIAL = '" + xFilial("BT1") + "'      " + cEnt
		_cQuery += "     AND BT1.BT1_CODIGO = '" + _cCodBqc + "'    		" + cEnt
		_cQuery += "     AND BT1.BT1_VERSAO = '001'              			" + cEnt
		_cQuery += "     AND BT1.BT1_GRAUPA = '" + _cGraPt + "' 			" + cEnt
		
		TCQuery _cQuery New Alias _aArBT1
		
		If !(_aArBT1->(EOF()))
			
			//-------------------------------------------
			//Rotina padrï¿½o para calcular a idade
			//-------------------------------------------
			If Calc_Idade(dDataBase,CTOD(_cDtNasc)) > _aArBT1->BT1_IDAMAX
				
				_lRet := .F.
				
			EndIf
			
		EndIf
		
		_aArBT1->(DbCloseArea())
		
	EndIF
	
	_aArBQC->(DbCloseArea())
	
Return _lRet


/*
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Í»ï¿½ï¿½
ï¿½ï¿½ï¿½Programa  ï¿½ VldCPFDp ï¿½Autor  ï¿½Angelo Henrique     ï¿½ Data ï¿½  26/03/2018 ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Í¹ï¿½ï¿½
ï¿½ï¿½ï¿½Desc.     ï¿½ Validaï¿½ï¿½o de duplicidade de CPF no arquivo que esta sendo   ï¿½ï¿½
ï¿½ï¿½ï¿½          ï¿½ importado.                                                 ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Í¹ï¿½ï¿½
ï¿½ï¿½ï¿½Uso       ï¿½ AP                                                         ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½          ï¿½                                                            ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Í¼ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
*/
User Function VldCPFDp(_cSeq , _cCpf)
	
	Local _lRet 	:= .T.
	Local _cQuery	:= ""
	Local _cAlias	:= GetNextAlias()
	
	_cQuery := " SELECT												" + cEnt
	_cQuery += "     COUNT(*) QTD									" + cEnt
	_cQuery += " FROM												" + cEnt
	_cQuery += "     " + RetSqlName("ZZ1") + " ZZ1           		" + cEnt
	_cQuery += " WHERE 												" + cEnt
	_cQuery += "     ZZ1.ZZ1_FILIAL = '" + xFilial("ZZ1") + "'		" + cEnt
	_cQuery += "     AND ZZ1.ZZ1_SEQUEN = '" + _cSeq + "'			" + cEnt
	_cQuery += "     AND ZZ1.ZZ1_CPF = '" + _cCpf + "'				" + cEnt
	_cQuery += "     AND ZZ1.ZZ1_CPFPRE <> 'S'						" + cEnt
	_cQuery += "     AND ZZ1.D_E_L_E_T_ = ' '						" + cEnt
	_cQuery += "     AND ZZ1.ZZ1_OPER = '01'						" + cEnt
	
	If Select(_cAlias) > 0
		(_cAlias)->(DbCloseArea())
	EndIf
	
	PLSQuery(_cQuery,_cAlias)
	
	If !(_cAlias)->(EOF())
		
		If (_cAlias)->QTD > 1
			
			_lRet := .F.
			
		EndIf
		
	EndIf
	
	If Select(_cAlias) > 0
		(_cAlias)->(DbCloseArea())
	EndIf
	
Return _lRet


/*
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Í»ï¿½ï¿½
ï¿½ï¿½ï¿½Programa  ï¿½ IMPVDARQ ï¿½Autor  ï¿½Angelo Henrique     ï¿½ Data ï¿½  26/06/2018 ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Í¹ï¿½ï¿½
ï¿½ï¿½ï¿½Desc.     ï¿½ Validaï¿½ï¿½o para pegar o contrato, subcontrato e a empresa    ï¿½ï¿½
ï¿½ï¿½ï¿½          ï¿½ preenchendo assim automaticamente a tela de importaï¿½ï¿½o.    ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Í¹ï¿½ï¿½
ï¿½ï¿½ï¿½Uso       ï¿½ AP                                                         ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Í¼ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
*/

User Function IMPVDARQ
	
	Local _aArea	:= GetArea()
	Local nHdlImp	:= 0
	Local xBuffer   := ""
	Local cPath 	:= ""
	Local _nCont	:= 0
	Local nTamLinha	:= 0
	Local nBytes	:= 0
	Local _lRet		:= .T.
	Local cCodUsr	:= ""
	
	cCodUsr	:= RetCodUsr()
	
	If cCodUsr == '001349' .or. cCodUsr == '001727'		//001349 - carlos.qualivida e 001727 - FRED (GETIN) para testes
		
		cPath := "C:\IMP_CORRETORES\"
		
	Else
		
		cPath := GetNewPar("MV_YIMPIN","C:\")
		
	EndIf
	
	//cPath := 'M:\apo\DESENV3X\'
	
	If Substr(cPath,Len(cPath),1) <> "\"
		cPath := cPath + "\"
	EndIf
	
	nHdlImp := FOpen(cPath+M->ZZ0_NOMARQ,64)
	
	If nHdlImp == -1
		Help(" ",1,"NOFLEIMPOR")
	EndIf
	
	nTamArq := FSeek(nHdlImp,0,2)
	
	//----------------------------------
	//Vou para o inicio do arquivo
	//----------------------------------
	FSeek(nHdlImp,0,0)
	
	While nBytes < nTamArq
		
		nTamLinha 	:= 3000 //Defino o tamanho da linha alto para pegar a quebra de linha
		xBuffer		:= Space(nTamLinha)
		FREAD(nHdlImp, @xBuffer, nTamLinha)
		
		nTamLinha 	:= At(CHR(10), xBuffer) //Acho a quebra de linha
		FSeek(nHdlImp, nBytes, 0)//Volto para o ï¿½ltimo byte lido
		
		xBuffer		:= Space(nTamLinha)
		FREAD(nHdlImp, @xBuffer, nTamLinha)
		
		If _nCont = 0
			
			M->ZZ0_NUMCON := STRZERO(VAL(SUBSTR(xBuffer, 3, 5)),LEN(M->ZZ0_NUMCON))
			
			M->ZZ0_SUBCON := STRZERO(VAL(SUBSTR(xBuffer, 8, 5)),LEN(M->ZZ0_SUBCON))
			
			_nCont ++
			
		Else
			
			M->ZZ0_CODEMP := Substr(xBuffer, 339, 4)
			
			Exit
			
		EndIf
		
		nBytes += nTamLinha
		
	EndDo
	
	//--------------------
	//Fecha o Arquivo
	//--------------------
	FCLOSE(nHdlImp)
	
	RestArea(_aArea)
	
Return _lRet


/*
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Í»ï¿½ï¿½
ï¿½ï¿½ï¿½Programa  ï¿½ CBITRANS ï¿½Autor  ï¿½Angelo Henrique     ï¿½ Data ï¿½  26/12/2018 ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Í¹ï¿½ï¿½
ï¿½ï¿½ï¿½Desc.     ï¿½ Rotina responsï¿½vel por transferir o beneficiï¿½rio.           ï¿½ï¿½
ï¿½ï¿½ï¿½          ï¿½                                                            ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Í¹ï¿½ï¿½
ï¿½ï¿½ï¿½Uso       ï¿½ AP                                                         ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Í¼ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
*/
Static Function CBITRANS
	
	Local _aArea	:= GetArea()
	Local _aArBA1	:= BA1->(GetArea())
	Local _aArBA3	:= BA3->(GetArea())
	Local _aArBFO	:= BFO->(GetArea())
	Local _cChavAnt := ""
	Local _dDtCare	:= CTOD(" / / ")
	Local _lCar 	:= .T.
	
	//---------------------------------------------------------------------------------------------------------
	// primeiro devo bloquear a matricula anterior caso nï¿½o esteja bloqueada
	//---------------------------------------------------------------------------------------------------------
	_cChavAnt := STRTRAN(ZZ1->ZZ1_OUTROS, "PRTB", "")
	
	DbSelectArea("BA1")
	DbOrderNickName("BA1EMCOSUB")
	If DbSeek(xFilial("BA1") + AllTrim(_cChavAnt))
		
		//---------------------------------------------------------------------------------------------------------
		//Ponterei na matricula pego a Data de Carencia
		//---------------------------------------------------------------------------------------------------------
		_dDtCare := BA1->BA1_DATCAR
		
		//---------------------------------------------------------------------------------------------------------
		//Pode acontecer de jï¿½ ter ocorrido o bloqueio deste usuï¿½rio e a portabilidade
		//sï¿½ estar sendo executada neste momento
		//---------------------------------------------------------------------------------------------------------
		If Empty(BA1->BA1_DATBLO)
			
			//---------------------------------------------------------------------------------------------------------
			//Se for titular deve ser ponterado no nï¿½vel da famï¿½lia e executar o bloqueio no nï¿½vel da famï¿½lia
			//---------------------------------------------------------------------------------------------------------
			If BA1->BA1_TIPUSU = "T"
				
				DbSelectArea("BA3")
				DbSetOrder(1) //BA3_FILIAL+BA3_CODINT+BA3_CODEMP+BA3_MATRIC+BA3_CONEMP+BA3_VERCON+BA3_SUBCON+BA3_VERSUB
				If DbSeek(xFilial("BA3")+ BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_CONEMP+BA1_VERCON+BA1_SUBCON+BA1_VERSUB))
					
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
					
				Else
					
					//---------------------------------------------------------------------------------------------------
					//Bloquear/Desbloquear Usuario
					//---------------------------------------------------------------------------------------------------
					//PL260BLOUS(cAlias,nReg,nOpc,lDireto,cMotivo,dData,cBloFat,lFiltro,nP20,aLog,lGrav,lMsg)
					//---------------------------------------------------------------------------------------------------
					// cMotivo - Visualizar a tabela de Motivo de bloqueio Usuï¿½rio (BG3)
					//---------------------------------------------------------------------------------------------------
					PL260BLOUS("BA1", BA1->(Recno()), 4, .T.,"019",/*CTOD("31/05/2016")*/LastDate(dDataBase),"1")
					
				EndIf
				
			Endif
			
		EndIf
		//---------------------------------------------------------------------------------------------------------
		//Fim do Bloqueio da Familia/Usuï¿½rio
		//---------------------------------------------------------------------------------------------------------
		
		//---------------------------------------------------------------------------------------------------------
		//verifico se tem BFO e deixo a variavel com .T. ou .F.
		//---------------------------------------------------------------------------------------------------------
		DbSelectArea("BFO")
		DbSetOrder(1)//BFO_FILIAL+BFO_CODINT+BFO_CODEMP+BFO_MATRIC+BFO_TIPREG+BFO_CLACAR
		If DbSeek(xFilial("BFO") + BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG))
			
			_lCar := .T.
			
		EndIf
		
		
	EndIf
	
	//---------------------------------------------------------------------------------------------------------
	//segundo devo criar a nova matricula (familia/usuario)
	//---------------------------------------------------------------------------------------------------------
	IncluiUsuar()
	
	//---------------------------------------------------------------------------------------------------------
	//Terceiro se tiver BFO copio ela para a nova matricula.
	//---------------------------------------------------------------------------------------------------------
	If _lCar
		
		
		
		
	EndIf
	
	
	//Quarto nï¿½o tendo BFO chamo a rotina CABA119 (GerCarUsr) para gerar a carï¿½ncia e pego a DATCAR da matricula antiga
	
	RestArea(_aArBFO)
	RestArea(_aArBA3)
	RestArea(_aArBA1)
	RestArea(_aArea	)
	
Return


/*
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Í»ï¿½ï¿½
ï¿½ï¿½ï¿½Programa  ï¿½AtuCar     ï¿½Autor  ï¿½Angelo Henrique     ï¿½ Data ï¿½  28/12/18  ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Í¹ï¿½ï¿½
ï¿½ï¿½ï¿½Desc.     ï¿½Rotina que irï¿½ atualizar a carï¿½ncia  ificador dos           ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½          ï¿½beneficiarios que foram transferidos na importaï¿½ï¿½o prefeituraï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Í¹ï¿½ï¿½
ï¿½ï¿½ï¿½Uso       ï¿½CABERJ                                                      ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Í¼ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
*/

Static Function AtuCar()
	
	Local _aArea 	:= GetArea()
	Local cQry		:= ""
	Local cAliQry	:= GetNextAlias()
	Local cAliQr1	:= GetNextAlias()
	Local cAliQr2	:= GetNextAlias()
	Local cAliQr3	:= GetNextAlias()
	Local cAliQr4	:= GetNextAlias()
	Local _lSeek	:= .T.
	
	cQry := " SELECT                                                                        " 	+ CRLF
	cQry += "     BA1.BA1_CODINT,                                                           " 	+ CRLF
	cQry += "     BA1.BA1_CODEMP,                                                           " 	+ CRLF
	cQry += "     BA1.BA1_MATRIC,                                                           " 	+ CRLF
	cQry += "     BA1.BA1_CONEMP,                                                           " 	+ CRLF
	cQry += "     BA1.BA1_VERCON,                                                           " 	+ CRLF
	cQry += "     BA1.BA1_SUBCON,                                                           " 	+ CRLF
	cQry += "     BA1.BA1_VERSUB,                                                           " 	+ CRLF
	cQry += "     BA1.BA1_TIPREG,                                                           " 	+ CRLF
	cQry += "     BA1.BA1_CODPLA,                                                           " 	+ CRLF
	cQry += "     BA1.BA1_VERSAO,                                                           " 	+ CRLF
	cQry += "     BA1.BA1_DIGITO,                                                           " 	+ CRLF
	cQry += "     BA1.BA1_DATCAR,                                                           " 	+ CRLF
	cQry += "     TRIM(BA1.BA1_NOMUSR) NOME,                                                " 	+ CRLF
	cQry += "     BA1.BA1_CPFUSR,                                                           " 	+ CRLF
	cQry += "     BA1.BA1_DATNAS                                                            " 	+ CRLF
	cQry += " FROM                                                                          " 	+ CRLF
	cQry += "     BA1020 BA1                                                                " 	+ CRLF
	cQry += " WHERE                                                                         " 	+ CRLF
	cQry += "     BA1.BA1_CODINT = '0001'                                                   " 	+ CRLF
	cQry += "     AND BA1.BA1_CODEMP = '0296'                                               " 	+ CRLF
	cQry += "     AND BA1.BA1_CONEMP = '000000000003'                                       " 	+ CRLF
	cQry += "     AND NOT EXISTS                                                            " 	+ CRLF
	cQry += "     (                                                                         " 	+ CRLF
	cQry += "         SELECT 																" 	+ CRLF
	cQry += "             BFO.BFO_CODINT||BFO.BFO_CODEMP||BFO.BFO_MATRIC||BFO.BFO_TIPREG	" 	+ CRLF
	cQry += "         FROM 																	" 	+ CRLF
	cQry += "             BFO020 BFO                                                        " 	+ CRLF
	cQry += "         WHERE                                                                 " 	+ CRLF
	cQry += "             BFO.BFO_FILIAL      = BA1.BA1_FILIAL                              " 	+ CRLF
	cQry += "             AND BFO.BFO_CODINT  = BA1.BA1_CODINT                              " 	+ CRLF
	cQry += "             AND BFO.BFO_CODEMP  = BA1.BA1_CODEMP                              " 	+ CRLF
	cQry += "             AND BFO.BFO_MATRIC  = BA1.BA1_MATRIC                              " 	+ CRLF
	cQry += "             AND BFO.BFO_TIPREG  = BA1.BA1_TIPREG                              " 	+ CRLF
	cQry += "     )                                                                         " 	+ CRLF
	cQry += "     AND NOT EXISTS                                                            " 	+ CRLF
	cQry += "     (                                                                         " 	+ CRLF
	cQry += "         SELECT                                                                " 	+ CRLF
	cQry += "             BFJ.BFJ_CODINT||BFJ.BFJ_CODEMP||BFJ.BFJ_MATRIC                    " 	+ CRLF
	cQry += "         FROM                                                                  " 	+ CRLF
	cQry += "             BFJ020 BFJ                                                        " 	+ CRLF
	cQry += "         WHERE                                                                 " 	+ CRLF
	cQry += "             BFJ.BFJ_FILIAL      = BA1.BA1_FILIAL                              " 	+ CRLF
	cQry += "             AND BFJ.BFJ_CODINT  = BA1.BA1_CODINT                              " 	+ CRLF
	cQry += "             AND BFJ.BFJ_CODEMP  = BA1.BA1_CODEMP                              " 	+ CRLF
	cQry += "             AND BFJ.BFJ_MATRIC  = BA1.BA1_MATRIC                              " 	+ CRLF
	cQry += "             AND BFJ.D_E_L_E_T_  = ' '                                         " 	+ CRLF
	cQry += "     )                                                                         " 	+ CRLF
	
	If Select(cAliQry)>0
		(cAliQry)->(DbCloseArea())
	EndIf
	
	DbUseArea(.T.,"TopConn",TcGenQry(,,cQry),cAliQry,.T.,.T.)
	
	DbSelectArea(cAliQry)
	
	While !((cAliQry)->(EOF()))
		
		cQry := " SELECT                                                    " 	+ CRLF
		cQry += "     DISTINCT                                              " 	+ CRLF
		cQry += "     BA1.BA1_CODINT,                                       " 	+ CRLF
		cQry += "     BA1.BA1_CODEMP,                                       " 	+ CRLF
		cQry += "     BA1.BA1_MATRIC,                                       " 	+ CRLF
		cQry += "     BA1.BA1_CONEMP,                                       " 	+ CRLF
		cQry += "     BA1.BA1_VERCON,                                       " 	+ CRLF
		cQry += "     BA1.BA1_SUBCON,                                       " 	+ CRLF
		cQry += "     BA1.BA1_VERSUB,                                       " 	+ CRLF
		cQry += "     BA1.BA1_TIPREG,                                       " 	+ CRLF
		cQry += "     BA1.BA1_CODPLA,                                       " 	+ CRLF
		cQry += "     BA1.BA1_VERSAO,                                       " 	+ CRLF
		cQry += "     BA1.BA1_DIGITO,                                       " 	+ CRLF
		cQry += "     BA1.BA1_DATCAR,                                       " 	+ CRLF
		cQry += "     TRIM(BA1.BA1_NOMUSR) NOME,                            " 	+ CRLF
		cQry += "     DECODE(TRIM(BFO.BFO_MATRIC), NULL, 'N','S') USUARIO,	" 	+ CRLF
		cQry += "     DECODE(TRIM(BFJ.BFJ_MATRIC), NULL, 'N','S') FAMILIA,	" 	+ CRLF
		cQry += "     DECODE(TRIM(BA6.BA6_CODIGO), NULL, 'N','S') SUBCON	" 	+ CRLF
		cQry += "     														" 	+ CRLF
		cQry += " FROM                                                      " 	+ CRLF
		cQry += "     BA1020 BA1                                            " 	+ CRLF
		cQry += "                                                           " 	+ CRLF
		cQry += "     LEFT JOIN                                             " 	+ CRLF
		cQry += "         BFO020 BFO                                        " 	+ CRLF
		cQry += "     ON                                                    " 	+ CRLF
		cQry += "         BFO.BFO_FILIAL = BA1.BA1_FILIAL                   " 	+ CRLF
		cQry += "         AND BFO.BFO_CODINT = BA1.BA1_CODINT               " 	+ CRLF
		cQry += "         AND BFO.BFO_CODEMP = BA1.BA1_CODEMP               " 	+ CRLF
		cQry += "         AND BFO.BFO_MATRIC = BA1.BA1_MATRIC               " 	+ CRLF
		cQry += "         AND BFO.BFO_TIPREG = BA1.BA1_TIPREG               " 	+ CRLF
		cQry += "         AND BFO.D_E_L_E_T_ = ' '                          " 	+ CRLF
		cQry += "                                                           " 	+ CRLF
		cQry += "     LEFT JOIN                                             " 	+ CRLF
		cQry += "         BFJ020 BFJ                                        " 	+ CRLF
		cQry += "     ON                                                    " 	+ CRLF
		cQry += "         BFJ.BFJ_FILIAL      = BA1.BA1_FILIAL              " 	+ CRLF
		cQry += "         AND BFJ.BFJ_CODINT  = BA1.BA1_CODINT              " 	+ CRLF
		cQry += "         AND BFJ.BFJ_CODEMP  = BA1.BA1_CODEMP              " 	+ CRLF
		cQry += "         AND BFJ.BFJ_MATRIC  = BA1.BA1_MATRIC              " 	+ CRLF
		cQry += "         AND BFJ.D_E_L_E_T_  = ' '                         " 	+ CRLF
		cQry += "                                                           " 	+ CRLF
		cQry += "     LEFT JOIN	                                        	" 	+ CRLF
		cQry += "         BA6020 BA6                                        " 	+ CRLF
		cQry += "     ON                                                    " 	+ CRLF
		cQry += "         BA6.BA6_FILIAL  = BA1.BA1_FILIAL                  " 	+ CRLF
		cQry += "         AND BA6.BA6_CODINT = BA1.BA1_CODINT               " 	+ CRLF
		cQry += "         AND BA6.BA6_NUMCON = BA1.BA1_CONEMP               " 	+ CRLF
		cQry += "         AND BA6.BA6_VERCON = BA1.BA1_VERCON               " 	+ CRLF
		cQry += "         AND BA6.BA6_SUBCON = BA1.BA1_SUBCON               " 	+ CRLF
		cQry += "         AND BA6.BA6_VERSUB = BA1.BA1_VERSUB               " 	+ CRLF
		cQry += "         AND BA6.BA6_CODPRO = BA1.BA1_CODPLA               " 	+ CRLF
		cQry += "         AND BA6.BA6_CODIGO = BA1.BA1_CODEMP               " 	+ CRLF
		cQry += "         AND BA6.D_E_L_E_T_ = ' '                          " 	+ CRLF
		cQry += "                                                           " 	+ CRLF
		cQry += " WHERE                                                     " 	+ CRLF
		cQry += "     BA1.D_E_L_E_T_ = ' '                                  " 	+ CRLF
		cQry += "     AND BA1.BA1_CODINT = '0001'                           " 	+ CRLF
		cQry += "     AND BA1.BA1_CODEMP IN ('0182', '0282')                " 	+ CRLF
		cQry += "     AND                                                   " 	+ CRLF
		cQry += "         (                                                 " 	+ CRLF
		cQry += "             BA1.BA1_DATBLO > '20181101'                   " 	+ CRLF
		cQry += "             OR                                            " 	+ CRLF
		cQry += "             BA1.BA1_DATBLO = ' '                          " 	+ CRLF
		cQry += "         )                                                 " 	+ CRLF
		cQry += "     AND BA1.BA1_CPFUSR = '" + (cAliQry)->BA1_CPFUSR 	+ "'" 	+ CRLF
		cQry += "     AND BA1.BA1_DATNAS = '" + (cAliQry)->BA1_DATNAS 	+ "'" 	+ CRLF
		cQry += "                                                           " 	+ CRLF
		cQry += " ORDER BY                                                  " 	+ CRLF
		cQry += "     BA1.BA1_CODEMP,                                       " 	+ CRLF
		cQry += "     BA1.BA1_MATRIC                                        " 	+ CRLF
		
		If Select(cAliQr1)>0
			(cAliQr1)->(DbCloseArea())
		EndIf
		
		DbUseArea(.T.,"TopConn",TcGenQry(,,cQry),cAliQr1,.T.,.T.)
		
		DbSelectArea(cAliQr1)
		
		While !((cAliQr1)->(EOF()))
			
			_aArBA1 := BA1->(GetArea())
			_aArBFO := BFO->(GetArea())
			_aArBFJ := BFJ->(GetArea())
			_aArBA6 := BA6->(GetArea())
			
			//---------------------------------------------------------------------------------
			//Caso o beneficiï¿½rio tenho Carï¿½ncia no nivel do usuï¿½rio na antiga matricula
			//ï¿½ necessï¿½rio criar na nova matricula igual esta na anterior
			//---------------------------------------------------------------------------------
			If AllTrim((cAliQr1)->USUARIO) == "S"
				
				cQry := " SELECT													" 	+ CRLF
				cQry += " 	BFO.BFO_CLACAR,											" 	+ CRLF
				cQry += " 	BFO.BFO_CARENC,											" 	+ CRLF
				cQry += " 	BFO.BFO_UNICAR,											" 	+ CRLF
				cQry += " 	BFO.BFO_DATCAR,											" 	+ CRLF
				cQry += " 	BFO.BFO_TIPREG,											" 	+ CRLF
				cQry += " 	BFO.BFO_YRGIMP											" 	+ CRLF
				cQry += " FROM														" 	+ CRLF
				cQry += " 	BFO020 BFO												" 	+ CRLF
				cQry += " WHERE														" 	+ CRLF
				cQry += " 	BFO.BFO_FILIAL      = '" + xFilial("BFO") + "'			" 	+ CRLF
				cQry += " 	AND BFO.BFO_CODINT  = '" + (cAliQr1)->BA1_CODINT + "' 	" 	+ CRLF
				cQry += " 	AND BFO.BFO_CODEMP  = '" + (cAliQr1)->BA1_CODEMP + "' 	" 	+ CRLF
				cQry += " 	AND BFO.BFO_MATRIC  = '" + (cAliQr1)->BA1_MATRIC + "' 	" 	+ CRLF
				cQry += " 	AND BFO.BFO_TIPREG  = '" + (cAliQr1)->BA1_TIPREG + "' 	" 	+ CRLF
				cQry += " 	AND BFO.D_E_L_E_T_ = ' '								" 	+ CRLF
				
				If Select(cAliQr2)>0
					(cAliQr2)->(DbCloseArea())
				EndIf
				
				DbUseArea(.T.,"TopConn",TcGenQry(,,cQry),cAliQr2,.T.,.T.)
				
				DbSelectArea(cAliQr2)
				
				While !((cAliQr2)->(EOF()))
					
					Reclock("BFO", .T.)
					
					BFO->BFO_CODINT := (cAliQry)->BA1_CODINT
					BFO->BFO_CODEMP := (cAliQry)->BA1_CODEMP
					BFO->BFO_MATRIC := (cAliQry)->BA1_MATRIC
					BFO->BFO_TIPREG := (cAliQry)->BA1_TIPREG
					BFO->BFO_CLACAR := (cAliQr2)->BFO_CLACAR
					BFO->BFO_CARENC := (cAliQr2)->BFO_CARENC
					BFO->BFO_UNICAR := (cAliQr2)->BFO_UNICAR
					BFO->BFO_DATCAR := STOD((cAliQr2)->BFO_DATCAR)
					BFO->BFO_YRGIMP := (cAliQr2)->BFO_YRGIMP
					
					BFO->(MsUnLock())
					
					(cAliQr2)->(DbSkip())
					
				EndDo
				
				If Select(cAliQr2)>0
					(cAliQr2)->(DbCloseArea())
				EndIf
				
			EndIf
			
			//---------------------------------------------------------------------------------
			//Caso o beneficiï¿½rio tenho Carï¿½ncia no nivel da famï¿½lia na antiga matricula
			//ï¿½ necessï¿½rio criar na nova matricula igual esta na anterior
			//---------------------------------------------------------------------------------
			If AllTrim((cAliQr1)->FAMILIA) == "S"
				
				cQry := " SELECT													" 	+ CRLF
				cQry += " 	BFJ.BFJ_CLACAR,											" 	+ CRLF
				cQry += " 	BFJ.BFJ_CARENC,											" 	+ CRLF
				cQry += " 	BFJ.BFJ_UNICAR,											" 	+ CRLF
				cQry += " 	BFJ.BFJ_CAREDU											" 	+ CRLF
				cQry += " FROM														" 	+ CRLF
				cQry += " 	BFJ020 BFJ												" 	+ CRLF
				cQry += " WHERE														" 	+ CRLF
				cQry += " 	BFJ.BFJ_FILIAL      = '" + xFilial("BFJ") + "'			" 	+ CRLF
				cQry += " 	AND BFJ.BFJ_CODINT  = '" + (cAliQr1)->BA1_CODINT + "'	" 	+ CRLF
				cQry += " 	AND BFJ.BFJ_CODEMP  = '" + (cAliQr1)->BA1_CODEMP + "'	" 	+ CRLF
				cQry += " 	AND BFJ.BFJ_MATRIC  = '" + (cAliQr1)->BA1_MATRIC + "'	" 	+ CRLF
				cQry += " 	AND BFJ.D_E_L_E_T_ = ' '								" 	+ CRLF
				
				If Select(cAliQr3)>0
					(cAliQr3)->(DbCloseArea())
				EndIf
				
				DbUseArea(.T.,"TopConn",TcGenQry(,,cQry),cAliQr3,.T.,.T.)
				
				DbSelectArea(cAliQr3)
				
				While !((cAliQr3)->(EOF()))
					
					Reclock("BFJ", .T.)
					
					BFJ->BFJ_CODINT := (cAliQry)->BA1_CODINT
					BFJ->BFJ_CODEMP := (cAliQry)->BA1_CODEMP
					BFJ->BFJ_MATRIC := (cAliQry)->BA1_MATRIC
					BFJ->BFJ_CLACAR := (cAliQr3)->BFJ_CLACAR
					BFJ->BFJ_CARENC := (cAliQr3)->BFJ_CARENC
					BFJ->BFJ_UNICAR := (cAliQr3)->BFJ_UNICAR
					BFJ->BFJ_CAREDU := (cAliQr3)->BFJ_CAREDU
					
					BFJ->(MsUnLock())
					
					(cAliQr3)->(DbSkip())
					
				EndDo
				
				If Select(cAliQr3)>0
					(cAliQr3)->(DbCloseArea())
				EndIf
				
			EndIf
			
			//---------------------------------------------------------------------------------
			//Caso o beneficiï¿½rio tenho Carï¿½ncia no nivel do subcontrato na antiga matricula
			//ï¿½ necessï¿½rio criar na nova matricula igual esta na anterior
			//---------------------------------------------------------------------------------
			If AllTrim((cAliQr1)->SUBCON) $ "S"
				
				cQry := " SELECT													"	+ CRLF
				cQry += " 	BA6.BA6_CLACAR,											"	+ CRLF
				cQry += " 	BA6.BA6_CARENC,											"	+ CRLF
				cQry += " 	BA6.BA6_UNICAR,											"	+ CRLF
				cQry += " 	BA6.BA6_VERPRO,											"	+ CRLF
				cQry += " 	BA6.BA6_CAREDU											"	+ CRLF
				cQry += " FROM														"	+ CRLF
				cQry += " 	BA6020 BA6												"	+ CRLF
				cQry += " WHERE														"	+ CRLF
				cQry += " 	BA6.BA6_FILIAL  	= '" + xFilial("BA6") + "' 			"	+ CRLF
				cQry += " 	AND BA6.BA6_CODINT 	= '" + (cAliQr1)->BA1_CODINT + "' 	"	+ CRLF
				cQry += " 	AND BA6.BA6_NUMCON 	= '" + (cAliQr1)->BA1_CONEMP + "' 	"	+ CRLF
				cQry += " 	AND BA6.BA6_VERCON 	= '" + (cAliQr1)->BA1_VERCON + "' 	"	+ CRLF
				cQry += " 	AND BA6.BA6_SUBCON 	= '" + (cAliQr1)->BA1_SUBCON + "' 	"	+ CRLF
				cQry += " 	AND BA6.BA6_VERSUB 	= '" + (cAliQr1)->BA1_VERSUB + "' 	"	+ CRLF
				cQry += " 	AND BA6.BA6_CODPRO 	= '" + (cAliQr1)->BA1_CODPLA + "' 	"	+ CRLF
				cQry += " 	AND BA6.BA6_CODIGO 	= '" + (cAliQr1)->BA1_CODEMP + "' 	"	+ CRLF
				cQry += " 	AND BA6.D_E_L_E_T_ 	= ' '
				
				If Select(cAliQr4)>0
					(cAliQr4)->(DbCloseArea())
				EndIf
				
				DbUseArea(.T.,"TopConn",TcGenQry(,,cQry),cAliQr4,.T.,.T.)
				
				DbSelectArea(cAliQr4)
				
				While !((cAliQr4)->(EOF()))
					
					//----------------------------------------------------------------------------
					//Pesquisar na nova matricula se possui jï¿½ cadastrado para atualizar
					//----------------------------------------------------------------------------
					_aArBA6 := BA6->(GetArea())
					
					DbSelectArea("BA6")
					DbSetOrder(1)//BA6_FILIAL+BA6_CODINT+BA6_CODIGO+BA6_NUMCON+BA6_VERCON+BA6_SUBCON+BA6_VERSUB+BA6_CODPRO+BA6_VERPRO+BA6_CLACAR
					If DbSeek(xFilial("BA6") + (cAliQry)->(BA1_CODINT+BA1_CODEMP+BA1_CONEMP+BA1_VERCON+BA1_SUBCON+BA1_VERSUB+BA1_CODPLA)+"001"+(cAliQr4)->BA6_CLACAR)
						
						Reclock("BA6", .F.)
						
					Else
						
						Reclock("BA6", .T.)
						
					EndIf
					
					BA6->BA6_CODINT := (cAliQry)->BA1_CODINT
					BA6->BA6_CODIGO := (cAliQry)->BA1_CODEMP
					BA6->BA6_NUMCON := (cAliQry)->BA1_CONEMP
					BA6->BA6_VERCON := (cAliQry)->BA1_VERCON
					BA6->BA6_SUBCON := (cAliQry)->BA1_SUBCON
					BA6->BA6_VERSUB := (cAliQry)->BA1_VERSUB
					BA6->BA6_CODPRO := (cAliQry)->BA1_CODPLA
					BA6->BA6_VERPRO := (cAliQry)->BA1_VERSAO
					BA6->BA6_CLACAR := (cAliQr4)->BA6_CLACAR
					BA6->BA6_CARENC := (cAliQr4)->BA6_CARENC
					BA6->BA6_UNICAR := (cAliQr4)->BA6_UNICAR
					BA6->BA6_CAREDU := (cAliQr4)->BA6_CAREDU
					
					BA6->(MsUnLock())
					
					RestArea(_aArBA6)
					
					(cAliQr4)->(DbSkip())
					
				EndDo
				
				If Select(cAliQr4)>0
					(cAliQr4)->(DbCloseArea())
				EndIf
				
			EndIf
			
			//-------------------------------------------------------------------------------------------------
			//Apï¿½s ter realizado as atualizaï¿½ï¿½es
			//ï¿½ necessï¿½rio atualizar a data de carï¿½ncia conforme matricula anterios
			//-------------------------------------------------------------------------------------------------
			DbSelectArea("BA1")
			DbSetOrder(2) //BA1_FILIAL+BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG+BA1_DIGITO
			If DbSeek(xFIlial("BA1") + (cAliQry)->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG+BA1_DIGITO))
				
				Reclock("BA1", .F.)
				
				BA1->BA1_DATCAR := STOD((cAliQr1)->BA1_DATCAR)
				
				BA1->(MsUnLock())
				
			EndIf
			
			RestArea(_aArBA1)
			RestArea(_aArBFO)
			RestArea(_aArBFJ)
			RestArea(_aArBA6)
			
			(cAliQr1)->(DbSkip())
			
		EndDo
		
		If Select(cAliQr1)>0
			(cAliQr1)->(DbCloseArea())
		EndIf
		
		(cAliQry)->(DbSkip())
		
	EndDo
	
	If Select(cAliQry)>0
		(cAliQry)->(DbCloseArea())
	EndIf
	
	RestArea(_aArea)
	
Return


//-------------------------------------------------------------------
/*/{Protheus.doc} function RetTpReg
Rotina para validar se o BA1_TIPREG  esta em uso e assim
@author  author
@since   date
@version version
/*/
//-------------------------------------------------------------------
Static Function RetTpReg(_cMatric, _cTipReg)
	
	Local _cRet 	:= ""
	Local _lAchou	:= .T.
	Local _aArea	:= GetArea()
	Local _aArBa1	:= BA1->(GetArea())
	
	Default _cMatric := ""
	Default _cTipReg := ""
	
	While _lAchou
		
		DbSelectArea("BA1")
		DbSetOrder(2)
		IF !(DBSEEK( xFilial("BA1") + _cMatric + _cTipReg  ))
			
			_lAchou := .F.
			_cRet	:= _cTipReg
			
		ELSE
			
			_cTipReg := SOMA1( _cTipReg )
			
		ENDIF
		
	ENDDO
	
	RestArea(_aArBa1)
	RestArea(_aArea	)
	
Return _cRet
