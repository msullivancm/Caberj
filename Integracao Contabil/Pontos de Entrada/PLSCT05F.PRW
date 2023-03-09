
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³PLSCT05F  ºAutor  ³Roger Cangianeli    º Data ³  20/04/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Ponto de entrada para mudanca no filtro do programa de con- º±±
±±º          ³tabilizacao de guias (PLSCTB05).                            º±±
±±º          ³                                                            º±±
±±º          ³ ATENCAO                                                    º±±
±±º          ³ Deve ser coerente com o ponto de entrada PLS103CG.         º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Unimed's                                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function PLSCT05F
local 	cSql

If PlsIntPad() == '0055'
	cSql	:= " ( BD6_YANOCT >='"+ cAnoPag +"' AND BD6_YMESCT >='"+ cMesPag +"' AND " 
	cSql	+= "   BD6_YANOCT <='"+ cAnoPag +"' AND BD6_YMESCT <='"+ cMesPag +"') " 
Else
	cSql	:= " ( (SUBSTRING(BD6_NUMLOT,1,4)='"+ cAnoPag +"' AND SUBSTRING(BD6_NUMLOT,5,2)='"+ cMesPag +"') " 
	cSql	+= " OR (BD6_ANOPAG='"+ cAnoPag +"'AND BD6_MESPAG='"+ cMesPag +"' AND BD6_NUMLOT=' ') ) "
EndIf
//cSql	:= ChangeQuery(cSql) - Removido, não pode ser utilizado. RC - 06/01/08

return(cSql)