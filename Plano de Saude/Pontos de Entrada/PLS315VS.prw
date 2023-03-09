
/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �PLS315VS  �Motta  �Caberj              � Data �  04/02/11   ���
�������������������������������������������������������������������������͹��
���Desc.     �  Ponto de Entrada PLS315VS na fun��o ValidStatu, ap�s a    ���
���          �  verifica��o de status do paciente.                        ���
���          �  Objetivo: Permite o controle da mudan�a de status de      ���
���          �  um paciente agendado na funcionalidade de recep��o.       ���
���          �                                                            ���
���          �  Avisar se um Paciente � de algum Programa AED/AAG         ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                         ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������  

Ponto de Entrada PLS315VS na fun��o ValidStatu, ap�s a verifica��o de status do paciente. 

Objetivo: Permite o controle da mudan�a de status de um paciente agendado na funcionalidade de recep��o.
.Programa Fonte
*/

User Function PLS315VS()
                                                            
LOCAL lRet      := .T. 
LOCAL lTemAED   := .F.            
LOCAL cMat315   := " "

cMat315 := Substr(BBD->BBD_CODPAC,1,16) 

If BF4->(MsSeek(xFilial("BF4")+cMat315))
	While BF4->(BF4_CODINT+BF4_CODEMP+BF4_MATRIC+BF4_TIPREG) == cMat315 .And. !BF4->(Eof())
		If BF4->BF4_CODPRO $ GetNewPar("MV_YPLAED","0024,0038,0041")
			
			If Empty(BF4->BF4_DATBLO) .Or. (!Empty(BF4->BF4_DATBLO) .And. (BF4->BF4_DATBLO > dDataBase))
				If BI3->(MsSeek(xFilial("BI3")+BF4->BF4_CODINT+BF4->BF4_CODPRO))
					cProjeto := AllTrim(BI3->BI3_NREDUZ)+", "
				EndIf
				
				lTemAED := .T.
			Endif
		Endif
		BF4->(DbSkip())
	Enddo
Endif

If lTemAED
	Aviso( "Usuario Cadastrado em Projeto","A T E N C A O! Este usuario e participante do projeto "+cProjeto+"!!!",{ "Ok" }, 2 )
Endif

Return lRet
