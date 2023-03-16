#INCLUDE "RWMAKE.CH"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "TOPCONN.CH"
#INCLUDE "FONT.CH"
#INCLUDE "TBICONN.CH"

#DEFINE cEnt CHR(13) + CHR(10)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABA020   ºAutor  ³Angelo Henrique     º Data ³  08/10/18   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Usado para criar protocolos para as liberações da operativa º±±
±±º          ³que não possuem protocolo de atendimento. (SCHEDULE)        º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³CABERJ                                                      º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function CABA020()
	
	Local _ni := 0
	
	QOut("CABA020 - Iniciando geração de protocolos")
	
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
			QOut("CABA020 - Executando CABA020A pela CABERJ")
			
			U_CABA020A()
						
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
			QOut("CABA020 - Executando CABA020A pela INTEGRAL")
			U_CABA020A()
			
		EndIf
		
	Next _ni
	
	QOut("CABA020 - Processo de Geração de Protocolos da Operativa Fiunalizado")
	
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABA020A  ºAutor  ³Angelo Henrique     º Data ³  08/10/18   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Usado para criar protocolos para as liberações da operativa º±±
±±º          ³que não possuem protocolo de atendimento.                   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³CABERJ                                                      º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function CABA020A
	
	Local _aArea 		:= GetArea()
	Local _aArBEA		:= BEA->(GetArea())
	Local _aArSZX		:= SZX->(GetArea())
	Local _aArSZY		:= SZY->(GetArea())
	Local _aArB1 		:= BA1->(GetArea())
	Local _aArBI 		:= BI3->(GetArea())
	Local _aArCG 		:= PCG->(GetArea())
	Local _aArBL 		:= PBL->(GetArea())
	Local _cQuery		:= ""
	Local _nSla 		:= 0
	Local _cSeq			:= ""
	Local _cCdAre		:= ""
	Local _cDsAre		:= ""
	Local _cTpSv		:= "1036"
	Local _cHst 		:= "000015" //Entrada de Pedido
	Local _cTpDm		:= "T" 		//Solicitação (SX5) Tipo da Demanda
	Local _cCanal		:= "000025" //SITE
	
	Private _cAlias1	:= GetNextAlias()
	
	_cQuery := " SELECT												" + cEnt
	_cQuery += "     BEA.BEA_USUOPE,								" + cEnt
	_cQuery += "     BEA.BEA_XPROTC,								" + cEnt
	_cQuery += "     BEA.BEA_OPEMOV,								" + cEnt
	_cQuery += "     BEA.BEA_ANOAUT,								" + cEnt
	_cQuery += "     BEA.BEA_MESAUT,								" + cEnt
	_cQuery += "     BEA.BEA_NUMAUT,								" + cEnt
	_cQuery += "     BEA.BEA_DTDIGI,								" + cEnt
	_cQuery += "     SUBSTR(BEA.BEA_HHDIGI,1,4) BEA_HHDIGI,			" + cEnt
	_cQuery += "     BEA.BEA_TIPADM,								" + cEnt
	_cQuery += "     BEA.BEA_NOMUSR,								" + cEnt
	_cQuery += "     BEA.BEA_CODEMP,								" + cEnt
	_cQuery += "     BEA.BEA_MATRIC,								" + cEnt
	_cQuery += "     BEA.BEA_TIPREG,								" + cEnt
	_cQuery += "     BEA.BEA_DIGITO,								" + cEnt
	_cQuery += "     BEA.BEA_DATNAS,								" + cEnt
	_cQuery += "     BEA.BEA_DESOPE,					    		" + cEnt
	_cQuery += "     BEA.BEA_CODRDA						    		" + cEnt
	_cQuery += " FROM						                		" + cEnt
	_cQuery += " 	" + RetSqlName("BEA") + " BEA 					" + cEnt
	_cQuery += " WHERE						                		" + cEnt
	_cQuery += "     BEA.BEA_XPROTC = ' '							" + cEnt
	_cQuery += "     AND BEA.BEA_FILIAL = '" + xFilial("BEA") + " '	" + cEnt
	_cQuery += "     AND BEA.BEA_USUOPE = 'OPERAT'          		" + cEnt
	_cQuery += "     AND BEA.BEA_TIPO = '2'			        		" + cEnt
	_cQuery += "     AND BEA.BEA_OPEMOV = '0001'	        		" + cEnt
	_cQuery += "     AND BEA.D_E_L_E_T_ = ' '               		" + cEnt
	_cQuery += " ORDER BY BEA.BEA_DTDIGI                    		" + cEnt
	
	If Select(_cAlias1) > 0
		(_cAlias1)->(DbCloseArea())
	EndIf
	
	PLSQuery(_cQuery,_cAlias1)
	
	While !(_cAlias1)->(EOF())
		
		//--------------------------------------------------------------------------------------------
		//Pegar o ultimo registro criado do protocolo, somar mais um para os q não são do dia atual
		//--------------------------------------------------------------------------------------------
		If dDataBase <> (_cAlias1)->BEA_DTDIGI
			
			_cSeq 	:= CRIAZP1()
			
		Else
			
			_cSeq 	:= U_GERNUMPA()
			
		EndIf
		
		If !Empty(_cSeq)
			
			DbSelectArea("BA1")
			DbSetOrder(2) //BA1_FILIAL+BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG+BA1_DIGITO
			If DbSeek(xFilial("BA1") + (_cAlias1)->(BEA_OPEMOV + BEA_CODEMP + BEA_MATRIC + BEA_TIPREG + BEA_DIGITO))
				
				_cTpSv	:= IIF((_cAlias1)->BEA_TIPADM $ '4|5',"1016","1036") //BE4_TIPADM = 4 ou 5 (emergência ou urgência)
				
				//------------------------------------------
				//Pegando a quantidade de SLA
				//------------------------------------------
				DbSelectArea("PCG")
				DbSetOrder(1)
				If DbSeek(xFilial("PCG") + PADR(AllTrim(_cTpDm),TAMSX3("PCG_CDDEMA")[1]) + "000006" + _cCanal + PADR(AllTrim(_cTpSv),TAMSX3("PCG_CDSERV")[1]) )
					
					_nSla := PCG->PCG_QTDSLA
					
				Else
					
					_nSla := 0
					
				EndIf
				
				//----------------------------------------------
				//Ponterar na Tabela de PBL (Tipo de Serviço)
				//Pegando assim a Area
				//----------------------------------------------
				DbSelectArea("PBL")
				DbSetOrder(1)
				If DbSeek(xFilial("PBL") + PADR(AllTrim(_cTpSv),TAMSX3("PBL_YCDSRV")[1]))
					
					_cCdAre := PBL->PBL_AREA
					_cDsAre := PBL->PBL_YDEPTO
					
				EndIf
				
				//-----------------------------------------------------------
				//Inicio da gravação do protocolo de atendimento
				//-----------------------------------------------------------
				DbSelectArea("SZX")
				DbSetOrder(1)
				lAchou := DbSeek(xFilial("SZX") + _cSeq)
				
				RecLock("SZX",!lAchou)
				
				SZX->ZX_FILIAL 	:= xFilial("SZX")
				SZX->ZX_SEQ 	:= _cSeq
				SZX->ZX_DATDE 	:= (_cAlias1)->BEA_DTDIGI
				SZX->ZX_HORADE 	:= (_cAlias1)->BEA_HHDIGI
				SZX->ZX_DATATE 	:= (_cAlias1)->BEA_DTDIGI
				SZX->ZX_HORATE 	:= (_cAlias1)->BEA_HHDIGI
				SZX->ZX_NOMUSR 	:= BA1->BA1_NOMUSR
				SZX->ZX_CODINT 	:= BA1->BA1_CODINT
				SZX->ZX_CODEMP 	:= BA1->BA1_CODEMP
				SZX->ZX_MATRIC 	:= BA1->BA1_MATRIC
				SZX->ZX_TIPREG 	:= BA1->BA1_TIPREG
				SZX->ZX_DIGITO 	:= BA1->BA1_DIGITO
				SZX->ZX_CPFUSR	:= BA1->BA1_CPFUSR
				SZX->ZX_TPINTEL	:= "2" 		//Status Encerrado
				SZX->ZX_YDTNASC	:= (_cAlias1)->BEA_DATNAS
				SZX->ZX_EMAIL 	:= BA1->BA1_EMAIL
				SZX->ZX_CONTATO	:= ""
				SZX->ZX_YPLANO 	:= POSICIONE("BI3",1,BA1->(BA1_FILIAL+BA1_CODINT+BA1_CODPLA+BA1_VERSAO),"BI3_CODIGO+' '+BI3_DESCRI")
				SZX->ZX_TPDEM	:= _cTpDm 	//Tipo de Demanda
				SZX->ZX_CANAL	:= _cCanal
				SZX->ZX_SLA  	:= _nSla	//SLA
				SZX->ZX_PTENT 	:= "000012" //Porta de Entrada = web
				SZX->ZX_CODAREA := _cCdAre	//Codigo da Area
				SZX->ZX_YAGENC  := _cDsAre	//Descrição da Area
				SZX->ZX_VATEND	:= "3"    	//Seguindo o protocolo anterior (Novo PA não utiliza este campo)
				SZX->ZX_TPATEND := "1" 		//At. CABERJ
				SZX->ZX_USDIGIT	:= (_cAlias1)->BEA_DESOPE //Usuário Digitador
				SZX->ZX_RDA		:= (_cAlias1)->BEA_CODRDA //Prestador
				
				// FRED: equalizado os campos
				//If cEmpAnt = "01"
					SZX->ZX_YDTINC	:= (_cAlias1)->BEA_DTDIGI
				/*	
				Else
					SZX->ZX_YDTINIC	:= (_cAlias1)->BEA_DTDIGI
				EndIf
				*/
				// FRED: fim alteração
				
				SZX->(MsUnLock())
				
				//----------------------------------------------------------
				//Gravando as linhas do protocolo de atendimento
				//----------------------------------------------------------
				DbSelectArea("SZY")
				DbSetOrder(1)
				lAchou := DbSeek(xFilial("SZY") + _cSeq)
				
				RecLock("SZY",!lAchou)
				
				SZY->ZY_FILIAL 	:= xFilial("SZY")
				SZY->ZY_SEQBA	:= _cSeq
				SZY->ZY_SEQSERV	:= "000001"
				SZY->ZY_DTSERV	:= (_cAlias1)->BEA_DTDIGI
				SZY->ZY_HORASV	:= (_cAlias1)->BEA_HHDIGI
				SZY->ZY_TIPOSV	:= _cTpSv
				SZY->ZY_OBS		:= "Protocolo referente a liberacao : " + (_cAlias1)->(BEA_OPEMOV + BEA_ANOAUT + BEA_MESAUT + BEA_NUMAUT)
				SZY->ZY_RESPOST := "Protocolo gerado de forma automatica pelo sistema, origem OPERATIVA."
				SZY->ZY_HISTPAD	:= _cHst
				SZY->ZY_USDIGIT	:= (_cAlias1)->BEA_DESOPE //Usuário Digitador
				
				SZY->(MsUnLock())
				
				//--------------------------------------------------------------
				//Atualizando a tabela de liberação BEA
				//--------------------------------------------------------------
				DbSelectArea("BEA")
				DbSetOrder(1) //BEA_FILIAL+BEA_OPEMOV+BEA_ANOAUT+BEA_MESAUT+BEA_NUMAUT+DTOS(BEA_DATPRO)+BEA_HORPRO
				If DBSeek(xFilial("BEA") + (_cAlias1)->(BEA_OPEMOV + BEA_ANOAUT + BEA_MESAUT + BEA_NUMAUT))
					
					While !BEA->(EOF()) .And. Empty(BEA->BEA_XPROTC) .And. (_cAlias1)->(BEA_OPEMOV + BEA_ANOAUT + BEA_MESAUT + BEA_NUMAUT) == BEA->(BEA_OPEMOV + BEA_ANOAUT + BEA_MESAUT + BEA_NUMAUT)
					
						RecLock("BEA", .F.)
					
						BEA->BEA_XPROTC := _cSeq
					
						BEA->(MsUnLock())
					
						BEA->(DbSkip())
					
					EndDo
					
				EndIf
				
			EndIf
			
		EndIf
		
		(_cAlias1)->(DbSkip())
		
	EndDo
	
	If Select(_cAlias1) > 0
		(_cAlias1)->(DbCloseArea())
	EndIf
	
	//Aviso("ATENÇÃO","Atualização de liberação x protocolo finalizada",{"OK"})	
	
	RestArea(_aArBL	)
	RestArea(_aArCG	)
	RestArea(_aArBI	)
	RestArea(_aArB1	)
	RestArea(_aArSZY)
	RestArea(_aArSZX)
	RestArea(_aArBEA)
	RestArea(_aArea	)
	
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CRIAZXOP1 ºAutor  ³Angelo Henrique     º Data ³    /  /     º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Usado para pegar o tulimo protocolo criado e somar mais um  º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³CABERJ                                                      º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function CRIAZP1()
	
	Local _cQuery		:= ""
	Local _cRet			:= ""
	
	Private _cAlias2	:= GetNextAlias()
	
	_cQuery	:= " SELECT														" + cEnt
	_cQuery	+= " 	MAX(SZX.ZX_SEQ) TOTAL									" + cEnt
	_cQuery	+= " FROM														" + cEnt
	_cQuery += " 	" + RetSqlName("SZX") + " SZX 							" + cEnt
	_cQuery	+= " WHERE														" + cEnt
	_cQuery	+= " 	SZX.ZX_DATDE = '" + DTOS((_cAlias1)->BEA_DTDIGI) + "'	" + cEnt
	
	If Select(_cAlias2) > 0
		(_cAlias2)->(DbCloseArea())
	EndIf
	
	PLSQuery(_cQuery,_cAlias2)
	
	If !(_cAlias2)->(EOF())
		
		_cRet := SOMA1((_cAlias2)->TOTAL)
		
	EndIf
	
	If Select(_cAlias2) > 0
		(_cAlias2)->(DbCloseArea())
	EndIf
	
Return _cRet
