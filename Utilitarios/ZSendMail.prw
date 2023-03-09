#Include "Rwmake.ch"
#INCLUDE "TBIConn.CH"
#Include "AP5Mail.ch"
#Include "MSOLE.ch"
#Include "FILEIO.ch"

#DEFINE CRLF Chr(13)

/*/
�������������������������������������������������������������������������������
�������������������������������������������������������������������������������
���������������������������������������������������������������������������Ŀ��
���Fun��o    � ZSendMail � Autor � Mateus Medeiros      � Data � 08/11/17   ���
���������������������������������������������������������������������������Ĵ��
���Descri��o � Rotina para o envio de emails                                ���
���������������������������������������������������������������������������Ĵ��
���Parametros� ExpC1 : Conta para conexao com servidor SMTP                 ���
���          | ExpC2 : Password da conta para conexao com o servidor SMTP   ���
���          � ExpC3 : Servidor de SMTP                                     ���
���          � ExpC4 : Conta de origem do e-mail. O padrao eh a mesma conta ���
���          �         de conexao com o servidor SMTP.                      ���
���          � ExpC5 : Conta de destino do e-mail.                          ���
���          � ExpC6 : Assunto do e-mail.                                   ���
���          � ExpC7 : Corpo da mensagem a ser enviada.               	    |��
���          | ExpC8 : Patch com o arquivo que serah enviado                |��
���������������������������������������������������������������������������Ĵ��
��� Uso      � SIGAGAC                                                      ���
����������������������������������������������������������������������������ٱ�
�������������������������������������������������������������������������������
�������������������������������������������������������������������������������
/*/
User Function ZSendMail(cAccount,cPassword,cServer,cFrom,cEmail,cAssunto,cMensagem,cAttach,cEmailCCC,lMsg1)

Local cEmailTo := ""
Local cEmailBcc:= ""
//Local lResult  := .F.
Local lOk  := .F.
Local cError   := ""

Private nTimeOut    := GetMv("MV_RELTIME",,120) //Tempo de Espera antes de abortar a Conex�o
Private lAutentica  := GetMv("MV_RELAUTH",,.F.) //Determina se o Servidor de Email necessita de Autentica��o
Private cUserAut    := Alltrim(GetMv("MV_RELAUSR",,cAccount)) //Usu�rio para Autentica��o no Servidor de Email
Private cPassAut    := Alltrim(GetMv("MV_RELAPSW",,cPassword)) //Senha para Autentica��o no Servidor de Email
// Verifica se serao utilizados os valores padrao.
cAccount		    := Iif( cAccount  == NIL, GetMV( "MV_RELACNT" )  , cAccount  )
cPassword	        := Iif( cPassword == NIL, GetMV( "MV_RELPSW"  )  , cPassword )
cServer		        := Iif( cServer   == NIL, GetMV( "MV_RELSERV" )  , cServer   )
cAttach 		    := Iif( cAttach   == NIL, ""                     , cAttach   )
lMsg      	        := Iif( lMsg1     == NIL, .T.                    , lMsg1     )
cFrom			    := Iif( cFrom     == NIL, GetMv("MV_RELACNT")    , cFrom     )

//�������������������������������������������������������������������������������Ŀ
//�Envia o e-mail para a lista selecionada. Envia como BCC para que a pessoa pense�
//�que somente ela recebeu aquele email, tornando o email mais personalizado.     �
//���������������������������������������������������������������������������������
cEmailTo := Alltrim(cEmail)
cEmailcc := Alltrim(cEmailccc)
cEmailBcc:= GetMv("MV_RELACNT")

CONNECT SMTP SERVER cServer ACCOUNT cAccount PASSWORD cPassword TIMEOUT nTimeOut Result lOk
	
	If lOk
		If lAutentica
			If !MailAuth(cUserAut,cPassAut)
				If lMsg ; MSGINFO("Falha na Autentica��o do Usu�rio","Aten��o") ; Endif
				// floga("Falha na Autentica��o do Usu�rio")
				DISCONNECT SMTP SERVER RESULT lOk
				IF !lOk
					GET MAIL ERROR cErrorMsg
					If lMsg ; MSGINFO("Erro na Desconex�o: "+cErrorMsg,"Aten��o") ; Endif
	                // floga("Erro na Desconex�o: "+cErrorMsg)
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
		//	If lMsg ; MsgBox("Email enviado com Sucesso !!","Informa��o","INFO") ; Endif
		
		EndIf

	Else

		GET MAIL ERROR cErrorMsg
		If lMsg ; Help("",1,"AVG0001057",,"Error: "+cErrorMsg,2,0) ; Endif
		
	EndIf

DISCONNECT SMTP SERVER RESULT lOk

IF !lOk

	GET MAIL ERROR cErrorMsg
	If lMsg ; MSGINFO("Erro na Desconex�o: "+cErrorMsg,"Aten��o") ; Endif

ENDIF

Return(lOk)
