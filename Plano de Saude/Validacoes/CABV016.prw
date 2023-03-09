#INCLUDE "PROTHEUS.CH"
#INCLUDE "UTILIDADES.CH"
/*************************************************************************************************************
* Programa....: CABV016    																				      *
* Tipo........: Valida��o de campos no cadastro de Usu�rios.                                                  *
* Autor.......: Otavio Pinto                                                                                  *
* Cria�ao.....: 14/01/2014                                                                                    *
* Modificado..: Otavio Pinto                                                                                  *
* Altera��o...:                                                                                               *	
* Solicitante.:                                                                                               *
* M�dulo......: PLS - Plano de Saude                                                                          *
* Chamada.....:                                                                                               *
* Objetivo....: Valida��o dos campos BA1_MATVID, BA1_CODPLA e BA1_DATINC.                                     *
 *************************************************************************************************************/
user function CABV016
local cCodUsr	 := RetCodUsr()
return ( cCodUsr $ SuperGetMv('MV_YPERCAD') .or. cCodUsr $ SuperGetMv('MV_XGETIN')  )