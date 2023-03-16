#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'TOTVS.CH'
#INCLUDE 'FONT.CH'
#INCLUDE 'TOPCONN.CH'
#INCLUDE 'Tbiconn.ch' 

#DEFINE cEnt chr(10)+chr(13)
/*
#############################################################################
#############################################################################
###Programa | CABA616   |Autor: Fabio Bianchini     | Data:04/01/2018     ###
#############################################################################
##Desc.     |  INTEGRAÇÃO GUIAS E TITULOS (P12) X FOLHA AUTONOMOS(P12)    ###
##          | 											                  ###
#############################################################################
##Uso       | INTEGRAÇÃO PROTHEUS12 X PROTHEUS12                          ###
#############################################################################
#############################################################################
#############################################################################
*/     
User Function CABA616()                        
Local oButton1
Local oButton2
Local oButton3
Local oGet1
Local nGet1 := GetMv('MV_SALBAS') //5839.45
Local oGet2
Local cGet2 := Space(2)
Local oGet3
Local cGet3 := Space(4)
Local oGet4
Local cGet4 := Space(6)
Local oGet5
Local cGet5 := "ZZZZZZ" //Space(6)
Local oGroup1
Local oSay1
Local oSay2
Local oSay3
Local oSay4
Local oSay5
Local oSay6

Local aEmpresas := {"01","02"}
Local lSchedule := .T.

Private nTETOINSS := nGet1 //5839.45
Private cMes      := cGet2
Private cAno      := cGet3 
Private cRDADE    := cGet4
Private cRDAATE   := cGet5 

Static oDlg

  DEFINE MSDIALOG oDlg TITLE "New Dialog" FROM 000, 000  TO 300, 460 COLORS 0, 16777215 PIXEL

    @ 000, 002 GROUP oGroup1 TO 147, 227 OF oDlg COLOR 0, 16777215 PIXEL
    @ 018, 049 SAY oSay1 PROMPT "INTEGRAÇÃO CONTAS MÉDICAS P12 X FOLHA P12" SIZE 130, 007 OF oDlg COLORS 0, 16777215 PIXEL

    @ 030, 056 SAY oSay2 PROMPT "Teto INSS:" SIZE 049, 007 OF oDlg COLORS 0, 16777215 PIXEL
    @ 028, 112 MSGET oGet1 VAR nGet1 SIZE 007, 010 OF oDlg COLORS 0, 16777215 PIXEL PICTURE "@R 9999.99"
    @ 048, 056 SAY oSay3 PROMPT "Mes/Compet. Pgto.:" SIZE 049, 007 OF oDlg COLORS 0, 16777215 PIXEL
    @ 045, 112 MSGET oGet1 VAR cGet2 SIZE 060, 010 OF oDlg COLORS 0, 16777215 PIXEL
    @ 066, 056 SAY oSay4 PROMPT "Ano/Compet. Pgto.:" SIZE 050, 007 OF oDlg COLORS 0, 16777215 PIXEL
    @ 062, 112 MSGET oGet2 VAR cGet3 SIZE 060, 010 OF oDlg COLORS 0, 16777215 PIXEL
    @ 082, 056 SAY oSay5 PROMPT "Cód.Prestador De:" SIZE 050, 007 OF oDlg COLORS 0, 16777215 PIXEL
    @ 079, 112 MSGET oGet3 VAR cGet4 SIZE 060, 010 OF oDlg COLORS 0, 16777215 F3 "YBAUPL" PIXEL
    @ 098, 056 SAY oSay6 PROMPT "Cód.Prestador Até:" SIZE 053, 007 OF oDlg COLORS 0, 16777215 PIXEL
    @ 095, 112 MSGET oGet4 VAR cGet5 SIZE 060, 010 OF oDlg COLORS 0, 16777215 F3 "YBAUPL" PIXEL
    @ 120, 025 BUTTON oButton1 PROMPT "&Processar >>>" SIZE 037, 012 OF oDlg ACTION BuscaTit(lSchedule,aEmpresas[2],nGet1,cGet2,cGet3,cGet4,cGet5)PIXEL
    @ 120, 093 BUTTON oButton2 PROMPT "&Limpar" SIZE 037, 012 OF oDlg ACTION Limpar(@nGet1,@cGet2,@cGet3,@cGet4,@cGet5,@oGet1) PIXEL
    @ 120, 154 BUTTON oButton3 PROMPT "Sai&r" SIZE 037, 012 OF oDlg ACTION oDlg:End() PIXEL

  ACTIVATE MSDIALOG oDlg CENTERED

Return

Static Function BuscaTit(lSchedule,cEmp,nTeto,cMes,cAno,cRDADe,cRDAAte)
//Fabio Bianchini - 28/12/2018 - INICIO
Local cAlias      := GetNextAlias()
Local cAliasSRA   := GetNextAlias()
Local cAliasRFQ   := GetNextAlias()
Local cAliasRGB   := GetNextAlias()
Local cAliasBGQ   := GetNextAlias()
//Local cAliasBBC   := GetNextAlias()
Local cDBOra      := " " // alterar o alias/dsn para o banco/conexão que está utilizando
Local cSrvOra     := " " // alterar para o ip do DbAccess
Local nHndERP     := -1
Local nHwnd       := -1
Local nBGQ_VALOR  := 0
Local nPerc_BGQ   := 0 
Local nRecRGB     := 0 
Local nContRegua  := 0
Local aFolha      := {} 
Local cFilSRA     := ""
Local cMatSRA     := ""
Local cCCSRA      := ""
Local cQry        := ""
Local cQrySRA     := ""
Local cQryRFQ     := ""
Local cQryRGB	  := ""
Local cQryBGQ	  := ""
//Local cQryBBC	  := ""
Local cCpoIns	  := ""
Local cValIns	  := ""
Local lPossui110  := .F.
Local lPossui706  := .F.
Local lPossui710  := .F.

//Atualizando Teto INSS
	nTETOINSS := nTeto

//Private cCompTabela := IIf(cEmpAnt == '01',"010","020") 

//Fabio Bianchini - 28/12/2018 - FIM

	QOut("CABA616 - INÍCIO PROCESSAMENTO - "+Time())

	aArea := getArea()

	//nHndERP := AdvConnection()

	//if TCQuit() // fecho todas as conexões com o dbaccess em curso na thread.
	//	QOut("CABA616 - CONEXÕES ENCERRADAS - "+Time())
	//endif 
	
	//CONECTANDO P11
	//cDBOra   := "ORACLE/CABERJ" // alterar o alias/dsn para o banco/conexão que está utilizando
	//cSrvOra  := "10.19.1.8" // alterar para o ip do DbAccess
	//nHwnd := TCLink(cDBOra, cSrvOra, 7890)
	//TcSetConn(nHwnd)

	//If nHwnd >= 0
		/********************************/
		/* Busca Guias e Titulos na P11 */ 
		/********************************/
		cQry += "SELECT DISTINCT 	" + cEnt 
		cQry += "       BD7_CODRDA,  " + cEnt
		cQry += "       BD7_NOMRDA, 	" + cEnt
		cQry += "       A2_CGC, 		" + cEnt
		cQry += "       E2_FORNECE, 	" + cEnt
		cQry += "       E2_LOJA, 	    " + cEnt
		cQry += "       SUM(E2_VALOR) E2_VALOR,	" + cEnt
		cQry += "       SUM(E2_INSS)  E2_INSS, 	" + cEnt
		cQry += "       SUM(E2_IRRF)  E2_IRRF 	" + cEnt
		cQry += "  FROM (   		" + cEnt
		cQry += "	SELECT DISTINCT 	" + cEnt 
		cQry += "	       BD7_CODRDA,  " + cEnt
		cQry += "	       BD7_NOMRDA, 	" + cEnt
		cQry += "	       A2_CGC, 		" + cEnt
		cQry += "	       E2_FORNECE, 	" + cEnt
		cQry += "	       E2_LOJA, 	" + cEnt
		cQry += "	       E2_VALOR, 	" + cEnt
		cQry += "	       E2_INSS, 	" + cEnt
		cQry += "	       E2_IRRF,	 	" + cEnt
		cQry += "	       E2_PREFIXO, 	" + cEnt
		cQry += "	       E2_NUM, 		" + cEnt
		cQry += "	       E2_EMISSAO	" + cEnt		
		cQry += "	  FROM SIGA."+RetSQLName("BD7")+ " BD7, " + cEnt
		cQry += "	       SIGA."+RetSQLName("SA2")+ " SA2, " + cEnt
		cQry += "	       SIGA."+RetSQLName("SE2")+ " SE2 " + cEnt
		cQry += "	 WHERE BD7_FILIAL = '" + xFilial("BD7") + "'" + cEnt
		cQry += "	   AND A2_FILIAL  = '" + xFilial("SA2") + "'" + cEnt
		cQry += "	   AND E2_FILIAL  = '" + xFilial("SE2") + "'" + cEnt
		//cQry += "	   AND BD7_YFAS35 = 'T'  " + cEnt
		cQry += "	   AND BD7_BLOPAG <> '1' " + cEnt
		cQry += "	   AND BD7_CONPAG IN (' ','1') " + cEnt
		cQry += "	   AND BD7_SITUAC = '1'  " + cEnt
		cQry += "	   AND BD7_FASE   = '4'  " + cEnt
		cQry += "	   AND BD7_NUMLOT <> ' ' " + cEnt
		cQry += "	   AND BD7_CODLDP <> '9000' " + cEnt
		cQry += "	   AND BD7_NUMLOT = E2_PLLOTE  " + cEnt
		cQry += "	   AND BD7_CODRDA = E2_CODRDA  " + cEnt
		cQry += "	   AND SUBSTR(BD7_NUMLOT,1,6) = '"+cValToChar(cAno+cMes) + "' " + cEnt
		//cQry += "	   AND E2_BAIXA = ' '   " + cEnt
		//cQry += "	   AND E2_PREFIXO||E2_NUM <> 'CON000040352'  " + cEnt   ///PONTUAL PARA UM TITULO EMITIDO E PAGO EM 12/2018
		cQry += "	   AND E2_TIPO = 'FT'        " + cEnt
		cQry += "	   AND E2_FORNECE = A2_COD   " + cEnt
		cQry += "	   AND E2_LOJA	  = A2_LOJA  " + cEnt
		cQry += "	   AND A2_TIPO    = 'F'	     " + cEnt
		cQry += "	   AND E2_CODRDA  >=  '"+cRDADE  +"'" + cEnt
		cQry += "	   AND E2_CODRDA  <=  '"+cRDAATE +"'" + cEnt
		cQry += "	   AND BD7.D_E_L_E_T_ = ' '  " + cEnt
		cQry += "	   AND SA2.D_E_L_E_T_ = ' '  " + cEnt
		cQry += "	   AND SE2.D_E_L_E_T_ = ' '  " + cEnt
		cQry += "		)
		cQry += "	 GROUP BY BD7_CODRDA, BD7_NOMRDA, A2_CGC, E2_FORNECE, E2_LOJA " + cEnt   
		cQry += "	 ORDER BY BD7_CODRDA  " + cEnt
		
		dbUseArea(.T.,'TOPCONN',TcGenQry(,,cQry),cAlias,.T.,.T.)
		
		DbSelectArea(cAlias)
		
		nContRegua := (cAlias)->(RecCount())
		
		While !(cAlias)->(EOF())
			/*Pegar Retenção por outras fontes*/
			cQryBGQ := " SELECT MAX(BGQ_VALOR) BGQ_VALOR FROM " + RetSqlName("BGQ") + " BGQ " + cEnt
			cQryBGQ += "  WHERE BGQ.BGQ_FILIAL = ' ' " + cEnt
			cQryBGQ += "    AND BGQ.BGQ_CODIGO = '" + (cAlias)->(BD7_CODRDA) + "' " + cEnt
			//cQryBGQ += "    AND BGQ.BGQ_ANO    = '" + SUBS((cAlias)->(E2_PLLOTE),1,4)+"' " + cEnt
			//cQryBGQ += "    AND BGQ.BGQ_MES    = '" + SUBS((cAlias)->(E2_PLLOTE),5,2)+"' " + cEnt
			cQryBGQ += "    AND BGQ.BGQ_ANO    = '" + cValToChar(cAno) + "' " + cEnt
			cQryBGQ += "    AND BGQ.BGQ_MES    = '" + cValToChar(cMes) + "' " + cEnt
			cQryBGQ += "    AND BGQ.BGQ_CODLAN = '050' " + cEnt
			cQryBGQ += "    AND BGQ.BGQ_TIPO   = '3' " + cEnt
			cQryBGQ += "    AND BGQ.D_E_L_E_T_ = ' ' " + cEnt	  			
	
			IF SELECT(cAliasBGQ) > 0
				(cAliasBGQ)->(dbclosearea())
				cAliasBGQ := GetNextAlias()
			Endif		
	
			dbUseArea(.T.,'TOPCONN',TcGenQry(,,cQryBGQ),cAliasBGQ,.T.,.T.)	
			
			DbSelectArea(cAliasBGQ)		
			
			If !(cAliasBGQ)->(EOF())
				nBGQ_VALOR := (cAliasBGQ)->(BGQ_VALOR)
				nPerc_BGQ  := (cAliasBGQ)->(BGQ_VALOR) * 0.11 
			Else
				nBGQ_VALOR := 0
				nPerc_BGQ  := 0
			Endif
			
			//Força retenção por outras fontes, caso INSSvenha zerado
			If (cAlias)->(E2_INSS) == 0 .or. (nBGQ_VALOR <> 0 .and. nTETOINSS > nBGQ_VALOR)   
				nBGQ_VALOR := nTETOINSS
				nPerc_BGQ  := nTETOINSS * 0.11
			Endif 
			
			aAdd(aFolha,{(cAlias)->(BD7_CODRDA),(cAlias)->(BD7_NOMRDA),(cAlias)->(A2_CGC) ,(cAlias)->(E2_FORNECE),(cAlias)->(E2_LOJA),;
						 (cAlias)->(E2_VALOR)  ,(cAlias)->(E2_INSS)   ,(cAlias)->(E2_IRRF), nBGQ_VALOR           , nPerc_BGQ})
						 
			(cAlias)->(DbSkip())
		Enddo
	
		(cAlias)->(DbCloseArea())
		
		QOut("CABA616 - CARREGOU MOVIMENTOS DE PAGAMENTOS EM ARRAY - "+Time())
	//Endif
	
	//TCUnlink( nHwnd )
				
	// Reabro a conexão do dbaccess com a base principal(P12)
	//cDBOra   := "ORACLE/P12GPEPROD" // alterar o alias/dsn para o banco/conexão que está utilizando
	//cSrvOra  := "10.19.1.8" // alterar para o ip do DbAccess
	//nHwnd := TCLink(cDBOra, cSrvOra, 7890)
	//TcSetConn(nHwnd)

	RestArea(aArea)

	//If nHwnd >= 0
	  	For nCont:= 1 to Len(aFolha)
	  		/*Checar se Existe SRA*/
	  		cQrySRA := " SELECT * FROM " + RetSqlName("SRA") + " SRA "
	  		cQrySRA += "  WHERE RA_FILIAL = '01'"
	  		cQrySRA += "    AND SRA.RA_CIC = '" +AllTrim(aFolha[nCont][3])+ "'"
	  		cQrySRA += "    AND SRA.D_E_L_E_T_ = ' ' "	  		

	  		IF SELECT(cAliasSRA) > 0
				(cAliasSRA)->(dbclosearea())
				cAliasSRA := GetNextAlias()
			Endif		

			dbUseArea(.T.,'TOPCONN',TcGenQry(,,cQrySRA),cAliasSRA,.T.,.T.)
			
			DbSelectArea(cAliasSRA)

			If !(cAliasSRA)->(EOF())
		  		cFilSRA := (cAliasSRA)->(RA_FILIAL)
				cMatSRA := (cAliasSRA)->(RA_MAT)
				cCCSRA  := (cAliasSRA)->(RA_CC)
				cCODFUN := (cAliasSRA)->(RA_CODFUNC)			
				
				/*Checar periodo ABERTO no processo 00003*/
		  		cQryRFQ := " SELECT * FROM " + RetSqlName("RFQ") + " RFQ "
		  		cQryRFQ += "  WHERE RFQ.RFQ_FILIAL = ' ' "
		  		cQryRFQ += "    AND RFQ.RFQ_PROCES = '00003' "
		  		cQryRFQ += "    AND RFQ.RFQ_PERIOD = '" + cValToChar(cAno+cMes) + "' "
		  		cQryRFQ += "    AND RFQ.D_E_L_E_T_ = ' ' "	  		

		  		IF SELECT(cAliasRFQ) > 0
					(cAliasRFQ)->(dbclosearea())
					cAliasRFQ := GetNextAlias()
				Endif		
				
				dbUseArea(.T.,'TOPCONN',TcGenQry(,,cQryRFQ),cAliasRFQ,.T.,.T.)
				
				DbSelectArea(cAliasRFQ)
		  		
		  		If !(cAliasRFQ)->(EOF())
			  		If (cAliasRFQ)->(RFQ_STATUS) == '1'  //Se período está aberto
			  			//Verba 110 - Serviços Prestados
			  			
			  			//Procurar Verba 110 e Excluir Para Re-inserir
			  			DbSelectArea("RGB")
			  			DbSetOrder(8) //rgb_filial + rgb_pd + rgb_proces + rgb_period + rgb_roteir + rgb_mat
			  			if DbSeek(xFilial("RGB")+'110'+'00003'+cAno+cMes+'AUT'+cMatSRA)
			  				While !RGB->(EOF()) .and. RGB->RGB_PD == '110' .and. RGB->RGB_PROCES == '00003' .and. ;
			  				                          RGB->RGB_PERIOD == cValToChar(cAno+cMes) .and. ;
			  				                          RGB->RGB_ROTEIR == 'AUT' .and. RGB->RGB_MAT == cMatSRA
				  				RecLock("RGB",.F.)
				  				DbDelete()
				  				MsUnlock() 
				  				RGB->(DbSkip())
			  				Enddo
			  			endif
			  			//Procurar Verba 706 e Excluir Para Re-inserir
			  			DbSelectArea("RGB")
			  			DbSetOrder(8) //rgb_filial + rgb_pd + rgb_proces + rgb_period + rgb_roteir + rgb_mat
			  			if DbSeek(xFilial("RGB")+'706'+'00003'+cAno+cMes+'AUT'+cMatSRA)
			  				While !RGB->(EOF()) .and. RGB->RGB_PD == '706' .and. RGB->RGB_PROCES == '00003' .and. ;
			  				                          RGB->RGB_PERIOD == cValToChar(cAno+cMes) .and. ;
			  				                          RGB->RGB_ROTEIR == 'AUT' .and. RGB->RGB_MAT == cMatSRA
				  				RecLock("RGB",.F.)
				  				DbDelete()
				  				MsUnlock() 
				  				RGB->(DbSkip())
			  				Enddo
			  			endif			  			
			  			//Procurar Verba 710 e Excluir Para Re-inserir
			  			DbSelectArea("RGB")
			  			DbSetOrder(8) //rgb_filial + rgb_pd + rgb_proces + rgb_period + rgb_roteir + rgb_mat
			  			if DbSeek(xFilial("RGB")+'710'+'00003'+cValToChar(cAno+cMes)+'AUT'+cMatSRA)
			  				While !RGB->(EOF()) .and. RGB->RGB_PD == '710' .and. RGB->RGB_PROCES == '00003' .and. ;
			  				                          RGB->RGB_PERIOD == cValToChar(cAno+cMes) .and. ;
			  				                          RGB->RGB_ROTEIR == 'AUT' .and. RGB->RGB_MAT == cMatSRA
				  				RecLock("RGB",.F.)
				  				DbDelete()
				  				MsUnlock() 
				  				RGB->(DbSkip())
			  				Enddo
			  			endif
				  			
			  			DbSelectArea("RGB")
			  			DbSetOrder(1)
			  			
			  			//Incluindo Verba 110 - Serviços Prestados
			  			Reclock("RGB",.T.)
			  			
			  			RGB->RGB_FILIAL := cFilSRA
			  			RGB->RGB_PROCES := '00003'
			  			RGB->RGB_PERIOD := cValToChar(cAno+cMes)
			  			RGB->RGB_SEMANA := '01'
			  			RGB->RGB_ROTEIR := 'AUT'
			  			RGB->RGB_MAT 	:= cMatSRA
			  			RGB->RGB_PD 	:= '110'
			  			RGB->RGB_TIPO1 	:= 'V'
			  			RGB->RGB_QTDSEM := 0
			  			RGB->RGB_HORAS 	:= 0
			  			RGB->RGB_VALOR 	:= NoRound(aFolha[nCont][6]+aFolha[nCont][7]+aFolha[nCont][8],2)
			  			RGB->RGB_CC 	:= AllTrim(cCCSRA)
			  			RGB->RGB_PARCEL := 0
			  			RGB->RGB_TIPO2 	:= 'I'
			  			RGB->RGB_CODFUN := cCODFUN
			  			RGB->RGB_DUM 	:= 0
			  			RGB->RGB_DDOIS 	:= 0
			  			RGB->RGB_DTRES 	:= 0
			  			RGB->RGB_DQUATR := 0
			  			RGB->RGB_DCINCO := 0
			  			RGB->RGB_DSEIS 	:= 0
			  			RGB->RGB_DSETE 	:= 0
			  			RGB->RGB_DTREF 	:= Date()
			  			
			  			MsUnlock()
				  						  			 
						//Se possuir a verba 706 ou INSS = 0
						If aFolha[nCont][10] > 0 .or. aFolha[nCont][7] == 0  
							
							Do Case
								Case aFolha[nCont][10] == 0 .AND. aFolha[nCont][7] == 0 
									nBaseOF := NoRound(nTETOINSS * 0.11,2)
								Case aFolha[nCont][10] > 0
									nBaseOF := NoRound(aFolha[nCont][10],2)
							EndCase	
								
				  			//Incluindo Verba 706 - Desconto INSS Outras Empresas (11%)
				  			Reclock("RGB",.T.)
				  			
				  			RGB->RGB_FILIAL := cFilSRA
				  			RGB->RGB_PROCES := '00003'
				  			RGB->RGB_PERIOD := cValToChar(cAno+cMes)
				  			RGB->RGB_SEMANA := '01'
				  			RGB->RGB_ROTEIR := 'AUT'
				  			RGB->RGB_MAT 	:= cMatSRA
				  			RGB->RGB_PD 	:= '706'
				  			RGB->RGB_TIPO1 	:= 'V'
				  			RGB->RGB_QTDSEM := 0
				  			RGB->RGB_HORAS 	:= 0
				  			RGB->RGB_VALOR 	:= nBaseOF //NoRound(aFolha[nCont][10],2)
				  			RGB->RGB_CC 	:= AllTrim(cCCSRA)
				  			RGB->RGB_PARCEL := 0
				  			RGB->RGB_TIPO2 	:= 'I'
				  			RGB->RGB_CODFUN := cCODFUN
				  			RGB->RGB_DUM 	:= 0
				  			RGB->RGB_DDOIS 	:= 0
				  			RGB->RGB_DTRES 	:= 0
				  			RGB->RGB_DQUATR := 0
				  			RGB->RGB_DCINCO := 0
				  			RGB->RGB_DSEIS 	:= 0
				  			RGB->RGB_DSETE 	:= 0
				  			RGB->RGB_DTREF 	:= Date()
				  			
				  			MsUnlock()
				  		Endif	
				  		
				  		//Se possuir a verba 710
				  		If aFolha[nCont][9] > 0 .or. aFolha[nCont][7] == 0 
				  		
				  			Do Case
								Case aFolha[nCont][9] == 0 .AND. aFolha[nCont][7] == 0 
									nBaseOF := NoRound(nTETOINSS,2)
								Case aFolha[nCont][9] > 0
									nBaseOF := NoRound(aFolha[nCont][9],2)
							EndCase
				  		
				  			//Incluindo Verba 710 - Base de INSS Outras Empresas (Teto)
				  			Reclock("RGB",.T.)
				  			
				  			RGB->RGB_FILIAL := cFilSRA
				  			RGB->RGB_PROCES := '00003'
				  			RGB->RGB_PERIOD := cValToChar(cAno+cMes)
				  			RGB->RGB_SEMANA := '01'
				  			RGB->RGB_ROTEIR := 'AUT'
				  			RGB->RGB_MAT 	:= cMatSRA
				  			RGB->RGB_PD 	:= '710'
				  			RGB->RGB_TIPO1 	:= 'V'
				  			RGB->RGB_QTDSEM := 0
				  			RGB->RGB_HORAS 	:= 0
				  			RGB->RGB_VALOR 	:= nBaseOF //NoRound(aFolha[nCont][24],2)
				  			RGB->RGB_CC 	:= AllTrim(cCCSRA)
				  			RGB->RGB_PARCEL := 0
				  			RGB->RGB_TIPO2 	:= 'I'
				  			RGB->RGB_CODFUN := cCODFUN
				  			RGB->RGB_DUM 	:= 0
				  			RGB->RGB_DDOIS 	:= 0
				  			RGB->RGB_DTRES 	:= 0
				  			RGB->RGB_DQUATR := 0
				  			RGB->RGB_DCINCO := 0
				  			RGB->RGB_DSEIS 	:= 0
				  			RGB->RGB_DSETE 	:= 0
				  			RGB->RGB_DTREF 	:= Date()
				  			
				  			MsUnlock()		
			  								
						Endif
			  		Else
			  			Alert('O Período: ' + cValToChar(cAno+cMes) + ' está FECHADO!')
			  		Endif
		  		Else
		  			Alert('Não existe o período: ' + cValToChar(cAno+cMes))
		  		Endif
		  		(cAliasRFQ)->(DbCloseArea())
		  		(cAliasSRA)->(DbCloseArea())	
		  	Endif
		Next nCont
		Alert('PROCESSO FINALIZADO !')
	//EndIf
	
	QOut("FIM PROCESSAMENTO - CABA616 - "+Time())	
Return

Static Function Limpar(nGet1,cGet2,cGet3,cGet4,cGet5,oGet1)

	nGet1 := 0.00
	cGet2 := cMes 	 := Space(2)
	cGet3 := cAno 	 := Space(4)
	cGet4 := cRDADE  := Space(6)
	cGet5 := cRDAATE := Space(6)
	
	oGet1:SetFocus()

Return
