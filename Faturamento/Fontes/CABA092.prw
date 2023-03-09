#INCLUDE "RWMAKE.CH"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "TBICONN.CH"
#INCLUDE "TOPCONN.CH"
#INCLUDE 'FONT.CH'
#INCLUDE 'COLORS.CH'
#include "TOTVS.CH"

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  � CABA092    � Autor � Angelo Henrique    � Data �  21/05/19 ���
�������������������������������������������������������������������������͹��
���Descricao � Rotina para importar lan�amentos de d�bito e cr�dito       ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � CABERJ                                                     ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/

User Function CABA092()
	Local aArea    		:= GetArea()
	Local cDescr		:= ""
	Local cFlag			:= .F.
	
	Private cProg       := "CABA092"
	Private cArqCSV		:= "C:\"
	Private nOpen		:= -1
	Private cDiretorio	:= " "
	Private oDlg		:= Nil
	Private oGet1		:= Nil
	Private oBtn1		:= Nil
	Private oGrp1		:= Nil
	Private oSay1		:= Nil
	Private oSBtn1		:= Nil
	Private oSBtn2		:= Nil
	Private oCombo		:= Nil
	Private nLinhaAtu  	:= 0
	Private cTrbPos
	Private lEnd	    := .F.
	Private _cTime		:= TIME()
	Private _aDadGrv	:= {}
	
	cDescr := "Este programa ir� importar os lan�amentos de D�bito /Cr�dito apartir de um arquivo CSV."
	
	oDlg              := MSDialog():New( 095,232,301,762,"Importa��o Lan�amento Cr�dito / D�bito",,,.F.,,,,,,.T.,,,.T. )
	oGet1             := TGet():New( 062,020,{||cArqCSV},oDlg,206,008,,,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cArqCSV",,)
	oGet1:lReadOnly   := .T.
	
	oButton1          := TBrowseButton():New( 062,228,'...',oDlg,,022,011,,,.F.,.T.,.F.,,.F.,,,)
	
	*-----------------------------------------------------------------------------------------------------------------*
	*Buscar o arquivo no diretorio desejado.                                                                          *
	*Comando para selecionar um arquivo.                                                                              *
	*Parametro: GETF_LOCALFLOPPY - Inclui o floppy drive local.                                                       *
	*           GETF_LOCALHARD   - Inclui o Harddisk local.                                                           *
	*-----------------------------------------------------------------------------------------------------------------*
	
	oButton1:bAction  := {||cArqCSV := cGetFile("Arquivos CSV (*.CSV)|*.csv|","Selecione o .CSV a importar",1,cDiretorio,.T.,GETF_LOCALHARD)}
	oButton1:cToolTip := "Importar CSV"
	
	oGrp1             := TGroup():New( 008,020,050,252,"",oDlg,CLR_BLACK,CLR_WHITE,.T.,.F. )
	oSay1             := TSay():New( 016,028,{||cDescr},oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,226,030)
	oButton2          := tButton():New(082,092,'Avan�ar' ,oDlg,,35,15,,,,.T.)
	oButton2:bAction  := {||If(empty(cArqCSV) .or. right(allTrim(lower(cArqCSV)),4) != ".csv",MsgAlert("Informe um arquivo!"),(cFlag := .T.,oDlg:End()))}
	oButton2:cToolTip := "Ir para o pr�ximo passo"
	
	oButton3          := tButton():New(082,144,'Cancelar',oDlg,,35,15,,,,.T.)
	oButton3:bAction  := {||cFlag := .F.,fClose(nOpen),oDlg:End()}
	oButton3:cToolTip := "Cancela a importa��o"
	
	
	oButton4          := tButton():New(082,195,'Excluir',oDlg,,35,15,,,,.T.)
	oButton4:bAction  := {||fExclui(lEnd),oDlg:End()}
	oButton4:cToolTip := "Exclui lan�amentos importados"

	
	oDlg:Activate(,,,.T.)
	
	If cFlag == .T.
		Processa({|lEnd|ImportCSV(@lEnd, cArqCSV)},"Aguarde...","",.T.)
	EndIf
	
	RestArea(aArea)
	
Return

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  � ImportCSV  � Autor � Angelo Henrique    � Data �  08/01/19 ���
�������������������������������������������������������������������������͹��
���Descricao � Efetua a importal�ao do arquivo .CSV                       ���
�������������������������������������������������������������������������͹��
���Uso       � CABERJ                                                     ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/

Static Function ImportCSV(lEnd,cArqCSV)
	
	Local cLinha 		:= ""
	Local nTotal		:= 0
	Local aStruc      	:= {}
	Local _ntot 		:= 0
	Local cArq    		:= Replace(UPPER(cArqCSV),".CSV","_LOG.TXT")
	Local nHandle 		:= FCreate(cArq)
	
	Private nMat 		:= 0
	Private nValor	 	:= 0
	Private nObs	   	:= 0
	Private nAno	  	:= 0
	Private nMes		:= 0
	Private nCdLan     	:= 0
	Private nDbCrd   	:= 0
	
	Private _cTime		:= TIME() //Hora inicial da importa��o
	Private aLinha		:= {}
	
	Private a_ItFim     := {}
	Private a_Cab		:= {"Matricula","Ano","Mes","Lan�amento","Mensagem"}	
		
	//���������������������������������������������������������������������Ŀ
	//� Criacao do arquivo temporario...                                    �
	//�����������������������������������������������������������������������
	aAdd(aStruc,{"CAMPO","C",500,0})
	
	cTrbPos := CriaTrab(aStruc,.T.)
	
	If Select("TrbPos") <> 0
		TrbPos->(dbCloseArea())
	End
	
	DbUseArea(.T.,,cTrbPos,"TrbPos",.T.)
	
	lInicio 	:= .T.
	lCabecOk 	:= .T.
	
	//-------------------------------------------------
	// importa arquivo para tabela tempor�ria
	//-------------------------------------------------
	PLSAppTmp(cArqCSV)
	
	TRBPOS->(DbGoTop())
	
	If TRBPOS->(EOF())
		MsgStop("Arquivo Vazio!")
		TRBPOS->(DBCLoseArea())
		Close(oLeTxt)
		lRet := .F.
		Return
	End
	
	nTotal := TRBPOS->(LastRec()-1)
	
	ProcRegua(nTotal)
	
	TRBPOS->(DbGoTop())
	
	While !TRBPOS->(Eof())
		
		If lEnd
			MsgAlert("Interrompido pelo usu�rio","Aviso")
			Return
		EndIf
		
		++nLinhaAtu
		
		IncProc("Processando a Linha n�mero " + allTrim(Str(nLinhaAtu-1)) + " De " + cValTochar(nTotal))
		
		//-----------------------------------------------------------------------
		// Faz a leitura da linha do arquivo e atribui a vari�vel cLinha
		//-----------------------------------------------------------------------
		cLinha := UPPER(TRBPOS->CAMPO)
		
		//-----------------------------------------------------------------------
		// Se ja passou por todos os registros da planilha CSV sai do while
		//-----------------------------------------------------------------------
		if Empty(cLinha) .OR. substring(cLinha,1,1) == ";"
			Exit
		EndIf
		
		//-----------------------------------------------------------------------
		// Transfoma todos os ";;" em "; ;", de modo que o StrTokArr ir� retornar
		// sempre um array com o n�mero de colunas correto.
		//-----------------------------------------------------------------------
		cLinha := strTran(cLinha,";;","; ;")
		cLinha := strTran(cLinha,";;","; ;")
		
		//-----------------------------------------------------------------------
		// Para que o �ltimo item nunca venha vazio.
		//-----------------------------------------------------------------------
		cLinha += " ;"
		
		aLinha := strTokArr(cLinha,";")
		
		If lInicio
			lInicio := .F.
			IncProc("Lendo cabe�alho...De: "+cValTochar(nTotal))
			
			if !lLeCabec(aLinha)
				MsgAlert("Cabe�alho inv�lido, favor verificar e reimportar","Aviso")
				Return
			else
				lCabecOk :=  .T.
			endif
			//-----------------------------------------------------------------------
			// N�o continua se o cabe�alho n�o estiver Ok
			//-----------------------------------------------------------------------
			
		Else
			
			//-----------------------------------------------------------------------
			// n�o � linha em branco
			//-----------------------------------------------------------------------
			If len(aLinha) > 0
				
				*'-------------------------------------------------------------------'*
				*'Fun��o para gravar as informa��es do arquivo na tabela EMS_IMPORTA
				*'-------------------------------------------------------------------'*
				fProcDad(aLinha)
				
			EndIf
			
		EndIf
		
		TRBPOS->(dbskip())
		
	EndDo
	
	IncProc("Gravando arquivo de Log ")
	
	For _ntot := 1 To Len(_aDadGrv)
		
		If nHandle < 0
			
			MsgAlert("Erro durante cria��o do arquivo de Log.")
			Exit
			
		Else
			
			IncProc("Gravando arquivo de Log " + cValToChar(_ntot) + " de " + cValTochar(nTotal))
			
			FWrite(nHandle, _aDadGrv[_ntot] + CRLF)
			
		EndIf
		
	Next _ntot
	
	//�������������������������������������������������������������������������������������������������������������������Ŀ
	//�FClose - Comando que fecha o arquivo, liberando o uso para outros programas.                                       �
	//���������������������������������������������������������������������������������������������������������������������
	FClose(nHandle)
	
	If Len(a_ItFim) > 0
		
		DlgToExcel({{"ARRAY","Log de Importa��o de Lan�amentos, CABA092", a_Cab, a_ItFim}})
		
	EndIf
	
	Aviso("Aten��o","Importa��o de lan�amentos finalizada..",{"OK"})
	
Return

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  � PLSAppTmp  � Autor � Angelo Henrique    � Data �  08/01/19 ���
�������������������������������������������������������������������������͹��
���Descricao � Realiza o append do arquivo em uma tabela temporaria       ���
�������������������������������������������������������������������������͹��
���Uso       � CABERJ                                                     ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/

Static Function PLSAppTmp(cNomeArq)
	
	DbSelectArea("TRBPOS")
	Append From &(cNomeArq) SDF
	
Return

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  � lLeCabec   � Autor � Angelo Henrique    � Data �  08/01/19 ���
�������������������������������������������������������������������������͹��
���Descricao � Realiza a valida��o do cabe�alho                           ���
�������������������������������������������������������������������������͹��
���Uso       � CABERJ                                                     ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/

Static Function lLeCabec(aLinha)
	
	Local lRet 		:= .T.
	Local _ni		:= 0
	
	//------------------------------------------------------------------------------
	//Realizando o tratamento no cabe�alho antes de executar as valida��es
	//------------------------------------------------------------------------------
	For _ni := 1 To Len(aLinha)
		
		aLinha[_ni] := u_SemAcento(UPPER(AllTrim(aLinha[_ni])))
		
	Next _ni
	
	
	nMat	:= aScan(aLinha,{|x| Alltrim(UPPER(x)) == "MATRICULA" 	})
	nValor	:= aScan(aLinha,{|x| Alltrim(UPPER(x)) == "VALOR" 		})
	nObs	:= aScan(aLinha,{|x| Alltrim(UPPER(x)) == "OBSERVACAO" 	})
	nAno	:= aScan(aLinha,{|x| Alltrim(UPPER(x)) == "ANO" 		})
	nMes	:= aScan(aLinha,{|x| Alltrim(UPPER(x)) == "MES" 		})
	nCdLan  := aScan(aLinha,{|x| Alltrim(UPPER(x)) == "LANCAMENTO" 	})
	
	if nMat == 0
		lRet := .F.
	elseif nValor == 0
		lRet := .F.
	elseif nObs == 0
		lRet := .F.
	elseif nAno == 0
		lRet := .F.
	elseif nMes == 0
		lRet := .F.
	elseif nCdLan == 0
		lRet := .F.		
	endif
	
Return lRet


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �fProcDad   �Autor  � Angelo Henrique   � Data �  08/01/19   ���
�������������������������������������������������������������������������͹��
���Desc.     � Fun��o para armazenar os dados lidos do arquivo no vetor   ���
���		     � e gravar na BA1				 							  ���
�������������������������������������������������������������������������͹��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

Static Function fProcDad(aLinha)
	
	Local _aArea 	:= GetArea()
	Local _aArBA1 	:= BA1->(GetArea())
	Local _aArBA3 	:= BA3->(GetArea())
	Local _aArBSQ 	:= BSQ->(GetArea())
	Local _cChvBSQ	:= ""
	Local _na		:= 0
	Local _cNivel	:= ""
	
	//-------------------------------------------------------------------------------
	//Antes de realizar a grava��o verificar se existem ainda caracteres especiais
	//-------------------------------------------------------------------------------
	For _na := 1 To Len(aLinha)
		
		aLinha[_na] := Replace(Replace(AllTrim(aLinha[_na]),'"',''),'=','')
		
	Next _na
	
	//--------------------------------------------------------
	//Rotina para trazer o ultimo sequencial inserido
	//--------------------------------------------------------
	c_Seq := STPEGASEQ()
	
	If  !Empty( c_Seq )
		
		DbSelectArea("BA1")
		DbSetOrder(2)
		If DbSeek( xFilial("BA1") + AllTrim(aLinha[nMat]) )
			
			//-------------------------------------------------------------------
			//valida��o para saber em qual n�vel deve ser colocado o lan�amento
			//-------------------------------------------------------------------
			DbSelectArea("BA3")
			DbSetOrder(1) //BA3_FILIAL+BA3_CODINT+BA3_CODEMP+BA3_MATRIC+BA3_CONEMP+BA3_VERCON+BA3_SUBCON+BA3_VERSUB
			If DbSeek( xFilial("BA3") +  BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC))
				
				If BA3->BA3_COBNIV == '1' //1=Sim;0=Nao
					
					_cNivel := "5"
					
				Else
					
					_cNivel := "3"
					
				EndIf
				
			Else
				
				_cNivel := "3"
				
			EndIf
			
			//--------------------------------------------------------------------------------------------------------------
			//Montagem da chave da BSQ
			//--------------------------------------------------------------------------------------------------------------
			//Indice n�mero 2:
			//--------------------------------------------------------------------------------------------------------------
			//BSQ_FILIAL+BSQ_USUARI+BSQ_CONEMP+BSQ_VERCON+BSQ_SUBCON+BSQ_VERSUB+BSQ_ANO+BSQ_MES+BSQ_CODLAN+BSQ_TIPO
			//--------------------------------------------------------------------------------------------------------------
			_cChvBSQ := xFilial("BSQ")  														//BSQ_FILIAL
			_cChvBSQ += AllTrim(aLinha[nMat]) 													//BSQ_USUARI
			_cChvBSQ += BA1->(BA1_CONEMP+BA1_VERCON+BA1_SUBCON+BA1_VERSUB) 						//BSQ_CONEMP+BSQ_VERCON+BSQ_SUBCON+BSQ_VERSUB
			_cChvBSQ += AllTrim(aLinha[nAno]) 													//BSQ_ANO
			_cChvBSQ += PADL(AllTrim(aLinha[nMes]), TAMSX3("BSQ_MES")[1], '0')					//BSQ_MES
			_cChvBSQ += AllTrim(aLinha[nCdLan]) 												//BSQ_CODLAN
			_cChvBSQ += POSICIONE("BSP",1,xFilial("BSP")+AllTrim(aLinha[nCdLan]),"BSP_TIPSER") 	//BSQ_TIPO
			//--------------------------------------------------------------------------------------------------------------
			
			DbSelectArea("BSQ")
			DbSetOrder(2) //BSQ_FILIAL+BSQ_USUARI+BSQ_CONEMP+BSQ_VERCON+BSQ_SUBCON+BSQ_VERSUB+BSQ_ANO+BSQ_MES+BSQ_CODLAN+BSQ_TIPO
			If !(DbSeek( _cChvBSQ ))
				
				RecLock("BSQ",.T.)
				
				BSQ_FILIAL 	:= xFilial("BSQ")
				BSQ_CODSEQ 	:= soma1(c_Seq)
				BSQ_USUARI 	:= AllTrim(aLinha[nMat])
				BSQ_CODINT 	:= BA1->BA1_CODINT
				BSQ_CODEMP	:= BA1->BA1_CODEMP
				BSQ_CONEMP	:= BA1->BA1_CONEMP
				BSQ_VERCON  := '001'
				BSQ_SUBCON	:= BA1->BA1_SUBCON
				BSQ_VERSUB	:= '001'
				BSQ_MATRIC  := BA1->BA1_MATRIC
				BSQ_ANO		:= AllTrim(aLinha[nAno])
				BSQ_MES		:= PADL(AllTrim(aLinha[nMes]), TAMSX3("BSQ_MES")[1], '0')
				BSQ_CODLAN 	:= AllTrim(aLinha[nCdLan]) 	//011 - Debito // 014 - Credito
				BSQ_VALOR	:= VAL(Replace(aLinha[nValor],",","."))
				BSQ_TIPO 	:= POSICIONE("BSP",1,xFilial("BSP")+AllTrim(aLinha[nCdLan]),"BSP_TIPSER") //AllTrim(aLinha[nDbCrd]) 	// 1=Debito 2=Credito
				BSQ_NPARCE	:= '1'
				BSQ_TIPEMP 	:= '2'
				BSQ_AUTOMA 	:= '0'
				BSQ_COBNIV  := _cNivel
				BSQ_OBS     := AllTrim(aLinha[nObs]) 	//'DIFEREN�A DE MENSALIDADE  - DEBITO'
				BSQ_ZHIST   := UPPER(CUSERNAME) + " - " + DTOC(dDataBase) + " - " + _cTime
				
				BSQ->(MSUnLock())
				
				//--------------------------------------
				//Gravar Log informativo
				//--------------------------------------
				aAdd(_aDadGrv,;
					"Matricula: " 		+ AllTrim(aLinha[nMat]	) 									+ ;
					" - Ano: " 			+ AllTrim(aLinha[nAno]	) 									+ ;
					" - Mes: " 			+ PADL(AllTrim(aLinha[nMes]), TAMSX3("BSQ_MES")[1], '0') 	+ ;
					" - Lan�amento: " 	+ AllTrim(aLinha[nCdLan]) 									+ ;
					" - Incluido com sucesso. " )
									
				aaDD(a_ItFim,{ AllTrim(aLinha[nMat]) , AllTrim(aLinha[nAno]) , PADL(AllTrim(aLinha[nMes]), TAMSX3("BSQ_MES")[1], '0'), AllTrim(aLinha[nCdLan]), "Incluido com sucesso." })
				
			Else
				
				//--------------------------------------
				//Gravar Log informativo
				//--------------------------------------
				aAdd(_aDadGrv,;
					"Matricula: " 		+ AllTrim(aLinha[nMat]	) 									+ ;
					" - Ano: " 			+ AllTrim(aLinha[nAno]	) 									+ ;
					" - Mes: " 			+ PADL(AllTrim(aLinha[nMes]), TAMSX3("BSQ_MES")[1], '0') 	+ ;
					" - Lancamento: " 	+ AllTrim(aLinha[nCdLan]) 									+ ;
					" - J� existe lan�amento inclu�do para este benefici�rio.. " )
					
				aaDD(a_ItFim,{ AllTrim(aLinha[nMat]) , AllTrim(aLinha[nAno]) , PADL(AllTrim(aLinha[nMes]), TAMSX3("BSQ_MES")[1], '0'), AllTrim(aLinha[nCdLan]), "J� existe lan�amento inclu�do para este benefici�rio" })
				
			EndIf
			
		Else
			
			//--------------------------------------
			//Gravar Log informativo
			//--------------------------------------
			aAdd(_aDadGrv,;
				"Matricula: " + AllTrim(aLinha[nMat]	) + ;				
				" - N�o encontrada no sistema. " )
			
			aaDD(a_ItFim,{ AllTrim(aLinha[nMat]) , AllTrim(aLinha[nAno]) , PADL(AllTrim(aLinha[nMes]), TAMSX3("BSQ_MES")[1], '0'), AllTrim(aLinha[nCdLan]), "Matricula n�o encontrada" })
			
		EndIf
		
	EndIf
	
	RestArea(_aArBSQ)
	RestArea(_aArBA3)
	RestArea(_aArBA1)
	RestArea(_aArea )
	
Return


/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  � STPEGASEQ  � Autor � Angelo Henrique    � Data �  27/05/19 ���
�������������������������������������������������������������������������͹��
���Descricao � Traz a numera��o para o sequencial dos lan�amentos.        ���
�������������������������������������������������������������������������͹��
���Uso       � CABERJ                                                     ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/

Static Function STPEGASEQ()
	
	Local c_Qry := ""
	Local c_Cod := ""
	
	c_Qry := " SELECT Max(BSQ_CODSEQ) VALMAX FROM " + retsqlname("BSQ") + " WHERE D_E_L_E_T_ = ' ' "
	
	TCQuery c_Qry Alias "TMPMXBSQ" New
	
	If !TMPMXBSQ->( EOF() )
		
		c_Cod	:= TMPMXBSQ->VALMAX
		
	Endif
	
	TMPMXBSQ->( dbCloseArea() )
	
	
Return c_Cod




/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  � Static Function fExclui()
 � Autor � Luiz Otavio Campos    					� Data �  02/03/2021 ���
�������������������������������������������������������������������������͹��
���Descricao � Efetua a exclus�o dos lan�amentos importados do arquivo .CSV���
�������������������������������������������������������������������������͹��
���Uso       � CABERJ                                                     ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/

Static Function fExclui(lEnd)
	Local cCodLanD := Space(TAMSX3("BSQ_CODSEQ")[1])
	Local cCodLanA := Space(TAMSX3("BSQ_CODSEQ")[1])
	Local APERGS   := {}
	Private __aRet   := {}


	//====================================================================================
	//SEMPRE QUE ALTERAR ALGO AQUI, ALTERAR TAMBEM NA ROTINA 
	//====================================================================================
	aadd(/*01*/ aPergs,{ 1,"Sequencial De  :",@cCodLanD,"@!",'.T.','',/*'.T.'*/,40,.T. } )
	aadd(/*02*/ aPergs,{ 1,"Sequencial At� :",@cCodLanA,"@!",'.T.','',/*'.T.'*/,40,.T. } )

// Pergunta com parametros para a exclus�o
if( paramBox( aPergs,"Par�metros - Exclui Lan�amentos Importados",__aRet) )

	If MsgYesNo("Tem certeza que deseja excluir os lan�ametos???")

				
		//Processa a exclus�o dos itens
		Processa({|lEnd|fExclui2(@lEnd )},"Aguarde...","",.T.)

	Endif

endIf

Return	




STATIC function fExclui2(lEnd)
	Local cSQLExec := ""
	Local aCabec := {} 
	Local aDados := {}
	Local cAliasQuery := GetNextAlias()  
	Local cDeletado := ""
	
	aAdd(aCabec, GetSx3Cache ("BSQ_CODSEQ","X3_TITULO"))
	aAdd(aCabec, GetSx3Cache ("BSQ_USUARI","X3_TITULO"))
	aAdd(aCabec, GetSx3Cache ("BSQ_CODINT","X3_TITULO"))
	aAdd(aCabec, GetSx3Cache ("BSQ_CODEMP","X3_TITULO"))
	aAdd(aCabec, GetSx3Cache ("BSQ_MATRIC","X3_TITULO"))
	aAdd(aCabec, GetSx3Cache ("BSQ_CONEMP","X3_TITULO"))
	aAdd(aCabec, GetSx3Cache ("BSQ_SUBCON","X3_TITULO"))
	aAdd(aCabec, GetSx3Cache ("BSQ_ANO","X3_TITULO"))
	aAdd(aCabec, GetSx3Cache ("BSQ_MES","X3_TITULO"))
	aAdd(aCabec, GetSx3Cache ("BSQ_CODLAN","X3_TITULO"))
	aAdd(aCabec, GetSx3Cache ("BSQ_VALOR","X3_TITULO"))
	aAdd(aCabec, "EXCLUIDO")

	
	
	IncProc("Processando a exclus�o dos lan�amentos..." )

	//Filtra os lan�amento de acordo com os parametros informados
		cSQLExec := "SELECT * "
		cSQLExec += " FROM " + RetSqlName("BSQ")
		cSQLExec += "  WHERE D_E_L_E_T_ = ' ' "
		cSQLExec += "  AND BSQ_FILIAL = '" + xFilial("BSQ") + "'"
		//cSQLExec += "  AND 
		cSQLExec += "  AND BSQ_CODSEQ >= '"+__aRet[1]+"' AND BSQ_CODSEQ <='"+__aRet[2]+"'"

		cSQLExec := ChangeQuery(cSQLExec)

		dbUseArea(.T., "TOPCONN", TCGenQry(,,cSQLExec), cAliasQuery, .F., .T.)

		//cAliasQuery := MpSysOpenQuery(cSQLExec)

		(cAliasQuery)->(Dbgotop())


		If !(cAliasQuery)->(Eof())

			While !(cAliasQuery)->(Eof())

				
				IncProc("Processando lan�amento " +(cAliasQuery)->BSQ_CODSEQ )
				
				IF (cAliasQuery)->BSQ_NUMTIT = ' ' .and. (cAliasQuery)->BSQ_NUMCOB = ' '"
				
					//Delete o registro
					DbSelectArea("BSQ")
					Dbgoto((cAliasQuery)->R_E_C_N_O_)
					RecLock("BSQ",.F.)
					BSQ->BSQ_ZHIST := Alltrim(BSQ->BSQ_ZHIST) + ' - DELETADO POR: ' + UPPER(CUSERNAME) + " - " + DTOC(dDataBase) + " - " + _cTime //Angelo Henrique - Data: 24/05/2022
					DbDelete()
					MsunLock()
					
					cDeletado:= "SIM"
					
				Else
					cDeletado:= "NAO"

				EndIf

				//Ariciona no array do excel
				aAdd( aDados, { "'"+(cAliasQuery)->BSQ_CODSEQ,"'"+(cAliasQuery)->BSQ_USUARI, "'"+(cAliasQuery)->BSQ_CODINT, "'"+(cAliasQuery)->BSQ_CODEMP,  "'"+(cAliasQuery)->BSQ_MATRIC, "'"+(cAliasQuery)->BSQ_CONEMP, "'"+(cAliasQuery)->BSQ_SUBCON, "'"+(cAliasQuery)->BSQ_ANO, "'"+(cAliasQuery)->BSQ_MES, "'"+(cAliasQuery)->BSQ_CODLAN, (cAliasQuery)->BSQ_VALOR  , cDeletado } )

				(cAliasQuery)->(dbSkip())
			EndDo

			Aviso("AVISO!","Registros exclu�dos com sucesso!",{"OK"})

			// Imprime relatorio de lan�emtnos exclu�dos
			DlgToExcel({{"ARRAY","Log de Exclus�o" ,aCabec,aDados}})

		Else
			
			Alert('Nenhum registro foi encontrado!')

		EndIf

		


Return
