#Include "protheus.ch"
#Include "rwmake.ch"
#Include "topconn.ch"
#INCLUDE "plsmcon.ch"
#include "TCBROWSE.CH"
#include "PLSMGER.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³PL660VDC  ºAutor  ³Marcela Coimbra     º Data ³  12/11/14   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Ponto de entrada execudado na inclusão e alteração de     rº±±
±±º          ³ contrato empresa para validar campos caso a cobrança       º±±
±±º          ³ esteja parametrizada no nível do contrato                  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function PL660VDC()

Local l_Ret		:= .T.
Local c_Func 	:= ProcName(2)
Local c_Alias	:= "BT5"

l_Ret := u_VLDCeS( c_Alias )

Return l_Ret
                                       

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³VLDCeS    ºAutor  ³Marcela Coimbra     º Data ³  07/08/15   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Rotina criada pararealizar as validações na rotina de       º±±
±±º          ³contratos e sub-contratos.                                  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºAlteração ³Angelo Henrique - Data:07/08/2015                           º±±
±±º          ³Criado a tela para exibir os campos para serem preenchidos  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CABERJ                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function VLDCeS( c_Alias )

Local l_Ret		:= .T.
Local c_Msg		:= "" //Angelo Henrique - Data:07/08/2015
Local _aMsg		:= {} //Angelo Henrique - Data:07/08/2015
Local _aButtons := {} //Angelo Henrique - Data:07/08/2015
Local _cCabec	:= "Favor preencher os campos listados:" //Angelo Henrique - Data:07/08/2015

If &( "M->" + c_Alias + "_COBNIV" ) == "1"   .AND.  GetNewPar("MV_XBRAIN",'S') == "N" 
	
	If Empty( &( "M->" + c_Alias + "_NATURE" ))
		
		//c_Msg := IIF(Empty(c_Msg), "", ", ") + "natureza"
		//l_Ret		:= .F.
		
		AADD(_aMsg,_cCabec)
		AADD(_aMsg," - Natureza")
		
	EndIf
	
	If Empty( &( "M->" + c_Alias + "_TIPPAG" ))
		
		//c_Msg := IIF(Empty(c_Msg), "", ", ") + "tipo de pagamento"
		//l_Ret		:= .F.
		
		If !(Len(_aMsg) > 0)
			
			AADD(_aMsg,_cCabec)
			
		EndIf
		
		AADD(_aMsg," - Tipo de Pagamento") //Angelo Henrique - Data:07/08/2015
		
	EndIf
	
	If Empty( &( "M->" + c_Alias + "_PORTAD" ))
		
		//l_Ret		:= .F.
		//c_Msg := IIF(Empty(c_Msg), "", ", ") + "banco operadora"
		
		If !(Len(_aMsg) > 0)
			
			AADD(_aMsg,_cCabec)
			
		EndIf
		
		AADD(_aMsg," - Banco Operadora") //Angelo Henrique - Data:07/08/2015
		
	EndIf
	
	If Empty( &( "M->" + c_Alias + "_AGEDEP" ))
		
		//l_Ret		:= .F.
		//c_Msg := IIF(Empty(c_Msg), "", ", ") + "agencia operadora"
		
		If !(Len(_aMsg) > 0)
			
			AADD(_aMsg,_cCabec)
			
		EndIf
		
		AADD(_aMsg," - Agencia Operadora") //Angelo Henrique - Data:07/08/2015
		
	EndIf
	
	If Empty( &( "M->" + c_Alias + "_CTACOR" ))
		
		//l_Ret		:= .F.
		//c_Msg := IIF(Empty(c_Msg), "", ", ") + "conta operadora"
		
		If !(Len(_aMsg) > 0)
			
			AADD(_aMsg,_cCabec)
			
		EndIf
		
		AADD(_aMsg," - Conta Operadora") //Angelo Henrique - Data:07/08/2015
		
	EndIf
	
EndIf

//----------------------------------
//Angelo Henrique - Data:07/08/2015
//----------------------------------
If Len(_aMsg) > 0
	
	l_Ret := .F.
	
	AADD(_aButtons, { 1,.T.,{|o| nOpcao:= 1,o:oWnd:End()} } )
	
	FormBatch( "Atenção", _aMsg, _aButtons,,200,530 )
	
EndIf


Return l_Ret
