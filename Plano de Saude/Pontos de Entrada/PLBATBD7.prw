#include 'Protheus.ch'

//Bloqueia ou n�o o pagamento na importa��o XML

User Function PLBATBD7

Local lBloq := .F.

If IsInCallStack('PLSA973')
	
EndIf

Return lBloq
