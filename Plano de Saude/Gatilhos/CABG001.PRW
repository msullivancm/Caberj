#INCLUDE 'PROTHEUS.CH'

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �CABG001   �Autor  �Leonardo Portella   � Data �  28/04/11   ���
�������������������������������������������������������������������������͹��
���Desc.     �Gatilho para exibir um aviso de que o profissional nao faz  ���
���          �parte da Rede de Atendimento.                               ���
���          �Gatilho para exibir um aviso de que o procedimento precisa  ���
���          �de senha e analise medica.                                  ���
�������������������������������������������������������������������������͹��
���Uso       � CABERJ                                                     ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
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
     
	Aviso('ATEN��O','Profissional n�o faz parte da Rede de Atendimento!',{'Ok'})

EndIf   

If lPrecSenha
                        
	Aviso('ATEN��O','O procedimento ' + allTrim(M->BE2_CODPRO) + ' necessita de senha e an�lise m�dica!',{'Ok'})	

EndIf

Return cRet