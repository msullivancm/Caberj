#include "Rwmake.ch"

User Function FA040ALT //Valida se pode ou não alterar título a receber
Local aArea := GetArea()
Local lRet := .T. //Variável de Retorno

//Alert("FA040ALT")

RestArea(aArea)
Return lRet