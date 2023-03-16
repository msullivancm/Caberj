#include "Tbiconn.ch"
#include "rwmake.ch"
#include "Topconn.ch"
#include "protheus.ch"
#include "Fileio.ch"

/*
Programa CheDupNE()
Autor: Sullivan
Data: 19/04/2013
Descri��o: Programa criado para verificar e excluir os registros duplicados nas SXs conforme log do MP710To110
Altera��o: 10/07/2013 - Sullivan - Inclus�o de verifica��o e corre��o de registros duplicados utilizando o X2_Unico.
Altera��o: 30/12/2013 - Sullivan - Cria��o de interface gr�fica e adapta��o para ser utilizado como pacote e n�o programa a compilar.
Altera��o: 30/01/2014 - Sullivan - Ajuste no CorSXG para registrar espa�o quando o sequencial n�o existir, para que o VolSX3 possa voltar com os valores ap�s a migra��o.
*/

//Exemplo de chamada da rotina:  u_CheDupNE()

User function CheDupNE()            
	Private aEmpresa := {"01"}
		
	Private cCaminho := "\Data\" 
	Private cSystem	 := "\System\"
	Private cCampos	 := cCaminho + "Campos.txt"  // Arquivo texto simples com um campo por linha
	Private cCampNE  := cCaminho + "CamposNE.txt"  // Arquivo texto simples com uma tabela por linha
	Private cTabDup  := cCaminho + "TabDup.txt" // Arquivo texto simples com uma tabela por linha
	Private cE	 := "" // Vari�ve para armazenar o n�mero da empresa atual.
	Private cExt	 := ".DTC" // Extens�o da tabela. Pode ser ".DTC" para CTree ou ".DBF" para ADS.
	Private cDriver	 := "CTREECDX" // Driver de conex�o com a tabela. Pode ser "CTREECDX" para CTree ou "DBFCDX" para ADS.

/*	// Top Origem
	Private cDBOri := "@!!@ORACLE/P11HML" // Os caracteres @!!@ s�o necess�rios para que n�o seja contabilizada licen�a do TopConnection.
	Private cSrvOri := "10.10.23.49"
	Private nPortOri := 7890
	Private nTopOri := 0

	// Cria TCLink Origem
	nTopOri := TcLink(cDBOri, cSrvOri, nPortOri)
	If nTopOri < 0
	    UserException("Erro ao conectar com "+cDbOri+" em "+cSrvOri)
	Endif   
	QOut("Conectado em "+cDbOri+" em "+cSrvOri)  
	TcSetConn(nTopOri)
*/	
	QOut("In�cio do CheDupNE: " + DtoC(Date()) + " " + Time())
	
	For nY := 1 To Len(aEmpresa)
		cE := aEmpresa[nY] // Para m�scara EE.
		QOut("Empresa: " + cE + " " + DtoC(Date()) + " " + Time())
//		Processa( {|| APCOMPSX() }, "Aguarde...", "Verifica se a tabela que est� na SX2 tem campos na SX3",.F.)
		Processa( {|| APCOMPUNI() }, "Aguarde...", "Verifica se a tabela est� com X2_UNICO vazio",.F.)
//		Processa( {|| APCC4Dro() }, "Aguarde...", "Dropando tabela CC4 (desnecess�ria mas um impeditivo para a migra��o)",.F.)
//		Processa( {|| APCCZDro() }, "Aguarde...", "Dropando tabela CCZ (desnecess�ria mas um impeditivo para a migra��o)",.F.)
//		Processa( {|| APTabDup("SX6","X6_FIL+X6_VAR") }, "Aguarde...", "Verificando e eliminando Par�metros duplicados",.F.)		
		Processa( {|| APTabDup("SX7","X7_CAMPO + X7_REGRA + X7_CDOMIN") }, "Aguarde...", "Verificando e eliminando Gatilhos duplicados",.F.)		
		Processa( {|| APTabDup("SIX","INDICE + CHAVE") }, "Aguarde...", "Verificando e eliminando �ndices duplicados",.F.)
//		Processa( {|| APTabDup("SX3","X3_CAMPO") }, "Aguarde...", "Verificando e eliminando Campos duplicados",.F.)
//		Processa( {|| APTabDup("SX2","X2_CHAVE") }, "Aguarde...", "Verificando e eliminando Tabelas duplicadas",.F.)
//		Processa( {|| APCORSXG("SX1","GRUPO") }, "Aguarde...", "Verificando e corrigindo os perguntas que divergem do tamanho do grupo",.F.)
		Processa( {|| APCORSXG("SX3","CAMPO") }, "Aguarde...", "Verificando e corrigindo os campos que divergem do tamanho do grupo",.F.)
/// ainda n�o conclu�do		Processa( {|| APCDTop(cTabDup) }, "Aguarde...", "Verificando e corrigindo registros duplicados nas tabelas previamente selecionadas",.F.)
//		Processa( {|| APCamPad(cCampos) }, "Aguarde...", "Verificando e campos de usu�rios que j� existem no padr�o",.F.)
//		Processa( {|| APCampNE(cCampNE) }, "Aguarde...", "Verificando e corrigindo os campos que existem na SX3 mas n�o no banco",.F.)
////	Processa( {|| APSX2Res() }, "Aguarde...", "Verificando e recuperando Tabelas exclu�das",.F.) // Usar somente caso seja necess�rio restaurar a SX2.
	Next nY                                  
	
	QOut("T�rmino do CheDupNE: " + DtoC(Date()) + " " + Time())
	MsgInfo("CheDupNE conclu�do.")
	
Return

Static Function APCC4Dro() // Fun��o criada para dropar a tabela CC4, caso exista. Pois essa tabela � criada automaticamente pelo Protheus 11 j� atualizada.

	Local cArq := cCaminho + "CC4" + cE + "0BKP" + cExt
	Local cTabela := "CC4" + cE + "0" // Nome da tabela independente da empresa onde est� logado. 
	Local lOk := .F. // Verifica se a tabela foi exclu�da ou n�o.

	Local cAreaTMP := ""  
	cAreaTMP := GetArea()

	QOut("APCC4Dro: " + DtoC(Date()) + " " + Time())

	If TcCanOpen(cTabela) // Verifica se a tabela existe
	
			If File(cArq)
				QOut("J� executado" + DtoC(Date()) + " " + Time())
			Else
				DbUseArea(.T., "TOPCONN", cTabela, "CC4AUX", .F., .T.) 
				
				QOut("In�cio do Backup da CC4: " + DtoC(Date()) + " " + Time())
				//Copy To &cArq Via cDriver // Backup
		 		QOut("T�rmino do Backup da CC4: " + DtoC(Date()) + " " + Time())
				
				DbCloseArea("CC4AUX") // Antes de excluir a tabela, fecha a �rea que a est� utilizando                                          
				lOk := TcDelFile(cTabela) // Exclui, efetivamente, a tabela.
	
				If lOk
					QOut("Tabela CC4 dropada: " + DtoC(Date()) + " " + Time())
				Else
					QOut("Tabela CC4 n�o exclu�da: " + DtoC(Date()) + " " + Time())
				EndIf
		
	    	EndIf
		

	Else 
		QOut("APCC4Dro: Tabela n�o existe - " + DtoC(Date()) + " " + Time())
	EndIf

	RestArea(cAreaTMP)

Return

Static Function APCCZDro() // Fun��o criada para dropar a tabela CCZ, caso exista. Pois essa tabela � criada automaticamente pelo Protheus 11 j� atualizada.

	Local cArq := cCaminho + "CCZ" + cE + "0BKP" + cExt
	Local cTabela := "CCZ" + cE + "0" // Nome da tabela independente da empresa onde est� logado. 
	Local lOk := .F. // Verifica se a tabela foi exclu�da ou n�o.

	Local cAreaTMP := ""  
	cAreaTMP := GetArea()

	QOut("APCCZDro: " + DtoC(Date()) + " " + Time())

	If TcCanOpen(cTabela) // Verifica se a tabela existe
	
			If File(cArq)
				QOut("J� executado" + DtoC(Date()) + " " + Time())
			Else
			
				DbUseArea(.T., "TOPCONN", cTabela, "CCZAUX", .F., .T.) 
				
				QOut("In�cio do Backup da CCZ: " + DtoC(Date()) + " " + Time())
				//Copy To &cArq Via cDriver // Backup
		 		QOut("T�rmino do Backup da CCZ: " + DtoC(Date()) + " " + Time())
				
				DbCloseArea("CCZAUX") // Antes de excluir a tabela, fecha a �rea que a est� utilizando                                          
				lOk := TcDelFile(cTabela) // Exclui, efetivamente, a tabela.
	
				If lOk
					QOut("Tabela CCZ dropada: " + DtoC(Date()) + " " + Time())
				Else
					QOut("Tabela CCZ n�o exclu�da: " + DtoC(Date()) + " " + Time())
				EndIf
		
	    	EndIf
		

	Else 
		QOut("APCCZDro: Tabela n�o existe - " + DtoC(Date()) + " " + Time())
	EndIf

	RestArea(cAreaTMP)

Return

Static Function APTabDup(cAlias,cChave) // Como chamar APTabDup("SX7","X7_CAMPO + X7_REGRA + X7_CDOMIN")
	//cAlias:="SX7" cChave:="X7_CAMPO + X7_REGRA + X7_CDOMIN"
	Local cArq := cCaminho + cAlias + cE + "0BKP" + cExt
	Local cTabela := cSystem + cAlias + cE + "0" + cExt
	Local cNome := "Ap"+cAlias+"Dup"
	Local cLog := cCaminho + cNome + cE + ".log"  
	Local aLinha := {} 
	Local cAAux := cAlias + "AUX"
	Local cAnter := "" // Vari�vel que armazenar� o registro anterior ao que ser� comparado

	Local cArquivo
	Local cFor
	Local nIndex

	Local cAreaTMP := ""  
	cAreaTMP := GetArea()

	QOut(cNome+": " + DtoC(Date()) + " " + Time())

	If File(cTabela) // Se a tabela existir continua.
	
		//APTBPack(cAlias) // Executa Pack na tabela
	
		DBUseArea( .T.,cDriver,cTabela,cAAux, .F. ) // Abre tabela de gatilhos
		
		cArquivo := CriaTrab( NIL, .F. ) //Criando Arquivo
		cFor := ""
	
		IndRegua( cAAux, cArquivo, cChave, , cFor) //Selec.registros..."
		DbSelectArea(cAAux)
		DbSetIndex(cArquivo+OrdBagExt())
	
			If File(cArq)
				QOut("J� executado" + DtoC(Date()) + " " + Time())
			Else
				QOut("In�cio do Backup da "+cAlias+": " + DtoC(Date()) + " " + Time())
				//Copy To &cArq Via cDriver // Backup
		 		QOut("T�rmino do Backup da "+cAlias+": " + DtoC(Date()) + " " + Time())
	
				ProcRegua(1000000)
				(cAAux)->(DbGoTop()) // Posiciona no primeiro registro filtrado.
	
				While !(cAAux)->(Eof())
					IncProc("Excluindo registro duplicado: " + &(cChave))                      
					QOut("Excluindo registro duplicado: " + &(cChave) + " " + DtoC(Date()) + " " + Time())
		            
					If cAnter == &(cChave)
						If !(cAAux)->(DELETED()) // Se n�o estiver exclu�do
							aadd(aLinha, "Excluindo registro duplicado: " + &(cChave) + " " + DtoC(Date()) + " " + Time() ) // Salva em log o valor antido para voltar depois da migra��o
							(cAAux)->(DbDelete()) // Exclui registro posicionado
						EndIf
					EndIf
					cAnter := &(cChave)
					(cAAux)->(DbSkip())
				EndDo  
				QOut("Registros filtrados exclu�dos: " + DtoC(Date()) + " " + Time())
		
	    	EndIf

		fLog(aLinha,cLog,cNome)					
		FErase(cArquivo+OrdBagExt())
	
		(cAAux)->(DbCloseArea())	
		
	Else
		QOut("Tabela : " + cTabela + " n�o existe " + DtoC(Date()) + " " + Time())		
	EndIf
		
	RestArea(cAreaTMP)

Return

Static Function APCamPad(cCampos) // Fun��o criada para verificar e corrigir os campos de usu�rio que j� s�o padr�o na vers�o nova.

	Local cArq := cCaminho + "SX3" + cE + "0BKP" + cExt
	Local cTabela := cSystem + "sx3" + cE + "0" + cExt

	Local cArquivo
	Local cFor
	Local nIndex
	
	Local aCampo := {}
	Local cAreaTMP := ""  
	cAreaTMP := GetArea()

	QOut("APCamPad: " + DtoC(Date()) + " " + Time())

	If File(cTabela)
	
		aCampo := LeCamp(cCampos)
	
		//APTBPack("SX3") // Executa Pack na tabela
		
		DBUseArea( .T.,cDriver,cTabela, "SX3AUX", .F., .T. ) // Abre tabela de gatilhos
		cArquivo := CriaTrab( NIL, .F. ) //Criando Arquivo
		cFor := ""
		IndRegua( "SX3AUX", cArquivo, "X3_CAMPO", , cFor) //Selec.registros..."
		DbSelectArea("SX3AUX")
		DbSetIndex(cArquivo+OrdBagExt())
		SX3AUX->(DbGoTop())
	
		If File(cArq)
			QOut("J� executado." + DtoC(Date()) + " " + Time())
		Else
			QOut("In�cio do Backup da SX3: " + DtoC(Date()) + " " + Time())
			//Copy To &cArq Via cDriver // Backup
	 		QOut("T�rmino do Backup da SX3: " + DtoC(Date()) + " " + Time())
	
			ProcRegua(Len(aCampo))
			For nI := 1 To Len(aCampo)
				IncProc("Processando campo " + AllTrim(aCampo[nI]) )                      
				If SX3AUX->(DbSeek(aCampo[nI]))
					QOut("Processando campo: " + AllTrim(aCampo[nI]) + " em " + DtoC(Date()) + " " + Time())
					SX3AUX->X3_PROPRI := "S" // Passa a ser campo de sistema e n�o mais de usu�rio
				EndIf
			Next nI
		
	 	EndIf
	
		SX3AUX->(DbCloseArea())	
	Else
		QOut("Tabela : " + cTabela + " n�o existe " + DtoC(Date()) + " " + Time())		
	EndIf
	
	FErase(cArquivo+OrdBagExt())
	RestArea(cAreaTMP)

Return

Static Function LeCamp(cCamp)
	Local aLinha := {}
	// Abre o arquivo
	nHandle := FT_FUse(cCamp) // Se houver erro de abertura abandona processamento
	if ferror() # 0
		msgalert ("ERRO AO ABRIR O ARQUIVO, ERRO: " + str(ferror()))
		return
	endif
	// Posiciona na primeria linha
	FT_FGoTop()
	// Retorna o n�mero de linhas do arquivo
	nLast := FT_FLastRec()

	While !FT_FEOF()   
		cLine  := FT_FReadLn() // Retorna a linha corrente  
		aAdd(aLinha, AllTrim(cLine) ) 
		// Pula para pr�xima linha  
		FT_FSKIP()
	EndDo// Fecha o Arquivo
	FT_FUSE()
Return aLinha // Gera vetor de uma dimens�o com o nome do campo a ser manipulado

Static Function APCampNE(cCampNE) // Fun��o criada para criar campos que existem na SX3 mas n�o no banco nas tabelas identificadas pelo MP710To110
//ESSA FUN��O PODE N�O FUNCIONAR CORRETAMENTE SEM OS PARAMETROS DE EMPRESA, PORTANTO FOI DESATIVADA
/*	Local aCampo := {}
	Local cAreaTMP := ""  
	cAreaTMP := GetArea()

	QOut("APCampNE: " + DtoC(Date()) + " " + Time())
	
	aCampo := LeCamp(cCampNE)
	
	For nI := 1 To Len(aCampo)
		QOut("Processando tabela : " + aCampo[nI] + " em " + DtoC(Date()) + " " + Time())
		ChkFile(aCampo[nI])
	Next nI

	RestArea(cAreaTMP)
*/
Return

Static Function APCDTop(cTabDup) // Fun��o criada para verificar e eliminar itens duplicados nas tabelas previamente informadas no arquivo texto separado por ;
	Local aTabelas := {}
	Local cAreaTMP := ""  
	cAreaTMP := GetArea()

	QOut("APCDTop: " + DtoC(Date()) + " " + Time())
	
	aTabelas := LeCamp(cTabDup)
	
	For nI := 1 To Len(aTabelas)
		QOut("Processando tabela : " + aTabelas[nI] + " em " + DtoC(Date()) + " " + Time())
		DupTOP(AllTrim(aTabelas[nI]))
	Next nI

	RestArea(cAreaTMP)

	QOut("APCDTop: Conclu�do. " + DtoC(Date()) + " " + Time())

Return

Static Function fLog(aLinha,cLog,cNome)
	Default	cLog := cCaminho + cNome + cE + ".log"

	If File(cLog)
		QOut("J� executado: " + DtoC(Date()) + " " + Time())
		Return
	Else
		nArquivo := fcreate(cLog, FC_NORMAL)
	EndIf
	if ferror() # 0
		msgalert ("ERRO AO CRIAR O ARQUIVO, ERRO: " + str(ferror()))
		lFalha := .t.
	else
		for nLinha := 1 to len(aLinha)
			fwrite(nArquivo, aLinha[nLinha] + chr(13) + chr(10))
			if ferror() # 0
				msgalert ("ERRO GRAVANDO ARQUIVO, ERRO: " + str(ferror()))
				lFalha := .t.
			endif
		next
	endif
	fclose(nArquivo)
Return           

Static Function APCORSXG(cAlias,cCampo) // Corrige grupo da tabela de perguntas. Como utilizar: APCorGRP("SX1","GRUPO") //Alias e primeiro campo da tabela.

	Local aLinha := {}
	Local cNome := "Cor"+cAlias
	Local cLog := cCaminho + cNome + cE + ".log"
	Local cTabela 	:= cSystem + cAlias + cE + "0" + cExt
	Local cTSXG 	:= cSystem + "SXG" + cE + "0" + cExt // Compara sempre com a tabela SXG, portanto n�o h� necessidade de alias.
	Local cSuf		:= Right(AllTrim(cAlias),2) + "_" // Sufixo do campo. Como s�o tabelas SXs, normalmente o sufixo � os dois �ltimos caracteres do alias.
	Local cArq 		:= cCaminho + cAlias + cE + "0BKP" + cExt

	Local cArquivo
	Local cFor
	Local nIndex
                    
	Local cArqSXG
	Local cForSXG
	Local nIndSXG  
	
	Local cChave := cSuf+cCampo + " + " + cSuf+"ORDEM"
	
	Local cAreaTMP := "" 
	
	cAreaTMP := GetArea()
	
	QOut(cNome+": " + DtoC(Date()) + " " + Time())

	If File(cTabela) .AND. File(cTSXG)
	
		If File(cLog)
	
			QOut("J� executado: " + DtoC(Date()) + " " + Time())
		
		Else
		
			// Abre Tabela que ser� comparada
			DBUseArea( .T.,cDriver,cTabela, "TABAUX", .F.)  
			cArquivo := CriaTrab( NIL, .F. ) //Criando Arquivo
			cFor := ""
			IndRegua( "TABAUX", cArquivo, cChave, , cFor) //Selec.registros..."
			DbSelectArea("TABAUX")
			DbSetIndex(cArquivo+OrdBagExt())

			TABAUX->(dbGoTop())      

			If File(cArq)
				QOut("Backup j� executado " + DtoC(Date()) + " " + Time())
			Else
				QOut("In�cio do Backup da "+cAlias+": " + DtoC(Date()) + " " + Time())
				//Copy To &cArq Via cDriver // Backup
		 		QOut("T�rmino do Backup da "+cAlias+": " + DtoC(Date()) + " " + Time())
		 	EndIf
			
			// Abre SXG
			DBUseArea( .T.,cDriver,cTSXG, "SXGAUX", .F.)  
			cArqSXG := CriaTrab( NIL, .F. ) //Criando Arquivo
			cForSXG := ""
			IndRegua( "SXGAUX", cArqSXG, "XG_GRUPO", , cForSXG) //Selec.registros..."
			DbSelectArea("SXGAUX")
			DbSetIndex(cArqSXG+OrdBagExt())
					
			ProcRegua(10000)
			While !TABAUX->(Eof())
				
				// Ajuste para limpar o conte�do de todos os campos que possu�a 
				// o campo GRPSXG preenchido. 
				if !Empty(&("TABAUX->"+cSuf+"GRPSXG"))
					IncProc("Processando " + &("TABAUX->"+cSuf+cCampo) )
					If SXGAUX->(dbSeek(&("TABAUX->"+cSuf+"GRPSXG")))
						//If (&("TABAUX->"+cSuf+"TAMANHO") <> SXGAUX->XG_SIZE) // Se o tamanho do grupo de campo for menor que o tamanho da pergunta poder� truncar, logo 
							QOut("Processando " + AllTrim(&("TABAUX->"+cSuf+cCampo)) + " em " + DtoC(Date()) + " " + Time())
							aadd(aLinha, AllTrim(&("TABAUX->"+cSuf+cCampo)) + "," + iIf( AllTrim(&("TABAUX->"+cSuf+"ORDEM"))==""," ",AllTrim(&("TABAUX->"+cSuf+"ORDEM")) ) + "," + AllTrim(&("TABAUX->"+cSuf+"GRPSXG")) ) // Salva em log o valor antido para voltar depois da migra��o
																					// Se n�o houver valor na sequencia, preencher com um espa�o para que o arquivo de log possa ser restaurado pelo VolSX3
							&("TABAUX->"+cSuf+"GRPSXG") := " "
						//EndIf
					Endif
				Endif 
				
				/*
				if !Empty(&("TABAUX->"+cSuf+"GRPSXG"))
				IncProc("Processando " + &("TABAUX->"+cSuf+cCampo) )
					If SXGAUX->(dbSeek(&("TABAUX->"+cSuf+"GRPSXG")))
						If (&("TABAUX->"+cSuf+"TAMANHO") <> SXGAUX->XG_SIZE) // Se o tamanho do grupo de campo for menor que o tamanho da pergunta poder� truncar, logo 
							QOut("Processando " + AllTrim(&("TABAUX->"+cSuf+cCampo)) + " em " + DtoC(Date()) + " " + Time())
							aadd(aLinha, AllTrim(&("TABAUX->"+cSuf+cCampo)) + "," + iIf( AllTrim(&("TABAUX->"+cSuf+"ORDEM"))==""," ",AllTrim(&("TABAUX->"+cSuf+"ORDEM")) ) + "," + AllTrim(&("TABAUX->"+cSuf+"GRPSXG")) ) // Salva em log o valor antido para voltar depois da migra��o
																					// Se n�o houver valor na sequencia, preencher com um espa�o para que o arquivo de log possa ser restaurado pelo VolSX3
							&("TABAUX->"+cSuf+"GRPSXG") := " "
						EndIf
					Endif
				Endif */
				
				TABAUX->(DBSkip())
				
			EndDo
			TABAUX->(DBCloseArea())   
			SXGAUX->(DBCloseArea())   
		                   
			fLog(aLinha,cLog,cNome)
	
		EndIf    
	Else
		QOut("Tabela : " + cTabela + " ou " + cTSXG + " n�o existe " + DtoC(Date()) + " " + Time())		
	EndIf         

//	FErase(cArquivo+OrdBagExt()) // Exclui �ndice
//	FErase(cArqSXG+OrdBagExt()) // Exclui �ndice
			
	RestArea(cAreaTMP)

Return

//---Restaurar SX2 caso necess�rio
Static Function APSX2Res()   
	Local cTabela := cSystem + "sx2" + cE + "0" + cExt
	Local cNome := "ApSX2Dup"                  
	Local cLog := cCaminho + cNome + cE + ".log"  
	Local aLinha := {}

	Local cArquivo
	Local cChave
	Local cFor
	Local nIndex

	Local cAreaTMP := ""  
	cAreaTMP := GetArea()
	
	If File(cLog)
		aLinha := fLeLog(cLog)
	
		DBUseArea( .T.,cDriver,cTabela, "SX2AUX", .F., .T. ) // Abre tabela de gatilhos
		cArquivo := CriaTrab( NIL, .F. ) //Criando Arquivo
		cChave := "X2_CHAVE"
		cFor := ""
	
		IndRegua( "SX2AUX", cArquivo, cChave, , cFor) //Selec.registros..."
		DbSelectArea("SX2AUX")
		DbSetIndex(cArquivo+OrdBagExt())

		SX2AUX->(dbGoTop())
		For nI := 1 To Len(aLinha)         
			
			If SX2AUX->(dbSeek(aLinha[nI][1])) // Encontra o campo
					If SX2AUX->(DELETED()) // Retorna: .T.
						RECALL
					EndIf
			Endif
			SX2AUX->(DBSkip())
			
		Next 
		SX2AUX->(DBCloseArea())
	Else 
		Alert("Arquivo n�o encontrado.")
	EndIf

	RestArea(cAreaTMP)
Return

Static Function fLeLog(cLog)
	Local aLinha := {}
	// Abre o arquivo
	nHandle := FT_FUse(cLog) // Se houver erro de abertura abandona processamento
	if ferror() # 0
		msgalert ("ERRO AO ABRIR O ARQUIVO, ERRO: " + str(ferror()))
		return
	endif
	// Posiciona na primeria linha
	FT_FGoTop()
	// Retorna o n�mero de linhas do arquivo
	nLast := FT_FLastRec()

	While !FT_FEOF()   
		cLine  := FT_FReadLn() // Retorna a linha corrente  
		aAdd(aLinha, Separa(cLine,',',.f.) )
		// Pula para pr�xima linha  
		FT_FSKIP()
	EndDo// Fecha o Arquivo
	FT_FUSE()
Return aLinha

Static Function APTBPack(cAlias) // Pack na tabela especificada

	Local cArq := cCaminho + cAlias + cE + "0BKP" + cExt
	Local cTabela := cSystem + "" + cAlias + cE + "0" + cExt
	Local cNome := "Ap"+cAlias+"Pack"                  
	Local cLog := cCaminho + cNome + cE + ".log"  
	Local aLinha := {}        
	Local cAAux := cAlias + "AUX"

	Local cAreaTMP := ""  
	cAreaTMP := GetArea()

	QOut(cNome + ": " + DtoC(Date()) + " " + Time())

	If File(cTabela)
	
		If File(cLog)
	
			QOut("J� executado: " + DtoC(Date()) + " " + Time())
		
		Else
	
			If Select(cAAux) > 0
				DbCloseArea(cAAux)
			EndIf
	
			DBUseArea( .T.,cDriver,cTabela, cAAux, .F.) // Abre tabela em modo exclusivo.
			Pack
			QOut("Pack realizado na tabela: " + cTabela + " " + DtoC(Date()) + " " + Time())
	
			(cAAux)->(DbCloseArea())	
	
			fLog(aLinha,cLog,cNome)
			                             
		EndIf

	Else
		QOut("Tabela : " + cTabela + " n�o existe " + DtoC(Date()) + " " + Time())		
	EndIf
	
	RestArea(cAreaTMP)

Return

Static Function APCOMPSX() // Verifica se a tabela que est� na SX2 tem campos na SX3.

	Local aLinha := {}
	Local cNome := "COMPSX"
	Local cLog := cCaminho + cNome + cE + ".log"
	Local cTSX2 	:= cSystem + "SX2" + cE + "0" + cExt
	Local cTSX3 	:= cSystem + "SX3" + cE + "0" + cExt

	Local cArqSX2
	Local cForSX2
	Local nIndSX2
	Local cChaSX2 := "X2_CHAVE"
                    
	Local cArqSX3
	Local cForSX3
	Local nIndSX3  
	Local cChaSX3 := "X3_ARQUIVO"
		
	Local cAreaTMP := ""  
	cAreaTMP := GetArea()
	
	QOut(cNome+": " + DtoC(Date()) + " " + Time())

	If File(cTSX3) .AND. File(cTSX3)
		If File(cLog)
	
			QOut("J� executado: " + DtoC(Date()) + " " + Time())
		
		Else
		
			// Abre SX2
			DBUseArea( .T.,cDriver,cTSX2, "SX2AUX", .F.)  
			cArqSX2 := CriaTrab( NIL, .F. ) //Criando Arquivo
			cForSX2 := ""
			IndRegua( "SX2AUX", cArqSX2, cChaSX2, , cForSX2) //Selec.registros..."
			DbSelectArea("SX2AUX")
			DbSetIndex(cArqSX2+OrdBagExt())
			SX2AUX->(dbGoTop())      
			
			// Abre SX3
			DBUseArea( .T.,cDriver,cTSX3, "SX3AUX", .F.)  
			cArqSX3 := CriaTrab( NIL, .F. ) //Criando Arquivo
			cForSX3 := UniqueKey(cChaSX3)
			IndRegua( "SX3AUX", cArqSX3, cChaSX3, , cForSX3) //Selec.registros..."
			DbSelectArea("SX3AUX")
			DbSetIndex(cArqSX3+OrdBagExt())
								
			ProcRegua(10000)
			While !SX2AUX->(Eof())
				
				IncProc("Processando " + &("SX2AUX->"+cChaSX2) )
				
				If SX3AUX->(dbSeek(&("SX2AUX->"+cChaSX2)))
				Else
					aadd(aLinha, AllTrim(&("SX2AUX->"+cChaSX2)) + " existe na SX2 mas n�o tem campo na SX3.")
				Endif
				SX2AUX->(DBSkip())
				
			EndDo
			SX2AUX->(DBCloseArea())   
			SX3AUX->(DBCloseArea())   
		                   
			fLog(aLinha,cLog,cNome)
	
		EndIf    
	Else
		QOut("Tabela : " + cTSX2 + " ou " + cTSX3 + " n�o existe " + DtoC(Date()) + " " + Time())		
	EndIf         

//	FErase(cArquivo+OrdBagExt()) // Exclui �ndice
//	FErase(cArqSXG+OrdBagExt()) // Exclui �ndice
			
	RestArea(cAreaTMP)

Return

Static Function DupTOP(cTabela) // Como chamar DupTOP("SA1010")
	Local cArq := cCaminho + cAlias + cE + "0BKP" + cExt
	Local cNome := "DupTOP"+cAlias
	Local cLog := cCaminho + cNome + cE + ".log"  
	Local aLinha := {} 
	Local cAlias := Left(cTabela, 3)
	Local cAAux := cAlias + "AUX"
	Local cAnter := "" // Vari�vel que armazenar� o registro anterior ao que ser� comparado

	Local cTSX2 	:= cSystem + "SX2" + cE + "0" + cExt
	Local cArqSX2
	Local cForSX2
	Local nIndSX2
	Local cChaSX2 := "X2_CHAVE"

	Local cArquivo
	Local cFor
	Local nIndex

	Local cAreaTMP := ""  
	cAreaTMP := GetArea()

	QOut(cNome+": " + DtoC(Date()) + " " + Time())

	// Abre SX2
	DBUseArea( .T.,cDriver,cTSX2, "SX2AUX", .F.)  
	cArqSX2 := CriaTrab( NIL, .F. ) //Criando Arquivo
	cForSX2 := ""
	IndRegua( "SX2AUX", cArqSX2, cChaSX2, , cForSX2) //Selec.registros..."
	DbSelectArea("SX2AUX")
	DbSetIndex(cArqSX2+OrdBagExt())
	SX2AUX->(dbGoTop())      
	If SX2AUX->(DBSeek(cAlias))
	
		DBUseArea( .T.,'TOPCONN',cTabela, cAAux, .F. ) // Abre tabela com registros duplicados
		cArquivo := CriaTrab( NIL, .F. ) //Criando Arquivo
		cFor := ""
		IndRegua( cAAux, cArquivo, SX2AUX->X2_UNICO, , cFor) //Cria o �ndice tempor�rio utilizando o X2_Unico da tabela
		DbSelectArea(cAAux)
		DbSetIndex(cArquivo+OrdBagExt())
	
		ProcRegua(1000000)
		(cAAux)->(DbGoTop()) // Posiciona no primeiro registro filtrado.

		While !(cAAux)->(Eof())
			IncProc("Excluindo registro duplicado: " + (cAAux)->(&(SX2AUX->X2_UNICO)) )                      
			QOut("Excluindo registro duplicado: " + (cAAux)->(&(SX2AUX->X2_UNICO)) + " " + DtoC(Date()) + " " + Time())
            
			If cAnter == (cAAux)->(&(SX2AUX->X2_UNICO))
				If !(cAAux)->(DELETED()) // Se n�o estiver exclu�do
					aadd(aLinha, "Excluindo registro duplicado: " + (cAAux)->(&(SX2AUX->X2_UNICO)) + " " + DtoC(Date()) + " " + Time() ) // Salva em log o valor antido para voltar depois da migra��o
					(cAAux)->(DbDelete()) // Exclui registro posicionado
				EndIf
			EndIf
			cAnter := (cAAux)->(&(SX2AUX->X2_UNICO))
			(cAAux)->(DbSkip())
		EndDo  
		QOut("Registros filtrados exclu�dos: " + DtoC(Date()) + " " + Time())

		fLog(aLinha,cLog,cNome)					
		FErase(cArquivo+OrdBagExt())

		(cAAux)->(DbCloseArea())	
		SX2AUX->(DBCloseArea())   
	
	Else
		QOut("Tabela " + cTabela + " n�o encontrada do SX2"+ DtoC(Date()) + " " + Time())
	EndIf
		
	RestArea(cAreaTMP)

Return

Static Function LeEmp() // L� empresas e gera vetor contendo todas elas
	Local cTabela := cSystem + "sigamat.emp"
	Local aEmp := {} 
	Local cAAux := "SigamatAUX"
	Local cAnter := "" // Vari�vel que armazenar� o registro anterior ao que ser� comparado

	Local cArquivo
	Local cFor
	Local nIndex
	
	Local cAreaTMP := ""  
	cAreaTMP := GetArea()
	
	DBUseArea( .T.,cDriver,cTabela, cAAux, .F. ) // Abre sigamat.emp
	cArquivo := CriaTrab( NIL, .F. ) //Criando Arquivo de �ndice
	cFor := ""
	IndRegua( cAAux, cArquivo, "M0_CODIGO+M0_CODFIL", , cFor)
	DbSelectArea(cAAux)
	DbSetIndex(cArquivo+OrdBagExt())
	
	If File(cTabela) // Se a tabela existir continua.
		
		While !(cAAux)->(Eof())
			If (cAAux)->M0_CODIGO == cAnter // S� armazena o n�mero da empresa se for diferente que o registro anterior
			Else
				aAdd(aEmp, (cAAux)->M0_CODIGO )
				cAnter := (cAAux)->M0_CODIGO 		
			EndIf
			(cAAux)->(DbSkip())
		EndDo  
		
	EndIf
	
	(cAAux)->(DbCloseArea())	
		
	RestArea(cAreaTMP)	
	
Return aEmp // Retorna vetor contendo todas as empresas

Static Function ApCompUni() 

	Local cNome := "ApCompUniSX2"
	Local cLog := cCaminho + cNome + cE + ".log"  
	Local aLinha := {} 
	Local cAAux := "SX2AUX"
	Local cAnter := "" // Vari�vel que armazenar� o registro anterior ao que ser� comparado

	Local cTSX2 	:= cSystem + "SX2" + cE + "0" + cExt
	Local cArqSX2
	Local cForSX2
	Local nIndSX2
	Local cChaSX2 := "X2_CHAVE"

	Local cArquivo
	Local cFor
	Local nIndex

	Local cAreaTMP := ""  
	cAreaTMP := GetArea()

	QOut(cNome+": " + DtoC(Date()) + " " + Time())

	// Abre SX2
	DBUseArea( .T.,cDriver,cTSX2, cAAux, .F.)  
	cArqSX2 := CriaTrab( NIL, .F. ) //Criando Arquivo
	cForSX2 := ""
	IndRegua(cAAux, cArqSX2, cChaSX2, , cForSX2) //Selec.registros..."
	DbSelectArea("SX2AUX")
	DbSetIndex(cArqSX2+OrdBagExt())
	(cAAux)->(dbGoTop())      
	
		ProcRegua(1000000)
		(cAAux)->(DbGoTop()) // Posiciona no primeiro registro filtrado.

		While !(cAAux)->(Eof())
			                      
			QOut("Listando tabela com X2_UNICO em branco: " + (cAAux)->X2_CHAVE + " " + DtoC(Date()) + " " + Time())
            
			If Empty((cAAux)->X2_UNICO)
					aadd(aLinha, "X2_UNICO em branco: " + (cAAux)->X2_CHAVE + " " + DtoC(Date()) + " " + Time() ) // Salva em log o valor antigo para voltar depois da migra��o
					
			EndIf
			
			(cAAux)->(DbSkip())
		EndDo  
		QOut("Registros filtrados listados: " + DtoC(Date()) + " " + Time())

		fLog(aLinha,cLog,cNome)					
		FErase(cArqSX2+OrdBagExt())

		(cAAux)->(DbCloseArea())	
		
	RestArea(cAreaTMP)

Return
