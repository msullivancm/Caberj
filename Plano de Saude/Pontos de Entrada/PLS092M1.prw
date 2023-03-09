#include "PLSMGER.CH"
#include "COLORS.CH"
#include "TOPCONN.CH"
#INCLUDE "plsa090.ch"
#include "PROTHEUS.CH"
#include "PLSMCCR.CH"
#INCLUDE "plsa092.ch"

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �PLS092M1  �Autor  � Mateus Medeiros    � Data �  29/11/2018 ���
�������������������������������������������������������������������������͹��
���Desc.     �Inserir botao para chamada da rotina de clone de autorizacao���
���          �para alteracoes de dados.                                   ���
�������������������������������������������������������������������������͹��
���Uso       � Caberj.                                                    ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

User Function PLS092M1
	
	Local aArea		:= GetArea()
	Local aSubRot   := {}
	
	aSubRot := {'Bloqueio Futuro ?' , 'U_ValBenefFt()'	}
	
	RestArea(aArea)
	
Return(aSubRot)

//Valida Bloqueio futuro benefici�rio
User Function ValBenefFt()
	
	Local lRet := .T.
	//**********************************************************
	// MATEUS MEDEIROS - 27/11/2018 - IN�CIO
	// VALIDA��O DE BLOQUEIO FUTURO DO BENEFICI�RIO
	//**********************************************************
	lRet := PLSA090USR(BE4->(BE4_CODOPE+BE4_CODEMP+BE4_MATRIC+BE4_TIPREG+BE4_DIGITO),dDataBase,BE4->BE4_HORPRO,"BE4")
	
	if lRet
		DbSelectArea("BA1")
		DbSetOrder(2)
		If DbSeek(xFilial("BA1") + BE4->(BE4_CODOPE+BE4_CODEMP+BE4_MATRIC+BE4_TIPREG+BE4_DIGITO))
			
			IF Empty(BA1->BA1_DATBLO) 
				DbSelectArea("BA3")
				DbSetOrder(2) //BA3_FILIAL+BA3_CODPLA+BA3_CODINT+BA3_CODEMP+BA3_MATRIC+BA3_CONEMP+BA3_VERCON+BA3_SUBCON+BA3_VERSUB
				If DbSeek(xFilial("BA3")+BA1->(BA1_CODPLA+BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_CONEMP+BA1_VERCON+BA1_SUBCON+BA1_VERSUB))
					
					If Empty(BA3->BA3_DATBLO)
						
						alert("N�o h� bloqueio previsto para este benefici�rio!")
						
					EndIf
					
				endIf
			endif 
		endif
	endif
	
	
	
	//**********************************************************
	// MATEUS MEDEIROS - 27/11/2018 - FIM
	// VALIDA��O DE BLOQUEIO FUTURO DO BENEFICI�RIO
	//**********************************************************
	
Return
