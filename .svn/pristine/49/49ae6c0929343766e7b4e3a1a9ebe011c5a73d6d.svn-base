#INCLUDE "TOTVS.CH"
#Include "TOPCONN.CH"
#Include "RWMAKE.CH"

/* ============================================================ *
 * Programa   : Autor         : Data                            *
 * MT103IPC   : Luis Madureira: 27/11/2019                      *
 * Atualiza o campo customizado histórico do doc de entrada com *
 * base no campo observação do pedido de compras.               *
 * Parametro  : PARAMIBX[1] - array - linha do ped. compras     *
 * Retorno    : lRet  - l - Lógico                              *
 * ============================================================ */

User Function MT103IPC()
	
	Local lRet 		 := .F.
	Local nLinha     := PARAMIXB[1]
	Local nPosD1Hist := aScan(aHeader,{|x| Alltrim(x[2]) == "D1_HIST"})

	aCols[nLinha, nPosD1Hist] := SC7->C7_OBS
	
Return lRet	
/* MT103IPC*/
