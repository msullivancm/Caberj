*-----------------------------------*
/*/{Protheus.doc} CABA244

@project Novas Empresas
@description Manutenção do cadastro de Documentações para o Sub-Contrato
@author Rafael Rezende
@since 14/12/2022
@version 1.0		
@return
@see www.rgrsolucoes.com.br/
/*/               

#Include "Protheus.ch"

*---------------------*
User Function CABA244()
*---------------------*
Private cCadastro   := "Documentação de Sub-Contratos"
Private cDelFunc    := ".T." // Validacao para a exclusao. Pode-se utilizar ExecBlock
Private aRotina     := { { "Pesquisar"  , "AxPesqui"    , 00, 01 } ,;
    		             { "Visualizar" , "AxVisual"    , 00, 02 } ,;
            		     { "Incluir"    , "AxInclui"    , 00, 03 } ,;
    		             { "Alterar"    , "AxAltera"    , 00, 04 } ,;
            		     { "Excluir"    , "AxDeleta"    , 00, 05 }  }
DbSelectArea( "Z04" )
DbSetOrder( 01 )
mBrowse( 06, 01, 22, 75, "Z04" )

Return
