
/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �CABA587   �Autor  �Marcela Coimbra     � Data �  05/30/17   ���
�������������������������������������������������������������������������͹��
���Desc.     � Altera parametro que libera consulta ao portal RH          ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                         ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/


User Function CABA587()  
	
	Local cPerg := "CABA587"
	
	PutSx1(cPerg,"01",OemToAnsi("Data de exibicao RH Online")		,"","","mv_ch5","D",08,0,0,"G","","","","","mv_par05","","","","","","","","","","","","","","","","",{"Data para exibi��o do RH Online"},{""},{""})  
	 
	If !Pergunte(cPerg)
	    
		Return
	
	EndIf               
	
	c_dias := allTRIM(STR(( MV_PAR01 - LastDay( MV_PAR01 ) )))
	
	PutMv("MV_TCFDFOL", c_dias)    
	
	Aviso("Aten��o","Data de disponibiliza��o de consulta no RH Online alterada para " + dtoc((LastDay( MV_PAR01 ) + val( getmv("MV_TCFDFOL") ))) + "." ,{"OK"})       
	

Return