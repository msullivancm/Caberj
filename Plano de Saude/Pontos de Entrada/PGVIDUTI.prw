#Include 'RWMAKE.CH'                               
#Include 'PLSMGER.CH'
#Include 'COLORS.CH'
#Include 'TOPCONN.CH'

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �PGVIDUTI  �Autor  � Jean Schulz        � Data �  03/10/06   ���
�������������������������������������������������������������������������͹��
���Desc.     � Tela de log de geracao dos adicionais de pagamento a RDAs  ���
���          � confirme parametrizado por produtos opcionais.             ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                         ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function PGVIDUTI()
//���������������������������������������������������������������������Ŀ
//� Monta matriz com as opcoes do browse...                             �
//�����������������������������������������������������������������������
PRIVATE aRotina   	:=	{	{ "Pesquisar"	    , 'AxPesqui'	  , 0 , K_Pesquisar  },;
{ "&Visualizar"	, 'AxVisual'	  , 0 , K_Visualizar },;
{ "&Gera Adic."	, 'U_GERAADIC'    , 0 , K_Incluir    },;
{ "&Excluir"	, 'U_EXCLADIC'    , 0 , K_Excluir    },;
{ "Gerar Arquivo", 'msgalert("tst") ', 0 , K_Visualizar} } //Leandro 24/10/2007

//���������������������������������������������������������������������Ŀ
//� Titulo e variavies para indicar o status do arquivo                 �
//�����������������������������������������������������������������������
PRIVATE cCadastro 	:= "Gera��o adicionais de pagamento diversos"

PRIVATE cPath  := ""                        
PRIVATE cAlias := "ZZA"
//���������������������������������������������������������������������Ŀ
//� Starta mBrowse...                                                   �
//�����������������������������������������������������������������������
ZZA->(DBSetOrder(1))
ZZA->(mBrowse(006,001,022,075,"ZZA" , , , , , Nil,, , , ,nil, .T.))
ZZA->(DbClearFilter())

Return
              
/*
������������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Programa  � GERAADIC   � Autor � Jean Schulz       � Data � 02.10.2006 ���
�������������������������������������������������������������������������Ĵ��
���Descri��o � Gera adicionais de pagamento para RDA informada por param. ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function GERAADIC(cAlias,nReg,nOpc)

Local I__f := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

LOCAL oDlg
LOCAL nOpca   := 0
LOCAL oEnc
LOCAL aRet
LOCAL bOK        := {|| nOpca := 1, oDlg:End()}
LOCAL bCancel := { || nOpca := 0, oDlg:End() }

PRIVATE cAlias := "ZZA"

//���������������������������������������������������������������������Ŀ
//� Define dialogo...                                                   �
//�����������������������������������������������������������������������
DEFINE MSDIALOG oDlg TITLE cCadastro FROM ndLinIni,000 TO ndLinFin,ndColFin OF GetWndDefault()
//���������������������������������������������������������������������Ŀ
//� Enchoice...                                                         �
//�����������������������������������������������������������������������
Copy cAlias To Memory Blank

oEnc := ZZA->(MsMGet():New(cAlias,nReg,nOpc,,,,,{015,004,192,390},,,,,,oDlg,,,.F.))
//���������������������������������������������������������������������Ŀ
//� Ativa o dialogo...                                                  �
//�����������������������������������������������������������������������
ACTIVATE MSDIALOG oDlg ON INIT EnchoiceBar(oDlg,bOK,bCancel,.F.,{})
//���������������������������������������������������������������������Ŀ
//� Define tratamento de acordo com a opcao...                          �
//�����������������������������������������������������������������������
If nOpca == K_OK
	//���������������������������������������������������������������������Ŀ
	//� Inclui movimento...                                                 �
	//�����������������������������������������������������������������������

	aRet := CRIAADICIO(oEnc:aGets,oEnc:aTela,"",oDlg)
	M->ZZA_VLRTOT	:= aRet[1]
	M->ZZA_VLRUNI	:= aRet[2]
	M->ZZA_QTDCRI	:= aRet[3]
	M->ZZA_QTDUSU	:= aRet[4]

	ZZA->(PLUPTENC("ZZA",K_Incluir))
	

Endif
//���������������������������������������������������������������������Ŀ
//� Fim da Rotina...                                                    �
//�����������������������������������������������������������������������
Return


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Programa  � CRIAADICIO � Autor � Jean Schulz       � Data � 05.09.2006 ���
�������������������������������������������������������������������������Ĵ��
���Descri��o � Gera os adicionais de credito ao RDA.                      ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function CRIAADICIO(aGets,aTela,cNomArq,oDlg)
LOCAL aRet := {0,0,0,0}

Private nBytes := 0 
Private cTitulo := "Gerando adicionais RDA X Opcionais"
PRIVATE nHdl
//���������������������������������������������������������������������Ŀ
//� Testa campos obrigatorios...                                        �
//�����������������������������������������������������������������������
If ! Obrigatorio(aGets,aTela)
	Return(aRet)
Endif

//���������������������������������������������������������������������Ŀ
//� Gera os registros adicionais para prestador conforme adicionais.    �
//�����������������������������������������������������������������������
Processa({|| aRet := fAdicionais() }, cTitulo, "", .T.)

Return aRet


/*
������������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Programa  � EXCLADIC   � Autor � Jean Schulz       � Data � 03.10.2006 ���
�������������������������������������������������������������������������Ĵ��
���Descri��o � Exclui o arquivo e sua composicao                          ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function EXCLADIC(cAlias,nReg,nOpc)

Local n_I 	:= 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS
Local I__f 	:= 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

LOCAL oDlg
LOCAL nOpca		:= 0
LOCAL oEnc
LOCAL bOK    	:= { || nOpca := 1, oDlg:End() }
LOCAL bCancel	:= { || oDlg:End() }
LOCAL cSQL		:= ""

PRIVATE cAlias := "ZZA"

//���������������������������������������������������������������������Ŀ
//� Define dialogo...                                                   �
//�����������������������������������������������������������������������
DEFINE MSDIALOG oDlg TITLE cCadastro FROM ndLinIni,000 TO ndLinFin,ndColFin OF GetWndDefault()
//���������������������������������������������������������������������Ŀ
//� Enchoice...                                                         �
//�����������������������������������������������������������������������
Copy cAlias To Memory

oEnc := ZZA->(MsMGet():New(cAlias,nReg,K_Visualizar,,,,,{015,004,192,390},,,,,,oDlg,,,.F.))
//���������������������������������������������������������������������Ŀ
//� Ativa o dialogo...                                                  �
//�����������������������������������������������������������������������
ACTIVATE MSDIALOG oDlg ON INIT EnchoiceBar(oDlg,bOK,bCancel,.F.,{})
//���������������������������������������������������������������������Ŀ
//� Rotina de exclusao de adicionais de credito / RDA X Opcional...     �
//�����������������������������������������������������������������������
If nOpca == K_OK

	cSQL := " SELECT COUNT(R_E_C_N_O_) AS TOTAL FROM "+RetSQLName("BGQ")
	cSQL += " WHERE BGQ_YLTRDA = '"+M->ZZA_CODIGO+"' "
	cSQL += " AND BGQ_NUMLOT <> ' '"
	cSQL += " AND D_E_L_E_T_ = ' '"
	PlsQuery(cSQL,"TRB")

	//���������������������������������������������������������������������Ŀ
	//� Apagar somente registros nao pagos, e limpar guias ja marcadas...   �
	//�����������������������������������������������������������������������	
	If TRB->TOTAL = 0
		cSQL := " UPDATE "+RetSQLName("BGQ")+" SET D_E_L_E_T_ = '*' "
		cSQL += " WHERE BGQ_YLTRDA = '"+M->ZZA_CODIGO+"' "
		cSQL += " AND BGQ_NUMLOT = ' '"
		cSQL += " AND D_E_L_E_T_ = ' '"
		TCSQLEXEC(cSQL)	  
				
		ZZA->(PLUPTENC("ZZA",K_Excluir))		
	Else
		MsgAlert("Imposs�vel excluir adicionais de pagamento. Os mesmos j� foram faturados !","Aten��o")
	Endif
	
	TRB->(DBCloseArea())	
		
Endif

//���������������������������������������������������������������������Ŀ
//� Fim da Rotina...                                                    �
//�����������������������������������������������������������������������
Return


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  � fAdicionais  �Autor  � Jean Schulz    � Data �  03/10/06   ���
�������������������������������������������������������������������������͹��
���Desc.     �Geracao dos adicionais ao prestador no parametro.           ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � Microsiga.                                                 ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function fAdicionais()
Local aRet			:= {}
Local cRDAAud		:= M->ZZA_CODRDA
Local nVlrTot		:= 0
Local nVlrUni		:= 0
Local nQtdUsu		:= 0
Local cSQL			:= ""
Local cCodPla		:= ""
Local cVerPla		:= ""
Local nProc			:= 0
Local nCont			:= 0
Local nQtdCri		:= 0
Local nTotQry		:= 0
Local nTotArr		:= 0
Local aErr			:= {}
Local aUsr			:= {}
Local aVetCidRDA	:= {}
Local aPlaQtd		:= {}
Local cDescPlano    := ""

//���������������������������������������������������������������������Ŀ
//� Definicao de indices para busca...                                  �
//�����������������������������������������������������������������������
BA1->(DbSetOrder(2))
BA3->(DbSetOrder(1))
BI3->(DbSetOrder(1))
BID->(DbSetOrder(1))
ZZ8->(DbSetOrder(1))
BBB->(DbSetOrder(1))
BAU->(DbSetOrder(1))
BFM->(DbSetOrder(1))

nVlrUni := Posicione("BI3",1,xFilial("BI3")+PLSINTPAD()+M->(ZZA_CODPRO+ZZA_VERPRO),"BI3_YVLADO")

If nVlrUni > 0


	//���������������������������������������������������������������������Ŀ
	//� Analisa os campos de RDA do municipio cfme convenio de opcional...  �
	//�����������������������������������������������������������������������		
	cSQL := " SELECT BID_CODMUN FROM "+RetSQLName("BID")	
	If M->ZZA_CONVEN == "1"
		cSQL += " WHERE BID_YRDVID = '"+M->ZZA_CODRDA+"' "
	Endif
	cSQL += " AND D_E_L_E_T_ = ' '"
	PLSQuery(cSQL,"TRB")
	
	cSQL := ""

	//���������������������������������������������������������������������Ŀ
	//� Seleciona cidades que a RDA tem abrangencia para o VIDAUTI          �
	//�����������������������������������������������������������������������	
	TRB->(DbGoTop())	
	While ! TRB->(Eof())
		aadd(aVetCidRDA,TRB->BID_CODMUN)
		TRB->(DbSkip())		
	Enddo	
	TRB->(DbCloseArea())		
		
	//���������������������������������������������������������������������Ŀ
	//� Consulta principal para quantidade de usuarios x opcionais...       �
	//�����������������������������������������������������������������������
	For nCont := 1 to 2
		
		If nCont == 1
			cSQL := " SELECT COUNT(R_E_C_N_O_) AS TOTAL FROM "+RetSQLName('BF4')
		Else
			cSQL := " SELECT R_E_C_N_O_ AS REGISTRO FROM "+RetSQLName('BF4')
		Endif		
	
		cSQL += " WHERE (BF4_DATBLO = ' ' OR BF4_DATBLO < '"+DtoS(M->ZZA_DATBAS)+"') "
		cSQL += " AND BF4_CODPRO = '"+M->ZZA_CODPRO+"' "
		cSQL += " AND BF4_VERSAO = '"+M->ZZA_VERPRO+"' "
//		cSQL += " AND ROWNUM <= 100 "
		cSQL += " AND D_E_L_E_T_ = ' ' "
		
		If nCont == 1
			PLSQuery(cSQL,"TRB")
			nTotQry := TRB->TOTAL
			TRB->(DbCloseArea())
		Endif
		
	Next
	
	PLSQuery(cSQL,"TRB")	
	
	ProcRegua( nTotQry )
	
	While ! TRB->(Eof())
	
		nProc++
		IncProc("Lendo registro " + AllTrim(Str(nProc)) )
	
		BF4->(DbGoto(TRB->REGISTRO))
		
		BA1->(MsSeek(xFilial("BA1")+BF4->(BF4_CODINT+BF4_CODEMP+BF4_MATRIC+BF4_TIPREG)))
		BA3->(MsSeek(xFilial("BA3")+BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_CONEMP+BA1_VERCON+BA1_SUBCON+BA1_VERSUB)))
		
		If Empty(BA1->BA1_CODPLA)
			cCodPla := BA3->BA3_CODPLA
			cVerPla := BA3->BA3_VERSAO
		Else
			cCodPla := BA1->BA1_CODPLA
			cVerPla := BA1->BA1_VERSAO	
		Endif
		
		//----> Leandro e Raquel 15/01/2007  Obter a descricao do plano para informar no relatorio de log.  
	    BI3->(dbSeek(xFilial("BI3")+BA1->(BA1_CODINT+BA1_CODPLA+BA1_VERSAO)))
		cDescPlano := BI3->BI3_DESCRI
		//-----<
		
		//���������������������������������������������������������������������Ŀ
		//� Valida data de bloqueio usuario x adicional...                      �
		//�����������������������������������������������������������������������	
		If !(Empty(BA1->BA1_DATBLO) .Or. Substr(DtoS(BA1->BA1_DATBLO),1,6) < M->(ZZA_ANOADI+ZZA_MESADI))
			TRB->(DbSkip())
			Loop
		Endif
		
		//���������������������������������������������������������������������Ŀ
		//� Valida endereco do usuario x abrangencia RDA...                     �
		//�����������������������������������������������������������������������	
		If Len(aVetCidRDA) > 0
			If ascan(aVetCidRDA,BA1->BA1_CODMUN) = 0
				TRB->(DbSkip())
				Loop
			Endif
		Endif		

		//���������������������������������������������������������������������Ŀ
		//� Separar quantidade de atendimentos X adicional x plano usuario...   �
		//�����������������������������������������������������������������������			    
		If ZZ8->(MsSeek(xFilial("ZZ8")+cCodPla+cVerPla+"2")) //Convenio 2 = VidaUti
		
		    nPos := Ascan( aPlaQtd, { |x| x[1] == ZZ8->ZZ8_ADIAUD } )
		    
		    If nPos > 0
		    	aPlaQtd[nPos,2]++
		    Else
				aadd(aPlaQtd,{ZZ8->ZZ8_ADIAUD,1})	    
		    Endif
		    
		    nQtdUsu++
		    
		    cGerRel := GetNewPar("MV_YVDUTRL","1")
		    
		    If cGerRel == "1"
		    	aadd(aUsr,{BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG),BA1->BA1_MATANT,cCodPla+" "+cDescPlano,cVerPla})		
		    Endif
		    
		Else
			aadd(aErr,{"Aten��o! Produto/Versao: "+cCodPla+"/"+cVerPla+" n�o possui cadastro de adicionais para prestador. Verifique!"})
			nQtdCri++
		Endif
		
		TRB->(DbSkip())
		
	Enddo
	
	//���������������������������������������������������������������������Ŀ
	//� Calcular o valor total a ser lancado...                             �
	//�����������������������������������������������������������������������	
	If nQtdUsu > 0
		nVlrTot := nVlrUni*nQtdUsu
		
		Begin Transaction
	
		For nCont := 1 to Len(aPlaQtd)
		
			BBB->(MsSeek(xFilial("BBB")+aPlaQtd[nCont,1]))
	
			//���������������������������������������������������������������������Ŀ
			//� Necessario truncar casas decimais, lancando centavo no ultimo adic. �
			//�����������������������������������������������������������������������					
			BGQ->(Reclock("BGQ",.T.))	
			BGQ->BGQ_FILIAL	:= xFilial("BGQ") 
			BGQ->BGQ_CODSEQ	:= GETSX8NUM("BGQ","BGQ_CODSEQ")
			BGQ->BGQ_CODIGO	:= cRDAAud
			BGQ->BGQ_NOME	:= Posicione("BAU",1,xFilial("BAU")+cRDAAud,"BAU_NOME")
			BGQ->BGQ_ANO	:= M->ZZA_ANOADI
			BGQ->BGQ_MES	:= M->ZZA_MESADI
			BGQ->BGQ_CODLAN	:= aPlaQtd[nCont,1]
			BGQ->BGQ_VALOR	:= IIf(nCont <> nQtdUsu,NoRound(nVlrUni*aPlaQtd[nCont,2],2),nVlrTot-nTotArr)
			BGQ->BGQ_QTDCH	:= 0
			BGQ->BGQ_TIPO	:= "2" //Credito
			BGQ->BGQ_TIPOCT	:= "2" //PJ
			BGQ->BGQ_INCIR	:= BBB->BBB_INCIR
			BGQ->BGQ_INCINS	:= BBB->BBB_INCINS
			BGQ->BGQ_INCPIS	:= BBB->BBB_INCPIS
			BGQ->BGQ_INCCOF	:= BBB->BBB_INCCOF
			BGQ->BGQ_INCCSL	:= BBB->BBB_INCCSL
			BGQ->BGQ_VERBA	:= BBB->BBB_VERBA
			BGQ->BGQ_CODOPE	:= PLSINTPAD()
			BGQ->BGQ_CONMFT	:= "0" //Nao
			BGQ->BGQ_OBS	:= "LANCTO RDA X OPCIONAL / LOTE: "+M->ZZA_CODIGO
			BGQ->BGQ_USMES	:= Posicione("BFM",1,PLSINTPAD()+M->(ZZA_ANOADI+ZZA_MESADI),"BFM_VALRDA")
			BGQ->BGQ_LANAUT	:= "0" //Nao
			BGQ->BGQ_YLTRDA	:= M->ZZA_CODIGO
			BGQ->(MsUnlock()) 
			ConfirmSx8()
			
			If nCont <> Len(aPlaQtd)
				nTotArr += BGQ->BGQ_VALOR
			Endif
				
		Next
		
		End Transaction
		
	Else	
		aadd(aErr,{"Aten��o! Nenhum lan�amento foi efetuado! Valor total de pagamento ser� zerado!"})
		nVlrTot := 0
		nVlrUni := 0
		nQtdCri++
	Endif	
Else
	aadd(aErr,{"Aten��o! Opcional "+M->ZZA_CODPRO+"/"+M->ZZA_VERPRO+" n�o possui valor de adicional! Imposs�vel gerar adic. de pagamento"})
	nVlrUni := 0
	nVlrTot := 0
	nQtdUsu	:= 0
	nQtdCri++
Endif
	
If Len(aPlaQtd) > 0
	MsgAlert("Adicionais de pagamento gerados. Verifique os resultados!")
Endif

If Len(aErr) > 0
	PLSCRIGEN(aErr,{ {"Descri��o da cr�tica","@C",400}},"Cr�ticas encontradas",.T.)
Endif

If Len(aUsr) > 0 
	PLSCRIGEN(aUsr,{ {"Cod. Usuario","@C",50},{"Matr. Antiga","@C",30},{"Cod. Plano","@C",15},{"Ver. Plano","@C",15}},"Usu�rios utilizados para c�lculo...",.T.)
Endif


TRB->(DbCloseArea())

aRet := {nVlrTot,nVlrUni,nQtdCri,nQtdUsu}

Return aRet