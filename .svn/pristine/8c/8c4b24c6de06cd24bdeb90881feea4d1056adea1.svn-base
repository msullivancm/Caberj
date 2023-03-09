#include "protheus.ch"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณExpLivro  บAutor  ณRafael Fernanedes   บ Data ณ  31/01/13   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ  Programa resposแvel pela gera็ใo do orientador m้dico.    บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function ExpLivro()

Local aCabExcel :={}
Local aItensExcel :={}
Private cEnt := chr(13)+chr(10)
aHelpPor := {"Informe a Rede de Atendimento"}
aHelpEng := {"Informe a Rede de Atendimento"}
aHelpSpa := {"Informe a Rede de Atendimento"}
cHelp := "Informe a rede de atendimento"
PutSX1("EXPLIVRO","01","Rede De?" ,"","","MV_CH1","C",02,0,0,"G","","B46PLS","","S","MV_PAR01","","","","","","","","","","","","","","","","",aHelpPor,aHelpEng,aHelpSpa,cHelp)
PutSX1("EXPLIVRO","02","Rede At้?","","","MV_CH1","C",02,0,0,"G","","B46PLS","","S","MV_PAR02","","","","","","","","","","","","","","","","",aHelpPor,aHelpEng,aHelpSpa,cHelp)

WHILE .T.
	
	If Pergunte("EXPLIVRO",.T.)
		
		If !Empty(MV_PAR01) .and. !Empty(MV_PAR01)
			If MV_PAR01 > MV_PAR02
				alert("O primeiro parโmetro deve ser menor que o segundo!")
			Else
				Exit
			EndIf
		Else
			Alert("Rede de atendimento nใo preenchida!")
		EndIf
	Else
		Return
	EndIf
EndDo

//AADD(aCabExcel, {"TITULO DO CAMPO", "TIPO", NTAMANHO, NDECIMAIS})
AADD(aCabExcel, {"REDE" ,"C", 40, 0})
AADD(aCabExcel, {"RAZAO_SOCIAL" ,"C", 40, 0})
AADD(aCabExcel, {"ESPECIALIDADE" ,"C", 30, 0})
AADD(aCabExcel, {"ENDERECO" ,"C", 60, 0})
AADD(aCabExcel, {"NOME_BAIRRO" ,"C", 20, 0})
AADD(aCabExcel, {"NOME_MUNICIPIO" ,"C", 20, 0})
AADD(aCabExcel, {"UF" ,"C", 2, 0})
AADD(aCabExcel, {"DDD" ,"C", 2, 0})
AADD(aCabExcel, {"TELEFONES","C", 30, 0})
AADD(aCabExcel, {"X","C", 5, 0})


If MsgYesNo("Deseja gerar os dados com os parโmetros informados?")
	MsgRun("Favor Aguardar.....", "Selecionando os Registros",{|| ProcItens(aCabExcel, @aItensExcel)})
	
	MsgRun("Favor Aguardar.....", "Exportando os Registros para o Excel",;
	{||DlgToExcel({{"GETDADOS","ORIENTADOR MษDICO",aCabExcel,aItensExcel}})})
EndIf
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNOVO4     บAutor  ณMicrosiga           บ Data ณ  01/31/13   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function ProcItens(aHeader, aCols)

Local aItem
Local nX
Local cQuery := ""


cQuery := " SELECT DISTINCT "
cQuery += " 	BI5_DESCRI AS REDE, BAU_NOME AS RAZAO_SOCIAL , BAQ_DESCRI ESPECIALIDADE, BB8_END ENDERECO, BB8_BAIRRO NOME_BAIRRO, "
cQuery += " 	BB8.BB8_MUN AS NOME_MUNICIPIO , BB8_EST AS UF , BB8_DDD AS DDD , BB8_TEL AS TELEFONES, '' AS X "
cQuery += " FROM "+RetSqlName("BI5")+" BI5 "
cQuery += " INNER JOIN "+RetSqlName("BBK")+" BBK "
cQuery += " ON  BI5.BI5_CODRED = BBK.BBK_CODRED "
cQuery += " AND BI5.D_E_L_E_T_ = BBK.D_E_L_E_T_ "
cQuery += " INNER JOIN "+RetSqlName("BAU")+" BAU "
cQuery += " ON  BBK.BBK_CODIGO = BAU.BAU_CODIGO "
cQuery += " AND BBK.D_E_L_E_T_ = BAU.D_E_L_E_T_ "
cQuery += " INNER JOIN "+RetSqlName("BB8")+" BB8 "
cQuery += " ON  BAU.BAU_CODIGO = BB8.BB8_CODIGO "
cQuery += " AND BAU.D_E_L_E_T_ = BB8.D_E_L_E_T_ "
cQuery += " INNER JOIN "+RetSqlName("BAX")+" BAX "
cQuery += " ON  BB8.BB8_CODIGO = BAX.BAX_CODIGO "
cQuery += " AND BB8.BB8_CODLOC = BAX.BAX_CODLOC "
cQuery += " AND BB8.D_E_L_E_T_ = BAX.D_E_L_E_T_ "
cQuery += " INNER JOIN "+RetSqlName("BAQ")+" BAQ "
cQuery += " ON  BAX.BAX_CODINT = BAQ.BAQ_CODINT "
cQuery += " AND BAX.BAX_CODESP = BAQ.BAQ_CODESP "
cQuery += " AND BAX.D_E_L_E_T_ = BAQ.D_E_L_E_T_ "
cQuery += " WHERE BI5.D_E_L_E_T_ <> '*' "
cQuery += " AND BI5.BI5_CODRED BETWEEN '"+MV_PAR01+"' AND '"+MV_PAR02+"' "   
cQuery += " AND BB8_DATBLO = '"+Space(TamSX3("BB8_DATBLO")[1])+"'"
cQuery += " AND BAX_DATBLO = '"+Space(TamSX3("BAX_DATBLO")[1])+"' "
cQuery += " AND BB8_GUIMED = '1' "
cQuery += " AND BAX_GUIMED = '1' "
cQuery += " AND BAU_GUIMED <> '0' "
cQuery += " AND BB8_VISEXT = '1' "
cQuery += " AND BAX_VISEXT = '1' "
cQuery += " AND BAU_VISEXT = '1' "
cQuery += " AND BAU_CODBLO = '"+Space(TamSX3("BAU_CODBLO")[1])+"' "
cQuery += " ORDER BY BI5.BI5_DESCRI "

DbUseArea(.T., 'TOPCONN', TCGenQry(,,cQuery), "TRB", .F., .T.)

While TRB->(!EOF())
	aItem := Array(Len(aHeader))
	
	For nX := 1 to Len(aHeader)
		aItem[nX] := CHR(160)+&(aHeader[nX][1])
	Next nX
	
	AADD(aCols,aItem)
	aItem := {}
	TRB->(dbSkip())
EndDo

Return
