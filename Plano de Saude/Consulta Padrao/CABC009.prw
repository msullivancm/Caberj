#INCLUDE "RWMAKE.CH"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "TOPCONN.CH"
#INCLUDE "FONT.CH"
#INCLUDE "TBICONN.CH"

#DEFINE c_ent CHR(13) + CHR(10)

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �CABC009   �Autor  �Angelo Henrique     � Data �  09/03/21   ���
�������������������������������������������������������������������������͹��
���Desc.     � Consulta Padr�o para a listar codigo da a��o e descri��o   ���
���          �no relat�rio crystal  RELCBC                                ���
�������������������������������������������������������������������������͹��
���Uso       � CABERJ                                                     ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function CABC009()

    Local _aArea 		:= GetArea()
    Local lRet 			:= .T.

    Local oButton1		:= Nil
    Local oButton2		:= Nil

    Private oListBox1	:= Nil
    Private aDadosACA 	:= {}

    Static _oDlg2		:= Nil

    Public _cCodAca		:= ""

    //------------------------------------------------
    //Iniciando o vetor
    //------------------------------------------------
    CABC009A()

    DEFINE MSDIALOG _oDlg2 TITLE "Pesquisa de Tipos A��o" FROM 000, 000  TO 400, 820 COLORS 0, 16777215 PIXEL

    @ 010, 004 LISTBOX oListBox1 FIELDS HEADER "Codigo" , "Descri��o" SIZE 400, 170 OF _oDlg2 COLORS 0, 16777215 COLSIZES 10,50,50,100 PIXEL

    @ 185, 320 BUTTON oButton1 PROMPT "Ok" 			SIZE 037, 012 OF _oDlg2 ACTION (IIF(CABC009B(), _oDlg2:End(),.F.)	) PIXEL
    @ 185, 367 BUTTON oButton2 PROMPT "Cancelar" 	SIZE 037, 012 OF _oDlg2 ACTION (_oDlg2:End()						) PIXEL

    oListBox1:SetArray(aDadosACA)

    oListBox1:bLine := {|| {AllTrim(aDadosACA[oListBox1:nAT,01]),AllTrim(aDadosACA[oListBox1:nAT,02])}}

    oListBox1:blDblClick := {||IIF(CABC009B(), _oDlg2:End(),.F.)}

    ACTIVATE MSDIALOG _oDlg2 CENTERED

    RestArea(_aArea)

Return lRet

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �CABC009A  �Autor  �Angelo Henrique     � Data �  09/03/21   ���
�������������������������������������������������������������������������͹��
���Desc.     � Monta a query para a CABERJ e INTEGRAL                     ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � CABERJ                                                     ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

Static Function CABC009A()

    Local cAlias1 	:= GetNextAlias()
    Local _cRet 	:= ""

    _cRet := " SELECT 			" + CRLF
    _cRet += " 	COD_ACAO,		" + CRLF
    _cRet += " 	DESCRICAO_RES   " + CRLF
    _cRet += " FROM             " + CRLF
    _cRet += " 	ACAO_CBC        " + CRLF
    _cRet += " ORDER BY 1       " + CRLF

    //-----------------------------------------
    //Fechando a area caso esteja aberta
    //-----------------------------------------
    If Select(cAlias1) > 0
        (cAlias1)->(DbCloseArea())
    Endif

    DbUseArea(.T.,"TOPCONN", TCGENQRY(,,_cRet),cAlias1, .F., .T.)

    (cAlias1)->(DbGoTop())

    If !(cAlias1)->(Eof())

        aDadosACA 	:= {}

        Do While (cAlias1)->(!Eof())

            aAdd( aDadosACA, {(cAlias1)->COD_ACAO, (cAlias1)->DESCRICAO_RES } )

            (cAlias1)->(DbSkip())

        EndDo

    EndIf

    //-----------------------------------------
    //Fechando a area caso esteja aberta
    //-----------------------------------------
    If Select(cAlias1) > 0
        (cAlias1)->(DbCloseArea())
    Endif

Return

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �CABC009B  �Autor  �Angelo Henrique     � Data �  12/07/17   ���
�������������������������������������������������������������������������͹��
���Desc.     � Rotina utilizada para pegar a linha selecionada ap�s a     ���
���          �pesquisa da consulta padr�o.                                ���
�������������������������������������������������������������������������͹��
���Uso       � CABERJ                                                     ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

Static Function CABC009B()

    Local _lRet			:= .T.

    Public _cCodAca		:= ""

    _cCodAca := aDadosACA[oListBox1:nAT][1]

Return _lRet