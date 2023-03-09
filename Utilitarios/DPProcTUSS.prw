#include "PROTHEUS.CH"
#include "TOPCONN.CH"
#include "TBICONN.CH"   
#include "UTILIDADES.CH"   

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออปฑฑ
ฑฑบPrograma  ณDPProcTUSS  บAutor  ณLeonardo Portella   บ Data ณ  27/02/12 บฑฑ
ฑฑฬออออออออออุออออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออนฑฑ
ฑฑบDesc.     ณRotina para gerar arquivo com os codigos dos procedimentos  บฑฑ
ฑฑบ          ณnovos da TUSS contra os procedimentos antigos.              บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณCABERJ                                                      บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function DpProcTUSS(aSchedule)

Local aRet			:= {}

Private cArqCAB		:= ""
Private cArqINT		:= ""
Private lSchedule	:= If(empty(aSchedule),.F.,aSchedule[1][1])
Private cDtHrReal	:= "'DPPROCTUSS - ' + DtoC(Date()) + ' ' + Time()"
Private cDtHoraArq	:= ""
Private cDtHoraAtu	:= ""

If lSchedule
	//Na query considera a Caberj e a Integral
	PREPARE ENVIRONMENT EMPRESA "01" FILIAL "01"

	cDtHoraAtu := DtoC(Date()) + ' - ' + Time()

	cDtHoraArq := DtoS(Date()) + "_" + StrTran(Time(),":","")

	ConOut('Preparando ambiente...')   

	ConOut(&cDtHrReal + ' - Gerando HTML Caberj...')   	

	aRet := GeraHTML('CABERJ')

	ConOut(&cDtHrReal + ' - HTML Caberj gerado...') 

	ConOut(&cDtHrReal + ' - Gerando HTML Integral...')
    
	If aRet[1]
		GeraHTML('INTEGRAL')   	                          

		ConOut(&cDtHrReal + ' - HTML Integral gerado...')

		ConOut(&cDtHrReal + ' - Enviando e-mail de confirma็ใo...')
	EndIf

Else                                                             

	cDtHoraAtu := DtoC(Date()) + ' - ' + Time()
	
	cDtHoraArq := DtoS(Date()) + "_" + StrTran(Time(),":","")
	
	Processa({||aRet := GeraHTML('CABERJ')},'Processando...')
	
	If aRet[1]
		Processa({||GeraHTML('INTEGRAL')},'Processando...')
	EndIf
	
	IncProc('Enviando e-mail de confirma็ใo...')
EndIf                 
    
aMail := EnviaMail(aRet[1],aRet[2])

If !aMail[1]
	ConOut(&cDtHrReal + " - Erro ao enviar o e-mail de confirma็ใo Atualiza็ใo De/Para Procedimentos TUSS: " + aMail[2])
Else  
	ConOut(&cDtHrReal + " - E-mail de confirma็ใo Atualiza็ใo De/Para Procedimentos TUSS enviado.")
EndIf  

If !lSchedule
	If aRet[1]
		MsgInfo('Pแginas geradas!')
	Else
	   	Alert(aRet[2])
	EndIf
EndIf

Return

***************************************************************************************************************************

Static Function GeraHTML(c_Empresa)

Local cQry	 	:= ''
Local cBMP		:= If(c_Empresa == 'CABERJ',"\\Srvpqv\wwwintegralsaude\integral\images\logo_grupo_caber.png","\\Srvpqv\wwwintegralsaude\integral\images\logo.png")
Local cLog 		:= "DpProcTUSS - "
Local cMsg    	:= "" //Mensagem para o corpo do e-mail  
Local cDirSav	:= '\\srvpqv\wwwroot\PortalCaberj\tuss\'//'\\srvpqv\NovoSite_teste\Portal\TUSS\'
Local cNomArq	:= 'PROC_TUSS_' + c_Empresa + '.htm' 
Local cArq 		:= cDirSav + cNomArq
Local nHdl 		:= 0
Local lRet		:= .T.
Local cErro		:= "" 
Local c_Empr 	:= c_Empresa
Local cAlias 	:= GetNextAlias()
Local cTot		:= 0   
Local nAux		:= 0
Local nCap		:= 0
Local nGrp		:= 0
Local nSubG		:= 0
Local cCor		:= If(c_Empresa == 'CABERJ','#99FF99','#FFA500')
Local cCorRealce:= If(c_Empresa == 'CABERJ','#33FF33','#FF6600')
Local cCorCap	:= cCor
Local cCorGrp	:= cCor
Local cCorSubG	:= cCor
Local cFonteCab	:= 'Arial'
Local cFonteTxt	:= 'Courier New'
Local cArqBKP	:= ''

If File(cArq)
	
	If !ExistDir(cDirSav + 'BACKUP\')
		lRet := ( MakeDir(cDirSav + 'BACKUP\') == 0 )
		If !lRet
			cErro 	:= "Erro ao criar o diret๓rio para fazer backup (" + cDirSav + 'BACKUP\' + ")"
		EndIf	
	EndIf
	
	If lRet
		cArqBKP := cDirSav + 'BACKUP\' + cDtHoraArq + '_' + cNomArq
		lRet 	:= MoveFile(cArq,cArqBKP,.T.)
		If !lRet
			cErro 	:= "Erro ao fazer backup do arquivo (" + cArq + ") para o arquivo backup (" + cArqBKP + ")"	
		EndIf
	EndIf
EndIf

If lRet
	
	nHdl := FCreate(cArq) 
	
	If(c_Empresa == 'CABERJ',cArqCAB := cArq,cArqINT := cArq)
	
	If nHdl = -1
	   	lRet 	:= .F.                            
	   	cErro 	:= "Erro ao criar arquivo (" + cArq + ") - fError: " + cDesFerror(fError())
	   
	   	If !empty(cArqBKP)
		   //Volto o arquivo de Backup se der erro e nao puder criar o novo
		   MoveFile(cArqBKP,cArq,.T.)
		EndIf
		
	EndIf
	
EndIf
	
If lRet
	cMsg += '<html>'
	cMsg += '<body><body bgcolor=#FFFFFF>'																				 
	cMsg += '<head>'							
	cMsg += '<title>De/Para Procedimentos TUSS</title>'								 
	cMsg += '</head>'
	
	cMsg += '<img src="' + cBMP + '">'																							  
	
	cMsg += '<br>'
	cMsg += '<hr>'	 
	cMsg += '<br>'
	cMsg += '<b><font size="3" face="Arial" color="Red">Importante!   </font></b>'
	cMsg += '<br>'
	cMsg += '<b><font size="3" face="Arial" color="Black">Em caso de d๚vidas, favor entrar em contato com o </font></b>'
	cMsg += '<b><i><font size="3" face="Arial" color="Black">Credenciamento</font></i></b>'
	cMsg += '<b><font size="3" face="Arial" color="Black"> da Caberj (Tels: 2505-6446 e 2277-9999)</font></b>'
	
	cMsg += '<br>'
	cMsg += '<br>'
	
	cMsg += '<b><font size="3" face="Arial" color="' + If(c_Empresa == 'CABERJ','Green','Orange') + '">Obs: Atalho do </font></b>' 
	cMsg += '<b><i><font size="3" face="Arial" color="' + If(c_Empresa == 'CABERJ','Green','Orange') + '">Localizar </font></i></b>' 
	cMsg += '<b><font size="3" face="Arial" color="' + If(c_Empresa == 'CABERJ','Green','Orange') + '">no </font></b>' 
	cMsg += '<b><i><font size="3" face="Arial" color="' + If(c_Empresa == 'CABERJ','Green','Orange') + '">Internet Explorer </font></i></b>'  
	cMsg += '<b><font size="3" face="Arial" color="' + If(c_Empresa == 'CABERJ','Green','Orange') + '">(Pressione juntas as teclas: </font></b>' 
	cMsg += '<b><i><font size="3" face="Arial" color="' + If(c_Empresa == 'CABERJ','Green','Orange') + '">Ctrl + F</font></i></b>'
	cMsg += '<b><font size="3" face="Arial" color="' + If(c_Empresa == 'CABERJ','Green','Orange') + '">)</font></b>'
	 
	cMsg += '<br>'
	cMsg += '<br>'
	
	If !lSchedule
		ProcRegua(0)
		
		For nAux := 1 to 5
			IncProc('Executando consulta ao banco... ' + c_Empresa)	
		Next 
	Else
		ConOut(&cDtHrReal + ' - Executando consulta ao banco... ' + c_Empresa) 
	EndIf
	       
	FWrite(nHdl,cMsg,len(cMsg))
	
	cMsg := ""
	
	cQry := "SELECT DECODE(BA8_NIVEL,'1','CAPITULO','2','GRUPO','3','SUB-GRUPO','4','PROCEDIMENTO','-') NIVEL," + CRLF
	cQry += "   TRIM(BA8_CODPRO) COD_TUSS, TRIM(BA8_DESCRI) DESC_TUSS, TRIM(BA8_CODANT) COD_ANTERIOR," 	   		+ CRLF
	cQry += "   TRIM(NVL(RETORNA_DESCRI_PROCEDIMENTO('C','01',BA8_CODANT),' ')) DESC_ANTERIOR" 					+ CRLF
	cQry += "FROM BA8" + If(c_Empresa == 'CABERJ','010','020')													+ CRLF
	cQry += "WHERE D_E_L_E_T_ = ' '" 																			+ CRLF
	cQry += "	AND BA8_FILIAL = ' '" 																			+ CRLF
	cQry += "	AND BA8_CODPAD = '16'" 																			+ CRLF
	//cQry += "	AND BA8_NIVEL = '4'" 																			+ CRLF
	cQry += "	AND BA8_CODPRO <> '99999994'" 																	+ CRLF
	cQry += "ORDER BY COD_TUSS"
	
	TcQuery cQry New Alias cAlias 
	
	COUNT TO nAux 
	cTot := AllTrim(Transform(nAux,"@E 999,999,999,999"))
	
	If nAux == 0
		lRet := .F.
   		cErro := "Nใo foram retornados dados no SQL..."
	EndIf
		
	If !lSchedule
		ProcRegua(nAux)
	Else
		ConOut(&cDtHrReal + ' - ' + cTot + ' registros encontrados... ' + c_Empresa) 
	EndIf              
	
	nAux := 0
	
	cAlias->(DbGoTop())
	
	lTabCap	 	:= .F.
	lTabGrp		:= .F.
	lTabSubG	:= .F.
	lTabProc 	:= .F.	
	
	While !cAlias->(EOF())
		
		//CAPITULO - INICIO
	     
		//Inicia tabela capitulo
		If AllTrim(cAlias->NIVEL) == 'CAPITULO' .and. !lTabCap
			cMsg += '<table width="100%" border="2" bordercolor="black" bgcolor="' + cCorCap + '">'								 
			cMsg += '<tr>'																								 
			cMsg += '<td colspan=2><b><font size="3" face="' + cFonteCab + '" color="Black">Capํtulo</font></b></td>'																			 
			cMsg += '</tr>'																								 

			lTabCap := .T.
		EndIf
		
		//Preenche a tabela capitulo
		While !cAlias->(EOF()) .and. AllTrim(cAlias->NIVEL) == 'CAPITULO'
		    
		    ++nCap
		    nGrp	:= 0
			nSubG	:= 0

		    If !lSchedule 
		    	IncProc('Processando ' + AllTrim(Transform(++nAux,'@E 999,999,999,999')) + ' de ' + cTot + ' - ' + c_Empresa + ' (' + AllTrim(cAlias->NIVEL) + ')')
		    EndIf

		    //JavaScript para realcar a linha do mouse
			cMsg += '<tr style="cursor:default" onMouseOver="javascript:this.style.backgroundColor='+ "'" + cCorRealce + "'" + '" onMouseOut="javascript:this.style.backgroundColor=' + "''" + '">'
			
			cMsg += '<td width=70><font size="2" face="' + cFonteTxt + '" color="Black">' + cValToChar(nCap) + '</font></td>'
			cMsg += '<td><font size="3" face="' + cFonteTxt + '" color="Black">' + cAlias->DESC_TUSS + '</font></td>'
			cMsg += '</tr>'
			
			cAlias->(DbSkip())													        
			
			FWrite(nHdl,cMsg,len(cMsg))
			cMsg := ""
				
			//Finaliza a tabela capitulo
			If cAlias->(EOF()) .or. AllTrim(cAlias->NIVEL) <> 'CAPITULO'
				cMsg += '</table width="100%">' 	
				cMsg += '<br>'
				
				FWrite(nHdl,cMsg,len(cMsg))
				cMsg := ""
				
				lTabCap := .F.												        
			EndIf
			
		EndDo
		
		//CAPITULO - FIM
		
		//GRUPO - INICIO
		
		//Inicia tabela grupo
		If AllTrim(cAlias->NIVEL) == 'GRUPO' .and. !lTabCap
			cMsg += '<table width="100%" border="2" bordercolor="black" bgcolor="' + cCorGrp + '">'
			cMsg += '<tr>'
			cMsg += '<td colspan=2><b><font size="3" face="' + cFonteCab + '" color="Black">Grupo</font></b></td>'
			cMsg += '</tr>'
			
			lTabGrp := .T.
		EndIf
		
		//Preenche a tabela grupo
		While !cAlias->(EOF()) .and. AllTrim(cAlias->NIVEL) == 'GRUPO'
		    
		    If !lSchedule 
		    	IncProc('Processando ' + AllTrim(Transform(++nAux,'@E 999,999,999,999')) + ' de ' + cTot + ' - ' + c_Empresa + ' (' + AllTrim(cAlias->NIVEL) + ')')
		    EndIf

		    //JavaScript para realcar a linha do mouse
			cMsg += '<tr style="cursor:default" onMouseOver="javascript:this.style.backgroundColor='+ "'" + cCorRealce + "'" + '" onMouseOut="javascript:this.style.backgroundColor=' + "''" + '">'
			
		    ++nGrp
			nSubG	:= 0                          
			c_Ind	:= cValToChar(nCap) + '.' + cValToChar(nGrp)
			
			cMsg += '<td width=70><font size="2" face="' + cFonteTxt + '" color="Black">' + c_Ind + '</font></td>'
			cMsg += '<td><font size="3" face="' + cFonteTxt + '" color="Black">' + cAlias->DESC_TUSS		+ '</font></td>'
			cMsg += '</tr>'
			
			cAlias->(DbSkip())													        
			
			FWrite(nHdl,cMsg,len(cMsg))
			cMsg := ""
				
			//Finaliza a tabela grupo
			If cAlias->(EOF()) .or. AllTrim(cAlias->NIVEL) <> 'GRUPO'
				cMsg += '</table width="100%">' 	
				cMsg += '<br>'
				
				FWrite(nHdl,cMsg,len(cMsg))
				cMsg := ""
				
				lTabGrp := .F.												        
			EndIf
			
		EndDo
		
		//GRUPO - FIM
		
		//SUB-GRUPO - INICIO

		//Inicia tabela sub-grupo
		If AllTrim(cAlias->NIVEL) == 'SUB-GRUPO' .and. !lTabCap
			cMsg += '<table width="100%" border="2" bordercolor="black" bgcolor="' + cCorSubG + '">'								 
			cMsg += '<tr>'	
			cMsg += '<td colspan=2><b><font size="3" face="' + cFonteCab + '" color="Black">Sub-grupo</font></b></td>'					 
			cMsg += '</tr>'																								 
			
			lTabSubG := .T.
		EndIf
		
		//Preenche a tabela sub-grupo
		While !cAlias->(EOF()) .and. AllTrim(cAlias->NIVEL) == 'SUB-GRUPO'
		    
		    If !lSchedule 
		    	IncProc('Processando ' + AllTrim(Transform(++nAux,'@E 999,999,999,999')) + ' de ' + cTot + ' - ' + c_Empresa + ' (' + AllTrim(cAlias->NIVEL) + ')')
		    EndIf

		    //JavaScript para realcar a linha do mouse
			cMsg += '<tr style="cursor:default" onMouseOver="javascript:this.style.backgroundColor='+ "'" + cCorRealce + "'" + '" onMouseOut="javascript:this.style.backgroundColor=' + "''" + '">'
			
		    ++nSubG
			c_Ind	:= cValToChar(nCap) + '.' + cValToChar(nGrp) + '.' + cValToChar(nSubG)
			
			cMsg += '<td width=70><font size="2" face="' + cFonteTxt + '" color="Black">' + c_Ind + '</font></td>'
			cMsg += '<td><font size="3" face="' + cFonteTxt + '" color="Black">' + cAlias->DESC_TUSS		+ '</font></td>'
			cMsg += '</tr>'
			
			cAlias->(DbSkip())													        
			
			FWrite(nHdl,cMsg,len(cMsg))
			cMsg := ""
				
			//Finaliza a tabela sub-grupo
			If cAlias->(EOF()) .or. AllTrim(cAlias->NIVEL) <> 'SUB-GRUPO'
				cMsg += '</table width="100%">' 	
				cMsg += '<br>'
				
				FWrite(nHdl,cMsg,len(cMsg))
				cMsg := ""
				
				lTabSubG := .F.												        
			EndIf
			
		EndDo
		
		//SUB-GRUPO - FIM
		
	    //PROCEDIMENTOS - INICIO
	       
		//Inicia tabela procedimentos
		If AllTrim(cAlias->NIVEL) == 'PROCEDIMENTO' .and. !lTabProc
			cMsg += '<table width="100%" border="2" bordercolor="black" bgcolor="' + cCor + '">'								 
			cMsg += '<tr>'																								 
			cMsg += '<td width=90><b><font size="3" face="' + cFonteCab + '" color="Black">C๓digo TUSS</font></b></td>'																	 
			cMsg += '<td width=500><b><font size="3" face="' + cFonteCab + '" color="Black">Descri็ใo TUSS</font></b></td>'					  
			cMsg += '<td width=90><b><font size="3" face="' + cFonteCab + '" color="Black">C๓digo Anterior</font></b></td>'																			 
			cMsg += '<td><b><font size="3" face="' + cFonteCab + '" color="Black">Descri็ใo Anterior</font></b></td>'															 
			cMsg += '</tr>'																								 
			
			lTabProc := .T.
		EndIf
		
		//Preenche a tabela procedimentos
		While !cAlias->(EOF()) .and. AllTrim(cAlias->NIVEL) == 'PROCEDIMENTO'
		    
		    //JavaScript para realcar a linha do mouse
			cMsg += '<tr style="cursor:default" onMouseOver="javascript:this.style.backgroundColor='+ "'" + cCorRealce + "'" + '" onMouseOut="javascript:this.style.backgroundColor=' + "''" + '">'
			
			cMsg += '<td><font size="3" face="' + cFonteTxt + '" color="Black">' + AllTrim(cAlias->COD_TUSS)		+ '</font></td>'	 
			cMsg += '<td><font size="3" face="' + cFonteTxt + '" color="Black">' + AllTrim(cAlias->DESC_TUSS)		+ '</font></td>'
			cMsg += '<td><font size="3" face="' + cFonteTxt + '" color="Black">' + AllTrim(cAlias->COD_ANTERIOR)	+ '</font></td>'
			cMsg += '<td><font size="3" face="' + cFonteTxt + '" color="Black">' + AllTrim(cAlias->DESC_ANTERIOR)	+ '</font></td>'
			cMsg += '</tr>'
			
			cAlias->(DbSkip())													        
			
		    If !lSchedule 
		    	IncProc('Processando ' + AllTrim(Transform(++nAux,'@E 999,999,999,999')) + ' de ' + cTot + ' - ' + c_Empresa + ' (' + AllTrim(cAlias->NIVEL) + ')')
		    EndIf
			
			FWrite(nHdl,cMsg,len(cMsg))
			cMsg := ""
				
			//Finaliza a tabela procedimentos
			If cAlias->(EOF()) .or. AllTrim(cAlias->NIVEL) <> 'PROCEDIMENTO'
				cMsg += '</table width="100%">' 	
				cMsg += '<br>'
				
				FWrite(nHdl,cMsg,len(cMsg))
				cMsg := ""
				
				lTabProc := .F.												        
			EndIf
			
		EndDo
		
		//PROCEDIMENTOS - FIM
		
		While !cAlias->(EOF()) .and. AllTrim(cAlias->NIVEL) == '-'
		    If !lSchedule 
		    	IncProc('Processando ' + AllTrim(Transform(++nAux,'@E 999,999,999,999')) + ' de ' + cTot + ' - ' + c_Empresa + ' (' + AllTrim(cAlias->NIVEL) + ')')
		    EndIf

			cAlias->(DbSkip())
		EndDo
		                   
		FWrite(nHdl,cMsg,len(cMsg))
	
		cMsg := ""
	
	EndDo
	
	cAlias->(DbCloseArea())
	
	cMsg += '<hr>'
	
	cMsg += '<br>'
	cMsg += '<b><font size="3" face="Arial" color="Black">ฺltima atualiza็ใo automแtica em ' + cDtHoraAtu + '</font></b>' 	 
	cMsg += '<br>'
	cMsg += '<br>'
	
	cMsg += '<hr>'
	cMsg += '<br>'
	
	cMsg += '<img src="' + cBMP + '">'
	cMsg += '<br>'
	cMsg += '<br>'
	cMsg += '</body>'
	cMsg += '</html>'      
	  
	FWrite(nHdl,cMsg,len(cMsg))
	
	// Fecha o Arquivo
	FCLOSE(nHdl)
	FT_FUSE() 
EndIf
	
Return {lRet,cErro}   

**********************************************************************************************************************************

Static Function EnviaMail(lOk,cErro)

Local cSubject 		:= "Atualiza็ใo De/Para Procedimentos TUSS (" + If(lSchedule,"Schedule","Manual") + ") " + DtoC(Date()) + " - STATUS: " + If(lOk,"OK","ERRO") 
Local cBody 		:= ""
Local cTo 			:= GetMV('MV_XLOGCAB')
Local cServer 		:= SuperGetmv("MV_RELSERV")
Local cAccount		:= SuperGetmv("MV_RELACNT")
Local cPassword		:= SuperGetMv("MV_RELAPSW") 
Local cRemetente	:= SuperGetMv("MV_WFMAIL")
Local nTimeOut	    := SuperGetMv("MV_RELTIME",,120)
Local cErrorMsg 	:= ""
Local lResult		:= .T.

cBody := '<html>' 
cBody += '<head>' 							
cBody += '<title>Atualiza็ใo De/Para Procedimentos TUSS</title>'								 
cBody += '</head>'																							  
cBody += '<b><font size="3" face="Arial" color="Black">Status da Atualiza็ใo De/Para Procedimentos TUSS do dia '  + DtoC(Date()) + ' (' + If(lSchedule,"Schedule","Manual") + '): ' + If(lOk,"HMTLs disponibilizados na Rede da Caberj para atualiza็ใo do site - Caberj e Integral","ERRO") + '</font></b>' 	 
cBody += '<br>'
cBody += '<br>'    

If lOk
	cBody += '<b><font size="3" face="Arial" color="Black">Arquivo Caberj: ' + cArqCAB + '</font></b>' 	 
	cBody += '<br>'
	cBody += '<b><font size="3" face="Arial" color="Black">Arquivo Integral: ' + cArqINT + '</font></b>' 	 
	cBody += '<br>'
	cBody += '<br>'
EndIf

If !lOk
	cBody += '<b><font size="3" face="Arial" color="Black">' + cErro + '</font></b>' 	 
EndIf

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

*****************************************************************************************************************************************

