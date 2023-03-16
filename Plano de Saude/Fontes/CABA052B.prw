#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'TOPCONN.CH'
#Include 'PLSMGER.CH'

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �CABA052B  �Autor  �Renato Peixoto      � Data �  20/10/11   ���
�������������������������������������������������������������������������͹��
���Desc.     �Rotina respons�vel por realizar o rateio do bonus pago      ���
���          �opcionalmente para o projeto AED (quando for o caso).       ���
�������������������������������������������������������������������������͹��
���Uso       � CABERJ                                                     ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

User Function CABA052B()

Private cPerg      := "CABA52B"
Private cCodInt    := PLSINTPAD() 
Private cNomInt    := ""
Private cCodRDA    := ""
Private aDadosBene := {} 
Private aArray1    := {}
Private dDtEvento  := dDataBase
Private nValorRat  := 0
Private cCodPad    := "16"//"01"  Motta chamado 58993
Private cProAED    := GETMV("MV_XPROAED")   
Private cCodPla    := ""  
Private cCodPla1   := ""
Private cDesPla    := ""
Private cLocalBB8  := ""
Private cCodLoc    := ""
Private cDesLocBB8 := ""
Private cBB8END    := ""
Private cBB8NR_END := ""
Private cBB8COMEND := ""
Private cBB8Bairro := ""
Private cCodEsp    := ""
Private j          := 0
Private k          := 0 
Private lOk        := .F.
Private cCompet    := ""
Private cAno       := ""
Private cMes       := ""  
Private cTipProd   := "Projeto AED"
Private aVetUsu	   := {}
Private nCont      := 0  
Private lGerouRat  := .F.
Private aVetRat    := {} 
Private cSiglaProf := ""
Private cUFProf    := ""
Private cOperProf  := ""
Private cCRMProf   := ""
Private cCodProf   := ""
Private cNomProf   := ""
Private cCodPegRat := ""
Private nTotBenRDA := 0
Private nTotRat    := 0

CriaSX1()

IF !Pergunte(cPerg,.T.)
	Return
EndIF

If lOk                       
	INCLUI := .T. //Chumbado como .T., pq essa vari�vel � utilizada em um inicializador padr�o de campo da tabela BD5

	cCodRDA   := MV_PAR03
	cCompet   := MV_PAR01
	dDtEvento := MV_PAR02  
	nValorRat := MV_PAR04
	
	DbSelectArea("PAI")
	DbSetOrder(1)
	If DbSeek(XFILIAL("PAI")+cCodRDA)
		cSiglaProf := PAI->PAI_SIGLA
		cUFProf    := PAI->PAI_UFPROF
		cOperProf  := PAI->PAI_CODOPE
		cCRMProf   := PAI->PAI_CRM  
		cCodProf   := PAI->PAI_CODBB0
		cNomProf   := PAI->PAI_NOMBB0
	EndIf
	
	cAno := SUBSTR(cCompet,3,4)
	cMes := SUBSTR(cCompet,1,2)
	
	If APMSGYESNO("Deseja gerar o pagamento AED com os usu�rios selecionados?","Pagamento AED.")
		Processa( {|| U_XRateioAED() }, "Aguarde...", "Incluindo guias no contas m�dicas...",.F.)
	EndIf
		
EndIf

If lGerouRat
	APMSGINFO("Rotina de pagamento AED foi executada com sucesso e houve guia criada no contas m�dicas com os par�metros informados. Verifique a PEG "+cCodPegRat+" dentro do contas m�dicas para ver os resultados.")
Else
	APMSGSTOP("Aten��o, n�o foi gerada nenhuma guia de pagamento para os par�metros informados. Provavelmente o pagamento referente aos benefici�rios escolhidos j� foi gerado para esta compet�ncia e este RDA. Por favor verifique os par�metros e tente novamente.","Nenhum pagamento foi gerado!")
EndIf

Return



/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �XRateioAED�Autor  �Renato Peixoto      � Data �  03/10/11   ���
�������������������������������������������������������������������������͹��
���Desc.     �Rotina que vai chamar o processamento do rateio AED;        ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                         ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function XRateioAED()

//Local j := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

Local cQuery     := ""    
Local cArqQryBon := GetNextAlias()
Local nTotBon    := 0

//Alterado por Renato Peixoto em 11/07/12 para otimizar a logica no caso da geracao de rateio de bonus AED.
cQuery := "SELECT count(PB2_COMPET) TOTBONUS "
cQuery += "FROM "+RetSqlName("PB2")+" PB2 "
cQuery += "WHERE D_E_L_E_T_ = ' ' "
cQuery += "AND pb2_filial = '  ' "
cQuery += "AND pb2_compet = '"+cCompet+"' "
cQuery += "AND pb2_bonus = 'S' "
cQuery += "AND pb2_rda = '"+cCodRDA+"' "

If Select(cArqQryBon)>0

	(cArqQryBon)->(DbCloseArea())

EndIf

DbUseArea(.T.,"TopConn",TcGenQry(,,cQuery),cArqQryBon,.T.,.T.)

nTotBon := (cArqQryBon)->TOTBONUS

If nTotBon > 0 //Fim Alteacao Renato Peixoto.
	If !(APMSGYESNO("Aten��o, j� existe pagamento de b�nus gerado para este RDA nesta compet�ncia. Somente ser�o gerados pagamentos de b�nus para benefici�rios desse RDA que ainda n�o tenham sido escolhidos para esta compet�ncia. Deseja continuar?","J� existe pagamento de b�nus para este RDA na compet�ncia informada."))
		Return
	Else
		nCont := Len(aVetUsu)
		ProcRegua(nCont)
		For j := 1 To Len(aVetusu)
			If aVetUsu[j][2]
    			//Indice PB2: PB2_FILIAL+PB2_COMPET+PB2_RDA+PB2_CODINT+PB2_CODEMP+PB2_MATRIC+PB2_TIPREG+PB2_DIGITO  
    			DbSelectArea("PB2")
    			DbSetOrder(2)
    			//S� vou gerar o rateio se o mesmo ainda n�o tiver sido gerado para este RDA/Beneficiario na competencia escolhida
    			If !(DbSeek(XFILIAL("PB2")+cCompet+cCodRDA+cCodInt+aVetUsu[j][4]+aVetUsu[j][5]+aVetUsu[j][14]+aVetUsu[j][15]+"S"))
    				IncProc('Gerando pagamento para o RDA '+cCodRDA+', usu�rio '+aVetUsu[j][10]+'...')
    				/*If aVetUsu[j][3]
    					For k := 1 To 2 
    						DbSelectArea("PB2")
    						DbSetOrder(3)
    						If !(DbSeek(XFILIAL("PB2")+cCompet+cCodRDA+cCodInt+aVetUsu[j][4]+aVetUsu[j][5]+aVetUsu[j][14]+aVetUsu[j][15]+"S"))
    							U_GERAAEDB()
    						EndIf
    						                    //matric        nomusr          tipreg         digito
    						aAdd(aVetRat, {aVetUsu[j][5],aVetUsu[j][10],aVetUsu[j][14],aVetUsu[j][15]} )
    						nTotRat += nValorRat
    					Next k
    				Else */
    					U_GERAAEDB()
    					aAdd(aVetRat, {aVetUsu[j][5],aVetUsu[j][10],aVetUsu[j][14],aVetUsu[j][15]} )
    					nTotRat += nValorRat
    				//EndIf
    				//U_GERAAEDB()
    			    
    			EndIf
   			Else
   				IncProc('Processando...')
   			EndIf
        Next j
   		//Chama o relat�rio do que foi gerado de pagamento AED
   		If lGerouRat
   			If APMSGYESNO("Deseja gerar o relat�rio do pagamento que acabou de ser gerado?","Emite relat�rio?")
   				U_RELAEDB()	
   			EndIf
   		EndIf
 	EndIf   
Else
	nCont := Len(aVetUsu)
	ProcRegua(nCont)
	For j := 1 To Len(aVetusu)
		If aVetUsu[j][2]
    		//Indice PB2: PB2_FILIAL+PB2_COMPET+PB2_RDA+PB2_CODINT+PB2_CODEMP+PB2_MATRIC+PB2_TIPREG+PB2_DIGITO  
    		//DbSelectArea("PB2")
    		//DbSetOrder(1)
    			//S� vou gerar o rateio se o mesmo ainda n�o tiver sido gerado para este RDA/Beneficiario na competencia escolhida
    		//If !(DbSeek(XFILIAL("PB2")+cCompet+cCodRDA+cCodInt+aVetUsu[j][4]+aVetUsu[j][5]+aVetUsu[j][14]+aVetUsu[j][15]))
    		IncProc('Gerando pagamento para o RDA '+cCodRDA+', usu�rio '+aVetUsu[j][10]+'...')
    		//If aVetUsu[j][3]
    		  //	For k := 1 To 2 
    				U_GERAAEDB()
    				aAdd(aVetRat, {aVetUsu[j][5],aVetUsu[j][10],aVetUsu[j][14],aVetUsu[j][15]} )
    		   		nTotRat += nValorRat
    		   //	Next k
    		//EndIf
    		                    //matric        nomusr          tipreg         digito
    		
    		//EndIf
   		Else
   				IncProc('Processando...')
   		EndIf
    Next j
   	//Chama o relat�rio do que foi gerado de pagamento AED
   	If lGerouRat
   		If APMSGYESNO("Deseja gerar o relat�rio do pagamento que acabou de ser gerado?","Emite relat�rio?")
   			U_RELAEDB()	
   		EndIf
   	EndIf
   	
EndIf

//Encerro a area aberta para verificar a quantidade de guias de rateio de bonus que foram geradas na competencia
(cArqQryBon)->(DbCloseArea())

Return

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �RETLOGIN  �Autor  �Leonardo Portella   � Data �  12/08/11   ���
�������������������������������������������������������������������������͹��
���Desc.     �Funcao usuada na consulta especifica LOGIN e que retorna os ���
���          �codigos dos usuarios Protheus selecionados.                 ���
�������������������������������������������������������������������������͹��
���Uso       � CABERJ                                                     ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

User Function XRetUsrAED(lUnicaMar)

Local lConfirm	:= .F.
Local cLog 		:= ""
Local aPesq		:= {'Matricula','Nome','Projeto'}
Local cCombo 	:= aPesq[1]   
Local nOpca		:= 0     
Local nTam		:= Len(UsrFullName(RetCodUsr()))
Local cBusca	:= Space(nTam)
Local bPesq		:= {||.T.,nOpca := Pesquisa(aVetUsu,cCombo,allTrim(cBusca),lPalChave,oBrowse:nAt),If(nOpca > 0,oBrowse:nAt := nOpca,),oBrowse:Refresh()}
Local aCab		:= {" "," ","Dobra Pgto?","Matricula","Nome","Projeto"}
Local aTam		:= {20,20,50,100,50,50}
Local lPalChave	:= .F.  
Local bDesMarca	:= {||aVetUsu := DesMarca(aVetUsu)}
Local lBuffer	:= .F.
Local i         := 0

Default lUnicaMar := .F.

Private oDlg 	:= nil
Private oBrowse	:= nil
Private oBrowse2:= nil
Private nPos 	:= 0
Private oOk    	:= LoadBitMap(GetResources(),"LBOK")
Private oNo    	:= LoadBitMap(GetResources(),"LBNO")
Private oPaga	:= LoadBitMap(GetResources(),"BR_VERDE")
Private oNaoPag	:= LoadBitMap(GetResources(),"BR_VERMELHO")
Private oPagDbr	:= LoadBitMap(GetResources(),"BR_LARANJA")

SetPrvt("oDlg1","oCBox1")

Processa({||aVetUsu := RetArrUsr()})

If Len(aVetUsu) = 0
	APMSGSTOP("Aten��o, n�o existe benefici�rio AED cadastrado para este RDA. Por favor, escolha outro RDA.","N�o h� benefici�rios.")
	Return
EndIf

oDlg := MSDialog():New(0,0,510,850,"Sele��o de usu�rios AED por RDA",,,.F.,,,,,,.T.,,,.T. )
	
	oGrp1      	:= TGroup():New( 005,010,025,420,"",oDlg1,CLR_BLACK,CLR_WHITE,.T.,.F. )
	
	oTBitmap1 	:= TBitmap():New(010,015,260,184,,"",.T.,oGrp1,,,.F.,.F.,,,.F.,,.T.,,.F.) 
	oTBitmap1:Load("BR_VERDE") 
	
	oSay1      	:= TSay():New( 010,030,{||'Pagamento Normal'},oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,528,020)
	
	oTBitmap2 	:= TBitmap():New(010,100,260,184,,"",.T.,oGrp1,,,.F.,.F.,,,.F.,,.T.,,.F.) 
	oTBitmap2:Load("BR_VERMELHO") 
	
	oSay2      	:= TSay():New( 010,115,{||'Sem Pagamento'},oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,528,020)
	
	oTBitmap3 	:= TBitmap():New(010,200,260,184,,"",.T.,oGrp1,,,.F.,.F.,,,.F.,,.T.,,.F.) 
	oTBitmap3:Load("BR_LARANJA") 
	
	oSay3      	:= TSay():New( 010,215,{||'Pagamento Dobrado'},oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,528,020)
	    
	oBrowse := TCBrowse():New(030,010,410,190,,aCab,aTam,oDlg,,,,,{|| },,,,,,,.F.,,.T.,,.F.,,, )
    oBrowse:SetArray(aVetUsu) 
    
    oBrowse:bLDblClick := {||U_AjuCels()}//lEditCell(aVetUsu,oBrowse,,oBrowse:nColPos)
    
    oBrowse:bLine := {||{If(aVetUsu[oBrowse:nAt,2] .and. aVetUsu[oBrowse:nAt,3],oPagDbr,If(aVetUsu[oBrowse:nAt,2],oPaga,oNaoPag)),;
    					If(aVetUsu[oBrowse:nAt,2],oOk,oNo)	,;
						If(aVetUsu[oBrowse:nAt,3],oOk,oNo)	,;
						aVetUsu[oBrowse:nAt,5]  				,;
						aVetUsu[oBrowse:nAt,10] 			   	,;
						aVetUsu[oBrowse:nAt,6]				,;
						}} 

  	oSay4      := TSay():New( 230,030,{||'QTD DE BENEFICI�RIOS PARA ESSE RDA:  '+STR(nTotBenRDA)},oDlg,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,528,020)
  	oSBtn3     := SButton():New(230,325,06,{||U_RelLstB(aVetUsu)} ,oDlg,.T.,,)
  	oSBtn1     := SButton():New(230,365,1,{||lConfirm := .T.,oDlg:End()}	,oDlg,,"", )
	oSBtn2     := SButton():New(230,395,2,{||oDlg:End()}					,oDlg,,"", )

oDlg:Activate(,,,.T.)	  

If lConfirm 
	
	For i := 1 to len(aVetUsu)
		If aVetUsu[i][2]
		     lOk := .T.
		     Exit
		EndIf                  
	Next                               
	
		
EndIf

Return //cLog                               

*********************************************************************************************************

Static Function DesMarca(aDes)

Local i := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS
           
For i := 1 to len(aDes)
	aDes[i][1] := .F.
Next

Return aDes

*********************************************************************************************************

Static Function RetArrUsr
      
Local i := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS
      
Local aRet 		:= {}
Local aUsers	:= {}
Local nQtd 		:= 0
Local nCont		:= 0
Local cTot 		:= "" 
Local cQuery    := ""
Local cArqQry   := GetNextAlias()

ProcRegua(0)

For i := 1 to 5
	IncProc('Selecionando registros...')
Next
/*
cQry := "SELECT BF4_CODEMP, BF4_MATRIC, BF4_CODPRO "	//+ CRLF
cQry += " FROM " + RetSqlName('BF4') 					//+ CRLF
cQry += " WHERE D_E_L_E_T_ = ' '" 						//+ CRLF
cQry += "  AND BF4_FILIAL = '" + xFilial('BF4') + "'" 	//+ CRLF
cQry += "  AND BF4_CODRDA = '104019'" 					//+ CRLF  
*/

cQuery := "SELECT BA3.BA3_CODPLA, BA3.BA3_VERSAO, bf4_codemp, bf4_matric, bf4_codpro, ba1_matric, ba1_tipreg, ba1_digito, BA1_NOMUSR NOME, BA1.* " +CRLF
    
cQuery += "       FROM   "+RetSqlName("BA3")+" BA3, "+RetSqlName("BF4")+" BF4, "+RetSqlName("BA1")+" BA1, "+RetSqlName("BTS")+" BTS, "+RetSqlName("BI3")+" BI3 "+CRLF
cQuery += "       WHERE  ((PLS_PRA_PROJSERV_ATIVO_MS(BA1_CODINT,BA1_CODEMP,BA1_MATRIC,BA1_TIPREG,'0024',TO_CHAR(TO_DATE('"+DTOS(FirstDay(MV_PAR02))+"','YYYYMMDD'),'YYYYMMDD')) = 'S' ) OR (PLS_PRA_PROJSERV_ATIVO_MS(BA1_CODINT,BA1_CODEMP,BA1_MATRIC,BA1_TIPREG,'0024',TO_CHAR(TO_DATE('"+DTOS(LastDay(MV_PAR02))+"','YYYYMMDD'),'YYYYMMDD')) = 'S' ) )"+CRLF
cQuery += "       AND    BF4_CODPRO = '0024' "+CRLF
//cQuery += "       AND    BF4_DATBLO = ' ' "+CRLF
cQuery += "       AND    (BF4_DATBLO = ' '  OR BF4_DATBLO > TO_CHAR(TO_DATE('"+DTOS(FirstDay(MV_PAR02))+"','YYYYMMDD'),'YYYYMMDD')) "+CRLF
cQuery += "       and    bf4_filial = '  ' "+CRLF
cQuery += "       and    ba3_filial = '  ' "+CRLF
cQuery += "       and    ba1_filial = '  ' "+CRLF
cQuery += "       and    bts_filial = '  ' "+CRLF
cQuery += "       and    bi3_filial = '  ' "+CRLF
cQuery += "       and    ba3_codint = ba1_codint "+CRLF
cQuery += "       and    ba3_codemp = ba1_codemp "+CRLF
cQuery += "       and    ba3_matric = ba1_matric "+CRLF
cQuery += "       AND    BA1_FILIAL = BF4_FILIAL "+CRLF
cQuery += "       AND    BA1_CODINT = BF4_CODINT "+CRLF
cQuery += "       AND    BA1_CODEMP = BF4_CODEMP "+CRLF
cQuery += "       AND    BA1_MATRIC = BF4_MATRIC "+CRLF
cQuery += "       AND    BA1_TIPREG = BF4_TIPREG "+CRLF
cQuery += "       AND    (BA1_DATBLO = ' '  OR BA1_DATBLO > TO_CHAR(TO_DATE('"+DTOS(FirstDay(MV_PAR02))+"','YYYYMMDD'),'YYYYMMDD')) "+CRLF
cQuery += "       AND    BTS_FILIAL = BA1_FILIAL "+CRLF
cQuery += "       AND    BTS_MATVID = BA1_MATVID "+CRLF
cQuery += "       AND    BI3_FILIAL = BF4_FILIAL "+CRLF
cQuery += "       AND    BI3_VERSAO = BF4_VERSAO "+CRLF
cQuery += "       AND    BI3_CODIGO = BF4_CODPRO "+CRLF
cQuery += "       AND    BI3_CODINT = BF4_CODINT "+CRLF
cQuery += "       AND    BF4_CODRDA = '"+MV_PAR03+"' "+CRLF
cQuery += "       AND    BF4.D_E_L_E_T_ = ' ' "+CRLF
cQuery += "       AND    BA1.D_E_L_E_T_ = ' ' "+CRLF
cQuery += "       AND    BTS.D_E_L_E_T_ = ' ' "+CRLF
cQuery += "       AND    BI3.D_E_L_E_T_ = ' ' "+CRLF
cQuery += "       --ORDER BY 3  "+CRLF
  
cQuery += "union "+CRLF

cQuery += "SELECT BA3.BA3_CODPLA, BA3.BA3_VERSAO, bf4_codemp, bf4_matric, bf4_codpro, ba1_matric, ba1_tipreg, ba1_digito, BA1_NOMUSR NOME, BA1.* " +CRLF
    
cQuery += "       FROM   "+RetSqlName("BA3")+" BA3, "+RetSqlName("BF4")+" BF4, "+RetSqlName("BA1")+" BA1, "+RetSqlName("BTS")+" BTS, "+RetSqlName("BI3")+" BI3 "+CRLF
cQuery += "       WHERE  ( (PLS_PRA_PROJSERV_ATIVO_MS(BA1_CODINT,BA1_CODEMP,BA1_MATRIC,BA1_TIPREG,'0038',TO_CHAR(TO_DATE('"+DTOS(FirstDay(MV_PAR02))+"','YYYYMMDD'),'YYYYMMDD')) = 'S' ) OR (PLS_PRA_PROJSERV_ATIVO_MS(BA1_CODINT,BA1_CODEMP,BA1_MATRIC,BA1_TIPREG,'0038',TO_CHAR(TO_DATE('"+DTOS(LastDay(MV_PAR02))+"','YYYYMMDD'),'YYYYMMDD')) = 'S' ) )"+CRLF
cQuery += "       AND    BF4_CODPRO = '0038' "+CRLF
//cQuery += "       AND    BF4_DATBLO = ' ' "+CRLF
cQuery += "       AND    (BF4_DATBLO = ' '  OR BF4_DATBLO > TO_CHAR(TO_DATE('"+DTOS(FirstDay(MV_PAR02))+"','YYYYMMDD'),'YYYYMMDD')) "+CRLF
cQuery += "       and    bf4_filial = '  ' "+CRLF
cQuery += "       and    ba3_filial = '  ' "+CRLF
cQuery += "       and    ba1_filial = '  ' "+CRLF
cQuery += "       and    bts_filial = '  ' "+CRLF
cQuery += "       and    bi3_filial = '  ' "+CRLF
cQuery += "       and    ba3_codint = ba1_codint "+CRLF
cQuery += "       and    ba3_codemp = ba1_codemp "+CRLF
cQuery += "       and    ba3_matric = ba1_matric "+CRLF
cQuery += "       AND    BA1_FILIAL = BF4_FILIAL "+CRLF
cQuery += "       AND    BA1_CODINT = BF4_CODINT "+CRLF
cQuery += "       AND    BA1_CODEMP = BF4_CODEMP "+CRLF
cQuery += "       AND    BA1_MATRIC = BF4_MATRIC "+CRLF
cQuery += "       AND    BA1_TIPREG = BF4_TIPREG "+CRLF
cQuery += "       AND    (BF4_DATBLO = ' '  OR BF4_DATBLO > TO_CHAR(TO_DATE('"+DTOS(FirstDay(MV_PAR02))+"','YYYYMMDD'),'YYYYMMDD')) "+CRLF
cQuery += "       AND    BTS_FILIAL = BA1_FILIAL "+CRLF
cQuery += "       AND    BTS_MATVID = BA1_MATVID "+CRLF
cQuery += "       AND    BI3_FILIAL = BF4_FILIAL "+CRLF
cQuery += "       AND    BI3_VERSAO = BF4_VERSAO "+CRLF
cQuery += "       AND    BI3_CODIGO = BF4_CODPRO "+CRLF
cQuery += "       AND    BI3_CODINT = BF4_CODINT "+CRLF
cQuery += "       AND    BF4_CODRDA = '"+MV_PAR03+"' "+CRLF
cQuery += "       AND    BF4.D_E_L_E_T_ = ' ' "+CRLF
cQuery += "       AND    BA1.D_E_L_E_T_ = ' ' "+CRLF
cQuery += "       AND    BTS.D_E_L_E_T_ = ' ' "+CRLF
cQuery += "       AND    BI3.D_E_L_E_T_ = ' ' "+CRLF
cQuery += "ORDER BY NOME  "+CRLF

If Select(cArqQry)>0

	(cArqQry)->(DbCloseArea())

EndIf

DbUseArea(.T.,"TopConn",TcGenQry(,,cQuery),cArqQry,.T.,.T.)

nQtd 	:= 0

(cArqQry)->(DbGoTop())

COUNT TO nQtd

nTotBenRDA := nQtd

(cArqQry)->(DbGoTop())

cTot := cValToChar(nQtd)

ProcRegua(nQtd)

While !((cArqQry)->(EOF()))

    IncProc('Usu�rio ' + cValToChar(++nCont) + ' de ' + cTot)

    //aAdd(aRet,{'',.T.,.F.,(cArqQry)->(BF4_CODEMP),(cArqQry)->(BF4_MATRIC),(cArqQry)->(BF4_CODPRO)})
    
    If !Empty((cArqQry)->BA1_CODPLA)
		cCodPla  := (cArqQry)->(BA1_CODPLA)
		cCodPla1 := (cArqQry)->(BA1_CODPLA+BA1_VERSAO)
	Else
		cCodPla  := (cArqQry)->(BA3_CODPLA)
		cCodPla1 := (cArqQry)->(BA1_CODPLA+BA1_VERSAO)
	EndIf

	DbSelectArea("BI3")
	BI3->(DbSetOrder(1))  //BI3_FILIAL + BI3_CODINT + BI3_CODIGO + BI3_VERSAO = "  00010001001"
	
	If BI3->(DbSeek(xFilial("BI3")+(cArqQry)->BA1_CODINT+cCodPla1))
		cDesPla := BI3->BI3_DESCRI
	EndIf
    /*Posicoes no array:
    2 - Beneficiario faz parte do rateio (.T.) ou nao (.F.)
    3 - Sera feito pagamento dobrado para o beneficiario (.T.) ou nao (.F.)
    4 - BA1_CODEMP
    5 - BA1_MATRIC
    6 - BF4_CODPRO  //Codigo do projeto AED
    7 - cCodPla (codigo do plano)
    8 - cDesPla (descri��o do plano)
    9 - BA1_CODINT
    10 - BA1_NOMUSR
    11 - cCodRDA
    12 - nValorRat
    13 - cProAED (codigo do procedimento para inclusao guias rateio AED
    14 - BA1_TIPREG
    15 - BA1_DIGITO
    16 - BA1_TELEFO
    17 - BA1_SEXO
    18 - BA1_MATANT
    19 - BA1_MATVID
    20 - BA1_CONEMP
    21 - BA1_VERCON
    22 - BA1_SUBCON
    23 - BA1_VERSUB*/
    aADD( aRet, {'', .T., .F., (cArqQry)->BA1_CODEMP, (cArqQry)->BA1_MATRIC, (cArqQry)->BF4_CODPRO, cCodPla,cDesPla,(cArqQry)->BA1_CODINT,;
     (cArqQry)->BA1_NOMUSR,cCodRDA,nValorRat,cProAED, (cArqQry)->BA1_TIPREG, (cArqQry)->BA1_DIGITO, (cArqQry)->BA1_TELEFO, (cArqQry)->BA1_SEXO,;
     (cArqQry)->BA1_MATANT, (cArqQry)->BA1_MATVID, (cArqQry)->BA1_CONEMP, (cArqQry)->BA1_VERCON, (cArqQry)->BA1_SUBCON, (cArqQry)->BA1_VERSUB})
    
    (cArqQry)->(DbSkip())

EndDo


(cArqQry)->(DbCloseArea())

Return aRet

*********************************************************************************************************

Static Function Pesquisa(aVetUsu,cCombo,cBusca,lPalChave,nAt)
    
Local nOpca := nAt
                         
If !empty(cBusca)

	Do Case
	
		Case cCombo == 'Nome'
		
			If lPalChave
				nOpca := aScan(aVetUsu,{|x| Upper(cBusca) $ Upper(x[3]) }, nAt + 1)
			Else
				nOpca := aScan(aVetUsu,{|x| Upper(cBusca) == left(Upper(x[3]),len(cBusca)) }, nAt + 1)
			EndIf
		
		Case cCombo == 'Login'
		
			If lPalChave
				nOpca := aScan(aVetUsu,{|x| Upper(cBusca) $ Upper(x[4]) }, nAt + 1)
			Else
				nOpca := aScan(aVetUsu,{|x| Upper(cBusca) == left(Upper(x[4]),len(cBusca)) }, nAt + 1)
			EndIf
		
		Case cCombo == 'C�digo'
		
			If lPalChave                  
				nOpca := aScan(aVetUsu,{|x| Upper(cBusca) $ Upper(x[2]) }, nAt + 1)
			Else
				nOpca := aScan(aVetUsu,{|x| Upper(cBusca) == left(Upper(x[2]),len(cBusca)) }, nAt + 1)
			EndIf
		
	EndCase

EndIf

Return nOpca                 

********************************************************************************************************

User Function AjuCels
      
If oBrowse:nColPos == 2 

	aVetUsu[oBrowse:nAt,2] := !aVetUsu[oBrowse:nAt,2] 
	
	If !aVetUsu[oBrowse:nAt,2]
		aVetUsu[oBrowse:nAt,3] := .F.
	EndIf  
	
ElseIf oBrowse:nColPos == 3 .and. aVetUsu[oBrowse:nAt,2] 

	aVetUsu[oBrowse:nAt,3] := !aVetUsu[oBrowse:nAt,3]
	
EndIf

Return         


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Funcao    � GERAAEDB � Autor � Renato Peixoto        � Data � 28/09/11 ���
�������������������������������������������������������������������������Ĵ��
���Descricao � Rotina respons�vel por gerar o rateio AED.                 ���
�������������������������������������������������������������������������Ĵ��
���Sintaxe   � CABERJ                                                     ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

User Function GERAAEDB

Local nContador := 0

nContador := j

cNomInt    := POSICIONE("BA0",1,XFILIAL("BA0")+cCodInt,"BA0_NOMINT")

DbSelectArea("BAU")
DbSetOrder(1)
MSSeek(XFILIAL("BAU")+cCodRDA)
cLocalBB8  := POSICIONE("BB8",1,XFILIAL("BB8")+cCodRDA+cCodInt,"BB8_CODLOC")
cCodLoc    := POSICIONE("BB8",1,XFILIAL("BB8")+cCodRDA+cCodInt,"BB8_LOCAL")    
cDesLocBB8 := POSICIONE("BB8",1,XFILIAL("BB8")+cCodRDA+cCodInt,"BB8_DESLOC")
cBB8END    := POSICIONE("BB8",3,XFILIAL("BB8")+cCodRDA+cCodInt,"BB8_END")
cBB8NR_END := POSICIONE("BB8",3,XFILIAL("BB8")+cCodRDA+cCodInt,"BB8_NR_END")
cBB8COMEND := POSICIONE("BB8",3,XFILIAL("BB8")+cCodRDA+cCodInt,"BB8_COMEND")
cBB8Bairro := POSICIONE("BB8",3,XFILIAL("BB8")+cCodRDA+cCodInt,"BB8_BAIRRO")
cCodEsp    := POSICIONE("BAX",1,XFILIAL("BAX")+cCodRDA+cCodInt+cLocalBB8,"BAX_CODESP")
 

If Empty(cLocalBB8)
	APMSGSTOP("Aten��o, n�o existe c�digo de localidade cadastrado para o RDA "+cCodRDA+", operadora "+cCodInt+" e local "+cCodLoc+". Favor cadastrar antes de realizar este processo. ","Processo n�o pode ser realizado.")
	Return
EndIf

If Empty(cCodEsp)
	APMSGSTOP("Aten��o, n�o existe especialidade cadastrada para o RDA "+cCodRDA+", operadora "+cCodInt+" e local "+cCodLoc+". Favor cadastrar antes de realizar este processo. ","Processo n�o pode ser realizado.")
	Return
EndIf

aArray1 := {}//zero o vetor a cada loop
      				
IncProc("Processando inclus�o de contas m�dicas para rateio "+cTipProd+"...")

cNomInt    := POSICIONE("BA0",1,XFILIAL("BA0")+cCodInt,"BA0_NOMINT")

 /*Posicoes no array:
    2 - Beneficiario faz parte do rateio (.T.) ou nao (.F.)
    3 - Sera feito pagamento dobrado para o beneficiario (.T.) ou nao (.F.)
    4 - BA1_CODEMP
    5 - BA1_MATRIC
    6 - BF4_CODPRO  //Codigo do projeto AED
    7 - cCodPla (codigo do plano)
    8 - cDesPla (descri��o do plano)
    9 - BA1_CODINT
    10 - BA1_NOMUSR
    11 - cCodRDA
    12 - nValorRat
    13 - cProAED (codigo do procedimento para inclusao guias rateio AED
    14 - BA1_TIPREG
    15 - BA1_DIGITO
    16 - BA1_TELEFO
    17 - BA1_SEXO
    18 - BA1_MATANT
    19 - BA1_MATVID
    20 - BA1_CONEMP
    21 - BA1_VERCON
    22 - BA1_SUBCON
    23 - BA1_VERSUB*/	
//Preencho o vetor com as informa�oes que serao utilizadas na inclusao das guias de rateio AED
aAdd ( aArray1  , { {"FILIAL",XFILIAL("BAU")},;
	{"CODRDA",cCodRDA},;
	{"OPERDA",cCodInt},;
	{"CODINT",cCodInt},;  //No BD5 � CODOPE
	{"NOMINT",cNomInt},;
	{"DATA",dDtEvento},; 
	{"DATPRO", dDtEvento},; 
	{"HORPRO",STRTRAN(substr(time(),1,5),":","")},;
	{"NOMUSR",aVetUsu[j][10]},;
	{"TELEFO",aVetUsu[j][16]},;
	{"CODESP",cCodEsp},;
	{"CODLOC",cLocalBB8},;
	{"LOCAL",cCodLoc},;
	{"SIGLA",BAU->BAU_SIGLCR},;
	{"ESTCR",BAU->BAU_ESTCR},;
	{"REGSOL",BAU->BAU_CONREG},;
	{"CDPFSO",BAU->BAU_CODBB0},;
	{"TPCON","1"},; 
	{"SEXO",aVetUsu[j][17]},;      
    {"ANOPAG",cAno},;
	{"MESPAG",cMes},; //Paulo Motta 10/2/14	{"ANOPAG",SUBSTR(cAno,3,4)},;	{"MESPAG",SUBSTR(cMes,1,2)},;
	{"MATANT",aVetUsu[j][18]},;  //Paulo Motta  
	{"MATVID",aVetUsu[j][19]},;
	{"OPEUSR",cCodInt},;  //codint
	{"TIPRDA",BAU->BAU_TIPPE},;
	{"MATRIC",aVetUsu[j][5]},;  
	{"TIPREG",aVetUsu[j][14]},;	   
	{"CPFRDA",BAU->BAU_CPFCGC},; 
	{"DIGITO",aVetUsu[j][15]},;
	{"NOMRDA",BAU->BAU_NOME},;
	{"NOMSOL",BAU->BAU_NOME},;
	{"CODEMP",aVetUsu[j][4]},;  
	{"CONEMP",aVetUsu[j][20]},;
	{"VERCON",aVetUsu[j][21]},;
	{"SUBCON",aVetUsu[j][22]},;	
	{"VERSUB",aVetUsu[j][23]},;
	{"DATDIG",DDATABASE},;
	{"CODPAD","16"},;//Motta chamado 58993
	{"CODPRO",cProAED},;
	{"TIPPRE",BAU->BAU_TIPPRE},;
	{"DTDIG1",DDATABASE},;
	{"YVLTAP", /*IIF(aVetUsu[j][3]=.F.,nValorRat,nValorRat*2)*/nValorRat},;
	{"VLRAPR", /*IIF(aVetUsu[j][3]=.F.,nValorRat,nValorRat*2)*/nValorRat},;
	{"QTDAPR", 1},;
	{"QTDPRO", 1},;
	{"BLOCPA", "1"},;  //bloqueia a cobranca da co-participacao
	{"DESBPF", "INFORMAR A DESCRICAO DO MOTIVO"},; 
	{"TIPSAI", "5"},;
	{"ORIMOV", "1"},; 
	{"DESLOC", cDesLocBB8},;
	{"ENDLOC", AllTrim(cBB8END)+"+"+AllTrim(cBB8NR_END)+"-"+AllTrim(cBB8COMEND)+"-"+AllTrim(cBB8BAIRRO)},; 
	{"MOTBPF", "999"},; //    // INFORME O CODIGO DO BLOQUEIO DA COPARTICIPACAO DE ACORDO COM A TABELA DE BLOQUEIO  Na BD5 � MOTBPG
	{"TIPATE", "06"},; //Atendimento domiciliar, pois segundo o Dr. Jose Paulo � o que melhor se enquadra ao ADU.
	{"CODPLA", aVetUsu[j][7]},;  //acrescentado em 05/10/11 por Renato Peixoto para atender especificacoes rateio AED. Alterado para pegar do vetor por Renato Peixoto. 
	{"REGEXE", cCRMProf},; //acrescentado em 05/10/11 por Renato Peixoto para atender especificacoes rateio AED.
	{"OPEEXE", cOperProf},;//acrescentado em 05/10/11 por Renato Peixoto para atender especificacoes rateio AED.
	{"NOMEXE", cNomProf},; //acrescentado em 05/10/11 por Renato Peixoto para atender especificacoes rateio AED.
	{"CDPFRE", cCodProf},; //acrescentado em 05/10/11 por Renato Peixoto para atender especificacoes rateio AED.
	{"ESTEXE", cUFProf},;  //acrescentado em 05/10/11 por Renato Peixoto para atender especificacoes rateio AED.
	{"SIGEXE", cSiglaProf},;//acrescentado em 05/10/11 por Renato Peixoto para atender especificacoes rateio AED. 
	{"REGPRE", cCRMProf},; //acrescentado em 05/10/11 por Renato Peixoto para atender especificacoes rateio AED.
	{"NOMPRE", cNomProf} })  //acrescentado em 05/10/11 por Renato Peixoto para atender especificacoes rateio AED. 
    /*bd5_regexe -> CR executante
opeexe   - operadora executante
nomexe   - nome do executante
cdpfre   - cod. prof. saude executante
estexe   - UF executante
sigexe   - sigla do executante (CRM)
regpre  CR executante
nompre  nome executante*/

//Atualizo o conteudo da variavel cCodPla
cCodPla := aVetUsu[j][7]

U_XGRVGUIAED()

Return



/*/
������������������������������������������������������������������������������
������������������������������������������������������������������������������
��������������������������������������������������������������������������Ŀ��
���Funcao    �XGRVGUIAED  � Autor � Renato Peixoto       � Data � 29.09.11 ���
��������������������������������������������������������������������������Ĵ��
���Descricao � Grava dados de consulta em um PEG e GUIA                    ���
���������������������������������������������������������������������������ٱ�
������������������������������������������������������������������������������
/*/
User Function XGRVGUIAED(/*cNumAte,dDataBase*/)  //alterar aqui nessa fun��o, fazendo um for e 1 ate 2 para gerar duas vezes caso avetusu[j][3] seja .T. alterando a data da segunda guia
Local I__f := 0
//��������������������������������������������������������������������������Ŀ
//� Declara variaveis da rotina...                                           �
//����������������������������������������������������������������������������
LOCAL nH := PLSAbreSem("XGRVGUIAED.SMF")
LOCAL cNumGuia
LOCAL nFor
LOCAL nTmp
LOCAL nAux
LOCAL aFiles
LOCAL cAliasAux
LOCAL nPos
LOCAL cAliasPri
LOCAL cCpoFase
LOCAL aColsAux
LOCAL cCampos
LOCAL aStruARQ    := {}

LOCAL aRetCal     := PLSXVLDCAL(dDtEvento,cCodInt,.F.)    // Valida o calendario de pagamento da operadora
LOCAL cAnoBase    := aRetCal[4]
LOCAL cMesBase    := aRetCal[5]
LOCAL nHESP
LOCAL nStackSX8   := GetSx8Len()
Local aHeaderBE2  := {}

Local nQ          := 0

Local nCOEFUT     := 0 // MOTTA CHAMADO 58993  

PRIVATE cOpeRDA   := cCodInt
//PRIVATE cCodRDA   := cCodRda j� � declarada como private na fun��o que chama esta
PRIVATE cNomRDA   := BAU->BAU_NOME
PRIVATE cTipRDA   := BAU->BAU_TIPPE
PRIVATE cFunGRV
PRIVATE cTipGRV
PRIVATE cTipoGuia
PRIVATE cGuiRel
PRIVATE cNewPEG                          //codemp      matricula         TIPREG         DIGITO
PRIVATE aDadUSR   := PLSDADUSR(cCodInt+aVetUsu[j][4]+aVetUsu[j][5]+aVetUsu[j][14]+aVetUsu[j][15],"1",.T.,dDataBase/*dDatLan*/)  //busca dados do usuario a ser lancado
Private aArea     := GetArea() //Acrescentado por Renato Peixoto em 04/01/11 para tentar solucionar o erro "Tc_eof  - No Connection on RECLOCKED(APLIB060.PRW)"

//��������������������������������������������������������������������������Ŀ
//� Verifica se existe o PEG eletronico do mes para o credenciado...         �
//����������������������������������������������������������������������������
BCI->(DbSetOrder(4))

If !(aRetCal[1])
	APMSGSTOP("Aten��o, n�o existe calendario de pagamento para a data em quest�o ou os par�metros de pagamento desse m�s n�o foram configurados. Favor Verificar antes de realizar este processo.","Processo n�o pode ser realizado.")
	Return
EndIf

nHESP := PLSAbreSem("PLSPEG1.SMF")
If ! BCI->(MsSeek(xFilial("BCI")+cOpeRDA+cCodRDA+cAnoBase+cMesBase+"211")) //2 - inclu�do eletronicamente; 1-em digitacao; 1- ativo
	
	cNewPEG := PLSA175Cod(cOpeRDA,"0001")//GetNewPar("MV_PLSPEGE","0000"))
	
	RecLock("BCI",.T.)
	BCI->BCI_FILIAL := xFilial("BCI")
	BCI->BCI_CODOPE := cOpeRDA
	BCI->BCI_PROTOC := CriaVar("BCI_PROTOC")
	BCI->BCI_CODLDP := "0001" //GetNewPar("MV_PLSPEGE","0001")
	BCI->BCI_CODPEG := cNewPEG
	BCI->BCI_OPERDA := cOpeRDA
	BCI->BCI_CODRDA := cCodRDA//cOpeRDA  
	BCI->BCI_NOMRDA := cNomRDA
	BCI->BCI_TIPSER := GetNewPar("MV_PLSTPSP","01")
	BCI->BCI_TIPGUI := GetNewPar("MV_PLSTPGS","02")//GetNewPar("MV_PLSTPGC","01")
	BCI->BCI_TIPPRE := BAU->BAU_TIPPRE
	
	BCL->(DbSetOrder(1))
	BCL->(MsSeek(xFilial("BCL")+cOpeRDA+BCI->BCI_TIPGUI))
	//BCI->BCI_QTDGUI := 1
	BCI->BCI_VLRGUI := 0 //REVER
	BCI->BCI_DATREC := dDataBase//Base
	//BCI->BCI_DTPRPG := ctod("")
	BCI->BCI_DTDIGI := dDtEvento
	BCI->BCI_QTDDIG := 1
	//BCI->BCI_VALDIG := 0 //REVER
	BCI->BCI_CODCOR := BCL->BCL_CODCOR
	BCI->BCI_FASE   := "1"
	BCI->BCI_SITUAC := "1"
	BCI->BCI_MES    := cMesBase
	BCI->BCI_ANO    := cAnoBase
	BCI->BCI_TIPO   := "2" 
	BCI->BCI_STATUS := "1"
	MsUnLock()
	
	While GetSx8Len() > nStackSX8
		ConfirmSX8()
	EndDo
	
Else
	BCL->(DbSetOrder(1))
	BCL->(MsSeek(xFilial("BCL")+cOpeRDA+BCI->BCI_TIPGUI))
Endif
PLSFechaSem(nHESP,"PLSPEG1.SMF")

cTipoGuia := BCL->(BCL_TIPGUI)
cGuiRel   := BCL->BCL_GUIREL
cFunGRV   := BCL->BCL_FUNGRV
cTipGRV   := BCL->BCL_TIPGRV
//��������������������������������������������������������������������������Ŀ
//� Inicio do processo de gravacao das guias...                              �
//����������������������������������������������������������������������������
aFiles := PLSA500Fil(BCI->BCI_CODOPE,BCI->BCI_TIPGUI)

For nQ := 1 to Len(aArray1)  //Loop para gerar uma guia para cada ususario contido no array
	//��������������������������������������������������������������������������Ŀ
	//� Monta os vetores e vari�veis...                                                    �
	//����������������������������������������������������������������������������
	For nFor := 1 To Len(aFiles)
		cAliasAux := aFiles[nFor,1]
		
		If Empty(cAliasPri)
			cAliasPri := aFiles[nFor,1]
			cNumGuia  := PLSA500NUM(cAliasPri,cOpeRDA,BCI->BCI_CODLDP,BCI->BCI_CODPEG)
		Endif
		//BIANCHINI - P12 - RETIRADO O IF. SE NA BCS A BD6 E BD7 FICAREM COM O TIPO 2 D� ERRO
		//NA INCLUSAO E VISUALIZAO DE GUIAS NO CONTAS MEDICAS
		//If aFiles[nFor,3] == "2"
			aStruARQ := (cAliasAux)->(DbStruct())
			
			//��������������������������������������������������������������������������Ŀ
			//� Monta RegToMemory...                                                     �
			//����������������������������������������������������������������������������
			//RegToMemory(cAliasAux,.T.,.F.)
				
			Copy (cAliasAux) To Memory Blank
			
			//Dados fixos para todos os arquivos a serem procesados do contas medicas
			&("M->"+cAliasAux+"_CODOPE") := BCI->BCI_CODOPE
			&("M->"+cAliasAux+"_CODLDP") := BCI->BCI_CODLDP
			&("M->"+cAliasAux+"_CODPEG") := BCI->BCI_CODPEG
			&("M->"+cAliasAux+"_NUMERO") := cNumGuia
			&("M->"+cAliasAux+"_TIPGUI") := BCI->BCI_TIPGUI
			
			//Dados variados para cada arquivo que esta sendo processado
			For nAux := 1 To Len(aArray1[nQ])   //Processa a quantida de campos contidos no array do usuario em questao
				nPos := ascan(aStruARQ, {|x| alltrim(x[1]) = cAliasAux+"_"+aArray1[nQ,nAux,1]}) //ascan(aStruARQ,aArray1[nQ,nAux,1])   //Verifica se o campo a ser gravado nesta tabela corresponde ao do array
				If nPos > 0
					&("M->"+cAliasAux+"_"+aArray1[nQ,nAux,1]) := aArray1[nQ,nAux,2]
				Endif
			Next
			
			PLUPTENC(cAliasAux,K_Incluir)
		//Else
		//	QOut("Gravacao de itens nao implementada") //
		//Endif
	Next
Next

//Crio o vetor aHeaderBE2 com os dados do SX3 para os campos BE2_CODPAD, BE2_CODPRO e BE2_STATUS
DbSelectArea("SX3")
SX3->(DbSetOrder(1))
SX3->(dbSeek("BE2"))
_Recno := Recno()
Do While !Eof() .And. (X3_ARQUIVO == "BE2")
	If X3_CAMPO = "BE2_CODPAD" .or. X3_CAMPO = "BE2_CODPRO" .or. X3_CAMPO = "BE2_STATUS"
		Aadd(aHeaderBE2,{Trim(X3_TITULO), X3_CAMPO, X3_PICTURE, X3_TAMANHO, X3_DECIMAL,".T.", X3_USADO, X3_TIPO, X3_ARQUIVO, X3_CONTEXT})
	Endif
	dbSkip()
Enddo
DbGoto(_Recno)

//��������������������������������������������������������������������������Ŀ
//� Executa funcao de gravacao dos dados...                                  �
//����������������������������������������������������������������������������
If !Empty(cFunGRV)
	aPar   := {K_Incluir,cOpeRDA,BCI->BCI_CODLDP,BCI->BCI_CODPEG,cNumGuia,.T.,cAliasPri,"01","","1",{{cCodPad,cProAED,"1"}}, aHeaderBE2 }//{K_Incluir,cOpeRDA,BCI->BCI_CODLDP,BCI->BCI_CODPEG,cNumGuia,.T.}
	cMacro := (AllTrim(cFunGRV)+"(aPar)")
	&(cMacro)
Endif

//Gravo os campos BD6_YVLTAP com o valor correspondente ao NUPRE e o campo QTDAPR
DbSelectArea("BD6")
//BIANCHINI - AJUSTES P12 - SEM NENHUMA RAZAO SE USAVA UM DBSELECTAREA AQUI SEM SEEK E DESPONTEIRAVA A BD6, QUE POR SI S� JA VEM 
//DESPONTEIRADA DEPOIS DA GRAVA��O PELO PLSA720
//TAMB�M FEITO O TRATAMENTO DE CAMPOS QUE ERAM PREENCHIDOS NA P11 E N�O MAIS NA P12
DbSetOrder(1)
If DbSeek(BD5->(BD5_FILIAL+BD5_CODOPE+BD5_CODLDP+BD5_CODPEG+BD5_NUMERO+BD5_ORIMOV))
	RecLock("BD6",.F.)
	BD6->BD6_DESPRO := POSICIONE("BR8",1,XFILIAL("BR8")+'16'+cProAED,"BR8_DESCRI") // motta chamado 58993
	BD6->BD6_NIVEL  := '4'   // motta chamado 58993
	BD6->BD6_CODTAB := '024' // motta chamado 58993
	BD6->BD6_ALIATB := 'BH0'

	BD6->BD6_YVLTAP := nValorRat//IIF(aVetUsu[j][3]=.F.,nValorRat,nValorRat*2)
	BD6->BD6_VLRAPR := nValorRat//IIF(aVetUsu[j][3]=.F.,nValorRat,nValorRat*2)
	//BD6->BD6_QTDAPR := 1   //DESCONTINUADO P12
	BD6->BD6_QTDPRO := 1  
	BD6->BD6_BLOCPA := "1"
	BD6->BD6_DESBPF := "PAGAMENTO "+cTipProd //"RATEIO NUPRE"
	BD6->BD6_MOTBPF := "501" 
	//For�o a grava��o do plano correto do usu�rio, caso o sistema esteja gravando errado na BD6 e BD7 o campo CODPLA
	//Alterado em 17/03/2011 por Renato Peixoto
	If BD6->Bd6_CODPLA <> cCodPla
		BD6->BD6_CODPLA := cCodPla
	EndIf
	//Fim Altera��o Renato Peixoto 
	cCodPegRat := BD6->BD6_CODPEG
	
	DbSelectArea("BC0")
	DbSetOrder(1) //BC0_FILIAL BC0_CODIGO BC0_CODINT BC0_CODLOC BC0_CODESP BC0_CODTAB BC0_CODOPC
	If !(DbSeek(xFilial("BC0") + BD6->(BD6_CODRDA+BD6_CODOPE+BD6_CODLOC+BD6_CODESP+BD6_CODPAD+BD6_CODPRO)))
		nCOEFUT := BC0->BC0_VALREA
	EndIf
	BD6->(MsUnlock())
Endif
//For�o a grava��o do plano correto do usu�rio, caso o sistema esteja gravando errado na BD6 e BD7 o campo CODPLA
//Alterado em 17/03/2011 por Renato Peixoto
DbSelectArea("BD7")
DbSetOrder(1)
If DbSeek(BD5->(BD5_FILIAL+BD5_CODOPE+BD5_CODLDP+BD5_CODPEG+BD5_NUMERO+BD5_ORIMOV))
	RecLock("BD7",.F.)
	//BIANCHINI - 04/05/2019 - AJUSTES P12 - CAMPOS QUE ERAM PREENCHIDOS NA P11 E N�O MAIS NA P12
	//MOTTA AGO/19 MUDANCA PAGAMENTO CODIGO TUSS CH 58993
	BD7->BD7_CODUNM := 'HM'//'RE1'  MOTTA CHAMADO 58993
	BD7->BD7_CDPFPR := cCodProf
	BD7->BD7_PERCEN := 100      
	BD7->BD7_COEFUT := nCOEFUT //MOTTA CHAMADO 58993
	BD7->BD7_TIPCOE := 'Valor'//'R$'   MOTTA CHAMADO 58993
	BD7->BD7_FATMUL := 1
	BD7->BD7_REFTDE := 1      
	BD7->BD7_UNITDE := 'CH'//'R$'    
	BD7->BD7_TIPEVE := '2' 
	BD7->BD7_PROBD7 := '1'
	BD7->BD7_UTHRES := '0'
	BD7->BD7_DTCTBF := dDatabase
	BD7->BD7_VALORI := nValorRat
	//FIM 
	If BD7->BD7_CODPLA <> cCodPla
		BD7->BD7_CODPLA := cCodPla
	EndIf
	MsUnlock()
Endif
//��������������������������������������������������������������������������Ŀ
//� Muda a fase da guia...                                                   �
//����������������������������������������������������������������������������
cCpoFase := (cAliasPri+"->"+cAliasPri+"_FASE")

If !Empty(BCL->BCL_FUNMFS)
     //Paulo Motta mudan�a de parametro da 11 (10/2/14)
     //aPar   := {cAliasPri,"1",cOpeRDA,cTipoGuia,&cCpoFase,BCI->BCI_CODLDP,BCI->BCI_CODPEG,BCL->BCL_GUIREL,.T.,dDataBase,.F.,,,,,cAliasPri}    
     aPar   := {cAliasPri,"1",cOpeRDA,cTipoGuia,&cCpoFase,BCI->BCI_CODLDP,BCI->BCI_CODPEG,BCL->BCL_GUIREL,.T.,dDataBase,.F.,,,,,cAliasPri,{}}  
     //Paulo Motta 
     cMacro := (AllTrim(BCL->BCL_FUNMFS)+"(aPar)")
     aRetAux := &(cMacro)
     lGerouRat := .T. //se ao menos uma guia foi gerada por essa rotina, marco esse flag como .T.
Endif 

//BIANCHINI - 04/05/2019 - AJUSTES P12 - LIMPANDO A GLOSA EM BD6 E BD7 NA MARRA. GLOSANDO 100%.ESSE PRESTADOR N�O PODE USAR O PARAMETRO
//NOVO(BAU_TPCALC) PARA PAGAR VALORES APRESENTADOS VISTO QUE ELE APRESENTA OUTRAS GUIAS EM DIFERENTES LOCAIS, CODIGOS E VALORES
//O RATEIO N�O PODE GLOSAR
DbSelectArea("BD6")
DbSetOrder(1)
If DbSeek(BD5->(BD5_FILIAL+BD5_CODOPE+BD5_CODLDP+BD5_CODPEG+BD5_NUMERO+BD5_ORIMOV))
	RecLock("BD6",.F.)
	BD6->BD6_VLRGLO := 0
	BD6->(MsUnlock())
Endif

DbSelectArea("BD7")
DbSetOrder(1)
If DbSeek(BD5->(BD5_FILIAL+BD5_CODOPE+BD5_CODLDP+BD5_CODPEG+BD5_NUMERO+BD5_ORIMOV))
	RecLock("BD7",.F.)
	BD7->BD7_VLRGLO := 0
	BD7->(MsUnlock())
Endif

//��������������������������������������������������������������������������Ŀ
//� Finaliza transacao fisica...                                             �
//����������������������������������������������������������������������������
PLSFechaSem(nH,"XGRVGUIAED.SMF")
//��������������������������������������������������������������������������Ŀ
//� Fim da Rotina...                                                         �
//����������������������������������������������������������������������������

//Gravo na tabela de controle do rateio AED
DbSelectArea("PB2")
DbSetOrder(2)
//          //codemp      matricula         TIPREG         DIGITO
//(cCodInt+aVetUsu[j][4]+aVetUsu[j][5]+aVetUsu[j][14]+aVetUsu[j][15],"1",.T.,dDataBase/*dDatLan*/)  //busca dados do usuario a ser lancado
//If k <= 1
	If !(DbSeek(XFILIAL("PB2")+cCompet+cCodRDA+cCodInt+aVetUsu[j][4]+aVetUsu[j][5]+aVetUsu[j][14]+aVetUsu[j][15]+"S"))
		RecLock("PB2",.T.)
		PB2->PB2_FILIAL := XFILIAL("PB2")
		PB2->PB2_COMPET := cCompet
		PB2->PB2_RDA    := cCodRDA
	    PB2->PB2_CODINT := cCodInt
	    PB2->PB2_CODEMP := aVetUsu[j][4]
	    PB2->PB2_MATRIC := aVetUsu[j][5]
	    PB2->PB2_TIPREG := aVetUsu[j][14]
	    PB2->PB2_DIGITO := aVetUsu[j][15]	
	    PB2->PB2_NOMUSR := aVetUsu[j][10]
	    PB2->PB2_VLRAT  := nValorRat//IIF(aVetUsu[j][3]=.F.,nValorRat,nValorRat*2)
	    PB2->PB2_VLRDOB := "N"//IIF(aVetUsu[j][3]=.F.,"N","S")
	    PB2->PB2_PROJET := aVetUsu[j][6]
	    PB2->PB2_BONUS  := "S"
	    PB2->PB2_VLBONU := nValorRat
	    PB2->(MsUnLock())
	EndIf
/*Else
	DbSelectArea("PB2")
	DbSetOrder(3)
	If !(DbSeek(XFILIAL("PB2")+cCompet+cCodRDA+cCodInt+aVetUsu[j][4]+aVetUsu[j][5]+aVetUsu[j][14]+aVetUsu[j][15]+"S"))
		RecLock("PB2",.T.)
		PB2->PB2_FILIAL := XFILIAL("PB2")
		PB2->PB2_COMPET := cCompet
		PB2->PB2_RDA    := cCodRDA
	    PB2->PB2_CODINT := cCodInt
	    PB2->PB2_CODEMP := aVetUsu[j][4]
	    PB2->PB2_MATRIC := aVetUsu[j][5]
	    PB2->PB2_TIPREG := aVetUsu[j][14]
	    PB2->PB2_DIGITO := aVetUsu[j][15]	
	    PB2->PB2_NOMUSR := aVetUsu[j][10]
	    PB2->PB2_VLRAT  := nValorRat//IIF(aVetUsu[j][3]=.F.,nValorRat,nValorRat*2)
	    PB2->PB2_VLRDOB := IIF(aVetUsu[j][3]=.F.,"N","S")
	    PB2->PB2_PROJET := aVetUsu[j][6]
	    PB2->PB2_VLRDOB := "S"
	    PB2->(MsUnLock())
	 EndIf
EndIf */
RestArea(aArea) //Acrescentado por Renato Peixoto em 04/01/11 para tentar solucionar o erro "Tc_eof  - No Connection on RECLOCKED(APLIB060.PRW)"

Return


/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �RELAEDB   � Autor � Renato Peixoto     � Data �  04/10/11   ���
�������������������������������������������������������������������������͹��
���Descricao � Relat�rio do que foi gerado de pagamento para o rateio AED.���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP6 IDE                                                    ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/

User Function RELAEDB()


//���������������������������������������������������������������������Ŀ
//� Declaracao de Variaveis                                             �
//�����������������������������������������������������������������������

Local cDesc1         := "Este programa tem como objetivo imprimir relatorio "
Local cDesc2         := "de pagamento AED gerado pela rotina autom�tica de rateio."
Local cDesc3         := ""
Local cPict          := ""
Local titulo         := "Bonus AED para o RDA "+MV_PAR03+" - "+AllTrim(POSICIONE("BAU",1,XFILIAL("BAU")+MV_PAR03,"BAU_NOME"))+"."
Local nLin           := 80

Local Cabec1         := "Compet�ncia    RDA     Matr�cula    Tipo Registro   Digito                Nome                                          Valor"
Local Cabec2         := ""
Local imprime        := .T.
Local aOrd := {}
Private lEnd         := .F.
Private lAbortPrint  := .F.
Private CbTxt        := ""
Private limite       := 132
Private tamanho      := "M"
Private nomeprog     := "RELAEDB" 
Private nTipo        := 18
Private aReturn      := { "Zebrado", 1, "Administracao", 2, 2, 1, "", 1}
Private nLastKey     := 0
Private cbtxt        := Space(10)
Private cbcont       := 00
Private CONTFL       := 01
Private m_pag        := 01
Private wnrel        := "RELAEDB" 

Private cString      := ""


//���������������������������������������������������������������������Ŀ
//� Monta a interface padrao com o usuario...                           �
//�����������������������������������������������������������������������

wnrel := SetPrint(cString,NomeProg,"",@titulo,cDesc1,cDesc2,cDesc3,.T.,aOrd,.T.,Tamanho,,.T.)

If nLastKey == 27
	Return
Endif

SetDefault(aReturn,cString)

If nLastKey == 27
   Return
Endif

nTipo := If(aReturn[4]==1,15,18)

//���������������������������������������������������������������������Ŀ
//� Processamento. RPTSTATUS monta janela com a regua de processamento. �
//�����������������������������������������������������������������������

RptStatus({|| RunReport(Cabec1,Cabec2,Titulo,nLin) },Titulo)
Return

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Fun��o    �RUNREPORT � Autor � AP6 IDE            � Data �  04/10/11   ���
�������������������������������������������������������������������������͹��
���Descri��o � Funcao auxiliar chamada pela RPTSTATUS. A funcao RPTSTATUS ���
���          � monta a janela com a regua de processamento.               ���
�������������������������������������������������������������������������͹��
���Uso       � Programa principal                                         ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/

Static Function RunReport(Cabec1,Cabec2,Titulo,nLin)

Local nQtdReg := Len(aVetRat)
Local i       := 0

SetRegua(nQtdReg)

For i := 1 To Len(aVetRat) 


   //���������������������������������������������������������������������Ŀ
   //� Verifica o cancelamento pelo usuario...                             �
   //�����������������������������������������������������������������������

   If lAbortPrint
      @nLin,00 PSAY "*** CANCELADO PELO OPERADOR ***"
      Exit
   Endif

   //���������������������������������������������������������������������Ŀ
   //� Impressao do cabecalho do relatorio. . .                            �
   //�����������������������������������������������������������������������

   If nLin > 55 // Salto de P�gina. Neste caso o formulario tem 55 linhas...
      Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
      nLin := 8
   Endif

   // Coloque aqui a logica da impressao do seu programa...
   // Utilize PSAY para saida na impressora. Por exemplo:
   // @nLin,00 PSAY SA1->A1_COD

   nLin := nLin + 1 // Avanca a linha de impressao
	
	@nLin,00 PSAY cCompet
	@nLin,13 PSAY cCodRDA
	@nLin,24 PSAY aVetRat[i][1] //matricula
	@nLin,40 PSAY aVetRat[i][3] //tpreg
	@nLin,54 PSAY aVetRat[i][4] //digito
	@nLin,65 PSAY AllTrim(aVetRat[i][2]) //nomusr
	@nLin,112 PSAY nValorRat PICTURE "@E 999,999,999.99"
   
Next i

nLin += 2
@nLin,00 PSAY "Total Pago neste Rateio: "+AllTrim(Transform(nTotRat,"@E 999,999,999"))// PICTURE "@E 999,999,999.99"
//���������������������������������������������������������������������Ŀ
//� Finaliza a execucao do relatorio...                                 �
//�����������������������������������������������������������������������

SET DEVICE TO SCREEN

//���������������������������������������������������������������������Ŀ
//� Se impressao em disco, chama o gerenciador de impressao...          �
//�����������������������������������������������������������������������

If aReturn[5]==1
   dbCommitAll()
   SET PRINTER TO
   OurSpool(wnrel)
Endif

MS_FLUSH()

Return



/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �RELAED    � Autor � Renato Peixoto     � Data �  04/10/11   ���
�������������������������������������������������������������������������͹��
���Descricao � Relat�rio do que foi gerado de pagamento para o rateio AED.���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP6 IDE                                                    ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/

User Function RelLstB(aVetBen)


//���������������������������������������������������������������������Ŀ
//� Declaracao de Variaveis                                             �
//�����������������������������������������������������������������������

Local cDesc1         := "Este programa tem como objetivo imprimir relatorio "
Local cDesc2         := "dos benefici�rios AED que ir�o fazer parte da rotina de rateio."
Local cDesc3         := ""
Local cPict          := ""
Local titulo         := "Bonus benef. AED para o RDA "+MV_PAR03+" - "+AllTrim(POSICIONE("BAU",1,XFILIAL("BAU")+MV_PAR03,"BAU_NOME"))+"."
Local nLin           := 80

Local Cabec1         := "Operadora    Empresa    Matr�cula     Tipo Reg.    D�gito           Nome                                          Plano"
Local Cabec2         := ""
Local imprime        := .T.
Local aOrd := {}
Private lEnd         := .F.
Private lAbortPrint  := .F.
Private CbTxt        := ""
Private limite       := 132
Private tamanho      := "M"
Private nomeprog     := "REUSUB" 
Private nTipo        := 18
Private aReturn      := { "Zebrado", 1, "Administracao", 2, 2, 1, "", 1}
Private nLastKey     := 0
Private cbtxt        := Space(10)
Private cbcont       := 00
Private CONTFL       := 01
Private m_pag        := 01
Private wnrel        := "REUSUB" 

Private cString      := ""
Private aBenef       := aVetBen

//���������������������������������������������������������������������Ŀ
//� Monta a interface padrao com o usuario...                           �
//�����������������������������������������������������������������������

wnrel := SetPrint(cString,NomeProg,"",@titulo,cDesc1,cDesc2,cDesc3,.T.,aOrd,.T.,Tamanho,,.T.)

If nLastKey == 27
	Return
Endif

SetDefault(aReturn,cString)

If nLastKey == 27
   Return
Endif

nTipo := If(aReturn[4]==1,15,18)

//���������������������������������������������������������������������Ŀ
//� Processamento. RPTSTATUS monta janela com a regua de processamento. �
//�����������������������������������������������������������������������

RptStatus({|| ImpLista(Cabec1,Cabec2,Titulo,nLin) },Titulo)
Return



/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �ImpLista  �Autor  �Renato Peixoto      � Data �  06/12/11   ���
�������������������������������������������������������������������������͹��
���Desc.     �Rotina que ir� realizar a impressao dos beneficiarios       ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                         ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

Static Function ImpLista(Cabec1,Cabec2,Titulo,nLin)

Local nQtdReg := Len(aBenef)
Local i       := 0

SetRegua(nQtdReg)

For i := 1 To Len(aBenef) 


   //���������������������������������������������������������������������Ŀ
   //� Verifica o cancelamento pelo usuario...                             �
   //�����������������������������������������������������������������������

   If lAbortPrint
      @nLin,00 PSAY "*** CANCELADO PELO OPERADOR ***"
      Exit
   Endif

   //���������������������������������������������������������������������Ŀ
   //� Impressao do cabecalho do relatorio. . .                            �
   //�����������������������������������������������������������������������

   If nLin > 55 // Salto de P�gina. Neste caso o formulario tem 55 linhas...
      Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
      nLin := 8
   Endif

   // Coloque aqui a logica da impressao do seu programa...
   // Utilize PSAY para saida na impressora. Por exemplo:
   // @nLin,00 PSAY SA1->A1_COD

   nLin := nLin + 1 // Avanca a linha de impressao
	
	//@nLin,00 PSAY cCompet
	@nLin,00 PSAY cCodInt
	@nLin,13 PSAY aBenef[i][4]  //Empresa cCodRDA
	@nLin,24 PSAY aBenef[i][5] //matricula
	@nLin,40 PSAY aBenef[i][14] //tpreg
	@nLin,54 PSAY aBenef[i][15] //digito
	@nLin,65 PSAY AllTrim(aBenef[i][10]) //nomusr
	@nLin,112 PSAY aBenef[i][8] 
   
Next i

nLin += 2
@nLin,00 PSAY "Total de benefici�rios para este RDA neste Rateio: "+AllTrim(STR(nQtdReg))
//���������������������������������������������������������������������Ŀ
//� Finaliza a execucao do relatorio...                                 �
//�����������������������������������������������������������������������

SET DEVICE TO SCREEN

//���������������������������������������������������������������������Ŀ
//� Se impressao em disco, chama o gerenciador de impressao...          �
//�����������������������������������������������������������������������

If aReturn[5]==1
   dbCommitAll()
   SET PRINTER TO
   OurSpool(wnrel)
Endif

MS_FLUSH()


Return



/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Funcao    � CriaSX1  � Autor � Renato Peixoto        � Data � 26/09/11 ���
�������������������������������������������������������������������������Ĵ��
���Descricao � Atualiza perguntas                                         ���
�������������������������������������������������������������������������Ĵ��
���Sintaxe   � CriaSX1()                                                  ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

Static Function CriaSX1()

PutSx1(cPerg,"01",OemToAnsi("Competencia Pgto:")     ,"","","mv_ch1","C",06,0,0,"G","","   ","","","mv_par01",""   ,"","","",""   ,"","","","","","","","","","","",{"Defina qual ser� a competencia de Pgto no formato mmaaaa"},{""},{""})
PutSx1(cPerg,"02",OemToAnsi("Data do Evento:")	  	  ,"","","mv_ch2","D",08,0,0,"G","","   ","","","mv_par02",""   ,"","","",""   ,"","","","","","","","","","","",{"Indique a data que sera usada para lan�ar cada guia no contas m�dicas..."},{""},{""})
PutSx1(cPerg,"03",OemToAnsi("RDA Pgto:")             ,"","","mv_ch3","C",06,0,0,"G","U_XRETUSRAED()","RDAAED","","","mv_par03",""   ,"","","",""   ,"","","","","","","","","","","",{"Defina qual ser� a competencia de Pgto no formato mmaaaa"},{""},{""})
PutSx1(cPerg,"04",OemToAnsi("Vlr Individual do Bonus:"),"","","mv_ch4","N",09,2,0,"G","","   ","","","mv_par04",""   ,"","","",""   ,"","","","","","","","","","","",{"Defina qual ser� o valor individual para o rateio do AED. "},{""},{""})
//PutSx1(cPerg,"05",OemToAnsi("Paga Bonus?")           ,"","","mv_ch5","C",01,0,0,"C","","   ","","","mv_par05","Sim","","","","Nao" ,"","","","","","","","","","","",{"Haver� pagamento de bonus? (Sim/Nao)"},{},{})
//PutSx1(cPerg,"06",OemToAnsi("Vlr Individual Bonus:") ,"","","mv_ch6","N",09,2,0,"G","","   ","","","mv_par06",""   ,"","","",""   ,"","","","","","","","","","","",{"Defina qual ser� o valor individual para o Pgto do bonus. "},{""},{""})

Return
