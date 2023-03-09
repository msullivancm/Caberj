#INCLUDE "PROTHEUS.CH"   

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABV006   ºAutor  ³Leonardo Portella   º Data ³  18/11/11   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Alteracao dos inicializadores dos campos BE4_YCDPRO,        º±±  
±±º          ³BE4_YDSPRO, BE4_PADINT, BE4_DESPAD, BE1_YCDPRO e BE1_YDSPRO º±±
±±º          ³para funcionarem tanto na tela de Internacao do PLS, Libera-º±±
±±º          ³cao do PLS e na tela de chamados do CallCenter              º±±
±±º          ³(Atualizacoes > Atendimento > CallCenter >                  º±±
±±º          ³Botao Plano de Saude > Botao Guias > GIH e Liberacao)       º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³CABERJ                                                      º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function CABV006(cCampo)

Local uRet
Local cMatric
Local lCallCenter 	:= ( FunName() == 'TMKA271' )
Local aArea			:= GetArea()

If lCallCenter
	cMatric := M->UC_CHAVE
EndIf

Do Case

	Case cCampo == 'BE4_YCDPRO'
		If lCallCenter
			uRet := SubStr(U_BUSCAPROD(cMatric,.T.),1,4)
		Else
			uRet := If(INCLUI,"",SubStr(U_BUSCAPROD(BE4->(BE4_OPEUSR+BE4_CODEMP+BE4_MATRIC+BE4_TIPREG+BE4_DIGITO),.T.),1,4))//Inicializador padrao original                        
		EndIf

	Case cCampo == 'BE4_YDSPRO'
		If lCallCenter
			uRet := SubStr(U_BUSCAPROD(cMatric,.F.),1,20)
		Else
			uRet := If(INCLUI,"",Substr(U_BUSCAPROD(BE4->(BE4_OPEUSR+BE4_CODEMP+BE4_MATRIC+BE4_TIPREG+BE4_DIGITO),.F.),1,20))//Inicializador padrao original                       
		EndIf

	Case cCampo == 'BE4_PADINT'	
		If lCallCenter
			uRet := PLSACOMUSR(cMatric)
		Else
			uRet := Space(TamSx3('BE4_PADINT')[1])//Inicializador padrao original
		EndIf

	Case cCampo == 'BE4_DESPAD'
		If lCallCenter 
	   		uRet := Posicione('BI4',1,xFilial('BI4') + PLSACOMUSR(cMatric),'BI4_DESCRI')
	 	Else
	 	    uRet := If(Inclui,"",BI4->(Posicione("BI4",1,xFilial("BI4")+BE4->BE4_PADINT,"BI4_DESCRI")))//Inicializador padrao original                                             
	 	EndIf 
	 	
	Case cCampo == 'BE1_YCDPRO'
		If lCallCenter 
	   		uRet := SubStr(U_BUSCAPROD(cMatric,.T.),1,4)
	 	Else
			uRet := If(INCLUI,"",SubStr(U_BUSCAPROD(BEA->(BEA_OPEUSR+BEA_CODEMP+BEA_MATRIC+BEA_TIPREG+BEA_DIGITO),.T.),1,4))//Inicializador padrao original
		EndIf

	Case cCampo == 'BE1_YDSPRO'
		If lCallCenter 
	   		uRet := U_BUSCAPROD(cMatric,.F.)
	 	Else
	 	 	uRet := If(INCLUI,"",U_BUSCAPROD(BEA->(BEA_OPEUSR+BEA_CODEMP+BEA_MATRIC+BEA_TIPREG+BEA_DIGITO),.F.))//Inicializador padrao original
	 	EndIf

EndCase    

RestArea(aArea)

Return uRet