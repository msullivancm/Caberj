#INCLUDE 'PROTHEUS.CH'

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �CABV015   �Autor  �Leonardo Portella   � Data �  09/12/13   ���
�������������������������������������������������������������������������͹��
���Desc.     �Validacao do modo de edicao do campo BE4_DATPRO, BE4_HORPRO ���
���          �BE4_DTALTA e BE4_HRALTA.                                    ���
���          �Na importacao prestadores enviam data de alta e inicio de   ���
���          �internacao como alta/internacao administrativa e o sistema  ���
���          �altera conforme informado no XML, porem estas nao corres-   ���
���          �pondem a data de alta/internacao reais, sao apenas adminis- ���
���          �trativas.                                                   ���
�������������������������������������������������������������������������͹��
���Uso       �CABERJ                                                      ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

User Function CABV015

//�����������������������������������������������������������������������������������������������������������������������������Ŀ
//�Conforme orientacao de Joana e Agda, solicito acesso para alterar a data de internacao hospitalar para os seguintes usuarios:�
//�                                                                                                                             �
//�Analistas                                                                                                                    �
//�Wallace Oliveira - 000334                                                                                                    �
//�Wallace Viana - 000242                                                                                                       �
//�Carlos Roberto Hing - 000341                                                                                                 �
//�Elizete Batista - 000109                                                                                                     �
//�Patricia Paz - 000110                                                                                                        �
//�Ricardo Augusto Fialho - 000111                                                                                              �
//�Nilda Coelho - 000108                                                                                                        �
//�Marcelo Oliveira - 000778                                                                                                    �
//�Joseane Castro - 000780                                                                                                      �
//�                                                                                                                             �
//�Digitadores                                                                                                                  �
//�Marcio Andre Fernandez - 000299                                                                                              �
//�Walcinea Francisca dos Santos - 000190                                                                                       �
//�������������������������������������������������������������������������������������������������������������������������������

//MV_XALDTAL - ALtera DaTa da ALta
Local cUsrAut 	:= GetMV('MV_XGETIN') + '|' + GetMV('MV_XGERIN') + '|' + GetNewPar('MV_XALDTAL','000334|000242|000341|000109|000110|000111|000108|000778|000780|000299|000190')
Local lEdita	

lEdita	:= ( RetCodUsr() $ cUsrAut ) 

Return lEdita