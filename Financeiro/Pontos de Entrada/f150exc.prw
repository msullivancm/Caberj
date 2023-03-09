#INCLUDE "RWMAKE.CH"
#include "PLSMGER.CH"
#include "COLORS.CH"
#include "TOPCONN.CH"


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³F150EXC   ºMotta  ³Microsiga           º Data ³  07/11/07   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³  Ponto de entrada para nao permitir a gravacao no arquivo  º±±
±±º          ³  de titulos com o FormRec diferente de 06 para envio e     º±±  
±±º          ³  04 ou 06 para cancelamento                                º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/    
User Function F150EXC() 
	Local aArea := GetArea() // Adicionado por Luiz Otavio 10/03/2021
	Local bRet := .T. 

	bRet := ((SE1->E1_FORMREC == "06") .OR. (MV_PAR14 == 2))

// 01/01/08
// Atualiza o status do titulo para quando o tipo de envio for Sisdeb.
//
// Atualmente a verificação do tipo do envio é informada através do arquivo
// de configuração.

	If bRet .And. Upper(AllTrim(mv_par03)) == "SISDEBPM.2RE"
		RecLock("SE1", .F.)
		SE1->E1_YTPEXP	:= "C"
		SE1->E1_YTPEDSC	:= Posicione("SX5", 1, xFilial("SX5")+"K1"+"C", "X5_DESCRI")
		SE1->(MsUnlock())
	EndIf              
	
	dbSelectArea("SEA")
	dbSetOrder(1)
	dbSeek(xFilial("SEA") + SE1->E1_NUMBOR + SE1->E1_PREFIXO + SE1->E1_NUM + SE1->E1_PARCELA + SE1->E1_TIPO)
	 //***********Adicionado por Luiz Otávio (10/03/2021) *********************************************
	 //Para realizar a gravação da Sub-Conta no momento da geração do arquivo CNAB de cobrança remessa 
	 dbSelectArea("SEA")
  	 RecLock("SEA",.F.)
	 SEA->EA_XSUBCON := cSubCta //SEE->EE_SUBCTA
	 MsUnlock()

	 dbSelectArea("SEE")
	 dbsetorder(1)
	 dbSeek(xFilial("SEE")+SEA->EA_PORTADO+SEA->EA_AGEDEP+SEA->EA_NUMCON+SEA->EA_XSUBCON)  

	//------------------------------------------------------------------------------
	//Luiz Otávio - Data:16/06/2021
	//------------------------------------------------------------------------------
	If Upper(AllTrim(mv_par03)) != "SISDEBPM.2RE" //SEE->EE_CODCART = "04"
		DbSelectArea("SE1")
		RecLock("SE1", .F.)
		SE1->E1_YTPEXP	:= "B"
		SE1->E1_YTPEDSC	:= Posicione("SX5", 1, xFilial("SX5")+"K1"+"B", "X5_DESCRI")
		SE1->(MsUnlock())	
	EndIf

	//*************************************************************************************************//


	RestArea(aArea) // Adicionado por Luiz Otavio 10/03/2021											 
	
Return bRet