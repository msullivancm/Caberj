//#INCLUDE "plstiss.ch"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "TOPCONN.CH"
#INCLUDE "PLSMGER.CH"
#INCLUDE "RPTDEF.CH"
#INCLUDE "TBICONN.CH"
#include 'fileio.ch'
#define lSrvUnix IsSrvUnix()

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡ao    ³ PLSTISSD  ³ Autor ³ Bruno Iserhardt       ³ Data ³ 20.06.13 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡ao ³ Estrutura Relatório TISS 3.00.01 (Guia de Consulta )        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ SigaPLS                                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ aDados - Array com as informações do relat´rio              ³±±
±±³          ³ lGerTXT - Define se imprime direto sem passar pela tela     ³±±
±±³          ³           de configuracao/preview do relatorio              ³±±
±±³          ³ nLayout - Define o formato de papél para impressao:         ³±±
±±³          ³           1 - Formato Ofício II (216x330mm)                 ³±±
±±³          ³           2 - Formato A4 (210x297mm)                        ³±±
±±³          ³  		     3 - Formato Carta (216x279mm)                     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function CABTISSD(aDados, lGerTXT, nLayout, cLogoGH, lWeb, cPathRelW)

Local nLinMax
Local nColMax
Local nLinIni	:=	0		// Linha Lateral (inicial) Esquerda
Local nColIni	:=	0		// Coluna Lateral (inicial) Esquerda
Local nColA4    :=  0      // Para implementar layout A4
Local nLinA4    :=  0      // Para implementar layout A4
Local cFileLogo
Local nI, nX
Local cObs
Local oFont01
Local oFont02n
Local oFont03n
Local oFont04
LOCAL cFileName	:= ""
LOCAL cRel      := "guicons"
LOCAL cPathSrvJ := GETMV("MV_RELT")
LOCAL nAL		:= 0.25
LOCAL nAC		:= 0.24
LOCAL nLinObs	:= 0

DEFAULT lGerTXT 	:= .F.
DEFAULT nLayout 	:= 2
DEFAULT cLogoGH 	:= ""
DEFAULT lWeb		:= .F.
DEFAULT cPathRelW 	:= ""
DEFAULT aDados := { {;
	"123456",; //1 - Registro ANS
	"12345678901234567890",; //2- Nº Guia no Prestador
	"12345678901234567890",; //3 - Número da Guia Atribuído pela Operadora
	"12345678901234567892",; //4 - Número da Carteira
	CtoD("12/12/07"),; //5 - Validade da Carteira
	"N",; //6 – Atendimento a RN (Sim ou Não)
	Replicate("M",70),; //7 – Nome
	"123456789012345",; //8 - Cartão Nacional de Saúde
	"12345678901234",; //9- Código na Operadora
	Replicate("M",70),; //10 - Nome do Contratado
	"1234567",; //11 - Código CNES
	Replicate("M",70),; //12 - Nome do Profissional Executante
	"AA",; //13 - Conselho Profissional
	"123456789012345",; //14 - Número no Conselho
	"RS",; //15 - UF
	"123456",; //16 - Código CBO
	"A",; //17 - Indicação de Acidente(acidente ou doença relacionada)
	CtoD("12/12/07"),; //18 - Data do Atendimento
	"A",; //19 - Tipo de Consulta
	"00",; //20 - Tabela
	"1234567890",; //21 - Código do Procedimento
	11111.78,; //22 - Valor do Procedimento
	Replicate("M",100)+Replicate("A",100)+Replicate("B",100)+Replicate("D",100)+Replicate("C",100)} } //23 - Observação / Justificativa

oFont01		:= TFont():New("Arial",  5,  5, , .F., , , , .T., .F.) // Normal

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
	//³ Nao permite acionar a impressao quando for na web.
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
If lWeb
	cPathSrvJ := cPathRelW
	cFileName := cRel+lower(CriaTrab(NIL,.F.))+".pdf"
Else
	cFileName := cRel+CriaTrab(NIL,.F.)
EndIf

	//						New ( < cFilePrintert >, [ nDevice], [ lAdjustToLegacy], [ cPathInServer], [ lDisabeSetup ], [ lTReport], [ @oPrintSetup], [ cPrinter], [ lServer], [ lPDFAsPNG], [ lRaw], [ lViewPDF] )
oPrint := FWMSPrinter():New ( cFileName			,			,	.F.				,cPathSrvJ	 	,	.T.				,			 ,				,			  ,			  ,	.F.			, 		, 				)
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
	//³Tratamento para impressao via job
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
oPrint:lServer := lWeb

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
	//³ Caminho do arquivo
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
oPrint:cPathPDF := cPathSrvJ

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
	//³Modo retrato
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
oPrint:SetPortrait()

If nLayout ==2
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
		//³Papél A4
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
	oPrint:SetPaperSize(9)
ElseIf nLayout ==3
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
		//³Papél Carta
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
	oPrint:SetPaperSize(1)
Else
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
		//³Papel Oficio2 216 x 330mm / 8 1/2 x 13in
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
	oPrint:SetPaperSize(14)
Endif

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
	//³Device
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
If lWeb
	oPrint:setDevice(IMP_PDF)
	oPrint:lPDFAsPNG := .T.
EndIf
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
	//³Verifica se existe alguma impressora configurada para Impressao Grafica
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
If  !lWeb
	oPrint:Setup()
	If !(oPrint:nModalResult == 1)
		Return
	Endif
EndIf

If oPrint:nPaperSize  == 9 // Papél A4
	nLinMax	:= 1134
	nColMax	:= 2335
	nLayout 	:= 2
	oFont02n	:= TFont():New("Arial", 12, 12, , .T., , , , .T., .F.) // Negrito
	oFont03n	:= TFont():New("Arial", 13, 13, , .T., , , , .T., .F.) // Negrito
	oFont04		:= TFont():New("Arial", 07, 07, , .F., , , , .T., .F.) // Normal
Elseif oPrint:nPaperSize == 1 // Papel Carta
	nLinMax	:= 0925
	nColMax	:= 2400
	nLayout 	:= 3
	oFont02n	:= TFont():New("Arial", 12, 12, , .T., , , , .T., .F.) // Negrito
	oFont03n	:= TFont():New("Arial", 13, 13, , .T., , , , .T., .F.) // Negrito
	oFont04		:= TFont():New("Arial", 07, 07, , .F., , , , .T., .F.) // Normal
Else // Papel Oficio2 216 x 330mm / 8 1/2 x 13in
	nLinMax	:= 1184
	nColMax	:= 2400
	nLayout 	:= 1
	oFont02n	:= TFont():New("Arial", 12, 12, , .T., , , , .T., .F.) // Negrito
	oFont03n	:= TFont():New("Arial", 14, 14, , .T., , , , .T., .F.) // Negrito
	oFont04	:= TFont():New("Arial", 09, 09, , .F., , , , .T., .F.) // Normal
Endif

For nX := 1 To Len(aDados)

	If Len(aDados[nX]) == 0
		Loop
	EndIf

	If oPrint:Cprinter == "PDF" .OR. lWeb
		nLinIni	:= 000
	Else
		nLinIni := 100
	Endif
	nColIni := 065
	nLinA4  := 000
	nColA4  := 000

	oPrint:StartPage()		// Inicia uma nova pagina
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Box Principal                                                 ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	oPrint:Box((nLinIni + 0000)*nAL, (nColIni + 0010)*nAC, (nLinIni + nLinMax)*nAL, (nColIni + nColMax)*nAC)

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Carrega e Imprime Logotipo da Empresa                         ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	fLogoEmp(@cFileLogo,, cLogoGH)

	If File(cFilelogo)
		oPrint:SayBitmap((nLinIni + 0050)*nAL, (nColIni + 0020)*nAC, cFileLogo, (400)*nAL, (090)*nAC) // Tem que estar abaixo do RootPath
	EndIf

	if nLayout == 2 // Papél A4
		nColA4:= -0065
		nLinA4:= 0
	Elseif nLayout ==3 //Carta
		nLinA4:= -0010
	Endif

	oPrint:Say((nLinIni + 0110)*nAL + nLinA4, (nColIni + (nColMax*0.4))*nAC, "GUIA DE CONSULTA", oFont02n,,,, 2) //"GUIA DE CONSULTA"
	oPrint:Say((nLinIni + 0090)*nAL + nLinA4, (nColIni + (nColMax*0.67))*nAC, "2- Nº Guia no Prestador", oFont01) //"2- Nº Guia no Prestador"
	oPrint:Say((nLinIni + 0090)*nAL + nLinA4, (nColIni + (nColMax*0.78))*nAC, aDados[nX, 02], oFont03n)

	oPrint:Box((nLinIni + 0165)*nAL + nLinA4, (nColIni + 0020)*nAC, (nLinIni + 0225)*nAL + nLinA4, (nColIni + (nColMax*0.16) - 0010)*nAC)
	oPrint:Say((nLinIni + 0185)*nAL + nLinA4, (nColIni + 0030)*nAC, "1 - Registro ANS", oFont01) //1 - Registro ANS
	oPrint:Say((nLinIni + 0217)*nAL + nLinA4, (nColIni + 0040)*nAC, aDados[nX, 01], oFont04)
	oPrint:Box((nLinIni + 0165)*nAL + nLinA4, (nColIni + (nColMax*0.16))*nAC, (nLinIni + 0225)*nAL + nLinA4, (nColIni + (nColMax*0.64) - 0010)*nAC)
	oPrint:Say((nLinIni + 0185)*nAL + nLinA4, (nColIni + (nColMax*0.16) + 0010)*nAC, "3 - Número da Guia Atribuído pela Operadora", oFont01) //3 - Número da Guia Atribuído pela Operadora
	oPrint:Say((nLinIni + 0217)*nAL + nLinA4, (nColIni + (nColMax*0.16) + 0020)*nAC, aDados[nX, 03], oFont04)

	oPrint:Say((nLinIni + 0245)*nAL + nLinA4, (nColIni + 0020)*nAC, "Dados do Beneficiário", oFont01) //Dados do Beneficiário
	oPrint:Box((nLinIni + 0255)*nAL + nLinA4, (nColIni + 0020)*nAC, (nLinIni + 0315)*nAL + nLinA4, (nColIni + (nColMax*0.48) - 0010)*nAC)
	oPrint:Say((nLinIni + 0275)*nAL + nLinA4, (nColIni + 0030)*nAC, "4 - Número da Carteira", oFont01) //4 - Número da Carteira
	oPrint:Say((nLinIni + 0307)*nAL + nLinA4, (nColIni + 0040)*nAC, aDados[nX, 04], oFont04)
	oPrint:Box((nLinIni + 0255)*nAL + nLinA4, (nColIni + (nColMax*0.48))*nAC, (nLinIni + 0315)*nAL + nLinA4, (nColIni + (nColMax*0.70) - 0010)*nAC)
	oPrint:Say((nLinIni + 0275)*nAL + nLinA4, (nColIni + (nColMax*0.48) + 0010)*nAC, "5 - Validade da Carteira", oFont01) //5 - Validade da Carteira
	oPrint:Say((nLinIni + 0307)*nAL + nLinA4, (nColIni + (nColMax*0.48) + 0020)*nAC, DtoC(aDados[nX, 05]), oFont04)
	oPrint:Box((nLinIni + 0255)*nAL + nLinA4, (nColIni + (nColMax*0.70))*nAC, (nLinIni + 0315)*nAL + nLinA4, (nColIni + (nColMax*0.92) - 0090)*nAC)
	oPrint:Say((nLinIni + 0275)*nAL + nLinA4, (nColIni + (nColMax*0.70) + 0010)*nAC, "6 - Atendimento a RN (Sim ou Não)", oFont01) //6 - Atendimento a RN (Sim ou Não)
	oPrint:Say((nLinIni + 0307)*nAL + nLinA4, (nColIni + (nColMax*0.70) + 0020)*nAC, aDados[nX, 06], oFont04)

	oPrint:Box((nLinIni + 0325)*nAL + nLinA4, (nColIni + 0020)*nAC, (nLinIni + 0385)*nAL + nLinA4, (nColIni + (nColMax*0.70) - 0010)*nAC)
	oPrint:Say((nLinIni + 0345)*nAL + nLinA4, (nColIni + 0030)*nAC, "7 - Nome", oFont01) //7 - Nome
	oPrint:Say((nLinIni + 0377)*nAL + nLinA4, (nColIni + 0040)*nAC, aDados[nX, 07], oFont04)
	oPrint:Box((nLinIni + 0325)*nAL + nLinA4, (nColIni + (nColMax*0.70))*nAC, (nLinIni + 0385)*nAL + nLinA4, (nColIni + nColMax - 0010)*nAC)
	oPrint:Say((nLinIni + 0345)*nAL + nLinA4, (nColIni + (nColMax*0.70) + 0010)*nAC, "8 - Cartão Nacional de Saúde", oFont01) //8 - Cartão Nacional de Saúde
	oPrint:Say((nLinIni + 0377)*nAL + nLinA4, (nColIni + (nColMax*0.70) + 0020)*nAC, aDados[nX, 08], oFont04)

	oPrint:Say((nLinIni + 0405)*nAL + nLinA4, (nColIni + 0020)*nAC, "Dados do Contratado", oFont01) //Dados do Contratado
	oPrint:Box((nLinIni + 0415)*nAL + nLinA4, (nColIni + 0020)*nAC, (nLinIni + 0475)*nAL + nLinA4, (nColIni + (nColMax*0.20) - 0010)*nAC)
	oPrint:Say((nLinIni + 0435)*nAL + nLinA4, (nColIni + 0030)*nAC, "9 - Código na Operadora", oFont01) //9 - Código na Operadora
	oPrint:Say((nLinIni + 0467)*nAL + nLinA4, (nColIni + 0040)*nAC, aDados[nX, 09], oFont04)
	oPrint:Box((nLinIni + 0415)*nAL + nLinA4, (nColIni + (nColMax*0.20))*nAC, (nLinIni + 0475)*nAL + nLinA4, (nColIni + (nColMax*0.85) - 0010)*nAC)
	oPrint:Say((nLinIni + 0435)*nAL + nLinA4, (nColIni + (nColMax*0.20) + 0010)*nAC, "10 - Nome do Contratado", oFont01) //10 - Nome do Contratado
	oPrint:Say((nLinIni + 0467)*nAL + nLinA4, (nColIni + (nColMax*0.20) + 0020)*nAC, aDados[nX, 10], oFont04)
	oPrint:Box((nLinIni + 0415)*nAL + nLinA4, (nColIni + (nColMax*0.85))*nAC, (nLinIni + 0475)*nAL + nLinA4, (nColIni + nColMax - 0010)*nAC)
	oPrint:Say((nLinIni + 0435)*nAL + nLinA4, (nColIni + (nColMax*0.85) + 0010)*nAC, "11 - Código CNES", oFont01) //11 - Código CNES
	oPrint:Say((nLinIni + 0467)*nAL + nLinA4, (nColIni + (nColMax*0.85) + 0020)*nAC, aDados[nX, 11], oFont04)

	oPrint:Box((nLinIni + 0485)*nAL + nLinA4, (nColIni + 0020)*nAC, (nLinIni + 0545)*nAL + nLinA4, (nColIni + (nColMax*0.51) - 0010)*nAC)
	oPrint:Say((nLinIni + 0505)*nAL + nLinA4, (nColIni + 0030)*nAC, "12 - Nome do Profissional Executante", oFont01) //12 - Nome do Profissional Executante
	oPrint:Say((nLinIni + 0537)*nAL + nLinA4, (nColIni + 0040)*nAC, aDados[nX, 12], oFont04)
	oPrint:Box((nLinIni + 0485)*nAL + nLinA4, (nColIni + (nColMax*0.51))*nAC, (nLinIni + 0545)*nAL + nLinA4, (nColIni + (nColMax*0.60) - 0010)*nAC)
	oPrint:Say((nLinIni + 0500)*nAL + nLinA4, (nColIni + (nColMax*0.51) + 0010)*nAC, "13 - Conselho", oFont01) //13 - Conselho
	oPrint:Say((nLinIni + 0517)*nAL + nLinA4, (nColIni + (nColMax*0.51) + 0010)*nAC, "Profissional", oFont01) //Profissional
	oPrint:Say((nLinIni + 0540)*nAL + nLinA4, (nColIni + (nColMax*0.51) + 0020)*nAC, aDados[nX, 13], oFont04)
	oPrint:Box((nLinIni + 0485)*nAL + nLinA4, (nColIni + (nColMax*0.60))*nAC, (nLinIni + 0545)*nAL + nLinA4, (nColIni + (nColMax*0.81) - 0010)*nAC)
	oPrint:Say((nLinIni + 0505)*nAL + nLinA4, (nColIni + (nColMax*0.60) + 0010)*nAC, "14 - Número no Conselho", oFont01) //14 - Número no Conselho
	oPrint:Say((nLinIni + 0537)*nAL + nLinA4, (nColIni + (nColMax*0.60) + 0020)*nAC, aDados[nX, 14], oFont04)
	oPrint:Box((nLinIni + 0485)*nAL + nLinA4, (nColIni + (nColMax*0.81))*nAC, (nLinIni + 0545)*nAL + nLinA4, (nColIni + (nColMax*0.87) - 0010)*nAC)
	oPrint:Say((nLinIni + 0505)*nAL + nLinA4, (nColIni + (nColMax*0.81) + 0010)*nAC, "15 - UF", oFont01) //15 - UF
	oPrint:Say((nLinIni + 0537)*nAL + nLinA4, (nColIni + (nColMax*0.81) + 0020)*nAC, aDados[nX, 15], oFont04)
	oPrint:Box((nLinIni + 0485)*nAL + nLinA4, (nColIni + (nColMax*0.87))*nAC, (nLinIni + 0545)*nAL + nLinA4, (nColIni + nColMax - 0010)*nAC)
	oPrint:Say((nLinIni + 0505)*nAL + nLinA4, (nColIni + (nColMax*0.87) + 0010)*nAC, "16 - Código CBO", oFont01) //16 - Código CBO

	If !EMPTY(aDados[nX, 04])

	   cQuery := "SELECT BTU_CDTERM "
	   cQuery += "FROM " + RetSqlName("BTU") + " "
	   cQuery += "WHERE BTU_VLRSIS LIKE '%" + ALLTRIM(aDados[nX, 16]) + "%' AND D_E_L_E_T_ <> '*' "

	   // Compatibiliza a sintaxe da query para o banco de dados em uso.
	   cQuery := ChangeQuery(cQuery)

	   // Executa a query e retorna o conjunto de registros numa WorkArea denominada MOVIM,
	   // contendo os registros filtrados pela clausula WHERE.
	   dbUseArea(.T., "TOPCONN", TCGenQry( , , cQuery), "MOVIM", .F., .T.)

		aDados[nX, 16] := MOVIM->BTU_CDTERM

		dbSelectArea("MOVIM")
   		dbCloseArea()
	EndIf

	oPrint:Say((nLinIni + 0537)*nAL + nLinA4, (nColIni + (nColMax*0.87) + 0020)*nAC, aDados[nX, 16], oFont04)

	oPrint:Say((nLinIni + 0565)*nAL + nLinA4, (nColIni + 0020)*nAC, "Hipóteses Diagnósticas", oFont01) //Hipóteses Diagnósticas
	oPrint:Box((nLinIni + 0575)*nAL + nLinA4, (nColIni + 0020)*nAC, (nLinIni + 0635)*nAL + nLinA4, (nColIni + (nColMax*0.23) - 0010)*nAC)
	oPrint:Say((nLinIni + 0590)*nAL + nLinA4, (nColIni + 0030)*nAC, "17 - Indicação de Acidente", oFont01) //17 - Indicação de Acidente
	oPrint:Say((nLinIni + 0605)*nAL + nLinA4, (nColIni + 0040)*nAC, "(acidente ou doença relacionada)", oFont01) //(acidente ou doença relacionada)
	oPrint:Say((nLinIni + 0630)*nAL + nLinA4, (nColIni + (nColMax*0.11))*nAC, aDados[nX, 17], oFont04)

	oPrint:Say((nLinIni + 0655)*nAL + nLinA4, (nColIni + 0020)*nAC, "Dados do Atendimento / Procedimento Realizado", oFont01) //Dados do Atendimento / Procedimento Realizado
	oPrint:Box((nLinIni + 0665)*nAL + nLinA4, (nColIni + 0020)*nAC, (nLinIni + 0725)*nAL + nLinA4, (nColIni + (nColMax*0.23) - 0010)*nAC)
	oPrint:Say((nLinIni + 0685)*nAL + nLinA4, (nColIni + 0030)*nAC, "18 - Data do Atendimento", oFont01) //18 - Data do Atendimento
	oPrint:Say((nLinIni + 0717)*nAL + nLinA4, (nColIni + 0040)*nAC, DtoC(aDados[nX, 18]), oFont04)
	oPrint:Box((nLinIni + 0665)*nAL + nLinA4, (nColIni + (nColMax*0.23))*nAC, (nLinIni + 0725)*nAL + nLinA4, (nColIni + (nColMax*0.35) - 0010)*nAC)
	oPrint:Say((nLinIni + 0685)*nAL + nLinA4, (nColIni + (nColMax*0.23) + 0010)*nAC, "19 - Tipo de Consulta", oFont01) //19 - Tipo de Consulta
	oPrint:Say((nLinIni + 0717)*nAL + nLinA4, (nColIni + (nColMax*0.23) + 0020)*nAC, aDados[nX, 19], oFont04)
	oPrint:Box((nLinIni + 0665)*nAL + nLinA4, (nColIni + (nColMax*0.46))*nAC, (nLinIni + 0725)*nAL + nLinA4, (nColIni + (nColMax*0.53) - 0010)*nAC)
	oPrint:Say((nLinIni + 0685)*nAL + nLinA4, (nColIni + (nColMax*0.46) + 0010)*nAC, "20 - Tabela", oFont01) //20 - Tabela
	oPrint:Say((nLinIni + 0717)*nAL + nLinA4, (nColIni + (nColMax*0.46) + 0020)*nAC, aDados[nX, 20], oFont04)
	oPrint:Box((nLinIni + 0665)*nAL + nLinA4, (nColIni + (nColMax*0.53))*nAC, (nLinIni + 0725)*nAL + nLinA4, (nColIni + (nColMax*0.78) - 0010)*nAC)
	oPrint:Say((nLinIni + 0685)*nAL + nLinA4, (nColIni + (nColMax*0.53) + 0010)*nAC, "21 - Código do Procedimento", oFont01) //21 - Código do Procedimento
	oPrint:Say((nLinIni + 0717)*nAL + nLinA4, (nColIni + (nColMax*0.53) + 0020)*nAC, aDados[nX, 21], oFont04)
	oPrint:Box((nLinIni + 0665)*nAL + nLinA4, (nColIni + (nColMax*0.78))*nAC, (nLinIni + 0725)*nAL + nLinA4, (nColIni + nColMax - 0010)*nAC)
	oPrint:Say((nLinIni + 0685)*nAL + nLinA4, (nColIni + (nColMax*0.78) + 0010)*nAC, "22 - Valor do Procedimento", oFont01) //22 - Valor do Procedimento
	oPrint:Say((nLinIni + 0717)*nAL + nLinA4, (nColIni + (nColMax*0.78) + 0020)*nAC, IIf(Empty(aDados[nX, 22]), "", Transform(aDados[nX, 22], "@E 99,999,999.99")), oFont04)

	oPrint:Box((nLinIni + 0735)*nAL + nLinA4, (nColIni + 0020)*nAC, (nLinIni + 1000)*nAL + nLinA4, (nColIni + nColMax - 0010)*nAC)
	oPrint:Say((nLinIni + 0755)*nAL + nLinA4, (nColIni + 0030)*nAC, "23 - Observação / Justificativa", oFont01) //23 - Observação / Justificativa

	For nI := 1 To MlCount(aDados[nX, 23], 100)
		cObs := MemoLine(aDados[nX, 23], 100, nI)
		oPrint:Say((nLinIni + 0800 + nLinObs)*nAL + nLinA4, (nColIni + 0040)*nAC, cObs, oFont04)
		nLinObs+=40
	Next nI

	oPrint:Box((nLinIni + 1010)*nAL + nLinA4, (nColIni + 0020)*nAC, (nLinIni + 1120)*nAL + nLinA4, (nColIni + (nColMax/2) - 0005)*nAC)
	oPrint:Say((nLinIni + 1030)*nAL + nLinA4, (nColIni + 0030)*nAC, "24 - Assinatura do Profissional Executante", oFont01) //24 - Assinatura do Profissional Executante
	oPrint:Box((nLinIni + 1010)*nAL + nLinA4, (nColIni + (nColMax/2) + 0005)*nAC, (nLinIni + 1120)*nAL + nLinA4, (nColIni + nColMax - 0010)*nAC)
	oPrint:Say((nLinIni + 1030)*nAL + nLinA4, (nColIni + (nColMax/2) + 0015)*nAC, "25 - Assinatura do Beneficiário ou Responsável", oFont01) //25 - Assinatura do Beneficiário ou Responsável

	oPrint:EndPage()	// Finaliza a pagina

Next nX


If lGerTXT .And. !lWeb
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
		//³Imprime Relatorio
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
	oPrint:Print()
Else
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
		//³Visualiza impressao grafica antes de imprimir
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
	oPrint:Preview()
EndIf

Return (cFileName)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡ao    ³ PLSTISSE  ³ Autor ³ Bruno Iserhardt       ³ Data ³ 21.06.13 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡ao ³ Estrutura Relatório TISS 3.00.01 (Guia Sol. Internaçao)     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ SigaPLS                                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ aDados - Array com as informações do relat´rio              ³±±
±±³          ³ lGerTXT - Define se imprime direto sem passar pela tela 	   ³±±
±±³          ³			 de configuracao/preview do relatorio 		       ³±±
±±³          ³ nLayout - Define o formato de papél para impressao:         ³±±
±±³          ³           1 - Formato Ofício II (216x330mm)                 ³±±
±±³          ³           2 - Formato A4 (210x297mm)                        ³±±
±±³          ³  		 3 - Formato Carta (216x279mm)     			       ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function CABTISSE(aDados, lGerTXT, nLayout, cLogoGH, lMail, lWeb, cPathRelW, lProrrog)

Local nLinMax
Local nColMax
Local nLinIni	:=	0	// Linha Lateral (inicial) Esquerda
Local nColIni	:=	0	// Coluna Lateral (inicial) Esquerda
Local nColA4    :=  0
Local nLinA4    :=  0
Local cFileLogo
Local nLin
Local nP:=0
Local nT:=0
Local nT1:=0
Local nT3:=0
Local nI,nJ,nK,nX
Local nR,nV,nV1,nV2,nN
Local cObs
Local oFont01
Local oFont02n
Local oFont03n
Local oFont04
Local lImpnovo  :=.T.
Local nVolta    :=0
Local cFile 	:= GetNewPar("MV_RELT",'\SPOOL\')
Local lRet		:= .T.
Local lOk		:= .T.
LOCAL cFileName	:= ""
LOCAL cRel      := "GUICONS"
LOCAL cPathSrvJ := GETMV("MV_RELT")
LOCAL nAL		:= 0.25
LOCAL nAC		:= 0.24
Local lImpPrc   := .T.
Local cCodTab 	:= ""
Local cCodPro 	:= ""
Local cDescri	:= ""
Local lImpNAut	:= IIf(GetNewPar("MV_PLNAUT",0) == 0, .F., .T.) // 0 = Nao imprime procedimento nao autorizado 1 = Sim imprime
LOCAL nLinObs	:= 0
LOCAL cIndic    := ""
LOCAL cErro		:= ""
LOCAL cArq			:= ""
//Local bError		:= ErrorBlock( {|e| TrataErro(e,@cErro) } )

DEFAULT lProrrog 	:= ".F."
DEFAULT lGerTXT 	:= .F.
DEFAULT nLayout 	:= 2
DEFAULT cLogoGH 	:= ""
DEFAULT lMail		:= .F.
DEFAULT lWeb		:= .F.
DEFAULT cPathRelW 	:= ""
DEFAULT aDados 	:= { { ;
	"123456",; //1 - Registro ANS
	"12345678901234567890",; //2- Nº Guia no Prestador
	"12345678901234567890",; //3 - Número da Guia Atribuído pela Operadora
	CtoD("01/01/07"),; //4 - Data da Autorização
	"12345678901234567890",; //5 - Senha
	CtoD("01/01/07"),; //6 – Data de Validade da Senha
	"12345678901234567890",; //7 - Número da Carteira
	CtoD("12/12/07"),; //8 - Validade da Carteira
	"S",; //9-Atendimento de RN
	Replicate("M",70),; //10 - Nome
	"123456789012345",; //11 - Cartão Nacional de Saúde
	"12345678901234",; //12 – Código na Operadora
	Replicate("M",70),; //13 - Nome do Contratado
	Replicate("M",70),; //14 - Nome do Profissional Solicitante
	"MM",; //15 - Conselho Profissional
	"123456789012345",; //16 - Número no Conselho
	"RS",; //17 - UF
	"123456",; //18 - Código CBO
	"12345678901234",; //19- Código na Operadora / CNPJ
	Replicate("M",70),; //20 - Nome do Hospital/Local Solicitado
	CtoD("12/12/07"),; //21 - Data sugerida para internação
	"U",; //22 - Caráter do Atendimento
	"1",; //23-Tipo de Internação
	"1",; //24 - Regime de Internação
	999,; //25 - Qtde. Diárias Solicitadas
	"A",; //26 – Previsão de uso de OPME
	"N",; //27 – Previsão de uso de quimioterápico
	Replicate("M",480),; //28 - Indicação Clínica
	"1234",; //29-CID 10 Principal (opcional)
	"1234",; //30 - CID 10 (2) (opcional)
	"1234",; //31 - CID 10 (3) (opcional)
	"1234",; //32 - CID 10 (4) (opcional)
	"1",; //33 - Indicação de Acidente (acidente ou doença relacionada)
	{ "10","20","30","40","50","60","70","80","90","99","00","11", "11" },; //34-Tabela
	{ "1234567890","2345678901","3456789012","4567890123","5678901234","1234567890","2345678901","3456789012","4567890123","5678901234","4567890123","5678901234","5678901234" },; //35 - Código do Procedimento
	{ Replicate("M",150),Replicate("A",150),Replicate("B",150),Replicate("C",150),Replicate("D",150),Replicate("M",150),Replicate("A",150),Replicate("B",150),Replicate("C",150),Replicate("D",150),Replicate("C",150),Replicate("D",150),Replicate("D",150) },; //36 - Descrição
	{ 999,888,777,666,555,444,333,222,111,999,888,777,777 },; //37 - Qtde Solic
	{ 111,222,333,444,555,1212,111,222,333,444,555,1212,1212 },; //38 – Qtde Aut
	CtoD("12/12/07"),; //39 - Data Provável da Admissão Hospitalar
	123,; //40 - Qtde. Diarias Autorizadas
	"AA",;//41 - Tipo da Acomodação Autorizada
	"12345678901234",; //42 - Código na Operadora / CNPJ autorizado
	Replicate("M",70),; //43 - Nome do Hospital / Local Autorizado
	"1234567",; //44 - Código CNES
	Replicate("O",1000),; //45 – Observação / Justificativa
	CtoD("12/12/07") } } //46-Data da Solicitação

If nLayout  == 1 // Ofício 2
	nLinMax	:=	3705	// Numero maximo de Linhas (31,5 cm)
	nColMax	:=	2400	// Numero maximo de Colunas (21 cm)
Elseif nLayout == 2   // Papél A4
	nLinMax	:=	2350
	nColMax	:=	2335
Else //Carta
	nLinMax	:=	3155
	nColMax	:=	2400
Endif

oFont01		:= TFont():New("Arial",  5,  5, , .F., , , , .T., .F.) // Normal
if nLayout == 1 // Oficio 2
	oFont02n	:= TFont():New("Arial", 12, 12, , .T., , , , .T., .F.) // Negrito
	oFont03n	:= TFont():New("Arial", 14, 14, , .T., , , , .T., .F.) // Negrito
	oFont04		:= TFont():New("Arial", 09, 09, , .F., , , , .T., .F.) // Normal
Else  // Papél A4 ou Carta
	oFont02n := TFont():New("Arial", 12, 12, , .T., , , , .T., .F.) // Negrito
	oFont03n := TFont():New("Arial", 13, 13, , .T., , , , .T., .F.) // Negrito
	oFont04	 := TFont():New("Arial", 07, 07, , .F., , , , .T., .F.) // Normal
Endif

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
	//³ Nao permite acionar a impressao quando for na web.
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
If lWeb
	cPathSrvJ := cPathRelW
	cFileName := cRel+CriaTrab(NIL,.F.)+".pdf"
Else
	cFileName := cRel+CriaTrab(NIL,.F.)+".pdf"
EndIf

	//						New ( < cFilePrintert >, [ nDevice], [ lAdjustToLegacy], [ cPathInServer], [ lDisabeSetup ], [ lTReport], [ @oPrintSetup], [ cPrinter], [ lServer], [ lPDFAsPNG], [ lRaw], [ lViewPDF] )
oPrint := FWMSPrinter():New ( cFileName			,	IMP_PDF		,	.F.				,cPathSrvJ	 	,	.T.				,			 ,				,			  ,			  ,	.F.			, 		, 				)
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
	//³Tratamento para impressao via job
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
	//oPrint:lInJob  := lWeb
oPrint:lServer := lWeb
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
	//³ Caminho do arquivo
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
oPrint:cPathPDF := cPathSrvJ

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
	//³Modo retrato
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
oPrint:SetPortrait()	// Modo retrato

If nLayout ==2
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
		//³Papél A4
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
	oPrint:SetPaperSize(9)
ElseIf nLayout ==3
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
		//³Papél Carta
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
	oPrint:SetPaperSize(1)
Else
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
		//³Papel Oficio2 216 x 330mm / 8 1/2 x 13in
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
	oPrint:SetPaperSize(14)
Endif

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
	//³Device
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
If lWeb
	oPrint:setDevice(IMP_PDF)
	oPrint:lPDFAsPNG := .T.
EndIf
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
	//³Verifica se existe alguma impressora configurada para Impressao Grafica
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
If  !lWeb
	oPrint:Setup()
	If !(oPrint:nModalResult == 1)
		lRet := .F.
		lMail := .F.
	Else
		lImpnovo:=(oPrint:nModalResult == 1)
	Endif
EndIf

If lProrrog == '.T.'
	lProrrog := PPLVERPRR(@aDados)
Else
	lProrrog := .F.
EndIf


BEGIN SEQUENCE
	While lImpnovo

		lImpnovo:=.F.
		nVolta  += 1
		nT      += 12
		nT1     += 2
		nT3     += 3

		For nX := 1 To Len(aDados)

			If Len(aDados[nX]) == 0
				Loop
			EndIf

			For nI := 34 To 38
				If Len(aDados[nX, nI]) < nT
					For nJ := Len(aDados[nX, nI]) + 1 To nT
						If AllTrim(Str(nI)) $ "37,38"
							aAdd(aDados[nX, nI], 0)
						Else
							aAdd(aDados[nX, nI], "")
						EndIf
					Next nJ
				EndIf
			Next nI

			If oPrint:Cprinter == "PDF" .OR. lWeb
				nLinIni	:= 150
			Else
				nLinIni := 000
			Endif

			nColIni := 060
			nColA4  := 000
			nLinA4  := 000

			oPrint:StartPage()		// Inicia uma nova pagina

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Box Principal                                                 ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			oPrint:Box((nLinIni + 0000)*nAL, (nColIni + 0010)*nAC, (nLinIni + nLinMax - 10)*nAL, (nColIni + nColMax)*nAC)

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Carrega e Imprime Logotipo da Empresa                         ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			fLogoEmp(@cFileLogo,, cLogoGH)

			If File(cFilelogo)
				oPrint:SayBitmap((nLinIni + 0050)*nAL, (nColIni + 0020)*nAC, cFileLogo, (400)*nAL, (090)*nAC) 		// Tem que estar abaixo do RootPath
			EndIf

			If nLayout == 2 // Papél A4
				nColA4    := -0065
			Elseif nLayout == 3// Carta
				nLinA4    := -0085
			Endif

			If lProrrog
				oPrint:Say((nLinIni+ 0050)*nAL, (nColIni + (nColMax*0.35))*nAC, "GUIA  DE SOLICITAÇÃO", oFont02n) //"GUIA DE SOLICITAÇÃO DE PRORROGAÇÃO DE "
				oPrint:Say((nLinIni + 0100)*nAL, (nColIni + (nColMax*0.30))*nAC, "DE PRORROGAÇÃO DE INTERNAÇÃO", oFont02n) //"DE INTERNAÇÃO"
				oPrint:Say((nLinIni + 0150)*nAL, (nColIni + (nColMax*0.28))*nAC, "OU COMPLEMENTAÇÃO DO TRATAMENTO", oFont02n) //"DE INTERNAÇÃO"
			Else
				oPrint:Say((nLinIni + 0100)*nAL, (nColIni + (nColMax*0.40))*nAC, "GUIA DE SOLICITAÇÃO", oFont02n) //"GUIA DE SOLICITAÇÃO"
				oPrint:Say((nLinIni + 0150)*nAL, (nColIni + (nColMax*0.42))*nAC, "DE INTERNAÇÃO", oFont02n) //"DE INTERNAÇÃO"
			EndIf
			oPrint:Say((nLinIni + 0100)*nAL, (nColIni + (nColMax*0.70))*nAC, "2- Nº Guia no Prestador", oFont01) //"2- Nº Guia no Prestador"
			oPrint:Say((nLinIni + 0100)*nAL, (nColIni + (nColMax*0.79))*nAC, aDados[nX, 02], oFont03n)

			oPrint:Box((nLinIni + 0180)*nAL, (nColIni + 0020)*nAC, (nLinIni + 0240)*nAL, (nColIni + (nColMax*0.15)- 0010)*nAC)
			oPrint:Say((nLinIni + 0200)*nAL, (nColIni + 0030)*nAC, "1 - Registro ANS", oFont01) //"1 - Registro ANS"
			oPrint:Say((nLinIni + 0232)*nAL, (nColIni + 0040)*nAC, aDados[nX, 01], oFont04)
			oPrint:Box((nLinIni + 0180)*nAL, (nColIni + (nColMax*0.15))*nAC, (nLinIni + 0240)*nAL, (nColIni + (nColMax*0.60) - 0010)*nAC)
			oPrint:Say((nLinIni + 0200)*nAL, (nColIni + (nColMax*0.15) + 0010)*nAC, "3 - Número da Guia Atribuído pela Operadora", oFont01) //"3 - Número da Guia Atribuído pela Operadora"
			oPrint:Say((nLinIni + 0232)*nAL, (nColIni + (nColMax*0.15) + 0020)*nAC, aDados[nX, 03], oFont04)

			oPrint:Box((nLinIni + 0250)*nAL, (nColIni + 0020)*nAC, (nLinIni + 0310)*nAL, (nColIni + (nColMax*0.25) - 0010)*nAC)
			oPrint:Say((nLinIni + 0270)*nAL, (nColIni + 0030)*nAC, "4 - Data da Autorização", oFont01) //"4 - Data da Autorização"


			oPrint:Say((nLinIni + 0302)*nAL, (nColIni + 0040)*nAC,IIF(empty(BE4->BE4_XDTLIB),DtoC(aDados[nX, 04]),dtoc(BE4->BE4_XDTLIB)), oFont04)
			oPrint:Box((nLinIni + 0250)*nAL, (nColIni + (nColMax*0.25))*nAC, (nLinIni + 0310)*nAL, (nColIni + (nColMax*0.70)- 0010)*nAC)
			oPrint:Say((nLinIni + 0270)*nAL, (nColIni + (nColMax*0.25) + 0010)*nAC, "5 - Senha", oFont01) //"5 - Senha"
			// ajuste - para imprimir o Registro da ANS - 04/08/2017 - inicio
			oPrint:Say((nLinIni + 0302)*nAL, (nColIni + (nColMax*0.25) + 0020)*nAC, if(Empty(aDados[nX, 05]) .and. Empty(aDados[nX, 04]) ,aDados[nX, 02],aDados[nX, 05]), oFont04)
			// ajuste - para imprimir o Registro da ANS - 04/08/2017 - fim
			oPrint:Box((nLinIni + 0250)*nAL, (nColIni + (nColMax*0.70))*nAC, (nLinIni + 0310)*nAL, (nColIni + (nColMax*0.95)- 0010)*nAC)
			oPrint:Say((nLinIni + 0270)*nAL, (nColIni + (nColMax*0.70) + 0010)*nAC, "6 - Data de Validade da Senha", oFont01) //"6 - Data de Validade da Senha"
			oPrint:Say((nLinIni + 0302)*nAL, (nColIni + (nColMax*0.70) + 0020)*nAC, DtoC(aDados[nX, 06]), oFont04)

			oPrint:Say((nLinIni + 0330)*nAL, (nColIni + 0020)*nAC, "Dados do Beneficiário", oFont01) //Dados do Beneficiário
			oPrint:Box((nLinIni + 0340)*nAL, (nColIni + 0020)*nAC, (nLinIni + 0400)*nAL, (nColIni + (nColMax*0.50) - 0010)*nAC)
			oPrint:Say((nLinIni + 0360)*nAL, (nColIni + 0030)*nAC, "7 - Número da Carteira", oFont01) //"7 - Número da Carteira"
			oPrint:Say((nLinIni + 0392)*nAL, (nColIni + 0040)*nAC, aDados[nX, 07], oFont04)
			oPrint:Box((nLinIni + 0340)*nAL, (nColIni + (nColMax*0.50))*nAC, (nLinIni + 0400)*nAL, (nColIni + (nColMax*0.73) - 0010)*nAC)
			oPrint:Say((nLinIni + 0360)*nAL, (nColIni + (nColMax*0.50) + 0010)*nAC, "8 - Validade da Carteira", oFont01) //"8 - Validade da Carteira"
			oPrint:Say((nLinIni + 0392)*nAL, (nColIni + (nColMax*0.50) + 0020)*nAC, DtoC(aDados[nX, 08]), oFont04)
			oPrint:Box((nLinIni + 0340)*nAL, (nColIni + (nColMax*0.73))*nAC, (nLinIni + 0400)*nAL, (nColIni + (nColMax*0.85) - 0010)*nAC)
			oPrint:Say((nLinIni + 0360)*nAL, (nColIni + (nColMax*0.73) + 0010)*nAC, "9 - Atendimento de RN", oFont01) //"9 - Atendimento de RN"
			oPrint:Say((nLinIni + 0392)*nAL, (nColIni + (nColMax*0.78))*nAC, aDados[nX, 09], oFont04)

			oPrint:Box((nLinIni + 0410)*nAL, (nColIni + 0020)*nAC, (nLinIni + 0470)*nAL, (nColIni + (nColMax*0.68) - 0010)*nAC)
			oPrint:Say((nLinIni + 0430)*nAL, (nColIni + 0030)*nAC, "10 - Nome", oFont01) //"10 - Nome"
			oPrint:Say((nLinIni + 0462)*nAL, (nColIni + 0040)*nAC, aDados[nX, 10], oFont04)
			oPrint:Box((nLinIni + 0410)*nAL, (nColIni + (nColMax*0.68))*nAC, (nLinIni + 0470)*nAL, (nColIni + nColMax - 0010)*nAC)
			oPrint:Say((nLinIni + 0430)*nAL, (nColIni + (nColMax*0.68) + 0010)*nAC, "11 - Cartão Nacional de Saúde", oFont01) //"11 - Cartão Nacional de Saúde"
			oPrint:Say((nLinIni + 0462)*nAL, (nColIni + (nColMax*0.68) + 0020)*nAC, aDados[nX, 11], oFont04)

			oPrint:Say((nLinIni + 0490)*nAL, (nColIni + 0020)*nAC, "Dados do Contratado Solicitante", oFont01) //Dados do Contratado Solicitante
			oPrint:Box((nLinIni + 0500)*nAL, (nColIni + 0020)*nAC, (nLinIni + 0560)*nAL, (nColIni + (nColMax*0.30) - 0010)*nAC)
			oPrint:Say((nLinIni + 0520)*nAL, (nColIni + 0030)*nAC, "12 - Código na Operadora", oFont01) //"12 - Código na Operadora"
			oPrint:Say((nLinIni + 0552)*nAL, (nColIni + 0040)*nAC, aDados[nX, 12], oFont04)
			oPrint:Box((nLinIni + 0500)*nAL, (nColIni + (nColMax*0.30))*nAC, (nLinIni + 0560)*nAL, (nColIni + nColMax - 0010)*nAC)
			oPrint:Say((nLinIni + 0520)*nAL, (nColIni + (nColMax*0.30) + 0010)*nAC, "13 - Nome do Contratado", oFont01) //"13 - Nome do Contratado"
			oPrint:Say((nLinIni + 0552)*nAL, (nColIni + (nColMax*0.30) + 0020)*nAC, aDados[nX, 13], oFont04)

			oPrint:Box((nLinIni + 0570)*nAL, (nColIni + 0020)*nAC, (nLinIni + 0630)*nAL, (nColIni + (nColMax*0.47) - 0010)*nAC)
			oPrint:Say((nLinIni + 0590)*nAL, (nColIni + 0030)*nAC, "14 - Nome do Profissional Solicitante", oFont01) //"14 - Nome do Profissional Solicitante"
			oPrint:Say((nLinIni + 0622)*nAL, (nColIni + 0040)*nAC, aDados[nX, 14], oFont04)
			oPrint:Box((nLinIni + 0570)*nAL, (nColIni + (nColMax*0.47))*nAC, (nLinIni + 0630)*nAL, (nColIni + (nColMax*0.57) - 0010)*nAC)
			oPrint:Say((nLinIni + 0586)*nAL, (nColIni + (nColMax*0.47) + 0010)*nAC, "15 - Conselho", oFont01) //"15 - Conselho"
			oPrint:Say((nLinIni + 0603)*nAL, (nColIni + (nColMax*0.47) + 0015)*nAC, "Profissional", oFont01) //"Profissional"
			oPrint:Say((nLinIni + 0628)*nAL, (nColIni + (nColMax*0.47) + 0020)*nAC, aDados[nX, 15], oFont04)
			oPrint:Box((nLinIni + 0570)*nAL, (nColIni + (nColMax*0.57))*nAC, (nLinIni + 0630)*nAL, (nColIni + (nColMax*0.82) - 0010)*nAC)
			oPrint:Say((nLinIni + 0590)*nAL, (nColIni + (nColMax*0.57) + 0010)*nAC, "16 - Número no Conselho", oFont01) //"16 - Número no Conselho"
			oPrint:Say((nLinIni + 0622)*nAL, (nColIni + (nColMax*0.57) + 0020)*nAC, aDados[nX, 16], oFont04)
			oPrint:Box((nLinIni + 0570)*nAL, (nColIni + (nColMax*0.82))*nAC, (nLinIni + 0630)*nAL, (nColIni + (nColMax*0.86) - 0010)*nAC)
			oPrint:Say((nLinIni + 0590)*nAL, (nColIni + (nColMax*0.82) + 0010)*nAC, "17 - UF", oFont01) //"17 - UF"
			oPrint:Say((nLinIni + 0622)*nAL, (nColIni + (nColMax*0.82) + 0020)*nAC, aDados[nX, 17], oFont04)
			oPrint:Box((nLinIni + 0570)*nAL, (nColIni + (nColMax*0.86))*nAC, (nLinIni + 0630)*nAL, (nColIni + nColMax - 0010)*nAC)
			oPrint:Say((nLinIni + 0590)*nAL, (nColIni + (nColMax*0.86) + 0010)*nAC, "18 - Código CBO", oFont01) //"18 - Código CBO"
			oPrint:Say((nLinIni + 0622)*nAL, (nColIni + (nColMax*0.86) + 0020)*nAC, aDados[nX, 18], oFont04)

			oPrint:Say((nLinIni + 0650)*nAL, (nColIni + 0020)*nAC, "Dados do Hospital /Local Solicitado / Dados da Internação", oFont01) //Dados do Hospital /Local Solicitado / Dados da Internação
			oPrint:Box((nLinIni + 0660)*nAL, (nColIni + 0020)*nAC, (nLinIni + 0720)*nAL, (nColIni + (nColMax*0.25) - 0010)*nAC)
			oPrint:Say((nLinIni + 0680)*nAL, (nColIni + 0030)*nAC, "19- Código na Operadora / CNPJ", oFont01) //"19- Código na Operadora / CNPJ"
			oPrint:Say((nLinIni + 0712)*nAL, (nColIni + 0040)*nAC, aDados[nX, 19], oFont04)
			oPrint:Box((nLinIni + 0660)*nAL, (nColIni + (nColMax*0.25))*nAC, (nLinIni + 0720)*nAL, (nColIni + (nColMax*0.78) - 0010)*nAC)
			oPrint:Say((nLinIni + 0680)*nAL, (nColIni + (nColMax*0.25) + 0010)*nAC, "20 - Nome do Hospital/Local Solicitado", oFont01) //"20 - Nome do Hospital/Local Solicitado"
			oPrint:Say((nLinIni + 0712)*nAL, (nColIni + (nColMax*0.25) + 0020)*nAC, aDados[nX, 20], oFont04)
			oPrint:Box((nLinIni + 0660)*nAL, (nColIni + (nColMax*0.78))*nAC, (nLinIni + 0720)*nAL, (nColIni + nColMax - 0010)*nAC)
			oPrint:Say((nLinIni + 0680)*nAL, (nColIni + (nColMax*0.78) + 0010)*nAC, "21 - Data sugerida para internação", oFont01) //"20 - Nome do Hospital/Local Solicitado"
			oPrint:Say((nLinIni + 0712)*nAL, (nColIni + (nColMax*0.78) + 0020)*nAC, DtoC(aDados[nX, 21]), oFont04)

			oPrint:Box((nLinIni + 0730)*nAL, (nColIni + 0020)*nAC, (nLinIni + 0790)*nAL, (nColIni + (nColMax*0.17) - 0010)*nAC)
			oPrint:Say((nLinIni + 0750)*nAL, (nColIni + 0030)*nAC, "22 - Caráter do Atendimento", oFont01) //"22 - Caráter do Atendimento"
			oPrint:Say((nLinIni + 0782)*nAL, (nColIni + 0185)*nAC, aDados[nX, 22], oFont04)
			oPrint:Box((nLinIni + 0730)*nAL, (nColIni + (nColMax*0.17))*nAC, (nLinIni + 0790)*nAL, (nColIni + (nColMax*0.29) - 0010)*nAC)
			oPrint:Say((nLinIni + 0750)*nAL, (nColIni + (nColMax*0.17) + 0010)*nAC, "23 - Tipo de Internação", oFont01) //"23-Tipo de Internação"
			oPrint:Say((nLinIni + 0782)*nAL, (nColIni + (nColMax*0.225))*nAC, aDados[nX, 23], oFont04)
			oPrint:Box((nLinIni + 0730)*nAL, (nColIni + (nColMax*0.29))*nAC, (nLinIni + 0790)*nAL, (nColIni + (nColMax*0.44) - 0010)*nAC)
			oPrint:Say((nLinIni + 0750)*nAL, (nColIni + (nColMax*0.29) + 0010)*nAC, "24 - Regime de Internação", oFont01) //"24 - Regime de Internação"
			oPrint:Say((nLinIni + 0782)*nAL, (nColIni + (nColMax*0.36))*nAC, aDados[nX, 24], oFont04)
			oPrint:Box((nLinIni + 0730)*nAL, (nColIni + (nColMax*0.44))*nAC, (nLinIni + 0790)*nAL, (nColIni + (nColMax*0.60) - 0010)*nAC)
			oPrint:Say((nLinIni + 0750)*nAL, (nColIni + (nColMax*0.44) + 0010)*nAC, "25 - Qtde. Diárias Solicitadas", oFont01) //"25 - Qtde. Diárias Solicitadas"
			oPrint:Say((nLinIni + 0782)*nAL, (nColIni + (nColMax*0.51))*nAC, IIf(Empty(aDados[nX, 25]), "", Transform(aDados[nX, 25], "@E 999")), oFont04)
			oPrint:Box((nLinIni + 0730)*nAL, (nColIni + (nColMax*0.60))*nAC, (nLinIni + 0790)*nAL, (nColIni + (nColMax*0.78) - 0010)*nAC)
			oPrint:Say((nLinIni + 0750)*nAL, (nColIni + (nColMax*0.60) + 0010)*nAC, "26 - Previsão de uso de OPME", oFont01) //"26 – Previsão de uso de OPME"
			oPrint:Say((nLinIni + 0782)*nAL, (nColIni + (nColMax*0.68))*nAC, aDados[nX, 26], oFont04)
			oPrint:Box((nLinIni + 0730)*nAL, (nColIni + (nColMax*0.78))*nAC, (nLinIni + 0790)*nAL, (nColIni + nColMax - 0010)*nAC)
			oPrint:Say((nLinIni + 0750)*nAL, (nColIni + (nColMax*0.78) + 0010)*nAC, "27 - Previsão de uso de quimioterápico", oFont01) //"27 – Previsão de uso de quimioterápico"
			oPrint:Say((nLinIni + 0782)*nAL, (nColIni + (nColMax*0.85))*nAC, aDados[nX, 27], oFont04)

			oPrint:Box((nLinIni + 0800)*nAL, (nColIni + 0020)*nAC, (nLinIni + 1040)*nAL, (nColIni + nColMax - 0010)*nAC)
			oPrint:Say((nLinIni + 0820)*nAL, (nColIni + 0030)*nAC, "28 - Indicação Clínica", oFont01) //"28 - Indicação Clínica"
			For nI := 1 To MlCount(aDados[nX, 28], 100)
				cIndic := MemoLine(aDados[nX, 28], 100, nI)
				oPrint:Say((nLinIni + 0852 + nLinObs)*nAL, (nColIni + 0040)*nAC, cIndic, oFont04)
				nLinObs+=40
			Next nI

			oPrint:Say((nLinIni + 1060)*nAL, (nColIni + 0020)*nAC, "Hipóteses Diagnósticas", oFont01) //Hipóteses Diagnósticas
			oPrint:Box((nLinIni + 1070)*nAL, (nColIni + 0020)*nAC, (nLinIni + 1130)*nAL, (nColIni + (nColMax*0.15) - 0010)*nAC)
			oPrint:Say((nLinIni + 1090)*nAL, (nColIni + 0030)*nAC, "29 - CID 10 Principal (opcional)", oFont01) //"29 - CID 10 Principal"
			oPrint:Say((nLinIni + 1122)*nAL, (nColIni + 0040)*nAC, aDados[nX, 29], oFont04)
			oPrint:Box((nLinIni + 1070)*nAL, (nColIni + (nColMax*0.15))*nAC, (nLinIni + 1130)*nAL, (nColIni + (nColMax*0.30) - 0010)*nAC)
			oPrint:Say((nLinIni + 1090)*nAL, (nColIni + (nColMax*0.15) + 0010)*nAC, "30 - CID 10 (2) (opcional)", oFont01) //"30 - CID 10 (2)"
			oPrint:Say((nLinIni + 1122)*nAL, (nColIni + (nColMax*0.15) + 0020)*nAC, aDados[nX, 30], oFont04)
			oPrint:Box((nLinIni + 1070)*nAL, (nColIni + (nColMax*0.30))*nAC, (nLinIni + 1130)*nAL, (nColIni + (nColMax*0.45) - 0010)*nAC)
			oPrint:Say((nLinIni + 1090)*nAL, (nColIni + (nColMax*0.30) + 0010)*nAC, "31 - CID 10 (3) (opcional)", oFont01) //"31 - CID 10 (3)"
			oPrint:Say((nLinIni + 1122)*nAL, (nColIni + (nColMax*0.30) + 0020)*nAC, aDados[nX, 31], oFont04)
			oPrint:Box((nLinIni + 1070)*nAL, (nColIni + (nColMax*0.45))*nAC, (nLinIni + 1130)*nAL, (nColIni + (nColMax*0.60) - 0010)*nAC)
			oPrint:Say((nLinIni + 1090)*nAL, (nColIni + (nColMax*0.45) + 0010)*nAC, "32 - CID 10 (4) (opcional)", oFont01) //"32 - CID 10 (4)"
			oPrint:Say((nLinIni + 1122)*nAL, (nColIni + (nColMax*0.45) + 0020)*nAC, aDados[nX, 32], oFont04)
			oPrint:Box((nLinIni + 1070)*nAL, (nColIni + (nColMax*0.60))*nAC, (nLinIni + 1130)*nAL, (nColIni + nColMax - 0010)*nAC)
			oPrint:Say((nLinIni + 1090)*nAL, (nColIni + (nColMax*0.60) + 0010)*nAC, "33 - Indicação de Acidente (acidente ou doença relacionada)", oFont01) //"33 - Indicação de Acidente (acidente ou doença relacionada)"
			oPrint:Say((nLinIni + 1122)*nAL, (nColIni + (nColMax*0.60) + 0020)*nAC, aDados[nX, 33], oFont04)

			oPrint:Say((nLinIni + 1150)*nAL, (nColIni + 0020)*nAC, "Procedimentos Solicitados", oFont01) //Procedimentos Solicitados
			oPrint:Box((nLinIni + 1160)*nAL, (nColIni + 0020)*nAC, (nLinIni + 1670)*nAL, (nColIni + nColMax - 0010)*nAC)
			oPrint:Say((nLinIni + 1180)*nAL, (nColIni + (nColMax*0.02))*nAC, "34 - Tabela", oFont01) //34-Tabela
			oPrint:Say((nLinIni + 1180)*nAL, (nColIni + (nColMax*0.08))*nAC, "35 - Código do Procedimento", oFont01) //35 - Código do Procedimento
			oPrint:Say((nLinIni + 1180)*nAL, (nColIni + (nColMax*0.19))*nAC, "36 - Descrição", oFont01) //36 - Descrição
			oPrint:Say((nLinIni + 1180)*nAL, (nColIni + (nColMax*0.80))*nAC, "37 - Qtde Solic", oFont01) //37 - Qtde Solic
			oPrint:Say((nLinIni + 1180)*nAL, (nColIni + (nColMax*0.90))*nAC, "38 - Qtde Aut", oFont01) //38 – Qtde Aut

			nOldLinIni := nLinIni

			if nVolta=1
				nV1:=1
			Endif


			cOper := substr(aDados[nX, 2],1,4)
			cAno  := substr(aDados[nX, 2],6,4)
			cMes  := substr(aDados[nX, 2],11,2)
			cAut  := substr(aDados[nX, 2],14,8)

			/*DbSelectArea("BEA")
			BEA->(dbSetOrder(1))
			If BEA->(DbSeek(xFilial("BEA")+cOper+cAno+cMes+cAut))
				If BEA->BEA_LIBERA == '0'
					//se eh uma execucao eu tenho que refazer os procedimentos que foram solicitados
					If !Empty(BEA->BEA_NRLBOR)
						xChave := alltrim(BEA->BEA_NRLBOR)
					Else
						xChave := alltrim(cOper+cAno+cMes+cAut)
					Endif
				Else
					//se eh uma solicitacao eu tenho que refazer os procedimentos que foram solicitados e autorizados
					xChave := alltrim(cOper+cAno+cMes+cAut)
				Endif

				BE2->(DbSetORder(1))
				if !Empty(xChave) .and. BE2->(MsSeek(xFilial('BE2')+alltrim(xChave)))
					aDados[nX, 34] := {}
					aDados[nX, 35] := {}
					aDados[nX, 36] := {}
					aDados[nX, 37] := {}
					aDados[nX, 38] := {}
					While !BE2->(Eof()) .and. xFilial('BE2')+xChave == BE2->(BE2_FILIAL+BE2_OPEMOV+BE2_ANOAUT+BE2_MESAUT+BE2_NUMAUT)
						If (BE2->BE2_STATUS == '0' .And. lImpNAut) .Or. BE2->BE2_STATUS == '1'

							BD6->(DbSetOrder(6))
							If BD6->(MsSeek(xFilial("BD6")+BEA->(BEA_OPEMOV+BEA_CODLDP+BEA_CODPEG+BEA_NUMGUI)+'1'+BE2->(BE2_CODPAD+BE2_CODPRO))) .and. !Empty(BD6->BD6_SLVPAD)
								cCodTab := CABIMPVINC("BR4","87"	,	BD6->BD6_CODPAD					,.F.)
								cCodPro := CABIMPVINC("BR8",cCodTab	,	BD6->BD6_CODPAD+BD6->BD6_CODPRO	,.F.)
								cDescri := CABIMPVINC("BR8",cCodTab	,	BD6->BD6_CODPAD+BD6->BD6_CODPRO	,.T.)
							Else
								cCodTab := CABIMPVINC("BR4","87"	,	BE2->BE2_CODPAD					,.F.)
								cCodPro := CABIMPVINC("BR8",cCodTab	,	BE2->BE2_CODPAD+BE2->BE2_CODPRO	,.F.)
								cDescri := CABIMPVINC("BR8",cCodTab	,	BE2->BE2_CODPAD+BE2->BE2_CODPRO	,.T.)
							Endif

							If Empty(cCodTab) .Or. Empty(cCodPro) .Or. Empty(cDescri)
								cCodTab := BE2->BE2_CODPAD
								cCodPro := BE2->BE2_CODPRO
								cDescri := Posicione("BR8",1, xFilial("BR8")+BE2->(BE2_CODPAD+BE2_CODPRO), "BR8_DESCRI")
							Endif

							aAdd(aDados[nX, 34], cCodTab)
							aAdd(aDados[nX, 35], cCodPro)
							aAdd(aDados[nX, 36], cDescri)
							aAdd(aDados[nX, 37], BE2->BE2_QTDSOL)
							aAdd(aDados[nX, 38], BE2->BE2_QTDPRO)

						Endif
						BE2->(DbSkip())
					Enddo*/
					/*For nI := 34 To 38
						If Len(aDados[nX, nI]) < nT
							For nJ := Len(aDados[nX, nI]) + 1 To nT
								If AllTrim(Str(nI)) $ "37,38"
									aAdd(aDados[nX, nI], 0)
								Else
									aAdd(aDados[nX, nI], "")
								EndIf
							Next nJ
						EndIf
					Next nI
				Endif
			Endif*/

			If ExistBlock("PLSGTISS")
				lImpPrc := ExecBlock("PLSGTISS",.F.,.F.,{"03",lImpPrc})
			EndIf

			If lImpPrc
//				nT := len(aDados[nX, 34])
				For nP := nV1 To nT
						if nVolta <> 1
							nN:=nP-((5*nVolta)-5)
							oPrint:Say((nLinIni + 1220)*nAL, (nColIni + 0025)*nAC, AllTrim(Str(nN)) + " - ", oFont01)
						else
							oPrint:Say((nLinIni + 1220)*nAL, (nColIni + 0025)*nAC, AllTrim(Str(nP)) + " - ", oFont01)
						endif
						oPrint:Say((nLinIni + 1220)*nAL, (nColIni + (nColMax*0.03))*nAC, aDados[nX, 34, nP], oFont04)
						oPrint:Say((nLinIni + 1220)*nAL, (nColIni + (nColMax*0.08))*nAC, aDados[nX, 35, nP], oFont04)
						oPrint:Say((nLinIni + 1220)*nAL, (nColIni + (nColMax*0.19))*nAC, aDados[nX, 36, nP], oFont01)
						oPrint:Say((nLinIni + 1220)*nAL, (nColIni + (nColMax*0.82))*nAC, if (aDados[nX, 37, nP]=0,"",Transform(aDados[nX, 37, nP], "@E 999")), oFont04,,,,1)
						oPrint:Say((nLinIni + 1220)*nAL, (nColIni + (nColMax*0.92))*nAC, if (aDados[nX, 38, nP]=0,"",Transform(aDados[nX, 38, nP], "@E 999")), oFont04,,,,1)
						nLinIni += 40
				Next nP
			EndIF

			if nT < Len(aDados[nX, 35]).or. lImpnovo
				nV1:=nP
				lImpnovo:=.T.
			Endif

			nLinIni := nOldLinIni

			oPrint:Say((nLinIni + 1690)*nAL, (nColIni + 0020)*nAC, "Dados da Autorização", oFont01) //Dados da Autorização
			oPrint:Box((nLinIni + 1700)*nAL, (nColIni + 0020)*nAC, (nLinIni + 1760)*nAL, (nColIni + (nColMax*0.26) - 0010)*nAC)
			oPrint:Say((nLinIni + 1720)*nAL, (nColIni + 0030)*nAC, "39 - Data Provável da Admissão Hospitalar", oFont01) //"39 - Data Provável da Admissão Hospitalar"
			oPrint:Say((nLinIni + 1752)*nAL, (nColIni + 0040)*nAC, DtoC(aDados[nX, 39]), oFont04)
			oPrint:Box((nLinIni + 1700)*nAL, (nColIni + (nColMax*0.26))*nAC, (nLinIni + 1760)*nAL, (nColIni + (nColMax*0.44) - 0010)*nAC)
			oPrint:Say((nLinIni + 1720)*nAL, (nColIni + (nColMax*0.26) + 0010)*nAC, "40 - Qtde. Diarias Autorizadas", oFont01) //"40 - Qtde. Diarias Autorizadas"
			oPrint:Say((nLinIni + 1752)*nAL, (nColIni + (nColMax*0.34))*nAC, if (aDados[nX, 40]=0,"",Transform(aDados[nX, 40], "@E 999")), oFont04)
			oPrint:Box((nLinIni + 1700)*nAL, (nColIni + (nColMax*0.44))*nAC, (nLinIni + 1760)*nAL, (nColIni + (nColMax*0.66) - 0010)*nAC)
			oPrint:Say((nLinIni + 1720)*nAL, (nColIni + (nColMax*0.44) + 0010)*nAC, "41 - Tipo da Acomodação Autorizada", oFont01) //"41 - Tipo da Acomodação Autorizada"
			oPrint:Say((nLinIni + 1752)*nAL, (nColIni + (nColMax*0.54))*nAC, aDados[nX, 41], oFont04)

			oPrint:Box((nLinIni + 1770)*nAL, (nColIni + 0020)*nAC, (nLinIni + 1830)*nAL, (nColIni + (nColMax*0.27) - 0010)*nAC)
			oPrint:Say((nLinIni + 1790)*nAL, (nColIni + 0030)*nAC, "42 - Código na Operadora / CNPJ autorizado", oFont01) //"42 - Código na Operadora / CNPJ autorizado"
			oPrint:Say((nLinIni + 1822)*nAL, (nColIni + 0040)*nAC, aDados[nX, 42], oFont04)
			oPrint:Box((nLinIni + 1770)*nAL, (nColIni + (nColMax*0.27))*nAC, (nLinIni + 1830)*nAL, (nColIni + (nColMax*0.82) - 0010)*nAC)
			oPrint:Say((nLinIni + 1790)*nAL, (nColIni + (nColMax*0.27) + 0010)*nAC, "43 - Nome do Hospital / Local Autorizado", oFont01) //"43 - Nome do Hospital / Local Autorizado"
			oPrint:Say((nLinIni + 1822)*nAL, (nColIni + (nColMax*0.27) + 0020)*nAC, aDados[nX, 43], oFont04)
			oPrint:Box((nLinIni + 1770)*nAL, (nColIni + (nColMax*0.82))*nAC, (nLinIni + 1830)*nAL, (nColIni + nColMax - 0010)*nAC)
			oPrint:Say((nLinIni + 1790)*nAL, (nColIni + (nColMax*0.82) + 0010)*nAC, "44 - Código CNES", oFont01) //"44 - Código CNES"
			oPrint:Say((nLinIni + 1822)*nAL, (nColIni + (nColMax*0.82) + 0020)*nAC, aDados[nX, 44], oFont04)

			oPrint:Box((nLinIni + 1840)*nAL, (nColIni + 0020)*nAC, (nLinIni + 2260)*nAL, (nColIni + nColMax - 0010)*nAC)
			oPrint:Say((nLinIni + 1860)*nAL, (nColIni + 0030)*nAC, "45 - Observação / Justificativa", oFont01) //"45 – Observação / Justificativa"

			nLinObs := 0
			For nI := 1 To MlCount(aDados[nX, 45], 100)
				cObs := MemoLine(aDados[nX, 45], 100, nI)
				oPrint:Say((nLinIni + 1892 + nLinObs)*nAL, (nColIni + 0040)*nAC, cObs, oFont04)
				nLinObs+=38
			Next nI

			oPrint:Box((nLinIni + 2270)*nAL, (nColIni + 0020)*nAC, (nLinIni + 2330)*nAL, (nColIni + (nColMax/4) - 0010)*nAC)
			oPrint:Say((nLinIni + 2290)*nAL, (nColIni + 0030)*nAC, "46 - Data da Solicitação", oFont01) //"46 - Data da Solicitação"
			oPrint:Say((nLinIni + 2322)*nAL, (nColIni + 0040)*nAC, DtoC(aDados[nX, 46]), oFont04)
			oPrint:Box((nLinIni + 2270)*nAL, (nColIni + (nColMax/4))*nAC, (nLinIni + 2330)*nAL, (nColIni + ((nColMax/4)*2) - 0010)*nAC)
			oPrint:Say((nLinIni + 2290)*nAL, (nColIni + (nColMax/4) + 0010)*nAC, "47-Assinatura do Profissional Solicitante", oFont01) //"47-Assinatura do Profissional Solicitante"
			oPrint:Box((nLinIni + 2270)*nAL, (nColIni + ((nColMax/4)*2))*nAC, (nLinIni + 2330)*nAL, (nColIni + ((nColMax/4)*3) - 0010)*nAC)
			oPrint:Say((nLinIni + 2290)*nAL, (nColIni + ((nColMax/4)*2) + 0010)*nAC, "48-Assinatura do Beneficiário ou Responsável", oFont01) //"48-Assinatura do Beneficiário ou Responsável"
			oPrint:Box((nLinIni + 2270)*nAL, (nColIni + ((nColMax/4)*3))*nAC, (nLinIni + 2330)*nAL, (nColIni + nColMax - 0010)*nAC)
			oPrint:Say((nLinIni + 2290)*nAL, (nColIni + ((nColMax/4)*3) + 0010)*nAC, "49-Assinatura do Responsável pela Autorização", oFont01) //"49-Assinatura do Responsável pela Autorização"

			oPrint:EndPage()	// Finaliza a pagina

		Next nX

	enddo
END SEQUENCE
//ErrorBlock( bError )

If !Empty(cErro)
	cArq := "erro_imp_relat_" + DtoS(Date()) + StrTran(Time(),":") + ".txt"
	MsgAlert("Erro ao gerar relatório. Visualize o log em /LOGPLS/" + cArq )
	cErro := 	"Erro ao carregar dados do relatório." + CRLF + ;
		"Verifique a cfg. de impressão da guia no cadastro de " + CRLF + ;
		"Tipos de Guias." + CRLF + CRLF + ;
		cErro
	PLSLogFil(cErro,cArq)
EndIf

If lGerTXT .And. !lWeb
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
		//³Imprime Relatorio
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
	oPrint:Print()
Else
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
		//³Visualiza impressao grafica antes de imprimir
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
	If lRet

		oPrint:Preview()
	Endif

	If lMail .And. (lRet:=Aviso("Atenção","Confirma o envio do relatório por e-mail?",{"Sim","Não"},1)== 1)

		If File(cFile)
			lOk := (FErase(cFile)==0)
		EndIf

		If lOk
			CpyT2S(oPrint:CPATHPDF+LOWER(cFileName),cFile,.T.)
		Else
			Aviso("Atenção","Não foi possível criar o arquivo "+cFile,{"Ok"},1)
			lRet := .F.
		EndIf
	EndIf
EndIf

Return {lRet,cFile+cFileName,cFileName}

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡ao    ³ PLSTISSF  ³ Autor ³ Bruno Iserhardt       ³ Data ³ 25.06.13 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡ao ³ Estrutura Relatório TISS 3.00.01 (Guia Res. Internaçao)     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ SigaPLS                                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ aDados - Array com as informações do relat´rio              ³±±
±±³          ³ lGerTXT - Define se imprime direto sem passar pela tela 	   ³±±
±±³          ³			 de configuracao/preview do relatorio 		       ³±±
±±³          ³ nLayout - Define o formato de papél para impressao:         ³±±
±±³          ³           1 - Formato Ofício II (216x330mm)                 ³±±
±±³          ³           2 - Formato A4 (210x297mm)                        ³±±
±±³          ³  		 3 - Formato Carta (216x279mm)     			       ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function CABTISSF(aDados, lGerTXT, nLayout, cLogoGH,lWeb, cPathRelW)

Local nLinMax
	Local nColMax
	Local nLinIni := 0		// Linha Lateral (inicial) Esquerda
	Local nColIni := 0		// Coluna Lateral (inicial) Esquerda
    Local nColA4  := 0
    Local nCol2A4 := 0
	Local cFileLogo
	Local lPrinter
	Local nLin 	:= 0
	Local nOldLinIni
	Local nI, nJ, nX, nN
	Local cObs
	Local oFont01
	Local oFont02n
	Local oFont03n
	Local oFont04
	Local lImpnovo:=.T.
	Local nVolta  := 0
	Local nP   	  := 0
	Local nP1     := 0
	Local nP2     := 0
	Local nP3     := 0
	Local nP4     := 0
	Local nP5     := 0
	Local nT      := 0
	Local nT1     := 0
	Local nT2     := 0
	Local nT3     := 0
	Local nT4     := 0
	Local nAte    := 22
	Local nAte1   := 26
	Local nAte2   := 5

	LOCAL nLwebC := 0
	LOCAL nLweb  := 0
	LOCAl nTweb  := 1
	LOCAL nWeb	  := 0
	local oPrint  := nil	//07-12
	LOCAL cPathSrvJ := GETMV("MV_RELT") //07-12
	LOCAL cFileName := "" //07-12
	LOCAL cErro		:= ""
	LOCAL cArq			:= ""
	LOCAL cRel      := "resinte"
//	Local bError		:= ErrorBlock( {|e| TrataErro(e,@cErro) } )

	Default lGerTXT := .F.
	Default nLayout := 2
	Default cLogoGH := ''
	DEFAULT lWeb		:= .F. /*07-12*/
	DEFAULT cPathRelW 	:= ""  /*07-12*/

	Default aDados := { { ;
						"123456",; //1 - Registro ANS
						"12345678901234567890",; //2- Nº Guia no Prestador
						"12345678901234567890",; //3 - Número da Guia de Solicitação de Internação
						CtoD("01/01/07"),; //4 - Data da Autorização
						"12345678901234567890",; //5 - Senha
						CtoD("01/01/07"),; //6 - Data de Validade da Senha
						"12345678901234567890",; //7- Número da Guia Atribuído pela Operadora
						"12345678901234567890",; //8 - Número da Carteira
						CtoD("12/12/07"),; //9 - Validade da Carteira
						Replicate("M",70),; //10- Nome
						"123456789012345",; //11 - Cartão Nacional de Saúde
						"S",; //12-Atendimento a RN
						"12345678901234",; //13 - Código na Operadora
						Replicate("M",70),; //14 - Nome do Contratado
						"1234567",; //15 - Código CNES
						"U",; //16 - Caráter do Atendimento
						"T",; //17 - Tipo de Faturamento
						CtoD("12/12/07"),; //18- Data do Início do Faturamento
						"00:00",; //19- Hora do Início do Faturamento
						CtoD("12/12/07"),; //20- Data do Fim do Faturamento
						"99:99",; //21- Hora do Fim do Faturamento
						"I",; //22- Tipo de Internação
						"E",; //23- Regime de Internação
						"0000",; //24 - CID 10 Principal
						"1111",; //25 - CID 10 (2)
						"2222",; //26 - CID 10 (3)
						"3333",; //27 - CID 10 (4)
						"1",; //28 - Indicação de Acidente (acidente ou doença relacionada)
						"00",; //29 - Motivo de Encerramento da Internação
						"12345678901",; //30-Número da declaração de nascido vivo
						"4444",; //31 - CID 10 Óbito
						"12345678901",; //32 - Numero da declaração de óbito
						"N",; //33 -Indicador D.O. de RN
						{ CtoD("12/01/06"),CtoD("12/02/06"),CtoD("12/03/06"),CtoD("12/03/06"),CtoD("12/03/06")},; //34-Data
						{ "0107","0207","0307","0407","0507"},; //35-Hora Inicial
						{ "0607","0707","0807","0907","1007"},; //36-Hora Final
						{ "10", "20", "30", "40", "50", "60" },; //37-Tabela
						{ "1234567890","2345678901","3456789012","4567890123","5678901234","5678901234"},; //38-Código do Procedimento
						{ Replicate("M",60),Replicate("B",60),Replicate("C",60),Replicate("D",60),Replicate("E",60),Replicate("E",60)},; //39-Descrição
						{ "0", "1", "2", "3", "4"},; //40-Qtde.
						{ "0", "1", "2", "3", "4"},; //41-Via
						{ "0", "1", "2", "3", "4"},; //42-Téc
						{ 111.00,222.00,333.00,444.00,999.99},; //43-Fator Red/Acresc
						{ 99999.99,22222.22,33.33,44444.44},; //44-Valor Unitário (R$)
						{ 111111.11,555555.00,666666.00,777777.00,888888.00},; //45-Valor Total (R$)
						{ "01", "02", "03", "04", "05"},; //46-Seq.Ref
						{ "02", "03", "04", "05", "06"},; //47-Grau Part.
						{ Replicate("M",14), Replicate("D",14), Replicate("C",14), Replicate("A",14)},; //48-Código na Operadora/CPF
						{ Replicate("A", 70), Replicate("B", 70), Replicate("C", 70), Replicate("D", 70), Replicate("E", 70)},; //49-Nome do Profissional
						{ "01", "01", "01", "01", "01", "01", "01", "01", "01", "01", "01"},; //50-Conselho Profissional
						{ "123456789102345", "123456789102345", "123456789102345", "123456789102345", "123456789102345"},; //51-Número no Conselho
						{ "01", "02", "03", "04", "05",},; //52-UF
						{ "123456", "123456", "123456", "123456", "123456"},; //53-Código CBO
						19999900.99,; //54 - Total de Procedimentos (R$)
						19999900.99,; //55 - Total de Diárias (R$)
						19999900.99,; //56 - Total de Taxase Aluguéis (R$)
						19999900.99,; //57 - Total de Materiais (R$)
						19999900.99,; //59- Total de OPME (R$)
						19999900.99,; //58 - Total de Medicamentos (R$)
						19999900.99,; //60 - Total de Gases Medicinais (R$)
						19999900.99,; //61 - Total Geral (R$)
						CtoD("01/01/07"),; //62- Data da assinatura do contratado
						Replicate("M",500) } } //65 – Observações / Justificativa

If nLayout  == 1 // Ofício 2
	nLinMax := 2385
	nColMax := 3705	//3765
Elseif nLayout == 2   // Papél A4
   	nLinMax	:=	2325
	nColMax	:=	3370 //3365
Else //Carta
	nLinMax	:=	2385
	nColMax	:=	3175
Endif

oFont01		:= TFont():New("Arial",  6,  5, , .F., , , , .T., .F.) // Normal
if nLayout == 1 // Oficio 2
	oFont02n	:= TFont():New("Arial", 12, 12, , .T., , , , .T., .F.) // Negrito
	oFont03n	:= TFont():New("Arial", 14, 14, , .T., , , , .T., .F.) // Negrito
	oFont04		:= TFont():New("Arial", 09, 09, , .F., , , , .T., .F.) // Normal
Else  // Papél A4 ou Carta
  	oFont02n	:= TFont():New("Arial", 11, 11, , .T., , , , .T., .F.) // Negrito
	oFont03n	:= TFont():New("Arial", 13, 13, , .T., , , , .T., .F.) // Negrito
	oFont04		:= TFont():New("Arial", 08, 08, , .F., , , , .T., .F.) // Normal
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
//³ Nao permite acionar a impressao quando for na web.
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
If lWeb
	cPathSrvJ := cPathRelW
	cFileName := cRel+lower(CriaTrab(NIL,.F.))+".pdf"
Else
	cFileName := cRel+CriaTrab(NIL,.F.)
EndIf

if !lWeb
	oPrint	:= TMSPrinter():New("GUIA DE RESUMO DE INTERNACAO") //"GUIA DE RESUMO DE INTERNACAO"
else
	oPrint := FWMSPrinter():New ( cFileName	,,.F.,cPathSrvJ	 ,.T.,	,@oPrint,			  ,			  ,	.F.			,.f.)
	If lSrvUnix
		AjusPath(@oPrint)
	EndIf
	nTweb		:= 3.9
	nLweb		:= 10
	nLwebC		:= -3
	nColMax		:= 3100
	nWeb		:= 25
	oPrint:lServer := lWeb
Endif

oPrint:SetLandscape()		// Modo paisagem

if nLayout ==2
	oPrint:SetPaperSize(9)// Papél A4
Elseif nLayout ==3
	oPrint:SetPaperSize(1)// Papél Carta
Else
	oPrint:SetPaperSize(14) //Papel Oficio2 216 x 330mm / 8 1/2 x 13in
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
//³Device
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
If lWeb
	oPrint:setDevice(IMP_PDF)
Else
	// Verifica se existe alguma impressora configurada para Impressao Grafica
	lPrinter := oPrint:IsPrinterActive()

	If ! lPrinter
		oPrint:Setup()
	EndIf
Endif

BEGIN SEQUENCE
	While lImpnovo

		lImpnovo:=.F.
		nVolta  += 1
		nAte    += nP
		nAte1   += nP1
		nAte2   += nP4

		For nX := 1 To Len(aDados)

			If Len(aDados[nX]) == 0
				Loop
			EndIf

			For nI := 34 To 45
				If Len(aDados[nX, nI]) < nAte
					For nJ := Len(aDados[nX, nI]) + 1 To nAte
						If AllTrim(Str(nI)) $ "34"
							aAdd(aDados[nX, nI], StoD(""))
						ElseIf AllTrim(Str(nI)) $ "40,43,44,45"
							aAdd(aDados[nX, nI], 0)
						Else
							aAdd(aDados[nX, nI], "")
						EndIf
					Next nJ
				EndIf
			Next nI

			For nI := 46 To 53
				If Len(aDados[nX, nI]) < nAte1
					For nJ := Len(aDados[nX, nI]) + 1 To nAte1
						aAdd(aDados[nX, nI], "")
					Next nJ
				EndIf
			Next nI

			nLinIni := 080
			nColIni := 080
			nLin 	:= 000
			nColA4  := 000
			nCol2A4 := 000

			oPrint:StartPage()		// Inicia uma nova pagina
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Box Principal                                                 ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			oPrint:Box((nLinIni + 0000)/nTweb, (nColIni + 0000)/nTweb, (nLinIni + nLinMax)/nTweb, (nColIni + nColMax)/nTweb)
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Carrega e Imprime Logotipo da Empresa                         ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			fLogoEmp(@cFileLogo,, cLogoGH)

			If File(cFilelogo)
				oPrint:SayBitmap((nLinIni + 0050)/nTweb, (nColIni + 0020)/nTweb, cFileLogo, (400)/nTweb, (080)/nTweb)
			EndIf

			If nLayout == 2 // Papél A4
				nColA4    := -0335
			Elseif nLayout == 3// Carta
				nColA4    := -0530
			Endif

			oPrint:Say((nLinIni + 0080)/nTweb, ((nColIni + nColMax)*0.47)/nTweb, "GUIA DE RESUMO DE INTERNAÇÃO", oFont02n,,,, 2) //ANEXO DE SOLICITAÇÃO DE RADIOTERAPIA
			oPrint:Say((nLinIni + 0090)/nTweb, (nColMax - 750)/nTweb, "2- Nº Guia no Prestador", oFont01) //2- Nº Guia no Prestador
			oPrint:Say((nLinIni + 0090)/nTweb, (nColMax - 480)/nTweb, aDados[nX, 02], oFont03n)

			oPrint:Box((nLinIni + 0150 -nWeb) /nTweb, (nColIni + 0020) /nTweb, (nLinIni + 0220 - nWeb) /nTweb, (nColIni + (nColMax*0.10) - 0010) /nTweb)
			oPrint:Say((nLinIni + 0155) /nTweb, (nColIni + 0030) /nTweb, "1 - Registro ANS", oFont01) //"1 - Registro ANS"
			oPrint:Say((nLinIni + 0185) /nTweb, (nColIni + 0040) /nTweb, aDados[nX, 01], oFont04)
			oPrint:Box((nLinIni + 0150 - nWeb) /nTweb, (nColIni + (nColMax*0.10)) /nTweb, (nLinIni + 0220 - nWeb) /nTweb, (nColIni + (nColMax*0.36) - 0010) /nTweb)
			oPrint:Say((nLinIni + 0155) /nTweb, (nColIni + (nColMax*0.10) + 0010) /nTweb, "3 - Número da Guia de Solicitação de Internação", oFont01) //"3 - Número da Guia de Solicitação de Internação"
			oPrint:Say((nLinIni + 0185) /nTweb, (nColIni + (nColMax*0.10) + 0020) /nTweb, aDados[nX, 03], oFont04)

			oPrint:Box((nLinIni + 0230 - nWeb) /nTweb, (nColIni + 0020) /nTweb, (nLinIni + 0300 - nWeb) /nTweb, (nColIni + (nColMax*0.14) - 0010) /nTweb)
			oPrint:Say((nLinIni + 0235) /nTweb, (nColIni + 0030) /nTweb, "4 - Data da Autorização", oFont01) //"4 - Data da Autorização"
			oPrint:Say((nLinIni + 0265) /nTweb, (nColIni + 0040) /nTweb, DtoC(aDados[nX, 04]), oFont04)
			oPrint:Box((nLinIni + 0230 - nWeb) /nTweb, (nColIni + (nColMax*0.14)) /nTweb, (nLinIni + 0300 - nWeb) /nTweb, (nColIni + (nColMax*0.42) - 0010) /nTweb)
			oPrint:Say((nLinIni + 0235) /nTweb, (nColIni + (nColMax*0.14) + 0010) /nTweb, "5 - Senha", oFont01) //"5 - Senha"
			oPrint:Say((nLinIni + 0265) /nTweb, (nColIni + (nColMax*0.14) + 0020) /nTweb, aDados[nX, 05], oFont04)
			oPrint:Box((nLinIni + 0230 - nWeb) /nTweb, (nColIni + (nColMax*0.42)) /nTweb, (nLinIni + 0300 - nWeb) /nTweb, (nColIni + (nColMax*0.55) - 0010) /nTweb)
			oPrint:Say((nLinIni + 0235) /nTweb, (nColIni + (nColMax*0.42) + 0010) /nTweb, "6 - Data de Validade da Senha", oFont01) //"6 - Data de Validade da Senha"
			oPrint:Say((nLinIni + 0265) /nTweb, (nColIni + (nColMax*0.42) + 0020) /nTweb, DtoC(aDados[nX, 06]), oFont04)
			oPrint:Box((nLinIni + 0230 -nWeb) /nTweb, (nColIni + (nColMax*0.55)) /nTweb, (nLinIni + 0300 - nWeb) /nTweb, (nColIni + (nColMax*0.82) - 0010) /nTweb)
			oPrint:Say((nLinIni + 0235) /nTweb, (nColIni + (nColMax*0.55) + 0010) /nTweb, "7- Número da Guia Atribuído pela Operadora", oFont01) //"7- Número da Guia Atribuído pela Operadora"
			oPrint:Say((nLinIni + 0265) /nTweb, (nColIni + (nColMax*0.55) + 0020) /nTweb, aDados[nX, 07], oFont04)

			If !lWeb
				AddTBrush(oPrint, nLinIni + 0307, nColIni + 0010, nLinIni + 0337, nColIni + nColMax)
			EndIf

			oPrint:Say((nLinIni + 0310) /nTweb, (nColIni + 0020) /nTweb, "Dados do Beneficiário", oFont01) //"Dados do Beneficiário"
			oPrint:Box((nLinIni + 0340 - nWeb) /nTweb, (nColIni + 0020) /nTweb, (nLinIni + 0410 - nWeb) /nTweb, (nColIni + (nColMax*0.15) - 00100 /nTweb))
			oPrint:Say((nLinIni + 0345) /nTweb, (nColIni + 0030) /nTweb, "8 - Número da Carteira", oFont01) //"8 - Número da Carteira"
			oPrint:Say((nLinIni + 03750) /nTweb, (nColIni + 00400) /nTweb, aDados[nX, 08], oFont04)
			oPrint:Box((nLinIni + 0340 - nWeb) /nTweb, (nColIni + (nColMax*0.15)) /nTweb, (nLinIni + 0410 - nWeb) /nTweb, (nColIni + (nColMax*0.26) - 0010) /nTweb)
			oPrint:Say((nLinIni + 0345) /nTweb , (nColIni + (nColMax*0.15) + 0010) /nTweb, "9 - Validade da Carteira", oFont01) //"9 - Validade da Carteira"
			oPrint:Say((nLinIni + 0375) /nTweb, (nColIni + (nColMax*0.15) + 0020) /nTweb, DtoC(aDados[nX, 09]), oFont04)
			oPrint:Box((nLinIni + 0340 - nWeb) /nTweb, (nColIni + (nColMax*0.26)) /nTweb, (nLinIni + 0410 - nWeb) /nTweb, (nColIni + (nColMax*0.74) - 0010) /nTweb)
			oPrint:Say((nLinIni + 0345) /nTweb, (nColIni + (nColMax*0.26) + 0010) /nTweb, "10- Nome", oFont01) //"10- Nome"
			oPrint:Say((nLinIni + 0375) /nTweb, (nColIni + (nColMax*0.26) + 0020) /nTweb, aDados[nX, 10], oFont04)
			oPrint:Box((nLinIni + 0340 - nWeb) /nTweb, (nColIni + (nColMax*0.74)) /nTweb, (nLinIni + 0410 - nWeb) /nTweb, (nColIni + (nColMax*0.92) - 0010) /nTweb)
			oPrint:Say((nLinIni + 0345) /nTweb, (nColIni + (nColMax*0.74) + 0010) /nTweb, "11 - Cartão Nacional de Saúde", oFont01) //"11 - Cartão Nacional de Saúde"
			oPrint:Say((nLinIni + 0375) /nTweb, (nColIni + (nColMax*0.74) + 0020) /nTweb, aDados[nX, 11], oFont04)
			oPrint:Box((nLinIni + 0340 - nWeb) /nTweb, (nColIni + (nColMax*0.92)) /nTweb, (nLinIni + 0410 - nWeb) /nTweb, (nColIni + nColMax - 0010) /nTweb)
			oPrint:Say((nLinIni + 0345) /nTweb, (nColIni + (nColMax*0.92) + 0010) /nTweb, "12 - Atendimento a RN", oFont01) //"12 - Atendimento a RN"
			oPrint:Say((nLinIni + 0375) /nTweb, (nColIni + (nColMax*0.92) + 0020) /nTweb, aDados[nX, 12], oFont04)

			If !lWeb
				AddTBrush(oPrint, nLinIni + 0417, nColIni + 0010, nLinIni + 0447, nColIni + nColMax)
			Endif

			oPrint:Say((nLinIni + 0420) /nTweb, (nColIni + 0020) /nTweb, "Dados do Contratado Executante", oFont01) //"Dados do Contratado Executante"
			oPrint:Box((nLinIni + 0450 - nWeb) /nTweb, (nColIni + 0020) /nTweb, (nLinIni + 0520 - nWeb) /nTweb, (nColIni + (nColMax*0.20) - 0010) /nTweb)
			oPrint:Say((nLinIni + 0455) /nTweb, (nColIni + 0030) /nTweb, "13 - Código na Operadora", oFont01) //"13 - Código na Operadora"
			oPrint:Say((nLinIni + 0485) /nTweb, (nColIni + 0040) /nTweb, aDados[nX, 13], oFont04)
			oPrint:Box((nLinIni + 0450 - nWeb) /nTweb, (nColIni + (nColMax*0.20)) /nTweb, (nLinIni + 0520 - nWeb) /nTweb,  (nColIni + (nColMax*0.90) - 0010) /nTweb)
			oPrint:Say((nLinIni + 0455) /nTweb, (nColIni + (nColMax*0.20) + 0010) /nTweb, "14 - Nome do Contratado", oFont01) //"14 - Nome do Contratado"
			oPrint:Say((nLinIni + 0485) /nTweb, (nColIni + (nColMax*0.20) + 0020) /nTweb, aDados[nX, 14], oFont04)
			oPrint:Box((nLinIni + 0450 - nWeb) /nTweb, (nColIni + (nColMax*0.90)) /nTweb, (nLinIni + 0520 - nWeb) /nTweb,  (nColIni + nColMax - 0010) /nTweb)
			oPrint:Say((nLinIni + 0455) /nTweb, (nColIni + (nColMax*0.90) + 0010) /nTweb, "15 - Código CNES", oFont01) //"15 - Código CNES"
			oPrint:Say((nLinIni + 0485) /nTweb, (nColIni + (nColMax*0.90) + 0020) /nTweb, aDados[nX, 15], oFont04)

			If !lWeb
				AddTBrush(oPrint, nLinIni + 0527, nColIni + 0010, nLinIni + 0557, nColIni + nColMax)
			EndIf

			oPrint:Say((nLinIni + 0530) /nTweb, (nColIni + 0020) /nTweb, "Dados da Internação", oFont01) //"Dados da Internação"
			oPrint:Box((nLinIni + 0560 - nWeb) /nTweb, (nColIni + 0020) /nTweb, (nLinIni + 0630 - nWeb) /nTweb, (nColIni + (nColMax*0.10) - 0010) /nTweb)
			oPrint:Say((nLinIni + 05650) /nTweb, (nColIni + 0030) /nTweb, "16 - Caráter do Atendimento", oFont01) //"16 - Caráter do Atendimento"
			oPrint:Say((nLinIni + 0595) /nTweb, (nColIni + 0140) /nTweb, aDados[nX, 16], oFont04)
			oPrint:Box((nLinIni + 0560 - nWeb) /nTweb, (nColIni + (nColMax*0.10)) /nTweb, (nLinIni + 0630 - nWeb) /nTweb, (nColIni + (nColMax*0.20) - 0010) /nTweb)
			oPrint:Say((nLinIni + 0565) /nTweb, (nColIni + (nColMax*0.10) + 0010) /nTweb, "17 - Tipo de Faturamento", oFont01) //"17 - Tipo de Faturamento"
			oPrint:Say((nLinIni + 0595) /nTweb, (nColIni + (nColMax*0.10) + 0020) /nTweb, aDados[nX, 17], oFont04)
			oPrint:Box((nLinIni + 0560 - nWeb) /nTweb, (nColIni + (nColMax*0.20)) /nTweb, (nLinIni + 0630 - nWeb) /nTweb, (nColIni + (nColMax*0.35) - 0010) /nTweb)
			oPrint:Say((nLinIni + 0565) /nTweb, (nColIni + (nColMax*0.20) + 0010) /nTweb, "18- Data do Início do Faturamento", oFont01) //"18- Data do Início do Faturamento"
			oPrint:Say((nLinIni + 0595) /nTweb, (nColIni + (nColMax*0.20) + 0020) /nTweb, DtoC(aDados[nX, 18]), oFont04)
			oPrint:Box((nLinIni + 0560 - nWeb) /nTweb, (nColIni + (nColMax*0.35)) /nTweb, (nLinIni + 0630 - nWeb) /nTweb, (nColIni + (nColMax*0.47) - 0010) /nTweb)
			oPrint:Say((nLinIni + 0565) /nTweb, (nColIni + (nColMax*0.35) + 0010) /nTweb, "19- Hora do Início do Faturamento", oFont01) //"19- Hora do Início do Faturamento"
			oPrint:Say((nLinIni + 0595) /nTweb, (nColIni + (nColMax*0.35) + 0020) /nTweb, IIf(Empty(aDados[nX, 19]), "", Transform(aDados[nX, 19], "@R 99:99")), oFont04)
			oPrint:Box((nLinIni + 0560 - nWeb) /nTweb, (nColIni + (nColMax*0.47)) /nTweb, (nLinIni + 0630 - nWeb) /nTweb, (nColIni + (nColMax*0.62) - 0010) /nTweb)
			oPrint:Say((nLinIni + 0565) /nTweb, (nColIni + (nColMax*0.47) + 00100) /nTweb, "20- Data do Fim do Faturamento", oFont01) //"20- Data do Fim do Faturamento"
			oPrint:Say((nLinIni + 0595) /nTweb, (nColIni + (nColMax*0.47) + 0020) /nTweb, DtoC(aDados[nX, 20]), oFont04)
			oPrint:Box((nLinIni + 0560 - nWeb) /nTweb, (nColIni + (nColMax*0.62)) /nTweb, (nLinIni + 0630 - nWeb) /nTweb, (nColIni + (nColMax*0.74) - 0010) /nTweb)
			oPrint:Say((nLinIni + 0565) /nTweb, (nColIni + (nColMax*0.62) + 0010) /nTweb, "21- Hora do Fim do Faturamento", oFont01) //"21- Hora do Fim do Faturamento"
			oPrint:Say((nLinIni + 0595) /nTweb, (nColIni + (nColMax*0.62) + 0020) /nTweb, IIf(Empty(aDados[nX, 21]), "", Transform(aDados[nX, 21], "@R 99:99")), oFont04)
			oPrint:Box((nLinIni + 0560 - nWeb) /nTweb, (nColIni + (nColMax*0.74)) /nTweb, (nLinIni + 0630 - nWeb) /nTweb, (nColIni + (nColMax*0.82) - 0010) /nTweb)
			oPrint:Say((nLinIni + 0565) /nTweb, (nColIni + (nColMax*0.74) + 00100) /nTweb, "22- Tipo de Internação", oFont01) //"22- Tipo de Internação"
			oPrint:Say((nLinIni + 0595) /nTweb, (nColIni + (nColMax*0.74) + 0020) /nTweb, aDados[nX, 22], oFont04)
			oPrint:Box((nLinIni + 0560 - nWeb) /nTweb, (nColIni + (nColMax*0.82)) /nTweb, (nLinIni + 0630 - nWeb) /nTweb, (nColIni + (nColMax*0.91) - 0010) /nTweb)
			oPrint:Say((nLinIni + 0565) /nTweb, (nColIni + (nColMax*0.82) + 0010) /nTweb, "23- Regime de Internação", oFont01) //"23- Regime de Internação"
			oPrint:Say((nLinIni + 0595) /nTweb, (nColIni + (nColMax*0.82) + 0020) /nTweb, aDados[nX, 23], oFont04)

			oPrint:Box((nLinIni + 0640 - nWeb) /nTweb, (nColIni + 0020) /nTweb, (nLinIni + 0710 - nWeb) /nTweb, (nColIni + (nColMax*0.07) - 0010) /nTweb)
			oPrint:Say((nLinIni + 0645) /nTweb, (nColIni + 0022) /nTweb, "24-CID 10 Principal", oFont01) //"24 - CID 10 Principal"
			oPrint:Say((nLinIni + 0675) /nTweb, (nColIni + 0040) /nTweb, aDados[nX, 24], oFont04)
			oPrint:Box((nLinIni + 0640 - nWeb) /nTweb, (nColIni + (nColMax*0.07)) /nTweb, (nLinIni + 0710 - nWeb) /nTweb, (nColIni + (nColMax*0.14) - 0010) /nTweb)
			oPrint:Say((nLinIni + 0645) /nTweb, (nColIni + (nColMax*0.07) + 0010) /nTweb, "25 - CID 10 (2)", oFont01) //"25 - CID 10 (2)"
			oPrint:Say((nLinIni + 0675) /nTweb, (nColIni + (nColMax*0.07) + 0020) /nTweb, aDados[nX, 25], oFont04)
			oPrint:Box((nLinIni + 0640 - nWeb) /nTweb, (nColIni + (nColMax*0.14)) /nTweb, (nLinIni + 0710 - nWeb) /nTweb, (nColIni + (nColMax*0.21) - 0010) /nTweb)
			oPrint:Say((nLinIni + 0645) /nTweb, (nColIni + (nColMax*0.14) + 0010) /nTweb, "26 - CID 10 (3)", oFont01) //"26 - CID 10 (3)"
			oPrint:Say((nLinIni + 0675) /nTweb, (nColIni + (nColMax*0.14) + 0020) /nTweb, aDados[nX, 26], oFont04)
			oPrint:Box((nLinIni + 0640 - nWeb) /nTweb, (nColIni + (nColMax*0.21)) /nTweb, (nLinIni + 0710 - nWeb) /nTweb, (nColIni + (nColMax*0.28) - 0010) /nTweb)
			oPrint:Say((nLinIni + 0645) /nTweb, (nColIni + (nColMax*0.21) + 0010) /nTweb, "27 - CID 10 (4)", oFont01) //"27 - CID 10 (4)"
			oPrint:Say((nLinIni + 0675) /nTweb, (nColIni + (nColMax*0.21) + 00200) /nTweb, aDados[nX, 27], oFont04)
			oPrint:Box((nLinIni + 0640 - nWeb) /nTweb, (nColIni + (nColMax*0.28)) /nTweb, (nLinIni + 0710 - nWeb) /nTweb, (nColIni + (nColMax*0.39) - 0010) /nTweb)
			oPrint:Say((nLinIni + 0642) /nTweb, (nColIni + (nColMax*0.28) + 001) /nTweb, "28 - Indicação de Acidente", oFont01) //"28 - Indicação de Acidente"
			oPrint:Say((nLinIni + 0657) /nTweb, (nColIni + (nColMax*0.28) + 0010) /nTweb, "(acidente ou doença relacionada)", oFont01) //"acidente ou doença relacionada)"
			oPrint:Say((nLinIni + 0677) /nTweb, (nColIni + (nColMax*0.28) + 0020) /nTweb, aDados[nX, 28], oFont04)
			oPrint:Box((nLinIni + 0640 - nWeb) /nTweb, (nColIni + (nColMax*0.39)) /nTweb, (nLinIni + 0710 - nWeb) /nTweb, (nColIni + (nColMax*0.52) - 0010) /nTweb)
			oPrint:Say((nLinIni + 0645) /nTweb, (nColIni + (nColMax*0.39) + 0010) /nTweb, "29-Motivo de Encerramento da Internação", oFont01) //"29 - Motivo de Encerramento da Internação"
			oPrint:Say((nLinIni + 0675) /nTweb, (nColIni + (nColMax*0.39) + 0020) /nTweb, aDados[nX, 29], oFont04)
			oPrint:Box((nLinIni + 0640 - nWeb) /nTweb, (nColIni + (nColMax*0.52)) /nTweb, (nLinIni + 0710 - nWeb) /nTweb, (nColIni + (nColMax*0.68) - 0010) /nTweb)
			oPrint:Say((nLinIni + 0645) /nTweb, (nColIni + (nColMax*0.52) + 0010) /nTweb, "30-Número da declaração de nascido vivo", oFont01) //"30-Número da declaração de nascido vivo"
			oPrint:Say((nLinIni + 0675) /nTweb, (nColIni + (nColMax*0.52) + 0020) /nTweb, aDados[nX, 30], oFont04)
			oPrint:Box((nLinIni + 0640 - nWeb) /nTweb, (nColIni + (nColMax*0.68)) /nTweb, (nLinIni + 0710 - nWeb) /nTweb, (nColIni + (nColMax*0.76) - 0010) /nTweb)
			oPrint:Say((nLinIni + 0645) /nTweb, (nColIni + (nColMax*0.68) + 0010) /nTweb, "31 - CID 10 Óbito", oFont01) //"31 - CID 10 Óbito"
			oPrint:Say((nLinIni + 0675) /nTweb, (nColIni + (nColMax*0.68) + 0020) /nTweb, aDados[nX, 31], oFont04)
			oPrint:Box((nLinIni + 0640 - nWeb) /nTweb, (nColIni + (nColMax*0.76)) /nTweb, (nLinIni + 0710 - nWeb) /nTweb, (nColIni + (nColMax*0.92) - 00100 )/nTweb)
			oPrint:Say((nLinIni + 0645) /nTweb, (nColIni + (nColMax*0.76) + 0010) /nTweb, "32 - Numero da declaração de óbito", oFont01) //"32 - Numero da declaração de óbito"
			oPrint:Say((nLinIni + 0675) /nTweb, (nColIni + (nColMax*0.76) + 0020) /nTweb, aDados[nX, 32], oFont04)
			oPrint:Box((nLinIni + 0640 - nWeb) /nTweb, (nColIni + (nColMax*0.92)) /nTweb, (nLinIni + 0710 - nWeb) /nTweb, (nColIni + nColMax - 0010) /nTweb)
			oPrint:Say((nLinIni + 0645) /nTweb, (nColIni + (nColMax*0.92) + 0010) /nTweb, "33 -Indicador D.O. de RN", oFont01) //"33 -Indicador D.O. de RN"
			oPrint:Say((nLinIni + 0675) /nTweb, (nColIni + (nColMax*0.92) + 0020) /nTweb, aDados[nX, 33], oFont04)

			If !lWeb
				AddTBrush(oPrint, nLinIni + 0717, nColIni + 0010, nLinIni + 0747, nColIni + nColMax)
			EndIf

			oPrint:Say((nLinIni + 0720) /nTweb, (nColIni + 0020) /nTweb, "Procedimentos e Exames Realizados", oFont01) //"Procedimentos e Exames Realizados"
			oPrint:Box((nLinIni + 0750 - nWeb) /nTweb, (nColIni + 0020) /nTweb, (nLinIni + 1310 - nWeb) /nTweb, (nColIni + nColMax - 0010) /nTweb)
			oPrint:Say((nLinIni + 0760) /nTweb, (nColIni + (nColMax*0.02)) /nTweb, "34-Data", oFont01) //"34-Data"
			oPrint:Say((nLinIni + 0760) /nTweb, (nColIni + (nColMax*0.08)) /nTweb, "35-Hora Inicial", oFont01) //"35-Hora Inicial"
			oPrint:Say((nLinIni + 0760) /nTweb, (nColIni + (nColMax*0.13)) /nTweb, "36-Hora Final", oFont01) //"36-Hora Final"
			oPrint:Say((nLinIni + 0760) /nTweb, (nColIni + (nColMax*0.18)) /nTweb, "37-Tabela", oFont01) //"37-Tabela"
			oPrint:Say((nLinIni + 0760) /nTweb, (nColIni + (nColMax*0.22)) /nTweb, "38-Código do Procedimento", oFont01) //"38-Código do Procedimento"
			oPrint:Say((nLinIni + 0760) /nTweb, (nColIni + (nColMax*0.30)) /nTweb, "39-Descrição", oFont01) //"39-Descrição"
			oPrint:Say((nLinIni + 0760) /nTweb, (nColIni + (nColMax*0.69)) /nTweb, "40-Qtde.", oFont01) //"40-Qtde."
			oPrint:Say((nLinIni + 0760) /nTweb, (nColIni + (nColMax*0.73)) /nTweb, "41-Via", oFont01) //"41-Via"
			oPrint:Say((nLinIni + 0760) /nTweb, (nColIni + (nColMax*0.76)) /nTweb, "42-Téc", oFont01) //"42-Téc"
			oPrint:Say((nLinIni + 0760) /nTweb, (nColIni + (nColMax*0.79)) /nTweb, "43-Fator Red/Acresc", oFont01) //"43-Fator Red/Acresc"
			oPrint:Say((nLinIni + 0760) /nTweb, (nColIni + (nColMax*0.86)) /nTweb, "44-Valor Unitário (R$)", oFont01) //"44-Valor Unitário (R$)"
			oPrint:Say((nLinIni + 0760) /nTweb, (nColIni + (nColMax*0.93)) /nTweb, "45-Valor Total (R$)", oFont01) //"45-Valor Total (R$)"

			nOldLinIni := nLinIni
			if nVolta=1
				nP:=1
			Endif
			nT:=nP+9
			For nI := nP To nT
				if nVolta <> 1
					nN:=nI-(15*nVolta-15)
					oPrint:Say((nLinIni + 0800) /nTweb, (nColIni + 0030) /nTweb, AllTrim(Str(nN)) + " - ", oFont01)
				else
					oPrint:Say((nLinIni + 0800) /nTweb, (nColIni + 0030) /nTweb, AllTrim(Str(nI)) + " - ", oFont01)
				Endif
				oPrint:Say((nLinIni + 0800) /nTweb, (nColIni + (nColMax*0.02)) /nTweb, IIf(Valtype(aDados[nX, 34, nI])== "D", DtoC(aDados[nX, 34, nI]),aDados[nX, 34, nI]), oFont04) //"34-Data"
				oPrint:Say((nLinIni + 0800) /nTweb, (nColIni + (nColMax*0.087)) /nTweb, IIf(Empty(aDados[nX, 35, nI]), "", Transform(aDados[nX, 35, nI], "@R 99:99")), oFont04) //"35-Hora Inicial"
			   	oPrint:Say((nLinIni + 0800) /nTweb, (nColIni + (nColMax*0.137)) /nTweb, IIf(Empty(aDados[nX, 36, nI]), "", Transform(aDados[nX, 36, nI], "@R 99:99")), oFont04) //"36-Hora Final"
				oPrint:Say((nLinIni + 0800) /nTweb, (nColIni + (nColMax*0.185)) /nTweb, aDados[nX, 37, nI], oFont04) //"37-Tabela"
				oPrint:Say((nLinIni + 0800) /nTweb, (nColIni + (nColMax*0.22)) /nTweb, aDados[nX, 38, nI], oFont04) //"38-Código do Procedimento"
				oPrint:Say((nLinIni + 0800) /nTweb, (nColIni + (nColMax*0.30)) /nTweb, aDados[nX, 39, nI], oFont04) //"39-Descrição"
				oPrint:Say((nLinIni + 0800) /nTweb, (nColIni + (nColMax*0.705)) /nTweb, IIf(Empty(aDados[nX, 40, nI]), "", Transform(aDados[nX, 40, nI], "@E 999")), oFont04,,,,1) //"40-Qtde."
				oPrint:Say((nLinIni + 0800) /nTweb, (nColIni + (nColMax*0.733)) /nTweb, aDados[nX, 41, nI], oFont04) //"41-Via"
				oPrint:Say((nLinIni + 0800) /nTweb, (nColIni + (nColMax*0.765)) /nTweb, aDados[nX, 42, nI], oFont04) //"42-Téc"
				oPrint:Say((nLinIni + 0800) /nTweb, (nColIni + (nColMax*0.82)) /nTweb, IIf(Empty(aDados[nX, 43, nI]), "", Transform(aDados[nX, 43, nI], "@E 999.99")), oFont04,,,,1) //"43-Fator Red/Acresc"
				oPrint:Say((nLinIni + 0800) /nTweb, (nColIni + (nColMax*0.92)) /nTweb, IIf(Empty(aDados[nX, 44, nI]), "", Transform(aDados[nX, 44, nI], "@E 99,999,999.99")), oFont04,,,,1) //"44-Valor Unitário (R$)"
				oPrint:Say((nLinIni + 0800) /nTweb, (nColIni + (nColMax*0.99)) /nTweb, IIf(Empty(aDados[nX, 45, nI]), "", Transform(aDados[nX, 45, nI], "@E 99,999,999.99")), oFont04,,,,1) //45-Valor Total (R$)
				nLinIni += 50
			Next nI

			nLinIni := nOldLinIni
		    nP:=nI

			If !lWeb
				AddTBrush(oPrint, nLinIni + 1317, nColIni + 0010, nLinIni + 1347, nColIni + nColMax)
		    EndIf

		    oPrint:Say((nLinIni + 1320) /nTweb, (nColIni + 0020) /nTweb, "Identificação da Equipe", oFont01) //"Identificação da Equipe"
			oPrint:Box((nLinIni + 1350 - nWeb) /nTweb, (nColIni + 0020) /nTweb, (nLinIni + 1830 - nWeb) /nTweb, (nColIni + nColMax - 0010) /nTweb)
			oPrint:Say((nLinIni + 1360) /nTweb, (nColIni + (nColMax*0.01)) /nTweb, "46-Seq.Ref", oFont01) //"46-Seq.Ref"
			oPrint:Say((nLinIni + 1360) /nTweb, (nColIni + (nColMax*0.05)) /nTweb, "47-Grau Part.", oFont01) //"47-Grau Part."
			oPrint:Say((nLinIni + 1360) /nTweb, (nColIni + (nColMax*0.10)) /nTweb, "48-Código na Operadora/CPF", oFont01) //"48-Código na Operadora/CPF"
			oPrint:Say((nLinIni + 1360) /nTweb, (nColIni + (nColMax*0.20)) /nTweb, "49-Nome do Profissional", oFont01) //"49-Nome do Profissional"
			oPrint:Say((nLinIni + 1360) /nTweb, (nColIni + (nColMax*0.69)) /nTweb, "50-Conselho Profissional", oFont01) //"50-Conselho Profissional"
			oPrint:Say((nLinIni + 1360) /nTweb, (nColIni + (nColMax*0.77)) /nTweb, "51-Número no Conselho", oFont01) //"51-Número no Conselho"
			oPrint:Say((nLinIni + 1360) /nTweb, (nColIni + (nColMax*0.88)) /nTweb, "52-UF", oFont01) //"52-UF"
			oPrint:Say((nLinIni + 1360) /nTweb, (nColIni + (nColMax*0.92)) /nTweb, "53-Código CBO", oFont01) //"53-Código CBO"

			nOldLinIni := nLinIni
			if nVolta=1
				nP1:=1
			Endif
			nT1:=nP1+7
			For nI := nP1 To nT1
				oPrint:Say((nLinIni + 1400) /nTweb, (nColIni + (nColMax*0.02)) /nTweb, aDados[nX, 46, nI], oFont04) //"46-Seq.Ref"
				oPrint:Say((nLinIni + 1400) /nTweb, (nColIni + (nColMax*0.06)) /nTweb, aDados[nX, 47, nI], oFont04) //"47-Grau Part."
				oPrint:Say((nLinIni + 1400) /nTweb, (nColIni + (nColMax*0.10)) /nTweb, aDados[nX, 48, nI], oFont04) //"48-Código na Operadora/CPF"
				oPrint:Say((nLinIni + 1400) /nTweb, (nColIni + (nColMax*0.20)) /nTweb, aDados[nX, 49, nI], oFont04) //"49-Nome do Profissional"
				oPrint:Say((nLinIni + 1400) /nTweb, (nColIni + (nColMax*0.72)) /nTweb, aDados[nX, 50, nI], oFont04) //"50-Conselho Profissional"
				oPrint:Say((nLinIni + 1400) /nTweb, (nColIni + (nColMax*0.77)) /nTweb, aDados[nX, 51, nI], oFont04) //"51-Número no Conselho"
				oPrint:Say((nLinIni + 1400) /nTweb, (nColIni + (nColMax*0.883)) /nTweb, aDados[nX, 52, nI], oFont04) //"52-UF"
				oPrint:Say((nLinIni + 1400) /nTweb, (nColIni + (nColMax*0.92)) /nTweb, aDados[nX, 53, nI], oFont04) //"53-Código CBO"
				nLinIni += 50
			Next nI

			nP1:=nI
			nLinIni := nOldLinIni

			oPrint:Box((nLinIni + 1840 - nWeb) /nTweb, (nColIni + 0020) /nTweb, (nLinIni + 1930 - nWeb) /nTweb, (nColIni + (nColMax/8) - 0010) /nTweb)
			oPrint:Say((nLinIni + 1845) /nTweb, (nColIni + 0030) /nTweb, "54 - Total de Procedimentos (R$)", oFont01) //"54 - Total de Procedimentos (R$)"
			oPrint:Say((nLinIni + 1885)/nTweb, (nColIni + (nColMax/8) - 0030) /nTweb, IIf(Empty(aDados[nX, 54]), "", Transform(aDados[nX, 54], "@E 99,999,999.99")), oFont04,,,,1)
			oPrint:Box((nLinIni + 1840 - nWeb) /nTweb, (nColIni + (nColMax/8)) /nTweb , (nLinIni + 1930 - nWeb) /nTweb, (nColIni + (nColMax/8*2) - 0010) /nTweb)
			oPrint:Say((nLinIni + 1845) /nTweb, (nColIni + (nColMax/8) + 0010) /nTweb, "55 - Total de Diárias (R$)", oFont01) //"55 - Total de Diárias (R$)"
			oPrint:Say((nLinIni + 1885) /nTweb, (nColIni + (nColMax/8*2) - 0030) /nTweb, IIf(Empty(aDados[nX, 55]), "", Transform(aDados[nX, 55], "@E 99,999,999.99")), oFont04,,,,1)
			oPrint:Box((nLinIni + 1840 - nWeb)  /nTweb, (nColIni + (nColMax/8*2)) /nTweb, (nLinIni + 1930 - nWeb)  /nTweb, (nColIni + (nColMax/8*3) - 0010) /nTweb)
			oPrint:Say((nLinIni + 1845) /nTweb, (nColIni + (nColMax/8*2) + 0010)  /nTweb, "56 - Total de Taxase Aluguéis (R$)", oFont01) //"56 - Total de Taxase Aluguéis (R$)"
			oPrint:Say((nLinIni + 1890) /nTweb, (nColIni + (nColMax/8*3) - 0030) /nTweb, IIf(Empty(aDados[nX, 56]), "", Transform(aDados[nX, 56], "@E 99,999,999.99")), oFont04,,,,1)
			oPrint:Box((nLinIni + 1840 - nWeb) /nTweb, (nColIni + (nColMax/8*3)) /nTweb , (nLinIni + 1930 - nWeb) /nTweb, (nColIni + (nColMax/8*4) - 0010) /nTweb)
			oPrint:Say((nLinIni + 1845) /nTweb, (nColIni + (nColMax/8*3) + 0010) /nTweb, "57 - Total de Materiais (R$)", oFont01) //"57 - Total de Materiais (R$)"
			oPrint:Say((nLinIni + 1875) /nTweb, (nColIni + (nColMax/8*4) - 0030) /nTweb, IIf(Empty(aDados[nX, 57]), "", Transform(aDados[nX, 57], "@E 99,999,999.99")), oFont04,,,,1)
			oPrint:Box((nLinIni + 1840 - nWeb)  /nTweb, (nColIni + (nColMax/8*4)) /nTweb, (nLinIni + 1930 - nWeb) /nTweb, (nColIni + (nColMax/8*5) - 0010) /nTweb)
			oPrint:Say((nLinIni + 1845) /nTweb, (nColIni + (nColMax/8*4) + 0010) /nTweb, "58 - Total de OPME (R$)", oFont01) //"58- Total de OPME (R$)"
			oPrint:Say((nLinIni + 1875) /nTweb, (nColIni + (nColMax/8*5) - 0030) /nTweb, IIf(Empty(aDados[nX, 58]), "", Transform(aDados[nX, 58], "@E 99,999,999.99")), oFont04,,,,1)
			oPrint:Box((nLinIni + 1840 - nWeb) /nTweb, (nColIni + (nColMax/8*5)) /nTweb, (nLinIni + 1930 - nWeb) /nTweb, (nColIni + (nColMax/8*6) - 0010) /nTweb)
			oPrint:Say((nLinIni + 1845) /nTweb, (nColIni + (nColMax/8*5) + 0010) /nTweb, "59 - Total de Medicamentos (R$)", oFont01) //"59 - Total de Medicamentos (R$)"
			oPrint:Say((nLinIni + 1875) /nTweb, (nColIni + (nColMax/8*6) - 0030) /nTweb, IIf(Empty(aDados[nX, 59]), "", Transform(aDados[nX, 59], "@E 99,999,999.99")), oFont04,,,,1)
			oPrint:Box((nLinIni + 1840 - nWeb)  /nTweb, (nColIni + (nColMax/8*6)) /nTweb, (nLinIni + 1930 - nWeb) /nTweb, (nColIni + (nColMax/8*7) - 0010) /nTweb)
			oPrint:Say((nLinIni + 1845) /nTweb, (nColIni + (nColMax/8*6) + 0010) /nTweb, "60 - Total de Gases Medicinais (R$)", oFont01) //"60 - Total de Gases Medicinais (R$)"
			oPrint:Say((nLinIni + 1875) /nTweb, (nColIni + (nColMax/8*7) - 0030) /nTweb, IIf(Empty(aDados[nX, 60]), "", Transform(aDados[nX, 60], "@E 99,999,999.99")), oFont04,,,,1)
			oPrint:Box((nLinIni + 1840 - nWeb) /nTweb, (nColIni + (nColMax/8*7))  /nTweb, (nLinIni + 1930 - nWeb) /nTweb, (nColIni + nColMax - 0010) /nTweb)
			oPrint:Say((nLinIni + 1845) /nTweb, (nColIni + (nColMax/8*7) + 0010) /nTweb, "61 - Total Geral (R$)", oFont01) //"61 - Total Geral (R$)"
			oPrint:Say((nLinIni + 1875) /nTweb, (nColIni + nColMax - 0030) /nTweb		, IIf(Empty(aDados[nX, 61]), "", Transform(aDados[nX, 61], "@E 99,999,999.99")), oFont04,,,,1)

			oPrint:Box((nLinIni + 1940 - nWeb) /nTweb, (nColIni + 0020) /nTweb, (nLinIni + 2030 - nWeb) /nTweb, (nColIni + (nColMax*0.15) - 0010) /nTweb)
			oPrint:Say((nLinIni + 1945) /nTweb, (nColIni + 0030) /nTweb, "62- Data da assinatura do contratado", oFont01) //"62- Data da assinatura do contratado"
			oPrint:Say((nLinIni + 1975) /nTweb, (nColIni + 0040) /nTweb, DtoC(aDados[nX, 62]), oFont04)
			oPrint:Box((nLinIni + 1940 - nWeb) /nTweb, (nColIni + (nColMax*0.15)) /nTweb, (nLinIni + 2030 - nWeb) /nTweb, (nColIni + (nColMax*0.525) - 0010) /nTweb)
			oPrint:Say((nLinIni + 1945) /nTweb, (nColIni + (nColMax*0.15) + 0010) /nTweb, "63- Assinatura do contratado", oFont01) //"63- Assinatura do contratado"
			oPrint:Box((nLinIni + 1940 - nWeb) /nTweb, (nColIni + (nColMax*0.525)) /nTweb, (nLinIni + 2030 - nWeb) /nTweb, (nColIni + nColMax - 0010) /nTweb)
			oPrint:Say((nLinIni + 1945) /nTweb, (nColIni + (nColMax*0.525) + 0010) /nTweb, "64-Assinatura do(s) Auditor(es) da Operadora", oFont01) //"64-Assinatura do(s) Auditor(es) da Operadora"

			//AddTBrush(oPrint, nLinIni + 2040, nColIni + 0020, nLinIni + 2270, nColIni + nColMax - 0010)
			oPrint:Box((nLinIni + 2040 - nWeb) /nTweb, (nColIni + 0020) /nTweb, (nLinIni + 2270 - nWeb) /nTweb, (nColIni + nColMax - 0010) /nTweb)
			oPrint:Say((nLinIni + 2050) /nTweb, (nColIni + 0030) /nTweb, "65 – Observações / Justificativa", oFont01) //"65 – Observações / Justificativa"
			For nI := 1 To MlCount(aDados[nX, 63], 130)
				cObs := MemoLine(aDados[nX, 63], 130, nI)
				oPrint:Say((nLinIni + 2080 + nLin) /nTweb, (nColIni + 0040) /nTweb, cObs, oFont04)
				nLin += 50
			Next nI

			oPrint:EndPage()	// Finaliza a pagina

			//  Verso da Guia
			oPrint:StartPage()	// Inicia uma nova pagina

			nLinIni := 0
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Box Principal                                                 ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			oPrint:Box((nLinIni + 0010) /nTweb, (nColIni + 0020) /nTweb, (nLinIni + nLinMax) /nTweb, (nColIni + nColMax) /nTweb)

			If !lWeb
				AddTBrush(oPrint, nLinIni + 0017, nColIni + 0030, nLinIni + 0047, nColIni + nColMax)
			EndIf

			oPrint:Say((nLinIni + 0020) /nTweb, (nColIni + 0030) /nTweb, "Procedimentos e Exames Realizados", oFont01) //"Procedimentos e Exames Realizados"
			oPrint:Box((nLinIni + 0050 - nWeb) /nTweb, (nColIni + 0030) /nTweb, (nLinIni + (nLinMax*0.3) - nWeb) /nTweb, (nColIni + nColMax - 0010) /nTweb)
			oPrint:Say((nLinIni + 0060) /nTweb, (nColIni + (nColMax*0.02)) /nTweb, "34-Data", oFont01) //"34-Data"
			oPrint:Say((nLinIni + 0060) /nTweb, (nColIni + (nColMax*0.08)) /nTweb, "35-Hora Inicial", oFont01) //"35-Hora Inicial"
			oPrint:Say((nLinIni + 0060) /nTweb, (nColIni + (nColMax*0.13)) /nTweb, "36-Hora Final", oFont01) //"36-Hora Final"
			oPrint:Say((nLinIni + 0060) /nTweb, (nColIni + (nColMax*0.18)) /nTweb, "37-Tabela", oFont01) //"37-Tabela"
			oPrint:Say((nLinIni + 0060) /nTweb, (nColIni + (nColMax*0.21)) /nTweb, "38-Código do Procedimento", oFont01) //"38-Código do Procedimento"
			oPrint:Say((nLinIni + 0060) /nTweb, (nColIni + (nColMax*0.30)) /nTweb, "39-Descrição", oFont01) //"39-Descrição"
			oPrint:Say((nLinIni + 0060) /nTweb, (nColIni + (nColMax*0.66)) /nTweb, "40-Qtde.", oFont01) //"40-Qtde."
			oPrint:Say((nLinIni + 0060) /nTweb, (nColIni + (nColMax*0.69)) /nTweb, "41-Via", oFont01) //"41-Via"
			oPrint:Say((nLinIni + 0060) /nTweb, (nColIni + (nColMax*0.72)) /nTweb, "42-Téc", oFont01) //"42-Téc"
			oPrint:Say((nLinIni + 0060) /nTweb, (nColIni + (nColMax*0.76)) /nTweb, "43-Fator Red/Acresc", oFont01) //"43-Fator Red/Acresc"
			oPrint:Say((nLinIni + 0060) /nTweb, (nColIni + (nColMax*0.86)) /nTweb, "44-Valor Unitário (R$)", oFont01) //"44-Valor Unitário (R$)"
			oPrint:Say((nLinIni + 0060) /nTweb, (nColIni + (nColMax*0.93)) /nTweb, "45-Valor Total (R$)", oFont01) //"45-Valor Total (R$)"

			nOldLinIni := nLinIni

			if nVolta =1
				nP:=11
			Endif
			nT2:=nP+11

			For nI := nP To nT2
				if nVolta<>1
					nN:=nI-((15*nVolta)-15)
					oPrint:Say((nLinIni + 0100) /nTweb, (nColIni + 0030) /nTweb, AllTrim(Str(nN)) + " - ", oFont01)
				Else
					oPrint:Say((nLinIni + 0100) /nTweb, (nColIni + 0030) /nTweb, AllTrim(Str(nI)) + " - ", oFont01)
				Endif
				oPrint:Say((nLinIni + 0100) /nTweb, (nColIni + (nColMax*0.02)) /nTweb, IIf(Empty(aDados[nX, 34, nI]),"",aDados[nX, 34, nI]), oFont04) //"34-Data"
				oPrint:Say((nLinIni + 0100) /nTweb, (nColIni + (nColMax*0.087)) /nTweb, IIf(Empty(aDados[nX, 35, nI]), "", Transform(aDados[nX, 35, nI], "@R 99:99")), oFont04) //"35-Hora Inicial"
			   	oPrint:Say((nLinIni + 0100) /nTweb, (nColIni + (nColMax*0.137)) /nTweb, IIf(Empty(aDados[nX, 36, nI]), "", Transform(aDados[nX, 36, nI], "@R 99:99")), oFont04) //"36-Hora Final"
				oPrint:Say((nLinIni + 0100) /nTweb, (nColIni + (nColMax*0.185)) /nTweb, aDados[nX, 37, nI], oFont04) //"37-Tabela"
				oPrint:Say((nLinIni + 0100) /nTweb, (nColIni + (nColMax*0.21)) /nTweb, aDados[nX, 38, nI], oFont04) //"38-Código do Procedimento"
				oPrint:Say((nLinIni + 0100) /nTweb, (nColIni + (nColMax*0.30)) /nTweb, aDados[nX, 39, nI], oFont04) //"39-Descrição"
				oPrint:Say((nLinIni + 0100) /nTweb, (nColIni + (nColMax*0.68)) /nTweb, IIf(Empty(aDados[nX, 40, nI]), "", Transform(aDados[nX, 40, nI], "@E 999")), oFont04,,,,1) //"40-Qtde."
				oPrint:Say((nLinIni + 0100) /nTweb, (nColIni + (nColMax*0.695)) /nTweb, aDados[nX, 41, nI], oFont04) //"41-Via"
				oPrint:Say((nLinIni + 0100) /nTweb, (nColIni + (nColMax*0.725)) /nTweb, aDados[nX, 42, nI], oFont04) //"42-Téc"
				oPrint:Say((nLinIni + 0100) /nTweb, (nColIni + (nColMax*0.80)) /nTweb, IIf(Empty(aDados[nX, 43, nI]), "", Transform(aDados[nX, 43, nI], "@E 999.99")), oFont04,,,,1) //"43-Fator Red/Acresc"
				oPrint:Say((nLinIni + 0100) /nTweb, (nColIni + (nColMax*0.92)) /nTweb, IIf(Empty(aDados[nX, 44, nI]), "", Transform(aDados[nX, 44, nI], "@E 99,999,999.99")), oFont04,,,,1) //"44-Valor Unitário (R$)"
				oPrint:Say((nLinIni + 0100) /nTweb, (nColIni + (nColMax*0.99)) /nTweb, IIf(Empty(aDados[nX, 45, nI]), "", Transform(aDados[nX, 45, nI], "@E 99,999,999.99")), oFont04,,,,1) //45-Valor Total (R$)
				nLinIni += 50
			Next nI

			nP:=nI

			if nVolta=1
				nP3:=len(aDados[nX,34])
			Endif

			if nP3 >nI-1
				lImpnovo:=.T.
			Endif

			nLinIni := nOldLinIni

			If !lWeb
				AddTBrush(oPrint, nLinIni + (nLinMax*0.3) + 0017, nColIni + 0030, nLinIni + (nLinMax*0.3) + 0047, nColIni + nColMax)
			EndIf

			oPrint:Say((nLinIni + (nLinMax*0.3) + 0020) /nTweb, (nColIni + 0030) /nTweb, "Identificação da Equipe (Continuação)", oFont01) //"Identificação da Equipe (Continuação)"
			oPrint:Box((nLinIni + (nLinMax*0.3) + 0050 - nWeb) /nTweb , (nColIni + 0030) /nTweb, (nLinIni + (nLinMax*0.73) - nWeb) /nTweb, (nColIni + nColMax - 0010) /nTweb)
			oPrint:Say((nLinIni + (nLinMax*0.3) + 0060) /nTweb, (nColIni + (nColMax*0.01)) /nTweb, "46-Seq.Ref", oFont01) //"46-Seq.Ref"
			oPrint:Say((nLinIni + (nLinMax*0.3) + 0060) /nTweb, (nColIni + (nColMax*0.05)) /nTweb, "47-Grau Part.", oFont01) //"47-Grau Part."
			oPrint:Say((nLinIni + (nLinMax*0.3) + 0060) /nTweb, (nColIni + (nColMax*0.09)) /nTweb, "48-Código na Operadora/CPF", oFont01) //"48-Código na Operadora/CPF"
			oPrint:Say((nLinIni + (nLinMax*0.3) + 0060) /nTweb, (nColIni + (nColMax*0.18)) /nTweb, "49-Nome do Profissional", oFont01) //"49-Nome do Profissional"
			oPrint:Say((nLinIni + (nLinMax*0.3) + 0060) /nTweb, (nColIni + (nColMax*0.70)) /nTweb, "50-Conselho Profissional", oFont01) //"50-Conselho Profissional"
			oPrint:Say((nLinIni + (nLinMax*0.3) + 0060) /nTweb, (nColIni + (nColMax*0.80)) /nTweb, "51-Número no Conselho", oFont01) //"51-Número no Conselho"
			oPrint:Say((nLinIni + (nLinMax*0.3) + 0060) /nTweb, (nColIni + (nColMax*0.90)) /nTweb, "52-UF", oFont01) //"52-UF"
			oPrint:Say((nLinIni + (nLinMax*0.3) + 0060) /nTweb, (nColIni + (nColMax*0.94)) /nTweb, "53-Código CBO", oFont01) //"53-Código CBO"

			nOldLinIni := nLinIni
			if nVolta =1
				nP1:=9
			Endif
			nT3:=nP1+17

			For nI := nP1 To nT3
				oPrint:Say((nLinIni + (nLinMax*0.3) + 0100) /nTweb, (nColIni + (nColMax*0.018)) /nTweb, aDados[nX, 46, nI], oFont04) //"46-Seq.Ref"
				oPrint:Say((nLinIni + (nLinMax*0.3) + 0100) /nTweb, (nColIni + (nColMax*0.058)) /nTweb, aDados[nX, 47, nI], oFont04) //"47-Grau Part."
				oPrint:Say((nLinIni + (nLinMax*0.3) + 0100) /nTweb, (nColIni + (nColMax*0.09)) /nTweb, aDados[nX, 48, nI], oFont04) //"48-Código na Operadora/CPF"
				oPrint:Say((nLinIni + (nLinMax*0.3) + 0100) /nTweb, (nColIni + (nColMax*0.18)) /nTweb, aDados[nX, 49, nI], oFont04) //"49-Nome do Profissional"
				oPrint:Say((nLinIni + (nLinMax*0.3) + 0100) /nTweb, (nColIni + (nColMax*0.728)) /nTweb, aDados[nX, 50, nI], oFont04) //"50-Conselho Profissional"
				oPrint:Say((nLinIni + (nLinMax*0.3) + 0100) /nTweb, (nColIni + (nColMax*0.80)) /nTweb, aDados[nX, 51, nI], oFont04) //"51-Número no Conselho"
				oPrint:Say((nLinIni + (nLinMax*0.3) + 0100) /nTweb, (nColIni + (nColMax*0.903)) /nTweb, aDados[nX, 52, nI], oFont04) //"52-UF"
				oPrint:Say((nLinIni + (nLinMax*0.3) + 0100) /nTweb, (nColIni + (nColMax*0.94)) /nTweb, aDados[nX, 53, nI], oFont04) //"53-Código CBO"
				nLinIni += 50
			Next nI

			nP1:=nI

			if nVolta=1
				nP2:=len(aDados[nX,46])
			Endif

			if nP2 >nI-1
				lImpnovo:=.T.
			Endif

			nLinIni := nOldLinIni

			oPrint:EndPage()	// Finaliza a pagina

		Next nX

	Enddo
END SEQUENCE
//ErrorBlock( bError )

If !Empty(cErro)
	cArq := "erro_imp_relat_" + DtoS(Date()) + StrTran(Time(),":") + ".txt"
	MsgAlert("Erro ao gerar relatório. Visualize o log em /LOGPLS/" + cArq )
	cErro := 	"Erro ao carregar dados do relatório." + CRLF + ;
				"Verifique a cfg. de impressão da guia no cadastro de " + CRLF + ;
				"Tipos de Guias." + CRLF + CRLF + ;
				cErro
	PLSLogFil(cErro,cArq)
EndIf

If lWeb .OR. lGerTXT
	oPrint:Print()
Else
	oPrint:Preview()
Endif

Return cFileName

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡ao    ³ PLSTISSG  ³ Autor ³ Bruno Iserhardt       ³ Data ³ 26.06.13 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡ao ³ Estrutura Relatório TISS 3.00.01 (Guia Hon Individual)      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ SigaPLS                                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ aDados - Array com as informações do relat´rio              ³±±
±±³          ³ lGerTXT - Define se imprime direto sem passar pela tela 	  ³±±
±±³          ³			 de configuracao/preview do relatorio 		         ³±±
±±³          ³ nLayout - Define o formato de papél para impressao:         ³±±
±±³          ³           1 - Formato Ofício II (216x330mm)                 ³±±
±±³          ³           2 - Formato A4 (210x297mm)                        ³±±
±±³          ³  		 3 - Formato Carta (216x279mm)     			         ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
/*
Function CABTISSG(aDados, lGerTXT, nLayout, cLogoGH, lWeb, cPathRelW, lUnicaImp)

Local nLinMax
Local nColMax
Local nLinIni	:=	0		// Linha Lateral (inicial) Esquerda
Local nColIni	:=	0		// Coluna Lateral (inicial) Esquerda
Local nColA4    :=  0
Local nCol2A4   :=  0
Local cFileLogo
Local lPrinter := .F.
Local nOldLinIni
Local nI, nJ, nX
Local cObs
Local oFont01
Local oFont02n
Local oFont03n
Local oFont04
Local nAte		:= 10
Local nAte2	:= 0
Local lImpNovo	:= .T.
Local nIni		:= 1
Local nIni2	:= 1
Local cRel      := "guihon"
Local oPrint	:= nil
Local cPathSrvJ := GETMV("MV_RELT")
Local nTweb		:= 1
Local nLweb		:= 0
Local nLwebC	:= 0
LOCAL cErro		:= ""
LOCAL cArq			:= ""
Local nTamBox	:= 0

Default lGerTXT := .F.
Default nLayout := 2
Default cLogoGH := ''
Default lWeb    := .F.
Default cPathRelW := ''
Default lUnicaImp := .F.
Default aDados := { { ;
	"123456",; //1 - Registro ANS
	"12345678901234567890",; //2- Nº Guia no Prestador
	"12345678901234567890",; //3- Nº Guia de Solicitação de Internação
	"12345678901234567890",; //4 - Senha
	"12345678901234567890",; //5 - Número da Guia Atribuído pela Operadora
	"12345678901234567890",; //6 - Número da Carteira
	Replicate("M",70),; //7 - Nome
	"S",; //8 - Atendimento a RN
	"12345678901234",; //9 - Código na Operadora
	Replicate("H",70),; //10 - Nome do Hospital/Local
	"1234567",; //11-Código CNES
	"12345678901234",; //12 - Código na Operadora
	Replicate("M",70),; //13 - Nome do Contratado
	"1234567",; //14 - Código CNES
	CtoD("12/03/06"),; //15 - Data do Início do Faturamento
	CtoD("12/03/06"),; //16 - Data do Fim do Faturamento
	{ CtoD("12/03/06"),CtoD("12/03/06"),CtoD("12/03/06"),CtoD("12/03/06"),CtoD("12/03/06"),CtoD("12/03/06"),CtoD("12/03/06"),CtoD("12/03/06"),CtoD("12/03/06"),CtoD("12/03/06"),CtoD("12/03/06"),CtoD("12/03/06")},; //17-Data
	{ "0107","0207","0307","0407","0507","0507","0507","0507","0507","0507","0507","0507" },; //18-Hora Inicial
	{ "0607","0707","0807","0907","1007","0507","0507","0507","0507","0507","0507","0507" },; //19-Hora Final
	{ "MM","AA","BB","CC","DD","DD","DD","DD","DD","DD","DD","DD" },; //20-Tabela
	{ "5678901234","5678901234","5678901234","5678901234","5678901234","5678901234","5678901234","5678901234","5678901234","5678901234","5678901234","5678901234"},; //21-Código do Procedimento
	{ Replicate("M",10),Replicate("E",150),Replicate("E",150),Replicate("E",150),Replicate("E",150),Replicate("E",150),Replicate("E",150),Replicate("E",150),Replicate("E",150),Replicate("E",150),Replicate("E",150),Replicate("E",150)},; //22-Código do Procedimento
	{ 120,1,22,322,4,444,4,444,4,4,411,111 },; //23-Qtde.
	{ "D","D","D","D","D","D","D","D","D","D","D","D"},; //24-Via
	{ "M","E","F","G","H","D","D","D","D","D","D","D" },; //25-Tec
	{ 1.99,1.99,1.99,1.99,1.99,1.99,1.99,1.99,1.99,1.99,1.99,1.99 },; //26- Fator Red / Acresc
	{ 999999.99,22222.22,33.33,44444.44,11111.11,111111.11,11111.11,11111.11,211111.11,11111.11,311111.11,999999.99 },; //27-Valor Unitário - R$
	{ 999999.99,22222.22,33.33,44444.44,11111.11,111111.11,11111.11,11111.11,211111.11,11111.11,311111.11,999999.99 },; //28-Valor Total – R$
	{ "01", "99", "01", "99", "01" },; //29-Seq.Ref
	{ "02", "88", "02", "88", "02" },; //30-Grau Part.
	{ "01234567890123", "01234567890123", "01234567890123", "01234567890123", "01234567890123" },; //31-Código na Operadora/CPF
	{ Replicate("M", 70), Replicate("M", 70), Replicate("M", 70), Replicate("M", 70), Replicate("M", 70) },; //32-Nome do Profissional
	{ "00", "02", "00", "02", "00" },; //33-Conselho Profissional
	{ "012345678901234", "012345678901234", "012345678901234", "012345678901234", "012345678901234" },; //34-Número no Conselho
	{ "AA", "AA", "AA", "AA", "AA" },; //35-UF
	{ "123456", "123456", "123456", "123456", "123456" },; //36-Código CBO
	Replicate("M", 500),; //37- Observação / Justificativa
	987564.32,; //38- Valor total dos honorários
	CtoD("01/01/07") } } //39 - Data de emissão

If nLayout  == 1 // Ofício 2
	nLinMax := 2435
	nColMax := 3705
Elseif nLayout == 2   // Papél A4
	nLinMax	:=	2375
	nColMax	:=	3370 //3365
Else //Carta
	nLinMax	:=	2435
	nColMax	:=	3175
Endif

oFont01		:= TFont():New("Arial",  6,  6, , .F., , , , .T., .F.) // Normal
if nLayout == 1 // Oficio 2
	oFont02n	:= TFont():New("Arial", 12, 12, , .T., , , , .T., .F.) // Negrito
	oFont03n	:= TFont():New("Arial", 14, 14, , .T., , , , .T., .F.) // Negrito
	oFont04		:= TFont():New("Arial", 09, 09, , .F., , , , .T., .F.) // Normal
Else  // Papél A4 ou Carta
	oFont02n	:= TFont():New("Arial", 11, 11, , .T., , , , .T., .F.) // Negrito
	oFont03n	:= TFont():New("Arial", 13, 13, , .T., , , , .T., .F.) // Negrito
	oFont04		:= TFont():New("Arial", 08, 08, , .F., , , , .T., .F.) // Normal
Endif


	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
	//³ Nao permite acionar a impressao quando for na web.
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
If lWeb
	cPathSrvJ := cPathRelW
	cFileName := cRel+lower(CriaTrab(NIL,.F.))+".pdf"
Else
	cFileName := cRel+CriaTrab(NIL,.F.)
EndIf

if !lWeb
	oPrint	:= TMSPrinter():New("GUIA DE HONORARIOS") //"GUIA DE HONORARIOS"
else


	oPrint := FWMSPrinter():New ( cFileName	,,.F.,cPathSrvJ	 ,.T.,	,@oPrint,			  ,			  ,	.F.			,.f.)
	If lSrvUnix
		AjusPath(@oPrint)
	EndIf
	oPrint:cPathPDF := cPathSrvJ

	nTweb	 := 3.9 //2 //3.9
	nLweb	 := 10 //5 //10
	nLwebC	 := -3
	nTamBox := 25

	oPrint:lServer := lWeb
Endif

oPrint:SetLandscape()		// Modo paisagem

if nLayout == 2
	oPrint:SetPaperSize(9)// Papél A4
Elseif nLayout == 3
	oPrint:SetPaperSize(1)// Papél Carta
Else
	oPrint:SetPaperSize(14) //Papel Oficio2 216 x 330mm / 8 1/2 x 13in
Endif


	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
	//³Device
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
If lWeb
	oPrint:setDevice(IMP_PDF)
Else
		// Verifica se existe alguma impressora configurada para Impressao Grafica
	lPrinter := oPrint:IsPrinterActive()
	IF lPrinter
		lPrinter := IIF(GETNEWPAR("MV_IMPATIV", .F.), .F., .T.)	//	Define se irá alterar a Impressora Ativa
	ENDIF
	If ! lPrinter
		oPrint:Setup()
	EndIf
Endif

For nX := 1 To Len(aDados)

	nAte 	:= 10
	nAte2 	:= 5
	nI		:= 0
	nIni	:= 1
	nIni2	:= 1

	//Esta parte do código faz com que
	//imprima mais de uma guia.
	//INICIO
	If lUnicaImp
		If nX <= Len(aDados)
			lImpNovo := .T.
		EndIf
	EndIf
	//FIM

	While lImpNovo

		lImpNovo 	:= .F.

		If  ValType(aDados[nX]) == 'U' .OR. Len(aDados[nX]) == 0
			Loop
		EndIf

		For nI := 17 To 28
			If Len(aDados[nX, nI]) < nAte
				For nJ := Len(aDados[nX, nI]) + 1 To nAte
					If AllTrim(Str(nI)) $ "17"
						aAdd(aDados[nX, nI], StoD(""))
					ElseIf AllTrim(Str(nI)) $ "23,26,27,28"
						aAdd(aDados[nX, nI], 0)
					Else
						aAdd(aDados[nX, nI], "")
					EndIf
				Next nJ
			EndIf
		Next nI

		For nI := 29 To 36
			If Len(aDados[nX, nI]) < nAte2
				For nJ := Len(aDados[nX, nI]) + 1 To nAte2
					aAdd(aDados[nX, nI], "")
				Next nJ
			EndIf
		Next nI

		nLinIni := 000
		nColIni := 000
		nColA4  := 000
		nCol2A4 := 000

		If lWeb
			nColMax := 3175
		Endif

		oPrint:StartPage()		// Inicia uma nova pagina
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Box Principal                                                 ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		oPrint:Box((nLinIni + 0000)/nTweb, (nColIni + 0000)/nTweb, (nLinIni + nLinMax)/nTweb, (nColIni + nColMax)/nTweb)

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Carrega e Imprime Logotipo da Empresa                         ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		fLogoEmp(@cFileLogo,, cLogoGH)

		If File(cFilelogo)
			oPrint:SayBitmap((nLinIni + 0050)/nTweb, (nColIni + 0020)/nTweb, cFileLogo, (400)/nTweb, (090)/nTweb) 		// Tem que estar abaixo do RootPath
		EndIf

		If nLayout == 2 // Papél A4
			nColA4    := -0335
		Elseif nLayout == 3// Carta
			nColA4    := -0530
			nCol2A4   := -0400
		Endif

		If lWeb
			nColA4 := -550

			oPrint:Say(3*nLweb+(nLinIni + 0050)/nTweb, (nColIni + 1852 + IIf(nLayout == 2,nColA4,nCol2A4))/nTweb, "GUIA DE HONORÁRIOS", oFont03n,,,, 2) //GUIA DE HONORÁRIOS
			oPrint:Say(3*nLweb+(nLinIni + 0085)/nTweb, (nColIni + 1852 + IIf(nLayout == 2,nColA4,nCol2A4))/nTweb, "(Somente para pacientes internados)", oFont02n,,,, 2) //"(Somente para pacientes internados"
			oPrint:Say(3*nLweb+(nLinIni + 0060)/nTweb, (nColIni + 2900 + IIf(nLayout == 2,nColA4,nCol2A4))/nTweb, "2- Nº Guia no Prestador", oFont01) //"2- Nº Guia no Prestador"
			oPrint:Say(3*nLweb+(nLinIni + 0060)/nTweb, (nColIni + 3200 + IIf(nLayout == 2,nColA4,nCol2A4))/nTweb, aDados[nX, 02], oFont03n)

			oPrint:Box(3*nLweb+(nLinIni + 0240 - nTamBox)/nTweb, (nColIni + 0020)/nTweb, (nLinIni + 0250 - nTamBox)/nTweb, ((nColIni + nColMax)*0.15 - 0010)/nTweb)
			oPrint:Say(3*nLweb+(nLinIni + 0155)/nTweb, (nColIni + 0030)/nTweb, "1 - Registro ANS", oFont01) //"1 - Registro ANS"
			oPrint:Say(3*nLweb+(nLinIni + 0190)/nTweb, (nColIni + 0040)/nTweb, aDados[nX, 01], oFont04)
			oPrint:Box(3*nLweb+(nLinIni + 0240 - nTamBox)/nTweb, ((nColIni + nColMax)*0.15)/nTweb, (nLinIni + 0250 - nTamBox)/nTweb, ((nColIni + nColMax)*0.44- 0010)/nTweb)
			oPrint:Say(3*nLweb+(nLinIni + 0155)/nTweb, ((nColIni + nColMax)*0.15 + 0010)/nTweb, "3- Nº Guia de Solicitação de Internação", oFont01) //"3- Nº Guia de Solicitação de Internação"
			oPrint:Say(3*nLweb+(nLinIni + 0200)/nTweb, ((nColIni + nColMax)*0.15 + 0020)/nTweb, aDados[nX, 03], oFont04)
			oPrint:Box(3*nLweb+(nLinIni + 0240 - nTamBox)/nTweb, ((nColIni + nColMax)*0.44)/nTweb, (nLinIni + 0250 - nTamBox)/nTweb, ((nColIni + nColMax)*0.72- 0010)/nTweb)
			oPrint:Say(3*nLweb+(nLinIni + 0155)/nTweb, ((nColIni + nColMax)*0.44 + 0010)/nTweb, "4 - Senha", oFont01) //"4 - Senha"
			oPrint:Say(3*nLweb+(nLinIni + 0200)/nTweb, ((nColIni + nColMax)*0.44 + 0020)/nTweb, aDados[nX, 04], oFont04)
			oPrint:Box(3*nLweb+(nLinIni + 0240 - nTamBox)/nTweb, ((nColIni + nColMax)*0.72)/nTweb, (nLinIni + 0250 - nTamBox)/nTweb, (nColIni + nColMax - 0010)/nTweb)
			oPrint:Say(3*nLweb+(nLinIni + 0155)/nTweb, ((nColIni + nColMax)*0.72 + 0010)/nTweb, "5 - Número da Guia Atribuído pela Operadora", oFont01) //"5 - Número da Guia Atribuído pela Operadora"
			oPrint:Say(3*nLweb+(nLinIni + 0200)/nTweb, ((nColIni + nColMax)*0.72 + 0020)/nTweb, aDados[nX, 05], oFont04)

			AddTBrush(oPrint,  (nLinIni + 0370)/nTweb, (nColIni + 0020)/nTweb, (nLinIni + 0340)/nTweb, (nColIni + nColMax)/nTweb)
			oPrint:Say(3*nLweb+(nLinIni + 0247)/nTweb, (nColIni + 0020)/nTweb, "Dados do Beneficiário", oFont01) //"Dados do Beneficiário"
			oPrint:Box(3*nLweb+(nLinIni + 0380)/nTweb, (nColIni + 0020)/nTweb, (nLinIni + 0380)/nTweb, ((nColIni + nColMax)*0.25 - 0010)/nTweb)
			oPrint:Say(3*nLweb+(nLinIni + 0305)/nTweb, (nColIni + 0030)/nTweb, "6 - Número da Carteira", oFont01) //"6 - Número da Carteira"
			oPrint:Say(3*nLweb+(nLinIni + 0340)/nTweb, (nColIni + 0040)/nTweb, aDados[nX, 06], oFont04)
			oPrint:Box(3*nLweb+(nLinIni + 0380)/nTweb, ((nColIni + nColMax)*0.25)/nTweb, (nLinIni + 0380)/nTweb, ((nColIni + nColMax)*0.9 - 0010)/nTweb)
			oPrint:Say(3*nLweb+(nLinIni + 0305)/nTweb, ((nColIni + nColMax)*0.25 + 0010)/nTweb, "7 - Nome", oFont01) //"7 - Nome"
			oPrint:Say(3*nLweb+(nLinIni + 0340)/nTweb, ((nColIni + nColMax)*0.25 + 0020)/nTweb, aDados[nX, 07], oFont04)
			oPrint:Box(3*nLweb+(nLinIni + 0380)/nTweb, ((nColIni + nColMax)*0.9)/nTweb, (nLinIni + 0380)/nTweb, (nColIni + nColMax - 0010)/nTweb)
			oPrint:Say(3*nLweb+(nLinIni + 0305)/nTweb, ((nColIni + nColMax)*0.9 + 0010)/nTweb, "8 - Atendimento a RN", oFont01) //"7 - Nome"
			oPrint:Say(3*nLweb+(nLinIni + 0340)/nTweb, ((nColIni + nColMax)*0.9 + 0020)/nTweb, aDados[nX, 08], oFont04)

			AddTBrush(oPrint,  (nLinIni + 0503)/nTweb, (nColIni + 0020)/nTweb, (nLinIni + 0528)/nTweb, (nColIni + nColMax)/nTweb)
			oPrint:Say(3*nLweb+(nLinIni + 0406)/nTweb, (nColIni + 0020)/nTweb, "Dados do Contratado (onde foi executado o procedimento)", oFont01) //"Dados do Contratado (onde foi executado o procedimento)"
			oPrint:Box(3*nLweb+(nLinIni + 0530)/nTweb, (nColIni + 0020)/nTweb, (nLinIni + 0535)/nTweb, ((nColIni + nColMax)*0.20 - 0010)/nTweb)
			oPrint:Say(3*nLweb+(nLinIni + 0455)/nTweb, (nColIni + 0030)/nTweb, "9 - Código na Operadora", oFont01) //"9 - Código na Operadora"
			oPrint:Say(3*nLweb+(nLinIni + 0490)/nTweb, (nColIni + 0040)/nTweb, aDados[nX, 09], oFont04)
			oPrint:Box(3*nLweb+(nLinIni + 0530)/nTweb, ((nColIni + nColMax)*0.20)/nTweb, (nLinIni + 0535)/nTweb, ((nColIni + nColMax)*0.85 - 0010)/nTweb)
			oPrint:Say(3*nLweb+(nLinIni + 0455)/nTweb, ((nColIni + nColMax)*0.20 + 0010)/nTweb, "10 - Nome do Hospital/Local", oFont01) //"10 - Nome do Hospital/Local"
			oPrint:Say(3*nLweb+(nLinIni + 0490)/nTweb, ((nColIni + nColMax)*0.20 + 0020)/nTweb, aDados[nX, 10], oFont04)
			oPrint:Box(3*nLweb+(nLinIni + 0530)/nTweb, ((nColIni + nColMax)*0.85)/nTweb, (nLinIni + 0535)/nTweb, (nColIni + nColMax - 0010)/nTweb)
			oPrint:Say(3*nLweb+(nLinIni + 0455)/nTweb, ((nColIni + nColMax)*0.85 + 0010)/nTweb, "11 - Código CNES", oFont01) //"11 - Código CNES"
			oPrint:Say(3*nLweb+(nLinIni + 0490)/nTweb, ((nColIni + nColMax)*0.85 + 0020)/nTweb, aDados[nX, 11], oFont04)

			AddTBrush(oPrint,  (nLinIni + 0654)/nTweb, (nColIni + 0020)/nTweb, (nLinIni + 0679)/nTweb, (nColIni + nColMax)/nTweb)
			oPrint:Say(3*nLweb+(nLinIni + 0555)/nTweb, (nColIni + 0020)/nTweb, "Dados do Contratado Executante", oFont01) //"Dados do Contratado Executante"
			oPrint:Box(3*nLweb+(nLinIni + 0690)/nTweb, (nColIni + 0020)/nTweb, (nLinIni + 0685)/nTweb, ((nColIni + nColMax)*0.18 - 0010)/nTweb)
			oPrint:Say(3*nLweb+(nLinIni + 0600)/nTweb, (nColIni + 0030)/nTweb, "12 - Código na Operadora", oFont01) //"12 - Código na Operadora"
			oPrint:Say(3*nLweb+(nLinIni + 0640)/nTweb, (nColIni + 0040)/nTweb, aDados[nX, 12], oFont04)
			oPrint:Box(3*nLweb+(nLinIni + 0690)/nTweb, ((nColIni + nColMax)*0.18)/nTweb, (nLinIni + 0685)/nTweb, ((nColIni + nColMax)*0.85 - 0010)/nTweb)
			oPrint:Say(3*nLweb+(nLinIni + 0600)/nTweb, ((nColIni + nColMax)*0.18 + 0010)/nTweb, "13 - Nome do Contratado", oFont01) //"13 - Nome do Contratado"
			oPrint:Say(3*nLweb+(nLinIni + 0640)/nTweb, ((nColIni + nColMax)*0.18 + 0020)/nTweb, aDados[nX, 13], oFont04)
			oPrint:Box(3*nLweb+(nLinIni + 0690)/nTweb, ((nColIni + nColMax)*0.85)/nTweb, (nLinIni + 0685)/nTweb, (nColIni + nColMax - 0010)/nTweb)
			oPrint:Say(3*nLweb+(nLinIni + 0600)/nTweb, ((nColIni + nColMax)*0.85 + 0010)/nTweb, "14 - Código CNES", oFont01) //"14 - Código CNES"
			oPrint:Say(3*nLweb+(nLinIni + 0640)/nTweb, ((nColIni + nColMax)*0.85 + 0020)/nTweb, aDados[nX, 14], oFont04)

			nLinIni -= 35

			AddTBrush(oPrint,  (nLinIni + 0879)/nTweb, (nColIni + 0020)/nTweb, (nLinIni + 0850)/nTweb, (nColIni + nColMax)/nTweb)
			oPrint:Say(3*nLweb+(nLinIni + 0755)/nTweb, (nColIni + 0020)/nTweb, "Dados da internação", oFont01) //"Dados da internação"
			oPrint:Box(3*nLweb+(nLinIni + 0880)/nTweb, (nColIni + 0020)/nTweb, (nLinIni + 0885)/nTweb, ((nColIni + nColMax)*0.18 - 0010)/nTweb)
			oPrint:Say(3*nLweb+(nLinIni + 0815)/nTweb, (nColIni + 0030)/nTweb, "15 - Data do Início do Faturamento", oFont01) //"20 – Data do Início do Faturamento"
			oPrint:Say(3*nLweb+(nLinIni + 0855)/nTweb, (nColIni + 0040)/nTweb, DtoC(aDados[nX, 15]), oFont04)
			oPrint:Box(3*nLweb+(nLinIni + 0880)/nTweb, ((nColIni + nColMax)*0.18)/nTweb, (nLinIni + 0885)/nTweb, ((nColIni + nColMax)*0.36 - 0010)/nTweb)
			oPrint:Say(3*nLweb+(nLinIni + 0815)/nTweb, ((nColIni + nColMax)*0.18 + 0010)/nTweb, "16 - Data do Fim do Faturamento", oFont01) //"21 – Data do Fim do Faturamento"
			oPrint:Say(3*nLweb+(nLinIni + 0855)/nTweb, ((nColIni + nColMax)*0.18 + 0020)/nTweb, DtoC(aDados[nX, 16]), oFont04)

			AddTBrush(oPrint,  (nLinIni + 1005)/nTweb, (nColIni + 0020)/nTweb, (nLinIni + 1035)/nTweb, (nColIni + nColMax)/nTweb)
			oPrint:Say(3*nLweb+(nLinIni + 0910)/nTweb, (nColIni + 0020)/nTweb, "Procedimentos Realizados", oFont01) //"Dados da internação"
			oPrint:Box(3*nLweb+(nLinIni + 0930)/nTweb, (nColIni + 0020)/nTweb, (nLinIni + 1595)/nTweb, (nColIni + nColMax - 0010)/nTweb)
			oPrint:Say(3*nLweb+(nLinIni + 0960)/nTweb, ((nColIni + nColMax)*0.005), "17 - Data", oFont01) //"23 - Data"
			oPrint:Say(3*nLweb+(nLinIni + 0960)/nTweb, ((nColIni + nColMax)*0.015), "18 - Hora Inicial", oFont01) //"24 - Hora Inicial"
			oPrint:Say(3*nLweb+(nLinIni + 0960)/nTweb, ((nColIni + nColMax)*0.030), "19 - Hora Final", oFont01) //"25 - Hora Final"
			oPrint:Say(3*nLweb+(nLinIni + 0960)/nTweb, ((nColIni + nColMax)*0.045), "20 - Tabela", oFont01) //"26 - Tabela"
			oPrint:Say(3*nLweb+(nLinIni + 0960)/nTweb, ((nColIni + nColMax)*0.055), "21 - Código do Procedimento", oFont01) //"27 - Código do Procedimento"
			oPrint:Say(3*nLweb+(nLinIni + 0960)/nTweb, ((nColIni + nColMax)*0.080), "22 - Descrição", oFont01) //"28 - Descrição"
			oPrint:Say(3*nLweb+(nLinIni + 0960)/nTweb, ((nColIni + nColMax)*0.150), "23 - Qtde", oFont01) //"29 - Qtde"
			oPrint:Say(3*nLweb+(nLinIni + 0960)/nTweb, ((nColIni + nColMax)*0.165), "24 - Via", oFont01) //"30 - Via"
			oPrint:Say(3*nLweb+(nLinIni + 0960)/nTweb, ((nColIni + nColMax)*0.175), "25 - Tec", oFont01) //"31 - Tec"
			oPrint:Say(3*nLweb+(nLinIni + 0960)/nTweb, ((nColIni + nColMax)*0.185), "26 - Fator Red", oFont01) //"32 - Fator Red"
			oPrint:Say(3*nLweb+(nLinIni + 0980)/nTweb, ((nColIni + nColMax)*0.185), "/ Acresc", oFont01) //"/ Acresc"
			oPrint:Say(3*nLweb+(nLinIni + 0960)/nTweb, ((nColIni + nColMax)*0.200), "27 - Valor Unitário - R$", oFont01) //"33 - Valor Unitário - R$"
			oPrint:Say(3*nLweb+(nLinIni + 0960)/nTweb, ((nColIni + nColMax)*0.230), "28 - Valor Total – R$", oFont01) //"34-Valor Total – R$"

			nOldLinIni := nLinIni

			For nI := nIni To nAte
				oPrint:Say(3*nLweb+(nLinIni + 1012)/nTweb, (nColIni + (nColMax)*0.009)/nTweb, AllTrim(Str(nI)) + " - ", oFont01)

				oPrint:Say(3*nLweb+(nLinIni + 1017)/nTweb, ((nColIni + nColMax)*0.005), DtoC(aDados[nX, 17, nI]), oFont04)
				oPrint:Say(3*nLweb+(nLinIni + 1017)/nTweb, ((nColIni + nColMax)*0.015), IIf(Empty(aDados[nX, 18, nI]), "", Transform(aDados[nX, 18, nI], "@R 99:99")), oFont04)
				oPrint:Say(3*nLweb+(nLinIni + 1017)/nTweb, ((nColIni + nColMax)*0.030), IIf(Empty(aDados[nX, 19, nI]), "", Transform(aDados[nX, 19, nI], "@R 99:99")), oFont04)
				oPrint:Say(3*nLweb+(nLinIni + 1017)/nTweb, ((nColIni + nColMax)*0.045), aDados[nX, 20, nI], oFont04)
				oPrint:Say(3*nLweb+(nLinIni + 1017)/nTweb, ((nColIni + nColMax)*0.055), aDados[nX, 21, nI], oFont04)
				oPrint:Say(3*nLweb+(nLinIni + 1017)/nTweb, ((nColIni + nColMax)*0.080), aDados[nX, 22, nI], oFont04)
				oPrint:Say(3*nLweb+(nLinIni + 1017)/nTweb, ((nColIni + nColMax)*0.150), IIf(aDados[nX, 23, nI]=0, "", Transform(aDados[nX, 23, nI], "@E 999")), oFont04,,,,1)
				oPrint:Say(3*nLweb+(nLinIni + 1017)/nTweb, ((nColIni + nColMax)*0.165), aDados[nX, 24, nI], oFont04)
				oPrint:Say(3*nLweb+(nLinIni + 1017)/nTweb, ((nColIni + nColMax)*0.175), aDados[nX, 25, nI], oFont04,,,,1)
				oPrint:Say(3*nLweb+(nLinIni + 1017)/nTweb, ((nColIni + nColMax)*0.185), IIf(Empty(aDados[nX, 26, nI]), "", Transform(aDados[nX, 26, nI], "@E 9.99")), oFont04,,,,1)
				oPrint:Say(3*nLweb+(nLinIni + 1017)/nTweb, ((nColIni + nColMax)*0.200), IIf(Empty(aDados[nX, 27, nI]), "", Transform(aDados[nX, 27, nI], "@E 99,999,999.99")), oFont04,,,,1)
				oPrint:Say(3*nLweb+(nLinIni + 1017)/nTweb, ((nColIni + nColMax)*0.230), IIf(Empty(aDados[nX, 28, nI]), "", Transform(aDados[nX, 28, nI], "@E 99,999,999.99")), oFont04,,,,1)
				nLinIni += 50
			Next nI

			nLinIni := nOldLinIni

			nIni		:= nAte + 1
			If nAte < Len(aDados[nX][17])
				lImpNovo 	:= .T.
				nAte		+= 10
			EndIf

			nLinIni -= 100

			AddTBrush(oPrint,  (nLinIni + 1735)/nTweb, (nColIni + 0020)/nTweb, (nLinIni + 1705)/nTweb, (nColIni + nColMax)/nTweb)
			oPrint:Say(3*nLweb+(nLinIni + 1610)/nTweb, (nColIni + 0020)/nTweb, "Identificação do(s) Profissional(is) Executante(s)", oFont01) //"Identificação do(s) Profissional(is) Executante(s)"
			oPrint:Box(3*nLweb+(nLinIni + 1625)/nTweb, (nColIni + 0020)/nTweb, (nLinIni + 2060)/nTweb, (nColIni + nColMax - 0010)/nTweb)
			oPrint:Say(3*nLweb+(nLinIni + 1650)/nTweb, (nColIni + 0030)/nTweb, "29-Seq. Ref", oFont01) //"29-Seq. Ref"
			oPrint:Say(3*nLweb+(nLinIni + 1650)/nTweb, ((nColIni + nCOlMax)*0.07)/nTweb, "30-Grau Part.", oFont01) //"30-Grau Part."
			oPrint:Say(3*nLweb+(nLinIni + 1650)/nTweb, ((nColIni + nCOlMax)*0.15)/nTweb, "31-Còdigo na Operadora/CPF", oFont01) //"31-Còdigo na Operadora/CPF"
			oPrint:Say(3*nLweb+(nLinIni + 1650)/nTweb, ((nColIni + nCOlMax)*0.25)/nTweb, "32-Nome do Profissional", oFont01) //"32-Nome do Profissional"
			oPrint:Say(3*nLweb+(nLinIni + 1650)/nTweb, ((nColIni + nCOlMax)*0.7)/nTweb, "33-Conselho", oFont01) //"33-Conselho"
			oPrint:Say(3*nLweb+(nLinIni + 1675)/nTweb, ((nColIni + nCOlMax)*0.7)/nTweb, "Profissional", oFont01) //"Profissional"
			oPrint:Say(3*nLweb+(nLinIni + 1650)/nTweb, ((nColIni + nCOlMax)*0.78)/nTweb, "34-Número do Conselho", oFont01) //"34-Número do Conselho"
			oPrint:Say(3*nLweb+(nLinIni + 1650)/nTweb, ((nColIni + nCOlMax)*0.87)/nTweb, "35-UF", oFont01) //"35-UF"
			oPrint:Say(3*nLweb+(nLinIni + 1650)/nTweb, ((nColIni + nCOlMax)*0.92)/nTweb, "36-Código CBO", oFont01) //"36-Código CBO"

			nOldLinIni := nLinIni

			For nI := nIni2 To nAte2
				If !Empty(aDados[nX, 32, nI])
					oPrint:Say(3*nLweb+(nLinIni + 1695)/nTweb, (nColIni + 0030)/nTweb, AllTrim(Str(val(aDados[nX, 29, nI]))), oFont04)
					oPrint:Say(3*nLweb+(nLinIni + 1695)/nTweb, ((nColIni + nColMax)*0.07)/nTweb, aDados[nX, 30, nI], oFont04)
					oPrint:Say(3*nLweb+(nLinIni + 1695)/nTweb, ((nColIni + nColMax)*0.15)/nTweb, aDados[nX, 31, nI], oFont04)
					oPrint:Say(3*nLweb+(nLinIni + 1695)/nTweb, ((nColIni + nColMax)*0.25)/nTweb, aDados[nX, 32, nI], oFont04)
					oPrint:Say(3*nLweb+(nLinIni + 1695)/nTweb, ((nColIni + nColMax)*0.7)/nTweb, aDados[nX, 33, nI], oFont04)
					oPrint:Say(3*nLweb+(nLinIni + 1695)/nTweb, ((nColIni + nColMax)*0.78)/nTweb, aDados[nX, 34, nI], oFont04)
					oPrint:Say(3*nLweb+(nLinIni + 1695)/nTweb, ((nColIni + nColMax)*0.87)/nTweb, aDados[nX, 35, nI], oFont04)
					oPrint:Say(3*nLweb+(nLinIni + 1695)/nTweb, ((nColIni + nColMax)*0.92)/nTweb, aDados[nX, 36, nI], oFont04)
				EndIf

				nLinIni += 50
			Next nI

			nLinIni := nOldLinIni

			nIni2		:= nAte2 + 1
			If nAte2 < Len(aDados[nX][29])
				lImpNovo 	:= .T.
				nAte2		+= 5
			EndIf

			nLinIni += 410

			oPrint:Box(3*nLweb+(nLinIni + 1560)/nTweb, (nColIni + 0020)/nTweb, (nLinIni + 1890)/nTweb, ((nColIni + nColMax)*0.85 - 0010)/nTweb)
			AddTBrush(oPrint, (nLinIni + 1687)/nTweb, (nColIni + 0020)/nTweb, (nLinIni + 1888)/nTweb, ((nColIni + nColMax)*0.85 - 0010)/nTweb)
			oPrint:Say(3*nLweb+(nLinIni + 1590)/nTweb, (nColIni + 0030)/nTweb, "37- Observação / Justificativa", oFont01) //"35- Observação / Justificativa"

			nOldLinIni := nLinIni
			For nI := 1 To MlCount(aDados[nX, 37], 100)
				cObs := MemoLine(aDados[nX, 37], 100, nI)
				oPrint:Say(3*nLweb+(nLinIni + 1620)/nTweb, (nColIni + 0040)/nTweb, cObs, oFont04)
				nLinIni += 50
			Next nI
			nLinIni := nOldLinIni

			oPrint:Box(3*nLweb+(nLinIni + 1560)/nTweb, ((nColIni + nColMax)*0.85)/nTweb, (nLinIni + 1800)/nTweb, (nColIni + nColMax - 0010)/nTweb)
			oPrint:Say(3*nLweb+(nLinIni + 1590)/nTweb, ((nColIni + nColMax)*0.85 + 0010)/nTweb, "38 - Valor total dos honorários", oFont01) //"36 - Valor total dos honorários"
			oPrint:Say(3*nLweb+(nLinIni + 1620)/nTweb, ((nColIni + nColMax)*0.85 + 0020)/nTweb, IIf(Empty(aDados[nX, 38]), "", Transform(aDados[nX, 38], "@E 99,999,999.99")), oFont04)

			oPrint:Box(3*nLweb+(nLinIni + 1885)/nTweb, (nColIni + 0020)/nTweb, (nLinIni + 1900)/nTweb, ((nColIni + nColMax)*0.1 - 0010)/nTweb)
			oPrint:Say(3*nLweb+(nLinIni + 1815)/nTweb, (nColIni + 0030)/nTweb, "39 - Data de emissão", oFont01) //"37 - Data de emissão"
			oPrint:Say(3*nLweb+(nLinIni + 1845)/nTweb, (nColIni + 0040)/nTweb, DtoC(aDados[nX, 39]), oFont04)
			oPrint:Box(3*nLweb+(nLinIni + 1885)/nTweb, ((nColIni + nColMax)*0.1)/nTweb, (nLinIni + 1900)/nTweb, ((nColIni + nColMax)*0.85 - 0010)/nTweb)
			oPrint:Say(3*nLweb+(nLinIni + 1815)/nTweb, ((nColIni + nColMax)*0.1 + 0010)/nTweb, "40 - Assinatura do Profissional Executante", oFont01) //"38 - Assinatura do Profissional Executante"

			oPrint:EndPage()	// Finaliza a pagina

		Else
			oPrint:Say(nLinIni + 0060, (nColIni + nColMax)*0.44, "GUIA DE HONORÁRIOS", oFont03n,,,, 2) //GUIA DE HONORÁRIOS
			oPrint:Say(nLinIni + 0095, (nColIni + nColMax)*0.438, "(Somente para pacientes internados)", oFont02n,,,, 2) //"(Somente para pacientes internados"
			oPrint:Say(nLinIni + 0090, (nColIni + nColMax)*0.76, "2- Nº Guia no Prestador", oFont01) //"2- Nº Guia no Prestador"
			oPrint:Say(nLinIni + 0070, (nColIni + nColMax)*0.83, aDados[nX, 02], oFont03n)

			oPrint:Box(nLinIni + 0170, nColIni + 0020, nLinIni + 0250, (nColIni + nColMax)*0.15 - 0010)
			oPrint:Say(nLinIni + 0175, nColIni + 0030, "1 - Registro ANS", oFont01) //"1 - Registro ANS"
			oPrint:Say(nLinIni + 0205, nColIni + 0040, aDados[nX, 01], oFont04)
			oPrint:Box(nLinIni + 0170, (nColIni + nColMax)*0.15, nLinIni + 0250, (nColIni + nColMax)*0.44- 0010)
			oPrint:Say(nLinIni + 0175, (nColIni + nColMax)*0.15 + 0010, "3- Nº Guia de Solicitação de Internação", oFont01) //"3- Nº Guia de Solicitação de Internação"
			oPrint:Say(nLinIni + 0205, (nColIni + nColMax)*0.15 + 0020, aDados[nX, 03], oFont04)
			oPrint:Box(nLinIni + 0170, (nColIni + nColMax)*0.44, nLinIni + 0250, (nColIni + nColMax)*0.72- 0010)
			oPrint:Say(nLinIni + 0175, (nColIni + nColMax)*0.44 + 0010, "4 - Senha", oFont01) //"4 - Senha"
			oPrint:Say(nLinIni + 0205, (nColIni + nColMax)*0.44 + 0020, aDados[nX, 04], oFont04)
			oPrint:Box(nLinIni + 0170, (nColIni + nColMax)*0.72, nLinIni + 0250, nColIni + nColMax - 0010)
			oPrint:Say(nLinIni + 0175, (nColIni + nColMax)*0.72 + 0010, "5 - Número da Guia Atribuído pela Operadora", oFont01) //"5 - Número da Guia Atribuído pela Operadora"
			oPrint:Say(nLinIni + 0205, (nColIni + nColMax)*0.72 + 0020, aDados[nX, 05], oFont04)

			AddTBrush(oPrint, nLinIni + 0257, nColIni + 0010, nLinIni + 0285, nColIni + nColMax)
			oPrint:Say(nLinIni + 0260, nColIni + 0020, "Dados do Beneficiário", oFont01) //"Dados do Beneficiário"
			oPrint:Box(nLinIni + 0290, nColIni + 0020, nLinIni + 0370, (nColIni + nColMax)*0.25 - 0010)
			oPrint:Say(nLinIni + 0295, nColIni + 0030, "6 - Número da Carteira", oFont01) //"6 - Número da Carteira"
			oPrint:Say(nLinIni + 0325, nColIni + 0040, aDados[nX, 06], oFont04)
			oPrint:Box(nLinIni + 0290, (nColIni + nColMax)*0.25, nLinIni + 0370, (nColIni + nColMax)*0.9 - 0010)
			oPrint:Say(nLinIni + 0295, (nColIni + nColMax)*0.25 + 0010, "7 - Nome", oFont01) //"7 - Nome"
			oPrint:Say(nLinIni + 0325, (nColIni + nColMax)*0.25 + 0020, aDados[nX, 07], oFont04)
			oPrint:Box(nLinIni + 0290, (nColIni + nColMax)*0.9, nLinIni + 0370, nColIni + nColMax - 0010)
			oPrint:Say(nLinIni + 0295, (nColIni + nColMax)*0.9 + 0010, "8 - Atendimento a RN", oFont01) //"7 - Nome"
			oPrint:Say(nLinIni + 0325, (nColIni + nColMax)*0.9 + 0020, aDados[nX, 08], oFont04)

			AddTBrush(oPrint, nLinIni + 0377, nColIni + 0010, nLinIni + 0405, nColIni + nColMax)
			oPrint:Say(nLinIni + 0380, nColIni + 0020, "Dados do Contratado (onde foi executado o procedimento)", oFont01) //"Dados do Contratado (onde foi executado o procedimento)"
			oPrint:Box(nLinIni + 0410, nColIni + 0020, nLinIni + 0490, (nColIni + nColMax)*0.20 - 0010)
			oPrint:Say(nLinIni + 0415, nColIni + 0030, "9 - Código na Operadora", oFont01) //"9 - Código na Operadora"
			oPrint:Say(nLinIni + 0445, nColIni + 0040, aDados[nX, 09], oFont04)
			oPrint:Box(nLinIni + 0410, (nColIni + nColMax)*0.20, nLinIni + 0490, (nColIni + nColMax)*0.85 - 0010)
			oPrint:Say(nLinIni + 0415, (nColIni + nColMax)*0.20 + 0010, "10 - Nome do Hospital/Local", oFont01) //"10 - Nome do Hospital/Local"
			oPrint:Say(nLinIni + 0445, (nColIni + nColMax)*0.20 + 0020, aDados[nX, 10], oFont04)
			oPrint:Box(nLinIni + 0410, (nColIni + nColMax)*0.85, nLinIni + 0490, nColIni + nColMax - 0010)
			oPrint:Say(nLinIni + 0415, (nColIni + nColMax)*0.85 + 0010, "11 - Código CNES", oFont01) //"11 - Código CNES"
			oPrint:Say(nLinIni + 0445, (nColIni + nColMax)*0.85 + 0020, aDados[nX, 11], oFont04)

			AddTBrush(oPrint, nLinIni + 0497, nColIni + 0010, nLinIni + 0525, nColIni + nColMax)
			oPrint:Say(nLinIni + 0500, nColIni + 0020, "Dados do Contratado Executante", oFont01) //"Dados do Contratado Executante"
			oPrint:Box(nLinIni + 0530, nColIni + 0020, nLinIni + 0610, (nColIni + nColMax)*0.18 - 0010)
			oPrint:Say(nLinIni + 0535, nColIni + 0030, "12 - Código na Operadora", oFont01) //"12 - Código na Operadora"
			oPrint:Say(nLinIni + 0565, nColIni + 0040, aDados[nX, 12], oFont04)
			oPrint:Box(nLinIni + 0530, (nColIni + nColMax)*0.18, nLinIni + 0610, (nColIni + nColMax)*0.85 - 0010)
			oPrint:Say(nLinIni + 0535, (nColIni + nColMax)*0.18 + 0010, "13 - Nome do Contratado", oFont01) //"13 - Nome do Contratado"
			oPrint:Say(nLinIni + 0565, (nColIni + nColMax)*0.18 + 0020, aDados[nX, 13], oFont04)
			oPrint:Box(nLinIni + 0530, (nColIni + nColMax)*0.85, nLinIni + 0610, nColIni + nColMax - 0010)
			oPrint:Say(nLinIni + 0535, (nColIni + nColMax)*0.85 + 0010, "14 - Código CNES", oFont01) //"14 - Código CNES"
			oPrint:Say(nLinIni + 0565, (nColIni + nColMax)*0.85 + 0020, aDados[nX, 14], oFont04)

			nLinIni -= 90

			AddTBrush(oPrint, nLinIni + 0707, nColIni + 0010, nLinIni + 0735, nColIni + nColMax)
			oPrint:Say(nLinIni + 0710, nColIni + 0020, "Dados da internação", oFont01) //"Dados da internação"
			oPrint:Box(nLinIni + 0740, nColIni + 0020, nLinIni + 0820, (nColIni + nColMax)*0.18 - 0010)
			oPrint:Say(nLinIni + 0745, nColIni + 0030, "15 - Data do Início do Faturamento", oFont01) //"20 – Data do Início do Faturamento"
			oPrint:Say(nLinIni + 0775, nColIni + 0040, DtoC(aDados[nX, 15]), oFont04)
			oPrint:Box(nLinIni + 0740, (nColIni + nColMax)*0.18, nLinIni + 0820, (nColIni + nColMax)*0.36 - 0010)
			oPrint:Say(nLinIni + 0745, (nColIni + nColMax)*0.18 + 0010, "16 - Data do Fim do Faturamento", oFont01) //"21 – Data do Fim do Faturamento"
			oPrint:Say(nLinIni + 0775, (nColIni + nColMax)*0.18 + 0020, DtoC(aDados[nX, 16]), oFont04)

			AddTBrush(oPrint, nLinIni + 0827, nColIni + 0010, nLinIni + 0855, nColIni + nColMax)
			oPrint:Say(nLinIni + 0830, nColIni + 0020, "Procedimentos Realizados", oFont01) //"Dados da internação"
			oPrint:Box(nLinIni + 0860, nColIni + 0020, nLinIni + 1400, nColIni + nColMax - 0010)
			oPrint:Say(nLinIni + 0868, (nColIni + nColMax)*0.02, "17 - Data", oFont01) //"23 - Data"
			oPrint:Say(nLinIni + 0868, (nColIni + nColMax)*0.11, "18 - Hora Inicial", oFont01) //"24 - Hora Inicial"
			oPrint:Say(nLinIni + 0868, (nColIni + nColMax)*0.16, "19 - Hora Final", oFont01) //"25 - Hora Final"
			oPrint:Say(nLinIni + 0868, (nColIni + nColMax)*0.21, "20 - Tabela", oFont01) //"26 - Tabela"
			oPrint:Say(nLinIni + 0868, (nColIni + nColMax)*0.25, "21 - Código do Procedimento", oFont01) //"27 - Código do Procedimento"
			oPrint:Say(nLinIni + 0868, (nColIni + nColMax)*0.335, "22 - Descrição", oFont01) //"28 - Descrição"
			oPrint:Say(nLinIni + 0868, (nColIni + nColMax)*0.72, "23 - Qtde", oFont01) //"29 - Qtde"
			oPrint:Say(nLinIni + 0868, (nColIni + nColMax)*0.75, "24 - Via", oFont01) //"30 - Via"
			oPrint:Say(nLinIni + 0868, (nColIni + nColMax)*0.78, "25 - Tec", oFont01) //"31 - Tec"
			oPrint:Say(nLinIni + 0868, (nColIni + nColMax)*0.81, "26 - Fator Red", oFont01) //"32 - Fator Red"
			oPrint:Say(nLinIni + 0882, (nColIni + nColMax)*0.817, "/ Acresc", oFont01) //"/ Acresc"
			oPrint:Say(nLinIni + 0868, (nColIni + nColMax)*0.86, "27 - Valor Unitário - R$", oFont01) //"33 - Valor Unitário - R$"
			oPrint:Say(nLinIni + 0868, (nColIni + nColMax)*0.93, "28 - Valor Total – R$", oFont01) //"34-Valor Total – R$"

			nOldLinIni := nLinIni

			For nI := nIni To nAte
				oPrint:Say(nLinIni + 0912, nColIni + (nColMax*0.009), AllTrim(Str(nI)) + " - ", oFont01)

				oPrint:Say(nLinIni + 0910, (nColIni + nColMax)*0.03, DtoC(aDados[nX, 17, nI]), oFont04)
				oPrint:Say(nLinIni + 0910, (nColIni + nColMax)*0.117, IIf(Empty(aDados[nX, 18, nI]), "", Transform(aDados[nX, 18, nI], "@R 99:99")), oFont04)
				oPrint:Say(nLinIni + 0910, (nColIni + nColMax)*0.167, IIf(Empty(aDados[nX, 19, nI]), "", Transform(aDados[nX, 19, nI], "@R 99:99")), oFont04)
				oPrint:Say(nLinIni + 0910, (nColIni + nColMax)*0.215, aDados[nX, 20, nI], oFont04)
				oPrint:Say(nLinIni + 0910, (nColIni + nColMax)*0.25, aDados[nX, 21, nI], oFont04)
				oPrint:Say(nLinIni + 0910, (nColIni + nColMax)*0.335, aDados[nX, 22, nI], oFont04)
				oPrint:Say(nLinIni + 0910, (nColIni + nColMax)*0.735, IIf(aDados[nX, 23, nI]=0, "", Transform(aDados[nX, 23, nI], "@E 999")), oFont04,,,,1)
				oPrint:Say(nLinIni + 0910, (nColIni + nColMax)*0.757, aDados[nX, 24, nI], oFont04)
				oPrint:Say(nLinIni + 0910, (nColIni + nColMax)*0.79, aDados[nX, 25, nI], oFont04,,,,1)
				oPrint:Say(nLinIni + 0910, (nColIni + nColMax)*0.83, IIf(Empty(aDados[nX, 26, nI]), "", Transform(aDados[nX, 26, nI], "@E 9.99")), oFont04,,,,1)
				oPrint:Say(nLinIni + 0910, (nColIni + nColMax)*0.925, IIf(Empty(aDados[nX, 27, nI]), "", Transform(aDados[nX, 27, nI], "@E 99,999,999.99")), oFont04,,,,1)
				oPrint:Say(nLinIni + 0910, (nColIni + nColMax)*0.99, IIf(Empty(aDados[nX, 28, nI]), "", Transform(aDados[nX, 28, nI], "@E 99,999,999.99")), oFont04,,,,1)
				nLinIni += 50
			Next nI

			nLinIni := nOldLinIni

			nIni		:= nAte + 1
			If nAte < Len(aDados[nX][17])
				lImpNovo 	:= .T.
				nAte		+= 10
			EndIf

			nLinIni -= 100

			AddTBrush(oPrint, nLinIni + 1507, nColIni + 0010, nLinIni + 1535, nColIni + nColMax)
			oPrint:Say(nLinIni + 1510, nColIni + 0020, "Identificação do(s) Profissional(is) Executante(s)", oFont01) //"Identificação do(s) Profissional(is) Executante(s)"
			oPrint:Box(nLinIni + 1540, nColIni + 0020, nLinIni + 1900, nColIni + nColMax - 0010)
			oPrint:Say(nLinIni + 1555, nColIni + 0030, "29-Seq. Ref", oFont01) //"29-Seq. Ref"
			oPrint:Say(nLinIni + 1555, (nColIni + nCOlMax)*0.07, "30-Grau Part.", oFont01) //"30-Grau Part."
			oPrint:Say(nLinIni + 1555, (nColIni + nCOlMax)*0.15, "31-Còdigo na Operadora/CPF", oFont01) //"31-Còdigo na Operadora/CPF"
			oPrint:Say(nLinIni + 1555, (nColIni + nCOlMax)*0.25, "32-Nome do Profissional", oFont01) //"32-Nome do Profissional"
			oPrint:Say(nLinIni + 1555, (nColIni + nCOlMax)*0.7, "33-Conselho", oFont01) //"33-Conselho"
			oPrint:Say(nLinIni + 1575, (nColIni + nCOlMax)*0.7, "Profissional", oFont01) //"Profissional"
			oPrint:Say(nLinIni + 1555, (nColIni + nCOlMax)*0.78, "34-Número do Conselho", oFont01) //"34-Número do Conselho"
			oPrint:Say(nLinIni + 1555, (nColIni + nCOlMax)*0.87, "35-UF", oFont01) //"35-UF"
			oPrint:Say(nLinIni + 1555, (nColIni + nCOlMax)*0.92, "36-Código CBO", oFont01) //"36-Código CBO"

			nOldLinIni := nLinIni

			For nI := nIni2 To nAte2
				If !Empty(aDados[nX, 32, nI])
					oPrint:Say(nLinIni + 1600, nColIni + 0030, AllTrim(aDados[nX, 29, nI]), oFont04)
					oPrint:Say(nLinIni + 1600, (nColIni + nColMax)*0.07, aDados[nX, 30, nI], oFont04)
					oPrint:Say(nLinIni + 1600, (nColIni + nColMax)*0.15, aDados[nX, 31, nI], oFont04)
					oPrint:Say(nLinIni + 1600, (nColIni + nColMax)*0.25, aDados[nX, 32, nI], oFont04)
					oPrint:Say(nLinIni + 1600, (nColIni + nColMax)*0.7, aDados[nX, 33, nI], oFont04)
					oPrint:Say(nLinIni + 1600, (nColIni + nColMax)*0.78, aDados[nX, 34, nI], oFont04)
					oPrint:Say(nLinIni + 1600, (nColIni + nColMax)*0.87, aDados[nX, 35, nI], oFont04)
					oPrint:Say(nLinIni + 1600, (nColIni + nColMax)*0.92, aDados[nX, 36, nI], oFont04)
				EndIf

				nLinIni += 50
			Next nI

			nLinIni := nOldLinIni

			nIni2		:= nAte2 + 1
			If nAte2 < Len(aDados[nX][29])
				lImpNovo 	:= .T.
				nAte2		+= 5
			EndIf

			nLinIni += 410

			AddTBrush(oPrint, nLinIni + 1510, nColIni + 0020, nLinIni + 1800, (nColIni + nColMax)*0.85 - 0010)
			oPrint:Box(nLinIni + 1510, nColIni + 0020, nLinIni + 1800, (nColIni + nColMax)*0.85 - 0010)
			oPrint:Say(nLinIni + 1515, nColIni + 0030, "37- Observação / Justificativa", oFont01) //"35- Observação / Justificativa"

			nOldLinIni := nLinIni
			For nI := 1 To MlCount(aDados[nX, 37], 100)
				cObs := MemoLine(aDados[nX, 37], 100, nI)
				oPrint:Say(nLinIni + 1545, nColIni + 0040, strtran(cObs,char(10)," "), oFont04)
				nLinIni += 50
			Next nI
			nLinIni := nOldLinIni

			oPrint:Box(nLinIni + 1510, (nColIni + nColMax)*0.85, nLinIni + 1590, nColIni + nColMax - 0010)
			oPrint:Say(nLinIni + 1515, (nColIni + nColMax)*0.85 + 0010, "38 - Valor total dos honorários", oFont01) //"36 - Valor total dos honorários"
			oPrint:Say(nLinIni + 1545, (nColIni + nColMax)*0.85 + 0020, IIf(Empty(aDados[nX, 38]), "", Transform(aDados[nX, 38], "@E 99,999,999.99")), oFont04)

			oPrint:Box(nLinIni + 1810, nColIni + 0020, nLinIni + 1900, (nColIni + nColMax)*0.1 - 0010)
			oPrint:Say(nLinIni + 1815, nColIni + 0030, "39 - Data de emissão", oFont01) //"37 - Data de emissão"
			oPrint:Say(nLinIni + 1845, nColIni + 0040, DtoC(aDados[nX, 39]), oFont04)
			oPrint:Box(nLinIni + 1810, (nColIni + nColMax)*0.1, nLinIni + 1900, (nColIni + nColMax)*0.85 - 0010)
			oPrint:Say(nLinIni + 1815, (nColIni + nColMax)*0.1 + 0010, "40 - Assinatura do Profissional Executante", oFont01) //"38 - Assinatura do Profissional Executante"

			oPrint:EndPage()	// Finaliza a pagina
		Endif
	End

Next nX

	//END SEQUENCE
	//ErrorBlock( bError )

If !Empty(cErro)
	cArq := "erro_imp_relat_" + DtoS(Date()) + StrTran(Time(),":") + ".txt"
	MsgAlert("Erro ao gerar relatório. Visualize o log em /LOGPLS/" + cArq )
	cErro := 	"Erro ao carregar dados do relatório." + CRLF + ;
		"Verifique a cfg. de impressão da guia no cadastro de " + CRLF + ;
		"Tipos de Guias." + CRLF + CRLF + ;
		cErro
	PLSLogFil(cErro,cArq)
EndIf

If lGerTXT .OR. lWeb
	oPrint:Print()		// Imprime Relatorio
Else
	oPrint:Preview()	// Visualiza impressao grafica antes de imprimir
EndIf

Return cFileName
*/
/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡ao    ³ PLSTISSH  ³ Autor ³ Bruno Iserhardt       ³ Data ³ 28.06.13 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡ao ³ Estrutura Relatório TISS 3.00.01 (Guia Outras Despesas)     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ SigaPLS                                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ aDados - Array com as informações do relat´rio              ³±±
±±³          ³ lGerTXT - Define se imprime direto sem passar pela tela 	   ³±±
±±³          ³			 de configuracao/preview do relatorio 		       ³±±
±±³          ³ nLayout - Define o formato de papél para impressao:         ³±±
±±³          ³           1 - Formato Ofício II (216x330mm)                 ³±±
±±³          ³           2 - Formato A4 (210x297mm)                        ³±±
±±³          ³  		 3 - Formato Carta (216x279mm)     			       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Manutenção³ Anderson ³ Substituiu TMSPRINTER pela nova FWMSPRINTER com  ³±±
±±³          ³ A. Tome  ³ ajustes para o layout para 3.0                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/

User Function CABTISSH(aDados, lGerTXT, nLayout, cLogoGH)

Local nLinMax
Local nColMax
Local nLinIni		:=	0		// Linha Lateral (inicial) Esquerda
Local nColIni		:=	0		// Coluna Lateral (inicial) Esquerda
Local nColA4    	:=  0
Local cFileLogo
Local nOldLinIni
Local nI, nJ, nX
Local oFont01
Local oFont02n
Local oFont03n
Local oFont04
Local oFont05
Local lImpNovo		:= .T.
Local nAte 		:= 0
Local nIni			:= 0
Local lProrrog
Local cFileName  	:= "outras"+CriaTrab(NIL,.F.)
Local cPathSrvJ := GETMV("MV_RELT")

Default nLayout 	:= 2
Default lGerTXT 	:= .F.
Default cLogoGH 	:= ''
Default aDados 	:= { { ;
	"123456",; //1 - Registro ANS
	"12345678901234567890",; //2 – Número da Guia Referenciada
	"12345678901234",; //3 - Código na Operadora
	Replicate("M",70),; //4 - Nome do Contratado
	"1234567",; //5 – Código CNES
	{ "1","1","1","1","1","1","1","1","1","1","1","1","1" },; //6-CD
	{ CtoD("12/03/06"),CtoD("12/03/06"),CtoD("12/03/06"),CtoD("12/03/06"),CtoD("12/03/06"),CtoD("12/03/06"),CtoD("12/03/06"),CtoD("12/03/06"),CtoD("12/03/06"),CtoD("12/03/06"),CtoD("12/03/06"),CtoD("12/03/06"),CtoD("12/03/06")},; //7-Data
	{ "0507","0507","0507","0507","0507","0507","0507","0507","0507","0507","0507","0507","0507" },; //8-Hora Inicial
	{ "0507","0507","0507","0507","0507","0507","0507","0507","0507","0507","0507","0507","0507" },; //9-Hora Final
	{ "MM","AA","BB","CC","DD","DD","DD","DD","DD","DD","DD","DD","DD"},; //10-Tabela
	{ "5678901234","5678901234","5678901234","5678901234","5678901234","5678901234","5678901234","5678901234","5678901234","5678901234","5678901234","5678901234","5678901234"},; //11-Código do Item
	{ 111.1111,222.2222,333.3333,444.4444,555.5555,666.6666,777.7777,888.8888,999.9999,101.0101,202.0202,303.0303,404.0404},; //12-Qtde.
	{ "AAA","AAA","AAA","AAA","AAA","AAA","AAA","AAA","AAA","HHH","AAA","AAA","OOO" },; //13-Unidade de Medida
	{ 1.11, 2.22, 3.33, 4.44, 5.55, 6.66, 7.77, 8.88, 9.99, 1.01, 2.02, 3.03, 4.04 },; //14- Fator Red. / Acresc
	{ 111111.11, 222222.22, 333333.33, 444444.44, 555555.55, 666666.66, 777777.77, 888888.88, 999999.99, 101010.10, 202020.20, 303030.30, 404040.40 },; //15-Valor Unitário - R$
	{ 111111.11, 222222.22, 333333.33, 444444.44, 555555.55, 666666.66, 777777.77, 888888.88, 999999.99, 101010.10, 202020.20, 303030.30, 404040.40 },; //16-Valor Total – R$
	{ "123456789012345","123456789012345","123456789012345","123456789012345","123456789012345","123456789012345","123456789012345","123456789012345","123456789012345","123456789012345","123456789012345","123456789012345","123456789012345" },; //17-Registro ANVISA do Material
	{ "123456789012345678901234567890","123456789012345678901234567890","123456789012345678901234567890","123456789012345678901234567890","123456789012345678901234567890","123456789012345678901234567890","123456789012345678901234567890","123456789012345678901234567890","123456789012345678901234567890","123456789012345678901234567890","123456789012345678901234567890","123456789012345678901234567890","123456789012345678901234567890" },; //18-Referência do material no fabricante
	{ "123456789012345678901234567890","123456789012345678901234567890","123456789012345678901234567890","123456789012345678901234567890","123456789012345678901234567890","123456789012345678901234567890","123456789012345678901234567890","123456789012345678901234567890","123456789012345678901234567890","123456789012345678901234567890","123456789012345678901234567890","123456789012345678901234567890","123456789012345678901234567890" },; //19-Nº Autorização de Funcionamento
	{ Replicate("M", 150),Replicate("M", 150),Replicate("M", 150),Replicate("M", 150),Replicate("M", 150),Replicate("M", 150),Replicate("M", 150),Replicate("M", 150),Replicate("M", 150),Replicate("M", 150),Replicate("M", 150),Replicate("M", 150),Replicate("M", 150) },; //20-Descrição
	39999999.99,; //21 - Total de Gases Medicinais (R$)
	39999999.99,; //22 - Total de Medicamentos (R$)
	39999999.99,; //23 - Total de Materiais (R$)
	39999999.99,; //24 - Total de OPME (R$)
	39999999.99,; //25 - Total de Taxas e Aluguéis (R$)
	39999999.99,; //26 - Total de Diárias (R$)
	39999999.99 } } //27 - Total Geral (R$)

oPrint := FWMSPrinter():New ( cFileName			,			,	.F.				,cPathSrvJ	 	,	.T.				,			 ,				,			  ,			  ,	.F.			, 		, 				)

oPrint:SetLandscape()		// Modo paisagem

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
	//³ Caminho do arquivo
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
oPrint:cPathPDF := cPathSrvJ

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
	//³Verifica se existe alguma impressora configurada para Impressao Grafica
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
oPrint:Setup()

If oPrint:nPaperSize  == 9 // Papél A4
	nLinMax	:= 570
	nColMax	:= 820
	nLayout 	:= 2
	oFont01		:= TFont():New("Arial",  6,  6, , .F., , , , .T., .F.) // Normal
	oFont02n	:= TFont():New("Arial", 12, 12, , .T., , , , .T., .F.) // Negrito
	oFont03n	:= TFont():New("Arial", 13, 13, , .T., , , , .T., .F.) // Negrito
	oFont04		:= TFont():New("Arial", 07, 07, , .F., , , , .T., .F.) // Normal
Elseif oPrint:nPaperSize == 1 // Papel Carta
	nLinMax	:= 570
	nColMax	:= 820
	nLayout 	:= 3
	oFont01		:= TFont():New("Arial",  6,  6, , .F., , , , .T., .F.) // Normal
	oFont02n	:= TFont():New("Arial", 12, 12, , .T., , , , .T., .F.) // Negrito
	oFont03n	:= TFont():New("Arial", 13, 13, , .T., , , , .T., .F.) // Negrito
	oFont04		:= TFont():New("Arial", 07, 07, , .F., , , , .T., .F.) // Normal
Else // Papel Oficio2 216 x 330mm / 8 1/2 x 13in
	nLinMax	:= 570
	nColMax	:= 820
	nLayout 	:= 1
	oFont01		:= TFont():New("Arial",  6,  6, , .F., , , , .T., .F.) // Normal
	oFont02n	:= TFont():New("Arial", 12, 12, , .T., , , , .T., .F.) // Negrito
	oFont03n	:= TFont():New("Arial", 14, 14, , .T., , , , .T., .F.) // Negrito
	oFont04		:= TFont():New("Arial", 09, 09, , .F., , , , .T., .F.) // Normal
Endif

For nX := 1 To Len(aDados)

	nAte := 0
	nIni := 1

	If Len(aDados[nX]) == 0
		Loop
	EndIf

	While lImpNovo

		lImpNovo := .F.
		nAte += 10

		For nI := 6 To 20
			If Len(aDados[nX, nI]) < nAte
				For nJ := Len(aDados[nX, nI]) + 1 To nAte
					If AllTrim(StrZero(nI, 2, 0)) $ "07"
						aAdd(aDados[nX, nI], StoD(''))
					ElseIf AllTrim(StrZero(nI, 2, 0)) $ "12,14,15,16"
						aAdd(aDados[nX, nI], 0)
					Else
						aAdd(aDados[nX, nI], "")
					EndIf
				Next nJ
			EndIf
		Next nI

		nLinIni := 010
		nColIni := 005
		nColA4  := 000

		oPrint:StartPage()		// Inicia uma nova pagina
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Box Principal                                                 ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		oPrint:Box(nLinIni + 0010, nColIni + 0010, nLinIni + (nLinMax - 0010), nColIni + nColMax )

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Carrega e Imprime Logotipo da Empresa                         ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		fLogoEmp(@cFileLogo,, cLogoGH)

		If File(cFilelogo)
			oPrint:SayBitmap(nLinIni + 0015, nColIni + 0015, cFileLogo, 060, 040) 		// Tem que estar abaixo do RootPath
		EndIf

		If nLayout == 2 // Papél A4
			nColA4    := -0335
		Elseif nLayout == 3// Carta
			nColA4    := -0530
		Endif

			//"ANEXO DE OUTRAS DESPESAS"
		oPrint:Say(nLinIni + 0030, nColIni + (nColMax * 0.40) , "ANEXO DE OUTRAS DESPESAS", oFont02n,,,,2)

			//"(para Guia de SP/SADT e Resumo de Internação)"
		oPrint:Say(nLinIni + 0040, nColIni + (nColMax * 0.37) , "(para Guia de SP/SADT e Resumo de Internação)", oFont05,,,,2)

			//"1 - Registro ANS"
		oPrint:Box(nLinIni + 0070, nColIni + 0020, nLinIni + 0100, nColIni + (nColMax*0.14))
		oPrint:Say(nLinIni + 0080, nColIni + 0030, "1 - Registro ANS", oFont01)
		oPrint:Say(nLinIni + 0090, nColIni + 0040, aDados[nX, 01], oFont04)

			//"2 – Número da Guia Referenciada"
		oPrint:Box(nLinIni + 0070, nColIni + (nColMax * 0.15), nLinIni + 0100, nColIni + (nColMax*0.42))
		oPrint:Say(nLinIni + 0080, nColIni + (nColMax * 0.15) + 0010, "2 – Número da Guia Referenciada", oFont01)
		oPrint:Say(nLinIni + 0090, nColIni + (nColMax * 0.15) + 0020, aDados[nX, 02], oFont04)

			//Linha cinza
		AddTBrush(oPrint,nLinIni + 0105, nColIni + (nColMax * 0.02432), nLinIni + 0115, nColIni + nColMax - 0010)

			//"Dados do Contratado Executante"
		oPrint:Say(nLinIni + 0110, nColIni + 0020, "Dados do Contratado Executante", oFont01)

			//"3 - Código na Operadora"
		oPrint:Box(nLinIni + 0120, nColIni + 0020, nLinIni + 0150, nColIni + (nColMax*0.18) - 0010)
		oPrint:Say(nLinIni + 0130, nColIni + 0030, "3 - Código na Operadora", oFont01)
		oPrint:Say(nLinIni + 0140, nColIni + 0040, aDados[nX, 03], oFont04)

			//"4 - Nome do Contratado"
		oPrint:Box(nLinIni + 0120, nColIni + (nColMax * 0.18), nLinIni + 0150, nColIni + (nColMax*0.9) - 0010)
		oPrint:Say(nLinIni + 0130, nColIni + (nColMax * 0.18) + 0010, "4 - Nome do Contratado", oFont01)
		oPrint:Say(nLinIni + 0140, nColIni + (nColMax * 0.18) + 0020, aDados[nX, 04], oFont04)

			//"5 – Código CNES"
		oPrint:Box(nLinIni + 0120, nColIni + (nColMax * 0.9), nLinIni + 0150, nColIni + nColMax - 0010)
		oPrint:Say(nLinIni + 0130, nColIni + (nColMax * 0.9) + 0010, "5 – Código CNES", oFont01)
		oPrint:Say(nLinIni + 0140, nColIni + (nColMax * 0.9) + 0020, aDados[nX, 05], oFont04)

			//Linha cinza
		AddTBrush(oPrint, nLinIni + 0153, nColIni + (nColMax * 0.02432), nLinIni + 0166, nColIni + nColMax - 0010)

			//"Despesas Realizadas"
		oPrint:Say(nLinIni + 0160, nColIni + (nColMax * 0.02432), "Despesas Realizadas", oFont01)

			//Box da "Despesas Realizadas"
		oPrint:Box(nLinIni + 0170, nColIni + (nColMax * 0.02432), nLinIni + (nLinMax * 0.90) , nColIni + nColMax - 0010)

			//"6-CD"
		oPrint:Say(nLinIni + 0175, nColIni + (nColMax * 0.025), "6-CD"					, oFont01)

			//"7-Data"
		oPrint:Say(nLinIni + 0175, nColIni + (nColMax * 0.065), "7-Data"				, oFont01)

			//"8-Hora Inicial"
		oPrint:Say(nLinIni + 0175, nColIni + (nColMax * 0.14), "8-Hora Inicial"			, oFont01)

			//"9-Hora Final"
		oPrint:Say(nLinIni + 0175, nColIni + (nColMax * 0.195), "9-Hora Final"			, oFont01)

			//"10-Tabela"
		oPrint:Say(nLinIni + 0175, nColIni + (nColMax * 0.252), "10-Tabela"				, oFont01)

			//"11-Código do Item"
		oPrint:Say(nLinIni + 0175, nColIni + (nColMax * 0.32), "11-Código do Item"		, oFont01)

			//"12-Qtde."
		oPrint:Say(nLinIni + 0175, nColIni + (nColMax * 0.50), "12-Qtde."				, oFont01)

			//"13-Unidade"
		oPrint:Say(nLinIni + 0175, nColIni + (nColMax * 0.68), "13-Unidade"				, oFont01)

			//"de Medida"
		oPrint:Say(nLinIni + 0185, nColIni + (nColMax * 0.685), "de Medida"				, oFont01)

			//"14- Fator Red."
		oPrint:Say(nLinIni + 0175, nColIni + (nColMax * 0.76), "14- Fator Red."			, oFont01)

			 //"/ Acresc"
		oPrint:Say(nLinIni + 0185, nColIni + (nColMax * 0.765), "/ Acresc"				, oFont01)

			//"15-Valor Unitário - R$"
		oPrint:Say(nLinIni + 0175, nColIni + (nColMax * 0.83), "15-Valor Unitário - R$"	, oFont01)

			//"16-Valor Total – R$"
		oPrint:Say(nLinIni + 0175, nColIni + (nColMax * 0.92), "16-Valor Total – R$"	, oFont01)

			//"17-Registro ANVISA do Material"
		oPrint:Say(nLinIni + 0185, nColIni + (nColMax * 0.025), "17-Registro ANVISA do Material"		, oFont01)

			//"18-Referência do material no fabricante"
		oPrint:Say(nLinIni + 0185, nColIni + (nColMax*0.195), "18-Referência do material no fabricante"	, oFont01)

			//"19-Nº Autorização de Funcionamento"
		oPrint:Say(nLinIni + 0185, nColIni + (nColMax*0.83), "19-Nº Autorização de Funcionamento"		, oFont01)

		nOldLinIni := nLinIni
		For nI := nIni To nAte
			oPrint:Say(nLinIni + 0200, nColIni + 0030, AllTrim(Str(nI)) + " - ", oFont04)

				//6-CD
			oPrint:Say(nLinIni + 0200, nColIni + (nColMax * 0.025), aDados[nX, 6, nI], oFont04)

				//7-Data
			oPrint:Say(nLinIni + 0200, nColIni + (nColMax * 0.06) , IIf(Empty(DtoC(aDados[nX, 7, nI])),'|_|_|/|_|_|/|_|_|_|_|',DtoC(aDados[nX, 7, nI])), oFont04) // "|_|_|/|_|_|/|_|_|_|_|"

				//8-Hora Inicial
			oPrint:Say(nLinIni + 0200, nColIni + (nColMax * 0.146), IIf(Empty(aDados[nX, 8, nI]), "", Transform(aDados[nX, 8, nI], "@R 99:99")), oFont04)

			 	//9-Hora Final
			oPrint:Say(nLinIni + 0200, nColIni + (nColMax * 0.196), IIf(Empty(aDados[nX, 9, nI]), "", Transform(aDados[nX, 9, nI], "@R 99:99")), oFont04)

				//10-Tabela
			oPrint:Say(nLinIni + 0200, nColIni + (nColMax * 0.255), aDados[nX, 10, nI], oFont04)

				//11-Código do Item
			oPrint:Say(nLinIni + 0200, nColIni + (nColMax * 0.32) , aDados[nX, 11, nI], oFont04)

				//12-Qtde.
			oPrint:Say(nLinIni + 0200, nColIni + (nColMax * 0.51) , IIf(Empty(aDados[nX, 12, nI]), "", Transform(aDados[nX, 12, nI], '@E 9999')), oFont04,,,,1)

				//13-Unidade de Medida
			oPrint:Say(nLinIni + 0200, nColIni + (nColMax * 0.68) , aDados[nX, 13, nI], oFont04)//

				//14- Fator Red. / Acresc
			oPrint:Say(nLinIni + 0200, nColIni + (nColMax * 0.78) , IIf(Empty(aDados[nX, 14, nI]), "", Transform(aDados[nX, 14, nI], "@E 9.99")), oFont04,,,,1)

				//15-Valor Unitário -
			oPrint:Say(nLinIni + 0200, nColIni + (nColMax * 0.84) , IIf(Empty(aDados[nX, 15, nI]), "", Transform(aDados[nX, 15, nI], "@E 999,999.99")), oFont04,,,,1)

				//16-Valor Total -
			oPrint:Say(nLinIni + 0200, nColIni + (nColMax * 0.93) , IIf(Empty(aDados[nX, 16, nI]), "", Transform(aDados[nX, 16, nI], "@E 999,999.99")), oFont04,,,,1)

				// Pula uma linha
			nLinIni += 10

				// 17-Registro ANVISA do Material
			oPrint:Say(nLinIni + 0200, nColIni + (nColMax * 0.025), aDados[nX, 17, nI], oFont04)

				// 18-Referência do material no fabricante
			oPrint:Say(nLinIni + 0200, nColIni + (nColMax * 0.195), aDados[nX, 18, nI], oFont04)

				// 19-Nº Autorização de Funcionamento
			oPrint:Say(nLinIni + 0200, nColIni + (nColMax * 0.83 ), aDados[nX, 19, nI], oFont04)

				// Pula uma linha
			nLinIni += 10

				//"20-Descrição"
			oPrint:Say(nLinIni + 0200, nColIni + (nColMax * 0.025), "20-Descrição", oFont01)

				//"20-Descrição"
			oPrint:Say(nLinIni + 0200, nColIni + (nColMax * 0.07 ), aDados[nX, 20, nI], oFont04)

				// Pula uma linha
			nLinIni += 10

		Next nI

		nLinIni := nOldLinIni

		If nAte < Len(aDados[nX][6])
			lImpNovo 	:= .T.
			nIni 		:= nAte + 1
		EndIf

			//"21 - Total de Gases Medicinais (R$)"
		oPrint:Box(nLinIni + (nLinMax * 0.91), nColIni + 0020, nLinIni + (nLinMax * 0.972), nColIni + (nColMax/7) - 0008)
		oPrint:Say(nLinIni + (nLinMax * 0.93), nColIni + 0021, "21 - Total de Gases Medicinais (R$)", oFont01)
		oPrint:Say(nLinIni + (nLinMax * 0.94), nColIni + (nColMax* 0.1062), IIf(Empty(aDados[nX, 21]), "", Transform(aDados[nX, 21], "@E 99,999,999.99")), oFont04,,,,1)

			//"22 - Total de Medicamentos (R$)"
		oPrint:Box(nLinIni + (nLinMax * 0.91), nColIni + (nColMax* 0.14286), nLinIni + (nLinMax * 0.972), nColIni + (nColMax/7*2) - 0010)
		oPrint:Say(nLinIni + (nLinMax * 0.93), nColIni + (nColMax* 0.145), "22 - Total de Medicamentos (R$)", oFont01)
		oPrint:Say(nLinIni + (nLinMax * 0.94), nColIni + (nColMax* 0.165), IIf(Empty(aDados[nX, 22]), "", Transform(aDados[nX, 22], "@E 99,999,999.99")), oFont04,,,,1)

			 //"23 - Total de Materiais (R$)"
		oPrint:Box(nLinIni + (nLinMax * 0.91), nColIni + (nColMax* 0.285), nLinIni + (nLinMax * 0.972), nColIni + (nColMax/7*3) - 0010)
		oPrint:Say(nLinIni + (nLinMax * 0.93), nColIni + (nColMax* 0.288), "23 - Total de Materiais (R$)", oFont01)
		oPrint:Say(nLinIni + (nLinMax * 0.94), nColIni + (nColMax* 0.300), IIf(Empty(aDados[nX, 23]), "", Transform(aDados[nX, 23], "@E 99,999,999.99")), oFont04,,,,1)

			//"24 - Total de OPME (R$)"
		oPrint:Box(nLinIni + (nLinMax * 0.91), nColIni + (nColMax/7*3), nLinIni + (nLinMax * 0.972), nColIni + (nColMax/7*4) - 0010)
		oPrint:Say(nLinIni + (nLinMax * 0.93), nColIni + (nColMax/7*3) + 0002, "24 - Total de OPME (R$)", oFont01)
		oPrint:Say(nLinIni + (nLinMax * 0.94), nColIni + (nColMax/7*3) + 0006, IIf(Empty(aDados[nX, 24]), "", Transform(aDados[nX, 24], "@E 99,999,999.99")), oFont04,,,,1)

			//"25 - Total de Taxas e Aluguéis (R$)"
		oPrint:Box(nLinIni + (nLinMax * 0.91), nColIni + (nColMax/7*4), nLinIni + (nLinMax * 0.972), nColIni + (nColMax/7*5) - 0010)
		oPrint:Say(nLinIni + (nLinMax * 0.93), nColIni + (nColMax/7*4) + 0002, "25 - Total de Taxas e Aluguéis (R$)", oFont01)
		oPrint:Say(nLinIni + (nLinMax * 0.94), nColIni + (nColMax/7*4) + 0006, IIf(Empty(aDados[nX, 25]), "", Transform(aDados[nX, 25], "@E 99,999,999.99")), oFont04,,,,1)

			//"26 - Total de Diárias (R$)"
		oPrint:Box(nLinIni + (nLinMax * 0.91), nColIni + (nColMax/7*5), nLinIni + (nLinMax * 0.972), nColIni + (nColMax/7*6) - 0010)
		oPrint:Say(nLinIni + (nLinMax * 0.93), nColIni + (nColMax/7*5) + 0002, "26 - Total de Diárias (R$)", oFont01)
		oPrint:Say(nLinIni + (nLinMax * 0.94), nColIni + (nColMax/7*5) + 0006, IIf(Empty(aDados[nX, 26]), "", Transform(aDados[nX, 26], "@E 99,999,999.99")), oFont04,,,,1)

			//"27 - Total Geral (R$)"
		oPrint:Box(nLinIni + (nLinMax * 0.91), nColIni + (nColMax/7*6), nLinIni + (nLinMax * 0.972), nColIni + nColMax - 0010)
		oPrint:Say(nLinIni + (nLinMax * 0.93), nColIni + (nColMax/7*6) + 0002, "27 - Total Geral (R$)", oFont01)
		oPrint:Say(nLinIni + (nLinMax * 0.94), nColIni + (nColMax/7*6) + 0006, IIf(Empty(aDados[nX, 27]), "", Transform(aDados[nX, 27], "@E 99,999,999.99")), oFont04,,,,1)

		oPrint:Say(nLinIni + (nLinMax * 1), nColIni + 0021, 'Padrão TISS - Componente de Conteúdo e Estrutura - Janeiro 2015', oFont01) //'Padrão TISS - Componente de Conteúdo e Estrutura - Janeiro 2015'

		oPrint:EndPage()	// Finaliza a pagina

	End

Next nX

If lGerTXT
	oPrint:Print()		// Imprime Relatorio
Else
	oPrint:Preview()	// Visualiza impressao grafica antes de imprimir
EndIf

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡ao    ³ PLSTISSI  ³ Autor ³ Bruno Iserhardt       ³ Data ³ 29.09.13 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡ao ³ Estrutura Relatório TISS 3.00.01 (Guia Odontológica)        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ SigaPLS                                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ aDados - Array com as informações do relat´rio              ³±±
±±³          ³ nLayout - Define o formato de papél para impressao:         ³±±
±±³          ³           1 - Formato Ofício II (216x330mm)                 ³±±
±±³          ³           2 - Formato A4 (210x297mm)                        ³±±
±±³          ³  		 3 - Formato Carta (216x279mm)     			       ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function CABTISSI(aDados, nLayout, cLogoGH, lGerTXT, lWeb, cPathRelW) //Guia Odontológica - Cobrança

Local nLinMax
Local nColMax
Local nLinIni	:=	0		// Linha Lateral (inicial) Esquerda
Local nColIni	:=	0		// Coluna Lateral (inicial) Esquerda
Local nColA4    :=  0
Local cFileLogo
LOCAL nX
Local nI, nJ
Local oFont01
Local oFont02n
Local oFont03n
Local oFont04
Local nP		:= 1
Local nP1		:= 0
Local nAte 		:= 20
Local lImpnovo 	:= .T.
Local nVolta	:= 0
LOCAL cFileName	:= ""
LOCAL cRel      := "GUICONS"
LOCAL cPathSrvJ := GETMV("MV_RELT")
LOCAL nAL		:= 0.25
LOCAL nAC		:= 0.24

DEFAULT lGerTXT 	:= .F.
DEFAULT nLayout 	:= 2
DEFAULT cLogoGH 	:= ""
DEFAULT lWeb		:= .F.
DEFAULT cPathRelW 	:= ""
DEFAULT aDados  := { { ;
	"123456",; //1 - Registro ANS
	"12345678901234567890",; //2- Nº Guia no Prestador
	"12345678901234567890",; //3 - Número da Guia Principal
	CtoD("05/03/07"),; //4 - Data da Autorização
	"12345678901234567890",; //5 - Senha
	CtoD("01/12/07"),; //6 - Data de Validade da Senha
	"12345678901234567890",; //7 - Número da Guia Atribuído pela Operadora
	"12345678901234567890",; //8 - Número da Carteira
	Replicate("M",60),; //9 - Plano
	Replicate("M",40),; //10- Empresa
	CtoD("01/12/07"),; //11 - Validade da Carteira
	"123456789012345",; //12 - Cartão Nacional de Saúde
	Replicate("M",70),; //13 - Nome
	"14345678901",; //14 - Telefone
	Replicate("M",70),; //15 - Nome do titular do plano
	"N",; //16 -Atendimento a RN
	Replicate("M",70),; //17 - Nome do Profissional Solicitante
	"183456789012345",; //18 - Número no CRO
	"RS",; //19 - UF
	"123456",; //20 - Código CBO
	"21345678901234",; //21 - Código na Operadora
	Replicate("M",70),; //22 - Nome do Contratado Executante
	"233456789012345",; //23 - Número no CRO
	"RS",; //24 - UF
	"1234567",; //25 - Código CNES
	Replicate("M",70),; //26 - Nome do Profissional Executante
	"273456789012345",; //27 - Número no CRO
	"RS",; //28 - UF
	"293456",; //29 - Código CBO
	{"AA","BB","CC","DD","EE","FF","GG","HH","II","JJ","KK","LL","MM","NN","OO","PP","LL","MM","NN","OO","PP"},; //30-Tabela
	{"1234567890","1234567890","1234567890","1234567890","1234567890","1234567890","1234567890","1234567890","1234567890","1234567890","1234567890","1234567890","1234567890","1234567890","1234567890","1234567890"},; //31 - Código do Procedimento
	{Replicate("M",40),Replicate("M",40),Replicate("M",40),Replicate("M",70),Replicate("M",70),Replicate("M",70),Replicate("M",70),Replicate("M",70),Replicate("M",70),Replicate("M",70),Replicate("M",70),Replicate("M",70),Replicate("M",70),Replicate("M",70),Replicate("M",70),Replicate("M",70)},; //32 - Descrição
	{"1234","1234","1234","1234","1234","1234","1234","1234","1234","1234","1234","1234","1234","1234","1234","1234"},; //33-Dente/Região
	{"ABCDE","ABCDE","ABCDE","ABCDE","ABCDE","ABCDE","ABCDE","ABCDE","ABCDE","ABCDE","ABCDE","ABCDE","ABCDE","ABCDE","ABCDE","ABCDE"},; //34-Face
	{10,20,30,40,50,60,70,80,90,15,25,35,45,55,65,75},; //35-Qtde
	{99999.99,99999.99,99999.99,99999.99,99999.99,99999.99,99999.99,99999.99,99999.99,99999.99,99999.99,99999.99,99999.99,99999.99,99999.99,99999.99},; //36-Qtde US
	{999999.99,999999.99,999999.99,999999.99,999999.99,999999.99,999999.99,999999.99,999999.99,999999.99,999999.99,999999.99,999999.99,999999.99,999999.99,999999.99},; //37-Valor R$
	{999999.99,999999.99,999999.99,999999.99,999999.99,999999.99,999999.99,999999.99,999999.99,999999.99,999999.99,999999.99,999999.99,999999.99,999999.99,999999.99},; //38-Franquia (R$)
	{"A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A"},; //39-Aut
	{CtoD("01/03/07"),CtoD("01/03/07"),CtoD("01/03/07"),CtoD("01/03/07"),CtoD("01/03/07"),CtoD("01/03/07"),CtoD("01/03/07"),CtoD("01/03/07"),CtoD("01/03/07"),CtoD("01/03/07"),CtoD("01/03/07"),CtoD("01/03/07"),CtoD("01/03/07"),CtoD("01/03/07"),CtoD("01/03/07"),CtoD("01/03/07")},; //40-Data de Realização
	{"","","","","","","","","","","","","","","",""},; //41-Assinatura
	CtoD("01/04/07"),; //42 - Data de Término do Tratamento
	"1",; //43 - Tipo de Atendimento
	"1",; //44 - Tipo de Faturamento
	19999.99,; //45 - Total Quantidade US
	29999999.99,; //46 - Valor Total (R$)
	39999999.99,; //47 – Valor Total Franquia (R$)
	Replicate("M", 500),; //48 – Observação / Justificativa
	CtoD("30/12/07"),; //49–Data da Assinatura do Cirurgião-Dentista Solicitante
	"",; //50–Assinatura do Cirurgião-Dentista Solicitante
	CtoD("30/12/07"),; //51- Data da assinatura do Cirurgião-Dentista
	"",; //52- Assinatura do Cirurgião-Dentista
	CtoD("30/12/07"),; //53-Data da assinatura do Beneficiário ou Responsável
	"",; //54-Assinatura do Beneficiário ou Responsável
	CtoD("30/12/07") } }//55– Data do carimbo da empresa

If nLayout  == 1 // Ofício 2
	nLinMax := 2335
	nColMax := 3705
Elseif nLayout == 2   // Papél A4
	nLinMax	:=	2190
	nColMax	:=	3380 //3365
Else //Carta
	nLinMax	:=	2335
	nColMax	:=	3175
Endif

oFont01		:= TFont():New("Arial",  5,  5, , .F., , , , .T., .F.) // Normal
if nLayout == 1 // Oficio 2
	oFont02n	:= TFont():New("Arial", 12, 12, , .T., , , , .T., .F.) // Negrito
	oFont03n	:= TFont():New("Arial", 14, 14, , .T., , , , .T., .F.) // Negrito
	oFont04		:= TFont():New("Arial", 09, 09, , .F., , , , .T., .F.) // Normal
Else  // Papél A4 ou Carta
	oFont02n := TFont():New("Arial", 12, 12, , .T., , , , .T., .F.) // Negrito
	oFont03n := TFont():New("Arial", 13, 13, , .T., , , , .T., .F.) // Negrito
	oFont04	 := TFont():New("Arial", 07, 07, , .F., , , , .T., .F.) // Normal
Endif

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
	//³ Nao permite acionar a impressao quando for na web.
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
If lWeb
	cPathSrvJ := cPathRelW
	cFileName := cRel+CriaTrab(NIL,.F.)+".pdf"
Else
	cFileName := cRel+CriaTrab(NIL,.F.)
EndIf

	//						New ( < cFilePrintert >, [ nDevice], [ lAdjustToLegacy], [ cPathInServer], [ lDisabeSetup ], [ lTReport], [ @oPrintSetup], [ cPrinter], [ lServer], [ lPDFAsPNG], [ lRaw], [ lViewPDF] )
oPrint := FWMSPrinter():New ( cFileName			,			,	.F.				,cPathSrvJ	 	,	.T.				,			 ,				,			  ,			  ,	.F.			, 		, 				)
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
	//³Tratamento para impressao via job
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
	//oPrint:lInJob  := lWeb
oPrint:lServer := lWeb
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
	//³ Caminho do arquivo
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
oPrint:cPathPDF := cPathSrvJ

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
	//³Modo paisagem
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
oPrint:SetLandscape()

If nLayout ==2
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
		//³Papél A4
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
	oPrint:SetPaperSize(9)
ElseIf nLayout ==3
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
		//³Papél Carta
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
	oPrint:SetPaperSize(1)
Else
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
		//³Papel Oficio2 216 x 330mm / 8 1/2 x 13in
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
	oPrint:SetPaperSize(14)
Endif
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
	//³Device
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
If lWeb
	oPrint:setDevice(IMP_PDF)
	oPrint:lPDFAsPNG := .T.
EndIf

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
	//³Verifica se existe alguma impressora configurada para Impressao Grafica
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
If  !lWeb
	oPrint:Setup()
	lImpnovo:=(oPrint:nModalResult == 1)
EndIf

If oPrint:Cprinter == "PDF" .OR. lWeb
	nLinIni := 150
	nColMax -= 15
Else
	nLinIni := 000
Endif
nColIni := 040
nColA4  := 000

While lImpnovo
	lImpnovo:=.F.
	nVolta 	+= 1

	if (nVolta <> 1)
		nAte	+= nP-1
	EndIf

	For nX := 1 To Len(aDados)

		If Len(aDados[nX]) == 0
			Loop
		EndIf

		For nI := 30 To 40
			If Len(aDados[nX, nI]) < nAte
				For nJ := Len(aDados[nX, nI]) + 1 To nAte
					If AllTrim(Str(nI)) $ "35,36,37,38"
						aAdd(aDados[nX, nI], 0)
					ElseiF AllTrim(Str(nI)) $ "40"
						aAdd(aDados[nX, nI], StoD(""))
					Else
						aAdd(aDados[nX, nI],"")
					EndIf
				Next nJ
			EndIf
		Next nI

		oPrint:StartPage()		// Inicia uma nova pagina
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Box Principal                                                 ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		oPrint:Box((nLinIni + 0000)*nAL, (nColIni + 0000)*nAC, (nLinIni + nLinMax)*nAL, (nColIni + nColMax)*nAC)

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Carrega e Imprime Logotipo da Empresa                         ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		fLogoEmp(@cFileLogo,, cLogoGH)

		If File(cFilelogo)
			oPrint:SayBitmap((nLinIni + 0050)*nAL, (nColIni + 0020)*nAC, cFileLogo, (400)*nAL, (090)*nAC) 		// Tem que estar abaixo do RootPath
		EndIf

		If nLayout == 2 // Papél A4
			nColA4    := -0335
		Elseif nLayout == 3// Carta
			nColA4    := -0530
		Endif

		oPrint:Say((nLinIni + 0090)*nAL, (nColIni + (nColMax*0.4))*nAC, "GUIA TRATAMENTO ODONTOLÓGICO", oFont02n,,,,2) //"GUIA TRATAMENTO ODONTOLÓGICO"
		oPrint:Say((nLinIni + 0090)*nAL, (nColIni + (nColMax*0.76))*nAC, "2- Nº Guia no Prestador", oFont01) //"2- Nº Guia no Prestador"
		oPrint:Say((nLinIni + 0090)*nAL, (nColIni + (nColMax*0.83))*nAC, aDados[nX, 02], oFont03n)

		oPrint:Box((nLinIni + 0150)*nAL, (nColIni + 0010)*nAC, (nLinIni + 0220)*nAL, (nColIni + (nColMax*0.1) - 0010)*nAC)
		oPrint:Say((nLinIni + 0170)*nAL, (nColIni + 0020)*nAC, "1 - Registro ANS", oFont01) //"1 - Registro ANS"
		oPrint:Say((nLinIni + 0210)*nAL, (nColIni + 0030)*nAC, aDados[nX, 01], oFont04)
		oPrint:Box((nLinIni + 0150)*nAL, (nColIni + (nColMax*0.1))*nAC, (nLinIni + 0220)*nAL, (nColIni + (nColMax*0.32) - 0010)*nAC)
		oPrint:Say((nLinIni + 0170)*nAL, (nColIni + (nColMax*0.1) + 0010)*nAC, "3 - Número da Guia Principal", oFont01) //"3 - Número da Guia Principal"
		oPrint:Say((nLinIni + 0210)*nAL, (nColIni + (nColMax*0.1) + 0020)*nAC, aDados[nX, 02], oFont04)
		oPrint:Box((nLinIni + 0150)*nAL, (nColIni + (nColMax*0.32))*nAC, (nLinIni + 0220)*nAL, (nColIni + (nColMax*0.43) - 0010)*nAC)
		oPrint:Say((nLinIni + 0170)*nAL, (nColIni + (nColMax*0.32) + 0010)*nAC, "4 - Data da Autorização", oFont01) //"4 - Data da Autorização"
		oPrint:Say((nLinIni + 0210)*nAL, (nColIni + (nColMax*0.32) + 0020)*nAC, DtoC(aDados[nX, 04]), oFont04)
		oPrint:Box((nLinIni + 0150)*nAL, (nColIni + (nColMax*0.43))*nAC, (nLinIni + 0220)*nAL, (nColIni + (nColMax*0.65) - 0010)*nAC)
		oPrint:Say((nLinIni + 0170)*nAL, (nColIni + (nColMax*0.43) + 0010)*nAC, "5 - Senha", oFont01) //"5 - Senha"
		oPrint:Say((nLinIni + 0210)*nAL, (nColIni + (nColMax*0.43) + 0020)*nAC, aDados[nX, 05], oFont04)
		oPrint:Box((nLinIni + 0150)*nAL, (nColIni + (nColMax*0.65))*nAC, (nLinIni + 0220)*nAL, (nColIni + (nColMax*0.76) - 0010)*nAC)
		oPrint:Say((nLinIni + 0170)*nAL, (nColIni + (nColMax*0.65) + 0010)*nAC, "6 - Data de Validade da Senha", oFont01) //"6 - Data de Validade da Senha"
		oPrint:Say((nLinIni + 0210)*nAL, (nColIni + (nColMax*0.65) + 0020)*nAC, DtoC(aDados[nX, 06]), oFont04)
		oPrint:Box((nLinIni + 0150)*nAL, (nColIni + (nColMax*0.76))*nAC, (nLinIni + 0220)*nAL, (nColIni + nColMax - 0010)*nAC)
		oPrint:Say((nLinIni + 0170)*nAL, (nColIni + (nColMax*0.76) + 0010)*nAC, "7 - Número da Guia Atribuído pela Operadora", oFont01) //"7 - Número da Guia Atribuído pela Operadora"
		oPrint:Say((nLinIni + 0210)*nAL, (nColIni + (nColMax*0.76) + 0020)*nAC, aDados[nX, 07], oFont04)

		oPrint:Say((nLinIni + 0250)*nAL, (nColIni + 0010)*nAC, "Dados do Beneficiário", oFont01) //"Dados do Beneficiário"
		oPrint:Box((nLinIni + 0270)*nAL, (nColIni + 0010)*nAC, (nLinIni + 0340)*nAL, (nColIni + (nColMax*0.25) - 0010)*nAC)
		oPrint:Say((nLinIni + 0290)*nAL, (nColIni + 0020)*nAC, "8 - Número da Carteira", oFont01) //"8 - Número da Carteira"
		oPrint:Say((nLinIni + 0330)*nAL, (nColIni + 0030)*nAC, aDados[nX, 08], oFont04)
		oPrint:Box((nLinIni + 0270)*nAL, (nColIni + (nColMax*0.25))*nAC, (nLinIni + 0340)*nAL, (nColIni + (nColMax*0.48) - 0010)*nAC)
		oPrint:Say((nLinIni + 0290)*nAL, (nColIni + (nColMax*0.25) + 0010)*nAC, "9 - Plano", oFont01) //"9 - Plano"
		oPrint:Say((nLinIni + 0330)*nAL, (nColIni + (nColMax*0.25) + 0020)*nAC, aDados[nX, 09], oFont04)
		oPrint:Box((nLinIni + 0270)*nAL, (nColIni + (nColMax*0.48))*nAC, (nLinIni + 0340)*nAL, (nColIni + (nColMax*0.70) - 0010)*nAC)
		oPrint:Say((nLinIni + 0290)*nAL, (nColIni + (nColMax*0.48) + 0010)*nAC, "10- Empresa", oFont01) //"10- Empresa"
		oPrint:Say((nLinIni + 0330)*nAL, (nColIni + (nColMax*0.48) + 0020)*nAC, aDados[nX, 10], oFont04)
		oPrint:Box((nLinIni + 0270)*nAL, (nColIni + (nColMax*0.70))*nAC, (nLinIni + 0340)*nAL, (nColIni + (nColMax*0.82) - 0010)*nAC)
		oPrint:Say((nLinIni + 0290)*nAL, (nColIni + (nColMax*0.70) + 0010)*nAC, "11 - Validade da Carteira", oFont01) //"11 - Validade da Carteira"
		oPrint:Say((nLinIni + 0330)*nAL, (nColIni + (nColMax*0.70) + 0020)*nAC, DtoC(aDados[nX, 11]), oFont04)
		oPrint:Box((nLinIni + 0270)*nAL, (nColIni + (nColMax*0.82))*nAC, (nLinIni + 0340)*nAL, (nColIni + nColMax - 0010)*nAC)
		oPrint:Say((nLinIni + 0290)*nAL, (nColIni + (nColMax*0.82) + 0010)*nAC, "12 - Cartão Nacional de Saúde", oFont01) //"12 - Cartão Nacional de Saúde"
		oPrint:Say((nLinIni + 0330)*nAL, (nColIni + (nColMax*0.82) + 0010)*nAC, aDados[nX, 12], oFont04)

		oPrint:Box((nLinIni + 0350)*nAL, (nColIni + 0010)*nAC, (nLinIni + 0420)*nAL, (nColIni + (nColMax*0.42) - 0010)*nAC)
		oPrint:Say((nLinIni + 0370)*nAL, (nColIni + 0020)*nAC, "13 - Nome", oFont01) //"13 - Nome"
		oPrint:Say((nLinIni + 0410)*nAL, (nColIni + 0030)*nAC, aDados[nX, 13], oFont04)
		oPrint:Box((nLinIni + 0350)*nAL, (nColIni + (nColMax*0.42))*nAC, (nLinIni + 0420)*nAL, (nColIni + (nColMax*0.57) - 0010)*nAC)
		oPrint:Say((nLinIni + 0370)*nAL, (nColIni + (nColMax*0.42) + 0010)*nAC, "14 - Telefone", oFont01) //"14 - Telefone"
		oPrint:Say((nLinIni + 0410)*nAL, (nColIni + (nColMax*0.42) + 0020)*nAC, aDados[nX, 14], oFont04)
		oPrint:Box((nLinIni + 0350)*nAL, (nColIni + (nColMax*0.57))*nAC, (nLinIni + 0420)*nAL, (nColIni + (nColMax*0.90) - 0010)*nAC)
		oPrint:Say((nLinIni + 0370)*nAL, (nColIni + (nColMax*0.57) + 0010)*nAC, "15 - Nome do titular do plano", oFont01) //"15 - Nome do titular do plano"
		oPrint:Say((nLinIni + 0410)*nAL, (nColIni + (nColMax*0.57) + 0020)*nAC, aDados[nX, 15], oFont04)
		oPrint:Box((nLinIni + 0350)*nAL, (nColIni + (nColMax*0.90))*nAC, (nLinIni + 0420)*nAL, (nColIni + nColMax - 0010)*nAC)
		oPrint:Say((nLinIni + 0370)*nAL, (nColIni + (nColMax*0.90) + 0010)*nAC, "16 -Atendimento a RN", oFont01) //"16 -Atendimento a RN"
		oPrint:Say((nLinIni + 0410)*nAL, (nColIni + (nColMax*0.90) + 0020)*nAC, aDados[nX, 16], oFont04)

		oPrint:Say((nLinIni + 0450)*nAL, (nColIni + 0010)*nAC, "Dados do Contratado Responsável pelo Tratamento", oFont01) //"Dados do Contratado Responsável pelo Tratamento"
		oPrint:Box((nLinIni + 0470)*nAL, (nColIni + 0010)*nAC, (nLinIni + 0540)*nAL, (nColIni + (nColMax*0.67) - 0010)*nAC)
		oPrint:Say((nLinIni + 0490)*nAL, (nColIni + 0020)*nAC, "17 - Nome do Profissional Solicitante", oFont01) //"17 - Nome do Profissional Solicitante"
		oPrint:Say((nLinIni + 0530)*nAL, (nColIni + 0030)*nAC, aDados[nX, 17], oFont04)
		oPrint:Box((nLinIni + 0470)*nAL, (nColIni + (nColMax*0.67))*nAC, (nLinIni + 0540)*nAL, (nColIni + (nColMax*0.83) - 0010)*nAC)
		oPrint:Say((nLinIni + 0490)*nAL, (nColIni + (nColMax*0.67) + 0010)*nAC, "18 - Número no CRO", oFont01) //"18 - Número no CRO"
		oPrint:Say((nLinIni + 0530)*nAL, (nColIni + (nColMax*0.67) + 0010)*nAC, aDados[nX, 18], oFont04)
		oPrint:Box((nLinIni + 0470)*nAL, (nColIni + (nColMax*0.83))*nAC, (nLinIni + 0540)*nAL, (nColIni + (nColMax*0.88) - 0010)*nAC)
		oPrint:Say((nLinIni + 0490)*nAL, (nColIni + (nColMax*0.83) + 0010)*nAC, "19 - UF", oFont01) //"19 - UF"
		oPrint:Say((nLinIni + 0530)*nAL, (nColIni + (nColMax*0.83) + 0010)*nAC, aDados[nX, 19], oFont04)
		oPrint:Box((nLinIni + 0470)*nAL, (nColIni + (nColMax*0.88))*nAC, (nLinIni + 0540)*nAL, (nColIni + nColMax - 0010)*nAC)
		oPrint:Say((nLinIni + 0490)*nAL, (nColIni + (nColMax*0.88) + 0010)*nAC, "20 - Código CBO", oFont01) //"20 - Código CBO"
		oPrint:Say((nLinIni + 0530)*nAL, (nColIni + (nColMax*0.88) + 0010)*nAC, aDados[nX, 20], oFont04)

		oPrint:Box((nLinIni + 0550)*nAL, (nColIni + 0010)*nAC, (nLinIni + 0620)*nAL, (nColIni + (nColMax*0.20) - 0010)*nAC)
		oPrint:Say((nLinIni + 0570)*nAL, (nColIni + 0020)*nAC, "21 - Código na Operadora", oFont01) //"21 - Código na Operadora"
		oPrint:Say((nLinIni + 0610)*nAL, (nColIni + 0030)*nAC, aDados[nX, 21], oFont04)
		oPrint:Box((nLinIni + 0550)*nAL, (nColIni + (nColMax*0.20))*nAC, (nLinIni + 0620)*nAL, (nColIni + (nColMax*0.67) - 0010)*nAC)
		oPrint:Say((nLinIni + 0570)*nAL, (nColIni + (nColMax*0.20) + 0010)*nAC, "22 - Nome do Contratado Executante", oFont01) //"22 - Nome do Contratado Executante"
		oPrint:Say((nLinIni + 0610)*nAL, (nColIni + (nColMax*0.20) + 0010)*nAC, aDados[nX, 22], oFont04)
		oPrint:Box((nLinIni + 0550)*nAL, (nColIni + (nColMax*0.67))*nAC, (nLinIni + 0620)*nAL, (nColIni + (nColMax*0.83) - 0010)*nAC)
		oPrint:Say((nLinIni + 0570)*nAL, (nColIni + (nColMax*0.67) + 0010)*nAC, "23 - Número no CRO", oFont01) //"22 - Nome do Contratado Executante"
		oPrint:Say((nLinIni + 0610)*nAL, (nColIni + (nColMax*0.67) + 0010)*nAC, aDados[nX, 23], oFont04)
		oPrint:Box((nLinIni + 0550)*nAL, (nColIni + (nColMax*0.83))*nAC, (nLinIni + 0620)*nAL, (nColIni + (nColMax*0.88) - 0010)*nAC)
		oPrint:Say((nLinIni + 0570)*nAL, (nColIni + (nColMax*0.83) + 0010)*nAC, "24 - UF", oFont01) //"24 - UF"
		oPrint:Say((nLinIni + 0610)*nAL, (nColIni + (nColMax*0.83) + 0010)*nAC, aDados[nX, 24], oFont04)
		oPrint:Box((nLinIni + 0550)*nAL, (nColIni + (nColMax*0.88))*nAC, (nLinIni + 0620)*nAL, (nColIni + nColMax - 0010)*nAC)
		oPrint:Say((nLinIni + 0570)*nAL, (nColIni + (nColMax*0.88) + 0010)*nAC, "25 - Código CNES", oFont01) //"25 - Código CNES"
		oPrint:Say((nLinIni + 0610)*nAL, (nColIni + (nColMax*0.88) + 0010)*nAC, aDados[nX, 25], oFont04)

		oPrint:Box((nLinIni + 0630)*nAL, (nColIni + 0010)*nAC, (nLinIni + 0700)*nAL, (nColIni + (nColMax*0.67) - 0010)*nAC)
		oPrint:Say((nLinIni + 0650)*nAL, (nColIni + 0020)*nAC, "26 - Nome do Profissional Executante", oFont01) //"26 - Nome do Profissional Executante"
		oPrint:Say((nLinIni + 0690)*nAL, (nColIni + 0030)*nAC, aDados[nX, 26], oFont04)
		oPrint:Box((nLinIni + 0630)*nAL, (nColIni + (nColMax*0.67))*nAC, (nLinIni + 0700)*nAL, (nColIni + (nColMax*0.83) - 0010)*nAC)
		oPrint:Say((nLinIni + 0650)*nAL, (nColIni + (nColMax*0.67) + 0010)*nAC, "27 - Número no CRO", oFont01) //"27 - Número no CRO"
		oPrint:Say((nLinIni + 0690)*nAL, (nColIni + (nColMax*0.67) + 0010)*nAC, aDados[nX, 27], oFont04)
		oPrint:Box((nLinIni + 0630)*nAL, (nColIni + (nColMax*0.83))*nAC, (nLinIni + 0700)*nAL, (nColIni + (nColMax*0.88) - 0010)*nAC)
		oPrint:Say((nLinIni + 0650)*nAL, (nColIni + (nColMax*0.83) + 0010)*nAC, "28 - UF", oFont01) //"28 - UF"
		oPrint:Say((nLinIni + 0690)*nAL, (nColIni + (nColMax*0.83) + 0010)*nAC, aDados[nX, 28], oFont04)
		oPrint:Box((nLinIni + 0630)*nAL, (nColIni + (nColMax*0.88))*nAC, (nLinIni + 0700)*nAL, (nColIni + nColMax - 0010)*nAC)
		oPrint:Say((nLinIni + 0650)*nAL, (nColIni + (nColMax*0.88) + 0010)*nAC, "29 - Código CBO", oFont01) //"29 - Código CBO"
		oPrint:Say((nLinIni + 0690)*nAL, (nColIni + (nColMax*0.88) + 0010)*nAC, aDados[nX, 29,1], oFont04)

		oPrint:Say((nLinIni + 0730)*nAL, (nColIni + 0010)*nAC, "Plano de Tratamento / Procedimentos Solicitados / Procedimentos Executados", oFont01) //"Plano de Tratamento / Procedimentos Solicitados / Procedimentos Executados"
		oPrint:Box((nLinIni + 0750)*nAL, (nColIni + 0010)*nAC, (nLinIni + 1680)*nAL, (nColIni + nColMax - 0010)*nAC)
		oPrint:Say((nLinIni + 0770)*nAL, (nColIni + (nColMax*0.01))*nAC, "30-Tabela", oFont01) //"30-Tabela"
		oPrint:Say((nLinIni + 0770)*nAL, (nColIni + (nColMax*0.05))*nAC, "31 - Código do Procedimento", oFont01) //"31 - Código do Procedimento"
		oPrint:Say((nLinIni + 0770)*nAL, (nColIni + (nColMax*0.14))*nAC, "32 - Descrição", oFont01) //"32 - Descrição"
		oPrint:Say((nLinIni + 0770)*nAL, (nColIni + (nColMax*0.42))*nAC, "33-Dente/Região", oFont01) //"33-Dente/Região"
		oPrint:Say((nLinIni + 0770)*nAL, (nColIni + (nColMax*0.47))*nAC, "34-Face", oFont01) //"34-Face"
		oPrint:Say((nLinIni + 0770)*nAL, (nColIni + (nColMax*0.51))*nAC, "35-Qtde", oFont01) //"35-Qtde"
		oPrint:Say((nLinIni + 0770)*nAL, (nColIni + (nColMax*0.54))*nAC, "36-Qtde US", oFont01) //"36-Qtde US"
		oPrint:Say((nLinIni + 0770)*nAL, (nColIni + (nColMax*0.60))*nAC, "37-Valor R$", oFont01) //"37-Valor R$"
		oPrint:Say((nLinIni + 0770)*nAL, (nColIni + (nColMax*0.66))*nAC, "38-Franquia (R$)", oFont01) //"38-Franquia (R$)"
		oPrint:Say((nLinIni + 0770)*nAL, (nColIni + (nColMax*0.73))*nAC, "39-Aut", oFont01) //"39-Aut"
		oPrint:Say((nLinIni + 0770)*nAL, (nColIni + (nColMax*0.76))*nAC, "40-Data de Realização", oFont01) //"40-Data de Realização"
		oPrint:Say((nLinIni + 0770)*nAL, (nColIni + (nColMax*0.83))*nAC, "41-Assinatura", oFont01) //"41-Assinatura"

		nOldLinIni := nLinIni

		For nI := nP To Len(aDados)
			oPrint:Say((nLinIni + 0800)*nAL, (nColIni + 0020)*nAC, AllTrim(Str(nI)) + " - ", oFont01)
			oPrint:Say((nLinIni + 0805)*nAL, (nColIni + (nColMax*0.017))*nAC, aDados[nX, 30, nI], oFont04)
			oPrint:Say((nLinIni + 0805)*nAL, (nColIni + (nColMax*0.05))*nAC, aDados[nX, 31, nI], oFont04)
			oPrint:Say((nLinIni + 0805)*nAL, (nColIni + (nColMax*0.14))*nAC, aDados[nX, 32, nI], oFont01)
			oPrint:Say((nLinIni + 0805)*nAL, (nColIni + (nColMax*0.42))*nAC, aDados[nX, 33, nI], oFont04)
			oPrint:Say((nLinIni + 0805)*nAL, (nColIni + (nColMax*0.47))*nAC, Alltrim(Str(aDados[nX, 34, nI])), oFont04)
			oPrint:Say((nLinIni + 0805)*nAL, (nColIni + (nColMax*0.515))*nAC, IIF(Empty(aDados[nX, 35, nI]), "", Transform(aDados[nX, 35, nI], "@E 99")), oFont04,,,,1)
			oPrint:Say((nLinIni + 0805)*nAL, (nColIni + (nColMax*0.55))*nAC, IIf(Empty(aDados[nX, 36, nI]), "", Transform(aDados[nX, 36, nI], "@E 99,999,999.99")), oFont04,,,,1)
			oPrint:Say((nLinIni + 0805)*nAL, (nColIni + (nColMax*0.61))*nAC, IIf(Empty(aDados[nX, 37, nI]), "", Transform(aDados[nX, 37, nI], "@E 99,999,999.99")), oFont04,,,,1)
			oPrint:Say((nLinIni + 0805)*nAL, (nColIni + (nColMax*0.67))*nAC, IIf(Empty(aDados[nX, 38, nI]), "", Transform(aDados[nX, 38, nI], "@E 99,999,999.99")), oFont04,,,,1)
			oPrint:Say((nLinIni + 0805)*nAL, (nColIni + (nColMax*0.735))*nAC,  DtoC(aDados[nX, 39, nI]), oFont04)
			oPrint:Say((nLinIni + 0805)*nAL, (nColIni + (nColMax*0.76))*nAC, aDados[nX, 40, nI], oFont04)
			oPrint:Say((nLinIni + 0805)*nAL, (nColIni + (nColMax*0.83))*nAC, Replicate("_",35), oFont04)
			nLinIni += 45
		Next nI

		nP:=nI

		nP1:=Len(aDados[nX, 30])
/*
	 	if nP1 >nI-1
			lImpnovo:=.T.
		Endif
*/

		nLinIni := nOldLinIni

		oPrint:Box((nLinIni + 1690)*nAL, (nColIni + 0010)*nAC, (nLinIni + 1760)*nAL, (nColIni + (nColMax*0.14) - 0010)*nAC)
		oPrint:Say((nLinIni + 1710)*nAL, (nColIni + 0020)*nAC, "42 - Data de Término do Tratamento", oFont01) //"42 - Data de Término do Tratamento"
		oPrint:Say((nLinIni + 1750)*nAL, (nColIni + 0030)*nAC, aDados[nX, 42], oFont04)
		oPrint:Box((nLinIni + 1690)*nAL, (nColIni + (nColMax*0.14))*nAC, (nLinIni + 1760)*nAL, (nColIni + (nColMax*0.23) - 0010)*nAC)
		oPrint:Say((nLinIni + 1710)*nAL, (nColIni + (nColMax*0.14) + 0010)*nAC, "43 - Tipo de Atendimento", oFont01) //"43 - Tipo de Atendimento"
		oPrint:Say((nLinIni + 1750)*nAL, (nColIni + (nColMax*0.14) + 0020)*nAC, aDados[nX, 43], oFont04)
		oPrint:Box((nLinIni + 1690)*nAL, (nColIni + (nColMax*0.23))*nAC, (nLinIni + 1760)*nAL, (nColIni + (nColMax*0.33) - 0010)*nAC)
		oPrint:Say((nLinIni + 1710)*nAL, (nColIni + (nColMax*0.23) + 0010)*nAC, "44 - Tipo de Faturamento", oFont01) //"44 - Tipo de Faturamento"
		oPrint:Say((nLinIni + 1750)*nAL, (nColIni + (nColMax*0.23) + 0020)*nAC, IIf(Empty(aDados[nX, 44]), "", Transform(aDados[nX, 44], "9999999")), oFont04)
		oPrint:Box((nLinIni + 1690)*nAL, (nColIni + (nColMax*0.33))*nAC, (nLinIni + 1760)*nAL, (nColIni + (nColMax*0.47) - 0010)*nAC)
		oPrint:Say((nLinIni + 1710)*nAL, (nColIni + (nColMax*0.33) + 0010)*nAC, "45 - Total Quantidade US", oFont01) //"45 - Total Quantidade US"
		oPrint:Say((nLinIni + 1750)*nAL, (nColIni + (nColMax*0.33) + 0030)*nAC, IIf(Empty(aDados[nX, 45]), "", Transform(aDados[nX, 45], "@E 99,999,999.99")), oFont04,,,,1)
		oPrint:Box((nLinIni + 1690)*nAL, (nColIni + (nColMax*0.47))*nAC, (nLinIni + 1760)*nAL, (nColIni + (nColMax*0.62) - 0010)*nAC)
		oPrint:Say((nLinIni + 1710)*nAL, (nColIni + (nColMax*0.47) + 0010)*nAC, "46 - Valor Total (R$)", oFont01) //"46 - Valor Total (R$)"
		oPrint:Say((nLinIni + 1750)*nAL, (nColIni + (nColMax*0.47) + 0030)*nAC, IIf(Empty(aDados[nX, 46]), "", Transform(aDados[nX, 46], "@E 99,999,999.99")), oFont04,,,,1)
		oPrint:Box((nLinIni + 1690)*nAL, (nColIni + (nColMax*0.62))*nAC, (nLinIni + 1760)*nAL, (nColIni + (nColMax*0.75) - 0010)*nAC)
		oPrint:Say((nLinIni + 1710)*nAL, (nColIni + (nColMax*0.62) + 0010)*nAC, "47 – Valor Total Franquia (R$)", oFont01) //"47 – Valor Total Franquia (R$)"
		oPrint:Say((nLinIni + 1750)*nAL, (nColIni + (nColMax*0.62) + 0030)*nAC, IIf(Empty(aDados[nX, 47]), "", Transform(aDados[nX, 47], "@E 99,999,999.99")), oFont04,,,,1)

		oPrint:Say((nLinIni + 1785)*nAL, (nColIni + 0020)*nAC, "Declaro, que após ter sido devidamente esclarecido sobre os propósitos, riscos, custos e alternativas de tratamento, conforme acima apresentados, aceito e autorizo a execução do tratamento, comprometendo-me a cumprir as orientações do profissional assistente e arcar com os custos previstos em contrato. Declaro, ainda,", oFont01) //"Declaro, que após ter sido devidamente esclarecido sobre os propósitos, riscos, custos e alternativas de tratamento, conforme acima apresentados, aceito e autorizo a execução do tratamento, comprometendo-me a cumprir as orientações do profissional assistente e arcar com os custos previstos em contrato. Declaro, ainda,"
		oPrint:Say((nLinIni + 1810)*nAL, (nColIni + 0020)*nAC, "que o(s) procedimento(s) descrito(s) acima, e por mim assinado(s), foi/foram realizado(s) com meu consentimento e de forma satisfatória. Autorizo a Operadora a pagar em meu nome e por minha conta, ao profissional contratado que assina esse documento, os valores referentes ao tratamento realizado, comprometendo-me", oFont01) //"que o(s) procedimento(s) descrito(s) acima, e por mim assinado(s), foi/foram realizado(s) com meu consentimento e de forma satisfatória. Autorizo a Operadora a pagar em meu nome e por minha conta, ao profissional contratado que assina esse documento, os valores referentes ao tratamento realizado, comprometendo-me"
		oPrint:Say((nLinIni + 1835)*nAL, (nColIni + 0020)*nAC, "a arcar com os custos conforme previsto em contrato.", oFont01) //"a arcar com os custos conforme previsto em contrato."

		oPrint:Box((nLinIni + 1840)*nAL, (nColIni + 0010)*nAC, (nLinIni + 2000)*nAL, (nColIni + nColMax - 0010)*nAC)
		oPrint:Say((nLinIni + 1860)*nAL, (nColIni + 0020)*nAC, "48 – Observação / Justificativa", oFont01) //"48 – Observação / Justificativa"
/*
		nLin := 0
		For nI := 1 To MlCount(aDados[nX, 48], 150)
			cObs := MemoLine(aDados[nX, 48], 150, nI)
			oPrint:Say((nLinIni + 1890 + nLin)*nAL, (nColIni + 0020)*nAC, cObs, oFont04)
			nLin += 35
		Next nI
*/
		oPrint:Box((nLinIni + 2010)*nAL, (nColIni + 0010)*nAC, (nLinIni + 2080)*nAL, (nColIni + (nColMax*0.18) - 0010)*nAC)
		oPrint:Say((nLinIni + 2030)*nAL, (nColIni + 0020)*nAC, "49-Data da Assinatura do Cirurgião-Dentista Solicitante", oFont01) //"49–Data da Assinatura do Cirurgião-Dentista Solicitante"
		oPrint:Say((nLinIni + 2060)*nAL, (nColIni + 0030)*nAC, DtoC(aDados[nX, 48]), oFont04,,,,1)
		oPrint:Box((nLinIni + 2010)*nAL, (nColIni + (nColMax*0.18))*nAC, (nLinIni + 2080)*nAL, (nColIni + (nColMax*0.52) - 0010)*nAC)
		oPrint:Say((nLinIni + 2030)*nAL, (nColIni + (nColMax*0.18) + 0010)*nAC, "50–Assinatura do Cirurgião-Dentista Solicitante", oFont01) //"50–Assinatura do Cirurgião-Dentista Solicitante"
		oPrint:Box((nLinIni + 2010)*nAL, (nColIni + (nColMax*0.52))*nAC, (nLinIni + 2080)*nAL, (nColIni + (nColMax*0.68) - 0010)*nAC)
		oPrint:Say((nLinIni + 2030)*nAL, (nColIni + (nColMax*0.52) + 0010)*nAC, "51- Data da assinatura do Cirurgião-Dentista", oFont01) //"51- Data da assinatura do Cirurgião-Dentista"
		oPrint:Say((nLinIni + 2060)*nAL, (nColIni + (nColMax*0.52) + 0020)*nAC, DtoC(aDados[nX, 50]), oFont04,,,,1)
		oPrint:Box((nLinIni + 2010)*nAL, (nColIni + (nColMax*0.68))*nAC, (nLinIni + 2080)*nAL, (nColIni + nColMax - 0010)*nAC)
		oPrint:Say((nLinIni + 2030)*nAL, (nColIni + (nColMax*0.68) + 0010)*nAC, "52- Assinatura do Cirurgião-Dentista", oFont01) //"52- Assinatura do Cirurgião-Dentista"

		oPrint:Box((nLinIni + 2090)*nAL, (nColIni + 0010)*nAC, (nLinIni + 2160)*nAL, (nColIni + (nColMax*0.18) - 0010)*nAC)
		oPrint:Say((nLinIni + 2110)*nAL, (nColIni + 0020)*nAC, "53-Data da assinatura do Beneficiário ou Responsável", oFont01) //"53-Data da assinatura do Beneficiário ou Responsável"
		oPrint:Say((nLinIni + 2140)*nAL, (nColIni + 0030)*nAC, DtoC(aDados[nX, 52]), oFont04,,,,1)
		oPrint:Box((nLinIni + 2090)*nAL, (nColIni + (nColMax*0.18))*nAC, (nLinIni + 2160)*nAL, (nColIni + (nColMax*0.52) - 0010)*nAC)
		oPrint:Say((nLinIni + 2110)*nAL, (nColIni + (nColMax*0.18) + 0010)*nAC, "54-Assinatura do Beneficiário ou Responsável", oFont01) //"54-Assinatura do Beneficiário ou Responsável"
		oPrint:Box((nLinIni + 2090)*nAL, (nColIni + (nColMax*0.52))*nAC, (nLinIni + 2160)*nAL, (nColIni + nColMax - 0010)*nAC)
		oPrint:Say((nLinIni + 2110)*nAL, (nColIni + (nColMax*0.52) + 0010)*nAC, "55 - Data do carimbo da empresa", oFont01) //"55 - Data do carimbo da empresa"
		oPrint:Say((nLinIni + 2140)*nAL, (nColIni + (nColMax*0.52) + 0020)*nAC, DtoC(aDados[nX, 54]), oFont04,,,,1)

		oPrint:EndPage()	// Finaliza a pagina

	Next nX

Enddo

If lGerTXT .And. !lWeb
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
	//³Imprime Relatorio
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
	oPrint:Print()
Else
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
	//³Visualiza impressao grafica antes de imprimir
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
	oPrint:Preview()
EndIf

Return(cFileName)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡ao    ³ PLSTISS7B ³ Autor ³ Luciano Aparecido     ³ Data ³ 26.02.07 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡ao ³ Estrutura Relatório TISS (Demons An. Contas Med)-BOPS 095189³±±
±±³          ³ TISS 3                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ SigaPLS                                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ aDados - Array com as informações do relat´rio              ³±±
±±³          ³ nLayout - Define o formato de papél para impressao:         ³±±
±±³          ³           1 - Formato Ofício II (216x330mm)                 ³±±
±±³          ³           2 - Formato A4 (210x297mm)                        ³±±
±±³          ³  		 3 - Formato Carta (216x279mm)     			       ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
/*
User Function CABTISS7B(aDados, nLayout, cLogoGH)

Local nLinMax
Local nColMax
Local nLinIni	:=	0		// Linha Lateral (inicial) Esquerda
Local nColIni	:=  0		// Coluna Lateral (inicial) Esquerda
Local nColA4    :=  0
Local nInfGui   :=  0
Local nProcGui  :=  0
Local nLibGui   :=  0
Local nGloGui   :=  0
Local nInfGer   :=  0
Local nProcGer  :=  0
Local nLibGer   :=  0
Local nGloGer   :=  0
Local nInfFat   :=  0
Local nProcFat  :=  0
Local nLibFat   :=  0
Local nGloFat   :=  0
Local cFileLogo
Local lPrinter := .F.
Local nI, nJ
Local nX,nX1,nX2,nX3,nX4,nX5
Local oFont01
Local oFont02n
Local oFont04
Local nT := 0
Local nVolta := 0
Local nV := 1
Local lImpnovo := .T.

Default nLayout := 2
Default cLogoGH := ''
Default aDados  := { { ;
	"123456",; //1
	{"123456789102"},; //2
	Replicate("M",70),; //3
	"14.141.114/00001-35",; //4
	{CtoD("12/01/06")},; //5
	{"14.141.114/00001-35"},; //6
	{Replicate("M",70)},; //7
	{"1234567"},; //8
	{{"123456789012"}},; //9
	{{ "123456789012" }},; //10
	{{ CtoD("12/01/06") }},; //11
	{{ "1234" }},; //12
	{{ { "12345678901234567890" } }},; //13
	{{ { "12345678901234567890" } }},; //14
	{{ { "12345678901234567890" } }},; //15
	{{ { Replicate("M",70) } }},; //16
	{{ { "12345678901234567890" } }},; //17
	{{ { CtoD("12/01/06") } }},; //18
	{{ { "00:00" } }},; //19
	{{ { CtoD("12/01/06") } }},; //20
	{{ { "00:00" } }},; //21
	{{ { "1234" } }},; //22
	{{ { { CtoD("12/01/06"), CtoD("12/01/06") } } }},; //23
	{{ { { "MM", "MM" } } }},; //24
	{{ { { "1234567890", "1234567890" } } }},; //25
	{{ { { Replicate("M",150), Replicate("M",150) } } }},; //26
	{{ { { "MM", "MM" } } }},; //27
	{{ { { 123456.78, 123456.78 } } }},; //28
	{{ { { 123, 123 } } }},; //29
	{{ { { 123456.78, 123456.78 } } }},; //30
	{{ { { 123456.78, 123456.78 } } }},; //31
	{{ { { 123456.78, 123456.78 } } }},; //32
	{{ { { "1234", "1234" } } }},; //33
	} }

If nLayout  == 1 // Ofício 2
	nLinMax := 2435
	nColMax := 3705
Elseif nLayout == 2   // Papél A4
	nLinMax	:=	2310
	nColMax	:=	3190
Else //Carta
	nLinMax	:=	2435
	nColMax	:=	3175
Endif


oFont01		:= TFont():New("Arial",  6,  6, , .F., , , , .T., .F.) // Normal
if nLayout == 1 // Oficio 2
	oFont02n	:= TFont():New("Arial", 12, 12, , .T., , , , .T., .F.) // Negrito
	oFont03n	:= TFont():New("Arial", 14, 14, , .T., , , , .T., .F.) // Negrito
	oFont04		:= TFont():New("Arial", 09, 09, , .F., , , , .T., .F.) // Normal
Else  // Papél A4 ou Carta
	oFont02n	:= TFont():New("Arial", 11, 11, , .T., , , , .T., .F.) // Negrito
	oFont03n	:= TFont():New("Arial", 13, 13, , .T., , , , .T., .F.) // Negrito
	oFont04		:= TFont():New("Arial", 08, 08, , .F., , , , .T., .F.) // Normal
Endif

oPrint	:= TMSPrinter():New("DEMONSTRATIVO DE ANALISE DA CONTA") //"DEMONSTRATIVO DE ANALISE DA CONTA"

oPrint:SetLandscape()		// Modo paisagem

if nLayout ==2
	oPrint:SetPaperSize(9)// Papél A4
Elseif nLayout ==3
	oPrint:SetPaperSize(1)// Papél Carta
Else
	oPrint:SetPaperSize(14) //Papel Oficio2 216 x 330mm / 8 1/2 x 13in
Endif

	// Verifica se existe alguma impressora configurada para Impressao Grafica
lPrinter := oPrint:IsPrinterActive()
IF lPrinter
	lPrinter := IIF(GETNEWPAR("MV_IMPATIV", .F.), .F., .T.)	//	Define se irá alterar a Impressora Ativa
ENDIF
If ! lPrinter
	oPrint:Setup()
EndIf

For nX := 1 To Len(aDados)

	If ValType(aDados[nX]) == 'U' .OR. Len(aDados[nX]) == 0
		Loop
	EndIf

	For nI := 25 To 35
		If Len(aDados[nX, nI]) < nT
			For nJ := Len(aDados[nX, nI]) + 1 To 17
				If AllTrim(Str(nI)) $ "25"
					aAdd(aDados[nX, nI], StoD(""))
				ElseIf AllTrim(Str(nI)) $ "30,31,32,33,34"
					aAdd(aDados[nX, nI], 0)
				Else
					aAdd(aDados[nX, nI], "")
				EndIf
			Next nJ
		EndIf
	Next nI

	For nX1 := 1 To Len(aDados[nX, 02])

		If nX1 > 1
			oPrint:EndPage()
		Endif


		nInfGer := 0
		nProcGer := 0
		nLibGer  := 0
		nGloGer  := 0
		nInfFat := 0
		nProcFat := 0
		nLibFat  := 0
		nGloFat  := 0

		For nX2 := 1 To Len(aDados[nX, 9, nX1])

			If nX2 > 1
				oPrint:EndPage()
			Endif

			nInfGui := 0
			nProcGui := 0
			nLibGui  := 0
			nGloGui  := 0
			nVolta := 0

			For nX3 := 1 To Len(aDados[nX, 14, nX1, nX2])


				lImpnovo:= .T.
				nT := 0


				While lImpnovo

					lImpnovo:= .F.
					nVolta  += 1
					nT += 17

					If nVolta > 1
						oPrint:EndPage()
					Endif

					nLinIni := 040
					nColIni := 060
					nColA4  := 000

					oPrint:StartPage()		// Inicia uma nova pagina
						//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
						//³Box Principal                                                 ³
						//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					oPrint:Box(nLinIni + 0000, nColIni + 0000, nLinIni + nLinMax, nColIni + nColMax)

						//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
						//³Carrega e Imprime Logotipo da Empresa                         ³
						//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					fLogoEmp(@cFileLogo,, cLogoGH)

					If File(cFilelogo)
						oPrint:SayBitmap(nLinIni + 0050, nColIni + 0020, cFileLogo, 400, 090) 		// Tem que estar abaixo do RootPath
					EndIf

					If nLayout == 2 // Papél A4
						nColA4    := -0335
					Elseif nLayout == 3// Carta
						nColA4    := -0530
					Endif

					oPrint:Say(nLinIni + 0080, nColIni + 1852 + IIF(nLayout == 2 .Or. nLayout == 3,nColA4+250,0), "DEMONSTRATIVO DE ANALISE DA CONTA", oFont02n,,,, 2) //"DEMONSTRATIVO DE ANÁLISE DA CONTA MÉDICA"

					oPrint:Say(nLinIni + 0090, (nColIni + nColMax)*0.80, 		  "2- Nº", oFont01)
					oPrint:Say(nLinIni + 0080, (nColIni + nColMax)*0.80 + 0050, aDados[nX, 02, nX1], oFont03n)

					nLinIni += 60
					oPrint:Box(nLinIni + 0175, nColIni + 0010, nLinIni + 0269, (nColIni + nColMax)*0.1 - 0010)
					oPrint:Say(nLinIni + 0185, nColIni + 0020, "1 - Registro ANS", oFont01) //1-Registro ANS
					oPrint:Say(nLinIni + 0220, nColIni + 0030, aDados[nX, 01], oFont04)
					oPrint:Box(nLinIni + 0175, (nColIni + nColMax)*0.1, nLinIni + 0269, (nColIni + nColMax)*0.67 - 0010)
					oPrint:Say(nLinIni + 0185, (nColIni + nColMax)*0.1 + 0010, "3 - Nome da Operadora", oFont01) //"3-Nome da Operadora
					oPrint:Say(nLinIni + 0220, (nColIni + nColMax)*0.1 + 0020, aDados[nX, 03], oFont04)
					oPrint:Box(nLinIni + 0175, (nColIni + nColMax)*0.67, nLinIni + 0269, (nColIni + nColMax)*0.87 - 0010)
					oPrint:Say(nLinIni + 0185, (nColIni + nColMax)*0.67 + 0010, "4 - CNPJ da Operadora", oFont01) //4-CNPJ da Operadora
					oPrint:Say(nLinIni + 0220, (nColIni + nColMax)*0.67 + 0020, aDados[nX, 04], oFont04)
					oPrint:Box(nLinIni + 0175, (nColIni + nColMax)*0.87, nLinIni + 0269, nColIni + nColMax - 0010)
					oPrint:Say(nLinIni + 0185, (nColIni + nColMax)*0.87 + 0010, "5 - Data de Emissao", oFont01) //5-Data de Emissao
					oPrint:Say(nLinIni + 0220, (nColIni + nColMax)*0.87 + 0020, DtoC(aDados[nX, 05, nX1]), oFont04)

					AddTBrush(oPrint, nLinIni + 0281, nColIni + 0010, nLinIni + 0312, nColIni + nColMax)
					oPrint:Say(nLinIni + 0284, nColIni + 0020, "Dados do Prestador", oFont01) //Dados do Prestador
					oPrint:Box(nLinIni + 0314, nColIni + 0010, nLinIni + 0408, (nColIni + nColMax)*0.22 - 0010)
					oPrint:Say(nLinIni + 0324, nColIni + 0020, "6 - Coódigo na Operadora", oFont01) //6 - Código na Operadora
					oPrint:Say(nLinIni + 0359, nColIni +  0030, aDados[nX, 06, nX1], oFont04)
					oPrint:Box(nLinIni + 0314, (nColIni + nColMax)*0.22, nLinIni + 0408, (nColIni + nColMax)*0.90 - 0010)
					oPrint:Say(nLinIni + 0324, (nColIni + nColMax)*0.22 + 0010, "7 - Nome do Contratado", oFont01) //7- Nome do Contratado
					oPrint:Say(nLinIni + 0359, (nColIni + nColMax)*0.22 + 0020, aDados[nX, 07, nX1], oFont04)
					oPrint:Box(nLinIni + 0314, (nColIni + nColMax)*0.90, nLinIni + 0408, nColIni + nColMax - 0010)
					oPrint:Say(nLinIni + 0324, (nColIni + nColMax)*0.90 + 0010, "8 - Código CNES", oFont01) //8 - Código CNES
					oPrint:Say(nLinIni + 0359, (nColIni + nColMax)*0.90 + 0020, aDados[nX, 08, nX1], oFont04)

					fSomaLin(nLinMax, nColMax, @nLinIni, nColIni, 270, 40)

					fSomaLin(nLinMax, nColMax, @nLinIni, nColIni, 140, 40)
					AddTBrush(oPrint, nLinIni, nColIni + 0010, nLinIni + 0031, nColIni + nColMax)
					oPrint:Say(nLinIni + 0003, nColIni + 0020, "Dados do Lote/Protocolo", oFont01) //Dados do Lote/Protocolo
					oPrint:Box(nLinIni + 0033, nColIni + 0010, nLinIni + 0127, (nColIni + nColMax)*0.18 - 0010)
					oPrint:Say(nLinIni + 0043, nColIni + 0020, "9 - Número do Lote", oFont01) //9 - Número do Lote
					oPrint:Say(nLinIni + 0073, nColIni + 0030, aDados[nX, 9, nX1, nX2], oFont04)
					oPrint:Box(nLinIni + 0033, (nColIni + nColMax)*0.18, nLinIni + 0127, (nColIni + nColMax)*0.35 - 0010)
					oPrint:Say(nLinIni + 0043, (nColIni + nColMax)*0.18 + 0010, "10 - Número do Protocolo", oFont01) //10 - Número do Protocolo
					oPrint:Say(nLinIni + 0073, (nColIni + nColMax)*0.18 + 0020, aDados[nX, 10, nX1, nX2], oFont04)
					oPrint:Box(nLinIni + 0033, (nColIni + nColMax)*0.35, nLinIni + 0127, (nColIni + nColMax)*0.48 - 0010)
					oPrint:Say(nLinIni + 0043, (nColIni + nColMax)*0.35 + 0010, "11 - Data do Protocolo", oFont01) //11 - Data do Protocolo
					oPrint:Say(nLinIni + 0073, (nColIni + nColMax)*0.35 + 0010, DtoC(aDados[nX, 11, nX1, nX2]), oFont04)
					oPrint:Box(nLinIni + 0033, (nColIni + nColMax)*0.48, nLinIni + 0127, (nColIni + nColMax)*0.60 - 0010)
					oPrint:Say(nLinIni + 0043, (nColIni + nColMax)*0.48 + 0010, "12 - Código da Glosa do Protocolo", oFont01) //12 - Código da Glosa do Protocolo
					oPrint:Say(nLinIni + 0073, (nColIni + nColMax)*0.48 + 0010, aDados[nX, 12, nX1, nX2], oFont04)
					oPrint:Box(nLinIni + 0033, (nColIni + nColMax)*0.60, nLinIni + 0127, (nColIni + nColMax)*0.75 - 0010)
					oPrint:Say(nLinIni + 0043, (nColIni + nColMax)*0.60 + 0010, "13 - Código da Situação do Protocolo", oFont01) //13 - Código da Situação do Protocolo
					oPrint:Say(nLinIni + 0073, (nColIni + nColMax)*0.60 + 0010, aDados[nX, 13, nX1, nX2], oFont04)

					fSomaLin(nLinMax, nColMax, @nLinIni, nColIni, 140, 40)
					AddTBrush(oPrint, nLinIni, nColIni + 0010, nLinIni + 0031, nColIni + nColMax)
					oPrint:Say(nLinIni + 0003, nColIni + 0020, "Dados da Guia", oFont01) //Dados da Guia
					oPrint:Box(nLinIni + 0033, nColIni + 0010, nLinIni + 0127, (nColIni + nColMax)*0.30 - 0010)
					oPrint:Say(nLinIni + 0043, nColIni + 0020, "14 - Número da Guia no Prestador", oFont01) //14 - Número da Guia no Prestador
					oPrint:Say(nLinIni + 0073, nColIni +  0030, aDados[nX, 14, nX1, nX2, nX3], oFont04)
					oPrint:Box(nLinIni + 0033, (nColIni + nColMax)*0.30, nLinIni + 0127,(nColIni + nColMax)*0.60 - 0010)
					oPrint:Say(nLinIni + 0043, (nColIni + nColMax)*0.30 + 0010, "15 - Número da Guia Atribuído pela Operadora", oFont01) //15 - Número da Guia Atribuído pela Operadora
					oPrint:Say(nLinIni + 0073, (nColIni + nColMax)*0.30 + 0020, aDados[nX, 15,nX1, nX2, nX3], oFont04)
					oPrint:Box(nLinIni + 0033, (nColIni + nColMax)*0.60, nLinIni + 0127, (nColIni + nColMax)*0.85 - 0010)
					oPrint:Say(nLinIni + 0043, (nColIni + nColMax)*0.60 + 0010, "16 - Senha", oFont01) //16 -Senha
					oPrint:Say(nLinIni + 0073, (nColIni + nColMax)*0.60 + 0020, aDados[nX, 16, nX1,nX2, nX3], oFont04)

					fSomaLin(nLinMax, nColMax, @nLinIni, nColIni, 110, 40)
					oPrint:Box(nLinIni + 0033, nColIni + 0010, nLinIni + 0127,(nColIni + nColMax)*0.55 - 0010)
					oPrint:Say(nLinIni + 0043, nColIni + 0020, "17 - Nome do beneficiário", oFont01) //17 - Nome do beneficiário
					oPrint:Say(nLinIni + 0073, nColIni + 0030, aDados[nX, 17,nX1, nX2, nX3], oFont04)
					oPrint:Box(nLinIni + 0033, (nColIni + nColMax)*0.55, nLinIni + 0127, (nColIni + nColMax)*0.85 - 0010)
					oPrint:Say(nLinIni + 043, (nColIni + nColMax)*0.55 + 0010, "18 - Número da Carteira", oFont01) //18 - Número da Carteira
					oPrint:Say(nLinIni + 0073, (nColIni + nColMax)*0.55 + 0020, aDados[nX, 18, nX1,nX2, nX3], oFont04)

					fSomaLin(nLinMax, nColMax, @nLinIni, nColIni, 110, 40)
					oPrint:Box(nLinIni + 0033, nColIni + 0010, nLinIni + 0127,(nColIni + nColMax)*0.15 - 0010)
					oPrint:Say(nLinIni + 0043, nColIni + 0020, "19 - Data do Início do Faturamento", oFont01) //19 - Data do Início do Faturamento
					oPrint:Say(nLinIni + 0073, nColIni + 0030, IIf(Empty(aDados[nX, 19,nX1, nX2, nX3]), "", DtoC(aDados[nX, 19,nX1, nX2, nX3])), oFont04)
					oPrint:Box(nLinIni + 0033, (nColIni + nColMax)*0.15, nLinIni + 0127, (nColIni + nColMax)*0.30 - 0010)
					oPrint:Say(nLinIni + 0043, (nColIni + nColMax)*0.15 + 0010, "20 - Hora do Início do Faturamento", oFont01) //20 - Hora do Início do Faturamento
					oPrint:Say(nLinIni + 0073, (nColIni + nColMax)*0.15 + 0020, aDados[nX, 20, nX1,nX2, nX3], oFont04)
					oPrint:Box(nLinIni + 0033, (nColIni + nColMax)*0.30, nLinIni + 0127, (nColIni + nColMax)*0.45 - 0010)
					oPrint:Say(nLinIni + 0043, (nColIni + nColMax)*0.30 + 0010, "21 - Data do Fim do Faturamento", oFont01) //21 - Data do Fim do Faturamento
					oPrint:Say(nLinIni + 0073, (nColIni + nColMax)*0.30 + 0020, IIf(Empty(aDados[nX, 21, nX1,nX2, nX3]), "", DtoC(aDados[nX, 21, nX1,nX2, nX3])), oFont04)
					oPrint:Box(nLinIni + 0033, (nColIni + nColMax)*0.45, nLinIni + 0127, (nColIni + nColMax)*0.60 - 0010)
					oPrint:Say(nLinIni + 0043, (nColIni + nColMax)*0.45 + 0010, "22 - Hora do Fim do Faturamento", oFont01) //22 - Hora do Fim do Faturamento
					oPrint:Say(nLinIni + 0073, (nColIni + nColMax)*0.45 + 0020, aDados[nX, 22, nX1,nX2, nX3], oFont04)
					oPrint:Box(nLinIni + 0033, (nColIni + nColMax)*0.60, nLinIni + 0127, (nColIni + nColMax)*0.75 - 0010)
					oPrint:Say(nLinIni + 0043, (nColIni + nColMax)*0.60 + 0010, "23 - Código da Glosa da Guia", oFont01) //23 - Código da Glosa da Guia
					oPrint:Say(nLinIni + 0073, (nColIni + nColMax)*0.60 + 0020, aDados[nX, 23, nX1,nX2, nX3], oFont04)
					oPrint:Box(nLinIni + 0033, (nColIni + nColMax)*0.75, nLinIni + 0127, (nColIni + nColMax)*0.90 - 0010)
					oPrint:Say(nLinIni + 0043, (nColIni + nColMax)*0.75 + 0010, "24 - Código da Situação da Guia", oFont01) //24 - Código da Situação da Guia
					oPrint:Say(nLinIni + 0073, (nColIni + nColMax)*0.75 + 0020, aDados[nX, 24, nX1,nX2, nX3], oFont04)

					fSomaLin(nLinMax, nColMax, @nLinIni, nColIni, 110, 40)
					oPrint:Box(nLinIni + 0035, nColIni + 0010, nLinIni + 110 + (16 * 50), nColIni + nColMax -0010)
					oPrint:Say(nLinIni + 0040, nColIni + 0015, "", oFont01) //Índice
					oPrint:Say(nLinIni + 0040, (nColIni + nColMax)*0.04, "25-Data de realização", oFont01) 		//25-Data de realização
					oPrint:Say(nLinIni + 0040, (nColIni + nColMax)*0.10, "26-Tabela", oFont01) 			//26-Tabela
					oPrint:Say(nLinIni + 0040, (nColIni + nColMax)*0.14, "27-Código do procedimento/", oFont01) //27-Código do procedimento/
					oPrint:Say(nLinIni + 0060, (nColIni + nColMax)*0.14, "Item assistencial", oFont01) 			//Item assistencial
					oPrint:Say(nLinIni + 0040, (nColIni + nColMax)*0.23, "28-Descrição", oFont01) 			//28-Descrição
					oPrint:Say(nLinIni + 0040, (nColIni + nColMax)*0.55, "29-Grau de", oFont01) 				//29-Grau de
					oPrint:Say(nLinIni + 0060, (nColIni + nColMax)*0.55, "Participação", oFont01) 			//Participação
					oPrint:Say(nLinIni + 0040, (nColIni + nColMax)*0.65, "30-Valor Informado", oFont01,,,,1) //30-Valor Informado
					oPrint:Say(nLinIni + 0040, (nColIni + nColMax)*0.69, "31-Quant.", oFont01,,,,1) 			//31-Quant.
					oPrint:Say(nLinIni + 0060, (nColIni + nColMax)*0.69, "Executada", oFont01,,,,1) 			//Executada
					oPrint:Say(nLinIni + 0040, (nColIni + nColMax)*0.76, "32-Valor Processado", oFont01,,,,1) //32-Valor Processado
					oPrint:Say(nLinIni + 0040, (nColIni + nColMax)*0.83, "33-Valor Liberado", oFont01,,,,1) //33-Valor Liberado
					oPrint:Say(nLinIni + 0040, (nColIni + nColMax)*0.90, "34-Valor Glosa", oFont01,,,,1) 	//34-Valor Glosa
					oPrint:Say(nLinIni + 0040, (nColIni + nColMax)*0.91, "35-Código", oFont01) 				//35-Código
					oPrint:Say(nLinIni + 0060, (nColIni + nColMax)*0.91, "da Glosa", oFont01) 				//da Glosa

					if nVolta = 1
						nV:=1
					Endif


					fSomaLin(nLinMax, nColMax, @nLinIni, nColIni, 15, 40)
					For nX4 := nV To Len(aDados[nX, 25, nX1,nX2, nX3])
						If nX4 <= nT
							fSomaLin(nLinMax, nColMax, @nLinIni, nColIni, 45, 40)
							oPrint:Say(nLinIni + 0025, nColIni + 0015, AllTrim(Str(nX4)), oFont04)
							oPrint:Say(nLinIni + 0025, (nColIni + nColMax)*0.04, IIf(Empty(aDados[nX, 25, nX1,nX2, nX3, nX4]), "", DtoC(aDados[nX, 25, nX1,nX2, nX3, nX4])), oFont04)
							oPrint:Say(nLinIni + 0025, (nColIni + nColMax)*0.10, aDados[nX, 26, nX1,nX2, nX3, nX4], oFont04)
							oPrint:Say(nLinIni + 0025, (nColIni + nColMax)*0.14, aDados[nX, 27, nX1,nX2, nX3, nX4], oFont04)
							oPrint:Say(nLinIni + 0025, (nColIni + nColMax)*0.23, aDados[nX, 28, nX1,nX2, nX3, nX4], oFont04)
							oPrint:Say(nLinIni + 0025, (nColIni + nColMax)*0.55, aDados[nX, 29, nX1,nX2, nX3, nX4], oFont04)
							oPrint:Say(nLinIni + 0025, (nColIni + nColMax)*0.65, IIf(Empty(aDados[nX, 30, nX1, nX2, nX3, nX4]), "", Transform(aDados[nX, 30, nX1, nX2, nX3, nX4], "@E 999,999,999.99")), oFont04,,,,1)
							oPrint:Say(nLinIni + 0025, (nColIni + nColMax)*0.69, IIf(Empty(aDados[nX, 31, nX1, nX2, nX3, nX4]), "", Transform(aDados[nX, 31, nX1, nX2, nX3, nX4], "@E 9999")), oFont04,,,,1)
							oPrint:Say(nLinIni + 0025, (nColIni + nColMax)*0.76, IIf(Empty(aDados[nX, 32, nX1, nX2, nX3, nX4]), "", Transform(aDados[nX, 32, nX1, nX2, nX3, nX4], "@E 999,999,999.99")), oFont04,,,,1)
							oPrint:Say(nLinIni + 0025, (nColIni + nColMax)*0.83, IIf(Empty(aDados[nX, 33, nX1, nX2, nX3, nX4]), "", Transform(aDados[nX, 33, nX1, nX2, nX3, nX4], "@E 999,999,999.99")), oFont04,,,,1)
							oPrint:Say(nLinIni + 0025, (nColIni + nColMax)*0.83, IIf(Empty(aDados[nX, 34, nX1, nX2, nX3, nX4]), "", Transform(aDados[nX, 34, nX1, nX2, nX3, nX4], "@E 999,999,999.99")), oFont04,,,,1)
							oPrint:Say(nLinIni + 0025, (nColIni + nColMax)*0.91, aDados[nX, 35,nX1,nX2, nX3, nX4], oFont04)

							nInfGui += aDados[nX, 30, nX1, nX2, nX3, nX4]
							nProcGui += aDados[nX, 32, nX1, nX2, nX3, nX4]
							nLibGui  += aDados[nX, 33, nX1, nX2, nX3, nX4]
							nGloGui  += aDados[nX, 34, nX1, nX2, nX3, nX4]
						Endif
					Next nX4

					If nX4 <= nT
						For nX5 := nX4 To nT
							fSomaLin(nLinMax, nColMax, @nLinIni, nColIni, 45, 40)
							oPrint:Say(nLinIni + 0025, nColIni + 0015, AllTrim(Str(nX5)), oFont04)
							oPrint:Say(nLinIni + 0025, (nColIni + nColMax)*0.04, "" ,oFont04)
							oPrint:Say(nLinIni + 0025, (nColIni + nColMax)*0.10, "", oFont04)
							oPrint:Say(nLinIni + 0025, (nColIni + nColMax)*0.14, "", oFont04)
							oPrint:Say(nLinIni + 0025, (nColIni + nColMax)*0.23, "", oFont04)
							oPrint:Say(nLinIni + 0025, (nColIni + nColMax)*0.55, "", oFont04)
							oPrint:Say(nLinIni + 0025, (nColIni + nColMax)*0.65, "", oFont04,,,,1)
							oPrint:Say(nLinIni + 0025, (nColIni + nColMax)*0.69, "", oFont04,,,,1)
							oPrint:Say(nLinIni + 0025, (nColIni + nColMax)*0.76, "", oFont04,,,,1)
							oPrint:Say(nLinIni + 0025, (nColIni + nColMax)*0.83, "", oFont04,,,,1)
							oPrint:Say(nLinIni + 0025, (nColIni + nColMax)*0.83, "", oFont04,,,,1)
							oPrint:Say(nLinIni + 0025, (nColIni + nColMax)*0.91, "", oFont04)
						Next nX5
					Endif

					if Len(aDados[nX, 25, nX1,nX2, nX3]) > nT
						nVolta += 1
						nV := (nT * (nVolta-1)) + 1
						lImpnovo:= .T.
					Endif

					fSomaLin(nLinMax, nColMax, @nLinIni, nColIni, 140, 40)
					AddTBrush(oPrint, nLinIni, nColIni + 0010, nLinIni + 0031, nColIni + nColMax)
					oPrint:Say(nLinIni + 0003, nColIni + 0020, "Total Guia", oFont01) //Total Guia
					oPrint:Box(nLinIni + 0033, nColIni + 0010, nLinIni + 0137, (nColIni + nColMax)*0.15 - 0010)
					oPrint:Say(nLinIni + 0043, nColIni + 0020, "36 - Valor Informado da Guia (R$)", oFont01) //34 - Valor Informado da Guia (R$)
					oPrint:Say(nLinIni + 0073, (nColIni + nColMax)*0.15 - 0030, Transform(nInfGui, "@E 999,999,999.99"), oFont04,,,,1)
					oPrint:Box(nLinIni + 0033, (nColIni + nColMax)*0.15, nLinIni + 0137, (nColIni + nColMax)*0.30 - 0010)
					oPrint:Say(nLinIni + 0043, (nColIni + nColMax)*0.15 + 0010, "37 - Valor Processado da Guia (R$)", oFont01) //35 - Valor Processado da Guia (R$)
					oPrint:Say(nLinIni + 0073, (nColIni + nColMax)*0.30 - 0030, Transform(nProcGui, "@E 999,999,999.99"), oFont04,,,,1)
					oPrint:Box(nLinIni + 0033, (nColIni + nColMax)*0.30, nLinIni + 0137, (nColIni + nColMax)*0.45 - 0010)
					oPrint:Say(nLinIni + 0043, (nColIni + nColMax)*0.30 + 0010, "38 - Valor Liberado da Guia (R$)", oFont01) //36 - Valor Liberado da Guia (R$)
					oPrint:Say(nLinIni + 0073, (nColIni + nColMax)*0.45 - 0030, Transform(nLibGui, "@E 999,999,999.99"), oFont04,,,,1)
					oPrint:Box(nLinIni + 0033, (nColIni + nColMax)*0.45, nLinIni + 0137, (nColIni + nColMax)*0.60 - 0010)
					oPrint:Say(nLinIni + 0043, (nColIni + nColMax)*0.45 + 0010, "39 - Valor Glosa da Guia (R$)", oFont01) //37 - Valor Glosa da Guia (R$)
					oPrint:Say(nLinIni + 0073, (nColIni + nColMax)*0.60 - 0030, Transform(nGloGui, "@E 999,999,999.99"), oFont04,,,,1)

					nInfFat += nInfGui
					nProcFat += nProcGui
					nLibFat  += nLibGui
					nGloFat  += nGloGui

					fSomaLin(nLinMax, nColMax, @nLinIni, nColIni, 145, 40)
					AddTBrush(oPrint, nLinIni, nColIni + 0010, nLinIni + 0031, nColIni + nColMax)
					oPrint:Say(nLinIni + 0003, nColIni + 0020, "Total do Protocolo", oFont01) //Total do Protocolo
					oPrint:Box(nLinIni + 0033, nColIni + 0010, nLinIni + 0137, (nColIni + nColMax)*0.15 - 0010)
					oPrint:Say(nLinIni + 0043, nColIni + 0020, "40 - Valor Informado do Protocolo (R$)", oFont01) //38 - Valor Informado do Protocolo (R$)
					oPrint:Say(nLinIni + 0073, (nColIni + nColMax)*0.15 - 0030, Transform(nInfFat, "@E 999,999,999.99"), oFont04,,,,1)
					oPrint:Box(nLinIni + 0033, (nColIni + nColMax)*0.15, nLinIni + 0137, (nColIni + nColMax)*0.30 - 0010)
					oPrint:Say(nLinIni + 0043, (nColIni + nColMax)*0.15 + 0010, "41 - Valor Processado do Protocolo (R$)", oFont01) //39 - Valor Processado do Protocolo (R$)
					oPrint:Say(nLinIni + 0073, (nColIni + nColMax)*0.30 - 0030, Transform(nProcFat, "@E 999,999,999.99"), oFont04,,,,1)
					oPrint:Box(nLinIni + 0033, (nColIni + nColMax)*0.30, nLinIni + 0137, (nColIni + nColMax)*0.45 - 0010)
					oPrint:Say(nLinIni + 0043, (nColIni + nColMax)*0.30 + 0010, "42 - Valor Liberado do Protocolo (R$)", oFont01) //40 - Valor Liberado do Protocolo (R$)
					oPrint:Say(nLinIni + 0073, (nColIni + nColMax)*0.45 - 0030, Transform(nLibFat, "@E 999,999,999.99"), oFont04,,,,1)
					oPrint:Box(nLinIni + 0033, (nColIni + nColMax)*0.45, nLinIni + 0137, (nColIni + nColMax)*0.60 - 0010)
					oPrint:Say(nLinIni + 0043, (nColIni + nColMax)*0.45 + 0010, "43 - Valor Glosa do Protocolo (R$)", oFont01) //41 - Valor Glosa do Protocolo (R$)
					oPrint:Say(nLinIni + 0073, (nColIni + nColMax)*0.60 - 0030, Transform(nGloFat, "@E 999,999,999.99"), oFont04,,,,1)

					nInfGer += nInfFat
					nProcGer += nProcFat
					nLibGer  += nLibFat
					nGloGer  += nGloFat

					fSomaLin(nLinMax, nColMax, @nLinIni, nColIni, 140, 40)
					AddTBrush(oPrint, nLinIni, nColIni + 0010, nLinIni + 0031, nColIni + nColMax)
					oPrint:Say(nLinIni + 0003, nColIni + 0020, "Total Geral", oFont01) //Total Geral
					oPrint:Box(nLinIni + 0033, nColIni + 0010, nLinIni + 0137, (nColIni + nColMax)*0.15 - 0010)
					oPrint:Say(nLinIni + 0043, nColIni + 0020, "44 - Valor Informado Geral (R$)", oFont01) //42 - Valor Informado Geral (R$)
					oPrint:Say(nLinIni + 0073, (nColIni + nColMax)*0.15 - 0030, Transform(nInfGer, "@E 999,999,999.99"), oFont04,,,,1)
					oPrint:Box(nLinIni + 0033, (nColIni + nColMax)*0.15, nLinIni + 0137, (nColIni + nColMax)*0.30 - 0010)
					oPrint:Say(nLinIni + 0043, (nColIni + nColMax)*0.15 + 0010, "45 - Valor Processado Geral (R$)", oFont01) //43 - Valor Processado Geral (R$)
					oPrint:Say(nLinIni + 0073, (nColIni + nColMax)*0.30 - 0030, Transform(nProcGer, "@E 999,999,999.99"), oFont04,,,,1)
					oPrint:Box(nLinIni + 0033, (nColIni + nColMax)*0.30, nLinIni + 0137, (nColIni + nColMax)*0.45 - 0010)
					oPrint:Say(nLinIni + 0043, (nColIni + nColMax)*0.30 + 0010, "46 - Valor Liberado Geral (R$)", oFont01) //44 - Valor Liberado Geral (R$)
					oPrint:Say(nLinIni + 0073, (nColIni + nColMax)*0.45 - 0030, Transform(nLibGer, "@E 999,999,999.99"), oFont04,,,,1)
					oPrint:Box(nLinIni + 0033, (nColIni + nColMax)*0.45, nLinIni + 0137, (nColIni + nColMax)*0.60 - 0010)
					oPrint:Say(nLinIni + 0043, (nColIni + nColMax)*0.45 + 0010, "47 - Valor Glosa Geral (R$)", oFont01) //45 - Valor Glosa Geral (R$)
					oPrint:Say(nLinIni + 0073, (nColIni + nColMax)*0.60 - 0030, Transform(nGloGer, "@E 999,999,999.99"), oFont04,,,,1)
				EndDo
			Next nX3
		Next nX2
	Next nX1
	oPrint:EndPage()	// Finaliza a pagina
Next nX
oPrint:Preview() // Visualiza impressao grafica antes de imprimir

Return
*/
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡ao    ³ PLSTISSBB ³ Autor ³ Luciano Aparecido     ³ Data ³ 11.12.13 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡ao ³ Estrutura Relatório TISS (Guia Odontológica - Pagamento )   ³±±
±±³          ³ TISS 3                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ SigaPLS                                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ aDados - Array com as informações do relat´rio              ³±±
±±³          ³ nLayout - Define o formato de papél para impressao:         ³±±
±±³          ³           1 - Formato Ofício II (216x330mm)                 ³±±
±±³          ³           2 - Formato A4 (210x297mm)                        ³±±
±±³          ³  		 3 - Formato Carta (216x279mm)     			       ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
/*
User Function CABTISSC(aDados, nLayout, cLogoGH) //Guia Odontológica - Pagamento

Local nLinMax
Local nColMax
Local nLinIni	:=	0		// Linha Lateral (inicial) Esquerda
Local nColIni	:=	0		// Coluna Lateral (inicial) Esquerda
Local nOldCol	:=	0
Local nColA4    := 	0
Local cFileLogo
Local lPrinter := .F.
Local nI, nJ
Local nX, nX1, nX2, nX3, nX4
Local nCount := 0
Local oFont01
Local oFont02n
Local oFont03n
Local oFont04
Local nProcGer,nProcLot,nProcGui
Local nLibGer,nLiblot,nLibGui
Local nGloGer,nGlolot,nGloGui
Local lBox
Local cObs

Default nLayout := 2
Default cLogoGH := ''
Default	aDados  := { {;
	"123456",; //1 - Registro ANS
	{"01234567890123456789"},; //2 - Nº
	{Replicate("M",70)},; //3 - Nome da Operadora
	{"14.141.114/00001-35"},; //4 - CNPJ Operadora
	{CtoD("05/03/07")},; //5 - Data de Início do Processamento
	{CtoD("05/03/07")},; //6 - Data de Fim do Processamento
	{"1234567"},; //7 - Código na Operadora
	{Replicate("M", 70)},; //8 - Nome do Contratado
	{"14.141.114/00001-35"},; //9 - CPF / CNPJ Contratado
	{{{CtoD("05/03/07")}}},; //10 - Data do Pagamento
	{{{"0001"}}},; //11 - Banco
	{{{"1234567"}}},; //12 - Agência
	{{{"01234567890123456789"}}},; //13 - Conta
	{{{"123456789012"}}},; //14 - Número do lote
	{{{"123456789012"}}},; //15 - Número do Protocolo
	{{{"12345678901234567890"}}},; //16 - Número da guia no prestador
	{{{"12345678901234567890"}}},; //17 - Número da Carteira
	{{{Replicate("M",70)}}},; //18 -Nome do Beneficiário
	{{{{"00"}}}},; //19-Tabela
	{{{{"0123456789"}}}},; //20- Código do Procedimento
	{{{{Replicate("M", 150)}}}},; //21 - Descrição
	{{{{"1234"}}}},; //22-Dente/Região
	{{{{"12345"}}}},; //23-Face
	{{{{CtoD("01/01/01")}}}},; //24-Data de Realização
	{{{{99}}}},; //25-Qtde
	{{{{999999.99}}}},; //26-Valor Informado(R$)
	{{{{999999.99}}}},; //27-Valor Processado (R$)
	{{{{999999.99}}}},; //28-Valor Glosa/Estorno (R$)
	{{{{999999.99}}}},; //29- Valor Franquia (R$)
	{{{{999999.99}}}},; //30-Valor Liberado (R$)
	{{{{"1234"}}}},; //31-Código da Glosa
	{{{Replicate("M", 500)}}},; //32-Observação / Justificativa
	{{{99999999.99}}},; //33- Valor Total Informado Guia (R$)
	{{{99999999.99}}},; //34 - Valor Total Processado Guia (R$)
	{{{99999999.99}}},; //35 - Valor Total Glosa Guia (R$)
	{{{99999999.99}}},; //36 - Valor Total Franquia Guia (R$)
	{{{99999999.99}}},; //37 - Valor Total Liberado Guia (R$)
	{{99999999.99}},; //38 - Valor Total Informado Protocolo (R$)
	{{99999999.99}},; //39 - Valor Total Processado Protocolo (R$)
	{{99999999.99}},; //40 - Valor Total Glosa Protocolo (R$)
	{{99999999.99}},; //41 - Valor Total Franquia Protocolo (R$)
	{{99999999.99}},; //42 - Valor Total Liberado Protocolo (R$)
	{{"1"}},; //43-Indicação
	{{"01"}},; //44-Código do débito/crédito
	{{Replicate("M", 40)}},; //45-Descrição do débito/crédito
	{{999999.99}},; //46-Valor
	{{"1"}},; //47-Indicação
	{{"01"}},; //48-Código do débito/crédito
	{{Replicate("M", 40)}},; //49-Descrição do débito/crédito
	{{999999.99}},; //50-Valor
	{{"1"}},; //51-Indicação
	{{"01"}},; //52-Código do débito/crédito
	{{Replicate("M", 40)}},; //53-Descrição do débito/crédito
	{{999999.99}},; //54-Valor
	{99999999.99},; //55 - Valor Total Tributável (R$)
	{99999999.99},; //56- Valor Total Impostos Retidos (R$)
	{99999999.99},; //57 - Valor Total Não Tributável (R$)
	{99999999.99},; //58 - Valor Final a Receber (R$)
	{Replicate("M", 500)} } }

If nLayout  == 1 // Ofício 2
	nLinMax := 2435
	nColMax := 3705
Elseif nLayout == 2   // Papél A4
	nLinMax	:=	2275
	nColMax	:=	3270
Else //Carta
	nLinMax	:=	2435
	nColMax	:=	3175
Endif

oFont01		:= TFont():New("Arial",  6,  6, , .F., , , , .T., .F.) // Normal
if nLayout == 1 // Oficio 2
	oFont02n	:= TFont():New("Arial", 12, 12, , .T., , , , .T., .F.) // Negrito
	oFont03n	:= TFont():New("Arial", 14, 14, , .T., , , , .T., .F.) // Negrito
	oFont04		:= TFont():New("Arial", 09, 09, , .F., , , , .T., .F.) // Normal
Else  // Papél A4 ou Carta
	oFont02n	:= TFont():New("Arial", 11, 11, , .T., , , , .T., .F.) // Negrito
	oFont03n	:= TFont():New("Arial", 13, 13, , .T., , , , .T., .F.) // Negrito
	oFont04		:= TFont():New("Arial", 08, 08, , .F., , , , .T., .F.) // Normal
Endif

oPrint	:= TMSPrinter():New("GUIA ODONTOLÓGICA - DEMONSTRATIVO PAGAMENTO") //"GUIA ODONTOLÓGICA - DEMONSTRATIVO PAGAMENTO"

oPrint:SetLandscape()		// Modo paisagem

if nLayout ==2
	oPrint:SetPaperSize(9)// Papél A4
Elseif nLayout ==3
	oPrint:SetPaperSize(1)// Papél Carta
Else
	oPrint:SetPaperSize(14) //Papel Oficio2 216 x 330mm / 8 1/2 x 13in
Endif

	// Verifica se existe alguma impressora configurada para Impressao Grafica
lPrinter := oPrint:IsPrinterActive()
IF lPrinter
	lPrinter := IIF(GETNEWPAR("MV_IMPATIV", .F.), .F., .T.)	//	Define se irá alterar a Impressora Ativa
ENDIF
If ! lPrinter
	oPrint:Setup()
EndIf

For nX := 1 To Len(aDados)

	If ValType(aDados[nX]) == 'U' .OR. Len(aDados[nX]) == 0
		Loop
	EndIf

	For nI:= 19 To 28
		If Len(aDados[nX, nI]) < 6
			For nJ := Len(aDados[nX, nI]) + 1 To 6
				If AllTrim(Str(nI)) $ "25,27,28,29,30"
					aAdd(aDados[nX, nI], 0)
				ElseiF AllTrim(Str(nI)) $ "24"
					aAdd(aDados[nX, nI], CToD(""))
				Else
					aAdd(aDados[nX, nI],"")
				EndIf
			Next nJ
		EndIf
	Next nI

	For nI := 43 To 46
		If Len(aDados[nX, nI]) < 2
			For nJ := Len(aDados[nX, nI]) + 1 To 2
				If AllTrim(Str(nI)) == "46"
					aAdd(aDados[nX, nI], 0)
				Else
					aAdd(aDados[nX, nI], "")
				EndIf
			Next
		EndIf
	Next nI

	For nI := 47 To 54
		If Len(aDados[nX, nI]) < 3
			For nJ := Len(aDados[nX, nI]) + 1 To 3
				If AllTrim(Str(nI)) $ "50,54"
					aAdd(aDados[nX, nI], 0)
				Else
					aAdd(aDados[nX, nI], "")
				EndIf
			Next
		EndIf
	Next nI


	For nX1 := 1 To Len(aDados[nX, 02])

		If nX1 > 1
			oPrint:EndPage()
		Endif

		nLinIni  := 040
		nColIni  := 060
		nColA4   := 000

		oPrint:StartPage()		// Inicia uma nova pagina
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Box Principal                                                 ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		oPrint:Box(nLinIni + 0000, nColIni + 0000, nLinIni + nLinMax, nColIni + nColMax)

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Carrega e Imprime Logotipo da Empresa                         ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		fLogoEmp(@cFileLogo,, cLogoGH)

		If File(cFilelogo)

			oPrint:SayBitmap(nLinIni + 0050, nColIni + 0020, cFileLogo, 400, 090) 		// Tem que estar abaixo do RootPath
		EndIf

		If nLayout == 2 // Papél A4
			nColA4    := -0335
		Elseif nLayout == 3// Carta
			nColA4    := -0530
		Endif

		oPrint:Say(nLinIni + 0080, nColIni + 1852 + IIF(nLayout ==2 .Or. nLayout ==3,nColA4+260,0), "DEMONSTRATIVO DE PAGAMENTO - TRATAMENTO ODONTOLÓGICO", oFont02n,,,, 2) //DEMONSTRATIVO DE PAGAMENTO - TRATAMENTO ODONTOLÓGICO
		oPrint:Say(nLinIni + 0090, nColIni + 3000 + nColA4, "2 - Nº", oFont01) //"Nº"
		oPrint:Say(nLinIni + 0070, nColIni + 3096 + nColA4, aDados[nX, 02, nX1], oFont03n)

		fSomaLin(nLinMax, nColMax, @nLinIni, nColIni, 80, 40)
		oPrint:Box(nLinIni + 0175, nColIni + 0010, nLinIni + 0269, (nColIni + nColMax)*0.1 - 0010)
		oPrint:Say(nLinIni + 0180, nColIni + 0020, "1 - Registro ANS", oFont01) //1 - Registro ANS
		oPrint:Say(nLinIni + 0210, nColIni + 0030, aDados[nX, 01], oFont04)
		oPrint:Box(nLinIni + 0175, (nColIni + nColMax)*0.1, nLinIni + 0269, (nColIni + nColMax)*0.4 - 0010)
		oPrint:Say(nLinIni + 0180, (nColIni + nColMax)*0.1 + 0020, "3 - Nome da Operadora", oFont01) //3 - Nome da Operadora
		oPrint:Say(nLinIni + 0210, (nColIni + nColMax)*0.1 + 0030, aDados[nX, 03, nX1], oFont04)
		oPrint:Box(nLinIni + 0175, (nColIni + nColMax)*0.4, nLinIni + 0269, (nColIni + nColMax)*0.6 - 0010)
		oPrint:Say(nLinIni + 0180, (nColIni + nColMax)*0.4 + 0020, "4 - CNPJ Operadora", oFont01) //4 - CNPJ Operadora
		oPrint:Say(nLinIni + 0210, (nColIni + nColMax)*0.4 + 0030, aDados[nX, 04, nX1], oFont04)
		oPrint:Box(nLinIni + 0175, (nColIni + nColMax)*0.6, nLinIni + 0269, (nColIni + nColMax)*0.8 - 0010)
		oPrint:Say(nLinIni + 0180, (nColIni + nColMax)*0.6 + 0020, "5 - Data de Início do Processamento", oFont01) //5 – Data de Início do Processamento
		oPrint:Say(nLinIni + 0210, (nColIni + nColMax)*0.6 + 0030, DToC(aDados[nX, 05, nX1]), oFont04)
		oPrint:Box(nLinIni + 0175, (nColIni + nColMax)*0.8, nLinIni + 0269, nColIni + nColMax - 0010)
		oPrint:Say(nLinIni + 0180, (nColIni + nColMax)*0.8 + 0020, "6 - Data de Fim do Processamento", oFont04) //6 - Data de Fim do Processamento
		oPrint:Say(nLinIni + 0210, (nColIni + nColMax)*0.8 + 0030, DToC(aDados[nX, 06, nX1]), oFont04)

		fSomaLin(nLinMax, nColMax, @nLinIni, nColIni, 0, 40)
		AddTBrush(oPrint, nLinIni + 0271, nColIni + 0010, nLinIni + 0301, nColIni + nColMax)
		oPrint:Say(nLinIni + 0274, nColIni + 0020, "Dados do Prestador", oFont01) //Dados do Prestador
		oPrint:Box(nLinIni + 0304, nColIni + 0010, nLinIni + 0398, (nColIni + nColMax)*0.2 - 0010)
		oPrint:Say(nLinIni + 0309, nColIni + 0020, "7 - Código na Operadora", oFont01) //7 - Código na Operadora
		oPrint:Say(nLinIni + 0339, nColIni + 0030, aDados[nX, 07, nX1], oFont04)
		oPrint:Box(nLinIni + 0304, (nColIni + nColMax)*0.2, nLinIni + 0398, (nColIni + nColMax)*0.77 - 0010)
		oPrint:Say(nLinIni + 0309, (nColIni + nColMax)*0.2 + 0020, "8 - Nome do Contratado", oFont01) //8 - Nome do Contratado
		oPrint:Say(nLinIni + 0339, (nColIni + nColMax)*0.2 + 0030, aDados[nX, 08, nX1], oFont04)
		oPrint:Box(nLinIni + 0304, (nColIni + nColMax)*0.77, nLinIni + 0398, nColIni + nColMax - 0010)
		oPrint:Say(nLinIni + 0309, (nColIni + nColMax)*0.77 + 0020, "9 - CPF / CNPJ Contratado", oFont01) //9 - CPF / CNPJ Contratado
		oPrint:Say(nLinIni + 0339, (nColIni + nColMax)*0.77 + 0030, aDados[nX, 09, nX1], oFont04)


		nProcGer := 0
		nLibGer  := 0
		nGloGer  := 0

		fSomaLin(nLinMax, nColMax, @nLinIni, nColIni, 300, 40)

		For nX2 := 1 To Len(aDados[nX, 10,nX1])

			For nX3 := 1 To Len(aDados[nX, 10,nX1, nX2])

				nProcLot := 0
				nGloLot  := 0
				nLibLot  := 0

				fSomaLin(nLinMax, nColMax, @nLinIni, nColIni, 100, 40)
				AddTBrush(oPrint, nLinIni + 0004, nColIni + 0010, nLinIni + 0034, nColIni + nColMax)
				oPrint:Say(nLinIni + 0007, nColIni + 0020, "Dados do Pagamento", oFont01) //Dados do Pagamento

				fSomaLin(nLinMax, nColMax, @nLinIni, nColIni, 37, 40)
				oPrint:Box(nLinIni + 0000, nColIni + 0010, nLinIni + 0094, (nColIni + nColMax)*0.15 - 0010)
				oPrint:Say(nLinIni + 0005, nColIni + 0020, "10 - Data do Pagamento", oFont01) //10 - Data do Pagamento
				oPrint:Say(nLinIni + 0035, nColIni + 0030, DtoC(aDados[nX, 10, nX1, nX2, nX3]), oFont04)
				oPrint:Box(nLinIni + 0000, (nColIni + nColMax)*0.15, nLinIni + 0094, (nColIni + nColMax)*0.23 - 0010)
				oPrint:Say(nLinIni + 0005, (nColIni + nColMax)*0.15 + 0010, "11 - Banco", oFont01) //11 - Banco
				oPrint:Say(nLinIni + 0035, (nColIni + nColMax)*0.15 + 0020, aDados[nX, 11, nX1, nX2, nX3], oFont04)
				oPrint:Box(nLinIni + 0000, (nColIni + nColMax)*0.23, nLinIni + 0094, (nColIni + nColMax)*0.35 - 0010)
				oPrint:Say(nLinIni + 0005, (nColIni + nColMax)*0.23 + 0010, "12 - Agência", oFont01) //12 - Agência
				oPrint:Say(nLinIni + 0035, (nColIni + nColMax)*0.23 + 0020, aDados[nX, 12, nX1, nX2, nX3], oFont04)
				oPrint:Box(nLinIni + 0000, (nColIni + nColMax)*0.35, nLinIni + 0094, (nColIni + nColMax)*0.65 - 0010)
				oPrint:Say(nLinIni + 0005, (nColIni + nColMax)*0.35 + 0010, "13 - Conta", oFont01) //13 - Conta
				oPrint:Say(nLinIni + 0035, (nColIni + nColMax)*0.35 + 0020, aDados[nX, 13,nX1, nX2, nX3], oFont04)
				oPrint:Box(nLinIni + 0000, (nColIni + nColMax)*0.65, nLinIni + 0094, (nColIni + nColMax)*0.8 - 0010)
				oPrint:Say(nLinIni + 0005, (nColIni + nColMax)*0.65 + 0010, "14 - Número do lote", oFont01) //14 - Número do lote
				oPrint:Say(nLinIni + 0035, (nColIni + nColMax)*0.65 + 0020, aDados[nX, 14, nX1, nX2, nX3], oFont04)
				oPrint:Box(nLinIni + 0000, (nColIni + nColMax)*0.8, nLinIni + 0094, nColIni + nColMax - 0010)
				oPrint:Say(nLinIni + 0005, (nColIni + nColMax)*0.8 + 0010, "15 - Número do Protocolo", oFont01) //15 - Número do Protocolo
				oPrint:Say(nLinIni + 0035, (nColIni + nColMax)*0.8 + 0020, aDados[nX, 15,nX1, nX2, nX3], oFont04)

				fSomaLin(nLinMax, nColMax, @nLinIni, nColIni, 110, 40)
				oPrint:Box(nLinIni + 0000, nColIni + 0010, nLinIni + 0094, (nColIni + nColMax)*0.25 - 0010)
				oPrint:Say(nLinIni + 0005, nColIni + 0020, "16 - Número da guia no prestador", oFont01) //16 - Número da guia no prestador
				oPrint:Say(nLinIni + 0035, nColIni + 0030, aDados[nX, 16, nX1, nX2, nX3], oFont04)
				oPrint:Box(nLinIni + 0000, (nColIni + nColMax)*0.25, nLinIni + 0094, (nColIni + nColMax)*0.50 - 0010)
				oPrint:Say(nLinIni + 0005, (nColIni + nColMax)*0.25 + 0010, "17 - Número da Carteira", oFont01) //17 - Número da Carteira
				oPrint:Say(nLinIni + 0035, (nColIni + nColMax)*0.25 + 0020, aDados[nX, 17, nX1, nX2, nX3], oFont04)
				oPrint:Box(nLinIni + 0000, (nColIni + nColMax)*0.50, nLinIni + 0094, nColIni + nColMax - 0010)
				oPrint:Say(nLinIni + 0005, (nColIni + nColMax)*0.50 + 0010, "18 - Nome do Beneficiário", oFont01) //18 - Nome do Beneficiário
				oPrint:Say(nLinIni + 0035, (nColIni + nColMax)*0.50 + 0020, aDados[nX, 18, nX1, nX2, nX3], oFont04)

				lBox:=.F.

				fSomaLin(nLinMax, nColMax, @nLinIni, nColIni, 110, 40)
				if (nLinIni + (Len(aDados[nX, 19,nX1, nX2, nX3]) * 75)) < nLinMax
					oPrint:Box(nLinIni, nColIni + 0010, nLinIni + 60 + (Len(aDados[nX, 19,nX1, nX2, nX3]) * 75), nColIni + nColMax - 0010)
				Else
					oPrint:Line(nLinIni, nColIni + 0010, nLinIni + 0045, nColIni + 0010)
					oPrint:Line(nLinIni, nColIni + 0010, nLinIni, nColIni + nColMax)
					oPrint:Line(nLinIni, nColIni + nColMax, nLinIni + 0045, nColIni + nColMax)
					lBox:=.T.
				Endif

				oPrint:Say(nLinIni + 0002, nColIni + 0020, "19-Tabela", oFont01) //19-Tabela
				oPrint:Say(nLinIni + 0002, (nColIni + nColMax)*0.06, "20-Código do Procedimento", oFont01) //20-Código do Procedimento
				oPrint:Say(nLinIni + 0002, (nColIni + nColMax)*0.15, "21-Descrição", oFont01) //21-Descrição
				oPrint:Say(nLinIni + 0002, (nColIni + nColMax)*0.35, "22-Dente/Região", oFont01) //22-Dente/Região
				oPrint:Say(nLinIni + 0002, (nColIni + nColMax)*0.40, "23-Face", oFont01) //23-Face
				oPrint:Say(nLinIni + 0002, (nColIni + nColMax)*0.47, "24-Data de Realização", oFont01) //24-Data de Realização
				oPrint:Say(nLinIni + 0002, (nColIni + nColMax)*0.55, "25-Qtde", oFont01) //25-Qtde
				oPrint:Say(nLinIni + 0002, (nColIni + nColMax)*0.62, "26-Valor Informado(R$)", oFont01) //26-Valor Informado(R$)
				oPrint:Say(nLinIni + 0002, (nColIni + nColMax)*0.75, "27-Valor Processado(R$)", oFont01) //27-Valor Processado (R$)
				oPrint:Say(nLinIni + 0002, (nColIni + nColMax)*0.88, "28-Valor Glosa/Estorno(R$)", oFont01) //28-Valor Glosa/Estorno (R$)
				oPrint:Say(nLinIni + 0020, (nColIni + nColMax)*0.06, "29-Valor Franquia(R$)", oFont01) //29-Valor Franquia(R$)
				oPrint:Say(nLinIni + 0020, (nColIni + nColMax)*0.15, "30-Valor Liberado(R$)", oFont01) //30-Valor Liberado (R$)
				oPrint:Say(nLinIni + 0020, (nColIni + nColMax)*0.35, "31-Código da Glosa", oFont01) //31-Código da Glosa

				nProcGui := 0
				nGloGui  := 0
				nLibGui  := 0

				fSomaLin(nLinMax, nColMax, @nLinIni, nColIni, 60, 40)
				For nX4 := 1 To Len(aDados[nX, 19, nX1, nX2, nX3])

					if lBox
						oPrint:Line(nLinIni + 0010, nColIni + 0010, nLinIni + 0055, nColIni  + 0010)
						oPrint:Line(nLinIni + 0010, nColIni  + 3695 + nColA4, nLinIni + 0055, nColIni  + 3695 + nColA4)
					Endif

					oPrint:Say(nLinIni, nColIni + 0020, aDados[nX, 19, nX1, nX2, nX3, nX4], oFont04)
					oPrint:Say(nLinIni, (nColIni + nColMax)*0.06, aDados[nX, 20, nX1, nX2, nX3, nX4], oFont04)
					oPrint:Say(nLinIni, (nColIni + nColMax)*0.15, aDados[nX, 21, nX1, nX2, nX3, nX4], oFont04)
					oPrint:Say(nLinIni, (nColIni + nColMax)*0.35, aDados[nX, 22, nX1, nX2, nX3, nX4], oFont04)
					oPrint:Say(nLinIni, (nColIni + nColMax)*0.40, aDados[nX, 23, nX1, nX2, nX3, nX4], oFont04)
					oPrint:Say(nLinIni, (nColIni + nColMax)*0.47, DtoC(aDados[nX, 24, nX1, nX2, nX3, nX4]), oFont04)
					oPrint:Say(nLinIni, (nColIni + nColMax)*0.55, IIF(Empty(aDados[nX, 25, nX1, nX2, nX3, nX4]), "", Transform(aDados[nX, 25, nX1, nX2, nX3, nX4], "99")), oFont04)
					oPrint:Say(nLinIni, (nColIni + nColMax)*0.62 + 200, IIF(Empty(aDados[nX, 26, nX1, nX2, nX3, nX4]), "", Transform(aDados[nX, 26, nX1, nX2, nX3, nX4], "@E 99,999,999.99")), oFont04,,,,1)
					oPrint:Say(nLinIni, (nColIni + nColMax)*0.75 + 200, IIF(Empty(aDados[nX, 27, nX1, nX2, nX3, nX4]), "", Transform(aDados[nX, 27, nX1, nX2, nX3, nX4], "@E 99,999,999.99")), oFont04,,,,1)
					oPrint:Say(nLinIni, (nColIni + nColMax)*0.88 + 200, IIF(Empty(aDados[nX, 28, nX1, nX2, nX3, nX4]), "", Transform(aDados[nX, 28, nX1, nX2, nX3, nX4], "@E 99,999,999.99")), oFont04,,,,1)

					oPrint:Say(nLinIni + 0030, (nColIni + nColMax)*0.06 + 200, IIF(Empty(aDados[nX, 29, nX1, nX2, nX3, nX4]), "", Transform(aDados[nX, 29, nX1, nX2, nX3, nX4], "@E 99,999,999.99")), oFont04,,,,1)
					oPrint:Say(nLinIni + 0030, (nColIni + nColMax)*0.15 + 200, IIF(Empty(aDados[nX, 30, nX1, nX2, nX3, nX4]), "", Transform(aDados[nX, 30, nX1, nX2, nX3, nX4], "@E 99,999,999.99")), oFont04,,,,1)
					oPrint:Say(nLinIni + 0030, (nColIni + nColMax)*0.35, aDados[nX, 31, nX1, nX2, nX3, 1], oFont04)

					fSomaLin(nLinMax, nColMax, @nLinIni, nColIni, 75, 40)
				Next nX4

				if lBox
					oPrint:Line(nLinIni + 0010, nColIni + 0010, nLinIni + 0010, nColIni + 3695 + nColA4)
				Endif

				fSomaLin(nLinMax, nColMax, @nLinIni, nColIni, 20, 40)
				AddTBrush(oPrint, nLinIni, nColIni + 0010, nLinIni + 0220, nColIni + nColMax - 0010)
				oPrint:Box(nLinIni + 0000, nColIni + 0010, nLinIni + 0220, nColIni + nColMax - 0010)
				oPrint:Say(nLinIni + 0005, nColIni + 0020, "32-Observação / Justificativa", oFont01) //32-Observação / Justificativa

				For nI := 1 To MlCount(aDados[nX, 32,nX1,nX2,nX3], 130)
					cObs := MemoLine(aDados[nX, 32,nX1,nX2,nX3], 130, nI)
					oPrint:Say(nLinIni + (nI*45), nColIni + 0030, cObs, oFont04)
				Next nI

				fSomaLin(nLinMax, nColMax, @nLinIni, nColIni, 230, 40)
				AddTBrush(oPrint, nLinIni, nColIni + 0010, nLinIni + 0030, nColIni + nColMax)
				oPrint:Say(nLinIni + 0003, nColIni + 0020, "Total da Guia", oFont01) //Dados do Pagamento

				fSomaLin(nLinMax, nColMax, @nLinIni, nColIni, 37, 40)
				oPrint:Box(nLinIni, nColIni + 0010, nLinIni + 0094, (nColIni + nColMax)*0.15 - 0010)
				oPrint:Say(nLinIni + 0005, nColIni + 0020, "33- Valor Total Informado Guia (R$)", oFont01) //33- Valor Total Informado Guia (R$)
				oPrint:Say(nLinIni + 0035, (nColIni + nColMax)*0.15 - 0020, Transform(aDados[nX, 33, nX1, nX2, nX3], "@E 999,999,999.99"), oFont04,,,,1)
				oPrint:Box(nLinIni, (nColIni + nColMax)*0.15, nLinIni + 0094, (nColIni + nColMax)*0.30 - 0010)
				oPrint:Say(nLinIni + 0005, (nColIni + nColMax)*0.15 + 0010, "34 - Valor Total Processado Guia (R$)", oFont01) //34 - Valor Total Processado Guia (R$)
				oPrint:Say(nLinIni + 0035, (nColIni + nColMax)*0.30 - 0020, Transform(aDados[nX, 34, nX1, nX2, nX3], "@E 999,999,999.99"), oFont04,,,,1)
				oPrint:Box(nLinIni, (nColIni + nColMax)*0.30, nLinIni + 0094, (nColIni + nColMax)*0.45 - 0010)
				oPrint:Say(nLinIni + 0005, (nColIni + nColMax)*0.30 + 0010, "35 - Valor Total Glosa Guia (R$)", oFont01) //35 - Valor Total Glosa Guia (R$)
				oPrint:Say(nLinIni + 0035, (nColIni + nColMax)*0.45 - 0020, Transform(aDados[nX, 35, nX1, nX2, nX3], "@E 999,999,999.99"), oFont04,,,,1)
				oPrint:Box(nLinIni, (nColIni + nColMax)*0.45, nLinIni + 0094, (nColIni + nColMax)*0.60 - 0010)
				oPrint:Say(nLinIni + 0005, (nColIni + nColMax)*0.45 + 0010, "36 - Valor Total Franquia Guia (R$)", oFont01) //36 - Valor Total Franquia Guia (R$)
				oPrint:Say(nLinIni + 0035, (nColIni + nColMax)*0.60 - 0020, Transform(aDados[nX, 36, nX1, nX2, nX3], "@E 999,999,999.99"), oFont04,,,,1)
				oPrint:Box(nLinIni, (nColIni + nColMax)*0.60, nLinIni + 0094, (nColIni + nColMax)*0.75 - 0010)
				oPrint:Say(nLinIni + 0005, (nColIni + nColMax)*0.60 + 0010, "37 - Valor Total Liberado Guia (R$)", oFont01) //37 - Valor Total Liberado Guia (R$)
				oPrint:Say(nLinIni + 0035, (nColIni + nColMax)*0.75 - 0020, Transform(aDados[nX, 37, nX1, nX2, nX3], "@E 999,999,999.99"), oFont04,,,,1)

			Next nX3

			fSomaLin(nLinMax, nColMax, @nLinIni, nColIni, 100, 40)
			AddTBrush(oPrint, nLinIni, nColIni + 0010, nLinIni + 0030, nColIni + nColMax)
			oPrint:Say(nLinIni + 0003, nColIni + 0020, "Total do Protocolo", oFont01) //Total do Protocolo

			fSomaLin(nLinMax, nColMax, @nLinIni, nColIni, 37, 40)
			oPrint:Box(nLinIni, nColIni + 0010, nLinIni + 0094, (nColIni + nColMax)*0.15 - 0010)
			oPrint:Say(nLinIni + 0005, nColIni + 0020, "38 - Valor Total Informado Protocolo (R$)", oFont01) //38 - Valor Total Informado Protocolo (R$)
			oPrint:Say(nLinIni + 0035, (nColIni + nColMax)*0.15 - 0020, Transform(aDados[nX, 38, nX1, nX2], "@E 999,999,999.99"), oFont04,,,,1)
			oPrint:Box(nLinIni, (nColIni + nColMax)*0.15, nLinIni + 0094, (nColIni + nColMax)*0.30 - 0010)
			oPrint:Say(nLinIni + 0005, (nColIni + nColMax)*0.15 + 0010, "39 - Valor Total Processado Protocolo (R$)", oFont01) //39 - Valor Total Processado Protocolo (R$)
			oPrint:Say(nLinIni + 0035, (nColIni + nColMax)*0.30 - 0020, Transform(aDados[nX, 39, nX1, nX2], "@E 999,999,999.99"), oFont04,,,,1)
			oPrint:Box(nLinIni, (nColIni + nColMax)*0.30, nLinIni + 0094, (nColIni + nColMax)*0.45 - 0010)
			oPrint:Say(nLinIni + 0005, (nColIni + nColMax)*0.30 + 0010, "40 - Valor Total Glosa Protocolo (R$)", oFont01) //40 - Valor Total Glosa Protocolo (R$)
			oPrint:Say(nLinIni + 0035, (nColIni + nColMax)*0.45 - 0020, Transform(aDados[nX, 40, nX1, nX2], "@E 999,999,999.99"), oFont04,,,,1)
			oPrint:Box(nLinIni, (nColIni + nColMax)*0.45, nLinIni + 0094, (nColIni + nColMax)*0.60 - 0010)
			oPrint:Say(nLinIni + 0005, (nColIni + nColMax)*0.45 + 0010, "41 - Valor Total Franquia Protocolo (R$)", oFont01) //41 - Valor Total Franquia Protocolo (R$)
			oPrint:Say(nLinIni + 0035, (nColIni + nColMax)*0.60 - 0020, Transform(aDados[nX, 41, nX1, nX2], "@E 999,999,999.99"), oFont04,,,,1)
			oPrint:Box(nLinIni, (nColIni + nColMax)*0.60, nLinIni + 0094, (nColIni + nColMax)*0.75 - 0010)
			oPrint:Say(nLinIni + 0005, (nColIni + nColMax)*0.60 + 0010, "42 - Valor Total Liberado Protocolo (R$)", oFont01) //42 - Valor Total Liberado Protocolo (R$)
			oPrint:Say(nLinIni + 0035, (nColIni + nColMax)*0.75 - 0020, Transform(aDados[nX, 42, nX1, nX2], "@E 999,999,999.99"), oFont04,,,,1)

		Next nX2

		fSomaLin(nLinMax, nColMax, @nLinIni, nColIni, 110, 40)
		AddTBrush(oPrint, nLinIni, nColIni + 0010, nLinIni + 0030, nColIni + nColMax)
		oPrint:Say(nLinIni + 0003, nColIni + 0020, "Demais débitos / créditos", oFont01) //Demais débitos / créditos

		fSomaLin(nLinMax, nColMax, @nLinIni, nColIni, 37, 40)
		oPrint:Box(nLinIni, nColIni + 0010, nLinIni + 40 + (Len(aDados[nX, 43,nX1]) * 45), nColIni + nColMax - 0010)
		oPrint:Say(nLinIni, nColIni + 0020, "43-Indicação", oFont01) //43-Indicação
		oPrint:Say(nLinIni, (nColIni + nColMax)*0.10, "44-Código do débito/crédito", oFont01)  //44-Código do débito/crédito
		oPrint:Say(nLinIni, (nColIni + nColMax)*0.20, "45-Descrição do débito/crédito", oFont01)  //45-Descrição do débito/crédito
		oPrint:Say(nLinIni, (nColIni + nColMax)*0.85, "46-Valor", oFont01,,,,1)  //46-Valor

		For nI := 1 To Len(aDados[nX, 43,nX1])
			oPrint:Say(nLinIni + 0030, nColIni + 0020, aDados[nX, 43,nX1, nI], oFont04)
			oPrint:Say(nLinIni + 0030, (nColIni + nColMax)*0.10, aDados[nX, 44,nX1, nI], oFont04)
			oPrint:Say(nLinIni + 0030, (nColIni + nColMax)*0.20, aDados[nX, 45,nX1, nI], oFont04)
			oPrint:Say(nLinIni + 0030, (nColIni + nColMax)*0.85, IIf(Empty(aDados[nX, 46,nX1, nI]), "", Transform(aDados[nX, 46,nX1, nI], "@E 999,999,999.99")), oFont04,,,,1)
			fSomaLin(nLinMax, nColMax, @nLinIni, nOldCol, 45, 40)
		Next nI

		fSomaLin(nLinMax, nColMax, @nLinIni, nColIni, 45, 40)
		AddTBrush(oPrint, nLinIni, nColIni + 0010, nLinIni + 0030, (nColIni + nColMax)*0.5 - 0010)
		oPrint:Say(nLinIni + 0003, nColIni + 0020, "Demais débitos / créditos não tributáveis", oFont01) //Demais débitos / créditos não tributáveis

		AddTBrush(oPrint, nLinIni, (nColIni + nColMax)*0.5 + 0010, nLinIni + 0030, nColIni + nColMax)
		oPrint:Say(nLinIni + 0003, (nColIni + nColMax)*0.5 + 0020, "Impostos", oFont01) //Impostos

		nCount := Len(aDados[nX, 47,nX1])
		If (nCount < Len(aDados[nX, 51,nX1]))
			nCount := Len(aDados[nX, 51,nX1])
		EndIf

		fSomaLin(nLinMax, nColMax, @nLinIni, nColIni, 37, 40)
		oPrint:Box(nLinIni, nColIni + 0010, nLinIni + 40 + (nCount * 45), (nColIni + nColMax)*0.5 - 0010)
		oPrint:Say(nLinIni, nColIni + 0020, "47-Indicação", oFont01) //47-Indicação
		oPrint:Say(nLinIni, (nColIni + nColMax)*0.07, "48-Código do débito/crédito", oFont01) //48-Código do débito/crédito
		oPrint:Say(nLinIni, (nColIni + nColMax)*0.17, "49-Descrição do débito/crédito", oFont01) //49-Descrição do débito/crédito
		oPrint:Say(nLinIni, (nColIni + nColMax)*0.48, "50-Valor", oFont01,,,,1) //50-Valor

		oPrint:Box(nLinIni, (nColIni + nColMax)*0.5 + 0010, nLinIni + 40 + (nCount * 45), nColIni + nColMax - 0010)
		oPrint:Say(nLinIni, (nColIni + nColMax)*0.5 + 0020, "51-Indicação", oFont01) //51-Indicação
		oPrint:Say(nLinIni, (nColIni + nColMax)*0.57, "52-Código do débito/crédito", oFont01) //52-Código do débito/crédito
		oPrint:Say(nLinIni, (nColIni + nColMax)*0.67, "53-Descrição do débito/crédito", oFont01) //53-Descrição do débito/crédito
		oPrint:Say(nLinIni, (nColIni + nColMax)*0.98, "54-Valor", oFont01,,,,1) //54-Valor

		If (nCount > 0)
			fSomaLin(nLinMax, nColMax, @nLinIni, nColIni, 30, 40)

			For nI := 1 To nCount
				If (Len(aDados[nX, 47, nX1]) >= nI)
					oPrint:Say(nLinIni + 0003, nColIni + 0020, aDados[nX, 47, nX1, nI], oFont04) //47-Indicação
					oPrint:Say(nLinIni + 0003, (nColIni + nColMax)*0.07, aDados[nX, 48, nX1, nI], oFont04) //48-Código do débito/crédito
					oPrint:Say(nLinIni + 0003, (nColIni + nColMax)*0.17, aDados[nX, 49, nX1, nI], oFont04) //49-Descrição do débito/crédito
					oPrint:Say(nLinIni + 0003, (nColIni + nColMax)*0.48, IIf(Empty(aDados[nX, 50,nX1, nI]), "", Transform(aDados[nX, 50,nX1, nI], "@E 999,999,999.99")), oFont04,,,,1) //50-Valor
				EndIf

				If (Len(aDados[nX, 51, nX1]) >= nI)
					oPrint:Say(nLinIni + 0003, (nColIni + nColMax)*0.5 + 0020, aDados[nX, 51, nX1, nI], oFont04) //51-Indicação
					oPrint:Say(nLinIni + 0003, (nColIni + nColMax)*0.57, aDados[nX, 52, nX1, nI], oFont04) //52-Código do débito/crédito
					oPrint:Say(nLinIni + 0003, (nColIni + nColMax)*0.67, aDados[nX, 53, nX1, nI], oFont04) //53-Descrição do débito/crédito
					oPrint:Say(nLinIni + 0003, (nColIni + nColMax)*0.98, IIf(Empty(aDados[nX, 54,nX1, nI]), "", Transform(aDados[nX, 54,nX1, nI], "@E 999,999,999.99")), oFont04,,,,1) //54-Valor
				EndIf
				fSomaLin(nLinMax, nColMax, @nLinIni, nColIni, 45, 40)
			Next nI
		EndIf

		fSomaLin(nLinMax, nColMax, @nLinIni, nColIni, IIF(nCount > 0, 25,50), 40)
		AddTBrush(oPrint, nLinIni, nColIni + 0010, nLinIni + 0030, nColIni + nColMax)
		oPrint:Say(nLinIni + 0003, nColIni + 0020, "Totais", oFont01) //Total do Protocolo

		fSomaLin(nLinMax, nColMax, @nLinIni, nColIni, 37, 40)
		oPrint:Box(nLinIni, nColIni + 0010, nLinIni + 0094, (nColIni + nColMax)*0.15 - 0010)
		oPrint:Say(nLinIni + 0005, nColIni + 0020, "55 - Valor Total Tributável (R$)", oFont01) //55 - Valor Total Tributável (R$)
		oPrint:Say(nLinIni + 0035, (nColIni + nColMax)*0.15 - 0020, Transform(aDados[nX, 55, nX1], "@E 999,999,999.99"), oFont04,,,,1)
		oPrint:Box(nLinIni, (nColIni + nColMax)*0.15, nLinIni + 0094, (nColIni + nColMax)*0.30 - 0010)
		oPrint:Say(nLinIni + 0005, (nColIni + nColMax)*0.15 + 0010, "56- Valor Total Impostos Retidos (R$)", oFont01) //56- Valor Total Impostos Retidos (R$)
		oPrint:Say(nLinIni + 0035, (nColIni + nColMax)*0.30 - 0020, Transform(aDados[nX, 56, nX1], "@E 999,999,999.99"), oFont04,,,,1)
		oPrint:Box(nLinIni, (nColIni + nColMax)*0.30, nLinIni + 0094, (nColIni + nColMax)*0.45 - 0010)
		oPrint:Say(nLinIni + 0005, (nColIni + nColMax)*0.30 + 0010, "57 - Valor Total Não Tributável (R$)", oFont01) //57 - Valor Total Não Tributável (R$)
		oPrint:Say(nLinIni + 0035, (nColIni + nColMax)*0.45 - 0020, Transform(aDados[nX, 57, nX1], "@E 999,999,999.99"), oFont04,,,,1)
		oPrint:Box(nLinIni, (nColIni + nColMax)*0.45, nLinIni + 0094, (nColIni + nColMax)*0.60 - 0010)
		oPrint:Say(nLinIni + 0005, (nColIni + nColMax)*0.45 + 0010, "58 - Valor Final a Receber (R$)", oFont01) //58 - Valor Final a Receber (R$)
		oPrint:Say(nLinIni + 0035, (nColIni + nColMax)*0.60 - 0020, Transform(aDados[nX, 58, nX1], "@E 999,999,999.99"), oFont04,,,,1)

		fSomaLin(nLinMax, nColMax, @nLinIni, nColIni, 105, 40)
		AddTBrush(oPrint, nLinIni, nColIni + 0010, nLinIni + 0220, nColIni + nColMax - 0010)
		oPrint:Box(nLinIni, nColIni + 0010, nLinIni + 0220, nColIni + nColMax - 0010)
		oPrint:Say(nLinIni + 0005, nColIni + 0020, "59 - Observação", oFont01) //59 - Observação

		For nI := 1 To MlCount(aDados[nX, 59, nX1], 130)
			cObs := MemoLine(aDados[nX, 59, nX1], 130, nI)
			oPrint:Say(nLinIni + (nI*40), nColIni + 0030, cObs, oFont04)
		Next nI

	Next nX1
	oPrint:EndPage()	// Finaliza a pagina

Next nX

oPrint:Preview()	// Visualiza impressao grafica antes de imprimir

Return
*/
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡ao    ³ PLSTISS8B ³ Autor ³ Luciano Aparecido     ³ Data ³ 05.03.07 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡ao ³ Estrutura Relatório TISS (Guia Demons Pagamento)-BOPS 095189³±±
±±³          ³ TISS 3                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ SigaPLS                                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ aDados - Array com as informações do relat´rio              ³±±
±±³          ³ nLayout - Define o formato de papél para impressao:         ³±±
±±³          ³           1 - Formato Ofício II (216x330mm)                 ³±±
±±³          ³           2 - Formato A4 (210x297mm)                        ³±±
±±³          ³  		 3 - Formato Carta (216x279mm)                        ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
/*
User Function CABTISS8B(aDados, nLayout, cLogoGH)

Local nLinMax
Local nColMax
Local nLinIni	:=	0		// Linha Lateral (inicial) Esquerda
Local nColIni	:=	0		// Coluna Lateral (inicial) Esquerda
Local nColA4    :=  0
Local cFileLogo
Local lPrinter := .F.
Local nI, nJ, nX, nX1
Local n2 := 0
Local nCount := 1
Local oFont01
Local oFont02n
Local oFont04
Local lBox

Default nLayout := 2
Default cLogoGH := ''
Default aDados  := { { ;
	"123456",;
	"12345678910234567892",;
	Replicate("M",70),;
	{"14.141.114/00001-35"},;
	{CtoD("12/01/06")},;
	{"14.141.114/00001-35"},;
	{Replicate("M",70)},;
	{"1234567"},;
	{CtoD("12/01/06")},;
	{"X"},;
	{"1234"},;
	{"1234567"},;
	{"12345678910234567892"},;
	{{ CtoD("12/01/06"),CtoD("12/01/06"),CtoD("12/01/06"),CtoD("12/01/06"),CtoD("12/01/06"),CtoD("12/01/06"),CtoD("12/01/06"),CtoD("12/01/06") }},;
	{{ Replicate("9",12),Replicate("9",12),Replicate("9",12),Replicate("9",12),Replicate("9",12),Replicate("9",12),Replicate("9",12),Replicate("9",12),Replicate("B",12),Replicate("C",12),Replicate("D",12),Replicate("E",12),Replicate("E",12),Replicate("E",12),Replicate("E",12),Replicate("E",12),Replicate("E",12),Replicate("E",12),Replicate("E",12),Replicate("E",12),Replicate("E",12),Replicate("E",12),Replicate("E",12),Replicate("E",12),Replicate("E",12),Replicate("E",12),Replicate("E",12)}},;
	{{ Replicate("9",12),Replicate("9",12),Replicate("9",12),Replicate("9",12),Replicate("9",12),Replicate("9",12),Replicate("9",12),Replicate("9",12),Replicate("B",12),Replicate("C",12),Replicate("D",12),Replicate("E",12),Replicate("E",12),Replicate("E",12),Replicate("E",12),Replicate("E",12),Replicate("E",12),Replicate("E",12),Replicate("E",12),Replicate("E",12),Replicate("E",12),Replicate("E",12),Replicate("E",12),Replicate("E",12),Replicate("E",12),Replicate("E",12),Replicate("E",12)}},;
	{{ 99999999.99,99999999.99,99999999.99,99999999.99,99999999.99,99999999.99,99999999.99,99999999.99,222.00,333.00,444.00,999.99,999.99,999.99,999.99,999.99,999.99,999.99,999.99,999.99,999.99,999.99,999.99,999.99,999.99,999.99,999.99 }},;
	{{ 99999999.99,99999999.99,99999999.99,99999999.99,99999999.99,99999999.99,99999999.99,99999999.99,222.00,333.00,444.00,999.99,999.99,999.99,999.99,999.99,999.99,999.99,999.99,999.99,999.99,999.99,999.99,999.99,999.99,999.99,999.99 }},;
	{{ 99999999.99,99999999.99,99999999.99,99999999.99,99999999.99,99999999.99,99999999.99,99999999.99,222.00,333.00,444.00,999.99,999.99,999.99,999.99,999.99,999.99,999.99,999.99,999.99,999.99,999.99,999.99,999.99,999.99,999.99,999.99 }},;
	{{ 99999999.99,99999999.99,99999999.99,99999999.99,99999999.99,99999999.99,99999999.99,99999999.99,222.00,333.00,444.00,999.99,999.99,999.99,999.99,999.99,999.99,999.99,999.99,999.99,999.99,999.99,999.99,999.99,999.99,999.99,999.99 }},;
	{99999999.99},;
	{99999999.99},;
	{99999999.99},;
	{99999999.99},;
	{{ "X","X","X","X","X","X" }},;
	{{ "XX","XX","XX","XX","XX","XX" }},;
	{{ Replicate("M",40),Replicate("M",40),Replicate("M",40),Replicate("M",40),Replicate("M",40),Replicate("M",40) }},;
	{{ 999999.99, 999999.99, 999999.99, 999999.99, 999999.99, 999999.99 }},;
	{99999999.99},;
	{99999999.99},;
	{99999999.99},;
	{Replicate("M",500)} }}

If nLayout  == 1 // Ofício 2
	nLinMax := 2435
	nColMax := 3705
Elseif nLayout == 2   // Papél A4
	nLinMax	:=	2375
	nColMax	:=	3350
Else //Carta
	nLinMax	:=	2435
	nColMax	:=	3175
Endif

oFont01		:= TFont():New("Arial",  6,  6, , .T., , , , .T., .F.) // Normal
if nLayout == 1 // Oficio 2
	oFont02n	:= TFont():New("Arial", 12, 12, , .T., , , , .T., .F.) // Negrito
	oFont03n	:= TFont():New("Arial", 14, 14, , .T., , , , .T., .F.) // Negrito
	oFont04		:= TFont():New("Arial", 09, 09, , .F., , , , .T., .F.) // Normal
Else  // Papél A4 ou Carta
	oFont02n	:= TFont():New("Arial", 11, 11, , .T., , , , .T., .F.) // Negrito
	oFont03n	:= TFont():New("Arial", 13, 13, , .T., , , , .T., .F.) // Negrito
	oFont04		:= TFont():New("Arial", 08, 08, , .F., , , , .T., .F.) // Normal
Endif

oPrint	:= TMSPrinter():New("DEMONSTRATIVO DE PAGAMENTO") //"DEMONSTRATIVO DE PAGAMENTO"

oPrint:SetLandscape()		// Modo paisagem

if nLayout ==2
	oPrint:SetPaperSize(9)// Papél A4
Elseif nLayout ==3
	oPrint:SetPaperSize(1)// Papél Carta
Else
	oPrint:SetPaperSize(14) //Papel Oficio2 216 x 330mm / 8 1/2 x 13in
Endif

	// Verifica se existe alguma impressora configurada para Impressao Grafica
lPrinter := oPrint:IsPrinterActive()
IF lPrinter
	lPrinter := IIF(GETNEWPAR("MV_IMPATIV", .F.), .F., .T.)	//	Define se irá alterar a Impressora Ativa
ENDIF
If ! lPrinter
	oPrint:Setup()
EndIf

For nX := 1 To Len(aDados)

	If ValType(aDados[nX]) == 'U' .OR. Len(aDados[nX]) == 0
		Loop
	EndIf

	For nI := 14 To 32
		If Len(aDados[nX, nI]) < 1
			For nJ := Len(aDados[nX, nI]) + 1 To 32
				If AllTrim(Str(nI)) $ "14"
					aAdd(aDados[nX, nI], StoD(""))
				ElseIf AllTrim(Str(nI)) $ "17,18,19,20,21,22,23,24,28,29,30,31"
					aAdd(aDados[nX, nI], 0)
				Else
					aAdd(aDados[nX, nI], "")
				EndIf
			Next nJ
		EndIf
	Next nI

	For nX1 := 1 To Len(aDados[nX, 04])

		If nX1 > 1
			oPrint:EndPage()
		Endif

		nLinIni := 0
		nColIni := 0
		nColA4  := 0

		oPrint:StartPage()		// Inicia uma nova pagina
		n2 := 1
		nCount := 1
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Box Principal                                                 ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		oPrint:Box(nLinIni + 0000, nColIni + 0000, nLinIni + nLinMax, nColIni + nColMax)

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Carrega e Imprime Logotipo da Empresa                         ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		fLogoEmp(@cFileLogo,, cLogoGH)

		If File(cFilelogo)
			oPrint:SayBitmap(nLinIni + 0050, nColIni + 0020, cFileLogo, 400, 090) 		// Tem que estar abaixo do RootPath
		EndIf

		If nLayout == 2 // Papél A4
			nColA4    := -0335
		Elseif nLayout == 3// Carta
			nColA4    := -0530
		Endif

		oPrint:Say(nLinIni + 0080, nColIni + 1852 + IIF(nLayout == 2 .Or. nLayout == 3,nColA4+250,0), "DEMONSTRATIVO DE PAGAMENTO", oFont02n,,,, 2) //"DEMONSTRATIVO DE PAGAMENTO"

		nLinIni += 60
		oPrint:Box(nLinIni + 0175, nColIni + 0010, nLinIni + 0269, nColIni + 0315)
		oPrint:Say(nLinIni + 0180, nColIni + 0020, "1 - "+"Registro ANS", oFont01) //"Registro ANS"
		oPrint:Say(nLinIni + 0210, nColIni + 0030, aDados[nX, 01], oFont04)

		oPrint:Say(nLinIni + 0042, nColIni + 3120 + nColA4, "2- "+"Número do Demonstrativo", oFont01) //"Número do Demonstrativo"
		oPrint:Say(nLinIni + 0030, nColIni + 3200 + nColA4, aDados[nX, 02], oFont02n)

		oPrint:Box(nLinIni + 0175, nColIni + 0355, nLinIni + 0269, nColIni + 2680 + nColA4)
		oPrint:Say(nLinIni + 0180, nColIni + 0365, "3 - "+"Nome da Operadora", oFont01) //"Nome da Operadora"
		oPrint:Say(nLinIni + 0210, nColIni + 0375, aDados[nX, 03], oFont04)

		oPrint:Box(nLinIni + 0175, nColIni + 2720 + nColA4, nLinIni + 0269, nColIni + 3235 + nColA4)
		oPrint:Say(nLinIni + 0180, nColIni + 2730 + nColA4, "4 - "+"CNPJ Operadora", oFont01) //"CNPJ Operadora"
		oPrint:Say(nLinIni + 0210, nColIni + 2740 + nColA4, aDados[nX, 04, nX1], oFont04)

		oPrint:Box(nLinIni + 0175, nColIni + 3275 + nColA4, nLinIni + 0269, nColIni + 3645 + nColA4)
		oPrint:Say(nLinIni + 0180, nColIni + 3285 + nColA4, "5 - "+"Data Emissão do Demonstrativo", oFont01) //"Data Emissão do Demonstrativo"
		oPrint:Say(nLinIni + 0210, nColIni + 3295 + nColA4, DtoC(aDados[nX, 05, nX1]), oFont04)

		nLinIni += 20
		AddTBrush(oPrint, nLinIni + 0251, nColIni + 0010, nLinIni + 0282, nColIni + nColMax)
		oPrint:Say(nLinIni + 0254, nColIni + 0020, "Dados do Prestador", oFont01) //"Dados do Prestador"

		oPrint:Box(nLinIni + 0284, nColIni + 0010, nLinIni + 0378, nColIni + 0471)
		oPrint:Say(nLinIni + 0289, nColIni + 0020, "6 - Código na Operadora", oFont01) //6 - Código na Operadora
		oPrint:Say(nLinIni + 0319, nColIni + 0030, aDados[nX, 06, nX1], oFont04)

		oPrint:Box(nLinIni + 0284, nColIni + 0511, nLinIni + 0378, nColIni + 3035)
		oPrint:Say(nLinIni + 0289, nColIni + 0521, "7- Nome do Contratado", oFont01) //7- Nome do Contratado
		oPrint:Say(nLinIni + 0319, nColIni + 0531, aDados[nX, 07, nX1], oFont04)

		oPrint:Box(nLinIni + 0284, nColIni + 3075, nLinIni + 0378, nColIni + 3310)
		oPrint:Say(nLinIni + 0289, nColIni + 3085, "8 - "+"Código CNES", oFont01) //"Código CNES"
		oPrint:Say(nLinIni + 0319, nColIni + 3095, aDados[nX, 08, nX1], oFont04)

		nLinIni += 20
		AddTBrush(oPrint, nLinIni + 0360, nColIni + 0010, nLinIni + 0391, nColIni + nColMax)
		oPrint:Say(nLinIni + 0363, nColIni + 0020, "Dados do Pagamento", oFont01) //"Dados do Pagamento"

		oPrint:Box(nLinIni + 0393, nColIni + 0010, nLinIni + 0487, nColIni + 0380)
		oPrint:Say(nLinIni + 0398, nColIni + 0020, "9 - "+"Data do Pagamento", oFont01) //"Data do Pagamento"
		oPrint:Say(nLinIni + 0428, nColIni + 0030, DtoC(aDados[nX, 09, nX1]), oFont04)

		oPrint:Box(nLinIni + 0393, nColIni + 0420, nLinIni + 0487, nColIni + 1500)
		oPrint:Say(nLinIni + 0398, nColIni + 0430, "10 - "+"Forma de Pagamento", oFont01) //"Forma de Pagamento"
		oPrint:Say(nLinIni + 0428, nColIni + 0440, aDados[nX, 10, nX1], oFont04)

		oPrint:Box(nLinIni + 0393, nColIni + 1540, nLinIni + 0487, nColIni + 1900)
		oPrint:Say(nLinIni + 0398, nColIni + 1550, "11 - "+"Banco", oFont01) //"Banco"
		oPrint:Say(nLinIni + 0428, nColIni + 1560, aDados[nX, 11, nX1], oFont04)

		oPrint:Box(nLinIni + 0393, nColIni + 1940, nLinIni + 0487, nColIni + 2300)
		oPrint:Say(nLinIni + 0398, nColIni + 1950, "12 - "+"Agência", oFont01) //"Agência"
		oPrint:Say(nLinIni + 0428, nColIni + 1960, aDados[nX, 12, nX1], oFont04)

		oPrint:Box(nLinIni + 0393, nColIni + 2340, nLinIni + 0487, nColIni + 3310)
		oPrint:Say(nLinIni + 0398, nColIni + 2350, "13 - Conta", oFont01) //13-Conta
		oPrint:Say(nLinIni + 0428, nColIni + 2360, aDados[nX, 13, nX1], oFont04)

		lBox:=.F.
		AddTBrush(oPrint, nLinIni + 0489, nColIni + 0010, nLinIni + 0520, nColIni + nColMax)
		oPrint:Say(nLinIni + 0492, nColIni + 0020, "Dados do Resumo", oFont01) //"Dados do Resumo"

		if (nLinIni + 645 + Iif(Empty(aDados[nX, 14]), 1, Len(aDados[nX, 14]) * 45) )  < nLinMax

			oPrint:Box(nLinIni + 0522, nColIni + 0010, nLinIni + 645 + (Len(aDados[nX, 14, nX1]) * 45), nColIni + 3695 + nColA4)
		Else
			oPrint:Line(nLinIni + 0522, nColIni + 0010, nLinIni + 0045, nColIni + 3695 + nColA4)
			oPrint:Line(nLinIni + 0522, nColIni + 0010, nLinIni + 0090, nColIni + 0010)
			oPrint:Line(nLinIni + 0522, nColIni + 3695 + nColA4, nLinIni + 0090, nColIni + 3695 + nColA4)
			lBox:=.T.
		Endif

		oPrint:Say(nLinIni + 0527, nColIni + 0020, "14 - Data do Protocolo", oFont01) //"Número da Fatura"
		oPrint:Say(nLinIni + 0527, nColIni + 0520, "15 - Número do Protocolo", oFont01) //"Número do Lote"
		oPrint:Say(nLinIni + 0527, nColIni + 1020, "16 - Número do Lote", oFont01) //"Data de Envio do Lote"
		oPrint:Say(nLinIni + 0527, nColIni + 2173 + nColA4/2, "17 - "+"Valor Informado (R$)", oFont01,,,,1) //"Valor Informado (R$)"
		oPrint:Say(nLinIni + 0527, nColIni + 2582 + nColA4/2, "18 - "+"Valor Processado (R$)", oFont01,,,,1) //"Valor Processado (R$)"
		oPrint:Say(nLinIni + 0527, nColIni + 2991 + nColA4/2, "19 - "+"Valor Liberado (R$)", oFont01,,,,1) //"Valor Liberado (R$)"
		oPrint:Say(nLinIni + 0527, nColIni + 3350 + nColA4/2, "20 - "+"Valor da Glosa (R$)", oFont01,,,,1) //"Valor da Glosa (R$)"

		fSomaLin(nLinMax, nColMax, @nLinIni, nColIni, 600)

		For nI := 1 To Len(aDados[nX, 14, nX1])

			if lBox
				oPrint:Line(nLinIni + 0010, nColIni + 0010, nLinIni + 0115, nColIni  + 0010)
				oPrint:Line(nLinIni + 0010, nColIni  + 3695 + nColA4, nLinIni + 0115, nColIni  + 3695 + nColA4)
			Endif

			oPrint:Say(nLinIni + 0004, nColIni + 0070, IIf(Empty(aDados[nX, 14, nX1, nI]), "", DtoC(aDados[nX, 14, nX1, nI])), oFont04)
			oPrint:Say(nLinIni + 0004, nColIni + 0570, aDados[nX, 15, nX1, nI], oFont04)
			oPrint:Say(nLinIni + 0004, nColIni + 1025, aDados[nX, 16, nX1, nI], oFont04)
			oPrint:Say(nLinIni + 0004, nColIni + 2173 + nColA4/2, IIf(Empty(aDados[nX, 14, nX1, nI]), "", Transform(aDados[nX, 17, nX1, nI], "@E 999,999,999.99")), oFont04,,,,1)
			oPrint:Say(nLinIni + 0004, nColIni + 2582 + nColA4/2, IIf(Empty(aDados[nX, 14, nX1, nI]), "", Transform(aDados[nX, 18, nX1, nI], "@E 999,999,999.99")), oFont04,,,,1)
			oPrint:Say(nLinIni + 0004, nColIni + 2991 + nColA4/2, IIf(Empty(aDados[nX, 14, nX1, nI]), "", Transform(aDados[nX, 19, nX1, nI], "@E 999,999,999.99")), oFont04,,,,1)
			oPrint:Say(nLinIni + 0004, nColIni + 3340 + nColA4/2, IIf(Empty(aDados[nX, 14, nX1, nI]), "", Transform(aDados[nX, 20, nX1, nI], "@E 999,999,999.99")), oFont04,,,,1)

			fSomaLin(nLinMax, nColMax, @nLinIni, nColIni, 45)
		Next nI

			//Para arrumar o Box qdo tem muitas faturas ->Luciano
		if lBox
			oPrint:Line(nLinIni + 0010, nColIni + 0010, nLinIni + 0090, nColIni + 0010)
			oPrint:Line(nLinIni + 0010, nColIni + 3695 + nColA4, nLinIni + 0090, nColIni + 3695 + nColA4)
			oPrint:Line(nLinIni + 0020, nColIni + 0010, nLinIni + 0020, nColIni + 3695 + nColA4)
		Endif

		fSomaLin(nLinMax, nColMax, @nLinIni, nColIni, 45)

		AddTBrush(oPrint, nLinIni + 0002, nColIni + 0010, nLinIni + 0035, nColIni + nColMax)
		oPrint:Say(nLinIni + 0005, nColIni + 0020, "Valores Totais do Demonstrativo - Bruto", oFont01) //"Valores Totais do Demonstrativo - Bruto"
		oPrint:Box(nLinIni + 0042, nColIni + 0350 + nColA4, nLinIni + 0126, nColIni + 0950 + nColA4)
		oPrint:Say(nLinIni + 0046, nColIni + 0360 + nColA4, "21 - Valor Total Informado (R$) (somatório do campo 17)", oFont01) //"21 - Valor Total Informado (R$) (somatório do campo 17)
		oPrint:Say(nLinIni + 0076, nColIni + 0940 + nColA4, Transform(aDados[nX, 21, nX1], "@E 999,999,999.99"), oFont04,,,,1)
		oPrint:Box(nLinIni + 0042, nColIni + 0960 + nColA4, nLinIni + 0126, nColIni + 1560 + nColA4)
		oPrint:Say(nLinIni + 0046, nColIni + 0970 + nColA4, "22 - Valor Total Processado(R$) (somatório do campo 18)", oFont01) //22 - Valor Total Processado(R$) (somatório do campo 18)
		oPrint:Say(nLinIni + 0076, nColIni + 1550 + nColA4, Transform(aDados[nX, 22, nX1], "@E 999,999,999.99"), oFont04,,,,1)
		oPrint:Box(nLinIni + 0042, nColIni + 1570 + nColA4, nLinIni + 0126, nColIni + 2170 + nColA4)
		oPrint:Say(nLinIni + 0046, nColIni + 1580 + nColA4, "23 - Valor Total Liberado (R$) (somatório do campo 19)", oFont01) //23 - Valor Total Liberado (R$) (somatório do campo 19)
		oPrint:Say(nLinIni + 0076, nColIni + 2160 + nColA4, Transform(aDados[nX, 23, nX1], "@E 999,999,999.99"), oFont04,,,,1)
		oPrint:Box(nLinIni + 0042, nColIni + 2180 + nColA4, nLinIni + 0126, nColIni + 2780 + nColA4)
		oPrint:Say(nLinIni + 0046, nColIni + 2190 + nColA4, "24 - Valor Total Glosa (R$) (somatório do campo 20)", oFont01) //24 - Valor Total Glosa (R$) (somatório do campo 20)
		oPrint:Say(nLinIni + 0076, nColIni + 2770 + nColA4, Transform(aDados[nX, 24, nX1], "@E 999,999,999.99"), oFont04,,,,1)

		fSomaLin(nLinMax, nColMax, @nLinIni, nColIni, 100)

		oPrint:Box(nLinIni + 0070, nColIni + 0015, nLinIni + 110 + (Len(aDados[nX, 25, nX1]) * 45), nColIni + 3695 + nColA4)

		AddTBrush(oPrint, nLinIni + 0036, nColIni + 0010, nLinIni + 0067, nColIni + nColMax)
		oPrint:Say(nLinIni + 0040, nColIni + 0020, "Demais débitos / créditos", oFont01) //Demais débitos / créditos

		oPrint:Say(nLinIni + 0075, nColIni + 0020, "25 - Indicação", oFont01) //"25 - Indicação"
		oPrint:Say(nLinIni + 0075, nColIni + 0300, "26 - Código do Débito/Crédito", oFont01) //"26 - Código do Débito/Crédito"
		oPrint:Say(nLinIni + 0075, nColIni + 0800, "27 - Descrição do Débito/Crédito", oFont01) //"27 - Descrição d Débito/Crédito"
		oPrint:Say(nLinIni + 0075, nColIni + 2900, "28 - Valor (R$)", oFont01) //"28 - Valor (R$)"

		For nI := 1 To Len(aDados[nX, 25, nX1])
			oPrint:Say(nLinIni + 0110, nColIni +	 0070, aDados[nX, 25, nX1, nI], oFont04)
			oPrint:Say(nLinIni + 0110, nColIni + 0410, aDados[nX, 26, nX1, nI], oFont04)
			oPrint:Say(nLinIni + 0110, nColIni + 0800, aDados[nX, 27, nX1, nI], oFont04)
			oPrint:Say(nLinIni + 0110, nColIni + 2890, Transform(aDados[nX, 28, nX1, nI], "@E 999,999,999.99"), oFont04)

			fSomaLin(nLinMax, nColMax, @nLinIni, nColIni, 45)
			nI += 1
		Next nI


		fSomaLin(nLinMax, nColMax, @nLinIni, nColIni, 245)

		AddTBrush(oPrint, nLinIni + 0007, nColIni + 0010, nLinIni + 0037, nColIni + nColMax)
		oPrint:Say(nLinIni + 0010, nColIni + 0020, "Valores Totais do Demonstrativo - Líquido", oFont01) //"Valores Totais do Demonstrativo - Líquido"

		oPrint:Box(nLinIni + 0040, nColIni + 0350 + nColA4, nLinIni + 0126, nColIni + 0800 + nColA4)
		oPrint:Say(nLinIni + 0050, nColIni + 0360 + nColA4, "29 - Valor Total de Demais Débitos(R$)", oFont01) //"29 - Valor Total de Demais Débitos(R$)"
		oPrint:Say(nLinIni + 0080, nColIni + 0740 + nColA4, Transform(aDados[nX, 29, nX1], "@E 999,999,999.99"), oFont04,,,,1)

		oPrint:Box(nLinIni + 0040, nColIni + 0810 + nColA4, nLinIni + 0126, nColIni + 1260 + nColA4)
		oPrint:Say(nLinIni + 0050, nColIni + 0820 + nColA4, "30 - Valor Total de Demais Créditos(R$)", oFont01) //"30 - Valor Total de Demais Créditos(R$)"
		oPrint:Say(nLinIni + 0080, nColIni + 1200 + nColA4, Transform(aDados[nX, 30, nX1], "@E 999,999,999.99"), oFont04,,,,1)

		oPrint:Box(nLinIni + 0040, nColIni + 1270 + nColA4, nLinIni + 0126, nColIni + 1720 + nColA4)
		oPrint:Say(nLinIni + 0050, nColIni + 1280 + nColA4, "31 - Valor Final a Receber(R$)(23-29+30)", oFont01) //"31 - Valor Final a Receber(R$)(23-29+30)"
		oPrint:Say(nLinIni + 0080, nColIni + 1670 + nColA4, Transform(aDados[nX, 31, nX1], "@E 999,999,999.99"), oFont04,,,,1)

		AddTBrush(oPrint, nLinIni + 0150, nColIni + 0350 + nColA4, nLinIni + 0550, nColIni + nColMax)
		oPrint:Box(nLinIni + 0150, nColIni + 0350 + nColA4, nLinIni + 0550, nColIni + nColMax)
		oPrint:Say(nLinIni + 0170, nColIni + 0360 + nColA4, "32 - Observação / Justificativa", oFont01) //"32 - Observação / Justificativa"

		For nI := 1 To Len(aDados[nX, 32])
			MlCount(aDados[nX, 32, nX1], 140)
			cObs := MemoLine(aDados[nX, 32, nX1], 140, nI)
			oPrint:Say(nLinIni + 0220, nColIni + 0400 + nColA4, cObs, oFont04)
			nLinIni += 35
		Next nI

	Next nX1

	oPrint:EndPage()	// Finaliza a pagina


Next nX

oPrint:Preview()	// Visualiza impressao grafica antes de imprimir

Return
*/
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡ao    ³ PLSTISSC  ³ Autor ³ Bruno Iserhardt       ³ Data ³ 18.06.13 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡ao ³ Estrutura Relatório TISS 3.00.01 (Guia de Serv/SADT)        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ SigaPLS                                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ aDados - Array com as informações do relat´rio              ³±±
±±³          ³ lGerTXT - Define se imprime direto sem passar pela tela	   ³±±
±±³          ³			 de configuracao/preview do relatorio 		       ³±±
±±³          ³ nLayout - Define o formato de papél para impressao:         ³±±
±±³          ³           1 - Formato Ofício II (216x330mm)                 ³±±
±±³          ³           2 - Formato A4 (210x297mm)                        ³±±
±±³          ³  		 3 - Formato Carta (216x279mm)     			       ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
/*
User Function CABTISSC(aDados, lGerTXT, nLayout, cLogoGH, lWeb, cPathRelW)

Local nLinMax
Local nColMax
Local nLinIni	:= 0 // Linha Lateral (inicial) Esquerda
Local nColIni	:= 0 // Coluna Lateral (inicial) Esquerda
Local nLimFim	:= 0
Local nColA4    := 0
Local nColSoma  := 0
Local nColSoma2 := 0
Local nLinA4	:= 0
Local cFileLogo
Local nLin
Local nOldLinIni
Local nI, nJ, nX//, nN
Local nV, nV1, nV2	//, nV3, nV4
Local cObs
Local oFont01
Local oFont02n
Local oFont03n
Local oFont04
Local oFont05
Local lImpnovo  :=.T.
Local nVolta    := 0
Local nP        := 0
Local nP1       := 0
Local nP2       := 0
Local nT        := 0
Local nT1       := 0
Local nT2       := 0
Local nT3       := 0
Local nT4       := 0
Local nProx     := 0
LOCAL cFileName	:= ""
LOCAL cRel      := "guisadt"
LOCAL cPathSrvJ := GETMV("MV_RELT")
LOCAL nAL		:= 0.25
LOCAL nAC		:= 0.24
Local lImpPrc   := .T.
Local cCodTab 	:= ""
Local cCodPro 	:= ""
Local cDescri	:= ""
Local lImpNAut	:= IIf(GetNewPar("MV_PLNAUT",0) == 0, .F., .T.) // 0 = Nao imprime procedimento nao autorizado 1 = Sim imprime
Local nLinSeq		:= 0
Local nSeq			:= 0
DEFAULT lGerTXT 	:= .F.
DEFAULT nLayout 	:= 2
DEFAULT cLogoGH 	:= ""
DEFAULT lWeb		:= .F.
DEFAULT cPathRelW 	:= ""
DEFAULT aDados 	:= { {;
	"123456",; //1 - Registro ANS
	"12345678901234567890",; //2- Nº Guia no Prestador
	"12345678901234567890",; //3- Número da guia principal
	CtoD("01/01/07"),; //4 - Data da Autorização
	"12345678901234567890",; //5-Senha
	CtoD("01/01/07"),; //6 - Data de Validade da Senha
	"12345678901234567890",; //7 - Número da Guia Atribuído pela Operadora
	"12345678901234567890",; //8 - Número da Carteira
	CtoD("12/12/07"),; //9 - Validade da Carteira
	Replicate("N",70),; //10 - Nome
	"123456789012345",; //11 - Cartão Nacional de Saúde
	"N",; //12 -Atendimento a RN
	"12345678901234",; //13 - Código na Operadora
	Replicate("N",70),; //14 - Nome do Contratado
	Replicate("N",70),; //15 - Nome do Profissional Solicitante
	"00",; //16 - Conselho Profissional
	"123456789012345",; //17 - Número no Conselho
	"UF",; //18 - UF
	"123456",; //19 - Código CBO
	"",; //20 - Assinatura do Profissional Solicitante
	"A",; //21 - Caráter do Atendimento
	CtoD("12/12/07"),; //22 - Data da Solicitação
	Replicate("A",500),; //23 - Indicação Clínica
	{ "10", "20", "30", "40", "50", "60" } ,; //24-Tabela
	{ "1234567890", "2345678901", "3456789012", "4567890123", "5678901234", "1111111111" },; //25- Código do Procedimento
	{ Replicate("M",60),Replicate("B",60),Replicate("C",60),Replicate("D",60),Replicate("E",60),Replicate("E",60) },; //26 - Descrição
	{ 111,111,11,1,1,2 },; //27-Qtde. Solic.
	{ 999,999,99,9,9,1 },; //28-Qtde. Aut.
	"123456789012345",; //29-Código na operadora
	Replicate("M",70),; //30-Nome do contratado
	"9999999",; //31-Código CNES
	"TA",; //32-Tipo de Atendimento
	"A",; //33 - Indicação de Acidente
	"C",; //34 - Tipo de consulta
	"AA",; //35 - Motivo de Encerramento do Atendimento
	{ CtoD("12/12/07"),CtoD("12/12/07"),CtoD("12/12/07"),CtoD("12/12/07"),CtoD("12/12/07") },; //36 - Data
	{ "00:00","01:00","02:00","03:00","04:00" },; //37 - Hora Inicial
	{ "02:00","04:00","06:00","99:00","00:99" },; //38 - Hora Final
	{ "TT","TT","TT","TT","TT" },; //39 - Tabela
	{ "1234567890","1234567890","1234567890","1234567890","1234567890" },;//40-Código do Procedimento
	{ Replicate("M",60),Replicate("B",60),Replicate("C",60),Replicate("D",60),Replicate("E",60) },;//41-Descrição
	{ 111, 222, 333, 444, 555},; //42 - Qtde.
	{ "0", "1", "2", "3", "4"},; //43-Via
	{ "0", "1", "2", "3", "4"},; //44-Tec.
	{ 0.99, 1.65 , 2.58 , 3.11 , 4.22},;//45- Fator Red./Acresc.
	{ 111111.99, 222222.65 , 333333.58 , 444444.11 , 555555.22},;//46-Valor Unitário (R$)
	{ 111111.99, 999999.65 , 888888.58 , 777777.11 , 666666.22},;//47-Valor Total (R$)
	{ "44", "33", "22", "11"},; //48-Seq.Ref
	{ "00", "11", "22", "33"},; //49-Grau Part.
	{ Replicate("M",14), Replicate("D",14), Replicate("C",14), Replicate("A",14)},; //50-Código na Operadora/CPF
	{ Replicate("B",70), Replicate("E",70), Replicate("X",70), Replicate("Z",70)},; //51-Nome do Profissional
	{ "12", "34", "56", "78"},; //52-Conselho Profissional
	{ Replicate("0",15), Replicate("1",15), Replicate("2",15), Replicate("3",15)},; //53-Número no Conselho
	{ "RS", "RJ", "SP", "RS"},; //54-UF
	{ "000000", "111111", "222222", "333333", "aaaaaa"},; //55-Código CBO
	{ CtoD("01/01/07"),CtoD("02/01/07"),CtoD("03/01/07"),CtoD("04/01/07"),CtoD("05/01/07"),CtoD("06/01/07"),CtoD("07/01/07"),CtoD("08/01/07"),CtoD("09/01/07"),CtoD("10/01/07")},; //56-Data de Realização de Procedimentos em Série
	"",;//57-Assinatura do Beneficiário ou Responsável
	Replicate("0",500),; //58-Observação / Justificativa
	12345678.90,; //59 - Total de Procedimentos (R$)
	12345678.90,; //60 - Total de Taxas e Aluguéis (R$)
	11111111.55,; //61 - Total de Materiais (R$)
	58745458.11,; //62- Total de OPME (R$)
	77777777.00,; //63 - Total de Medicamentos (R$)
	22222222.99,; //64 - Total de Gases Medicinais (R$)
	99999999.99 } } //65 - Total Geral (R$)

oFont01	:= TFont():New("Arial",  5,  5, , .F., , , , .T., .F.) // Normal

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
//³ Nao permite acionar a impressao quando for na web.
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
If lWeb
	cPathSrvJ := cPathRelW
	cFileName := cRel+lower(CriaTrab(NIL,.F.))+".pdf"
Else
	cFileName := cRel+CriaTrab(NIL,.F.)
EndIf

//						New ( < cFilePrintert >, [ nDevice], [ lAdjustToLegacy], [ cPathInServer], [ lDisabeSetup ], [ lTReport], [ @oPrintSetup], [ cPrinter], [ lServer], [ lPDFAsPNG], [ lRaw], [ lViewPDF] )
oPrint := FWMSPrinter():New ( cFileName			,			,	.F.				,cPathSrvJ	 	,	.T.				,			 ,				,			  ,			  ,	.F.			, 		, 				)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
//³Tratamento para impressao via job
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
//oPrint:lInJob  := lWeb
oPrint:lServer := lWeb
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
//³ Caminho do arquivo
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
oPrint:cPathPDF := cPathSrvJ

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
//³Modo paisagem
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
oPrint:SetLandscape()

if nLayout ==2
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
	//³Papél A4
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
	oPrint:SetPaperSize(9)
Elseif nLayout ==3
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
	//³Papél Carta
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
	oPrint:SetPaperSize(1)
Else
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
	//³Papel Oficio2 216 x 330mm / 8 1/2 x 13in
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
	oPrint:SetPaperSize(14)
Endif
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
//³Device
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
If lWeb
	oPrint:setDevice(IMP_PDF)
	oPrint:lPDFAsPNG := .T.
EndIf
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
//³Verifica se existe alguma impressora configurada para Impressao Grafica
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
If  !lWeb
	oPrint:Setup()
	If !(oPrint:nModalResult == 1)// Botao cancelar da janela de config. de impressoras.
		Return
	Else
		lImpnovo:=(oPrint:nModalResult == 1)
	Endif
EndIf

If oPrint:nPaperSize  == 9 // Papél A4
	nLinMax	:=	2000
	nColMax	:=	3365 //3508 //3380 //3365
	nLayout 	:= 2
	oFont02n	:= TFont():New("Arial", 12, 12, , .T., , , , .T., .F.) // Negrito
	oFont03n	:= TFont():New("Arial", 13, 13, , .T., , , , .T., .F.) // Negrito
	oFont04		:= TFont():New("Arial", 05, 05, , .F., , , , .T., .F.) // Normal
	oFont05		:= TFont():New("Arial", 08, 08, , .F., , , , .T., .F.) // Normal
Elseif oPrint:nPaperSize == 1 // Papel Carta
	nLinMax	:=	2000
	nColMax	:=	3175
	nLayout 	:= 3
	oFont02n	:= TFont():New("Arial", 12, 12, , .T., , , , .T., .F.) // Negrito
	oFont03n	:= TFont():New("Arial", 13, 13, , .T., , , , .T., .F.) // Negrito
	oFont04		:= TFont():New("Arial", 07, 07, , .F., , , , .T., .F.) // Normal
	oFont05		:= TFont():New("Arial", 08, 08, , .F., , , , .T., .F.) // Normal
Else // Papel Oficio2 216 x 330mm / 8 1/2 x 13in
	nLinMax	:=	2435
	nColMax	:=	3765
	nLayout 	:= 1
	oFont02n	:= TFont():New("Arial", 12, 12, , .T., , , , .T., .F.) // Negrito
	oFont03n	:= TFont():New("Arial", 14, 14, , .T., , , , .T., .F.) // Negrito
	oFont04		:= TFont():New("Arial", 09, 09, , .F., , , , .T., .F.) // Normal
	oFont05		:= TFont():New("Arial", 08, 08, , .F., , , , .T., .F.) // Normal
Endif

While lImpnovo

	lImpnovo:=.F.
	nVolta  += 1
	nT      += 5
	nT1     += 5
	nT2     += 5
	nT3     += 9
	nT4     += 9
	nProx   += 1

	For nX := 1 To Len(aDados)

		If ValType(aDados[nX]) == 'U' .OR. Len(aDados[nX]) == 0
			Loop
		EndIf

		For nI := 24 To 28
			If Len(aDados[nX, nI]) < nT
				For nJ := Len(aDados[nX, nI]) + 1 To nT
					If AllTrim(Str(nI)) $ "27,28"
						aAdd(aDados[nX, nI], 0)
					Else
						aAdd(aDados[nX, nI], "")
					EndIf
				Next nJ
			EndIf
		Next nI

		For nI := 36 To 47
			If Len(aDados[nX, nI]) < nT1
				For nJ := Len(aDados[nX, nI]) + 1 To nT1
					If AllTrim(Str(nI)) $ "36"
						aAdd(aDados[nX, nI], StoD(""))
					ElseIf AllTrim(Str(nI)) $ "42,45,46,47"
						aAdd(aDados[nX, nI], 0)
					Else
						aAdd(aDados[nX, nI], "")
					EndIf
				Next nJ
			EndIf
		Next nI

		For nI := 48 To 55
			If Len(aDados[nX, nI]) < nT2
				For nJ := Len(aDados[nX, nI]) + 1 To nT2
					aAdd(aDados[nX, nI], "")
				Next nJ
			EndIf
		Next nI

		If oPrint:Cprinter == "PDF" .OR. lWeb
			nLinIni	:= 150
			nLimFim	:= 400
		Else
			nLinIni	:= 050
			nLimFim	:= 300
		Endif


		nColIni	:= 080
		nColA4		:= 000
		nLinA4		:= 000
		nColSoma	:= 000
		nColSoma2	:= 000

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
		//³Inicia uma nova pagina
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
		oPrint:StartPage()
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Box Principal                                                 ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		oPrint:Box((nLinIni + 0000)*nAL, (nColIni + 0000)*nAC, (nLimFim + nLinMax)*nAL, (nColIni + nColMax)*nAC)
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Carrega e Imprime Logotipo da Empresa                         ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		fLogoEmp(@cFileLogo,, cLogoGH)

		If File(cFilelogo)
			oPrint:SayBitmap((nLinIni + 0050)*nAL, (nColIni + 0020)*nAC, cFileLogo, (400)*nAL, (090)*nAC) 	// Tem que estar abaixo do RootPath
		EndIf

		If nLayout == 2 // Papél A4
			nColA4    := -0395
			nLinA4    := -0010
			nColSoma  := -0300
			nColSoma2 := -0190
		Elseif nLayout == 3// Carta
			nColA4    := -0590
			nLinA4    := -0010
			nColSoma  := -0300
			nColSoma2 := -0190
		Endif

		oPrint:Say((nLinIni + 0050)*nAL, (nColIni + (nColMax*0.30))*nAC, "GUIA DE SERVIÇO PROFISSIONAL / SERVIÇO AUXILIAR DE", oFont02n,,,, 2) //GUIA DE SERVIÇO PROFISSIONAL / SERVIÇO AUXILIAR DE
		oPrint:Say((nLinIni + 0100)*nAL, (nColIni + (nColMax*0.36))*nAC, "DIAGNÓSTICO E TERAPIA - SP/SADT", oFont02n,,,, 2) //DIAGNÓSTICO E TERAPIA - SP/SADT
		oPrint:Say((nLinIni + 0050)*nAL, (nColIni + (nColMax*0.70))*nAC, "2- Nº Guia no Prestador", oFont01) //"Nº"
		oPrint:Say((nLinIni + 0050)*nAL, (nColIni + (nColMax*0.79))*nAC, aDados[nX, 02], oFont03n)

		oPrint:Box((nLinIni + 0175)*nAL + nLinA4, (nColIni + 0010)*nAC, (nLinIni + 0250)*nAL + nLinA4, (nColIni + (nColMax*0.1) - 0010)*nAC)
		oPrint:Say((nLinIni + 0170 + nLinA4)*nAL, (nColIni + 0015)*nAC, "1 - "+"Registro ANS", oFont01) //"Registro ANS"
		oPrint:Say((nLinIni + 0210 + nLinA4)*nAL, (nColIni + 0030)*nAC, aDados[nX, 01], oFont04)
		oPrint:Box((nLinIni + 0175)*nAL + nLinA4, (nColIni + (nColMax*0.1))*nAC, (nLinIni + 0250)*nAL + nLinA4, (nColIni + (nColMax*0.37))*nAC)
		oPrint:Say((nLinIni + 0170 + nLinA4)*nAL, (nColIni + (nColMax*0.1) + 0010)*nAC, "3 - "+"Nº Guia Principal", oFont01) //"Nº Guia Principal"
		oPrint:Say((nLinIni + 0210 + nLinA4)*nAL, (nColIni + (nColMax*0.1) + 0020)*nAC, aDados[nX, 03], oFont04)

		oPrint:Box((nLinIni + 0260)*nAL + nLinA4, (nColIni + 0010)*nAC, (nLinIni + 0335)*nAL + nLinA4, (nColIni + (nColMax*0.14) - 0014)*nAC)
		oPrint:Say((nLinIni + 0255 + nLinA4)*nAL, (nColIni + 0020)*nAC, "4 - Data da Autorização", oFont01) //"Data da Autorização"
		oPrint:Say((nLinIni + 0295 + nLinA4)*nAL, (nColIni + 0030)*nAC, DtoC(aDados[nX, 04]), oFont04)
		oPrint:Box((nLinIni + 0260)*nAL + nLinA4, (nColIni + (nColMax*0.14))*nAC, (nLinIni + 0335)*nAL + nLinA4, (nColIni + (nColMax*0.42) - 0010)*nAC)
		oPrint:Say((nLinIni + 0255 + nLinA4)*nAL, (nColIni + (nColMax*0.14) + 0010)*nAC, "5 - Senha", oFont01) //"Senha"
		oPrint:Say((nLinIni + 0295 + nLinA4)*nAL, (nColIni + (nColMax*0.14) + 0020)*nAC, aDados[nX, 05], oFont04)
		oPrint:Box((nLinIni + 0260)*nAL + nLinA4, (nColIni + (nColMax*0.42))*nAC, (nLinIni + 0335)*nAL + nLinA4, (nColIni + (nColMax*0.54) - 0010)*nAC)
		oPrint:Say((nLinIni + 0255 + nLinA4)*nAL, (nColIni + (nColMax*0.42) + 0010)*nAC, "6 - Data de Validade da Senha", oFont01) //"6 - Data de Validade da Senha"
		oPrint:Say((nLinIni + 0295 + nLinA4)*nAL, (nColIni + (nColMax*0.42) + 0020)*nAC, DtoC(aDados[nX, 06]), oFont04)
		oPrint:Box((nLinIni + 0260)*nAL + nLinA4, (nColIni + (nColMax*0.54))*nAC, (nLinIni + 0335)*nAL + nLinA4, (nColIni + (nColMax*0.82) - 0010)*nAC)
		oPrint:Say((nLinIni + 0255 + nLinA4)*nAL, (nColIni + (nColMax*0.54) + 0010)*nAC, "7 - Número da Guia Atribuído pela Operadora", oFont01) //"7 - Número da Guia Atribuído pela Operadora"
		oPrint:Say((nLinIni + 0295 + nLinA4)*nAL, (nColIni + (nColMax*0.54) + 0020)*nAC, aDados[nX, 07], oFont04)

		AddTBrush(oPrint, (nLinIni + 0310 + nLinA4)*nAL, (nColIni + 0010)*nAC, (nLinIni + 0365)*nAL + nLinA4, (nColIni + nColMax)*nAC)
		oPrint:Say((nLinIni + 0330 + nLinA4)*nAL, (nColIni + 0010)*nAC, "Dados do Beneficiário", oFont01) //"Dados do Beneficiário"
		oPrint:Box((nLinIni + 0370)*nAL + nLinA4, (nColIni + 0010)*nAC, (nLinIni + 0447)*nAL + nLinA4, (nColIni + (nColMax*0.20) - 0010)*nAC)
		oPrint:Say((nLinIni + 0365 + nLinA4)*nAL, (nColIni + 0020)*nAC, "8 - Número da Carteira", oFont01) //"8 - Número da Carteira"
		oPrint:Say((nLinIni + 0405 + nLinA4)*nAL, (nColIni + 0030)*nAC, aDados[nX, 08], oFont04)
		oPrint:Box((nLinIni + 0370)*nAL + nLinA4, (nColIni + (nColMax*0.20))*nAC, (nLinIni + 0447)*nAL + nLinA4, (nColIni + (nColMax*0.30) - 0010)*nAC)
		oPrint:Say((nLinIni + 0365 + nLinA4)*nAL, (nColIni + (nColMax*0.20) + 0010)*nAC, "9 - Validade da Carteira", oFont01) //"9 - Validade da Carteira"
		oPrint:Say((nLinIni + 0405 + nLinA4)*nAL, (nColIni + (nColMax*0.20) + 0020)*nAC, DtoC(aDados[nX, 09]), oFont04)
		oPrint:Box((nLinIni + 0370)*nAL + nLinA4, (nColIni + (nColMax*0.30))*nAC, (nLinIni + 0447)*nAL + nLinA4, (nColIni + (nColMax*0.75) - 0010)*nAC)
		oPrint:Say((nLinIni + 0365 + nLinA4)*nAL, (nColIni + (nColMax*0.30) + 0010)*nAC, "10 - Nome", oFont01) //"10 - Nome"
		oPrint:Say((nLinIni + 0405 + nLinA4)*nAL, (nColIni + (nColMax*0.30) + 0020)*nAC, aDados[nX, 10], oFont04)
		oPrint:Box((nLinIni + 0370)*nAL + nLinA4, (nColIni + (nColMax*0.75))*nAC, (nLinIni + 0447)*nAL + nLinA4, (nColIni + (nColMax*0.93) - 0010)*nAC)
		oPrint:Say((nLinIni + 0365 + nLinA4)*nAL, (nColIni + (nColMax*0.75) + 0010)*nAC, "11 - Cartão Nacional de Saúde", oFont01) //"11 - Cartão Nacional de Saúde"
		oPrint:Say((nLinIni + 0405 + nLinA4)*nAL, (nColIni + (nColMax*0.75) + 0020)*nAC, aDados[nX, 11], oFont04)
		oPrint:Box((nLinIni + 0370)*nAL + nLinA4, (nColIni + (nColMax*0.93))*nAC, (nLinIni + 0447)*nAL + nLinA4, (nColIni + nColMax - 0010)*nAC)
		oPrint:Say((nLinIni + 0365 + nLinA4)*nAL, (nColIni + (nColMax*0.93) + 0010)*nAC, "12 -Atendimento a RN", oFont01) //"12 -Atendimento a RN"
		oPrint:Say((nLinIni + 0405 + nLinA4)*nAL, (nColIni + (nColMax*0.93) + 0020)*nAC, aDados[nX, 12], oFont04)

		AddTBrush(oPrint, (nLinIni + 0420 + nLinA4)*nAL, (nColIni + 0010)*nAC, (nLinIni + 0475)*nAL + nLinA4, (nColIni + nColMax)*nAC)
		oPrint:Say((nLinIni + 0440 + nLinA4)*nAL, (nColIni + 0010)*nAC, "Dados do Solicitante", oFont01) //"Dados do Solicitante"
		oPrint:Box((nLinIni + 0480)*nAL + nLinA4, (nColIni + 0010)*nAC, (nLinIni + 0557)*nAL + nLinA4, (nColIni + (nColMax*0.20) - 0010)*nAC)
		oPrint:Say((nLinIni + 0475 + nLinA4)*nAL, (nColIni + 0020)*nAC, "13 - Código na Operadora", oFont01) //"13 - Código na Operadora"
		oPrint:Say((nLinIni + 0515 + nLinA4)*nAL, (nColIni + 0030)*nAC, aDados[nX, 13], oFont04)
		oPrint:Box((nLinIni + 0480)*nAL + nLinA4, (nColIni + (nColMax*0.20))*nAC, (nLinIni + 0557)*nAL + nLinA4, (nColIni + nColMax - 0010)*nAC)
		oPrint:Say((nLinIni + 0475 + nLinA4)*nAL, (nColIni + (nColMax*0.20) + 0010)*nAC, "14 - Nome do Contratado", oFont01) //"14 - Nome do Contratado"
		oPrint:Say((nLinIni + 0515 + nLinA4)*nAL, (nColIni + (nColMax*0.20) + 0020)*nAC, aDados[nX, 14], oFont04)

		oPrint:Box((nLinIni + 0565)*nAL + nLinA4, (nColIni + 0010)*nAC, (nLinIni + 0642)*nAL + nLinA4, (nColIni + (nColMax*0.38) - 0010)*nAC)
		oPrint:Say((nLinIni + 0560 + nLinA4)*nAL, (nColIni + 0020)*nAC, "15 - Nome do Profissional Solicitante", oFont01) //"15 - Nome do Profissional Solicitante"
		oPrint:Say((nLinIni + 0600 + nLinA4)*nAL, (nColIni + 0030)*nAC, aDados[nX, 15], oFont04)
		oPrint:Box((nLinIni + 0565)*nAL + nLinA4, (nColIni + (nColMax*0.38))*nAC, (nLinIni + 0642)*nAL + nLinA4, (nColIni + (nColMax*0.43) - 0010)*nAC)
		oPrint:Say((nLinIni + 0550 + nLinA4)*nAL, (nColIni + (nColMax*0.38) + 0010)*nAC, "16 - Conselho", oFont01) //"16 - Conselho Profissional"
		oPrint:Say((nLinIni + 0570 + nLinA4)*nAL, (nColIni + (nColMax*0.38) + 0010)*nAC, "Profissional", oFont01) //"16 - Conselho Profissional"
		oPrint:Say((nLinIni + 0600 + nLinA4)*nAL, (nColIni + (nColMax*0.38) + 0020)*nAC, aDados[nX, 16], oFont04)
		oPrint:Box((nLinIni + 0565)*nAL + nLinA4, (nColIni + (nColMax*0.43))*nAC, (nLinIni + 0642)*nAL + nLinA4, (nColIni + (nColMax*0.56) - 0010)*nAC)
		oPrint:Say((nLinIni + 0560 + nLinA4)*nAL, (nColIni + (nColMax*0.43) + 0010)*nAC, "17 - Número no Conselho", oFont01) //"17 - Número no Conselho"
		oPrint:Say((nLinIni + 0600 + nLinA4)*nAL, (nColIni + (nColMax*0.43) + 0020)*nAC, aDados[nX, 17], oFont04)
		oPrint:Box((nLinIni + 0565)*nAL + nLinA4, (nColIni + (nColMax*0.56))*nAC, (nLinIni + 0642)*nAL + nLinA4, (nColIni + (nColMax*0.59) - 0010)*nAC)
		oPrint:Say((nLinIni + 0560 + nLinA4)*nAL, (nColIni + (nColMax*0.56) + 0010)*nAC, "18 - UF", oFont01) //"18 - UF"
		oPrint:Say((nLinIni + 0600 + nLinA4)*nAL, (nColIni + (nColMax*0.56) + 0020)*nAC, aDados[nX, 18], oFont04)
		oPrint:Box((nLinIni + 0565)*nAL + nLinA4, (nColIni + (nColMax*0.59))*nAC, (nLinIni + 0642)*nAL + nLinA4, (nColIni + (nColMax*0.67) - 0010)*nAC)
		oPrint:Say((nLinIni + 0560 + nLinA4)*nAL, (nColIni + (nColMax*0.59) + 0010)*nAC, "19 - Código CBO", oFont01) //"19 - Código CBO"
*/
 /*cQuery := "SELECT BTU_CDTERM "
	   cQuery += "FROM " + RetSqlName("BTU") + " "
	   cQuery += "WHERE BTU_VLRSIS LIKE '%" + ALLTRIM(aDados[nX, 19]) + "%' AND D_E_L_E_T_ <> '*' "

	   // Compatibiliza a sintaxe da query para o banco de dados em uso.
	   cQuery := ChangeQuery(cQuery)

	   // Executa a query e retorna o conjunto de registros numa WorkArea denominada MOVIM,
	   // contendo os registros filtrados pela clausula WHERE.
	   dbUseArea(.T., "TOPCONN", TCGenQry( , , cQuery), "MOVIM", .F., .T.)



		aDados[nX, 19] := MOVIM->BTU_CDTERM

		dbSelectArea("MOVIM")
   		dbCloseArea()*/
/* apagar
		oPrint:Say((nLinIni + 0600 + nLinA4)*nAL, (nColIni + (nColMax*0.59) + 0020)*nAC, aDados[nX, 19], oFont04)
		oPrint:Box((nLinIni + 0565)*nAL + nLinA4, (nColIni + (nColMax*0.67))*nAC, (nLinIni + 0642)*nAL + nLinA4, (nColIni + nColMax - 0010)*nAC)
		oPrint:Say((nLinIni + 0560 + nLinA4)*nAL, (nColIni + (nColMax*0.67) + 0010)*nAC, "20 - Assinatura do Profissional Solicitante", oFont01) //"20 - Assinatura do Profissional Solicitante"

		AddTBrush(oPrint, (nLinIni + 0615 + nLinA4)*nAL, (nColIni + 0010)*nAC, (nLinIni + 0670)*nAL + nLinA4, (nColIni + nColMax)*nAC)
		oPrint:Say((nLinIni + 0635 + nLinA4)*nAL, (nColIni + 0010)*nAC, "Dados da Solicitação / Procedimentos e Exames Solicitados", oFont01) //"Dados da Solicitação / Procedimentos e Exames Solicitados"
		oPrint:Box((nLinIni + 0675)*nAL + nLinA4, (nColIni + 0010)*nAC, (nLinIni + 0752)*nAL + nLinA4, (nColIni + (nColMax*0.08) - 0010)*nAC)
		oPrint:Say((nLinIni + 0665 + nLinA4)*nAL, (nColIni + 0020)*nAC, "21 - Caráter do", oFont01) //"21 - Caráter do "
		oPrint:Say((nLinIni + 0685 + nLinA4)*nAL, (nColIni + 0020)*nAC, "Atendimento", oFont01) //"8 - Número da Carteira"
		oPrint:Say((nLinIni + 0710 + nLinA4)*nAL, (nColIni + 0080)*nAC, aDados[nX, 21], oFont04)
		oPrint:Box((nLinIni + 0675)*nAL + nLinA4, (nColIni + (nColMax*0.08))*nAC, (nLinIni + 0752)*nAL + nLinA4, (nColIni + (nColMax*0.17) - 0010)*nAC)
		oPrint:Say((nLinIni + 0665 + nLinA4)*nAL, (nColIni + (nColMax*0.08) + 0010)*nAC, "22 - Data da Solicitação", oFont01) //"22 - Data da Solicitação"
		oPrint:Say((nLinIni + 0710 + nLinA4)*nAL, (nColIni + (nColMax*0.08) + 0020)*nAC, DtoC(aDados[nX, 22]), oFont04)
		oPrint:Box((nLinIni + 0675)*nAL + nLinA4, (nColIni + (nColMax*0.17))*nAC, (nLinIni + 0752)*nAL + nLinA4, (nColIni + nColMax - 0010)*nAC)
		oPrint:Say((nLinIni + 0665 + nLinA4)*nAL, (nColIni + (nColMax*0.17) + 0010)*nAC, "23 - Indicação Clínica", oFont01) //"23 - Indicação Clínica"
		oPrint:Say((nLinIni + 0710 + nLinA4)*nAL, (nColIni + (nColMax*0.17) + 0020)*nAC, aDados[nX, 23], oFont04)

		oPrint:Box((nLinIni + 0760)*nAL + nLinA4, (nColIni + 0010)*nAC, (nLinIni + 1000)*nAL + nLinA4, (nColIni + nColMax - 0010)*nAC)
		oPrint:Say((nLinIni + 0760 + nLinA4)*nAL, (nColIni + (nColMax*0.02))*nAC, "24-Tabela", oFont01) //"24-Tabela"
		oPrint:Say((nLinIni + 0760 + nLinA4)*nAL, (nColIni + (nColMax*0.06))*nAC, "25- Código do Procedimento", oFont01) //"25- Código do Procedimento"
		oPrint:Say((nLinIni + 0760 + nLinA4)*nAL, (nColIni + (nColMax*0.16))*nAC, "26 - Descrição", oFont01) //"26 - Descrição"
		oPrint:Say((nLinIni + 0760 + nLinA4)*nAL, (nColIni + (nColMax*0.85))*nAC, "27-Qtde. Solic.", oFont01) //"27-Qtde. Solic."
		oPrint:Say((nLinIni + 0760 + nLinA4)*nAL, (nColIni + (nColMax*0.92))*nAC, "28-Qtde. Aut.", oFont01) //"28-Qtde. Aut."

		nOldLinIni := nLinIni

		if nVolta = 1
			nV:=1
		Endif

		cOper := substr(aDados[nX, 2],1,4)
		cAno  := substr(aDados[nX, 2],6,4)
		cMes  := substr(aDados[nX, 2],11,2)
		cAut  := substr(aDados[nX, 2],14,8)
		lLibera := .f.

// ATENÇÃO!!! Não dar manutenção nessa codificação! Devemos manter os tratamentos nas tabelas B7A e B7B (Tipos de guias) - Thiago Fonseca 21.01.15
		//Realizo a consulta na BEA
		DbSelectArea("BEA")
		BEA->(dbSetOrder(1))
		If BEA->(DbSeek(xFilial("BEA")+cOper+cAno+cMes+cAut))
			If BEA->BEA_LIBERA == '0'
				//se eh uma execucao eu tenho que refazer os procedimentos que foram solicitados
				If !Empty(BEA->BEA_NRLBOR)
					xChave := alltrim(BEA->BEA_NRLBOR)
				Else
					xChave := alltrim(cOper+cAno+cMes+cAut)
				Endif
			Else
				//se eh uma solicitacao eu tenho que refazer os procedimentos que foram solicitados e autorizados
				xChave := alltrim(cOper+cAno+cMes+cAut)
				lLibera := .t.
			Endif

			BE2->(DbSetORder(1))
			if !Empty(xChave) .and. BE2->(MsSeek(xFilial('BE2')+alltrim(xChave)))
				aDados[nX, 24] := {}
				aDados[nX, 25] := {}
				aDados[nX, 26] := {}
				aDados[nX, 27] := {}
				aDados[nX, 28] := {}
				While !BE2->(Eof()) .and. xFilial('BE2')+xChave == BE2->(BE2_FILIAL+BE2_OPEMOV+BE2_ANOAUT+BE2_MESAUT+BE2_NUMAUT)
					If (BE2->BE2_STATUS == '0' .And. lImpNAut) .Or. BE2->BE2_STATUS == '1'

						BD6->(DbSetOrder(6))
						If BD6->(MsSeek(xFilial("BD6")+BEA->(BEA_OPEMOV+BEA_CODLDP+BEA_CODPEG+BEA_NUMGUI)+'1'+BE2->(BE2_CODPAD+BE2_CODPRO))) .and. !Empty(BD6->BD6_SLVPAD)
							cCodTab := CABIMPVINC("BR4","87"	,	BD6->BD6_CODPAD					,.F.)
							cCodPro := CABIMPVINC("BR8",cCodTab	,	BD6->BD6_CODPAD+BD6->BD6_CODPRO	,.F.)
							cDescri := CABIMPVINC("BR8",cCodTab	,	BD6->BD6_CODPAD+BD6->BD6_CODPRO	,.T.)
						Else
							cCodTab := CABIMPVINC("BR4","87"	,	BE2->BE2_CODPAD					,.F.)
							cCodPro := CABIMPVINC("BR8",cCodTab	,	BE2->BE2_CODPAD+BE2->BE2_CODPRO	,.F.)
							cDescri := CABIMPVINC("BR8",cCodTab	,	BE2->BE2_CODPAD+BE2->BE2_CODPRO	,.T.)
						Endif

						If Empty(cCodTab) .Or. Empty(cCodPro) .Or. Empty(cDescri)
							cCodTab := BE2->BE2_CODPAD
							cCodPro := BE2->BE2_CODPRO
							cDescri := Posicione("BR8",1, xFilial("BR8")+BE2->(BE2_CODPAD+BE2_CODPRO), "BR8_DESCRI")
						Endif

						aAdd(aDados[nX, 24], cCodTab)
						aAdd(aDados[nX, 25], cCodPro)
						aAdd(aDados[nX, 26], cDescri)
						aAdd(aDados[nX, 27], BE2->BE2_QTDSOL)
						aAdd(aDados[nX, 28], IIf(BE2->BE2_STATUS = '1',BE2->BE2_QTDSOL,0))

					Endif
					BE2->(DbSkip())
				Enddo
				For nI := 24 To 28
					If Len(aDados[nX, nI]) < nT
						For nJ := Len(aDados[nX, nI]) + 1 To nT
							If AllTrim(Str(nI)) $ "27,28"
								aAdd(aDados[nX, nI], 0)
							Else
								aAdd(aDados[nX, nI], "")
							EndIf
						Next nJ
					EndIf
				Next nI
			Endif
		Endif

		For nP := nV To nT
			oPrint:Say((nLinIni + 0800 + nLinA4)*nAL, (nColIni + 0025)*nAC, AllTrim(Str(nP)) + " - ", oFont01)
			oPrint:Say((nLinIni + 0800 + nLinA4)*nAL, (nColIni + (nColMax*0.020))*nAC, aDados[nX, 24, nP], oFont04)
			oPrint:Say((nLinIni + 0800 + nLinA4)*nAL, (nColIni + (nColMax*0.06))*nAC, aDados[nX, 25, nP], oFont04)
			oPrint:Say((nLinIni + 0800 + nLinA4)*nAL, (nColIni + (nColMax*0.16))*nAC, aDados[nX, 26, nP], oFont04)
			oPrint:Say((nLinIni + 0800 + nLinA4)*nAL, (nColIni + (nColMax*0.85))*nAC, IIf(Empty(aDados[nX, 27, nP]), "", Transform(aDados[nX, 27, nP], "@E 9999.99")), oFont04,,,,1)
			oPrint:Say((nLinIni + 0800 + nLinA4)*nAL, (nColIni + (nColMax*0.92))*nAC, IIf(Empty(aDados[nX, 28, nP]), "", Transform(aDados[nX, 28, nP], "@E 9999.99")), oFont04,,,,1)
			nLinIni += 40
		Next nP

		if nT < Len(aDados[nX, 24]).or. lImpnovo
			nV:=nP
			lImpnovo:=.T.
		Endif

		nLinIni := nOldLinIni

		AddTBrush(oPrint, (nLinIni + 0980 + nLinA4)*nAL, (nColIni + 0010)*nAC, (nLinIni + 1035)*nAL + nLinA4, (nColIni + nColMax)*nAC)
		oPrint:Say((nLinIni + 1000 + nLinA4)*nAL, (nColIni + 0010)*nAC, "Dados do Contratado Executante", oFont01) //"Dados do Contratado Executante"
		oPrint:Box((nLinIni + 1040)*nAL + nLinA4, (nColIni + 0010)*nAC, (nLinIni + 1118)*nAL + nLinA4, (nColIni + (nColMax*0.20) - 0010)*nAC)
		oPrint:Say((nLinIni + 1035 + nLinA4)*nAL, (nColIni + 0020)*nAC, "29 - Código na Operadora", oFont01) //"29 - Código na Operadora"

		If !lLibera
			oPrint:Say((nLinIni + 1075 + nLinA4)*nAL, (nColIni + 0030)*nAC, aDados[nX, 29], oFont04)
		Endif

		oPrint:Box((nLinIni + 1040)*nAL + nLinA4, (nColIni + (nColMax*0.20))*nAC, (nLinIni + 1118)*nAL + nLinA4, (nColIni + (nColMax*0.87) - 0010)*nAC)
		oPrint:Say((nLinIni + 1035 + nLinA4)*nAL, (nColIni + (nColMax*0.20) + 0010)*nAC, "30 - Nome do Contratado", oFont01) //"30 - Nome do Contratado"

		If !lLibera
			oPrint:Say((nLinIni + 1075 + nLinA4)*nAL, (nColIni + (nColMax*0.20) + 0020)*nAC, aDados[nX, 30], oFont04)
		Endif

		oPrint:Box((nLinIni + 1040)*nAL + nLinA4, (nColIni + (nColMax*0.87))*nAC, (nLinIni + 1118)*nAL + nLinA4, (nColIni + nColMax - 0010)*nAC)
		oPrint:Say((nLinIni + 1035 + nLinA4)*nAL, (nColIni + (nColMax*0.87) + 0010)*nAC, "31 - Código CNES", oFont01) //"31 - Código CNES"
		oPrint:Say((nLinIni + 1075 + nLinA4)*nAL, (nColIni + (nColMax*0.87) + 0020)*nAC, aDados[nX, 31], oFont04)

		AddTBrush(oPrint, (nLinIni + 1095 + nLinA4)*nAL, (nColIni + 0010)*nAC, (nLinIni + 1149.1)*nAL + nLinA4, (nColIni + nColMax)*nAC)
		oPrint:Say((nLinIni + 1110 + nLinA4)*nAL, (nColIni + 0010)*nAC, "Dados do Atendimento", oFont01) //"Dados do Atendimento"
		oPrint:Box((nLinIni + 1150)*nAL + nLinA4, (nColIni + 0010)*nAC, (nLinIni + 1226)*nAL + nLinA4, (nColIni + (nColMax*0.08) - 0010)*nAC)
		oPrint:Say((nLinIni + 1145 + nLinA4)*nAL, (nColIni + 0020)*nAC, "32-Tipo de Atendimento", oFont01) //"32-Tipo de Atendimento"
		oPrint:Say((nLinIni + 1185 + nLinA4)*nAL, (nColIni + 0100)*nAC, aDados[nX, 32], oFont04)
		oPrint:Box((nLinIni + 1150)*nAL + nLinA4, (nColIni + (nColMax*0.08))*nAC, (nLinIni + 1226)*nAL + nLinA4, (nColIni + (nColMax*0.29) - 0010)*nAC)
		oPrint:Say((nLinIni + 1145 + nLinA4)*nAL, (nColIni + (nColMax*0.08) + 0010)*nAC, "33 - Indicação de Acidente (acidente ou doença relacionada", oFont01) //"33 - Indicação de Acidente (acidente ou doença relacionada"
		oPrint:Say((nLinIni + 1185 + nLinA4)*nAL, (nColIni + (nColMax*0.08) + 0020)*nAC, aDados[nX, 33], oFont04)

		oPrint:Box((nLinIni + 1150)*nAL + nLinA4, (nColIni + (nColMax*0.29))*nAC, (nLinIni + 1226)*nAL + nLinA4, (nColIni + (nColMax*0.36) - 0010)*nAC)
		oPrint:Say((nLinIni + 1145 + nLinA4)*nAL, (nColIni + (nColMax*0.29) + 0010)*nAC, "34 - Tipo de Consulta", oFont01) //"34 - Tipo de Consulta"
		oPrint:Say((nLinIni + 1185 + nLinA4)*nAL, (nColIni + (nColMax*0.29) + 0020)*nAC, aDados[nX, 34], oFont04)

		oPrint:Box((nLinIni + 1150)*nAL + nLinA4, (nColIni + (nColMax*0.36))*nAC, (nLinIni + 1226)*nAL + nLinA4, (nColIni + (nColMax*0.53) - 0010)*nAC)
		oPrint:Say((nLinIni + 1145 + nLinA4)*nAL, (nColIni + (nColMax*0.36) + 0010)*nAC, "35 - Motivo de Encerramento do Atendimento", oFont01) //"35 - Motivo de Encerramento do Atendimento"
		oPrint:Say((nLinIni + 1185 + nLinA4)*nAL, (nColIni + (nColMax*0.36) + 0020)*nAC, aDados[nX, 35], oFont04)

		AddTBrush(oPrint, (nLinIni + 1200 + nLinA4)*nAL, (nColIni + 0010)*nAC, (nLinIni + 1260)*nAL + nLinA4, (nColIni + nColMax)*nAC)
		oPrint:Say((nLinIni + 1220 + nLinA4)*nAL, (nColIni + 0010)*nAC, "Dados da Execução / Procedimentos e Exames Realizados", oFont01) //Dados da Execução / Procedimentos e Exames Realizados
		oPrint:Box((nLinIni + 1265)*nAL + nLinA4, (nColIni + 0010)*nAC, (nLinIni + 1500)*nAL + nLinA4, (nColIni + nColMax - 0010)*nAC)
		oPrint:Say((nLinIni + 1265 + nLinA4)*nAL, (nColIni + (nColMax*0.02))*nAC, "36-Data", oFont01) //"36-Data"
		oPrint:Say((nLinIni + 1265 + nLinA4)*nAL, (nColIni + (nColMax*0.09))*nAC, "37-Hora Inicial", oFont01) //"37-Hora Inicial"
		oPrint:Say((nLinIni + 1265 + nLinA4)*nAL, (nColIni + (nColMax*0.14))*nAC, "38-Hora Final", oFont01) //"38-Hora Final"
		oPrint:Say((nLinIni + 1265 + nLinA4)*nAL, (nColIni + (nColMax*0.19))*nAC, "39-Tabela", oFont01) //"39-Tabela"
		oPrint:Say((nLinIni + 1265 + nLinA4)*nAL, (nColIni + (nColMax*0.22))*nAC, "40-Código do Procedimento", oFont01) //"40-Código do Procedimento"
		oPrint:Say((nLinIni + 1265 + nLinA4)*nAL, (nColIni + (nColMax*0.31))*nAC, "41-Descrição", oFont01) //"41-Descrição"
		oPrint:Say((nLinIni + 1265 + nLinA4)*nAL, (nColIni + (nColMax*0.66))*nAC, "42 - Qtde.", oFont01) //"42 - Qtde."
		oPrint:Say((nLinIni + 1265 + nLinA4)*nAL, (nColIni + (nColMax*0.69))*nAC, "43-Via", oFont01) //"43-Via"
		oPrint:Say((nLinIni + 1265 + nLinA4)*nAL, (nColIni + (nColMax*0.715))*nAC, "44-Tec.", oFont01) //"44-Tec."
		oPrint:Say((nLinIni + 1265 + nLinA4)*nAL, (nColIni + (nColMax*0.74))*nAC, "45- Fator Red./Acresc.", oFont01) //"45- Fator Red./Acresc."
		oPrint:Say((nLinIni + 1265 + nLinA4)*nAL, (nColIni + (nColMax*0.81))*nAC, "46-Valor Unitário (R$)", oFont01) //"46-Valor Unitário (R$)"
		oPrint:Say((nLinIni + 1265 + nLinA4)*nAL, (nColIni + (nColMax*0.90))*nAC, "47-Valor Total (R$)", oFont01) //"47-Valor Total (R$)"

		nOldLinIni := nLinIni

		if nVolta==1
			nV1:=1
		Endif

		If ExistBlock("PLSGTISS")
			lImpPrc := ExecBlock("PLSGTISS",.F.,.F.,{"02",lImpPrc})
		EndIf

		If lImpPrc

			For nP1 := nV1 To nT1
				If !lLibera
					If !Empty(aDados[nX, 40, nP1])
						oPrint:Say((nLinIni + 1305 + nLinA4)*nAL, (nColIni + 0015)*nAC, AllTrim(Str(nP1)) + " - ", oFont01)
						oPrint:Say((nLinIni + 1305 + nLinA4)*nAL, (nColIni + (nColMax*0.020))*nAC, IIf(Empty(aDados[nX, 36, nP1]), "", DtoC(aDados[nX, 36, nP1])), oFont04)
						oPrint:Say((nLinIni + 1305 + nLinA4)*nAL, (nColIni + (nColMax*0.090))*nAC, IIf(Empty(aDados[nX, 37, nP1]), "", Transform(aDados[nX, 37, nP1], "@R 99:99")), oFont04)
						oPrint:Say((nLinIni + 1305 + nLinA4)*nAL, (nColIni + (nColMax*0.140))*nAC, IIf(Empty(aDados[nX, 38, nP1]), "", Transform(aDados[nX, 38, nP1], "@R 99:99")), oFont04)
						oPrint:Say((nLinIni + 1305 + nLinA4)*nAL, (nColIni + (nColMax*0.190))*nAC, aDados[nX, 39, nP1], oFont04)
						oPrint:Say((nLinIni + 1305 + nLinA4)*nAL, (nColIni + (nColMax*0.22))*nAC, aDados[nX, 40, nP1], oFont04)
						oPrint:Say((nLinIni + 1305 + nLinA4)*nAL, (nColIni + (nColMax*0.31))*nAC, SUBSTR(aDados[nX, 41, nP1],1,51), oFont04)
						oPrint:Say((nLinIni + 1305 + nLinA4)*nAL, (nColIni + (nColMax*0.660))*nAC, IIf(Empty(aDados[nX, 42, nP1]), "", Transform(aDados[nX, 42, nP1], "@E 9999.99")), oFont04,,,,1)
						oPrint:Say((nLinIni + 1305 + nLinA4)*nAL, (nColIni + (nColMax*0.690))*nAC, aDados[nX, 43, nP1], oFont04)
						oPrint:Say((nLinIni + 1305 + nLinA4)*nAL, (nColIni + (nColMax*0.72))*nAC, aDados[nX, 44, nP1], oFont04)
						oPrint:Say((nLinIni + 1305 + nLinA4)*nAL, (nColIni + (nColMax*0.755))*nAC, IIf(Empty(aDados[nX, 45, nP1]), "", Transform(aDados[nX, 45, nP1], "@E 9999.99")), oFont04,,,,1)
						oPrint:Say((nLinIni + 1305 + nLinA4)*nAL, (nColIni + (nColMax*0.82))*nAC, IIf(Empty(aDados[nX, 46, nP1]), "", Transform(aDados[nX, 46, nP1], "@E 99,999,999.99")), oFont04,,,,1)
						oPrint:Say((nLinIni + 1305 + nLinA4)*nAL, (nColIni + (nColMax*0.91))*nAC, IIf(Empty(aDados[nX, 47, nP1]), "", Transform(aDados[nX, 47, nP1], "@E 99,999,999.99")), oFont04,,,,1)
					Endif
				Endif
				nLinIni += 40
			Next nP1

		EndIf

		if nT1 < Len(aDados[nX, 36]).or. lImpnovo
			nV1:=nP1
			lImpnovo:=.T.
		Endif

		nLinIni := nOldLinIni

		AddTBrush(oPrint, (nLinIni + 1480 + nLinA4)*nAL, (nColIni + 0010)*nAC, (nLinIni + 1535)*nAL + nLinA4, (nColIni + nColMax)*nAC)
		oPrint:Say((nLinIni + 1500 + nLinA4)*nAL, (nColIni + 0010)*nAC, "Identificação do(s) Profissional(is) Executante(s)", oFont01) //Identificação do(s) Profissional(is) Executante(s)
		oPrint:Box((nLinIni + 1540)*nAL + nLinA4, (nColIni + 0010)*nAC, (nLinIni + 1775)*nAL + nLinA4, (nColIni + nColMax - 0010)*nAC)
		oPrint:Say((nLinIni + 1530 + nLinA4)*nAL, (nColIni + (nColMax*0.008))*nAC, "48-Seq.Ref", oFont01) //"48-Seq.Ref"
		oPrint:Say((nLinIni + 1530 + nLinA4)*nAL, (nColIni + (nColMax*0.04))*nAC, "49-Grau Part.", oFont01) //"49-Grau Part."
		oPrint:Say((nLinIni + 1530 + nLinA4)*nAL, (nColIni + (nColMax*0.09))*nAC, "50-Código na Operadora/CPF", oFont01) //"50-Código na Operadora/CPF"
		oPrint:Say((nLinIni + 1530 + nLinA4)*nAL, (nColIni + (nColMax*0.25))*nAC, "51-Nome do Profissional", oFont01) //"51-Nome do Profissional"
		oPrint:Say((nLinIni + 1530 + nLinA4)*nAL, (nColIni + (nColMax*0.64))*nAC, "52-Conselho", oFont01) //"52-Conselho"
		oPrint:Say((nLinIni + 1530 + nLinA4)*nAL, (nColIni + (nColMax*0.68))*nAC, "53-Número no Conselho", oFont01) //"53-Número no Conselho"
		oPrint:Say((nLinIni + 1530 + nLinA4)*nAL, (nColIni + (nColMax*0.88))*nAC, "54-UF", oFont01) //"54-UF"
		oPrint:Say((nLinIni + 1530 + nLinA4)*nAL, (nColIni + (nColMax*0.92))*nAC, "55-Código CBO", oFont01) //"55-Código CBO"

		if nVolta==1
			nV2:=1
		Endif

		nLinSeq := nLinIni
		For nSeq := 1 To 5
			oPrint:Say((nLinSeq + 1565 + nLinA4)*nAL, (nColIni + (nColMax*0.017))*nAC, AllTrim(Str(nSeq)) + " - ", oFont04)
			nLinSeq += 40
		Next nSeq

		For nP2 := nV2 To nT2
			nSeq := 1
			If !Empty(aDados[nX, 50, nP2])
			If !lLibera
				oPrint:Say((nLinIni + 1565 + nLinA4)*nAL, (nColIni + (nColMax*0.051))*nAC, aDados[nX, 49, nP2], oFont04)
				oPrint:Say((nLinIni + 1565 + nLinA4)*nAL, (nColIni + (nColMax*0.09))*nAC, aDados[nX, 50, nP2], oFont04)
				oPrint:Say((nLinIni + 1565 + nLinA4)*nAL, (nColIni + (nColMax*0.25))*nAC, aDados[nX, 51, nP2], oFont04)
				oPrint:Say((nLinIni + 1565 + nLinA4)*nAL, (nColIni + (nColMax*0.64))*nAC, aDados[nX, 52, nP2], oFont04)
				oPrint:Say((nLinIni + 1565 + nLinA4)*nAL, (nColIni + (nColMax*0.68))*nAC, If (Empty(aDados[nX, 53, nP2]), "", Transform(aDados[nX, 53, nP2], "999999999999999")), oFont04)
				oPrint:Say((nLinIni + 1565 + nLinA4)*nAL, (nColIni + (nColMax*0.883))*nAC, aDados[nX, 54, nP2], oFont04)
				If FUNNAME() == "HSPAHM30"
					oPrint:Say((nLinIni + 1565 + nLinA4)*nAL, (nColIni + (nColMax*0.92))*nAC, "", oFont04)
				Else
					oPrint:Say((nLinIni + 1565 + nLinA4)*nAL, (nColIni + (nColMax*0.92))*nAC, aDados[nX, 55, nP2], oFont04)
				EndIf
			Endif
			nLinIni += 40
			EndIf
			nSeq++
		Next nP2

		if nT2 < Len(aDados[nX, 48]).or. lImpnovo
			nV2:=nP2
			lImpnovo:=.T.
		Endif

		nLinIni := nOldLinIni

		oPrint:Box((nLinIni + 1785)*nAL + nLinA4, (nColIni + 0010)*nAC, (nLinIni + 1920)*nAL + nLinA4, (nColIni + nColMax - 0010)*nAC)
		oPrint:Say((nLinIni + 1780 + nLinA4)*nAL, (nColIni + 0020)*nAC, "56-Data de Realização de Procedimentos em Série 57-Assinatura do Beneficiário ou Responsável", oFont01) //56-Data de Realização de Procedimentos em Série 57-Assinatura do Beneficiário ou Responsável
		if Len(aDados[nX])>68
			oPrint:Say((nLinIni + 1805 + nLinA4)*nAL, (nColIni + 0020)*nAC, "1-  "+If (Empty(aDados[nX, 69]), "", dToc(aDados[nX, 69]))+"   ____________________________", oFont04)
			oPrint:Say((nLinIni + 1870 + nLinA4)*nAL, (nColIni + 0020)*nAC, "2-  "+If (Empty(aDados[nX, 70]), "", dToc(aDados[nX, 70]))+"   ____________________________", oFont04)
			oPrint:Say((nLinIni + 1805 + nLinA4)*nAL, (nColIni + (nColMax/5))*nAC, "3-  "+If (Empty(aDados[nX, 71]), "", dToc(aDados[nX, 71]))+"   ____________________________", oFont04)
			oPrint:Say((nLinIni + 1870 + nLinA4)*nAL, (nColIni + (nColMax/5))*nAC, "4-  "+If (Empty(aDados[nX, 72]), "", dToc(aDados[nX, 72]))+"   ____________________________", oFont04)
			oPrint:Say((nLinIni + 1805 + nLinA4)*nAL, (nColIni + (nColMax/5*2))*nAC, "5-  "+If (Empty(aDados[nX, 73]), "", dToc(aDados[nX, 73]))+"   ____________________________", oFont04)
			oPrint:Say((nLinIni + 1870 + nLinA4)*nAL, (nColIni + (nColMax/5*2))*nAC, "6-  "+If (Empty(aDados[nX, 74]), "", dToc(aDados[nX, 74]))+"   ____________________________", oFont04)
			oPrint:Say((nLinIni + 1805 + nLinA4)*nAL, (nColIni + (nColMax/5*3))*nAC, "7-  "+If (Empty(aDados[nX, 75]), "", dToc(aDados[nX, 75]))+"   ____________________________", oFont04)
			oPrint:Say((nLinIni + 1870 + nLinA4)*nAL, (nColIni + (nColMax/5*3))*nAC, "8-  "+If (Empty(aDados[nX, 76]), "", dToc(aDados[nX, 76]))+"   ____________________________", oFont04)
			oPrint:Say((nLinIni + 1805 + nLinA4)*nAL, (nColIni + (nColMax/5*4))*nAC, "9-  "+If (Empty(aDados[nX, 77]), "", dToc(aDados[nX, 77]))+"   ____________________________", oFont04)
			oPrint:Say((nLinIni + 1870 + nLinA4)*nAL, (nColIni + (nColMax/5*4))*nAC, "10-  "+If (Empty(aDados[nX, 78]), "", dToc(aDados[nX, 78]))+"   ____________________________", oFont04)
		Endif

		oPrint:Line((nLinIni + 1930)*nAL + nLinA4, (nColIni + 0010)*nAC,(nLinIni + 1930)*nAL + nLinA4, (nColIni + nColMax - 0010)*nAC)
		oPrint:Line((nLinIni + 1930)*nAL + nLinA4, (nColIni + 0010)*nAC,(nLinIni + 2110)*nAL + nLinA4, (nColIni + 0010)*nAC)
		oPrint:Line((nLinIni + 1930)*nAL + nLinA4, (nColIni + nColMax - 0010)*nAC, (nLinIni + 2110)*nAL + nLinA4, (nColIni + nColMax - 0010)*nAC)
		oPrint:Line((nLinIni + 2110)*nAL + nLinA4, (nColIni + 0010)*nAC, (nLinIni + 2110)*nAL + nLinA4, (nColIni + nColMax - 0010)*nAC)
		oPrint:Say((nLinIni + 1925 + nLinA4)*nAL, (nColIni + 0020)*nAC, "58-Observação / Justificativa", oFont01) //58-Observação / Justificativa

		nLin := 0
       //Defino as variáveis para a consultada na BEA
		cOper := substr(aDados[nX, 2],1,4)
		cAno  := substr(aDados[nX, 2],6,4)
		cMes  := substr(aDados[nX, 2],11,2)
		cAut  := substr(aDados[nX, 2],14,8)

		//Realizo a consulta na BEA
		DbSelectArea("BEA")
		BEA->(dbSetOrder(1))
		BEA->(DbSeek(xFilial("BEA")+cOper+cAno+cMes+cAut))

		//acrescento na posição da observação o resultado da busca, pois estava vindo errado
		If PGETTISVER() < '3'//No caso da Tiss 3, considero a parametrizacao da estrutura de impressao B7B para o campo 58 - Observacao / Justificativa
			aDados[nX, 58] := BEA->BEA_MSG01 + BEA->BEA_MSG02
		EndIf

		For nI := 1 To MlCount(aDados[nX, 58])
			cObs := MemoLine(aDados[nX, 58], 200, nI)
			If cObs == ""
				exit
			Endif
			oPrint:Say((nLinIni + 1965 + nLinA4 + nLin)*nAL, (nColIni + 0030)*nAC, LOWERACE(cObs), oFont05)
			nLin += 50
		Next nI

		oPrint:Box((nLinIni + 2120)*nAL + nLinA4, (nColIni + 0010)*nAC, (nLinIni + 2196)*nAL + nLinA4, (nColIni + (nColMax/7) - 0010)*nAC)
		oPrint:Say((nLinIni + 2115 + nLinA4)*nAL, (nColIni + 0020)*nAC, "59 - Total de Procedimentos (R$)", oFont01) //59 - Total de Procedimentos (R$)
		oPrint:Say((nLinIni + 2155 + nLinA4)*nAL, (nColIni + 0030)*nAC, IIf(Empty(aDados[nX, 59]), "", Transform(aDados[nX, 59], "@E 99,999,999.99")), oFont04)
		oPrint:Box((nLinIni + 2120)*nAL + nLinA4, (nColIni + nColMax/7)*nAC, (nLinIni + 2196)*nAL + nLinA4, (nColIni + ((nColMax/7)*2) - 0010)*nAC)
		oPrint:Say((nLinIni + 2115 + nLinA4)*nAL, (nColIni + (nColMax/7) + 0010)*nAC, "60 - Total de Taxas e Aluguéis (R$)", oFont01) //60 - Total de Taxas e Aluguéis (R$)
		oPrint:Say((nLinIni + 2155 + nLinA4)*nAL, (nColIni + (nColMax/7) + 0020)*nAC, IIf(Empty(aDados[nX, 60]), "", Transform(aDados[nX, 60], "@E 99,999,999.99")), oFont04)
		oPrint:Box((nLinIni + 2120)*nAL + nLinA4, (nColIni + ((nColMax/7)*2))*nAC, (nLinIni + 2196)*nAL + nLinA4, (nColIni + ((nColMax/7)*3) - 0010)*nAC)
		oPrint:Say((nLinIni + 2115 + nLinA4)*nAL, (nColIni + ((nColMax/7)*2) + 0010)*nAC, "61 - Total de Materiais (R$)", oFont01) //61 - Total de Materiais (R$)
		oPrint:Say((nLinIni + 2155 + nLinA4)*nAL, (nColIni + ((nColMax/7)*2) + 0020)*nAC, IIf(Empty(aDados[nX, 61]), "", Transform(aDados[nX, 61], "@E 99,999,999.99")), oFont04)
		oPrint:Box((nLinIni + 2120)*nAL + nLinA4, (nColIni + ((nColMax/7)*3))*nAC, (nLinIni + 2196)*nAL + nLinA4, (nColIni + ((nColMax/7)*4) - 0010)*nAC)
		oPrint:Say((nLinIni + 2115 + nLinA4)*nAL, (nColIni + ((nColMax/7)*3) + 0010)*nAC, "62- Total de OPME (R$)", oFont01) //62- Total de OPME (R$)
		oPrint:Say((nLinIni + 2155 + nLinA4)*nAL, (nColIni + ((nColMax/7)*3) + 0020)*nAC, IIf(Empty(aDados[nX, 62]), "", Transform(aDados[nX, 62], "@E 99,999,999.99")), oFont04)
		oPrint:Box((nLinIni + 2120)*nAL + nLinA4, (nColIni + ((nColMax/7)*4))*nAC, (nLinIni + 2196)*nAL + nLinA4, (nColIni + ((nColMax/7)*5) - 0010)*nAC)
		oPrint:Say((nLinIni + 2115 + nLinA4)*nAL, (nColIni + ((nColMax/7)*4) + 0010)*nAC, "63 - Total de Medicamentos (R$)", oFont01) //63 - Total de Medicamentos (R$)
		oPrint:Say((nLinIni + 2155 + nLinA4)*nAL, (nColIni + ((nColMax/7)*4) + 0020)*nAC, IIf(Empty(aDados[nX, 63]), "", Transform(aDados[nX, 63], "@E 99,999,999.99")), oFont04)
		oPrint:Box((nLinIni + 2120)*nAL + nLinA4, (nColIni + ((nColMax/7)*5))*nAC, (nLinIni + 2196)*nAL + nLinA4, (nColIni + ((nColMax/7)*6) - 0010)*nAC)
		oPrint:Say((nLinIni + 2115 + nLinA4)*nAL, (nColIni + ((nColMax/7)*5) + 0010)*nAC, "64 - Total de Gases Medicinais (R$)", oFont01) //64 - Total de Gases Medicinais (R$)
		oPrint:Say((nLinIni + 2155 + nLinA4)*nAL, (nColIni + ((nColMax/7)*5) + 0020)*nAC, IIf(Empty(aDados[nX, 64]), "", Transform(aDados[nX, 64], "@E 99,999,999.99")), oFont04)
		oPrint:Box((nLinIni + 2120)*nAL + nLinA4, (nColIni + ((nColMax/7)*6))*nAC, (nLinIni + 2196)*nAL + nLinA4, (nColIni + nColMax - 0010)*nAC)
		oPrint:Say((nLinIni + 2115 + nLinA4)*nAL, (nColIni + ((nColMax/7)*6) + 0010)*nAC, "65 - Total Geral (R$)", oFont01) //65 - Total Geral (R$)
		oPrint:Say((nLinIni + 2155 + nLinA4)*nAL, (nColIni + ((nColMax/7)*6) + 0020)*nAC, IIf(Empty(aDados[nX, 65]), "", Transform(aDados[nX, 65], "@E 99,999,999.99")), oFont04)

		oPrint:Box((nLinIni + 2206)*nAL + nLinA4, (nColIni + 0010)*nAC, (nLinIni + 2284)*nAL + nLinA4, (nColIni + (nColMax/3) - 0010)*nAC)
		oPrint:Say((nLinIni + 2201 + nLinA4)*nAL, (nColIni + 0020)*nAC, "66 - Assinatura do Responsável pela Autorização", oFont01) //66 - Assinatura do Responsável pela Autorização
		oPrint:Box((nLinIni + 2206)*nAL + nLinA4, (nColIni + (nColMax/3))*nAC, (nLinIni + 2284)*nAL + nLinA4, (nColIni + ((nColMax/3)*2) - 0010)*nAC)
		oPrint:Say((nLinIni + 2201 + nLinA4)*nAL, (nColIni + (nColMax/3) + 0010)*nAC, "67 - Assinatura do Beneficiário ou Responsável", oFont01) //67 - Assinatura do Beneficiário ou Responsável
		oPrint:Box((nLinIni + 2206)*nAL + nLinA4, (nColIni + ((nColMax/3)*2))*nAC, (nLinIni + 2284)*nAL + nLinA4, (nColIni + nColMax - 0010)*nAC)
		oPrint:Say((nLinIni + 2201 + nLinA4)*nAL, (nColIni + ((nColMax/3)*2) + 0010)*nAC, "68 - Assinatura do Contratado", oFont01) //68 - Assinatura do Contratado

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
		//³Finaliza a pagina
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
		oPrint:EndPage()

	Next nX
EndDo

If lGerTXT .And. !lWeb
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
	//³Imprime Relatorio
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
	oPrint:Print()
Else
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
	//³Visualiza impressao grafica antes de imprimir
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
	oPrint:Preview()
EndIf

Return(cFileName)
*/
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡ao    ³ PLTISAOPME³ Autor ³ Bruno Iserhardt       ³ Data ³ 03.02.14 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡ao ³ Estrutura Relatório TISS 3 (Anexo de Solicitacao de Ortese, ³±±
±±³          ³ Proteses e Materiais Especiais)                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ SigaPLS                                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ aDados - Array com as informações do relat´rio              ³±±
±±³          ³ nLayout - Define o formato de papél para impressao:         ³±±
±±³          ³           1 - Formato Ofício II (216x330mm)                 ³±±
±±³          ³           2 - Formato A4 (210x297mm)                        ³±±
±±³          ³  		 3 - Formato Carta (216x279mm)     			       ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
/*
User Function PLTISAOPME(aDados, nLayout, cLogoGH,lWeb, cPathRelW,lUnicaImp)

Local nLinMax
Local nColMax
Local nLinIni	:=	0		// Linha Lateral (inicial) Esquerda
Local nColIni	:=	0		// Coluna Lateral (inicial) Esquerda
Local nColA4    := 	0
Local nLinOld	:=	0
Local nWeb		:=  0
Local lImpNovo := .T.
Local cFileLogo
Local lPrinter := .F.
Local nAte := 0
Local nI, nJ, nN, nV
Local nX, nX1
Local oFont01
Local oFont02n
Local oFont03n
Local oFont04
Local cObs
Local cRel      := "guiopme"
Local cPathSrvJ := GETMV("MV_RELT")
Local nTweb		:= 1
Local nLweb		:= 0
Local nLwebC	:= 0
Local oPrint	:= NIL

Default lUnicaImp := .F.
Default lWeb    := .F.
Default cPathRelW := ''
Default nLayout := 2
Default cLogoGH := ''
Default	aDados  := { {;
	"123456",; //1 - Registro ANS
	{"01234567890123456789"},; //2 - N Guia no Prestador
	{"01234567890123456789"},; //3 - Numero da Guia Referenciada
	{"01234567890123456789"},; //4 - Senha
	{CtoD("03/02/14")},; //5 - Data da Autorizacao
	{"01234567890123456789"},; //6 - Numero da Guia Atribuido pela Operadora
	{"01234567890123456789"},; //7 - Numero da Carteira
	{Replicate("M", 70)},; //8 - Nome
	{Replicate("M", 70)},; //9- Nome do Profissional Solicitante
	{"01234567890"},; //10 - Telefone
	{Replicate("M", 60)},; //11 - E-mail
	{Replicate("M", 1000)},; //12 - Justificativa Tecnica
	{{"99", "01","99", "01","99", "01"}},; //13-Tabela
	{{"0123456789", "0123456789","0123456789", "0123456789","0123456789", "0123456789"}},; //14-Codigo do Material
	{{Replicate("M", 150), Replicate("M", 150),Replicate("M", 150), Replicate("M", 150),Replicate("M", 150), Replicate("M", 150)}},; //15-Descricao
	{{"0", "9","0", "9","0", "9"}},; //16-Opcao
	{{123, 999, 123, 999, 123, 999}},; //17-Qtde. Solicitada
	{{123456.78, 999999.99,123456.78, 999999.99,123456.78, 999999.99}},; //18-Valor Unitario Solicitado
	{{123, 999, 123, 999, 123, 999}},; //19-Qtde. Autorizada
	{{123456.78, 999999.99, 123456.78, 999999.99, 123456.78, 999999.99}},; //20-Valor Unitario Autorizado
	{{"012345678901234","012345678901234","012345678901234","012345678901234","012345678901234","012345678901234"}},; //21-Registro ANVISA do Material
	{{Replicate("M", 30), Replicate("9", 30), Replicate("M", 30), Replicate("9", 30), Replicate("M", 30), Replicate("9", 30)}},; //22-Referencia do material no fabricante
	{{Replicate("M", 30), Replicate("9", 30), Replicate("M", 30), Replicate("9", 30), Replicate("9", 30), Replicate("9", 30)}},; //23-N Autorizacao de Funcionamento
	{Replicate("M", 500)},; //24 - Especificacao do Material
	{Replicate("M", 500)},; //25- Observacao / Justificativa
	{CtoD("03/02/14")},; //26 - Data da Solicitacao
	{""},; //27- Assinatura do Profissional Solicitante
	{""} } } //28- Assinatura do Responsavel pela Autorizacao

If nLayout  == 1 // Ofício 2
	nLinMax := 2435
	nColMax := 3705
Elseif nLayout == 2   // Papél A4
	nLinMax	:=	2275
	nColMax	:=	3270
Else //Carta
	nLinMax	:=	2435
	nColMax	:=	3175
Endif

oFont01		:= TFont():New("Arial",  6,  6, , .F., , , , .T., .F.) // Normal
if nLayout == 1 // Oficio 2
	oFont02n	:= TFont():New("Arial", 12, 12, , .T., , , , .T., .F.) // Negrito
	oFont03n	:= TFont():New("Arial", 14, 14, , .T., , , , .T., .F.) // Negrito
	oFont04		:= TFont():New("Arial", 09, 09, , .F., , , , .T., .F.) // Normal
Else  // Papél A4 ou Carta
	oFont02n	:= TFont():New("Arial", 11, 11, , .T., , , , .T., .F.) // Negrito
	oFont03n	:= TFont():New("Arial", 13, 13, , .T., , , , .T., .F.) // Negrito
	oFont04		:= TFont():New("Arial", 08, 08, , .F., , , , .T., .F.) // Normal
Endif

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
	//³ Nao permite acionar a impressao quando for na web.
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
If lWeb
	cPathSrvJ := cPathRelW
	cFileName := cRel+lower(CriaTrab(NIL,.F.))+".pdf"
Else
	cFileName := cRel+CriaTrab(NIL,.F.)
EndIf

if !lWeb
	oPrint	:= TMSPrinter():New("ANEXO DE SOLICITAÇÃO DE ÓRTESES, PRÓTESES E MATERIAIS ESPECIAIS - OPME") //ANEXO DE SOLICITAÇÃO DE ÓRTESES, PRÓTESES E MATERIAIS ESPECIAIS - OPME
else
	oPrint := FWMSPrinter():New ( cFileName	,,.F.,cPathSrvJ	 ,.T.,	,@oPrint,			  ,			  ,	.F.			,.f.)
	If lSrvUnix
		AjusPath(@oPrint)
	EndIf
	oPrint:cPathPDF := cPathSrvJ
	nTweb		:= 3.9
	nLweb		:= 10
	nLwebC		:= -3
	nColMax		:= 3100
	nWeb		:= 25
	oPrint:lServer := lWeb
Endif


oPrint:SetLandscape()		// Modo paisagem

if nLayout ==2
	oPrint:SetPaperSize(9)// Papél A4
Elseif nLayout ==3
	oPrint:SetPaperSize(1)// Papél Carta
Else
	oPrint:SetPaperSize(14) //Papel Oficio2 216 x 330mm / 8 1/2 x 13in
Endif

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
	//³Device
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
If lWeb
	oPrint:setDevice(IMP_PDF)
Else
		// Verifica se existe alguma impressora configurada para Impressao Grafica
	lPrinter := oPrint:IsPrinterActive()
	IF lPrinter
		lPrinter := IIF(GETNEWPAR("MV_IMPATIV", .F.), .F., .T.)	//	Define se irá alterar a Impressora Ativa
	ENDIF
	If ! lPrinter
		oPrint:Setup()
	EndIf
Endif

For nX := 1 To Len(aDados)

	If ValType(aDados[nX]) == 'U' .OR. Len(aDados[nX]) == 0
		Loop
	EndIf



	For nX1 := 1 To Len(aDados[nX, 02])

		nAte := 6
		nV := 1

		//Esta parte do código faz com que
		//imprima mais de uma guia.
		//INICIO
		If lUnicaImp
			If nX1 <= Len(aDados)
				lImpNovo := .T.
			EndIf
		EndIf
		//FIM

		While lImpNovo

			lImpNovo := .F.

			For nI:= 13 To 23
				If Len(aDados[nX, nI, nX1]) < nAte
					For nJ := Len(aDados[nX, nI, nX1]) + 1 To nAte
						If AllTrim(Str(nI)) $ "17,18,19,20"
							aAdd(aDados[nX, nI, nX1], 0)
						Else
							aAdd(aDados[nX, nI, nX1],"")
						EndIf
					Next nJ
				EndIf
			Next nI

			nLinIni  := 080
			nColIni  := 080
			nColA4   := 000

			oPrint:StartPage()		// Inicia uma nova pagina
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Box Principal                                                 ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			oPrint:Box((nLinIni + 0000)/nTweb, (nColIni + 0000)/nTweb, (nLinIni + nLinMax)/nTweb, (nColIni + nColMax)/nTweb)

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Carrega e Imprime Logotipo da Empresa                         ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			fLogoEmp(@cFileLogo,, cLogoGH)

			If File(cFilelogo)
				oPrint:SayBitmap((nLinIni + 0050)/nTweb, (nColIni + 0020)/nTweb, cFileLogo, 400/nTweb, 090/nTweb) 		// Tem que estar abaixo do RootPath
			EndIf

			If nLayout == 2 // Papél A4
				nColA4    := -0335
			Elseif nLayout == 3// Carta
				nColA4    := -0530
			Endif

			oPrint:Say((nLinIni + 0080)/nTweb, ((nColIni + nColMax)*0.46)/nTweb, "ANEXO DE SOLICITAÇÃO DE ÓRTESES, PRÓTESES E", oFont02n,,,, 2) //ANEXO DE SOLICITAÇÃO DE ÓRTESES, PRÓTESES E MATERIAIS ESPECIAIS - OPME
			oPrint:Say((nLinIni + 0120)/nTweb, ((nColIni + nColMax)*0.47)/nTweb, "MATERIAIS ESPECIAIS - OPME", oFont02n,,,, 2)
			oPrint:Say((nLinIni + 0090)/nTweb, (nColMax - 750)/nTweb, "2- Nº Guia no Prestador", oFont01) //2- Nº Guia no Prestador
			oPrint:Say((nLinIni + 0070)/nTweb, (nColMax - 480)/nTweb, aDados[nX, 02, nX1], oFont03n)

			fSomaLin(nLinMax, nColMax, @nLinIni, nColIni, 80, 80)
			oPrint:Box((nLinIni + 0175 - nWeb)/nTweb, (nColIni + 0010)/nTweb, (nLinIni + 0269 -nWeb)/nTweb, ((nColIni + nColMax)*0.1 - 0010)/nTweb)
			oPrint:Say((nLinIni + 0180)/nTweb, (nColIni + 0020)/nTweb, "1 - Registro ANS", oFont01) //1 - Registro ANS
			oPrint:Say((nLinIni + 0220)/nTweb, (nColIni + 0030)/nTweb, aDados[nX, 01], oFont04)
			oPrint:Box((nLinIni + 0175 - nWeb)/nTweb, ((nColIni + nColMax)*0.1)/nTweb, (nLinIni + 0269 - nWeb)/nTweb, ((nColIni + nColMax)*0.35 - 0010)/nTweb)
			oPrint:Say((nLinIni + 0180)/nTweb, ((nColIni + nColMax)*0.1 + 0020)/nTweb, "3 - Número da Guia Referenciada", oFont01) //3 - Número da Guia Referenciada
			oPrint:Say((nLinIni + 0220)/nTweb, ((nColIni + nColMax)*0.1 + 0030)/nTweb, aDados[nX, 03, nX1], oFont04)
			oPrint:Box((nLinIni + 0175 - nWeb)/nTweb, ((nColIni + nColMax)*0.35)/nTweb, (nLinIni + 0269 - nWeb)/nTweb, ((nColIni + nColMax)*0.6 - 0010)/nTweb)
			oPrint:Say((nLinIni + 0180)/nTweb, ((nColIni + nColMax)*0.35 + 0020)/nTweb, "4 - Senha", oFont01) //4 - Senha
			oPrint:Say((nLinIni + 0220)/nTweb, ((nColIni + nColMax)*0.35 + 0030)/nTweb, aDados[nX, 04, nX1], oFont04)
			oPrint:Box((nLinIni + 0175 - nWeb)/nTweb, ((nColIni + nColMax)*0.6)/nTweb, (nLinIni + 0269 - nWeb)/nTweb, ((nColIni + nColMax)*0.75 - 0010)/nTweb)
			oPrint:Say((nLinIni + 0180)/nTweb, ((nColIni + nColMax)*0.6 + 0020)/nTweb, "5 - Data da Autorização", oFont01) //5 - Data da Autorização
			oPrint:Say((nLinIni + 0220)/nTweb, ((nColIni + nColMax)*0.6 + 0030)/nTweb, DToC(aDados[nX, 05, nX1]), oFont04)
			oPrint:Box((nLinIni + 0175 -nWeb)/nTweb, ((nColIni + nColMax)*0.75)/nTweb, (nLinIni + 0269 -nWeb)/nTweb, (nColIni + nColMax - 0010)/nTweb)
			oPrint:Say((nLinIni + 0180)/nTweb, ((nColIni + nColMax)*0.75 + 0020)/nTweb, "6 - Número da Guia Atribuído pela Operadora", oFont01) //6 - Número da Guia Atribuído pela Operadora
			oPrint:Say((nLinIni + 0220)/nTweb, ((nColIni + nColMax)*0.75 + 0030)/nTweb, aDados[nX, 06, nX1], oFont04)

			fSomaLin(nLinMax, nColMax, @nLinIni, nColIni, 100, 0)
			AddTBrush(oPrint, (nLinIni + 175)/nTweb, (nColIni + 0010)/nTweb, (nLinIni + 206)/nTweb, (nColIni + nColMax)/nTweb)
			oPrint:Say((nLinIni + 178)/nTweb, (nColIni + 0020)/nTweb, "Dados do Beneficiário", oFont01) //Dados do Prestador
			oPrint:Box((nLinIni + 207 - nWeb)/nTweb, (nColIni + 0010)/nTweb, (nLinIni + 300- nWeb)/nTweb, ((nColIni + nColMax)*0.25 - 0010)/nTweb)
			oPrint:Say((nLinIni + 212)/nTweb, (nColIni + 0020)/nTweb, "7 - Número da Carteira", oFont01) //7 - Número da Carteira
			oPrint:Say((nLinIni + 252)/nTweb, (nColIni + 0030)/nTweb, aDados[nX, 07, nX1], oFont04)
			oPrint:Box((nLinIni + 207 - nWeb)/nTweb, ((nColIni + nColMax)*0.25)/nTweb, (nLinIni + 300- nWeb)/nTweb, (nColIni + nColMax - 0010)/nTweb)
			oPrint:Say((nLinIni + 212)/nTweb, ((nColIni + nColMax)*0.25 + 0020)/nTweb, "8 - Nome", oFont01) //8 - Nome
			oPrint:Say((nLinIni + 252)/nTweb, ((nColIni + nColMax)*0.25 + 0030)/nTweb, aDados[nX, 08, nX1], oFont04)

			fSomaLin(nLinMax, nColMax, @nLinIni, nColIni, 130, 80)
			AddTBrush(oPrint,  (nLinIni + 174)/nTweb, (nColIni + 0010)/nTweb, (nLinIni + 205)/nTweb, (nColIni + nColMax)/nTweb)
			oPrint:Say((nLinIni + 178)/nTweb, (nColIni + 0020)/nTweb, "Dados do Profissional Solicitante", oFont01) //Dados do Profissional Solicitante
			oPrint:Box((nLinIni + 207- nWeb)/nTweb, (nColIni + 0010)/nTweb, (nLinIni + 300- nWeb)/nTweb, ((nColIni + nColMax)*0.5 - 0010)/nTweb)
			oPrint:Say((nLinIni + 212)/nTweb, (nColIni + 0020)/nTweb, "9- Nome do Profissional Solicitante", oFont01) //9- Nome do Profissional Solicitante
			oPrint:Say((nLinIni + 252)/nTweb, (nColIni + 0030)/nTweb, aDados[nX, 09, nX1], oFont04)
			oPrint:Box((nLinIni + 207- nWeb)/nTweb, ((nColIni + nColMax)*0.5)/nTweb, (nLinIni + 300- nWeb)/nTweb, ((nColIni + nColMax)*0.6 - 0010)/nTweb)
			oPrint:Say((nLinIni + 212)/nTweb, ((nColIni + nColMax)*0.5 + 0020)/nTweb, "10 - Telefone", oFont01) //10 - Telefone
			oPrint:Say((nLinIni + 252)/nTweb, ((nColIni + nColMax)*0.5 + 0030)/nTweb, aDados[nX, 10, nX1], oFont04)
			oPrint:Box((nLinIni + 207- nWeb)/nTweb, ((nColIni + nColMax)*0.6)/nTweb, (nLinIni + 300- nWeb)/nTweb, (nColIni + nColMax - 0010)/nTweb)
			oPrint:Say((nLinIni + 212)/nTweb, ((nColIni + nColMax)*0.6 + 0020)/nTweb, "11 - E-mail", oFont01) //11 - E-mail
			oPrint:Say((nLinIni + 252)/nTweb, ((nColIni + nColMax)*0.6 + 0030)/nTweb, aDados[nX, 11, nX1], oFont04)

			fSomaLin(nLinMax, nColMax, @nLinIni, nColIni, 130, 80)
			AddTBrush(oPrint, (nLinIni + 175)/nTweb, (nColIni + 0010)/nTweb, (nLinIni + 206)/nTweb, (nColIni + nColMax)/nTweb)
			oPrint:Say((nLinIni + 178)/nTweb, (nColIni + 0020)/nTweb, "Dados da Cirurgia", oFont01) //Dados da Cirurgia
			oPrint:Box((nLinIni + 209- nWeb)/nTweb, (nColIni + 0010)/nTweb, (nLinIni + 660- nWeb)/nTweb, (nColIni + nColMax - 0010)/nTweb)
			oPrint:Say((nLinIni + 214)/nTweb, (nColIni + 0020)/nTweb, "12 - Justificativa Técnica", oFont01) //12 - Justificativa Técnica

			nLinOld := nLinIni

			For nI := 1 To MlCount(aDados[nX, 12, nX1], 130)
				cObs := MemoLine(aDados[nX, 12, nX1], 130, nI)
				oPrint:Say((nLinIni + 252)/nTweb, (nColIni + 0020)/nTweb, cObs, oFont04)
				nLinIni += 40
				If nI == 10
					exit //trunco para nao desconfigurar o relatorio
				Endif
			Next nI

			nLinIni := nLinOld + 400

			fSomaLin(nLinMax, nColMax, @nLinIni, nColIni, 100, 80)
			AddTBrush(oPrint, (nLinIni + 165)/nTweb, (nColIni + 0010)/nTweb, (nLinIni + 200)/nTweb, (nColIni + nColMax)/nTweb)
			oPrint:Say((nLinIni + 168)/nTweb, (nColIni + 0020)/nTweb, "OPME Solicitadas", oFont01) //OPME Solicitadas

			oPrint:Box((nLinIni + 204- nWeb)/nTweb, (nColIni + 0010)/nTweb, (nLinIni + 790- nWeb)/nTweb, (nColIni + nColMax - 0010)/nTweb)
			oPrint:Say((nLinIni + 210)/nTweb, (nColIni + 0040)/nTweb, "13-Tabela", oFont01) //13-Tabela
			oPrint:Say((nLinIni + 210)/nTweb, ((nColIni + nColMax)*0.07)/nTweb, "14-Código do Material", oFont01) //14-Código do Material
			oPrint:Say((nLinIni + 210)/nTweb, ((nColIni + nColMax)*0.15)/nTweb, "15-Descrição", oFont01) //15-Descrição
			oPrint:Say((nLinIni + 210)/nTweb, ((nColIni + nColMax)*0.45)/nTweb, "16-Opção", oFont01) //16-Opção
			oPrint:Say((nLinIni + 210)/nTweb, ((nColIni + nColMax)*0.55)/nTweb, "17- Qtde. Sol.", oFont01,,,,1) //17- Qtde. Solicitada
			oPrint:Say((nLinIni + 210)/nTweb, ((nColIni + nColMax)*0.66)/nTweb, "18- Valor Unitário Solicitado", oFont01,,,,1) //18- Valor Unitário Solicitado
			oPrint:Say((nLinIni + 210)/nTweb, ((nColIni + nColMax)*0.80)/nTweb, "19- Qtde. Aut.", oFont01,,,,1) //19- Qtde. Autorizada
			oPrint:Say((nLinIni + 210)/nTweb, ((nColIni + nColMax)*0.90)/nTweb, "20- Valor Unitário Autorizado", oFont01,,,,1) //20- Valor Unitário Autorizado

			oPrint:Say((nLinIni + 235)/nTweb, (nColIni + 0040)/nTweb, "21-Registro ANVISA do Material", oFont01) //21-Registro ANVISA do Material
			oPrint:Say((nLinIni + 235)/nTweb, ((nColIni + nColMax)*0.2)/nTweb, "22-Referência do material no fabricante", oFont01) //22-Referência do material no fabricante
			oPrint:Say((nLinIni + 235)/nTweb, ((nColIni + nColMax)*0.6)/nTweb, "23-Nº Autorização de Funcionamento", oFont01) //23-Nº Autorização de Funcionamento

			For nN := nV To nAte

				oPrint:Say((nLinIni + 270)/nTweb, (nColIni + 0012)/nTweb, AllTrim(Str(nN)) + " - ", oFont01)
				oPrint:Say((nLinIni + 270)/nTweb, (nColIni + 0040)/nTweb, aDados[nX, 13, nX1, nN], oFont04)
				oPrint:Say((nLinIni + 270)/nTweb, ((nColIni + nColMax)*0.07)/nTweb, aDados[nX, 14, nX1, nN], oFont04)
				oPrint:Say((nLinIni + 270)/nTweb, ((nColIni + nColMax)*0.15)/nTweb, aDados[nX, 15, nX1, nN], oFont04)
				oPrint:Say((nLinIni + 270)/nTweb, ((nColIni + nColMax)*0.45)/nTweb, aDados[nX, 16, nX1, nN], oFont04)
				oPrint:Say((nLinIni + 270)/nTweb, ((nColIni + nColMax)*0.55)/nTweb, IIf(Empty(aDados[nX, 17, nX1, nN]), "", Transform(aDados[nX, 17, nX1, nN], "@E 9999.99")), oFont04,,,,1)
				oPrint:Say((nLinIni + 270)/nTweb, ((nColIni + nColMax)*0.66)/nTweb, IIf(Empty(aDados[nX, 18, nX1, nN]), "", Transform(aDados[nX, 18, nX1, nN], "@E 999,999,999.99")), oFont04,,,,1)
				oPrint:Say((nLinIni + 270)/nTweb, ((nColIni + nColMax)*0.80)/nTweb, IIf(Empty(aDados[nX, 19, nX1, nN]), "", Transform(aDados[nX, 19, nX1, nN], "@E 9999.99")), oFont04,,,,1)
				oPrint:Say((nLinIni + 270)/nTweb, ((nColIni + nColMax)*0.90)/nTweb, IIf(Empty(aDados[nX, 20, nX1, nN]), "", Transform(aDados[nX, 20, nX1, nN], "@E 999,999,999.99")), oFont04,,,,1)

				oPrint:Say((nLinIni + 305)/nTweb, (nColIni + 0040)/nTweb, aDados[nX, 21, nX1, nN], oFont04)
				oPrint:Say((nLinIni + 305)/nTweb, ((nColIni + nColMax)*0.2)/nTweb, aDados[nX, 22, nX1, nN], oFont04)
				oPrint:Say((nLinIni + 305)/nTweb, ((nColIni + nColMax)*0.6)/nTweb, aDados[nX, 23, nX1, nN], oFont04)

				fSomaLin(nLinMax, nColMax, @nLinIni, nColIni, 85, 60)
			Next

			If nAte < Len(aDados[nX, 13, nX1])
				lImpNovo := .T.
				nAte += 6
				nV := nN
			EndIf

			nLinIni := 1530

			fSomaLin(nLinMax, nColMax, @nLinIni, nColIni, 120, 80)
			oPrint:Box((nLinIni + 178- nWeb)/nTweb, (nColIni + 0010)/nTweb, (nLinIni + 370- nWeb)/nTweb, (nColIni + nColMax - 0010)/nTweb)
			oPrint:Say((nLinIni + 183)/nTweb, (nColIni + 0020)/nTweb, "24 - Especificação do Material", oFont01) //24 - Especificação do Material

			nLinOld := nLinIni

			For nI := 1 To MlCount(aDados[nX, 24, nX1], 130)
				cObs := MemoLine(aDados[nX, 24, nX1], 130, nI)
				oPrint:Say((nLinIni + 210)/nTweb, (nColIni + 0020)/nTweb, cObs, oFont04)
				nLinIni += 40
				If nI == 4
					exit //trunco para nao desconfigurar o relatorio
				Endif
			Next nI

			nLinIni := nLinOld + 160

			fSomaLin(nLinMax, nColMax, @nLinIni, nColIni, 50, 80)
			AddTBrush(oPrint, (nLinIni + 178)/nTweb, (nColIni + 0010)/nTweb, (nLinIni + 370)/nTweb, (nColIni + nColMax - 0010)/nTweb)
			oPrint:Box((nLinIni + 178- nWeb)/nTweb, (nColIni + 0010)/nTweb, (nLinIni + 370- nWeb)/nTweb, (nColIni + nColMax - 0010)/nTweb)
			oPrint:Say((nLinIni + 183)/nTweb, (nColIni + 0020)/nTweb, "25- Observação / Justificativa", oFont01) //25- Observação / Justificativa

			nLinOld := nLinIni

			For nI := 1 To MlCount(aDados[nX, 25, nX1], 130)
				cObs := MemoLine(aDados[nX, 25, nX1], 130, nI)
				oPrint:Say((nLinIni + 210)/nTweb, (nColIni + 0020)/nTweb, cObs, oFont04)
				nLinIni += 40
				If nI == 4
					exit //trunco para nao desconfigurar o relatorio
				Endif
			Next nI

			nLinIni := nLinOld + 160

			fSomaLin(nLinMax, nColMax, @nLinIni, nColIni, 50, 80)
			oPrint:Box((nLinIni + 178- nWeb)/nTweb, (nColIni + 0010)/nTweb, (nLinIni + 272- nWeb)/nTweb, ((nColIni + nColMax)*0.15 - 0010)/nTweb)
			oPrint:Say((nLinIni + 183)/nTweb, (nColIni + 0020)/nTweb, "26 - Data da Solicitação", oFont01) //26 - Data da Solicitação
			oPrint:Say((nLinIni + 223)/nTweb, (nColIni + 0030 + 0030)/nTweb, DtoC(aDados[nX, 26, nX1]), oFont04)
			oPrint:Box((nLinIni + 178- nWeb)/nTweb, ((nColIni + nColMax)*0.15)/nTweb, (nLinIni + 272- nWeb)/nTweb, ((nColIni + nColMax)*0.55 - 0010)/nTweb)
			oPrint:Say((nLinIni + 183)/nTweb, ((nColIni + nColMax)*0.15 + 0020)/nTweb, "27- Assinatura do Profissional Solicitante", oFont01) //27- Assinatura do Profissional Solicitante
			oPrint:Box((nLinIni + 178- nWeb)/nTweb, ((nColIni + nColMax)*0.55)/nTweb, (nLinIni + 272- nWeb)/nTweb, (nColIni + nColMax - 0010)/nTweb)
			oPrint:Say((nLinIni + 183)/nTweb, ((nColIni + nColMax)*0.55 + 0020)/nTweb, "28- Assinatura do Responsável pela Autorização", oFont01) //28- Assinatura do Responsável pela Autorização

			oPrint:EndPage()	// Finaliza a pagina

		EndDo

	Next nX1


Next nX

If lWeb
	oPrint:Print()
Else
	oPrint:Preview()
Endif

Return cFileName
*/
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡ao    ³ PLTISAQUIM³ Autor ³ Bruno Iserhardt       ³ Data ³ 05.02.14 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡ao ³ Estrutura Relatório TISS 3 (Anexo de Solicitacao de         ³±±
±±³          ³ Quimioterapia)                                               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ SigaPLS                                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ aDados - Array com as informações do relat´rio              ³±±
±±³          ³ nLayout - Define o formato de papél para impressao:         ³±±
±±³          ³           1 - Formato Ofício II (216x330mm)                 ³±±
±±³          ³           2 - Formato A4 (210x297mm)                        ³±±
±±³          ³  		 3 - Formato Carta (216x279mm)     			       ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
/*
Function PLTISAQUIM(aDados, nLayout, cLogoGH,lWeb, cPathRelW,lUnicaImp)

Local nLinMax
Local nColMax
Local nLinIni	:=	0		// Linha Lateral (inicial) Esquerda
Local nColIni	:=	0		// Coluna Lateral (inicial) Esquerda
Local nOldLin	:=	0
Local nColA4    := 	0
Local nWeb		:= 0
Local cFileLogo
Local lImpNovo := .T.
Local lPrinter := .F.
Local nI, nJ, nN, nV
Local nX, nX1
Local oFont01
Local oFont02n
Local oFont03n
Local oFont04
Local cObs
Local cRel      := "guiaquim"
Local cPathSrvJ := GETMV("MV_RELT")
Local nTweb		:= 1
Local nLweb		:= 0
Local nLwebC	:= 0
Local oPrint	:= NIL

Default lUnicaImp := .F.
Default lWeb    := .F.
Default cPathRelW := ''
Default nLayout := 2
Default cLogoGH := ''
Default	aDados  := { {;
	"123456",; //1 - Registro ANS
	{"01234567890123456789"},; //2 - N Guia no Prestador
	{"01234567890123456789"},; //3 - Numero da Guia Referenciada
	{"01234567890123456789"},; //4 - Senha
	{CtoD("03/02/14")},; //5 - Data da Autorizacao
	{"01234567890123456789"},; //6 - Numero da Guia Atribuido pela Operadora
	{"01234567890123456789"},; //7 - Número da Carteira
	{Replicate("M", 70)},; //8 - Nome
	{999.99},; //9 - Peso (Kg)
	{999.99},; //10 - Altura (Cm)
	{99.99},; //11 - Superfície Corporal (m²)
	{999},; //12 - Idade
	{"M"},; //13 - Sexo
	{Replicate("M", 70)},; //14 - Nome do Profissional Solicitante
	{"01234567890"},; //15 - Telefone
	{Replicate("M", 60)},; //16 - E-mail
	{CtoD("05/02/2014")},; //17 - Data do diagnóstico
	{"9999"},; //18 - CID 10 Principal
	{"9999"},; //19 - CID 10 (2)
	{"9999"},; //20 - CID 10 (3)
	{"9999"},; //21 - CID 10 (4)
	{"1"},; //22 - Estadiamento
	{"1"},; //23 - Tipo de Quimioterapia
	{"1"},; //24 - Finalidade
	{"1"},; //25 - ECOG
	{Replicate("M", 1000)},; //26 - PlanoTerapêutico
	{Replicate("M", 1000)},; //27 - Diagnóstico Cito/Histopatológico
	{Replicate("M", 1000)},; //28 - Informações relevantes
	{{CtoD("05/02/2014"),CtoD("05/02/2014"),CtoD("05/02/2014"),CtoD("05/02/2014"),CtoD("05/02/2014"),CtoD("05/02/2014"),CtoD("05/02/2014"),CtoD("05/02/2014")}},; //29-Data Prevista para Administração
	{{"99","99","99","99","99","99","99","99"}},; //30-Tabela
	{{"0123456789","0123456789","0123456789","0123456789","0123456789","0123456789","0123456789","0123456789"}},; //31-Código do Medicamento
	{{Replicate("M", 150),Replicate("M", 150),Replicate("M", 150),Replicate("M", 150),Replicate("M", 150),Replicate("M", 150),Replicate("M", 150),Replicate("M", 150)}},; //32-Descrição
	{{999.99, 999.99, 999.99, 999.99, 999.99, 999.99, 111.11, 222.22}},; //33-Doses
	{{"99", "99", "99", "99", "99", "99", "99", "99"}},; //34-Via Adm
	{{99, 99, 99, 99, 99, 99, 11, 22}},; //35-Frequência
	{Replicate("M", 40)},; //36- Cirurgia
	{CtoD("05/02/2014")},; //37 - Data da Realização
	{Replicate("M", 40)},; //38 - Área Irradiada
	{CtoD("05/02/2014")},; //39 - Data da Aplicação
	{Replicate("M", 500)},; //40 - Observação
	{99},; //41 - Número de Ciclos Previstos
	{99},; //42 - Ciclo Atual
	{999},; //43-Intervalo entre Ciclos ( em dias)
	{CtoD("05/02/2014")},; //44 - Data da Solicitação
	{""},; //45-Assinatura do Profissional Solicitante
	{""} } } //46-Assinatura do Responsável pela Autorização

If nLayout  == 1 // Ofício 2
	nLinMax := 2435
	nColMax := 3705
Elseif nLayout == 2   // Papél A4
	nLinMax	:=	2275
	nColMax	:=	3270
Else //Carta
	nLinMax	:=	2435
	nColMax	:=	3175
Endif

if lWeb
	oFont01		:= TFont():New("Arial",  4,  4, , .F., , , , .T., .F.) // Normal
else
	oFont01		:= TFont():New("Arial",  5,  5, , .F., , , , .T., .F.) // Normal
End if
if nLayout == 1 // Oficio 2
	oFont02n	:= TFont():New("Arial", 12, 12, , .T., , , , .T., .F.) // Negrito
	oFont03n	:= TFont():New("Arial", 14, 14, , .T., , , , .T., .F.) // Negrito
	oFont04		:= TFont():New("Arial", 09, 09, , .F., , , , .T., .F.) // Normal
Else  // Papél A4 ou Carta
	oFont02n	:= TFont():New("Arial", 11, 11, , .T., , , , .T., .F.) // Negrito
	oFont03n	:= TFont():New("Arial", 13, 13, , .T., , , , .T., .F.) // Negrito
	oFont04		:= TFont():New("Arial", 08, 08, , .F., , , , .T., .F.) // Normal
Endif

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
	//³ Nao permite acionar a impressao quando for na web.
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
If lWeb
	cPathSrvJ := cPathRelW
	cFileName := cRel+lower(CriaTrab(NIL,.F.))+".pdf"
Else
	cFileName := cRel+CriaTrab(NIL,.F.)
EndIf

if !lWeb
	oPrint	:= TMSPrinter():New("ANEXO DE SOLICITAÇÃO DE QUIMIOTERAPIA") //ANEXO DE SOLICITAÇÃO DE QUIMIOTERAPIA
	nWeb	:= 0
else
	oPrint := FWMSPrinter():New ( cFileName	,,.F.,cPathSrvJ	 ,.T.,	,@oPrint,			  ,			  ,	.F.			,.f.)
	If lSrvUnix
		AjusPath(@oPrint)
	EndIf
	oPrint:cPathPDF := cPathSrvJ
	nTweb		:= 3.9
	nLweb		:= 10
	nLwebC		:= -3
	nColMax		:= 3100
	nWeb		:= 25
	oPrint:lServer := lWeb
Endif


oPrint:SetLandscape()		// Modo paisagem

if nLayout ==2
	oPrint:SetPaperSize(9)// Papél A4
Elseif nLayout ==3
	oPrint:SetPaperSize(1)// Papél Carta
Else
	oPrint:SetPaperSize(14) //Papel Oficio2 216 x 330mm / 8 1/2 x 13in
Endif

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
	//³Device
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
If lWeb
	oPrint:setDevice(IMP_PDF)
Else
		// Verifica se existe alguma impressora configurada para Impressao Grafica
	lPrinter := oPrint:IsPrinterActive()
	IF lPrinter
		lPrinter := IIF(GETNEWPAR("MV_IMPATIV", .F.), .F., .T.)	//	Define se irá alterar a Impressora Ativa
	ENDIF
	If ! lPrinter
		oPrint:Setup()
	EndIf
Endif

For nX := 1 To Len(aDados)

	If ValType(aDados[nX]) == 'U' .OR. Len(aDados[nX]) == 0
		Loop
	EndIf

	For nX1 := 1 To Len(aDados[nX, 02])

		nAte := 8
		nV := 1

		//Esta parte do código faz com que
		//imprima mais de uma guia.
		//INICIO
		If lUnicaImp
			If nX1 <= Len(aDados)
				lImpNovo := .T.
			EndIf
		EndIf
		//FIM

		While lImpNovo

			lImpNovo := .F.

			For nI:= 29 To 35
				If Len(aDados[nX, nI, nX1]) < nAte
					For nJ := Len(aDados[nX, nI, nX1]) + 1 To nAte
						If AllTrim(Str(nI)) $ "33,35"
							aAdd(aDados[nX, nI, nX1], 0)
						ElseIf AllTrim(Str(nI)) $ "29"
							aAdd(aDados[nX, nI, nX1], CtoD(""))
						Else
							aAdd(aDados[nX, nI, nX1],"")
						EndIf
					Next nJ
				EndIf
			Next nI

			nLinIni  := 080
			nColIni  := 080
			nColA4   := 000

			oPrint:StartPage()		// Inicia uma nova pagina
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³Box Principal                                                 ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			oPrint:Box((nLinIni + 0000)/nTWeb, (nColIni + 0000)/nTWeb, (nLinIni + nLinMax)/nTWeb, (nColIni + nColMax)/nTWeb)

				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³Carrega e Imprime Logotipo da Empresa                         ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			fLogoEmp(@cFileLogo,, cLogoGH)

			If File(cFilelogo)
				oPrint:SayBitmap((nLinIni + 0050)/nTWeb, (nColIni + 0020)/nTWeb, cFileLogo, (400)/nTWeb, (090)/nTWeb) 		// Tem que estar abaixo do RootPath
			EndIf

			If nLayout == 2 // Papél A4
				nColA4    := -0335
			Elseif nLayout == 3// Carta
				nColA4    := -0530
			Endif

			nLinIni += 70

			oPrint:Say((nLinIni + 0010)/nTWeb, ((nColIni + nColMax)*0.47)/nTWeb, "ANEXO DE SOLICITAÇÃO DE QUIMIOTERAPIA", oFont02n,,,, 2) //ANEXO DE SOLICITAÇÃO DE QUIMIOTERAPIA
			oPrint:Say((nLinIni + 0030)/nTWeb, (nColMax - 750)/nTWeb, "2- Nº Guia no Prestador", oFont01) //2- Nº Guia no Prestador
			oPrint:Say((nLinIni + 0020)/nTWeb, (nColMax - 480)/nTWeb, aDados[nX, 02, nX1], oFont03n)

				//fSomaLin(nLinMax, nColMax, @nLinIni, nColIni, 80, 80)
			nLinIni -= 80
			oPrint:Box((nLinIni + 0175 -nWeb)/nTWeb,( nColIni + 0010)/nTWeb, (nLinIni + 0269-nWeb)/nTWeb, ((nColIni + nColMax)*0.1 - 0010)/nTWeb)
			oPrint:Say((nLinIni + 0180)/nTWeb,( nColIni + 0020)/nTWeb, "1 - Registro ANS", oFont01) //1 - Registro ANS
			oPrint:Say((nLinIni + 0220)/nTWeb,( nColIni + 0030)/nTWeb, aDados[nX, 01], oFont04)
			oPrint:Box((nLinIni + 0175-nWeb)/nTWeb,( (nColIni + nColMax)*0.1)/nTWeb, (nLinIni + 0269-nWeb)/nTWeb, ((nColIni + nColMax)*0.35 - 0010)/nTWeb)
			oPrint:Say((nLinIni + 0180)/nTWeb,( (nColIni + nColMax)*0.1 + 0020)/nTWeb, "3 - Número da Guia Referenciada", oFont01) //3 - Número da Guia Referenciada
			oPrint:Say((nLinIni + 0220)/nTWeb,( (nColIni + nColMax)*0.1 + 0030)/nTWeb, aDados[nX, 03, nX1], oFont04)
			oPrint:Box((nLinIni + 0175-nWeb)/nTWeb,( (nColIni + nColMax)*0.35)/nTWeb, (nLinIni + 0269-nWeb)/nTWeb, ((nColIni + nColMax)*0.6 - 0010)/nTWeb)
			oPrint:Say((nLinIni + 0180)/nTWeb,( (nColIni + nColMax)*0.35 + 0020)/nTWeb, "4 - Senha", oFont01) //4 - Senha
			oPrint:Say((nLinIni + 0220)/nTWeb,( (nColIni + nColMax)*0.35 + 0030)/nTWeb, aDados[nX, 04, nX1], oFont04)
			oPrint:Box((nLinIni + 0175-nWeb)/nTWeb,( (nColIni + nColMax)*0.6)/nTWeb, (nLinIni + 0269-nWeb)/nTWeb, ((nColIni + nColMax)*0.75 - 0010)/nTWeb)
			oPrint:Say((nLinIni + 0180)/nTWeb,( (nColIni + nColMax)*0.6 + 0020)/nTWeb, "5 - Data da Autorização", oFont01) //5 - Data da Autorização
			oPrint:Say((nLinIni + 0220)/nTWeb,( (nColIni + nColMax)*0.6 + 0030)/nTWeb, DToC(aDados[nX, 05, nX1]), oFont04)
			oPrint:Box((nLinIni + 0175-nWeb)/nTWeb,( (nColIni + nColMax)*0.75)/nTWeb, (nLinIni + 0269-nWeb)/nTWeb, (nColIni + nColMax - 0010)/nTWeb)
			oPrint:Say((nLinIni + 0180)/nTWeb,( (nColIni + nColMax)*0.75 + 0020)/nTWeb, "6 - Número da Guia Atribuído pela Operadora", oFont01) //6 - Número da Guia Atribuído pela Operadora
			oPrint:Say((nLinIni + 0220)/nTWeb,( (nColIni + nColMax)*0.75 + 0030)/nTWeb, aDados[nX, 06, nX1], oFont04)

			fSomaLin(nLinMax, nColMax, @nLinIni, nColIni, 100, 80)
			AddTBrush(oPrint, (nLinIni + 175)/nTWeb, (nColIni + 0010)/nTWeb, (nLinIni + 206)/nTWeb, (nColIni + nColMax)/nTWeb)
			oPrint:Say((nLinIni + 178)/nTWeb, (nColIni + 0020)/nTWeb, "Dados do Beneficiário", oFont01) //Dados do Prestador
			oPrint:Box((nLinIni + 208-nWeb)/nTWeb, (nColIni + 0010)/nTWeb, (nLinIni + 300-nWeb)/nTWeb, ((nColIni + nColMax)*0.25 - 0010)/nTWeb)
			oPrint:Say((nLinIni + 212)/nTWeb, (nColIni + 0020)/nTWeb, "7 - Número da Carteira", oFont01) //7 - Número da Carteira
			oPrint:Say((nLinIni + 252)/nTWeb, (nColIni + 0030)/nTWeb, aDados[nX, 07, nX1], oFont04)
			oPrint:Box((nLinIni + 208-nWeb)/nTWeb, ((nColIni + nColMax)*0.25)/nTWeb, (nLinIni + 300-nWeb)/nTWeb, (nColIni + nColMax - 0010)/nTWeb)
			oPrint:Say((nLinIni + 212)/nTWeb, ((nColIni + nColMax)*0.25 + 0020)/nTWeb, "8 - Nome", oFont01) //8 - Nome
			oPrint:Say((nLinIni + 252)/nTWeb, ((nColIni + nColMax)*0.25 + 0030)/nTWeb, aDados[nX, 08, nX1], oFont04)

			fSomaLin(nLinMax, nColMax, @nLinIni, nColIni, 130, 80)
			oPrint:Box((nLinIni + 178-nWeb)/nTWeb, (nColIni + 0010)/nTWeb, (nLinIni + 272-nWeb)/nTWeb, ((nColIni + nColMax)*0.1 - 0010)/nTWeb)
			oPrint:Say((nLinIni + 183)/nTWeb, (nColIni + 0020)/nTWeb, "9 - Peso (Kg)", oFont01) //9 - Peso (Kg)
			oPrint:Say((nLinIni + 223)/nTWeb, (nColIni + 0030)/nTWeb, Transform(aDados[nX, 09, nX1], "@E 999.99"), oFont04)
			oPrint:Box((nLinIni + 178-nWeb)/nTWeb, ((nColIni + nColMax)*0.1)/nTWeb, (nLinIni + 272-nWeb)/nTWeb, ((nColIni + nColMax)*0.2 - 0010)/nTWeb)
			oPrint:Say((nLinIni + 183)/nTWeb, ((nColIni + nColMax)*0.1 + 0020)/nTWeb, "10 - Altura (Cm)", oFont01) //10 - Altura (Cm)
			oPrint:Say((nLinIni + 223)/nTWeb, ((nColIni + nColMax)*0.1 + 0030)/nTWeb, Transform(aDados[nX, 10, nX1], "@E 999.99"), oFont04)
			oPrint:Box((nLinIni + 178-nWeb)/nTWeb, ((nColIni + nColMax)*0.2 + 0010)/nTWeb, (nLinIni + 272-nWeb)/nTWeb, ((nColIni + nColMax)*0.33 - 0010)/nTWeb)
			oPrint:Say((nLinIni + 183)/nTWeb, ((nColIni + nColMax)*0.2 + 0020)/nTWeb, "11 - Superfície Corporal (m²)", oFont01) //11 - Superfície Corporal (m²)
			oPrint:Say((nLinIni + 223)/nTWeb, ((nColIni + nColMax)*0.2 + 0030)/nTWeb, Transform(aDados[nX, 11, nX1], "@E 99.99"), oFont04)
			oPrint:Box((nLinIni + 178-nWeb)/nTWeb, ((nColIni + nColMax)*0.33 + 0010)/nTWeb, (nLinIni + 272-nWeb)/nTWeb, ((nColIni + nColMax)*0.4 - 0010)/nTWeb)
			oPrint:Say((nLinIni + 183)/nTWeb, ((nColIni + nColMax)*0.33 + 0020)/nTWeb, "12 - Idade", oFont01) //12 - Idade
			oPrint:Say((nLinIni + 223)/nTWeb, ((nColIni + nColMax)*0.33 + 0030)/nTWeb, Transform(aDados[nX, 12, nX1], "@E 999"), oFont04)
			oPrint:Box((nLinIni + 178-nWeb)/nTWeb, ((nColIni + nColMax)*0.4 + 0010)/nTWeb, (nLinIni + 272-nWeb)/nTWeb, ((nColIni + nColMax)*0.5 - 0010)/nTWeb)
			oPrint:Say((nLinIni + 183)/nTWeb, ((nColIni + nColMax)*0.4 + 0020)/nTWeb, "13 - Sexo", oFont01) //13 - Sexo
			oPrint:Say((nLinIni + 223)/nTWeb, ((nColIni + nColMax)*0.4 + 0030)/nTWeb, aDados[nX, 13, nX1], oFont04)

			fSomaLin(nLinMax, nColMax, @nLinIni, nColIni, 110, 80)
			AddTBrush(oPrint,  (nLinIni + 174)/nTWeb, (nColIni + 0010)/nTWeb, (nLinIni + 205)/nTWeb, (nColIni + nColMax)/nTWeb)
			oPrint:Say((nLinIni + 178)/nTWeb, (nColIni + 0020)/nTWeb, "Dados do Profissional Solicitante", oFont01) //Dados do Profissional Solicitante
			oPrint:Box((nLinIni + 208-nWeb)/nTWeb, (nColIni + 0010)/nTWeb, (nLinIni + 300-nWeb)/nTWeb, ((nColIni + nColMax)*0.5 - 0010)/nTWeb)
			oPrint:Say((nLinIni + 212)/nTWeb, (nColIni + 0020)/nTWeb, "14 - Nome do Profissional Solicitante", oFont01) //14 - Nome do Profissional Solicitante
			oPrint:Say((nLinIni + 252)/nTWeb, (nColIni + 0030)/nTWeb, aDados[nX, 14, nX1], oFont04)
			oPrint:Box((nLinIni + 209-nWeb)/nTWeb, ((nColIni + nColMax)*0.5)/nTWeb, (nLinIni + 300-nWeb)/nTWeb, ((nColIni + nColMax)*0.6 - 0010)/nTWeb)
			oPrint:Say((nLinIni + 212)/nTWeb, ((nColIni + nColMax)*0.5 + 0020)/nTWeb, "15 - Telefone", oFont01) //15 - Telefone
			oPrint:Say((nLinIni + 252)/nTWeb, ((nColIni + nColMax)*0.5 + 0030)/nTWeb, aDados[nX, 15, nX1], oFont04)
			oPrint:Box((nLinIni + 210-nWeb)/nTWeb, ((nColIni + nColMax)*0.6)/nTWeb, (nLinIni + 300-nWeb)/nTWeb, (nColIni + nColMax - 0010)/nTWeb)
			oPrint:Say((nLinIni + 212)/nTWeb, ((nColIni + nColMax)*0.6 + 0020)/nTWeb, "16 - E-mail", oFont01) //16 - E-mail
			oPrint:Say((nLinIni + 252)/nTWeb, ((nColIni + nColMax)*0.6 + 0030)/nTWeb, aDados[nX, 16, nX1], oFont04)

			fSomaLin(nLinMax, nColMax, @nLinIni, nColIni, 140, 80)
			AddTBrush(oPrint, (nLinIni + 174)/nTWeb, (nColIni + 0010)/nTWeb, (nLinIni + 205)/nTWeb, (nColIni + nColMax)/nTWeb)
			oPrint:Say((nLinIni + 178)/nTWeb, (nColIni + 0020)/nTWeb, "Diagnóstico Oncológico", oFont01) //Diagnóstico Oncológico
			oPrint:Box((nLinIni + 208-nWeb)/nTWeb, (nColIni + 0010)/nTWeb, (nLinIni + 300-nWeb)/nTWeb, ((nColIni + nColMax)*0.12 - 0010)/nTWeb)
			oPrint:Say((nLinIni + 212)/nTWeb, (nColIni + 0020)/nTWeb, "17 - Data do diagnóstico", oFont01) //17 - Data do diagnóstico
			oPrint:Say((nLinIni + 252)/nTWeb, (nColIni + 0030)/nTWeb, DtoC(aDados[nX, 17, nX1]), oFont04)
			AddTBrush(oPrint, (nLinIni + 208)/nTWeb, ((nColIni + nColMax)*0.12)/nTWeb, (nLinIni + 300)/nTWeb, ((nColIni + nColMax)*0.2 - 0010)/nTWeb)
			oPrint:Box((nLinIni + 208-nWeb)/nTWeb, ((nColIni + nColMax)*0.12)/nTWeb, (nLinIni + 300-nWeb)/nTWeb, ((nColIni + nColMax)*0.2 - 0010)/nTWeb)
			oPrint:Say((nLinIni + 212)/nTWeb, ((nColIni + nColMax)*0.12 + 0020)/nTWeb, "18 - CID 10 Principal (opcional)", oFont01) //18 - CID 10 Principal
			oPrint:Say((nLinIni + 252)/nTWeb, ((nColIni + nColMax)*0.12 + 0030)/nTWeb, aDados[nX, 18, nX1], oFont04)
			AddTBrush(oPrint, (nLinIni + 208)/nTWeb, ((nColIni + nColMax)*0.2)/nTWeb, (nLinIni + 300)/nTWeb, ((nColIni + nColMax)*0.26 - 0010)/nTWeb)
			oPrint:Box((nLinIni + 208-nWeb)/nTWeb, ((nColIni + nColMax)*0.2)/nTWeb, (nLinIni + 300-nWeb)/nTWeb, ((nColIni + nColMax)*0.26 - 0010)/nTWeb)
			oPrint:Say((nLinIni + 212)/nTWeb, ((nColIni + nColMax)*0.2 + 0020)/nTWeb, "19 - CID 10 (2)(opcional)", oFont01) //19 - CID 10 (2)
			oPrint:Say((nLinIni + 252)/nTWeb, ((nColIni + nColMax)*0.2 + 0030)/nTWeb, aDados[nX, 19, nX1], oFont04)
			AddTBrush(oPrint, (nLinIni + 208)/nTWeb, ((nColIni + nColMax)*0.26)/nTWeb, (nLinIni + 300)/nTWeb, ((nColIni + nColMax)*0.32 - 0010)/nTWeb)
			oPrint:Box((nLinIni + 208-nWeb)/nTWeb, ((nColIni + nColMax)*0.26)/nTWeb, (nLinIni + 300-nWeb)/nTWeb, ((nColIni + nColMax)*0.32 - 0010)/nTWeb)
			oPrint:Say((nLinIni + 212)/nTWeb, ((nColIni + nColMax)*0.26 + 0020)/nTWeb, "20 - CID 10 (3)(opcional)", oFont01) //20 - CID 10 (3)
			oPrint:Say((nLinIni + 252)/nTWeb, ((nColIni + nColMax)*0.26 + 0030)/nTWeb, aDados[nX, 20, nX1], oFont04)
			AddTBrush(oPrint, (nLinIni + 208)/nTWeb, ((nColIni + nColMax)*0.32)/nTWeb, (nLinIni + 300)/nTWeb, ((nColIni + nColMax)*0.38 - 0010)/nTWeb)
			oPrint:Box((nLinIni + 208-nWeb)/nTWeb, ((nColIni + nColMax)*0.32)/nTWeb, (nLinIni + 300-nWeb)/nTWeb, ((nColIni + nColMax)*0.38 - 0010)/nTWeb)
			oPrint:Say((nLinIni + 212)/nTWeb, ((nColIni + nColMax)*0.32 + 0020)/nTWeb, "21 - CID 10 (4)(opcional)", oFont01) //21 - CID 10 (4)
			oPrint:Say((nLinIni + 252)/nTWeb, ((nColIni + nColMax)*0.32 + 0030)/nTWeb, aDados[nX, 21, nX1], oFont04)
			oPrint:Box((nLinIni + 208-nWeb)/nTWeb, ((nColIni + nColMax)*0.38)/nTWeb, (nLinIni + 400-nWeb)/nTWeb, (nColIni + nColMax - 0010)/nTWeb)
			oPrint:Say((nLinIni + 212)/nTWeb, ((nColIni + nColMax)*0.38 + 0020)/nTWeb, "26 - Plano Terapêutico", oFont01) //26 - PlanoTerapêutico

			nOldLin := nLinIni

			For nI := 1 To MlCount(aDados[nX, 26, nX1], If(!lWeb,180,120))
				cObs := MemoLine(aDados[nX, 26, nX1], If(!lWeb,180,120), nI)
				oPrint:Say((nLinIni + 252)/nTWeb, ((nColIni + nColMax)*0.38 + 0020)/nTWeb, cObs, oFont01)
				nLinIni += 30
				If nI == 5
					exit //trunco para nao desconfigurar o relatorio
				Endif
			Next nI

			nLinIni := nOldLin

			fSomaLin(nLinMax, nColMax, @nLinIni, nColIni, 130, 80)
			oPrint:Box((nLinIni + 178-nWeb)/nTWeb, (nColIni + 0010)/nTWeb, (nLinIni + 272-nWeb)/nTWeb, ((nColIni + nColMax)*0.12 - 0010)/nTWeb)
			oPrint:Say((nLinIni + 183)/nTWeb, (nColIni + 0020)/nTWeb, "22 - Estadiamento", oFont01) //22 - Estadiamento
			oPrint:Say((nLinIni + 223)/nTWeb, (nColIni + 0030)/nTWeb, aDados[nX, 22, nX1], oFont04)
			oPrint:Box((nLinIni + 178-nWeb)/nTWeb, ((nColIni + nColMax)*0.12)/nTWeb, (nLinIni + 272-nWeb)/nTWeb, ((nColIni + nColMax)*0.22 - 0010)/nTWeb)
			oPrint:Say((nLinIni + 183)/nTWeb, ((nColIni + nColMax)*0.12 + 0020)/nTWeb, "23 - Tipo de Quimioterapia", oFont01) //23 - Tipo de Quimioterapia
			oPrint:Say((nLinIni + 223)/nTWeb, ((nColIni + nColMax)*0.12 + 0030)/nTWeb, aDados[nX, 23, nX1], oFont04)
			oPrint:Box((nLinIni + 178-nWeb)/nTWeb, ((nColIni + nColMax)*0.22)/nTWeb, (nLinIni + 272-nWeb)/nTWeb, ((nColIni + nColMax)*0.3 - 0010)/nTWeb)
			oPrint:Say((nLinIni + 183)/nTWeb, ((nColIni + nColMax)*0.22 + 0020)/nTWeb, "24 - Finalidade", oFont01) //24 - Finalidade
			oPrint:Say((nLinIni + 223)/nTWeb, ((nColIni + nColMax)*0.22 + 0030)/nTWeb, aDados[nX, 24, nX1], oFont04)
			oPrint:Box((nLinIni + 178-nWeb)/nTWeb, ((nColIni + nColMax)*0.3)/nTWeb, (nLinIni + 272-nWeb)/nTWeb, ((nColIni + nColMax)*0.38 - 0010)/nTWeb)
			oPrint:Say((nLinIni + 183)/nTWeb, ((nColIni + nColMax)*0.3 + 0020)/nTWeb, "25 - ECOG", oFont01) //25 - ECOG
			oPrint:Say((nLinIni + 223)/nTWeb, ((nColIni + nColMax)*0.3 + 0030)/nTWeb, aDados[nX, 25, nX1], oFont04)

			fSomaLin(nLinMax, nColMax, @nLinIni, nColIni, 300, 80)
			oPrint:Box((nLinIni + 28-nWeb)/nTWeb, (nColIni + 0010)/nTWeb, (nLinIni + 500-nWeb)/nTWeb, ((nColIni + nColMax)*0.5 - 0010)/nTWeb)
			oPrint:Say((nLinIni +33)/nTWeb, (nColIni + 0020)/nTWeb, "27 - Diagnóstico Cito/Histopatológico", oFont01) //27 - Diagnóstico Cito/Histopatológico
			oPrint:Box((nLinIni + 28-nWeb)/nTWeb, ((nColIni + nColMax)*0.5)/nTWeb, (nLinIni + 500-nWeb)/nTWeb, (nColIni + nColMax - 0010)/nTWeb)
			oPrint:Say((nLinIni + 33)/nTWeb, ((nColIni + nColMax)*0.5 + 0020)/nTWeb, "28 - Informações relevantes", oFont01) //28 - Informações relevantes

			nOldLin := nLinIni

			For nI := 1 To MlCount(aDados[nX, 27, nX1], If(!lWeb,120,90))
				cObs := MemoLine(aDados[nX, 27, nX1], If(!lWeb,120,90), nI)
				oPrint:Say((nLinIni + 80)/nTWeb, (nColIni + 0020)/nTWeb, cObs, oFont01)
				nLinIni += 30
			Next nI

			nLinIni := nOldLin

			For nI := 1 To MlCount(aDados[nX, 28, nX1], If(!lWeb,120,90))
				cObs := MemoLine(aDados[nX, 28, nX1], If(!lWeb,120,90), nI)
				oPrint:Say((nLinIni + 80)/nTWeb, ((nColIni + nColMax)*0.5 + 0030)/nTWeb, cObs, oFont01)
				nLinIni += 30
			Next nI

			nLinIni := nOldLin
			fSomaLin(nLinMax, nColMax, @nLinIni, nColIni, 500, 80)
			nOldLin := nLinIni

			AddTBrush(oPrint,  (nLinIni + 97)/nTWeb, (nColIni + 0010)/nTWeb, (nLinIni + 230)/nTWeb, ((nColIni + nColMax)*0.8 - 0010)/nTWeb)
			oPrint:Say((nLinIni + 50)/nTWeb, (nColIni + 0020)/nTWeb, "Medicamentos e Drogas solicitadas", oFont01) //Medicamentos e Drogas solicitadas

			fSomaLin(nLinMax, nColMax, @nLinIni, nColIni, 30, 80)
			oPrint:Box((nLinIni + 54-nWeb)/nTWeb, (nColIni + 0010)/nTWeb, (nLinIni + 570-nWeb)/nTWeb, ((nColIni + nColMax)*0.8 - 0010)/nTWeb)
			oPrint:Say((nLinIni + 60)/nTWeb, (nColIni + 0040)/nTWeb, "29-Data Prevista para Administração", oFont01) //29-Data Prevista para Administração
			oPrint:Say((nLinIni + 60)/nTWeb, ((nColIni + nColMax)*0.16)/nTWeb, "30-Tabela", oFont01) //30-Tabela
			oPrint:Say((nLinIni + 60)/nTWeb, ((nColIni + nColMax)*0.20)/nTWeb, "31-Código do Medicamento", oFont01) //31-Código do Medicamento
			oPrint:Say((nLinIni + 60)/nTWeb, ((nColIni + nColMax)*0.29)/nTWeb, "32-Descrição", oFont01) //32-Descrição
			oPrint:Say((nLinIni + 60)/nTWeb, ((nColIni + nColMax)*0.62)/nTWeb, "33-Doses", oFont01,,,,1) //33-Doses
			oPrint:Say((nLinIni + 60)/nTWeb, ((nColIni + nColMax)*0.65 + 0020)/nTWeb, "34-Via Adm", oFont01) //34-Via Adm
			oPrint:Say((nLinIni + 60)/nTWeb, ((nColIni + nColMax)*0.75 - 0020)/nTWeb, "35-Frequência", oFont01,,,,1) //35-Frequência

			For nN := nV To nAte

				oPrint:Say((nLinIni + 100)/nTWeb, (nColIni + 0012)/nTWeb, AllTrim(Str(nN)) + " - ", oFont01)
				oPrint:Say((nLinIni + 100)/nTWeb, (nColIni + 0040)/nTWeb, DtoC(aDados[nX, 29, nX1, nN]), oFont04)
				oPrint:Say((nLinIni + 100)/nTWeb, ((nColIni + nColMax)*0.16)/nTWeb, aDados[nX, 30, nX1, nN], oFont04)
				oPrint:Say((nLinIni + 100)/nTWeb, ((nColIni + nColMax)*0.20)/nTWeb, aDados[nX, 31, nX1, nN], oFont04)
				oPrint:Say((nLinIni + 100)/nTWeb, ((nColIni + nColMax)*0.29)/nTWeb, aDados[nX, 32, nX1, nN], oFont01)
				oPrint:Say((nLinIni + 100)/nTWeb, ((nColIni + nColMax)*0.62)/nTWeb, IIf(Empty(aDados[nX, 33, nX1, nN]), "", Transform(aDados[nX, 33, nX1, nN], "@E 999.99")), oFont04,,,,1)
				oPrint:Say((nLinIni + 100)/nTWeb, ((nColIni + nColMax)*0.65 + 0020)/nTWeb, aDados[nX, 34, nX1, nN], oFont04)
				oPrint:Say((nLinIni + 100)/nTWeb, ((nColIni + nColMax)*0.75 - 0020)/nTWeb, IIf(Empty(aDados[nX, 35, nX1, nN]), "", Transform(aDados[nX, 35, nX1, nN], "@E 99")), oFont04,,,,1)

				fSomaLin(nLinMax, nColMax, @nLinIni, nColIni, 40, 80)
			Next

			If nAte < Len(aDados[nX, 29, nX1])
				lImpNovo := .T.
				nAte += 8
				nV := nN
			EndIf

			nLinIni := nOldLin

			AddTBrush(oPrint,  (nLinIni + 97)/nTWeb, ((nColIni + nColMax)*0.8)/nTWeb, (nLinIni + 230)/nTWeb, (nColIni + nColMax)/nTWeb)
			oPrint:Say((nLinIni + 50)/nTWeb, ((nColIni + nColMax)*0.8 + 0010)/nTWeb, "Tratamentos Anteriores", oFont01) //Tratamentos Anteriores

			fSomaLin(nLinMax, nColMax, @nLinIni, nColIni, 30, 80)
			oPrint:Box((nLinIni + 54-nWeb)/nTWeb, ((nColIni + nColMax)*0.8)/nTWeb, (nLinIni + 230-nWeb)/nTWeb, ((nColIni + nColMax) - 0010)/nTWeb)
			oPrint:Say((nLinIni + 54)/nTWeb, ((nColIni + nColMax)*0.8 + 0020)/nTWeb, "36 - Cirurgia", oFont01) //36- Cirurgia

			nLinZZ := nLinIni

			For nI := 1 To MlCount(aDados[nX, 36, nX1], 30)
				cObs := MemoLine(aDados[nX, 36, nX1], 30, nI)
				oPrint:Say((nLinIni + 74)/nTWeb, ((nColIni + nColMax)*0.8 + 0030)/nTWeb, cObs, oFont04)
				nLinIni += 30
				If nI == 5
					exit // trunco para nao desconfigurar o relatorio
				Endif
			Next nI

			nLinIni := nLinZZ + 150

			fSomaLin(nLinMax, nColMax, @nLinIni, nColIni, 30, 80)
			oPrint:Box((nLinIni + 54-nWeb)/nTWeb, ((nColIni + nColMax)*0.8)/nTWeb, (nLinIni + 130-nWeb)/nTWeb, ((nColIni + nColMax) - 0010)/nTWeb)
			oPrint:Say((nLinIni + 54)/nTWeb, ((nColIni + nColMax)*0.8 + 0020)/nTWeb, "37 - Data da Realização", oFont01) //38 - Área Irradiada
			oPrint:Say((nLinIni + 74)/nTWeb, ((nColIni + nColMax)*0.8 + 0030)/nTWeb, DtoC(aDados[nX, 37, nX1]), oFont04)

			fSomaLin(nLinMax, nColMax, @nLinIni, nColIni, 80, 80)
			oPrint:Box((nLinIni + 54-nWeb)/nTWeb, ((nColIni + nColMax)*0.8)/nTWeb, (nLinIni + 230-nWeb)/nTWeb, ((nColIni + nColMax) - 0010)/nTWeb)
			oPrint:Say((nLinIni + 54)/nTWeb, ((nColIni + nColMax)*0.8 + 0020)/nTWeb, "38 - Área Irradiada", oFont01) //38 - Área Irradiada

			nLinZZ := nLinIni

			For nI := 1 To MlCount(aDados[nX, 38, nX1], 30)
				cObs := MemoLine(aDados[nX, 38, nX1], 30, nI)
				oPrint:Say((nLinIni + 74)/nTWeb, ((nColIni + nColMax)*0.8 + 0030)/nTWeb, cObs, oFont04)
				nLinIni += 30
				If nI == 5
					exit // trunco para nao desconfigurar o relatorio
				Endif
			Next nI

			nLinIni := nLinZZ + 150

			fSomaLin(nLinMax, nColMax, @nLinIni, nColIni, 30, 80)
			oPrint:Box((nLinIni + 54-nWeb)/nTWeb, ((nColIni + nColMax)*0.8)/nTWeb, (nLinIni + 130-nWeb)/nTWeb, ((nColIni + nColMax) - 0010)/nTWeb)
			oPrint:Say((nLinIni + 54)/nTWeb, ((nColIni + nColMax)*0.8 + 0020)/nTWeb, "39 - Data da Aplicação", oFont01) //39 - Data da Aplicação
			oPrint:Say((nLinIni + 74)/nTWeb, ((nColIni + nColMax)*0.8 + 0030)/nTWeb, DtoC(aDados[nX, 39, nX1]), oFont04)

			fSomaLin(nLinMax, nColMax, @nLinIni, nColIni, 80, 80)
			AddTBrush(oPrint, (nLinIni + 54)/nTWeb, (nColIni + 0010)/nTWeb, (nLinIni + 400)/nTWeb, ((nColIni + nColMax) - 0010)/nTWeb)
			oPrint:Box((nLinIni + 50 -nWeb)/nTWeb, (nColIni + 0010)/nTWeb, (nLinIni + 200-nWeb)/nTWeb, ((nColIni + nColMax)*0.8 - 0010)/nTWeb)
			oPrint:Say((nLinIni + 50)/nTWeb, (nColIni + 0020)/nTWeb, "40 - Observação / Justificativa", oFont01) //38 - Área Irradiada

			nLinZZ := nLinIni

			For nI := 1 To MlCount(aDados[nX, 40, nX1], If(!lWeb,155,120))
				cObs := MemoLine(aDados[nX, 40, nX1], If(!lWeb,155,120), nI)
				oPrint:Say((nLinIni + 70)/nTWeb, (nColIni + 0030)/nTWeb, cObs, oFont04)
				nLinIni += 30
				If nI == 4
					exit
				Endif
			Next nI

			nLinIni := 1980

			fSomaLin(nLinMax, nColMax, @nLinIni, nColIni, 50, 80)
			oPrint:Box((nLinIni + 204-nWeb)/nTWeb, (nColIni + 0010)/nTWeb, (nLinIni + 300-nWeb)/nTWeb, ((nColIni + nColMax)*0.12 - 0010)/nTWeb)
			oPrint:Say((nLinIni + 209)/nTWeb, (nColIni + 0020)/nTWeb, "41- Número de Ciclos", oFont01) //40- Número de Ciclos
			oPrint:Say((nLinIni + 229)/nTWeb, (nColIni + 0020)/nTWeb, "Previstos", oFont01) //Previstos
			oPrint:Say((nLinIni + 254)/nTWeb, (nColIni + 0030)/nTWeb, IIf(Empty(aDados[nX, 41, nX1]), "", Transform(aDados[nX, 41, nX1], "@E 99")), oFont04)
			oPrint:Box((nLinIni + 204-nWeb)/nTWeb, ((nColIni + nColMax)*0.12)/nTWeb, (nLinIni + 300-nWeb)/nTWeb, ((nColIni + nColMax)*0.18 - 0010)/nTWeb)
			oPrint:Say((nLinIni + 209)/nTWeb, ((nColIni + nColMax)*0.12 + 0020)/nTWeb, "42 - Ciclo Atual", oFont01) //41 - Ciclo Atual
			oPrint:Say((nLinIni + 254)/nTWeb, ((nColIni + nColMax)*0.12 + 0030)/nTWeb, IIf(Empty(aDados[nX, 42, nX1]), "", Transform(aDados[nX, 42, nX1], "@E 99")), oFont04)
			oPrint:Box((nLinIni + 204-nWeb)/nTWeb, ((nColIni + nColMax)*0.18)/nTWeb, (nLinIni + 300-nWeb)/nTWeb, ((nColIni + nColMax)*0.25 - 0010)/nTWeb)
			oPrint:Say((nLinIni + 209)/nTWeb, ((nColIni + nColMax)*0.18 + 0020)/nTWeb, "43-Intervalo entre", oFont01) //42-Intervalo entre
			oPrint:Say((nLinIni + 229)/nTWeb, ((nColIni + nColMax)*0.18 + 0020)/nTWeb, "Ciclos ( em dias)", oFont01) //Ciclos ( em dias)
			oPrint:Say((nLinIni + 254)/nTWeb, ((nColIni + nColMax)*0.18 + 0030)/nTWeb, IIf(Empty(aDados[nX, 43, nX1]), "", Transform(aDados[nX, 43, nX1], "@E 999")), oFont04)
			oPrint:Box((nLinIni + 204-nWeb)/nTWeb, ((nColIni + nColMax)*0.25)/nTWeb, (nLinIni + 300-nWeb)/nTWeb, ((nColIni + nColMax)*0.35 - 0010)/nTWeb)
			oPrint:Say((nLinIni + 209)/nTWeb, ((nColIni + nColMax)*0.25 + 0020)/nTWeb, "44 - Data da Solicitação", oFont01) //43 - Data da Solicitação
			oPrint:Say((nLinIni + 254)/nTWeb, ((nColIni + nColMax)*0.25 + 0030)/nTWeb, DtoC(aDados[nX, 44, nX1]), oFont04)
			oPrint:Box((nLinIni + 204-nWeb)/nTWeb, ((nColIni + nColMax)*0.35)/nTWeb, (nLinIni + 300-nWeb)/nTWeb, ((nColIni + nColMax)*0.68 - 0010)/nTWeb)
			oPrint:Say((nLinIni + 209)/nTWeb, ((nColIni + nColMax)*0.35 + 0020)/nTWeb, "45-Assinatura do Profissional Solicitante", oFont01) //44-Assinatura do Profissional Solicitante
			oPrint:Box((nLinIni + 204-nWeb)/nTWeb, ((nColIni + nColMax)*0.68)/nTWeb, (nLinIni + 300-nWeb)/nTWeb, (nColIni + nColMax - 0010)/nTWeb)
			oPrint:Say((nLinIni + 209)/nTWeb, ((nColIni + nColMax)*0.68 + 0020)/nTWeb, "46-Assinatura do Responsável pela Autorização", oFont01) //45-Assinatura do Responsável pela Autorização

			oPrint:EndPage()	// Finaliza a pagina

		EndDo

	Next

	oPrint:EndPage()	// Finaliza a pagina

Next

If lWeb
	oPrint:Print()
Else
	oPrint:Preview()
Endif

Return cFileName
*/

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡ao    ³ PLTISARADI³ Autor ³ Bruno Iserhardt       ³ Data ³ 06.02.14 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡ao ³ Estrutura Relatório TISS 3 (Anexo de Solicitacao de         ³±±
±±³          ³ Radioterapia)                                               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ SigaPLS                                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ aDados - Array com as informações do relat´rio              ³±±
±±³          ³ nLayout - Define o formato de papél para impressao:         ³±±
±±³          ³           1 - Formato Ofício II (216x330mm)                 ³±±
±±³          ³           2 - Formato A4 (210x297mm)                        ³±±
±±³          ³  		 3 - Formato Carta (216x279mm)     			       ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
/*
Function PLTISARADI(aDados, nLayout, cLogoGH,lWeb, cPathRelW, lUnicaImp)

Local nLinMax
Local nColMax
Local nLinIni	:=	0		// Linha Lateral (inicial) Esquerda
Local nColIni	:=	0		// Coluna Lateral (inicial) Esquerda
Local nOldLin	:=	0
Local nColA4    := 	0
Local nWeb		:=  0
Local cFileLogo
Local lPrinter := .F.
Local lImpNovo := .T.
Local nI, nJ, nN, nV
Local nX, nX1, nCount
Local oFont01
Local oFont02n
Local oFont03n
Local oFont04
Local cObs
Local cRel      := "guiaradi"
Local cPathSrvJ := GETMV("MV_RELT")
Local nTweb		:= 1
Local nLweb		:= 0
Local nLwebC	:= 0
Local oPrint	:= NIL

Default lUnicaImp := .F.
Default lWeb    := .F.
Default cPathRelW := ''
Default nLayout := 2
Default cLogoGH := ''
Default	aDados  := { {;
	"123456",; //1 - Registro ANS
	{"01234567890123456789"},; //2 - N Guia no Prestador
	{"01234567890123456789"},; //3 - Numero da Guia Referenciada
	{"01234567890123456789"},; //4 - Senha
	{CtoD("06/02/14")},; //5 - Data da Autorizacao
	{"01234567890123456789"},; //6 - Numero da Guia Atribuido pela Operadora
	{"01234567890123456789"},; //7 - Número da Carteira
	{Replicate("M", 70)},; //8 - Nome
	{999},; //9 - Idade
	{"M"},; //10 - Sexo
	{Replicate("M", 70)},; //11 - Nome do Profissional Solicitante
	{"01234567890"},; //12 - Telefone
	{Replicate("M", 60)},; //13 - E-mail
	{CtoD("06/02/2014")},; //14 - Data do diagnóstico
	{"1111"},; //15 - CID 10 Principal
	{"2222"},; //16 - CID 10 (2)
	{"3333"},; //17 - CID 10 (3)
	{"4444"},; //18 - CID 10 (4)
	{"1"},; //19 - Diagnóstico por Imagem
	{"2"},; //20 - Estadiamento
	{"3"},; //21 - ECOG
	{"4"},; //22 - Finalidade
	{Replicate("M", 1000)},; //23 - Diagnóstico Cito/Histopatológico
	{Replicate("M", 1000)},; //24 - Informações relevantes
	{Replicate("M", 40)},; //25 - Cirurgia
	{CtoD("06/02/2014")},; //26 - Data da Realização
	{Replicate("M", 40)},; //27 - Quimioterapia
	{CtoD("06/02/2014")},; //28 - Data da Aplicação
	{{CtoD("06/02/2014"),CtoD("06/02/2014"),CtoD("06/02/2014"),CtoD("06/02/2014"),CtoD("06/02/2014"),CtoD("06/02/2014"),CtoD("06/02/2014"),CtoD("06/02/2014"),CtoD("06/02/2014"),CtoD("06/02/2014"),CtoD("06/02/2014"),CtoD("06/02/2014")}},; //29-Data Prevista
	{{"14","99","99","99","99","88","99","99","77","99","99","25"}},; //30-Tabela
	{{"0123456789","0123456789","0123456789","0123456789","0123456789","0123456789","0123456789","0123456789","0123456789","0123456789","0123456789","0123456789"}},; //31-Código do Procedimento
	{{Replicate("M", 150),Replicate("M", 150),Replicate("M", 150),Replicate("M", 150),Replicate("M", 150),Replicate("M", 150),Replicate("M", 150),Replicate("M", 150),Replicate("M", 150),Replicate("M", 150),Replicate("M", 150),Replicate("M", 150)}},; //32-Descrição
	{{111.99, 999.99, 333.99, 999.99, 555.99, 999.99, 777.99, 999.99, 999.99, 100.99, 999.99, 999.99}},; //33-Qtde.
	{111},; //34 - Número de Campos
	{2222},; //35 - Dose por dia (em Gy)
	{3333},; //36 - Dose Total ( em Gy)
	{444},; //37 - Número de Dias
	{CtoD("06/02/2014")},; //38 - Data Prevista para Início da Administração
	{Replicate("M", 500)},; //39-Observação/Justificativa
	{CtoD("06/02/2014")},; //40 - Data da Solicitação
	{},; //41-Assinatura do Profissional Solicitante
	{} } } //42-Assinatura do Autorizador da Operadora

If nLayout  == 1 // Ofício 2
	nLinMax := 2435
	nColMax := 3705
Elseif nLayout == 2   // Papél A4
	nLinMax	:=	2275
	nColMax	:=	3270
Else //Carta
	nLinMax	:=	2435
	nColMax	:=	3175
Endif

oFont01		:= TFont():New("Arial",  5,  5, , .F., , , , .T., .F.) // Normal
if nLayout == 1 // Oficio 2
	oFont02n	:= TFont():New("Arial", 12, 12, , .T., , , , .T., .F.) // Negrito
	oFont03n	:= TFont():New("Arial", 14, 14, , .T., , , , .T., .F.) // Negrito
	oFont04		:= TFont():New("Arial", 09, 09, , .F., , , , .T., .F.) // Normal
Else  // Papél A4 ou Carta
	oFont02n	:= TFont():New("Arial", 11, 11, , .T., , , , .T., .F.) // Negrito
	oFont03n	:= TFont():New("Arial", 13, 13, , .T., , , , .T., .F.) // Negrito
	oFont04		:= TFont():New("Arial", 08, 08, , .F., , , , .T., .F.) // Normal
Endif

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
	//³ Nao permite acionar a impressao quando for na web.
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
If lWeb
	cPathSrvJ := cPathRelW
	cFileName := cRel+lower(CriaTrab(NIL,.F.))+".pdf"
Else
	cFileName := cRel+CriaTrab(NIL,.F.)
EndIf

if !lWeb
	oPrint	:= TMSPrinter():New("ANEXO DE SOLICITAÇÃO DE RADIOTERAPIA") //ANEXO DE SOLICITAÇÃO DE RADIOTERAPIA
else
	oPrint := FWMSPrinter():New ( cFileName	,,.F.,cPathSrvJ	 ,.T.,	,@oPrint,			  ,			  ,	.F.			,.f.)
	If lSrvUnix
		AjusPath(@oPrint)
	EndIf
	oPrint:cPathPDF := cPathSrvJ
	nTweb		:= 3.9
	nLweb		:= 10
	nLwebC		:= -3
	nWeb		:= 25
	nColMax		:= 3100
	oPrint:lServer := lWeb
Endif



oPrint:SetLandscape()		// Modo paisagem

if nLayout ==2
	oPrint:SetPaperSize(9)// Papél A4
Elseif nLayout ==3
	oPrint:SetPaperSize(1)// Papél Carta
Else
	oPrint:SetPaperSize(14) //Papel Oficio2 216 x 330mm / 8 1/2 x 13in
Endif

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
	//³Device
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
If lWeb
	oPrint:setDevice(IMP_PDF)
Else
		// Verifica se existe alguma impressora configurada para Impressao Grafica
	lPrinter := oPrint:IsPrinterActive()
	IF lPrinter
		lPrinter := IIF(GETNEWPAR("MV_IMPATIV", .F.), .F., .T.)	//	Define se irá alterar a Impressora Ativa
	ENDIF
	If ! lPrinter
		oPrint:Setup()
	EndIf
Endif

For nX := 1 To Len(aDados)

	If ValType(aDados[nX]) == 'U' .OR. Len(aDados[nX]) == 0
		Loop
	EndIf

	For nX1 := 1 To Len(aDados[nX, 02])

		nAte := 12
		nV := 1

		//Esta parte do código faz com que
		//imprima mais de uma guia.
		//INICIO
		If lUnicaImp
			If nX1 <= Len(aDados)
				lImpNovo := .T.
			EndIf
		EndIf
		//FIM

		While lImpNovo

			lImpNovo := .F.

			For nI:= 29 To 33
				If Len(aDados[nX, nI, nX1]) < nAte
					For nJ := Len(aDados[nX, nI, nX1]) + 1 To nAte
						If AllTrim(Str(nI)) $ "33"
							aAdd(aDados[nX, nI, nX1], 0)
						ElseIf AllTrim(Str(nI)) $ "29"
							aAdd(aDados[nX, nI, nX1], CtoD(""))
						Else
							aAdd(aDados[nX, nI, nX1],"")
						EndIf
					Next nJ
				EndIf
			Next nI

			nLinIni  := 080
			nColIni  := 080
			nColA4   := 000

			oPrint:StartPage()		// Inicia uma nova pagina
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³Box Principal                                                 ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			oPrint:Box((nLinIni + 0000)/nTweb, (nColIni + 0000)/nTweb, (nLinIni + nLinMax)/nTweb, (nColIni + nColMax)/nTweb)

				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³Carrega e Imprime Logotipo da Empresa                         ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			fLogoEmp(@cFileLogo,, cLogoGH)

			If File(cFilelogo)
				oPrint:SayBitmap((nLinIni + 0050)/nTweb, (nColIni + 0020)/nTweb, cFileLogo, (400)/nTweb, (090)/nTweb) 		// Tem que estar abaixo do RootPath
			EndIf

			If nLayout == 2 // Papél A4
				nColA4    := -0335
			Elseif nLayout == 3// Carta
				nColA4    := -0530
			Endif

			oPrint:Say((nLinIni + 0080)/nTweb, ((nColIni + nColMax)*0.47)/nTweb, "ANEXO DE SOLICITAÇÃO DE RADIOTERAPIA", oFont02n,,,, 2) //ANEXO DE SOLICITAÇÃO DE RADIOTERAPIA
			oPrint:Say((nLinIni + 0090)/nTweb, (nColMax - 750)/nTweb, "2- Nº Guia no Prestador", oFont01) //2- Nº Guia no Prestador
			oPrint:Say((nLinIni + 0070)/nTweb, (nColMax - 480)/nTweb, aDados[nX, 02, nX1], oFont03n)

				//fSomaLin(nLinMax, nColMax, @nLinIni, nColIni, 40, 80)
			oPrint:Box((nLinIni + 0175 -nWeb)/nTweb, (nColIni + 0010)/nTweb, (nLinIni + 0269-nWeb)/nTweb, ((nColIni + nColMax)*0.1 - 0010)/nTweb)
			oPrint:Say((nLinIni + 0180)/nTweb, (nColIni + 0020)/nTweb, "1 - Registro ANS", oFont01) //1 - Registro ANS
			oPrint:Say((nLinIni + 0220)/nTweb, (nColIni + 0030)/nTweb, aDados[nX, 01], oFont04)
			oPrint:Box((nLinIni + 0175-nWeb)/nTweb, ((nColIni + nColMax)*0.1)/nTweb, (nLinIni + 0269-nWeb)/nTweb, ((nColIni + nColMax)*0.35 - 0010)/nTweb)
			oPrint:Say((nLinIni + 0180)/nTweb, ((nColIni + nColMax)*0.1 + 0020)/nTweb, "3 - Número da Guia Referenciada", oFont01) //3 - Número da Guia Referenciada
			oPrint:Say((nLinIni + 0220)/nTweb, ((nColIni + nColMax)*0.1 + 0030)/nTweb, aDados[nX, 03, nX1], oFont04)
			oPrint:Box((nLinIni + 0175-nWeb)/nTweb, ((nColIni + nColMax)*0.35)/nTweb, (nLinIni + 0269-nWeb)/nTweb, ((nColIni + nColMax)*0.6 - 0010)/nTweb)
			oPrint:Say((nLinIni + 0180)/nTweb, ((nColIni + nColMax)*0.35 + 0020)/nTweb, "4 - Senha", oFont01) //4 - Senha
			oPrint:Say((nLinIni + 0220)/nTweb, ((nColIni + nColMax)*0.35 + 0030)/nTweb, aDados[nX, 04, nX1], oFont04)
			oPrint:Box((nLinIni + 0175-nWeb)/nTweb, ((nColIni + nColMax)*0.6)/nTweb, (nLinIni + 0269-nWeb)/nTweb, ((nColIni + nColMax)*0.75 - 0010)/nTweb)
			oPrint:Say((nLinIni + 0180)/nTweb, ((nColIni + nColMax)*0.6 + 0020)/nTweb, "5 - Data da Autorização", oFont01) //5 - Data da Autorização
			oPrint:Say((nLinIni + 0220)/nTweb, ((nColIni + nColMax)*0.6 + 0030)/nTweb, DToC(aDados[nX, 05, nX1]), oFont04)
			oPrint:Box((nLinIni + 0175-nWeb)/nTweb, ((nColIni + nColMax)*0.75)/nTweb, (nLinIni + 0269-nWeb)/nTweb, (nColIni + nColMax - 0010)/nTweb)
			oPrint:Say((nLinIni + 0180)/nTweb, ((nColIni + nColMax)*0.75 + 0020)/nTweb, "6 - Número da Guia Atribuído pela Operadora", oFont01) //6 - Número da Guia Atribuído pela Operadora
			oPrint:Say((nLinIni + 0220)/nTweb, ((nColIni + nColMax)*0.75 + 0030)/nTweb, aDados[nX, 06, nX1], oFont04)

			fSomaLin(nLinMax, nColMax, @nLinIni, nColIni, 100, 80)
			AddTBrush(oPrint, (nLinIni + 175)/nTweb, (nColIni + 0010)/nTweb, (nLinIni + 206)/nTweb, (nColIni + nColMax)/nTweb)
			oPrint:Say((nLinIni + 178)/nTweb, (nColIni + 0020)/nTweb, "Dados do Beneficiário", oFont01) //Dados do Prestador
			oPrint:Box((nLinIni + 208-nWeb)/nTweb, (nColIni + 0010)/nTweb, (nLinIni + 300-nWeb)/nTweb, ((nColIni + nColMax)*0.25 - 0010)/nTweb)
			oPrint:Say((nLinIni + 212)/nTweb, (nColIni + 0020)/nTweb, "7 - Número da Carteira", oFont01) //7 - Número da Carteira
			oPrint:Say((nLinIni + 252)/nTweb, (nColIni + 0030)/nTweb, aDados[nX, 07, nX1], oFont04)
			oPrint:Box((nLinIni + 208-nWeb)/nTweb, ((nColIni + nColMax)*0.25)/nTweb, (nLinIni + 300-nWeb)/nTweb, ((nColIni + nColMax)*0.85 - 0010)/nTweb)
			oPrint:Say((nLinIni + 212)/nTweb, ((nColIni + nColMax)*0.25 + 0020)/nTweb, "8 - Nome", oFont01) //8 - Nome
			oPrint:Say((nLinIni + 252)/nTweb, ((nColIni + nColMax)*0.25 + 0030)/nTweb, aDados[nX, 08, nX1], oFont04)
			oPrint:Box((nLinIni + 208-nWeb)/nTweb, ((nColIni + nColMax)*0.85 + 0010)/nTweb, (nLinIni + 300-nWeb)/nTweb, ((nColIni + nColMax)*0.92 - 0010)/nTweb)
			oPrint:Say((nLinIni + 212)/nTweb, ((nColIni + nColMax)*0.85 + 0020)/nTweb, "9 - Idade", oFont01) //12 - Idade
			oPrint:Say((nLinIni + 252)/nTweb, ((nColIni + nColMax)*0.85 + 0030)/nTweb, Transform(aDados[nX, 9, nX1], "@E 999"), oFont04)
			oPrint:Box((nLinIni + 208-nWeb)/nTweb, ((nColIni + nColMax)*0.92 + 0010)/nTweb, (nLinIni + 300-nWeb)/nTweb, (nColIni + nColMax - 0010)/nTweb)
			oPrint:Say((nLinIni + 212)/nTweb, ((nColIni + nColMax)*0.92 + 0020)/nTweb, "10 - Sexo", oFont01) //13 - Sexo
			oPrint:Say((nLinIni + 252)/nTweb, ((nColIni + nColMax)*0.92 + 0030)/nTweb, aDados[nX, 10, nX1], oFont04)

			fSomaLin(nLinMax, nColMax, @nLinIni, nColIni, 130, 80)
			AddTBrush(oPrint,  (nLinIni + 174)/nTweb, (nColIni + 0010)/nTweb, (nLinIni + 205)/nTweb, (nColIni + nColMax)/nTweb)
			oPrint:Say((nLinIni + 178)/nTweb, (nColIni + 0020)/nTweb, "Dados do Profissional Solicitante", oFont01) //Dados do Profissional Solicitante
			oPrint:Box((nLinIni + 208-nWeb)/nTweb, (nColIni + 0010)/nTweb, (nLinIni + 300-nWeb)/nTweb, ((nColIni + nColMax)*0.5 - 0010)/nTweb)
			oPrint:Say((nLinIni + 212)/nTweb, (nColIni + 0020)/nTweb, "11 - Nome do Profissional Solicitante", oFont01) //14 - Nome do Profissional Solicitante
			oPrint:Say((nLinIni + 252)/nTweb, (nColIni + 0030)/nTweb, aDados[nX, 11, nX1], oFont04)
			oPrint:Box((nLinIni + 209-nWeb)/nTweb, ((nColIni + nColMax)*0.5)/nTweb, (nLinIni + 300-nWeb)/nTweb, ((nColIni + nColMax)*0.6 - 0010)/nTweb)
			oPrint:Say((nLinIni + 212)/nTweb, ((nColIni + nColMax)*0.5 + 0020)/nTweb, "12 - Telefone", oFont01) //15 - Telefone
			oPrint:Say((nLinIni + 252)/nTweb, ((nColIni + nColMax)*0.5 + 0030)/nTweb, aDados[nX, 12, nX1], oFont04)
			oPrint:Box((nLinIni + 210-nWeb)/nTweb, ((nColIni + nColMax)*0.6)/nTweb, (nLinIni + 300-nWeb)/nTweb, (nColIni + nColMax - 0010)/nTweb)
			oPrint:Say((nLinIni + 212)/nTweb, ((nColIni + nColMax)*0.6 + 0020)/nTweb, "13 - E-mail", oFont01) //16 - E-mail
			oPrint:Say((nLinIni + 252)/nTweb, ((nColIni + nColMax)*0.6 + 0030)/nTweb, aDados[nX, 13, nX1], oFont04)

			fSomaLin(nLinMax, nColMax, @nLinIni, nColIni, 130, 80)
			AddTBrush(oPrint, (nLinIni + 174)/nTweb, (nColIni + 0010)/nTweb, (nLinIni + 205)/nTweb, (nColIni + nColMax)/nTweb)
			oPrint:Say((nLinIni + 178)/nTweb, (nColIni + 0020)/nTweb, "Diagnóstico Oncológico", oFont01) //Diagnóstico Oncológico
			oPrint:Box((nLinIni + 208-nWeb)/nTweb, (nColIni + 0010)/nTweb, (nLinIni + 300-nWeb)/nTweb, ((nColIni + nColMax)*0.15 - 0010)/nTweb)
			oPrint:Say((nLinIni + 212)/nTweb, (nColIni + 0020)/nTweb, "14 - Data do diagnóstico", oFont01) //14 - Data do diagnóstico
			oPrint:Say((nLinIni + 252)/nTweb, (nColIni + 0030)/nTweb, DtoC(aDados[nX, 14, nX1]), oFont04)
			AddTBrush(oPrint, (nLinIni + 208)/nTweb, ((nColIni + nColMax)*0.15)/nTweb, (nLinIni + 300)/nTweb, ((nColIni + nColMax)*0.23 - 0010)/nTweb)
			oPrint:Box((nLinIni + 208-nWeb)/nTweb, ((nColIni + nColMax)*0.15)/nTweb, (nLinIni + 300-nWeb)/nTweb, ((nColIni + nColMax)*0.23 - 0010)/nTweb)
			oPrint:Say((nLinIni + 212)/nTweb, ((nColIni + nColMax)*0.15 + 0020)/nTweb, "15 - CID 10 Principal (opcional)", oFont01) //15 - CID 10 Principal
			oPrint:Say((nLinIni + 252)/nTweb, ((nColIni + nColMax)*0.15 + 0030)/nTweb, aDados[nX, 15, nX1], oFont04)
			AddTBrush(oPrint, (nLinIni + 208)/nTweb, ((nColIni + nColMax)*0.23)/nTweb, (nLinIni + 300)/nTweb, ((nColIni + nColMax)*0.31 - 0010)/nTweb)
			oPrint:Box((nLinIni + 208-nWeb)/nTweb, ((nColIni + nColMax)*0.23)/nTweb, (nLinIni + 300-nWeb)/nTweb, ((nColIni + nColMax)*0.31 - 0010)/nTweb)
			oPrint:Say((nLinIni + 212)/nTweb, ((nColIni + nColMax)*0.23 + 0020)/nTweb, "16 - CID 10 (2)(opcional)", oFont01) //16 - CID 10 (2)
			oPrint:Say((nLinIni + 252)/nTweb, ((nColIni + nColMax)*0.23 + 0030)/nTweb, aDados[nX, 16, nX1], oFont04)
			AddTBrush(oPrint, (nLinIni + 208)/nTweb, ((nColIni + nColMax)*0.31)/nTweb, (nLinIni + 300)/nTweb, ((nColIni + nColMax)*0.39 - 0010)/nTweb)
			oPrint:Box((nLinIni + 208-nWeb)/nTweb, ((nColIni + nColMax)*0.31)/nTweb, (nLinIni + 300-nWeb)/nTweb, ((nColIni + nColMax)*0.39 - 0010)/nTweb)
			oPrint:Say((nLinIni + 212)/nTweb, ((nColIni + nColMax)*0.31 + 0020)/nTweb, "17 - CID 10 (3)(opcional)", oFont01) //17 - CID 10 (3)
			oPrint:Say((nLinIni + 252)/nTweb, ((nColIni + nColMax)*0.31 + 0030)/nTweb, aDados[nX, 17, nX1], oFont04)
			AddTBrush(oPrint, (nLinIni + 208)/nTweb, ((nColIni + nColMax)*0.39)/nTweb, (nLinIni + 300)/nTweb, ((nColIni + nColMax)*0.47 - 0010)/nTweb)
			oPrint:Box((nLinIni + 208-nWeb)/nTweb, ((nColIni + nColMax)*0.39)/nTweb, (nLinIni + 300-nWeb)/nTweb, ((nColIni + nColMax)*0.47 - 0010)/nTweb)
			oPrint:Say((nLinIni + 212)/nTweb, ((nColIni + nColMax)*0.39 + 0020)/nTweb, "18 - CID 10 (4)(opcional)", oFont01) //18 - CID 10 (4)
			oPrint:Say((nLinIni + 252)/nTweb, ((nColIni + nColMax)*0.39 + 0030)/nTweb, aDados[nX, 18, nX1], oFont04)
			oPrint:Box((nLinIni + 208-nWeb)/nTweb, ((nColIni + nColMax)*0.47)/nTweb, (nLinIni + 300-nWeb)/nTweb, ((nColIni + nColMax)*0.59 - 0010)/nTweb)
			oPrint:Say((nLinIni + 212)/nTweb, ((nColIni + nColMax)*0.47 + 0020)/nTweb, "19 - Diagnóstico por Imagem", oFont01) //19 - Diagnóstico por Imagem
			oPrint:Say((nLinIni + 252)/nTweb, ((nColIni + nColMax)*0.47 + 0030)/nTweb, aDados[nX, 19, nX1], oFont04)
			oPrint:Box((nLinIni + 208-nWeb)/nTweb, ((nColIni + nColMax)*0.59)/nTweb, (nLinIni + 300-nWeb)/nTweb, ((nColIni + nColMax)*0.69 - 0010)/nTweb)
			oPrint:Say((nLinIni + 212)/nTweb, ((nColIni + nColMax)*0.59 + 0020)/nTweb, "20 - Estadiamento", oFont01) //20 - Estadiamento
			oPrint:Say((nLinIni + 252)/nTweb, ((nColIni + nColMax)*0.59 + 0030)/nTweb, aDados[nX, 20, nX1], oFont04)
			oPrint:Box((nLinIni + 208-nWeb)/nTweb, ((nColIni + nColMax)*0.69)/nTweb, (nLinIni + 300-nWeb)/nTweb, ((nColIni + nColMax)*0.79 - 0010)/nTweb)
			oPrint:Say((nLinIni + 212)/nTweb, ((nColIni + nColMax)*0.69 + 0020)/nTweb, "21 - ECOG", oFont01) //21 - ECOG
			oPrint:Say((nLinIni + 252)/nTweb, ((nColIni + nColMax)*0.69 + 0030)/nTweb, aDados[nX, 21, nX1], oFont04)
			oPrint:Box((nLinIni + 208-nWeb)/nTweb, ((nColIni + nColMax)*0.79)/nTweb, (nLinIni + 300-nWeb)/nTweb, ((nColIni + nColMax)*0.89 - 0010)/nTweb)
			oPrint:Say((nLinIni + 212)/nTweb, ((nColIni + nColMax)*0.79 + 0020)/nTweb, "22 - Finalidade", oFont01) //22 - Finalidade
			oPrint:Say((nLinIni + 252)/nTweb, ((nColIni + nColMax)*0.79 + 0030)/nTweb, aDados[nX, 22, nX1], oFont04)

			fSomaLin(nLinMax, nColMax, @nLinIni, nColIni, 110, 80)

			nOldLin := nLinIni

			oPrint:Box((nLinIni + 208-nWeb)/nTweb, (nColIni + 0010)/nTweb, (nLinIni + 900-nWeb)/nTweb, ((nColIni + nColMax)*0.4 - 0010)/nTweb)
			oPrint:Say((nLinIni + 212)/nTweb, (nColIni + 0020)/nTweb, "23 - Diagnóstico Cito/Histopatológico", oFont01) //23 - Diagnóstico Cito/Histopatológico
			For nI := 1 To MlCount(aDados[nX, 23, nX1], 110)
				cObs := MemoLine(aDados[nX, 23, nX1], 110, nI)
				oPrint:Say((nLinIni + 254)/nTweb, (nColIni + 0020)/nTweb, cObs, oFont01)
				nLinIni += 30
			Next nI

			nLinIni := nOldLin

			oPrint:Box((nLinIni + 208-nWeb)/nTweb, ((nColIni + nColMax)*0.4 + 0010)/nTweb, (nLinIni + 900-nWeb)/nTweb, ((nColIni + nColMax)*0.8 - 0010)/nTweb)
			oPrint:Say((nLinIni + 212)/nTweb, ((nColIni + nColMax)*0.4 + 0020)/nTweb, "24 - Informações relevantes", oFont01) //24 - Informações relevantes
			For nI := 1 To MlCount(aDados[nX, 24, nX1], 120)
				cObs := MemoLine(aDados[nX, 24, nX1], 120, nI)
				oPrint:Say((nLinIni + 254)/nTweb, ((nColIni + nColMax)*0.4 + 0020)/nTweb, cObs, oFont01)
				nLinIni += 30
			Next nI

			nLinIni := nOldLin

			AddTBrush(oPrint,  (nLinIni + 208)/nTweb, ((nColIni + nColMax)*0.8)/nTweb, (nLinIni + 240)/nTweb, (nColIni + nColMax - 0010)/nTweb)
			oPrint:Say((nLinIni + 208)/nTweb, ((nColIni + nColMax)*0.8 + 0010)/nTweb, "Tratamentos Anteriores", oFont01) //Tratamentos Anteriores

			fSomaLin(nLinMax, nColMax, @nLinIni, nColIni, 40, 80)
			oPrint:Box((nLinIni + 204-nWeb)/nTweb, ((nColIni + nColMax)*0.8)/nTweb, (nLinIni + 380-nWeb)/nTweb, ((nColIni + nColMax) - 0010)/nTweb)
			oPrint:Say((nLinIni + 214)/nTweb, ((nColIni + nColMax)*0.8 + 0020)/nTweb, "25 - Cirurgia", oFont01) //36- Cirurgia

			For nI := 1 To MlCount(aDados[nX, 25, nX1], 30)
				cObs := MemoLine(aDados[nX, 25, nX1], 30, nI)
				oPrint:Say((nLinIni + 240)/nTweb, ((nColIni + nColMax)*0.8 + 0030)/nTweb, cObs, oFont04)
				nLinIni += 30
				If nI == 5
					exit
				Endif
			Next nI

			nLinIni := 670

			fSomaLin(nLinMax, nColMax, @nLinIni, nColIni, 110, 80)
			oPrint:Box((nLinIni + 204-nWeb)/nTweb, ((nColIni + nColMax)*0.8)/nTweb, (nLinIni + 280-nWeb)/nTweb, ((nColIni + nColMax) - 0010)/nTweb)
			oPrint:Say((nLinIni + 214)/nTweb, ((nColIni + nColMax)*0.8 + 0020)/nTweb, "26 - Data da Realização", oFont01) //26 - Data da Realização
			oPrint:Say((nLinIni + 235)/nTweb, ((nColIni + nColMax)*0.8 + 0030)/nTweb, DtoC(aDados[nX, 26, nX1]), oFont04)

			fSomaLin(nLinMax, nColMax, @nLinIni, nColIni, 90, 80)
			oPrint:Box((nLinIni + 204-nWeb)/nTweb, ((nColIni + nColMax)*0.8)/nTweb, (nLinIni + 380-nWeb)/nTweb, ((nColIni + nColMax) - 0010)/nTweb)
			oPrint:Say((nLinIni + 214)/nTweb, ((nColIni + nColMax)*0.8 + 0020)/nTweb, "27 - Quimioterapia", oFont01) //27 - Quimioterapia

			For nI := 1 To MlCount(aDados[nX, 27, nX1], 30)
				cObs := MemoLine(aDados[nX, 27, nX1], 30, nI)
				oPrint:Say((nLinIni + 240)/nTweb, ((nColIni + nColMax)*0.8 + 0030)/nTweb, cObs, oFont04)
				nLinIni += 30
				If nI == 5
					exit
				Endif
			Next nI

			nLinIni := 960

			fSomaLin(nLinMax, nColMax, @nLinIni, nColIni, 110, 80)
			oPrint:Box((nLinIni + 204-nWeb)/nTweb, ((nColIni + nColMax)*0.8)/nTweb, (nLinIni + 290-nWeb)/nTweb, ((nColIni + nColMax) - 0010)/nTweb)
			oPrint:Say((nLinIni + 214)/nTweb, ((nColIni + nColMax)*0.8 + 0020)/nTweb, "28 - Data da Aplicação", oFont01) //28 - Data da Aplicação
			oPrint:Say((nLinIni + 235)/nTweb, ((nColIni + nColMax)*0.8 + 0030)/nTweb, DtoC(aDados[nX, 28, nX1]), oFont04)

			fSomaLin(nLinMax, nColMax, @nLinIni, nColIni, 200, 80)

			AddTBrush(oPrint,  (nLinIni + 197)/nTweb, (nColIni + 0010)/nTweb, (nLinIni + 230)/nTweb, (nColIni + nColMax - 0010)/nTweb)
			oPrint:Say((nLinIni + 200)/nTweb, (nColIni + 0020)/nTweb, "Procedimentos Complementares", oFont01) //Procedimentos Complementares

			fSomaLin(nLinMax, nColMax, @nLinIni, nColIni, 30, 80)
			oPrint:Box((nLinIni + 204-nWeb)/nTweb, (nColIni + 0010)/nTweb, (nLinIni + 600-nWeb)/nTweb, ((nColIni + nColMax)*0.5 - 0010)/nTweb)
			oPrint:Say((nLinIni + 210)/nTweb, (nColIni + 0040)/nTweb, "29-Data Prevista", oFont01) //29-Data Prevista
			oPrint:Say((nLinIni + 210)/nTweb, ((nColIni + nColMax)*0.09)/nTweb, "30-Tabela", oFont01) //30-Tabela
			oPrint:Say((nLinIni + 210)/nTweb, ((nColIni + nColMax)*0.13)/nTweb, "31-Código do Procedimento", oFont01) //31-Código do Procedimento
			oPrint:Say((nLinIni + 210)/nTweb, ((nColIni + nColMax)*0.22)/nTweb, "32-Descrição", oFont01) //32-Descrição
			oPrint:Say((nLinIni + 210)/nTweb, ((nColIni + nColMax)*0.40)/nTweb, "33-Qtde.", oFont01,,,,1) //33-Qtde.

			oPrint:Box((nLinIni + 204-nWeb)/nTweb, ((nColIni + nColMax)*0.5 + 0010)/nTweb, (nLinIni + 600-nWeb)/nTweb, (nColIni + nColMax - 0010)/nTweb)
			oPrint:Say((nLinIni + 210)/nTweb, ((nColIni + nColMax)*0.5 + 0040)/nTweb, "29-Data Prevista", oFont01) //29-Data Prevista
			oPrint:Say((nLinIni + 210)/nTweb, ((nColIni + nColMax)*0.58)/nTweb, "30-Tabela", oFont01) //30-Tabela
			oPrint:Say((nLinIni + 210)/nTweb, ((nColIni + nColMax)*0.63)/nTweb, "31-Código do Procedimento", oFont01) //31-Código do Procedimento
			oPrint:Say((nLinIni + 210)/nTweb, ((nColIni + nColMax)*0.72)/nTweb, "32-Descrição", oFont01) //32-Descrição
			oPrint:Say((nLinIni + 210)/nTweb, ((nColIni + nColMax)*0.89)/nTweb, "33-Qtde.", oFont01,,,,1) //33-Qtde.

			nCount := 0
			nOldLin := nLinIni

			For nN := nV To nAte

				If nCount < 6
					oPrint:Say((nLinIni + 250)/nTweb, (nColIni + 0012)/nTweb, AllTrim(Str(nN)) + " - ", oFont01)
					oPrint:Say((nLinIni + 250)/nTweb, (nColIni + 0040)/nTweb, DtoC(aDados[nX, 29, nX1, nN]), oFont04)
					oPrint:Say((nLinIni + 250)/nTweb, ((nColIni + nColMax)*0.09)/nTweb, aDados[nX, 30, nX1, nN], oFont04)
					oPrint:Say((nLinIni + 250)/nTweb, ((nColIni + nColMax)*0.13)/nTweb, aDados[nX, 31, nX1, nN], oFont04)
					oPrint:Say((nLinIni + 250)/nTweb, ((nColIni + nColMax)*0.22)/nTweb, aDados[nX, 32, nX1, nN], oFont01)
					oPrint:Say((nLinIni + 250)/nTweb, ((nColIni + nColMax)*0.40)/nTweb, IIf(Empty(aDados[nX, 33, nX1, nN]), "", Transform(aDados[nX, 33, nX1, nN], "@E 999.99")), oFont04,,,,1)
				Else
					If nCount == 6
						nLinIni := nOldLin
					EndIf
					oPrint:Say((nLinIni + 250)/nTweb, ((nColIni + nColMax)*0.5 + 0012)/nTweb, AllTrim(Str(nN)) + " - ", oFont01)
					oPrint:Say((nLinIni + 250)/nTweb, ((nColIni + nColMax)*0.5 + 0040)/nTweb, DtoC(aDados[nX, 29, nX1, nN]), oFont04)
					oPrint:Say((nLinIni + 250)/nTweb, ((nColIni + nColMax)*0.58)/nTweb, aDados[nX, 30, nX1, nN], oFont04)
					oPrint:Say((nLinIni + 250)/nTweb, ((nColIni + nColMax)*0.63)/nTweb, aDados[nX, 31, nX1, nN], oFont04)
					oPrint:Say((nLinIni + 250)/nTweb, ((nColIni + nColMax)*0.72)/nTweb, aDados[nX, 32, nX1, nN], oFont01)
					oPrint:Say((nLinIni + 250)/nTweb, ((nColIni + nColMax)*0.89)/nTweb, IIf(Empty(aDados[nX, 33, nX1, nN]), "", Transform(aDados[nX, 33, nX1, nN], "@E 999.99")), oFont04,,,,1)
				EndIf
				fSomaLin(nLinMax, nColMax, @nLinIni, nColIni, 60, 80)
				nCount++
			Next

			If nAte < Len(aDados[nX, 29, nX1])
				lImpNovo := .T.
				nAte += 12
				nV := nN
			EndIf

			fSomaLin(nLinMax, nColMax, @nLinIni, nColIni, 60, 80)

			oPrint:Box((nLinIni + 204-nWeb)/nTweb, (nColIni + 0010)/nTweb, (nLinIni + 300-nWeb)/nTweb, ((nColIni + nColMax)*0.12 - 0010)/nTweb)
			oPrint:Say((nLinIni + 214)/nTweb, (nColIni + 0020)/nTweb, "34 - Número de Campos", oFont01) //34 - Número de Campos
			oPrint:Say((nLinIni + 254)/nTweb, (nColIni + 0030)/nTweb, IIf(Empty(aDados[nX, 34, nX1]), "", Transform(aDados[nX, 34, nX1], "@E 999")), oFont04)
			oPrint:Box((nLinIni + 204-nWeb)/nTweb, ((nColIni + nColMax)*0.12 + 0010)/nTweb, (nLinIni + 300-nWeb)/nTweb, ((nColIni + nColMax)*0.22 - 0010)/nTweb)
			oPrint:Say((nLinIni + 214)/nTweb, ((nColIni + nColMax)*0.12 + 0020)/nTweb, "35 - Dose por dia (em Gy)", oFont01) //35 - Dose por dia (em Gy)
			oPrint:Say((nLinIni + 254)/nTweb, ((nColIni + nColMax)*0.12 + 0030)/nTweb, IIf(Empty(aDados[nX, 35, nX1]), "", Transform(aDados[nX, 35, nX1], "@E 9999")), oFont04)
			oPrint:Box((nLinIni + 204-nWeb)/nTweb, ((nColIni + nColMax)*0.22 + 0010)/nTweb, (nLinIni + 300-nWeb)/nTweb, ((nColIni + nColMax)*0.32 - 0010)/nTweb)
			oPrint:Say((nLinIni + 214)/nTweb, ((nColIni + nColMax)*0.22 + 0020)/nTweb, "36 - Dose Total ( em Gy)", oFont01) //36 - Dose Total ( em Gy)
			oPrint:Say((nLinIni + 254)/nTweb, ((nColIni + nColMax)*0.22 + 0030)/nTweb, IIf(Empty(aDados[nX, 36, nX1]), "", Transform(aDados[nX, 36, nX1], "@E 9999")), oFont04)
			oPrint:Box((nLinIni + 204-nWeb)/nTweb, ((nColIni + nColMax)*0.32 + 0010)/nTweb, (nLinIni + 300-nWeb)/nTweb, ((nColIni + nColMax)*0.40 - 0010)/nTweb)
			oPrint:Say((nLinIni + 214)/nTweb, ((nColIni + nColMax)*0.32 + 0020)/nTweb, "37 - Número de Dias", oFont01) //37 - Número de Dias
			oPrint:Say((nLinIni + 254)/nTweb, ((nColIni + nColMax)*0.32 + 0030)/nTweb, IIf(Empty(aDados[nX, 37, nX1]), "", Transform(aDados[nX, 37, nX1], "@E 999")), oFont04)
			oPrint:Box((nLinIni + 204-nWeb)/nTweb, ((nColIni + nColMax)*0.40 + 0010)/nTweb, (nLinIni + 300-nWeb)/nTweb, ((nColIni + nColMax)*0.58 - 0010)/nTweb)
			oPrint:Say((nLinIni + 214)/nTweb, ((nColIni + nColMax)*0.40 + 0020)/nTweb, "38 - Data Prevista para Início da Administração", oFont01) //38 - Data Prevista para Início da Administração
			oPrint:Say((nLinIni + 254)/nTweb, ((nColIni + nColMax)*0.40 + 0030)/nTweb, DtoC(aDados[nX, 38, nX1]), oFont04)

			fSomaLin(nLinMax, nColMax, @nLinIni, nColIni, 110, 80)
			AddTBrush(oPrint,  (nLinIni + 204)/nTweb, (nColIni + 0010)/nTweb, (nLinIni + 400)/nTweb, ((nColIni + nColMax) - 0010)/nTweb)
			oPrint:Box((nLinIni + 204-nWeb)/nTweb, (nColIni + 0010)/nTweb, (nLinIni + 400-nWeb)/nTweb, ((nColIni + nColMax) - 0010)/nTweb)
			oPrint:Say((nLinIni + 204)/nTweb, (nColIni + 0020)/nTweb, "39 - Observação / Justificativa", oFont01) //39 - Observação / Justificativa

			For nI := 1 To MlCount(aDados[nX, 39, nX1], 235)
				cObs := MemoLine(aDados[nX, 39, nX1], 235, nI)
				oPrint:Say((nLinIni + 235)/nTweb, (nColIni + 0030)/nTweb, cObs, oFont04)
				nLinIni += 30
				If nI == 5
					exit
				Endif
			Next nI

			nLinIni := 1990

			fSomaLin(nLinMax, nColMax, @nLinIni, nColIni, 50, 80)
			oPrint:Box((nLinIni + 204-nWeb)/nTweb, (nColIni + 0010)/nTweb, (nLinIni + 300-nWeb)/nTweb, ((nColIni + nColMax)*0.12 - 0010)/nTweb)
			oPrint:Say((nLinIni + 214)/nTweb, (nColIni + 0020)/nTweb, "40 - Data da Solicitação", oFont01) //39 - Data da Solicitação
			oPrint:Say((nLinIni + 254)/nTweb, (nColIni + 0030)/nTweb, DtoC(aDados[nX, 40, nX1]), oFont04)
			oPrint:Box((nLinIni + 204-nWeb)/nTweb, ((nColIni + nColMax)*0.12 + 0010)/nTweb, (nLinIni + 300-nWeb)/nTweb, ((nColIni + nColMax)*0.55 - 0010)/nTweb)
			oPrint:Say((nLinIni + 214)/nTweb, ((nColIni + nColMax)*0.12 + 0020)/nTweb, "41-Assinatura do Profissional Solicitante", oFont01) //40-Assinatura do Profissional Solicitante
			oPrint:Box((nLinIni + 204-nWeb)/nTweb, ((nColIni + nColMax)*0.55 + 0010)/nTweb, (nLinIni + 300-nWeb)/nTweb, (nColIni + nColMax - 0010)/nTweb)
			oPrint:Say((nLinIni + 214)/nTweb, ((nColIni + nColMax)*0.55 + 0020)/nTweb, "42-Assinatura do Autorizador da Operadora", oFont01) //41-Assinatura do Autorizador da Operadora

			oPrint:EndPage()	// Finaliza a pagina

		EndDo
	Next

	oPrint:EndPage()	// Finaliza a pagina

Next

If lWeb
	oPrint:Print()
Else
	oPrint:Preview()
Endif

Return cFileName
*/
//-------------------------------------------------------------------
/*/{Protheus.doc} PLTISRGLO
Estrutura para montar a guia de recurso de glosa

@author  PLS TEAM
@version P11
@since   16.04.00
/*/
//-------------------------------------------------------------------
/*Function PLTISRGLO(aDados, nLayout, cLogoGH,lWeb, cPathRelW)

Local nN,nV,nX,nX1	//nI,
Local nLinMax	:= 0
Local nColMax	:= 0
Local nLinIni	:= 0		// Linha Lateral (inicial) Esquerda
Local nColIni	:= 0		// Coluna Lateral (inicial) Esquerda
Local nOldLin	:= 0
Local nColA4    := 0
Local nWeb		:= 25
Local cFileLogo	:= ''
Local lImpNovo 	:= .t.
Local oFont01	:= nil
Local oFont02n	:= nil
Local oFont03n	:= nil
Local oFont04	:= nil
Local cRel      := "guiareglo"
Local cPathSrvJ := GETMV("MV_RELT")
Local nTweb		:= 3.9
Local nLweb		:= 0
Local nLwebC	:= 0
Local oPrint	:= NIL

default lWeb    	:= .f.
default cPathRelW 	:= ''
default nLayout 	:= 2
default cLogoGH 	:= ''
default	aDados  	:= { {;
	"123456",; //1 - Registro ANS
	"01234567890123456789",; //2 - N Guia no Prestador
	Replicate("M", 70),; //3 - Nome da Operadora
	"1",; //4 - Objeto do Recurso
	"01234567890123456789",; //5 - Numero da Guia de Recurso de Glosas Atribuido pela Operadora
	"01234567890123",; //6 - Codigo na Operadora
	Replicate("M", 70),; //7 - Nome do Contratado
	"012345678901",; //8 - Numero do Lote
	"012345678901",; //9 - Numero do protocolo
	"0123",; //10 - Codigo da Glosa do Protocolo
	Replicate("M", 150),; //11 - Justificativa (no caso de recurso integral do protocolo)
	"S",; //12 - Acatado
	Replicate("M", 20),; //13 - Numero da guia no prestador
	Replicate("M", 20),; //14 - Numero da guia atribuido pela operadora
	Replicate("M", 20),; //15 - Senha
	"2222",; //16 - codigo da glosa da guia
	Replicate("M", 150),; //17 - justificativa (nocaso de recurso integral da guia)
	"S",; //18 - Acatado
	{CtoD("06/02/2014"),CtoD("06/02/2014"),CtoD("06/02/2014"),CtoD("06/02/2014"),CtoD("06/02/2014"),CtoD("06/02/2014"),CtoD("06/02/2014"),CtoD("06/02/2014"),CtoD("06/02/2014"),CtoD("06/02/2014"),CtoD("06/02/2014"),CtoD("06/02/2014")},; //19 - Data de realizacao
	{CtoD("06/02/2014"),CtoD("06/02/2014"),CtoD("06/02/2014"),CtoD("06/02/2014"),CtoD("06/02/2014"),CtoD("06/02/2014"),CtoD("06/02/2014"),CtoD("06/02/2014"),CtoD("06/02/2014"),CtoD("06/02/2014"),CtoD("06/02/2014"),CtoD("06/02/2014")},; //20 - Data final periodo
	{"14","99","99","99","99","88","99","99","77","99","99","25"},; //21 - Tabela
	{"0123456789","0123456789","0123456789","0123456789","0123456789","0123456789","0123456789","0123456789","0123456789","0123456789","0123456789","0123456789"},; //22 - Procedimento/item assistencial
	{Replicate("M", 150),Replicate("M", 150),Replicate("M", 150),Replicate("M", 150),Replicate("M", 150),Replicate("M", 150),Replicate("M", 150),Replicate("M", 150),Replicate("M", 150),Replicate("M", 150),Replicate("M", 150),Replicate("M", 150)},; //23 - Descricao
	{"H1","O1","C1","U1","C1","C1","H1","11","21","S1","G1","D1"},; //24 - Grau de Participação
	{"0011","0012","0013","0013","0013","0013","0013","0031","0031","0031","0031","0031"},; //25 - Codigo
	{111111.99, 111111.99, 111111.99, 111111.99, 111111.99, 111111.99, 111111.99, 111111.99, 111111.99, 111111.99, 111111.99, 111111.99},; //26 - Valor Recursado
	{Replicate("M", 150),Replicate("M", 150),Replicate("M", 150),Replicate("M", 150),Replicate("M", 150),Replicate("M", 150),Replicate("M", 150),Replicate("M", 150),Replicate("M", 150),Replicate("M", 150),Replicate("M", 150),Replicate("M", 150)},; //27 - Justificativa do Prestador
	{111111.99, 111111.99, 111111.99, 111111.99, 111111.99, 111111.99, 111111.99, 111111.99, 111111.99, 111111.99, 111111.99, 111111.99},; //28 - Valor Acatado
	{Replicate("M", 450),Replicate("M", 450),Replicate("M", 450),Replicate("M", 450),Replicate("M", 450),Replicate("M", 450),Replicate("M", 450),Replicate("M", 450),Replicate("M", 450),Replicate("M", 450),Replicate("M", 450),Replicate("M", 450)},; //29 - Justificativa da Operadora
	11111111.99,; //30 - Valor Total Recursado (R$)
	11111111.99,; //31 - Valor Total Acatado (R$)
	CtoD("06/02/2014"),; //32 - Data do Recurso
	'',; //33-Assinatura do Contratado
	CtoD("06/02/2014"),; //34 - Data da Assinatura da Operadora
	'' } } //35-Assinatura da Operadora

oFont01 := TFont():New("Arial",  6,  6, , .F., , , , .T., .F.) // Normal


//Nao permite acionar a impressao quando for na web.
if lWeb
	cPathSrvJ := cPathRelW
	cFileName := cRel+lower(CriaTrab(NIL,.F.))+".pdf"
else
	cFileName := cRel+CriaTrab(NIL,.F.)
endIf
//New ( < cFilePrintert >, [ nDevice], [ lAdjustToLegacy], [ cPathInServer], [ lDisabeSetup ], [ lTReport], [ @oPrintSetup], [ cPrinter], [ lServer], [ lPDFAsPNG], [ lRaw], [ lViewPDF] )
if lWeb
	oPrint := FWMSPrinter():New( cFileName,,.f.,cPathSrvJ,.t.,,@oPrint,,,.f.,.f.)

	If lSrvUnix
		AjusPath(@oPrint)
	EndIf
	oPrint:cPathPDF 	:= cPathSrvJ
	nColMax			:= 2980
else
	oPrint := FWMSPrinter():New( cFileName,,.f.,cPathSrvJ,.t.,,,,,.f.,,)
endIf

oPrint:lServer 	:= lWeb

oPrint:setLandscape()		// Modo paisagem

if nLayout == 2
	oPrint:setPaperSize(9)// Papél A4
elseIf nLayout == 3
	oPrint:setPaperSize(1)// Papél Carta
endif

//Device
if lWeb
	oPrint:setDevice(IMP_PDF)
else
	oPrint:Setup()

	if !(oPrint:nModalResult == 1)// Botao cancelar da janela de config. de impressoras.
		return
	else
		lImpnovo := (oPrint:nModalResult == 1)
	endif
endif

If oPrint:nPaperSize  == 9 // Papel A4
	nLinMax	:= 2270
	nColMax	:= 3100
	nLayout 	:= 2
	oFont02n	:= TFont():New("Arial", 12, 12, , .T., , , , .T., .F.) // Negrito
	oFont03n	:= TFont():New("Arial", 13, 13, , .T., , , , .T., .F.) // Negrito
	oFont04	:= TFont():New("Arial", 07, 07, , .F., , , , .T., .F.) // Normal
Elseif oPrint:nPaperSize == 1 // Papel Carta
	nLinMax	:= 2275
	nColMax	:= 2950
	nLayout 	:= 3
	oFont02n	:= TFont():New("Arial", 12, 12, , .T., , , , .T., .F.) // Negrito
	oFont03n	:= TFont():New("Arial", 13, 13, , .T., , , , .T., .F.) // Negrito
	oFont04	:= TFont():New("Arial", 07, 07, , .F., , , , .T., .F.) // Normal
Else // Papel Oficio2 216 x 330mm / 8 1/2 x 13in
	nLinMax	:= 2150
	nColMax	:= 2800
	nLayout 	:= 1
	oFont02n	:= TFont():New("Arial", 12, 12, , .T., , , , .T., .F.) // Negrito
	oFont03n	:= TFont():New("Arial", 14, 14, , .T., , , , .T., .F.) // Negrito
	oFont04	:= TFont():New("Arial", 09, 09, , .F., , , , .T., .F.) // Normal
Endif

if lWeb
	nColMax := 2980
EndIf

For nX := 1 To Len(aDados)
	If ValType(aDados[nX]) == 'U' .OR. Len(aDados[nX]) == 0
		Loop
	EndIf

	For nX1 := 1 To Len(aDados[nX, 02])

		nAte:= 12
		nV 	:= 1

		While lImpNovo

			lImpNovo := .F.

			nLinIni  := 080
			nColIni  := 080
			nColA4   := 000

			//Inicia uma nova pagina
			oPrint:StartPage()

			//Box Principal
			oPrint:Box((nLinIni/nTweb), nColIni/nTweb, (nLinIni + nLinMax)/nTweb, (nColIni + nColMax)/nTweb)

			//Carrega e Imprime Logotipo da Empresa
			fLogoEmp(@cFileLogo,, cLogoGH)

			If File(cFilelogo)
				oPrint:SayBitmap((nLinIni + 0050)/nTweb, (nColIni + 0020)/nTweb, cFileLogo, (400)/nTweb, (090)/nTweb) 		// Tem que estar abaixo do RootPath
			EndIf

			// Papél A4
			If nLayout == 2
				nColA4    := -0335
			// Carta
			Elseif nLayout == 3
				nColA4    := -0530
			Endif

			oPrint:Say((nLinIni + 0080)/nTweb, ((nColIni + nColMax)*0.47)/nTweb, "GUIA DE RECURSO DE GLOSAS", oFont02n,,,, 2)
			oPrint:Say((nLinIni + 0070)/nTweb, (nColMax - 750)/nTweb, "2- Nº Guia no Prestador", oFont01) //2- Nº Guia no Prestador
			oPrint:Say((nLinIni + 0070)/nTweb, (nColMax - 480)/nTweb, aDados[nX, 02], oFont03n)

			oPrint:Box((nLinIni + 0175 -nWeb)/nTweb, (nColIni + 0010)/nTweb, (nLinIni + 0269-nWeb)/nTweb, ((nColIni + nColMax)*0.1 - 0010)/nTweb)
			oPrint:Say((nLinIni + 0180)/nTweb, (nColIni + 0020)/nTweb, "1 - Registro ANS", oFont01) //1 - Registro ANS
			oPrint:Say((nLinIni + 0220)/nTweb, (nColIni + 0030)/nTweb, aDados[nX, 01], oFont04)

			oPrint:Box((nLinIni + 0175-nWeb)/nTweb, ((nColIni + nColMax)*0.1)/nTweb, (nLinIni + 0269-nWeb)/nTweb, ((nColIni + nColMax)*0.65 - 0010)/nTweb)
			oPrint:Say((nLinIni + 0180)/nTweb, ((nColIni + nColMax)*0.1 + 0020)/nTweb, "3 - Nome da Operadora", oFont01) //3 - Nome da Operadora
			oPrint:Say((nLinIni + 0220)/nTweb, ((nColIni + nColMax)*0.1 + 0030)/nTweb, aDados[nX, 03], oFont04)

			oPrint:Box((nLinIni + 0175-nWeb)/nTweb, ((nColIni + nColMax)*0.65)/nTweb, (nLinIni + 0269-nWeb)/nTweb, ((nColIni + nColMax)*0.73 - 0010)/nTweb)
			oPrint:Say((nLinIni + 0180)/nTweb, ((nColIni + nColMax)*0.65 + 0020)/nTweb, "4 - Objeto do Recurso", oFont01) //4 - Objeto do Recurso
			oPrint:Say((nLinIni + 0220)/nTweb, ((nColIni + nColMax)*0.65 + 0030)/nTweb, aDados[nX, 04], oFont04)

			oPrint:Box((nLinIni + 0175-nWeb)/nTweb, ((nColIni + nColMax)*0.73)/nTweb, (nLinIni + 0269-nWeb)/nTweb, ((nColIni + nColMax)*0.97 - 0010)/nTweb)
			oPrint:Say((nLinIni + 0180)/nTweb, ((nColIni + nColMax)*0.73 + 0020)/nTweb, "5 - Número da Guia de Recurso de Glosas Atribuido pela Operadora", oFont01) //5 - Número da Guia de Recurso de Glosas Atribuido pela Operadora
			oPrint:Say((nLinIni + 0220)/nTweb, ((nColIni + nColMax)*0.73 + 0030)/nTweb, aDados[nX, 05], oFont04)

			fSomaLin(nLinMax, nColMax, @nLinIni, nColIni, 100, 80)
			AddTBrush(oPrint, (nLinIni + 175)/nTweb, (nColIni + 0010)/nTweb, (nLinIni + 206)/nTweb, (nColIni + nColMax)/nTweb)
			oPrint:Say((nLinIni + 195)/nTweb, (nColIni + 0020)/nTweb, "Dados do Contratado", oFont01) //Dados do Contratado

			oPrint:Box((nLinIni + 238-nWeb)/nTweb, (nColIni + 0010)/nTweb, (nLinIni + 330-nWeb)/nTweb, ((nColIni + nColMax)*0.25 - 0010)/nTweb)
			oPrint:Say((nLinIni + 242)/nTweb, (nColIni + 0020)/nTweb, "6 - Código na Operadora", oFont01) //6 - Código na Operadora
			oPrint:Say((nLinIni + 282)/nTweb, (nColIni + 0030)/nTweb, aDados[nX, 06], oFont04)

			oPrint:Box((nLinIni + 238-nWeb)/nTweb, ((nColIni + nColMax)*0.25)/nTweb, (nLinIni + 330-nWeb)/nTweb, ((nColIni + nColMax)*0.85 - 0010)/nTweb)
			oPrint:Say((nLinIni + 242)/nTweb, ((nColIni + nColMax)*0.25 + 0020)/nTweb, "7 - Nome do Contratado", oFont01) //7 - Nome do Contratado
			oPrint:Say((nLinIni + 282)/nTweb, ((nColIni + nColMax)*0.25 + 0030)/nTweb, aDados[nX, 07], oFont04)

			fSomaLin(nLinMax, nColMax, @nLinIni, nColIni, 150, 80)

			AddTBrush(oPrint, (nLinIni + 175)/nTweb, (nColIni + 0010)/nTweb, (nLinIni + 206)/nTweb, (nColIni + nColMax)/nTweb)
			oPrint:Say((nLinIni + 195)/nTweb, (nColIni + 0020)/nTweb, "Dados do recurso do protocolo", oFont01) //Dados do recurso do protocolo

			oPrint:Box((nLinIni + 238-nWeb)/nTweb, (nColIni + 0010)/nTweb, (nLinIni + 330-nWeb)/nTweb, ((nColIni + nColMax)*0.100 - 0010)/nTweb)
			oPrint:Say((nLinIni + 242)/nTweb, (nColIni + 0020)/nTweb, "8 - Número do Lote", oFont01) //8 - Número do Lote
			oPrint:Say((nLinIni + 282)/nTweb, (nColIni + 0030)/nTweb, aDados[nX, 08], oFont04)

			oPrint:Box((nLinIni + 238-nWeb)/nTweb, ((nColIni + nColMax)*0.100 + 0010)/nTweb, (nLinIni + 330-nWeb)/nTweb, ((nColIni + nColMax)*0.20 - 0010)/nTweb)
			oPrint:Say((nLinIni + 242)/nTweb, ((nColIni + nColMax)*0.100 + 0020)/nTweb, "9 - Número do Protocolo", oFont01) //9 - Número do Protocolo
			oPrint:Say((nLinIni + 282)/nTweb, ((nColIni + nColMax)*0.100 + 0030)/nTweb, aDados[nX, 09], oFont04)

			oPrint:Box((nLinIni + 238-nWeb)/nTweb, ((nColIni + nColMax)*0.20 + 0010)/nTweb, (nLinIni + 330-nWeb)/nTweb, ((nColIni + nColMax)*0.35 - 0010)/nTweb)
			oPrint:Say((nLinIni + 242)/nTweb, ((nColIni + nColMax)*0.20 + 0020)/nTweb, "10 - Código da Glosa do Protocolo", oFont01) //10 - Código da Glosa do Protocolo
			oPrint:Say((nLinIni + 282)/nTweb, ((nColIni + nColMax)*0.20 + 0030)/nTweb, aDados[nX, 10], oFont04)

			oPrint:Box((nLinIni + 238-nWeb)/nTweb, ((nColIni + nColMax)*0.35 + 0010)/nTweb, (nLinIni + 330-nWeb)/nTweb, ((nColIni + nColMax)*0.94 - 0010)/nTweb)
			oPrint:Say((nLinIni + 242)/nTweb, ((nColIni + nColMax)*0.35 + 0020)/nTweb, "11 - Justificativa (no caso de recurso integral do protocolo)", oFont01) //11 - Justificativa (no caso de recurso integral do protocolo)
			oPrint:Say((nLinIni + 282)/nTweb, ((nColIni + nColMax)*0.35 + 0030)/nTweb, left(aDados[nX, 11],75), oFont04)

			oPrint:Box((nLinIni + 238-nWeb)/nTweb, ((nColIni + nColMax)*0.94 + 0010)/nTweb, (nLinIni + 330-nWeb)/nTweb, ((nColIni + nColMax) - 0010)/nTweb)
			oPrint:Say((nLinIni + 242)/nTweb, ((nColIni + nColMax)*0.94 + 0020)/nTweb, "12 -  Acatado", oFont01) //12 -  Acatado
			oPrint:Say((nLinIni + 282)/nTweb, ((nColIni + nColMax)*0.94 + 0030)/nTweb, aDados[nX, 12], oFont04)

			fSomaLin(nLinMax, nColMax, @nLinIni, nColIni, 150, 80)

			AddTBrush(oPrint,  (nLinIni + 175)/nTweb, (nColIni + 0010)/nTweb, (nLinIni + 206)/nTweb, (nColIni + nColMax)/nTweb)
			oPrint:Say((nLinIni + 195)/nTweb, (nColIni + 0020)/nTweb, "Dados do recurso da guia", oFont01) //Dados do recurso da guia

			oPrint:Box((nLinIni + 238-nWeb)/nTweb, (nColIni + 0010)/nTweb, (nLinIni + 330-nWeb)/nTweb, ((nColIni + nColMax)*0.20 - 0010)/nTweb)
			oPrint:Say((nLinIni + 242)/nTweb, (nColIni + 0020)/nTweb, "13- Número da guia no prestador", oFont01) //13- Número da guia no prestador
			oPrint:Say((nLinIni + 282)/nTweb, (nColIni + 0030)/nTweb, aDados[nX, 13], oFont04)

			oPrint:Box((nLinIni + 238-nWeb)/nTweb, ((nColIni + nColMax)*0.20 + 0010)/nTweb, (nLinIni + 330-nWeb)/nTweb, ((nColIni + nColMax)*0.60 - 0010)/nTweb)
			oPrint:Say((nLinIni + 242)/nTweb, ((nColIni + nColMax)*0.20 + 0020)/nTweb, "14- Número da guia atribuído pela operadora", oFont01) //14- Número da guia atribuído pela operadora
			oPrint:Say((nLinIni + 282)/nTweb, ((nColIni + nColMax)*0.20 + 0030)/nTweb, aDados[nX, 14], oFont04)

			oPrint:Box((nLinIni + 238-nWeb)/nTweb, ((nColIni + nColMax)*0.60)/nTweb, (nLinIni + 330-nWeb)/nTweb, (nColIni + nColMax - 0010)/nTweb)
			oPrint:Say((nLinIni + 242)/nTweb, ((nColIni + nColMax)*0.60 + 0020)/nTweb, "15-Senha", oFont01) //15-Senha
			oPrint:Say((nLinIni + 282)/nTweb, ((nColIni + nColMax)*0.60 + 0030)/nTweb, aDados[nX, 15], oFont04)

			fSomaLin(nLinMax, nColMax, @nLinIni, nColIni, 105, 80)

			oPrint:Box((nLinIni + 238-nWeb)/nTweb, (nColIni + 0010)/nTweb, (nLinIni + 330-nWeb)/nTweb, ((nColIni + nColMax)*0.12 - 0010)/nTweb)
			oPrint:Say((nLinIni + 242)/nTweb, (nColIni + 0020)/nTweb, "16-Código da glosa da guia", oFont01) //16-Código da glosa da guia
			oPrint:Say((nLinIni + 282)/nTweb, (nColIni + 0020)/nTweb, aDados[nX, 16], oFont04)

			oPrint:Box((nLinIni + 238-nWeb)/nTweb, ((nColIni + nColMax)*0.12)/nTweb, (nLinIni + 330-nWeb)/nTweb, ((nColIni + nColMax)*0.94 - 0010)/nTweb)
			oPrint:Say((nLinIni + 242)/nTweb, ((nColIni + nColMax)*0.12 + 0020)/nTweb, "17-Justificativa (no caso de recurso integral da guia)", oFont01) //17-Justificativa (no caso de recurso integral da guia)
			oPrint:Say((nLinIni + 282)/nTweb, ((nColIni + nColMax)*0.12 + 0030)/nTweb, left(aDados[nX, 17],105), oFont04)

			oPrint:Box((nLinIni + 238-nWeb)/nTweb, ((nColIni + nColMax)*0.94)/nTweb, (nLinIni + 330-nWeb)/nTweb, (nColIni + nColMax - 0010)/nTweb)
			oPrint:Say((nLinIni + 242)/nTweb, ((nColIni + nColMax)*0.94 + 0020)/nTweb, "18-Acatado", oFont01) //18-Acatado
			oPrint:Say((nLinIni + 282)/nTweb, ((nColIni + nColMax)*0.94 + 0030)/nTweb, aDados[nX, 18], oFont04)

			fSomaLin(nLinMax, nColMax, @nLinIni, nColIni, 150, 80)

			AddTBrush(oPrint,  (nLinIni + 175)/nTweb, (nColIni + 0010)/nTweb, (nLinIni + 206)/nTweb, (nColIni + nColMax)/nTweb)
			oPrint:Say((nLinIni + 195)/nTweb, (nColIni + 0020)/nTweb, "Dados do recurso do procedimento ou item assistencial", oFont01) //Dados do recurso do procedimento ou item assistencial

			oPrint:Box((nLinIni + 238-nWeb)/nTweb, (nColIni + 0010)/nTweb, (nLinIni + 1200-nWeb)/nTweb, ( (nColIni + nColMax)-0010)/nTweb)
			oPrint:Say((nLinIni + 242)/nTweb, (nColIni + 0040)/nTweb, "19-Data de realização", oFont01) //19-Data de realização
			oPrint:Say((nLinIni + 242)/nTweb, ((nColIni + nColMax)*0.11)/nTweb, "20-Data final período", oFont01) //20-Data final período
			oPrint:Say((nLinIni + 242)/nTweb, ((nColIni + nColMax)*0.18)/nTweb, "21-Tabela", oFont01) //21-Tabela
			oPrint:Say((nLinIni + 242)/nTweb, ((nColIni + nColMax)*0.22)/nTweb, "22-Procedimento/Item assistencial", oFont01) //22-Procedimento/Item assistencial
			oPrint:Say((nLinIni + 242)/nTweb, ((nColIni + nColMax)*0.33)/nTweb, "23-Descrição", oFont01,,,,1) //23-Descrição
			oPrint:Say((nLinIni + 242)/nTweb, ((nColIni + nColMax)*0.90)/nTweb, "24-Grau de Participação", oFont01,,,,1) //24-Grau de Participação

			fSomaLin(nLinMax, nColMax, @nLinIni, nColIni, 20, 80)

			oPrint:Say((nLinIni + 242)/nTweb, (nColIni + 0040)/nTweb, "25-Código da glosa", oFont01,,,,1) //25-Código da glosa
			oPrint:Say((nLinIni + 242)/nTweb, ((nColIni + nColMax)*0.11)/nTweb, "26-Valor Recursado", oFont01,,,,1) //26-Valor Recursado
			oPrint:Say((nLinIni + 242)/nTweb, ((nColIni + nColMax)*0.18)/nTweb, "27-Justificativa do Prestador", oFont01,,,,1) //27-Justificativa do Prestador
			oPrint:Say((nLinIni + 242)/nTweb, ((nColIni + nColMax)*0.57)/nTweb, "28-Valor Acatado", oFont01,,,,1) //28-Valor Acatado
			oPrint:Say((nLinIni + 242)/nTweb, ((nColIni + nColMax)*0.63)/nTweb, "29-Justificativa da Operadora", oFont01,,,,1) //29-Justificativa da Operadora

			nOldLin := nLinIni

			for nN := nV to nAte

				if nN > len(aDados[nX, 19])
					fSomaLin(nLinMax, nColMax, @nLinIni, nColIni, 25, 80)
					fSomaLin(nLinMax, nColMax, @nLinIni, nColIni, 50, 80)
					loop
				endIf

				oPrint:Say((nLinIni + 282)/nTweb, (nColIni + 0012)/nTweb, AllTrim(Str(nN)) + " - ", oFont01)

				oPrint:Say((nLinIni + 282)/nTweb, (nColIni + 0040)/nTweb, DtoC(aDados[nX, 19, nN]), oFont04)
				oPrint:Say((nLinIni + 282)/nTweb, ((nColIni + nColMax)*0.11)/nTweb, Dtoc(aDados[nX, 20, nN]), oFont04)
				oPrint:Say((nLinIni + 282)/nTweb, ((nColIni + nColMax)*0.18)/nTweb, aDados[nX, 21, nN], oFont04)
				oPrint:Say((nLinIni + 282)/nTweb, ((nColIni + nColMax)*0.22)/nTweb, aDados[nX, 22, nN], oFont01)
				oPrint:Say((nLinIni + 282)/nTweb, ((nColIni + nColMax)*0.33)/nTweb, left(aDados[nX, 23, nN],98), oFont01)
				oPrint:Say((nLinIni + 282)/nTweb, ((nColIni + nColMax)*0.90)/nTweb, aDados[nX, 24, nN], oFont01)

				fSomaLin(nLinMax, nColMax, @nLinIni, nColIni, 25, 80)

				oPrint:Say((nLinIni + 282)/nTweb, (nColIni + 0040)/nTweb, aDados[nX, 25, nN], oFont01)
				oPrint:Say((nLinIni + 282)/nTweb, ((nColIni + nColMax)*0.11)/nTweb, Transform(aDados[nX, 26, nN], "@E 99,999,999.99"), oFont01)
				oPrint:Say((nLinIni + 282)/nTweb, ((nColIni + nColMax)*0.18)/nTweb, left(aDados[nX, 27, nN],67), oFont01)
				oPrint:Say((nLinIni + 282)/nTweb, ((nColIni + nColMax)*0.57)/nTweb, Transform(aDados[nX, 28, nN], "@E 99,999,999.99"), oFont01)
				oPrint:Say((nLinIni + 282)/nTweb, ((nColIni + nColMax)*0.63)/nTweb, left(aDados[nX, 29, nN],63), oFont01)

				fSomaLin(nLinMax, nColMax, @nLinIni, nColIni, 50, 80)

			next

			if nAte < len(aDados[nX, 19])
				lImpNovo := .T.
				nAte += 12
				nV := nN
			endIf

			fSomaLin(nLinMax, nColMax, @nLinIni, nColIni, 60, 80)

			oPrint:Box((nLinIni + 238-nWeb)/nTweb, (nColIni + 0010)/nTweb, (nLinIni + 330-nWeb)/nTweb, ((nColIni + nColMax)*0.14 - 0010)/nTweb)
			oPrint:Say((nLinIni + 242)/nTweb, (nColIni + 0020)/nTweb, "30 - Valor Total Recursado (R$)", oFont01) //30 - Valor Total Recursado (R$)
			oPrint:Say((nLinIni + 282)/nTweb, (nColIni + 0030)/nTweb, IIf(Empty(aDados[nX, 30]), "", Transform(aDados[nX, 30], "@E 99,999,999.99")), oFont04)

			oPrint:Box((nLinIni + 238-nWeb)/nTweb, ((nColIni + nColMax)*0.14)/nTweb, (nLinIni + 330-nWeb)/nTweb, ((nColIni + nColMax)*0.30 - 0010)/nTweb)
			oPrint:Say((nLinIni + 242)/nTweb, ((nColIni + nColMax)*0.14 + 0020)/nTweb, "31 - Valor Total  Acatado (R$)", oFont01) //31 - Valor Total  Acatado (R$)
			oPrint:Say((nLinIni + 282)/nTweb, ((nColIni + nColMax)*0.14 + 0030)/nTweb, IIf(Empty(aDados[nX, 31]), "", Transform(aDados[nX, 31], "@E 99,999,999.99")), oFont04)

			fSomaLin(nLinMax, nColMax, @nLinIni, nColIni, 109, 80)

			oPrint:Box((nLinIni + 238-nWeb)/nTweb, (nColIni + 0010)/nTweb, (nLinIni + 330-nWeb)/nTweb, ((nColIni + nColMax)*0.11 - 0010)/nTweb)
			oPrint:Say((nLinIni + 242)/nTweb, (nColIni + 0020)/nTweb, "32 - Data do Recurso", oFont01) //32 - Data do Recurso
			oPrint:Say((nLinIni + 282)/nTweb, (nColIni + 0030)/nTweb, DtoC(aDados[nX, 32]), oFont04)

			oPrint:Box((nLinIni + 238-nWeb)/nTweb, ((nColIni + nColMax)*0.11)/nTweb, (nLinIni + 330-nWeb)/nTweb, ((nColIni + nColMax)*0.40 - 0010)/nTweb)
			oPrint:Say((nLinIni + 242)/nTweb, ((nColIni + nColMax)*0.11 + 0020)/nTweb, "33 - Assinatura do Contratado", oFont01) //33 - Assinatura do Contratado

			oPrint:Box((nLinIni + 238-nWeb)/nTweb, ((nColIni + nColMax)*0.40)/nTweb, (nLinIni + 330-nWeb)/nTweb, ((nColIni + nColMax) - 0010)/nTweb)
			oPrint:Say((nLinIni + 242)/nTweb, ((nColIni + nColMax)*0.40 + 0020)/nTweb, "34 - Data da Assinatura da Operadora", oFont01) //34 - Data da Assinatura da Operadora
			oPrint:Say((nLinIni + 282)/nTweb, ((nColIni + nColMax)*0.40 + 0030)/nTweb, DtoC(aDados[nX, 34]), oFont04)

			fSomaLin(nLinMax, nColMax, @nLinIni, nColIni, 140, 80)

			oPrint:Box((nLinIni + 204-nWeb)/nTweb, (nColIni + 0010)/nTweb, (nLinIni + 400-nWeb)/nTweb, ((nColIni + nColMax) - 0010)/nTweb)
			oPrint:Say((nLinIni + 204)/nTweb, (nColIni + 0020)/nTweb, "35 -  Assinatura da Operadora", oFont01) //35 -  Assinatura da Operadora

			oPrint:EndPage()	// Finaliza a pagina

		EndDo
	Next

	oPrint:EndPage()	// Finaliza a pagina

Next

if lWeb
	oPrint:Print()
else
	oPrint:Preview()
endif

return cFileName
*/
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡ao    ³ PLSTISSP  ³ Autor ³ MAICON SANTOS        ³ Data ³ 16.10.14  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡ao ³ Estrutura Relatório TISS 3.00.01 (Guia Prog. Internaçao)    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ SigaPLS                                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ aDados - Array com as informações do relat´rio              ³±±
±±³          ³ lGerTXT - Define se imprime direto sem passar pela tela	 ³±±
±±³          ³			 de configuracao/preview do relatorio 		        ³±±
±±³          ³ nLayout - Define o formato de papél para impressao:         ³±±
±±³          ³           1 - Formato Ofício II (216x330mm)                 ³±±
±±³          ³           2 - Formato A4 (210x297mm)                        ³±±
±±³          ³  		 	3 - Formato Carta (216x279mm)     			        ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function CABTISSP(aDados, lGerTXT, nLayout, cLogoGH, lMail, lWeb, cPathRelW )

Local nLinMax
Local nColMax
Local nLinIni	:=	0	// Linha Lateral (inicial) Esquerda
Local nColIni	:=	0	// Coluna Lateral (inicial) Esquerda
Local nColA4    :=  0
Local nLinA4    :=  0
Local cFileLogo
Local nLin
Local nP:=0
Local nT:=0
Local nT1:=0
Local nT3:=0
Local nI,nJ,nK,nX
Local nR,nV,nV1,nV2,nN
Local cObs
Local oFont01
Local oFont02n
Local oFont03n
Local oFont04
Local lImpnovo  :=.T.
Local nVolta    :=0
Local cFile 	:= GetNewPar("MV_RELT",'\SPOOL\')+'PLSR421N.HTM'
Local lRet		:= .T.
Local lOk		:= .T.
LOCAL cFileName	:= ""
LOCAL cRel      := "GUICONS"
LOCAL cPathSrvJ := GETMV("MV_RELT")
LOCAL nAL		:= 0.25
LOCAL nAC		:= 0.24
Local lImpPrc   := .T.
LOCAL nLinObs	:= 0
LOCAL cIndic    := ""
LOCAL I			:=0
LOCAL J			:=0
LOCAL cErro		:= ""
LOCAL cArq			:= ""
//Local bError		:= ErrorBlock( {|e| TrataErro(e,@cErro) } )
Local nLinB		:= 0
DEFAULT lGerTXT 	:= .F.
DEFAULT nLayout 	:= 2
DEFAULT cLogoGH 	:= ""
DEFAULT lMail		:= .F.
DEFAULT lWeb		:= .F.
DEFAULT cPathRelW 	:= ""
DEFAULT aDados 	:= { { ;
	"123456",; 				 //1 - Registro ANS
	"12345678901234567890",; //2 - Nº Guia no Prestador
	"12345678901234567890",; //3 - Número da Guia de Solicitação de Internação
	CtoD("01/01/07"),; 		 //4 - Data da Autorização
	"12345678901234567890",; //5 - Senha
	"12345678901234567890",; //6 - Número da Guia Atribuído pela Operadora
	"123456789012345678901234567890",; //7 - Número da Carteira
	Replicate("M",70),; //8 - Nome
	"12345678901234",; //9 – Código na Operadora
	Replicate("M",70),; //10 - Nome do Contratado
	Replicate("M",70),; //11 - Nome do Profissional Solicitante
	"MM",; //12 - Conselho Profissional
	"123456789012345",; //13 - Número no Conselho
	"RS",; //14 - UF
	"123456",; //15 - Código CBO
	999,; //16 - Qtde. diárias adicionais solicitadas
	"AA",; //17 - Tipo da acomodação solicitada
	Replicate("M",500),; //18 - Indicação Clínica
	{ "10","20","30","40","50","60","70","80","90","99","00","11", "11" },; //19-Tabela
	{ "1234567890","2345678901","3456789012","4567890123","5678901234","1234567890","2345678901","3456789012","4567890123","5678901234","4567890123","5678901234","5678901234" },; //20 - Código do Procedimento
	{ Replicate("M",150),Replicate("A",150),Replicate("B",150),Replicate("C",150),Replicate("D",150),Replicate("M",150),Replicate("A",150),Replicate("B",150),Replicate("C",150),Replicate("D",150),Replicate("C",150),Replicate("D",150),Replicate("D",150) },; //21 - Descrição
	{ 999,888,777,666,555,444,333,222,111,999,888,777,777 },; //22 - Qtde Solic
	{ 111,222,333,444,555,1212,111,222,333,444,555,1212,1212 },; //23 – Qtde Aut
	123,; //24 - Qtde. diárias adicionais autorizadas
	"AA",;//25 - Tipo da Acomodação Autorizada
	Replicate("O",500),; //26 - Justificativa da Operadora
	Replicate("O",500),; //27 – Observação / Justificativa
	CtoD("12/12/07") } } //28 - Data da Solicitação

If nLayout  == 1 // Ofício 2
	nLinMax	:=	3705	// Numero maximo de Linhas (31,5 cm)
	nColMax	:=	2400	// Numero maximo de Colunas (21 cm)
Elseif nLayout == 2   // Papél A4
	nLinMax	:=	2478
	nColMax	:=	2335
Else //Carta
	nLinMax	:=	3155
	nColMax	:=	2400
Endif

oFont01		:= TFont():New("Arial",  5,  5, , .F., , , , .T., .F.) // Normal
if nLayout == 1 // Oficio 2
	oFont02n	:= TFont():New("Arial", 12, 12, , .T., , , , .T., .F.) // Negrito
	oFont03n	:= TFont():New("Arial", 14, 14, , .T., , , , .T., .F.) // Negrito
	oFont04		:= TFont():New("Arial", 09, 09, , .F., , , , .T., .F.) // Normal
Else  // Papél A4 ou Carta
	oFont02n := TFont():New("Arial", 12, 12, , .T., , , , .T., .F.) // Negrito
	oFont03n := TFont():New("Arial", 13, 13, , .T., , , , .T., .F.) // Negrito
	oFont04	 := TFont():New("Arial", 07, 07, , .F., , , , .T., .F.) // Normal
Endif

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
	//³ Nao permite acionar a impressao quando for na web.
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
If lWeb
	cPathSrvJ := cPathRelW
	cFileName := cRel+CriaTrab(NIL,.F.)+".pdf"
Else
	cFileName := cRel+CriaTrab(NIL,.F.)
EndIf

	//						New ( < cFilePrintert >, [ nDevice], [ lAdjustToLegacy], [ cPathInServer], [ lDisabeSetup ], [ lTReport], [ @oPrintSetup], [ cPrinter], [ lServer], [ lPDFAsPNG], [ lRaw], [ lViewPDF] )
oPrint := FWMSPrinter():New ( cFileName			,			,	.F.				,cPathSrvJ	 	,	.T.				,			 ,				,			  ,			  ,	.F.			, 		, 				)
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
	//³Tratamento para impressao via job
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
	//oPrint:lInJob  := lWeb
oPrint:lServer := lWeb
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
	//³ Caminho do arquivo
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
oPrint:cPathPDF := cPathSrvJ

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
	//³Modo retrato
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
oPrint:SetPortrait()	// Modo retrato

If nLayout ==2
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
		//³Papél A4
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
	oPrint:SetPaperSize(9)
ElseIf nLayout ==3
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
		//³Papél Carta
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
	oPrint:SetPaperSize(1)
Else
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
		//³Papel Oficio2 216 x 330mm / 8 1/2 x 13in
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
	oPrint:SetPaperSize(14)
Endif

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
	//³Device
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
If lWeb
	oPrint:setDevice(IMP_PDF)
	oPrint:lPDFAsPNG := .T.
EndIf
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
	//³Verifica se existe alguma impressora configurada para Impressao Grafica
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
If  !lWeb
	oPrint:Setup()
	If !(oPrint:nModalResult == 1)
		lRet := .F.
		lMail := .F.
		lImpnovo:=.F.
	Else
		lImpnovo:=(oPrint:nModalResult == 1)
	Endif
EndIf
For I:=1 to Len(aDados)    // Prevenindo de erros log
	For J:=1 To Len(aDados[I])
		If ValType(aDados[I,J])=="U"
			//lImpnovo:=.F.
			aDados[I,J] := " - "
		Endif
	Next J
Next I

BEGIN SEQUENCE
	While lImpnovo

		lImpnovo:=.F.
		nVolta  += 1
		nT      += 9
		nT1     += 2
		nT3     += 3


		For nX := 1 To Len(aDados)

			If Len(aDados[nX]) == 0
				Loop
			EndIf

			For nI := 19 To 23
				If Len(aDados[nX, nI]) < nT
					For nJ := Len(aDados[nX, nI]) + 1 To nT
						If AllTrim(Str(nI)) $ "22,23"
							aAdd(aDados[nX, nI], 0)
						Else
							aAdd(aDados[nX, nI], "")
						EndIf
					Next nJ
				EndIf
			Next nI

			If oPrint:Cprinter == "PDF" .OR. lWeb
				nLinIni := 150
			Else
				nLinIni := 000
			Endif

			nColIni := 060
			nColA4  := 000
			nLinA4  := 000

			oPrint:StartPage()		// Inicia uma nova pagina

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Box Principal                                                 ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			oPrint:Box((nLinIni + 0000)*nAL, (nColIni + 0010)*nAC, (nLinIni + nLinMax - 10)*nAL, (nColIni + nColMax)*nAC)

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Carrega e Imprime Logotipo da Empresa                         ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			fLogoEmp(@cFileLogo,, cLogoGH)

			If File(cFilelogo)
				oPrint:SayBitmap((nLinIni + 0050)*nAL, (nColIni + 0020)*nAC, cFileLogo, (400)*nAL, (090)*nAC) 		// Tem que estar abaixo do RootPath
			EndIf

			If nLayout == 2 // Papél A4
				nColA4    := -0065
			Elseif nLayout == 3// Carta
				nLinA4    := -0085
			Endif

			oPrint:Say((nLinIni + 0050)*nAL, (nColIni + (nColMax*0.40))*nAC, "GUIA DE SOLICITAÇÃO", oFont02n) //"GUIA DE SOLICITAÇÃO"
			oPrint:Say((nLinIni + 0050)*nAL, (nColIni + (nColMax*0.69))*nAC, "2- Nº Guia no Prestador", oFont01) //"2- Nº Guia no Prestador"
			oPrint:Say((nLinIni + 0050)*nAL, (nColIni + (nColMax*0.78))*nAC, aDados[nX, 02], oFont03n)
			oPrint:Say((nLinIni + 0100)*nAL, (nColIni + (nColMax*0.34))*nAC, "DE PRORROGAÇÃO DE INTERNAÇÃO", oFont02n) //"DE PRORROGAÇÃO DE INTERNAÇÃO"
			oPrint:Say((nLinIni + 0150)*nAL, (nColIni + (nColMax*0.32))*nAC, "OU COMPLEMENTAÇÃO DO TRATAMENTO", oFont02n) //"OU COMPLEMENTAÇÃO DO TRATAMENTO"

		//Linha 1
			oPrint:Box((nLinIni + 0180)*nAL, (nColIni + 0020)*nAC, (nLinIni + 0240)*nAL, (nColIni + (nColMax*0.15)- 0010)*nAC)
			oPrint:Say((nLinIni + 0200)*nAL, (nColIni + 0030)*nAC, "1 - Registro ANS", oFont01) //"1 - Registro ANS"
			oPrint:Say((nLinIni + 0232)*nAL, (nColIni + 0040)*nAC, SUBSTR(aDados[nX, 01],1,6), oFont04)
			oPrint:Box((nLinIni + 0180)*nAL, (nColIni + (nColMax*0.15))*nAC, (nLinIni + 0240)*nAL, (nColIni + (nColMax*0.60) - 0010)*nAC)
			oPrint:Say((nLinIni + 0200)*nAL, (nColIni + (nColMax*0.15) + 0010)*nAC, "3 - Número da Guia de Solicitação de Internação", oFont01) //"3 - Número da Guia de Solicitação de Internação"
			oPrint:Say((nLinIni + 0232)*nAL, (nColIni + (nColMax*0.15) + 0020)*nAC, aDados[nX, 03], oFont04)
			oPrint:Box((nLinIni + 0180)*nAL, (nColIni + (nColMax*0.60))*nAC, (nLinIni + 0240)*nAL, (nColIni + (nColMax*0.85) - 0010)*nAC)
			oPrint:Say((nLinIni + 0200)*nAL, (nColIni + (nColMax*0.60) + 0010)*nAC, "4 - Data da Autorização", oFont01) //"4 - Data da Autorização"
			oPrint:Say((nLinIni + 0232)*nAL, (nColIni + (nColMax*0.60) + 0020)*nAC, DtoC(aDados[nX, 04]), oFont04)

		//Linha 2
			oPrint:Box((nLinIni + 0250)*nAL, (nColIni + 0020)*nAC, (nLinIni + 0310)*nAL, (nColIni + (nColMax*0.50) - 0010)*nAC)
			oPrint:Say((nLinIni + 0270)*nAL, (nColIni + 0030)*nAC, "5 - Senha", oFont01) //"5 - Senha"
			oPrint:Say((nLinIni + 0302)*nAL, (nColIni + 0040)*nAC, SUBSTR(aDados[nX, 05],1,20), oFont04)
			oPrint:Box((nLinIni + 0250)*nAL, (nColIni + (nColMax*0.50))*nAC, (nLinIni + 0310)*nAL, (nColIni + nColMax - 0010)*nAC)
			oPrint:Say((nLinIni + 0270)*nAL, (nColIni + (nColMax*0.50) + 0010)*nAC, "6 - Número da Guia Atribuído pela Operadora", oFont01) //"6 - Número da Guia Atribuído pela Operadora"
			oPrint:Say((nLinIni + 0302)*nAL, (nColIni + (nColMax*0.50) + 0020)*nAC, aDados[nX, 06], oFont04)

		//Linha 3
			oPrint:Say((nLinIni + 0330)*nAL, (nColIni + 0020)*nAC, "Dados do Beneficiário", oFont01) //Dados do Beneficiário*/

		//Linha 4
			oPrint:Box((nLinIni + 0340)*nAL, (nColIni + 0020)*nAC, (nLinIni + 0400)*nAL, (nColIni + (nColMax*0.30) - 0010)*nAC)
			oPrint:Say((nLinIni + 0360)*nAL, (nColIni + 0030)*nAC, "7 - Número da Carteira", oFont01) //"7 - Número da Carteira"
			oPrint:Say((nLinIni + 0392)*nAL, (nColIni + 0040)*nAC, aDados[nX, 07], oFont04)
			oPrint:Box((nLinIni + 0340)*nAL, (nColIni + (nColMax*0.30))*nAC, (nLinIni + 0400)*nAL, (nColIni + nColMax - 0010)*nAC)
			oPrint:Say((nLinIni + 0360)*nAL, (nColIni + (nColMax*0.30) + 0010)*nAC, "8 - Nome", oFont01) //"8 - Nome"
			oPrint:Say((nLinIni + 0392)*nAL, (nColIni + (nColMax*0.30) + 0020)*nAC, SUBSTR(aDados[nX, 8],1,70), oFont04)

		//Linha 5
			oPrint:Say((nLinIni + 0420)*nAL, (nColIni + 0020)*nAC, "Dados do Contratado Solicitante", oFont01) //Dados do Contratado Solicitante

		//Linha 6
			oPrint:Box((nLinIni + 0430)*nAL, (nColIni + 0020)*nAC, (nLinIni + 0490)*nAL, (nColIni + (nColMax*0.25) - 0010)*nAC)
			oPrint:Say((nLinIni + 0450)*nAL, (nColIni + 0030)*nAC, "9 - Código na Operadora", oFont01) //"9 - Código na Operadora"
			oPrint:Say((nLinIni + 0482)*nAL, (nColIni + 0040)*nAC, SUBSTR(aDados[nX, 9],1,14), oFont04)
			oPrint:Box((nLinIni + 0430)*nAL, (nColIni + (nColMax*0.25))*nAC, (nLinIni + 0490)*nAL, (nColIni + nColMax - 0010)*nAC)
			oPrint:Say((nLinIni + 0450)*nAL, (nColIni + (nColMax*0.25) + 0010)*nAC, "10 - Nome do Contratado", oFont01) //"10 - Nome do Contratado"
			oPrint:Say((nLinIni + 0482)*nAL, (nColIni + (nColMax*0.25) + 0020)*nAC, SUBSTR(aDados[nX, 10],1,70), oFont04)

		//Linha 7
			oPrint:Box((nLinIni + 0500)*nAL, (nColIni + 0020)*nAC, (nLinIni + 0560)*nAL, (nColIni + (nColMax*0.69) - 0010)*nAC)
			oPrint:Say((nLinIni + 0520)*nAL, (nColIni + 0030)*nAC, "11 - Nome do Profissional Solicitante", oFont01) //"11 - Nome do Profissional Solicitante"
			oPrint:Say((nLinIni + 0552)*nAL, (nColIni + 0040)*nAC, SUBSTR(aDados[nX, 11],1,70), oFont04)
			oPrint:Box((nLinIni + 0500)*nAL, (nColIni + (nColMax*0.69))*nAC, (nLinIni + 0560)*nAL, (nColIni + (nColMax*0.75) - 0010)*nAC)
			oPrint:Say((nLinIni + 0518)*nAL, (nColIni + (nColMax*0.69) + 0010)*nAC, "12 - Conselho", oFont01) //"12 - Conselho"
			oPrint:Say((nLinIni + 0532)*nAL, (nColIni + (nColMax*0.69) + 0015)*nAC, "Profissional", oFont01) //"Profissional"
			oPrint:Say((nLinIni + 0558)*nAL, (nColIni + (nColMax*0.69) + 0020)*nAC, SUBSTR(aDados[nX, 12],1,3), oFont04)
			oPrint:Box((nLinIni + 0500)*nAL, (nColIni + (nColMax*0.75))*nAC, (nLinIni + 0560)*nAL, (nColIni + (nColMax*0.88) - 0010)*nAC)
			oPrint:Say((nLinIni + 0520)*nAL, (nColIni + (nColMax*0.75) + 0010)*nAC, "13 - Número no Conselho", oFont01) //"13 - Número no Conselho"
			oPrint:Say((nLinIni + 0552)*nAL, (nColIni + (nColMax*0.75) + 0020)*nAC, SUBSTR(aDados[nX, 13],1,15), oFont04)
			oPrint:Box((nLinIni + 0500)*nAL, (nColIni + (nColMax*0.88))*nAC, (nLinIni + 0560)*nAL, (nColIni + (nColMax*0.93) - 0010)*nAC)
			oPrint:Say((nLinIni + 0520)*nAL, (nColIni + (nColMax*0.88) + 0010)*nAC, "14 - UF", oFont01) //"14 - UF"
			oPrint:Say((nLinIni + 0552)*nAL, (nColIni + (nColMax*0.88) + 0020)*nAC, SUBSTR(aDados[nX, 14],1,2), oFont04)
			oPrint:Box((nLinIni + 0500)*nAL, (nColIni + (nColMax*0.93))*nAC, (nLinIni + 0560)*nAL, (nColIni + nColMax - 0010)*nAC)
			oPrint:Say((nLinIni + 0520)*nAL, (nColIni + (nColMax*0.93) + 0010)*nAC, "15 - Código CBO", oFont01) //"15 - Código CBO"
			oPrint:Say((nLinIni + 0552)*nAL, (nColIni + (nColMax*0.93) + 0020)*nAC, SUBSTR(aDados[nX, 15],1,6), oFont04)

		//Linha 8
			oPrint:Say((nLinIni + 0580)*nAL, (nColIni + 0020)*nAC, "Dados da Internação", oFont01) //Dados da Internação

		//Linha 9
			oPrint:Box((nLinIni + 0590)*nAL, (nColIni + 0020)*nAC, (nLinIni + 0650)*nAL, (nColIni + (nColMax*0.20) - 0010)*nAC)
			oPrint:Say((nLinIni + 0610)*nAL, (nColIni + 0030)*nAC, "16 - Qtde. Diárias Adicionais Solicitadas", oFont01) //"16 - Qtde. Diárias Adicionais Solicitadas / CNPJ"
			oPrint:Say((nLinIni + 0642)*nAL, (nColIni + 0040)*nAC, IIf(Empty(aDados[nX, 16]), "", Transform(aDados[nX, 16], "@E 999")), oFont04)
			oPrint:Box((nLinIni + 0590)*nAL, (nColIni + (nColMax*0.20))*nAC, (nLinIni + 0650)*nAL, (nColIni + (nColMax*0.45) - 0010)*nAC)
			oPrint:Say((nLinIni + 0610)*nAL, (nColIni + (nColMax*0.20) + 0010)*nAC, "17 - Tipo da Acomodação Solicitada", oFont01) //"17-Tipo de Internação"
			oPrint:Say((nLinIni + 0642)*nAL, (nColIni + (nColMax*0.21))*nAC, aDados[nX, 17], oFont04)

		//Linha 10
			oPrint:Box((nLinIni + 0660)*nAL, (nColIni + 0020)*nAC, (nLinIni + 1200)*nAL, (nColIni + nColMax - 0010)*nAC)
			oPrint:Say((nLinIni + 0680)*nAL, (nColIni + 0030)*nAC, "18 - Indicação Clínica", oFont01) //"18 - Indicação Clínica"
			//oPrint:Say((nLinIni + 0712 + nLinObs)*nAL, (nColIni + 0040)*nAC,  aDados[nX, 18], oFont04)

			nLinB := nLinIni
			For nI := 1 To MlCount(aDados[nX, 18], 180)
				cObs := MemoLine(aDados[nX, 18], 180, nI)
				oPrint:Say((nLinB + 0712)*nAl, (nColIni + 0040)*nAC, cObs, oFont04)
				nLinB += 30
				If nI == 15
					exit
						Endif
			Next nI


		//Linha 11
			oPrint:Say((nLinIni + 1228)*nAL, (nColIni + 0020)*nAC, "Procedimentos Solicitados", oFont01) //Procedimentos Solicitados
		//Linha 12
			oPrint:Box((nLinIni + 1238)*nAL, (nColIni + 0020)*nAC, (nLinIni + 1638)*nAL, (nColIni + nColMax - 0010)*nAC)
			oPrint:Say((nLinIni + 1258)*nAL, (nColIni + (nColMax*0.02))*nAC, "19 - Tabela", oFont01) //19-Tabela
			oPrint:Say((nLinIni + 1258)*nAL, (nColIni + (nColMax*0.07))*nAC, "20 - Código do Procedimento", oFont01) //20 - Código do Procedimento
			oPrint:Say((nLinIni + 1258)*nAL, (nColIni + (nColMax*0.18))*nAC, "21 - Descrição", oFont01) //21 - Descrição
			oPrint:Say((nLinIni + 1258)*nAL, (nColIni + (nColMax*0.86))*nAC, "22 - Qtde Solic", oFont01) //22 - Qtde Solic
			oPrint:Say((nLinIni + 1258)*nAL, (nColIni + (nColMax*0.93))*nAC, "23 - Qtde Aut", oFont01) //23 – Qtde Aut

			nOldLinIni := nLinIni

			if nVolta=1
				nV1:=1
			Endif

			If ExistBlock("PLSGTISS")
				lImpPrc := ExecBlock("PLSGTISS",.F.,.F.,{"03",lImpPrc})
			EndIf

			If lImpPrc

				For nP := nV1 To nT
					If !Empty(Alltrim(aDados[nx,19,nP]))
						oPrint:Say((nLinIni + 1298)*nAL, (nColIni + 0025)*nAC, AllTrim(Str(nP)) + " - ", oFont01)
						oPrint:Say((nLinIni + 1298)*nAL, (nColIni + (nColMax*0.03))*nAC, aDados[nX, 19, nP], oFont04)
						oPrint:Say((nLinIni + 1298)*nAL, (nColIni + (nColMax*0.07))*nAC, aDados[nX, 20, nP], oFont04)
						oPrint:Say((nLinIni + 1298)*nAL, (nColIni + (nColMax*0.18))*nAC, SUBSTR(aDados[nX, 21, nP],1,300), oFont01)
						oPrint:Say((nLinIni + 1298)*nAL, (nColIni + (nColMax*0.88))*nAC, if (aDados[nX, 22, nP]=0,"",Transform(aDados[nX, 22, nP], "@E 999")), oFont04,,,,1)
						oPrint:Say((nLinIni + 1298)*nAL, (nColIni + (nColMax*0.95))*nAC, if (aDados[nX, 23, nP]=0,"",Transform(aDados[nX, 23, nP], "@E 999")), oFont04,,,,1)
						nLinIni += 40
					Endif
				Next nP

			EndIf

			if nT < Len(aDados[nX, 20]).or. lImpnovo
				nV1:=nP
				lImpnovo:=.T.
			Endif

			nLinIni := nOldLinIni

		//Linha 13
			oPrint:Say((nLinIni + 1666)*nAL, (nColIni + 0020)*nAC, "Dados da Autorização", oFont01) //Dados da Autorização

		//Linha 14
			oPrint:Box((nLinIni + 1676)*nAL, (nColIni + 0020)*nAC, (nLinIni + 1736)*nAL, (nColIni + (nColMax*0.20) - 0010)*nAC)

			oPrint:Say((nLinIni + 1696)*nAL, (nColIni + 0030)*nAC, "24 - Qtde. Diárias Adicionais Autorizadas", oFont01) //"24 - Data Provável da Admissão Hospitalar"
			oPrint:Say((nLinIni + 1728)*nAL, (nColIni + 0040)*nAC, aDados[nX, 24], oFont04)
			oPrint:Box((nLinIni + 1676)*nAL, (nColIni + (nColMax*0.20))*nAC, (nLinIni + 1736)*nAL, (nColIni + (nColMax*0.45) - 0040)*nAC)

			oPrint:Say((nLinIni + 1696)*nAL, (nColIni + (nColMax*0.20) + 0010)*nAC, "25 - Tipo da Acomodação Autorizada", oFont01) //"25 - Tipo da Acomodação Autorizada"
			oPrint:Say((nLinIni + 1728)*nAL, (nColIni + (nColMax*0.21))*nAC, aDados[nX, 25], oFont04)

		//Linha 15
			oPrint:Box((nLinIni + 1746)*nAL, (nColIni + 0020)*nAC, (nLinIni + 2058)*nAL, (nColIni + nColMax - 0010)*nAC)
			oPrint:Say((nLinIni + 1766)*nAL, (nColIni + 0030)*nAC, "26 - Justificativa da Operadora", oFont01) //"26 - Código na Operadora / CNPJ autorizado"

			nLinB := 0
			nLinB := nLinIni
			For nI := 1 To MlCount(aDados[nX, 26], 180)
				cObs := MemoLine(aDados[nX, 26], 180, nI)
				oPrint:Say((nLinB + 1798)*nAl, (nColIni + 0040)*nAC, cObs, oFont04)
				nLinB += 30
				If nI == 9
					exit
				Endif
			Next nI


		//Linha 16
			oPrint:Box((nLinIni + 2068)*nAL, (nColIni + 0020)*nAC, (nLinIni + 2388)*nAL, (nColIni + nColMax - 0010)*nAC)
			oPrint:Say((nLinIni + 2088)*nAL, (nColIni + 0030)*nAC, "27 - Observação / Justificativa", oFont01) //"27 – Observação / Justificativa"

			nLinB := 0
			nLinB := nLinIni
			For nI := 1 To MlCount(aDados[nX, 27], 180)
				cObs := MemoLine(aDados[nX, 27], 180, nI)
				oPrint:Say((nLinB + 2120)*nAl, (nColIni + 0040)*nAC, cObs, oFont04)
				nLinB += 30
				If nI == 9
					exit
				Endif
			Next nI

		//Linha 17
			oPrint:Box((nLinIni + 2398)*nAL, (nColIni + 0020)*nAC, (nLinIni + 2458)*nAL, (nColIni + (nColMax/3) - 0010)*nAC)
			oPrint:Say((nLinIni + 2418)*nAL, (nColIni + 0030)*nAC, "28 - Data da Solicitação", oFont01) //"28 - Data da Solicitação"
			oPrint:Say((nLinIni + 2450)*nAL, (nColIni + 0040)*nAC, DtoC(aDados[nX, 28]), oFont04)
			oPrint:Box((nLinIni + 2398)*nAL, (nColIni + (nColMax/3))*nAC, (nLinIni + 2458)*nAL, (nColIni + ((nColMax/3)*2) - 0010)*nAC)
			oPrint:Say((nLinIni + 2418)*nAL, (nColIni + (nColMax/3) + 0010)*nAC, "29-Assinatura do Profissional Solicitante", oFont01) //"29-Assinatura do Profissional Solicitante"
			oPrint:Box((nLinIni + 2398)*nAL, (nColIni + ((nColMax/3)*2))*nAC, (nLinIni + 2458)*nAL, (nColIni + ((nColMax/3)*3) - 0010)*nAC)
			oPrint:Say((nLinIni + 2418)*nAL, (nColIni + ((nColMax/3)*2) + 0010)*nAC, "30-Assinatura do Responsável pela Autorização", oFont01) //"30-Assinatura do Beneficiário ou Responsável"

			oPrint:EndPage()	// Finaliza a pagina

		Next nX

	enddo
END SEQUENCE
//ErrorBlock( bError )

If !Empty(cErro)
	cArq := "erro_imp_relat_" + DtoS(Date()) + StrTran(Time(),":") + ".txt"
	MsgAlert("Erro ao gerar relatório. Visualize o log em /LOGPLS/" + cArq )
	cErro := 	"Erro ao carregar dados do relatório." + CRLF + ;
		"Verifique a cfg. de impressão da guia no cadastro de " + CRLF + ;
		"Tipos de Guias." + CRLF + CRLF + ;
		cErro
	PLSLogFil(cErro,cArq)
EndIf

If lGerTXT .And. !lWeb
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
		//³Imprime Relatorio
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
	oPrint:Print()
Else
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
		//³Visualiza impressao grafica antes de imprimir
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
	If lRet

		oPrint:Preview()
	Endif

	If lMail .And. (lRet:=Aviso("Atenção","Confirma o envio do relatório por e-mail?",{"Sim","Não"},1)== 1)

		If File(cFile)
			lOk := (FErase(cFile)==0)
		EndIf

		If lOk
			oPrint:SaveAsHTML(cFile)
		Else
			Aviso("Atenção","Não foi possível criar o arquivo "+cFile,{"Ok"},1)
			lRet := .F.
		EndIf

	EndIf

EndIf

Return {lRet,cFile,cFileName}

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CalcDiriaEvoºAutor  ³Microsiga         º Data ³  04/11/14   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³   Calcula as Diarias autorizadas ou não para a Evolução de  º±±
±±º          ³   internação                                                º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

/*
Function CalcDiriaEvo(nTipo)

Local nDiasDiari:=0

Default nTipo:= 1 // 1 autorizados 2 solicitador

BQV->(DbSetOrder(1))
If BQV->(DbSeek(xFilial('BQV')+BE4->(BE4_CODOPE+BE4_ANOINT+BE4_MESINT+BE4_NUMINT) ))
	While !BQV->(Eof()) .and.  BQV->(BQV_FILIAL+BQV_CODOPE+BQV_ANOINT+BQV_MESINT+BQV_NUMINT) == BE4->(BE4_FILIAL+BE4_CODOPE+BE4_ANOINT+BE4_MESINT+BE4_NUMINT)
		If BQV->BQV_STATUS  $ "1,2" .and. nTipo == 1		//autorizada, parcialmente ou nao
			If BR8->( MsSeek(xFilial("BR8")+BQV->BQV_CODPAD+BQV->BQV_CODPRO) )
				If BR8->BR8_TPPROC=='4' //DIARIAS
					nDiasDiari:= BQV->BQV_QTDPRO
				Endif
			Endif
		Else // Não Autorizado
			IF BE4->BE4_DIASSO> 0
				nDiasDiari:=BE4->BE4_DIASSO
			Else
				If BR8->( MsSeek(xFilial("BR8")+BQV->BQV_CODPAD+BQV->BQV_CODPRO) )
					If BR8->BR8_TPPROC=='4' //DIARIAS
						nDiasDiari:= BQV->BQV_QTDSOL
					Endif
				Endif
			Endif
		Endif
		BQV->(DbSkip())
	Enddo
Endif
nDiasDiari:=StrZero(nDiasDiari,3)

Return(nDiasDiari)
*/
//-------------------------------------------------------------------
/*/{Protheus.doc} PPLVERPRR
Adiciona prorrogações para exibição no portal

@author  Lucas de Azevedo Nonato
@version P11
@since   03/11/2015
/*/
//-------------------------------------------------------------------
/*
Function PPLVERPRR(aDados)

Local lRet := .F.

aDados[1][34] := {}
aDados[1][35] := {}
aDados[1][36] := {}
aDados[1][37] := {}
aDados[1][38] := {}



dbSelectArea("BQV")
dbSetOrder(1)
dbGoTop()
While !BQV->(EOF())
	If BQV->(BQV_FILIAL + BQV_CODOPE +"."+ BQV_ANOINT +"."+ BQV_MESINT +"-"+ BQV_NUMINT) == xFilial("BQV") + aDados[1][2]
		aAdd(aDados[1][34], AllTrim(BQV->BQV_CODPAD))
		aAdd(aDados[1][35], AllTrim(BQV->BQV_CODPRO))
		aAdd(aDados[1][36], AllTrim(BQV->BQV_DESPRO))
		aAdd(aDados[1][37], BQV->BQV_QTDSOL)
		aAdd(aDados[1][38], BQV->BQV_QTDPRO)
		lRet := .T.
	EndIf
	dbSkip()
EndDo
BQV->(dbCloseArea())

Return lRet
//-----------------------------------------------------------------------------------------
Static Function fLogoEmp(cLogo, cTipo, cLogoGH)

Local cStartPath	:= GetSrvProfString("STARTPATH","")

Default cTipo	:= "1"
Default cLogoGH := ""

If ValType(cLogoGH) <> "U" .And. !Empty(cLogoGH) .And. File(cLogoGH) //logo a partir do campo do Gestao Hospitalar
	cLogo := cLogoGH
Else // Logotipo da Empresa
	If cTipo == "1"
		cLogo := cStartPath + "\LGRL"+FWCompany()+FWCodFil()+".BMP"	// Empresa+Filial
	Else
		cLogo := cStartPath + "\LGRL"+FWCompany()+".BMP"				// Empresa
	EndIf
EndIf

Return
*/

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡ao    ³ PLSSOLINI  ³ Autor ³ Thiago Ribas     ³ Data ³ 17.12.15 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡ao ³ Estrutura Relatório TISS 3 Guia Odontológica - Solicitação)  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ SigaPLS                                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ aDados - Array com as informações do relat´rio              ³±±
±±³          ³ lGerTXT - Imprime sem seleção de impressora
			 ³ nLayout - Define o formato de papél para impressao:         ³±±
±±³          ³           1 - Formato Ofício II (216x330mm)                 ³±±
±±³          ³           2 - Formato A4 (210x297mm)                        ³±±
±±³          ³  		 3 - Formato Carta (216x279mm)     			       ³±±
±±³          ³ cPathRelW - caminho onde será gravado o relatório	       ³±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
/*
Function CABSOLINI(aDados, lGerTXT, nLayout, cLogoGH, lWeb, cPathRelW) //Guia Odontológica - Solicitação

	Local nLinMax
	Local nColMax
	Local nLinIni	:=	0		// Linha Lateral (inicial) Esquerda
	Local nColIni	:=	0		// Coluna Lateral (inicial) Esquerda
	Local cFileLogo
	Local nLin
	Local nX , nI
	Local cObs
	Local oFont01
	Local oFont02n
	Local oFont03n
	Local oFont04
	Local nCol  	:=	0
	Local nColf 	:=	0
	Local aNum1,aNum2,aNum3,aNum4 :={}
	LOCAL cRel      := "TRTODONT"
	LOCAL cPathSrvJ := GETMV("MV_RELT")
	Local lRet 		:= .T.
	Local oPrint := NIL
	Local nAL		:= 0.25
	Local nAC		:= 0.24
	Local nEspGrid  := 0
	Local nLinVert  := 0
	Local nVert     := 0
	Local cFileName := NIL
	Local cFile     := GetNewPar("MV_RELT",'\SPOOL\')+'PLSR421N.HTM'

	Default lGerTXT := .F.
	Default nLayout := 2
	Default cLogoGH := ''
	Default lWeb	:= .F.
	Default cPathRelW 	:= ""
	Default aDados  := { { ;
						"123456",; 				 //1 - Registro ANS
						"12345678901234567892",; //2 - Nº Guia no Prestador
						"12345678901234567892",; //3 - Número da Guia Principal de Tratamento Odontológico
						"12345678901234567892",; //4 - Número da Guia Atribuído pela Operadora
						Replicate("M",70),;      //5 - Nome
						Replicate("M",20),;		 //6 - Número da Carteira
						"",;			         //7 - Dente
						"",;					 //8 - Situação Dentária Inicial
						"",;   		 			 //9 - Sinais Clínicos de Doença Periodontal
						"",;				 	 //10 - Alteração dos Tecidos Moles
						Replicate("M",500),;  	 //11 - Observação/Justificativa
						CtoD("30/12/07"),;   	 //12 - Local e Data
						"",;			     	 //13 - Assinatura do Cirurgião-Dentista
						CtoD("30/12/07"),; 		 //14 - Local e Data
						"",;					 //15 - Assinatura do Beneficiário/Responsável
						CtoD("30/12/07")} } 	 //16 - Local, Data e Carimbo da Empresa

	If nLayout  == 1 // Ofício 2
		nLinMax := 2435
		nColMax := 3705
	Elseif nLayout == 2   // Papél A4
	   	nLinMax	:=	2150
		nColMax	:=	3350 //3365
	Else //Carta
		nLinMax	:=	2435
		nColMax	:=	3175
	Endif

	oFont01		:= TFont():New("Arial",  6,  6, , .F., , , , .T., .F.) // Normal
	if nLayout == 1 // Oficio 2
		oFont02n	:= TFont():New("Arial", 12, 12, , .T., , , , .T., .F.) // Negrito
		oFont03n	:= TFont():New("Arial", 14, 14, , .T., , , , .T., .F.) // Negrito
		oFont04		:= TFont():New("Arial", 09, 09, , .F., , , , .T., .F.) // Normal
	Else  // Papél A4 ou Carta
	  	oFont02n	:= TFont():New("Arial", 11, 11, , .T., , , , .T., .F.) // Negrito
		oFont03n	:= TFont():New("Arial", 13, 13, , .T., , , , .T., .F.) // Negrito
		oFont04		:= TFont():New("Arial", 08, 08, , .F., , , , .T., .F.) // Normal
	Endif

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
	//³ Nao permite acionar a impressao quando for na web.
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
	If lWeb
		cPathSrvJ := cPathRelW
		cFileName := cRel+lower(CriaTrab(NIL,.F.))+".pdf"
	Else
		cFileName := cRel+CriaTrab(NIL,.F.)
	EndIf

	oPrint := FWMSPrinter():New ( cFileName	,,.F.,cPathSrvJ, .T.,, @oPrint,,, .F.,.F.)

	//³Tratamento para impressao via job
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
	oPrint:lServer := lWeb

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
	//³ Caminho do arquivo
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
	oPrint:cPathPDF := cPathSrvJ

	oPrint:SetLandscape()		// Modo paisagem

	if nLayout ==2
		oPrint:SetPaperSize(9)// Papél A4
	Elseif nLayout ==3
		oPrint:SetPaperSize(1)// Papél Carta
	Else
		oPrint:SetPaperSize(14) //Papel Oficio2 216 x 330mm / 8 1/2 x 13in
	Endif/

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
	//³Device
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
	If lWeb
		oPrint:setDevice(IMP_PDF)
		oPrint:lPDFAsPNG := .T.
	EndIf

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
	//³Verifica se existe alguma impressora configurada para Impressao Grafica
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
	If  !lWeb
		oPrint:Setup()
		lImpnovo:=(oPrint:nModalResult == 1)
	EndIf

	If oPrint:Cprinter == "PDF" .OR. lWeb
		nLinIni := 150
		nColMax -= 15
	Else
		nLinIni := 080
	Endif

	nColIni := 080

	For nX := 1 To Len(aDados)

		If ValType(aDados[nX]) == 'U' .OR. Len(aDados[nX]) == 0
			Loop
		EndIf

		oPrint:StartPage()		// Inicia uma nova pagina

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Box Principal                                                 ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		oPrint:Box((nLinIni + 0000)*nAL, (nColIni + 0000)*nAC, (nLinIni + nLinMax)*nAL, (nColIni + nColMax)*nAC)

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Carrega e Imprime Logotipo da Empresa                         ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		fLogoEmp(@cFileLogo,, cLogoGH)

		If File(cFilelogo)
			oPrint:SayBitmap((nLinIni + 0050)*nAL, (nColIni + 0020)*nAC, cFileLogo, (400)*nAL, (090)*nAC) 		// Tem que estar abaixo do RootPath
		EndIf

		oPrint:Say((nLinIni + 0080)*nAL, (nColIni + (nColMax*0.3))*nAC,STR0391, oFont02n,,,, 2)  //"GUIA TRATAMENTO ODONTOLÓGICO - SITUAÇÃO INICIAL"
		oPrint:Say((nLinIni + 0100)*nAL, (nColIni + (nColMax*0.76))*nAC, "2 - "+"Nº", oFont01) //"Nº"
		oPrint:Say((nLinIni + 0100)*nAL, (nColIni + (nColMax*0.79))*nAC, aDados[nX, 02], oFont03n)

		oPrint:Box((nLinIni + 0175)*nAL, (nColIni + 0010)*nAC, (nLinIni + 0269)*nAL, (nColIni + (nColMax*0.1) - 0010)*nAC)
		oPrint:Say((nLinIni + 0210)*nAL, (nColIni + 0020)*nAC, "1 - " + "Registro ANS", oFont01) //"Registro ANS"
		oPrint:Say((nLinIni + 0243)*nAL, (nColIni + 0030)*nAC, aDados[nX, 01], oFont04)

		oPrint:Box((nLinIni + 0175)*nAL, (nColIni + (nColMax*0.1))*nAC, (nLinIni + 0269)*nAL , (nColIni + (nColMax*0.40) - 0010)*nAC)
		oPrint:Say((nLinIni + 0210)*nAL, (nColIni + (nColMax*0.1) + 0010)*nAC, "3 - " + "Número da Guia Principal de Tratamento Odontológico", oFont01) //"Número da Guia Principal de Tratamento Odontológico"
		oPrint:Say((nLinIni + 0243)*nAL, (nColIni + (nColMax*0.1) + 0020)*nAC, aDados[nX, 03], oFont04)

	    oPrint:Box((nLinIni + 0175)*nAL, (nColIni + (nColMax*0.40))*nAC, (nLinIni + 0269)*nAL , (nColIni + (nColMax*0.72) - 0010)*nAC)
		oPrint:Say((nLinIni + 0210)*nAL, (nColIni + (nColMax*0.40) + 0020)*nAC, "4 - " + "Número da Guia Atribuído pela Operadora", oFont01) //"Número da Guia Atribuído pela Operadora"
		oPrint:Say((nLinIni + 0243)*nAL, (nColIni + (nColMax*0.40) + 0030)*nAC, aDados[nX, 04], oFont04)

		oPrint:Say((nLinIni + 0305)*nAL, (nColIni + 0010)*nAC, "Dados do Beneficiário", oFont01) //"Dados do Beneficiário"

		oPrint:Box((nLinIni + 0320)*nAL, (nColIni + 0010)*nAC, (nLinIni + 0398)*nAL, (nColIni + 1700 - 0010)*nAC)
		oPrint:Say((nLinIni + 0355)*nAL, (nColIni + 0020)*nAC, "5 - "+STR0009, oFont01) //"Nome"
		oPrint:Say((nLinIni + 0385)*nAL, (nColIni + 0030)*nAC, SUBSTR(aDados[nX, 05],1,50), oFont04)

		oPrint:Box((nLinIni + 0320)*nAL, (nColIni + 3200)*nAC, (nLinIni + 0398)*nAL, (nColIni + 1700)*nAC)
		oPrint:Say((nLinIni + 0355)*nAL, (nColIni + 1710)*nAC, "6 - " + "Número da Carteira", oFont01) //"Número da Carteira"
		oPrint:Say((nLinIni + 0385)*nAL, (nColIni + 1710)*nAC, aDados[nX, 06], oFont04)

		oPrint:Say((nLinIni + 0437)*nAL, (nColIni + 0010)*nAC, "Situação Inicial", oFont01) //"Situação Inicial"

		//Monta GRID e informações da situação inicial
		//Início
		nEspGrid := 515

		oPrint:Box((nLinIni + 0455)*nAL, (nColIni + 0010)*nAC, (nLinIni + 1147)*nAL, (nColIni + 0240)*nAC)
			oPrint:Say((nLinIni + nEspGrid)*nAL, (nColIni + 0020)*nAC, "Situação Inicial", oFont04) //"Situação Inicial"
			oPrint:Box((nLinIni + nEspGrid + 0055)*nAL, (nColIni + 0010)*nAC, (nLinIni + nEspGrid + 0055)*nAL , (nColIni + 0280)*nAC)

			nEspGrid += 115
			oPrint:Say((nLinIni + nEspGrid)*nAL, (nColIni + 0020)*nAC, STR0341, oFont04) //"Permanentes"
			oPrint:Box((nLinIni + nEspGrid + 0055)*nAL, (nColIni + 0010)*nAC, (nLinIni + nEspGrid + 0055)*nAL , (nColIni + 0280)*nAC)

			nEspGrid += 115
			oPrint:Say((nLinIni + nEspGrid)*nAL, (nColIni + 0020)*nAC, STR0342, oFont04) //"Decíduos"
			oPrint:Box((nLinIni + nEspGrid + 0055)*nAL, (nColIni + 0010)*nAC, (nLinIni + nEspGrid + 0055)*nAL , (nColIni + 0280)*nAC)

			nEspGrid += 115
			oPrint:Say((nLinIni + nEspGrid)*nAL, (nColIni + 0020)*nAC, STR0342, oFont04) //"Decíduos"
			oPrint:Box((nLinIni + nEspGrid + 0055)*nAL, (nColIni + 0010)*nAC, (nLinIni + nEspGrid + 0055)*nAL , (nColIni + 0280)*nAC)

			nEspGrid += 115
			oPrint:Say((nLinIni + nEspGrid)*nAL, (nColIni + 0020)*nAC, STR0341, oFont04) //"Permanentes"
			oPrint:Box((nLinIni + nEspGrid + 0055)*nAL, (nColIni + 0010)*nAC, (nLinIni + nEspGrid + 0055)*nAL , (nColIni + 0280)*nAC)

			nEspGrid += 115
			oPrint:Say((nLinIni + nEspGrid)*nAL, (nColIni + 0020)*nAC, "Situação Inicial", oFont04) //"Situação Inicial"

			nCol  :=245
			nColf :=350
			nLinVert := 455

			For nI:=1 to 16
				oPrint:Box((nLinIni + nLinVert)*nAL, (nColIni + nCol)*nAC , (nLinIni + nLinVert + 115)*nAL, (nColIni + 	nColf)*nAC)
				nLinVert += 115

				oPrint:Box((nLinIni + nLinVert)*nAL, (nColIni + nCol)*nAC , (nLinIni + nLinVert + 115)*nAL, (nColIni + 	nColf)*nAC)
				nLinVert += 115

				oPrint:Box((nLinIni + nLinVert)*nAL, (nColIni + nCol)*nAC , (nLinIni + nLinVert + 115)*nAL, (nColIni + 	nColf)*nAC)
				nLinVert += 115

				oPrint:Box((nLinIni + nLinVert)*nAL, (nColIni + nCol)*nAC , (nLinIni + nLinVert + 115)*nAL, (nColIni + 	nColf)*nAC)
				nLinVert += 115

				oPrint:Box((nLinIni + nLinVert)*nAL, (nColIni + nCol)*nAC , (nLinIni + nLinVert + 115)*nAL, (nColIni + 	nColf)*nAC)
				nLinVert += 115

				oPrint:Box((nLinIni + nLinVert)*nAL, (nColIni + nCol)*nAC , (nLinIni + nLinVert + 115)*nAL, (nColIni + 	nColf)*nAC)

			    nCol     += 0100
			    nColf 	 += 0100
			    nLinVert := 0455
			Next nI

			nCol  := 0268
			nVert := 0640
			aNum1:={"18","17","16","15","14","13","12","11","21","22","23","24","25","26","27","28"}

			For nI:=1 to Len(aNum1)
			oPrint:Say((nLinIni + 0640)*nAL, (nColIni + nCol)*nAC, aNum1[nI], oFont03n)
			 nCol  +=0100
			Next nI

			nVert += 0120
			nCol  := 0570
			aNum2:={"55","54","53","52","51","61","62","63","64","65"}

			For nI:=1 to Len(aNum2)
			oPrint:Say((nLinIni + nVert)*nAL, (nColIni + nCol)*nAC, aNum2[nI], oFont03n)
			 nCol  +=0100
			Next nI

			nVert += 0110
			nCol  := 0570
			aNum3:={"85","84","83","82","81","71","72","73","74","75"}

			For nI:=1 to Len(aNum3)
			oPrint:Say((nLinIni + nVert)*nAL, (nColIni + nCol)*nAC, aNum3[nI], oFont03n)
			 nCol  +=0100
			Next nI

			nVert += 0115
			nCol  := 0268
			aNum4:={"48","47","46","45","44","43","42","41","31","32","33","34","35","36","37","38"}

			For nI:=1 to Len(aNum4)
			oPrint:Say((nLinIni + nVert)*nAL, (nColIni + nCol)*nAC, aNum4[nI], oFont03n)
			 nCol  +=0100
			Next nI
		//FIM

		//Monta os quadros referente a parte pertencente
		//a LEGENDA E OBSERVAÇÕES SOBRE A SITUAÇÃO INICIAL

		oPrint:Say((nLinIni + 0465)*nAL, (nColIni + 1910)*nAC, STR0347, oFont01)	 //"LEGENDA E OBSERVAÇÕES SOBRE A SITUAÇÃO INICIAL"

		//Montagem do quadro Sinais Clínicos de doença periodontal ?
		//INÍCIO
		oPrint:Box((nLinIni + 0485)*nAL, (nColIni + 2250)*nAC, (nLinIni + 0650)*nAL, (nColIni + 2770)*nAC)

			oPrint:Say((nLinIni + 0520)*nAL, (nColIni + 2290)*nAC, "9 - " + STR0343, oFont01) //"Sinais Clínicos de doença periodontal ?"

				oPrint:Line((nLinIni + 0560)*nAL,(nColIni + 2320)*nAC, (nLinIni + 0600)*nAL,(nColIni + 2320)*nAC)
				oPrint:Line((nLinIni + 0600)*nAL,(nColIni + 2320)*nAC, (nLinIni + 0600)*nAL,(nColIni + 2380)*nAC)
				oPrint:Line((nLinIni + 0560)*nAL,(nColIni + 2380)*nAC, (nLinIni + 0600)*nAL,(nColIni + 2380)*nAC)
				oPrint:Say((nLinIni + 0590)*nAL, (nColIni + 2400)*nAC, STR0344, oFont04)  //"Sim"
				oPrint:Say((nLinIni + 0560)*nAL, (nColIni + 2335)*nAC, IIf(((aDados[nX, 9]) =="1"),"X",""), oFont04)

			   	oPrint:Line((nLinIni + 0560)*nAL, (nColIni + 2550)*nAC, (nLinIni + 0600)*nAL,(nColIni + 2550)*nAC)
				oPrint:Line((nLinIni + 0600)*nAL, (nColIni + 2550)*nAC, (nLinIni + 0600)*nAL,(nColIni + 2610)*nAC)
				oPrint:Line((nLinIni + 0560)*nAL, (nColIni + 2610)*nAC, (nLinIni + 0600)*nAL,(nColIni + 2610)*nAC)
				oPrint:Say((nLinIni + 0590)*nAL,  (nColIni + 2630)*nAC, STR0345, oFont04) //"Não"
				oPrint:Say((nLinIni + 0560)*nAL,  (nColIni + 2560)*nAC, IIf (((aDados[nX, 9]) == "0"),"X",""), oFont04)
		//FIM

		//Montagem do quadro alteração dos Tecidos Moles
		//INÍCIO
		oPrint:Box((nLinIni + 0965)*nAL, (nColIni + 2250)*nAC, (nLinIni + 0800)*nAL, (nColIni + 2770)*nAC)

			oPrint:Say((nLinIni + 0838)*nAL, (nColIni + 2290)*nAC, "10 - "+STR0346, oFont01) //"Alteração dos Tecidos Moles ?"

				oPrint:Line((nLinIni + 0880)*nAL, (nColIni + 2320)*nAC, (nLinIni + 0920)*nAL, (nColIni + 2320)*nAC)
				oPrint:Line((nLinIni + 0920)*nAL, (nColIni + 2320)*nAC, (nLinIni + 0920)*nAL, (nColIni + 2380)*nAC)
				oPrint:Line((nLinIni + 0880)*nAL, (nColIni + 2380)*nAC, (nLinIni + 0920)*nAL, (nColIni + 2380)*nAC)
				oPrint:Say((nLinIni + 0910)*nAL, (nColIni + 2400)*nAC, STR0344, oFont04)  //"Sim"
				oPrint:Say((nLinIni + 0880)*nAL, (nColIni + 2335)*nAC, IIf(((aDados[nX, 10]) =="1"),"X",""), oFont04)

				oPrint:Line((nLinIni + 0880)*nAL, (nColIni + 2550)*nAC,( nLinIni + 0920)*nAL, (nColIni + 2550)*nAC)
				oPrint:Line((nLinIni + 0920)*nAL, (nColIni + 2550)*nAC, (nLinIni + 0920)*nAL, (nColIni + 2610)*nAC)
				oPrint:Line((nLinIni + 0880)*nAL, (nColIni + 2610)*nAC, (nLinIni + 0920)*nAL, (nColIni + 2610)*nAC)
				oPrint:Say((nLinIni + 0910)*nAL, (nColIni + 2630)*nAC, STR0345, oFont04) //"Não"
				oPrint:Say((nLinIni + 0880)*nAL, (nColIni + 2560)*nAC, IIf (((aDados[nX, 10]) =="0"),"X",""), oFont04)
		//FIM

		//Montagem do quadro SITUAÇÃO INICIAL
		//INÍCIO
		oPrint:Box((nLinIni + 0560)*nAL, (nColIni + 1910)*nAC, (nLinIni + 0900)*nAL, (nColIni + 2220)*nAC)
			oPrint:Say((nLinIni + 0608)*nAL, (nColIni + 1960)*nAC, "8 - " + "Situação Inicial", oFont01) //"SITUAÇÃO INICIAL"
			oPrint:Say((nLinIni + 0658)*nAL, (nColIni + 1960)*nAC, "A - Ausente", oFont01) //"A - Ausente"
			oPrint:Say((nLinIni + 0708)*nAL, (nColIni + 1960)*nAC, "E - Extração Indicada", oFont01) //"E - Extração Indicada"
			oPrint:Say((nLinIni + 0758)*nAL, (nColIni + 1960)*nAC, "H - Hígido", oFont01) //"H - Hígido"
			oPrint:Say((nLinIni + 0808)*nAL, (nColIni + 1960)*nAC, "C - Cariado", oFont01) //"C - Cariado"
			oPrint:Say((nLinIni + 0858)*nAL, (nColIni + 1960)*nAC, "R - Restaurado", oFont01) //"R - Restaurado"
		//FIM

		oPrint:Box((nLinIni + 1180)*nAL, (nColIni + 0010)*nAC, (nLinIni + 1810)*nAL, (nColIni + 3320)*nAC)
		oPrint:Say((nLinIni + 1210)*nAL, (nColIni + 0020)*nAC, "11 - " + "Observação / Justificativa", oFont01) //"Observação / Justificativa"

		nLin := 1270

		For nI := 1 To MlCount(aDados[nX, 11], 130)
			cObs := MemoLine(aDados[nX, 11], 130, nI)
			oPrint:Say((nLinIni + nLin)*nAL, (nColIni + 0030)*nAC, cObs, oFont04)
			nLin += 50
		Next nI

		//Início da montagem  dos campos inferiores.
		oPrint:Box((nLinIni + 1830)*nAL, (nColIni + 0010)*nAC, (nLinIni + 1980)*nAL, (nColIni + 0850)*nAC)
		oPrint:Say((nLinIni + 1860)*nAL, (nColIni + 0020)*nAC, "12 - " + "Local e Data", oFont01) //"Local e Data"
		oPrint:Say((nLinIni + 1960)*nAL, (nColIni + 00630)*nAC, DtoC(aDados[nX, 12]), oFont04)

		oPrint:Box((nLinIni + 1830)*nAL, (nColIni + 0870)*nAC, (nLinIni + 1980)*nAL, (nColIni + 1710)*nAC)
		oPrint:Say((nLinIni + 1860)*nAL, (nColIni + 0880)*nAC, "13 - " + "Assinatura do Cirurgião-Dentista", oFont01) //"Assinatura do Cirurgião-Dentista"

		oPrint:Box((nLinIni + 1990)*nAL, (nColIni + 0010)*nAC, (nLinIni + 2140)*nAL, (nColIni + 0850)*nAC)
		oPrint:Say((nLinIni + 2020)*nAL, (nColIni + 0020)*nAC, "14 - "+"Local e Data", oFont01) //"Local e Data"
		oPrint:Say((nLinIni + 2120)*nAL, (nColIni + 00630)*nAC, DtoC(aDados[nX, 14]), oFont04)

		oPrint:Box((nLinIni + 1990)*nAL, (nColIni + 0870)*nAC, (nLinIni + 2140)*nAL, (nColIni + 1710)*nAC)
		oPrint:Say((nLinIni + 2020)*nAL, (nColIni + 0880)*nAC, "15 - " + "Assinatura do Beneficiário / Responsável", oFont01) //"Assinatura do Beneficiário / Responsável"

		oPrint:Box((nLinIni + 1830)*nAL, (nColIni + 1730)*nAC, (nLinIni + 2140)*nAL, (nColIni + 3320)*nAC)
		oPrint:Say((nLinIni + 1860)*nAL, (nColIni + 1740)*nAC, "16 - " + "Local, Data e Carimbo da Empresa", oFont01) //"Local, Data e Carimbo da Empresa"
		oPrint:Say((nLinIni + 2120)*nAL, (nColIni + 3100)*nAC, DtoC(aDados[nX, 16]), oFont04)
		//FIM

		oPrint:EndPage()	// Finaliza a pagina

	Next nX

	If lGerTXT .And. !lWeb
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
		//³Imprime Relatorio
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
		oPrint:Print()
	Else
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
		//³Visualiza impressao grafica antes de imprimir
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
		If lRet
			oPrint:Preview()
		Endif
	EndIf
Return {lRet,cFile,cFileName}*/


STATIC FUNCTION CABIMPVINC(cAlias,cCodTab,cVlrSis,lDetTerm)

LOCAL cBtuAlias := ""
LOCAL cRet		:= ""
DEFAULT cAlias  := ""
DEFAULT cCodTab := ""
DEFAULT cVlrSis := ""
DEFAULT lDetTerm:= .F.

If (!Empty(cCodTab) .And. !Empty(cAlias))
	BTU->(DbSetOrder(1))//BTU_FILIAL+BTU_CODTAB+BTU_ALIAS
	If BTU->(MsSeek(xFilial("BTU")+cCodTab))
		cBtuAlias := BTU->BTU_ALIAS
		BTU->(DbSetOrder(4))//BTU_FILIAL+BTU_CODTAB+BTU_VLRSIS+BTU_ALIAS
		If BTU->(MsSeek(xFilial("BTU")+cCodTab+cVlrSis+Space(TamSX3("BTU_VLRSIS")[1]-Len(cVlrSis))+cBtuAlias))
			cRet := BTU->BTU_CDTERM
		Else
			If BTU->(MsSeek(xFilial("BTU")+cCodTab+(xFilial(cBtuAlias)+cVlrSis+Space(TamSX3("BTU_VLRSIS")[1]-Len(cVlrSis)-8))+cBtuAlias))
				cRet := BTU->BTU_CDTERM
			Else
				If BTU->(MsSeek(xFilial("BTU")+cCodtab+xFilial(cBtuAlias)+cVlrSis))
					cRet := BTU->BTU_CDTERM
				EndIf
			EndIf
		EndIf
	EndIf
Else
	cRet := cVlrSis
EndIf
If lDetTerm .And. !Empty(cRet)
	BTQ->(DbSetOrder(1))// BTQ_FILIAL+BTQ_CODTAB+BTQ_CDTERM
	If BTQ->(MsSeek(xFilial("BTQ")+cCodTab+cRet))
		cRet := BTQ->BTQ_DESTER
	Endif
Endif

Return Alltrim(cRet)