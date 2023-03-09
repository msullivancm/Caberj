#INCLUDE 'PROTHEUS.CH'

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABV045     ºAutor  ³Mateus Medeiros  º Data ³  12/03/18   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Validações Ajuste protocolo de remessa de fatura           º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CABERJ                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±ºParametros³ Esta rotina será chamada de vários campos:                 º±±
±±º   1      ³ Chamada 1 virá do campo ZZP_CODRDA                        º±±
±±º          ³                                                            º±±
±±º          ³                                                            º±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function CABV045(_cParam)
	
	Local _aArea	:= GetArea()
	Local _aArBAU   := BAU->(GetArea())
	Local _lRet		:= .T.
	Local dVldDay   := FirstDate( dDataBase )-1 // pega o último dia do mês ao anterior ao corrente
	Local nDayBloq  := SuperGetMv("MV_YDAYBLQ",.T.,60)	
	Local lUsrPode 	:= ( AllTrim(Upper(cUserName)) $ GetNewPar('MV_XUSCARE','MARIANA.OLIVEIRA|DANIELLE|ANTONIOA|LEONARDO.PORTELLA') )//Usuarios que podem cancelar
	Default _cParam	:= ""
	
	
	if !Empty(_cParam) 
		
			dbselectarea("BAU")
			BAU->(dbsetorder(1))
			if BAU->(dbseek(xFilial("BAU")+_cParam))	
				if !Empty(BAU->BAU_DATBLO)
					nTotDay := dVldDay - BAU->BAU_DATBLO
					
					if nTotDay > nDayBloq 
						if lUsrPode
							_lRet := MsgYesNo( " Data de bloqueio do prestador superior a 60 dias ( Prestador bloqueado em "+dtoc(BAU->BAU_DATBLO)+" ). Prestador bloqueado em "+dtoc(BAU->BAU_DATBLO)+". Deseja prosseguir? ")
						else 
							_lRet := .F.
							
							MsgStop(" Data de bloqueio do prestador superior a 60 dias ( Prestador bloqueado em "+dtoc(BAU->BAU_DATBLO)+" ). Solicite a coordenação do contas médicas a inclusão da remessa.")
//							MsgStop( "Prestador bloqueado em "+dtoc(BAU->BAU_DATBLO)+". Para recebimento de remessa solicite a coordenação do contas médicas a liberação.")
						endif 
					endif 
					
				endif 			
			endif 
		
	EndIf
	
	
	RestArea(_aArBAU)
	RestArea(_aArea	)
	
Return _lRet