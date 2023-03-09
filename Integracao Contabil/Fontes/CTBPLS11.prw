#Include 'protheus.ch'
#include 'topconn.ch'

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �CTBPLS11  �Autor  �Roger Cangianeli    � Data �  21/03/06   ���
�������������������������������������������������������������������������͹��
���Desc.     � Busca dinamica da conta, conforme configuracao flexivel    ���
���          � no arquivo especifico SZT. (Faturamento)          		  ���
�������������������������������������������������������������������������͹��
���Uso       � Unimed e cooperativas                                      ���
�������������������������������������������������������������������������ͼ��
���31/10/07  � A partir desta data o programa passa a considerar somente  ���
���          � co-participa��o e compra de procedimento. Os demais movi-  ���
���          � mentos referentes a mensalidade (PP ou CO) e  lancamentos  ���
���          � de custo operacional (em planos Demais Modalidades) ser�o  ���
���          � executados no programa CTBPLS05. RC.                       ���
���26/03/08  � A partir desta data o programa passa a considerar o Custo  ���
���          � operacional (em planos Demais Modalidades). RC.			  ���
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

User Function CTBPLS11(lLogUsu, cNatLct, cTipLct, cTipCo, cTipAto )		//, nPosLct )

Local nTmp		:= 0
//��������������������������������������Ŀ
//�Inicializa as variaveis neste ambiente�
//����������������������������������������
Local cRet, cBusca, aArea, aAreaBA1, aAreaBA3, aAreaBSP, cDtEmis, cDtComp
Local cBi3ModPag,cBi3ApoSrg,cBi3TipCon,cBi3Tipo,cBi3CodSeg, cTipoBG9, cBi3TpBen, cProc		//cBi3XModPg,
Local cGruOpe := ''

//������������������������������������������������������������������Ŀ
//�Inicializa Parametros:                                            �
//�MV_YCTPL05 --> Codigo dos Tipos de Planos Individuais / Familiares�
//�MV_YCTPL06 --> Codigo dos Procedimentos de Consultas     		 �	--> Antigo grupo de materiais
//��������������������������������������������������������������������
Private cCtpl05	:= GetNewPar('MV_YCTPL05','1')
Private cCtpl06 := GetNewPar('MV_YCTPL06','00010014,00010073,10101012,10101039')
Private cCtpl11 := GetNewPar('MV_YCTPL11','000004')
Private cCodPla := Space(4)

Default lLogUsu	:= .T.		// Habilita gravacao do Log Bom para nao replicar no retorno 4 do CTBPLS06
Default cNatLct	:= 'D'		// Natureza do lan�amento: D-D�bito / C-Cr�dito
Default cTipLct	:= 'I'		// Tipo do Lan�amento: I-Inclus�o / P-Provis�o / C-Cancelamento

Default cTipCo	:= '0'		// Tipo de Participa��o Financeira: 0-Custo Operacional em Demais Modalidades
//									1-Custo Operacional por compras
//									2-Co-Participa��o
//									3-Taxa Admin. s/Custo Operacional por compras
//									4-Taxa Admin. s/Co-Participa��o
//									5-Taxa Admin. s/Custo Operacional Demais Modal.

Default cTipAto	:= ''		// Tipo de Ato: 0-Ato Coop Aux / 1-Ato Coop Princ / 2-Ato Nao Coop
// Identifica se deve tratar tipo de ato especifico ou pelo processo normal (n�o passa par�metro).
// Utilizado para divis�o de atos no BM1 - BM1_YVLACP/BM1_YVLACA/BM1_YVLANC

aArea	:= GetArea()
aAreaBA1:= BA1->(GetArea())
aAreaBA3:= BA3->(GetArea())
aAreaBFQ:= BFQ->(GetArea())
aAreaBSP:= BSP->(GetArea())

// PREPARAR TRATAMENTO PARA O BMO
If cTipLct == 'I'
	cAlias	:= 'BD6'
Else
	cAlias	:= 'BMO'
EndIf


//��������������������������������������������������������������������������Ŀ
//�Inserida validacao do posicionamento do usuario e tentativa de localizacao�
//�pelo codigo antigo deste.                                                 �
//�Roger Cangianeli - 24/05/06                                               �
//����������������������������������������������������������������������������

// Verifica se o programa nao achou o usuario ou se parou em usuario diferente, para procurar pelo codigo antigo.
If BA1->(Eof()) .or. BA3->(Eof()) //.or. Subs(BM1->BM1_NOMUSR,1,40) <> Subs(BA1->BA1_NOMUSR,1,40)
	lAchouBA1 := .F.
	dbSelectArea('BA1')
	BA1->(dbSetOrder(2))
	If BA1->(dbSeek(xFilial('BA1')+AllTrim(&(cAlias+'->('+cAlias+'_CODINT+'+cAlias+'_CODEMP+'+cAlias+'_MATRIC+'+cAlias+'_TIPREG+'+cAlias+'_DIGITO)') ),.F.))
		lAchouBA1:= .T.
	Else
		If BA1->(dbSeek(xFilial('BA1')+&(cAlias+'->'+cAlias+'_MATUSU'), .F.))
			lAchouBA1:= .T.
		Else
			dbSelectArea('BA1')
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
		cProc	:= 'Lt.Cobr:'+AllTrim(Subs(&(cAlias+'->'+cAlias+'_NUMFAT'),5,8))+'|Tit:'+AllTrim(&(cAlias+'->'+cAlias+'_NUMSE1'))
		cProc	+= '|Matr:'+AllTrim(&(cAlias+'->('+cAlias+'_OPEUSR+'+cAlias+'_CODEMP+'+cAlias+'_MATRIC+'+cAlias+'_TIPREG)') )+IIf(cAlias=='BD6','|Nome:'+AllTrim(Subs(&(cAlias+'->'+cAlias+'_NOMUSR'),1,40)),'')
		cProc	+= '|Prod: N/Enc. |Grp.Emp:'+AllTrim(&(cAlias+'->'+cAlias+'_CODEMP'))
		cProc	+= '|Contr:'+AllTrim(BA1->BA1_CONEMP)+'/'+AllTrim(BA1->BA1_VERCON)+'|Sub:'+AllTrim(BA1->BA1_SUBCON)+'/'+AllTrim(BA1->BA1_VERSUB)
		cProc	+= '|Vl.Tit.:|'+StrZero(SE1->E1_VALOR,10,2)
		cProc	+= '|Usuario nao encontrado|CTBPLS11'
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
cProc	:= 'Lt.Cobr:'+AllTrim(Subs(&(cAlias+'->'+cAlias+'_NUMFAT'),5,8))+'|Tit:'+AllTrim(&(cAlias+'->'+cAlias+'_NUMSE1'))
cProc	+= '|Matr:'+AllTrim(&(cAlias+'->('+cAlias+'_OPEUSR+'+cAlias+'_CODEMP+'+cAlias+'_MATRIC+'+cAlias+'_TIPREG)') )+IIf(cAlias=='BD6','|Nome:'+AllTrim(Subs(&(cAlias+'->'+cAlias+'_NOMUSR'),1,40)),'')
cProc	+= '|Prod:'+Subs(cPlano,1,4)+'/'+Subs(cPlano,5,3)+'|Grp.Emp:'+AllTrim(&(cAlias+'->'+cAlias+'_CODEMP'))
cProc	+= '|Contr:'+AllTrim(BA1->BA1_CONEMP)+'/'+AllTrim(BA1->BA1_VERCON)+'|Sub:'+AllTrim(BA1->BA1_SUBCON)+'/'+AllTrim(BA1->BA1_VERSUB)
cProc	+= '|Vl.Evto:|'+StrZero(IIf(cAlias=='BD6',IIf(cTipCo$'0/1/2', aRetVlr[nPosLct], aRetTxa[nPosLct]),BMK->BMK_VALOR),10,2)
cProc	+= '|Vl.Tit.:|'+StrZero(SE1->E1_VALOR,10,2)
cProc	+= IIf(cTipLct=='D','|Deb/Cred:D',IIf(cTipLct=='C','|Deb/Cred:C',''))

//������������������������������������������������������������������Ŀ
//�TIPO DO CONTRATO PARA FATURAMENTO                                 �
//�Este campo analisa condicoes para classificar o tipo de contrato, �
//�conforme segue:                                                   �
//�1 - Demais Modalidades                                            �
//�4 - CO em PP        } somente estas situa��es s�o tratadas        �
//�5 - Participacao    } neste programa. RC.                         �
//��������������������������������������������������������������������
Do Case
	Case cTipCo $ '0/5'
		// Lancamentos exclusivos de Custo Operacional em contrato Demais Modalidades
		cBusca += '1'
		
	Case cTipCo $ '1/3'
		// Lancamentos exclusivos de Custo Operacional -> 1->Custo Operacional / 3->Taxa Adm.s/Custo Oper.
		cBusca += '4'
		
	Case cTipCo $ '2/4'
		// Lancamentos exclusivos de Co-Participa��o -> 2->Co-Participa��o / 4->Taxa Adm.s/Co-Participa��o
		cBusca += '5'
		
	Otherwise
		cBusca	+= 'X'
		
EndCase


//��������������������������������������������������������������������Ŀ
//�TIPO DO SERVICO UNIMED                                              �
//�Este campo analisa condicoes para classificar o tipo de servico,    �
//�conforme segue:                                                     �
//�1 - AMBULATORIAL													   �
//�No caso de guias ambulatoriais, deve-se localizar o procedimento ou �
//�o seu grupo no cadastro de Natureza de Saude.					   �
//�2 - INTERNACAO													   �
//�No caso de guias de internacao, deve-se obedecer as regras abaixo:  �
//�- Honorario Medico: Todo procedimento pago a Rda PF.				   �
//�- Exames: Procedimentos classificados cfme natureza de saude		   �
//�- Terapias: Procedimentos classificados cfme natureza de saude      �
//�- Material: Procedimentos da classe do parametro MV_YCTPL06		   �
//�- Medicamento: Procedimentos da classe do parametro MV_YCTPL09	   �
//�- Outros: Caso nao se enquadre em nenhuma das combinacoes anteriores�
//�                                                                    �
//�Obs.: Caso o material ou medicamento seja pago para um rda que foi  �
//�      pago um procedimento, o material ou medicamento deve ser con- �
//�      tabilizado na mesma conta do procedimento. Regra valida para  �
//�      guias Ambulatoriais e guias de Internacao.                    �
//����������������������������������������������������������������������

cCodPad	:= &(cAlias+'->'+cAlias+'_CODPAD')		//BD6->BD6_CODPAD
cCodPro	:= &(cAlias+'->'+cAlias+'_CODPRO')		//BD6->BD6_CODPRO

If Select('TRBBR8') > 0
	TRBBR8->(dbCloseArea())
EndIf
cSqlBR8	:= "SELECT BR8_CLASSE, BR8_TPPROC FROM "+RetSqlName('BR8')+" WHERE BR8_FILIAL = '"
cSqlBR8	+= xFilial('BR8')+"' AND BR8_CODPAD = '"+cCodPad+"' AND "
csqlBR8	+= "BR8_CODPSA = '"+cCodPro+"' AND D_E_L_E_T_ = ' ' "
TcQuery cSqlBR8 New Alias 'TRBBR8'

cClasse	:= TRBBR8->BR8_CLASSE
cTpProc	:= TRBBR8->BR8_TPPROC

If cTipCO $ '0/5'
	// Fixo espa�o duplo para o Tipo de Faturamento, que s� � utilizado nos lan�amentos
	// do tipo 4-CO em PP e tipo 5-Co-Participa��o.
	cBusca	+= Space(2)
	
	// ElseIf BD6->BD6_ORIMOV == "1" //Guias Ambulatoriais
ElseIf &(cAlias+'->'+cAlias+'_ORIMOV') == "1" .and. cAlias == 'BD6'			//Guias Ambulatoriais
	
	/*			nao tem sentido, nao est� no BD7
	// Se for Mat/Med/Taxas
	If cTpProc $ '1/2/3/4/5/7/8'
	aCodPro		:= U_VldMatMed(cCtpl06)
	cCodPad		:= aCodPro[1]
	cCodPro		:= aCodPro[2]
	lConsulta	:= aCodPro[3]
	cClasse		:= aCodPro[4]
	cTpProc		:= aCodPro[5]
	EndIf
	*/
	// Se for Mat/Med/Txas e Consulta
	If cTpProc $ '1/2/3/4/5/7/8' .and. cCodPro $ cCtpl06
		cBusca += "13" //Demais despesas
	Else
		BFA->(DbSetOrder(2))
		BF0->(DbSetOrder(1))
		If BFA->(MsSeek(xFilial("BFA")+cCodPro))
			If BF0->(MsSeek(xFilial("BF0")+BFA->(BFA_GRUGEN+BFA_CODIGO)))
				cBusca += BF0->BF0_YTPUNM
			Else
				cBusca += Space(2)
			Endif
		Else
			lAchou  := .F.
			aNivPro := PLSESPNIV(cCodPad)
			For nTmp := 1 to aNivPro[1]
				cTmp := substr(cCodPro,aNivPro[2][nTmp][1],aNivPro[2][nTmp][2])
				cTmp += Replicate("0",(7 - aNivPro[2][nTmp][2]))
				If BFA->(MsSeek(xFilial("BFA")+cTmp))
					If BF0->(MsSeek(xFilial("BF0")+BFA->(BFA_GRUGEN+BFA_CODIGO)))
						cBusca += BF0->BF0_YTPUNM
						lAchou := .T.
						Exit
					Endif
				Endif
			Next
			If ! lAchou
				cBusca += "12" //Outros Atendimentos Ambulatoriais
			Endif
		Endif
	Endif
	
Else //Guias de Internacao
	
	lAchou  := .F.
	If cClasse $ cCtpl11			// Classe de Procedimentos para HM
		cBusca += "06" //Honorario Medico
		lAchou  := .T.
	Endif
	
	If ! lAchou
		BFA->(DbSetOrder(2))
		BF0->(DbSetOrder(1))
		If BFA->(MsSeek(xFilial("BFA")+cCodPro))
			If BF0->(MsSeek(xFilial("BF0")+BFA->(BFA_GRUGEN+BFA_CODIGO)))
				If substr(BF0->BF0_CODIGO,1,3) == "1.2"
					cBusca += "07" //Exames
					lAchou := .T.
				ElseIf substr(BF0->BF0_CODIGO,1,3) == "1.3"
					cBusca += "08" //Terapias
					lAchou := .T.
					//Inserida em 19/02/08 para contemplar personaliza��o
				ElseIf !Empty(BF0->BF0_YTPUNM)
					cBusca += BF0->BF0_YTPUNM
					lAchou := .T.
				Endif
			Endif
		Endif
		
		If ! lAchou
			aNivPro := PLSESPNIV(cCodPad)
			For nTmp := 1 to aNivPro[1]
				cTmp := substr(cCodPro,aNivPro[2][nTmp][1],aNivPro[2][nTmp][2])
				cTmp += Replicate("0",(7 - aNivPro[2][nTmp][2]))
				If BFA->(MsSeek(xFilial("BFA")+cTmp))
					If BF0->(MsSeek(xFilial("BF0")+BFA->(BFA_GRUGEN+BFA_CODIGO)))
						If substr(BF0->BF0_CODIGO,1,3) == "1.2"
							cBusca += "07" //Exames
							lAchou := .T.
							Exit
						ElseIf substr(BF0->BF0_CODIGO,1,3) == "1.3"
							cBusca += "08" //Terapias
							lAchou := .T.
							Exit
							//Inserida em 19/02/08 para contemplar personaliza��o
						ElseIf !Empty(BF0->BF0_YTPUNM)
							cBusca += BF0->BF0_YTPUNM
							lAchou := .T.
							Exit
						Endif
					Endif
				Endif
			Next
		Endif
		
	Endif
	
	If ! lAchou
		Do Case
			Case cTpProc == '1/5/7'
				cBusca += "09" //Materiais Medicos
			Case cTpProc == '2'
				cBusca += "10" //Medicamentos
			Otherwise
				cBusca += "11" //Outras Despesas
		EndCase
	Endif
	
Endif

//���������������������������������������������������������������������Ŀ
//�TIPO DE ATO                                                          �
//�0 = Ato Cooperativo Auxiliar                                         �
//�1 = Ato Cooperativo Principal                                        �
//�2 = Ato Nao Cooperativo                                              �
//�����������������������������������������������������������������������
If Empty(cTipAto)
	cBusca	+= BFQ->BFQ_ATOCOO
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
//�Segue a segmentacao conforme o cadastro no proprio produto.�
//�������������������������������������������������������������
cBusca	+= cBi3CodSeg

//�������������������������������������������������������������������������Ŀ
//�Analisa condi��o do faturamento, se foi realizado no m�s da compet�ncia, �
//�se foi adiantado ou postergado, para definir qual conta pegar, conforme a�
//�condi��o da vari�vel lMesFat.                                            �
//���������������������������������������������������������������������������
lMesFat	:= .T.

// Em lan�amento a d�bito, verifica se a guia � de compet�ncia anterior a emiss�o do t�tulo
// ou seja, faturamento postergado.
// A cr�dito, seria utilizado para faturamento antecipado de mensalidades, n�o aplic�vel neste programa.
If cNatLct == 'D'
	// PARAMETROS: DATA / OPERADORA / EXIBE HELP / TABELA / PROCEDIMENTO
	aRetAux := PLSXVLDCAL(SE1->E1_EMISSAO,PLSINTPAD(),.F.,&(cAlias+'->'+cAlias+'_CODPAD'),&(cAlias+'->'+cAlias+'_CODPRO'))
	// Retorno
	// cAno := aRetAux[4]
	// cMes := aRetAux[5]
	
	// Verifica se foi poss�vel obter a compet�ncia com base na data enviada, sen�o mant�m lMesFat = TRUE
	If Len(aRetAux) >= 5
		cDtEmis	:= aRetAux[4]+aRetAux[5]
		cDtComp	:= &(cAlias+'->('+cAlias+'_ANOPAG+'+cAlias+'_MESPAG)')				// BD6->BD6_ANOPAG+BD6->BD6_MESPAG
		If cDtComp < cDtEmis
			lMesFat	:= .F.
		EndIf
	Endif
EndIf

    DBSelectArea("SZT")
    SZT->(DBSetOrder(2))
    lAchou	:= .F.
    lLocSZT := .F.

    //Tratamento ao Grupo de Operadoras.
    //Valido somente para Tipo de Beneficiario igual a
    //Exposto Nao Beneficiario (2) ou Prestacao de Servicos (4).
    //RC - 06/08/07
    If cBi3TpBen $ '2/4'
        cGruOpe	:= Posicione("BA0", 1, xFilial("BA0")+BA1->BA1_OPEORI, "BA0_GRUOPE")
        //Procura combinacao com Grupo de Operadora
        If !(lLocSZT := SZT->(DBSeek(xFilial("SZT")+cBusca+cCodPla+cGruOpe, .F.)))
            lLocSZT := SZT->(DBSeek(xFilial("SZT")+cBusca+Space(4)+cGruOpe, .F.))
        EndIf
        
        If lLocSZT
            Do Case
                Case cNatLct == "D" .And. cTipLct $ "I/P" .And. lMesFat
                    cRet := If(Empty(SZT->ZT_CTADEB1), "C->"+cBusca, SZT->ZT_CTADEB1)
                Case cNatLct == "D" .And. cTipLct $ "I/P" .And. !lMesFat
                    cRet := If(Empty(SZT->ZT_CTADEB2), "C->"+cBusca, SZT->ZT_CTADEB2)
                Case cNatLct == "C" .And. cTipLct $ "I/P"
                    cRet := If(Empty(SZT->ZT_CTACRD1), "C->"+cBusca, SZT->ZT_CTACRD1)
                Case cNatLct == "D" .And. cTipLct == "C" .And. lMesFat
                    cRet := If(Empty(SZT->ZT_CANDEB1), "C->"+cBusca, SZT->ZT_CANDEB1)
                Case cNatLct == "D" .And. cTipLct == "C" .And. !lMesFat
                    cRet := If(Empty(SZT->ZT_CANDEB2), "C->"+cBusca, SZT->ZT_CANDEB2)
                Case cNatLct == "C" .And. cTipLct == "C"
                    cRet := If(Empty(SZT->ZT_CANCRD1), "C->"+cBusca, SZT->ZT_CANCRD1)
                OtherWise
                    cRet := "L->"+cBusca+"|Param.Invalida:|Nat.Lancto:|'"+cNatLct+"'|Tipo Lancto:|'"+cTipLct+"'|"
            EndCase
        EndIf
        lAchou	:= .T.
	EndIf

    lLocSZT := .F.
    //Se n�o achou, procura combinacao sem Grupo de Operadora
    If !lAchou
        If !(lLocSZT := SZT->(DBSeek(xFilial('SZT')+cBusca+cCodPla, .F.)))
            lLocSZT := SZT->(DBSeek(xFilial('SZT')+cBusca+Space(4), .F.))
        EndIf
	
        If lLocSZT
            Do Case
                Case cNatLct == 'D' .and. cTipLct $ 'I/P' .and. lMesFat
                    cRet := IIf(Empty(SZT->ZT_CTADEB1), 'C->'+cBusca, SZT->ZT_CTADEB1 )
                Case cNatLct == 'D' .and. cTipLct $ 'I/P' .and. !lMesFat
                    cRet := IIf(Empty(SZT->ZT_CTADEB2), 'C->'+cBusca, SZT->ZT_CTADEB2 )
                Case cNatLct == 'C' .and. cTipLct $ 'I/P'
                    cRet := IIf(Empty(SZT->ZT_CTACRD1), 'C->'+cBusca, SZT->ZT_CTACRD1 )
                Case cNatLct == 'D' .and. cTipLct == 'C' .and. lMesFat
                    cRet := IIf(Empty(SZT->ZT_CANDEB1), 'C->'+cBusca, SZT->ZT_CANDEB1 )
                Case cNatLct == 'D' .and. cTipLct == 'C' .and. !lMesFat
                    cRet := IIf(Empty(SZT->ZT_CANDEB2), 'C->'+cBusca, SZT->ZT_CANDEB2 )
                Case cNatLct == 'C' .and. cTipLct == 'C'
                    cRet := IIf(Empty(SZT->ZT_CANCRD1), 'C->'+cBusca, SZT->ZT_CANCRD1 )
                OtherWise
                    cRet := "L->"+cBusca+"|Param.Invalida:|Nat.Lancto:|'"+cNatLct+"'|Tipo Lancto:|'"+cTipLct+"'|"
            EndCase
        Else
            If 'X' $ cBusca
                cRet := 'L->'+cBusca
            Else
                cRet := 'N->'+cBusca
            EndIf
        EndIf
    EndIf

// Aciona gravacao de Log
If Subs(cRet,1,1) $ 'CLN'
	cProc	+= IIf(!Empty(cGruOpe),'|Grupo Oper:'+cGruOpe,'')
	cProc	+= IIf(lMesFat, '|Mes Faturamento', '|Mes Faturamento Postergado')
	If Subs(cRet,1,1) $ 'C'
		cProc	+= '|Chave:'+cBusca+'|Sem Conta na Combinacao     |Retorno:'+cRet
	ElseIf Subs(cRet,1,1) $ 'N'
		cProc	+= '|Chave:'+cBusca+'|Falta Cadastrar Combinacao  |Retorno:'+cRet
	Else
		cProc	+= '|Chave:'+cBusca+'|Impossivel Montar Combinacao|Retorno:'+cRet
	EndIf
	// Grava log de registro com problema
	U_Gravalog(cProc,'FAT')
	
Else
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
