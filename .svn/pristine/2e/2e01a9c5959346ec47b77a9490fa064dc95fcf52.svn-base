#INCLUDE "PROTHEUS.CH"
#INCLUDE "PLSMGER.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABR004   ºAutor  ³Luzio Tavares       º Data ³  13/03/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±   
±±ºDesc.     ³Emissao de Etiquetas por lote de cartao de identificacao emiº±±
±±º          ³tidos.                                                      º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³CABERJ                                                      º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/                                                 
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define nome da funcao                                                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
User Function CABR004A()
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define variaveis padroes para todos os relatorios...                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Private nQtdLin   	:= 55
Private wnrel   	:= "CABR004A" //"CABR004" //Leonardo Portella - 07/12/11 
Private cTitulo 	:= "Etiquetas AVULSAS"
Private cDesc1 		:= "Emissão Etiquetas AVULSAS"
Private cDesc2 		:= ""
Private cDesc3 		:= ""
Private cString 	:= "BA1"	      			// Alias utilizado na Filtragem
Private lDic    	:= .F. 			   		// Habilita/Desabilita Dicionario
Private lComp   	:= .F. 				   	// Habilita/Desabilita o Formato Comprimido/Expandido
Private lFiltro 	:= .F.    					// Habilita/Desabilita o Filtro
Private cCabec1   	:= ""
Private cCabec2   	:= ""
Private cNomeProg	:= "CABR004A.PRW"	   	// nome do programa
Private cTamanho  	:= "P"				   	// P/M/G
Private Limite    	:= 80  //132 //220	    		// 80/132/220
Private nTipo     	:= 18

Private aReturn := { "Zebrado",;	    	//[1] Reservado para Formulario
1,;		   		//[2] Reservado para N§ de Vias
"Administração",;	//[3] Destinatario
2,;			   	//[4] Formato => 1-Comprimido 2-Normal
1,;	    	   	//[5] Midia   => 1-Disco 2-Impressora
1,;			   	//[6] Porta ou Arquivo 1-LPT1... 4-COM1...
"",;			   	//[7] Expressao do Filtro
1 } 			   	//[8] Ordem a ser selecionada
//							[9]..[10]..[n]    //Campos a Processar (se houver)

Private m_pag   := 1							// Contador de Paginas
Private nLastKey:= 0							// Controla o cancelamento da SetPrint e SetDefault
Private cPerg   := "CAR004A"	         // Pergunta do Relatorio
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
Private aImprimir   := {} //Leonardo Portella - 06/06/11
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas selecionadas                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
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

wnrel := SetPrint(cString,wnrel,cPerg,@cTitulo,cDesc1,cDesc2,cDesc3,lDic,aOrdem,lComp,cTamanho,lFiltro)

If (nLastKey == 27)
	DbSelectArea(cString)
	DbSetOrder(1)
	DbClearFilter()
	Return
Endif

/*
aArray - Array aReturn, preenchido pelo SetPrint
[1] Reservado para Formulário
[2] Reservado para Nº de Vias
[3] Destinatário
[4] Formato => 1-Comprimido 2-Normal
[5] Mídia => 1-Disco 2-Impressora
[6] Porta ou Arquivo 1-LPT1... 4-COM1...
[7] Expressão do Filtro
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

Return(.T.)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³R333Imp   ºAutor  ³Luzio Tavares       º Data ³  13/03/08   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Imprime as etiquetas                                        º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³CABERJ                                                      º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function R333Imp(lEnd,wnrel,cString,cNomeprog,cTitulo,cCabec1,cCabec2)

Local nI 	:= 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS
Local nK 	:= 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS
Local nJ 	:= 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS
Local n 	:= 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define variaveis...                                                      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local cSQL		:= ""
//Local nOrdSel   := aReturn[8]
Local I         := 1
Local J         := 0
Local Lin       := Array(5,3)
Local aLinha    := {}
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
Local	cNomTit   := space(42)
Local cNome     := Space(42)
Local aResumo   := {}
Local aMatTit   := {}
Local lImprime  := .T.
Local nTotSub   := 0
Local nTotal	:= 0

Local cNomlot := Space(0)
Local cEndere := Space(0)
Local cCidade := space(0)
Local cEstado := Space(0)                                                      

Private I:= 1

If Mv_Par05 == 1		// Matriculas digitadas
	aRecNum := CABR004Matr()
	For I := 1 To Len(aRecNum)
		cRecNum += AllTrim(Str(aRecNum[I][3])) + IIF(I<>Len(aRecNum),",","")
	Next
	
Endif

If mv_par27 == 1
	Limite     := 132
	cTamanho   := "G"
	cCabec1 := "Codigo do Usuario   Nome do Usuario                          Nome Titular                              Nascimento  Validade   Dt.Solic.  Lote         Via  Estado da Cobranca"
	cCabec2 := ""
Else
	cCabec1 := ""
	cCabec2 := ""
	If Mv_Par06 > 2							// Matriculas digitadas
		cTamanho := "M"				   	// P/M/G
		Limite  := 132               	// 80/132/220
	EndIf
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Faz filtro no arquivo...                                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

cSQL  := space(0)
cSQL1 := space(0)
cSQL2 := space(0)
cSQL3 := space(0)

If Empty(cRecNum) .and. (!Empty(MV_PAR01) .Or. !Empty(MV_PAR02) .Or. !Empty(MV_PAR03) .Or. !Empty(MV_PAR04) .Or. !Empty(cGrupoDe) .Or. !Empty(cContrDe) .Or. !Empty(cSubConDe) .Or. !Empty(cGrupoAte) .Or. !Empty(cContrAte) .Or. !Empty(cSubConAte))
	cSQL1 := "SELECT BA1.R_E_C_N_O_, BA1_CODINT, BA1_CODEMP, BA1_CONEMP, BA1_VERCON, BA1_SUBCON, BA1_VERSUB, BA1_MATRIC, BA1_TIPREG, BA1_DIGITO, BA1_NOMUSR, "
	cSQL1 += "BA1_YLOTAC, BA1_YNOMLO, BA1_ENDERE, BA1_NR_END, BA1_COMEND, BA1_BAIRRO, BA1_ESTADO, BA1_MUNICI, BA1_CEPUSR, "
	cSql1 += "DECODE(Trim(BA1_CODPLA),NULL,BA3_CODPLA,BA1_CODPLA) AS BA1_CODPLA, BA1_MATEMP, BA3_MATEMP, "
	cSQL1 += "BTS_CEPUSR, BTS_ENDERE, BTS_NR_END, BTS_COMEND, BTS_BAIRRO, BTS_ESTADO, BTS_MUNICI, BTS_DATNAS  "

	
	cSQL3 := "FROM " + RetSQLName("BA1")+" BA1, "+RetSQLName("BTS")+" BTS, "+RetSQLName("BA3")+" BA3 "
	If nTipEnd == 2      // Por Lotacao
		//***** Aqui vou procurar pelo titular da funcional para apresentar o nome
		cSql1 += ", BQC.BQC_YCDCON "
		cSql3 += ", "+RetSQLName("BQC")+" BQC "
	EndIf
	cSQL += "WHERE	"
	If  !Empty(MV_PAR01) .and. !Empty(MV_PAR02)   //lote de arquivo a ser impresso
		
		cSQL2 := " ,BED_CDIDEN, BED_FILIAL, BED_DATVAL, BED_VIACAR, BED_DATVAL, BED_DTSOLI, BED_FATUR, BED.R_E_C_N_O_ AS RECNOBED "
		
		cSQL3 += ","+ RetSQLName("BED")+" BED "
		cSQL += "BED.BED_FILIAL = '" + xFilial("BED") + "' AND "
		cSQL += "BED.BED_CDIDEN BETWEEN '" + Mv_Par01 + "' AND '" + Mv_Par02 + "' AND "
		cSql += "BA1.BA1_CODINT = BED.BED_CODINT AND "
		cSql += "BA1.BA1_CODEMP = BED.BED_CODEMP AND "
		cSql += "BA1.BA1_MATRIC = BED.BED_MATRIC AND "
		cSql += "BA1.BA1_TIPREG = BED.BED_TIPREG AND "
		cSql += "BA1.BA1_DIGITO = BED.BED_DIGITO AND "
		//		cSQL += "BTS.BTS_FILIAL = '" + xFilial("BTS") + "' AND "
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
	
	If nTipEnd == 2     // Por Lotacao
		cSQL += "BQC.BQC_FILIAL = '" + xFilial("BQC") + "' AND "
		cSQL += "BQC.BQC_CODINT = BA1.BA1_CODINT AND "
		cSQL += "BQC.BQC_CODEMP = BA1.BA1_CODEMP AND "
		cSQL += "BQC.BQC_NUMCON = BA1.BA1_CONEMP AND "
		cSQL += "BQC.BQC_VERCON = BA1.BA1_VERCON AND "
		cSQL += "BQC.BQC_SUBCON = BA1.BA1_SUBCON AND "
		cSQL += "BQC.BQC_VERSUB = BA1.BA1_VERSUB AND "
		cSql +=	"BQC.D_E_L_E_T_ = ' ' AND "
	EndIf
	
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
			cSql += "BA1.BTS_MUNICI BETWEEN '" + cCodMunDe + "' AND '" + cCodMunAte + "' AND "
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
cSQL := ""
	If lTemUnion
		cSQL += "SELECT "
	Else
		cSQL := "SELECT "
	EndIf
	cSQL += "BA1.R_E_C_N_O_ , BA1_CODINT, BA1_CODEMP, BA1_CONEMP, BA1_VERCON, BA1_SUBCON, BA1_VERSUB, BA1_MATRIC, BA1_TIPREG, BA1_DIGITO, BA1_NOMUSR, "
	cSQL += "BA1_YLOTAC, BA1_YNOMLO, BA1_ENDERE, BA1_NR_END, BA1_COMEND, BA1_BAIRRO, BA1_ESTADO, BA1_MUNICI, BA1_CEPUSR, "
	cSql += "DECODE(Trim(BA1_CODPLA),NULL,BA3_CODPLA,BA1_CODPLA) AS BA1_CODPLA, "
	cSQL += "BTS_CEPUSR, BTS_ENDERE, BTS_NR_END, BTS_COMEND, BTS_BAIRRO, BTS_ESTADO, BTS_MUNICI, BTS_DATNAS,BTS_MUNICI, BTS_DATNAS, BA3_MATEMP " 
	
	If nTipEnd == 2      // Por Lotacao
		//***** Aqui vou procurar pelo titular da funcional para apresentar o nome
		cSQL += ", ' ' BQC_YCDCON "

	EndIf
	
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
Endif

If nTipEnd == 1     // em ordem de endereco residencial
	If nOrdem == 1   // Ordem de Nome de Usuario                          
		cSql	+=	"ORDER BY BA1_NOMUSR+BA1_CODINT, BA1_CODEMP, BA1_CONEMP, BA1_VERCON, BA1_SUBCON, BA1_VERSUB, BA1_MATRIC "
	ElseIf nOrdem == 2 // Ordem de Matricula do Microsiga
		cSql	+=	"ORDER BY BA1_CODINT, BA1_CODEMP, BA1_CONEMP, BA1_VERCON, BA1_SUBCON, BA1_VERSUB, BA1_MATRIC "
	Else	   //Ordem do Lote Gerado
		If Empty(MV_PAR01) .Or. Empty(MV_PAR02)
			cSql	+=	"ORDER BY BA1_CODINT, BA1_CODEMP, BA1_CONEMP, BA1_VERCON, BA1_SUBCON, BA1_VERSUB, BA1_MATRIC "
		EndIf                            
	EndIf
Else   // Por lotacao
			//cSql	+=	"ORDER BY BA1_CODINT, BA1_CODEMP, BA1_CONEMP, BA1_VERCON, BA1_SUBCON, BA1_VERSUB, BA1_MATRIC "
	cSql +=	"ORDER BY  BA1_CODEMP, BA1_MATRIC, BA1_TIPREG " // BA3_MATEMP,
EndIf
                         
If !Empty(cRecNum)       
	memowrit("C:\CABR004.SQL",cSQL)
	
	PLSQuery(cSQL1+cSQL2+cSQL3+cSQL,"ETQ")
Else
	memowrit("C:\CABR004.SQL",cSQL1+cSQL2+cSQL3+cSQL)
	
	PLSQuery(cSQL1+cSQL2+cSQL3+cSQL,"ETQ")
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ SETA A IMPRESSORA PARA A POSICAO zero e expandido                   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//setprc(0,0)
//@000,000 PSAY Chr(18)  // Compressao de Impressao

//Leonardo Portella - 03/06/11 - Inicio

nCont := 0
ETQ->(dbEval({||++nCont}))

//SetRegua( ETQ->( RecCount() ) )
SetRegua(nCont)                

//Leonardo Portella - 03/06/11 - Fim

//@ pRow(),pCol() Psay "0....+....1....+....2....+....3....+....4....+....5....+....6....+....7....+....8....+....9....+....0....+....1....+....2....+....3....+....4....+....5....+....6"

ETQ->(DbGoTop())

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Imprime cabecalho do relatorio...                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If mv_par27 == 1
	
	c_EmpAnt := "xxxxxxxxxxxxxxxxxxx"
	
	cFamAnt := ETQ->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC)
	
	While !ETQ->(Eof())
	
		cNomTit := space(40)
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Verifica o cancelamento pelo usuario...                             ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If lAbortPrint
			@nLin,00 PSAY "*** CANCELADO PELO OPERADOR ***"
			Exit
		Endif
		
		If c_EmpAnt <> ETQ->BA1_CODEMP
	
			BQC->(DbSetorder(1))
			BQC->(DbSeek(xFilial("BQC")+ETQ->(BA1_CODINT+BA1_CODEMP+BA1_CONEMP+BA1_VERCON+BA1_SUBCON+BA1_VERSUB)))
			
			nLin := nQtdLin+10
	
			If nLin > nQtdLin
				nLin := cabec(cTitulo,cCabec1,cCabec2,cNomeProg,cTamanho,IIF(aReturn[4]==1,GetMv("MV_COMP"),GetMv("MV_NORM")))
			Endif
	
			If ETQ->BA1_CODEMP <> "0000"
				@ ++nLin, 00 pSay "Empresa : "+ETQ->BA1_CODEMP+" "+BQC->BQC_DESCRI
			Else
				@ ++nLin, 00 pSay BQC->BQC_DESCRI
			EndIf
	
			nLin++
	
			c_EmpAnt := ETQ->BA1_CODEMP
	
		EndIf
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Conforme solicitado pelo usuario, imprimir linha a cada familia.    ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
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
		
		BA1->(DbSetOrder(2))
		BA1->(DbSeek(xFilial("BA1")+ETQ->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC)+"00"))
		
		cNomTit := BA1->BA1_NOMUSR
		
		@ ++nLin, 00 pSay ETQ->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG+BA1_DIGITO)+"  "+PadR(ETQ->BA1_NOMUSR,40)+"  "+PadR(cNomTit,40)+"  "+DtoC(ETQ->BTS_DATNAS)+"  "+DtoC(ETQ->BED_DATVAL)+"  "+DtoC(ETQ->BED_DTSOLI)+"  "+ETQ->BED_CDIDEN+"  "+StrZero(ETQ->BED_VIACAR,2)+"  "+cEstCob
		cConAnt   := ETQ->BA1_CONEMP
		cSubAnt   := ETQ->BA1_SUBCON
		nTotSub++
	
		ETQ->(DbSkip())
	
		If c_EmpAnt # ETQ->BA1_CODEMP .OR. cConAnt # ETQ->BA1_CONEMP .or. cSubAnt # ETQ->BA1_SUBCON
	
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
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Faz manualmente porque nao chama a funcao Cabec()                 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	//setPrc( pRow(),pCol())
	//	If mv_par27 != 3   //Emissao diferente de etiqueta
	
	If nNumCol > 2							// Matriculas digitadas
		@ pRow(),pCol() Psay AvalImp(132)
	Else
		@ pRow(),pCol() Psay AvalImp(80)
	EndIf
	
	If cTipImp = 2
		nLin := pRow() + 2
	EndIf
	//	EndIf
	            
	i:= 1

	If nTipEnd == 2   // Somente para Titular e endereco por Lotacao
	
		While ! ETQ->(Eof())

			IncRegua()
			
			cMatric := ETQ->(BA3_MATEMP+BA1_CODINT+BA1_CODEMP+BA1_MATRIC)
			
			nPos := aScan(aMatTit,{|x|x[1]  == ETQ->(BA3_MATEMP+BA1_CODINT+BA1_CODEMP+BA1_MATRIC)} )
			
			If !lSomTit .OR. nPos == 0
				
				//***** Aqui vou procurar pelo titular da funcional para apresentar o nome
				cSql := "SELECT ZZ1_FUNC, ZZ1_DEPEND, ZZ1_BENEF, ZZ1_INDENV, ZZ1_LOGRAD, ZZ1_NUMERO, ZZ1_COMPLE, ZZ1_BAIRRO,"
				cSql += " ZZ1_CEP, ZZ1_CIDADE, ZZ1_UF, ZZ1_CODEMP, ZZ1_UFLOT, ZZ1_CODLOT, ZZ1_CDORGL, ZZ1_ORGAO, "
				cSql += " ZZ1_IDLOGR, ZZ1_CODLOG, ZZ1_MUNLOG, ZZ1_ENDLOG, ZZ1_COMLOG, ZZ1_BAILOG, ZZ1_CITLOG, ZZ1_ESTLOG "
				cSql += " FROM "+RetSQLName("ZZ1")+" ZZ1 "
				cSQL += " WHERE ZZ1.ZZ1_FILIAL = '" + xFilial("ZZ1") + "' "
				cSql += " AND ZZ1.ZZ1_FUNC   = '" + AllTrim(ETQ->BA3_MATEMP) + "' "
			   //	cSql += " AND ZZ1.ZZ1_CONTR  = '" + AllTrim(ETQ->BQC_YCDCON) + "' " 
				
				// If lSomTit
				
				cSql += " AND ZZ1_DEPEND = '00' "
				cSql += " AND ZZ1_CDBENE = 'T' "				
				// Else                                 
				
				// 	cSql += " AND ZZ1_DEPEND = '" + ETQ->BA1_TIPREG + "' "
				
				// EndIf
				
				cSql += " AND ZZ1_TPBENE <> ' ' "

				cSql += " AND ZZ1.D_E_L_E_T_ = ' ' "
				cSql += " ORDER BY ZZ1.r_e_c_n_o_ Desc "
				
				PLSQuery(cSql,"TrbZZ1")
				
				TrbZZ1->(DbGoTop())
				
				aadd(aMatTit,{ETQ->(BA3_MATEMP+BA1_CODINT+BA1_CODEMP+BA1_MATRIC),;  	//1
				TRBZZ1->ZZ1_INDENV,;													//2
				TRBZZ1->ZZ1_CODEMP,;                                                   //  3
				TRBZZ1->ZZ1_UFLOT,;                                                    //  4
				TRBZZ1->ZZ1_CODLOT,;                                                   //  5
				TRBZZ1->ZZ1_CDORGL,;                                                   //  6
				ETQ->BA3_MATEMP,;                                                      //  7
				ETQ->BQC_YCDCON,;                                                      // 8
				TRBZZ1->ZZ1_FUNC,;                                                     //  9
				TRBZZ1->ZZ1_DEPEND,;                                                   //  10
				TRBZZ1->ZZ1_BENEF,;                                                    //  11
				TRBZZ1->ZZ1_INDENV,;                                                   //  12
				TRBZZ1->ZZ1_LOGRAD,;                                                   //  13
				TRBZZ1->ZZ1_NUMERO,;                                                   //  14
				TRBZZ1->ZZ1_COMPLE,;                                                   //  15
				TRBZZ1->ZZ1_BAIRRO,;                                                   //  16
				TRBZZ1->ZZ1_CEP,;                                                      //  17
				TRBZZ1->ZZ1_CIDADE,;                                                   //  18
				TRBZZ1->ZZ1_UF,;                                     				   //  19
				ETQ->BA1_CODINT,;                                                      //  20
				ETQ->BA1_CODEMP,;//  21
				ETQ->BA1_MATRIC,;//  22
				ETQ->BA1_TIPREG,;//  23
				ETQ->BA1_DIGITO,;//  24
				TRBZZ1->ZZ1_ORGAO ,; //  25 // mbc
				TRBZZ1->ZZ1_ENDLOG ,; //  26 // mbc
				TRBZZ1->ZZ1_COMLOG ,; //  27 // mbc
				TRBZZ1->ZZ1_BAILOG ,; //  28 // mbc
				TRBZZ1->ZZ1_CITLOG ,; //  29 // mbc
				TRBZZ1->ZZ1_ESTLOG ,; //  30 // mbc
				TRBZZ1->ZZ1_IDLOGR } )//   // mbc

				TrbZZ1->( DbCloseArea() )
			EndIf
	
			ETQ->( DbSkip() )
	
		Enddo
	
		If len(aMatTit) > 0
			// ORGANIZADO CONFORME solicitacao do banco Itau
			// Tipo de Expedicao+Empresa+Estado da Lotacao+Lotacao
			// mbc aSort(aMatTit,,, { |x,y| x[2]+x[3]+x[4]+x[5] < y[2]+y[3]+y[4]+y[5] })
			
			For n = 1 to len(aMatTit)
				
				cCodigo  := aMatTit[n,20]+aMatTit[n,21]+aMatTit[n,22]+aMatTit[n,23]+aMatTit[n,24]   //ETQ->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG+BA1_DIGITO)
				
				cEndere  := ""
				cCompl   := ""
				cBairro  := ""
				cMunici  := ""
				cEstado  := ""
				cCep     := ""
				//			cEndere  := ETQ->BA1_YLOTAC
				//			cCompl   := ETQ->BA1_YNOMLO
				
				cEndere  := Alltrim( SubStr(aMatTit[n,13],1,37) ) + " " + Alltrim( SubStr(aMatTit[n,14],1,5) )
				cCompl   := Alltrim(aMatTit[n,15])
				cBairro  := AllTrim(aMatTit[n,16])
				cMunici  := AllTrim(aMatTit[n,19])
				cEstado  := Alltrim(aMatTit[n,19])
//				cCep     := Substr(aMatTit[n,17],1,5)+"-"+Substr(aMatTit[n,17],6,3)
				cCep     := Alltrim(aMatTit[n,17])

				
				Lin[3,I] := cEndere
				Lin[4,I] := Iif(Empty(AllTrim(cCompl)),cBairro,cCompl+" - "+cBairro)
				Lin[5,I] := cMunici+"-"+cEstado+"  CEP:" +cCep
				

					If aMatTit[n,2] != "C"   // ZZ1_INDENV   Envio Pelo Malote Itau ou Unibanco

						**'--------------------------------------------------------------------------------------'**
		                                    
		        		If !Empty( ALLTRIM( aMatTit[n, 26] ) )
						
					
							cNomlot := aMatTit[n, 25] 
							cCodlot := aMatTit[n, 06] 
							cEndere := aMatTit[n, 26] 
							cComple := aMatTit[n, 27] 
							cBairro := aMatTit[n, 28] 
							cCidade := aMatTit[n, 29] 
							cEstado := aMatTit[n, 30] 

                            /*
							cNomlot := ALLTRIM( aMatTit[n, 25] )
							cCodlot := ALLTRIM( aMatTit[n, 06] )
							cEndere := ALLTRIM( aMatTit[n, 26] )
							cComple := ALLTRIM( aMatTit[n, 27] )
							cBairro := ALLTRIM( aMatTit[n, 28] )
							cCidade := ALLTRIM( aMatTit[n, 29] )
							cEstado := ALLTRIM( aMatTit[n, 30] )
					        */
							Lin[1,I] := AllTrim(aMatTit[n,07]) + " ("+cCodigo+")"    //AllTrim(TrbZZ1->ZZ1_BENEF)   //"Titular: "+cNomTit
							Lin[2,I] := AllTrim(aMatTit[n,11])  //cNomTit
							Lin[3,I] := AllTrim(cNomlot)
							Lin[4,I] := AllTrim(cEndere)
							Lin[5,I] := AllTrim(cCidade) + " - "+AllTrim(cEstado)
			
														
							Aadd(aLinha,AllTrim(aMatTit[n,7])+ ";";
															+cCodigo+";";
															+AllTrim(aMatTit[n,2])+";";
															+AllTrim(aMatTit[n,11])+";"; 	// NOME
															+AllTrim(cNomLot)+" - "+AllTrim(cCodlot)+";"; 	// LOTAÇÃO 
															+AllTrim(cEndere)+";";					// ENDEREÇO
															+iIf(!Empty(cComple), AllTrim(cComple) + " - ", "") + AllTrim(cBairro )+ ";";	// ENDEREÇO
															+AllTrim(cCidade)+ " - " + AllTrim(cEstado))         
						Else				
						
						**'--------------------------------------------------------------------------------------'**
		
							cSql := "SELECT Z01_EMPCOL, Z01_ESTADO, Z01_CODLOT, Z01_CDSORG, Z01_NOMLOT, Z01_ENDERE, Z01_CIDADE, Z01_ESTADO "
							//					If !Empty(AllTrim(ETQ->LOTACAO))
							cSql += " FROM "+RetSQLName("Z01")+" Z01 "
							cSQL += " WHERE Z01.Z01_FILIAL = '" + xFilial("Z01") + "' "
							cSql += " AND Z01.Z01_EMPCOL = '" + AllTrim(aMatTit[n,3]) + "' "
							cSql += " AND Z01.Z01_CODLOT = '" + AllTrim(aMatTit[n,5]) + "' "
							cSql += " AND Z01.Z01_CDSORG = '" + SubStr(aMatTit[n,6],1,5) + "' "
							cSql += " AND Z01.D_E_L_E_T_ = ' ' "
							//					Else
							//						cSql += " FROM "+RetSQLName("Z01")+" Z01, "+RetSQLName("ZZ1")+" ZZ1 "
							//						cSQL += " WHERE Z01.Z01_FILIAL = '" + xFilial("Z01") + "' "
							//						cSQL += " AND ZZ1.ZZ1_FILIAL = '" + xFilial("ZZ1") + "' "
							//						cSql += " AND ZZ1.ZZ1_FUNC   = '"+ AllTrim(aMatTit[N,7])+"' "
							//						cSql += " AND ZZ1.ZZ1_CONTR  = '"+ AllTrim(aMatTit[n,8])+"' "
							//						cSql += " AND ZZ1_DEPEND     = '00' "
							//						cSql += " AND ZZ1_TPBENE     <> ' ' "
							//						cSql += " AND ZZ1_CDBENE     = 'T' "
							//						cSql += " AND Z01.Z01_EMPCOL = ZZ1.ZZ1_CODEMP "
							//						cSql += " AND Z01.Z01_CODLOT = ZZ1.ZZ1_CODLOT "
							//						cSql += " AND Z01.Z01_CDSORG = substr(ZZ1.ZZ1_CDORGL,0,5) "
							//						cSql += " AND ZZ1.D_E_L_E_T_ = ' ' "
							//						cSql += " AND Z01.D_E_L_E_T_ = ' ' "
							//						cSql += " ORDER BY ZZ1.r_e_c_n_o_ Desc "
							//					EndIf
							
							PLSQuery(cSql,"TrbZ01")
							
							TrbZ01->(DbGoTop())
							
							Lin[1,I] := AllTrim(aMatTit[n,07]) + " ("+cCodigo+")"    //AllTrim(TrbZZ1->ZZ1_BENEF)   //"Titular: "+cNomTit
							Lin[2,I] := AllTrim(aMatTit[n,11])  //cNomTit
							
							If !TrbZ01->(Eof())
								//							Lin[1,I] := AllTrim(ETQ->BA3_MATEMP) + " ("+cCodigo+")"    //AllTrim(TrbZZ1->ZZ1_BENEF)   //"Titular: "+cNomTit
								//							Lin[2,I] := AllTrim(TrbZZ1->ZZ1_BENEF)  //cNomTit
								Lin[3,I] := AllTrim(TrbZ01->Z01_NOMLOT)
								Lin[4,I] := Alltrim(TrbZ01->Z01_ENDERE)
								Lin[5,I] := Alltrim(TrbZ01->Z01_CIDADE) + " - "+Alltrim(TrbZ01->Z01_ESTADO)  //""
								cNomlot := AllTrim(TrbZ01->Z01_NOMLOT)
								cEndere := Alltrim(TrbZ01->Z01_ENDERE)
								cCidade := Alltrim(TrbZ01->Z01_CIDADE)
								cEstado := Alltrim(TrbZ01->Z01_ESTADO)
							
							Else
		//					If aMatTit[n,8] != "01115"
		//						Lin[3,I] := "Funcional: "+BA3->BA3_MATEMP
		//						Lin[4,I] := alltrim(ETQ->BA1_YLOTAC)
		//						Lin[5,I] := Alltrim(ETQ->BA1_YNOMLO)
		
								Lin[3,I] := AllTrim(aMatTit[n,25])   //ZZ1_ORGAO
								Lin[4,I] := Alltrim(aMatTit[n,05])   //zz1_codlot
		//						Lin[5,I] := Alltrim(aMatTit[n,07]) + " - "+Alltrim(aMatTit[n,04])  //""   //zz1_uflot
								Lin[5,I] := Alltrim(aMatTit[n,04])   //zz1_uflot
		//					EndIf	
								cNomlot := AllTrim(aMatTit[n,25])
								cEndere := Alltrim(aMatTit[n,05]) 
								cCidade := ""
								cEstado := Alltrim(aMatTit[n,04])
							EndIf
		
							If mv_par27 == 3   //Emissao diferente de etiqueta
		//						Aadd(aLinha,AllTrim(aMatTit[n,7])+ ";"+cCodigo+";"+AllTrim(aMatTit[n,2])+";"+AllTrim(aMatTit[n,11])+";"+AllTrim(TrbZ01->Z01_NOMLOT)+";"+Alltrim(TrbZ01->Z01_ENDERE)+";"+Alltrim(TrbZ01->Z01_CIDADE) + " - "+Alltrim(TrbZ01->Z01_ESTADO))
								Aadd(aLinha,AllTrim(aMatTit[n,7])+ ";"+cCodigo+";"+AllTrim(aMatTit[n,2])+";"+AllTrim(aMatTit[n,11])+";"+AllTrim(cNomLot)+";"+AllTrim(cEndere)+";"+AllTrim(cCidade)+ " - "+AllTrim(cEstado))
							EndIf
							TrbZ01->( DbCloseArea() )    
						
						EndIf
					
					Else
	
						If mv_par27 == 3   //Emissao diferente de etiqueta
							Aadd(aLinha,AllTrim(aMatTit[n,7])+ ";"+cCodigo+";"+AllTrim(aMatTit[n,2])+";"+AllTrim(aMatTit[n,11])+";"+AllTrim(cEndere)+";"+Iif(Empty(AllTrim(cCompl)),AllTrim(cBairro),AllTrim(cCompl)+" - "+AllTrim(cBairro))+";"+AllTrim(cMunici)+"-"+AllTrim(cEstado)+"  CEP: "+AllTrim(cCep))
						EndIf
	
					EndIf
					
					//				If mv_par27 == 3   //Emissao diferente de etiqueta
				//					If aMatTit[n,02] == "C"
				//						Aadd(aLinha,AllTrim(aMatTit[n,7])+ ";"+cCodigo+";"+AllTrim(aMatTit[n,2])+";"+AllTrim(aMatTit[n,11])+";"+cEndere+";"+Iif(Empty(AllTrim(cCompl)),cBairro,cCompl+" - "+cBairro)+";"+cMunici+"-"+cEstado+"  CEP: "+cCep)
				//					Else
				//						Aadd(aLinha,AllTrim(aMatTit[n,7])+ ";"+cCodigo+";"+AllTrim(aMatTit[n,2])+";"+AllTrim(aMatTit[n,11])+";"+AllTrim(TrbZ01->Z01_NOMLOT)+";"+Alltrim(TrbZ01->Z01_ENDERE)+";"+Alltrim(TrbZ01->Z01_CIDADE) + " - "+Alltrim(TrbZ01->Z01_ESTADO))
				//						TrbZ01->( DbCloseArea() )
				//					EndIf
				//				EndIf  
				
			//Leonardo Portella - 06/06/11 - Inicio
			//Correcao da impressao das etiquetas que estavam saindo duplicadas
			
			For nJ := 1 to len(Lin[1])
				
				If !empty(Lin[1][nJ])
				
					If aScan(aImprimir,{|x|x[1] == Lin[1][nJ]}) <= 0
						               
						aBuffer := {}
						
						For nK := 1 to len(Lin)
						
							aAdd(aBuffer,Lin[nK][nJ])
						
						Next
						
						aAdd(aImprimir,aBuffer)   
					
					EndIf
					
				EndIf
			
			Next
			
			/*	
       		If MV_PAR27 == 2 //.and. I == 2 
				   
				For J := 1 to 5
                    
					For k := nPosCol TO MV_PAR06   //3  Colunas  
					    
						nColuna := (K-1) * 45  //68 //73  // Posiciona as colunas
						@nLin,nColuna PSAY Lin[J,K]
						
					Next K 
					
					nLin += 1
				
				Next J
			*/      
			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Imprime por linha do array aImprimir.        ³
			//³Ex: 2 colunas a imprimir                     ³
			//³Array aImprimir com 3 etiquetas              ³
			//³                                             ³
			//³Linha 1 -  aImprimir[1][1]    aImprimir[2][1]³
			//³Linha 2 -  aImprimir[1][2]    aImprimir[2][2]³
			//³Linha 3 -  aImprimir[1][3]    aImprimir[2][3]³
			//³Linha 4 -  aImprimir[1][4]    aImprimir[2][4]³
			//³Linha 5  - aImprimir[1][5]    aImprimir[2][5]³
			//³Linha 6                                      ³
			//³Linha 7 -  aImprimir[3][1]                   ³
			//³Linha 8 -  aImprimir[3][2]                   ³
			//³Linha 9 -  aImprimir[3][3]                   ³
			//³Linha 10-  aImprimir[3][4]                   ³
			//³Linha 11-  aImprimir[3][5]                   ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				
			If mv_par27 == 2 .and. n == len(aMatTit)//.and. I == 2 
				 
				nQtdImpressa := 0
				nColImprimir := mv_par06 - nPosCol + 1
			   	nQtdLinEtiq  := len(aImprimir[1])
			   	nQtdEtiqImpr := len(aImprimir) 
			   	
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³Obs: Nao imprime dependentes, somente titulares. Informado³
				//³pela Claudia do cadastro.                                 ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			   				   		  
				While nQtdImpressa < nQtdEtiqImpr 
				
					//Leonardo Portella - 08/12/11 - Inicio - Tratar a quebra de pagina pois esta imprimindo fora da folha
					
					If nLin > nQtdLin
						nLin := 3
					Endif
				    
					//Leonardo Portella - 08/12/11 - Fim
					
					For nJ := 1 to nQtdLinEtiq //Para cada linha de aImprimir
					
						For nK := nPosCol to mv_par06 //Para cada coluna de etiqueta a imprimir
					        
							If nQtdImpressa + nK <= len(aImprimir)
							
								nColuna := (nK-1) * 45  //68 //73  // Posiciona as colunas
								
								@nLin,nColuna PSAY aImprimir[nQtdImpressa+nK][nJ]
								
							EndIf
							
						Next
					
						++nLin
					
					Next      
					
					++nLin //Pula linha
					
					nQtdImpressa += nColImprimir
				
				EndDo
			
			//Leonardo Portella - 06/06/11 - Fim
				
				nQtdEtq += 1
				
				If ((nQtdEtq = 4 .or. nQtdEtq = 8) .and. cTipImp = 2)
					nLin := nLin + 1
				EndIf
				
				If (nQtdEtq = 10 .and. cTipImp = 2)
					nQtdEtq := 0
					eject
					nLin := pRow() + 1
				EndIf
				nLin += 1   
				
			EndIf   
						
			If I == 1
				I++
			Else
				I:=1
			EndIf
			  
		Next

			If MV_PAR27 <> 2			
	
				nlin := 0
	
				For I := 1 TO Len(aLinha)
					@nLin,000 PSAY AllTrim(aLinha[I])
					nLin ++
				Next I        
	
			EndIf
	
		EndIf
		
	Else
		
		While ! ETQ->(Eof())
			IncRegua()
			
			nColuna := 0
			I       := 1
			J       := 0
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Verifica se foi abortada a impressao...                            ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If Interrupcao(lAbortPrint)
				nLin ++
				@ nLin, nColuna pSay PLSTR0002
				Exit
			Endif
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
 			//³ Monta array com etiquetas...           									   ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			Lin := Array(5,3)
			
			While I <= MV_PAR06  .And. ! ETQ->(Eof())
				
				//			cMatric := ETQ->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC)
				cMatric := ETQ->(BA3_MATEMP+BA1_CODINT+BA1_CODEMP+BA1_MATRIC)
				
				/*
				If lSomTit //Isso filtrará caso não seja solicitado a emissão de lotes  //Somente para titular da familia
					nPos := aScan(aResumo,{|x|x[1] == ETQ->(BA3_MATEMP+BA1_CODINT+BA1_CODEMP+BA1_MATRIC)} )
					
					If nPos == 0
						aadd(aResumo,{ETQ->(BA3_MATEMP+BA1_CODINT+BA1_CODEMP+BA1_MATRIC)} )
						lImprime := .T.
					Else
						lImprime := .F.
					EndIf
				EndIf
				*/
				If lImprime
					
					//    BTS_CEPUSR, BTS_ENDERE, BTS_NR_END, BTS_COMEND, BTS_BAIRRO, BTS_ESTADO
					//		BA1_CODINT, BA1_CODEMP, BA1_MATRIC, "
					
					cNomTit := space(42)
					
					BA1->(DbSetOrder(2))
					BA1->(DbSeek(xFilial("BA1")+ETQ->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+"00")))
					
					cNomTit := Alltrim(Substr(BA1->BA1_NOMUSR,1,42) )
					
					cCodigo  := ETQ->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG+BA1_DIGITO)
					
					cNome    := Alltrim( SubStr(ETQ->BA1_NOMUSR,1,42) )
					
					cEndere  := Alltrim( SubStr(ETQ->BTS_ENDERE,1,37) ) + " " + Alltrim( SubStr(ETQ->BTS_NR_END,1,5) )
					cCompl   := Alltrim(ETQ->BTS_COMEND)
					cBairro  := AllTrim(ETQ->BTS_BAIRRO)
					cMunici  := AllTrim(ETQ->BTS_MUNICI)
					cEstado  := Alltrim(ETQ->BTS_ESTADO)
					cCep     := Substr(ETQ->BTS_CEPUSR,1,5)+"-"+Substr(ETQ->BTS_CEPUSR,6,3)
					
					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³ Monto array com dados da etiqueta ...                                              ³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					Lin[1,I] := cCodigo
					If !Empty(Alltrim(cNomTit)) .and. cNomEtq == 1
						Lin[2,I] := cNomTit   //"Titular: "+cNomTit
					Else
						Lin[2,I] := cNome
					EndIf
					Lin[3,I] := cEndere
					Lin[4,I] := Iif(Empty(AllTrim(cCompl)),cBairro,cCompl+" - "+cBairro)
					Lin[5,I] := cMunici+"-"+cEstado+"  CEP:" +cCep
					
					If mv_par27 != 3
						I += 1
						If ETQ->(Eof())
							I = 3 + 1
						Endif
					EndIf
				EndIf
				
				ETQ->( DbSkip() )
				
				If cMatric != ETQ->(BA3_MATEMP+BA1_CODINT+BA1_CODEMP+BA1_MATRIC)
					aResumo := {}
				EndIf
			Enddo
			
			I := 0
			If mv_par27 != 3   //Etiquetas
				For J := 1 to 5
					For I := nPosCol TO MV_PAR06   //3  Colunas
						nColuna := (I-1) * 45  //68 //73  // Posiciona as colunas
						@nLin,nColuna PSAY Lin[J,I]
					Next I
					nLin += 1
				Next J
				nQtdEtq += 1
				
				If ((nQtdEtq = 4 .or. nQtdEtq = 8) .and. cTipImp = 2)
					nLin := nLin + 1
				EndIf
				
				If (nQtdEtq = 10 .and. cTipImp = 2)
					nQtdEtq := 0
					eject
					nLin := pRow() + 1
				EndIf
				nLin += 1
			Else   //Arquivo
				nlin := 0
				For I := 1 TO Len(aLinha)
					@nLin,000 PSAY AllTrim(aLinha[I])
					nLin ++
				Next I
			EndIf
		Enddo
	EndIf
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
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³AjustaSX1 ºAutor  ³Luzio Tavares       º Data ³  13/03/08   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Cria as perguntas no SX1.                                   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³CABERJ                                                      º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
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

aadd(aRegs,{cPerg,"27","Tipo                          ","","","MV_CHR","N", 1,0,2,"C","","mv_par27","Relatorio","","","","","Etiqueta","","","","","Arquivo","","","","",""       			  ,"","","","","","","","",""   	,""})
aadd(aRegs,{cPerg,"28","Salta Pag. Subcontrato        ","","","MV_CHS","N", 1,0,2,"C","","mv_par28","Sim","","","","","Nao","","","","",""               ,"","","","",""       			  ,"","","","","","","","",""   	,""})
aadd(aRegs,{cPerg,"29","Ordenar por                   ","","","MV_CHT","N", 1,0,0,"C","","mv_par29","Nome Usuario","","","","","Cod. Usuario","","","","","Lote Gerado","","","","",""       			  ,"","","","","","","","",""   	,""})

//aadd(aRegs,{cPerg,"26","Operadora Destino ?         ","","","mv_chQ","C", 4,0,0,"G","","mv_par26","","","","","","","","","","","","","","","","","","","","","","","","","","B89PLS"})
//Aadd(aRegs,{cPerg,"24","         ","","","MV_CHO","N",01,0,0,"C","","Mv_Par24","Endereco","","","","","Lotacao","","","","","","","","","","","","","","","","","","","",""})

PlsVldPerg( aRegs )

Return(.T.)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABR004MatrºAutor  ³Luzio Tavares      º Data ³  13/03/08   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Informa as matriculas manualmente para impressao de etiquetaº±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CABERJ                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function CABR004Matr()

Local nI := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

Local aSaveArea := GetArea()
Local oDlg
Local oLbx
Local aNumRec := {}
Local oMatric
Local cMatric := CriaVar("BA1_MATANT")   //BA1_CODINT"+"BA1_CODEMP"+"BA1_MATRIC"+"BA1_TIPREG"+"BA1_DIGITO", .F.)

//Leonardo Portella - 23/05/11
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

DEFINE MSDIALOG oDlg TITLE "Usuários para emissão de etiquetas." FROM 0,0 TO 320,620 PIXEL

//EnchoiceBar(oDlg, {|| oDlg:End() }, {|| (aNumRec:={},oDlg:End()) } )

@ 018,005 SAY "Matricula" OF oDlg PIXEL
@ 018,030 MSGET oMatric VAR cMatric OF oDlg SIZE 100,09 PIXEL WHEN .T. PICTURE "@!" VALID VALMAT(oLbx, oMatric, cMatric) F3 "B92PLS"
//	@ 018,030 GET oCodInt VAR cCodInt OF oDlg SIZE 25,09 PIXEL WHEN .T. PICTURE "@!"
//	@ 018,060 GET oCodEmp VAR cCodEmp OF oDlg SIZE 25,09 PIXEL WHEN .T. PICTURE "@!"
//	@ 018,090 GET oMatric VAR cMatric OF oDlg SIZE 40,09 PIXEL WHEN .T. PICTURE "@!"
//	@ 018,135 GET oTipReg VAR cTipReg OF oDlg SIZE 15,09 PIXEL WHEN .T. PICTURE "@!"
//	@ 018,155 GET oDigito VAR cDigito OF oDlg SIZE 10,09 PIXEL WHEN .T. PICTURE "@!" VALID VALMAT(oLbx, oCodInt, cCodInt, cCodEmp, cMatric, cTipReg, cDigito)

@ 035,005 LISTBOX oLbx FIELDS HEADER "Matricula", "Nome do Usuário", "Record" SIZE 301, 112 NOSCROLL OF oDlg PIXEL
oLbx:SetArray(aNumRec)
oLbx:bLine:={||{ aNumRec[oLbx:nAt,01], aNumRec[oLbx:nAt,02], aNumRec[oLbx:nAt,03] }}
oLbx:nAt := 1
oLbx:aColSizes := {70, 170, 30}
oLbx:BLDBLCLICK := { || CABR004Excl(oLbx) }

ACTIVATE MSDIALOG oDlg CENTERED ON INIT (EnchoiceBar(oDlg, {|| oDlg:End() }, {|| (aNumRec:={},oDlg:End()) } ))
 
//Leonardo Portella - 03/06/11 - Inicio 
//Nao enviar repetidos, evitando assim impressao de etiquetas repetidas

aBuffer := aClone(aNumRec)
aNumRec := {}

For nI := 1 to len(aBuffer)
    
    //Se nao encontrar com mesma matricula e nome
	If !( aScan(aNumRec,{|x|allTrim(x[1]) == aBuffer[nI][1]}) > 0 .and. aScan(aNumRec,{|x|allTrim(x[2]) == allTrim(aBuffer[nI][2])}) > 0 )
	     
		aAdd(aNumRec,aBuffer[nI])
	
	EndIf	

Next

//Leonardo Portella - 03/06/11 - Fim

Return(aNumRec)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CVALMAT   ºAutor  ³Luzio Tavares       º Data ³  13/03/08   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Valida se a matricula existe e adiciona na lista.           º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CABERJ                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
//Static Function VALMAT(oLbx, oCodInt, cCodInt, cCodEmp, cMatric, cTipReg, cDigito)
Static Function VALMAT(oLbx, oMatric, cMatric)

BA1->( DbSetOrder(2) )		// BA1_FILIAL + BA1_CODINT + BA1_CODEMP + BA1_MATRIC + BA1_TIPREG + BA1_DIGITO
//If BA1->( !MsSeek( xFilial("BA1")+cCodInt+cCodEmp+cMatric+cTipReg+cDigito ) )
If BA1->( !MsSeek( xFilial("BA1")+cMatric ) )
	BA1->( DbSetOrder(5) )		// BA1_FILIAL + BA1_MATANT + BA1_TIPANT
	//	If BA1->( !MsSeek( xFilial("BA1")+cCodInt+cCodEmp+cMatric+cTipReg+cDigito ) )
	If BA1->( !MsSeek( xFilial("BA1")+cMatric ) )
		MsgStop("Matricula informada não cadastrada...")
		//		oCodInt:SetFocus()
		oMatric:SetFocus()
	Endif
Endif
	
If BA1->( Found() )
	
	If aScan(oLbx:AARRAY,{|x|x[3] == BA1->(RecNo())}) <= 0 //Leonardo Portella - 15/06/11 - Nao incluir Recnos repetidos
	
		If !Empty( oLbx:AARRAY[1][1] )
			Aadd( oLbx:AARRAY, {"", "", 0} )
		Endif
	
		oLbx:AARRAY[Len(oLbx:AARRAY)][1] :=	BA1->BA1_CODINT + "." +;
		BA1->BA1_CODEMP + "." +;
		BA1->BA1_MATRIC + "." +;
		BA1->BA1_TIPREG + "-" +;
		BA1->BA1_DIGITO
		oLbx:AARRAY[Len(oLbx:AARRAY)][2] :=	BA1->BA1_NOMUSR
		oLbx:AARRAY[Len(oLbx:AARRAY)][3] :=	BA1->(RecNo())
	
	EndIf //Leonardo Portella - 15/06/11 - Nao incluir Recnos repetidos

	oLbx:nAt := 1
	oLbx:Refresh()
	//	oCodInt:SetFocus()
	oMatric:SetFocus()
Endif

Return(.T.)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABR004ExclºAutor  ³Luzio Tavares      º Data ³  13/03/08   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Exclui a linha selecionada na lista de matriculas digitadas º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ PLS                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function CABR004Excl(oLbx)

Local aArray := Aclone( oLbx:AARRAY )

If MsgYesNo("Deseja excluir este usuário ?")
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

