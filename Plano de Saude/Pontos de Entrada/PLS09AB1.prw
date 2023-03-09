//-------------------------------------------------------------------
/*/{Protheus.doc} function PLS09AB1
description Ponto de entrada utilizado para acrescentar botões na
rotina de prorrogação
@author  author Angelo Henrique
@since   date 01/09/2021
@version version
/*/
//-------------------------------------------------------------------
User Function PLS09AB1

	Local bBotao01  := {|| U_TELAMURAL("PLS09AB1") }  
	Local aRet      := {"RELATORIO","Mural Assistido",bBotao01} 
	
Return aRet     