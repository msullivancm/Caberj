#Include "PROTHEUS.CH"
#Include "UTILIDADES.CH"
#INCLUDE "rwmake.ch"

/*------------------------------------------------------------------------
| Funcao    | CABA570  | Otavio Pinto                  | Data | 05/03/15  |
|-------------------------------------------------------------------------|
| Descricao | MBrowse para a tabela ZRK (Cadastro de Usuários)            |
|-------------------------------------------------------------------------|
| Uso       |                                                             |
|           |                                                             |
|-------------------------------------------------------------------------|
| Alterado  |                                          | Data             |
|           |                                                             |
|           |                                                             |
|           |                                                             |
 ------------------------------------------------------------------------*/
user function CABA570()
private cLibera   := GetNewPar("MV_CABA570","000668,000064,000786,000678,000250,000241")
private cCadastro := "Cadastro de Usuários"
//private cDelFunc  := ".F." // Validacao para a exclusao. Pode-se utilizar ExecBlock
private cString   := "ZRK"

private aCdCores  := { { 'BR_VERDE'      ,'Ativo'      },;
                       { 'BR_VERMELHO'   ,'Bloqueado'  } }
                         
private aCores    := { { 'ZRK_BLOQ <> "S" ',aCdCores[1,1]  },;
                       { 'ZRK_BLOQ == "S" ',aCdCores[2,1]  } }

private aRotina   := { {"Pesquisar" , "AxPesqui" , 0, 1},;
                       {"Visualizar", "AxVisual" , 0, 2},;
                       {"Incluir"   , "AxInclui" , 0, 3},;
                       {"Alterar"   , "AxAltera" , 0, 4},;
                       {"Excluir"   , "AxDeleta" , 0, 5},;
                       {"Legenda"   , "u_ZKLegen", 0, 6} }

begin sequence                                              

    if !( __cUserID $ AllTrim(cLibera) )
       MsgAlert("Acesso permitido somente aos usuarios habilitados a executar esta rotina!"+CHR(13)+CHR(13)+; 
                "SOLUCAO: Incluir ID do usuario no parametro MV_CABA570."+CHR(13)+CHR(13)+;
                "Verifique com sua gerencia.", "AVISO" )
       break
    endif

    dbSelectArea(cString)
    (cString)->( dbSetOrder(1) ) ; (cString)->( dbGoTop() )

    (cString)->( mBrowse(,,,,cString, , , , , Nil    , aCores)  )

endsequence

return


/*------------------------------------------------------------------------
| Funcao    | ZKLegen   | Otavio Pinto                 | Data | 05/03/15  |
|-------------------------------------------------------------------------|
| Descricao | Rotina para exibir a janela da legenda.                     |
|           |                                                             |
|           |                                                             |
+------------------------------------------------------------------------*/
user function ZKLegen()
local aLegenZK := { { aCdCores[1,1],aCdCores[1,2] },;
	                { aCdCores[2,1],aCdCores[2,2] } }


BrwLegenda(cCadastro,"Usuarios" ,aLegenZk)

return


/*------------------------------------------------------------------------
| Funcao    | RetNomUsr | Otavio Pinto                 | Data | 05/03/15  |
|-------------------------------------------------------------------------|
| Descricao | Rotina para retornar o login do usuário no Protheus.        |
|           |                                                             |
|           |                                                             |
+------------------------------------------------------------------------*/
user function RetNomUsr( __cID )
local cAlias  := Alias()
local cSavOrd := IndexOrd()
local cLogin  := Space(15)

PswOrder(1)
if PswSeek( __cID )
   cLogin := PswRet(1)[1][2]
endIf

dbSelectArea(cAlias)
dbSetOrder(cSavOrd)

return cLogin



// Fim da Rotina CABA570.prw
