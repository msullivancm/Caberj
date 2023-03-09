#INCLUDE "rwmake.ch"

/*/
----------------------------------------------------------------------------
Programa  FA050CSL()º Autor ³ Erika Schmitz      º Data ³  27/04/05   
----------------------------------------------------------------------------
Descricao  Ponto de entrada para atualização dos campos ítem contábil, 
           centros de custos e históricos nos títulos de CSLL gerados 
           automaticamente. 
----------------------------------------------------------------------------
//
//	Alteracao:	31/01/13	- Vitor Sbano	- Gravacao de Campo de Data Liberacao (E2_DATALIB) para registros não originados no PLS
//
//
/*/

User Function F050CSL()
PRIVATE nRegistro, aArea, cItemConta, cCentroCusto, cHistorico

aArea := getarea()

DbSelectArea("SE2")
nRegistro := PARAMIXB
DBGOTO(nRegistro) 

cItemConta   := SE2->E2_ITEMD
cCentroCusto := SE2->E2_CCD 
cHistorico   := SE2->E2_HIST

restarea(aArea)

Reclock("SE2", .F.)
   SE2->E2_ITEMD := cItemConta
   SE2->E2_CCD   := cCentroCusto   
   SE2->E2_HIST  := cHistorico
   SE2->E2_CODRET := '5987' 
   //
   SE2->E2_DATALIB	:=	dDATABASE			&& Inclusao 31/01/13 - Vitor Sbano - Implementacao de Bloqueio - Financeiro (fase 3 1/2)
   //
MsUnlock()   

Return
