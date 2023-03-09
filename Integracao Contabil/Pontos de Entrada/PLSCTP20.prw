#include 'protheus.ch'
/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �PLSCTP20  �Autor  �Roger Cangianeli    � Data �  19/02/08   ���
�������������������������������������������������������������������������͹��
���Desc.     � Ponto de entrada para classificacao do tipo de ato no SZZ -���
���          � contabiliza��o custos, somente intercambio n�o preenchido. ���
�������������������������������������������������������������������������͹��
���Uso       � Contabiliza��o Espec�fica PLS                              ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

//���������������������������������������������������������������ġ
//�Variavel recebida: cBusca - string de busca para o arquivo SZZ.�
//���������������������������������������������������������������ġ
User Function PLSCTP20()

Local cBusca	:= ParamIxb[1]
//����������������������������������������������������������������������������������Ŀ
//�Na Unimed Vale do Sinos, foi definido que a classifica��o ser� definida pelo tipo �
//�de procedimento cont�bil, conforme liga��o do procedimento m�dico da guia com a   �
//�natureza de sa�de, que cont�m o tipo de procedimento cont�bil.                    �
//�No caso, o tipo de procedimento cont�bil j� faz parte da vari�vel cBusca.         �
//������������������������������������������������������������������������������������


//��������������������������������������������������������������Ŀ
//�Definido que se o procedimento for referido a '01'- Consulta, �
//�'06' - Interna��o HM ou '12' - Outros Atendimentos, ser�      �
//�classificado como '1' -> Ato Cooperativo Principal.           �
//�Demais procedimento ser�o classificados como '2' - Ato        �
//�Cooperativo Auxiliar.                                         �
//�                                                              �
//�ATEN��O: regra definida para esta Unimed, n�o � regra de      �
//�Interc�mbio nem tampouco possui embasamento legal.            �
//�Verificar regra com o cliente a implantar.                    �
//�                                                              �
//����������������������������������������������������������������

// se Tipo de Procedimemnto Cont�bil 01, 06 ou 12, classifica ACP
If Subs(cBusca,2,2) $ '01/06/12'
	cBusca += '1'

// Demais, classifica ACA
Else
	cBusca += '2'

EndIf


//���������������������������������������������������������������������������Ŀ
//�Vari�vel de retorno: cBusca -> deve acrescer o tipo de ato, que pode ser:  �
//�1 - Ato Cooperativo Principal                                              �
//�2 - Ato Cooperativo Auxiliar                                               �
//�3 - Ato N�o Cooperativo                                                    �
//�����������������������������������������������������������������������������
Return(cBusca)

