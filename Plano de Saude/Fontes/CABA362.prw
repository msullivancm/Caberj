#include 'protheus.ch'
#include 'parmtype.ch'
#include 'totvs.ch'
#INCLUDE 'topconn.ch'
#INCLUDE 'Tbiconn.ch' 

#DEFINE c_ent CHR(13) + CHR(10)

user function CABA362()
	Local aSize   := {}
	Local bOk     := {||oDialog:End()}
	Local bCancel := {||oDialog:End()}
	Local cTitulo := "PROJETO TABELAS CBHPM 2019/2020" 
	Private oGetOpcao
	Private cGetOpcao := '1'
	Private oGetPrest
	Private cGetPrest := '      '
	Private oDialog

	aSize := MsAdvSize(.F.)
	/*
	MsAdvSize (http://tdn.totvs.com/display/public/mp/MsAdvSize+-+Dimensionamento+de+Janelas)
	aSize[1] = 1 -> Linha inicial área trabalho.
	aSize[2] = 2 -> Coluna inicial área trabalho.
	aSize[3] = 3 -> Linha final área trabalho.
	aSize[4] = 4 -> Coluna final área trabalho.
	aSize[5] = 5 -> Coluna final dialog (janela).
	aSize[6] = 6 -> Linha final dialog (janela).
	aSize[7] = 7 -> Linha inicial dialog (janela).
	*/
	Define MsDialog oDialog TITLE cTitulo STYLE DS_MODALFRAME From aSize[7],0 To aSize[6],aSize[5] OF oMainWnd PIXEL
	//Se não utilizar o MsAdvSize, pode-se utilizar a propriedade lMaximized igual a T para maximizar a janela
	//oDialog:lMaximized := .T. //Maximiza a janela
	//Usando o estilo STYLE DS_MODALFRAME, remove o botão X

	@ 048,018 GROUP oGroup1 TO 078, 300 OF oDialog COLOR 0, 16777215 PIXEL
	@ 050,020 Say " Este programa exportará os cadastros das especialidades da tabela BBM (Especialidades Medicas) para a    "  SIZE 300,010 PIXEL OF oDialog 
	@ 060,020 Say " tabela BC0 (Procedimentos Autoizados) de cada prestador identificado com a(s) mesma(s) especialidade(s)  "  SIZE 300,010 PIXEL OF oDialog 
	@ 070,020 Say " e já limpará os valores de CH para atuação da NOVA Tabela de Preço.										 "  SIZE 300,010 PIXEL OF oDialog 	

	@ 080,018 GROUP oGroup2 TO 112,300 OF oDialog COLOR 0, 16777215 PIXEL	
	@ 082,020 SAY " 1 - BBM ===> BC0 " SIZE 300,010 PIXEL OF oDialog 
	//@ 092,020 SAY " 2 - BC0 ===> BBM " SIZE 300,010 PIXEL OF oDialog 
	//@ 102,020 SAY " 3 - EXCLUIR BC0 TEMPORARIA " SIZE 300,010 PIXEL OF oDialog
	@ 125,020 SAY " Selecione Prestador ===> " SIZE 300,010 PIXEL OF oDialog
	@ 121,090 MSGET oGetPrest VAR cGetPrest PICTURE "@!"  SIZE 020,010 PIXEL OF oDialog F3 "BAUPLS" VALID !EMPTY(cGetPrest)
	@ 140,020 SAY " Selecione Opção     ===> " SIZE 300,010 PIXEL OF oDialog
	@ 136,090 MSGET oGetOpcao VAR cGetOpcao PICTURE "@!"  SIZE 010,010 PIXEL OF oDialog VALID !EMPTY(cGetOpcao)
	@ 136,140 BUTTON "PROCESSAR >>>" SIZE 080, 010 PIXEL OF oDialog ACTION (executa(cGetPrest,cGetOpcao))

	ACTIVATE MSDIALOG oDialog ON INIT EnchoiceBar(oDialog, bOk , bCancel) CENTERED	
return

static function executa(cCodRDA, cOpcao)
	private oProcess := MsNewProcess():New({||processa(cCodRDA,cOpcao)},"Processando...","",.F.)
	oProcess:Activate()
return .T.

static function processa(cCodRDA, cOpcao) 

	Local cSql     	  := ''
	Local aESPEC   	  := {}
	Local aPrest	  := {}
	Local nX
	Local nCont	   	  := 1
	Local cAliasQRY   := "TMPQRY"
	Private _cCodRDA  := cCodRDA

	oProcess:SetRegua1(0)
	oProcess:SetRegua2(0)

	If cOpcao == '1'

		If Empty(cCodRDA)
			Alert('Campo Prestador em Branco!!! Favor preencher')
		Else
			DbSelectArea("PDT")
			PDT->(DbSetOrder(7))
			If DbSeek(xFilial("PDT")+cCodRDA)
				Alert('Parametros para este Prestador Já Migrados.  Não é possível refazer o processo!')
			Else
				If MsgYesNo('Carrega tabela BBM - Especialidades para BC0 - Procedimentos Autorizados? Processo Irreversível!','PROJETO TABELAS CBHPM')

					//QUERY 1 - DESCOBRIR QUAIS ESPECIALIDADES O PRESTADOR POSSUI
					cSql := " SELECT DISTINCT  					  " 	+ c_ent
					cSql += "        BAU_CODIGO  				  " 	+ c_ent
					cSql += "      , TRIM(BAU_NOME) BAU_NOME	  " 	+ c_ent
					cSql += "      , BAQ_CODESP  				  " 	+ c_ent
					cSql += "      , TRIM(BAQ_DESCRI) BAQ_DESCRI  " 	+ c_ent    
					cSql += "  FROM " + RetSqlName("BAU") + " BAU "		+ c_ent 
					cSql += "     , " + RetSqlName("BBF") + " BBF "		+ c_ent
					cSql += "     , " + RetSqlName("BAQ") + " BAQ "		+ c_ent
					cSql += "     , " + RetSqlName("BBM") + " BBM "		+ c_ent
					cSql += " WHERE BAU_FILIAL = '"+ xFilial("BAU") +"'" + c_ent
					cSql += "   AND BBF_FILIAL = '"+ xFilial("BBF") +"'" + c_ent
					cSql += "   AND BAQ_FILIAL = '"+ xFilial("BAQ") +"'" + c_ent
					cSql += "   AND BBM_FILIAL = '"+ xFilial("BBM") +"'" + c_ent
					cSql += "   AND BAU_CODIGO = '"+cCodRDA+"' "		+ c_ent
					cSql += "   AND BAU_CODIGO = BBF_CODIGO "			+ c_ent
					cSql += "   AND BBF_CODINT = BAQ_CODINT "			+ c_ent
					cSql += "   AND BBF_CODINT = BBM_CODINT "			+ c_ent
					cSql += "   AND BAQ_CODINT = BBM_CODINT "			+ c_ent
					cSql += "   AND BBF_CDESP  = BAQ_CODESP "			+ c_ent
					cSql += "   AND BBF_CDESP  = BBM_CODESP "			+ c_ent
					cSql += "   AND BAQ_CODESP = BBM_CODESP "			+ c_ent
					cSql += "   AND BAU_DATBLO = ' '	 	"			+ c_ent
					cSql += "   AND BBF_DATBLO = ' '	 	"			+ c_ent
					cSql += "   AND BAU.D_E_L_E_T_ = ' ' 	"			+ c_ent
					cSql += "   AND BBF.D_E_L_E_T_ = ' ' 	"			+ c_ent
					cSql += "   AND BBM.D_E_L_E_T_ = ' ' 	"			+ c_ent
					cSql += "ORDER BY BAU_CODIGO, BAU_NOME, BAQ_CODESP, BAQ_DESCRI "	+ c_ent

					DbUseArea(.T.,"TOPCONN",TcGenQry(,,cSql),cAliasQRY,.T.,.T.) 

					DBSELECTAREA(cAliasQRY)

					DbGoTop()

					If !(cAliasQRY)->(EOF())  

						While !(cAliasQRY)->(EOF())
							aAdd(aEspec,{(cAliasQRY)->BAU_CODIGO,(cAliasQRY)->BAU_NOME,(cAliasQRY)->BAQ_CODESP,(cAliasQRY)->BAQ_DESCRI})
							(cAliasQRY)->(DbSkip())
						Enddo

					Endif

					(cAliasQRY)->(DbCloseArea())

					If !Empty(aEspec)
						oProcess:SetRegua1(4)
						//Copiar BBM encontrada para tabela de Backup, levando RECNO da BAQ
						oProcess:IncRegua1("Backup Especialidades BBM >>> PDS ")
						BACKUPBBM(aEspec)
						//Buscar todos os RDA´s com as mesmas especialidades
						oProcess:IncRegua1("Busca prestador com mesma especialidade")
						aPrest := BUSCARDA(aEspec)
						//Copiar BBM para BC0 de cada RDA encontrada
						oProcess:IncRegua1("Copia Proc.Autor./Monta espec.")
						COPIABBM(aPrest)
						//Limpar Parametro de CH das especialidades
						oProcess:IncRegua1("Limpar Parametro de CH das especialidades ")
						ZERARCHBBM(aEspec)
					Endif
					ALERT("Processo de Migração Concluído com Sucesso!")
				Endif
				PDT->(DbCloseArea())
			Endif		
		Endif
	Endif

	
return

//FUNÇÃO BACKUPBBM
//Realiza o Backup das BBM´s encontradas para o prestador selecionado
STATIC FUNCTION BACKUPBBM(aEspec)
	Local nX := 0
	Local cSql := ""
	Local lRecLockPDS := .F.
	Local cAliasQRY2  := "TMPQRY2"
	Local nCont  := 0
	Local cTot   := ""

	For nX := 1 to Len(aEspec)

		//QUERY 2 - PERCORRER OS PROCEDIMENTOS HABILITADOS NA TABELA BBM PARA CADA ESPECIALIDADE ENCONTRADA NA BBF E BAQ 		
		cSql := " SELECT   BAU_CODIGO		 				"	+ c_ent
		cSql += " 	     , TRIM(BAU_NOME) BAU_NOME 			"	+ c_ent
		cSql += " 	     , BAQ_CODINT 						"	+ c_ent
		cSql += " 	     , BAQ_CODESP 						"	+ c_ent
		cSql += "	     , TRIM(BAQ_DESCRI) BAQ_DESCRI 		"	+ c_ent
		cSql += "	     , BAQ.RECNO RECBAQ 				"	+ c_ent
		cSql += "	     , BBM_FILIAL 						"	+ c_ent
		cSql += "	     , BBM_CODPAD 						"	+ c_ent
		cSql += "	     , TRIM(BBM_CODPSA) BBM_CODPSA 		"	+ c_ent
		cSql += "	     , BBM_NIVEL 						"	+ c_ent
		cSql += "	     , BBM_CDNV01						"	+ c_ent
		cSql += "	     , BBM_CDNV02						"	+ c_ent
		cSql += "	     , BBM_CDNV03						"	+ c_ent
		cSql += "	     , BBM_CDNV04						"	+ c_ent
		cSql += "	     , BBM_TIPO 						"	+ c_ent
		cSql += "	     , BBM_DATVAL 						"	+ c_ent
		cSql += "	     , BBM_ATIVO 						"	+ c_ent
		cSql += "	     , BBM_VALREA 						"	+ c_ent
		cSql += "	     , BBM_VALCH 						"	+ c_ent
		cSql += "	     , BBM_SUBSID 						"	+ c_ent
		cSql += "	     , BBM_MESUSR 						"	+ c_ent
		cSql += "	     , BBM_PERIOD 						"	+ c_ent
		cSql += "	     , BBM_PERDES 						"	+ c_ent
		cSql += "	     , BBM_UNPER  						"	+ c_ent
		cSql += "	     , BBM_PERACR 						"	+ c_ent
		cSql += "	     , BBM_BANDA  						"	+ c_ent
		cSql += "	     , BBM_UCO    						"	+ c_ent
		cSql += "	     , BBM_DIFIDA 						"	+ c_ent
		cSql += "	     , BBM.R_E_C_N_O_ RECBBM   			"	+ c_ent   
		cSql += "	  FROM " + RetSqlName("BAU") + " BAU 	"   + c_ent
		cSql += "	     , " + RetSqlName("BBF") + " BBF	"	+ c_ent
		cSql += "	     , (SELECT BAQ_ACAO 				"	+ c_ent
		cSql += "	             , BAQ_ANIVER 				"	+ c_ent
		cSql += "	             , BAQ_AOINT 				"	+ c_ent
		cSql += "	             , BAQ_BANDA 				"	+ c_ent
		cSql += "	             , BAQ_CODANT 				"	+ c_ent
		cSql += "	             , BAQ_CODESP 				"	+ c_ent
		cSql += "	             , BAQ_CODINT 				"	+ c_ent
		cSql += "	             , BAQ_CODPAD 				"	+ c_ent
		cSql += "	             , BAQ_CODPSA 				"	+ c_ent
		cSql += "	             , BAQ_DESCRI 				"	+ c_ent
		cSql += "	             , BAQ_DESGUI 				"	+ c_ent
		cSql += "	             , BAQ_DTINT 				"	+ c_ent
		cSql += "	             , BAQ_ENVGUI 				"	+ c_ent
		cSql += "	             , BAQ_ESPCFM 				"	+ c_ent
		cSql += "	             , BAQ_ESPSIP 				"	+ c_ent
		cSql += "	             , BAQ_ESPSP2 				"	+ c_ent
		cSql += "	             , BAQ_FILIAL 				"	+ c_ent
		cSql += "	             , BAQ_IDAMAX 				"	+ c_ent
		cSql += "	             , BAQ_IDAMIN 				"	+ c_ent
		cSql += "	             , BAQ_INTERC 				"	+ c_ent
		cSql += "	             , BAQ_REFIGH 				"	+ c_ent
		cSql += "	             , BAQ_SEXO 				"	+ c_ent
		cSql += "	             , BAQ_UCO 					"	+ c_ent
		cSql += "	             , BAQ_VALCH 				"	+ c_ent
		cSql += "	             , BAQ_YDIVUL 				"	+ c_ent
		cSql += "	             , BAQ_YGPESP 				"	+ c_ent
		cSql += "	             , BAQ_YINDIC 				"	+ c_ent
		cSql += "	             , BAQ_YTIPO 				"	+ c_ent
		cSql += "	             , BAQ_YUSO 				"	+ c_ent
		cSql += "	             , MAX(R_E_C_N_O_) RECNO 	"	+ c_ent
		cSql += "	          FROM " + RetSqlName("BAQ") + " BAQ "			+ c_ent
		cSql += "	         WHERE BAQ_FILIAL = '" + xFilial("BAQ") +"' "	+ c_ent
		cSql += "	           AND D_E_L_E_T_ = ' ' 		"	+ c_ent
		cSql += "	         GROUP BY BAQ_ACAO 				"		+ c_ent
		cSql += "	             , BAQ_ANIVER 				"	+ c_ent
		cSql += "	             , BAQ_AOINT 				"	+ c_ent
		cSql += "	             , BAQ_BANDA 				"	+ c_ent
		cSql += "	             , BAQ_CODANT 				"	+ c_ent
		cSql += "	             , BAQ_CODESP 				"	+ c_ent
		cSql += "	             , BAQ_CODINT 				"	+ c_ent
		cSql += "	             , BAQ_CODPAD 				"	+ c_ent
		cSql += "	             , BAQ_CODPSA 				"	+ c_ent
		cSql += "	             , BAQ_DESCRI 				"	+ c_ent
		cSql += "	             , BAQ_DESGUI 				"	+ c_ent
		cSql += "	             , BAQ_DTINT 				"	+ c_ent
		cSql += "	             , BAQ_ENVGUI 				"	+ c_ent
		cSql += "	             , BAQ_ESPCFM 				"	+ c_ent
		cSql += "	             , BAQ_ESPSIP 				"	+ c_ent
		cSql += "	             , BAQ_ESPSP2 				"	+ c_ent
		cSql += "	             , BAQ_FILIAL 				"	+ c_ent
		cSql += "	             , BAQ_IDAMAX 				"	+ c_ent
		cSql += "	             , BAQ_IDAMIN 				"	+ c_ent
		cSql += "	             , BAQ_INTERC 				"	+ c_ent
		cSql += "	             , BAQ_REFIGH 				"	+ c_ent
		cSql += "	             , BAQ_SEXO 				"	+ c_ent
		cSql += "	             , BAQ_UCO 					"	+ c_ent
		cSql += "	             , BAQ_VALCH 				"	+ c_ent
		cSql += "	             , BAQ_YDIVUL 				"	+ c_ent
		cSql += "	             , BAQ_YGPESP 				"	+ c_ent
		cSql += "	             , BAQ_YINDIC 				"	+ c_ent
		cSql += "	             , BAQ_YTIPO 				"	+ c_ent
		cSql += "	             , BAQ_YUSO) BAQ 			"	+ c_ent
		cSql += "	     , " + RetSqlName("BBM") + " BBM 	" 	+ c_ent
		cSql += "	 WHERE BAU_FILIAL = '" + xFilial("BAU") + "' "	+ c_ent
		cSql += "	   AND BBF_FILIAL = '" + xFilial("BBF") + "' "	+ c_ent
		cSql += "	   AND BAQ_FILIAL = '" + xFilial("BAQ") + "' "	+ c_ent
		cSql += "	   AND BBM_FILIAL = '" + xFilial("BBM") + "' "	+ c_ent
		cSql += "	   AND BAU_CODIGO = '" + aEspec[nX,1] 	+ "'"	+ c_ent
		cSql += "	   AND BBF_CDESP  = '" + aEspec[nX,3] 	+ "'"	+ c_ent
		cSql += "	   AND BAU_CODIGO = BBF_CODIGO 			"	+ c_ent
		cSql += "	   AND BBF_CODINT = BAQ_CODINT 			"	+ c_ent
		cSql += "	   AND BBF_CODINT = BBM_CODINT 			"	+ c_ent
		cSql += "	   AND BAQ_CODINT = BBM_CODINT 			"	+ c_ent
		cSql += "	   AND BBF_CDESP  = BAQ_CODESP 			"	+ c_ent
		cSql += "	   AND BBF_CDESP  = BBM_CODESP 			"	+ c_ent
		cSql += "	   AND BAQ_CODESP = BBM_CODESP 			"	+ c_ent
		cSql += "	   AND BBM_ATIVO  = '1' 				"	+ c_ent
		cSql += "	   AND BAU_DATBLO = ' ' 				"	+ c_ent
		cSql += "	   AND BBF_DATBLO = ' ' 				"	+ c_ent
		cSql += "	   AND BAU.D_E_L_E_T_ = ' ' 			"	+ c_ent
		cSql += "	   AND BBF.D_E_L_E_T_ = ' ' 			"	+ c_ent
		cSql += "	   AND BBM.D_E_L_E_T_ = ' ' 			"	+ c_ent
		cSql += "	   AND BBM.R_E_C_N_O_ = (SELECT MAX(R_E_C_N_O_)  "	+ c_ent
		cSql += "	                           FROM " + RetSqlName("BBM") + " BBM2 "	+ c_ent
		cSql += "	                          WHERE BBM2.BBM_FILIAL = '" + xFilial("BBM") + "' "	+ c_ent
		cSql += "	                            AND BBM2.BBM_CODINT = BBM.BBM_CODINT "	+ c_ent
		cSql += "	                            AND BBM2.BBM_CODESP = BBM.BBM_CODESP "	+ c_ent
		cSql += "	                            AND BBM2.BBM_CODPAD = BBM.BBM_CODPAD "	+ c_ent
		cSql += "	                            AND BBM2.BBM_CODPSA = BBM.BBM_CODPSA "	+ c_ent
		cSql += "	                            AND BBM2.BBM_DATVAL = BBM.BBM_DATVAL "	+ c_ent
		cSql += "	                            AND BBM2.BBM_ATIVO  = '1')			 "	+ c_ent
		//cSql += "	ORDER BY BAU_CODIGO, BAQ_CODESP, BBM_CODPAD, BBM_CODPSA, BBM_DATVAL ASC "	+ c_ent
		cSql += "	ORDER BY BAQ_CODESP, BBM_CODPAD, BBM_CODPSA, BBM_DATVAL ASC "	+ c_ent

		If Select (cAliasQRY2) > 0
			(cAliasQRY2)->(DbCloseArea())
			cAliasQRY2 := 'TMPQRY2'
		Endif

		DbUseArea(.T.,"TOPCONN",TcGenQry(,,cSql),cAliasQRY2,.T.,.T.) 

		DBSELECTAREA(cAliasQRY2)

		nCont := 0

		COUNT TO nCont

		DbGoTop()

		oProcess:SetRegua2(nCont)

		cTot 	:=  allTrim(Transform(nCont, "@E 999,999,999,999")) 
		nCont 	:= 0

		If !(cAliasQRY2)->(EOF())  

			While !(cAliasQRY2)->(EOF())
				oProcess:IncRegua2("Backup BBM >>> PDS. Espec.: " + (cAliasQRY2)->BAQ_CODESP + " " + allTrim(Transform(++nCont, "@E 999,999,999,999")) + ' de ' + cTot )

				PDS->(DbSetOrder(1))
				If PDS->(DbSeek(xFilial("PDS") + (cAliasQRY2)->BAQ_CODINT + (cAliasQRY2)->BAQ_CODESP + (cAliasQRY2)->BBM_CODPAD + (cAliasQRY2)->BBM_CODPSA))
					lRecLockPDS := .F.
				Else
					PDS->(DbSetOrder(2))
					If PDS->(DbSeek(xFilial("PDS") + (cAliasQRY2)->BAQ_CODINT + (cAliasQRY2)->BAQ_CODESP + (cAliasQRY2)->BBM_CODPAD + (cAliasQRY2)->BBM_CODPSA))
						lRecLockPDS := .F.
					Else
						PDS->(DbSetOrder(3))
						If PDS->(DbSeek(xFilial("PDS") + (cAliasQRY2)->BAQ_CODINT + (cAliasQRY2)->BAQ_CODESP + (cAliasQRY2)->BBM_CODPAD + (cAliasQRY2)->BBM_CODPSA))
							lRecLockPDS := .F.
						Else
							PDS->(DbSetOrder(4))
							If PDS->(DbSeek(xFilial("PDS") + (cAliasQRY2)->BAQ_CODINT + (cAliasQRY2)->BAQ_CODESP + (cAliasQRY2)->BBM_CODPAD + (cAliasQRY2)->BBM_CODPSA))
								lRecLockPDS := .F.
							Else
								PDS->(DbSetOrder(5))
								If PDS->(DbSeek(xFilial("PDS") + (cAliasQRY2)->BAQ_CODINT + (cAliasQRY2)->BAQ_CODESP + (cAliasQRY2)->BBM_CODPAD + (cAliasQRY2)->BBM_CODPSA))
									lRecLockPDS := .F.
								Else
									lRecLockPDS := .T.
								Endif
							Endif
						Endif
					Endif
				Endif
				//GRAVAR COPIA DA BBM ORIGINAL EM PDS(TABELA ESPELHO)
				//GRAVANDO AINDA O RECNO DE BAQ PORQUE ALGUNS CAMPOS SERÃO MEXIDOS MANUALMENTE
				PDS->(Reclock("PDS",lRecLockPDS))

				PDS->PDS_FILIAL := xFilial("PDS")
				PDS->PDS_CODINT := (cAliasQRY2)->BAQ_CODINT
				PDS->PDS_CODESP := (cAliasQRY2)->BAQ_CODESP
				PDS->PDS_CODPSA := (cAliasQRY2)->BBM_CODPSA
				PDS->PDS_NIVEL  := (cAliasQRY2)->BBM_NIVEL
				PDS->PDS_TIPO   := (cAliasQRY2)->BBM_TIPO
				If !Empty((cAliasQRY2)->BBM_DATVAL)
					PDS->PDS_DATVAL := STOD((cAliasQRY2)->BBM_DATVAL)
				Endif
				PDS->PDS_ATIVO  := (cAliasQRY2)->BBM_ATIVO
				PDS->PDS_CODPAD := (cAliasQRY2)->BBM_CODPAD
				PDS->PDS_CDNV01 := (cAliasQRY2)->BBM_CDNV01
				PDS->PDS_CDNV02 := (cAliasQRY2)->BBM_CDNV02
				PDS->PDS_CDNV03 := (cAliasQRY2)->BBM_CDNV03
				PDS->PDS_CDNV04 := (cAliasQRY2)->BBM_CDNV04
				PDS->PDS_SUBSID := (cAliasQRY2)->BBM_SUBSID
				PDS->PDS_VALREA := (cAliasQRY2)->BBM_VALREA
				PDS->PDS_VALCH  := (cAliasQRY2)->BBM_VALCH
				PDS->PDS_MESUSR := (cAliasQRY2)->BBM_MESUSR
				PDS->PDS_PERIOD := (cAliasQRY2)->BBM_PERIOD
				PDS->PDS_PERDES := (cAliasQRY2)->BBM_PERDES
				PDS->PDS_UNPER  := (cAliasQRY2)->BBM_UNPER
				PDS->PDS_PERACR := (cAliasQRY2)->BBM_PERACR
				PDS->PDS_BANDA  := (cAliasQRY2)->BBM_BANDA
				PDS->PDS_UCO    := (cAliasQRY2)->BBM_UCO
				PDS->PDS_DIFIDA := (cAliasQRY2)->BBM_DIFIDA
				PDS->PDS_RECBAQ := (cAliasQRY2)->RECBAQ
				PDS->PDS_RECBBM := (cAliasQRY2)->RECBBM 

				PDS->(MsUnlock())

				(cAliasQRY2)->(DbSkip())
			Enddo

		Endif

	Next nX

	(cAliasQRY2)->(DbCloseArea())
Return

//FUNÇÃO BUSCARDA
//Realiza a busca das RDA´s que possuam as mesmas especialidades
STATIC FUNCTION BUSCARDA(aEspec)
	Local nX := 0
	Local cSql := ""
	Local aPrest := {}
	Local cAliasQRY3  := "TMPQRY3"
	Local nCont  := 0
	Local cTot   := ""

	For nX := 1 to Len(aEspec)

		//QUERY 3 - DESCOBRIR PRESTADORES COM A MESMA ESPECIALIDADE
		cSql := " SELECT DISTINCT  					  " 	+ c_ent
		cSql += "        BAU_CODIGO  				  " 	+ c_ent
		cSql += "      , TRIM(BAU_NOME) BAU_NOME	  " 	+ c_ent
		cSql += "      , BB8_CODLOC
		cSql += "      , BB8_LOCAL
		cSql += "      , BB8_DESLOC
		cSql += "      , BAQ_CODESP  				  " 	+ c_ent
		cSql += "      , TRIM(BAQ_DESCRI) BAQ_DESCRI  " 	+ c_ent    
		cSql += "  FROM " + RetSqlName("BAU") + " BAU "		+ c_ent 
		cSql += "     , " + RetSqlName("BBF") + " BBF "		+ c_ent
		cSql += "     , " + RetSqlName("BB8") + " BB8 "		+ c_ent
		cSql += "     , " + RetSqlName("BAX") + " BAX "		+ c_ent
		cSql += "     , " + RetSqlName("BAQ") + " BAQ "		+ c_ent
		cSql += "     , " + RetSqlName("BBM") + " BBM "		+ c_ent
		cSql += " WHERE BAU_FILIAL = '"+ xFilial("BAU") +"'" + c_ent
		cSql += "   AND BBF_FILIAL = '"+ xFilial("BBF") +"'" + c_ent
		cSql += "   AND BAQ_FILIAL = '"+ xFilial("BAQ") +"'" + c_ent
		cSql += "   AND BBM_FILIAL = '"+ xFilial("BBM") +"'" + c_ent
		cSql += "   AND BAU_CODIGO <> '"+ aEspec[nX,1]   +"' " + c_ent
		cSql += "	AND BBF_CDESP  = '"+ aEspec[nX,3] + "'" + c_ent
		cSql += "	AND BBM_ATIVO  = '1' 				   " + c_ent
		cSql += "   AND BAU_CODIGO = BBF_CODIGO "			 + c_ent
		cSql += "   AND BAU_CODIGO = BB8_CODIGO "			 + c_ent
		cSql += "   AND BAU_CODIGO = BAX_CODIGO "			 + c_ent
		cSql += "   AND BB8_CODIGO = BAX_CODIGO "			 + c_ent
		cSql += "   AND BB8_CODLOC = BAX_CODLOC "			 + c_ent
		cSql += "   AND BBF_CDESP  = BAX_CODESP "			 + c_ent
		cSql += "   AND BBF_CODINT = BAQ_CODINT "			 + c_ent
		cSql += "   AND BBF_CODINT = BBM_CODINT "			 + c_ent
		cSql += "   AND BAQ_CODINT = BBM_CODINT "			 + c_ent
		cSql += "   AND BBF_CDESP  = BAQ_CODESP "			 + c_ent
		cSql += "   AND BBF_CDESP  = BBM_CODESP "			 + c_ent
		cSql += "   AND BAQ_CODESP = BBM_CODESP "			 + c_ent
		cSql += "   AND BAU_DATBLO = ' '	 	"			 + c_ent
		cSql += "   AND BBF_DATBLO = ' '	 	"			 + c_ent
		cSql += "   AND BB8_DATBLO = ' '	 	"			 + c_ent
		cSql += "   AND BAX_DATBLO = ' '	 	"			 + c_ent
		cSql += "   AND BAU.D_E_L_E_T_ = ' ' 	"			 + c_ent
		cSql += "   AND BBF.D_E_L_E_T_ = ' ' 	"			 + c_ent
		cSql += "   AND BB8.D_E_L_E_T_ = ' ' 	"			 + c_ent
		cSql += "   AND BAX.D_E_L_E_T_ = ' ' 	"			 + c_ent		
		cSql += "   AND BBM.D_E_L_E_T_ = ' ' 	"			 + c_ent
		cSql += "ORDER BY BAU_CODIGO, BAU_NOME, BAQ_CODESP " + c_ent

		DbUseArea(.T.,"TOPCONN",TcGenQry(,,cSql),cAliasQRY3,.T.,.T.) 

		DBSELECTAREA(cAliasQRY3)

		nCont := 0

		COUNT TO nCont

		DbGoTop()

		oProcess:SetRegua2(nCont)

		cTot 	:=  allTrim(Transform(nCont, "@E 999,999,999,999")) 
		nCont 	:= 0

		If !(cAliasQRY3)->(EOF())  

			While !(cAliasQRY3)->(EOF())
				oProcess:IncRegua2("Prestadores de Mesmas Espec. " + allTrim(Transform(++nCont, "@E 999,999,999,999")) + ' de ' + cTot )

				aAdd(aPrest,{(cAliasQRY3)->BAU_CODIGO,(cAliasQRY3)->BAU_NOME,(cAliasQRY3)->BB8_CODLOC,(cAliasQRY3)->BB8_LOCAL,(cAliasQRY3)->BB8_DESLOC,(cAliasQRY3)->BAQ_CODESP,(cAliasQRY3)->BAQ_DESCRI})
				(cAliasQRY3)->(DbSkip())
			Enddo

		Endif

		(cAliasQRY3)->(DbCloseArea())

	Next nX

Return aPrest

//FUNÇÃO COPIABBM
//Realiza cópia das BBM´s encontradas para as BC0´s dos prestadores encontrados. 
STATIC FUNCTION COPIABBM(aPrest)
	Local nX := 0
	Local cSql  := ""
	Local cSql2 := ""
	Local lRecLockPDT := .F.
	Local cPrestAnt := ""
	Local cAliasQRY4 := "TMPQRY4"
	Local cAliasQRY5 := "TMPQRY5"
	Local nCont  := 0
	Local cTot   := ""

	/* 
	ESTRUTURA DO ARRAY aPREST 
	aPrest [1] = (cAliasQRY3)->BAU_CODIGO
	aPrest [2] = (cAliasQRY3)->BAU_NOME
	aPrest [3] = (cAliasQRY3)->BAU_CODLOC
	aPrest [4] = (cAliasQRY3)->BAU_LOCAL
	aPrest [5] = (cAliasQRY3)->BAU_DESLOC
	aPrest [6] = (cAliasQRY3)->BAQ_CODESP
	aPrest [7] = (cAliasQRY3)->BAQ_DESCRI
	*/
	For nX := 1 to Len(aPrest)

		//QUERY 2 - PERCORRER OS PROCEDIMENTOS HABILITADOS NA TABELA BBM PARA CADA ESPECIALIDADE ENCONTRADA NA BBF E BAQ 		
		cSql := " SELECT   BBM_CODINT 						"	+ c_ent
		cSql += " 	     , BBM_CODESP 						"	+ c_ent
		cSql += "	     , BBM_FILIAL 						"	+ c_ent
		cSql += "	     , BBM_CODPAD 						"	+ c_ent
		cSql += "	     , TRIM(BBM_CODPSA) BBM_CODPSA 		"	+ c_ent
		cSql += "	     , BBM_NIVEL 						"	+ c_ent
		cSql += "	     , BBM_CDNV01						"	+ c_ent
		cSql += "	     , BBM_CDNV02						"	+ c_ent
		cSql += "	     , BBM_CDNV03						"	+ c_ent
		cSql += "	     , BBM_CDNV04						"	+ c_ent
		cSql += "	     , BBM_TIPO 						"	+ c_ent
		cSql += "	     , BBM_DATVAL 						"	+ c_ent
		cSql += "	     , BBM_ATIVO 						"	+ c_ent
		cSql += "	     , BBM_VALREA 						"	+ c_ent
		cSql += "	     , BBM_VALCH 						"	+ c_ent
		cSql += "	     , BBM_SUBSID 						"	+ c_ent
		cSql += "	     , BBM_MESUSR 						"	+ c_ent
		cSql += "	     , BBM_PERIOD 						"	+ c_ent
		cSql += "	     , BBM_PERDES 						"	+ c_ent
		cSql += "	     , BBM_UNPER  						"	+ c_ent
		cSql += "	     , BBM_PERACR 						"	+ c_ent
		cSql += "	     , BBM_BANDA  						"	+ c_ent
		cSql += "	     , BBM_UCO    						"	+ c_ent
		cSql += "	     , BBM_DIFIDA 						"	+ c_ent
		cSql += "	     , BBM.R_E_C_N_O_ RECBBM   			"	+ c_ent   
		cSql += "	  FROM " + RetSqlName("BBM") + " BBM 	" 	+ c_ent
		cSql += "	 WHERE BBM_FILIAL = '" + xFilial("BBM") + "' "	+ c_ent
		cSql += "	   AND BBM_CODESP = '" + aPrest[nX,6] 	+ "'"	+ c_ent
		cSql += "	   AND BBM_ATIVO  = '1' 				"	+ c_ent
		cSql += "	   AND BBM.D_E_L_E_T_ = ' ' 			"	+ c_ent
		cSql += "	   AND BBM.R_E_C_N_O_ = (SELECT MAX(R_E_C_N_O_)  "	+ c_ent
		cSql += "	                           FROM " + RetSqlName("BBM") + " BBM2 "	+ c_ent
		cSql += "	                          WHERE BBM2.BBM_FILIAL = '" + xFilial("BBM") + "' "	+ c_ent
		cSql += "	                            AND BBM2.BBM_CODINT = BBM.BBM_CODINT "	+ c_ent
		cSql += "	                            AND BBM2.BBM_CODESP = BBM.BBM_CODESP "	+ c_ent
		cSql += "	                            AND BBM2.BBM_CODPAD = BBM.BBM_CODPAD "	+ c_ent
		cSql += "	                            AND BBM2.BBM_CODPSA = BBM.BBM_CODPSA "	+ c_ent
		cSql += "	                            AND BBM2.BBM_DATVAL = BBM.BBM_DATVAL "	+ c_ent
		cSql += "	                            AND BBM2.BBM_ATIVO  = '1')			 "	+ c_ent
		cSql += "	ORDER BY BBM_CODESP, BBM_CODPAD, BBM_CODPSA, BBM_DATVAL ASC      "  + c_ent

		If Select (cAliasQRY4) > 0
			(cAliasQRY4)->(DbCloseArea())
			cAliasQRY4 := "TMPQRY4"
		Endif

		DbUseArea(.T.,"TOPCONN",TcGenQry(,,cSql),cAliasQRY4,.T.,.T.) 

		DBSELECTAREA(cAliasQRY4)

		nCont := 0

		COUNT TO nCont

		(cAliasQRY4)->(DbGoTop())

		oProcess:SetRegua2(nCont)

		cTot 	:=  allTrim(Transform(nCont, "@E 999,999,999,999")) 
		nCont 	:= 0

		If !(cAliasQRY4)->(EOF())  

			While !(cAliasQRY4)->(EOF())
				oProcess:IncRegua2("Insere BC0/Backup BC0. Prest.: " + aPrest[nX,1] +' - ' + allTrim(Transform(++nCont, "@E 999,999,999,999")) + ' de ' + cTot )

				//Fazendo copia de toda a BC0 do Prestador, por isso faço o controle
				//do anterior par não realizar beckup 2x
				If cPrestAnt <> aPrest[nX,1]
					cSql2 := " SELECT * FROM " + RetSqlName("BC0") + c_ent
					cSql2 += "  WHERE BC0_FILIAL = '" + xFilial("BC0") + "'" + c_ent
					cSql2 += "    AND BC0_CODIGO = '" + aPrest[nX,1]   + "'" + c_ent
					cSql2 += "    AND D_E_L_E_T_ = ' ' 					   " + c_ent
					cSql2 += "  ORDER BY BC0_CODIGO, BC0_CODINT, BC0_CODLOC, BC0_CODESP, BC0_CODPAD, BC0_CODOPC

					If Select (cAliasQRY5) > 0
						(cAliasQRY5)->(DbCloseArea())
						cAliasQRY5 := "TMPQRY5"
					Endif

					DbUseArea(.T.,"TOPCONN",TcGenQry(,,cSql2),cAliasQRY5,.T.,.T.) 

					DBSELECTAREA(cAliasQRY5)

					(cAliasQRY5)->(DbGoTop())

					If !(cAliasQRY5)->(EOF())  

						While !(cAliasQRY5)->(EOF())
							DbSelectArea("PDT")
							PDT->(DbSetOrder(2))
							If DbSeek(xFilial("PDT")+(cAliasQRY5)->BC0_CODIGO+(cAliasQRY5)->BC0_CODINT+(cAliasQRY5)->BC0_CODLOC+(cAliasQRY5)->BC0_CODESP+(cAliasQRY5)->BC0_CODPAD+(cAliasQRY5)->BC0_CODOPC)
								lRecLockPDT := .F.
							Else
								PDT->(DbSetOrder(3))
								If DbSeek(xFilial("PDT")+(cAliasQRY5)->BC0_CODIGO+(cAliasQRY5)->BC0_CODINT+(cAliasQRY5)->BC0_CODLOC+(cAliasQRY5)->BC0_CODESP+(cAliasQRY5)->BC0_CODPAD+(cAliasQRY5)->BC0_CDNV01)
									lRecLockPDT := .F.
								Else
									PDT->(DbSetOrder(4))
									If DbSeek(xFilial("PDT")+(cAliasQRY5)->BC0_CODIGO+(cAliasQRY5)->BC0_CODINT+(cAliasQRY5)->BC0_CODLOC+(cAliasQRY5)->BC0_CODESP+(cAliasQRY5)->BC0_CODPAD+(cAliasQRY5)->BC0_CDNV02)
										lRecLockPDT := .F.
									Else
										PDT->(DbSetOrder(5))
										If DbSeek(xFilial("PDT")+(cAliasQRY5)->BC0_CODIGO+(cAliasQRY5)->BC0_CODINT+(cAliasQRY5)->BC0_CODLOC+(cAliasQRY5)->BC0_CODESP+(cAliasQRY5)->BC0_CODPAD+(cAliasQRY5)->BC0_CDNV03)
											lRecLockPDT := .F.
										Else
											PDT->(DbSetOrder(6))
											If DbSeek(xFilial("PDT")+(cAliasQRY5)->BC0_CODIGO+(cAliasQRY5)->BC0_CODINT+(cAliasQRY5)->BC0_CODLOC+(cAliasQRY5)->BC0_CODESP+(cAliasQRY5)->BC0_CODPAD+(cAliasQRY5)->BC0_CDNV04)
												lRecLockPDT := .F.
											Else
												lRecLockPDT := .T.
											Endif
										Endif
									Endif
								Endif	
							Endif

							RecLock("PDT",lRecLockPDT)
							PDT->PDT_FILIAL := (cAliasQRY5)->BC0_FILIAL
							PDT->PDT_CODIGO := (cAliasQRY5)->BC0_CODIGO
							PDT->PDT_CODINT := (cAliasQRY5)->BC0_CODINT
							PDT->PDT_CODLOC := (cAliasQRY5)->BC0_CODLOC
							PDT->PDT_CODESP := (cAliasQRY5)->BC0_CODESP
							PDT->PDT_CODSUB := (cAliasQRY5)->BC0_CODSUB
							PDT->PDT_CODTAB := (cAliasQRY5)->BC0_CODTAB
							PDT->PDT_CODPAD := (cAliasQRY5)->BC0_CODPAD
							PDT->PDT_CODOPC := (cAliasQRY5)->BC0_CODOPC
							PDT->PDT_NIVEL  := (cAliasQRY5)->BC0_NIVEL
							PDT->PDT_VALCH  := (cAliasQRY5)->BC0_VALCH
							PDT->PDT_VALREA := (cAliasQRY5)->BC0_VALREA
							PDT->PDT_VALCOB := (cAliasQRY5)->BC0_VALCOB
							PDT->PDT_FORMUL := (cAliasQRY5)->BC0_FORMUL
							PDT->PDT_EXPRES := (cAliasQRY5)->BC0_EXPRES
							PDT->PDT_PERDES := (cAliasQRY5)->BC0_PERDES
							PDT->PDT_PERACR := (cAliasQRY5)->BC0_PERACR
							PDT->PDT_TIPO   := (cAliasQRY5)->BC0_TIPO
							PDT->PDT_CDNV01 := (cAliasQRY5)->BC0_CDNV01
							PDT->PDT_CDNV02 := (cAliasQRY5)->BC0_CDNV02
							PDT->PDT_CDNV03 := (cAliasQRY5)->BC0_CDNV03
							PDT->PDT_CDNV04 := (cAliasQRY5)->BC0_CDNV04
							If !Empty((cAliasQRY5)->BC0_VIGDE)
								PDT->PDT_VIGDE  := STOD((cAliasQRY5)->BC0_VIGDE)
							Endif	
							If !Empty((cAliasQRY5)->BC0_VIGATE)
								PDT->PDT_VIGATE := STOD((cAliasQRY5)->BC0_VIGATE)
							Endif
							PDT->PDT_BANDA  := (cAliasQRY5)->BC0_BANDA
							PDT->PDT_USERGI := (cAliasQRY5)->BC0_USERGI
							PDT->PDT_USERGA := (cAliasQRY5)->BC0_USERGA
							If !Empty((cAliasQRY5)->BC0_DATBLO)
								PDT->PDT_DATBLO := STOD((cAliasQRY5)->BC0_DATBLO)
							Endif 
							PDT->PDT_OBSERV := (cAliasQRY5)->BC0_OBSERV
							PDT->PDT_UCO    := (cAliasQRY5)->BC0_UCO
							PDT->PDT_CODBLO := (cAliasQRY5)->BC0_CODBLO
							PDT->PDT_MOTBLO := (cAliasQRY5)->BC0_MOTBLO
							PDT->PDT_CODREA := (cAliasQRY5)->BC0_CODREA
							PDT->PDT_RECREA := (cAliasQRY5)->BC0_RECREA
							PDT->PDT_AUPREV := (cAliasQRY5)->BC0_AUPREV
							PDT->PDT_RDAMIG := _cCodRDA
							MsUnlock()			
							(cAliasQRY5)->(DbSkip())
						Enddo
					Endif
					cPrestAnt := aPrest[nX,1]
				Endif

				DbSelectArea("BC0")
				BC0->(DbSetOrder(2))
				//BC0_FILIAL+BC0_CODIGO+BC0_CODINT+BC0_CODLOC+BC0_CODESP+BC0_CODPAD+BC0_CODOPC+BC0_NIVEL+BC0_TIPO                                                                 
				If !DbSeek(xFilial("BC0")+aPrest[nX,1]+PLSINTPAD()+aPrest[nX,3]+aPrest[nX,6]+(cAliasQRY4)->BBM_CODPAD+(cAliasQRY4)->BBM_CODPSA+(cAliasQRY4)->BBM_NIVEL+(cAliasQRY4)->BBM_TIPO)
					Reclock("BC0",.T.)
					BC0->BC0_FILIAL := xFilial("BC0")
					BC0->BC0_CODIGO := aPrest[nX,1]
					BC0->BC0_CODINT := PLSINTPAD()
					BC0->BC0_CODLOC := aPrest[nX,3]
					BC0->BC0_CODESP := aPrest[nX,6]
					BC0->BC0_CODSUB := (cAliasQRY4)->BBM_SUBSID
					//BC0->BC0_CODTAB := 
					BC0->BC0_CODPAD := (cAliasQRY4)->BBM_CODPAD
					BC0->BC0_CODOPC := (cAliasQRY4)->BBM_CODPSA
					BC0->BC0_NIVEL  := (cAliasQRY4)->BBM_NIVEL
					BC0->BC0_VALCH  := (cAliasQRY4)->BBM_VALCH
					BC0->BC0_VALREA := (cAliasQRY4)->BBM_VALREA
					//BC0->BC0_VALCOB := (cAliasQRY4)->
					//BC0->BC0_FORMUL := (cAliasQRY4)->
					//BC0->BC0_EXPRES := (cAliasQRY4)->
					//BC0->BC0_PERDES := (cAliasQRY4)->
					//BC0->BC0_PERACR := (cAliasQRY4)->
					BC0->BC0_TIPO   := (cAliasQRY4)->BBM_TIPO
					BC0->BC0_CDNV01 := (cAliasQRY4)->BBM_CDNV01
					BC0->BC0_CDNV02 := (cAliasQRY4)->BBM_CDNV02
					BC0->BC0_CDNV03 := (cAliasQRY4)->BBM_CDNV03
					BC0->BC0_CDNV04 := (cAliasQRY4)->BBM_CDNV04
					//BC0->BC0_VIGDE  := (cAliasQRY4)->
					If !Empty((cAliasQRY4)->BBM_DATVAL)
						BC0->BC0_VIGATE := STOD((cAliasQRY4)->BBM_DATVAL)
					Endif
					BC0->BC0_BANDA  := (cAliasQRY4)->BBM_BANDA
					//BC0->BC0_USERGI := (cAliasQRY4)->
					//BC0->BC0_USERGA := (cAliasQRY4)->
					If !Empty((cAliasQRY4)->BBM_DATVAL)
						BC0->BC0_DATBLO := STOD((cAliasQRY4)->BBM_DATVAL)
					Endif
					//BC0->BC0_OBSERV := (cAliasQRY4)->
					BC0->BC0_UCO    := (cAliasQRY4)->BBM_UCO
					//BC0->BC0_CODBLO := (cAliasQRY4)->
					//BC0->BC0_MOTBLO := (cAliasQRY4)->
					//BC0->BC0_CODREA := (cAliasQRY4)->
					//BC0->BC0_RECREA := (cAliasQRY4)->
					//BC0->BC0_AUPREV := (cAliasQRY4)->
					MsUnlock()			
				Endif
				(cAliasQRY4)->(DbSkip())
			Enddo

		Endif

	Next nX

	(cAliasQRY4)->(DbCloseArea())
Return

//FUNÇÃO ZERARCHBBM
//Zera o CH das BBM encontradas que já foram migradas para PDS
STATIC FUNCTION ZERARCHBBM(aEspec)
	Local nX := 0
	Local cSql := ""
	Local lRecLockPDS := .F.
	Local cAliasQRY2  := "TMPQRY2"
	Local nCont  := 0
	Local cTot   := ""
	Local aAreaBBM := BBM->(GetArea())

	For nX := 1 to Len(aEspec)

		cSql := " SELECT   BAQ_CODINT 						"	+ c_ent
		cSql += " 	     , BAQ_CODESP 						"	+ c_ent
		cSql += "	     , TRIM(BAQ_DESCRI) BAQ_DESCRI 		"	+ c_ent
		cSql += "	     , BAQ.RECNO RECBAQ 				"	+ c_ent
		cSql += "	     , BBM_FILIAL 						"	+ c_ent
		cSql += "	     , BBM_CODPAD 						"	+ c_ent
		cSql += "	     , TRIM(BBM_CODPSA) BBM_CODPSA 		"	+ c_ent
		cSql += "	     , BBM_NIVEL 						"	+ c_ent
		cSql += "	     , BBM_CDNV01						"	+ c_ent
		cSql += "	     , BBM_CDNV02						"	+ c_ent
		cSql += "	     , BBM_CDNV03						"	+ c_ent
		cSql += "	     , BBM_CDNV04						"	+ c_ent
		cSql += "	     , BBM_TIPO 						"	+ c_ent
		cSql += "	     , BBM_DATVAL 						"	+ c_ent
		cSql += "	     , BBM_ATIVO 						"	+ c_ent
		cSql += "	     , BBM_VALREA 						"	+ c_ent
		cSql += "	     , BBM_VALCH 						"	+ c_ent
		cSql += "	     , BBM_SUBSID 						"	+ c_ent
		cSql += "	     , BBM_MESUSR 						"	+ c_ent
		cSql += "	     , BBM_PERIOD 						"	+ c_ent
		cSql += "	     , BBM_PERDES 						"	+ c_ent
		cSql += "	     , BBM_UNPER  						"	+ c_ent
		cSql += "	     , BBM_PERACR 						"	+ c_ent
		cSql += "	     , BBM_BANDA  						"	+ c_ent
		cSql += "	     , BBM_UCO    						"	+ c_ent
		cSql += "	     , BBM_DIFIDA 						"	+ c_ent
		cSql += "	     , BBM.R_E_C_N_O_ RECBBM   			"	+ c_ent   
		cSql += "	  FROM (SELECT BAQ_ACAO 				"	+ c_ent
		cSql += "	             , BAQ_ANIVER 				"	+ c_ent
		cSql += "	             , BAQ_AOINT 				"	+ c_ent
		cSql += "	             , BAQ_BANDA 				"	+ c_ent
		cSql += "	             , BAQ_CODANT 				"	+ c_ent
		cSql += "	             , BAQ_CODESP 				"	+ c_ent
		cSql += "	             , BAQ_CODINT 				"	+ c_ent
		cSql += "	             , BAQ_CODPAD 				"	+ c_ent
		cSql += "	             , BAQ_CODPSA 				"	+ c_ent
		cSql += "	             , BAQ_DESCRI 				"	+ c_ent
		cSql += "	             , BAQ_DESGUI 				"	+ c_ent
		cSql += "	             , BAQ_DTINT 				"	+ c_ent
		cSql += "	             , BAQ_ENVGUI 				"	+ c_ent
		cSql += "	             , BAQ_ESPCFM 				"	+ c_ent
		cSql += "	             , BAQ_ESPSIP 				"	+ c_ent
		cSql += "	             , BAQ_ESPSP2 				"	+ c_ent
		cSql += "	             , BAQ_FILIAL 				"	+ c_ent
		cSql += "	             , BAQ_IDAMAX 				"	+ c_ent
		cSql += "	             , BAQ_IDAMIN 				"	+ c_ent
		cSql += "	             , BAQ_INTERC 				"	+ c_ent
		cSql += "	             , BAQ_REFIGH 				"	+ c_ent
		cSql += "	             , BAQ_SEXO 				"	+ c_ent
		cSql += "	             , BAQ_UCO 					"	+ c_ent
		cSql += "	             , BAQ_VALCH 				"	+ c_ent
		cSql += "	             , BAQ_YDIVUL 				"	+ c_ent
		cSql += "	             , BAQ_YGPESP 				"	+ c_ent
		cSql += "	             , BAQ_YINDIC 				"	+ c_ent
		cSql += "	             , BAQ_YTIPO 				"	+ c_ent
		cSql += "	             , BAQ_YUSO 				"	+ c_ent
		cSql += "	             , MAX(R_E_C_N_O_) RECNO 	"	+ c_ent
		cSql += "	          FROM " + RetSqlName("BAQ") + " BAQ "			+ c_ent
		cSql += "	         WHERE BAQ_FILIAL = '" + xFilial("BAQ") +"' "	+ c_ent
		cSql += "	           AND D_E_L_E_T_ = ' ' 		"	+ c_ent
		cSql += "	         GROUP BY BAQ_ACAO 				"		+ c_ent
		cSql += "	             , BAQ_ANIVER 				"	+ c_ent
		cSql += "	             , BAQ_AOINT 				"	+ c_ent
		cSql += "	             , BAQ_BANDA 				"	+ c_ent
		cSql += "	             , BAQ_CODANT 				"	+ c_ent
		cSql += "	             , BAQ_CODESP 				"	+ c_ent
		cSql += "	             , BAQ_CODINT 				"	+ c_ent
		cSql += "	             , BAQ_CODPAD 				"	+ c_ent
		cSql += "	             , BAQ_CODPSA 				"	+ c_ent
		cSql += "	             , BAQ_DESCRI 				"	+ c_ent
		cSql += "	             , BAQ_DESGUI 				"	+ c_ent
		cSql += "	             , BAQ_DTINT 				"	+ c_ent
		cSql += "	             , BAQ_ENVGUI 				"	+ c_ent
		cSql += "	             , BAQ_ESPCFM 				"	+ c_ent
		cSql += "	             , BAQ_ESPSIP 				"	+ c_ent
		cSql += "	             , BAQ_ESPSP2 				"	+ c_ent
		cSql += "	             , BAQ_FILIAL 				"	+ c_ent
		cSql += "	             , BAQ_IDAMAX 				"	+ c_ent
		cSql += "	             , BAQ_IDAMIN 				"	+ c_ent
		cSql += "	             , BAQ_INTERC 				"	+ c_ent
		cSql += "	             , BAQ_REFIGH 				"	+ c_ent
		cSql += "	             , BAQ_SEXO 				"	+ c_ent
		cSql += "	             , BAQ_UCO 					"	+ c_ent
		cSql += "	             , BAQ_VALCH 				"	+ c_ent
		cSql += "	             , BAQ_YDIVUL 				"	+ c_ent
		cSql += "	             , BAQ_YGPESP 				"	+ c_ent
		cSql += "	             , BAQ_YINDIC 				"	+ c_ent
		cSql += "	             , BAQ_YTIPO 				"	+ c_ent
		cSql += "	             , BAQ_YUSO) BAQ 			"	+ c_ent
		cSql += "	     , " + RetSqlName("BBM") + " BBM 	" 	+ c_ent
		cSql += "	 WHERE BAQ_FILIAL = '" + xFilial("BAQ") + "' "	+ c_ent
		cSql += "	   AND BBM_FILIAL = '" + xFilial("BBM") + "' "	+ c_ent
		cSql += "	   AND BAQ_CODESP = '" + aEspec[nX,3] 	+ "'"	+ c_ent
		cSql += "	   AND BAQ_CODINT = BBM_CODINT 			"	+ c_ent
		cSql += "	   AND BAQ_CODESP = BBM_CODESP 			"	+ c_ent
		cSql += "	   AND BBM_ATIVO  = '1' 				"	+ c_ent
		cSql += "	   AND BBM.D_E_L_E_T_ = ' ' 			"	+ c_ent
		cSql += "	   AND BBM.R_E_C_N_O_ = (SELECT MAX(R_E_C_N_O_)  "	+ c_ent
		cSql += "	                           FROM " + RetSqlName("BBM") + " BBM2 "	+ c_ent
		cSql += "	                          WHERE BBM2.BBM_FILIAL = '" + xFilial("BBM") + "' "	+ c_ent
		cSql += "	                            AND BBM2.BBM_CODINT = BBM.BBM_CODINT "	+ c_ent
		cSql += "	                            AND BBM2.BBM_CODESP = BBM.BBM_CODESP "	+ c_ent
		cSql += "	                            AND BBM2.BBM_CODPAD = BBM.BBM_CODPAD "	+ c_ent
		cSql += "	                            AND BBM2.BBM_CODPSA = BBM.BBM_CODPSA "	+ c_ent
		cSql += "	                            AND BBM2.BBM_DATVAL = BBM.BBM_DATVAL "	+ c_ent
		cSql += "	                            AND BBM2.BBM_ATIVO  = '1')			 "	+ c_ent
		cSql += "	ORDER BY BAQ_CODESP, BBM_CODPAD, BBM_CODPSA, BBM_DATVAL ASC "	+ c_ent

		If Select (cAliasQRY2) > 0
			(cAliasQRY2)->(DbCloseArea())
			cAliasQRY2 := 'TMPQRY2'
		Endif

		DbUseArea(.T.,"TOPCONN",TcGenQry(,,cSql),cAliasQRY2,.T.,.T.) 

		DBSELECTAREA(cAliasQRY2)

		nCont := 0

		COUNT TO nCont

		DbGoTop()

		oProcess:SetRegua2(nCont)

		cTot 	:=  allTrim(Transform(nCont, "@E 999,999,999,999")) 
		nCont 	:= 0

		If !(cAliasQRY2)->(EOF())  

			While !(cAliasQRY2)->(EOF())
				oProcess:IncRegua2("Limpeza CH´s nas Espec.: " + (cAliasQRY2)->BAQ_CODESP + " " + allTrim(Transform(++nCont, "@E 999,999,999,999")) + ' de ' + cTot )
				DbSelectArea("BBM")
				BBM->(DbGoTo((cAliasQRY2)->RECBBM))
				Reclock("BBM",.F.)
				If BBM->BBM_VALREA <> 0
					BBM->BBM_VALREA := 0
				Endif
				If BBM->BBM_VALCH <> 0
					BBM->BBM_VALCH := 0
				Endif	
				MsUnlock()			

				(cAliasQRY2)->(DbSkip())
			Enddo

		Endif

	Next nX

	(cAliasQRY2)->(DbCloseArea())
	RestArea(aAreaBBM)

Return
