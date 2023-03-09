#INCLUDE "PROTHEUS.CH"
#Include "topconn.ch"  
#Include "FWBROWSE.CH"
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³SCH004  ºAutor  ³Marcos 7Consulting  º Data ³   02/02/23    º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Schedule para campos da BE4 para internação				  º±±
±±º          ³ vinda do HAT						                          º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

USER FUNCTION SCH004(aJob)

local cCodEmp	:= aJob[1]
local cCodFil	:= aJob[2]


RpcSetEnv( cCodEmp, cCodFil , , ,'PLS', , )

FWLogMsg('WARN',, 'SIGAPLS', funName(), '', '01', "Execução da Tarefa de atualização de campos na BE4." , 0, 0, {})

CABABE4()

FWLogMsg('WARN',, 'SIGAPLS', funName(), '', '01', "Execução Finalizada do JOB CABABE4!" , 0, 0, {})
 
Return()

/*/{Protheus.doc} CABABE4
@author Marcos 7Consulting
@since 02/02/2023
/*/

Static Function CABABE4()

local cSql		:= ""
local cAliBE4	:= RetSqlName("BE4")
local cFilBE4	:= xFilial("BE4")
local cCodOpe	:= PlsIntPad()
local cSql2		:= ""
local nRet		:= 0
Private cAliasBOL  := GetnextAlias()

	cSql := " SELECT DISTINCT BE4.R_E_C_N_O_ REC, BE4_DTDIGI DTDIGIT	   	"
	cSql += " FROM " + cAliBE4 + " BE4			 							"
	cSql += " WHERE BE4_FILIAL = '" + cFilBE4 + "' 							"
	cSql += "   AND BE4_CODOPE = '" + cCodOpe + "' 							"
	cSql += "   AND BE4_ORIMOV   = '6' 										"
	cSql += "   AND BE4_SITUAC = '1' 										"
	cSql += "   AND BE4_YDTSOL = ' '		 								"
	cSql += "   AND BE4_YOPME = ' '		 									"
	cSql += "   AND BE4_YATOPM = ' '		 								"
	cSql += "   AND BE4_YPOPME = ' '		 								"
	cSql += "   AND BE4_XORIG = ' '			 								"
	cSql += "   AND BE4_XENT = ' '			 								"
	cSql += "   AND BE4_YSOPME = ' '		 								"
	cSql += "   AND BE4_XDTPR = ' '		 									"
	cSql += "   AND BE4.D_E_L_E_T_ = ' ' 									"
		
	cSql := ChangeQuery(cSql)
	dbUseArea(.T.,"TOPCONN",TcGenQry(,,cSql),cAliasBOL,.T.,.T.)

	dbSelectArea(cAliasBOL)
	(cAliasBOL)->(dbgotop())		

	If (cAliasBOL)->(Eof())
		RETURN
	Else
		While  !(cAliasBOL)->(Eof())    

			cSql2 := " UPDATE " + cAliBE4 
			cSql2 += " SET BE4_YDTSOL = BE4_DTDIGI, BE4_YOPME = '1',				 "
			cSql2 += " BE4_YATOPM = '2', BE4_YPOPME = '0',							 "
			cSql2 += " BE4_XORIG ='4', BE4_XENT = '1', BE4_YSOPME = '1',			 "
			cSql2 += " BE4_XDTPR = '"+DTOS(DaySum(STOD((cAliasBOL)->DTDIGIT),12))+"' "
			cSql2 += " WHERE 														 " 
			cSql2 += " BE4_FILIAL = '" + cFilBE4 + "' AND 							 "
			cSql2 += " R_E_C_N_O_ = '"+cvaltochar((cAliasBOL)->REC)+"' 							 "
		
			nRet := TCSqlExec(cSql2)

			if nRet < 0
				FWLogMsg('WARN',, 'SIGAPLS', 'CABABE4', '', '01','Erro na query de atualização:' + TCSQLError() , 0, 0, {})
			endif
			
			(cAliasBOL)->(DbSkip())
		END
	ENDIF

	(cAliasBOL)->(DbCloseArea())

Return
