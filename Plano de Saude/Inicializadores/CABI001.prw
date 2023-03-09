/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABI001   ºAutor  ³Leonardo Portella   º Data ³  25/09/12   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Inicializador padrao do campo BD5_NUMIMP para quando for um º±±
±±º          ³RDA de reciprocidade trazer um sequencial automatico.       º±±
±±º          ³Em outros RDAs ira trazer o conteudo original do campo, ou  º±±
±±º          ³seja, BCI->BCI_NRIMUN.                                      º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³CABERJ                                                      º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

***************************************************************************************************************************************

//Nao eh internacao E nao eh clone OU eh clone mas nao eh a guia origem do clone
Static bCloneOk := {||( BCI->BCI_CODLDP <> '0000' ) .and. ( empty(BD5->BD5_GUESTO) .or. ( !empty(BD5->BD5_GUESTO) .and. BD5->BD5_ESTORI <> '0' ) ) }

//Leonardo Portella - 11/10/12 - Para estes RDAs o campo deve ficar digitavel e nao deve ter sequencial pois, apesar de serem reciprocidades, enviam o numero
//impresso proprio. Chamado ID: 3826/3864
Static bRDAsExc	:= {||( AllTrim(BAU->BAU_CODIGO) $ GetNewPar('MV_YRDAEXC','040495|095818|010480|071129|013013|103969') )}

***************************************************************************************************************************************

User Function CABI001

Local cRet 		:= BCI->BCI_NRIMUN//Inicializador padrao original do campo BD5_NUMIMP
Local cProxImp 	:= ''
Local aArea		:= GetArea()
Local aAreaBAU	:= BAU->(GetArea())

// MV_YOPAVLC guarda os codigos de Operadora (BA0) de Intercambio 
//Bianchini - Retirado o cEMPANT porque a Integral passou a ter reciprocidade
//If ( ( cEmpAnt == '01' ) .and. ( ( FunName() == 'PLSA498' ) .and. ( BAU->BAU_CODOPE $ GetMv('MV_YOPAVLC') ) ) ) 
If ( ( FunName() == 'PLSA498' ) .and. ( BAU->BAU_CODOPE $ GetMv('MV_YOPAVLC') ) ) 
	If Eval(bCloneOk) .and. !Eval(bRDAsExc)
	
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Nao posso usar GetSx8Num pois a numeracao nao eh de todos no campo, somente do numero impresso de reciprocidade. Tambem nao³
		//³posso fazer MAX() pois preciso garantir que seja unico. Pode ocorrer de digitarem ao mesmo tempo e o MAX() pegaria o mesmo.³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		cProxImp := GetMv('MV_XIMPRCP')
		PutMv('MV_XIMPRCP',Left(cProxImp,4) + Soma1(Substr(cProxImp,5,16)))
	
		cRet 	 := cProxImp
		
	EndIf

EndIf

BAU->(RestArea(aAreaBAU))
RestArea(aArea)

Return cRet

***************************************************************************************************************************************

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Na digitacao de Contas Medicas somente sera editavel se nao     ³
//³for Reciprocidade. Em outras rotinas sera editavel. BD5_NUMIMP  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

User Function EdiNumImp

Local lRet 		:= .T.                                                                      
Local aArea		:= GetArea()
Local aAreaBAU	:= BAU->(GetArea())

//Bianchini - Retirado o cEMPANT porque a Integral passou a ter reciprocidade
//If cEmpAnt == '01' .and. Eval(bCloneOk)
If Eval(bCloneOk)
	lRet := ( ( FunName() <> 'PLSA498' ) .or. !( BAU->BAU_CODOPE $ GetMv('MV_YOPAVLC') ) .or. Eval(bRDAsExc) ) 
EndIf

BAU->(RestArea(aAreaBAU))
RestArea(aArea)

Return lRet

***************************************************************************************************************************************