
#INCLUDE "RWMAKE.CH"
#include "PLSMGER.CH"
#include "COLORS.CH"
#include "TOPCONN.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³PLS092B2  ºAutor  ³ Jean Schulz        º Data ³  30/05/07   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Inserir botao para chamada da rotina de calculo de diarias  º±±
±±º          ³conforme separacao da Caberj.                               º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Caberj.                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/                                      
User Function PLS092B2
Local bBotao02 := {|| CalcQtdDia() }
Local aRet := {"VERNOTA","Calcula Qtd Diarias",bBotao02}  

If alltrim( GetNewPar("MV_XLOGINT", '0') ) == '1' 

	If FunName() == "PLSA092" 
	
		u_LogMatInt(M->BE4_USUARI, M->BE4_NOMUSR, "PLS092B2")
	
	EndIf

EndIf

	
Return aRet

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CalcQtdDiaºAutor  ³ Jean Schulz        º Data ³  30/05/07   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Calcula qtd de dias ja liberados para internacao em questaoº±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function CalcQtdDia
Local aAreaBEJ	:= BEJ->(GetArea())
Local aAreaBQV	:= BQV->(GetArea())
Local aAreaBR8	:= BR8->(GetArea())
Local nTotDia	:= 0
Local nTotUTI	:= 0

Local nDiaRcN	:= 0
Local nUtiRcN	:= 0

Local aVetDia	:= {}    



BR8->(DbSetOrder(3))

If !Empty(M->BE4_DATPRO)
	
	BEJ->(MsSeek(xFilial("BEJ")+PLSINTPAD()+BE4->(BE4_ANOINT+BE4_MESINT+BE4_NUMINT)))
	
	While !BEJ->(Eof()) .And. BE4->(BE4_ANOINT+BE4_MESINT+BE4_NUMINT)==BEJ->(BEJ_ANOINT+BEJ_MESINT+BEJ_NUMINT)
	
		If Posicione("BR8",3,xFilial("BR8")+BEJ->BEJ_CODPRO,"BR8_TPPROC") == "4" //DIARIAS
	
			If BEJ->BEJ_STATUS <> "0" .And. BEJ->BEJ_PENDEN <> "1"				
				nTotDia += BEJ->BEJ_QTDPRO
			Endif
		Endif
	
		BEJ->(DbSkip())
	Enddo
	

	BQV->(MsSeek(xFilial("BQV")+PLSINTPAD()+BE4->(BE4_ANOINT+BE4_MESINT+BE4_NUMINT)))
	
	While !BQV->(Eof()) .And. BE4->(BE4_ANOINT+BE4_MESINT+BE4_NUMINT)==BQV->(BQV_ANOINT+BQV_MESINT+BQV_NUMINT)
	
		If BQV->BQV_STATUS <> "0" .And. BQV->BQV_PENDEN <> "1"
		
			If Posicione("BR8",3,xFilial("BR8")+BQV->BQV_CODPRO,"BR8_TPPROC") == "4" //DIARIAS
				If BQV->BQV_TIPDIA == "2"
					If BQV->BQV_ATERNA == "1"
						nUtiRcN	+= BQV->BQV_QTDPRO
					Else
						nTotUTI += BQV->BQV_QTDPRO
					Endif
				Else
					If BQV->BQV_ATERNA == "1"
						nDiaRcN += BQV->BQV_QTDPRO
					Else
						nTotDia += BQV->BQV_QTDPRO
					Endif	
				Endif
			Endif
			
		Endif
	
		BQV->(DbSkip())
	Enddo
	
	If nTotUti+nTotDia+nDiaRcN+nUtiRcN > 0	
		If nTotDia > 0
			aadd(aVetDia,{"Total de Diárias liberadas: ",Alltrim(Str(nTotDia))})
		Endif
		If nTotUTI > 0
			aadd(aVetDia,{"Diárias de UTI liberadas: ",Alltrim(Str(nTotUTI))})
		Endif
		
		If nDiaRcN > 0
			aadd(aVetDia,{"Diárias de Rec.Nasc. liberadas: ",Alltrim(Str(nDiaRcN))})
		Endif
		If nUtiRcN > 0
			aadd(aVetDia,{"Diárias de UTI Rec.Nasc. liberadas: ",Alltrim(Str(nUtiRcN))})
		Endif	
		
		aadd(aVetDia,{"Diárias liberadas até: ",DtoC(BE4->BE4_DATPRO+(nTotUti+nTotDia+nDiaRcN+nUtiRcN))})
	Else
		aadd(aVetDia,{"Não existem diárias liberadas para esta internação!",""})
	Endif
		
	If Len(aVetDia) > 0
		PLSCRIGEN(aVetDia,{ {"Tipo de informação","@C",200},{"Detalhe","@C",100}},"Análise de diárias liberadas",.T.)
	Endif        
	
Else
	MsgAlert("É necessário informar uma data de internação para visualizar as diárias autorizadas!")
Endif

RestArea(aAreaBEJ)
RestArea(aAreaBQV)
RestArea(aAreaBR8)

Return Nil