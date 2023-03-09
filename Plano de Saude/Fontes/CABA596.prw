#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'PARMTYPE.CH'
#INCLUDE "AP5MAIL.CH"
#INCLUDE 'RWMAKE.CH'
#INCLUDE 'FONT.CH'
#INCLUDE 'COLORS.CH'


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ CABA596  บAutor  ณAngelo Henrique     บ Data ณ  29/03/2017 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRotina criada para enviar e-mail no protocolo de atendimentoบฑฑ
ฑฑบ          ณlogo sso de Cancelamento de Plano e retorno de relat๓rio    บฑฑ
ฑฑบ          ณe realiza a inser็ใo do protocolo de atendimento.           บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณCABERJ                                                      บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function CABA596()
	
	Local _aArea 		:= GetArea()
	Local _aArSZX		:= SZX->(GetArea())
	Local _aArBA1		:= BA1->(GetArea())
	Local _aArBI3		:= BI3->(GetArea())
	//Local a_Vet 		:= {}
	Local a_Msg 		:= {}
	Local a_Htm 		:= "" //Variavel que irแ receber o template
	Local c_To 			:= ""
	Local c_CC 	    	:= " "
	Local c_Assunto 	:= "Protocolo de Atendimento - CABERJ"
	Local _cDscPln		:= "" //Descri็ใo do Plano do Beneficiแrio
	Local _cMat			:= "" //Matricula do Beneficiแrio
	Local _cTpSrv		:= "" //Tipo de Servi็o
	Local _cHora		:= "" //Hora do Protocolo
	Local _cMail		:= SZX->ZX_EMAIL + SPACE(200)
	Local _nOpc 		:= 1  //Op็ใo da Tela
	Local _nCntZy 		:= 0
	Local _cTpSv 		:= ""
	Local _cHst			:= ""
	Local _cDigt 		:= ""
	
	If SZX->ZX_CANAL != "000014"
		
		SetPrvt("oDlg1","oGrp1","oSay1","oGet1","oBtn1","oBtn2")
		
		/*ฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤมฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤูฑฑ
		ฑฑ Definicao do Dialog e todos os seus componentes.                        ฑฑ
		ูฑฑภฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤมฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤ*/
		oDlg1      	:= MSDialog():New( 092,232,267,725,"Envio de Protocolo de Atendimento por E-mail",,,.F.,,,,,,.T.,,,.T. )
		oGrp1      	:= TGroup():New( 004,004,076,236,"  Envio de Email  ",oDlg1,CLR_HBLUE,CLR_WHITE,.T.,.F. )
		oSay1      	:= TSay():New( 016,012,{||"Deseja enviar este protocolo para qual e-mail?"},oGrp1,,,.F.,.F.,.F.,.T.,CLR_HBLUE,CLR_WHITE,216,012)
		oGet1  		:= TGet():New( 032,012,{|u| If( PCount() == 0, _cMail, _cMail := u )},oGrp1,216,010,'',{|| u_cabv037(_cMail) .or. Empty(_cMail)  },CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","",,)
		
		oBtn1      	:= TButton():New( 056,144,"Enviar",oGrp1,{||iif(u_cabv037(_cMail),oDlg1:End(),.F.),_nOpc := 1},037,012,,,,.T.,,"Enviar",,,,.F. )
		oBtn2      	:= TButton():New( 056,188,"Fechar",oGrp1,{||oDlg1:End(),_nOpc := 2},037,012,,,,.T.,,"Fechar",,,,.F. )
		
		oDlg1:Activate(,,,.T.)
		
		If _nOpc = 1
			
			c_To := _cMail
			
			DbSelectArea("SZX")
			DbSetOrder(1)
			If DbSeek(xFilial("SZX") + SZX->ZX_SEQ)
				
				_cMat := SZX->ZX_CODINT + "." + SZX->ZX_CODEMP + "." + SZX->ZX_MATRIC + "-" + SZX->ZX_TIPREG + "." + SZX->ZX_DIGITO
				
				If cEmpAnt == "01"
					
					If SZX->ZX_CODEMP $ "0024|0025|0027|0028"
						
						a_Htm := "\HTML\PAPREF.HTML"
						
					Else
						
						a_Htm := "\HTML\PAGERAL.HTML"
						
					Endif
					
				Else
					
					a_Htm := "\HTML\PAINTEGRAL.HTML"
					
				EndIf
				
				//----------------------------------------------------------------
				//Caso o protocolo seja para um beneficiแrio registrado
				//irแ pegar informa็๕es pertinentes ao plano,
				//caso contrแrio nใo irแ preenche-lo
				//----------------------------------------------------------------
				DbSelectArea("BA1")
				DbSetOrder(2)
				If DbSeek(xFilial("SZX") + SZX->ZX_CODINT + SZX->ZX_CODEMP + SZX->ZX_MATRIC + SZX->ZX_TIPREG + SZX->ZX_DIGITO)
					
					DbSelectArea("BI3")
					DbSetOrder(1) //BI3_FILIAL+BI3_CODINT+BI3_CODIGO+BI3_VERSAO
					If DbSeek(xFilial("BI3") + BA1->BA1_CODINT + BA1->BA1_CODPLA)
						
						_cDscPln := AllTrim(BI3->BI3_DESCRI)
						
					Else
						
						_cDscPln := ""
						
					EndIf
					
				Else
					
					_cDscPln := ""
					
				EndIf
				
				//Pegando o primeiro registro do tipo de servi็o
				//para poder encaminhar no e-mail
				DbSelectArea("SZY")
				DbSetOrder(1)
				If DbSeek(xFilial("SZY") + SZX->ZX_SEQ)
					
					DbSelectArea("PBL")
					DbSetOrder(1)
					If DBSeek(xFilial("PBL") + SZY->ZY_TIPOSV)
						
						_cTpSrv := PBL_YDSSRV
						
					EndIf
					
				EndIf
				
				_cHora := SUBSTR(SZX->ZX_HORADE,1,2) + ":" + SUBSTR(SZX->ZX_HORADE,3,2)
				
				aAdd( a_Msg, { "_cBenef"	, SZX->ZX_NOMUSR		}) //Nome do Beneficiแrio
				aAdd( a_Msg, { "_cPlan"		, _cDscPln 				}) //Descri็ใo do Plano do Beneficiแrio
				aAdd( a_Msg, { "_cMat"		, _cMat 				}) //Matricula do Beneficiแrio
				aAdd( a_Msg, { "_cSeq"		, SZX->ZX_SEQ 			}) //N๚mero do Protocolo
				aAdd( a_Msg, { "_cTpServ"	, _cTpSrv				}) //Descri็ใo do Tipo de Servi็o
				aAdd( a_Msg, { "_cDtDe"		, DTOC(SZX->ZX_DATDE)	}) //Data de Abertura do Protocolo
				aAdd( a_Msg, { "_cHora"		, _cHora				}) //Hora de Abertura do Protocolo
				
				//Fun็ใo para envio de e-mail
				If Env_1(a_Htm, c_To, c_CC, c_Assunto, a_Msg, SZX->ZX_SEQ, _cMat, SZX->ZX_RDA )
					
					Aviso("Aten็ใo", "Protocolo enviado com sucesso!",{"OK"})
					
					If MSGYESNO("Deseja atualizar o e-mail no protocolo de atendimento?","Aten็ใo")
						
						RecLock("SZX",.F.)
						
						SZX->ZX_EMAIL := c_To
						
						SZX->(MsUnLock())
						
					EndIf
					
					//-----------------------------------------------------------------
					//Gravando mais uma linha na SZY de hist๓rico do envio de e-mail.
					//-----------------------------------------------------------------
					DbSelectArea("SZY") 
					DbSetOrder(1)
					If DbSeek(xFilial("SZY") + SZX->ZX_SEQ)
						
						_nCntZy := 1
						
						While !Eof() .And. SZX->ZX_SEQ == SZY->ZY_SEQBA
							
							_nCntZy ++
							
							_cTpSv 	:= SZY->ZY_TIPOSV
							_cHst	:= SZY->ZY_HISTPAD
							_cDigt 	:= SZY->ZY_USDIGIT
							
							SZY->(DbSkip())
							
						EndDo
						
						RecLock("SZY", .T.)
						
						SZY->ZY_SEQBA 	:= SZX->ZX_SEQ
						SZY->ZY_SEQSERV	:= STRZERO(_nCntZy,TAMSX3("ZY_SEQSERV")[1])
						SZY->ZY_DTSERV	:= dDatabase
						SZY->ZY_HORASV	:= SUBSTR(TIME(),1,2) + SUBSTR(TIME(),4,2)
						SZY->ZY_TIPOSV	:= _cTpSv
						SZY->ZY_OBS		:= "E-mail enviado para: " + c_To
						SZY->ZY_HISTPAD	:= 	_cHst
						SZY->ZY_USDIGIT	:= _cDigt
						SZY->ZY_PESQUIS := "4"
						
						SZY->(MsUnLock())
						
					EndIf
					
				Else
					
					Aviso("Aten็ใo", "Protocolo nใo enviado, favor verificar se o e-mail esta correto.!",{"OK"})
					
				EndIf
				
			Else
				
				If Empty(SZX->ZX_EMAIL)
					
					Aviso("Aten็ใo","Este protocolo nใo possui um e-mail cadastrado para ser enviado.",{"OK"})
					
				EndIf
				
			EndIf
			
		Else
			
			Aviso("Aten็ใo", "Protocolo nใo enviado.!",{"OK"})
			
		EndIf
		
	Else
		
		Aviso("Aten็ใo", "Protocolo nใo enviado, pois trata-se de assuntos da DIRETORIA.!",{"OK"})
		
	EndIf
	
	
	RestArea(_aArBI3)
	RestArea(_aArBA1)
	RestArea(_aArSZX)
	RestArea(_aArea)
	
Return



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณEnv_1     บAutor  ณAngelo Henrique     บ Data ณ  30/03/17   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Fun็ใo generica responsavel pelo envio de e-mails.         บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function Env_1(c_ArqTxt, c_To, c_CC, c_Assunto, a_Msg, cProtoc, cMatric, cCodRDA )
	
	Local n_It 			:= 0
	
	Local l_Result    	:= .F.                   		// resultado de uma conexใo ou envio
	Local nHdl        	:= fOpen(c_ArqTxt,68)
	Local c_Body      	:= space(99999)
	
	Private _cServer  	:= Trim(GetMV("MV_RELSERV")) 	// smtp.ig.com.br ou 200.181.100.51
	
	Private _cUser    	:= GetNewPar("MV_XMAILPA", "protocolodeatendimento@caberj.com.br")
	Private _cPass    	:= GetNewPar("MV_XPSWPA" , "Caberj2017@!")
	
	Private _cFrom    	:= "CABERJ PROTHEUS"
	Private cMsg      	:= ""
	
	If !(nHdl == -1)
		
		nBtLidos := fRead(nHdl,@c_Body,99999)
		fClose(nHdl)
		
		For n_It:= 1 to Len( a_Msg )
			
			c_Body  := StrTran(c_Body, a_Msg[n_It][1] , a_Msg[n_It][2])
			
		Next
		
		// Tira quebras de linha para nao dar problema no WebMail da Caberj
		c_Body  := StrTran(c_Body,CHR(13)+CHR(10) , "")

		cMatric	:= StrTran(StrTran(cMatric,".",""),"-","")
		l_Result := U_CabEmail(AllTrim(c_To), "", _cUser, c_Assunto, c_Body, {}, _cUser,, .F.,,,,{"01",cProtoc,cMatric,cCodRDA})[1]

		/*
		// Contecta o servidor de e-mail
		CONNECT SMTP SERVER _cServer ACCOUNT _cUser PASSWORD _cPass RESULT l_Result
		
		If !l_Result
			
			GET MAIL ERROR _cError
			
			DISCONNECT SMTP SERVER RESULT lOk
			
		Else
			
			SEND MAIL FROM _cUser TO c_To BCC _cUser  SUBJECT c_Assunto BODY c_Body  RESULT l_Result
			
			If !l_Result
				
				GET MAIL ERROR _cError
				
			Endif
			
		EndIf
		*/

	Endif
	
Return l_Result
