/*/{Protheus.doc} PLS105MN
Ponto de entrada para adicionar opções no menu da rotina PLSA105
@type function
@version  1.0
@author angelo.cassago
@since 19/10/2022
@return variant, retorna a nova opção de menu
/*/
User Function PLS105MN()
	
	Local aRotina := {}
	
	AADD(aRotina, { "Importar/Extrair Tabela"      , "U_CABA100('1')"   , 0, 8 })	

Return aRotina
	