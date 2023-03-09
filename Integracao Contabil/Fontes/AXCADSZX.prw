#include 'rwmake.ch'
/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �AXCADSZX  �Autor  �Roger Cangianeli    � Data �  12/01/06   ���
�������������������������������������������������������������������������͹��
���Desc.     � Cadastro de Amarracoes Contabeis para Custos               ���
���          � CONTAS DOS RDAs                                            ���
���          � Tabela SZX foi a�terada para SZP                           ���
�������������������������������������������������������������������������͹��
���Uso       � AP7                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

User Function AXCADSZX()

_aArea	:= GetArea()

dbSelectARea("SZP")
dbSetOrder(1)
_cMsg	:= "Contabilizacao PLS - Lancamentos Debitos / Creditos RDA "

axCadastro("SZP",_cMsg,"ExecBlock('EXCLSZX')","ExecBlock('ALTSZX')")

RestArea(_aArea)

Return


User Function ExclSZX()
_lRet	:= .T.
_cMsg	:= 'Esta exclusao podera afetar a contabilizacao.'+CHR(13)+'Tem certeza que deseja excluir?'
If !MsgBox(_cMsg, 'ATENCAO', 'YESNO')
	_lRet	:= .F.
EndIf
Return(_lRet)


User Function ALTSZX()
_lRet	:= .T.

Return(_lRet)
