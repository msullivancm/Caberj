#include "Tbiconn.ch"
#include "rwmake.ch"
#include "Topconn.ch"
#include "protheus.ch"
#include "Fileio.ch"
#DEFINE CRLF Chr(13)+Chr(10)

//189 - Acesso ao smartclient html

User Function uAjustaUsu()
Local oTela

	Private cPaisLoc := ''

	// --------------------- Cria Tela Principal ------------
	oTela := TWindow():New( 10, 10, 400, 400, 'Plano de virada',,,,,,,,CLR_BLACK,CLR_WHITE,,,,,,,.T. )
	 
	TMenuBar := TMenuBar():New(oTela)
	TMenuBar:nClrPane := RGB(150,178,133)
	 
	// --------------------- Cria Menu ---------------------
	oTMenu1 := TMenu():New(0,0,0,0,.T.,,oTela)
	TMenuBar:AddItem("uAjustaUsu" , oTMenu1, .T.)
	
	// --------------------- Cria SubMenus ---------------------
	oTMenuItem := TMenuItem():New(oTela,"Altera valores no cadastro de usuarios",,,,{|| iIf(ApMsgYesNo("Executa alteracao","Executa"),AppuUsu(),MsgInfo("Execução cancelada")) },,"AVGLBPAR1",,,,,,,.T.)
	oTMenu1:Add(oTMenuItem)
	          
	oTela:SetMenu(TMenuBar)
	oTela:Activate('MAXIMIZED')
	
Return

Static Function AppuUsu()
	Private oProcess
	RpcSetType(3)
	RpcSetEnv('01')
		oProcess := MsNewProcess():New({|lEnd| AppuUsu1()( @oProcess,@lEnd)} , "Executando processamento", "Aguarde...", .T.)
		oProcess:Activate()
	RpcClearEnv()
Return

Static Function AppuUsu1()
	//	Local aUser := AllUsers(.F.,.T.)
	Local nA          := 0   
	Local nX	:= 0
	Local aPswDet
	Local cPswFile     := "sigapss.spf"
	Local cPswId     := ""
	Local cPswName     := ""
	Local cPswPwd      := ""
	Local cPswDet      := ""
	Local lEncrypt     := .F.
	Local nPswRec     := 0
	Local oOb
	Local cError := ''
	Local cWarning := ''
	Local aUser
	Local aErro	:= {} 
	Local cCodUser	:= "" 
	Local cListaErro := ""
	Local cDir    := "C:\TEMP\"
	Local cArq    := "LOG_SIGAPSS.TXT"
	Local nHandle := FCreate(cDir+cArq)

		
	aUser := FWSFALLUSERS() // lista todos os usuários

	oProcess:SetRegua1(Len(aUser))
    
	If nHandle < 0
		MsgAlert("Erro durante criação do arquivo.")
	Else
		For nX := 1 to Len(aUser)
	
	
			oProcess:IncRegua1("Processando: " + AllTrim(Str(nX)) )                      
	
			if aUser[nX][2] # "000000"
			
				//Abro a Tabela de Senhas
				spf_CanOpen(cPswFile)
				
				nPswRec := spf_Seek( cPswFile , "3U"+aUser[nX][2] , 1 )
				
				if nPswRec > 0
					// Obtenho as Informacoes do usuario retornadas por referencia na variavel cPswDet)
					SPF_GETFIELDS( @cPswFile , @nPswRec , @cPswId, @cPswName, @cPswPwd, @cPswDet )
					//Guardo o XML gerado porque posso precisar dele adiante
				    cPswDetOld	:=	cPswDet
					//Se o XML gerado vem sem o padrao, preciso acrescentar
					If !('<?xml version="1.0" encoding="UTF-8"?>' $ cPswDet) .and. !EMPTY(cPswDet)
						cPswDet	:=	'<?xml version="1.0" encoding="UTF-8"?>' + cPswDet 
					Endif
					//Leio o XML gerado em memória e carrego pra um objeto
					oOb:= XmlParser( cPswDet, "_", @cError, @cWarning ) 
					//Se o Parser reportou erro, testo com outro padrao, e ai uso a variavel cPswDetOld declarada la em cima
					//Uso o Parser novamente para o novo padrao
					If !EMPTY(cError) .and. !EMPTY(cPswDet) 
						cPswDet	:=	'<?xml version="1.0" encoding="iso-8859-1"?>' + cPswDetOld	
						oOb:= XmlParser( cPswDet, "_", @cError, @cWarning ) 
					Endif
					//Sem erro e com a variavel de XML preenchida, sigo o processo
					If EMPTY(cError) .and. !EMPTY(cPswDet) 
						cCodUser	:= oOb:_FWUSERACCOUNTDATA:_DATAUSER:_USR_CODIGO:_VALUE:Text
		
						//If oOb # nil
						//If oOb:_FWUSERACCOUNTDATA:_DATAUSER:_PROTHEUSDATA:_PROTHEUSPRINTER:_USR_DIRIMP:_VALUE:Text # nil
						If 'USR_DIRIMP' $ cPswDet
							// IMPRESSAO
							///oOb:_FWUSERACCOUNTDATA:_DATAUSER:_PROTHEUSDATA:_PROTHEUSPRINTER:_USR_DIRIMP:_VALUE:TEXT := "\SPOOL\"  
							//oOb:_FWUSERACCOUNTDATA:_DATAUSER:_PROTHEUSDATA:_PROTHEUSPRINTER:_USR_DIRIMP:_VALUE:Text := "\SPOOL\"+UPPER(oOb:_FWUSERACCOUNTDATA:_DATAUSER:_USR_CODIGO:_VALUE:TEXT)+"'\'"
							oOb:_FWUSERACCOUNTDATA:_DATAUSER:_PROTHEUSDATA:_PROTHEUSPRINTER:_USR_DIRIMP:_VALUE:Text 			:= "C:\TEMP\"
							oOb:_FWUSERACCOUNTDATA:_DATAUSER:_PROTHEUSDATA:_PROTHEUSPRINTER:_USR_DRIVEIMP:_VALUE:TEXT 			:= "EPSON.DRV"
							
							If 'USR_ENVIMP' $ cPswDet
								oOb:_FWUSERACCOUNTDATA:_DATAUSER:_PROTHEUSDATA:_PROTHEUSPRINTER:_USR_ENVIMP:_VALUE:TEXT		:= "2" // 1 - Servidor / 2 - Cliente
						    Else
						    	QOut("Erro - Nao foi Encontrado Ambiente de Impressao (1-Servidor/2-Cliente). Usuario: --> " + aUser[nX][2])
	                        	cListaErro += "Erro - Nao foi Encontrado Ambiente de Impressao (1-Servidor/2-Cliente). Usuario: --> " + aUser[nX][2] + CRLF
	                        	FWrite(nHandle, cListaErro)   //Gravacao do Arquivo
	                        Endif
	                        
							If 'USR_FORMATOIMP' $ cPswDet
								oOb:_FWUSERACCOUNTDATA:_DATAUSER:_PROTHEUSDATA:_PROTHEUSPRINTER:_USR_FORMATOIMP:_VALUE:TEXT	:= "1"
					 		Else
					 	    	QOut("Erro - Nao foi Encontrado Formato Padrao de Impressao (1-Retrato/2-Paisagem). Usuario: --> " + aUser[nX][2])
					 	    	cListaErro += "Erro - Nao foi Encontrado Formato Padrao de Impressao (1-Retrato/2-Paisagem). Usuario: --> " + aUser[nX][2] + CRLF
					 			FWrite(nHandle, cListaErro)   //Gravacao do Arquivo
					 		Endif
							
							If 'USR_TIPOIMP' $ cPswDet
								oOb:_FWUSERACCOUNTDATA:_DATAUSER:_PROTHEUSDATA:_PROTHEUSPRINTER:_USR_TIPOIMP:_VALUE:TEXT	:= "1" 
							Else
						    	QOut("Erro - Nao foi Encontrado Tipo de Impressao (1-Disco/2-Windows/3-Porta). Usuario: --> " + aUser[nX][2])
						    	cListaErro += "Erro - Nao foi Encontrado Tipo de Impressao (1-Disco/2-Windows/3-Porta). Usuario: --> " + aUser[nX][2] + CRLF
								FWrite(nHandle, cListaErro)   //Gravacao do Arquivo
							Endif
							
							// FIM IMPRESSAO 
						Else
					  		QOut("Erro - Nao foi Encontrado Caminho de Impressora. Usuario: --> " + aUser[nX][2]) 
					  		cListaErro += "Erro - Nao foi Encontrado Caminho de Impressora. Usuario: --> " + aUser[nX][2] + CRLF
							FWrite(nHandle, cListaErro)   //Gravacao do Arquivo
							loop
						EndIf
						
						If oOb:_FWUSERACCOUNTDATA:_DATAUSER:_USR_ANO:_VALUE:TEXT <> '4' 
							oOb:_FWUSERACCOUNTDATA:_DATAUSER:_USR_ANO:_VALUE:TEXT	:=	'4'
						Endif				
					Else
						QOut("Erro - Estrutura de Perfil de Impressao Precisa de Atenção - REVISAR. Usuario: --> " + aUser[nX][2])
						cListaErro += "Erro - Estrutura de Perfil de Impressao Precisa de Atenção - REVISAR. Usuario: --> " + aUser[nX][2] + CRLF
						FWrite(nHandle, cListaErro)   //Gravacao do Arquivo
						loop
					Endif
					
					cPswDet := XMLSaveStr(oOb) // transforma objeto em xml para enviar para o spf_update
	
					//ALTERACOES DATAPREV
					// marca acesso 111
					cPswDet := strtran(cPswDet,'<item id="111" deleted="0"><USR_CODACESSO>111</USR_CODACESSO></item>','<item id="111" deleted="0"><USR_ACESSO>T</USR_ACESSO><USR_CODACESSO>111</USR_CODACESSO></item>')
					
					// desmarca acesso 112   
					cPswDet := strtran(cPswDet,'<item id="112" deleted="0"><USR_ACESSO>T</USR_ACESSO><USR_CODACESSO>112</USR_CODACESSO></item>','<item id="112" deleted="0"><USR_CODACESSO>112</USR_CODACESSO></item>')
					
					// acrescenta a porta LPT
					cPswDet := strtran(cPswDet,'<USR_DRIVEIMP order="8"><value>EPSON.DRV</value></USR_DRIVEIMP>','<USR_DRIVEIMP order="8"><value>EPSON.DRV</value></USR_DRIVEIMP><USR_PORTAIMP order="9"><value>LPT1</value></USR_PORTAIMP>')
					// O trecho acima pode gerar uma duplicidade.  A proxima linha corrige isso
					cPswDet := strtran(cPswDet,'<USR_PORTAIMP order="9"><value>LPT1</value></USR_PORTAIMP><USR_PORTAIMP order="9"><value>LPT1</value></USR_PORTAIMP>','<USR_PORTAIMP order="9"><value>LPT1</value></USR_PORTAIMP>')
	
					//FIM DE ALTERACOES - DATAPREV
					
					// marca acesso 189    
					cPswDet := strtran(cPswDet,'<item id="189" deleted="0"><USR_CODACESSO>189</USR_CODACESSO></item>','<item id="189" deleted="0"><USR_ACESSO>T</USR_ACESSO><USR_CODACESSO>189</USR_CODACESSO></item>')
					
					//Realiza Bloqueio SPF
					PswLock(.T.)
					
					If !spf_Update( cPswFile, @nPswRec,  cPswId , cPswName , cPswPwd , cPswDet )
						QOut("Erro")
						lRet := .T.
					ELSE
						QOut("Sucesso")
					EndIf
					//Libera a SPF
					PswLock(.F.)
					
					//Fecha o arquivo SPF
					SPF_Close(cPswFile)
					cCodUser := ""
				EndIf
			Endif
			
			//FreeObj(oOb)	
			oOb:=nil
			DelClassIntf()
		
		Next Nx
        
 		FClose(nHandle)
	
		Alert('Ajustes Concluidos em SIGAPSS.SPF !!!')
   
    Endif
Return nil  
