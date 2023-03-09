#INCLUDE "RWMAKE.CH"
#INCLUDE "TOPCONN.CH"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "TBICONN.CH"

#DEFINE cEnt Chr(13)+Chr(10)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABA084   ºAutor  ³Angelo Henrique     º Data ³  10/10/18   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Rotina utilizada para a schedule mo processo de RDA tabela  º±±
±±º          ³de preço x Especialidade da RDA                             º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³CABERJ                                                      º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function CABA084()
	
	Local _ni := 0
	
	Conout("CABA084 - Iniciando geração de RDA tabela de Preço x Especialidade da RDA")
	
	For _ni := 1 To 2
		
		If _ni = 1
			
			RpcSetType(3)
			
			If FindFunction("WfPrepEnv")
				
				WFPrepEnv("01","01", , , "PLS")
				
			Else
				
				PREPARE ENVIRONMENT EMPRESA "01" FILIAL "01"  MODULO "PLS"
				
			EndIf
			
			//----------------------------------------------------------------------------
			//Após logar na CABERJ, irá executar a rotina de geração de protocolo
			//----------------------------------------------------------------------------
			Conout("CABA084 - Executando CABA084A pela CABERJ")
			
			U_CABA084A()
			
		ElseIf _ni = 2
			
			RpcSetType(3)
			
			If FindFunction("WfPrepEnv")
				
				WFPrepEnv("02","01", , , "PLS")
				
			Else
				
				PREPARE ENVIRONMENT EMPRESA "02" FILIAL "01"  MODULO "PLS"
				
			EndIf
			
			//----------------------------------------------------------------------------
			//Após logar na INTEGRAL, irá executar a rotina de geração de protocolo
			//----------------------------------------------------------------------------
			Conout("CABA084 - Executando CABA084A pela INTEGRAL")
			U_CABA084A()
			
		EndIf
		
	Next _ni
	
	U_CABA084A()
	
	CONOUT("CABA084 - FIM Processo de geração de RDA tabela de Preço x Especialidade da RDA")
	
	
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABA084A  ºAutor  ³Angelo Henrique     º Data ³  10/10/18   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Rotina utilizada para a schedule mo processo de RDA tabela  º±±
±±º          ³de preço x Especialidade da RDA                             º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³CABERJ                                                      º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function CABA084A()
	
	Local _aArea 		:= GetArea()
	Local _aArBC0 		:= BC0->(GetArea())
	Local _aArBC6 		:= BC6->(GetArea())
	Local _cQuery		:= ""
	Local _cEmp			:= IIF(cEmpAnt == "01","C","I")
	
	Private _cAlias1	:= GetNextAlias()
	Private _cAlias2	:= GetNextAlias()
	
	_cQuery := " SELECT 																							" + cEnt
	_cQuery += "     BC6.BC6_CODRDA,                                                                    			" + cEnt
	_cQuery += "     BC6.BC6_CODINT,                                                                    			" + cEnt
	_cQuery += "     BB8.BB8_CODLOC,                                                                    			" + cEnt
	_cQuery += "     BAX.BAX_CODESP,                                                                    			" + cEnt
	_cQuery += "     SUBSTR(BA8_CODTAB,5,3) BA8_CODTAB,                                                 			" + cEnt
	_cQuery += "     BC6.BC6_CODTAB,                                                 								" + cEnt
	_cQuery += "     BC6.BC6_CODPAD,                                                                    			" + cEnt
	_cQuery += "     BC6.BC6_CODPRO,                                                                    			" + cEnt
	_cQuery += "     BC6.BC6_NIVEL ,                                                                    			" + cEnt
	_cQuery += "     RETORN_TIPO_PROC_ESPEC('" + _cEmp + "',BC6.BC6_CODPAD,BC6.BC6_CODPRO,BAX.BAX_CODESP) BC0_TIPO, " + cEnt
	_cQuery += "     BC6.BC6_CDNV01 ,                                                                   			" + cEnt
	_cQuery += "     BC6.BC6_CDNV02 ,                                                                   			" + cEnt
	_cQuery += "     BC6.BC6_CDNV03 ,                                                                   			" + cEnt
	_cQuery += "     BC6.BC6_CDNV04 ,                                                                   			" + cEnt
	_cQuery += "     NVL(TRIM(BC6.BC6_VIGINI), ' ') VIGINI ,			                                 			" + cEnt
	_cQuery += "     NVL(TRIM(BC6.BC6_VIGFIM), ' ') VIGFIM              			                     			" + cEnt
	_cQuery += " FROM                                                                                   			" + cEnt
	_cQuery += " 	" + RetSqlName("BC6") + " BC6 																	" + cEnt
	_cQuery += "                                                                                        			" + cEnt
	_cQuery += "     INNER JOIN                                                                         			" + cEnt
	_cQuery += " 		" + RetSqlName("BC5") + " BC5																" + cEnt
	_cQuery += "     ON                                                                                 			" + cEnt
	_cQuery += "         BC5.BC5_FILIAL      = BC6.BC6_FILIAL                                           			" + cEnt
	_cQuery += "         AND BC5.BC5_CODINT  = BC6.BC6_CODINT                                           			" + cEnt
	_cQuery += "         AND BC5.BC5_CODRDA  = BC6.BC6_CODRDA                                           			" + cEnt
	_cQuery += "         AND BC5.BC5_CODTAB  = BC6.BC6_CODTAB                                           			" + cEnt
	_cQuery += "         AND BC5.D_E_L_E_T_  = BC6.D_E_L_E_T_                                           			" + cEnt
	_cQuery += "                                                                                        			" + cEnt
	_cQuery += "     INNER JOIN                                                                         			" + cEnt
	_cQuery += " 		" + RetSqlName("BAU") + " BAU																" + cEnt
	_cQuery += "     ON                                                                                 			" + cEnt
	_cQuery += "         BAU.BAU_FILIAL      = BC6.BC6_FILIAL                                           			" + cEnt
	_cQuery += "         AND BAU.BAU_CODIGO  = BC6.BC6_CODRDA                                           			" + cEnt
	_cQuery += "         AND BAU.BAU_DATBLO  = ' '                                                      			" + cEnt
	_cQuery += "         AND BC6.D_E_L_E_T_  = BAU.D_E_L_E_T_                                           			" + cEnt
	_cQuery += "                                                                                        			" + cEnt
	_cQuery += "     INNER JOIN                                                                         			" + cEnt
	_cQuery += " 		" + RetSqlName("BB8") + " BB8																" + cEnt
	_cQuery += "     ON                                                                                 			" + cEnt
	_cQuery += "         BB8.BB8_FILIAL      = BAU.BAU_FILIAL                                           			" + cEnt
	_cQuery += "         AND BB8.BB8_CODIGO  = BAU.BAU_CODIGO                                           			" + cEnt
	_cQuery += "         AND BB8.BB8_DATBLO  = ' '                                                      			" + cEnt
	_cQuery += "                                                                                        			" + cEnt
	_cQuery += "     INNER JOIN                                                                         			" + cEnt
	_cQuery += " 		" + RetSqlName("BAX") + " BAX																" + cEnt
	_cQuery += "     ON                                                                                 			" + cEnt
	_cQuery += "         BAX.BAX_FILIAL      = BAU.BAU_FILIAL                                           			" + cEnt
	_cQuery += "         AND BAX.BAX_CODIGO  = BAU.BAU_CODIGO                                           			" + cEnt
	_cQuery += "         AND BAX.BAX_CODLOC  = BB8.BB8_CODLOC                                           			" + cEnt
	_cQuery += "         AND BAX.BAX_DATBLO  = ' '                                                      			" + cEnt
	_cQuery += "                                                                                        			" + cEnt
	_cQuery += "     INNER JOIN                                                                         			" + cEnt
	_cQuery += " 		" + RetSqlName("BA8") + " BA8																" + cEnt
	_cQuery += "     ON                                                                                 			" + cEnt
	_cQuery += "         BA8.BA8_FILIAL      = BC6.BC6_FILIAL                                           			" + cEnt
	_cQuery += "         AND BA8.BA8_CODPAD  = BC6.BC6_CODPAD                                           			" + cEnt
	_cQuery += "         AND BA8.BA8_CODPRO  = BC6.BC6_CODPRO                                           			" + cEnt
	_cQuery += "                                                                                        			" + cEnt
	_cQuery += " WHERE                                                                                  			" + cEnt
	_cQuery += "     BC6.BC6_XSINCR = '2'                                                               			" + cEnt
	_cQuery += "     AND VERIF_PROC_ESPEC ('" + _cEmp + "',BC6_CODPAD,BC6_CODPRO,BAX_CODESP)='S'                    " + cEnt
	_cQuery += "     AND BC6.D_E_L_E_T_ = ' '                                                           			" + cEnt
	
	If Select(_cAlias1) > 0
		(_cAlias1)->(DbCloseArea())
	EndIf
	
	PLSQuery(_cQuery,_cAlias1)
	
	While !(_cAlias1)->(EOF())
		
		_cQuery := " SELECT 															" + cEnt
		_cQuery += "     NVL(															" + cEnt
		_cQuery += "			RETORNA_PROC_NIVEIS (                   				" + cEnt
		_cQuery += "									'" + _cEmp 					+ "'" + cEnt
		_cQuery += "									," + (_cAlias1)->BA8_CODTAB + " " + cEnt
		_cQuery += "									," + (_cAlias1)->BC6_CODPAD + " " + cEnt
		_cQuery += "									," + (_cAlias1)->BAX_CODESP + " " + cEnt
		_cQuery += "									," + (_cAlias1)->BC6_CODRDA + " " + cEnt
		_cQuery += "									," + (_cAlias1)->BB8_CODLOC + " " + cEnt
		_cQuery += "									," + (_cAlias1)->BC6_CODPRO + " " + cEnt
		_cQuery += "									," + (_cAlias1)->BC6_NIVEL  + "	" + cEnt
		_cQuery += "								)                   				" + cEnt
		_cQuery += "		, ' ') NIVEIS                               				" + cEnt
		_cQuery += " FROM                                               				" + cEnt
		_cQuery += " 	DUAL                                            				" + cEnt
		
		If Select(_cAlias2) > 0
			(_cAlias2)->(DbCloseArea())
		EndIf
		
		PLSQuery(_cQuery,_cAlias2)
		
		If !(_cAlias2)->(EOF())
			
			DbSelectArea("BC0")
			DbSetOrder(1) //BC0_FILIAL+BC0_CODIGO+BC0_CODINT+BC0_CODLOC+BC0_CODESP+BC0_CODTAB+BC0_CODOPC
			If !(DbSeek(xFilial("BC0") + (_cAlias1)->(BC6_CODRDA+BC6_CODINT+BB8_CODLOC+BAX_CODESP+BA8_CODTAB+BC6_CODPRO)))
				
				Reclock("BC0", .T.)
				
				BC0->BC0_FILIAL := xFilial("BC0")
				BC0->BC0_CODIGO := (_cAlias1)->BC6_CODRDA
				BC0->BC0_CODINT := (_cAlias1)->BC6_CODINT
				BC0->BC0_CODLOC := (_cAlias1)->BB8_CODLOC
				BC0->BC0_CODESP := (_cAlias1)->BAX_CODESP
				BC0->BC0_CODTAB := (_cAlias1)->BA8_CODTAB
				BC0->BC0_CODPAD := (_cAlias1)->BC6_CODPAD
				BC0->BC0_CODOPC := (_cAlias1)->BC6_CODPRO
				BC0->BC0_NIVEL  := (_cAlias1)->BC6_NIVEL
				BC0->BC0_VALCH  := 0
				BC0->BC0_VALREA := 0
				BC0->BC0_VALCOB := 0
				BC0->BC0_FORMUL := "1"
				BC0->BC0_PERDES := 0
				BC0->BC0_PERACR := 0
				BC0->BC0_TIPO   := (_cAlias1)->BC0_TIPO
				BC0->BC0_CDNV01 := (_cAlias1)->BC6_CDNV01
				BC0->BC0_CDNV02 := (_cAlias1)->BC6_CDNV02
				BC0->BC0_CDNV03 := (_cAlias1)->BC6_CDNV03
				BC0->BC0_CDNV04 := (_cAlias1)->BC6_CDNV04
				BC0->BC0_VIGDE  := CTOD((_cAlias1)->VIGINI)
				BC0->BC0_VIGATE := CTOD((_cAlias1)->VIGFIM)
				BC0->BC0_BANDA  := 0
				BC0->BC0_OBSERV := "Incluido automaticamente pela rotina RDA tabela de preços x Especialidade da RDA"
				BC0->BC0_XUSUAR := "SISTEMA"
				BC0->BC0_XDTINC := dDatabase
				
				BC0->(MsUnLock())
				
				conout("CABA084 - GRAVOU BC0")
				
			EndIf
			
			//----------------------------------------------------------------
			// Após ter realizado a inclusão do novo item na BC0
			// É necessário atualizar a BC6 que esta sendo analisada
			//----------------------------------------------------------------
			_cQuery := " UPDATE 																" + cEnt
			_cQuery += " 	" + RetSqlName("BC6") + " BC6 										" + cEnt
			_cQuery += " SET 																	" + cEnt
			_cQuery += "	BC6.BC6_XHRSIN = '" + SUBSTR(TIME(),1,2)+SUBSTR(TIME(),4,2) + "' , 	" + cEnt
			_cQuery += "	BC6.BC6_XSINCR = '1'												" + cEnt
			_cQuery += " WHERE																	" + cEnt
			_cQuery += "    BC6.BC6_CODINT 			= '" + (_cAlias1)->BC6_CODINT 	+ "'		" + cEnt
			_cQuery += "    AND BC6.BC6_CODRDA 		= '" + (_cAlias1)->BC6_CODRDA 	+ "'		" + cEnt
			_cQuery += "    AND BC6.BC6_CODTAB 		= '" + (_cAlias1)->BC6_CODTAB 	+ "'		" + cEnt
			_cQuery += "    AND BC6.BC6_CODPAD 		= '" + (_cAlias1)->BC6_CODPAD 	+ "'		" + cEnt
			_cQuery += "    AND BC6.BC6_CODPRO 		= '" + (_cAlias1)->BC6_CODPRO 	+ "'		" + cEnt
			_cQuery += "    AND BC6.BC6_NIVEL 		= '" + (_cAlias1)->BC6_NIVEL 	+ "'		" + cEnt
			_cQuery += "    AND BC6.BC6_XSINCR 		= '2'										" + cEnt
			_cQuery += "	AND BC6.D_E_L_E_T_ 	= ' ' 											" + cEnt
						
			If TcSqlExec(_cQuery ) < 0
				
				conout("CABA084 - Erro na atualizacao do item da BC6")
				
			EndIf
			
		EndIf
		
		If Select(_cAlias2) > 0
			(_cAlias2)->(DbCloseArea())
		EndIf
		
		(_cAlias1)->(DbSkip())
		
	EndDo
	
	If Select(_cAlias1) > 0
		(_cAlias1)->(DbCloseArea())
	EndIf
	
	RestArea(_aArBC6)
	RestArea(_aArBC0)
	RestArea(_aArea	)
	
Return
