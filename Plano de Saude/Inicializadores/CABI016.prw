#INCLUDE "RWMAKE.CH"
#INCLUDE "TOPCONN.CH"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "TBICONN.CH"

#DEFINE cEnt Chr(13)+Chr(10)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABI016   ºAutor  ³Angelo Henrique     º Data ³  03/10/18   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Usado para inicializar da BD6 e BD7 para dizer se o         º±±
±±º          ³procedimento é PMC ou PFB                                   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³CABERJ                                                      º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function CABI016()
	
	Local _aArea 		:= GetArea()
	Local _aArBD6 		:= BD6->(GetArea())
	Local _aArBD7 		:= BD7->(GetArea())
	Local _aArBD4 		:= BD4->(GetArea())
	Local _cRet			:= ""
	Local _cQuery 		:= ""
	
	Private cAliQry1  	:= GetNextAlias()
	
	_cQuery := " SELECT 															" + cEnt
	_cQuery += "     DECODE(TRIM(BD4.BD4_XTPREC),'1','PMC','2','PFB',' ') XTPREC    " + cEnt	
	_cQuery += "  FROM 																" + cEnt
	_cQuery += "      																" + cEnt
	_cQuery += "     " + RetSqlName("BD6")+ " BD6									" + cEnt
	_cQuery += "                                                    				" + cEnt
	_cQuery += "      INNER JOIN  													" + cEnt
	_cQuery += "     " + RetSqlName("BD4")+ " BD4									" + cEnt
	_cQuery += "      ON 															" + cEnt
	_cQuery += "      	BD4.BD4_FILIAL = '" + xFilial("BD4") + "'   				" + cEnt
	_cQuery += "         AND BD4.BD4_CODPRO  = BD6.BD6_CODPRO						" + cEnt
	_cQuery += "         AND BD4.BD4_CDPADP  = BD6.BD6_CODPAD						" + cEnt
	_cQuery += "         AND BD4.BD4_VIGINI  <> ' '									" + cEnt
	_cQuery += "         AND BD4.BD4_VIGINI  <= BD6.BD6_DATPRO						" + cEnt
	_cQuery += "         AND														" + cEnt
	_cQuery += "         	(														" + cEnt
	_cQuery += "         		BD4.BD4_VIGFIM  >= BD6.BD6_DATPRO					" + cEnt
	_cQuery += "         		OR													" + cEnt
	_cQuery += "          		BD4.BD4_VIGFIM = ' '								" + cEnt
	_cQuery += "          	)														" + cEnt
	_cQuery += "         AND BD4.D_E_L_E_T_  = ' '									" + cEnt
	_cQuery += "         AND BD4.BD4_CDPADP = BD6.BD6_CODPAD        				" + cEnt
	_cQuery += "          															" + cEnt
	_cQuery += "  WHERE																" + cEnt
	_cQuery += "          															" + cEnt
	_cQuery += "     BD6.D_E_L_E_T_      = ' '										" + cEnt
	_cQuery += "     AND BD6.BD6_FILIAL  = '" + xFilial("BD6")  + "'				" + cEnt
	_cQuery += "     AND BD6.BD6_CODOPE  = '" + BD6->BD6_CODOPE + "'				" + cEnt
	_cQuery += "     AND BD6.BD6_CODLDP  = '" + BD6->BD6_CODLDP + "'				" + cEnt
	_cQuery += "     AND BD6.BD6_CODPEG  = '" + BD6->BD6_CODPEG + "'				" + cEnt
	_cQuery += "     AND BD6.BD6_NUMERO  = '" + BD6->BD6_NUMERO + "'				" + cEnt
	_cQuery += "     AND BD6.BD6_ORIMOV  = '" + BD6->BD6_ORIMOV + "'				" + cEnt
	_cQuery += "     AND BD6.BD6_SEQUEN  = '" + BD6->BD6_SEQUEN + "'				" + cEnt
	
	If Select(cAliQry1)>0
		(cAliQry1)->(DbCloseArea())
	EndIf
	
	DbUseArea(.T.,"TopConn",TcGenQry(,,_cQuery),cAliQry1,.T.,.T.)
	
	DbSelectArea(cAliQry1)
	
	If !((cAliQry1)->(Eof()))
		
		_cRet := (cAliQry1)->XTPREC
		
	EndIf
	
	If Select(cAliQry1)>0
		(cAliQry1)->(DbCloseArea())
	EndIf
	
	RestArea(_aArBD4)
	RestArea(_aArBD7)
	RestArea(_aArBD6)
	RestArea(_aArea	)
	
Return _cRet

