#INCLUDE "TOTVS.CH"
#INCLUDE "rwmake.ch"
#INCLUDE "TOPCONN.CH"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณIMPMATMED บ Autor ณ ROGER CANGIANELI   บ Data ณ  24/05/05   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ IMPORTA TABELA DE MATERIAIS E MEDICAMENTOS BRASINDICE.     บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP7 IDE  - Alterado em 12/07/2]007 por Leandro para o TISS บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑบAlteracao ณ Angelo Henrique - Data:27/07/2018.                         บฑฑ
ฑฑบ          ณ Altera็๕es foram efetuadas na rotina para melhorar o       บฑฑ
ฑฑบ          ณ desempenho e como o fonte estava muito comentado gravei    บฑฑ
ฑฑบ          ณ o backup deste fonte no shared.                            บฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/

User Function IMPBRASI()
	
	Private cCodMat 	:= GetNewPar("MV_YCDUNMA","VMT")
	Private cCodMed 	:= GetNewPar("MV_YCDUNME","VMD")
	Private lBD4		:= .F.
	Private lBA8		:= .F.
	Private lBR8		:= .F.
	Private nPercent	:= 0
	Private ctab00  	:='99'
	//Private cUsuario	:= SubStr(cUSUARIO,7,15)
	Private _cUsu		:= SubStr(cUSUARIO,7,15)
	Private dDtDigit	:= DATE()
	Private nvalor11	:= ' '
	Private nvalor1 	:= ' '
	Private _aArea		:= GetArea()
	
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Declaracao de Variaveis                                             ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	Private cString 	:= "TRB"
	Private cString1	:= "TRB1"
	Private cPerg		:= "BRASIN"
	
	//--------------------------------------------------------------------------------------------------------------------------------------------
	//Bianchini - 19/10/2010 - Retorna a maior data de tabela existente a fim de validar de estแ sendo incluida a mesma ou a anterior a ela.
	//--------------------------------------------------------------------------------------------------------------------------------------------
	cQuery  := "SELECT '20090101' DATAINI "
	cQuery  += "FROM "+RETSQLNAME("BA8")+" BA8, "+ RETSQLNAME("BD4")+ " BD4 "
	cQuery  += "WHERE BA8_FILIAL = '"+xFilial("BA8")+"' "
	cQuery  += "AND BD4_FILIAL = '"+xFilial("BA8")+"' "
	cQuery  += "AND BA8_CODPRO = BD4_CODPRO "
	
	cQuery  += "AND BD4_CDPADP IN ('18','19','20')"
	
	cQuery  += "AND BA8.D_E_L_E_T_ = ' ' "
	cQuery  += "AND BD4.D_E_L_E_T_ = ' ' "
	
	// Cria Pergunte, caso nใo exista
	CriaSX1()
	
	If !Pergunte(cPerg, .T.)
		Return
	EndIf
	
	if !(Empty(mv_par09))
		nPercent := mv_par09 / 100
	EndIf
	
	TcQuery cQuery New Alias "QRYMAXDATA"
	
	if mv_par04 < stod(QRYMAXDATA->DATAINI)
		MsgAlert("Data digitada (" + dtos(mv_par04) +") inferior a Tabela vigente do sistema ("+ QRYMAXDATA->DATAINI +") Operacao abortada!")
		QRYMAXDATA->(DbCloseArea())
		Return
	Endif
	
	
	if mv_par04 = stod(QRYMAXDATA->DATAINI)
		if !ApMsgYesNo("Data digitada (" + dtos(mv_par04) +") igual a Tabela vigente do sistema ("+ QRYMAXDATA->DATAINI +"). Continua?","SIMNAO")
			QRYMAXDATA->(DbCloseArea())
			Return
		Endif
	Endif
	
	QRYMAXDATA->(DbCloseArea())
	
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Grava BR8 - Tabela Padrao                                                ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	BD3->(DbSetOrder(1))
	If !BD3->(MsSeek(xFilial("BD3")+mv_par06))
		MsgAlert("Unidade de medida de saude informada invalida. Operacao abortada!")
		Return
	Endif
	
	//Leonardo Portella - 05/07/16 - Inicio
	
	If mv_par07 <> 2
		MsgStop('Somente ้ permitida a importa็ใo de arquivo de tamanho fixo!',Alltrim(SM0->M0_NOMECOM))
		Return
	EndIf
	
	//Leonardo Portella - 05/07/16 - Fim
	
	_aArea	:= GetArea()
	
	If !MsgBox('Este programa ira importar a tabela formato BRASINDICE TISS. '+CHR(13)+'Deseja Continuar?', "Confirma processamento?","YESNO")
		Return
	EndIf
	
	//001UNIAO QUIMICA                           00001A CURITYBINA                                                                    AJOXLiquido display c/12                                                                                                                                            85.23  12PMC           7.10  658 0.00N78960062118080000000001
	//123123456789012345678901234567890123456789012345123456789012345678901234567890123456789012345678901234567890123456789012345678901234123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123451234
	//1...+....0....+....2....+....3....+....4....+....5....+....6....+....7....+....8....+....9....+....0....+....1....+....2....+....3....+....4....+....5....+....6....+....7....+....8....+....9....+....0....+....1....+....2....+....3....+....4....+....5....+....6....+....7....+....8....+....9....+....0....+....1....+....2....+....3....+....4....+....5...
	
	aStru	:= {}
	
	aAdd(aStru,	{"CODLAB"	,"C",3		,0	})
	aAdd(aStru,	{"DESLAB"	,"C",40		,0	})
	aAdd(aStru,	{"CODMED"	,"C",5		,0	})
	aAdd(aStru,	{"DESMED"	,"C",80		,0	})
	aAdd(aStru,	{"CODAPR"	,"C",4		,0	})
	aAdd(aStru,	{"DESAPR"	,"C",150	,0	})
	aAdd(aStru,	{"PRECO"	,"C",15		,2	})
	aAdd(aStru,	{"QTDE"		,"C",4		,0	})
	aAdd(aStru,	{"TPPRC"	,"C",3		,0	})
	aAdd(aStru,	{"PRCUNI"	,"C",15		,2	})
	aAdd(aStru,	{"EDBRAS"	,"C",5		,0	})
	aAdd(aStru,	{"IPI"		,"C",5		,2	})
	aAdd(aStru,	{"PORT"		,"C",1		,0	})
	aAdd(aStru,{"CODBAR"	,"C",13		,0	})
	aAdd(aStru,{"NUMTIS"	,"C",10		,0	})
	
	//------------------------------------------------------
	//Se for material ้ necessแrio incluir este campo
	//------------------------------------------------------
	If mv_par02 == 1
		aAdd(aStru,{"MATHOS","C",4		,0	})
	EndIf
	
	//------------------------------------------------------------------------------------------------------------
	//Se nao criar um campo com 13 posicoes no tipo 1 (MAT), quando le o campo TUSS ele pega a posicao errada
	//------------------------------------------------------------------------------------------------------------
	If mv_par02 == 1
		aAdd(aStru,{"TMP"	,"C",13		,0	})
	EndIf
	
	aAdd(aStru,{"TUSS"	,"C",8		,00})//Leonardo Portella - 14/01/15
	
	cArq := CriaTrab(aStru,.T.)
	dbUseArea(.T.,,cArq,cString,.T.)
	cInd := CriaTrab(NIL,.F.)
	
	IndRegua(cString,cInd,"NUMTIS",,,"Selecionando Registros...")
	
	//----------------------------------------------------------------------------------------------
	// Abre a tela para sele็ใo do arquivo a ser importado
	//----------------------------------------------------------------------------------------------
	cArqTxt := cGetFile("Arquivos de Importacao (*.txt) | *.txt","Selecione o Arquivo PMC",,"",.F.,)
	
	If !File(cArqTxt)
		MsgBox('Arquivo '+cArqTxt+' nao encontrado. Verifique.','Erro no Processo','ALERT')
		Return
	EndIf
	
	//*-----------------------------------
	//* Carrega arquivos para memoria
	//*------------------------------------
	MsAguarde({|| CarregaArq(cArqTxt,1), "Importacao Brasindice", OemToAnsi("Aguarde, carregando o arquivo...")})
	
	if mv_par09 > 0
		
		aStru	:= {}
		aAdd(aStru,{"CODLAB"	,"C",3	,00	})
		aAdd(aStru,{"DESLAB"	,"C",40	,00	})
		aAdd(aStru,{"CODMED"	,"C",5	,00	})
		aAdd(aStru,{"DESMED"	,"C",80	,00	})
		aAdd(aStru,{"CODAPR"	,"C",4	,00	})
		aAdd(aStru,{"DESAPR"	,"C",150,00	})
		aAdd(aStru,{"PRECO"		,"C",15	,2	})
		aAdd(aStru,{"QTDE"		,"C",4	,00	})
		aAdd(aStru,{"TPPRC"		,"C",3	,00	})
		aAdd(aStru,{"PRCUNI"	,"C",15	,2	})
		aAdd(aStru,{"EDBRAS"	,"C",5	,0	})
		aAdd(aStru,{"IPI"		,"C",5	,2	})
		aAdd(aStru,{"PORT"		,"C",1	,00	})
		aAdd(aStru,{"CODBAR"	,"C",13	,0	})
		aAdd(aStru,{"NUMTIS"	,"C",10	,0	})
		
		if mv_par02 == 1//If mv_par08 == 1 //Versao do Brasindice antiga
			aAdd(aStru,{"MATHOS","C",4,0})
		EndIf
		
		If mv_par02 == 1//Se nao criar um campo com 13 posicoes no tipo 1 (MAT), quando le o campo TUSS ele pega a posicao errada
			aAdd(aStru,{"TMP","C",13,0})
		EndIf
		
		aAdd(aStru,{"TUSS","C",8,00})
		
		cArq := CriaTrab(aStru,.T.)
		dbUseArea(.T.,,cArq,cString1,.T.)
		cInd := CriaTrab(NIL,.F.)
		
		IndRegua(cString1,cInd,"NUMTIS",,,"Selecionando Registros...")
		
		cArqTxt1 := cGetFile("Arquivos de Importacao (*.txt) | *.txt","Selecione o Arquivo PFB",,"",.F.,)
		
		If !File(cArqTxt1)
			MsgBox('Arquivo '+cArqTxt1+' nao encontrado. Verifique.','Erro no Processo','ALERT')
			Return
		EndIf
		
		//-------------------------------------------
		// Carrega arquivos para memoria
		//-------------------------------------------
		MsAguarde({|| CarregaArq(cArqTxt1,2), "Importacao Procedimentos", OemToAnsi("Aguarde, carregando o arquivo...")})
		
	EndIf
	
	//--------------------------------------
	// Processamento da importacao...
	//--------------------------------------
	Processa({|| _RunProc()},'Atualizando arquivos...')
	
	RestArea(_aArea)
	
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ_RunProc  บAutor  ณJean Schulz         บ Data ณ  27/07/06   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณExecucao da rotina de atualizacao de TDE, composicao de     บฑฑ
ฑฑบ          ณvalores e tabela padrao.                                    บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function _RunProc()
	
	cNivel	:= '4'//"3" TEMPORARIO - Nova mascara da tabela 18,19 e 20
	cAnaSin	:= "1"
	cOper	:= mv_par01
	cTabela	:= mv_par02
	cCodTab	:= ''//Pega da BF8 -- cOper + '027'//mv_par03 temporario
	dVigIni	:= mv_par04
	dDatAtu	:= mv_par05   //Data da Vigencia final
	cCodigo	:= mv_par06
	cCdPaDp	:= '05'
	cClasse	:= "000009"
	cCodPro	:= space(16)
	nValor	:= 0
	nValor1	:= 0
	cTpPrec	:= "" //Angelo Henrique - Data: 26/07/2018 - Atualiza็ใo do importador (Recebe a informa็ใo se o medicamento ้ PMC ou PFB)
	nVlFab	:= 0  //Angelo Henrique - Data: 26/07/2018 - Atualiza็ใo do importador (Recebe o valor de fabrica sem percentual, conforme vem no arquivo)
	cCdPSpp := ""
	cCodSpp := ""
	cSQL	:= ""
	cAliSQL := GetNextAlias()
	
	If Empty(DtoS(dDatAtu))
		dDatAtu := StoD("20491231")
	Endif
	
	Do case
	Case cTabela = 1 //Material
		_cTpProc:= '1'
		cCodigo := cCodMat   //VMT
	Case cTabela = 2 //Medicamento
		_cTpProc:= '2'       //VMD
		cCodigo := cCodMed 
	Otherwise		 //Solucoes...
		_cTpProc:= '2'       //VMT
		cCodigo := cCodMat 
	Endcase
	
	BD4->( dbSetOrder(1) )
	BA8->( dbSetOrder(4) )
	BF8->( dbSetOrder(1) )
	
	dbSelectArea('TRB')
	ProcRegua(RecCount())
	
	dbGoTop()
	
	//Begin Transaction
	BeginTran()
		
		While !TRB->(Eof())
			
			lBD4		:= .F.
			lBA8		:= .F.
			lBR8		:= .F.
			
			cDescriTmp := substr(UPPER( Alltrim(TRB->DESMED)+Space(1)+Alltrim(TRB->DESAPR) ),1,40)
			cDescriTmp := Replace(cDescriTmp,'(','')
			cDescriTmp := Replace(cDescriTmp,')','')
			cDescriTmp := Replace(cDescriTmp,'.','')
			cDescriTmp := Replace(cDescriTmp,'"','')
			cDescriTmp := Replace(cDescriTmp,"'",'')
			
			cCodPro := IIf(empty(TRB->TUSS),' ',TRB->TUSS)
			
			cInsTmp := "INSERT INTO TMP_COD_BRASINDICE(EMPRESA,ORIGEM,CARGA,TABELA,CODIGO,DESCR) VALUES ('" + If(cEmpAnt == '01','CAB','INT') + "','BRASINDICE','" + if(mv_par02 == 1,'MAT',IF(mv_par02 == 2,'MED','SOL'))+ "','  ','"+cCodPro+"','"+cDescriTmp+"')"
			
			If TcSqlExec(cInsTmp) < 0
				Alert("Erro TcSqlExec [ " + cInsTmp + " ]" + Chr(10)+Chr(13) + TCSQLError())
				DisarmTransaction()
				return
			Endif
			
			nvalor1 := Replace( TRB->PRCUNI,'.','')
			
			if (Alltrim(nvalor1) == '000' .or. empty(TRB->TUSS) ).and. mv_par09 > 0
				
				While !TRB1->(Eof())
					
					if !empty(TRB->TUSS)
						IF (TRB->TUSS)==(TRB1->TUSS) .and. !empty(TRB1->TUSS)
							
							nvalor11 := Replace( TRB1->PRCUNI ,'.','')
							nvalor1 :=(val(nvalor11)+(val(nvalor11)*(mv_Par09/10000)))
							nvalor1	:= nvalor1/100
							nValor	:= nvalor1
							
							//------------------------------------------------------
							// INICIO - Angelo Henrique - Data:26/07/2018
							//------------------------------------------------------
							// Atualiza็ใo do importador para pegar sigla PMC o PFB
							// e o valor de fabrica, caso o produto tenho este
							// valor preenchido no arquivo
							//------------------------------------------------------
							If Val(Replace( TRB1->PRCUNI ,'.','')) <> 0
								
								cTpPrec	:= "2"  //1=PMC;2=PFB
								nVlFab	:= Val(TRB1->PRCUNI)
								
							Else
								
								cTpPrec	:= "1"  //1=PMC;2=PFB
								nVlFab	:= 0
								
							EndIf
							//------------------------------------------------------
							// FIM - Angelo Henrique - Data:26/07/2018
							//------------------------------------------------------
							
							EXIT
						EndIf
					Else
						IF (TRB->NUMTIS)==(TRB1->NUMTIS)
							if Alltrim(nvalor1) == '000'	 .or. Alltrim(nvalor1) == '00' .or.  Alltrim(nvalor1) == '0'
								nvalor1 := Replace( TRB1->PRCUNI ,'.','')
								nvalor1 :=(val(nvalor1)+(val(nvalor1)*(mv_Par09/10000)))
							else
								nvalor1 :=(val(nvalor1))
							EndIf
							nvalor1	:= nvalor1/100
							nValor	:= nvalor1
							
							//------------------------------------------------------
							// INICIO - Angelo Henrique - Data:26/07/2018
							//------------------------------------------------------
							// Atualiza็ใo do importador para pegar sigla PMC o PFB
							// e o valor de fabrica, caso o produto tenho este
							// valor preenchido no arquivo
							//------------------------------------------------------
							If Val(Replace( TRB1->PRCUNI ,'.','')) <> 0
								
								cTpPrec	:= "2"  //1=PMC;2=PFB
								nVlFab	:= Val(TRB1->PRCUNI)
								
							Else
								
								cTpPrec	:= "1"  //1=PMC;2=PFB
								nVlFab	:= 0
								
							EndIf
							//------------------------------------------------------
							// FIM - Angelo Henrique - Data:26/07/2018
							//------------------------------------------------------
							
							EXIT
						EndIf
					EndIf
					TRB1->(DbSkip())
				EndDo
				
				If TRB1->(Eof())
					TRB1->(DbGotop())
					TRB->(dbSkip())
					Loop
				EndIf
				
			Else
				nvalor1  := val(Replace( TRB->PRCUNI ,',','.'))
				//nvalor1	:= val(nvalor1)/100
				nValor	:= nvalor1
				
				//------------------------------------------------------
				// INICIO - Angelo Henrique - Data:26/07/2018
				//------------------------------------------------------
				// Atualiza็ใo do importador para pegar sigla PMC o PFB
				// neste momento o medicamento s๓ possui valor para
				// PMC, logo o campo de valor do PFB permanece zerado.
				//------------------------------------------------------
				cTpPrec	:= "1"  //1=PMC;2=PFB
				nVlFab	:= 0
				//------------------------------------------------------
				// FIM - Angelo Henrique - Data:26/07/2018
				//------------------------------------------------------
				
			EndIf
			
			if !empty(TRB->TUSS)
				cCodPro := TRB->TUSS//Leonardo Portella - 14/01/15
			Else
				
				//Leonardo Portella - 30/07/15 - Inicio - Alterar tamanho dos codigos para 8 conforme TUSS. Tabela BTU espera
				//tamanho 8. A numeracao sempre vem com 00 na frente e com 10 digitos.
				
				If len(Alltrim(TRB->NUMTIS)) == 8
					cCodPro := TRB->NUMTIS
				Else
					
					//Nao importo se tiver mais que 8 digitos e os 2 primeiros diferentes de 00
					If Left(Alltrim(TRB->NUMTIS),2) <> '00'
						TRB->(dbSkip())
						Loop
					Else
						// MBC	cCodPro := Substr(Alltrim(TRB->NUMTIS),3,8)
						cCodPro := TRB->NUMTIS//Substr(Alltrim(TRB->NUMTIS),3,8)
					EndIf
					
					//Leonardo Portella - 30/07/15 - Fim
					
				EndIf
				
				cCdPaDp := GETMV("MV_XCODBRA")
				// MBC cCdPaDp := '00'
				
			endIf
			
			//Leonardo Portella - 08/09/14 - Inํcio - A tabela em que serแ incluido o procedimento deve ser determinada pela
			//ANS atrav้s da teminologia TUSS
			
			//Ao inv้s de fazer por query, vou fazer por DbSeek para utilizar o ํndice pois a BTQ possui muitos dados.
			
			BTQ->(DbSetOrder(1))//BTQ_FILIAL+BTQ_CODTAB+BTQ_CDTERM
			
			If BTQ->(DbSeek(xFilial('BTQ') + '18' + cCodPro))//Diแrias, taxas e gases medicinais
				cCdPaDp := BTQ->BTQ_CODTAB
				If !(_cTpProc $ '3,4,7')//Taxas,Diarias,Gases Medicinais
					_cTpProc := '3'
				EndIf
			ElseIf BTQ->(DbSeek(xFilial('BTQ') + '19' + cCodPro))//OPME e Materiais - BRASINDICE SOMENTE MATERIAIS
				cCdPaDp := BTQ->BTQ_CODTAB
				If _cTpProc <> '1'//Material
					_cTpProc := '1'
				EndIf
			ElseIf BTQ->(DbSeek(xFilial('BTQ') + '20' + cCodPro))//Medicamentos
				cCdPaDp := BTQ->BTQ_CODTAB
				If _cTpProc <> '2'//Medicamento
					_cTpProc := '2'
				EndIf
				
			Else
				
				cCodPro := cCodPro
				cCdPaDp := GETMV("MV_XCODBRA")
				
			EndIf
			
			BR4->(DbSetOrder(1))
			
			If BR4->(DbSeek(xFilial('BR4') + cCdPaDp))
				BF8->(DbSetOrder(2))//BF8_FILIAL, BF8_CODPAD, BF8_CODINT, BF8_CODIGO
				If BF8->(DbSeek(xFilial('BF8') + cCdPaDp + cOper))
					cCodTab	:= BF8->(BF8_CODINT + BF8_CODIGO)
				Else
					c_MsgLog := 'Tabela [ ' + cCdPaDp + ' ] nใo localizada na tabela de honorarios (BF8)'
					
					//Se nใo encontrar na tabela de honorarios (BF8) nใo inclui
					TRB->(dbSkip())
					Loop
				EndIf
			Else
				c_MsgLog := 'Tabela [ ' + cCdPaDp + ' ] nใo localizada na tipos de tabela (BR4)'
				
				//Se nใo encontrar na tipos de tabela (BR4) nใo inclui
				TRB->(dbSkip())
				Loop
			EndIf
			
			//Leonardo Portella - 08/09/14 - Fim
			
			//Leonardo Portella - 12/12/14 - Inicio - Se o valor estiver zerado, nao importar
			
			If nValor <= 0
				TRB->(dbSkip())
				Loop
			EndIf
			
			//Leonardo Portella - 12/12/14 - Fim
			
			//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
			//ณ Grava BA8 - TDE Cabecalho                                                ณ
			//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
			
			BR8->(DbSetOrder(1))
			If BR8->(DbSeek(xFilial("BR8") + cCdPaDp + cCodPro ))
				//Temporario. So vou importar primeiros arquivos para incluir Brasindice das outras tabelas (18 e 20)
				If ( cCdPaDp == '19' )// .and. !empty(BR8->BR8_LEMBRE)
					TRB->(dbSkip())
					Loop
				EndIf
			EndIf
			
			dbSelectArea("BA8")
			dbSetOrder(1)
			
			cChvBA8 := xFilial("BA8") + cCodTab + cCdPaDp + cCodPro
			
			//Leonardo Portella - Inicio - Temporario!!!!!
			If BA8->(DbSeek(cChvBA8))
				While !BA8->(EOF()) .and. ( BA8->(BA8_FILIAL + BA8_CODTAB + BA8_CDPADP + BA8_CODPRO) == cChvBA8 )
					If ( cCdPaDp == '19' ) .and. ( ( cEmpAnt == '01' .and. ( BA8->(RECNO()) < 663345 ) ) .or. ( cEmpAnt == '02' .and. ( BA8->(RECNO()) < 523231 ) ) )
						BA8->(Reclock('BA8',.F.))
						BA8->(DbDelete())
						BA8->(MsUnlock())
						
						lBA8		:= .T.
					EndIf
					
					BA8->(DbSkip())
				EndDo
				
				BA8->(DbGoTop())
			EndIf
			//Leonardo Portella - Fim - Temporario!!!!!
			
			If !BA8->(DbSeek(cChvBA8))
				BA8->(RecLock("BA8",.T.))
				BA8->BA8_FILIAL := xFilial("BA8")
				BA8->BA8_CDPADP := cCdPaDp
				BA8->BA8_CODPRO := cCodPro
				BA8->BA8_DESCRI := UPPER( Alltrim(TRB->DESMED)+Space(1)+Alltrim(TRB->DESAPR))
				
				If cCdPaDp == "23"
					
					BA8->BA8_NIVEL  := "3"
					
				Else
					
					BA8->BA8_NIVEL  := cNivel
					
				EndIf
				
				BA8->BA8_UNIDAD := ""  //Substituir apos cadastro de unidades por Funcao Posicione("ALIAS TABELA",Indice,Chave,"CAMPO_RETORNO")
				BA8->BA8_ANASIN := cAnaSin
				BA8->BA8_CODPAD := cCdPaDp
				BA8->BA8_CODTAB := cCodTab
				BA8->BA8_CODANT := ""
				BA8->(msUnLock())
				
				lBA8		:= .T.
			Else
				BA8->(RecLock("BA8",.F.))
				BA8->BA8_DESCRI := UPPER( Alltrim(TRB->DESMED)+Space(1)+Alltrim(TRB->DESAPR) )
				BA8->BA8_NIVEL  := cNivel
				BA8->BA8_UNIDAD := '1'
				BA8->BA8_ANASIN := cAnaSin
				BA8->BA8_CODPAD := cCdPaDp
				BA8->BA8_CODTAB := cCodTab
				BA8->(msUnLock())
				
				lBA8		:= .T.
			Endif
			
			//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
			//ณ Grava BD4 - TDE Detalhe                                                  ณ
			//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
			
			//Leonardo Portella - Inicio - Temporario!!!!!
			If BD4->(DbSeek(xFilial("BD4") + cCodTab + cCdPaDp + cCodPro)) .and. (BD4->BD4_CODIGO == cCodigo)
				While BD4->(BD4_CODTAB+BD4_CDPADP+BD4_CODPRO+BD4_CODIGO)==(cCodTab + cCdPaDp + cCodPro + Space(len(bd4->bd4_codpro) - len(cCodPro) )+ cCodigo ) .and. ! BD4->(Eof())
					//While BD4->(BD4_CODTAB+BD4_CDPADP+BD4_CODPRO+BD4_CODIGO)==(cCodTab+cCdPaDp+cCodPro+ Space(6)+cCodigo) .and. ! BD4->(Eof())
					//While !BD4->(Eof()) .and. BD4->(BD4_CODTAB+BD4_CDPADP+Alltrim(BD4_CODPRO)+BD4_CODIGO)==(cCodTab+cCdPaDp+cCodPro+cCodigo)
					
					If ( cCdPaDp == '19' ) .and. ( ( cEmpAnt == '01' .and. ( BD4->(RECNO()) < 1580017 ) ) .or. ( cEmpAnt == '02' .and. ( BD4->(RECNO()) < 1370222 ) ) )
						BD4->(Reclock('BD4',.F.))
						BD4->(DbDelete())
						BD4->(MsUnlock())
						
						lBD4		:= .T.
					EndIf
					
					BD4->(DbSkip())
				EndDo
				
				BD4->(DbGoTop())
			EndIf
			//Leonardo Portella - Fim - Temporario!!!!!
			
			//If BD4->(DbSeek(xFilial("BD4") + cCodTab + cCdPaDp + k + Space(6) + cCodigo ))
			If (BD4->(DbSeek(xFilial("BD4") + cCodTab + cCdPaDp + cCodPro + Space(len(bd4->bd4_codpro) - len(cCodPro) )+ cCodigo )))
				
				While BD4->(BD4_CODTAB+BD4_CDPADP+BD4_CODPRO+BD4_CODIGO)==(cCodTab+cCdPaDp+cCodPro+  Space(len(bd4->bd4_codpro) - len(cCodPro) )+cCodigo) .and. ! BD4->(Eof())
					BD4->(DbSkip())
				EndDo
				
				BD4->(DbSkip(-1))
				//AJUSTADO
				If BD4->BD4_VALREF <> round(nValor,4) //BD4->BD4_VALREF <> nValor
					
					BD4->(RecLock("BD4",.F.))
					BD4->BD4_VIGFIM := (dVigIni - 1)
					BD4->(msUnLock())
					
					d_ViFim := BD4->BD4_VIGFIM
					
					
					//---------------------------------------------------------------------------
					//Atualizar o registro anterior e nใo criar outro caso tenha codigo TUSS
					//---------------------------------------------------------------------------
					_cAreBR4 := BR4->(GetArea())
					_cAreBF8 := BF8->(GetArea())
					_cAreBD4 := BD4->(GetArea())
					
					If !(Empty(TRB->TUSS))
						
						BTQ->(DbSetOrder(1))//BTQ_FILIAL+BTQ_CODTAB+BTQ_CDTERM
						
						If BTQ->(DbSeek(xFilial('BTQ') + '18' + TRB->NUMTIS))//Diแrias, taxas e gases medicinais
							
							cCdPSpp := BTQ->BTQ_CODTAB
							
						ElseIf BTQ->(DbSeek(xFilial('BTQ') + '19' + TRB->NUMTIS))//OPME e Materiais - BRASINDICE SOMENTE MATERIAIS
							
							cCdPSpp := BTQ->BTQ_CODTAB
							
						ElseIf BTQ->(DbSeek(xFilial('BTQ') + '20' + TRB->NUMTIS))//Medicamentos
							
							cCdPSpp := BTQ->BTQ_CODTAB
							
						Else
							
							cCdPSpp := GETMV("MV_XCODBRA")
							
						EndIf
						
						BR4->(DbSetOrder(1))
						If BR4->(DbSeek(xFilial('BR4') + cCdPSpp))
							
							BF8->(DbSetOrder(2))//BF8_FILIAL, BF8_CODPAD, BF8_CODINT, BF8_CODIGO
							If BF8->(DbSeek(xFilial('BF8') + cCdPSpp + cOper))
								
								cCodSpp	:= BF8->(BF8_CODINT + BF8_CODIGO)
								
								DbSelectArea("BD4")
								DbSetOrder(1) //BD4_FILIAL+BD4_CODTAB+BD4_CDPADP+BD4_CODPRO+BD4_CODIGO+DTOS(BD4_VIGINI)
								If DbSeek(xFilial("BD4") + cCodSpp + cCdPSpp + TRB->NUMTIS)
									
									While !EOF() .And. Trim(cCodSpp + cCdPSpp + TRB->NUMTIS) ==  Trim(BD4->(BD4_CODTAB+BD4_CDPADP+BD4_CODPRO))
										
										If BD4->BD4_VIGFIM = StoD("20491231")
											
											BD4->(RecLock("BD4",.F.))
											BD4->BD4_VIGFIM := BD4->BD4_VIGINI
											BD4->(msUnLock())
											
										EndIf
										
										BD4->(DbSkip())
										
									EndDo
									
								EndIf
								
							EndIf
							
						EndIf
												
					EndIf
					
					RestArea(_cAreBR4)
					RestArea(_cAreBD4)
					RestArea(_cAreBF8)
					//---------------------------------------------------------------------------
					//Fim corre็ใo cria็ใo de registro anterior com codigo TUSS
					//---------------------------------------------------------------------------
					
					BD4->(RecLock("BD4",.T.))
					BD4->BD4_FILIAL := xFilial("BD4")
					//			BD4->BD4_CODPRO := cCodPro
					BD4->BD4_CODPRO :=(cCodPro+Space(len(bd4->bd4_codpro) - len(cCodPro) ))
					BD4->BD4_CODTAB := cCodTab
					BD4->BD4_CDPADP := cCdPaDp
					BD4->BD4_CODIGO := cCodigo
					BD4->BD4_VALREF := nValor
					BD4->BD4_PORMED := ""
					BD4->BD4_VLMED  := 0
					BD4->BD4_PERACI := 0
					BD4->BD4_VIGINI := d_ViFim+1
					BD4->BD4_VIGFIM := dDatAtu
					
					BD4->BD4_YDTIMP := dDtDigit
					BD4->BD4_YPERIM := nPercent
					BD4->BD4_YUSUR  := _cUsu
					BD4->BD4_YEDICA := Alltrim(TRB->EDBRAS)
					BD4->BD4_YTBIMP := ' '
					
					//----------------------------------------------------
					//INICIO - Angelo Henrique - Data: 25/07/2018
					//----------------------------------------------------
					//Gravando os campos pertinentes ao valor de PFB
					//e o campo que irแ dizer se ้ PMC ou PFB
					//----------------------------------------------------
					BD4->BD4_XTPREC := cTpPrec
					BD4->BD4_XVLFAB := nVlFab
					//----------------------------------------------------
					//FIM - Angelo Henrique - Data: 25/07/2018
					//----------------------------------------------------
					
					BD4->(msUnLock())
					
					lBD4		:= .T.
					
				Else
					
					//---------------------------------------------------------
					//INICIO - Angelo Henrique - Data: 25/07/2018
					//---------------------------------------------------------
					//Na primeira importa็ใo do arquivo, existe a necessidade
					//de atualizar os registros(medicamentos) que foram
					//descontinuados e a rotina s๓ precisa atualizar este
					//registro.
					//---------------------------------------------------------
					If TRB->EDBRAS = BD4->BD4_YEDICA .And. BD4->BD4_VALREF = round(nValor,4) .And. Empty(AllTrim(BD4->BD4_XTPREC))
						
						BD4->(RecLock("BD4",.F.))
						
						BD4->BD4_XTPREC := cTpPrec
						BD4->BD4_XVLFAB := nVlFab
						
						BD4->(msUnLock())
						
					EndIf
					//----------------------------------------------------
					//FIM - Angelo Henrique - Data: 25/07/2018
					//----------------------------------------------------
					
					//lBD4		:= .T.
					
				EndIf
				
			Else
				
				BD4->(RecLock("BD4",.T.))
				BD4->BD4_FILIAL := xFilial("BD4")
				BD4->BD4_CODPRO := cCodPro
				BD4->BD4_CODTAB := cCodTab
				BD4->BD4_CDPADP := cCdPaDp
				BD4->BD4_CODIGO := cCodigo
				BD4->BD4_VALREF := nValor
				BD4->BD4_PORMED := ""
				BD4->BD4_VLMED  := 0
				BD4->BD4_PERACI := 0
				BD4->BD4_VIGINI := dVigIni
				BD4->BD4_VIGFIM := dDatAtu
				
				BD4->BD4_YDTIMP := dDtDigit
				BD4->BD4_YPERIM := nPercent
				BD4->BD4_YUSUR  := _cUsu
				BD4->BD4_YEDICA := Alltrim(TRB->EDBRAS)
				BD4->BD4_YTBIMP := ' '
				
				//----------------------------------------------------
				//INICIO - Angelo Henrique - Data: 25/07/2018
				//----------------------------------------------------
				//Gravando os campos pertinentes ao valor de PFB
				//e o campo que irแ dizer se ้ PMC ou PFB
				//----------------------------------------------------
				BD4->BD4_XTPREC := cTpPrec
				BD4->BD4_XVLFAB := nVlFab
				//----------------------------------------------------
				//FIM - Angelo Henrique - Data: 25/07/2018
				//----------------------------------------------------
				
				BD4->(msUnLock())
				
				lBD4		:= .T.
			Endif
			
			//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
			//ณ Grava BR8 - Tabela Padrao                                                ณ
			//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
			If BR8->(Found())
				BR8->(RecLock("BR8",.F.))
			Else
				BR8->(RecLock("BR8",.T.))
			Endif
			
			lBR8		:= .T.
			
			BR8->BR8_FILIAL := xFilial("BR8")
			BR8->BR8_CODPAD := cCdPaDp
			BR8->BR8_CODPSA := cCodPro
			BR8->BR8_DESCRI := UPPER( Alltrim(TRB->DESMED)+Space(1)+Alltrim(TRB->DESAPR) )
			BR8->BR8_ANASIN := cAnaSin
			
			If cCdPaDp == "23"
				
				BR8->BR8_NIVEL  := "3"
				
			Else
				
				BR8->BR8_NIVEL  := cNivel
				
			EndIf
			
			BR8->BR8_CLASSE := cClasse
			BR8->BR8_BENUTL := "1"
			BR8->BR8_TPPROC := _cTpProc
			BR8->BR8_AUTORI := "1"
			
			BR8->BR8_LEMBRE	:= Left('BRASINDICE - ' + DtoC(Date()) + ' [ ' + IIf(lBD4,'BD4 - ','') + IIf(lBA8,'BA8 - ','') + IIf(lBR8,'BR8','') + ' ]' + IIf(!empty(BR8->BR8_LEMBRE),' Antigo: [ ' + Alltrim(BR8->BR8_LEMBRE) + ' ]',''),TamSx3('BR8_LEMBRE')[1])//Leonardo Portella - 14/01/15
			
			BR8->(MSUnLock())
			
			//Leonardo Portella - 12/12/14 - Inicio - Ao importar os arquivos da BRASINDICE, que existem na BTQ,
			//fazer o vinculo da TISS 3
		/*	
			BTU->(DbSetOrder(3))//BTU_FILIAL, BTU_CODTAB, BTU_ALIAS, BTU_CDTERM
			
			n_RecBTU 	:= 0
			lIncAltBTU := .T.
			
			If BTU->(MsSeek(xFilial('BTU') + cCdPaDp + "BR8" + cCodPro ) )
				While !BTU->( EOF() ) .AND. alltrim(BTU->( BTU_FILIAL + BTU_CODTAB + BTU_ALIAS + BTU_CDTERM)) == alltrim(xFilial('BTU') + cCdPaDp + "BR8" + cCodPro  )
					
					If BTU->BTU_CODTAB == cCdPaDp .AND. Alltrim(BTU->BTU_VLRBUS) == AllTrim(cCodPro)
 					
						lIncAltBTU 	:= .F.
						n_RecBTU 	:= BTU->( RECNO() )
						
					EndIf
					
					BTU->( dbSkip() )
					
				EndDo
			Else
				
				lIncAltBTU := .T.
				
			EndIf
		*/
			n_RecBTU 	:= 0
			lIncAltBTU := .F.

			cSql := " SELECT * FROM " + RETSQLNAME("BTU") + " BTU "
			cSql += "  WHERE BTU_FILIAL = '" + xFilial("BTU") + "'"
			cSql += "    AND BTU_CODTAB = '" + AllTrim(cCdPaDp) + "'"
			cSql += "    AND BTU_VLRSIS = '" + xFilial("BTU") + AllTrim(cCdPaDp) + AllTrim(cCodPro) + "'"
			cSql += "    AND BTU_VLRBUS = '" + AllTrim(cCodPro) + "'"
			cSql += "    AND BTU_CDTERM = '" + AllTrim(cCodPro) + "'"
			cSql += "    AND BTU_ALIAS  = 'BR8' " 
			cSql += "    AND D_E_L_E_T_ = ' ' "

		
			If Select(cAliSql) > 0
				(cAliSql)->(DbCloseArea())
			EndIf
			
			DbUseArea(.T.,"TopConn",TcGenQry(,,cSql),cAliSql,.T.,.T.)
			
			DbSelectArea(cAliSql)

			If !((cAliSql)->(Eof())) 
			
				While !((cAliSql)->(Eof()))
					
					lIncAltBTU 	:= .F.
					n_RecBTU 	:= ((cAliSql)->( RECNO() ) )
					
					((cAliSql)->( dbSkip() ) )

				EndDo
								
				If Select(cAliSql)>0
					(cAliSql)->(DbCloseArea())
				EndIf

			Else
				
				lIncAltBTU := .T.
			
			Endif

			If lIncAltBTU
				BTU->(Reclock('BTU',.T.))
				
				BTU->BTU_FILIAL := xFilial('BTU')
				BTU->BTU_CODTAB	:= cCdPaDp
				BTU->BTU_VLRSIS	:= ( xFilial('BR8') + cCdPaDp + cCodPro )
				BTU->BTU_VLRBUS := cCodPro
				BTU->BTU_CDTERM	:= cCodPro
				BTU->BTU_ALIAS	:= "BR8"
				
				BTU->(MsUnlock())
				
			EndIf
			
			//Atualizo na terminologia pois o vinculo foi criado
			If BTQ->(Found())
				
				BTQ->(Reclock('BTQ',.F.))
				
				BTQ->BTQ_HASVIN = '1'
				
				BTQ->(MsUnlock())
				
			EndIf
			
			TRB->(dbSkip())
			IncProc()
			
		EndDo
		
		TRB->(DbCloseArea())
		
	EndTran()
	//End Transaction
	
	MsgBox('Importa็ใo concluํda','Fim do Processamento','ALERT')
	
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCarregaArqบAutor  ณ Jean Schulz        บ Data ณ  09/08/06   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณCarrega o arquivo repassado para memoria                    บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Caberj                                                     บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function CarregaArq(cArqTxt,seq)
	
	Local cDirLido  := "C:\Brasindice\PROCESSADOS\"
	Local cFileDest := Alltrim(cDirLido+substr(Alltrim(cArqTxt),-10))
	Local nTipArq   := mv_par07
	
	if seq== 1
		
		dbSelectArea('TRB')
		
	else
		
		dbSelectArea('TRB1')
		
	endIf
	
	Append From &(cArqTxt) SDF
	
	COPY FILE &cArqTxt TO &cFileDest
	
	DbGotop()
	
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCriaSX1 บAutor  ณJean Schulz         บ Data ณ  27/07/06   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณValidar perguntas de usuario.                               บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Caberj                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function CriaSX1()
	
	PutSx1(cPerg,"01",OemToAnsi("Operadora:")				,"","","mv_ch1","C",04,0,0,"G","","B89PLS","","","mv_par01","","","","","","","","","","","","","","","","",{},{},{})
	PutSx1(cPerg,"02",OemToAnsi("Tipo de Importacao?")		,"","","mv_ch2","C",01,0,0,"C","","","","","mv_par02","Materiais ","","","","Medicamentos","","","Solu็๕es","","","","","","","","",{},{},{})
	PutSx1(cPerg,"03",OemToAnsi("Informe a tabela:")		,"","","mv_ch3","C",03,0,0,"G","","_F8","","","mv_par03","","","","","","","","","","","","","","","","",{},{},{})
	PutSx1(cPerg,"04",OemToAnsi("Data Vig๊ncia de:")		,"","","mv_ch4","D",08,0,0,"G","","","","","mv_par04","","","","","","","","","","","","","","","","",{},{},{})
	PutSx1(cPerg,"05",OemToAnsi("Data Vig๊ncia At้:")		,"","","mv_ch5","D",08,0,0,"G","","","","","mv_par05","","","","","","","","","","","","","","","","",{},{},{})
	PutSx1(cPerg,"06",OemToAnsi("Unidade de valor:")		,"","","mv_ch6","C",03,0,0,"G","","B87PLS","","","mv_par06","","","","","","","","","","","","","","","","",{},{},{})
	PutSx1(cPerg,"07",OemToAnsi("Tipo de Arquivo")		    ,"","","mv_ch7","N",01,0,0,"C","","","","","mv_par07","Delimitado","","","","Tamanho Fixo","","","","","","","","","","","",{},{},{})
	PutSx1(cPerg,"08",OemToAnsi("Versao do Brasindice")	    ,"","","mv_ch8","N",01,0,0,"C","","","","","mv_par08","Antigo","","","","Novo","","","","","","","","","","","",{},{},{})
	PutSx1(cPerg,"09",OemToAnsi("% เ Aplicar :")		    ,"","","mv_ch9","N",05,0,0,"G","","","","","mv_par09","","","","","","","","","","","","","","","","",{},{},{})
	
RETURN