#INCLUDE 'RWMAKE.CH'
#INCLUDE 'PROTHEUS.CH'
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³PLS092INT ºAutor  ³Renato Peixoto      º Data ³  19/09/11   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Ponto de entrada no momento da digitacao da data e hora    º±±
±±º          ³ da internacao. Se for hospital-dia, data e hora serao      º±± 
±±º          ³ preenchidas automaticamente.                               º±± 
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function PLS092INT()

Local aArea := GetArea()

if BE4->BE4_REGINT == "2"		// 1=Hospitalar;2=Hospital-Dia;3=Domiciliar

	if BE4->BE4_GRPINT <> "5"	// 1=Internacao Clinica;2=Internacao Cirurgica;3=Internacao Obstetrica;4=Internacao Pediatrica;5=Internacao Psiquiatrica

		RecLock("BE4",.F.)
			BE4->BE4_DTALTA	:= ParamIxb[1]
			BE4->BE4_HRALTA	:= "2200"
			BE4->BE4_TIPALT	:= "1"
		BE4->(MsUnlock())
	
	endif

endif

if AllTrim(funname()) == "RPC"		// Chamada do HAT

	BE4->( RecLock("BE4", .F.) )
		BE4->BE4_MSG01 := "Data de Internacao informada pelo HAT"
	BE4->( MsUnLock() )

else

	INFOINT()//Leonardo Portella - 24/06/13

endif

RestArea(aArea)

Return  




/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³INFOINT   º Autor ³ Joany Peres        º Data ³  04/06/13   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Informacoes complementares para autorizacao de internacao  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CABERJ                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function INFOINT

Local oDlgInt 	:= Nil
Local dMsg01	:= If(Empty(BE4->BE4_MSG01),Space(TamSx3("BE4_MSG01")[1]),BE4->BE4_MSG01 )
Local dMsg02	:= If(Empty(BE4->BE4_MSG02),Space(TamSx3("BE4_MSG02")[1]),BE4->BE4_MSG02 )
Local dMsg03	:= If(Empty(BE4->BE4_MSG03),Space(TamSx3("BE4_MSG03")[1]),BE4->BE4_MSG03 ) 
Local oFont 	:= Nil
Local nOpca   	:= 2
Local bOk		:= {||If( Empty(dMsg03), MsgStop("O campo Informação é obrigatório",AllTrim(SM0->M0_NOMECOM)), (nOpca := 0, oDlgInt:End()) )} 

If empty(dMsg03)
	
	DEFINE FONT oFont NAME "Arial" SIZE 000,-012 BOLD 
	
	DEFINE MSDIALOG oDlgInt TITLE "Informações de Internação - " + AllTrim(SM0->M0_NOMECOM) FROM 007.2,006.6 TO 016,076 OF GetWndDefault() Style DS_MODALFRAME    
	
		oDlgInt:lEscClose  := .F. //cancela o sair pela tecla 'ESC'

		@ 05, 10  Say oSay PROMPT "Mensagem"      		SIZE 65,10 	OF oDlgInt PIXEL FONT oFont  
		@ 05, 70  MSGET oGet VAR dMsg01					SIZE 200,10 OF oDlgInt FONT oFont PICTURE "@A" PIXEL 
	
		@ 20, 10  Say oSay PROMPT "Compl. Mensagem" 	SIZE 65,10 	OF oDlgInt PIXEL FONT oFont 
		@ 20, 70  MSGET oGet VAR dMsg02					SIZE 200,10 OF oDlgInt FONT oFont PICTURE "@A" PIXEL 
	
		@ 35, 10  Say oSay PROMPT "Informação" 	    	SIZE 65,10 	OF oDlgInt PIXEL FONT oFont 
		@ 35, 70  MSGET oGet VAR dMsg03					SIZE 200,10 OF oDlgInt FONT oFont PICTURE "@A" PIXEL 
	
		oBtSalvar	:= TButton():New(50,230, 'Salvar',,bok,040, 012 ,,,,.T.)
	
	ACTIVATE MSDIALOG oDlgInt CENTERED 
	
	If nOpca == 0 

		Begin Transaction

		BE4->( RecLock("BE4", .F.) )
		BE4->BE4_MSG01 := dMsg01
		BE4->BE4_MSG02 := dMsg02
		BE4->BE4_MSG03 := dMsg03
		BE4->( MsUnLock() )
	
		End Transaction
		
	EndIf
	
EndIf
	
Return
