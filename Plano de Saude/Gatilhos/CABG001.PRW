#INCLUDE 'PROTHEUS.CH'

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABG001   ºAutor  ³Leonardo Portella   º Data ³  28/04/11   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Gatilho para exibir um aviso de que o profissional nao faz  º±±
±±º          ³parte da Rede de Atendimento.                               º±±
±±º          ³Gatilho para exibir um aviso de que o procedimento precisa  º±±
±±º          ³de senha e analise medica.                                  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CABERJ                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function CABG001(cCpo)
   
Local lNaoVincRDA 	:= .F.  
Local cCampo 		:= allTrim(Upper(cCpo))
Local cRet			:= &('M->' + cCampo)
Local lPrecSenha 	:= .F.  
Local cProAnalise	:= SuperGetMv('MV_XPANALI')

Do Case

	Case cCampo == 'BE1_REGSOL'
	
		lNaoVincRDA := ( Val(Posicione('BB0',7,xFilial('BB0') + M->BE1_REGSOL,'BB0_VINC')) == 2 )

	Case cCampo == 'BE1_REGEXE'
	
		lNaoVincRDA := ( Val(Posicione('BB0',7,xFilial('BB0') + M->BE1_REGEXE,'BB0_VINC')) == 2 )

	Case cCampo == 'BE4_REGSOL'
	
		lNaoVincRDA := ( Val(Posicione('BB0',7,xFilial('BB0') + M->BE4_REGSOL,'BB0_VINC')) == 2 )

	Case cCampo == 'BE4_REGEXE'
	
		lNaoVincRDA := ( Val(Posicione('BB0',7,xFilial('BB0') + M->BE4_REGEXE,'BB0_VINC')) == 2 )
		
	Case cCampo == 'BE2_CODPRO'
	
		lPrecSenha := allTrim(M->BE2_CODPRO) $ cProAnalise
			
EndCase

If lNaoVincRDA
     
	Aviso('ATENÇÃO','Profissional não faz parte da Rede de Atendimento!',{'Ok'})

EndIf   

If lPrecSenha
                        
	Aviso('ATENÇÃO','O procedimento ' + allTrim(M->BE2_CODPRO) + ' necessita de senha e análise médica!',{'Ok'})	

EndIf

Return cRet