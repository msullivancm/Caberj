#Include 'Protheus.ch'

/*/
----------------------------------------------------------------------------
Programa  F240ADCM()� Autor � MMT      � Data �  07/07/2022   
----------------------------------------------------------------------------
Descricao  Para os campos da tabela SE2 que n�o fazem parte da estrutura 
original da tabela tempor�ria SE2TMP, o ponto de entrada F240ADCM deve ser 
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
