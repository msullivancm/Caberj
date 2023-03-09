#INCLUDE "PROTHEUS.CH"
#INCLUDE "RWMAKE.CH"

#DEFINE CRLF CHR(13)+CHR(10)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABA565   º Autor ³ Angelo Henrique    º Data ³  16/02/16   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Rotina utilizada para atualizar a base de CEP oriunda dos  º±±
±±º          ³ correios.                                                  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºObservação³ A rotina foi desenvolvida originalmente por Otávio Pinto,  º±±
±±º          ³ como o correios alterou algumas posições , a estrutura     º±±
±±º          ³ do layout e os arquivos, será criada uma nova versão desta º±±
±±º          ³ rotina.                                                    º±±
±±º          ³ A versão anterior se encontra no final deste fonte, foi    º±±
±±º          ³ deixada intacta para fins de consulta.                     º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CABERJ                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/


User Function CABA565()
	
	Local _aArea 		:= GetArea()
	Local cArq 		:= ''
	Local cPath		:= ''
	Local nTipoAj		:= 0
	Local nI			:= 0
	Local nCount		:= 0
	
	Private _oDlg		:= Nil
	Private _oBtn		:= Nil
	Private _oSay		:= Nil
	Private _oGroup	:= Nil
	Private oFont		:= Nil
	
	Private aFiles	:= {}
	Private aSizes	:= {}
	Private _cLibera 	:= GetNewPar("MV_YATUCEP","000024,000668,000786,000000")
	
	//------------------------------------------------------------
	//Validação para saber se o usuário possui acesso a rotina
	//------------------------------------------------------------
	//If !( __cUserID $ AllTrim(_cLibera))
		
		MsgAlert("Acesso permitido somente aos usuarios habilitados a executar esta rotina!"+CHR(13)+CHR(13)+;
			"SOLUCAO: Incluir ID do usuario no parametro MV_YATUCEP."+CHR(13)+CHR(13)+;
			"Verifique com sua gerencia.", "AVISO" )
		
	//Else
		
		//=======================================================================
		//Validação para saber qual é o arquivo que será importado/atualizado
		//=======================================================================
		DEFINE MSDIALOG _oDlg FROM 0,0 TO 110,500 PIXEL TITLE "Atualização de CEP"
		
		_oGroup:= tGroup():New(05,05,55,245,"Atualização de CEP",_oDlg,,,.T.)
		
		@ 015, 016 SAY "Rotina de importação/atualização do CEP, arquivo disponibilizado pelos correios." SIZE 200,20 OF _oDlg PIXEL
		@ 025, 016 SAY "Favor selecionar uma das opções abaixo." SIZE 200,20 OF _oDlg PIXEL
		
		_oBtn := TButton():New( 040,010,"Localidades"	,_oDlg,{||_oDlg:End(),_nOpc := 1	},050,012,,,,.T.,,"",,,,.F. )
		_oBtn := TButton():New( 040,070,"Logradouros"	,_oDlg,{||_oDlg:End(),_nOpc := 2	},050,012,,,,.T.,,"",,,,.F. )
		_oBtn := TButton():New( 040,180,"Fechar"		,_oDlg,{||_oDlg:End()				},050,012,,,,.T.,,"",,,,.F. )
		
		ACTIVATE MSDIALOG _oDlg CENTERED
		
		If _nOpc = 1 //Rotina de importação das localidades
			
			cArq :=  cGetFile( '*.txt' , 'Textos (TXT)', 1, 'C:\', .T., GETF_LOCALHARD)
			
			If !Empty(cArq)
				
				Processa({||CABA565A(cArq)},'Atualização das localidades ','Processando...',.F.)
				
			Else
				
				MsgStop('Informe um arquivo!',AllTrim(SM0->M0_NOMECOM))
				
			EndIf
			
		ElseIf _nOpc = 2 //Rotina de importação de logradouros
			
			nTipoAj	:= Aviso('Atenção','Deseja processar 1 arquivo ou todos os arquivos do diretório?',{'1 arquivo','Diretório','Cancelar'})
			
			If nTipoAj = 1
				
				cArq :=  cGetFile( '*.txt' , 'Textos (TXT)', 1, 'C:\', .T., GETF_LOCALHARD)
				
				If !Empty(cArq)
					
					Processa({||CABA565B(cArq,"1")},'Atualizadação dde Logradouros ','Processando...',.F.)
					
				Else
					
					MsgStop('Informe um arquivo!',AllTrim(SM0->M0_NOMECOM))
					
				EndIf
				
			ElseIf nTipoAj = 2
				
				cPath :=  cGetFile( '*.txt' , 'Textos (TXT)', 1, 'C:\', .F., nOR( GETF_LOCALHARD, GETF_LOCALFLOPPY, GETF_RETDIRECTORY ),.T.,.T.)
				
				nCount 	:= aDir(AllTrim(cPath) + "*.txt", aFiles, aSizes)
				
				For nI := 1 to nCount
					
					cArq := cPath + aFiles[nI]
					Processa({||CABA565B(cArq,"2")},'Atualização dos Logradouros','Processando...',.F.)
					
				Next
				
				cMsg := 'Atualização dos logradouros finalizado!' 				+ CRLF				
				
				MsgAlert(cMsg,AllTrim(SM0->M0_NOMECOM))
				
			EndIf
			
		EndIf
		
	//EndIf
	
	RestArea(_aArea)
	
Return


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABA565A  º Autor ³ Angelo Henrique    º Data ³  16/02/16   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Rotina utilizada para atualizar as localidades oriunda dos º±±
±±º          ³ correios.                                                  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CABERJ                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function CABA565A(cArq,_cParam)
	
	Local _aArea 		:= GetArea()
	Local _aArBID		:= BID->(GetArea()) //Cadastro de Municipios
	Local nHandle		:= 0
	Local nPosDiv		:= RAt('\',cArq)
	Local cNomArq 	:= Substr(cArq,nPosDiv+1,Len(cArq)-nPosDiv)
	Local cNovoNome	:= Stuff(cNomArq,At('.',cNomArq),At('.',cNomArq),".LOG")
	Local cPathArq 	:= Left(cArq,nPosDiv)
	Local nHandle 	:= FT_FUse(cArq)
	Local cLine		:= ""
	Local nQtd 		:= 0
	Local nLinOri 	:= 0
	Local cTot 		:= ""
	Local aNewArq		:= {}
	Local cNewLine	:= ""
	Local _lAchou		:= .F.
	Local cBuffer		:= ""
	Local cMsg			:= ""
	Local nHdl			:= 0
	Local _aNotLn		:= {}
	
	Default _cParam 	:= "1"
	
	FT_FGoTop()
	
	nLinOri := FT_FLastRec()
	cTot 	:= AllTrim(Transform(nLinOri, "@E 999,999,999"))
	
	ProcRegua(nLinOri)
	
	nQtd := 0
	
	FT_FGoTop()
	
	While !FT_FEOF()
		
		IncProc('Linha: ' + AllTrim(Transform(++nQtd, "@E 999,999,999")) + ' de ' + cTot)
		
		cLine := FT_FReadLn() //Retorna a linha corrente
		
		If !Empty(AllTrim(cLine))
			
			//------------
			//Se for item
			//------------
			If SUBSTR(cLine,001,01) == "D"
				
				//--------------------------------------
				//Validação Código IBGE do Município
				//--------------------------------------
				If !Empty(SUBSTR(cLine,155,07))
					
					//-----------------------------------------------
					//Inicio da pesquisa na tabela de municipios
					//-----------------------------------------------
					DbSelectArea("BID")
					DbSetOrder(1)
					_lAchou := DbSeek(xFilial("BID")+SUBSTR(cLine,155,07))
					
					RecLock("BID", !_lAchou)
					
					BID->BID_FILIAL 	:= xFilial("BID")
					BID->BID_CODMUN 	:= SUBSTR(cLine,155,08)
					BID->BID_DESCRI 	:= UPPER(FwNoAccent(SUBSTR(cLine,020,72)))
					BID->BID_EST    	:= SUBSTR(cLine,004,02)
					BID->BID_XCHCC2 	:= SUBSTR(cLine,004,02)+SUBSTR(cLine,157,05)  // CHAVE NO CC2  Exemplo: AM 0029 =  1300029
					
					BID->(MsUnlock())
					
					//----------------------------------------------------------
					//Adicionando em um array as informações para gravar no log
					//Registros incluidos e alterados
					//----------------------------------------------------------
					If _lAchou
						
						cNewLine := "Registro Alterado: " + CRLF
						
					Else
						
						cNewLine := "Registro Criado: " + CRLF
						
					EndIf
					
					cNewLine += "Municipio: " 	+ SUBSTR(cLine,155,08) 									+ ";"
					cNewLine += "Descrição: " 	+ AllTrim(UPPER(FwNoAccent(SUBSTR(cLine,020,72)))) 	+ ";"
					cNewLine += "Estado: " 		+ AllTrim(SUBSTR(cLine,004,02))							+ CRLF
					
					aAdd(aNewArq, cNewLine)
					
				Else
					
					//----------------------------------------------------------
					//Adicionando em um array as informações para gravar no log
					//Registros Não Incluídos
					//----------------------------------------------------------
					cNewLine := "Registro sem codigo IBGE: " + CRLF
					cNewLine += "Municipio: " 	+ AllTrim(UPPER(FwNoAccent(SUBSTR(cLine,020,72)))) 	+ ";"
					cNewLine += "Estado: " 		+ AllTrim(SUBSTR(cLine,004,02))							+ CRLF
					
					aAdd(_aNotLn, cNewLine)
					
				EndIf
				
			EndIf
			
		EndIf
		
		FT_FSKIP()
		
	EndDo
	
	//------------------
	// Fecha o Arquivo
	//------------------
	FCLOSE(nHandle)
	FT_FUSE()
	
	//-----------------------------------------------------------------
	//Criando arquivo de LOG
	//Case já existe o mesmo será apagado e um novo será criado
	//-----------------------------------------------------------------
	If File(cPathArq + cNovoNome)
		
		If ( FErase(cPathArq + cNovoNome) <> 0 )
			
			MsgStop('Erro ao deletar o arquivo [ ' + cPathArq + cNovoNome + ' ].' + CRLF + 'Operação cancelada...',AllTrim(SM0->M0_NOMECOM))
			Return
			
		EndIf
		
	EndIf
	
	//-----------------------------------------||
	//Inicio do Processo de Montagem do LOG	 ||
	//-----------------------------------------||
	If Len(aNewArq) > 0 .Or. Len(_aNotLn) > 0
		
		nHdl := FCreate(cPathArq + cNovoNome)
		
		nQtd := Len(aNewArq)
		cTot := AllTrim(Transform(nQtd, "@E 999,999,999"))
		
		ProcRegua(nQtd)
		
		IncProc("Inicio da criação do arquivo de LOG")
		
		For nI := 1 to Len(aNewArq)
			
			IncProc('Gerando arquivo, registros alterados e incluidos. Linha: ' + AllTrim(Transform(nI, "@E 999,999,999")) + ' de ' + cTot)
			
			cBuffer	:= aNewArq[nI] + CRLF
			
			FWrite(nHdl,cBuffer,len(cBuffer))
			
		Next
		
		nQtd := Len(aNewArq)
		cTot := AllTrim(Transform(nQtd, "@E 999,999,999"))
		
		ProcRegua(nQtd)
		
		For nI := 1 to Len(_aNotLn)
			
			IncProc('Gerando arquivo, registros não incluidos. Linha: ' + AllTrim(Transform(nI, "@E 999,999,999")) + ' de ' + cTot)
			
			cBuffer	:= _aNotLn[nI] + CRLF
			
			FWrite(nHdl,cBuffer,len(cBuffer))
			
		Next
		
		FClose(nHdl)
		
		If _cParam == "1"
			
			If File(cPathArq + cNovoNome)
				
				cMsg := 'Atualização das localidades finalizado!' 				+ CRLF
				cMsg += '- Arquivo [ ' + cPathArq + cNovoNome + ' ] gerado.' 	+ CRLF
				
				MsgAlert(cMsg,AllTrim(SM0->M0_NOMECOM))
				
			Else
				
				MsgStop('Ocorreu algum erro na criação do arquivo [ ' + cPathArq + cNovoNome + ' ]. Verifique...',AllTrim(SM0->M0_NOMECOM))
				
			EndIf
					
		EndIf
		
	Else
		
		If _cParam == "1"
			
			cMsg := 'Atualização das localidades finalizado!' + CRLF
		
			MsgAlert(cMsg,AllTrim(SM0->M0_NOMECOM))
		
		EndIf
		
	EndIf
	
	RestArea(_aArBID)
	RestArea(_aArea)
	
Return


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABA565B  º Autor ³ Angelo Henrique    º Data ³  16/02/16   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Rotina utilizada para atualizar os logradouros oriunda dos º±±
±±º          ³ correios.                                                  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CABERJ                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function CABA565B(cArq, _cParam)
	
	Local _aArea 		:= GetArea()
	Local _aArBC9		:= BC9->(GetArea()) //Cadastro de CEP's
	Local nHandle		:= 0
	Local nPosDiv		:= RAt('\',cArq)
	Local cNomArq 	:= Substr(cArq,nPosDiv+1,Len(cArq)-nPosDiv)
	Local cNovoNome	:= Stuff(cNomArq,At('.',cNomArq),At('.',cNomArq),".LOG")
	Local cPathArq 	:= Left(cArq,nPosDiv)
	Local nHandle 	:= FT_FUse(cArq)
	Local cLine		:= ""
	Local nQtd 		:= 0
	Local nLinOri 	:= 0
	Local cTot 		:= ""
	Local aNewArq		:= {}
	Local cNewLine	:= ""
	Local _lAchou		:= .F.
	Local cBuffer		:= ""
	Local cMsg			:= ""
	Local nHdl			:= 0
	Local _aNotLn		:= {}
	
	Default _cParam 	:= "1"
	
	FT_FGoTop()
	
	nLinOri:= FT_FLastRec()
	cTot 	:= AllTrim(Transform(nLinOri, "@E 999,999,999"))
	
	ProcRegua(nLinOri)
	
	nQtd 	:= 0
	
	FT_FGoTop()
	
	While !FT_FEOF()
		
		IncProc('Linha: ' + AllTrim(Transform(++nQtd, "@E 999,999,999")) + ' de ' + cTot)
		
		cLine := FT_FReadLn() //Retorna a linha corrente
		
		If !Empty(AllTrim(cLine))
			
			If  SUBSTR(cLine,519,08) == "25935442"
			
				_aaa := ""
			
			EndIf
			
			//------------
			//Se for item
			//------------
			If SUBSTR(cLine,001,01) $ "D|S|N"
				
				//--------------------------------------
				//Validação Código CEP
				//--------------------------------------
				If !Empty(SUBSTR(cLine,519,08))
					
					//-----------------------------------------------
					//Inicio da pesquisa na tabela de municipios
					//-----------------------------------------------
					DbSelectArea("BC9")
					DbSetOrder(1)
					_lAchou := DbSeek(xFilial("BC9")+SUBSTR(cLine,519,08))
					
					RecLock("BC9", !_lAchou)
					
					BC9->BC9_FILIAL := xFilial("BC9")
					BC9->BC9_CEP    := SUBSTR(cLine,519,08)
					BC9->BC9_END    := ALLTRIM(UPPER(FwNoAccent(SUBSTR(cLine,447,36))))
					BC9->BC9_CODMUN := POSICIONE("BID",3, xFilial("BID") + SUBSTR(cLine,002,02) + ALLTRIM(UPPER(FwNoAccent(SUBSTR(cLine,018,72)))), "BID_CODMUN")
					BC9->BC9_BAIRRO := FwNoAccent(AllTrim(UPPER(SUBSTR(cLine,103,72))))
					BC9->BC9_MUN    := UPPER(FwNoAccent(ALLTRIM(SUBSTR(cLine,018,72))))
					BC9->BC9_EST    := UPPER(SUBSTR(cLine,002,02))
					BC9->BC9_YCOMP  := UPPER(FwNoAccent(ALLTRIM(SUBSTR(cLine,483,36))))
					BC9->BC9_TIPLOG := POSICIONE("B18",2,xFilial("B18") + UPPER(FwNoAccent(AllTrim(SUBSTR(cLine,260,26)))), "B18_CODIGO")
					
					BC9->(MsUnlock())
					
					//----------------------------------------------------------
					//Adicionando em um array as informações para gravar no log
					//Registros incluidos e alterados
					//----------------------------------------------------------
					If _lAchou
						
						cNewLine := "Registro Alterado: " + CRLF
						
					Else
						
						cNewLine := "Registro Criado: " + CRLF
						
					EndIf
					
					cNewLine += "CEP: " 			+ SUBSTR(cLine,519,08) 									+ ";"
					cNewLine += "ENDEREÇO: " 	+ ALLTRIM(UPPER(FwNoAccent(SUBSTR(cLine,447,36)))) 	+ ";"
					cNewLine += "MUNICIPIO: " 	+ POSICIONE("BID",3, xFilial("BID") + SUBSTR(cLine,002,02) + ALLTRIM(UPPER(FwNoAccent(SUBSTR(cLine,018,72)))), "BID_CODMUN")+ ";"
					cNewLine += "DESCRIÇÃO: " 	+ UPPER(FwNoAccent(ALLTRIM(SUBSTR(cLine,018,72)))) 	+ ";"
					cNewLine += "ESTADO: " 		+ UPPER(SUBSTR(cLine,002,02))						 	+ CRLF
					
					aAdd(aNewArq, cNewLine)
					 
				Else
					
					//----------------------------------------------------------
					//Adicionando em um array as informações para gravar no log
					//Registros Não Incluídos
					//----------------------------------------------------------
					cNewLine += "CEP: " 			+ SUBSTR(cLine,519,08) 									+ ";"
					cNewLine += "ENDEREÇO: " 	+ ALLTRIM(UPPER(FwNoAccent(SUBSTR(cLine,447,36)))) 	+ ";"
					cNewLine += "MUNICIPIO: " 	+ POSICIONE("BID",3, xFilial("BID") + SUBSTR(cLine,002,02) + ALLTRIM(UPPER(FwNoAccent(SUBSTR(cLine,018,72)))), "BID_CODMUN")+ ";"
					cNewLine += "DESCRIÇÃO: " 	+ UPPER(FwNoAccent(ALLTRIM(SUBSTR(cLine,018,72)))) 	+ ";"
					cNewLine += "ESTADO: " 		+ UPPER(SUBSTR(cLine,002,02))						 	+ CRLF
					
					aAdd(_aNotLn, cNewLine)
					
				EndIf
				
			EndIf
			
		EndIf
		
		FT_FSKIP()
		
	EndDo
	
	// Fecha o Arquivo
	FCLOSE(nHandle)
	FT_FUSE()
	
	//-----------------------------------------------------------------
	//Criando arquivo de LOG
	//Case já existe o mesmo será apagado e um novo será criado
	//-----------------------------------------------------------------
	If File(cPathArq + cNovoNome)
		
		If ( FErase(cPathArq + cNovoNome) <> 0 )
			
			MsgStop('Erro ao deletar o arquivo [ ' + cPathArq + cNovoNome + ' ].' + CRLF + 'Operação cancelada...',AllTrim(SM0->M0_NOMECOM))
			Return
			
		EndIf
		
	EndIf
	
	nHdl := FCreate(cPathArq + cNovoNome)
	
	nQtd := len(aNewArq)
	cTot := AllTrim(Transform(nQtd, "@E 999,999,999"))
	
	ProcRegua(nQtd)
	
	IncProc("Inicio da criação do arquivo de LOG")
	
	For nI := 1 to len(aNewArq)
		
		IncProc('Gerando arquivo, registros alterados e incluidos. Linha: ' + AllTrim(Transform(nI, "@E 999,999,999")) + ' de ' + cTot)
		
		cBuffer	:= aNewArq[nI] + CRLF
		
		FWrite(nHdl,cBuffer,len(cBuffer))
		
	Next
	
	nQtd := len(aNewArq)
	cTot := AllTrim(Transform(nQtd, "@E 999,999,999"))
	
	ProcRegua(nQtd)
	
	For nI := 1 to len(_aNotLn)
		
		IncProc('Gerando arquivo, registros não incluidos. Linha: ' + AllTrim(Transform(nI, "@E 999,999,999")) + ' de ' + cTot)
		
		If nI = 1
			
			cBuffer	:= "Registro sem codigo CEP:" + CRLF

			FWrite(nHdl,cBuffer,len(cBuffer))
			
		EndIf
		
		cBuffer	:= _aNotLn[nI] + CRLF
		
		FWrite(nHdl,cBuffer,len(cBuffer))
		
	Next
	
	FClose(nHdl)
	
	If File(cPathArq + cNovoNome)
		
		If _cParam == "1"
		
			cMsg := 'Atualizadação dos logradouros finalizado!' 					+ CRLF
			cMsg += '- Arquivo [ ' + cPathArq + cNovoNome + ' ] gerado.' 		+ CRLF
			
			MsgAlert(cMsg,AllTrim(SM0->M0_NOMECOM))
			
		EndIf
		
	Else
		
		MsgStop('Ocorreu algum erro na criação do arquivo [ ' + cPathArq + cNovoNome + ' ]. Verifique...',AllTrim(SM0->M0_NOMECOM))
		
	EndIf
	
	RestArea(_aArBC9)
	RestArea(_aArea)
	
Return

//-----------------------------------------------------------------------------------------------------------------	||
// Angelo Henrique - Data: 16/02/2016																							||
//-----------------------------------------------------------------------------------------------------------------	||
//Comentado as linhas abaixo pois saiu um novo layout a maioria das informações continuam em suas posições			||
//porém todas as validações feitas para a versão anterior não se adequam nesta nova versão, para que o  				||
//fonte não ficasse todo comentado, achei melhor preservar a versão anterior e criar uma nova							||
//-----------------------------------------------------------------------------------------------------------------	||

//
//
///*
// //////////////////////////////////////////////////////////////////////////////
// /  PROGRAMA : CABA565.PRW
// /             Atualiza o cadastro CEPs (BC9), do arquivo texto dos Correios.
// /             OBS: Utilize os arquivos:
// /                  DNE_DLT_LOGRADOUROS.TXT renomeie para LOGR.TXT
// /             Otavio Pinto em 03.04.2014
// /             EMPRESA 1=CABERJ  2=INTEGRAL
// //////////////////////////////////////////////////////////////////////////////
//*/
//
//user function CABA565()
//private nEmpresa := SM0->M0_CODIGO  ,;
	//        cRotaTXT := GetNewPar("MV_YARQCEP","C:\TEMP\") ,;
	//        cLibera  := GetNewPar("MV_YATUCEP","000024,000668,000786,000000")
//
////000000 - Administrador
////000024 - piumbim
////000668 - otavo.salvador
////000786 - marcos.bellio
//
//
////Pergunte("CABA565",.F.)
//
///*
//mv_par01 := Local do arquivo
//mv_par02 := Nome do arquivo
//mv_par03 := Nao definido
//*/
//
////begin sequence
//    if !( __cUserID $ AllTrim(cLibera) )
//       MsgAlert("Acesso permitido somente aos usuarios habilitados a executar esta rotina!"+CHR(13)+CHR(13)+;
	//                "SOLUCAO: Incluir ID do usuario no parametro MV_YATUCEP."+CHR(13)+CHR(13)+;
	//                "Verifique com sua gerencia.", "AVISO" )
//       break
//    endif
//
//    if MsgBox("Atualização do cadastro de CEPs"+chr(13)+chr(13)+"Importante ler a documentação sobre este procedimento."+chr(13)+"Confirma a atualização ?",;
	//              "Rotina de Manutencao",;
	//              "YESNO")
//       dbSelectArea("BID") ; BID->( dbSetOrder(3) )    /*Cadastro de Municipios*/
//       dbSelectArea("B18") ; B18->( dbSetOrder(2) )    /*Cadastro de Tipos de Logradouros*/
//       dbSelectArea("BC9") ; BC9->( dbSetOrder(1) )    /*Cadastro de CEPs*/
//
//       Processa({|| F_EXPORT() })
//
//    endif
////end sequence
//
//return
//
//
//
///*
//  F_EXPORT()
//  Faz leitura do arquivo texto e atualiza o cadastro de Ceps (BC9)
//*/
//static function F_EXPORT()
//local npTam
//local aTabela := {"LOCA","LOGR"}
//
//private cEnter    := CHR(13)+CHR(10)
//private nLin      := 0
//private nCol1
//private nHandle
//private cBuffer
//
//For x := 1 to len( aTabela )
//
//    _cArq := cRotaTXT+aTabela[x]+".LOG"
//
//    If File( _cArq ) ; FErase( _cArq ) ; Endif
//
//    nHandle := FCreate( _cArq )
//
//    if nHandle == -1
//       MsgAlert("O arquivo "+AllTrim( _cArq )+" nao pode ser criado! Verifique os parametros.","Atencao !")
//       Exit
//    endif
//
//    ARQUIVO := cRotaTXT+aTabela[x]+".TXT"
//
//    do Case
//       case x == 1
//            dbSelectArea("BID")
//            BID->( dbSetOrder(1) )
//            npTam := 172
//            nCol1 := 150
//            if file(ARQUIVO)
//               Arq     := fOpen(ARQUIVO,0)
//               Tam     := fSeek(Arq,1,npTam)
//               String  := fReadStr(Arq,npTam)
//               lEntra  := .F.
//
//               while !EMPTY(String)
//                   /*
//                    IndRegua("BID",cIndex,cChave)  //"Selecionando Registros..."
//                   */
//                   if lEntra
//                      String  := fReadStr(Arq,npTam)
//                   endif
//                   if SUBSTR(String,001,01) == "D"
//                      lPassou := .F.
//                      if SUBS(String,162,01) == "U" .AND. !Empty(SUBSTR(String,155,07))
//                         //BID->( dbSetOrder(3) )
//                         if BID->(  dbSeek( xFilial("BID")+SUBSTR(String,155,07) ) ) //BID_FILIAL+BID_CODMUN
//                            lLock   := .F.
//                            lPassou := .T.
//                         else
//                            BID->( DBGOTOP() )
//                            lPassou := .F.
//                         endif
//                      endif
//                      if SUBS(String,162,01) == "I"  .AND. !Empty(SUBSTR(String,155,07))
//                         if BID->(  dbSeek( xFilial("BID")+SUBSTR(String,155,07) ) ) //BID_FILIAL+BID_CODMUN
//                            BID->( DBGOTOP() )
//                            lLock   := .F.
//                            lPassou := .T.
//                         else
//                            BID->( DBGOTOP() )
//                            lLock   := .T.
//                            lPassou := .T.
//                         endif
//                      endif
//
//                      if lPassou
//
//                          /*------------------------------------------------------------------
//                          | GRAVA DADOS NA TABELA BID...                                      |
//                           ------------------------------------------------------------------*/
//
//                          RecLock( "BID" , lLock )
//                          BID->BID_FILIAL := ""
//                          BID->BID_CODMUN := SUBSTR(String,155,08)
//                          BID->BID_DESCRI := UPPER(caixaalta(SUBSTR(String,020,72)))
//                          BID->BID_EST    := SUBSTR(String,004,02)
//                          if B18->( dbSeek( xFilial("B18")+ALLTRIM(caixaalta(SUBS(String,20,72),2)) ) )
//                             BID->BID_YDDD  := B18->B18_CODIGO
//                          endif
//                          BID->BID_XCHCC2 := SUBSTR(String,004,02)+SUBSTR(String,157,05)  // CHAVE NO CC2  Exemplo: AM 0029 =  1300029
//                          BID->( MsUnlock() )
//
//                          /*------------------------------------------------------------------
//                          | GERA e PRINTA LINHA PARA O LOG...                                 |
//                           ------------------------------------------------------------------*/
//                          cBID_FILIAL := " "
//                          cBID_CODMUM := SUBSTR(String,155,07)
//                          cBID_DESCRI := UPPER(caixaalta(SUBSTR(String,020,72)))
//                          cBID_EST    := SUBSTR(String,004,02)
//                          cBID_YDDD   := "  "
//                          if B18->( dbSeek( xFilial("B18")+ALLTRIM(caixaalta(SUBS(String,20,72),2)) ) )
//                             cBID_YDDD  := B18->B18_CODIGO
//                          endif
//                          cBID_XCHCC2 := if ( !Empty(SUBSTR(String,157,05)), SUBSTR(String,004,02)+SUBSTR(String,157,05),"") // CHAVE NO CC2  Exemplo: AM 0029 =  1300029
//
//                          _cLinha:= PADR( cbid_filial , 2," ")+" "+;
	//                                    PADR( cbid_codmun , 8," ")+" "+;
	//                                    PADR( cbid_descri ,72," ")+" "+;
	//                                    PADR( cbid_Est    , 2," ")+" "+;
	//                                    PADR( cbid_YDDD   , 3," ")+" "+;
	//                                    PADR( cbid_XCHCC2 , 7," ")+" "+;
	//                                    PADR( SUBS(String,162,01) , 1," ")
//
//                          cBuffer :=  PADR( _cLinha ,nCol1,"") + cEnter
//                          FWrite(nHandle, cBuffer)
//                      endif
//                   endif
//                   lEntra := .T.
//
//               enddo
//            endif
//            fClose(ARQUIVO)
//       case x == 2
//            BID->( dbSetOrder(3) )
//            dbSelectArea("BC9")
//            BC9->( dbSetOrder(1) )
//            npTam := 635
//            nCol1 := 255
//            if file(ARQUIVO)
//               Arq     := fOpen(ARQUIVO,0)
//               Tam     := fSeek(Arq,1,npTam)
//               String  := fReadStr(Arq,npTam)
//               lEntra  := .F.
//               while !EMPTY(String)
//                   /*
//                    IndRegua("BC9",cIndex,cChave,,cFor,STR0018)  //"Selecionando Registros..."
//                   */
//                   if lEntra
//                      String  := fReadStr(Arq,npTam)
//                   endif
//
//                   if SUBS(String,001,01) == "D" .and. SUBS(String,528,01) == "S"
//                      lPassou := .F.
//                      if SUBS(String,529,01) == "I"
//                         if BC9->( !dbSeek( xFilial("BC9")+SUBSTR(String,519,08) ) )   // VERIFICA SE EXISTE O CEP...
//                            lPassou := .T.
//                            lLock   := .T.
//                            BC9->( DBGOTOP() )
//                         else
//                            lPassou := .T.
//                            lLock   := .F.
//                         endif
//
//                      endif
//                      if SUBS(String,529,01) == "U"
//                         if BC9->( dbSeek( xFilial("BC9")+SUBSTR(String,519,08) ) )   // VERIFICA SE EXISTE O CEP...
//                            lPassou := .T.
//                            lLock   := .F.
//                         else
//                            lPassou := .F.
//                         endif
//                      endif
//                      if lPassou
//                          /*------------------------------------------------------------------
//                          | GRAVA DADOS NA TABELA BID...                                      |
//                           ------------------------------------------------------------------*/
//
//                          RecLock( "BC9" , lLock )
//	                      BC9->bc9_filial := ""
//	                      BC9->bc9_cep    := SUBSTR(String,519,08)
//	                      BC9->bc9_end    := Alltrim(UPPER(caixaalta(SUBSTR(String,447,36),1)))
//	                      //BID->( dbSetOrder(3) )  //BID_FILIAL+BID_EST+BID_DESCRI
//	                      BC9->bc9_codmun := if ( BID->( dbSeek(xFilial("BID")+SUBSTR(String,002,02)+UPPER(caixaalta(SUBSTR(String,018,72))) ) ) ,BID->BID_CODMUN, "")
//	                      //BID->( dbSetOrder(1) )  //BID_FILIAL+BID_CODMUN
//	                      BC9->bc9_bairro := caixaalta(UPPER(SUBSTR(String,103,72)),1)
//	                      BC9->bc9_mun    := Alltrim(UPPER(caixaalta(SUBSTR(String,018,72),1)))
//	                      BC9->bc9_est    := SUBSTR(String,002,02)
//	                      BC9->bc9_ycomp  := Alltrim(UPPER(caixaalta(SUBSTR(String,483,36),1)))
//	                      BC9->bc9_tiplog := SPACE(3)
//	                      if B18->( dbSeek( xFilial("B18")+ALLTRIM(caixaalta(SUBS(String,260,26),2)) ) )
//	                         BC9->bc9_tiplog  := B18->B18_CODIGO
//	                      endif
//	                      BC9->bc9_yregia := SPACE(2)
//	                      BC9->( MsUnlock() )
//
//                          /*------------------------------------------------------------------
//                          | GERA e PRINTA LINHA PARA O LOG...                                 |
//                           ------------------------------------------------------------------*/
//
//	                      cbc9_filial := ""
//
//	                      cbc9_cep    := SUBSTR(String,519,08)
//	                      cbc9_end    := Alltrim(UPPER(caixaalta(SUBSTR(String,447,36),1)))
//
//	                      //BID->( dbSetOrder(3) )  //BID_FILIAL+BID_EST+BID_DESCRI
//	                      cbc9_codmun := if ( BID->( dbSeek(xFilial("BID")+SUBSTR(String,002,02)+UPPER(caixaalta(SUBSTR(String,018,72))) ) ) ,BID->BID_CODMUN, "")
//	                      //BID->( dbSetOrder(1) )  //BID_FILIAL+BID_CODMUN
//
//	                      cbc9_bairro := caixaalta(UPPER(SUBSTR(String,103,72)),1)
//	                      cbc9_mun    := Alltrim(UPPER(caixaalta(SUBSTR(String,018,72),1)))
//	                      cbc9_est    := SUBSTR(String,002,02)
//	                      cbc9_ycomp  := Alltrim(UPPER(caixaalta(SUBSTR(String,483,36),1)))
//	                      cbc9_tiplog := SPACE(3)
//	                      if B18->( dbSeek( xFilial("B18")+ALLTRIM(caixaalta(SUBS(String,260,26),2)) ) )
//	                         cbc9_tiplog  := B18->B18_CODIGO
//	                      endif
//	                      cbc9_yregia := SPACE(2)
//
//	                      _cLinha:= PADR( cbc9_filial, 2," ")+" "+;
	//	                                PADR( cbc9_cep   , 8," ")+" "+;
	//	                                PADR( cbc9_end   ,36," ")+" "+;
	//	                                PADR( cbc9_codmun, 8," ")+" "+;
	//	                                PADR( cbc9_bairro,72," ")+" "+;
	//	                                PADR( cbc9_mun   ,72," ")+" "+;
	//	                                PADR( cbc9_est   , 2," ")+" "+;
	//	                                PADR( cbc9_ycomp ,36," ")+" "+;
	//	                                PADR( cbc9_tiplog, 3," ")+" "+;
	//	                                PADR( cbc9_yregia, 2," ")+" "+;
	//                                    PADR( SUBS(String,529,01) , 1," ")
//
//	                      cBuffer :=  PADR( _cLinha ,nCol1,"") + cEnter
//	                      FWrite(nHandle, cBuffer)
//	                      endif
//                   endif
//                   lEntra := .T.
//
//               enddo
//            endif
//            fClose(ARQUIVO)
//
//    endcase
//    FClose(nHandle)
//Next
//
//return
//
//
//
///*
//  caixaalta()
//  Tira acentuação e retorna em caixa alta.
//*/
//static function caixaalta( cCampo, nTip )
//local x := {},;
	//      y := {}
//nTip := if(nTip == Nil, 1, nTip )
//x := if (nTip == 1,{'A','A','E','I','O','U','A','O','A','E','O','C'},{'a','a','e','i','o','u','a','o','a','e','o','c'} )
//y := {'à','á','é','í','ó','ú','ã','õ','â','ê','ô','ç'}
//for ww := 1 to len(y)
//    cCampo := StrTran(if(nTip == 1, UPPER(cCampo),cCampo ),y[ww],x[ww])
//next
//return cCampo
//
///*
//  ValidPerg()
//  Valida as Perguntas do Relatorio
//*/
//static function ValidPerg(cPerg)
//local aArea := GetArea()
//local aRegs := {}
//local nX
//local nY
//
//dbSelectArea("SX1") ; SX1->( dbSetOrder(1) )
//
//cPerg :=PADR(cPerg,len(sx1->x1_grupo))
//
//aAdd(aRegs,{cPerg , "01" , "Local do arquivo ? " , "" , "" , "mv_ch1" , "C" ,  50 , 00 , 0 , "G" , "" , "mv_par01" , "" , "" , "" , "" , "" , "            " , "" , "" , "" , "" , "            " , "" , "" , "" , "" , "               " , "" , "" , "" , "" , "     " , "" , "" , "" , "" , "" , "" })
//aAdd(aRegs,{cPerg , "02" , "Nome do arquivo  ? " , "" , "" , "mv_ch2" , "C" ,  30 , 00 , 0 , "G" , "" , "mv_par02" , "" , "" , "" , "" , "" , "            " , "" , "" , "" , "" , "            " , "" , "" , "" , "" , "               " , "" , "" , "" , "" , "     " , "" , "" , "" , "" , "" , "" })
////aAdd(aRegs,{cPerg , "03" , "A partir da data ? " , "" , "" , "mv_ch3" , "D" ,  08 , 00 , 0 , "G" , "" , "mv_par03" , "" , "" , "" , "" , "" , "            " , "" , "" , "" , "" , "            " , "" , "" , "" , "" , "               " , "" , "" , "" , "" , "     " , "" , "" , "" , "" , "" , "" })
//
//for nX := 1 To Len(aRegs)
//	if !SX1->(dbSeek(cPerg + aRegs[nX,2]))
//		RecLock("SX1",.T.)
//		for nY:=1 To fCount()
//			If nY <= Len(aRegs[nX])
//				SX1->(FieldPut(nY, aRegs[nX,nY]))
//			EndIf
//		next nY
//		MsUnlock()
//	endIf
//next nX
//RestArea(aArea)
//
//return
//  // FIM da rotina CABA565.PRW
//
//