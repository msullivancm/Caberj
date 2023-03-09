#INCLUDE "rwmake.ch"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  F370E1W     º Autor ³ Mauro Guerra      º Data ³  22/02/13   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Codigo gerado pelo AP6 IDE.                                º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP6 IDE                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

User Function F370E1W
/*
			If lF370E1WH
				cCondWhile:= Execblock("F370E1W",.F.,.F.)
			Else
				cCondWhile:= "'"+cFilial+"' == SE1->E1_FILIAL .And. ( SE1->E1_EMISSAO >= mv_par04	.And. SE1->E1_EMISSAO <= mv_par05 )"
				If mv_par14 == 1 .and. !Empty( SE1->( FieldPos( "E1_MSFIL"   ) ) )
					cFor := "E1_MSFIL >= mv_par15 .and. E1_MSFIL <= mv_par16"
				Else
					cFor := ".T."   
//
E1_MESBASE
E1_ANOBASE					


*/        
//
//cRet	:= 	"'"+cFilial+"' == SE1->E1_FILIAL .And. ( SE1->E1_EMISSAO >= mv_par04	.And. SE1->E1_EMISSAO <= mv_par05 )"
cRet	:= 	"'"+cFilial+"' == SE1->E1_FILIAL .And. ( SE1->(E1_ANOBASE+E1_MESBASE) >= substr(dtos(MV_PAR04),1,6)	.And. SE1->(E1_ANOBASE+E1_MESBASE) <=  substr(dtos(MV_PAR04),1,6) )"
//



Return(cRet)
