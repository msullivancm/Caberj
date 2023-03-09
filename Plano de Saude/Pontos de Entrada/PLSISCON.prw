#INCLUDE "Protheus.ch"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณPLSISCON  บAutor  ณLeonardo Portella	 บ Data ณ  28/09/11   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณPonto de entrada na funcao padrao PLSISCON que retorna se o บฑฑ
ฑฑบ          ณprocedimento eh uma consulta ou nao. Fonte padrao da funcao บฑฑ
ฑฑบ          ณPLSISCON: PLSMFUN.PRW. Sintaxe: PLSISCON(cTabela,cCodPro)	  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณCABERJ                                                      บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function PLSISCON

	Local i := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

	Local aConsultas 	:= {allTrim(SuperGetMv("MV_PLSCDCO"))}//Parametro padrao para consulta (somente 1 tabela e procedimento) 
	Local aBuffer 		:= StrTokArr(allTrim(SuperGetMv("MV_XCDCONS")),';')     

	If AllTrim(FunName()) <> "PLSA001"
		If alltrim( GetNewPar("MV_XLOGINT", '0') ) == '1'    
			If FunName() == "PLSA092" 

				u_LogMatInt(M->BE4_USUARI, M->BE4_NOMUSR, "PLSISCON - 1")

			EndIf
		EndIf


		For i := 1 to len(aBuffer)
			If aScan(aConsultas,aBuffer[i]) <= 0
				aAdd(aConsultas,aBuffer[i])
			EndIf
		Next

		If alltrim( GetNewPar("MV_XLOGINT", '0') ) == '1'    
			If FunName() == "PLSA092" 

				u_LogMatInt(M->BE4_USUARI, M->BE4_NOMUSR, "PLSISCON - 2")

			EndIf
		EndIf
	Endif
Return aConsultas
