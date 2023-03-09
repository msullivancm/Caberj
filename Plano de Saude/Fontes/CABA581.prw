#INCLUDE 'PROTHEUS.CH'

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �CABA581   �Autor  �Angelo Henrique     � Data �  11/03/16   ���
�������������������������������������������������������������������������͹��
���Desc.     � Rotina de atualiza��o da tabela Tipo de Servi�o x Historico���
���          � Padr�o (PCE).                                              ���
�������������������������������������������������������������������������͹��
���Uso       � CABERJ                                                     ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

User Function CABA581()

//���������������������������������������������������������������������Ŀ
//� Declaracao de Variaveis                                             �
//�����������������������������������������������������������������������

Local cVldAlt := "U_CABA581A()"     // Validacao para permitir a inclus�o/alteracao.
Local cVldExc := ".T."              // Validacao para permitir a exclusao. Pode-se utilizar ExecBlock.

Private cString := "PCE"

dbSelectArea("PCE")
dbSetOrder(1)

AxCadastro(cString,"Cadasto Tipo de Servi�os x Historico Padr�o(Protocolo de Atendimento)",cVldExc,cVldAlt)

Return


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  � CABA581A �Autor  � Fred O. C. Jr      � Data �  23/09/21   ���
�������������������������������������������������������������������������͹��
���Desc.     �    Validar quem pode alterar/incluir registros             ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                         ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function CABA581A

Local lRet      := .T.
Local cGETIN    := SuperGetMv('MV_XGETIN')  // Usu�rio de TI (GETIN)
Local cUsLib    := SuperGetMv('MV_XPASRVH') // Usu�rio liberado para inclus�o/altera��o da rotina

if !(__cUserID $ cGETIN) .and. !(__cUserID $ cUsLib)

    lRet    := .F.
    Aviso('ATEN��O', 'Usu�rio n�o habilitado a executar esta rotina. Entrar em contato com a GEATE.', {'Ok'})

endif

return lRet
