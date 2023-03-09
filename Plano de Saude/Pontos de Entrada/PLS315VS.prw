
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³PLS315VS  ºMotta  ³Caberj              º Data ³  04/02/11   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³  Ponto de Entrada PLS315VS na função ValidStatu, após a    º±±
±±º          ³  verificação de status do paciente.                        º±±
±±º          ³  Objetivo: Permite o controle da mudança de status de      º±±
±±º          ³  um paciente agendado na funcionalidade de recepção.       º±±
±±º          ³                                                            º±±
±±º          ³  Avisar se um Paciente é de algum Programa AED/AAG         º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß  

Ponto de Entrada PLS315VS na função ValidStatu, após a verificação de status do paciente. 

Objetivo: Permite o controle da mudança de status de um paciente agendado na funcionalidade de recepção.
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
