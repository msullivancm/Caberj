#INCLUDE 'PROTHEUS.CH'
#INCLUDE "RWMAKE.CH"
#INCLUDE "TOPCONN.CH"
#INCLUDE "FONT.CH"
#INCLUDE "TBICONN.CH"


#DEFINE c_ent CHR(13) + CHR(10)

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �CABA006   �Autor  �Angelo Henrique     � Data �  10/09/18   ���
�������������������������������������������������������������������������͹��
���Desc.     � Rotina de atualiza��o da tabela RDA xProduto x Filme       ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � CABERJ                                                     ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

User Function CABA006()
	
	//���������������������������������������������������������������������Ŀ
	//� Declaracao de Variaveis                                             �
	//�����������������������������������������������������������������������
	
	Local cVldAlt := ".T." // Validacao para permitir a alteracao. Pode-se utilizar ExecBlock.
	Local cVldExc := ".T." // Validacao para permitir a exclusao. Pode-se utilizar ExecBlock.
	
	Private cString := "PD3"
	
	dbSelectArea("PD3")
	dbSetOrder(1)
	
	AxCadastro(cString,"RDA x PRODUTO x FILME",cVldExc,cVldAlt)
	
Return


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �CABA006A  �Autor  �Angelo Henrique     � Data �  10/09/18   ���
�������������������������������������������������������������������������͹��
���Desc.     � Rotina para validar se o produto e o RDA ja foram          ���
���          �cadastrados anteriormente.                                  ���
�������������������������������������������������������������������������͹��
���Uso       � CABERJ                                                     ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

User Function CABA006A()
	
	Local _aArea	:= GetArea()
	Local _aArPD3	:= PD3->(GetArea())
	Local _lRet 	:= .T.
	
	If !Empty(M->PD3_CODRDA) .And. !Empty(M->PD3_CODPLA)
		
		//Varrer
		If !Empty(M->PD3_VIGDE)
			
			DbSelectArea("PD3")
			DbSetOrder(1)
			If DbSeek(xFilial("PD3") + M->PD3_CODRDA + M->PD3_CODPLA)
				
				While !EOF() .And. M->(PD3_CODRDA+PD3_CODPLA) == PD3->(PD3_CODRDA+PD3_CODPLA)
					
					//---------------------------------------------
					//Validando vig�ncia em aberto
					//---------------------------------------------
					If Empty(PD3->PD3_VIGATE)
						
						_lRet := .F.
						
						Aviso("Aten��o", "Para este RDA e Produto j� existe uma vig�ncia em aberto." , {"OK"})
						
						Exit
						
					EndIf
					
					//------------------------------------------------------------------
					//Validando se a vig�ncia inserida ja esta dentro de outra
					//------------------------------------------------------------------
					If !(Empty(PD3->PD3_VIGATE)) .And. M->PD3_VIGDE < PD3->PD3_VIGATE
						
						_lRet := .F.
						
						Aviso("Aten��o", "Para este RDA e Produto uma vig�ncia ja foi definida dentro desta vig�ncia inicial." , {"OK"})
						
						Exit
						
					EndIf
					
					PD3->(DbSkip())
					
				EndDo
				
			EndIf
			
		EndIf
		
		
	EndIf
	
	RestArea(_aArPD3)
	RestArea(_aArea	)
	
Return _lRet