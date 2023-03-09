#INCLUDE "RWMAKE.CH"
#include "PLSMGER.CH"
#include "COLORS.CH"
#include "TOPCONN.CH"                                                                              
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณPLS090CAN บAutor  ณMicrosiga           บ Data ณ  13/11/06   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณPonto de entrada para exibir tela de motivo de cancelamento บฑฑ
ฑฑบ          ณao cancelar uma liberacao.                                  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function PLS090CAN() 

Local aArea	:= GetArea()
Local cPerg := "CAN09X"
Local _cDesc1 := ""
Local _cDesc2 := ""
Local _cDesc3 := ""  

If BEA->( FieldPos("BEA_YDESC1") ) <> 0 
	// Mateus Medeiros - 17/05/2018 - Inํcio
	If (Alltrim(FunName()) == "PLSA094B") .or. (Alltrim(FunName()) == "TMKA271")
		if Alltrim(BEA->BEA_USUOPE) == "OPERAT" 
			MsgStop("Opera็ใo nใo permitida. Esta solicita็ใo foi realizada pelo portal da Operativa. Solicite o prestador o cancelamento pelo portal da Operativa.")
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
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCriaSX1   บAutor  ณMicrosiga           บ Data ณ  09/18/08   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function CriaSX1(cPerg)

PutSx1(cPerg,"01",OemToAnsi("Obs. Canc. linha 1: ")	,"","","mv_ch1","C",50,0,0,"G","naovazio","","","","mv_par01","","","","","","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"02",OemToAnsi("Obs. Canc. linha 2: ")	,"","","mv_ch2","C",50,0,0,"G","","","","","mv_par02","","","","","","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"03",OemToAnsi("Obs. Canc. linha 3: ")	,"","","mv_ch3","C",50,0,0,"G","","","","","mv_par03","","","","","","","","","","","","","","","","",{},{},{})

Return