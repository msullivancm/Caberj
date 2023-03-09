#INCLUDE "TOTVS.CH"      
/************************************************************************/
/* Ponto de entra que inibe o bota visualizar da consulta padrao        */
/************************************************************************/
User Function CPDBtnVis()
Local lRet 		 := .T.       
Local cCons 	 := PARAMIXB[1]
// Local cAliasCons := PARAMIXB[2]
// Se for o Administrador e o nome da consulta for SA1 ou a tabela principal da consulta for SA1, inibe a opção Visualizar.
//If __cUserID == "000000" .And. (cCons == "SA1" .Or. cAliasCons == "SA1")	 
If cCons == "SRAJUR" 	
   lRet := .F.
EndIf
Return lRet
