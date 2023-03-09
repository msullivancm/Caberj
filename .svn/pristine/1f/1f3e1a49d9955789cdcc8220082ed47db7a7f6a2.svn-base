#INCLUDE 'PROTHEUS.CH'

User Function PLBLQUSR

Local cBloqueio := paramixb[1]   
Local cMotBlq   := paramixb[2]      
Local dDatBlq   := paramixb[3]    
Local cAlias    := paramixb[4]   
Local dDatInc   := paramixb[5]   
Local dDatPed   := paramixb[6]   
Local lRet      := .T.
                              
If Empty(cBloqueio) // Se estiver vazio eh um bloqueio.

	If BA1->BA1_LOCATE == '2' 
	    //BA0_FILIAL+BA0_CODIDE+BA0_CODINT                                                                                                                                
		cDescOper 	:= AllTrim(Capital(Lower(Posicione('BA0',1,xFilial('BA0') + BA1->BA1_OPEDES,'BA0_NOMINT'))))
		cMsg 		:= 'O(a) usuário(a) ' + AllTrim(Capital(Lower(BA1->BA1_NOMUSR))) + ' é de repasse. Favor bloquear a matrícula do repasse na operadora destino (' + cDescOper + ').' + CRLF 
		cMsg		+= Replicate('_',50) + CRLF + 'Confirma o bloqueio do usuário de repasse?'
		
		nOpca 	:= Aviso('ATENÇÃO',cMsg,{'Sim','Não'})
		
		lRet 	:= ( nOpca == 1 )
	EndIf
	
Endif      

Return lRet