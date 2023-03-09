#include 'protheus.ch'
#include 'parmtype.ch'

//******************************************************
// Autor: Mateus Medeiros 
// Descrição: Ponto de entrada após a gravação de BD6 e BD7 na importação do XML
// para atribuir o "H" no momento da importação de guias de internação  
// Data: 16/08/2018
//******************************************************
User Function PLSIITE1

	Local cSeqMov:= paramixb[1]
	Local cCodPad:= paramixb[2]
	Local cCodPro:= paramixb[3]
	Local cDesPro:= paramixb[4]
	Local nVlrApr:= paramixb[5]
	Local nQtd	 := paramixb[6]
	Local aTpPar := paramixb[7]
	Local cHorIni:= paramixb[8]
	Local cHorFim:= paramixb[9]
	Local dDtPro := paramixb[10]
	Local cSlvPad:= paramixb[11]
	Local cSlvPro:= paramixb[12]
	Local cSlvDes:= paramixb[13]
	
	if BD6->BD6_TIPGUI=="05" // somente guia de internação 
		_cCntQry := " UPDATE 														" + CRLF
		_cCntQry += " 	" + RetSqlName("BD7") + " BD7 								" + CRLF
		_cCntQry += " SET BD7.BD7_CODTPA = 'H'										" + CRLF

		//-------------------------------------------------------------------------------------------
		//Rotina para acrescentar as informações do where(utilizado em varios pontos desta rotina)
		//-------------------------------------------------------------------------------------------
		_cCntQry += " WHERE 																" + CRLF
		_cCntQry += " 	BD7.BD7_FILIAL = '" + xFilial("BD6") + "'  							" + CRLF
		_cCntQry += " 	AND BD7.BD7_CODOPE = '" + BD6->BD6_CODOPE + "' 						" + CRLF
		_cCntQry += " 	AND BD7.BD7_CODLDP = '" + BD6->BD6_CODLDP + "' 						" + CRLF
		_cCntQry += " 	AND BD7.BD7_CODPEG = '" + BD6->BD6_CODPEG + "' 						" + CRLF
		_cCntQry += " 	AND BD7.BD7_NUMERO = '" + BD6->BD6_NUMERO + "' 						" + CRLF
		_cCntQry += " 	AND BD7.BD7_ORIMOV = '" + BD6->BD6_ORIMOV + "' 						" + CRLF
		_cCntQry += " 	AND BD7.D_E_L_E_T_ = ' '											" + CRLF
		
		TcSqlExec(_cCntQry) 
		
	ELSEIF  BD6->BD6_TIPGUI=="02"
		  	
		BD7->(DbSetOrder(1))
		aBD7 := PLSCOMEVE(BD6->BD6_CODTAB,BD6->BD6_CODPAD,BD6->BD6_CODPRO,BD6->BD6_CODOPE,BD6->BD6_DATPRO,BD6->BD6_TIPGUI)
	 	
	 	For nX := 1 to Len(aBd7)
		 	BD7->(DbSetOrder(1))
		 	If !BD7->(MsSeek(xFilial('BD6')+BD6->(BD6_CODOPE+BD6_CODLDP+BD6_CODPEG+BD6_NUMERO+BD6_ORIMOV+BD6_SEQUEN+aBD7[nX][1])))
			 	PLS720IBD7('',BD6->BD6_VLPGMA,BD6->BD6_CODPAD,BD6->BD6_CODPRO,BD6->BD6_CODTAB,BD6->BD6_CODOPE,BD6->BD6_CODRDA,;
					BD6->BD6_REGEXE,BD6->BD6_SIGEXE,BD6->BD6_ESTEXE,BD6->BD6_CDPFRE,BD6->BD6_CODESP,BD6->(BD6_CODLOC+BD6_LOCAL),"1",BD6->BD6_SEQUEN,;
					BD6->BD6_ORIMOV,BD6->BD6_TIPGUI,BD6->BD6_DATPRO,NIL,aBd7,NIL,NIL,NIL,NIL,NIL,NIL,NIL,NIL,nil,nil,,,NIL)
			Endif   	
		Next nX 
	
	ENDIF

Return