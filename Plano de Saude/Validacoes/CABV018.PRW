#INCLUDE 'PROTHEUS.CH'

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCABV018   บAutor  ณAngelo Henrique     บ Data ณ  06/08/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRotina que serแ utilizada na rotina padrใo PLSA261.         บฑฑ
ฑฑบ          ณSerแ utilizada para bloquear ou nใo alguns campos no        บฑฑ
ฑฑบ          ณpergunte                                                    บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CABERJ                                                     บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
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
//Se o usuแrio nใo fizer parte do setor de cadastro
//Caso fa็a parte o mesmo deverแ estar cadastrado
//no parโmetro: MV_XPLS26A
//-------------------------------------------------
If !(_cUsu $ _cMvPer)
	
	//----------------------------------------------------------------------------------------------------
	//Valida็ใo do MV_PAR03(Gera cartao agora ?), do MV_PAR05(Local Grav. ?) e do MV_PAR06(Nome Cartao ?)
	//----------------------------------------------------------------------------------------------------
	If _cParam == "1" //MV_PAR03
		
		If MV_PAR03 != _nMvGrCt
			
			Aviso("Aten็ใo", "Usuแrio nใo possui permissใo para alterar este parโmetro, favor restaurar o conte๚do deste parโmetro: " + cValToChar(_nMvGrCt) + " - Op็ใo", {"OK"})
			
			_lRet := .F.
			
		EndIf
		
	ElseIf _cParam == "2" //MV_PAR05
		
		If UPPER(AllTrim(MV_PAR05)) != UPPER(AllTrim(_cMvLcAq)) //MV_PAR05
			
			Aviso("Aten็ใo", "Usuแrio nใo possui permissใo para alterar este parโmetro, favor restaurar o conte๚do deste parโmetro: " + _cMvLcAq, {"OK"})
			
			_lRet := .F.
			
		EndIf
		
	ElseIf _cParam == "3" //MV_PAR06
		
		If MV_PAR06 != _nMvNmCt  
			
			Aviso("Aten็ใo", "Usuแrio nใo possui permissใo para alterar este parโmetro, favor restaurar o conte๚do deste parโmetro: " + cValToChar(_nMvNmCt) + " - Op็ใo", {"OK"})
			
			_lRet := .F.
			
		EndIf
		
	EndIf
	
EndIf

If _cParam == "4"

	//Atualizando para Nใo o parametro de Gerar cartใo agora.
	MV_PAR03 := 2

EndIf

Return _lRet
