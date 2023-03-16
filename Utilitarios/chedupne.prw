#include "Tbiconn.ch"
#include "rwmake.ch"
#include "Topconn.ch"
#include "protheus.ch"
#include "Fileio.ch"

/*
Programa CheDupNE()
Autor: Sullivan
Data: 19/04/2013
Descrição: Programa criado para verificar e excluir os registros duplicados nas SXs conforme log do MP710To110
Alteração: 10/07/2013 - Sullivan - Inclusão de verificação e correção de registros duplicados utilizando o X2_Unico.
Alteração: 30/12/2013 - Sullivan - Criação de interface gráfica e adaptação para ser utilizado como pacote e não programa a compilar.
Alteração: 30/01/2014 - Sullivan - Ajuste no CorSXG para registrar espaço quando o sequencial não existir, para que o VolSX3 possa voltar com os valores após a migração.
*/

//Exemplo de chamada da rotina:  u_CheDupNE()

User function CheDupNE()            
	Private aEmpresa := {"01"}
		
	Private cCaminho := "\Data\" 
	Private cSystem	 := "\System\"
	Private cCampos	 := cCaminho + "Campos.txt"  // Arquivo texto simples com um campo por linha
	Private cCampNE  := cCaminho + "CamposNE.txt"  // Arquivo texto simples com uma tabela por linha
	Private cTabDup  := cCaminho + "TabDup.txt" // Arquivo texto simples com uma tabela por linha
	Private cE	 := "" // Variáve para armazenar o número da empresa atual.
	Private cExt	 := ".DTC" // Extensão da tabela. Pode ser ".DTC" para CTree ou ".DBF" para ADS.
	Private cDriver	 := "CTREECDX" // Driver de conexão com a tabela. Pode ser "CTREECDX" para CTree ou "DBFCDX" para ADS.

/*	// Top Origem
	Private cDBOri := "@!!@ORACLE/P11HML" // Os caracteres @!!@ são necessários para que não seja contabilizada licença do TopConnection.
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
	QOut("Início do CheDupNE: " + DtoC(Date()) + " " + Time())
	
	For nY := 1 To Len(aEmpresa)
		cE := aEmpresa[nY] // Para máscara EE.
		QOut("Empresa: " + cE + " " + DtoC(Date()) + " " + Time())
//		Processa( {|| APCOMPSX() }, "Aguarde...", "Verifica se a tabela que está na SX2 tem campos na SX3",.F.)
		Processa( {|| APCOMPUNI() }, "Aguarde...", "Verifica se a tabela está com X2_UNICO vazio",.F.)
//		Processa( {|| APCC4Dro() }, "Aguarde...", "Dropando tabela CC4 (desnecessária mas um impeditivo para a migração)",.F.)
//		Processa( {|| APCCZDro() }, "Aguarde...", "Dropando tabela CCZ (desnecessária mas um impeditivo para a migração)",.F.)
//		Processa( {|| APTabDup("SX6","X6_FIL+X6_VAR") }, "Aguarde...", "Verificando e eliminando Parâmetros duplicados",.F.)		
		Processa( {|| APTabDup("SX7","X7_CAMPO + X7_REGRA + X7_CDOMIN") }, "Aguarde...", "Verificando e eliminando Gatilhos duplicados",.F.)		
		Processa( {|| APTabDup("SIX","INDICE + CHAVE") }, "Aguarde...", "Verificando e eliminando Índices duplicados",.F.)
//		Processa( {|| APTabDup("SX3","X3_CAMPO") }, "Aguarde...", "Verificando e eliminando Campos duplicados",.F.)
//		Processa( {|| APTabDup("SX2","X2_CHAVE") }, "Aguarde...", "Verificando e eliminando Tabelas duplicadas",.F.)
//		Processa( {|| APCORSXG("SX1","GRUPO") }, "Aguarde...", "Verificando e corrigindo os perguntas que divergem do tamanho do grupo",.F.)
		Processa( {|| APCORSXG("SX3","CAMPO") }, "Aguarde...", "Verificando e corrigindo os campos que divergem do tamanho do grupo",.F.)
/// ainda não concluído		Processa( {|| APCDTop(cTabDup) }, "Aguarde...", "Verificando e corrigindo registros duplicados nas tabelas previamente selecionadas",.F.)
//		Processa( {|| APCamPad(cCampos) }, "Aguarde...", "Verificando e campos de usuários que já existem no padrão",.F.)
//		Processa( {|| APCampNE(cCampNE) }, "Aguarde...", "Verificando e corrigindo os campos que existem na SX3 mas não no banco",.F.)
////	Processa( {|| APSX2Res() }, "Aguarde...", "Verificando e recuperando Tabelas excluídas",.F.) // Usar somente caso seja necessário restaurar a SX2.
	Next nY                                  
	
	QOut("Término do CheDupNE: " + DtoC(Date()) + " " + Time())
	MsgInfo("CheDupNE concluído.")
	
Return

Static Function APCC4Dro() // Função criada para dropar a tabela CC4, caso exista. Pois essa tabela é criada automaticamente pelo Protheus 11 já atualizada.

	Local cArq := cCaminho + "CC4" + cE + "0BKP" + cExt
	Local cTabela := "CC4" + cE + "0" // Nome da tabela independente da empresa onde está logado. 
	Local lOk := .F. // Verifica se a tabela foi excluída ou não.

	Local cAreaTMP := ""  
	cAreaTMP := GetArea()

	QOut("APCC4Dro: " + DtoC(Date()) + " " + Time())

	If TcCanOpen(cTabela) // Verifica se a tabela existe
	
			If File(cArq)
				QOut("Já executado" + DtoC(Date()) + " " + Time())
			Else
				DbUseArea(.T., "TOPCONN", cTabela, "CC4AUX", .F., .T.) 
				
				QOut("Início do Backup da CC4: " + DtoC(Date()) + " " + Time())
				//Copy To &cArq Via cDriver // Backup
		 		QOut("Término do Backup da CC4: " + DtoC(Date()) + " " + Time())
				
				DbCloseArea("CC4AUX") // Antes de excluir a tabela, fecha a área que a está utilizando                                          
				lOk := TcDelFile(cTabela) // Exclui, efetivamente, a tabela.
	
				If lOk
					QOut("Tabela CC4 dropada: " + DtoC(Date()) + " " + Time())
				Else
					QOut("Tabela CC4 não excluída: " + DtoC(Date()) + " " + Time())
				EndIf
		
	    	EndIf
		

	Else 
		QOut("APCC4Dro: Tabela não existe - " + DtoC(Date()) + " " + Time())
	EndIf

	RestArea(cAreaTMP)

Return

Static Function APCCZDro() // Função criada para dropar a tabela CCZ, caso exista. Pois essa tabela é criada automaticamente pelo Protheus 11 já atualizada.

	Local cArq := cCaminho + "CCZ" + cE + "0BKP" + cExt
	Local cTabela := "CCZ" + cE + "0" // Nome da tabela independente da empresa onde está logado. 
	Local lOk := .F. // Verifica se a tabela foi excluída ou não.

	Local cAreaTMP := ""  
	cAreaTMP := GetArea()

	QOut("APCCZDro: " + DtoC(Date()) + " " + Time())

	If TcCanOpen(cTabela) // Verifica se a tabela existe
	
			If File(cArq)
				QOut("Já executado" + DtoC(Date()) + " " + Time())
			Else
			
				DbUseArea(.T., "TOPCONN", cTabela, "CCZAUX", .F., .T.) 
				
				QOut("Início do Backup da CCZ: " + DtoC(Date()) + " " + Time())
				//Copy To &cArq Via cDriver // Backup
		 		QOut("Término do Backup da CCZ: " + DtoC(Date()) + " " + Time())
				
				DbCloseArea("CCZAUX") // Antes de excluir a tabela, fecha a área que a está utilizando                                          
				lOk := TcDelFile(cTabela) // Exclui, efetivamente, a tabela.
	
				If lOk
					QOut("Tabela CCZ dropada: " + DtoC(Date()) + " " + Time())
				Else
					QOut("Tabela CCZ não excluída: " + DtoC(Date()) + " " + Time())
				EndIf
		
	    	EndIf
		

	Else 
		QOut("APCCZDro: Tabela não existe - " + DtoC(Date()) + " " + Time())
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
	Local cAnter := "" // Variável que armazenará o registro anterior ao que será comparado

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
				QOut("Já executado" + DtoC(Date()) + " " + Time())
			Else
				QOut("Início do Backup da "+cAlias+": " + DtoC(Date()) + " " + Time())
				//Copy To &cArq Via cDriver // Backup
		 		QOut("Término do Backup da "+cAlias+": " + DtoC(Date()) + " " + Time())
	
				ProcRegua(1000000)
				(cAAux)->(DbGoTop()) // Posiciona no primeiro registro filtrado.
	
				While !(cAAux)->(Eof())
					IncProc("Excluindo registro duplicado: " + &(cChave))                      
					QOut("Excluindo registro duplicado: " + &(cChave) + " " + DtoC(Date()) + " " + Time())
		            
					If cAnter == &(cChave)
						If !(cAAux)->(DELETED()) // Se não estiver excluído
							aadd(aLinha, "Excluindo registro duplicado: " + &(cChave) + " " + DtoC(Date()) + " " + Time() ) // Salva em log o valor antido para voltar depois da migração
							(cAAux)->(DbDelete()) // Exclui registro posicionado
						EndIf
					EndIf
					cAnter := &(cChave)
					(cAAux)->(DbSkip())
				EndDo  
				QOut("Registros filtrados excluídos: " + DtoC(Date()) + " " + Time())
		
	    	EndIf

		fLog(aLinha,cLog,cNome)					
		FErase(cArquivo+OrdBagExt())
	
		(cAAux)->(DbCloseArea())	
		
	Else
		QOut("Tabela : " + cTabela + " não existe " + DtoC(Date()) + " " + Time())		
	EndIf
		
	RestArea(cAreaTMP)

Return

Static Function APCamPad(cCampos) // Função criada para verificar e corrigir os campos de usuário que já são padrão na versão nova.

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
			QOut("Já executado." + DtoC(Date()) + " " + Time())
		Else
			QOut("Início do Backup da SX3: " + DtoC(Date()) + " " + Time())
			//Copy To &cArq Via cDriver // Backup
	 		QOut("Término do Backup da SX3: " + DtoC(Date()) + " " + Time())
	
			ProcRegua(Len(aCampo))
			For nI := 1 To Len(aCampo)
				IncProc("Processando campo " + AllTrim(aCampo[nI]) )                      
				If SX3AUX->(DbSeek(aCampo[nI]))
					QOut("Processando campo: " + AllTrim(aCampo[nI]) + " em " + DtoC(Date()) + " " + Time())
					SX3AUX->X3_PROPRI := "S" // Passa a ser campo de sistema e não mais de usuário
				EndIf
			Next nI
		
	 	EndIf
	
		SX3AUX->(DbCloseArea())	
	Else
		QOut("Tabela : " + cTabela + " não existe " + DtoC(Date()) + " " + Time())		
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
	// Retorna o número de linhas do arquivo
	nLast := FT_FLastRec()

	While !FT_FEOF()   
		cLine  := FT_FReadLn() // Retorna a linha corrente  
		aAdd(aLinha, AllTrim(cLine) ) 
		// Pula para próxima linha  
		FT_FSKIP()
	EndDo// Fecha o Arquivo
	FT_FUSE()
Return aLinha // Gera vetor de uma dimensão com o nome do campo a ser manipulado

Static Function APCampNE(cCampNE) // Função criada para criar campos que existem na SX3 mas não no banco nas tabelas identificadas pelo MP710To110
//ESSA FUNÇÃO PODE NÃO FUNCIONAR CORRETAMENTE SEM OS PARAMETROS DE EMPRESA, PORTANTO FOI DESATIVADA
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

Static Function APCDTop(cTabDup) // Função criada para verificar e eliminar itens duplicados nas tabelas previamente informadas no arquivo texto separado por ;
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

	QOut("APCDTop: Concluído. " + DtoC(Date()) + " " + Time())

Return

Static Function fLog(aLinha,cLog,cNome)
	Default	cLog := cCaminho + cNome + cE + ".log"

	If File(cLog)
		QOut("Já executado: " + DtoC(Date()) + " " + Time())
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
	Local cTSXG 	:= cSystem + "SXG" + cE + "0" + cExt // Compara sempre com a tabela SXG, portanto não há necessidade de alias.
	Local cSuf		:= Right(AllTrim(cAlias),2) + "_" // Sufixo do campo. Como são tabelas SXs, normalmente o sufixo é os dois últimos caracteres do alias.
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
	
			QOut("Já executado: " + DtoC(Date()) + " " + Time())
		
		Else
		
			// Abre Tabela que será comparada
			DBUseArea( .T.,cDriver,cTabela, "TABAUX", .F.)  
			cArquivo := CriaTrab( NIL, .F. ) //Criando Arquivo
			cFor := ""
			IndRegua( "TABAUX", cArquivo, cChave, , cFor) //Selec.registros..."
			DbSelectArea("TABAUX")
			DbSetIndex(cArquivo+OrdBagExt())

			TABAUX->(dbGoTop())      

			If File(cArq)
				QOut("Backup já executado " + DtoC(Date()) + " " + Time())
			Else
				QOut("Início do Backup da "+cAlias+": " + DtoC(Date()) + " " + Time())
				//Copy To &cArq Via cDriver // Backup
		 		QOut("Término do Backup da "+cAlias+": " + DtoC(Date()) + " " + Time())
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
				
				// Ajuste para limpar o conteúdo de todos os campos que possuía 
				// o campo GRPSXG preenchido. 
				if !Empty(&("TABAUX->"+cSuf+"GRPSXG"))
					IncProc("Processando " + &("TABAUX->"+cSuf+cCampo) )
					If SXGAUX->(dbSeek(&("TABAUX->"+cSuf+"GRPSXG")))
						//If (&("TABAUX->"+cSuf+"TAMANHO") <> SXGAUX->XG_SIZE) // Se o tamanho do grupo de campo for menor que o tamanho da pergunta poderá truncar, logo 
							QOut("Processando " + AllTrim(&("TABAUX->"+cSuf+cCampo)) + " em " + DtoC(Date()) + " " + Time())
							aadd(aLinha, AllTrim(&("TABAUX->"+cSuf+cCampo)) + "," + iIf( AllTrim(&("TABAUX->"+cSuf+"ORDEM"))==""," ",AllTrim(&("TABAUX->"+cSuf+"ORDEM")) ) + "," + AllTrim(&("TABAUX->"+cSuf+"GRPSXG")) ) // Salva em log o valor antido para voltar depois da migração
																					// Se não houver valor na sequencia, preencher com um espaço para que o arquivo de log possa ser restaurado pelo VolSX3
							&("TABAUX->"+cSuf+"GRPSXG") := " "
						//EndIf
					Endif
				Endif 
				
				/*
				if !Empty(&("TABAUX->"+cSuf+"GRPSXG"))
				IncProc("Processando " + &("TABAUX->"+cSuf+cCampo) )
					If SXGAUX->(dbSeek(&("TABAUX->"+cSuf+"GRPSXG")))
						If (&("TABAUX->"+cSuf+"TAMANHO") <> SXGAUX->XG_SIZE) // Se o tamanho do grupo de campo for menor que o tamanho da pergunta poderá truncar, logo 
							QOut("Processando " + AllTrim(&("TABAUX->"+cSuf+cCampo)) + " em " + DtoC(Date()) + " " + Time())
							aadd(aLinha, AllTrim(&("TABAUX->"+cSuf+cCampo)) + "," + iIf( AllTrim(&("TABAUX->"+cSuf+"ORDEM"))==""," ",AllTrim(&("TABAUX->"+cSuf+"ORDEM")) ) + "," + AllTrim(&("TABAUX->"+cSuf+"GRPSXG")) ) // Salva em log o valor antido para voltar depois da migração
																					// Se não houver valor na sequencia, preencher com um espaço para que o arquivo de log possa ser restaurado pelo VolSX3
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
		QOut("Tabela : " + cTabela + " ou " + cTSXG + " não existe " + DtoC(Date()) + " " + Time())		
	EndIf         

//	FErase(cArquivo+OrdBagExt()) // Exclui índice
//	FErase(cArqSXG+OrdBagExt()) // Exclui índice
			
	RestArea(cAreaTMP)

Return

//---Restaurar SX2 caso necessário
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
		Alert("Arquivo não encontrado.")
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
	// Retorna o número de linhas do arquivo
	nLast := FT_FLastRec()

	While !FT_FEOF()   
		cLine  := FT_FReadLn() // Retorna a linha corrente  
		aAdd(aLinha, Separa(cLine,',',.f.) )
		// Pula para próxima linha  
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
	
			QOut("Já executado: " + DtoC(Date()) + " " + Time())
		
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
		QOut("Tabela : " + cTabela + " não existe " + DtoC(Date()) + " " + Time())		
	EndIf
	
	RestArea(cAreaTMP)

Return

Static Function APCOMPSX() // Verifica se a tabela que está na SX2 tem campos na SX3.

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
	
			QOut("Já executado: " + DtoC(Date()) + " " + Time())
		
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
					aadd(aLinha, AllTrim(&("SX2AUX->"+cChaSX2)) + " existe na SX2 mas não tem campo na SX3.")
				Endif
				SX2AUX->(DBSkip())
				
			EndDo
			SX2AUX->(DBCloseArea())   
			SX3AUX->(DBCloseArea())   
		                   
			fLog(aLinha,cLog,cNome)
	
		EndIf    
	Else
		QOut("Tabela : " + cTSX2 + " ou " + cTSX3 + " não existe " + DtoC(Date()) + " " + Time())		
	EndIf         

//	FErase(cArquivo+OrdBagExt()) // Exclui índice
//	FErase(cArqSXG+OrdBagExt()) // Exclui índice
			
	RestArea(cAreaTMP)

Return

Static Function DupTOP(cTabela) // Como chamar DupTOP("SA1010")
	Local cArq := cCaminho + cAlias + cE + "0BKP" + cExt
	Local cNome := "DupTOP"+cAlias
	Local cLog := cCaminho + cNome + cE + ".log"  
	Local aLinha := {} 
	Local cAlias := Left(cTabela, 3)
	Local cAAux := cAlias + "AUX"
	Local cAnter := "" // Variável que armazenará o registro anterior ao que será comparado

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
		IndRegua( cAAux, cArquivo, SX2AUX->X2_UNICO, , cFor) //Cria o índice temporário utilizando o X2_Unico da tabela
		DbSelectArea(cAAux)
		DbSetIndex(cArquivo+OrdBagExt())
	
		ProcRegua(1000000)
		(cAAux)->(DbGoTop()) // Posiciona no primeiro registro filtrado.

		While !(cAAux)->(Eof())
			IncProc("Excluindo registro duplicado: " + (cAAux)->(&(SX2AUX->X2_UNICO)) )                      
			QOut("Excluindo registro duplicado: " + (cAAux)->(&(SX2AUX->X2_UNICO)) + " " + DtoC(Date()) + " " + Time())
            
			If cAnter == (cAAux)->(&(SX2AUX->X2_UNICO))
				If !(cAAux)->(DELETED()) // Se não estiver excluído
					aadd(aLinha, "Excluindo registro duplicado: " + (cAAux)->(&(SX2AUX->X2_UNICO)) + " " + DtoC(Date()) + " " + Time() ) // Salva em log o valor antido para voltar depois da migração
					(cAAux)->(DbDelete()) // Exclui registro posicionado
				EndIf
			EndIf
			cAnter := (cAAux)->(&(SX2AUX->X2_UNICO))
			(cAAux)->(DbSkip())
		EndDo  
		QOut("Registros filtrados excluídos: " + DtoC(Date()) + " " + Time())

		fLog(aLinha,cLog,cNome)					
		FErase(cArquivo+OrdBagExt())

		(cAAux)->(DbCloseArea())	
		SX2AUX->(DBCloseArea())   
	
	Else
		QOut("Tabela " + cTabela + " não encontrada do SX2"+ DtoC(Date()) + " " + Time())
	EndIf
		
	RestArea(cAreaTMP)

Return

Static Function LeEmp() // Lê empresas e gera vetor contendo todas elas
	Local cTabela := cSystem + "sigamat.emp"
	Local aEmp := {} 
	Local cAAux := "SigamatAUX"
	Local cAnter := "" // Variável que armazenará o registro anterior ao que será comparado

	Local cArquivo
	Local cFor
	Local nIndex
	
	Local cAreaTMP := ""  
	cAreaTMP := GetArea()
	
	DBUseArea( .T.,cDriver,cTabela, cAAux, .F. ) // Abre sigamat.emp
	cArquivo := CriaTrab( NIL, .F. ) //Criando Arquivo de índice
	cFor := ""
	IndRegua( cAAux, cArquivo, "M0_CODIGO+M0_CODFIL", , cFor)
	DbSelectArea(cAAux)
	DbSetIndex(cArquivo+OrdBagExt())
	
	If File(cTabela) // Se a tabela existir continua.
		
		While !(cAAux)->(Eof())
			If (cAAux)->M0_CODIGO == cAnter // Só armazena o número da empresa se for diferente que o registro anterior
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
	Local cAnter := "" // Variável que armazenará o registro anterior ao que será comparado

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
					aadd(aLinha, "X2_UNICO em branco: " + (cAAux)->X2_CHAVE + " " + DtoC(Date()) + " " + Time() ) // Salva em log o valor antigo para voltar depois da migração
					
			EndIf
			
			(cAAux)->(DbSkip())
		EndDo  
		QOut("Registros filtrados listados: " + DtoC(Date()) + " " + Time())

		fLog(aLinha,cLog,cNome)					
		FErase(cArqSX2+OrdBagExt())

		(cAAux)->(DbCloseArea())	
		
	RestArea(cAreaTMP)

Return
