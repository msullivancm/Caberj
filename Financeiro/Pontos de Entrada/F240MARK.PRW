#Include 'Protheus.ch'

/*/
----------------------------------------------------------------------------
Programa  F240MARK()º Autor ³ MMT      º Data ³  07/07/2022   
----------------------------------------------------------------------------
Descricao  Ponto de entrada para O ponto entrada F240MARK altera as 
            posições dos campos de tela MarkBrowse.
----------------------------------------------------------------------------
//
//
//
/*/


User Function F240MARK()
Local aArea := GetArea()
Local aRet := PARAMIXB

aadd(aRet,{"E2_CODBAR","","COD.BAR", ""})

RestArea(aArea)

Return aRet
