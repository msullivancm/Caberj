#INCLUDE 'PROTHEUS.CH'

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �CABV018   �Autor  �Angelo Henrique     � Data �  06/08/15   ���
�������������������������������������������������������������������������͹��
���Desc.     �Rotina que ser� utilizada na rotina padr�o PLSA261.         ���
���          �Ser� utilizada para bloquear ou n�o alguns campos no        ���
���          �pergunte                                                    ���
�������������������������������������������������������������������������͹��
���Uso       � CABERJ                                                     ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

User Function  CABV018(_cParam)

Local _lRet 	:= .T.
Local _aUsu 	:= PswRet()
Local _cUsu 	:= _aUsu[1][1] //Codigo do usuario
Local _cMvPer   := GetNewPar("MV_XPLS26A","000000")
Local _nMvGrCt	:= GetNewPar("MV_XPLS26B",2)
Local _cMvLcAq	:= GetNewPar("MV_XPLS26C","c:\cartao\emitido\")
Local _nMvNmCt	:= GetNewPar("MV_XPLS26D",2)

Default _cParam	:= "1"

//-------------------------------------------------
//Se o usu�rio n�o fizer parte do setor de cadastro
//Caso fa�a parte o mesmo dever� estar cadastrado
//no par�metro: MV_XPLS26A
//-------------------------------------------------
If !(_cUsu $ _cMvPer)
	
	//----------------------------------------------------------------------------------------------------
	//Valida��o do MV_PAR03(Gera cartao agora ?), do MV_PAR05(Local Grav. ?) e do MV_PAR06(Nome Cartao ?)
	//----------------------------------------------------------------------------------------------------
	If _cParam == "1" //MV_PAR03
		
		If MV_PAR03 != _nMvGrCt
			
			Aviso("Aten��o", "Usu�rio n�o possui permiss�o para alterar este par�metro, favor restaurar o conte�do deste par�metro: " + cValToChar(_nMvGrCt) + " - Op��o", {"OK"})
			
			_lRet := .F.
			
		EndIf
		
	ElseIf _cParam == "2" //MV_PAR05
		
		If UPPER(AllTrim(MV_PAR05)) != UPPER(AllTrim(_cMvLcAq)) //MV_PAR05
			
			Aviso("Aten��o", "Usu�rio n�o possui permiss�o para alterar este par�metro, favor restaurar o conte�do deste par�metro: " + _cMvLcAq, {"OK"})
			
			_lRet := .F.
			
		EndIf
		
	ElseIf _cParam == "3" //MV_PAR06
		
		If MV_PAR06 != _nMvNmCt  
			
			Aviso("Aten��o", "Usu�rio n�o possui permiss�o para alterar este par�metro, favor restaurar o conte�do deste par�metro: " + cValToChar(_nMvNmCt) + " - Op��o", {"OK"})
			
			_lRet := .F.
			
		EndIf
		
	EndIf
	
EndIf

If _cParam == "4"

	//Atualizando para N�o o parametro de Gerar cart�o agora.
	MV_PAR03 := 2

EndIf

Return _lRet
