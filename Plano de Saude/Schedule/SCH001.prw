#include 'protheus.ch'
#include "rwmake.ch"
#include "topconn.ch"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ SCH001   บAuthor ณ Fred O. C. Jr      บ Date ณ  28/06/21   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ  Criar vinculo entre tabela de terminologia e padrใo		  บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUse       ณ                                                            บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function SCH001(aParSched)

Local aArea			:= GetArea()
Local nH			:= 0
Local cQuery		:= ""
Local cAliasQry

RpcSetType(3)
RpcSetEnv(aParSched[1], aParSched[2],,,'PLS',,)

nH := PLSAbreSem("SCH001.SMF", .F.)
if nH == 0
	RpcClearEnv()
	return()
endif

cQuery := " select BTQ.R_E_C_N_O_ as BTQREC, BR8.R_E_C_N_O_ as BR8REC"
cQuery += " from " + RetSqlName("BTQ") + " BTQ"
cQuery +=	" inner join " + RetSqlName("BTU") + " BTU"
cQuery +=		" on (    BTU_FILIAL = BTQ_FILIAL"
cQuery +=			" and BTU_CODTAB = '87'"
cQuery +=			" and BTU_ALIAS  = 'BR4'"
cQuery +=			" and BTU_CDTERM = BTQ_CODTAB)"
cQuery +=	" inner join " + RetSqlName("BR8") + " BR8"
cQuery +=		" on (    BR8_FILIAL = BTQ_FILIAL"
cQuery +=			" and BR8_CODPAD = BTU_VLRBUS"
cQuery +=			" and BR8_CODPSA = BTQ_CDTERM)"
cQuery +=	" inner join ( select BR4_CODPAD, sum(BR4_DIGITO) as BR4_TAMANHO"
cQuery +=				 " from " + RetSqlName("BR4") + " BR4"
cQuery +=				 " where BR4.D_E_L_E_T_ = ' '"
cQuery +=				 " group by BR4_CODPAD ) TBR4"
cQuery +=		" on (TBR4.BR4_CODPAD = BR8_CODPAD)"
cQuery += " where BTQ.D_E_L_E_T_ = ' ' and BTU.D_E_L_E_T_ = ' ' and BR8.D_E_L_E_T_ = ' '"
cQuery += 	" and BTQ_FILIAL = '" + xFilial("BTQ") + "'"

cQuery += 	" and BR8_PROBLO <> '1'"
cQuery += 	" and BR8_BENUTL = '1'"
cQuery += 	" and length(trim(BR8_CODPSA)) = BR4_TAMANHO"

cQuery +=	" and not exists (select BTU_FILIAL"
cQuery +=					" from " + RetSqlName("BTU") + " BTU"
cQuery +=					" where BTU.D_E_L_E_T_ = ' '"
cQuery +=						" and BTU_FILIAL = BTQ_FILIAL"
cQuery +=						" and BTU_CODTAB = BTQ_CODTAB"
cQuery +=						" and BTU_ALIAS  = 'BR8'"
cQuery +=						" and BTU_CDTERM = BTQ_CDTERM)"
cQuery += " order by BTQ_CODTAB, BTQ_CDTERM"

cAliasQry := MpSysOpenQuery(cQuery)

DbSelectArea( cAliasQry )
while !(cAliasQry)->(Eof())

	BTQ->(DbSetOrder(1))
	BTQ->(DbGoTo( (cAliasQry)->BTQREC ))
	
	BR8->(DbSetOrder(1))
	BR8->(DbGoTo( (cAliasQry)->BR8REC ))
	
	if AllTrim(BTQ->BTQ_CDTERM) == AllTrim(BR8->BR8_CODPSA)
	
		Begin Transaction
		
			// marcar que possui vinculo na BTQ
			BTQ->(RecLock("BTQ", .F. ))
				BTQ->BTQ_HASVIN := '1'
			BTQ->(MsUnLock())

            BTU->(DbSetOrder(2))	// BTU_FILIAL+BTU_CODTAB+BTU_ALIAS+BTU_VLRSIS
		    if !BTU->(DbSeek( xFilial("BTU") + BTQ->BTQ_CODTAB + "BR8" + xFilial("BR8") + xFilial("BR8") + BR8->(BR8_CODPAD+BR8_CODPSA) ))
			
                // criar o vinculo
                Reclock("BTU", .T.)
                    BTU->BTU_FILIAL	:= xFilial("BTU")
                    BTU->BTU_CODTAB	:= BTQ->BTQ_CODTAB
                    BTU->BTU_VLRSIS	:= xFilial("BR8") + BR8->(BR8_CODPAD+BR8_CODPSA)
                    BTU->BTU_VLRBUS	:= BR8->BR8_CODPSA
                    BTU->BTU_CDTERM	:= BTQ->BTQ_CDTERM
                    BTU->BTU_ALIAS	:= "BR8"
                BTU->(MsUnlock())
            
            endif
		
		End Transaction
		
	endif
	
	(cAliasQry)->(DbSkip())
end
dbselectarea(cAliasQry)
(cAliasQry)->(dbclosearea())

PLSFechaSem(nH, "SCH001.SMF")

RpcClearEnv()

RestArea(aArea)

return
