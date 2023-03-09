#Define CRLF Chr(13)+Chr(10)
#Include "Rwmake.Ch"
#Include "Protheus.Ch"
#Include "Topconn.Ch"
#Include "Font.Ch"
#Include "Colors.Ch"
#Include "Msole.Ch"



// fUNÇÃO PARA REALIZAR LANÇAMENTO DEBITO E CREDITO
User Function TMPBAIXSE1()
	
	Local A_VET := {}
	Private cLote := ''
AADD(A_VET,{'01PLS000073776', 3740.64})
AADD(A_VET,{'01PLS000074467', 333.31})
AADD(A_VET,{'01PLS000074693', 408.21})
AADD(A_VET,{'01PLS000074697', 864.05})
AADD(A_VET,{'01PLS000074712', 186.5})
AADD(A_VET,{'01PLS000074689', 22.8})
AADD(A_VET,{'01PLS000074725', 31680})
AADD(A_VET,{'01PLS000074738', 13590})
AADD(A_VET,{'01PLS000074744', 7840})
AADD(A_VET,{'01PLS000074751', 3665})
AADD(A_VET,{'01PLS000074764', 1820})
AADD(A_VET,{'01PLS000074776', 2254})
AADD(A_VET,{'01PLS000074792', 1270.4})
AADD(A_VET,{'01PLS000074796', 3374.71})
AADD(A_VET,{'01PLS000074799', 1894.94})
AADD(A_VET,{'01PLS000074833', 12})
AADD(A_VET,{'01PLS000074835', 168.08})
AADD(A_VET,{'01PLS000074837', 30.72})
AADD(A_VET,{'01PLS000074924', 12616.2})

	For nX := 1 To Len(A_VET)
		teste:= ''
		BaixaTitulo(A_VET[nX][1],A_VET[nX][2])
		
	Next nX
	teste := ""
Return

//**************************************************************
// BAIXA TITULO A RECEBER PREVI
//**************************************************************
Static Function BaixaTitulo(cTit,nVlrBaixa)
	
	Local lRet 		:= .T.
	Local cHisBaixa := 'BX FORA DO PERIODO'
	Local cMotBx	:= 'NOR'
	Local dDtBaixa	:= stod('20181120')
	//	Local cLote		:= ''
	
	
	Local aArea 	:= GetArea()
	Local aAreaSE5 	:= SE5->(GetArea())
	Local aAreaSE1	:= SE1->(GetArea())
	
	Private lmsErroAuto := .f.
	Private lmsHelpAuto := .t. // para mostrar os erros na tela
	
	nTpMov := 1
	
	
	
	dbSelectArea("SE1")
	SE1->(dbSetOrder(1))
	If SE1->(MsSeek(cTit+Padl("DP",TamSX3("E1_TIPO")[1])))
		
		//If SE1->E1_SALDO > 0
		//nVlrBaixa := If(nVlrBaixa > SE1->E1_SALDO, SE1->E1_SALDO, m)
		//SA6->(DbSetOrder(1)) //A6_FILIAL+A6_COD+A6_AGENCIA+A6_NUMCON
		//SA6->(MsSeek(xFilial("SA6")+"3416015 017251     "))
		
		aCamposSE5 := {}
		aAdd(aCamposSE5, {"E1_FILIAL"	, xFilial("SE1")	, Nil})
		aAdd(aCamposSE5, {"E1_PREFIXO"	, SE1->E1_PREFIXO	, Nil})
		aAdd(aCamposSE5, {"E1_NUM"		, SE1->E1_NUM			, Nil})
		aAdd(aCamposSE5, {"E1_PARCELA"	, SE1->E1_PARCELA			, Nil})
		aAdd(aCamposSE5, {"E1_TIPO"		, SE1->E1_TIPO				, Nil})
		aAdd(aCamposSE5, {"E1_LOTE"		, SE1->E1_LOTE			, Nil})
		aAdd(aCamposSE5, {"AUTMOTBX"	, cMotBx			, Nil})
		aAdd(aCamposSE5, {"AUTBANCO"	, SE1->E1_PORTADO		, Nil})
		aAdd(aCamposSE5, {"AUTAGENCIA"	, SE1->E1_AGEDEP	, Nil})
		aAdd(aCamposSE5, {"AUTCONTA"	, SE1->E1_CONTA	, Nil})
		
		aAdd(aCamposSE5, {"AUTDTBAIXA"	, dDtBaixa			, Nil})
		aAdd(aCamposSE5, {"AUTDTCREDITO", dDtBaixa			, Nil})
		aAdd(aCamposSE5, {"AUTHIST"		, cHisBaixa			, Nil})
		aAdd(aCamposSE5, {"AUTVALREC"	, nVlrBaixa			, Nil})
		
		msExecAuto({|x,y| Fina070(x,y)}, aCamposSE5, 5)
		//msExecAuto({|x,y| Fina070(x,y)}, aCamposSE5, 3)
		
		If lMsErroAuto
			lRet := .F.
			//	aadd(aErrImp,{"Ocorreu um erro na baixa do titulo "+cPrefixo+" " +cNumero+" "+cParcela+" "+cTipo})
			MostraErro()
			/*SE1->(Reclock("SE1",.F.))
			SE1->E1_YTPEXP	:= "F" // RETORNO RIO PREVIDENCIA - ERRO - TABELA K1
			SE1->E1_YTPEDSC	:= Posicione("SX5", 1, xFilial("SX5")+"K1"+"F", "X5_DESCRI")
			SE1->(MsUnlock())*/
			
		Else
			Conout("Titulo Previ Baixado: "+cTit)
			/*
			SE1->(Reclock("SE1",.F.))
			SE1->E1_YTPEXP	:= "E" // RETORNO RIO PREVIDENCIA - OK - TABELA K1
			SE1->E1_YTPEDSC	:= Posicione("SX5", 1, xFilial("SX5")+"K1"+"E", "X5_DESCRI")
			SE1->(MsUnlock())
			//Informa o lote no movimento totalizador
			If nTpMov == 1
				SE5->(Reclock("SE5",.F.))
				SE5->E5_TIPODOC	:= "BA"
				SE5->E5_LOTE	:= cLote
				SE5->(MsUnlock())
			EndIf
			*/
			//	n_TotBx+= nVlrBaixa
			
			//	lRet := .T.
		EndIf
		//Else
		//		aadd(aErrImp,{"O titulo encontra-se baixado. "+cPrefixo+" " +cNumero+" "+cParcela+" "+cTipo})
		//		EndIf
		
	EndIf
	
	RestArea(aAreaSE1)
	RestArea(aAreaSE5)
	RestArea(aArea)
Return /*lRet*/

// fUNÇÃO PARA REALIZAR LANÇAMENTO DE CONTAS A RECEBER PREVI
User Function TMPAPPSE1()
	
	Local A_VET := {}
	
	AADD(A_VET,{'01PLS003318558',490.59,'000556'})
AADD(A_VET,{'01PLS003318579',490.59,'000390'})
AADD(A_VET,{'01PLS003316882',490.59,'028247'})
AADD(A_VET,{'01PLS003318982',490.59,'000565'})
AADD(A_VET,{'01PLS003317238',490.59,'021567'})
AADD(A_VET,{'01PLS003316767',490.59,'037848'})
AADD(A_VET,{'01PLS003318572',490.59,'000460'})
AADD(A_VET,{'01PLS003318511',490.59,'001196'})
AADD(A_VET,{'01PLS003318577',490.59,'000422'})
AADD(A_VET,{'01PLS003318573',490.59,'000445'})
AADD(A_VET,{'01PLS003317534',490.59,'016013'})
AADD(A_VET,{'01PLS003318608',490.59,'028329'})
AADD(A_VET,{'01PLS003316857',490.59,'139156'})
AADD(A_VET,{'01PLS003318571',490.59,'000470'})
AADD(A_VET,{'01PLS003318568',490.59,'000463'})
AADD(A_VET,{'01PLS003318349',490.59,'003847'})
AADD(A_VET,{'01PLS003318570',490.59,'000467'})
AADD(A_VET,{'01PLS003318504',490.59,'001255'})
AADD(A_VET,{'01PLS003316903',490.59,'027739'})
AADD(A_VET,{'01PLS003316912',490.59,'027580'})
AADD(A_VET,{'01PLS003319002',490.59,'027473'})
AADD(A_VET,{'01PLS003318554',490.59,'000602'})
AADD(A_VET,{'01PLS003316909',490.59,'027630'})
AADD(A_VET,{'01PLS003318578',490.59,'000395'})
AADD(A_VET,{'01PLS003318552',490.59,'000599'})
AADD(A_VET,{'01PLS003318594',490.59,'000204'})
AADD(A_VET,{'01PLS003318523',490.59,'001024'})
AADD(A_VET,{'01PLS003318788',490.59,'043885'})
AADD(A_VET,{'01PLS003318543',490.59,'000700'})
AADD(A_VET,{'01PLS003316881',490.59,'028264'})
AADD(A_VET,{'01PLS003318291',490.59,'004876'})
AADD(A_VET,{'01PLS003318556',490.59,'000578'})
AADD(A_VET,{'01PLS003318503',490.59,'001276'})
AADD(A_VET,{'01PLS003318488',490.59,'001464'})
AADD(A_VET,{'01PLS003318974',490.59,'001135'})
AADD(A_VET,{'01PLS003318594',490.59,'000204'})
AADD(A_VET,{'01PLS003317338',490.59,'020043'})
AADD(A_VET,{'01PLS003318622',490.59,'028580'})
AADD(A_VET,{'01PLS003318477',490.59,'001639'})
AADD(A_VET,{'01PLS003318560',490.59,'000543'})
AADD(A_VET,{'01PLS003318491',490.59,'001451'})
AADD(A_VET,{'01PLS003318533',490.59,'000892'})
AADD(A_VET,{'01PLS003318590',490.59,'000258'})
AADD(A_VET,{'01PLS003318736',490.59,'000334'})
AADD(A_VET,{'01PLS003316933',490.59,'027323'})
AADD(A_VET,{'01PLS003318581',490.59,'000339'})
AADD(A_VET,{'01PLS003318491',490.59,'001451'})
AADD(A_VET,{'01PLS003318546',490.59,'000668'})
AADD(A_VET,{'01PLS003318524',490.59,'140811'})
AADD(A_VET,{'01PLS003318525',490.59,'001006'})
AADD(A_VET,{'01PLS003318772',490.59,'027612'})
AADD(A_VET,{'01PLS003318530',490.59,'000927'})
AADD(A_VET,{'01PLS003316945',490.59,'027089'})
AADD(A_VET,{'01PLS003318527',490.59,'000983'})
AADD(A_VET,{'01PLS003318608',490.59,'028329'})

	
	
	
	For nX := 1 To Len(A_VET)
				IncTitulo(A_VET[nX][1],A_VET[nX][2],A_VET[nX][3])
		
	Next nX
	teste := ""
	
Return

// Inclusão de titulo RAC
Static function IncTitulo(pTitulo,pValor,pCliente)
	
	Local aArea		:= GetArea()
	Local aAreaSE1	:= SE1->(GetArea())
	Local cFil		:= Substr(pTitulo,1,2)
	Local cPrefix	:= substr(pTitulo,3,3)
	Local cNum 		:= substr(pTitulo,6,9)
	Local cParcela  := padr('',tamsx3("E2_PARCELA")[1])
	Local nValor 	:= pValor
	Local cCliente	:= pCliente
	Local cLojaCli 	:= "01"
	Local cHistor	:= "Previ 09.2018"
	Local cAnoBase  := '2018'
	Local cNat		:=	"30"
	
	Private lMsErroAuto	:= .F.
	
	dbSelectArea("SE1")
	SE1->(dbSetOrder(1))
	If SE1->(MsSeek(pTitulo+Padl("DP",TamSX3("E1_TIPO")[1])))
		
		// Criação de títulos provisórios.
		aDadosTit := {}
		aAdd(aDadosTit, {"E1_PREFIXO"	, SE1->E1_PREFIXO	, Nil})
		aAdd(aDadosTit, {"E1_NUM"		, SE1->E1_NUM	, Nil})
		aAdd(aDadosTit, {"E1_PARCELA"	, SE1->E1_PARCELA	, Nil})
		aAdd(aDadosTit, {"E1_TIPO"		, SE1->E1_TIPO	  	, Nil})
		aAdd(aDadosTit, {"E1_NATUREZ"	, SE1->E1_NATUREZ	  	, Nil})
		aAdd(aDadosTit, {"E1_CLIENTE"	, SE1->E1_CLIENTE	, Nil})
		aAdd(aDadosTit, {"E1_LOJA"		, SE1->E1_LOJA	, Nil})
		aAdd(aDadosTit, {"E1_EMISSAO"	, SE1->E1_EMISSAO	, Nil})
		aAdd(aDadosTit, {"E1_VENCTO"	, SE1->E1_VENCTO  	, Nil})
		//aAdd(aDadosTit, {"E1_VALOR"		, nValor  	, Nil})
		aAdd(aDadosTit, {"E1_HIST"		, SE1->E1_HIST	, Nil})
		aAdd(aDadosTit, {"E1_ANOBASE"	, SE1->E1_ANOBASE	, Nil})
		/*aAdd(aDadosTit, {"E1_PREFIXO"	, cPrefix	, Nil})
		aAdd(aDadosTit, {"E1_NUM"		, cNum	, Nil})
		aAdd(aDadosTit, {"E1_PARCELA"	, cParcela	, Nil})
		aAdd(aDadosTit, {"E1_TIPO"		, "DP"	  	, Nil})
		aAdd(aDadosTit, {"E1_NATUREZ"	, cNat	  	, Nil})
		aAdd(aDadosTit, {"E1_CLIENTE"	, cCliente	, Nil})
		aAdd(aDadosTit, {"E1_LOJA"		, cLojaCli	, Nil})
		aAdd(aDadosTit, {"E1_EMISSAO"	, STOD('20180827')	, Nil})
		aAdd(aDadosTit, {"E1_VENCTO"	, STOD('20180827')  	, Nil})
		//aAdd(aDadosTit, {"E1_VALOR"		, nValor  	, Nil})
		aAdd(aDadosTit, {"E1_HIST"		, cHistor	, Nil})
		aAdd(aDadosTit, {"E1_ANOBASE"	, cAnoBase	, Nil})*/
		//	aAdd(aDadosTit, {"E1_MESBASE"	, cMesBase	, Nil})
		
		MsExecAuto({|x,y| Fina040(x,y)},aDadosTit,5)
		
		If lMsErroAuto
			DisarmTransaction()
			MostraErro()
			Return .F.
		Else
			
			Conout("Titulo Previ Incluido: "+pTitulo)
			
		EndIf
	Endif
	
	RestArea(aAreaSE1)
	RestArea(aArea)
	
Return


// compensação de títulos a receber
User FUNCTION COMPCR()
	
	Local lRetOK := .T.
	Local aArea  := GetArea()
	
	Local nTaxaCM := 0
	Local aTxMoeda := {}
	Local aVet := {}
	
	Private nRecnoNDF
	Private nRecnoE1
	
	aadd(aVet,{'01RAC003240309','01PLS003206460'})
	aadd(aVet,{'01RAC003240666','01PLS003206841'})
	aadd(aVet,{'01RAC003240426','01PLS003206581'})
	
	For nX := 1 to len(aVet)
		
		SE1->(dbgotop())
		SE1->(dbSetOrder(1)) // Recebimento Antecipado
		IF SE1->(dbSeek(aVet[nX][1]+Padl("RA",TamSX3("E1_TIPO")[1])))
			
			nRecnoRA := SE1->(recno())
			
			SE1->(dbgotop())
			SE1->(dbSetOrder(1))  // Duplicata
			IF SE1->(dbSeek(aVet[nX][2]+Padl("DP",TamSX3("E1_TIPO")[1])))
				
				nRecnoE1 := SE1->(recno())
				
				PERGUNTE("AFI340",.F.)
				lContabiliza  := MV_PAR11 == 1
				lAglutina   := MV_PAR08 == 1
				lDigita   := MV_PAR09 == 1
				
				nTaxaCM := RecMoeda(dDataBase,SE1->E1_MOEDA)
				
				aAdd(aTxMoeda, {1, 1} )
				
				aAdd(aTxMoeda, {2, nTaxaCM} )
				
				SE1->(dbSetOrder(1)) //E1_FILIAL+E1_PREFIXO+E1_NUM+E1_PARCELA+E1_TIPO+E1_FORNECE+E1_LOJA
				
				aRecRA := { nRecnoRA }
				aRecSE1 := { nRecnoE1 }
				
				If !MaIntBxCR(3,aRecSE1,,aRecRA,,{lContabiliza,lAglutina,lDigita,.F.,.F.,.F.},,,,,dDatabase )
					Help("XAFCMPAD",1,"HELP","XAFCMPAD","Não foi possível a compensação"+CRLF+" do titulo do adiantamento",1,0)
					lRet := .F.
				endif
				
			Endif
		Endif
		
	Next nX
	
	RestArea(aArea)
	
Return lRetOK


User function FilCancela()
	cFiltro := "(E1_NUM='003318558' .AND. E1_CLIENTE='000556') .OR. (E1_NUM='003318579' .AND. E1_CLIENTE='000390') .OR. (E1_NUM='003316882' .AND. E1_CLIENTE='028247') .OR.(E1_NUM='003318982' .AND. E1_CLIENTE='000565') .OR.(E1_NUM='003317238' .AND. E1_CLIENTE='021567') .OR.(E1_NUM='003316767' .AND. E1_CLIENTE='037848') .OR.(E1_NUM='003318572' .AND. E1_CLIENTE='000460') .OR.(E1_NUM='003318511' .AND. E1_CLIENTE='001196') .OR.(E1_NUM='003318577' .AND. E1_CLIENTE='000422') .OR.(E1_NUM='003318573' .AND. E1_CLIENTE='000445') .OR.(E1_NUM='003317534' .AND. E1_CLIENTE='016013') .OR.(E1_NUM='003318608' .AND. E1_CLIENTE='028329') .OR.(E1_NUM='003316857' .AND. E1_CLIENTE='139156') .OR.(E1_NUM='003318571' .AND. E1_CLIENTE='000470') .OR.(E1_NUM='003318568' .AND. E1_CLIENTE='000463') .OR.(E1_NUM='003318349' .AND. E1_CLIENTE='003847') .OR.(E1_NUM='003318570' .AND. E1_CLIENTE='000467') .OR.E1_NUM='003318504' .AND. E1_CLIENTE='001255') .OR.(E1_NUM='003316903' .AND. E1_CLIENTE='027739') .OR.(E1_NUM='003316912' .AND. E1_CLIENTE='027580') .OR.(E1_NUM='003319002' .AND. E1_CLIENTE='027473') .OR. (E1_NUM='003318554' .AND. E1_CLIENTE='000602') .OR.(E1_NUM='003316909' .AND. E1_CLIENTE='027630') .OR.(E1_NUM='003318578' .AND. E1_CLIENTE='000395') .OR.(E1_NUM='003318552' .AND. E1_CLIENTE='000599') .OR.(E1_NUM='003318594' .AND. E1_CLIENTE='000204') .OR.(E1_NUM='003318523' .AND. E1_CLIENTE='001024') .OR.(E1_NUM='003318788' .AND. E1_CLIENTE='043885') .OR.(E1_NUM='003318543' .AND. E1_CLIENTE='000700') .OR.(E1_NUM='003316881' .AND. E1_CLIENTE='028264') .OR.(E1_NUM='003318291' .AND. E1_CLIENTE='004876') .OR.(E1_NUM='003318556' .AND. E1_CLIENTE='000578') .OR.(E1_NUM='003318503' .AND. E1_CLIENTE='001276') .OR.(E1_NUM='003318488' .AND. E1_CLIENTE='001464') .OR.(E1_NUM='003318974' .AND. E1_CLIENTE='001135') .OR.(E1_NUM='003318594' .AND. E1_CLIENTE='000204') .OR.(E1_NUM='003317338' .AND. E1_CLIENTE='020043') .OR.(E1_NUM='003318622' .AND. E1_CLIENTE='028580') .OR.(E1_NUM='003318477' .AND. E1_CLIENTE='001639') .OR.(E1_NUM='003318560' .AND. E1_CLIENTE='000543') .OR.(E1_NUM='003318491' .AND. E1_CLIENTE='001451') .OR.(E1_NUM='003318533' .AND. E1_CLIENTE='000892') .OR.(E1_NUM='003318590' .AND. E1_CLIENTE='000258') .OR.(E1_NUM='003318736' .AND. E1_CLIENTE='000334') .OR.(E1_NUM='003316933' .AND. E1_CLIENTE='027323') .OR.(E1_NUM='003318581' .AND. E1_CLIENTE='000339') .OR.(E1_NUM='003318491' .AND. E1_CLIENTE='001451') .OR.(E1_NUM='003318546' .AND. E1_CLIENTE='000668') .OR.(E1_NUM='003318524' .AND. E1_CLIENTE='140811') .OR.(E1_NUM='003318525' .AND. E1_CLIENTE='001006') .OR.(E1_NUM='003318772' .AND. E1_CLIENTE='027612') .OR.(E1_NUM='003318530' .AND. E1_CLIENTE='000927') .OR.(E1_NUM='003316945' .AND. E1_CLIENTE='027089') .OR.(E1_NUM='003318527' .AND. E1_CLIENTE='000983') .OR. (E1_NUM='003318608' .AND. E1_CLIENTE='028329')"
	
	dbselectarea("SE1")
	Set Filter to cFiltro
	
Return .T. 