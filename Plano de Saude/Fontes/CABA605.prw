#INCLUDE 'PROTHEUS.CH'

#DEFINE cEnt chr(10)+chr(13)

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �CABA605   �Autor  � Angelo Henrique    � Data �  24/01/18   ���
�������������������������������������������������������������������������͹��
���Desc.     �Rotina utilizada para incluir nos dados unificados as       ���
���          �informa��es do protocolo de atendimento para atualiza��o    ���
���          �de cadastro do benefici�rio.                                ���
�������������������������������������������������������������������������͹��
���Uso       � CABERJ                                                     ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

User Function CABA605()
	
	Local _aArea 	:= GetArea()
	Local _aArBA1	:= BA1->(GetArea())
	Local _aArSZZ	:= SZZ->(GetArea())
	Local _aArSZX	:= SZX->(GetArea())
	Local _aArSZY	:= SZY->(GetArea())
	Local _cMsg		:= ""
	
	//------------------------------------------------------
	//Criando aqui a tela dos dados unificados.
	//------------------------------------------------------			
	RecLock("SZZ",.T.)
	
	SZZ->ZZ_SEQUEN 	:= ProxReg()
	SZZ->ZZ_TIPALT 	:= "3" //1=Cliente;2=Vida;3=Ambos
	SZZ->ZZ_USRCAD 	:= CUSERNAME
	SZZ->ZZ_HORCAD 	:= Time()
	SZZ->ZZ_DATCAD 	:= Date()   
	SZZ->ZZ_STATUS 	:= "1" //Cadastrado
	SZZ->ZZ_EMAIL	:= AllTrim(SZX->ZX_EMAIL) 
	SZZ->ZZ_NOME	:= AllTrim(SZX->ZX_NOMUSR)
	SZZ->ZZ_CGC		:= POSICIONE("BA1",2,xFilial("BA1") + SZX->(ZX_CODINT + ZX_CODEMP + ZX_MATRIC + ZX_TIPREG + ZX_DIGITO),"BA1_CPFUSR")
	SZZ->ZZ_CODVID	:= POSICIONE("BA1",2,xFilial("BA1") + SZX->(ZX_CODINT + ZX_CODEMP + ZX_MATRIC + ZX_TIPREG + ZX_DIGITO),"BA1_MATVID")
	
	SZZ->(MsUnLock())
	
	_cMsg := "Atualiza��o de Dados Unificados inclu�da com sucesso." + cEnt	
			
	Aviso("Aten��o",_cMsg,{"OK"})
	
	MsUnLockAll()
	
	RestArea(_aArSZY)
	RestArea(_aArSZX)
	RestArea(_aArSZZ)
	RestArea(_aArBA1)
	RestArea(_aArea )
	
Return



/*/
���������������������������������������������������������������������������
���������������������������������������������������������������������������
�����������������������������������������������������������������������Ŀ��
���Funcao    � ProxReg � Autor � Thiago Machado Correa� Data � 23.02.08 ���
�����������������������������������������������������������������������Ĵ��
���Descricao � Retorna proximo codigo sequencial 			            ���
������������������������������������������������������������������������ٱ�
���������������������������������������������������������������������������
���������������������������������������������������������������������������
/*/
Static Function ProxReg()
	
	Local cRet := ""
	Local cSql := ""
		
	cSql := " SELECT MAX(TO_NUMBER(TRIM(ZZ_SEQUEN))) SEQ FROM " + RetSqlName("SZZ")
	cSql += " WHERE ZZ_FILIAL = '" + xFilial("SZZ") + "' AND D_E_L_E_T_ <> '*' "
	
	PLSQuery(cSql,"SZZSEQ")	
	
	cRet := StrZero((SZZSEQ->SEQ+1),8)
	
	SZZSEQ->(DbCloseArea())
	
Return cRet