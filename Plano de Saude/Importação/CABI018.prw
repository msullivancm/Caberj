#INCLUDE "RWMAKE.CH"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "TBICONN.CH"
#INCLUDE "TOPCONN.CH"

Static cEOL := chr(13) + chr(10)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ CABI018    บ Autor ณ Angelo Henrique    บ Data ณ  08/01/19 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Importa็ใo do arquivo gerado pela EMS (Estoque de Fatur.)  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CABERJ                                                     บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/

User Function CABI018()
	
	Local aArea    		:= GetArea()
	Local cDescr		:= ""
	Local cFlag			:= .F.
	
	Private cProg       := "CABI018"
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
	
	cDescr := "Este programa irแ importar os dados gerados pela EMS (Estoque de Faturamento) apartir de um arquivo CSV."
	
	oDlg              := MSDialog():New( 095,232,301,762,"Importa็ใo EMS - Estoque de Faturamento",,,.F.,,,,,,.T.,,,.T. )
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
	
	Private nId 		:= 0
	Private nFornec 	:= 0
	Private nGuia   	:= 0
	Private nBenef  	:= 0
	Private nCdBenef	:= 0
	Private nPlano     	:= 0
	Private nOperad   	:= 0
	Private nDtProc     := 0
	Private nVlrTot  	:= 0
	
	//--------------------------------------------------------------
	//Limpando a tabela antes de realizar a importa็ใo
	//--------------------------------------------------------------
	//_cQuery := " DELETE FROM SIGA.EMS_IMPORTA " + cEOL
	
	//If TcSqlExec(_cQuery ) < 0
		
		//Aviso("Aten็ใo","Nใo foi possํvel realizar a limpeza da tabela antes da importa็ใo",{"OK"})
		
	//Else
		
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
					*'Fun็ใo para gravar as informa็๕es do arquivo na tabela EMS_IMPORTA
					*'-------------------------------------------------------------------'*
					fProcDad(aLinha)
					
				EndIf
				
			EndIf
			
			TRBPOS->(dbskip())
			
		EndDo
		
		Aviso("ATENวรO","Importa็ใo finalizada com sucesso!!!",{"Ok"})
		
	//EndIf
	
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
	
	Local lRet := .T.
	
	//------------------------------------------------------------------------------
	//Realizando o tratamento no cabe็alho antes de executar as valida็๕es
	//------------------------------------------------------------------------------
	For _ni := 1 To Len(aLinha)
		
		aLinha[_ni] := u_SemAcento(UPPER(AllTrim(aLinha[_ni])))
		
	Next _ni
	
	nId 		:= aScan(aLinha,{|x| Alltrim(UPPER(x)) == "ID"   						})
	nFornec 	:= aScan(aLinha,{|x| Alltrim(UPPER(x)) == "FORNECEDORES DO PROCESSO"	})
	nGuia   	:= aScan(aLinha,{|x| Alltrim(UPPER(x)) == "GIH/SADT"		   			})
	nBenef  	:= aScan(aLinha,{|x| Alltrim(UPPER(x)) == "BENEFICIARIO"         		})
	nCdBenef	:= aScan(aLinha,{|x| Alltrim(UPPER(x)) == "COD. BENEFICIARIO"         	})
	nPlano     	:= aScan(aLinha,{|x| Alltrim(UPPER(x)) == "PLANO"        	 			})
	nOperad   	:= aScan(aLinha,{|x| Alltrim(UPPER(x)) == "OPERADORA ORIGEM"      		})
	nDtProc     := aScan(aLinha,{|x| Alltrim(UPPER(x)) == "DATA DO PROCEDIMENTO"     	})
	nVlrTot  	:= aScan(aLinha,{|x| Alltrim(UPPER(x)) == "[AUDITORIA] VALOR TOTAL"    	})
	
	if nId 			== 0
		lRet := .F.
	elseif nFornec  == 0
		lRet := .F.
	elseif nGuia    == 0
		lRet := .F.
	elseif nBenef   == 0
		lRet := .F.
	elseif nCdBenef == 0
		lRet := .F.
	elseif nPlano   == 0
		lRet := .F.
	elseif nOperad  == 0
		lRet := .F.
	elseif nDtProc  == 0
		lRet := .F.
	elseif nVlrTot  == 0
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
			
			If AT("ID",aLinha[_ni]) > 0
				
				nId := _ni
				
			EndIf
			
			If AT("FORNECEDORES",aLinha[_ni]) > 0
				
				nFornec := _ni
				
			EndIf
			
			If AT("GIH",aLinha[_ni]) > 0
				
				nGuia := _ni
				
			EndIf
			
			If AT("BENEFICI",aLinha[_ni]) > 0 .And. AT("D. BENEFICIA",aLinha[_ni]) = 0
				
				nBenef := _ni
				
			EndIf
			
			If AT("D. BENEFICIA",aLinha[_ni]) > 0
				
				nCdBenef := _ni
				
			EndIf
			
			If AT("PLANO",aLinha[_ni]) > 0
				
				nPlano := _ni
				
			EndIf
			
			If AT("OPERADORA",aLinha[_ni]) > 0
				
				nOperad := _ni
				
			EndIf
			
			If AT("PROCEDIMENTO",aLinha[_ni]) > 0
				
				nDtProc := _ni
				
			EndIf
			
			If AT("VALOR TOTAL",aLinha[_ni]) > 0
				
				nVlrTot := _ni
				
			EndIf
			
		Next _ni
		
		if nId 			== 0
			lRet := .F.
		elseif nFornec  == 0
			lRet := .F.
		elseif nGuia    == 0
			lRet := .F.
		elseif nBenef   == 0
			lRet := .F.
		elseif nCdBenef == 0
			lRet := .F.
		elseif nPlano   == 0
			lRet := .F.
		elseif nOperad  == 0
			lRet := .F.
		elseif nDtProc  == 0
			lRet := .F.
		elseif nVlrTot  == 0
			lRet := .F.
		endif
		
	EndIf
	
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
	Local cAlias1   := GetNextAlias()
	
	//-------------------------------------------------------------------------------
	//Antes de realizar a grava็ใo verificar se existem ainda caracteres especiais
	//-------------------------------------------------------------------------------
	For _na := 1 To Len(aLinha)
		
		aLinha[_na] := Replace(Replace(AllTrim(aLinha[_na]),'"',''),'=','')
	
	Next _na		
	
	_cQuery := " INSERT INTO SIGA.EMS_IMPORTA					" + cEOL
	_cQuery += " (											" + cEOL
	_cQuery += " 	ID_EMS    	, 							" + cEOL // ID DA EMS
	_cQuery += " 	FORNEC    	, 							" + cEOL // NOME DO FORNCEDOR
	_cQuery += " 	GIH_SADT  	, 							" + cEOL // SENHA
	_cQuery += " 	BENEF     	, 							" + cEOL // NOME DO BENEFICIARIO
	_cQuery += " 	MATRICULA 	, 							" + cEOL // CODIGO DO BENEFICIARIO
	_cQuery += " 	PLANO     	, 							" + cEOL // PLANO DO BENEFICIARIO
	_cQuery += " 	OPERADORA 	, 							" + cEOL // OPRADORA (CABERJ / INTEGRAL)
	_cQuery += " 	DT_PROC   	, 							" + cEOL // DATA DO PROCEDIMENTO
	_cQuery += " 	VALOR     	, 							" + cEOL // VALOR
	_cQuery += " 	DT_IMPOR  	, 							" + cEOL // DATA DA IMPORTACAO
	_cQuery += " 	HR_IMPOR  	  							" + cEOL // HORA DA IMPORTACAO
	_cQuery += " )											" + cEOL
	_cQuery += " VALUES										" + cEOL
	_cQuery += " (											" + cEOL
	_cQuery += " 	'" + AllTrim(aLinha[nId 	])	+ "' ,	" + cEOL
	_cQuery += " 	'" + AllTrim(aLinha[nFornec ])	+ "' ,	" + cEOL
	_cQuery += " 	'" + AllTrim(aLinha[nGuia   ])	+ "' ,	" + cEOL
	_cQuery += " 	'" + AllTrim(aLinha[nBenef  ])	+ "' ,	" + cEOL
	_cQuery += " 	'" + AllTrim(aLinha[nCdBenef])	+ "' ,	" + cEOL
	_cQuery += " 	'" + AllTrim(aLinha[nPlano  ])	+ "' ,	" + cEOL
	_cQuery += " 	'" + AllTrim(aLinha[nOperad ])	+ "' ,	" + cEOL
	_cQuery += " 	'" + AllTrim(aLinha[nDtProc ])	+ "' ,	" + cEOL
	_cQuery += " 	'" + AllTrim(aLinha[nVlrTot ])	+ "' ,	" + cEOL
	_cQuery += " 	'" + DTOC(DDATABASE)			+ "' ,	" + cEOL
	_cQuery += " 	'" + _cTime			  			+ "' 	" + cEOL
	_cQuery += " )											" + cEOL
	_cQuery += " 											" + cEOL
	
	If TcSqlExec(_cQuery ) < 0
		
		Aviso("Aten็ใo","Nใo foi possํvel importar os registros",{"OK"})
		
	EndIf
	
	RestArea(_aArea)
	
Return