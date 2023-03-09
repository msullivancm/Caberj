#include "rwmake.ch"
#include "topconn.ch"


/************************************************************************************
* Rotina..: CABA001          *    Autor:  Carlos Aquino        * Data:  09/08/2005  *
*************************************************************************************
* Objetivo: Geração de Solicitações ao Armazém com Controles Customizados           *
************************************************************************************/

User Function CABA001

	Local aCor := {{"A185BtVe()", "BR_VERMELHO"},;
    	       	   {"A185BtVd()", "BR_VERDE"   }}

	Private _cSolic	  := ""
	Private _cNoSoli  := "" 
	Private cUsuari   := ""
    Private _cCCusto  := ""

	Private cCadastro := "Solic. ao Armazem (CABERJ)"
	Private aRotina := {  {"Pesquisar"     ,"AxPesqui"       ,0,1} ,;
				             {"Visualizar"    ,"U_CABA001A('V')",0,2} ,;
				             {"Incluir"       ,"U_CABA001A('I')",0,3} ,;
				             {"Alterar"       ,"U_CABA001A('A')",0,4} ,;  
				             {"Excluir"       ,"U_CABA001A('E')",0,5} ,;
				             {"Legenda","U_CABALegenda", 0 , 2}}
				             //{"Atlz.Contenção","U_CABA001B"     ,0,4} ,;
				             				
	Private cDelFunc := ".T." // Validacao para a exclusao. Pode-se utilizar ExecBlock

	cUsuari   := PADR(SubStr(cUsuario,7,15),15)
	
// WRC - O Centro de custo deixou de ser o do usuário e passou a ser do solicitante
//	_cCCusto  := BuscaCC(cUsuari)
    _cCCusto  := CriaVar("D3_CC",.F.) // WRC em 29-03-06
    
//	cFiltro   := "CP_CC == '+_cCCusto+'"
	cString := "SCP"
	dbSelectArea("SCP")
	mBrowse( 6,1,22,75,"SCP",,"CP_PREREQU")
	
return

/************************************************************************************
* Rotina..: CABALegenda      *    Autor:  Carlos Aquino        * Data:  09/08/2005  *
*************************************************************************************
* Objetivo: Cria uma janela contendo a legenda da mBrowse                           *
************************************************************************************/
User Function CABALegenda()
	BrwLegenda(cCadastro,"Legenda",{{"DISABLE","Pre-Requisicao Gerada" },; 
		                            {"ENABLE","Gerar Pre-Requisicao"   }})
Return .T.                           


/************************************************************************************
* Rotina..: CABA001A         *    Autor:  Carlos Aquino        * Data:  09/08/2005  *
*************************************************************************************
* Objetivo: Montagem da Tela de Solicitação de Compras com Controles Customizados   *
************************************************************************************/

User Function CABA001A(cTpAtlz)                                                    

	Local cTitulo := OemToAnsi("Solicit.ao Armazem (CABERJ)")

	Private _nOpc  := 0
	//Private lAlter := IIF(cTpAtlz <> 'I', .T., .F.)
	//Private lExclu := IIF(cTpAtlz == 'E', .T., .F.)

	Private oDlg, oGet
	Private cAlias := "SCP"
	Private cTabSol := "USR"

	_cSolic	  := SPACE(15)
	_cNoSoli  := SPACE(15)
	cUsuari   := PADR(SubStr(cUsuario,7,15),15)                                    
	
// WRC - O Centro de custo deixou de ser o do usuário e passou a ser do solicitante	
//  _cCCusto  := CRIAVAR("RA_CC") 
//	_cCCusto := BuscaCC(cUsuari)
	
	Do Case
		Case cTpAtlz = 'V'
			_nOpc := 2				// Inclusao
		Case cTpAtlz = 'I'
			_nOpc := 3				// Inclusao
		Case cTpAtlz = 'A'
			_nOpc := 4				// Alteracao
		Case cTpAtlz = 'E'
			_nOpc := 5				// Exclusao
	End Case
	
	if _nOpc = 3
		Private _cNumSoli	:= CRIAVAR("CP_NUM",.t.)
   		Private dDataSoli := dDataBase
   		//_cNumSoli := GetSx8Num("SCP","CP_NUM") // NumSolArm() "Alterado por Fabiano Von Held - gravar codigo da SC de acordo com rotina padrão"
	else  //if _nOpc >=4	
		Private _cNumSoli	:= SCP->CP_NUM
		Private dDataSoli := SCP->CP_EMISSAO
        /*
		if SCP->CP_CC != _cCCusto .and. _nopc <> 2
			Alert("Usuario não pode alterar Solicitação de outro Centro de Custo.")
			Return .T.                            			
		endif                                     
		*/
   Endif
   
   	Private CA105NUM  	:= _cNumSoli  
   	Private CA105FILIAl	:= xFilial("SCP") // Incluido por Marcela Coimbra - Data: 03/03/10
  	Private aHeader   	:= {}
    Private aCols     	:= {}
    Private lGravou 	:= .F.
    
	/*-----------*/
	
	dbSelectArea("SCP")
	dbSetOrder(1)	
	
//	_cNumSoli := IIF(Empty(_cNumSoli),NextNumero("SCP",1,"CP_NUM",.T.),_cNumSoli)
//	_cNumSoli := IIF(Empty(_cNumSoli),GetSX8Num("SCP","CP_NUM"),_cNumSoli)
	
	MontaMulti(_nOpc)
   
	DEFINE MSDIALOG oDlg TITLE cTitulo FROM 0,0 to 30,103
	@ 005, 005 SAY   "&Numero"
	@ 005, 030 GET _cNumSoli Picture PesqPict("SCP","CP_NUM")  SIZE 40,12 When .f. // // WRC - 08/03/06 - When _nOpc=3
	@ 005, 080 SAY   "&Solicitante" 
	@ 005, 110 GET _cSolic F3 cTabSol Picture "@S10" VALID BuscaNUser(_cSolic) .or. .t. SIZE 50,12 When IIF(_nOpc=2 .or. _nOpc=5,.F.,.T.)
	@ 016, 080 SAY   "Nome Solic."
	@ 016, 110 GET _cNoSoli SIZE 50,12 When .F.
	@ 005, 165 SAY   "&Centro de Custo" 
	@ 005, 215 GET _cCCusto Picture PesqPict("SRA","RA_CC") SIZE 50,12 When .F. 
	@ 016, 165 SAY   "&Usuario" 
	@ 016, 215 GET cUsuari Picture "@S10" SIZE 50,12 When .F. 
	@ 005, 270 SAY   "&Data de Emissao" 
	@ 005, 315 GET dDataSoli Valid NaoVazio() When .F. 
	If _nOpc = 3 
		@ 005, 350 BUTTON "Carregar Produtos" SIZE 50,12 ACTION BuscaProd()
	endif
//	@ 030, 005 TO 200,400 MULTILINE MODIFY DELETE VALID U_A105LINOK() object oGet
	oGet := MSGetDados():New(030,005,200,400,_nopc,"U_A105LinOK","U_A105TudOK","+CP_ITEM",.T.,PermitEdit())	
	if _nOpc = 3
		@ 205, 290 BUTTON "Incluir" SIZE 50,12 Action MExecAuto(3)
	elseif _nOpc = 4
		@ 205, 290 BUTTON "Alterar" SIZE 50,12 Action MExecAuto(4)
	elseif _nOpc = 5 
		DbSelectArea("SCP")
		DbSetOrder(1)
		DbSeek(xFilial("SCP")+_cNumSoli)
		_cNoSoli := SCP->CP_SOLICIT
		_cSolic := BuscaNUser(,_cNoSoli)
		@ 205, 290 BUTTON "Excluir" SIZE 50,12 Action MExecAuto(5)
	endif
	@ 205, 350 BUTTON "Sair" SIZE 50,12 Action Sair()

	ACTIVATE DIALOG oDlg CENTER

	If (!lGravou) .and. _nOpc = 3	   
	   RollbackSX8()             
//	   EvalTrigger()
//	   DbCommitAll()
	Endif   
	
	dbSelectArea("SCP")
	SET FILTER TO 
	dbSetOrder(1)
	
Return

Static Function Sair()

Close(odlg)

Return

/************************************************************************************
* Funcao..: MontaMulti       *    Autor:  Carlos Aquino        * Data:  09/08/2005  *
*************************************************************************************
* Objetivo: Montagem do Multiline                                                   *
************************************************************************************/

Static Function MontaMulti(nNumOpc)
Local aArea    := GetArea()
Local nUsado   := 0
Local cX3Usado := ""

Local nCntFor := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS
   
	nNumOpc := IIF(ValType(nNumOpc)<>"N",3,nNumOpc)

	dbSelectArea("SX3")
	dbSetOrder(1)
	dbSeek( cAlias )
	While ( !EOF() .And. SX3->X3_ARQUIVO == cAlias )
		If ( X3USO(SX3->X3_USADO) .AND. cNivel >= SX3->X3_NIVEL .And.;
			AllTrim(SX3->X3_CAMPO) != "CP_NUM" )
			if AllTrim(SX3->X3_CAMPO) = "CP_PROJETO" 
				dbSelectArea("SX3")
			  `	dbSkip()
				Loop
			endif
		
			nUsado++
			//AADD(aHeader,{ AllTrim(X3Titulo()),SX3->X3_CAMPO,SX3->X3_PICTURE,SX3->X3_TAMANHO,SX3->X3_DECIMAL,;
			//               " ",SX3->X3_USADO,SX3->X3_TIPO,SX3->X3_ARQUIVO,SX3->X3_CONTEXT} )
			AADD(aHeader,{ AllTrim(X3Titulo()),SX3->X3_CAMPO,SX3->X3_PICTURE,SX3->X3_TAMANHO,SX3->X3_DECIMAL,;
			               SX3->X3_VALID,SX3->X3_USADO,SX3->X3_TIPO,SX3->X3_ARQUIVO,SX3->X3_CONTEXT} )
		EndIf
		dbSelectArea("SX3")
		dbSkip()
	EndDo
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Montagem do aCols                                             ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	if nNumOpc = 3
		aadd(aCols,Array(len(aHeader)+1))
		For nCntFor := 1 To len(aHeader)
			aCols[1][nCntFor] := CriaVar(aHeader[nCntFor][2],.T.)
			If ( AllTrim(aHeader[nCntFor][2]) == "CP_ITEM" )
				aCols[1][nCntFor] := "01"
			EndIf
		Next nCntFor
		aCOLS[1][len(aHeader)+1] := .F.	
	else
		// Se For Alteração Entra Aqui.
		DbSelectArea("SCP")
		DbSetOrder(1)
		DbSeek(xFilial("SCP")+_cNumSoli)
		While !Eof() .and. CP_FILIAL = xFilial("SCP") .and. CP_NUM = _cNumSoli
			if nNumOpc = 4 .and. CP_PREREQU <> ' '
				DbSelectArea("SCP")
				DbSkip()
				Loop
			endif
			aadd(aCols,Array(len(aHeader)+1))
			For nCntFor := 1 To len(aHeader)
					aCols[Len(aCols)][nCntFor] := &("SCP->"+aHeader[nCntFor][2])
			Next nCntFor
			aCOLS[Len(aCols)][len(aHeader)+1] := .F.
			DbSelectArea("SCP")
			DbSkip()
		Enddo
	endif
	RestArea(aArea)	
Return


/************************************************************************************
* Rotina..: BuscaCC          *    Autor:  Carlos Aquino        * Data:  09/08/2005  *
*************************************************************************************
* Objetivo: Retorna o Centro de Custo do Usuario informado pelo parametro           *
************************************************************************************/

Static Function BuscaCC(_cUsuario)
	Local aArea := GetArea()
	Local cRet := ""
   Local cMat := ""

   if !Empty(_cUsuario)
		PswOrder(2)
		PswSeek( _cUsuario, .T. )
      cMat := PSWRet(1)[1][22]
		If !Empty(AllTrim(cMat))
			DbSelectArea("SRA")
			DbSetOrder(1)
			DbSeek(substr(cMat,3,Len(cMat)-2)) //xFilial("SRA")
			if Found()
				cRet := SRA->RA_CC
			else
				cRet := CRIAVAR("RA_CC",.T.) 			
			endif
			//DbCloseArea()
		Endif
		if Empty(Alltrim(cRet))
			cRet :=  CRIAVAR("RA_CC",.T.)
		endif
	endif
	RestArea(aArea)
return (cRet)


/************************************************************************************
* Funcao..: BuscaNUser       *    Autor:  Carlos Aquino        * Data:  09/08/2005  *
*************************************************************************************
* Objetivo: Retorna verdadeiro se o Solicitante for encontrado, atualiza o nome do  *
*         : solicitante.                                                            *
************************************************************************************/
Static Function BuscaNUser(_cUsuario,_cCodUsua)
	Local aArea := GetArea()
	Local aDUsu := {}
    Local lRet  := .F.
   _cUsuario := IIF(ValType(_cUsuario)<>"C","",_cUsuario)   
   _cCodUsua := IIF(ValType(_cCodUsua)<>"C","",_cCodUsua)
   
   if !Empty(_cUsuario)
		PswOrder(1)
		If PswSeek( _cUsuario, .T. )
		  aDUsu := PswRet(1)
		  _cNoSoli := aDUsu[1][2]  		// Nome do Solicitante
		  lRet := .T.     
		  // WRC - O Centro de custo deixou de ser o do usuário e passou a ser do solicitante
		  _cCCusto := BuscaCC(_cNoSoli) // WRC em 29-03-06
		EndIf
	endif
	if !Empty(_cCodUsua)
		PswOrder(2)
		If PswSeek( _cCodUsua, .T. )
		  aDUsu := PswRet(1)
		  lRet := aDUsu[1][1]  		// Codigo do Usuario
		EndIf
	Endif
   RestArea(aArea)
Return (lRet)


/************************************************************************************
* Funcao..: BuscaProd        *    Autor:  Carlos Aquino        * Data:  09/08/2005  *
*************************************************************************************
* Objetivo: Retorna uma lista de produtos de acordo com o centro de custo informado *
************************************************************************************/
Static Function BuscaProd()
	Local aArea    := GetArea()
	Local _nConta  := 0

	Local _cCeCusto:= _cCCusto
	Local _dData   := dDataSoli
	Local _nUsado  := Len(aHeader)+1
	Local cDataFim := Substr(DtoS(_dData),1,4)+StrZero(Val(SubStr(DtoS(_dData),5,2)),2)
	Local cDataIni := Str(Val(cDataFim)-3,6)
	Local cQuery   := ""
	Local aDados   := {}
	Local lRet     := .T.
	Local i        := 0
	Local nSaldo   := 0

	If Select("XCP") > 0
		DbSelectArea("XCP")
		DbCloseArea()
	Endif

	cQuery := "Select CP_NUM QUANT from "+RetSqlName("SCP")
	cQuery += " where CP_CC  = '"+_cCeCusto+"'"
	cQuery += " AND SubStr(CP_EMISSAO,1,6) = '"+Substr(DtoS(dDataSoli),1,6)+"'"		// 	cQuery += " AND SubString(CP_DATPRF,1,6) = '"+Substr(DtoS(dDataSoli),1,6)+"'"
	cQuery += " AND CP_FILIAL = '"+xFilial("SCP")+"'"
	cQuery += " AND D_E_L_E_T_ <> '*'
	cQuery += " GROUP BY CP_NUM "
	
	If TcSqlExec(cQuery) < 0
		TcSqlError()
	Endif
	
	TCQUERY cQuery Alias XCP NEW

	DbSelectArea("XCP")
	DbGoTop()
	While !Eof()
		_nConta++
		dbSkip()
	Enddo
	
	if _nConta > 1
	
		Alert("Já existem duas solicitações para este Centro de Custo no mês solicitado.")
		Return
		
	endif
	/*If Select("XCP") > 0
		DbSelectArea("XCP")
		DbCloseArea()
	Endif*/
 

	/* Validações Iniciais */
	if Empty(Alltrim(_cNumSoli)) .or. Empty(Alltrim(_cSolic)) .or.;
		Empty(Alltrim(_cNoSoli))  .or. Empty(Alltrim(_cCCusto)) .or.;
		Empty(AllTrim(DtoS(dDataSoli)))

		Alert("Dados do cabeçalho incompletos. Antes de prosseguir preencha as informações faltantes.")
		return
	endif
	/* ------------------- */ 

	If Select("TD3") > 0
		DbSelectArea("TD3")
		DbCloseArea()
	Endif
	
	cQuery := "Select D3_COD from "+RetSqlName("SD3")
	cQuery += " where D3_CC  = '"+_cCeCusto+"'"
	cQuery += " AND D3_EMISSAO >= '"+cDataIni+"' AND D3_EMISSAO < '"+cDataFim+"'"
	cQuery += " AND SubStr(D3_CF,1,1) = 'R'" 									// 	cQuery += " AND SubString(D3_CF,1,1) = 'R'" 
	cQuery += " AND D3_FILIAL = '"+xFilial("SD3")+"'"
	cQuery += " AND D3_ESTORNO <> 'S'
	cQuery += " AND D_E_L_E_T_ <> '*'
	cQuery += " GROUP BY D3_COD "
	cQuery += " ORDER BY D3_COD "
	
	If TcSqlExec(cQuery) < 0
		TcSqlError()
	Endif
	
	TCQUERY cQuery Alias TD3 NEW

	DbSelectArea("TD3")
	DbGoTop()

	aDados := {}
	aProdutos := {}

	While !Eof()
	   cProdu := TD3->D3_COD
		nSaldo := BusQtdSug(_cCeCusto, cProdu, _dData)
		if nSaldo > 0
			aAdd( aDados, { cProdu, nSaldo } )
			//aAdd( aProdutos, cProdu )
		endif
		DbSelectArea("TD3")		
		dbSkip()
	Enddo

   if Len(aDados) > 0
		   aCols := {}
			cItem := "00"
			For i := 1 to Len(aDados)
				cItem := Soma1(cItem)
				aadd(aCols,Array(_nUsado))
	            n := i 
				aCOLS[n][_nUsado] := .F.
				DbSelectArea("SB1")						// Procura Informações sobre o Produto
				DbSetOrder(1)
				DbSeek(xFilial("SB1")+aDados[i][1])
				if Found()
					U_AtlzMultili(1, aDados[i], cItem)
				endif					
				//DbCloseArea()
			Next i
    else
    	Aviso("Carregar Produtos","Nenhum produto a ser carregado.",{"OK"})
	Endif
	n := 1

	/*If Select("TD3") > 0
		DbSelectArea("TD3")
		DbCloseArea()
	Endif*/
		
   RestArea(aArea)
Return (lRet)

/************************************************************************************
* Funcao..: AtlzMultili    *    Autor:  Carlos Aquino        * Data:  15/08/2005  *
*************************************************************************************
* Objetivo: Atualiza o item da Multiline                                            *
************************************************************************************/
User Function AtlzMultili(_nOpc, aDados, cItem, lProduto)
	Local aArea     := GetArea()
	Local nX        := 0
	Local _cProduto := ""
	Local cRet      := cItem  
	_nOpc   := IIF(Valtype(_nOpc) <> "N" , 0   , _nOpc )
	aDados  := IIF(Valtype(aDados) <> "A", {}  , aDados)	
	cItem   := IIF(ValType(cItem) <> "C" , "01", cItem )
	lProduto:= IIF(ValType(lProduto) <> "B", .F., lProduto)
    
	//Alert(FunName())

	DbSelectArea("SB1")	
	if lProduto .And. Empty(aDados)
		_cProduto := aCols[n][aScan(aHeader,{|x| AllTrim(x[2])=="CP_PRODUTO"})]
		if !Empty(Alltrim(_cProduto))
			DbSeek(xFilial("SB1")+_cProduto)
		else
			Alert("Informe o código do produto.")
			return(.T.)
		endif
	endif
	For nX := 1 To Len(aHeader)
		if !Empty(aCols[n][nX])
			Loop
		Endif
		Do Case
			Case Trim(aHeader[nX][2]) == "CP_UM"			// Unidade Medida
				aCols[n][nX] := SB1->B1_UM
			Case Trim(aHeader[nX][2]) == "CP_LOCAL"		// Almoxarifado
				aCols[n][nX] := SB1->B1_LOCPAD
			Case Trim(aHeader[nX][2]) == "CP_CC"			// Centro Custo  << ---  Verificar
				//aCols[n][nX] := SB1->B1_CC
				aCols[n][nX] := _cCCusto
			Case Trim(aHeader[nX][2]) == "CP_CONTA"		// Conta Contabil
				aCols[n][nX] := SB1->B1_CONTA
			Case Trim(aHeader[nX][2]) == "CP_DESCRI"		// Descricao
				aCols[n][nX] := SB1->B1_DESC
			Case Trim(aHeader[nX][2]) == "CP_SEGUM"		// Segunda Unidade Medida
				aCols[n][nX] := SB1->B1_SEGUM
				//A100SegUm()   																		// <---- Verificar
			Case Trim(aHeader[nX][2]) == "CP_ITEMCTA"		//Item da Conta Contabil
				aCols[n][nX] := SB1->B1_ITEMCC
			Case Trim(aHeader[nX][2]) == "CP_CLVL"   		//Classe do Valor Contabil
				aCols[n][nX] := SB1->B1_CLVL
			Case Trim(aHeader[nX][2]) == "CP_ITEM"
				if _nOpc <> 0 
					aCols[n][nX] := cItem
				endif
			Case Trim(aHeader[nX][2]) == "CP_PRODUTO"		//Item da Conta Contabil
				if !Empty(aDados)
					aCols[n][nX] := aDados[1]
				endif
			Case Trim(aHeader[nX][2]) == "CP_XQUANT"   		//Classe do Valor Contabil
				if !Empty(aDados)			
					aCols[n][nX] := aDados[2]
				endif				
			OTHERWISE
				if _nOpc <> 0
					aCols[n][nX] := CriaVar(aHeader[nX][2],.T.)
				endif
		EndCase
	Next nX
	RestArea(aArea)
Return cRet

/************************************************************************************
* Funcao..: BusQtdSug        *    Autor:  Carlos Aquino        * Data:  09/08/2005  *
*************************************************************************************
* Objetivo: Retorna a Quantidade Sugerida para determinado produto                  *
************************************************************************************/
Static Function BusQtdSug(_cCeCusto, _cProduto,_dData)
	Local aArea    := GetArea()
	Local cDataFim := Substr(DtoS(_dData),1,4)+StrZero(Val(SubStr(DtoS(_dData),5,2)),2)
	Local cDataIni := Str(Val(cDataFim)-3,6)
	Local cQuery   := ""
	Local aDados   := {}
	Local nRet     := 0
	Local nCont    := 0
	Local i        := 0
	Local lGrav    := .T.
	Local lCalcula := .T.
	Local sdJaPedi := 0
	
	If Select("XD3") > 0
		DbSelectArea("XD3")
		DbCloseArea()
	Endif
	
	cQuery := "Select D3_COD, SubStr(D3_EMISSAO,1,6) D3_EMISSAO, SUM(D3_QUANT) D3_QUANT from "+RetSqlName("SD3")		// 	cQuery := "Select D3_COD, SubString(D3_EMISSAO,1,6) D3_EMISSAO, SUM(D3_QUANT) D3_QUANT from "+RetSqlName("SD3")
	cQuery += " where D3_COD = '"+_cProduto+"'"
	cQuery += " AND   D3_CC  = '"+_cCeCusto+"'"
	cQuery += " AND D3_EMISSAO >= '"+cDataIni+"' AND D3_EMISSAO <= '"+cDataFim+"'"
	cQuery += " AND SubStr(D3_CF,1,1) = 'R'" 											// 	cQuery += " AND SubString(D3_CF,1,1) = 'R'" 
	cQuery += " AND D3_FILIAL = '"+xFilial("SD3")+"'"
	cQuery += " AND D3_ESTORNO <> 'S'
	cQuery += " AND D_E_L_E_T_ <> '*'
	cQuery += " GROUP BY D3_EMISSAO, D3_COD "
	cQuery += " ORDER BY D3_EMISSAO "
	
	If TcSqlExec(cQuery) < 0
		TcSqlError()
	Endif
	
	TCQUERY cQuery Alias XD3 NEW

	DbSelectArea("XD3")
	DbGoTop()

	aDados := {}

	While !Eof()
		if Len(aDados) = 0
			aAdd( aDados, { XD3->D3_EMISSAO, XD3->D3_QUANT } )
		else
			lGrav    := .T.
			For i := 1 to Len(aDados)
				if aDados[i][1] = XD3->D3_EMISSAO
					aDados[i][2] += XD3->D3_QUANT
					lGrav    := .F.
				endif
			Next i
			if lGrav
				aAdd( aDados, { XD3->D3_EMISSAO, XD3->D3_QUANT } )
			endif
		endif
		dbSkip()
	Enddo
	
	//DbCloseArea()	// XD3
	
	if Len(aDados) <> 3
		lCalcula := .F.
	endif
	
	if lCalcula
		nRet += aDados[1][2] + aDados[2][2] + aDados[3][2]			// Soma a Quantidade Pedida por Mes.
		
		nRet := Int(nRet / 3)	 									// Calcula a Media do Produto.
		
		if nRet > aDados[3][2]										// Se o Valor do Ultimo mês for menor
			nRet := aDados[3][2]									// ele passa a ser o valor sugerido.
		endif				
      
		DbSelectArea("SB1")											// Busca o Indice de Contencao para aquele produto
		DbSetOrder(1)
		DbSeek(xFilial("SB1")+_cProduto)
		if Found()
			nCont := SB1->B1_XCONT
		else
			nCont := 0
		endif
		if nCont <> 0 .and. nRet > 1									//  <-- Verificar
			nRet := Int(nRet - (nRet * nCont/100))						// Aplica o Indice de Contenção
		endif
		        
		if GETMV("MV_XCONTSA") == "S"									// Se for S, considera solicitacao
			sdJaPedi := BuscaSlSolic(_cCeCusto, _cProduto,_dData)       // anterior.  
			//if (nRet - sdJaPedi) > 1
				nRet -= sdJaPedi
			//endif
		endif	
		
	endif

	/*If Select("XD3") > 0
		DbSelectArea("XD3")
		DbCloseArea()
	Endif*/
	
   RestArea(aArea)
Return (nRet)

/************************************************************************************
* Funcao..: A105Numero       *    Autor:  Carlos Aquino        * Data:  09/08/2005  *
*************************************************************************************
* Objetivo: Retorna a Quantidade Sugerida para determinado produto                  *
************************************************************************************/
Static Function A105Numero()
	Local lRetorna	:= .T.
	Local aArea		:= GetArea()
	If ( Empty(_cNumSoli) )
		Help(" ",1,"VAZIO")
		lRetorna := .F.
	Else
		dbSelectArea("SCP")
		dbSetOrder(1)
		If ( dbSeek(xFilial("SCP")+_cNumSoli) )
			Help(" ",1,"A10501")
			lRetorna := .F.
		EndIf
	EndIf
	RestArea(aArea)
Return( lRetorna )

/************************************************************************************
* Funcao..: A105LinOk        *    Autor:  Carlos Aquino        * Data:  09/08/2005  *
*************************************************************************************
* Objetivo: Validação da Linha Ok                                                   *
* Retorno.: ExpL1: .T. se valido                                                    *
************************************************************************************/
User Function A105LinOk(o)
	Local lRet		:= .T.
	U_AtlzMultili(,,,.T.)
Return( lRet )

/************************************************************************************
* Funcao..: A105TudOk        *    Autor:  Carlos Aquino        * Data:  09/08/2005  *
*************************************************************************************
* Objetivo: Validação de todo o GetDados                                            *
* Retorno.: ExpL1: .T. se valido                                                    *
************************************************************************************/
User Function A105TudOK()

Return .T.

/************************************************************************************
* Funcao..: PermitEdit       *    Autor:  Carlos Aquino        * Data:  11/08/2005  *
*************************************************************************************
* Objetivo: Rotina Responsavel pela montagem dos campos que podem ser alterados no  *
*         : aHeader.                                                                *
************************************************************************************/
Static Function PermitEdit
	Local aRet := {}
	Local i := 1
	
	For i := 1 to Len(aHeader)
		if Trim(aHeader[i][2]) != "CP_XQUANT"
			aAdd(aRet, aHeader[i][2])
		endif	
	Next i	
Return aRet

/************************************************************************************
* Funcao..: MExecAuto        *    Autor:  Carlos Aquino        * Data:  11/08/2005  *
*************************************************************************************
* Objetivo: Rotina Responsavel pela montagem do MsExecAuto para Mata105             *
************************************************************************************/
Static Function MExecAuto(_xOpc)
	Local aArea := GetArea()
	Local _lTZera:= .F.
	Local aCab  := {}
	Local aItens:= {}
	Local aTMPIt:= {}
	Local i     := 0
	Local j     := 0
	Local senhas:= .F., pwdReq := .F.
    Local lApagar:=.F.
    Local _cCont  := "00"
    Local xAutorizador := SPACE(15)
	_xOpc := IIF(ValType(_xOpc)<>"N",3,_xOpc)
	        
	PRIVATE lMSHelpAuto := .f. // para nao mostrar os erro na tela
	PRIVATE lMSErroAuto := .f. // inicializa como falso, se voltar verdadeiro e' que deu erro

	/* Validações Iniciais */
	if (Empty(Alltrim(_cNumSoli)) .or. Empty(Alltrim(_cSolic)) .or.;
		Empty(Alltrim(_cNoSoli))  .or. Empty(Alltrim(_cCCusto)) .or.;
		Empty(AllTrim(DtoS(dDataSoli)))) .and. _xOpc <> 5
	
		Alert("Dados do cabeçalho incompletos. Antes de prosseguir preencha as informações faltantes.")
		return .T.
	endif
	/* ------------------- */ 

	/*Incluir aqui verificações sobre senhas de autorização para inclusão de SA */

	aCab := {{"CP_NUM"     , _cNumSoli, NIL},;
			 {"CP_SOLICIT" , AllTrim(_cNoSoli), NIL},;
			 {"CP_EMISSAO" , dDataSoli, NIL}}
	
	if _xOpc <> 5 
		For i := 1 to Len(aCols)
			aTMPIt :={}
			if aCols[i][Len(aCols[i])] = .T.				//	Verifica se o ítem foi apagado.
				Loop
			endif
	
			// Verifica se o item está com quantidade zerada.
			if aCols[i][aScan(aHeader,{|x| AllTrim(x[2])=="CP_QUANT"})] = 0
				_lTZera := .T.                                                  // utilizacao futura.
				Alert("Há ítem com valor zerado. Por favor, verifique.")
				RestArea(aArea)
				Return(.F.)
			endif		
			
			// Verifica se a Quantidade Informada é maior que a qtd. Sugerida
			if aCols[i][aScan(aHeader,{|x| AllTrim(x[2])=="CP_QUANT"})] > aCols[i][aScan(aHeader,{|x| AllTrim(x[2])=="CP_XQUANT"})]
				Senhas := .T.
			endif		
			
			_cCont := Soma1(_cCont)			
			
			For j := 1 to Len(aCols[i])-1
				if AllTrim(aHeader[j][2]) == "CP_CC"
					aAdd ( aTMPIt , { aHeader[j][2] , _cCCusto , NIL} )
					Loop
				elseif AllTrim(aHeader[j][2]) == "CP_ITEM" .and. _xOpc = 3
					aAdd ( aTMPIt , { aHeader[j][2] , _cCont , NIL} )
					Loop
				endif

				aAdd ( aTMPIt , { aHeader[j][2] , aCols[i][j] , NIL} )

			Next j
			aAdd ( aItens , aClone(aTMPIt) )
		Next i
		
		if Len(aItens) = 0 .and. _xOpc = 3
			Alert("Não existe item a ser incluido por esta solicitação."+CHR(13)+"Verifique a quantidade informada.")
			Return
		endif

		/*if _xOpc = 4
			    i := "01"
				While Val(i) <= Len(aItens)
				
					DbSelectArea("SCP")
					DbSetOrder(2)
					DbSeek(xFilial("SCP")+_cNumSoli+i)
					if 
					aItens[i][aScan(aItens[i],{|x| AllTrim(x[1])=="CP_ITEM"})][1] := StrZero(i,2)
					
				Next i
		endif*/
		
		if Senhas .and. _xOpc <> 5
			Senhas := .F.
			pwdReq := SenhaSol(@xAutorizador)
			if pwdReq
				Senhas := .F.
			else
				Senhas := .T.
			endif
		endif
	endif
			
	if !Senhas .or. _xOpc = 5
		DbSelectArea("SCP")
		DbSetOrder(1)
		DbSeek(xFilial("SCP")+_cNumSoli)
		if _xOpc = 3												// Inclusao
			if !Found() 

				if CABA001GRV(1,_cNumSoli,dDataSoli,AllTrim(_cNoSoli),xAutorizador, pwdReq)
					Aviso("Sucesso","Solicitação gravada com Sucesso!",{"OK"})			
					Close(odlg)
				else
					Aviso("Erro","Solicitaçao não Incluida.",{"OK"})
				endif

				/*MsExecAuto
				
				MSExecAuto({|x,z,y| MATA105(x,z,y)},aCab,aItens,3)
				
				if lMSErroAuto
					MostraErro()
					lMSErroAuto := .F.
				else
					// ExecAuto da Rotina não inclui CP_SOLICIT
					DbSelectArea("SCP")
					DbSetOrder(1)
					DbSeek(xFilial("SCP")+_cNumSoli)
					While !Eof() .and. CP_FILIAL = xFilial("SCP") .and. CP_NUM = _cNumSoli
						if SCP->CP_PREREQU = ' '
							RecLock("SCP",.F.)
							SCP->CP_SOLICIT := _cNoSoli
							MsUnlock()
						endif	
						DbSkip()
					Enddo
					Aviso("Sucesso","Solicitação gravada com Sucesso!",{"OK"})			
					Sair()				
				endif*/
				
			else
				Alert("Já existe uma Solicitação com esta numeração.")
			endif
		elseif _xOpc = 4                             	// Alteracao
				DbSelectArea("SCP")
				DbSetOrder(1)
				DbSeek(xFilial("SCP")+_cNumSoli)
				
				if CABA001GRV(2,_cNumSoli,dDataSoli,AllTrim(_cNoSoli),xAutorizador, pwdReq)
					Aviso("Sucesso","Solicitação alterada com Sucesso!",{"OK"})			
					Close(odlg)
				else
					Aviso("Erro","Solicitaçao não alterada.",{"OK"})
				endif
				
				/*While !Eof() .and. CP_FILIAL = xFilial("SCP") .and. CP_NUM = _cNumSoli
					if SCP->CP_PREREQU = ' '
						RecLock("SCP",.F.)
						DbDelete()
						MsUnlock()
					endif	
					DbSkip()
				Enddo
				MSExecAuto({|x,z,y| MATA105(x,z,y)},aCab,aItens,3)
				if lMSErroAuto
					MostraErro()
					lMSErroAuto := .F.
				else
					
				endif*/
		elseif _xOpc = 5                             	// Exclusao
				lApagar := .T.
				DbSetOrder(1)
				DbSeek(xFilial("SCP")+_cNumSoli)
				While !Eof() .and. CP_FILIAL = xFilial("SCP") .and. CP_NUM = _cNumSoli
					if SCP->CP_PREREQU <> ' '
						lApagar := .F.
					endif
					DbSkip()
				Enddo
				if lApagar
					DbSelectArea("SCP")
					DbSetOrder(1)
					DbSeek(xFilial("SCP")+_cNumSoli)
					While !Eof() .and. CP_FILIAL = xFilial("SCP") .and. CP_NUM = _cNumSoli
						RecLock("SCP",.F.)
						DbDelete()
						MsUnlock()
						DbSkip()
					Enddo
					Aviso("Sucesso","Solicitação Excluida com Sucesso!",{"OK"})			
					Close(odlg)				
				else
					Aviso("Erro","Existe Pre-Requisisao para item da Solicitacao."+CHR(13)+"A Solicitacao nao pode ser apagada",{"OK"})
				endif
		endif
	endif		
	RestArea(aArea)
Return

/************************************************************************************
* Funcao..: SenhaSol         *    Autor:  Carlos Aquino        * Data:  11/08/2005  *
*************************************************************************************
* Objetivo: Janela para digitação da senha do solicitante caso necessário.          *
************************************************************************************/
Static Function SenhaSol(_xAutoriz)
	Local aArea := GetArea()
	LOCAL aUsu := {}, cUsuAut := "", lRet := .F., nOpc := 0, _cUsu, _cSenha
	
	_xAutoriz := IIF(Empty(_xAutoriz),SPACE(15),_xAutoriz)

	@ 248,264 To 430,520 Dialog oDlg2 Title OemToAnsi("Informar Usuário/Senha Solicitante")
	@ 02,02 To  67,127
	
	_cUsu:=PADR(_cNoSoli,15)
	_cSenha := SPACE(20)
	
	@ 05,08 Say OemToAnsi("Existe ítem com quantidade requisitada superior à quantidade sugerida.") Size 106,20
	
	@ 28,08 Say OemToAnsi("Solicitante:") Size 50,8 Object cUsu
	@ 38,08 Say OemToAnsi("Senha:") Size 50,8
	@ 28,38 Get _cUsu   			Picture "XXXXXXXXXXXXXXXXXXXX" Size 86,10 WHEN .F.
	@ 38,38 Get _cSenha PASSWORD 	Picture "XXXXXXXXXXXXXXXXXXXX" Size 86,10  //Angelo Henrique - Data:05/01/2016 - Alterado o tamanho da PICTURE da senha
	@ 50,08 Say OemToAnsi("Senha do Solicitante necessária para prosseguir operação.") Size 106,20
	
	@ 075,075 BUTTON "Prosseguir" Size 50,12 ACTION Eval({|| nopc:=2,Close(oDlg2)})	
	@ 075,010 BUTTON "Cancelar  " Size 50,12 ACTION Eval({|| nopc:=1,Close(oDlg2)})

	
	Activate Dialog oDlg2 CENTERED
	
	If nOpc = 1
		lRet := .F.
	EndIf	
	
	If nOpc = 2
		PswOrder(2)
		If PswSeek( _cNoSoli , .T. )
		  	aUsu := PswRet()
			If PswName( _cSenha )  // Verico a senha do usuário
				_xAutoriz := _cUsu
				lRet := .T.
			Else
				MsgBox("Senha do usuário inválida.","ATENÇÃO","STOP")
				lRet := .F.
			EndIf
		EndIf	
	Else
		MsgBox("Usuário não autorizado a solicitar ítens ao Armazem.","ATENÇÃO","STOP")
		lRet := .F.
	EndIf
	RestArea(aArea)
Return(lRet)

/************************************************************************************
* Funcao..: CABA001B         *    Autor:  Carlos Aquino        * Data:  15/08/2005  *
*************************************************************************************
* Objetivo: Rotina de atualização dos Indices de Contenção (0 para 5)              *
************************************************************************************/

User Function CABA001B()
	Local aArea := GetArea()
	Local cMsg  := "Esta Rotina atualizará todos os valores de Indice de Contenção que forem 0% para 5%"
	
	if Aviso("Atualizar Indices de Contenção",cMsg,{"Sim","Não"}) = 1
		DbSelectArea("SB1")
		DbSetOrder(1)
		DbSeek(xFilial("SB1"))
		While !Eof() .and. B1_FILIAL = xFilial("SB1")
			if SB1->B1_XCONT = 0
				RecLock("SB1",.F.)
				SB1->B1_XCONT := 5
				MsUnlock()
			endif
			dbSkip()
		enddo
		Aviso("Operação Concluida!","A atualização foi concluida com sucesso!",{"OK"})
	endif
	RestArea(aArea)
Return               

/*/
_______________________________________________________________________________________________
	Parâmetros da MsGetDados():New()
¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
MsGetDados():New( nSuperior, nEsquerda, nInferior, nDireita, nOpc, cLinhaOk, ;
                  cTudoOk, cIniCpos, lApagar, aAlter, uPar1, lVazio, nMax, ;
                  cCampoOk, cSuperApagar, uPar2, cApagaOk, oWnd )
¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
 nSuperior....: Distancia entre a MsGetDados e o extremidade superior do objeto que a contém
 nEsquerda....: Distancia entre a MsGetDados e o extremidade esquerda do objeto que a contém
 nInferior....: Distancia entre a MsGetDados e o extremidade inferior do objeto que a contém
 nDireita.....: Distancia entre a MsGetDados e o extremidade direita do objeto que a contém
 nOpc.........: Posição do elemento do vetor aRotina que a MsGetDados usará como referencia
 cLinhaOk.....: Função executada para validar o contexto da linha atual do aCols
 cTudoOk......: Função executada para validar o contexto geral da MsGetDados (todo aCols)
 cIniCpos.....: Nome dos campos do tipo caracter que utilizarão incremento automático. 
                Este parâmetro deve ser no formato "+<nome do primeiro campo>+<nome do 
                segundo campo>+..."
 lApagar......: Habilita deletar linhas do aCols. Valor padrão falso
 aAlter.......: Vetor com os campos que poderão ser alterados
 uPar1........: Parâmetro reservado
 lVazio.......: Habilita validação da primeira coluna do aCols para esta não poder estar vazia. 
                Valor padrão falso
 nMax.........: Número máximo de linhas permitidas. Valor padrão 99
 cCampoOk.....: Função executada na validação do campo
 cSuperApagar.: Função executada quando pressionada as teclas <Ctrl>+<Delete>
 uPar2........: Parâmetro reservado
 cApagaOk.....: Função executada para validar a exclusão de uma linha do aCols
 oWnd.........: Objeto no qual a MsGetDados será criada
¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
/*/
          
/************************************************************************************
* Funcao..: CABA001GRV       *    Autor:  Carlos Aquino        * Data:  15/08/2005  *
*************************************************************************************
* Objetivo: Efetua a Atualizacao das Solicitacoes ao Almoxarifado                   *
* Parametros³ExpN1: [1] Inclusado                                                   *
*           ³       [2] Alteracao                                                   *
*           ³       [3] Exclusao                                                    *
* Retorno   ³ExpL1: .T. se atualizado efetuada                                      *
************************************************************************************/

Static Function CABA001GRV(nOpcao,_cNumSo,_dDataSo,cSolicta, _xAutoriz, pwdReq)

	Local cSaAnt 	:= _cNumSo
	Local nUsado	:= Len(aHeader)+1
	Local nPItem	:= aScan(aHeader,{|x| AllTrim(x[2])=="CP_ITEM"})
	Local nPProduto := aScan(aHeader,{|x| AllTrim(x[2])=="CP_PRODUTO"})
	Local nx		:= 0
	Local ny		:= 0
	Local cMay  := "" 
	Local nRecNo    := SCP->(RecNo())
	Local lGrava    := .T.
	

	If ( nOpcao != 3 )
		If ( nOpcao == 1 )
			dbSelectArea("SCP")
			cMay := "SCP"+AllTrim(xFilial("SCP"))
			While MsSeek(xFilial("SCP")+_cNumSo) .Or. !MayIUseCode(cMay+_cNumSo)
				_cNumSo := Soma1(_cNumSo,Len(_cNumSo))
			EndDo
			If ( _cNumSo # cSAAnt ).And. !l105Auto
				HELP(" ",1,"NUMSEQ",,_cNumSo,4,15)
			EndIf            
           ConfirmSX8()
           lGravou := .t.
    	Endif	
	
		For nx := 1 To Len(aCols)
			lGrava := .T.
			If ( !aCols[nx][nUsado] .And. !Empty(aCols[nx][nPProduto]) )
				dbSelectArea("SCP")
				dbSetOrder(1)
				If ( dbSeek(xFilial("SCP")+_cNumSo+aCols[nx][nPItem]) )
					If Empty(CP_PREREQU)
						RecLock("SCP",.F.)
					Else
						lGrava := .F.
					EndIf	
				Else
					RecLock("SCP",.T.)
				EndIf
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Atualiza dados padroes da solicitacao ao almox.          ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				If lGrava
					Replace CP_FILIAL  With xFilial("SCP")
					Replace CP_NUM     With _cNumSo
					Replace CP_EMISSAO With _dDataSo
					Replace	CP_SOLICIT With cSolicta
					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³ Atualiza dados do corpo da SA.                           ³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					For ny := 1 To Len(aHeader)
						If ( aHeader[ny][10] != "V" )
							FieldPut(FieldPos(aHeader[ny][2]),aCols[nx][ny])
						EndIf
					Next ny
					MsUnLock()
					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³Cria o Almoxarifado se nao existir                        ³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					CriaSb2(SCP->CP_PRODUTO,SCP->CP_LOCAL)
					
					if pwdReq
						DbSelectArea("SCP")
						dbSetOrder(1)
						dbSeek(xFilial("SCP")+_cNumSo )
						While !Eof() .and. CP_FILIAL+CP_NUM = xFilial("SCP")+_cNumSo
							RecLock("SCP",.F.)
							CP_XAUTORI := cSolicta
							MsUnlock()
							DbSkip()
						Enddo
					endif	
				EndIf
			Else
				dbSelectArea("SCP")
				dbSetOrder(1)
				If ( dbSeek(xFilial("SCP")+_cNumSo+aCols[nx][nPItem]) ) .And. Empty(SCP->CP_PREREQU)
					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³Atualiza os arquivos do SIGAPMS - Estorno/Exclusao                      ³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					//PMSWriteSA(2,"SCP")
					//PMSWriteSA(3,"SCP")
					RecLock("SCP",.F.,.T.)
					dbDelete()
					MsUnLock()
				EndIf
			EndIf
		Next nx
	EndIf
Return .T.


/************************************************************************************
* Funcao..: BuscaSlSolic     *    Autor:  Carlos Aquino        * Data:  09/08/2005  *
*************************************************************************************
* Objetivo: Retorna a Quantidade Solicitada p/ determinado produto/mes/CC           *
************************************************************************************/
Static Function BuscaSlSolic(_cCeCusto, _cProduto,_dData)

	Local aArea    := GetArea()
	Local cDataFim := Substr(DtoS(_dData),1,4)+StrZero(Val(SubStr(DtoS(_dData),5,2)),2)
	Local _nConta  := 0
	Local cQuery   := ""
	Local aDados   := {}
	Local nRet     := 0
	Local nCont    := 0
	Local i        := 0
	Local lGrav    := .T.
	Local lCalcula := .T.
	Local nRet     := 0
	
	If Select("XXP") > 0
		DbSelectArea("XXP")
		DbCloseArea()
	Endif
                               
	cQuery := "Select CP_PRODUTO, CP_QUANT from "+RetSqlName("SCP")
	cQuery += " where CP_PRODUTO = '"+_cProduto+"'"
	
	//Leonardo Portella - 07/11/14 - Inicio - Virada TISS 3 - Compilacao TDS - CABA001.PRW(1133) - Command has no effect
	 
	//cQuery == " AND CP_CC  = '"+_cCeCusto+"'"
	cQuery += " AND CP_CC  = '"+_cCeCusto+"'"
	
	//Leonardo Portella - 07/11/14 - Fim - Virada TISS 3 
	
	cQuery += " AND SubStr(CP_DATPRF,1,6) = '"+Substr(DtoS(dDataSoli),1,6)+"'"		// 	cQuery += " AND SubString(CP_DATPRF,1,6) = '"+Substr(DtoS(dDataSoli),1,6)+"'"
	cQuery += " AND CP_FILIAL = '"+xFilial("SCP")+"'"
	cQuery += " AND D_E_L_E_T_ <> '*'
	
	If TcSqlExec(cQuery) < 0
		TcSqlError()
	Endif
	
	TCQUERY cQuery Alias XXP NEW

	DbSelectArea("XXP")
	DbGoTop()
	if !Eof()
		nRet := XXP->CP_QUANT
	endif
		
	/*If Select("XXP") > 0
		DbSelectArea("XXP")
		DbCloseArea()
	Endif*/

Return nRet

/************************************************************************************
* Funcao..: NumSolArm        *    Autor:  Carlos Aquino        * Data:  09/08/2005  *
*************************************************************************************
* Objetivo: Retorna a Quantidade Solicitada p/ determinado produto/mes/CC           *
************************************************************************************/
Static Function NumSolArm()
	Local aArea    := GetArea()
	Local cRet     := ""
	Local cQuery   := ""

	If Select("XXZ") > 0
		DbSelectArea("XXZ")
		DbCloseArea()
	Endif

	cQuery := "Select MAX(CP_NUM) CP_NUM from "+RetSqlName("SCP")
	cQuery += " where CP_FILIAL = '"+xFilial("SCP")+"'"
	
	If TcSqlExec(cQuery) < 0
		TcSqlError()
	Endif
	
	TCQUERY cQuery Alias XXZ NEW

	DbSelectArea("XXZ")
	DbGoTop()
	While !Eof()
		cRet := XXZ->CP_NUM
		dbSkip()
	Enddo
	
	/*If Select("XXZ") > 0
		DbSelectArea("XXZ")
		DbCloseArea()
	Endif*/
	cRet := Soma1(cRet)
	
Return cRet