#Include "protheus.ch"
#include "RWMAKE.CH"
#Include "topconn.ch"
#INCLUDE "plsmcon.ch"
#include "TCBROWSE.CH"
#include "PLSMGER.CH"   


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³AJUSBFA   ºAutor  ³Microsiga           º Data ³  05/06/09   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function AJUSBFA
Local cSQL 		:= ""
Local cGruGen	:= "0005" 

If !MsgYesNo("Esta rotina irá criar vários registros na BFA baseando-se na BR8!!! Você deve excluir os registros antigos manualmente. Deseja continuar?")
	MsgAlert("Rotina abortada!")
	Return
Endif

cSQL := " SELECT * "
cSQL += " FROM "+RetSQLName("BR8")+" BR8 "
cSQL += " WHERE BR8_FILIAL = '  ' "
//cSQL += " AND BR8_BENUTL = '0' "
//cSQL += " AND BR8_CODPSA = '00049999' "
cSQL += " AND D_E_L_E_T_ = ' ' "

If Select("TRB") > 0
	dbSelectArea("TRB")
	dbclosearea()
Endif   

TCQuery cSQL Alias "TRB" New

dbSelectArea("TRB")
                         
While !TRB->(Eof())

	If TRB->BR8_YNEVEN <> 0
	
		cSQL := " SELECT BF0_CODIGO "
		cSQL += " FROM "+RetSQLName("BF0")+" BF0 "
		cSQL += " WHERE BF0_FILIAL = '"+xFilial("BF0")+"' "
		cSQL += " AND BF0_YNEVEN = "+Str(TRB->BR8_YNEVEN)
		cSQL += " AND D_E_L_E_T_ = ' ' "
		
		If Select("TRB2") > 0
			dbSelectArea("TRB2")
			dbclosearea()
		Endif   
		
		TCQuery cSQL Alias "TRB2" New
		
		dbSelectArea("TRB2")
		                         
		If !Empty(TRB2->BF0_CODIGO)
	
			BFA->(RecLock("BFA",.T.))
			BFA->BFA_FILIAL := xFilial("BFA")
			BFA->BFA_GRUGEN := cGruGen
			BFA->BFA_CODIGO := TRB2->BF0_CODIGO
			BFA->BFA_CODPSA := TRB->BR8_CODPSA
			BFA->BFA_ATIVO	:= "1"
			BFA->BFA_CODPAD := TRB->BR8_CODPAD
			BFA->(MsUnlock())			
		Else
			MsgAlert("Classificacao nao encontrada! "+Str(TRB->BR8_YNEVEN))
		Endif
	Else

		BFA->(RecLock("BFA",.T.))
		BFA->BFA_FILIAL := xFilial("BFA")
		BFA->BFA_GRUGEN := cGruGen
		BFA->BFA_CODIGO := "1.6"
		BFA->BFA_CODPSA := TRB->BR8_CODPSA
		BFA->BFA_ATIVO	:= "1"
		BFA->BFA_CODPAD := TRB->BR8_CODPAD
		BFA->(MsUnlock())			
	
	Endif

	TRB->(DbSkip())
	
Enddo

MsgAlert("Processamento finalizado! ")

Return
