#include 'rwmake.ch'
/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �AXCADSZZ  �Autor  �Roger Cangianeli    � Data �  05/12/06   ���
�������������������������������������������������������������������������͹��
���Desc.     � Cadastro de Amarracoes Contabeis para Comissoes            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP7                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

User Function AXCADSZR()

_aArea	:= GetArea()

dbSelectARea("SZR")
dbSetOrder(1)
_cMsg	:= "Contabilizacao PLS - Comissoes"

axCadastro("SZR",_cMsg,"ExecBlock('EXCLSZR')","ExecBlock('ALTSZR')")

RestArea(_aArea)

Return


User Function ExclSZR()
_lRet	:= .T.
_cMsg	:= 'Esta exclusao podera afetar a contabilizacao.'+CHR(13)+'Tem certeza que deseja excluir?'
If !MsgBox(_cMsg, 'ATENCAO', 'YESNO')
	_lRet	:= .F.
EndIf
Return(_lRet)


User Function ALTSZR()
_lRet	:= .T.

Return(_lRet)
