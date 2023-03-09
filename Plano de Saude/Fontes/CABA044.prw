#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'TOPCONN.CH'

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABA044   ºAutor  ³Leonardo Portella   º Data ³  24/08/11   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Cadastro de Gerencias (SZM).                                º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³CABERJ                                                      º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/   

User Function CABA044

AxCadastro("PA1",,"U_DelCB044()","U_OkCB044()")

Return

****************************************************************************************************************

User Function DelCB044
          
Aviso('ATENÇÃO','Para fins de consistência, não exclua a amarração entre o administrador e a gerência, mas sim altere-a e coloque-a como Inativa.',{'Ok'})

Return .F.

****************************************************************************************************************

User Function OkCB044

Local lOk 		:= .T. 

If INCLUI
    
    DbSelectArea('PA1')
    DbGoTop()
	
	If M->PA1_TIPOAC == 'E' 
		
		DbSetOrder(1)
	
		If MsSeek(xFilial('PA1') + 'T' + M->PA1_ADMIN + 'S') 
		
			Aviso('ATENÇÃO','O administrador já possui acesso a todas as gerências.',{'Ok'})
			lOk := .F.   
			
		EndIf
		
		DbSetOrder(2)
	
		If lOk .and. MsSeek(xFilial('PA1') + 'E' + M->PA1_GEREN + M->PA1_ADMIN)
        
	    	If PA1->PA1_ATIVO == 'S'
				cMsg := 'O administrador já possui acesso a esta gerência.'		
			Else
			   	cMsg := 'O administrador já possui acesso a esta gerência, porém a mesma encontra-se Inativa. Altere o acesso a esta gerência e ative-a.'
			EndIf
		
			Aviso('ATENÇÃO',cMsg,{'Ok'})
			lOk := .F.   
			
		EndIf
		
		If lOk .and. empty(M->PA1_GEREN)
			
			Aviso('ATENÇÃO','Para o tipo de acesso Específico, é obrigatório informar a gerência.',{'Ok'})
			lOk := .F.   
			
		EndIf
		
	ElseIf M->PA1_TIPOAC == 'T' 

		DbSetOrder(1)
	
		If MsSeek(xFilial('PA1') + 'T' + M->PA1_ADMIN) 
		
			If PA1->PA1_ATIVO == 'S'
				cMsg := 'O administrador já possui acesso a todas as gerências.'		
			Else
			   	cMsg := 'O administrador já possui acesso a todas as gerências, porém a mesma encontra-se Inativa. Altere este acesso e ative-o.'
			EndIf
		
			Aviso('ATENÇÃO',cMsg,{'Ok'})
			lOk := .F.   
			
		ElseIf MsSeek(xFilial('PA1') + 'E' + M->PA1_ADMIN + 'S')
        
	    	cMsg := 'O administrador possui acesso a gerências Ativas. Altere estas gerências e coloque-as como Inativas para dar acesso a todas as gerências.'		
			
			Aviso('ATENÇÃO',cMsg,{'Ok'})
			lOk := .F.   
			
		EndIf
		
	EndIf
		
EndIf

If ALTERA .and. M->PA1_ATIVO == 'S'
     
	nRecnoOri := PA1->(Recno())
	
	DbSelectArea('PA1')
	DbSetOrder(1)	
	
	While !PA1->(EOF())
	
		//Se possui acesso a Todos e nao eh a propria linha.
		If MsSeek(xFilial('PA1') + 'T' + M->PA1_ADMIN + 'S') .and. PA1->(Recno()) != nRecnoOri
		
			Aviso('ATENÇÃO','O administrador já possui acesso a todas as gerências. Não será permitido ativar este acesso',{'Ok'})
			lOk := .F.
			exit
    
		EndIf
		
		PA1->(DbSkip())
			
	EndDo
	
	DbSetOrder(2)
	
	PA1->(DbGoTop())
	
	While lOk .and. !PA1->(EOF()) 	
	
		If MsSeek(xFilial('PA1') + 'E' + M->PA1_GEREN + M->PA1_ADMIN + 'S') .and. PA1->(Recno()) != nRecnoOri
     	
			Aviso('ATENÇÃO','O administrador já possui acesso a esta gerência. Não será permitido ativar este acesso.',{'Ok'})
			lOk := .F.
			exit
	     
		Endif
		
		PA1->(DbSkip())

	EndDo	
          
EndIf

Return lOk