#Include "protheus.ch"

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �CTBPLS02  �Autor  �Roger Cangianeli    � Data �  08/02/06   ���
�������������������������������������������������������������������������͹��
���Desc.     � Busca dinamica da conta, conforme configuracao flexivel    ���
���          � nos arquivos  especificos SZZ e SZY.                       ���
���          � Conta d�bito, lancamento P21 - Despesa Prod.M�dica         ���
���          � Conta cr�bito, lancamento PA9 - Transit.Desp.Prod.M�dica   ���
�������������������������������������������������������������������������͹��
���Uso       � Unimed e cooperativas                                      ���
�������������������������������������������������������������������������͹��
���Alteracao � Incluida opcao de localizacao com grupo de operadoras, cfe.���
���30/07/07  � necessidade de divisao do plano de contas ANS.             ���
���          � Contempla tamb�m novo tratamento ao Tipo de Prestador.     ���
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

User Function CTBPLS02(lLogOk,cAliasCab)

//������������������������������������������������������������������Ŀ
//�Inicializa Parametros:                                            �
//�MV_YCTPL01 --> Classes de Procedimentos para Consultas            �
//�MV_YCTPL02 --> Classes de Procedimentos para Exames / Terapias    �
//�MV_YCTPL03 --> Classes de Procedimentos para Demais Despesas      �
//�MV_YCTPL04 --> Codigo do RDA para o SUS                           �
//�MV_YCTPL10 --> Codigo do Tipo de Prestador existente p/Medicos    �
//�MV_YCTPL11 --> Classes de Procedimentos para HM                   �
//�MV_YCTPL14 --> Codigo do Tipo de Prestador existente p/Operadoras.�
//�MV_YCTPL19 --> Codigo dos RDA's para desconsiderar Tipo Prestador.�
//�MV_YCTPL20 --> Tipo de Prestador fixo nos RDAs param. MV_YCTPL19. �
//��������������������������������������������������������������������

Local cCtpl01 := GetNewPar('MV_YCTPL01','000001')
Local cCtpl02 := GetNewPar('MV_YCTPL02','000002/000003/000005/000006/000007/000008/000009/000010')
Local cCtpl03 := GetNewPar('MV_YCTPL03','000011/000012')
Local cCtpl04 := GetNewPar('MV_YCTPL04','SUS')
//Local cCtpl10 := GetNewPar('MV_YCTPL10','ANE/MED/MCR/MPT')
Local cCtpl11 := GetNewPar('MV_YCTPL11','000004')
Local cCtpl14 := GetNewPar('MV_YCTPL14','OPE/UNI')
Local cCtpl19 := GetNewPar('MV_YCTPL19','000511/000512/000513/001059/001060/001061/001062/001063/001064/001065/001074')
Local cCtpl20 := GetNewPar('MV_YCTPL20','PAT')

//��������������������������������������Ŀ
//�Inicializa as variaveis neste ambiente�
//����������������������������������������
Private cRet, cBusca, aArea, cProc
Private cClasse    := ""
//Private cBauEst    := ""
Private cBauTipPre := ""
Private cBauCopCre := ""
Private lAchou     := .F.
Private cCodPla    := Space(4)

Default lLogOk	:= .F.
Default cAliasCab	:= 'BMS'

aArea	:= GetArea()
aAreaBAU:= BAU->(GetArea())		// Alteracao em 07/12/06 pois perdeu posicionamento no BAU. Roger C.
aAreaBA1:= BA1->(GetArea())		// Alteracao em 30/07/07. Roger C.


cPlano	:= ''

//���������������������������������������������������������������Ŀ
//�Incluida condi��o para contemplar lan�amentos deb/crd, que n�o �
//�tem como buscar o benefici�rio.                                �
//�����������������������������������������������������������������
If cAliasCab == 'BMS'
	cBusca	:= '1'
	
Else
	//�������������������������������������������������Ŀ
	//�POSICIONAR USUARIO E/OU FAMILIA PARA BUSCAR BI3  �
	//���������������������������������������������������
	If BD7->BD7_OPEUSR+BD7->BD7_CODEMP+BD7->BD7_MATRIC+BD7->BD7_TIPREG <> BA1->BA1_CODINT+BA1->BA1_CODEMP+BA1->BA1_MATRIC+BA1->BA1_TIPREG
		//	cPlano	:= Posicione("BA1",2,xFilial("BA1")+BD7->BD7_OPEUSR+BD7->BD7_CODEMP+BD7->BD7_MATRIC+BD7->BD7_TIPREG,"BA1_CODPLA")
		// 30/07/07 - Posiciona para utilizacao posterior
		BA1->(dbSetOrder(2))
		BA1->(MsSeek(xFilial("BA1")+BD7->BD7_OPEUSR+BD7->BD7_CODEMP+BD7->BD7_MATRIC+BD7->BD7_TIPREG))
		cPlano	:= BA1->BA1_CODPLA
		cCodPla := BA1->BA1_CODPLA
		
		// Identifica se o plano esta no usuario ou na familia
		If !Empty(cPlano)
			cPlano	+= Posicione("BA1",2,xFilial("BA1")+BD7->BD7_OPEUSR+BD7->BD7_CODEMP+BD7->BD7_MATRIC+BD7->BD7_TIPREG,"BA1_VERSAO")
		Else
			cPlano	:= Posicione("BA3",1,xFilial("BA3")+BD7->BD7_OPEUSR+BD7->BD7_CODEMP+BD7->BD7_MATRIC,"BA3_CODPLA")
			cPlano	+= Posicione("BA3",1,xFilial("BA3")+BD7->BD7_OPEUSR+BD7->BD7_CODEMP+BD7->BD7_MATRIC,"BA3_VERSAO")
		EndIf
		
	Else
		If !Empty(BA1->BA1_CODPLA+BA1->BA1_VERSAO)
			cPlano	:= 	BA1->BA1_CODPLA+BA1->BA1_VERSAO
		Else
			cPlano	:= Posicione("BA3",1,xFilial("BA3")+BD7->BD7_OPEUSR+BD7->BD7_CODEMP+BD7->BD7_MATRIC,"BA3_CODPLA")
			cPlano	+= Posicione("BA3",1,xFilial("BA3")+BD7->BD7_OPEUSR+BD7->BD7_CODEMP+BD7->BD7_MATRIC,"BA3_VERSAO")
		EndIf
		
	EndIf
	//������������������������������������������������������������������������Ŀ
	//�TIPO DO BENEFICIARIO                                                    �
	//�Verifica conteudo do campo BG9_XTPBEN ( Char(1) ), especifico que indica�
	//�o tipo de beneficiario do contrato. As opcoes sao:                      �
	//�1 - BE - Beneficiario Exposto                                           �
	//�2 - ENB - Exposto Nao Beneficiario                                      �
	//�3 - BNE - Beneficiario Nao Exposto                                      �
	//�4 - PS - Prestacao de Servicos                                          �
	//��������������������������������������������������������������������������		
	cBusca	:= Posicione("BI3",1,xFilial("BI3")+PLSINTPAD()+cPlano,"BI3_YTPBEN")
	
	//�����������������������������������������������������������������e
	//�Verifica se BAU esta posicionado e reposiciona, caso n�o esteja.�
	//�07/12/06 - Roger C.                                             �
	//�����������������������������������������������������������������e
	If BD7->BD7_CODRDA <> BAU->BAU_CODIGO
		BAU->(dbSetOrder(1))
		BAU->(dbSeek(xFilial('BAU')+BD7->BD7_CODRDA,.F.))
	EndIf

EndIf

cBauTipPre	:= BAU->BAU_TIPPRE
cBauCopCre	:= BAU->BAU_COPCRE


//���������������������������������������������������Ŀ
//�CLASSE DO PROCEDIMENTO                             �
//�Verifica a classe do procedimento da tabela padrao.�
//�����������������������������������������������������
cClasse	:= Posicione("BR8",1,xFilial("BR8")+BD7->BD7_CODPAD+BD7->BD7_CODPRO,"BR8_CLASSE")


//���������������������������������������������������Ŀ
//�CLASSE DA RDA                                      �
//�Assume a classe da RDA configurada em RDA Cadastro.�
//�����������������������������������������������������
// Inclus�o de tratamento espec�fico via par�metro, para necessidade de clientes
If AllTrim( &(cAliasCab+'->'+cAliasCab+'_CODRDA') ) $ cCtpl19
	cBusca += cCtpl20
Else
	cBusca	+= AllTrim(cBauTipPre)
EndIf

//�������������������������������������������������������������������������������������������������Ŀ
//�TIPO DE PRESTADOR                                                          						�
//�Analisa o vinculo do prestador com a cooperativa e a classe do procedimento						�
//�executado. As opcoes sao:                                                  						�
//�0 - Nulo --> Para atendimento pelo SUS ou Exterior                         						�
//�1 - Proprio/Assalariado --> Para Funcionarios em atendimento a consultas   						�
//�2 - Cooperados --> Para Cooperados em atendimento a consultas              						�
//�3 - Nao Cooperados --> Para Nao Cooperados, qualquer atendimento           						�
//�4 - Rede Propria --> Para Cooperados, em atendimento a exames/terapias e demais despesas			�
//�5 - Rede Conveniada --> Para Credenciados, em atendimento a exames/terapias e demais despesas	�
//�6 - Intec ambio --> Atendimento em Intercambio                              						�
//���������������������������������������������������������������������������������������������������
Do Case
	// SUS e Exterior
	Case AllTrim(BAU->BAU_CODIGO) $ cCtpl04 .or. BAU->BAU_EST == 'EX'
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
		
		// Credenciados e Exames/Demais despesas
		// Permitido todas as classes a partir de 24/10/07, por ser classificados da mesma forma.
	Case AllTrim(cBauCopCre) $ '2' //.and. AllTrim(cClasse) $ cCtpl01+'/'+cCtpl02+'/'+cCtpl03
		cBusca	+= '5'
		
		// Nao Cooperados - Todas as classes...
	Case AllTrim(cBauCopCre) $ '4'
		cBusca	+= '3'
		
		// Outras opcoes
	OtherWise
		cBusca	+= ' '
		
EndCase

    //Tratamento ao Grupo de Operadoras.
    //Valido somente para Tipo de Beneficiario igual a
    //Exposto Nao Beneficiario (2) ou Prestacao de Servicos (4).
    //RC - 06/08/07
    DBSelectArea('SZO')
    SZO->(DBSetOrder(2)) //ZO_FILIAL+ZO_TPBENEF+ZO_TIPPRE+ZO_TPPREST+ZO_CODPROD+ZO_GRUOPE
    
    If Subs(cBusca, 1, 1) $ '2/4' //Tipo do Beneficiario
        cGruOpe	:= Posicione("BA0", 1, xFilial("BA0")+BA1->BA1_OPEORI, "BA0_GRUOPE")
        //Procura combinacao com Grupo de Operadora
        If SZO->(DBSeek(xFilial('SZO')+cBusca+cCodPla+cGruOpe, .F.))
            cRet   := If(Empty(SZO->ZO_CONTA), 'C->'+cBusca, SZO->ZO_CONTA)
            lAchou := .T.
        ElseIf SZO->(DBSeek(xFilial('SZO')+cBusca+Space(4)+cGruOpe, .F.))
            cRet   := If(Empty(SZO->ZO_CONTA), 'C->'+cBusca, SZO->ZO_CONTA)
            lAchou := .T.
        EndIf
    EndIf

    //Se n�o achou, procura combinacao sem Grupo de Operadora
    If !lAchou
        If SZO->(DBSeek(xFilial('SZO')+cBusca+cCodPla, .F.))
            cRet := IIf(Empty(SZO->ZO_CONTA), 'C->'+cBusca, SZO->ZO_CONTA)
        ElseIf SZO->(DBSeek(xFilial('SZO')+cBusca+Space(4), .F.))
            cRet := IIf(Empty(SZO->ZO_CONTA), 'C->'+cBusca, SZO->ZO_CONTA)
        Else
            //Se for operadora, despreza o tipo de cooperado e tenta achar a conta novamente
            If Subs(cBusca,2,3) $ cCtpl14
                If SZO->(DBSeek(xFilial('SZO')+Subs(cBusca,1,4), .F.))
                    cRet := IIf(Empty(SZO->ZO_CONTA), 'C->'+cBusca, SZO->ZO_CONTA)
                Else
                    If ' ' $ cBusca
                        cRet := 'L->'+cBusca
                    Else
                        cRet := 'N->'+cBusca
                    EndIf
                EndIf
            Else
                If ' ' $ cBusca
                    cRet := 'L->'+cBusca
                Else
                    cRet := 'N->'+cBusca
                EndIf
            EndIf
        EndIf
    EndIf


// Grava em memoria o procedimento
cProc	:= BD7->BD7_CODPAD+'/'+BD7->BD7_CODPRO

// Aciona gravacao de Log
cLog	:= 'Chave:'+cBusca+'|Conta:'+AllTrim(cRet)
If cAliasCab $ 'BD5/BE4'
	If cAliasCab == 'BD5'
		cLog	+= '|Imp:'+AllTrim(BD5->BD5_NUMIMP)+'|LDP:'+BD5->BD5_CODLDP+'|PEG:'+BD5->BD5_CODPEG+'|Guia:'+BD5->BD5_NUMERO+"|Proc:"+AllTrim(cProc)+"|Comp:"+BD5->BD5_MESPAG+"/"+BD5->BD5_ANOPAG
	Else
		cLog	+= '|Int:'+AllTrim(BE4->BE4_NUMINT)+'|LDP:'+BE4->BE4_CODLDP+'|PEG:'+BE4->BE4_CODPEG+'|Guia:'+BE4->BE4_NUMERO+"|Proc:"+AllTrim(cProc)+"|Comp:"+BE4->BE4_MESPAG+"/"+BE4->BE4_ANOPAG
	EndIf
Else			// SE VIER DO P22 (BMS)
	cLog	+= '|Imp:'+AllTrim(BD7->BD7_NUMIMP)+'|LDP:'+BD7->BD7_CODLDP+'|PEG:'+BD7->BD7_CODPEG+'|Guia:'+BD7->BD7_NUMERO+"|Proc:"+AllTrim(cProc)+"|Comp:"+BD7->BD7_MESPAG+"/"+BD7->BD7_ANOPAG
EndIf
cLog	+= '|Classe Proc.:|'+IIf( Empty(cClasse), 'Em branco', cClasse )

// Adicao dos campos Valor, Codigo Novo e Antigo do Usuario, Plano, Grupo Empresa, Contrato e Subcontrato
// conforme solicitacao de Minou em 27/03/06 - Roger / Raquel

cLog1	:= '|Valor:|'+ Stuff( StrZero(BD7->BD7_VLRPAG,14,2), AT('.',StrZero(BD7->BD7_VLRPAG,14,2)), 1, ',' )
cLog1	+= '|Matric:'+BD7->BD7_OPEUSR+BD7->BD7_CODEMP+BD7->BD7_MATRIC+BD7->BD7_TIPREG
cLog1	+= '|Cod.Plano:'+cPlano
cLog1	+= '|Cod.RDA:'+BD7->BD7_CODRDA
cLog1	+= '|Centro de Custo:'+IIF(BA3->BA3_TIPOUS=="1",BI3->BI3_CC,(IIF(EMPTY(BT6->BT6_CC),BI3->BI3_CC,BT6->BT6_CC)))

// Identifica tipo de log conforme origem

If cAliasCab $ 'BD5/BE4'
	cTpLog	:= 'CRD/EVT'
Else				// se vier do P21-P22-P23 (BMS)
	cTpLog	:= 'DEB/PRD'
EndIf

// Aciona gravacao de Log

If Subs(cRet,1,1) $ 'CLN'
	If Subs(cRet,1,1) $ 'C'
		cLog1	+= '|Falta Conta para Combinacao'
	ElseIf Subs(cRet,1,1) $ 'N'
		cLog1	+= '|Falta Combinacao'
	Else
		cLog1	+= '|Combinacao Invalida'
	EndIf
	
	// Grava log de registro com problema
	U_Gravalog(cLog+cLog1,cTpLog)
	
ElseIf lLogOk
	
	// Grava registro ok
	U_GrvLogBom(cLog+cLog1,cTpLog)
	
EndIf

RestArea(aAreaBA1)		// Alteracao em 07/12/06
RestArea(aAreaBAU)		// Alteracao em 07/12/06 pois perdeu posicionamento no BAU. Roger C.
RestArea(aArea)
Return(cRet)
