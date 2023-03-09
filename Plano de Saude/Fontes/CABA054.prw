#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'TBICONN.CH'
#INCLUDE 'AP5MAIL.CH' 
#INCLUDE 'UTILIDADES.CH'
#INCLUDE "FWBROWSE.CH"

User Function CABA054

Local oBrowse
Local oButton
Local oColumn
Local oDlg    
Local cAlias	:= 'PB4'
Local cTit		:= 'Atividades X Colaboradores'

DbSelectArea(cAlias)
DbSetOrder(1)

aSize 		:= MsAdvSize()                      

aObjects	:= {}   

aAdd( aObjects, { 1000,1000,.T.,.T. } ) 

// Dados da area de trabalho e separacao
aInfo 		:= {aSize[1], aSize[2], aSize[3], aSize[4], 3, 3} 

// Chama MsObjSize e recebe array e tamanhos
aPosObj 	:= MsObjSize( aInfo, aObjects,.T.)  

DEFINE MSDIALOG oDlg TITLE cTit From aSize[7],00 To aSize[6],aSize[5] PIXEL

	DEFINE FWFORMBROWSE oBrowse DATA TABLE ALIAS cAlias OF oDlg
        
		oBrowse:SetDescription(cTit) 
	
		oBrowse:AddLegend( "PB4_DELEGA == 'S'", "GREEN"	, "Atividade delegada" )  
		oBrowse:AddLegend( "PB4_DELEGA != 'S'", "RED"	, "Atividade não delegada"  )  

		oBrowse:AddButton('Incluir'		,{||ALTERA := .F.,INCLUI := .T.,If(AxInclui('PB4') == 1,u_OkCB054(),)}		,,3)
        oBrowse:AddButton('Visualizar'	,{||ALTERA := .F.,INCLUI := .F.,AxVisual('PB4',PB4->(Recno()),2)}				,,2)
		oBrowse:AddButton('Alterar'		,{||ALTERA := .T.,INCLUI := .F.,AxAltera('PB4',PB4->(Recno()),4)}	 			,,4)
		oBrowse:AddButton('Excluir'		,{||If(u_DelCB054(),AxDeleta('PB4'),)}			,,5)
		
		MontaCols(cAlias, @oColumn, @oBrowse)
		
	ACTIVATE FWFORMBROWSE oBrowse

ACTIVATE MSDIALOG oDlg CENTERED

Return

***************************************************

Static Function MontaCols(cAlias, oColumn, oBrowse)          

Local aArea := GetArea()            

SX3->(DbSetOrder(1))

If SX3->(MsSeek(cAlias))

	While ( !SX3->(EOF()) .and. SX3->X3_ARQUIVO == cAlias )
	    
		If X3USO(SX3->X3_USADO) .and. cNivel >= SX3->X3_NIVEL
			    
			If SX3->X3_BROWSE == 'S' .and. !empty(SX3->X3_INIBRW)
				cExpress := SX3->X3_INIBRW	
			Else	    

				Do Case
				
					Case SX3->X3_BROWSE == 'N'
						cExpress := ""
				
					Case SX3->X3_TIPO == 'C'
						If !empty(SX3->X3_CBOX)
							cExpress := "U_CBOX(" + SX3->X3_CAMPO + ",'" + SX3->X3_CBOX + "')"
						Else
						    cExpress := SX3->X3_CAMPO
						EndIf
						
					Case SX3->X3_TIPO == 'N'
						cExpress := "Transform(" + SX3->X3_CAMPO + ",'" + SX3->X3_PICTURE + "')"
					
					Case SX3->X3_TIPO == 'D'
						cExpress := 'StoD(' + SX3->X3_CAMPO + ')'
							
					Otherwise
						cExpress := ""
						
				EndCase
				
			EndIf
				
			If !empty(cExpress)
				bCampo := '{||' + cExpress + '}'
		    	ADD COLUMN oColumn DATA &bCampo TITLE SX3->X3_TITULO  SIZE SX3->X3_TAMANHO OF oBrowse
		  	EndIf
		  	
        EndIf
        
        SX3->(DbSkip())
        
	EndDo

EndIf

RestArea(aArea)

Return        

*'============================================='*

User Function CBOX(cConteudo, cCBOX)
      
Local i := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS
      
Local aOpcoes 	:= StrTokArr(cCBOX,';')
Local cRet 		:= ''

For i := 1 to len(aOpcoes) 
	aBuffer := StrTokArr(aOpcoes[i],'=')
	If aBuffer[1] == cConteudo
		cRet 	:= allTrim(aBuffer[2])
	EndIf
Next

Return cRet

****************************************************************************************************************

User Function DelCB054
          
Aviso('ATENÇÃO','Para fins de consistência, não exclua a amarração entre o atividade e o colaborador, mas sim altere-a e coloque-a como não delegada ao colaborador.',{'Ok'})

Return .F.

****************************************************************************************************************

User Function OkCB054

Local aStatus := EnviaMail(PB4->PB4_COLABO)      
                                    
If !aStatus[1]
	cErro := 'CABERJ'+ CRLF + CRLF + Replicate('_',100) + CRLF + 'Ocorreu um erro e o e-mail informativo não foi enviado:' + CRLF + CRLF + aStatus[2] + CRLF + CRLF
	cErro += ' - Login: ' + allTrim(UsrRetName(PB4->PB4_COLABO)) + ';' + CRLF 
	cErro += ' - Nome: ' + allTrim(Capital(Lower(UsrFullName(PB4->PB4_COLABO)))) + ';' + CRLF 
	cErro += ' - E-mail: ' + allTrim(UsrRetMail(PB4->PB4_COLABO)) 
	
	LogErros(cErro)
Else                               
	cMsg := 'E-mail informativo enviado com sucesso para: ' 		+ CRLF
	cMsg += allTrim(Capital(Lower(UsrFullName(PB4->PB4_COLABO)))) 	+ CRLF 
	cMsg += '(' + allTrim(UsrRetMail(PB4->PB4_COLABO)) + ')'
	
	Aviso('E-mail informativo',cMsg,{'Ok'})
EndIf

Return .T. 

***************************************************************************************************************************

Static Function EnviaMail(cCodUsr)

Local cSubject 		:= If(cEmpAnt == '01','CABERJ','INTEGRAL') + " - Atividade delegada" 
Local cBody 		:= ""
Local cTo 			:= UsrRetMail (cCodUsr)             
Local cServer 		:= SuperGetmv("MV_RELSERV")
Local cAccount		:= SuperGetmv("MV_RELACNT")
Local cPassword		:= SuperGetMv("MV_RELAPSW") 
Local cRemetente	:= SuperGetMv("MV_WFMAIL")
Local nTimeOut	    := SuperGetMv("MV_RELTIME",,120)
Local cErrorMsg 	:= ""
Local lResult		:= .T.

cMsg := 'A atividade ' + PB4->PB4_CODATI + '(' + allTrim(POSICIONE('PA2',1,XFILIAL('PA2') + PB4->PB4_CODATI,'PA2_DESCRI')) + ') foi delegada para o(a) colaborador(a) ' + allTrim(Capital(Lower(UsrFullName(PB4->PB4_COLABO))))                                                                  

cBody := '<html>'
cBody += '<head>'
cBody += '<title>' + If(cEmpAnt == '01','CABERJ','INTEGRAL') + ' - ATIVIDADE DELEGADA</title>'
cBody += '</head>'
cBody += '<b><font size="3" face="Arial" color="Black">' + cMsg + '</font></b>'
cBody += '<br>'
cBody += '<br>'
cBody += '</body>'
cBody += '</html>'

CONNECT SMTP SERVER cServer ACCOUNT cAccount PASSWORD cPassword TIMEOUT nTimeOut RESULT lResult

If lResult

	If MailAuth(cAccount,cPassword)

		SEND MAIL FROM cAccount   ;
		TO cTo ;     
		CC "" ;
		SUBJECT cSubject;
		BODY cBody;
		ATTACHMENT ""

	Else
		lResult 	:= .F.
		cErrorMsg 	:= "Falha na autenticacao com servidor de e-mail..."
	End                     
Else
	cErrorMsg := "Falha na conexao com servidor de e-mail..."
End

DISCONNECT SMTP SERVER

Return {lResult,cErrorMsg}

***************************************************************************************************************************

User Function lValidCodUsr(cCodUsr, lAviso)
      
Local lOk := .F.                         
                                                               	
Default lAviso := .T.   

cCodUsr := allTrim(cCodUsr)
          
PswOrder(1)

lOk := PswSeek(cCodUsr, .T.)

If lAviso .and. !lOk
	Aviso('ATENÇÃO',"Não foi encontrado nenhum usuário com o código '" + cCodUsr + "'",{'Ok'})
EndIf

Return lOk