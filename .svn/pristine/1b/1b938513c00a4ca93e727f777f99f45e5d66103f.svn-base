#INCLUDE "RWMAKE.CH"
#INCLUDE "PROTHEUS.CH"

/*/{Protheus.doc} CABA094
Rotina que irá executar a baixa automática da PREVI
@type function
@author angelo.cassago
@since 10/02/2020
@version 1.0
@return ${return}, ${return_description}
@example
(examples)
@see (links_or_references)
/*/
User Function CABA094()
	
	Local oDlg1 := Nil
	Local oGrp1 := Nil
	Local oSay1 := Nil
	Local oSay2 := Nil
	Local oSay3 := Nil
	Local oBtn1 := Nil
	Local oBtn5 := Nil
	Local oBtn2 := Nil
	
	oDlg1      := MSDialog():New( 092,232,265,649,"Processo de Baixa de Titulos PREVI",,,.F.,,,,,,.T.,,,.T. )
	
	oGrp1      := TGroup():New( 004,004,076,200,"      Rotina para realizar a baixa de titulos PREVI       ",oDlg1,CLR_HBLUE,CLR_WHITE,.T.,.F. )
	
	oSay1      := TSay():New( 016,012,{||"Nesta tela será possível retirar as seguintes informações:"			},oGrp1,,,.F.,.F.,.F.,.T.,CLR_HBLUE,CLR_WHITE,144,008)
	oSay2      := TSay():New( 028,012,{||"1 - Leitura de arquivo .CSV contendo os titulos para efetuar a Baixa"	},oGrp1,,,.F.,.F.,.F.,.T.,CLR_HBLUE,CLR_WHITE,184,008)
	oSay3      := TSay():New( 040,012,{||"2 - Apresentar Layout para a Importação"								},oGrp1,,,.F.,.F.,.F.,.T.,CLR_HBLUE,CLR_WHITE,136,008)
	
	oBtn1      := TButton():New( 056,008,"1 - Ler arquivo .CSV para baixa"	,oGrp1,{||U_CABA094A()	},088,012,,,,.T.,,"",,,,.F. )
	oBtn5      := TButton():New( 056,100,"2 - Layout"						,oGrp1,{||U_CABA094B()	},048,012,,,,.T.,,"",,,,.F. )
	oBtn2      := TButton():New( 056,152,"Fechar"							,oGrp1,{||oDlg1:End()	},044,012,,,,.T.,,"",,,,.F. )
	
	oDlg1:Activate(,,,.T.)
	
Return


/*/{Protheus.doc} CABA094
Rotina que irá executar a baixa automática da PREVI
@type function
@author angelo.cassago
@since 10/02/2020
@version 1.0
@return ${return}, ${return_description}
@example
(examples)
@see (links_or_references)
/*/
User Function CABA094A()
	
	
	Local aArea    		:= GetArea()
	Local cDescr		:= ""
	Local cFlag			:= .F.
	
	Private cArqCSV		:= "C:\"
	Private nOpen		:= -1
	Private cDiretorio	:= " "
	Private oDlg		:= Nil
	Private oGet1		:= Nil
	Private oGrp1		:= Nil
	Private oSay1		:= Nil
	Private lEnd	    := .F.
	
	cDescr := "Este programa irá realizar o cancelamento dos títulos do Contas a Receber apartir de um arquivo CSV."
	
	oDlg              := MSDialog():New( 095,232,301,762,"Rotina para CAncelamento Automático de Títulos a Receber",,,.F.,,,,,,.T.,,,.T. )
	oGet1             := TGet():New( 062,020,{||cArqCSV},oDlg,206,008,,,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cArqCSV",,)
	oGet1:lReadOnly   := .T.
	
	oButton1          := TBrowseButton():New( 062,228,'...',oDlg,,022,011,,,.F.,.T.,.F.,,.F.,,,)
	
	*'-----------------------------------------------------------------------------------------------------------------'*
	*'Buscar o arquivo no diretorio desejado.                                                                          '*
	*'Comando para selecionar um arquivo.                                                                              '*
	*'Parametro: GETF_LOCALFLOPPY - Inclui o floppy drive local.                                                       '*
	*'          GETF_LOCALHARD   - Inclui o Harddisk local.                                                            '*
	*'-----------------------------------------------------------------------------------------------------------------'*
	
	oButton1:bAction  := {||cArqCSV := cGetFile("Arquivos CSV (*.CSV)|*.csv|","Selecione o .CSV a importar",1,cDiretorio,.T.,GETF_LOCALHARD)}
	oButton1:cToolTip := "Importar CSV"
	
	oGrp1             := TGroup():New( 008,020,050,252,"",oDlg,CLR_BLACK,CLR_WHITE,.T.,.F. )
	oSay1             := TSay():New( 016,028,{||cDescr},oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,226,030)
	oButton2          := tButton():New(082,092,'Avançar' ,oDlg,,35,15,,,,.T.)
	oButton2:bAction  := {||If(empty(cArqCSV) .or. right(allTrim(lower(cArqCSV)),4) != ".csv",MsgAlert("Informe um arquivo!","Aviso"),(cFlag := .T.,oDlg:End()))}
	oButton2:cToolTip := "Ir para o próximo passo"
	
	oButton3          := tButton():New(082,144,'Cancelar',oDlg,,35,15,,,,.T.)
	oButton3:bAction  := {||cFlag := .F.,fClose(nOpen),oDlg:End()}
	oButton3:cToolTip := "Cancela a importação"
	
	oDlg:Activate(,,,.T.)
	
	If cFlag == .T.
		Processa({|lEnd|ImportCSV(@lEnd, cArqCSV)},"Aguarde...","",.T.)
	EndIf
	
	RestArea(aArea)
	
Return


//-------------------------------------------------------------------
/*/{Protheus.doc} function
Rotina que irá iniciar o processo da validação/importação do arquivo
CSV
@author  Angelo Henrique
@since   14/02/2020
@version version
/*/
//-------------------------------------------------------------------
Static Function ImportCSV(lEnd,cArqCSV)
	
	Local cLinha 		:= ""
	Local nTotal		:= 0
	Local aStruc      	:= {}
	Local lInicio 		:= .T.
	Local lCabecOk 		:= .T.
	
	Private aLinha		:= {}
	Private a_ItFim     := {}
	Private a_Cab		:= {"Titulo","Valor","Concluido","Mensagem"}
	Private nLinhaAtu  	:= 0
	Private nTit	    := 0
	Private nValor		:= 0
	Private nDtBx	    := 0
	Private nBanco		:= 0
	Private nAgnc	    := 0
	Private nConta    	:= 0
	Private nHisto    	:= 0
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Criacao do arquivo temporario...                                    ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	aAdd(aStruc,{"CAMPO","C",500,0})
	
	cTrbPos := CriaTrab(aStruc,.T.)
	
	If Select("TrbPos") <> 0
		TrbPos->(dbCloseArea())
	End
	
	DbUseArea(.T.,,cTrbPos,"TrbPos",.T.)
	
	//-------------------------------------------------
	// importa arquivo para tabela temporária
	//-------------------------------------------------
	PLSAppTmp(cArqCSV)
	
	TRBPOS->(DbGoTop())
	
	If TRBPOS->(EOF())
		MsgStop("Arquivo Vazio!")
		TRBPOS->(DBCLoseArea())
		Return
	End
	
	nTotal := TRBPOS->(LastRec()-1)
	
	ProcRegua(nTotal)
	
	TRBPOS->(DbGoTop())
	
	While !TRBPOS->(Eof())
		
		If lEnd
			MsgAlert("Interrompido pelo usuário","Aviso")
			Return
		EndIf
		
		++nLinhaAtu
		
		IncProc("Processando a Linha número " + allTrim(Str(nLinhaAtu-1)) + " De " + cValTochar(nTotal))
		
		//-----------------------------------------------------------------------
		// Faz a leitura da linha do arquivo e atribui a variável cLinha
		//-----------------------------------------------------------------------
		cLinha := UPPER(TRBPOS->CAMPO)
		
		//-----------------------------------------------------------------------
		// Se ja passou por todos os registros da planilha CSV sai do while
		//-----------------------------------------------------------------------
		if Empty(cLinha) .OR. substring(cLinha,1,1) == ";"
			Exit
		EndIf
		
		//-----------------------------------------------------------------------
		// Transfoma todos os ";;" em "; ;", de modo que o StrTokArr irá retornar
		// sempre um array com o número de colunas correto.
		//-----------------------------------------------------------------------
		cLinha := strTran(cLinha,";;","; ;")
		cLinha := strTran(cLinha,";;","; ;")
		
		//-----------------------------------------------------------------------
		// Para que o último item nunca venha vazio.
		//-----------------------------------------------------------------------
		cLinha += " ;"
		
		aLinha := strTokArr(cLinha,";")
		
		If lInicio
			lInicio := .F.
			IncProc("Lendo cabeçalho...De: "+cValTochar(nTotal))
			
			if !lLeCabec(aLinha)
				MsgAlert("Cabeçalho inválido, favor verificar e reimportar","Aviso")
				Return
			else
				lCabecOk :=  .T.
			endif
			//-----------------------------------------------------------------------
			// Não continua se o cabeçalho não estiver Ok
			//-----------------------------------------------------------------------
			
		Else
			
			//-----------------------------------------------------------------------
			// não é linha em branco
			//-----------------------------------------------------------------------
			If len(aLinha) > 0
				
				*'-------------------------------------------------------------------'*
				*'Função para gravar as informações do arquivo na tabela EMS_IMPORTA
				*'-------------------------------------------------------------------'*
				fProcDad(aLinha)
				
			EndIf
			
		EndIf
		
		TRBPOS->(dbskip())
		
	EndDo
	
	If Len(a_ItFim) > 0
		
		DlgToExcel({{"ARRAY","Informações Baixa Titulos PREVI ", a_Cab, a_ItFim}})
		
	EndIf
	
	Aviso("Atenção","Importação de lançamentos finalizada..",{"OK"})
	
Return

//-------------------------------------------------------------------
/*/{Protheus.doc} function PLSAppTmp
Realiza o append do arquivo em uma tabela temporaria
@author  author
@since   date
@version version
/*/
//-------------------------------------------------------------------
Static Function PLSAppTmp(cNomeArq)
	
	DbSelectArea("TRBPOS")
	Append From &(cNomeArq) SDF
	
Return

//-------------------------------------------------------------------
/*/{Protheus.doc} function lLeCabec
Rotina para validar o cabeçalho que irá vir no CSV
@author  author
@since   date
@version version
/*/
//-------------------------------------------------------------------
Static Function lLeCabec(aLinha)
	
	Local lRet 		:= .T.
	Local _ni		:= 0
	
	//------------------------------------------------------------------------------
	//Realizando o tratamento no cabeçalho antes de executar as validações
	//------------------------------------------------------------------------------
	For _ni := 1 To Len(aLinha)
		
		aLinha[_ni] := u_SemAcento(UPPER(AllTrim(aLinha[_ni])))
		
	Next _ni
	
	
	nTit	:= aScan(aLinha,{|x| Alltrim(UPPER(x)) == "TITULO" 	    })
	nValor	:= aScan(aLinha,{|x| Alltrim(UPPER(x)) == "VALOR" 		})
	nDtBx	:= aScan(aLinha,{|x| Alltrim(UPPER(x)) == "DTBAIXA" 	})
	nBanco	:= aScan(aLinha,{|x| Alltrim(UPPER(x)) == "BANCO" 		})
	nAgnc	:= aScan(aLinha,{|x| Alltrim(UPPER(x)) == "AGENCIA" 	})
	nConta  := aScan(aLinha,{|x| Alltrim(UPPER(x)) == "CONTA" 	    })
	nHisto  := aScan(aLinha,{|x| Alltrim(UPPER(x)) == "HISTORICO" 	})
	
	If nTit	= 0
		
		lRet := .F.
		
	ElseIf nValor = 0
		
		lRet := .F.
		
	ElseIf nDtBx = 0
		
		lRet := .F.
		
	ElseIf nBanco = 0
		
		lRet := .F.
		
	ElseIf nAgnc = 0
		
		lRet := .F.
		
	ElseIf nConta = 0
		
		lRet := .F.
		
	ElseIf nHisto = 0
		
		lRet := .F.
		
	EndIf
	
Return lRet

//-------------------------------------------------------------------
/*/{Protheus.doc} function fProcDad
Rotina que irá realizar o processamento dos dados
@author  Angelo Henrique
@since   17/02/2020
@version version
/*/
//-------------------------------------------------------------------
Static Function fProcDad(aLinha)
	
	Local _aArea 	:= GetArea()
	Local _aArSE1 	:= SE1->(GetArea())
	Local _aArSE5 	:= SE5->(GetArea())
	Local _aArSA6 	:= SA6->(GetArea())
	Local _na       := 0
	Local _nValFim	:= 0
	Local _cBanco	:= ""
	Local _cAgenc	:= ""
	Local _cConta 	:= ""
	
	//-------------------------------------------------------------------------------
	//Antes de realizar a gravação verificar se existem ainda caracteres especiais
	//-------------------------------------------------------------------------------
	For _na := 1 To Len(aLinha)
		
		aLinha[_na] := Replace(Replace(AllTrim(aLinha[_na]),'"',''),'=','')
		
	Next _na
	
	_nValFim := Replace(aLinha[nValor],".","")
	_nValFim := VAL(Replace(_nValFim,",","."))
	
	_cBanco	:= PADR(AllTrim(aLinha[nBanco]),TAMSX3("E5_BANCO"  )[1])
	_cAgenc	:= PADR(AllTrim(aLinha[nAgnc] ),TAMSX3("E5_AGENCIA")[1])
	_cConta	:= PADR(AllTrim(aLinha[nConta]),TAMSX3("E5_CONTA"  )[1])
	
	DbSelectArea("SA6")
	DbSetOrder(1) //A6_FILIAL+A6_COD+A6_AGENCIA+A6_NUMCON
	If DbSeek(xFilial("SA6") + _cBanco + _cAgenc + _cConta)
		
		DbSelectArea("SE1")
		DbSetOrder(1)
		If DbSeek(aLinha[nTit])
			
			If Empty(SE1->E1_BAIXA)
				
				aDadSe1 := {{"E1_PREFIXO"  ,SE1->E1_PREFIXO 		, Nil }, ;
					{"E1_NUM"      ,SE1->E1_NUM     				, Nil }, ;
					{"E1_PARCELA"  ,SE1->E1_PARCELA 				, Nil }, ;
					{"E1_TIPO"     ,SE1->E1_TIPO    				, Nil }, ;
					{"E1_CLIENTE"  ,SE1->E1_CLIENTE 				, Nil }, ;
					{"E1_LOJA"     ,SE1->E1_LOJA    				, Nil }, ;
					{"AUTMOTBX"    ,"NOR"           				, Nil }, ;
					{"AUTBANCO"    ,_cBanco   						, Nil }, ;
					{"AUTAGENCIA"  ,_cAgenc   						, Nil }, ;
					{"AUTCONTA"    ,_cConta   						, Nil }, ;
					{"AUTDTBAIXA"  ,CTOD(AllTrim(aLinha[nDtBx]))  	, Nil }, ;
					{"AUTDTCREDITO",CTOD(AllTrim(aLinha[nDtBx]))  	, Nil }, ;
					{"AUTHIST"     ,AllTrim(aLinha[nHisto])     	, Nil }, ;
					{"AUTVALREC"   ,_nValFim		   				, Nil }  }
				
				lMsErroAuto := .F.
				MsExecAuto({ |x,y| Fina070(x,y)},aDadSe1,3)
				
				If lMsErroAuto
					
					DisarmTransaction()
					
					aaDD(a_ItFim,{ aLinha[nTit] , _nValFim , "Não" , "2 - Baixa não pode ser efetuada, erro em efetuar a baixa" })
					
				else
					
					aaDD(a_ItFim,{ aLinha[nTit] , _nValFim , "Sim" , "1 - Baixa realizada com sucesso." })
					
				Endif
				
			Else
				
				aaDD(a_ItFim,{ aLinha[nTit] , _nValFim , "Não" , "3 - Titulo ja baixado ou parcialmente baixado " })
				
			EndIf
			
		Else
			
			aaDD(a_ItFim,{ aLinha[nTit] , _nValFim , "Não" , "4 - Titulo nao encontrado" })
			
		EndIf
		
	Else
		
		aaDD(a_ItFim,{ aLinha[nTit] , _nValFim , "Não" , "5 - Informações banco, agência ou conta estão incoerentes, favor revisar" })
		aaDD(a_ItFim,{ aLinha[nTit] , _nValFim , "Não" , "5.1 - Banco: " 	+ AllTrim(aLinha[nBanco]) + "." })
		aaDD(a_ItFim,{ aLinha[nTit] , _nValFim , "Não" , "5.2 - Agência: " 	+ AllTrim(aLinha[nAgnc] ) + "." })
		aaDD(a_ItFim,{ aLinha[nTit] , _nValFim , "Não" , "5.3 - Conta: " 	+ AllTrim(aLinha[nConta]) + "." })
		aaDD(a_ItFim,{ aLinha[nTit] , _nValFim , "Não" , "5.4 - Observação: O problema pode estar no 0 (Zero) que fica na frente da conta, veja se o mesmo esta faltando no arquivo CSV." })
		
	EndIf
	
	RestArea(_aArSA6)
	RestArea(_aArSE5)
	RestArea(_aArSE1)
	RestArea(_aArea )
	
Return


/*/{Protheus.doc} CABA094B

Rotina Utilizada para gerar o layout de importação

@type function
@author angelo.cassago
@since 26/12/2019
@version 1.0
/*/
User Function CABA094B
	
	Local a_vet 	:= {}
	Local a_Cabec 	:= {}
	Local c_titulo	:= "Layout para realizar a Baixa dos Titulos PREVI"					
	
	a_Cabec := {"TITULO","VALOR","DTBAIXA","BANCO","AGENCIA","CONTA","HISTORICO"}
	
	aadd(a_vet,{ "'01PLS000000000" , "'999,99" , "20/01/2020" , "341" , "6015", "'017251", "BAIXA RIO PREVI XX.XX" })

	
	DlgToExcel({{"ARRAY", c_titulo, a_Cabec, a_vet}})
	
Return