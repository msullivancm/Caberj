#INCLUDE "TOPCONN.CH"
#INCLUDE "RWMAKE.CH"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "TBICONN.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCABA621     บAutor  ณAnderson Rangel   บ Data ณ  JULHO/2021 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Integra a visใo web do Demonstrativo 					  บฑฑ
ฑฑบ            de Anแlise de Conta M้dica com o Protheus                  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CABERJ E INTEGRAL                                          บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function CABA621()

	Private cRda		:= " "
	Private cAno		:= " "
	Private cMes		:= " "
	Private cLinkCab	:= GetNewPar("MV_XVDACM1","https://www.caberj.com.br/seucanal/credenciado/painel/DemonstrativoPagamentoAnalitico/DemonstAnContaMed.asp?panomes=")
	Private cLinkInt	:= GetNewPar("MV_XVDACM3","https://www.integralsaude.com.br/seucanal/credenciado/painel/DemonstrativoPagamentoAnalitico/DemonstAnContaMed.asp?panomes=")
	Private cLink2		:= GetNewPar("MV_XVDACM2","&IdCredenciado=")
	Private cPerg		:= "CABA621"

	//Cria grupo de perguntas
	PCABA621(cPerg)
	
	If Pergunte(cPerg,.T.)
		
		cRda	:= mv_par01
		cAno	:= mv_par02
		cMes	:= mv_par03
		
		If cEmpAnt == "01"
			
			cLinkCab += cAno + cMes + cLink2 + cRda 
			
			If cRda <> " " .and. cAno <> "" .and. cMes <> ""
				Processa({||Sleep(3000)},'Gerando Demonstrativo de Analise de Conta M้dica...')
				ShellExecute("Open", cLinkCab, "", "", 1)
			else
				msgalert("Os parโmetros nใo foram preenchidos corretamente","Aten็ใo")	
			EndIf

		else

			cLinkInt += cAno + cMes + cLink2 + cRda 
			
			If cRda <> " " .and. cAno <> "" .and. cMes <> ""
				Processa({||Sleep(3000)},'Gerando Demonstrativo de Analise de Conta M้dica...')
				ShellExecute("Open", cLinkInt, "", "", 1)
			else
				msgalert("Os parโmetros nใo foram preenchidos corretamente","Aten็ใo")	
			EndIf

		EndIf

	EndIf

Return

*********************************************

Static Function PCABA621(cPerg)

	Local aHelpPor := {} //help da pergunta
	
	aHelpPor := {}
	AADD(aHelpPor,"Informe o 			")
	AADD(aHelpPor,"codido do RDA		")
	
	u_CABASX1(cPerg,"01","RDA ?"	,"a","a","MV_CH1","C",TamSX3("BAU_CODIGO")[1],0,0,"G","","BAUPLS","","","MV_PAR01","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")
	
	aHelpPor := {}
	AADD(aHelpPor,"Informe o Ano  		")
	AADD(aHelpPor,"do Demostrativo		")
	
	u_CABASX1(cPerg,"02","Ano ?"	,"a","a","MV_CH2","C",4,0,0,"G","","","","","MV_PAR02","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")
	
	aHelpPor := {}
	AADD(aHelpPor,"Informe o M๊s  		")
	AADD(aHelpPor,"do Demostrativo		")
	
	u_CABASX1(cPerg,"03","Mes ?"	,"a","a","MV_CH3","C",2,0,0,"G","","","","","MV_PAR03","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")
		
Return
