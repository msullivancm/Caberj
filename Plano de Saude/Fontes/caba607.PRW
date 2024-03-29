#INCLUDE "PROTHEUS.CH"
#INCLUDE "PLSMGER.CH"

#DEFINE drAtivo			"BR_VERDE"    //
#DEFINE drVencido		"BR_LARANJA" // VENCIDO

//Static lDatPagto := GETNEWPAR("MV_PLSDTPG",.F.)

/*--------------------------------------------------------------|
|Rotina: CABA607                | Data: 19/02/2018              |
-----------------------------------------------------------------
|Autor: Mateus Medeiros         								|
-----------------------------------------------------------------
|Descri��o: Rotina para realizar o cadastro da calendariza��o   |
| do Contas M�dicas												|
---------------------------------------------------------------*/

User Function CABA607()
	
	Private cCadastro := OemToAnsi("Calend�rio de Entrega de Faturas") //"Calendario de Pagamento"
	Private aCores    := {}
	Private aRotina   := MenuDef()
	
	// Cores Legenda.
	//AAdd(aCores,	{"STOD(PCX->(PCX_ANO+PCX_MES+PCX_DATFIM)) >= ddatabase",drAtivo 	})
	//AAdd(aCores,	{"STOD(PCX->(PCX_ANO+PCX_MES+PCX_DATFIM)) < ddatabase" ,drVencido   })
	// Fi
	//������������������������������������������������������Ŀ
	//� Endereca a funcao de BROWSE                          �
	//��������������������������������������������������������
	DBSelectArea("PCX")
	PCX->(DBSetOrder(1))
	PCX->(mBrowse( 6, 1,22,75,"PCX",,,,,,/*aCores*/))
	
	//������������������������������������������������������Ŀ
	//� Restaura a Integridade dos Dados                     �
	//��������������������������������������������������������
	SetKey( VK_F3 )
	SetKey( VK_F12 )
	
Return(.T.)

/*/
������������������������������������������������������������������������������
������������������������������������������������������������������������������
��������������������������������������������������������������������������Ŀ��
���Fun��o    �CB607Inc � Autor �Totvs				     � Data �19/02/2018���
��������������������������������������������������������������������������Ĵ��
���Descri��o � Inclusao de dados.                                          ���
��������������������������������������������������������������������������Ĵ��
��� Uso      � CABA607 - Calendario de Entrega de Fatura                   ���
���������������������������������������������������������������������������ٱ�
������������������������������������������������������������������������������
������������������������������������������������������������������������������
/*/
User Function CB607Inc(cAlias,nReg,nOpc)
Return ( AxInclui(cAlias,nReg,nOpc,,,,"u_CB007bOk(nOpc)") )

/*/
������������������������������������������������������������������������������
������������������������������������������������������������������������������
��������������������������������������������������������������������������Ŀ��
���Fun��o    �PLSA265Alt � Autor �Totvs				     � Data �02/12/2010���
��������������������������������������������������������������������������Ĵ��
���Descri��o � Alteracao de dados.                                         ���
��������������������������������������������������������������������������Ĵ��
��� Uso      � PLSA265 - Calendario de Pagamento                           ���
���������������������������������������������������������������������������ٱ�
������������������������������������������������������������������������������
������������������������������������������������������������������������������
/*/
User Function CB607Alt(cAlias,nReg,nOpc)
Return ( AxAltera(cAlias,nReg,nOpc,,,,,"u_CB007bOk(nOpc)") )

/*/
������������������������������������������������������������������������������
������������������������������������������������������������������������������
��������������������������������������������������������������������������Ŀ��
���Fun��o    �PLSA265Exc � Autor �Totvs				     � Data �02/12/2010���
��������������������������������������������������������������������������Ĵ��
���Descri��o � Exclusao	 de dados.                                         ���
��������������������������������������������������������������������������Ĵ��
��� Uso      � PLSA265 - Calendario de Pagamento                           ���
���������������������������������������������������������������������������ٱ�
������������������������������������������������������������������������������
������������������������������������������������������������������������������
/*/
User Function CB607Exc(cAlias,nReg,nOpc)
Return ( AxDeleta(cAlias,nReg,nOpc,"") )
/*/
������������������������������������������������������������������������������
������������������������������������������������������������������������������
��������������������������������������������������������������������������Ŀ��
���Fun��o    �PLSA265bOk � Autor �Totvs			         � Data �02/12/2010���
��������������������������������������������������������������������������Ĵ��
���Descri��o � Funcao de validacao do botao "Confirmar".                   ���
��������������������������������������������������������������������������Ĵ��
��� Uso      � PLSA265 - Calendario de Pagamento                           ���
���������������������������������������������������������������������������ٱ�
������������������������������������������������������������������������������
������������������������������������������������������������������������������
/*/
User Function CB007bOk(nOpc)
	
	LOCAL aArea 	:= GetArea()
	LOCAL cSQL      := ""
	LOCAL lRet		:= .T.
	LOCAL nRecno    := 0
	LOCAL lInicial  := .F.
	LOCAL lFim      := .F.
	LOCAL cCodDat	:= ""
	LOCAL cCodInt	:= ""
	LOCAL cReemb	:= ""
	Local lComp 	:= .F.
	Local cAlias1   := GetNextAlias()
	Local cAnoMes	:= M->PCX_ANO+M->PCX_MES
	
	
	
	If lRet .And. nOpc == K_Incluir .Or. nOpc == K_Alterar // Inclusao ou Altera��o
		//��������������������������������������������������������������������������Ŀ
		//� Se for alteracao, pego o Recno do registro corrente                      �
		//����������������������������������������������������������������������������
		If nOpc == K_Alterar
			nRecno:= PCX->(Recno())
		Endif
		
		cSQL := "SELECT PCX_CODOPE,PCX_DATINI, PCX_DATFIM,PCX_ANO,PCX_MES,PCX_RDA,PCX_GRPPGT, "
		
		cSQL += " R_E_C_N_O_  RecnoPCX FROM "+RetSQLName("PCX")+" "
		cSQL += " WHERE PCX_FILIAL = '"+xFilial("PCX")+"' AND "
		cSQL += " PCX_CODOPE = '"+ M->PCX_CODOPE +"' AND "
		cSQL += " PCX_ANO = '"+ M->PCX_ANO +"' AND "
		cSQL += " PCX_MES = '"+ M->PCX_MES +"' AND "
		cSQL += " D_E_L_E_T_ = ''"
		
		cSQL := ChangeQuery(cSQL)
		dbUseArea(.T.,"TOPCONN",TCGENQRY(,,cSQL),"Trb265",.F.,.T.)
		
		While Trb265->(!Eof())
			//��������������������������������������������������������������������������Ŀ
			//� Tratamento para que na alteracao nao compare o registro corrente         �
			//����������������������������������������������������������������������������
			If nOpc == K_Alterar .And. nRecno == Trb265->(RecnoPCX)
				Trb265->(DbSkip())
				Loop
			Endif
			
			//��������������������������������������������������������������������������Ŀ
			//� Valida a Faixa Inicial e Final da competencia do Calendario			     �
			//����������������������������������������������������������������������������
			If !Empty(alltrim(M->PCX_RDA))
				
				if Alltrim(M->PCX_RDA) == Alltrim(Trb265->PCX_RDA)
					// Verifica se a Data inicial pertence a um calendario ja cadastrado
					If !lInicial .And. STOD(M->(PCX_ANO+PCX_MES+PCX_DATINI)) >= SToD(Trb265->(PCX_ANO+PCX_MES+PCX_DATINI)) .And. STOD(M->(PCX_ANO+PCX_MES+PCX_DATINI)) <= SToD(Trb265->(PCX_ANO+PCX_MES+PCX_DATFIM))
						lInicial:= .T.
					Endif
					// Verifica se a Data final pertence a um calendario ja cadastrado
					If !lFim .And. STOD(M->(PCX_ANO+PCX_MES+PCX_DATFIM)) >= SToD(Trb265->(PCX_ANO+PCX_MES+PCX_DATINI)) .And. STOD(M->(PCX_ANO+PCX_MES+PCX_DATFIM)) <= SToD(Trb265->(PCX_ANO+PCX_MES+PCX_DATFIM))
						lFim:= .T.
					Endif
				
				
					BeginSql Alias cAlias1
						
						SELECT COUNT(PCX_GRPPGT) CONT
						FROM %table:PCX%
						WHERE PCX_RDA = %exp:M->PCX_GRPPGT%
						AND PCX_ANO||PCX_MES = %exp:cAnoMes%
						AND D_E_L_E_T_ <> '*'
					
					EndSql
					
					// Verifica se existe compet�ncia cadastrada. 
					if !lComp .and. (cAlias1)->CONT > 0
						lComp := .T.
					endif
					
					if select(cAlias1) > 0
						dbselectarea(cAlias1)
						dbclosearea()
					endif
				
				Endif
				
			Else
				
				If Alltrim(M->PCX_GRPPGT) == Alltrim(Trb265->PCX_GRPPGT)
					// Verifica se a Data inicial pertence a um calendario ja cadastrado
					If !lInicial .And. STOD(M->(PCX_ANO+PCX_MES+PCX_DATINI)) >= SToD(Trb265->(PCX_ANO+PCX_MES+PCX_DATINI)) .And. STOD(M->(PCX_ANO+PCX_MES+PCX_DATINI)) <= SToD(Trb265->(PCX_ANO+PCX_MES+PCX_DATFIM))
						lInicial:= .T.
					Endif
					// Verifica se a Data final pertence a um calendario ja cadastrado
					If !lFim .And. STOD(M->(PCX_ANO+PCX_MES+PCX_DATFIM)) >= SToD(Trb265->(PCX_ANO+PCX_MES+PCX_DATINI)) .And. STOD(M->(PCX_ANO+PCX_MES+PCX_DATFIM)) <= SToD(Trb265->(PCX_ANO+PCX_MES+PCX_DATFIM))
						lFim:= .T.
					Endif
					
					BeginSql Alias cAlias1
						
						SELECT COUNT(PCX_GRPPGT) CONT
						FROM %table:PCX%
						WHERE PCX_GRPPGT = %exp:M->PCX_GRPPGT%
						AND PCX_ANO||PCX_MES = %exp:cAnoMes%
						AND D_E_L_E_T_ <> '*'
					
					EndSql
					
					// Verifica se existe compet�ncia cadastrada. 
					if !lComp .and. (cAlias1)->CONT > 0
						lComp := .T.
					endif
					
					if select(cAlias1) > 0
						dbselectarea(cAlias1)
						dbclosearea()
					endif
					
				Endif
				
			Endif
			
			Trb265->(DbSkip())
		End
		//������������������������������������������������������������������������������������������Ŀ
		//� Se as datas Inicial e Final ja estiverem numa faixa de competencia ja cadastrada, critico�
		//��������������������������������������������������������������������������������������������
		If lRet
			Do Case
			Case lComp
				MsgAlert("Compet�ncia j� cadastrada, favor verificar.  ("+ M->PCX_MES + "/" + M->PCX_ANO +")")//
				lRet:=.F.
			Case lInicial .And. lFim
				MsgAlert("A data inicial e a data final pertence a um  per�odo j� cadastrado do Calend�rio de pagamento da compet�ncia "+ M->PCX_MES + "/" + M->PCX_ANO +")")//
				lRet:=.F.
			Case lInicial
				MsgAlert("A data inicial pertence a um  per�odo j� cadastrado do Calend�rio de pagamento da compet�ncia "+ M->PCX_MES + "/" + M->PCX_ANO +")")//
				lRet:=.F.
			Case lFim
				MsgAlert("A data final pertence a um  per�odo  j� cadastrado do Calend�rio de pagamento da compet�ncia "+ M->PCX_MES + "/" + M->PCX_ANO +")") //
				lRet:=.F.
			End Case
		EndIf
		
		if select("Trb265") > 0
			dbselectarea("Trb265")
			Trb265->(DbCloseArea())
		endif
		
	Endif
	
	RestArea(aArea)
	
Return(lRet)

/*/
������������������������������������������������������������������������������
������������������������������������������������������������������������������
��������������������������������������������������������������������������Ŀ��
���Fun��o    |CB607DTI � Autor �Totvs			         � Data �02/12/2010���
��������������������������������������������������������������������������Ĵ��
���Descri��o � Funcao Validacao Data Inicial			                   ���
��������������������������������������������������������������������������Ĵ��
��� Uso      � PLSA265 - Calendario de Pagamento                           ���
���������������������������������������������������������������������������ٱ�
������������������������������������������������������������������������������
������������������������������������������������������������������������������
/*/
User Function CB607DTI(cAno, cMes, dDatIni)
	LOCAL aArea 		:= GetArea()
	LOCAL lRet			:= .T.
	DEFAULT cAno        := M->PCX_ANO
	DEFAULT cMes        := M->PCX_MES
	
	//������������������������������������������������������������������Ŀ
	//� Valida a Data Inicial x Competencia do Calendario			     �
	//��������������������������������������������������������������������
	If cAno+cMes <> Substr(dTos(dDatIni),1,6)
		MsgAlert("Data Inicial deve estar dentro da competencia do calend�rio!") //"Data Inicial deve estar dentro da competencia do calend�rio!"
		lRet:=.F.
	Endif
	
	RestArea(aArea)
	
Return(lRet)

/*/
������������������������������������������������������������������������������
������������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ���
���Funcao    � MenuDef � Autor � Totvs				    � Data � 02/04/07 ����
�������������������������������������������������������������������������Ĵ���
���Descricao � Atualizacao do menu funcional                              ����
�������������������������������������������������������������������������Ĵ���
���Sintaxe   � MenuDef()                                                  ����
�������������������������������������������������������������������������Ĵ���
��� Uso      � Advanced Protheus                                          ����
��������������������������������������������������������������������������ٱ��
������������������������������������������������������������������������������
������������������������������������������������������������������������������
/*/
Static Function MenuDef()
	
	Local aRotina := {}
	
	aAdd(aRotina,{ "Pesquisar"	,"AxPesqui"   	,0,K_Pesquisar	}) //"Pesquisar"
	aAdd(aRotina,{ 'Visualizar'	,'AxVisual'     ,0,K_Visualizar	}) //'Visualizar'
	aAdd(aRotina,{ 'Incluir' 	,'u_CB607Inc'   ,0,K_Incluir	}) //'Incluir'
	aAdd(aRotina,{ 'Alterar' 	,'u_CB607Alt'   ,0,K_Alterar	}) //'Alterar'
	aAdd(aRotina,{ 'Excluir' 	,'u_CB607Exc'   ,0,5			}) //'Excluir'
	aAdd(aRotina,{ 'Legenda' 	,'u_CB607LEG'   ,0,0			}) //'Legenda'
	
Return(aRotina)
/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �PLSA265LEG�Autor  �Totvs		         � Data � 19/06/2010  ���
�������������������������������������������������������������������������͹��
���Desc.     �Funcao trata Legenda do calendario	     				  ���
�������������������������������������������������������������������������͹��
���Uso       �PROTHEUS 11 - PLANO DE SAUDE                                ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function CB607LEG()
	
	Local cCadLeg := "Calend�rio de pagamento"//"Calend�rio de pagamento"
	
	BrwLegenda(cCadLeg		,"Calend�rio de pagamento"  ,;   //"Calend�rio de pagamento"
	{{drAtivo	,"Ativo"} ,;  //"Pagamento Credenciado"
	{drVencido	,"Vencido"} }) //"Pagamento Reembolso"
	
Return
/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �PL265VDT	�Autor  �Totvs		         � Data � 19/06/2010  ���
�������������������������������������������������������������������������͹��
���Desc.     �Funcao Valida codigo data de pagamento					  ���
�������������������������������������������������������������������������͹��
���Uso       �PROTHEUS 11 - PLANO DE SAUDE                                ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
/*Function PL265VDT()

If PCX->( FieldPos("PCX_REEMB") ) > 0
	M->PCX_REEMB  := BXU->BXU_REEMB
Endif

If PCX->( FieldPos("PCX_CODDAT") ) > 0
	M->PCX_DATPAG := BXU->BXU_DATPAG
Endif

Return .T.*/

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  |PL265WDT	�Autor  �Totvs		         � Data � 19/06/2010  ���
�������������������������������������������������������������������������͹��
���Desc.     �When do campo COD DATA									  ���
�������������������������������������������������������������������������͹��
���Uso       �PROTHEUS 11 - PLANO DE SAUDE                                ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
/*Function PL265WDT()
LOCAL lRet := .T.
//��������������������������������������������������������������������������Ŀ
//� Se Alteracao/Exclusao - Verifico se a Data de Pagto ja esta Processada   �
//����������������������������������������������������������������������������
If PCX->( FieldPos("PCX_CODDAT") ) > 0 .and. PCX->( FieldPos("PCX_REEMB") ) > 0
	If !Empty(M->PCX_DATPAG)
		BXU->(DbSetOrder(3)) //BXU_FILIAL, BXU_CODINT, BXU_DATPAG, BXU_REEMB
		If BXU->(MsSeek(xFilial("BXU")+M->(PCX_CODINT+DTOS(PCX_DATPAG)+PCX_REEMB))) .And. !Empty(BXU->BXU_DATPRO)
			lRet :=.F.
		Endif
	Endif
Endif


Return lRet*/