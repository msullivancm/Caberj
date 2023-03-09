/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³PLSE2BVL  ºAutor  ³Microsiga           º Data ³  08/08/07   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Muda o valor do decrescimo no titulo caso obedeca a regra   º±±
±±º          ³da operadora.                                               º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function PLSE2BVL()
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Faz a mudanca conforme cliente.                                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
Local nPos		:= 0
Local aAreaBAU	:= BAU->(GetArea())
Local aArray	:= paramixb[1]
Local cCodRDA	:= paramixb[2]
Local aBases	:= paramixb[3]  
local cTipTit   := paramixb[1][2][2]
Local lOperad	:= .F.

BAU->(DbSetOrder(1))
BAU->(MsSeek(xFilial("BAU")+cCodRDA))
//ALTAMIRO EM 23/08/2011
IF cTipTit == "COM"
	lOperad := .T.
ELSEIf BAU->(Found()) .And. BAU->BAU_TIPPRE == "OPE"
	lOperad := .T.
Endif

//Regra: aplicar tarifa bancaria a todos os RDAS diferentes de operadoras
//e que tenham conta em bancos diferentes de 029 e 341, conforme regra
//repassada por Leandro (Caberj) em 20/09/07.

If !lOperad .And. !(SA2->A2_BANCO $ GetNewPar("MV_YBANDOC","029,341"))
	nPos := aScan(aArray,{ |x| x[1] == "E2_DECRESC"})
	If nPos <> 0
		aArray[nPos,2] := GetNewPar("MV_YVLRDOC",2.93) 
	else 
   	    aAdd(aArray, {"E2_DECRESC"   ,GetNewPar("MV_YVLRDOC",2.93)    ,NIL})	
	Endif
Endif

RestArea(aAreaBAU)

Return({aArray,aBases})