#INCLUDE "RWMAKE.CH"
#INCLUDE "TOPCONN.CH"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "TBICONN.CH"

#DEFINE cEnt Chr(13)+Chr(10)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABA005   ºAutor  ³ Angelo Henrique    º Data ³  06/08/18   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Rotina utilizada para realizar o processo de acrescimo ou   º±±
±±º          ³decrescimo do Brasindice.                                   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºObservacao³Esta rotina esta sendo chamada pelos seguintes pontos de    º±±
±±º          ³entrada:                                                    º±±
±±º          ³PLS720G1 - Chamado no final da rotina de mudança de fase.   º±±
±±º          ³PLSREVPC - Chamado no final da rotina de revalorização.     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function CABA005()
	
	Local _aArea		:= GetArea()
	Local _aArBD6		:= BD6->(GetArea())
	Local _aArBD7		:= BD7->(GetArea())
	Local _aArBDX		:= BDX->(GetArea())
	Local cQuery		:= ""
	Local _cEmp			:= IIF(cEmpAnt = "01", "C", "I")
	
	Private c_ChavBD7 	:= ( xFilial("BD7") + BD6->(BD6_CODOPE + BD6_CODLDP + BD6_CODPEG + BD6_NUMERO + BD6_ORIMOV) )
	Private _nVlrCalc	:= 0
	Private _nVlrMaj	:= 0
	Private _nVlrCont	:= 0
	Private _nVlrDsc 	:= 0
	Private _nClcDsc	:= 0
	Private _cChvFil 	:= "" //Chave da BD& onde se encontra o Filme
	Private _nVlrFin  	:= 0
	Private _nVlAnt		:= 0
	Private _lAtuPeg	:= .F.
	
	Private cAliQry1  	:= GetNextAlias()
	Private cAliQry2  	:= GetNextAlias()
	
	// Função ORACLE - VERIF_DESC_ACRESC_BC6
	// Função ORACLE - VERIF_CONGELA_BC6
	
	cQuery := " SELECT 												" + cEnt
	cQuery += "     DISTINCT										" + cEnt
	cQuery += "     BD6.BD6_CODOPE,     							" + cEnt
	cQuery += "     BD6.BD6_CODLDP,     							" + cEnt
	cQuery += "     BD6.BD6_CODPEG,     							" + cEnt
	cQuery += "     BD6.BD6_NUMERO,     							" + cEnt
	cQuery += "     BD6.BD6_ORIMOV,     							" + cEnt
	cQuery += "     BD6.BD6_CODPAD,     							" + cEnt
	cQuery += "     BD6.BD6_CODPRO,     							" + cEnt
	cQuery += "     BD6.BD6_SEQUEN,									" + cEnt
	cQuery += "     BD6.BD6_QTDPRO,									" + cEnt
	cQuery += "     BD6.BD6_VLRAPR,									" + cEnt
	cQuery += "     BD6.BD6_PERTAD,									" + cEnt
	cQuery += "     VERIF_DESC_ACRESC_BC6							" + cEnt
	cQuery += "                         ( 							" + cEnt
	cQuery += "                             '" + _cEmp + "',		" + cEnt    // -- Empresa (CABERJ/INTEGRAL)
	cQuery += "                             BD6.BD6_CODRDA, 		" + cEnt	// -- RDA
	cQuery += "                             BD6.BD6_CODPAD, 		" + cEnt	// -- Tabela
	cQuery += "                             BD6.BD6_CODPRO, 		" + cEnt	// -- Codigo do Procedimento
	cQuery += "                             BD6.BD6_DATPRO, 		" + cEnt	// -- Data do Procedimento
	cQuery += "                             BD6.BD6_CODPLA, 		" + cEnt	// -- Codigo do Plano
	cQuery += "                             'A'         			" + cEnt	// -- Acréscimo ou Desconto ou Percentual PFB -- D (desconto) | A (Acrescimo) | P (Acrescimo PFB) OU F (Desconto PFB)
	cQuery += "                         ) VLR_ACRES, 				" + cEnt
	cQuery += "     VERIF_DESC_ACRESC_BC6							" + cEnt
	cQuery += "                         ( 							" + cEnt
	cQuery += "                             '" + _cEmp + "',		" + cEnt    // -- Empresa (CABERJ/INTEGRAL)
	cQuery += "                             BD6.BD6_CODRDA, 		" + cEnt 	// -- RDA
	cQuery += "                             BD6.BD6_CODPAD, 		" + cEnt	// -- Tabela
	cQuery += "                             BD6.BD6_CODPRO, 		" + cEnt	// -- Codigo do Procedimento
	cQuery += "                             BD6.BD6_DATPRO, 		" + cEnt	// -- Data do Procedimento
	cQuery += "                             BD6.BD6_CODPLA, 		" + cEnt	// -- Codigo do Plano
	cQuery += "                             'D'         			" + cEnt	// -- Acréscimo ou Desconto ou Percentual PFB -- D (desconto) | A (Acrescimo) | P (Acrescimo PFB) OU F (Desconto PFB)
	cQuery += "                         ) VLR_DECRES,				" + cEnt
	cQuery += "     VERIF_DESC_ACRESC_BC6							" + cEnt
	cQuery += "                         ( 							" + cEnt
	cQuery += "                             '" + _cEmp + "',		" + cEnt    // -- Empresa (CABERJ/INTEGRAL)
	cQuery += "                             BD6.BD6_CODRDA, 		" + cEnt 	// -- RDA
	cQuery += "                             BD6.BD6_CODPAD, 		" + cEnt	// -- Tabela
	cQuery += "                             BD6.BD6_CODPRO, 		" + cEnt	// -- Codigo do Procedimento
	cQuery += "                             BD6.BD6_DATPRO, 		" + cEnt	// -- Data do Procedimento
	cQuery += "                             BD6.BD6_CODPLA, 		" + cEnt	// -- Codigo do Plano
	cQuery += "                             'P'         			" + cEnt	// -- Acréscimo ou Desconto ou Percentual PFB -- D (desconto) | A (Acrescimo) | P (Acrescimo PFB) OU F (Desconto PFB)
	cQuery += "                         ) VLR_PRCPFB,				" + cEnt
	cQuery += "     VERIF_DESC_ACRESC_BC6							" + cEnt
	cQuery += "                         ( 							" + cEnt
	cQuery += "                             '" + _cEmp + "',		" + cEnt    // -- Empresa (CABERJ/INTEGRAL)
	cQuery += "                             BD6.BD6_CODRDA, 		" + cEnt 	// -- RDA
	cQuery += "                             BD6.BD6_CODPAD, 		" + cEnt	// -- Tabela
	cQuery += "                             BD6.BD6_CODPRO, 		" + cEnt	// -- Codigo do Procedimento
	cQuery += "                             BD6.BD6_DATPRO, 		" + cEnt	// -- Data do Procedimento
	cQuery += "                             BD6.BD6_CODPLA, 		" + cEnt	// -- Codigo do Plano
	cQuery += "                             'F'         			" + cEnt	// -- Acréscimo ou Desconto ou Percentual PFB -- D (desconto) | A (Acrescimo) | P (Acrescimo PFB) OU F (Desconto PFB)
	cQuery += "                         ) VLR_PRCDSC,				" + cEnt
	cQuery += "    	NVL(BD4.BD4_XTPREC,' ') PRECIFIC,				" + cEnt
	cQuery += "    	NVL(BD4.BD4_XVLFAB,0  ) VLR_FABRIC,   			" + cEnt
	cQuery += "    	NVL(BD4.BD4_VALREF,0  ) VLR_REF,   				" + cEnt
	cQuery += "     VERIF_CONGELA_BC6								" + cEnt
	cQuery += "                         ( 							" + cEnt
	cQuery += "                             '" + _cEmp + "',		" + cEnt    // -- Empresa (CABERJ/INTEGRAL)
	cQuery += "                             BD6.BD6_CODRDA, 		" + cEnt 	// -- RDA
	cQuery += "                             BD6.BD6_CODPAD, 		" + cEnt	// -- Tabela
	cQuery += "                             BD6.BD6_CODPRO, 		" + cEnt	// -- Codigo do Procedimento
	cQuery += "                             BD6.BD6_DATPRO	 		" + cEnt	// -- Data do Procedimento
	cQuery += "                         ) EDICAO,					" + cEnt
	cQuery += "    BAU.BAU_XPGPFB PFB_NEGOC							" + cEnt
	cQuery += "     												" + cEnt
	cQuery += " FROM 												" + cEnt
	cQuery += "     												" + cEnt
	cQuery += "     " + RetSqlName("BD6")+ " BD6					" + cEnt
	cQuery += "     												" + cEnt
	cQuery += "     INNER JOIN  									" + cEnt
	cQuery += "     " + RetSqlName("BD7")+ " BD7					" + cEnt
	cQuery += "     ON 												" + cEnt
	cQuery += "         BD7.D_E_L_E_T_ = ' ' 						" + cEnt
	cQuery += "         AND BD7.BD7_FILIAL = BD6.BD6_FILIAL 		" + cEnt
	cQuery += "         AND BD7.BD7_CODOPE = BD6.BD6_CODOPE 		" + cEnt
	cQuery += "         AND BD7.BD7_CODLDP = BD6.BD6_CODLDP 		" + cEnt
	cQuery += "         AND BD7.BD7_CODPEG = BD6.BD6_CODPEG 		" + cEnt
	cQuery += "         AND BD7.BD7_NUMERO = BD6.BD6_NUMERO 		" + cEnt
	cQuery += "         AND BD7.BD7_ORIMOV = BD6.BD6_ORIMOV 		" + cEnt
	cQuery += "         AND BD7.BD7_SEQUEN = BD6.BD6_SEQUEN			" + cEnt
	cQuery += "         AND BD7.BD7_YFAS35 = 'F'					" + cEnt
	cQuery += "         											" + cEnt
	cQuery += "     LEFT JOIN  										" + cEnt
	cQuery += "     " + RetSqlName("BD4")+ " BD4					" + cEnt
	cQuery += "     ON 												" + cEnt
	cQuery += "         BD4.BD4_FILIAL = '" + xFilial("BD4") + "'	" + cEnt
	cQuery += "         AND BD4.BD4_CODPRO  = BD6.BD6_CODPRO		" + cEnt
	cQuery += "         AND BD4.BD4_CDPADP  = BD6.BD6_CODPAD		" + cEnt
	cQuery += "         AND BD4.BD4_VIGINI  <> ' '					" + cEnt
	cQuery += "         AND BD4.BD4_VIGINI  <= BD6.BD6_DATPRO		" + cEnt
	cQuery += "         AND											" + cEnt
	cQuery += "         	(										" + cEnt
	cQuery += "         		BD4.BD4_VIGFIM  >= BD6.BD6_DATPRO	" + cEnt
	cQuery += "         		OR									" + cEnt
	cQuery += "         		BD4.BD4_VIGFIM = ' '				" + cEnt
	cQuery += "         	)										" + cEnt
	cQuery += "         AND BD4.D_E_L_E_T_  = ' '					" + cEnt
	cQuery += "         AND BD4.BD4_CDPADP IN ('20','23')			" + cEnt
	cQuery += "         											" + cEnt
	cQuery += "		INNER JOIN 										" + cEnt
	cQuery += "     " + RetSqlName("BAU")+ " BAU					" + cEnt
	cQuery += "		ON												" + cEnt
	cQuery += "			BAU.BAU_FILIAL = ' '						" + cEnt
	cQuery += "			AND BAU.BAU_CODIGO = BD6.BD6_CODRDA			" + cEnt
	cQuery += "			AND BAU.BAU_XPGPFB = '1'					" + cEnt
	cQuery += "         											" + cEnt
	cQuery += " WHERE												" + cEnt
	cQuery += "         											" + cEnt
	cQuery += "     BD6.D_E_L_E_T_      = ' '						" + cEnt
	cQuery += "     AND BD6.BD6_FILIAL  = '" + xFilial("BD6")  + "'	" + cEnt
	cQuery += "     AND BD6.BD6_CODOPE  = '" + BD6->BD6_CODOPE + "'	" + cEnt
	cQuery += "     AND BD6.BD6_CODLDP  = '" + BD6->BD6_CODLDP + "'	" + cEnt
	cQuery += "     AND BD6.BD6_CODPEG  = '" + BD6->BD6_CODPEG + "'	" + cEnt
	cQuery += "     AND BD6.BD6_NUMERO  = '" + BD6->BD6_NUMERO + "'	" + cEnt
	cQuery += "     AND BD6.BD6_ORIMOV  = '" + BD6->BD6_ORIMOV + "'	" + cEnt
	
	If Select(cAliQry1)>0
		(cAliQry1)->(DbCloseArea())
	EndIf
	
	DbUseArea(.T.,"TopConn",TcGenQry(,,cQuery),cAliQry1,.T.,.T.)
	
	DbSelectArea(cAliQry1)
	
	While !((cAliQry1)->(Eof()))
		
		//---------------------------------------------------------------------------
		//Caso esteja com congelamento de edição realizará outra validação
		//---------------------------------------------------------------------------
		If !Empty((cAliQry1)->EDICAO)
			
			cQuery := " SELECT                                                                       	" + cEnt
			cQuery += "     BD4.BD4_VALREF VLREF                                                       	" + cEnt
			cQuery += " FROM                                                                         	" + cEnt
			cQuery += "     " + RetSqlName("BD4")+ " BD4							    			 	" + cEnt
			cQuery += " WHERE                                                                        	" + cEnt
			cQuery += "     BD4.BD4_FILIAL 		= '" + xFilial("BD4") 			+ "'      				" + cEnt
			cQuery += "     AND BD4.BD4_CODPRO 	= '" + (cAliQry1)->BD6_CODPRO 	+ "'      				" + cEnt
			cQuery += "     AND BD4.BD4_CDPADP 	= '" + (cAliQry1)->BD6_CODPAD 	+ "'      				" + cEnt
			cQuery += "     AND BD4.BD4_YEDICA 	= '" + (cAliQry1)->EDICAO 	 	+ "'                 	" + cEnt
			cQuery += "     AND BD4.BD4_VALREF 	<> 0                                                 	" + cEnt
			cQuery += "     AND BD4.D_E_L_E_T_ 	= ' '                                                 	" + cEnt
			cQuery += "     AND BD4.R_E_C_N_O_ 	=    (                                                	" + cEnt
			cQuery += "                                 SELECT                                       	" + cEnt
			cQuery += "                                     MAX(BD4_INT.R_E_C_N_O_) RECNO            	" + cEnt
			cQuery += "                                 FROM                                         	" + cEnt
			cQuery += "                                     BD4010 BD4_INT                           	" + cEnt
			cQuery += "                                 WHERE                                        	" + cEnt
			cQuery += "                                     BD4_INT.BD4_FILIAL      = BD4.BD4_FILIAL 	" + cEnt
			cQuery += "                                     AND BD4_INT.BD4_CODPRO  = BD4.BD4_CODPRO 	" + cEnt
			cQuery += "                                     AND BD4_INT.BD4_CDPADP  = BD4.BD4_CDPADP 	" + cEnt
			cQuery += "                                     AND BD4_INT.BD4_YEDICA  = BD4.BD4_YEDICA 	" + cEnt
			cQuery += "                                     AND BD4_INT.D_E_L_E_T_  = BD4.D_E_L_E_T_ 	" + cEnt
			cQuery += "                             )													" + cEnt
			
			If Select(cAliQry2)>0
				(cAliQry2)->(DbCloseArea())
			EndIf
			
			DbUseArea(.T.,"TopConn",TcGenQry(,,cQuery),cAliQry2,.T.,.T.)
			
			DbSelectArea(cAliQry2)
			
			If !((cAliQry2)->(Eof()))
				
				BD7->(DbGoTop())
				
				DbSelectArea("BD7")
				DbSetOrder(1) //BD7_FILIAL+BD7_CODOPE+BD7_CODLDP+BD7_CODPEG+BD7_NUMERO+BD7_ORIMOV
				If DbSeek(c_ChavBD7 + (cAliQry1)->BD6_SEQUEN )
					
					While !EOF() .And. BD7->(BD7_FILIAL+BD7_CODOPE+BD7_CODLDP+BD7_CODPEG+BD7_NUMERO+BD7_ORIMOV+BD7_SEQUEN) == c_ChavBD7 + (cAliQry1)->BD6_SEQUEN
						
						If BD7->BD7_BLOPAG == "0" .And. !BD7->BD7_YFAS35
							
							If BD7->BD7_VLRAPR > (cAliQry2)->VLREF .OR. BD7->BD7_VLRAPR = 0
								
								
								RecLock("BD7", .F.)
								
								BD7->BD7_VLRBPR := (cAliQry2)->VLREF * (cAliQry1)->BD6_QTDPRO
								
								If ((cAliQry1)->BD6_VLRAPR * (cAliQry1)->BD6_QTDPRO) < BD7->BD7_VLRBPR
									
									BD7->BD7_VLRPAG := (((cAliQry1)->BD6_VLRAPR * (cAliQry1)->BD6_QTDPRO) * BD7->BD7_PERCEN) / 100
									BD7->BD7_VLRBPF := (((cAliQry1)->BD6_VLRAPR * (cAliQry1)->BD6_QTDPRO) * BD7->BD7_PERCEN) / 100
									BD7->BD7_VLRMAN := ((cAliQry1)->BD6_VLRAPR * (cAliQry1)->BD6_QTDPRO)
									
								Else
									
									BD7->BD7_VLRPAG := (BD7->BD7_VLRBPR  * BD7->BD7_PERCEN) / 100
									BD7->BD7_VLRBPF := (BD7->BD7_VLRBPR  * BD7->BD7_PERCEN) / 100
									BD7->BD7_VLRMAN := (((cAliQry1)->BD6_VLRAPR * (cAliQry1)->BD6_QTDPRO) * BD7->BD7_PERCEN) / 100
									BD7->BD7_VLRGLO := BD7->BD7_VLRMAN - BD7->BD7_VLRPAG
									
								EndIf
								
								BD7->BD7_COEFUT := (cAliQry2)->VLREF
								BD7->BD7_COEFPF := (cAliQry2)->VLREF
								BD7->BD7_REFTDE := (cAliQry2)->VLREF
								BD7->BD7_ALIAUS := "BC6"
								BD7->BD7_VLRTAD := (BD7->BD7_VLRPAG * (cAliQry1)->BD6_PERTAD) /100							
								
								_nVlrCalc += BD7->BD7_VLRPAG
								_nVlrCont += BD7->BD7_VLRBPR //Valor Contrato
								
								BD7->(MsUnLock())
								
							EndIf
							
						EndIf
						
						BD7->(DbSkip())
						
					EndDo
					
				EndIf
				
				If _nVlrCalc > 0
					
					//-----------------------------------------
					//Rotina responsável por atualizar o BD6
					//-----------------------------------------
					_lAtuPeg := U_CABA005D("3")
					
				EndIf
				
			EndIf
			
			If Select(cAliQry2)>0
				(cAliQry2)->(DbCloseArea())
			EndIf
			
		Else
			
			If (cAliQry1)->PFB_NEGOC == "1" //SIM Para olhar PFB ou as negociações
				
				BD7->(DbGoTop())
				
				DbSelectArea("BD7")
				DbSetOrder(1) //BD7_FILIAL+BD7_CODOPE+BD7_CODLDP+BD7_CODPEG+BD7_NUMERO+BD7_ORIMOV
				If DbSeek(c_ChavBD7 + (cAliQry1)->BD6_SEQUEN )
					
					While !EOF() .And. BD7->(BD7_FILIAL+BD7_CODOPE+BD7_CODLDP+BD7_CODPEG+BD7_NUMERO+BD7_ORIMOV+BD7_SEQUEN) == c_ChavBD7 + (cAliQry1)->BD6_SEQUEN
						
						If BD7->BD7_BLOPAG == "0" .And. !BD7->BD7_YFAS35
							
							If BD7->BD7_VLRAPR > (cAliQry1)->VLR_FABRIC .OR. BD7->BD7_VLRAPR = 0
								
								RecLock("BD7", .F.)
								
								//--------------------------------------------------------------------
								//Se for PFB
								//--------------------------------------------------------------------
								If (cAliQry1)->PRECIFIC == "2"
									
									//--------------------------------------------------------------
									//Se o valor da BC6 for maior que zero
									//--------------------------------------------------------------
									If (cAliQry1)->VLR_FABRIC > 0
										
										//----------------------------------------------------------
										//Calculo do valor contratado - Acréscimo
										//----------------------------------------------------------
										If (cAliQry1)->VLR_PRCPFB > 0
											
											BD7->BD7_VLRBPR := ((((cAliQry1)->VLR_FABRIC * (cAliQry1)->VLR_PRCPFB) / 100) + (cAliQry1)->VLR_FABRIC) * (cAliQry1)->BD6_QTDPRO 
											BD7->BD7_MAJORA := (cAliQry1)->VLR_PRCPFB
											
											_nVlrMaj 	+= (cAliQry1)->VLR_PRCPFB
											
										EndIf
										
										//----------------------------------------------------------
										//Calculo do valor contratado - Decréscimo
										//----------------------------------------------------------
										If (cAliQry1)->VLR_PRCDSC > 0
											
											BD7->BD7_VLRBPR :=  ((cAliQry1)->VLR_FABRIC - (((cAliQry1)->VLR_FABRIC * (cAliQry1)->VLR_PRCDSC) / 100)) * (cAliQry1)->BD6_QTDPRO 
											BD7->BD7_DSCCLI := (cAliQry1)->VLR_PRCDSC
											
											_nVlrDsc += (cAliQry1)->VLR_PRCDSC //Percentual do Desconto
											_nClcDsc := (cAliQry1)->VLR_FABRIC //Valor desconto PFB
											
										EndIf
										
										If ((cAliQry1)->BD6_VLRAPR * (cAliQry1)->BD6_QTDPRO) < BD7->BD7_VLRBPR
											
											BD7->BD7_VLRPAG := (((cAliQry1)->BD6_VLRAPR * (cAliQry1)->BD6_QTDPRO) * BD7->BD7_PERCEN) / 100
											BD7->BD7_VLRMAN := ((cAliQry1)->BD6_VLRAPR * (cAliQry1)->BD6_QTDPRO)
											
										Else
											
											BD7->BD7_VLRPAG := (BD7->BD7_VLRBPR  * BD7->BD7_PERCEN) / 100
											BD7->BD7_VLRMAN := (((cAliQry1)->BD6_VLRAPR * (cAliQry1)->BD6_QTDPRO) * BD7->BD7_PERCEN) / 100
											BD7->BD7_VLRGLO := BD7->BD7_VLRMAN - BD7->BD7_VLRPAG
											
										EndIf
										
										BD7->BD7_COEFUT := (cAliQry1)->VLR_FABRIC
										BD7->BD7_COEFPF := (cAliQry1)->VLR_FABRIC
										BD7->BD7_REFTDE := (cAliQry1)->VLR_FABRIC
										BD7->BD7_ALIAUS := "BC6"
										BD7->BD7_VLRTAD := (BD7->BD7_VLRPAG * (cAliQry1)->BD6_PERTAD) /100
										
										_nVlrCalc 	+= BD7->BD7_VLRPAG
										_nVlrCont 	+= BD7->BD7_VLRBPR //Valor Contrato
										
									EndIf
									
								Else
									
									//-------------------------------------------------------
									// Validando se irá pegar o acréscimo ou decréscimo
									//-------------------------------------------------------
									If (cAliQry1)->VLR_ACRES > 0
										
										BD7->BD7_VLRBPR := (((cAliQry1)->VLR_REF  / 100) + (cAliQry1)->VLR_REF ) * (cAliQry1)->BD6_QTDPRO 
										
										If ((cAliQry1)->BD6_VLRAPR * (cAliQry1)->BD6_QTDPRO) < BD7->BD7_VLRBPR
											
											BD7->BD7_VLRPAG := (((cAliQry1)->BD6_VLRAPR * (cAliQry1)->BD6_QTDPRO) * BD7->BD7_PERCEN) / 100
											BD7->BD7_VLRMAN := ((cAliQry1)->BD6_VLRAPR * (cAliQry1)->BD6_QTDPRO)
											
										Else
											
											BD7->BD7_VLRPAG := (BD7->BD7_VLRBPR  * BD7->BD7_PERCEN) / 100
											BD7->BD7_VLRMAN := (((cAliQry1)->BD6_VLRAPR * (cAliQry1)->BD6_QTDPRO) * BD7->BD7_PERCEN) / 100
											BD7->BD7_VLRGLO := BD7->BD7_VLRMAN - BD7->BD7_VLRPAG
											
										EndIf
										
										BD7->BD7_COEFUT := (cAliQry1)->VLR_REF
										BD7->BD7_COEFPF := (cAliQry1)->VLR_REF
										BD7->BD7_REFTDE := (cAliQry1)->VLR_REF
										BD7->BD7_MAJORA := (cAliQry1)->VLR_ACRES
										BD7->BD7_ALIAUS := "BC6"
										BD7->BD7_VLRTAD := (BD7->BD7_VLRPAG * (cAliQry1)->BD6_PERTAD) /100
										
										_nVlrMaj 	+= (cAliQry1)->VLR_ACRES
										_nVlrCalc 	+= BD7->BD7_VLRPAG
										_nVlrCont 	+= BD7->BD7_VLRBPR //Valor Contrato
										
									ElseIf (cAliQry1)->VLR_DECRES > 0
																																			
										BD7->BD7_VLRBPR := ((cAliQry1)->VLR_REF - (((cAliQry1)->VLR_REF * (cAliQry1)->VLR_DECRES) / 100)) * (cAliQry1)->BD6_QTDPRO
										
										If ((cAliQry1)->BD6_VLRAPR * (cAliQry1)->BD6_QTDPRO) < BD7->BD7_VLRBPR
											
											BD7->BD7_VLRPAG := (((cAliQry1)->BD6_VLRAPR * (cAliQry1)->BD6_QTDPRO) * BD7->BD7_PERCEN) / 100
											BD7->BD7_VLRMAN := ((cAliQry1)->BD6_VLRAPR * (cAliQry1)->BD6_QTDPRO)
											
										Else
											
											BD7->BD7_VLRPAG := (BD7->BD7_VLRBPR  * BD7->BD7_PERCEN) / 100
											BD7->BD7_VLRMAN := (((cAliQry1)->BD6_VLRAPR * (cAliQry1)->BD6_QTDPRO) * BD7->BD7_PERCEN) / 100
											BD7->BD7_VLRGLO := BD7->BD7_VLRMAN - BD7->BD7_VLRPAG
											
										EndIf
										
										BD7->BD7_COEFUT := (cAliQry1)->VLR_REF
										BD7->BD7_COEFPF := (cAliQry1)->VLR_REF
										BD7->BD7_REFTDE := (cAliQry1)->VLR_REF
										BD7->BD7_DSCCLI := (cAliQry1)->VLR_DECRES
										BD7->BD7_ALIAUS := "BC6"
										BD7->BD7_VLRTAD := (BD7->BD7_VLRPAG * (cAliQry1)->BD6_PERTAD) /100
										
										_nVlrCalc += BD7->BD7_VLRPAG
										_nVlrCont += BD7->BD7_VLRBPR //Valor Contrato
										_nVlrDsc  += (cAliQry1)->VLR_DECRES //Valor do Desconto
										_nClcDsc  := (cAliQry1)->VLR_REF  //Valor do Desconto
										
									EndIf
									
								EndIf
								
								BD7->(MsUnLock())
								
							EndIf
							
						EndIf
						
						BD7->(DbSkip())
						
					EndDo
					
				EndIf
				
				If _nVlrCalc > 0
					
					//-----------------------------------------
					//Rotina responsável por atualizar o BD6
					//-----------------------------------------
					_lAtuPeg := U_CABA005D("1")
					
				EndIf
				
			EndIf
			
		EndIf
		
		//-------------------------------------
		//Restaurando a variável
		//-------------------------------------
		_nVlrCalc 	:= 0
		_nVlrMaj	:= 0
		_nVlrCont	:= 0
		_nVlrDsc 	:= 0
		
		(cAliQry1)->(DbSkip())
		
	EndDo
	
	If Select(cAliQry1)>0
		(cAliQry1)->(DbCloseArea())
	EndIf
	
	
	//----------------------------------------------------------------------------------------
	//Inicio do processo de calculo do Filme, tabela PD3 (RDA x Produto x Filme)
	//----------------------------------------------------------------------------------------
	RestArea(_aArBDX)
	RestArea(_aArBD7)
	RestArea(_aArBD6)
	
	cQuery 		:= ""
	_nVlrCalc 	:= 0
	_nVlrCont	:= 0
	
	cQuery += " SELECT                                       			" + cEnt
	cQuery += "     DISTINCT                                 			" + cEnt
	cQuery += "     BD6.BD6_CODOPE,                          			" + cEnt
	cQuery += "     BD6.BD6_CODLDP,                          			" + cEnt
	cQuery += "     BD6.BD6_CODPEG,                          			" + cEnt
	cQuery += "     BD6.BD6_NUMERO,                          			" + cEnt
	cQuery += "     BD6.BD6_ORIMOV,                          			" + cEnt
	cQuery += "     BD6.BD6_CODPAD,                          			" + cEnt
	cQuery += "     BD6.BD6_CODPRO,                          			" + cEnt
	cQuery += "     BD6.BD6_SEQUEN,                          			" + cEnt
	cQuery += "     BD6.BD6_CODRDA,                          			" + cEnt
	cQuery += "     BD6.BD6_QTDPRO,                          			" + cEnt
	cQuery += "     PD3.PD3_VLRFIL,			                 			" + cEnt
	cQuery += "     NVL(BD4.BD4_VALREF,0) VL_REFERE		       			" + cEnt
	cQuery += " FROM                                         			" + cEnt
	cQuery += "     " + RetSqlName("BD6")+ " BD6						" + cEnt
	cQuery += "                                              			" + cEnt
	cQuery += "     INNER JOIN                               			" + cEnt
	cQuery += "     " + RetSqlName("BD7")+ " BD7						" + cEnt
	cQuery += "     ON                                       			" + cEnt
	cQuery += "         BD7.D_E_L_E_T_      = '" + xFilial("BD7")  + "' " + cEnt
	cQuery += "         AND BD7.BD7_FILIAL  = BD6.BD6_FILIAL			" + cEnt
	cQuery += "         AND BD7.BD7_CODOPE  = BD6.BD6_CODOPE 			" + cEnt
	cQuery += "         AND BD7.BD7_CODLDP  = BD6.BD6_CODLDP 			" + cEnt
	cQuery += "         AND BD7.BD7_CODPEG  = BD6.BD6_CODPEG 			" + cEnt
	cQuery += "         AND BD7.BD7_NUMERO  = BD6.BD6_NUMERO 			" + cEnt
	cQuery += "         AND BD7.BD7_ORIMOV  = BD6.BD6_ORIMOV 			" + cEnt
	cQuery += "         AND BD7.BD7_SEQUEN  = BD6.BD6_SEQUEN 			" + cEnt
	cQuery += "         AND BD7.BD7_YFAS35  = 'F'            			" + cEnt
	cQuery += "         AND BD7.BD7_BLOPAG  = '0'            			" + cEnt
	cQuery += "         AND BD7.BD7_CODUNM  = 'FIL'          			" + cEnt // FILME
	cQuery += "                                              			" + cEnt
	cQuery += "     INNER JOIN                               			" + cEnt
	cQuery += "     " + RetSqlName("BA1")+ " BA1						" + cEnt
	cQuery += "     ON                                       			" + cEnt
	cQuery += "         BA1.BA1_FILIAL      = '" + xFilial("BA1")  + "' " + cEnt
	cQuery += "         AND BA1.BA1_CODINT  = BD6.BD6_CODOPE 			" + cEnt
	cQuery += "         AND BA1.BA1_CODEMP  = BD6.BD6_CODEMP 			" + cEnt
	cQuery += "         AND BA1.BA1_MATRIC  = BD6.BD6_MATRIC 			" + cEnt
	cQuery += "         AND BA1.BA1_TIPREG  = BD6.BD6_TIPREG 			" + cEnt
	cQuery += "         AND BA1.BA1_DIGITO  = BD6.BD6_DIGITO 			" + cEnt
	cQuery += "         AND BA1.D_E_L_E_T_  = ' '            			" + cEnt
	cQuery += "                                            				" + cEnt
	cQuery += "     INNER JOIN                               			" + cEnt
	cQuery += "     " + RetSqlName("PD3")+ " PD3						" + cEnt
	cQuery += "     ON                                       			" + cEnt
	cQuery += "         PD3.PD3_FILIAL      = '" + xFilial("PD3")  + "' " + cEnt
	cQuery += "         AND PD3.PD3_CODRDA  = BD6.BD6_CODRDA 			" + cEnt
	cQuery += "         AND PD3.PD3_CODPLA  = BA1.BA1_CODPLA 			" + cEnt
	cQuery += "         AND PD3.D_E_L_E_T_  = ' '            			" + cEnt
	cQuery += "         AND PD3.PD3_VLRFIL 	<> 0             			" + cEnt
	cQuery += "         AND PD3.PD3_VIGDE 	<> ' '						" + cEnt
	cQuery += "         AND PD3.PD3_VIGDE 	<= BD6.BD6_DATPRO			" + cEnt
	cQuery += "         AND												" + cEnt
	cQuery += "         	(											" + cEnt
	cQuery += "         		PD3.PD3_VIGATE  >= BD6.BD6_DATPRO		" + cEnt
	cQuery += "         		OR										" + cEnt
	cQuery += "         		PD3.PD3_VIGATE = ' '					" + cEnt
	cQuery += "         	)											" + cEnt
	cQuery += "                                              			" + cEnt
	cQuery += "		INNER JOIN											" + cEnt
	cQuery += "     " + RetSqlName("BD4")+ " BD4						" + cEnt
	cQuery += "		ON													" + cEnt
	cQuery += "			BD4.BD4_FILIAL      = '" + xFilial("BD4")  + "'	" + cEnt
	cQuery += "			AND BD4.BD4_CODPRO  = BD6.BD6_CODPRO			" + cEnt
	cQuery += "			AND BD4.BD4_CDPADP  = BD6.BD6_CODPAD			" + cEnt
	cQuery += "			AND BD4.BD4_VIGINI  <> ' '						" + cEnt
	cQuery += "			AND BD4.BD4_VIGINI  <= BD6.BD6_DATPRO			" + cEnt
	cQuery += "			AND BD4.BD4_CODIGO = 'FIL'						" + cEnt
	cQuery += "			AND												" + cEnt
	cQuery += "				(											" + cEnt
	cQuery += "					BD4.BD4_VIGFIM  >= BD6.BD6_DATPRO		" + cEnt
	cQuery += "					OR										" + cEnt
	cQuery += "					BD4.BD4_VIGFIM = ' '					" + cEnt
	cQuery += "				)											" + cEnt
	cQuery += "			AND BD4.D_E_L_E_T_  = ' '						" + cEnt
	cQuery += "			AND BD4.BD4_CDPADP = BD6.BD6_CODPAD				" + cEnt
	cQuery += "                                              			" + cEnt
	cQuery += " WHERE                                        			" + cEnt
	cQuery += "                                              			" + cEnt
	cQuery += "     BD6.D_E_L_E_T_      = ' '	            			" + cEnt
	cQuery += "     AND BD6.BD6_FILIAL  = '" + xFilial("BD6")  + "'		" + cEnt
	cQuery += "     AND BD6.BD6_CODOPE  = '" + BD6->BD6_CODOPE + "'		" + cEnt
	cQuery += "     AND BD6.BD6_CODLDP  = '" + BD6->BD6_CODLDP + "'		" + cEnt
	cQuery += "     AND BD6.BD6_CODPEG  = '" + BD6->BD6_CODPEG + "'		" + cEnt
	cQuery += "     AND BD6.BD6_NUMERO  = '" + BD6->BD6_NUMERO + "'		" + cEnt
	cQuery += "     AND BD6.BD6_ORIMOV  = '" + BD6->BD6_ORIMOV + "'		" + cEnt
	cQuery += "                                              			" + cEnt
	cQuery += " ORDER BY                                     			" + cEnt
	cQuery += "     BD6.BD6_SEQUEN                           			" + cEnt
	
	If Select(cAliQry1)>0
		(cAliQry1)->(DbCloseArea())
	EndIf
	
	DbUseArea(.T.,"TopConn",TcGenQry(,,cQuery),cAliQry1,.T.,.T.)
	
	DbSelectArea(cAliQry1)
	
	While !((cAliQry1)->(Eof()))
		
		BD7->(DbGoTop())
		
		DbSelectArea("BD7")
		DbSetOrder(1) //BD7_FILIAL+BD7_CODOPE+BD7_CODLDP+BD7_CODPEG+BD7_NUMERO+BD7_ORIMOV
		If DbSeek(c_ChavBD7 + (cAliQry1)->BD6_SEQUEN )
			
			While !EOF() .And. BD7->(BD7_FILIAL+BD7_CODOPE+BD7_CODLDP+BD7_CODPEG+BD7_NUMERO+BD7_ORIMOV+BD7_SEQUEN) == c_ChavBD7 + (cAliQry1)->BD6_SEQUEN
				
				If BD7->BD7_BLOPAG == "0" .And. !BD7->BD7_YFAS35
					
					If BD7->BD7_VLRAPR > (cAliQry1)->VL_REFERE .OR. BD7->BD7_VLRAPR = 0
						
						If (cAliQry1)->VL_REFERE > 0
							
							RecLock("BD7", .F.)
							
							If BD7->BD7_CODUNM  == 'FIL'
								
								_cChvFil := BD7->(BD7_FILIAL+BD7_CODOPE+BD7_CODLDP+BD7_CODPEG+BD7_NUMERO+BD7_ORIMOV+BD7_SEQUEN+BD7_CODUNM)
								
								BD7->BD7_VLRPAG := ((cAliQry1)->PD3_VLRFIL * (cAliQry1)->VL_REFERE) * (cAliQry1)->BD6_QTDPRO
								BD7->BD7_VLRBPR := ((cAliQry1)->PD3_VLRFIL * (cAliQry1)->VL_REFERE) * (cAliQry1)->BD6_QTDPRO
								BD7->BD7_COEFUT := (cAliQry1)->PD3_VLRFIL
								BD7->BD7_COEFPF := (cAliQry1)->PD3_VLRFIL
								BD7->BD7_RFTDEC := (cAliQry1)->PD3_VLRFIL
								BD7->BD7_ALIAUS := "PD3"
								BD7->BD7_ALIPF 	:= "PD3"
								
							EndIf
							
							_nVlrCalc += BD7->BD7_VLRPAG //Valor Pago
							_nVlrCont += BD7->BD7_VLRBPR //Valor Contrato
							
							BD7->(MsUnLock())
							
						EndIf
						
					EndIf
					
				EndIf
				
				BD7->(DbSkip())
				
			EndDo
			
		EndIf
		
		If _nVlrCalc > 0
			
			//-----------------------------------------
			//Rotina responsável por atualizar o BD6
			//-----------------------------------------
			_lAtuPeg := U_CABA005D("2")
			
		EndIf
		
		//-------------------------------------
		//Restaurando a variável
		//-------------------------------------
		_nVlrCalc 	:= 0
		_nVlrCont	:= 0
		
		(cAliQry1)->(DbSkip())
		
	EndDo
	
	If Select(cAliQry1)>0
		(cAliQry1)->(DbCloseArea())
	EndIf
	
	//--------------------------------------------------------------------------------
	//Caso tenha atualizado a BD6 é necessário reclacular a BD5 e depois a BCI
	//--------------------------------------------------------------------------------
	If _lAtuPeg
		
		u_CABA005C()
		
	EndIf
	
	_lAtuPeg := .F.
	
	RestArea(_aArBDX)
	RestArea(_aArBD7)
	RestArea(_aArBD6)
	RestArea(_aArea	)
	
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABA005A  ºAutor  ³ Angelo Henrique    º Data ³  14/08/18   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Rotina utilizada para limpar os campos utilizados na        º±±
±±º          ³rotina de acréscimo e descrescimo.                          º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function CABA005A()
	
	Local _aArea	:= GetArea()
	Local _aArBD6	:= BD6->(GetArea())
	Local _aArBD7	:= BD7->(GetArea())
	Local _aArBDX	:= BDX->(GetArea())
	Local cUpdBd7	:= ""
	
	//-------------------------------------------------------------------
	//Limpando os campos da BD6 caso os mesmos não sejam zerados
	//no momento em que retorna a fase da guia
	//-------------------------------------------------------------------
	BD6->(Reclock('BD6',.F.))
	
	BD6->BD6_VLRDES := 0
	BD6->BD6_PERDES := 0
	BD6->BD6_TABDES := ""
	BD6->BD6_MAJORA := 0
	
	BD6->(Msunlock())
	
	//-------------------------------------------------------------------
	//Ponterando na BD7 para limpar os campos de acrescimo e decrescimo
	//-------------------------------------------------------------------
	DbSelectArea("BD7")
	DbSetOrder(1) //BD7_FILIAL+BD7_CODOPE+BD7_CODLDP+BD7_CODPEG+BD7_NUMERO+BD7_ORIMOV+BD7_SEQUEN+BD7_CODUNM+BD7_NLANC
	If DbSeek(xFilial("BD7")+BD6->(BD6_CODOPE+BD6_CODLDP+BD6_CODPEG+BD6_NUMERO+BD6_ORIMOV))
		
		cUpdBd7 := " UPDATE 																" + cEnt
		cUpdBd7 += " 	" + RetSqlName("BD7") + " BD7 										" + cEnt
		cUpdBd7 += " SET																	" + cEnt
		cUpdBd7 += " 	BD7.BD7_MAJORA = 0, 												" + cEnt
		cUpdBd7 += " 	BD7.BD7_DSCCLI = 0	 												" + cEnt
		cUpdBd7 += " WHERE 																	" + cEnt
		cUpdBd7 += " 	BD7.BD7_FILIAL = '" + xFilial("BD7") + "'  							" + cEnt
		cUpdBd7 += " 	AND BD7.BD7_CODOPE = '" + BD6->BD6_CODOPE + "' 						" + cEnt
		cUpdBd7 += " 	AND BD7.BD7_CODLDP = '" + BD6->BD6_CODLDP + "' 						" + cEnt
		cUpdBd7 += " 	AND BD7.BD7_CODPEG = '" + BD6->BD6_CODPEG + "' 						" + cEnt
		cUpdBd7 += " 	AND BD7.BD7_NUMERO = '" + BD6->BD6_NUMERO + "' 						" + cEnt
		cUpdBd7 += " 	AND BD7.BD7_ORIMOV = '" + BD6->BD6_ORIMOV + "' 						" + cEnt
		
		If TcSqlExec(cUpdBd7) < 0
			
			MsgStop("Ocorreu um erro ao tentar atualizar as linhas da guia. ")
			
		EndIf
		
	EndIf
	
	RestArea(_aArBDX)
	RestArea(_aArBD7)
	RestArea(_aArBD6)
	RestArea(_aArea	)
	
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABA005B  ºAutor  ³ Angelo Henrique    º Data ³  14/08/18   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Rotina utilizada validar se a guia entrou em conferencia    º±±
±±º          ³tendo assim que alterar os valores corretos nas tabelas.    º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function CABA005B()
	
	Local _aArea	:= GetArea()
	Local _aArBDX	:= BDX->(GetArea())
	Local _cChvBD6	:= BD6->(BD6_CODOPE+BD6_CODLDP+BD6_CODPEG+BD6_NUMERO+BD6_ORIMOV+BD6_CODPAD+BD6_CODPRO+BD6_SEQUEN)
	
	DbSelectArea("BDX")
	DbSetOrder(1) //BDX_FILIAL+BDX_CODOPE+BDX_CODLDP+BDX_CODPEG+BDX_NUMERO+BDX_ORIMOV+BDX_CODPAD+BDX_CODPRO+BDX_SEQUEN+BDX_CODGLO
	If DbSeek(xFilial("BDX") + _cChvBD6)
		
		While !EOF() .And.  BDX->(BDX_CODOPE+BDX_CODLDP+BDX_CODPEG+BDX_NUMERO+BDX_ORIMOV+BDX_CODPAD+BDX_CODPRO+BDX_SEQUEN) == _cChvBD6
			
			RecLock("BDX", .F.)
			
			BDX->BDX_VLRBPR := BD6->BD6_VLRBPR
			BDX->BDX_VLRBP2 := BD6->BD6_VLRBPR
			BDX->BDX_VLRPAG := BD6->BD6_VLRPAG
			BDX->BDX_VLRPA2 := BD6->BD6_VLRPAG
			BDX->BDX_VLRGLO := BD6->BD6_VLRGLO
			BDX->BDX_PERGLO := Round((BDX->BDX_VLRPAG / BDX->BDX_VLRMAN) * 100,2)
			BDX->BDX_VLRAPR	:= BD6->BD6_VLRAPR
			BDX->BDX_VLRAP2	:= BD6->BD6_VLRAPR
			
			If BDX->BDX_TIPREG == "1"
				
				BDX->BDX_VLRGL2 := BD6->BD6_VLRGLO
				
			EndIf
			
			BDX->(MsUnLock())
			
			BDX->(DbSkip())
			
		EndDo
		
	EndIf
	
	RestArea(_aArBDX)
	RestArea(_aArea	)
	
Return





/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABA005C  ºAutor  ³ Angelo Henrique    º Data ³  14/08/18   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Rotina utilizada para calcular os valores totais da guia    º±±
±±º          ³ TABELA BD5 ou BE4                                          º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function CABA005C()
	
	Local _aArea    := GetArea()
	Local _aArBD5   := BD5->(GetArea())
	Local _aArBE4   := BE4->(GetArea())
	Local cAliQry1	:= GetNextAlias()
	Local _cAlias	:= "BD5"
	Local cQuery	:= ""
	
	//if cTipoGuia $ G_SOL_INTER + "|" + G_RES_INTER
	If BD6->BD6_TIPGUI = "05"
		cAlias := "BE4"
	endIf
	
	cQuery := " SELECT 													" + cEnt
	cQuery += " 	BD6.BD6_CODOPE, 									" + cEnt
	cQuery += " 	BD6.BD6_CODLDP, 									" + cEnt
	cQuery += " 	BD6.BD6_CODPEG,  									" + cEnt
	cQuery += " 	BD6.BD6_NUMERO,  									" + cEnt
	cQuery += " 	BD6.BD6_ORIMOV, 									" + cEnt
	cQuery += "     SUM(BD6_VLRPAG) SOMAVLRPAG,  						" + cEnt
	cQuery += " 	SUM(BD6_VLRGLO) SOMAVLRGLO, 						" + cEnt
	cQuery += " 	SUM(BD6_VLRMAN) SOMAVLRMAN, 						" + cEnt
	cQuery += " 	SUM(BD6_VLRBPR) SOMAVLRBPR, 						" + cEnt
	cQuery += "     SUM(BD6_VLTXPG) SOMAVLTXPG, 						" + cEnt
	cQuery += " 	SUM(BD6_VLRPF)  SOMAVLRPF, 							" + cEnt
	cQuery += " 	SUM(BD6_VLRBPF) SOMAVLRBPF, 						" + cEnt
	cQuery += " 	SUM(BD6_VLRTPF) SOMAVLRTPF,							" + cEnt
	cQuery += "     SUM(BD6_VLRAPR) SOMAVLRAPR 							" + cEnt
	cQuery += " FROM 													" + cEnt
	cQuery += " 	" + RetSqlName("BD6") + " BD6 						" + cEnt
	cQuery += " WHERE 													" + cEnt
	cQuery += " 	BD6.BD6_FILIAL = '" + xFilial("BD6")  		+ "' 	" + cEnt
	cQuery += " 	AND BD6.BD6_CODOPE = '" + BD6->BD6_CODOPE 	+ "' 	" + cEnt
	cQuery += " 	AND BD6.BD6_CODLDP = '" + BD6->BD6_CODLDP  	+ "' 	" + cEnt
	cQuery += " 	AND BD6.BD6_CODPEG = '" + BD6->BD6_CODPEG  	+ "' 	" + cEnt
	cQuery += " 	AND BD6.BD6_NUMERO = '" + BD6->BD6_NUMERO  	+ "' 	" + cEnt
	cQuery += " 	AND BD6.BD6_ORIMOV = '" + BD6->BD6_ORIMOV	+ "' 	" + cEnt
	cQuery += " 	AND BD6.D_E_L_E_T_  = ' ' 							" + cEnt
	cQuery += " GROUP BY 												" + cEnt
	cQuery += " 	BD6.BD6_CODOPE, 									" + cEnt
	cQuery += " 	BD6.BD6_CODLDP, 									" + cEnt
	cQuery += " 	BD6.BD6_CODPEG,  									" + cEnt
	cQuery += " 	BD6.BD6_NUMERO,  									" + cEnt
	cQuery += " 	BD6.BD6_ORIMOV 										" + cEnt
	
	If Select(cAliQry1)>0
		(cAliQry1)->(DbCloseArea())
	EndIf
	
	DbUseArea(.T.,"TopConn",TcGenQry(,,cQuery),cAliQry1,.T.,.T.)
	
	DbSelectArea(cAliQry1)
	
	If !((cAliQry1)->(Eof()))
		
		DbSelectArea(_cAlias)
		DbSetOrder(1)
		If DbSeek( xFilial(_cAlias) + BD6->(BD6_CODOPE + BD6_CODLDP + BD6_CODPEG + BD6_NUMERO))
			
			RecLock(_cAlias,.F.)
			
			(_cAlias)->&( _cAlias + "_VLRBPR" ) := (cAliQry1)->SOMAVLRBPR
			(_cAlias)->&( _cAlias + "_VLRMAN" ) := (cAliQry1)->SOMAVLRMAN
			(_cAlias)->&( _cAlias + "_VLRGLO" ) := (cAliQry1)->SOMAVLRGLO
			(_cAlias)->&( _cAlias + "_VLRPAG" ) := (cAliQry1)->SOMAVLRPAG
			(_cAlias)->&( _cAlias + "_VLRAPR" ) := (cAliQry1)->SOMAVLRAPR
			(_cAlias)->&( _cAlias + "_VLRBPF" ) := (cAliQry1)->SOMAVLRBPF
			(_cAlias)->&( _cAlias + "_VLRTPF" ) := (cAliQry1)->SOMAVLRTPF
			(_cAlias)->&( _cAlias + "_VLRPF"  ) := (cAliQry1)->SOMAVLRPF
			
			(_cAlias)->( MsUnLock())
			
		EndIf
		
	EndIf
	
	If Select(cAliQry1)>0
		(cAliQry1)->(DbCloseArea())
	EndIf
	
	RestArea(_aArBE4)
	RestArea(_aArBD5)
	RestArea(_aArea	)
	
Return



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABA005D  ºAutor  ³ Angelo Henrique    º Data ³  21/09/18   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Rotina utilizada para atualizar a BD6.                      º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function CABA005D(_cParam)
	
	Local _aArea 	:= GetArea()
	Local _aArBD6 	:= BD6->(GetArea())
	Local _aArBD7 	:= BD7->(GetArea())
	Local _lRet 	:= .F.
	
	Default _cParam	:= "1"
	
	BD6->(DbGoTop())
	DbSelectArea("BD6")
	DbSetOrder(1) //BD6_FILIAL+BD6_CODOPE+BD6_CODLDP+BD6_CODPEG+BD6_NUMERO+BD6_ORIMOV+BD6_SEQUEN+BD6_CODPAD+BD6_CODPRO
	If DbSeek(xFilial("BD6") + (cAliQry1)->(BD6_CODOPE + BD6_CODLDP + BD6_CODPEG + BD6_NUMERO + BD6_ORIMOV + BD6_SEQUEN + BD6_CODPAD + BD6_CODPRO) )
		
		If _cParam	== "1"
			
			RecLock("BD6", .F.)
			
			//---------------------------------------------------------------------------
			//Se o valor apresentado é maior que o valor pago existirá a glosa
			//---------------------------------------------------------------------------
			If (BD6->BD6_VLRAPR * BD6->BD6_QTDPRO) > _nVlrCalc
				
				BD6->BD6_VLRGLO :=  (BD6->BD6_VLRAPR * BD6->BD6_QTDPRO) - _nVlrCalc
				
			ElseIf BD6->BD6_VLRGLO > 0
				
				BD6->BD6_VLRGLO := 0 //Zerando a glosa efetuada pelo padrão
				
			EndIf
			
			BD6->BD6_VLRMAN := (BD6->BD6_VLRAPR * BD6->BD6_QTDPRO)	
			
			//-----------------------------------------------------
			//Valor do desconto
			//-----------------------------------------------------
			If _nVlrDsc > 0
				
				BD6->BD6_VLRDES := ((_nClcDsc * _nVlrDsc) /100) * BD6->BD6_QTDPRO //Valor do Desconto na BD6
				
			EndIf
			
			BD6->BD6_VLRPAG := _nVlrCalc
			BD6->BD6_VLRBPF := _nVlrCalc
			BD6->BD6_VLRBPR := _nVlrCont //Valor contratado atualizado
			BD6->BD6_VLRPF	:= (BD6->BD6_VLRPAG * BD6->BD6_PERCOP) /100
			BD6->BD6_VLRTPF := (BD6->BD6_VLRPAG * BD6->BD6_PERCOP) /100
			BD6->BD6_VLRTAD := (BD6->BD6_VLRPAG * BD6->BD6_PERTAD) /100
			BD6->BD6_PERDES := _nVlrDsc
			BD6->BD6_TABDES := "BC6"
			BD6->BD6_MAJORA := _nVlrMaj
			
			BD6->(MsUnLock())
			
			_lRet := .T.
			
		ElseIf _cParam	== "2"
			
			DbSelectArea("BD7")
			DbSetOrder(1) //BD7_FILIAL+BD7_CODOPE+BD7_CODLDP+BD7_CODPEG+BD7_NUMERO+BD7_ORIMOV
			If DbSeek(c_ChavBD7 + (cAliQry1)->BD6_SEQUEN )
				While !EOF() .And. BD7->(BD7_FILIAL+BD7_CODOPE+BD7_CODLDP+BD7_CODPEG+BD7_NUMERO+BD7_ORIMOV+BD7_SEQUEN) == c_ChavBD7 + (cAliQry1)->BD6_SEQUEN
					
					_nVlAnt := BD7->BD7_VLRPAG
					
					RecLock("BD7", .F.)
					
					If (BD6->BD6_VLRAPR * BD6->BD6_QTDPRO) < _nVlrCont
						
						BD7->BD7_VLRPAG := ((BD6->BD6_VLRAPR * BD6->BD6_QTDPRO) * BD7->BD7_PERCEN) / 100
						BD7->BD7_VLRMAN := ((BD6->BD6_VLRAPR * BD6->BD6_QTDPRO) * BD7->BD7_PERCEN) / 100
						
					Else
						
						BD7->BD7_VLRPAG := (_nVlrCont * BD7->BD7_PERCEN) / 100
						BD7->BD7_VLRMAN := (_nVlrCont * BD7->BD7_PERCEN) / 100
						BD7->BD7_VLRGLO := BD7->BD7_VLRMAN - BD7->BD7_VLRPAG
						
					EndIf
					
					BD7->(MsUnLock())
					
					_nVlrFin 	:= _nVlAnt - BD7->BD7_VLRPAG
					_nVlrCalc 	:= _nVlrCalc - _nVlrFin
					
					BD7->(DbSkip())
					
				EndDo
				
			EndIf
			
			RecLock("BD6", .F.)
			
			//---------------------------------------------------------------------------
			//Se o valor apresentado é maior que o valor pago existirá a glosa
			//---------------------------------------------------------------------------
			If (BD6->BD6_VLRAPR * BD6->BD6_QTDPRO) > _nVlrCalc
				
				BD6->BD6_VLRGLO :=  (BD6->BD6_VLRAPR * BD6->BD6_QTDPRO) - _nVlrCalc
				
			EndIf
			
			BD6->BD6_VLRMAN := (BD6->BD6_VLRAPR * BD6->BD6_QTDPRO)	
			
			BD6->BD6_VLRPAG := _nVlrCalc //Valor Pago
			BD6->BD6_VLRBPF := _nVlrCalc
			BD6->BD6_VLRBPR := _nVlrCont //Valor Contratado
			BD6->BD6_VLRPF	:= (BD6->BD6_VLRPAG * BD6->BD6_PERCOP) /100
			BD6->BD6_VLRTPF := ((BD6->BD6_VLRPAG * BD6->BD6_PERCOP) /100) + BD6->BD6_VLRTAD
			BD6->BD6_VLRTAD := (BD6->BD6_VLRPAG * BD6->BD6_PERTAD) /100
			
			BD6->(MsUnLock())
			
			_lRet := .T.
			
		ElseIf _cParam	== "3"
			
			RecLock("BD6", .F.)
			
			//---------------------------------------------------------------------------
			//Se o valor apresentado é maior que o valor pago existirá a glosa
			//---------------------------------------------------------------------------
			If (BD6->BD6_VLRAPR * BD6->BD6_QTDPRO) > _nVlrCalc
				
				BD6->BD6_VLRGLO :=  (BD6->BD6_VLRAPR * BD6->BD6_QTDPRO) - _nVlrCalc
				
			EndIf																
					
			BD6->BD6_VLRMAN := (BD6->BD6_VLRAPR * BD6->BD6_QTDPRO)			
			
			BD6->BD6_VLRPAG := _nVlrCalc //Valor Pago
			BD6->BD6_VLRBPF := _nVlrCalc
			BD6->BD6_VLRBPR := _nVlrCont //Valor Contratado
			BD6->BD6_VLRPF	:= (BD6->BD6_VLRPAG * BD6->BD6_PERCOP) /100
			BD6->BD6_VLRTPF := ((BD6->BD6_VLRPAG * BD6->BD6_PERCOP) /100) + BD6->BD6_VLRTAD
			BD6->BD6_VLRTAD := (BD6->BD6_VLRPAG * BD6->BD6_PERTAD) /100
			
			BD6->(MsUnLock())
			
			_lRet := .T.
			
		EndIf
		
		//--------------------------------------------------------------------------
		//Caso tenha realizado a atualização da BD¨6, necessário validar se
		//entrou em conferência, necessitando validar a tabela BDX
		//--------------------------------------------------------------------------
		If _lRet
			
			//----------------------------------------------------------------------
			//Validando se entrou em glosas, irá chamar rotina para atualizar
			//corretamente os valores de glosa
			//----------------------------------------------------------------------
			If BD6->BD6_FASE = "2" //Conferência
				
				U_CABA005B()
				
			EndIf
			
		EndIf
		
	EndIf
	
	RestArea(_aArBD7)
	RestArea(_aArBD6)
	RestArea(_aArea	)
	
Return _lRet