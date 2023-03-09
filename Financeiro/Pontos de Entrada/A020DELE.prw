/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Função	 ³ M020INC	³ Autor ³ ANTONIO MELO            DATA ³ 30.01.05 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descrição ³ Ponto de Entrada após a inclusão do FORNECEDOR -    	  ³±±
±±³          ³ Envio de WorkFlow após a inlusão do FORNECEDOR para equipe ³±±
±±³          ³ do financeiro.                                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso		 ³ MATA020()Generico 						  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

#Include "RwMake.Ch" 
#Include "Ap5Mail.Ch"
*----------------------*
User Function A020DELE()
*----------------------*
Local _aArea     := GetArea() //Armazena a Area atual        
Local _cMensagem := ""

_cMensagem := DtoC( Date() ) + Chr(13) + Chr(10) + Chr(13) + Chr(10)      
_cMensagem +=  Chr(13) + Chr(10) +Chr(13) + Chr(10) +'Empresa : '+(iif(cEmpAnt == "01", "CABERJ", "INTEGRAL" ))
_cMensagem += Chr(13) + Chr(10) + Chr(13) + Chr(10) +"    Para seu Conhecimento foi Excluido no sistema pelo usuario " + AllTrim( SubStr( cUsuario, 07, 15 ) ) 
_cMensagem +=  Chr(13) + Chr(10) + " o Fornecedor " + AllTrim( SA2->A2_COD ) + " - " 
_cMensagem += AllTrim( SA2->A2_NOME ) + " - "
_cMensagem += Chr(13) + Chr(10) + Chr(13) + Chr(10) + " Obs.: Este e-mail foi enviado automaticamente pelo Protheus. Por favor não responder"

EnviaEmail( _cMensagem ) 
RestArea( _aArea ) 
Return

*--------------------------------------*
Static Function EnviaEmail( _cMensagem )
*--------------------------------------*
Local _cMailServer := GetMv(  "MV_RELSERV" )
Local _cMailConta  := GetMv( "MV_EMCONTA")
Local _cMailSenha  := GetMv( "MV_EMSENHA" )                 
// comentado para exexcutar GLPI 54408 - Mateus Medeiros - 03/12/18
//Local _cTo  	   := alan.jefferson@caberj.com.br, esther.melo@caberj.com.br "
Local _cTo  	   := "esther.melo@caberj.com.br" //"monique.goncalves@caberj.com.br"//"alan.jefferson@caberj.com.br, esther.melo@caberj.com.br "
Local _cCC         := "  "  
Local _cAssunto    := " Exclusão de Fornecedor do Cadastro"
Local _cError      := ""
Local _lOk         := .T.
Local _lSendOk     := .F.

If !Empty( _cMailServer ) .And. !Empty( _cMailConta  ) .AND. !Empty( _cTo)  
	// Conecta uma vez com o servidor de e-mails
	CONNECT SMTP SERVER _cMailServer ACCOUNT _cMailConta PASSWORD _cMailSenha RESULT _lOk

	If _lOk
		SEND MAIL From _cMailConta To _cTo /*BCC _cCC  */ Subject _cAssunto Body _cMensagem  Result _lSendOk
	
/*		If !_lSendOk
			//Erro no Envio do e-mail
			GET MAIL ERROR _cError
		    Aviso("Erro no envio do E-Mail", _cError, { "Fechar" }, 2 )   
		Else
 	    	//DbSelectArea("SA1")
			RecLock("SA1",.F.)
			SB1->B1_XEMAIL := "1" //e-mail não enviado
			MsUnlock()				    
		 
		EndIf
*/	
	Else
		//Erro na conexao com o SMTP Server
		GET MAIL ERROR _cError
     	Aviso( "Erro no envio do E-Mail", _cError, { "Fechar" }, 2 )   
	EndIf
EndIf

If _lOk       
	//Desconecta do Servidor
	DISCONNECT SMTP SERVER
EndIf