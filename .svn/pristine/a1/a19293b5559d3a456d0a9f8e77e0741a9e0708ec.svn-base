#INCLUDE "PROTHEUS.CH"
#INCLUDE "UTILIDADES.CH"
/*************************************************************************************************************
* Programa....: CABV016    																				      *
* Tipo........: Validação de campos no cadastro de Usuários.                                                  *
* Autor.......: Otavio Pinto                                                                                  *
* Criaçao.....: 14/01/2014                                                                                    *
* Modificado..: Otavio Pinto                                                                                  *
* Alteração...:                                                                                               *	
* Solicitante.:                                                                                               *
* Módulo......: PLS - Plano de Saude                                                                          *
* Chamada.....:                                                                                               *
* Objetivo....: Validação dos campos BA1_MATVID, BA1_CODPLA e BA1_DATINC.                                     *
 *************************************************************************************************************/
user function CABV016
local cCodUsr	 := RetCodUsr()
return ( cCodUsr $ SuperGetMv('MV_YPERCAD') .or. cCodUsr $ SuperGetMv('MV_XGETIN')  )