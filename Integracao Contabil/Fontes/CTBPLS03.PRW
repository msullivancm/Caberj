#Include 'protheus.ch'

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �CTBPLS03  �Autor  �Roger Cangianeli    � Data �  16/02/06   ���
�������������������������������������������������������������������������͹��
���Desc.     � Busca dinamica da conta, conforme configuracao flexivel    ���
���          � no arquivo especifico SZX - Lanctos Deb/Cred RDA.          ���
�������������������������������������������������������������������������͹��
���Uso       � Unimed e cooperativas                                      ���
�������������������������������������������������������������������������͹��
���Alteracoes� Inclusao do CRM para busca de contas, facilitando o lancto ���
���          � de Integralizacao de Capital. Roger Cangianeli-18/07/06    ���
���          �                                                            ���
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

User Function CTBPLS03(cTpLog)

//��������������������������������������Ŀ
//�Inicializa as variaveis neste ambiente�
//����������������������������������������
Local cRet, cBusca, aArea, cProc

Private cCodPla := Space(4)

Default	cTpLog	:= 'DC/RDA'
aArea	:= GetArea()


//�������������������������������������������������������Ŀ
//�CODIGO DO LANCAMENTO                                   �
//�Utiliza o codigo do lancamento do cadastro de tipos de �
//�lancamento Deb/Cred da RDA.                            �
//���������������������������������������������������������
cCodPla := BBB->BBB_YCODPL
cBusca	:= BBB->BBB_CODSER

//���������������������������������������������������Ŀ
//�CLASSE DA RDA                                      �
//�Assume a classe da RDA configurada em RDA Cadastro.�
//�����������������������������������������������������
// Se for Operadora, nao exige preenchimento
cBusca	+= AllTrim(BAU->BAU_TIPPRE)


//�������������������������������������������������������������Ŀ
//�TIPO DO PRESTADOR                                            �
//�Identifica qual o tipo de prestador conforme cadastro da RDA.�
//�As opcoes sao:                                               �
//�1 - Cooperado                                                �
//�2 - Credenciado                                              �
//�3 - Funcionario                                              �
//�4 - Nao Cooperado                                            �
//���������������������������������������������������������������
cBusca	+= BAU->BAU_COPCRE



//�������������������������������������������������������Ŀ
//�CODIGO CONSELHO REGIONAL                               �
//�Inclue na procura o codigo do conselho regional do RDA.�
//���������������������������������������������������������
//cBusca	+= BAU->BAU_CONREG

    DBSelectArea('SZP')
    SZP->(DBSetOrder(1))

    Do Case
        //Verifica chave completa
        Case SZP->(DBSeek(xFilial("SZP")+cBusca+BAU->BAU_CONREG+cCodPla, .F.))
            cRet := If(Empty(SZP->ZP_CCRED), 'C->'+cBusca+BAU->BAU_CONREG+cCodPla, SZP->ZP_CCRED)	

        //Verifica chave com a conta cont�bil padr�o, levando em considera��o o grupo
        Case SZP->(DBSeek(xFilial('SZP')+cBusca+BAU->BAU_CONREG+Space(4), .F.))
            cRet := If(Empty(SZP->ZP_CCRED), 'C->'+cBusca+BAU->BAU_CONREG+Space(4), SZP->ZP_CCRED)
            
        //Despreza o plano e verifica se existe cadastro com o grupo informado
        Case SZP->(DBSeek(xFilial('SZP')+cBusca+BAU->BAU_CONREG, .F.))
            cRet := If(Empty(SZP->ZP_CCRED), 'C->'+cBusca+BAU->BAU_CONREG, SZP->ZP_CCRED)            

		//Despreza o CRM e verifica se existe Tipo de Cooperado
        Case SZP->(DBSeek(xFilial('SZP')+cBusca, .F.))
            cRet := If(Empty(SZP->ZP_CCRED), 'C->'+cBusca, SZP->ZP_CCRED)

		//Despreza o CRM e verifica se existe Tipo de Cooperado
        Case SZP->(DBSeek(xFilial('SZP')+Left(cBusca, 7), .F.))
            cRet := If(Empty(SZP->ZP_CCRED), 'C->'+Left(cBusca, 7), SZP->ZP_CCRED)
		
		//Despreza o tipo de cooperado e tenta achar pelo tipo de prestador
        Case SZP->(DBSeek(xFilial('SZP')+Left(cBusca, 6), .F.))
            cRet := IIf(Empty(SZP->ZP_CCRED), 'C->'+Left(cBusca, 6), SZP->ZP_CCRED)
		
        //Despreza o tipo de prestador e tenta achar pelo tipo de lancamento
        Case dbSeek(xFilial('SZP')+Left(cBusca, 3),.F.)
            cRet := IIf(Empty(SZP->ZP_CCRED), 'C->'+Left(cBusca, 3), SZP->ZP_CCRED)
		
        OtherWise
            If ' ' $ cBusca
                cRet	:= 'L->'+cBusca
            Else
                cRet	:= 'N->'+cBusca
            EndIf
    EndCase

cProc	:= '|Oper.:'+BMS->BMS_OPELOT+'|RDA:'+BMS->BMS_CODRDA+'|Ano:'+BMS->BMS_ANOLOT+'|Mes:'+BMS->BMS_MESLOT
cProc 	+= '|Num.Lote:'+BMS->BMS_NUMLOT+'|Chave:'+cBusca

// Aciona gravacao de Log
If Subs(cRet,1,1) $ 'CLN'
	If Subs(cRet,1,1) $ 'L'
		cProc	+= '|Impossivel montar combinacao'
	ElseIf Subs(cRet,1,1) $ 'C'
		cProc	+= '|Falta Conta para Combinacao'
	ElseIf Subs(cRet,1,1) $ 'N'
		cProc	+= '|Falta Combinacao'
	EndIf
	U_Gravalog(cProc,cTpLog)
	
Else
	// Grava registro ok
	U_GrvLogBom(cProc,cTpLog)
	
EndIf


RestArea(aArea)
Return(cRet)


