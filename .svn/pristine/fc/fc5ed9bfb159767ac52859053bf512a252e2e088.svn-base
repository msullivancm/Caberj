#Include 'Protheus.ch'
#Include "topconn.ch"  
#Include "FWBROWSE.CH"
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณSCH003  บAutor  ณMarcos 7Consulting  บ Data ณ   23/11/22    บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Schedule para atualizar o status tiss, pois o PLJBATUTISS  บฑฑ
ฑฑบ          ณ padrใo TOTVS nใo estแ funcionando                          บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

USER FUNCTION SCH003(aJob)

local cCodEmp	:= aJob[1]
local cCodFil	:= aJob[2]

RpcSetEnv( cCodEmp, cCodFil , , ,'PLS', , )

FWLogMsg('WARN',, 'SIGAPLS', funName(), '', '01', "Execu็ใo da Tarefa de atualiza็ใo de status TISS na BCI." , 0, 0, {})

CABASTTISS()

FWLogMsg('WARN',, 'SIGAPLS', funName(), '', '01', "Execu็ใo Finalizada do JOB CABASTTISS!" , 0, 0, {})
 
Return()

/*/{Protheus.doc} CABASTTISS
@description Rotina para atualizar o campo BCI_STTISS via query e schedule, jแ que temos vแrias formas de baixar um tํtulo no back-office, que nใo comunica tal baixa ao PLS. 
@author Marcos 7Consulting
@since 11/2022
@Obs: Como a query busca os pagamentos efetuados, precisamos checar na BCI as PEG Faturadas (4) e com Status TISS como Liberado para pagamento (3).
/*/
Static Function CABASTTISS()

local cSql		:= ""
local cAliBCI	:= RetSqlName("BCI")
local cFilBCI	:= xFilial("BCI")
local cCodOpe	:= PlsIntPad()
local cSql2	:= ""

local lAtuSt	:= getNewPar("MV_STATISS",.f.)

local nRet		:= 0

//A fun็ใo s๓ ira ser executada caso a Operadora opte em utilizar o status TISS.
if lAtuSt
	
		cSql := " SELECT DISTINCT BCI.R_E_C_N_O_ REC FROM " + cAliBCI + " BCI "
		cSql += " WHERE BCI_FILIAL = '" + cFilBCI + "' "
		cSql += "   AND BCI_CODOPE = '" + cCodOpe + "' "
		cSql += "   AND BCI_FASE   = '4' "
		cSql += "   AND BCI_USRLIB <> ' ' "
		cSql += "   AND BCI_STTISS = '3' "
		cSql += "   AND BCI.D_E_L_E_T_ = ' ' "
		
		cSql := ChangeQuery(cSql)
		
		cSql2 += " UPDATE " + cAliBCI 
		cSql2 += " SET BCI_STTISS = '6' "
		cSql2 += " WHERE " 
		cSql2 += " BCI_FILIAL = '" + cFilBCI + "' AND "
		cSql2 += " R_E_C_N_O_ IN ( " + cSql + ") "
		
		nRet := TCSqlExec(cSql2)

		if nRet < 0
			FWLogMsg('WARN',, 'SIGAPLS', 'CABASTTISS', '', '01','Erro na query de atualiza็ใo:' + TCSQLError() , 0, 0, {})
		endif
		cSql	:= ""
		cSql2 	:= ""

		// atualiza status para "liberado para pagamento" em guias com usuario de libera็ใo

		cSql := " SELECT DISTINCT BCI.R_E_C_N_O_ REC FROM " + cAliBCI + " BCI "
		cSql += " WHERE BCI_FILIAL = '" + cFilBCI + "' "
		cSql += "   AND BCI_CODOPE = '" + cCodOpe + "' "
		cSql += "   AND BCI_USRLIB <> ' ' "
		cSql += "   AND BCI_STTISS = '2' "
		cSql += "   AND BCI.D_E_L_E_T_ = ' ' "
		
		cSql := ChangeQuery(cSql)
		
		cSql2 += " UPDATE " + cAliBCI 
		cSql2 += " SET BCI_STTISS = '3' "
		cSql2 += " WHERE " 
		cSql2 += " BCI_FILIAL = '" + cFilBCI + "' AND "
		cSql2 += " R_E_C_N_O_ IN ( " + cSql + ") "
		
		nRet := TCSqlExec(cSql2)

		if nRet < 0
			FWLogMsg('WARN',, 'SIGAPLS', 'CABASTTISS', '', '02','Erro na query de atualiza็ใo:' + TCSQLError() , 0, 0, {})
		endif
		cSql	:= ""
		cSql2 	:= ""
		
endif


Return
