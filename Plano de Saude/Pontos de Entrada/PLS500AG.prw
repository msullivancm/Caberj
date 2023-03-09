#include 'Protheus.ch' 

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �PLS500AG  �Autor  �Leonardo Portella   � Data �  22/07/13   ���
�������������������������������������������������������������������������͹��
���Desc.     �PE na analise de glosas. Visa liberar a coparticipacao.     ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � CABERJ                                                     ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

User Function PLS500AG

Local cAcao   	:= paramixb[1]//1=Glosar;2=Reconsiderar  
Local cSequen 	:= paramixb[2]//Sequencia do evento na guia
Local lprocessa	:= .T.
Local aArea		:= GetArea()
Local aAreaBD6	:= BD6->(GetArea())

BD6->(DbSetOrder(1))

If BD6->(MsSeek(xFilial('BD6') + BDX->(BDX_CODOPE + BDX_CODLDP + BDX_CODPEG + BDX_NUMERO + BDX_ORIMOV) + cSequen))

	//���������������������������������������������������������������������������������������������Ŀ
	//�Desbloquear quando for reconsiderado e tiver valor maior que zero. Conforme informado pela   �
	//�Marcia, se o sistema calcula um valor de coparticipacao maior que zero entao ja passou pelos �
	//�niveis de validacao, inclusive o PLSRETCP.                                                   �
	//�����������������������������������������������������������������������������������������������
	
	If ( cAcao == '2' ) .and. ( BD6->BD6_BLOCPA == '1' ) .and. ( BD6->BD6_VLRTPF > 0 )
		
		//�����������������������������������������������������������������������������������������������Ŀ
		//�Obs: Caso o analista de Contas Medicas nao deseje pagar esta coparticipacao, a mesma devera ser�
		//�bloqueada no nivel de usuario e assim o sistema calculara zero para coparticipacao e nao       �
		//�entrara aqui.                                                                                  �
		//�������������������������������������������������������������������������������������������������
	
		//���������������������������������������������������������������������Ŀ
		//�Sistema recalcula o BD6_VLRTPF caso tenha reconsiderado parcialmente.�
		//�����������������������������������������������������������������������

		BD6->(Reclock('BD6',.F.))
	
		BD6->BD6_BLOCPA := '0'
		
		BD6->(MsUnlock())
		
	EndIf
	
EndIf
	
BD6->(RestArea(aAreaBD6))
RestArea(aArea)

Return lprocessa