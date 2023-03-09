#INCLUDE 'RWMAKE.CH'
#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'TOPCONN.CH'
#INCLUDE 'TBICONN.CH'

#DEFINE cEnt Chr(13)+Chr(10)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABA603   ºAutor  ³Angelo Henrique     º Data ³  01/11/17   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Rotina criada para remover as criticas geradas pela        a±±
±±º          ³auditoria na momento da internação, uma vez que a rotina    º±±
±±º          ³padrão esta dando erro de chave unica, pois tentava gravar  º±±
±±º          ³o mesmo item mais de uma vez.                               º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CABERJ                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function CABA603()
	
	Local _aArea 	:= GetArea()
	Local _aArBEJ 	:= BEJ->(GetArea())
	Local _aArBEL 	:= BEL->(GetArea())
	Local _aNvBel	:= Nil
	Local _nRet		:= M->BEJ_QTDPRO
	Local _cChav	:= ""
	
	DbSelectArea("BEL")
	DbSetOrder(1) //BEL_FILIAL + BEL_CODOPE + BEL_ANOINT + BEL_MESINT + BEL_NUMINT + BEL_SEQUEN
	If DbSeek(xFilial("BEL") + BEJ->(BEJ_CODOPE+BEJ_ANOINT+BEJ_MESINT+BEJ_NUMINT))
		
		While BEL->(!(EOF())) .And. BEJ->(BEJ_CODOPE+BEJ_ANOINT+BEJ_MESINT+BEJ_NUMINT) == BEL->(BEL_CODOPE+BEL_ANOINT+BEL_MESINT+BEL_NUMINT)
			
			_cChav := BEL->(BEL_CODOPE + BEL_ANOINT + BEL_MESINT + BEL_NUMINT)
			
			_aNvBel := BEL->(GetArea())
			
			While BEL->(!(EOF())) .And. BEJ->(BEJ_CODOPE+BEJ_ANOINT+BEJ_MESINT+BEJ_NUMINT) == BEL->(BEL_CODOPE+BEL_ANOINT+BEL_MESINT+BEL_NUMINT)
				
				If _cChav == BEL->(BEL_CODOPE + BEL_ANOINT + BEL_MESINT + BEL_NUMINT)
					
					RecLock("BEL",.F.)
					
					DbDelete()
					
					MsUnlock()
					
				EndIf
				
				BEL->(DbSkip())
				
			EndDo
			
			RestArea(_aNvBel)
			
			BEL->(DbSkip())
			
		EndDo
		
	EndIf
	
	RestArea(_aArea)
	RestArea(_aArBEJ)
	RestArea(_aArBEL)
	
Return _nRet

