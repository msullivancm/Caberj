#include "PROTHEUS.CH"
//#INCLUDE "plsmfun.ch"
/*
 +---------------------------------------------------------------------------------+
 | Programa  | PLSVLDHR   | Autor | Otavio Salvador        |  Data |  30/07/2012   |
 +---------------------------------------------------------------------------------+
 | Desc.     | Ponto de Entrada para validar Hora / Minuto                         |
 |           | Validação de Usuários                                               |
 +---------------------------------------------------------------------------------+ 
 | Uso       |  Critica nos campos SZX->ZX_HORADE e SZX->ZX_HORATE                 | 
 |           |                     SZY->ZY_HORASV                                  | 
 +---------------------------------------------------------------------------------+
*/
user function PLSVLDHR
local lRet  := .T.  
local cHora := paramixb[1]
IF FUNNAME() <> "RDMBA"    // em 09.08.2012 - OSP
   lRet  := .F.                                        
   if ( Subs(cHora,1,2) >= "00" .And. Subs(cHora,1,2) <= "23" ) .And. ;
      ( Subs(cHora,3,2) >= "00" .And. Subs(cHora,3,2) <= "59" )
      lRet := .T.
   else
      Help("",1,"PLSVLDHOR")
   endif                    
ENDIF   
Return (lRet)

// Fim da rotina PLSVLDHR.PRW
