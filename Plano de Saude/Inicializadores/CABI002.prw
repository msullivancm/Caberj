#INCLUDE 'PROTHEUS.CH'

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABI002   ºAutor  ³Leonardo Portella   º Data ³  13/12/12   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Usado para inicializar o vetor que carrega o browse na tela º±±
±±º          ³de situacoes adversas no familia/usuario > usuario.         º±±
±±º          ³Nao estava carregando e somente colocar o inicializador     º±±
±±º          ³padrao nao resolveu, por isso preencho o vetor que alimenta º±±
±±º          ³o browse no momento da construcao (quando chama o iniciali- º±±
±±º          ³zador padrao).                                              º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³CABERJ                                                      º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function CABI002

Local cDesc 	:= " "
Local aAreaBGX	:= BGX->(GetArea())
Local nI		:= 0
Local nPosSit	:= 0
Local nPosDes	:= 0
                                  
//Leonardo Portella - 15/02/13 - Emergencial - Nao executar quando for chamado pelo CallCenter
If AllTrim(Upper(FunName())) <> 'TMKA271' 

	nPosSit	:= aScan(aCabBHH,{|x|x[2] == 'BHH_CODSAD'})
	nPosDes	:= aScan(aCabBHH,{|x|x[2] == 'BHH_DESSAD'})
	
	For nI := 1 to len(aDadBHH) 
		If !empty(aDadBHH[nI][nPosSit]) .and. empty(aDadBHH[nI][nPosDes])
			BGX->(DbSetOrder(1))
			If BGX->(MsSeek(xFilial('BGX') + BA3->BA3_CODINT + aDadBHH[nI][nPosSit]))
				aDadBHH[nI][nPosDes] := BGX->BGX_DESCRI
			EndIf
		EndIf
	Next
	
	cDesc := If(!empty(aDadBHH[len(aDadBHH),nPosDes]),aDadBHH[len(aDadBHH),nPosDes]," ")
	
EndIf

BGX->(RestArea(aAreaBGX))

Return cDesc