#INCLUDE "PROTHEUS.CH"
#include "ap5mail.ch"        

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³GEnvMail  ºAutor  ³Marcela Coimbra     º Data ³  01/04/10   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Função generica responsavel pelo envio de e-mails.         º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function GEnvMail(c_ArqTxt, c_To, c_CC, c_Assunto, a_Msg )

Local n_It := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

Local oMsg
Local _cError     := ""
Local l_Result    := .F.                   // resultado de uma conexão ou envio
Local nHdl        := fOpen(c_ArqTxt,68)
Local c_Body      := space(99999)

Private _cServer  := Trim(GetMV("MV_RELSERV")) // smtp.ig.com.br ou 200.181.100.51
Private _cUser    := Trim(GetMV("MV_RELACNT")) // fulano@ig.com.br
Private _cPass    := Trim(GetMV("MV_RELPSW"))  // 123abc
Private _cFrom    := "CABERJ Ptotheus"
Private cMsg      := ""
Private cdata	  := DATE()
Private cNomFor
Private cNum          
Private nOrdSE2Esp:= GetNewPar("MV_PLSOSE2",11)

Private c_Itens:= ""
                              
If nHdl == -1
	//alert("O arquivo de nome "+c_ArqTxt+" nao pode ser aberto! Verifique os parametros.","Atencao!")
	Return
Endif
         
nBtLidos := fRead(nHdl,@c_Body,99999)
fClose(nHdl)

For n_It:= 1 to Len( a_Msg )

	c_Body  := StrTran(c_Body, a_Msg[n_It][1] , a_Msg[n_It][2])		

Next

// Tira quebras de linha para nao dar problema no WebMail da Caberj
c_Body  := StrTran(c_Body,CHR(13)+CHR(10) , "")

// Contecta o servidor de e-mail
CONNECT SMTP SERVER _cServer ACCOUNT _cUser PASSWORD _cPass RESULT l_Result
**'Marcela Coimbra - Retirada autenticação em 03/05/2017'**
/*                          
// Autentica
If !MailAuth(_cUser,_cPass)
	//MSGINFO("Falla de Atentificacion","Error")
	DISCONNECT SMTP SERVER RESULT lOk
	IF !lOk
		GET MAIL ERROR cErrorMsg
		//Alert("Error al tratar de enviar correo  Error")
	ENDIF

EndIf
*/       
**'Marcela Coimbra Fim - Retirada autenticação em 03/05/2017'**     

SEND MAIL FROM _cUser TO c_To SUBJECT c_Assunto BODY c_Body  RESULT l_Result

If !l_Result
	GET MAIL ERROR _cError
	//alert("Erro ao conectar no servidor: " + _cError)
	Return
Endif

If !l_Result
	GET MAIL ERROR _cError
	//("Erro ao enviar e-mail: " + _cError)
	Return    

Endif 

Return  

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³gGravaLog ºAutor  ³Marcela Coimbra     º Data ³  01/04/10   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Função generica responsavel pelo cadastro de logs na       º±±
±±º          ³ tabela BX1.                                                º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function gGravaLog( a_Vet )
              
/*
a_Vet[1] - Alias da tabela
a_Vet[2] - recno
a_Vet[3] - Tipo (I E A)
a_Vet[4] - Obs
*/
cSeq := PLBX1NEW()    
dbSelectArea("SE2")      
                     
BX1->(RecLock("BX1",.T.))

	BX1->BX1_FILIAL   	:= xFilial("BX1")
	BX1->BX1_SEQUEN   	:= cSeq
	BX1->BX1_ALIAS    	:= a_Vet[1] // "SE2"
	BX1->BX1_RECNO    	:= a_Vet[2] // strzero( SE2->( rECNO()) , 10)
	BX1->BX1_TIPO     	:= a_Vet[3] // "E"
	BX1->BX1_USUARI   	:= USRFULLNAME( __cUserId )
	BX1->BX1_DATA     	:= Date()
	BX1->BX1_HORA     	:= Time()
	BX1->BX1_ESTTRB   	:= GetComputerName()
	BX1->BX1_ROTINA 	:= funname()
	BX1->BX1_XOBS 		:= a_Vet[4]//c_DadosLote + "JUSTIFICATIVA USUÁRIO: " + xx_cMemo1
	
	
BX1->(MsUnLock())       

Return
