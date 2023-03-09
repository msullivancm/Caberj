/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �PL365ROT  �Autor  �Leonardo Portella   � Data �  05/10/11   ���
�������������������������������������������������������������������������͹��
���Desc.     �Ponto de entrada para permitir que somente os usuarios con- ���
���          �tidos em um dos parametros MV_XGETIN,MV_XGERIN ou MV_XRDACOM���
���          �possam alterar o complemento do RDA. GETIN e GERIN tem      ��� 
���          �acesso a alterar sempre.      					          ���
�������������������������������������������������������������������������͹��
���Uso       �CABERJ                                                      ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

User Function PL365ROT

Local nOpcao 	:= 4 //Alterar
Local cCodUsr 	:= RetCodUsr()
           
Private cGETIN 		:= SuperGetMv('MV_XGETIN') 
Private cGERIN 		:= SuperGetMv('MV_XGERIN')  
Private cAltComRDA	:= SuperGetMv('MV_XRDACOM')

//����������������������������������������������������������������Ŀ
//�Validacao no browse do RDA - Cadastro - para validar usuario que�
//�tem direito a alterar o RDA atraves da opcao Complemento.       �
//������������������������������������������������������������������

If !( cCodUsr $ cAltComRDA ) .and. !( cCodUsr $ cGETIN ) .and. !( cCodUsr $ cGERIN )
   	nOpcao := 2 //Visualizar
	Aviso('ATEN��O','Somente ser� permitido visualizar este prestador.',{'Ok'})
EndIf

Return nOpcao