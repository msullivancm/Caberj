#INCLUDE "PROTHEUS.CH"
#INCLUDE "RWMAKE.CH"
#INCLUDE "TOPCONN.CH"
#include "TOTVS.CH"


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ CABA201  ºAutor  ³ Fred O. C. Jr     º Data ³  14/10/21    º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³   Cadastro de Carência para Benef. vindo da Concorrência   º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function CABA201()

Local cAlias		:= "ZS0"
Local cCadastro		:= "Cadastro de Carência - Beneficiários da Concorrência"
Local cVldAlt		:= ".T."													// Validação da inclusão/alteração
Local cVldExc		:= ".T."													// Validação da exclusão

dbSelectArea(cAlias)
(cAlias)->(dbSetOrder(1))

AxCadastro( cAlias, cCadastro, cVldExc, cVldAlt)

return


//--------------------------------------------------------------------------------------------------------------//
//						Inicializador do browse - regra grande demais para o SX3 ou SX7							//
//--------------------------------------------------------------------------------------------------------------//
User Function CABA201A(nTp)

Local cRet	:= ""

if nTp == 1			// Contrato (browse)
	cRet	:= POSICIONE("BT5",1,XFILIAL("BT5")+PLSINTPAD()+ZS0->(ZS0_CODEMP+ZS0_NUMCON+ZS0_VERCON),"BT5_YDESCR")
elseif nTp == 2		// Subcontrato (gatilho e inic. padrão)
	cRet	:= POSICIONE("BQC",1,XFILIAL("BT5")+PLSINTPAD()+M->(ZS0_CODEMP+ZS0_NUMCON+ZS0_VERCON+ZS0_SUBCON+ZS0_VERSUB),"BQC_DESCRI")
else				// Subcontrato (browse)
	cRet	:= POSICIONE("BQC",1,XFILIAL("BT5")+PLSINTPAD()+ZS0->(ZS0_CODEMP+ZS0_NUMCON+ZS0_VERCON+ZS0_SUBCON+ZS0_VERSUB),"BQC_DESCRI")
endif

return cRet
