#INCLUDE "RWMAKE.CH"
#include "PLSMGER.CH"
#include "COLORS.CH"
#include "TOPCONN.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³PLS092B1  ºAutor  ³ Jean Schulz        º Data ³  13/09/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Inserir botao para chamada da rotina de Mural, criada para  º±±
±±º          ³a Caberj (rotina de internacao).                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Caberj.                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/                           
User Function PLS092B1

	//Local bBotao01 := {|| U_TELAMURAL("PLS092B1") }  //Angelo Henrique - Data: 28/03/2017 
	//Local aRet := {"RELATORIO","Mural Assistido",bBotao01} //Angelo Henrique - Data: 28/03/2017
	Local bBotao01 := {|| MENU092() }
	Local aRet := {"RELATORIO","Mural/Exceções",bBotao01} //Angelo Henrique - Data: 28/03/2017

	If alltrim( GetNewPar("MV_XLOGINT", '0') ) == '1' 

		If FunName() == "PLSA092" 

			u_LogMatInt(M->BE4_USUARI, M->BE4_NOMUSR, "PLS092B1")

		EndIf

	EndIf	

Return aRet                                  


Static Function MENU092 

	Local _aArea 	:= GetArea()
	Local _nOpc 	:= 0

	Private _oDlg	:= Nil
	Private _oBtn	:= Nil	
	Private _oGroup	:= Nil		

	DEFINE MSDIALOG _oDlg FROM 0,0 TO 90,380 PIXEL TITLE 'Seleção de Opções'

	_oGroup:= tGroup():New(02,05,40,175,'Selecione uma das opções',_oDlg,,,.T.)

	_oBtn := TButton():New( 15,020,"Mural Assistido"	,_oDlg,{||_oDlg:End(),_nOpc := 1	},060,012,,,,.T.,,"",,,,.F. )
	_oBtn := TButton():New( 15,100,"Exceções Cont/Sub"	,_oDlg,{||_oDlg:End(),_nOpc := 2	},060,012,,,,.T.,,"",,,,.F. )	

	ACTIVATE MSDIALOG _oDlg CENTERED

	If _nOpc = 1

		U_TELAMURAL("PLS092B1")

	ElseIf _nOpc = 2

		U_CABV028("1","2")

	EndIf

	RestArea(_aArea)

Return