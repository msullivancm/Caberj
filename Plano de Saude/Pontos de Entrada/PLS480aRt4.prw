	
/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �PLS480aRt4�Autor  �Marcela Coimbra     � Data �  02/03/10   ���
�������������������������������������������������������������������������͹��
���Desc.     � Ponto de entrada executado antes de montar o menu da       ���
���          � rotina PLSA480 respons�vel por inclus�o de botoes no       ���
���          � menu.                                                      ���
���          � Altera a chamada das fun��es de inclusao/Altera�ao/Exclu-  ���
���          � s�o para tratamento de log.                                ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � CABERJ                                                     ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

User Function PLS480aRt4()

Local l_Continua := "S"

n_PosI:= Ascan( aRotina,{|x|Alltrim(x[2])=='AxInclui'})
n_PosA:= Ascan( aRotina,{|x|Alltrim(x[2])=='AxAltera'})
n_PosD:= Ascan( aRotina,{|x|Alltrim(x[2])=='AxDeleta'})   

l_Continua := GetNewPar("MV_XPLS48", "S") // Parametro responsavel por desabilitar rotina de log
If l_Continua == "N"
    Return                                       
EndIf

If ProcName(2) == "PL480COP"
	
	If n_PosI > 0   
	
		aRotina[n_PosI][2] := "u_A_PLS480aRt4('I')"
	    
	EndIf     
	
	If n_PosA > 0   
	
		aRotina[n_PosA][2] := "u_A_PLS480aRt4('A')"
	    
	EndIf                                
	
	If n_PosD > 0   

		aRotina[n_PosD][2] := "u_A_PLS480aRt4('E	')"
	    
	EndIf     

EndIf
	      
Return 


// Func��o respons�vel por criar o vetor para gera��o de Log
User Function A_PLS480aRt4(c_Tipo,cAlias,cRecNo)

Local a_Vet 	:= {}                       
Local cCodOpe  	:= PLSINTPAD()

cAlias 			:= "BHK"

dbSelectArea("BHK")               

a_vet := 		{{ "PA0_TIPO"	, c_Tipo 	},;
				{ "PA0_ROTINA"	, FunName() },;
				{ "PA0_CODUSU"	, __cUserId },;
				{ "PA0_USRRED"	, GetComputerName()	},;
				{ "PA0_DATA"	, date() 	},;
				{ "PA0_HORA"	, time() 	},;
				{ "PA0_NUMREC"	, "" 	},;
				{ "PA0_TABELA"	, cAlias 	},;
				{ "PA0_FILIAL"	, cFilAnt 	}}
	

dbSelectArea("BIQ")
DbSetOrder(1)
DbSeek(xFilial("BIQ")+cCodOpe+cAlias)

If c_Tipo == "I" 

	n_Escolha := AxInclui(cAlias,cRecNo,3)
	
	If n_Escolha == 1 .AND. BIQ->BIQ_INCLUI == "1"
		u_B_PLS480ATR4( a_Vet, BHK->( Recno() ) )
	EndIf


ElseIf c_Tipo == "A" 

	n_Escolha := AxAltera(cAlias,cRecNo,4)
	
	If n_Escolha == 1 .AND. BIQ->BIQ_ALTERA == "1"
		u_B_PLS480ATR4( a_Vet, BHK->( Recno() )  )
	EndIf
          
Else         

	n_Escolha := AxDeleta(cAlias,cRecNo,5)
	
	If n_Escolha == 2 .AND. BIQ->BIQ_EXCLUS == "1"
		u_B_PLS480ATR4( a_Vet, BHK->( Recno() )  )
	EndIf
       
Endif        
             
Return         


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �B_PLS480ATR4   �Autor  �Marcela Coimbra     � Data �  03/03/10   ���
�������������������������������������������������������������������������͹��
���Desc.     � Grava na tabela PA0 as movimenta�oes informadas por para-  ���
���          � metro.                                                     ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � CABERJ                                                     ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/                          

User Function B_PLS480ATR4( a_Vet, c_Recno )

cSeq := PLBX1NEW()      

BX1->(RecLock("BX1",.T.))

	BX1->BX1_FILIAL   	:= xFilial("BX1")
	BX1->BX1_SEQUEN   	:= cSeq
	BX1->BX1_ALIAS    	:= a_vet[8][2]
	BX1->BX1_RECNO    	:= strzero(c_Recno, 10)
	BX1->BX1_TIPO     	:= a_vet[1][2]
	BX1->BX1_USUARI   	:= USRFULLNAME(a_vet[3][2])
	BX1->BX1_DATA     	:= a_vet[5][2]
	BX1->BX1_HORA     	:= a_vet[6][2]
	BX1->BX1_ESTTRB   	:= a_vet[4][2]
	BX1->BX1_ROTINA 	:= a_vet[2][2]
	
BX1->(MsUnLock())        

MSUnLock()
	
Return