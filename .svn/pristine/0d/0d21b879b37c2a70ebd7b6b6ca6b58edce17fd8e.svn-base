#INCLUDE "RWMAKE.CH"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "TBICONN.CH"
#INCLUDE "TOPCONN.CH"

Static cEOL := chr(13) + chr(10)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ CABI019    บ Autor ณ Angelo Henrique    บ Data ณ  22/03/19 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Importa็ใo dos arquivos da NOTA CARIOCA, para atualizar    บฑฑ
ฑฑบ          ณas notas que jแ foram transmitidas por้m o protheus nใo     บฑฑ
ฑฑบ          ณreconhece.                                                  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CABERJ                                                     บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/

User Function CABI019()
	
	Local aArea    		:= GetArea()
	Local cDescr		:= ""
	Local cFlag			:= .F.
	
	Private cProg       := "CABI019"
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
	
	cDescr := "Este programa irแ importar o arquivos CSV disponibilizado pelo site da nota carioca, para atualziar as notas que ja foram transmitidas."
	
	oDlg              := MSDialog():New( 095,232,301,762,"Importa็ใo e Atualiza็ใo da Nota Carioca ",,,.F.,,,,,,.T.,,,.T. )
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
	oButton2          := tButton():New(082,092,'Avan็ar' ,oDlg,,35,15,,,,.T.)
	oButton2:bAction  := {||If(empty(cArqCSV) .or. right(allTrim(lower(cArqCSV)),4) != ".csv",MsgAlert("Informe um arquivo!"),(cFlag := .T.,oDlg:End()))}
	oButton2:cToolTip := "Ir para o pr๓ximo passo"
	
	oButton3          := tButton():New(082,144,'Cancelar',oDlg,,35,15,,,,.T.)
	oButton3:bAction  := {||cFlag := .F.,fClose(nOpen),oDlg:End()}
	oButton3:cToolTip := "Cancela a importa็ใo"
	
	oDlg:Activate(,,,.T.)
	
	If cFlag == .T.
		Processa({|lEnd|ImportCSV(@lEnd, cArqCSV)},"Aguarde...","",.T.)
	EndIf
	
	RestArea(aArea)
	
Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ ImportCSV  บ Autor ณ Angelo Henrique    บ Data ณ  22/03/19 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Efetua a importal็ao do arquivo .CSV                       บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CABERJ                                                     บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/

Static Function ImportCSV(lEnd,cArqCSV)
	
	Local cLinha 		:= ""
	Local nTotal		:= 0
	Local aStruc      	:= {}
	
	Private nNotaFis	:= 0
	Private nCodVer 	:= 0
	Private nDtHora   	:= 0
	Private nSerie   	:= 0
	Private nNumRPS   	:= 0
	
	
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Criacao do arquivo temporario...                                    ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	aAdd(aStruc,{"CAMPO","C",500,0})
	
	cTrbPos := CriaTrab(aStruc,.T.)
	
	If Select("TrbPos") <> 0
		TrbPos->(dbCloseArea())
	End
	
	DbUseArea(.T.,,cTrbPos,"TrbPos",.T.)
	
	lInicio := .T.
	lCabecOk := .T.
	
	//-------------------------------------------------
	// importa arquivo para tabela temporแria
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
			MsgAlert("Interrompido pelo usuแrio","Aviso")
			Return
		EndIf
		
		++nLinhaAtu
		
		IncProc("Processando a Linha n๚mero " + allTrim(Str(nLinhaAtu-1)) + " De " + cValTochar(nTotal))
		
		//-----------------------------------------------------------------------
		// Faz a leitura da linha do arquivo e atribui a variแvel cLinha
		//-----------------------------------------------------------------------
		cLinha := UPPER(TRBPOS->CAMPO)
		
		//-----------------------------------------------------------------------
		// Se ja passou por todos os registros da planilha CSV sai do while
		//-----------------------------------------------------------------------
		if Empty(cLinha) .OR. substring(cLinha,1,1) == ";"
			Exit
		EndIf
		
		//-----------------------------------------------------------------------
		// Transfoma todos os ";;" em "; ;", de modo que o StrTokArr irแ retornar
		// sempre um array com o n๚mero de colunas correto.
		//-----------------------------------------------------------------------
		cLinha := strTran(cLinha,";;","; ;")
		cLinha := strTran(cLinha,";;","; ;")
		
		//-----------------------------------------------------------------------
		// Para que o ๚ltimo item nunca venha vazio.
		//-----------------------------------------------------------------------
		cLinha += " ;"
		
		aLinha := strTokArr(cLinha,";")
		
		If lInicio
			lInicio := .F.
			IncProc("Lendo cabe็alho...De: "+cValTochar(nTotal))
			
			if !lLeCabec(aLinha)
				MsgAlert("Cabe็alho invแlido, favor verificar e reimportar","Aviso")
				Return
			else
				lCabecOk :=  .T.
			endif
			//-----------------------------------------------------------------------
			// Nใo continua se o cabe็alho nใo estiver Ok
			//-----------------------------------------------------------------------
			
		Else
			
			//-----------------------------------------------------------------------
			// nใo ้ linha em branco
			//-----------------------------------------------------------------------
			If len(aLinha) > 0
				
				*'-------------------------------------------------------------------'*
				*'Fun็ใo para gravar as informa็๕es nas tabelas SPED051 e da NOTA (SF2)
				*'-------------------------------------------------------------------'*
				fProcDad(aLinha)
				
			EndIf
			
		EndIf
		
		TRBPOS->(dbskip())
		
	EndDo
	
	Aviso("ATENวรO","Importa็ใo finalizada com sucesso!!!",{"Ok"})
	
Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ PLSAppTmp  บ Autor ณ Angelo Henrique    บ Data ณ  22/03/19 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Realiza o append do arquivo em uma tabela temporaria       บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CABERJ                                                     บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/

Static Function PLSAppTmp(cNomeArq)
	
	DbSelectArea("TRBPOS")
	Append From &(cNomeArq) SDF
	
Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ lLeCabec   บ Autor ณ Angelo Henrique    บ Data ณ  22/03/19 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Realiza a valida็ใo do cabe็alho                           บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CABERJ                                                     บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/

Static Function lLeCabec(aLinha)
	
	Local lRet := .T.
	
	//------------------------------------------------------------------------------
	//Realizando o tratamento no cabe็alho antes de executar as valida็๕es
	//------------------------------------------------------------------------------
	For _ni := 1 To Len(aLinha)
		
		aLinha[_ni] := u_SemAcento(UPPER(AllTrim(aLinha[_ni])))
		
	Next _ni
	
	nNotaFis	:= aScan(aLinha,{|x| Alltrim(UPPER(x)) == "N. DA NOTA FISCAL ELETRONICA"		})
	nCodVer 	:= aScan(aLinha,{|x| Alltrim(UPPER(x)) == "CODIGO DE VERIFICACAO NF"			})
	nDtHora   	:= aScan(aLinha,{|x| Alltrim(UPPER(x)) == "DATA HORA DA EMISSAO DA NOTA FISCAL"	})
	nSerie   	:= aScan(aLinha,{|x| Alltrim(UPPER(x)) == "SERIE DO RPS"						})
	nNumRPS   	:= aScan(aLinha,{|x| Alltrim(UPPER(x)) == "NUMERO DO RPS"						})
	
	
	if nNotaFis 	== 0
		
		lRet := .F.
		
	elseif nCodVer  == 0
		
		lRet := .F.
		
	elseif nDtHora 	== 0
		
		lRet := .F.
		
	elseif nSerie   == 0
		
		lRet := .F.
		
	elseif nNumRPS  == 0
		
		lRet := .F.
		
	endif
	
	//------------------------------------------------------------------------------
	//Caso o cabe็alho tenha vindo com problemas uma ultima pequisa ้ realizada
	//------------------------------------------------------------------------------
	If !lRet
		
		//-------------------------------------------------------
		//Atualizando a variแvel para refazer as valida็๕es
		//-------------------------------------------------------
		lRet := .T.
		
		For _ni := 1 To Len(aLinha)
			
			If AT("FISCAL ELETRONICA",aLinha[_ni]) > 0
				
				nNotaFis := _ni
				
			EndIf
			
			If AT("VERIFICACAO NF",aLinha[_ni]) > 0
				
				nCodVer := _ni
				
			EndIf
			
			If AT("HORA DA EMISSAO",aLinha[_ni]) > 0
				
				nDtHora := _ni
				
			EndIf
			
			If AT("SERIE DO",aLinha[_ni]) > 0
				
				nSerie := _ni
				
			EndIf
			
			If AT("NUMERO DO RPS",aLinha[_ni]) > 0
				
				nNumRPS := _ni
				
			EndIf
			
		Next _ni
		
		If nNotaFis 	== 0
			
			lRet := .F.
			
		ElseIf nCodVer  == 0
			
			lRet := .F.
			
		ElseIf nDtHora 	== 0
			
			lRet := .F.
			
		ElseIf nSerie   == 0
			
			lRet := .F.
			
		ElseIf nNumRPS  == 0
			
			lRet := .F.
			
		Endif
		
	EndIf
	
Return lRet


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณfProcDad   บAutor  ณ Angelo Henrique   บ Data ณ  22/03/19   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Fun็ใo para armazenar os dados lidos do arquivo no vetor   บฑฑ
ฑฑบ		     ณ e gravar na BA1				 							  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function fProcDad(aLinha)
	
	Local _aArea 	:= GetArea()
	Local _aArSF2 	:= SF2->(GetArea())
	Local cAlias1   := GetNextAlias()
	
	//--------------------------------------------------------------------------------------------------------------------
	//Variแveis da Nota e informa็๕es a serem gravadas
	//--------------------------------------------------------------------------------------------------------------------
	Local _cNotaFis	:= UPPER(AllTrim(aLinha[nNotaFis]))
	Local _cCodVer 	:= SUBSTR(UPPER(AllTrim(aLinha[nCodVer])),1,4) + "-" + SUBSTR(UPPER(AllTrim(aLinha[nCodVer])),5,4)
	Local _cDtHora 	:= UPPER(AllTrim(aLinha[nDtHora ]))
	Local _cSerie   := UPPER(AllTrim(aLinha[nSerie 	]))
	Local _cNumRPS  := StrZero(Val(AllTrim(aLinha[nNumRPS 	])), TAMSX3("F2_DOC")[1])
	
	//--------------------------------------------------------------------------------------------------------------------
	//Antes de realizar a grava็ใo verificar se existem ainda caracteres especiais
	//--------------------------------------------------------------------------------------------------------------------
	For _na := 1 To Len(aLinha)
		
		aLinha[_na] := Replace(Replace(AllTrim(aLinha[_na]),'"',''),'=','')
		
	Next _na
	
	
	DbSelectArea("SF2")
	DbSetOrder(1) //F2_FILIAL+F2_DOC+F2_SERIE+F2_CLIENTE+F2_LOJA+F2_FORMUL+F2_TIPO
	If DbSeek(xFilial("SF2") + _cNumRPS + _cSerie )
		
		//---------------------------------------------------------------------------
		//S๓ entra para atualizar o registro caso a nota esteja vazio
		//---------------------------------------------------------------------------
		If Empty(AllTrim(SF2->F2_CODNFE))
			
			//-------------------------------------
			//Atualiza a Tabela de Doc's
			//-------------------------------------
			RecLock("SF2", .F.)
			
			SF2->F2_FIMP 	:= "S"
			SF2->F2_NFELETR := _cNotaFis
			SF2->F2_CODNFE 	:= _cCodVer
			SF2->F2_EMINFE	:= CTOD(SUBSTR(_cDtHora,1,10))
			SF2->F2_HORNFE	:= SUBSTR(_cDtHora,11)
			
			SF2->(MsUnLock())
			
			//-------------------------------------------------------------------------------------------------------------
			//Atualiza a Tabela de SPED
			//-------------------------------------------------------------------------------------------------------------
			_cQuery := " UPDATE 															" + cEOL
			_cQuery += " 	TSSPROD.SPED051 												" + cEOL
			_cQuery += " SET 																" + cEOL
			_cQuery += " 	STATUS 		= '6', 												" + cEOL
			_cQuery += " 	NFSE 		= '" + _cNotaFis 							+ "', 	" + cEOL
			_cQuery += " 	NFSE_PROT 	= '" + _cCodVer 							+ "',	" + cEOL
			_cQuery += " 	DATE_ENFSE 	= '" + DTOS(CTOD(SUBSTR(_cDtHora,1,10))) 	+ "', 	" + cEOL
			_cQuery += " 	TIME_ENFSE 	= '" + SUBSTR(_cDtHora,11) + ":00" 			+ "' 	" + cEOL
			_cQuery += " WHERE																" + cEOL
			
			If cEmpAnt = "01" //CABERJ
				
				_cQuery += " 	ID_ENT = '000003'											" + cEOL //CABERJ
				
			Else
				
				If SF2->F2_FILIAL = "01" //Integral 
					
					_cQuery += " 	ID_ENT = '000004'										" + cEOL //CABERJ
					
				ElseIf SF2->F2_FILIAL = "04" //Integral Niter๓i
					
					_cQuery += " 	ID_ENT = '000005'										" + cEOL //CABERJ
					
				EndIf
				
			EndIf
			_cQuery += " 	AND NFSE_ID = '" + SF2->(F2_DOC+F2_SERIE) 				+ "'	" + cEOL
			
			If TcSqlExec(_cQuery ) < 0
				
				Aviso("Aten็ใo","Nใo foi possํvel importar os registros",{"OK"})
				
			EndIf
			
		EndIf
		
	EndIf
	
	RestArea(_aArea)
	
Return