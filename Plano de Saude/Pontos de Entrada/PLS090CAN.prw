#INCLUDE "RWMAKE.CH"
#include "PLSMGER.CH"
#include "COLORS.CH"
#include "TOPCONN.CH"                                                                              
/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �PLS090CAN �Autor  �Microsiga           � Data �  13/11/06   ���
�������������������������������������������������������������������������͹��
���Desc.     �Ponto de entrada para exibir tela de motivo de cancelamento ���
���          �ao cancelar uma liberacao.                                  ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                         ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

User Function PLS090CAN() 

Local aArea	:= GetArea()
Local cPerg := "CAN09X"
Local _cDesc1 := ""
Local _cDesc2 := ""
Local _cDesc3 := ""  

If BEA->( FieldPos("BEA_YDESC1") ) <> 0 
	// Mateus Medeiros - 17/05/2018 - In�cio
	If (Alltrim(FunName()) == "PLSA094B") .or. (Alltrim(FunName()) == "TMKA271")
		if Alltrim(BEA->BEA_USUOPE) == "OPERAT" 
			MsgStop("Opera��o n�o permitida. Esta solicita��o foi realizada pelo portal da Operativa. Solicite o prestador o cancelamento pelo portal da Operativa.")
			Return
		endif  
	endif 
	// Mateus Medeiros - 17/05/2018 - Fim
	
	CriaSX1(cPerg)
	Pergunte(cPerg,.T.)
	
	_cDesc1 := mv_par01
	_cDesc2 := mv_par02
	_cDesc3 := mv_par03
	
	//Bianchini - 14/10/2013 - Vesao 10
	//If (Alltrim(FunName()) == "PLSA094B")
	
	//Bianchini - 14/10/2013 - Vesao 11
	If (Alltrim(FunName()) == "PLSA094B") .or. (Alltrim(FunName()) == "TMKA271")
		
			BEA->(RecLock("BEA",.F.))
			BEA->BEA_YDTCAN := dDataBase 
			BEA->BEA_YHRCAN := StrTran(Time(),":","")
			BEA->BEA_YUSCAN := cUserName		
			BEA->BEA_YDESC1 := _cDesc1
			BEA->BEA_YDESC2 := _cDesc2
			BEA->BEA_YDESC3 := _cDesc3
			BEA->(MsUnlock())
		
	Else
		BE4->(RecLock("BE4",.F.))
		BE4->BE4_YDTCAN := dDataBase     
		BE4->BE4_YHRCAN := StrTran(Time(),":","")
		BE4->BE4_YUSCAN := cUserName		
		BE4->BE4_YDESC1 := _cDesc1
		BE4->BE4_YDESC2 := _cDesc2
		BE4->BE4_YDESC3 := _cDesc3
		BE4->(MsUnlock())	

	Endif
	
Endif

RestArea(aArea)

Return 



/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �CriaSX1   �Autor  �Microsiga           � Data �  09/18/08   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function CriaSX1(cPerg)

PutSx1(cPerg,"01",OemToAnsi("Obs. Canc. linha 1: ")	,"","","mv_ch1","C",50,0,0,"G","naovazio","","","","mv_par01","","","","","","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"02",OemToAnsi("Obs. Canc. linha 2: ")	,"","","mv_ch2","C",50,0,0,"G","","","","","mv_par02","","","","","","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"03",OemToAnsi("Obs. Canc. linha 3: ")	,"","","mv_ch3","C",50,0,0,"G","","","","","mv_par03","","","","","","","","","","","","","","","","",{},{},{})

Return