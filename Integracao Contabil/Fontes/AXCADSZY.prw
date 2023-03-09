#include 'rwmake.ch'
/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �AXCADSZY  �Autor  �Roger Cangianeli    � Data �  12/01/06   ���
�������������������������������������������������������������������������͹��
���Desc.     � Cadastro de Amarracoes Contabeis para Custos               ���
���          � CONTAS DOS RDAs                                            ���
���          � 16/09/09 -Tabela SZY alterada para SZO                     ���
�������������������������������������������������������������������������͹��
���Uso       � AP7                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

User Function AXCADSZY()

_aArea	:= GetArea()

dbSelectARea("SZO")
dbSetOrder(1)
_cMsg	:= "Contabilizacao PLS - Custos - Credito "

axCadastro("SZO",_cMsg,"ExecBlock('EXCLSZY')","ExecBlock('ALTSZY')")

RestArea(_aArea)

Return


User Function ExclSZY()
_lRet	:= .T.
_cMsg	:= 'Esta exclusao podera afetar a contabilizacao.'+CHR(13)+'Tem certeza que deseja excluir?'
If !MsgBox(_cMsg, 'ATENCAO', 'YESNO')
	_lRet	:= .F.
EndIf
Return(_lRet)


User Function ALTSZY()
_lRet	:= .T.

Return(_lRet)
