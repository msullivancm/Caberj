#Include "PROTHEUS.CH"
#Include "TOPCONN.CH"
#Include "UTILIDADES.CH"
#Include "FILEIO.CH"

Static TamArqLote := 12

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³PRECARLT     ºAutor  ³Leonardo Portella   º Data ³ 14/09/12 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Rotina baseada na funcao PREPCART, sendo que prepara os     º±±
±±º          ³arquivos em lote (De/Ate). Tambem foram feitas revisoes paraº±±
±±º          ³melhorar o desempenho, conforme solicitado pelos usuários.  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³CABERJ - RDM 095                                            º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function PRECARLT

Local lConfirmou 	:= .F.
Local cFile      	:= '\'
Local aCombo		:= {".TXT"}
Local aCombOrd		:= {"Lotação","Ordem 2"}
	
Private cLoteDe    	:= Space(TamArqLote)
Private cLoteAte   	:= Space(TamArqLote)
Private cCombo
Private oProcess    := Nil
Private cPathProc	:= GetNewPar('MV_YPREPCA','\Processados_Carteirinha\')   
Private cArqEnviar	:= GetNewPar("MV_YDEXCAR","\Interface\Exporta\Cartao\")
Private cCombOrd

SetPrvt("oDlgPerg","oSBtn1","oSBtn2","oGrp1","oSay1","oSay2","oSay3","oSay4","oGet1","oBtn1","oGet2")
SetPrvt("oCBox1")

oDlgPerg   := MSDialog():New( 095,232,330,820,"Parâmetros - Todos os arquivos devem estar na mesma pasta",,,.F.,,,,,,.T.,,,.T. )

oGrp1      := TGroup():New( 008,008,084,284,"",oDlgPerg,CLR_BLACK,CLR_WHITE,.T.,.F. )

oSay1      := TSay():New( 016,012,{||"Caminho"}	,oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,024,008)
oSay2      := TSay():New( 028,012,{||"Lote De"}	,oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,024,008)
oSay3      := TSay():New( 040,012,{||"Lote Até"}	,oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
oSay4      := TSay():New( 054,012,{||"Extensão"}	,oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
oSay5      := TSay():New( 068,012,{||"Ordem"} 		,oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
                                                 
//Leonardo Portella - 17/12/12 - Incluido o GETF_LOCALHARD pois aas funcionarias do cadastro nao tem direito de escrita no ROOTPATH
oBtn1      := TButton():New( 016,260,"...",oGrp1,{||cFile := AllTrim(cGetFile('','Selecione arquivo', 0, cFile, .F.,GETF_RETDIRECTORY + GETF_LOCALHARD) )},012,008,,,,.T.,,"",,,,.F. )

oGet1      := TGet():New( 016,036,{|u| If(PCount()>0,If(CompPath(u,cArqEnviar),cFile:=u,cFile),cFile)}	,oGrp1,220,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cFile"		,,)
oGet2      := TGet():New( 028,036,{|u| If(PCount()>0,U_VLoteCar(u,'cLoteDe'),cLoteDe)} 					,oGrp1,060,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cLoteDe"		,,)
oGet3      := TGet():New( 040,036,{|u| If(PCount()>0,U_VLoteCar(u,'cLoteAte'),cLoteAte)}					,oGrp1,060,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cLoteAte"	,,)

oCBox1     := TComboBox():New( 054,036,{|u| If(PCount()>0,cCombo:=u,cCombo)}		,aCombo		,036,010,oGrp1,,,,CLR_BLACK,CLR_WHITE,.T.,,"",,,,,,,cCombo 	)
oCBox2     := TComboBox():New( 068,036,{|u| If(PCount()>0,cCombOrd:=u,cCombOrd)}	,aCombOrd	,036,010,oGrp1,,,,CLR_BLACK,CLR_WHITE,.T.,,"",,,,,,,cCombOrd 	)

oSBtn1     := SButton():New( 092,228,1,{||lConfirmou := .T.,oDlgPerg:End()},oDlgPerg,,"", )
oSBtn2     := SButton():New( 092,258,2,{||lConfirmou := .F.,oDlgPerg:End()},oDlgPerg,,"", )

oDlgPerg:Activate(,,,.T.)

If lConfirmou
	oProcess := MsNewProcess():New({|lFim|U_ProcArqsCar(cFile,cLoteDe,cLoteAte,cCombo,@lFim,oProcess,aScan(aCombOrd,cCombOrd)) },AllTrim(SM0->M0_NOMECOM),"",.T.)
	oProcess:Activate()
EndIf

Return

***********************************************************************

Static Function CompPath(cPath1,cPath2)

Local lOk	:= .T.
Local cMsg	:= ""

If AllTrim(Upper(cPath1)) == AllTrim(Upper(cPath2))
	lOk		:= .F.
	
	cMsg	:= 'O caminho de gravacao [ ' + cPath1 + ' ] não pode ser o mesmo local onde se encontram os arquivos!' + CRLF 
	cMsg 	+= 'Altere o local onde se encontram os arquivos!'
	
	MsgStop(cMsg,AllTrim(SM0->M0_NOMECOM))
EndIf

Return lOk

***********************************************************************

User Function ProcArqsCar(cPath,cLoteDe,cLoteAte,cExtensao,lFim,oProcess,nOrdem)

Local nI 		:= 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS
Local nJ 		:= 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS
Local nArq		:= 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS
Local n_Cont	:= 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS
Local nCont2	:= 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

Local cCodPla 		:= ""
Local nCont			:= 0
Local cNomeArq		:= ""
Local aCriticas 	:= {}
Local nLoteDe		:= Val(cLoteDe)
Local nLoteAte		:= Val(cLoteAte)
Local aStruc 		:= {}
Local nQtdLinhas	:= 0
Local nHandle		:= 0
Local nLinha 		:= 0
Local nQtdArqs		:= nLoteAte - nLoteDe + 1
Local nArq			:= 0
Local cFile			:= ""
Local nTamArrMax 	:= 23
Local nTamArr		:= 0
Local aLinha		:= {}
Local aImpCart		:= {}
Local aImp			:= {}
Local nHdl			:= 0
Local aOrdena		:= {}
Local cEscrever		:= ""
Local cNomLote		:= ""
Local cProc			:= ""

If ( nQtdArqs <= 0 ) .or. ( nLoteDe == 0 ) .or. ( nLoteAte == 0 )
	MsgStop('Quantidade de arquivos inválida. Verifique os nomes dos arquivos [' + cLoteDe + cExtensao + '] e [' + cLoteAte + cExtensao + ']',AllTrim(SM0->M0_NOMECOM))
	Return
EndIf

oProcess:SetRegua1(nQtdArqs)

BA1->(DbSetOrder(2))

//Crio a pasta em que serao gravados os arquivos caso ela nao exista
MakePath(cArqEnviar)

//Crio a pasta em que serao movidos os arquivos processados
MakePath(cPathProc)

For nArq := nLoteDe to nLoteAte

	If lFim
		MsgAlert('Operação abortada!',AllTrim(SM0->M0_NOMECOM))	
		Return
	EndIf
    
	cNomLote	:= StrZero(nArq,TamArqLote)
	cFile 		:= cNomLote + cExtensao     

	oProcess:IncRegua1("Processando arquivo [ " + cFile + " ] : " + cValToChar(++nCont) + ' de ' + cValToChar(nQtdArqs))
	oProcess:SetRegua2(0)
	oProcess:IncRegua2("")
	
	cNomeArq := cPath + cFile

	If !File(cNomeArq) 
		aAdd(aCriticas,'Arquivo ' + cNomeArq + ' não encontrado!')
		loop
	End

	nHandle := FT_FUse(cNomeArq)

	If nHandle == -1
		aAdd(aCriticas,'Erro na abertura do arquivo [ ' + cNomeArq + ' ]' + CRLF + 'Erro: [ ' + cDesFerror(FError()) + ' ] !')
		loop
    EndIf

    nQtdLinhas := FT_FLastRec()
   	FT_FGoTop()

	oProcess:SetRegua2(nQtdLinhas * 3)

	nLinha 		:= 0
	nTamArrMax 	:= 23
	nTamArr		:= 0

    While !FT_FEOF()

		oProcess:IncRegua2("Lendo arquivo [ " + cFile + " ] linha " + cValToChar(++nLinha) + ' de ' + cValToChar(nQtdLinhas))

		cString 	:= StrTran(AllTrim(FT_FReadLn()),'"',"")

		aLinha 		:= Separa(cString,';',.T.)

		nTamArr		:= len(aLinha)
		nTamArrMax 	:= If(nTamArrMax < nTamArr, nTamArr, nTamArrMax)

		cCodPla		:= AllTrim(aLinha[8])
		aLinha[8] 	:= cCodPla

		//Posiciona Produto do usuario...
        BI3->(DbSetOrder(1))//BI3_FILIAL+BI3_CODINT+BI3_CODIGO+BI3_VERSAO  

        If BI3->(MsSeek(xFilial("BI3")+PLSINTPAD()+cCodPla))
        	If !Empty(BI3->BI3_DESCAR) .and. ( AllTrim(BI3->BI3_DESCAR) <> "CABERJ" ) .and. ( AllTrim(BI3->BI3_DESCAR) <> "INTEGRAL" )
				aLinha[9] := AllTrim(BI3->BI3_DESCAR)
			EndIf	
	    Endif 

		//Corrigir grafia caso coluna de acomodacao apresente-se com nome incompleto
		If aLinha[10] == "APARTAMENT"
			aLinha[10] := "APARTAMENTO"
	    EndIf

	    _cTexto := ""
		cCodBAT := Alltrim(aLinha[17])

		If cCodBAT $ "SEM CARENCIA"

			_cTexto 	:= "SEM CARENCIA"
		  	aLinha[20] 	:= _cTexto

		ElseIf At("_0",cCodBat) > 0 .or. At("_1",cCodBat) > 0 .or. At("_2",cCodBat) > 0 .or. At("_3",cCodBat) > 0 .or. SubStr(cCodBat,1,1) $ "0/1/2/3/4/5/6/7/8/9"

        	nElem 	:= 11
		    nElem2 	:= 20

		    While .T.

				_cCodCar := SubStr(AllTrim(cCodBat),1,3)

				If !Empty(_cCodCar)
					BAT->(DbSetOrder(1))//BAT_FILIAL+BAT_CODINT+BAT_CODIGO
					If BAT->(MsSeek(xFilial("BAT")+PLSINTPAD()+_cCodCar)) .and. ( nElem <= len(aLinha) ) 
					   _cTexto := _cTexto + AllTrim(BAT->BAT_DESCRI) + " ATE "+ aLinha[nElem]
					EndIf
				EndIf  

				nPos := At("_",AllTrim(cCodBAT)) 

				If nPos > 0
					cCodBAT := SubStr(AllTrim(cCodBAT),at("_",cCodBAT)+1)
	            Else
				   Exit
				EndIf  

				_cTexto := _cTexto + ";"
		        nElem++
		        nElem2++ 

			EndDo    

		  	aLinha[20] := _cTexto

		EndIf

		aLinha[17] := ""

		aAdd(aOrdena,aLinha)

		FT_FSKIP()    

	Enddo
	
	FT_FUse()
	FClose(nHandle)
	
	BA1->(DbSetOrder(2))
	
	For nI := 1 to len(aOrdena)

		If lFim
			MsgAlert('Operação abortada!',AllTrim(SM0->M0_NOMECOM))	
			Return
		EndIf
	    
    	oProcess:IncRegua2("Ajustando registro " + StrZero(nI,6) + " de " + StrZero(len(aOrdena),6))
	
		aBuffer := Array(nTamArrMax)

		//Ajuste da linha
		For nJ := 1 to nTamArrMax  
			If nJ <= len(aOrdena[nI])
				aBuffer[nJ] := aOrdena[nI][nJ]
			Else
				aBuffer[nJ] := " "			
			EndIf
		Next
		
		//Buscar de BA1 o campo YLOTAC para realizar a ordenacao Itau.
		If nOrdem == 1
	
			cCodBA1 := StrTran(StrTran(aBuffer[7],".",""),"-","")

			If BA1->(MsSeek(xFilial("BA1") + cCodBA1))
				aBuffer[21] := BA1->BA1_YLOTAC
				aBuffer[6]  := AllTrim(BA1->BA1_NOMUSR)
			Else
				MsgAlert("Não foi encontrado o usuario matricula [ " + aBuffer[7] + " ] no cadastro. Verifique!",AllTrim(SM0->M0_NOMECOM))
			Endif
	
		Else
			//MsgAlert("Ponto para ser escrita a lógica da ordem nro 2 para a rotina de ajuste de cartão!")
		EndIf

		aOrdena[nI] := aBuffer

	Next
    
	If File(cArqEnviar + cFile)
		If FErase(cArqEnviar + cFile) <> 0
			aAdd(aCriticas,'Erro ao apagar o arquivo [ ' + cArqEnviar + cFile + ' ]' + CRLF + 'Erro: [ Nao foi possivel apagar o arquivo ] !')
			loop
		EndIf
	EndIf
	
	nHdl := FCreate(cArqEnviar + cFile)//Cria em pasta diferente com o mesmo nome
    
    If nHdl == -1
		aAdd(aCriticas,'Erro na criacao do arquivo [ ' + cArqEnviar + cFile + ' ]' + CRLF + 'Erro: [ ' + cDesFerror(FError()) + ' ] !')
		loop
    Endif 

    FT_FUse()
	FClose(nHdl)

    nHdl := FOpen(cArqEnviar + cFile,FO_WRITE)

	If nHdl == -1      
		aAdd(aCriticas,'Erro na abertura do arquivo [ ' + cArqEnviar + cFile + ' ]' + CRLF + 'Erro: [ ' + cDesFerror(FError()) + ' ] !')
		loop
    EndIf

	//Leonardo Portella - 21/12/12 - O cartao ja sai ordenado pelo PE PLS264OB visto que a carteirinha pode ser impressa direto na Caberj, sem preparacao do arquivo.
	//aSort(aOrdena,,,{|x,y| ( x[21] + x[7] ) < ( y[21] + y[7] )})

	For n_Cont := 1 to len(aOrdena)

		oProcess:IncRegua2("Ajustando registro " + StrZero(n_Cont,6) + " de " + StrZero(len(aOrdena),6))

		cString := StrZero(n_Cont,11) + ";"

		aAdd(aImp,{aOrdena[n_Cont][7],aOrdena[n_Cont][6],aOrdena[n_Cont][4],aOrdena[n_Cont][21],cNomeArq,cArqEnviar + cFile})

		For nCont2 := 2 to (Len(aOrdena[n_Cont])-1)
		    If !empty(aOrdena[n_Cont][nCont2])
		    	cString += aOrdena[n_Cont][nCont2]
		    EndIf
		    
		    cString += ";"
		Next   

		aAdd(aImpCart,cString)

	Next

	For nCont := 1 to len(aImpCart)

		cEscrever := aImpCart[nCont]
                                    
        If nCont < len(aImpCart)
        	cEscrever += CRLF
        EndIf
        
		FSeek(nHdl, 0, FS_END)//Posiciona no fim do arquivo
		
		FWrite(nHdl,@cEscrever)
	Next

	FT_FUse()
	FClose(nHdl)

	aImpCart	:= {}
    aOrdena 	:= {}
	aLinha 		:= {}
	
	cProc := cPathProc + cNomLote + '_' + DtoS(Date()) + '_' + StrTran(Time(),':','') + cExtensao
		
	If !MoveFile(cPath + cFile,cProc,.T.)
		aAdd(aCriticas,'Não foi possivel mover o arquivo [ ' + cPath + cFile + ' ] para o arquivo [ ' + cProc + ' ] !')
		loop
	EndIf
	
Next

If len(aCriticas) > 0
	cCrit := ''

	For nI := 1 to len(aCriticas)
		cCrit += aCriticas[nI] + CRLF
	Next

	LogErros(cCrit,'Criticas da geracao de carteiras',,'M')
EndIf

GeraRel(aImp)

Return

***********************************************************************

User Function VLoteCar(cConteudo,cVar)

Local nI := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

Local lOk 	:= .T.
Local nI	:= 0

cConteudo := AllTrim(cConteudo)

For nI := 1 to len(cConteudo)
	If !IsDigit(Substr(cConteudo,nI,1))	
		MsgAlert('Lote deve conter apenas digitos!',AllTrim(SM0->M0_NOMECOM))
		lOk := .F.
		exit
	EndIf
Next

If lOk .and. !empty(cConteudo)
	&cVar 	:= StrZero(Val(cConteudo),TamArqLote)
Else
	&cVar	:= Space(TamArqLote)
EndIf

GetDRefresh()

Return lOk

************************************************************************************************************************************

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Imprime o conteudo da variavel cMemo da funcao LogErros ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

Static Function GeraRel(aImprimir)

Local oReport            

If !empty(aImprimir)

	Private aImp := aImprimir
	
	oReport:= DefRepGR()
	oReport:PrintDialog()

Else
	Aviso('ATENÇÃO','Não há dados!',{'Ok'})
EndIf

Return

********************************************************************************************************************************

//ÚÄÄÄÄÄÄÄÄÄ¿
//³Auxiliar ³
//ÀÄÄÄÄÄÄÄÄÄÙ

Static Function DefRepGR()

Local oReport 
Local oLog 
                
oReport	:= TReport():New("PRECARLT","Preparacao carteirinha","PRECARLT", {|oReport| PrtRep(oReport)},"Este relatorio emite a relacao de arquivo prontos para serem enviados")

oReport:SetLandscape() //Impressão em paisagem.

oLog := TRSection():New(oReport,"Preparacao carteirinha")

TRCell():New(oLog ,'MATRICULA'	,,'Matr.'				,/*Picture*/	,20	  	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
TRCell():New(oLog ,'NOME'		,,'Nome'				,/*Picture*/	,50	  	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
TRCell():New(oLog ,'VALIDADE'	,,'Validade'			,/*Picture*/	,12	   	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
TRCell():New(oLog ,'LOTACAO'	,,'Lotacao'				,/*Picture*/	,50		,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
TRCell():New(oLog ,'ARQORI'		,,'Arq. Origem'			,/*Picture*/	,55		,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
TRCell():New(oLog ,'ARQPRO'		,,'Arq. a ser enviado'	,/*Picture*/	,55	   	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)

Return(oReport)

********************************************************************************************************************************

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Auxiliar para a funcao PrintLog³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

Static Function PrtRep(oReport)

Local i
Local nTot	:= len(aImp)
Local cTot	:= allTrim(Transform(nTot,'@E 999,999,999'))

Private oLog   	:= oReport:Section(1)

oReport:SetMeter(nTot) 

nTot	:= 0

oLog:init()
	                                                
For i := 1 to len(aImp)
        
    If oReport:Cancel()

	    oReport:FatLine()     
	    oReport:PrintText('Cancelado pelo operador!!!',,,CLR_RED,,,.T.)
	    
	    exit

	EndIf 

	oReport:SetMsgPrint("Imprimindo a linha " + allTrim(Transform(++nTot,'@E 999,999,999')) + " de " + cTot)
	oReport:IncMeter()

	oLog:Cell('MATRICULA'	):SetValue(aImp[i][1])
	oLog:Cell('NOME'		):SetValue(aImp[i][2])
	oLog:Cell('VALIDADE'	):SetValue(aImp[i][3])

	cCodBA1 := StrTran(StrTran(aImp[i][1],".",""),"-","")

	BA1->(DbSetOrder(2))//BA1_FILIAL+BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG+BA1_DIGITO
	BA1->(MsSeek(xFilial("BA1") + cCodBA1))

	oLog:Cell('LOTACAO'		):SetValue( If(BA1->(Found()) .and. !empty(BA1->BA1_YLOTAC),AllTrim(BA1->BA1_YLOTAC) + ' - ' + AllTrim(BA1->BA1_YNOMLO),'-') )
	oLog:Cell('ARQORI'		):SetValue(aImp[i][5])
	oLog:Cell('ARQPRO'		):SetValue(aImp[i][6])

	oLog:PrintLine()

Next

oLog:Finish()

Return

************************************************************************************************************************************