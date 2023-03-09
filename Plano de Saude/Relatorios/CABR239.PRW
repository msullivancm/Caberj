#INCLUDE "PROTHEUS.CH"
#INCLUDE "TOPCONN.CH"
#INCLUDE "UTILIDADES.CH"
#INCLUDE "AP5MAIL.CH"
#INCLUDE "FWPRINTSETUP.CH"
#INCLUDE "RPTDEF.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ CABR239  ³ Autor ³ Marcela Coimbra      ³ Data ³01/06/2017³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Informações para a Carta de reajuste para empresas.        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ CABERJ                                                     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function CABR239( a_Dados, a_Desc )

	Local l_AdjustToLegacy 	:= .F.
	Local l_DisableSetup  	:= .T.
	Local c_Path			:= MsDocPath()
	Local c_NomeArq 		:= Replace(a_Dados[1][3],'.','')
	Local l_Ok 				:= .T.
	Local c_Matric 			:= ""
	Local c_ArquivoPDF 		:= ""
	Local n_Count

	Private c_Seq			:= U_GERNUMPA()
	Private c_PathBmp		:= GetSrvProfString("Startpath","")
	Private n_Lin 			:= 90
	Private n_TamLin 		:= 10
	Private n_LinCab		:= 3
	Private n_LinMax		:= 760
	Private n_TamPar 		:= 8
	Private n_TamTab 		:= 5
	Private n_ColMax		:= 95 //Caracteres
	Private n_ColIni 		:= 60 //Pixel

	Private oPrinter

	Private LINHA	:= 17

	c_Matric  := Replace(c_NomeArq,'-','')
	c_NomeArq := substr( Replace(c_NomeArq,'-',''),  5, 10 ) + "_" + dtos( date() )
	
	PARAGRAFO := 50

	c_PathBmp 	:= AjuBarPath(c_PathBmp)
	c_Path		:= AjuBarPath(c_Path)

	//------------------------------------------------------
	// Ordem obrigátoria de configuração do relatório
	//------------------------------------------------------
	oPrinter 	:= 	FwMsPrinter():New(c_NomeArq, IMP_PDF, l_AdjustToLegacy, c_Path, l_DisableSetup)
	
	oPrinter:setDevice(IMP_PDF)
	oPrinter:SetResolution(72)
	oPrinter:SetPortrait()
	oPrinter:SetPaperSize(DMPAPER_A4)
	oPrinter:lServer  := .T. // imprime no servidor
	oPrinter:cPathPDF :=  c_Path

	oFont01 	:= TFont():New("Courier New",,12,,.F.)
	oFont01N 	:= TFont():New("Courier New",,12,,.T.)
	oFont01S 	:= TFont():New("Courier New",,12,,.T.)
	oFontBox 	:= TFont():New("Courier New",,9,,.F.)
	oFontBoxN 	:= TFont():New("Courier New",,9,,.T.)

	oPrinter:StartPage()
	oPrinter:SayBitMap(40, n_ColIni, c_PathBmp + If(cEmpAnt == '01',"lgrl01.bmp","lgrl02.bmp"),50,50)

	ImprLinha( cAlinDir("Rio de Janeiro, " + cValtoChar(Day(Date())) + " de " + MesExtenso(Month(Date())) + " de " + cValToChar(Year(Date()))), oFont01, n_ColIni)

	n_Lin := n_Lin + LINHA + LINHA

	ImprLinha( "CONFIRMAÇÃO DE CANCELAMENTO DO PLANO DE SAÚDE", oFont01N, n_ColIni + 180)

	n_Lin := n_Lin + LINHA + LINHA

	ImprLinha( 'Prezado(a) beneficiário(a): '  , oFont01N, n_ColIni  )
	n_Lin := n_Lin - LINHA
	ImprLinha( a_Dados[1][4] , oFont01, n_ColIni + 160)

	n_Lin := n_Lin + LINHA

	ImprLinha( Space(n_TamTab) + 'Em cumprimento ao Art. 18 da Resolução Normativa n° 412 de 10 de novembro de 2016 confirmamos o cancelamento do(s) plano(s) de saúde especificado(s) abaixo mediante solicitação do beneficiário titular:', oFont01, n_ColIni)

	n_Lin := n_Lin + LINHA

	For n_Count := 1 to Len( a_Dados )

		If a_Dados[ n_Count ][ 1 ] == 'B'

			If a_Dados[ n_Count ][ 2 ] == 'T'

				ImprLinha( 'Dados do Beneficiário titular cancelado:', oFont01S, n_ColIni)

			Else

				ImprLinha( 'Dados do Beneficiário dependente cancelado:', oFont01S, n_ColIni)

			EndIf

			ImprLinha( 'Nome: '  , oFont01N, n_ColIni)
			n_Lin := n_Lin - LINHA
			ImprLinha(  a_Dados[ n_Count ][ 4 ] , oFont01, n_ColIni + 40)

			ImprLinha( 'Plano: ', oFont01N, n_ColIni)
			n_Lin := n_Lin - LINHA
			ImprLinha( a_Dados[ n_Count ][ 5 ] , oFont01, n_ColIni + 50)

			ImprLinha( 'Matricula: '  , oFont01N, n_ColIni)
			n_Lin := n_Lin - LINHA
			ImprLinha( a_Dados[ n_Count ][ 3 ] , oFont01, n_ColIni + 60)

			ImprLinha( 'Data do Cancelamento: '  , oFont01N, n_ColIni)
			n_Lin := n_Lin - LINHA
			ImprLinha( a_Dados[ n_Count ][ 6 ] , oFont01, n_ColIni + 120)

			n_Lin := n_Lin + LINHA

		EndIf

	Next

	iF a_Desc[7][3] < 0

		ImprLinha( 'Dados bancários para ressarcimento ao beneficiário:', oFont01N, n_ColIni)
		PARAGRAFO++

		ImprLinha( 'Banco: ' , oFont01N, n_ColIni)
		n_Lin := n_Lin - LINHA
		ImprLinha( a_Dados[1][7], oFont01, n_ColIni + 40)


		ImprLinha( 'Ag.: ' , oFont01N, n_ColIni)
		n_Lin := n_Lin - LINHA
		ImprLinha( a_Dados[1][8], oFont01, n_ColIni + 30)


		ImprLinha( 'C/C: '   , oFont01N, n_ColIni)
		n_Lin := n_Lin - LINHA
		ImprLinha( a_Dados[1][9], oFont01, n_ColIni + 30)

	EndIf

	n_Lin := n_Lin + LINHA + LINHA

	If n_Lin >= 500

		n_Lin := 800

	EndIf

	nTamH1box 		:= 260
	nTamH2Box		:= 90
	nTamHSepBox 	:= 20

	n_Lin := n_Lin + LINHA + LINHA

	ImprLinha( 'Departamento Financeiro', oFont01, n_ColIni)

	ImprLinha( 'Grupo CABERJ', oFont01, n_ColIni)

	c_ArquivoPDF	:= oPrinter:cPathPDF + c_NomeArq + '.PDF'

	oPrinter:EndPage() // Finaliza a página
	oPrinter:lViewPDF := .F.
	oPrinter:Print()

	PLSCHKRP(c_Path, c_NomeArq + ".pdf")

	FreeObj(oPrinter)

	c_Dest := a_DadoS[01][10]

	If FILE(c_ArquivoPDF)
		
		fGrvPrtAnx(c_ArquivoPDF, c_Matric, c_Seq)
		EnvEmail1( c_Dest, c_ArquivoPDF,  a_Dados[1][4]) 
		
	Else
		
		Alert("Arquivo não gerado: "+c_ArquivoPDF)
		
	
	EndIf

Return l_Ok

****************************************************************************************************************************************
Static Function ImprLinha( cTexto, o_Font , nColuna )

	Local aMsg 	:= aQuebraTxt(alltrim( cTexto ), n_ColMax)
	Local nK	:= 0
	Local nZ	:= 0

	nCont := len(aMsg)

	For nK := 1 to nCont

		n_Lin := n_Lin + LINHA

		If n_Lin > n_LinMax

			oPrinter:EndPage()
			oPrinter:StartPage()

			n_Lin := 90

			oPrinter:SayBitMap(n_Lin, n_ColIni, c_PathBmp + If(cEmpAnt == '01',"lgrl01.bmp","lgrl02.bmp"),50,50)

			n_Lin := n_Lin + LINHA + LINHA + LINHA + LINHA+ LINHA

			oPrinter:Say(n_Lin, nColuna, "Rio de Janeiro, " + cValtoChar(Day(Date())) + " de " + MesExtenso(Month(Date())) + " de " + cValToChar(Year(Date())), o_Font)
			
			n_Lin := n_Lin + LINHA + LINHA

			oPrinter:Say(n_Lin, n_ColIni + 180, "CONFIRMAÇÃO DE CANCELAMENTO DO PLANO DE SAÚDE", o_Font)
			
			n_Lin := n_Lin + LINHA + LINHA

		EndIf

		If n_Lin == 0
			For nZ := 1 to n_LinCab
				n_Lin := n_Lin + LINHA
			Next
		EndIf

		oPrinter:Say(n_Lin, nColuna, aMsg[nK], o_Font)
		
	Next

Return

****************************************************************************************************************************************

Static Function aQuebraTxt(cTxt, nTamMax)

	Local aRet 		:= {}
	Local cRet		:= ''
	Local nJ		:= 0
	Local nK		:= 0
	Local nPos		:= 0

	If len(cTxt) > nTamMax

		For nJ := 1 to len(cTxt)

			If ( len(cRet + Substr(cTxt,nJ,1)) <= nTamMax )
				cRet += Substr(cTxt,nJ,1)
			Else
				If !empty(cRet)
					nPos := ( len(cRet) - RAt(' ',cRet) )
					cRet := Left(cRet,len(cRet) - nPos)

					For nK := 1 to nPos
						nJ--
					Next
				EndIf

				aAdd(aRet,cJustifica(cRet, nTamMax))
				cRet := Substr(cTxt,nJ,1)
			EndIf

		Next

	Else
		aAdd(aRet,cTxt)
	EndIf

	If !empty(cRet)
		aAdd(aRet,cRet)
	EndIf

Return aRet

****************************************************************************************************************************************

Static Function cJustifica(cTexto, nLimite)

	Local cRet 		:= RTrim(cTexto)
	Local lContinua := .T.
	Local nTamAnt	:= 0
	Local n_I		:= 1
	Local lInicio	:= .T.

	If empty(cTexto)
		lContinua 	:= .F.
		cRet		:= Space(nLimite)
	EndIf

	While lContinua

		nTamAnt := len(cTexto)

		For n_I := 1 to len(cTexto)

			If ( len(cTexto) > nLimite )
				Exit
			EndIf

			If lInicio .and. ( Substr(cTexto,n_I,1) <> ' ' )
				lInicio := .F.
			EndIf

			If !lInicio .and. ( Substr(cTexto,n_I,1) == ' ' )
				cTexto := Stuff(cTexto, n_I, 1, Space(2))
				n_I++
			EndIf

			If ( nTamAnt == len(cTexto) ) .or. ( len(cTexto) > nLimite )
				lContinua := .F.
			Else
				cRet := cTexto
			EndIf

		Next

	EndDo

Return cRet

******************************************************************************************************

Static Function cAlinDir(cMsg)

	cMsg := Space(n_ColMax - len(cMsg) - 1) + cMsg

Return cMsg

******************************************************************************************************



*--------------------------------------*
Static Function EnvEmail1( c_Dest, c_Caminho, c_Nome )
*--------------------------------------*

	Local _cMailServer	:= GetMv( "MV_RELSERV" )
	Local _cMailConta  	:= GetMv( "MV_EMCONTA" )
	Local _cMailSenha  	:= GetMv( "MV_EMSENHA" )
	Local _cTo  	   	:= c_Dest
	Local _cBCC			:= GETNEWPAR("MV_WFFINA","elifas.garcia@caberj.com.br;carlos.santos@caberj.com.br") + ";" + _cMailConta
	Local _cAssunto    	:= " "
	Local _cError      	:= ""
	Local l_Ok         	:= .T.
	Local _lSendOk     	:= .F.

	If cEmpAnt == '01'
		_cAssunto    	:= " Desligamento do plano - CABERJ "
	Else
		_cAssunto    	:= " Desligamento do plano - INTEGRAL "
	Endif

	c_Mensagem := "Em " + DtoC( Date() ) +  Chr(10) + Chr(13) + Chr(10) + Chr(13)

	c_Mensagem +=  Chr(13) + Chr(10) + Chr(13) + Chr(10) + "Prezado(a) :  " + c_Nome

	c_Mensagem +=  Chr(13) + Chr(13)

	c_Mensagem +=  Chr(13) + Chr(10) + Chr(13) + Chr(10) + "Enviamos em anexo os dados referentes ao cancelamento do plano solicitado"

	If !Empty( _cMailServer ) .And.    !Empty( _cMailConta  )

		CONNECT SMTP SERVER _cMailServer ACCOUNT _cMailConta PASSWORD _cMailSenha RESULT l_Ok

		If l_Ok

			SEND MAIL From _cMailConta To _cTo BCC _cBCC Subject _cAssunto Body c_Mensagem  Result _lSendOk ATTACHMENT c_Caminho
			
		Else

			GET MAIL ERROR _cError
			Aviso( "Erro no envio do E-Mail", _cError, { "Fechar" }, 2 )

		EndIf

		If l_Ok

			DISCONNECT SMTP SERVER

		EndIf

	EndIf

return()

/*/
{Protheus.doc} Static Function fGrvPrtAnx
Gerar Protocolo de Atendimento e grava anexo de carta de desligamento no PA
@type  Function
@author anderson.rangel
@since 11/11/2021
@version 1.0
/*/
Static Function fGrvPrtAnx(cDoc,cChaveAnx,cSeq)

	Local _aArea 	:= GetArea()
	Local lRet      := .T.									
	Local _cNumAnx	:= "" 
	Local _lGrAC9 	:= .F.
	Local _lAchou	:= .F.
	Local _cObjeto 	:= ""
	Local _cDescri 	:= ""
	Local _cCodAre	:= ""
	Local _cDesAre	:= ""
	
	Default cSeq		:= ''	
	Default cDoc		:= ''
	Default cChaveAnx	:= ''

	_cObjeto := SUBSTR(cDoc,RAT("\",cDoc)+1,Length(cDoc)-RAT("\",cDoc))
	_cDescri := SUBSTR(_cObjeto,1,RAT(".",_cObjeto)-1)

	// *CRIA PROTOCOLO DE ATENDIMENTO*

	//----------------------------------------------
	//Ponterar na Tabela de PBL (Tipo de Serviço)
	//Pegando assim a Area
	//----------------------------------------------
	DbSelectArea("PBL")
	DbSetOrder(1)
	If DbSeek(xFilial("PBL") + PADR(AllTrim("1104"),TAMSX3("PBL_YCDSRV")[1]))
					
		_cCodAre := PBL->PBL_AREA
		_cDesAre := PBL->PBL_YDEPTO
					
	EndIf
	
	DbSelectArea("BA1")
	DbSetOrder(2)
	If DbSeek(xFilial("BA1") + cChaveAnx)

		DbSelectArea("SZX")
		DbSetOrder(1)
		_lAchou := DbSeek(xFilial("SZX") + cSeq)
	
		RecLock("SZX",!_lAchou)
		SZX->ZX_FILIAL 	:= xFilial("SZX")
		SZX->ZX_SEQ 	:= cSeq
		SZX->ZX_NOMUSR 	:= alltrim(BA1->BA1_NOMUSR)
		SZX->ZX_DATDE	:= dDataBase
		SZX->ZX_HORADE 	:= STRTRAN(TIME(),":","")
		SZX->ZX_DATATE	:= dDataBase
		SZX->ZX_HORATE  := STRTRAN(TIME(),":","")
		SZX->ZX_CODINT 	:= BA1->BA1_CODINT
		SZX->ZX_CODEMP 	:= BA1->BA1_CODEMP
		SZX->ZX_MATRIC 	:= BA1->BA1_MATRIC
		SZX->ZX_TIPREG 	:= BA1->BA1_TIPREG
		SZX->ZX_DIGITO 	:= BA1->BA1_DIGITO
		SZX->ZX_TPINTEL	:= '2'  
		SZX->ZX_YDTNASC	:= BA1->BA1_DATNAS
		SZX->ZX_EMAIL 	:= BA1->BA1_EMAIL
		SZX->ZX_CONTATO	:= iif(BA1->BA1_DDD != ' ',alltrim(BA1->BA1_DDD) +' '+ alltrim(BA1->BA1_TELEFO) +' '+ alltrim(BA1->BA1_YTEL2) +' '+ alltrim(BA1->BA1_YCEL),' ')
		SZX->ZX_YPLANO 	:= POSICIONE("BI3",1,BA1->(BA1_FILIAL+BA1_CODINT+BA1_CODPLA+BA1_VERSAO),"BI3_CODIGO+' '+BI3_DESCRI")
		SZX->ZX_TPDEM	:= 'I' 	//Tipo de Demanda
		SZX->ZX_CANAL	:= '000028' //Canal
		SZX->ZX_PTENT 	:= '000014'  //Porta de Entrada
		SZX->ZX_VATEND	:= "3"    	//Seguindo o protocolo anterior (Novo PA não utiliza este campo)
		SZX->ZX_TPATEND := "1"
		SZX->ZX_YDTINC	:= dDataBase
		SZX->ZX_USDIGIT := "sistema"
		SZX->ZX_CPFUSR	:= BA1->BA1_CPFUSR
		SZX->ZX_PESQUIS := "4" //NÃO AVALIADO
		SZX->ZX_SLA		:= 2 //SLA
		SZX->ZX_CODAREA := _cCodAre	//Codigo da Area
		SZX->ZX_YAGENC  := _cDesAre	//Descrição da Area
		SZX->(MsUnLock())
	
	
		DbSelectArea("SZY")
		DbSetOrder(1)
		_lAchou := DbSeek(xFilial("SZY") + cSeq)

		RecLock("SZY",!_lAchou)
		SZY->ZY_SEQBA 	:= cSeq
		SZY->ZY_SEQSERV	:= '000001'
		SZY->ZY_DTSERV	:= dDatabase
		SZY->ZY_DTRESPO := dDatabase
		SZY->ZY_HRRESPO := SUBSTR(TIME(),1,2) + SUBSTR(TIME(),4,2)
		SZY->ZY_HORASV	:= SUBSTR(TIME(),1,2) + SUBSTR(TIME(),4,2)
		SZY->ZY_TIPOSV	:= '1104'
		SZY->ZY_OBS		:= "PROTOCOLO GERADO AUTOMATICAMENTE PELO SISTEMA - ENVIO DE CARTA DE DESLIGAMENTO (ROTINA RN412)" 
		SZY->ZY_HISTPAD	:= '000279'
		SZY->ZY_USDIGIT	:= 'sistema'
		SZY->ZY_RESPOST := "CARTA DE DESLIGAMENTO ANEXADA A ESTE PROTOCOLO ("+_cObjeto+")"
		SZY->ZY_PESQUIS := "4"
		SZY->(MsUnLock())

		// *ANEXAR CARTA DE DESLIGAMENTO*	
		
		_cNumAnx := GetSx8Num("ACB","ACB_CODOBJ")
		ConfirmSX8() 
		
		DbSelectArea("ACB")
		DbSetORder(1) //AC9_FILIAL+AC9_CODOBJ+AC9_ENTIDA+AC9_FILENT+AC9_CODENT
		
		If !(DbSeek(xFilial("ACB") + _cNumAnx ))

			_lGrAC9 := .T.

		Else

			While !_lGrAC9

				_cNumAnx := GetSx8Num("ACB","ACB_CODOBJ")
				ConfirmSX8() 

				DbSelectArea("ACB")
				DbSetORder(1) 
				If !(DbSeek(xFilial("ACB") + _cNumAnx ))

					_lGrAC9 := .T.

				Else

					_lGrAC9 := .F.

				EndIf

			EndDo

		EndIf

		If 	_lGrAC9
			
			//INDEX DA AC9 (ZX_FILIAL+ZX_SEQ+ZX_CODINT+ZX_CODEMP+ZX_MATRIC+ZX_TIPREG+ZX_DIGITO+DTOS(ZX_DATDE)+ZX_HORADE+DTOS(ZX_DATATE)+ZX_HORATE)
			
			RecLock("AC9",.T.)
			AC9->AC9_FILIAL := xFilial("AC9")
			AC9->AC9_FILENT := xFilial("SZX")
			AC9->AC9_ENTIDA	:= "SZX"
			AC9->AC9_CODOBJ	:= _cNumAnx
			AC9->AC9_CODENT	:= xFilial("SZX")+cSeq+cChaveAnx+DTOS(SZX->ZX_DATDE)+(SZX->ZX_HORADE)+DTOS(SZX->ZX_DATATE)+(SZX->ZX_HORATE)
			AC9->AC9_XUSU	:= 'SISTEMA'
			AC9->AC9_XDTINC := ddatabase
			AC9->AC9_HRINC  := STRTRAN(TIME(),":","")
			AC9->(MsUnLock())

			RecLock("ACB",.T.)
			ACB->ACB_FILIAL := xFilial("ACB")
			ACB->ACB_CODOBJ	:= _cNumAnx
			ACB->ACB_OBJETO	:= _cObjeto
			ACB->ACB_DESCRI	:= _cDescri
			ACB->(MsUnLock())

		EndIf

	EndIf

	RestArea(_aArea)

Return lRet
