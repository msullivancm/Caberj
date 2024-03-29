#include "rwmake.ch"
/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  � F090QFIL  � Autor �                   � Data �  24/10/2022 ���
�������������������������������������������������������������������������͹��
���Desc.     � Filtrar Titulos Bloqueados no Contas a Pagar Gerados no PLS���
���          � na Rotina Baixa de Titulos Automatica.(FINA090)            ���
���          � utilizand sintaxe SQL                                      ���
�������������������������������������������������������������������������͹��
���Uso       � Caberj                                                     ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

/*
Substitui F090FIL pois a mesma se tornou obsoleta na V33 conforme boletim
https://centraldeatendimento.totvs.com/hc/pt-br/articles/360020608812-Cross-Segmento-Backoffice-Linha-Protheus-ADVPL-Erro-F090FIL-n%C3%A3o-realiza-filtragem
*/

User Function F090QFIL()
    
    Local cFiltro    := ParamIXB[1] //Filtro padr�o
    //Local nTipoBx    := ParamIXB[2] //Tipo de Baixa
    Local cRetFiltro := cFiltro //Novo Filtro

    cRetFiltro +=  " AND ( E2_YLIBPLS IN ('S','M') OR Substr(E2_ORIGEM,1,3) <> 'PLS' ) "

    cRetFiltro +=  " AND (( SELECT A2_YBLQPLS FROM " + RetSqlName("SA2") + " SA2  " 
    cRetFiltro +=  " WHERE SA2.A2_COD = E2_FORNECE AND SA2.A2_LOJA = E2_LOJA "
    cRetFiltro +=  " AND SA2.D_E_L_E_T_ = ' ' "
    cRetFiltro +=  " AND SA2.A2_FILIAL = '" + XFilial("SA2") + "' ) <> 'S'  )" 

Return cRetFiltro

