#INCLUDE "RWMAKE.CH"
#INCLUDE "TOPCONN.CH"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "TBICONN.CH"

#DEFINE cEnt Chr(13)+Chr(10)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABI017   ºAutor  ³Angelo Henrique     º Data ³  03/10/18   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Usado para inicializar da BD6 e BD7 para dizer se o         º±±
±±º          ³procedimento é PMC ou PFB                                   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³CABERJ                                                      º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function CABI017()
	
	Local _aArea 		:= GetArea()
	Local _aArBE4 		:= BE4->(GetArea())
	Local _cRet			:= ""
	Local _cQuery 		:= ""
	Local _cCodPad		:= ""
	Local _cCodPro		:= ""
	
	Private cAliQry1  	:= GetNextAlias()
	
	If B53->B53_TIPO = "2" //SADT
		_cCodPad 		:= BE2->BE2_CODPAD
		_cCodPro		:= BE2->BE2_CODPRO
		
	ElseIf B53->B53_TIPO = "3" //Internação
		
		//-----------------------------------------------------------------------------------
		//Necessário ponterar na internação e visualizar se possui prorrogação ou não
		//-----------------------------------------------------------------------------------
		DbSelectArea("BE4")
		DbSetOrder(2)
		If DbSeek(xFilial("BE4") + B53->B53_NUMGUI)
			
			If BE4->BE4_PRORRO = "1" //POSSUI PRORROGAÇÃO
				
				_cCodPad 		:= BQV->BQV_CODPAD
				_cCodPro		:= BQV->BQV_CODPRO
				
			Else
				
				_cCodPad 		:= BEJ->BEJ_CODPAD
				_cCodPro		:= BEJ->BEJ_CODPRO
								
			EndIf
			
		EndIf
		
	ElseIf B53->B53_TIPO = "5" //Reembolso
		
		_cCodPad 		:= B45->B45_CODPAD
		_cCodPro		:= B45->B45_CODPRO
		
	EndIf
	
	_cQuery := " SELECT                                                     " + cEnt
	_cQuery += "     B53.B53_RECMOV,                                        " + cEnt
	_cQuery += "     B53.B53_NUMGUI,                                        " + cEnt
	_cQuery += "     B53.B53_ALIMOV,                                        " + cEnt
	_cQuery += "     B53.B53_ORIMOV,                                        " + cEnt
	_cQuery += "     BE2.BE2_CODPRO,                                        " + cEnt
	_cQuery += " 	 CASE  													" + cEnt
	_cQuery += "	     WHEN BE2_QTDPRO = '0' THEN BE2_QTDSOL 				" + cEnt
	_cQuery += "	     ELSE BE2_QTDPRO 									" + cEnt
	_cQuery += "	 END QTDSOL 											" + cEnt	
	_cQuery += " FROM                                                       " + cEnt
	_cQuery += "	"	+ RetSqlName("B53")		+ " B53						" + cEnt
	_cQuery += "                                                            " + cEnt
	_cQuery += "     INNER JOIN                                             " + cEnt
	_cQuery += "	"	+ RetSqlName("BE2")		+ " BE2						" + cEnt
	_cQuery += "     ON                                                     " + cEnt
	_cQuery += "         BE2.BE2_FILIAL      = B53.B53_FILIAL 				" + cEnt
	_cQuery += "         AND BE2.BE2_OPEMOV  = SUBSTR(B53.B53_NUMGUI,1,4)	" + cEnt
	_cQuery += "         AND BE2.BE2_ANOAUT  = SUBSTR(B53.B53_NUMGUI,5,4)	" + cEnt
	_cQuery += "         AND BE2.BE2_MESAUT  = SUBSTR(B53.B53_NUMGUI,9,2)   " + cEnt
	_cQuery += "         AND BE2.BE2_NUMAUT  = SUBSTR(B53.B53_NUMGUI,11)    " + cEnt
	_cQuery += "         AND BE2.BE2_CODPAD  = '" + _cCodPad + "'  			" + cEnt
	_cQuery += "         AND BE2.BE2_CODPRO  = '" + _cCodPro + "'  			" + cEnt
	_cQuery += "         AND BE2.D_E_L_E_T_  = ' '                          " + cEnt
	_cQuery += "                                                            " + cEnt
	_cQuery += " WHERE                                                      " + cEnt
	_cQuery += "                                                            " + cEnt
	_cQuery += "     B53.B53_FILIAL = ' '                                   " + cEnt
	_cQuery += "     AND B53.B53_NUMGUI = '" + B53->B53_NUMGUI + "'         " + cEnt
	_cQuery += "     AND B53.B53_ORIMOV = '" + B53->B53_ORIMOV + "'         " + cEnt
	_cQuery += "     AND B53.B53_ALIMOV = '" + B53->B53_ALIMOV + "' 		" + cEnt
	_cQuery += "     AND B53.D_E_L_E_T_ = ' '                               " + cEnt
	
	If Select(cAliQry1)>0
		(cAliQry1)->(DbCloseArea())
	EndIf
	
	DbUseArea(.T.,"TopConn",TcGenQry(,,_cQuery),cAliQry1,.T.,.T.)
	
	DbSelectArea(cAliQry1)
	
	If !((cAliQry1)->(Eof()))
		
		_cRet := (cAliQry1)->QTDSOL
		
	EndIf
	
	If Select(cAliQry1)>0
		(cAliQry1)->(DbCloseArea())
	EndIf
	
	RestArea(_aArBE4)
	RestArea(_aArea	)
	
Return _cRet

