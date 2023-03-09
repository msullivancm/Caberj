#Include "Rwmake.ch"
#INCLUDE "TBIConn.CH"
#Include "AP5Mail.ch"
#Include "MSOLE.ch"
#Include "FILEIO.ch"

#DEFINE CRLF Chr(13)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ ZSendMail ³ Autor ³ Mateus Medeiros      ³ Data ³ 08/11/17   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Rotina para o envio de emails                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ExpC1 : Conta para conexao com servidor SMTP                 ³±±
±±³          | ExpC2 : Password da conta para conexao com o servidor SMTP   ³±±
±±³          ³ ExpC3 : Servidor de SMTP                                     ³±±
±±³          ³ ExpC4 : Conta de origem do e-mail. O padrao eh a mesma conta ³±±
±±³          ³         de conexao com o servidor SMTP.                      ³±±
±±³          ³ ExpC5 : Conta de destino do e-mail.                          ³±±
±±³          ³ ExpC6 : Assunto do e-mail.                                   ³±±
±±³          ³ ExpC7 : Corpo da mensagem a ser enviada.               	    |±±
±±³          | ExpC8 : Patch com o arquivo que serah enviado                |±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ SIGAGAC                                                      ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function ZSendMail(cAccount,cPassword,cServer,cFrom,cEmail,cAssunto,cMensagem,cAttach,cEmailCCC,lMsg1)

Local cEmailTo := ""
Local cEmailBcc:= ""
//Local lResult  := .F.
Local lOk  := .F.
Local cError   := ""

Private nTimeOut    := GetMv("MV_RELTIME",,120) //Tempo de Espera antes de abortar a Conexão
Private lAutentica  := GetMv("MV_RELAUTH",,.F.) //Determina se o Servidor de Email necessita de Autenticação
Private cUserAut    := Alltrim(GetMv("MV_RELAUSR",,cAccount)) //Usuário para Autenticação no Servidor de Email
Private cPassAut    := Alltrim(GetMv("MV_RELAPSW",,cPassword)) //Senha para Autenticação no Servidor de Email
// Verifica se serao utilizados os valores padrao.
cAccount		    := Iif( cAccount  == NIL, GetMV( "MV_RELACNT" )  , cAccount  )
cPassword	        := Iif( cPassword == NIL, GetMV( "MV_RELPSW"  )  , cPassword )
cServer		        := Iif( cServer   == NIL, GetMV( "MV_RELSERV" )  , cServer   )
cAttach 		    := Iif( cAttach   == NIL, ""                     , cAttach   )
lMsg      	        := Iif( lMsg1     == NIL, .T.                    , lMsg1     )
cFrom			    := Iif( cFrom     == NIL, GetMv("MV_RELACNT")    , cFrom     )

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Envia o e-mail para a lista selecionada. Envia como BCC para que a pessoa pense³
//³que somente ela recebeu aquele email, tornando o email mais personalizado.     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cEmailTo := Alltrim(cEmail)
cEmailcc := Alltrim(cEmailccc)
cEmailBcc:= GetMv("MV_RELACNT")

CONNECT SMTP SERVER cServer ACCOUNT cAccount PASSWORD cPassword TIMEOUT nTimeOut Result lOk
	
	If lOk
		If lAutentica
			If !MailAuth(cUserAut,cPassAut)
				If lMsg ; MSGINFO("Falha na Autenticação do Usuário","Atenção") ; Endif
				// floga("Falha na Autenticação do Usuário")
				DISCONNECT SMTP SERVER RESULT lOk
				IF !lOk
					GET MAIL ERROR cErrorMsg
					If lMsg ; MSGINFO("Erro na Desconexão: "+cErrorMsg,"Atenção") ; Endif
	                // floga("Erro na Desconexão: "+cErrorMsg)
				ENDIF
				Return(.F.)
			EndIf
		EndIf
		
		If !Empty(cEmailcc)
			SEND MAIL FROM cFrom TO cEmailTo ;
			CC          cEmailcc ;
			BCC     	cEmailBcc ;
			SUBJECT 	OemToAnsi(cAssunto)  ; //ACTxt2Htm( cAssunto, cEmail ) ;
			BODY    	OemToAnsi( cMensagem ) ; //ACTxt2Htm( cMensagem, cEmail ) ;
			ATTACHMENT  cAttach  ;
			Result lOk
		Else
			SEND MAIL FROM cFrom TO cEmailTo ;
			BCC     	cEmailBcc ;
			SUBJECT 	OemToAnsi( cAssunto);
			BODY    	OemToAnsi( cMensagem ); //ACTxt2Htm( cMensagem, cEmail ) ;
			ATTACHMENT  cAttach  ;
			Result lOk
		EndIf

		If !lOk
			GET MAIL ERROR cErrorMsg
			If lMsg ; Help("",1,"AVG0001056",,"Error: "+cErrorMsg,2,0) ; Endif
		
		Else
		//	If lMsg ; MsgBox("Email enviado com Sucesso !!","Informação","INFO") ; Endif
		
		EndIf

	Else

		GET MAIL ERROR cErrorMsg
		If lMsg ; Help("",1,"AVG0001057",,"Error: "+cErrorMsg,2,0) ; Endif
		
	EndIf

DISCONNECT SMTP SERVER RESULT lOk

IF !lOk

	GET MAIL ERROR cErrorMsg
	If lMsg ; MSGINFO("Erro na Desconexão: "+cErrorMsg,"Atenção") ; Endif

ENDIF

Return(lOk)
