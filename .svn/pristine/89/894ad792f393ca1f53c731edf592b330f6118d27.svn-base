#Include 'Protheus.ch'
#Include 'FISA022.ch'

//**************************************************************
// ROTINA: CABA353
// Função de execução do monitor
// Mateus Medeiros - 15/10/2018
//
//**************************************************************


User Function CABA353()
	
	Private lEnd := .f.
	Private cPerg := 'CABNFSE'
	
	CriaSX1(cPerg)
	
	If Pergunte(cPerg,.T. )
		
		Processa( {|lEnd| u_MntNFSEAut() }, "Aguarde...", "Carregando notas para transmissão...",.T.)
		// Chama a rotina de monitoramente, caso ainda exista nota que não esteja marcada como autorizada 
		// com sucesso.  
		U_CABA353A()
	else
		Alert("Processo cancelado pelo operador")
	Endif
	
Return

User Function CABA353A()
	
	Local aArea		:= GetArea()	
	Private lEnd := .f.
	Private cPerg := 'CABNFSE'
	
/*	CriaSX1(cPerg)
	
	If Pergunte(cPerg,.T. )*/
		
		Processa( {|lEnd| u_MonitorAut() }, "Aguarde...", "Monitorando notas que não foram monitoradas na transmissão...",.T.)
	/*else
		Alert("Processo cancelado pelo operador")
	Endif*/
	
	RestArea(aArea)
	
Return

//-----------------------------------------------------------------------
/*/{Protheus.doc} CBWsNFSeMnt
Funcao que executa o monitoramento manual

@author Sergio S. Fuzinaka
@since 20.12.2012
@version 1.0

@param cIdEnt	  		Codigo da entidade
@param aParam			Array de parametros

@return	aListBox		Array - montagem da grid do monitor
/*/
//-----------------------------------------------------------------------
Static Function CBWsNFSeMnt( cIdEnt, aParam, lUsaColab , aRet )

Local nX			:= 0
Local aListBox	 	:= { .F., "", {} }
Local cSerie		:= ""
Local cIdInicial	:= ""
Local cIdFinal		:= ""
Local cCNPJIni		:= ""
Local cCNPJFim		:= ""
Local dDataIni		:= CtoD("  /  /    ")
Local dDataFim		:= CtoD("  /  /    ")
Local aIdNotas		:= {}
Local cMod004		:= ""
Local nTpMonitor	:= 1
Local cModelo		:= "56"
Local lCte			:= .F.
Local cAviso		:= ""

Default aRet		:= {}
Default cIdEnt		:= ""
Default aParam		:= {}
Default lUsaColab	:= .F.

If Len( aParam ) > 0

	If lUsaColab
		//-- TOTVS Colaboracao 2.0 Monitoramento da nota de serviço
		aRet := colNfsMonProc( aParam, nTpMonitor, cModelo, lCte, cAviso, lUsaColab )
		If !Empty(cAviso)
			Aviso( "NFS-e", cAviso, { STR0114 }, 3 ) //"Ok"
		EndIf
		
		Return( aRet ) // Retorno para o TC2.0
		
	Else
		cMod004		:= Fisa022Cod("004")
		cSerie		:= aParam[ 1 ]
		cIdInicial	:= aParam[ 2 ]
		cIdFinal	:= aParam[ 3 ]

		If cEntSai == "0"
			cCNPJIni := aParam[ 4 ]
			cCNPJFim := aParam[ 5 ]
			dDataIni := aParam[ 6 ]
			dDataFim := aParam[ 7 ]
		Endif
		
		// aIdNotas[ 1 ]: Numero do documento
		// aIdNotas[ 2 ]: Flag ( documento ja retornado pelo TSS )
		aIdNotas := IdNfRet( aParam )
		
		Processa( {|| execMonitor( cIdEnt , cSerie , cCNPJIni , cCNPJFim, dDataIni, dDataFim , cMod004 , aIdNotas , @aListBox ) } , STR0169 , STR0170 , .F. ) //"Aguarde..." ### "Monitorando Nota Fiscal Eletrônica de Serviços..."
		
		If !aListBox[1]

			If !Empty( aListBox[ 2 ] )

				Aviso( "NFS-e", aListBox[ 2 ], { STR0114 }, 3 )

			ElseIf ( Empty( aListBox[ 3 ] ) )

				Aviso( "NFS-e", STR0106, { STR0114 } )

			Endif

		Endif

		If Len( aListBox[3] ) > 0
			aListBox[3] := aSort( aListBox[3],,,{|x,y| x[2] > y[2]} )
		Endif
	
		Return( aListBox[ 3 ] ) // Retorno para o TSS

	Endif

Endif

Return aRet


//-----------------------------------------------------------------------
/*/{Protheus.doc} cbMntNFSE
Monitoramento manual e automatico da NFS-e

@author Sergio S. Fuzinaka
@since 20.12.2012

@version 1.0
/*/
//-----------------------------------------------------------------------
Static Function cbMntNFSE( cIdEnt, cSerie, aLote, cCNPJIni, cCNPJFim, cMod004, dDataIni, dDataFim ,lUsaColab)

Local aListBox 		:= { .F., "", {} }
Local nTipoMonitor	:= 1
Local cIdInicial	:= ""
Local cIdFinal		:= ""
Local cIdNotas		:= ""
Local nBytes		:= 0
Local nX			:= 0

Default cIdEnt		:= ""
Default cSerie		:= ""
Default aLote		:= {}
Default cCNPJIni	:= ""
Default cCNPJFim	:= ""
Default dDataIni	:= CtoD("  /  /    ")
Default dDataFim	:= CtoD("  /  /    ")
default lUsaColab	:= .F.

For nX := 1 To Len( aLote )
	nBytes += Len( "'" + cSerie + Alltrim( aLote[nX] ) + "', " )
			
	If nBytes <= 950000
		cIdNotas += ( "'"  + cSerie + Alltrim( aLote[nX] ) + "'" ) + IIf( nX < Len( aLote ), ", ", "" )
	Else
		Exit
	Endif
Next
	
If Len( aLote ) > 0

	cIdInicial	:= aLote[ 1 ]
	cIdFinal	:= aLote[ Len( aLote ) ]
	
	aListBox 	:= FisMonitorX( cIdEnt, cSerie, cIdInicial, cIdFinal, cCNPJIni, cCNPJFim, nTipoMonitor, dDataIni, dDataFim, /* cHoraDe */, /* cHoraAte */, /* nTempo */, /* nDiasParaExclusao */, cIdNotas, cMod004 )
Endif
	
Return( aListBox )
//-----------------------------------------------------------------------
/*/{Protheus.doc} FisMonitorX
Funcao executa o metodo MonitorX()

@author Sergio S. Fuzinaka
@since 20.12.2012
@version 1.0      

@param cIdEnt	  		Codigo da entidade
@param aParam			Array de parametros
@param aDados			Dados da Nfs-e

@return	aListBox[1]		Logico   - status processamento
@return	aListBox[2]		Caracter - mensagem de erro
@return	aListBox[3]		Array    - montagem da grid do monitor

@Obs	A rotina de monitoramento da nfs-e eh executado de forma manual e automatica (Auto-Nfse), por este motivo nao dever ser utilizada
		funcoes de alertas como: MsgInfo, MsgAlert, MsgStop, Alert, Aviso, etc.
/*/
//-----------------------------------------------------------------------
Static Function FisMonitorX( cIdEnt, cNumSerie, cIdInicial, cIdFinal, cCNPJIni, cCNPJFim, nTipoMonitor, dDataDe, dDataAte, cHoraDe, cHoraAte, nTempo, nDiasParaExclusao, cIdNotas, cMod004 )

Local aRetorno				:= {}
Local aListBox 				:= {}
Local aMVTitNFT				:= &(GetNewPar("MV_TITNFTS",'{{""},{""}}'))
Local aMsg     				:= {}
Local aDataHora				:= {}

Local dEmiNfe				:= CTOD( "" )
Local cMsgErro			:= ""
Local cHorNFe				:= ""  
Local cNumero				:= ""
Local cSerie				:= ""
Local cRecomendacao		:= ""
Local cNota				:= ""
Local cRPS					:= ""
Local cCnpjForn			:= ""
Local cProtocolo			:= ""
Local cURL     			:= PadR(GetNewPar("MV_SPEDURL","http://"),250)     
Local cCodMun			:= AllTrim(if( type( "oSigamatX" ) == "U",SM0->M0_CODMUN,oSigamatX:M0_CODMUN ))
Local cURLNfse			:= ""
Local lOk      			:= .F.
Local lRetorno			:= .T.
Local lRetNumRps			:= GetNewPar("MV_RETRPS",.F.)  // Número da NFS-e gerada pela Prefeitura.
Local lUsaColab				:= .F.
Local nX	 				:= 0
Local nY       			:= 0
Local nAmbiente			:= 2
Local cCallName			:= "PROTHEUS"	// Origem da Chamado do WebService

Local oRetorno			:= Nil
Local lErroNot			:= .F.
Local cNotasOk			:= ""
Private oWS    			:= Nil
Private oXml				:= Nil  
Private oRetxml			:= Nil  
Private oRetxmlrps	 	:= Nil  

Default cIdEnt			:= ""
Default cNumSerie			:= ""
Default cIdInicial		:= ""
Default cIdFinal			:= ""
Default cCNPJIni			:= ""
Default cCNPJFim			:= ""
Default nTipoMonitor		:= 1
Default dDataDe			:= CTOD( "01/01/1949" )
Default dDataAte			:= CTOD( "31/12/2049" )
Default cHoraDe			:= "00:00:00"
Default cHoraAte			:= "00:00:00"
Default nTempo			:= 0
Default nDiasParaExclusao:= 0
Default cIdNotas			:= ""

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Chamada do Totvs Colaboração 2.0                    ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

If lUsaColab
	Fisa022Mon(cNumSerie /*aParam[1]*/,cIdInicial/*aParam[2]*/,cIdFinal/*aParam[3]*/,@aListBox/*@aMonitor*/,/*nMaxMon*/,/*@cNotasOk*/,.T. )
EndIf

If !lUsaColab
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Chamada do WebService da NFS-e                       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ	

oWS := WsNFSE001():New()

oWS:cUSERTOKEN   		:= "TOTVS"
oWS:cID_ENT      		:= cIdEnt 
oWS:_URL         		:= AllTrim(cURL)+"/NFSE001.apw"
oWS:cCODMUN    			:= cCodMun
oWS:dDataDe       		:= dDataDe
oWS:dDataAte     		:= dDataAte
oWS:cHoraDe       		:= cHoraDe
oWS:cHoraAte 			:= cHoraAte
oWS:nTipoMonitor		:= nTipoMonitor
oWS:nTempo   			:= nTempo 

If Type("cVerTss") <> "U" .And. cVerTss >= "2.19"  .Or. Val(substr(cVerTss,1,2)) >= 12
	oWS:nDiasParaExclusao	:= nDiasParaExclusao
	oWS:cIdNotas	  		:= cIdNotas 
	oWS:cCallName			:= cCallName
Endif

If cEntSai == "0" .And. cCodMun $ "3304557"
	oWS:cIdInicial := cNumSerie+cIdInicial+cCNPJIni
	oWS:cIdFinal   := cNumSerie+cIdFinal+cCNPJFim+"FIN"
ElseIf (cCodMun $ Fisa022Cod("201") .Or. cCodMun $ Fisa022Cod("202")) .And. cCodMun $ GetMunNFT() .and. !cCodMun $ "3550308"
	oWS:cIdInicial := cNumSerie+PADR(cIdInicial,TamSX3("F1_DOC")[1])+cCNPJIni
	oWS:cIdFinal   := cNumSerie+PADR(cIdFinal,TamSX3("F1_DOC")[1])+cCNPJFim+"FIN"
Else 		
	oWS:cIdInicial := cNumSerie+cIdInicial
	oWS:cIdFinal   := cNumSerie+cIdFinal
EndIf

incProc( "["+ oWS:cIdInicial +"] - ["+ oWS:cIdFinal +"]" )

lOk := ExecWSRet(oWS,"MonitorX")

If ( lOk )

	oRetorno := oWS:OWSMONITORXRESULT
	
	SF3->(dbSetOrder(5))
	
	For nX := 1 To Len(oRetorno:OWSMONITORNFSE)
		
		aMsg 			:= {}
		lRegFin 		:= .F.
						
		oXml 			:= oRetorno:OWSMONITORNFSE[nX]
		
		if lRegFin
	 		cNumero			:= PADR(SUBSTR(oXml:Cid,4,Len(oXml:Cid)),TamSX3("E2_NUM")[1])	
	 	else
		 	cNumero			:= PADR(Substr(oXml:cID,4,Len(oXml:cID)),TamSX3("F2_DOC")[1])	
	 	endif
		
		cProtocolo		:= oXml:cPROTOCOLO
		dEmiNfe			:= CTOD( "" )
		cHorNFe			:= ""
		cSerie			:= Substr(oXml:cID,1,3)
		cRecomendacao	:= oXml:cRECOMENDACAO
		cNota			:= oXml:cNota
		cRPS			:= oXml:cRPS
		cCnpjForn		:= padR(Substr(oXml:cid,13,Len(oXml:cid)),14)
		nAmbiente		:= oXml:nAmbiente
		if Type("oXml:cURLNFSE") <> "U"
			cURLNfse := oXml:cURLNFSE
		endif
		
		if RAT( "FIN", oXml:cid ) > 0 .And. SubStr( oXml:cid, RAT( "FIN", oXml:cid ) ) == "FIN" .And. cEntSai == "0"
			lRegFin := .T.			
		endif

		// Ignora a data de hora para NFTS de SP
		if!( cCodMun == "3550308" .and. type( "oXml:oWSNFE:cXMLERP" ) <> "U" .and. "<NFTS>" $ oXml:oWSNFE:cXMLERP )
			// Retorna a Data e a Hora do arquivo XML
			aDataHora := FisRetDataHora( oRetorno:OWSMONITORNFSE[nX], cMod004 )
		
			If Len( aDataHora ) > 0
				dEmiNfe	:= aDataHora[ 1 ]	// Data
				cHorNFe	:= aDataHora[ 2 ]	// Hora
			Endif
		endIf
		
		// Atualiza os dados com as mensagens de transmissao
		If ( Type("oXml:OWSERRO:OWSERROSLOTE") <> "U" )
			
			For nY := 1 To Len(oXml:OWSERRO:OWSERROSLOTE)
				
				If ( oXml:OWSERRO:OWSERROSLOTE[nY]:CCODIGO <> '' )
					aadd(aMsg,{oXml:OWSERRO:OWSERROSLOTE[nY]:CCODIGO,oXml:OWSERRO:OWSERROSLOTE[nY]:CMENSAGEM})
					Else
						lErroNot := .T.
				EndIf
				
			Next nY
			
		EndIf
		
		If ( Empty( aMsg ) )
				aAdd( aMsg, { "", "" } )
			Else
				lErroNot := .F.
		EndIf
		
			If FindFunction( "autoNfseMsg" )
				autoNfseMsg( "[Monitoramento] Nota Monitorada: " + cSerie + cNumero, .F. )
			EndIf
			//-- Atualizacao dos documentos
			CB022Upd(cProtocolo, cNumero, cSerie, cRecomendacao, cNota, cCnpjForn, dEmiNfe, cHorNFe, cCodMun, lRegFin, aMsg, lUsaColab)
			If !lErroNot
				aAdd( aListBox, {	"",;
									cSerie + cNumero,;
									nAmbiente,; //"Produção"###"Homologação"
									STR0058,; //"Normal"
									cProtocolo,;
									PADR( cRecomendacao, 250 ),;
									cRPS,;
									cNota,;
									aMsg,;
									cURLNfse} )
			EndIf
			
			//Ponto de entrada para o cliente customizar a gravação de 
			//campos proprios no SF2/SF1 a partir do refreh no monitor de notas
			If ExistBlock("F022ATUNF")
				ExecBlock("F022ATUNF",.F.,.F.,{cSerie,cNumero,cProtocolo,cRPS,cNota})
			EndIf
		Next nX

		If Empty( aListBox )
			lRetorno := .F.
			cMsgErro := STR0106 //"Não há dados"
		EndIf
	Else
		lRetorno := .F.
		cMsgErro := IIf( Empty(GetWscError(3)), GetWscError(1), GetWscError(3) )
	EndIf

EndIf

	aRetorno	:= {}
	aAdd( aRetorno, lRetorno )
	aAdd( aRetorno, cMsgErro )
	aAdd( aRetorno, aListBox )

	
	oWS			:= Nil
	oXml		:= Nil
	oRetxml		:= Nil
	oRetxmlrps	:= Nil
	delClassIntF()

Return( aRetorno )
//-------------------------------------------------------------------
/*/{Protheus.doc} execMonitor
Funcao responsavel por controlar o monitoramento dos documentos selecionados no botao Monitor da rotina Fisa022.

Todos os documentos requisitados na rotina de monitoramento serao enviados ao TSS com o objetivo de obter o
status de cada documento. Devido a limitacao de 1mb do arquivo xml retornado pelo web service, podera haver
a necessidade de repetir esta requisicao por diversas vezes ao TSS.

Esta funcao somente deixara de enviar pacotes ao TSS quando nao houver mais retorno do metodo MonitorX, ou
seja, enquanto houver retorno do web service a rotina continuara consultando o TSS.

Foi estabelecido uma regra de 30 documentos ou mais para que a rotina emita um aviso ao usuario indicando
uma possivel demora no processo devido a quantidade selecionada para monitoramento.

@param		cIdEnt		Codigo da entidade corrente
@param		cSerie		Serie dos documentos que serao monitorados
@param		cCNPJIni	CNPJ inicial no caso de monitoramento dos documentos de entrada
@param		cCNPJFim	CNPJ final no caso de monitoramento dos documentos de entrada
@param		cMod004		Codigo relacionado ao modelo 004
@param		aIdNotas	Array com todos os documentos que devem ser monitorados
@param		aListBox	Deve ser enviado como referencia, pois este array sera manipulado dentro da funcao para receber o resultado do monitoramento

@author		Luccas Curcio
@since		19/09/2014
@version	1.0
/*/
//-------------------------------------------------------------------
Static Function execMonitor( cIdEnt , cSerie , cCNPJIni , cCNPJFim, dDataIni, dDataFim , cMod004 , aIdNotas , aListBox )
	
	local	lKeepProcess	:=	.T.
	local	nPosIdNotas		:=	0
	local	nInicial		:=	1
	local	nX				:=	0
	local	aLote			:=	{}
	local	nLote			:=	0
	local	aListBoxTmp		:=	{ .F. , "" , {} }
	local	aRetListBox		:=	{}
	
	if len( aIdNotas ) > 30
		//"Foi selecionada uma grande quantidade de documentos para monitoramento. Devido a isso a consulta será mais lenta e poderá demorar alguns minutos."
		//"Sugerimos que seja selecionado um range mais específico de documentos."
		//"Deseja continuar?"
		lKeepProcess := MsgYesNo( STR0171 + CRLF + CRLF + STR0172 + CRLF + CRLF + STR0173 )
	endif
	
	procRegua( recCount() )
	
	while lKeepProcess
		//reseta conteudo do lote a ser consultado no TSS
		aLote	:=	{}
		nLote	:=	0
		
		for nX := nInicial to len( aIdNotas )
			
			nLote++
			
			//verifica se o documento ja foi retornado pelo TSS
			if !( aIdNotas[ nX , 2 ] )
				//adiciona o documento ao lote
				aAdd( aLote, aIdNotas[ nX , 1 ] )
			endif
			
			If nLote == 30
				Exit
			Endif
			
		next
		
		nInicial := ( nX + 1 )
		
		//consulta os documentos no TSS
		aRetListBox := cbMntNFSE( cIdEnt, cSerie, aLote, cCNPJIni, cCNPJFim, cMod004, dDataIni, dDataFim )
		
		for nX := 1 to len( aRetListBox[ 3 ] )
			
			aAdd( aListBoxTmp[ 3 ] , aRetListBox[ 3 , nX ] )
			
			//procura o documento no array aIdNotas
			//nPosIdNotas := aScan( aIdNotas , { |x| Val(x[ 1 ]) == Val(aRetListBox[ 3 , nX , 7 ]) } )
			nPosIdNotas := aScan( aIdNotas , { |x| x[1] $ aRetListBox[3 , nX , 2]})
			
			If nPosIdNotas > 0
				//altera o flag do documento no array aIdNotas
				aIdNotas[ nPosIdNotas , 2 ] := .T.
			EndIf
		next
		
		aListBoxTmp[1] := ( Len( aListBoxTmp[ 3 ] ) > 0 )
		aListBoxTmp[2] := iif( !empty( aRetListBox[ 2 ] ) .and. !empty( aListBoxTmp[ 2 ] ) , aRetListBox[ 2 ] , "" )
		
		if ( empty( aRetListBox[3] ) )
			
			If nInicial >= Len( aIdNotas )
				lKeepProcess	:= .F.
			Endif
			
			aListBox[ 3 ]	:= aClone( aListBoxTmp[ 3 ] )
			aListBox[ 1 ]	:= len( aListBox[3] ) > 0
			aListBox[ 2 ]	:= iif( !Empty( aListBoxTmp[2] ), aListBoxTmp[2], "" )
			
		endif
		
	end
	
return aListBox

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³IsReady   ³ Autor ³Eduardo Riera          ³ Data ³18.06.2007³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Verifica se a conexao com a Totvs Sped Services pode ser    ³±±
±±³          ³estabelecida                                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³Nenhum                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ExpN2: Código do município                               OPC³±±
±±³          ³ExpC1: URL do Totvs Services SPED                        OPC³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   DATA   ³ Programador   ³Manutencao efetuada                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³          ³               ³                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function IsReady(cCodMun, cURL, nTipo)
	
	Local lRetorno := .T.
	Local oWs      := Nil
	Local lUsaColab := .F.
	Default cCodMun := SM0->M0_CODMUN
	Default cURL	  := Padr(GetNewPar("MV_SPEDURL","http://localhost:8080/nfse"),250)
	
	If !lUsaColab
		
		If !Empty(cURL) .And. !PutMV("MV_SPEDURL",cURL)
			RecLock("SX6",.T.)
			SX6->X6_FIL     := xFilial( "SX6" )
			SX6->X6_VAR     := "MV_SPEDURL"
			SX6->X6_TIPO    := "C"
			SX6->X6_DESCRIC := "URL do WebService Nota Fiscal de Serviços Eletrônica."
			MsUnLock()
			PutMV("MV_SPEDURL",cURL)
		EndIf
		SuperGetMv() //Limpa o cache de parametros - nao retirar
		
		DEFAULT cURL  := PadR(GetNewPar("MV_SPEDURL","http://"),250)
		Default nTipo := 1
		
		// Verifica se o servidor da Totvs esta no ar
		if  Empty(cURL)
			lRetorno := .F.
		Else
			oWs := WsSpedCfgNFe():New()
			oWs:cUserToken := "TOTVS"
			oWS:_URL := AllTrim(cURL)+"/SPEDCFGNFe.apw"
			If ExecWSRet( oWs ,"CFGCONNECT" )
				lRetorno := .T.
				If ExecWSRet( oWs ,"CFGTSSVERSAO" )
					cVerTSS := oWs:cCfgTSSVersaoResult
				EndIf
			Else
				Aviso("NFS-e",IIf(Empty(GetWscError(3)),GetWscError(1),GetWscError(3)),{STR0114},3)
				lRetorno := .F.
			EndIf
		Endif
		// Verifica se o certificado digital ja foi transferido
		If lRetorno .And. nTipo == 2
			oWs := WsNFSe001():New()
			oWs:cUserToken := "TOTVS"
			oWs:cID_ENT    := GetIdEnt()
			oWs:cCODMUN    := cCodMun
			oWS:_URL       := AllTrim(cURL)+"/NFSe001.apw"
			If ExecWSRet( oWs ,"CFGREADYX" )
				lRetorno := .T.
			Else
				lRetorno := .F.
			EndIf
		EndIf
	EndIf
	
Return lRetorno



//-------------------------------------------------------------------
/*/{Protheus.doc} IdNfRet
Funcao para retornar notas que existem na base realmente

@author		Leonardo Kichitaro
@since		14/09/2015
/*/
//-------------------------------------------------------------------
Static Function IdNfRet( aParam )
	Local aArea			:= GetArea()
	Local aRetNf		:= {}
	Local cAliasSF3		:= "SF3"
	Local lTopDbf		:= .T.
	Local cWhere		:= ""
	
	if( cEntSai == "0" )
		cWhere := "%SF3.F3_NFISCAL BETWEEN '"+ aParam[ 2 ] +"' AND '"+ aParam[ 3 ] +"' AND "
		cWhere += "SF3.F3_ENTRADA BETWEEN '"+ dtos( aParam[ 6 ] ) +"' AND '"+ dtos( aParam[ 7 ] ) +"'%"
	else
		cWhere := "%SF3.F3_NFISCAL BETWEEN '"+ aParam[ 2 ] +"' AND '"+ aParam[ 3 ] +"'%"
	endIf
	
	#IFDEF TOP
		
		lTopDbf	:= .T.
		
		cAliasSF3 := GetNextAlias()
		
		if( cEntSai == "0" )
			BeginSql Alias cAliasSF3
				
				SELECT ( SF3.F3_NFISCAL + SA2.A2_CGC ) AS F3_NFISCAL
				FROM %Table:SF3% SF3
				JOIN %Table:SA2% SA2 ON
				SA2.A2_FILIAL = %xFilial:SA2% AND
				SA2.A2_COD = SF3.F3_CLIEFOR AND
				SA2.A2_LOJA = SF3.F3_LOJA AND
				SA2.A2_CGC BETWEEN %Exp:aParam[ 4 ]% AND %Exp:aParam[ 5 ]% AND
				SA2.%notdel%
				WHERE
				SF3.F3_FILIAL = %xFilial:SF3% AND
				SF3.F3_SERIE = %Exp:aParam[ 1 ]% AND
				%Exp:cWhere% AND
				SF3.%notdel%
			EndSql
		else
			BeginSql Alias cAliasSF3
				
				SELECT SF3.F3_NFISCAL
				FROM %Table:SF3% SF3
				WHERE
				SF3.F3_FILIAL = %xFilial:SF3% AND
				SF3.F3_SERIE = %Exp:aParam[ 1 ]% AND
				%Exp:cWhere% AND
				SF3.%notdel%
			EndSql
		endIf
	#ELSE
		
		lTopDbf	:= .F.
		
		(cAliasSF3)->( dbSetOrder(5) )
		if( cEndSai == "0" )
			bCondicao := {||	SF3->F3_FILIAL	== xFilial("SF3") .And. ;
				SF3->F3_SERIE	== aParam[ 1 ] .And. ;
				SF3->F3_NFISCAL	>= aParam[ 2 ] .And. ;
				SF3->F3_NFISCAL	<= aParam[ 3 ] .and. ;
				SF3->F3_ENTRADA	>= dtos( aParam[ 6 ] ) .and. ;
				SF3->F3_ENTRADA	<= dtos( aParam[ 7 ] ) }
		else
			bCondicao := {||	SF3->F3_FILIAL	== xFilial("SF3") .And. ;
				SF3->F3_SERIE	== aParam[ 1 ] .And. ;
				SF3->F3_NFISCAL	>= aParam[ 2 ] .And. ;
				SF3->F3_NFISCAL	<= aParam[ 3 ] }
		endIf
		
		(cAliasSF3)->(DbSetFilter(bCondicao,""))
		(cAliasSF3)->(dbGotop())
		
	#ENDIF
	
	While (cAliasSF3)->(!Eof())
		aAdd(aRetNf,{ AllTrim((cAliasSF3)->F3_NFISCAL) , .F. })
		
		(cAliasSF3)->(dbSkip())
	EndDo
	
	SF3->(DBClearFilter())
	
	If lTopDbf
		(cAliasSF3)->(dbCloseArea())
	EndIf
	
	RestArea(aArea)
	
Return aRetNf


//-----------------------------------------------------------------------
/*/{Protheus.doc} FisRetDataHora
Funcao que retorna Data e Hora do XML

@author Sergio S. Fuzinaka
@since 20.12.2012
@version 1.0
/*/
//-----------------------------------------------------------------------
Static Function FisRetDataHora( oXml, cMod004 )
	
Local aRetorno		:= {}
Local aDados		:= {}
local aRet			:= {}
Local cCodMun		:= if( type( "oSigamatX" ) == "U",SM0->M0_CODMUN,oSigamatX:M0_CODMUN )

Local cRecXml		:= ""
Local cRethora		:= ""
Local cRetdata		:= ""
Local dDataConv		:= CTOD( "" )
Local cCID			:= "" 

Private oWS			:= NIL

If Type( "oXml" ) <> "U"
	oWS := oXml
Endif
   		
If Type( "oWS:cID" ) <> "U" .And. !Empty( Alltrim( oWS:cID ) )

	cCID := Alltrim( oWS:cID )

	If ( IsTSSModeloUnico() .And. Type( "oWS:XMLRETTSS" ) <> "U" .And. !Empty( oWS:XMLRETTSS ) )
		
		AADD( aDados, RetornaMonitor( cCID, oWS:XMLRETTSS ) )
		
	Else
	
		cRetdata	:= ""
		cRethora	:= ""
		dDataconv 	:= CTOD( "" )
		
		
		if ( ( cCodMun == "3550308" .Or. cCodMun == "2611606" .Or. cCodMun == "4202404" .Or. cCodMun == "4209102") .And. ( cEntSai == "1" ) )  //SAO PAULO, RECIFE, BLUMENAU E JOINVILLE.		
			if Type( "oWS:OWSNFE:CXMLERP" ) <> "U" .And. !Empty( oWS:OWSNFE:CXMLERP )
				cRecxml		:= oWS:OWSNFE:CXMLERP			
			endif
		elseif cCodMun $ "3304557-3200607-3200300-3305000-3303302" .And. ( Type("oWS:OWSNFE:CXMLPROT") <> "U" .And. !Empty( oWS:OWSNFE:CXMLPROT ) )
			cRecxml := oWS:OWSNFE:CXMLPROT		
		else
			If Type( "oWS:OWSNFE:CXML" ) <> "U" .And. !Empty( oWS:OWSNFE:CXML )
				cRecxml		:= oWS:OWSNFE:CXML			
			endif
		endif		
		
		aRet := retDataXMLNfse(cRecxml,cCodMun)		

		if ( ( ( cCodMun == "3550308" .or. cCodMun == "4202404" ) .And. ( cEntSai == "1" ) ) .or.  GetMunSiaf(cCodMun)[1][2] $ "004-006-009"  )  //SAO PAULO E RECIFE E BLUMENAU
			aRet[2] := "00:00:00"
		Elseif GetMunSiaf(cCodMun)[1][2] $ "011" .Or. cCodMun $ "4308201-3524006-4313300-3505906"
			aRet[1] := ddatabase
			aRet[2] := "00:00:00"	
		endif

		AADD( aDados, { cCID, aRet[1], aRet[2], "" } )
	
	EndIf	

Endif

aRetorno 	:= {}

If Len( aDados ) > 0

	AADD( aRetorno, aDados[ 1, 2 ] )
	AADD( aRetorno, aDados[ 1, 3 ] )

Endif
	
Return( aRetorno )

//-----------------------------------------------------------------------
/*/{Protheus.doc} retDataXMLNFSe
retorna a data e a hora contida no XML da NFSe

@author Renato Nagib
@since 18.03.2013
@version 1.0

@param cXML	XML da NFSe

@Return aRet	array contendo a data e a hora
aRet[1] - data
aRet[2] - hora
/*/
//-----------------------------------------------------------------------

static function retDataXMLNFSe(cXML,cCodMun)
	
	
	local aTiposData	:= {}
	local aTiposHora	:= {}
	local aTiposDia		:= {}
	local aTiposMes		:= {}
	local aTiposAno		:= {}
	local aRet			:= {"", ""}
	local cAviso		:= ""
	local cErro		:= ""
	local cRetData	:= ""
	local cRetHora	:= ""
	local cConteudo	:= ""
	local cConteuDia:= ""
	local cConteuMes:= ""
	local cConteuAno:= ""
	local lDataHora	:= .T.
	local nPosData	:= 0
	local nPosHora	:= 0
	local nPosDia	:= 0
	local nPosMes	:= 0
	local nPosAno	:= 0
	
	private oXML
	
	default cXML	:= ""
	
	cXML := StrTran(cXML,"tipos:","")
	cXML := StrTran(cXML,"tc:","")
	cXML := StrTran(cXML,"es:","")
	cXML := StrTran(cXML,"nfse:","")
	cXML := StrTran(cXML,"sis:","")
	cXML := StrTran(cXML,'xsi:type="xsd:int"',"")
	cXML := StrTran(cXML,'xsi:type="xsd:string"',"")
	
	//colaboracao
	aadd( aTiposData, "_RPS:_DATAEMISSAORPS" )
	
	
	aadd( aTiposData, "_ENVIARLOTERPSENVIO:_LOTERPS:_LISTARPS:_RPS:_INFRPS:_DATAEMISSAO" )
	aadd( aTiposData, "_ENVIARLOTERPSENVIO:_LOTERPS:_LISTARPS:_RPS[1]:_INFRPS:_DATAEMISSAO" )
	aadd( aTiposData, "_P_ENVIARLOTERPSENVIO:_P_LOTERPS:_P1_LISTARPS:_P1_RPS:_P1_INFRPS:_P1_DATAEMISSAO" )
	
	//"3550308(SAO PAULO)-2611606(RECIFE)-4202404(BLUMENAU)
	aadd( aTiposData, "_RPS:_DATAEMISSAO" )
	
	//4318002(RS-São Borja)-4203006(SC-Caçador)-5218508(GO-Quirinópolis)-4207304(SC-Imbituba)-4211306(SC-Navegantes)
	aadd( aTiposData, "_E_ENVIARLOTERPSENVIO:_LOTERPS:_LISTARPS:_RPS[1]:_INFRPS:_DATAEMISSAO" )
	
	//4318002(RS-São Borja)-4203006(SC-Caçador)-5218508(GO-Quirinópolis)
	aadd( aTiposData, "_E_ENVIARLOTERPSENVIO:_LOTERPS:_LISTARPS:_RPS:_INFRPS:_DATAEMISSAO" )
	
	//3503307(SP-Araras)-3515004(SP-Embu das artes)-3538709(SP-Piracicaba)-3148103(MG-Patrocínio)-4202008(SC-Balneário Camboriú)
	aadd( aTiposData, "_ENVIARLOTERPSENVIO:_NFSE_LOTERPS:_NFSE_LISTARPS:_NFSE_RPS:_NFSE_INFRPS:_NFSE_DATAEMISSAO" )
	
	//"3106200|2927408|3170107|4106902|3501608|3301702|3136207|2304400|3543402|2704302|3115300|2507507|3547809|3513009|2604106|5201108|4104808|2800308|3548708|3513801|5103403|3525904|3518800|3118601|3519071|3518701|1302603|3156700|3549904|3303302|3549805|3548500|3300407|3147105|4118204|3300100|4125506|4108304|3131307|2910800|4208203|3536505|3518404|3529401|3523909|4216602|4204608|2802106|3143906|2307650|3136702|3106705|3169901|3303401" // |Belo Horizonte-MG|Salvador-BA|Uberaba-MG|Curitiba-PR|Americana-SP|Duque de Caxias-RJ|João Monlevade-MG|Fortaleza-CE|Ribeirão Preto-SP|Maceió-AL|Cataguases-MG|João Pessoa-PB|Santo André-SP|Cotia-SP|Caruaru-PE|Anápolis-GO|Cascavel-PR|Aracaju-SE|São Bernardo do Campo-SP|
	//Diadema-SP|Cuiabá-MT|Jundiai-SP|Guarulhos-SP|Contagem-MG|Hortolandia-SP|Guaruja-SP|Manaus-AM|Sabará-MG|São Borja-RS|São José dos Campos-SP|Niteroi|São José do Rio Preto-SP|Barra Mansa-RJ|Pará de Minas-MG|Paranaguá-PR|Angra dos Reis-RJ|São José dos Pinhais||Foz do Iguaçu-PR|Ipatinga-MG|Feira de Santana|Itajaí-SC|Paulinia|Guaratinguetá|Mauá|Itu|São José|Nova Friburgo|Criciúma|Estância-SE|Muriaé-MG|Maracanaú-CE|Juiz de Fora-MG|Betim-MG|Araquari-SC|
	aadd( aTiposData, "_CONSULTARLOTERPSRESPOSTA:_LISTANFSE:_COMPNFSE[1]:_NFSE:_INFNFSE:_DATAEMISSAO" )
	aadd( aTiposData, "_CONSULTARLOTERPSRESPOSTA:_LISTANFSE:_COMPNFSE:_NFSE:_INFNFSE:_DATAEMISSAO" )
	aadd( aTiposData, "_GERARNFSEENVIO:_LOTERPS:_LISTARPS:_RPS:_INFRPS:_DATAEMISSAO" )
	aadd( aTiposData, "_GERARNFSEENVIO:_RPS:_INFDECLARACAOPRESTACAOSERVICO:_RPS:_DATAEMISSAO" )
	aadd( aTiposData, "_ENVIARLOTERPSENVIO:_LOTERPS:_LISTARPS:_RPS:_INFDECLARACAOPRESTACAOSERVICO:_RPS:_DATAEMISSAO" )
	aadd( aTiposData, "_ENVIARLOTERPSENVIO:_LOTERPS:_LISTARPS:_RPS[1]:_INFDECLARACAOPRESTACAOSERVICO:_RPS:_DATAEMISSAO" )
	aadd( aTiposData, "_ENVIARLOTERPSSINCRONOENVIO:_LOTERPS:_LISTARPS:_RPS:_INFDECLARACAOPRESTACAOSERVICO:_RPS:_DATAEMISSAO" )
	aadd( aTiposData, "_ENVIARLOTERPSSINCRONOENVIO:_LOTERPS:_LISTARPS:_RPS[1]:_INFDECLARACAOPRESTACAOSERVICO:_RPS:_DATAEMISSAO" )
	aadd( aTiposData, "_ENVIARLOTERPSSINCRONORESPOSTA:_LISTANFSE:_COMPNFSE:_NFSE:_INFNFSE:_DATAEMISSAO" )
	
	
	//"2111300|5002704|3170206|1501402|2211001|3303500|3509502|3552205" //Sao Luis|Campo Grande|Uberlandia|Belem|Teresina|Nova Iguaçu|Campinas|Sorocaba - Modelo DSFNET
	aadd( aTiposData, "_NS1_REQENVIOLOTERPS:_LOTE:_RPS[1]:_DATAEMISSAORPS" )
	aadd( aTiposData, "_NS1_REQENVIOLOTERPS:_LOTE:_RPS:_DATAEMISSAORPS" )
	
	//3300704(Cabo Frio)-1400100(RR-Boa Vista)
	aadd( aTiposData, "_SubstituirNfseEnvio:_SubstituicaoNfse:_Rps:_InfDeclaracaoPrestacaoServico:_Rps:_DataEmissao" )
	//3158953 //Santana do Paraiso-MG
	aadd( aTiposData, "_NOTAS:_NOTA_DATA_EMISSAO" )
	
	//Modelo 004
	aadd( aTiposData, "_TBNFD:_NFD:_DATAEMISSAO" )
	
	//Modelo 007
	aadd( aTiposData, "_ENVIARLOTERPSENVIO:_LOTE:_LISTARPS:_RPS:_DTEMISSAORPS")
	aadd( aTiposData, "_ENVIARLOTERPSENVIO:_LOTE:_LISTARPS:_RPS[1]:_DTEMISSAORPS")
	
	//Modelo 008
	aadd( aTiposData, "_ENVIOLOTE:_DHTRANS")
	//Modelo 009
	aadd( aTiposData, "_NFEELETRONICA:_DADOSNOTAFISCAL:_EMISSAO")
	aadd( aTiposData, "_NFEELETRONICA:_DADOSNOTAFISCAL[1]:_EMISSAO")
	//Definir os tipos,caso exista Municipio que contenha a informação da hora em uma tag especifica
	aadd( aTiposHora, "" )
	
	//Definir os tipos, caso exista Municipio que contenha as informações do dia, mês e ano de emissão do RPS em uma tag especifica
	aadd( aTiposDia, "_DESCRICAORPS:_RPS_DIA")
	
	aadd( aTiposMes, "_DESCRICAORPS:_RPS_MES")
	
	aadd( aTiposAno, "_DESCRICAORPS:_RPS_ANO")
	
	//Aracruz
	aadd( aTiposData, "_RETURN:_NOTASFISCAIS:_DATAPROCESSAMENTO" )
	
	//Recife - NFSE
	aadd( aTiposData, "_INFRPS:_DATAEMISSAO" )
	
	oXML := XmlParser(cXML,"_",@cAviso,@cErro)
	
	If oXML == Nil
		oXML := XmlParser(EncodeUtf8(cXML),"_",@cAviso,@cErro)
	EndIf
	
	//verifica se a data é separada
	nPosDia := aScan(aTiposDia,{|X| type("oXML:"+X) <> "U" })
	nPosMes := aScan(aTiposMes,{|X| type("oXML:"+X) <> "U" })
	nPosAno := aScan(aTiposAno,{|X| type("oXML:"+X) <> "U" })
	
	if nPosDia > 0 .and. nPosMes > 0 .and. nPosAno > 0
		cConteuDia := "oXML:"+aTiposDia[nPosDia]+":TEXT"
		cConteuMes := "oXML:"+aTiposMes[nPosMes]+":TEXT"
		cConteuAno := "oXML:"+aTiposAno[nPosAno]+":TEXT"
	else
		//pega a data
		nPosData := aScan(aTiposData,{|X| type("oXML:"+X) <> "U" })
		
		if nPosData > 0
			cConteudo := "oXML:"+aTiposData[nPosData]+":TEXT"
		endif
		
	endif
	
	if !Empty(cConteuDia) .And. !Empty(cConteuMes) .And. !Empty(cConteuAno)
		cConteudo := (&(cConteuAno)+"/"+&(cConteuMes)+"/"+&(cConteuDia))
	else
		cConteudo :=&(cConteudo)
	endif
	
	if cConteudo == nil
		cConteudo := ""
	endif
	
	cRetData	:= substr(cConteudo,1,10)
	
	if lDataHora
		cRetHora	:= substr(cConteudo,12,8)
		
	else	 //busca a hora na tag especifica para hora
		
		nPosHora := aScan(aTiposHora,{|X| type("oXML:"+X) <> "U" })
		
		if nPosHora > 0
			cRetHora := "oXML:"+aTiposHora[nPosData]+":TEXT"
		endif
		
		cRetHora :=&(cRetHora)
		
		if cRetHora == nil
			cRetHora := ""
		endif
	endif
	
	If cCodMun <> "3205002"
		cRetData 	:= CTOD(SubStr(cRetData,9,2) + "/" + SubStr(cRetData,6,2)  + "/" + SubStr(cRetData,1,4))
	Else
		cRetData 	:= CTOD(cRetData)
	EndIf
	
	aRet[1]	:= cRetData
	aRet[2]	:= cRetHora
	
	oXML		:= NIL
	
return aRet


//-----------------------------------------------------------------------
/*/{Protheus.doc} retornaMonitor
Funcao que executa o retornanfse e retorna a data e hora de transmissão do documento.

@author Henrique Brugugnoli
@since 30/01/2012
@version 1.0

@param cXmlRet	XML unico de retorno do TSS

@return		Nil
/*/
//-----------------------------------------------------------------------
Static Function retornaMonitor( cCID, cXmlRet )
	
	Local aDados	:= {}
	
	Local cHora		:= ""
	Local cData		:= ""
	Local cAviso	:= ""
	Local cErro		:= ""
	Local cCodVer	:= ""
	Local dDataConv	:= CTOD( "" )
	
	Private oXml	:= NIL
	
	If ( !Empty(cXmlRet) )
		
		oXml := XmlParser( cXmlRet, "_", @cAviso, @cErro )
		
		cHora		:= ""
		cData		:= ""
		dDataConv	:= CTOD( "" )
		
		If ( empty(cErro) .And. empty(cAviso) ) .And. Type( "oXml:_nfseretorno:_identificacao:_tipo:TEXT" ) <> "U"
			
			If ( oXml:_nfseretorno:_identificacao:_tipo:TEXT == "1" ) .And. Type( "oXml:_nfseretorno:_identificacao:_dthremisrps:TEXT" ) <> "U"
				
				cHora := SubStr( oXml:_nfseretorno:_identificacao:_dthremisrps:TEXT,12,8 )
				cData := SubStr( oXml:_nfseretorno:_identificacao:_dthremisrps:TEXT,1,10 )
				
			ElseIf ( oXml:_nfseretorno:_identificacao:_tipo:TEXT == "2" ) .And. Type( "oXml:_nfseretorno:_cancelamento:_datahora:TEXT" ) <> "U"
				
				cHora := SubStr( oXml:_nfseretorno:_cancelamento:_datahora:TEXT,12,8 )
				cData := SubStr( oXml:_nfseretorno:_cancelamento:_datahora:TEXT,1,10 )
				
			EndIf
			
			If !Empty( cData )
				dDataConv := cToD(SubStr(cData,9,2) + "/" + SubStr(cData,6,2)  + "/" + SubStr(cData,1,4))
			Endif
			
			If Type( "oXml:_nfseretorno:_identificacao:_codver:TEXT" ) <> "U"
				cCodVer := oXml:_nfseretorno:_identificacao:_codver:TEXT
			Endif
			
			aDados := { cCID, dDataConv, cHora, cCodVer }
			
		EndIf
		
	EndIf
	
	oXml := Nil
	
Return( aDados )

//-------------------------------------------------------------------
/*/{Protheus.doc} CB022Upd
Funcao de atualizacao dos documentos - SEFAZ / NFs-e.

@author	Flavio Luiz Vicco
@since		15/08/2014
@version	1.0
/*/
//-------------------------------------------------------------------
Static Function CB022Upd(cProtocolo, cNumero, cSerie, cRecomendacao, cNota, cCnpjForn, dEmiNfe, cHorNFe, cCodMun, lRegFin, aMsg, lUsaColab)
	
	
	Local aMVTitNFT		:= &(GetNewPar("MV_TITNFTS",'{{""},{""}}'))
	Local cNotaArq		:= ""
	Local lF3CODRSEF		:= SF3->(FieldPos("F3_CODRSEF")) > 0
	Local lF3CODRET		:= SF3->(FieldPos("F3_CODRET" )) > 0 .And. SF3->(FieldPos("F3_DESCRET")) > 0
	Local lE2FIMP			:= SE2->(FieldPos("E2_FIMP"   )) > 0
	Local lE2NFELETR		:= SE2->(FieldPos("E2_NFELETR")) > 0
	Local nTamDoc			:= TamSx3("F2_NFELETR")[1]
	Local lExisCOP		:= AliasIndic("C0P")
	Local lRetNumRps		:= GetNewPar("MV_RETRPS",.F.)  // Número da NFS-e gerada pela Prefeitura.
	Local cIdEnt			:= GetIdEnt()
	Local cUrl				:= Padr(GetNewPar("MV_SPEDURL","http://localhost:8080/nfse"),250)
	
	Default cProtocolo 	:= ""
	Default cNumero		:= ""
	Default cSerie		:= ""
	Default cRecomendacao:= ""
	Default cNota			:= ""
	Default cCnpjForn		:= ""
	Default dEmiNfe		:= CTOD( "" )
	Default cHorNFe		:= ""
	Default cCodMun		:= SM0->M0_CODMUN
	Default lRegFin 		:= .F.
	Default aMsg    		:= {}
	Default lUsaColab		:= .F.
	
	If lUsaColab
		if ( 'aguarde o processamento' $ cRecomendacao )
			aMsg := {}
			aAdd(aMsg,{"  ",cRecomendacao})
		else
			aMsg := {}
			aAdd(aMsg,{"999",cRecomendacao})
		endif
	ElseIf ( 'Schema Invalido' $ cRecomendacao )
		aMsg := {}
		aAdd(aMsg,{"999",cRecomendacao})
	Endif
	
	if Len( aMsg ) > 0 .And. !Empty( aMsg[1][1] )
		If ( cEntSai == "1" )
			//-- NFS-e Nao Autorizada
			SF2->(dbSetOrder(1))
			If ( SF2->(MsSeek(xFilial("SF2")+cNumero+cSerie,.T.)) )
				
				SF2->( RecLock("SF2") )
				IF ( "002 -" $  cRecomendacao )
					SF2->F2_FIMP := "T" //NF Transmitida ,'BR_AZUL'
				ELSEIF ( "005 -" $  cRecomendacao )
					SF2->F2_FIMP := "T" //NF Transmitida ,'BR_AZUL'
				ELSE
					SF2->F2_FIMP := "N" //NF nao autorizada, 'BR_PRETO'
				ENDIF
				SF2->( MsUnlock() )
				
				SF3->(dbSetOrder(5))
				If ( SF3->(MsSeek(xFilial("SF3")+SF2->F2_SERIE+SF2->F2_DOC+SF2->F2_CLIENTE+SF2->F2_LOJA)) )
					
					If SF3->( FieldPos("F3_CODRSEF") ) > 0
						SF3->( RecLock("SF3") )
						IF ( "002 -" $  cRecomendacao )
							SF3->F3_CODRSEF := "T" //NF Transmitida ,'BR_AZUL'
							SF3->F3_CODRET  := "T"
						ELSEIF ( "005 -" $  cRecomendacao )
							SF3->F3_CODRSEF := "C" //NF Transmitida ,'BR_AZUL'
							SF3->F3_CODRET  := "T"
						ELSE
							SF3->F3_CODRSEF := "N" //NF nao autorizada, 'BR_PRETO'
						ENDIF
						If	lF3CODRET .And. Empty(SF3->F3_CODRET)
							SF3->F3_CODRET	:= aMsg[1][1]
							SF3->F3_DESCRET	:= aMsg[1][2]
							
						EndIf
						
						SF3->( MsUnlock() )
					EndIf
					
				EndIf
			EndIf
			
		elseif ( lRegFin )
			//-- Financeiro - Contas a Pagar
			SE2->(dbSetOrder(1))
			
			If ( SE2->(MsSeek(xFilial("SE2")+(cSerie+cNumero),.T.)) ) .And. SE2->( FieldPos("E2_FIMP") ) > 0
				
				While SE2->(!eof()) .And. xFilial("SE2") == SE2->E2_FILIAL .And. ( PADR(cNumero,LEN(SE2->E2_NUM)) == SE2->E2_NUM) .And. ( cSerie == SE2->E2_PREFIXO )
					
					If cCnpjForn == Posicione("SA2",1,xFilial("SA2")+SE2->E2_FORNECE+SE2->E2_LOJA,"SA2->A2_CGC") .And. ;
							aScan(aMVTitNFT,{|x| x[1]==SE2->E2_TIPO}) > 0 .And. SE2->E2_FIMP <> "N"
						
						RecLock("SE2")
						IF ( "002 -" $  cRecomendacao )
							SE2->E2_FIMP := "T" //NF Transmitida ,'BR_AZUL'
						ELSEIF ( "005 -" $  cRecomendacao )
							SE2->E2_FIMP := "T" //NF Transmitida ,'BR_AZUL'
						ELSE
							SE2->E2_FIMP := "N" //NF nao autorizada, 'BR_PRETO'
						ENDIF
						SE2->(MsUnlock())
						
					EndIf
					
					SE2->(dbSkip())
					
				EndDo
				
			EndIf
			
		Else
			//-- NFS-e
			SF1->(dbSetOrder(1))
			If ( SF1->(MsSeek(xFilial("SF1")+cNumero+cSerie,.T.)) )
				
				SF1->( RecLock("SF1") )
				IF ( "002 -" $  cRecomendacao )
					SF1->F1_FIMP  := "T" //NF Transmitida ,'BR_AZUL'
				ELSEIF ( "005 -" $  cRecomendacao )
					SF1->F1_FIMP  := "T" //NF Transmitida ,'BR_AZUL'
				ELSE
					SF1->F1_FIMP := "N" //NF nao autorizada,'BR_PRETO'
				ENDIF
				SF1->( MsUnlock() )
				//-- Livros Fiscais
				SF3->(dbSetOrder(5))
				If SF3->( MsSeek( xFilial("SF3")+SF1->F1_SERIE+SF1->F1_DOC+SF1->F1_FORNECE+SF1->F1_LOJA ) )
					
					If SF3->( FieldPos( "F3_CODRSEF" ) ) > 0
						SF3->( RecLock("SF3") )
						IF ( "002 -" $  cRecomendacao )
							SF3->F3_CODRSEF := "T" //NF Transmitida ,'BR_AZUL'
							SF3->F3_CODRET  := "T"
						ELSEIF ( "005 -" $  cRecomendacao )
							SF3->F3_CODRSEF := "C" //NF Transmitida ,'BR_AZUL'
							SF3->F3_CODRET  := "T"
						ELSE
							SF3->F3_CODRSEF := "N" //NF nao autorizada,'BR_PRETO'
							SF3->F3_CODRET  := ""
						ENDIF
						SF3->( MsUnlock() )
					EndIf
					
				EndIf
				
			EndIf
			
		EndIf
		
		//Atualização da tabela de AIDF
		if aliasIndic("C0P")
			C0P->(dbSetOrder(1))
			if C0P->(dbSeek(xFilial() +  padr(cValToChar(val(SF3->F3_NFISCAL)), tamSX3("C0P_RPS")[1] ) ) )
				reclock("C0P")
				C0P->C0P_AUT		:= "N"
				C0P->(msunlock())
			endif
		endif
	endif
	
	
	If ( "Emissao de Nota Autorizada" $ cRecomendacao ) .Or. (lUsaColab .And. "Emissão de nota autorizada" $ cRecomendacao )
		aMsg := {}
		aAdd(aMsg,{"111",cRecomendacao})
	ElseIf ( 'Nota Fiscal Substituida' $ cRecomendacao )
		aMsg := {}
		aAdd(aMsg,{"222",cRecomendacao})
	ElseIf ( 'Cancelamento do RPS Autorizado' $ cRecomendacao ).OR.( 'Cancelamento da NFS-e autorizado' $ cRecomendacao )
		aMsg := {}
		aAdd(aMsg,{"333",cRecomendacao})
	ElseIf ( 'aguarde o processamento' $ cRecomendacao ).And. lUsaColab
		aMsg := {}
		aAdd(aMsg,{"  ",cRecomendacao})
	EndIf
	
	If ( cEntSai == "1"	)
		//-- NFS-e Autorizada
		SF2->( dbSetOrder(1) )
		If SF2->(MsSeek(xFilial("SF2")+cNumero+cSerie,.T.))
			
			SF2->( RecLock("SF2") )
			
			If ( !Empty(cNota) ) .And. !Empty(RTrim(cProtocolo))
				SF2->F2_FIMP 		:= "S" //NF Autorizada, 'BR_GREEN'
				SF2->F2_NFELETR	:= RIGHT(cNota,nTamDoc)
				SF2->F2_EMINFE	:= dEmiNfe
				SF2->F2_HORNFE	:= cHorNFe
				SF2->F2_CODNFE	:= RTrim(cProtocolo)
			EndIf
			
			SF2->( MsUnlock() )
			//-- Livros Fiscais
			SF3->(dbSetOrder(5))
			If ( SF3->(MsSeek(xFilial("SF3")+SF2->F2_SERIE+SF2->F2_DOC+SF2->F2_CLIENTE+SF2->F2_LOJA)) )
				
				If ( SF3->(FieldPos("F3_CODRSEF")) > 0 )
					
					SF3->( RecLock("SF3") )
					
					If SF3->(FieldPos("F3_CODRET")) > 0 .And. SF3->(FieldPos("F3_DESCRET")) > 0
						If Len( aMsg ) > 0 .And. !Empty( aMsg[1][1] )
							SF3->F3_CODRET	:= aMsg[1][1]
							SF3->F3_DESCRET	:= aMsg[1][2]
						Endif
					EndIf
					
					If ( !Empty(cNota) ) .And. !Empty(RTrim(cProtocolo))
						SF3->F3_CODRSEF 	:= "S" //NF Autorizada, 'BR_GREEN'
						SF3->F3_NFELETR	:= RIGHT(cNota,nTamDoc)
						SF3->F3_EMINFE	:= dEmiNfe
						SF3->F3_HORNFE	:= cHorNFe
						SF3->F3_CODNFE	:= RTrim(cProtocolo)
					EndIf
					
					SF3->(MsUnlock())
				EndIf
			EndIf
			//-- Financeiro - Contas a Receber
			SE1->(dbSetOrder(2))
			If ( SE1->(MsSeek(xFilial("SE1")+SF2->F2_CLIENTE+SF2->F2_LOJA+SF2->F2_SERIE+SF2->F2_DOC)) )
				
				If ( Alltrim(SF3->F3_CODRSEF) == "S" )
					If ( !empty(cNota) )
						
						While SE1->(!eof()) .And. xFilial("SE1") == SF2->F2_FILIAL .And. SE1->E1_CLIENTE == SF2->F2_CLIENTE .And. SE1->E1_LOJA == SF2->F2_LOJA .And. SE1->E1_PREFIXO == SF2->F2_SERIE .And. SE1->E1_NUM == SF2->F2_DOC .Or.  ( SE1->(!eof()) .And. SE1->E1_FILORIG == SF2->F2_FILIAL .And. SE1->E1_CLIENTE == SF2->F2_CLIENTE .And. SE1->E1_LOJA == SF2->F2_LOJA .And. SE1->E1_PREFIXO == SF2->F2_SERIE .And. SE1->E1_NUM == SF2->F2_DOC )
							
							SE1->( RecLock("SE1") )
							SE1->E1_NFELETR := iif( lRetNumRps, cNota ,RIGHT(cNota,nTamDoc) )
							SE1->(MsUnlock())
							
							SE1->( dbSkip() )
						EndDo
						
					EndIf
				EndIf
				
			ElseIf 	( SE1->(MsSeek(xFilial("SE1")+SF2->F2_CLIENTE+SF2->F2_LOJA+SF2->F2_PREFIXO+SF2->F2_DOC)) )
				//--
				If ( Alltrim(SF3->F3_CODRSEF) == "S" )
					If ( !empty(cNota) )
						
						While SE1->(!eof()) .And. xFilial("SE1") == SF2->F2_FILIAL .And. SE1->E1_CLIENTE == SF2->F2_CLIENTE .And. SE1->E1_LOJA == SF2->F2_LOJA .And. SE1->E1_PREFIXO == SF2->F2_PREFIXO .And. SE1->E1_NUM == SF2->F2_DOC .Or. ( SE1->(!eof()) .And. SE1->E1_FILORIG == SF2->F2_FILIAL .And. SE1->E1_CLIENTE == SF2->F2_CLIENTE .And. SE1->E1_LOJA == SF2->F2_LOJA .And. SE1->E1_PREFIXO == SF2->F2_PREFIXO .And. SE1->E1_NUM == SF2->F2_DOC )
							
							SE1->( RecLock("SE1") )
							SE1->E1_NFELETR := iif( lRetNumRps, cNota ,RIGHT(cNota,nTamDoc) )
							SE1->( MsUnlock() )
							
							SE1->( dbSkip() )
						EndDo
						
					EndIf
				EndIf
			EndIf
			//-- Livros Fiscais - Resumo
			SFT->(dbSetOrder(1))
			If ( SFT->(MsSeek(xFilial("SFT")+"S"+SF2->F2_SERIE+SF2->F2_DOC+SF2->F2_CLIENTE+SF2->F2_LOJA)) )
				
				If ( Alltrim(SF3->F3_CODRSEF) == "S" )
					
					If ( !Empty(cNota) )
						
						While SFT->(!eof()) .And. xFilial("SFT") == SF2->F2_FILIAL .And. SFT->FT_TIPOMOV == "S" .And. SFT->FT_SERIE == SF2->F2_SERIE .And. SFT->FT_NFISCAL == SF2->F2_DOC .And. SFT->FT_CLIEFOR == SF2->F2_CLIENTE .And. SFT->FT_LOJA == SF2->F2_LOJA
							SFT->( RecLock("SFT") )
							SFT->FT_NFELETR	:= RIGHT(cNota,nTamDoc)
							SFT->FT_EMINFE	:= dEmiNfe
							SFT->FT_HORNFE	:= cHorNFe
							SFT->FT_CODNFE	:= RTrim(cProtocolo)
							SFT->( MsUnlock() )
							
							SFT->( dbSkip() )
						EndDo
						
					EndIf
				EndIf
			EndIf
			//-- NFST-e (SIGATMS)
			If IntTms()
				DT6->(DbSetOrder(1))
				If DT6->(DbSeek(xFilial("DT6")+SF2->F2_FILIAL+ SF2->F2_DOC+SF2->F2_SERIE))
					If ( Alltrim(SF3->F3_CODRSEF) == "S" )
						If ( !Empty(cNota) )
							While DT6->(!eof()) .And. DT6->DT6_SERIE == SF2->F2_SERIE .And. DT6->DT6_DOC == SF2->F2_DOC .And. DT6->DT6_CLIDEV == SF2->F2_CLIENTE .And. DT6->DT6_LOJDEV == SF2->F2_LOJA
								
								DT6->( RecLock("DT6") )
								DT6->DT6_NFELET := RIGHT(cNota,nTamDoc)
								DT6->DT6_EMINFE := dEmiNfe
								DT6->DT6_CODNFE := RTrim(cProtocolo)
								DT6->( MsUnlock() )
								
								//-- Executa integração do Datasul
								If FindFunction("TMSAE76")
									TMSAE76()
								EndIf
								DT6->(dbSkip())
								
							EndDo
						EndIf
					EndIf
				EndIf
			EndIf
			
		Else
			//-- Livros Fiscais
			dbSelectArea("SF3")
			SF3->( dbSetOrder(5) )
			If SF3->( MsSeek( xFilial("SF3") + cSerie + cNumero ) )
				If SF3->( FieldPos("F3_CODRSEF") ) > 0
					SF3->( RecLock("SF3") )
					SF3->F3_CODRSEF := "S"
					
					If SF3->(FieldPos("F3_CODRET")) > 0 .And. SF3->(FieldPos("F3_DESCRET")) > 0
						If Len( aMsg ) > 0 .And. !Empty( aMsg[1][1] )
							SF3->F3_CODRET	:= aMsg[1][1]
							SF3->F3_DESCRET	:= aMsg[1][2]
						Endif
					EndIf
					
					If !Empty(cNota) .And. !Empty(cProtocolo)
						SF3->F3_NFELETR	:= RIGHT(cNota,nTamDoc)
						SF3->F3_EMINFE	:= dEmiNfe
						SF3->F3_HORNFE	:= cHorNFe
						SF3->F3_CODNFE	:= RTrim(cProtocolo)
						SF3->F3_CODRSEF 	:= "S" //NF Autorizada, 'BR_GREEN'
					EndIf
					
					SF3->( MsUnlock() )
				EndIf
			EndIf
			//-- WS
			If !lUsaColab
				lRetMonit := GetMonitRx(cIdEnt,cUrl)
			EndIf
		EndIf
		
	elseif lRegFin
		
		SE2->(dbSetOrder(1))
		
		If ( SE2->(DbSeek(xFilial("SE2")+(cSerie+cNumero))) ) .And. SE2->( FieldPos("E2_FIMP") ) > 0 .And. SE2->( FieldPos("E2_NFELETR") ) > 0
			
			While SE2->(!eof()) .And. xFilial("SE2") == SE2->E2_FILIAL .And. ( PADR(cNumero,LEN(SE2->E2_NUM)) == SE2->E2_NUM) .And. ( cSerie == SE2->E2_PREFIXO )
				
				If cCnpjForn == Posicione("SA2",1,xFilial("SA2")+SE2->E2_FORNECE+SE2->E2_LOJA,"SA2->A2_CGC") .And. ;
						aScan(aMVTitNFT,{|x| x[1]==SE2->E2_TIPO}) > 0 .And. SE2->E2_FIMP <> "S"
					
					RecLock("SE2")
					SE2->E2_FIMP := "S" //NF Autorizada, 'BR_GREEN'
					SE2->E2_NFELETR := cNota
					SE2->(MsUnlock())
					
				EndIf
				
				SE2->(dbSkip())
				
			EndDo
			
		EndIf
		
	Else
		//-- NFS-e
		SF1->(dbSetOrder(1))
		If ( SF1->(MsSeek(xFilial("SF1")+(PADR(cNumero,LEN(SF1->F1_DOC))+cSerie),.T.)) )
			
			While SF1->(!eof()) .And. xFilial("SF1") == SF1->F1_FILIAL .And. ( PADR(cNumero,LEN(SF1->F1_DOC)) == SF1->F1_DOC) .And. ( cSerie == SF1->F1_SERIE )
				
				If cCnpjForn == Posicione("SA2",1,xFilial("SA2")+SF1->F1_FORNECE+SF1->F1_LOJA,"SA2->A2_CGC")
					
					
					SF1->( RecLock("SF1") )
					If ( !Empty(cNota) ) .And. !Empty(RTrim(cProtocolo))
						SF1->F1_NFELETR	:= RIGHT(cNota,nTamDoc)
						SF1->F1_EMINFE	:= dEmiNfe
						SF1->F1_HORNFE	:= cHorNFe
						SF1->F1_CODNFE	:= RTrim(cProtocolo)
						SF1->F1_FIMP 		:= "S" //NF Autorizada, 'BR_GREEN'
					EndIf
					
					
					SF1->( MsUnlock() )
					//-- Livros Fiscais
					SF3->( dbSetOrder(5) )
					If ( SF3->(MsSeek(xFilial("SF3")+SF1->F1_SERIE+SF1->F1_DOC+SF1->F1_FORNECE+SF1->F1_LOJA)) )
						
						If ( SF3->(FieldPos("F3_CODRSEF")) > 0 )
							
							SF3->( RecLock("SF3") )
							
							If ( !Empty( cNota ) ) .And. !Empty(RTrim(cProtocolo))
								
								SF3->F3_NFELETR	:= RIGHT(cNota,nTamDoc)
								SF3->F3_EMINFE	:= dEmiNfe
								SF3->F3_HORNFE	:= cHorNFe
								SF3->F3_CODNFE	:= RTrim(cProtocolo)
								SF3->F3_CODRSEF 	:= "S" //NF Autorizada, 'BR_GREEN'
							EndIf
							
							SF3->(MsUnlock())
							
						EndIf
					EndIf
					//-- Financeiro - Contas a Pagar
					SE2->( dbSetOrder(2) )
					If ( SE2->(MsSeek(xFilial("SE2")+SF1->F1_FORNECE+SF1->F1_LOJA+SF1->F1_SERIE+SF1->F1_DOC)) )
						
						If ( Alltrim(SF3->F3_CODRSEF) == "S" )
							If ( !Empty( cNota ) )
								
								While SE2->(!EOF()) .And. xFilial("SE1") == SF2->F2_FILIAL .And. SE2->E2_CLIENTE == SF1->F1_FORNECE .And. SE2->E2_LOJA == SF1->F1_LOJA .And. SE2->E2_PREFIXO == SF1->F1_SERIE .And. SE2->E2_NUM == SF1->F1_DOC
									
									SE2->( RecLock("SE2") )
									SE2->E2_NFELETR := RIGHT(cNota,nTamDoc)
									SE2->( MsUnlock() )
									
									SE2->( dbSkip() )
								EndDo
								
							EndIf
						EndIf
						
					EndIf
					//-- Livros Fiscais - Resumo
					SFT->( dbSetOrder(1) )
					If ( SFT->(MsSeek(xFilial("SFT")+"E"+SF1->F1_SERIE+SF1->F1_DOC+SF1->F1_FORNECE+SF1->F1_LOJA)) )
						
						If ( Alltrim(SF3->F3_CODRSEF) == "S" )
							If ( !Empty( cNota ) )
								
								While SFT->(!EOF()) .And. xFilial("SFT") == SF1->F1_FILIAL .And. SFT->FT_TIPOMOV == "E" .And. SFT->FT_SERIE == SF1->F1_SERIE .And. SFT->FT_NFISCAL == SF1->F1_DOC .And. SFT->FT_CLIEFOR == SF1->F1_FORNECE .And. SFT->FT_LOJA == SF1->F1_LOJA
									
									SFT->( RecLock("SFT") )
									SFT->FT_NFELETR	:= RIGHT(cNota,nTamDoc)
									SFT->FT_EMINFE	:= dEmiNfe
									SFT->FT_HORNFE	:= cHorNFe
									SFT->FT_CODNFE	:= RTrim(cProtocolo)
									SFT->( MsUnlock() )
									
									SFT->(dbSkip())
								EndDo
								
							EndIf
						EndIf
					EndIf
				EndIf
				SF1->(dbSkip())
			EndDo
		EndIf
	EndIf
	
	//atualização da tabela de AIDF
	if aliasIndic("C0P")
		SF3->(dbSetOrder(5))
		If SF3->(MsSeek(xFilial("SF3") + cSerie + cNumero))
			
			C0P->(dbSetOrder(1))
			If (cCodMun == "3524006" .Or. cCodMun == "3505906") .and. !C0P->(dbSeek(xFilial() +  padr(cValToChar(Val(SF3->F3_NFISCAL)), TamSX3("C0P_RPS")[1] ) ) )
				cNotaArq := "0"
			Else
				cNotaArq := cValToChar(Val(SF3->F3_NFISCAL))
			EndIf
			If C0P->(dbSeek(xFilial() +  Padr(cNotaArq, TamSX3("C0P_RPS")[1]))) .And. Empty(C0P->C0P_AUT)
				reclock("C0P",.F.)
				C0P->C0P_AUT := "S"
				If cCodMun == "3524006" .Or. cCodMun == "3505906"
					C0P->C0P_RPS := Val(SF3->F3_NFISCAL)
				EndIf
				C0P->(msunlock())
			EndIf
			
		EndIf
	endif
	
Return Nil



/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³GetIdEnt  ³ Autor ³Eduardo Riera          ³ Data ³18.06.2007³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Obtem o codigo da entidade apos enviar o post para o Totvs  ³±±
±±³          ³Service                                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ExpC1: Codigo da entidade no Totvs Services                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³Nenhum                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   DATA   ³ Programador   ³Manutencao efetuada                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³          ³               ³                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function GetIdEnt(cError)
	
	Local cIdEnt 	  := ""
	Local lUsaColab := .F.
	Default cError  := ""
	
	IF lUsaColab
		if !( ColCheckUpd() )
			Aviso("SPED","UPDATE do TOTVS Colaboração 2.0 não aplicado. Desativado o uso do TOTVS Colaboração 3.0",{STR0114},3)
		else
			cIdEnt := "000000"
		endif
	Else
		//if isCBConnTSS(@cError) // Verifica a conexão do TSS antes de iniciar o processo de validação da entidade
		//	cIdEnt := getCfgEntidade(@cError)
		//endif
		cIdEnt := getCfgEntidade(@cError)
		If !Empty(cError)
			Aviso("NFS-e",cError,{STR0114},3)
		EndIf
	EndIF
	
Return(cIdEnt)



//-------------------------------------------------------------------
/*/{Protheus.doc} isCBConnTSS
Verifica se esta concetado com o TSS


@param	cError		-	Mensagem de Error em caso de falha na requisição

@return	lRet		-	Status da conexão

@author  Renato Nagib
@since   17/08/2015
@version 12

/*/
//-------------------------------------------------------------------
Static function isCBConnTSS(cError)
	
	local aConn	:= { seconds(), date() }
	local cURL := ""
	local lRet := .T.
	local oWS := nil
	
	cUrl := alltrim( if( FunName() == "LOJA701" .and. !Empty( getNewPar("MV_NFCEURL","")), PadR(GetNewPar("MV_NFCEURL","http://"),250),padR(getNewPar("MV_SPEDURL","http://"),250 )) )
	
	varSetUID(UID, .T.)
	
	if(  !varGetAD(UID, "CFGCONNECT" + cUrl, @aConn) .or. ( seconds() - aConn[1] )  > 10 .or. date() > aConn[2] )
		
		oWs := WsSpedCfgNFe():New()
		oWs:cUserToken	:= "TOTVS"
		oWS:_URL 		:= AllTrim(cURL)+"/SPEDCFGNFe.apw"
		
		if( !execWSRet(oWs, "CFGCONNECT") )
			cError := IIf(Empty(GetWscError(3)),GetWscError(1),GetWscError(3))
			lRet := .F.
			
		else
			
			aConn := array(2)
			aConn[1] := seconds()
			aConn[2] := date()
			
			varSetAD(UID, "CFGCONNECT" + cUrl, aConn)
			
			aSize(aConn, 0)
			aConn := nil
			
		endIf
		
		oWS := nil
		
	endif
	
return lRet

//-------------------------------------------------------------------
/*/{Protheus.doc} getCfgEntidade
Retorno o codigo da Entidade no TSS.

@param cError	- Mensagem de Retorno em caso de falha na requisição

@return	Entidade	-	Codigo da Entidade

@author  Renato Nagib
@since   17/08/2015
@version 12

/*/
//--------------------------------------------------------------------
Static function getCfgEntidade(cError)
	
	local aArea 		:= {}
	local cIdEnt	 	:= ""
	local cURL			:= ""
	local lUsaGesEmp	:= .F.
	local lEnvCodEmp	:= .F.
	local oWS			:= nil
	
	default cError		 := ""
	
	//	varSetUID(UID, .T.)
	
	cUrl := alltrim( if( FunName() == "LOJA701" .and. !Empty( getNewPar("MV_NFCEURL","")), PadR(GetNewPar("MV_NFCEURL","http://"),250),padR(getNewPar("MV_SPEDURL","http://"),250 )) )
	
	//if(  !varGetXD(UID, alltrim(SM0->M0_CGC) + alltrim(SM0->M0_INSC) + alltrim(SM0->M0_ESTENT) + alltrim(SM0->M0_CODIGO) + alltrim(SM0->M0_CODFIL) + cUrl, @cIdEnt ) )
	
	aArea 	:= getArea()
	lEnvCodEmp	:= getNewPar("MV_ENVCDGE",.F.)
	lUsaGesEmp	:= iif(findFunction("FWFilialName") .And. findFunction("FWSizeFilial") .And. FWSizeFilial() > 2,.T.,.F.)
	
	oWS := WsSPedAdm():New()
	
	oWS:cUSERTOKEN				:= "TOTVS"
	oWS:oWSEMPRESA:cCNPJ		:= iiF(SM0->M0_TPINSC==2 .Or. empty(SM0->M0_TPINSC),SM0->M0_CGC,"")
	oWS:oWSEMPRESA:cCPF			:= iiF(SM0->M0_TPINSC==3,SM0->M0_CGC,"")
	oWS:oWSEMPRESA:cIE			:= AllTrim(SM0->M0_INSC)
	oWS:oWSEMPRESA:cIM			:= AllTrim(SM0->M0_INSCM)
	oWS:oWSEMPRESA:cNOME			:= AllTrim(SM0->M0_NOMECOM)
	oWS:oWSEMPRESA:cFANTASIA	:= iif(lUsaGesEmp,FWFilialName(),Alltrim(SM0->M0_NOME))
	oWS:oWSEMPRESA:cENDERECO		:= AllTrim(FisGetEnd(SM0->M0_ENDENT)[1])
	oWS:oWSEMPRESA:cNUM			:= AllTrim(FisGetEnd(SM0->M0_ENDENT)[3])
	oWS:oWSEMPRESA:cCOMPL		:= AllTrim(FisGetEnd(SM0->M0_ENDENT)[4])
	oWS:oWSEMPRESA:cUF			:= AllTrim(SM0->M0_ESTENT)
	oWS:oWSEMPRESA:cCEP			:= AllTrim(SM0->M0_CEPENT)
	oWS:oWSEMPRESA:cCOD_MUN		:= AllTrim(SM0->M0_CODMUN)
	oWS:oWSEMPRESA:cCOD_PAIS	:= "1058"
	oWS:oWSEMPRESA:cBAIRRO		:= AllTrim(SM0->M0_BAIRENT)
	oWS:oWSEMPRESA:cMUN			:= AllTrim(SM0->M0_CIDENT)
	oWS:oWSEMPRESA:cCEP_CP		:= nil
	oWS:oWSEMPRESA:cCP			:= nil
	oWS:oWSEMPRESA:cDDD			:= str(FisGetTel(SM0->M0_TEL)[2],3)
	oWS:oWSEMPRESA:cFONE		:= AllTrim(Str(FisGetTel(SM0->M0_TEL)[3],15))
	oWS:oWSEMPRESA:cFAX			:= AllTrim(Str(FisGetTel(SM0->M0_FAX)[3],15))
	oWS:oWSEMPRESA:cEMAIL		:= UsrRetMail(RetCodUsr())
	oWS:oWSEMPRESA:cNIRE			:= AllTrim(SM0->M0_NIRE)
	oWS:oWSEMPRESA:dDTRE		:= SM0->M0_DTRE
	oWS:oWSEMPRESA:cNIT			:= iif(SM0->M0_TPINSC==1,SM0->M0_CGC,"")
	oWS:oWSEMPRESA:cINDSITESP	:= ""
	oWS:oWSEMPRESA:cID_MATRIZ	:= ""
	
	if(lUsaGesEmp .And. lEnvCodEmp )
		oWS:oWSEMPRESA:CIDEMPRESA:= FwGrpCompany()+FwCodFil()
		
	endif
	
	oWS:oWSOUTRASINSCRICOES:oWSInscricao := SPEDADM_ARRAYOFSPED_GENERICSTRUCT():New()
	oWS:_URL := AllTrim(cURL)+"/SPEDADM.apw"
	
	if( oWs:ADMEMPRESAS() )
		cIdEnt  := oWs:cADMEMPRESASRESULT
		
		//	varSetXD(UID, alltrim(SM0->M0_CGC) + alltrim(SM0->M0_INSC) + alltrim(SM0->M0_ESTENT) + alltrim(SM0->M0_CODIGO) + alltrim(SM0->M0_CODFIL) + cUrl, cIdEnt )
	else
		cError := iif( empty(GetWscError(3)), getWscError(1), getWscError(3) )
		
	endif
	
	oWs := nil
	
	restArea(aArea)
	aSize(aArea,0)
	aArea := nil
	
	//endif
	
Return cIdEnt


//-----------------------------------------------------------------------
/*/{Protheus.doc} GetMonitRx
Funcao que retorna informações referente ao Monitoramento da NFS-e do TSS

@author Simone dos Santos Oliveira
@since 12.03.2012
@version 1.0

@param		Nil

@return		Nil
/*/
//-----------------------------------------------------------------------
Static Function GetMonitRx(cIdEnt,cUrl)
	
	Local aArea	:= GetArea()
	Local aNotas	:= {}
	Local cAliasSF3 := GetNextAlias()
	Local cCodMun   := if( type( "oSigamatX" ) == "U",SM0->M0_CODMUN,oSigamatX:M0_CODMUN )
	Local cNumAte	:= ""
	Local cNumDe  	:= ""
	Local lOk       := .F.
	local nAt		:= 0
	Local nX        := 0
	Local oWS		:= Nil
	Local oXmlMonit	:= Nil
	
	
	BeginSql Alias cAliasSF3
		COLUMN F3_ENTRADA AS DATE
		COLUMN F3_DTCANC AS DATE
		
		SELECT	F3_FILIAL,F3_ENTRADA,F3_NFeLETR,F3_CFO,F3_FORMUL,F3_NFISCAL,F3_SERIE,F3_CLIEFOR,F3_LOJA,F3_ESPECIE,F3_DTCANC,F3_CODRSEF,R_E_C_N_O_
		FROM %Table:SF3% SF3
		WHERE
		SF3.F3_FILIAL = %xFilial:SF3% AND
		SF3.F3_DTCANC <> ' ' AND
		SF3.F3_CODRSEF = 'C' AND
		SF3.%notdel%
	EndSql
	
	If ( cAliasSF3 )->( Eof() )
		Return .F.
	EndIf
	
	While !( cAliasSF3 )->( Eof() )
		
		aAdd( aNotas, { allTrim( ( cAliasSF3 )->F3_SERIE ) + allTrim( ( cAliasSF3 )->F3_NFISCAL ), ( cAliasSF3 )->R_E_C_N_O_ } )
		
		If (( cAliasSF3 )->F3_SERIE + ( cAliasSF3 )->F3_NFISCAL) < cNumDe .Or. Empty( cNumDe )
			cNumDe	:= ( cAliasSF3 )->F3_SERIE + allTrim( ( cAliasSF3 )->F3_NFISCAL )
		EndIf
		
		If (( cAliasSF3 )->F3_SERIE + ( cAliasSF3 )->F3_NFISCAL) > cNumAte .Or. Empty( cNumAte )
			cNumAte	:=  ( cAliasSF3 )->F3_SERIE + allTrim( ( cAliasSF3 )->F3_NFISCAL )
		EndIf
		
		( cAliasSF3 )->( DbSkip() )
		
	EndDo
	
	oWS := WsNFSE001():New()
	oWS:cUSERTOKEN             := "TOTVS"
	oWS:cID_ENT                := cIdEnt
	oWS:_URL                   := AllTrim(cURL)+"/NFSE001.apw"
	oWS:cCODMUN                := cCodMun
	oWS:dDataDe                := cTod("01/01/1949")
	oWS:dDataAte               := cTod("31/12/2049")
	oWS:cHoraDe                := "00:00:00"
	oWS:cHoraAte               := "00:00:00"
	oWS:nTipoMonitor           := 1
	oWS:cIdInicial             := cNumDe
	oWS:cIdFinal               := cNumAte
	oWS:nTempo                 := 0
	
	lOk := ExecWSRet(oWS,"MonitorX")
	
	If lOk
		
		oRetorno := oWS:OWSMONITORXRESULT
		
		For nX := 1 To Len(oRetorno:OWSMONITORNFSE)
			
			oXmlMonit := oRetorno:OWSMONITORNFSE[nX]
			
			nAt	:= aScan( aNotas, { | x | x[1] == allTrim( SubStr( oXmlMonit:CID, 1, 3 ) ) + allTrim( SubStr( oXmlMonit:CID, 4, 9 ) ) } )
			
			If nAt > 0
				
				If oXmlMonit:NSTATUSCANC == 3
					
					SF3->( DbGoTo( aNotas[nAt][2] ) )
					
					If SF3->(FieldPos("F3_CODRSEF")) > 0
						SF3->( RecLock("SF3",.F.) )
						SF3->F3_CODRSEF	:= "S"
						SF3->( MsUnlock() )
					EndIf
					
				EndIf
				
			EndIf
			
		Next nX
		
	EndIf
	
	( cAliasSF3 )->( dbCloseArea() )
	
	RestArea( aArea )
	
	
	oWS := nil
	delClassIntF()
	
Return .T.

	

//-----------------------------------------------------------------------
/*/{Protheus.doc} Bt2NFSeMnt
Funcao que exibe o historico da NFS-e

@author
@since
@version
/*/
//-----------------------------------------------------------------------
Static Function Bt2NFSeMnt(aMsg,lUsaColab)
	
	Local aSize    := MsAdvSize()
	Local aObjects := {}
	Local aInfo    := {}
	Local aPosObj  := {}
	Local oDlg
	Local oListBox
	Local oBtn1
	Default lUsaColab	:= .f.
	
	If !Empty(aMsg) .And. !lUsaColab
		AAdd( aObjects, { 100, 100, .t., .t. } )
		AAdd( aObjects, { 100, 015, .t., .f. } )
		aInfo := { aSize[ 1 ], aSize[ 2 ], aSize[ 3 ], aSize[ 4 ], 3, 3 }
		aPosObj := MsObjSize( aInfo, aObjects )
		
		DEFINE MSDIALOG oDlg TITLE "NFS-e" From aSize[7],0 to aSize[6],aSize[5] OF oMainWnd PIXEL
		@ aPosObj[1,1],aPosObj[1,2] LISTBOX oListBox Fields HEADER "Cod Erro", "Mensagem";
			SIZE aPosObj[1,4]-aPosObj[1,2],aPosObj[1,3]-aPosObj[1,1] PIXEL
		oListBox:SetArray( aMsg )
		oListBox:bLine := { || { aMsg[ oListBox:nAT,1 ],aMsg[ oListBox:nAT,2 ]} }
		@ aPosObj[2,1],aPosObj[2,4]-030 BUTTON oBtn1 PROMPT STR0114 ACTION oDlg:End() OF oDlg PIXEL SIZE 028,011 //"Ok"
		ACTIVATE MSDIALOG oDlg
	EndIf
	If !Empty(aMsg) .And. lUsaColab	 // Somente para Totvs Colaboração 2.0
		//aSort(aMsg,,,{|x,y| ( if( Empty(x[4]),"99/99/9999",DToC(x[4]))+x[5] > if(Empty(y[4]),"99/99/9999",DToC(x[4]))+y[5])})
		AAdd( aObjects, { 100, 100, .t., .t. } )
		AAdd( aObjects, { 100, 015, .t., .f. } )
		aInfo := { aSize[ 1 ], aSize[ 2 ], aSize[ 3 ], aSize[ 4 ], 3, 3 }
		aPosObj := MsObjSize( aInfo, aObjects )
		DEFINE MSDIALOG oDlg TITLE "NFS-e" From aSize[7],0 to aSize[6],aSize[5] OF oMainWnd PIXEL
		@ aPosObj[1,1],aPosObj[1,2] LISTBOX oListBox Fields HEADER "Cod Erro","Recibo SEF","Mensagem","Cod.Env.Lote","Dt.Lote","Hr.Lote","Msg.Env.Lote","Nome Arquivo","Lote";
			SIZE aPosObj[1,4]-aPosObj[1,2],aPosObj[1,3]-aPosObj[1,1] PIXEL
		oListBox:SetArray( aMsg )
		oListBox:bLine := { || { aMsg[ oListBox:nAT,1 ],aMsg[ oListBox:nAT,6 ],aMsg[ oListBox:nAT,2 ],aMsg[ oListBox:nAT,3 ],aMsg[ oListBox:nAT,4 ],aMsg[ oListBox:nAT,5 ],aMsg[ oListBox:nAT,7 ],aMsg[ oListBox:nAT,8 ],aMsg[ oListBox:nAT,9 ]} }
		@ aPosObj[2,1],aPosObj[2,4]-030 BUTTON oBtn1 PROMPT STR0114 ACTION oDlg:End() OF oDlg PIXEL SIZE 028,011 //"Ok"
		ACTIVATE MSDIALOG oDlg
	EndIf
Return(.T.)



/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    |DetSchema ³ Autor ³ Roberto Souza         ³ Data ³11/05/2010³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Exibe detalhe de schema.                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ ATUALIZACOES SOFRIDAS DESDE A CONSTRUCAO INICIAL.                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ PROGRAMADOR  ³ DATA   ³ BOPS ³  MOTIVO DA ALTERACAO                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³              ³        ³      ³                                        ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function DetSchema(cIdEnt,cCodMun,cIdNFe,nTipo,lAutomato)
	
	
	Local cURL     := PadR(GetNewPar("MV_SPEDURL","http://"),250)
	Local oWS
	Local cMsg     := ""
	Local aRetAuto := {}
	DEFAULT nTipo  := 1
	Default lAutomato := .F.
	
	oWS := WsNFSE001():New()
	oWS:cUSERTOKEN            := "TOTVS"
	oWS:cID_ENT               := cIdEnt
	oWS:cCodMun               := cCodMun
	oWS:_URL                  := AllTrim(cURL)+"/NFSE001.apw"
	oWS:nDIASPARAEXCLUSAO     := 0
	oWS:OWSNFSEID:OWSNOTAS    := NFSe001_ARRAYOFNFSESID1():New()
	
	aadd(oWS:OWSNFSEID:OWSNOTAS:OWSNFSESID1,NFSE001_NFSES1():New())
	oWS:OWSNFSEID:OWSNOTAS:OWSNFSESID1[1]:CCODMUN  := cCodMun
	oWS:OWSNFSEID:OWSNOTAS:OWSNFSESID1[1]:cID      := cIdNFe
	oWS:OWSNFSEID:OWSNOTAS:OWSNFSESID1[1]:cXML     := " "
	oWS:OWSNFSEID:OWSNOTAS:OWSNFSESID1[1]:CNFSECANCELADA := " "
	
	// Rotina automatizada
	If lAutomato
		If FindFunction("GetParAuto")
			aRetAuto	:= GetParAuto("AUTONFSETestCase")
			Aadd(aRetAuto, "")
		EndIf
	Endif
	
	If ExecWSRet(oWS,"RETORNANFSE")
		
		If Len(oWs:oWsRetornaNfseResult:OWSNOTAS:OWSNFSES5) > 0
			If nTipo == 1
				Do Case
				Case oWs:oWsRetornaNfseResult:OWSNOTAS:OWSNFSES5[1]:oWSNFECANCELADA <> Nil
					If !lAutomato
						Aviso("NFSE",oWs:oWsRetornaNfseResult:OWSNOTAS:OWSNFSES5[1]:oWSNFECANCELADA:cXML,{STR0114},3)
					Else
						MemoWrite(GetSrvProfString("RootPath","") + "\baseline\tssschema.xml", oWs:oWsRetornaNfseResult:OWSNOTAS:OWSNFSES5[1]:oWSNFECANCELADA:cXML)
						aRetAuto := oWs:oWsRetornaNfseResult:OWSNOTAS:OWSNFSES5[1]:oWSNFECANCELADA:cXML
					EndIf
				OtherWise
					If !lAutomato
						Aviso("NFSE",oWs:oWsRetornaNfseResult:OWSNOTAS:OWSNFSES5[1]:oWSNFE:cXMLERP,{STR0114},3)
					Else
						MemoWrite(GetSrvProfString("RootPath","") + "\baseline\tssschema.xml", oWs:oWsRetornaNfseResult:OWSNOTAS:OWSNFSES5[1]:oWSNFE:cXMLERP)
						aRetAuto := oWs:oWsRetornaNfseResult:OWSNOTAS:OWSNFSES5[1]:oWSNFE:cXMLERP
					EndIf
				EndCase
			Else
				cMsg := AllTrim(oWs:oWsRetornaNfseResult:OWSNOTAS:OWSNFSES5[1]:oWSNFE:cXMLERP)
				If !Empty(cMsg)
					If !lAutomato
						Aviso("NFSE",@cMsg,{STR0114},3,/*cCaption2*/,/*nRotAutDefault*/,/*cBitmap*/,.T.)
					Else
						MemoWrite(GetSrvProfString("RootPath","") + "\baseline\TSSSchema.xml", cMsg)
					EndIf
					oWS := WsNFSE001():New()
					oWS:cUSERTOKEN     := "TOTVS"
					oWS:cID_ENT        := cIdEnt
					oWS:cCodMun        := cCodMun
					
					oWs:oWsNF:oWSNOTAS:=  NFSE001_ARRAYOFNF001():New()
					aadd(oWs:oWsNF:oWSNOTAS:OWSNF001,NFSE001_NF001():New())
					
					oWs:oWsNF:oWSNOTAS:oWSNF001[1]:CID := cIdNfe
					oWs:oWsNF:oWSNOTAS:oWSNF001[1]:Cxml:= EncodeUtf8(cMsg)
					oWS:_URL                             := AllTrim(cURL)+"/NFSE001.apw"
					If ExecWSRet(oWS,"SchemaX")
						If Empty(oWS:OWSSCHEMAXRESULT:OWSNFSES4[1]:cMENSAGEM)
							Aviso("NFSE",STR0091,{STR0114})
						Else
							Aviso("NFSE",IIF(Empty(oWS:OWSSCHEMAXRESULT:OWSNFSES4[1]:cMENSAGEM),STR0091,oWS:OWSSCHEMAXRESULT:OWSNFSES4[1]:cMENSAGEM),{STR0114},3)
						EndIf
					Else
						Aviso("NFSE",IIf(Empty(GetWscError(3)),GetWscError(1),GetWscError(3)),{STR0114},3)
					EndIf
				EndIf
			EndIf
		EndIf
	Else
		Aviso("NFSE",IIf(Empty(GetWscError(3)),GetWscError(1),GetWscError(3)),{STR0114},3)
	EndIf
	
	
	oWS := nil
	delClassIntF()
	
Return



Static Function ExecWSRet( oWS, cMetodo )
	
	Local bBloco	:= {||}
	
	Local lRetorno	:= .F.
	
	Private oWS2
	
	DEFAULT oWS		:= NIL
	DEFAULT cMetodo	:= ""
	
	If ( ValType(oWS) <> "U" .And. !Empty(cMetodo) )
		
		oWS2 := oWS
		
		If ( Type("oWS2") <> "U" )
			bBloco 	:= &("{|| oWS2:"+cMetodo+"() }")
			lRetorno:= eval(bBloco)
			
			If ( lRetorno == NIL )
				lRetorno := .F.
			EndIf
			
		EndIf
		
	EndIf
	
Return lRetorno


//************************************
User Function MntNFSEAut()
	
	Local aVet 			:= {}
	
	Local cCodMun		:= AllTrim(if( type( "oSigamatX" ) == "U",SM0->M0_CODMUN,oSigamatX:M0_CODMUN ))
	Local aParam 	  	:= {Space(Len(SF2->F2_SERIE)),Space(Len(SF2->F2_DOC)),Space(Len(SF2->F2_DOC)),Space(14),Space(14),CTOD("  /  /    "),CTOD("  /  /    ")}
	Local cDEST			:= Space(10)
	Local lUsaColab		:= .f.
	Local cAlias		:= "SF2"
	Local lNFT			:= .F.
	Local lNFTE			:= .F.
	Local cAlias1   	:= GetNextAlias()
	
	Local cDatDe 	 	:= dtos(mv_par01)
	Local cDatAte 	 	:= dtos(mv_par02)
	Local cSituac		:= ''
	
	Private cURL     		:= PadR(GetNewPar("MV_SPEDURL","http://"),250)
	Private cIdEnt		:= GetIdEnt()
	Private cVerTss := ""
	Private cEntSai		:= "1"
	
	
	cIniHr := DTOC(ddatabase) + ' às '+ Time()
	
	BEGINSQL ALIAS cAlias1
		SELECT  TRIM(NFSE_ID) NFSE_ID,
		TRIM(RPS) RPS,
		TRIM(NVL(NFSE,' ' )) NFSE ,
		TRIM(NVL(NFSE_PROT,' '))  NFSE_PROT,
		F2_NFELETR,
		F2_EMINFE ,
		F2_HORNFE ,
		DATE_NFSE,
		TIME_NFSE,
		F2_DOC
		FROM SF2010 SF2
		left join TSSPROD.SPED051
		on ID_ENT = %exp:cIdEnt%
		AND NFSE_ID = F2_SERIE||F2_DOC
		AND NFSE_PROT <> ' '
		WHERE
		SF2.D_E_L_E_T_ = ' '
		AND F2_EMISSAO BETWEEN %exp:cDatDe% and %exp:cDatAte%
		AND F2_NFELETR = ' '
		AND NVL(NFSE_ID,' ') = ' '
		oRDER BY F2_DOC
	ENDSQL
	
	nTotal := 0
	
	dbeval({|| nTotal++ })
	(cAlias1)->(dbgotop())
	ProcRegua(nTotal)
	aMsgRet := {}
	
	if (cAlias1)->(!eof())
		do while (cAlias1)->(!eof())
			
			IncProc("Monitorando nota "+(cAlias1)->F2_DOC)
			
			if lEnd
				Exit
			EndIf
			
			aParam[1] 	:= 'UNI'
			aParam[2] 	:= (cAlias1)->F2_DOC
			aParam[3]	:= (cAlias1)->F2_DOC
			
			oWsTss := nil
			oWsTss:= WsSpedCfgNFe():New()
			oWsTss:cUSERTOKEN      := "TOTVS"
			oWsTss:cID_ENT         := cIdEnt
			oWSTss:_URL            := AllTrim(cURL)+"/SPEDCFGNFe.apw"
			lOk                    := IsReady(cCodMun, cURL, 1) // Mudar o terceiro parâmetro para 2 após o código de município 003 ter sido homologado no método CFGREADYX do serviço NFSE001
			
			If lOk
				lOk     := oWsTss:CfgTSSVersao()
				cVerTss := oWsTss:cCfgTSSVersaoResult
			EndIf
			
			cNotasOk := ""
			cMensRet := ""
			// Transmite
			Processa( {|| Fisa022Trs(cCodMun,'UNI',(cAlias1)->F2_DOC,(cAlias1)->F2_DOC,"",cAlias,@cNotasOk,cDEST,1,@cMensRet,ctod("01/01/2000"),ctod("01/01/2019"),,,"", , )},"Aguarde...","(1/1) Verificando dados...", .T. )
			Sleep(4000)
			// MONITORA NOTA
			if !empty(cNotasOk)
				aMonitor	:= CBWsNFSeMnt( cIdEnt, aParam, lUsaColab )
			endif
			
			if type("aMonitor[1][6]") == "C"
				if	alltrim(aMonitor[1][6]) <> "Emissao de Nota Autorizada."
				
					//Processa( {|| Fisa022Trs(cCodMun,'UNI',(cAlias1)->F2_DOC,(cAlias1)->F2_DOC,"",cAlias,@cNotasOk,cDEST,1,@cMensRet,ctod("01/01/2000"),ctod("01/01/2019"),,,"", , )},"Aguarde...","(1/1) Verificando dados...", .T. )
					Sleep(3000)
					if !empty(cNotasOk)
						aMonitor	:= CBWsNFSeMnt( cIdEnt, aParam, lUsaColab )
					Endif
					
					// valida após a segunda passagem na rotina de monitor
					if alltrim(aMonitor[1][6]) <> "Emissao de Nota Autorizada."
						cSituac := "N"
					else 
						cSituac := "S"	
					endif 
					
					cQuery := " INSERT  INTO SIGA.LOG_ENVIO_NOTA_FISCAL(DATA_OPERACAO ,OBSERVACAO ,SITUACAO ,COMPETENCIA ,NOTA_FISCAL ,OPERADORA )"
					cQuery += "    VALUES    (      SYSDATE ,      '"+alltrim(aMonitor[1][6])+"',      '"+cSituac+"' ,      '"+substr(cDatDe,1,6)+"' ,      '" + alltrim((cAlias1)->F2_DOC) + "' ,      '" + iif(cEmpAnt == "01","C","I") + "'    )"
					tcSqlExec(cQuery)
					aadd(aMsgRet,{(cAlias1)->F2_DOC,cNotasOk,alltrim(aMonitor[1][6]),dtoc(ddatabase),Time()})
				else
						
					cQuery := " INSERT  INTO SIGA.LOG_ENVIO_NOTA_FISCAL(DATA_OPERACAO ,OBSERVACAO ,SITUACAO ,COMPETENCIA ,NOTA_FISCAL ,OPERADORA )"
					cQuery += "    VALUES    (      SYSDATE ,      '"+alltrim(aMonitor[1][6])+"',      'S' ,      '"+substr(cDatDe,1,6)+"' ,      '" + alltrim((cAlias1)->F2_DOC) + "' ,      '" + iif(cEmpAnt == "01","C","I") + "'    )"
					tcSqlExec(cQuery)
					
					aadd(aMsgRet,{(cAlias1)->F2_DOC,cNotasOk,alltrim(aMonitor[1][6]),dtoc(ddatabase),Time()})
					
				endif
			ELSE
				
					cQuery := " INSERT  INTO SIGA.LOG_ENVIO_NOTA_FISCAL(DATA_OPERACAO ,OBSERVACAO ,SITUACAO ,COMPETENCIA ,NOTA_FISCAL ,OPERADORA )"
					cQuery += "    VALUES    (SYSDATE ,'Problema no monitoramento','S' ,'"+substr(cDatDe,1,6)+"' ,'" + alltrim((cAlias1)->F2_DOC) + "' ,'" + iif(cEmpAnt == "01","C","I") + "')"
					tcSqlExec(cQuery)
					
				aadd(aMsgRet,{(cAlias1)->F2_DOC,cNotasOk,'Problema no monitoramento',dtoc(ddatabase),Time()})
			endif
			
			DelClassIntF()
			(cAlias1)->(dbskip())
		EndDo
		
		// GERA RELATÓRIO DE NOTAS
		u_GerExecel(aMsgRet)
		
		alert("Fim do processamento iniciado em: "+ cIniHr+" finalizado em: " +DTOC(ddatabase) + ' às '+Time())
	else
		alert("Não há notas para transmisão no período informado.")
	endif
	
	IF SELECT(cAlias1)
		DBSELECTAREA(cAlias1)
		DBCLOSEAREA()
	ENDIF
	
Return



//uSER 
// rotina para monitorar automaticamente notas - com status no log diferente de nota autorizada. 

//************************************
User Function MonitorAut()
	
	Local aArea			:= GetArea()
	Local aVet 			:= {}
	
	Local cCodMun		:= AllTrim(if( type( "oSigamatX" ) == "U",SM0->M0_CODMUN,oSigamatX:M0_CODMUN ))
	Local aParam 	  	:= {Space(Len(SF2->F2_SERIE)),Space(Len(SF2->F2_DOC)),Space(Len(SF2->F2_DOC)),Space(14),Space(14),CTOD("  /  /    "),CTOD("  /  /    ")}
	Local cDEST			:= Space(10)
	Local lUsaColab		:= .f.
	Local cAlias		:= "SF2"
	Local lNFT			:= .F.
	Local lNFTE			:= .F.
	Local cAlias1   	:= GetNextAlias()
	
	Local cSituac		:= ''
	Local cDatDe        := FirstDay(ddatabase)
	Local cDatAte       := lastDay(ddatabase)
	Private cURL     		:= PadR(GetNewPar("MV_SPEDURL","http://"),250)
	Private cIdEnt		:= GetIdEnt()
	Private cVerTss := ""
	Private cEntSai		:= "1"
	
	
	cIniHr := DTOC(ddatabase) + ' às '+ Time()
	
	BEGINSQL ALIAS cAlias1
		SELECT  TRIM(NFSE_ID) NFSE_ID,
		TRIM(RPS) RPS,
		TRIM(NVL(NFSE,' ' )) NFSE ,
		TRIM(NVL(NFSE_PROT,' '))  NFSE_PROT,
		F2_NFELETR,
		F2_EMINFE ,
		F2_HORNFE ,
		DATE_NFSE,
		TIME_NFSE,
		F2_DOC,
		NOTA_FISCAL
		FROM SF2010 SF2
		left join TSSPROD.SPED051
		on ID_ENT = %exp:cIdEnt%
		AND NFSE_ID = F2_SERIE||F2_DOC
		AND NFSE_PROT <> ' '
		left join SIGA.LOG_ENVIO_NOTA_FISCAL  
		on OBSERVACAO <> 'Emissao de Nota Autorizada.' AND NOTA_FISCAL = F2_DOC
		WHERE
		SF2.D_E_L_E_T_ = ' '
		//AND F2_EMISSAO BETWEEN %exp:cDatDe% and %exp:cDatAte%
		AND F2_NFELETR = ' '
		AND NVL(NFSE_ID,' ') <> ' '
		oRDER BY F2_DOC
	ENDSQL
		
	nTotal := 0
	
	dbeval({|| nTotal++ })
	(cAlias1)->(dbgotop())
	ProcRegua(nTotal)
	aMsgRet := {}
	
	if (cAlias1)->(!eof())
		do while (cAlias1)->(!eof())
			
			IncProc("Monitorando nota "+(cAlias1)->NOTA_FISCAL)
			
			aParam[1] 	:= 'UNI'
			aParam[2] 	:= (cAlias1)->NOTA_FISCAL
			aParam[3]	:= (cAlias1)->NOTA_FISCAL
			
			oWsTss := nil
			oWsTss:= WsSpedCfgNFe():New()
			oWsTss:cUSERTOKEN      := "TOTVS"
			oWsTss:cID_ENT         := cIdEnt
			oWSTss:_URL            := AllTrim(cURL)+"/SPEDCFGNFe.apw"
			lOk                    := IsReady(cCodMun, cURL, 1) // Mudar o terceiro parâmetro para 2 após o código de município 003 ter sido homologado no método CFGREADYX do serviço NFSE001
			
			If lOk
				lOk     := oWsTss:CfgTSSVersao()
				cVerTss := oWsTss:cCfgTSSVersaoResult
			EndIf
			
			cNotasOk := ""
			cMensRet := ""
		
			// Monitora
			aMonitor	:= CBWsNFSeMnt( cIdEnt, aParam, lUsaColab )
			
			if type("aMonitor[1][6]") == "C"
				if	alltrim(aMonitor[1][6]) <> "Emissao de Nota Autorizada."
				
					//Processa( {|| Fisa022Trs(cCodMun,'UNI',(cAlias1)->F2_DOC,(cAlias1)->F2_DOC,"",cAlias,@cNotasOk,cDEST,1,@cMensRet,ctod("01/01/2000"),ctod("01/01/2019"),,,"", , )},"Aguarde...","(1/1) Verificando dados...", .T. )
					Sleep(3000)
					if !empty(cNotasOk)
						aMonitor	:= CBWsNFSeMnt( cIdEnt, aParam, lUsaColab )
					Endif
					
					// valida após a segunda passagem na rotina de monitor
					if alltrim(aMonitor[1][6]) <> "Emissao de Nota Autorizada."
						cSituac := "N"
					else 
						cSituac := "S"	
					endif 
					
					cQuery := " UPDATE SIGA.LOG_ENVIO_NOTA_FISCAL SET SITUACAO = '"+cSituac+"', OBSERVACAO='"+alltrim(aMonitor[1][6])+"'"
					cQuery += "    where  NOTA_FISCAL = '"+ alltrim((cAlias1)->NOTA_FISCAL)+"'"
					tcSqlExec(cQuery)
					aadd(aMsgRet,{(cAlias1)->NOTA_FISCAL,cNotasOk,alltrim(aMonitor[1][6]),dtoc(ddatabase),Time()})
				else
					cSituac := "S"		
							cQuery := " UPDATE SIGA.LOG_ENVIO_NOTA_FISCAL SET SITUACAO = '"+cSituac+"', OBSERVACAO='"+alltrim(aMonitor[1][6])+"'"
					cQuery += "    where  NOTA_FISCAL = '"+ alltrim((cAlias1)->NOTA_FISCAL)+"'"
					tcSqlExec(cQuery)
					
					aadd(aMsgRet,{(cAlias1)->NOTA_FISCAL,cNotasOk,alltrim(aMonitor[1][6]),dtoc(ddatabase),Time()})
					
				endif
			ELSE
				
					cQuery := " UPDATE SIGA.LOG_ENVIO_NOTA_FISCAL SET SITUACAO = 'N', OBSERVACAO='Não há dados'"
					cQuery += "    where  NOTA_FISCAL = '"+ alltrim((cAlias1)->NOTA_FISCAL)+"'"
					tcSqlExec(cQuery)
					
				aadd(aMsgRet,{(cAlias1)->NOTA_FISCAL,cNotasOk,'Problema no monitoramento',dtoc(ddatabase),Time()})
			endif
			
			DelClassIntF()
			(cAlias1)->(dbskip())
		EndDo
		
		// GERA RELATÓRIO DE NOTAS
		u_GerExecel(aMsgRet)
		
		alert("Fim do processamento iniciado em: "+ cIniHr+" finalizado em: " +DTOC(ddatabase) + ' às '+Time())
	else
		alert("Não há notas para transmisão no período informado.")
	endif
	
	IF SELECT(cAlias1)
		//DBSELECTAREA(cAlias1)
		(cAlias1)->(DBCLOSEAREA())
	ENDIF
	
	RestArea(aArea)
Return

// 
// rotina que irá na tabela de log da competência em questão, para gerar o relatório de log.  
User  Function GerExecel(aExcel)

Local cWkSkeet      :='Emit_NFSE'
Local cMesExt       := 'Notas'
Local nRegs			:= 0
Local cArquivo    	:= GetTempPath()+cvaltochar(randomize(1,100000))+'_CNF.xml'

Default aExcel		:= {}

nRegs := len(aExcel)

//Criando o objeto que irá gerar o conteúdo do Excel
oFWMsExcel := FWMSExcel():New()

//Aba 01 - Log_Boletos
oFWMsExcel:AddworkSheet(cWkSkeet)
//Criando a Tabela
oFWMsExcel:AddTable(cWkSkeet,cMesExt)
//Adicionando Coluna
oFWMsExcel:AddColumn(cWkSkeet,cMesExt,'NOTA/RPS',1)
oFWMsExcel:AddColumn(cWkSkeet,cMesExt,'Transmissão',1)
oFWMsExcel:AddColumn(cWkSkeet,cMesExt,'Monitoramento',1)
oFWMsExcel:AddColumn(cWkSkeet,cMesExt,'Data',1)
oFWMsExcel:AddColumn(cWkSkeet,cMesExt,'Hora',1)

ProcRegua(nRegs) // Atribui quantidade de registros que serão impressos

//Criando as Linhas... Enquanto não for fim da query
For nX := 1 to len(aExcel)
	
	if lEnd
		Alert("Processo terminado pelo usuário")
		Exit
	endif
	
	IncProc()
	IncProc("Aguarde.. Gerando Relatório de notas transmitidas..")
	
	oFWMsExcel:AddRow(cWkSkeet,cMesExt,{;
		aExcel[nX][1],;
		aExcel[nX][2],;
		aExcel[nX][3],;
		aExcel[nX][4],;
		aExcel[nX][5];
		})
	
Next nX

if !lEnd
	//Ativando o arquivo e gerando o xml
	oFWMsExcel:Activate()
	oFWMsExcel:GetXMLFile(cArquivo)
	
	//Abrindo o excel e abrindo o arquivo xml
	oExcel := MsExcel():New()           //Abre uma nova conexão com Excel
	oExcel:WorkBooks:Open(cArquivo)     //Abre uma planilha
	oExcel:SetVisible(.T.)              //Visualiza a planilha
	oExcel:Destroy()                    //Encerra o processo do gerenciador de tarefas
Endif

Return

// Função que criação as perguntas que estão feitas ao usuário
Static Function CriaSX1(cPerg)
	
	PutSx1(cPerg,"01",OemToAnsi("Data Emissao de")			,"","","mv_ch1","D",08,0,0,"G","","","","","mv_par01","","","","","","","","","","","","","","","","",{},{},{})
	PutSx1(cPerg,"02",OemToAnsi("Data Emissao ate")			,"","","mv_ch2","D",08,0,0,"G","","","","","mv_par02","","","","","","","","","","","","","","","","",{},{},{})
	//PutSx1(cPerg,"03",OemToAnsi("Monitorar")			,"","","mv_ch3","D",08,0,0,"G","","","","","mv_par03","","","","","","","","","","","","","","","","",{},{},{})
	
Return
