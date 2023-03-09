#include 'protheus.ch'
#include 'topconn.ch'

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �CTBPLS01  �Autor  �Roger Cangianeli    � Data �  08/02/06   ���
�������������������������������������������������������������������������͹��
���Desc.     � Busca dinamica da conta, conforme configuracao flexivel    ���
���          � no arquivo especifico SZZ para contabilizar custo da guia. ���
�������������������������������������������������������������������������͹��
���Uso       � Unimed e cooperativas                                      ���
�������������������������������������������������������������������������ͼ��
���Uso       � CABERJ-RJ                                                  ���
�� 18/09/08 O arquivo SZZ foi alterado para SZQ                           ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

//�������������������������������������������������������������Ŀ
//�Este programa fara uma busca de conta conforme a string busca�
//�(cBusca) que ser� montada. Esta string ira variar conforme a �
//�combinacao de informacoes que serao avaliadas.               �
//�Os arquivos estao sempre posicionados no momento do          �
//�lancamento, portanto somente sera posicionado o arquivo de   �
//�combinacoes de contas.                                       �
//�Roger Cangianeli.                                            �
//���������������������������������������������������������������

User Function CTBPLS01(cAliasCab,cTipCta,cChaCT5,cTipDC)

//������������������������������������������������������������������Ŀ
//�Inicializa Parametros:                                            �
//�MV_YCTPL01 --> Classes de Procedimentos para Consultas            �
//�MV_YCTPL04 --> Codigo do RDA para o SUS                           �
//�MV_YCTPL05 --> Codigo dos Tipos de Planos Individuais / Familiares�
//�MV_YCTPL06 --> Codigo de Consultas							     �	--> modificado, era Grupo de Materiais
//�MV_YCTPL11 --> Classes de Procedimentos para HM                   �
//�MV_YCTPL12 --> Locais para Digita��o de Guias de Interc�mbio      �
//�MV_YCTPL14 --> Codigo do Tipo de Prestador existente p/Operadoras.�
//��������������������������������������������������������������������

//Tabela padrao BR8- CAMPO BR8_CLASSE
Local cCtpl01 := GetNewPar('MV_YCTPL01','000001')
Local cCtpl04 := GetNewPar('MV_YCTPL04','SUS')
Local cCtpl05 := GetNewPar('MV_YCTPL05','1')
Local cCtpl11 := GetNewPar('MV_YCTPL11','000004')
Local cCtpl12 := GetNewPar('MV_YCTPL12','0004/0005')
Local cCtpl14 := GetNewPar('MV_YCTPL14','OPE/UNI')
Local aNivPro := {}
Local aCodPro := {}
Local aAreaCT5:= CT5->(GetArea())

//��������������������������������������Ŀ
//�Inicializa as variaveis neste ambiente�
//����������������������������������������
Local cRet, cBusca, aArea, cTmp			//nHand, cFile,
Local cBi3ModPag,cBi3ApoSrg,cBi3TipCon,cBi3Tipo,cBi3CodSeg, cLog, cLog1, cPlano, cBi3TpBen, cTpProc
Local nTmp
Local lAchou, lConsulta
Local cCodPad := BD7->BD7_CODPAD
Local cCodPro := BD7->BD7_CODPRO

Default cTipCta := "P"

Private cCtpl06 := GetNewPar('MV_YCTPL06','00010014,00010073,10101012,10101039')
Private cClasse    := ""
Private cBauEst    := ""
Private cBauTipPre := ""
Private cBauCopCre := ""
Private cCodPla    := Space(4)

Default cAliasCab  := 'BD5'
Default cChaCT5	   := '' 
Default cTipDC	   := 'D' 

// Salva ambiente original
aArea	:= GetArea()

//�������������������������������������������������Ŀ
//�POSICIONAR PRODUTO - BUSCAR BI3           		�
//���������������������������������������������������
If Empty(BA1->BA1_CODPLA)
	cPlano	:= BA3->BA3_CODPLA+BA3->BA3_VERSAO
	cCodPla := BA3->BA3_CODPLA
Else
	cPlano	:= BA1->BA1_CODPLA+BA1->BA1_VERSAO
	cCodPla := BA1->BA1_CODPLA
EndIf

BI3->(DbSetOrder(1))
BI3->(MsSeek(xFilial("BI3")+PLSINTPAD()+cPlano))

cBi3ModPag := BI3->BI3_MODPAG
cBi3ApoSrg := BI3->BI3_APOSRG
cBi3TipCon := BI3->BI3_TIPCON
cBi3Tipo   := BI3->BI3_TIPO
cBi3CodSeg := BI3->BI3_CODSEG
cBi3TpBen  := BI3->BI3_YTPBEN

//������������������������������������������������������������������������Ŀ
//�TIPO DO BENEFICIARIO                                                    �
//�Verifica conteudo do campo BG9_XTPBEN ( Char(1) ), especifico que indica�
//�o tipo de beneficiario do contrato. As opcoes sao:                      �
//�1 - BE - Beneficiario Exposto                                           �
//�2 - ENB - Exposto Nao Beneficiario                                      �
//�3 - BNE - Beneficiario Nao Exposto                                      �
//�4 - PS - Prestacao de Servicos                                          �
//��������������������������������������������������������������������������
//cBusca	:= BG9->BG9_XTPBEN
// Solicitado altera��es em 29/03/06 para buscar o tipo de beneficiario diretamente no produto. Roger C.

cBusca	:= cBi3TpBen			//BI3->BI3_YTPBEN

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
//�- Material: Procedimentos do grupo '7'							   �
//�- Medicamento: Procedimentos do grupo '9'						   �
//�- Outros: Caso nao se enquadre em nenhuma das combinacoes anteriores�
//�                                                                    �
//�Obs.: Caso o material ou medicamento seja pago para um rda que foi  �
//�      pago um procedimento, o material ou medicamento deve ser con- �
//�      tabilizado na mesma conta do procedimento. Regra valida para  �
//�      guias Ambulatoriais e guias de Internacao.                    �
//����������������������������������������������������������������������

If Select('TRBBR8') > 0
	TRBBR8->(dbCloseArea())
EndIf
cSqlBR8	:= "SELECT BR8_CLASSE, BR8_TPPROC FROM "+RetSqlName('BR8')+" WHERE BR8_FILIAL = '"
cSqlBR8	+= xFilial('BR8')+"' AND BR8_CODPAD = '"+BD7->BD7_CODPAD+"' AND "
csqlBR8	+= "BR8_CODPSA = '"+BD7->BD7_CODPRO+"' AND D_E_L_E_T_ = ' ' "
TcQuery cSqlBR8 New Alias 'TRBBR8'

cCodPad := BD7->BD7_CODPAD
cCodPro := BD7->BD7_CODPRO
cClasse	:= TRBBR8->BR8_CLASSE	//Posicione("BR8",1,xFilial("BR8")+BD7->BD7_CODPAD+BD7->BD7_CODPRO,"BR8_CLASSE")
cTpProc	:= TRBBR8->BR8_TPPROC


Do Case
	Case cTipCta == "P"
		//custo total
		cCampoCtb := "SZQ->ZQ_CONTA"
	Case cTipCta == "G"
		//Glosa
		cCampoCtb := "SZQ->ZQ_CCGLOSA"
	Case cTipCta == "CC"
		//Copart - Conta credito
		cCampoCtb := "SZQ->ZQ_CCCOPAR"
	Case cTipCta == "CD"       
		//Copart - Conta debito
		cCampoCtb := "SZQ->ZQ_CCCOPDE"
		
EndCase
//&(cAlias+"->(DbSkip())")

If BD7->BD7_ORIMOV == "1" //Guias Ambulatoriais
	
	// Se for Mat/Med/Taxas
	If cTpProc $ '1/2/3/4/5/7/8'
		aCodPro		:= U_VldMatMed(cCtpl06)
		cCodPad		:= aCodPro[1]
		cCodPro		:= aCodPro[2]
		lConsulta	:= aCodPro[3]
		cClasse		:= aCodPro[4]
		cTpProc		:= aCodPro[5]
	EndIf
	
	// Se for Mat/Med/Txas e Consulta
	If cTpProc $ '1/2/3/4/5/7/8' .and. lConsulta
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
			Case cTpProc $ '1/5/7'
				cBusca += "09" //Materiais Medicos
			Case cTpProc $ '2'
				cBusca += "10" //Medicamentos
			Otherwise
				cBusca += "11" //Outras Despesas
		EndCase
	Endif
	
Endif


//�������������������������������������������������Ŀ
//�REDE DE ATENDIMENTO  -   BUSCAR DO BAU           �
//���������������������������������������������������
BAU->(DbSetOrder(1))
BAU->(MsSeek(xFilial("BAU")+BD7->BD7_CODRDA))

cBauEst		:= BAU->BAU_EST
cBauTipPre	:= BAU->BAU_TIPPRE
cBauCopCre	:= BAU->BAU_COPCRE

//�������������������������������������������������������������������������������������������������Ŀ
//�TIPO DE PRESTADOR                                                          						�
//�Analisa o vinculo do prestador com a cooperativa e a classe do procedimento						�
//�executado. As opcoes sao:                                                  						�
//�0 - Nulo --> Para atendimento pelo SUS ou Exterior                         						�
//�1 - Proprio/Assalariado --> Para Funcionarios em atendimento a consultas   						�
//�2 - Cooperados --> Para Cooperados em atendimento a consultas              						�
//�3 - Nao Cooperados --> Para Nao Cooperados, qualquer atendimento           						�
//�4 - Rede Propria --> Para Cooperados, qualquer atendimento exceto consultas						�
//�5 - Rede Conveniada --> Para Credenciados, todos atendimentos 								 	�
//�6 - Intec ambio --> Atendimento em Intercambio                              						�
//���������������������������������������������������������������������������������������������������
Do Case
	// SUS e Exterior
	Case AllTrim(BAU->BAU_CODIGO) $ cCtpl04 .or. cBauEst == 'EX'
		cBusca	+= '0'
		
		// Intercambio, NAO CONSIDERAR USUARIOS -> Minou, 27/03/06
	Case cBauTipPre $ cCtpl14
		cBusca	+= '6'
		
		// Funcionario e Consultas/Honorarios Medicos
	Case AllTrim(cBauCopCre) $ '3' .and. AllTrim(cClasse) $ cCtpl01+'/'+cCtpl11
		cBusca	+= '1'
		
		// Cooperados e Consultas/Honorarios Medicos
	Case AllTrim(cBauCopCre) $ '1' .and. AllTrim(cClasse) $ cCtpl01+'/'+cCtpl11
		cBusca	+= '2'
		
		// Funcionarios, Cooperados e Exames/Demais despesas
		// Permitido todas as classes a partir de 19/02/08, por serem classificados na mesma conta
	Case AllTrim(cBauCopCre) $ '1/3' //.and. AllTrim(cClasse) $ cCtpl02+'/'+cCtpl03
		cBusca	+= '4'
		
		// Credenciados e Consultas/Exames/Demais despesas
		// Permitido todas as classes a partir de 24/10/07, por serem classificados na mesma conta
	Case AllTrim(cBauCopCre) $ '2' //.and. AllTrim(cClasse) $ cCtpl01+'/'+cCtpl02+'/'+cCtpl03
		cBusca	+= '5'
		
		// Nao Cooperados - Todas as classes...
	Case AllTrim(cBauCopCre) $ '4'
		cBusca	+= '3'
		
		// Outras opcoes
	OtherWise
		cBusca	+= ' '
		
EndCase

//������������������������������������������������������������Ŀ
//�MODALIDADE DE COBRANCA                                      �
//�Verifica se a modalidade eh Pre-Pagamento, senao classifica �
//�direto em demais modalidades.                               �
//�1 - Pre-Pagamento                                           �
//�2 - Demais Modalidades                                      �
//��������������������������������������������������������������
cBusca	+= IIf( AllTrim(cBi3ModPag) $'1', '1', '2' )

//���������������������������������������������������������������������Ŀ
//�TIPO DE ATO                                                          �
//�Analisa os tipos de atos conforme o tipo de vinculo com a operadora. �
//�Em definicao com a Minou (Tubarao) em 09/02/06, fica estabelecido    �
//�os seguintes criterios para classificacao contabil dos tipos de atos:�
//�1 - Ato Cooperativo Principal --> Quando a RDA for um Cooperado      �
//�ou um Funcionario.                                                   �
//�2 - Ato Cooperativo Auxiliar --> Quando a RDA for um Credenciado.    �
//�3 - Ato Nao Cooperativo --> Quando a RDA for Nao Cooperado.          �
//�                                                                     �
//�ATENCAO: EM CASOS DE INTERCAMBIO, SERA MANTIDO O TIPO DE ATO PROVE-  �
//�NIENTE DO ARQUIVO DE INTERCAMBIO INFORMADO NA OPERADORA ORIGEM VIA   �
//�PTU A500, GRAVADO NO CAMPO BD6_CODATO.                               �
//�                                                                     �
//�   ** VALIDAR ESTA REGRA COM A OPERADORA QUE FOR IMPLANTAR **        �
//�                                                                     �
//�����������������������������������������������������������������������
Do Case
	// Intercambio digitado manualmente
	Case cBauTipPre $ cCtpl14 .and. BD6->BD6_CODLDP $ cCtpl12
		Do Case
			Case AllTrim(cBauCopCre) $ '1,3'
				cBusca	+= '1'
			Case AllTrim(cBauCopCre) $ '2'
				cBusca	+= '2'
			Case AllTrim(cBauCopCre) $ '4'
				cBusca	+= '3'
			OtherWise
				cBusca	+= ' '
		EndCase
		// Intercambio
	Case cBauTipPre $ cCtpl14
		//����������������������������������������������������������Ŀ
		//�Inclus�o de ponto de entrada para defini��o espec�fica de �
		//�tratamento a tipo de ato. Envia vari�vel cBusca e espera  �
		//�retorno desta, classificando o tipo de ato, que pode ser: �
		//�1 - Ato Cooperativo Principal                             �
		//�2 - Ato Cooperativo Auxiliar                              �
		//�3 - Ato N�o Cooperativo		                                 �
		//������������������������������������������������������������
		If  Empty(BD6->BD6_CODATO) .and. ExistBlock("PLSCTP20")
			cBusca := ExecBlock("PLSCTP20",.F.,.F., {cBusca} )
		Else
			cBusca += IIf(BD6->BD6_CODATO=='0','2',IIf(BD6->BD6_CODATO=='2','3', BD6->BD6_CODATO ) )
		Endif
		// Cooperados e funcionarios
	Case AllTrim(cBauCopCre) $ '1,3'
		cBusca	+= '1'
		// Credenciados
	Case AllTrim(cBauCopCre) $ '2'
		cBusca	+= '2'
		// Nao Cooperados
	Case AllTrim(cBauCopCre) $ '4'
		cBusca	+= '3'
		// Opcoes nao previstas
	OtherWise
		cBusca	+= ' '
EndCase

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
	If BG9->BG9_TIPO == "1" //Pessoa Fisica
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
If cBi3Tipo == "3" //Ambos
	If BG9->BG9_TIPO == "1" //Pessoa Fisica
		cBusca	+= "0"
	Else
		cBusca	+= IIf( AllTrim(BQC->BQC_PATROC) == '1', '1', '0' )
	Endif
Else
	If AllTrim(cBi3Tipo) == '1'			// Plano Individual/Familiar, nunca tera patrocinio
		cBusca	+= '0'
	Else
		// Plano coletivo, forca que o campo esteja preenchido ou retorna sem patrocinio
		cBusca	+= IIf( AllTrim(BQC->BQC_PATROC) == '1', '1', '0' )
	EndIf
Endif

//�����������������������������������������������������������Ŀ
//�SEGMENTACAO                                                �
//�Segue a segmentacao conforme o cadastro no proprio produto.�
//�������������������������������������������������������������
//cBusca	+= cBi3CodSeg

//Tratamento ao Grupo de Operadoras.
//Valido somente para Tipo de Beneficiario igual a
//Exposto Nao Beneficiario (2) ou Prestacao de Servicos (4).
//RC - 06/08/07

DBSelectArea('SZQ')
lAchou	:= .F.

SZQ->(DBSetOrder(2)) //ZQ_FILIAL+ZQ_TPBENEF+ZQ_TPUNIM+ZQ_TPPREST+ZQ_MODCOB+ZQ_TPATO+ZQ_REGPLN+ZQ_TPPLN+ZQ_PATROC+ZQ_CODPROD+ZQ_SEGMEN
If cBi3TpBen $ '2/4'
	cGruOpe	:= Posicione("BA0", 1, xFilial("BA0")+BA1->BA1_OPEORI, "BA0_GRUOPE")
	//Procura combinacao com Grupo de Operadora
	If SZQ->(DBSeek(xFilial('SZQ')+cBusca+cCodPla+cGruOpe, .F.))
		cRet    := If(Empty(&(cCampoCtb)), 'C->'+cBusca, &(cCampoCtb))
		lAchou  := .T.
	Else
		If SZQ->(DBSeek(xFilial('SZQ')+cBusca+Space(4)+cGruOpe, .F.))
			cRet    := If(Empty(&(cCampoCtb)), 'C->'+cBusca, &(cCampoCtb))
			lAchou  := .T.
		EndIf
	EndIf
EndIf

//Se n�o achou, procura combinacao sem Grupo de Operadora
If !lAchou
	If SZQ->(DBSeek(xFilial('SZQ')+cBusca+cCodPla+cBi3CodSeg, .F.))
		cRet := IIf(Empty(&(cCampoCtb)), 'C->'+cBusca+cCodPla+cBi3CodSeg, &(cCampoCtb))
	ElseIf SZQ->(DBSeek(xFilial('SZQ')+cBusca+Space(4)+cBi3CodSeg, .F.))
		cRet := IIf(Empty(&(cCampoCtb)), 'C->'+cBusca+cCodPla+cBi3CodSeg, &(cCampoCtb))
	Else
		If ' ' $ cBusca
			cRet := 'L->'+cBusca+cCodPla+cBi3CodSeg
		Else
			cRet := 'N->'+cBusca+cCodPla+cBi3CodSeg
		EndIf
	EndIf
EndIf

//����������������������������������������������������������������������Ŀ
//�Solicitado em 29/03/06 incluir verificacao quanto ao campo BQC_CONTAC,�
//�se este estiver preenchido, considera a conta nele cadastrada, caso   �
//�contrario sera feita a busca nas combina�oes. Roger Cangianeli.       �
//�Modificado posicao para gravar log quando retornar conta do contrato, �
//�conforme solicitacao da Minou em 07/08/06. Roger C.                   �
//�Mantido nesta posicao devido aos dados do log. 07/08/07. Roger C.     �
//������������������������������������������������������������������������
If BG9->BG9_TIPO == "2" .and. !Empty(BQC->BQC_CONTAC)		//Pessoa Juridica com conta cadastrada
	cRet := BQC->BQC_CONTAC
EndIf

// Grava em memoria o procedimento
cProc	:= BD7->BD7_CODPAD+'/'+BD7->BD7_CODPRO

// Aciona gravacao de Log
If cAliasCab == 'BD5'
	cLog	:= 'Chave:'+cBusca+cCodPla+cBi3CodSeg+'|Conta:'+AllTrim(cRet)+'|Imp:'+AllTrim(BD5->BD5_NUMIMP)+'|LDP:'+BD5->BD5_CODLDP+'|PEG:'+BD5->BD5_CODPEG+'|Guia:'+BD5->BD5_NUMERO+"|Proc:"+AllTrim(cProc)+"|Proc.Contab:"+AllTrim(cCodPro)+"|Comp:"+BD5->BD5_MESPAG+"/"+BD5->BD5_ANOPAG
Else
	cLog	:= 'Chave:'+cBusca+cCodPla+cBi3CodSeg+'|Conta:'+AllTrim(cRet)+'|Int:'+AllTrim(BE4->BE4_NUMINT)+'|LDP:'+BE4->BE4_CODLDP+'|PEG:'+BE4->BE4_CODPEG+'|Guia:'+BE4->BE4_NUMERO+"|Proc:"+AllTrim(cProc)+"|Proc.Contab:"+AllTrim(cCodPro)+"|Comp:"+BE4->BE4_MESPAG+"/"+BE4->BE4_ANOPAG
EndIf
cLog	+= '|Classe Proc.:|'+IIf( Empty(cClasse), 'Em branco', cClasse )

// Adicao dos campos Valor, Codigo Novo e Antigo do Usuario, Plano, Grupo Empresa, Contrato e Subcontrato
// conforme solicitacao de Minou em 27/03/06 - Roger / Raquel
// Adicao da cod da natureza que esta na posicao 2 da variavel Cbusca a pedido da minou em 15/06
If !CT5->(CT5_LANPAD+CT5_SEQUEN) == cChaCT5 .and. !Empty(cChaCT5)
	CT5->(DbSetOrder(1))
	CT5->(MsSeek(xFilial("CT5")+cChaCT5)) 
EndIf

If !Empty(cChaCT5)
	cCT5Vlr := CT5->CT5_VLR01
Else
	cCT5Vlr := 'BD7->BD7_VLRPAG'
EndIf
 
//cLog1	:= '|Valor:|'+ Stuff( StrZero(BD7->BD7_VLRPAG,14,2), AT('.',StrZero(BD7->BD7_VLRPAG,14,2)), 1, ',' )
cLog1	:= '|Valor:|'+ Stuff( StrZero(&cCT5Vlr,14,2), AT('.',StrZero(&cCT5Vlr,14,2)), 1, ',' )
//cLog1	:= '|Valor:|'+ Stuff( StrZero(&(CT5->CT5_VLR01),14,2), AT('.',StrZero(&(CT5->CT5_VLR01),14,2)), 1, ',' )
cLog1	+= '|Matric:'+BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG+BA1_DIGITO)
cLog1	+= '|MatAnt:'+BA1->BA1_MATANT
cLog1	+= '|Cod.Plano:'+BI3->BI3_CODIGO+'/'+BI3->BI3_VERSAO
cLog1	+= '|Cod.RDA:'+BD7->BD7_CODRDA
cLog1	+= '|Centro de Custo:'+IIF(BA3->BA3_TIPOUS=="1",BI3->BI3_CC,(IIF(EMPTY(BT6->BT6_CC),BI3->BI3_CC,BT6->BT6_CC)))
cLog1	+= '|Cod.Grupo Ct:' +SUBSTRING(cBusca,2,2)

If BG9->BG9_TIPO == "1" //Pessoa Fisica
	cLog1	+= '|Grp.Fis:'+BG9->BG9_CODIGO
Else
	cLog1	+= '|Grp.Emp:'+BG9->BG9_CODIGO+'|Contr:'+BT5->BT5_NUMCON+'/'+BT5->BT5_VERSAO
	cLog1	+= '|Subcont:'+BQC->BQC_SUBCON+'/'+BQC->BQC_VERSUB
EndIf

If Subs(cRet,1,1) $ 'CLN'
	If Subs(cRet,1,1) $ 'C'
		cLog1	+= '|Falta Conta para Combinacao'
	ElseIf Subs(cRet,1,1) $ 'N'
		cLog1	+= '|Falta Combinacao'
	Else
		cLog1	+= '|Combinacao Invalida'
	EndIf
	// Grava log de registro com problema
	U_Gravalog(cLog+cLog1,IIf(cTipDC=="C","CRD/EVT","DEB/EVT") )
Else
	// Grava registro ok
	U_GrvLogBom(cLog+cLog1,IIf(cTipDC=="C","CRD/EVT","DEB/EVT") )
EndIf

CT5->(RestArea(aAreaCT5))
RestArea(aArea)
Return(cRet)


