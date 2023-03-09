#Include "Protheus.ch"
#Include "TopConn.ch"

//Constantes
#Define STR_PULA    Chr(13)+Chr(10)

/*/
--------------------------------------------------------------------------------
Fonte	  : CABR261
--------------------------------------------------------------------------------
Autor	  : Mateus Medeiros
--------------------------------------------------------------------------------
Data	  : 11/12/2018
--------------------------------------------------------------------------------
Descricao : Relatório para extração dos valores do faturamento por sub-contrato
--------------------------------------------------------------------------------
Partida   : Menu de Usuario
--------------------------------------------------------------------------------
/*/

User Function CABR261() 
	
	Local aArea        := GetArea()
	
	Local cAlias1      := GetNextAlias()
	Local nAux         := 0
	Local oFWMsExcel
	Local oExcel
	Local cArquivo     := GetTempPath()+'CABR261_'+cvaltochar(randomize(1,10000))+'.xml'
	Local cWorkSheet   := "Valores_Faturamento"
	Local cTable       := "Tabela de Sub-contrato"
	Local aColunas     := {"Nm. Reduzido","Nome Reduz Plano","Idade Miníma","Idade Máxima","Valor Faixa","Tipo Benef","Sexo" }
	Local aLinhaAux    := {}
	Local aLinhaCod	   := {}
	Local aLinhaPla	   := {}
	Local cOperadora   := '0001'
	Local cEmpDe       := ''
	Local cEmpAte      := ''
	Local cEmpAtu	   := ''
	Local cCotAtu	   := ''
	Local cSubAtu      := ''
	Local cCodPla      := ''
	Private cPerg  	   := Padr("CABR261",10)
	
	CriaSx1(cPerg)
	
	if Pergunte(cPerg,.T.)
		
		cEmpDe       := cOperadora+mv_par01
		cEmpAte      := cOperadora+mv_par02
		
		
		//Montando a consulta
		BeginSql alias cAlias1
			SELECT BTN.BTN_CODIGO CODIGO,
			BTN.BTN_NUMCON CONTRATO,
			BTN.BTN_SUBCON SUBCONTRATO,
			BTN.BTN_CODPRO CODIGO_PLANO,
			BI3.BI3_NREDUZ NOME_PLANO,
			BQC.BQC_NREDUZ NOME_REDUZ,
			BTN_IDAINI IDADE_MINIMA,
			BTN_IDAFIN IDADE_MAXIMA,
			BTN_VALFAI VALOR_FAIXA,
			BTN_TIPUSR TIPO_BENEFICIARIO ,
			BTN_SEXO SEXO
			FROM %table:BTN% BTN
			INNER JOIN %table:BI3% BI3
			ON BI3_CODIGO  = BTN_CODPRO
			AND BI3_VERSAO = BTN_VERPRO
			INNER JOIN %table:BQC% BQC
			ON BQC_FILIAL  = BTN_FILIAL
			AND BQC_CODIGO = BTN_CODIGO
			AND BQC_NUMCON = BTN_NUMCON
			AND BQC_VERCON = BTN_VERCON
			AND BQC_SUBCON = BTN_SUBCON
			AND BQC_VERSUB = BTN_VERSUB
			WHERE BTN_CODIGO BETWEEN %exp:cEmpDe% AND %exp:cEmpAte%
			AND BTN_TABVLD='        '
			AND ( BTN_NUMCON BETWEEN %exp:MV_PAR03% AND %exp:MV_PAR04%)
			AND BTN_SUBCON BETWEEN %exp:MV_PAR05% AND %exp:MV_PAR06%
			AND BTN.D_E_L_E_T_ = ' '
			AND BI3.D_E_L_E_T_ = ' '
			AND BQC.D_E_L_E_T_ = ' '
			ORDER BY BTN_CODIGO,
			BTN_NUMCON,
			BTN_SUBCON,
			BTN_CODPRO,BTN_IDAINI,BTN_IDAFIN
		EndSql
		
		if !(cAlias1)->(Eof())
			//Criando o objeto que irá gerar o conteúdo do Excel
			oFWMsExcel := FWMSExcel():New()
			
			//Aba 01
			oFWMsExcel:AddworkSheet(cWorkSheet) //Não utilizar número junto com sinal de menos. Ex.: 1-
			
			//Criando a Tabela
			oFWMsExcel:AddTable(cWorkSheet, cTable)
			
			//Criando Colunas
			For nAux := 1 To Len(aColunas)
				oFWMsExcel:AddColumn(cWorkSheet, cTable, aColunas[nAux], 1, 1)
			Next
			
			//Percorrendo os produtos
			While !(cAlias1)->(EoF())
					//Criando a linha
					//aLinhaAux := Array(Len(aColunas))
					
					if cEmpAtu # (cAlias1)->CODIGO 
						
						
						aLinhaCod := Array(Len(aColunas))
						aLinhaCod[1] := "Codigo "+(cAlias1)->CODIGO 
						aLinhaCod[2] := '-'
						aLinhaCod[3] := '-'
						aLinhaCod[4] := '-'
						aLinhaCod[5] := '-'
						aLinhaCod[6] := '-'
						aLinhaCod[7] := '-'
						
						cEmpAtu := (cAlias1)->CODIGO 
						oFWMsExcel:AddRow(cWorkSheet, cTable, aLinhaCod)
						
					
					endif	
					
					IF  cEmpAtu == (cAlias1)->CODIGO  .and. cCotAtu #  (cAlias1)->CONTRATO .OR. ;
						(cEmpAtu == (cAlias1)->CODIGO  .and. cCotAtu == (cAlias1)->CONTRATO .and. cSubAtu #  (cAlias1)->SUBCONTRATO)
						
						if cCotAtu # (cAlias1)->CONTRATO .OR. cSubAtu # (cAlias1)->SUBCONTRATO  
							aLinhaPla := Array(Len(aColunas))
							aLinhaPla[1] := ' ' 
							aLinhaPla[2] := ' '
							aLinhaPla[3] := ' '
							aLinhaPla[4] := ' '
							aLinhaPla[5] := ' '
							aLinhaPla[6] := ' '
							aLinhaPla[7] := ' '
							oFWMsExcel:AddRow(cWorkSheet, cTable, aLinhaPla)
						endif 
									
						aLinhaAux := Array(Len(aColunas))
						//aLinhaAux[1] := "SubContrato: "+(cAlias1)->SUBCONTRATO -- Angelo Henrque						
						//aLinhaAux[2] := '-'
						aLinhaAux[1] := "Contrato: " 	+ (cAlias1)->CONTRATO
						aLinhaAux[2] := "SubContrato: "	+ (cAlias1)->SUBCONTRATO 
						aLinhaAux[3] := '-'
						aLinhaAux[4] := '-'
						aLinhaAux[5] := '-'
						aLinhaAux[6] := '-'
						aLinhaAux[7] := '-'
						cCotAtu := (cAlias1)->CONTRATO 
						cSubAtu := (cAlias1)->SUBCONTRATO 
						oFWMsExcel:AddRow(cWorkSheet, cTable, aLinhaAux)
						
					endif 
						
					IF  cEmpAtu == (cAlias1)->CODIGO .and. cCotAtu == (cAlias1)->CONTRATO .and. cSubAtu == (cAlias1)->SUBCONTRATO .and. cCodPla # (cAlias1)->CODIGO_PLANO
						
						if cCodPla # (cAlias1)->CODIGO_PLANO
							aLinhaPla := Array(Len(aColunas))
							aLinhaPla[1] := ' ' 
							aLinhaPla[2] := ' '
							aLinhaPla[3] := ' '
							aLinhaPla[4] := ' '
							aLinhaPla[5] := ' '
							aLinhaPla[6] := ' '
							aLinhaPla[7] := ' '
							oFWMsExcel:AddRow(cWorkSheet, cTable, aLinhaPla)
						endif 
																								
						aLinhaPla := Array(Len(aColunas))
						aLinhaPla[1] := "Cod. Plano: "+(cAlias1)->CODIGO_PLANO 
						aLinhaPla[2] := '-'
						aLinhaPla[3] := '-'
						aLinhaPla[4] := '-'
						aLinhaPla[5] := '-'
						aLinhaPla[6] := '-'
						aLinhaPla[7] := '-'
						cCodPla := (cAlias1)->CODIGO_PLANO  
						oFWMsExcel:AddRow(cWorkSheet, cTable, aLinhaPla)
						
					endif 	
						aLinhaAux := Array(Len(aColunas))
						aLinhaAux[1] := (cAlias1)->NOME_REDUZ
						aLinhaAux[2] := (cAlias1)->NOME_PLANO
						aLinhaAux[3] := (cAlias1)->IDADE_MINIMA
						aLinhaAux[4] := (cAlias1)->IDADE_MAXIMA
						aLinhaAux[5] := (cAlias1)->VALOR_FAIXA
						aLinhaAux[6] := (cAlias1)->TIPO_BENEFICIARIO
						aLinhaAux[7] := (cAlias1)->SEXO
			 			
			 			oFWMsExcel:AddRow(cWorkSheet, cTable, aLinhaAux)
			 			
				(cAlias1)->(DbSkip())
			EndDo
			
			//Ativando o arquivo e gerando o xml
			oFWMsExcel:Activate()
			oFWMsExcel:GetXMLFile(cArquivo)
			
			//Abrindo o excel e abrindo o arquivo xml
			oExcel := MsExcel():New()             //Abre uma nova conexão com Excel
			oExcel:WorkBooks:Open(cArquivo)     //Abre uma planilha
			oExcel:SetVisible(.T.)                 //Visualiza a planilha
			oExcel:Destroy()                        //Encerra o processo do gerenciador de tarefas
			
			if select(cAlias1) > 0 
				dbselectarea(cAlias1)
				dbclosearea()
			endif 
		else
			MsgStop("Não há dados para serem consultados com os parâmetros informados.")
		endif
	endif
	
	RestArea(aArea)
	
Return


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa   ³ CriaSX1   ³ Autor ³ Mateus Medeiros     ³ Data ³ 22.03.07 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao  ³ Atualiza SX1                                               ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
/*/
static function CriaSX1()
	
		
	aHelpPor := {}
	AADD(aHelpPor,"Informe a empresa De/Ate			")
	
	PutSx1(cPerg,"01","Empresa De: ?"				,"a","a","MV_CH1"	,"C",TamSX3("BG9_CODIGO")[1]	,0,0,"G","","B7APLS","","","MV_PAR01","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")
	PutSx1(cPerg,"02","Empresa Ate:?"				,"a","a","MV_CH2"	,"C",TamSX3("BG9_CODIGO")[1]	,0,0,"G","","B7APLS","","","MV_PAR02","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")
	
	aHelpPor := {}
	AADD(aHelpPor,"Informe o contrato De/ate  		")
	
	PutSx1(cPerg,"03","Contrato De: ? "				,"a","a","MV_CH3"	,"C",TamSX3("BT5_NUMCON")[1]	,0,0,"G","","BE6PLS","","","MV_PAR03","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")
	PutSx1(cPerg,"04","Contrato Ate:? "				,"a","a","MV_CH4"	,"C",TamSX3("BT5_NUMCON")[1]	,0,0,"G","","BE6PLS","","","MV_PAR04","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")
	
	aHelpPor := {}
	AADD(aHelpPor,"Informe o sub-contrato De/Ate	")
	
	PutSx1(cPerg,"05","Sub-Contrato De: ? "			,"a","a","MV_CH5"	,"C",TamSX3("BQC_SUBCON")[1]	,0,0,"G","","BKCPLS","","","MV_PAR05","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")
	PutSx1(cPerg,"06","Sub-Contrato Ate:? "			,"a","a","MV_CH6"	,"C",TamSX3("BQC_SUBCON")[1]	,0,0,"G","","BKCPLS","","","MV_PAR06","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")
	
	
return
