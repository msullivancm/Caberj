#INCLUDE 'PROTHEUS.CH'
      
/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �PLS766GRV �Autor  �Leonardo Portella   � Data �  21/09/11   ���
�������������������������������������������������������������������������͹��
���Desc.     �Gravacao do campo BA1_XTPBEN para identificar os casos de   ���
���          �reciprocidade gerados pela rotina de atendimento.           ���
���          �                                                            ���
���          �(PLS>Atualizacoes>Marcacao Consulta>Agenda Medica)          ���
�������������������������������������������������������������������������͹��
���Uso       � CABERJ                                                     ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

User Function PLS766GRV

BA1->(RecLock('BA1',.F.))

BA1->BA1_XTPBEN	:= 'RECIPR'

//Leonardo Portella - 07/11/11 - Usuario de reciprocidade nao deve ter matricula antiga pois a mesma eh de outra empresa e, caso exista
//uma matricula igual na empresa atual, a informacao estara incorreta, o que estava acontecendo na Liberacao.
BA1->BA1_MATANT	:= ' '

BA1->(MsUnlock())

Return