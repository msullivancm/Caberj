#include "Rwmake.ch"

User Function FA040ALT //Valida se pode ou n�o alterar t�tulo a receber
Local aArea := GetArea()
Local lRet := .T. //Vari�vel de Retorno

//Alert("FA040ALT")

RestArea(aArea)
Return lRet