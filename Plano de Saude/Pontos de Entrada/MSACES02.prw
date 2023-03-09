#INCLUDE "rwmake.ch"
#INCLUDE "protheus.ch"
#INCLUDE "TopConn.ch"
#include "TBICONN.CH"    
/*
±±ºPrograma  ³MSACES02     ºAutor  ³  Motta             º Data ³ dez/21      º±± 
CHAMADO PELA ws_login_beneficiario MobileSaude
*/
User Function MSACES02()   

  LOCAL aRet := {}
      
  If BA3->BA3_CODEMP == "0004" 
   aRet := {.f., ""}
  Else
   aRet := {.t., ""}
  Endif

Return aRet