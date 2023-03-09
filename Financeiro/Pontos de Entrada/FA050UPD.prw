#Include "Protheus.ch" 

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �FA050UPD  �Autor  �Leonardo Portella   � Data �  04/08/11   ���
�������������������������������������������������������������������������͹��
���Desc.     �PE para validar os usuarios que podem alterar o contas a    ���
���          �pagar que nao tenham sido originados no FINA050 (ou seja,   ���
���          �PLS), conforme solicitacao do Roberto.                      ���
�������������������������������������������������������������������������͹��
���Uso       � CABERJ                                                     ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

User Function FA050UPD

Local lOk := .T.

Private cGETIN 	:= SuperGetMv('MV_XGETIN') 
Private cGERIN	:= SuperGetMv('MV_XGERIN')  

If ALTERA .and. allTrim(Upper(SE2->E2_ORIGEM)) != 'FINA050'
    
    If !RetCodUsr() $ SuperGetMv('MV_XSE2PLS') .and. !( RetCodUsr() $ cGETIN ) .and. !( RetCodUsr() $ cGERIN )
                        
		cMsg := 'N�o � permitido alterar contas a pagar que tenham origem no PLS atrav�s desta rotina!'
		
		Aviso('ATEN��O',cMsg,{'Ok'})
		
		lOk := .F.
		
	EndIf

EndIf


Return lOk