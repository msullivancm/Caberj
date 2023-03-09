#Include "PROTHEUS.CH"
#Include "TOPCONN.CH"
#include "tbiconn.ch"
#Include "RWMAKE.CH"
#include 'TOTVS.CH'


User Function ValidPref(cPref)

	Local lValid := .F.
	Local aArea := GETAREA()

	dbSelectArea("ZUO")
	dbSetOrder(1)
//Alltrim(FunName())
//	lValid := !Empty(POSICIONE("ZUO",1,XFILIAL("ZUO")+AllTrim(cPref),"ZUO_PREF"))

	 lValid := !Empty(POSICIONE("ZUO",1,XFILIAL("ZUO")+Alltrim(FunName())+AllTrim(cPref),"ZUO_PREF"))
	If(!lValid) 
	   alert("Programa : "+ Alltrim(FunName()) + " - Prefixo : "+cPref+" "+CRLF+" O Progama para este PREFIXO Não e Válida." +CRLF+CRLF+ "  Favor "+CRLF+"Verificar o Prefixo ou "+CRLF+" Entra Em Contactar Com o Dept. Financeiro")
	Endif
	
	RESTAREA(aArea)
	
Return lValid
/* X3Valid */