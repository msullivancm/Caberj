#INCLUDE "rwmake.ch"
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³LP5307     º Autor ³ AP6 IDE            º Data ³  24/08/05  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ LESCAUT                                                    º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP6 IDE                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
// De / Para das Conta Contábeis 19/09/07
User Function LP5307

PRIVATE cconta:=""

IF ALLTRIM(SE2->E2_NATUREZ)=="41127" .OR. ALLTRIM(SE2->E2_NATUREZ)=="41172"
	cconta:="411111041"
ELSEIF ALLTRIM(SE2->E2_NATUREZ)=="41128"
	cconta:="411111031"
ELSEIF ALLTRIM(SE2->E2_NATUREZ)=="41129"
	cconta:="411111041"
ELSEIF ALLTRIM(SE2->E2_NATUREZ)=="41130"
	cconta:="411111041"
ELSEIF ALLTRIM(SE2->E2_NATUREZ)=="41131"
	cconta:="411111041"
ELSEIF ALLTRIM(SE2->E2_NATUREZ)=="41132"
	cconta:="411111041" 
ELSEIF ALLTRIM(SE2->E2_NATUREZ)=="41133"
	cconta:="411111041"
ELSEIF ALLTRIM(SE2->E2_NATUREZ)=="41134"
	cconta:="411111041"
ELSEIF ALLTRIM(SE2->E2_NATUREZ)=="41135"
	cconta:="411111041" 
ELSEIF ALLTRIM(SE2->E2_NATUREZ)=="41136"
	cconta:="411111041" 
ELSEIF ALLTRIM(SE2->E2_NATUREZ)=="41137"
	cconta:="411111041"
ELSEIF ALLTRIM(SE2->E2_NATUREZ)=="41138"
	cconta:="411111041"  
ELSEIF ALLTRIM(SE2->E2_NATUREZ)=="41139"
	cconta:="411111041"
ELSE
	cconta:='311911031' 
ENDIF

Return cconta
