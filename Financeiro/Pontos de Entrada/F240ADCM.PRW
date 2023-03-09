#Include 'Protheus.ch'

/*/
----------------------------------------------------------------------------
Programa  F240ADCM()º Autor ³ MMT      º Data ³  07/07/2022   
----------------------------------------------------------------------------
Descricao  Para os campos da tabela SE2 que não fazem parte da estrutura 
original da tabela temporária SE2TMP, o ponto de entrada F240ADCM deve ser 
utilizado para adicionar o campo. 
----------------------------------------------------------------------------
//
//
//
/*/

User Function F240ADCM()
Local aCamposADCM := {}

aAdd(aCamposADCM,'E2_CODBAR')

Return aCamposADCM
