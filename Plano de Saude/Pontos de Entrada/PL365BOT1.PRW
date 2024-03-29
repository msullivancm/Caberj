//#INCLUDE "plsa940.ch"
#include "PLSMGER.CH"
#include "topconn.CH"
#include "PROTHEUS.CH"

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �PL365BOT1 �Autor  �Desconhecido        � Data �  03/19/10   ���
�������������������������������������������������������������������������͹��
���Desc.     �Ponto de entrada para inclus�o de bot�es na tela de rede de ���
���          �atendimento.                                                ���
�������������������������������������������������������������������������͹��
���Alteracoes�Leonardo Portella (10/05/11) - Alteracoes para adaptacao da ���
���          �rotina conforme o ponto de entrada apos o patch SCZWB4 que  ���
���          �permite que mais de um botao no enchoice.                   ���
�������������������������������������������������������������������������͹��
���Uso       � CABERJ                                                     ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/  

User Function PL365BOT1
//�������������������������������������Ŀ
//�Variaveis padroes do porto de entrada�
//���������������������������������������

//����������������������������������������������������������������������������������������������������������������������������Ŀ
//�PL365BOT1 - Inclus�o de bot�es na tela rede de atendimento. ( [ nOpc ], [ cCodigo ], [ cCodLoc ], [ cCodEsp ] ) --> aButtons�
//�nOpc - N�mero da op��o                                                                                                      �
//�cCodigo - C�digo da rede de atendimento                                                                                     �
//�cCodLoc - C�digo do local.                                                                                                  �
//�cCodEsp - C�digo da especialidade.                                                                                          �
//������������������������������������������������������������������������������������������������������������������������������

Local aRet    	:= {}

Local nOpc    	:= paramixb[1]//paramixb[5]
Local cCodRda 	:= paramixb[2]
Local cCodLoc 	:= paramixb[3]
Local cCodEsp 	:= paramixb[4]

//1- Tipo do bot�o
//2- Bloco de codigo da Fun��o a ser executada
//3- Descri��o da bot�o
//4- Nome do Bot�o

aAdd(aRet,{"HISTORIC"	,{||Processa({||RDAxPlano(cCodRda)})	},"RDA x Plano","RDA x Pl."}) 
//aAdd(aRet,{"SDURECALL"	,{||alert('PL365BOT1')     				},"Vincula��o RDA x Local x Itens divulga��o x Grupo Especialidade","Vincula��o"}) 

Return aRet
           
********************************************************************************************************************************

Static Function RDAxPlano(cCodRda)

Local nI := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

Local aPlanos 	:= {}
Local aAreaBAU	:= BAU->(GetArea())
Local cCodOpe 	:= PLSINTPAD()

ProcRegua(0)

For nI := 1 to 5
    IncProc('Processando...')
Next                       

//���������������������������������������������������������������������Ŀ
//� nOpc = "1" - Retorna a montagem do botao                            �
//� Array de Retorno: [1] - .T.                                         �
//�                   [2] - Imagem do botao                             �
//�                   [3] - Titulo do botao                             �
//�����������������������������������������������������������������������
//If nOpc == 1 //cOpe == "1"
	
    /*
	Aadd(aRet,.T.)
	Aadd(aRet,"HISTORIC") //Imagem
	Aadd(aRet,"RDA x Plano")   //Titulo

	Return(aRet)
    */
//���������������������������������������������������������������������Ŀ
//� cOpe = "2" - Chama a funcao que monta a tela                        �
//�����������������������������������������������������������������������
	
//ElseIf nOpc == 2 //cOpe == "2"
	
	//���������������������������������������������������������������������Ŀ
	//�Observacao importante:                                               |
	//�Conforme solicitado pelo setor de crecendicamento:                   |
	//�Maria Claudia, Leandro, Dr. Vitoria                                  |
	//�Esta pesquisa nao considera Local de Atendimento x Especialidade     |
	//�x Rede de Atendimento, mostranto assim os planos da RDA, no geral    |
	//�����������������������������������������������������������������������
	
	cQuery := " SELECT BI3_CODIGO CODIGO, BI3_VERSAO VERSAO,BI3_NREDUZ PRODUTO,BI3_CODACO CODACO "
	cQuery += "  FROM "+RetSqlName("BI3")+" BI3 "
	cQuery += "  WHERE BI3_FILIAL = '"+xFilial("BI3")+"' "
	cQuery += "   AND BI3_CODINT = '"+cCodOpe+"' "
	cQuery += "   AND BI3_GRUPO = '001'"
	cQuery += "   AND BI3_STATUS = '1'"
	cQuery += "   AND BI3.D_E_L_E_T_ = ' ' "
	cQuery += "   ORDER BY BI3_CODIGO "
	
	cQuery := ChangeQuery(cQuery)
	
	TCQuery cQuery Alias "TRBPLA" New
	
	While !TRBPLA->(Eof())
		
		cQuery := " SELECT BA1.R_E_C_N_O_ RECUSR "
		cQuery += " FROM "+RetSqlName("BA1")+" BA1 "
		cQuery += " WHERE BA1.BA1_FILIAL = '"+xFilial("BA1")+"' "
		cQuery += " AND BA1.BA1_CODINT = '"+cCodOpe+"' "
		cQuery += " AND BA1.BA1_DATBLO = ' ' "
		cQuery += " AND BA1.BA1_CODPLA = '"+TRBPLA->CODIGO+"' "
		cQuery += " AND BA1.BA1_VERSAO = '"+TRBPLA->VERSAO+"' "
		cQuery += " AND BA1.D_E_L_E_T_ = ' ' "
		cQuery += " AND ROWNUM < 2 "
		
		cQuery := ChangeQuery(cQuery)
		
		TCQuery cQuery Alias "TRBUSR" New
		
		WHILE !TRBUSR->(EOF())
			//BA1->(DbSetorder(1))
			//BA1->(dbSeek(xFilial("BA1")+TRBUSR->(BA3_CODINT+BA3_CODEMP+BA3_MATRIC+"00")))
			//Rotina padrao para validar RDA
			BA1->(DbGoto(TRBUSR->RECUSR))
			aRet:= PLSVLDRDA("1",nil,nil,nil,nil)
			If aRet[1]
				aAdd(aPlanos,{TRBPLA->CODIGO,;
				TRBPLA->VERSAO,;
				TRBPLA->PRODUTO,;
				TRBPLA->CODACO,;
				Posicione("BI4",1,xFilial("BI4")+TRBPLA->CODACO,"BI4_DESCRI")})
				
			EndIf
			TRBUSR->(DbSkip())
		EndDo
		
		TRBUSR->(dbCloseArea())
		
		TRBPLA->(DbSkip())
	EndDo
	TRBPLA->(DbCloseArea())
	
	Plscrigen(aPlanos,{{"Codigo ","@C","7"},;
	{"Vers�o ","@!","7"},;
	{"Plano","@!","20"},;
	{"Cod.Rede","@!","8"},;
	{"Descri. Rede","@!","30"}},;
	"Planos x RDA - "+cCodRda+"-"+M->BAU_NOME,.T.,"Planos atendidos por esta RDA")
	
//EndIf
/*
romulo//���������������������������������������������������������������������Ŀ
//� cOpe = "3" - Grava Dados                                            �
//�����������������������������������������������������������������������
ElseIf cOpe == "3"

//���������������������������������������������������������������������Ŀ
//� cOpe = "4" - cancela dados                                          �
//�����������������������������������������������������������������������
ElseIf cOpe == "4"
*/

BAU->(RestArea(aAreaBAU))

Return
