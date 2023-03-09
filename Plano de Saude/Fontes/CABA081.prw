#Include 'RWMAKE.CH'
#Include 'PLSMGER.CH'
#INCLUDE "Protheus.ch"     
#Include "Colors.Ch"
#Include "TOPCONN.CH"

/*--------------------------------------------------------------------------
| Programa  | CABA081  | Autor | Otavio Pinto         | Data |  21/06/2013  |
|---------------------------------------------------------------------------|
| Descricao | Medico Assistente nao NUPRE                                   |
|           |                                                               |
|---------------------------------------------------------------------------|
| Uso       | Projeto Qualidade de Vida                                     | 
 --------------------------------------------------------------------------*/
user function CABA081( _cMatricula )
local cSql 		:= ""   

/*--------------------------------------------------------------------------
| Declaracao de Variaveis                                                   |
 --------------------------------------------------------------------------*/
private aRotina   	:=	{	{ "Pesquisar"   , 'AxPesqui'   , 0 , K_Pesquisar  },;
                            { "Visualizar"  , 'AxVisual'   , 0 , K_Visualizar },;
                            { "Inclur"      , 'AxInclui'   , 0 , K_Incluir    },;
                            { "Alterar"     , 'AxAltera'   , 0 , K_Alterar    },;
                            { "Legenda"     , 'u_PLSLEG2'  , 0 , K_Incluir    } }

private cCadastro   := "Medico Assistente nao NUPRE"
                        
private aCores      := { { " Empty((cAlias)->ZUG_DTVLD) .OR.  (DTOS(dDataBase) < DTOS((cAlias)->ZUG_DTVLD) )" ,'BR_VERDE'    },;
                         { "!Empty((cAlias)->ZUG_DTVLD) .AND. (DTOS(dDataBase) >= DTOS((cAlias)->ZUG_DTVLD) )",'BR_VERMELHO' } }  

private cPath     := ""
private cAlias    := "ZUG"
private _aArea    := GetArea()

*cSQL := " SELECT * "
*cSQL += " FROM " + RetSQLName("ZUG") + " ZUG " 
*cSQL += " WHERE  ZUG_MATRIC =  '" + M->BTH_CODPAC + "' "
*cSQL += " AND    D_E_L_E_T_ = ' ' " 
	

*PlsQuery(cSQL ,cAlias)            
//TcQuery cSQL New Alias cAlias

(cAlias)->( dbGoTop() )
	
if (cAlias)->( !EOF() )     
            
   (cAlias)->( DBSetOrder(1) )
   (cAlias)->( mBrowse(,,,,cAlias ,,,,,,aCores,,,,, .T. ))   

   //--------- Para reapresentar o aBrowse2 atualizado.
   aBrowse2 := {}    
   (cAlias)->( DbGoTop() )       
   while (cAlias)->( !EOF() )
       if (cAlias)->ZUG_MATRIC = _cMatricula 
          aAdd(aBrowse2,{(cAlias)->ZUG_MATRIC , (cAlias)->ZUG_USUARI , (cAlias)->ZUG_CDESP , (cAlias)->ZUG_DSESP , (cAlias)->ZUG_NUMCR , (cAlias)->ZUG_ESTADO ,  (cAlias)->ZUG_NOME})
       endif       
       (cAlias)->( dbskip() )
   enddo

   (cAlias)->( DbClearFilter() )
else
   msgstop("Matricula nao encontrada...")   
endif   

(cAlias)->( dbCloseArea() ) 

RestArea(_aArea)

return


/*------------------------------------------------------------------------
| Funcao    | PLSLEG2   | Otavio Pinto                 | Data | 05/07/13  |
+-------------------------------------------------------------------------+
| Descricao | PLSLEG2                                                     |
+-------------------------------------------------------------------------+
| Uso       |                                                             |
+-------------------------------------------------------------------------+
| Alterado  |                                          | Data |   /  /    |
|           |                                                             |
|           |                                                             |
+------------------------------------------------------------------------*/
user function PLSLEG2 

BrwLegenda(cCadastro, "Legenda", { { 'BR_VERDE'   ,'Ativo'    },;
                                   { 'BR_VERMELHO','Bloqueado'} } )
return


/*------------------------------------------------------------------------
| Funcao    | VLDTZUG   | Otavio Pinto                 | Data | 05/07/13  |
+-------------------------------------------------------------------------+
| Descricao | Valida o campo tornando-o nao editavel.                     |
+-------------------------------------------------------------------------+
| Uso       |                                                             |
+-------------------------------------------------------------------------+
| Alterado  |                                          | Data |   /  /    |
|           |                                                             |
|           |                                                             |
+------------------------------------------------------------------------*/
user function VLDTZUG
local lRet := .T.

if !Empty((cAlias)->ZUG_DTVLD) .AND. (DTOS(dDataBase) >= DTOS((cAlias)->ZUG_DTVLD) )
   lRet := .F.
endif   

return lRet


// Fim do Programa CABA081.PRW

