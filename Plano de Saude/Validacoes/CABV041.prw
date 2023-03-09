#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'RWMAKE.CH'
#INCLUDE "TOPCONN.CH"
#INCLUDE "TBICONN.CH"

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  � CABV041  �Autor  �Mateus Medeiros     � Data �  17/01/2018 ���
�������������������������������������������������������������������������͹��
���Desc.     �Valida��o criada para for�ar a data da solicita��o na be4    ��
���          �� Fun��o chamada no valid do campo BE4_GUIINT                ��
�������������������������������������������������������������������������͹��
���Uso       �CABERJ                                                      ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

User Function CABV041(cConteudo)
	
	Local _aArea	:= GetArea()
	Local _aArBE4	:= BE4->(GetArea())
	Local _lRet		:= .T.
	
	Local dData     := ""
	//********************************************************************************************
	// Variavel publica criada para controle do posicionamento da BE4, 
    // Devido a fun��o padr�o PLS498vls de valida��o do campo BE4_GUIINT, executar 
    // primeiro os gatilhos do campo  BE4_USUARI, e posteiormente o gatilho do campo BE4_GUIINT
    // levando a informa��o incorreta para o campo BE4_YDTSOL. 
	//********************************************************************************************
	Public x_xxGuiSol :=  "" 
	
	x_xxGuiSol := iif(cvaltochar(M->BE4_GUIINT) == cConteudo,M->BE4_GUIINT,x_xxGuiSol) 
	//********************************************************************************************
	//_lRet := PLS498vls(cConteudo)                                                                      
	
	RestArea(_aArBE4)
	RestArea(_aArea	)
	
Return lRet


User Function RetDat(cConteudo)

	Local _aArea	 := GetArea()
	Local _aArBE4	 := BE4->(GetArea())
	Local nTmSenha   := TamSx3("BE4_SENHA")[1]
	Local nTam		 := LEN(M->(BE4_FILIAL+BE4_CODOPE+BE4_ANOINT+BE4_MESINT+BE4_NUMINT))
	Local dData      := ctod(" / / ")
	Local x_xxGuiSol := ""  	

	x_xxGuiSol := iif(cvaltochar(x_xxGuiSol) # cConteudo,x_xxGuiSol,cConteudo) 
	
	BE4->(DbSetORder(2))//BE4_FILIAL + BE4_CODOPE + BE4_ANOINT + BE4_MESINT + BE4_NUMINT
	If BE4->(MsSeek(xFilial("BE4")+padr(x_xxGuiSol,nTam)))
		dData := BE4->BE4_DTDIGI
	Else
		BE4->( DbSetOrder(7) )//BE4_FILIAL + BE4_SENHA
		If BE4->(MsSeek(xFilial("BE4")+padr(x_xxGuiSol,nTmSenha)))
			dData   := BE4->BE4_DTDIGI
		Endif
	Endif
	
//Zera o Recno para que nao seja restaurado incorretamente caso o valid do campo seja acionado sem a consulta padrao
//__nRecBE4 := 0
	
	RestArea(_aArBE4)
	RestArea(_aArea	)
	
Return dData