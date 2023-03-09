//#INCLUDE "PLSA500.ch"
#INCLUDE "rwmake.ch"
#INCLUDE "protheus.ch"
#INCLUDE "TopConn.ch"
#INCLUDE "TBICONN.CH"   

#DEFINE cEnt chr(10)+chr(13)

User Function CABACLO()

	If MsgYesNo('INCLUIR CLONES?','Confirmação')
		Processa({|| fIncClone()}, "INICIANDO CLONAGEM DE GUIAS EM LOTE...")
	ElseIf MsgYesNo('EXLUIR CLONES?','Confirmação')
		Processa({|| fExcClone()}, "INICIANDO EXCLUSAO DE GUIAS CLONADAS...")
	ElseIf MsgYesNo('TRANSFERIR CLONES?','Confirmação')
		Processa({|| fTransClone()}, "TRANSFERINDO GUIAS CLONADAS...")
	Endif
Return

Static Function fIncClone()
    Local nAtual := 0
    Local nTotal := 0
	Local cQryClone := ""
    Local cAliQry1  := "CLONE"
    Local cQryPEG   := ""
    Local cAliQry2  := "PEG0022"
    Local aMatLin   := {}
    Local cCodLdp   := "0019"//"0022" //MOVIMENTACAO CUSTO X CONTABILIDADE  
    Local cMesPeg   := "05"   //MUDAR PARA CADA COMPETENCIA
    Local cAnoPeg   := "2021" //MUDAR PARA CADA COMPETENCIA
    Local dDataPeg  := STOD("20210501") //MUDAR PARA CADA COMPETENCIA
	Local nParcela  := 4 //MUDAR PARA CADA COMPETENCIA
    Local _cChkOri  := ""   
    Local cPegDes   := ""
    Local X         := 0     
	Local aAreaBD5  := {}                

    PRIVATE objCENFUNLGP := CENFUNLGP():New()
    
    dDatabase := dDataPeg

    cQryClone := " SELECT DISTINCT CODRDA,BD5_ANOPAG,BD5_MESPAG,LOCAL,PEG,NUMERO,NUMIMP,BD5.R_E_C_N_O_   " + cEnt
    cQryClone += "   FROM TEMP_RECUP_2021,BD5010 BD5 "  + cEnt
    cQryClone += "  WHERE BD5_FILIAL=' ' "  + cEnt
    cQryClone += "    AND BD5_OPEUSR='0001' "  + cEnt
    cQryClone += "    AND BD5_CODRDA IN ('138460','138851','111406','111414','124796','140040','134210','140171','140139','140147','140155')  "  + cEnt
    cQryClone += "    AND BD5_CODRDA=CODRDA "  + cEnt
    cQryClone += "    AND BD5_ANOPAG=ANOPAG "  + cEnt
    cQryClone += "    AND BD5_MESPAG=MESPAG "  + cEnt
    cQryClone += "    AND PARCELA="            + cValToChar(nParcela) + cEnt
    cQryClone += "    AND BD5_CODLDP=LOCAL  "  + cEnt
    cQryClone += "    AND BD5_CODPEG=PEG    "  + cEnt
    cQryClone += "    AND BD5_NUMERO=NUMERO "  + cEnt
    cQryClone += "    AND BD5_GUESTO = ' '  "  + cEnt
	cQryClone += "    AND D_E_L_E_T_=' '    "  + cEnt
    cQryClone += "  ORDER BY CODRDA,BD5_ANOPAG,BD5_MESPAG,LOCAL,PEG,NUMERO "  + cEnt

    If Select(cAliQry1)>0
        (cAliQry1)->(DbCloseArea())
    EndIf
    
	memowrite('c:\TEMP\cabaclo.sql',cQryClone)                            
    
	DbUseArea(.T.,"TopConn",TcGenQry(,,cQryClone),cAliQry1,.T.,.T.)
        
    While !(cAliQry1)->(EOF())
		nTotal++	
        (cAliQry1)->(DbSkip())
    Enddo

    ProcRegua(nTotal)

    DbSelectArea(cAliQry1)

	(cAliQry1)->(DbGotop())

    While !(cAliQry1)->(EOF())
		nAtual++
        IncProc("Clonando Guia << " +  (cAliQry1)->(LOCAL+PEG+NUMERO) +" >> Posição: " + cValToChar(nAtual) + " de " + cValToChar(nTotal) + "...")

        cQryPEG := " SELECT * FROM BCI010 " + cEnt
        cQryPEG += "  WHERE BCI_FILIAL = ' ' " + cEnt
        cQryPEG += "    AND BCI_CODLDP = '" + cCodLdp + "'" + cEnt
        cQryPEG += "    AND BCI_MES    = '" + cMesPeg + "'" + cEnt
        cQryPEG += "    AND BCI_ANO    = '" + cAnoPeg + "'" + cEnt
        cQryPEG += "    AND BCI_CODRDA = '" + (cAliQry1)->(CODRDA) + "'" + cEnt
        cQryPEG += "    AND D_E_L_E_T_ = ' ' " + cEnt
      
        If Select(cAliQry2)>0
            (cAliQry2)->(DbCloseArea())
        EndIf
       
        DbUseArea(.T.,"TopConn",TcGenQry(,,cQryPEG),cAliQry2,.T.,.T.)
            
        DbSelectArea(cAliQry2)
		//Se não tiver PEG para este prestador, nesta comeptência, crio uma
        If (cAliQry2)->(EOF())
            PLSIPP(PLSINTPAD(),cCodLDP,PLSINTPAD(),(cAliQry1)->(CODRDA),cMesPeg,cAnoPeg,dDataBase,"02"," ",{},"1"," ",0,1,0)
        Endif
        
		//Ponteirar a BD5 original Para clonar Guia
		DbSelectArea("BD5")
		BD5->(DbGoTo((cAliQry1)->R_E_C_N_O_))
		
		aAreaBD5 := BD5->(GetArea())

        GeraCLO("BD5",(cAliQry1)->R_E_C_N_O_,3,nil,.f.)
		
		//Ponteirar a BD5 original Para Pegar seu BD5_GUESTO que será movida para novo PEG
		BD5->(DbGoTop())
		BD5->(DbGoTo((cAliQry1)->R_E_C_N_O_))
		
		aAreaBD5 := BD5->(GetArea())
		
		aMatLin := {}
        aadd(aMatLin,{"1",;  //RETCBOX("BD5_SITUAC",BD5->BD5_SITUAC)
                      "1",;  //RETCBOX("BD5_FASE",BD5->BD5_FASE)
                      DTOC(BD5->BD5_DATPRO),;
                      SUBSTR(BD5->BD5_GUESTO,17,8),;  //BD5_NUMERO
                      transForm(BD5->BD5_NRLBOR,PesqPict("BE1","BE1_NUMAUT")),;
                      transForm(BD5->(BD5_OPEUSR+BD5_CODEMP+BD5_MATRIC+BD5_TIPREG+BD5_DIGITO),"@R !!!!.!!!!.!!!!!!-!!.!"),;
                      allTrim(BD5->BD5_NOMUSR),;
                      transForm(BD5->BD5_VLRPAG,"@E 999,999,999.99"),;
                      .f.})
        
		_cChkOri := PLSINTPAD() + (cAliQry1)->(LOCAL) + (cAliQry1)->(PEG)

        //Ponteiro para pegar a BCI Destino
        BCI->(dbSetOrder(4)) //BCI_FILIAL, BCI_OPERDA, BCI_CODRDA, BCI_ANO, BCI_MES, BCI_TIPO, BCI_FASE, BCI_SITUAC, BCI_TIPGUI, BCI_CODLDP
        cChaveBCI := PLSINTPAD() + (cAliQry1)->(CODRDA) + cAnoPeg + cMesPeg + "2" + "1" + "1" + "02" + cCodLDP
        If BCI->( MsSeek(xFilial("BCI")+cChaveBCI) )
            cPegDes  := BCI->(BCI_CODOPE+BCI_CODLDP+BCI_CODPEG)
        Endif

        If !Empty(_cChkOri) .and. !Empty(cPegDes) .and. !Empty(aMatLin) .and. _cChkOri <> cPegDes 
            CABTRAGUI(_cChkOri,cPegDes,aMatLin)
        Endif
    
		BCI->(DbCloseArea())
		RestArea(aAreaBD5)
		BD5->(DbCloseArea())

        (cAliQry1)->(DbSkip())

    Enddo

    Alert("CONCLUIDO")

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³PLSA500CLO ³ Autor ³ Daher		        | Data ³ 08.12.05 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³Selecionada uma guia o sistema clona a mesma				  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
/*/
Static Function GeraCLO(cAlias,nReg,nOpc,aFields,lMsg)

LOCAL cChaveGui:= &(cAlias+"->("+cAlias+"_CODOPE+"+cAlias+"_CODLDP+"+cAlias+"_CODPEG+"+cAlias+"_NUMERO+"+cAlias+"_ORIMOV)")
LOCAL aCabec   := {cAlias,&(cAlias+"->(DbStruct())")}
LOCAL aItens   := BD6->(DbStruct())
LOCAL aSubItens:= BD7->(DbStruct())
LOCAL nH       := 0
LOCAL nI	   := 0
LOCAL nJ	   := 0
LOCAL nK	   := 0
LOCAL dDatCtbChk:= stod('')
LOCAL cNumero   := ""
LOCAL cCodOpe   := ""
LOCAL cCodLdp   := ""
LOCAL cCodPeg   := ""
LOCAL cSemGuia  := ""
LOCAL cFiltAli  := ""
LOCAL aLocClo	:= {}

PRIVATE aNewRDA	:= {}
DEFAULT aFields := nil
DEFAULT lMsg    := .T.

dDatCtbChk := PLRtDtCTB(&(cAlias+"->"+cAlias+"_CODOPE"), &(cAlias+"->"+cAlias+"_CODLDP"), &(cAlias+"->"+cAlias+"_CODPEG"), &(cAlias+"->"+cAlias+"_NUMERO"), .F.)

if PLVLDBLQCO(dDatCtbChk, {"PLS007"}, lMsg) //verifica se a database está no periodo contabil e se estiver não pode clonar a guia

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ O compatibilizador tem que ter sido aplicado							 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If &(cAlias+"->(FieldPos('"+cAlias+"_GUESTO'))") == 0
		If lMsg
			Help("",1,"PLSA500013")
		Endif
		Return
	Endif
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ O conteudo do parametro tem q estar na BW								 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	SX5->(DbSetOrder(1))
	If !SX5->(MsSeek(xFilial("SX5")+"BW"+alltrim(GetNewPar("MV_PLGUIES","123"))))
		If lMsg
			Help("",1,"PLSA500026")
		Endif
		Return
	Endif
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ So posso clonar se a guia estiver pronta/faturada, desbloqueada			 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If ! &(cAlias+"->"+cAlias+"_FASE") $ "3,4" .Or. &(cAlias+"->"+cAlias+"_SITUAC") <> "1" .or. !Empty(&(cAlias+"->"+cAlias+"_GUESTO"))
	     If lMsg
	        Help("",1,"PLSA500014")
	     Endif
	     Return
	Else
	   //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	   //³ Pede confirmacao...                                                      ³
	   //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	   //If ! lMsg .Or. MsgYesNo(STR0080)       //"Deseja clonar a guia ?"
	
	    aLocClo := GetLocal(cAlias)
	   	while !aLocClo[1]
	   		aLocClo := GetLocal(cAlias)
	   	enddo
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Antes de qualquer coisa eu vou marcar os campos de controle na guia      |
		//| que vai ser clonada													 	 ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If BD6->(MsSeek(xFilial("BD6")+cChaveGui))
			   While !BD6->(Eof()) .and. BD6->(BD6_FILIAL+BD6_CODOPE+BD6_CODLDP+BD6_CODPEG+BD6_NUMERO+BD6_ORIMOV) == ;
			   							 xFilial("BD6")+cChaveGui
	
				   	BD6->(Reclock("BD6",.F.))
				   		BD6->BD6_TPESTO := '1'//nenhum
				    	BD6->BD6_CONCOB := '1'//sim
				    	BD6->BD6_CONPAG := '1'//sim
				    	BD6->BD6_CONMUS := '1'//sim
				    	BD6->BD6_CONMRD := '1'//sim
				   	BD6->(MsUnlock())
	
					BD7->(DbSetOrder(1))
			    	If BD7->(MsSeek(xFilial("BD7")+BD6->(BD6_CODOPE+BD6_CODLDP+BD6_CODPEG+BD6_NUMERO+BD6_ORIMOV+BD6_SEQUEN)))
			    		While ! BD7->(Eof()) .And. BD7->(BD7_FILIAL+BD7_CODOPE+BD7_CODLDP+BD7_CODPEG+BD7_NUMERO+BD7_ORIMOV+BD7_SEQUEN) == ;
			     									xFilial("BD6")+BD6->(BD6_CODOPE+BD6_CODLDP+BD6_CODPEG+BD6_NUMERO+BD6_ORIMOV+BD6_SEQUEN)
		
						   	BD7->(Reclock("BD7",.F.))
						   			BD7->BD7_TPESTO := '1'//nenhum
						   			BD7->BD7_CONCOB := '1'//sim
							    	BD7->BD7_CONPAG := '1'//sim
							    	BD7->BD7_CONMUS := '1'//sim
							    	BD7->BD7_CONMRD := '1'//sim
						   	BD7->(MsUnlock())
	
			     			BD7->(DbSkip())
			     		Enddo
					Endif
					BD6->(DbSkip())
				Enddo
		Endif
	    //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	    //³ A guia a ser estornada agora esta toda dentro deste array				 ³
	    //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	    aGuiaOri := PlGetDadGui(cChaveGui,aCabec,aItens,aSubItens,cAlias)
	    //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	    //³ Garanto o BCI posicionado												 ³
	    //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	
	    cCodOpe  := &(cAlias+"->"+cAlias+"_CODOPE")
	    cCodLdp  := &(cAlias+"->"+cAlias+"_CODLDP")
	    cCodPeg  := &(cAlias+"->"+cAlias+"_CODPEG")
	    cSemGuia := cCodOpe+cCodLdp+cCodPeg
		nH       := PLSAbreSem(cSemGuia+".SMF")
	    Begin Transaction
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	    //³ Garanto o BCI posicionado												 ³
	    //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		BCI->(DbSetOrder(1))
	    BCI->(MsSeek(xFilial("BCI")+&(cAlias+"->"+cAlias+"_CODOPE")+&(cAlias+"->"+cAlias+"_CODLDP")+&(cAlias+"->"+cAlias+"_CODPEG")))
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	    //³ Busco o proximo numero da guia											 ³
	    //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If FindFunction("TcSqlFilter()")//teoricamente sempre tem q entrar aqui
			cFiltAli := &(cAlias+"->(TcSqlFilter())")
		Else
			cFiltAli := RetFiltro(cAlias,"BCI")
		Endif
		&(cAlias+"->(DbClearFilter())")
	
		cNumero  := PLSA500NUM(cAlias,aLocClo[2],aLocClo[3],aLocClo[4])
	
	    DbSelectArea(aCabec[1])
	    Reclock(aCabec[1],.F.)
	    	&(aCabec[1]+"_GUESTO") := aLocClo[2]+aLocClo[3]+aLocClo[4]+cNumero+&(cAlias+"->"+cAlias+"_ORIMOV")
	    	&(aCabec[1]+"_ESTORI") := '1'
	    MsUnlock()
	
	    PosNewRda(aLocClo[2],aLocClo[3],aLocClo[4],aLocClo[5]) // Posiciona na nova RDA
	
	    Reclock(aCabec[1],.T.)
	    //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	    //³ Gravo o cabecalho da guia												 ³
	    //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	    For nI := 1 to Len(aCabec[2])
	    	cCampo  := aCabec[2][nI][1]
	    	cAliCp  := subs(cCampo,1,3)
	    	If cAliCp+"_CODOPE" == alltrim(cCampo)
	    		&cCampo := aLocClo[2]
	    	ElseIf cAliCp+"_CODLDP" == alltrim(cCampo)
	    		&cCampo := aLocClo[3]
	    	ElseIf cAliCp+"_CODPEG" == alltrim(cCampo)
	    		&cCampo := aLocClo[4]
	    	ElseIf cAliCp+"_NUMERO" == alltrim(cCampo)
	    		&cCampo := cNumero
	    	ElseIf cAliCp+"_FASE" == alltrim(cCampo)
	    		&cCampo := "1"
	    	ElseIf cAliCp+"_GUESTO" == alltrim(cCampo)
	    		&cCampo := cChaveGui
	    	ElseIf cAliCp+"_ESTORI" == alltrim(cCampo)
	    		&cCampo := '0'
			ElseIf cAliCp+"_LA" == alltrim(cCampo)
	    		&cCampo := ' '
	    	ElseIf DesField(cAliCp,cCampo)
	    		loop
	    	ElseIf ValType((xRet := TraField(cAliCp,cCampo,aCabec))) <> "U"
		    		//fiz esse tratamento pois tem alguns campos que não preenchia nessa função
		    		//um exemplo era o BD5_CODESP pois pega o aNewRDA que preenche só quando tem BAX_ESPPRI == '1'
		    		//ai no momento de analisar as divergencias da guia dava varios erros
		    		If empty(xRet) .and. !empty(aGuiaOri[1][nI])
		    			&cCampo := aGuiaOri[1][nI]
		    		Else
	    		&cCampo := xRet
		    		EndIf
		    		
	    		xRet := Nil
	    	Else
	    		&cCampo := aGuiaOri[1][nI]
	    	Endif
	    Next
	    MsUnlock()
	    //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Vou varrer cada evento da guia											 ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	    For nI := 1 to Len(aGuiaOri[2])
		    //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		    //³ Gravo o cabecalho do evento												 ³
		    //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		    DbSelectArea("BD6")
	    	Reclock("BD6",.T.)
		    For nK := 1 to Len(aItens)
		    	cCampo  := aItens[nK][1]
		    	cAliCp  := subs(cCampo,1,3)
		    	If cAliCp+"_CODOPE" == alltrim(cCampo)
	    			&cCampo := aLocClo[2]
		    	ElseIf cAliCp+"_CODLDP" == alltrim(cCampo)
		    		&cCampo := aLocClo[3]
		    	ElseIf cAliCp+"_CODPEG" == alltrim(cCampo)
		    		&cCampo := aLocClo[4]
		    	ElseIf cAliCp+"_NUMERO" == alltrim(cCampo)
		    		&cCampo := cNumero
		    	ElseIf cAliCp+"_FASE" == alltrim(cCampo)
	    			&cCampo := "1"
		    	ElseIf cAliCp+"_TPESTO" == alltrim(cCampo)
	    			&cCampo := "1"
	    		ElseIf cAliCp+"_GUESTO" == alltrim(cCampo)
	    			&cCampo := cChaveGui
		    	ElseIf cAliCp+"_CONCOB" == alltrim(cCampo)
		    		&cCampo := '0'
		    	ElseIf cAliCp+"_CONPAG" == alltrim(cCampo)
		    		&cCampo := '0'
		    	ElseIf cAliCp+"_CONMUS" == alltrim(cCampo)
		    		&cCampo := '0'
		    	ElseIf cAliCp+"_CONMRD" == alltrim(cCampo)
		    		&cCampo := '0'
				ElseIf cAliCp+"_LAPRO" == alltrim(cCampo)
		    		&cCampo := ''
				ElseIf cAliCp+"_LA" == alltrim(cCampo)
		    		&cCampo := ''
				ElseIf cAliCp+"_DTPRO" == alltrim(cCampo)
		    		&cCampo := CTOD('  /  /  ')
				ElseIf cAliCp+"_BLOCPA" == alltrim(cCampo)
		    		&cCampo := "1"
		       	ElseIf DesField(cAliCp,cCampo)
		    		loop
		    	ElseIf ValType((xRet := TraField(cAliCp,cCampo,aCabec))) <> "U"
			    		//fiz esse tratamento pois tem alguns campos que não preenchia nessa função
		    			//um exemplo era o BD5_CODESP pois pega o aNewRDA que preenche só quando tem BAX_ESPPRI == '1'
			    		//ai no momento de analisar as divergencias da guia dava varios erros
			    		If empty(xRet) .and. !empty(aGuiaOri[2][nI][1][nK] )
			    			&cCampo := aGuiaOri[2][nI][1][nK] 
			    		Else
		    		&cCampo := xRet
			    		EndIf
			    		
		    		xRet := Nil
		    	Else
		    		&cCampo := aGuiaOri[2][nI][1][nK]
		    	Endif
	    	Next
		    MsUnlock()
		    //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		    //³ Vou gravar cada unidade deste evento									 ³
		    //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	    	For nJ := 1 to Len(aGuiaOri[2][nI][2])
	    		DbSelectArea("BD7")
	    		Reclock("BD7",.T.)
	    		For nK := 1 to Len(aSubItens)
				   cCampo  := aSubItens[nK][1]
				   cAliCp  := subs(cCampo,1,3)
		    	   If cAliCp+"_CODOPE" == alltrim(cCampo)
			    		&cCampo := aLocClo[2]
			       ElseIf cAliCp+"_CODLDP" == alltrim(cCampo)
			    		&cCampo := aLocClo[3]
			       ElseIf cAliCp+"_CODPEG" == alltrim(cCampo)
			    		&cCampo := aLocClo[4]
			       ElseIf cAliCp+"_NUMERO" == alltrim(cCampo)
				   		&cCampo := cNumero
				   ElseIf cAliCp+"_FASE" == alltrim(cCampo)
	    				&cCampo := "1"
				   ElseIf cAliCp+"_GUESTO" == alltrim(cCampo)
	    				&cCampo := cChaveGui
				   ElseIf cAliCp+"_TPESTO" == alltrim(cCampo)
	    				&cCampo := "1"
				   ElseIf cAliCp+"_CONCOB" == alltrim(cCampo)
			    		&cCampo := '0'
			       ElseIf cAliCp+"_CONPAG" == alltrim(cCampo)
			    		&cCampo := '0'
			       ElseIf cAliCp+"_CONMUS" == alltrim(cCampo)
			    		&cCampo := '0'
			       ElseIf cAliCp+"_CONMRD" == alltrim(cCampo)
			    		&cCampo := '0'
			       ElseIf cAliCp+"_CODRDA" == alltrim(cCampo)
			    		&cCampo := aGuiaOri[2][nI][2][nJ][nK]
			       ElseIf cAliCp+"_NOMRDA" == alltrim(cCampo)
			    		&cCampo := aGuiaOri[2][nI][2][nJ][nK]
			       ElseIf cAliCp+"_LA" == alltrim(cCampo)
			       		&cCampo :=" "
			       ElseIf cAliCp+"_LAPRV" == alltrim(cCampo)
			       		&cCampo :=" "
			       ElseIf cAliCp+"_LAREV" == alltrim(cCampo)
			       		&cCampo :=" "
			       ElseIf cAliCp+"_DTPRV" == alltrim(cCampo)
			       		&cCampo :=Ctod("  /  /  ")
			       ElseIf cAliCp+"_DTREV" == alltrim(cCampo)
			       		&cCampo :=Ctod("  /  /  ")
		           ElseIf cAliCp+"_DTPRO" == alltrim(cCampo)
			       		&cCampo :=Ctod("  /  /  ")
			       ElseIf cAliCp+"_COMPCT" == alltrim(cCampo)
			       		&cCampo :="    "
	  		       ElseIf cAliCp+"_VLPRV" == alltrim(cCampo)
			       		&cCampo :=0
				   ElseIf cAliCp+"_BLOPAG" == alltrim(cCampo) 
			       		&cCampo :=aGuiaOri[2][nI][2][nJ][nK]
			       ElseIf DesField(cAliCp,cCampo)
				   		loop
				   ElseIf ValType((xRet := TraField(cAliCp,cCampo,aCabec))) <> "U"
							//fiz esse tratamento pois tem alguns campos que não preenchia nessa função
		    				//um exemplo era o BD5_CODESP pois pega o aNewRDA que preenche só quando tem BAX_ESPPRI == '1'
		    				//ai no momento de analisar as divergencias da guia dava varios erros
		    				If empty(xRet) .and. !empty(aGuiaOri[2][nI][2][nJ][nK])
		    					&cCampo := aGuiaOri[2][nI][2][nJ][nK] 
		    				Else
						&cCampo := xRet
							EndIf
							
						xRet := Nil
				   Else
				   		&cCampo := aGuiaOri[2][nI][2][nJ][nK]
				   Endif
			    Next
			    MsUnlock()
	    	Next
	    Next
	    End Transaction
		PLSFechaSem(nH,cSemGuia+".SMF")
		&(cAlias+"->(MsSeek('"+xFilial(cAlias)+cChaveGui+"'))")//depois da clonagem eu deixo posicionado na guia origem
		If !Empty(cFiltAli)
			DbSelectArea(cAlias)
			DbSetFilter({||&cFiltAli},cFiltAli)
		Endif
/*		If lMsg
			//-------------------------------------------------------------------
			//  LGPD
			//-------------------------------------------------------------------
			objCENFUNLGP:useLogUser()
			MsgInfo(STR0081+"     " +Chr(13)+Chr(10)+  STR0253+aLocClo[2]+'.'+aLocClo[3]+'.'+aLocClo[4]+'.'+cNumero+"]") //"Clonagem de guia concluida com sucesso !!!" //"Chave da guia clonada ["
		Endif
*/	   //Endif
	Endif

EndIf

Return

static function GetLocal(cAlias)
local aRet    := {}
local aSXB    := {}
local nJ      :=1
local nI      :=1
local aEstrut := {"XB_ALIAS","XB_TIPO","XB_SEQ","XB_COLUNA","XB_DESCRI","XB_DESCSPA","XB_DESCENG","XB_CONTEM","XB_WCONTEM"}
local oDlg,oSBtn1,oGrp2,oGet3,oGet4,oGet5,oSay6,oSay7,oSay8
local nOrdBCI := BCI->(IndexOrd())
local nRecBCI := BCI->(recno())
local bValid  := {|| M->BCI_CODOPE := cOpeClo, ExistCpo("BCG",cLocClo,1)}
local bVali2  := {|| M->BCI_CODOPE := cOpeClo, ExistCpo("BA0",cOpeClo,1)}
local bVali3  := {|| BCI->(dbSetOrder(1)),if(BCI->(msSeek(xFilial("BCI")+cOpeClo+cLocClo+cPegClo)), iIf(BCI->BCI_TIPGUI == cTipGui,.t.,Eval({|| Help("",1,"PLSA500032"),.f.})) ,Eval({|| Help("",1,"PLSA500031"),.f.})) }
cOpeClo := &(cAlias+"->("+cAlias+"_CODOPE)")
cLocClo := &(cAlias+"->("+cAlias+"_CODLDP)")
cPegClo := &(cAlias+"->("+cAlias+"_CODPEG)")
cTipGui := &(cAlias+"->("+cAlias+"_TIPGUI)")
M->BCI_CODOPE := cOpeClo //necessario para o f3 funcionar
/*
oDlg := MSDIALOG():Create()
oDlg:cName := "oDlg"
oDlg:cCaption := STR0259 //"Informe aonde deve ser criada a guia clonada."
oDlg:nLeft := 0
oDlg:nTop := 0
oDlg:nWidth := 286
oDlg:nHeight := 193

oGrp2 := TGROUP():Create(oDlg)
oGrp2:cName := "oGrp2"
oGrp2:cCaption := ""
oGrp2:nLeft := 11
oGrp2:nTop := 6
oGrp2:nWidth := 257
oGrp2:nHeight := 151

@ 14,61 MSGET oGet3 VAR cOpeClo PICTURE "@R !.!!!"  size 010,010 VALID iIf(!empty(cOpeClo),Eval(bVali2),.t.) PIXEL of oDlg F3 "B89PLS" hasbutton
@ 30,61 MSGET oGet4 VAR cLocClo PICTURE "@!"        size 010,010 VALID iIf(!empty(cLocClo),Eval(bValid),.t.) PIXEL of oDlg F3 "BCGPLS" hasbutton
@ 46,61 MSGET oGet5 VAR cPegClo PICTURE "@!"        size 025,010 VALID iIf(!empty(cPegClo),Eval(bVali3),.t.) PIXEL of oDlg F3 "B1IPLS" hasbutton

oSay6 := TSAY():Create(oDlg)
oSay6:cName := "oSay6"
oSay6:cCaption := STR0260 //"Operadora :"
oSay6:nLeft := 23
oSay6:nTop := 31
oSay6:nWidth := 65
oSay6:nHeight := 17

oSay7 := TSAY():Create(oDlg)
oSay7:cName := "oSay7"
oSay7:cCaption := STR0261 //"local Digitação :"
oSay7:nLeft := 23
oSay7:nTop := 65
oSay7:nWidth := 89
oSay7:nHeight := 17

oSay8 := TSAY():Create(oDlg)
oSay8:cName := "oSay8"
oSay8:cCaption := "PEG : "
oSay8:nLeft := 23
oSay8:nTop := 95
oSay8:nWidth := 65
oSay8:nHeight := 17

oSBtn1 := SBUTTON():Create(oDlg)
oSBtn1:cName := "oSBtn1"
oSBtn1:cCaption := "OK"
oSBtn1:nLeft := 207
oSBtn1:nTop := 120
oSBtn1:nWidth := 52
oSBtn1:nHeight := 22
oSBtn1:bAction := {|| iIf(Eval(bValid) .and. Eval(bVali2) .and. Eval(bVali3),oDlg:end(),.f.) }

ACTIVATE MSDIALOG oDlg CENTERED
*/
//if Eval(bValid) .and. Eval(bVali2) .and. Eval(bVali3)
	aRet := {.t.,cOpeClo,cLocClo,cPegClo,BCI->BCI_CODRDA}
//else
//	aRet := {.f.}
//endIf
BCI->(dbSetOrder(nOrdBCI))
BCI->(dbGoto(nRecBCI))

return aRet

static function PosNewRda(cCodOpe,cCodLocDig,cCodPEG,cCodRda)
local aAreaBAU	:= BAU->(getArea())
local aAreaBAX	:= BAX->(getArea())
local aAreaBAQ	:= BAQ->(getArea())
local aAreaBB8	:= BB8->(getArea())

BAU->(dbSetOrder(1))
BAU->(msSeek(xFilial("BAU")+cCodRda))

aNewRDA := {{"_CODRDA",BAU->BAU_CODIGO},;
			{"_CODBB0",BAU->BAU_CODBB0},;
			{"_NOMRDA",BAU->BAU_NOME},;
			{"_NREDUZ",BAU->BAU_NREDUZ},;
			{"_TIPRDA",BAU->BAU_TIPPE},;
			{"_DATBLO",BAU->BAU_DATBLO},;
			{"_CODBLO",BAU->BAU_CODBLO},;
			{"_CODESP",GetEspPri()},;
			{"_DESESP",Posicione("BAQ",1,xFilial("BAQ")+BAX->(BAX_CODINT+BAX_CODESP),"BAQ_DESCRI")},;
			{"_SUBESP",BAX->BAX_CODSUB},;
			{"_DESSUB",Posicione("BFN",1,xFilial("BFN")+BAX->(BAX_CODINT+BAX_CODESP+BAX_CODSUB),"BFN_DESCRI")},;
			{"_LOCATE",Posicione("BB8",1,xFilial("BB8")+BAU->BAU_CODIGO,"BB8_CODLOC+BB8_LOCAL")},;
			{"_LOCAL",BB8->BB8_LOCAL},;
			{"_ENDLOC",allTrim(BB8->BB8_END)+"+"+allTrim(BB8->BB8_NR_END)+"-"+allTrim(BB8->BB8_COMEND)+"-"+allTrim(BB8->BB8_BAIRRO)},;
			{"_CODLOC",BB8->BB8_CODLOC},;
			{"_DESLOC",BB8->BB8_DESLOC},;
			{"_CPFRDA",BAU->BAU_CPFCGC},;
			{"_CATHOS",BAU->BAU_CATHOS},;
			{"_TIPPRE",BAU->BAU_TIPPRE},;
			{"_OPERDA",cCodOpe},;
			{"_ALTCUS",BAU->BAU_ALTCUS},;
			{"_SIGLCR",BAU->BAU_SIGLCR},;
			{"_CONREG",BAU->BAU_CONREG}}

BAU->(restArea(aAreaBAU))
BAX->(restArea(aAreaBAX))
BAQ->(restArea(aAreaBAQ))
BB8->(restArea(aAreaBB8))

return

static function GetEspPri()
local cCodEsp := ""

BAX->(dbSetOrder(1))
BAX->(msSeek(xFilial("BAX")+BAU->BAU_CODIGO))

while (! BAX->(eof())) .and. BAX->BAX_CODIGO == BAU->BAU_CODIGO
	
	if BAX->BAX_ESPPRI == "1"
		cCodEsp := BAX->BAX_CODESP
		exit
	endIf
	BAX->(dbSkip())
endDo

return cCodEsp

static function DesField(cAliCp,cCampo)
local lRet    := .f.
local aFields := {"_DTGRCP","_INTFAT","_STAFAT","_NUMFAT","_OPEFAT","_NUMSE1",;
	"_NUMLOT","_OPELOT","_SEQPF","_PERCEN","_VLRTPF","_VLRPAG",;
	"_PERPF"}
local nI	  := 0

for nI:= 1 to len(aFields)
	if cAliCp+aFields[nI] == allTrim(cCampo)
		lRet := .t.
		exit
	endIf
next

return lRet

static function TraField(cAliCp, cCampo, aCabec)
local xRet    := nil
local aFields := {	"_CODRDA","_NOMRDA","_OPERDA","_TIPRDA","_ENDLOC","_SUBESP",;
					"_DESSUB","_CPFRDA","_TIPPRE","_CODLOC","_LOCAL","_DESLOC",;
					"_CODESP","_LOCATE","_DESESP" }
local nI	  := 0
local nPos	  := 0

for nI:= 1 to len(aFields)
	if cAliCp+aFields[nI] == allTrim(cCampo)
		if (nPos := ascan(aNewRDA,{|x| x[1] $ cCampo})) > 0
			xRet := aNewRDA[nPos][2]
		endIf
		exit
	endIf
next

return xRet

static function CABTRAGUI(cChaveOri,cChaveDes,aMatLin)
local nI		:= 0
local nTam		:= 0
local nQtdGuiT	:= 0
local cOpeOri	:= ""
local cLdpOri	:= ""
local cPegOri	:= ""
local cOpeDes	:= ""
local cLdpDes	:= ""
local cPegDes	:= ""
local cGuiOri	:= ""

//operadora Origem
nTam 		:= tamSX3("BCI_CODOPE")[1]
cOpeOri		:= left(cChaveOri,nTam)
cChaveOri 	:= subStr(cChaveOri,nTam+1,len(cChaveOri))

//local de origem
nTam 		:= tamSX3("BCI_CODLDP")[1]
cLdpOri		:= left(cChaveOri,nTam)
cChaveOri 	:= subStr(cChaveOri,nTam+1,len(cChaveOri))

//peg origem
nTam 		:= tamSX3("BCI_CODPEG")[1]
cPegOri		:= left(cChaveOri,nTam)

//operadora Destino
nTam 		:= tamSX3("BCI_CODOPE")[1]
cOpeDes		:= left(cChaveDes,nTam)
cChaveDes 	:= subStr(cChaveDes,nTam+1,len(cChaveDes))

//local Destino
nTam 		:= tamSX3("BCI_CODLDP")[1]
cLdpDes		:= left(cChaveDes,nTam)
cChaveDes 	:= subStr(cChaveDes,nTam+1,len(cChaveDes))

//local Destino
nTam 		:= tamSX3("BCI_CODPEG")[1]
cPegDes		:= left(cChaveDes,nTam)

procRegua(len(aMatLin))

nRecBCI := BCI->(recno())
nOrdBCI := BCI->(indexOrd())

BCI->(dbSetOrder(1))
if BCI->(MsSeek(xFilial('BCI')+cOpeDes+cLdpDes+cPegDes))
	
	if BCI->BCI_TIPGUI $ "03,05"
		cAliCab := "BE4"
	else
		cAliCab := "BD5"
	endIf
	
endIf

BCI->(dbSetOrder(nOrdBCI))
BCI->(dbGoto(nRecBCI))

//somente guias selecionadas
for nI := 1 to len(aMatLin)
	
	// somente a selecionada
	//if aMatLin[nI,len(aMatLin[nI])]

		nQtdGuiT++
		cGuiOri := aMatLin[nI,4]
		incProc("Transferindo guia ["+cGuiOri+"]")

		// retira a guia do peg origem e colocar no destino (guia a guia)
		PLSATUPEG(cOpeOri,cLdpOri,cPegOri,cGuiOri,cOpeDes,cLdpDes,cPegDes,cAliCab)
		
	//endIf
	
next

//atualiza quantidade de evento,valor apr e guias do peg
PLSATUPP(,,nQtdGuiT,.t.,cOpeDes,cLdpDes,cPegDes,(cOpeOri+cLdpOri+cPegOri))

//msgAlert("Transferência concluída com sucesso")

return(nil)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³PLSA500EXC ³ Autor ³ Daher		        | Data ³ 08.12.05 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³Vou excluir a guia clonada								  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
/*/
Static Function CABAEXC(cAlias,nReg,nOpc,aFields,lMsg)
LOCAL cChaveGui := &(cAlias+"->("+cAlias+"_CODOPE+"+cAlias+"_CODLDP+"+cAlias+"_CODPEG+"+cAlias+"_NUMERO+"+cAlias+"_ORIMOV)")
LOCAL cChaveAtu := "" //chave do clone
LOCAL cChaveOri := ""//chave da guia origem
LOCAL aArea		:= GetArea()
LOCAL dDatCtbChk := PLRtDtCTB(&(cAlias+"->"+cAlias+"_CODOPE"), &(cAlias+"->"+cAlias+"_CODLDP"), &(cAlias+"->"+cAlias+"_CODPEG"), &(cAlias+"->"+cAlias+"_NUMERO"), .F.)

DEFAULT lMsg    := .T.

if PLVLDBLQCO(dDatCtbChk, {"PLS011"}, lMsg) //verifica se a database está no periodo contabil e se estiver não pode excluir a guia
	If &(cAlias+"->(FieldPos('"+cAlias+"_GUESTO'))") == 0
		If lMsg
	 		Help("",1,"PLSA500028")
		Endif
		Restarea(aArea)
		Return
	Endif
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Com essa critica eu garanto a integridade								 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	
	If Empty(&(cAlias+"->"+cAlias+"_GUESTO"))
		If lMsg
			Help("",1,"PLSA500019")
		Endif
		Restarea(aArea)
		Return
	Endif
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifico aonde o usuario esta posicionado								 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If &(cAlias+"->"+cAlias+"_ESTORI") == '0'//estou posicionado no clone
	    	cChaveAtu := cChaveGui //chave do clone
	    	cChaveOri := alltrim(&(cAlias+"->"+cAlias+"_GUESTO"))//chave da guia origem
	Else
	    	cChaveAtu := alltrim(&(cAlias+"->"+cAlias+"_GUESTO"))       //chave do clone
	    	cChaveOri := cChaveGui//chave da guia origem
	Endif
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Posiciono no clone														 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If FindFunction("TcSqlFilter()")//teoricamente sempre tem q entrar aqui
		cFiltAli := &(cAlias+"->(TcSqlFilter())")
	Else
		cFiltAli := RetFiltro(cAlias,"BCI")
	Endif
	&(cAlias+"->(DbClearFilter())")
	
	DbSelectArea(cAlias)
	DbSetOrder(1)
	MsSeek(xFilial(cAlias)+subs(cChaveAtu,1,24))
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Com essa critica eu garanto a integridade								 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If &(cAlias+"_FASE") <> '1'
		If lMsg
			Help("",1,"PLSA500020")
		Endif
		If !Empty(cFiltAli)
			DbSelectArea(cAlias)
			DbSetFilter({||&cFiltAli},cFiltAli)
		Endif
		Restarea(aArea)
		Return
	Endif
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Se ja foi analisada a divergencia entre as duas guias nao se pode excluir³
	//| o clone																	 |
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If !Empty(&(cAlias+"->"+cAlias+"_SEQEST"))
		If lMsg
			Help("",1,"PLSA500021")
		Endif
		If !Empty(cFiltAli)
			DbSelectArea(cAlias)
			DbSetFilter({||&cFiltAli},cFiltAli)
		Endif
		Restarea(aArea)
		Return
	Endif
/*	If lMsg .and. !MsgYesNo(STR0112) //"Deseja realmente excluir a guia?"
		If !Empty(cFiltAli)
			DbSelectArea(cAlias)
			DbSetFilter({||&cFiltAli},cFiltAli)
		Endif
		Restarea(aArea)
		Return
	Endif
*/	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Inicio da transacao													     ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	Begin Transaction
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Limpo os campos da guia origem											 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If MsSeek(xFilial(cAlias)+subs(cChaveOri,1,24))
		Reclock(cAlias,.F.)
			&(cAlias+"_GUESTO") := ''
			&(cAlias+"_ESTORI") := ''
		MsUnlock()
	Endif
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Limpo os campos do BD6 da guia origem									 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	BD6->(DbSetOrder(1))
	If BD6->(MsSeek(xFilial("BD6")+cChaveOri))
		While !BD6->(Eof()) .and. BD6->(BD6_FILIAL+BD6_CODOPE+BD6_CODLDP+BD6_CODPEG+BD6_NUMERO+BD6_ORIMOV) == ;
			   							 xFilial("BD6")+cChaveOri
					BD7->(DbSetOrder(1))
			    	If BD7->(MsSeek(xFilial("BD7")+BD6->(BD6_CODOPE+BD6_CODLDP+BD6_CODPEG+BD6_NUMERO+BD6_ORIMOV+BD6_SEQUEN)))
			    		While ! BD7->(Eof()) .And. BD7->(BD7_FILIAL+BD7_CODOPE+BD7_CODLDP+BD7_CODPEG+BD7_NUMERO+BD7_ORIMOV+BD7_SEQUEN) == ;
			     									xFilial("BD6")+BD6->(BD6_CODOPE+BD6_CODLDP+BD6_CODPEG+BD6_NUMERO+BD6_ORIMOV+BD6_SEQUEN)
	
				            BD7->(Reclock("BD7",.F.))
								BD7->BD7_TPESTO := '1'
								BD7->BD7_CONCOB := '1'
								BD7->BD7_CONPAG := '1'
							BD7->(MsUnlock())
	
			     			BD7->(DbSkip())
			     		Enddo
					Endif
	
					BD6->(Reclock("BD6",.F.))
						BD6->BD6_TPESTO := '1'
						BD6->BD6_CONCOB := '1'
						BD6->BD6_CONPAG := '1'
					BD6->(MsUnlock())
	
					BD6->(DbSkip())
		Enddo
	Endif
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Posiciono no clone														 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	DbSelectArea(cAlias)
	DbSetOrder(1)
	MsSeek(xFilial(cAlias)+subs(cChaveAtu,1,24))
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Limpo os BD6 do clone													 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	BD6->(DbSetOrder(1))
	If BD6->(MsSeek(xFilial("BD6")+cChaveAtu))
		While !BD6->(Eof()) .and. BD6->(BD6_FILIAL+BD6_CODOPE+BD6_CODLDP+BD6_CODPEG+BD6_NUMERO+BD6_ORIMOV) == ;
			   							 xFilial("BD6")+cChaveAtu
					BD7->(DbSetOrder(1))
			    	If BD7->(MsSeek(xFilial("BD7")+BD6->(BD6_CODOPE+BD6_CODLDP+BD6_CODPEG+BD6_NUMERO+BD6_ORIMOV+BD6_SEQUEN)))
			    		While ! BD7->(Eof()) .And. BD7->(BD7_FILIAL+BD7_CODOPE+BD7_CODLDP+BD7_CODPEG+BD7_NUMERO+BD7_ORIMOV+BD7_SEQUEN) == ;
			     									xFilial("BD6")+BD6->(BD6_CODOPE+BD6_CODLDP+BD6_CODPEG+BD6_NUMERO+BD6_ORIMOV+BD6_SEQUEN)
	
				            BD7->(Reclock("BD7",.F.))
							BD7->(DbDelete())
							BD7->(MsUnlock())
	
			     			BD7->(DbSkip())
			     		Enddo
					Endif
	
					BD6->(Reclock("BD6",.F.))
					BD6->(DbDelete())
					BD6->(MsUnlock())
	
					BD6->(DbSkip())
		Enddo
	Endif
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Deleto o clone															 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	Reclock(cAlias,.F.)
		DbDelete()
	MsUnlock()
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Final da transacao													     ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	End Transaction
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Posiciono na guia origem												 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	DbSelectArea(cAlias)
	DbSetOrder(1)
	MsSeek(xFilial(cAlias)+subs(cChaveOri,1,24))
	If !Empty(cFiltAli)
		DbSelectArea(cAlias)
		DbSetFilter({||&cFiltAli},cFiltAli)
	Endif
/*	If lMsg
		MsgInfo(STR0113) //"Exclusão concluida com sucesso !!!"
	Endif*/
EndIf

Return

Static Function fExcClone()
    Local nAtual := 0
    Local nTotal := 0
	Local cQryClone := ""
    Local cAliQry1  := "CLONE"
    Local cQryPEG   := ""
    Local cAliQry2  := "PEG0022"
    Local aMatLin   := {}
    Local cCodLdp   := "0019"//"0022" //MOVIMENTACAO CUSTO X CONTABILIDADE  
    Local cMesPeg   := "01"   //MUDAR PARA CADA COMPETENCIA
    Local cAnoPeg   := "2021" //MUDAR PARA CADA COMPETENCIA
    Local dDataPeg  := STOD("20210101") //MUDAR PARA CADA COMPETENCIA
	Local nParcela  := 1 //MUDAR PARA CADA COMPETENCIA
    Local _cChkOri  := ""   
    Local cPegDes   := ""
    Local X         := 0                     

    PRIVATE objCENFUNLGP := CENFUNLGP():New()
    
    dDatabase := dDataPeg

    cQryClone := " SELECT BD5.BD5_CODOPE  "  + cEnt
    cQryClone += "      , BD5.BD5_CODLDP   "  + cEnt
    cQryClone += "       , BD5.BD5_CODPEG "  + cEnt
    cQryClone += "       , BD5.BD5_NUMERO  "  + cEnt
    cQryClone += "       , BD5CLO.BD5_CODOPE CODOPE_CLO  "  + cEnt
    cQryClone += "       , BD5CLO.BD5_CODLDP CODLDP_CLO "  + cEnt
    cQryClone += "       , BD5CLO.BD5_CODPEG CODPEG_CLO "  + cEnt
    cQryClone += "       , BD5CLO.BD5_NUMERO NUMGUI_CLO "  + cEnt
    cQryClone += "       , BD5.BD5_OPEUSR||BD5.BD5_MATRIC||BD5.BD5_TIPREG||BD5.BD5_TIPREG||BD5.BD5_DIGITO MATRIC "  + cEnt
    cQryClone += "       , BD5.BD5_NOMUSR "  + cEnt
    cQryClone += "       , BD5.BD5_SITUAC "  + cEnt
    cQryClone += "       , BD5.BD5_FASE "  + cEnt
    cQryClone += "       , BD5CLO.BD5_SITUAC SIT_CLO "  + cEnt
    cQryClone += "       , BD5CLO.BD5_FASE FASE_CLO "  + cEnt
    cQryClone += "       , BD5.BD5_VLRAPR "  + cEnt
    cQryClone += "       , BD5.BD5_VLRBPR "  + cEnt
    cQryClone += "       , BD5.BD5_VLRGLO "  + cEnt
    cQryClone += "       , BD5.BD5_VLRPAG "  + cEnt
    cQryClone += "       , BD5.BD5_VLRMAN "  + cEnt
    cQryClone += "       , BD5.BD5_VALORI "  + cEnt
    cQryClone += "       , BD5CLO.BD5_VLRAPR APR_CLO "  + cEnt
    cQryClone += "       , BD5CLO.BD5_VLRBPR BPR_CLO "  + cEnt
    cQryClone += "       , BD5CLO.BD5_VLRGLO GLO_CLO "  + cEnt
    cQryClone += "       , BD5CLO.BD5_VLRPAG PAG_CLO "  + cEnt
    cQryClone += "       , BD5CLO.BD5_VLRMAN MAN_CLO "  + cEnt
    cQryClone += "       , BD5CLO.BD5_VALORI VALORI_CLO "  + cEnt
    cQryClone += "       , BD5CLO.R_E_C_N_O_ RECNO_CLO "  + cEnt
    cQryClone += "      FROM TEMP_RECUP_2021,BD5010 BD5, BD5010 BD5CLO "  + cEnt
    cQryClone += "      WHERE BD5.BD5_FILIAL = ' '  "  + cEnt
    cQryClone += "      AND BD5CLO.BD5_FILIAL = ' ' "  + cEnt
    cQryClone += "      AND BD5.BD5_OPEUSR='0001'  "  + cEnt
    cQryClone += "      AND BD5.BD5_CODRDA IN ('138460','138851','111406','111414','124796','140040','134210','140171','140139','140147','140155')   "  + cEnt
    cQryClone += "      AND BD5.BD5_CODRDA=CODRDA  "  + cEnt
    cQryClone += "      AND BD5.BD5_ANOPAG=ANOPAG  "  + cEnt
    cQryClone += "      AND BD5.BD5_MESPAG=MESPAG  "  + cEnt
    cQryClone += "      AND PARCELA=1          "  + cEnt
    cQryClone += "      AND BD5.BD5_CODLDP=LOCAL   "  + cEnt
    cQryClone += "      AND BD5.BD5_CODPEG=PEG     "  + cEnt
    cQryClone += "      AND BD5.BD5_NUMERO=NUMERO  "  + cEnt
    cQryClone += "      AND BD5.BD5_CODLDP = '0002'  "  + cEnt
    cQryClone += "      AND BD5CLO.BD5_CODLDP = '0002' "  + cEnt
    cQryClone += "      AND BD5CLO.BD5_CODOPE = '0001' "  + cEnt
    cQryClone += "      AND BD5CLO.BD5_SITUAC = '1' "  + cEnt
	cQryClone += "      AND BD5CLO.BD5_FASE = '1' "  + cEnt
    cQryClone += "      AND BD5.BD5_CODOPE = SUBSTR(BD5CLO.BD5_GUESTO,1,4) "  + cEnt
    cQryClone += "      AND BD5.BD5_CODLDP = SUBSTR(BD5CLO.BD5_GUESTO,5,4) "  + cEnt
    cQryClone += "      AND BD5.BD5_CODPEG = SUBSTR(BD5CLO.BD5_GUESTO,9,8) "  + cEnt
    cQryClone += "      AND BD5.BD5_NUMERO = SUBSTR(BD5CLO.BD5_GUESTO,17,8) "  + cEnt
    cQryClone += "      AND BD5.D_E_L_E_T_ = ' ' "  + cEnt
    cQryClone += "      AND BD5CLO.D_E_L_E_T_ = ' ' "  + cEnt
    
	If Select(cAliQry1)>0
        (cAliQry1)->(DbCloseArea())
    EndIf
    
	memowrite('c:\TEMP\cabaexcclo.sql',cQryClone)                            
    
	DbUseArea(.T.,"TopConn",TcGenQry(,,cQryClone),cAliQry1,.T.,.T.)
        
    While !(cAliQry1)->(EOF())
		nTotal++	
        (cAliQry1)->(DbSkip())
    Enddo

    ProcRegua(nTotal)

    DbSelectArea(cAliQry1)

	(cAliQry1)->(DbGotop())

    While !(cAliQry1)->(EOF())
		nAtual++
        IncProc("Excluindo Clones de Guia << " +  (cAliQry1)->(CODLDP_CLO+CODPEG_CLO+NUMGUI_CLO) +" >> Posição: " + cValToChar(nAtual) + " de " + cValToChar(nTotal) + "...")

        DbSelectArea("BD5")
        BD5->(DbGoTo((cAliQry1)->RECNO_CLO))

        DbSelectArea("BD6")

        DbSelectArea("BD7")

        CabaEXC("BD5",(cAliQry1)->RECNO_CLO,3,nil,.f.)

        BD5->(DbCloseArea())
        BD6->(DbCloseArea())
        BD7->(DbCloseArea())

        (cAliQry1)->(DbSkip())

    Enddo

    Alert("CONCLUIDO")

Return

Static Function fTransClone()
    Local nAtual := 0
    Local nTotal := 0
	Local cQryClone := ""
    Local cAliQry1  := "CLONE"
    //Local cQryPEG   := ""
    //Local cAliQry2  := "PEG0022"
    Local aMatLin   := {}
    Local cCodLdp   := "0019"//"0022" //MOVIMENTACAO CUSTO X CONTABILIDADE  
    Local cMesPeg   := "01"   //MUDAR PARA CADA COMPETENCIA
    Local cAnoPeg   := "2021" //MUDAR PARA CADA COMPETENCIA
    Local dDataPeg  := STOD("20210101") //MUDAR PARA CADA COMPETENCIA
	//Local nParcela  := 1 //MUDAR PARA CADA COMPETENCIA
    Local _cChkOri  := ""   
    Local cPegDes   := ""
    Local X         := 0                     

    PRIVATE objCENFUNLGP := CENFUNLGP():New()
    
    dDatabase := dDataPeg

    cQryClone := " SELECT BD5.BD5_CODOPE   "  + cEnt
    cQryClone += "      , BD5.BD5_CODLDP   "  + cEnt
    cQryClone += "       , BD5.BD5_CODPEG "  + cEnt
    cQryClone += "       , BD5.BD5_NUMERO  "  + cEnt
	cQryClone += "       , BD5.BD5_CODRDA  "  + cEnt
	cQryClone += "       , BD5.R_E_C_N_O_ RECBD5  "  + cEnt
    cQryClone += "       , BD5CLO.BD5_CODOPE CODOPE_CLO  "  + cEnt
    cQryClone += "       , BD5CLO.BD5_CODLDP CODLDP_CLO "  + cEnt
    cQryClone += "       , BD5CLO.BD5_CODPEG CODPEG_CLO "  + cEnt
    cQryClone += "       , BD5CLO.BD5_NUMERO NUMGUI_CLO "  + cEnt
    cQryClone += "       , BD5.BD5_OPEUSR||BD5.BD5_MATRIC||BD5.BD5_TIPREG||BD5.BD5_TIPREG||BD5.BD5_DIGITO MATRIC "  + cEnt
    cQryClone += "       , BD5.BD5_NOMUSR "  + cEnt
    cQryClone += "       , BD5.BD5_SITUAC "  + cEnt
    cQryClone += "       , BD5.BD5_FASE "  + cEnt
    cQryClone += "       , BD5CLO.BD5_SITUAC SIT_CLO "  + cEnt
    cQryClone += "       , BD5CLO.BD5_FASE FASE_CLO "  + cEnt
    cQryClone += "       , BD5.BD5_VLRAPR "  + cEnt
    cQryClone += "       , BD5.BD5_VLRBPR "  + cEnt
    cQryClone += "       , BD5.BD5_VLRGLO "  + cEnt
    cQryClone += "       , BD5.BD5_VLRPAG "  + cEnt
    cQryClone += "       , BD5.BD5_VLRMAN "  + cEnt
    cQryClone += "       , BD5.BD5_VALORI "  + cEnt
    cQryClone += "       , BD5CLO.BD5_VLRAPR APR_CLO "  + cEnt
    cQryClone += "       , BD5CLO.BD5_VLRBPR BPR_CLO "  + cEnt
    cQryClone += "       , BD5CLO.BD5_VLRGLO GLO_CLO "  + cEnt
    cQryClone += "       , BD5CLO.BD5_VLRPAG PAG_CLO "  + cEnt
    cQryClone += "       , BD5CLO.BD5_VLRMAN MAN_CLO "  + cEnt
    cQryClone += "       , BD5CLO.BD5_VALORI VALORI_CLO "  + cEnt
    cQryClone += "       , BD5CLO.R_E_C_N_O_ RECNO_CLO "  + cEnt
    cQryClone += "      FROM TEMP_RECUP_2021,BD5010 BD5, BD5010 BD5CLO "  + cEnt
    cQryClone += "      WHERE BD5.BD5_FILIAL = ' '  "  + cEnt
    cQryClone += "      AND BD5CLO.BD5_FILIAL = ' ' "  + cEnt
    cQryClone += "      AND BD5.BD5_OPEUSR='0001'  "  + cEnt
    cQryClone += "      AND BD5.BD5_CODRDA IN ('138460','138851','111406','111414','124796','140040','134210','140171','140139','140147','140155')   "  + cEnt
    cQryClone += "      AND BD5.BD5_CODRDA=CODRDA  "  + cEnt
    cQryClone += "      AND BD5.BD5_ANOPAG=ANOPAG  "  + cEnt
    cQryClone += "      AND BD5.BD5_MESPAG=MESPAG  "  + cEnt
    cQryClone += "      AND PARCELA=1          "  + cEnt
    cQryClone += "      AND BD5.BD5_CODLDP=LOCAL   "  + cEnt
    cQryClone += "      AND BD5.BD5_CODPEG=PEG     "  + cEnt
    cQryClone += "      AND BD5.BD5_NUMERO=NUMERO  "  + cEnt
    cQryClone += "      AND BD5.BD5_CODOPE = '0001' " + cEnt
    cQryClone += "      AND BD5.BD5_CODOPE = BD5CLO.BD5_CODOPE "  + cEnt
	cQryClone += "      AND BD5.BD5_CODLDP = BD5CLO.BD5_CODLDP "  + cEnt
	cQryClone += "      AND BD5.BD5_CODPEG = BD5CLO.BD5_CODPEG "  + cEnt
	//cQryClone += "      AND BD5.BD5_CODLDP = '0002'  "  + cEnt
    //cQryClone += "      AND BD5CLO.BD5_CODLDP = '0002' "  + cEnt
	cQryClone += "      AND BD5CLO.BD5_SITUAC = '1' "  + cEnt
	cQryClone += "      AND BD5CLO.BD5_FASE = '1' "  + cEnt
    cQryClone += "      AND BD5.BD5_CODOPE = SUBSTR(BD5CLO.BD5_GUESTO,1,4) "  + cEnt
    cQryClone += "      AND BD5.BD5_CODLDP = SUBSTR(BD5CLO.BD5_GUESTO,5,4) "  + cEnt
    cQryClone += "      AND BD5.BD5_CODPEG = SUBSTR(BD5CLO.BD5_GUESTO,9,8) "  + cEnt
    cQryClone += "      AND BD5.BD5_NUMERO = SUBSTR(BD5CLO.BD5_GUESTO,17,8) "  + cEnt
    cQryClone += "      AND BD5.D_E_L_E_T_ = ' ' "  + cEnt
    cQryClone += "      AND BD5CLO.D_E_L_E_T_ = ' ' "  + cEnt
    
	If Select(cAliQry1)>0
        (cAliQry1)->(DbCloseArea())
    EndIf
    
	memowrite('c:\TEMP\cabatransclo.sql',cQryClone)                            
    
	DbUseArea(.T.,"TopConn",TcGenQry(,,cQryClone),cAliQry1,.T.,.T.)
        
    While !(cAliQry1)->(EOF())
		nTotal++	
        (cAliQry1)->(DbSkip())
    Enddo

    ProcRegua(nTotal)

    DbSelectArea(cAliQry1)

	(cAliQry1)->(DbGotop())

    While !(cAliQry1)->(EOF())
		nAtual++
        IncProc("Transferindo Guia << " +  (cAliQry1)->(BD5_CODLDP+BD5_CODPEG+BD5_NUMERO) +" >> Posição: " + cValToChar(nAtual) + " de " + cValToChar(nTotal) + "...")
     
        DbSelectArea("BD5")
        BD5->(DbGoTo((cAliQry1)->RECBD5))
		aMatLin := {}
        aadd(aMatLin,{"1",;  //RETCBOX("BD5_SITUAC",BD5->BD5_SITUAC)
                      "1",;  //RETCBOX("BD5_FASE",BD5->BD5_FASE)
                      DTOC(BD5->BD5_DATPRO),;
                      SUBSTR(BD5->BD5_GUESTO,17,8),;  //BD5_NUMERO
                      transForm(BD5->BD5_NRLBOR,PesqPict("BE1","BE1_NUMAUT")),;
                      transForm(BD5->(BD5_OPEUSR+BD5_CODEMP+BD5_MATRIC+BD5_TIPREG+BD5_DIGITO),"@R !!!!.!!!!.!!!!!!-!!.!"),;
                      allTrim(BD5->BD5_NOMUSR),;
                      transForm(BD5->BD5_VLRPAG,"@E 999,999,999.99"),;
                      .f.})
					  //;
                      //PLSINTPAD() + (cAliQry1)->(BD5_CODLDP) + (cAliQry1)->(BD5_CODPEG),;
                      //(cAliQry1)->(BD5_CODRDA)}) 
        
        BD5->(DbCloseArea())
		
		_cChkOri := PLSINTPAD() + (cAliQry1)->(BD5_CODLDP) + (cAliQry1)->(BD5_CODPEG)

		//Ponteiro para pegar a BCI Destino
        BCI->(dbSetOrder(4)) //BCI_FILIAL, BCI_OPERDA, BCI_CODRDA, BCI_ANO, BCI_MES, BCI_TIPO, BCI_FASE, BCI_SITUAC, BCI_TIPGUI, BCI_CODLDP
        cChaveBCI := PLSINTPAD() + (cAliQry1)->(BD5_CODRDA) + cAnoPeg + cMesPeg + "2" + "1" + "1" + "02" + cCodLDP
        If BCI->( MsSeek(xFilial("BCI")+cChaveBCI) )
            cPegDes  := BCI->(BCI_CODOPE+BCI_CODLDP+BCI_CODPEG)
        Endif

        If !Empty(_cChkOri) .and. !Empty(cPegDes) .and. !Empty(aMatLin) .and. _cChkOri <> cPegDes 
            CABTRAGUI(_cChkOri,cPegDes,aMatLin)
        Endif
    
		BCI->(DbCloseArea())

        (cAliQry1)->(DbSkip())

    Enddo

    Alert("CONCLUIDO")

Return
