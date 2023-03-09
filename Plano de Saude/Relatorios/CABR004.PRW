#INCLUDE "PROTHEUS.CH"
#INCLUDE "PLSMGER.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCABR004   บAutor  ณLuzio Tavares       บ Data ณ  13/03/06   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณEmissao de Etiquetas por lote de cartao de identificacao emiบฑฑ
ฑฑบ          ณtidos.                                                      บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณCABERJ                                                      บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Define nome da funcao                                                    ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
User Function CABR004()
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Define variaveis padroes para todos os relatorios...                     ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Define Variaveis                                             ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	Private nQtdLin   := 55
	Private wnrel   	:= "CABR004"			// Nome do Arquivo utilizado no Spool
	Private cTitulo 	:= "Etiquetas AVULSAS"
	Private cDesc1 	:= "Emissใo Etiquetas AVULSAS"
	Private cDesc2 	:= ""
	Private cDesc3 	:= ""
	Private cString 	:= "BA1"	      			// Alias utilizado na Filtragem
	Private lDic    	:= .F. 			   		// Habilita/Desabilita Dicionario
	Private lComp   	:= .F. 				   	// Habilita/Desabilita o Formato Comprimido/Expandido
	Private lFiltro 	:= .F.    					// Habilita/Desabilita o Filtro
	Private cCabec1   := ""
	Private cCabec2   := ""
	Private cNomeProg	:= "CABR004.PRW"	   	// nome do programa
	Private cTamanho  := "P"				   	// P/M/G
	Private Limite    := 80  //132 //220	    		// 80/132/220
	Private nTipo     := 18
	
	Private aReturn := { "Zebrado",;	    	//[1] Reservado para Formulario
	1,;		   		//[2] Reservado para Nง de Vias
	"Administra็ใo",;	//[3] Destinatario
	2,;			   	//[4] Formato => 1-Comprimido 2-Normal
	1,;	    	   	//[5] Midia   => 1-Disco 2-Impressora
	1,;			   	//[6] Porta ou Arquivo 1-LPT1... 4-COM1...
	"",;			   	//[7] Expressao do Filtro
	1 } 			   	//[8] Ordem a ser selecionada
	//							[9]..[10]..[n]    //Campos a Processar (se houver)
	
	Private m_pag   := 1							// Contador de Paginas
	Private nLastKey:= 0							// Controla o cancelamento da SetPrint e SetDefault
	Private cPerg   := "CAR004    "	               // Pergunta do Relatorio
	Private aOrdem  := {}						// Ordem do Relatorio
	Private nFormat := 1     					//
	Private nNumCol := 0
	Private cTipImp := 1
	Private nPosCol := 1
	
	private nUtilEnd      //Utiliza endereco
	PRIVATE cUFDe      // Codigo da Operadora de
	PRIVATE cUFAte      // Codigo da Operadora de
	PRIVATE cCEPDe      // Codigo da Operadora de
	PRIVATE cCEPAte      // Codigo da Operadora de
	PRIVATE cGrupoDe    // Codigo do Grupo/Empresa de
	PRIVATE cGrupoAte   // Codigo do Grupo/Empresa ate
	PRIVATE cContrDe    // Codigo do Contrato de
	PRIVATE cContrAte   // Codigo do Contrato ate
	PRIVATE cSbConDe    // Codigo do Sub-contrato de
	PRIVATE cSbConAte   // Codigo do Sub-contrato ate
	PRIVATE cCodMunDe   // Codigo do Sub-contrato ate
	PRIVATE cCodMunAte  // Codigo do Sub-contrato ate
	PRIVATE nTipEnd     // Codigo do Sub-contrato ate
	PRIVATE cProdDe     // Codigo do Sub-contrato ate
	PRIVATE cProdAte    // Codigo do Sub-contrato ate
	PRIVATE cOpeDes     // Codigo da Operadora de Destino
	PRIVATE cNomEtq
	PRIVATE lSomTit     := .F.
	
	//BIANCHINI - 27/08/2014
	//Pelo motivo de alguem ter ZUADO INSANAMENTE o cEmpAnt mais abaixo neste fonte, estou tomando a seguinte atitude:
	
	PRIVATE cEmpAntORI := cEmpAnt
	
	//------------------------------------------------------------------------
	//Angelo Henrique - Data:21/10/2015 - Para filtrar conforme localidade
	//------------------------------------------------------------------------
	PRIVATE _nLocal := ""
	PRIVATE _cAgenc := ""
	PRIVATE _cMunic := ""
	PRIVATE _cBairr := ""
	
	
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Verifica as perguntas selecionadas                           ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	AjustaSX1(cPerg)
	Pergunte(cPerg,.T.)
	
	nNumCol := Mv_Par06
	If nNumCol > 2							// Matriculas digitadas
		cTamanho := "M"				   	// P/M/G
		Limite  := 132               	// 80/132/220
	EndIf
	
	nUtilEnd := Mv_Par08
	cTipImp := MV_PAR09
	nPosCol := MV_PAR10
	
	cUFDe      := Mv_Par11
	cUFAte     := Mv_Par12
	cCEPDe     := Mv_Par13
	cCEPAte    := Mv_Par14
	cGrupoDe   := Mv_Par15
	cGrupoAte  := Mv_Par16
	cContrDe   := Mv_Par17
	cContrAte  := Mv_Par18
	cSubConDe  := Mv_Par19
	cSubConAte := Mv_Par20
	cCodMunDe  := Mv_Par21
	cCodMunAte := Mv_Par22
	nTipEnd    := Mv_Par23
	cProdDe    := Mv_Par24
	cProdAte   := Mv_par25
	cNomEtq    := mv_par26
	lSomTit    := Iif(MV_PAR07 == 2,.T.,.F.)   // Imprimir etiqueta somente para titulares, mesmo existindo dependentes?
	nOrdem     := mv_par29
	
	//---------------------------------------------------
	//Angelo Henrique - Data:21/10/2015 - Localidade
	//---------------------------------------------------
	_nLocal := mv_par30
	_cAgenc := AllTrim(mv_par31)
	
	If !Empty(_cAgenc)
		
		//-----------------------------------------------------------------------------	||
		// Tabela Gen้rica contendo as localidades dos bairros que serใo pesquisados		||
		//-----------------------------------------------------------------------------	||
		//CODIGO	|DESCRIวรO																		||
		//-----------------------------------------------------------------------------	||
		//01   	|NITEROI (CENT,ST ROSA,ICARAI,BARRET,FONS,S DOMIN,INGA) 				||
		//02    	|TIJUCA (TIJUC, R COMP, MARAC; GRAJAU, PRC BAND, S CRIS)				||
		//03    	|CENTRO RJ (CENTRO; FLAMENGO; LAPA; SANTO CRISTO, GLORIA				||
		//04    	|BANGU (BANGU,CAMPO GRANDE)                             				||
		//05    	|COPACABANA (COPACABANA, IPANEMA, LEBLON, LEME, BOTAFOG)				||
		//06    	|GERAL (AQUELES QUE NAO ENTRAM NA REGRA)                				||
		//-----------------------------------------------------------------------------	||
		If _cAgenc = "01"
			
			_cMunic := "NITEROI"
			_cBairr := "IN ('CENTRO', 'SANTA ROSA', 'ICARAI', 'BARRETO', 'FONSECA', 'SAO DOMINGOS', 'INGA')"
			
		ElseIf _cAgenc = "02"
			
			_cMunic := "RIO DE JANEIRO"
			_cBairr := "IN ('TIJUCA', 'RIO COMPRIDO', 'MARACANA', 'GRAJAU', 'PRACA DA BANDEIRA', 'SAO CRISTOVAO')"
			
		ElseIf _cAgenc = "03"
			
			_cMunic := "RIO DE JANEIRO"
			_cBairr := "IN ('CENTRO', 'FLAMENGO', 'LAPA', 'SANTO CRISTO', 'GLORIA')"
			
		ElseIf _cAgenc = "04"
			
			_cMunic := "RIO DE JANEIRO"
			_cBairr := "IN ('BANGU', 'CAMPO GRANDE')"
			
		ElseIf _cAgenc = "05"
			
			_cMunic := "RIO DE JANEIRO"
			_cBairr := "IN ('COPACABANA', 'IPANEMA', 'LEBLON', 'LEME', 'BOTAFOGO')"
			
		EndIf
		
	EndIf
	
	wnrel := SetPrint(cString,wnrel,cPerg,@cTitulo,cDesc1,cDesc2,cDesc3,lDic,aOrdem,lComp,cTamanho,lFiltro)
	
	If (nLastKey == 27)
		DbSelectArea(cString)
		DbSetOrder(1)
		DbClearFilter()
		Return
	Endif
	
	/*
	aArray - Array aReturn, preenchido pelo SetPrint
	[1] Reservado para Formulแrio
	[2] Reservado para Nบ de Vias
	[3] Destinatแrio
	[4] Formato => 1-Comprimido 2-Normal
	[5] Mํdia => 1-Disco 2-Impressora
	[6] Porta ou Arquivo 1-LPT1... 4-COM1...
	[7] Expressใo do Filtro
	[8] Ordem a ser selecionada
	[9]..[10]..[n] Campos a Processar (se houver)
	cAlias - Alias do arquivo a ser impresso.
	*/
	//SetDefault(aReturn,cString, , , tamanho, nFormat)
	
	aReturn[4] := 2
	
	SetDefault(aReturn,cString)
	
	If (nLastKey == 27)
		DbSelectArea(cString)
		DbSetOrder(1)
		DbClearFilter()
		Return
	Endif
	
	nTipo := If(aReturn[4]==1,15,18)
	
	RptStatus({|lEnd| R333Imp(@lEnd,wnRel,cString,cNomeprog,cTitulo,cCabec1, cCabec2)},cTitulo)
	
	//BIANCHINI - 28/08/2014 - GARANTINDO QUE A VARIAVEL cEmpAnt retorne ao sistema com seu valor original
	If (cEmpAnt <> cEmpAntORI) .and. (!cEmpAnt $ '01|02')
		cEmpAnt := cEmpAntORI
	Endif
	
Return(.T.)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณR333Imp   บAutor  ณLuzio Tavares       บ Data ณ  13/03/08   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณImprime as etiquetas                                        บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณCABERJ                                                      บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function R333Imp(lEnd,wnrel,cString,cNomeprog,cTitulo,cCabec1,cCabec2)
	
	Local nI := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS
	
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Define variaveis...                                                      ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	Local cSQL		:= ""
	//Local nOrdSel   := aReturn[8]
	Local I         := 1
	Local J         := 0
	Local Lin       := Array(5,3)
	Local cCodigo   := ""
	Local nLin		 := nQtdLin+1  //0
	Local nColuna	 := 0
	Local cCodCli   := ""	// codigo do cliente
	Local cLoja     := ""	// loja do cliente
	Local cNomCli	 := ""	// nome do cliente
	Local cNivel	 := ""	// nivel que pode ser "4" na familia "3" no subcontrato "5" na operadora "2" no contrato ou "1" grupo de empresa
	Local cImprime  := ""
	Local aClientes := {}
	Local aRecNum   := {}
	Local cRecNum   := ""
	Local nQtdEtq   := 0
	Local lTemUnion := .F.
	Local cNomTit   := space(42)
	Local cNome     := Space(42)
	Local aResumo   := {}
	Local lImprime  := .T.
	Local nTotSub   := 0
	Local nTotal	:= 0
	
	Local cLotac    := space(20)
	Local cFunci    := space(9)
	
	//------------------------------------------------------------------------------------
	//Angelo Henrique - Data:23/10/2015															
	//Removido  a sele็ใo de matriculas, uma vez que nใo existe essa necessidade
	//e o mesmo esta dando erro na query quando realiza o UNION
	//------------------------------------------------------------------------------------
	
	If Mv_Par05 == 1		// Matriculas digitadas
		aRecNum := CABR004Matr()
		For I := 1 To Len(aRecNum)
			cRecNum += AllTrim(Str(aRecNum[I][3])) + IIF(I<>Len(aRecNum),",","")
		Next
	Endif

	
	If mv_par27 == 1
		Limite     := 132
		cTamanho   := "G"
		If nTipEnd == 1     // em ordem de endereco residencial
			cCabec1 := "Codigo do Usuario   Nome do Usuario                          Nome Titular                              Nascimento  Validade   Dt.Solic.  Lote         Via  Est Cob    Funcional"
		Else
			cCabec1 := "Codigo do Usuario   Nome do Usuario                          Nome Titular                              Nascimento  Validade   Dt.Solic.  Lote         Via  Est Cob    Lotacao             Funcional"
		Endif
		cCabec2 := ""
	Else
		cCabec1 := ""
		cCabec2 := ""
		If Mv_Par06 > 2							// Matriculas digitadas
			cTamanho := "M"				   	// P/M/G
			Limite  := 132               	// 80/132/220
		EndIf
	EndIf
	
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Faz filtro no arquivo...                                                 ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	
	cSQL  := space(0)
	cSQL1 := space(0)
	cSQL2 := space(0)
	cSQL3 := space(0)
	
	If !Empty(MV_PAR01) .Or. !Empty(MV_PAR02) .Or. !Empty(MV_PAR03) .Or. !Empty(MV_PAR04) .Or. !Empty(cGrupoDe) .Or. !Empty(cContrDe) .Or. !Empty(cSubConDe) .Or. !Empty(cGrupoAte) .Or. !Empty(cContrAte) .Or. !Empty(cSubConAte)
		cSQL1 := "SELECT BA1.R_E_C_N_O_, BA1_CODINT, BA1_CODEMP, BA1_CONEMP, BA1_VERCON, BA1_SUBCON, BA1_VERSUB, BA1_MATRIC, BA1_TIPREG, BA1_DIGITO, BA1_NOMUSR, BA1_YNMSOC,"
		cSQL1 += "BA1_YLOTAC, BA1_MATEMP, BA3_MATEMP, BA1_YNOMLO, BA1_ENDERE, BA1_NR_END, BA1_COMEND, BA1_BAIRRO, BA1_ESTADO, BA1_MUNICI, BA1_CEPUSR, "
		cSql1 += "DECODE(Trim(BA1_CODPLA),NULL,BA3_CODPLA,BA1_CODPLA) AS BA1_CODPLA, "
		cSQL1 += "BTS_CEPUSR, BTS_ENDERE, BTS_NR_END, BTS_COMEND, BTS_BAIRRO, BTS_ESTADO, BTS_MUNICI, BTS_DATNAS "
		
		if cEmpAntORI == '01'
			cSQL1 += " ,RETORNA_DESCRI_GRUPOEMP ('C',BA1.BA1_CODEMP) EMPRESA "
		Else
			cSQL1 += " ,RETORNA_DESCRI_GRUPOEMP ('I',BA1.BA1_CODEMP) EMPRESA "
		Endif
		
		cSQL3 := "FROM " + RetSQLName("BA1")+" BA1, "+RetSQLName("BTS")+" BTS, "+RetSQLName("BA3")+" BA3 "
		cSQL += "WHERE	"
		If  !Empty(MV_PAR01) .and. !Empty(MV_PAR02)   //lote de arquivo a ser impresso
			
			cSQL2 := " ,BED_CDIDEN, BED_FILIAL, BED_DATVAL, BED_VIACAR, BED_DATVAL, BED_DTSOLI, BED_FATUR, BED.R_E_C_N_O_ AS BEDRECNO "
			
			cSQL3 += ","+ RetSQLName("BED")+" BED "
			cSQL += "BED.BED_FILIAL = '" + xFilial("BED") + "' AND "
			cSQL += "BED.BED_CDIDEN BETWEEN '" + Mv_Par01 + "' AND '" + Mv_Par02 + "' AND "
			cSql += "BA1.BA1_CODINT = BED.BED_CODINT AND "
			cSql += "BA1.BA1_CODEMP = BED.BED_CODEMP AND "
			cSql += "BA1.BA1_MATRIC = BED.BED_MATRIC AND "
			cSql += "BA1.BA1_TIPREG = BED.BED_TIPREG AND "
			cSql += "BA1.BA1_DIGITO = BED.BED_DIGITO AND "
			cSQL += "BTS.BTS_FILIAL = '" + xFilial("BTS") + "' AND "
			//	Else
			//		cSQL += "WHERE BTS.BTS_FILIAL = '" + xFilial("BTS") + "' AND "
		EndIf
		cSQL += "BTS.BTS_FILIAL = '" + xFilial("BTS") + "' AND "
		cSql += "BTS.BTS_MATVID = BA1.BA1_MATVID AND "
		cSQL += "BA1.BA1_FILIAL = '" + xFilial("BA1") + "' AND "
		
		If !Empty(MV_PAR03) .and. !Empty(MV_PAR04)
			cSql += "BA1.BA1_CODINT||BA1.BA1_CODEMP||BA1.BA1_MATRIC||BA1.BA1_TIPREG||BA1.BA1_DIGITO BETWEEN '" + Mv_Par03 + "' AND '" + Mv_Par04 + "' AND "
			//	cSql += "BA1.BA1_CODEMP BETWEEN '" + SubStr(Mv_Par03,05,04) + "' AND '" + SubStr(Mv_Par04,05,04) + "' AND "
			//	cSql += "BA1.BA1_MATRIC BETWEEN '" + SubStr(Mv_Par03,09,06) + "' AND '" + SubStr(Mv_Par04,09,06) + "' AND "
			//	cSql += "BA1.BA1_TIPREG BETWEEN '" + SubStr(Mv_Par03,15,02) + "' AND '" + SubStr(Mv_Par04,15,02) + "' AND "
			//	cSql += "BA1.BA1_DIGITO BETWEEN '" + SubStr(Mv_Par03,17,01) + "' AND '" + SubStr(Mv_Par04,17,01) + "' AND "
		EndIf
		cSql += "BA3.BA3_CODINT = BA1.BA1_CODINT AND "
		cSql += "BA3.BA3_CODEMP = BA1.BA1_CODEMP AND "
		cSql += "BA3.BA3_MATRIC = BA1.BA1_MATRIC AND "
		
		//---------------------------------------------
		//Angelo Henrique - Data: 26/10/2015 
		//---------------------------------------------
		//Acrescentado para filtrar corretamente e 
		//remover aqueles que foram bloqueados.
		//---------------------------------------------
		cSql += "BA1_DATBLO = ' ' AND "  
		
		//If !empty(cOpeDes)
		//	cSQL += " AND BA1_OPEDES = '"+cOpeDes+"' "
		//Else
		//	cSQL += " AND BA1_OPEDES <> '"+PlsIntPad()+"' "
		//EndIf
		
		//	If lSomTit .and. Empty(MV_PAR02)   //Isso filtrarแ caso nใo seja solicitado a emissใo de lotes
		//		cSql +=	"BA1.BA1_TIPREG = '00' AND "
		//	EndIf
		
		If !Empty(cGrupoAte)
			cSql += "BA1.BA1_CODEMP BETWEEN '" + cGrupoDe + "' AND '" + cGrupoAte + "' AND "
		EndIf
		If !Empty(cContrAte)
			cSql += "BA1.BA1_CONEMP BETWEEN '" + cContrDe + "' AND '" + cContrAte + "' AND "
			//	cSql += "BA1.BA1_VERCON BETWEEN '" + cVerConDe + "' AND '" + cVerConAte + "' AND "
		EndIf
		If !Empty(cSubConAte)
			cSql += "BA1.BA1_SUBCON BETWEEN '" + cSubConDe + "' AND '" + cSubConAte + "' AND "
			//	cSql += "BA1.BA1_VERSUB BETWEEN '" + cVerSubDe + "' AND '" + cVerSubAte + "' AND "
		EndIf
		
		If !Empty(cCodMunAte)
			If nUtilEnd = 2
				cSql += "BTS.BTS_MUNICI BETWEEN '" + cCodMunDe + "' AND '" + cCodMunAte + "' AND "
			Else
				cSql += "BTS.BTS_MUNICI BETWEEN '" + cCodMunDe + "' AND '" + cCodMunAte + "' AND "
			EndIf
		EndIf
		If !Empty(cUFAte)
			If nUtilEnd = 2
				cSql += "BA1.BA1_ESTADO BETWEEN '" + cUFDe + "' AND '" + cUFAte + "' AND "
			Else
				cSql += "BTS.BTS_ESTADO BETWEEN '" + cUFDe + "' AND '" + cUFAte + "' AND "
			EndIf
		EndIf
		If !Empty(cCEPAte)
			If nUtilEnd = 2
				cSql += "BA1.BA1_CEPUSR BETWEEN '" + cCEPDe + "' AND '" + cCEPAte + "' AND "
			Else
				cSql += "BTS.BTS_CEPUSR BETWEEN '" + cCEPDe + "' AND '" + cCEPAte + "' AND "
			EndIf
		EndIf
		If !Empty(cProdAte)
			cSql += "BA1_CODPLA BETWEEN '" + cProdDe + "' AND '" + cProdAte + "' AND "
		EndIf
		
		//-------------------------------------------------------
		//INICIO - Angelo Henrique - Data:21/10/2015 - Localidade
		//-------------------------------------------------------
		If _nLocal = 1
			
			If !Empty(AllTrim(_cAgenc))
				
				If _cAgenc $ "02|03|04|05"
					
					cSql += "BA1.BA1_MUNICI = '" + _cMunic  + "' AND "
					cSql += "BA1.BA1_BAIRRO  " + _cBairr  + " AND "
					
				ElseIf _cAgenc = "01"
					
					cSql += "BA1.BA1_MUNICI = '" + _cMunic  + "' AND "
					cSql += "BA1.BA1_BAIRRO  " + _cBairr    + " AND "
					
				EndIf
				
			EndIf
			
		EndIf
		//-------------------------------------------------------
		//FIM    - Angelo Henrique - Data:21/10/2015 - Localidade
		//-------------------------------------------------------
		
		If  !Empty(MV_PAR01) .and. !Empty(MV_PAR02)
			cSql	+=	"BED.D_E_L_E_T_ = ' ' AND "
		EndIf
		cSql	+=	"BTS.D_E_L_E_T_ = ' ' AND "
		cSql	+=	"BA3.D_E_L_E_T_ = ' ' AND "
		cSql	+=	"BA1.D_E_L_E_T_ = ' ' "
		If !Empty(cRecNum)
			csql += "UNION "
			lTemUnion := .T.
		EndIf
	EndIf
	If !Empty(cRecNum)
		If lTemUnion
			cSQL += "SELECT "
		Else
			cSQL := "SELECT "
		EndIf
		cSQL += "BA1.R_E_C_N_O_, BA1_CODINT, BA1_CODEMP, BA1_CONEMP, BA1_VERCON, BA1_SUBCON, BA1_VERSUB, BA1_MATRIC, BA1_TIPREG, BA1_DIGITO, BA1_NOMUSR, BA1_YNMSOC, "
		cSQL += "BA1_YLOTAC, BA1_MATEMP, BA3_MATEMP, BA1_YNOMLO, BA1_ENDERE, BA1_NR_END, BA1_COMEND, BA1_BAIRRO, BA1_ESTADO, BA1_MUNICI, BA1_CEPUSR, "
		cSql += "DECODE(Trim(BA1_CODPLA),NULL,BA3_CODPLA,BA1_CODPLA) AS BA1_CODPLA, "
		cSQL += "BTS_CEPUSR, BTS_ENDERE, BTS_NR_END, BTS_COMEND, BTS_BAIRRO, BTS_ESTADO, BTS_MUNICI, BTS_DATNAS "
		if cEmpAntORI == '01'
			cSQL += " ,RETORNA_DESCRI_GRUPOEMP ('C',BA1.BA1_CODEMP) EMPRESA "
		Else
			cSQL += " ,RETORNA_DESCRI_GRUPOEMP ('I',BA1.BA1_CODEMP) EMPRESA "
		Endif
		cSQL += "FROM "+ RetSQLName("BA1")+" BA1, "+RetSQLName("BTS")+" BTS, "+RetSQLName("BA3")+" BA3 "
		cSQL += "WHERE BA1.R_E_C_N_O_ IN (" + cRecNum + ") AND "
		cSQL += "BTS.BTS_FILIAL = '" + xFilial("BTS") + "' AND "
		cSQL += "BA1.BA1_FILIAL = '" + xFilial("BA1") + "' AND "
		cSql += "BTS.BTS_MATVID = BA1.BA1_MATVID AND "
		cSql += "BA3.BA3_CODINT = BA1.BA1_CODINT AND "
		cSql += "BA3.BA3_CODEMP = BA1.BA1_CODEMP AND "
		cSql += "BA3.BA3_MATRIC = BA1.BA1_MATRIC AND "
		cSql += "BTS.D_E_L_E_T_ = ' ' AND "
		cSql += "BA3.D_E_L_E_T_ = ' ' AND "
		cSQL += "BA1.D_E_L_E_T_ = ' ' "
		
		//-------------------------------------------------------
		//INICIO - Angelo Henrique - Data:21/10/2015 - Localidade
		//-------------------------------------------------------
		If _nLocal = 1
			
			If !Empty(AllTrim(_cAgenc))
				
				If _cAgenc $ "02|03|04|05"
					
					cSql += "BA1.BA1_MUNICI = '" + _cMunic + "' AND "
					cSql += "BA1.BA1_BAIRRO  " + _cBairr + " AND "
					
				ElseIf _cAgenc = "01"
					
					cSql += "BA1.BA1_MUNICI = '" + _cMunic + "' AND "
					cSql += "BA1.BA1_BAIRRO  " + _cBairr + " AND "
					
				EndIf
				
			EndIf
			
		EndIf
		
		//-------------------------------------------------------
		//FIM    - Angelo Henrique - Data:21/10/2015 - Localidade
		//-------------------------------------------------------
		
	Endif
	If nTipEnd == 1     // em ordem de endereco residencial
		If nOrdem == 1   // Ordem de Nome de Usuario
			//cSql	+=	"ORDER BY BA1_NOMUSR, BA1_CODINT, BA1_CODEMP, BA1_CONEMP, BA1_VERCON, BA1_SUBCON, BA1_VERSUB, BA1_MATRIC "
			cSql	+=	"ORDER BY BA1_CODINT, BA1_CODEMP, BA1_CONEMP, BA1_VERCON, BA1_SUBCON, BA1_VERSUB, BA1_NOMUSR, BA1_MATRIC, BA1_TIPREG "
		ElseIf nOrdem == 2 // Ordem de Matricula do Microsiga
			//		cSql	+=	"ORDER BY BA1_CODINT, BA1_CODEMP, BA1_CONEMP, BA1_VERCON, BA1_SUBCON, BA1_VERSUB, BA1_MATRIC "
			cSql	+=	"ORDER BY BA1_CODINT, BA1_CODEMP, BA1_CONEMP, BA1_VERCON, BA1_SUBCON, BA1_VERSUB, BA1_CODEMP, BA1_MATRIC, BA1_TIPREG "
		ElseIf nOrdem == 5
			//cSql	+=	"ORDER BY BA1_CODINT, BA1_CODEMP, BA1_CONEMP, BA1_VERCON, BA1_SUBCON, BA1_VERSUB, BA1_MATEMP "
			// Roberto Meirelles - 12082015 - Altera็ใo para atender ao Estaleiro na CABERJ
			cSql	+=	"ORDER BY BA1_SUBCON, BA3_MATEMP "
			
		ElseIf nOrdem == 4 //Matricula - Angelo Henrique - Data: 26/10/2015
		
			cSql	+=	"ORDER BY BA1_MATRIC "
		
		Else	   //Ordem do Lote Gerado
			If Empty(MV_PAR01) .Or. Empty(MV_PAR02)
				cSql	+=	"ORDER BY BA1_CODINT, BA1_CODEMP, BA1_CONEMP, BA1_VERCON, BA1_SUBCON, BA1_VERSUB, BA1_MATRIC "
			EndIf
		EndIf
	Else   // Por lotacao
		If nOrdem == 1   // Ordem de Nome de Usuario
			cSql	+=	"ORDER BY BA1_YLOTAC, BA1_NOMUSR "
		ElseIf nOrdem == 2 // Ordem do Matricula do microsiga
			//		cSql +=	"ORDER BY BA1_CODINT, BA1_CODEMP, BA1_CONEMP, BA1_VERCON, BA1_SUBCON, BA1_VERSUB, BA1_MATRIC "
			cSql	+=	"ORDER BY BA1_CODINT, BA1_CODEMP, BA1_MATRIC, BA1_TIPREG "
		ElseIf nOrdem == 3     //Ordem do Lote Gerado
			//       cSql	+=	"ORDER BY BA1_YLOTAC, BA1_CODINT, BA1_CODEMP, BA1_CONEMP, BA1_VERCON, BA1_SUBCON, BA1_VERSUB, BA1_MATRIC "
			If !Empty(MV_PAR01) .and. !Empty(MV_PAR02)   //lote de arquivo a ser impresso
				cSql += "ORDER BY BEDRECNO "
			Else
				cSql +=	"ORDER BY BA1_CODINT, BA1_CODEMP, BA1_CONEMP, BA1_VERCON, BA1_SUBCON, BA1_VERSUB, BA1_MATRIC "
			EndIf
		
		ElseIf nOrdem == 4 //Matricula - Angelo Henrique - Data: 26/10/2015
		
			cSql	+=	"ORDER BY BA1_MATRIC "
		
		ElseIf nOrdem == 5
			cSql	+=	"ORDER BY BA1_MATEMP "
		Else //Ordem de Lotacao do Itau
			cSql	+=	"ORDER BY BA1_YLOTAC, BA1_CODINT, BA1_CODEMP, BA1_MATRIC, BA1_TIPREG "
		Endif
	EndIf
	
	memowrit("C:\CABR004.SQL",cSQL1+cSQL2+cSQL3+cSQL)
	
	PLSQuery(cSQL1+cSQL2+cSQL3+cSQL,"ETQ")
	
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ SETA A IMPRESSORA PARA A POSICAO zero e expandido                   ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	//setprc(0,0)
	//@000,000 PSAY Chr(18)  // Compressao de Impressao
	
	SetRegua( ETQ->( RecCount() ) )
	
	//@ pRow(),pCol() Psay "0....+....1....+....2....+....3....+....4....+....5....+....6....+....7....+....8....+....9....+....0....+....1....+....2....+....3....+....4....+....5....+....6"
	
	ETQ->(DbGoTop())
	
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Imprime cabecalho do relatorio...                                        ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	If mv_par27 == 1
		
		cEmpAnt := "xxxxxxxxxxxxxxxxxxx"
		
		cConAnt   := ' '
		cSubAnt   := ' '
		
		cFamAnt := ETQ->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC)
		
		While !ETQ->(Eof())
			cNomTit := space(40)
			
			//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
			//ณ Verifica o cancelamento pelo usuario...                             ณ
			//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
			If lAbortPrint
				@nLin,00 PSAY "*** CANCELADO PELO OPERADOR ***"
				Exit
			Endif
			
			//--------------------------------------------------------
			//INICIO - Angelo Henrique - Data:21/10/2015
			//Valida็๕es para op็๕es de localidade
			//--------------------------------------------------------
			If _nLocal = 1 .And. _cAgenc = "06"
				
				If UPPER(AllTrim(ETQ->BA1_MUNICI)) = "RIO DE JANEIRO"
					
					If UPPER(AllTrim(ETQ->BA1_BAIRRO)) $ "TIJUCA|RIO COMPRIDO|MARACANA|GRAJAU|PRACA DA BANDEIRA|SAO CRISTOVAO|CENTRO|FLAMENGO|LAPA|SANTO CRISTO|GLORIA|BANGU|CAMPO GRANDE|COPACABANA|IPANEMA|LEBLON|LEME|BOTAFOGO"
						
						ETQ->(DbSkip())
						Loop
						
					EndIf
					
				ElseIf UPPER(AllTrim(ETQ->BA1_MUNICI)) = "NITEROI"
					
					If UPPER(AllTrim(ETQ->BA1_BAIRRO)) $ "CENTRO|SANTA ROSA|ICARAI|BARRETO|FONSECA|SAO DOMINGOS|INGA"
						
						ETQ->(DbSkip())
						Loop
						
					EndIf
					
				EndIf
				
			EndIf
			//--------------------------------------------------------
			// FIM    - Angelo Henrique - Data:21/10/2015
			//--------------------------------------------------------
			
			//If cEmpAnt <> ETQ->BA1_CODEMP
			If cEmpAnt + cConAnt + cSubAnt <> ETQ->(BA1_CODEMP + BA1_CONEMP + BA1_SUBCON)
				BQC->(DbSetorder(1))
				BQC->(DbSeek(xFilial("BQC")+ETQ->(BA1_CODINT+BA1_CODEMP+BA1_CONEMP+BA1_VERCON+BA1_SUBCON+BA1_VERSUB)))
				
				nLin := nQtdLin+10
				If nLin > nQtdLin
					nLin := cabec(cTitulo,cCabec1,cCabec2,cNomeProg,cTamanho,IIF(aReturn[4]==1,GetMv("MV_COMP"),GetMv("MV_NORM")))
				Endif
				If ETQ->BA1_CODEMP <> "0000"
					@ ++nLin, 00 pSay "Empresa : "+ETQ->BA1_CODEMP+" - "+trim(ETQ->EMPRESA)+" - "+BQC->BQC_NUMCON+" - "+BQC->BQC_SUBCON+" - "+BQC->BQC_DESCRI
				Else
					@ ++nLin, 00 pSay BQC->BQC_DESCRI
				EndIf
				nLin++
				cEmpAnt := ETQ->BA1_CODEMP
			EndIf
			
			//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
			//ณ Conforme solicitado pelo usuario, imprimir linha a cada familia.    ณ
			//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
			If cFamAnt <> ETQ->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC)   //Substr(ETQ->TMP_CODUSR,1,14)
				@ ++nLin, 00 pSay Replicate("-",50)
				cFamAnt := ETQ->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC)   //Substr(ETQ->TMP_CODUSR,1,14)
				nLin++
			Endif
			
			nPos := aScan(aResumo,{|x|x[1]== ETQ->BA1_CODEMP} )
			
			If nPos == 0
				aadd(aResumo,{ETQ->BA1_CODEMP,BQC->BQC_DESCRI,0} )
				nPos := Len(aResumo)
			EndIf
			
			cEstCob := ""
			If  !Empty(MV_PAR01) .and. !Empty(MV_PAR02)   //lote de arquivo a ser impresso
				Do Case
				Case ETQ->BED_FATUR == "0"
					cEstCob := "Nao Faturado"
				Case ETQ->BED_FATUR == "1"
					cEstCob := "Faturado"
				Case ETQ->BED_FATUR == "2"
					cEstCob := "Titulo em Aberto"
				Case ETQ->BED_FATUR == "3"
					cEstCob := "Titulo Baixado"
				EndCase
			EndIf
			
			aResumo[nPos,3]++
			If nLin > nQtdLin
				nLin := cabec(cTitulo,cCabec1,cCabec2,cNomeProg,cTamanho,IIF(aReturn[4]==1,GetMv("MV_COMP"),GetMv("MV_NORM")))
			Endif
			
			// Agregados Itau - Motta 28/09/09
			If ETQ->BA1_CODEMP == "0006" .AND. ETQ->BA1_CODPLA $ "0014,0015,0016,0017"
				BA1->(DbSetOrder(6))
				BA1->(DbSeek(xFilial("BA1")+SUBSTR(ALLTRIM(ETQ->BA1_MATEMP),1,9)+"00")) //Titular do Agregado
			Else
				BA1->(DbSetOrder(2))
				BA1->(DbSeek(xFilial("BA1")+ETQ->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC)+"00"))
			Endif
			
			if Empty(alltrim(BA1->BA1_YNMSOC))
				cNomTit := BA1->BA1_NOMUSR
			else 
				cNomTit := BA1->BA1_YNMSOC
			endif 
			If nTipEnd != 1     // em ordem de endereco residencial
				cLotac    := SUBSTR(ETQ->BA1_YLOTAC,1,20)
				cFunci    := SUBSTR(ETQ->BA1_MATEMP,1,9)
			Endif
			
			//BIANCHINI - 26/08/2014 - APARECER FUNCIONAL QDO FOR ESTAS EMPRESAS
			//If (cEmpAntORI == '02' .and. ETQ->BA1_CODEMP $ GetMv("MV_CARCOFU"))
			// Roberto Meirelles - 11/08/15 - Ajuste para considerar as empresas do estaleiro na CABERJ
			//If (cEmpAntORI == '01' .and. ETQ->BA1_CODEMP $ GetMv("MV_CARCOFU"))
			//BIANCHINI - 26/07/2019 - APARECER FUNCIONAL QDO FOR ESTAS EMPRESAS
			If ETQ->BA1_CODEMP $ GetMv("MV_CARCOFU")
				cFunci    := PADL(TRIM(ETQ->BA3_MATEMP),9,'0')
			Endif
			
			If nTipEnd == 1     // em ordem de endereco residencial
				//BIANCHINI - 26/08/2014 - APARECER FUNCIONAL QDO FOR ESTAS EMPRESAS
				//@ ++nLin, 00 pSay ETQ->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG+BA1_DIGITO)+"  "+PadR(ETQ->BA1_NOMUSR,40)+"  "+PadR(cNomTit,40)+"  "+DtoC(ETQ->BTS_DATNAS)+"  "+DtoC(ETQ->BED_DATVAL)+"  "+DtoC(ETQ->BED_DTSOLI)+"  "+ETQ->BED_CDIDEN+"  "+StrZero(ETQ->BED_VIACAR,2)+"  "+cEstCob + If(cEmpAntORI == '02' .and. ETQ->BA1_CODEMP $ GetMv("MV_CARCOFU"),"  "+cFunci,'')
				// Roberto Meirelles - 11/08/15 - Ajuste para considerar as empresas do estaleiro na CABERJ
				if Empty(alltrim(BA1->BA1_YNMSOC))
					@ ++nLin, 00 pSay ETQ->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG+BA1_DIGITO)+"  "+PadR(ETQ->BA1_NOMUSR,40)+"  "+PadR(cNomTit,40)+"  "+DtoC(ETQ->BTS_DATNAS)+"  "+DtoC(ETQ->BED_DATVAL)+"  "+DtoC(ETQ->BED_DTSOLI)+"  "+ETQ->BED_CDIDEN+"  "+StrZero(ETQ->BED_VIACAR,2)+"  "+cEstCob + If(cEmpAntORI == '01' .and. ETQ->BA1_CODEMP $ GetMv("MV_CARCOFU"),"  "+cFunci,'')
				else
					@ ++nLin, 00 pSay ETQ->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG+BA1_DIGITO)+"  "+PadR(ETQ->BA1_YNMSOC,40)+"  "+PadR(cNomTit,40)+"  "+DtoC(ETQ->BTS_DATNAS)+"  "+DtoC(ETQ->BED_DATVAL)+"  "+DtoC(ETQ->BED_DTSOLI)+"  "+ETQ->BED_CDIDEN+"  "+StrZero(ETQ->BED_VIACAR,2)+"  "+cEstCob + If(cEmpAntORI == '01' .and. ETQ->BA1_CODEMP $ GetMv("MV_CARCOFU"),"  "+cFunci,'')
				endif 
			Else
				if Empty(alltrim(BA1->BA1_YNMSOC))
					@ ++nLin, 00 pSay ETQ->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG+BA1_DIGITO)+"  "+PadR(ETQ->BA1_NOMUSR,40)+"  "+PadR(cNomTit,40)+"  "+DtoC(ETQ->BTS_DATNAS)+"  "+DtoC(ETQ->BED_DATVAL)+"  "+DtoC(ETQ->BED_DTSOLI)+"  "+ETQ->BED_CDIDEN+"  "+StrZero(ETQ->BED_VIACAR,2)+"  "+cEstCob+"  "+cLotac+"  "+cFunci
				else
					@ ++nLin, 00 pSay ETQ->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG+BA1_DIGITO)+"  "+PadR(ETQ->BA1_YNMSOC,40)+"  "+PadR(cNomTit,40)+"  "+DtoC(ETQ->BTS_DATNAS)+"  "+DtoC(ETQ->BED_DATVAL)+"  "+DtoC(ETQ->BED_DTSOLI)+"  "+ETQ->BED_CDIDEN+"  "+StrZero(ETQ->BED_VIACAR,2)+"  "+cEstCob+"  "+cLotac+"  "+cFunci 
				endif 
			Endif
			
			cConAnt   := ETQ->BA1_CONEMP
			cSubAnt   := ETQ->BA1_SUBCON
			nTotSub++
			ETQ->(DbSkip())
			//	If cEmpAnt # ETQ->BA1_CODEMP .OR. cConAnt # ETQ->BA1_CONEMP .or. cSubAnt # ETQ->BA1_SUBCON
			If cEmpAnt + cConAnt + cSubAnt <> ETQ->(BA1_CODEMP + BA1_CONEMP + BA1_SUBCON)
				@ ++nLin, 00 pSay Space(20)+"Total de carteirinhas emitidas deste SubContrato  ("+cConAnt+"/"+cSubAnt+") => "+Str(nTotSub,4)
				If  mv_par28 == 1
					nLin := 99
				Else
					nLin++
				Endif
				nTotSub := 0
			EndIf
			
		EndDo
		
		nLin := nQtdLin+10
		cCabec1 := Space(40)+PadC("Total de carteirinhas emitidas por empresa",50)
		cCabec2 := ""
		nTotal := 0
		
		For nI := 1 to Len(aResumo)
			If nLin > nQtdLin
				nLin := cabec(cTitulo,cCabec1,cCabec2,cNomeProg,cTamanho,IIF(aReturn[4]==1,GetMv("MV_COMP"),GetMv("MV_NORM")))
			Endif
			@ ++nLin, 00 pSay Space(40)+aResumo[nI,1]+" "+aResumo[nI,2]+" "+Str(aResumo[nI,3],4)
			nTotal+=aResumo[nI,3]
		Next
		
		nLin++
		If nLin > nQtdLin
			nLin := cabec(cTitulo,cCabec1,cCabec2,cNomeProg,cTamanho,IIF(aReturn[4]==1,GetMv("MV_COMP"),GetMv("MV_NORM")))
		Endif
		@ ++nLin, 00 pSay Space(40)+PadR("       Total de carteirinhas emitidas ",46)+Str(nTotal,4)
		
	Else
		//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
		//ณ Faz manualmente porque nao chama a funcao Cabec()                 ณ
		//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
		//setPrc( pRow(),pCol())
		If nNumCol > 2							// Matriculas digitadas
			@ pRow(),pCol() Psay AvalImp(132)
		Else
			@ pRow(),pCol() Psay AvalImp(80)
		EndIf
		If cTipImp = 2
			nLin := pRow() + 2
		EndIf
		
		While ! ETQ->(Eof())
			IncRegua()
			
			nColuna := 0
			I       := 1
			J       := 0
			//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
			//ณ Verifica se foi abortada a impressao...                            ณ
			//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
			If Interrupcao(lAbortPrint)
				nLin ++
				@ nLin, nColuna pSay PLSTR0002
				Exit
			Endif
			//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
			//ณ Monta array com etiquetas...           								ณ
			//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
		//	Lin := Array(5,3)  altamiro em 15/04/21
			Lin := Array(7,3)
			
			//--------------------------------------------------------
			//INICIO - Angelo Henrique - Data:21/10/2015
			//Valida็๕es para op็๕es de localidade
			//--------------------------------------------------------
			If _nLocal == 1 .And. _cAgenc == "06"
				
				If UPPER(AllTrim(ETQ->BA1_MUNICI)) = "RIO DE JANEIRO"
					
					If UPPER(AllTrim(ETQ->BA1_BAIRRO)) $ "TIJUCA|RIO COMPRIDO|MARACANA|GRAJAU|PRACA DA BANDEIRA|SAO CRISTOVAO|CENTRO|FLAMENGO|LAPA|SANTO CRISTO|GLORIA|BANGU|CAMPO GRANDE|COPACABANA|IPANEMA|LEBLON|LEME|BOTAFOGO"
						
						ETQ->(DbSkip())
						Loop
						
					EndIf
					
				ElseIf UPPER(AllTrim(ETQ->BA1_MUNICI)) = "NITEROI"
					
					If UPPER(AllTrim(ETQ->BA1_BAIRRO)) $ "CENTRO|SANTA ROSA|ICARAI|BARRETO|FONSECA|SAO DOMINGOS|INGA"
						
						ETQ->(DbSkip())
						Loop
						
					EndIf
					
				EndIf
				
			EndIf
			//--------------------------------------------------------
			// FIM    - Angelo Henrique - Data:21/10/2015
			//--------------------------------------------------------
			
			
			While I <= MV_PAR06  .And. ! ETQ->(Eof())
				
				cMatric := ETQ->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC)
				
				If lSomTit //Isso filtrarแ caso nใo seja solicitado a emissใo de lotes
					nPos := aScan(aResumo,{|x|x[1] == ETQ->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC)} )
					
					If nPos == 0
						aadd(aResumo,{ETQ->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC)} )
						lImprime := .T.
					Else
						lImprime := .F.
					EndIf
				EndIf
				
				If lImprime
					
					//    BTS_CEPUSR, BTS_ENDERE, BTS_NR_END, BTS_COMEND, BTS_BAIRRO, BTS_ESTADO
					//		BA1_CODINT, BA1_CODEMP, BA1_MATRIC, "
					
					cNomTit := space(42)
					
					BA1->(DbSetOrder(2))
					BA1->(DbSeek(xFilial("BA1")+ETQ->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+"00")))
					
					if Empty(alltrim(BA1->BA1_YNMSOC))
						cNomTit := Alltrim(Substr(BA1->BA1_NOMUSR,1,42) )
					else 
						cNomTit := Alltrim(Substr(BA1->BA1_YNMSOC,1,42) )
					endif
					 
					cCodigo  := ETQ->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG+BA1_DIGITO)
					
					cNome    := Alltrim( SubStr(ETQ->BA1_NOMUSR,1,42) )
					
					cEndere  := Alltrim( SubStr(ETQ->BTS_ENDERE,1,37) ) + " " + Alltrim( SubStr(ETQ->BTS_NR_END,1,5) )
					cCompl   := Alltrim(ETQ->BTS_COMEND)
					cBairro  := AllTrim(ETQ->BTS_BAIRRO)
					cMunici  := AllTrim(ETQ->BTS_MUNICI)
					cEstado  := Alltrim(ETQ->BTS_ESTADO)
					cCep     := Substr(ETQ->BTS_CEPUSR,1,5)+"-"+Substr(ETQ->BTS_CEPUSR,6,3)
					If nUtilEnd = 2
						//				// Posiciona o usuario na tabela BA1
						//				BA1->( DbGoTo(ETQ->R_E_C_N_O_) )
						//				cEndere  := Alltrim( SubStr(BA1->BA1_ENDERE,1,37) ) + " " + Alltrim( SubStr(BA1->BA1_NR_END,1,5) )
						//				cCompl   := Alltrim(BA1->BA1_COMEND)
						//				cBairro  := AllTrim(BA1->BA1_BAIRRO)
						//				cMunici  := AllTrim(BA1->BA1_MUNICI)
						//				cEstado  := Alltrim(BA1->BA1_ESTADO)
						//				cCep     := Substr(BA1->BA1_CEPUSR,1,5)+"-"+Substr(BA1->BA1_CEPUSR,6,3)
						
						cEndere  := Alltrim( SubStr(ETQ->BA1_ENDERE,1,37) ) + " " + Alltrim( SubStr(ETQ->BA1_NR_END,1,5) )
						cCompl   := Alltrim(ETQ->BA1_COMEND)
						cBairro  := AllTrim(ETQ->BA1_BAIRRO)
						cMunici  := AllTrim(ETQ->BA1_MUNICI)
						cEstado  := Alltrim(ETQ->BA1_ESTADO)
						cCep     := Substr(ETQ->BA1_CEPUSR,1,5)+"-"+Substr(ETQ->BA1_CEPUSR,6,3)
					EndIf
					//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
					//ณ Monto array com dados da etiqueta ...                                              ณ
					//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
					//BIANCHINI - IMPRIMIR FUNCIONAL NA ETIQUETA SE FOR ESTALEIRO (INTEGRAL) 15/08/2014
					// Roberto Meirelles - 11/08/15 - Ajuste para considerar as empresas do estaleiro na CABERJ
					//IF (cEmpAntORI == '02' .and. ETQ->BA1_CODEMP $ GetMv("MV_CARCOFU"))
					//IF (cEmpAntORI == '01' .and. ETQ->BA1_CODEMP $ GetMv("MV_CARCOFU"))
					//BIANCHINI - 26/07/2019 - Empresas com Funcional
					
					Lin[1,I] := ' '
					Lin[2,I] := ' '  
					

					IF ETQ->BA1_CODEMP $ GetMv("MV_CARCOFU")	
						Lin[3,I] := cCodigo+" / "+PADL(TRIM(ETQ->BA3_MATEMP),9,'0')
					else
						Lin[3,I] := cCodigo
					Endif
					If !Empty(Alltrim(cNomTit)) .and. cNomEtq == 1
						Lin[4,I] := cNomTit   //"Titular: "+cNomTit
					Else
						Lin[4,I] := cNome
					EndIf
					Lin[5,I] := cEndere
					Lin[6,I] := Iif(Empty(AllTrim(cCompl)),cBairro,cCompl+" - "+cBairro)
					Lin[7,I] := cMunici+"-"+cEstado+"  CEP:" +cCep

				/*
				    // ajuste do array de impressao de 5 para 8 linhas altamiro em 15/04/21
					IF ETQ->BA1_CODEMP $ GetMv("MV_CARCOFU")	
						Lin[1,I] := cCodigo+" / "+PADL(TRIM(ETQ->BA3_MATEMP),9,'0')
					else
						Lin[1,I] := cCodigo
					Endif
					If !Empty(Alltrim(cNomTit)) .and. cNomEtq == 1
						Lin[2,I] := cNomTit   //"Titular: "+cNomTit
					Else
						Lin[2,I] := cNome
					EndIf
					Lin[3,I] := cEndere
					Lin[4,I] := Iif(Empty(AllTrim(cCompl)),cBairro,cCompl+" - "+cBairro)
					Lin[5,I] := cMunici+"-"+cEstado+"  CEP:" +cCep
	                
				*/



					If nTipEnd == 2  .and. Alltrim(ETQ->BA1_YLOTAC) != replicate("0", len(alltrim(ETQ->BA1_YLOTAC)))
						//			BA1->( DbGoTo(ETQ->R_E_C_N_O_) )
						cEndere  := ""
						cCompl   := ""
						cBairro  := ""
						cMunici  := ""
						cEstado  := ""
						cCep     := ""
						//			cEndere  := ETQ->BA1_YLOTAC
						//			cCompl   := ETQ->BA1_YNOMLO
						
						BA3->(DbSetOrder(1))
						BA3->(DbSeek(xFilial("BA3")+ETQ->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC)))
						/*
						Lin[3,I] := "Funcional: "+BA3->BA3_MATEMP
						Lin[4,I] := alltrim(ETQ->BA1_YLOTAC)
						Lin[5,I] := Alltrim(ETQ->BA1_YNOMLO) */

						Lin[5,I] := "Funcional: "+BA3->BA3_MATEMP
						Lin[6,I] := alltrim(ETQ->BA1_YLOTAC)
						Lin[7,I] := Alltrim(ETQ->BA1_YNOMLO) 
					EndIf
					
					//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
					//ณ Monto array com dados da etiqueta ...                                              ณ
					//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
					//		Lin[1,I] := cCodigo
					//		Lin[2,I] := cNome
					//		Lin[3,I] := cEndere
					//		Lin[4,I] := IiF(nTipEnd==1 .and. Alltrim(ETQ->BA1_YLOTAC) == replicate("0", len(alltrim(ETQ->BA1_YLOTAC))),Iif(Empty(AllTrim(cCompl)),cBairro,cCompl+" - "+cBairro),cCompl)
					//		Lin[5,I] := IiF(nTipEnd==1 .and. Alltrim(ETQ->BA1_YLOTAC) == replicate("0", len(alltrim(ETQ->BA1_YLOTAC))),cMunici+"-"+cEstado+"  CEP:" +cCep,"")
					
					I += 1
					If ETQ->(Eof())
						I = 3 + 1
					Endif
				EndIf
				
				ETQ->( DbSkip() )
				
				If cMatric != ETQ->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC)
					aResumo := {}
				EndIf
			Enddo
			
			I := 0
			For J := 1 to 7
				For I := nPosCol TO MV_PAR06   //3  Colunas
					nColuna := (I-1) * 45  //68 //73  // Posiciona as colunas
					@nLin,nColuna PSAY Lin[J,I]
				Next I
				nLin += 1
			Next J
			nQtdEtq += 1
			
			If (nQtdEtq = 3 .or. nQtdEtq = 6) //.and. cTipImp = 2)
				nLin := nLin + 1
			EndIf
			
			//If (nQtdEtq = 10 .and. cTipImp = 2)
			If nQtdEtq = 7 //10 .and. cTipImp = 2)
				nQtdEtq := 0
				eject
				nLin := pRow() + 1
			EndIf
			
			nLin += 1
		Enddo
	EndIf
	ETQ->( DbCloseArea() )
	
	Set Device To Screen
	If ( aReturn[5] = 1 )
		Set Printer To
		dbCommitAll()
		OurSpool(wnrel)
	Endif
	MS_FLUSH()
	
Return(.T.)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณAjustaSX1 บAutor  ณLuzio Tavares       บ Data ณ  13/03/08   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณCria as perguntas no SX1.                                   บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณCABERJ                                                      บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function AjustaSX1(cPerg)
	
	Local aRegs		:= {}
	
	Aadd(aRegs,{cPerg,"01","Lote de cartao de             ","","","MV_CH1","C",12,0,0,"G","","Mv_Par01","","","","","","","","","","","","","","","","","","","","","","","","","BED",""})
	Aadd(aRegs,{cPerg,"02","Lote de cartao ate            ","","","MV_CH2","C",12,0,0,"G","","Mv_Par02","","","","","","","","","","","","","","","","","","","","","","","","","BED",""})
	Aadd(aRegs,{cPerg,"03","Matricula de                  ","","","MV_CH3","C",17,0,0,"G","","Mv_Par03","","","","","","","","","","","","","","","","","","","","","","","","","",""})
	Aadd(aRegs,{cPerg,"04","Matricula ate                 ","","","MV_CH4","C",17,0,0,"G","","Mv_Par04","","","","","","","","","","","","","","","","","","","","","","","","","",""})
	Aadd(aRegs,{cPerg,"05","Digita Matriculas Manualmente ","","","MV_CH5","C",01,0,0,"C","","Mv_Par05","Sim","","","","","Nao","","","","","","","","","","","","","","","","","","","",""})
	Aadd(aRegs,{cPerg,"06","Numero de Colunas             ","","","MV_CH6","N",01,0,0,"G","","Mv_Par06","","","","","","","","","","","","","","","","","","","","","","","","","",""})
	Aadd(aRegs,{cPerg,"07","Imprime Somente Titulares     ","","","MV_CH7","C",01,0,0,"C","","Mv_Par07","Nao","","","","","Sim","","","","","","","","","","","","","","","","","","","",""})
	Aadd(aRegs,{cPerg,"08","Utiliza endereco              ","","","MV_CH8","C",01,0,0,"C","","Mv_Par08","Vida","","","","","Usuario","","","","","","","","","","","","","","","","","","","",""})
	Aadd(aRegs,{cPerg,"09","Tipo de Impressora            ","","","MV_CH9","C",01,0,0,"C","","Mv_Par09","Matricial","","","","","Laser/Jato de Tinta","","","","","","","","","","","","","","","","","","","",""})
	Aadd(aRegs,{cPerg,"10","Coluna de Inicio Impressao    ","","","MV_CHA","C",01,0,0,"C","","Mv_Par10","Primeira","","","","","Segunda","","","","","Terceira","","","","","Quarta","","","","","","","","","",""})
	
	Aadd(aRegs,{cPerg,"11","UF De                         ","","","MV_CHB","C",02,0,0,"G","","Mv_Par11","","","","","","","","","","","","","","","","","","","","","","","","","12",""})
	Aadd(aRegs,{cPerg,"12","UF Ate                        ","","","MV_CHC","C",02,0,0,"G","","Mv_Par12","","","","","","","","","","","","","","","","","","","","","","","","","12",""})
	Aadd(aRegs,{cPerg,"13","CEP de                        ","","","MV_CHD","C",08,0,0,"G","","Mv_Par13","","","","","","","","","","","","","","","","","","","","","","","","","B83PLS",""})
	Aadd(aRegs,{cPerg,"14","CEP Ate                       ","","","MV_CHE","C",08,0,0,"G","","Mv_Par14","","","","","","","","","","","","","","","","","","","","","","","","","B83PLS",""})
	Aadd(aRegs,{cPerg,"15","Grupo/Empresa De              ","","","MV_CHF","C",04,0,0,"G","","Mv_Par15","","","","","","","","","","","","","","","","","","","","","","","","","BJLPLS",""})
	Aadd(aRegs,{cPerg,"16","Grupo/Empresa Ate             ","","","MV_CHG","C",04,0,0,"G","","Mv_Par16","","","","","","","","","","","","","","","","","","","","","","","","","BJLPLS",""})
	Aadd(aRegs,{cPerg,"17","Contrato De                   ","","","MV_CHH","C",12,0,0,"G","","Mv_Par17","","","","","","","","","","","","","","","","","","","","","","","","","B7BPLS",""})
	Aadd(aRegs,{cPerg,"18","Contrato Ate                  ","","","MV_CHI","C",12,0,0,"G","","Mv_Par18","","","","","","","","","","","","","","","","","","","","","","","","","B7BPLS",""})
	Aadd(aRegs,{cPerg,"19","Sub-Contrato De               ","","","MV_CHJ","C",09,0,0,"G","","Mv_Par19","","","","","","","","","","","","","","","","","","","","","","","","","BA6PLS",""})
	Aadd(aRegs,{cPerg,"20","Sub-Contrato Ate              ","","","MV_CHK","C",09,0,0,"G","","Mv_Par20","","","","","","","","","","","","","","","","","","","","","","","","","BA6PLS",""})
	Aadd(aRegs,{cPerg,"21","Municipio De                  ","","","MV_CHL","C",08,0,0,"G","","Mv_Par21","","","","","","","","","","","","","","","","","","","","","","","","","B57PLS",""})
	Aadd(aRegs,{cPerg,"22","Municipio Ate                 ","","","MV_CHM","C",08,0,0,"G","","Mv_Par22","","","","","","","","","","","","","","","","","","","","","","","","","B57PLS",""})
	Aadd(aRegs,{cPerg,"23","Tipo de Enderecamento         ","","","MV_CHN","N",01,0,0,"C","","Mv_Par23","Endereco","","","","","Lotacao     ","","","","","","","","","","","","","","","","","","","",""})
	Aadd(aRegs,{cPerg,"24","Produto De                    ","","","MV_CHO","C",04,0,0,"G","","Mv_Par24","","","","","","","","","           ","","","","","","","","","","","","","","","","B57PLS",""})
	Aadd(aRegs,{cPerg,"25","produto Ate                   ","","","MV_CHP","C",04,0,0,"G","","Mv_Par25","","","","","","","","","           ","","","","","","","","","","","","","","","","B57PLS",""})
	Aadd(aRegs,{cPerg,"26","Nome a ser Impresso           ","","","MV_CHQ","N",01,0,0,"C","","Mv_Par26","Titular ","","","","","Beneficiario","","","","","","","","","","","","","","","","","","","",""})
	
	aadd(aRegs,{cPerg,"27","Tipo                          ","","","MV_CHR","N", 1,0,2,"C","","mv_par27","Relatorio","","","","","Etiqueta","","","","",""               ,"","","","",""       			  ,"","","","","","","","",""   	,""})
	aadd(aRegs,{cPerg,"28","Salta Pag. Subcontrato        ","","","MV_CHS","N", 1,0,2,"C","","mv_par28","Sim","","","","","Nao","","","","",""               ,"","","","",""       			  ,"","","","","","","","",""   	,""})
	aadd(aRegs,{cPerg,"29","Ordenar por                   ","","","MV_CHT","N", 1,0,0,"C","","mv_par29","Nome Usuario","","","","","Cod. Usuario","","","","","Lote Gerado","","","","","Matricula","","","","","Funcional","","","",""   	,""})
	
	//--------------------------------------------------------------------------------------
	//Angelo Henrique - Data: 21/10/2015 - Mudan็a para acompanhar a gera็ใo em lote
	//--------------------------------------------------------------------------------------
	
	Aadd(aRegs,{cPerg,"30","Utiliza Agencia               ","","","MV_CHU","C",01,0,0,"C","","MV_PAR30","Sim","","","","","Nao","","","","","","","","","","","","","","","","","","","",""})
	Aadd(aRegs,{cPerg,"31","Agencia                       ","","","MV_CHV","C",02,0,0,"G","","Mv_Par31","","","","","","","","","           ","","","","","","","","","","","","","","","","CABRZX",""})
	
	//--------------------------------------------------------------------------------------
	
	//aadd(aRegs,{cPerg,"26 ","Operadora Destino ?         ","","","mv_chQ","C", 4,0,0,"G","","mv_par26","","","","","","","","","","","","","","","","","","","","","","","","","","B89PLS"})
	//Aadd(aRegs,{cPerg,"24","         ","","","MV_CHO","N",01,0,0,"C","","Mv_Par24","Endereco","","","","","Lotacao","","","","","","","","","","","","","","","","","","","",""})
	
	PlsVldPerg( aRegs )
	
Return(.T.)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCABR004MatrบAutor  ณLuzio Tavares      บ Data ณ  13/03/08   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณInforma as matriculas manualmente para impressao de etiquetaบฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CABERJ                                                     บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function CABR004Matr()
	
	Local aSaveArea := GetArea()
	Local oDlg
	Local oLbx
	Local aNumRec := {}
	Local oMatric
	Local cMatric := CriaVar("BA1_MATANT")   //BA1_CODINT"+"BA1_CODEMP"+"BA1_MATRIC"+"BA1_TIPREG"+"BA1_DIGITO", .F.)
	//Alert(cMatric)
	//Local oCodInt
	//Local cCodInt	:= PLSIntPad()
	//Local oCodEmp
	//Local cCodEmp	:= CriaVar("BA1_CODEMP", .F.)
	//Local oMatric
	//Local cMatric	:= CriaVar("BA1_MATRIC", .F.)
	//Local oTipReg
	//Local cTipReg	:= CriaVar("BA1_TIPREG", .F.)
	//Local oDigito
	//Local cDigito	:= CriaVar("BA1_DIGITO", .F.)
	
	Aadd( aNumRec, {"", "", 0} )
	
	DEFINE MSDIALOG oDlg TITLE "Usuแrios para emissใo de etiquetas." FROM 0,0 TO 320,620 PIXEL
	
	EnchoiceBar(oDlg, {|| oDlg:End() }, {|| (aNumRec:={},oDlg:End()) } )
	
	@ 018,005 SAY "Matricula" OF oDlg PIXEL
	@ 018,030 MSGET oMatric VAR cMatric OF oDlg SIZE 100,09 PIXEL WHEN .T. PICTURE "@!" VALID VALMAT(oLbx, oMatric, cMatric) F3 "B92PLS"
	//	@ 018,030 GET oCodInt VAR cCodInt OF oDlg SIZE 25,09 PIXEL WHEN .T. PICTURE "@!"
	//	@ 018,060 GET oCodEmp VAR cCodEmp OF oDlg SIZE 25,09 PIXEL WHEN .T. PICTURE "@!"
	//	@ 018,090 GET oMatric VAR cMatric OF oDlg SIZE 40,09 PIXEL WHEN .T. PICTURE "@!"
	//	@ 018,135 GET oTipReg VAR cTipReg OF oDlg SIZE 15,09 PIXEL WHEN .T. PICTURE "@!"
	//	@ 018,155 GET oDigito VAR cDigito OF oDlg SIZE 10,09 PIXEL WHEN .T. PICTURE "@!" VALID VALMAT(oLbx, oCodInt, cCodInt, cCodEmp, cMatric, cTipReg, cDigito)
	
	@ 035,005 LISTBOX oLbx FIELDS HEADER "Matricula", "Nome do Usuแrio", "Record" SIZE 300, 120 NOSCROLL OF oDlg PIXEL
	oLbx:SetArray(aNumRec)
	oLbx:bLine:={||{ aNumRec[oLbx:nAt,01], aNumRec[oLbx:nAt,02], aNumRec[oLbx:nAt,03] }}
	oLbx:nAt := 1
	oLbx:aColSizes := {70, 170, 30}
	oLbx:BLDBLCLICK := { || CABR004Excl(oLbx) }
	
	ACTIVATE MSDIALOG oDlg CENTERED
	
Return(aNumRec)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCVALMAT   บAutor  ณLuzio Tavares       บ Data ณ  13/03/08   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณValida se a matricula existe e adiciona na lista.           บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CABERJ                                                     บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
//Static Function VALMAT(oLbx, oCodInt, cCodInt, cCodEmp, cMatric, cTipReg, cDigito)
Static Function VALMAT(oLbx, oMatric, cMatric)
	
	BA1->( DbSetOrder(2) )		// BA1_FILIAL + BA1_CODINT + BA1_CODEMP + BA1_MATRIC + BA1_TIPREG + BA1_DIGITO
	//If BA1->( !MsSeek( xFilial("BA1")+cCodInt+cCodEmp+cMatric+cTipReg+cDigito ) )
	If BA1->( !MsSeek( xFilial("BA1")+cMatric ) )
		BA1->( DbSetOrder(5) )		// BA1_FILIAL + BA1_MATANT + BA1_TIPANT
		//	If BA1->( !MsSeek( xFilial("BA1")+cCodInt+cCodEmp+cMatric+cTipReg+cDigito ) )
		If BA1->( !MsSeek( xFilial("BA1")+cMatric ) )
			MsgStop("Matricula informada nใo cadastrada...")
			//		oCodInt:SetFocus()
			oMatric:SetFocus()
		Endif
	Endif
	
	If BA1->( Found() )
		If !Empty( oLbx:AARRAY[1][1] )
			Aadd( oLbx:AARRAY, {"", "", 0} )
		Endif
		
		oLbx:AARRAY[Len(oLbx:AARRAY)][1] :=	BA1->BA1_CODINT + "." +;
			BA1->BA1_CODEMP + "." +;
			BA1->BA1_MATRIC + "." +;
			BA1->BA1_TIPREG + "-" +;
			BA1->BA1_DIGITO
		oLbx:AARRAY[Len(oLbx:AARRAY)][2] :=	iif(Empty(Alltrim(BA1->BA1_YNMSOC)),BA1->BA1_NOMUSR,BA1->BA1_YNMSOC)
		oLbx:AARRAY[Len(oLbx:AARRAY)][3] :=	BA1->( RecNo() )
		
		oLbx:nAt := 1
		oLbx:Refresh()
		//	oCodInt:SetFocus()
		oMatric:SetFocus()
	Endif
	
Return(.T.)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCABR004ExclบAutor  ณLuzio Tavares      บ Data ณ  13/03/08   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณExclui a linha selecionada na lista de matriculas digitadas บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ PLS                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function CABR004Excl(oLbx)
	
	Local aArray := Aclone( oLbx:AARRAY )
	
	If MsgYesNo("Deseja excluir este usuแrio ?")
		If Len(aArray) > 0
			Adel(aArray, oLbx:nAt) // deleta o item
			Asize(aArray, Len(aArray) - 1) //redimensiona o array
		Endif
	Endif
	
	If Len(aArray) == 0
		Aadd( aArray, {"", "", 0} )
	Endif
	
	oLbx:AARRAY := Aclone( aArray )
	oLbx:Refresh()
	
Return(.T.)

