#include "rwmake.ch"
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³FA340FILT º Autor ³Jose Carlos Noronha º Data ³  31/07/2007 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Filtrar Titulos Bloqueados no Contas a Pagar Gerados no PLSº±±
±±º          ³ na Rotina Compensacao de Titulos.(FINA340)                 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Caberj                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function FA340FILT()
Local lRet := .T.        
LOCAL _nRecnoE2_		:= paramixb[1]  
// "N" - Titulos Bloqueados
// "S" - Titulos Liberados por NF
// "M" - Titulos Liberados Manualmente
// A2_YBLQPLS = "N" - Fornecedor Sem Bloqueio       
If !FunName() == "FINA340"    
   lRet := (SE2->E2_YLIBPLS $ "S|M") .or. (!Substr(E2_ORIGEM,1,3) $ "PLS") .or. (POSICIONE("SA2",1,xFilial("SA2")+SE2->E2_FORNECE+SE2->E2_LOJA,"A2_YBLQPLS") = "N") 
Else  
//DbSelectArea("SE2")
//DbGoto(_nRecnoE2_)
   lRet := (E2_YLIBPLS $ "S|M") .or. (!Substr(E2_ORIGEM,1,3) $ "PLS") .or. (POSICIONE("SA2",1,xFilial("SA2")+E2_FORNECE+E2_LOJA,"A2_YBLQPLS") = "N")
//dbclosearea()
EndIf
Return(lRet) 
