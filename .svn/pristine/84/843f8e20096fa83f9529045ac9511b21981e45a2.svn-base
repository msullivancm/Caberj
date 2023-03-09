#INCLUDE "RWMAKE.CH"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "TBICONN.CH"
#INCLUDE "TOPCONN.CH"
#INCLUDE 'FONT.CH'
#INCLUDE 'COLORS.CH'
#include "TOTVS.CH"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ CABA092    บ Autor ณ Angelo Henrique    บ Data ณ  21/05/19 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Rotina para importar lan็amentos de d้bito e cr้dito       บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CABERJ                                                     บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
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
	
	cDescr := "Este programa irแ importar os lan็amentos de D้bito /Cr้dito apartir de um arquivo CSV."
	
	oDlg              := MSDialog():New( 095,232,301,762,"Importa็ใo Lan็amento Cr้dito / D้bito",,,.F.,,,,,,.T.,,,.T. )
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
	
	
	oButton4          := tButton():New(082,195,'Excluir',oDlg,,35,15,,,,.T.)
	oButton4:bAction  := {||fExclui(lEnd),oDlg:End()}
	oButton4:cToolTip := "Exclui lan็amentos importados"

	
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
ฑฑบPrograma  ณ ImportCSV  บ Autor ณ Angelo Henrique    บ Data ณ  08/01/19 บฑฑ
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
	
	Private _cTime		:= TIME() //Hora inicial da importa็ใo
	Private aLinha		:= {}
	
	Private a_ItFim     := {}
	Private a_Cab		:= {"Matricula","Ano","Mes","Lan็amento","Mensagem"}	
		
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Criacao do arquivo temporario...                                    ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	aAdd(aStruc,{"CAMPO","C",500,0})
	
	cTrbPos := CriaTrab(aStruc,.T.)
	
	If Select("TrbPos") <> 0
		TrbPos->(dbCloseArea())
	End
	
	DbUseArea(.T.,,cTrbPos,"TrbPos",.T.)
	
	lInicio 	:= .T.
	lCabecOk 	:= .T.
	
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
				*'Fun็ใo para gravar as informa็๕es do arquivo na tabela EMS_IMPORTA
				*'-------------------------------------------------------------------'*
				fProcDad(aLinha)
				
			EndIf
			
		EndIf
		
		TRBPOS->(dbskip())
		
	EndDo
	
	IncProc("Gravando arquivo de Log ")
	
	For _ntot := 1 To Len(_aDadGrv)
		
		If nHandle < 0
			
			MsgAlert("Erro durante cria็ใo do arquivo de Log.")
			Exit
			
		Else
			
			IncProc("Gravando arquivo de Log " + cValToChar(_ntot) + " de " + cValTochar(nTotal))
			
			FWrite(nHandle, _aDadGrv[_ntot] + CRLF)
			
		EndIf
		
	Next _ntot
	
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณFClose - Comando que fecha o arquivo, liberando o uso para outros programas.                                       ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	FClose(nHandle)
	
	If Len(a_ItFim) > 0
		
		DlgToExcel({{"ARRAY","Log de Importa็ใo de Lan็amentos, CABA092", a_Cab, a_ItFim}})
		
	EndIf
	
	Aviso("Aten็ใo","Importa็ใo de lan็amentos finalizada..",{"OK"})
	
Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ PLSAppTmp  บ Autor ณ Angelo Henrique    บ Data ณ  08/01/19 บฑฑ
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
ฑฑบPrograma  ณ lLeCabec   บ Autor ณ Angelo Henrique    บ Data ณ  08/01/19 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Realiza a valida็ใo do cabe็alho                           บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CABERJ                                                     บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/

Static Function lLeCabec(aLinha)
	
	Local lRet 		:= .T.
	Local _ni		:= 0
	
	//------------------------------------------------------------------------------
	//Realizando o tratamento no cabe็alho antes de executar as valida็๕es
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
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณfProcDad   บAutor  ณ Angelo Henrique   บ Data ณ  08/01/19   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Fun็ใo para armazenar os dados lidos do arquivo no vetor   บฑฑ
ฑฑบ		     ณ e gravar na BA1				 							  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
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
	//Antes de realizar a grava็ใo verificar se existem ainda caracteres especiais
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
			//valida็ใo para saber em qual nํvel deve ser colocado o lan็amento
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
			//Indice n๚mero 2:
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
				BSQ_OBS     := AllTrim(aLinha[nObs]) 	//'DIFERENวA DE MENSALIDADE  - DEBITO'
				BSQ_ZHIST   := UPPER(CUSERNAME) + " - " + DTOC(dDataBase) + " - " + _cTime
				
				BSQ->(MSUnLock())
				
				//--------------------------------------
				//Gravar Log informativo
				//--------------------------------------
				aAdd(_aDadGrv,;
					"Matricula: " 		+ AllTrim(aLinha[nMat]	) 									+ ;
					" - Ano: " 			+ AllTrim(aLinha[nAno]	) 									+ ;
					" - Mes: " 			+ PADL(AllTrim(aLinha[nMes]), TAMSX3("BSQ_MES")[1], '0') 	+ ;
					" - Lan็amento: " 	+ AllTrim(aLinha[nCdLan]) 									+ ;
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
					" - Jแ existe lan็amento incluํdo para este beneficiแrio.. " )
					
				aaDD(a_ItFim,{ AllTrim(aLinha[nMat]) , AllTrim(aLinha[nAno]) , PADL(AllTrim(aLinha[nMes]), TAMSX3("BSQ_MES")[1], '0'), AllTrim(aLinha[nCdLan]), "Jแ existe lan็amento incluํdo para este beneficiแrio" })
				
			EndIf
			
		Else
			
			//--------------------------------------
			//Gravar Log informativo
			//--------------------------------------
			aAdd(_aDadGrv,;
				"Matricula: " + AllTrim(aLinha[nMat]	) + ;				
				" - Nใo encontrada no sistema. " )
			
			aaDD(a_ItFim,{ AllTrim(aLinha[nMat]) , AllTrim(aLinha[nAno]) , PADL(AllTrim(aLinha[nMes]), TAMSX3("BSQ_MES")[1], '0'), AllTrim(aLinha[nCdLan]), "Matricula nใo encontrada" })
			
		EndIf
		
	EndIf
	
	RestArea(_aArBSQ)
	RestArea(_aArBA3)
	RestArea(_aArBA1)
	RestArea(_aArea )
	
Return


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ STPEGASEQ  บ Autor ณ Angelo Henrique    บ Data ณ  27/05/19 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Traz a numera็ใo para o sequencial dos lan็amentos.        บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CABERJ                                                     บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
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
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ Static Function fExclui()
 บ Autor ณ Luiz Otavio Campos    					บ Data ณ  02/03/2021 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Efetua a exclusใo dos lan็amentos importados do arquivo .CSVบฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CABERJ                                                     บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
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
	aadd(/*02*/ aPergs,{ 1,"Sequencial At้ :",@cCodLanA,"@!",'.T.','',/*'.T.'*/,40,.T. } )

// Pergunta com parametros para a exclusใo
if( paramBox( aPergs,"Parโmetros - Exclui Lan็amentos Importados",__aRet) )

	If MsgYesNo("Tem certeza que deseja excluir os lan็ametos???")

				
		//Processa a exclusใo dos itens
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

	
	
	IncProc("Processando a exclusใo dos lan็amentos..." )

	//Filtra os lan็amento de acordo com os parametros informados
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

				
				IncProc("Processando lan็amento " +(cAliasQuery)->BSQ_CODSEQ )
				
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

			Aviso("AVISO!","Registros excluํdos com sucesso!",{"OK"})

			// Imprime relatorio de lan็emtnos excluํdos
			DlgToExcel({{"ARRAY","Log de Exclusใo" ,aCabec,aDados}})

		Else
			
			Alert('Nenhum registro foi encontrado!')

		EndIf

		


Return
