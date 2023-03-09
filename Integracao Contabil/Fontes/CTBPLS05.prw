#Include 'protheus.ch'

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �CTBPLS05  �Autor  �Roger Cangianeli    � Data �  21/03/06   ���
�������������������������������������������������������������������������͹��
���Desc.     � Busca dinamica da conta, conforme configuracao flexivel    ���
���          � no arquivo especifico SZT. (Faturamento)          		  ���
�������������������������������������������������������������������������͹��
���Uso       � Unimed e cooperativas                                      ���
���������������������������������]����������������������������������������ͼ��
���31/10/07  � A partir desta data o programa passa a considerar somente  ���
���          � movimentos referentes a mensalidade (PP ou CO) e lancamento���
���          � de custo operacional (em planos Demais Modalidades).       ���
���          � O tratamento a classe do procedimento passa a ser feito em ���
���          � outro lancamento, pelo programa CTBPLS11. RC.              ���
���26/03/08  � A partir desta data o programa passa a considerar somente  ���
���          � movimentos referentes a mensalidade (PP ou CO).			  ���
���          � Os demais tratamentos passam a ser feitos pelo  programa   ���
���          � CTBPLS11. RC.             								  ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

//�������������������������������������������������������������Ŀ
//�Este programa fara uma busca de conta conforme a string busca�
//�(cBusca) que ser� montada. Esta string ira variar conforme a �
//�combinacao de informacoes que serao avaliadas.               �
//�Alguns arquivos estao sempre posicionados no momento do      �
//�lancamento, portanto somente sera posicionado o arquivo de   �
//�combinacoes de contas e especificos.                         �
//�Roger Cangianeli.                                            �
//���������������������������������������������������������������

User Function CTBPLS05( lLogUsu, cNatLct, cTipLct, lConAnt, lAtuFlag, cTipAto )

//������������������������������������������������������������������Ŀ
//�Inicializa Parametros:                                            �
//�MV_YCTPL05 --> Codigo dos Tipos de Planos Individuais / Familiares�
//�MV_YCTPL07 --> Codigo dos planos do opcional Usimed               �
//�MV_YCTPL13 --> Conta para contabilizar Tx.Adm. em conta unica     �
//��������������������������������������������������������������������
Local cCtpl05	:= GetNewPar('MV_YCTPL05','1')
Local cCtpl07	:= GetNewPar('MV_YCTPL07','0086')
Local cCtpl13	:= GetNewPar('MV_YCTPL13','3311810100001')
Local cCodPla   := Space(4)

//��������������������������������������Ŀ
//�Inicializa as variaveis neste ambiente�
//����������������������������������������
Local cRet, cBusca, aArea, aAreaBA1, aAreaBA3, aAreaBSP, cDtEmis, cDtComp, lMensal
//, cClasse, cBauEst, cBauTipPre, cBauCopCre, nHand, cFile
Local cBi3ModPag,cBi3ApoSrg,cBi3TipCon,cBi3Tipo,cBi3CodSeg, cTipoBG9, cBi3TpBen, cProc		//,cBi3XModPg

Default lLogUsu	:= .T.		// Habilita gravacao do Log. Bom para nao replicar no retorno 4 do CTBPLS06.
Default cNatLct	:= 'D'		// Natureza do lan�amento: D-D�bito / C-Cr�dito. Esta natureza � relativa ao
// retorno do programa, se deve retornar a conta cr�dito ou d�bito.

Default cTipLct	:= 'I'		// Tipo do Lan�amento: I-Inclus�o / C-Cancelamento / P-Provis�o (para t�tulos exclu�dos antes de contabilizar)
Default lConAnt	:= .T.		// Considerar faturamento antecipado? .T. - Considera / .F. - N�o Considera

Default lAtuFlag:= .T.		// Atualiza flag contabiliza��o? .T. - Atualiza / .F. - N�o atualiza
// Utilizado para identificar registros de faturamento antecipado.

Default cTipAto	:= ''		// Tipo de Ato: 0-Ato Coop Aux / 1-Ato Coop Princ / 2-Ato Nao Coop
// Identifica se deve tratar tipo de ato especifico ou pelo processo normal (n�o passa par�metro).
// Utilizado para divis�o de atos no BM1 - BM1_YVLACP/BM1_YVLACA/BM1_YVLANC

aArea	:= GetArea()
aAreaBA1:= BA1->(GetArea())
aAreaBA3:= BA3->(GetArea())
aAreaBFQ:= BFQ->(GetArea())
aAreaBSP:= BSP->(GetArea())

// Define qual arquivo ir� tratar
If cTipLct == 'I'
	cAlias	:= 'BM1'
Else
	cAlias	:= 'BMN'
EndIf


//��������������������������������������������������������������������������Ŀ
//�Inserida validacao do posicionamento do usuario e tentativa de localizacao�
//�pelo codigo antigo deste.                                                 �
//�Roger Cangianeli - 24/05/06                                               �
//����������������������������������������������������������������������������

// Verifica se o programa nao achou o usuario ou se parou em usuario diferente, para procurar pelo codigo antigo.
If BA1->(Eof()) .or. BA3->(Eof())
	lAchouBA1 := .F.
	dbSelectArea('BA1')
	BA1->(dbSetOrder(2))
	If BA1->(MsSeek(xFilial('BA1')+&(cAlias+'->('+cAlias+'_CODINT +'+cAlias+'_CODEMP+ '+cAlias+'_MATRIC + '+cAlias+'_TIPREG)') ) )
		lAchouBA1:= .T.
	Else
		If BA1->(dbSeek(xFilial('BA1')+&(cAlias+'->'+cAlias+'_MATUSU'), .F.))
			lAchouBA1:= .T.
		Else
			BA1->(dbSetOrder(5))
			If dbSeek(xFilial('BA1')+&(cAlias+'->'+cAlias+'_MATUSU'), .F.)
				lAchouBA1:= .T.
			EndIf
		EndIf
	EndIf
	
	If lAchouBA1
		dbSelectArea('BA3')
		BA3->(dbSetOrder(1))
		BA3->(dbSeek(xFilial('BA3')+BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC),.F.))
	Else
		//������������������������������������������Ŀ
		//�Grava em memoria a composicao da cobranca.�
		//��������������������������������������������
		cProc	:= 'Lt.Cobr:'+Subs(&(cAlias+'->'+cAlias+'_PLNUCO'),5,8)+'|Seq:'+&(cAlias+'->'+cAlias+'_SEQ')+'|Tit:'+&(cAlias+'->'+cAlias+'_NUMTIT')
		cProc	+= '|Matr:'+&(cAlias+'->('+cAlias+'_CODINT+'+cAlias+'_CODEMP+'+cAlias+'_MATRIC+'+cAlias+'_TIPREG+'+cAlias+'_DIGITO)')+'|Nome:'+Subs(&(cAlias+'->'+cAlias+'_NOMUSR'),1,20)
		cProc	+= '|Prod: N/Enc. |Grp.Emp:'+&(cAlias+'->'+cAlias+'_CODEMP')
		cProc	+= '|Contr:'+BA1->BA1_CONEMP+'/'+BA1->BA1_VERCON+'|Sub:'+BA1->BA1_SUBCON+'/'+BA1->BA1_VERSUB
		cProc	+= '|Tp.Fat:'+&(cAlias+'->'+cAlias+'_CODTIP')+'|Evto:'+&(cAlias+'->'+cAlias+'_CODEVE')
		cProc	+= '|Vl.Evto:|'+StrZero(&(cAlias+'->'+cAlias+'_VALOR'),10,2)+'|Vl.Tit.:|'+StrZero(SE1->E1_VALOR,10,2)
		cProc	+= IIf(&(cAlias+'->'+cAlias+'_TIPO')=='1','|Deb/Cred:D',IIf(&(cAlias+'->'+cAlias+'_TIPO')=='2','|Deb/Cred:C',''))
		cProc	+= '|Usuario nao encontrado|CTBPLS05'
		cRet	:= 'X'
		
		// Grava log de registro com problema
		U_Gravalog(cProc,'FAT')
		
		BSP->(RestArea(aAreaBSP))
		BA3->(RestArea(aAreaBA3))
		BA1->(RestArea(aAreaBA1))
		RestArea(aArea)
		Return(cRet)
		
	EndIf
EndIf


//�������������������������������������������������Ŀ
//�POSICIONAR PRODUTO - BUSCAR BI3               	�
//���������������������������������������������������
// Identifica se o plano esta no usuario ou na familia
If Empty(BA1->BA1_CODPLA)
	cPlano	:= BA3->BA3_CODPLA+BA3->BA3_VERSAO
	cCodPla := BA3->BA3_CODPLA
Else
	cPlano	:= BA1->BA1_CODPLA+BA1->BA1_VERSAO
	cCodPla := BA1->BA1_CODPLA
EndIf

cBi3ModPag		:= Posicione("BI3",1,xFilial("BI3")+PLSINTPAD()+cPlano,"BI3_MODPAG")
//cBi3XModPg		:= Posicione("BI3",1,xFilial("BI3")+PLSINTPAD()+cPlano,"BI3_YMODPG")
cBi3ApoSrg		:= Posicione("BI3",1,xFilial("BI3")+PLSINTPAD()+cPlano,"BI3_APOSRG")
cBi3TipCon		:= Posicione("BI3",1,xFilial("BI3")+PLSINTPAD()+cPlano,"BI3_TIPCON")
cBi3Tipo		:= Posicione("BI3",1,xFilial("BI3")+PLSINTPAD()+cPlano,"BI3_TIPO")
cBi3CodSeg		:= Posicione("BI3",1,xFilial("BI3")+PLSINTPAD()+cPlano,"BI3_CODSEG")
cBi3TpBen		:= Posicione("BI3",1,xFilial("BI3")+PLSINTPAD()+cPlano,"BI3_YTPBEN")

//������������������������������������������������������������������������Ŀ
//�TIPO DO BENEFICIARIO                                                    �
//�Verifica conteudo do campo BI3_YTPBEN ( Char(1) ), especifico que indica�
//�o tipo de beneficiario do contrato. As opcoes sao:                      �
//�1 - BE - Beneficiario Exposto                                           �
//�2 - ENB - Exposto Nao Beneficiario                                      �
//�3 - BNE - Beneficiario Nao Exposto                                      �
//�4 - PS - Prestacao de Servicos                                          �
//��������������������������������������������������������������������������
cBusca	:= cBi3TpBen


// Posiciona Contrato, caso nao esteja posicionado
If AllTrim(BG9->BG9_CODINT)+AllTrim(BG9->BG9_CODIGO) <> AllTrim(BA1->BA1_CODINT)+AllTrim(BA1->BA1_CODEMP)
	cTipoBG9:= Posicione("BG9",1,xFilial("BG9")+BA1->BA1_CODINT+BA1->BA1_CODEMP,"BG9_TIPO")
Else
	cTipoBG9:= BG9->BG9_TIPO
EndIf



//������������������������������������������Ŀ
//�Grava em memoria a composicao da cobranca.�
//�Sera utilizado nos arquivos de log.       �
//��������������������������������������������
cProc	:= 'Lt.Cobr:'+Subs(&(cAlias+'->'+cAlias+'_PLNUCO'),5,8)+'|Seq:'+&(cAlias+'->'+cAlias+'_SEQ')+'|Tit:'+&(cAlias+'->'+cAlias+'_NUMTIT')
cProc	+= '|Matr:'+&(cAlias+'->('+cAlias+'_CODINT+'+cAlias+'_CODEMP+'+cAlias+'_MATRIC+'+cAlias+'_TIPREG+'+cAlias+'_DIGITO)')+'|Nome:'+Subs(BA1->BA1_NOMUSR,1,20)
cProc	+= '|Prod:'+Subs(cPlano,1,4)+'/'+Subs(cPlano,5,3)+'|Grp.Emp:'+BA1->BA1_CODEMP
cProc	+= '|Contr:'+BA1->BA1_CONEMP+'/'+BA1->BA1_VERCON+'|Sub:'+BA1->BA1_SUBCON+'/'+BA1->BA1_VERSUB
cProc	+= '|Tp.Fat:'+&(cAlias+'->'+cAlias+'_CODTIP')+'|Evto:'+&(cAlias+'->'+cAlias+'_CODEVE')
cProc	+= '|Vl.Evto:|'+StrZero(&(cAlias+'->'+cAlias+'_VALOR'),10,2)+'|Vl.Tit.:|'+StrZero(SE1->E1_VALOR,10,2)
cProc	+= IIf(&(cAlias+'->'+cAlias+'_TIPO')=='1','|Deb/Cred:D',IIf(&(cAlias+'->'+cAlias+'_TIPO')=='2','|Deb/Cred:C',''))



// Posiciona para tratamento a conta fixa no BFQ
If AllTrim(&(cAlias+'->'+cAlias+'_CODTIP')) <> AllTrim(BFQ->BFQ_PROPRI)+AllTrim(BFQ->BFQ_CODLAN)
	BFQ->(dbSetOrder(1))
	BFQ->(dbSeek(xFilial('BFQ')+PlsIntPad()+AllTrim(&(cAlias+'->'+cAlias+'_CODTIP')),.F.))
EndIf



//������������������������������������������������������������������Ŀ
//�TIPO DO CONTRATO PARA FATURAMENTO                                 �
//�Este campo analisa condicoes para classificar o tipo de contrato, �
//�conforme segue:                                                   �
//�1 - Demais Modalidades (CO) --> alterado para programa CTBPLS11.  �
//�2 - Mensalidade PP                                                �
//�3 - Mensalidade CO                                                �
//�4 - CO em PP        } estas situa��es s�o descartadas             �
//�5 - Participacao    } neste programa. RC.                         �
//��������������������������������������������������������������������
lMensal	:= .F.
Do Case
	
	// Tratamento a conta fixa no BFQ para qualquer tipo de lan�amento, exceto Outros D�bitos/Cr�ditos
	Case !Empty(BFQ->BFQ_CONTA) .and. !Alltrim(&(cAlias+'->'+cAlias+'_CODTIP')) $ '113,128,129,130,131,132,135,136,180'
		cRet	:= BFQ->BFQ_CONTA
		// Chama funcao para gravacao de log
		If lLogUsu
			U_GrvLogBom(cProc+'|Comb:'+cBusca+'|Conta:'+cRet,'FAT')
		EndIf
		BFQ->(RestArea(aAreaBFQ))
		BSP->(RestArea(aAreaBSP))
		BA3->(RestArea(aAreaBA3))
		BA1->(RestArea(aAreaBA1))
		RestArea(aArea)
		Return(cRet)
		
		// Lancamentos exclusivos de Custo Operacional -> retorna Demais modalidades (CO)
	Case AllTrim(&(cAlias+'->'+cAlias+'_CODTIP')) $ '104,127,134,137,138,139,140,141,142,143,144,145,156,157,158,159,160,161,162,163,164,165,166,167'
		// 104	Custo Operac. Servicos Medicos			// 127- Custo Operacional Serv.Acessorios
		// 134- Custo Operacional outros servicos		// 137-	Producao de coop / PF
		// 138-	Producao de coop / PJ					// 139- Servico coop PF outras operadoras
		// 140-	Servico coop PJ outras operadoras		// 141-	SERV.AUXILI.DE DIAGN. E TER
		// 142-	SERV.AUXILIARES OUTRAS UNIM				// 143-	Prod nao cooperados
		// 144- Prod nao coop outras operadoras			// 145- Custos em servicos proprios
		// 156- Taxa custo oper serv medicos			// 157- Taxa adm serv acessorios
		// 158- Taxa outros servicos					// 159- Taxa prod coop / PF
		// 160- Taxa prod coop / PJ						// 161- Taxa serv coop PF / outras operadoras
		// 162- Taxa serv coop PJ / outras operadoras	// 163- Taxa SADT
		// 164- Taxa SADT / outras operadoras			// 165- Taxa prod nao coop
		// 166- Taxa prod nao coop / outras operadoras	// 167- Taxa custo serv proprios
		cBusca	+= '1'
		
		
		// Lancamentos de Mensalidade -> retorna 2-Mensalidade PP ou 3-Mensalidade C.O.
	Case AllTrim(&(cAlias+'->'+cAlias+'_CODTIP')) $ '101,107,110,118' .or.;
		(Alltrim(&(cAlias+'->'+cAlias+'_CODTIP')) $ '102,133,146' .and. !AllTrim(&(cAlias+'->'+cAlias+'_CODEVE')) $ cCtPl07)
		// 101- Mensalidade								// 102- Opcional
		// 107- Cartao de Identificacao					// 110- Valor do Agravo
		// 118- Mensalidade Retroativa
		// 133- Taxa de Adesao do Opcional				// 146- Opcional Retroativo
		cBusca	+= IIf( AllTrim(cBi3ModPag) $ '1', '2', '3' )
		lMensal	:= .T.
		
		// Opcional Usimed
	Case Alltrim(&(cAlias+'->'+cAlias+'_CODTIP')) $ '102,133,146' .and. AllTrim(&(cAlias+'->'+cAlias+'_CODEVE')) $ cCtPl07
		// 102- Opcional		// 133- Taxa de Adesao do Opcional		// 146- Opcional Retroativo
		cRet	:= Posicione("BI3",1,xFilial("BI3")+PLSINTPAD()+AllTrim(&(cAlias+'->'+cAlias+'_CODEVE')),"BI3_CONTA")
		If Empty(cRet)
			cRet	:= 'C->Opc:'+AllTrim(&(cAlias+'->'+cAlias+'_CODEVE'))
			cProc	+= '|Cadastrar Cta no Opcional'
			// Grava log de registro com problema
			U_Gravalog(cProc,'FAT')
		ElseIf lLogUsu
			// Chama funcao para gravacao de log bom
			U_GrvLogBom(cProc+'|Comb:'+cBusca+'|Conta:'+cRet,'FAT')
		EndIf
		BFQ->(RestArea(aAreaBFQ))
		BSP->(RestArea(aAreaBSP))
		BA3->(RestArea(aAreaBA3))
		BA1->(RestArea(aAreaBA1))
		RestArea(aArea)
		Return(cRet)
		
		// Taxa de Inscricao -> retorna 2-Mensalidade PP ou 3-Mensalidade CO
	Case Alltrim(&(cAlias+'->'+cAlias+'_CODTIP')) $ '103'
		// 103- Taxa de Inscricao
		cBusca	+= IIf( AllTrim(cBi3ModPag) $ '1', '2', '3' )
		
		// revisado RN136 - 31/10/07 - RC ==> CREIO NECESSITAR ALTERACAO, VERIFICAR REGRA COM TULIO
		// Lancamentos de Taxa Adm sobre compra de procedimento - trata somente se a conta for fixa
	Case AllTrim(&(cAlias+'->'+cAlias+'_CODTIP')) $ '117,122,125'
		// 117- Taxa Administrativa
		// 122- Taxa administrativa compras pagamento no ato
		// 125- Taxa administrativa compras pagamento a faturar
		// Se for conta fixa para taxa administrativa, pega a conta via parametro
		If !Empty(cCtpl13)
			cRet	:= cCtpl13
			If lLogUsu
				// Chama funcao para gravacao de log bom
				U_GrvLogBom(cProc+'|Comb:'+cBusca+'|Conta:'+cRet,'FAT')
			EndIf
			BFQ->(RestArea(aAreaBFQ))
			BSP->(RestArea(aAreaBSP))
			BA3->(RestArea(aAreaBA3))
			BA1->(RestArea(aAreaBA1))
			RestArea(aArea)
			Return(cRet)
		Else
			cBusca	+= ' '
		EndIf
		
		// Outros Debitos / Creditos diversos -> busca conta na tabela BSQ ou BSP
	Case Subs(&(cAlias+'->'+cAlias+'_CODTIP'),1,1) = '9' .or. Alltrim(&(cAlias+'->'+cAlias+'_CODTIP')) $ '111,113,128,129,130,131,132,135,136,180'
		// 111- Juros do Mes Anterior
		// 113- Debitos servicos medicos		// 128- Debito servicos acessorios
		// 129- Credito servicos medicos		// 130- Credito servicos acessorios
		// 131- Credito odontologico			// 132- Debito odontologico
		// 135- Debito outros servicos			// 136- Credito outros servicos
		// 180- Debito servicos medicos			// Codigo do Tipo iniciando com '9' � lan�to usu�rio
		If !Empty(BSQ->BSQ_YCONTA)
			cRet	:= BSQ->BSQ_YCONTA
		Else
			If AllTrim(BSP->BSP_CODSER) <> AllTrim(&(cAlias+'->'+cAlias+'_CODEVE'))
				BSP->(dbSetOrder(1))
				BSP->(dbSeek(xFilial('BSP')+AllTrim(&(cAlias+'->'+cAlias+'_CODEVE')),.F.))
			EndIf
			If !Empty(BSP->BSP_CONTA)
				cRet	:= BSP->BSP_CONTA
				
			ElseIf !Empty(BFQ->BFQ_CONTA)
				cRet	:= BFQ->BFQ_CONTA
				
			Else
				cRet	:= 'C->Eve:'+AllTrim(&(cAlias+'->'+cAlias+'_CODEVE'))
				cProc	+= '|Cadastrar Cta Tp.Deb/Cred'
				// Grava log de registro com problema
				If lLogUsu
					U_Gravalog(cProc,'FAT')
				EndIf
				BFQ->(RestArea(aAreaBFQ))
				BSP->(RestArea(aAreaBSP))
				BA3->(RestArea(aAreaBA3))
				BA1->(RestArea(aAreaBA1))
				RestArea(aArea)
				Return(cRet)
			EndIf
		EndIf
		If lLogUsu
			// Chama funcao para gravacao de log bom
			U_GrvLogBom(cProc+'|Comb:'+cBusca+'|Conta:'+cRet,'FAT')
		EndIf
		BFQ->(RestArea(aAreaBFQ))
		BSP->(RestArea(aAreaBSP))
		BA3->(RestArea(aAreaBA3))
		BA1->(RestArea(aAreaBA1))
		RestArea(aArea)
		Return(cRet)
		
		
		// revisado RN136 - 31/10/07 - RC ==> NECESSITA ALTERACAO, AGUARDANDO DEFINI��O TULIO
		// Reembolso de livre escolha -- arquivos BKD / BKE
	Case AllTrim(&(cAlias+'->'+cAlias+'_CODTIP')) $ '108'
		// 108- Reembolso de livre escolha
		cBusca += ' '
		
		// revisado RN136 - 31/10/07 - RC ==> NECESSITA ALTERACAO, AGUARDANDO REGRA CLIENTES
		// Via de boleto -- arquivo BEE
	Case AllTrim(&(cAlias+'->'+cAlias+'_CODTIP')) $ '109'
		// 109- Via de boleto
		cBusca += ' '
		
	Otherwise
		cBusca	+= ' '
		
EndCase

// Fixo espa�o duplo para o Tipo de Faturamento, que s� � utilizado nos lan�amentos
// do tipo 4-CO em PP e tipo 5-Co-Participa��o, QUE S�O CONTABILIZADOS NO PROGRAMA CTBPLS11.
// RC - 31/10/07.
cBusca	+= Space(2)


//���������������������������������������������������������������������Ŀ
//�TIPO DE ATO                                                          �
//�0 = Ato Cooperativo Auxiliar                                         �
//�1 = Ato Cooperativo Principal                                        �
//�2 = Ato Nao Cooperativo                                              �
//�����������������������������������������������������������������������
If Empty(cTipAto)
	cBusca	+= &(cAlias+'->'+cAlias+'_ATOCOO')
Else
	cBusca	+= cTipAto
EndIf


//������������������������������������������������������Ŀ
//�PLANO REGULAMENTADO                                   �
//�Analisa se o plano do usuario e regulamentado. Opcoes:�
//�0 - Nao                                               �
//�1 - Sim                                               �
//��������������������������������������������������������
cBusca	+= IIf( AllTrim(cBi3ApoSrg) == '1', '1', '0' )

//�������������������������������������������������������������Ŀ
//�TIPO DE PLANO / CONTRATO                                     �
//�Analisa o tipo de plano / contrato do usuario. As opcoes sao:�
//�1 - Individual / Familiar                                    �
//�2 - Coletivo                                                 �
//���������������������������������������������������������������
If cBi3Tipo == "3" //Ambos
	If cTipoBG9 == "1" //Pessoa Fisica
		cBusca	+= "1"
	Else
		cBusca	+= "2"
	Endif
Else
	cBusca	+= IIf( AllTrim(cBi3TipCon) $ cCtpl05, '1', '2' )
Endif

//��������������������������������������������������������Ŀ
//�PATROCINIO                                              �
//�Analisa se o plano tem patrocinio ou nao. As opcoes sao:�
//�0 - Sem patrocinio                                      �
//�1 - Com patrocinio                                      �
//����������������������������������������������������������
cPatroc	:= ''
//Plano Ambos / Pessoa Fisica ou Individual/Familiar, nunca tera patrocinio
If ( cBi3Tipo == "3" .and. cTipoBG9 == "1" ) .or. AllTrim(cBi3Tipo) == '1'
	cBusca	+= "0"
Else
	// Plano coletivo, forca que o campo esteja preenchido ou retorna sem patrocinio
	cPatroc	:= Posicione("BQC",1,xFilial("BQC")+BA1->(BA1_CODINT+BA1_CODEMP+BA1_CONEMP+BA1_VERCON+BA1_SUBCON+BA1_VERSUB),"BQC_PATROC")
	cBusca	+= IIf( cPatroc == '1', '1', '0' )
EndIf

//�����������������������������������������������������������Ŀ
//�SEGMENTACAO                                                �
//�Segue a segmentacao conforme o cadastro no proprioproduto.�
//�������������������������������������������������������������
cBusca	+= cBi3CodSeg


//�������������������������������������������������������������������������Ŀ
//�Analisa condi��o do faturamento, se foi realizado no m�s da compet�ncia, �
//�se foi adiantado ou postergado, para definir qual conta pegar, conforme a�
//�condi��o da vari�vel lMesFat.                                            �
//���������������������������������������������������������������������������

lMesFat	:= .T.
// Verifica se o faturamento � de compet�ncia posterior a emiss�o do t�tulo, ou seja, faturamento antecipado.
// A d�bito � utilizado somente em guias, n�o aplic�vel neste programa.
// Inclu�do tratamento opcional, para contemplar lan�amento P03 criado em 19/12/07. RC.
If lConAnt			//	cNatLct == 'C'
	cDtEmis	:= StrZero(Year(SE1->E1_EMISSAO),4)+StrZero(Month(SE1->E1_EMISSAO),2)
	cDtComp	:= SE1->E1_ANOBASE+SE1->E1_MESBASE
	If cDtComp > cDtEmis
		lMesFat	:= .F.
	EndIf
EndIf

DBSelectArea('SZT')
SZT->(DBSetOrder(2))
lAchou	:= .F.
lLocSZT := .F.

//Tratamento ao Grupo de Operadoras.
//Valido somente para Tipo de Beneficiario igual a
//Exposto Nao Beneficiario (2) ou Prestacao de Servicos (4).
//RC - 06/08/07
If cBi3TpBen $ '2/4'
	cGruOpe	:= Posicione("BA0",1,xFilial("BA0")+BA1->BA1_OPEORI,"BA0_GRUOPE")
	//Procura combinacao com Grupo de Operadora
	If !(lLocSZT := SZT->(DBSeek(xFilial("SZT")+cBusca+cCodPla+cGruOpe, .F.)))
		lLocSZT := SZT->(DBSeek(xFilial("SZT")+cBusca+Space(4)+cGruOpe, .F.))
	EndIf
	
	If lLocSZT
		Do Case
			Case cNatLct == 'D' .And. cTipLct $ 'I/P'
				cRet := If(Empty(SZT->ZT_CTADEB1), 'C->'+cBusca, SZT->ZT_CTADEB1)
			Case cNatLct == 'D' .And. cTipLct == 'C'
				cRet := If(Empty(SZT->ZT_CANDEB1), 'C->'+cBusca, SZT->ZT_CANDEB1)
			Case cNatLct == 'C' .And. cTipLct $ 'I/P' .And. lMesFat
				cRet := If(Empty(SZT->ZT_CTACRD1), 'C->'+cBusca, SZT->ZT_CTACRD1)
			Case cNatLct == 'C' .And. cTipLct $ 'I/P' .And. !lMesFat
				cRet := If(Empty(SZT->ZT_CTACRD2), 'C->'+cBusca, SZT->ZT_CTACRD2)
			Case cNatLct == 'C' .And. cTipLct == 'C' .And. lMesFat
				cRet := If(Empty(SZT->ZT_CANCRD1), 'C->'+cBusca, SZT->ZT_CANCRD1)
			Case cNatLct == 'C' .And. cTipLct == 'C' .And. !lMesFat
				cRet := If(Empty(SZT->ZT_CANCRD2), 'C->'+cBusca, SZT->ZT_CANCRD2)
			OtherWise
				cRet := "L->"+cBusca+"|Param.Invalida:|Nat.Lancto:|'"+cNatLct+"'|Tipo Lancto:|'"+cTipLct+"'|"
		EndCase
	EndIf
	lAchou	:= .T.
EndIf

//Se n�o achou, procura combinacao sem Grupo de Operadora
If !lAchou
	lLocSZT := .F.
	cGruOpe	:= Posicione("BA0",1,xFilial("BA0")+BA1->BA1_OPEORI,"BA0_GRUOPE")
	//Procura combinacao com Grupo de Operadora
	If !(lLocSZT := SZT->(DBSeek(xFilial("SZT")+cBusca+cCodPla, .F.)))
		lLocSZT := SZT->(DBSeek(xFilial("SZT")+cBusca+Space(4), .F.))
	EndIf
	
	If lLocSZT
		Do Case
			Case cNatLct == "D" .And. cTipLct $ "I/P"
				cRet := IIf(Empty(SZT->ZT_CTADEB1), "C->"+cBusca, SZT->ZT_CTADEB1 )
			Case cNatLct == "D" .And. cTipLct == "C"
				cRet := IIf(Empty(SZT->ZT_CANDEB1), "C->"+cBusca, SZT->ZT_CANDEB1 )
			Case cNatLct == "C" .And. cTipLct $ "I/P" .And. lMesFat
				cRet := IIf(Empty(SZT->ZT_CTACRD1), "C->"+cBusca, SZT->ZT_CTACRD1 )
			Case cNatLct == "C" .And. cTipLct $ "I/P" .And. !lMesFat
				cRet := IIf(Empty(SZT->ZT_CTACRD2), "C->"+cBusca, SZT->ZT_CTACRD2 )
			Case cNatLct == "C" .And. cTipLct == "C" .And. lMesFat
				cRet := IIf(Empty(SZT->ZT_CANCRD1), "C->"+cBusca, SZT->ZT_CANCRD1 )
			Case cNatLct == "C" .And. cTipLct == "C" .And. !lMesFat
				cRet := IIf(Empty(SZT->ZT_CANCRD2), "C->"+cBusca, SZT->ZT_CANCRD2 )
			OtherWise
				cRet := "L->"+cBusca+"|Param.Invalida:|Nat.Lancto:|'"+cNatLct+"'|Tipo Lancto:|'"+cTipLct+"'|"
		EndCase
	Else
		cRet := "N->"+cBusca
	EndIf
Else
	If " " $ cBusca
		cRet	:= "L->"+cBusca
	Else
		cRet	:= "N->"+cBusca
	EndIf
EndIf

// Aciona gravacao de Log
If Subs(cRet,1,1) $ "CLN"
	If Subs(cRet,1,1) $ 'C'
		cProc	+= '|Chave:'+cBusca+'|Sem Cta Combinacao'
	ElseIf Subs(cRet,1,1) $ 'N'
		cProc	+= '|Chave:'+cBusca+'|Falta Combinacao  '
	Else
		cProc	+= '|Chave:'+cBusca+'|Impossivel Montar Combinacao'
	EndIf
	// Grava log de registro com problema
	U_Gravalog(cProc, "FAT")
	
Else
	
	// Atualiza flag para contabilizar no faturamento antecipado - fica com status de A - "Aguardando"
	// at� que seja contabilizado no programa PLSCTB02. Somente para mensalidades. 18/12/07 - RC.
	// Se for lancamento de cancelamento, desmarca para registrar que j� cancelou. 21/02/08 - RC.
	If !lMesFat .and. lMensal .and. lAtuFlag //.and. cTipLct $ 'I/P'
		RecLock(cAlias,.F.)
		&(cAlias+'->'+cAlias+'_LAFAT') := IIf( cTipLct $ 'I/P', 'A', IIf(&(cAlias+'->'+cAlias+'_LAFAT')=='A','C',&(cAlias+'->'+cAlias+'_LAFAT')) )
		//		&(cAlias+'->'+cAlias+'_LAFAT') := 'A'
		&(cAlias+'->(msUnlock())')
	EndIf
	
	// Chama funcao para gravacao de log bom
	If lLogUsu
		U_GrvLogBom(cProc+'|Comb:'+cBusca+'|Conta:'+cRet,'FAT')
	EndIf
EndIf

BSP->(RestArea(aAreaBSP))
BA3->(RestArea(aAreaBA3))
BA1->(RestArea(aAreaBA1))
RestArea(aArea)

Return(cRet)
