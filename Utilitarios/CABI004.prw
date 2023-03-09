
/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �CABI004   �Autor  �Microsiga           � Data �  24/02/17   ���
�������������������������������������������������������������������������͹��
���Desc.     � Catilho e inlcude executado em campos do cadastro          ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

#INCLUDE 'PROTHEUS.CH'
#INCLUDE "RWMAKE.CH"
#INCLUDE "TOPCONN.CH"


User Function CABI004( c_Tipo )   

	Local c_Ret := ""   
    
    If c_Tipo == "P"// campo de Plano
	      
		if cEmpAnt == '01' .AND. m->BA3_CODEMP == '0024' .and. m->BA3_CODPLA $ '0112||0113||0114||0115' 
		
			If m->BA3_CODPLA $ '0112||0114'  
			
		   		c_Ret := IIF( m->ba1_tipusu == 'T', '0112', '0114' )
			
			ElseIf m->BA3_CODPLA $ '0113||0115'  
	
				c_Ret := IIF( m->ba1_tipusu == 'T', '0113', '0115' )
			
			Else
	
				c_Ret := m->BA3_CODPLA
	
			EndIf    
			
		Else
	
			c_Ret	:= M->BA3_CODPLA  
		
		EndIf   
	
		M->BA3_CODPLA 	:= c_Ret
	
	Else // campo de versao
	     
		c_Ret := "001"
	
	EndIf  

Return c_Ret