#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'TOPCONN.CH'

//⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø
//≥Leonardo Portella - 18/09/13                                              ≥
//≥Virada P11 - Rotina da P10 padrao conforme documento mostrado pela Marcia ≥
//≥deve ficar sob controle da Caberj. Transformando em User Function para que≥
//≥seja possivel dar  manutencao.                                            ≥
//≥A rotina nao existe no padrao da P11 e nao existia no padrao da P10.      |
//≥Incluida na P10 por meio de patch feito pela Totvs SP.                    |
//¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ

//-------------------------------------------------------------------
/*/{Protheus.doc} 
Rotina Bloqueio Pagto Rda

@author Luciano Aparecido
@since 10/11/2010
@version P10
/*/
//-------------------------------------------------------------------

User Function PLSMVC01()

Local cAlias		:= 'B36'

Private cCadastro 	:= "Bloqueio de Pagamento de RDA"
Private aRotina 	:= MenuDef()
Private aCores		:= {}
Private aDadBD7		:= {}
Private aRecBD7  	:= {}		

aAdd(aRotina,{"Legenda" 	,"U_LegB36" ,0,3})

aAdd(aCores,{"B36_STATUS == '1'", "BR_AMARELO"		})
aAdd(aCores,{"B36_STATUS == '2'", "BR_VERMELHO"		})
aAdd(aCores,{"B36_STATUS == '3'", "BR_LARANJA"		})
aAdd(aCores,{"B36_STATUS == '4'", "BR_VERDE"		})

CriaSX1()

DbSelectArea(cAlias)
DbSetOrder(1)
DbGoTop()

mBrowse(6,1,22,75,cAlias,,,,,2,aCores)

Return

****************************************************************************************************************************************************

Static Function MenuDef()

Local aRotina  	:= {}
Local aSubRot1 	:= {}
Local aSubRot2 	:= {} 
//1-Bloqueio Pendente;2-Bloqueio Processado;3-DesBloqueio Pendente;4-DesBloqueio Processado
Local cExprVisB	:= 'If(B36->B36_STATUS $ "1,2",AxVisual("B37",B37->(RECNO()),2),MsgStop("Lote se refere a DESbloqueio"))'
Local cExprVisD	:= 'If(B36->B36_STATUS $ "3,4",AxVisual("B37",B37->(RECNO()),2),MsgStop("Lote se refere a BLOQUEIO"))'

B37->(DbSetOrder(1))
B37->(MsSeek(xFilial('B37') + B36->B36_CODOPE + B36->B36_NUMLOT))

//aAdd(aSubRot1,{'Visualizar' 		,cExprVisB	,2,0})
aAdd(aSubRot1,{'Incluir'   			,'U_INCLTB'	,3,0}) 
aAdd(aSubRot1,{'Total Lote Bloq.'  	,'U_TOTLTB'	,3,0}) 

//aAdd(aSubRot2,{'Visualizar' 		,cExprVisD	,2,0})
aAdd(aSubRot2,{'Incluir'   			,'U_INCLTD'	,3,0}) 
aAdd(aSubRot2,{'Total Lote Desb.'  	,'U_TOTLTD'	,3,0}) 

aAdd(aRotina,{'Pesquisar'  			,'AxPesqui'	,1,0})
aAdd(aRotina,{'Lote Bloqueio'   	,aSubRot1 	,3,0}) 
aAdd(aRotina,{'Lote DesBloqueio'	,aSubRot2 	,3,0}) 

Return aRotina

***********************************************************************************************************************************************************************

User Function TOTLTB  

Processa({||PTOTLTB()},'Lote de bloqueio')

***********************************************************************************************************************************************************************

Static Function PTOTLTB

Local nI := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

Local cAliasB36 := GetNextAlias()
Local cQry
Local cCodRDA

If !( B36->B36_STATUS $ "1,2" )//1-Bloqueio Pendente;2-Bloqueio Processado;3-DesBloqueio Pendente;4-DesBloqueio Processado  
	MsgStop('Lote È de DESbloqueio. OpÁ„o disponÌvel apenas para lote de bloqueio!',AllTrim(SM0->M0_NOMECOM)) 
	Return
EndIf

ProcRegua(0)

For nI := 1 to 5
	IncProc('Totalizando lote de bloqueio')
Next

cQry := "SELECT BD7_CODRDA,SUM(BD7_VLRPAG) VLR_LIB"		  				+ CRLF
cQry += "FROM " + RetSqlName('BD7') + " VALOR_LIB"						+ CRLF
cQry += "WHERE BD7_FILIAL = '" + xFilial('BD7') + "'"  					+ CRLF
cQry += "  AND BD7_LOTBLO = '" + B36->B36_NUMLOT + "'" 					+ CRLF
cQry += "  AND D_E_L_E_T_ = ' '" 										+ CRLF
cQry += "GROUP BY BD7_CODRDA" 		  									+ CRLF

TcQuery cQry New Alias cAliasB36

If cAliasB36->(EOF())
	
	cAliasB36->(DbCloseArea())
	
	cQry := "SELECT B37_NUMLOT,B37_CODRDA,B37_LOTDES,B37_NUMLOT,B37_LOTDES,B37_VLRBLO VLR_LIB"	+ CRLF
	cQry += "FROM " + RetSqlName('B37') + " VALOR_LIB"					 						+ CRLF
	cQry += "WHERE B37_FILIAL = '" + xFilial('B37') + "'"  			  							+ CRLF
	cQry += "  AND B37_LOTDES = '" + B36->B36_NUMLOT + "'" 				 						+ CRLF
	cQry += "  AND D_E_L_E_T_ = ' '" 									 						+ CRLF
	
	cAliasB36 := GetNextAlias()
		
	TcQuery cQry New Alias cAliasB36

	If cAliasB36->(EOF())
		MsgAlert('N„o h· valor bloqueado neste lote de bloqueio!',AllTrim(SM0->M0_NOMECOM))	
	Else
		//B37_LOTDES : ID DO LOTE DE DESBLOQUEIO - REFERENCIA COM O B36_NUMLOT
		//B37_NUMLOT : DESBLOQUEIA O LOTE DE BLOQUEIO COM NUMERO B37_NUMLOT
	
		MsgInfo(	'N„o h· valor bloqueado neste lote de bloqueio!' + CRLF + ;
					'Lote de desbloqueio [ ' + cAliasB36->B37_NUMLOT + ' ] referente ao lote de bloqueio [ ' + cAliasB36->B37_LOTDES + ' ]' + CRLF + ;
					'RDA [ ' + cAliasB36->B37_CODRDA + ' ]' + CRLF + ; 
					'Valor desbloqueado [ R$ ' + AllTrim(Transform(cAliasB36->VLR_LIB,'@E 999,999,999.99')) + ' ]',AllTrim(SM0->M0_NOMECOM))
	EndIf
		
	cAliasB36->(DbCloseArea())

Else
	cCodRDA := cAliasB36->BD7_CODRDA	
	nVlrLib := cAliasB36->VLR_LIB
	
	MsgInfo('Lote de bloqueio [ ' + B36->B36_NUMLOT + ' ] RDA [ ' + cCodRDA + ' ] Valor [ R$ ' + AllTrim(Transform(nVlrLib,'@E 999,999,999.99')) + ' ]',AllTrim(SM0->M0_NOMECOM))
	
	cAliasB36->(DbCloseArea())
EndIf
	
Return

***********************************************************************************************************************************************************************

User Function TOTLTD  

Processa({||PTOTLTD()},'Lote de desbloqueio')

***********************************************************************************************************************************************************************

Static Function PTOTLTD

Local nI := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

Local cAliasB36 := GetNextAlias()
Local cQry

If !( B36->B36_STATUS $ "3,4" )//1-Bloqueio Pendente;2-Bloqueio Processado;3-DesBloqueio Pendente;4-DesBloqueio Processado  
	MsgStop('Lote È de bloqueio. OpÁ„o disponÌvel apenas para lote de DESbloqueio!',AllTrim(SM0->M0_NOMECOM)) 
	Return
EndIf

ProcRegua(0)

For nI := 1 to 5
	IncProc('Totalizando lote de desbloqueio')
Next

cQry := "SELECT B37_CODRDA,B37_LOTDES,B37_NUMLOT,B37_LOTDES,SUM(B37_VLRBLO) VLR_LIB"	+ CRLF
cQry += "FROM " + RetSqlName('B37') + " VALOR_LIB"		   	   		  					+ CRLF
cQry += "WHERE B37_FILIAL = '" + xFilial('B37') + "'"  	  	   			  				+ CRLF
cQry += "  AND B37_NUMLOT = '" + B36->B36_NUMLOT + "'" 	  	   							+ CRLF
cQry += "  AND D_E_L_E_T_ = ' '" 						  	  		   					+ CRLF
cQry += "GROUP BY B37_CODRDA,B37_NUMLOT,B37_LOTDES" 		  		   					+ CRLF

TcQuery cQry New Alias cAliasB36

If cAliasB36->(EOF())
	MsgAlert(	'Lote de desbloqueio foi incluÌdo na vers„o 10, quando n„o existia este log!' + CRLF + ;
				'N„o ser· possÌvel exibir o total deste lote de desbloqueio.',AllTrim(SM0->M0_NOMECOM))	
Else
	//B37_LOTDES : ID DO LOTE DE DESBLOQUEIO - REFERENCIA COM O B36_NUMLOT
	//B37_NUMLOT : DESBLOQUEIA O LOTE DE BLOQUEIO COM NUMERO B37_NUMLOT

	MsgInfo(	'Lote de desbloqueio [ ' + cAliasB36->B37_NUMLOT + ' ] referente ao lote de bloqueio [ ' + cAliasB36->B37_LOTDES + ' ]' + CRLF + ;
				'RDA [ ' + cAliasB36->B37_CODRDA + ' ]' + CRLF + ; 
				'Valor desbloqueado [ R$ ' + AllTrim(Transform(cAliasB36->VLR_LIB,'@E 999,999,999.99')) + ' ]',AllTrim(SM0->M0_NOMECOM))
EndIf

cAliasB36->(DbCloseArea())
	
Return

***********************************************************************************************************************************************************************

User Function INCLTB

Local lRet 		:= Pergunte("PLMVC01",.T.)
Local aArea
Local nI   		:= 0
Local cQry		:= ''
Local cAliasB36	:= GetNextAlias()
Local cNextLot	:= ''

Private aDadProc	:= {}

If lRet

	If LockByName('PLMVC01')
        
		aArea 	:= GetArea()
		
		aDadBD7 := {}
		aRecBD7 := {} 
		
		cQry := "SELECT NVL(TO_NUMBER(MAX(B36_NUMLOT)),0) + 1 LOTE"	+ CRLF
		cQry += "FROM " + RetSqlName('B36') 						+ CRLF
		cQry += "WHERE B36_FILIAL = '" + xFilial('B36') + "'" 		+ CRLF		
		cQry += "  AND D_E_L_E_T_ = ' '" 							+ CRLF			
		
		TcQuery cQry New Alias cAliasB36
		
		cNextLot := StrZero(cAliasB36->LOTE,TamSx3('B36_NUMLOT')[1])
		
		cAliasB36->(DbCloseArea())
		
		Processa({||PLMV01VPRO() },"Inclus„o de lote de bloqueio", "", .T.)
			 
		If Len(aDadBD7) == 0
			lRet:=.F.
			Help(,,'HELP',,'Com a parametrizacao informada n„o retornou nenhum dado!',1,0)
		ElseIf len(aDadProc) == 0
				Aviso("AtenÁ„o","N„o foram selecionados itens para processar.",{"Ok"},1)
				lRet := .F.
		Else
			If PLSCRIGEN(aDadProc,	{ ;
										{"COD RDA","@C",10},;
										{"NOME","@C",100 },;
										{"GUIA","@C",60 },;
										{"UNIDADE","@C",03 },;
										{"VLR BASE PAGTO","@E 999,999,999.99",17 },;
										{"VLR PAGTO","@E 999,999,999.99",17 },;
										{"VLR GLOSA","@E 999,999,999.99",17 },;
										{"VLR BLOQUEIO","@E 999,999,999.99",17 },;
										{"MES/ANO PAG","@C",17 };
									},"Itens Selecionados",nil,nil,nil,nil,nil,nil,"G",220)[1] 
									
				If Aviso("AtenÁ„o","Deseja confirmar o processamento do lote: "+cNextLot+" ?",{"Sim","N„o"},1) == 1
					PLGRV01PRO(aDadProc,cNextLot)	
				EndIf
				
			EndIf 
			                   
		EndIf
		
		UnLockByName('PLMVC01')
	    
		RestArea(aArea)
		
	Else
		MsgStop('Rotina est· sendo usada por outro usu·rio!',AllTrim(SM0->M0_NOMECOM))
	EndIf
		 
EndIf

Return

***********************************************************************************************************************************************************************

Static Function PLGRV01PRO(aDadProc,cNumLot)

Local aArea 		:= GetArea()
Local nI 			:= 0        
Local nJ			:= 0
Local nVlrBloq		:= 0
Local cCodRDA
Local cNomRDA

If len(aDadProc) > 0

	Begin Transaction	
	        
	    B36->(RecLock("B36",.T.)) 
		
		B36->B36_FILIAL := xFilial('B36')
		B36->B36_CODOPE := PLSINTPAD()
		B36->B36_ANOLDE := mv_par05
		B36->B36_ANOLAT := mv_par06
		B36->B36_MESLDE := mv_par07
		B36->B36_MESLAT := mv_par08
		B36->B36_DTDIGI := Date()
		B36->B36_HRDIGI := StrTran(Time(),":","")
		B36->B36_OPESIS := RetCodUsr()
		B36->B36_NOMOPE := PLRETOPE()                               
		B36->B36_NUMLOT	:= cNumLot
		B36->B36_DTPROC := Date()
		B36->B36_HRPROC := StrTran(Time(),":","")
		B36->B36_OPEPRO := RetCodUsr()
		B36->B36_NOMPRO := PLRETOPE()      
		B36->B36_STATUS := "2" //1-Bloqueio Pendente;2-Bloqueio Processado;3-DesBloqueio Pendente;4-DesBloqueio Processado   
			
		B36->(MsUnlock()) 
		
		cCodRDA	:= aDadProc[1,1]
		cNomRDA	:= aDadProc[1,2]
		cTipPre	:= Posicione('BAU',1,xFilial('BAU') + cCodRDA,'BAU_TIPPRE')
	
		For nI := 1 to len(aDadProc)
			
			BD7->(DbGoTo(aDadProc[nI,10]))
					
			BD7->(RecLock("BD7",.F.))
	    	
	    	//BD7->?G := "1"
	    	BD7->BD7_DESBLO := "Pagamento bloqueado pela rotina de bloqueio autom·tico" 
	    	BD7->BD7_LOTBLO := cNumLot
	    		
	    	BD7->(MsUnLock())
	    	
	    	//BIANCHINI - 21/08/2019 - Se Desbloqueio Pagamento, desbloqueio CobranÁa
			u_BLOCPABD6(BD7->(BD7_CODOPE+BD7_CODLDP+BD7_CODPEG+BD7_NUMERO+BD7_ORIMOV+BD7_SEQUEN),BD7->BD7_MOTBLO,BD7->BD7_DESBLO, .T.,.T.)
	    	
	    	nVlrBloq += BD7->BD7_VLRPAG
			
		Next nI 
		
		B37->(RecLock("B37",.T.))
		
		B37->B37_FILIAL 	:= xFilial('B37')
		B37->B37_CODOPE 	:= PLSINTPAD() 
		B37->B37_NUMLOT 	:= cNumLot 
		B37->B37_CODRDA		:= cCodRDA 
		B37->B37_NOMRDA		:= cNomRDA                              
		B37->B37_TIPPRE    	:= cTipPre
		B37->B37_VLRPAG 	:= nVlrBloq            
		B37->B37_VLRBLO 	:= nVlrBloq
		B37->B37_SALPAG 	:= 0             
		B37->B37_LOTDES 	:= Space(TamSx3('B37_LOTDES')[1])
		B37->B37_STATUS 	:= '2' //2-Processado;3-DesBloqueado
		
		B37->(MsUnLock())
		
	End Transaction
	
EndIf	                      

RestArea(aArea)

Return 

*****************************************************************************************************************************************************

Static Function PLMVC01VAV
 
Local lRet			:= .T.
Local aArea      	:= GetArea()
Local nSaveSx8  	:= GetSX8Len()

If ( B36->B36_STATUS $ '3|4' ) .and. ( nOperation <> MODEL_OPERATION_INSERT ) //Desbloqueio
	lRet:=.F.
	Help(,,'HELP',,'Selecione um Lote de Bloqueio para esta opÁao!',1,0) 
	Return lRet
EndIf

If nOperation == MODEL_OPERATION_INSERT // Inclusao
ElseIf (nOperation == 6 .Or. nOperation == MODEL_OPERATION_UPDATE) .and. oModelB36:GetValue('B36_STATUS') == '2'

	Aviso("AtenÁ„o","Lote de Bloqueio j· Processado.",{"Ok"},1)	
    lRet := .F. 
                                      
ElseIf nOperation == MODEL_OPERATION_DELETE .and. oModelB36:GetValue('B36_STATUS') == '2'

	Aviso("AtenÁ„o"," Lote de Bloqueio j· Processado. "+CHR(10)+CHR(13)+"Caso queira DesBloquear, insira um Lote de DesBloqueio!",{"Ok"},1)	
    lRet := .F.   
     
EndIf

If !lRet

	While (GetSx8Len() > nSaveSx8)	
		RollBackSxe()
	Enddo 
		 
EndIf

RestArea(aArea)

Return lRet 

*****************************************************************************************************************************************************

Static Function PLMV01VPRO

Local aArea      	:= GetArea()
Local cMVPLSRDAG   	:= GetNewPar("MV_PLSRDAG","999999")
Local cSQL          := ""
Local cSQLBAU       := ""
Local nValorBD7   	:= 0
Local nValBloq      := 0
Local cTmp 			:= ""
Local nTmp 			:= 0
Local cOrimov       := 0

cCodOpe  	:= mv_par01 //Operadora                
nValBloq 	:= mv_par02 //Valor Bloqueio                    			       		
nPerBloq 	:= mv_par03 //Percentual Bloqueio                			       		
cClasRDA 	:= mv_par04 //Grupos                    			       			
cAnoDe 		:= mv_par05 //Ano De                                       		
cAnoAte 	:= mv_par06 //Ano Ate                                      		
cMesDe  	:= mv_par07 //Mes De                          	
cMesAte 	:= mv_par08 //Mes Ate          
cEmpDe  	:= mv_par09 //Empresa  De    		
cEmpAte 	:= mv_par10 //Empresa Ate       
cContrDe   	:= mv_par11 //Contrato De        
cContrAte  	:= mv_par12 //Contrato Ate        
cSubDe   	:= mv_par13 //Subcontrato De       
cSubAte 	:= mv_par14 //Subcontrato Ate      
cCodPLaDe   := mv_par15 //Produto De             						
cCodPLaAte  := mv_par16 //Produto Ate           								  		
cCodRDADe  	:= mv_par17//RDA De                                         	  	
cCodRDAAte 	:= mv_par18//RDA Ate                                        	  	   			
dDatMvIni  	:= mv_par19 //Data Movimento De                                    		
dDatMvFin 	:= mv_par20 //Data Movimento Ate                                   		
cTipPes  	:= If(mv_par21 ==1,"F",If(mv_par21 ==2, "J","A")) //Tipo de Pessoa ("Fisica","Juridica","Ambas")               							   	   		
cTipGuia 	:= mv_par22 //Tipo de Guia ("Consulta","SADT","InternaÁ„o","Ambos")            							    	
cGuiaCob 	:= mv_par23 //Considerar Guia ("Cobr./Nao Pagas","Nao Cob/Nao Pag","Todas") 

IncProc("Verificando RDA...")
		
cSQLBAU := "SELECT BAU_CODIGO, BAU_NOME, BAU_TIPPRE" 				+ CRLF
cSQLBAU += "FROM " + RetSQLName("BAU") 						  		+ CRLF
cSQLBAU += "WHERE BAU_FILIAL =  '" + xFilial("BAU") + "' and"  		+ CRLF
cSQLBAU += "BAU_CODIGO <> '"+cMVPLSRDAG+"' AND "  					+ CRLF

If !empty(cCodRDADe+cCodRDAAte)
	cSQLBAU += "( BAU_CODIGO >= '"+cCodRDADe+"' AND BAU_CODIGO <= '"+cCodRDAAte+"' ) AND "  + CRLF
EndIf 
    
If !empty(cTipPes)
   	If cTipPes $ "F|J"  // Fisica ou juridica
		cSQLBAU += "BAU_TIPPE = '" + cTipPes + "' and" 		+ CRLF
	Else
		cSQLBAU += "(BAU_TIPPE = 'F' OR"  					+ CRLF
		cSQLBAU += "BAU_TIPPE = 'J') and"  					+ CRLF
	EndIf
EndIf 

If !empty(cClasRDA)   

	// Ajusta Classe para compor IN da query
	cTmp := "'"
	nTmp := 0 
	
	For nTmp := 1 to Len(Alltrim(cClasRDA))
		If substr(cClasRDA,nTmp,1)==","
			cTmp += "','"
		Else
			cTmp += substr(cClasRDA,nTmp,1)
		EndIf
	Next
	
	cTmp += "'"
	cClasRDA := cTmp
	
	cSQLBAU += "BAU_TIPPRE IN (" + cClasRDA + ") and" 		+ CRLF

EndIf
 	
cSQLBAU += "D_E_L_E_T_ = ' '" 								+ CRLF
cSQLBAU += "ORDER BY BAU_NOME" 								+ CRLF    
    
DbUseArea(.T.,"TOPCONN",TCGENQRY(,,cSQLBAU),"TrbBAU",.F.,.T.)
				
While ! TrbBAU->(Eof())	

	IncProc("Processando RDA : "+TrbBAU->(BAU_CODIGO)) 
	
	//BD7_FILIAL, BD7_CODOPE, BD7_ANOPAG, BD7_MESPAG, BD7_SITUAC, BD7_FASE, BD7_CODRDA
	 
	cSQL := " SELECT BD7_VLRPAG,BD7_CODPAD, BD7_CODPRO, BD7.R_E_C_N_O_ RecnoBD7,"																		+ CRLF
	cSQL += " BD7_CODRDA,BD7_NOMRDA,BD7_CODOPE,BD7_CODLDP,BD7_CODPEG,BD7_NUMERO,BD7_CODUNM,BD7_VLRMAN,BD7_VLRPAG,BD7_VLRGLO,BD7_MESPAG,BD7_ANOPAG"		+ CRLF
	cSQL += " FROM " + RetSQLName("BD7") + " BD7" 																										+ CRLF
	cSQL += ", " + RetSQLName("BD6") + " BD6"																											+ CRLF
   	cSQL += " WHERE BD7_FILIAL =  '" + xFilial("BD7") + "' AND "																						+ CRLF
    cSQL += " BD7_CODOPE =  '" + cCodOpe+"' AND " 																										+ CRLF
    
    If !empty(cAnoDe) .Or. !empty(cMesDe)
		cSQL += " ( BD7_ANOPAG||BD7_MESPAG  >= '"+ cAnoDe+cMesDe +"' ) AND " 																			+ CRLF
	EndIf   
    
    If !empty(cAnoAte) .Or. !empty(cMesAte)
		cSQL += " ( BD7_ANOPAG||BD7_MESPAG  <= '"+ cAnoAte+cMesAte +"' ) AND " 																			+ CRLF
	EndIf
	
	cSQL += " BD7_SITUAC = '1'  AND "  																													+ CRLF // Ativo 
	cSQL += " BD7_FASE   = '3'  AND "   																												+ CRLF// Pronta
	cSQL += " BD7_CODRDA = '"+TrbBAU->(BAU_CODIGO)+"' AND "             																				+ CRLF
    
    //BD7_YFAS35 - Para bloquear nao precisa estar conferido
    
    If !empty(dDatMvIni) .Or. !empty(dDatMvFin)
        cSQL += " ( BD7_DATPRO >= '"+dtos(dDatMvIni)+"' AND BD7_DATPRO <= '"+dtos(dDatMvFin)+"' ) AND "												+ CRLF
    EndIf
	
	If !empty(cCodPlaDe) .Or. !empty(cCodPlaAte)
		cSQL += " ( BD7_CODPLA >= '"+cCodPlaDe+"' AND BD7_CODPLA <= '"+cCodPlaAte+"' ) AND "															+ CRLF
	EndIf 
	
	If !empty(cTipGuia) 
	
		If cTipGuia == 1 .Or. cTipGuia == 2
			cOrimov := "1" // Guia Consulta/Exames
		ElseIf cTipGuia =3
			cOrimov := "2" // Internacao
		Else
			cOrimov := "'1','2'" // Ambos
		EndIf 
		
		If cTipGuia <> 4
			cSQL += " BD7_ORIMOV = '"+cOrimov+"' AND "	   																								+ CRLF
		Else
			cSQL += " BD7_ORIMOV IN ("+cOrimov+") AND "																									+ CRLF
		EndIf
		
	EndIf
	
	cSQL += " BD7_BLOPAG <> '1' AND "  		+ CRLF // Nao Bloqueada Pagamento
    cSQL += " BD7_LOTBLO = '"+ Space(TamSx3("BD7_LOTBLO")[1])+ "' AND "																				+ CRLF
	cSQL += " BD7.D_E_L_E_T_ = ' ' "                                           																			+ CRLF
	
	cSQL += " AND ( BD7_CONPAG = '1' OR BD7_CONPAG = ' ' )" 																							+ CRLF
	
	cSQL += " AND BD7_FILIAL = BD6_FILIAL "	  																											+ CRLF
    cSQL += " AND BD7_CODOPE = BD6_CODOPE "	 																											+ CRLF
    cSQL += " AND BD7_CODLDP = BD6_CODLDP "	   																											+ CRLF
    cSQL += " AND BD7_CODPEG = BD6_CODPEG "	   																											+ CRLF
    cSQL += " AND BD7_NUMERO = BD6_NUMERO "	  																											+ CRLF
    cSQL += " AND BD7_ORIMOV = BD6_ORIMOV "	   																											+ CRLF
    cSQL += " AND BD7_SEQUEN = BD6_SEQUEN "	  																											+ CRLF
    cSQL += " AND BD6.D_E_L_E_T_ = ' ' "	 																											+ CRLF
    
    If cGuiaCob = 1 .Or. cGuiaCob = 2 // guia ja cobradas e nao cobradas 
    
       If cGuiaCob = 1 // guia ja cobradas 
     		cSQL += " AND BD6_PREFIX <> '"+Space(TamSx3("BD6_PREFIX")[1])+"' "	 																		+ CRLF
          	cSQL += " AND BD6_NUMTIT <> '"+Space(TamSx3("BD6_NUMTIT")[1])+"' "	   																		+ CRLF
          	cSQL += " AND BD6_PARCEL <> '"+Space(TamSx3("BD6_PARCEL")[1])+"' "	  																		+ CRLF
          	cSQL += " AND BD6_TIPTIT <> '"+Space(TamSx3("BD6_TIPTIT")[1])+"' "	   																		+ CRLF
    	ElseIf cGuiaCob = 2 // guia nao cobradas
        	cSQL += " AND BD6_PREFIX = '"+Space(TamSx3("BD6_PREFIX")[1])+"' "	   																		+ CRLF
         	cSQL += " AND BD6_NUMTIT = '"+Space(TamSx3("BD6_NUMTIT")[1])+"' "																			+ CRLF
          	cSQL += " AND BD6_PARCEL = '"+Space(TamSx3("BD6_PARCEL")[1])+"' "	   																		+ CRLF
          	cSQL += " AND BD6_TIPTIT = '"+Space(TamSx3("BD6_TIPTIT")[1])+"' "	   																		+ CRLF
      	EndIf
      	
    EndIf
    
    If !empty(cEmpDe) .Or. !empty(cEmpAte)
		cSQL += " AND ( BD6_CODEMP >= '"+cEmpDe+"' AND BD6_CODEMP <= '"+cEmpAte+"' ) "	 																+ CRLF
	EndIf 
	
    If !empty(cContrDe) .Or. !empty(cContrAte)
        cSQL += " AND ( BD6_CONEMP >= '"+ cContrDe +"' AND BD6_CONEMP <= '"+ cContrAte +"') "															+ CRLF
    EndIf     
    
    If !empty(cSubDe) .Or. !empty(cSubAte)
        cSQL += " AND ( BD6_SUBCON >= '"+ cSubDe +"' AND BD6_SUBCON <= '"+ cSubAte +"') "	   															+ CRLF
    EndIf
    
    If Select('TrbBD7') > 0
		TrbBD7->(DbCloseArea())    
    EndIf

	DbUseArea(.T.,"TOPCONN",TCGENQRY(,,cSQL),"TrbBD7",.F.,.T.)

    nValorBD7 := 0
	
	While !TrbBD7->(Eof())

	    //Verifica se a guia de 1- consulta ou 2- exame
		If cTipGuia <> 3 // Internacao

			Do Case

				Case cTipGuia == 1 .and. !PLSISCON(TrbBD7->(BD7_CODPAD),TrbBD7->(BD7_CODPRO))	// Se o parametro esta consulta e nao for consulta, pular
					TrbBD7->(DbSkip())
					loop

				Case cTipGuia == 2 .and. PLSISCON(TrbBD7->(BD7_CODPAD),TrbBD7->(BD7_CODPRO))	// Se o parametro esta Exame e for consulta, pular
					TrbBD7->(DbSkip())
					loop

			EndCase 

		EndIf

		// Grava o numero Lote no BD7 e pega o Valor de pagamento
		If TrbBD7->(BD7_VLRPAG) > 0

			IncProc("Processando RDA : "+TrbBAU->(BAU_CODIGO)+ " - BD7_RECNO : "+ Str(TrbBD7->(RecnoBD7)))

			nValorBD7 += TrbBD7->(BD7_VLRPAG)
			
			aAdd(aRecBD7,TrbBD7->(RecnoBD7))
		
		EndIf
		
		If nValorBD7 > 0 
	
			nValBloq := nValorBD7                               
			   
			// Adiciona Dados Array BD7 
			//{1- Cod RDa, 2- Nome Rda, 3- Tipo Prest, 4- Valor PAGTO, 5-Valor Bloqueio, 6-Saldo Pagto}
			aAdd(aDadBD7,{TrbBAU->(BAU_CODIGO),TrbBAU->(BAU_NOME),TrbBAU->(BAU_TIPPRE),nValorBD7,nValBloq,nValorBD7 - nValBloq})
			
			aAdd(aDadProc, {	Alltrim(TrbBD7->BD7_CODRDA),;
		    					Alltrim(TrbBD7->BD7_NOMRDA),;
		    					Alltrim(TrbBD7->BD7_CODOPE+"."+TrbBD7->BD7_CODLDP+"."+TrbBD7->BD7_CODPEG+"."+TrbBD7->BD7_NUMERO),;
		    					Alltrim(TrbBD7->BD7_CODUNM),;
		    					TrbBD7->BD7_VLRMAN,;//Valor Base Pagamento
		    					TrbBD7->BD7_VLRPAG,;//Valor Pagamento
		    					TrbBD7->BD7_VLRGLO,;//Valor Glosa 
		    					TrbBD7->BD7_VLRPAG,;//Valor Bloqueio
		    					Alltrim(TrbBD7->BD7_MESPAG+" / "+TrbBD7->BD7_ANOPAG),;
		    					TrbBD7->RecnoBD7,;
		    					1}) //Tipo da AlteraÁ„o (1=Bloqueio;2=Glosa)                        
			
		EndIf		           
					
		TrbBD7->(dbSkip())
		
	EndDo
			
	TrbBD7->(dbCloseArea())

	TrbBAU->(dbSkip())
	
End

TrbBAU->(DbCloseArea())

RestArea(aArea)
	
Return 

*****************************************************************************************************************************************************

/*/
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±⁄ƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒƒƒø±±
±±≥ Funcao   ≥ PLSMVCBD7  ≥ Autor ≥ Luciano Aparecido ≥ Data ≥ 10.11.2010 ≥±±
±±√ƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒƒƒ¥±±
±±≥DescriáÑo ≥ Busca os BD7 do Lote selecionado.                          ≥±±
±±¿ƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
/*/
Static Function PLSMVCBD7(oModel)

Local aArea      	:= GetArea()
Local oModelB36		:= oModel:GetModel( 'B36FIELD' )
Local nOperation	:= oModel:GetOperation()
Local cSQLBD7       := ""
Local cNumLot       := ""
Local nRecBd7       := 0

If nOperation == MODEL_OPERATION_DELETE // Excluir 

		cNumLot:= oModelB36:GetValue("B36_NUMLOT") 
				
		cSQLBD7  := " SELECT BD7_LOTBLO, R_E_C_N_O_ RecnoBD7 "
	    cSqlBD7  += " FROM "+RetSqlName("BD7")+" WHERE "
	    cSqlBD7  += " BD7_FILIAL =  '" + xFilial("BD7") + "' AND "  
	    cSqlBD7  += " BD7_CODOPE = '"+PLSINTPAD()		+"' and"
	   	cSqlBD7  += " BD7_LOTBLO = '"+cNumLot+"' AND "
	    cSqlBD7  += " D_E_L_E_T_ = ' ' " 

		dbUseArea(.T.,"TOPCONN",TCGENQRY(,,cSqlBD7),"TrbBD7",.F.,.T.) 
									
		While ! TrbBD7->(Eof()) 
			
			nRecBd7 := TrbBD7->(RecnoBD7) 
			
			BD7->(dbGoTo(nRecBd7))
			// Limpa os Lotes de Bloqueio
			BD7->(RecLock("BD7",.F.))
			BD7->BD7_LOTBLO := ""  
			BD7->(MsUnlock()) 
			
			TrbBD7->(dbSkip())
		End
        
        TrbBD7->(dbCloseArea())
		
EndIf

RestArea(aArea)

Return

*****************************************************************************************************************************************************

/*/
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±⁄ƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒƒƒø±±
±±≥ Funcao   ≥ CRIASX1    ≥ Autor ≥ Luciano Aparecido ≥ Data ≥ 10.11.2010 ≥±±
±±√ƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒƒƒ¥±±
±±≥DescriáÑo ≥ Ajuste o arquivo de perguntas.                             ≥±±
±±¿ƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
/*/
Static Function CriaSX1()

Local aRegs	:=	{}
Local cPerg := "PLMVC01" 

SX1->(dbSetOrder(1))
If SX1->(MsSeek(Padr(cPerg,Len(SX1->X1_GRUPO))+"22")) .and. SX1->X1_DEF04 <> "Ambos"
	SX1->(Reclock("SX1",.F.))
	SX1->(DbDelete())	
	SX1->(MsUnlock())
EndIf
 
AADD(aRegs,{cPerg,"01","Operadora ?               ","Operadora ?            		","Operator ?               ","mv_ch1","C",04,00,00,"G","Vazio() .Or. ExistCpo('BA0')"												,"mv_par01       ","","","","","","","","","","","","","","","","","","","","","","","","","B89PLS","N","","","",""})
AADD(aRegs,{cPerg,"02","Valor Bloqueio ?          ","Valor Bloqueio ?         		","Valor Bloqueio ?       	","mv_ch2","N",17,02,00,"G","(mv_par02==0)" 			 													,"mv_par02       ","","","","","","","","","","","","","","","","","","","","","","","","","","N","","","",""})
AADD(aRegs,{cPerg,"03","Percentual Bloqueio ?     ","Percentual Bloqueio ?    		","Percentual Bloqueio ?  	","mv_ch3","N",17,02,00,"G","(mv_par03==100)"	    					 					   				,"mv_par03       ","","","","","","","","","","","","","","","","","","","","","","","","","","N","","","",""})
AADD(aRegs,{cPerg,"04","Classe ?                  ","Classe ?                 		","Classe ?               	","mv_ch4","C",50,00,00,"G",""              			       											,"mv_par04       ","","","","","","","","","","","","","","","","","","","","","","","","","BYTPLS","N","","","",""})
AADD(aRegs,{cPerg,"05","Ano De ?                  ","AÒo De?            			","From year ?              ","mv_ch5","C",04,00,00,"G",""                               											,"mv_par05       ","","","","","","","","","","","","","","","","","","","","","","","","","","N","","","",""})
AADD(aRegs,{cPerg,"06","Ano Ate ?                 ","AÒo Hasta?         			","To year ?                ","mv_ch6","C",04,00,00,"G","Val(mv_par06)>=Val(mv_par05)"    											,"mv_par06       ","","","","","","","","","","","","","","","","","","","","","","","","","","N","","","",""})
AADD(aRegs,{cPerg,"07","Mes De ?                  ","Mes De ?           			","From month ?             ","mv_ch7","C",02,00,00,"G","Vazio() .Or. PlsVldMes()"                    								,"mv_par07       ","","","","","","","","","","","","","","","","","","","","","","","","","","N","","","",""})
AADD(aRegs,{cPerg,"08","Mes Ate ?                 ","Mes Hasta ?        			","To month ?               ","mv_ch8","C",02,00,00,"G","Vazio() .Or. PlsVldMes() .and. mv_par08>=mv_par07"						,"mv_par08       ","","","","","","","","","","","","","","","","","","","","","","","","","","N","","","",""})
AADD(aRegs,{cPerg,"09","Empresa  De ?             ","De Empresa ?            		","From company ?           ","mv_ch9","C",04,00,00,"G","U_PLSVAFIL('3',mv_par01,mv_par09)"										,"mv_par09       ","","","","","","","","","","","","","","","","","","","","","","","","","B7APLS","N","","","",""})
AADD(aRegs,{cPerg,"10","Empresa Ate ?             ","Hasta Empresa ?         		","To company ?             ","mv_cha","C",04,00,00,"G","U_PLSVAFIL('3',mv_par01,mv_par10)"										,"mv_par10       ","","","",""," ",""," ","","","","","","","","","","","","","","","","","","B7APLS","N","","","",""})
aAdd(aRegs,{cPerg,"11","Contrato De ?         	   ","Contrato De ?					","Contrato De ?			","mv_chb","C",12,00,00,"G","U_PLSVAFIL('1',mv_par01,mv_par09,mv_par11)"					   			,"mv_par11		  ","","","","","","","","","","","","","","","","","","","","","","","","","B7BPLS","N","","","",""})
aAdd(aRegs,{cPerg,"12","Contrato Ate ?        	   ","Contrato Hasta ?				","Contrato Ate ?			","mv_chc","C",12,00,00,"G","U_PLSVAFIL('1',mv_par01,mv_par10,mv_par12)"								,"mv_par12		  ","","","","","","","","","","","","","","","","","","","","","","","","","B7BPLS","N","","","",""})
aAdd(aRegs,{cPerg,"13","Subcontrato De ?      	   ","Subcontrato De ?				","Subcontrato De ? 		","mv_chd","C",09,00,00,"G","U_PLSVAFIL('2',mv_par01,mv_par09,mv_par11,mv_par13)	"					,"mv_par13 		","","","","","","","","","","","","","","","","","","","","","","","","","B7CPLS","N","","","",""})
aAdd(aRegs,{cPerg,"14","Subcontrato Ate ?     	   ","Subcontrato Hasta				","Subcontrato Ate			","mv_che","C",09,00,00,"G","U_PLSVAFIL('2',mv_par01,mv_par10,mv_par12,mv_par14)	"					,"mv_par14 		","","","","","","","","","","","","","","","","","","","","","","","","","B7CPLS","N","","","",""})
aadd(aRegs,{cPerg,"15","Produto De ?              ","Produto De",					"Produto De			 		","mv_chf","C",04,00,00,"G",""						                              	  					,"mv_par15		  ","","","","","","","","","","","","","","","","","","","","","","","","","",""})
aadd(aRegs,{cPerg,"16","Produto Ate ?             ","Produto Ate",					"Produto Ate				","mv_chg","C",04,00,00,"G",""			                              	  								,"mv_par16		  ","","","","","","","","","","","","","","","","","","","","","","","","","",""})
AADD(aRegs,{cPerg,"17","RDA De ?                  ","De RDA ?           			","From RDA ?               ","mv_chh","C",06,00,00,"G",""                              	  										,"mv_par17       ","","","","","","","","","","","","","","","","","","","","","","","","","BAUPLS","N","","","",""})
AADD(aRegs,{cPerg,"18","RDA Ate ?                 ","A DRA ?            			","To RDA ?                 ","mv_chi","C",06,00,00,"G",""                          	  	   										,"mv_par18       ","","","","","","","","","","","","","","","","","","","","","","","","","BAUPLS","N","","","",""})
AADD(aRegs,{cPerg,"19","Data Movimento De ?       ","De fecha movimiento ?  		","From movement date ?     ","mv_chj","D",08,00,00,"G",""                                 										,"mv_par19       ","","","","","","","","","","","","","","","","","","","","","","","","","","N","","","",""})
AADD(aRegs,{cPerg,"20","Data Movimento Ate ?      ","A fecha movimiento ?   		","To movement date ?       ","mv_chl","D",08,00,00,"G",""                                 										,"mv_par20       ","","","","","","","","","","","","","","","","","","","","","","","","","","N","","","",""})
AADD(aRegs,{cPerg,"21","Tipo de Pessoa ?          ","Tipo de Persona ?      		","Person Type ?            ","mv_chm","C",10,00,00,"C",""							   	   											,"mv_par21       ","Fisica         ","Fisica         ","Physical       ","","","Juridica        ","Juridica        ","Juridica       		","","","Ambos       ","Ambos          ","Ambos          ","","","","","","","","","","","","","N","",""," ",""})
AADD(aRegs,{cPerg,"22","Tipo de Guia ?            ","Tipo de Guia ?      			","Guide Type ?             ","mv_chn","C",10,00,00,"C",""   							    										,"mv_par22       ","Consulta       ","Consulta       ","Consulta       ","","","SADT             ","SADT           ","SADT           		","","","InternaÁ„o  ","InternaÁ„o     ","InternaÁ„o     ","","","Ambos","Ambos","Ambos","","","","","","","","N","","","",""})
AADD(aRegs,{cPerg,"23","Considerar Guia ?         ","Considerar Guia  ?     		","consider guide ?         ","mv_cho","C",10,00,00,"C",""   							    										,"mv_par23       ","Cobr./Nao Pagas","Cobr./Nao Pagas","Cobr./Nao Pagas","","","Nao Cob/Nao Pag","Nao Cob/Nao Pag","Nao Cob/Nao Pag","","","Todas      ","Todas          ","Todas          ","","","","","","","","","","","","","N","","","",""})

PlsVldPerg( aRegs )
     
Return

*****************************************************************************************************************************************************

/*/
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±⁄ƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒƒƒø±±
±±≥ Funcao   ≥ PLSVAFIL   ≥ Autor ≥ Luciano Aparecido ≥ Data ≥ 26.11.2010 ≥±±
±±√ƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒƒƒ¥±±
±±≥DescriáÑo ≥ Valid do arquivo de perguntas.                             ≥±±
±±¿ƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
/*/
User Function PLSVAFIL(cPar,cCpo1,cCpo2,cCpo3,cCpo4)

Local lRet 		:= .T.               
Local bBlcVld	:= { || !empty(cCpo2) .and. UPPER(cCpo2) <> Replicate('Z',Len(cCpo2)) .and. IIf(cPar == "1",!empty(cCpo3),UPPER(cCpo3) <> Replicate('Z',Len(cCpo3)) .and. !empty(cCpo4))}

If cPar =='1' .and. Eval(bBlcVld)
	BT5->(dbSetOrder(1))
	If !BT5->(dbSeek(xFilial("BT5")+cCpo1+cCpo2+cCpo3))
		MsgStop("Contrato Invalido!")     	
		lRet := .F.
	EndIf 
ElseIf 	cPar =='2' .and. Eval(bBlcVld)
	BQC->(dbSetOrder(6))
	If !BQC->(dbSeek(xFilial("BQC")+cCpo1+cCpo2+cCpo3+cCpo4))
		MsgStop("SubContrato Invalido!")
		lRet := .F.
	EndIf
ElseIf 	cPar =='3'
	If !empty(cCpo2) .and. UPPER(cCpo2) <> Replicate('Z',Len(cCpo2)) 
		BG9->(dbSetOrder(1))
		If !BG9->(dbSeek(xFilial("BG9")+cCpo1+cCpo2))
			MsgStop("Empresa Invalida!")     	
			lRet := .F.
		EndIf 
	EndIf
EndIf 

Return lRet

*****************************************************************************************************************************************************

/*
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±…ÕÕÕÕÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÀÕÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÀÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÕÕÕª±±
±±∫Programa  |PLSVLPAG  ∫Autor  ≥Microsiga 			 ∫ Data ≥  30/11/2010 ∫±±
±±ÃÕÕÕÕÕÕÕÕÕÕÿÕÕÕÕÕÕÕÕÕÕ ÕÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕ ÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕÕÕπ±±
±±∫Desc.     ≥Funcao de VALID SX1 do Valor Bloqueio		                  ∫±±
±±ÃÕÕÕÕÕÕÕÕÕÕÿÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕπ±±
±±∫Uso       ≥SIGAPLS		                                              ∫±±
±±»ÕÕÕÕÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕº±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
*/
User Function SX1VldBlo(nVlrBlo,nPerBlo,nCpo)

Local lRet      := .T.

Default nVlrBlo := 0
Default nPerBlo := 0
Default nCpo    := 0

If nCpo == "1"

	If nVlrBlo > 0 .and. nPerBlo > 0
	     MsgStop("J· existe Percentual de Bloqueio Informado!")
	     lRet := .F.
	EndIf 
	
EndIf

If nCpo == "2" 

	If nPerBlo > 0 .and. nVlrBlo > 0
	     MsgStop("J· existe Valor Bloqueio Informado!")
	     lRet := .F.
	EndIf 
	
	If lRet .and. nPerBlo > 100
	    MsgStop("Percentual de Bloqueio n„o pode ser maior que 100!")
	     lRet := .F.
	EndIf
	
EndIf

Return lRet

*****************************************************************************************************************************************************

User Function LegB36

Local aLegenda := {		{ "BR_AMARELO"	, "Bloqueio Pendente"  		},;
		             	{ "BR_VERMELHO"	, "Bloqueio Processado"		},;    
		             	{ "BR_LARANJA"	, "DesBloqueio Pendente"	},;
		             	{ "BR_VERDE" 	, "DesBloqueio Processado"	} }

BrwLegenda(cCadastro,"Status" ,aLegenda)

Return

*****************************************************************************************************************************************************

User Function INCLTD

Local lContinua		:= .F.                   
Local cPictB36		:= Replicate('9',TamSX3('B36_NUMLOT')[1])
Local bValLot		:= {||If(empty(cLoteBlo),(MsgStop('Informe um lote a ser desbloqueado',AllTrim(SM0->M0_NOMECOM)),.F.),.T.)}

Private cLoteBlo   	:= If(B36_STATUS == '2',B36_NUMLOT,Space(TamSX3('B36_NUMLOT')[1]))
Private aDadProc	:= {}

SetPrvt("oDlg1","oSay1","oSBtn1","oSBtn2","oGet1")

oDlg1      := MSDialog():New( 095,232,214,447,"Desbloqueio de Pagamento",,,.F.,,,,,,.T.,,,.T. )

oSay1      := TSay():New( 004,004,{||"Lote de Bloqueio"},oDlg1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,044,008)
oSBtn1     := SButton():New( 036,044,1,{||lContinua:=.T.,oDlg1:End()},oDlg1,,"", )
oSBtn2     := SButton():New( 036,076,2,{||lContinua:=.F.,oDlg1:End()},oDlg1,,"", )
oGet1      := TGet():New( 004,048,{|u| If(PCount()>0,(u:=(cLoteBlo:=StrZero(Val(u),TamSX3('B36_NUMLOT')[1])),oGet1:CtrlRefresh()),cLoteBlo)},oDlg1,052,008,cPictB36,bValLot,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cLoteBlo",,)

oDlg1:Activate(,,,.T.)

If lContinua
	Processa({||PINCLTD(cLoteBlo)},'Inclus„o de lote de desbloqueio')
EndIf

Return

*****************************************************************************************************************************************************

Static Function PINCLTD(cLoteBlo)

Local aArea         := {}
Local nI   			:= 0
Local cQry			:= ''
Local nVlrLib		:= 0
Local cCodRDA		:= ''
Local cAliasB36		:= GetNextAlias()

If LockByName('PLMVC01')

	ProcRegua(0)
        
	For nI := 1 to 5
		IncProc('Processando...')		
	Next
	
	aArea 	:= GetArea()
	
	aRecBD7 := {} 
	
	cQry := "SELECT BD7_CODRDA,BD7_VLRPAG VLR_LIB, R_E_C_N_O_ REC"			+ CRLF
	cQry += "FROM " + RetSqlName('BD7') + " VALOR_LIB"						+ CRLF
	cQry += "WHERE BD7_FILIAL = '" + xFilial('BD7') + "'"  					+ CRLF		
	cQry += "  AND BD7_LOTBLO = '" + cLoteBlo + "'" 						+ CRLF			
	cQry += "  AND D_E_L_E_T_ = ' '" 										+ CRLF			
	
	TcQuery cQry New Alias cAliasB36
	
	While !cAliasB36->(EOF())
		cCodRDA := cAliasB36->BD7_CODRDA	
		nVlrLib += cAliasB36->VLR_LIB
		aAdd(aRecBD7,cAliasB36->REC)
		cAliasB36->(DbSkip())
	EndDo
	
	B36->(DbSetOrder(1))
	B36->(MsSeek(xFilial('B36') + PLSINTPAD() + cLoteBlo))
	
	aData	:= {B36->B36_ANOLDE,B36->B36_ANOLAT,B36->B36_MESLDE,B36->B36_MESLAT}
	
	cAliasB36->(DbCloseArea())

	If len(aRecBD7) == 0
		Help(,,'HELP',,'Com a parametrizacao informada n„o retornou nenhum dado!',1,0)
	ElseIf MsgYesNo(	'Confirma a liberaÁ„o do lote de bloqueio [ '  + cLoteBlo + ' ] RDA [ ' + cCodRDA + ' ]' + CRLF + ;
						' no valor de [ R$ ' + AllTrim(Transform(nVlrLib,'@E 999,999,999.99')) + ' ] ?',AllTrim(SM0->M0_NOMECOM))
	
		Processa({||PLMV01DESB(cLoteBlo,cCodRDA,aRecBD7,aData) },"Iniciando Processamento...", "", .T.)
		
	EndIf
	
	UnLockByName('PLMVC01')
    
	RestArea(aArea)
	
Else
	MsgStop('Rotina est· sendo usada por outro usu·rio!',AllTrim(SM0->M0_NOMECOM))
EndIf

Return

*****************************************************************************************************************************************************

Static Function PLMV01DESB(cLoteBlo,cCodRDA,aRecBD7,aData)

Local nI := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

Local aArea 	:= GetArea()
Local Alias		:= GetNextAlias()
Local cQry
Local cNextLot
Local nVlrDesB	:= 0

ProcRegua(0)
        
For nI := 1 to 5
	IncProc('Processando...')		
Next

cQry := "SELECT NVL(TO_NUMBER(MAX(B36_NUMLOT)),0) + 1 LOTE"	+ CRLF
cQry += "FROM " + RetSqlName('B36') 						+ CRLF
cQry += "WHERE B36_FILIAL = '" + xFilial('B36') + "'" 		+ CRLF		
cQry += "  AND D_E_L_E_T_ = ' '" 							+ CRLF			

TcQuery cQry New Alias cAliasB36

cNextLot := StrZero(cAliasB36->LOTE,TamSx3('B36_NUMLOT')[1])

cAliasB36->(DbCloseArea())

Begin Transaction	
        
    B36->(RecLock("B36",.T.))  
    
    B36->B36_FILIAL := xFilial('B36')
	B36->B36_CODOPE := PLSINTPAD()
	B36->B36_DTDIGI := Date()
	B36->B36_HRDIGI := StrTran(Time(),":","")
	B36->B36_OPESIS := RetCodUsr()
	B36->B36_NOMOPE := PLRETOPE()
	B36->B36_NUMLOT	:= cNextLot
	B36->B36_DTPROC := Date()
	B36->B36_HRPROC := StrTran(Time(),":","")
	B36->B36_OPEPRO := RetCodUsr()
	B36->B36_NOMPRO := PLRETOPE()
	B36->B36_STATUS := "4" //1-Bloqueio Pendente;2-Bloqueio Processado;3-DesBloqueio Pendente;4-DesBloqueio Processado
	B36->B36_ANOLDE := aData[1]
	B36->B36_ANOLAT := aData[2]
	B36->B36_MESLDE := aData[3]
	B36->B36_MESLAT := aData[4]
		
	B36->(MsUnlock()) 
	
	For nI := 1 to len(aRecBD7)
		
		BD7->(DbGoTo(aRecBD7[nI]))
				
		BD7->(RecLock("BD7",.F.))
    	
    	BD7->BD7_BLOPAG := "0"
    	BD7->BD7_DESBLO := Space(TamSX3('BD7_DESBLO')[1])
    	BD7->BD7_LOTBLO := Space(TamSX3('BD7_LOTBLO')[1])
    		
    	BD7->(MsUnLock())

		//BIANCHINI - 21/08/2019 - Se Desbloqueio Pagamento, desbloqueio CobranÁa
		u_BLOCPABD6(BD7->(BD7_CODOPE+BD7_CODLDP+BD7_CODPEG+BD7_NUMERO+BD7_ORIMOV+BD7_SEQUEN),BD7->BD7_MOTBLO,BD7->BD7_DESBLO, .F.,.F.)
    	
    	nVlrDesB 	+= BD7->BD7_VLRPAG 
    	
	Next nI 
	
	cNomRDA	:= Posicione('BAU',1,xFilial('BAU') + cCodRDA,'BAU_NOME')
	cTipPre	:= Posicione('BAU',1,xFilial('BAU') + cCodRDA,'BAU_TIPPRE')
	
	//A rotina original PLSMVC01 nao gera B37 no desbloqueio. Vou utilizar a B37 neste caso para gravar o log do lote desbloqueado.
	B37->(RecLock("B37",.T.))
	
	B37->B37_FILIAL 	:= xFilial('B37')
	B37->B37_CODOPE 	:= PLSINTPAD()
	B37->B37_NUMLOT 	:= cNextLot
	B37->B37_CODRDA		:= cCodRDA
	B37->B37_NOMRDA		:= cNomRDA
	B37->B37_TIPPRE    	:= cTipPre
	B37->B37_VLRPAG 	:= nVlrDesB
	B37->B37_VLRBLO 	:= nVlrDesB
	B37->B37_SALPAG 	:= 0
	B37->B37_LOTDES 	:= cLoteBlo
	B37->B37_STATUS 	:= '3'//2-Processado;3-DesBloqueado

	B37->(MsUnLock())
	
End Transaction

RestArea(aArea)

MsgInfo('Desbloqueio processado. Lote de desbloqueio [ ' + cNextLot + ' ] gerado!',AllTrim(SM0->M0_NOMECOM))

Return
