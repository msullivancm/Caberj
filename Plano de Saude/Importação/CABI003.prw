#INCLUDE "TOTVS.CH"
#INCLUDE "RWMAKE.CH"
#INCLUDE "TOPCONN.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABI003   ºAutor  ³Angelo Henrique     º Data ³  11/08/15   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Rotina responsável pela importação SIMPRO, elaborada apartirº±±
±±º          ³da rotina CABA012, foram solicitadas alterações que mudaram º±±
±±º          ³a forma de validação e composição da rotina, levando assim  º±±
±±º          ³a elaboração de uma nova rotina.                            º±±
±±º          ³Criado RDM 170e uma nova rotina.                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CABERJ                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function CABI003
	
	Local _aArea 		:= GetArea()
	Local cDirLido  	:= GetNewPar("MV_XSMPDIR", "\INTERFACE\IMPORTA\SIMPRODBF\")
	Local cFileDest	:= ""
	Local nTipArq   	:= 0
	
	Local nCont		:= 0
	Local cChar     	:= space(0)
	Local cPerg		:= "CABI003"
	Local nPos			:= 0
	Local _cQuery		:= ""
	
	Private cArqCsv	:= ""
	//Private _QryN1 	:= GetNextAlias()
	Private _cAliQry	:= GetNextAlias()
	Private cArqTmp		:= ""
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Inicio Perguntas dos parametros				   ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	
	//--------------------------------------------------------------------------------
	//Angelo Henrique - Data: 19/08/2015 -- Alinhamento com Nilton
	//--------------------------------------------------------------------------------
	//A pergunta abaixo será utilizada em outro momento.
	//--------------------------------------------------------------------------------
	
	PutSx1(cPerg,"01","Data de Divulgação "	,"","","mv_ch1","D",08,0,0,"G","NaoVazio()","      ","S","","mv_par01","         ","","","    ","      ","","","       ","","","","","","","","",{},{},{},"")
	
	PutSx1(cPerg,"02","Arquivo"				,"","","mv_ch2","C",99,0,0,"G","NaoVazio()","DIR   ","S","","mv_par02","         ","","","    ","      ","","","       ","","","","","","","","",{},{},{},"")
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Fim    Perguntas dos parametros				   ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	
	If !Pergunte(cPerg,.T.)
		Return
	EndIf
	
	
	//--------------------------------------------------------------------------------
	// Inicio - Angelo Henrique - Data: 19/08/2015 -- Alinhamento com Nilton
	//--------------------------------------------------------------------------------
	//Retirado as validações, será utilizado a vigência encaminhada no arquivo.
	//--------------------------------------------------------------------------------
	
	/*
	_cQuery  := "SELECT MAX(BD4_VIGINI) DATAINI "
	_cQuery  += "FROM "+RETSQLNAME("BA8")+" BA8, "+ RETSQLNAME("BD4")+ " BD4 "
	_cQuery  += "WHERE BA8_FILIAL = '"+xFilial("BA8")+"' "
	_cQuery  += "AND BD4_FILIAL = '"+xFilial("BD4")+"' "
	_cQuery  += "AND BA8_CODTAB IN ('0001027','0001030') "
	_cQuery  += "AND BD4_CDPADP IN ('00','19')"
	_cQuery  += "AND BA8_CDPADP = BD4_CDPADP "
	_cQuery  += "AND BA8_CODPRO = BD4_CODPRO "
	_cQuery  += "AND BA8_CODTAB = BD4_CODTAB "
	_cQuery  += "AND (BD4_VIGFIM = ' ' OR BD4_VIGFIM = '20501231' OR BD4_VIGFIM = '20491231') "
	_cQuery  += "AND BA8.D_E_L_E_T_ = ' ' "
	_cQuery  += "AND BD4.D_E_L_E_T_ = ' ' "
	
	*'-----------------------------'*
	*'Valida se o Alias esta em uso'*
	*'-----------------------------'*
	If Select(_cAliQry) > 0
		dbSelectArea(_cAliQry)
		(_cAliQry)->(dbCloseArea())
	EndIf
	
	dbUseArea(.T., "TOPCONN", TcGenQry(,,_cQuery), _cAliQry, .T., .F.)
	
	DbSelectArea(_cAliQry)
	
	if mv_par01 < stod((_cAliQry)->DATAINI)
		MsgAlert("Data digitada (" + dtos(mv_par01) +") inferior a Tabela vigente do sistema ("+ (_cAliQry)->DATAINI +") Operacao abortada!")
		Return
	Endif
	*/
	
	//--------------------------------------------------------------------------------
	// Fim    - Angelo Henrique - Data: 19/08/2015 -- Alinhamento com Nilton
	//--------------------------------------------------------------------------------
	
	cArqCsv := AllTrim(mv_par02)
	//nPos := AT(".DBF",Upper(cArqdbf))
	
	If !File(cArqCsv)
		MsgBox('Arquivo '+cArqCsv+' nao encontrado. Verifique.','Erro no Processo','ALERT')
		Return
	EndIf
	
	//If nPos == 0
	//	MsgBox('Arquivo '+cArqdbf+' invalido. So eh possivel importar arquivo com a extensao DBF. Verifique.','Erro no Processo','ALERT')
	//	Return
	//EndIf
	
	If !MsgBox('Este programa ira importar a tabela de Materias do SIMPRO. '+CHR(13)+'Deseja Continuar?', "Confirma processamento?","YESNO")
		Return
	EndIf
	
	For nCont := Len(alltrim(cArqCsv)) to 0 step -1
		cChar := Substr(cArqCsv,nCont,1)
		If cChar $ "/\"
			Exit
		Endif
	Next
	
	cArqTmp := Substr(cArqCsv,nCont+1)
	
	cFileDest := Alltrim(cDirLido+alltrim(cArqTmp))
	
	//dbUseArea(.T.,"DBFCDXADS",cArqdbf,_QryN1,.F.,.F.)
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Processamento da importacao...                                           ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	Processa({|| CABI003A(cArqCsv)},'Importando Arquivo...')
	
	COPY FILE &cArqCsv TO &cFileDest
	
	// Apaga fisicamente arquivo da pasta de origem apos ser copiado.
	
	fErase(cArqCsv)
	
	*'-----------------------------'*
	*'Valida se o Alias esta em uso'*
	*'-----------------------------'*
	If Select(_cAliQry) > 0
		dbSelectArea(_cAliQry)
		(_cAliQry)->(dbCloseArea())
	EndIf
	
	//If Select(_QryN1) <> 0
	//	(_QryN1)->(DbCloseArea())
	//Endif
	
	MsgBox('Importacao concluida','Fim do Processamento','ALERT')
	
	RestArea(_aArea)
	
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABI003A	ºAutor  ³Angelo Henrique     º Data ³  11/08/2015 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Execucao da rotina de atualizacao de TDE, composicao de     º±±
±±º          ³valores e tabela padrao.                                    º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CABERJ                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function CABI003A(cFile)
	
	Local nI
	Local nQuant := 0
	Local nLastUpdate := Seconds()
	Local nTotal := 0
	Local cLinha := ''
	Local nTam := 0
	Local cValArray := ''
	Local nValArray := 0
	
	Local _aArea 		:= GetArea()
	Local _aArBR4		:= BR4->(GetArea())
	Local _aArBF8		:= BF8->(GetArea())
	Local _aArBA8		:= BA8->(GetArea())
	Local _aArBD4		:= BD4->(GetArea())
	
	Private _cTpProc 	:= '1' //Material
	Private _cCodPro	:= ""  //Irá receber informações do campo CD_TUSS ou CD_SIMPRO do arquivo .CSV
	Private _cCodigo	:= ""
	Private _lTuss 		:= .F.
	Private _cCdPaDp	:= ""
	Private _cCodTab	:= ""
	Private _nValor		:= 0
	Private dDatAtu		:= StoD("20491231") //Data da Vigencia final
	Private dVigIni		:= CTOD("  /  /  ")
	Private nGravados	:= 0
	Private nLidas		:= 0
	Private a_Log		:= {}
	Private lPrim   := .T.
	Private aDados := {}
	Private aCampos := {"CD_USUARIO","CD_FRACAO","DESCRICAO","VIGENCIA","IDENTIF","PC_EM_FAB","PC_EM_VEN","PC_EM_USU","PC_FR_FAB","PC_FR_VEN","PC_FR_USU","TP_EMBAL","TP_FRACAO","QTDE_EMBAL","QTDE_FRAC","PERC_LUCR","TIP_ALT","FABRICA","CD_SIMPRO","CD_MERCADO","PERC_DESC","VLR_IPI","CD_REG_ANV","DT_REG_ANV","CD_BARRA","LISTA","HOSPITALAR","FRACIONAR","CD_TUSS","CD_CLASSIF","CD_REF_PRO","GENERICO","DIVERSOS"}

	FT_FUSE(cFile)
	
	nTotal := FT_FLASTREC()
	
	ProcRegua(nTotal)
	
	FT_FGOTOP()
	//DbSelectArea((_QryN1))
	//ProcRegua(RecCount())
	
	//(_QryN1)->(DbGoTop())
	
	//Begin Transaction
	While !FT_FEOF()
 		
 		nQuant++ 
 		
 		If (Seconds() - nLastUpdate) > 1

			IncProc("Lendo arquivo CSV..." + cValToChar(nQuant) + " de " + cValToChar(nTotal) + " registros.")
			
			nLastUpdate := Seconds()
				
		EndIf
 
		cLinha := FT_FREADLN()
 
		//If lPrim
		//	aCampos := Separa(cLinha,",",.T.)
		//	lPrim := .F.
		//Else
			AADD(aDados,Separa(cLinha,";",.T.))
		//EndIf
 
		FT_FSKIP()
	EndDo

	BeginTran()

		ProcRegua(Len(aDados))

		For i:=1 to Len(aDados)
			//Alert(aDados[i][  ASCAN(aCampos, { |x| UPPER(x) == "CD_FRACAO" })  ] )
			//Bianchini - 02/10/2020 - Na leitura do Arquivo CSV os numeros com casas decimais vêm ponto decimal
			//                         Aqui quebro a String de acordo com o Layout DBF que era utilizado
			If !Empty(aDados[i][6]) 
				nTam := Len(Trim(aDados[i][6]))
				cValArray := Trim(aDados[i][6]) 
				nValArray := cValToChar(Substr(cValArray,1,nTam-2)+"."+Substr(cValArray,nTam-1,2))
				aDados[i][6] := nValArray 
			Endif

			If !Empty(aDados[i][7]) 
				nTam := Len(Trim(aDados[i][7]))
				cValArray := Trim(aDados[i][7]) 
				nValArray := cValToChar(Substr(cValArray,1,nTam-2)+"."+Substr(cValArray,nTam-1,2))
				aDados[i][7] := nValArray 
			Endif

			If !Empty(aDados[i][8]) 
				nTam := Len(Trim(aDados[i][8]))
				cValArray := Trim(aDados[i][8]) 
				nValArray := cValToChar(Substr(cValArray,1,nTam-2)+"."+Substr(cValArray,nTam-1,2))
				aDados[i][8] := nValArray 
			Endif

			If !Empty(aDados[i][9]) 
				nTam := Len(Trim(aDados[i][9]))
				cValArray := Trim(aDados[i][9]) 
				nValArray := cValToChar(Substr(cValArray,1,nTam-3)+"."+Substr(cValArray,nTam-2,3))
				aDados[i][9] := nValArray 
			Endif

			If !Empty(aDados[i][10]) 
				nTam := Len(Trim(aDados[i][10]))
				cValArray := Trim(aDados[i][10]) 
				nValArray := cValToChar(Substr(cValArray,1,nTam-3)+"."+Substr(cValArray,nTam-2,3))
				aDados[i][10] := nValArray 
			Endif

			If !Empty(aDados[i][11]) 
				nTam := Len(Trim(aDados[i][11]))
				cValArray := Trim(aDados[i][11]) 
				nValArray := cValToChar(Substr(cValArray,1,nTam-3)+"."+Substr(cValArray,nTam-2,3))
				aDados[i][11] := nValArray 
			Endif

			If !Empty(aDados[i][14]) 
				nTam := Len(Trim(aDados[i][14]))
				cValArray := Trim(aDados[i][14]) 
				nValArray := cValToChar(Substr(cValArray,1,nTam-2)+"."+Substr(cValArray,nTam-1,2))
				aDados[i][14] := nValArray 
			Endif

			If !Empty(aDados[i][15]) 
				nTam := Len(Trim(aDados[i][15]))
				cValArray := Trim(aDados[i][15]) 
				nValArray := cValToChar(Substr(cValArray,1,nTam-2)+"."+Substr(cValArray,nTam-1,2))
				aDados[i][15] := nValArray 
			Endif

			If !Empty(aDados[i][16]) 
				nTam := Len(Trim(aDados[i][16]))
				cValArray := Trim(aDados[i][16]) 
				nValArray := cValToChar(Substr(cValArray,1,nTam-2)+"."+Substr(cValArray,nTam-1,2))
				aDados[i][16] := nValArray 
			Endif

			If !Empty(aDados[i][21]) 
				nTam := Len(Trim(aDados[i][21]))
				cValArray := Trim(aDados[i][21]) 
				nValArray := cValToChar(Substr(cValArray,1,nTam-2)+"."+Substr(cValArray,nTam-1,2))
				aDados[i][21] := nValArray 
			Endif

			If !Empty(aDados[i][22]) 
				nTam := Len(Trim(aDados[i][22]))
				cValArray := Trim(aDados[i][22]) 
				nValArray := cValToChar(Substr(cValArray,1,nTam-2)+"."+Substr(cValArray,nTam-1,2))
				aDados[i][22] := nValArray 
			Endif
			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//Restaurando o valor inicial das variáveis
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			_lTuss  := .F.
			_nValor := 0
			dVigIni := aDados[i][ASCAN(aCampos, { |x| UPPER(x) == "VIGENCIA" })] //(_QryN1)->VIGENCIA //MV_PAR01 -- Angelo Henrique - Data: 19/08/2015 -- Alinhamento com Nilton
			dVigIni := STOD(Substr(dVigIni,5,4)+Substr(dVigIni,3,2)+Substr(dVigIni,1,2))
			nLidas++ //Quantidade de linhas lidas no arquivo .DBF
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Inicio - Validações de registros que não devem ser importados³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			
			If AllTrim(aDados[i][ASCAN(aCampos, { |x| UPPER(x) == "CD_MERCADO" })]) = "50" //Medicamento
				
				//(_QryN1)->(DbSkip())
				Loop
				
				/*	ElseIf AllTrim(UPPER((_QryN1)->CD_CLASSIF)) = "IT"
				
				(_QryN1)->(DbSkip())
				Loop
				*/
			ElseIf AllTrim(UPPER(aDados[i][ASCAN(aCampos, { |x| UPPER(x) == "IDENTIF" })])) $ "L|A|D"
				
				//(_QryN1)->(DbSkip())
				Loop
				
			//ElseIf aDados[i][ASCAN(aCampos, { |x| UPPER(x) == "PC_FR_FAB" })] <= 0 .And. aDados[i][ASCAN(aCampos, { |x| UPPER(x) == "PC_EM_FAB" })] <= 0 //WALLACE RODRIGUES // PAREI AQUI ERRO TYPE MISMATCH
			ElseIf Val(aDados[i][ASCAN(aCampos, { |x| UPPER(x) == "PC_FR_FAB" })]) <= 0 .And. Val(aDados[i][ASCAN(aCampos, { |x| UPPER(x) == "PC_EM_FAB" })]) <= 0 
				
				//(_QryN1)->(DbSkip())
				Loop
				
			Endif
			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿aDados[i][ASCAN(aCampos, { |x| UPPER(x) == "" })]
			//³  FIM  - Validações de registros que não devem ser importados³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			
			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Validando campo TUSS, para saber qual validações fazer³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If !Empty(AllTrim(aDados[i][ASCAN(aCampos, { |x| UPPER(x) == "CD_TUSS" })]))
				
				_cCodigo := PADR("027", TAMSX3("BF8_CODIGO")[1])
				
				_cCdPaDp := PADR("19" , TAMSX3("BA8_CDPADP")[1])
				
				_cCodPro :=  aDados[i][ASCAN(aCampos, { |x| UPPER(x) == "CD_TUSS" })] //(_QryN1)->CD_TUSS
				
				_lTuss := .T.
				
			Else
				
				_cCodigo := PADR(GetMv("MV_XTABPAD"), TAMSX3("BF8_CODIGO")[1])
				
				_cCdPaDp := PADR(GetMv("MV_XCODPAD") , TAMSX3("BA8_CDPADP")[1])
				
				_cCodPro := aDados[i][ASCAN(aCampos, { |x| UPPER(x) == "CD_SIMPRO" })]
				
			EndIf
			
			//Leonardo Portella - 30/08/16 - Comentado pois após aplicação de patch e compatibilizador, o protheus aceita com 10 dígitos.
			/*
			//Leonardo Portella - 14/12/15 - Inicio - Alterar tamanho dos codigos para 8 conforme TUSS. Tabela BTU
			//espera tamanho 8. A numeracao sempre vem com 00 na frente e com 10 digitos.
			
			If len(AllTrim(_cCodPro)) <> 8
				
				//Nao importo se tiver mais que 8 digitos e os 2 primeiros diferentes de 00
				If Left(AllTrim(_cCodPro),2) <> '00'
					(_QryN1)->(dbSkip())
					Loop
				Else
					_cCodPro := Right(AllTrim(_cCodPro),8)
				EndIf
				
			EndIf
			
			//Leonardo Portella - 14/12/15 - Fim
			*/
			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Validação dos tipos de tabela³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			DbSelectArea("BR4")
			DbSetOrder(1)
			If DbSeek(xFilial('BR4') + _cCdPaDp)
				
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³Inicio do processo de pesquisa/inclusão/alteração³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				DbSelectArea("BF8")
				DbSetOrder(2)
				If DbSeek(xFilial("BF8")+_cCdPaDp +"0001"+_cCodigo)
					
					_cCodTab	:= BF8->(BF8_CODINT + BF8_CODIGO)
					
					If _lTuss
						
						//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
						//³Se for codigo TUSS deve validar BTQ,           ³
						//³pois não pode cadastrar sem existir a BTQ que é³
						//³o padrão da ANS                                ³
						//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
						DbSelectArea("BTQ")
						DbSetOrder(1)//BTQ_FILIAL+BTQ_CODTAB+BTQ_CDTERM
						If !(DbSeek(xFilial('BTQ') + '19' + _cCodPro))
							
							c_MsgLog := "Codigo TUSS: " + _cCodPro + " não encontrado no sistema, "
							c_MsgLog := "favor verificar o cadastro de Terminologia TUSS."
							
							If aScan(a_Log,c_MsgLog) <= 0
								aAdd(a_Log,c_MsgLog)
							EndIf
							
							Loop
							
						EndIf
						
					EndIf
					
					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³Antes da inclusão/alteração realizar a validação do valor conforme levantado  ³
					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³Regra:                                                                        ³
					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³ - Quando o IDENTIF estiver com o conteúdo 'V' ou 'F' deve considerar o valor ³
					//³da caluna PC_FR_FAB, se este campo for zero, considerar o campo PC_EM_FAB     ³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					
					If AllTrim(UPPER(aDados[i][ASCAN(aCampos, { |x| UPPER(x) == "IDENTIF" })])) $ "V|F"
						
						//If !(aDados[i][ASCAN(aCampos, { |x| UPPER(x) == "PC_FR_FAB" })] = 0)
						If Val(aDados[i][ASCAN(aCampos, { |x| UPPER(x) == "PC_FR_FAB" })]) <> 0
							
							//_nValor := aDados[i][ASCAN(aCampos, { |x| UPPER(x) == "PC_FR_FAB" })]
							_nValor := Val(aDados[i][ASCAN(aCampos, { |x| UPPER(x) == "PC_FR_FAB" })])
							
						Else
							
							//_nValor := aDados[i][ASCAN(aCampos, { |x| UPPER(x) == "PC_EM_FAB" })]
							_nValor := Val(aDados[i][ASCAN(aCampos, { |x| UPPER(x) == "PC_EM_FAB" })])
							
						EndIf
						
					EndIf
					
					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³Cabeçalho da tabela onde são gravados os registros³
					//Inicando o processo de inclusão ou alteração 		 ³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					DbSelectArea("BA8")
					DbSetOrder(1)
					If DbSeek(xFilial("BA8") + _cCodTab + _cCdPaDp + _cCodPro)
						
						//Função para atualizar ou inlcuir BD4
						U_CABI003B()
						
					Else
						
						BA8->(RecLock("BA8",.T.))
						BA8->BA8_FILIAL := xFilial("BA8")
						BA8->BA8_CDPADP := _cCdPaDp
						BA8->BA8_CODPRO := _cCodPro
						BA8->BA8_DESCRI := UPPER( ALLTRIM(aDados[i][ASCAN(aCampos, { |x| UPPER(x) == "DESCRICAO" })])+" - "+ALLTRIM(aDados[i][ASCAN(aCampos, { |x| UPPER(x) == "FABRICA" })]) )
						BA8->BA8_NIVEL  := "4"
						BA8->BA8_ANASIN := "1"
						BA8->BA8_CODPAD := _cCdPaDp
						BA8->BA8_CODTAB := _cCodTab
						BA8->BA8_CODANT := ""
						BA8->BA8_NMFABR := aDados[i][ASCAN(aCampos, { |x| UPPER(x) == "FABRICA" })]
						BA8->(MsUnLock())
						
						//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄD¿
						//³Rotina responsável pela inclusão/alteração na tabela BD4³
						//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄDÙ
						U_CABI003B()
						
						//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
						//³ Grava BR8 - Tabela Padrao                                                ³
						//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
						DbSelectArea("BR8")
						DbSetOrder(1)
						If DbSeek(xFilial("BR8") + _cCdPaDp + _cCodPro )
							
							RecLock("BR8",.F.)
							
						Else
							
							RecLock("BR8",.T.)
							
						Endif
						
						BR8->BR8_FILIAL := xFilial("BR8")
						BR8->BR8_CODPAD := _cCdPaDp
						BR8->BR8_CODPSA := _cCodPro
						BR8->BR8_DESCRI := UPPER( ALLTRIM(aDados[i][ASCAN(aCampos, { |x| UPPER(x) == "DESCRICAO" })] ))+ " - " + ALLTRIM(aDados[i][ASCAN(aCampos, { |x| UPPER(x) == "FABRICA" })] )
						BR8->BR8_ANASIN := "1"
						BR8->BR8_NIVEL  := "4"
						BR8->BR8_BENUTL := "1"
						BR8->BR8_TPPROC := _cTpProc
						BR8->BR8_AUTORI := "1"
						BR8->BR8_REGATD := "3"
						
						BR8->BR8_LEMBRE := 'SIMPRO - Divulgação: ' + DTOC(MV_PAR01) + "Dt. Importação: " + DtoC(Date())
						
						BR8->(MSUnLock())
						
					EndIf
					
					//	nGravados++
					
					DbSelectArea("BTU")
					BTU->(DbSetOrder(3))//BTU_FILIAL, BTU_CODTAB, BTU_ALIAS, BTU_CDTERM
					
					lIncAltBTU := !BTU->(MsSeek(xFilial('BTU') + _cCdPaDp + "BR8" + _cCodPro ) )
					
					//Leonardo Portella - 31/08/16 - Início - Validar se os dados existem na base
					
					lProcBTU := .T.
					
					If !lIncAltBTU //Se vai alterar
						
						nRecBTU := BTU->(Recno())
						
						iF nRecBTU == 94139
							LPROCBTU := .T.
						ENDIF
						
						While 	!BTU->(EOF()) 						.and. ;
								BTU->BTU_FILIAL == xFilial('BTU') 	.and. ;
								BTU->BTU_CODTAB	== _cCdPaDp			.and. ;
								BTU->BTU_CDTERM	== _cCodPro			.and. ;
								BTU->BTU_ALIAS	== "BR8"
							
							If 	AllTrim(BTU->BTU_VLRSIS) == AllTrim( _cCdPaDp + _cCodPro )	.and. ;
									AllTrim(BTU->BTU_VLRBUS) == AllTrim(_cCodPro)
								
								lProcBTU := .F. //Já existe com os mesmos dados
								
							EndIf
							
							BTU->(DbSkip())
							
						EndDo
						
						BTU->(DbGoTo(nRecBTU))
						
					EndIf
					
					If lProcBTU
						
						//Leonardo Portella - 31/08/16 - Fim
						
						BTU->(Reclock('BTU',lIncAltBTU))
						
						BTU->BTU_FILIAL := xFilial('BTU')
						BTU->BTU_CODTAB	:= _cCdPaDp
						BTU->BTU_VLRSIS	:= ( xFilial('BR8') + _cCdPaDp + _cCodPro )
						BTU->BTU_VLRBUS := _cCodPro
						BTU->BTU_CDTERM	:= _cCodPro
						BTU->BTU_ALIAS	:= "BR8"
						
					EndIf //Leonardo Portella - 31/08/16
					
					BTU->(MsUnlock())
					
					//Atualizo na terminologia pois o vinculo foi criado
					If BTQ->(Found())
						
						BTQ->(Reclock('BTQ',.F.))
						
						BTQ->BTQ_HASVIN = '1'
						
						BTQ->(MsUnlock())
						
					EndIf
					
				Else
					
					c_MsgLog := "Codigo [ " + _cCodPro + " ] não localizado na tabela de honorarios (BF8)"
					
					If aScan(a_Log,c_MsgLog) <= 0
						aAdd(a_Log,c_MsgLog)
					EndIf
					
					//Se não encontrar na tabela de honorarios (BF8) não inclui
					//(_QryN1)->(dbSkip())
					Loop
					
				EndIf
				
			Else
				
				c_MsgLog := 'Tabela [ ' + _cCdPaDp + ' ] não localizada na tipos de tabela (BR4)'
				
				If aScan(a_Log,c_MsgLog) <= 0
					aAdd(a_Log,c_MsgLog)
				EndIf
				
				//(_QryN1)->(dbSkip())
				Loop
				
			EndIf
			
			//(_QryN1)->(dbSkip())
			
			IncProc()

		Next i

		//(_QryN1)->(DbCloseArea())
		
	EndTran()
	//End Transaction
	
	If !empty(a_Log)
		
		c_MsgLog := ''
		
		For nI := 1 to len(a_Log)
			c_MsgLog += a_Log[nI] + CRLF
		Next
		
		MsgStop('Críticas: ' + CRLF + c_MsgLog,AllTrim(SM0->M0_NOMECOM))
		
	EndIf
	
	MsgInfo('Registros lidos: ' + cValToChar(nLidas) + ' - Registros gravados: ' + cValToChar(nGravados),AllTrim(SM0->M0_NOMECOM))
	
	RestArea(_aArea)
	RestArea(_aArBR4)
	RestArea(_aArBF8)
	RestArea(_aArBA8)
	RestArea(_aArBD4)
	
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABI003B  ºAutor  ³Angelo Henrique     º Data ³  13/08/15   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Rotina responsável pela inclusão/alteração da tabela BD4    º±±
±±º          ³Unidade de Saúde                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³CABERJ                                                      º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function CABI003B()
	
	Local _aArea 	:= GetArea()
	Local _aArBD4	:= BD4->(GetArea())
	Local cCodBD4	:= "VMT"
	Local dDtDigit	:= DATE()
	Local _cUsu		:= SubStr(cUSUARIO,7,15)
	Local _cCodMv 	:= ""
	Local _cCdPaMv 	:= ""
	Local _cCodSmp 	:= ""
	Local _cCodBf8 	:= ""
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Grava BD4 - TDE Detalhe                                                  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	DbSelectArea("BD4")
	DbSetOrder(1)
	If DbSeek(xFilial("BD4") + _cCodTab + _cCdPaDp + PADR(AllTrim(_cCodPro),TAMSX3("BD4_CODPRO")[1]) + cCodBD4)
		
		If !EMPTY(_cCodPro)
			
			//---------------------------------------------------------------------
			//Se o valor for diferente irá realizar as atualizações
			//---------------------------------------------------------------------
			If BD4->BD4_VALREF <> round(_nValor,4)
				
				While ! BD4->(Eof()) .and. BD4->(BD4_CODTAB+BD4_CDPADP+TRIM(BD4_CODPRO)+BD4_CODIGO)==(_cCodTab+_cCdPaDp+AllTrim(_cCodPro)+cCodBD4)
					
					//-------------------------------------------------------------
					//Varrendo todos os itens da composição para corrigir
					//a data de vigência final das importações anteriores
					//que podem estar abertas
					//-------------------------------------------------------------
					If BD4->BD4_VIGFIM = dDatAtu
						
						BD4->(RecLock("BD4",.F.))
						BD4->BD4_VIGFIM := (dVigIni - 1)
						BD4->(msUnLock())
						
					EndIf
					
					BD4->(DbSkip())
					
				EndDo
				
				BD4->(DbSkip(-1))
				
				//--------------------------------------------------------------
				//Necessário varrer caso tenha mais de um registro criado
				//--------------------------------------------------------------
				DbSelectArea("BD4")
				DbSetOrder(1)
				If DbSeek(xFilial("BD4") + _cCodTab + _cCdPaDp + _cCodPro) .and. (BD4->BD4_CODIGO == cCodBD4)
					
					While ! BD4->(Eof()) .and. BD4->(BD4_CODTAB+BD4_CDPADP+TRIM(BD4_CODPRO)+BD4_CODIGO)==(_cCodTab+_cCdPaDp+AllTrim(_cCodPro)+cCodBD4)
						
						If BD4->BD4_VIGFIM = dDatAtu
							
							BD4->(RecLock("BD4",.F.))
							BD4->BD4_VIGFIM := (dVigIni - 1)
							BD4->(msUnLock())
							
						EndIf
						
						BD4->(DbSkip())
					EndDo
					
				EndIf
				
				d_ViFim := BD4->BD4_VIGFIM
				
				//------------------------------------------------------------
				// Inicio -  Atualizar o registro anterior (Codigo SIMPRO)
				//------------------------------------------------------------
				_cAreBF8 := BF8->(GetArea())
				_cAreBD4 := BD4->(GetArea())
				
				If _lTuss
					
					_cCodMv  := PADR(GetMv("MV_XTABPAD"), TAMSX3("BF8_CODIGO")[1])
					_cCdPaMv := PADR(GetMv("MV_XCODPAD"), TAMSX3("BA8_CDPADP")[1])
					_cCodSmp := aDados[i][ASCAN(aCampos, { |x| UPPER(x) == "CD_SIMPRO" })] //(_QryN1)->CD_SIMPRO
					
					DbSelectArea("BF8")
					DbSetOrder(2)
					If DbSeek(xFilial("BF8")+_cCdPaMv +"0001"+_cCodMv)
						
						_cCodBf8	:= BF8->(BF8_CODINT + BF8_CODIGO)
						
						DbSelectArea("BD4")
						DbSetOrder(1) //BD4_FILIAL+BD4_CODTAB+BD4_CDPADP+BD4_CODPRO+BD4_CODIGO+DTOS(BD4_VIGINI)
						If DbSeek(xFilial("BD4") + _cCodBf8 + _cCdPaMv + _cCodSmp)
							
							While !EOF() .And. Trim(_cCodBf8 + _cCdPaMv + _cCodSmp) ==  Trim(BD4->(BD4_CODTAB+BD4_CDPADP+BD4_CODPRO))
								
								If BD4->BD4_VIGFIM = dDatAtu
									
									BD4->(RecLock("BD4",.F.))
									BD4->BD4_VIGFIM := BD4->BD4_VIGINI
									BD4->(msUnLock())
									
								EndIf
								
								BD4->(DbSkip())
								
							EndDo
							
						EndIf
						
					EndIf
					
				EndIf
				
				RestArea(_cAreBD4)
				RestArea(_cAreBF8)				
				//------------------------------------------------------------
				// Fim -  Atualizar o registro anterior (Codigo SIMPRO)
				//------------------------------------------------------------
				
				//------------------------------------------------------------
				//Gravando a atualização após todas as correções
				//------------------------------------------------------------ 
				BD4->(RecLock("BD4",.T.))
				BD4->BD4_FILIAL := xFilial("BD4")
				BD4->BD4_CODPRO := _cCodPro
				BD4->BD4_CODTAB := _cCodTab
				BD4->BD4_CDPADP := _cCdPaDp
				BD4->BD4_CODIGO := cCodBD4
				BD4->BD4_VALREF := _nValor
				BD4->BD4_PORMED := ""
				BD4->BD4_VLMED  := 0
				BD4->BD4_PERACI := 0
				BD4->BD4_VIGINI := dVigIni
				BD4->BD4_VIGFIM := dDatAtu
				BD4->BD4_YDTIMP := dDtDigit
				BD4->BD4_YUSUR  := _cUsu
				BD4->BD4_XNOMAR := SUBSTR(SUBSTR(DTOS(MV_PAR01), 1,6) + cArqTmp, 1, 25 )
				BD4->BD4_YTBIMP := "SIMPRO - Dt Divulgação: " + DTOC(MV_PAR01) + "Dt. Importação: " + DtoC(Date())
				BD4->(MsUnLock())
				
				nGravados++
				
			EndIf
			
		EndIf
		
	Else
		
		BD4->(RecLock("BD4",.T.))
		BD4->BD4_FILIAL := xFilial("BD4")
		BD4->BD4_CODPRO := _cCodPro
		BD4->BD4_CODTAB := _cCodTab
		BD4->BD4_CDPADP := _cCdPaDp
		BD4->BD4_CODIGO := cCodBD4
		BD4->BD4_VALREF := _nValor
		BD4->BD4_PORMED := ""
		BD4->BD4_VLMED  := 0
		BD4->BD4_PERACI := 0
		BD4->BD4_VIGINI := dVigIni
		BD4->BD4_VIGFIM := dDatAtu
		BD4->BD4_YDTIMP := dDtDigit
		BD4->BD4_YUSUR  := _cUsu
		BD4->BD4_XNOMAR := SUBSTR(SUBSTR(DTOS(MV_PAR01), 1,6) + cArqTmp, 1, 25 )
		BD4->BD4_YTBIMP := "SIMPRO - Dt Divulgação: " + DTOC(MV_PAR01) + "Dt. Importação: " + DtoC(Date())
		BD4->(MsUnLock())
		nGravados++
		
	Endif
	
Return
