//#INCLUDE "plstiss.ch"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "TOPCONN.CH"
#INCLUDE "PLSMGER.CH"
#INCLUDE "RPTDEF.CH"
#INCLUDE "TBICONN.CH"
#include 'fileio.ch'
#define cPicCNES	PesqPict("BB8","BB8_CNES")
#define __aCdCri049 {"020","O valor contratato e diferente do valor informado/apresentado."}
#define lSrvUnix IsSrvUnix()

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡ao    ?PLSTISS1  ?Autor ?Luciano Aparecido     ?Data ?08.01.07 ³±?
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡ao ?Estrutura Relatório TISS (Guia de Consulta ) -BOPS 095189   ³±?
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±?Uso      ?SigaPLS                                                     ³±?
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros?aDados - Array com as informações do relat´rio              ³±?
±±?         ?lGerTXT - Define se imprime direto sem passar pela tela 	  ³±?
±±?         ?		 de configuracao/preview do relatorio 		         ³±?
±±?         ?nLayout - Define o formato de papél para impressao:         ³±?
±±?         ?          1 - Formato Ofício II (216x330mm)                 ³±?
±±?         ?          2 - Formato A4 (210x297mm)                        ³±?
±±?         ?   	 	 3 - Formato Carta (216x279mm)     			     ³±?
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function CABTISS1(aDados, lGerTXT, nLayout, cLogoGH, lWeb, cPathRelW)

Local nLinMax
Local nColMax
Local nLinIni	:=	0		// Linha Lateral (inicial) Esquerda
Local nColIni	:=	0		// Coluna Lateral (inicial) Esquerda
Local nColA4    :=  0      // Para implementar layout A4
Local nLinA4    :=  0      // Para implementar layout A4
Local cFileLogo
Local nLin
Local nI, nX
Local cObs
Local oFont01
Local oFont02n
Local oFont03n
Local oFont04
Local oFont05
Local oPrint    := Nil
LOCAL cFileName	:= ""
LOCAL cRel      := "guicons"
LOCAL cPathSrvJ := GETMV("MV_RELT")
LOCAL nAL		:= 0.25
LOCAL nAC		:= 0.24

DEFAULT lGerTXT 	:= .F.
DEFAULT nLayout 	:= 2
DEFAULT cLogoGH 	:= ""
DEFAULT lWeb		:= .F.
DEFAULT cPathRelW 	:= ""
DEFAULT aDados := { {;
	"123456",;
	"12345678901234567892",;
	CtoD("01/01/07"),;
	"12345678901234567892",;
	Replicate("M",40),;
	CtoD("12/12/07"),;
	Replicate("M",70),;
	"123456789102345",;
	"14.141.114/00001-35",;
	Replicate("M",70),;
	"1234567",;
	"123",;
	Replicate("M",40),;
	"12345",;
	Replicate("M",15),;
	Replicate("M",40),;
	"ES",;
	"1234567",;
	"29800-000",;
	Replicate("M",70),;
	"MMMMMMM",;
	"123456789102345",;
	"ES",;
	"12345",;
	"M",;
	{ 12,"M" },;
	"0",;
	"12345",;
	"23456",;
	"34567",;
	"45678",;
	CtoD("12/12/06"),;
	"12",;
	"1234567890",;
	"1",;
	"1",;
	Replicate("M", 240),;
	CtoD("12/12/12"),;
	CtoD("12/12/12") } }

oFont01		:= TFont():New("Arial",  5,  5, , .F., , , , .T., .F.) // Normal

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
	//?Nao permite acionar a impressao quando for na web.
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
If lWeb
	cPathSrvJ := cPathRelW
	cFileName := cRel+lower(CriaTrab(NIL,.F.))+".pdf"
Else
	cFileName := cRel+CriaTrab(NIL,.F.)
EndIf

	//						New ( < cFilePrintert >, [ nDevice], [ lAdjustToLegacy], [ cPathInServer], [ lDisabeSetup ], [ lTReport], [ @oPrintSetup], [ cPrinter], [ lServer], [ lPDFAsPNG], [ lRaw], [ lViewPDF] )
If !lWeb
	oPrint := FWMSPrinter():New ( cFileName			,			,	.F.				,cPathSrvJ	 	,	.T.				,			 ,				,			  ,			  ,	.F.			, 		, 				)
Else
	oPrint := FWMSPrinter():New ( cFileName	,,.F.,cPathSrvJ	 ,.T.,	,@oPrint,			  ,			  ,	.F.			,.f.)
	If lSrvUnix
		AjusPath(@oPrint)
	EndIf
EndIf
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
	//³Tratamento para impressao via job
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
oPrint:lServer := lWeb

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
	//?Caminho do arquivo
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
oPrint:cPathPDF := cPathSrvJ

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
	//³Modo retrato
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
oPrint:SetPortrait()

If nLayout ==2
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
		//³Papél A4
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
	oPrint:SetPaperSize(9)
ElseIf nLayout ==3
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
		//³Papél Carta
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
	oPrint:SetPaperSize(1)
Else
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
		//³Papel Oficio2 216 x 330mm / 8 1/2 x 13in
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
	oPrint:SetPaperSize(14)
Endif

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
	//³Device
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
If lWeb
	oPrint:setDevice(IMP_PDF)
		//oPrint:lPDFAsPNG := .T.
EndIf
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
	//³Verifica se existe alguma impressora configurada para Impressao Grafica
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
If  !lWeb
	oPrint:Setup()
	If !(oPrint:nModalResult == 1)
		Return
	Endif
EndIf

If oPrint:nPaperSize  == 9 // Papél A4
	nLinMax	:= 1754
	nColMax	:= 2335
	nLayout 	:= 2
	oFont02n	:= TFont():New("Arial", 12, 12, , .T., , , , .T., .F.) // Negrito
	oFont03n	:= TFont():New("Arial", 13, 13, , .T., , , , .T., .F.) // Negrito
	oFont04		:= TFont():New("Arial", 07, 07, , .F., , , , .T., .F.) // Normal
	oFont05		:= TFont():New("Arial", 05, 05, , .F., , , , .T., .F.) // Normal
Elseif oPrint:nPaperSize == 1 // Papel Carta
	nLinMax	:= 1545
	nColMax	:= 2400
	nLayout 	:= 3
	oFont02n	:= TFont():New("Arial", 12, 12, , .T., , , , .T., .F.) // Negrito
	oFont03n	:= TFont():New("Arial", 13, 13, , .T., , , , .T., .F.) // Negrito
	oFont04		:= TFont():New("Arial", 07, 07, , .F., , , , .T., .F.) // Normal
	oFont05		:= TFont():New("Arial", 05, 05, , .F., , , , .T., .F.) // Normal
Else // Papel Oficio2 216 x 330mm / 8 1/2 x 13in
	nLinMax	:= 1764
	nColMax	:= 2400
	nLayout 	:= 1
	oFont02n	:= TFont():New("Arial", 12, 12, , .T., , , , .T., .F.) // Negrito
	oFont03n	:= TFont():New("Arial", 14, 14, , .T., , , , .T., .F.) // Negrito
	oFont04	:= TFont():New("Arial", 09, 09, , .F., , , , .T., .F.) // Normal
	oFont05	:= TFont():New("Arial", 05, 05, , .F., , , , .T., .F.) // Normal
Endif

For nX := 1 To Len(aDados)

	If ValType(aDados[nX]) == 'U' .OR. Len(aDados[nX]) == 0
		Loop
	EndIf

	If oPrint:Cprinter == "PDF" .OR. lWeb
		nLinIni	:= 150
	Else
		nLinIni := 100
	Endif
	nColIni := 065
	nLinA4  := 000
	nColA4  := 000

	oPrint:StartPage()		// Inicia uma nova pagina
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Box Principal                                                 ?
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	oPrint:Box((nLinIni + 0000)*nAL, (nColIni + 0000)*nAC, (nLinIni + nLinMax)*nAL, (nColIni + nColMax)*nAC)

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Carrega e Imprime Logotipo da Empresa                         ?
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	fLogoEmp(@cFileLogo,, cLogoGH)

	If File(cFilelogo)
		oPrint:SayBitmap((nLinIni + 0050)*nAL, (nColIni + 0020)*nAC, cFileLogo, (400)*nAL, (090)*nAC) // Tem que estar abaixo do RootPath
	EndIf

	if nLayout == 2 // Papél A4
		nColA4:= -0065
		nLinA4:= 0
	Endif

	oPrint:Say((nLinIni + 0090)*nAL, (nColIni + 1000 + nColA4)*nAC, "GUIA DE CONSULTA", oFont02n,,,, 2) //"GUIA DE CONSULTA"
	oPrint:Say((nLinIni + 0090)*nAL, (nColIni + 1700 + nColA4)*nAC, "2 - "+OemToAnsi("Nº"), oFont01) //"N?
	oPrint:Say((nLinIni + 0090)*nAL, (nColIni + 1801 + nColA4)*nAC, aDados[nX, 02], oFont03n)

	oPrint:Box((nLinIni + 0155)*nAL, (nColIni + 0010)*nAC, (nLinIni + 0249)*nAL + nLinA4, (nColIni + 0415)*nAC)
	oPrint:Say((nLinIni + 0180)*nAL, (nColIni + 0020)*nAC, "1 - "+"Registro ANS", oFont01) //"Registro ANS"
	oPrint:Say((nLinIni + 0220)*nAL, (nColIni + 0030)*nAC, aDados[nX, 01], oFont04)
	oPrint:Box((nLinIni + 0155)*nAL, (nColIni + 0420)*nAC, (nLinIni + 0249)*nAL + nLinA4, (nColIni + 0830)*nAC)
	oPrint:Say((nLinIni + 0180)*nAL, (nColIni + 0430)*nAC, "3 - "+"Data de Emissão da Guia", oFont01) //"Data de Emissão da Guia"
	oPrint:Say((nLinIni + 0220)*nAL, (nColIni + 0440)*nAC, DtoC(aDados[nX, 03]), oFont04)

	oPrint:Say((nLinIni + 0274 + nLinA4)*nAL, (nColIni + 0010)*nAC, "Dados do Beneficiário", oFont01) //"Dados do Beneficiário"
	oPrint:Box((nLinIni + 0284)*nAL + nLinA4, (nColIni + 0010)*nAC, (nLinIni + 0378)*nAL + (2*nLinA4), (nColIni + 0585)*nAC)
	oPrint:Say((nLinIni + 0309 + nLinA4)*nAL, (nColIni + 0020)*nAC, "4 - "+"Número da Carteira", oFont01) //"Número da Carteira"
	oPrint:Say((nLinIni + 0349 + nLinA4)*nAL, (nColIni + 0030)*nAC, aDados[nX, 04], oFont04)
	oPrint:Box((nLinIni + 0284)*nAL + nLinA4, (nColIni + 0590)*nAC, (nLinIni + 0378)*nAL + (2*nLinA4), (nColIni + 2112 + nColA4)*nAC)
	oPrint:Say((nLinIni + 0309 + nLinA4)*nAL, (nColIni + 0600)*nAC, "5 - "+"Plano", oFont01) //"Plano"
	oPrint:Say((nLinIni + 0349 + nLinA4)*nAL, (nColIni + 0610)*nAC, aDados[nX, 05], oFont04)
	oPrint:Box((nLinIni + 0284)*nAL + nLinA4, (nColIni + 2117)*nAC + nColA4, (nLinIni + 0378)*nAL + (2*nLinA4), (nColIni + 2390 + nColA4)*nAC)
	oPrint:Say((nLinIni + 0309 + nLinA4)*nAL, (nColIni + 2127 + nColA4)*nAC, "6 - "+"Validade da Carteira", oFont01) //"Validade da Carteira"
	oPrint:Say((nLinIni + 0349 + nLinA4)*nAL, (nColIni + 2137 + nColA4)*nAC, DtoC(aDados[nX, 06]), oFont04)

	oPrint:Box((nLinIni + 0383)*nAL + (2*nLinA4), (nColIni + 0010)*nAC, (nLinIni + 0477)*nAL + (3*nLinA4), (nColIni + 1965 + nColA4)*nAC)
	oPrint:Say((nLinIni + 0408 + (2*nLinA4))*nAL, (nColIni + 0020)*nAC, "7 - "+"Nome", oFont01) //"Nome"
	oPrint:Say((nLinIni + 0448 + (2*nLinA4))*nAL, (nColIni + 0030)*nAC, aDados[nX, 07], oFont04)
	oPrint:Box((nLinIni + 0383)*nAL + (2*nLinA4), (nColIni + 1970 + nColA4)*nAC, (nLinIni + 0477)*nAL + (3*nLinA4), (nColIni + 2390 + nColA4)*nAC)
	oPrint:Say((nLinIni + 0408 + (2*nLinA4))*nAL, (nColIni + 1980 + nColA4)*nAC, "8 - "+"Número do Cartão Nacional de Saúde", oFont01) //"Número do Cartão Nacional de Saúde"
	oPrint:Say((nLinIni + 0448 + (2*nLinA4))*nAL, (nColIni + 1990 + nColA4)*nAC, aDados[nX, 08], oFont04)

	oPrint:Say((nLinIni + 0502 + (3*nLinA4))*nAL, (nColIni + 0010)*nAC, "Dados do Contratado", oFont01) //"Dados do Contratado"
	oPrint:Box((nLinIni + 0512)*nAL + (3*nLinA4), (nColIni + 0010)*nAC, (nLinIni + 0606)*nAL + (4*nLinA4), (nColIni + 0426)*nAC)
	oPrint:Say((nLinIni + 0537 + (3*nLinA4))*nAL, (nColIni + 0020)*nAC, "9 - "+"Código na Operadora / CNPJ / CPF", oFont01) //"Código na Operadora / CNPJ / CPF"
	oPrint:Say((nLinIni + 0577 + (3*nLinA4))*nAL, (nColIni + 0030)*nAC, aDados[nX, 09], oFont04)
	oPrint:Box((nLinIni + 0512)*nAL + (3*nLinA4), (nColIni + 0431)*nAC, (nLinIni + 0606)*nAL + (4*nLinA4), (nColIni + 2165 + nColA4)*nAC)
	oPrint:Say((nLinIni + 0537 + (3*nLinA4))*nAL, (nColIni + 0441)*nAC, "10 - "+"Nome do Contratado", oFont01) //"Nome do Contratado"
	oPrint:Say((nLinIni + 0577 + (3*nLinA4))*nAL, (nColIni + 0451)*nAC, SubStr(aDados[nX, 10], 1, 65), oFont04)
	oPrint:Box((nLinIni + 0512)*nAL + (3*nLinA4), (nColIni + 2170 + nColA4)*nAC, (nLinIni + 0606)*nAL + (4*nLinA4), (nColIni + 2390 + nColA4)*nAC)
	oPrint:Say((nLinIni + 0537 + (3*nLinA4))*nAL, (nColIni + 2180 + nColA4)*nAC, "11 - "+"Código CNES", oFont01) //"Código CNES"
	oPrint:Say((nLinIni + 0577 + (3*nLinA4))*nAL, (nColIni + 2190 + nColA4)*nAC, aDados[nX, 11], oFont04)

	oPrint:Box((nLinIni + 0611)*nAL + (4*nLinA4), (nColIni + 0010)*nAC, (nLinIni + 0705)*nAL + (5*nLinA4), (nColIni + 0132)*nAC)
	oPrint:Say((nLinIni + 0636 + (4*nLinA4))*nAL, (nColIni + 0020)*nAC, "12 - "+"T.L.", oFont01) //"T.L."
	oPrint:Say((nLinIni + 0676 + (4*nLinA4))*nAL, (nColIni + 0030)*nAC, aDados[nX, 12], oFont04)
	oPrint:Box((nLinIni + 0611)*nAL + (4*nLinA4), (nColIni + 0137)*nAC, (nLinIni + 0705)*nAL + (5*nLinA4), (nColIni + 1050 + nColA4)*nAC)
	oPrint:Say((nLinIni + 0636 + (4*nLinA4))*nAL, (nColIni + 0147)*nAC, "13-14-15 - "+"Logradouro - Número - Complemento", oFont01) //"Logradouro - Número - Complemento"
	oPrint:Say((nLinIni + 0676 + (4*nLinA4))*nAL, (nColIni + 0157)*nAC, SubStr(AllTrim(aDados[nX, 13]) + IIf(!Empty(aDados[nX, 14]), ", ","") + AllTrim(aDados[nX, 14]) + IIf(!Empty(aDados[nX, 15]), " - ","") + AllTrim(aDados[nX, 15]), 1, 34), oFont04)
	oPrint:Box((nLinIni + 0611)*nAL + (4*nLinA4), (nColIni + 1055 + nColA4)*nAC, (nLinIni + 0705)*nAL + (5*nLinA4), (nColIni + 1830 + nColA4)*nAC)
	oPrint:Say((nLinIni + 0636 + (4*nLinA4))*nAL, (nColIni + 1065 + nColA4)*nAC, "16 - "+"Município", oFont01) //"Município"
	oPrint:Say((nLinIni + 0676 + (4*nLinA4))*nAL, (nColIni + 1075 + nColA4)*nAC, SubStr(aDados[nX, 16], 1, 29), oFont04)
	oPrint:Box((nLinIni + 0611)*nAL + (4*nLinA4), (nColIni + 1835 + nColA4)*nAC, (nLinIni + 0705)*nAL + (5*nLinA4), (nColIni + 1940 + nColA4)*nAC)
	oPrint:Say((nLinIni + 0636 + (4*nLinA4))*nAL, (nColIni + 1845 + nColA4)*nAC, "17 - "+"UF", oFont01) //"UF"
	oPrint:Say((nLinIni + 0676 + (4*nLinA4))*nAL, (nColIni + 1860 + nColA4)*nAC, aDados[nX, 17], oFont04)
	oPrint:Box((nLinIni + 0611)*nAL + (4*nLinA4), (nColIni + 1945 + nColA4)*nAC, (nLinIni + 0705)*nAL + (5*nLinA4), (nColIni + 2165 + nColA4)*nAC)
	oPrint:Say((nLinIni + 0636 + (4*nLinA4))*nAL, (nColIni + 1955 + nColA4)*nAC, "18 - "+"Código IBGE", oFont01) //"Código IBGE"
	oPrint:Say((nLinIni + 0676 + (4*nLinA4))*nAL, (nColIni + 1965 + nColA4)*nAC, aDados[nX, 18], oFont04)
	oPrint:Box((nLinIni + 0611)*nAL + (4*nLinA4), (nColIni + 2170 + nColA4)*nAC, (nLinIni + 0705)*nAL + (5*nLinA4), (nColIni + 2390 + nColA4)*nAC)
	oPrint:Say((nLinIni + 0636 + (4*nLinA4))*nAL, (nColIni + 2180 + nColA4)*nAC, "19 - "+"CEP", oFont01) //"CEP"
	oPrint:Say((nLinIni + 0676 + (4*nLinA4))*nAL, (nColIni + 2190 + nColA4)*nAC, aDados[nX, 19], oFont04)

	oPrint:Box((nLinIni + 0710)*nAL + (5*nLinA4), (nColIni + 0010)*nAC, (nLinIni + 0804)*nAL + (6*nLinA4), (nColIni + 1455 + nColA4)*nAC)
	oPrint:Say((nLinIni + 0735 + (5*nLinA4))*nAL, (nColIni + 0020)*nAC, "20 - "+"Nome do Profissional Executante", oFont01) //"Nome do Profissional Executante"
	oPrint:Say((nLinIni + 0775 + (5*nLinA4))*nAL, (nColIni + 0030)*nAC, SubStr(aDados[nX, 20], 1, 54), oFont04)
	oPrint:Box((nLinIni + 0710)*nAL + (5*nLinA4), (nColIni + 1460 + nColA4)*nAC, (nLinIni + 0804)*nAL + (6*nLinA4), (nColIni + 1735 + nColA4)*nAC)
	oPrint:Say((nLinIni + 0735 + (5*nLinA4))*nAL, (nColIni + 1470 + nColA4)*nAC, "21 - "+"Conselho Profissional", oFont01) //"Conselho Profissional"
	oPrint:Say((nLinIni + 0775 + (5*nLinA4))*nAL, (nColIni + 1480 + nColA4)*nAC, aDados[nX, 21], oFont04)
	oPrint:Box((nLinIni + 0710)*nAL + (5*nLinA4), (nColIni + 1740 + nColA4)*nAC, (nLinIni + 0804)*nAL + (6*nLinA4), (nColIni + 2065 + nColA4)*nAC)
	oPrint:Say((nLinIni + 0735 + (5*nLinA4))*nAL, (nColIni + 1750 + nColA4)*nAC, "22 - "+OemToAnsi("Número no Conselho"), oFont01) //"Número no Conselho"
	oPrint:Say((nLinIni + 0775 + (5*nLinA4))*nAL, (nColIni + 1760 + nColA4)*nAC, aDados[nX, 22], oFont04)
	oPrint:Box((nLinIni + 0710)*nAL + (5*nLinA4), (nColIni + 2070 + nColA4)*nAC, (nLinIni + 0804)*nAL + (6*nLinA4), (nColIni + 2165 + nColA4)*nAC)
	oPrint:Say((nLinIni + 0735 + (5*nLinA4))*nAL, (nColIni + 2080 + nColA4)*nAC, "23 - "+"UF", oFont01) //"UF"
	oPrint:Say((nLinIni + 0775 + (5*nLinA4))*nAL, (nColIni + 2090 + nColA4)*nAC, aDados[nX, 23], oFont04)
	oPrint:Box((nLinIni + 0710)*nAL + (5*nLinA4), (nColIni + 2170 + nColA4)*nAC, (nLinIni + 0804)*nAL + (6*nLinA4), (nColIni + 2390 + nColA4)*nAC)
	oPrint:Say((nLinIni + 0735 + (5*nLinA4))*nAL, (nColIni + 2180 + nColA4)*nAC, "24 - "+"Código CBO S", oFont01) //"Código CBO S"
	oPrint:Say((nLinIni + 0775 + (5*nLinA4))*nAL, (nColIni + 2190 + nColA4)*nAC, aDados[nX, 24], oFont04)

	oPrint:Say((nLinIni  + 0829 + (6*nLinA4))*nAL, (nColIni + 0010)*nAC, "Hipóteses Diagnósticas", oFont01) //"Hipóteses Diagnósticas"
	oPrint:Box((nLinIni  + 0839)*nAL + (6*nLinA4), (nColIni + 0010)*nAC, (nLinIni + 0933)*nAL + (7*nLinA4), (nColIni + 0315)*nAC)
	oPrint:Say((nLinIni  + 0864 + (6*nLinA4))*nAL, (nColIni + 0020)*nAC, "25 - "+"Tipo de Doença", oFont01) //"Tipo de Doença"
	oPrint:Line((nLinIni + 0874)*nAL + (6*nLinA4), (nColIni + 0030)*nAC, (nLinIni + 0921)*nAL + (7*nLinA4), (nColIni + 0030)*nAC)
	oPrint:Line((nLinIni + 0921)*nAL + (7*nLinA4), (nColIni + 0030)*nAC, (nLinIni + 0921)*nAL + (7*nLinA4), (nColIni + 0077)*nAC)
	oPrint:Line((nLinIni + 0874)*nAL + (6*nLinA4), (nColIni + 0077)*nAC, (nLinIni + 0921)*nAL + (7*nLinA4), (nColIni + 0077)*nAC)
	oPrint:Say((nLinIni  + 0904 + (6*nLinA4))*nAL, (nColIni + 0043)*nAC, aDados[nX, 25], oFont04)
	oPrint:Say((nLinIni  + 0904 + (6*nLinA4))*nAL, (nColIni + 0090)*nAC, "A-Aguda"+"    "+"C-Crônica", oFont01)  //"A-Aguda"###"C-Crônica"
	oPrint:Box((nLinIni  + 0839)*nAL + (6*nLinA4), (nColIni + 0320)*nAC, (nLinIni + 0933)*nAL + (7*nLinA4), (nColIni + 0765)*nAC)
	oPrint:Say((nLinIni  + 0864 + (6*nLinA4))*nAL, (nColIni + 0330)*nAC, "26 - "+"Tempo de Doença", oFont01) //"Tempo de Doença"
	oPrint:Line((nLinIni + 0874)*nAL + (6*nLinA4), (nColIni + 0340)*nAC, (nLinIni + 0921)*nAL + (7*nLinA4), (nColIni + 0340)*nAC)
	oPrint:Line((nLinIni + 0921)*nAL + (7*nLinA4), (nColIni + 0340)*nAC, (nLinIni + 0921)*nAL + (7*nLinA4), (nColIni + 0426)*nAC)
	oPrint:Line((nLinIni + 0874)*nAL + (6*nLinA4), (nColIni + 0426)*nAC, (nLinIni + 0921)*nAL + (7*nLinA4), (nColIni + 0426)*nAC)
	oPrint:Say((nLinIni  + 0904 + (6*nLinA4))*nAL, (nColIni + 0353)*nAC, IIF((StrZero(aDados[nX, 26,1], 2, 0))=="00","",(StrZero(aDados[nX, 26,1], 2, 0))), oFont04)
	oPrint:Say((nLinIni  + 0899 + (6*nLinA4))*nAL, (nColIni + 0434)*nAC, "-", oFont01)
	oPrint:Line((nLinIni + 0874)*nAL + (6*nLinA4), (nColIni + 0447)*nAC, (nLinIni + 0921)*nAL + (7*nLinA4), (nColIni + 0447)*nAC)
	oPrint:Line((nLinIni + 0921)*nAL + (7*nLinA4), (nColIni + 0447)*nAC, (nLinIni + 0921)*nAL + (7*nLinA4), (nColIni + 0494)*nAC)
	oPrint:Line((nLinIni + 0874)*nAL + (6*nLinA4), (nColIni + 0494)*nAC, (nLinIni + 0921)*nAL + (7*nLinA4), (nColIni + 0494)*nAC)
	oPrint:Say((nLinIni  + 0904 + (6*nLinA4))*nAL, (nColIni + 0457)*nAC, aDados[nX, 26,2], oFont04)
	oPrint:Say((nLinIni  + 0904 + (6*nLinA4))*nAL, (nColIni + 0510)*nAC, "A-Anos"+"  "+"M-Meses"+"  "+"D-Dias", oFont01) //"A-Anos"###"M-Meses"###"D-Dias"
	oPrint:Box((nLinIni + 0839)*nAL  + (6*nLinA4), (nColIni + 0770)*nAC, (nLinIni + 0933)*nAL + (7*nLinA4), (nColIni + 1807)*nAC)
	oPrint:Say((nLinIni + 0864  + (6*nLinA4))*nAL, (nColIni + 0780)*nAC, "27 - "+"Indicação de Acidente", oFont01) //"Indicação de Acidente"
	oPrint:Line((nLinIni+ 0869)*nAL  + (6*nLinA4), (nColIni + 0790)*nAC, (nLinIni + 0921)*nAL + (7*nLinA4), (nColIni + 0790)*nAC)
	oPrint:Line((nLinIni+ 0921)*nAL  + (7*nLinA4), (nColIni + 0790)*nAC, (nLinIni + 0921)*nAL + (7*nLinA4), (nColIni + 0832)*nAC)
	oPrint:Line((nLinIni+ 0869)*nAL  + (6*nLinA4), (nColIni + 0832)*nAC, (nLinIni + 0921)*nAL + (7*nLinA4), (nColIni + 0832)*nAC)
	oPrint:Say((nLinIni + 0904  + (6*nLinA4))*nAL, (nColIni + 0803)*nAC, aDados[nX, 27], oFont04)
	oPrint:Say((nLinIni + 0904  + (6*nLinA4))*nAL, (nColIni + 0850)*nAC, "0 - "+"Acidente ou doença relacionado ao trabalho"+"     "+"1 - "+"Trânsito"+"     "+"2 - "+"Outros", oFont01) //"Acidente ou doença relacionado ao trabalho"###"Trânsito"###"Outros"

	oPrint:Box((nLinIni + 0938)*nAL + (7*nLinA4), (nColIni + 0010)*nAC, (nLinIni + 1032)*nAL + (8*nLinA4), (nColIni + 0285)*nAC)
	oPrint:Say((nLinIni + 0963 + (7*nLinA4))*nAL, (nColIni + 0020)*nAC, "28 - "+"CID Principal", oFont01) //"CID Principal"
	oPrint:Say((nLinIni + 1003 + (7*nLinA4))*nAL, (nColIni + 0030)*nAC, aDados[nX, 28], oFont04)
	oPrint:Box((nLinIni + 0938)*nAL + (7*nLinA4), (nColIni + 0290)*nAC, (nLinIni + 1032)*nAL + (8*nLinA4), (nColIni + 0565)*nAC)
	oPrint:Say((nLinIni + 0963 + (7*nLinA4))*nAL, (nColIni + 0300)*nAC, "29 - "+"CID (2)", oFont01) //"CID (2)"
	oPrint:Say((nLinIni + 1003 + (7*nLinA4))*nAL, (nColIni + 0310)*nAC, aDados[nX, 29], oFont04)
	oPrint:Box((nLinIni + 0938)*nAL + (7*nLinA4), (nColIni + 0570)*nAC, (nLinIni + 1032)*nAL + (8*nLinA4), (nColIni + 0845)*nAC)
	oPrint:Say((nLinIni + 0963 + (7*nLinA4))*nAL, (nColIni + 0580)*nAC, "30 - "+"CID (3)", oFont01) //"CID (3)"
	oPrint:Say((nLinIni + 1003 + (7*nLinA4))*nAL, (nColIni + 0590)*nAC, aDados[nX, 30], oFont04)
	oPrint:Box((nLinIni + 0938)*nAL + (7*nLinA4), (nColIni + 0850)*nAC, (nLinIni + 1032)*nAL + (8*nLinA4), (nColIni + 1115)*nAC)
	oPrint:Say((nLinIni + 0963 + (7*nLinA4))*nAL, (nColIni + 0860)*nAC, "31 - "+"CID (4)", oFont01) //"CID (4)"
	oPrint:Say((nLinIni + 1003 + (7*nLinA4))*nAL, (nColIni + 0870)*nAC, aDados[nX, 31], oFont04)

	oPrint:Say((nLinIni + 1057 + (8*nLinA4))*nAL, (nColIni + 0010)*nAC, "Dados do Atendimento"+" / "+"Procedimento Realizado", oFont01) //"Dados do Atendimento"###"Procedimento Realizado"
	oPrint:Box((nLinIni + 1067)*nAL + (8*nLinA4), (nColIni + 0010)*nAC, (nLinIni + 1161)*nAL + (9*nLinA4), (nColIni + 0305)*nAC)
	oPrint:Say((nLinIni + 1092 + (8*nLinA4))*nAL, (nColIni + 0020)*nAC, "32 - "+"Data do Atendimento", oFont01) //"Data do Atendimento"
	oPrint:Say((nLinIni + 1132 + (8*nLinA4))*nAL, (nColIni + 0030)*nAC, DtoC(aDados[nX, 32]), oFont04)
	oPrint:Box((nLinIni + 1067)*nAL + (8*nLinA4), (nColIni + 0310)*nAC, (nLinIni + 1161)*nAL + (9*nLinA4), (nColIni + 0565)*nAC)
	oPrint:Say((nLinIni + 1092 + (8*nLinA4))*nAL, (nColIni + 0320)*nAC, "33 - "+"Código Tabela", oFont01) //"Código Tabela"
	oPrint:Say((nLinIni + 1132 + (8*nLinA4))*nAL, (nColIni + 0330)*nAC, aDados[nX, 33], oFont04)
	oPrint:Box((nLinIni + 1067)*nAL + (8*nLinA4), (nColIni + 0570)*nAC, (nLinIni + 1161)*nAL + (9*nLinA4), (nColIni + 0900)*nAC)
	oPrint:Say((nLinIni + 1092 + (8*nLinA4))*nAL, (nColIni + 0580)*nAC, "34 - "+OemToansi("Código Procedimento"), oFont01) //"Código Procedimento"
	oPrint:Say((nLinIni + 1132 + (8*nLinA4))*nAL, (nColIni + 0590)*nAC, aDados[nX, 34], oFont04)

	oPrint:Box((nLinIni + 1166)*nAL  + (9*nLinA4), (nColIni + 0010)*nAC, (nLinIni + 1260)*nAL + (10*nLinA4), (nColIni + 0505)*nAC)
	oPrint:Say((nLinIni + 1191  + (9*nLinA4))*nAL, (nColIni + 0020)*nAC, "35 - "+"Tipo de Consulta", oFont01) //"Tipo de Consulta"
	oPrint:Line((nLinIni + 1206)*nAL + (9*nLinA4), (nColIni + 0030)*nAC, (nLinIni + 1253)*nAL + (10*nLinA4), (nColIni + 0030)*nAC)
	oPrint:Line((nLinIni + 1253)*nAL +(10*nLinA4), (nColIni + 0030)*nAC, (nLinIni + 1253)*nAL + (10*nLinA4), (nColIni + 0077)*nAC)
	oPrint:Line((nLinIni + 1206)*nAL + (9*nLinA4), (nColIni + 0077)*nAC, (nLinIni + 1253)*nAL + (10*nLinA4), (nColIni + 0077)*nAC)
	oPrint:Say((nLinIni + 1231  + (9*nLinA4))*nAL, (nColIni + 0043)*nAC, aDados[nX, 35], oFont04)
	oPrint:Say((nLinIni + 1231  + (9*nLinA4))*nAL, (nColIni + 0090)*nAC, "1-"+"Primeira"+"   "+"2-"+"Seguimento"+"   "+"3-"+OemToAnsi("PréNatal"), oFont01) //"Primeira"###"Seguimento"###"Pr?Natal"
	oPrint:Box((nLinIni + 1166)*nAL  + (9*nLinA4), (nColIni + 0510)*nAC, (nLinIni + 1260)*nAL + (10*nLinA4), (nColIni + 1250)*nAC)
	oPrint:Say((nLinIni + 1191  + (9*nLinA4))*nAL, (nColIni + 0520)*nAC, "36 - "+"Tipo de Saída", oFont01) //"Tipo de Saída"
	oPrint:Line((nLinIni + 1206)*nAL + (9*nLinA4), (nColIni + 0530)*nAC, (nLinIni + 1253)*nAL + (10*nLinA4), (nColIni + 0530)*nAC)
	oPrint:Line((nLinIni + 1253)*nAL +(10*nLinA4), (nColIni + 0530)*nAC, (nLinIni + 1253)*nAL + (10*nLinA4), (nColIni + 0577)*nAC)
	oPrint:Line((nLinIni + 1206)*nAL + (9*nLinA4), (nColIni + 0577)*nAC, (nLinIni + 1253)*nAL + (10*nLinA4), (nColIni + 0577)*nAC)
	oPrint:Say((nLinIni + 1231  + (9*nLinA4))*nAL, (nColIni + 0543)*nAC, aDados[nX, 36], oFont04)
	oPrint:Say((nLinIni + 1231  + (9*nLinA4))*nAL, (nColIni + 0590)*nAC, "1-"+"Retorno"+"   "+"2-"+"Retorno SADT"+"   "+"3-"+"Referência"+"   "+"4-"+"Internação"+"   "+"5-"+"Alta", oFont01) //"Retorno"###"Retorno SADT"###"Referência"###"Internação"###"Alta"

	oPrint:Box((nLinIni + 1265)*nAL + (10*nLinA4), (nColIni + 0010)*nAC, (nLinIni + 1557)*nAL + IIf(nLayout ==2,(13*nLinA4),(20*nLinA4)), (nColIni + 2390 + nColA4)*nAC)
	oPrint:Say((nLinIni + 1290 + (10*nLinA4))*nAL, (nColIni + 0020)*nAC, "37 - "+"Observação", oFont01) //"Observação"
	nLin := 1335

	For nI := 1 To MlCount(aDados[nX, 37], 80)
		cObs := MemoLine(aDados[nX, 37], 80, nI)
		oPrint:Say((nLinIni + nLin + (10*nLinA4))*nAL, (nColIni + 0030)*nAC, cObs, oFont04)
		nLin += 35
	Next nI

	oPrint:Box((nLinIni + 1562)*nAL + IIf(nLayout ==2,(13*nLinA4),(20*nLinA4)), (nColIni + 0010)*nAC, (nLinIni + 1734)*nAL + IIf(nLayout ==2,(14*nLinA4),(22*nLinA4)), (nColIni + 1185 + nColA4)*nAC)
	oPrint:Say((nLinIni + 1587 + IIf(nLayout ==2,(13*nLinA4),(20*nLinA4)))*nAL, (nColIni + 0020)*nAC, "38 - "+"Data e Assinatura do Profissional", oFont01) //"Data e Assinatura do Profissional"
	oPrint:Say((nLinIni + 1627 + IIf(nLayout ==2,(13*nLinA4),(20*nLinA4)))*nAL, (nColIni + 0030)*nAC, DtoC(aDados[nX, 38]), oFont04)
	oPrint:Box((nLinIni + 1562)*nAL + IIf(nLayout ==2,(13*nLinA4),(20*nLinA4)), (nColIni + 1190 + nColA4)*nAC, (nLinIni + 1734)*nAL + IIf(nLayout ==2,(14*nLinA4),(22*nLinA4)), (nColIni + 2390 + nColA4)*nAC)
	oPrint:Say((nLinIni + 1587 + IIf(nLayout ==2,(13*nLinA4),(20*nLinA4)))*nAL, (nColIni + 1200 + nColA4)*nAC, "39 - "+"Data e Assinatura do Beneficiário ou Responsável", oFont01) //"Data e Assinatura do Beneficiário ou Responsável"
	oPrint:Say((nLinIni + 1627 + IIf(nLayout ==2,(13*nLinA4),(20*nLinA4)))*nAL, (nColIni + 1210 + nColA4)*nAC, DtoC(aDados[nX, 39]), oFont04)

	oPrint:EndPage()	// Finaliza a pagina

Next nX

If lGerTXT .And. !lWeb
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
		//³Imprime Relatorio
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
	oPrint:Print()
Else
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
		//³Visualiza impressao grafica antes de imprimir
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
	oPrint:Print()
EndIf


Return (cFileName)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡ao    ?PLSTISS2  ?Autor ?Luciano Aparecido     ?Data ?08.01.07 ³±?
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡ao ?Estrutura Relatório TISS (Guia de Serv/SADT ) - BOPS 095189 ³±?
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±?Uso      ?SigaPLS                                                     ³±?
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros?aDados - Array com as informações do relat´rio              ³±?
±±?         ?lGerTXT - Define se imprime direto sem passar pela tela	   ³±?
±±?         ?		 de configuracao/preview do relatorio 		       ³±?
±±?         ?nLayout - Define o formato de papél para impressao:         ³±?
±±?         ?          1 - Formato Ofício II (216x330mm)                 ³±?
±±?         ?          2 - Formato A4 (210x297mm)                        ³±?
±±?         ? 		 3 - Formato Carta (216x279mm)     			       ³±?
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function CABTISS2(aDados, lGerTXT, nLayout, cLogoGH, lWeb, cPathRelW)

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
Local nOldColIni
Local nI, nJ, nX, nN
Local nV, nV1, nV2, nV3, nV4
Local cObs
Local oFont01
Local oFont02n
Local oFont03n
Local oFont04
Local oFont05
Local oPrint    := Nil
Local lImpnovo  :=.T.
Local nVolta    := 0
Local nP        := 0
Local nP1       := 0
Local nP2       := 0
Local nP3       := 0
Local nP4       := 0
Local nT        := 0
Local nT1       := 0
Local nT2       := 0
Local nT3       := 0
Local nT4       := 0
Local nTotOPM   := 0
Local nProx     := 0
LOCAL cFileName	:= ""
LOCAL cRel      := "guisadt"
LOCAL cPathSrvJ := GETMV("MV_RELT")
LOCAL nAL		:= 0.25
LOCAL nAC		:= 0.24
Local lImpPrc   := .T.
Local cTissVer  := "2.02.03" //PLSTISSVER()

If FindFunction("PLSTISSVER")
	cTissVer	:= PLSTISSVER()
EndIf


DEFAULT lGerTXT 	:= .F.
DEFAULT nLayout 	:= 2
DEFAULT cLogoGH 	:= ""
DEFAULT lWeb		:= .F.
DEFAULT cPathRelW 	:= ""
DEFAULT aDados 	:= { {;
					"123456",;
					"12345678901234567892",;
					"12345678901234567892",;
					CtoD("01/01/07"),;
					"12345678901234567892",;
					CtoD("01/01/07"),;
					CtoD("01/01/07"),;
					"12345678901234567892",;
					Replicate("M",20),;
					CtoD("12/12/07"),;
					Replicate("M",70),;
					"123456789102345",;
					"14.141.114/00001-35",;
					Replicate("M",70),;
					"1234567",;
					Replicate("M",70),;
					"1234567",;
					"123456789102345",;
					"ES",;
					"12345",;
					{ CtoD("12/12/07"), "2210" },;
					"E",;
					"12345",;
					Replicate("M",70),;
					{ "10", "20", "30", "40", "50" } ,;
					{ "1234567890", "2345678901", "3456789012", "4567890123", "5678901234" },;
					{ Replicate("M",60),Replicate("B",60),Replicate("C",60),Replicate("D",60),Replicate("E",60) },;
					{ 111,111,11,1,1 },;
					{ 999,999,99,9,9 },;
					"14.141.114/00001-35",;
					Replicate("M",70),;
					"999",;
					Replicate("M",40),;
					"MMMMM",;
					Replicate("M",15),;
					Replicate("M",40),;
					"MM",;
					"1234567",;
					"12345-678",;
					{ "1234567", "27.456.658/0001-35" },;
					Replicate("M",70),;
					"1234567",;
					"123456789102345",;
					"MM",;
					{ "12345", "01" },;
					"01",;
					"1",;
					"1",;
					"1",;
					{ 12,"M" },;
					{ CtoD("01/01/07"),CtoD("01/02/07"),CtoD("01/03/07"),CtoD("01/04/07"),CtoD("01/05/07")},;
					{ "0107","0207","0307","0407","0507" },;
					{ "0607","0707","0807","0907","1007" },;
					{ "MM","AA","BB","CC","DD"},;
					{ "1234567890","2345678901","3456789012","4567890123","5678901234"},;
					{ Replicate("M",60),Replicate("B",60),Replicate("C",60),Replicate("D",60),Replicate("E",60)},;
					{ 12,1,2,3,4},;
					{ "M","A","B","C","D"},;
					{ "M","E","F","G","H"},;
					{ 111.00,222.00,333.00,444.00,999.99 },;
					{ 99999999.99,22222.22,33333.33,44444.44,11111.11 },;
					{ 11111111.11,55555.00,66666.00,77777.00,88888.00 },;
					{ CtoD("01/01/07"),CtoD("02/01/07"),CtoD("03/01/07"),CtoD("04/01/07"),CtoD("05/01/07"),CtoD("06/01/07"),CtoD("07/01/07"),CtoD("08/01/07"),CtoD("09/01/07"),CtoD("10/01/07")},;
					Replicate("M", 240),;
					{1333333.22},;
					{2333333.22},;
					{3333333.22},;
					{4333333.22},;
					{5333333.22},;
					{6333333.22},;
					{73333333.22},;
					{ "11", "22", "33", "44", "55", "66", "77", "88", "99" },;
					{ "1234567890", "2345678901", "3456789012", "4567890123", "5678901234", "6789012345", "7890123456", "8901234567", "9012345678" },;
					{ Replicate ("M", 60), Replicate ("A", 60), Replicate ("B", 60), Replicate ("C", 60), Replicate ("D", 60), Replicate ("E", 60), Replicate ("F", 60), Replicate ("G", 60), Replicate ("H", 60) },;
					{ 01, 1, 2, 03, 04, 05, 06, 7, 99 }, ;
					{ Replicate ("I", 40), Replicate ("J", 40), Replicate ("K", 40), Replicate ("L", 40), Replicate ("M", 40), Replicate ("N", 40), Replicate ("O", 40), Replicate ("P", 40), Replicate ("Q", 40) },;
					{ 999999.99, 111111.99, 222229.99, 333999.99, 444449.99, 555559.99, 666669,99, 777779.99, 888899.99 },;
					{ "11", "12", "13", "14", "15", "16", "17", "18", "19" },;
					{ "1234567890", "2345678901", "3456789012", "4567890123", "5678901234", "6789012345", "7890123456", "8901234567", "9012345678" },;
					{ Replicate ("A", 60), Replicate ("B", 60), Replicate ("C", 60), Replicate ("D", 60), Replicate ("E", 60), Replicate ("F", 60), Replicate ("G", 60), Replicate ("H", 60), Replicate ("I", 60) },;
					{ 01, 2, 3, 04, 05, 06, 07, 8, 99 }, ;
					{ Replicate ("J", 20), Replicate ("K", 20), Replicate ("L", 20), Replicate ("M", 20), Replicate ("N", 20), Replicate ("O", 20), Replicate ("P", 20), Replicate ("Q", 20), Replicate ("R", 20) },;
					{ 199999.99, 299999.99, 399999.99, 499999.99, 599999.99, 699999.99, 799.99, 899999.99, 99.99 },;
					{ 399999999.99, 499999999.99, 599999999.99, 699999.99, 799999.99, 899999.99, 99.99, 09.99, 19.99 },;
					{1999999.99},;
					CtoD("01/01/07"),;
					CtoD("02/01/07"),;
					CtoD("03/01/07"),;
					CtoD("04/01/07") } }

oFont01	:= TFont():New("Arial",  5,  5, , .F., , , , .T., .F.) // Normal

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
//?Nao permite acionar a impressao quando for na web.
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
If lWeb
	cPathSrvJ := cPathRelW
	cFileName := cRel+lower(CriaTrab(NIL,.F.))+".pdf"
Else
	cFileName := cRel+CriaTrab(NIL,.F.)
EndIf

//						New ( < cFilePrintert >, [ nDevice], [ lAdjustToLegacy], [ cPathInServer], [ lDisabeSetup ], [ lTReport], [ @oPrintSetup], [ cPrinter], [ lServer], [ lPDFAsPNG], [ lRaw], [ lViewPDF] )
if !lWeb
	oPrint := FWMSPrinter():New ( cFileName			,			,	.F.				,cPathSrvJ	 	,	.T.				,			 ,				,			  ,			  ,	.F.			, 		, 				)
else
	oPrint := FWMSPrinter():New ( cFileName	,,.F.,cPathSrvJ	 ,.T.,	,@oPrint,			  ,			  ,	.F.			,.f.)
	If lSrvUnix
		AjusPath(@oPrint)
	EndIf
Endif
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
//³Tratamento para impressao via job
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
//oPrint:lInJob  := lWeb
oPrint:lServer := lWeb
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
//?Caminho do arquivo
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
oPrint:cPathPDF := cPathSrvJ

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
//³Modo paisagem
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
oPrint:SetLandscape()

if nLayout ==2
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
	//³Papél A4
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
	oPrint:SetPaperSize(9)
Elseif nLayout ==3
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
	//³Papél Carta
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
	oPrint:SetPaperSize(1)
Else
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
	//³Papel Oficio2 216 x 330mm / 8 1/2 x 13in
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
	oPrint:SetPaperSize(14)
Endif
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
//³Device
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
If lWeb
	oPrint:setDevice(IMP_PDF)
	//oPrint:lPDFAsPNG := .T.
EndIf
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄaÄÄÄÄÄÄÄÄÄÄ?
//³Verifica se existe alguma impressora configurada para Impressao Grafica
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
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
	nColMax	:=	3355 //3508 //3380 //3365
	nLayout 	:= 2
	oFont02n	:= TFont():New("Arial", 12, 12, , .T., , , , .T., .F.) // Negrito
	oFont03n	:= TFont():New("Arial", 13, 13, , .T., , , , .T., .F.) // Negrito
	oFont04		:= TFont():New("Arial", 07, 07, , .F., , , , .T., .F.) // Normal
	oFont05		:= TFont():New("Arial", 06, 06, ,.F., , , , .T., .F.) // Normal
Elseif oPrint:nPaperSize == 1 // Papel Carta
	nLinMax	:=	2000
	nColMax	:=	3175
	nLayout 	:= 3
	oFont02n	:= TFont():New("Arial", 12, 12, , .T., , , , .T., .F.) // Negrito
	oFont03n	:= TFont():New("Arial", 13, 13, , .T., , , , .T., .F.) // Negrito
	oFont04		:= TFont():New("Arial", 07, 07, , .F., , , , .T., .F.) // Normal
	oFont05		:= TFont():New("Arial", 06, 06, , .F., , , , .T., .F.) // Normal
Else // Papel Oficio2 216 x 330mm / 8 1/2 x 13in
	nLinMax	:=	2435
	nColMax	:=	3765
	nLayout 	:= 1
	oFont02n	:= TFont():New("Arial", 12, 12, , .T., , , , .T., .F.) // Negrito
	oFont03n	:= TFont():New("Arial", 14, 14, , .T., , , , .T., .F.) // Negrito
	oFont04		:= TFont():New("Arial", 09, 09, , .F., , , , .T., .F.) // Normal
	oFont05		:= TFont():New("Arial", 06, 06, , .F., , , , .T., .F.) // Normal
Endif

While lImpnovo

	lImpnovo:=.F.
	nVolta  += 1
	nT      += 5
	nT1     += 5
	nT2     +=10
	nT3     += 9
	nT4     += 9
	nProx   += 1

	For nX := 1 To Len(aDados)

		If ValType(aDados[nX]) == 'U' .OR. Len(aDados[nX]) == 0
			Loop
		EndIf

		For nI := 25 To 29
			If Len(aDados[nX, nI]) < nT
				For nJ := Len(aDados[nX, nI]) + 1 To nT
					If AllTrim(Str(nI)) $ "28,29"
						aAdd(aDados[nX, nI], 0)
					Else
						aAdd(aDados[nX, nI], "")
					EndIf
				Next nJ
			EndIf
		Next nI

		For nI := 51 To 62
			If Len(aDados[nX, nI]) < nT1
				For nJ := Len(aDados[nX, nI]) + 1 To nT1
					If AllTrim(Str(nI)) $ "51"
						aAdd(aDados[nX, nI], StoD(""))
					ElseIf AllTrim(Str(nI)) $ "57,60,61,62"
						aAdd(aDados[nX, nI], 0)
					Else
						aAdd(aDados[nX, nI], "")
					EndIf
				Next nJ
			EndIf
		Next nI

		For nI := 63 To 63
			If Len(aDados[nX, nI]) < nT2
				For nJ := Len(aDados[nX, nI]) + 1 To nT2
					aAdd(aDados[nX, nI], StoD(""))
				Next nJ
			EndIf
		Next nI

		For nI := 65 To 71
			If Len(aDados[nX, nI]) < nVolta
				For nJ := Len(aDados[nX, nI]) + 1 To nVolta
					If AllTrim(Str(nI)) $ "65,66,67,68,69,70,71"
						aAdd(aDados[nX, nI], 0)
					EndIf
				Next nJ
			EndIf
		Next nI

		For nI := 72 To 77
			If Len(aDados[nX, nI]) < nT3
				For nJ := Len(aDados[nX, nI]) + 1 To nT3
					If AllTrim(Str(nI)) $ "75,77"
						aAdd(aDados[nX, nI], 0)
					Else
						aAdd(aDados[nX, nI], "")
					EndIf
				Next nJ
			EndIf
		Next nI

		For nI := 78 To 84
			If Len(aDados[nX, nI]) < nT4
				For nJ := Len(aDados[nX, nI]) + 1 To nT4
					If AllTrim(Str(nI)) $ "81,83,84"
						aAdd(aDados[nX, nI], 0)
					Else
						aAdd(aDados[nX, nI], "")
					EndIf
				Next nJ
			EndIf
		Next nI

		For nI := 85 To 85
			If Len(aDados[nX, nI]) < nVolta
				For nJ := Len(aDados[nX, nI]) + 1 To nVolta
					aAdd(aDados[nX, nI], 0)
				Next nJ
			EndIf
		Next nI
		If oPrint:Cprinter == "PDF" .OR. lWeb
			nLinIni	:= 150
			nLimFim	:= 400
		Else
			nLinIni	:= 060
			nLimFim	:= 230
		Endif


		nColIni		:= 068
		nColA4		:= 000
		nLinA4		:= 000
		nColSoma	:= 000
		nColSoma2	:= 000

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
		//³Inicia uma nova pagina
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
		oPrint:StartPage()
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Box Principal                                                 ?
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		oPrint:Box((nLinIni + 0000)*nAL, (nColIni + 0000)*nAC, (nLimFim + nLinMax)*nAL, (nColIni + nColMax)*nAC)
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Carrega e Imprime Logotipo da Empresa                         ?
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

		oPrint:Say((nLinIni + 0050)*nAL, (nColIni + 1702)*nAC + (nColA4/2), "GUIA DE SERVIÇO PROFISSIONAL / SERVIÇO AUXILIAR DE DIAGNÓSTICO E TERAPIA - SP/SADT", oFont02n,,,, 2) //"GUIA DE SERVIÇO PROFISSIONAL / SERVIÇO AUXILIAR DE DIAGNÓSTICO E TERAPIA - SP/SADT"
		oPrint:Say((nLinIni + 0050)*nAL, (nColIni + 2930 + IIf (nLayout == 3,(nColA4/2+(nColSoma/3)),(nColA4/2)))*nAC, "2 - "+"Nº", oFont01) //"N?
		oPrint:Say((nLinIni + 0050)*nAL, (nColIni + 3026 + IIf (nLayout == 3,(nColA4/2+(nColSoma/3)),(nColA4/2)))*nAC, aDados[nX, 02], oFont03n)

		oPrint:Box((nLinIni + 0175)*nAL + nLinA4, (nColIni + 0010			)*nAC, (nLinIni + 0269)*nAL + nLinA4, (nColIni + 0315)*nAC)
		oPrint:Say((nLinIni + 0180 + nLinA4)*nAL, (nColIni + 0020			)*nAC, "1 - "+"Registro ANS", oFont01) //"Registro ANS"
		oPrint:Say((nLinIni + 0210 + nLinA4)*nAL, (nColIni + 0030			)*nAC, aDados[nX, 01], oFont04)
		oPrint:Box((nLinIni + 0175)*nAL + nLinA4, (nColIni + 0320			)*nAC, (nLinIni + 0269)*nAL + nLinA4, (nColIni + 1035)*nAC)
		oPrint:Say((nLinIni + 0180 + nLinA4)*nAL, (nColIni + 0330			)*nAC, "3 - "+OemToAnsi("Nº Guia Principal"), oFont01) //"N?Guia Principal"
		oPrint:Say((nLinIni + 0210 + nLinA4)*nAL, (nColIni + 0340			)*nAC, aDados[nX, 03], oFont04)
		oPrint:Box((nLinIni + 0175)*nAL + nLinA4, (nColIni + 1040			)*nAC, (nLinIni + 0269)*nAL + nLinA4, (nColIni + 1345)*nAC)
		oPrint:Say((nLinIni + 0180 + nLinA4)*nAL, (nColIni + 1050			)*nAC, "4 - "+OemToansi("Data da Autorização"), oFont01) //"Data da Autorização"
		oPrint:Say((nLinIni + 0210 + nLinA4)*nAL, (nColIni + 1060			)*nAC, DtoC(aDados[nX, 04]), oFont04)
		oPrint:Box((nLinIni + 0175)*nAL + nLinA4, (nColIni + 1350			)*nAC, (nLinIni + 0269)*nAL + nLinA4, (nColIni + 1755)*nAC)
		oPrint:Say((nLinIni + 0180 + nLinA4)*nAL, (nColIni + 1360			)*nAC, "5 - "+"Senha", oFont01) //"Senha"
		oPrint:Say((nLinIni + 0210 + nLinA4)*nAL, (nColIni + 1370			)*nAC, aDados[nX, 05], oFont04)
		oPrint:Box((nLinIni + 0175)*nAL + nLinA4, (nColIni + 1760			)*nAC, (nLinIni + 0269)*nAL + nLinA4, (nColIni + 2165)*nAC)
		oPrint:Say((nLinIni + 0180 + nLinA4)*nAL, (nColIni + 1770			)*nAC, "6 - "+"Data Validade da Senha", oFont01) //"Data Validade da Senha"
		oPrint:Say((nLinIni + 0210 + nLinA4)*nAL, (nColIni + 1780			)*nAC, DtoC(aDados[nX, 06]), oFont04)
		oPrint:Box((nLinIni + 0175)*nAL + nLinA4, (nColIni + 2170			)*nAC, (nLinIni + 0269)*nAL + nLinA4, (nColIni + 2465)*nAC)
		oPrint:Say((nLinIni + 0180 + nLinA4)*nAL, (nColIni + 2180			)*nAC, "7 - "+"Data de Emissão da Guia", oFont01) //"Data de Emissão da Guia"
		oPrint:Say((nLinIni + 0210 + nLinA4)*nAL, (nColIni + 2190			)*nAC, DtoC(aDados[nX, 07]), oFont04)

		oPrint:Say((nLinIni + 0274 + nLinA4)*nAL, (nColIni + 0010			)*nAC, "Dados do Beneficiário", oFont01) //"Dados do Beneficiário"
		oPrint:Box((nLinIni + 0304)*nAL + nLinA4, (nColIni + 0010			)*nAC, (nLinIni + 0398)*nAL + nLinA4, (nColIni + 0425)*nAC)
		oPrint:Say((nLinIni + 0309 + nLinA4)*nAL, (nColIni + 0020			)*nAC, "8 - "+OemToAnsi("Número da Carteira"), oFont01) //"Número da Carteira"
		oPrint:Say((nLinIni + 0339 + nLinA4)*nAL, (nColIni + 0030			)*nAC, aDados[nX, 08], oFont04)
		oPrint:Box((nLinIni + 0304)*nAL + nLinA4, (nColIni + 0430			)*nAC, (nLinIni + 0398)*nAL + nLinA4, (nColIni + 1572 + nColA4)*nAC)
		oPrint:Say((nLinIni + 0309 + nLinA4)*nAL, (nColIni + 0440			)*nAC, "9 - "+"Plano", oFont01) //"Plano"
		oPrint:Say((nLinIni + 0339 + nLinA4)*nAL, (nColIni + 0450			)*nAC, aDados[nX, 09], oFont04)
		oPrint:Box((nLinIni + 0304)*nAL + nLinA4, (nColIni + 1577 + nColA4	)*nAC, (nLinIni + 0398)*nAL + nLinA4, (nColIni + 1835 + nColA4)*nAC)
		oPrint:Say((nLinIni + 0309 + nLinA4)*nAL, (nColIni + 1587 + nColA4	)*nAC, "10 - "+"Validade da Carteira", oFont01) //"Validade da Carteira"
		oPrint:Say((nLinIni + 0339 + nLinA4)*nAL, (nColIni + 1597 + nColA4	)*nAC, DtoC(aDados[nX, 10]), oFont04)
		oPrint:Box((nLinIni + 0304)*nAL + nLinA4, (nColIni + 1840 + nColA4	)*nAC, (nLinIni + 0398)*nAL + nLinA4, (nColIni + 3290 + nColA4)*nAC)
		oPrint:Say((nLinIni + 0309 + nLinA4)*nAL, (nColIni + 1850 + nColA4	)*nAC, "11 - "+"Nome", oFont01) //"Nome"
		oPrint:Say((nLinIni + 0339 + nLinA4)*nAL, (nColIni + 1860 + nColA4	)*nAC, SubStr(aDados[nX, 11], 1, 52), oFont04)
		oPrint:Box((nLinIni + 0304)*nAL + nLinA4, (nColIni + 3295 + nColA4	)*nAC, (nLinIni + 0398)*nAL + nLinA4, (nColIni + 3745 + nColA4)*nAC)
		oPrint:Say((nLinIni + 0309 + nLinA4)*nAL, (nColIni + 3305 + nColA4	)*nAC, "12 - "+OemToAnsi("Número do Cartão Nacional de Saúde"), oFont01) //"Número do Cartão Nacional de Saúde"
		oPrint:Say((nLinIni + 0339 + nLinA4)*nAL, (nColIni + 3315 + nColA4	)*nAC, aDados[nX, 12], oFont04)

		oPrint:Say((nLinIni + 0403 + nLinA4)*nAL, (nColIni + 0010			)*nAC, OemToAnsi("Dados do Contratado Solicitante"), oFont01) //"Dados do Contratado Solicitante"
		oPrint:Box((nLinIni + 0433)*nAL + nLinA4, (nColIni + 0010			)*nAC, (nLinIni + 0527)*nAL + nLinA4, (nColIni + 0426)*nAC)
		oPrint:Say((nLinIni + 0438 + nLinA4)*nAL, (nColIni + 0020			)*nAC, "13 - "+"Código na Operadora / CNPJ / CPF", oFont01) //"Código na Operadora / CNPJ / CPF"
		oPrint:Say((nLinIni + 0468 + nLinA4)*nAL, (nColIni + 0030			)*nAC, aDados[nX, 13], oFont04)
		oPrint:Box((nLinIni + 0433)*nAL + nLinA4, (nColIni + 0431			)*nAC, (nLinIni + 0527)*nAL + nLinA4, (nColIni + 2245)*nAC)
		oPrint:Say((nLinIni + 0438 + nLinA4)*nAL, (nColIni + 0441			)*nAC, "14 - "+"Nome do Contratado", oFont01) //"Nome do Contratado"
		oPrint:Say((nLinIni + 0468 + nLinA4)*nAL, (nColIni + 0451			)*nAC, SubStr(aDados[nX, 14], 1, 65), oFont04)
		oPrint:Box((nLinIni + 0433)*nAL + nLinA4, (nColIni + 2250			)*nAC, (nLinIni + 0527)*nAL + nLinA4, (nColIni + 2480)*nAC)
		oPrint:Say((nLinIni + 0438 + nLinA4)*nAL, (nColIni + 2260			)*nAC, "15 - "+OemToAnsi("Código CNES"), oFont01) //"Código CNES"
		oPrint:Say((nLinIni + 0468 + nLinA4)*nAL, (nColIni + 2270			)*nAC, aDados[nX, 15], oFont04)

		oPrint:Box((nLinIni + 0532)*nAL + nLinA4, (nColIni + 0010			)*nAC, (nLinIni + 0626)*nAL + nLinA4, (nColIni + 1824)*nAC)
		oPrint:Say((nLinIni + 0537 + nLinA4)*nAL, (nColIni + 0020			)*nAC, "16 - "+"Nome do Profissional Solicitante", oFont01) //"Nome do Profissional Solicitante"
		oPrint:Say((nLinIni + 0567 + nLinA4)*nAL, (nColIni + 0030			)*nAC, SubStr(aDados[nX, 16], 1, 66), oFont04)
		oPrint:Box((nLinIni + 0532)*nAL + nLinA4, (nColIni + 1829			)*nAC, (nLinIni + 0626)*nAL + nLinA4, (nColIni + 2122)*nAC)
		oPrint:Say((nLinIni + 0537 + nLinA4)*nAL, (nColIni + 1839			)*nAC, "17 - "+"Conselho Profissional", oFont01) //"Conselho Profissional"
		oPrint:Say((nLinIni + 0567 + nLinA4)*nAL, (nColIni + 1849			)*nAC, aDados[nX, 17], oFont04)
		oPrint:Box((nLinIni + 0532)*nAL + nLinA4, (nColIni + 2127			)*nAC, (nLinIni + 0626)*nAL + nLinA4, (nColIni + 2480)*nAC)
		oPrint:Say((nLinIni + 0537 + nLinA4)*nAL, (nColIni + 2137			)*nAC, "18 - "+"Número no Conselho", oFont01) //"Número no Conselho"
		oPrint:Say((nLinIni + 0567 + nLinA4)*nAL, (nColIni + 2147			)*nAC, aDados[nX, 18], oFont04)
		oPrint:Box((nLinIni + 0532)*nAL + nLinA4, (nColIni + 2485			)*nAC, (nLinIni + 0626)*nAL + nLinA4, (nColIni + 2575)*nAC)
		oPrint:Say((nLinIni + 0537 + nLinA4)*nAL, (nColIni + 2495			)*nAC, "19 - "+"UF", oFont01) //"UF"
		oPrint:Say((nLinIni + 0567 + nLinA4)*nAL, (nColIni + 2505			)*nAC, aDados[nX, 19], oFont04)
		oPrint:Box((nLinIni + 0532)*nAL + nLinA4, (nColIni + 2580			)*nAC, (nLinIni + 0626)*nAL + nLinA4, (nColIni + 2790)*nAC)
		oPrint:Say((nLinIni + 0537 + nLinA4)*nAL, (nColIni + 2590			)*nAC, "20 - "+"Código CBO S", oFont01) //"Código CBO S"
		oPrint:Say((nLinIni + 0567 + nLinA4)*nAL, (nColIni + 2600			)*nAC, aDados[nX, 20], oFont04)

		oPrint:Say((nLinIni + 0631 + nLinA4)*nAL, (nColIni + 0010)*nAC, "Dados da Solicitação / Procedimentos e Exames Solicitados", oFont01) //"Dados da Solicitação / Procedimentos e Exames Solicitados"
		oPrint:Box((nLinIni + 0661)*nAL + nLinA4, (nColIni + 0010)*nAC, (nLinIni + 0755)*nAL + nLinA4, (nColIni + 0315)*nAC)
		oPrint:Say((nLinIni + 0660 + nLinA4)*nAL, (nColIni + 0020)*nAC, "21 - "+"Data/Hora da Solicitação", oFont01) //"Data/Hora da Solicitação"
		oPrint:Say((nLinIni + 0696 + nLinA4)*nAL, (nColIni + 0030)*nAC, DtoC(aDados[nX, 21,1]) + " " + Transform(aDados[nX, 21,2], "@R 99:99"), oFont04)
		oPrint:Box((nLinIni + 0661)*nAL + nLinA4, (nColIni + 0320)*nAC, (nLinIni + 0755)*nAL + nLinA4, (nColIni + 0735)*nAC)
		oPrint:Say((nLinIni + 0660 + nLinA4)*nAL, (nColIni + 0330)*nAC, "22 - "+"Caráter da Solicitação", oFont01) //"Caráter da Solicitação"
		oPrint:Line((nLinIni + 0691)*nAL+ nLinA4, 		(nColIni + 0340)*nAC, (nLinIni + 0728)*nAL + (nLinA4/2), (nColIni + 0340)*nAC)
		oPrint:Line((nLinIni + 0728)*nAL+ (nLinA4/2), 	(nColIni + 0340)*nAC, (nLinIni + 0728)*nAL + (nLinA4/2), (nColIni + 0387)*nAC)
		oPrint:Line((nLinIni + 0691)*nAL+ nLinA4, 		(nColIni + 0387)*nAC, (nLinIni + 0728)*nAL + (nLinA4/2), (nColIni + 0387)*nAC)
		oPrint:Say((nLinIni + 0696 + nLinA4)*nAL, (nColIni + 0353)*nAC, aDados[nX, 22], oFont04)
		oPrint:Say((nLinIni + 0703 + nLinA4)*nAL, (nColIni + 0400)*nAC, "E-Eletiva"+"  "+"U-Urgência/Emergência", oFont01) //"E-Eletiva"###"U-Urgência/Emergência"
		oPrint:Box((nLinIni + 0661)*nAL + nLinA4, (nColIni + 0740)*nAC, (nLinIni + 0755)*nAL + nLinA4, (nColIni + 0905)*nAC)
		oPrint:Say((nLinIni + 0660 + nLinA4)*nAL, (nColIni + 0750)*nAC, "23 - "+"CID 10", oFont01) //"CID 10"
		oPrint:Say((nLinIni + 0696 + nLinA4)*nAL, (nColIni + 0760)*nAC, aDados[nX, 23], oFont04)
		oPrint:Box((nLinIni + 0661)*nAL + nLinA4, (nColIni + 0910)*nAC, (nLinIni + 0755)*nAL + nLinA4, (nColIni + 3745 + nColA4)*nAC)
		oPrint:Say((nLinIni + 0660 + nLinA4)*nAL, (nColIni + 0920)*nAC, "24 - "+OemToAnsi("Indicação Clínica (obrigatório se pequena cirurgia, terapia, consulta referenciada e alto custo)"), oFont01) //"Indicação Clínica (obrigatório se pequena cirurgia, terapia, consulta referenciada e alto custo)"
		oPrint:Say((nLinIni + 0696 + nLinA4)*nAL, (nColIni + 0930)*nAC, aDados[nX, 24], oFont04)

		oPrint:Box((nLinIni + 0760)*nAL + nLinA4, (nColIni + 0010			)*nAC, (nLinIni + 1005)*nAL + nLinA4, (nColIni + 3745 + nColA4)*nAC)
		oPrint:Say((nLinIni + 0765 + nLinA4)*nAL, (nColIni + 0020			)*nAC, "25 - "+"Tabela", oFont01) //"Tabela"
		oPrint:Say((nLinIni + 0765 + nLinA4)*nAL, (nColIni + 0150			)*nAC, "26 - "+"Código do Procedimento", oFont01) //"Código do Procedimento"
		oPrint:Say((nLinIni + 0765 + nLinA4)*nAL, (nColIni + 0450			)*nAC, "27 - "+"Descrição", oFont01) //"Descrição"
		oPrint:Say((nLinIni + 0765 + nLinA4)*nAL, (nColIni + 3400 + nColA4	)*nAC, "28 - "+"Qt.Solic.", oFont01,,,,1) //"Qt.Solic."
		oPrint:Say((nLinIni + 0765 + nLinA4)*nAL, (nColIni + 3610 + nColA4	)*nAC, "29 - "+"Qt.Autoriz.", oFont01,,,,1) //"Qt.Autoriz."

		nOldLinIni := nLinIni

		if nVolta = 1
			nV:=1
		Endif

		For nP := nV To nT
			if nVolta <> 1
				nN:=nP-((5*nVolta)-5)
				oPrint:Say((nLinIni + 0805 + nLinA4)*nAL, (nColIni + 0025)*nAC, AllTrim(Str(nN)) + " - ", oFont01)
			else
				oPrint:Say((nLinIni + 0805 + nLinA4)*nAL, (nColIni + 0025)*nAC, AllTrim(Str(nP)) + " - ", oFont01)
			endif
			oPrint:Say((nLinIni + 0800 + nLinA4)*nAL, (nColIni + 0065)*nAC			, aDados[nX, 25, nP], oFont04)
			oPrint:Say((nLinIni + 0800 + nLinA4)*nAL, (nColIni + 0150)*nAC			, aDados[nX, 26, nP], oFont04)
			oPrint:Say((nLinIni + 0800 + nLinA4)*nAL, (nColIni + 0450)*nAC			, aDados[nX, 27, nP], oFont04)
			oPrint:Say((nLinIni + 0800 + nLinA4)*nAL, (nColIni + 3425 + nColA4)*nAC, IIf(Empty(aDados[nX, 28, nP]), "", Transform(aDados[nX, 28, nP], "@E 9999.99")), oFont04,,,,1)
			oPrint:Say((nLinIni + 0800 + nLinA4)*nAL, (nColIni + 3635 + nColA4)*nAC, IIf(Empty(aDados[nX, 29, nP]), "", Transform(aDados[nX, 29, nP], "@E 9999.99")), oFont04,,,,1)
			nLinIni += 40
		Next nP

		if nT < Len(aDados[nX, 26]).or. lImpnovo
			  nV:=nP
			  lImpnovo:=.T.
		Endif

		nLinIni := nOldLinIni

		oPrint:Say((nLinIni + 1000 + nLinA4)*nAL, (nColIni + 0010			)*nAC, "Dados do Contratado Executante", oFont01) //"Dados do Contratado Executante"
		oPrint:Box((nLinIni + 1040)*nAL + nLinA4, (nColIni + 0010			)*nAC, (nLinIni + 1134)*nAL + nLinA4, (nColIni + 0416)*nAC)
		oPrint:Say((nLinIni + 1045 + nLinA4)*nAL, (nColIni + 0020			)*nAC, "30 - "+"Código na Operadora / CNPJ / CPF", oFont01) //"Código na Operadora / CNPJ / CPF"
		oPrint:Say((nLinIni + 1075 + nLinA4)*nAL, (nColIni + 0030			)*nAC, aDados[nX, 30], oFont04)
		oPrint:Box((nLinIni + 1040)*nAL + nLinA4, (nColIni + 0421			)*nAC, (nLinIni + 1134)*nAL + nLinA4, (nColIni + 1316 + nColSoma)*nAC)
		oPrint:Say((nLinIni + 1045 + nLinA4)*nAL, (nColIni + 0431			)*nAC, "31 - "+"Nome do Contratado", oFont01) //"Nome do Contratado"
		oPrint:Say((nLinIni + 1075 + nLinA4)*nAL, (nColIni + 0441			)*nAC, SubStr(aDados[nX, 31], 1, 32), oFont04)
		oPrint:Box((nLinIni + 1040)*nAL + nLinA4, (nColIni + 1321 + nColSoma)*nAC, (nLinIni + 1134)*nAL + nLinA4, (nColIni + 1433 + nColSoma)*nAC)
		oPrint:Say((nLinIni + 1045 + nLinA4)*nAL, (nColIni + 1331 + nColSoma)*nAC, "32 - "+"T.L.", oFont01) //"T.L."
		oPrint:Say((nLinIni + 1075 + nLinA4)*nAL, (nColIni + 1341 + nColSoma)*nAC, aDados[nX, 32], oFont04)
		oPrint:Box((nLinIni + 1040)*nAL + nLinA4, (nColIni + 1438 + nColSoma)*nAC, (nLinIni + 1134)*nAL + nLinA4, (nColIni + 2413 + nColA4)*nAC)
		oPrint:Say((nLinIni + 1045 + nLinA4)*nAL, (nColIni + 1448 + nColSoma)*nAC, "33-34-35 - "+"Logradouro - Número - Complemento", oFont01) //"Logradouro - Número - Complemento"
		oPrint:Say((nLinIni + 1075 + nLinA4)*nAL, (nColIni + 1458 + nColSoma)*nAC, SubStr(AllTrim(aDados[nX, 33]) + IIf(!Empty(aDados[nX, 34]), ", ","") + AllTrim(aDados[nX, 34]) + IIf(!Empty(aDados[nX, 35]), " - ","") + AllTrim(aDados[nX, 35]), 1, 35), oFont04)
		oPrint:Box((nLinIni + 1040)*nAL + nLinA4, (nColIni + 2418 + nColA4	)*nAC, (nLinIni + 1134)*nAL + nLinA4, (nColIni + 3023 + nColA4)*nAC)
		oPrint:Say((nLinIni + 1045 + nLinA4)*nAL, (nColIni + 2428 + nColA4	)*nAC, "36 - "+"Município", oFont01) //"Município"
		oPrint:Say((nLinIni + 1075 + nLinA4)*nAL, (nColIni + 2438 + nColA4	)*nAC, SubStr(aDados[nX, 36], 1, 21), oFont04)
		oPrint:Box((nLinIni + 1040)*nAL + nLinA4, (nColIni + 3028 + nColA4	)*nAC, (nLinIni + 1134)*nAL + nLinA4, (nColIni + 3130 + nColA4)*nAC)
		oPrint:Say((nLinIni + 1045 + nLinA4)*nAL, (nColIni + 3038 + nColA4	)*nAC, "37 - "+"UF", oFont01) //"UF"
		oPrint:Say((nLinIni + 1075 + nLinA4)*nAL, (nColIni + 3048 + nColA4	)*nAC, aDados[nX, 37], oFont04)
		oPrint:Box((nLinIni + 1040)*nAL + nLinA4, (nColIni + 3135 + nColA4	)*nAC, (nLinIni + 1134)*nAL + nLinA4, (nColIni + 3320 + nColA4)*nAC)
		oPrint:Say((nLinIni + 1045 + nLinA4)*nAL, (nColIni + 3145 + nColA4	)*nAC, "38 - "+OemToAnsi("Cód.IBGE"), oFont01) //"Cód.IBGE"
		oPrint:Say((nLinIni + 1075 + nLinA4)*nAL, (nColIni + 3155 + nColA4	)*nAC, aDados[nX, 38], oFont04)
		oPrint:Box((nLinIni + 1040)*nAL + nLinA4, (nColIni + 3325 + nColA4	)*nAC, (nLinIni + 1134)*nAL + nLinA4, (nColIni + 3510 + nColA4)*nAC)
		oPrint:Say((nLinIni + 1045 + nLinA4)*nAL, (nColIni + 3335 + nColA4	)*nAC, "39 - "+"CEP", oFont01) //"CEP"
		oPrint:Say((nLinIni + 1075 + nLinA4)*nAL, (nColIni + 3345 + nColA4	)*nAC, aDados[nX, 39], oFont04)
		oPrint:Box((nLinIni + 1040)*nAL + nLinA4, (nColIni + 3515 + nColA4	)*nAC, (nLinIni + 1134)*nAL + nLinA4, (nColIni + 3745 + nColA4)*nAC)
		oPrint:Say((nLinIni + 1045 + nLinA4)*nAL, (nColIni + 3525 + nColA4	)*nAC, "40 - "+"Código CNES", oFont01) //"Código CNES"
		oPrint:Say((nLinIni + 1075 + nLinA4)*nAL, (nColIni + 3535 + nColA4	)*nAC, aDados[nX, 40, 1], oFont04)

		oPrint:Box((nLinIni + 1139)*nAL + nLinA4, (nColIni + 0010)*nAC, (nLinIni + 1233)*nAL + nLinA4, (nColIni + 0590)*nAC)
		oPrint:Say((nLinIni + 1144 + nLinA4)*nAL, (nColIni + 0020)*nAC, "40a - "+"Código na Operadora / CPF do exec. complementar", oFont01) //"Código na Operadora / CPF do exec. complementar"
		oPrint:Say((nLinIni + 1174 + nLinA4)*nAL, (nColIni + 0030)*nAC, SubStr(aDados[nX, 40, 2], 1, 68), oFont04)
		oPrint:Box((nLinIni + 1139)*nAL + nLinA4, (nColIni + 0595)*nAC, (nLinIni + 1233)*nAL + nLinA4, (nColIni + 2436 + IIf(nLayout == 2,nColA4,nColSoma+nColSoma2))*nAC)
		oPrint:Say((nLinIni + 1144 + nLinA4)*nAL, (nColIni + 0605)*nAC, "41 - "+"Nome do Profissional Executante/Complementar", oFont01) //"Nome do Profissional Executante/Complementar"
		oPrint:Say((nLinIni + 1174 + nLinA4)*nAL, (nColIni + 0615)*nAC, SubStr(aDados[nX, 41], 1, 68), oFont04)
		oPrint:Box((nLinIni + 1139)*nAL + nLinA4, (nColIni + 2441 + IIf(nLayout == 2,nColA4,nColSoma+nColSoma2))*nAC, (nLinIni + 1233)*nAL + nLinA4, (nColIni + 2715 + IIf(nLayout == 2,nColA4,nColSoma+nColSoma2))*nAC)
		oPrint:Say((nLinIni + 1144 + nLinA4)*nAL, (nColIni + 2451 + IIf(nLayout == 2,nColA4,nColSoma+nColSoma2))*nAC, "42 - "+"Conselho Profissional", oFont01) //"Conselho Profissional"
		oPrint:Say((nLinIni + 1174 + nLinA4)*nAL, (nColIni + 2461 + IIf(nLayout == 2,nColA4,nColSoma+nColSoma2))*nAC, aDados[nX, 42], oFont04)
		oPrint:Box((nLinIni + 1139)*nAL + nLinA4, (nColIni + 2720 + IIf(nLayout == 2,nColA4,nColSoma+nColSoma2))*nAC, (nLinIni + 1233)*nAL + nLinA4, (nColIni + 3055 + IIf(nLayout == 2,nColA4,nColSoma+nColSoma2))*nAC)
		oPrint:Say((nLinIni + 1144 + nLinA4)*nAL, (nColIni + 2730 + IIf(nLayout == 2,nColA4,nColSoma+nColSoma2))*nAC, "43 - "+"Número no Conselho", oFont01) //"Número no Conselho"
		oPrint:Say((nLinIni + 1174 + nLinA4)*nAL, (nColIni + 2740 + IIf(nLayout == 2,nColA4,nColSoma+nColSoma2))*nAC, aDados[nX, 43], oFont04)
		oPrint:Box((nLinIni + 1139)*nAL + nLinA4, (nColIni + 3060 + IIf(nLayout == 2,nColA4,nColSoma+nColSoma2))*nAC, (nLinIni + 1233)*nAL + nLinA4, (nColIni + 3160 + IIf(nLayout == 2,nColA4,nColSoma+nColSoma2))*nAC)
		oPrint:Say((nLinIni + 1144 + nLinA4)*nAL, (nColIni + 3070 + IIf(nLayout == 2,nColA4,nColSoma+nColSoma2))*nAC, "44 - "+"UF", oFont01) //"UF"
		oPrint:Say((nLinIni + 1174 + nLinA4)*nAL, (nColIni + 3080 + IIf(nLayout == 2,nColA4,nColSoma+nColSoma2))*nAC, aDados[nX, 44], oFont04)
		oPrint:Box((nLinIni + 1139)*nAL + nLinA4, (nColIni + 3165 + IIf(nLayout == 2,nColA4,nColSoma+nColSoma2))*nAC, (nLinIni + 1233)*nAL + nLinA4, (nColIni + 3372 + IIf(nLayout == 2,nColA4,nColSoma+nColSoma2))*nAC)
		oPrint:Say((nLinIni + 1144 + nLinA4)*nAL, (nColIni + 3175 + IIf(nLayout == 2,nColA4,nColSoma+nColSoma2))*nAC, "45 - "+OemToAnsi("Código CBO S"), oFont01) //"Código CBO S"
		oPrint:Say((nLinIni + 1174 + nLinA4)*nAL, (nColIni + 3185 + IIf(nLayout == 2,nColA4,nColSoma+nColSoma2))*nAC, aDados[nX, 45, 1], oFont04)
		oPrint:Box((nLinIni + 1139)*nAL + nLinA4, (nColIni + 3377 + IIf(nLayout == 2,nColA4,nColSoma+nColSoma2))*nAC, (nLinIni + 1233)*nAL + nLinA4, (nColIni + 3745 + nColA4)*nAC)
		oPrint:Say((nLinIni + 1144 + nLinA4)*nAL, (nColIni + 3387 + IIf(nLayout == 2,nColA4,nColSoma+nColSoma2))*nAC, "45a - "+"Grau de Participação", oFont01) //"Grau de Participação"
		oPrint:Say((nLinIni + 1174 + nLinA4)*nAL, (nColIni + 3397 + IIf(nLayout == 2,nColA4,nColSoma+nColSoma2))*nAC, aDados[nX, 45, 2], oFont04)

		oPrint:Say((nLinIni + 1236 + nLinA4)*nAL, (nColIni + 0010)*nAC, "Dados do Atendimento", oFont01) //"Dados do Atendimento"
		oPrint:Box((nLinIni + 1268)*nAL + nLinA4, (nColIni + 0010)*nAC, (nLinIni + 1362)*nAL + nLinA4, (nColIni + 1185)*nAC)
		oPrint:Say((nLinIni + 1273 + nLinA4)*nAL, (nColIni + 0020)*nAC, "46 - "+"Tipo Atendimento", oFont01) //"Tipo Atendimento"
		oPrint:Line((nLinIni + 1298)*nAL+ nLinA4, (nColIni + 0030)*nAC, (nLinIni + 1348)*nAL + nLinA4, (nColIni + 0030)*nAC)
		oPrint:Line((nLinIni + 1348)*nAL+ nLinA4, (nColIni + 0030)*nAC, (nLinIni + 1348)*nAL + nLinA4, (nColIni + 0087)*nAC)
		oPrint:Line((nLinIni + 1298)*nAL+ nLinA4, (nColIni + 0087)*nAC, (nLinIni + 1348)*nAL + nLinA4, (nColIni + 0087)*nAC)
		oPrint:Say((nLinIni + 1303 + nLinA4)*nAL, (nColIni + 0043)*nAC, aDados[nX, 46], oFont04)
		oPrint:Say((nLinIni + 1298 + nLinA4)*nAL, (nColIni + 0100)*nAC, "01 - "+"Remoção"+"    "+"02 - "+"Pequena Cirurgia"+"    "+"03 - "+"Terapias"+"    "+"04 - "+"Consulta"+"    "+"05 - "+"Exame"+"    "+"06 - "+"Atendimento Domiciliar", oFont01) //"Remoção"###"Pequena Cirurgia"###"Terapias"###"Consulta"###"Exame"###"Atendimento Domiciliar"
		oPrint:Say((nLinIni + 1328 + nLinA4)*nAL, (nColIni + 0100)*nAC, "07 - "+"SADT Internado"+"    "+"08 - "+"Quimioterapia"+"    "+"09 - "+"Radioterapia"+"    "+"10 - "+"TRS-Terapia Renal Substitutiva", oFont01) //"SADT Internado"###"Quimioterapia"###"Radioterapia"###"TRS-Terapia Renal Substitutiva"
		oPrint:Box((nLinIni + 1268)*nAL + nLinA4, (nColIni + 1190)*nAC, (nLinIni + 1362)*nAL + nLinA4, (nColIni + 2450 + nColA4/2)*nAC)
		oPrint:Say((nLinIni + 1273 + nLinA4)*nAL, (nColIni + 1200)*nAC, "47 - "+"Indicação de Acidente", oFont01) //"Indicação de Acidente"
		oPrint:Line((nLinIni + 1298)*nAL+ nLinA4, (nColIni + 1210)*nAC, (nLinIni + 1348)*nAL + nLinA4, (nColIni + 1210)*nAC)
		oPrint:Line((nLinIni + 1348)*nAL+ nLinA4, (nColIni + 1210)*nAC, (nLinIni + 1348)*nAL + nLinA4, (nColIni + 1257)*nAC)
		oPrint:Line((nLinIni + 1298)*nAL+ nLinA4, (nColIni + 1257)*nAC, (nLinIni + 1348)*nAL + nLinA4, (nColIni + 1257)*nAC)
		oPrint:Say((nLinIni + 1303 + nLinA4)*nAL, (nColIni + 1223)*nAC, aDados[nX, 47], oFont04)
		oPrint:Say((nLinIni + 1313 + nLinA4)*nAL, (nColIni + 1270)*nAC, "0 - "+"Acidente ou doença relacionado ao trabalho"+"   "+"1 - "+"Trânsito"+"   "+"2 - "+"Outros", oFont01) //"Acidente ou doença relacionado ao trabalho"###"Trânsito"###"Outros"
		oPrint:Box((nLinIni + 1268)*nAL + nLinA4, (nColIni + 2455 + nColA4/2)*nAC, (nLinIni + 1362)*nAL + nLinA4, (nColIni + 3745 + nColA4)*nAC)
		oPrint:Say((nLinIni + 1273 + nLinA4)*nAL, (nColIni + 2465 + nColA4/2)*nAC, "48 - "+"Tipo de Saída", oFont01) //"Tipo de Saída"
		oPrint:Line((nLinIni + 1298)*nAL+ nLinA4, (nColIni + 2475 + nColA4/2)*nAC, (nLinIni + 1348)*nAL + nLinA4, (nColIni + 2475 + nColA4/2)*nAC)
		oPrint:Line((nLinIni + 1348)*nAL+ nLinA4, (nColIni + 2475 + nColA4/2)*nAC, (nLinIni + 1348)*nAL + nLinA4, (nColIni + 2522 + nColA4/2)*nAC)
		oPrint:Line((nLinIni + 1298)*nAL+ nLinA4, (nColIni + 2522 + nColA4/2)*nAC, (nLinIni + 1348)*nAL + nLinA4, (nColIni + 2522 + nColA4/2)*nAC)
		oPrint:Say((nLinIni + 1303 + nLinA4)*nAL, (nColIni + 2488 + nColA4/2)*nAC, aDados[nX, 48], oFont04)
		oPrint:Say((nLinIni + 1313 + nLinA4)*nAL, (nColIni + 2535 + nColA4/2)*nAC, "1 - "+"Retorno"+"    "+"2 - "+"Retorno SADT"+"    "+"3 - "+"Referência"+"    "+"4 - "+"Internação"+"    "+"5 - "+"Alta"+"    "+"6 - "+"Óbito", oFont01) //"Retorno"###"Retorno SADT"###"Referência"###"Internação"###"Alta"###"Óbito"

		oPrint:Say((nLinIni + 1367 + nLinA4)*nAL , (nColIni + 0010)*nAC, "Consulta Referência", oFont01) //"Consulta Referência"
		oPrint:Box((nLinIni + 1397)*nAL + nLinA4 , (nColIni + 0010)*nAC, (nLinIni + 1491)*nAL + nLinA4, (nColIni + 0315)*nAC)
		oPrint:Say((nLinIni + 1402 + nLinA4)*nAL , (nColIni + 0020)*nAC, "49 - "+"Tipo de Doença", oFont01) //"Tipo de Doença"
		oPrint:Line((nLinIni + 1427)*nAL + nLinA4, (nColIni + 0030)*nAC, (nLinIni + 1477)*nAL + nLinA4, (nColIni + 0030)*nAC)
		oPrint:Line((nLinIni + 1477)*nAL + nLinA4, (nColIni + 0030)*nAC, (nLinIni + 1477)*nAL + nLinA4, (nColIni + 0077)*nAC)
		oPrint:Line((nLinIni + 1427)*nAL + nLinA4, (nColIni + 0077)*nAC, (nLinIni + 1477)*nAL + nLinA4, (nColIni + 0077)*nAC)
		oPrint:Say((nLinIni + 1432  + nLinA4)*nAL, (nColIni + 0043)*nAC, aDados[nX, 49], oFont04)
		oPrint:Say((nLinIni + 1442  + nLinA4)*nAL, (nColIni + 0090)*nAC, "A-Aguda"+"    "+"C-Crônica", oFont01) //"A-Aguda"###"C-Crônica"
		oPrint:Box((nLinIni + 1397)*nAL  + nLinA4, (nColIni + 0320)*nAC, (nLinIni + 1491)*nAL + nLinA4, (nColIni + 0770)*nAC)
		oPrint:Say((nLinIni + 1402  + nLinA4)*nAL, (nColIni + 0330)*nAC, "50 - "+"Tempo de Doença", oFont01) //"Tempo de Doença"
		oPrint:Line((nLinIni + 1427)*nAL + nLinA4, (nColIni + 0340)*nAC, (nLinIni + 1477)*nAL + nLinA4, (nColIni + 0340)*nAC)
		oPrint:Line((nLinIni + 1477)*nAL + nLinA4, (nColIni + 0340)*nAC, (nLinIni + 1477)*nAL + nLinA4, (nColIni + 0426)*nAC)
		oPrint:Line((nLinIni + 1427)*nAL + nLinA4, (nColIni + 0426)*nAC, (nLinIni + 1477)*nAL + nLinA4, (nColIni + 0426)*nAC)
		If aDados[nX,50,1] > 0
			oPrint:Say((nLinIni + 1432 + nLinA4)*nAL, (nColIni + 0353)*nAC, IIF((StrZero(aDados[nX, 50,1], 2, 0))=="00","",(StrZero(aDados[nX, 50,1], 2, 0))), oFont04)
		Endif
		oPrint:Say((nLinIni + 1442 + nLinA4)*nAL, (nColIni + 0434)*nAC, "-", oFont01)
		oPrint:Line((nLinIni+ 1427)*nAL + nLinA4, (nColIni + 0447)*nAC, (nLinIni + 1477)*nAL + nLinA4, (nColIni + 0447)*nAC)
		oPrint:Line((nLinIni+ 1477)*nAL + nLinA4, (nColIni + 0447)*nAC, (nLinIni + 1477)*nAL + nLinA4, (nColIni + 0494)*nAC)
		oPrint:Line((nLinIni+ 1427)*nAL + nLinA4, (nColIni + 0494)*nAC, (nLinIni + 1477)*nAL + nLinA4, (nColIni + 0494)*nAC)
		oPrint:Say((nLinIni + 1432 + nLinA4)*nAL, (nColIni + 0457)*nAC, aDados[nX, 50,2], oFont04)
		oPrint:Say((nLinIni + 1442 + nLinA4)*nAL, (nColIni + 0510)*nAC, "A-Anos"+"  "+"M-Meses"+"  "+"D-Dias", oFont01) //"A-Anos"###"M-Meses"###"D-Dias"

		oPrint:Say((nLinIni + 1478 + nLinA4)*nAL, (nColIni + 0010)*nAC, "Procedimentos e Exames realizados", oFont01) //"Procedimentos e Exames realizados"
		oPrint:Box((nLinIni + 1526)*nAL + nLinA4, (nColIni + 0010)*nAC, (nLinIni + 1766)*nAL + nLinA4, (nColIni + 3745 + nColA4)*nAC)
		oPrint:Say((nLinIni + 1531 + nLinA4)*nAL, (nColIni + 0020)*nAC, "51 - "+"Data", oFont01) //"Data"
		oPrint:Say((nLinIni + 1531 + nLinA4)*nAL, (nColIni + 0210)*nAC, "52 - "+"Hora Inicial", oFont01) //"Hora Inicial"
		oPrint:Say((nLinIni + 1531 + nLinA4)*nAL, (nColIni + 0380)*nAC, "53 - "+"Hora Final", oFont01) //"Hora Final"
		oPrint:Say((nLinIni + 1531 + nLinA4)*nAL, (nColIni + 0540)*nAC, "54 - "+"Tabela", oFont01) //"Tabela"
		oPrint:Say((nLinIni + 1531 + nLinA4)*nAL, (nColIni + 0660)*nAC, "55 - "+"Código do Procedimento", oFont01) //"Código do Procedimento"
		oPrint:Say((nLinIni + 1531 + nLinA4)*nAL, (nColIni + 0940)*nAC, "56 - "+"Descrição", oFont01) //"Descrição"
		oPrint:Say((nLinIni + 1531 + nLinA4)*nAL, (nColIni + 3675)*nAC + nColA4, "57 - "+"Qtde.", oFont01,,,,1) //"Qtde."
		oPrint:Say((nLinIni + 1531 + nLinA4)*nAL, (nColIni + 3795)*nAC + nColA4, "58 - "+"Via", oFont01) //"Via"
		oPrint:Say((nLinIni + 1531 + nLinA4)*nAL, (nColIni + 4040)*nAC + nColA4, "59 - "+"Tec.", oFont01) //"Tec."
		oPrint:Say((nLinIni + 1531 + nLinA4)*nAL, (nColIni + 4260)*nAC + nColA4, "60 - "+"% Red./Acresc.", oFont01,,,,1) //"% Red./Acresc."
		oPrint:Say((nLinIni + 1531 + nLinA4)*nAL, (nColIni + 4500)*nAC + nColA4, "61 - "+"Valor Unitário - R$", oFont01,,,,1) //"Valor Unitário - R$"
		oPrint:Say((nLinIni + 1531 + nLinA4)*nAL, (nColIni + 4745)*nAC + nColA4, "62 - "+"Valor Total - R$", oFont01,,,,1) //"Valor Total - R$"

		nOldLinIni := nLinIni

		if nVolta=1
			nV1:=1
		Endif

		If ExistBlock("PLSGTISS")
			lImpPrc := ExecBlock("PLSGTISS",.F.,.F.,{"02",lImpPrc})
		EndIf

		If lImpPrc

			For nP1 := nV1 To nT1
				if nVolta <> 1
					nN:=nP1-((5*nVolta)-5)
					oPrint:Say((nLinIni + 1566 + nLinA4)*nAL, (nColIni + 0020)*nAC, AllTrim(Str(nN)) + " - ", oFont01)
				else
					oPrint:Say((nLinIni + 1566 + nLinA4)*nAL, (nColIni + 0020)*nAC, AllTrim(Str(nP1)) + " - ", oFont01)
				endif
					oPrint:Say((nLinIni + 1561 + nLinA4)*nAL, (nColIni + 0065)*nAC, IIf(Empty(aDados[nX, 51, nP1]), "", DtoC(aDados[nX, 51, nP1])), oFont04)
				oPrint:Say((nLinIni + 1561 + nLinA4)*nAL, (nColIni + 0210)*nAC, IIf(Empty(aDados[nX, 52, nP1]), "", Transform(aDados[nX, 52, nP1], "@R 99:99")), oFont04)
			 	oPrint:Say((nLinIni + 1561 + nLinA4)*nAL, (nColIni + 0380)*nAC, IIf(Empty(aDados[nX, 53, nP1]), "", Transform(aDados[nX, 53, nP1], "@R 99:99")), oFont04)
				oPrint:Say((nLinIni + 1561 + nLinA4)*nAL, (nColIni + 0540)*nAC, aDados[nX, 54, nP1], oFont04)
				oPrint:Say((nLinIni + 1561 + nLinA4)*nAL, (nColIni + 0660)*nAC, aDados[nX, 55, nP1], oFont04)
				oPrint:Say((nLinIni + 1561 + nLinA4)*nAL, (nColIni + 0940)*nAC, SUBSTR(aDados[nX, 56, nP1],1,51), oFont04)
				oPrint:Say((nLinIni + 1561 + nLinA4)*nAL, (nColIni + 2445 + nColA4)*nAC, IIf(Empty(aDados[nX, 57, nP1]), "", Transform(aDados[nX, 57, nP1], "@E 9999.99")), oFont04,,,,1)
				oPrint:Say((nLinIni + 1561 + nLinA4)*nAL, (nColIni + 2560 + nColA4)*nAC, aDados[nX, 58, nP1], oFont04)
				oPrint:Say((nLinIni + 1561 + nLinA4)*nAL, (nColIni + 2840 + nColA4)*nAC, aDados[nX, 59, nP1], oFont04)
				oPrint:Say((nLinIni + 1561 + nLinA4)*nAL, (nColIni + 3050 + nColA4)*nAC, IIf(Empty(aDados[nX, 60, nP1]), "", Transform(aDados[nX, 60, nP1], "@E 9999.99")), oFont04,,,,1)
				oPrint:Say((nLinIni + 1561 + nLinA4)*nAL, (nColIni + 3240 + nColA4)*nAC, IIf(Empty(aDados[nX, 61, nP1]), "", Transform(aDados[nX, 61, nP1], "@E 99,999,999.99")), oFont04,,,,1)
				oPrint:Say((nLinIni + 1561 + nLinA4)*nAL, (nColIni + 3510 + nColA4)*nAC, IIf(Empty(aDados[nX, 62, nP1]), "", Transform(aDados[nX, 62, nP1], "@E 99,999,999.99")), oFont04,,,,1)
				nLinIni += 40
			Next nP1

		EndIf

		if nT1 < Len(aDados[nX, 55]).or. lImpnovo
			  nV1:=nP1
			  lImpnovo:=.T.
		Endif

		nLinIni := nOldLinIni

		oPrint:Box((nLinIni + 1771)*nAL + nLinA4, (nColIni + 0010)*nAC, (nLinIni + 1971)*nAL + (2*nLinA4), (nColIni + 3745 + nColA4)*nAC)
		oPrint:Say((nLinIni + 1766 + nLinA4)*nAL, (nColIni + 0020)*nAC, "63 - "+"Data e Assinatura de Procedimentos em Série", oFont01) //"Data e Assinatura de Procedimentos em Série"

		nOldColIni := nColIni

		if nVolta=1
			nV2:=1
		Endif

		For nP2 := nV2 To nT2 Step 2
			if nVolta <> 1
				nN:=nP2-((10*nVolta)-10)
				oPrint:Say((nLinIni + 1816 + nLinA4)*nAL, (nColIni + 0030)*nAC, AllTrim(Str(nN)) + " - ", oFont01)
			Else
				oPrint:Say((nLinIni + 1816 + nLinA4)*nAL, (nColIni + 0030)*nAC, AllTrim(Str(nP2)) + " - ", oFont01)
			Endif
			oPrint:Say((nLinIni + 1816 + nLinA4)*nAL, (nColIni + 0070)*nAC, DtoC(aDados[nX, 63, nP2]), oFont04)
			oPrint:Line((nLinIni + 1861)*nAL + nLinA4,(nColIni + 0230)*nAC, (nLinIni + 1861)*nAL + nLinA4, (nColIni + 0757 + nColSoma2)*nAC)
			if nLayout ==1
				nColIni += 727
			Elseif nLayout ==2
				nColIni += 670
			Else
				nColIni += 630
			Endif
		Next nP2

		nColIni := nOldColIni

		nOldColIni := nColIni

		if nVolta=1
			nV2:=1
		Endif

		For nP2 := nV2+1 To nT2+1 Step 2
			if nVolta <> 1
				nN:=nP2-((10*nVolta)-10)
				oPrint:Say((nLinIni + 1890 + (2*nLinA4))*nAL, (nColIni + 0030)*nAC, AllTrim(Str(nN)) + " - ", oFont01)
			Else
				oPrint:Say((nLinIni + 1890 + (2*nLinA4))*nAL, (nColIni + 0030)*nAC, AllTrim(Str(nP2)) + " - ", oFont01)
			Endif
			oPrint:Say((nLinIni + 1890 + (2*nLinA4))*nAL, (nColIni + 0070)*nAC, DtoC(aDados[nX, 63, nP2]), oFont04)
			oPrint:Line((nLinIni + 1945)*nAL + (2*nLinA4),(nColIni + 0230)*nAC, (nLinIni + 1945)*nAL + (2*nLinA4), (nColIni + 0757 + nColSoma2)*nAC)
			if nLayout ==1
				nColIni += 727
			Elseif nLayout ==2
				nColIni += 670
			Else
				nColIni += 630
			Endif
		Next nP2

		nColIni := nOldColIni

	    if nT2 < Len(aDados[nX, 63]).or. lImpnovo
			  nV2:=nP2-1
			  lImpnovo:=.T.
		Endif

		oPrint:Box((nLinIni + 1976)*nAL + (2*nLinA4), (nColIni + 0010)*nAC, (nLinIni + 2136)*nAL + (3*nLinA4), (nColIni + 3745 + nColA4)*nAC)
		oPrint:Say((nLinIni + 1950 + (2*nLinA4))*nAL, (nColIni + 0020)*nAC, "64 - "+"Observação", oFont01) //"Observação"

		If nModulo == 51    //Gestão Hospitalar
			if nVolta=1
				nV1:=1
			Endif

			nLin := 1988
			For nP1 := nV1 To nT1
				if nVolta <> 1
					nN:=nP1-((5*nVolta)-5)
					oPrint:Say((nLinIni + nLin + nLinA4)*nAL, (nColIni + 0020)*nAC, AllTrim(Str(nN)) + " - ", oFont01)
				else
					oPrint:Say((nLinIni + nLin + nLinA4)*nAL, (nColIni + 0020)*nAC, AllTrim(Str(nP1)) + " - ", oFont01)
				endif
				oPrint:Say((nLinIni + nLin + nLinA4)*nAL, (nColIni + 0065)*nAC, aDados[nX, 64, nP1], oFont04)

				nLin += 35
			Next nP1

			if nT1 < Len(aDados[nX, 64]).or. lImpnovo
				  nV1:=nP1
				  lImpnovo:=.T.
			Endif
		Else
			nLin := 1991

		cOper := substr(aDados[nX, 2],1,4)
		cAno  := substr(aDados[nX, 2],6,4)
		cMes  := substr(aDados[nX, 2],11,2)
		cAut  := substr(aDados[nX, 2],14,8)

		//Realizo a consulta na BEA
		DbSelectArea("BEA")
		BEA->(dbSetOrder(1))
		BEA->(DbSeek(xFilial("BEA")+cOper+cAno+cMes+cAut))

		//acrescento na posição da observação o resultado da busca, pois estava vindo errado
			//Correção TISS 2.02.03
			If !Empty(cTissVer) .AND. cTissVer >= "3"
				aDados[nX, 58] := BEA->BEA_MSG01 + BEA->BEA_MSG02 + BEA->BEA_MSG03
			EndIf



			For nI := 1 To MlCount(aDados[nX, 64])
				cObs := MemoLine(aDados[nX, 64], 250, nI)
				If cObs == ""
					exit
				Endif
				oPrint:Say((nLinIni + nLin + (2*nLinA4))*nAL, (nColIni + 0030)*nAC, LOWERACE(cObs), oFont05)
				nLin += 20 //dennis
			Next nI

		Endif
		oPrint:Box((nLinIni + 2141)*nAL + (3*nLinA4), (nColIni + 0010)*nAC			 		, (nLinIni + 2235)*nAL + (3*nLinA4), (nColIni + 0591 + (nColA4/7) )*nAC)
		oPrint:Say((nLinIni + 2159)*nAL + (3*nLinA4), (nColIni + 0020)*nAC				 	, "65 - "+"Total Procedimentos R$", oFont01) //"Total Procedimentos R$"
		oPrint:Say((nLinIni + 2210)*nAL + (3*nLinA4), (nColIni + 0220 + (nColA4/6))*nAC 	, Transform(aDados[nX, 65,nProx], "@E 999,999,999.99"), oFont04,,,,1)
		oPrint:Box((nLinIni + 2141)*nAL + (3*nLinA4), (nColIni + 0596 + (nColA4/7))*nAC	, (nLinIni + 2235)*nAL + (3*nLinA4), (nColIni + 1117 + 2*(nColA4/7))*nAC)
		oPrint:Say((nLinIni + 2159)*nAL + (3*nLinA4), (nColIni + 0606 + (nColA4/7))*nAC	, "66 - "+"Total Taxas e Aluguéis R$", oFont01) //"Total Taxas e Aluguéis R$"
		oPrint:Say((nLinIni + 2210)*nAL + (3*nLinA4), (nColIni + 0806 + 2*(nColA4/6))*nAC	, Transform(aDados[nX, 66,nProx], "@E 999,999,999.99"), oFont04,,,,1)
		oPrint:Box((nLinIni + 2141)*nAL + (3*nLinA4), (nColIni + 1122 + 2*(nColA4/7))*nAC	, (nLinIni + 2235)*nAL + (3*nLinA4), (nColIni + 1643  + 3*(nColA4/7))*nAC)
		oPrint:Say((nLinIni + 2159)*nAL + (3*nLinA4), (nColIni + 1132 + 2*(nColA4/7))*nAC	, "67 - "+"Total Materiais R$", oFont01) //"Total Materiais R$"
		oPrint:Say((nLinIni + 2210)*nAL + (3*nLinA4), (nColIni + 1332 + 3*(nColA4/6))*nAC	, Transform(aDados[nX, 67,nProx], "@E 999,999,999.99"), oFont04,,,,1)
		oPrint:Box((nLinIni + 2141)*nAL + (3*nLinA4), (nColIni + 1648 + 3*(nColA4/7))*nAC	, (nLinIni + 2235)*nAL + (3*nLinA4), (nColIni + 2169 + 4*(nColA4/7) )*nAC)
		oPrint:Say((nLinIni + 2159)*nAL + (3*nLinA4), (nColIni + 1658 + 3*(nColA4/7))*nAC	, "68 - "+"Total Medicamentos R$", oFont01) //"Total Medicamentos R$"
		oPrint:Say((nLinIni + 2210)*nAL + (3*nLinA4), (nColIni + 1858 + 4*(nColA4/6))*nAC	, Transform(aDados[nX, 68,nProx], "@E 999,999,999.99"), oFont04,,,,1)
		oPrint:Box((nLinIni + 2141)*nAL + (3*nLinA4), (nColIni + 2174 + 4*(nColA4/7))*nAC	, (nLinIni + 2235)*nAL + (3*nLinA4), (nColIni + 2695 + 5*(nColA4/7) )*nAC)
		oPrint:Say((nLinIni + 2159)*nAL + (3*nLinA4), (nColIni + 2184 + 4*(nColA4/7))*nAC	, "69 - "+"Total Diárias R$", oFont01) //"Total Diárias R$"
		oPrint:Say((nLinIni + 2210)*nAL + (3*nLinA4), (nColIni + 2384 + 5*(nColA4/6))*nAC	, Transform(aDados[nX, 69,nProx], "@E 999,999,999.99"), oFont04,,,,1)
		oPrint:Box((nLinIni + 2141)*nAL + (3*nLinA4), (nColIni + 2700 + 5*(nColA4/7))*nAC	, (nLinIni + 2235)*nAL + (3*nLinA4), (nColIni + 3221 + 6*(nColA4/7) )*nAC)
		oPrint:Say((nLinIni + 2159)*nAL + (3*nLinA4), (nColIni + 2710 + 5*(nColA4/7))*nAC	, "70 - "+"Total Gases Medicinais R$", oFont01) //"Total Gases Medicinais R$"
		oPrint:Say((nLinIni + 2210)*nAL + (3*nLinA4), (nColIni + 2910 + 6*(nColA4/6))*nAC	, Transform(aDados[nX, 70,nProx], "@E 999,999,999.99"), oFont04,,,,1)
		oPrint:Box((nLinIni + 2141)*nAL + (3*nLinA4), (nColIni + 3226 + 6*(nColA4/7))*nAC	, (nLinIni + 2235)*nAL + (3*nLinA4), (nColIni + 3745  + 7*(nColA4/7))*nAC)
		oPrint:Say((nLinIni + 2159)*nAL + (3*nLinA4), (nColIni + 3236 + 6*(nColA4/7))*nAC	, "71 - "+"Total Geral da Guia R$", oFont01) //"Total Geral da Guia R$"
		oPrint:Say((nLinIni + 2210)*nAL + (3*nLinA4), (nColIni + 3436 + 7*(nColA4/6))*nAC	, Transform(aDados[nX, 71,nProx], "@E 999,999,999.99"), oFont04,,,,1)


		oPrint:Box((nLinIni + 2240)*nAL + (3*nLinA4), (nColIni + 0010)*nAC					, (nLinIni + 2385)*nAL + (4*nLinA4), (nColIni + 0986 + (nColA4/4) )*nAC)
	   	oPrint:Say((nLinIni + 2185 + (4*nLinA4))*nAL, (nColIni + 0020)*nAC 				, "86 - "+"Data e Assinatura do Solicitante", oFont01) //"Data e Assinatura do Solicitante"
		oPrint:Say((nLinIni + 2225 + (4*nLinA4))*nAL, (nColIni + 0030)*nAC 				, DtoC(aDados[nX, 86]), oFont04)
		oPrint:Box((nLinIni + 2240)*nAL + (3*nLinA4), (nColIni + 0991  +(nColA4/4))*nAC	, (nLinIni + 2385)*nAL + (4*nLinA4), (nColIni + 1907 + 2*(nColA4/4) )*nAC)
		oPrint:Say((nLinIni + 2185 + (4*nLinA4))*nAL, (nColIni + 1001  +(nColA4/4))*nAC	, "87 - "+"Data e Assinatura do Responsável pela Autorização", oFont01) //"Data e Assinatura do Responsável pela Autorização"
		oPrint:Say((nLinIni + 2225 + (4*nLinA4))*nAL, (nColIni + 1011  +(nColA4/4))*nAC	, DtoC(aDados[nX, 87]), oFont04)
		oPrint:Box((nLinIni + 2240)*nAL + (3*nLinA4), (nColIni + 1912  +2*(nColA4/4))*nAC	, (nLinIni + 2385)*nAL + (4*nLinA4), (nColIni + 2828 + 3*(nColA4/4) )*nAC)
		oPrint:Say((nLinIni + 2185 + (4*nLinA4))*nAL, (nColIni + 1922  +2*(nColA4/4))*nAC	, "88 - "+"Data e Assinatura do Beneficiário ou Responsável", oFont01) //"Data e Assinatura do Beneficiário ou Responsável"
		oPrint:Say((nLinIni + 2225 + (4*nLinA4))*nAL, (nColIni + 1932  +2*(nColA4/4))*nAC	, DtoC(aDados[nX, 88]), oFont04)
		oPrint:Box((nLinIni + 2240)*nAL + (3*nLinA4), (nColIni + 2833  +3*(nColA4/4))*nAC	, (nLinIni + 2385)*nAL + (4*nLinA4), (nColIni + 3745 + 4*(nColA4/4) )*nAC)
		oPrint:Say((nLinIni + 2185 + (4*nLinA4))*nAL, (nColIni + 2843  +3*(nColA4/4))*nAC	, "89 - "+"Data e Assinatura do Prestador Executante", oFont01) //"Data e Assinatura do Prestador Executante"
		oPrint:Say((nLinIni + 2225 + (4*nLinA4))*nAL, (nColIni + 2853  +3*(nColA4/4))*nAC	, DtoC(aDados[nX, 89]), oFont04)

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
		//³Finaliza a pagina
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
		oPrint:EndPage()
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
		//³Verso da Guia - Inicia uma nova pagina
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
		oPrint:StartPage()
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Box Principal                                                 ?
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		oPrint:Box((nLinIni + 0000)*nAL, (nColIni + 0000)*nAC, (nLinIni + nLinMax)*nAL, (nColIni + nColMax)*nAC)

		oPrint:Box((nLinIni + 0010)*nAL, (nColIni + 0010)*nAC			, (nLinIni + 0490)*nAL, (nColIni + 3745 + nColA4)*nAC)
		oPrint:Say((nLinIni + 0030)*nAL, (nColIni + 0020)*nAC			, "OPM Solicitados", oFont01) //"OPM Solicitados"
		oPrint:Say((nLinIni + 0065)*nAL, (nColIni + 0020)*nAC			, "72 - "+"Tabela", oFont01) //"Tabela"
		oPrint:Say((nLinIni + 0065)*nAL, (nColIni + 0160)*nAC			, "73 - "+"Código do OPM", oFont01) //"Código do OPM"
		oPrint:Say((nLinIni + 0065)*nAL, (nColIni + 0410)*nAC		 	, "74 - "+"Descrição OPM", oFont01) //"Descrição OPM"
		oPrint:Say((nLinIni + 0065)*nAL, (nColIni + 2400 + nColA4)*nAC	, "75 - "+"Qtde.", oFont01,,,,1) //"Qtde."
		oPrint:Say((nLinIni + 0065)*nAL, (nColIni + 2550 + nColA4)*nAC	, "76 - "+"Fabricante", oFont01) //"Fabricante"
		oPrint:Say((nLinIni + 0065)*nAL, (nColIni + 3530 + nColA4)*nAC	, "77 - "+"Valor Unitário - R$", oFont01,,,,1) //"Valor Unitário - R$"

		nOldLinIni := nLinIni

		if nVolta=1
			nV3:=1
		Endif

		For nP3 := nV3 To nT3
			if nVolta <> 1
				nN:=nP3-((9*nVolta)-9)
				oPrint:Say((nLinIni + 0100)*nAL, (nColIni + 0020)*nAC, AllTrim(Str(nN)) + " - ", oFont01)
			Else
				oPrint:Say((nLinIni + 0100)*nAL, (nColIni + 0020)*nAC, AllTrim(Str(nP3)) + " - ", oFont01)
			Endif
			oPrint:Say((nLinIni + 0100)*nAL, (nColIni + 0065)*nAC			, aDados[nX, 72, nP3], oFont04)
			oPrint:Say((nLinIni + 0100)*nAL, (nColIni + 0160)*nAC			, aDados[nX, 73, nP3], oFont04)
			oPrint:Say((nLinIni + 0100)*nAL, (nColIni + 0410)*nAC			, aDados[nX, 74, nP3], oFont04)
			oPrint:Say((nLinIni + 0100)*nAL, (nColIni + 2400 + nColA4)*nAC	, IIf(Empty(aDados[nX, 75, nP3]), "", Transform(aDados[nX, 75, nP3], "@E 9999.99")), oFont04,,,,1)
			oPrint:Say((nLinIni + 0100)*nAL, (nColIni + 2550 + nColA4)*nAC	, aDados[nX, 76, nP3], oFont04)
			oPrint:Say((nLinIni + 0100)*nAL, (nColIni + 3550 + nColA4)*nAC	, IIf(Empty(aDados[nX, 77, nP3]), "", Transform(aDados[nX, 77, nP3], "@E 999,999,999.99")), oFont04,,,,1)
			nLinIni += 40
		Next nP3

		nLinIni := nOldLinIni

	    if nT3 < Len(aDados[nX, 73]).or. lImpnovo
			  nV3:=nP3
			  lImpnovo:=.T.
		Endif

		oPrint:Box((nLinIni + 0495)*nAL, (nColIni + 0010)*nAC			, (nLinIni + 0990)*nAL, (nColIni + 3745 + nColA4)*nAC)
		oPrint:Say((nLinIni + 0515)*nAL, (nColIni + 0020)*nAC			, "OPM Utilizados", oFont01) //"OPM Utilizados"
		oPrint:Say((nLinIni + 0550)*nAL, (nColIni + 0020)*nAC			, "78 - "+"Tabela", oFont01) //"Tabela"
		oPrint:Say((nLinIni + 0550)*nAL, (nColIni + 0160)*nAC			, "79 - "+"Código do OPM", oFont01) //"Código do OPM"
		oPrint:Say((nLinIni + 0550)*nAL, (nColIni + 0410)*nAC			, "80 - "+"Descrição OPM", oFont01) //"Descrição OPM"
		oPrint:Say((nLinIni + 0550)*nAL, (nColIni + 2400 + nColA4)*nAC	, "81 - "+"Qtde.", oFont01,,,,1) //"Qtde."
		oPrint:Say((nLinIni + 0550)*nAL, (nColIni + 2550 + nColA4)*nAC	, "82 - "+"Código de Barras", oFont01) //"Código de Barras"
		oPrint:Say((nLinIni + 0550)*nAL, (nColIni + 3250 + nColA4)*nAC	, "83 - "+"Valor Unitário - R$", oFont01,,,,1) //"Valor Unitário - R$"
		oPrint:Say((nLinIni + 0550)*nAL, (nColIni + 3560 + nColA4)*nAC	, "84 - "+"Valor Total - R$", oFont01,,,,1) //"Valor Total - R$"

		nOldLinIni := nLinIni

		if nVolta=1
			nV4:=1
		Endif

		For nP4 := nV4 To nT4
			if nVolta <> 1
				nN:=nP4-((9*nVolta)-9)
				oPrint:Say((nLinIni + 0585)*nAL, (nColIni + 0020)*nAC, AllTrim(Str(nN)) + " - ", oFont01)
			Else
				oPrint:Say((nLinIni + 0585)*nAL, (nColIni + 0020)*nAC, AllTrim(Str(nP4)) + " - ", oFont01)
			Endif
			oPrint:Say((nLinIni + 0585)*nAL, (nColIni + 0065)*nAC			, aDados[nX, 78, nP4], oFont04)
			oPrint:Say((nLinIni + 0585)*nAL, (nColIni + 0160)*nAC			, aDados[nX, 79, nP4], oFont04)
			oPrint:Say((nLinIni + 0585)*nAL, (nColIni + 0410)*nAC			, aDados[nX, 80, nP4], oFont04)
			oPrint:Say((nLinIni + 0585)*nAL, (nColIni + 2400 + nColA4)*nAC	, IIf(Empty(aDados[nX, 81, nP4]), "", Transform(aDados[nX, 81, nP4], "@E 9999.99")), oFont04,,,,1)
			oPrint:Say((nLinIni + 0585)*nAL, (nColIni + 2550 + nColA4)*nAC	, aDados[nX, 82, nP4], oFont04)
			oPrint:Say((nLinIni + 0585)*nAL, (nColIni + 3260 + nColA4)*nAC	, IIf(Empty(aDados[nX, 83, nP4]), "", Transform(aDados[nX, 83, nP4], "@E 999,999,999.99")), oFont04,,,,1)
			oPrint:Say((nLinIni + 0585)*nAL, (nColIni + 3540 + nColA4)*nAC	, IIf(Empty(aDados[nX, 84, nP4]), "", Transform(aDados[nX, 84, nP4], "@E 999,999,999.99")), oFont04,,,,1)
			nLinIni += 40
		Next nP4

		nLinIni := nOldLinIni

	    nTotOPM:=nV4

	    if nT4 < Len(aDados[nX, 79]).or. lImpnovo
			  nV4:=nP4
			  lImpnovo:=.T.
		Endif

		oPrint:Box((nLinIni + 1005)*nAL, (nColIni + 3395 + nColA4)*nAC, (nLinIni + 1089)*nAL, (nColIni + 3745 + nColA4)*nAC)
		oPrint:Say((nLinIni + 1025)*nAL, (nColIni + 3405 + nColA4)*nAC, "85 - "+"Total OPM R$", oFont01) //"Total OPM R$"
		oPrint:Say((nLinIni + 1055)*nAL, (nColIni + 3555 + nColA4)*nAC, Transform(aDados[nX, 85,nProx], "@E 999,999,999.99"), oFont04,,,,1)
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
		//³Finaliza a pagina
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
	   	oPrint:EndPage()

	Next nX
EndDo

If lGerTXT .And. !lWeb
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
	//³Imprime Relatorio
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
	oPrint:Print()
Else
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
	//³Visualiza impressao grafica antes de imprimir
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
	oPrint:Print()
EndIf

Return(cFileName)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡ao    ?PLSSADT1  ?Autor ?Luciano Aparecido     ?Data ?08.01.07 ³±?
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡ao ?Estrutura Relatório TISS (Guia de Serv/SADT ) - BOPS 095189
±±             Impressão apenas da primeira pagina guia sadt
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±?Uso      ?SigaPLS                                                     ³±?
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros?aDados - Array com as informações do relat´rio              ³±?
±±?         ?lGerTXT - Define se imprime direto sem passar pela tela	  ³±?
±±?         ?		 de configuracao/preview do relatorio 		         ³±?
±±?         ?nLayout - Define o formato de papél para impressao:         ³±?
±±?         ?          1 - Formato Ofício II (216x330mm)                 ³±?
±±?         ?          2 - Formato A4 (210x297mm)                        ³±?
±±?         ? 		 3 - Formato Carta (216x279mm)     			        ³±?
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function CABSADT1(aDados, lGerTXT, nLayout, cLogoGH, lWeb, cPathRelW)

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
Local nOldColIni
Local nI, nJ, nX, nN
Local nV, nV1, nV2
Local cObs
Local oFont01
Local oFont02n
Local oFont03n
Local oFont04
Local oPrint    := Nil
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

DEFAULT lGerTXT 	:= .F.
DEFAULT nLayout 	:= 2
DEFAULT cLogoGH 	:= ""
DEFAULT lWeb		:= .F.
DEFAULT cPathRelW 	:= ""
DEFAULT aDados 	:= { {;
					"123456",;
					"12345678901234567892",;
					"12345678901234567892",;
					CtoD("01/01/07"),;
					"12345678901234567892",;
					CtoD("01/01/07"),;
					CtoD("01/01/07"),;
					"12345678901234567892",;
					Replicate("M",20),;
					CtoD("12/12/07"),;
					Replicate("M",70),;
					"123456789102345",;
					"14.141.114/00001-35",;
					Replicate("M",70),;
					"1234567",;
					Replicate("M",70),;
					"1234567",;
					"123456789102345",;
					"ES",;
					"12345",;
					{ CtoD("12/12/07"), "2210" },;
					"E",;
					"12345",;
					Replicate("M",70),;
					{ "10", "20", "30", "40", "50" } ,;
					{ "1234567890", "2345678901", "3456789012", "4567890123", "5678901234" },;
					{ Replicate("M",60),Replicate("B",60),Replicate("C",60),Replicate("D",60),Replicate("E",60) },;
					{ 111,111,11,1,1 },;
					{ 999,999,99,9,9 },;
					"14.141.114/00001-35",;
					Replicate("M",70),;
					"999",;
					Replicate("M",40),;
					"MMMMM",;
					Replicate("M",15),;
					Replicate("M",40),;
					"MM",;
					"1234567",;
					"12345-678",;
					{ "1234567", "27.456.658/0001-35" },;
					Replicate("M",70),;
					"1234567",;
					"123456789102345",;
					"MM",;
					{ "12345", "01" },;
					"01",;
					"1",;
					"1",;
					"1",;
					{ 12,"M" },;
					{ CtoD("01/01/07"),CtoD("01/02/07"),CtoD("01/03/07"),CtoD("01/04/07"),CtoD("01/05/07")},;
					{ "0107","0207","0307","0407","0507" },;
					{ "0607","0707","0807","0907","1007" },;
					{ "MM","AA","BB","CC","DD"},;
					{ "1234567890","2345678901","3456789012","4567890123","5678901234"},;
					{ Replicate("M",60),Replicate("B",60),Replicate("C",60),Replicate("D",60),Replicate("E",60)},;
					{ 12,1,2,3,4},;
					{ "M","A","B","C","D"},;
					{ "M","E","F","G","H"},;
					{ 111.00,222.00,333.00,444.00,999.99 },;
					{ 99999999.99,22222.22,33333.33,44444.44,11111.11 },;
					{ 11111111.11,55555.00,66666.00,77777.00,88888.00 },;
					{ CtoD("01/01/07"),CtoD("02/01/07"),CtoD("03/01/07"),CtoD("04/01/07"),CtoD("05/01/07"),CtoD("06/01/07"),CtoD("07/01/07"),CtoD("08/01/07"),CtoD("09/01/07"),CtoD("10/01/07")},;
					Replicate("M", 240),;
					{1333333.22},;
					{2333333.22},;
					{3333333.22},;
					{4333333.22},;
					{5333333.22},;
					{6333333.22},;
					{73333333.22},;
					{ "11", "22", "33", "44", "55", "66", "77", "88", "99" },;
					{ "1234567890", "2345678901", "3456789012", "4567890123", "5678901234", "6789012345", "7890123456", "8901234567", "9012345678" },;
					{ Replicate ("M", 60), Replicate ("A", 60), Replicate ("B", 60), Replicate ("C", 60), Replicate ("D", 60), Replicate ("E", 60), Replicate ("F", 60), Replicate ("G", 60), Replicate ("H", 60) },;
					{ 01, 1, 2, 03, 04, 05, 06, 7, 99 }, ;
					{ Replicate ("I", 40), Replicate ("J", 40), Replicate ("K", 40), Replicate ("L", 40), Replicate ("M", 40), Replicate ("N", 40), Replicate ("O", 40), Replicate ("P", 40), Replicate ("Q", 40) },;
					{ 999999.99, 111111.99, 222229.99, 333999.99, 444449.99, 555559.99, 666669,99, 777779.99, 888899.99 },;
					{ "11", "12", "13", "14", "15", "16", "17", "18", "19" },;
					{ "1234567890", "2345678901", "3456789012", "4567890123", "5678901234", "6789012345", "7890123456", "8901234567", "9012345678" },;
					{ Replicate ("A", 60), Replicate ("B", 60), Replicate ("C", 60), Replicate ("D", 60), Replicate ("E", 60), Replicate ("F", 60), Replicate ("G", 60), Replicate ("H", 60), Replicate ("I", 60) },;
					{ 01, 2, 3, 04, 05, 06, 07, 8, 99 }, ;
					{ Replicate ("J", 20), Replicate ("K", 20), Replicate ("L", 20), Replicate ("M", 20), Replicate ("N", 20), Replicate ("O", 20), Replicate ("P", 20), Replicate ("Q", 20), Replicate ("R", 20) },;
					{ 199999.99, 299999.99, 399999.99, 499999.99, 599999.99, 699999.99, 799.99, 899999.99, 99.99 },;
					{ 399999999.99, 499999999.99, 599999999.99, 699999.99, 799999.99, 899999.99, 99.99, 09.99, 19.99 },;
					{1999999.99},;
					CtoD("01/01/07"),;
					CtoD("02/01/07"),;
					CtoD("03/01/07"),;
					CtoD("04/01/07") } }

oFont01	:= TFont():New("Arial",  5,  5, , .F., , , , .T., .F.) // Normal

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
//?Nao permite acionar a impressao quando for na web.
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
If lWeb
	cPathSrvJ := cPathRelW
	cFileName := cRel+lower(CriaTrab(NIL,.F.))+".pdf"
Else
	cFileName := cRel+CriaTrab(NIL,.F.)
EndIf

//						New ( < cFilePrintert >, [ nDevice], [ lAdjustToLegacy], [ cPathInServer], [ lDisabeSetup ], [ lTReport], [ @oPrintSetup], [ cPrinter], [ lServer], [ lPDFAsPNG], [ lRaw], [ lViewPDF] )
if !lWeb
	oPrint := FWMSPrinter():New ( cFileName			,			,	.F.				,cPathSrvJ	 	,	.T.				,			 ,				,			  ,			  ,	.F.			, 		, 				)
else
	oPrint := FWMSPrinter():New ( cFileName	,,.F.,cPathSrvJ	 ,.T.,	,@oPrint,			  ,			  ,	.F.			,.f.)
	If lSrvUnix
		AjusPath(@oPrint)
	EndIf
Endif
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
//³Tratamento para impressao via job
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
//oPrint:lInJob  := lWeb
oPrint:lServer := lWeb
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
//?Caminho do arquivo
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
oPrint:cPathPDF := cPathSrvJ

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
//³Modo paisagem
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
oPrint:SetLandscape()

if nLayout ==2
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
	//³Papél A4
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
	oPrint:SetPaperSize(9)
Elseif nLayout ==3
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
	//³Papél Carta
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
	oPrint:SetPaperSize(1)
Else
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
	//³Papel Oficio2 216 x 330mm / 8 1/2 x 13in
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
	oPrint:SetPaperSize(14)
Endif
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
//³Device
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
If lWeb
	oPrint:setDevice(IMP_PDF)
	//oPrint:lPDFAsPNG := .T.
EndIf
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄaÄÄÄÄÄÄÄÄÄÄ?
//³Verifica se existe alguma impressora configurada para Impressao Grafica
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
If  !lWeb
	oPrint:Setup()
	If !(oPrint:nModalResult == 1)
		Return
	Else
		lImpnovo:=(oPrint:nModalResult == 1)
	Endif
EndIf

If oPrint:nPaperSize  == 9 // Papél A4
	nLinMax	:=	2000
	nColMax	:=	3355 //3508 //3380 //3365
	nLayout 	:= 2
	oFont02n	:= TFont():New("Arial", 12, 12, , .T., , , , .T., .F.) // Negrito
	oFont03n	:= TFont():New("Arial", 13, 13, , .T., , , , .T., .F.) // Negrito
	oFont04		:= TFont():New("Arial", 07, 07, , .F., , , , .T., .F.) // Normal
Elseif oPrint:nPaperSize == 1 // Papel Carta
	nLinMax	:=	2000
	nColMax	:=	3175
	nLayout 	:= 3
	oFont02n	:= TFont():New("Arial", 12, 12, , .T., , , , .T., .F.) // Negrito
	oFont03n	:= TFont():New("Arial", 13, 13, , .T., , , , .T., .F.) // Negrito
	oFont04		:= TFont():New("Arial", 07, 07, , .F., , , , .T., .F.) // Normal
Else // Papel Oficio2 216 x 330mm / 8 1/2 x 13in
	nLinMax	:=	2435
	nColMax	:=	3765
	nLayout 	:= 1
	oFont02n	:= TFont():New("Arial", 12, 12, , .T., , , , .T., .F.) // Negrito
	oFont03n	:= TFont():New("Arial", 14, 14, , .T., , , , .T., .F.) // Negrito
	oFont04		:= TFont():New("Arial", 09, 09, , .F., , , , .T., .F.) // Normal
Endif

While lImpnovo

	lImpnovo:=.F.
	nVolta  += 1
	nT      += 5
	nT1     += 5
	nT2     +=10
	nT3     += 9
	nT4     += 9
	nProx   += 1

	For nX := 1 To Len(aDados)

		If ValType(aDados[nX]) == 'U' .OR. Len(aDados[nX]) == 0
			Loop
		EndIf

		For nI := 25 To 29
			If Len(aDados[nX, nI]) < nT
				For nJ := Len(aDados[nX, nI]) + 1 To nT
					If AllTrim(Str(nI)) $ "28,29"
						aAdd(aDados[nX, nI], 0)
					Else
						aAdd(aDados[nX, nI], "")
					EndIf
				Next nJ
			EndIf
		Next nI

		For nI := 51 To 62
			If Len(aDados[nX, nI]) < nT1
				For nJ := Len(aDados[nX, nI]) + 1 To nT1
					If AllTrim(Str(nI)) $ "51"
						aAdd(aDados[nX, nI], StoD(""))
					ElseIf AllTrim(Str(nI)) $ "57,60,61,62"
						aAdd(aDados[nX, nI], 0)
					Else
						aAdd(aDados[nX, nI], "")
					EndIf
				Next nJ
			EndIf
		Next nI

		For nI := 63 To 63
			If Len(aDados[nX, nI]) < nT2
				For nJ := Len(aDados[nX, nI]) + 1 To nT2
					aAdd(aDados[nX, nI], StoD(""))
				Next nJ
			EndIf
		Next nI

		For nI := 65 To 71
			If Len(aDados[nX, nI]) < nVolta
				For nJ := Len(aDados[nX, nI]) + 1 To nVolta
					If AllTrim(Str(nI)) $ "65,66,67,68,69,70,71"
						aAdd(aDados[nX, nI], 0)
					EndIf
				Next nJ
			EndIf
		Next nI

		For nI := 72 To 77
			If Len(aDados[nX, nI]) < nT3
				For nJ := Len(aDados[nX, nI]) + 1 To nT3
					If AllTrim(Str(nI)) $ "75,77"
						aAdd(aDados[nX, nI], 0)
					Else
						aAdd(aDados[nX, nI], "")
					EndIf
				Next nJ
			EndIf
		Next nI

		For nI := 78 To 84
			If Len(aDados[nX, nI]) < nT4
				For nJ := Len(aDados[nX, nI]) + 1 To nT4
					If AllTrim(Str(nI)) $ "81,83,84"
						aAdd(aDados[nX, nI], 0)
					Else
						aAdd(aDados[nX, nI], "")
					EndIf
				Next nJ
			EndIf
		Next nI

		For nI := 85 To 85
			If Len(aDados[nX, nI]) < nVolta
				For nJ := Len(aDados[nX, nI]) + 1 To nVolta
					aAdd(aDados[nX, nI], 0)
				Next nJ
			EndIf
		Next nI
		If oPrint:Cprinter == "PDF" .OR. lWeb
			nLinIni	:= 150
			nLimFim	:= 400
		Else
			nLinIni	:= 060
			nLimFim	:= 230
		Endif


		nColIni		:= 068
		nColA4		:= 000
		nLinA4		:= 000
		nColSoma	:= 000
		nColSoma2	:= 000

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
		//³Inicia uma nova pagina
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
		oPrint:StartPage()
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Box Principal                                                 ?
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		oPrint:Box((nLinIni + 0000)*nAL, (nColIni + 0000)*nAC, (nLimFim + nLinMax)*nAL, (nColIni + nColMax)*nAC)
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Carrega e Imprime Logotipo da Empresa                         ?
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

		oPrint:Say((nLinIni + 0050)*nAL, (nColIni + 1702)*nAC + (nColA4/2), OemToAnsi("GUIA DE SERVIÇO PROFISSIONAL / SERVIÇO AUXILIAR DE DIAGNÓSTICO E TERAPIA - SP/SADT"), oFont02n,,,, 2) //"GUIA DE SERVIÇO PROFISSIONAL / SERVIÇO AUXILIAR DE DIAGNÓSTICO E TERAPIA - SP/SADT"
		oPrint:Say((nLinIni + 0050)*nAL, (nColIni + 2930 + IIf (nLayout == 3,(nColA4/2+(nColSoma/3)),(nColA4/2)))*nAC, "2 - "+OemToAnsi("Nº"), oFont01) //"N?
		oPrint:Say((nLinIni + 0050)*nAL, (nColIni + 3026 + IIf (nLayout == 3,(nColA4/2+(nColSoma/3)),(nColA4/2)))*nAC, aDados[nX, 02], oFont03n)

		oPrint:Box((nLinIni + 0175)*nAL + nLinA4, (nColIni + 0010			)*nAC, (nLinIni + 0269)*nAL + nLinA4, (nColIni + 0315)*nAC)
		oPrint:Say((nLinIni + 0180 + nLinA4)*nAL, (nColIni + 0020			)*nAC, "1 - "+"Registro ANS", oFont01) //"Registro ANS"
		oPrint:Say((nLinIni + 0210 + nLinA4)*nAL, (nColIni + 0030			)*nAC, aDados[nX, 01], oFont04)
		oPrint:Box((nLinIni + 0175)*nAL + nLinA4, (nColIni + 0320			)*nAC, (nLinIni + 0269)*nAL + nLinA4, (nColIni + 1035)*nAC)
		oPrint:Say((nLinIni + 0180 + nLinA4)*nAL, (nColIni + 0330			)*nAC, "3 - "+OemToAnsi("Nº Guia Principal"), oFont01) //"N?Guia Principal"
		oPrint:Say((nLinIni + 0210 + nLinA4)*nAL, (nColIni + 0340			)*nAC, aDados[nX, 03], oFont04)
		oPrint:Box((nLinIni + 0175)*nAL + nLinA4, (nColIni + 1040			)*nAC, (nLinIni + 0269)*nAL + nLinA4, (nColIni + 1345)*nAC)
		oPrint:Say((nLinIni + 0180 + nLinA4)*nAL, (nColIni + 1050			)*nAC, "4 - "+"Data da Autorização", oFont01) //"Data da Autorização"
		oPrint:Say((nLinIni + 0210 + nLinA4)*nAL, (nColIni + 1060			)*nAC, DtoC(aDados[nX, 04]), oFont04)
		oPrint:Box((nLinIni + 0175)*nAL + nLinA4, (nColIni + 1350			)*nAC, (nLinIni + 0269)*nAL + nLinA4, (nColIni + 1755)*nAC)
		oPrint:Say((nLinIni + 0180 + nLinA4)*nAL, (nColIni + 1360			)*nAC, "5 - "+"Senha", oFont01) //"Senha"
		oPrint:Say((nLinIni + 0210 + nLinA4)*nAL, (nColIni + 1370			)*nAC, aDados[nX, 05], oFont04)
		oPrint:Box((nLinIni + 0175)*nAL + nLinA4, (nColIni + 1760			)*nAC, (nLinIni + 0269)*nAL + nLinA4, (nColIni + 2165)*nAC)
		oPrint:Say((nLinIni + 0180 + nLinA4)*nAL, (nColIni + 1770			)*nAC, "6 - "+"Data Validade da Senha", oFont01) //"Data Validade da Senha"
		oPrint:Say((nLinIni + 0210 + nLinA4)*nAL, (nColIni + 1780			)*nAC, DtoC(aDados[nX, 06]), oFont04)
		oPrint:Box((nLinIni + 0175)*nAL + nLinA4, (nColIni + 2170			)*nAC, (nLinIni + 0269)*nAL + nLinA4, (nColIni + 2465)*nAC)
		oPrint:Say((nLinIni + 0180 + nLinA4)*nAL, (nColIni + 2180			)*nAC, "7 - "+"Data de Emissão da Guia", oFont01) //"Data de Emissão da Guia"
		oPrint:Say((nLinIni + 0210 + nLinA4)*nAL, (nColIni + 2190			)*nAC, DtoC(aDados[nX, 07]), oFont04)

		oPrint:Say((nLinIni + 0274 + nLinA4)*nAL, (nColIni + 0010			)*nAC, "Dados do Beneficiário", oFont01) //"Dados do Beneficiário"
		oPrint:Box((nLinIni + 0304)*nAL + nLinA4, (nColIni + 0010			)*nAC, (nLinIni + 0398)*nAL + nLinA4, (nColIni + 0425)*nAC)
		oPrint:Say((nLinIni + 0309 + nLinA4)*nAL, (nColIni + 0020			)*nAC, "8 - "+"Número da Carteira", oFont01) //"Número da Carteira"
		oPrint:Say((nLinIni + 0339 + nLinA4)*nAL, (nColIni + 0030			)*nAC, aDados[nX, 08], oFont04)
		oPrint:Box((nLinIni + 0304)*nAL + nLinA4, (nColIni + 0430			)*nAC, (nLinIni + 0398)*nAL + nLinA4, (nColIni + 1572 + nColA4)*nAC)
		oPrint:Say((nLinIni + 0309 + nLinA4)*nAL, (nColIni + 0440			)*nAC, "9 - "+"Plano", oFont01) //"Plano"
		oPrint:Say((nLinIni + 0339 + nLinA4)*nAL, (nColIni + 0450			)*nAC, aDados[nX, 09], oFont04)
		oPrint:Box((nLinIni + 0304)*nAL + nLinA4, (nColIni + 1577 + nColA4	)*nAC, (nLinIni + 0398)*nAL + nLinA4, (nColIni + 1835 + nColA4)*nAC)
		oPrint:Say((nLinIni + 0309 + nLinA4)*nAL, (nColIni + 1587 + nColA4	)*nAC, "10 - "+"Validade da Carteira", oFont01) //"Validade da Carteira"
		oPrint:Say((nLinIni + 0339 + nLinA4)*nAL, (nColIni + 1597 + nColA4	)*nAC, DtoC(aDados[nX, 10]), oFont04)
		oPrint:Box((nLinIni + 0304)*nAL + nLinA4, (nColIni + 1840 + nColA4	)*nAC, (nLinIni + 0398)*nAL + nLinA4, (nColIni + 3290 + nColA4)*nAC)
		oPrint:Say((nLinIni + 0309 + nLinA4)*nAL, (nColIni + 1850 + nColA4	)*nAC, "11 - "+"Nome", oFont01) //"Nome"
		oPrint:Say((nLinIni + 0339 + nLinA4)*nAL, (nColIni + 1860 + nColA4	)*nAC, SubStr(aDados[nX, 11], 1, 52), oFont04)
		oPrint:Box((nLinIni + 0304)*nAL + nLinA4, (nColIni + 3295 + nColA4	)*nAC, (nLinIni + 0398)*nAL + nLinA4, (nColIni + 3745 + nColA4)*nAC)
		oPrint:Say((nLinIni + 0309 + nLinA4)*nAL, (nColIni + 3305 + nColA4	)*nAC, "12 - "+"Número do Cartão Nacional de Saúde", oFont01) //"Número do Cartão Nacional de Saúde"
		oPrint:Say((nLinIni + 0339 + nLinA4)*nAL, (nColIni + 3315 + nColA4	)*nAC, aDados[nX, 12], oFont04)

		oPrint:Say((nLinIni + 0403 + nLinA4)*nAL, (nColIni + 0010			)*nAC, "Dados do Contratado Solicitante", oFont01) //"Dados do Contratado Solicitante"
		oPrint:Box((nLinIni + 0433)*nAL + nLinA4, (nColIni + 0010			)*nAC, (nLinIni + 0527)*nAL + nLinA4, (nColIni + 0426)*nAC)
		oPrint:Say((nLinIni + 0438 + nLinA4)*nAL, (nColIni + 0020			)*nAC, "13 - "+"Código na Operadora / CNPJ / CPF", oFont01) //"Código na Operadora / CNPJ / CPF"
		oPrint:Say((nLinIni + 0468 + nLinA4)*nAL, (nColIni + 0030			)*nAC, aDados[nX, 13], oFont04)
		oPrint:Box((nLinIni + 0433)*nAL + nLinA4, (nColIni + 0431			)*nAC, (nLinIni + 0527)*nAL + nLinA4, (nColIni + 2245)*nAC)
		oPrint:Say((nLinIni + 0438 + nLinA4)*nAL, (nColIni + 0441			)*nAC, "14 - "+"Nome do Contratado", oFont01) //"Nome do Contratado"
		oPrint:Say((nLinIni + 0468 + nLinA4)*nAL, (nColIni + 0451			)*nAC, SubStr(aDados[nX, 14], 1, 65), oFont04)
		oPrint:Box((nLinIni + 0433)*nAL + nLinA4, (nColIni + 2250			)*nAC, (nLinIni + 0527)*nAL + nLinA4, (nColIni + 2480)*nAC)
		oPrint:Say((nLinIni + 0438 + nLinA4)*nAL, (nColIni + 2260			)*nAC, "15 - "+"Código CNES", oFont01) //"Código CNES"
		oPrint:Say((nLinIni + 0468 + nLinA4)*nAL, (nColIni + 2270			)*nAC, aDados[nX, 15], oFont04)

		oPrint:Box((nLinIni + 0532)*nAL + nLinA4, (nColIni + 0010			)*nAC, (nLinIni + 0626)*nAL + nLinA4, (nColIni + 1824)*nAC)
		oPrint:Say((nLinIni + 0537 + nLinA4)*nAL, (nColIni + 0020			)*nAC, "16 - "+"Nome do Profissional Solicitante", oFont01) //"Nome do Profissional Solicitante"
		oPrint:Say((nLinIni + 0567 + nLinA4)*nAL, (nColIni + 0030			)*nAC, SubStr(aDados[nX, 16], 1, 66), oFont04)
		oPrint:Box((nLinIni + 0532)*nAL + nLinA4, (nColIni + 1829			)*nAC, (nLinIni + 0626)*nAL + nLinA4, (nColIni + 2122)*nAC)
		oPrint:Say((nLinIni + 0537 + nLinA4)*nAL, (nColIni + 1839			)*nAC, "17 - "+"Conselho Profissional", oFont01) //"Conselho Profissional"
		oPrint:Say((nLinIni + 0567 + nLinA4)*nAL, (nColIni + 1849			)*nAC, aDados[nX, 17], oFont04)
		oPrint:Box((nLinIni + 0532)*nAL + nLinA4, (nColIni + 2127			)*nAC, (nLinIni + 0626)*nAL + nLinA4, (nColIni + 2480)*nAC)
		oPrint:Say((nLinIni + 0537 + nLinA4)*nAL, (nColIni + 2137			)*nAC, "18 - "+"Número no Conselho", oFont01) //"Número no Conselho"
		oPrint:Say((nLinIni + 0567 + nLinA4)*nAL, (nColIni + 2147			)*nAC, aDados[nX, 18], oFont04)
		oPrint:Box((nLinIni + 0532)*nAL + nLinA4, (nColIni + 2485			)*nAC, (nLinIni + 0626)*nAL + nLinA4, (nColIni + 2575)*nAC)
		oPrint:Say((nLinIni + 0537 + nLinA4)*nAL, (nColIni + 2495			)*nAC, "19 - "+"UF", oFont01) //"UF"
		oPrint:Say((nLinIni + 0567 + nLinA4)*nAL, (nColIni + 2505			)*nAC, aDados[nX, 19], oFont04)
		oPrint:Box((nLinIni + 0532)*nAL + nLinA4, (nColIni + 2580			)*nAC, (nLinIni + 0626)*nAL + nLinA4, (nColIni + 2790)*nAC)
		oPrint:Say((nLinIni + 0537 + nLinA4)*nAL, (nColIni + 2590			)*nAC, "20 - "+"Código CBO S", oFont01) //"Código CBO S"
		oPrint:Say((nLinIni + 0567 + nLinA4)*nAL, (nColIni + 2600			)*nAC, aDados[nX, 20], oFont04)

		oPrint:Say((nLinIni + 0631 + nLinA4)*nAL, (nColIni + 0010)*nAC, "Dados da Solicitação / Procedimentos e Exames Solicitados", oFont01) //"Dados da Solicitação / Procedimentos e Exames Solicitados"
		oPrint:Box((nLinIni + 0661)*nAL + nLinA4, (nColIni + 0010)*nAC, (nLinIni + 0755)*nAL + nLinA4, (nColIni + 0315)*nAC)
		oPrint:Say((nLinIni + 0660 + nLinA4)*nAL, (nColIni + 0020)*nAC, "21 - "+"Data/Hora da Solicitação", oFont01) //"Data/Hora da Solicitação"
		oPrint:Say((nLinIni + 0696 + nLinA4)*nAL, (nColIni + 0030)*nAC, DtoC(aDados[nX, 21,1]) + " " + Transform(aDados[nX, 21,2], "@R 99:99"), oFont04)
		oPrint:Box((nLinIni + 0661)*nAL + nLinA4, (nColIni + 0320)*nAC, (nLinIni + 0755)*nAL + nLinA4, (nColIni + 0735)*nAC)
		oPrint:Say((nLinIni + 0660 + nLinA4)*nAL, (nColIni + 0330)*nAC, "22 - "+"Caráter da Solicitação", oFont01) //"Caráter da Solicitação"
		oPrint:Line((nLinIni + 0691)*nAL+ nLinA4, 		(nColIni + 0340)*nAC, (nLinIni + 0728)*nAL + (nLinA4/2), (nColIni + 0340)*nAC)
		oPrint:Line((nLinIni + 0728)*nAL+ (nLinA4/2), 	(nColIni + 0340)*nAC, (nLinIni + 0728)*nAL + (nLinA4/2), (nColIni + 0387)*nAC)
		oPrint:Line((nLinIni + 0691)*nAL+ nLinA4, 		(nColIni + 0387)*nAC, (nLinIni + 0728)*nAL + (nLinA4/2), (nColIni + 0387)*nAC)
		oPrint:Say((nLinIni + 0696 + nLinA4)*nAL, (nColIni + 0353)*nAC, aDados[nX, 22], oFont04)
		oPrint:Say((nLinIni + 0706 + nLinA4)*nAL, (nColIni + 0400)*nAC, "E-Eletiva"+"  "+"U-Urgência/Emergência", oFont01) //"E-Eletiva"###"U-Urgência/Emergência"
		oPrint:Box((nLinIni + 0661)*nAL + nLinA4, (nColIni + 0740)*nAC, (nLinIni + 0755)*nAL + nLinA4, (nColIni + 0905)*nAC)
		oPrint:Say((nLinIni + 0660 + nLinA4)*nAL, (nColIni + 0750)*nAC, "23 - "+"CID 10", oFont01) //"CID 10"
		oPrint:Say((nLinIni + 0696 + nLinA4)*nAL, (nColIni + 0760)*nAC, aDados[nX, 23], oFont04)
		oPrint:Box((nLinIni + 0661)*nAL + nLinA4, (nColIni + 0910)*nAC, (nLinIni + 0755)*nAL + nLinA4, (nColIni + 3745 + nColA4)*nAC)
		oPrint:Say((nLinIni + 0660 + nLinA4)*nAL, (nColIni + 0920)*nAC, "24 - "+"Indicação Clínica (obrigatório se pequena cirurgia, terapia, consulta referenciada e alto custo)", oFont01) //"Indicação Clínica (obrigatório se pequena cirurgia, terapia, consulta referenciada e alto custo)"
		oPrint:Say((nLinIni + 0696 + nLinA4)*nAL, (nColIni + 0930)*nAC, aDados[nX, 24], oFont04)

		oPrint:Box((nLinIni + 0760)*nAL + nLinA4, (nColIni + 0010			)*nAC, (nLinIni + 1005)*nAL + nLinA4, (nColIni + 3745 + nColA4)*nAC)
		oPrint:Say((nLinIni + 0765 + nLinA4)*nAL, (nColIni + 0020			)*nAC, "25 - "+"Tabela", oFont01) //"Tabela"
		oPrint:Say((nLinIni + 0765 + nLinA4)*nAL, (nColIni + 0150			)*nAC, "26 - "+"Código do Procedimento", oFont01) //"Código do Procedimento"
		oPrint:Say((nLinIni + 0765 + nLinA4)*nAL, (nColIni + 0450			)*nAC, "27 - "+"Descrição", oFont01) //"Descrição"
		oPrint:Say((nLinIni + 0765 + nLinA4)*nAL, (nColIni + 3400 + nColA4	)*nAC, "28 - "+"Qt.Solic.", oFont01,,,,1) //"Qt.Solic."
		oPrint:Say((nLinIni + 0765 + nLinA4)*nAL, (nColIni + 3610 + nColA4	)*nAC, "29 - "+"Qt.Autoriz.", oFont01,,,,1) //"Qt.Autoriz."

		nOldLinIni := nLinIni

		if nVolta = 1
			nV:=1
		Endif

		For nP := nV To nT
			if nVolta <> 1
				nN:=nP-((5*nVolta)-5)
				oPrint:Say((nLinIni + 0805 + nLinA4)*nAL, (nColIni + 0025)*nAC, AllTrim(Str(nN)) + " - ", oFont01)
			else
				oPrint:Say((nLinIni + 0805 + nLinA4)*nAL, (nColIni + 0025)*nAC, AllTrim(Str(nP)) + " - ", oFont01)
			endif
			oPrint:Say((nLinIni + 0800 + nLinA4)*nAL, (nColIni + 0065)*nAC			, aDados[nX, 25, nP], oFont04)
			oPrint:Say((nLinIni + 0800 + nLinA4)*nAL, (nColIni + 0150)*nAC			, aDados[nX, 26, nP], oFont04)
			oPrint:Say((nLinIni + 0800 + nLinA4)*nAL, (nColIni + 0450)*nAC			, aDados[nX, 27, nP], oFont04)
			oPrint:Say((nLinIni + 0800 + nLinA4)*nAL, (nColIni + 3425 + nColA4)*nAC, IIf(Empty(aDados[nX, 28, nP]), "", Transform(aDados[nX, 28, nP], "@E 9999.99")), oFont04,,,,1)
			oPrint:Say((nLinIni + 0800 + nLinA4)*nAL, (nColIni + 3635 + nColA4)*nAC, IIf(Empty(aDados[nX, 29, nP]), "", Transform(aDados[nX, 29, nP], "@E 9999.99")), oFont04,,,,1)
			nLinIni += 40
		Next nP

		if nT < Len(aDados[nX, 26]).or. lImpnovo
			  nV:=nP
			  lImpnovo:=.T.
		Endif

		nLinIni := nOldLinIni

		oPrint:Say((nLinIni + 1000 + nLinA4)*nAL, (nColIni + 0010			)*nAC, "Dados do Contratado Executante", oFont01) //"Dados do Contratado Executante"
		oPrint:Box((nLinIni + 1040)*nAL + nLinA4, (nColIni + 0010			)*nAC, (nLinIni + 1134)*nAL + nLinA4, (nColIni + 0416)*nAC)
		oPrint:Say((nLinIni + 1045 + nLinA4)*nAL, (nColIni + 0020			)*nAC, "30 - "+"Código na Operadora / CNPJ / CPF", oFont01) //"Código na Operadora / CNPJ / CPF"
		oPrint:Say((nLinIni + 1075 + nLinA4)*nAL, (nColIni + 0030			)*nAC, aDados[nX, 30], oFont04)
		oPrint:Box((nLinIni + 1040)*nAL + nLinA4, (nColIni + 0421			)*nAC, (nLinIni + 1134)*nAL + nLinA4, (nColIni + 1316 + nColSoma)*nAC)
		oPrint:Say((nLinIni + 1045 + nLinA4)*nAL, (nColIni + 0431			)*nAC, "31 - "+"Nome do Contratado", oFont01) //"Nome do Contratado"
		oPrint:Say((nLinIni + 1075 + nLinA4)*nAL, (nColIni + 0441			)*nAC, SubStr(aDados[nX, 31], 1, 32), oFont04)
		oPrint:Box((nLinIni + 1040)*nAL + nLinA4, (nColIni + 1321 + nColSoma)*nAC, (nLinIni + 1134)*nAL + nLinA4, (nColIni + 1433 + nColSoma)*nAC)
		oPrint:Say((nLinIni + 1045 + nLinA4)*nAL, (nColIni + 1331 + nColSoma)*nAC, "32 - "+"T.L.", oFont01) //"T.L."
		oPrint:Say((nLinIni + 1075 + nLinA4)*nAL, (nColIni + 1341 + nColSoma)*nAC, aDados[nX, 32], oFont04)
		oPrint:Box((nLinIni + 1040)*nAL + nLinA4, (nColIni + 1438 + nColSoma)*nAC, (nLinIni + 1134)*nAL + nLinA4, (nColIni + 2413 + nColA4)*nAC)
		oPrint:Say((nLinIni + 1045 + nLinA4)*nAL, (nColIni + 1448 + nColSoma)*nAC, "33-34-35 - "+"Logradouro - Número - Complemento", oFont01) //"Logradouro - Número - Complemento"
		oPrint:Say((nLinIni + 1075 + nLinA4)*nAL, (nColIni + 1458 + nColSoma)*nAC, SubStr(AllTrim(aDados[nX, 33]) + IIf(!Empty(aDados[nX, 34]), ", ","") + AllTrim(aDados[nX, 34]) + IIf(!Empty(aDados[nX, 35]), " - ","") + AllTrim(aDados[nX, 35]), 1, 35), oFont04)
		oPrint:Box((nLinIni + 1040)*nAL + nLinA4, (nColIni + 2418 + nColA4	)*nAC, (nLinIni + 1134)*nAL + nLinA4, (nColIni + 3023 + nColA4)*nAC)
		oPrint:Say((nLinIni + 1045 + nLinA4)*nAL, (nColIni + 2428 + nColA4	)*nAC, "36 - "+"Município", oFont01) //"Município"
		oPrint:Say((nLinIni + 1075 + nLinA4)*nAL, (nColIni + 2438 + nColA4	)*nAC, SubStr(aDados[nX, 36], 1, 21), oFont04)
		oPrint:Box((nLinIni + 1040)*nAL + nLinA4, (nColIni + 3028 + nColA4	)*nAC, (nLinIni + 1134)*nAL + nLinA4, (nColIni + 3130 + nColA4)*nAC)
		oPrint:Say((nLinIni + 1045 + nLinA4)*nAL, (nColIni + 3038 + nColA4	)*nAC, "37 - "+"UF", oFont01) //"UF"
		oPrint:Say((nLinIni + 1075 + nLinA4)*nAL, (nColIni + 3048 + nColA4	)*nAC, aDados[nX, 37], oFont04)
		oPrint:Box((nLinIni + 1040)*nAL + nLinA4, (nColIni + 3135 + nColA4	)*nAC, (nLinIni + 1134)*nAL + nLinA4, (nColIni + 3320 + nColA4)*nAC)
		oPrint:Say((nLinIni + 1045 + nLinA4)*nAL, (nColIni + 3145 + nColA4	)*nAC, "38 - "+"Cód.IBGE", oFont01) //"Cód.IBGE"
		oPrint:Say((nLinIni + 1075 + nLinA4)*nAL, (nColIni + 3155 + nColA4	)*nAC, aDados[nX, 38], oFont04)
		oPrint:Box((nLinIni + 1040)*nAL + nLinA4, (nColIni + 3325 + nColA4	)*nAC, (nLinIni + 1134)*nAL + nLinA4, (nColIni + 3510 + nColA4)*nAC)
		oPrint:Say((nLinIni + 1045 + nLinA4)*nAL, (nColIni + 3335 + nColA4	)*nAC, "39 - "+"CEP", oFont01) //"CEP"
		oPrint:Say((nLinIni + 1075 + nLinA4)*nAL, (nColIni + 3345 + nColA4	)*nAC, aDados[nX, 39], oFont04)
		oPrint:Box((nLinIni + 1040)*nAL + nLinA4, (nColIni + 3515 + nColA4	)*nAC, (nLinIni + 1134)*nAL + nLinA4, (nColIni + 3745 + nColA4)*nAC)
		oPrint:Say((nLinIni + 1045 + nLinA4)*nAL, (nColIni + 3525 + nColA4	)*nAC, "40 - "+"Código CNES", oFont01) //"Código CNES"
		oPrint:Say((nLinIni + 1075 + nLinA4)*nAL, (nColIni + 3535 + nColA4	)*nAC, aDados[nX, 40, 1], oFont04)

		oPrint:Box((nLinIni + 1139)*nAL + nLinA4, (nColIni + 0010)*nAC, (nLinIni + 1233)*nAL + nLinA4, (nColIni + 0590)*nAC)
		oPrint:Say((nLinIni + 1144 + nLinA4)*nAL, (nColIni + 0020)*nAC, "40a - "+"Código na Operadora / CPF do exec. complementar", oFont01) //"Código na Operadora / CPF do exec. complementar"
		oPrint:Say((nLinIni + 1174 + nLinA4)*nAL, (nColIni + 0030)*nAC, SubStr(aDados[nX, 40, 2], 1, 68), oFont04)
		oPrint:Box((nLinIni + 1139)*nAL + nLinA4, (nColIni + 0595)*nAC, (nLinIni + 1233)*nAL + nLinA4, (nColIni + 2436 + IIf(nLayout == 2,nColA4,nColSoma+nColSoma2))*nAC)
		oPrint:Say((nLinIni + 1144 + nLinA4)*nAL, (nColIni + 0605)*nAC, "41 - "+"Nome do Profissional Executante/Complementar", oFont01) //"Nome do Profissional Executante/Complementar"
		oPrint:Say((nLinIni + 1174 + nLinA4)*nAL, (nColIni + 0615)*nAC, SubStr(aDados[nX, 41], 1, 68), oFont04)
		oPrint:Box((nLinIni + 1139)*nAL + nLinA4, (nColIni + 2441 + IIf(nLayout == 2,nColA4,nColSoma+nColSoma2))*nAC, (nLinIni + 1233)*nAL + nLinA4, (nColIni + 2715 + IIf(nLayout == 2,nColA4,nColSoma+nColSoma2))*nAC)
		oPrint:Say((nLinIni + 1144 + nLinA4)*nAL, (nColIni + 2451 + IIf(nLayout == 2,nColA4,nColSoma+nColSoma2))*nAC, "42 - "+"Conselho Profissional", oFont01) //"Conselho Profissional"
		oPrint:Say((nLinIni + 1174 + nLinA4)*nAL, (nColIni + 2461 + IIf(nLayout == 2,nColA4,nColSoma+nColSoma2))*nAC, aDados[nX, 42], oFont04)
		oPrint:Box((nLinIni + 1139)*nAL + nLinA4, (nColIni + 2720 + IIf(nLayout == 2,nColA4,nColSoma+nColSoma2))*nAC, (nLinIni + 1233)*nAL + nLinA4, (nColIni + 3055 + IIf(nLayout == 2,nColA4,nColSoma+nColSoma2))*nAC)
		oPrint:Say((nLinIni + 1144 + nLinA4)*nAL, (nColIni + 2730 + IIf(nLayout == 2,nColA4,nColSoma+nColSoma2))*nAC, "43 - "+"Número no Conselho", oFont01) //"Número no Conselho"
		oPrint:Say((nLinIni + 1174 + nLinA4)*nAL, (nColIni + 2740 + IIf(nLayout == 2,nColA4,nColSoma+nColSoma2))*nAC, aDados[nX, 43], oFont04)
		oPrint:Box((nLinIni + 1139)*nAL + nLinA4, (nColIni + 3060 + IIf(nLayout == 2,nColA4,nColSoma+nColSoma2))*nAC, (nLinIni + 1233)*nAL + nLinA4, (nColIni + 3160 + IIf(nLayout == 2,nColA4,nColSoma+nColSoma2))*nAC)
		oPrint:Say((nLinIni + 1144 + nLinA4)*nAL, (nColIni + 3070 + IIf(nLayout == 2,nColA4,nColSoma+nColSoma2))*nAC, "44 - "+"UF", oFont01) //"UF"
		oPrint:Say((nLinIni + 1174 + nLinA4)*nAL, (nColIni + 3080 + IIf(nLayout == 2,nColA4,nColSoma+nColSoma2))*nAC, aDados[nX, 44], oFont04)
		oPrint:Box((nLinIni + 1139)*nAL + nLinA4, (nColIni + 3165 + IIf(nLayout == 2,nColA4,nColSoma+nColSoma2))*nAC, (nLinIni + 1233)*nAL + nLinA4, (nColIni + 3372 + IIf(nLayout == 2,nColA4,nColSoma+nColSoma2))*nAC)
		oPrint:Say((nLinIni + 1144 + nLinA4)*nAL, (nColIni + 3175 + IIf(nLayout == 2,nColA4,nColSoma+nColSoma2))*nAC, "45 - "+"Código CBO S", oFont01) //"Código CBO S"
		oPrint:Say((nLinIni + 1174 + nLinA4)*nAL, (nColIni + 3185 + IIf(nLayout == 2,nColA4,nColSoma+nColSoma2))*nAC, aDados[nX, 45, 1], oFont04)
		oPrint:Box((nLinIni + 1139)*nAL + nLinA4, (nColIni + 3377 + IIf(nLayout == 2,nColA4,nColSoma+nColSoma2))*nAC, (nLinIni + 1233)*nAL + nLinA4, (nColIni + 3745 + nColA4)*nAC)
		oPrint:Say((nLinIni + 1144 + nLinA4)*nAL, (nColIni + 3387 + IIf(nLayout == 2,nColA4,nColSoma+nColSoma2))*nAC, "45a - "+"Grau de Participação", oFont01) //"Grau de Participação"
		oPrint:Say((nLinIni + 1174 + nLinA4)*nAL, (nColIni + 3397 + IIf(nLayout == 2,nColA4,nColSoma+nColSoma2))*nAC, aDados[nX, 45, 2], oFont04)

		oPrint:Say((nLinIni + 1236 + nLinA4)*nAL, (nColIni + 0010)*nAC, "Dados do Atendimento", oFont01) //"Dados do Atendimento"
		oPrint:Box((nLinIni + 1268)*nAL + nLinA4, (nColIni + 0010)*nAC, (nLinIni + 1362)*nAL + nLinA4, (nColIni + 1185)*nAC)
		oPrint:Say((nLinIni + 1273 + nLinA4)*nAL, (nColIni + 0020)*nAC, "46 - "+"Tipo Atendimento", oFont01) //"Tipo Atendimento"
		oPrint:Line((nLinIni + 1298)*nAL+ nLinA4, (nColIni + 0030)*nAC, (nLinIni + 1348)*nAL + nLinA4, (nColIni + 0030)*nAC)
		oPrint:Line((nLinIni + 1348)*nAL+ nLinA4, (nColIni + 0030)*nAC, (nLinIni + 1348)*nAL + nLinA4, (nColIni + 0087)*nAC)
		oPrint:Line((nLinIni + 1298)*nAL+ nLinA4, (nColIni + 0087)*nAC, (nLinIni + 1348)*nAL + nLinA4, (nColIni + 0087)*nAC)
		oPrint:Say((nLinIni + 1303 + nLinA4)*nAL, (nColIni + 0043)*nAC, aDados[nX, 46], oFont04)
		oPrint:Say((nLinIni + 1298 + nLinA4)*nAL, (nColIni + 0100)*nAC, "01 - "+"Remoção"+"    "+"02 - "+"Pequena Cirurgia"+"    "+"03 - "+"Terapias"+"    "+"04 - "+"Consulta"+"    "+"05 - "+"Exame"+"    "+"06 - "+"Atendimento Domiciliar", oFont01) //"Remoção"###"Pequena Cirurgia"###"Terapias"###"Consulta"###"Exame"###"Atendimento Domiciliar"
		oPrint:Say((nLinIni + 1328 + nLinA4)*nAL, (nColIni + 0100)*nAC, "07 - "+"SADT Internado"+"    "+"08 - "+"Quimioterapia"+"    "+"09 - "+"Radioterapia"+"    "+"10 - "+"TRS-Terapia Renal Substitutiva", oFont01) //"SADT Internado"###"Quimioterapia"###"Radioterapia"###"TRS-Terapia Renal Substitutiva"
		oPrint:Box((nLinIni + 1268)*nAL + nLinA4, (nColIni + 1190)*nAC, (nLinIni + 1362)*nAL + nLinA4, (nColIni + 2450 + nColA4/2)*nAC)
		oPrint:Say((nLinIni + 1273 + nLinA4)*nAL, (nColIni + 1200)*nAC, "47 - "+"Indicação de Acidente", oFont01) //"Indicação de Acidente"
		oPrint:Line((nLinIni + 1298)*nAL+ nLinA4, (nColIni + 1210)*nAC, (nLinIni + 1348)*nAL + nLinA4, (nColIni + 1210)*nAC)
		oPrint:Line((nLinIni + 1348)*nAL+ nLinA4, (nColIni + 1210)*nAC, (nLinIni + 1348)*nAL + nLinA4, (nColIni + 1257)*nAC)
		oPrint:Line((nLinIni + 1298)*nAL+ nLinA4, (nColIni + 1257)*nAC, (nLinIni + 1348)*nAL + nLinA4, (nColIni + 1257)*nAC)
		oPrint:Say((nLinIni + 1303 + nLinA4)*nAL, (nColIni + 1223)*nAC, aDados[nX, 47], oFont04)
		oPrint:Say((nLinIni + 1313 + nLinA4)*nAL, (nColIni + 1270)*nAC, "0 - "+"Acidente ou doença relacionado ao trabalho"+"   "+"1 - "+"Trânsito"+"   "+"2 - "+"Outros", oFont01) //"Acidente ou doença relacionado ao trabalho"###"Trânsito"###"Outros"
		oPrint:Box((nLinIni + 1268)*nAL + nLinA4, (nColIni + 2455 + nColA4/2)*nAC, (nLinIni + 1362)*nAL + nLinA4, (nColIni + 3745 + nColA4)*nAC)
		oPrint:Say((nLinIni + 1273 + nLinA4)*nAL, (nColIni + 2465 + nColA4/2)*nAC, "48 - "+"Tipo de Saída", oFont01) //"Tipo de Saída"
		oPrint:Line((nLinIni + 1298)*nAL+ nLinA4, (nColIni + 2475 + nColA4/2)*nAC, (nLinIni + 1348)*nAL + nLinA4, (nColIni + 2475 + nColA4/2)*nAC)
		oPrint:Line((nLinIni + 1348)*nAL+ nLinA4, (nColIni + 2475 + nColA4/2)*nAC, (nLinIni + 1348)*nAL + nLinA4, (nColIni + 2522 + nColA4/2)*nAC)
		oPrint:Line((nLinIni + 1298)*nAL+ nLinA4, (nColIni + 2522 + nColA4/2)*nAC, (nLinIni + 1348)*nAL + nLinA4, (nColIni + 2522 + nColA4/2)*nAC)
		oPrint:Say((nLinIni + 1303 + nLinA4)*nAL, (nColIni + 2488 + nColA4/2)*nAC, aDados[nX, 48], oFont04)
		oPrint:Say((nLinIni + 1313 + nLinA4)*nAL, (nColIni + 2535 + nColA4/2)*nAC, "1 - "+"Retorno"+"    "+"2 - "+"Retorno SADT"+"    "+"3 - "+"Referência"+"    "+"4 - "+"Internação"+"    "+"5 - "+"Alta"+"    "+"6 - "+"Óbito", oFont01) //"Retorno"###"Retorno SADT"###"Referência"###"Internação"###"Alta"###"Óbito"

		oPrint:Say((nLinIni + 1367 + nLinA4)*nAL , (nColIni + 0010)*nAC, "Consulta Referência", oFont01) //"Consulta Referência"
		oPrint:Box((nLinIni + 1397)*nAL + nLinA4 , (nColIni + 0010)*nAC, (nLinIni + 1491)*nAL + nLinA4, (nColIni + 0315)*nAC)
		oPrint:Say((nLinIni + 1402 + nLinA4)*nAL , (nColIni + 0020)*nAC, "49 - "+"Tipo de Doença", oFont01) //"Tipo de Doença"
		oPrint:Line((nLinIni + 1427)*nAL + nLinA4, (nColIni + 0030)*nAC, (nLinIni + 1477)*nAL + nLinA4, (nColIni + 0030)*nAC)
		oPrint:Line((nLinIni + 1477)*nAL + nLinA4, (nColIni + 0030)*nAC, (nLinIni + 1477)*nAL + nLinA4, (nColIni + 0077)*nAC)
		oPrint:Line((nLinIni + 1427)*nAL + nLinA4, (nColIni + 0077)*nAC, (nLinIni + 1477)*nAL + nLinA4, (nColIni + 0077)*nAC)
		oPrint:Say((nLinIni + 1432  + nLinA4)*nAL, (nColIni + 0043)*nAC, aDados[nX, 49], oFont04)
		oPrint:Say((nLinIni + 1442  + nLinA4)*nAL, (nColIni + 0090)*nAC, "A-Aguda"+"    "+"C-Crônica", oFont01) //"A-Aguda"###"C-Crônica"
		oPrint:Box((nLinIni + 1397)*nAL  + nLinA4, (nColIni + 0320)*nAC, (nLinIni + 1491)*nAL + nLinA4, (nColIni + 0770)*nAC)
		oPrint:Say((nLinIni + 1402  + nLinA4)*nAL, (nColIni + 0330)*nAC, "50 - "+"Tempo de Doença", oFont01) //"Tempo de Doença"
		oPrint:Line((nLinIni + 1427)*nAL + nLinA4, (nColIni + 0340)*nAC, (nLinIni + 1477)*nAL + nLinA4, (nColIni + 0340)*nAC)
		oPrint:Line((nLinIni + 1477)*nAL + nLinA4, (nColIni + 0340)*nAC, (nLinIni + 1477)*nAL + nLinA4, (nColIni + 0426)*nAC)
		oPrint:Line((nLinIni + 1427)*nAL + nLinA4, (nColIni + 0426)*nAC, (nLinIni + 1477)*nAL + nLinA4, (nColIni + 0426)*nAC)
		If aDados[nX,50,1] > 0
			oPrint:Say((nLinIni + 1432 + nLinA4)*nAL, (nColIni + 0353)*nAC, IIF((StrZero(aDados[nX, 50,1], 2, 0))=="00","",(StrZero(aDados[nX, 50,1], 2, 0))), oFont04)
		Endif
		oPrint:Say((nLinIni + 1442 + nLinA4)*nAL, (nColIni + 0434)*nAC, "-", oFont01)
		oPrint:Line((nLinIni+ 1427)*nAL + nLinA4, (nColIni + 0447)*nAC, (nLinIni + 1477)*nAL + nLinA4, (nColIni + 0447)*nAC)
		oPrint:Line((nLinIni+ 1477)*nAL + nLinA4, (nColIni + 0447)*nAC, (nLinIni + 1477)*nAL + nLinA4, (nColIni + 0494)*nAC)
		oPrint:Line((nLinIni+ 1427)*nAL + nLinA4, (nColIni + 0494)*nAC, (nLinIni + 1477)*nAL + nLinA4, (nColIni + 0494)*nAC)
		oPrint:Say((nLinIni + 1432 + nLinA4)*nAL, (nColIni + 0457)*nAC, aDados[nX, 50,2], oFont04)
		oPrint:Say((nLinIni + 1442 + nLinA4)*nAL, (nColIni + 0510)*nAC, "A-Anos"+"  "+"M-Meses"+"  "+"D-Dias", oFont01) //"A-Anos"###"M-Meses"###"D-Dias"

		oPrint:Say((nLinIni + 1478 + nLinA4)*nAL, (nColIni + 0010)*nAC, "Procedimentos e Exames realizados", oFont01) //"Procedimentos e Exames realizados"
		oPrint:Box((nLinIni + 1526)*nAL + nLinA4, (nColIni + 0010)*nAC, (nLinIni + 1766)*nAL + nLinA4, (nColIni + 3745 + nColA4)*nAC)
		oPrint:Say((nLinIni + 1531 + nLinA4)*nAL, (nColIni + 0020)*nAC, "51 - "+"Data", oFont01) //"Data"
		oPrint:Say((nLinIni + 1531 + nLinA4)*nAL, (nColIni + 0210)*nAC, "52 - "+"Hora Inicial", oFont01) //"Hora Inicial"
		oPrint:Say((nLinIni + 1531 + nLinA4)*nAL, (nColIni + 0380)*nAC, "53 - "+"Hora Final", oFont01) //"Hora Final"
		oPrint:Say((nLinIni + 1531 + nLinA4)*nAL, (nColIni + 0540)*nAC, "54 - "+"Tabela", oFont01) //"Tabela"
		oPrint:Say((nLinIni + 1531 + nLinA4)*nAL, (nColIni + 0660)*nAC, "55 - "+"Código do Procedimento", oFont01) //"Código do Procedimento"
		oPrint:Say((nLinIni + 1531 + nLinA4)*nAL, (nColIni + 0940)*nAC, "56 - "+"Descrição", oFont01) //"Descrição"
		oPrint:Say((nLinIni + 1531 + nLinA4)*nAL, (nColIni + 3675)*nAC + nColA4, "57 - "+"Qtde.", oFont01,,,,1) //"Qtde."
		oPrint:Say((nLinIni + 1531 + nLinA4)*nAL, (nColIni + 3795)*nAC + nColA4, "58 - "+"Via", oFont01) //"Via"
		oPrint:Say((nLinIni + 1531 + nLinA4)*nAL, (nColIni + 4040)*nAC + nColA4, "59 - "+"Tec.", oFont01) //"Tec."
		oPrint:Say((nLinIni + 1531 + nLinA4)*nAL, (nColIni + 4260)*nAC + nColA4, "60 - "+"% Red./Acresc.", oFont01,,,,1) //"% Red./Acresc."
		oPrint:Say((nLinIni + 1531 + nLinA4)*nAL, (nColIni + 4500)*nAC + nColA4, "61 - "+"Valor Unitário - R$", oFont01,,,,1) //"Valor Unitário - R$"
		oPrint:Say((nLinIni + 1531 + nLinA4)*nAL, (nColIni + 4745)*nAC + nColA4, "62 - "+"Valor Total - R$", oFont01,,,,1) //"Valor Total - R$"

		nOldLinIni := nLinIni

		if nVolta=1
			nV1:=1
		Endif

		If ExistBlock("PLSGTISS")
			lImpPrc := ExecBlock("PLSGTISS",.F.,.F.,{"02",lImpPrc})
		EndIf

		If lImpPrc

			For nP1 := nV1 To nT1
				if nVolta <> 1
					nN:=nP1-((5*nVolta)-5)
					oPrint:Say((nLinIni + 1566 + nLinA4)*nAL, (nColIni + 0020)*nAC, AllTrim(Str(nN)) + " - ", oFont01)
				else
					oPrint:Say((nLinIni + 1566 + nLinA4)*nAL, (nColIni + 0020)*nAC, AllTrim(Str(nP1)) + " - ", oFont01)
				endif
					oPrint:Say((nLinIni + 1561 + nLinA4)*nAL, (nColIni + 0065)*nAC, IIf(Empty(aDados[nX, 51, nP1]), "", DtoC(aDados[nX, 51, nP1])), oFont04)
				oPrint:Say((nLinIni + 1561 + nLinA4)*nAL, (nColIni + 0210)*nAC, IIf(Empty(aDados[nX, 52, nP1]), "", Transform(aDados[nX, 52, nP1], "@R 99:99")), oFont04)
			 	oPrint:Say((nLinIni + 1561 + nLinA4)*nAL, (nColIni + 0380)*nAC, IIf(Empty(aDados[nX, 53, nP1]), "", Transform(aDados[nX, 53, nP1], "@R 99:99")), oFont04)
				oPrint:Say((nLinIni + 1561 + nLinA4)*nAL, (nColIni + 0540)*nAC, aDados[nX, 54, nP1], oFont04)
				oPrint:Say((nLinIni + 1561 + nLinA4)*nAL, (nColIni + 0660)*nAC, aDados[nX, 55, nP1], oFont04)
				oPrint:Say((nLinIni + 1561 + nLinA4)*nAL, (nColIni + 0940)*nAC, SUBSTR(aDados[nX, 56, nP1],1,51), oFont04)
				oPrint:Say((nLinIni + 1561 + nLinA4)*nAL, (nColIni + 2445 + nColA4)*nAC, IIf(Empty(aDados[nX, 57, nP1]), "", Transform(aDados[nX, 57, nP1], "@E 9999.99")), oFont04,,,,1)
				oPrint:Say((nLinIni + 1561 + nLinA4)*nAL, (nColIni + 2560 + nColA4)*nAC, aDados[nX, 58, nP1], oFont04)
				oPrint:Say((nLinIni + 1561 + nLinA4)*nAL, (nColIni + 2840 + nColA4)*nAC, aDados[nX, 59, nP1], oFont04)
				oPrint:Say((nLinIni + 1561 + nLinA4)*nAL, (nColIni + 3050 + nColA4)*nAC, IIf(Empty(aDados[nX, 60, nP1]), "", Transform(aDados[nX, 60, nP1], "@E 9999.99")), oFont04,,,,1)
				oPrint:Say((nLinIni + 1561 + nLinA4)*nAL, (nColIni + 3240 + nColA4)*nAC, IIf(Empty(aDados[nX, 61, nP1]), "", Transform(aDados[nX, 61, nP1], "@E 99,999,999.99")), oFont04,,,,1)
				oPrint:Say((nLinIni + 1561 + nLinA4)*nAL, (nColIni + 3510 + nColA4)*nAC, IIf(Empty(aDados[nX, 62, nP1]), "", Transform(aDados[nX, 62, nP1], "@E 99,999,999.99")), oFont04,,,,1)
				nLinIni += 40
			Next nP1

		EndIf

		if nT1 < Len(aDados[nX, 55]).or. lImpnovo
			  nV1:=nP1
			  lImpnovo:=.T.
		Endif

		nLinIni := nOldLinIni

		oPrint:Box((nLinIni + 1771)*nAL + nLinA4, (nColIni + 0010)*nAC, (nLinIni + 1971)*nAL + (2*nLinA4), (nColIni + 3745 + nColA4)*nAC)
		oPrint:Say((nLinIni + 1766 + nLinA4)*nAL, (nColIni + 0020)*nAC, "63 - "+"Data e Assinatura de Procedimentos em Série", oFont01) //"Data e Assinatura de Procedimentos em Série"

		nOldColIni := nColIni

		if nVolta=1
			nV2:=1
		Endif

		For nP2 := nV2 To nT2 Step 2
			if nVolta <> 1
				nN:=nP2-((10*nVolta)-10)
				oPrint:Say((nLinIni + 1816 + nLinA4)*nAL, (nColIni + 0030)*nAC, AllTrim(Str(nN)) + " - ", oFont01)
			Else
				oPrint:Say((nLinIni + 1816 + nLinA4)*nAL, (nColIni + 0030)*nAC, AllTrim(Str(nP2)) + " - ", oFont01)
			Endif
			oPrint:Say((nLinIni + 1816 + nLinA4)*nAL, (nColIni + 0070)*nAC, DtoC(aDados[nX, 63, nP2]), oFont04)
			oPrint:Line((nLinIni + 1861)*nAL + nLinA4,(nColIni + 0230)*nAC, (nLinIni + 1861)*nAL + nLinA4, (nColIni + 0757 + nColSoma2)*nAC)
			if nLayout ==1
				nColIni += 727
			Elseif nLayout ==2
				nColIni += 670
			Else
				nColIni += 630
			Endif
		Next nP2

		nColIni := nOldColIni

		nOldColIni := nColIni

		if nVolta=1
			nV2:=1
		Endif

		For nP2 := nV2+1 To nT2+1 Step 2
			if nVolta <> 1
				nN:=nP2-((10*nVolta)-10)
				oPrint:Say((nLinIni + 1890 + (2*nLinA4))*nAL, (nColIni + 0030)*nAC, AllTrim(Str(nN)) + " - ", oFont01)
			Else
				oPrint:Say((nLinIni + 1890 + (2*nLinA4))*nAL, (nColIni + 0030)*nAC, AllTrim(Str(nP2)) + " - ", oFont01)
			Endif
			oPrint:Say((nLinIni + 1890 + (2*nLinA4))*nAL, (nColIni + 0070)*nAC, DtoC(aDados[nX, 63, nP2]), oFont04)
			oPrint:Line((nLinIni + 1945)*nAL + (2*nLinA4),(nColIni + 0230)*nAC, (nLinIni + 1945)*nAL + (2*nLinA4), (nColIni + 0757 + nColSoma2)*nAC)
			if nLayout ==1
				nColIni += 727
			Elseif nLayout ==2
				nColIni += 670
			Else
				nColIni += 630
			Endif
		Next nP2

		nColIni := nOldColIni

	    if nT2 < Len(aDados[nX, 63]).or. lImpnovo
			  nV2:=nP2-1
			  lImpnovo:=.T.
		Endif

		oPrint:Box((nLinIni + 1976)*nAL + (2*nLinA4), (nColIni + 0010)*nAC, (nLinIni + 2136)*nAL + (3*nLinA4), (nColIni + 3745 + nColA4)*nAC)
		oPrint:Say((nLinIni + 1950 + (2*nLinA4))*nAL, (nColIni + 0020)*nAC, "64 - "+"Observação", oFont01) //"Observação"

		If nModulo == 51    //Gestão Hospitalar
			if nVolta=1
				nV1:=1
			Endif

			nLin := 1988
			For nP1 := nV1 To nT1
				if nVolta <> 1
					nN:=nP1-((5*nVolta)-5)
					oPrint:Say((nLinIni + nLin + nLinA4)*nAL, (nColIni + 0020)*nAC, AllTrim(Str(nN)) + " - ", oFont01)
				else
					oPrint:Say((nLinIni + nLin + nLinA4)*nAL, (nColIni + 0020)*nAC, AllTrim(Str(nP1)) + " - ", oFont01)
				endif
				oPrint:Say((nLinIni + nLin + nLinA4)*nAL, (nColIni + 0065)*nAC, aDados[nX, 64, nP1], oFont04)

				nLin += 35
			Next nP1

			if nT1 < Len(aDados[nX, 64]).or. lImpnovo
				  nV1:=nP1
				  lImpnovo:=.T.
			Endif
		Else
			nLin := 1991

			For nI := 1 To MlCount(aDados[nX, 64], 130)
				cObs := MemoLine(aDados[nX, 64], 130, nI)
				oPrint:Say((nLinIni + nLin + (2*nLinA4))*nAL, (nColIni + 0030)*nAC, cObs, oFont04)
				nLin += 35
			Next nI

		Endif
		oPrint:Box((nLinIni + 2141)*nAL + (3*nLinA4), (nColIni + 0010)*nAC			 		, (nLinIni + 2235)*nAL + (3*nLinA4), (nColIni + 0591 + (nColA4/7) )*nAC)
		oPrint:Say((nLinIni + 2159)*nAL + (3*nLinA4), (nColIni + 0020)*nAC				 	, "65 - "+"Total Procedimentos R$", oFont01) //"Total Procedimentos R$"
		oPrint:Say((nLinIni + 2210)*nAL + (3*nLinA4), (nColIni + 0220 + (nColA4/6))*nAC 	, Transform(aDados[nX, 65,nProx], "@E 999,999,999.99"), oFont04,,,,1)
		oPrint:Box((nLinIni + 2141)*nAL + (3*nLinA4), (nColIni + 0596 + (nColA4/7))*nAC	, (nLinIni + 2235)*nAL + (3*nLinA4), (nColIni + 1117 + 2*(nColA4/7))*nAC)
		oPrint:Say((nLinIni + 2159)*nAL + (3*nLinA4), (nColIni + 0606 + (nColA4/7))*nAC	, "66 - "+"Total Taxas e Aluguéis R$", oFont01) //"Total Taxas e Aluguéis R$"
		oPrint:Say((nLinIni + 2210)*nAL + (3*nLinA4), (nColIni + 0806 + 2*(nColA4/6))*nAC	, Transform(aDados[nX, 66,nProx], "@E 999,999,999.99"), oFont04,,,,1)
		oPrint:Box((nLinIni + 2141)*nAL + (3*nLinA4), (nColIni + 1122 + 2*(nColA4/7))*nAC	, (nLinIni + 2235)*nAL + (3*nLinA4), (nColIni + 1643  + 3*(nColA4/7))*nAC)
		oPrint:Say((nLinIni + 2159)*nAL + (3*nLinA4), (nColIni + 1132 + 2*(nColA4/7))*nAC	, "67 - "+"Total Materiais R$", oFont01) //"Total Materiais R$"
		oPrint:Say((nLinIni + 2210)*nAL + (3*nLinA4), (nColIni + 1332 + 3*(nColA4/6))*nAC	, Transform(aDados[nX, 67,nProx], "@E 999,999,999.99"), oFont04,,,,1)
		oPrint:Box((nLinIni + 2141)*nAL + (3*nLinA4), (nColIni + 1648 + 3*(nColA4/7))*nAC	, (nLinIni + 2235)*nAL + (3*nLinA4), (nColIni + 2169 + 4*(nColA4/7) )*nAC)
		oPrint:Say((nLinIni + 2159)*nAL + (3*nLinA4), (nColIni + 1658 + 3*(nColA4/7))*nAC	, "68 - "+"Total Medicamentos R$", oFont01) //"Total Medicamentos R$"
		oPrint:Say((nLinIni + 2210)*nAL + (3*nLinA4), (nColIni + 1858 + 4*(nColA4/6))*nAC	, Transform(aDados[nX, 68,nProx], "@E 999,999,999.99"), oFont04,,,,1)
		oPrint:Box((nLinIni + 2141)*nAL + (3*nLinA4), (nColIni + 2174 + 4*(nColA4/7))*nAC	, (nLinIni + 2235)*nAL + (3*nLinA4), (nColIni + 2695 + 5*(nColA4/7) )*nAC)
		oPrint:Say((nLinIni + 2159)*nAL + (3*nLinA4), (nColIni + 2184 + 4*(nColA4/7))*nAC	, "69 - "+"Total Diárias R$", oFont01) //"Total Diárias R$"
		oPrint:Say((nLinIni + 2210)*nAL + (3*nLinA4), (nColIni + 2384 + 5*(nColA4/6))*nAC	, Transform(aDados[nX, 69,nProx], "@E 999,999,999.99"), oFont04,,,,1)
		oPrint:Box((nLinIni + 2141)*nAL + (3*nLinA4), (nColIni + 2700 + 5*(nColA4/7))*nAC	, (nLinIni + 2235)*nAL + (3*nLinA4), (nColIni + 3221 + 6*(nColA4/7) )*nAC)
		oPrint:Say((nLinIni + 2159)*nAL + (3*nLinA4), (nColIni + 2710 + 5*(nColA4/7))*nAC	, "70 - "+"Total Gases Medicinais R$", oFont01) //"Total Gases Medicinais R$"
		oPrint:Say((nLinIni + 2210)*nAL + (3*nLinA4), (nColIni + 2910 + 6*(nColA4/6))*nAC	, Transform(aDados[nX, 70,nProx], "@E 999,999,999.99"), oFont04,,,,1)
		oPrint:Box((nLinIni + 2141)*nAL + (3*nLinA4), (nColIni + 3226 + 6*(nColA4/7))*nAC	, (nLinIni + 2235)*nAL + (3*nLinA4), (nColIni + 3745  + 7*(nColA4/7))*nAC)
		oPrint:Say((nLinIni + 2159)*nAL + (3*nLinA4), (nColIni + 3236 + 6*(nColA4/7))*nAC	, "71 - "+"Total Geral da Guia R$", oFont01) //"Total Geral da Guia R$"
		oPrint:Say((nLinIni + 2210)*nAL + (3*nLinA4), (nColIni + 3436 + 7*(nColA4/6))*nAC	, Transform(aDados[nX, 71,nProx], "@E 999,999,999.99"), oFont04,,,,1)


		oPrint:Box((nLinIni + 2240)*nAL + (3*nLinA4), (nColIni + 0010)*nAC					, (nLinIni + 2385)*nAL + (4*nLinA4), (nColIni + 0986 + (nColA4/4) )*nAC)
	   	oPrint:Say((nLinIni + 2185 + (4*nLinA4))*nAL, (nColIni + 0020)*nAC 				, "86 - "+"Data e Assinatura do Solicitante", oFont01) //"Data e Assinatura do Solicitante"
		oPrint:Say((nLinIni + 2225 + (4*nLinA4))*nAL, (nColIni + 0030)*nAC 				, DtoC(aDados[nX, 86]), oFont04)
		oPrint:Box((nLinIni + 2240)*nAL + (3*nLinA4), (nColIni + 0991  +(nColA4/4))*nAC	, (nLinIni + 2385)*nAL + (4*nLinA4), (nColIni + 1907 + 2*(nColA4/4) )*nAC)
		oPrint:Say((nLinIni + 2185 + (4*nLinA4))*nAL, (nColIni + 1001  +(nColA4/4))*nAC	, "87 - "+"Data e Assinatura do Responsável pela Autorização", oFont01) //"Data e Assinatura do Responsável pela Autorização"
		oPrint:Say((nLinIni + 2225 + (4*nLinA4))*nAL, (nColIni + 1011  +(nColA4/4))*nAC	, DtoC(aDados[nX, 87]), oFont04)
		oPrint:Box((nLinIni + 2240)*nAL + (3*nLinA4), (nColIni + 1912  +2*(nColA4/4))*nAC	, (nLinIni + 2385)*nAL + (4*nLinA4), (nColIni + 2828 + 3*(nColA4/4) )*nAC)
		oPrint:Say((nLinIni + 2185 + (4*nLinA4))*nAL, (nColIni + 1922  +2*(nColA4/4))*nAC	, "88 - "+"Data e Assinatura do Beneficiário ou Responsável", oFont01) //"Data e Assinatura do Beneficiário ou Responsável"
		oPrint:Say((nLinIni + 2225 + (4*nLinA4))*nAL, (nColIni + 1932  +2*(nColA4/4))*nAC	, DtoC(aDados[nX, 88]), oFont04)
		oPrint:Box((nLinIni + 2240)*nAL + (3*nLinA4), (nColIni + 2833  +3*(nColA4/4))*nAC	, (nLinIni + 2385)*nAL + (4*nLinA4), (nColIni + 3745 + 4*(nColA4/4) )*nAC)
		oPrint:Say((nLinIni + 2185 + (4*nLinA4))*nAL, (nColIni + 2843  +3*(nColA4/4))*nAC	, "89 - "+"Data e Assinatura do Prestador Executante", oFont01) //"Data e Assinatura do Prestador Executante"
		oPrint:Say((nLinIni + 2225 + (4*nLinA4))*nAL, (nColIni + 2853  +3*(nColA4/4))*nAC	, DtoC(aDados[nX, 89]), oFont04)

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
		//³Finaliza a pagina
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
		oPrint:EndPage()
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
		//³Verso da Guia - Inicia uma nova pagina
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
		/*
		oPrint:StartPage()
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Box Principal                                                 ?
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		oPrint:Box((nLinIni + 0000)*nAL, (nColIni + 0000)*nAC, (nLinIni + nLinMax)*nAL, (nColIni + nColMax)*nAC)

		oPrint:Box((nLinIni + 0010)*nAL, (nColIni + 0010)*nAC			, (nLinIni + 0490)*nAL, (nColIni + 3755 + nColA4)*nAC)
		oPrint:Say((nLinIni + 0030)*nAL, (nColIni + 0020)*nAC			, "OPM Solicitados", oFont01) //"OPM Solicitados"
		oPrint:Say((nLinIni + 0065)*nAL, (nColIni + 0020)*nAC			, "72 - "+"Tabela", oFont01) //"Tabela"
		oPrint:Say((nLinIni + 0065)*nAL, (nColIni + 0160)*nAC			, "73 - "+"Código do OPM", oFont01) //"Código do OPM"
		oPrint:Say((nLinIni + 0065)*nAL, (nColIni + 0410)*nAC		 	, "74 - "+"Descrição OPM", oFont01) //"Descrição OPM"
		oPrint:Say((nLinIni + 0065)*nAL, (nColIni + 2400 + nColA4)*nAC	, "75 - "+"Qtde.", oFont01,,,,1) //"Qtde."
		oPrint:Say((nLinIni + 0065)*nAL, (nColIni + 2550 + nColA4)*nAC	, "76 - "+"Fabricante", oFont01) //"Fabricante"
		oPrint:Say((nLinIni + 0065)*nAL, (nColIni + 3530 + nColA4)*nAC	, "77 - "+"Valor Unitário - R$", oFont01,,,,1) //"Valor Unitário - R$"

		nOldLinIni := nLinIni

		if nVolta=1
			nV3:=1
		Endif

		For nP3 := nV3 To nT3
			if nVolta <> 1
				nN:=nP3-((9*nVolta)-9)
				oPrint:Say((nLinIni + 0100)*nAL, (nColIni + 0020)*nAC, AllTrim(Str(nN)) + " - ", oFont01)
			Else
				oPrint:Say((nLinIni + 0100)*nAL, (nColIni + 0020)*nAC, AllTrim(Str(nP3)) + " - ", oFont01)
			Endif
			oPrint:Say((nLinIni + 0100)*nAL, (nColIni + 0065)*nAC			, aDados[nX, 72, nP3], oFont04)
			oPrint:Say((nLinIni + 0100)*nAL, (nColIni + 0160)*nAC			, aDados[nX, 73, nP3], oFont04)
			oPrint:Say((nLinIni + 0100)*nAL, (nColIni + 0410)*nAC			, aDados[nX, 74, nP3], oFont04)
			oPrint:Say((nLinIni + 0100)*nAL, (nColIni + 2400 + nColA4)*nAC	, IIf(Empty(aDados[nX, 75, nP3]), "", Transform(aDados[nX, 75, nP3], "@E 9999.99")), oFont04,,,,1)
			oPrint:Say((nLinIni + 0100)*nAL, (nColIni + 2550 + nColA4)*nAC	, aDados[nX, 76, nP3], oFont04)
			oPrint:Say((nLinIni + 0100)*nAL, (nColIni + 3550 + nColA4)*nAC	, IIf(Empty(aDados[nX, 77, nP3]), "", Transform(aDados[nX, 77, nP3], "@E 999,999,999.99")), oFont04,,,,1)
			nLinIni += 40
		Next nP3

		nLinIni := nOldLinIni

	    if nT3 < Len(aDados[nX, 73]).or. lImpnovo
			  nV3:=nP3
			  lImpnovo:=.T.
		Endif

		oPrint:Box((nLinIni + 0495)*nAL, (nColIni + 0010)*nAC			, (nLinIni + 0990)*nAL, (nColIni + 3755 + nColA4)*nAC)
		oPrint:Say((nLinIni + 0515)*nAL, (nColIni + 0020)*nAC			, "OPM Utilizados", oFont01) //"OPM Utilizados"
		oPrint:Say((nLinIni + 0550)*nAL, (nColIni + 0020)*nAC			, "78 - "+"Tabela", oFont01) //"Tabela"
		oPrint:Say((nLinIni + 0550)*nAL, (nColIni + 0160)*nAC			, "79 - "+"Código do OPM", oFont01) //"Código do OPM"
		oPrint:Say((nLinIni + 0550)*nAL, (nColIni + 0410)*nAC			, "80 - "+"Descrição OPM", oFont01) //"Descrição OPM"
		oPrint:Say((nLinIni + 0550)*nAL, (nColIni + 2400 + nColA4)*nAC	, "81 - "+"Qtde.", oFont01,,,,1) //"Qtde."
		oPrint:Say((nLinIni + 0550)*nAL, (nColIni + 2550 + nColA4)*nAC	, "82 - "+"Código de Barras", oFont01) //"Código de Barras"
		oPrint:Say((nLinIni + 0550)*nAL, (nColIni + 3250 + nColA4)*nAC	, "83 - "+"Valor Unitário - R$", oFont01,,,,1) //"Valor Unitário - R$"
		oPrint:Say((nLinIni + 0550)*nAL, (nColIni + 3560 + nColA4)*nAC	, "84 - "+"Valor Total - R$", oFont01,,,,1) //"Valor Total - R$"

		nOldLinIni := nLinIni

		if nVolta=1
			nV4:=1
		Endif

		For nP4 := nV4 To nT4
			if nVolta <> 1
				nN:=nP4-((9*nVolta)-9)
				oPrint:Say((nLinIni + 0585)*nAL, (nColIni + 0020)*nAC, AllTrim(Str(nN)) + " - ", oFont01)
			Else
				oPrint:Say((nLinIni + 0585)*nAL, (nColIni + 0020)*nAC, AllTrim(Str(nP4)) + " - ", oFont01)
			Endif
			oPrint:Say((nLinIni + 0585)*nAL, (nColIni + 0065)*nAC			, aDados[nX, 78, nP4], oFont04)
			oPrint:Say((nLinIni + 0585)*nAL, (nColIni + 0160)*nAC			, aDados[nX, 79, nP4], oFont04)
			oPrint:Say((nLinIni + 0585)*nAL, (nColIni + 0410)*nAC			, aDados[nX, 80, nP4], oFont04)
			oPrint:Say((nLinIni + 0585)*nAL, (nColIni + 2400 + nColA4)*nAC	, IIf(Empty(aDados[nX, 81, nP4]), "", Transform(aDados[nX, 81, nP4], "@E 9999.99")), oFont04,,,,1)
			oPrint:Say((nLinIni + 0585)*nAL, (nColIni + 2550 + nColA4)*nAC	, aDados[nX, 82, nP4], oFont04)
			oPrint:Say((nLinIni + 0585)*nAL, (nColIni + 3260 + nColA4)*nAC	, IIf(Empty(aDados[nX, 83, nP4]), "", Transform(aDados[nX, 83, nP4], "@E 999,999,999.99")), oFont04,,,,1)
			oPrint:Say((nLinIni + 0585)*nAL, (nColIni + 3540 + nColA4)*nAC	, IIf(Empty(aDados[nX, 84, nP4]), "", Transform(aDados[nX, 84, nP4], "@E 999,999,999.99")), oFont04,,,,1)
			nLinIni += 40
		Next nP4

		nLinIni := nOldLinIni

	    nTotOPM:=nV4

	    if nT4 < Len(aDados[nX, 79]).or. lImpnovo
			  nV4:=nP4
			  lImpnovo:=.T.
		Endif

		oPrint:Box((nLinIni + 1005)*nAL, (nColIni + 3395 + nColA4)*nAC, (nLinIni + 1089)*nAL, (nColIni + 3755 + nColA4)*nAC)
		oPrint:Say((nLinIni + 1025)*nAL, (nColIni + 3405 + nColA4)*nAC, "85 - "+STR0124, oFont01) //"Total OPM R$"
		oPrint:Say((nLinIni + 1055)*nAL, (nColIni + 3555 + nColA4)*nAC, Transform(aDados[nX, 85,nProx], "@E 999,999,999.99"), oFont04,,,,1)
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
		//³Finaliza a pagina
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
	   	oPrint:EndPage()
		*/
	Next nX
EndDo

If lGerTXT .And. !lWeb
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
	//³Imprime Relatorio
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
	oPrint:Print()
Else
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
	//³Visualiza impressao grafica antes de imprimir
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
	oPrint:Print()
EndIf

Return(cFileName)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡ao    ?PLSTISS3  ?Autor ?Luciano Aparecido     ?Data ?08.01.07 ³±?
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡ao ?Estrutura Relatório TISS (Guia Sol. Internaçao)-BOPS 095189 ³±?
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±?Uso      ?SigaPLS                                                     ³±?
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros?aDados - Array com as informações do relat´rio              ³±?
±±?         ?lGerTXT - Define se imprime direto sem passar pela tela 	   ³±?
±±?         ?		 de configuracao/preview do relatorio 		       ³±?
±±?         ?nLayout - Define o formato de papél para impressao:         ³±?
±±?         ?          1 - Formato Ofício II (216x330mm)                 ³±?
±±?         ?          2 - Formato A4 (210x297mm)                        ³±?
±±?         ? 		 3 - Formato Carta (216x279mm)     			       ³±?
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function CABTISS3(aDados, lGerTXT, nLayout, cLogoGH, lMail, lWeb, cPathRelW )
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
	Local oPrint    := Nil
	Local lImpnovo  :=.T.
	Local nVolta    :=0
	Local cFile 	:= GetNewPar("MV_RELT",'\SPOOL\')+'PLSR420N.HTM'
	Local lRet		:= .T.
	Local lOk		:= .T.
	LOCAL cFileName	:= ""
	LOCAL cRel      := "GUICONS"
	LOCAL cPathSrvJ := GETMV("MV_RELT")
	LOCAL nAL		:= 0.25
	LOCAL nAC		:= 0.24
	Local lImpPrc   := .T.

	DEFAULT lGerTXT 	:= .F.
	DEFAULT nLayout 	:= 2
	DEFAULT cLogoGH 	:= ""
	DEFAULT lMail		:= .F.
	DEFAULT lWeb		:= .F.
	DEFAULT cPathRelW 	:= ""
	DEFAULT aDados 	:= { { ;
						"123456",;
						"12345678901234567892",;
						CtoD("01/01/07"),;
						"12345678901234567892",;
						CtoD("01/01/07"),;
						CtoD("01/01/07"),;
						"12345678901234567892",;
						Replicate("M",40),;
						CtoD("12/12/07"),;
						Replicate("M",70),;
						"123456789102345",;
						"14.141.114/00001-35",;
						Replicate("M",70),;
						"1234567",;
						Replicate("M",70),;
						"1234567",;
						"123456789102345",;
						"ES",;
						"12345",;
						"14.141.114/00001-35",;
						Replicate("M",70),;
						"U",;
						"1",;
						"1",;
						999,;
						Replicate("M",500),;
						"A",;
						{ 12,"M" },;
						"0",;
						"12345",;
						"22345",;
						"32345",;
						"42345",;
						{ "10","20","30","40","50" },;
						{ "1234567890","2345678901","3456789012","4567890123","5678901234" },;
						{ Replicate("M",60),Replicate("A",60),Replicate("B",60),Replicate("C",60),Replicate("D",60) },;
						{ 01,02,03,04,99 },;
						{ 05,06,07,08,09 },;
						{ "10","20","30","40","50" },;
						{ "1234567890","2345678901","3456789012","4567890123","5678901234" },;
						{ Replicate("M",60),Replicate("B",60),Replicate("C",60),Replicate("D",60),Replicate("E",60) },;
						{ 99,99,99,99,99 },;
						{ Replicate("M",40),Replicate("B",40),Replicate("C",40),Replicate("D",40),Replicate("E",40) },;
						{ 199999999.99,999999999.99,299999999.99,3.99,49.99 },;
						CtoD("12/01/06"),;
						999,;
						{ "01", "APARTAMENTO" },;
						"14.141.114/00001-35",;
						Replicate("M",70),;
						"1234567",;
						Replicate("M",240),;
						CtoD("12/01/06"),;
						CtoD("12/02/06"),;
						CtoD("12/02/06"),;
						{ CtoD("12/01/06"),CtoD("12/02/06"),CtoD("12/03/06") },;
						{ "12345678910234567892","23456789102345678921","34567891023456789212" },;
						{ Replicate("M",70),Replicate("B",70),Replicate("C",70) },;
						{ "01","02","03" },;
						{ Replicate("M",40),Replicate("B",40),Replicate("C",40) },;
						{ 01,02,99 },;
						{ { "01","02" },{ "03","04" },{ "05","06" } },;
						{ { "1234567891","2345678911" },{ "3456789112","4567891123" },{ "5678911234","6789112345" } },;
						{ { Replicate("M",60),Replicate("A",60) },{ Replicate("B",60),Replicate("C",60) },{ Replicate("D",60),Replicate("E",60) } },;
						{ { 01,02 },{ 03,04 },{ 05,06 } },;
						{ { 07,08 },{ 09,10 },{ 11,99 } },;
						{ { "01","02" },{ "03","04" },{ "05","06" } },;
						{ { "1234567891","2345678911" },{ "3456789112","4567891123" },{ "5678911234","6789112345" } },;
						{ { Replicate("M",60),Replicate("A",60) },{ Replicate("B",60),Replicate("C",60) },{ Replicate("D",60),Replicate("E",60) } },;
						{ { 07,08 },{ 09,10 },{ 11,99 } },;
						{ { Replicate("F",40),Replicate("G",40) },{ Replicate("H",40),Replicate("I",40) },{ Replicate("J",40),Replicate("K",40) } },;
						{ { 199999.99, 299999.99 },{ 399999.99, 499999.99 },{ 599999.99, 999999.99 } } } }

	If nLayout  == 1 // Ofício 2
	 	nLinMax	:=	3705	// Numero maximo de Linhas (31,5 cm)
		nColMax	:=	2400	// Numero maximo de Colunas (21 cm)
	Elseif nLayout == 2   // Papél A4
	   	nLinMax	:=	3225
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

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
	//?Nao permite acionar a impressao quando for na web.
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
	If lWeb
		cPathSrvJ := cPathRelW
		cFileName := cRel+CriaTrab(NIL,.F.)+".pdf"
	Else
		cFileName := cRel+CriaTrab(NIL,.F.)
	EndIf

	//						New ( < cFilePrintert >, [ nDevice], [ lAdjustToLegacy], [ cPathInServer], [ lDisabeSetup ], [ lTReport], [ @oPrintSetup], [ cPrinter], [ lServer], [ lPDFAsPNG], [ lRaw], [ lViewPDF] )
	If !lWeb
	oPrint := FWMSPrinter():New ( cFileName			,			,	.F.				,cPathSrvJ	 	,	.T.				,			 ,				,			  ,			  ,	.F.			, 		, 				)
	Else
		oPrint := FWMSPrinter():New ( cFileName	,,.F.,cPathSrvJ	 ,.T.,	,@oPrint,			  ,			  ,	.F.			,.f.)
		If lSrvUnix
			AjusPath(@oPrint)
		EndIf
	EndIf
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
	//³Tratamento para impressao via job
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
	//oPrint:lInJob  := lWeb
	oPrint:lServer := lWeb
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
	//?Caminho do arquivo
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
	oPrint:cPathPDF := cPathSrvJ

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
	//³Modo retrato
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
	oPrint:SetPortrait()	// Modo retrato

	If nLayout ==2
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
		//³Papél A4
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
		oPrint:SetPaperSize(9)
	ElseIf nLayout ==3
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
		//³Papél Carta
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
		oPrint:SetPaperSize(1)
	Else
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
		//³Papel Oficio2 216 x 330mm / 8 1/2 x 13in
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
		oPrint:SetPaperSize(14)
	Endif

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
	//³Device
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
	If lWeb
		oPrint:setDevice(IMP_PDF)
		oPrint:lPDFAsPNG := .T.
	EndIf
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
	//³Verifica se existe alguma impressora configurada para Impressao Grafica
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
	If  !lWeb
		oPrint:Setup()
		If (oPrint:nModalResult == 2)
			lRet := .F.
			lMail := .F.
			Return()
		Else
			lImpnovo:=(oPrint:nModalResult == 1)
		Endif
	EndIf


While lImpnovo

	lImpnovo:=.F.
	nVolta  += 1
	nT      += 5
	nT1     += 2
	nT3     += 3


	For nX := 1 To Len(aDados)

		If ValType(aDados[nX]) == 'U' .OR. Len(aDados[nX]) == 0
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

		For nI := 39 To 44
			If Len(aDados[nX, nI]) < nT
				For nJ := Len(aDados[nX, nI]) + 1 To nT
					If AllTrim(Str(nI)) $ "42,44"
						aAdd(aDados[nX, nI], 0)
					Else
						aAdd(aDados[nX, nI], "")
					EndIf
				Next nJ
			EndIf
		Next nI

		For nI := 55 To 71
			If Len(aDados[nX, nI]) < nT3
				For nJ := Len(aDados[nX, nI]) + 1 To nT3
					If AllTrim(Str(nI)) $ "55"
						aAdd(aDados[nX, nI], StoD(""))
					ElseIf AllTrim(Str(nI)) $ "60"
						aAdd(aDados[nX, nI], 0)
					ElseIf AllTrim(Str(nI)) $ "56,57,58,59"
						aAdd(aDados[nX, nI], "")
					Else
						aAdd(aDados[nX, nI], {})
					EndIf
				Next nJ
			EndIf
		Next nI

		For nI := 61 To 71
			For nK := 1 To nT3
				If Len(aDados[nX, nI, nK]) < nT1
					For nJ := Len(aDados[nX, nI, nK]) + 1 To nT1
						If AllTrim(Str(nI)) $ "64,65,69,71"
							aAdd(aDados[nX, nI, nK], 0)
						Else
							aAdd(aDados[nX, nI, nK], "")
						EndIf
					Next nJ
				EndIf
			Next nK
		Next nI

		If oPrint:Cprinter == "PDF" .OR. lWeb
			nLinIni	:= 150
		Else
			nLinIni := 000
		Endif

		nColIni := 000
		nColA4  := 000
		nLinA4  := 000

		oPrint:StartPage()		// Inicia uma nova pagina

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Box Principal                                                 ?
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		oPrint:Box((nLinIni + 0000)*nAL, (nColIni + 0000)*nAC, (nLinIni + nLinMax)*nAL, (nColIni + nColMax)*nAC)

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Carrega e Imprime Logotipo da Empresa                         ?
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

		oPrint:Say((nLinIni + 0120)*nAL, (nColIni + 0975 + nColA4)*nAC, "GUIA DE SOLICITAÇÃO", oFont02n,,,, 2) //"GUIA DE SOLICITAÇÃO"
		oPrint:Say((nLinIni + 0170)*nAL, (nColIni + 1030 + nColA4)*nAC, "DE INTERNAÇÃO", oFont02n,,,, 2) //"DE INTERNAÇÃO"
		oPrint:Say((nLinIni + 0120)*nAL, (nColIni + 1705 + nColA4)*nAC, "2 - "+OemToAnsi("Nº"), oFont01) //"N?
		oPrint:Say((nLinIni + 0120)*nAL, (nColIni + 1801 + nColA4)*nAC, aDados[nX, 02], oFont03n)

		nLinIni+= 150
		oPrint:Box((nLinIni + 0155)*nAL, (nColIni + 0010)*nAC, (nLinIni + 0249)*nAL, (nColIni + 0315)*nAC)
		oPrint:Say((nLinIni + 0180)*nAL, (nColIni + 0020)*nAC, "1 - "+"Registro ANS", oFont01) //"Registro ANS"
		oPrint:Say((nLinIni + 0220)*nAL, (nColIni + 0030)*nAC, aDados[nX, 01], oFont04)
		oPrint:Box((nLinIni + 0155)*nAL, (nColIni + 0320)*nAC, (nLinIni + 0249)*nAL, (nColIni + 0625)*nAC)
		oPrint:Say((nLinIni + 0180)*nAL, (nColIni + 0330)*nAC, "3 - "+"Data da Autorização", oFont01) //"Data da Autorização"
		oPrint:Say((nLinIni + 0220)*nAL, (nColIni + 0340)*nAC, DtoC(aDados[nX, 03]), oFont04)
		oPrint:Box((nLinIni + 0155)*nAL, (nColIni + 0630)*nAC, (nLinIni + 0249)*nAL, (nColIni + 1035)*nAC)
		oPrint:Say((nLinIni + 0180)*nAL, (nColIni + 0640)*nAC, "4 - "+"Senha", oFont01) //"Senha"
		oPrint:Say((nLinIni + 0220)*nAL, (nColIni + 0650)*nAC, aDados[nX, 04], oFont04)
		oPrint:Box((nLinIni + 0155)*nAL, (nColIni + 1040)*nAC, (nLinIni + 0249)*nAL, (nColIni + 1445)*nAC)
		oPrint:Say((nLinIni + 0180)*nAL, (nColIni + 1050)*nAC, "5 - "+"Data Validade da Senha", oFont01) //"Data Validade da Senha"
		oPrint:Say((nLinIni + 0220)*nAL, (nColIni + 1060)*nAC, DtoC(aDados[nX, 05]), oFont04)
		oPrint:Box((nLinIni + 0155)*nAL, (nColIni + 1450)*nAC, (nLinIni + 0249)*nAL, (nColIni + 1745)*nAC)
		oPrint:Say((nLinIni + 0180)*nAL, (nColIni + 1460)*nAC, "6 - "+"Data de Emissão da Guia", oFont01) //"Data de Emissão da Guia"
		oPrint:Say((nLinIni + 0220)*nAL, (nColIni + 1470)*nAC, DtoC(aDados[nX, 06]), oFont04)

		nLinIni += 20
		oPrint:Say((nLinIni + 0274)*nAL, (nColIni + 0010)*nAC, "Dados do Beneficiário", oFont01) //"Dados do Beneficiário"
		oPrint:Box((nLinIni + 0284)*nAL, (nColIni + 0010)*nAC, (nLinIni + 0378)*nAL, (nColIni + 0425)*nAC)
		oPrint:Say((nLinIni + 0309)*nAL, (nColIni + 0020)*nAC, "7 - "+"Número da Carteira", oFont01) //"Número da Carteira"
		oPrint:Say((nLinIni + 0349)*nAL, (nColIni + 0030)*nAC, aDados[nX, 07], oFont04)
		oPrint:Box((nLinIni + 0284)*nAL, (nColIni + 0430)*nAC, (nLinIni + 0378)*nAL, (nColIni + 1542)*nAC)
		oPrint:Say((nLinIni + 0309)*nAL, (nColIni + 0440)*nAC, "8 - "+"Plano", oFont01) //"Plano"
		oPrint:Say((nLinIni + 0349)*nAL, (nColIni + 0450)*nAC, aDados[nX, 08], oFont04)
		oPrint:Box((nLinIni + 0284)*nAL, (nColIni + 1547)*nAC, (nLinIni + 0378)*nAL, (nColIni + 1835)*nAC)
		oPrint:Say((nLinIni + 0309)*nAL, (nColIni + 1557)*nAC, "9 - "+"Validade da Carteira", oFont01) //"Validade da Carteira"
		oPrint:Say((nLinIni + 0349)*nAL, (nColIni + 1567)*nAC, DtoC(aDados[nX, 09]), oFont04)

		oPrint:Box((nLinIni + 0383)*nAL, (nColIni + 0010)*nAC, (nLinIni + 0477)*nAL, (nColIni + 1965 + nColA4)*nAC)
		oPrint:Say((nLinIni + 0407)*nAL, (nColIni + 0020)*nAC, "10 - "+"Nome", oFont01) //"Nome"
		oPrint:Say((nLinIni + 0447)*nAL, (nColIni + 0030)*nAC, aDados[nX, 10], oFont04)
		oPrint:Box((nLinIni + 0383)*nAL, (nColIni + 1970 + nColA4)*nAC, (nLinIni + 0477)*nAL, (nColIni + 2390 + nColA4)*nAC)
		oPrint:Say((nLinIni + 0407)*nAL, (nColIni + 1980 + nColA4)*nAC, "11 - "+"Número do Cartão Nacional de Saúde", oFont01) //"Número do Cartão Nacional de Saúde"
		oPrint:Say((nLinIni + 0447)*nAL, (nColIni + 1990 + nColA4)*nAC, aDados[nX, 11], oFont04)

		nLinIni += 20
		oPrint:Say((nLinIni + 0502)*nAL, (nColIni + 0010)*nAC, "Dados do Contratado Solicitante", oFont01) //"Dados do Contratado Solicitante"
		oPrint:Box((nLinIni + 0512)*nAL, (nColIni + 0010)*nAC, (nLinIni + 0606)*nAL, (nColIni + 0426)*nAC)
		oPrint:Say((nLinIni + 0537)*nAL, (nColIni + 0020)*nAC, "12 - "+"Código na Operadora / CNPJ / CPF", oFont01) //"Código na Operadora / CNPJ / CPF"
		oPrint:Say((nLinIni + 0577)*nAL, (nColIni + 0030)*nAC, aDados[nX, 12], oFont04)
		oPrint:Box((nLinIni + 0512)*nAL, (nColIni + 0431)*nAC, (nLinIni + 0606)*nAL, (nColIni + 2175 + nColA4)*nAC)
		oPrint:Say((nLinIni + 0537)*nAL, (nColIni + 0441)*nAC, "13 - "+"Nome do Contratado", oFont01) //"Nome do Contratado"
		oPrint:Say((nLinIni + 0577)*nAL, (nColIni + 0451)*nAC, SubStr(aDados[nX, 13], 1, 65), oFont04)
		oPrint:Box((nLinIni + 0512)*nAL, (nColIni + 2180 + nColA4)*nAC, (nLinIni + 0606)*nAL, (nColIni + 2390 + nColA4)*nAC)
		oPrint:Say((nLinIni + 0537)*nAL, (nColIni + 2190 + nColA4)*nAC, "14 - "+"Código CNES", oFont01) //"Código CNES"
		oPrint:Say((nLinIni + 0577)*nAL, (nColIni + 2200 + nColA4)*nAC, aDados[nX, 14], oFont04)

		oPrint:Box((nLinIni + 0611)*nAL, (nColIni + 0010)*nAC, (nLinIni + 0705)*nAL, (nColIni + 1459 + nColA4)*nAC)
		oPrint:Say((nLinIni + 0636)*nAL, (nColIni + 0020)*nAC, "15 - "+"Nome do Profissional Solicitante", oFont01) //"Nome do Profissional Solicitante"
		oPrint:Say((nLinIni + 0676)*nAL, (nColIni + 0030)*nAC, SubStr(aDados[nX, 15], 1, 55), oFont04)
		oPrint:Box((nLinIni + 0611)*nAL, (nColIni + 1464 + nColA4)*nAC, (nLinIni + 0705)*nAL, (nColIni + 1737 + nColA4)*nAC)
		oPrint:Say((nLinIni + 0636)*nAL, (nColIni + 1474 + nColA4)*nAC, "16 - "+"Conselho Profissional", oFont01) //"Conselho Profissional"
		oPrint:Say((nLinIni + 0676)*nAL, (nColIni + 1484 + nColA4)*nAC, aDados[nX, 16], oFont04)
		oPrint:Box((nLinIni + 0611)*nAL, (nColIni + 1742 + nColA4)*nAC, (nLinIni + 0705)*nAL, (nColIni + 2056 + nColA4)*nAC)
		oPrint:Say((nLinIni + 0636)*nAL, (nColIni + 1752 + nColA4)*nAC, "17 - "+"Número no Conselho", oFont01) //"Número no Conselho"
		oPrint:Say((nLinIni + 0676)*nAL, (nColIni + 1762 + nColA4)*nAC, aDados[nX, 17], oFont04)
		oPrint:Box((nLinIni + 0611)*nAL, (nColIni + 2061 + nColA4)*nAC, (nLinIni + 0705)*nAL, (nColIni + 2160 + nColA4)*nAC)
		oPrint:Say((nLinIni + 0636)*nAL, (nColIni + 2071 + nColA4)*nAC, "18 - "+"UF", oFont01) //"UF"
		oPrint:Say((nLinIni + 0676)*nAL, (nColIni + 2081 + nColA4)*nAC, aDados[nX, 18], oFont04)
		oPrint:Box((nLinIni + 0611)*nAL, (nColIni + 2165 + nColA4)*nAC, (nLinIni + 0705)*nAL, (nColIni + 2390 + nColA4)*nAC)
		oPrint:Say((nLinIni + 0636)*nAL, (nColIni + 2175 + nColA4)*nAC, "19 - "+"Código CBO S", oFont01) //"Código CBO S"
		oPrint:Say((nLinIni + 0676)*nAL, (nColIni + 2185 + nColA4)*nAC, aDados[nX, 19], oFont04)

		nLinIni += 20
		oPrint:Say((nLinIni + 0730)*nAL, (nColIni + 0010)*nAC, "Dados do Contratado Solicitante / Dados da Internação", oFont01) //"Dados do Contratado Solicitante / Dados da Internação"
		oPrint:Box((nLinIni + 0740)*nAL, (nColIni + 0010)*nAC, (nLinIni + 0834)*nAL, (nColIni + 0426)*nAC)
		oPrint:Say((nLinIni + 0765)*nAL, (nColIni + 0020)*nAC, "20 - "+"Código na Operadora / CNPJ", oFont01) //"Código na Operadora / CNPJ"
		oPrint:Say((nLinIni + 0805)*nAL, (nColIni + 0030)*nAC, aDados[nX, 20], oFont04)
		oPrint:Box((nLinIni + 0740)*nAL, (nColIni + 0431)*nAC, (nLinIni + 0834)*nAL, (nColIni + 2390 + nColA4)*nAC)
		oPrint:Say((nLinIni + 0765)*nAL, (nColIni + 0441)*nAC, "21 - "+"Nome do Prestador", oFont01) //"Nome do Prestador"
		oPrint:Say((nLinIni + 0805)*nAL, (nColIni + 0451)*nAC, SubStr(aDados[nX, 21], 1, 65), oFont04)

		oPrint:Box((nLinIni + 0839)*nAL, (nColIni + 0010)*nAC, (nLinIni + 0933)*nAL, (nColIni + 0465)*nAC)
		oPrint:Say((nLinIni + 0864)*nAL, (nColIni + 0020)*nAC, "22 - "+"Caráter da Internação", oFont01) //"Caráter da Internação"
		oPrint:Line((nLinIni+ 0869)*nAL, (nColIni + 0030)*nAC, (nLinIni + 0916)*nAL, (nColIni + 0030)*nAC)
		oPrint:Line((nLinIni+ 0916)*nAL, (nColIni + 0030)*nAC, (nLinIni + 0916)*nAL, (nColIni + 0077)*nAC)
		oPrint:Line((nLinIni+ 0869)*nAL, (nColIni + 0077)*nAC, (nLinIni + 0916)*nAL, (nColIni + 0077)*nAC)
		oPrint:Say((nLinIni + 0904)*nAL, (nColIni + 0043)*nAC, aDados[nX, 22], oFont04)
		oPrint:Say((nLinIni + 0904)*nAL, (nColIni + 0090)*nAC, "E - Eletiva"+"  "+"U - Urgência/Emergência", oFont01) //"E - Eletiva"###"U - Urgência/Emergência"
		oPrint:Box((nLinIni + 0839)*nAL, (nColIni + 0470)*nAC, (nLinIni + 0933)*nAL, (nColIni + 2000)*nAC)
		oPrint:Say((nLinIni + 0864)*nAL, (nColIni + 0480)*nAC, "23 - "+"Tipo de Internação", oFont01) //"Tipo de Internação"
		oPrint:Line((nLinIni+ 0869)*nAL, (nColIni + 0490)*nAC, (nLinIni + 0916)*nAL, (nColIni + 0490)*nAC)
		oPrint:Line((nLinIni+ 0916)*nAL, (nColIni + 0490)*nAC, (nLinIni + 0916)*nAL, (nColIni + 0537)*nAC)
		oPrint:Line((nLinIni+ 0869)*nAL, (nColIni + 0537)*nAC, (nLinIni + 0916)*nAL, (nColIni + 0537)*nAC)
		oPrint:Say((nLinIni + 0904)*nAL, (nColIni + 0503)*nAC, aDados[nX, 23], oFont04)
		oPrint:Say((nLinIni + 0904)*nAL, (nColIni + 0550)*nAC, "1 - "+"Clínica"+"    "+"2 - "+"Cirúrgica"+"    "+"3 - "+OemToAnsi("Obstétrica")+"    "+"4 - "+OemToAnsi("Pediátrica")+"    "+"5 - "+OemToAnsi("Psiquiátrica"), oFont01) //"Clínica"###"Cirúrgica"###"Obstétrica"###"Pediátrica"###"Psiquiátrica"

		oPrint:Box((nLinIni + 0938)*nAL, (nColIni + 0010)*nAC, (nLinIni + 1032)*nAL, (nColIni + 0635)*nAC)
		oPrint:Say((nLinIni + 0963)*nAL, (nColIni + 0020)*nAC, "24 - "+"Regime de Internação", oFont01) //"Regime de Internação"
		oPrint:Line((nLinIni+ 0968)*nAL, (nColIni + 0030)*nAC, (nLinIni + 1015)*nAL, (nColIni + 0030)*nAC)
		oPrint:Line((nLinIni+ 1015)*nAL, (nColIni + 0030)*nAC, (nLinIni + 1015)*nAL, (nColIni + 0077)*nAC)
		oPrint:Line((nLinIni+ 0968)*nAL, (nColIni + 0077)*nAC, (nLinIni + 1015)*nAL, (nColIni + 0077)*nAC)
		oPrint:Say((nLinIni + 1003)*nAL, (nColIni + 0043)*nAC, aDados[nX, 24], oFont04)
		oPrint:Say((nLinIni + 1003)*nAL, (nColIni + 0090)*nAC, "1 - "+"Hospitalar"+"    "+"2 - "+"Hospital-dia"+"    "+"3 - "+"Domiciliar", oFont01) //"Hospitalar"###"Hospital-dia"###"Domiciliar"
		oPrint:Box((nLinIni + 0938)*nAL, (nColIni + 0640)*nAC, (nLinIni + 1032)*nAL, (nColIni + 0940)*nAC)
		oPrint:Say((nLinIni + 0963)*nAL, (nColIni + 0650)*nAC, "25 - "+"Qtde. Diárias Solicitadas", oFont01) //"Qtde. Diárias Solicitadas"
		oPrint:Say((nLinIni + 1003)*nAL, (nColIni + 0810)*nAC, Transform(aDados[nX, 25], "@E 9999.99"), oFont04,,,,1)

		oPrint:Box((nLinIni + 1037)*nAL, (nColIni + 0010)*nAC, (nLinIni + 1329)*nAL, (nColIni + 2390 + nColA4)*nAC)
		oPrint:Say((nLinIni + 1067)*nAL, (nColIni + 0020)*nAC, "26 - "+"Indicação Clínica", oFont01) //"Indicação Clínica"
		nLin := 1112

		For nI := 1 To MlCount(aDados[nX, 26], 79)
			cObs := MemoLine(aDados[nX, 26], 79, nI)
			oPrint:Say((nLinIni + nLin)*nAL, (nColIni + 0030)*nAC, cObs, oFont04)
			nLin += 35
		Next nI

		nLinIni += 20
		oPrint:Say((nLinIni + 1354)*nAL, (nColIni + 0010)*nAC, "Hipóteses Diagnósticas", oFont01) //"Hipóteses Diagnósticas"
		oPrint:Box((nLinIni + 1364)*nAL, (nColIni + 0010)*nAC, (nLinIni + 1458)*nAL, (nColIni + 0315)*nAC)
		oPrint:Say((nLinIni + 1389)*nAL, (nColIni + 0020)*nAC, "27 - "+"Tipo Doença", oFont01) //"Tipo Doença"
		oPrint:Line((nLinIni+ 1394)*nAL, (nColIni + 0030)*nAC, (nLinIni + 1441)*nAL, (nColIni + 0030)*nAC)
		oPrint:Line((nLinIni+ 1441)*nAL, (nColIni + 0030)*nAC, (nLinIni + 1441)*nAL, (nColIni + 0077)*nAC)
		oPrint:Line((nLinIni+ 1394)*nAL, (nColIni + 0077)*nAC, (nLinIni + 1441)*nAL, (nColIni + 0077)*nAC)
		oPrint:Say((nLinIni + 1429)*nAL, (nColIni + 0043)*nAC, aDados[nX, 27], oFont04)
		oPrint:Say((nLinIni + 1429)*nAL, (nColIni + 0090)*nAC, "A-Aguda"+"    "+"C-Crônica", oFont01) //"A-Aguda"###"C-Crônica"
		oPrint:Box((nLinIni + 1364)*nAL, (nColIni + 0320)*nAC, (nLinIni + 1458)*nAL, (nColIni + 0795)*nAC)
		oPrint:Say((nLinIni + 1389)*nAL, (nColIni + 0330)*nAC, "28 - "+"Tempo de Doença Referida pelo Paciente", oFont01) //"Tempo de Doença Referida pelo Paciente"
		oPrint:Line((nLinIni+ 1394)*nAL, (nColIni + 0340)*nAC, (nLinIni + 1441)*nAL, (nColIni + 0340)*nAC)
		oPrint:Line((nLinIni+ 1441)*nAL, (nColIni + 0340)*nAC, (nLinIni + 1441)*nAL, (nColIni + 0426)*nAC)
		oPrint:Line((nLinIni+ 1394)*nAL, (nColIni + 0426)*nAC, (nLinIni + 1441)*nAL, (nColIni + 0426)*nAC)
		oPrint:Say((nLinIni + 1429)*nAL, (nColIni + 0353)*nAC, IIF((StrZero(aDados[nX, 28,1], 2, 0))=="00","",(StrZero(aDados[nX, 28,1], 2, 0))), oFont04)
		oPrint:Say((nLinIni + 1424)*nAL, (nColIni + 0434)*nAC, "-", oFont01)
		oPrint:Line((nLinIni+ 1394)*nAL, (nColIni + 0447)*nAC, (nLinIni + 1441)*nAL, (nColIni + 0447)*nAC)
		oPrint:Line((nLinIni+ 1441)*nAL, (nColIni + 0447)*nAC, (nLinIni + 1441)*nAL, (nColIni + 0494)*nAC)
		oPrint:Line((nLinIni+ 1394)*nAL, (nColIni + 0494)*nAC, (nLinIni + 1441)*nAL, (nColIni + 0494)*nAC)
		oPrint:Say((nLinIni + 1429)*nAL, (nColIni + 0457)*nAC, aDados[nX, 28, 2], oFont04)
		oPrint:Say((nLinIni + 1429)*nAL, (nColIni + 0510)*nAC, "A-Anos"+"  "+"M-Meses"+"  "+"D-Dias", oFont01) //"A-Anos"###"M-Meses"###"D-Dias"
		oPrint:Box((nLinIni + 1364)*nAL, (nColIni + 0800)*nAC, (nLinIni + 1458)*nAL, (nColIni + 1807)*nAC)
		oPrint:Say((nLinIni + 1389)*nAL, (nColIni + 0810)*nAC, "29 - "+"Indicação de Acidente", oFont01) //"Indicação de Acidente"
		oPrint:Line((nLinIni+ 1394)*nAL, (nColIni + 0820)*nAC, (nLinIni + 1441)*nAL, (nColIni + 0820)*nAC)
		oPrint:Line((nLinIni+ 1441)*nAL, (nColIni + 0820)*nAC, (nLinIni + 1441)*nAL, (nColIni + 0862)*nAC)
		oPrint:Line((nLinIni+ 1394)*nAL, (nColIni + 0862)*nAC, (nLinIni + 1441)*nAL, (nColIni + 0862)*nAC)
		oPrint:Say((nLinIni + 1429)*nAL, (nColIni + 0833)*nAC, aDados[nX, 29], oFont04)
		oPrint:Say((nLinIni + 1429)*nAL, (nColIni + 0880)*nAC, "0 - "+"Acidente ou doença relacionada ao Trabalho"+"     "+"1 - "+"Trânsito"+"     "+"2 - "+"Outros", oFont01) //"Acidente ou doença relacionada ao Trabalho"###"Trânsito"###"Outros"

		oPrint:Box((nLinIni + 1463)*nAL, (nColIni + 0010)*nAC, (nLinIni + 1557)*nAL, (nColIni + 0285)*nAC)
		oPrint:Say((nLinIni + 1492)*nAL, (nColIni + 0020)*nAC, "30 - "+"CID 10 Principal", oFont01) //"CID 10 Principal"
		oPrint:Say((nLinIni + 1532)*nAL, (nColIni + 0030)*nAC, aDados[nX, 30], oFont04)
		oPrint:Box((nLinIni + 1463)*nAL, (nColIni + 0290)*nAC, (nLinIni + 1557)*nAL, (nColIni + 0565)*nAC)
		oPrint:Say((nLinIni + 1492)*nAL, (nColIni + 0300)*nAC, "31 - "+"CID 10 (2)", oFont01) //"CID 10 (2)"
		oPrint:Say((nLinIni + 1532)*nAL, (nColIni + 0310)*nAC, aDados[nX, 31], oFont04)
		oPrint:Box((nLinIni + 1463)*nAL, (nColIni + 0570)*nAC, (nLinIni + 1557)*nAL, (nColIni + 0845)*nAC)
		oPrint:Say((nLinIni + 1492)*nAL, (nColIni + 0580)*nAC, "32 - "+"CID 10 (3)", oFont01) //"CID 10 (3)"
		oPrint:Say((nLinIni + 1532)*nAL, (nColIni + 0590)*nAC, aDados[nX, 32], oFont04)
		oPrint:Box((nLinIni + 1463)*nAL, (nColIni + 0850)*nAC, (nLinIni + 1557)*nAL, (nColIni + 1115)*nAC)
		oPrint:Say((nLinIni + 1492)*nAL, (nColIni + 0860)*nAC, "33 - "+"CID 10 (4)", oFont01) //"CID 10 (4)"
		oPrint:Say((nLinIni + 1532)*nAL, (nColIni + 0870)*nAC, aDados[nX, 33], oFont04)

		nLinIni += 20
		oPrint:Say((nLinIni + 1582)*nAL, (nColIni + 0010)*nAC, "Procedimentos Solicitados", oFont01) //"Procedimentos Solicitados"
		oPrint:Box((nLinIni + 1592)*nAL, (nColIni + 0010)*nAC, (nLinIni + 1867)*nAL, (nColIni + 2390 + nColA4)*nAC)
		oPrint:Say((nLinIni + 1617)*nAL, (nColIni + 0020)*nAC, "34 - "+"Tabela", oFont01) //"Tabela"
		oPrint:Say((nLinIni + 1617)*nAL, (nColIni + 0150)*nAC, "35 - "+"Código do Procedimento", oFont01) //"Código do Procedimento"
		oPrint:Say((nLinIni + 1617)*nAL, (nColIni + 0450)*nAC, "36 - "+"Descrição", oFont01) //"Descrição"
		oPrint:Say((nLinIni + 1617)*nAL, (nColIni + 2000 + nColA4)*nAC, "37 - "+"Qtde.Solict", oFont01,,,,1) //"Qtde.Solict"
		oPrint:Say((nLinIni + 1617)*nAL, (nColIni + 2210 + nColA4)*nAC, "38 - "+"Qtde.Aut", oFont01,,,,1) //"Qtde.Aut"

		nOldLinIni := nLinIni

		if nVolta=1
			nV1:=1
		Endif

		If ExistBlock("PLSGTISS")
			lImpPrc := ExecBlock("PLSGTISS",.F.,.F.,{"03",lImpPrc})
		EndIf

		If lImpPrc

			For nP := nV1 To nT
				if nVolta <> 1
					nN:=nP-((5*nVolta)-5)
					oPrint:Say((nLinIni + 1667)*nAL, (nColIni + 0020)*nAC, AllTrim(Str(nN)) + " - ", oFont01)
				else
					oPrint:Say((nLinIni + 1667)*nAL, (nColIni + 0020)*nAC, AllTrim(Str(nP)) + " - ", oFont01)
				endif
				oPrint:Say((nLinIni + 1662)*nAL, (nColIni + 0070)*nAC, aDados[nX, 34, nP], oFont04)
				oPrint:Say((nLinIni + 1662)*nAL, (nColIni + 0150)*nAC, aDados[nX, 35, nP], oFont04)
				oPrint:Say((nLinIni + 1662)*nAL, (nColIni + 0450)*nAC, aDados[nX, 36, nP], oFont04)
				oPrint:Say((nLinIni + 1662)*nAL, (nColIni + 2000 + nColA4)*nAC, if (aDados[nX, 37, nP]=0,If(Empty(aDados[nX, 35, nP]),"","0,00"),Transform(aDados[nX, 37, nP], "@E 9999.99")), oFont04,,,,1)
				oPrint:Say((nLinIni + 1662)*nAL, (nColIni + 2210 + nColA4)*nAC, if (aDados[nX, 38, nP]=0,If(Empty(aDados[nX, 35, nP]),"","0,00"),Transform(aDados[nX, 38, nP], "@E 9999.99")), oFont04,,,,1)
				nLinIni += 40
			Next nP

		EndIf

		if nT < Len(aDados[nX, 35]).or. lImpnovo
			  nV1:=nP
			  lImpnovo:=.T.
		Endif

		nLinIni := nOldLinIni

		nLinIni += 20
		oPrint:Say((nLinIni + 1892)*nAL, (nColIni + 0010)*nAC, "OPM Solicitados", oFont01) //"OPM Solicitados"
		oPrint:Box((nLinIni + 1902)*nAL, (nColIni + 0010)*nAC, (nLinIni + 2177)*nAL, (nColIni + 2390 + nColA4)*nAC)
		oPrint:Say((nLinIni + 1927)*nAL, (nColIni + 0020)*nAC, "39 - "+"Tabela", oFont01) //"Tabela"
		oPrint:Say((nLinIni + 1927)*nAL, (nColIni + 0160)*nAC, "40 - "+"Código do OPM", oFont01) //"Código do OPM"
		oPrint:Say((nLinIni + 1927)*nAL, (nColIni + 0410)*nAC, "41 - "+"Descrição OPM", oFont01) //"Descrição OPM"
		oPrint:Say((nLinIni + 1927)*nAL, (nColIni + 1270 + nColA4)*nAC, "42 - "+"Qtde.", oFont01,,,,1) //"Qtde."
		oPrint:Say((nLinIni + 1927)*nAL, (nColIni + 1420 + nColA4)*nAC, "43 - "+"Fabricante", oFont01) //"Fabricante"
		oPrint:Say((nLinIni + 1927)*nAL, (nColIni + 2140 + nColA4)*nAC, "44 - "+"Valor Unitário - R$", oFont01,,,,1) //"Valor Unitário - R$"

		nOldLinIni := nLinIni

		if nVolta=1
			nV2:=1
		Endif

		For nP := nV2 To nT
			if nVolta <> 1
				nN:=nP-((5*nVolta)-5)
				oPrint:Say((nLinIni + 1977)*nAL, (nColIni + 0020)*nAC, AllTrim(Str(nN)) + " - ", oFont01)
			else
				oPrint:Say((nLinIni + 1977)*nAL, (nColIni + 0020)*nAC, AllTrim(Str(nP)) + " - ", oFont01)
			endif
			oPrint:Say((nLinIni + 1972)*nAL, (nColIni + 0065)*nAC, aDados[nX, 39, nP], oFont04)
			oPrint:Say((nLinIni + 1972)*nAL, (nColIni + 0160)*nAC, aDados[nX, 40, nP], oFont04)
			oPrint:Say((nLinIni + 1972)*nAL, (nColIni + 0410)*nAC, SubStr(aDados[nX, 41, nP], 1, 36), oFont04)
			oPrint:Say((nLinIni + 1972)*nAL, (nColIni + 1270 + nColA4)*nAC, if (aDados[nX, 42, nP]=0,If(Empty(aDados[nX, 40, nP]),"","0,00"),Transform(aDados[nX, 42, nP], "@E 9999.99")), oFont04,,,,1)
			oPrint:Say((nLinIni + 1972)*nAL, (nColIni + 1420 + nColA4)*nAC, Substr(aDados[nX, 43, nP], 1, 25), oFont04)
			oPrint:Say((nLinIni + 1972)*nAL, (nColIni + 2140 + nColA4)*nAC, if (aDados[nX, 44, nP]=0,If(Empty(aDados[nX, 40, nP]),"","0,00"),Transform(aDados[nX, 44, nP], "@E 999,999,999.99")), oFont04,,,,1)
			nLinIni += 40

		Next nP

		if nT < Len(aDados[nX, 40]) .or. lImpnovo
			  nV2:=nP
			  lImpnovo:=.T.
		Endif

		nLinIni := nOldLinIni

		nLinIni += 20
		oPrint:Say((nLinIni + 2197)*nAL, (nColIni + 0010)*nAC, "Dados da Autorização", oFont01) //"Dados da Autorização"
		oPrint:Box((nLinIni + 2207)*nAL, (nColIni + 0010)*nAC, (nLinIni + 2301)*nAL, (nColIni + 0610)*nAC)
		oPrint:Say((nLinIni + 2232)*nAL, (nColIni + 0020)*nAC, "45 - "+"Data Provável da Admissão Hospitalar", oFont01) //"Data Provável da Admissão Hospitalar"
		oPrint:Say((nLinIni + 2272)*nAL, (nColIni + 0030)*nAC, DtoC(aDados[nX, 45]), oFont04)
		oPrint:Box((nLinIni + 2207)*nAL, (nColIni + 0615)*nAC, (nLinIni + 2301)*nAL, (nColIni + 1115)*nAC)
		oPrint:Say((nLinIni + 2232)*nAL, (nColIni + 0625)*nAC, "46 - "+"Qtde.Diárias Autorizadas", oFont01) //"Qtde.Diárias Autorizadas"
		oPrint:Say((nLinIni + 2272)*nAL, (nColIni + 0695)*nAC, Transform(aDados[nX, 46], "@E 9999.99"), oFont04,,,, 1)
		oPrint:Box((nLinIni + 2207)*nAL, (nColIni + 1120)*nAC, (nLinIni + 2301)*nAL, (nColIni + 2120)*nAC)
		oPrint:Say((nLinIni + 2232)*nAL, (nColIni + 1130)*nAC, "47 - "+"Tipo da Acomodação Autorizada", oFont01) //"Tipo da Acomodação Autorizada"
		oPrint:Say((nLinIni + 2272)*nAL, (nColIni + 1140)*nAC, aDados[nX, 47, 1] + " - " + aDados[nX, 47, 2], oFont04)

		oPrint:Box((nLinIni + 2311)*nAL, (nColIni + 0010)*nAC, (nLinIni + 2405)*nAL, (nColIni + 0426)*nAC)
		oPrint:Say((nLinIni + 2336)*nAL, (nColIni + 0020)*nAC, "48 - "+"Código na Operadora / CNPJ", oFont01) //"Código na Operadora / CNPJ"
		oPrint:Say((nLinIni + 2376)*nAL, (nColIni + 0030)*nAC, aDados[nX, 48], oFont04)
		oPrint:Box((nLinIni + 2311)*nAL, (nColIni + 0431)*nAC, (nLinIni + 2405)*nAL, (nColIni + 2175 + nColA4)*nAC)
		oPrint:Say((nLinIni + 2336)*nAL, (nColIni + 0441)*nAC, "49 - "+"Nome do Prestador Autorizado", oFont01) //"Nome do Prestador Autorizado"
		oPrint:Say((nLinIni + 2376)*nAL, (nColIni + 0451)*nAC, SubStr(aDados[nX, 49], 1, 65), oFont04)
		oPrint:Box((nLinIni + 2311)*nAL, (nColIni + 2180 + nColA4)*nAC, (nLinIni + 2405)*nAL, (nColIni + 2390 + nColA4)*nAC)
		oPrint:Say((nLinIni + 2336)*nAL, (nColIni + 2190 + nColA4)*nAC, "50 - "+"Código CNES", oFont01) //"Código CNES"
		oPrint:Say((nLinIni + 2376)*nAL, (nColIni + 2200 + nColA4)*nAC, aDados[nX, 50], oFont04)

		oPrint:Box((nLinIni + 2410)*nAL, (nColIni + 0010)*nAC, (nLinIni + 2692 + nLinA4)*nAL, (nColIni + 2390 + nColA4)*nAC)
		oPrint:Say((nLinIni + 2435)*nAL, (nColIni + 0020)*nAC, "51 - "+"Observação", oFont01) //"Observação"
		nLin := 2480

		For nI := 1 To MlCount(aDados[nX, 51], 78)
			cObs := MemoLine(aDados[nX, 51], 78, nI)
			oPrint:Say((nLinIni + nLin)*nAL, (nColIni + 0030)*nAC, cObs, oFont04)
			nLin += 35
		Next nI

		oPrint:Box((nLinIni + 2697)*nAL + nLinA4, (nColIni + 0010)*nAC, (nLinIni + 2855)*nAL + nLinA4, (nColIni + 0754 + nColA4)*nAC)
		oPrint:Say((nLinIni + 2731 + nLinA4)*nAL, (nColIni + 0020)*nAC, "52 - "+"Data e Assinatura do Profissional Solicitante", oFont01) //"Data e Assinatura do Profissional Solicitante"
		oPrint:Say((nLinIni + 2771 + nLinA4)*nAL, (nColIni + 0030)*nAC, DtoC(aDados[nX, 52]), oFont04)
		oPrint:Box((nLinIni + 2697)*nAL + nLinA4, (nColIni + 0759 + nColA4)*nAC, (nLinIni + 2855)*nAL + nLinA4, (nColIni + 1573 + nColA4)*nAC)
		oPrint:Say((nLinIni + 2731 + nLinA4)*nAL, (nColIni + 0769 + nColA4)*nAC, "53 - "+"Data e Assinatura do Beneficiário ou Responsável", oFont01) //"Data e Assinatura do Beneficiário ou Responsável"
		oPrint:Say((nLinIni + 2771 + nLinA4)*nAL, (nColIni + 0779 + nColA4)*nAC, DtoC(aDados[nX, 53]), oFont04)
		oPrint:Box((nLinIni + 2697)*nAL + nLinA4, (nColIni + 1578 + nColA4)*nAC, (nLinIni + 2855)*nAL + nLinA4, (nColIni + 2390 + nColA4)*nAC)
		oPrint:Say((nLinIni + 2731 + nLinA4)*nAL, (nColIni + 1588 + nColA4)*nAC, "54 - "+"Data e Assinatura do Responsável pela Autorização", oFont01) //"Data e Assinatura do Responsável pela Autorização"
		oPrint:Say((nLinIni + 2771 + nLinA4)*nAL, (nColIni + 1598 + nColA4)*nAC, DtoC(aDados[nX, 54]), oFont04)

		oPrint:EndPage()	// Finaliza a pagina

		//  Verso da Guia
		oPrint:StartPage()	// Inicia uma nova pagina

		nLinIni := 100
		nColIni := 0
		nTot55	:=0
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Box Principal                                                 ?
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		oPrint:Box((nLinIni-nLinIni)*nAL, (nColIni)*nAC, ((nLinIni-nLinIni) + nLinMax)*nAL, (nColIni + nColMax)*nAC)
		oPrint:Say((nLinIni + 0010)*nAL, (nColIni + 0010)*nAC, "Prorrogações", oFont01) //"Prorrogações"

	    if nVolta=1
			nV:=1
		Endif

		nT3:=Len(aDados[nx,55])

		For nR := nV To nT3

			oPrint:Box((nLinIni + 0020)*nAL, (nColIni + 0010)*nAC, (nLinIni + 0503)*nAL, (nColIni + 2390 + nColA4)*nAC)
			oPrint:Box((nLinIni + 0025)*nAL, (nColIni + 0015)*nAC, (nLinIni + 0119)*nAL, (nColIni + 0405)*nAC)
			oPrint:Say((nLinIni + 0050)*nAL, (nColIni + 0025)*nAC, "55 - "+"Data", oFont01) //"Data"
			oPrint:Say((nLinIni + 0090)*nAL, (nColIni + 0035)*nAC, DtoC(aDados[nX, 55, nR]), oFont04)
			oPrint:Box((nLinIni + 0025)*nAL, (nColIni + 0410)*nAC, (nLinIni + 0119)*nAL, (nColIni + 1005)*nAC)
			oPrint:Say((nLinIni + 0050)*nAL, (nColIni + 0420)*nAC, "56 - "+"Senha", oFont01) //"Senha"
			oPrint:Say((nLinIni + 0090)*nAL, (nColIni + 0430)*nAC, aDados[nX, 56, nR], oFont04)
			oPrint:Box((nLinIni + 0025)*nAL, (nColIni + 1010)*nAC, (nLinIni + 0119)*nAL, (nColIni + 2385 + nColA4)*nAC)
			oPrint:Say((nLinIni + 0050)*nAL, (nColIni + 1020)*nAC, "57 - "+"Responsável pela Autorização", oFont01) //"Responsável pela Autorização"
			oPrint:Say((nLinIni + 0090)*nAL, (nColIni + 1030)*nAC, SubStr(aDados[nX, 57, nR], 1, 52), oFont04)

			oPrint:Box((nLinIni + 0124)*nAL, (nColIni + 0015)*nAC, (nLinIni + 0218)*nAL, (nColIni + 0305)*nAC)
			oPrint:Say((nLinIni + 0149)*nAL, (nColIni + 0025)*nAC, "58 - "+"Tipo Acomod", oFont01) //"Tipo Acomod"
			oPrint:Say((nLinIni + 0189)*nAL, (nColIni + 0035)*nAC, aDados[nX, 58, nR], oFont04)
			oPrint:Box((nLinIni + 0124)*nAL, (nColIni + 0310)*nAC, (nLinIni + 0218)*nAL, (nColIni + 1445)*nAC)
			oPrint:Say((nLinIni + 0149)*nAL, (nColIni + 0320)*nAC, "59 - "+"Acomodação", oFont01) //"Acomodação"
			oPrint:Say((nLinIni + 0189)*nAL, (nColIni + 0330)*nAC, aDados[nX, 59, nR], oFont04)
			oPrint:Box((nLinIni + 0124)*nAL, (nColIni + 1450)*nAC, (nLinIni + 0218)*nAL, (nColIni + 1685)*nAC)
			oPrint:Say((nLinIni + 0149)*nAL, (nColIni + 1460)*nAC, "60 - "+"Qtde.Autorizada", oFont01) //"Qtde.Autorizada"

			nTotAut:=0

			If ValType(aDados[nX][60][nR]) == "N" .And. aDados[nX][60][nR] > 0
				nTotAut := aDados[nX][60][nR]
			Else
				For nJ := 1 To  Len( aDados[nX, 65, nR])
					nTotAut:=aDados[nX, 65, nR, nJ]
	  			Next nj
            EndIf

			oPrint:Say((nLinIni + 0189)*nAL, (nColIni + 1530)*nAC, If(Empty(nTotAut),"0,00",Transform(nTotAut, "@E 9999.99")), oFont04,,,,1)

			oPrint:Box((nLinIni + 0223)*nAL, (nColIni + 0015)*nAC, (nLinIni + 0358)*nAL, (nColIni + 2385 + nColA4)*nAC)
			oPrint:Say((nLinIni + 0248)*nAL, (nColIni + 0025)*nAC, "61 - "+"Tabela", oFont01) //"Tabela"
			oPrint:Say((nLinIni + 0248)*nAL, (nColIni + 0155)*nAC, "62 - "+"Código do Procedimento", oFont01) //"Código do Procedimento"
			oPrint:Say((nLinIni + 0248)*nAL, (nColIni + 0455)*nAC, "63 - "+"Descrição", oFont01) //"Descrição"
			oPrint:Say((nLinIni + 0248)*nAL, (nColIni + 2025 + nColA4)*nAC, "64 - "+"Qtde.Solic", oFont01,,,,1) //"Qtde.Solic"
			oPrint:Say((nLinIni + 0248)*nAL, (nColIni + 2235 + nColA4)*nAC, "65 - "+"Qtde.Aut", oFont01,,,,1) //"Qtde.Aut"

			nOldLinIni := nLinIni

			For nJ := 1 To 1
				oPrint:Say((nLinIni + 0288)*nAL, (nColIni + 0025)*nAC, aDados[nX, 61, nR, nJ], oFont04)
				oPrint:Say((nLinIni + 0288)*nAL, (nColIni + 0155)*nAC, aDados[nX, 62, nR, nJ], oFont04)
				oPrint:Say((nLinIni + 0288)*nAL, (nColIni + 0455)*nAC, SubStr(aDados[nX, 63, nR, nJ],1,92), oFont04)
				oPrint:Say((nLinIni + 0288)*nAL, (nColIni + 2025 + nColA4)*nAC, IIf(aDados[nX, 64, nR, nJ]=0, If(Empty(aDados[nX, 62, nR, nJ]),"","0,00"), Transform(aDados[nX, 64, nR, nJ], "@E 9999.99")), oFont04,,,,1)
				oPrint:Say((nLinIni + 0288)*nAL, (nColIni + 2235 + nColA4)*nAC, IIf(aDados[nX, 65, nR, nJ]=0, If(Empty(aDados[nX, 62, nR, nJ]),"","0,00"), Transform(aDados[nX, 65, nR, nJ], "@E 9999.99")), oFont04,,,,1)
				nLinIni += 40
			Next nJ

			nLinIni := nOldlinIni

			oPrint:Box((nLinIni + 0363)*nAL, (nColIni + 0015)*nAC, (nLinIni + 0498)*nAL, (nColIni + 2385 + nColA4)*nAC)
			oPrint:Say((nLinIni + 0388)*nAL, (nColIni + 0025)*nAC, "66 - "+"Tabela", oFont01) //"Tabela"
			oPrint:Say((nLinIni + 0388)*nAL, (nColIni + 0165)*nAC, "67 - "+"Código do OPM", oFont01) //"Código do OPM"
			oPrint:Say((nLinIni + 0388)*nAL, (nColIni + 0400)*nAC, "68 - "+"Descrição OPM", oFont01) //"Descrição OPM"
			oPrint:Say((nLinIni + 0388)*nAL, (nColIni + 1375 + nColA4)*nAC, "69 - "+"Qtde.", oFont01,,,,1) //"Qtde."
			oPrint:Say((nLinIni + 0388)*nAL, (nColIni + 1495 + nColA4)*nAC, "70 - "+"Fabricante", oFont01) //"Fabricante"
			oPrint:Say((nLinIni + 0388)*nAL, (nColIni + 2125 + nColA4)*nAC, "71 - "+"Valor Unitário - R$", oFont01,,,,1) //"Valor Unitário - R$"

			nOldLinIni := nLinIni

			For nJ := 1 To Len( aDados[nX, 66, nR])
				oPrint:Say((nLinIni + 0428)*nAL, (nColIni + 0025)*nAC, aDados[nX, 66, nR, nJ], oFont04)
				oPrint:Say((nLinIni + 0428)*nAL, (nColIni + 0165)*nAC, aDados[nX, 67, nR, nJ], oFont04)
				oPrint:Say((nLinIni + 0428)*nAL, (nColIni + 0400)*nAC, SubStr(aDados[nX, 68, nR, nJ], 1, 36), oFont04)
				oPrint:Say((nLinIni + 0428)*nAL, (nColIni + 1375 + nColA4)*nAC, IIf(aDados[nX, 69, nR, nJ]=0,If(Empty(aDados[nX, 67, nR, nJ]),"","0,00") , Transform(aDados[nX, 69, nR, nJ], "@E 9999.99")), oFont04,,,,1)
				oPrint:Say((nLinIni + 0428)*nAL, (nColIni + 1495 + nColA4)*nAC, SubStr(aDados[nX, 70, nR, nJ], 1, 25), oFont04)
				oPrint:Say((nLinIni + 0428)*nAL, (nColIni + 2125 + nColA4)*nAC, IIf(aDados[nX, 71, nR, nJ]=0, If(Empty(aDados[nX, 67, nR, nJ]),"","0,00"), Transform(aDados[nX, 71, nR, nJ], "@E 999,999,999.99")), oFont04,,,,1)
				nLinIni += 40
			Next nJ

			nLinIni := nOldlinIni
			nTot55 ++

			If nTot55 > 5
			  	oPrint:EndPage()	// Finaliza a pagina
		  		oPrint:StartPage()	// Inicia uma nova pagina
				nLinIni := 100
				nColIni := 0
				nTot55	:=0
			Else
				nLinIni += 500
			Endif

		Next nR

		if (Len(aDados[nX, 55])>nR-1) .or. (Len(aDados[nX, 55])>nR-1).or. lImpnovo
			  nV       :=nR
			  nV1      :=nP
			  nV2      :=nP
			  lImpnovo :=.T.
		Endif

		oPrint:EndPage()	// Finaliza a pagina

	Next nX

enddo
	If lGerTXT .And. !lWeb
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
		//³Imprime Relatorio
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
		oPrint:Print()
	Else
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
		//³Visualiza impressao grafica antes de imprimir
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
       If lRet
		oPrint:Print()
		EndIf

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
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡ao    ?PLSTISS4  ?Autor ?Luciano Aparecido     ?Data ?22.02.07 ³±?
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡ao ?Estrutura Relatório TISS (Guia Res. Internaçao)-BOPS 095189 ³±?
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±?Uso      ?SigaPLS                                                     ³±?
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros?aDados - Array com as informações do relat´rio              ³±?
±±?         ?lGerTXT - Define se imprime direto sem passar pela tela 	   ³±?
±±?         ?		 de configuracao/preview do relatorio 		       ³±?
±±?         ?nLayout - Define o formato de papél para impressao:         ³±?
±±?         ?          1 - Formato Ofício II (216x330mm)                 ³±?
±±?         ?          2 - Formato A4 (210x297mm)                        ³±?
±±?         ? 		 3 - Formato Carta (216x279mm)     			       ³±?
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function CABTISS4(aDados, lGerTXT, nLayout, cLogoGH)

	Local nLinMax
	Local nColMax
	Local nLinIni := 0		// Linha Lateral (inicial) Esquerda
	Local nColIni := 0		// Coluna Lateral (inicial) Esquerda
    Local nColA4  := 0
    Local nCol2A4 := 0
	Local cFileLogo
	Local lPrinter
	Local nLin
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
	Local nAte    :=15
	Local nAte1   :=20
	Local nAte2   := 5

	Default lGerTXT := .F.
	Default nLayout := 2
	Default cLogoGH := ''
	Default aDados := { { ;
						"123456",;
						"12345678901234567892",;
						"12345678901234567892",;
						CtoD("01/01/07"),;
						"12345678901234567892",;
						CtoD("01/01/07"),;
						CtoD("01/01/07"),;
						"12345678901234567892",;
						Replicate("M",40),;
						CtoD("12/12/07"),;
						Replicate("M",70),;
						"123456789102345",;
						"14.141.114/00001-35",;
						Replicate("M",70),;
						"1234567",;
						"999",;
						Replicate("M",40),;
						"MMMMM",;
						Replicate("M",15),;
						Replicate("M",40),;
						"MM",;
						"1234567",;
						"12345-678",;
						"E",;
						{ "00", "COLETIVO" },;
						{ CtoD("12/12/07"), "2210" },;
						{ CtoD("12/12/07"), "2210" },;
						"1",;
						"1",;
						{ "X","X","X","X","X","X","X","X","X" },;
						"1",;
						{ 1, 1 },;
						"123456789102345",;
						99,;
						01,;
						01,;
						"12345",;
						"12345",;
						"12345",;
						"12345",;
						"1",;
						"01",;
						"12345",;
						"1234567",;
						{ CtoD("12/01/06"),CtoD("12/02/06"),CtoD("12/03/06"),CtoD("12/03/06"),CtoD("12/03/06"),CtoD("12/03/06"),CtoD("12/03/06"),CtoD("12/03/06"),CtoD("12/03/06"),CtoD("12/03/06"),CtoD("12/03/06"),CtoD("12/03/06"),CtoD("12/03/06"),CtoD("12/03/06"),CtoD("12/03/06") },;
						{ "0107","0207","0307","0407","0507","0507","0507","0507","0507","0507","0507","0507","0507","0507","0507" },;
						{ "0607","0707","0807","0907","1007","0507","0507","0507","0507","0507","0507","0507","0507","0507","0507" },;
						{ "MM","AA","BB","CC","DD","DD","DD","DD","DD","DD","DD","DD","DD","DD","DD"},;
						{ "1234567890","2345678901","3456789012","4567890123","5678901234","5678901234","5678901234","5678901234","5678901234","5678901234","5678901234","5678901234","5678901234","5678901234","5678901234"},;
						{ Replicate("M",60),Replicate("B",60),Replicate("C",60),Replicate("D",60),Replicate("E",60),Replicate("E",60),Replicate("E",60),Replicate("E",60),Replicate("E",60),Replicate("E",60),Replicate("E",60),Replicate("E",60),Replicate("E",60),Replicate("E",60),Replicate("E",60)},;
						{ 12,1,2,3,4,4,4,4,4,4,4,4,4,4,4},;
						{ "M","A","B","C","D","D","D","D","D","D","D","D","D","D","D"},;
						{ "M","E","F","G","H","D","D","D","D","D","D","D","D","D","D"},;
						{ 111.00,222.00,333.00,444.00,999.99,999.99,999.99,999.99,999.99,999.99,999.99,999.99,999.99,999.99,999.99 },;
						{ 99999.99,22222.22,33.33,44444.44,11111.11,11111.11,11111.11,11111.11,11111.11,11111.11,11111.11,11111.11,11111.11,11111.11,11111.11 },;
						{ 11111.11,55555.00,66666.00,77777.00,88888.00,88888.00,88888.00,88888.00,88888.00,88888.00,88888.00,88888.00,88888.00,88888.00,88888.00 },;
						{ "03", "04", "05", "06", "07","08","08","08","08","08","08","08","08","08","08","08","08","08","08","08","08" },;
						{ "02", "03", "04", "05", "06","07","08","08","08","08","08","08","08","08","08","08","08","08","08","08","08" },;
						{ "123456789102", "123456789102", "123456789102", "123456789102", "123456789102", "123456789102", "123456789102", "123456789102", "123456789102", "123456789102", "123456789102", "123456789102", "123456789102", "123456789102", "123456789102", "123456789102", "123456789102", "123456789102", "123456789102", "123456789102", "123456789102" },;
						{ Replicate("A", 70), Replicate("B", 70), Replicate("C", 70), Replicate("D", 70), Replicate("E", 70), Replicate("M", 70), Replicate("M", 70), Replicate("M", 70), Replicate("M", 70), Replicate("M", 70), Replicate("M", 70), Replicate("M", 70), Replicate("M", 70), Replicate("M", 70), Replicate("M", 70), Replicate("M", 70), Replicate("M", 70), Replicate("M", 70), Replicate("M", 70), Replicate("M", 70), Replicate("M", 70) },;
						{ "1234567", "1234567", "1234567", "1234567", "1234567", "1234567", "1234567", "1234567", "1234567", "1234567", "1234567", "1234567", "1234567", "1234567", "1234567", "1234567", "1234567", "1234567", "1234567", "1234567" },;
						{ "123456789102345", "123456789102345", "123456789102345", "123456789102345", "123456789102345", "123456789102345", "123456789102345", "123456789102345", "123456789102345", "123456789102345", "123456789102345", "123456789102345", "123456789102345", "123456789102345", "123456789102345", "123456789102345", "123456789102345", "123456789102345", "123456789102345", "123456789102345" },;
						{ "ES", "DF", "MM", "GO", "SP","SC", "DF", "MM", "GO", "SP","SC", "DF", "MM", "GO", "SP","SC", "DF", "MM", "GO", "SP","SC", "DF", "MM", "GO", "SP" },;
						{ "12345678910", "12345678910", "12345678910", "12345678910", "12345678910", "12345678910", "12345678910", "12345678910", "12345678910", "12345678910", "12345678910", "12345678910", "12345678910", "12345678910", "12345678910", "12345678910", "12345678910", "12345678910", "12345678910", "12345678910" },;
						{ "11", "12", "13", "14", "15", "16", "17", "18", "19" },;
						{ "1234567890", "2345678901", "3456789012", "4567890123", "5678901234", "6789012345", "7890123456", "8901234567", "9012345678" },;
						{ Replicate ("A", 60), Replicate ("B", 60), Replicate ("C", 60), Replicate ("D", 60), Replicate ("E", 60), Replicate ("F", 60), Replicate ("G", 60), Replicate ("H", 60), Replicate ("I", 60) },;
						{ 01, 2, 3, 04, 05, 06, 07, 8, 99 }, ;
						{ Replicate ("J", 20), Replicate ("K", 20), Replicate ("L", 20), Replicate ("M", 20), Replicate ("N", 20), Replicate ("O", 20), Replicate ("P", 20), Replicate ("Q", 20), Replicate ("R", 20) },;
						{ 199999.99, 299999.99, 399999.99, 499999.99, 599999.99, 699999.99, 799.99, 899999.99, 99.99 },;
						{ 199999.99, 299999.99, 399999.99, 499999.99, 599999.99, 699999.99, 799.99, 899999.99, 99.99 },;
						3999999.99,;
						{ "X","X" },;
						199999.99,;
						199999.99,;
						199999.99,;
						199999.99,;
						199999.99,;
						199999.99,;
						199999.99,;
						Replicate("M", 240),;
						CtoD("01/01/07"),;
						CtoD("04/01/07") } }

	If nLayout  == 1 // Ofício 2
		nLinMax := 2435
		nColMax := 3705	//3765
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


	oPrint	:= TMSPrinter():New("GUIA DE RESUMO DE INTERNACAO") //"GUIA DE RESUMO DE INTERNACAO"

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

	If ! lPrinter
		oPrint:Setup()
	EndIf


While lImpnovo

	lImpnovo:=.F.
	nVolta  += 1
	nAte    += nP
	nAte1   += nP1
	nAte2   += nP4


	For nX := 1 To Len(aDados)

		If ValType(aDados[nX]) == 'U' .OR. Len(aDados[nX]) == 0
			Loop
		EndIf

		For nI := 45 To 56
			If Len(aDados[nX, nI]) < nAte
				For nJ := Len(aDados[nX, nI]) + 1 To nAte
					If AllTrim(Str(nI)) $ "45"
						aAdd(aDados[nX, nI], StoD(""))
					ElseIf AllTrim(Str(nI)) $ "51,54,55,56"
						aAdd(aDados[nX, nI], 0)
					Else
						aAdd(aDados[nX, nI], "")
					EndIf
				Next nJ
			EndIf
		Next nI

		For nI := 57 To 64
			If Len(aDados[nX, nI]) < nAte1
				For nJ := Len(aDados[nX, nI]) + 1 To nAte1
					aAdd(aDados[nX, nI], "")
				Next nJ
			EndIf
		Next nI

		For nI := 65 To 71
			If Len(aDados[nX, nI]) < nAte2
				For nJ := Len(aDados[nX, nI]) + 1 To nAte2
					If AllTrim(Str(nI)) $ "68,70,71"
						aAdd(aDados[nX, nI], 0)
					Else
						aAdd(aDados[nX, nI], "")
					EndIf
				Next nJ
			EndIf
		Next nI

		nLinIni := 000
		nColIni := 000
		nColA4  := 000
		nCol2A4 := 000

		oPrint:StartPage()		// Inicia uma nova pagina
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Box Principal                                                 ?
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		oPrint:Box(nLinIni + 0000, nColIni + 0000, nLinIni + nLinMax, nColIni + nColMax)

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Carrega e Imprime Logotipo da Empresa                         ?
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		fLogoEmp(@cFileLogo,, cLogoGH)

		If File(cFilelogo)
			oPrint:SayBitmap(nLinIni + 0050, nColIni + 0020, cFileLogo, 400, 090) 		// Tem que estar abaixo do RootPath
		EndIf

		If nLayout == 2 // Papél A4
			nColA4    := -0335
			nCol2A4   := -0180
		Elseif nLayout == 3// Carta
			nColA4    := -0530
			nCol2A4   := -0180
		Endif

		oPrint:Say(nLinIni + 0080, nColIni + 1852 + IIf(nLayout == 2 .Or. nLayout == 3,nColA4+230,nColA4), OemToAnsi("GUIA DE RESUMO DE INTERNAÇÃO"), oFont02n,,,, 2) //"GUIA DE RESUMO DE INTERNAÇÃO"
		oPrint:Say(nLinIni + 0090, nColIni + 3000 + nColA4, "2 - "+OemToAnsi("Nº"), oFont01) //"N?
		oPrint:Say(nLinIni + 0070, nColIni + 3096 + nColA4, aDados[nX, 02], oFont03n)

		nLinIni += 60
		oPrint:Box(nLinIni + 0175, nColIni + 0010, nLinIni + 0269, nColIni + 0315)
		oPrint:Say(nLinIni + 0180, nColIni + 0020, "1 - "+"Registro ANS", oFont01) //"Registro ANS"
		oPrint:Say(nLinIni + 0210, nColIni + 0030, aDados[nX, 01], oFont04)
		oPrint:Box(nLinIni + 0175, nColIni + 0320, nLinIni + 0269, nColIni + 1035)
		oPrint:Say(nLinIni + 0180, nColIni + 0330, "3 - "+OemToAnsi("Nº Guia de Solicitação"), oFont01) //"N?Guia de Solicitação"
		oPrint:Say(nLinIni + 0210, nColIni + 0340, aDados[nX, 03], oFont04)
		oPrint:Box(nLinIni + 0175, nColIni + 1040, nLinIni + 0269, nColIni + 1345)
		oPrint:Say(nLinIni + 0180, nColIni + 1050, "4 - "+"Data da Autorização", oFont01) //"Data da Autorização"
		oPrint:Say(nLinIni + 0210, nColIni + 1060, DtoC(aDados[nX, 04]), oFont04)
		oPrint:Box(nLinIni + 0175, nColIni + 1350, nLinIni + 0269, nColIni + 1755)
		oPrint:Say(nLinIni + 0180, nColIni + 1360, "5 - "+"Senha", oFont01) //"Senha"
		oPrint:Say(nLinIni + 0210, nColIni + 1370, aDados[nX, 05], oFont04)
		oPrint:Box(nLinIni + 0175, nColIni + 1760, nLinIni + 0269, nColIni + 2165)
		oPrint:Say(nLinIni + 0180, nColIni + 1770, "6 - "+"Data Validade da Senha", oFont01) //"Data Validade da Senha"
		oPrint:Say(nLinIni + 0210, nColIni + 1780, DtoC(aDados[nX, 06]), oFont04)
		oPrint:Box(nLinIni + 0175, nColIni + 2170, nLinIni + 0269, nColIni + 2465)
		oPrint:Say(nLinIni + 0180, nColIni + 2180, "7 - "+"Data de Emissão da Guia", oFont01) //"Data de Emissão da Guia"
		oPrint:Say(nLinIni + 0210, nColIni + 2190, DtoC(aDados[nX, 07]), oFont04)

		nLinIni += 20
		oPrint:Say(nLinIni + 0274, nColIni + 0010, "Dados do Beneficiário", oFont01) //"Dados do Beneficiário"
		oPrint:Box(nLinIni + 0304, nColIni + 0010, nLinIni + 0398, nColIni + 0425)
		oPrint:Say(nLinIni + 0309, nColIni + 0020, "8 - "+"Número da Carteira", oFont01) //"Número da Carteira"
		oPrint:Say(nLinIni + 0339, nColIni + 0030, aDados[nX, 08], oFont04)
		oPrint:Box(nLinIni + 0304, nColIni + 0430, nLinIni + 0398, nColIni + 1572)
		oPrint:Say(nLinIni + 0309, nColIni + 0440, "9 - "+"Plano", oFont01) //"Plano"
		oPrint:Say(nLinIni + 0339, nColIni + 0450, aDados[nX, 09], oFont04)
		oPrint:Box(nLinIni + 0304, nColIni + 1577, nLinIni + 0398, nColIni + 1835)
		oPrint:Say(nLinIni + 0309, nColIni + 1587, "10 - "+"Validade da Carteira", oFont01) //"Validade da Carteira"
		oPrint:Say(nLinIni + 0339, nColIni + 1597, DtoC(aDados[nX, 10]), oFont04)

		oPrint:Box(nLinIni + 0403, nColIni + 0010, nLinIni + 0497, nColIni + 3090 + nColA4)
		oPrint:Say(nLinIni + 0408, nColIni + 0020, "11 - "+"Nome", oFont01) //"Nome"
		oPrint:Say(nLinIni + 0438, nColIni + 0030, aDados[nX, 11], oFont04)
		oPrint:Box(nLinIni + 0403, nColIni + 3095 + nColA4, nLinIni + 0497, nColIni + 3695 + nColA4)
		oPrint:Say(nLinIni + 0408, nColIni + 3105 + nColA4, "12 - "+"Número do Cartão Nacional de Saúde", oFont01) //"Número do Cartão Nacional de Saúde"
		oPrint:Say(nLinIni + 0438, nColIni + 3115 + nColA4, aDados[nX, 12], oFont04)

		nLinIni += 20
		oPrint:Say(nLinIni + 0502, nColIni + 0010, "Dados do Contratado Executante", oFont01) //"Dados do Contratado Executante"
		oPrint:Box(nLinIni + 0532, nColIni + 0010, nLinIni + 0626, nColIni + 0426)
		oPrint:Say(nLinIni + 0537, nColIni + 0020, "13 - "+"Código na Operadora / CNPJ", oFont01) //"Código na Operadora / CNPJ"
		oPrint:Say(nLinIni + 0567, nColIni + 0030, aDados[nX, 13], oFont04)
		oPrint:Box(nLinIni + 0532, nColIni + 0431, nLinIni + 0626, nColIni + 2245)
		oPrint:Say(nLinIni + 0537, nColIni + 0441, "14 - "+"Nome do Contratado", oFont01) //"Nome do Contratado"
		oPrint:Say(nLinIni + 0567, nColIni + 0451, SubStr(aDados[nX, 14], 1, 65), oFont04)
		oPrint:Box(nLinIni + 0532, nColIni + 2250, nLinIni + 0626, nColIni + 2460)
		oPrint:Say(nLinIni + 0537, nColIni + 2260, "15 - "+"Código CNES", oFont01) //"Código CNES"
		oPrint:Say(nLinIni + 0567, nColIni + 2270, aDados[nX, 15], oFont04)

		oPrint:Box(nLinIni + 0631, nColIni + 0010, nLinIni + 0725, nColIni + 0132)
		oPrint:Say(nLinIni + 0636, nColIni + 0020, "16 - "+"T.L.", oFont01) //"T.L."
		oPrint:Say(nLinIni + 0666, nColIni + 0030, aDados[nX, 16], oFont04)
		oPrint:Box(nLinIni + 0631, nColIni + 0137, nLinIni + 0725, nColIni + 2032 + nColA4)
		oPrint:Say(nLinIni + 0636, nColIni + 0147, "17-18-19 - "+"Logradouro - Número - Complemento", oFont01) //"Logradouro - Número - Complemento"
		oPrint:Say(nLinIni + 0666, nColIni + 0157, SubStr(AllTrim(aDados[nX, 17]) + IIf(!Empty(aDados[nX, 18]), ", ","") + AllTrim(aDados[nX, 18]) + IIf(!Empty(aDados[nX, 19]), " - ","") + AllTrim(aDados[nX, 19]), 1, 76), oFont04)
		oPrint:Box(nLinIni + 0631, nColIni + 2037 + nColA4, nLinIni + 0725, nColIni + 3165 + nColA4)
		oPrint:Say(nLinIni + 0636, nColIni + 2047 + nColA4, "20 - "+"Município", oFont01) //"Município"
		oPrint:Say(nLinIni + 0666, nColIni + 2057 + nColA4, SubStr(aDados[nX, 20], 1, 39), oFont04)
		oPrint:Box(nLinIni + 0631, nColIni + 3170 + nColA4, nLinIni + 0725, nColIni + 3269 + nColA4)
		oPrint:Say(nLinIni + 0636, nColIni + 3180 + nColA4, "21 - "+"UF", oFont01) //"UF"
		oPrint:Say(nLinIni + 0666, nColIni + 3190 + nColA4, aDados[nX, 21], oFont04)
		oPrint:Box(nLinIni + 0631, nColIni + 3274 + nColA4, nLinIni + 0725, nColIni + 3502 + nColA4)
		oPrint:Say(nLinIni + 0636, nColIni + 3284 + nColA4, "22 - "+"Cód. IBGE", oFont01) //"Cód. IBGE"
		oPrint:Say(nLinIni + 0666, nColIni + 3294 + nColA4, aDados[nX, 22], oFont04)
		oPrint:Box(nLinIni + 0631, nColIni + 3507 + nColA4, nLinIni + 0725, nColIni + 3695 + nColA4)
		oPrint:Say(nLinIni + 0636, nColIni + 3517 + nColA4, "23 - "+"CEP", oFont01) //"CEP"
		oPrint:Say(nLinIni + 0666, nColIni + 3527 + nColA4, aDados[nX, 23], oFont04)

		nLinIni += 20
		oPrint:Say(nLinIni + 0730, nColIni + 0010, "Dados da Internação", oFont01) //"Dados da Internação"
		oPrint:Box(nLinIni + 0760, nColIni + 0010, nLinIni + 0854, nColIni + 0465)
		oPrint:Say(nLinIni + 0765, nColIni + 0020, "24 - "+"Caráter da Internação", oFont01) //"Caráter da Internação"
		oPrint:Line(nLinIni + 0790, nColIni + 0030 + nColA4, nLinIni + 0837, nColIni + 0030 + nColA4)
		oPrint:Line(nLinIni + 0837, nColIni + 0030 + nColA4, nLinIni + 0837, nColIni + 0077 + nColA4)
		oPrint:Line(nLinIni + 0790, nColIni + 0077 + nColA4, nLinIni + 0837, nColIni + 0077 + nColA4)
		oPrint:Say(nLinIni + 0795, nColIni + 0043, aDados[nX, 24], oFont04)
		oPrint:Say(nLinIni + 0805, nColIni + 0090, "E - Eletiva"+"  "+"U - Urgência/Emergência", oFont01) //"E - Eletiva"###"U - Urgência/Emergência"
		oPrint:Box(nLinIni + 0760, nColIni + 0470, nLinIni + 0854, nColIni + 1445 + nColA4)
		oPrint:Say(nLinIni + 0765, nColIni + 0480, "25 - "+"Tipo Acomodação Autorizada", oFont01) //"Tipo Acomodação Autorizada"
		oPrint:Say(nLinIni + 0795, nColIni + 0490, aDados[nX, 25, 1] + "-" + aDados[nX, 25, 2], oFont04)
		oPrint:Box(nLinIni + 0760, nColIni + 1450 + nColA4, nLinIni + 0854, nColIni + 1865 + nColA4)
		oPrint:Say(nLinIni + 0765, nColIni + 1460 + nColA4, "26 - "+"Data/Hora da Internação", oFont01) //"Data/Hora da Internação"
		oPrint:Say(nLinIni + 0795, nColIni + 1470 + nColA4, DtoC(aDados[nX, 26,1]) + " " + Transform(aDados[nX, 26,2], "@R 99:99"), oFont04)
		oPrint:Box(nLinIni + 0760, nColIni + 1870 + nColA4, nLinIni + 0854, nColIni + 2285 + nColA4)
		oPrint:Say(nLinIni + 0765, nColIni + 1880 + nColA4, "27 - "+"Data/Hora da Saída Internação", oFont01) //"Data/Hora da Saída Internação"
		oPrint:Say(nLinIni + 0795, nColIni + 1890 + nColA4, DtoC(aDados[nX, 27,1]) + " " + Transform(aDados[nX, 27,2], "@R 99:99"), oFont04)
		oPrint:Box(nLinIni + 0760, nColIni + 2290 + nColA4, nLinIni + 0854, nColIni + 3055 + nColA4)
		oPrint:Say(nLinIni + 0765, nColIni + 2300 + nColA4, "28 - "+"Tipo Internação", oFont01) //"Tipo Internação"
		oPrint:Line(nLinIni + 0790, nColIni + 2310 + nColA4, nLinIni + 0837, nColIni + 2310 + nColA4)
		oPrint:Line(nLinIni + 0837, nColIni + 2310 + nColA4, nLinIni + 0837, nColIni + 2357 + nColA4)
		oPrint:Line(nLinIni + 0790, nColIni + 2357 + nColA4, nLinIni + 0837, nColIni + 2357 + nColA4)
		oPrint:Say(nLinIni + 0795, nColIni + 2323 + nColA4, aDados[nX, 28], oFont04)
		oPrint:Say(nLinIni + 0805, nColIni + 2370 + nColA4, "1 - "+"Clínica"+"  "+"2 - "+"Cirúrgica"+"  "+"3 - "+OemToAnsi("Obstétrica")+"  "+"4 - "+OemToAnsi("Pediátrica")+"  "+"5 - "+OemToAnsi("Psiquiátrica"), oFont01) //"Clínica"###"Cirúrgica"###"Obstétrica"###"Pediátrica"###"Psiquiátrica"
		oPrint:Box(nLinIni + 0760, nColIni + 3060 + nColA4, nLinIni + 0854, nColIni + 3695 + nColA4)
		oPrint:Say(nLinIni + 0765, nColIni + 3070 + nColA4, "29 - "+"Regime de Internação", oFont01) //"Regime de Internação"
		oPrint:Line(nLinIni + 0790, nColIni + 3080 + nColA4, nLinIni + 0837, nColIni + 3080 + nColA4)
		oPrint:Line(nLinIni + 0837, nColIni + 3080 + nColA4, nLinIni + 0837, nColIni + 3127 + nColA4)
		oPrint:Line(nLinIni + 0790, nColIni + 3127 + nColA4, nLinIni + 0837, nColIni + 3127 + nColA4)
		oPrint:Say(nLinIni + 0795, nColIni + 3093 + nColA4, aDados[nX, 29], oFont04)
		oPrint:Say(nLinIni + 0805, nColIni + 3140 + nColA4, "1 - "+"Hospitalar"+"  "+"2 - "+"Hospital-dia"+"  "+"3- "+"Domiciliar", oFont01) //"Hospitalar"###"Hospital-dia"###"Domiciliar"

		oPrint:Box(nLinIni + 0859, nColIni + 0010, nLinIni + 0948, nColIni + 3695 + nColA4)
		oPrint:Say(nLinIni + 0864, nColIni + 0020, '30 - '+'Internação Obstétrica - (selecione mais de um se necessário com "X")', oFont01) //'Internação Obstétrica - (selecione mais de um se necessário com "X")'
		oPrint:Line(nLinIni + 0889, nColIni + 0030, nLinIni + 0936, nColIni + 0030)
		oPrint:Line(nLinIni + 0936, nColIni + 0030, nLinIni + 0936, nColIni + 0077)
		oPrint:Line(nLinIni + 0889, nColIni + 0077, nLinIni + 0936, nColIni + 0077)
		oPrint:Say(nLinIni + 0894, nColIni + 0043, aDados[nX, 30,1], oFont04)
		oPrint:Say(nLinIni + 0904, nColIni + 0090, "- "+"Em gestação", oFont01) //"Em gestação"
		oPrint:Line(nLinIni + 0889, nColIni + 0240, nLinIni + 0936, nColIni + 0240)
		oPrint:Line(nLinIni + 0936, nColIni + 0240, nLinIni + 0936, nColIni + 0287)
		oPrint:Line(nLinIni + 0889, nColIni + 0287, nLinIni + 0936, nColIni + 0287)
		oPrint:Say(nLinIni + 0894, nColIni + 0253, aDados[nX, 30,2], oFont04)
		oPrint:Say(nLinIni + 0904, nColIni + 0300, "- "+"Aborto", oFont01) //"Aborto"
		oPrint:Line(nLinIni + 0889, nColIni + 0390, nLinIni + 0936, nColIni + 0390)
		oPrint:Line(nLinIni + 0936, nColIni + 0390, nLinIni + 0936, nColIni + 0437)
		oPrint:Line(nLinIni + 0889, nColIni + 0437, nLinIni + 0936, nColIni + 0437)
		oPrint:Say(nLinIni + 0894, nColIni + 0403, aDados[nX, 30,3], oFont04)
		oPrint:Say(nLinIni + 0904, nColIni + 0450, "- "+"Transtorno materno relacionado a gravidez", oFont01) //"Transtorno materno relacionado a gravidez"
		oPrint:Line(nLinIni + 0889, nColIni + 0880, nLinIni + 0936, nColIni + 0880)
		oPrint:Line(nLinIni + 0936, nColIni + 0880, nLinIni + 0936, nColIni + 0927)
		oPrint:Line(nLinIni + 0889, nColIni + 0927, nLinIni + 0936, nColIni + 0927)
		oPrint:Say(nLinIni + 0894, nColIni + 0893, aDados[nX, 30,4], oFont04)
		oPrint:Say(nLinIni + 0904, nColIni + 0940, "- "+"Complic. Puerpério", oFont01) //"Complic. Puerpério"
		oPrint:Line(nLinIni + 0889, nColIni + 1160, nLinIni + 0936, nColIni + 1160)
		oPrint:Line(nLinIni + 0936, nColIni + 1160, nLinIni + 0936, nColIni + 1207)
		oPrint:Line(nLinIni + 0889, nColIni + 1207, nLinIni + 0936, nColIni + 1207)
		oPrint:Say(nLinIni + 0894, nColIni + 1173, aDados[nX, 30,5], oFont04)
		oPrint:Say(nLinIni + 0904, nColIni + 1220, "- "+"Atend. ao RN na sala de parto", oFont01) //"Atend. ao RN na sala de parto"
		oPrint:Line(nLinIni + 0889, nColIni + 1540, nLinIni + 0936, nColIni + 1540)
		oPrint:Line(nLinIni + 0936, nColIni + 1540, nLinIni + 0936, nColIni + 1587)
		oPrint:Line(nLinIni + 0889, nColIni + 1587, nLinIni + 0936, nColIni + 1587)
		oPrint:Say(nLinIni + 0894, nColIni + 1553, aDados[nX, 30,6], oFont04)
		oPrint:Say(nLinIni + 0904, nColIni + 1600, "- "+"Complicação Neonatal", oFont01) //"Complicação Neonatal"
		oPrint:Line(nLinIni + 0889, nColIni + 1850, nLinIni + 0936, nColIni + 1850)
		oPrint:Line(nLinIni + 0936, nColIni + 1850, nLinIni + 0936, nColIni + 1897)
		oPrint:Line(nLinIni + 0889, nColIni + 1897, nLinIni + 0936, nColIni + 1897)
		oPrint:Say(nLinIni + 0894, nColIni + 1863, aDados[nX, 30,7], oFont04)
		oPrint:Say(nLinIni + 0904, nColIni + 1910, "- "+"Bx. Peso < 2,5 Kg", oFont01) //"Bx. Peso < 2,5 Kg"
		oPrint:Line(nLinIni + 0889, nColIni + 2130, nLinIni + 0936, nColIni + 2130)
		oPrint:Line(nLinIni + 0936, nColIni + 2130, nLinIni + 0936, nColIni + 2177)
		oPrint:Line(nLinIni + 0889, nColIni + 2177, nLinIni + 0936, nColIni + 2177)
		oPrint:Say(nLinIni + 0894, nColIni + 2143, aDados[nX, 30,8], oFont04)
		oPrint:Say(nLinIni + 0904, nColIni + 2190, "- "+"Parto Cesáreo", oFont01) //"Parto Cesáreo"
		oPrint:Line(nLinIni + 0889, nColIni + 2380, nLinIni + 0936, nColIni + 2380)
		oPrint:Line(nLinIni + 0936, nColIni + 2380, nLinIni + 0936, nColIni + 2427)
		oPrint:Line(nLinIni + 0889, nColIni + 2427, nLinIni + 0936, nColIni + 2427)
		oPrint:Say(nLinIni + 0894, nColIni + 2393, aDados[nX, 30,9], oFont04)
		oPrint:Say(nLinIni + 0904, nColIni + 2440, "- "+"Parto Normal", oFont01) //"Parto Normal"

		oPrint:Box(nLinIni + 0953, nColIni + 0010, nLinIni + 1047, nColIni + 1060)
		oPrint:Say(nLinIni + 0958, nColIni + 0020, "31 - "+"Se óbito em mulher", oFont01) //"Se óbito em mulher"
		oPrint:Line(nLinIni + 0983, nColIni + 0030, nLinIni + 1030, nColIni + 0030)
		oPrint:Line(nLinIni + 1030, nColIni + 0030, nLinIni + 1030, nColIni + 0077)
		oPrint:Line(nLinIni + 0983, nColIni + 0077, nLinIni + 1030, nColIni + 0077)
		oPrint:Say(nLinIni + 0988, nColIni + 0043, aDados[nX, 31], oFont04)
		oPrint:Say(nLinIni + 0998, nColIni + 0090, "1 - "+OemToAnsi("Grávida")+"  "+"2 - "+OemToAnsi("até 42 dias após término gestação")+"  "+"3 - "+"de 43 dias a 12 meses após término gestação", oFont01) //"Grávida"###"at?42 dias após término gestação"###"de 43 dias a 12 meses após término gestação"
		oPrint:Box(nLinIni + 0953, nColIni + 1065, nLinIni + 1047, nColIni + 1800)
		oPrint:Say(nLinIni + 0958, nColIni + 1075, "32 - "+OemToAnsi("Se óbito neonatal"), oFont01) //"Se óbito neonatal"
		oPrint:Line(nLinIni + 0983, nColIni + 1085, nLinIni + 1030, nColIni + 1085)
		oPrint:Line(nLinIni + 1030, nColIni + 1085, nLinIni + 1030, nColIni + 1132)
		oPrint:Line(nLinIni + 0983, nColIni + 1132, nLinIni + 1030, nColIni + 1132)
		oPrint:Say(nLinIni + 0988, nColIni + 1125, Transform(aDados[nX, 32,1], "@E 99"), oFont04,,,,1)
		oPrint:Say(nLinIni + 0998, nColIni + 1145, "- "+OemToAnsi("Qtde. óbito neonatal precoce"), oFont01) //"Qtde. óbito neonatal precoce"
		oPrint:Line(nLinIni + 0983, nColIni + 1455, nLinIni + 1030, nColIni + 1455)
		oPrint:Line(nLinIni + 1030, nColIni + 1455, nLinIni + 1030, nColIni + 1502)
		oPrint:Line(nLinIni + 0983, nColIni + 1502, nLinIni + 1030, nColIni + 1502)
		oPrint:Say(nLinIni + 0988, nColIni + 1495, Transform(aDados[nX, 32,2], "@E 99"), oFont04,,,,1)
		oPrint:Say(nLinIni + 0998, nColIni + 1515, "- "+OemToAnsi("Qtde. óbito neonatal tardio"), oFont01) //"Qtde. óbito neonatal tardio"
		oPrint:Box(nLinIni + 0953, nColIni + 1805, nLinIni + 1047, nColIni + 2125 + IIf(nLayout == 2 .Or. nLayout ==3,nCol2A4/2+30,0))
		oPrint:Say(nLinIni + 0958, nColIni + 1815, "33 - "+OemToansi("Nº Decl.Nasc.Vivos"), oFont01) //"N?Decl.Nasc.Vivos"
		oPrint:Say(nLinIni + 0988, nColIni + 1825 + IIf(nLayout == 2 .Or. nLayout ==3,nCol2A4/2+80,0), aDados[nX, 33], oFont04)
		oPrint:Box(nLinIni + 0953, nColIni + 2130 + IIf(nLayout == 2 .Or. nLayout ==3,nCol2A4/2+30,0), nLinIni + 1047, nColIni + 2530 + nCol2A4/2)
		oPrint:Say(nLinIni + 0958, nColIni + 2140 + IIf(nLayout == 2 .Or. nLayout ==3,nCol2A4/2+30,0), "34 - "+"Qtde.Nasc.Vivos a Termo", oFont01) //"Qtde.Nasc.Vivos a Termo"
		oPrint:Say(nLinIni + 0988, nColIni + 2350 + IIf(nLayout == 2 .Or. nLayout ==3,nCol2A4/2+30,0), Transform(aDados[nX, 34], "@E 9999.99"), oFont04,,,,1)
		oPrint:Box(nLinIni + 0953, nColIni + 2535 + nCol2A4/2, nLinIni + 1047, nColIni + 2935 + nCol2A4/2)
		oPrint:Say(nLinIni + 0958, nColIni + 2545 + nCol2A4/2, "35 - "+"Qtde.Nasc.Mortos", oFont01) //"Qtde.Nasc.Mortos"
		oPrint:Say(nLinIni + 0988, nColIni + 2755 + nCol2A4/2, Transform(aDados[nX, 35], "@E 9999.99"), oFont04,,,,1)
		oPrint:Box(nLinIni + 0953, nColIni + 2940 + nCol2A4/2, nLinIni + 1047, nColIni + 3340 + IIf(nLayout == 2 .Or. nLayout ==3,nCol2A4+5,0))
		oPrint:Say(nLinIni + 0958, nColIni + 2950 + nCol2A4/2, "36 - "+"Qtde.Nasc.Vivos Prematuro", oFont01) //"Qtde.Nasc.Vivos Prematuro"
		oPrint:Say(nLinIni + 0988, nColIni + 3160 + nCol2A4/2, Transform(aDados[nX, 36], "@E 9999.99"), oFont04,,,,1)

		nLinIni += 20
		oPrint:Say(nLinIni + 1052, nColIni + 0010, "Dados da Saída da Internação", oFont01) //"Dados da Saída da Internação"
		oPrint:Box(nLinIni + 1082, nColIni + 0010, nLinIni + 1176, nColIni + 0285)
		oPrint:Say(nLinIni + 1087, nColIni + 0020, "37 - "+"CID 10 Principal", oFont01) //"CID 10 Principal"
		oPrint:Say(nLinIni + 1117, nColIni + 0030, aDados[nX, 37], oFont04)
		oPrint:Box(nLinIni + 1082, nColIni + 0290, nLinIni + 1176, nColIni + 0565)
		oPrint:Say(nLinIni + 1087, nColIni + 0300, "38 - "+"CID 10 (2)", oFont01) //"CID 10 (2)"
		oPrint:Say(nLinIni + 1117, nColIni + 0310, aDados[nX, 38], oFont04)
		oPrint:Box(nLinIni + 1082, nColIni + 0570, nLinIni + 1176, nColIni + 0845)
		oPrint:Say(nLinIni + 1087, nColIni + 0580, "39 - "+"CID 10 (3)", oFont01) //"CID 10 (3)"
		oPrint:Say(nLinIni + 1117, nColIni + 0590, aDados[nX, 39], oFont04)
		oPrint:Box(nLinIni + 1082, nColIni + 0850, nLinIni + 1176, nColIni + 1115)
		oPrint:Say(nLinIni + 1087, nColIni + 0860, "40 - "+"CID 10 (4)", oFont01) //"CID 10 (4)"
		oPrint:Say(nLinIni + 1117, nColIni + 0870, aDados[nX, 40], oFont04)
		oPrint:Box(nLinIni + 1082, nColIni + 1120, nLinIni + 1176, nColIni + 1900)
		oPrint:Say(nLinIni + 1087, nColIni + 1130, "41 - "+"Indicador de Acidente", oFont01) //"Indicador de Acidente"
		oPrint:Line(nLinIni + 1112, nColIni + 1140, nLinIni + 1159, nColIni + 1140)
		oPrint:Line(nLinIni + 1159, nColIni + 1140, nLinIni + 1159, nColIni + 1182)
		oPrint:Line(nLinIni + 1112, nColIni + 1182, nLinIni + 1159, nColIni + 1182)
		oPrint:Say(nLinIni + 1117, nColIni + 1153, aDados[nX, 41], oFont04)
		oPrint:Say(nLinIni + 1127, nColIni + 1200, "0 - "+"Acidente ou doença relacionado ao trabalho"+"   "+"1 - "+"Trânsito"+"   "+"2 - "+"Outros", oFont01) //"Acidente ou doença relacionado ao trabalho"###"Trânsito"###"Outros"
		oPrint:Box(nLinIni + 1082, nColIni + 1905, nLinIni + 1176, nColIni + 2205)
		oPrint:Say(nLinIni + 1087, nColIni + 1915, "42 - "+"Motivo Saída", oFont01) //"Motivo Saída"
		oPrint:Say(nLinIni + 1117, nColIni + 1925, aDados[nX, 42], oFont04)
		oPrint:Box(nLinIni + 1082, nColIni + 2210, nLinIni + 1176, nColIni + 2510)
		oPrint:Say(nLinIni + 1087, nColIni + 2220, "43 - "+"CID 10 Óbito", oFont01) //"CID 10 Óbito"
		oPrint:Say(nLinIni + 1117, nColIni + 2230, aDados[nX, 43], oFont04)
		oPrint:Box(nLinIni + 1082, nColIni + 2515, nLinIni + 1176, nColIni + 3000)
		oPrint:Say(nLinIni + 1087, nColIni + 2525, "44 - "+OemToAnsi("Nº Declaração do Óbito"), oFont01) //"N?Declaração do Óbito"
		oPrint:Say(nLinIni + 1117, nColIni + 2535, aDados[nX, 44], oFont04)

		nLinIni += 20
		oPrint:Say(nLinIni + 1181, nColIni + 0010, "Procedimentos e Exames realizados", oFont01) //"Procedimentos e Exames Realizados"
		oPrint:Box(nLinIni + 1211, nColIni + 0010, nLinIni + 1501, nColIni + 3695 + nColA4)
		oPrint:Say(nLinIni + 1216, nColIni + 0020, "45 - "+"Data", oFont01) //"Data"
		oPrint:Say(nLinIni + 1216, nColIni + 0205, "46 - "+"Hora Inicial", oFont01) //"Hora Inicial"
		oPrint:Say(nLinIni + 1216, nColIni + 0380, "47 - "+"Hora Final", oFont01) //"Hora Final"
		oPrint:Say(nLinIni + 1216, nColIni + 0540, "48 - "+"Tabela", oFont01) //"Tabela"
		oPrint:Say(nLinIni + 1216, nColIni + 0660, "49 - "+"Código do Procedimento", oFont01) //"Código do Procedimento"
		oPrint:Say(nLinIni + 1216, nColIni + 0940, "50 - "+"Descrição", oFont01) //"Descrição"
		oPrint:Say(nLinIni + 1216, nColIni + 2825 + nColA4, "51 - "+"Qtde.", oFont01,,,,1) //"Qtde."
		oPrint:Say(nLinIni + 1216, nColIni + 2855 + nColA4, "52 - "+"Via", oFont01) //"Via"
		oPrint:Say(nLinIni + 1216, nColIni + 2945 + nColA4, "53 - "+"Tec.", oFont01) //"Tec."
		oPrint:Say(nLinIni + 1216, nColIni + 3235 + nColA4, "54 - "+"% Red./Acresc.", oFont01,,,,1) //"% Red./Acresc."
		oPrint:Say(nLinIni + 1216, nColIni + 3465 + nColA4, "55 - "+"Valor Unitário - R$", oFont01,,,,1) //"Valor Unitário - R$"
		oPrint:Say(nLinIni + 1216, nColIni + 3675 + nColA4, "56 - "+"Valor Total - R$", oFont01,,,,1) //"Valor Total - R$"

		nOldLinIni := nLinIni
		if nVolta=1
			nP:=1
		Endif
		nT:=nP+4
		For nI := nP To nT
			if nVolta <> 1
				nN:=nI-(15*nVolta-15)
				oPrint:Say(nLinIni + 1271, nColIni + 0020, AllTrim(Str(nN)) + " - ", oFont01)
			else
				oPrint:Say(nLinIni + 1271, nColIni + 0020, AllTrim(Str(nI)) + " - ", oFont01)
			Endif
			oPrint:Say(nLinIni + 1266, nColIni + 0065, IIf(Empty(aDados[nX, 45, nI]), "", DtoC(aDados[nX, 45, nI])), oFont04)
			oPrint:Say(nLinIni + 1266, nColIni + 0205, IIf(Empty(aDados[nX, 46, nI]), "", Transform(aDados[nX, 46, nI], "@R 99:99")), oFont04)
		   	oPrint:Say(nLinIni + 1266, nColIni + 0380, IIf(Empty(aDados[nX, 47, nI]), "", Transform(aDados[nX, 47, nI], "@R 99:99")), oFont04)
			oPrint:Say(nLinIni + 1266, nColIni + 0540, aDados[nX, 48, nI], oFont04)
			oPrint:Say(nLinIni + 1266, nColIni + 0660, aDados[nX, 49, nI], oFont04)
			oPrint:Say(nLinIni + 1266, nColIni + 0940, aDados[nX, 50, nI], oFont04)
			oPrint:Say(nLinIni + 1266, nColIni + 2825 + nColA4, IIf((aDados[nX, 51, nI])=0, "", Transform(aDados[nX, 51, nI], "@E 9999.99")), oFont04,,,,1)
			oPrint:Say(nLinIni + 1266, nColIni + 2855 + nColA4, aDados[nX, 52, nI], oFont04)
			oPrint:Say(nLinIni + 1266, nColIni + 2945 + nColA4, aDados[nX, 53, nI], oFont04)
			oPrint:Say(nLinIni + 1266, nColIni + 3235 + nColA4, IIf((aDados[nX, 54, nI])=0, "", Transform(aDados[nX, 54, nI], "@E 999.99")), oFont04,,,,1)
			oPrint:Say(nLinIni + 1266, nColIni + 3465 + nColA4, IIf((aDados[nX, 55, nI])=0, "", Transform(aDados[nX, 55, nI], "@E 99,999,999.99")), oFont04,,,,1)
			oPrint:Say(nLinIni + 1266, nColIni + 3675 + nColA4, IIf((aDados[nX, 56, nI])=0, "", Transform(aDados[nX, 56, nI], "@E 99,999,999.99")), oFont04,,,,1)
			nLinIni += 40
		Next nI

		nLinIni := nOldLinIni
	    nP:=nI

		nLinIni += 20
		oPrint:Say(nLinIni + 1506, nColIni + 0010, "Identificação da Equipe", oFont01) //"Identificação da Equipe"
		oPrint:Box(nLinIni + 1536, nColIni + 0010, nLinIni + 1866, nColIni + 3695 + nColA4)
		oPrint:Say(nLinIni + 1541, nColIni + 0020, "57 - "+"Seq.Ref", oFont01) //"Seq.Ref"
		oPrint:Say(nLinIni + 1541, nColIni + 0180, "58 - "+"Gr.Part.", oFont01) //"Gr.Part."
		oPrint:Say(nLinIni + 1541, nColIni + 0320, "59 - "+"Código na Operadora/CPF", oFont01) //"Código na Operadora/CPF"
		oPrint:Say(nLinIni + 1541, nColIni + 0670, "60 - "+"Nome do profissional", oFont01) //"Nome do Profissional"
		oPrint:Say(nLinIni + 1541, nColIni + 2640 + nColA4, "61 - "+"Conselho Prof.", oFont01) //"Conselho Prof."
		oPrint:Say(nLinIni + 1541, nColIni + 2990 + nColA4, "62 - "+"Número Conselho", oFont01) //"Número Conselho"
		oPrint:Say(nLinIni + 1541, nColIni + 3340 + nColA4, "63 - "+"UF", oFont01) //"UF"
		oPrint:Say(nLinIni + 1541, nColIni + 3440 + nColA4, "64 - "+"CPF", oFont01) //"CPF"

		nOldLinIni := nLinIni
		if nVolta=1
			nP1:=1
		Endif
		nT1:=nP1+5
		For nI := nP1 To nT1
			oPrint:Say(nLinIni + 1591, nColIni + 0020, aDados[nX, 57, nI], oFont04)
			oPrint:Say(nLinIni + 1591, nColIni + 0180, aDados[nX, 58, nI], oFont04)
			oPrint:Say(nLinIni + 1591, nColIni + 0320, aDados[nX, 59, nI], oFont04)
			oPrint:Say(nLinIni + 1591, nColIni + 0670, aDados[nX, 60, nI], oFont04)
			oPrint:Say(nLinIni + 1591, nColIni + 2640 + nColA4, aDados[nX, 61, nI], oFont04)
			oPrint:Say(nLinIni + 1591, nColIni + 2990 + nColA4, aDados[nX, 62, nI], oFont04)
			oPrint:Say(nLinIni + 1591, nColIni + 3340 + nColA4, aDados[nX, 63, nI], oFont04)
			oPrint:Say(nLinIni + 1591, nColIni + 3440 + nColA4, IIf(Empty(aDados[nX, 64, nI]), "", Transform(aDados[nX, 64, nI], "@R 999.999.999-99")), oFont04)
			nLinIni += 40
		Next nI

		nP1:=nI
		nLinIni := nOldLinIni

		oPrint:Box(nLinIni + 1871, nColIni + 0010, nLinIni + 1965, nColIni + 0350)
		oPrint:Say(nLinIni + 1876, nColIni + 0020, "73 - "+"Tipo Faturamento R$", oFont01) //"Tipo Faturamento R$"
		oPrint:Line(nLinIni + 1901, nColIni + 0030, nLinIni + 1948, nColIni + 0030)
		oPrint:Line(nLinIni + 1948, nColIni + 0030, nLinIni + 1948, nColIni + 0077)
		oPrint:Line(nLinIni + 1901, nColIni + 0077, nLinIni + 1948, nColIni + 0077)
		oPrint:Say(nLinIni + 1906, nColIni + 0043, aDados[nX, 73,1], oFont04)
		oPrint:Say(nLinIni + 1916, nColIni + 0090, "- "+"Total", oFont01) //"Total"
		oPrint:Line(nLinIni + 1901, nColIni + 0180, nLinIni + 1948, nColIni + 0180)
		oPrint:Line(nLinIni + 1948, nColIni + 0180, nLinIni + 1948, nColIni + 0227)
		oPrint:Line(nLinIni + 1901, nColIni + 0227, nLinIni + 1948, nColIni + 0227)
		oPrint:Say(nLinIni + 1906, nColIni + 0193, aDados[nX, 73,2], oFont04)
		oPrint:Say(nLinIni + 1916, nColIni + 0240, "- "+"Parcial", oFont01) //"Parcial"

		oPrint:Box(nLinIni + 1871, nColIni + 0355, nLinIni + 1965, nColIni + 0827 + nColA4/3)
		oPrint:Say(nLinIni + 1876, nColIni + 0365, "74 - "+"Total Procedimentos R$", oFont01) //"Total Procedimentos R$"
		oPrint:Say(nLinIni + 1906, nColIni + 0807 + nColA4/3, Transform(aDados[nX, 74], "@E 999,999.99"), oFont04,,,,1)
		oPrint:Box(nLinIni + 1871, nColIni + 0832 + nColA4/3, nLinIni + 1965, nColIni + 1304 + nColA4/2)
		oPrint:Say(nLinIni + 1876, nColIni + 0842 + nColA4/3, "75 - "+"Total Diárias R$", oFont01) //"Total Diárias R$"
		oPrint:Say(nLinIni + 1906, nColIni + 1284 + nColA4/2, Transform(aDados[nX, 75], "@E 999,999.99"), oFont04,,,,1)
		oPrint:Box(nLinIni + 1871, nColIni + 1309 + nColA4/2, nLinIni + 1965, nColIni + 1781 + nColA4/2)
		oPrint:Say(nLinIni + 1876, nColIni + 1319 + nColA4/2, "76 - "+"Total Taxas e Aluguéis R$", oFont01) //"Total Taxas e Aluguéis R$"
		oPrint:Say(nLinIni + 1906, nColIni + 1761 + nColA4/2, Transform(aDados[nX, 76], "@E 999,999.99"), oFont04,,,,1)
		oPrint:Box(nLinIni + 1871, nColIni + 1786 + nColA4/2, nLinIni + 1965, nColIni + 2258 + nColA4/2)
		oPrint:Say(nLinIni + 1876, nColIni + 1796 + nColA4/2, "77 - "+"Total Materiais R$", oFont01) //"Total Materiais R$"
		oPrint:Say(nLinIni + 1906, nColIni + 2238 + nColA4/2, Transform(aDados[nX, 77], "@E 999,999.99"), oFont04,,,,1)
		oPrint:Box(nLinIni + 1871, nColIni + 2263 + nColA4/2, nLinIni + 1965, nColIni + 2735 + nColA4/2)
		oPrint:Say(nLinIni + 1876, nColIni + 2273 + nColA4/2, "78 - "+"Total Medicamentos R$", oFont01) //"Total Medicamentos R$"
		oPrint:Say(nLinIni + 1906, nColIni + 2715 + nColA4/2, Transform(aDados[nX, 78], "@E 999,999.99"), oFont04,,,,1)
		oPrint:Box(nLinIni + 1871, nColIni + 2740 + nColA4/2, nLinIni + 1965, nColIni + 3212 + IIF(nLayout == 2,(nCol2A4*2)+70,nCol2A4*2))
		oPrint:Say(nLinIni + 1876, nColIni + 2750 + nColA4/2, "79 - "+"Total Gases Medicinais R$", oFont01) //"Total Gases Medicinais R$"
		oPrint:Say(nLinIni + 1906, nColIni + 3192 + IIF(nLayout == 2,(nCol2A4*2)+70,nCol2A4*2), Transform(aDados[nX, 79], "@E 999,999.99"), oFont04,,,,1)
		oPrint:Box(nLinIni + 1871, nColIni + 3217 + IIF(nLayout == 2,(nCol2A4*2)+70,nCol2A4*2), nLinIni + 1965, nColIni + 3695 + nColA4)
		oPrint:Say(nLinIni + 1876, nColIni + 3227 + IIF(nLayout == 2,(nCol2A4*2)+70,nCol2A4*2), "80 - "+"Total Geral R$", oFont01) //"Total Geral R$"
		oPrint:Say(nLinIni + 1906, nColIni + 3675 + nColA4, Transform(aDados[nX, 80], "@E 999,999.99"), oFont04,,,,1)

		oPrint:Box(nLinIni + 1970, nColIni + 0010, nLinIni + 2158, nColIni + 1340)
		oPrint:Say(nLinIni + 1975, nColIni + 0020, "82 - "+"Data e Assinatura do Contratado", oFont01) //"Data e Assinatura do Contratado"
		oPrint:Say(nLinIni + 2005, nColIni + 0030, DtoC(aDados[nX, 82]), oFont04)
		oPrint:Box(nLinIni + 1970, nColIni + 1345, nLinIni + 2158, nColIni + 2695)
		oPrint:Say(nLinIni + 1975, nColIni + 1355, "83 - "+"Data e Assinatura do(s) Auditor(es) da Operadora", oFont01) //"Data e Assinatura do(s) Auditor(es) da Operadora"
		oPrint:Say(nLinIni + 2005, nColIni + 1365, DtoC(aDados[nX, 83]), oFont04)

		oPrint:EndPage()	// Finaliza a pagina

		//  Verso da Guia
		oPrint:StartPage()	// Inicia uma nova pagina

		nLinIni := 0
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Box Principal                                                 ?
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		oPrint:Box(nLinIni + 0000, nColIni + 0000, nLinIni + nLinMax, nColIni + nColMax)

		nLinIni += 20
		oPrint:Say(nLinIni + 0010, nColIni + 0010, "Procedimentos e Exames Realizados (Continuação)", oFont01) //"Procedimentos e Exames Realizados (Continuação)"
		oPrint:Box(nLinIni + 0040, nColIni + 0010, nLinIni + 0530, nColIni + 3695 + nColA4)
		oPrint:Say(nLinIni + 0045, nColIni + 0020, "45 - "+"Data", oFont01) //"Data"
		oPrint:Say(nLinIni + 0045, nColIni + 0205, "46 - "+"Hora Inicial", oFont01) //"Hora Inicial"
		oPrint:Say(nLinIni + 0045, nColIni + 0380, "47 - "+"Hora Final", oFont01) //"Hora Final"
		oPrint:Say(nLinIni + 0045, nColIni + 0540, "48 - "+"Tabela", oFont01) //"Tabela"
		oPrint:Say(nLinIni + 0045, nColIni + 0660, "49 - "+"Código do Procedimento", oFont01) //"Código do Procedimento"
		oPrint:Say(nLinIni + 0045, nColIni + 0940, "50 - "+"Descrição", oFont01) //"Descrição"
		oPrint:Say(nLinIni + 0045, nColIni + 2855 + nColA4, "51 - "+"Qtde.", oFont01,,,,1) //"Qtde."
		oPrint:Say(nLinIni + 0045, nColIni + 2885 + nColA4, "52 - "+"Via", oFont01) //"Via"
		oPrint:Say(nLinIni + 0045, nColIni + 2975 + nColA4, "53 - "+"Tec.", oFont01) //"Tec."
		oPrint:Say(nLinIni + 0045, nColIni + 3245 + nColA4, "54 - "+"% Red./Acresc.", oFont01,,,,1) //"% Red./Acresc."
		oPrint:Say(nLinIni + 0045, nColIni + 3465 + nColA4, "55 - "+"Valor Unitário - R$", oFont01,,,,1) //"Valor Unitário - R$"
		oPrint:Say(nLinIni + 0045, nColIni + 3675 + nColA4, "56 - "+"Valor Total - R$", oFont01,,,,1) //"Valor Total - R$"

		nOldLinIni := nLinIni

		if nVolta =1
			nP:=6
		Endif
		nT2:=nP+9

		For nI := nP To nT2
			if nVolta<>1
				nN:=nI-((15*nVolta)-15)
				oPrint:Say(nLinIni + 0100, nColIni + 0020, AllTrim(Str(nN)) + " - ", oFont01)
			Else
				oPrint:Say(nLinIni + 0100, nColIni + 0020, AllTrim(Str(nI)) + " - ", oFont01)
			Endif
			oPrint:Say(nLinIni + 0095, nColIni + 0065, if (Empty(aDados[nX, 45, nI]),"",DtoC(aDados[nX, 45, nI])), oFont04)
			oPrint:Say(nLinIni + 0095, nColIni + 0205, if (Empty(aDados[nX, 46, nI]),"",Transform(aDados[nX, 46, nI], "@R 99:99")), oFont04)
		   	oPrint:Say(nLinIni + 0095, nColIni + 0380, if (Empty(aDados[nX, 47, nI]),"",Transform(aDados[nX, 47, nI], "@R 99:99")), oFont04)
			oPrint:Say(nLinIni + 0095, nColIni + 0540, aDados[nX, 48, nI], oFont04)
			oPrint:Say(nLinIni + 0095, nColIni + 0660, aDados[nX, 49, nI], oFont04)
			oPrint:Say(nLinIni + 0095, nColIni + 0940, aDados[nX, 50, nI], oFont04)
			oPrint:Say(nLinIni + 0095, nColIni + 2855 + nColA4, IIf((aDados[nX, 51, nI])=0, "", Transform(aDados[nX, 51, nI], "@E 9999.99")), oFont04,,,,1)
			oPrint:Say(nLinIni + 0095, nColIni + 2885 + nColA4, aDados[nX, 52, nI], oFont04)
			oPrint:Say(nLinIni + 0095, nColIni + 2975 + nColA4, aDados[nX, 53, nI], oFont04)
			oPrint:Say(nLinIni + 0095, nColIni + 3245 + nColA4, IIf((aDados[nX, 54, nI])=0, "", Transform(aDados[nX, 54, nI], "@E 999.99")), oFont04,,,,1)
			oPrint:Say(nLinIni + 0095, nColIni + 3465 + nColA4, IIf((aDados[nX, 55, nI])=0, "", Transform(aDados[nX, 55, nI], "@E 99,999,999.99")), oFont04,,,,1)
			oPrint:Say(nLinIni + 0095, nColIni + 3675 + nColA4, IIf((aDados[nX, 56, nI])=0, "", Transform(aDados[nX, 56, nI], "@E 99,999,999.99")), oFont04,,,,1)
			nLinIni += 40
		Next nI

		nP:=nI

		if nVolta=1
			nP3:=len(aDados[nX,49])
		Endif

		if nP3 >nI-1
			lImpnovo:=.T.
		Endif

		nLinIni := nOldLinIni

		nLinIni += 20
		oPrint:Say(nLinIni + 0535, nColIni + 0010, "Identificação da Equipe (Continuação)", oFont01) //"Identificação da Equipe (Continuação)"
		oPrint:Box(nLinIni + 0565, nColIni + 0010, nLinIni + 1215, nColIni + 3695 + nColA4)
		oPrint:Say(nLinIni + 0570, nColIni + 0020, "57 - "+"Seq.Ref", oFont01) //"Seq.Ref"
		oPrint:Say(nLinIni + 0570, nColIni + 0180, "58 - "+"Gr.Part.", oFont01) //"Gr.Part."
		oPrint:Say(nLinIni + 0570, nColIni + 0320, "59 - "+"Código na Operadora/CPF", oFont01) //"Código na Operadora/CPF"
		oPrint:Say(nLinIni + 0570, nColIni + 0670, "60 - "+"Nome do profissional", oFont01) //"Nome do Profissional"
		oPrint:Say(nLinIni + 0570, nColIni + 2640 + nColA4, "61 - "+"Conselho Prof.", oFont01) //"Conselho Prof."
		oPrint:Say(nLinIni + 0570, nColIni + 2990 + nColA4, "62 - "+"Número Conselho", oFont01) //"Número Conselho"
		oPrint:Say(nLinIni + 0570, nColIni + 3340 + nColA4, "63 - "+"UF", oFont01) //"UF"
		oPrint:Say(nLinIni + 0570, nColIni + 3440 + nColA4, "64 - "+"CPF", oFont01) //"CPF"

		nOldLinIni := nLinIni
		if nVolta =1
			nP1:=7
		Endif
		nT3:=nP1+13

		For nI := nP1 To nT3
			oPrint:Say(nLinIni + 0620, nColIni + 0020, aDados[nX, 57, nI], oFont04)
			oPrint:Say(nLinIni + 0620, nColIni + 0180, aDados[nX, 58, nI], oFont04)
			oPrint:Say(nLinIni + 0620, nColIni + 0320, aDados[nX, 59, nI], oFont04)
			oPrint:Say(nLinIni + 0620, nColIni + 0670, aDados[nX, 60, nI], oFont04)
			oPrint:Say(nLinIni + 0620, nColIni + 2640 + nColA4, aDados[nX, 61, nI], oFont04)
			oPrint:Say(nLinIni + 0620, nColIni + 2990 + nColA4, aDados[nX, 62, nI], oFont04)
			oPrint:Say(nLinIni + 0620, nColIni + 3340 + nColA4, aDados[nX, 63, nI], oFont04)
			oPrint:Say(nLinIni + 0620, nColIni + 3440 + nColA4, IIf(Empty(aDados[nX, 57, nI]), "", Transform(aDados[nX, 64, nI], "@R 999.999.999-99")), oFont04)
			nLinIni += 40
		Next nI

		nP1:=nI

		if nVolta=1
			nP2:=len(aDados[nX,57])
		Endif

		if nP2 >nI-1
			lImpnovo:=.T.
		Endif

		nLinIni := nOldLinIni

		nLinIni += 20
		oPrint:Say(nLinIni + 1220, nColIni + 0020, "OPM Utilizados", oFont01) //"OPM Utilizados"
		oPrint:Box(nLinIni + 1250, nColIni + 0010, nLinIni + 1540, nColIni + 3695 + nColA4)
		oPrint:Say(nLinIni + 1255, nColIni + 0020, "65 - "+"Tabela", oFont01) //"Tabela"
		oPrint:Say(nLinIni + 1255, nColIni + 0160, "66 - "+"Código do OPM", oFont01) //"Código do OPM"
		oPrint:Say(nLinIni + 1255, nColIni + 0410, "67 - "+"Descrição OPM", oFont01) //"Descrição OPM"
		oPrint:Say(nLinIni + 1255, nColIni + 2465 + nColA4, "68 - "+"Qtde.", oFont01,,,,1) //"Qtde."
		oPrint:Say(nLinIni + 1255, nColIni + 2505 + nColA4, "69 - "+"Código de Barras", oFont01) //"Código de Barras"
		oPrint:Say(nLinIni + 1255, nColIni + 3390 + nColA4, "70 - "+"Valor Unitário - R$", oFont01,,,,1) //"Valor Unitário - R$"
		oPrint:Say(nLinIni + 1255, nColIni + 3665 + nColA4, "71 - "+"Valor Total - R$", oFont01,,,,1) //"Valor Total - R$"

		nOldLinIni := nLinIni

		if nVolta=1
			nP4:=1
		Endif
		nT4:=nP4+4

		For nI := nP4 To nT4
			if nVolta <> 1
				nN:=nI-((nVolta*5)-5)
				oPrint:Say(nLinIni + 1305, nColIni + 0020, AllTrim(Str(nN)) + " - ", oFont01)
			else
				oPrint:Say(nLinIni + 1305, nColIni + 0020, AllTrim(Str(nI)) + " - ", oFont01)
            Endif
			oPrint:Say(nLinIni + 1300, nColIni + 0065, aDados[nX, 65, nI], oFont04)
			oPrint:Say(nLinIni + 1300, nColIni + 0160, aDados[nX, 66, nI], oFont04)
			oPrint:Say(nLinIni + 1300, nColIni + 0410, aDados[nX, 67, nI], oFont04)
			oPrint:Say(nLinIni + 1300, nColIni + 2465 + nColA4, IIf(Empty(aDados[nX, 68, nI]), "", Transform(aDados[nX, 68, nI], "@E 9999.99")), oFont04,,,,1)
			oPrint:Say(nLinIni + 1300, nColIni + 2505 + nColA4, aDados[nX, 69, nI], oFont04)
			oPrint:Say(nLinIni + 1300, nColIni + 3390 + nColA4, IIf(Empty(aDados[nX, 70, nI]), "", Transform(aDados[nX, 70, nI], "@E 999,999,999.99")), oFont04,,,,1)
			oPrint:Say(nLinIni + 1300, nColIni + 3665 + nColA4, IIf(Empty(aDados[nX, 71, nI]), "", Transform(aDados[nX, 71, nI], "@E 999,999,999.99")), oFont04,,,,1)
			nLinIni += 40
		Next nI

		nP4:=nI

		if nVolta=1
			nP5:=len(aDados[nX,66])
		Endif

		if nP5 >nI-1
			lImpnovo:=.T.
		Endif

		nLinIni := nOldLinIni

		oPrint:Box(nLinIni + 1545, nColIni + 3295 + nColA4, nLinIni + 1639, nColIni + 3695 + nColA4)
		oPrint:Say(nLinIni + 1550, nColIni + 3305 + nColA4, "72 - "+"Total Geral R$", oFont01) //"Total Geral R$"
		oPrint:Say(nLinIni + 1580, nColIni + 3675 + nColA4, Transform(aDados[nX, 72], "@E 999,999,999.99"), oFont04,,,,1)

		oPrint:Box(nLinIni + 1644, nColIni + 0010, nLinIni + 1864, nColIni + 3695 + nColA4)
		oPrint:Say(nLinIni + 1649, nColIni + 0020, "81 - "+"Observação", oFont01) //"Observação"

		nLin := 1684

		For nI := 1 To MlCount(aDados[nX, 81], 130)
			cObs := MemoLine(aDados[nX, 81], 130, nI)
			oPrint:Say(nLinIni + nLin, nColIni + 0030, cObs, oFont04)
			nLin += 35
		Next nI

		oPrint:EndPage()	// Finaliza a pagina

	Next nX

Enddo

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
±±³Fun‡ao    ?PLSTISS5  ?Autor ?Luciano Aparecido     ?Data ?06.03.07 ³±?
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡ao ?Estrutura Relatório TISS (Guia Hon Individual) -BOPS 095189 ³±?
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±?Uso      ?SigaPLS                                                     ³±?
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros?aDados - Array com as informações do relat´rio              ³±?
±±?         ?lGerTXT - Define se imprime direto sem passar pela tela 	   ³±?
±±?         ?		 de configuracao/preview do relatorio 		       ³±?
±±?         ?nLayout - Define o formato de papél para impressao:         ³±?
±±?         ?          1 - Formato Ofício II (216x330mm)                 ³±?
±±?         ?          2 - Formato A4 (210x297mm)                        ³±?
±±?         ? 		 3 - Formato Carta (216x279mm)     			       ³±?
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function CABTISS5(aDados, lGerTXT, nLayout, cLogoGH, lWeb, cPathRelW, lUnicaImp)

	Local nLinMax
	Local nColMax
	Local nLinIni	:=	0		// Linha Lateral (inicial) Esquerda
	Local nColIni	:=	0		// Coluna Lateral (inicial) Esquerda
	Local nColA4    :=  0
	Local nCol2A4   :=  0
	Local cFileLogo
	Local lPrinter
	Local nLin
	Local nOldLinIni
	Local nI, nJ, nX
	Local cObs
	Local oFont01
	Local oFont02n
	Local oFont03n
	Local oFont04
	Local nAte		:= 10
	Local lImpNovo	:= .T.
	Local nIni		:= 1
	Local cRel      := "guihind"
	Local oPrint	:= nil
	Local cPathSrvJ := GETMV("MV_RELT")
	Local nTweb		:= 1
	Local nLweb		:= 0
	Local nLwebC	:= 0

	Default lUnicaImp := .F.
	Default lGerTXT := .F.
	Default nLayout := 2
	Default cLogoGH := ''
	Default lWeb    := .F.
	Default cPathRelW := ''
	Default aDados := { { ;
						"123456",;
						"12345678901234567892",;
						"12345678901234567892",;
						CtoD("01/01/07"),;
						"12345678901234567892",;
						Replicate("M",40),;
						CtoD("12/12/07"),;
						Replicate("M",70),;
						"123456789102345",;
						"14.141.114/00001-35",;
						Replicate("M",70),;
						"1234567",;
						"14.141.114/00001-35",;
						Replicate("M",70),;
						"1234567",;
						{ "01", "COLETIVO" },;
						"01",;
						Replicate("M",70),;
						"1234567",;
						"123456789102345",;
						"DF",;
						"12345678910",;
						{ CtoD("12/03/06"),CtoD("12/03/06"),CtoD("12/03/06"),CtoD("12/03/06"),CtoD("12/03/06"),CtoD("12/03/06"),CtoD("12/03/06"),CtoD("12/03/06"),CtoD("12/03/06"),CtoD("12/03/06") },;
						{ "0107","0207","0307","0407","0507","0507","0507","0507","0507","0507" },;
						{ "0607","0707","0807","0907","1007","0507","0507","0507","0507","0507" },;
						{ "MM","AA","BB","CC","DD","DD","DD","DD","DD","DD" },;
						{ "5678901234","5678901234","5678901234","5678901234","5678901234","5678901234","5678901234","5678901234","5678901234","5678901234"},;
						{ Replicate("M",60),Replicate("E",60),Replicate("E",60),Replicate("E",60),Replicate("E",60),Replicate("E",60),Replicate("E",60),Replicate("E",60),Replicate("E",60),Replicate("E",60)},;
						{ 12,1,2,3,4,4,4,4,4,4 },;
						{ "D","D","D","D","D","D","D","D","D","D"},;
						{ "M","E","F","G","H","D","D","D","D","D" },;
						{ 111.00,222.00,333.00,444.00,999.99,999.99,999.99,999.99,999.99,999.99 },;
						{ 99999.99,22222.22,33.33,44444.44,11111.11,11111.11,11111.11,11111.11,11111.11,11111.11 },;
						{ 11111.11,55555.00,66666.00,77777.00,88888.00,88888.00,88888.00,88888.00,88888.00,88888.00 },;
						3999999.99,;
						Replicate("M", 240),;
						CtoD("01/01/07"),;
						{ CtoD("04/01/07"), "0101" } } }

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

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
	//?Nao permite acionar a impressao quando for na web.
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
	If lWeb
		cPathSrvJ := cPathRelW
		cFileName := cRel+lower(CriaTrab(NIL,.F.))+".pdf"
	Else
		cFileName := cRel+CriaTrab(NIL,.F.)
	EndIf

	if !lWeb
	oPrint	:= TMSPrinter():New(OemToAnsi("GUIA DE HONORÁRIO INDIVIDUAL")) //"GUIA DE HONORARIO INDIVIDUAL"
	else
		oPrint := FWMSPrinter():New ( cFileName	,,.F.,cPathSrvJ	 ,.T.,	,@oPrint,			  ,			  ,	.F.			,.f.)
		If lSrvUnix
			AjusPath(@oPrint)
		EndIf
		oPrint:cPathPDF := cPathSrvJ
		nTweb		:= 3.9
		nLweb		:= 10
		nLwebC		:= -3
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


	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
	//³Device
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
	If lWeb
		oPrint:setDevice(IMP_PDF)
	Else
	// Verifica se existe alguma impressora configurada para Impressao Grafica
	lPrinter := oPrint:IsPrinterActive()

	If ! lPrinter
		oPrint:Setup()
	EndIf
	Endif

	For nX := 1 To Len(aDados)

		nAte 	:= 10
		nI		:= 0
		nIni	:= 1

		//Esta condição do código faz com que
		//imprima mais de uma guia.
		If lUnicaImp
			If nX <= Len(aDados)
				lImpNovo := .T.
			EndIf
		EndIf

		While lImpNovo

			lImpNovo 	:= .F.

			If  ValType(aDados[nX]) == 'U' .OR. Len(aDados[nX]) == 0
				Loop
			EndIf

			For nI := 23 To 34
				If Len(aDados[nX, nI]) < 10
					For nJ := Len(aDados[nX, nI]) + 1 To 10
						If AllTrim(Str(nI)) $ "23"
							aAdd(aDados[nX, nI], StoD(""))
						ElseIf AllTrim(Str(nI)) $ "29,32,33,34"
							aAdd(aDados[nX, nI], 0)
						Else
							aAdd(aDados[nX, nI], "")
						EndIf
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
			//³Box Principal                                                 ?
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			oPrint:Box((nLinIni + 0000)/nTweb, (nColIni + 0000)/nTweb, (nLinIni + nLinMax)/nTweb, (nColIni + nColMax)/nTweb)

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Carrega e Imprime Logotipo da Empresa                         ?
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
			Endif

			oPrint:Say(3*nLweb+(nLinIni + 0080)/nTweb, (nColIni + 1852 + IIf(nLayout == 2,nColA4,nCol2A4))/nTweb, OemToAnsi("GUIA DE HONORÁRIO INDIVIDUAL"), oFont02n,,,, 2) //"GUIA DE HONORÁRIO INDIVIDUAL"
			oPrint:Say(3*nLweb+(nLinIni + 0090)/nTweb, (nColIni + 3000 + nColA4)/nTweb, "2 - "+OemToAnsi("Nº"), oFont01) //"N?
			oPrint:Say(3*nLweb+(nLinIni + 0090)/nTweb, (nColIni + 3096 + nColA4)/nTweb, aDados[nX, 02], oFont03n)

			nLinIni += 60
			oPrint:Box((nLinIni + 0175)/nTweb, (nColIni + 0010)/nTweb, (nLinIni + 0269)/nTweb, (nColIni + 0315)/nTweb)
			oPrint:Say(nLweb+nLwebC+(nLinIni + 0180)/nTweb, (nColIni + 0020)/nTweb, "1 - "+"Registro ANS", oFont01) //"Registro ANS"
			oPrint:Say(nLweb+(nLinIni + 0210)/nTweb, (nColIni + 0030)/nTweb, aDados[nX, 01], oFont04)
			oPrint:Box((nLinIni + 0175)/nTweb, (nColIni + 0320)/nTweb, (nLinIni + 0269)/nTweb, (nColIni + 1035)/nTweb)
			oPrint:Say(nLweb+nLwebC+(nLinIni + 0180)/nTweb, (nColIni + 0330)/nTweb, "3 - "+OemToAnsi("Nº Guia de Solicitação/Senha"), oFont01) //"N?Guia de Solicitação/Senha"
			oPrint:Say(nLweb+(nLinIni + 0210)/nTweb, (nColIni + 0340)/nTweb, aDados[nX, 03], oFont04)
			oPrint:Box((nLinIni + 0175)/nTweb, (nColIni + 1040)/nTweb, (nLinIni + 0269)/nTweb, (nColIni + 1345)/nTweb)
			oPrint:Say(nLweb+nLwebC+(nLinIni + 0180)/nTweb, (nColIni + 1050)/nTweb, "4 - "+"Data de Emissão da Guia", oFont01) //"Data de Emissao da Guia"
			oPrint:Say(nLweb+(nLinIni + 0210)/nTweb, (nColIni + 1060)/nTweb, Iif(valtype(aDados[nX, 04])=="C",aDados[nX, 04],DtoC(aDados[nX, 04])), oFont04)

			nLinIni += 20
			oPrint:Say(nLweb+nLwebC+(nLinIni + 0274)/nTweb, (nColIni + 0010)/nTweb, "Dados do Beneficiário", oFont01) //"Dados do Beneficiário"
			oPrint:Box((nLinIni + 0304)/nTweb, (nColIni + 0010)/nTweb, (nLinIni + 0398)/nTweb, (nColIni + 0425)/nTweb)
			oPrint:Say(nLweb+nLwebC+(nLinIni + 0309)/nTweb, (nColIni + 0020)/nTweb, "5 - "+"Número da Carteira", oFont01) //"Número da Carteira"
			oPrint:Say(nLweb+(nLinIni + 0339)/nTweb, (nColIni + 0030)/nTweb, aDados[nX, 05], oFont04)
			oPrint:Box((nLinIni + 0304)/nTweb, (nColIni + 0430)/nTweb, (nLinIni + 0398)/nTweb, (nColIni + 1572)/nTweb)
			oPrint:Say(nLweb+nLwebC+(nLinIni + 0309)/nTweb, (nColIni + 0440)/nTweb, "6 - "+"Plano", oFont01) //"Plano"
			oPrint:Say(nLweb+(nLinIni + 0339)/nTweb, (nColIni + 0450)/nTweb, aDados[nX, 06], oFont04)
			oPrint:Box((nLinIni + 0304)/nTweb, (nColIni + 1577)/nTweb, (nLinIni + 0398)/nTweb, (nColIni + 1835)/nTweb)
			oPrint:Say(nLweb+nLwebC+(nLinIni + 0309)/nTweb, (nColIni + 1587)/nTweb, "7 - "+"Validade da Carteira", oFont01) //"Validade da Carteira"
			oPrint:Say(nLweb+(nLinIni + 0339)/nTweb, (nColIni + 1597)/nTweb, Iif(valtype(aDados[nX, 07])=="C",aDados[nX, 07],DtoC(aDados[nX, 07])), oFont04)

			oPrint:Box((nLinIni + 0403)/nTweb, (nColIni + 0010)/nTweb, (nLinIni + 0497)/nTweb, (nColIni + 3090 + nColA4)/nTweb)
			oPrint:Say(nLweb+nLwebC+(nLinIni + 0408)/nTweb, (nColIni + 0020)/nTweb, "8 - "+"Nome", oFont01) //"Nome"
			oPrint:Say(nLweb+(nLinIni + 0438)/nTweb, (nColIni + 0030)/nTweb, aDados[nX, 08], oFont04)
			oPrint:Box((nLinIni + 0403)/nTweb, (nColIni + 3095 + nColA4)/nTweb, (nLinIni + 0497)/nTweb, (nColIni + 3695 + nColA4)/nTweb)
			oPrint:Say(nLweb+nLwebC+(nLinIni + 0408)/nTweb, (nColIni + 3105 + nColA4)/nTweb, "9 - "+"Número do Cartão Nacional de Saúde", oFont01) //"Número do Cartão Nacional de Saúde"
			oPrint:Say(nLweb+(nLinIni + 0438)/nTweb, (nColIni + 3115 + nColA4)/nTweb, aDados[nX, 09], oFont04)

			nLinIni += 20
			oPrint:Say(nLweb+nLwebC+(nLinIni + 0502)/nTweb, (nColIni + 0010)/nTweb, "Dados do Contratado (onde foi executado o procedimento)", oFont01) //"Dados do Contratado (onde foi executado o procedimento)"
			oPrint:Box((nLinIni + 0532)/nTweb, (nColIni + 0010)/nTweb, (nLinIni + 0626)/nTweb, (nColIni + 0426)/nTweb)
			oPrint:Say(nLweb+nLwebC+(nLinIni + 0537)/nTweb, (nColIni + 0020)/nTweb, "10 - "+"Código na Operadora / CNPJ / CPF", oFont01) //"Código na Operadora / CNPJ / CPF"
			oPrint:Say(nLweb+(nLinIni + 0567)/nTweb, (nColIni + 0030)/nTweb, aDados[nX, 10], oFont04)
			oPrint:Box((nLinIni + 0532)/nTweb, (nColIni + 0431)/nTweb, (nLinIni + 0626)/nTweb, (nColIni + 2365)/nTweb)
			oPrint:Say(nLweb+nLwebC+(nLinIni + 0537)/nTweb, (nColIni + 0441)/nTweb, "11 - "+"Nome do Contratado", oFont01) //"Nome do Contratado"
			oPrint:Say(nLweb+(nLinIni + 0567)/nTweb, (nColIni + 0451)/nTweb, aDados[nX, 11], oFont04)
			oPrint:Box((nLinIni + 0532)/nTweb, (nColIni + 2370)/nTweb, (nLinIni + 0626)/nTweb, (nColIni + 2580)/nTweb)
			oPrint:Say(nLweb+nLwebC+(nLinIni + 0537)/nTweb, (nColIni + 2380)/nTweb, "12 - "+"Código CNES", oFont01) //"Código CNES"
			oPrint:Say(nLweb+(nLinIni + 0567)/nTweb, (nColIni + 2390)/nTweb, aDados[nX, 12], oFont04)

			nLinIni += 20
			oPrint:Say(nLweb+nLwebC+(nLinIni + 0631)/nTweb, (nColIni + 0010)/nTweb, "Dados do Contratado Executante", oFont01) //"Dados do Contratado Executante"
			oPrint:Box((nLinIni + 0661)/nTweb, (nColIni + 0010)/nTweb, (nLinIni + 0755)/nTweb, (nColIni + 0426)/nTweb)
			oPrint:Say(nLweb+nLwebC+(nLinIni + 0666)/nTweb, (nColIni + 0020)/nTweb, "13 - "+"Código na Operadora / CNPJ / CPF", oFont01) //"Código na Operadora / CNPJ / CPF"
			oPrint:Say(nLweb+(nLinIni + 0696)/nTweb, (nColIni + 0030)/nTweb, aDados[nX, 13], oFont04)
			oPrint:Box((nLinIni + 0661)/nTweb, (nColIni + 0431)/nTweb, (nLinIni + 0755)/nTweb, (nColIni + 2365)/nTweb)
			oPrint:Say(nLweb+nLwebC+(nLinIni + 0666)/nTweb, (nColIni + 0441)/nTweb, "14 - "+"Nome do Contratado Executante", oFont01) //"Nome do Contratado Executante"
			oPrint:Say(nLweb+(nLinIni + 0696)/nTweb, (nColIni + 0451)/nTweb, aDados[nX, 14], oFont04)
			oPrint:Box((nLinIni + 0661)/nTweb, (nColIni + 2370)/nTweb, (nLinIni + 0755)/nTweb, (nColIni + 2580)/nTweb)
			oPrint:Say(nLweb+nLwebC+(nLinIni + 0666)/nTweb, (nColIni + 2380)/nTweb, "15 - "+"Código CNES", oFont01) //"Código CNES"
			oPrint:Say(nLweb+(nLinIni + 0696)/nTweb, (nColIni + 2390)/nTweb, aDados[nX, 15], oFont04)
			oPrint:Box((nLinIni + 0661)/nTweb, (nColIni + 2585)/nTweb, (nLinIni + 0755)/nTweb, (nColIni + 3150)/nTweb)
			oPrint:Say(nLweb+nLwebC+(nLinIni + 0666)/nTweb, (nColIni + 2595)/nTweb, "16 - "+"Tipo da Acomodação Autorizada", oFont01) //"Tipo da Acomodação Autorizada"
			oPrint:Say(nLweb+(nLinIni + 0696)/nTweb, (nColIni + 2605)/nTweb, aDados[nX, 16, 1] + " - " + aDados[nX, 16, 2], oFont04)

			oPrint:Box((nLinIni + 0761)/nTweb, (nColIni + 0010)/nTweb, (nLinIni + 0855)/nTweb, (nColIni + 0205)/nTweb)
			oPrint:Say(nLweb+nLwebC+(nLinIni + 0766)/nTweb, (nColIni + 0020)/nTweb, "17 - "+"Grau Part.", oFont01) //"Grau Part."
			oPrint:Say(nLweb+(nLinIni + 0796)/nTweb, (nColIni + 0030)/nTweb, SubStr(aDados[nX, 17], 1, 54), oFont04)
			oPrint:Box((nLinIni + 0761)/nTweb, (nColIni + 0210)/nTweb, (nLinIni + 0855)/nTweb, (nColIni + 2134)/nTweb)
			oPrint:Say(nLweb+nLwebC+(nLinIni + 0766)/nTweb, (nColIni + 0220)/nTweb, "18 - "+"Nome do Profissional Executante", oFont01) //"Nome do Profissional Executante"
			oPrint:Say(nLweb+(nLinIni + 0796)/nTweb, (nColIni + 0230)/nTweb, aDados[nX, 18], oFont04)
			oPrint:Box((nLinIni + 0761)/nTweb, (nColIni + 2139)/nTweb, (nLinIni + 0855)/nTweb, (nColIni + 2412)/nTweb)
			oPrint:Say(nLweb+nLwebC+(nLinIni + 0766)/nTweb, (nColIni + 2149)/nTweb, "19 - "+"Conselho Profissional", oFont01) //"Conselho Profissional"
			oPrint:Say(nLweb+(nLinIni + 0796)/nTweb, (nColIni + 2159)/nTweb, aDados[nX, 19], oFont04)
			oPrint:Box((nLinIni + 0761)/nTweb, (nColIni + 2417)/nTweb, (nLinIni + 0855)/nTweb, (nColIni + 2751)/nTweb)
			oPrint:Say(nLweb+nLwebC+(nLinIni + 0766)/nTweb, (nColIni + 2427)/nTweb, "20 - "+"Número no Conselho", oFont01) //"Número no Conselho"
			oPrint:Say(nLweb+(nLinIni + 0796)/nTweb, (nColIni + 2437)/nTweb, aDados[nX, 20], oFont04)
			oPrint:Box((nLinIni + 0761)/nTweb, (nColIni + 2756)/nTweb, (nLinIni + 0855)/nTweb, (nColIni + 2855)/nTweb)
			oPrint:Say(nLweb+nLwebC+(nLinIni + 0766)/nTweb, (nColIni + 2766)/nTweb, "21 - "+"UF", oFont01) //"UF"
			oPrint:Say(nLweb+(nLinIni + 0796)/nTweb, (nColIni + 2776)/nTweb, aDados[nX, 21], oFont04)
			oPrint:Box((nLinIni + 0761)/nTweb, (nColIni + 2860)/nTweb, (nLinIni + 0855)/nTweb, (nColIni + 3150)/nTweb)
			oPrint:Say(nLweb+nLwebC+(nLinIni + 0766)/nTweb, (nColIni + 2870)/nTweb, "22 - "+"Número no CPF", oFont01) //"Número no CPF"
			oPrint:Say(nLweb+(nLinIni + 0796)/nTweb, (nColIni + 2880)/nTweb, Transform(aDados[nX, 22], "@R 999.999.999-99"), oFont04)

			nLinIni += 20
			oPrint:Say(nLweb+nLwebC+(nLinIni + 0861)/nTweb, (nColIni + 0010)/nTweb, "Procedimentos Realizados", oFont01) //"Procedimentos Realizados"
			oPrint:Box((nLinIni + 0891)/nTweb, (nColIni + 0010)/nTweb, (nLinIni + 1671)/nTweb, (nColIni + 3695 + nColA4)/nTweb)
			oPrint:Say(nLweb+nLwebC+(nLinIni + 0896)/nTweb, (nColIni + 0020)/nTweb, "23 - "+"Data", oFont01) //"Data"
			oPrint:Say(nLweb+nLwebC+(nLinIni + 0896)/nTweb, (nColIni + 0205)/nTweb, "24 - "+"Hora Inicial", oFont01) //"Hora Inicial"
			oPrint:Say(nLweb+nLwebC+(nLinIni + 0896)/nTweb, (nColIni + 0380)/nTweb, "25 - "+"Hora Final", oFont01) //"Hora Final"
			oPrint:Say(nLweb+nLwebC+(nLinIni + 0896)/nTweb, (nColIni + 0540)/nTweb, "26 - "+"Tabela", oFont01) //"Tabela"
			oPrint:Say(nLweb+nLwebC+(nLinIni + 0896)/nTweb, (nColIni + 0660)/nTweb, "27 - "+"Código do Procedimento", oFont01) //"Código do Procedimento"
			oPrint:Say(nLweb+nLwebC+(nLinIni + 0896)/nTweb, (nColIni + 0940)/nTweb, "28 - "+"Descrição", oFont01) //"Descrição"
			oPrint:Say(nLweb+nLwebC+(nLinIni + 0896)/nTweb, (nColIni + 2575 + IIF (nLayout == 2 ,nColA4+0,nCol2A4))/nTweb, "29 - "+"Qtde.", oFont01,,,,1) //"Qtde."
			oPrint:Say(nLweb+nLwebC+(nLinIni + 0896)/nTweb, (nColIni + 2675 + IIF (nLayout == 2 ,nColA4+0,nCol2A4))/nTweb, "30 - "+"Via", oFont01) //"Via"
			oPrint:Say(nLweb+nLwebC+(nLinIni + 0896)/nTweb, (nColIni + 2760 + IIF (nLayout == 2 ,nColA4+0,nCol2A4))/nTweb, "31 - "+"Tec.", oFont01) //"Tec."
			oPrint:Say(nLweb+nLwebC+(nLinIni + 0896)/nTweb, (nColIni + 3045 + IIF (nLayout == 2 ,nColA4+0,nCol2A4))/nTweb, "32 - "+"% Red./Acresc.", oFont01,,,,1) //"% Red./Acresc."
			oPrint:Say(nLweb+nLwebC+(nLinIni + 0896)/nTweb, (nColIni + 3275 + IIF (nLayout == 2 ,nColA4+0,nCol2A4))/nTweb, "33 - "+"Valor Unitário - R$", oFont01,,,,1) //"Valor Unitário - R$"
			oPrint:Say(nLweb+nLwebC+(nLinIni + 0896)/nTweb, (nColIni + 3505 + IIF (nLayout == 2 ,nColA4+0,nCol2A4))/nTweb, "34 - "+"Valor Total - R$", oFont01,,,,1) //"Valor Total - R$"

			nOldLinIni := nLinIni
			For nI := nIni To nAte

				If Len(aDados[nX, 23]) >= nI
					oPrint:Say(nLweb+(nLinIni + 0961)/nTweb, (nColIni + 0020)/nTweb, AllTrim(Str(nI)) + " - ", oFont01)
					oPrint:Say(nLweb+(nLinIni + 0956)/nTweb, (nColIni + 0065)/nTweb, IIf(Empty(aDados[nX, 23, nI]), "", Iif(valtype(aDados[nX, 23, nI])=="C",aDados[nX, 23, nI],DtoC(aDados[nX, 23, nI]) )) , oFont04)
					oPrint:Say(nLweb+(nLinIni + 0956)/nTweb, (nColIni + 0205)/nTweb, IIf(Empty(aDados[nX, 24, nI]), "", Transform(aDados[nX, 24, nI], "@R 99:99")), oFont04)
					oPrint:Say(nLweb+(nLinIni + 0956)/nTweb, (nColIni + 0380)/nTweb, IIf(Empty(aDados[nX, 25, nI]), "", Transform(aDados[nX, 25, nI], "@R 99:99")), oFont04)
					oPrint:Say(nLweb+(nLinIni + 0956)/nTweb, (nColIni + 0540)/nTweb, aDados[nX, 26, nI], oFont04)
					oPrint:Say(nLweb+(nLinIni + 0956)/nTweb, (nColIni + 0660)/nTweb, aDados[nX, 27, nI], oFont04)
					oPrint:Say(nLweb+(nLinIni + 0956)/nTweb, (nColIni + 0940)/nTweb, aDados[nX, 28, nI], oFont04)
					oPrint:Say(nLweb+(nLinIni + 0956)/nTweb, (nColIni + 2575 + IIF (nLayout == 2 ,nColA4+0,nCol2A4))/nTweb, IIf(Empty(aDados[nX, 29, nI]), "", Transform(aDados[nX, 29, nI], "@E 9999.99")), oFont04,,,,1)
					oPrint:Say(nLweb+(nLinIni + 0956)/nTweb, (nColIni + 2675 + IIF (nLayout == 2 ,nColA4+0,nCol2A4))/nTweb, aDados[nX, 30, nI], oFont04)
					oPrint:Say(nLweb+(nLinIni + 0956)/nTweb, (nColIni + 2760 + IIF (nLayout == 2 ,nColA4+0,nCol2A4))/nTweb, aDados[nX, 31, nI], oFont04)
					oPrint:Say(nLweb+(nLinIni + 0956)/nTweb, (nColIni + 3045 + IIF (nLayout == 2 ,nColA4+0,nCol2A4))/nTweb, IIf(Empty(aDados[nX, 32, nI]), "", Transform(aDados[nX, 32, nI], "@E 999.99")), oFont04,,,,1)
					oPrint:Say(nLweb+(nLinIni + 0956)/nTweb, (nColIni + 3275 + IIF (nLayout == 2 ,nColA4+0,nCol2A4))/nTweb, IIf(Empty(aDados[nX, 33, nI]), "", Transform(aDados[nX, 33, nI], "@E 99,999,999.99")), oFont04,,,,1)
					oPrint:Say(nLweb+(nLinIni + 0956)/nTweb, (nColIni + 3505 + IIF (nLayout == 2 ,nColA4+0,nCol2A4))/nTweb, IIf(Empty(aDados[nX, 34, nI]), "", Transform(aDados[nX, 34, nI], "@E 99,999,999.99")), oFont04,,,,1)
				nLinIni += 45
				Endif
			Next nI

			nLinIni := nOldLinIni

			If nAte < Len(aDados[nX][27])
				lImpNovo 	:= .T.
				nIni		:= nAte + 1
				nAte		+= 10
			EndIf

			oPrint:Box((nLinIni + 1676)/nTweb, (nColIni + 2995 + nColA4)/nTweb, (nLinIni + 1770)/nTweb, (nColIni + 3495 + nColA4)/nTweb)
			oPrint:Say(nLweb+nLwebC+(nLinIni + 1681)/nTweb, (nColIni + 3105 + nColA4)/nTweb, "35 - "+"Total Geral Honorários R$", oFont01) //"Total Geral Honorários R$"
			oPrint:Say(nLweb+nLwebC+(nLinIni + 1711)/nTweb, (nColIni + 3175 + nColA4)/nTweb, Transform(aDados[nX, 35], "@E 999,999,999.99"), oFont04,,,,1)

			oPrint:Box((nLinIni + 1775)/nTweb, (nColIni + 0010)/nTweb, (nLinIni + 1995)/nTweb, (nColIni + 3695 + nColA4)/nTweb)
			oPrint:Say(nLweb+nLwebC+(nLinIni + 1780)/nTweb, (nColIni + 0020)/nTweb, "36 - "+"Observação", oFont01) //"Observação"

			nLin := 1815
			For nI := 1 To MlCount(aDados[nX, 36], 130)
				cObs := MemoLine(aDados[nX, 36], 130, nI)
				oPrint:Say(nLweb+(nLinIni + nLin)/nTweb, (nColIni + 0030)/nTweb, cObs, oFont04)
				nLin += 35
			Next nI

			oPrint:Box((nLinIni + 2000)/nTweb, (nColIni + 0010)/nTweb, (nLinIni + 2188)/nTweb, (nColIni + 1340)/nTweb)
			oPrint:Say(nLweb+nLwebC+(nLinIni + 2005)/nTweb, (nColIni + 0020)/nTweb, "37 - "+"Data e Assinatura do Prestador", oFont01) //"Data e Assinatura do Prestador"
			oPrint:Say(nLweb+(nLinIni + 2035)/nTweb, (nColIni + 0030)/nTweb, Iif(valtype(aDados[nX, 37])=="C",aDados[nX, 37],DtoC(aDados[nX, 37]) ), oFont04)
			oPrint:Box((nLinIni + 2000)/nTweb, (nColIni + 1345)/nTweb, (nLinIni + 2188)/nTweb, (nColIni + 2695)/nTweb)
			oPrint:Say(nLweb+nLwebC+(nLinIni + 2005)/nTweb, (nColIni + 1355)/nTweb, "38 - "+"Data/Hora e Assinatura do Beneficiário ou Responsável", oFont01) //"Data/Hora e Assinatura do Beneficiário ou Responsável"
			oPrint:Say(nLweb+(nLinIni + 2035)/nTweb, (nColIni + 1365)/nTweb, DtoC(aDados[nX, 38,1]) + " " + Transform(aDados[nX, 38,2], "@R 99:99"), oFont04)

			oPrint:EndPage()	// Finaliza a pagina

		End

	Next nX

	If lWeb
		oPrint:Print()
	Else
		oPrint:Preview()
	Endif

Return cFileName

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡ao    ?PLSTISS6  ?Autor ?Luciano Aparecido     ?Data ?26.02.07 ³±?
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡ao ?Estrutura Relatório TISS (Guia Outras Despesas)-BOPS 095189 ³±?
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±?Uso      ?SigaPLS                                                     ³±?
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros?aDados - Array com as informações do relat´rio              ³±?
±±?         ?lGerTXT - Define se imprime direto sem passar pela tela 	   ³±?
±±?         ?		 de configuracao/preview do relatorio 		       ³±?
±±?         ?nLayout - Define o formato de papél para impressao:         ³±?
±±?         ?          1 - Formato Ofício II (216x330mm)                 ³±?
±±?         ?          2 - Formato A4 (210x297mm)                        ³±?
±±?         ? 		 3 - Formato Carta (216x279mm)     			       ³±?
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function CABTISS6(aDados, lGerTXT, nLayout, cLogoGH)

	Local nLinMax
	Local nColMax
	Local nLinIni	:=	0		// Linha Lateral (inicial) Esquerda
	Local nColIni	:=	0		// Coluna Lateral (inicial) Esquerda
	Local nColA4    :=  0
	Local cFileLogo
	Local lPrinter
	Local nOldLinIni
	Local nI, nJ, nX
	Local oFont01
	Local oFont02n
	Local oFont03n
	Local oFont04

	Default nLayout := 2
	Default lGerTXT := .F.
	Default cLogoGH := ''
	Default aDados := { { ;
						"123456",;
						"12345678901234567892",;
						"14.141.114/00001-35",;
						Replicate("M",70),;
						"1234567",;
						{ "1","1","1","1","1","1","1","1","1","1","1","1","1" },;
						{ CtoD("12/03/06"),CtoD("12/03/06"),CtoD("12/03/06"),CtoD("12/03/06"),CtoD("12/03/06"),CtoD("12/03/06"),CtoD("12/03/06"),CtoD("12/03/06"),CtoD("12/03/06"),CtoD("12/03/06"),CtoD("12/03/06"),CtoD("12/03/06"),CtoD("12/03/06") },;
						{ "0507","0507","0507","0507","0507","0507","0507","0507","0507","0507","0507","0507","0507" },;
						{ "0507","0507","0507","0507","0507","0507","0507","0507","0507","0507","0507","0507","0507" },;
						{ "MM","AA","BB","CC","DD","DD","DD","DD","DD","DD","DD","DD","DD"},;
						{ "5678901234","5678901234","5678901234","5678901234","5678901234","5678901234","5678901234","5678901234","5678901234","5678901234","5678901234","5678901234","5678901234"},;
						{ 4,4,4,4,4,4,4,4,4,4,4,4,4},;
						{ 999.99,999.99,999.99,999.99,999.99,999.99,999.99,999.99,999.99,999.99,999.99,999.99,999.99 },;
						{ 11111.11,11111.11,11111.11,11111.11,11111.11,11111.11,11111.11,911111.11,911111.11,911111.11,911111.11,911111.11,911111.11 },;
						{ 88888.00,88888.00,88888.00,88888.00,88888.00,88888.00,88888.00,88888.00,911111.11,911111.11,911111.11,911111.11,911111.11 },;
						{ Replicate("M",60),Replicate("W",60),Replicate("E",60),Replicate("E",60),Replicate("E",60),Replicate("E",60),Replicate("E",60),Replicate("E",60),Replicate("E",60),Replicate("E",60),Replicate("E",60),Replicate("E",60),Replicate("E",60)},;
						3999999.99,;
						3999999.99,;
						3999999.99,;
						3999999.99,;
						3999999.99,;
						3999999.99,;
						3999999.99 } }

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

	oPrint	:= TMSPrinter():New("GUIA DE OUTRAS DESPESAS") //"GUIA DE OUTRAS DESPESAS"

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

	If ! lPrinter
		oPrint:Setup()
	EndIf

	For nX := 1 To Len(aDados)

		If ValType(aDados[nX]) == 'U' .OR. Len(aDados[nX]) == 0
			Loop
		EndIf

		For nI := 6 To 16
			If Len(aDados[nX, nI]) < 20
				For nJ := Len(aDados[nX, nI]) + 1 To 20
					If AllTrim(StrZero(nI, 2, 0)) $ "07"
						aAdd(aDados[nX, nI], StoD(""))
					ElseIf AllTrim(StrZero(nI, 2, 0)) $ "12,13,14,15"
						aAdd(aDados[nX, nI], 0)
					Else
						aAdd(aDados[nX, nI], "")
					EndIf
				Next nJ
			EndIf
		Next nI

		nLinIni := 0
		nColIni := 0
		nColA4  := 0

		oPrint:StartPage()		// Inicia uma nova pagina
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Box Principal                                                 ?
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		oPrint:Box(nLinIni + 0000, nColIni + 0000, nLinIni + nLinMax, nColIni + nColMax)

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Carrega e Imprime Logotipo da Empresa                         ?
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

		oPrint:Say(nLinIni + 0080, nColIni + 1852 + IIF(nLayout == 2 .Or. nLayout == 3,nColA4+140,0), "GUIA DE OUTRAS DESPESAS", oFont02n,,,, 2) //"GUIA DE OUTRAS DESPESAS"

		nLinIni += 60
		oPrint:Box(nLinIni + 0175, nColIni + 0010, nLinIni + 0269, nColIni + 0315)
		oPrint:Say(nLinIni + 0180, nColIni + 0020, "1 - "+"Registro ANS", oFont01) //"Registro ANS"
		oPrint:Say(nLinIni + 0210, nColIni + 0030, aDados[nX, 01], oFont04)
		oPrint:Box(nLinIni + 0175, nColIni + 0320, nLinIni + 0269, nColIni + 1035)
		oPrint:Say(nLinIni + 0180, nColIni + 0330, "2 - "+OemToAnsi("Nº Guia Referenciada"), oFont01) //"N?Guia Referenciada"
		oPrint:Say(nLinIni + 0210, nColIni + 0340, aDados[nX, 02], oFont04)

		nLinIni += 20
		oPrint:Say(nLinIni + 0274, nColIni + 0010, "Dados do Contratado Executante", oFont01) //"Dados do Contratado Executante"
		oPrint:Box(nLinIni + 0304, nColIni + 0010, nLinIni + 0398, nColIni + 0426)
		oPrint:Say(nLinIni + 0309, nColIni + 0020, "3 - "+"Código na Operadora / CNPJ / CPF", oFont01) //"Código na Operadora / CNPJ / CPF"
		oPrint:Say(nLinIni + 0339, nColIni + 0030, aDados[nX, 03], oFont04)
		oPrint:Box(nLinIni + 0304, nColIni + 0431, nLinIni + 0398, nColIni + 2395)
		oPrint:Say(nLinIni + 0309, nColIni + 0441, "4 - "+"Nome do Contratado", oFont01) //"Nome do Contratado"
		oPrint:Say(nLinIni + 0339, nColIni + 0451, aDados[nX, 04], oFont04)
		oPrint:Box(nLinIni + 0304, nColIni + 2400, nLinIni + 0398, nColIni + 2615)
		oPrint:Say(nLinIni + 0309, nColIni + 2410, "5 - "+"Código CNES", oFont01) //"Código CNES"
		oPrint:Say(nLinIni + 0339, nColIni + 2420, aDados[nX, 05], oFont04)

		nLinIni += 20
		oPrint:Say(nLinIni + 0403, nColIni + 0010, "Código de Despesas Realizadas"+"    "+"CD = "+"1-"+"Gases Medicinais"+"     "+"2-"+"Medicamentos"+"     "+"3-"+"Materiais"+"     "+"4-"+"Taxas Diversas"+"     "+"5-"+"Diárias"+"     "+"6-"+"Aluguéis", oFont01) //"Código de Despesas Realizadas"###"CD = "###"Gases Medicinais"###"Medicamentos"###"Materiais"###"Taxas Diversas"###"Diárias"###"Aluguéis"
		oPrint:Box(nLinIni + 0433, nColIni + 0010, nLinIni + 1701, nColIni + 3695 + nColA4)
		oPrint:Say(nLinIni + 0438, nColIni + 0030, "6 - "+"CD", oFont01) //"CD"
		oPrint:Say(nLinIni + 0438, nColIni + 0120, "7 - "+"Data", oFont01) //"Data"
		oPrint:Say(nLinIni + 0438, nColIni + 0305, "8 - "+"Hora Inicial", oFont01) //"Hora Inicial"
		oPrint:Say(nLinIni + 0438, nColIni + 0480, "9 - "+"Hora Final", oFont01) //"Hora Final"
		oPrint:Say(nLinIni + 0438, nColIni + 0740, "10 - "+"Tabela", oFont01) //"Tabela"
		oPrint:Say(nLinIni + 0438, nColIni + 0910, "11 - "+"Código do Item", oFont01) //"Código do Item"
	  	oPrint:Say(nLinIni + 0438, nColIni + 2555 + nColA4, "12 - "+"Qtde.", oFont01,,,,1) //"Qtde."
		oPrint:Say(nLinIni + 0438, nColIni + 2805 + nColA4, "13 - "+"% Red./Acresc.", oFont01,,,,1) //"% Red./Acresc."
		oPrint:Say(nLinIni + 0438, nColIni + 3065 + nColA4, "14 - "+"Valor Unitário - R$", oFont01,,,,1) //"Valor Unitário - R$"
		oPrint:Say(nLinIni + 0438, nColIni + 3275 + nColA4, "15 - "+"Valor Total - R$", oFont01,,,,1) //"Valor Total - R$"

		nOldLinIni := nLinIni
		For nI := 1 To 13
			oPrint:Say(nLinIni + 0503, nColIni + 0030, AllTrim(Str(nI)) + " - ", oFont01)
			oPrint:Say(nLinIni + 0498, nColIni + 0065, aDados[nX, 6, nI], oFont04)
			oPrint:Say(nLinIni + 0498, nColIni + 0120, IIf(Empty(aDados[nX, 7, nI]), "", DtoC(aDados[nX, 7, nI])), oFont04)
			oPrint:Say(nLinIni + 0498, nColIni + 0305, IIf(Empty(aDados[nX, 8, nI]), "", Transform(aDados[nX, 8, nI], "@R 99:99")), oFont04)
		 	oPrint:Say(nLinIni + 0498, nColIni + 0480, IIf(Empty(aDados[nX, 9, nI]), "", Transform(aDados[nX, 9, nI], "@R 99:99")), oFont04)
			oPrint:Say(nLinIni + 0498, nColIni + 0740, aDados[nX, 10, nI], oFont04)
			oPrint:Say(nLinIni + 0498, nColIni + 0910, aDados[nX, 11, nI], oFont04)
			oPrint:Say(nLinIni + 0498, nColIni + 2555 + nColA4, IIf(Empty(aDados[nX, 12, nI]), "", Transform(aDados[nX, 12, nI], "@E 9999.99")), oFont04,,,,1)
			oPrint:Say(nLinIni + 0498, nColIni + 2805 + nColA4, IIf(Empty(aDados[nX, 13, nI]), "", Transform(aDados[nX, 13, nI], "@E 999.99")), oFont04,,,,1)
			oPrint:Say(nLinIni + 0498, nColIni + 3065 + nColA4, IIf(Empty(aDados[nX, 14, nI]), "", Transform(aDados[nX, 14, nI], "@E 99,999,999.99")), oFont04,,,,1)
			oPrint:Say(nLinIni + 0498, nColIni + 3275 + nColA4, IIf(Empty(aDados[nX, 15, nI]), "", Transform(aDados[nX, 15, nI], "@E 99,999,999.99")), oFont04,,,,1)
			nLinIni += 43
			oPrint:Say(nLinIni + 0503, nColIni + 0065, "16 - "+"Descrição", oFont01) //"Descrição"
			oPrint:Say(nLinIni + 0498, nColIni + 0225, aDados[nX, 16, nI], oFont04)
			nLinIni += 45
		Next nI

		nLinIni := nOldLinIni

		oPrint:Box(nLinIni + 1706, nColIni + 0010, nLinIni + 1800, nColIni + 0531 + (nColA4/7))
		oPrint:Say(nLinIni + 1711, nColIni + 0020, "17 - "+"Total Gases Medicinais R$", oFont01) //"Total Gases Medicinais R$"
		oPrint:Say(nLinIni + 1741, nColIni + 0506 + (nColA4/7), Transform(aDados[nX, 17], "@E 999,999,999.99"), oFont04,,,,1)
		oPrint:Box(nLinIni + 1706, nColIni + 0536 + (nColA4/7), nLinIni + 1800, nColIni + 1057 + (2*(nColA4/7)))
		oPrint:Say(nLinIni + 1711, nColIni + 0546 + (nColA4/7), "18 - "+"Total Medicamentos R$", oFont01) //"Total Medicamentos R$"
		oPrint:Say(nLinIni + 1741, nColIni + 1032 + (2*(nColA4/7)), Transform(aDados[nX, 18], "@E 999,999,999.99"), oFont04,,,,1)
		oPrint:Box(nLinIni + 1706, nColIni + 1062 + (2*(nColA4/7)), nLinIni + 1800, nColIni + 1583 + (3*(nColA4/7)))
		oPrint:Say(nLinIni + 1711, nColIni + 1072 + (2*(nColA4/7)), "19 - "+"Total Materiais R$", oFont01) //"Total Materiais R$"
		oPrint:Say(nLinIni + 1741, nColIni + 1558 + (3*(nColA4/7)), Transform(aDados[nX, 19], "@E 999,999,999.99"), oFont04,,,,1)
		oPrint:Box(nLinIni + 1706, nColIni + 1588 + (3*(nColA4/7)), nLinIni + 1800, nColIni + 2109 + (4*(nColA4/7)))
		oPrint:Say(nLinIni + 1711, nColIni + 1598 + (3*(nColA4/7)), "20 - "+"Total Taxas Diversas R$", oFont01) //"Total Taxas Diversas R$"
		oPrint:Say(nLinIni + 1741, nColIni + 2084 + (4*(nColA4/7)), Transform(aDados[nX, 20], "@E 999,999,999.99"), oFont04,,,,1)
		oPrint:Box(nLinIni + 1706, nColIni + 2114 + (4*(nColA4/7)), nLinIni + 1800, nColIni + 2635 + (5*(nColA4/7)))
		oPrint:Say(nLinIni + 1711, nColIni + 2124 + (4*(nColA4/7)), "21 - "+"Total Diárias R$", oFont01) //"Total Diárias R$"
		oPrint:Say(nLinIni + 1741, nColIni + 2610 + (5*(nColA4/7)), Transform(aDados[nX, 21], "@E 999,999,999.99"), oFont04,,,,1)
		oPrint:Box(nLinIni + 1706, nColIni + 2640 + (5*(nColA4/7)), nLinIni + 1800, nColIni + 3161 + (6*(nColA4/7)))
		oPrint:Say(nLinIni + 1711, nColIni + 2650 + (5*(nColA4/7)), "22 - "+"Total Aluguéis R$", oFont01) //"Total Aluguéis R$"
		oPrint:Say(nLinIni + 1741, nColIni + 3136 + (6*(nColA4/7)), Transform(aDados[nX, 22], "@E 999,999,999.99"), oFont04,,,,1)
		oPrint:Box(nLinIni + 1706, nColIni + 3166 + (6*(nColA4/7)), nLinIni + 1800, nColIni + 3695 + (7*(nColA4/7)))
		oPrint:Say(nLinIni + 1711, nColIni + 3176 + (6*(nColA4/7)), "23 - "+"Total Geral R$", oFont01) //"Total Geral R$"
		oPrint:Say(nLinIni + 1741, nColIni + 3675 + (7*(nColA4/7)), Transform(aDados[nX, 23], "@E 999,999,999.99"), oFont04,,,,1)

		oPrint:EndPage()	// Finaliza a pagina

	Next nX

	If lGerTXT
		oPrint:Print()		// Imprime Relatorio
	Else
		oPrint:Print()	// Visualiza impressao grafica antes de imprimir
	EndIf

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡ao    ?PLSTISS7  ?Autor ?Luciano Aparecido     ?Data ?26.02.07 ³±?
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡ao ?Estrutura Relatório TISS (Demons An. Contas Med)-BOPS 095189³±?
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±?Uso      ?SigaPLS                                                     ³±?
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros?aDados - Array com as informações do relat´rio              ³±?
±±?         ?nLayout - Define o formato de papél para impressao:         ³±?
±±?         ?          1 - Formato Ofício II (216x330mm)                 ³±?
±±?         ?          2 - Formato A4 (210x297mm)                        ³±?
±±?         ? 		 3 - Formato Carta (216x279mm)     			       ³±?
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function CABTISS7(aDados, nLayout, cLogoGH)

	Local nLinMax
	Local nColMax
	Local nLinIni	:=	0		// Linha Lateral (inicial) Esquerda
	Local nColIni	:=  0		// Coluna Lateral (inicial) Esquerda
	Local nColA4    :=  0
	Local nProcGui  :=  0
	Local nLibGui   :=  0
	Local nGloGui   :=  0
	Local nProcGer  :=  0
	Local nLibGer   :=  0
	Local nGloGer   :=  0
	Local nProcFat  :=  0
	Local nLibFat   :=  0
	Local nGloFat   :=  0
	Local cFileLogo
	Local lPrinter
	Local nI, nJ
	Local nX,nX1,nX2,nX3,nX4
	Local oFont01
	Local oFont02n
	Local oFont04
	Local lBox

	Default nLayout := 2
	Default cLogoGH := ''
	Default aDados  := { { ;
						"123456",;
						Replicate("M",70),;
						"14.141.114/00001-35",;
						{"123456789102"},;
						{CtoD("12/01/06")},;
						{"14.141.114/00001-35"},;
						{Replicate("M",70)},;
						{"1234567"},;
						{"123456789102"},;
						{{ "123456789102" }},;
						{{ CtoD("12/01/06") }},;
						{{ "123456789102" }},;
						{{ 999999999.99 }},;
						{{ 999999999.99 }},;
						{{ "99" }},;
						{{ { "12345678910234567892" } }},;
						{{ { Replicate("M",70) } }},;
					    {{ { "12345678910234567892" } }},;
						{{ { { CtoD("12/01/06"),CtoD("12/01/06"),CtoD("12/01/06"),CtoD("12/01/06"),CtoD("12/01/06"),CtoD("12/01/06"),CtoD("12/01/06"),CtoD("12/01/06"),CtoD("12/02/06"),CtoD("12/03/06"),CtoD("12/03/06"),CtoD("12/03/06"),CtoD("12/03/06"),CtoD("12/03/06"),CtoD("12/03/06"),CtoD("12/03/06"),CtoD("12/03/06"),CtoD("12/03/06"),CtoD("12/03/06"),CtoD("12/03/06"),CtoD("12/03/06"),CtoD("12/03/06"),CtoD("12/03/06"),CtoD("12/03/06") } } }},;
						{{ { { Replicate("M",70),Replicate("M",70),Replicate("M",70),Replicate("M",70),Replicate("M",70),Replicate("M",70),Replicate("M",70),Replicate("M",70),Replicate("B",70),Replicate("C",70),Replicate("D",70),Replicate("E",70),Replicate("E",70),Replicate("E",70),Replicate("E",70),Replicate("E",60),Replicate("E",60),Replicate("E",60),Replicate("E",60),Replicate("E",70),Replicate("E",70),Replicate("E",70),Replicate("E",70),Replicate("E",70) } } }},;
						{{ { { "MM","MM","MM","MM","MM","MM","MM","MM","AA","BB","CC","DD","DD","DD","DD","DD","DD","DD","DD","DD","DD","DD","DD","DD" } }} },;
						{{ { { "1234567890","1234567890","1234567890","1234567890","1234567890","1234567890","1234567890","1234567890","2345678901","3456789012","4567890123","5678901234","5678901234","5678901234","5678901234","5678901234","5678901234","5678901234","5678901234","5678901234","5678901234","5678901234","5678901234","5678901234" } }} },;
						{{ { { "MM","MM","MM","MM","MM","MM","MM","MM","AA","BB","CC","DD","DD","DD","DD","DD","DD","DD","DD","DD","DD","DD","DD","DD" } }} },;
						{{ { { 312,312,312,312,312,312,312,312,1,2,3,4,4,4,4,4,4,4,4,4,4,4,4,4 } }} },;
						{{ { { 999999999.99,999999999.99,999999999.99,999999999.99,999999999.99,999999999.99,999999999.99,999999999.99,222.00,333.00,444.00,999.99,999.99,999.99,999.99,999.99,999.99,999.99,999.99,999.99,999.99,999.99,999.99,999.99 } } }},;
						{{ { { 999999999.99,999999999.99,999999999.99,999999999.99,999999999.99,999999999.99,999999999.99,999999999.99,22222.22,33.33,44444.44,11111.11,11111.11,11111.11,11111.11,11111.11,11111.11,11111.11,11111.11,11111.11,11111.11,911111.11,911111.11,911111.11 } }} },;
						{{ { { 999999999.99,999999999.99,999999999.99,999999999.99,999999999.99,999999999.99,999999999.99,999999999.99,22222.22,33.33,44444.44,11111.11,11111.11,11111.11,11111.11,11111.11,11111.11,11111.11,11111.11,11111.11,11111.11,911111.11,911111.11,911111.11 } } }},;
						{{ { { "MM","MM","MM","MM","MM","MM","MM","MM","AA","BB","CC","DD","DD","DD","DD","DD","DD","DD","DD","DD","DD","DD","DD","DD" } }} },;
						 } }

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

	oPrint	:= TMSPrinter():New("DEMONSTRATIVO DE ANALISE DA CONTA MEDICA") //"DEMONSTRATIVO DE ANALISE DA CONTA MEDICA"

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

	If ! lPrinter
		oPrint:Setup()
	EndIf

	For nX := 1 To Len(aDados)

		If ValType(aDados[nX]) == 'U' .OR. Len(aDados[nX]) == 0
			Loop
		EndIf

		For nI := 19 To 28
			If Len(aDados[nX, nI]) < 1
				For nJ := Len(aDados[nX, nI]) + 1 To 5
					If AllTrim(Str(nI)) $ "19"
						aAdd(aDados[nX, nI], StoD(""))
					ElseIf AllTrim(Str(nI)) $ "24,25,26,27"
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

			nLinIni := 040
			nColIni := 060
			nColA4  := 000

			oPrint:StartPage()		// Inicia uma nova pagina
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Box Principal                                                 ?
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			oPrint:Box(nLinIni + 0000, nColIni + 0000, nLinIni + nLinMax, nColIni + nColMax)

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Carrega e Imprime Logotipo da Empresa                         ?
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

			oPrint:Say(nLinIni + 0080, nColIni + 1852 + IIF(nLayout == 2 .Or. nLayout == 3,nColA4+250,0), "DEMONSTRATIVO DE ANÁLISE DA CONTA MÉDICA", oFont02n,,,, 2) //"DEMONSTRATIVO DE ANÁLISE DA CONTA MÉDICA"

			nLinIni += 60
			oPrint:Box(nLinIni + 0175, nColIni + 0010, nLinIni + 0269, nColIni + 0315)
			oPrint:Say(nLinIni + 0180, nColIni + 0020, "1 - "+"Registro ANS", oFont01) //"Registro ANS"
			oPrint:Say(nLinIni + 0210, nColIni + 0030, aDados[nX, 01], oFont04)
			oPrint:Box(nLinIni + 0175, nColIni + 0320, nLinIni + 0269, nColIni + 2265 + nColA4)
			oPrint:Say(nLinIni + 0180, nColIni + 0330, "2 - "+"Nome da Operadora", oFont01) //"Nome da Operadora"
			oPrint:Say(nLinIni + 0210, nColIni + 0340, aDados[nX, 02], oFont04)
			oPrint:Box(nLinIni + 0175, nColIni + 2270 + nColA4, nLinIni + 0269, nColIni + 2735 + nColA4)
			oPrint:Say(nLinIni + 0180, nColIni + 2280 + nColA4, "3 - "+"CNPJ Operadora", oFont01) //"CNPJ Operadora"
			oPrint:Say(nLinIni + 0210, nColIni + 2290 + nColA4, aDados[nX, 03], oFont04)
			oPrint:Box(nLinIni + 0175, nColIni + 2740 + nColA4, nLinIni + 0269, nColIni + 3290 + nColA4)
			oPrint:Say(nLinIni + 0180, nColIni + 2750 + nColA4, "4 - "+"Número do Demonstrativo", oFont01) //"Número do Demonstrativo"
			oPrint:Say(nLinIni + 0210, nColIni + 2760 + nColA4, aDados[nX, 04,nX1], oFont04)
			oPrint:Box(nLinIni + 0175, nColIni + 3295 + nColA4, nLinIni + 0269, nColIni + 3695 + nColA4)
			oPrint:Say(nLinIni + 0180, nColIni + 3305 + nColA4, "5 - "+"Data Emissão do Demonstrativo", oFont01) //"Data Emissão do Demonstrativo"
			oPrint:Say(nLinIni + 0210, nColIni + 3315 + nColA4, DtoC(aDados[nX, 05,nX1]), oFont04)

			nLinIni += 20
			oPrint:Say(nLinIni + 0274, nColIni + 0010, "Dados do Prestador", oFont01) //"Dados do Prestador"
			oPrint:Box(nLinIni + 0304, nColIni + 0010, nLinIni + 0398, nColIni + 0426)
			oPrint:Say(nLinIni + 0309, nColIni + 0020, "6 - "+"Código Prestador / CNPJ / CPF", oFont01) //"Código Prestador / CNPJ / CPF"
			oPrint:Say(nLinIni + 0339, nColIni + 0030, aDados[nX, 06,nX1], oFont04)
			oPrint:Box(nLinIni + 0304, nColIni + 0431, nLinIni + 0398, nColIni + 2365)
			oPrint:Say(nLinIni + 0309, nColIni + 0441, "7 - "+"Nome", oFont01) //"Nome"
			oPrint:Say(nLinIni + 0339, nColIni + 0451, aDados[nX, 07,nX1], oFont04)
			oPrint:Box(nLinIni + 0304, nColIni + 2370, nLinIni + 0398, nColIni + 2580)
			oPrint:Say(nLinIni + 0309, nColIni + 2380, "8 - "+"Código CNES", oFont01) //"Código CNES"
			oPrint:Say(nLinIni + 0339, nColIni + 2390, aDados[nX, 08,nX1], oFont04)

			nProcGer := 0
			nLibGer  := 0
			nGloGer  := 0
			nProcFat := 0
			nLibFat  := 0
			nGloFat  := 0
			fSomaLin(nLinMax, nColMax, @nLinIni, nColIni, 360)
			fSomaLin(nLinMax, nColMax, @nLinIni, nColIni, 60)
			oPrint:Say(nLinIni + 0003, nColIni + 0010, "Dados da Conta", oFont01) //"Dados da Conta"
			oPrint:Box(nLinIni + 0033, nColIni + 0010, nLinIni + 0127, nColIni + 0526)
			oPrint:Say(nLinIni + 0038, nColIni + 0020, "9 - "+"Número da Fatura", oFont01) //"Número da Fatura"
			oPrint:Say(nLinIni + 0068, nColIni + 0030, aDados[nX, 09,nX1], oFont04)

			For nX2 := 1 To Len(aDados[nX, 10, nX1])

				fSomaLin(nLinMax, nColMax, @nLinIni, nColIni, 100)
				oPrint:Box(nLinIni + 0032, nColIni + 0010, nLinIni + 0126, nColIni + 0620 + (nColA4/6))
				oPrint:Say(nLinIni + 0037, nColIni + 0020, "10 - "+"Número do Lote", oFont01) //"Número do Lote"
				oPrint:Say(nLinIni + 0067, nColIni + 0030, aDados[nX, 10, nX1,nX2], oFont04)
				oPrint:Box(nLinIni + 0032, nColIni + 0625 + (nColA4/6), nLinIni + 0126, nColIni + 1235 + (2*(nColA4/6)))
				oPrint:Say(nLinIni + 0037, nColIni + 0635 + (nColA4/6), "11 - "+"Data de Envio do Lote", oFont01) //"Data de Envio do Lote"
				oPrint:Say(nLinIni + 0067, nColIni + 0645 + (nColA4/6), DtoC(aDados[nX, 11,nX1, nX2]), oFont04)
				oPrint:Box(nLinIni + 0032, nColIni + 1240 + (2*(nColA4/6)), nLinIni + 0126, nColIni + 1850 + (3*(nColA4/6)))
				oPrint:Say(nLinIni + 0037, nColIni + 1250 + (2*(nColA4/6)), "12 - "+"Número do Protocolo", oFont01) //"Número do Protocolo"
				oPrint:Say(nLinIni + 0067, nColIni + 1260 + (2*(nColA4/6)), aDados[nX, 12, nX1,nX2], oFont04)
				oPrint:Box(nLinIni + 0032, nColIni + 1855 + (3*(nColA4/6)), nLinIni + 0126, nColIni + 2465 + (4*(nColA4/6)))
				oPrint:Say(nLinIni + 0037, nColIni + 1865 + (3*(nColA4/6)), "13 - "+"Valor Protocolo (R$)", oFont01) //"Valor Protocolo (R$)"
				oPrint:Say(nLinIni + 0067, nColIni + 2445 + (4*(nColA4/6)), Transform(aDados[nX, 13,nX1, nX2], "@E 999,999,999.99"), oFont04,,,,1)
				oPrint:Box(nLinIni + 0032, nColIni + 2470 + (4*(nColA4/6)), nLinIni + 0126, nColIni + 3080 + (5*(nColA4/6)))
				oPrint:Say(nLinIni + 0037, nColIni + 2480 + (4*(nColA4/6)), "14 - "+"Valor Glosa Protocolo (R$)", oFont01) //"Valor Glosa Protocolo (R$)"
				oPrint:Say(nLinIni + 0067, nColIni + 3060 + (5*(nColA4/6)), Transform(aDados[nX, 14,nX1, nX2], "@E 999,999,999.99"), oFont04,,,,1)
				oPrint:Box(nLinIni + 0032, nColIni + 3085 + (5*(nColA4/6)), nLinIni + 0126, nColIni + 3695 + (6*(nColA4/6)))
				oPrint:Say(nLinIni + 0037, nColIni + 3095 + (5*(nColA4/6)), "15 - "+"Código Glosa Protocolo", oFont01) //"Código Glosa Protocolo"
				oPrint:Say(nLinIni + 0067, nColIni + 3105 + (5*(nColA4/6)), aDados[nX, 15, nX1,nX2], oFont04)

				For nX3 := 1 To Len(aDados[nX, 16, nX1,nX2])

					fSomaLin(nLinMax, nColMax, @nLinIni, nColIni, 100)
					oPrint:Box(nLinIni + 0031, nColIni + 0010, nLinIni + 0125, nColIni + 0426)
					oPrint:Say(nLinIni + 0036, nColIni + 0020, "16 - "+"Número da Guia/Senha", oFont01) //"Número da Guia/Senha"
					oPrint:Say(nLinIni + 0066, nColIni + 0030, aDados[nX, 16, nX1,nX2, nX3], oFont04)
					oPrint:Box(nLinIni + 0031, nColIni + 0431, nLinIni + 0125, nColIni + 2365)
					oPrint:Say(nLinIni + 0036, nColIni + 0441, "17 - "+"Nome do Beneficiário", oFont01) //"Nome do Beneficiário"
					oPrint:Say(nLinIni + 0066, nColIni + 0451, aDados[nX, 17,nX1, nX2, nX3], oFont04)
					oPrint:Box(nLinIni + 0031, nColIni + 2370, nLinIni + 0125, nColIni + 2786)
					oPrint:Say(nLinIni + 0036, nColIni + 2380, "18 - "+"Código do Beneficiário", oFont01) //"Código do Beneficiário"
					oPrint:Say(nLinIni + 0066, nColIni + 2390, aDados[nX, 18, nX1,nX2, nX3], oFont04)

					fSomaLin(nLinMax, nColMax, @nLinIni, nColIni, 100)
					lBox:=.F.
					if (nLinIni + 110 + (Len(aDados[nX, 19, nX1,nX2, nX3]) * 45)) < nLinMax
						oPrint:Box(nLinIni + 0030, nColIni + 0010, nLinIni + 110 + (Len(aDados[nX, 19, nX1,nX2, nX3]) * 45), nColIni + 3695 + nColA4)
					Else
				   		oPrint:Line(nLinIni + 0030, nColIni + 0010, nLinIni + 0030, nColIni + 3695 + nColA4)
				  	 	oPrint:Line(nLinIni + 0030, nColIni + 0010, nLinIni + 0150, nColIni + 0010)
			  	   		oPrint:Line(nLinIni + 0030, nColIni + 3695 + nColA4, nLinIni + 0150, nColIni + 3695 + nColA4)
					  	lBox:=.T.
					Endif
					oPrint:Say(nLinIni + 0035, nColIni + 0020, "19 - "+"Data Realização", oFont01) //"Data Realização"
					oPrint:Say(nLinIni + 0035, nColIni + 0230, "20 - "+"Descrição do Serviço", oFont01) //"Descrição do Serviço"
					oPrint:Say(nLinIni + 0035, nColIni + 1695 + IIf(nLayout == 2 .Or.nLayout == 3,nColA4+100,nColA4),"21 - "+"Código Tabela", oFont01) //"Código Tabela"
					oPrint:Say(nLinIni + 0035, nColIni + 1900 + IIf(nLayout == 2 .Or.nLayout == 3,nColA4+90,nColA4), "22 - "+"Código Serviço", oFont01) //"Código Serviço"
					oPrint:Say(nLinIni + 0035, nColIni + 2135 + IIf(nLayout == 2 .Or.nLayout == 3,nColA4+80,nColA4), "23 - "+"Grau Part.", oFont01) //"Grau Part."
					oPrint:Say(nLinIni + 0035, nColIni + 2450 + IIf(nLayout == 2 .Or.nLayout == 3,nColA4+90,nColA4), "24 - "+"Qtde Exec.", oFont01,,,,1) //"Qtde Exec."
					oPrint:Say(nLinIni + 0035, nColIni + 2720 + IIf(nLayout == 2 .Or.nLayout == 3,nColA4+90,nColA4), "25 - "+"Valor Processado (R$)", oFont01,,,,1) //"Valor Processado (R$)"
					oPrint:Say(nLinIni + 0035, nColIni + 3050 + IIf(nLayout == 2 .Or.nLayout == 3,nColA4+90,nColA4), "26 - "+"Valor Liberado (R$)", oFont01,,,,1) //"Valor Liberado (R$)"
					oPrint:Say(nLinIni + 0035, nColIni + 3400 + IIf(nLayout == 2 .Or.nLayout == 3,nColA4+70,nColA4), "27 - "+"Valor Glosa (R$)", oFont01,,,,1) //"Valor Glosa (R$)"
					oPrint:Say(nLinIni + 0035, nColIni + 3445 + IIf(nLayout == 2 .Or.nLayout == 3,nColA4+60,nColA4), "28 - "+"Código Glosa", oFont01) //"Código Glosa"

					nProcGui := 0
					nLibGui  := 0
					nGloGui  := 0

					fSomaLin(nLinMax, nColMax, @nLinIni, nColIni, 60)

					For nX4 := 1 To Len(aDados[nX, 19, nX1,nX2, nX3])

						if lBox
				   			oPrint:Line(nLinIni + 0035, nColIni + 0010, nLinIni + 0090, nColIni  + 0010)
				   			oPrint:Line(nLinIni + 0035, nColIni  + 3695 + nColA4, nLinIni + 0090, nColIni  + 3695 + nColA4)
				   		Endif

						oPrint:Say(nLinIni + 0035, nColIni + 0020, IIf(Empty(aDados[nX, 19, nX1,nX2, nX3, nX4]), "", DtoC(aDados[nX, 19, nX1,nX2, nX3, nX4])), oFont04)
						oPrint:Say(nLinIni + 0035, nColIni + 0230, SubStr(aDados[nX, 20, nX1,nX2, nX3, nX4], 1, 54), oFont04)
						oPrint:Say(nLinIni + 0035, nColIni + 1745 + IIf(nLayout == 2 .Or.nLayout == 3,nColA4+100,nColA4), aDados[nX, 21, nX1,nX2, nX3, nX4], oFont04)
						oPrint:Say(nLinIni + 0035, nColIni + 1905 + IIf(nLayout == 2 .Or.nLayout == 3,nColA4+100,nColA4), aDados[nX, 22, nX1,nX2, nX3, nX4], oFont04)
						oPrint:Say(nLinIni + 0035, nColIni + 2115 + IIf(nLayout == 2 .Or.nLayout == 3,nColA4+120,nColA4), aDados[nX, 23, nX1,nX2, nX3, nX4], oFont04)
						oPrint:Say(nLinIni + 0035, nColIni + 2420 + IIf(nLayout == 2 .Or.nLayout == 3,nColA4+100,nColA4), IIf(Empty(aDados[nX, 24, nX1, nX2, nX3, nX4]), "", Transform(aDados[nX, 24, nX1, nX2, nX3, nX4], "@E 9999.99")), oFont04,,,,1)
						oPrint:Say(nLinIni + 0035, nColIni + 2700 + IIf(nLayout == 2 .Or.nLayout == 3,nColA4+100,nColA4), IIf(Empty(aDados[nX, 25, nX1, nX2, nX3, nX4]), "", Transform(aDados[nX, 25, nX1, nX2, nX3, nX4], "@E 999,999,999.99")), oFont04,,,,1)
						oPrint:Say(nLinIni + 0035, nColIni + 3050 + IIf(nLayout == 2 .Or.nLayout == 3,nColA4+100,nColA4), IIf(Empty(aDados[nX, 26, nX1, nX2, nX3, nX4]), "", Transform(aDados[nX, 26, nX1, nX2, nX3, nX4], "@E 999,999,999.99")), oFont04,,,,1)
						oPrint:Say(nLinIni + 0035, nColIni + 3400 + IIf(nLayout == 2 .Or.nLayout == 3,nColA4+100,nColA4), IIf(Empty(aDados[nX, 27, nX1, nX2, nX3, nX4]), "", Transform(aDados[nX, 27, nX1, nX2, nX3, nX4], "@E 999,999,999.99")), oFont04,,,,1)
						oPrint:Say(nLinIni + 0035, nColIni + 3445 + IIf(nLayout == 2 .Or.nLayout == 3,nColA4+110,nColA4), aDados[nX, 28,nX1,nX2, nX3, nX4], oFont04)
						nProcGui += aDados[nX, 25, nX1, nX2, nX3, nX4]
						nLibGui  += aDados[nX, 26, nX1, nX2, nX3, nX4]
						nGloGui  += aDados[nX, 27, nX1, nX2, nX3, nX4]
					   	fSomaLin(nLinMax, nColMax, @nLinIni, nColIni, 45)

					Next nX4

					//Para arrumar o Box qdo tem muitos procedimentos e ultrapassam o tamanho da folha ->Luciano
					if lBox
				  	 	oPrint:Line(nLinIni + 0035, nColIni + 0010, nLinIni + 0045, nColIni + 0010)
			  	   		oPrint:Line(nLinIni + 0035, nColIni + 3695 + nColA4, nLinIni + 0045, nColIni + 3695 + nColA4)
			  	   		oPrint:Line(nLinIni + 0045, nColIni + 0010, nLinIni + 0045, nColIni + 3695 + nColA4)
					Endif

					fSomaLin(nLinMax, nColMax, @nLinIni, nColIni, 30)
					oPrint:Box(nLinIni + 0038, nColIni + 0010, nLinIni + 0142, nColIni + 3695 + nColA4)
					oPrint:Say(nLinIni + 0043, nColIni + 0020, "Total Guia", oFont01) //"Total Guia"
					oPrint:Box(nLinIni + 0043, nColIni + 2375 + nColA4, nLinIni + 0137, nColIni + 2720 + nColA4)
					oPrint:Say(nLinIni + 0048, nColIni + 2385 + nColA4, "29 - "+"Valor Processado Guia (R$)", oFont01) //"Valor Processado Guia (R$)"
					oPrint:Say(nLinIni + 0078, nColIni + 2700 + nColA4, Transform(nProcGui, "@E 999,999,999.99"), oFont04,,,,1)
					oPrint:Box(nLinIni + 0043, nColIni + 2725 + nColA4, nLinIni + 0137, nColIni + 3070 + nColA4)
					oPrint:Say(nLinIni + 0048, nColIni + 2735 + nColA4, "30 - "+"Valor Liberado Guia (R$)", oFont01) //"Valor Liberado Guia (R$)"
					oPrint:Say(nLinIni + 0078, nColIni + 3050 + nColA4, Transform(nLibGui, "@E 999,999,999.99"), oFont04,,,,1)
					oPrint:Box(nLinIni + 0043, nColIni + 3075 + nColA4, nLinIni + 0137, nColIni + 3420 + nColA4)
					oPrint:Say(nLinIni + 0048, nColIni + 3085 + nColA4, "31 - "+"Valor Glosa Guia (R$)", oFont01) //"Valor Glosa Guia (R$)"
					oPrint:Say(nLinIni + 0078, nColIni + 3400 + nColA4, Transform(nGloGui, "@E 999,999,999.99"), oFont04,,,,1)
					oPrint:Box(nLinIni + 0043, nColIni + 3425 + nColA4, nLinIni + 0137, nColIni + 3690 + nColA4)
					oPrint:Say(nLinIni + 0048, nColIni + 3435 + nColA4, "32 - "+"Código Glosa Guia", oFont01) //"Código Glosa Guia"
					oPrint:Say(nLinIni + 0078, nColIni + 3445 + nColA4, "", oFont04)
					fSomaLin(nLinMax, nColMax, @nLinIni, nColIni, IIf(nLayout == 2,30,100))

					nProcFat += nProcGui
					nLibFat  += nLibGui
					nGloFat  += nGloGui
				Next nX3

			Next nX2

		  	fSomaLin(nLinMax, nColMax, @nLinIni, nColIni, 100)
			oPrint:Box(nLinIni + 0047, nColIni + 0010, nLinIni + 0151, nColIni + 3695 + nColA4)
			oPrint:Say(nLinIni + 0052, nColIni + 0020, "Total Fatura", oFont01) //"Total Fatura"
			oPrint:Box(nLinIni + 0052, nColIni + 2375 + nColA4, nLinIni + 0146, nColIni + 2720 + nColA4)
			oPrint:Say(nLinIni + 0057, nColIni + 2385 + nColA4, "33 - "+"Valor Processado Fatura (R$)", oFont01) //"Valor Processado Fatura (R$)"
			oPrint:Say(nLinIni + 0087, nColIni + 2700 + nColA4, Transform(nProcFat, "@E 999,999,999.99"), oFont04,,,,1)
			oPrint:Box(nLinIni + 0052, nColIni + 2725 + nColA4, nLinIni + 0146, nColIni + 3070 + nColA4)
			oPrint:Say(nLinIni + 0057, nColIni + 2735 + nColA4, "34 - "+"Valor Liberado Fatura (R$)", oFont01) //"Valor Liberado Fatura (R$)"
			oPrint:Say(nLinIni + 0087, nColIni + 3050 + nColA4, Transform(nLibFat, "@E 999,999,999.99"), oFont04,,,,1)
			oPrint:Box(nLinIni + 0052, nColIni + 3075 + nColA4, nLinIni + 0146, nColIni + 3420 + nColA4)
			oPrint:Say(nLinIni + 0057, nColIni + 3085 + nColA4, "35 - "+"Valor Glosa Fatura (R$)", oFont01) //"Valor Glosa Fatura (R$)"
			oPrint:Say(nLinIni + 0087, nColIni + 3400 + nColA4, Transform(nGloFat, "@E 999,999,999.99"), oFont04,,,,1)


			nProcGer += nProcFat
			nLibGer  += nLibFat
			nGloGer  += nGloFat

			fSomaLin(nLinMax, nColMax, @nLinIni, nColIni, 100)
			oPrint:Box(nLinIni + 0056, nColIni + 0010, nLinIni + 0160, nColIni + 3695 + nColA4)
			oPrint:Say(nLinIni + 0061, nColIni + 0020, "Total Geral", oFont01) //"Total Geral"
			oPrint:Box(nLinIni + 0061, nColIni + 2375 + nColA4, nLinIni + 0155, nColIni + 2720 + nColA4)
			oPrint:Say(nLinIni + 0066, nColIni + 2385 + nColA4, "36 - "+"Valor Processado Geral (R$)", oFont01) //"Valor Processado Geral (R$)"
			oPrint:Say(nLinIni + 0096, nColIni + 2700 + nColA4, Transform(nProcGer, "@E 999,999,999.99"), oFont04,,,,1)
			oPrint:Box(nLinIni + 0061, nColIni + 2725 + nColA4, nLinIni + 0155, nColIni + 3070 + nColA4)
			oPrint:Say(nLinIni + 0066, nColIni + 2735 + nColA4, "37 - "+"Valor Liberado Geral (R$)", oFont01) //"Valor Liberado Geral (R$)"
			oPrint:Say(nLinIni + 0096, nColIni + 3050 + nColA4, Transform(nLibGer, "@E 999,999,999.99"), oFont04,,,,1)
			oPrint:Box(nLinIni + 0061, nColIni + 3075 + nColA4, nLinIni + 0155, nColIni + 3420 + nColA4)
			oPrint:Say(nLinIni + 0066, nColIni + 3085 + nColA4, "38 - "+"Valor Glosa Geral (R$)", oFont01) //"Valor Glosa Geral (R$)"
			oPrint:Say(nLinIni + 0096, nColIni + 3400 + nColA4, Transform(nGloGer, "@E 999,999,999.99"), oFont04,,,,1)

		fSomaLin(nLinMax, nColMax, @nLinIni, nColIni, 100)

		Next nX1


	oPrint:EndPage()	// Finaliza a pagina

	Next nX

	oPrint:Preview() // Visualiza impressao grafica antes de imprimir

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡ao    ?PLSTISS8  ?Autor ?Luciano Aparecido     ?Data ?05.03.07 ³±?
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡ao ?Estrutura Relatório TISS (Guia Demons Pagamento)-BOPS 095189³±?
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±?Uso      ?SigaPLS                                                     ³±?
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros?aDados - Array com as informações do relat´rio              ³±?
±±?         ?nLayout - Define o formato de papél para impressao:         ³±?
±±?         ?          1 - Formato Ofício II (216x330mm)                 ³±?
±±?         ?          2 - Formato A4 (210x297mm)                        ³±?
±±?         ? 		 3 - Formato Carta (216x279mm)     			       ³±?
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function CABTISS8(aDados, nLayout, cLogoGH)

	Local nLinMax
	Local nColMax
	Local nLinIni	:=	0		// Linha Lateral (inicial) Esquerda
	Local nColIni	:=	0		// Coluna Lateral (inicial) Esquerda
	Local nColA4    :=  0
	Local cFileLogo
	Local lPrinter
	Local nI, nJ, nX, nX1
	Local oFont01
	Local oFont02n
	Local oFont04
	Local lBox
	Local  cStartPath	:= GetSrvProfString("Startpath","")

	Default nLayout := 2
	Default cLogoGH := ''
	Default aDados  := { { ;
						"123456",;
						Replicate("M",70),;
						"14.141.114/00001-35",;
						{"123456789102"},;
						{CtoD("12/01/06")},;
						{"14.141.114/00001-35"},;
						{Replicate("M",70)},;
						{"1234567"},;
						{CtoD("12/01/06")},;
						{{ "X", "X", "X" }},;
						{"1234567890"},;
						{"1234567890"},;
						{"12345678910234567892"},;
						{{ Replicate("9",12),Replicate("9",12),Replicate("9",12),Replicate("9",12),Replicate("9",12),Replicate("9",12),Replicate("9",12),Replicate("9",12),Replicate("B",12),Replicate("C",12),Replicate("D",12),Replicate("E",12),Replicate("E",12),Replicate("E",12),Replicate("E",12),Replicate("E",12),Replicate("E",12),Replicate("E",12),Replicate("E",12),Replicate("E",12),Replicate("E",12),Replicate("E",12),Replicate("E",12),Replicate("E",12),Replicate("E",12),Replicate("E",12),Replicate("E",12)}},;
						{{ Replicate("9",12),Replicate("9",12),Replicate("9",12),Replicate("9",12),Replicate("9",12),Replicate("9",12),Replicate("9",12),Replicate("9",12),Replicate("B",12),Replicate("C",12),Replicate("D",12),Replicate("E",12),Replicate("E",12),Replicate("E",12),Replicate("E",12),Replicate("E",12),Replicate("E",12),Replicate("E",12),Replicate("E",12),Replicate("E",12),Replicate("E",12),Replicate("E",12),Replicate("E",12),Replicate("E",12),Replicate("E",12),Replicate("E",12),Replicate("E",12)}},;
						{{ CtoD("12/01/06"),CtoD("12/01/06"),CtoD("12/01/06"),CtoD("12/01/06"),CtoD("12/01/06"),CtoD("12/01/06"),CtoD("12/01/06"),CtoD("12/01/06"),CtoD("12/02/06"),CtoD("12/03/06"),CtoD("12/03/06"),CtoD("12/03/06"),CtoD("12/03/06"),CtoD("12/03/06"),CtoD("12/03/06"),CtoD("12/03/06"),CtoD("12/03/06"),CtoD("12/03/06"),CtoD("12/03/06"),CtoD("12/03/06"),CtoD("12/03/06"),CtoD("12/03/06"),CtoD("12/03/06"),CtoD("12/03/06"),CtoD("12/03/06"),CtoD("12/03/06"),CtoD("12/03/06") }},;
						{{ Replicate("9",12),Replicate("9",12),Replicate("9",12),Replicate("9",12),Replicate("9",12),Replicate("9",12),Replicate("9",12),Replicate("9",12),Replicate("B",12),Replicate("C",12),Replicate("D",12),Replicate("E",12),Replicate("E",12),Replicate("E",12),Replicate("E",12),Replicate("E",12),Replicate("E",12),Replicate("E",12),Replicate("E",12),Replicate("E",12),Replicate("E",12),Replicate("E",12),Replicate("E",12),Replicate("E",12),Replicate("E",12),Replicate("E",12),Replicate("E",12)}},;
						{{ 999999999.99,999999999.99,999999999.99,999999999.99,999999999.99,999999999.99,999999999.99,999999999.99,222.00,333.00,444.00,999.99,999.99,999.99,999.99,999.99,999.99,999.99,999.99,999.99,999.99,999.99,999.99,999.99,999.99,999.99,999.99 }},;
						{{ 999999999.99,999999999.99,999999999.99,999999999.99,999999999.99,999999999.99,999999999.99,999999999.99,222.00,333.00,444.00,999.99,999.99,999.99,999.99,999.99,999.99,999.99,999.99,999.99,999.99,999.99,999.99,999.99,999.99,999.99,999.99 }},;
						{{ 999999999.99,999999999.99,999999999.99,999999999.99,999999999.99,999999999.99,999999999.99,999999999.99,22222.22,33.33,44444.44,11111.11,11111.11,11111.11,11111.11,11111.11,11111.11,11111.11,11111.11,11111.11,11111.11,911111.11,911111.11,911111.11,911111.11,911111.11,911111.11 }},;
						{{ 999999999.99,999999999.99,999999999.99,999999999.99,999999999.99,999999999.99,999999999.99,999999999.99,22222.22,33.33,44444.44,11111.11,11111.11,11111.11,11111.11,11111.11,11111.11,11111.11,11111.11,11111.11,11111.11,911111.11,911111.11,911111.11,911111.11,911111.11,911111.11 }},;
						{999999999.99},;
						{999999999.99},;
						{999999999.99},;
						{999999999.99},;
						{999999999.99},;
						{{ { Replicate("M", 70), 999999999.99 },{ Replicate("M", 70), 999999999.99 },{ Replicate("M", 70), 999999999.99 },;
						  { Replicate("M", 70), 999999999.99 },{ Replicate("M", 70), 999999999.99 },{ Replicate("M", 70), 999999999.99 },;
						  { Replicate("M", 70), 999999999.99 },{ Replicate("M", 70), 999999999.99 },{ Replicate("M", 70), 999999999.99 },{ Replicate("M", 70), 999999999.99 }} },;
						{999999999.99} } }

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

	oFont01		:= TFont():New("Arial",  08,  08, , .F., , , , .T., .F.) // Normal
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

	If ! lPrinter
		oPrint:Setup()
	EndIf

	For nX := 1 To Len(aDados)

		If ValType(aDados[nX]) == 'U' .OR. Len(aDados[nX]) == 0
			Loop
		EndIf

		For nI := 14 To 21
			If Len(aDados[nX, nI]) < 1
				For nJ := Len(aDados[nX, nI]) + 1 To 20
					If AllTrim(Str(nI)) $ "16"
						aAdd(aDados[nX, nI], StoD(""))
					ElseIf AllTrim(Str(nI)) $ "18,19,20,21"
						aAdd(aDados[nX, nI], 0)
					Else
						aAdd(aDados[nX, nI], "")
					EndIf
				Next nJ
			EndIf
		Next nI

		For nI := 27 To 27
			If Len(aDados[nX, nI]) < 1
				aAdd(aDados[nX, nI], { "", 0 })
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
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Box Principal                                                 ?
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		oPrint:Box(nLinIni + 0000, nColIni + 0000, nLinIni + nLinMax, nColIni + nColMax)

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Carrega e Imprime Logotipo da Empresa                         ?
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		//fLogoEmp(@cFileLogo,, cLogoGH)
		//fLogoEmp(@cFileLogo,"1",)
		cCompany := FWGrpCompany()
		cFileLogo  := cStartPath + "LGRL"+cCompany+FWCodFil()+".BMP" 	// Empresa+Filial
		cFileLogo1 := cStartPath + "LGRL"+cCompany+".BMP" 				// Empresa

		If File(cFilelogo)
			oPrint:SayBitmap(nLinIni + 0050, nColIni + 0020, cFileLogo, 400, 090) 		// Tem que estar abaixo do RootPath
		Else
		    oPrint:SayBitmap(nLinIni + 0050, nColIni + 0020, cFileLogo1, 400, 090) 		// Tem que estar abaixo do RootPath
		EndIf

		//If !File(cFileLogo) .OR. !File(cFileLogo1)
		//	oPrint:SayBitmap(nLinIni + 0050, nColIni + 0020, "\SYSTEM\LGRL.BMP", 400, 090) 		// Tem que estar abaixo do RootPath
	    //EndIf

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
		oPrint:Box(nLinIni + 0175, nColIni + 0320, nLinIni + 0269, nColIni + 2265 + nColA4)
		oPrint:Say(nLinIni + 0180, nColIni + 0330, "2 - "+"Nome da Operadora", oFont01) //"Nome da Operadora"
		oPrint:Say(nLinIni + 0210, nColIni + 0340, aDados[nX, 02], oFont04)
		oPrint:Box(nLinIni + 0175, nColIni + 2270 + nColA4, nLinIni + 0269, nColIni + 2735 + nColA4)
		oPrint:Say(nLinIni + 0180, nColIni + 2280 + nColA4, "3 - "+"CNPJ Operadora", oFont01) //"CNPJ Operadora"
		oPrint:Say(nLinIni + 0210, nColIni + 2290 + nColA4, aDados[nX, 03], oFont04)
		oPrint:Box(nLinIni + 0175, nColIni + 2740 + nColA4, nLinIni + 0269, nColIni + 3290 + nColA4)
		oPrint:Say(nLinIni + 0180, nColIni + 2750 + nColA4, "4 - "+"Número do Demonstrativo", oFont01) //"Número do Demonstrativo"
	   	oPrint:Say(nLinIni + 0210, nColIni + 2760 + nColA4, aDados[nX, 04, nX1], oFont04)
		oPrint:Box(nLinIni + 0175, nColIni + 3295 + nColA4, nLinIni + 0269, nColIni + 3695 + nColA4)
		oPrint:Say(nLinIni + 0180, nColIni + 3305 + nColA4, "5 - "+"Data Emissão do Demonstrativo", oFont01) //"Data Emissão do Demonstrativo"
		oPrint:Say(nLinIni + 0210, nColIni + 3315 + nColA4, DtoC(aDados[nX, 05, nX1]), oFont04)

		nLinIni += 20
		oPrint:Say(nLinIni + 0274, nColIni + 0010, "Dados do Prestador", oFont01) //"Dados do Prestador"
		oPrint:Box(nLinIni + 0304, nColIni + 0010, nLinIni + 0398, nColIni + 0426)
		oPrint:Say(nLinIni + 0309, nColIni + 0020, "6 - "+"Código Prestador / CNPJ / CPF", oFont01) //"Código Prestador / CNPJ / CPF"
		oPrint:Say(nLinIni + 0339, nColIni + 0030, aDados[nX, 06, nX1], oFont04)
		oPrint:Box(nLinIni + 0304, nColIni + 0431, nLinIni + 0398, nColIni + 2365)
		oPrint:Say(nLinIni + 0309, nColIni + 0441, "7 - "+"Nome", oFont01) //"Nome"
		oPrint:Say(nLinIni + 0339, nColIni + 0451, aDados[nX, 07, nX1], oFont04)
		oPrint:Box(nLinIni + 0304, nColIni + 2370, nLinIni + 0398, nColIni + 2580)
		oPrint:Say(nLinIni + 0309, nColIni + 2380, "8 - "+"Código CNES", oFont01) //"Código CNES"
		oPrint:Say(nLinIni + 0339, nColIni + 2390, aDados[nX, 08, nX1], oFont04)

		nLinIni += 20
		oPrint:Say(nLinIni + 0403, nColIni + 0010, "Dados do Pagamento", oFont01) //"Dados do Pagamento"
		oPrint:Box(nLinIni + 0433, nColIni + 0010, nLinIni + 0527, nColIni + 0526)
		oPrint:Say(nLinIni + 0438, nColIni + 0020, "9 - "+"Data do Pagamento", oFont01) //"Data do Pagamento"
		oPrint:Say(nLinIni + 0468, nColIni + 0030, DtoC(aDados[nX, 09, nX1]), oFont04)
		oPrint:Box(nLinIni + 0433, nColIni + 0531, nLinIni + 0527, nColIni + 1201)
		oPrint:Say(nLinIni + 0438, nColIni + 0541, "10 - "+"Forma de Pagamento", oFont01) //"Forma de Pagamento"
		oPrint:Line(nLinIni + 0463, nColIni + 0541, nLinIni + 0510, nColIni + 0541)
		oPrint:Line(nLinIni + 0510, nColIni + 0541, nLinIni + 0510, nColIni + 0588)
		oPrint:Line(nLinIni + 0463, nColIni + 0588, nLinIni + 0510, nColIni + 0588)
		oPrint:Say(nLinIni + 0468, nColIni + 0554, aDados[nX, 10, nX1,1], oFont04)
		oPrint:Say(nLinIni + 0478, nColIni + 0611, "Crédito em Conta", oFont01) //"Crédito em Conta"
		oPrint:Line(nLinIni + 0463, nColIni + 0791, nLinIni + 0510, nColIni + 0791)
		oPrint:Line(nLinIni + 0510, nColIni + 0791, nLinIni + 0510, nColIni + 0838)
		oPrint:Line(nLinIni + 0463, nColIni + 0838, nLinIni + 0510, nColIni + 0838)
		oPrint:Say(nLinIni + 0468, nColIni + 0804, aDados[nX, 10, nX1,2], oFont04)
		oPrint:Say(nLinIni + 0478, nColIni + 0861, "Carteira", oFont01) //"Carteira"
		oPrint:Line(nLinIni + 0463, nColIni + 0961, nLinIni + 0510, nColIni + 0961)
		oPrint:Line(nLinIni + 0510, nColIni + 0961, nLinIni + 0510, nColIni + 1008)
		oPrint:Line(nLinIni + 0463, nColIni + 1008, nLinIni + 0510, nColIni + 1008)
		oPrint:Say(nLinIni + 0468, nColIni + 0974, aDados[nX, 10, nX1,3], oFont04)
		oPrint:Say(nLinIni + 0478, nColIni + 1031, "Boleto Bancário", oFont01) //"Boleto Bancário"
		oPrint:Box(nLinIni + 0433, nColIni + 1206, nLinIni + 0527, nColIni + 1456)
		oPrint:Say(nLinIni + 0438, nColIni + 1216, "11 - "+"Banco", oFont01) //"Banco"
		oPrint:Say(nLinIni + 0468, nColIni + 1226, aDados[nX, 11, nX1], oFont04)
		oPrint:Box(nLinIni + 0433, nColIni + 1461, nLinIni + 0527, nColIni + 1711)
		oPrint:Say(nLinIni + 0438, nColIni + 1471, "12 - "+"Agência", oFont01) //"Agência"
		oPrint:Say(nLinIni + 0468, nColIni + 1481, aDados[nX, 12, nX1], oFont04)
		oPrint:Box(nLinIni + 0433, nColIni + 1716, nLinIni + 0527, nColIni + 2130)
		oPrint:Say(nLinIni + 0438, nColIni + 1726, "13 - "+"Número da conta/Cheque", oFont01) //"Número da conta/Cheque"
		oPrint:Say(nLinIni + 0468, nColIni + 1736, aDados[nX, 13, nX1], oFont04)

   		lBox:=.F.
		oPrint:Say(nLinIni + 0532, nColIni + 0010, "Dados do Resumo", oFont01) //"Dados do Resumo"

		if (nLinIni + 645 + (Len(aDados[nX, 14, nX1]) * 45)) < nLinMax
			oPrint:Box(nLinIni + 0562, nColIni + 0010, nLinIni + 645 + (Len(aDados[nX, 14, nX1]) * 45), nColIni + 3695 + nColA4)
		Else
			oPrint:Line(nLinIni + 0562, nColIni + 0010, nLinIni + 0045, nColIni + 3695 + nColA4)
		 	oPrint:Line(nLinIni + 0562, nColIni + 0010, nLinIni + 0090, nColIni + 0010)
		 	oPrint:Line(nLinIni + 0562, nColIni + 3695 + nColA4, nLinIni + 0090, nColIni + 3695 + nColA4)
		  	lBox:=.T.
		Endif

		oPrint:Say(nLinIni + 0567, nColIni + 0020, "14 - "+"Número da Fatura", oFont01) //"Número da Fatura"
		oPrint:Say(nLinIni + 0567, nColIni + 0520, "15 - "+"Número do Lote", oFont01) //"Número do Lote"
		oPrint:Say(nLinIni + 0567, nColIni + 1020, "16 - "+"Data de Envio do Lote", oFont01) //"Data de Envio do Lote"
		oPrint:Say(nLinIni + 0567, nColIni + 1320, "17 - "+"Número do Protocolo", oFont01) //"Número do Protocolo"
		oPrint:Say(nLinIni + 0567, nColIni + 2173 + nColA4/2, "18 - "+"Valor Informado (R$)", oFont01,,,,1) //"Valor Informado (R$)"
		oPrint:Say(nLinIni + 0567, nColIni + 2582 + nColA4/2, "19 - "+"Valor Processado (R$)", oFont01,,,,1) //"Valor Processado (R$)"
		oPrint:Say(nLinIni + 0567, nColIni + 2991 + nColA4/2, "20 - "+"Valor Liberado (R$)", oFont01,,,,1) //"Valor Liberado (R$)"
		oPrint:Say(nLinIni + 0567, nColIni + 3350 + nColA4/2, "21 - "+"Valor da Glosa (R$)", oFont01,,,,1) //"Valor da Glosa (R$)"

		fSomaLin(nLinMax, nColMax, @nLinIni, nColIni, 600)

		For nI := 1 To Len(aDados[nX, 14, nX1])

			if lBox
				oPrint:Line(nLinIni + 0010, nColIni + 0010, nLinIni + 0115, nColIni  + 0010)
				oPrint:Line(nLinIni + 0010, nColIni  + 3695 + nColA4, nLinIni + 0115, nColIni  + 3695 + nColA4)
			Endif

			oPrint:Say(nLinIni + 0010, nColIni + 0020, aDados[nX, 14, nX1, nI], oFont04)
			oPrint:Say(nLinIni + 0010, nColIni + 0520, aDados[nX, 15, nX1, nI], oFont04)
			oPrint:Say(nLinIni + 0010, nColIni + 1020, IIf(Empty(aDados[nX, 14, nX1, nI]), "", DtoC(aDados[nX, 16, nX1, nI])), oFont04)
			oPrint:Say(nLinIni + 0010, nColIni + 1320, aDados[nX, 17, nX1, nI], oFont04)
			oPrint:Say(nLinIni + 0010, nColIni + 2173 + nColA4/2, IIf(Empty(aDados[nX, 14, nX1, nI]), "", Transform(aDados[nX, 18, nX1, nI], "@E 999,999,999.99")), oFont04,,,,1)
			oPrint:Say(nLinIni + 0010, nColIni + 2582 + nColA4/2, IIf(Empty(aDados[nX, 14, nX1, nI]), "", Transform(aDados[nX, 19, nX1, nI], "@E 999,999,999.99")), oFont04,,,,1)
			oPrint:Say(nLinIni + 0010, nColIni + 2991 + nColA4/2, IIf(Empty(aDados[nX, 14, nX1, nI]), "", Transform(aDados[nX, 20, nX1, nI], "@E 999,999,999.99")), oFont04,,,,1)
			oPrint:Say(nLinIni + 0010, nColIni + 3350 + nColA4/2, IIf(Empty(aDados[nX, 14, nX1, nI]), "", Transform(aDados[nX, 21, nX1, nI], "@E 999,999,999.99")), oFont04,,,,1)
			fSomaLin(nLinMax, nColMax, @nLinIni, nColIni, 45)
		Next nI

		//Para arrumar o Box qdo tem muitas faturas ->Luciano
		if lBox
		 	oPrint:Line(nLinIni + 0010, nColIni + 0010, nLinIni + 0090, nColIni + 0010)
			oPrint:Line(nLinIni + 0010, nColIni + 3695 + nColA4, nLinIni + 0090, nColIni + 3695 + nColA4)
			oPrint:Line(nLinIni + 0020, nColIni + 0010, nLinIni + 0020, nColIni + 3695 + nColA4)
		Endif

		fSomaLin(nLinMax, nColMax, @nLinIni, nColIni, 45)
		oPrint:Box(nLinIni + 0027, nColIni + 0010, nLinIni + 0131, nColIni + 3695 + nColA4)
		oPrint:Say(nLinIni + 0032, nColIni + 0020, "Total Geral", oFont01) //"Total Geral"
		oPrint:Box(nLinIni + 0032, nColIni + 1789 + nColA4, nLinIni + 0126, nColIni + 2193 + nColA4)
		oPrint:Say(nLinIni + 0036, nColIni + 1799 + nColA4, "22 - " + "Total Geral Valor Informado (R$)", oFont01) //"Total Geral Valor Informado (R$)"
		oPrint:Say(nLinIni + 0066, nColIni + 2173 + nColA4, Transform(aDados[nX, 22, nX1], "@E 999,999,999.99"), oFont04,,,,1)
		oPrint:Box(nLinIni + 0032, nColIni + 2198 + nColA4, nLinIni + 0126, nColIni + 2602 + nColA4)
		oPrint:Say(nLinIni + 0036, nColIni + 2208 + nColA4, "23 - "+"Total Geral Valor Processado (R$)", oFont01) //"Total Geral Valor Processado (R$)"
		oPrint:Say(nLinIni + 0066, nColIni + 2582 + nColA4, Transform(aDados[nX, 23, nX1], "@E 999,999,999.99"), oFont04,,,,1)
		oPrint:Box(nLinIni + 0032, nColIni + 2607 + nColA4, nLinIni + 0126, nColIni + 3011 + nColA4)
		oPrint:Say(nLinIni + 0036, nColIni + 2617 + nColA4, "24 - "+"Total Geral Valor Liberado (R$)", oFont01) //"Total Geral Valor Liberado (R$)"
		oPrint:Say(nLinIni + 0066, nColIni + 2991 + nColA4, Transform(aDados[nX, 24, nX1], "@E 999,999,999.99"), oFont04,,,,1)
		oPrint:Box(nLinIni + 0032, nColIni + 3016 + nColA4, nLinIni + 0126, nColIni + 3420 + nColA4)
		oPrint:Say(nLinIni + 0036, nColIni + 3026 + nColA4, "25 - "+"Total Geral Glosa (R$)", oFont01) //"Total Geral Glosa (R$)"
		oPrint:Say(nLinIni + 0066, nColIni + 3400 + nColA4, Transform(aDados[nX, 25, nX1], "@E 999,999,999.99"), oFont04,,,,1)

		fSomaLin(nLinMax, nColMax, @nLinIni, nColIni, 100)
		oPrint:Box(nLinIni + 0036, nColIni + 0010, nLinIni + 0140, nColIni + 3695 + nColA4)
		oPrint:Box(nLinIni + 0041, nColIni + 3016 + nColA4, nLinIni + 0135, nColIni + 3420 + nColA4)
		oPrint:Say(nLinIni + 0046, nColIni + 0020 + nColA4, "26 - "+"Total Valor", oFont01) //"Total Valor"
		oPrint:Say(nLinIni + 0076, nColIni + 3400 + nColA4, Transform(aDados[nX, 26, nX1], "@E 999,999,999.99"), oFont04,,,,1)

		lBox:=.F.
		fSomaLin(nLinMax, nColMax, @nLinIni, nColIni, 100)

		if (nLinIni + 110 + (Len(aDados[nX, 27, nX1]) * 45)) < nLinMax
			oPrint:Box(nLinIni + 0045, nColIni + 0010, nLinIni + 110 + (Len(aDados[nX, 27, nX1]) * 45), nColIni + 3695 + nColA4)
		Else
			oPrint:Line(nLinIni + 0045, nColIni + 0010, nLinIni + 0045, nColIni + 3695 + nColA4)
		 	oPrint:Line(nLinIni + 0045, nColIni + 0010, nLinIni + 0090, nColIni + 0010)
		 	oPrint:Line(nLinIni + 0045, nColIni + 3695 + nColA4, nLinIni + 0090, nColIni + 3695 + nColA4)
		  	lBox:=.T.
		Endif

		oPrint:Say(nLinIni + 0050, nColIni + 0020, "27 - "+"Demais Descontos ou Créditos", oFont01) //"Demais Descontos ou Créditos"

		For nI := 1 To Len(aDados[nX, 27, nX1])

			if lBox
				oPrint:Line(nLinIni + 0045, nColIni + 0010, nLinIni + 0115, nColIni  + 0010)
				oPrint:Line(nLinIni + 0045, nColIni  + 3695 + nColA4, nLinIni + 0115, nColIni  + 3695 + nColA4)
			Endif

			oPrint:Say(nLinIni + 0085, nColIni + 0030, aDados[nX, 27, nX1, nI, 1], oFont04)
			oPrint:Say(nLinIni + 0085, nColIni + 3400 + nColA4, IIf(Empty(aDados[nX, 27, nX1, nI, 1]), "", Transform(aDados[nX, 27, nX1, nI, 2], "@E 999,999,999,999.99")), oFont04,,,,1)
		   	fSomaLin(nLinMax, nColMax, @nLinIni, nColIni, 45)

		Next nI

		//Para arrumar o Box qdo tem muitos demais descontos ou créditos ->Luciano
		if lBox
		 	oPrint:Line(nLinIni + 0045, nColIni + 0010, nLinIni + 0090, nColIni + 0010)
			oPrint:Line(nLinIni + 0045, nColIni + 3695 + nColA4, nLinIni + 0090, nColIni + 3695 + nColA4)
			oPrint:Line(nLinIni + 0090, nColIni + 0010, nLinIni + 0090, nColIni + 3695 + nColA4)
		Endif

		fSomaLin(nLinMax, nColMax, @nLinIni, nColIni, 60)
		oPrint:Box(nLinIni + 0056, nColIni + 0010, nLinIni + 0160, nColIni + 3695 + nColA4)
		oPrint:Box(nLinIni + 0061, nColIni + 3016 + nColA4, nLinIni + 0155, nColIni + 3420 + nColA4)
		oPrint:Say(nLinIni + 0066, nColIni + 0020 + nColA4, "28 - "+"Total Valor Liberado", oFont01) //"Total Valor Liberado"
		oPrint:Say(nLinIni + 0096, nColIni + 3400 + nColA4, Transform(aDados[nX, 28, nX1], "@E 999,999,999,999.99"), oFont04,,,,1)

	Next nX1

	oPrint:EndPage()	// Finaliza a pagina


Next nX

	oPrint:Preview() // Visualiza impressao grafica antes de imprimir
//	oPrint:Print()

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡ao    ?PLSTISS9  ?Autor ?Luciano Aparecido     ?Data ?10.03.07 ³±?
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡ao ?Estrutura Relatório TISS (Guia Odontológica - Cobrança)     ³±?
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±?Uso      ?SigaPLS                                                     ³±?
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros?aDados - Array com as informações do relat´rio              ³±?
±±?         ?nLayout - Define o formato de papél para impressao:         ³±?
±±?         ?          1 - Formato Ofício II (216x330mm)                 ³±?
±±?         ?          2 - Formato A4 (210x297mm)                        ³±?
±±?         ? 		 3 - Formato Carta (216x279mm)     			       ³±?
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function CABTISS9(aDados, nLayout, cLogoGH, lGerTXT, lWeb, cPathRelW) //Guia Odontológica - Cobrança

	Local nLinMax
	Local nColMax
	Local nLinIni	:=	0		// Linha Lateral (inicial) Esquerda
	Local nColIni	:=	0		// Coluna Lateral (inicial) Esquerda
	Local nColA4    :=  0
	Local cFileLogo
  	Local nLin
	Local nN, nX
	Local nI, nJ
	Local cObs
	Local oFont01
	Local oFont02n
	Local oFont03n
	Local oFont04
	Local oPrint    := Nil
	Local nT        := 0
	Local nP		:= 0
	Local nP1		:= 0
	Local nAte 		:= 20
	Local lImpnovo 	:= .T.
	Local nVolta	:= 0
	Local cMsg 		:= ""
	LOCAL cFileName	:= ""
	LOCAL cRel      := "GUICONS"
	LOCAL cPathSrvJ := GETMV("MV_RELT")
	LOCAL nAL		:= 0.25
	LOCAL nAC		:= 0.24
	LOCAL cTissVer:= "2.02.03"
	LOCAL cImpDatRea:= GetNewPar("MV_PLSIMDR","S") //Habilita/Desabilita a impressão do campo (Data Realização) na Guia Odontológica (S ou N).

	If FindFunction("PLSTISSVER")
		cTissVer	:= PLSTISSVER()
	EndIf

	DEFAULT lGerTXT 	:= .F.
	DEFAULT nLayout 	:= 2
	DEFAULT cLogoGH 	:= ""
	DEFAULT lWeb		:= .F.
	DEFAULT cPathRelW 	:= ""
	DEFAULT aDados  := { { ;
						"123456",;                      //1 - Registro ANS
						"12345678901234567892",;
						CtoD("05/03/07"),;
						CtoD("05/03/07"),;
						"12345678901234567892",;        //5 - Senha
						CtoD("01/12/07"),;
						"12345678901234567892",;
						"12345678901234567892",;
						Replicate("M",40),;
						Replicate("M",40),;             //10 - Empresa
						CtoD("01/12/07"),;
						"123456789012345",;
						Replicate("M",70),;
						"1199999999",;
						Replicate("M",40),;             //15 - Nome do títular do plano
						Replicate("M",70),;
						"123456789012345",;
						"SP",;
						"12345",;
						"14.141.114/00001-35",;			//20 - Código na Operadora / CNPJ / CPF
						Replicate("M",70),;
						"123456789012345",;
						"SP",;
						"1234567",;
						Replicate("M",70),;             //25 - Profissional Executante
						"123456789012345",;
						"SP",;
						"12345",;
						{"AA","BB","CC","DD","EE","FF","GG","HH","II","JJ","KK","LL","MM","NN","OO","PP"},;
					    {"1234567890","1234567890","1234567890","1234567890","1234567890","1234567890","1234567890","1234567890","1234567890","1234567890","1234567890","1234567890","1234567890","1234567890","1234567890","1234567890"},;
						{Replicate("M",40),Replicate("M",40),Replicate("M",40),Replicate("M",70),Replicate("M",70),Replicate("M",70),Replicate("M",70),Replicate("M",70),Replicate("M",70),Replicate("M",70),Replicate("M",70),Replicate("M",70),Replicate("M",70),Replicate("M",70),Replicate("M",70),Replicate("M",70)},;
						{"1234","1234","1234","1234","1234","1234","1234","1234","1234","1234","1234","1234","1234","1234","1234","1234"},;
						{"ABCDE","ABCDE","ABCDE","ABCDE","ABCDE","ABCDE","ABCDE","ABCDE","ABCDE","ABCDE","ABCDE","ABCDE","ABCDE","ABCDE","ABCDE","ABCDE"},;
						{10,20,30,40,50,60,70,80,90,15,25,35,45,55,65,75},;
						{99999.99,99999.99,99999.99,99999.99,99999.99,99999.99,99999.99,99999.99,99999.99,99999.99,99999.99,99999.99,99999.99,99999.99,99999.99,99999.99},;
						{99999.99,99999.99,99999.99,99999.99,99999.99,99999.99,99999.99,99999.99,99999.99,99999.99,99999.99,99999.99,99999.99,99999.99,99999.99,99999.99},;
						{99999.99,99999.99,99999.99,99999.99,99999.99,99999.99,99999.99,99999.99,99999.99,99999.99,99999.99,99999.99,99999.99,99999.99,99999.99,99999.99},;
						{"A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A"},;
						{CtoD("01/03/07"),CtoD("01/03/07"),CtoD("01/03/07"),CtoD("01/03/07"),CtoD("01/03/07"),CtoD("01/03/07"),CtoD("01/03/07"),CtoD("01/03/07"),CtoD("01/03/07"),CtoD("01/03/07"),CtoD("01/03/07"),CtoD("01/03/07"),CtoD("01/03/07"),CtoD("01/03/07"),CtoD("01/03/07"),CtoD("01/03/07")},;
						{"","","","","","","","","","","","","","","",""},;             //Posição 40
						CtoD("01/04/07"),;
						"1",;
						"1",;
				   		999999.99,;
						999999.99,;
						999999.99,;
						Replicate("M", 240),;
					 	CtoD("30/12/07"),;
					 	Replicate("M",30),;
						CtoD("30/12/07"),;
						Replicate("M",30),;
						CtoD("30/12/07"),;
						Replicate("M",30),;
						CtoD("30/12/07"),;
						Replicate("M",30)} }



	If nLayout  == 1 // Ofício 2
		nLinMax := 2435
		nColMax := 3705
	Elseif nLayout == 2   // Papél A4
	   	nLinMax	:=	2290
		nColMax	:=	3350 //3365
	Else //Carta
		nLinMax	:=	2435
		nColMax	:=	3175
	Endif

	oFont01		:= TFont():New("Arial",  4,  4, , .F., , , , .T., .F.) // Normal
	if nLayout == 1 // Oficio 2
		oFont02n	:= TFont():New("Arial", 12, 12, , .T., , , , .T., .F.) // Negrito
		oFont03n	:= TFont():New("Arial", 14, 14, , .T., , , , .T., .F.) // Negrito
		oFont04		:= TFont():New("Arial", 09, 09, , .F., , , , .T., .F.) // Normal
	Else  // Papél A4 ou Carta
	  	oFont02n := TFont():New("Arial", 12, 12, , .T., , , , .T., .F.) // Negrito
		oFont03n := TFont():New("Arial", 13, 13, , .T., , , , .T., .F.) // Negrito
		oFont04	 := TFont():New("Arial", 07, 07, , .F., , , , .T., .F.) // Normal
	Endif

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
	//?Nao permite acionar a impressao quando for na web.
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
	If lWeb
		cPathSrvJ := cPathRelW
		cFileName := cRel+CriaTrab(NIL,.F.)+".pdf"
	Else
		cFileName := cRel+CriaTrab(NIL,.F.)
	EndIf

	//						New ( < cFilePrintert >, [ nDevice], [ lAdjustToLegacy], [ cPathInServer], [ lDisabeSetup ], [ lTReport], [ @oPrintSetup], [ cPrinter], [ lServer], [ lPDFAsPNG], [ lRaw], [ lViewPDF] )
	If !lWeb
	oPrint := FWMSPrinter():New ( cFileName			,			,	.F.				,cPathSrvJ	 	,	.T.				,			 ,				,			  ,			  ,	.F.			, 		, 				)
	Else
		oPrint := FWMSPrinter():New ( cFileName	,,.F.,cPathSrvJ	 ,.T.,	,@oPrint,			  ,			  ,	.F.			,.f.)
		If lSrvUnix
			AjusPath(@oPrint)
		EndIf
	EndIf
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
	//³Tratamento para impressao via job
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
	//oPrint:lInJob  := lWeb
	oPrint:lServer := lWeb
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
	//?Caminho do arquivo
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
	oPrint:cPathPDF := cPathSrvJ

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
	//³Modo paisagem
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
	oPrint:SetLandscape()

	If nLayout ==2
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
		//³Papél A4
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
		oPrint:SetPaperSize(9)
	ElseIf nLayout ==3
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
		//³Papél Carta
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
		oPrint:SetPaperSize(1)
	Else
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
		//³Papel Oficio2 216 x 330mm / 8 1/2 x 13in
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
		oPrint:SetPaperSize(14)
	Endif
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
	//³Device
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
	If lWeb
		oPrint:setDevice(IMP_PDF)
		oPrint:lPDFAsPNG := .T.
	EndIf

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
	//³Verifica se existe alguma impressora configurada para Impressao Grafica
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
	If  !lWeb
		oPrint:Setup()
		If (oPrint:nModalResult == 2) // Clicou no botao cancelar
			lRet := .F.
			lMail := .F.
			Return
		Else
			lImpnovo:=(oPrint:nModalResult == 1)
		Endif
	EndIf

If cTissVer < "3"
	nAte := 17
	 While lImpnovo
	 	lImpnovo:=.F.
	 	nVolta 	+= 1
	 	nAte	+= nP
		For nX := 1 To Len(aDados)

			If ValType(aDados[nX]) == 'U' .OR. Len(aDados[nX]) == 0
				Loop
			EndIf

	   		If oPrint:Cprinter == "PDF" .OR. lWeb
				nLinIni := 130
				nColMax -= 15
			Else
				nLinIni := 080
			Endif
			nColIni := 080
			nColA4  := 000

			oPrint:StartPage()		// Inicia uma nova pagina
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Box Principal                                                 ?
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			oPrint:Box((nLinIni + 0000)*nAL, (nColIni + 0000)*nAC, (nLinIni + nLinMax)*nAL, (nColIni + nColMax)*nAC)

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Carrega e Imprime Logotipo da Empresa                         ?
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


			For nI := 29 To 40
				If Len(aDados[nX, nI]) < nAte
					For nJ := Len(aDados[nX, nI]) + 1 To nAte
						If AllTrim(Str(nI)) $ "34,35,36,37"
							aAdd(aDados[nX, nI], 0)
						ElseiF AllTrim(Str(nI)) $ "39"
							aAdd(aDados[nX, nI], StoD(""))
						Else
							aAdd(aDados[nX, nI],"")
						EndIf
					Next nJ
				EndIf
			Next nI

	   		If oPrint:Cprinter == "PDF" .OR. lWeb
				nLinIni := 130
				nColMax -= 15
			Else
				nLinIni := 080
			Endif
			nColIni := 080
			nColA4  := 000

			oPrint:StartPage()		// Inicia uma nova pagina
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Box Principal                                                 ?
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			oPrint:Box((nLinIni + 0000)*nAL, (nColIni + 0000)*nAC, (nLinIni + nLinMax)*nAL, (nColIni + nColMax)*nAC)

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Carrega e Imprime Logotipo da Empresa                         ?
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

			oPrint:Say((nLinIni + 0090)*nAL, (nColIni + 1482 + IIF(nLayout ==2 .Or. nLayout ==3,nColA4+160,0))*nAC, "GUIA TRATAMENTO ODONTOLÓGICO", oFont02n,,,, 2) //"GUIA TRATAMENTO ODONTOLÓGICO"
//			oPrint:Say((nLinIni + 0090)*nAL, (nColIni + 3000 + nColA4)*nAC, "2 - "+OemToAnsi("Nº"), oFont01) //"N?da guia no prestador"
			oPrint:Say((nLinIni + 0090)*nAL, (nColIni + 3096 + nColA4)*nAC, aDados[nX, 02], oFont03n)

			nLinIni+= 80
			oPrint:Box((nLinIni + 0155)*nAL, (nColIni + 0010)*nAC, (nLinIni + 0249)*nAL, (nColIni + 0315)*nAC)
			oPrint:Say((nLinIni + 0180)*nAL, (nColIni + 0020)*nAC, "1 - "+"Registro ANS", oFont01) //"Registro ANS"
			oPrint:Say((nLinIni + 0220)*nAL, (nColIni + 0030)*nAC, aDados[nX, 01], oFont04)
			oPrint:Box((nLinIni + 0155)*nAL, (nColIni + 0320)*nAC, (nLinIni + 0249)*nAL, (nColIni + 0625)*nAC)
			oPrint:Say((nLinIni + 0180)*nAL, (nColIni + 0330)*nAC, "3 - "+"Data Emissão Guia", oFont01) //"Data Emissão Guia"
			oPrint:Say((nLinIni + 0220)*nAL, (nColIni + 0340)*nAC, DtoC(aDados[nX, 03]), oFont04)
			oPrint:Box((nLinIni + 0155)*nAL, (nColIni + 0630)*nAC, (nLinIni + 0249)*nAL, (nColIni + 935)*nAC)
			oPrint:Say((nLinIni + 0180)*nAL, (nColIni + 0640)*nAC, "4 - "+"Data da Autorização", oFont01) //"Data da Autorização"
			oPrint:Say((nLinIni + 0220)*nAL, (nColIni + 0650)*nAC, DtoC(aDados[nX, 04]), oFont04)
			oPrint:Box((nLinIni + 0155)*nAL, (nColIni + 0940)*nAC, (nLinIni + 0249)*nAL, (nColIni + 1345)*nAC)
			oPrint:Say((nLinIni + 0180)*nAL, (nColIni + 0950)*nAC, "5 - "+"Senha", oFont01) //"Senha"
			oPrint:Say((nLinIni + 0220)*nAL, (nColIni + 0960)*nAC, aDados[nX, 05], oFont04)
			oPrint:Box((nLinIni + 0155)*nAL, (nColIni + 1350)*nAC, (nLinIni + 0249)*nAL, (nColIni + 1665)*nAC)
			oPrint:Say((nLinIni + 0180)*nAL, (nColIni + 1360)*nAC, "6 - "+"Data Validade da Senha", oFont01) //"Data Validade da Senha"
			oPrint:Say((nLinIni + 0220)*nAL, (nColIni + 1370)*nAC, DtoC(aDados[nX, 06]), oFont04)
			oPrint:Box((nLinIni + 0155)*nAL, (nColIni + 1670)*nAC, (nLinIni + 0249)*nAL, (nColIni + 2075)*nAC)
			oPrint:Say((nLinIni + 0180)*nAL, (nColIni + 1680)*nAC, "7 - "+"Número da guia principal", oFont01) //"Número da Guia Principal"
			oPrint:Say((nLinIni + 0220)*nAL, (nColIni + 1690)*nAC, aDados[nX, 07], oFont04)

		    nLinIni += 10
			oPrint:Say((nLinIni + 0274)*nAL, (nColIni + 0010)*nAC, "Dados do Beneficiário", oFont01) //"Dados do Beneficiário"
			oPrint:Box((nLinIni + 0284)*nAL, (nColIni + 0010)*nAC, (nLinIni + 0378)*nAL, (nColIni + 0415)*nAC)
			oPrint:Say((nLinIni + 0309)*nAL, (nColIni + 0020)*nAC, "8 - "+"Número da Carteira", oFont01) //"Número da Carteira"
			oPrint:Say((nLinIni + 0349)*nAL, (nColIni + 0030)*nAC, aDados[nX, 08], oFont04)

			oPrint:Box((nLinIni + 0284)*nAL, (nColIni + 0420)*nAC, (nLinIni + 0378)*nAL, (nColIni + 1770 + nColA4)*nAC)
			oPrint:Say((nLinIni + 0309)*nAL, (nColIni + 0430)*nAC, "9 - "+"Plano", oFont01) //"Plano"
			oPrint:Say((nLinIni + 0349)*nAL, (nColIni + 0440)*nAC, aDados[nX, 09], oFont04)

			oPrint:Box((nLinIni + 0284)*nAL, (nColIni + 1775 + nColA4)*nAC, (nLinIni + 0378)*nAL, (nColIni + 2835 + nColA4)*nAC)
			oPrint:Say((nLinIni + 0309)*nAL, (nColIni + 1785 + nColA4)*nAC, "10 - "+"Empresa", oFont01) //"Empresa"
			oPrint:Say((nLinIni + 0349)*nAL, (nColIni + 1795 + nColA4)*nAC, aDados[nX, 10], oFont04)

			oPrint:Box((nLinIni + 0284)*nAL, (nColIni + 2840 + nColA4)*nAC, (nLinIni + 0378)*nAL, (nColIni + 3145 + nColA4)*nAC)
			oPrint:Say((nLinIni + 0309)*nAL, (nColIni + 2850 + nColA4)*nAC, "11 - "+"Data Validade da Carteira", oFont01) //"Data Validade da Carteira"
			oPrint:Say((nLinIni + 0349)*nAL, (nColIni + 2860 + nColA4)*nAC, DtoC(aDados[nX, 11]), oFont04)

			oPrint:Box((nLinIni + 0284)*nAL, (nColIni + 3150 + nColA4)*nAC, (nLinIni + 0378)*nAL, (nColIni + 3590 + nColA4)*nAC)
			oPrint:Say((nLinIni + 0309)*nAL, (nColIni + 3160 + nColA4)*nAC, "12 - "+"Número do Cartão Nacional de Saúde", oFont01) //"Número do Cartão Nacional de Saúde"
			oPrint:Say((nLinIni + 0349)*nAL, (nColIni + 3170 + nColA4)*nAC, aDados[nX, 12], oFont04)

			oPrint:Box((nLinIni + 0383)*nAL, (nColIni + 0010)*nAC, (nLinIni + 0477)*nAL, (nColIni + 2100 + nColA4)*nAC)
			oPrint:Say((nLinIni + 0407)*nAL, (nColIni + 0020)*nAC, "13 - "+"Nome", oFont01) //"Nome"
			oPrint:Say((nLinIni + 0447)*nAL, (nColIni + 0030)*nAC, aDados[nX, 13], oFont04)

			oPrint:Box((nLinIni + 0383)*nAL, (nColIni + 2105 + nColA4)*nAC, (nLinIni + 0477)*nAL, (nColIni + 2435 + nColA4)*nAC)
			oPrint:Say((nLinIni + 0407)*nAL, (nColIni + 2115 + nColA4)*nAC, "14 - "+"Telefone", oFont01) //"Telefone"
			oPrint:Say((nLinIni + 0447)*nAL, (nColIni + 2125 + nColA4)*nAC, aDados[nX, 14], oFont04)

			oPrint:Box((nLinIni + 0383)*nAL, (nColIni + 2440 + nColA4)*nAC, (nLinIni + 0477)*nAL, (nColIni + 3590 + nColA4)*nAC)
			oPrint:Say((nLinIni + 0407)*nAL, (nColIni + 2450 + nColA4)*nAC, "15 - "+"Nome do Titular do Plano", oFont01) //"Nome do Titular do Plano"
			oPrint:Say((nLinIni + 0447)*nAL, (nColIni + 2460 + nColA4)*nAC, aDados[nX, 15], oFont04)

			nLinIni += 10
			oPrint:Say((nLinIni + 0502)*nAL, (nColIni + 0010)*nAC, "Dados do Contratado Responsável pelo Tratamento", oFont01) 		 //"Dados do Contratado Responsável pelo Tratamento"

			oPrint:Box((nLinIni + 0512)*nAL, (nColIni + 0010)*nAC, (nLinIni + 0607)*nAL, (nColIni + 1990)*nAC)
			oPrint:Say((nLinIni + 0537)*nAL, (nColIni + 0020)*nAC, "16 - " + "Nome do Profissional Solicitante", oFont01) //"Nome do Profissional Solicitante"
			oPrint:Say((nLinIni + 0577)*nAL, (nColIni + 0030)*nAC, aDados[nX, 16], oFont04)

			oPrint:Box((nLinIni + 0512)*nAL, (nColIni + 1995)*nAC, (nLinIni + 0607)*nAL, (nColIni + 2310)*nAC)
			oPrint:Say((nLinIni + 0537)*nAL, (nColIni + 2005)*nAC, "17 - " + "Número no CRO", oFont01) //"Número no CRO"
			oPrint:Say((nLinIni + 0577)*nAL, (nColIni + 2015)*nAC, aDados[nX, 17], oFont04)

			oPrint:Box((nLinIni + 0512)*nAL, (nColIni + 2315)*nAC, (nLinIni + 0607)*nAL, (nColIni + 2425)*nAC)
			oPrint:Say((nLinIni + 0537)*nAL, (nColIni + 2325)*nAC, "18 - " + "UF", oFont01) //"UF"
			oPrint:Say((nLinIni + 0577)*nAL, (nColIni + 2335)*nAC, aDados[nX, 18], oFont04)

			oPrint:Box((nLinIni + 0512)*nAL, (nColIni + 2430)*nAC, (nLinIni + 0607)*nAL, (nColIni + 2645)*nAC)
			oPrint:Say((nLinIni + 0537)*nAL, (nColIni + 2440)*nAC, "19 - " + "Código CBO S", oFont01) //"Código CBO S"
			oPrint:Say((nLinIni + 0577)*nAL, (nColIni + 2450)*nAC, aDados[nX, 19], oFont04)

			oPrint:Box((nLinIni + 0611)*nAL, (nColIni + 0010)*nAC, (nLinIni + 0706)*nAL, (nColIni + 0426)*nAC)
			oPrint:Say((nLinIni + 0636)*nAL, (nColIni + 0020)*nAC, "20 - "+"Código na Operadora / CNPJ / CPF", oFont01) //"Código na Operadora / CNPJ / CPF"
			oPrint:Say((nLinIni + 0676)*nAL, (nColIni + 0030)*nAC, aDados[nX, 20], oFont04)

			oPrint:Box((nLinIni + 0611)*nAL, (nColIni + 0431)*nAC, (nLinIni + 0706)*nAL, (nColIni + 2410)*nAC)
			oPrint:Say((nLinIni + 0636)*nAL, (nColIni + 0441)*nAC, "21 - "+"Nome do Contratado", oFont01) //"Nome do Contratado"
			oPrint:Say((nLinIni + 0676)*nAL, (nColIni + 0451)*nAC, SubStr(aDados[nX, 21], 1, 65), oFont04)

			oPrint:Box((nLinIni + 0611)*nAL, (nColIni + 2415)*nAC, (nLinIni + 0706)*nAL, (nColIni + 2745)*nAC)
			oPrint:Say((nLinIni + 0636)*nAL, (nColIni + 2425)*nAC, "22 - "+"Número no CRO", oFont01) //"Número no CRO"
			oPrint:Say((nLinIni + 0676)*nAL, (nColIni + 2435)*nAC, aDados[nX, 22], oFont04)

			oPrint:Box((nLinIni + 0611)*nAL, (nColIni + 2750)*nAC, (nLinIni + 0706)*nAL, (nColIni + 2850)*nAC)
			oPrint:Say((nLinIni + 0636)*nAL, (nColIni + 2760)*nAC, "23 - "+"UF", oFont01) //"UF"
			oPrint:Say((nLinIni + 0676)*nAL, (nColIni + 2770)*nAC, aDados[nX, 23], oFont04)

			oPrint:Box((nLinIni + 0611)*nAL, (nColIni + 2855)*nAC, (nLinIni + 0706)*nAL, (nColIni + 3065)*nAC)
			oPrint:Say((nLinIni + 0636)*nAL, (nColIni + 2865)*nAC, "24 - "+"Código CNES", oFont01) //"Código CNES"
			oPrint:Say((nLinIni + 0676)*nAL, (nColIni + 2875)*nAC, aDados[nX, 24], oFont04)

			oPrint:Box((nLinIni + 0710)*nAL, (nColIni + 0010)*nAC, (nLinIni + 0805)*nAL, (nColIni + 1990)*nAC)
			oPrint:Say((nLinIni + 0735)*nAL, (nColIni + 0020)*nAC, "25 - "+"Nome do Profissional Executante", oFont01) //"Nome do Profissional Executante"
			oPrint:Say((nLinIni + 0775)*nAL, (nColIni + 0030)*nAC, aDados[nX, 25], oFont04)

			oPrint:Box((nLinIni + 0710)*nAL, (nColIni + 1995)*nAC, (nLinIni + 0805)*nAL, (nColIni + 2310)*nAC)
			oPrint:Say((nLinIni + 0735)*nAL, (nColIni + 2005)*nAC, "26 - "+"Número no CRO", oFont01) //"Número no CRO"
			oPrint:Say((nLinIni + 0775)*nAL, (nColIni + 2015)*nAC, aDados[nX, 26], oFont04)

			oPrint:Box((nLinIni + 0710)*nAL, (nColIni + 2315)*nAC, (nLinIni + 0805)*nAL, (nColIni + 2425)*nAC)
			oPrint:Say((nLinIni + 0735)*nAL, (nColIni + 2325)*nAC, "27 - "+"UF", oFont01) //"UF"
			oPrint:Say((nLinIni + 0775)*nAL, (nColIni + 2335)*nAC, aDados[nX, 27], oFont04)

			oPrint:Box((nLinIni + 0710)*nAL, (nColIni + 2430)*nAC, (nLinIni + 0805)*nAL, (nColIni + 2645)*nAC)
			oPrint:Say((nLinIni + 0735)*nAL, (nColIni + 2440)*nAC, "28 - "+"Código CBO S", oFont01) //"Código CBO S"
			oPrint:Say((nLinIni + 0775)*nAL, (nColIni + 2450)*nAC, aDados[nX, 28], oFont04)

			nLinIni += 110
			oPrint:Say((nLinIni + 0730)*nAL, (nColIni + 0010)*nAC, "Procedimentos Executados", oFont01) //"Procedimentos Executados"
			oPrint:Box((nLinIni + 0740)*nAL, (nColIni + 0010)*nAC, (nLinIni + 1470)*nAL, (nColIni + 3665 + nColA4)*nAC)
			oPrint:Say((nLinIni + 0770)*nAL, (nColIni + 0020)*nAC, "29 - " + "Tabela", oFont01) //"Tabela"
			oPrint:Say((nLinIni + 0770)*nAL, (nColIni + 0130)*nAC, "30 - " + "Código do Procedimento", oFont01) //"Código do Procedimento"
			oPrint:Say((nLinIni + 0770)*nAL, (nColIni + 0422)*nAC, "31 - " + "Descrição", oFont01) //"Descrição"
			oPrint:Say((nLinIni + 0770)*nAL, (nColIni + 1880 + nColA4)*nAC, "32 - " + "Dente/Região", oFont01) //"Dente/Região"
			oPrint:Say((nLinIni + 0770)*nAL, (nColIni + 2080 + nColA4)*nAC, "33 - " + "Face", oFont01) //"Face"
			oPrint:Say((nLinIni + 0770)*nAL, (nColIni + 2220 + nColA4)*nAC, "34 - " + "Qtd", oFont01) //"Qtd"
			oPrint:Say((nLinIni + 0770)*nAL, (nColIni + 2330 + nColA4)*nAC, "35 - " + "Quantidade US", oFont01,,,,1) //"Quantidade US"
			oPrint:Say((nLinIni + 0770)*nAL, (nColIni + 2550 + nColA4)*nAC, "36 - " + "Valor", oFont01) //"Valor"
			oPrint:Say((nLinIni + 0770)*nAL, (nColIni + 2690 + nColA4)*nAC, "37 - " + "Franquia/Co-participação R$", oFont01) //"Franquia/Co-participação R$"
			oPrint:Say((nLinIni + 0770)*nAL, (nColIni + 3080 + nColA4)*nAC, "38 - " + "Aut", oFont01,,,,1)  //"Aut"
			oPrint:Say((nLinIni + 0770)*nAL, (nColIni + 3225 + nColA4)*nAC, "39 - " + "Data Realização", oFont01,,,,1) //"Data Realização"
			oPrint:Say((nLinIni + 0770)*nAL, (nColIni + 3450 + nColA4)*nAC, "40 - " + "Assinatura", oFont01,,,,1) //"Assinatura"

			nOldLinIni := nLinIni

			If nVolta == 1
			  nP := 1
			Endif
			nT := nP+16

			For nI := nP To nT
				If nVolta <> 1
					nN := nI-(17*nVolta-17)
					oPrint:Say((nLinIni + 0810)*nAL, (nColIni + 0020)*nAC, AllTrim(Str(nN)) + " - ", oFont01)
				Else
					oPrint:Say((nLinIni + 0810)*nAL, (nColIni + 0020)*nAC, AllTrim(Str(nI)) + " - ", oFont01)
				Endif
				oPrint:Say((nLinIni + 0810)*nAL, (nColIni + 0060)*nAC, aDados[nX, 29, nI], oFont04)
				oPrint:Say((nLinIni + 0810)*nAL, (nColIni + 0130)*nAC, aDados[nX, 30, nI], oFont04)
				oPrint:Say((nLinIni + 0810)*nAL, (nColIni + 0422)*nAC, aDados[nX, 31, nI], oFont01)
				oPrint:Say((nLinIni + 0810)*nAL, (nColIni + 1880 + nColA4)*nAC, aDados[nX, 32, nI], oFont04)
				oPrint:Say((nLinIni + 0810)*nAL, (nColIni + 2080 + nColA4)*nAC, aDados[nX, 33, nI], oFont04)
				oPrint:Say((nLinIni + 0810)*nAL, (nColIni + 2220 + nColA4)*nAC, IIF(Empty(aDados[nX, 34, nI]), "", Transform(aDados[nX, 34, nI], "@E 9999.99")), oFont04,,,,1)

				If GetNewPar("MV_PLSMUS","2") == "2"
					oPrint:Say((nLinIni + 0810)*nAL, (nColIni + 2330 + nColA4)*nAC, IIf(Empty(aDados[nX, 35, nI]), "", ""), oFont04,,,,1)
				Else
					oPrint:Say((nLinIni + 0810)*nAL, (nColIni + 2330 + nColA4)*nAC, IIf(Empty(aDados[nX, 35, nI]), "", Transform(aDados[nX, 35, nI], "@E 99,999,999.99")), oFont04,,,,1)//dennis
				Endif
				oPrint:Say((nLinIni + 0810)*nAL, (nColIni + 2520 + nColA4)*nAC, IIf(Empty(aDados[nX, 36, nI]), "", Transform(aDados[nX, 36, nI], "@E 99,999,999.99")), oFont04,,,,1)
				oPrint:Say((nLinIni + 0810)*nAL, (nColIni + 2720 + nColA4)*nAC, IIf(Empty(aDados[nX, 37, nI]), "", Transform(aDados[nX, 37, nI], "@E 99,999,999.99")), oFont04,,,,1)
			   	oPrint:Say((nLinIni + 0810)*nAL, (nColIni + 3080 + nColA4)*nAC, aDados[nX, 38, nI], oFont04)
			   	If cImpDatRea == "S"
				oPrint:Say((nLinIni + 0810)*nAL, (nColIni + 3225 + nColA4)*nAC, IIf(Empty(aDados[nX, 39, nI]), "", DtoC(aDados[nX, 39, nI])), oFont04)
				Else
				oPrint:Say((nLinIni + 0810)*nAL, (nColIni + 3225 + nColA4)*nAC, IIf(Empty(aDados[nX, 39, nI]), "", ""                       ), oFont04)
				EndIf
			   	oPrint:Say((nLinIni + 0810)*nAL, (nColIni + 3450 + nColA4)*nAC, aDados[nX, 40, nI], oFont04)

				nLinIni += 40
			Next nI

			nP:=nI

			nP1:=Len(aDados[nX, 29])

		 	if nP1 >nI-1
				lImpnovo:=.T.
			Endif

		 	nLinIni := nOldLinIni - 40

			oPrint:Box((nLinIni + 1525)*nAL, (nColIni + 0010)*nAC, (nLinIni + 1619)*nAL, (nColIni + 0450)*nAC)
			oPrint:Say((nLinIni + 1555)*nAL, (nColIni + 0020)*nAC, "41 - "+"Data Previsão Término do Tratamento", oFont01) //"Data Previsão Término do Tratamento"
			oPrint:Say((nLinIni + 1595)*nAL, (nColIni + 0030)*nAC, DtoC(aDados[nX, 41]), oFont04)
			oPrint:Box((nLinIni + 1525)*nAL, (nColIni + 0455)*nAC, (nLinIni + 1619)*nAL, (nColIni + 1710)*nAC)
			oPrint:Say((nLinIni + 1555)*nAL, (nColIni + 0465)*nAC, "42 - "+"Tipo de Atendimento", oFont01) //"Tipo de Atendimento"
			oPrint:Line((nLinIni+ 1560)*nAL, (nColIni + 0465)*nAC, (nLinIni + 1600)*nAL, (nColIni + 0465)*nAC)
			oPrint:Line((nLinIni+ 1600)*nAL, (nColIni + 0465)*nAC, (nLinIni + 1600)*nAL, (nColIni + 0500)*nAC)
			oPrint:Line((nLinIni+ 1560)*nAL, (nColIni + 0500)*nAC, (nLinIni + 1600)*nAL, (nColIni + 0500)*nAC)
			oPrint:Say((nLinIni + 1595)*nAL, (nColIni + 0477)*nAC, aDados[nX, 42], oFont04)
			oPrint:Say((nLinIni + 1585)*nAL, (nColIni + 0520)*nAC, "1 - "+"Tratamento Odontológico"+"     "+"2 - "+"Exame Radiológico"+"     "+"3 - "+"Ortodontia"+"     "+"4 - "+"Urgência/Emergência ", oFont01) //"Tratamento Odontológico"###"Exame Radiológico"###"Ortodontia"###"Urgência/Emergência "
			oPrint:Box((nLinIni + 1525)*nAL, (nColIni + 1715)*nAC, (nLinIni + 1619)*nAL, (nColIni + 2010)*nAC)
			oPrint:Say((nLinIni + 1555)*nAL, (nColIni + 1725)*nAC, "43 - "+"Tipo de Faturamento", oFont01) //"Tipo de Faturamento"
			oPrint:Line((nLinIni+ 1560)*nAL, (nColIni + 1725)*nAC, (nLinIni + 1600)*nAL, (nColIni + 1725)*nAC)
			oPrint:Line((nLinIni+ 1600)*nAL, (nColIni + 1725)*nAC, (nLinIni + 1600)*nAL, (nColIni + 1760)*nAC)
			oPrint:Line((nLinIni+ 1560)*nAL, (nColIni + 1760)*nAC, (nLinIni + 1600)*nAL, (nColIni + 1760)*nAC)
			oPrint:Say((nLinIni + 1595)*nAL, (nColIni + 1737)*nAC, aDados[nX, 43], oFont04)
			oPrint:Say((nLinIni + 1585)*nAL, (nColIni + 1780)*nAC, "1 - "+"Total"+"     "+"2 - "+"Parcial ", oFont01) //"Total"###"Parcial "
			oPrint:Box((nLinIni + 1525)*nAL, (nColIni + 2015)*nAC, (nLinIni + 1619)*nAL, (nColIni + 2415)*nAC)
			oPrint:Say((nLinIni + 1555)*nAL, (nColIni + 2025)*nAC, "44 - "+"Total Quantidade US", oFont01) //"Total Quantidade US"
			oPrint:Say((nLinIni + 1595)*nAL, (nColIni + 2205)*nAC, Transform(aDados[nX, 44], "@E 999,999,999.99"), oFont04,,,,1)
		    oPrint:Box((nLinIni + 1525)*nAL, (nColIni + 2420)*nAC, (nLinIni + 1619)*nAL, (nColIni + 2720)*nAC)
			oPrint:Say((nLinIni + 1555)*nAL, (nColIni + 2430)*nAC, "45 - "+"Valor Total R$", oFont01) //"Valor Total R$"
			oPrint:Say((nLinIni + 1595)*nAL, (nColIni + 2510)*nAC, Transform(aDados[nX, 45], "@E 999,999,999.99"), oFont04,,,,1)
		    oPrint:Box((nLinIni + 1525)*nAL, (nColIni + 2725)*nAC, (nLinIni + 1619)*nAL, (nColIni + 3165)*nAC)
			oPrint:Say((nLinIni + 1555)*nAL, (nColIni + 2735)*nAC, "46 - "+"Total Franquia / Co-Participação R$", oFont01) //"Total Franquia / Co-Participação R$"
			oPrint:Say((nLinIni + 1585)*nAL, (nColIni + 2935)*nAC, Transform(aDados[nX, 46], "@E 999,999,999.99"), oFont04,,,,1)

		 	nLinIni+=05
		 	cMsg := "Declaro, que após ter sido devidamente esclarecido sobre os propósitos, riscos, custos e alternativas de tratamento, conforme acima apresentados, aceito e autorizo a execução do tratamento, comprometendo-me a cumprir as orientações do profissional assistente"//"Declaro, que após ter sido devidamente esclarecido sobre os propósitos, riscos, custos e alternativas de tratamento, conforme acima apresentados, aceito e autorizo a execução do tratamento, comprometendo-me a cumprir as orientações do profissional assistente"
		 	oPrint:Say((nLinIni + 1635)*nAL, (nColIni + 0010)*nAC, cMsg, oFont04)

		 	cMsg := "e arcar com os custos previstos em contrato. Declaro, ainda, que o(s) procedimento(s) descrito(s) acima, e por mim assinado(s), foi/foram realizado(s) com meu consentimento e de forma satisfatória. Autorizo a Operadora a pagar em meu nome e por minha conta, "//"e arcar com os custos previstos em contrato. Declaro, ainda, que o(s) procedimento(s) descrito(s) acima, e por mim assinado(s), foi/foram realizado(s) com meu consentimento e de forma satisfatória. Autorizo a Operadora a pagar em meu nome e por minha conta, "
		 	oPrint:Say((nLinIni + 1670)*nAL, (nColIni + 0010)*nAC, cMsg, oFont04)

		 	cMsg := "ao profissional contratado que assina esse documento, os valores referentes ao tratamento realizado, "//"ao profissional contratado que assina esse documento, os valores referentes ao tratamento realizado, "
		 	oPrint:Say((nLinIni + 1700)*nAL, (nColIni + 0010)*nAC, cMsg, oFont04)

		    nLinIni += 50
		    oPrint:Box((nLinIni + 1755)*nAL, (nColIni + 0010)*nAC, (nLinIni + 1855)*nAL, (nColIni + 3665 + nColA4)*nAC)
			oPrint:Say((nLinIni + 1765)*nAC, (nColIni + 0020)*nAC, "47 - "+"Observação", oFont01) //"Observação"

			nLin := 1825

			For nI := 1 To MlCount(aDados[nX, 47], 220)
				cObs := MemoLine(aDados[nX, 47], 220, nI)
				oPrint:Say((nLinIni + nLin)*nAL, (nColIni + 0030)*nAC, cObs, oFont04)
				nLin += 35
			Next nI

		    oPrint:Box((nLinIni + 1860)*nAL, (nColIni + 0010)*nAC, (nLinIni + 2044)*nAL, (nColIni + 0825)*nAC)
			oPrint:Say((nLinIni + 1885)*nAL, (nColIni + 0025)*nAC, "48 - " + "Data, local e Assinatura do Cirurgião Dentista Solicitante", oFont01) //"Data, local e Assinatura do Cirurgião Dentista Solicitante"
			oPrint:Say((nLinIni + 1925)*nAL, (nColIni + 0035)*nAC, DtoC(aDados[nX, 48]), oFont04)
			oPrint:Say((nLinIni + 1925)*nAL, (nColIni + 0175)*nAC, (aDados[nX, 49]), oFont01)

		 	oPrint:Box((nLinIni + 1860)*nAL, (nColIni + 0830)*nAC, (nLinIni + 2044)*nAL, (nColIni + 1600)*nAC)
			oPrint:Say((nLinIni + 1885)*nAL, (nColIni + 0840)*nAC, "49 - "+"Data, Local e Assinatura do Cirurgião Dentista", oFont01) //"Data, Local e Assinatura do Cirurgião Dentista"
			oPrint:Say((nLinIni + 1925)*nAL, (nColIni + 0850)*nAC, DtoC(aDados[nX, 50]), oFont04)
			oPrint:Say((nLinIni + 1925)*nAL, (nColIni + 0990)*nAC, (aDados[nX, 51]), oFont01)

			oPrint:Box((nLinIni + 1860)*nAL, (nColIni + 1605)*nAC, (nLinIni + 2044)*nAL, (nColIni + 2375)*nAC)
			oPrint:Say((nLinIni + 1885)*nAL, (nColIni + 1615)*nAC, "50 - "+"Data, Local e Assinatura do Associado / Responsável", oFont01) //"Data, Local e Assinatura do Associado / Responsável"
			oPrint:Say((nLinIni + 1925)*nAL, (nColIni + 1625)*nAC, DtoC(aDados[nX, 52]), oFont04)
			oPrint:Say((nLinIni + 1925)*nAL, (nColIni + 1765)*nAC, (aDados[nX, 53]), oFont01)

			oPrint:Box((nLinIni + 1860)*nAL, (nColIni + 2380)*nAC, (nLinIni + 2044)*nAL, (nColIni + 3165)*nAC)
			oPrint:Say((nLinIni + 1885)*nAL, (nColIni + 2390)*nAC, "51 - "+"Data, Local e Carimbo da Empresa", oFont01) //"Data, Local e Carimbo da Empresa"
			oPrint:Say((nLinIni + 1925)*nAL, (nColIni + 2400)*nAC, DtoC(aDados[nX, 54]), oFont04)
			oPrint:Say((nLinIni + 1925)*nAL, (nColIni + 2540)*nAC, (aDados[nX, 55]), oFont01)

			oPrint:EndPage()	// Finaliza a pagina

		Next nX
	Enddo
Else
	 While lImpnovo
	 	lImpnovo:=.F.
	 	nVolta 	+= 1
	 	nAte	+= nP
		For nX := 1 To Len(aDados)

			If ValType(aDados[nX]) == 'U' .OR. Len(aDados[nX]) == 0
				Loop
			EndIf

	   		If oPrint:Cprinter == "PDF" .OR. lWeb
				nLinIni := 130
				nColMax -= 15
			Else
				nLinIni := 080
			Endif
			nColIni := 080
			nColA4  := 000

			oPrint:StartPage()		// Inicia uma nova pagina
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Box Principal                                                 ?
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			oPrint:Box((nLinIni + 0000)*nAL, (nColIni + 0000)*nAC, (nLinIni + nLinMax)*nAL, (nColIni + nColMax)*nAC)

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Carrega e Imprime Logotipo da Empresa                         ?
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

			For nI := 30 To 42
				If Len(aDados[nX, nI]) < nAte
					For nJ := Len(aDados[nX, nI]) + 1 To nAte
						If AllTrim(Str(nI)) $ "35,36,37,38"
							aAdd(aDados[nX, nI], 0)
						ElseiF AllTrim(Str(nI)) $ "41"
							aAdd(aDados[nX, nI], StoD(""))
						Else
							aAdd(aDados[nX, nI],"")
						EndIf
					Next nJ
				EndIf
			Next nI

			oPrint:Say((nLinIni + 0090)*nAL, (nColIni + 1482 + IIF(nLayout ==2 .Or. nLayout ==3,nColA4+160,0))*nAC, "GUIA TRATAMENTO ODONTOLÓGICO", oFont02n,,,, 2) //"GUIA TRATAMENTO ODONTOLÓGICO"
			oPrint:Say((nLinIni + 0090)*nAL, (nColIni + 2900 + nColA4)*nAC, "2-"+OemToAnsi("Nº da guia no prestador"), oFont01) //"N?da guia no prestador"
			oPrint:Say((nLinIni + 0090)*nAL, (nColIni + 3096 + nColA4)*nAC, aDados[nX, 02], oFont03n)

			nLinIni+= 20
			oPrint:Box((nLinIni + 0155)*nAL, (nColIni + 0010)*nAC, (nLinIni + 0249)*nAL, (nColIni + 0315)*nAC)
			oPrint:Say((nLinIni + 0180)*nAL, (nColIni + 0020)*nAC, "1 - "+"Registro ANS", oFont01) //"Registro ANS"
			oPrint:Say((nLinIni + 0220)*nAL, (nColIni + 0030)*nAC, aDados[nX, 01], oFont04)

			oPrint:Box((nLinIni + 0155)*nAL, (nColIni + 0320)*nAC, (nLinIni + 0249)*nAL, (nColIni + 0700)*nAC)
			oPrint:Say((nLinIni + 0180)*nAL, (nColIni + 0330)*nAC, "3 - "+"Número da guia principal", oFont01) //"Número da Guia Principal"
			oPrint:Say((nLinIni + 0220)*nAL, (nColIni + 0340)*nAC, aDados[nX, 03], oFont04)

			oPrint:Box((nLinIni + 0155)*nAL, (nColIni + 0705)*nAC, (nLinIni + 0249)*nAL, (nColIni + 1035)*nAC)
			oPrint:Say((nLinIni + 0180)*nAL, (nColIni + 0715)*nAC, "4 - "+"Data da Autorização", oFont01) //"Data da Autorização"
			oPrint:Say((nLinIni + 0220)*nAL, (nColIni + 0725)*nAC, DtoC(aDados[nX, 04]), oFont04)

			oPrint:Box((nLinIni + 0155)*nAL, (nColIni + 1040)*nAC, (nLinIni + 0249)*nAL, (nColIni + 1395)*nAC)
			oPrint:Say((nLinIni + 0180)*nAL, (nColIni + 1050)*nAC, "5 - "+"Senha", oFont01) //"Senha"
			oPrint:Say((nLinIni + 0220)*nAL, (nColIni + 1060)*nAC, aDados[nX, 05], oFont04)

			oPrint:Box((nLinIni + 0155)*nAL, (nColIni + 1400)*nAC, (nLinIni + 0249)*nAL, (nColIni + 1765)*nAC)
			oPrint:Say((nLinIni + 0180)*nAL, (nColIni + 1410)*nAC, "6 - "+"Data Validade da Senha", oFont01) //"Data Validade da Senha"
			oPrint:Say((nLinIni + 0220)*nAL, (nColIni + 1420)*nAC, DtoC(aDados[nX, 06]), oFont04)

			oPrint:Box((nLinIni + 0155)*nAL, (nColIni + 1770)*nAC, (nLinIni + 0249)*nAL, (nColIni + 2375)*nAC)
			oPrint:Say((nLinIni + 0180)*nAL, (nColIni + 1780)*nAC, "7 - "+"Número da Guia Atribuído pela Operadora", oFont01) //"Número da Guia Atribuído pela Operadora"
			oPrint:Say((nLinIni + 0220)*nAL, (nColIni + 1790)*nAC, aDados[nX, 07], oFont04)

		    nLinIni += 10
			oPrint:Say((nLinIni + 0274)*nAL, (nColIni + 0010)*nAC, "Dados do Beneficiário", oFont01) //"Dados do Beneficiário"
			oPrint:Box((nLinIni + 0284)*nAL, (nColIni + 0010)*nAC, (nLinIni + 0378)*nAL, (nColIni + 0415)*nAC)
			oPrint:Say((nLinIni + 0309)*nAL, (nColIni + 0020)*nAC, "8 - "+"Número da Carteira", oFont01) //"Número da Carteira"
			oPrint:Say((nLinIni + 0349)*nAL, (nColIni + 0030)*nAC, aDados[nX, 08], oFont04)

			oPrint:Box((nLinIni + 0284)*nAL, (nColIni + 0420)*nAC, (nLinIni + 0378)*nAL, (nColIni + 1770 + nColA4)*nAC)
			oPrint:Say((nLinIni + 0309)*nAL, (nColIni + 0430)*nAC, "9 - "+"Plano", oFont01) //"Plano"
			oPrint:Say((nLinIni + 0349)*nAL, (nColIni + 0440)*nAC, aDados[nX, 09], oFont04)

			oPrint:Box((nLinIni + 0284)*nAL, (nColIni + 1775 + nColA4)*nAC, (nLinIni + 0378)*nAL, (nColIni + 2835 + nColA4)*nAC)
			oPrint:Say((nLinIni + 0309)*nAL, (nColIni + 1785 + nColA4)*nAC, "10 - "+"Empresa", oFont01) //"Empresa"
			oPrint:Say((nLinIni + 0349)*nAL, (nColIni + 1795 + nColA4)*nAC, aDados[nX, 10], oFont04)

			oPrint:Box((nLinIni + 0284)*nAL, (nColIni + 2840 + nColA4)*nAC, (nLinIni + 0378)*nAL, (nColIni + 3145 + nColA4)*nAC)
			oPrint:Say((nLinIni + 0309)*nAL, (nColIni + 2850 + nColA4)*nAC, "11 - "+"Data Validade da Carteira", oFont01) //"Data Validade da Carteira"
			oPrint:Say((nLinIni + 0349)*nAL, (nColIni + 2860 + nColA4)*nAC, DtoC(aDados[nX, 11]), oFont04)

			oPrint:Box((nLinIni + 0284)*nAL, (nColIni + 3150 + nColA4)*nAC, (nLinIni + 0378)*nAL, (nColIni + 3590 + nColA4)*nAC)
			oPrint:Say((nLinIni + 0309)*nAL, (nColIni + 3160 + nColA4)*nAC, "12 - "+"Número do Cartão Nacional de Saúde", oFont01) //"Número do Cartão Nacional de Saúde"
			oPrint:Say((nLinIni + 0349)*nAL, (nColIni + 3170 + nColA4)*nAC, aDados[nX, 12], oFont04)

			oPrint:Box((nLinIni + 0383)*nAL, (nColIni + 0010)*nAC, (nLinIni + 0477)*nAL, (nColIni + 1800 + nColA4)*nAC)
			oPrint:Say((nLinIni + 0407)*nAL, (nColIni + 0020)*nAC, "13 - "+"Nome", oFont01) //"Nome"
			oPrint:Say((nLinIni + 0447)*nAL, (nColIni + 0030)*nAC, aDados[nX, 13], oFont04)

			oPrint:Box((nLinIni + 0383)*nAL, (nColIni + 1805 + nColA4)*nAC, (nLinIni + 0477)*nAL, (nColIni + 2135 + nColA4)*nAC)
			oPrint:Say((nLinIni + 0407)*nAL, (nColIni + 1815 + nColA4)*nAC, "14 - "+"Telefone", oFont01) //"Telefone"
			oPrint:Say((nLinIni + 0447)*nAL, (nColIni + 1825 + nColA4)*nAC, aDados[nX, 14], oFont04)

			oPrint:Box((nLinIni + 0383)*nAL, (nColIni + 2140 + nColA4)*nAC, (nLinIni + 0477)*nAL, (nColIni + 3185 + nColA4)*nAC)
			oPrint:Say((nLinIni + 0407)*nAL, (nColIni + 2150 + nColA4)*nAC, "15 - "+"Nome do Titular do Plano", oFont01) //"Nome do Titular do Plano"
			oPrint:Say((nLinIni + 0447)*nAL, (nColIni + 2160 + nColA4)*nAC, aDados[nX, 15], oFont04)

			oPrint:Box((nLinIni + 0383)*nAL, (nColIni + 3195 + nColA4)*nAC, (nLinIni + 0477)*nAL, (nColIni + 3590 + nColA4)*nAC)
			oPrint:Say((nLinIni + 0407)*nAL, (nColIni + 3205 + nColA4)*nAC, "16 - "+"Atendimento a RN", oFont01) //"Atendimento a RN"
			oPrint:Say((nLinIni + 0447)*nAL, (nColIni + 3215 + nColA4)*nAC, aDados[nX, 16], oFont04)

			nLinIni += 10
			oPrint:Say((nLinIni + 0502)*nAL, (nColIni + 0010)*nAC, "Dados do Contratado Responsável pelo Tratamento", oFont01) 		 //"Dados do Contratado Responsável pelo Tratamento"
			oPrint:Box((nLinIni + 0512)*nAL, (nColIni + 0010)*nAC, (nLinIni + 0607)*nAL, (nColIni + 2410)*nAC)
			oPrint:Say((nLinIni + 0537)*nAL, (nColIni + 0020)*nAC, "17 - " + "Nome do Profissional Solicitante", oFont01) //"Nome do Profissional Solicitante"
			oPrint:Say((nLinIni + 0577)*nAL, (nColIni + 0030)*nAC, aDados[nX, 17], oFont04)

			oPrint:Box((nLinIni + 0512)*nAL, (nColIni + 2415)*nAC, (nLinIni + 0607)*nAL, (nColIni + 2745)*nAC)
			oPrint:Say((nLinIni + 0537)*nAL, (nColIni + 2425)*nAC, "18 - " + "Número no CRO", oFont01) //"Número no CRO"
			oPrint:Say((nLinIni + 0577)*nAL, (nColIni + 2435)*nAC, aDados[nX, 18], oFont04)

			oPrint:Box((nLinIni + 0512)*nAL, (nColIni + 2750)*nAC, (nLinIni + 0607)*nAL, (nColIni + 2850)*nAC)
			oPrint:Say((nLinIni + 0537)*nAL, (nColIni + 2760)*nAC, "19 - " + "UF", oFont01) //"UF"
			oPrint:Say((nLinIni + 0577)*nAL, (nColIni + 2770)*nAC, aDados[nX, 19], oFont04)

			oPrint:Box((nLinIni + 0512)*nAL, (nColIni + 2855)*nAC, (nLinIni + 0607)*nAL, (nColIni + 3065)*nAC)
			oPrint:Say((nLinIni + 0537)*nAL, (nColIni + 2865)*nAC, "20 - " + "Código CBO S", oFont01) //"Código CBO S"
			oPrint:Say((nLinIni + 0577)*nAL, (nColIni + 2875)*nAC, aDados[nX, 20], oFont04)

			oPrint:Box((nLinIni + 0611)*nAL, (nColIni + 0010)*nAC, (nLinIni + 0706)*nAL, (nColIni + 0426)*nAC)
			oPrint:Say((nLinIni + 0636)*nAL, (nColIni + 0020)*nAC, "21 - "+"Código na Operadora / CNPJ / CPF", oFont01) //"Código na Operadora / CNPJ / CPF"
			oPrint:Say((nLinIni + 0676)*nAL, (nColIni + 0030)*nAC, aDados[nX, 21], oFont04)

			oPrint:Box((nLinIni + 0611)*nAL, (nColIni + 0431)*nAC, (nLinIni + 0706)*nAL, (nColIni + 2410)*nAC)
			oPrint:Say((nLinIni + 0636)*nAL, (nColIni + 0441)*nAC, "22 - "+"Nome do Contratado Executante", oFont01) //"Nome do Contratado Executante"
			oPrint:Say((nLinIni + 0676)*nAL, (nColIni + 0451)*nAC, SubStr(aDados[nX, 22], 1, 65), oFont04)

			oPrint:Box((nLinIni + 0611)*nAL, (nColIni + 2415)*nAC, (nLinIni + 0706)*nAL, (nColIni + 2745)*nAC)
			oPrint:Say((nLinIni + 0636)*nAL, (nColIni + 2425)*nAC, "23 - "+"Número no CRO", oFont01) //"Número no CRO"
			oPrint:Say((nLinIni + 0676)*nAL, (nColIni + 2435)*nAC, aDados[nX, 23], oFont04)

			oPrint:Box((nLinIni + 0611)*nAL, (nColIni + 2750)*nAC, (nLinIni + 0706)*nAL, (nColIni + 2850)*nAC)
			oPrint:Say((nLinIni + 0636)*nAL, (nColIni + 2760)*nAC, "24 - "+"UF", oFont01) //"UF"
			oPrint:Say((nLinIni + 0676)*nAL, (nColIni + 2770)*nAC, aDados[nX, 24], oFont04)

			oPrint:Box((nLinIni + 0611)*nAL, (nColIni + 2855)*nAC, (nLinIni + 0706)*nAL, (nColIni + 3065)*nAC)
			oPrint:Say((nLinIni + 0636)*nAL, (nColIni + 2865)*nAC, "25 - "+"Código CNES", oFont01) //"Código CNES"
			oPrint:Say((nLinIni + 0676)*nAL, (nColIni + 2875)*nAC, aDados[nX, 25], oFont04)

			oPrint:Box((nLinIni + 0710)*nAL, (nColIni + 0010)*nAC, (nLinIni + 0805)*nAL, (nColIni + 2410)*nAC)
			oPrint:Say((nLinIni + 0735)*nAL, (nColIni + 0020)*nAC, "26 - "+"Nome do Profissional Executante", oFont01) //"Nome do Profissional Executante"
			oPrint:Say((nLinIni + 0775)*nAL, (nColIni + 0030)*nAC, aDados[nX, 26], oFont04)

			oPrint:Box((nLinIni + 0710)*nAL, (nColIni + 2415)*nAC, (nLinIni + 0805)*nAL, (nColIni + 2745)*nAC)
			oPrint:Say((nLinIni + 0735)*nAL, (nColIni + 2425)*nAC, "27 - "+"Número no CRO", oFont01) //"Número no CRO"
			oPrint:Say((nLinIni + 0775)*nAL, (nColIni + 2435)*nAC, aDados[nX, 27], oFont04)

			oPrint:Box((nLinIni + 0710)*nAL, (nColIni + 2750)*nAC, (nLinIni + 0805)*nAL, (nColIni + 2850)*nAC)
			oPrint:Say((nLinIni + 0735)*nAL, (nColIni + 2760)*nAC, "28 - "+"UF", oFont01) //"UF"
			oPrint:Say((nLinIni + 0775)*nAL, (nColIni + 2770)*nAC, aDados[nX, 28], oFont04)

			oPrint:Box((nLinIni + 0710)*nAL, (nColIni + 2855)*nAC, (nLinIni + 0805)*nAL, (nColIni + 3065)*nAC)
			oPrint:Say((nLinIni + 0735)*nAL, (nColIni + 2865)*nAC, "29 - "+"Código CBO S", oFont01) //"Código CBO S"
			oPrint:Say((nLinIni + 0775)*nAL, (nColIni + 2875)*nAC, aDados[nX, 29], oFont04)

			nLinIni += 110
			oPrint:Say((nLinIni + 0730)*nAL, (nColIni + 0010)*nAC, "Procedimentos Executados", oFont01) //"Procedimentos Executados"
			oPrint:Box((nLinIni + 0740)*nAL, (nColIni + 0010)*nAC, (nLinIni + 1580)*nAL, (nColIni + 3665 + nColA4)*nAC)
			oPrint:Say((nLinIni + 0770)*nAL, (nColIni + 0020)*nAC, "30 - " + "Tabela", oFont01) //"Tabela"
			oPrint:Say((nLinIni + 0770)*nAL, (nColIni + 0130)*nAC, "31 - " + "Código do Procedimento", oFont01) //"Código do Procedimento"
			oPrint:Say((nLinIni + 0770)*nAL, (nColIni + 0422)*nAC, "32 - " + "Descrição", oFont01) //"Descrição"
			oPrint:Say((nLinIni + 0770)*nAL, (nColIni + 1680 + nColA4)*nAC, "33 - " + "Dente/Região", oFont01) //"Dente/Região"
			oPrint:Say((nLinIni + 0770)*nAL, (nColIni + 1830 + nColA4)*nAC, "34 - " + "Face", oFont01) //"Face"
			oPrint:Say((nLinIni + 0770)*nAL, (nColIni + 2020 + nColA4)*nAC, "35 - " + "Qtd", oFont01) //"Qtd"
			oPrint:Say((nLinIni + 0770)*nAL, (nColIni + 2130 + nColA4)*nAC, "36 - " + "Quantidade US", oFont01,,,,1) //"Quantidade US"
			oPrint:Say((nLinIni + 0770)*nAL, (nColIni + 2350 + nColA4)*nAC, "37 - " + "Valor", oFont01) //"Valor"
			oPrint:Say((nLinIni + 0770)*nAL, (nColIni + 2590 + nColA4)*nAC, "38 - " + "Franquia/Co-participação R$", oFont01) //"Franquia/Co-participação R$"
			oPrint:Say((nLinIni + 0770)*nAL, (nColIni + 2880 + nColA4)*nAC, "39 - " + "Aut", oFont01,,,,1)  //"Aut"
			oPrint:Say((nLinIni + 0770)*nAL, (nColIni + 3025 + nColA4)*nAC, "40 - " + "Cód. Negativa", oFont01,,,,1) //"Cód. Negativa"
			oPrint:Say((nLinIni + 0770)*nAL, (nColIni + 3175 + nColA4)*nAC, "41 - " + "Data Realização", oFont01,,,,1) //"Data Realização"
			oPrint:Say((nLinIni + 0770)*nAL, (nColIni + 3330 + nColA4)*nAC, "42 - " + "Assinatura", oFont01,,,,1) //"Assinatura"

			nOldLinIni := nLinIni

			If nVolta == 1
			  nP := 1
			Endif
			nT := nP+19

			For nI := nP To nT
				If nVolta <> 1
					nN := nI-(20*nVolta-20)
					oPrint:Say((nLinIni + 0810)*nAL, (nColIni + 0020)*nAC, AllTrim(Str(nN)) + " - ", oFont01)
				Else
					oPrint:Say((nLinIni + 0810)*nAL, (nColIni + 0020)*nAC, AllTrim(Str(nI)) + " - ", oFont01)
				Endif

				oPrint:Say((nLinIni + 0810)*nAL, (nColIni + 0060)*nAC, aDados[nX, 30, nI], oFont04)
				oPrint:Say((nLinIni + 0810)*nAL, (nColIni + 0130)*nAC, aDados[nX, 31, nI], oFont04)
				oPrint:Say((nLinIni + 0810)*nAL, (nColIni + 0422)*nAC, aDados[nX, 32, nI], oFont01)
				oPrint:Say((nLinIni + 0810)*nAL, (nColIni + 1680 + nColA4)*nAC, aDados[nX, 33, nI], oFont04)
				oPrint:Say((nLinIni + 0810)*nAL, (nColIni + 1830 + nColA4)*nAC, aDados[nX, 34, nI], oFont04)
				oPrint:Say((nLinIni + 0810)*nAL, (nColIni + 2010 + nColA4)*nAC, IIF(Empty(aDados[nX, 35, nI]), "", Transform(aDados[nX, 35, nI], "@E 9999.99")), oFont04,,,,1)

				If GetNewPar("MV_PLSMUS","2") == "2"
					oPrint:Say((nLinIni + 0810)*nAL, (nColIni + 2120 + nColA4)*nAC, IIf(Empty(aDados[nX, 36, nI]), "", ""), oFont04,,,,1)
				Else
					oPrint:Say((nLinIni + 0810)*nAL, (nColIni + 2120 + nColA4)*nAC, IIf(Empty(aDados[nX, 36, nI]), "", Transform(aDados[nX, 36, nI], "@E 99,999,999.99")), oFont04,,,,1)//dennis
				Endif
				oPrint:Say((nLinIni + 0810)*nAL, (nColIni + 2350 + nColA4)*nAC, IIf(Empty(aDados[nX, 37, nI]), "", Transform(aDados[nX, 37, nI], "@E 99,999,999.99")), oFont04,,,,1)
				oPrint:Say((nLinIni + 0810)*nAL, (nColIni + 2590 + nColA4)*nAC, IIf(Empty(aDados[nX, 38, nI]), "", Transform(aDados[nX, 38, nI], "@E 99,999,999.99")), oFont04,,,,1)
				oPrint:Say((nLinIni + 0810)*nAL, (nColIni + 2880 + nColA4)*nAC, aDados[nX, 39, nI], oFont04)
				oPrint:Say((nLinIni + 0810)*nAL, (nColIni + 3025 + nColA4)*nAC, aDados[nX, 40, nI], oFont04)
			   	If cImpDatRea == "S"
			   	oPrint:Say((nLinIni + 0810)*nAL, (nColIni + 3175 + nColA4)*nAC, IIf(Empty(aDados[nX, 41, nI]), "", DtoC(aDados[nX, 41, nI])), oFont04)
			   	Else
				oPrint:Say((nLinIni + 0810)*nAL, (nColIni + 3175 + nColA4)*nAC, IIf(Empty(aDados[nX, 41, nI]), "", ""                       ), oFont04)
			   	EndIf
			   	oPrint:Say((nLinIni + 0810)*nAL, (nColIni + 3330 + nColA4)*nAC, aDados[nX, 42, nI], oFont04)

				nLinIni += 40
			Next nI

			nP:=nI

			nP1:=Len(aDados[nX, 29])

		 	if nP1 >nI-1
				lImpnovo:=.T.
			Endif

		 	nLinIni := nOldLinIni - 30

			oPrint:Box((nLinIni + 1625)*nAL, (nColIni + 0010)*nAC, (nLinIni + 1719)*nAL, (nColIni + 0450)*nAC)
			oPrint:Say((nLinIni + 1655)*nAL, (nColIni + 0020)*nAC, "43 - "+"Data Previsão Término do Tratamento", oFont01) //"Data Previsão Término do Tratamento"
			oPrint:Say((nLinIni + 1695)*nAL, (nColIni + 0030)*nAC, DtoC(aDados[nX, 43]), oFont04)
			oPrint:Box((nLinIni + 1625)*nAL, (nColIni + 0455)*nAC, (nLinIni + 1719)*nAL, (nColIni + 1710)*nAC)
			oPrint:Say((nLinIni + 1655)*nAL, (nColIni + 0465)*nAC, "44 - "+"Tipo de Atendimento", oFont01) //"Tipo de Atendimento"
			oPrint:Line((nLinIni+ 1660)*nAL, (nColIni + 0465)*nAC, (nLinIni + 1700)*nAL, (nColIni + 0465)*nAC)
			oPrint:Line((nLinIni+ 1700)*nAL, (nColIni + 0465)*nAC, (nLinIni + 1700)*nAL, (nColIni + 0500)*nAC)
			oPrint:Line((nLinIni+ 1660)*nAL, (nColIni + 0500)*nAC, (nLinIni + 1700)*nAL, (nColIni + 0500)*nAC)
			oPrint:Say((nLinIni + 1695)*nAL, (nColIni + 0477)*nAC, aDados[nX, 44], oFont04)
			oPrint:Say((nLinIni + 1685)*nAL, (nColIni + 0520)*nAC, "1 - "+"Tratamento Odontológico"+"     "+"2 - "+"Exame Radiológico"+"     "+"3 - "+"Ortodontia"+"     "+"4 - "+"Urgência/Emergência ", oFont01) //"Tratamento Odontológico"###"Exame Radiológico"###"Ortodontia"###"Urgência/Emergência "
			oPrint:Box((nLinIni + 1625)*nAL, (nColIni + 1715)*nAC, (nLinIni + 1719)*nAL, (nColIni + 2010)*nAC)
			oPrint:Say((nLinIni + 1655)*nAL, (nColIni + 1725)*nAC, "45 - "+"Tipo de Faturamento", oFont01) //"Tipo de Faturamento"
			oPrint:Line((nLinIni+ 1660)*nAL, (nColIni + 1725)*nAC, (nLinIni + 1700)*nAL, (nColIni + 1725)*nAC)
			oPrint:Line((nLinIni+ 1700)*nAL, (nColIni + 1725)*nAC, (nLinIni + 1700)*nAL, (nColIni + 1760)*nAC)
			oPrint:Line((nLinIni+ 1660)*nAL, (nColIni + 1760)*nAC, (nLinIni + 1700)*nAL, (nColIni + 1760)*nAC)
			oPrint:Say((nLinIni + 1695)*nAL, (nColIni + 1737)*nAC, aDados[nX, 45], oFont04)
			oPrint:Say((nLinIni + 1685)*nAL, (nColIni + 1780)*nAC, "1 - "+"Total"+"     "+"2 - "+"Parcial ", oFont01) //"Total"###"Parcial "
			oPrint:Box((nLinIni + 1625)*nAL, (nColIni + 2015)*nAC, (nLinIni + 1719)*nAL, (nColIni + 2415)*nAC)
			oPrint:Say((nLinIni + 1655)*nAL, (nColIni + 2025)*nAC, "46 - "+"Total Quantidade US", oFont01) //"Total Quantidade US"
			oPrint:Say((nLinIni + 1695)*nAL, (nColIni + 2205)*nAC, Transform(aDados[nX, 46], "@E 999,999,999.99"), oFont04,,,,1)
			oPrint:Box((nLinIni + 1625)*nAL, (nColIni + 2420)*nAC, (nLinIni + 1719)*nAL, (nColIni + 2720)*nAC)
			oPrint:Say((nLinIni + 1655)*nAL, (nColIni + 2430)*nAC, "47 - "+"Valor Total R$", oFont01) //"Valor Total R$"
			oPrint:Say((nLinIni + 1695)*nAL, (nColIni + 2510)*nAC, Transform(aDados[nX, 47], "@E 999,999,999.99"), oFont04,,,,1)
			oPrint:Box((nLinIni + 1625)*nAL, (nColIni + 2725)*nAC, (nLinIni + 1719)*nAL, (nColIni + 3165)*nAC)
			oPrint:Say((nLinIni + 1655)*nAL, (nColIni + 2735)*nAC, "48 - "+"Total Franquia / Co-Participação R$", oFont01) //"Total Franquia / Co-Participação R$"
			oPrint:Say((nLinIni + 1685)*nAL, (nColIni + 2935)*nAC, Transform(aDados[nX, 48], "@E 999,999,999.99"), oFont04,,,,1)

		 	nLinIni+=05
		 	cMsg := "Declaro, que após ter sido devidamente esclarecido sobre os propósitos, riscos, custos e alternativas de tratamento, conforme acima apresentados, aceito e autorizo a execução do tratamento, comprometendo-me a cumprir as orientações do profissional assistente"//"Declaro, que após ter sido devidamente esclarecido sobre os propósitos, riscos, custos e alternativas de tratamento, conforme acima apresentados, aceito e autorizo a execução do tratamento, comprometendo-me a cumprir as orientações do profissional assistente"
		 	oPrint:Say((nLinIni + 1735)*nAL, (nColIni + 0010)*nAC, cMsg, oFont04)

		 	cMsg := "e arcar com os custos previstos em contrato. Declaro, ainda, que o(s) procedimento(s) descrito(s) acima, e por mim assinado(s), foi/foram realizado(s) com meu consentimento e de forma satisfatória. Autorizo a Operadora a pagar em meu nome e por minha conta, "//"e arcar com os custos previstos em contrato. Declaro, ainda, que o(s) procedimento(s) descrito(s) acima, e por mim assinado(s), foi/foram realizado(s) com meu consentimento e de forma satisfatória. Autorizo a Operadora a pagar em meu nome e por minha conta, "
		 	oPrint:Say((nLinIni + 1770)*nAL, (nColIni + 0010)*nAC, cMsg, oFont04)

		 	cMsg := "ao profissional contratado que assina esse documento, os valores referentes ao tratamento realizado, "//"ao profissional contratado que assina esse documento, os valores referentes ao tratamento realizado, "
		 	oPrint:Say((nLinIni + 1800)*nAL, (nColIni + 0010)*nAC, cMsg, oFont04)

		    nLinIni += 50
		    oPrint:Box((nLinIni + 1755)*nAL, (nColIni + 0010)*nAC, (nLinIni + 1895)*nAL, (nColIni + 3665 + nColA4)*nAC)
			oPrint:Say((nLinIni + 1865)*nAC, (nColIni + 0020)*nAC, "49 - "+"Observação", oFont01) //"Observação/Justificativa"

			nLin := 1825

			For nI := 1 To MlCount(aDados[nX, 49], 220)
				cObs := MemoLine(aDados[nX, 49], 220, nI)
				oPrint:Say((nLinIni + nLin)*nAL, (nColIni + 0020)*nAC, cObs, oFont04)
				nLin += 35
			Next nI

			nLinIni+=65

			oPrint:Box((nLinIni + 1840)*nAL, (nColIni + 0010)*nAC, (nLinIni + 1935)*nAL, (nColIni + 0825)*nAC)
			oPrint:Say((nLinIni + 1865)*nAL, (nColIni + 0025)*nAC, "50 - "+"Data, local e Assinatura do Cirurgião Dentista Solicitante", oFont01) //"Data, local e Assinatura do Cirurgião Dentista Solicitante"
			oPrint:Say((nLinIni + 1905)*nAL, (nColIni + 0035)*nAC, DtoC(aDados[nX, 50]), oFont04)

		 	oPrint:Box((nLinIni + 1840)*nAL, (nColIni + 0830)*nAC, (nLinIni + 1935)*nAL, (nColIni + 1600)*nAC)
			oPrint:Say((nLinIni + 1865)*nAL, (nColIni + 0845)*nAC, "51 - "+"Assinatura do Cirurgião Dentista", oFont01) //"Assinatura do Cirurgião Dentista"
			oPrint:Say((nLinIni + 1905)*nAL, (nColIni + 0855)*nAC, (aDados[nX, 51]), oFont04)

			oPrint:Box((nLinIni + 1840)*nAL, (nColIni + 1605)*nAC, (nLinIni + 1935)*nAL, (nColIni + 2375)*nAC)
			oPrint:Say((nLinIni + 1865)*nAL, (nColIni + 1620)*nAC, "52 - "+"Data Assinatura do Associado / Responsável", oFont01) //"Data Assinatura do Associado / Responsável"
			oPrint:Say((nLinIni + 1905)*nAL, (nColIni + 1630)*nAC, DtoC(aDados[nX, 52]), oFont04)

			oPrint:Box((nLinIni + 1840)*nAL, (nColIni + 2380)*nAC, (nLinIni + 1935)*nAL, (nColIni + 3165)*nAC)
			oPrint:Say((nLinIni + 1865)*nAL, (nColIni + 2385)*nAC, "53 - "+"Assinatura do Associado / Responsável", oFont01) //"Assinatura do Associado / Responsável"
			oPrint:Say((nLinIni + 1905)*nAL, (nColIni + 2395)*nAC, aDados[nX, 53], oFont04)

			nLinIni+=10
			oPrint:Box((nLinIni + 1940)*nAL, (nColIni + 0010)*nAC, (nLinIni + 2035)*nAL, (nColIni + 0825)*nAC)
			oPrint:Say((nLinIni + 1965)*nAL, (nColIni + 0025)*nAC, "54 - "+"Data, local e Assinatura do Cirurgião Dentista Solicitante", oFont01) //"Data, local e Assinatura do Cirurgião Dentista Solicitante"
			oPrint:Say((nLinIni + 2005)*nAL, (nColIni + 0035)*nAC, DtoC(aDados[nX, 54]), oFont04)

		 	oPrint:Box((nLinIni + 1940)*nAL, (nColIni + 0830)*nAC, (nLinIni + 2035)*nAL, (nColIni + 1600)*nAC)
			oPrint:Say((nLinIni + 1965)*nAL, (nColIni + 0845)*nAC, "55 - "+"Data, Local e Assinatura do Cirurgião Dentista", oFont01) //"Data, Local e Assinatura do Cirurgião Dentista"
			oPrint:Say((nLinIni + 2005)*nAL, (nColIni + 0855)*nAC, (aDados[nX, 55]), oFont04)

			oPrint:Box((nLinIni + 1940)*nAL, (nColIni + 1605)*nAC, (nLinIni + 2035)*nAL, (nColIni + 2375)*nAC)
			oPrint:Say((nLinIni + 1965)*nAL, (nColIni + 1620)*nAC, "56 - "+"Data, Local e Assinatura do Associado / Responsável", oFont01) //"Data, Local e Assinatura do Associado / Responsável"
			oPrint:Say((nLinIni + 2005)*nAL, (nColIni + 1630)*nAC, DtoC(aDados[nX, 56]), oFont04)

			oPrint:EndPage()	// Finaliza a pagina
		Next nX
	Enddo
Endif
If lGerTXT .And. !lWeb
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
	//³Imprime Relatorio
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
	oPrint:Print()
Else
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
	//³Visualiza impressao grafica antes de imprimir
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
	oPrint:Print()
EndIf

Return(cFileName)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡ao    ?PLSTISSA  ?Autor ?Luciano Aparecido     ?Data ?12.03.07 ³±?
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡ao ?Estrutura Relatório TISS (Guia Odontológica - Solicitação)  ³±?
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±?Uso      ?SigaPLS                                                     ³±?
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros?aDados - Array com as informações do relat´rio              ³±?
±±?         ?nLayout - Define o formato de papél para impressao:         ³±?
±±?         ?          1 - Formato Ofício II (216x330mm)                 ³±?
±±?         ?          2 - Formato A4 (210x297mm)                        ³±?
±±?         ? 		 3 - Formato Carta (216x279mm)     			       ³±?
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function CABTISSA(aDados, nLayout, cLogoGH) //Guia Odontológica - Solicitação

	Local nLinMax
	Local nColMax
	Local nLinIni	:=	0		// Linha Lateral (inicial) Esquerda
	Local nColIni	:=	0		// Coluna Lateral (inicial) Esquerda
	Local nColA4    :=  0
	Local nLinA4    :=  0
	Local cFileLogo
	Local lPrinter
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

	Default nLayout := 2
	Default cLogoGH := ''
	Default aDados  := { { ;
						"123456",;
						"12345678901234567892",;
						"12345678901234567892",;
						"12345678901234567892",;
						Replicate("M",40),;
						Replicate("M",40),;
						CtoD("01/12/07"),;
						Replicate("M",70),;
						"1199999999",;
						Replicate("M",40),;
						"14.141.114/00001-35",;
						Replicate("M",70),;
						"123456789012345",;
						"SP",;
						"1234567",;
						Replicate("M",70),;
						"123456789012345",;
						"SP",;
						"00199",;
						"1",;
						"0",;
						Replicate("M", 240),;
					 	CtoD("30/12/07"),;
					 	Replicate("M",30),;
						CtoD("30/12/07"),;
						Replicate("M",30),;
						CtoD("30/12/07"),;
						Replicate("M",30)} }

	If nLayout  == 1 // Ofício 2
		nLinMax := 2435
		nColMax := 3705
	Elseif nLayout == 2   // Papél A4
	   	nLinMax	:=	2335
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

	oPrint	:= TMSPrinter():New("GUIA ODONTOLÓGICA - SOLICITAÇÃO") //"GUIA ODONTOLÓGICA - SOLICITAÇÃO"

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

	If ! lPrinter
		oPrint:Setup()
	EndIf


	For nX := 1 To Len(aDados)

		If ValType(aDados[nX]) == 'U' .OR. Len(aDados[nX]) == 0
			Loop
		EndIf

		nLinIni := 080
		nColIni := 080
		nColA4  := 000
		nLinA4  := 000

		oPrint:StartPage()		// Inicia uma nova pagina
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Box Principal                                                 ?
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		oPrint:Box(nLinIni + 0000, nColIni + 0000, nLinIni + nLinMax, nColIni + nColMax)

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Carrega e Imprime Logotipo da Empresa                         ?
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		fLogoEmp(@cFileLogo,, cLogoGH)

		If File(cFilelogo)
			oPrint:SayBitmap(nLinIni + 0050, nColIni + 0020, cFileLogo, 400, 090) 		// Tem que estar abaixo do RootPath
		EndIf

		If nLayout == 2 // Papél A4
		  	nColA4    := -0335
		  	nLinA4    := -0025
		Elseif nLayout == 3// Carta
			nColA4    := -0530
		Endif

		oPrint:Say(nLinIni + 0080, nColIni + 1852 + IIF(nLayout ==2 .Or. nLayout ==3,nColA4+260,0),"GUIA TRATAMENTO ODONTOLÓGICO - SITUAÇÃO INICIAL", oFont02n,,,, 2)  //"GUIA TRATAMENTO ODONTOLÓGICO - SITUAÇÃO INICIAL"
		oPrint:Say(nLinIni + 0090, nColIni + 3000 + nColA4, "2 - "+OemToAnsi("Nº"), oFont01) //"N?
		oPrint:Say(nLinIni + 0070, nColIni + 3096 + nColA4, aDados[nX, 02], oFont03n)

		nLinIni+= 300
		oPrint:Box(nLinIni + 0175 + nLinA4, nColIni + 0010, nLinIni + 0269 + nLinA4, nColIni + 0315)
		oPrint:Say(nLinIni + 0180 + nLinA4, nColIni + 0020, "1 - " + "Registro ANS", oFont01) //"Registro ANS"
		oPrint:Say(nLinIni + 0210 + nLinA4, nColIni + 0030, aDados[nX, 01], oFont04)
		oPrint:Box(nLinIni + 0175 + nLinA4, nColIni + 0320, nLinIni + 0269 + nLinA4, nColIni + 0625)
		oPrint:Say(nLinIni + 0180 + nLinA4, nColIni + 0330, "3 - " + "Número da guia principal", oFont01) //"Número da guia principal"
		oPrint:Say(nLinIni + 0210 + nLinA4, nColIni + 0340, aDados[nX, 03], oFont04)

		nLinIni += 50
		oPrint:Say(nLinIni + 0274 + nLinA4, nColIni + 0010, "Dados do Beneficiário", oFont01) //"Dados do Beneficiário"
		oPrint:Box(nLinIni + 0304 + nLinA4, nColIni + 0010, nLinIni + 0398 + nLinA4, nColIni + 0415)
		oPrint:Say(nLinIni + 0309 + nLinA4, nColIni + 0020, "4 - "+"Número da Carteira", oFont01) //"Número da Carteira"
		oPrint:Say(nLinIni + 0339 + nLinA4, nColIni + 0030, aDados[nX, 04], oFont04)
		oPrint:Box(nLinIni + 0304 + nLinA4, nColIni + 0420, nLinIni + 0398 + nLinA4, nColIni + 1590 + IIF(nLayout ==3,nColA4/2,0))
		oPrint:Say(nLinIni + 0309 + nLinA4, nColIni + 0430, "5 - "+"Plano", oFont01) //"Plano"
		oPrint:Say(nLinIni + 0339 + nLinA4, nColIni + 0440, aDados[nX, 05], oFont04)
		oPrint:Box(nLinIni + 0304 + nLinA4, nColIni + 1595 + IIF(nLayout ==3,nColA4/2,0), nLinIni + 0398 + nLinA4, nColIni + 2765 + nColA4/2 + IIF(nLayout ==3,nColA4/2,0))
		oPrint:Say(nLinIni + 0309 + nLinA4, nColIni + 1605 + IIF(nLayout ==3,nColA4/2,0), "6 - "+"Empresa", oFont01) //"Empresa"
		oPrint:Say(nLinIni + 0339 + nLinA4, nColIni + 1615 + IIF(nLayout ==3,nColA4/2,0), aDados[nX, 06], oFont04)
		oPrint:Box(nLinIni + 0304 + nLinA4, nColIni + 2770 + nColA4/2 + IIF(nLayout ==3,nColA4/2,0), nLinIni + 0398 + nLinA4, nColIni + 3075 + nColA4/2 + IIF(nLayout ==3,nColA4/2,0))
		oPrint:Say(nLinIni + 0309 + nLinA4, nColIni + 2780 + nColA4/2 + IIF(nLayout ==3,nColA4/2,0), "7 - "+"Data Validade da Carteira", oFont01) //"Data Validade da Carteira"
		oPrint:Say(nLinIni + 0339 + nLinA4, nColIni + 2790 + nColA4/2 + IIF(nLayout ==3,nColA4/2,0), DtoC(aDados[nX, 07]), oFont04)

		oPrint:Box(nLinIni + 0403 + nLinA4, nColIni + 0010, nLinIni + 0497 + nLinA4, nColIni + 1990 + nColA4)
		oPrint:Say(nLinIni + 0407 + nLinA4, nColIni + 0020, "8 - "+"Nome", oFont01) //"Nome"
		oPrint:Say(nLinIni + 0437 + nLinA4, nColIni + 0030, aDados[nX, 08], oFont04)
		oPrint:Box(nLinIni + 0403 + nLinA4, nColIni + 1995 + nColA4, nLinIni + 0497 + nLinA4, nColIni + 2325 + nColA4)
		oPrint:Say(nLinIni + 0407 + nLinA4, nColIni + 2005 + nColA4, "9 - "+"Telefone", oFont01) //"Telefone"
		oPrint:Say(nLinIni + 0437 + nLinA4, nColIni + 2015 + nColA4, aDados[nX, 09], oFont04)
		oPrint:Box(nLinIni + 0403 + nLinA4, nColIni + 2330 + nColA4, nLinIni + 0497 + nLinA4, nColIni + 3500 + nColA4)
		oPrint:Say(nLinIni + 0407 + nLinA4, nColIni + 2340 + nColA4, "10 - "+"Nome do Titular do Plano", oFont01) //"Nome do Titular do Plano"
		oPrint:Say(nLinIni + 0437 + nLinA4, nColIni + 2350 + nColA4, aDados[nX, 10], oFont04)

		nLinIni += 50
		oPrint:Say(nLinIni + 0502 + nLinA4, nColIni + 0010, "Dados do contatado", oFont01) //"Dados do contatado"
		oPrint:Box(nLinIni + 0532 + nLinA4, nColIni + 0010, nLinIni + 0626 + nLinA4, nColIni + 0426)
		oPrint:Say(nLinIni + 0537 + nLinA4, nColIni + 0020, "11 - "+"Código na Operadora / CNPJ / CPF", oFont01) //"Código na Operadora / CNPJ / CPF"
		oPrint:Say(nLinIni + 0567 + nLinA4, nColIni + 0030, aDados[nX, 11], oFont04)
		oPrint:Box(nLinIni + 0532 + nLinA4, nColIni + 0431, nLinIni + 0626 + nLinA4, nColIni + 2410)
		oPrint:Say(nLinIni + 0537 + nLinA4, nColIni + 0441, "12 - "+"Nome do Contratado", oFont01) //"Nome do Contratado"
		oPrint:Say(nLinIni + 0567 + nLinA4, nColIni + 0451, SubStr(aDados[nX, 12], 1, 65), oFont04)
		oPrint:Box(nLinIni + 0532 + nLinA4, nColIni + 2415, nLinIni + 0626 + nLinA4, nColIni + 2745)
		oPrint:Say(nLinIni + 0537 + nLinA4, nColIni + 2425, "13 - "+"Número no CRO", oFont01) //"Número no CRO"
		oPrint:Say(nLinIni + 0567 + nLinA4, nColIni + 2435, aDados[nX, 13], oFont04)
		oPrint:Box(nLinIni + 0532 + nLinA4, nColIni + 2750, nLinIni + 0626 + nLinA4, nColIni + 2850)
		oPrint:Say(nLinIni + 0537 + nLinA4, nColIni + 2760, "14 - "+"UF", oFont01) //"UF"
		oPrint:Say(nLinIni + 0567 + nLinA4, nColIni + 2770, aDados[nX, 14], oFont04)
		oPrint:Box(nLinIni + 0532 + nLinA4, nColIni + 2855, nLinIni + 0626 + nLinA4, nColIni + 3065)
		oPrint:Say(nLinIni + 0537 + nLinA4, nColIni + 2865, "15 - "+"Código CNES", oFont01) //"Código CNES"
		oPrint:Say(nLinIni + 0567 + nLinA4, nColIni + 2875, aDados[nX, 15], oFont04)

		oPrint:Box(nLinIni + 0631 + nLinA4, nColIni + 0010, nLinIni + 0725 + nLinA4, nColIni + 1990)
		oPrint:Say(nLinIni + 0636 + nLinA4, nColIni + 0020, "16 - "+"Nome do profissional", oFont01) //"Nome do profissional"
		oPrint:Say(nLinIni + 0666 + nLinA4, nColIni + 0030, aDados[nX, 16], oFont04)
		oPrint:Box(nLinIni + 0631 + nLinA4, nColIni + 1995, nLinIni + 0725 + nLinA4, nColIni + 2310)
		oPrint:Say(nLinIni + 0636 + nLinA4, nColIni + 2005, "17 - "+"Número no CRO", oFont01) //"Número no CRO"
		oPrint:Say(nLinIni + 0666 + nLinA4, nColIni + 2015, aDados[nX, 17], oFont04)
		oPrint:Box(nLinIni + 0631 + nLinA4, nColIni + 2315, nLinIni + 0725 + nLinA4, nColIni + 2425)
		oPrint:Say(nLinIni + 0636 + nLinA4, nColIni + 2325, "18 - "+"UF", oFont01) //"UF"
		oPrint:Say(nLinIni + 0666 + nLinA4, nColIni + 2335, aDados[nX, 18], oFont04)
		oPrint:Box(nLinIni + 0631 + nLinA4, nColIni + 2430, nLinIni + 0725 + nLinA4, nColIni + 2645)
		oPrint:Say(nLinIni + 0636 + nLinA4, nColIni + 2440, "19 - "+"Código CBO S", oFont01) //"Código CBO S"
		oPrint:Say(nLinIni + 0666 + nLinA4, nColIni + 2450, aDados[nX, 19], oFont04)

		nLinIni += 50
		oPrint:Say(nLinIni + 0731 + nLinA4, nColIni + 0010, "Situação Inicial", oFont01) //"Situação Inicial"
		oPrint:Box(nLinIni + 0761 + nLinA4, nColIni + 0010, nLinIni + 0819 + nLinA4, nColIni + 0295)
		oPrint:Say(nLinIni + 0771 + nLinA4, nColIni + 0020, "Situação Inicial", oFont04) //"Situação Inicial"
		oPrint:Box(nLinIni + 0819 + nLinA4, nColIni + 0010, nLinIni + 0877 + nLinA4, nColIni + 0295)
		oPrint:Say(nLinIni + 0829 + nLinA4, nColIni + 0020, "Permanentes", oFont04) //"Permanentes"
		oPrint:Box(nLinIni + 0877 + nLinA4, nColIni + 0010, nLinIni + 0935 + nLinA4, nColIni + 0295)
		oPrint:Say(nLinIni + 0887 + nLinA4, nColIni + 0020, "Decíduos", oFont04) //"Decíduos"
		oPrint:Box(nLinIni + 0935 + nLinA4, nColIni + 0010, nLinIni + 0993 + nLinA4, nColIni + 0295)
		oPrint:Say(nLinIni + 0945 + nLinA4, nColIni + 0020, "Decíduos", oFont04) //"Decíduos"
		oPrint:Box(nLinIni + 0993 + nLinA4, nColIni + 0010, nLinIni + 1051 + nLinA4, nColIni + 0295)
		oPrint:Say(nLinIni + 1003 + nLinA4, nColIni + 0020, "Permanentes", oFont04) //"Permanentes"
		oPrint:Box(nLinIni + 1051 + nLinA4, nColIni + 0010, nLinIni + 1109 + nLinA4, nColIni + 0295)
		oPrint:Say(nLinIni + 1061 + nLinA4, nColIni + 0020, "Situação Inicial", oFont04) //"Situação Inicial"

		nCol	:=0300
		nColf	:=0400

		For nI:=1 to 16
			oPrint:Box(nLinIni + 0761 + nLinA4, nColIni + nCol , nLinIni + 0819 + nLinA4, nColIni + 	nColf)
			oPrint:Box(nLinIni + 0819 + nLinA4, nColIni + nCol , nLinIni + 0877 + nLinA4, nColIni + 	nColf)
			oPrint:Box(nLinIni + 0877 + nLinA4, nColIni + nCol , nLinIni + 0935 + nLinA4, nColIni + 	nColf)
			oPrint:Box(nLinIni + 0935 + nLinA4, nColIni + nCol , nLinIni + 0993 + nLinA4, nColIni + 	nColf)
			oPrint:Box(nLinIni + 0993 + nLinA4, nColIni + nCol , nLinIni + 1051 + nLinA4, nColIni + 	nColf)
			oPrint:Box(nLinIni + 1051 + nLinA4, nColIni + nCol , nLinIni + 1109 + nLinA4, nColIni + 	nColf)
		    nCol  +=0100
		    nColf +=0100
		Next nI

		aNum1:={"18","17","16","15","14","13","12","11","21","22","23","24","25","26","27","28"}
		nCol	:=0325
		For nI:=1 to Len(aNum1)
		oPrint:Say(nLinIni + 0829 + nLinA4, nColIni + nCol, aNum1[nI], oFont04)
		 nCol  +=0100
		Next nI

		nCol    :=630
		aNum2:={"55","54","53","52","51","61","62","63","64","65"}
		For nI:=1 to Len(aNum2)
		oPrint:Say(nLinIni + 0887 + nLinA4, nColIni + nCol, aNum2[nI], oFont04)
		 nCol  +=0100
		Next nI

		nCol    :=630
		aNum3:={"85","84","83","82","81","71","72","73","74","75"}
		For nI:=1 to Len(aNum3)
		oPrint:Say(nLinIni + 0945 + nLinA4, nColIni + nCol, aNum3[nI], oFont04)
		 nCol  +=0100
		Next nI

		aNum4:={"48","47","46","45","44","43","42","41","31","32","33","34","35","36","37","38"}
		nCol	:=0325
		For nI:=1 to Len(aNum4)
		oPrint:Say(nLinIni + 1003 + nLinA4, nColIni + nCol, aNum4[nI], oFont04)
		 nCol  +=0100
		Next nI

		oPrint:Box(nLinIni + 0761 + nLinA4, nColIni + 1905, nLinIni + 0850 + nLinA4, nColIni + 2330)
		oPrint:Say(nLinIni + 0766 + nLinA4, nColIni + 1910, "20 - "+"Sinais Clínicos de doença periodontal ?", oFont01) //"Sinais Clínicos de doença periodontal ?"

		oPrint:Line(nLinIni + 0800 + nLinA4, nColIni + 1920, nLinIni + 0840 + nLinA4, nColIni + 1920)
		oPrint:Line(nLinIni + 0840 + nLinA4, nColIni + 1920, nLinIni + 0840 + nLinA4, nColIni + 1955)
		oPrint:Line(nLinIni + 0800 + nLinA4, nColIni + 1955, nLinIni + 0840 + nLinA4, nColIni + 1955)
		oPrint:Say(nLinIni + 0805 + nLinA4, nColIni + 1970, "Sim", oFont04)  //"Sim"
		oPrint:Say(nLinIni + 0800 + nLinA4, nColIni + 1930, IIf(((aDados[nX, 20]) =="1"),"X",""), oFont04)

	   	oPrint:Line(nLinIni + 0800 + nLinA4, nColIni + 2050, nLinIni + 0840 + nLinA4, nColIni + 2050)
		oPrint:Line(nLinIni + 0840 + nLinA4, nColIni + 2050, nLinIni + 0840 + nLinA4, nColIni + 2085)
		oPrint:Line(nLinIni + 0800 + nLinA4, nColIni + 2085, nLinIni + 0840 + nLinA4, nColIni + 2085)
		oPrint:Say(nLinIni + 0805 + nLinA4, nColIni + 2100, "Não", oFont04) //"Não"
		oPrint:Say(nLinIni + 0800 + nLinA4, nColIni + 2060, IIf (((aDados[nX, 20]) =="0"),"X",""), oFont04)

		oPrint:Box(nLinIni + 0761 + nLinA4, nColIni + 2335, nLinIni + 0850 + nLinA4, nColIni + 2690)
		oPrint:Say(nLinIni + 0766 + nLinA4, nColIni + 2345, "21 - "+"Alteração dos Tecidos Moles ?", oFont01) //"Alteração dos Tecidos Moles ?"

		oPrint:Line(nLinIni + 0800 + nLinA4, nColIni + 2355, nLinIni + 0840 + nLinA4, nColIni + 2355)
		oPrint:Line(nLinIni + 0840 + nLinA4, nColIni + 2355, nLinIni + 0840 + nLinA4, nColIni + 2395)
		oPrint:Line(nLinIni + 0800 + nLinA4, nColIni + 2395, nLinIni + 0840 + nLinA4, nColIni + 2395)
		oPrint:Say(nLinIni + 0805 + nLinA4, nColIni + 2410, "Sim", oFont04)  //"Sim"
		oPrint:Say(nLinIni + 0800 + nLinA4, nColIni + 2365, IIf(((aDados[nX, 21]) =="1"),"X",""), oFont04)

		oPrint:Line(nLinIni + 0800 + nLinA4, nColIni + 2490, nLinIni + 0840 + nLinA4, nColIni + 2490)
		oPrint:Line(nLinIni + 0840 + nLinA4, nColIni + 2490, nLinIni + 0840 + nLinA4, nColIni + 2525)
		oPrint:Line(nLinIni + 0800 + nLinA4, nColIni + 2525, nLinIni + 0840 + nLinA4, nColIni + 2525)
		oPrint:Say(nLinIni + 0805 + nLinA4, nColIni + 2540, "Não", oFont04) //"Não"
		oPrint:Say(nLinIni + 0800 + nLinA4, nColIni + 2500, IIf (((aDados[nX, 21]) =="0"),"X",""), oFont04)

		oPrint:Say(nLinIni + 0860 + nLinA4, nColIni + 1905, "LEGENDA E OBSERVAÇÕES SOBRE A SITUAÇÃO INICIAL", oFont01)	 //"LEGENDA E OBSERVAÇÕES SOBRE A SITUAÇÃO INICIAL"
		oPrint:Box(nLinIni + 0890 + nLinA4, nColIni + 1905, nLinIni + 1109 + nLinA4, nColIni + 2150)
		oPrint:Say(nLinIni + 0900 + nLinA4, nColIni + 1920, "Situação Inicial", oFont01) //"SITUAÇÃO INICIAL"
		oPrint:Say(nLinIni + 0935 + nLinA4, nColIni + 1920, "A - Ausente", oFont01) //"A - Ausente"
		oPrint:Say(nLinIni + 0970 + nLinA4, nColIni + 1920, "E - Extração Indicada", oFont01) //"E - Extração Indicada"
		oPrint:Say(nLinIni + 1005 + nLinA4, nColIni + 1920, "H - Hígido", oFont01) //"H - Hígido"
		oPrint:Say(nLinIni + 1040 + nLinA4, nColIni + 1920, "C - Cariado", oFont01) //"C - Cariado"
		oPrint:Say(nLinIni + 1075 + nLinA4, nColIni + 1920, "R - Restaurado", oFont01) //"R - Restaurado"


		oPrint:Box(nLinIni + 1160 + nLinA4, nColIni + 0010, nLinIni + 1400 + nLinA4, nColIni + 3500 + nColA4)
		oPrint:Say(nLinIni + 1165 + nLinA4, nColIni + 0020, "22 - "+"Observação", oFont01) //"Observação"

		nLin := 1940

		For nI := 1 To MlCount(aDados[nX, 22], 130)
			cObs := MemoLine(aDados[nX, 22], 130, nI)
			oPrint:Say(nLinIni + nLin + nLinA4, nColIni + 0030, cObs, oFont04)
			nLin += 35
		Next nI



		oPrint:Box(nLinIni + 1450 + nLinA4, nColIni + 0010, nLinIni + 1600 + nLinA4, nColIni + 0850)
		oPrint:Say(nLinIni + 1455 + nLinA4, nColIni + 0020, "23 - "+"Data, Local e Assinatura do Cirurgião Dentista", oFont01) //"Data, Local e Assinatura do Cirurgião Dentista"
		oPrint:Say(nLinIni + 1485 + nLinA4, nColIni + 0030, DtoC(aDados[nX, 23]), oFont04)
		oPrint:Say(nLinIni + 1485 + nLinA4, nColIni + 0180, (aDados[nX, 24]), oFont04)
		oPrint:Box(nLinIni + 1450 + nLinA4, nColIni + 0855, nLinIni + 1600 + nLinA4, nColIni + 1695)
		oPrint:Say(nLinIni + 1455 + nLinA4, nColIni + 0865, "24 - "+"Data, Local e Assinatura do Associado / Responsável", oFont01) //"Data, Local e Assinatura do Associado / Responsável"
		oPrint:Say(nLinIni + 1485 + nLinA4, nColIni + 0875, DtoC(aDados[nX, 25]), oFont04)
		oPrint:Say(nLinIni + 1485 + nLinA4, nColIni + 1025, (aDados[nX, 26]), oFont04)
		oPrint:Box(nLinIni + 1450 + nLinA4, nColIni + 1700, nLinIni + 1600 + nLinA4, nColIni + 2540)
		oPrint:Say(nLinIni + 1455 + nLinA4, nColIni + 1710, "25 - "+"Data, Local e Carimbo da Empresa", oFont01) //"Data, Local e Carimbo da Empresa"
		oPrint:Say(nLinIni + 1485 + nLinA4, nColIni + 1720, DtoC(aDados[nX, 27]), oFont04)
		oPrint:Say(nLinIni + 1485 + nLinA4, nColIni + 1870, (aDados[nX, 28]), oFont04)

		oPrint:EndPage()	// Finaliza a pagina

	Next nX

	oPrint:Print()	// Visualiza impressao grafica antes de imprimir

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡ao    ?PLSTISSB  ?Autor ?Luciano Aparecido     ?Data ?13.03.07 ³±?
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡ao ?Estrutura Relatório TISS (Guia Odontológica - Pagamento )   ³±?
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±?Uso      ?SigaPLS                                                     ³±?
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros?aDados - Array com as informações do relat´rio              ³±?
±±?         ?nLayout - Define o formato de papél para impressao:         ³±?
±±?         ?          1 - Formato Ofício II (216x330mm)                 ³±?
±±?         ?          2 - Formato A4 (210x297mm)                        ³±?
±±?         ? 		 3 - Formato Carta (216x279mm)     			       ³±?
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function CABTISSB(aDados, nLayout, cLogoGH) //Guia Odontológica - Pagamento

	Local nLinMax
	Local nColMax
	Local nLinIni	:=	0		// Linha Lateral (inicial) Esquerda
	Local nColIni	:=	0		// Coluna Lateral (inicial) Esquerda
	Local nOldCol	:=	0
	Local nOldLin	:=	0
	Local nColA4    := 	0
	Local nLinFin	:=	0
    Local nTotVlrT  := 0
	Local cFileLogo
	Local lPrinter
	Local nI, nJ
	Local nX, nX1, nX2, nX3, nX4
	Local oFont01
	Local oFont02n
	Local oFont03n
	Local oFont04
	Local nProcGer,nProcLot,nProcGui
	Local nLibGer,nLiblot,nLibGui
	Local nGloGer,nGlolot,nGloGui
    Local lBox

    Default nLayout := 2
    Default cLogoGH := ''
	Default	aDados  := { {;
						"123456",;
						{"12345678901234567892"},;
						{Replicate("M",70)},;
						{"14.141.114/00001-35"},;
						{{CtoD("05/03/07"),CtoD("05/03/07")}},;
						{"14.141.114/00001-35"},;
						{Replicate("M",70)},;
						{"14.141.114/00001-35"},;
						{{"123456789012"}},;
						{{{"12345678901234567890"}}},;
						{{{Replicate("M",70)}}},;
						{{{"123456789012"}}},;
						{{{{"AA","BB","CC","DD","EE","FF","GG","HH","II","JJ","KK","LL","MM","NN","OO"}}}},;
					    {{{{"1234567890","1234567890","1234567890","1234567890","1234567890","1234567890","1234567890","1234567890","1234567890","1234567890","1234567890","1234567890","1234567890","1234567890","1234567890"}}}},;
						{{{{Replicate("M",70),Replicate("M",70),Replicate("M",70),Replicate("M",70),Replicate("M",70),Replicate("M",70),Replicate("M",70),Replicate("M",70),Replicate("M",70),Replicate("M",70),;
							Replicate("M",70),Replicate("M",70),Replicate("M",70),Replicate("M",70),Replicate("M",70)}}}},;
						{{{{"12345","12345","12345","12345","12345","12345","12345","12345","12345","12345","12345","12345","12345","12345","12345"}}}},;
						{{{{"ABCD","ABCD","ABCD","ABCD","ABCD","ABCD","ABCD","ABCD","ABCD","ABCD","ABCD","ABCD","ABCD","ABCD","ABCD"}}}},;
						{{{{CtoD("05/03/07"),CtoD("05/03/07"),CtoD("05/03/07"),CtoD("05/03/07"),CtoD("05/03/07"),CtoD("05/03/07"),CtoD("05/03/07"),CtoD("05/03/07"),CtoD("05/03/07"),CtoD("05/03/07"),CtoD("05/03/07"),CtoD("05/03/07"),CtoD("05/03/07"),CtoD("05/03/07"),CtoD("05/03/07")}}}},;
						{{{{10,20,30,40,50,60,70,80,90,15,25,35,45,55,65}}}},;
						{{{{99999.99,99999.99,99999.99,99999.99,99999.99,99999.99,99999.99,99999.99,99999.99,99999.99,99999.99,99999.99,99999.99,99999.99,99999.99}}}},;
						{{{{99999.99,99999.99,99999.99,99999.99,99999.99,99999.99,99999.99,99999.99,99999.99,99999.99,99999.99,99999.99,99999.99,99999.99,99999.99}}}},;
						{{{{99999.99,99999.99,99999.99,99999.99,99999.99,99999.99,99999.99,99999.99,99999.99,99999.99,99999.99,99999.99,99999.99,99999.99,99999.99}}}},;
						{{{{"1234","1234","1234","1234","1234","1234","1234","1234","1234","1234","1234","1234","1234","1234","1234"}}}},;
						{{{999999.99}}},;
						{{{999999.99}}},;
						{{{999999.99}}},;
						{{{999999.99}}},;
						{{{999999.99}}},;
						{{{999999.99}}},;
						{{{999999.99}}},;
						{{{999999.99}}},;
						{{{999999.99}}},;
				     	{{{ Replicate("M", 40), 999999999.99 },{ Replicate("M", 40), 999999999.99 },{ Replicate("M", 40), 999999999.99 },;
						  { Replicate("M", 40), 999999999.99 },{ Replicate("M", 40), 999999999.99 },{ Replicate("M", 40), 999999999.99 },;
						  { Replicate("M", 40), 999999999.99 },{ Replicate("M", 40), 999999999.99 },{ Replicate("M", 40), 999999999.99 },{ Replicate("M", 40), 999999999.99 } }},;
						{{{ Replicate("M", 40), 999999999.99 },{ Replicate("M", 40), 999999999.99 },{ Replicate("M", 40), 999999999.99 },;
						  { Replicate("M", 40), 999999999.99 } }},;
						{{{ Replicate("M", 40), 999999999.99 },{ Replicate("M", 40), 999999999.99 },{ Replicate("M", 40), 999999999.99 },;
						  { Replicate("M", 40), 999999999.99 } }},;
						{CtoD("30/12/07")},;
					 	{999999.99},;
						{999999.99},;
						{999999.99},;
						{999999.99} } }

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

	If ! lPrinter
		oPrint:Setup()
	EndIf


	For nX := 1 To Len(aDados)

		If ValType(aDados[nX]) == 'U' .OR. Len(aDados[nX]) == 0
			Loop
		EndIf

		For nI:= 13 To 23
			If Len(aDados[nX, nI]) < 15
				For nJ := Len(aDados[nX, nI]) + 1 To 15
					If AllTrim(Str(nI)) $ "19,20,21,22"
						aAdd(aDados[nX, nI], 0)
					ElseiF AllTrim(Str(nI)) $ "18"
						aAdd(aDados[nX, nI], CToD(""))
					Else
						aAdd(aDados[nX, nI],"")
					EndIf
				Next nJ
			EndIf
		Next nI

	  For nI := 33 To 33
			If Len(aDados[nX, nI]) < 1
				aAdd(aDados[nX, nI], { "", 0 })
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
		//³Box Principal                                                 ?
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		oPrint:Box(nLinIni + 0000, nColIni + 0000, nLinIni + nLinMax, nColIni + nColMax)

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Carrega e Imprime Logotipo da Empresa                         ?
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

		oPrint:Say(nLinIni + 0080, nColIni + 1852 + IIF(nLayout ==2 .Or. nLayout ==3,nColA4+260,0), "GUIA TRATAMENTO ODONTOLÓGICO - DEMONSTRATIVO DE PAGAMENTO", oFont02n,,,, 2) //"GUIA TRATAMENTO ODONTOLÓGICO - DEMONSTRATIVO DE PAGAMENTO"
		oPrint:Say(nLinIni + 0090, nColIni + 3000 + nColA4, "2 - "+OemToAnsi("Nº"), oFont01) //"N?
		oPrint:Say(nLinIni + 0070, nColIni + 3096 + nColA4, aDados[nX, 02,nX1], oFont03n)

		nLinIni+= 80
		oPrint:Box(nLinIni + 0175, nColIni + 0010, nLinIni + 0269, nColIni + 0315)
		oPrint:Say(nLinIni + 0180, nColIni + 0020, "1 - "+"Registro ANS", oFont01) //"Registro ANS"
		oPrint:Say(nLinIni + 0210, nColIni + 0030, aDados[nX, 01], oFont04)
		oPrint:Box(nLinIni + 0175, nColIni + 0320, nLinIni + 0269, nColIni + 2355 + IIf(nLayout == 3,nColA4/2,0))
		oPrint:Say(nLinIni + 0180, nColIni + 0330, "3 - "+"Nome da Operadora", oFont01) //"Nome da Operadora"
		oPrint:Say(nLinIni + 0210, nColIni + 0340, aDados[nX, 03,nX1], oFont04)
		oPrint:Box(nLinIni + 0175, nColIni + 2360 + IIf(nLayout == 3,nColA4/2,0), nLinIni + 0269, nColIni + 2776 + IIf(nLayout == 3,nColA4/2,0))
		oPrint:Say(nLinIni + 0180, nColIni + 2370 + IIf(nLayout == 3,nColA4/2,0), "4 - "+"CNPJ Operadora", oFont01) //"CNPJ Operadora"
		oPrint:Say(nLinIni + 0210, nColIni + 2380 + IIf(nLayout == 3,nColA4/2,0), aDados[nX, 04,nX1], oFont04)
		oPrint:Box(nLinIni + 0175, nColIni + 2781 + IIf(nLayout == 3,nColA4/2,0), nLinIni + 0269, nColIni + 3200 + IIf(nLayout == 3,nColA4/2,0))
		oPrint:Say(nLinIni + 0180, nColIni + 2791 + IIf(nLayout == 3,nColA4/2,0), "5 - "+"Período de Processamento", oFont01) //"Período de Processamento"
		oPrint:Say(nLinIni + 0210, nColIni + 2801 + IIf(nLayout == 3,nColA4/2,0), DToC(aDados[nX, 05,nX1,1]), oFont04)
		oPrint:Say(nLinIni + 0210, nColIni + 2950 + IIf(nLayout == 3,nColA4/2,0), " ?", oFont04) //" ?"
		oPrint:Say(nLinIni + 0210, nColIni + 3020 + IIf(nLayout == 3,nColA4/2,0), DToC(aDados[nX, 05,nX1,2]), oFont04)

		nLinIni += 20
		oPrint:Say(nLinIni + 0274, nColIni + 0010, "Dados do Prestador", oFont01) //"Dados do Prestador"
		oPrint:Box(nLinIni + 0304, nColIni + 0010, nLinIni + 0398, nColIni + 0415)
		oPrint:Say(nLinIni + 0309, nColIni + 0020, "6 - "+"Código na Operadora", oFont01) //"Código na Operadora"
		oPrint:Say(nLinIni + 0339, nColIni + 0030, aDados[nX, 06,nX1], oFont04)
		oPrint:Box(nLinIni + 0304, nColIni + 0420, nLinIni + 0398, nColIni + 2455)
		oPrint:Say(nLinIni + 0309, nColIni + 0430, "7 - "+"Nome do Contratado", oFont01) //"Nome do Contratado"
		oPrint:Say(nLinIni + 0339, nColIni + 0440, aDados[nX, 07,nX1], oFont04)
		oPrint:Box(nLinIni + 0304, nColIni + 2460, nLinIni + 0398, nColIni + 2875)
		oPrint:Say(nLinIni + 0309, nColIni + 2470, "8 - "+"CPF/ CNPJ Contratado", oFont01) //"CPF/ CNPJ Contratado"
		oPrint:Say(nLinIni + 0339, nColIni + 2480, aDados[nX, 08,nX1], oFont04)

		nProcGer := 0
		nLibGer  := 0
		nGloGer  := 0


	   For nX2 := 1 To Len(aDados[nX, 09,nX1])

	   fSomaLin(nLinMax, nColMax, @nLinIni, nColIni, 20)

			nProcLot := 0
	   		nGloLot  := 0
	   		nLibLot  := 0

			oPrint:Say(nLinIni + 0403, nColIni + 0010, "Dados do Pagamento", oFont01) //"Dados do Pagamento"
			oPrint:Box(nLinIni + 0433, nColIni + 0010, nLinIni + 0527, nColIni + 0370)
			oPrint:Say(nLinIni + 0438, nColIni + 0020, "9 - "+"Número do Lote", oFont01) //"Número do Lote"
			oPrint:Say(nLinIni + 0468, nColIni + 0030, aDados[nX, 09,nX1, nX2], oFont04)


		  	For nX3 := 1 To Len(aDados[nX, 12,nX1, nX2])
		  			if nX3 <> 1
		  		   		fSomaLin(nLinMax, nColMax, @nLinIni, nColIni, 100)
					Endif
					oPrint:Box(nLinIni + 0433, nColIni + 0375, nLinIni + 0527, nColIni + 0820)
					oPrint:Say(nLinIni + 0438, nColIni + 0385, "10 - "+"Código do Beneficiário", oFont01) //"Código do Beneficiário"
					oPrint:Say(nLinIni + 0468, nColIni + 0395, aDados[nX, 10,nX1, nX2, nX3], oFont04)
					oPrint:Box(nLinIni + 0433, nColIni + 0825, nLinIni + 0527, nColIni + 2835 + IIf(nLayout == 3,nColA4/2,0))
					oPrint:Say(nLinIni + 0438, nColIni + 0835, "11 - "+"Nome do Beneficiário", oFont01) //"Nome do Beneficiário"
					oPrint:Say(nLinIni + 0468, nColIni + 0845, aDados[nX, 11,nX1, nX2, nX3], oFont04)
					oPrint:Box(nLinIni + 0433, nColIni + 2840 + IIf(nLayout == 3,nColA4/2,0), nLinIni + 0527, nColIni + 3200 + IIf(nLayout == 3,nColA4/2,0))
					oPrint:Say(nLinIni + 0438, nColIni + 2850 + IIf(nLayout == 3,nColA4/2,0), "12 - "+"Número da Guia", oFont01) //"Número da Guia"
					oPrint:Say(nLinIni + 0468, nColIni + 2860 + IIf(nLayout == 3,nColA4/2,0), aDados[nX, 12 ,nX1, nX2, nX3], oFont04)
					lBox:=.F.

					fSomaLin(nLinMax, nColMax, @nLinIni, nColIni, 50)

					if (nLinIni + 600 + (Len(aDados[nX, 13,nX1, nX2, nX3]) * 45)) < nLinMax
						oPrint:Box(nLinIni + 0518, nColIni + 0010, nLinIni + 600 + (Len(aDados[nX, 13,nX1, nX2, nX3]) * 45), nColIni + 3695 + nColA4)
						Else
						oPrint:Line(nLinIni + 0518, nColIni + 0010, nLinIni + 0563, nColIni + 0010)
					 	oPrint:Line(nLinIni + 0518, nColIni + 0010, nLinIni + 0518, nColIni + 3695 + nColA4)
					 	oPrint:Line(nLinIni + 0518, nColIni + 3695 + nColA4, nLinIni + 0563, nColIni + 3695 + nColA4)
					  	lBox:=.T.
					Endif

					oPrint:Say(nLinIni + 0528, nColIni + 0020, "13 - "+"Tabela", oFont01) //"Tabela"
					oPrint:Say(nLinIni + 0528, nColIni + 0155, "14 - "+"Código do Procedimento", oFont01) //"Código do Procedimento"
					oPrint:Say(nLinIni + 0528, nColIni + 0430, "15 - "+"Descrição", oFont01) //"Descrição"
					oPrint:Say(nLinIni + 0528, nColIni + 1950 + nColA4, "16 - "+"Dente/Região", oFont01) //"Dente/Região"
					oPrint:Say(nLinIni + 0528, nColIni + 2150 + nColA4, "17 - "+"Face", oFont01) //"Face"
					oPrint:Say(nLinIni + 0528, nColIni + 2510 + nColA4, "18 - "+"Data de Realização", oFont01,,,,1) //"Data de Realização"
					oPrint:Say(nLinIni + 0528, nColIni + 2560 + nColA4, "19 - "+"Qtd", oFont01) //"Qtd"
					oPrint:Say(nLinIni + 0528, nColIni + 2910 + nColA4, "20 - "+"Valor Processado(R$)", oFont01,,,,1) //"Valor Processado(R$)"
					oPrint:Say(nLinIni + 0528, nColIni + 2950 + nColA4, "21 - "+"Valor Glosa/Estorno(R$)", oFont01) //"Valor Glosa/Estorno(R$)"
					oPrint:Say(nLinIni + 0528, nColIni + 3245 + nColA4, "22 - "+"Valor Liberado(R$)", oFont01) //"Valor Liberado(R$)"
					oPrint:Say(nLinIni + 0528, nColIni + 3665 + nColA4, "23 - "+"Motivo da Glosa", oFont01,,,,1) //"Motivo da Glosa"

					nProcGui := 0
					nGloGui  := 0
					nLibGui  := 0

					fSomaLin(nLinMax, nColMax, @nLinIni, nColIni, 555)

					For nX4 := 1 To Len(aDados[nX, 13,nX1, nX2, nX3])

						if lBox
							oPrint:Line(nLinIni + 0010, nColIni + 0010, nLinIni + 0055, nColIni  + 0010)
							oPrint:Line(nLinIni + 0010, nColIni  + 3695 + nColA4, nLinIni + 0055, nColIni  + 3695 + nColA4)
						Endif

						oPrint:Say(nLinIni + 0010, nColIni + 0065, aDados[nX, 13,nX1,  nX2, nX3 , nX4], oFont04) //0573
						oPrint:Say(nLinIni + 0010, nColIni + 0170, aDados[nX, 14,nX1,  nX2, nX3 , nX4], oFont04)
						oPrint:Say(nLinIni + 0010, nColIni + 0430, aDados[nX, 15,nX1,  nX2, nX3 , nX4], oFont01)
						oPrint:Say(nLinIni + 0010, nColIni + 1990 + IIf(nLayout == 3,nColA4+20,nColA4), aDados[nX, 16,nX1,  nX2, nX3 , nX4], oFont04)
						oPrint:Say(nLinIni + 0010, nColIni + 2150 + IIf(nLayout == 3,nColA4+20,nColA4), aDados[nX, 17,nX1,  nX2, nX3 , nX4], oFont04)
						oPrint:Say(nLinIni + 0010, nColIni + 2350 + IIf(nLayout == 3,nColA4+20,nColA4), DtoC(aDados[nX, 18,nX1 , nX2, nX3 , nX4]), oFont04)
						oPrint:Say(nLinIni + 0010, nColIni + 2610 + IIf(nLayout == 3,nColA4+20,nColA4), IIF(Empty(aDados[nX, 19 ,nX1, nX2, nX3 , nX4]), "", Transform(aDados[nX, 19,nX1, nX2, nX3 , nX4], "@E 9999.99")), oFont04,,,,1)
						oPrint:Say(nLinIni + 0010, nColIni + 2855 + IIf(nLayout == 3,nColA4+20,nColA4), IIF(Empty(aDados[nX, 20 ,nX1, nX2, nX3 , nX4]), "", Transform(aDados[nX, 20,nX1, nX2, nX3 , nX4], "@E 99,999,999.99")), oFont04,,,,1)
						oPrint:Say(nLinIni + 0010, nColIni + 3125 + IIf(nLayout == 3,nColA4+20,nColA4), IIf(Empty(aDados[nX, 21 ,nX1, nX2, nX3 , nX4]), "", Transform(aDados[nX, 21,nX1, nX2, nX3 , nX4], "@E 99,999,999.99")), oFont04,,,,1)
						oPrint:Say(nLinIni + 0010, nColIni + 3400 + IIf(nLayout == 3,nColA4+20,nColA4), IIf(Empty(aDados[nX, 22 ,nX1, nX2, nX3 , nX4]), "", Transform(aDados[nX, 22,nX1, nX2, nX3 , nX4], "@E 99,999,999.99")), oFont04,,,,1)
					   	oPrint:Say(nLinIni + 0010, nColIni + 3525 + IIf(nLayout == 3,nColA4+20,nColA4), aDados[nX, 23,nX1, nX2, nX3 , nX4], oFont04)

		 		   		fSomaLin(nLinMax, nColMax, @nLinIni, nColIni, 45)

					Next nX4

				    if lBox
						oPrint:Line(nLinIni + 0010, nColIni + 0010, nLinIni + 0010, nColIni + 3695 + nColA4)
					Endif

				    fSomaLin(nLinMax, nColMax, @nLinIni, nColIni, 45)

				 	oPrint:Box(nLinIni + 0010, nColIni + 2485 + nColA4, nLinIni + 0104, nColIni + 2885 + nColA4)
					oPrint:Say(nLinIni + 0015, nColIni + 2495 + nColA4, "24 - "+"Valor Total Processado Guia(R$)", oFont01) //"Valor Total Processado Guia(R$)"
					oPrint:Say(nLinIni + 0045, nColIni + 2705 + nColA4, Transform(aDados[nX, 24,nX1,nX2,nX3], "@E 999,999,999.99"), oFont04,,,,1)

				    oPrint:Box(nLinIni + 0010, nColIni + 2890 + nColA4, nLinIni + 0104, nColIni + 3290 + nColA4)
					oPrint:Say(nLinIni + 0015, nColIni + 2900 + nColA4, "25 - "+"Valor Total Glosa Guia(R$)", oFont01) //"Valor Total Glosa Guia(R$)"
					oPrint:Say(nLinIni + 0045, nColIni + 3110 + nColA4, Transform(aDados[nX, 25,nX1,nX2,nX3], "@E 999,999,999.99"), oFont04,,,,1)

				    oPrint:Box(nLinIni + 0010, nColIni + 3295 + nColA4, nLinIni + 0104, nColIni + 3695 + nColA4)
					oPrint:Say(nLinIni + 0015, nColIni + 3305 + nColA4, "26 - "+"Valor Total Liberado Guia (R$)", oFont01) //"Valor Total Liberado Guia (R$)"
					oPrint:Say(nLinIni + 0045, nColIni + 3515 + nColA4, Transform(aDados[nX, 26,nX1,nX2,nX3], "@E 999,999,999.99"), oFont04,,,,1)


					fSomaLin(nLinMax, nColMax, @nLinIni, nColIni, 030)
		    		nLinIni-=300
		    		oPrint:Box(nLinIni + 0385, nColIni + 1270 + nColA4, nLinIni + 0479, nColIni + 1670 + nColA4)
					oPrint:Say(nLinIni + 0390, nColIni + 1280 + nColA4, "27 - "+"Valor Total Processado Lote(R$)", oFont01) //"Valor Total Processado Lote(R$)"
					oPrint:Say(nLinIni + 0420, nColIni + 1590 + nColA4, Transform(aDados[nX, 27,nX1,nX2], "@E 999,999,999.99"), oFont04,,,,1)

				    oPrint:Box(nLinIni + 0385, nColIni + 1675 + nColA4, nLinIni + 0479, nColIni + 2075 + nColA4)
					oPrint:Say(nLinIni + 0390, nColIni + 1685 + nColA4, "28 - "+"Valor Total Glosa Lote(R$)", oFont01) //"Valor Total Glosa Lote(R$)"
					oPrint:Say(nLinIni + 0420, nColIni + 1895 + nColA4, Transform(aDados[nX, 28,nX1,nX2], "@E 999,999,999.99"), oFont04,,,,1)

				    oPrint:Box(nLinIni + 0385, nColIni + 2080 + nColA4, nLinIni + 0479, nColIni + 2480 + nColA4)
					oPrint:Say(nLinIni + 0390, nColIni + 2090 + nColA4, "29 - "+"Valor Total Liberado Lote (R$)", oFont01) //"Valor Total Liberado Lote (R$)"
					oPrint:Say(nLinIni + 0420, nColIni + 2300 + nColA4, Transform(aDados[nX, 29,nX1,nX2], "@E 999,999,999.99"), oFont04,,,,1)

				    oPrint:Box(nLinIni + 0385, nColIni + 2485 + nColA4, nLinIni + 0479, nColIni + 2885 + nColA4)
					oPrint:Say(nLinIni + 0390, nColIni + 2495 + nColA4, "30 - " + "Valor Geral Processado (R$)", oFont01)  //"Valor Geral Processado (R$)"
  					oPrint:Say(nLinIni + 0420, nColIni + 2705 + nColA4, Transform(aDados[nX, 30,nX1,1], "@E 999,999,999.99"), oFont04,,,,1)

				    oPrint:Box(nLinIni + 0385, nColIni + 2890 + nColA4, nLinIni + 0479, nColIni + 3290 + nColA4)
					oPrint:Say(nLinIni + 0390, nColIni + 2900 + nColA4, "31 - " + "Valor Geral Glosa (R$)", oFont01)  //"Valor Geral Glosa (R$)"
					oPrint:Say(nLinIni + 0420, nColIni + 3110 + nColA4, Transform(aDados[nX, 31,nX1], "@E 999,999,999.99"), oFont04,,,,1)

				    oPrint:Box(nLinIni + 0385, nColIni + 3295 + nColA4, nLinIni + 0479, nColIni + 3695 + nColA4)
					oPrint:Say(nLinIni + 0390, nColIni + 3305 + nColA4, "32 - " + "Valor Total Liberado Lote (R$)" /*STR0394*/, oFont01) //"Valor Total Liberado Lote (R$)" //"Valor Geral Liberado (R$)"
					oPrint:Say(nLinIni + 0420, nColIni + 3515 + nColA4, Transform(aDados[nX, 32,nX1], "@E 999,999,999.99"), oFont04,,,,1)

					fSomaLin(nLinMax, nColMax, @nLinIni, nColIni, 045)

			Next nX3

		Next nX2

	 	fSomaLin(nLinMax, nColMax, @nLinIni, nColIni, 45)
		oPrint:Say(nLinIni + 0420, nColIni + 0010, "Demais débitos / Créditos", oFont01) //"Demais débitos / Créditos"

	 	oPrint:Box(nLinIni + 0450, nColIni + 0010, nLinIni + 0520 + ((Len(aDados[nX, 33,nX1])/4) * 45), nColIni + 3695 + nColA4)

        nOldCol := nColIni
        nColIni := 0

		oPrint:Say(nLinIni + 0455, nColIni + 0020, "33 - " + "Descrição", oFont01) //"Descrição"
		oPrint:Say(nLinIni + 0455, nColIni + 0650, "34 - " + "Valor (R$)", oFont01)  //"Valor (R$)"

		nColIni := 0

	 	For nI := 1 To Len(aDados[nX, 33,nX1])
			oPrint:Say(nLinIni + 0495, nColIni + 0020, aDados[nX, 33,nX1, nI, 1], oFont01)
			oPrint:Say(nLinIni + 0495, nColIni + 0780, IIf(Empty(aDados[nX, 33,nX1, nI, 1]), "", Transform(aDados[nX, 33,nX1, nI, 2], "@E 999,999,999.99")), oFont01,,,,1)
		   	nColini += 775
		  	If Mod(nI,4)== 0
		  		nColIni := nOldCol
			  	fSomaLin(nLinMax, nColMax, @nLinIni, nOldCol, 45)
			EndIf
		Next nI

		nColIni := nOldCol

		If (If(Empty(aDados[nX, 34,nX1]),0,Len(aDados[nX, 34,nX1]))) >;
		   (If(Empty(aDados[nX, 35,nX1]),0,Len(aDados[nX, 35,nX1])))
			nLinFin := Len(aDados[nX, 34,nX1])
		Else
			nLinFin := Len(aDados[nX, 35,nX1])
		EndIf


		fSomaLin(nLinMax, nColMax, @nLinIni, nColIni, 130)

		oPrint:Say(nLinIni + 0420, nColIni + 0010, "Demais débitos / créditos não tributáveis", oFont01)               //"Demais débitos / créditos não tributáveis"
		oPrint:Say(nLinIni + 0420, nColIni + 1565, "Impostos", oFont01)               //"Impostos"

		oPrint:Box(nLinIni + 0450, nColIni + 0010, nLinIni + 0520 + ((nLinFin/2) * 45), nColIni + 1561)
		oPrint:Box(nLinIni + 0450, nColIni + 1564, nLinIni + 0520 + ((nLinFin/2) * 45), nColIni + 3695 + nColA4)


        nColIni := 0

		oPrint:Say(nLinIni + 0455, nColIni + 0020, "35 - " + "Descrição", oFont01) //"Descrição"
		oPrint:Say(nLinIni + 0455, nColIni + 0650, "36 - " + "Valor (R$)", oFont01)  //"Valor (R$)"


		nColIni += (2*775)

		oPrint:Say(nLinIni + 0455, nColIni + 0020, "37 - " + "Descrição", oFont01) //"Descrição"
		oPrint:Say(nLinIni + 0455, nColIni + 0650, "38 - " + "Valor (R$)", oFont01)  //"Valor (R$)"

		nColIni := 0
		nOldLin := nLinIni
	 	For nI := 1 To Len(aDados[nX, 34,nX1])
			oPrint:Say(nLinIni + 0495, nColIni + 0020, aDados[nX, 34,nX1, nI, 1], oFont01)
			oPrint:Say(nLinIni + 0495, nColIni + 0780, IIf(Empty(aDados[nX, 34,nX1, nI, 2]), "", Transform(aDados[nX, 34,nX1, nI, 2], "@E 999,999,999.99")), oFont01,,,,1)
		   	nColini += 775
		  	If Mod(nI,2)== 0
		  		nColIni := nOldCol
			  	fSomaLin(nLinMax, nColMax, @nLinIni, nColIni, 45)
			EndIf
		Next nI

		nColIni:=0
        nLinIni := nOldLin
        nTotVlrT := 0

	 	For nI := 1 To Len(aDados[nX, 35, nX1])
			oPrint:Say(nLinIni + 0495, nColIni + 1570, aDados[nX,35,nX1,nI,1], oFont01)
			oPrint:Say(nLinIni + 0495, nColIni + 2330, Transform((aDados[nX,35,nX1,nI,2]*aDados[nX,40,nX1,1]/aDados[nX,41,nX1,1]), "@E 999,999,999.99"), oFont01,,,,1)
		   	nTotVlrT += (aDados[nX,35,nX1,nI,2]*aDados[nX,40,nX1,1]/aDados[nX,41,nX1,1])
		   	nColini += 775
		  	If Mod(nI,2)== 0
		  		nColIni := nOldCol
			  	fSomaLin(nLinMax, nColMax, @nLinIni, nColIni, 45)
			EndIf
		Next nI


		nColIni := nOldCol

		fSomaLin(nLinMax, nColMax, @nLinIni, nColIni, 100)

	   	oPrint:Say(nLinIni + 0475, nColIni + 0010, "Totais", oFont01)  //"Totais"

		oPrint:Box(nLinIni + 0505, nColIni + 0010, nLinIni + 0599, nColIni + 0395)
		oPrint:Say(nLinIni + 0510, nColIni + 0020, "39 - " + "Data do Pagamento", oFont01) //"Data do Pagamento"
		oPrint:Say(nLinIni + 0540, nColIni + 0030, DtoC(aDados[nX, 36,nX1]), oFont04)

		oPrint:Box(nLinIni + 0505, nColIni + 0400, nLinIni + 0599, nColIni + 0800)
		oPrint:Say(nLinIni + 0510, nColIni + 0415, "40 - " + "Valor Total Tributável (R$)", oFont01) //"Valor Total Tributável (R$)"
		oPrint:Say(nLinIni + 0540, nColIni + 0425, Transform(aDados[nX, 37,nX1], "@E 999,999,999.99"), oFont04)

		oPrint:Box(nLinIni + 0505, nColIni + 0805, nLinIni + 0599, nColIni + 1205)
		oPrint:Say(nLinIni + 0510, nColIni + 0815, "41 - " + "Valor Total Impostos Retidos (R$)", oFont01)  //"Valor Total Impostos Retidos (R$)"
		oPrint:Say(nLinIni + 0540, nColIni + 0825, Transform(nTotVlrT, "@E 999,999,999.99"), oFont04)

		oPrint:Box(nLinIni + 0505, nColIni + 1210, nLinIni + 0599, nColIni + 1610)
		oPrint:Say(nLinIni + 0510, nColIni + 1220, "42 - " + "Valor Total Não Tributável (R$)", oFont01)  //"Valor Total Não Tributável (R$)"
		oPrint:Say(nLinIni + 0540, nColIni + 1230, Transform(aDados[nX, 39, nX1], "@E 999,999,999.99"), oFont04)

		oPrint:Box(nLinIni + 0505, nColIni + 3295 + nColA4, nLinIni + 0599, nColIni + 3695 + nColA4)
		oPrint:Say(nLinIni + 0510, nColIni + 3305 + nColA4, "43 -  "+ "Valor Final a Receber (R$)", oFont01)  //"Valor Final a Receber (R$)"
    	oPrint:Say(nLinIni + 0540, nColIni + 3515 + nColA4, Transform(aDados[nX, 32,nX1], "@E 99,999,999.99"), oFont04,,,,1)

	  	fSomaLin(nLinMax, nColMax, @nLinIni, nColIni, 100)

		oPrint:Box(nLinIni + 0510, nColIni + 0010, nLinIni + 780, nColIni + 3695 + nColA4)
		oPrint:Say(nLinIni + 0515, nColIni + 0020, "44 - "+"Observação", oFont01) //"Observação"
		oPrint:Say(nLinIni + 0540, nColIni + 3515 + nColA4, AllTrim(BEA->BEA_MSG01) + " " + AllTrim(BEA->BEA_MSG02)+ " " + AllTrim(BEA->BEA_MSG03), oFont04,,,,1)


	Next nX1
	oPrint:EndPage()	// Finaliza a pagina

Next nX

oPrint:Preview()	// Visualiza impressao grafica antes de imprimir

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡ao    ?PLSGSADT  ?Autor ?Luciano Aparecido     ?Data ?10.01.07 ³±?
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡ao ?Dados Relatório TISS (Guia Consulta e SP/SADT )             ³±?
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±?Uso      ?SigaPLS                                                     ³±?
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros?nGuia ( Informe 1- Guia de Consulta e 2-Guia de SP/SADT )   ³±?
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function CABGSADT(nGuia)
	Local aDados
	Local aCpo25
	Local aCpo26
	Local aCpo27
	Local aCpo28
	Local aCpo29
	Local aCpo40
	Local aCpo51
	Local aCpo52
	Local aCpo53
	Local aCpo54
	Local aCpo55
	Local aCpo56
	Local aCpo57
	Local aCpo58
	Local aCpo59
	Local aCpo60
	Local aCpo61
	Local aCpo62
	Local aCpo63
	Local aCpo65
	Local aCpo66
	Local aCpo67
	Local aCpo68
	Local aCpo69
	Local aCpo70
	Local aCpo71
	Local aCpo72
	Local aCpo73
	Local aCpo74
	Local aCpo75
	Local aCpo76
	Local aCpo77
	Local aCpo78
	Local aCpo79
	Local aCpo80
	Local aCpo81
	Local aCpo82
	Local aCpo83
	Local aCpo84
	Local aCpo85
	Local nVrProc
	Local nVrMater
	Local nVrMedic
	Local nVrTaxas
	Local nVrDiar
	Local nVrGases
	Local nTotOPM
	Local lTemPFExe
	Local lExecPF
	Local lBE2Aut
	Local nProx			:= 0
	Local nProx1		:= 0
	Local nRecBAU		:= 0
	Local nOrdBAU		:= 0
	Local lImpCID		:= GetMV("MV_PLSICID",,.T.)
	Local cTissVer		:= "2.02.03" //PLSTISSVER()
	Local lImpNAut	:= IIf(GetNewPar("MV_PLNAUT",0) == 0, .F., .T.) // 0 = Nao imprime procedimento nao autorizado 1 = Sim imprime
	If FindFunction("PLSTISSVER")
		cTissVer		:= PLSTISSVER()
	EndIf

	aDados := {}

	If !Empty(cTissVer) .AND. cTissVer >= "3"
		aDados := PL446DAD(nGuia)
		Return(aDados)
	EndIf

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//?Posiciona Operadora                                          ?
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	BA0->(dbSetOrder(1))
	BA0->(dbSeek(xFilial("BA0")+BEA->(BEA_OPEUSR)))
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//?Posiciona Usuario                                            ?
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	BA1->(dbSetOrder(2))
	BA1->(dbSeek(xFilial("BA1")+BEA->(BEA_OPEUSR+BEA_CODEMP+BEA_MATRIC+BEA_TIPREG)))
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//?Posiciona Vidas                                  			 ?
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	BTS->(dbSetOrder(1))
	BTS->(dbSeek(xFilial("BTS")+BA1->BA1_MATVID))
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//?Posiciona Familias/Usuarios                                  ?
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	BA3->(dbSetorder(01))
	BA3->(dbSeek(xFilial("BA3")+BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC)))
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//?Posiciona Produtos de Saude - Plano                          ?
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	BI3->(dbSetOrder(1))
	If !Empty(BA1->BA1_CODPLA)
		BI3->(dbSeek(xFilial("BI3")+BA1->(BA1_CODINT+BA1_CODPLA+BA1_VERSAO)))
	Else
		BI3->(dbSeek(xFilial("BI3")+BA3->(BA3_CODINT+BA3_CODPLA+BA3_VERSAO)))
	Endif
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//?Posiciona Medico Solicitante                                 ?
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	BB0->(dbSetOrder(4))
	BB0->(dbSeek(xFilial("BB0")+BEA->(BEA_ESTSOL+BEA_REGSOL+BEA_SIGLA)))

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//?Posiciona Rede de Atendimento                                ?
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	BAU->(dbSetOrder(1))
	BAU->(dbSeek(xFilial("BAU")+BEA->BEA_CODRDA))
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//?Posiciona Contas Medicas                                     ?
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	BD5->(dbSetOrder(1))
	BD5->(MsSeek(xFilial("BD5")+BEA->(BEA_OPEMOV+BEA_CODLDP+BEA_CODPEG+BEA_NUMGUI)))

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//?Posiciona Especialidade                                      ?
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	BAQ->(dbSetOrder(1))
	BAQ->(MsSeek(xFilial("BAQ")+BEA->(BEA_OPEMOV+BEA_CODESP)))

	//ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ?
	//?Monta dados da Guia de Consulta.													 ?
	//ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ?
	If nGuia == "1"

		// Cabecalho
		aAdd(aDados, BA0->BA0_SUSEP) // 1
		aAdd(aDados, BEA->(BEA_OPEMOV+"."+BEA_ANOAUT+"."+BEA_MESAUT+"-"+BEA_NUMAUT)) // 2
		aAdd(aDados, BEA->BEA_DTDIGI) // 3
		// Dados do Beneficiario
		If BA1->BA1_CODINT == BA1->BA1_OPEORI .Or. empty(BA1->BA1_MATANT)
			aAdd(aDados, BEA->(SubStr(BEA_OPEMOV,1,1)+SubStr(BEA_OPEMOV,2,3)+"."+BEA_CODEMP+"."+BEA_MATRIC+"."+BEA_TIPREG+"-"+BEA_DIGITO)	) // 4
		Else
			aAdd(aDados, BA1->BA1_MATANT) // 4
		EndIf
		aAdd(aDados, BI3->BI3_NREDUZ) // 5
		aAdd(aDados, BA1->BA1_DTVLCR) // 6
		aAdd(aDados, BEA->BEA_NOMUSR) // 7
		aAdd(aDados, BTS->BTS_NRCRNA) // 8
		// Dados do Contratado
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//?Posiciona Profissional de Saude                              ?
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		lTemPFExe := .F. // Tem Profissional Executante informado na Guia
		lExecPF   := .F. // O executante (RDA) eh pessoa fisica
		If ! Empty(BEA->BEA_REGEXE)
			BB0->(dbSetOrder(4))
			lTemPFExe := BB0->(dbSeek(xFilial("BB0")+BEA->(BEA_ESTEXE+BEA_REGEXE+BEA_SIGEXE)))
		Else
			If BAU->BAU_TIPPE == "F"
				BB0->(dbSetOrder(1))
				lExecPF := BB0->(dbSeek(xFilial("BB0")+BAU->BAU_CODBB0))
			EndIf
		EndIf
		aAdd(aDados, IIf(BAU->BAU_TIPPE == "F", Transform(BAU->BAU_CPFCGC, "@R 999.999.999-99"), Transform(BAU->BAU_CPFCGC, "@R 99.999.999/9999-99"))) // 9
		aAdd(aDados, BAU->BAU_NOME) // 10

		BB8->(dbSetOrder(1))
		BB8->(dbSeek(xFilial("BB8")+BAU->BAU_CODIGO+BEA->(BEA_OPEMOV+BEA_CODLOC)))

		aAdd(aDados, Transform(BB8->BB8_CNES, cPicCNES)) // 11
		aAdd(aDados, BB8->BB8_TIPLOG) // 12
		aAdd(aDados, BB8->BB8_END) // 13
		aAdd(aDados, BB8->BB8_NR_END) // 14
		aAdd(aDados, BB8->BB8_COMEND) // 15
		aAdd(aDados, BB8->BB8_MUN) // 16
		aAdd(aDados, BB8->BB8_EST) // 17
		aAdd(aDados, BB8->BB8_CODMUNI) // 18
		aAdd(aDados, Transform(BB8->BB8_CEP, "@R 99999-999")) // 19
		aAdd(aDados, IIf(lTemPFExe, BB0->BB0_NOME, "")) // 20
		aAdd(aDados, IIf(lTemPFExe .Or. lExecPF, BB0->BB0_CODSIG, "")) // 21
		aAdd(aDados, IIf(lTemPFExe .Or. lExecPF, BB0->BB0_NUMCR, "")) // 22
		aAdd(aDados, IIf(lTemPFExe .Or. lExecPF, BB0->BB0_ESTADO, "")) // 23
		aAdd(aDados, IIf(lTemPFExe .Or. lExecPF, BAQ->BAQ_CBOS, "")) // 24
		// Hipoteses Diagnosticas
		aAdd(aDados, BEA->BEA_TIPDOE) // 25
		aAdd(aDados, { BEA->BEA_TPODOE, BEA->BEA_UTPDOE } ) // 26
		aAdd(aDados, BEA->BEA_INDACI) // 27
		//Verifica se Imprime ou não o CID nas Guias
		aAdd(aDados, IIf( lImpCID , BEA->BEA_CID		, " " ) ) // 28 - Cid Principal
		aAdd(aDados, IIf( lImpCID , BEA->BEA_CIDSEC	, " " ) ) // 29 - Cid 02
		aAdd(aDados, IIf( lImpCID , BEA->BEA_CID3		, " " ) ) // 30 - Cid 03
		aAdd(aDados, IIf( lImpCID , BEA->BEA_CID4		, " " ) ) // 31 - Cid 04
		// Dados do Atendimento/Procedimento realizado
		BE2->(dbSetOrder(1))
		cChave	:= xFilial("BE2")+BEA->(BEA_OPEMOV+BEA_ANOAUT+BEA_MESAUT+BEA_NUMAUT )
		If BE2->(MsSeek(cChave))
			aAdd(aDados, BEA->BEA_DATPRO) // 32
			BD6->(dbSetOrder(1))
	 		BD6->(MsSeek(xFilial("BD6")+BD5->(BD5_CODOPE+BD5_CODLDP+BD5_CODPEG+BD5_NUMERO+BD5_ORIMOV)+BE2->(BE2_SEQUEN+BE2_CODPAD+BE2_CODPRO)))
		   	aAdd(aDados,Posicione("BF8", 2, xFilial("BF8")+BD6->(BD6_CODPAD+BD6_CODOPE+BD6_CODTAB), "BF8_TABTIS"))//33
			 //	aAdd(aDados, BE2->BE2_CODPAD) // 33

		   	aAdd(aDados, PlsPicPro(BE2->BE2_CODPAD, BE2->BE2_CODPRO)) // 34
			aAdd(aDados, BEA->BEA_TIPCON) // 35
		Else
			aAdd(aDados, StoD("")) // 32
			aAdd(aDados, "") // 33
			aAdd(aDados, "") // 34
			aAdd(aDados, "") // 35
		EndIf
		aAdd(aDados, BEA->BEA_TIPSAI) // 36
		aAdd(aDados, AllTrim(BEA->BEA_MSG01) + " " + AllTrim(BEA->BEA_MSG02) + " " + AllTrim(BEA->BEA_MSG03)) // 37
		aAdd(aDados, dDataBase) // 38
		aAdd(aDados, dDataBase) // 39
	ElseIf nGuia == "2" // Guia de SP/SADT
		// Dados da Autorizacao
		aAdd(aDados, BA0->BA0_SUSEP) // 1
		aAdd(aDados, BEA->(BEA_OPEMOV+"."+BEA_ANOAUT+"."+BEA_MESAUT+"-"+BEA_NUMAUT)) // 2

		If BD5->(FieldPos("BD5_GUIPRI")) > 0
			aAdd(aDados, if (!Empty(BEA->BEA_GUIPRI),BEA->BEA_GUIPRI,BD5->BD5_GUIPRI)) // 3
		EndIf

		aAdd(aDados, BEA->BEA_DATPRO) // 4
		// ajuste  - 03/08/2017 - Mateus
		//aAdd(aDados, iif(!Empty(BEA->BEA_SENHA) .and. !Empty(BEA->BEA_DATPRO) ,BEA->BEA_SENHA,BEA->(BEA_OPEMOV+"."+BEA_ANOAUT+"."+BEA_MESAUT+"-"+BEA_NUMAUT) ) ) // 5 - ajustar
		aAdd(aDados, BEA->(BEA_OPEMOV+"."+BEA_ANOAUT+"."+BEA_MESAUT+"-"+BEA_NUMAUT) ) // 5 - ajustar
		aAdd(aDados, IIf(Empty(BEA->BEA_SENHA), StoD(""), BEA->BEA_VALSEN)) // 6
		aAdd(aDados, BEA->BEA_DTDIGI) // 7
		// Dados do Beneficiario
		If BA1->BA1_CODINT == BA1->BA1_OPEORI .Or. empty(BA1->BA1_MATANT) // 8
			aAdd(aDados, BEA->(SubStr(BEA_OPEMOV,1,1)+SubStr(BEA_OPEMOV,2,3)+"."+BEA_CODEMP+"."+BEA_MATRIC+"."+BEA_TIPREG+"-"+BEA_DIGITO)	)
		Else
			aAdd(aDados, BA1->BA1_MATANT)
		EndIf
		aAdd(aDados, BI3->BI3_NREDUZ) // 9
		aAdd(aDados, BA1->BA1_DTVLCR) // 10
		aAdd(aDados, BEA->BEA_NOMUSR) // 11
		aAdd(aDados, BTS->BTS_NRCRNA) // 12
		// Dados do Contratado Solicitante
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//?Posiciona Medico Solicitante                                 ?
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		BB0->(dbSetOrder(4) )
		BB0->(dbSeek(xFilial("BB0")+BEA->(BEA_ESTSOL+BEA_REGSOL+BEA_SIGLA)))
		If  BEA->(FieldPos("BEA_RDACON")) > 0 .and. !Empty(BEA->BEA_RDACON)
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//?Salva Recnos												 ?
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			nRecBAU := BAU->(Recno())
			nOrdBAU := BAU->(IndexOrd())

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//?Posiciona Rede de Atendimento                                ?
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			BAU->(dbSetOrder(1))
			BAU->(dbSeek(xFilial("BAU")+BEA->BEA_RDACON))

			aAdd(aDados, IIf(BAU->BAU_TIPPE == "F", Transform(BAU->BAU_CPFCGC, "@R 999.999.999-99"), Transform(BAU->BAU_CPFCGC, "@R 99.999.999/9999-99"))) // 13
			aAdd(aDados, BAU->BAU_NOME) // 14

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//?Posiciona registros											 ?
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			BAU->(DbSetOrder(nOrdBAU))
			BAU->(DbGoTo(nRecBAU))
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//?Como no nosso sistema não existe local de atendimento para   ?
			//| o contratado solicitante, o CNES esta sendo enviado em branco|
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			BB8->(dbSetOrder(1))
			BB8->(dbSeek(xFilial("BB8")+BAU->BAU_CODIGO+BEA->(BEA_OPEMOV+BEA_CODLOC)))
			aAdd(aDados, Transform('', cPicCNES)) // 15
		Else
			aAdd(aDados, IIf(Len(AllTrim(BB0->BB0_CGC)) == 11, Transform(BB0->BB0_CGC, "@R 999.999.999-99"), Transform(BB0->BB0_CGC, "@R 99.999.999/9999-99"))) // 13
			aAdd(aDados, BB0->BB0_NOME) // 14
			BB8->(dbSetOrder(1))
			BB8->(dbSeek(xFilial("BB8")+BAU->BAU_CODIGO+BEA->(BEA_OPEMOV+BEA_CODLOC)))
			aAdd(aDados, Transform(BB8->BB8_CNES, cPicCNES)) // 15
		Endif

		aAdd(aDados, BEA->BEA_NOMSOL) // 16
		aAdd(aDados, BEA->BEA_SIGLA) // 17
		aAdd(aDados, BEA->BEA_REGSOL) // 18
		aAdd(aDados, BEA->BEA_ESTSOL) // 19
		aAdd(aDados, BAQ->BAQ_CBOS) // 20
		// Dados da solicitacao/procedimentos/exames solicitados
		aAdd(aDados, { BEA->BEA_DATSOL, BEA->BEA_HORSOL }) // 21
		BDR->(dbSetOrder(1)) // BDR_FILIAL + BDR_CODOPE + BDR_CODTAD
		BDR->(MsSeek(xFilial("BDR")+BEA->(BEA_OPEMOV+BEA_TIPADM)))
		aAdd(aDados, BDR->BDR_CARINT) // 22
		// Verifica Se Imprime CID nas Guias
		aAdd(aDados, IIf( lImpCID , BEA->BEA_CID , " " ) ) // 23 - CID Principal
		aAdd(aDados, AllTrim(BEA->BEA_INDCLI)+" "+AllTrim(BEA->BEA_INDCL2)) // 24
		aCpo25   := {}
		aCpo26   := {}
		aCpo27   := {}
		aCpo28   := {}
		aCpo29   := {}
		aCpo51   := {}
		aCpo52   := {}
		aCpo53   := {}
		aCpo54   := {}
		aCpo55   := {}
		aCpo56   := {}
		aCpo57   := {}
		aCpo58   := {}
		aCpo59   := {}
		aCpo60   := {}
		aCpo61   := {}
		aCpo62   := {}
		aCpo63   := {}
		aCpo65   := {}
		aCpo66   := {}
		aCpo67   := {}
		aCpo68   := {}
		aCpo69   := {}
		aCpo70   := {}
		aCpo71   := {}
		aCpo72   := {}
		aCpo73   := {}
		aCpo74   := {}
		aCpo75   := {}
		aCpo76   := {}
		aCpo77   := {}
		aCpo78   := {}
		aCpo79   := {}
		aCpo80   := {}
		aCpo81   := {}
		aCpo82   := {}
		aCpo83   := {}
		aCpo84   := {}
		aCpo85   := {}
		nVrProc  := 0
		nVrMater := 0
		nVrMedic := 0
		nVrTaxas := 0
		nVrDiar  := 0
		nVrGases := 0
		nTotOPM  := 0

		BE2->(dbSetOrder(1))
		cChave	:= xFilial("BE2")+BEA->(BEA_OPEMOV+BEA_ANOAUT+BEA_MESAUT+BEA_NUMAUT)
		If BE2->(dbSeek(cChave))
			Do While !BE2->(Eof()) .And. cChave == BE2->(BE2_FILIAL+BE2_OPEMOV+BE2_ANOAUT+BE2_MESAUT+BE2_NUMAUT)

				If !lImpNAut .And. BE2->BE2_STATUS == "0" // MV_PLNAUT 0 = Nao imprime procedimento nao autorizado 1 = Sim imprime
					BE2->(dbSkip())
					Loop
				Endif

				lBE2Aut := BE2->BE2_QTDPRO > 0

				BR8->(dbSetOrder(1))
				BR8->(dbSeek(xFilial("BR8")+BE2->(BE2_CODPAD+BE2_CODPRO)))

				If BR8->BR8_TPPROC <> "5" // OPM (Orteses, Proteses e Materiais Especiais)
				 	BD6->(dbSetOrder(1))
	 				BD6->(MsSeek(xFilial("BD6")+BD5->(BD5_CODOPE+BD5_CODLDP+BD5_CODPEG+BD5_NUMERO+BD5_ORIMOV)+BE2->(BE2_SEQUEN+BE2_CODPAD+BE2_CODPRO)))
		   			aAdd(aCpo25,Posicione("BF8", 2, xFilial("BF8")+BD6->(BD6_CODPAD+BD6_CODOPE+BD6_CODTAB), "BF8_TABTIS"))//25
		  		  	aAdd(aCpo26, PlsPicPro(BE2->BE2_CODPAD, BE2->BE2_CODPRO)) // 26
					aAdd(aCpo27, BE2->BE2_DESPRO) // 27
					aAdd(aCpo28, BE2->BE2_QTDSOL) // 28
					aAdd(aCpo29, BE2->BE2_QTDPRO) // 29
				EndIf

			 	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//?Posiciona Vias de Acesso                                     ?
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				If BEA->BEA_ORIGEM == "1"
					BGR->(dbSetOrder(1))
					BGR->(MsSeek(xFilial("BGR")+BE2->(BE2_OPEMOV+BE2_VIA)))

					If lBE2Aut .And. BR8->BR8_TPPROC <> "5" // OPM (Orteses, Proteses e Materiais Especiais)
						aAdd(aCpo51, BE2->BE2_DATPRO) // 51
						aAdd(aCpo52, BE2->BE2_HORPRO) // 52
						aAdd(aCpo53, BE2->BE2_HORFIM) // 53
					 	BD6->(dbSetOrder(1))
	 					BD6->(MsSeek(xFilial("BD6")+BD5->(BD5_CODOPE+BD5_CODLDP+BD5_CODPEG+BD5_NUMERO+BD5_ORIMOV)+BE2->(BE2_SEQUEN+BE2_CODPAD+BE2_CODPRO)))
		   		   		aAdd(aCpo54,Posicione("BF8", 2, xFilial("BF8")+BD6->(BD6_CODPAD+BD6_CODOPE+BD6_CODTAB), "BF8_TABTIS"))//54
						aAdd(aCpo55, PlsPicPro(BE2->BE2_CODPAD, BE2->BE2_CODPRO)) // 55
						aAdd(aCpo56, BE2->BE2_DESPRO) // 56
						aAdd(aCpo57, BE2->BE2_QTDPRO) // 57
						aAdd(aCpo58, BGR->BGR_VIATIS) // 58
						aAdd(aCpo59, BE2->BE2_TECUTI) // 59
					EndIf
					BD6->(dbSetOrder(1)) // BD6_FILIAL + BD6_CODOPE + BD6_CODLDP + BD6_CODPEG + BD6_NUMERO + BD6_ORIMOV + BD6_SEQUEN + BD6_CODPAD + BD6_CODPRO
					If BD6->(dbSeek(xFilial("BD6")+BE2->BE2_OPEMOV+BEA->BEA_CODLDP+ BEA->BEA_CODPEG +BE2->BE2_NUMERO+BEA->BEA_ORIMOV+BE2->BE2_SEQUEN+BE2->BE2_CODPAD+BE2->BE2_CODPRO))
						aAdd(aCpo60, BD6->BD6_PERC1) // 60
						If lBE2Aut .And. BR8->BR8_TPPROC <> "5" .And. GetNewPar("MV_VLTISS","1")=="1" // OPM (Orteses, Proteses e Materiais Especiais)
							aAdd(aCpo61, Round(BD6->BD6_VLRPAG / BD6->BD6_QTDPRO, 2)) // 61
							aAdd(aCpo62, BD6->BD6_VLRPAG) // 62
					 	Endif
						BR8->(dbSetOrder(1))
						If BR8->(dbSeek(xFilial("BR8")+BE2->(BE2_CODPAD+BE2_CODPRO))) .And. GetNewPar("MV_VLTISS","1")=="1"
							Do Case
								Case lBE2Aut .And. BR8->BR8_TPPROC == "0" // Procedimento
									nVrProc  += BD6->BD6_VLRPAG
										nProx+=1
								Case lBE2Aut .And. BR8->BR8_TPPROC == "1" // Material
									nVrMater += BD6->BD6_VLRPAG
										nProx+=1
								Case lBE2Aut .And. BR8->BR8_TPPROC == "2" // Medicamento
									nVrMedic += BD6->BD6_VLRPAG
										nProx+=1
								Case lBE2Aut .And. BR8->BR8_TPPROC == "3" // Taxas
									nVrTaxas += BD6->BD6_VLRPAG
										nProx+=1
								Case lBE2Aut .And. BR8->BR8_TPPROC == "4" // Diarias
									nVrDiar  += BD6->BD6_VLRPAG
										nProx+=1
								Case lBE2Aut .And. BR8->BR8_TPPROC == "7" // Gases Medicinais
									nVrGases += BD6->BD6_VLRPAG
										nProx+=1
								Case BR8->BR8_TPPROC == "5" // OPM (Orteses, Proteses e Materiais Especiais)
								    // OPM SOLICITADOS
								    	nProx1+=1
								    BD6->(dbSetOrder(1))
	 								BD6->(MsSeek(xFilial("BD6")+BD5->(BD5_CODOPE+BD5_CODLDP+BD5_CODPEG+BD5_NUMERO+BD5_ORIMOV)+BE2->(BE2_SEQUEN+BE2_CODPAD+BE2_CODPRO)))
		   		   					aAdd(aCpo72,Posicione("BF8", 2, xFilial("BF8")+BD6->(BD6_CODPAD+BD6_CODOPE+BD6_CODTAB), "BF8_TABTIS"))//72
									aAdd(aCpo73, PlsPicPro(BE2->BE2_CODPAD, BE2->BE2_CODPRO)) // 73
									aAdd(aCpo74, BE2->BE2_DESPRO) // 74
									aAdd(aCpo75, BE2->BE2_QTDSOL) // 75
									aAdd(aCpo76, BR8->BR8_FABRIC) // 76
									aAdd(aCpo77, Round(BD6->BD6_VLRPAG / BD6->BD6_QTDPRO, 2)) // 77
								    // OPM UTILIZADOS
				    				If lBE2Aut
				    				 	BD6->(dbSetOrder(1))
	 									BD6->(MsSeek(xFilial("BD6")+BD5->(BD5_CODOPE+BD5_CODLDP+BD5_CODPEG+BD5_NUMERO+BD5_ORIMOV)+BE2->(BE2_SEQUEN+BE2_CODPAD+BE2_CODPRO)))
		   		   						aAdd(aCpo78,Posicione("BF8", 2, xFilial("BF8")+BD6->(BD6_CODPAD+BD6_CODOPE+BD6_CODTAB), "BF8_TABTIS"))//78
										aAdd(aCpo79, PlsPicPro(BE2->BE2_CODPAD, BE2->BE2_CODPRO)) // 79
										aAdd(aCpo80, BE2->BE2_DESPRO) // 80
										aAdd(aCpo81, BE2->BE2_QTDPRO) // 81
										aAdd(aCpo82, BR8->BR8_CODBAR) // 82
										aAdd(aCpo83, Round(BD6->BD6_VLRPAG / BD6->BD6_QTDPRO, 2)) // 83
										aAdd(aCpo84, BD6->BD6_VLRPAG) // 84
										nTotOPM += BD6->BD6_VLRPAG
									EndIf
							EndCase
						Else
							Do Case
								Case lBE2Aut .And. BR8->BR8_TPPROC == "0" // Procedimento
									nVrProc  := 0
								Case lBE2Aut .And. BR8->BR8_TPPROC == "1" // Material
									nVrMater := 0
								Case lBE2Aut .And. BR8->BR8_TPPROC == "2" // Medicamento
									nVrMedic := 0
								Case lBE2Aut .And. BR8->BR8_TPPROC == "3" // Taxas
									nVrTaxas := 0
								Case lBE2Aut .And. BR8->BR8_TPPROC == "4" // Diarias
									nVrDiar  := 0
								Case lBE2Aut .And. BR8->BR8_TPPROC == "7" // Gases Medicinais
									nVrGases := 0
								Case BR8->BR8_TPPROC == "5" // OPM (Orteses, Proteses e Materiais Especiais)
								    // OPM SOLICITADOS
								    BD6->(dbSetOrder(1))
	 								BD6->(MsSeek(xFilial("BD6")+BD5->(BD5_CODOPE+BD5_CODLDP+BD5_CODPEG+BD5_NUMERO+BD5_ORIMOV)+BE2->(BE2_SEQUEN+BE2_CODPAD+BE2_CODPRO)))
		   		   					aAdd(aCpo72,Posicione("BF8", 2, xFilial("BF8")+BD6->(BD6_CODPAD+BD6_CODOPE+BD6_CODTAB), "BF8_TABTIS"))//72
									aAdd(aCpo73, PlsPicPro(BE2->BE2_CODPAD, BE2->BE2_CODPRO)) // 73
									aAdd(aCpo74, BE2->BE2_DESPRO) // 74
									aAdd(aCpo75, BE2->BE2_QTDSOL) // 75
									aAdd(aCpo76, BR8->BR8_FABRIC) // 76
									aAdd(aCpo77, 0) // 77
								    // OPM UTILIZADOS
				    				If lBE2Aut
				    				 	BD6->(dbSetOrder(1))
	 									BD6->(MsSeek(xFilial("BD6")+BD5->(BD5_CODOPE+BD5_CODLDP+BD5_CODPEG+BD5_NUMERO+BD5_ORIMOV)+BE2->(BE2_SEQUEN+BE2_CODPAD+BE2_CODPRO)))
		   		   						aAdd(aCpo78,Posicione("BF8", 2, xFilial("BF8")+BD6->(BD6_CODPAD+BD6_CODOPE+BD6_CODTAB), "BF8_TABTIS"))//78
										aAdd(aCpo79, PlsPicPro(BE2->BE2_CODPAD, BE2->BE2_CODPRO)) // 79
										aAdd(aCpo80, BE2->BE2_DESPRO) // 80
										aAdd(aCpo81, BE2->BE2_QTDPRO) // 81
										aAdd(aCpo82, BR8->BR8_CODBAR) // 82
										aAdd(aCpo83, 0) // 83
										aAdd(aCpo84, 0) // 84
										nTotOPM := 0
									EndIf
							EndCase
						EndIf
					Else
						aAdd(aCpo61, 0) // 61
						aAdd(aCpo62, 0) // 62
					EndIf
				Endif

			   	BE2->(dbSkip())

			if nProx == 5
			    aAdd(aCpo65,nVrProc)
			 	aAdd(aCpo66,nVrTaxas)
			 	aAdd(aCpo67,nVrMater)
			 	aAdd(aCpo68,nVrMedic)
			 	aAdd(aCpo69,nVrDiar)
			    aAdd(aCpo70,nVrGases)
			 	aAdd(aCpo71,nVrProc+nVrTaxas+nVrMater+nVrMedic+nVrDiar+nVrGases)
			 	nProx:=0
			 	nVrProc  := 0
			 	nVrMater := 0
			 	nVrMedic := 0
			 	nVrTaxas := 0
			 	nVrDiar  := 0
			 	nVrGases := 0
			Endif

			if nProx1 == 9
				aAdd(aCpo85,nTotOPM)
				nProx1:=0
				nTotOPM:=0
			Endif

			Enddo
		EndIf
		aAdd(aCpo65,nVrProc)
		aAdd(aCpo66,nVrTaxas)
		aAdd(aCpo67,nVrMater)
		aAdd(aCpo68,nVrMedic)
		aAdd(aCpo69,nVrDiar)
		aAdd(aCpo70,nVrGases)
		aAdd(aCpo71,nVrProc+nVrTaxas+nVrMater+nVrMedic+nVrDiar+nVrGases)
		aAdd(aCpo85,nTotOPM)

		aAdd(aDados, aCpo25)
		aAdd(aDados, aCpo26)
		aAdd(aDados, aCpo27)
		aAdd(aDados, aCpo28)
		aAdd(aDados, aCpo29)
		// Dados do Contratado executante
		lTemPFExe := .F. // Tem Profissional Executante informado na Guia
		lExecPF   := .F. // O executante (RDA) eh pessoa fisica
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//?Posiciona Rede de Atendimento                                ?
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		BAU->(dbSetOrder(1))
		BAU->(MsSeek(xFilial("BAU")+BEA->BEA_CODRDA))

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//?Posiciona Profissional de Saude                              ?
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If ! Empty(BEA->BEA_REGEXE)
			BB0->(dbSetOrder(4) )
			lTemPFExe := BB0->(dbSeek(xFilial("BB0")+BEA->(BEA_ESTEXE+BEA_REGEXE+BEA_SIGEXE)))
		Else
			If BAU->BAU_TIPPE == "F"
				BB0->(dbSetOrder(1))
				lExecPF := BB0->(dbSeek(xFilial("BB0")+BAU->BAU_CODBB0))
			EndIf
		EndIf

		BB8->(dbSetOrder(1))
		BB8->(dbSeek(xFilial("BB8")+BAU->BAU_CODIGO+BEA->(BEA_OPEMOV+BEA_CODLOC)))

		If !(GetNewPar("MV_PLSRDAG","") == BEA->BEA_CODRDA) .and. BEA->BEA_LIBERA <> '1'
			aAdd(aDados, IIf(BAU->BAU_TIPPE == "F", Transform(BAU->BAU_CPFCGC, "@R 999.999.999-99"), Transform(BAU->BAU_CPFCGC, "@R 99.999.999/9999-99"))) // 30
			aAdd(aDados, BAU->BAU_NOME) // 31
			aAdd(aDados, BB8->BB8_TIPLOG) // 32
			aAdd(aDados, BB8->BB8_END) // 33
			aAdd(aDados, BB8->BB8_NR_END) // 34
			aAdd(aDados, BB8->BB8_COMEND) // 35
			aAdd(aDados, BB8->BB8_MUN) // 36
			aAdd(aDados, BB8->BB8_EST) // 37
			aAdd(aDados, BB8->BB8_CODMUNI) // 38
			aAdd(aDados, Transform(BB8->BB8_CEP, "@R 99999-999")) // 39
			aCpo40 := {}
			aAdd(aCpo40, Transform(BB8->BB8_CNES, cPicCNES)) // 40
		Else //Se for a RDA Generica nao imprime
			aAdd(aDados, "") // 30
			aAdd(aDados, "") // 31
			aAdd(aDados, "") // 32
			aAdd(aDados, "") // 33
			aAdd(aDados, "") // 34
			aAdd(aDados, "") // 35
			aAdd(aDados, "") // 36
			aAdd(aDados, "") // 37
			aAdd(aDados, "") // 38
			aAdd(aDados, "") // 39
			aCpo40 := {}
			aAdd(aCpo40, "") // 40
		Endif

		If ( lTemPFExe .Or. lExecPF ) .And. BEA->BEA_ORIGEM == "1"
			aAdd(aCpo40, IIf(lTemPFExe, IIf(Len(AllTrim(BB0->BB0_CGC)) == 11, Transform(BB0->BB0_CGC, "@R 999.999.999-99"), Transform(BB0->BB0_CGC, "@R 99.999.999/9999-99")), "")) // 40a
			aAdd(aDados, aCpo40) // 40 e 40a
			aAdd(aDados, IIf(lTemPFExe, BB0->BB0_NOME, "")) // 41
			aAdd(aDados, IIf(lTemPFExe .Or. lExecPF, BB0->BB0_CODSIG, "")) // 42
			aAdd(aDados, IIf(lTemPFExe .Or. lExecPF, BB0->BB0_NUMCR, "")) // 43
			aAdd(aDados, IIf(lTemPFExe .Or. lExecPF, BB0->BB0_ESTADO, "")) // 44
			aAdd(aDados, { IIf(lTemPFExe .Or. lExecPF, BAQ->BAQ_CBOS, ""), "" }) // 45 e 45a ??????(45a)?????grau de participacao?????
		Else
			aAdd(aCpo40, "") // 40a
			aAdd(aDados, aCpo40) // 40 e 40a
			aAdd(aDados, "") // 41
			aAdd(aDados, "") // 42
			aAdd(aDados, "") // 43
			aAdd(aDados, "") // 44
			aAdd(aDados, { "", "" }) // 45 e 45a ??????(45a)?????grau de participacao?????
		EndIf
		// Dados do Atendimento
		aAdd(aDados, if (BEA->BEA_TIPATE $ ("01/02/03/04/05/06/07/08/09/10"),BEA->BEA_TIPATE,"")) // 46
		aAdd(aDados, BEA->BEA_INDACI) // 47
		aAdd(aDados, BEA->BEA_TIPSAI) // 48
		// Consulta de referencia
		aAdd(aDados, BEA->BEA_TIPDOE) // 49
		aAdd(aDados, { BEA->BEA_TPODOE, BEA->BEA_UTPDOE } ) // 50

		// Procedimentos e exames realizados
		aAdd(aDados, aCpo51)
		aAdd(aDados, aCpo52)
		aAdd(aDados, aCpo53)
		aAdd(aDados, aCpo54)
		aAdd(aDados, aCpo55)
		aAdd(aDados, aCpo56)
		aAdd(aDados, aCpo57)
		aAdd(aDados, aCpo58)
		aAdd(aDados, aCpo59)
		aAdd(aDados, aCpo60)
		aAdd(aDados, aCpo61)
		aAdd(aDados, aCpo62)
		aAdd(aDados, aCpo63) // Data e Assinatura de Procedimentos em Serie
		aAdd(aDados, AllTrim(BEA->BEA_MSG01) + " " + AllTrim(BEA->BEA_MSG02) + " " + AllTrim(BEA->BEA_MSG03))  // 64
		aAdd(aDados, aCpo65) // 65 - Vr Procedimentos
		aAdd(aDados, aCpo66) // 66 - Vr Taxas e Alugueis
		aAdd(aDados, aCpo67) // 67 - Vr Materiais
		aAdd(aDados, aCpo68) // 68 - Vr Medicamentos
		aAdd(aDados, aCpo69) // 69 - Vr Diarias
		aAdd(aDados, aCpo70) // 70 - Vr Gases Medicinais
		aAdd(aDados, aCpo71)
		// OPM Solicitadas
		aAdd(aDados, aCpo72)
		aAdd(aDados, aCpo73)
		aAdd(aDados, aCpo74)
		aAdd(aDados, aCpo75)
		aAdd(aDados, aCpo76)
		aAdd(aDados, aCpo77)
		// OPM Utilizadas
		aAdd(aDados, aCpo78)
		aAdd(aDados, aCpo79)
		aAdd(aDados, aCpo80)
		aAdd(aDados, aCpo81)
		aAdd(aDados, aCpo82)
		aAdd(aDados, aCpo83)
		aAdd(aDados, aCpo84)
		aAdd(aDados, aCpo85)	 // 85 - Valor Total de OPM
		aAdd(aDados, ctod("")) // dDataBase 86 - Data e Assinatura do Solicitante
		aAdd(aDados, ctod("")) // 87 - Data e Assinatura do Responsavel pela Autorizacao
		aAdd(aDados, ctod("")) // 88 - Data e Assinatura do Beneficiario ou Responsavel
		//If BEA->BEA_ORIGEM == "1"
		//aAdd(aDados, dDataBase) // 89 - Data e Assinatura do Prestador Executante
		//Else
		   aAdd(aDados, ctod("")) // 89 - Data e Assinatura do Prestador Executante
		//Endif
	Else
	MsgInfo("Guia Originada da Internação, para Impressão ir a Rotina de Internação.") //"Guia Originada da Internação, para Impressão ir a Rotina de Internação."
	EndIf

Return aDados

//-------------------------------------------------------------------
/*/{Protheus.doc} PLSGREGL
Estrutura para montar a guia de recurso de glosa

@author  PLS TEAM
@version P11
@since   25.09.15
/*/
//-------------------------------------------------------------------
User Function CABGREGL()
local nTotRec:= 0
local nTotAca:= 0
local aDados := {}
local aCpo19 := {}
local aCpo20 := {}
local aCpo21 := {}
local aCpo22 := {}
local aCpo23 := {}
local aCpo24 := {}
local aCpo25 := {}
local aCpo26 := {}
local aCpo27 := {}
local aCpo28 := {}
local aCpo29 := {}

aDados := {}

//Posiciona Operadora
BA0->(dbSetOrder(1))
BA0->(dbSeek(xFilial("BA0")+B4D->B4D_OPEUSR))

// Cabecalho
aAdd(aDados, BA0->BA0_SUSEP) 	// 1
aAdd(aDados, B4D->(B4D_OPEMOV+"."+B4D_ANOAUT+"."+B4D_MESAUT+"-"+B4D_NUMAUT)) // 2
aAdd(aDados, BA0->BA0_NOMINT) 	// 3
aAdd(aDados, B4D->B4D_OBJREC) 	// 4
aAdd(aDados, Transform(allTrim(B4D->(B4D_OPEMOV+B4D_NGLOPE)), "@R 9999.9999.99-99999999")) 	// 5
aAdd(aDados, B4D->B4D_CODRDA) 	// 6

//Posiciona Rede de Atendimento
BAU->(dbSetOrder(1))
BAU->(dbSeek(xFilial("BAU")+B4D->B4D_CODRDA))

aAdd(aDados, BAU->BAU_NOME) 	// 7
aAdd(aDados, B4D->B4D_NUMLOT) 	// 8
aAdd(aDados, B4D->B4D_CODPEG) 	// 9
aAdd(aDados, B4D->B4D_GLOPRT) 	// 10
aAdd(aDados, B4D->B4D_JUSPRO) 	// 11
aAdd(aDados, B4D->B4D_ACAPRO) 	// 12
aAdd(aDados, B4D->B4D_GUIPRE) 	// 13
aAdd(aDados, B4D->B4D_ATROPE) 	// 14
aAdd(aDados, B4D->B4D_SENHA)	// 15
aAdd(aDados, B4D->B4D_GLOGUI) 	// 16
aAdd(aDados, B4D->B4D_JUSGUI) 	// 17
aAdd(aDados, B4D->B4D_ACAGUI) 	// 18

BR8->(dbSetOrder(1))//BR8_FILIAL+BR8_CODPAD+BR8_CODPSA+BR8_ANASIN
B4E->(dbSetOrder(1))//B4E_FILIAL+B4E_OPEMOV+B4E_ANOAUT+B4E_MESAUT+B4E_NUMAUT+B4E_SEQUEN

cChave := xFilial("B4E")+B4D->(B4D_OPEMOV+B4D_ANOAUT+B4D_MESAUT+B4D_NUMAUT)

if B4E->(dbSeek(cChave))

	do while !B4E->(eof()) .and. cChave == B4E->(B4E_FILIAL+B4E_OPEMOV+B4E_ANOAUT+B4E_MESAUT+B4E_NUMAUT)

		aAdd(aCpo19, B4E->B4E_DATPRO)	// 19
	  	aAdd(aCpo20, B4E->B4E_DATFIN) 	// 20
		aAdd(aCpo21, B4E->B4E_CODPAD) 	// 21
		aAdd(aCpo22, B4E->B4E_CODPRO) 	// 22

		BR8->( dbSeek( xFilial("BR8") + B4E->(B4E_CODPAD+B4E_CODPRO) ) )

		aAdd(aCpo23, BR8->BR8_DESCRI) 	// 23
		aAdd(aCpo24, B4E->B4E_GRAUPA) 	// 24
		aAdd(aCpo25, B4E->B4E_GLOTIS) 	// 25

		aAdd(aCpo26, B4E->B4E_VLRREC) 	// 26
		aAdd(aCpo27, B4E->B4E_JUSPRE) 	// 27
		aAdd(aCpo28, B4E->B4E_VLRACA) 	// 28
		aAdd(aCpo29, B4E->B4E_JUSOPE) 	// 29

		nTotRec += B4E->B4E_VLRREC
		nTotAca += B4E->B4E_VLRACA

	B4E->(dbSkip())
	endDo

	// 19 a 29
	aAdd(aDados, aCpo19)
	aAdd(aDados, aCpo20)
	aAdd(aDados, aCpo21)
	aAdd(aDados, aCpo22)
	aAdd(aDados, aCpo23)
	aAdd(aDados, aCpo24)
	aAdd(aDados, aCpo25)
	aAdd(aDados, aCpo26)
	aAdd(aDados, aCpo27)
	aAdd(aDados, aCpo28)
	aAdd(aDados, aCpo29)

	aAdd(aDados, nTotRec) 	// 30
	aAdd(aDados, nTotAca) 	// 31
	aAdd(aDados, B4D->B4D_DATREC) // 32
	aAdd(aDados, '') 		// 33
	aAdd(aDados, date()) 	// 34
	aAdd(aDados, '') 		// 35
endIf

return aDados

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡ao    ?PLSGINT   ?Autor ?Luciano Aparecido     ?Data ?15.01.07 ³±?
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡ao ?Dados Relatório TISS (Guia Solicitação e Resumo Internação )³±?
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±?Uso      ?SigaPLS                                                     ³±?
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros?nGuia ( Informe 1- Guia de Solicitação e 2-Guia de Resumo ) ³±?
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function CABGINT(nGuia)

	Local lImpNAut	:= IIf(GetNewPar("MV_PLNAUT",0) == 0, .F., .T.) // 0 = Nao imprime procedimento nao autorizado 1 = Sim imprime
	Local aDados    := {}
	Local aCpo34, aCpo35, aCpo36, aCpo37, aCpo38
	Local aCpo45, aCpo46, aCpo47, aCpo48, aCpo49, aCpo50, aCpo51, aCpo52, aCpo53, aCpo54
	Local aCpo55, aCpo56, aCpo57, aCpo58, aCpo59, aCpo60, aCpo61, aCpo62, aCpo63, aCpo64, aCpo65, aCpo66, aCpo67, aCpo68, aCpo69, aCpo70, aCpo71
	Local nVrProc
	Local nVrMater
	Local nVrMedic
	Local nVrTaxas
	Local nVrDiar
	Local nVrGases
	Local nTotGer
	Local nInd
	Local cTipNas
	Local nQtdAut
	Local lImpCID  := GetMV( "MV_PLSICID" ,, .T. )
	Local cTissVer := "2.02.03"

	If FindFunction("PLSA443")
		cTissVer := PLSTISSVER()
	EndIf

	aDados := {}

	If !Empty(cTissVer) .AND. cTissVer >= "3"
		If nGuia == 1
			aDados := PL446DAD("3")
			
			if len(aDados) > 0 
				aDados[5] = BE4->BE4_SENHA
			endif 
		ElseiF nGuia == 2
			aDados := PL446DAD("5")
		Else
	   		aDados := PL446DAD("11")
		EndIf
		Return(aDados)
	EndIf

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//?Posiciona Operadora										     ?
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	BA0->(dbSetOrder(1))
	BA0->(dbSeek(xFilial("BA0")+ BE4->(BE4_OPEUSR)))
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//?Posiciona Padrao de Acomoda‡„o                               ?
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	BI4->(dbSetOrder(1))
	BI4->(dbSeek(xFilial("BI4")+BE4->BE4_PADINT))
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//?Posiciona Usuario                                            ?
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	BA1->(dbSetOrder(2))
	BA1->(dbSeek(xFilial("BA1")+BE4->(BE4_OPEUSR+BE4_CODEMP+BE4_MATRIC+BE4_TIPREG)))
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//?Posiciona Familias/Usuarios                                  ?
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	BA3->(dbSetOrder(1))
	BA3->(dbSeek(xFilial("BA3")+BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC)))
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//?Posiciona Empresa                                            ?
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	BG9->(dbSetOrder(1))
	BG9->(dbSeek( xFilial("BG9")+BA1->(BA1_CODINT+BA1_CODEMP) )  )
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//?Posiciona Produtos de Saude - Plano                          ?
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	BI3->(dbSetOrder(1))
	If !Empty(BA1->BA1_CODPLA)
		BI3->(dbSeek(xFilial("BI3")+BA1->(BA1_CODINT+BA1_CODPLA+BA1_VERSAO)))
	Else
		BI3->(dbSeek(xFilial("BI3")+BA3->(BA3_CODINT+BA3_CODPLA+BA3_VERSAO)))
	Endif
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//?Posiciona Rede de Atendimento								 ?
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	BAU->(dbSetOrder(1))
	BAU->(dbSeek(xFilial("BAU")+BE4->BE4_CODRDA))
   	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//?Posiciona Especialidade                                      ?
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	BAQ->(dbSetOrder(1))
	BAQ->(MsSeek(xFilial("BAQ")+BE4->(BE4_CODOPE+BE4_CODESP)))

	If nGuia == 1 // Guia de Solicitacao de Internacao
		// Cabecalho
		aAdd(aDados, BA0->BA0_SUSEP) // 1
		aAdd(aDados, BE4->(BE4_CODOPE+"."+BE4_ANOINT+"."+BE4_MESINT+"-"+BE4_NUMINT)) // 2
		aAdd(aDados, BE4->BE4_DATPRO) // 3 estara em branco na solicitacao porem apos o usuario internar sera preenchido
		aAdd(aDados, BE4->BE4_SENHA) // 4
		aAdd(aDados, BE4->BE4_DATVAL) // 5
		aAdd(aDados, BE4->BE4_DTDIGI) // 6
		// Dados do Beneficiario
		If BA1->BA1_CODINT == BA1->BA1_OPEORI .Or. empty(BA1->BA1_MATANT)
			aAdd(aDados, BA1->(BA1_CODINT+"."+BA1_CODEMP+"."+BA1_MATRIC+"."+BA1_TIPREG+"-"+BA1_DIGITO)) // 7
		Else
			aAdd(aDados, BA1->BA1_MATANT) // 7
		EndIf
		aAdd(aDados, BI3->BI3_NREDUZ) // 8
		aAdd(aDados, BA1->BA1_DTVLCR) // 9
		// Caso seja Recem nascido imprime na frente do nome a mensagem "Atendimento Recem Nascido"
		If BE4->BE4_ATERNA <> '1'
			aAdd(aDados, BA1->BA1_NOMUSR) // 10
		Else
			aAdd(aDados, AllTrim(BA1->BA1_NOMUSR) + " ("+"Atendimento Recém Nascido"+")") // 10 //"Atendimento Recém Nascido"
		EndIf
		aAdd(aDados, BTS->BTS_NRCRNA) // 11
		// Dados do Contratado Solicitante

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//?Posiciona Medico Solicitante                                 ?
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		BB0->(dbSetOrder(4) )
		BB0->(dbSeek(xFilial("BB0")+BE4->(BE4_ESTSOL+BE4_REGSOL+BE4_SIGLA)))
		If  BEA->(FieldPos("BEA_RDACON")) > 0 .and. !Empty(BE4->BE4_RDACON)
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//?Salva Recnos												 ?
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			nRecBAU := BAU->(Recno())
			nOrdBAU := BAU->(IndexOrd())

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//?Posiciona Rede de Atendimento                                ?
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			BAU->(dbSetOrder(1))
			BAU->(dbSeek(xFilial("BAU")+BE4->BE4_RDACON))

			aAdd(aDados, IIf(BAU->BAU_TIPPE == "F", Transform(BAU->BAU_CPFCGC, "@R 999.999.999-99"), Transform(BAU->BAU_CPFCGC, "@R 99.999.999/9999-99"))) // 12
			aAdd(aDados, BAU->BAU_NOME) // 13

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//?Posiciona registros											 ?
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			BAU->(DbSetOrder(nOrdBAU))
			BAU->(DbGoTo(nRecBAU))
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//?Como no nosso sistema não existe local de atendimento para   ?
			//| o contratado solicitante, o CNES esta sendo enviado em branco|
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			BB8->(dbSetOrder(1))
			BB8->(dbSeek(xFilial("BB8")+BE4->(BE4_CODRDA+BE4_CODOPE+BE4_CODLOC)))
			aAdd(aDados, Transform('', cPicCNES)) // 14
		Else
			aAdd(aDados, IIf(Len(AllTrim(BB0->BB0_CGC)) == 11, Transform(BB0->BB0_CGC, "@R 999.999.999-99"), Transform(BB0->BB0_CGC, "@R 99.999.999/9999-99"))) // 12
			aAdd(aDados, BB0->BB0_NOME) // 13
			BB8->(dbSetOrder(1))
			BB8->(dbSeek(xFilial("BB8")+BE4->(BE4_CODRDA+BE4_CODOPE+BE4_CODLOC)))
			aAdd(aDados, Transform(BB8->BB8_CNES, cPicCNES)) // 14
		Endif

		aAdd(aDados, BE4->BE4_NOMSOL) // 15
		aAdd(aDados, BE4->BE4_SIGLA) // 16
		aAdd(aDados, BE4->BE4_REGSOL) // 17
		aAdd(aDados, BE4->BE4_ESTSOL) // 18
		aAdd(aDados, BAQ->BAQ_CBOS) // 19
		// Dados do Contratato Solicitado / Dados da Internacao
		aAdd(aDados, IIf(Len(AllTrim(BAU->BAU_CPFCGC)) == 11, Transform(BAU->BAU_CPFCGC, "@R 999.999.999-99"), Transform(BAU->BAU_CPFCGC, "@R 99.999.999/9999-99"))) // 20
		aAdd(aDados, BAU->BAU_NOME) // 21
		BDR->(dbSetOrder(1)) // BDR_FILIAL + BDR_CODOPE + BDR_CODTAD
		BDR->(MsSeek(xFilial("BDR")+BE4->(BE4_CODOPE+BE4_TIPADM)))
		aAdd(aDados, BDR->BDR_CARINT) // 22
		If ExistBlock("PLS500EX")
		   cTipInt := ExecBlock("PLS500EX",.F.,.F.,{ BE4->BE4_GRPINT, BE4->BE4_TIPINT })
		Else
			If BQR->(FieldPos("BQR_CODEDI")) > 0
				BQR->(dbSetOrder(1))
				If BQR->(MsSeek(xFilial("BQR")+BE4->(BE4_GRPINT+BE4_TIPINT)))
					cTipInt := AllTrim(BQR->BQR_CODEDI)
				Else
					cTipInt := " "
				EndIf
			Else
			   	Do Case
			      Case BE4->BE4_GRPINT == "1" .And. BE4->BE4_TIPINT == "01"
			           cTipInt := "1" // Internacao Clinica
		    	  Case BE4->BE4_GRPINT == "1" .And. BE4->BE4_TIPINT == "02"
			           cTipInt := "6" // Pediatrica
			      Case BE4->BE4_GRPINT == "1" .And. BE4->BE4_TIPINT == "03"
			           cTipInt := "7" // Psiquiatrica
			      Case BE4->BE4_GRPINT == "1" .And. BE4->BE4_TIPINT == "05"
			           cTipInt := "3" // Internacao Obstetrica
			      Case BE4->BE4_GRPINT == "1" .And. BE4->BE4_TIPINT == "06"
		    	       cTipInt := "4" // Hospital Dia
			      Case BE4->BE4_GRPINT == "1" .And. BE4->BE4_TIPINT == "07"
			           cTipInt := "5" // Domiciliar
			      Case BE4->BE4_GRPINT == "2" .And. BE4->BE4_TIPINT == "01"
			           cTipInt := "2" // Internacao Cirurgica
			      Case BE4->BE4_GRPINT == "2" .And. BE4->BE4_TIPINT == "03"
			           cTipInt := "3" // Internacao Obstetrica
		    	  Otherwise
		        	   cTipInt := BE4->BE4_GRPINT + "." + BE4->BE4_TIPINT
			   	EndCase
			EndIf
		EndIf

		// Retiradas as opcoes de dominio 4 - Hospital dia (devera ser identificado atraves da diaria existente na Tabela C do Anexo 01) e
		// 5 - Domiciliar (devera ser criada uma diaria para essa finalidade) -- CONFORME MANUAL PTU
		// Desta forma, se faz necessario ajustar o codigo do tipo de internacao.
		If cTipInt == "6"
			cTipInt := "4" // Pediatrica
		ElseIf cTipInt == "7"
			cTipInt := "5" // Psiquiatrica
		EndIf
		aAdd(aDados, cTipInt) // 23
		aAdd(aDados, BE4->BE4_REGINT) // 24
		aAdd(aDados, BE4->BE4_DIASSO) // 25
		aAdd(aDados, AllTrim(BE4->BE4_INDCLI)+" "+AllTrim(BE4->BE4_INDCL2)) // 26
		// Hipoteses Diagnosticas
		aAdd(aDados, BE4->BE4_TIPDOE) // 27
		aAdd(aDados, { BE4->BE4_TPODOE, BE4->BE4_UTPDOE } ) // 28
		aAdd(aDados, BE4->BE4_INDACI) // 29
		// Verifica se Imprime CID na Guia
		aAdd( aDados , IIf( lImpCID , BE4->BE4_CID		, " " ) ) // 30 - Cid Principal
		aAdd( aDados , IIf( lImpCID , BE4->BE4_CIDSEC	, " " ) ) // 31 - Cid 02
		aAdd( aDados , IIf( lImpCID , BE4->BE4_CID3		, " " ) ) // 32 - Cid 03
		aAdd( aDados , IIf( lImpCID , BE4->BE4_CID4		, " " ) ) // 33 - Cid 04
		// Procedimentos Solicitados
		aCpo34 := {}
		aCpo35 := {}
		aCpo36 := {}
		aCpo37 := {}
		aCpo38 := {}
		aCpo39 := {}
		aCpo40 := {}
		aCpo41 := {}
		aCpo42 := {}
		aCpo43 := {}
		aCpo44 := {}
		BEJ->(dbSetOrder(1))
		If BEJ->(dbSeek(xFilial("BEJ")+BE4->(BE4_CODOPE+BE4_ANOINT+BE4_MESINT+BE4_NUMINT)))
			Do While ! BEJ->(Eof()) .And. BEJ->(BEJ_FILIAL+BEJ_CODOPE+BEJ_ANOINT+BEJ_MESINT+BEJ_NUMINT) == ;
		                               xFilial("BEJ")+BE4->(BE4_CODOPE+BE4_ANOINT+BE4_MESINT+BE4_NUMINT)
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³Nao imprime procedimento negado	conforme parametro			 ?
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				If !lImpNAut .And. BEJ->BEJ_STATUS == "0"
					BEJ->(dbSkip())
					Loop
				EndIf
				BR8->(dbSetOrder(1))
				BR8->(dbSeek(xFilial("BR8")+BEJ->(BEJ_CODPAD+BEJ_CODPRO)))
				If BR8->BR8_TPPROC == "5" // OPM (Orteses, Proteses e Materiais Especiais)
					BD6->(dbSetOrder(1))
	 				BD6->(MsSeek(xFilial("BD6")+BE4->(BE4_CODOPE+BE4_CODLDP+BE4_CODPEG+BE4_NUMERO+BE4_ORIMOV)+BEJ->(BEJ_SEQUEN+BEJ_CODPAD+BEJ_CODPRO)))
		   			aAdd(aCpo39,Posicione("BF8", 2, xFilial("BF8")+BD6->(BD6_CODPAD+BD6_CODOPE+BD6_CODTAB), "BF8_TABTIS"))//39
					aAdd(aCpo40, PLSPICPRO(BEJ->BEJ_CODPAD, BEJ->BEJ_CODPRO))
					aAdd(aCpo41, BEJ->BEJ_DESPRO)
					aAdd(aCpo42, BEJ->BEJ_QTDSOL)
					aAdd(aCpo43, BR8->BR8_FABRIC)
					BD6->(dbSetOrder(1))
					If BD6->(MsSeek(xFilial("BD6")+BE4->(BE4_CODOPE+BE4_CODLDP+BE4_CODPEG+BE4_NUMERO+BE4_ORIMOV)+BEJ->BEJ_SEQUEN)).And. GetNewPar("MV_VLTISS","1")=="1"
						aAdd(aCpo44, Round(BD6->BD6_VLRPAG / BD6->BD6_QTDPRO, 2))
					Else
						aAdd(aCpo44, 0)
					EndIf
				Else

					BD6->(dbSetOrder(1))
	 				BD6->(MsSeek(xFilial("BD6")+BE4->(BE4_CODOPE+BE4_CODLDP+BE4_CODPEG+BE4_NUMERO+BE4_ORIMOV)+BEJ->(BEJ_SEQUEN+BEJ_CODPAD+BEJ_CODPRO)))
		   	        aAdd(aCpo34,Posicione("BF8", 2, xFilial("BF8")+BD6->(BD6_CODPAD+BD6_CODOPE+BD6_CODTAB), "BF8_TABTIS"))//34
		  			//aAdd(aCpo34, BEJ->BEJ_CODPAD)
					aAdd(aCpo35, PLSPICPRO(BEJ->BEJ_CODPAD, BEJ->BEJ_CODPRO))
					aAdd(aCpo36, BEJ->BEJ_DESPRO)
					aAdd(aCpo37, BEJ->BEJ_QTDSOL)
					if BE4->BE4_STATUS == "3" .OR. BEJ->BEJ_STATUS == "0"
						aAdd(aCpo38, 0)
					Else
						aAdd(aCpo38, BEJ->BEJ_QTDPRO)
				    Endif
				EndIf
				BEJ->(dbSkip())
			EndDo
		EndIf
		aAdd(aDados, aCpo34)
		aAdd(aDados, aCpo35)
		aAdd(aDados, aCpo36)
		aAdd(aDados, aCpo37)
		aAdd(aDados, aCpo38)
		// OPM Solicitadas
		aAdd(aDados, aCpo39)
		aAdd(aDados, aCpo40)
		aAdd(aDados, aCpo41)
		aAdd(aDados, aCpo42)
		aAdd(aDados, aCpo43)
		aAdd(aDados, aCpo44)
		// Dados da Autorizacao
		aAdd(aDados, BE4->BE4_PRVINT)  // 45
		aAdd(aDados, BE4->BE4_DIASIN)  // 46
		BN5->(dbSetOrder(1))
		BN5->(MsSeek(xFilial("BN5")+BE4->(BE4_OPEUSR+BE4_PADCON)))
		aAdd(aDados, { BN5->BN5_CODEDI, BN5->BN5_NOMEDI }) // 47
		aAdd(aDados, IIf(Len(AllTrim(BAU->BAU_CPFCGC)) == 11, Transform(BAU->BAU_CPFCGC, "@R 999.999.999-99"), Transform(BAU->BAU_CPFCGC, "@R 99.999.999/9999-99"))) // 48
		aAdd(aDados, BAU->BAU_NOME) // 49
		BB8->(dbSetOrder(1))
		BB8->(dbSeek(xFilial("BB8")+BE4->(BE4_CODRDA+BE4_CODOPE+BE4_CODLOC)))
		aAdd(aDados, Transform(BB8->BB8_CNES, cPicCNES)) // 50
		aAdd(aDados, AllTrim(BE4->BE4_MSG01) + " " + AllTrim(BE4->BE4_MSG02) + " " + AllTrim(BE4->BE4_MSG03)) // 51
		aAdd(aDados, StoD("")) // 52
		aAdd(aDados, StoD("")) // 53
		aAdd(aDados, StoD("")) // 54

		// Prorrogacoes
		If BQV->( FieldPos("BQV_DATPRO") ) > 0
			cSQL    := "SELECT BQV_SEQUEN, BQV_CODPAD, BQV_CODPRO, BQV_DATPRO, BQV_RESAUT, BQV_QTDPRO, BQV_QTDSOL, BQV_OPEUSR, BQV_PADCON, BQV_SENHA, BQV_STATUS "
		Else
			cSQL    := "SELECT BQV_SEQUEN, BQV_CODPAD, BQV_CODPRO, BQV_DTENTR, BQV_RESAUT, BQV_QTDPRO, BQV_QTDSOL, BQV_OPEUSR, BQV_PADCON, BQV_SENHA, BQV_STATUS "
		EndIf
		cSQL    += "  FROM " + RetSQLName("BQV")
		cSQL    += " WHERE BQV_FILIAL = '" + xFilial("BQV") + "'"
		cSQL    += "   AND BQV_CODOPE = '" + BE4->BE4_CODOPE + "'"
		cSQL    += "   AND BQV_ANOINT = '" + BE4->BE4_ANOINT + "'"
		cSQL    += "   AND BQV_MESINT = '" + BE4->BE4_MESINT + "'"
		cSQL    += "   AND BQV_NUMINT = '" + BE4->BE4_NUMINT + "'"
		cSQL    += "   AND D_E_L_E_T_ = ' '"
		If BQV->( FieldPos("BQV_DATPRO") ) > 0
			cSQL    += " ORDER BY BQV_DATPRO, BQV_SEQUEN, BQV_SENHA, BQV_RESAUT, BQV_PADCON "
		Else
			cSQL    += " ORDER BY BQV_DTENTR, BQV_SEQUEN, BQV_SENHA, BQV_RESAUT, BQV_PADCON "
		EndIf

		BQV->(PLSQuery(cSQL,"TrbBQV"))

		aCpo55 := { }
		aCpo56 := { }
		aCpo57 := { }
		aCpo58 := { }
		aCpo59 := { }
		aCpo60 := { }
		aCpo61 := { }
		aCpo62 := { }
		aCpo63 := { }
		aCpo64 := { }
		aCpo65 := { }
		aCpo66 := { }
		aCpo67 := { }
		aCpo68 := { }
		aCpo69 := { }
		aCpo70 := { }
		aCpo71 := { }
		Do While ! TrbBQV->(Eof())
			If BQV->( FieldPos("BQV_DATPRO") ) > 0
				cChave := TrbBQV->(DtoS(BQV_DATPRO)+BQV_SENHA+BQV_RESAUT+BQV_PADCON)
				aAdd(aCpo55, TrbBQV->BQV_DATPRO)
			Else
				cChave := TrbBQV->(DtoS(BQV_DTENTR)+BQV_SENHA+BQV_RESAUT+BQV_PADCON)
				aAdd(aCpo55, TrbBQV->BQV_DTENTR)
			EndIf
			aAdd(aCpo56, TrbBQV->BQV_SENHA)
			aAdd(aCpo57, TrbBQV->BQV_RESAUT)
			aAdd(aCpo58, "")
			aAdd(aCpo59, "")
			aAdd(aCpo60, "")
			aAdd(aCpo61, {})
			aAdd(aCpo62, {})
			aAdd(aCpo63, {})
			aAdd(aCpo64, {})
			aAdd(aCpo65, {})
			aAdd(aCpo66, {})
			aAdd(aCpo67, {})
			aAdd(aCpo68, {})
			aAdd(aCpo69, {})
			aAdd(aCpo70, {})
			aAdd(aCpo71, {})
			nInd := Len(aCpo55)
			nPos := nInd
			Do While ! TrbBQV->(Eof()) .And. TrbBQV->( Iif( BQV->( FieldPos("BQV_DATPRO") ) > 0,DtoS(BQV_DATPRO),DtoS(BQV_DTENTR) )+BQV_SENHA+BQV_RESAUT+BQV_PADCON) == cChave
				BR8->(dbSetOrder(1))
				BR8->(dbSeek(xFilial("BR8")+TrbBQV->(BQV_CODPAD+BQV_CODPRO)))
				If BR8->BR8_TPPROC == "4" // Diarias
					nQtdAut:=0
					For nInd := nPos To Len(aCpo55)
						BN5->(dbSetOrder(1))
						BN5->(MsSeek(xFilial("BN5")+TrbBQV->(BQV_OPEUSR+BQV_PADCON)))

						If Empty(BN5->BN5_CODEDI)
							aCpo58[nInd] := BE4->BE4_PADINT
							aCpo59[nInd] := Posicione("BI4",1, xFilial("BI4")+BE4->BE4_PADINT,"BI4_DESCRI")
						Else
							aCpo58[nInd] := BN5->BN5_CODEDI
							aCpo59[nInd] := BN5->BN5_NOMEDI
						Endif

						nQtdAut+=TrbBQV->BQV_QTDPRO
						aCpo60[nInd] := nQtdAut

						BD6->(dbSetOrder(1))
	 					BD6->(MsSeek(xFilial("BD6")+BE4->(BE4_CODOPE+BE4_CODLDP+BE4_CODPEG+BE4_NUMERO+BE4_ORIMOV)+TrbBQV->(BQV_SEQUEN+BQV_CODPAD+BQV_CODPRO)))
		   				aAdd(aCpo61[nInd],Posicione("BF8", 2, xFilial("BF8")+BD6->(BD6_CODPAD+BD6_CODOPE+BD6_CODTAB), "BF8_TABTIS"))//61

						aAdd(aCpo62[nInd], PLSPICPRO(TrbBQV->BQV_CODPAD, TrbBQV->BQV_CODPRO))
						aAdd(aCpo63[nInd], BR8->BR8_DESCRI)
						aAdd(aCpo64[nInd], TrbBQV->BQV_QTDSOL)
						aAdd(aCpo65[nInd], If(TrbBQV->BQV_STATUS<>"0",TrbBQV->BQV_QTDPRO,0))
					Next nInd
					nInd := Len(aCpo55)
				Else
					If Len(aCpo61[nInd]) == 2 .Or. Len(aCpo66[nInd]) == 2
						aAdd(aCpo55, aCpo55[nInd])
						aAdd(aCpo56, aCpo56[nInd])
						aAdd(aCpo57, aCpo57[nInd])
						aAdd(aCpo58, aCpo58[nInd])
						aAdd(aCpo59, aCpo59[nInd])
						aAdd(aCpo60, aCpo60[nInd])
						aAdd(aCpo61, {})
						aAdd(aCpo62, {})
						aAdd(aCpo63, {})
						aAdd(aCpo64, {})
						aAdd(aCpo65, {})
						aAdd(aCpo66, {})
						aAdd(aCpo67, {})
						aAdd(aCpo68, {})
						aAdd(aCpo69, {})
						aAdd(aCpo70, {})
						aAdd(aCpo71, {})
						nInd := Len(aCpo55)
					EndIf
					If BR8->BR8_TPPROC == "5" // OPM (Orteses, Proteses e Materiais Especiais)
						BD6->(dbSetOrder(1))
	 					BD6->(MsSeek(xFilial("BD6")+BE4->(BE4_CODOPE+BE4_CODLDP+BE4_CODPEG+BE4_NUMERO+BE4_ORIMOV)+TrbBQV->(BQV_SEQUEN+BQV_CODPAD+BQV_CODPRO)))
		   				aAdd(aCpo66[nInd],Posicione("BF8", 2, xFilial("BF8")+BD6->(BD6_CODPAD+BD6_CODOPE+BD6_CODTAB), "BF8_TABTIS"))//66
					   //	aAdd(aCpo66[nInd], TrbBQV->BQV_CODPAD)
						aAdd(aCpo67[nInd], PLSPICPRO(TrbBQV->BQV_CODPAD, TrbBQV->BQV_CODPRO))
						aAdd(aCpo68[nInd], BR8->BR8_DESCRI)
						aAdd(aCpo69[nInd], TrbBQV->BQV_QTDSOL)
						aAdd(aCpo70[nInd], BR8->BR8_FABRIC)
						if GetNewPar("MV_VLTISS","1")=="1"
							aAdd(aCpo71[nInd], Round(BD6->BD6_VLRPAG / BD6->BD6_QTDPRO, 2))
					    Else
					    	aAdd(aCpo71[nInd],0)
					    Endif
					Else //BR8->BR8_TPPROC <> "4" // Diarias
						BD6->(dbSetOrder(1))
	 				  	BD6->(MsSeek(xFilial("BD6")+BE4->(BE4_CODOPE+BE4_CODLDP+BE4_CODPEG+BE4_NUMERO+BE4_ORIMOV)+TrbBQV->(BQV_SEQUEN+BQV_CODPAD+BQV_CODPRO)))
		   			   	aAdd(aCpo61[nInd],Posicione("BF8", 2, xFilial("BF8")+BD6->(BD6_CODPAD+BD6_CODOPE+BD6_CODTAB), "BF8_TABTIS"))//61
						aAdd(aCpo62[nInd], PLSPICPRO(TrbBQV->BQV_CODPAD, TrbBQV->BQV_CODPRO))
						aAdd(aCpo63[nInd], BR8->BR8_DESCRI)
						aAdd(aCpo64[nInd], TrbBQV->BQV_QTDSOL)
						aAdd(aCpo65[nInd], If(TrbBQV->BQV_STATUS<>"0",TrbBQV->BQV_QTDPRO,0) )
					EndIf
				EndIf
				TrbBQV->(dbSkip())
			EndDo
		EndDo
		TrbBQV->(dbCloseArea())
		aAdd(aDados, aCpo55)
		aAdd(aDados, aCpo56)
		aAdd(aDados, aCpo57)
		aAdd(aDados, aCpo58)
		aAdd(aDados, aCpo59)
		aAdd(aDados, aCpo60)
		aAdd(aDados, aCpo61)
		aAdd(aDados, aCpo62)
		aAdd(aDados, aCpo63)
		aAdd(aDados, aCpo64)
		aAdd(aDados, aCpo65)
		aAdd(aDados, aCpo66)
		aAdd(aDados, aCpo67)
		aAdd(aDados, aCpo68)
		aAdd(aDados, aCpo69)
		aAdd(aDados, aCpo70)
		aAdd(aDados, aCpo71)
	ElseIf nGuia == 2 // Guia de Resumo de Internacao
		// Cabecalho
		aAdd(aDados, BA0->BA0_SUSEP) // 1
		aAdd(aDados, BE4->(BE4_CODOPE+"."+BE4_ANOINT+"."+BE4_MESINT+"-"+BE4_NUMINT)) // 2
		aAdd(aDados, BE4->(BE4_CODOPE+"."+BE4_CODLDP+"."+BE4_CODPEG+"-"+BE4_NUMERO)) // 3
		aAdd(aDados, BE4->BE4_DATPRO) // 4
		aAdd(aDados, BE4->BE4_SENHA) // 5
		aAdd(aDados, BE4->BE4_DATVAL) // 6
		aAdd(aDados, BE4->BE4_DTDIGI) // 7
		// Dados do Beneficiario
		If BA1->BA1_CODINT == BA1->BA1_OPEORI .Or. empty(BA1->BA1_MATANT)
			aAdd(aDados, BA1->(BA1_CODINT+"."+BA1_CODEMP+"."+BA1_MATRIC+"."+BA1_TIPREG+"-"+BA1_DIGITO)) // 8
		Else
			aAdd(aDados, BA1->BA1_MATANT) // 8
		EndIf
		aAdd(aDados, BI3->BI3_NREDUZ) // 9
		aAdd(aDados, BA1->BA1_DTVLCR) // 10
		// Caso seja Recem nascido imprime na frente do nome a mensagem "Atendimento Recem Nascido"
		If BE4->BE4_ATERNA <> '1'    //Recem Nascido 1-Sim 0-Nao
			aAdd(aDados, BA1->BA1_NOMUSR) // 11
		Else
			aAdd(aDados, AllTrim(BA1->BA1_NOMUSR) + " ("+"Atendimento Recém Nascido"+")") // 11
		EndIf
		aAdd(aDados, BTS->BTS_NRCRNA) // 12
		// Dados do Contratado Executante
		aAdd(aDados, IIf(Len(AllTrim(BAU->BAU_CPFCGC)) == 11, Transform(BAU->BAU_CPFCGC, "@R 999.999.999-99"), Transform(BAU->BAU_CPFCGC, "@R 99.999.999/9999-99"))) // 13
		aAdd(aDados, BAU->BAU_NOME) // 14
		BB8->(dbSetOrder(1))
		BB8->(dbSeek(xFilial("BB8")+BE4->(BE4_CODRDA+BE4_CODOPE+BE4_CODLOC)))
		aAdd(aDados, Transform(BB8->BB8_CNES, cPicCNES)) // 15
		aAdd(aDados, BB8->BB8_TIPLOG) // 16
		aAdd(aDados, BB8->BB8_END) // 17
		aAdd(aDados, BB8->BB8_NR_END) // 18
		aAdd(aDados, BB8->BB8_COMEND) // 19
		aAdd(aDados, BB8->BB8_MUN) // 20
		aAdd(aDados, BB8->BB8_EST) // 21
		aAdd(aDados, BB8->BB8_CODMUNI) // 22
		aAdd(aDados, Transform(BB8->BB8_CEP, "@R 99999-999")) // 23
		// Dados da Internacao
		BDR->(dbSetOrder(1)) // BDR_FILIAL + BDR_CODOPE + BDR_CODTAD
		BDR->(MsSeek(xFilial("BDR")+BE4->(BE4_CODOPE+BE4_TIPADM)))
		aAdd(aDados, BDR->BDR_CARINT) // 24
		BN5->(dbSetOrder(1))
		BN5->(MsSeek(xFilial("BN5")+BE4->(BE4_OPEUSR+BE4_PADCON)))
		aAdd(aDados, { BN5->BN5_CODEDI, BN5->BN5_NOMEDI }) // 25
		aAdd(aDados, { BE4->BE4_DATPRO, BE4->BE4_HORPRO }) // 26
		aAdd(aDados, { BE4->BE4_DTALTA, BE4->BE4_HRALTA }) // 27
		If ExistBlock("PLS500EX")
		   cTipInt := ExecBlock("PLS500EX",.F.,.F.,{ BE4->BE4_GRPINT, BE4->BE4_TIPINT })
		Else
			If BQR->(FieldPos("BQR_CODEDI")) > 0  //1=Int Clinica;2=Int Cirurgica;3=Int Obstetrica;4=Hospital dia;5=Domiciliar;6=Pediatrica;7=Psiquiatrica
				BQR->(dbSetOrder(1))
				If BQR->(MsSeek(xFilial("BQR")+BE4->(BE4_GRPINT+BE4_TIPINT))) //GRPINT->1=Internacao Clinica;2=Internacao Cirurgica
					cTipInt := AllTrim(BQR->BQR_CODEDI)
				Else
					cTipInt := " "
				EndIf
			Else
			   	Do Case
			      Case BE4->BE4_GRPINT == "1" .And. BE4->BE4_TIPINT == "01"
			           cTipInt := "1" // Internacao Clinica
		    	  Case BE4->BE4_GRPINT == "1" .And. BE4->BE4_TIPINT == "02"
			           cTipInt := "6" // Pediatrica
			      Case BE4->BE4_GRPINT == "1" .And. BE4->BE4_TIPINT == "03"
			           cTipInt := "7" // Psiquiatrica
			      Case BE4->BE4_GRPINT == "1" .And. BE4->BE4_TIPINT == "05"
			           cTipInt := "3" // Internacao Obstetrica
			      Case BE4->BE4_GRPINT == "1" .And. BE4->BE4_TIPINT == "06"
		    	       cTipInt := "4" // Hospital Dia
			      Case BE4->BE4_GRPINT == "1" .And. BE4->BE4_TIPINT == "07"
			           cTipInt := "5" // Domiciliar
			      Case BE4->BE4_GRPINT == "2" .And. BE4->BE4_TIPINT == "01"
			           cTipInt := "2" // Internacao Cirurgica
			      Case BE4->BE4_GRPINT == "2" .And. BE4->BE4_TIPINT == "03"
			           cTipInt := "3" // Internacao Obstetrica
		    	  Otherwise
		        	   cTipInt := BE4->BE4_GRPINT + "." + BE4->BE4_TIPINT
			   	EndCase
			EndIf
		EndIf
		// Retiradas as opcoes de dominio 4 - Hospital dia (devera ser identificado atraves da diaria existente na Tabela C do Anexo 01) e
		// 5 - Domiciliar (devera ser criada uma diaria para essa finalidade) -- CONFORME MANUAL PTU
		// Desta forma, se faz necessario ajustar o codigo do tipo de internacao.
		If cTipInt == "6"
			cTipInt := "4" // Pediatrica
		ElseIf cTipInt == "7"
			cTipInt := "5" // Psiquiatrica
		EndIf
		aAdd(aDados, cTipInt) // 28
		aAdd(aDados, BE4->BE4_REGINT) // 29


		If cTipInt == "3"  // Internacao Obstetrica
			cTipNas := AllTrim(BE4->BE4_TIPNAS)
			aAdd(aDados, {	IIf(cTipNas == "1", "X", ""), ; // Em Gestacao
							IIf(cTipNas == "2", "X", ""), ; // Aborto
							IIf(cTipNas == "6", "X", ""), ; // Transtorno materno relacionado a gravidez
							IIf(cTipNas == "7", "X", ""), ; // Complic. Puerperio
							IIf(cTipNas == "8", "X", ""), ; // Atend. ao RN na sala de parto
							IIf(cTipNas == "9", "X", ""), ; // Complicacao Neonatal
							IIf(cTipNas == "10", "X", ""), ; // Bx. Peso < 2,5 Kg
							IIf(cTipNas == "11", "X", ""), ; // Parto Cesareo
							IIf(cTipNas == "12", "X", ""), ; // Parto Normal
														 }) // 30
			aAdd(aDados, BE4->BE4_OBTMUL) // 31
			aAdd(aDados, { BE4->BE4_OBTPRE, BE4->BE4_OBTTAR }) // 32
			aAdd(aDados, BE4->BE4_NRDCNV) // 33
   			aAdd(aDados, BE4->BE4_NASVIV) // 34
			aAdd(aDados, BE4->BE4_NASMOR) // 35
			aAdd(aDados, BE4->BE4_NASVPR) // 36
		Else
			aAdd(aDados, { "", "", "", "", "", "", "", "", "" }) // 30 Internacao Obstetrica
			aAdd(aDados, "") // 31 Se Obito em Mulher
			aAdd(aDados, { 0, 0 } ) // 32 Obito Neonatal precoce / Tardio
			aAdd(aDados, "") // 33 Nr Declaracao Nasc Vivos
			aAdd(aDados, 0) // 34 Nascidos Vivos a Termo
			aAdd(aDados, 0) // 35 Nascidos Mortos
			aAdd(aDados, 0) // 36 Nascidos Vivos Prematuros
		EndIf

		// Verifica se Imprime CID nas Guias
		aAdd(aDados, IIf( lImpCID , BE4->BE4_CID		, " " ) ) // 37 - Cid Principal
		aAdd(aDados, IIf( lImpCID , BE4->BE4_CIDSEC	, " " ) ) // 38 - Cid 02
		aAdd(aDados, IIf( lImpCID , BE4->BE4_CID3		, " " ) ) // 39 - Cid 03
		aAdd(aDados, IIf( lImpCID , BE4->BE4_CID4		, " " ) ) // 40 - Cid 04
		// Dados do Resumo da Internacao
		aAdd(aDados, BE4->BE4_INDACI) // 41
		BIY->(dbsetOrder(1))
		BIY->(msSeek(xFilial("BIY")+BE4->(BE4_CODOPE+BE4_TIPALT)))
  		 aAdd(aDados, BIY->BIY_MOTSAI) // 42
		//	aAdd(aDados, BE4->BE4_TIPALT) // 42
		aAdd(aDados, BE4->BE4_CIDOBT) // 43
		aAdd(aDados, BE4->BE4_NRDCOB) // 44
		// Procedimentos e Exames Realizados
		aCpo45 := {}
		aCpo46 := {}
		aCpo47 := {}
		aCpo48 := {}
		aCpo49 := {}
		aCpo50 := {}
		aCpo51 := {}
		aCpo52 := {}
		aCpo53 := {}
		aCpo54 := {}
		aCpo55 := {}
		aCpo56 := {}
		aCpo57 := {}
		aCpo58 := {}
		aCpo59 := {}
		aCpo60 := {}
		aCpo61 := {}
		aCpo62 := {}
		aCpo63 := {}
		aCpo64 := {}
		aCpo65 := {}
		aCpo66 := {}
		aCpo67 := {}
		aCpo68 := {}
		aCpo69 := {}
		aCpo70 := {}
		aCpo71 := {}
		nTotGer  := 0
		nVrProc  := 0
		nVrMater := 0
		nVrMedic := 0
		nVrTaxas := 0
		nVrDiar  := 0
		nVrGases := 0
		BEJ->(dbSetOrder(1))
		If BEJ->(dbSeek(xFilial("BEJ")+BE4->(BE4_CODOPE+BE4_ANOINT+BE4_MESINT+BE4_NUMINT)))

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//?Posiciona Vias de Acesso                                     ?
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			BGR->(dbSetOrder(1))
			BGR->(MsSeek(xFilial("BGR")+BEJ->(BEJ_CODOPE+BEJ_VIA)))
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//?Posiciona Tabela Padrao                                      ?
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			BR8->(dbSetOrder(1))
			BR8->(dbSeek(xFilial("BR8")+BEJ->(BEJ_CODPAD+BEJ_CODPRO)))

			BD6->(dbSetOrder(1))
			If BD6->(MsSeek(xFilial("BD6")+BE4->(BE4_CODOPE+BE4_CODLDP+BE4_CODPEG+BE4_NUMERO+BE4_ORIMOV)))
			    Do While ! BD6->(Eof()) .And. BD6->(BD6_FILIAL+BD6_CODOPE+BD6_CODLDP+BD6_CODPEG+BD6_NUMERO+BD6_ORIMOV) == ;
		                           			xFilial("BD6")+BE4->(BE4_CODOPE+BE4_CODLDP+BE4_CODPEG+BE4_NUMERO+BE4_ORIMOV)

					If BR8->BR8_TPPROC == "5" // OPM (Orteses, Proteses e Materiais Especiais)

						aAdd(aCpo65, Posicione("BF8", 2, xFilial("BF8")+BD6->(BD6_CODPAD+BD6_CODOPE+BD6_CODTAB), "BF8_TABTIS"))
						aAdd(aCpo66, PLSPICPRO(BD6->BD6_CODPAD, BD6->BD6_CODPRO))
						aAdd(aCpo67, BD6->BD6_DESPRO)
						aAdd(aCpo68, BD6->BD6_QTDPRO)
						aAdd(aCpo69, BR8->BR8_CODBAR)
						if GetNewPar("MV_VLTISS","1")=="1"
							aAdd(aCpo70, Round(BD6->BD6_VLRPAG / BD6->BD6_QTDPRO, 2))
							aAdd(aCpo71, BD6->BD6_VLRPAG)
						else
							aAdd(aCpo70, 0)
							aAdd(aCpo71, 0)
						Endif
					Else
						aAdd(aCpo45, BD6->BD6_DATPRO)
						aAdd(aCpo46, BD6->BD6_HORPRO)
						aAdd(aCpo47, BD6->BD6_HORFIM)
						aAdd(aCpo48,Posicione("BF8", 2, xFilial("BF8")+BD6->(BD6_CODPAD+BD6_CODOPE+BD6_CODTAB), "BF8_TABTIS"))
					   //	aAdd(aCpo48, BD6->BD6_CODPAD)
						aAdd(aCpo49, PLSPICPRO(BD6->BD6_CODPAD, BD6->BD6_CODPRO))
						aAdd(aCpo50, BD6->BD6_DESPRO)
						aAdd(aCpo51, BD6->BD6_QTDPRO)
						aAdd(aCpo52, BGR->BGR_VIATIS)
						aAdd(aCpo53, BD6->BD6_TECUTI)
						aAdd(aCpo54, BD6->BD6_PERC1)
						if GetNewPar("MV_VLTISS","1")=="1"
							aAdd(aCpo55, Round(BD6->BD6_VLRPAG / BD6->BD6_QTDPRO, 2))
							aAdd(aCpo56, BD6->BD6_VLRPAG)
						Else
							aAdd(aCpo55, 0)
							aAdd(aCpo56, 0)
						Endif
					EndIf
					if GetNewPar("MV_VLTISS","1")=="1"
						Do Case
							Case BR8->BR8_TPPROC == "0" // Procedimento
								nVrProc  += BD6->BD6_VLRPAG
							Case BR8->BR8_TPPROC == "1" // Material
								nVrMater += BD6->BD6_VLRPAG
							Case BR8->BR8_TPPROC == "2" // Medicamento
								nVrMedic += BD6->BD6_VLRPAG
							Case BR8->BR8_TPPROC == "3" // Taxas
								nVrTaxas += BD6->BD6_VLRPAG
							Case BR8->BR8_TPPROC == "4" // Diarias
								nVrDiar  += BD6->BD6_VLRPAG
							Case BR8->BR8_TPPROC == "7" // Gases Medicinais
								nVrGases += BD6->BD6_VLRPAG
						EndCase
						nTotGer += BD6->BD6_VLRPAG
					else
						Do Case
							Case BR8->BR8_TPPROC == "0" // Procedimento
								nVrProc  := 0
							Case BR8->BR8_TPPROC == "1" // Material
								nVrMater := 0
							Case BR8->BR8_TPPROC == "2" // Medicamento
								nVrMedic := 0
							Case BR8->BR8_TPPROC == "3" // Taxas
								nVrTaxas := 0
							Case BR8->BR8_TPPROC == "4" // Diarias
								nVrDiar  := 0
							Case BR8->BR8_TPPROC == "7" // Gases Medicinais
								nVrGases := 0
						EndCase
						nTotGer := 0
					Endif
					BD7->(dbSetOrder(1)) // BD7_FILIAL + BD7_CODOPE + BD7_CODLDP + BD7_CODPEG + BD7_NUMERO + BD7_ORIMOV + BD7_SEQUEN + BD7_CODUNM + BD7_NLANC
					BD7->(MsSeek(xFilial("BD7")+BD6->(BD6_CODOPE+BD6_CODLDP+BD6_CODPEG+BD6_NUMERO+BD6_ORIMOV+BD6_SEQUEN)))
					Do While ! BD7->(Eof()) .And. BD7->(BD7_FILIAL+BD7_CODOPE+BD7_CODLDP+BD7_CODPEG+BD7_NUMERO+BD7_ORIMOV+BD7_SEQUEN) == ;
													xFilial("BD7")+BD6->(BD6_CODOPE+BD6_CODLDP+BD6_CODPEG+BD6_NUMERO+BD6_ORIMOV+BD6_SEQUEN)
						aAdd(aCpo57, StrZero(Val(BD7->BD7_SEQUEN), 2, 0))
						BWT->(dbSetOrder(1))
						BWT->(MsSeek(xFilial("BWT")+BD7->(BD7_CODOPE+BD7_CODTPA)))
						aAdd(aCpo58, BWT->BWT_CODEDI)
						aAdd(aCpo59, BD7->BD7_CODRDA)
						BAU->(dbSetOrder(1))
						BAU->(dbSeek(xFilial("BAU")+BD7->BD7_CODRDA))
						aAdd(aCpo60, BAU->BAU_NOME)
						aAdd(aCpo61, BAU->BAU_SIGLCR)
						aAdd(aCpo62, BAU->BAU_CONREG)
						aAdd(aCpo63, BAU->BAU_ESTCR)
						aAdd(aCpo64, BAU->BAU_CPFCGC)
						BD7->(DbSkip())
					EndDo
				BD6->(dbSkip())
			    EndDo
			EndIf

		EndIf
		aAdd(aDados, aCpo45)
		aAdd(aDados, aCpo46)
		aAdd(aDados, aCpo47)
		aAdd(aDados, aCpo48)
		aAdd(aDados, aCpo49)
		aAdd(aDados, aCpo50)
		aAdd(aDados, aCpo51)
		aAdd(aDados, aCpo52)
		aAdd(aDados, aCpo53)
		aAdd(aDados, aCpo54)
		aAdd(aDados, aCpo55)
		aAdd(aDados, aCpo56)
		// Identificacao da Equipe
		aAdd(aDados, aCpo57)
		aAdd(aDados, aCpo58)
		aAdd(aDados, aCpo59)
		aAdd(aDados, aCpo60)
		aAdd(aDados, aCpo61)
		aAdd(aDados, aCpo62)
		aAdd(aDados, aCpo63)
		aAdd(aDados, aCpo64)
		// OPM Solicitadas
		aAdd(aDados, aCpo65)
		aAdd(aDados, aCpo66)
		aAdd(aDados, aCpo67)
		aAdd(aDados, aCpo68)
		aAdd(aDados, aCpo69)
		aAdd(aDados, aCpo70)
		aAdd(aDados, aCpo71)
		aAdd(aDados, nTotGer) // 72
		// Rodape
		aAdd(aDados, { IIf(BE4->BE4_TIPFAT == "T", "X", ""), IIf(BE4->BE4_TIPFAT == "P", "X", "") }) // 73
		aAdd(aDados, nVrProc)  // 74 Total Procedimentos
		aAdd(aDados, nVrDiar)  // 75 Total Diarias
		aAdd(aDados, nVrTaxas) // 76 Total Taxas e Alugueis
		aAdd(aDados, nVrMater) // 77 Total Materiais
		aAdd(aDados, nVrMedic) // 78 Total Medicamentos
		aAdd(aDados, nVrGases) // 79 Total Gases Medicinais
		aAdd(aDados, nVrProc+nVrTaxas+nVrMater+nVrMedic+nVrDiar+nVrGases) // 80 Total Geral
		aAdd(aDados, AllTrim(BEA->BEA_MSG01) + " " + AllTrim(BEA->BEA_MSG02) + " " + AllTrim(BEA->BEA_MSG03)) // 81
		aAdd(aDados, ctod("")) // dDataBase 82
		aAdd(aDados, ctod("")) // 83
	EndIf

Return aDados

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡ao    ?PLSGHONI  ?Autor ?Luciano Aparecido     ?Data ?01.03.07 ³±?
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡ao ?Dados Relatório TISS (Guia Hon. Individual e Guia Despesas )³±?
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±?Uso      ?SigaPLS                                                     ³±?
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros?nGuia (Informe 1- Guia honorario Indiv.e 2-Guia de Despesas)³±?
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function CABGHONI(nGuia)

Local aCpo23
Local aCpo24
Local aCpo25
Local aCpo26
Local aCpo27
Local aCpo28
Local aCpo29
Local aCpo30
Local aCpo31
Local aCpo32
Local aCpo33
Local aCpo34
Local aDados := {}
Local cChave := ""
Local cTissVer := "2.02.03" //PLSTISSVER()
Local cCpo30 := ""

If FindFunction("PLSTISSVER")
	cTissVer := PLSTISSVER()
EndIf
aDados := {}

If !Empty(cTissVer) .and. cTissVer >= "3" .and. nGuia == 1

	// Cabecalho
	aAdd(aDados, B0D->B0D_REGANS) //1
	aAdd(aDados, B0D->(B0D_CODOPE+'.'+B0D_ANOAUT+'.'+B0D_MESAUT+'.'+B0D_NUMAUT)) //2
	BE4->(DbSetOrder(1))
	BE4->(MsSeek(xFilial('BE4')+B0D->B0D_NUMINT))
	aAdd(aDados, BE4->(BE4_CODOPE+'.'+BE4_ANOINT+'.'+BE4_MESINT+'.'+BE4_NUMINT)) //3 Nr Guia Solicitacao
	aAdd(aDados, '') //4 senha
	aAdd(aDados, '') //5 guia operadora

	// Dados do Beneficiario
	aAdd(aDados, B0D->B0D_NUMCAR)  //6 carteiria
	aAdd(aDados, B0D->B0D_NOME) //7 nome
	aAdd(aDados, B0D->B0D_ATENRN) //8 recem nato

    // Dados do Contratado (onde foi executado o procedimento)
	BAU->(dbSetOrder(1))
	BAU->(dbSeek(xFilial("BAU")+B0D->B0D_RDACON))
	aAdd(aDados, IIf(Len(AllTrim(BAU->BAU_CPFCGC)) == 11, Transform(BAU->BAU_CPFCGC, "@R 999.999.999-99"), Transform(BAU->BAU_CPFCGC, "@R 99.999.999/9999-99")))
	aAdd(aDados, B0D->B0D_NOMCON) //11
	aAdd(aDados, Transform(IIF(Empty(B0D->B0D_CNES),"9999999",B0D->B0D_CNES), cPicCNES))


	// Dados do Contratado Executante
	BAU->(dbSetOrder(1))
	BAU->(dbSeek(xFilial("BAU")+B0D->B0D_CODRDA))
	aAdd(aDados, IIf(Len(AllTrim(BAU->BAU_CPFCGC)) == 11, Transform(BAU->BAU_CPFCGC, "@R 999.999.999-99"), Transform(BAU->BAU_CPFCGC, "@R 99.999.999/9999-99")))
	aAdd(aDados, B0D->B0D_NRDAEX) //14
	aAdd(aDados, Transform(IIF(Empty(B0D->B0D_CNESEX),"9999999",B0D->B0D_CNESEX), cPicCNES))

	//dados da Internacao
	aAdd(aDados, B0D->B0D_DTFTIN) //15
	aAdd(aDados, B0D->B0D_DTFTFN) //16

	// Dados do Procedimento
	aCpo17 := {}
	aCpo18 := {}
	aCpo19 := {}
	aCpo20 := {}
	aCpo21 := {}
	aCpo22 := {}
	aCpo23 := {}
	aCpo24 := {}
	aCpo25 := {}
	aCpo26 := {}
	aCpo27 := {}
	aCpo28 := {}
	nVrTot := 0

	// Identificação do(s) Profissional(is) Executante(s
	aCpo29 := {}
	aCpo30 := {}
	aCpo31 := {}
	aCpo32 := {}
	aCpo33 := {}
	aCpo34 := {}
	aCpo35 := {}
	aCpo36 := {}

	B0E->(dbSetOrder(2))//B0E_FILIAL + B0E_OPEMOV + B0E_ANOAUT + B0E_MESAUT + B0E_NUMAUT
	B4B->(dbSetOrder(1))//B0E_FILIAL + B0E_OPEMOV + B0E_ANOAUT + B0E_MESAUT + B0E_NUMAUT
	cChave	:= xFilial("B0E")+B0D->(B0D_OPEMOV+B0D_ANOAUT+B0D_MESAUT+B0D_NUMAUT)
	If B0E->(MsSeek( cChave ) )
		While !B0E->(Eof()) .And. cChave == B0E->(B0E_FILIAL + B0E_OPEMOV + B0E_ANOAUT + B0E_MESAUT + B0E_NUMAUT)

			If B0E->B0E_STATUS <> '0'
				aAdd(aCpo17, B0E->B0E_DATPRO)
				aAdd(aCpo18, B0E->B0E_HORINI)
				aAdd(aCpo19, B0E->B0E_HORFIM)
				aProcTiss:= RetProTiss(B0E->(B0E_CODPAD),B0E->(B0E_CODPRO))
				aAdd(aCpo20, aProcTiss[2])
				aAdd(aCpo21, aProcTiss[3])
				aAdd(aCpo22, B0E->B0E_DESPRO)
				aAdd(aCpo23, B0E->B0E_QTDPRO)
				aAdd(aCpo24, B0E->B0E_VIACES)
				aAdd(aCpo25, B0E->B0E_TECUTI)
				aAdd(aCpo26, B0E->B0E_REDACR)
				aAdd(aCpo27, Round(B0E->B0E_VALOR, 2))
				aAdd(aCpo28, Round(B0E->B0E_VALTOT, 2))
				nVrTot += B0E->B0E_VALTOT

				cChaveB4B	:= xFilial("B4B")+B0E->(B0E_OPEMOV+B0E_ANOAUT+B0E_MESAUT+B0E_NUMAUT+B0E->B0E_SEQUEN)
				If B4B->(MsSeek( cChaveB4B ) )
					While !B4B->(Eof()) .And. cChaveB4B == B4B->(B4B_FILIAL + B4B_OPEMOV + B4B_ANOAUT + B4B_MESAUT + B4B_NUMAUT + B4B_SEQUEN)
						aAdd(aCpo29, B0E->B0E_SEQUEN)
						BWT->(DbSetORder(1))
						BWT->(MsSeek(xFilial("BWT")+PlsIntPAd()+B0D->B0D_GRAPAR))
						If PLSTISSVER() >= "3"
							cCpo30 := PLSGETVINC("BTU_CDTERM", "BWT", .F., "35", B4B->B4B_GRAUPA)
						ENDIF
						IF EMPTY(cCpo30)
							cCpo30 := aAdd(aCpo30, B4B->B4B_GRAUPA)
						ENDIF
						aAdd(aCpo30, cCpo30)	//GRAU DE PARTICIPACAO DO PROFISSIONAL NA EQUIPE  17
						aAdd(aCpo31, B4B->B4B_CDPFPR)
						aAdd(aCpo32, B4B->B4B_NOMPRF)
						aAdd(aCpo33, B4B->B4B_SICONS)
						aAdd(aCpo34, B4B->B4B_NUCONS)
						aAdd(aCpo35, B4B->B4B_UFCONS)
						aAdd(aCpo36, B4B->B4B_CODESP)
						B4B->(dbSkip())
					Enddo
				EndIf

			Endif

			B0E->(dbSkip())
		Enddo
	EndIf

	aAdd(aDados, aCpo17)
	aAdd(aDados, aCpo18)
	aAdd(aDados, aCpo19)
	aAdd(aDados, aCpo20)
	aAdd(aDados, aCpo21)
	aAdd(aDados, aCpo22)
	aAdd(aDados, aCpo23)
	aAdd(aDados, aCpo24)
	aAdd(aDados, aCpo25)
	aAdd(aDados, aCpo26)
	aAdd(aDados, aCpo27)
	aAdd(aDados, aCpo28)


	aAdd(aDados, aCpo29)
	aAdd(aDados, aCpo30)
	aAdd(aDados, aCpo31)
	aAdd(aDados, aCpo32)
	aAdd(aDados, aCpo33)
	aAdd(aDados, aCpo34)
	aAdd(aDados, aCpo35)
	aAdd(aDados, aCpo36)

	aAdd(aDados, Alltrim(B0D->B0D_OBSERV))
	aAdd(aDados, nVrTot) // Valor final do Honorario Medico considerando o somatorio do campo valor total
	aAdd(aDados, B0D->B0D_DATPRO)
	aAdd(aDados, { dDataBase, Time() })

ElseIf nGuia == 1 // Guia de Honorario Individual

	// Cabecalho
	aAdd(aDados, B0D->B0D_REGANS) //1
	aAdd(aDados, B0D->(B0D_CODOPE+'.'+B0D_ANOAUT+'.'+B0D_MESAUT+'.'+B0D_NUMAUT)) //2
	BE4->(DbSetOrder(1))
	BE4->(MsSeek(xFilial('BE4')+B0D->B0D_NUMINT))
	aAdd(aDados, BE4->(BE4_CODOPE+'.'+BE4_ANOINT+'.'+BE4_MESINT+'.'+BE4_NUMINT)) //3 Nr Guia Solicitacao
	aAdd(aDados, B0D->B0D_DATGUI) //4

	// Dados do Beneficiario
	aAdd(aDados, B0D->B0D_NUMCAR)  //5
	aAdd(aDados, B0D->B0D_PLANO) //6
	aAdd(aDados, B0D->B0D_DATCAR)//7
	aAdd(aDados, B0D->B0D_NOME) //8
	aAdd(aDados, B0D->B0D_CNS) //9

	// Dados do Contratado (onde foi executado o procedimento)

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//?Posiciona Rede de Atendimento                                ?
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	BAU->(dbSetOrder(1))
	BAU->(dbSeek(xFilial("BAU")+B0D->B0D_RDACON))

	aAdd(aDados, IIf(Len(AllTrim(BAU->BAU_CPFCGC)) == 11, Transform(BAU->BAU_CPFCGC, "@R 999.999.999-99"), Transform(BAU->BAU_CPFCGC, "@R 99.999.999/9999-99")))
	aAdd(aDados, B0D->B0D_NOMCON) //11
	aAdd(aDados, Transform(B0D->B0D_CNES, cPicCNES))

	// Dados do Contratado Executante

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//?Posiciona Rede de Atendimento                                ?
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	BAU->(dbSetOrder(1))
	BAU->(dbSeek(xFilial("BAU")+B0D->B0D_CODRDA))
	aAdd(aDados, IIf(Len(AllTrim(BAU->BAU_CPFCGC)) == 11, Transform(BAU->BAU_CPFCGC, "@R 999.999.999-99"), Transform(BAU->BAU_CPFCGC, "@R 99.999.999/9999-99")))

	aAdd(aDados, B0D->B0D_NRDAEX) //14
	aAdd(aDados, Transform(B0D->B0D_CNESEX, cPicCNES))

	If !Empty(B0D->B0D_TIPACO)
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//?Posiciona Padrao de Acomoda‡„o                               ?
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		BI4->(dbSetOrder(1))
		BI4->(dbSeek(xFilial("BI4")+B0D->B0D_TIPACO))
		aAdd(aDados, { BI4->BI4_CODACO, BI4->BI4_DESCRI }) //TIPO DE ACOMODACAO  16
	Else
		aAdd(aDados, { "", "" }) //TIPO DE ACOMODACAO  16
	Endif

	BWT->(DbSetORder(1))
	BWT->(MsSeek(xFilial("BWT")+PlsIntPAd()+B0D->B0D_GRAPAR))
	aAdd(aDados, BWT->BWT_CODEDI) //GRAU DE PARTICIPACAO DO PROFISSIONAL NA EQUIPE  17

	aAdd(aDados, B0D->B0D_NOMEXE)//18
	aAdd(aDados, B0D->B0D_SICONS)//19
	aAdd(aDados, B0D->B0D_NUCONS)
	aAdd(aDados, B0D->B0D_UFCONS)
	aAdd(aDados, B0D->B0D_CPFEXE)

	// Dados do Procedimento
	aCpo23 := {}
	aCpo24 := {}
	aCpo25 := {}
	aCpo26 := {}
	aCpo27 := {}
	aCpo28 := {}
	aCpo29 := {}
	aCpo30 := {}
	aCpo31 := {}
	aCpo32 := {}
	aCpo33 := {}
	aCpo34 := {}
	nVrTot := 0


	B0E->(dbSetOrder(2))//B0E_FILIAL + B0E_OPEMOV + B0E_ANOAUT + B0E_MESAUT + B0E_NUMAUT
	cChave	:= xFilial("B0E")+B0D->(B0D_OPEMOV+B0D_ANOAUT+B0D_MESAUT+B0D_NUMAUT)

	If B0E->(MsSeek( cChave ) )
		Do While !B0E->(Eof()) .And. cChave == B0E->(B0E_FILIAL + B0E_OPEMOV + B0E_ANOAUT + B0E_MESAUT + B0E_NUMAUT)

			If B0E->B0E_STATUS <> '0'
				aAdd(aCpo23, B0E->B0E_DATPRO)
				aAdd(aCpo24, B0E->B0E_HORINI)
				aAdd(aCpo25, B0E->B0E_HORFIM)
				aAdd(aCpo26, B0E->B0E_CODPAD)
				aAdd(aCpo27, B0E->B0E_CODPRO)
				aAdd(aCpo28, B0E->B0E_DESPRO)
				aAdd(aCpo29, B0E->B0E_QTDPRO)
				aAdd(aCpo30, B0E->B0E_VIACES)
				aAdd(aCpo31, B0E->B0E_TECUTI)
				aAdd(aCpo32, B0E->B0E_REDACR)
				aAdd(aCpo33, Round(B0E->B0E_VALOR, 2))
				aAdd(aCpo34, Round(B0E->B0E_VALTOT, 2))
				nVrTot += B0E->B0E_VALTOT
			Endif

			B0E->(dbSkip())
		Enddo
	EndIf

	aAdd(aDados, aCpo23)
	aAdd(aDados, aCpo24)
	aAdd(aDados, aCpo25)
	aAdd(aDados, aCpo26)
	aAdd(aDados, aCpo27)
	aAdd(aDados, aCpo28)
	aAdd(aDados, aCpo29)
	aAdd(aDados, aCpo30)
	aAdd(aDados, aCpo31)
	aAdd(aDados, aCpo32)
	aAdd(aDados, aCpo33)
	aAdd(aDados, aCpo34)
	aAdd(aDados, nVrTot) // Valor final do Honorario Medico considerando o somatorio do campo valor total

	aAdd(aDados, B0D->B0D_OBSERV)
	aAdd(aDados, dDataBase)
	aAdd(aDados, { dDataBase, Time() })

ElseIf nGuia == 2 // Guia de Despesas
/*
		// Cabecalho
		aAdd(aDados, BA0->BA0_SUSEP)
		aAdd(aDados, BEA->(BEA_OPEMOV+"."+BEA_ANOAUT+"."+BEA_MESAUT+"-"+BEA_NUMAUT))
		// Dados do Contratado Executante
		nRecBAU := BAU->(RecNo())
		BAU->(dbSetOrder(5))
		BAU->(MsSeek(xFilial("BAU")+BB0->BB0_CODIGO)) //BB0 - PROFISSIONAL DE SAUDE
		aAdd(aDados, IIf(Len(AllTrim(BAU->BAU_CPFCGC)) == 11, Transform(BAU->BAU_CPFCGC, "@R 999.999.999-99"), Transform(BAU->BAU_CPFCGC, "@R 99.999.999/9999-99")))
		BB8->(dbSetOrder(1))
		BB8->(dbSeek(xFilial("BB8")+BAU->BAU_CODIGO+BEA->(BEA_OPEMOV+BEA_CODLOC)))
		aAdd(aDados, BAU->BAU_NOME)
		aAdd(aDados, Transform(BB8->BB8_CNES, cPicCNES))
		BAU->(dbGoTo(nRecBAU))
		// Dados do Atendimento/Procedimento realizado
		aCpo06 := {}
		aCpo07 := {}
		aCpo08 := {}
		aCpo09 := {}
		aCpo10 := {}
		aCpo11 := {}
		aCpo12 := {}
		aCpo13 := {}
		aCpo14 := {}
		aCpo15 := {}
		aCpo16 := {}
		nVrAlug  := 0 //Alugueis
		nVrMater := 0 // Diarias
		nVrMedic := 0 // Medicamentos
		nVrTaxas := 0 //Taxas Diversas
		nVrDiar  := 0 //Diárias
		nVrGases := 0 // Gases Medicinais
		BE2->(dbSetOrder(1))  //Autorizacao X Procedimentos
		cChave	:= xFilial("BE2")+BEA->(BEA_OPEMOV+BEA_ANOAUT+BEA_MESAUT+BEA_NUMAUT ) //BEA - Complemento Movimentacao
		If BE2->(dbSeek( cChave ) )
			Do While !BE2->(Eof()) .And. cChave == BE2->(BE2_FILIAL+BE2_OPEMOV+BE2_ANOAUT+BE2_MESAUT+BE2_NUMAUT)

				If BE2->BE2_STATUS <> "1" //PROCEDIMENTO  1- Autorizado  0- Não Autorizada
					BE2->(dbSkip())
					Loop
				Endif

				BD6->(dbSetOrder(6))//Eventos das Contas Medicas
				If BD6->(dbSeek(xFilial("BD6")+BE2->BE2_OPEMOV+BEA->BEA_CODLDP+ BEA->BEA_CODPEG +BE2->BE2_NUMERO+BEA->BEA_ORIMOV+BE2->BE2_CODPAD+BE2->BE2_CODPRO))
					BR8->(dbSetOrder(1))
					If BR8->(dbSeek(xFilial("BR8")+BE2->(BE2_CODPAD+BE2_CODPRO)))
						Do Case
						//BR8_TPPROC--> 0=Procedimento;1=Material;2=Medicamento;3=Taxas;4=Diarias;5=Ortese/Protese;6=Pacote;7=Gases Medicinais ; 8=Alugueis
							Case BR8->BR8_TPPROC == "8" //foi criado tipo 8 Alugueis
								nVrAlug  += BD6->BD6_VLRPAG // ALUGUEIS
								aAdd(aCpo06, "6")
							Case BR8->BR8_TPPROC == "1"
								nVrMater += BD6->BD6_VLRPAG
								aAdd(aCpo06, "3")
							Case BR8->BR8_TPPROC == "2"
								nVrMedic += BD6->BD6_VLRPAG
								aAdd(aCpo06, "2")
							Case BR8->BR8_TPPROC $ "3,5,6" //verificar futuro com tulio 5=Ortese/Protese e 6=Pacote
								nVrTaxas += BD6->BD6_VLRPAG
								aAdd(aCpo06, "4")
							Case BR8->BR8_TPPROC == "4"
								nVrDiar  += BD6->BD6_VLRPAG
								aAdd(aCpo06, "5")
							Case BR8->BR8_TPPROC $ "7,0" //verificar futuro com tulio 0-Procedimento
								nVrGases += BD6->BD6_VLRPAG
								aAdd(aCpo06, "1")
						EndCase
					Else
						aAdd(aCpo06, "")
					EndIf
					aAdd(aCpo14, Round(BD6->BD6_VLRPAG / BD6->BD6_QTDPRO, 2))
					aAdd(aCpo15, BD6->BD6_VLRPAG)
					aAdd(aCpo16, BD6->BD6_DESPRO)
				Else
				aAdd(aCpo06, "")
				aAdd(aCpo14, 0)
				aAdd(aCpo15, 0)
				aAdd(aCpo16, "")
				Endif

				aAdd(aCpo07, BE2->BE2_DATPRO)
				aAdd(aCpo08, BE2->BE2_HORPRO)
				aAdd(aCpo09, BE2->BE2_HORFIM)
				aAdd(aCpo10,Posicione("BF8", 2, xFilial("BF8")+BD6->(BD6_CODPAD+BD6_CODOPE+BD6_CODTAB), "BF8_TABTIS"))//10
				//aAdd(aCpo10, BE2->BE2_CODPAD)
				aAdd(aCpo11, PlsPicPro(BE2->BE2_CODPAD, BE2->BE2_CODPRO))
				aAdd(aCpo12, BE2->BE2_QTDPRO)
				aAdd(aCpo13, BE2->BE2_PERVIA)

			BE2->(dbSkip())
			Enddo

		EndIf
		aAdd(aDados, aCpo06)
		aAdd(aDados, aCpo07)
		aAdd(aDados, aCpo08)
		aAdd(aDados, aCpo09)
		aAdd(aDados, aCpo10)
		aAdd(aDados, aCpo11)
		aAdd(aDados, aCpo12)
		aAdd(aDados, aCpo13)
		aAdd(aDados, aCpo14)
		aAdd(aDados, aCpo15)
		aAdd(aDados, aCpo16)
		aAdd(aDados, nVrGases) // 17- Vr Gases Medicinais
		aAdd(aDados, nVrMedic) // 18- Vr Medicamentos
		aAdd(aDados, nVrMater) // 19- Vr Materiais
		aAdd(aDados, nVrTaxas) // 20- Vr Taxas e Alugueis
		aAdd(aDados, nVrDiar)  // 21- Vr Diarias
		aAdd(aDados, nVrAlug)  // 22- Vr Alugueis
		aAdd(aDados, nVrAlug+nVrTaxas+nVrMater+nVrMedic+nVrDiar+nVrGases) // Vr Total Geral
*/
EndIf


Return aDados

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡ao    ?PLSDACM   ?Autor ?Luciano Aparecido     ?Data ?03.03.07 ³±?
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡ao ?Dados Relatório TISS (Guia Demonst. Análise Contas Médicas )³±?
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±?Uso      ?SigaPLS                                                     ³±?
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros?cCodRda - Código da RDA a ser processado o Relatório        ³±?
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function CABDACM(cCodOpe, cRdaDe, cRdaAte, cAno, cMes, cClaPre, cLocRda , cNFSSDe, cNFSSAte,cNmTitPg,cPEGDe, cPEGAte,cAlias)
Local aCpo04,aCpo05,aCpo06,aCpo07,aCpo08,aCpo09,aCpo10, aCpo11, aCpo12, aCpo13, aCpo14, aCpo15
local aCpo16, aCpo17, aCpo18, aCpo19, aCpo20, aCpo21, aCpo22, aCpo23, aCpo24, aCpo25, aCpo26
local aCpo27, aCpo28, aCpo29

Local nInd1, nInd2,nInd3
Local aDados :={}
Local cSQL
LOCAL lAchouUm := .F.
local nProcGui := 0
LOCAL nLibGui  := 0
LOCAL nGloGui  := 0
LOCAL nProcFat := 0
LOCAL nLibFat  := 0
LOCAL nGloFat  := 0
LOCAL nProcGer := 0
LOCAL nLibGer  := 0
LOCAL nGloGer  := 0
LOCAL lFlag	   := .F.
LOCAL cNmLotPg		:= ""
LOCAL cRdaLote		:= ""

DEFAULT cLocRda 	:= ""
DEFAULT cNFSSDe 	:= ""
DEFAULT cNFSSAte 	:= ""
DEFAULT cNmTitPg 	:= ""
DEFAULT cPEGDe		:= " "
DEFAULT cPEGAte		:= Replicate("Z",Len(BD7->BD7_CODPEG))

// Peg Final não pode ser em branco.
If Empty(cPEGAte)
	cPEGAte		:= Replicate("Z",Len(BD7->BD7_CODPEG))
Endif

If !Empty(cNmTitPg)
	If cAlias ="SE2"
		SE2->(dbSetorder(01))
		If SE2->(dbSeek(xFilial("SE2")+cNmTitPg))
			cCodOpe  := SE2->E2_PLOPELT
			cNmLotPg := SE2->E2_PLLOTE
			cRdaLote := SE2->E2_CODRDA
			cAno 	 := SE2->E2_ANOBASE
			cMes	 := SE2->E2_MESBASE
		Endif
	Else
		SC7->(dbSetorder(01))
		If SC7->(dbSeek(xFilial("SC7")+cNmTitPg))
			cCodOpe  := If(SC7->(FieldPos("C7_PLOPELT"))>0,SC7->C7_PLOPELT,PLSINTPAD())
			cNmLotPg := SC7->C7_LOTPLS
			cRdaLote := SC7->C7_CODRDA
			cFornece:= SC7->C7_FORNECE
			cLoja    := SC7->C7_LOJA
			cAno := Substr(SC7->C7_LOTPLS,1,4)
			cMes := Substr(SC7->C7_LOTPLS,5,2)
		Endif
	Endif
Endif
cSQL := "SELECT BD7_CODEMP, BD7_CODLDP, BD7_CODOPE, BD7_CODPAD, BD7_CODPEG, BD7_CODPRO, BD7_CODRDA, BD7_CODTPA, BD7_DATPRO, BD7_MATRIC, BD7_NOMRDA, BD7_NOMUSR, BD7_NUMERO, BD7_NUMLOT, BD7_OPELOT, BD7_ORIMOV, BD7_SEQUEN, BD7_TIPREG, BD7_MOTBLO, BD7_VLRMAN, BD7_VLRPAG, BD7_VLRGLO, BD7_ANOPAG, BD7_MESPAG, R_E_C_N_O_ AS RECNO "
cSQL += "  FROM " + RetSqlName("BD7")
cSQL += " WHERE BD7_FILIAL = '" + xFilial("BD7") + "' AND "
cSQL += " BD7_OPELOT = '"+cCodOpe+"' AND "

cSQL += "( BD7_CODPEG >= '" + cPEGDe    + "' AND BD7_CODPEG <= '" + cPEGAte + "' ) AND "
If !Empty(cNmLotPg)
	cSQL += "BD7_CODRDA = '"+ cRdaLote +"' AND "
	cSQL += "BD7_NUMLOT = '"+ cNmLotPg +"' AND "

Else
	If Len(AllTrim(cAno+cMes)) == 6
		cSQL += "( BD7_CODRDA >= '" + cRdaDe    + "' AND BD7_CODRDA <= '" + cRdaAte    + "' ) AND "
		cSQL += " BD7_NUMLOT LIKE '"+cAno+cMes+"%' AND "
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
		//?Somente pega as guias de um mesma NFSS							  ?
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?

	Else
		If BD7->(FieldPos("BD7_SEQNFS")) > 0
			If !Empty(cNFSSAte)
				cSQL += "( BD7_SEQNFS >= '"+cNFSSDe+"' AND BD7_SEQNFS <= '"+cNFSSAte+"' ) AND "
				cSQL += "( BD7_CODRDA >= '" + cRdaDe    + "' AND BD7_CODRDA <= '" + cRdaAte    + "' ) AND "
				cSQL += "BD7_FASE IN ('3','4') AND "
			EndIf
		Endif
	EndIf
Endif

cSql += RetSQLName("BD7")+".D_E_L_E_T_ = ' '"
cSQL += " ORDER BY BD7_NUMLOT, BD7_CODRDA, BD7_CODLDP, BD7_CODPEG, BD7_NUMERO, BD7_SEQUEN "
PlsQuery(cSQL,"TrbBD7")

// BA0 - Operadoras de Saude
BA0->(dbSetOrder(1))
BA0->(msSeek(xFilial("BA0")+TrbBD7->(BD7_CODOPE)))

Do While ! TrbBD7->(Eof())

	aCpo04 := {}
	aCpo05 := {}
	aCpo06 := {}
	aCpo07 := {}
	aCpo08 := {}
	aCpo09 := {}
	aCpo10 := {}
	aCpo11 := {}
	aCpo12 := {}
	aCpo13 := {}
	aCpo14 := {}
	aCpo15 := {}
	aCpo16 := {}
	aCpo17 := {}
	aCpo18 := {}
	aCpo19 := {}
	aCpo20 := {}
	aCpo21 := {}
	aCpo22 := {}
	aCpo23 := {}
	aCpo24 := {}
	aCpo25 := {}
	aCpo26 := {}
	aCpo27 := {}
	aCpo28 := {}
	aCpo29 := {}

	aAdd(aDados, BA0->BA0_SUSEP) // 1
	aAdd(aDados, BA0->BA0_NOMINT) // 2
	aAdd(aDados, Transform(BA0->BA0_CGC, "@R 99.999.999/9999-99")) // 3

	Do While ! TrbBD7->(Eof())

		// BAU - Redes de Atendimento
		BAU->(dbSetOrder(1))
		BAU->(msSeek(xFilial("BAU")+TrbBD7->BD7_CODRDA))

		// BAF - Lotes de Pagamentos RDA
		BAF->(dbSetOrder(1))
		BAF->(msSeek(xFilial("BAF")+TrbBD7->(BD7_OPELOT+BD7_NUMLOT)))

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//?Posiciona Contas Medicas                                     ?
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		BD5->(dbSetOrder(1)) //BD5_FILIAL, BD5_CODOPE, BD5_CODLDP, BD5_CODPEG, BD5_NUMERO, BD5_SITUAC, BD5_FASE, BD5_DATPRO, BD5_OPERDA, BD5_CODRDA, R_E_C_N_O_, D_E_L_E_T_
		BD5->(MsSeek(xFilial("BD5")+TrbBD7->(BD7_CODOPE+BD7_CODLDP+BD7_CODPEG+BD7_NUMERO)))

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//?Na Web o relatorio e por local de atendimento				 ?
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If Len(AllTrim(cAno+cMes)) == 6
			//If !Empty(cLocRda) .And. !BD5->BD5_LOCAL == cLocRda //
			If !Empty(cLocRda) .And. !BD5->BD5_CODLOC == cLocRda
				TrbBD7->( dbSkip() )
				Loop
			Endif
		EndIf

		lAchouUm := .T.
		nProcGer :=0
		nLibGer  :=0
		nGloGer  :=0

		If Empty(cNmTitPg) .and. Empty(cNmLotPg)
			cSQL := " SELECT R_E_C_N_O_  AS E2_RECNO "
			cSQL += "  FROM " + RetSQLName("SE2")
			cSQL += "  WHERE E2_FILIAL = '" + xFilial("SE2") + "' "
			cSQL += "    AND E2_PLOPELT = '" + TrbBD7->BD7_OPELOT + "'"
			cSQL += "    AND E2_PLLOTE = '" + TrbBD7->BD7_NUMLOT + "'"
			cSQL += "    AND E2_CODRDA = '" + TrbBD7->BD7_CODRDA + "'"
			cSQL += "    AND D_E_L_E_T_ = ' ' "

			PlsQuery(cSQL,"TrbSE2")

			If ! TrbSE2->(Eof())
				SE2->(dbGoTo(TrbSE2->(E2_RECNO)))
			EndIf

			TrbSE2->(DbCloseArea())
		Endif

		aAdd(aCpo04, BAF->(BAF_ANOLOT+BAF_MESLOT+BAF_NUMLOT)) // 4
		aAdd(aCpo05, BAF->BAF_DTDIGI) // 5
		aAdd(aCpo06, IIf(BAU->BAU_TIPPE == "F", Transform(BAU->BAU_CPFCGC, "@R 999.999.999-99"), Transform(BAU->BAU_CPFCGC, "@R 99.999.999/9999-99"))) // 6
		aAdd(aCpo07, BAU->BAU_NOME) // 7

		BB8->(dbSetOrder(1))
		BB8->(dbSeek(xFilial("BB8")+TrbBD7->(BD7_CODRDA+BD7_CODOPE)+BD5->BD5_CODLOC))

		aAdd(aCpo08, Transform(BB8->BB8_CNES, cPicCNES)) // 8
		aAdd(aCpo09, If(cAlias=="SE2",SE2->(E2_PREFIXO+E2_NUM+E2_PARCELA),SC7->C7_NUM)) // 9

		aAdd(aCpo10,{})
		aAdd(aCpo11,{})
		aAdd(aCpo12,{})
		aAdd(aCpo13,{})
		aAdd(aCpo14,{})
		aAdd(aCpo15,{})
		aAdd(aCpo16,{})
		aAdd(aCpo17,{})
		aAdd(aCpo18,{})
		aAdd(aCpo19,{})
		aAdd(aCpo20,{})
		aAdd(aCpo21,{})
		aAdd(aCpo22,{})
		aAdd(aCpo23,{})
		aAdd(aCpo24,{})
		aAdd(aCpo25,{})
		aAdd(aCpo26,{})
		aAdd(aCpo27,{})
		aAdd(aCpo28,{})
		nInd1 := Len(aCpo04)

		cChRDA := TrbBD7->(BD7_NUMLOT+BD7_CODRDA)
		Do While ! TrbBD7->(Eof()) .And. TrbBD7->(BD7_NUMLOT+BD7_CODRDA) ==  cChRDA

			// BCI - PEGS ??????????
			BCI->(dbSetOrder(5))
			BCI->(msSeek(xFilial("BCI")+TrbBD7->(BD7_CODOPE+BD7_CODRDA+BD7_CODOPE+BD7_CODLDP+BD7_CODPEG)))

			aAdd(aCpo10[nInd1], TrbBD7->(BD7_CODLDP+BD7_CODPEG)) // 10
			aAdd(aCpo11[nInd1], BCI->BCI_DATREC) // 11
			aAdd(aCpo12[nInd1], BCI->BCI_CODPEG) // 12
			aAdd(aCpo13[nInd1], BCI->BCI_VLRGUI) // 13
			aAdd(aCpo14[nInd1], BD7->BD7_VLRGLO) // 14 (VALOR GLOSA PROTOCOLO)
			aAdd(aCpo15[nInd1], "") // 15 (CODIGO GLOSA PROTOCOLO)   ?????

			nProcGer+=TrbBD7->BD7_VLRPAG
			nLibGer +=TrbBD7->BD7_VLRPAG
			nGloGer +=TrbBD7->BD7_VLRGLO

			aAdd(aCpo16[nInd1], {})
			aAdd(aCpo17[nInd1], {})
			aAdd(aCpo18[nInd1], {})
			aAdd(aCpo19[nInd1], {})
			aAdd(aCpo20[nInd1], {})
			aAdd(aCpo21[nInd1], {})
			aAdd(aCpo22[nInd1], {})
			aAdd(aCpo23[nInd1], {})
			aAdd(aCpo24[nInd1], {})
			aAdd(aCpo25[nInd1], {})
			aAdd(aCpo26[nInd1], {})
			aAdd(aCpo27[nInd1], {})
			aAdd(aCpo28[nInd1], {})

			nInd2 := Len(aCpo10[nInd1])

			nProcFat:=0
			nLibFat :=0
			nGloFat :=0
			cChFat := TrbBD7->(BD7_NUMLOT+BD7_CODRDA+BD7_CODLDP+BD7_CODPEG)
			Do While ! TrbBD7->(Eof()) .And. TrbBD7->(BD7_NUMLOT+BD7_CODRDA+BD7_CODLDP+BD7_CODPEG) ==  cChFat

				BA1->(dbSetOrder(2))
				BA1->(msSeek(xFilial("BA1")+TrbBD7->(BD7_CODOPE+BD7_CODEMP+BD7_MATRIC+BD7_TIPREG)))

				aAdd(aCpo16[nInd1, nInd2], TrbBD7->BD7_NUMERO) // 16
				aAdd(aCpo17[nInd1, nInd2], TrbBD7->BD7_NOMUSR) // 17
				If BA1->BA1_CODINT == BA1->BA1_OPEORI .Or. empty(BA1->BA1_MATANT)
					aAdd(aCpo18[nInd1, nInd2], BA1->(BA1_CODINT+"."+BA1_CODEMP+"."+BA1_MATRIC+"."+BA1_TIPREG+"-"+BA1_DIGITO)	) // 18
				Else
					aAdd(aCpo18[nInd1, nInd2], BA1->BA1_MATANT) // 18
				EndIf

				nProcFat+=TrbBD7->BD7_VLRPAG
				nLibFat +=TrbBD7->BD7_VLRPAG
				nGloFat +=TrbBD7->BD7_VLRGLO

				aAdd(aCpo19[nInd1, nInd2], {})
				aAdd(aCpo20[nInd1, nInd2], {})
				aAdd(aCpo21[nInd1, nInd2], {})
				aAdd(aCpo22[nInd1, nInd2], {})
				aAdd(aCpo23[nInd1, nInd2], {})
				aAdd(aCpo24[nInd1, nInd2], {})
				aAdd(aCpo25[nInd1, nInd2], {})
				aAdd(aCpo26[nInd1, nInd2], {})
				aAdd(aCpo27[nInd1, nInd2], {})
				aAdd(aCpo28[nInd1, nInd2], {})
				nInd3 := Len(aCpo16[nInd1, nInd2])

				nProcGui:=0
				nLibGui :=0
				nGloGui :=0
				cChGuia := TrbBD7->(BD7_NUMLOT+BD7_CODRDA+BD7_CODLDP+BD7_CODPEG+BD7_NUMERO)
				Do While ! TrbBD7->(Eof()) .And. TrbBD7->(BD7_NUMLOT+BD7_CODRDA+BD7_CODLDP+BD7_CODPEG+BD7_NUMERO) ==  cChGuia
					// BR8 - Tabela Padrao
					BR8->(dbSetOrder(1))
					BR8->(msSeek(xFilial("BR8")+TrbBD7->(BD7_CODPAD+BD7_CODPRO)))
					// BWT - Tipo de Participacao
					BWT->(dbSetOrder(1))
					BWT->(msSeek(xFilial("BWT")+TrbBD7->(BD7_CODOPE+BD7_CODTPA)))
					aAdd(aCpo19[nInd1, nInd2, nInd3], TrbBD7->BD7_DATPRO) //19
					aAdd(aCpo20[nInd1, nInd2, nInd3], BR8->BR8_DESCRI)    //20

					BD6->(dbSetOrder(1))
					BD6->(msSeek(xFilial("BD6")+TrbBD7->(BD7_CODOPE+BD7_CODLDP+BD7_CODPEG+BD7_NUMERO+BD7_ORIMOV+BD7_SEQUEN+BD7_CODPAD+BD7_CODPRO)))

					aAdd(aCpo21[nInd1, nInd2, nInd3],Posicione("BF8", 2, xFilial("BF8")+BD6->(BD6_CODPAD+BD6_CODOPE+BD6_CODTAB), "BF8_TABTIS"))//21

					//	aAdd(aCpo21[nInd1, nInd2, nInd3], TrbBD7->BD7_CODPAD)  //21
					aAdd(aCpo22[nInd1, nInd2, nInd3], PLSPICPRO(TrbBD7->BD7_CODPAD, TrbBD7->BD7_CODPRO))//22

					BWT->(dbSetOrder(1))
					BWT->(MsSeek(xFilial("BWT")+TrbBD7->(BD7_CODOPE+BD7_CODTPA)))

					aAdd(aCpo23[nInd1, nInd2, nInd3], BWT->BWT_CODEDI) 	//23
					aAdd(aCpo24[nInd1, nInd2, nInd3], BD6->BD6_QTDPRO) 	// 24
					aAdd(aCpo25[nInd1, nInd2, nInd3], Iif (!Empty(TrbBD7->BD7_VLRPAG),TrbBD7->BD7_VLRPAG,0) + Iif (!Empty(TrbBD7->BD7_VLRGLO),TrbBD7->BD7_VLRGLO,0)) //25
					nProcGui+=Iif (!Empty(TrbBD7->BD7_VLRPAG),TrbBD7->BD7_VLRPAG,0) + Iif (!Empty(TrbBD7->BD7_VLRGLO),TrbBD7->BD7_VLRGLO,0)
					aAdd(aCpo26[nInd1, nInd2, nInd3], Iif (!Empty(TrbBD7->BD7_VLRPAG),TrbBD7->BD7_VLRPAG,0)) //26
					nLibGui+=TrbBD7->BD7_VLRPAG
					aAdd(aCpo27[nInd1, nInd2, nInd3], Iif (!Empty(TrbBD7->BD7_VLRGLO),TrbBD7->BD7_VLRGLO,0)) //27
					nGloGui+=TrbBD7->BD7_VLRGLO
					// BDX - Glosas das Movimentacoes
					cCpo28 := ""
					lFlag  := .F.
					BDX->(dbSetOrder(1))
					If  BDX->(msSeek(xFilial("BDX")+TrbBD7->(BD7_CODOPE+BD7_CODLDP+BD7_CODPEG+BD7_NUMERO+BD7_ORIMOV+BD7_CODPAD+BD7_CODPRO+BD7_SEQUEN)))
						Do While ! BDX->(eof()) .And. BDX->(BDX_FILIAL+BDX_CODOPE+BDX_CODLDP+BDX_CODPEG+BDX_NUMERO+BDX_ORIMOV+BDX_CODPAD+BDX_CODPRO+BDX_SEQUEN) == ;
							xFilial("BDX")+TrbBD7->(BD7_CODOPE+BD7_CODLDP+BD7_CODPEG+BD7_NUMERO+BD7_ORIMOV+BD7_CODPAD+BD7_CODPRO+BD7_SEQUEN)

							BCT->(dbSetOrder(1))
							If BCT->(msSeek(xFilial("BCT")+BDX->(BDX_CODOPE+BDX_CODGLO))) .And.;
								At(BCT->BCT_GLTISS,cCpo28)==0

								If BDX->BDX_TIPREG == "1" .Or. (BDX->BDX_CODGLO==__aCdCri049[1] .And. !lFlag)
									cCpo28 += IIf(Empty(cCpo28), "", ", ") + AllTrim(BCT->BCT_GLTISS)
								Endif

							EndIf

							If BDX->BDX_CODGLO == __aCdCri049[1]
								lFlag := .T.
							EndIf

							BDX->(dbSkip())
						EndDo
					EndIf
					aAdd(aCpo28[nInd1, nInd2, nInd3], cCpo28)
					aAdd(aCpo29,TrbBD7->RECNO) //29
					TrbBD7->(dbSkip())
				EndDo
			Enddo
		EndDo
	EndDo
	aAdd(aDados, aCpo04)
	aAdd(aDados, aCpo05)
	aAdd(aDados, aCpo06)
	aAdd(aDados, aCpo07)
	aAdd(aDados, aCpo08)
	aAdd(aDados, aCpo09)
	aAdd(aDados, aCpo10)
	aAdd(aDados, aCpo11)
	aAdd(aDados, aCpo12)
	aAdd(aDados, aCpo13)
	aAdd(aDados, aCpo14)
	aAdd(aDados, aCpo15)
	aAdd(aDados, aCpo16)
	aAdd(aDados, aCpo17)
	aAdd(aDados, aCpo18)
	aAdd(aDados, aCpo19)
	aAdd(aDados, aCpo20)
	aAdd(aDados, aCpo21)
	aAdd(aDados, aCpo22)
	aAdd(aDados, aCpo23)
	aAdd(aDados, aCpo24)
	aAdd(aDados, aCpo25)
	aAdd(aDados, aCpo26)
	aAdd(aDados, aCpo27)
	aAdd(aDados, aCpo28)
	aAdd(aDados, nProcGui)//29 Valor Processado Guia
	aAdd(aDados, nLibGui)//30 Valor Liberado Guia
	aAdd(aDados, nGloGui)//31 Valor Glosa Guia
	aAdd(aDados, "")	  //32 Codigo Glosa Guia
	aAdd(aDados, nProcFat)//33 Valor Processado Fatura
	aAdd(aDados, nLibFat)//34 Valor Liberado Fatura
	aAdd(aDados, nGloFat)//35 Valor Glosa Fatura
	aAdd(aDados, nProcGer)//36 Valor Processado Fatura
	aAdd(aDados, nLibGer)//37 Valor Liberado Fatura
	aAdd(aDados, nGloGer)//38 Valor Glosa Fatura
	aAdd(aDados, aCpo29) //39 recnos

	If !lAchouUm
		aDados := {}
	EndIf
Enddo
TrbBD7->(DbCloseArea())

Return aDados

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡ao    ?PLSDPGT   ?Autor ?Luciano Aparecido     ?Data ?05.03.07 ³±?
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡ao ?Dados Relatório TISS (Guia Demonstrativo de Pagamento )     ³±?
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±?Uso      ?SigaPLS                                                     ³±?
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros?cCodOpe - Código da Operadora                               ³±?
±±?         ?cRdaDe  - Código da RDA a ser processada (de)               ³±?
±±?         ?cRdaAte - Código da RDA a ser processada (At?              ³±?
±±?         ?cAno    - Informe o Ano a ser processado                    ³±?
±±?         ?cMes    - Informe o Mês a ser processado                    ³±?
±±?         ?cClaPre - Classe RDA                                        ³±?
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function CABDPGT(cCodOpe, cRdaDe, cRdaAte, cAno, cMes, cClaPre,cNFSSDe,cNFSSAte,cNmTitPg,cAlias)

	Local aCpo04,aCpo05, aCpo06, aCpo07, aCpo08, aCpo09, aCpo10, aCpo11, aCpo12, aCpo13
	Local aCpo14, aCpo15, aCpo16, aCpo17, aCpo18, aCpo19, aCpo20, aCpo21, aCpo22
	Local aCpo23, aCpo24, aCpo25, aCpo26, aCpo27,aCpo28
	Local aDados
	Local cSQL
	Local nInd1, nCont:=0
	LOCAL cNmLotPg		:= ""
	LOCAL cRdaLote		:= ""

	DEFAULT cNFSSDe 	:= ""
	DEFAULT cNFSSAte 	:= ""
	DEFAULT cNmTitPg 	:= ""
	DEFAULT cAlias := "SE2"

	DBSELECTAREA(cAlias)
	// Variaveis para buscar o BMR pelo numero do titulo.
	If !Empty(cNmTitPg)
		If cAlias ="SE2"
			SE2->(dbSetorder(01))
			If SE2->(dbSeek(xFilial("SE2")+cNmTitPg))
				cCodOpe  := SE2->E2_PLOPELT
				cNmLotPg := Subs(SE2->E2_PLLOTE,7,4)
				cRdaLote := SE2->E2_CODRDA
	            cFornece:= SE2->E2_FORNECE
	            cLoja    := SE2->E2_LOJA
				cAno := SE2->E2_ANOBASE
				cMes := SE2->E2_MESBASE
			Endif
		Else
			SC7->(dbSetorder(01))
			If SC7->(dbSeek(xFilial("SC7")+cNmTitPg))
				cCodOpe  := If(SC7->(FieldPos("C7_PLOPELT"))>0,SC7->C7_PLOPELT,PLSINTPAD())
				cNmLotPg := Subs(SC7->C7_LOTPLS,7,4)
				cRdaLote := SC7->C7_CODRDA
				cFornece:= SC7->C7_FORNECE
	            cLoja    := SC7->C7_LOJA

				cAno := Substr(SC7->C7_LOTPLS,1,4)
				cMes := Substr(SC7->C7_LOTPLS,5,2)
			Endif


		Endif
	Else
		cFornece:=SE2->E2_FORNECE
		cLoja := SE2->E2_LOJA

	Endif
	aDados := {}

	cSQL := "SELECT BMR_ANOLOT, BMR_CODLAN, BMR_CODRDA, BMR_DEBCRE, BMR_FILIAL, BMR_MESLOT, BMR_NUMLOT, BMR_OPELOT, BMR_OPERDA, BMR_VLRPAG"
	cSQL += "  FROM " + RetSqlName("BMR")
	cSQL += " WHERE BMR_FILIAL = '" + xFilial("BMR") + "' AND "
	cSQL += "  BMR_OPELOT = '" + cCodOpe + "' AND "
	If !Empty(cNmLotPg)
	    cSQL += "BMR_CODRDA = '" + cRdaLote + "' AND "
		cSQL += "BMR_NUMLOT = '" + cNmLotPg + "' AND "

	Else
	    cSQL += "( BMR_CODRDA >= '" + cRdaDe + "' AND BMR_CODRDA <= '" + cRdaAte + "' ) AND "
	Endif

	cSQL += " BMR_ANOLOT = '" + cAno + "' AND "
	cSQL += " BMR_MESLOT = '" + cMes + "' AND "
	cSql += RetSQLName("BMR")+".D_E_L_E_T_ = ' '"
	cSQL += " ORDER BY BMR_FILIAL, BMR_OPELOT, BMR_ANOLOT, BMR_MESLOT, BMR_NUMLOT, BMR_OPERDA, BMR_CODRDA, BMR_CODLAN "

	PlsQuery(cSQL,"TrbBMR")

	// BA0 - Operadoras de Saude
	BA0->(dbSetOrder(1))
	BA0->(msSeek(xFilial("BA0")+TrbBMR->(BMR_OPERDA)))

   	Do While ! TrbBMR->(Eof())
	    nCont+=1
		// BAU - Redes de Atendimento
		BAU->(dbSetOrder(1))
		BAU->(msSeek(xFilial("BAU")+TrbBMR->BMR_CODRDA))

		// BAF - Lotes plsde Pagamentos RDA
		BAF->(dbSetOrder(1))
		BAF->(msSeek(xFilial("BAF")+TrbBMR->(BMR_OPERDA+BMR_ANOLOT+BMR_MESLOT+BMR_NUMLOT)))

		If Empty(cNmTitPg) .and. Empty(cNmLotPg)
			cSQL := " SELECT R_E_C_N_O_  AS E2_RECNO,E2_VENCTO,E2_FORNECE,E2_LOJA "
			cSQL += "  FROM " + RetSQLName("SE2")
			cSQL += "  WHERE E2_FILIAL = '" + xFilial("SE2") + "' "
			cSQL += "    AND E2_PLOPELT = '" + TrbBMR->BMR_OPELOT + "'"
			cSQL += "    AND E2_PLLOTE = '" + TrbBMR->(BMR_ANOLOT+BMR_MESLOT+BMR_NUMLOT) + "'"
			cSQL += "    AND E2_CODRDA = '" + TrbBMR->BMR_CODRDA + "'"
			cSQL += "    AND D_E_L_E_T_ = ' ' "
			PlsQuery(cSQL,"TrbSE2")

			If ! TrbSE2->(Eof())
				SE2->(dbGoTo(TrbSE2->(E2_RECNO)))
			EndIf

			TrbSE2->(DbCloseArea())
		Endif

		// SA2 - Cadastro de Fornecedores
		SA2->(dbSetOrder(1))
		SA2->(msSeek(xFilial("SA2")+cFornece+cLoja))

		If nCont == 1
			aAdd(aDados, BA0->BA0_SUSEP) // 1
			aAdd(aDados, BA0->BA0_NOMINT) // 2
			aAdd(aDados, Transform(BA0->BA0_CGC, "@R 99.999.999/9999-99")) // 3
			aCpo04 := {}
			aCpo05 := {}
			aCpo06 := {}
			aCpo07 := {}
			aCpo08 := {}
			aCpo09 := {}
			aCpo10 := {}
			aCpo11 := {}
			aCpo12 := {}
			aCpo13 := {}
			aCpo14 := {}
			aCpo15 := {}
			aCpo16 := {}
			aCpo17 := {}
			aCpo18 := {}
			aCpo19 := {}
			aCpo20 := {}
			aCpo21 := {}
			aCpo22 := {}
			aCpo23 := {}
			aCpo24 := {}
			aCpo25 := {}
			aCpo26 := {}
			aCpo27 := {}
			aCpo28 := {}
		Endif

		cSQL := "SELECT BD7_CODOPE, BD7_CODRDA, BD7_CODOPE, BD7_CODLDP,BD7_NUMERO, BD7_CODPEG, BD7_ORIMOV,BD7_SEQUEN,BD7_CODPAD, BD7_VLRAPR,BD7_CODPRO, BD7_VLRPAG, BD7_VLRGLO "
		cSQL += "  FROM " + RetSqlName("BD7")
		cSQL += " WHERE BD7_FILIAL = '" + xFilial("BD7") + "'"
		cSQL += "   AND BD7_NUMLOT = '" + TrbBMR->(BMR_ANOLOT+BMR_MESLOT+BMR_NUMLOT) + "'"
		cSQL += "   AND BD7_CODRDA = '" + TrbBMR->(BMR_CODRDA)+ "'"
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
		//?Somente pega as guias de um mesma NFSS							  ?
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
		If BD7->(FieldPos("BD7_SEQNFS")) > 0
		  	If !Empty(cNFSSAte)
		  		cSQL += "AND ( BD7_SEQNFS >= '"+cNFSSDe+"' AND BD7_SEQNFS <= '"+cNFSSAte+"' ) "
		  	EndIf
		Endif
		cSQL += "   AND D_E_L_E_T_ = ' '"
		cSQL += " ORDER BY BD7_CODLDP,BD7_CODPEG"

		PlsQuery(cSQL,"TrbBD7")

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//?Posiciona Contas Medicas                                     ?
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		BD5->(dbSetOrder(1))
		BD5->(MsSeek(xFilial("BD5")+TrbBD7->(BD7_CODOPE+BD7_CODLDP+BD7_CODPEG+BD7_NUMERO)))

		aAdd(aCpo04, BAF->(BAF_ANOLOT+BAF_MESLOT+BAF_NUMLOT)) // 4
		aAdd(aCpo05, BAF->BAF_DTDIGI) // 5
		aAdd(aCpo06, IIf(BAU->BAU_TIPPE == "F", Transform(BAU->BAU_CPFCGC, "@R 999.999.999-99"), Transform(BAU->BAU_CPFCGC, "@R 99.999.999/9999-99"))) // 6
		aAdd(aCpo07, BAU->BAU_NOME) // 7

		BB8->(dbSetOrder(1))
		BB8->(dbSeek(xFilial("BB8")+BD7->(BD7_CODRDA+BD7_CODOPE)+BD5->BD5_CODLOC))

		aAdd(aCpo08, Transform(BB8->BB8_CNES, cPicCNES)) // 8
		aAdd(aCpo09, If(cAlias=="SE2",SE2->E2_VENCTO,CTOD(" / / "))) // 9   DATA DO PAGAMENTO
		aAdd(aCpo10, { IF (BAU->BAU_FORPGT =='1',"X",""),;  //Credito em conta
						IF (BAU->BAU_FORPGT =='2',"X",""),;  //Carteira
		               IF (BAU->BAU_FORPGT =='3',"X","")})  // Boleto Bancário   10   FORMA DE PAGAMENTO
		aAdd(aCpo11, IF (BAU->BAU_FORPGT =='1',SA2->A2_BANCO,""))  // 11   BANCO
		aAdd(aCpo12, IF (BAU->BAU_FORPGT =='1',SA2->A2_AGENCIA,"")) // 12   AGENCIA
		aAdd(aCpo13, IF (BAU->BAU_FORPGT =='1',SA2->A2_NUMCON,""))  // 13   NUMERO DA CONTA/CHEQUE

		aAdd(aCpo14,{})
		aAdd(aCpo15,{})
		aAdd(aCpo16,{})
		aAdd(aCpo17,{})
		aAdd(aCpo18,{})
		aAdd(aCpo19,{})
		aAdd(aCpo20,{})
		aAdd(aCpo21,{})
		aAdd(aCpo27,{})

		nGerInf  := 0
		nGerProc := 0
		nGerLib  := 0
		nGerGlo  := 0
		nVrInf   := 0
		nVrProc  := 0
		nVrLib   := 0
		nVrGlo   := 0

		nInd1 := Len(aCpo04)

		TrbBD7->(dbGoTop())
		Do While !TrbBD7->(Eof())

			nVrInf   := 0
			nVrProc  := 0
			nVrLib   := 0
			nVrGlo   := 0

			// BCI - PEGS
			BCI->(dbSetOrder(5)) //BCI_FILIAL + BCI_OPERDA + BCI_CODRDA + BCI_CODOPE + BCI_CODLDP + BCI_CODPEG + BCI_FASE + BCI_SITUAC
			BCI->(msSeek(xFilial("BCI")+TrbBD7->(BD7_CODOPE+BD7_CODRDA+BD7_CODOPE+BD7_CODLDP+BD7_CODPEG)))

			aAdd(aCpo14[nInd1], If(cAlias=="SE2",SE2->(E2_PREFIXO+E2_NUM+E2_PARCELA),SC7->C7_NUM))
			aAdd(aCpo15[nInd1], TrbBD7->(BD7_CODLDP+BD7_CODPEG))
			aAdd(aCpo16[nInd1], BCI->BCI_DATREC)
			aAdd(aCpo17[nInd1], BCI->BCI_CODPEG)

			cChRDA  := TrbBD7->(BD7_CODOPE+BD7_CODRDA+BD7_CODLDP+BD7_CODPEG)
			Do While ! TrbBD7->(Eof()) .And. TrbBD7->(BD7_CODOPE+BD7_CODRDA+BD7_CODLDP+BD7_CODPEG) ==  cChRDA

				nVrInf  += TrbBD7->BD7_VLRAPR
				nVrProc += TrbBD7->BD7_VLRPAG + TrbBD7->BD7_VLRGLO
				nVrLib  += TrbBD7->BD7_VLRPAG
				nVrGlo  += TrbBD7->BD7_VLRGLO

				TrbBD7->(dbSkip())
			EndDo

			aAdd(aCpo18[nInd1], nVrInf)
			aAdd(aCpo19[nInd1], nVrProc)
			aAdd(aCpo20[nInd1], nVrLib)
			aAdd(aCpo21[nInd1], nVrGlo)
			nGerInf  += nVrInf
			nGerProc += nVrProc
			nGerLib  += nVrLib
			nGerGlo  += nVrGlo
		EndDo

		aAdd(aCpo22, nGerInf)
		aAdd(aCpo23, nGerProc)
		aAdd(aCpo24, nGerLib)
		aAdd(aCpo25, nGerGlo)
		aAdd(aCpo26,(nGerProc-nGerGlo))
		TrbBD7->(dbCloseArea())
		aAdd(aDados, aCpo04)
		aAdd(aDados, aCpo05)
		aAdd(aDados, aCpo06)
		aAdd(aDados, aCpo07)
		aAdd(aDados, aCpo08)
		aAdd(aDados, aCpo09)
		aAdd(aDados, aCpo10)
		aAdd(aDados, aCpo11)
		aAdd(aDados, aCpo12)
		aAdd(aDados, aCpo13)
		aAdd(aDados, aCpo14)
		aAdd(aDados, aCpo15)
		aAdd(aDados, aCpo16)
		aAdd(aDados, aCpo17)
		aAdd(aDados, aCpo18)
		aAdd(aDados, aCpo19)
		aAdd(aDados, aCpo20)
		aAdd(aDados, aCpo21)
		aAdd(aDados, aCpo22) // 22
		aAdd(aDados, aCpo23) // 23
		aAdd(aDados, aCpo24) // 24
		aAdd(aDados, aCpo25) // 25
		aAdd(aDados, aCpo26) // 26

		nDeb :=0
		nCred:=0
		cChBMR := TrbBMR->(BMR_FILIAL+BMR_OPELOT+BMR_ANOLOT+BMR_MESLOT+BMR_NUMLOT+BMR_OPERDA+BMR_CODRDA)
		Do While ! TrbBMR->(Eof()) .And. TrbBMR->(BMR_FILIAL+BMR_OPELOT+BMR_ANOLOT+BMR_MESLOT+BMR_NUMLOT+BMR_OPERDA+BMR_CODRDA) == cChBMR

			If TrbBMR->BMR_CODLAN $ "102,103,104,105" // Debitos/Creditos Fixos e Variaveis
				BMS->(dbSetOrder(1))
				BMS->(msSeek(TrbBMR->(BMR_FILIAL+BMR_OPERDA+BMR_CODRDA+BMR_OPELOT+BMR_ANOLOT+BMR_MESLOT+BMR_NUMLOT+BMR_CODLAN)))
				Do While ! BMS->(Eof()) .And. ;
						BMS->(BMS_FILIAL+BMS_OPERDA+BMS_CODRDA+BMS_OPELOT+BMS_ANOLOT+BMS_MESLOT+BMS_NUMLOT+BMS_CODLAN) == ;
						TrbBMR->(BMR_FILIAL+BMR_OPERDA+BMR_CODRDA+BMR_OPELOT+BMR_ANOLOT+BMR_MESLOT+BMR_NUMLOT+BMR_CODLAN)
					aAdd(aCpo27[nInd1], { IIf(BMS->BMS_DEBCRE == "1", "(-) ", "(+) ") + BMS->BMS_CODSER + " - " + Posicione("BBB", 1, xFilial("BBB")+BMS->BMS_CODSER, "BBB_DESCRI"), BMS->BMS_VLRPAG })
					if BMS->BMS_DEBCRE == "1"
						nDeb+=BMS->BMS_VLRPAG
					else
						nCred+=BMS->BMS_VLRPAG
					Endif
					BMS->(dbSkip())
				EndDo
			ElseIf TrbBMR->BMR_CODLAN <> "101" .And. TrbBMR->BMR_DEBCRE <> "3"
				aAdd(aCpo27[nInd1], { IIf(TrbBMR->BMR_DEBCRE == "1", "(-) ", "(+) ") + TrbBMR->BMR_CODLAN + " - " + Posicione("BLR", 1, xFilial("BLR")+TrbBMR->(BMR_OPELOT+BMR_CODLAN), "BLR_DESCRI"), TrbBMR->BMR_VLRPAG })
				If TrbBMR->BMR_DEBCRE == "1"
					nDeb+=TrbBMR->BMR_VLRPAG
				else
					nCred+=TrbBMR->BMR_VLRPAG
				Endif
			EndIf

		TrbBMR->(dbSkip())
		EndDo

		aAdd(aDados, aCpo27)
		aAdd(aCpo28, ((nGerProc-nGerGlo)+nCred)-nDeb)
		aAdd(aDados, aCpo28) // 28

	EndDo

	TrbBMR->(DbCloseArea())

Return aDados

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡ao    ?PLSDPGTB  ?Autor ?Luciano Aparecido     ?Data ?05.03.07 ³±?
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡ao ?Dados Relatório TISS (Guia Demonstrativo de Pagamento )     ³±?
±±?         ?TISS 3                                                      ³±?
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±?Uso      ?SigaPLS                                                     ³±?
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros?cCodOpe - Código da Operadora                               ³±?
±±?         ?cRdaDe  - Código da RDA a ser processada (de)               ³±?
±±?         ?cRdaAte - Código da RDA a ser processada (At?              ³±?
±±?         ?cAno    - Informe o Ano a ser processado                    ³±?
±±?         ?cMes    - Informe o Mês a ser processado                    ³±?
±±?         ?cClaPre - Classe RDA                                        ³±?
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function CABDPGTB(cCodOpe, cRdaDe, cRdaAte, cAno, cMes, cClaPre,cNFSSDe,cNFSSAte,cNmTitPg,cAliasP,lWeb,cDataPag)

Local aCpo04,aCpo05, aCpo06, aCpo07, aCpo08, aCpo09, aCpo10, aCpo11, aCpo12, aCpo13
Local aCpo14, aCpo15, aCpo16, aCpo17, aCpo18, aCpo19, aCpo20, aCpo21, aCpo22
Local aCpo23, aCpo24, aCpo25, aCpo26, aCpo27,aCpo28
LOCAL aDados := {}
LOCAL aDadosTot := {}
Local cSQL
Local nCont:=0
Local nInd1 := 0
LOCAL cNmLotPg		:= ""
LOCAL cRdaLote		:= ""
LOCAL lAdd14			:= .F.
LOCAL lAdd17 			:= .F.
LOCAL nI				:= 1
LOCAL cDePara25 := ""
LOCAL cDePara26 := ""
LOCAL cDePara27 := ""
LOCAL nGerLib := 0
DEFAULT cNFSSDe 	:= ""
DEFAULT cNFSSAte 	:= ""
DEFAULT cNmTitPg 	:= ""
DEFAULT cAliasP		:= "SE2"
Default cDataPag	:= ""
DBSELECTAREA("SE2")

cSQL := "SELECT DISTINCT BMR_ANOLOT, BMR_CODLAN, BMR_CODRDA, BMR_DEBCRE, BMR_FILIAL, BMR_MESLOT, BMR_NUMLOT, BMR_OPELOT, BMR_OPERDA, BMR_VLRPAG"
cSQL += "  FROM " + RetSqlName("BMR") + " BMR "
If !Empty(cDataPag)
	cSQL += "INNER JOIN " + RetSqlName("BAF") + " BAF ON "
	cSQL += "BMR_ANOLOT = BAF_ANOLOT AND BMR_MESLOT = BAF_MESLOT AND BMR_NUMLOT = BAF_NUMLOT AND BAF_DTDIGI = '" + cDataPag + "' AND BAF.D_E_L_E_T_ = '' "
Endif
If lWeb
	// Variaveis para buscar o BMR pelo numero do titulo.
    If cAliasP == "SE2"
	SE2->(dbSetorder(01))
	If SE2->(dbSeek(xFilial("SE2")+cNmTitPg))
		cCodOpe  := SE2->E2_PLOPELT
			cNmLotPg := Substr(SE2->E2_PLLOTE,7,4)
		cRdaLote := SE2->E2_CODRDA

		cAno := SE2->E2_ANOBASE
		cMes := SE2->E2_MESBASE

			cPrefixo := SE2->E2_PREFIXO
			cNum	 := SE2->E2_NUM
			cParcela := SE2->E2_PARCELA
			cTipoTit := SE2->E2_TIPO
			cFornece := SE2->E2_FORNECE
			cLoja	 := SE2->E2_LOJA

	Endif
	Else
		SC7->(DbSetOrder(1))
		If SC7->(MsSeek(xFilial("SC7")+cNmTitPg))

			cCodOpe  := SC7->C7_PLOPELT
			cNmLotPg := Substr(SC7->C7_LOTPLS,7,4)
			cRdaLote := SC7->C7_CODRDA
			cAno 	 := Substr(SC7->C7_LOTPLS,1,4)
			cMes     := Substr(SC7->C7_LOTPLS,5,2)

		EndIf

	Endif

	// BAU - Redes de Atendimento
	BAU->(dbSetOrder(1))
	BAU->(msSeek(xFilial("BAU")+cRdaLote))
	cBAUCalImp	:= BAU->BAU_CALIMP

	/*Se o cAliasP for SE2 pode ser:
	 	a) Gera pagamento pelo financeiro; ou
		b) Gera pegamento por pedido de compras e ja foi dada entrada na NF
	 Se o cAliasP for SC7, usa pedido de compras mas ainda nao deu entrada na NF
	*/
	If cAliasP == "SE2"
		cSQL += " INNER JOIN " + RetSqlName("SE2") + " SE2 "
		cSQL += "    ON E2_FILIAL  = '"+xFilial("SE2")+"' "
		cSQL += "   AND E2_PREFIXO = '"+cPrefixo+"' "
		cSQL += "   AND E2_NUM 	   = '"+cNum+"' "
		cSQL += "   AND E2_PARCELA = '"+cParcela+"' "
		cSQL += "   AND E2_TIPO    = '"+cTipoTit+"' "
		cSQL += "   AND E2_FORNECE = '"+cFornece+"' "
		cSQL += "   AND E2_LOJA	   = '"+cLoja+"' "

		If	cBAUCalImp <>  '1'
			cSQL += "   AND E2_PLOPELT = BMR_OPELOT "
			cSQL += "   AND E2_PLLOTE  = BMR_ANOLOT || BMR_MESLOT || BMR_NUMLOT "
		EndIf
		cSQL += "   AND E2_CODRDA  = BMR_CODRDA "
		cSQL += "   AND SE2.D_E_L_E_T_ = ' ' "

		//Se gera pedido de compras, so vai ter o titulo quando ja tiver sido dado entrada no Documento de Entrada
		//Entao adiciono a tabela de NF e a tabela de pedidos de compras, para depois chegar a todos os lotes de pagamento que pertencem ao titulo/pedido
		iF cBAUCalImp ==  '1'

			cSQL += "	 INNER JOIN " + RetSqlName("SD1") + " SD1 "
			cSQL += "	    ON D1_FILIAL  = E2_FILORIG "
			cSQL += "	   AND D1_DOC 	  = E2_NUM "
			cSQL += "	   AND D1_FORNECE = E2_FORNECE  "
			cSQL += "	   AND D1_LOJA 	  = E2_LOJA "
			cSQL += "	   AND D1_DTDIGIT = SE2.E2_EMIS1 "
			cSQL += "	   AND SD1.D_E_L_E_T_ = ' '"

			cSQL += "	 INNER JOIN " + RetSqlName("SC7") + " SC7 "
			cSQL += "	    ON C7_FILIAL  = D1_FILIAL "
			cSQL += "	   AND C7_NUM     = D1_PEDIDO "
			cSQL += "	   AND C7_ITEM	  = D1_ITEMPC "
			cSQL += "	   AND C7_PLOPELT = BMR_OPELOT "
			cSQL += "	   AND C7_LOTPLS  = BMR_ANOLOT || BMR_MESLOT || BMR_NUMLOT "
			cSQL += "	   AND C7_CODRDA  = BMR_CODRDA "
			cSQL += "	   AND SC7.D_E_L_E_T_ = ' ' "

		EndIf
	Else
		//Se eh Web e nao ?SE2 significa que foi gerado apenas o pedido de compras mas ainda nao tem titulo a pagar.
		iF !Empty(cNmTitPg)
			cSQL += " INNER JOIN " + RetSqlName("SC7") + " SC7 "
			cSQL += "    ON C7_FILIAL = '"+xFilial("SC7")+"' "
			cSQL += "   AND C7_NUM    = '"+cNmTitPg+"'
			cSQL += "   AND C7_PLOPELT = BMR_OPELOT  "
			cSQL += "   AND C7_LOTPLS  = BMR_ANOLOT || BMR_MESLOT || BMR_NUMLOT "
			cSQL += "   AND C7_CODRDA  = BMR_CODRDA "
			cSQL += "   AND SC7.D_E_L_E_T_ = ' ' "
		EndIf
	EndIf

	cSQL += " WHERE BMR_FILIAL = '" + xFilial("BMR") + "' "
	cSQL += "  AND BMR_OPERDA = '" + cCodOpe + "' "
	cSQL += "  AND BMR_CODRDA = '" + cRdaLote + "' "
	cSQL += "  AND BMR_OPELOT = '" + cCodOpe + "' "
	cSQL += "  AND BMR_ANOLOT = '" + cAno + "' "
	cSQL += "  AND BMR_MESLOT = '" + cMes + "' "

	//Se usa pedido de compras nao posso filtrar pelo lote na BMR, pois um titulo/pedido pode ter mais de um lote
	iF cBAUCalImp <> '1'
		cSQL += " AND BMR_NUMLOT = '" + cNmLotPg + "' "
	EndIf

Else

	cSQL += " WHERE BMR_FILIAL = '" + xFilial("BMR") + "' "
	cSQL += "  AND BMR_OPERDA = '" + cCodOpe + "' "
	cSQL += "  AND ( BMR_CODRDA >= '" + cRdaDe + "' AND BMR_CODRDA <= '" + cRdaAte + "' ) "
	cSQL += "  AND BMR_OPELOT = '" + cCodOpe + "' "
	If !Empty(cAno)
		cSQL += " AND BMR_ANOLOT = '" + cAno + "' "
	EndIf
	If !Empty(cMes)
		cSQL += " AND BMR_MESLOT = '" + cMes + "' "
	EndIf

EndIF
cSql += " AND BMR.D_E_L_E_T_ = ' '"
cSQL += " ORDER BY BMR_FILIAL, BMR_OPERDA, BMR_CODRDA, BMR_OPELOT, BMR_ANOLOT, BMR_MESLOT, BMR_NUMLOT, BMR_CODLAN "

cSQL	:= ChangeQuery(cSQL)
PlsQuery(cSQL,"TrbBMR")

	// BA0 - Operadoras de Saude
BA0->(dbSetOrder(1))
BA0->(msSeek(xFilial("BA0")+TrbBMR->(BMR_OPERDA)))

Do While ! TrbBMR->(Eof())
	nCont+=1
		// BAU - Redes de Atendimento
	BAU->(dbSetOrder(1))
	BAU->(msSeek(xFilial("BAU")+TrbBMR->BMR_CODRDA))

		// BAF - Lotes plsde Pagamentos RDA
	BAF->(dbSetOrder(1))
	BAF->(msSeek(xFilial("BAF")+TrbBMR->(BMR_OPERDA+BMR_ANOLOT+BMR_MESLOT+BMR_NUMLOT)))

	If Empty(cNmTitPg) .and. Empty(cNmLotPg)
		cSQL := " SELECT R_E_C_N_O_  AS E2_RECNO,E2_VENCTO,E2_FORNECE,E2_LOJA "
		cSQL += "  FROM " + RetSQLName("SE2")
		cSQL += "  WHERE E2_FILIAL = '" + xFilial("SE2") + "' "
		cSQL += "    AND E2_PLOPELT = '" + TrbBMR->BMR_OPELOT + "'"
		cSQL += "    AND E2_PLLOTE = '" + TrbBMR->(BMR_ANOLOT+BMR_MESLOT+BMR_NUMLOT) + "'"
		cSQL += "    AND E2_CODRDA = '" + TrbBMR->BMR_CODRDA + "'"
		cSQL += "    AND D_E_L_E_T_ = ' ' "
		PlsQuery(cSQL,"TrbSE2")

		If ! TrbSE2->(Eof())
			SE2->(dbGoTo(TrbSE2->(E2_RECNO)))
		EndIf

		TrbSE2->(DbCloseArea())
	Endif

		// SA2 - Cadastro de Fornecedores
	SA2->(dbSetOrder(1))
	SA2->(msSeek(xFilial("SA2")+SE2->E2_FORNECE+SE2->E2_LOJA))

	If nCont == 1
		aAdd(aDados, BA0->BA0_SUSEP) // 1
		aAdd(aDados, BAF->(BAF_ANOLOT+BAF_MESLOT+BAF_NUMLOT)) // 2
		aAdd(aDados, BA0->BA0_NOMINT) // 3

		aCpo04 := {}
		aCpo05 := {}
		aCpo06 := {}
		aCpo07 := {}
		aCpo08 := {}
		aCpo09 := {}
		aCpo10 := {}
		aCpo11 := {}
		aCpo12 := {}
		aCpo13 := {}
		aCpo14 := {}
		aCpo15 := {}
		aCpo16 := {}
		aCpo17 := {}
		aCpo18 := {}
		aCpo19 := {}
		aCpo20 := {}
		aCpo21 := {}
		aCpo22 := {}
		aCpo23 := {}
		aCpo24 := {}
		aCpo25 := {}
		aCpo26 := {}
		aCpo27 := {}
		aCpo28 := {}
		aCpo29 := {}
		aCpo30 := {}
		aCpo31 := {}
		aCpo32 := {}

	Endif
	If TrbBMR->BMR_CODLAN == "101"

		cSQL := "SELECT BD7_CODOPE, BD7_CODRDA, BD7_CODOPE, BD7_CODLDP,BD7_NUMERO, BD7_CODPEG, BD7_ORIMOV,BD7_SEQUEN,BD7_CODPAD, BD7_VLRAPR,BD7_CODPRO, BD7_VLRPAG, BD7_VLRGLO "
			cSQL += "  FROM " + RetSqlName("BD7") + " BD7 "
		cSQL += " WHERE BD7_FILIAL = '" + xFilial("BD7") + "'"
			cSQL += "   AND BD7_CODOPE = '" + cCodOpe + "' "
			cSQL += "   AND BD7_OPELOT = '" + TrbBMR->(BMR_OPELOT) + "'"
		cSQL += "   AND BD7_NUMLOT = '" + TrbBMR->(BMR_ANOLOT+BMR_MESLOT+BMR_NUMLOT) + "'"
		cSQL += "   AND BD7_CODRDA = '" + TrbBMR->(BMR_CODRDA)+ "'"
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
			//?Somente pega as guias de um mesma NFSS							  ?
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
		If BD7->(FieldPos("BD7_SEQNFS")) > 0
			If !Empty(cNFSSAte)
				cSQL += "AND ( BD7_SEQNFS >= '"+cNFSSDe+"' AND BD7_SEQNFS <= '"+cNFSSAte+"' ) "
			EndIf
		Endif
			cSQL += "   AND BD7.D_E_L_E_T_ = ' '"
		cSQL += " ORDER BY BD7_CODLDP,BD7_CODPEG"

		PlsQuery(cSQL,"TrbBD7")

			If !TrbBD7->(Eof())
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//?Posiciona Contas Medicas                                     ?
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		BD5->(dbSetOrder(1))
		BD5->(MsSeek(xFilial("BD5")+TrbBD7->(BD7_CODOPE+BD7_CODLDP+BD7_CODPEG+BD7_NUMERO)))

		aAdd(aCpo04, Transform(BA0->BA0_CGC, "@R 99.999.999/9999-99") ) // 4
				aAdd(aCpo05, dDataBase) // 5 - Data de emissao do demonstrativo
				aAdd(aCpo06, IIf(BAU->BAU_TIPPE == "F", Transform(BAU->BAU_CPFCGC, "@R 999.999.999-99"), Transform(BAU->BAU_CPFCGC, "@R 99.999.999/9999-99"))) // 6 - Codigo identificador do prestador contratado executante junto a operadora, conforme contrato estabelecido
				aAdd(aCpo07, BAU->BAU_NOME) // 7 - Razao Social, nome fantasia ou nome do prestador contratado da operadora que executou o procedimento

		BB8->(dbSetOrder(1))
		BB8->(dbSeek(xFilial("BB8")+BD7->(BD7_CODRDA+BD7_CODOPE)+BD5->BD5_CODLOC))

				aAdd(aCpo08, Iif(Empty(BB8->BB8_CNES),'9999999',Transform(BB8->BB8_CNES, cPicCNES))) // 8 - CNES. Orientacao: Caso o prestador ainda nao possua o codigo do CNES preencher o campo com 9999999
				aAdd(aCpo09, SE2->E2_VENCTO) // 9   Data do pagamento ou data prevista para o pagamento

				aAdd(aCpo10, BAU->BAU_FORPGT)  // 10   Codigo da forma como sera efetuado o pagamento dos servicos ao prestador, conforme tabela de dominio no 34 - ok Protheus 1,2,3 iguais
		aAdd(aCpo11, IF (BAU->BAU_FORPGT =='1',SA2->A2_BANCO,""))  // 11   BANCO
		aAdd(aCpo12, IF (BAU->BAU_FORPGT =='1',SA2->A2_AGENCIA,"")) // 12   AGENCIA
		aAdd(aCpo13, IF (BAU->BAU_FORPGT =='1',SA2->A2_NUMCON,""))  // 13   NUMERO DA CONTA/CHEQUE

				aAdd(aCpo14,{}) //Data que a operadora recebeu o lote de guias de cobranca do prestador.
				aAdd(aCpo15,{}) //Numero atribuido pela operadora ao lote de guias encaminhado pelo prestador.
				aAdd(aCpo16,{}) //Numero atribuido pelo prestador ao enviar um conjunto de guias para a operadora
		aAdd(aCpo17,{})
		aAdd(aCpo18,{})
		aAdd(aCpo19,{})
		aAdd(aCpo20,{})

		nGerInf  := 0
		nGerProc := 0
		nGerLib  := 0
		nGerGlo  := 0
		nVrInf   := 0
		nVrProc  := 0
		nVrLib   := 0
		nVrGlo   := 0


		lAdd14 := .F.
		lAdd17 := .F.
		TrbBD7->(dbGoTop())
		Do While !TrbBD7->(Eof())

			nVrInf   := 0
			nVrProc  := 0
			nVrLib   := 0
			nVrGlo   := 0

				// BCI - PEGS
			BCI->(dbSetOrder(5)) //BCI_FILIAL + BCI_OPERDA + BCI_CODRDA + BCI_CODOPE + BCI_CODLDP + BCI_CODPEG + BCI_FASE + BCI_SITUAC
			BCI->(msSeek(xFilial("BCI")+TrbBD7->(BD7_CODOPE+BD7_CODRDA+BD7_CODOPE+BD7_CODLDP+BD7_CODPEG)))
			lAdd14 := .T.
			nInd1 := Len(aCpo04)

			aAdd(aCpo14[nInd1], BCI->BCI_DATREC)
			aAdd(aCpo15[nInd1], BCI->BCI_CODPEG)
					aAdd(aCpo16[nInd1], IIF(Empty(BCI->BCI_PROTOC),TrbBD7->(BD7_CODLDP+BD7_CODPEG),BCI->BCI_PROTOC)) //Numero atribuido pelo prestador ao enviar um conjunto de guias para a operadora

			cChRDA  := TrbBD7->(BD7_CODOPE+BD7_CODRDA+BD7_CODLDP+BD7_CODPEG)
			Do While ! TrbBD7->(Eof()) .And. TrbBD7->(BD7_CODOPE+BD7_CODRDA+BD7_CODLDP+BD7_CODPEG) ==  cChRDA

				lAdd17 := .T.
				nVrInf  += TrbBD7->BD7_VLRAPR
				nVrProc += TrbBD7->BD7_VLRPAG + TrbBD7->BD7_VLRGLO
				nVrLib  += TrbBD7->BD7_VLRPAG
				nVrGlo  += TrbBD7->BD7_VLRGLO

				TrbBD7->(dbSkip())
			EndDo

			aAdd(aCpo17[nInd1], nVrInf)
			aAdd(aCpo18[nInd1], nVrProc)
			aAdd(aCpo19[nInd1], nVrLib)
			aAdd(aCpo20[nInd1], nVrGlo)
			nGerInf  += nVrInf
			nGerProc += nVrProc
			nGerLib  += nVrLib
			nGerGlo  += nVrGlo
		EndDo

		If (!lAdd14)
			aAdd(aCpo14, {""})
			aAdd(aCpo15, {""})
			aAdd(aCpo16, {""})
		ElseIf (!lAdd17)
			aAdd(aCpo17, {""})
			aAdd(aCpo18, {""})
			aAdd(aCpo19, {""})
			aAdd(aCpo20, {""})
		EndIf
				IF nInd1 > 0
		For nI := Len(aCpo14[nInd1]) To 5
			aAdd(aCpo14[nInd1], "")
			aAdd(aCpo15[nInd1], "")
			aAdd(aCpo16[nInd1], "")
					Next
		For nI := Len(aCpo17[nInd1]) To 5
			aAdd(aCpo17[nInd1], "")
			aAdd(aCpo18[nInd1], "")
			aAdd(aCpo19[nInd1], "")
			aAdd(aCpo20[nInd1], "")
					Next
				ENDIF
				aAdd(aCpo21, nGerInf) //Valor total informado pelo prestador, correspondendo ao somatorio dos valores informados de todos os lotes/protocolos apresentados na data de pagamento
				aAdd(aCpo22, nGerProc) //Valor total utilizado como base pela operadora para o processamento do pagamento a ser efetuado, correspondendo ao somatorio dos valores processados de todos os lotes/protocolos apresentados na data de pagamento
				aAdd(aCpo23, nGerLib) //Valor total previsto para pagamento ao prestador. Corresponde ao somatorio dos valores liberados de todos os lotes/protocolos apresentados na data de pagamento.
				aAdd(aCpo24, nGerGlo) //Valor total glosado pela operadora, correspondendo ao somatorio dos valores glosados de todos os lotes/protocolos apresentados na data de pagamento.

		TrbBD7->(dbCloseArea())
			EndIf
	EndIf
	aAdd(aDados, aCpo04)
	aAdd(aDados, aCpo05)
	aAdd(aDados, aCpo06)
	aAdd(aDados, aCpo07)
	aAdd(aDados, aCpo08)
	aAdd(aDados, aCpo09)
	aAdd(aDados, aCpo10)
	aAdd(aDados, aCpo11)
	aAdd(aDados, aCpo12)
	aAdd(aDados, aCpo13)
	aAdd(aDados, aCpo14)
	aAdd(aDados, aCpo15)
	aAdd(aDados, aCpo16)
	aAdd(aDados, aCpo17)
	aAdd(aDados, aCpo18)
	aAdd(aDados, aCpo19)
	aAdd(aDados, aCpo20)
	aAdd(aDados, aCpo22)
	aAdd(aDados, aCpo22) // 22
	aAdd(aDados, aCpo23) // 23
	aAdd(aDados, aCpo24) // 24

	aAdd(aCpo25, {""})
	aAdd(aCpo26, {""})
	aAdd(aCpo27, {""})
	aAdd(aCpo28, {""})

	//nInd1 := 1
	IF nInd1 > 0
		For nI := Len(aCpo25[nInd1]) To 5
			aAdd(aCpo25[nInd1], "")
			aAdd(aCpo26[nInd1], "")
			aAdd(aCpo27[nInd1], "")
			aAdd(aCpo28[nInd1], "")
		Next
	ENDIF
	nDeb :=0
	nCred:=0
	nLiDeCr := 1
	nLenDC := Len(aCpo25)
	cChBMR := TrbBMR->(BMR_FILIAL+BMR_OPELOT+BMR_ANOLOT+BMR_MESLOT+BMR_NUMLOT+BMR_OPERDA+BMR_CODRDA)
	Do While ! TrbBMR->(Eof()) .And. TrbBMR->(BMR_FILIAL+BMR_OPELOT+BMR_ANOLOT+BMR_MESLOT+BMR_NUMLOT+BMR_OPERDA+BMR_CODRDA) == cChBMR

		If TrbBMR->BMR_CODLAN $ "102,103,104,105" // Debitos/Creditos Fixos e Variaveis
			BMS->(dbSetOrder(1)) //BMS_FILIAL+BMS_OPERDA+BMS_CODRDA+BMS_OPELOT+BMS_ANOLOT+BMS_MESLOT+BMS_NUMLOT+BMS_CODLAN+BMS_CODPLA+BMS_CC
			BMS->(msSeek(TrbBMR->(BMR_FILIAL+BMR_OPERDA+BMR_CODRDA+BMR_OPELOT+BMR_ANOLOT+BMR_MESLOT+BMR_NUMLOT+BMR_CODLAN)))
			Do While ! BMS->(Eof()) .And. ;
					BMS->(BMS_FILIAL+BMS_OPERDA+BMS_CODRDA+BMS_OPELOT+BMS_ANOLOT+BMS_MESLOT+BMS_NUMLOT+BMS_CODLAN) == ;
					TrbBMR->(BMR_FILIAL+BMR_OPERDA+BMR_CODRDA+BMR_OPELOT+BMR_ANOLOT+BMR_MESLOT+BMR_NUMLOT+BMR_CODLAN)

				cDePara25 := PLSIMPVINC('BLR', '37', BMS->BMS_DEBCRE)
				cDePara26 := PLSIMPVINC('BLR', '27', BMS->BMS_CODSER)
				cDePara27 := PLSIMPVINC('BLR', '27', BMS->BMS_CODSER,.T.)

				If nLiDeCr <= 5
					IF LEN(aCpo25[nLenDC]) < nLiDeCr
						AADD(aCpo25[nLenDC],"")
					ENDIF
					IF LEN(aCpo26[nLenDC]) < nLiDeCr
						AADD(aCpo26[nLenDC],"")
					ENDIF
					IF LEN(aCpo27[nLenDC]) < nLiDeCr
						AADD(aCpo27[nLenDC],"")
					ENDIF
					IF LEN(aCpo28[nLenDC]) < nLiDeCr
						AADD(aCpo28[nLenDC],"")
					ENDIF
					aCpo25[nLenDC,nLiDeCr] := Iif(!Empty( cDePara25 ),cDePara25,BMS->BMS_DEBCRE) //Indicador de debito ou credito conforme tabela de dominio no 37 (PROTHEUS COINCIDE)
					aCpo26[nLenDC,nLiDeCr] := Iif(!Empty( cDePara26 ),cDePara26,BMS->BMS_CODSER) //Codigo do debito ou credito, conforme tabela de dominio no 27
					aCpo27[nLenDC,nLiDeCr] := Iif(!Empty( cDePara27 ),cDePara27,Posicione("BBB", 1, xFilial("BBB")+BMS->BMS_CODSER, "BBB_DESCRI") )  //Descricao de valores debitados ou creditados por data de pagamento
					aCpo28[nLenDC,nLiDeCr] := BMS->BMS_VLRPAG
				Endif
				nLiDeCr++

				if BMS->BMS_DEBCRE == "1"
					nDeb+=BMS->BMS_VLRPAG
				else
					nCred+=BMS->BMS_VLRPAG
				Endif
				BMS->(dbSkip())
			EndDo
		ElseIf TrbBMR->BMR_CODLAN <> "101" .And. TrbBMR->BMR_DEBCRE <> "3"

			cDePara25 := PLSIMPVINC('BLR', '37', TrbBMR->BMR_DEBCRE)
			cDePara26 := PLSIMPVINC('BLR', '27', TrbBMR->BMR_CODLAN)
			cDePara27 := PLSIMPVINC('BLR', '27', TrbBMR->BMR_CODLAN,.T.)

			If nLiDeCr <= 5
				IF LEN(aCpo25[nLenDC]) < nLiDeCr
					AADD(aCpo25[nLenDC],"")
				ENDIF
				IF LEN(aCpo26[nLenDC]) < nLiDeCr
					AADD(aCpo26[nLenDC],"")
				ENDIF
				IF LEN(aCpo27[nLenDC]) < nLiDeCr
					AADD(aCpo27[nLenDC],"")
				ENDIF
				IF LEN(aCpo28[nLenDC]) < nLiDeCr
					AADD(aCpo28[nLenDC],"")
				ENDIF
				aCpo25[nLenDC,nLiDeCr] :=  Iif(!Empty( cDePara25 ), cDePara25 ,TrbBMR->BMR_DEBCRE) // //Indicador de debito ou credito conforme tabela de dominio no 37
				aCpo26[nLenDC,nLiDeCr] :=  Iif(!Empty( cDePara26 ), cDePara26 ,TrbBMR->BMR_CODLAN ) //Codigo do debito ou credito, conforme tabela de dominio no 27
				aCpo27[nLenDC,nLiDeCr] :=  Iif(!Empty( cDePara27 ) ,cDePara27, Posicione("BLR", 1, xFilial("BLR")+TrbBMR->(BMR_OPELOT+BMR_CODLAN), "BLR_DESCRI")  ) //Descricao de valores debitados ou creditados por data de pagamento
				aCpo28[nLenDC,nLiDeCr] :=  TrbBMR->BMR_VLRPAG
			Endif

			nLiDeCr++

			If TrbBMR->BMR_DEBCRE == "1"
				nDeb+=TrbBMR->BMR_VLRPAG
			else
				nCred+=TrbBMR->BMR_VLRPAG
			Endif
		EndIf

		TrbBMR->(dbSkip())
	EndDo

	aAdd(aDados, aCpo25)
	aAdd(aDados, aCpo26)
	aAdd(aDados, aCpo27)
	aAdd(aDados, aCpo28)
	aAdd(aCpo29, nDeb)  //Total de debitos
	aAdd(aCpo30, nCred) //Total de creditos
	aAdd(aCpo31, ((nGerLib-nDeb)+nCred)) // Total geral

	aAdd(aDados, aCpo29)
	aAdd(aDados, aCpo30)
	aAdd(aDados, aCpo31)

	DbSelectArea("BH1")
	DbSelectArea("BH2")
	BH1->(dbSetOrder(1))
	BH2->(dbSetOrder(1))


	If BH1->(MsSeek(xFilial("BH1")))

		Do While ! BH1->(Eof())

		If (Empty(Alltrim(cRdaDe)) .or. BH1->BH1_RDADE >= TrbBMR->BMR_CODRDA) .and. ;
		(Empty(Alltrim(cRdaAte)) .or. BH1->BH1_RDAATE <= TrbBMR->BMR_CODRDA) //.and. ;
		//(Empty(Alltrim(cClaPre)) .or. BH1->BH1_RDACLA == cClaPre)

			If BH2->(MsSeek(xFilial("BH2")+BH1->BH1_CODIGO))

				Do While ! BH2->(Eof()) .And. (BH1->BH1_CODIGO == BH2->BH2_CODIGO)

				aAdd(aCpo32, BH2->BH2_MSG01)

				BH2->(dbSkip())
				EndDo
			EndIf
		Else
			aAdd(aCpo32, "")
		EndIf
		BH1->(dbSkip())
		EndDo
	EndIf
	aAdd(aDados, aCpo32)
	//TrbBMR->(dbSkip())
    aAdd(aDadosTot,aDados)
    aDados := {}
    nCont := 0
EndDo

TrbBMR->(DbCloseArea())

Return aDadosTot
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡ao    ?PLSGODCO  ?Autor ?Luciano Aparecido     ?Data ?07.03.07 ³±?
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡ao ?Dados Relatório TISS (Guia Odontológica - Cobrança )        ³±?
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±?Uso      ?SigaPLS                                                     ³±?
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros?											                   ³±?
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function CABGODCO()

	Local lImpNAut	:= IIf(GetNewPar("MV_PLNAUT",0) == 0, .F., .T.) // 0 = Nao imprime procedimento nao autorizado 1 = Sim imprime
    Local lBE2Aut
	Local aDados    := {}
	Local aCpo29, aCpo30, aCpo31, aCpo32, aCpo33, aCpo34, aCpo35, aCpo36, aCpo37, aCpo38, aCpo39, aCpo40, aCpo41, aCpo42
	Local nQtdUS
	Local nVrTot
	Local nVrTotFr
	Local cChave
    Local aArea     := {}
	Local lVlTiss := GetNewPar("MV_VLTISS","1") == "1"
	Local cTissVer:= "2.02.03"
	Local cCodPro := ""
	Local cDescri := ""
	Local cTermFac:= ""
	Local cTermDen:= ""

	If FindFunction("PLSTISSVER")
		cTissVer	:= PLSTISSVER()
	EndIf

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//?Posiciona Operadora                                          ?
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	BA0->(dbSetOrder(1))
	BA0->(dbSeek(xFilial("BA0")+BD5->(BD5_OPEUSR)))
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//?Posiciona Usuario                                            ?
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	BA1->(dbSetOrder(2))
	BA1->(dbSeek(xFilial("BA1")+BD5->(BD5_OPEUSR+BD5_CODEMP+BD5_MATRIC+BD5_TIPREG)))
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//?Posiciona Sub-Contrato                                       ?
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	BQC->(dbSetOrder(1))
	BQC->(dbSeek(xFilial("BQC")+BA1->(BA1_CODINT+BA1_CODEMP+BA1_CONEMP+BA1_VERCON+BA1_SUBCON+BA1_VERSUB)))
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//?Posiciona Vidas                                  			 ?
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	BTS->(dbSetOrder(1))
	BTS->(dbSeek(xFilial("BTS")+BA1->BA1_MATVID))
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//?Posiciona Familias/Usuarios                                  ?
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	BA3->(dbSetorder(01))
	BA3->(dbSeek(xFilial("BA3")+BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC)))
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//?Posiciona Produtos de Saude - Plano                          ?
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	BI3->(dbSetOrder(1))
	If !Empty(BA1->BA1_CODPLA)
		BI3->(dbSeek(xFilial("BI3")+BA1->(BA1_CODINT+BA1_CODPLA+BA1_VERSAO)))
	Else
		BI3->(dbSeek(xFilial("BI3")+BA3->(BA3_CODINT+BA3_CODPLA+BA3_VERSAO)))
	Endif
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//?Posiciona Rede de Atendimento                                ?
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	BAU->(dbSetOrder(1))
	BAU->(dbSeek(xFilial("BAU")+BD5->BD5_CODRDA))
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//?Posiciona Especialidade                                      ?
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	BAQ->(dbSetOrder(1))
	BAQ->(MsSeek(xFilial("BAQ")+BD5->(BD5_CODOPE+BD5_CODESP)))
  /*
	BEA->(dbGoTop())
	Do While ! BEA->(Eof())

 */

 	If !BEA->(Found())
 		dbSelectArea("BEA")
 	Endif

	If cTissVer < "3"

	    //BEA_FILIAL + BEA_OPEMOV + BEA_CODLDP + BEA_CODPEG + BEA_NUMGUI + BEA_ORIMOV
	 	BEA->(dbSetOrder(12))
		BEA->(MsSeek(xFilial("BEA")+BD5->(BD5_CODOPE+BD5_CODLDP + BD5_CODPEG + BD5_NUMERO + BD5_ORIMOV)))

	    //Cabeçalho
		aAdd(aDados, BA0->BA0_SUSEP) // 1
		aAdd(aDados, BEA->(BEA_OPEMOV+"."+BEA_ANOAUT+"."+BEA_MESAUT+"-"+BEA_NUMAUT)) // 2
		aAdd(aDados, BEA->BEA_DTDIGI) // 3
		aAdd(aDados, BEA->BEA_DATPRO) // 4
		// ajuste  - 03/08/2017 - Mateus
		aAdd(aDados, iif(!Empty(BEA->BEA_SENHA) .and. !Empty(BEA->BEA_DATPRO) ,BEA->BEA_SENHA,BEA->(BEA_OPEMOV+"."+BEA_ANOAUT+"."+BEA_MESAUT+"-"+BEA_NUMAUT) ) ) // 5 - ajustar

		//aAdd(aDados, BEA->BEA_SENHA) // 5
		aAdd(aDados, IIf(Empty(BEA->BEA_SENHA), StoD(""), BEA->BEA_VALSEN)) // 6
		aAdd(aDados, BEA->BEA_NUMGUI) // 7

		// Dados do Beneficiario
		If BA1->BA1_CODINT == BA1->BA1_OPEORI .Or. empty(BA1->BA1_MATANT) // 8
			aAdd(aDados, BEA->(SubStr(BEA_OPEMOV,1,1)+SubStr(BEA_OPEMOV,2,3)+"."+BEA_CODEMP+"."+BEA_MATRIC+"."+BEA_TIPREG+"-"+BEA_DIGITO)	)
		Else
			aAdd(aDados, BA1->BA1_MATANT)
		EndIf
		aAdd(aDados, BI3->BI3_NREDUZ) // 9
		aAdd(aDados, BQC->BQC_DESCRI) //10
		aAdd(aDados, BA1->BA1_DTVLCR) // 11
		aAdd(aDados, BTS->BTS_NRCRNA) // 12
		aAdd(aDados, BEA->BEA_NOMUSR) // 13
		aAdd(aDados, BA1->(+"( "+BA1_DDD+" ) "+BA1_TELEFO)) //14
		aAdd(aDados, BEA->BEA_NOMTIT) //15

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//?Posiciona no solicitante                                     ?
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		aArea := GetArea()
            DbSelectArea("BB0")
            DbSetOrder(4)//BB0_FILIAL+BB0_ESTADO+BB0_NUMCR+BB0_CODSIG+BB0_CODOPE
            BB0->(DbSeek(xFilial("BB0")+BEA->(BEA_ESTSOL+BEA_REGSOL+BEA_SIGLA)))
		    aAdd(aDados, BB0->BB0_NOME   ) // 16
		    aAdd(aDados, BB0->BB0_NUMCR  ) // 17
		    aAdd(aDados, BB0->BB0_ESTADO ) // 18
		    aAdd(aDados, BAQ->BAQ_CBOS   ) // 19
		RestArea(aArea)

		// Dados do Contratado Executante
		lTemPFExe := .F. // Tem Profissional Executante informado na Guia
		lExecPF   := .F. // O executante (RDA) eh pessoa fisica
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//?Posiciona Rede de Atendimento                                ?
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		BAU->(dbSetOrder(1))
		BAU->(MsSeek(xFilial("BAU")+BEA->BEA_CODRDA))
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//?Posiciona Profissional de Saude                              ?
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If ! Empty(BEA->BEA_REGEXE)
			BB0->(dbSetOrder(4) )
			lTemPFExe := BB0->(dbSeek(xFilial("BB0")+BEA->(BEA_ESTEXE+BEA_REGEXE+BEA_SIGEXE)))
		Else
			If BAU->BAU_TIPPE == "F"
				BB0->(dbSetOrder(1))
				lExecPF := BB0->(dbSeek(xFilial("BB0")+BAU->BAU_CODBB0))
			EndIf
		EndIf
		aAdd(aDados, IIf(BAU->BAU_TIPPE == "F", Transform(BAU->BAU_CPFCGC, "@R 999.999.999-99"), Transform(BAU->BAU_CPFCGC, "@R 99.999.999/9999-99"))) // 20
		aAdd(aDados, BAU->BAU_NOME)  // 21
		aAdd(aDados, BEA->BEA_CODRDA)// 22
		BB8->(dbSetOrder(1))
		BB8->(dbSeek(xFilial("BB8")+BAU->BAU_CODIGO+BEA->(BEA_OPEMOV+BEA_CODLOC)))
		aAdd(aDados, BB8->BB8_EST)   // 23
		aAdd(aDados, Transform(BB8->BB8_CNES, cPicCNES)) // 24

		If lTemPFExe .Or. lExecPF
			aAdd(aDados, IIf(lTemPFExe .Or. lExecPF, BB0->BB0_NOME, "")) // 25
			aAdd(aDados, IIf(lTemPFExe .Or. lExecPF, BB0->BB0_NUMCR, "")) // 26
			aAdd(aDados, IIf(lTemPFExe .Or. lExecPF, BB0->BB0_ESTADO, "")) // 27
			aAdd(aDados, IIf(lTemPFExe .Or. lExecPF, BAQ->BAQ_CBOS, ""))//28
		Else
			aAdd(aDados, "") // 25
			aAdd(aDados, "") // 26
			aAdd(aDados, "") // 27
			aAdd(aDados, "") // 28
		EndIf

		aCpo29 := {}
		aCpo30 := {}
		aCpo31 := {}
		aCpo32 := {}
		aCpo33 := {}
		aCpo34 := {}
		aCpo35 := {}
		aCpo36 := {}
		aCpo37 := {}
		aCpo38 := {}
		aCpo39 := {}
		aCpo40 := {}
		nQtdUS   :=0
		nVrTot   :=0
		nVrTotFr :=0

		BE2->(dbSetOrder(1))
		cChave	:= xFilial("BE2")+BEA->(BEA_OPEMOV+BEA_ANOAUT+BEA_MESAUT+BEA_NUMAUT)
		If BE2->(dbSeek(cChave))
			Do While !BE2->(Eof()) .And. cChave == BE2->(BE2_FILIAL+BE2_OPEMOV+BE2_ANOAUT+BE2_MESAUT+BE2_NUMAUT)

				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³Nao imprime procedimento negado	conforme parametro			 ?
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				If !lImpNAut .And. BE2->BE2_STATUS == "0"   //1-Autorizado
					BE2->(dbSkip())
					Loop
				EndIf

				lBE2Aut := BE2->BE2_QTDPRO > 0

				BR8->(dbSetOrder(1))
				BR8->(dbSeek(xFilial("BR8")+BE2->(BE2_CODPAD+BE2_CODPRO)))

				BD6->(dbSetOrder(1)) // BD6_FILIAL + BD6_CODOPE + BD6_CODLDP + BD6_CODPEG + BD6_NUMERO + BD6_ORIMOV + BD6_SEQUEN + BD6_CODPAD + BD6_CODPRO
					If BD6->(dbSeek(xFilial("BD6")+BE2->BE2_OPEMOV+BEA->BEA_CODLDP+ BEA->BEA_CODPEG +BE2->BE2_NUMERO+BEA->BEA_ORIMOV+BE2->BE2_SEQUEN+BE2->BE2_CODPAD+BE2->BE2_CODPRO));
						.And. lBE2Aut .And. BR8->BR8_ODONTO == "1" // PROCEDIMENTO ODONTO
							aAdd(aCpo29,Posicione("BF8", 2, xFilial("BF8")+BD6->(BD6_CODPAD+BD6_CODOPE+BD6_CODTAB), "BF8_TABTIS"))//29
							//aAdd(aCpo25, BD6->BD6_CODPAD)
							aAdd(aCpo30, BD6->BD6_CODPRO) // 30
							aAdd(aCpo31, BD6->BD6_DESPRO) // 31

							//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
							//?Posiciona Dente/Região                             			 ?
							//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
							BYT->(dbSetOrder(1))
							BYT->(dbSeek(xFilial("BYT")+BD6->(BD6_CODOPE+BD6_CODLDP+BD6_CODPEG+BD6_NUMERO+BD6_SEQUEN)))
							If !Empty(BYT->BYT_CODIGO)
								aAdd(aCpo32, BYT->BYT_CODIGO) // 32
							Else
								aAdd(aCpo32, BE2->BE2_DENREG) // 32
							Endif

							//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
							//?Posiciona Face		                             			 ?
							//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
							BYS->(dbSetOrder(1))
							BYS->(dbSeek(xFilial("BYS")+BYT->BYT_CODOPE+BE2->(BE2_ANOAUT+BE2_MESAUT+BE2_NUMAUT)+BYT->(BYT_SEQUEN+BYT_CODIGO)))
							If !Empty(BYS->BYS_FACES)
								aAdd(aCpo33, BYS->BYS_FACES) // 33
							Else
								aAdd(aCpo33, BE2->BE2_FADENT) // 33
							Endif

							aAdd(aCpo34, BD6->BD6_QTDPRO)// 34

							//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
							//?Posiciona Part Hon Med. Itens		               			 ?
							//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
						   //	BD7->(dbSetOrder(4))
							//BD7->(dbSeek(xFilial("BD7")+BD6->(BD6_CODOPE+BD6_ANOPAG+BD6_MESPAG+BD6_SITUAC+BD6_FASE+BD6_CODRDA)))
							//BD7->(dbSetOrder(2))
							//BD7->(dbSeek(xFilial("BD7")+BD6->(BD6_CODOPE + BD6_CODLDP + BD6_CODPEG + BD6_NUMERO + BD6_ORIMOV + BD6_CODPAD + BD6_CODPRO ) ))
							//aAdd(aCpo31, BD7->BD7_REFTDE)//31
							//nQtdUS+=BD7->BD7_REFTDE

							nRefPro := 0
							BD7->(dbSetOrder(1))
							BD7->(dbSeek(xFilial("BD7")+BD6->(BD6_CODOPE + BD6_CODLDP + BD6_CODPEG + BD6_NUMERO + BD6_ORIMOV + BD6_SEQUEN ) ))
							While !BD7->(eof()) .and. xFilial("BD7")+BD6->(BD6_CODOPE + BD6_CODLDP + BD6_CODPEG + BD6_NUMERO + BD6_ORIMOV + BD6_SEQUEN) ==;
							             				BD7->(BD7_FILIAL + BD7_CODOPE + BD7_CODLDP + BD7_CODPEG + BD7_NUMERO + BD7_ORIMOV + BD7_SEQUEN)

								nRefPro += BD7->BD7_REFTDE
								BD7->(dbSkip())
							Enddo
							aAdd(aCpo35, nRefPro)//35
							nQtdUS+=(nRefPro*BE2->BE2_QTDPRO)

							If lVlTiss
								aAdd(aCpo36, BD6->BD6_VLRPAG) // 36
							Else
								aAdd(aCpo36, 0) // 36
							EndIf

							nVrTot+=BD6->BD6_VLRPAG
							aAdd(aCpo37, BD6->BD6_VLRTPF) // 37
							nVrTotFr +=BD6->BD6_VLRTPF
							aAdd(aCpo38, IIf(BD6->BD6_STATUS == "1","S","N")) // 38
							aAdd(aCpo39, BD6->BD6_DATPRO) // 39
							aAdd(aCpo40, "") //40

					Else
						aAdd(aCpo29, "") // 29
						aAdd(aCpo30, "") // 30
						aAdd(aCpo31, "") // 31
						aAdd(aCpo32, "") // 32
						aAdd(aCpo33, "") // 33
						aAdd(aCpo34, 0) // 34
						aAdd(aCpo35, 0) // 35
						aAdd(aCpo36, 0) // 36
						aAdd(aCpo37, 0) // 37
						aAdd(aCpo38, "") // 38
						aAdd(aCpo39, CToD("")) // 39

						aAdd(aCpo40, "") // 40

					EndIf
				BE2->(dbSkip())
			Enddo
		Endif
		aAdd(aDados,aCpo29)
		aAdd(aDados,aCpo30)
		aAdd(aDados,aCpo31)
		aAdd(aDados,aCpo32)
		aAdd(aDados,aCpo33)
		aAdd(aDados,aCpo34)
		aAdd(aDados,aCpo35)
		aAdd(aDados,aCpo36)
		aAdd(aDados,aCpo37)
		aAdd(aDados,aCpo38)
		aAdd(aDados,aCpo39)
		aAdd(aDados,aCpo40)
		// Rodape
		aAdd(aDados,BEA->BEA_DPTETA)// 41

		aAdd(aDados,BEA->BEA_TIPATO) // 42
	   //	aAdd(aDados,"")

		aAdd(aDados,BEA->BEA_TIPFAT) // 43
		//aAdd(aDados,"")

		aAdd(aDados,nQtdUS)//44

		If lVlTiss
			aAdd(aDados,nVrTot)//45
		Else
			aAdd(aDados,0)//45
		EndIf

		aAdd(aDados,nVrTotFr)//46
		aAdd(aDados, AllTrim(BEA->BEA_MSG01) + " " + AllTrim(BEA->BEA_MSG02) + " " + AllTrim(BEA->BEA_MSG03)) // 47

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//?Posiciona Local Atendimento 		               			 ?
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		BB8->(dbSetOrder(1))
		BB8->(dbSeek(xFilial("BB8")+BD6->(BD6_CODRDA+BD6_CODLOC+BD6_LOCAL)))

		aAdd(aDados, dDataBase) // 48
		aAdd(aDados,BB8->BB8_MUN)
		aAdd(aDados, dDataBase) // 49
		aAdd(aDados,BB8->BB8_MUN)
		aAdd(aDados, dDataBase) // 50
		aAdd(aDados,BB8->BB8_MUN)
		aAdd(aDados, dDataBase) // 51
		aAdd(aDados,BB8->BB8_MUN)

	Else

	    //BEA_FILIAL + BEA_OPEMOV + BEA_CODLDP + BEA_CODPEG + BEA_NUMGUI + BEA_ORIMOV
	 	BEA->(dbSetOrder(12))
		BEA->(MsSeek(xFilial("BEA")+BD5->(BD5_CODOPE+BD5_CODLDP + BD5_CODPEG + BD5_NUMERO + BD5_ORIMOV)))

	    //Cabeçalho
		aAdd(aDados, BA0->BA0_SUSEP) // 1
		aAdd(aDados, BD5->(BD5_OPEMOV+"."+BD5_ANOAUT+"."+BD5_MESAUT+"-"+BD5_NUMAUT)) // 2
		aAdd(aDados, BD5->BD5_NUMERO) // 3
		aAdd(aDados, BD5->BD5_DATPRO) // 4
		aAdd(aDados, BD5->BD5_SENHA) // 5
		aAdd(aDados, IIf(Empty(BD5->BD5_SENHA), StoD(""), BD5->BD5_VALSEN)) // 6
		aAdd(aDados, "") // 7

		// Dados do Beneficiario
		If BA1->BA1_CODINT == BA1->BA1_OPEORI .Or. empty(BA1->BA1_MATANT) // 8
			aAdd(aDados, BEA->(SubStr(BEA_OPEMOV,1,1)+SubStr(BEA_OPEMOV,2,3)+"."+BEA_CODEMP+"."+BEA_MATRIC+"."+BEA_TIPREG+"-"+BEA_DIGITO)	)
		Else
			aAdd(aDados, BA1->BA1_MATANT)
		EndIf
		aAdd(aDados, BI3->BI3_NREDUZ) // 9
		aAdd(aDados, BQC->BQC_DESCRI) //10
		aAdd(aDados, BA1->BA1_DTVLCR) // 11
		aAdd(aDados, BTS->BTS_NRCRNA) // 12
		aAdd(aDados, BEA->BEA_NOMUSR) // 13
		aAdd(aDados, BA1->(+"( "+BA1_DDD+" ) "+BA1_TELEFO)) //14
		aAdd(aDados, BEA->BEA_NOMTIT) //15
		If ! Empty(BE4->BE4_ATENRN)
			If BE4->BE4_ATENRN == "1"
				aAdd(aDados, "S" ) //16
			Else
				aAdd(aDados, "N" ) //16
			EndIf
		Else
			aAdd(aDados, "" ) //16
		EndIf

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//?Posiciona no solicitante                                     ?
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		aArea := GetArea()
            DbSelectArea("BB0")
            DbSetOrder(4)//BB0_FILIAL+BB0_ESTADO+BB0_NUMCR+BB0_CODSIG+BB0_CODOPE
            BB0->(DbSeek(xFilial("BB0")+BEA->(BEA_ESTSOL+BEA_REGSOL+BEA_SIGLA)))
		    aAdd(aDados, BB0->BB0_NOME   ) // 17
		    aAdd(aDados, BB0->BB0_NUMCR  ) // 18
		    aAdd(aDados, BB0->BB0_ESTADO ) // 19
		    aAdd(aDados, BAQ->BAQ_CBOS   ) // 20
		RestArea(aArea)

		// Dados do Contratado Executante
		lTemPFExe := .F. // Tem Profissional Executante informado na Guia
		lExecPF   := .F. // O executante (RDA) eh pessoa fisica
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//?Posiciona Rede de Atendimento                                ?
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		BAU->(dbSetOrder(1))
		BAU->(MsSeek(xFilial("BAU")+BEA->BEA_CODRDA))
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//?Posiciona Profissional de Saude                              ?
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If ! Empty(BEA->BEA_REGEXE)
			BB0->(dbSetOrder(4) )
			lTemPFExe := BB0->(dbSeek(xFilial("BB0")+BEA->(BEA_ESTEXE+BEA_REGEXE+BEA_SIGEXE)))
		Else
			If BAU->BAU_TIPPE == "F"
				BB0->(dbSetOrder(1))
				lExecPF := BB0->(dbSeek(xFilial("BB0")+BAU->BAU_CODBB0))
			EndIf
		EndIf
		aAdd(aDados, IIf(BAU->BAU_TIPPE == "F", Transform(BAU->BAU_CPFCGC, "@R 999.999.999-99"), Transform(BAU->BAU_CPFCGC, "@R 99.999.999/9999-99"))) // 21
		aAdd(aDados, BAU->BAU_NOME)  // 22
		aAdd(aDados, BEA->BEA_CODRDA)// 23
		BB8->(dbSetOrder(1))
		BB8->(dbSeek(xFilial("BB8")+BAU->BAU_CODIGO+BEA->(BEA_OPEMOV+BEA_CODLOC)))
		aAdd(aDados, BB8->BB8_EST)   // 24
		aAdd(aDados, Transform(BB8->BB8_CNES, cPicCNES)) // 25

		If lTemPFExe .Or. lExecPF
			aAdd(aDados, IIf(lTemPFExe .Or. lExecPF, BB0->BB0_NOME, "")) // 26
			aAdd(aDados, IIf(lTemPFExe .Or. lExecPF, BB0->BB0_NUMCR, "")) // 27
			aAdd(aDados, IIf(lTemPFExe .Or. lExecPF, BB0->BB0_ESTADO, "")) // 28
			aAdd(aDados, IIf(lTemPFExe .Or. lExecPF, BAQ->BAQ_CBOS, ""))//29
		Else
			aAdd(aDados, "") // 26
			aAdd(aDados, "") // 27
			aAdd(aDados, "") // 28
			aAdd(aDados, "") // 29
		EndIf

		aCpo30 := {}
		aCpo31 := {}
		aCpo32 := {}
		aCpo33 := {}
		aCpo34 := {}
		aCpo35 := {}
		aCpo36 := {}
		aCpo37 := {}
		aCpo38 := {}
		aCpo39 := {}
		aCpo40 := {}
		aCpo41 := {}
		aCpo42 := {}

		nQtdUS   :=0
		nVrTot   :=0
		nVrTotFr :=0

		BE2->(dbSetOrder(1))
		cChave	:= xFilial("BE2")+BEA->(BEA_OPEMOV+BEA_ANOAUT+BEA_MESAUT+BEA_NUMAUT)
		If BE2->(dbSeek(cChave))
			Do While !BE2->(Eof()) .And. cChave == BE2->(BE2_FILIAL+BE2_OPEMOV+BE2_ANOAUT+BE2_MESAUT+BE2_NUMAUT)

				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³Nao imprime procedimento negado	conforme parametro			 ?
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				If cTissVer < "3"
					If !lImpNAut .And. BE2->BE2_STATUS == "0"   //1-Autorizado
						BE2->(dbSkip())
						Loop
					EndIf
				End if

				lBE2Aut := BE2->BE2_QTDPRO > 0

				BR8->(dbSetOrder(1))
				BR8->(dbSeek(xFilial("BR8")+BE2->(BE2_CODPAD+BE2_CODPRO)))

				BD6->(dbSetOrder(1)) // BD6_FILIAL + BD6_CODOPE + BD6_CODLDP + BD6_CODPEG + BD6_NUMERO + BD6_ORIMOV + BD6_SEQUEN + BD6_CODPAD + BD6_CODPRO
					If BD6->(dbSeek(xFilial("BD6")+BE2->BE2_OPEMOV+BEA->BEA_CODLDP+ BEA->BEA_CODPEG +BE2->BE2_NUMERO+BEA->BEA_ORIMOV+BE2->BE2_SEQUEN+BE2->BE2_CODPAD+BE2->BE2_CODPRO));
						.And. lBE2Aut .And. BR8->BR8_ODONTO == "1" // PROCEDIMENTO ODONTO

							cCodTab := PLSIMPVINC("BR4","87"	,	BD6->BD6_CODPAD					,.F.)
							cCodPro := PLSIMPVINC("BR8",cCodTab	,	BD6->BD6_CODPAD+BD6->BD6_CODPRO	,.F.)
							cDescri := PLSIMPVINC("BR8",cCodTab	,	BD6->BD6_CODPAD+BD6->BD6_CODPRO	,.T.)

							If Empty(cCodTab) .Or. Empty(cCodPro) .Or. Empty(cDescri)
								cCodTab := BD6->BD6_CODPAD
								cCodPro := BD6->BD6_CODPRO
								cDescri := Posicione("BR8",1, xFilial("BR8")+BD6->(BD6_CODPAD+BD6_CODPRO), "BR8_DESCRI")
							Endif

							aAdd(aCpo30, cCodTab) //30-Tabela
							aAdd(aCpo31, cCodPro) //31-Codigo do Prodecimento/Item assistencial
							aAdd(aCpo32, cDescri) //32-Descricao

							//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
							//?Posiciona Dente/Região                             			 ?
							//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
							BYT->(dbSetOrder(1))
							BYT->(dbSeek(xFilial("BYT")+BD6->(BD6_CODOPE+BD6_CODLDP+BD6_CODPEG+BD6_NUMERO+BD6_SEQUEN)))
							If !Empty(BYT->BYT_CODIGO)
								cTermDen := PLSIMPVINC('B04', '28', BYT->BYT_CODIGO)
								If Empty(cTermDen)
									cTermDen := BYT->BYT_CODIGO
								Endif
							Else
								cTermDen := PLSIMPVINC('B04', '42', BE2->BE2_DENREG)
								If Empty(cTermDen)
									cTermDen := BE2->BE2_DENREG
								Endif
							Endif

							aAdd(aCpo33, cTermDen)// 33 - Dente/Região

							//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
							//?Posiciona Face		                             			 ?
							//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
							BYS->(dbSetOrder(1))
							BYS->(dbSeek(xFilial("BYS")+BYT->BYT_CODOPE+BE2->(BE2_ANOAUT+BE2_MESAUT+BE2_NUMAUT)+BYT->(BYT_SEQUEN+BYT_CODIGO)))
							If !Empty(BYS->BYS_FACES)
								cTermFac:= PLSIMPVINC('B04', '32', BYS->BYS_FACES)
								If Empty(cTermFac)
									cTermFac := BYS->BYS_FACES
								Endif
							Else
								cTermFac:= PLSIMPVINC('B09', '32', BE2->BE2_FADENT)
								If Empty(cTermFac)
									cTermFac := BE2->BE2_FADENT
								Endif
							Endif

							aAdd(aCpo34, cTermFac)// 34 - Face
							aAdd(aCpo35, BD6->BD6_QTDPRO)// 35

							//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
							//?Posiciona Part Hon Med. Itens		               			 ?
							//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
						   //	BD7->(dbSetOrder(4))
							//BD7->(dbSeek(xFilial("BD7")+BD6->(BD6_CODOPE+BD6_ANOPAG+BD6_MESPAG+BD6_SITUAC+BD6_FASE+BD6_CODRDA)))
							//BD7->(dbSetOrder(2))
							//BD7->(dbSeek(xFilial("BD7")+BD6->(BD6_CODOPE + BD6_CODLDP + BD6_CODPEG + BD6_NUMERO + BD6_ORIMOV + BD6_CODPAD + BD6_CODPRO ) ))
							//aAdd(aCpo31, BD7->BD7_REFTDE)//31
							//nQtdUS+=BD7->BD7_REFTDE

							nRefPro := 0
							BD7->(dbSetOrder(1))
							BD7->(dbSeek(xFilial("BD7")+BD6->(BD6_CODOPE + BD6_CODLDP + BD6_CODPEG + BD6_NUMERO + BD6_ORIMOV + BD6_SEQUEN ) ))
							While !BD7->(eof()) .and. xFilial("BD7")+BD6->(BD6_CODOPE + BD6_CODLDP + BD6_CODPEG + BD6_NUMERO + BD6_ORIMOV + BD6_SEQUEN) ==;
							             				BD7->(BD7_FILIAL + BD7_CODOPE + BD7_CODLDP + BD7_CODPEG + BD7_NUMERO + BD7_ORIMOV + BD7_SEQUEN)
								nRefPro += BD7->BD7_REFTDE
								BD7->(dbSkip())
							Enddo
							aAdd(aCpo36, nRefPro)//36
							nQtdUS+=(nRefPro*BE2->BE2_QTDPRO)

							If lVlTiss
								aAdd(aCpo37, BD6->BD6_VLRPAG) // 37
							Else
								aAdd(aCpo37, 0) // 36
							EndIf

							nVrTot+=BD6->BD6_VLRPAG
							aAdd(aCpo38, BD6->BD6_VLRTPF) // 38
							nVrTotFr +=BD6->BD6_VLRTPF
							aAdd(aCpo39, IIf(BD6->BD6_STATUS == "1","S","N")) // 39

							BEG->(dbSetOrder(1))
							BEG->(DbSeek(xFilial("BEG")+BE2->BE2_OPEMOV+BE2->BE2_ANOAUT+BE2->BE2_MESAUT+BE2->BE2_NUMAUT+BE2->BE2_SEQUEN))
							aAdd(aCpo40, PLSIMPVINC('BCT', '38', BEG->BEG_CODGLO)) // 40

							aAdd(aCpo41, BD6->BD6_DATPRO) // 41
							aAdd(aCpo42, "") //42

					Else
						aAdd(aCpo30, "") // 30
						aAdd(aCpo31, "") // 31
						aAdd(aCpo32, "") // 32
						aAdd(aCpo33, "") // 33
						aAdd(aCpo34, "") // 34
						aAdd(aCpo35, "") // 35
						aAdd(aCpo36, 0) // 36
						aAdd(aCpo37, 0) // 37
						aAdd(aCpo38, 0) // 38
						aAdd(aCpo39, "") // 39
						aAdd(aCpo40, "") // 40
						aAdd(aCpo41, CToD("")) // 41
						aAdd(aCpo42, "") // 42

					EndIf
				BE2->(dbSkip())
			Enddo
		Endif
		aAdd(aDados,aCpo30)
		aAdd(aDados,aCpo31)
		aAdd(aDados,aCpo32)
		aAdd(aDados,aCpo33)
		aAdd(aDados,aCpo34)
		aAdd(aDados,aCpo35)
		aAdd(aDados,aCpo36)
		aAdd(aDados,aCpo37)
		aAdd(aDados,aCpo38)
		aAdd(aDados,aCpo39)
		aAdd(aDados,aCpo40)
		aAdd(aDados,aCpo41)
		aAdd(aDados,aCpo42)
		// Rodape
		aAdd(aDados,BEA->BEA_DPTETA)// 43
		aAdd(aDados, BEA->BEA_TIPATO) // 44
		aAdd(aDados,BEA->BEA_TIPFAT) // 45
		aAdd(aDados,nQtdUS)//46
		If lVlTiss
			aAdd(aDados,nVrTot)//47
		Else
			aAdd(aDados,0)//47
		EndIf
		aAdd(aDados,nVrTotFr)//48
		aAdd(aDados, AllTrim(BEA->BEA_MSG01) + " " + AllTrim(BEA->BEA_MSG02)+ " " + AllTrim(BEA->BEA_MSG03)) // 48
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//?Posiciona Local Atendimento 		               			 ?
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		BB8->(dbSetOrder(1))
		BB8->(dbSeek(xFilial("BB8")+BD6->(BD6_CODRDA+BD6_CODLOC+BD6_LOCAL)))

		aAdd(aDados, dDataBase)	  	// 50
		aAdd(aDados,BB8->BB8_MUN) 	// 51
		aAdd(aDados, dDataBase) 		// 52
		aAdd(aDados,BB8->BB8_MUN)	// 53
		aAdd(aDados, dDataBase) 		// 54
		aAdd(aDados,BB8->BB8_MUN) 	// 55
		aAdd(aDados, dDataBase)  	// 56
		aAdd(aDados,BB8->BB8_MUN) 	// 57

	Endif
	//BEA->(DbCloseArea())

Return aDados

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡ao    ?PLSGODSO  ?Autor ?Luciano Aparecido     ?Data ?12.03.07 ³±?
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡ao ?Dados Relatório TISS (Guia Odontológica - Solicitação )     ³±?
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±?Uso      ?SigaPLS                                                     ³±?
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros?                                                            ³±?
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function CABGODSO(nGuia)

	Local aDados    := {}
	Local cVerTISS  := PLSTISSVER()

	If cVerTISS >= "3" .AND. FindFunction("PLSSOLINI")
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//?Posiciona Operadora                                          ?
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		BA0->(dbSetOrder(1))
		BA0->(dbSeek(xFilial("BA0")+BEA->(BEA_OPEUSR)))
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//?Posiciona Usuario                                            ?
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		BA1->(dbSetOrder(2))
		BA1->(dbSeek(xFilial("BA1")+BEA->(BEA_OPEUSR+BEA_CODEMP+BEA_MATRIC+BEA_TIPREG)))
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//?Posiciona Sub-Contrato                                       ?
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		BQC->(dbSetOrder(1))
		BQC->(dbSeek(xFilial("BQC")+BA1->(BA1_CODINT+BA1_CODEMP+BA1_CONEMP+BA1_VERCON+BA1_SUBCON+BA1_VERSUB)))
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//?Posiciona Vidas                                  			 ?
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		BTS->(dbSetOrder(1))
		BTS->(dbSeek(xFilial("BTS")+BA1->BA1_MATVID))
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//?Posiciona Familias/Usuarios                                  ?
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		BA3->(dbSetorder(01))
		BA3->(dbSeek(xFilial("BA3")+BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC)))
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//?Posiciona Produtos de Saude - Plano                          ?
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		BI3->(dbSetOrder(1))
		If !Empty(BA1->BA1_CODPLA)
			BI3->(dbSeek(xFilial("BI3")+BA1->(BA1_CODINT+BA1_CODPLA+BA1_VERSAO)))
		Else
			BI3->(dbSeek(xFilial("BI3")+BA3->(BA3_CODINT+BA3_CODPLA+BA3_VERSAO)))
		Endif
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//?Posiciona Rede de Atendimento                                ?
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		BAU->(dbSetOrder(1))
		BAU->(dbSeek(xFilial("BAU")+BEA->BEA_CODRDA))
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//?Posiciona Especialidade                                      ?
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		BAQ->(dbSetOrder(1))
		BAQ->(MsSeek(xFilial("BAQ")+BEA->(BEA_OPEMOV+BEA_CODESP)))


 	    //Cabeçalho
		aAdd(aDados, BA0->BA0_SUSEP) // 1
		aAdd(aDados, BEA->(BEA_OPEMOV+"."+BEA_ANOAUT+"."+BEA_MESAUT+"-"+BEA_NUMAUT)) // 2
		aAdd(aDados, BEA->BEA_NUMGUI) // 3

		aAdd(aDados, "") // 4
		aAdd(aDados, BEA->BEA_NOMUSR) // 5

		// Dados do Beneficiario
		If BA1->BA1_CODINT == BA1->BA1_OPEORI .Or. empty(BA1->BA1_MATANT) // 6
			aAdd(aDados, BEA->(SubStr(BEA_OPEMOV,1,1)+SubStr(BEA_OPEMOV,2,3)+"."+BEA_CODEMP+"."+BEA_MATRIC+"."+BEA_TIPREG+"-"+BEA_DIGITO)	)
		Else
			aAdd(aDados, BA1->BA1_MATANT)
		EndIf

		aAdd(aDados, "") //7
		aAdd(aDados, "") //8
		aAdd(aDados, BEA->BEA_SCDPER) // 9
		aAdd(aDados, BEA->BEA_ALTMOL) // 10
		aAdd(aDados, "") //11

		BB8->(dbSetOrder(1))
		BB8->(dbSeek(xFilial("BB8")+BAU->BAU_CODIGO+BEA->(BEA_OPEMOV+BEA_CODLOC)))

		aAdd(aDados, dDataBase) //12
		aAdd(aDados, "") //13
		aAdd(aDados, dDataBase)//14
		aAdd(aDados, "") //15
		aAdd(aDados, dDataBase) //16

	Else
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//?Posiciona Operadora                                          ?
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		BA0->(dbSetOrder(1))
		BA0->(dbSeek(xFilial("BA0")+BEA->(BEA_OPEUSR)))
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//?Posiciona Usuario                                            ?
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		BA1->(dbSetOrder(2))
		BA1->(dbSeek(xFilial("BA1")+BEA->(BEA_OPEUSR+BEA_CODEMP+BEA_MATRIC+BEA_TIPREG)))
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//?Posiciona Sub-Contrato                                       ?
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		BQC->(dbSetOrder(1))
		BQC->(dbSeek(xFilial("BQC")+BA1->(BA1_CODINT+BA1_CODEMP+BA1_CONEMP+BA1_VERCON+BA1_SUBCON+BA1_VERSUB)))
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//?Posiciona Vidas                                  			 ?
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		BTS->(dbSetOrder(1))
		BTS->(dbSeek(xFilial("BTS")+BA1->BA1_MATVID))
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//?Posiciona Familias/Usuarios                                  ?
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		BA3->(dbSetorder(01))
		BA3->(dbSeek(xFilial("BA3")+BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC)))
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//?Posiciona Produtos de Saude - Plano                          ?
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		BI3->(dbSetOrder(1))
		If !Empty(BA1->BA1_CODPLA)
			BI3->(dbSeek(xFilial("BI3")+BA1->(BA1_CODINT+BA1_CODPLA+BA1_VERSAO)))
		Else
			BI3->(dbSeek(xFilial("BI3")+BA3->(BA3_CODINT+BA3_CODPLA+BA3_VERSAO)))
		Endif
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//?Posiciona Rede de Atendimento                                ?
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		BAU->(dbSetOrder(1))
		BAU->(dbSeek(xFilial("BAU")+BEA->BEA_CODRDA))
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//?Posiciona Especialidade                                      ?
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		BAQ->(dbSetOrder(1))
		BAQ->(MsSeek(xFilial("BAQ")+BEA->(BEA_OPEMOV+BEA_CODESP)))


	 	    //Cabeçalho
			aAdd(aDados, BA0->BA0_SUSEP) // 1
			aAdd(aDados, BEA->(BEA_OPEMOV+"."+BEA_ANOAUT+"."+BEA_MESAUT+"-"+BEA_NUMAUT)) // 2
			aAdd(aDados, BEA->BEA_NUMGUI) // 3

			// Dados do Beneficiario
			If BA1->BA1_CODINT == BA1->BA1_OPEORI .Or. empty(BA1->BA1_MATANT) // 4
				aAdd(aDados, BEA->(SubStr(BEA_OPEMOV,1,1)+SubStr(BEA_OPEMOV,2,3)+"."+BEA_CODEMP+"."+BEA_MATRIC+"."+BEA_TIPREG+"-"+BEA_DIGITO)	)
			Else
				aAdd(aDados, BA1->BA1_MATANT)
			EndIf
			aAdd(aDados, BI3->BI3_NREDUZ) // 5
			aAdd(aDados, BQC->BQC_DESCRI) // 6
			aAdd(aDados, BA1->BA1_DTVLCR) // 7
			//aAdd(aDados, BTS->BTS_NRCRNA)

			aAdd(aDados, BEA->BEA_NOMUSR) // 8
			aAdd(aDados, BA1->(+"( "+BA1_DDD+" ) "+BA1_TELEFO)) //9
			aAdd(aDados, BEA->BEA_NOMTIT) //10

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//?Posiciona Profissional de Saude                              ?
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			aAdd(aDados, IIf(BAU->BAU_TIPPE == "F", Transform(BAU->BAU_CPFCGC, "@R 999.999.999-99"), Transform(BAU->BAU_CPFCGC, "@R 99.999.999/9999-99"))) // 11
			aAdd(aDados, BAU->BAU_NOME)  // 12
			aAdd(aDados, BEA->BEA_CODRDA)// 13
			BB8->(dbSetOrder(1))
			BB8->(dbSeek(xFilial("BB8")+BAU->BAU_CODIGO+BEA->(BEA_OPEMOV+BEA_CODLOC)))
			aAdd(aDados, BB8->BB8_EST)   // 14
			aAdd(aDados, Transform(BB8->BB8_CNES, cPicCNES)) // 15
			aAdd(aDados, BEA->BEA_NOMSOL) //16
			aAdd(aDados, BEA->BEA_REGSOL)//17
			aAdd(aDados, BEA->BEA_ESTSOL)//18
			aAdd(aDados, BAQ->BAQ_CBOS) // 19
			aAdd(aDados, BEA->BEA_SCDPER) // 20
			aAdd(aDados, BEA->BEA_ALTMOL) // 21
			aAdd(aDados, "") // 22 //Criar Campo Observção Inicial ????????

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//?Posiciona Local Atendimento 		               			 ?
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			BB8->(dbSetOrder(1))
			BB8->(dbSeek(xFilial("BB8")+BD6->(BD6_CODRDA+BD6_CODLOC+BD6_LOCAL)))

			aAdd(aDados, dDataBase) // 23
			aAdd(aDados,BB8->BB8_MUN)
			aAdd(aDados, dDataBase) // 24
			aAdd(aDados,BB8->BB8_MUN)
			aAdd(aDados, dDataBase) // 25
			aAdd(aDados,BB8->BB8_MUN)
		EndIf
Return aDados

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡ao    ?PLSDPGTOD ?Autor ?Luciano Aparecido     ?Data ?14.03.07 ³±?
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡ao ?Dados Relatório TISS (Guia Odontológica - Demon. Pagamento )³±?
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±?Uso      ?SigaPLS                                                     ³±?
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros?cCodOpe - Código da Operadora                               ³±?
±±?         ?cRdaDe  - Código da RDA a ser processada (de)               ³±?
±±?         ?cRdaAte - Código da RDA a ser processada (At?              ³±?
±±?         ?cAno    - Informe o Ano a ser processado                    ³±?
±±?         ?cMes    - Informe o Mês a ser processado                    ³±?
±±?         ?cClaPre - Classe RDA                                        ³±?
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function CABDPGTOD(cCodOpe, cRdaDe, cRdaAte, cAno, cMes, cClaPre, cNmTitPg)

Local aCpo08,aCpo09,aCpo10,aCpo11,aCpo12,aCpo13,aCpo14,aCpo15,aCpo16,aCpo17,aCpo18,aCpo19,aCpo20,aCpo21,aCpo22,aCpo23,aCpo30,aCpo38,aCpo39,aCpo40
Local aCpo02,aCpo03,aCpo04,aCpo05,aCpo06,aCpo07,aCpo24,aCpo25,aCpo26,aCpo27,aCpo28,aCpo29,aCpo31,aCpo32,aCpo33,aCpo34,aCpo35,aCpo36,aCpo37,aCpo41
Local nInd1, nInd2 , nInd3
Local nCont:=0
Local nValorDC 	:= 0
Local aDados
Local cSQL, cSQL1
Local nDeb,nCred,nDebNT,nCredNT
Local nProcGui,nGloGui,nLibGui
Local nProcLot,nGloLot,nLibLot
Local nProcGer,nGloGer,nLibGer
Local cChRDA,cChLot,cChGuia
LOCAL cNmLotPg		:= ""
LOCAL cRdaLote		:= ""
DEFAULT cNmTitPg := ""

aDados := {}
DBSELECTAREA("SE2")
// Variaveis para buscar o BMR pelo numero do titulo.
If !Empty(cNmTitPg)
	SE2->(dbSetorder(01))
	If SE2->(dbSeek(xFilial("SE2")+cNmTitPg))
		cCodOpe  := SE2->E2_PLOPELT
		cNmLotPg := substr(SE2->E2_PLLOTE,7,4) //SE2->E2_PLLOTE
		cRdaLote := SE2->E2_CODRDA
		cAno	 := SE2->E2_ANOBASE
		cMes	 := SE2->E2_MESBASE
	Endif
Endif

cSQL := "SELECT BMR_ANOLOT, BMR_CODLAN, BMR_CODRDA, BMR_DEBCRE, BMR_FILIAL, BMR_MESLOT, BMR_NUMLOT, BMR_OPELOT, BMR_OPERDA, BMR_VLRPAG"
cSQL += "  FROM " + RetSqlName("BMR")
cSQL += " WHERE BMR_FILIAL = '" + xFilial("BMR") + "' AND "
cSQL += " BMR_OPELOT = '" + cCodOpe + "' AND "

If !Empty(cNmLotPg)
	cSQL += " BMR_CODRDA = '" + cRdaLote + "' AND "
	cSQL += " BMR_NUMLOT = '" + cNmLotPg + "' AND "

Else
	cSQL += " ( BMR_CODRDA >= '" + cRdaDe    + "' AND BMR_CODRDA <= '" + cRdaAte    + "' ) AND "

Endif
cSQL += " BMR_ANOLOT = '" + cAno + "' AND "
cSQL += " BMR_MESLOT = '" + cMes + "' AND "

cSql += RetSQLName("BMR")+".D_E_L_E_T_ = ' '"
cSQL += " ORDER BY BMR_FILIAL, BMR_OPELOT, BMR_ANOLOT, BMR_MESLOT, BMR_NUMLOT, BMR_OPERDA, BMR_CODRDA, BMR_CODLAN "

PlsQuery(cSQL,"TrbBMR")

// BA0 - Operadoras de Saude
BA0->(dbSetOrder(1))
BA0->(msSeek(xFilial("BA0")+TrbBMR->(BMR_OPERDA)))

Do While ! TrbBMR->(Eof())
	nValorDC := 0

	nCont+=1
	// BAU - Redes de Atendimento
	BAU->(dbSetOrder(1))
	BAU->(msSeek(xFilial("BAU")+TrbBMR->BMR_CODRDA))

	// BAF - Lotes de Pagamentos RDA
	BAF->(dbSetOrder(1))
	BAF->(msSeek(xFilial("BAF")+TrbBMR->(BMR_OPERDA+BMR_ANOLOT+BMR_MESLOT+BMR_NUMLOT)))
	If Empty(cNmTitPg) .and. Empty(cNmLotPg)
		cSQL := " SELECT R_E_C_N_O_ E2_RECNO,E2_VENCTO, E2_VALOR "
		cSQL += "  FROM " + RetSQLName("SE2")
		cSQL += "  WHERE E2_FILIAL = '" + xFilial("SE2") + "' "
		cSQL += "    AND E2_PLOPELT = '" + TrbBMR->BMR_OPELOT + "'"
		cSQL += "    AND E2_PLLOTE = '" + TrbBMR->(BMR_ANOLOT+BMR_MESLOT+BMR_NUMLOT) + "'"
		cSQL += "    AND E2_CODRDA = '" + TrbBMR->BMR_CODRDA + "'"
		cSQL += "    AND D_E_L_E_T_ = ' ' "
		PlsQuery(cSQL,"TrbSE2")

		If ! TrbSE2->(Eof())
			SE2->(dbGoTo(TrbSE2->(E2_RECNO)))
		EndIf

		TrbSE2->(DbCloseArea())
	Endif

	cSQL := "SELECT BD7_CODEMP, BD7_CODLDP, BD7_CODOPE, BD7_CODPAD, BD7_CODPEG, BD7_CODPRO, BD7_CODRDA, BD7_CODTPA, BD7_DATPRO, BD7_MATRIC, BD7_NOMRDA,BD7_NOMUSR, BD7_NUMERO, BD7_NUMLOT, BD7_OPELOT, BD7_ORIMOV, BD7_SEQUEN, BD7_TIPREG, BD7_MOTBLO, BD7_VLRGLO, BD7_VLRPAG,BD7_ANOPAG, BD7_MESPAG "
	cSQL += "  FROM " + RetSqlName("BD7")
	cSQL += " WHERE BD7_FILIAL = '" + xFilial("BD7") + "'"
	cSQL += "   AND BD7_NUMLOT = '" + TrbBMR->(BMR_ANOLOT+BMR_MESLOT+BMR_NUMLOT) + "'"
	cSQL += "   AND BD7_CODRDA = '" + TrbBMR->(BMR_CODRDA)+ "'"
	cSQL += "   AND D_E_L_E_T_ = ' '"
	cSQL += " ORDER BY BD7_CODLDP, BD7_CODPEG"
	PlsQuery(cSQL,"TrbBD7")

	If nCont == 1

		aCpo02 := {}
		aCpo03 := {}
		aCpo04 := {}
		aCpo05 := {}
		aCpo06 := {}
		aCpo07 := {}
		aCpo08 := {}
		aCpo09 := {}
		aCpo10 := {}
		aCpo11 := {}
		aCpo12 := {}
		aCpo13 := {}
		aCpo14 := {}
		aCpo15 := {}
		aCpo16 := {}
		aCpo17 := {}
		aCpo18 := {}
		aCpo19 := {}
		aCpo20 := {}
		aCpo21 := {}
		aCpo22 := {}
		aCpo23 := {}
		aCpo24 := {}
		aCpo25 := {}
		aCpo26 := {}
		aCpo27 := {}
		aCpo28 := {}
		aCpo29 := {}
		aCpo30 := {}
		aCpo31 := {}
		aCpo32 := {}
		aCpo33 := {}
		aCpo34 := {}
		aCpo35 := {}
		aCpo36 := {}
		aCpo37 := {}
		aCpo38 := {}
		aCpo39 := {}
		aCpo40 := {}
		aCpo41 := {}

		aAdd(aCpo09,{})
		aAdd(aCpo10,{})
		aAdd(aCpo11,{})
		aAdd(aCpo12,{})
		aAdd(aCpo13,{})
		aAdd(aCpo14,{})
		aAdd(aCpo15,{})
		aAdd(aCpo16,{})
		aAdd(aCpo17,{})
		aAdd(aCpo18,{})
		aAdd(aCpo19,{})
		aAdd(aCpo20,{})
		aAdd(aCpo21,{})
		aAdd(aCpo22,{})
		aAdd(aCpo23,{})
		aAdd(aCpo24,{})
		aAdd(aCpo25,{})
		aAdd(aCpo26,{})
		aAdd(aCpo27,{})
		aAdd(aCpo28,{})
		aAdd(aCpo29,{})
		aAdd(aCpo30,{})
		aAdd(aCpo33,{})
		aAdd(aCpo34,{})
		aAdd(aCpo35,{})
		aAdd(aCpo38,{})
		aAdd(aCpo40,{})
		aAdd(aCpo41,{})

	Endif
	nInd1 :=nCont
	nProcGer:=0
	nLibGer :=0
	nGloGer :=0

	// BDT - Calendário de Pagamento
	BDT->(dbSetOrder(1))
	BDT->(msSeek(xFilial("BDT")+TrbBD7->(BD7_CODOPE+BD7_ANOPAG+BD7_MESPAG)))
	If nCont == 1
		aAdd(aDados, BA0->BA0_SUSEP) // 1
	Endif

	aAdd(aCpo02, BAF->(BAF_ANOLOT+BAF_MESLOT+BAF_NUMLOT))
	aAdd(aCpo03, BA0->BA0_NOMINT)
	aAdd(aCpo04, Transform(BA0->BA0_CGC, "@R 99.999.999/9999-99"))
	aAdd(aCpo05, {(BDT->BDT_DATINI),(BDT->BDT_DATFIN)})
	aAdd(aCpo06, BAU->(BAU_CODIGO))
	aAdd(aCpo07, BAU->BAU_NOME)
	aAdd(aCpo08, IIf(BAU->BAU_TIPPE == "F", Transform(BAU->BAU_CPFCGC, "@R 999.999.999-99"), Transform(BAU->BAU_CPFCGC, "@R 99.999.999/9999-99")))
	aAdd(aCpo09,{})
	aAdd(aCpo10,{})
	aAdd(aCpo11,{})
	aAdd(aCpo12,{})
	aAdd(aCpo13,{})
	aAdd(aCpo14,{})
	aAdd(aCpo15,{})
	aAdd(aCpo16,{})
	aAdd(aCpo17,{})
	aAdd(aCpo18,{})
	aAdd(aCpo19,{})
	aAdd(aCpo20,{})
	aAdd(aCpo21,{})
	aAdd(aCpo22,{})
	aAdd(aCpo23,{})
	aAdd(aCpo24,{})
	aAdd(aCpo25,{})
	aAdd(aCpo26,{})
	aAdd(aCpo27,{})
	aAdd(aCpo28,{})
	aAdd(aCpo29,{})
	aAdd(aCpo30,{})
	aAdd(aCpo33,{})
	aAdd(aCpo34,{})
	aAdd(aCpo35,{})
	aAdd(aCpo38,{})
	aAdd(aCpo40,{})
	aAdd(aCpo41,{})
	nInd1 := Len(aCpo02)

	nProcLot:=0
	nLibLot :=0
	nGloLot :=0
	nProcGer:=0
	nLibGer :=0
	nGloGer :=0

	cChRDA  := TrbBD7->(BD7_NUMLOT+BD7_CODRDA)
	Do While ! TrbBD7->(Eof()) .And. TrbBD7->(BD7_NUMLOT+BD7_CODRDA) ==  cChRDA
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//?Tabela Padrão                                    			 ?
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		BR8->(dbSetOrder(1))
		BR8->(msSeek(xFilial("BR8")+TrbBD7->(BD7_CODPAD+BD7_CODPRO)))

		If BR8->BR8_ODONTO == "1"

			aAdd(aCpo09[nInd1], TrbBD7->(BD7_CODLDP+BD7_CODPEG))
			aAdd(aCpo10[nInd1],{})
			aAdd(aCpo11[nInd1],{})
			aAdd(aCpo12[nInd1],{})
			aAdd(aCpo13[nInd1],{})
			aAdd(aCpo14[nInd1],{})
			aAdd(aCpo15[nInd1],{})
			aAdd(aCpo16[nInd1],{})
			aAdd(aCpo17[nInd1],{})
			aAdd(aCpo18[nInd1],{})
			aAdd(aCpo19[nInd1],{})
			aAdd(aCpo20[nInd1],{})
			aAdd(aCpo21[nInd1],{})
			aAdd(aCpo22[nInd1],{})
			aAdd(aCpo23[nInd1],{})
			aAdd(aCpo24[nInd1],{})
			aAdd(aCpo25[nInd1],{})
			aAdd(aCpo26[nInd1],{})
			nInd2 := Len(aCpo09[nInd1])

			nProcLot:=0
			nLibLot :=0
			nGloLot :=0
			cChLot := TrbBD7->(BD7_NUMLOT+BD7_CODRDA+BD7_CODLDP+BD7_CODPEG)
			Do While ! TrbBD7->(Eof()) .And. TrbBD7->(BD7_NUMLOT+BD7_CODRDA+BD7_CODLDP+BD7_CODPEG) ==  cChLot
				BA1->(dbSetOrder(2))
				BA1->(msSeek(xFilial("BA1")+TrbBD7->(BD7_CODOPE+BD7_CODEMP+BD7_MATRIC+BD7_TIPREG)))

				If BA1->BA1_CODINT == BA1->BA1_OPEORI .Or. empty(BA1->BA1_MATANT)
					aAdd(aCpo10[nInd1,nInd2], BA1->(BA1_CODINT+"."+BA1_CODEMP+"."+BA1_MATRIC+"."+BA1_TIPREG+"-"+BA1_DIGITO)	)
				Else
					aAdd(aCpo10[nInd1,nInd2], BA1->BA1_MATANT)
				EndIf
				aAdd(aCpo11[nInd1,nInd2], TrbBD7->BD7_NOMUSR)
				aAdd(aCpo12[nInd1,nInd2], TrbBD7->BD7_NUMERO)
				aAdd(aCpo13[nInd1, nInd2], {})
				aAdd(aCpo14[nInd1, nInd2], {})
				aAdd(aCpo15[nInd1, nInd2], {})
				aAdd(aCpo16[nInd1, nInd2], {})
				aAdd(aCpo17[nInd1, nInd2], {})
				aAdd(aCpo18[nInd1, nInd2], {})
				aAdd(aCpo19[nInd1, nInd2], {})
				aAdd(aCpo20[nInd1, nInd2], {})
				aAdd(aCpo21[nInd1, nInd2], {})
				aAdd(aCpo22[nInd1, nInd2], {})
				aAdd(aCpo23[nInd1, nInd2], {})

				nInd3 := Len(aCpo12[nInd1, nInd2])

				nProcGui:=0
				nLibGui :=0
				nGloGui :=0
				cChGuia := TrbBD7->(BD7_NUMLOT+BD7_CODRDA+BD7_CODLDP+BD7_CODPEG+BD7_NUMERO)
				Do While ! TrbBD7->(Eof()) .And. TrbBD7->(BD7_NUMLOT+BD7_CODRDA+BD7_CODLDP+BD7_CODPEG+BD7_NUMERO) ==  cChGuia
					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//?Tipo de Participação                             			 ?
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					BWT->(dbSetOrder(1))
					BWT->(msSeek(xFilial("BWT")+TrbBD7->(BD7_CODOPE+BD7_CODTPA)))
					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//?Tabela Padrão                                    			 ?
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					BR8->(dbSetOrder(1))
					BR8->(msSeek(xFilial("BR8")+TrbBD7->(BD7_CODPAD+BD7_CODPRO)))

					If BR8->BR8_ODONTO == "1"

						BD6->(dbSetOrder(1))
						BD6->(msSeek(xFilial("BD6")+TrbBD7->(BD7_CODOPE+BD7_CODLDP+BD7_CODPEG+BD7_NUMERO+BD7_ORIMOV+BD7_SEQUEN+BD7_CODPAD+BD7_CODPRO)))

						aAdd(aCpo13[nInd1, nInd2, nInd3], Posicione("BF8", 2, xFilial("BF8")+BD6->(BD6_CODPAD+BD6_CODOPE+BD6_CODTAB), "BF8_TABTIS"))
						aAdd(aCpo14[nInd1, nInd2, nInd3], TrbBD7->BD7_CODPRO)
						aAdd(aCpo15[nInd1, nInd2, nInd3], BR8->BR8_DESCRI)
						//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
						//?Posiciona Dente/Região                             			 ?
						//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
						BYT->(dbSetOrder(1))
						BYT->(dbSeek(xFilial("BYT")+TrbBD7->(BD7_CODOPE+BD7_CODLDP+BD7_CODPEG+BD7_NUMERO+BD7_SEQUEN)))
						aAdd(aCpo16[nInd1, nInd2, nInd3], BYT->BYT_CODIGO)

						cSQL1 := " SELECT BE2_ANOAUT,BE2_MESAUT,BE2_NUMAUT "
						cSQL1 += "  FROM " + RetSQLName("BE2")
						cSQL1 += "  WHERE BE2_FILIAL = '" + xFilial("BE2") + "' "
						cSQL1 += "    AND BE2_OPEMOV = '" + TrbBD7->BD7_CODOPE + "'"
						cSQL1 += "    AND BE2_ANOAUT = '" + TrbBD7->BD7_ANOPAG + "'"
						cSQL1 += "    AND BE2_MESAUT = '" + TrbBD7->BD7_MESPAG + "'"
						cSQL1 += "    AND BE2_NUMERO = '" + TrbBD7->BD7_NUMERO + "'"
						cSQL1 += "    AND BE2_CODLDP = '" + TrbBD7->BD7_CODLDP + "'"
						cSQL1 += "    AND BE2_CODPEG = '" + TrbBD7->BD7_CODPEG + "'"
						cSQL1 += "    AND BE2_SEQUEN = '" + TrbBD7->BD7_SEQUEN + "'"
						cSQL1 += "    AND BE2_CODPAD = '" + TrbBD7->BD7_CODPAD + "'"
						cSQL1 += "    AND BE2_CODPRO = '" + TrbBD7->BD7_CODPRO + "'"
						cSQL1 += "    AND D_E_L_E_T_ = ' ' "

						PlsQuery(cSQL1,"TrbBE2")

						//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
						//?Posiciona Face		                             			 ?
						//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
						BYS->(dbSetOrder(1))
						BYS->(dbSeek(xFilial("BYS")+BYT->BYT_CODOPE+TrbBD7->(BD7_ANOPAG+BD7_MESPAG+BD7_NUMERO)+BYT->(BYT_SEQUEN+BYT_CODIGO)))

						TrbBE2->(dbCloseArea())

						If !Empty(BYS->BYS_FACES)
							aAdd(aCpo17[nInd1, nInd2, nInd3],BYS->BYS_FACES)    //17
						Else
							dbSelectArea("BYT")
							BYT->(dbSetOrder(1))
							BYT->(dbSeek((xFilial("BYT")+TrbBD7->BD7_CODOPE+TrbBD7->BD7_CODLDP+TrbBD7->BD7_CODPEG+TrbBD7->BD7_NUMERO+TrbBD7->BD7_SEQUEN)))
							aAdd(aCpo17[nInd1, nInd2, nInd3],BYT->BYT_FACES)    //17
						EndIf

						aAdd(aCpo18[nInd1, nInd2, nInd3], TrbBD7->BD7_DATPRO) //18
						aAdd(aCpo19[nInd1, nInd2, nInd3], BD6->BD6_QTDPRO) // 19  ???????
						aAdd(aCpo20[nInd1, nInd2, nInd3], TrbBD7->BD7_VLRPAG + TrbBD7->BD7_VLRGLO) //20
						nProcGui+=TrbBD7->BD7_VLRPAG + TrbBD7->BD7_VLRGLO
						aAdd(aCpo21[nInd1, nInd2, nInd3], TrbBD7->BD7_VLRGLO) //21
						nGloGui+=TrbBD7->BD7_VLRGLO
						aAdd(aCpo22[nInd1, nInd2, nInd3], TrbBD7->BD7_VLRPAG) //22
						nLibGui+=TrbBD7->BD7_VLRPAG

						// BCT - Motivos de Glosas
						cCpo23 := ""
						BDX->(dbSetOrder(1))
						If BDX->(msSeek(xFilial("BDX")+TrbBD7->(BD7_CODOPE+BD7_CODLDP+BD7_CODPEG+BD7_NUMERO+BD7_ORIMOV+BD7_CODPAD+BD7_CODPRO+BD7_SEQUEN)))
							Do While ! BDX->(eof()) .And. BDX->(BDX_FILIAL+BDX_CODOPE+BDX_CODLDP+BDX_CODPEG+BDX_NUMERO+BDX_ORIMOV+BDX_CODPAD+BDX_CODPRO+BDX_SEQUEN) == ;
								xFilial("BDX")+TrbBD7->(BD7_CODOPE+BD7_CODLDP+BD7_CODPEG+BD7_NUMERO+BD7_ORIMOV+BD7_CODPAD+BD7_CODPRO+BD7_SEQUEN)
								// BDX - Glosas das Movimentacoes
								BCT->(dbSetOrder(1))
								If BCT->(msSeek(xFilial("BCT")+BDX->(BDX_CODOPE+BDX_CODGLO)))
									If At(BCT->BCT_GLTISS, cCpo23) == 0
										cCpo23 += IIf(Empty(cCpo23), "", ",") + BCT->BCT_GLTISS
									EndIf
								EndIf
								BDX->(dbSkip())
							EndDo
						EndIf
					Endif
					aAdd(aCpo23[nInd1, nInd2, nInd3], cCpo23)
					TrbBD7->(dbSkip())
				EndDo
				aAdd(aCpo24[nInd1, nInd2],nProcGui)
				nProcLot+=nProcGui
				aAdd(aCpo25[nInd1, nInd2],nGloGui)
				nGloLot+=nGloGui
				aAdd(aCpo26[nInd1, nInd2],(nProcGui-nGloGui))
				nLibLot+=(nProcGui-nGloGui)
			EndDo

			aAdd(aCpo27[nInd1],nProcLot)
			nProcGer+=nProcLot
			aAdd(aCpo28[nInd1],nGloLot)
			nGloGer+=nGloLot
			aAdd(aCpo29[nInd1],(nProcLot-nGloLot))
			nLibGer+=(nProcLot-nGloLot)

		Endif
		TrbBD7->(dbSkip())
	EndDo

	TrbBD7->(DbCloseArea())
	aAdd(aDados, aCpo02)
	aAdd(aDados, aCpo03)
	aAdd(aDados, aCpo04)
	aAdd(aDados, aCpo05)
	aAdd(aDados, aCpo06)
	aAdd(aDados, aCpo07)
	aAdd(aDados, aCpo08)
	aAdd(aDados, aCpo09)
	aAdd(aDados, aCpo10)
	aAdd(aDados, aCpo11)
	aAdd(aDados, aCpo12)
	aAdd(aDados, aCpo13)
	aAdd(aDados, aCpo14)
	aAdd(aDados, aCpo15)
	aAdd(aDados, aCpo16)
	aAdd(aDados, aCpo17)
	aAdd(aDados, aCpo18)
	aAdd(aDados, aCpo19)
	aAdd(aDados, aCpo20)
	aAdd(aDados, aCpo21)
	aAdd(aDados, aCpo22)
	aAdd(aDados, aCpo23)
	aAdd(aDados, aCpo24)//24 Valor Processado Guia
	aAdd(aDados, aCpo25)//25 Valor Glosa Guia
	aAdd(aDados, aCpo26)//26 Valor Liberado Guia
	aAdd(aDados, aCpo27)//27 Valor Processado Lote
	aAdd(aDados, aCpo28)//28 Valor Glosa Lote
	aAdd(aDados, aCpo29)//29 Valor Liberado Lote

	nDeb 	:= 0
	nDebNT 	:= 0
	nCred	:= 0
	nCredNT	:= 0
	nValorDC:= 0

	BGQ->(dbSetOrder(4))//BGQ_FILIAL+BGQ_CODOPE+BGQ_CODIGO+BGQ_ANO+BGQ_MES+BGQ_CODLAN+BGQ_OPELOT+BGQ_NUMLOT
	cChBMR := TrbBMR->(BMR_FILIAL+BMR_OPELOT+BMR_ANOLOT+BMR_MESLOT+BMR_NUMLOT+BMR_OPERDA+BMR_CODRDA)
	Do While ! TrbBMR->(Eof()) .And. TrbBMR->(BMR_FILIAL+BMR_OPELOT+BMR_ANOLOT+BMR_MESLOT+BMR_NUMLOT+BMR_OPERDA+BMR_CODRDA) == cChBMR

		If TrbBMR->BMR_CODLAN $ "102,103,104,105" // Debitos/Creditos Fixos e Variaveis
			BMS->(dbSetOrder(1))
			BMS->(msSeek(TrbBMR->(BMR_FILIAL+BMR_OPERDA+BMR_CODRDA+BMR_OPELOT+BMR_ANOLOT+BMR_MESLOT+BMR_NUMLOT+BMR_CODLAN)))
			Do While ! BMS->(Eof()) .And. ;
				BMS->(BMS_FILIAL+BMS_OPERDA+BMS_CODRDA+BMS_OPELOT+BMS_ANOLOT+BMS_MESLOT+BMS_NUMLOT+BMS_CODLAN) == ;
				TrbBMR->(BMR_FILIAL+BMR_OPERDA+BMR_CODRDA+BMR_OPELOT+BMR_ANOLOT+BMR_MESLOT+BMR_NUMLOT+BMR_CODLAN)

				If Len(CalcImp(BMS->BMS_VLRPAG)) > 0
					//aAdd(aCpo35[nInd1], { IIf(BMS->BMS_DEBCRE == "1", "(-) ", "(+) ") + BMS->BMS_CODSER + " - " + Posicione("BGQ", 4, xFilial("BGQ")+BMS->(BMS_OPERDA+BMS_CODRDA+BMS_ANOLOT+BMS_MESLOT+BMS_CODSER+BMS_OPELOT+BMS_ANOLOT+BMS_MESLOT+BMS_NUMLOT), "BGQ_OBS"), BMS->BMS_VLRPAG })
					aTmpCpo35 := CalcImp(BMS->BMS_VLRPAG)
					aAdd(aCpo35[nInd1], {aTmpCpo35[1,1],aTmpCpo35[1,2]})
					nValorDC += BMS->BMS_VLRPAG
				Else
					If BGQ->(MsSeek(xFilial("BGQ")+ BMS->(BMS_OPERDA + BMS_CODRDA + BMS_ANOLOT + BMS_MESLOT + BMS_CODSER + BMS_OPELOT + BMS_ANOLOT + BMS_MESLOT + BMS_NUMLOT )))
						If BGQ->BGQ_INCIR  == "1" .Or. BGQ->BGQ_INCINS == "1" .Or. BGQ->BGQ_INCPIS == "1" .Or.;
							BGQ->BGQ_INCCOF == "1" .Or. BGQ->BGQ_INCCSL == "1"
							aAdd(aCpo33[nInd1], { IIf(BMS->BMS_DEBCRE == "1", "(-) ", "(+) ") + BMS->BMS_CODSER + " - " + Posicione("BBB", 1, xFilial("BBB")+BMS->BMS_CODSER, "BBB_DESCRI"), BMS->BMS_VLRPAG })
							If BMS->BMS_DEBCRE == "1"
								nDeb += BMS->BMS_VLRPAG
							else
								nCred += BMS->BMS_VLRPAG
							Endif
						Else
							aAdd(aCpo34[nInd1], { IIf(BMS->BMS_DEBCRE == "1", "(-) ", "(+) ") + BMS->BMS_CODSER + " - " + Posicione("BBB", 1, xFilial("BBB")+BMS->BMS_CODSER, "BBB_DESCRI"), BMS->BMS_VLRPAG })
							If BMS->BMS_DEBCRE == "1"
								nDebNT += BMS->BMS_VLRPAG
							else
								nCredNT += BMS->BMS_VLRPAG
							Endif

						EndIf
					EndIf
				EndIf

				BMS->(dbSkip())

			EndDo
		ElseIf TrbBMR->BMR_CODLAN <> "101" .And. TrbBMR->BMR_DEBCRE <> "3"

			If Len(CalcImp(TrbBMR->BMR_VLRPAG)) > 0
				//aAdd(aCpo35[nInd1], {IIf(TrbBMR->BMR_DEBCRE == "1", "(-) ", "(+) ") + TrbBMR->BMR_CODLAN + " - " + Posicione("BLR", 1, xFilial("BLR")+TrbBMR->(BMR_OPELOT+BMR_CODLAN),"BLR_DESCRI"),   TrbBMR->BMR_VLRPAG })
				aTmpCpo35 := CalcImp(TrbBMR->BMR_VLRPAG)
				aAdd(aCpo35[nInd1], {aTmpCpo35[1,1],aTmpCpo35[1,2]})
				nValorDC += TrbBMR->BMR_VLRPAG
			Else
				If TrbBMR->BMR_CODLAN < "170"
					aAdd(aCpo34, {IIf(TrbBMR->BMR_DEBCRE == "1", "(-) ", "(+) ") + TrbBMR->BMR_CODLAN + " - " + Posicione("BLR", 1, xFilial("BLR")+TrbBMR->(BMR_OPELOT+BMR_CODLAN),"BLR_DESCRI"),   TrbBMR->BMR_VLRPAG })

					If BMS->BMS_DEBCRE == "1"
						nDebNT += TrbBMR->BMR_VLRPAG
					else
						nCredNT += TrbBMR->BMR_VLRPAG
					Endif
				Else
					aAdd(aCpo33[nInd1], {IIf(TrbBMR->BMR_DEBCRE == "1", "(-) ", "(+) ") + TrbBMR->BMR_CODLAN + " - " + Posicione("BLR", 1, xFilial("BLR")+TrbBMR->(BMR_OPELOT+BMR_CODLAN),"BLR_DESCRI"),   TrbBMR->BMR_VLRPAG })
					If TrbBMR->BMR_DEBCRE == "1"
						nDeb += TrbBMR->BMR_VLRPAG
					else
						nCred += TrbBMR->BMR_VLRPAG
					Endif
				EndIf
			EndIf
		EndIf
		TrbBMR->(dbSkip())
	EndDo

	aAdd(aCpo30[nInd1], nProcGer)
	aAdd(aDados, aCpo30)//30 Valor Processado Geral

	aAdd(aCpo31, nGloGer)
	aAdd(aDados, aCpo31)//31 Valor Glosa Geral

	aAdd(aCpo32, (nLibGer+((nCred-nDeb)+(nCredNT-nDebNT))))
	aAdd(aDados, aCpo32)//32 Valor Liberado Geral

	aAdd(aDados, aCpo33)//33 e 34

	aAdd(aDados, aCpo34)//35 e 36

	aAdd(aDados, aCpo35)//37 e 38

	aAdd(aCpo36, SE2->E2_VENCTO) // 39  DATA DO PAGAMENTO
	aAdd(aDados, aCpo36)

	aAdd(aCpo37, nCred-nDeb) 		// 40 VALOR TOTAL TRIBUTAVEL
	aAdd(aDados, aCpo37)

	aAdd(aCpo38[nInd1], nValorDC) 	// 41 VALOR TOTAL IMPOSTOS RETIDOS
	aAdd(aDados, aCpo38)

	aAdd(aCpo39, nCredNT-nDebNT) 	// 42 VALOR TOTAL NAO TRIBUTAVEL
	aAdd(aDados, aCpo39)

	aAdd(aCpo40[nInd1], ((nCred-nDeb)+(nCredNT-nDebNT))) 	// 43 VALOR FINAL A RECEBER
	aAdd(aDados, aCpo40)

	aAdd(aCpo41[nInd1], (SE2->E2_VALOR+nValorDC))
	aAdd(aDados, aCpo41)

EndDo
TrbBMR->(DbCloseArea())

Return aDados

//******************************************************************************************************************************

Static Function fLogoEmp(cLogo, cTipo, cLogoGH)

	Local cStartPath	:= GetSrvProfString("STARTPATH","")

	Default cTipo	:= "1"
	Default cLogoGH := ""

	If ValType(cLogoGH) <> "U" .And. !Empty(cLogoGH) .And. File(cLogoGH) //logo a partir do campo do Gestao Hospitalar
		 cLogo := cLogoGH
	Else // Logotipo da Empresa
		 If cTipo == "1"
	 		cLogo := cStartPath + "LGRL"+FWCompany()+FWCodFil()+".BMP"	// Empresa+Filial
		 	//If !File(cLogo)
		 	//	cLogo := cStartPath + "LGRL"+FWCompany()+".BMP"				// Empresa
	 		//EndIf
		 Else
		 	//cLogo := cStartPath + "LogoSiga.bmp"
		 	cLogo := cStartPath + "LGRL"+FWCompany()+".BMP"				// Empresa
		 EndIf
	EndIf

Return(Nil)

//******************************************************************************************************************************

Static Function fSomaLin(nLinMax, nColMax, nLinIni, nColIni, nValor, nIniDefault)
DEFAULT nIniDefault := 0
	nLinIni += nValor
	If nLinIni + 100 > nLinMax
		nLinIni := nIniDefault
		oPrint:EndPage()
		oPrint:StartPage()		// Inicia uma nova pagina
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Box Principal                                                 ?
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		oPrint:Box(nLinIni + 0000, nColIni + 0000, nLinIni + nLinMax, nColIni + nColMax)
		nLinIni += 10
	EndIf
Return

Static Function CalcImp(nVlrPag)
Local nIss      := 0
Local nPis      := 0
Local nCofins   := 0
Local nIR       := 0
Local nCSLL     := 0
Local nINSSPF   := 0
Local nINSSPJ   := 0
Local nINSSJF   := 0
Local nPINSSPJ  := 0
Local nPINSSPF  := 0
Local nCrPINSS  := 0
Local aTabRes	:= {}
Local lInssUnic := .F.

Do Case
	Case TrbBMR->BMR_CODLAN == "182"
		nBINSSPJ  += nVlrPAg
		lInssUnic := .T.
	Case TrbBMR->BMR_CODLAN == "183"
		nINSSPJ   += nVlrPAg
	Case TrbBMR->BMR_CODLAN == "184"
		nBIss     += nVlrPAg
	Case TrbBMR->BMR_CODLAN == "185"
		nIss      += nVlrPAg
	Case TrbBMR->BMR_CODLAN == "186"
		nBPis     += nVlrPAg
	Case TrbBMR->BMR_CODLAN == "187"
		nPis      += nVlrPAg
	Case TrbBMR->BMR_CODLAN == "188"
		nBCofins  += nVlrPAg
	Case TrbBMR->BMR_CODLAN == "189"
		nCofins   += nVlrPAg
	Case TrbBMR->BMR_CODLAN == "190"
		nBCSLL    += nVlrPAg
	Case TrbBMR->BMR_CODLAN == "191"
		nCSLL     += nVlrPAg
	Case TrbBMR->BMR_CODLAN == "192"
		nBINSSPF  += nVlrPAg
	Case TrbBMR->BMR_CODLAN == "193"
		nINSSPF   += nVlrPAg
	Case TrbBMR->BMR_CODLAN == "194"
		nBINSSPJ  += nVlrPAg
	Case TrbBMR->BMR_CODLAN == "195"
		nINSSPJ   += nVlrPAg
	Case TrbBMR->BMR_CODLAN == "196"
		nBINSSPF  += nVlrPAg
	Case TrbBMR->BMR_CODLAN == "197"
		nINSSPF   += nVlrPAg
	Case TrbBMR->BMR_CODLAN == "198"
		nBIR      += nVlrPAg
	Case TrbBMR->BMR_CODLAN == "199"
		nIR       += nVlrPAg
	Case TrbBMR->BMR_CODLAN == "179"
		nPINSSPJ  += nVlrPAg
	Case TrbBMR->BMR_CODLAN == "180"
		nPINSSPF  += nVlrPAg
	Case TrbBMR->BMR_CODLAN == "181"
		nCrPINSS  += nVlrPAg

EndCase

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//?Monta resumo                                                             ?
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

If  nIss > 0
	aadd(aTabRes,{"ISS", nIss})
Endif
If  nPis > 0
	aadd(aTabRes,{"PIS", nPis})
Endif
If  nCofins > 0
	aadd(aTabRes,{"COFINS", nCofins})
Endif
If  nCSLL   > 0
	aadd(aTabRes,{"CSLL", nCSLL})
Endif
If  nPINSSPF > 0
	aadd(aTabRes,{"Prov INSS PF", nPINSSPF})
Endif
If  nPINSSPJ > 0
	aadd(aTabRes,{"Prov INSS PJ", nPINSSPJ})
Endif
If  nINSSPF > 0
	aadd(aTabRes,{"INSS PF", nINSSPF})
Endif
If  nINSSPJ > 0
	If  lInssUnic
		aadd(aTabRes,{"INSS", nINSSPJ})
	Else
		aadd(aTabRes,{"INSS PJ", nINSSPJ})
	Endif
Endif
If  nINSSJF > 0
	aadd(aTabRes,{"INSS JF", nINSSJF})
Endif
If  nIR > 0
	aadd(aTabRes,{"I.R", nIR})
Endif
If  nCrPINSS > 0
	aadd(aTabRes,{"Cred Prov INSS",nCrPINSS})
Endif

Return(aTabRes)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡ao    ?PLVINCTIS ?Autor ?Bruno Iserhardt       ?Data ?15.06.13 ³±?
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡ao ?Chama a tela para vincular um item qualquer com um elemento ³±?
±±?         ³da TISS ou exclui o vínculo com a TISS, de acordo com o      ³±?
±±?         ³parÂmetro cOpc                                               ³±?
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±?Uso      ?PLSA940                                                     ³±?
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros?cTabPLS (caracter, obrigatório) - Recebera o código do alias³±?
±±?         ³de origem de onde esta sendo chamada a função de vinculo,    ³±?
±±?         ³ou seja, se a função esta sendo chamada de um ações          ³±?
±±?         ³relacionadas do browse da tabela padrão (BR8), devera ser    ³±?
±±?         ³passado o conteúdo "BR8" neste parâmetro, através do valor   ³±?
±±?         ³deste parâmetro ser?possível descobrir a terminologia       ³±?
±±?         ³vinculada a esta tabela posicionando na tabela               ³±?
±±?         ?BTP (Cabeçalho de terminologias)", para o campo BTP_ALIAS   ³±?
±±?         ³igual ao valor do parâmetro cTabPLS.                         ³±?
±±?         ?                                                            ³±?
±±?         ?cChvTab (caracter, opcional): Recebera o valor dos campos   ³±?
±±?         ³que compõem a chave do índice (SIX) principal da tabela,     ³±?
±±?         ³ex: BR8_FILIAL+BR8_CODPAD+BR8_CODSPA = 010110101012 onde     ³±?
±±?         ?1= filial, 01 = tabela e 10101012 = procedimento, essa chave³±?
±±?         ³é para localização do item da tabela em questão, não ?      ³±?
±±?         ³necessário a composição inteira de um índice, apenas os      ³±?
±±?         ³campos para posicionamento no registro, tabelas mais simples,³±?
±±?         ³terão apenas filial+código, a tabela de procedimento se      ³±?
±±?         ³trata de uma das exceções existentes, porque o código do     ³±?
±±?         ³procedimento esta associado a tabela de procedimentos        ³±?
±±?         ?BR8_CODPAD), dessa forma s?com o código do procedimento não³±?
±±?         ³seria possível ter uma chave única do mesmo, pois o mesmo    ³±?
±±?         ³procedimento pode estar em uma ou mais tabelas .             ³±?
±±?         ?                                                            ³±?
±±?         ?cCpoPri (caracter, obrigatório):  Valor do campo principal  ³±?
±±?         ³que faz o vinculo, no exemplo citado acima seria o valor do  ³±?
±±?         ³campo BR8_CODPSA.                                            ³±?
±±?         ?     				                                   	     ³±?
±±?         ?cOpc: Indica qual ação o método deve tomar, se ?de incluir ³±?
±±?         ³um vínculo(1) ou se ?para excluir(0)                        ³±?
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*//*
User Function PLVINCTIS(cTabPLS, cCpoPri, cOpc)
Local cCodTab 		:= ""   //Código da TERMINOLOGIA
Local lHasVinc 	:= .F. //indica se o item tem vinculo na tiss
Local lAltVinc 	:= .F. //indica se o usuário deseja alterar o vinculo da tiss do item
Local cCodTerm	 	:= ''  //código do termo que ser?vinculado
Local cDescTerm 	:= '' //descrição do termo que ja est?vinculado
Local cTerminolo 	:= '' //descrição da Terminologia
Local nIncluir	 	:= 1
Local nExcluir 	:= 0
Local cSQL      	:= ""
Local nUBOB    	:= 	0
Local nOpca      	:= 0
Local nLin		 	:= 1
Local bOK			:= { ||nLin := oBrowUsr:nAt, nOpca := 1,oDlgPes:End() }
Local bCancel 		:= { || nOpca := 3,oDlgPes:End() }
Local aBrowUsr 	:= PLGetTermi(cTabPLS)
Local cTissVer  := PLSTISSVER()
Local cChvTab := ""
Private aHBOB   	:= {}
Private aCBOB   	:= {}
Private cChv445	:= ""

If Empty(cTissVer) .OR. cTissVer < "3"
 MsgAlert(STR0417)
 Return
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
//?Define dialogo...                                                   ?
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
aSize := MsAdvSize()
aObjects := {}
AAdd( aObjects, { 100, 10, .T., .T. } )

aInfo := { aSize[ 1 ], aSize[ 2 ], aSize[ 3 ], aSize[ 4 ], 3, 3 }
aPosObj := MsObjSize( aInfo, aObjects )

DbSelectArea("BTP")
BTP->(DbSetOrder(2))
DbSelectArea("BVL")
BVL->(DbSetOrder(2))

	If BTP->(MsSeek(xFilial("BTP")+cTabPLS))
		cChvTab := &(ALLTRIM(cTabPLS+"->("+cTabPLS+"_FILIAL+"+ALLTRIM(BTP->BTP_CHVTAB)+")"))

		Else
			If BVL->(MsSeek(xFilial("BVL")+cTabPLS))
				cChvTab := &(ALLTRIM(cTabPLS+"->("+cTabPLS+"_FILIAL+"+ALLTRIM(BVL->BVL_CHVTAB)+")"))
			Else
				MsgAlert("Não foi encontrada terminologia TISS vinculada a tabela: " + cTabPLS)
			EndIf
	EndIf

//Se o Alias enviado tem mais de uma tabela de domínio
If (Len(aBrowUsr) > 0)
	If Len(aBrowUsr) == 1
		//Código da TERMINOLOGIA
		cCodTab := aBrowUsr[1,1]
		//Descrição da Terminologia
		cTerminolo = aBrowUsr[1,2]
	Else
		//Dialogo de pesquisa de terminologia
		DEFINE MSDIALOG oDlgPes TITLE "Seleção de Terminologia" From 009,000 TO 250,780 OF GetWndDefault() PIXEL //"Seleção de Terminologia"
		//Cria a Grid
		//Determina a grid de acordo com a resolução da tela
		If aPosObj[1][4] > 780  //1600x900
			oBrowUsr := TcBrowse():New( aPosObj[1][1]+2, aPosObj[1][2], aPosObj[1][3], aPosObj[1][4]/10,,,, oDlgPes,,,,,,,,,,,, .F.,, .T.,, .F., )
		ElseIf aPosObj[1][4] > 701 .AND. aPosObj[1][4] <= 780  //1440x900
			oBrowUsr := TcBrowse():New( aPosObj[1][1]+2, aPosObj[1][2], aPosObj[1][3], aPosObj[1][4]/9,,,, oDlgPes,,,,,,,,,,,, .F.,, .T.,, .F., )
		ElseIf aPosObj[1][4] > 661 .AND. aPosObj[1][4] <= 700  //1360x768
			oBrowUsr := TcBrowse():New( aPosObj[1][1]+2, aPosObj[1][2], aPosObj[1][3]+80, aPosObj[1][4]/9,,,, oDlgPes,,,,,,,,,,,, .F.,, .T.,, .F., )
		ElseIf aPosObj[1][4] > 621 .AND. aPosObj[1][4] <= 660  //1280x1024 e 1280x800
			oBrowUsr := TcBrowse():New( aPosObj[1][1]+2, aPosObj[1][2], IIf(aPosObj[1][3] = 427,aPosObj[1][3]-50,aPosObj[1][3]+60), aPosObj[1][4]/8,,,, oDlgPes,,,,,,,,,,,, .F.,, .T.,, .F., )
		ElseIf aPosObj[1][4] > 500 .AND. aPosObj[1][4] <= 620  //1024x768
			oBrowUsr := TcBrowse():New( aPosObj[1][1]+2, aPosObj[1][2], aPosObj[1][3]+80, aPosObj[1][4]/6,,,, oDlgPes,,,,,,,,,,,, .F.,, .T.,, .F., )
		EndIf
		//oBrowUsr := TcBrowse():New( 035, 008, 378, 075,,,, oDlgPes,,,,,,,,,,,, .F.,, .T.,, .F., )
		//Coluna Código
		oBrowUsr:AddColumn(TcColumn():New('Código',nil,;
		         nil,nil,nil,nil,055,.F.,.F.,nil,nil,nil,.F.,nil))
		         oBrowUsr:ACOLUMNS[1]:BDATA     := { || aBrowUsr[oBrowUsr:nAt,1] }
		//Coluna Descrição
		oBrowUsr:AddColumn(TcColumn():New('Descrição ',nil,;
		         nil,nil,nil,nil,055,.F.,.F.,nil,nil,nil,.F.,nil))
		         oBrowUsr:ACOLUMNS[2]:BDATA     := { || aBrowUsr[oBrowUsr:nAt,2] }

		oBrowUsr:nAt := 1 //seta o primeiro item da grid como default
		oBrowUsr:SetArray(aBrowUsr) //seta os itens que irão conter na grid
		oBrowUsr:Refresh()
		oBrowUsr:SetFocus()
		oBrowUsr:BLDBLCLICK := bOK

		ACTIVATE MSDIALOG oDlgPes ON INIT Eval({ || EnChoiceBar(oDlgPes, bOK, bCancel,.F.) })

		//se o usuário selecionou algum registro
		If nOpca == K_OK
			//verifica se o registro não est?em branco
		   	If !Empty(aBrowUsr[nLin,1])
		      	//Código da TERMINOLOGIA
				cCodTab := aBrowUsr[nLin,1]
				//Descrição da Terminologia
				cTerminolo = aBrowUsr[nLin,2]
		   Endif
		Endif
	EndIf
EndIf

//Se achou alguma tabela de terminologia
IF ( cCodTab != "" )
	//Seeka novamente a BTP para não se perder ao salvar registro na BTU
DbSelectArea("BTP")
BTP->(DbSetOrder(2))
DbSelectArea("BVL")
BVL->(DbSetOrder(2))

If BTP->(MsSeek(xFilial("BTP")+cTabPLS+cCodTab))
	cChvTab := &(ALLTRIM(cTabPLS+"->("+cTabPLS+"_FILIAL+"+ALLTRIM(BTP->BTP_CHVTAB)+")"))
Else
	If BVL->(MsSeek(xFilial("BVL")+cTabPLS+cCodTab))
		cChvTab := &(ALLTRIM(cTabPLS+"->("+cTabPLS+"_FILIAL+"+ALLTRIM(BVL->BVL_CHVTAB)+")"))
	EndIf
EndIf
	//verifica se o item tem vinculo na tabela de depara
	dbSelectArea("BTU")
	dbSetOrder(2) //BTU_FILIAL+BTU_CODTAB+BTU_ALIAS+BTU_VLRSIS
	lHasVinc := MsSeek(xFilial("BTU")+cCodTab+cTabPLS+cChvTab)

	//se tem vinculo verifica se o usuário realmente quer alterar o vinculo
	if ( lHasVinc )
		//seleciona o item que ja est?vinculado para exibir a sua descrição
		dbSelectArea("BTQ")
		dbSetOrder(1)
		if (MsSeek(xFilial("BTQ")+cCodTab+BTU->BTU_CDTERM))
			cDescTerm := BTQ->BTQ_DESTER
		EndIf

		//se for exclusão
		if (cOpc) == nExcluir
			//pergunta se o usuário deseja excluir o vínculo
			if (MsgYesNo('Deseja reamente excluir o vínculo com a TISS deste item?'+"<br>"+'Código'+': '+BTU->BTU_CDTERM+'<br>'+'Descrição '+': '+cDescTerm)) //Deseja reamente excluir o vínculo com a TISS deste item? Código: XXXXX Descrição: XXXXX
				cCodTerm := BTU->BTU_CDTERM
				cCodTab := BTU->BTU_CODTAB
				BTU->(RecLock('BTU',.F.))
					BTU->(DbDelete())
					BTU->(DbSkip())
				BTU->( MsUnlock() )

				//CHAMA A FUNÇAO QUE ATUALIZA O CAMPO BTU_HASVIN
				PLSAHASVIN(cCodTab, cCodTerm, cTabPLS)

				MsgInfo("Vínculo excluido com sucesso.") //"Vínculo excluido com sucesso."
			EndIf
		//se não ?inclusão
		Else
			//seleciona o item que ja est?vinculado para exibir a sua descrição
			dbSelectArea("BTQ")
			dbSetOrder(1)
			if (MsSeek(xFilial("BTQ")+cCodTab+BTU->BTU_CDTERM))
				cDescTerm := BTQ->BTQ_DESTER
			EndIf

			//verifica se o usuário deseja alterar o vínculo
			lAltVinc := MsgYesNo('Item já tem Vinculo com a TISS, deseja alterar este vínculo?'+'<br>'+'Código'+': '+BTU->BTU_CDTERM+'<br>'+'Descrição '+': '+cDescTerm) //Item já tem Vinculo com a TISS, deseja alterar este vínculo? Código: XXXXX Descrição: XXXXX
		EndIf
    ElseIf (cOpc) == nExcluir
    	MsgInfo("Item não tem vínculo com a TISS.") //Item não tem vínculo com a TISS.
    EndIf

	//se for inclusão e (não tem vinculo ou o usuário deseja alterar o vinculo)
	if ((cOpc) == nIncluir .And. ( !lHasVinc .Or. lAltVinc ) )
		//pesquisa o termo para vincular, se ja tem vinculo passa o código do item vinculado da TISS
		cCodTerm := PLSPESTISS(IIf(lHasVinc, BTU->BTU_CDTERM, ""), cCodTab, cTerminolo)


		//verifica se foi selecionado algum registro na pesquisa
		if ( cCodTerm != '' )
			If (lHasVinc)//se j?tem vínculo, ALTERA o vínculo
				//realiza alteração somente se o item selecionado não for o mesmo do que o que esta selecionado
				If ( BTU->BTU_CDTERM != cCodTerm )
					BTU->(RecLock("BTU",.F.))
						BTU->BTU_CDTERM := cCodTerm
					BTU->( MsUnlock() )

					MsgInfo("Item já tem Vinculo com a TISS, deseja alterar este vínculo?")
				EndIf
			Else //caso contrário INCLUI o vínculo
				BTU->(RecLock('BTU',.T.))
					BTU->BTU_FILIAL := xFilial("BTU")
					BTU->BTU_CODTAB := cCodTab
					BTU->BTU_VLRSIS := cChvTab
					BTU->BTU_VLRBUS := cCpoPri
					BTU->BTU_CDTERM := cCodTerm
					BTU->BTU_ALIAS  := cTabPLS
				BTU->( MsUnlock() )

				MsgInfo("Vínculo incluido com sucesso.") //Vínculo incluido com sucesso.
			EndIf

			//CHAMA A FUNÇAO QUE ATUALIZA O CAMPO BTU_HASVIN
			PLSAHASVIN(cCodTab, cCodTerm, cTabPLS)
		EndIf
	EndIf
ElseIf (nOpca == K_OK)
	MsgInfo("Tabela de Domínio não encontrada.") //Tabela de Domínio não encontrada.
EndIf

Return (Nil)
*/
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ?PLGetTermi ?Autor ?Bruno Iserhardt    ?Data ?09.07.13 ³±?
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ?Retorna um array com todas as terminologias do alias      ³±?
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/ /*
User Function PLGetTermi(cTabPLS)
Local aTerminolo := {}
Local cTissVer  := PLSTISSVER()

If Empty(cTissVer) .OR. cTissVer < "3"
 	MsgAlert(STR0417)
Else
	//seleciona todas as terminologias que utilziam o alias cadastrados na tabela BTP
	BTP->(DbSelectArea("BTP"))
	BTP->(DbSetOrder(2)) //BTP_FILIAL+BTP_ALIAS
	If (BTP->(MsSeek(xFilial("BTP")+cTabPLS)))
		While (!BTP->(Eof()) .AND. BTP->(BTP_FILIAL+BTP_ALIAS) == xFilial("BTP")+cTabPLS)
			BTP->(aadd(aTerminolo, { BTP_CODTAB, BTP_DESCRI }))
			BTP->(DbSkip())
		EndDo
	EndIf

	//agora seleciona as terminologias que utilizam o alias cadastrados na tabela BVL
	BVL->(DbSelectArea("BVL"))
	BVL->(DbSetOrder(2)) //BVL_FILIAL+BVL_ALIAS
	If (BVL->(MsSeek(xFilial("BVL")+cTabPLS)))
		BTP->(DbSetOrder(1)) //BTP_FILIAL+BTP_CODTAB
		While (!BVL->(Eof()) .AND. BVL->(BVL_FILIAL+BVL_ALIAS) == xFilial("BVL")+cTabPLS)
			//seleciona na BTP a descriçao e o codigo da tabela
			If (BTP->(MsSeek(xFilial("BTP")+BVL->BVL_CODTAB)))
				BTP->(aadd(aTerminolo, { BTP_CODTAB, BTP_DESCRI }))
			EndIf
			BVL->(DbSkip())
		EndDo
	EndIf
EndIf

Return aTerminolo
*/
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ?PLSPESUSER ?Autor ?Bruno Iserhardt    ?Data ?15.06.13 ³±?
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ?Pesquisa generica de itens das tabelas de dominio TISS    ³±?
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Programador ?Data   ?BOPS ? Motivo da Altera‡„o                    ³±?
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*
User Function CABPESTISS(cCodVinc, cCodTab, cTerminolo)
LOCAL cChave     := IIF (!Empty(cCodVinc), cCodVinc, Space(100))
LOCAL oDlgPesTis
LOCAL oTipoPes
LOCAL nOpca      := 0
LOCAL aBrowUsr   := {}
LOCAL aVetPad    := { {"",""} }
LOCAL oBrowUsr
LOCAL bRefresh   := { || If(!Empty(cChave),PLSAPTISPq(AllTrim(cChave),Subs(cTipoPes,1,1),cCodTab,lChkChk,aBrowUsr,aVetPad,oBrowUsr),.T.), If( Empty(aBrowUsr[1,2]) .And. !Empty(cChave),.F.,.T. )  }
LOCAL cValid     := "{|| Eval(bRefresh) }"
LOCAL bOK        := { || IIF(FunName() == "TMKA271", (nLin := oBrowUsr:nAt, nOpca := 1,oDlgPesTis:End()), IIF(!Empty(cChave),(nLin := oBrowUsr:nAt, nOpca := 1,oDlgPesTis:End()),Help("",1,"PLSMCON"))) }
LOCAL bCanc      := { || nOpca := 3,oDlgPesTis:End() }
LOCAL nReg
LOCAL oGetChave
LOCAL aTipoPes   := {}
LOCAL nOrdem     := 1
LOCAL cTipoPes   := ""
LOCAL oChkChk
LOCAL lChkChk    := .F.
LOCAL nLin       := 1
LOCAL aButtons 	 := {}
LOCAL cSQL
LOCAL cRet       := ''

aBrowUsr := aClone(aVetPad)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//?Itens do combo do tipo de pesquisa...                                    ?
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
aTipoPes   := {STR0406,STR0407} //Código Terminologia || Decrição Item Terminologia

DbSelectArea("BTQ")
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//?Define dialogo...                                                        ?
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
DEFINE MSDIALOG oDlgPesTis TITLE cTerminolo FROM 009,000 TO 280,780 OF GetWndDefault() PIXEL
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//?Monta objeto que recebera o a chave de pesquisa  ...                     ?
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oGetChave := TGet():New(37,103,{ | U | IF( PCOUNT() == 0, cChave, cChave := U ) },oDlgPesTis,210,10 ,"",&cValid,nil,nil,nil,nil,nil,.T.,nil,.F.,nil,.F.,nil,nil,.F.,nil,nil,cChave)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//?Monta Browse...                                                          ?
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oBrowUsr := TcBrowse():New( 055,008,378,075,,,, oDlgPesTis,,,,,,,,,,,, .F.,, .T.,, .F., ) //23-10

//Código
oBrowUsr:AddColumn(TcColumn():New('Código',nil,;
         nil,nil,nil,nil,055,.F.,.F.,nil,nil,nil,.F.,nil))
         oBrowUsr:ACOLUMNS[1]:BDATA     := { || aBrowUsr[oBrowUsr:nAt,1] }
//Descrição
oBrowUsr:AddColumn(TcColumn():New('Descrição ',nil,;
         nil,nil,nil,nil,055,.F.,.F.,nil,nil,nil,.F.,nil))
         oBrowUsr:ACOLUMNS[2]:BDATA     := { || aBrowUsr[oBrowUsr:nAt,2] }

@ 37,008 COMBOBOX oTipoPes  Var cTipoPes ITEMS aTipoPes SIZE 090,13 OF oDlgPesTis PIXEL COLOR CLR_HBLUE

oBrowUsr:SetArray(aBrowUsr)
oBrowUsr:BLDBLCLICK := bOK
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//?Ativa o Dialogo...                                                       ?
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
ACTIVATE MSDIALOG oDlgPesTis ON INIT Eval({ || EnChoiceBar(oDlgPesTis,bOK,bCanc,.F.,aButtons), EVAL(bRefresh), oGetChave:SetFocus() })

//se o usuário selecionou algum registro
If nOpca == K_OK
	//verifica se o registro não est?em branco
   	If !Empty(aBrowUsr[nLin,1])
   		//atribui o código do item da terminologia a variável de retorno
      	cRet := aBrowUsr[nLin,1]
   Endif
Endif

If ValType(cChv445) <> 'U'
	cChv445 := cRet
EndIf


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//?Retorno da Funcao...                                                     ?
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Return(cRet)
*/
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ?PLSAPTISPq ?Autor ?Bruno Iserhardt    ?Data ?15.06.13 ³±?
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ?Pesquisa detalhes das tarminologias TISS na base de dados ³±?
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Programador ?Data   ?BOPS ? Motivo da Altera‡„o                    ³±?
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
/*
Function CABAPTISPq(cChave,cTipoPes,cCodTab,lChkChk,aBrowUsr,aVetPad,oBrowUsr)
Local aArea     	:= GetArea()
LOCAL cSQL      	:= ""

If ( '"' $ cChave .Or. "'" $ cChave )
   Aviso( STR0418, STR0419, { STR0420 }, 2 )
   Return(.F.)
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//?Limpa resultado...                                                       ?
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
aBrowUsr := {}
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//?Efetua busca...                                                          ?
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cSQL := "SELECT BTQ.BTQ_CDTERM, BTQ.BTQ_DESTER "
cSQL += "FROM "+RetSqlName("BTQ")+" BTQ "
cSQL += "WHERE D_E_L_E_T_ = ' ' "
cSQL += "AND (BTQ_VIGDE = '" + DTOS(STOD("")) + "' OR BTQ_VIGDE <= '" + DTOS(Date()) + "') "
cSQL += "AND (BTQ_VIGATE = '" + DTOS(STOD("")) + "' OR BTQ_VIGATE >= '" + DTOS(Date()) + "') "
cSQL += "AND BTQ_CODTAB = " + cCodTab + " "

If ( cChave != '_' )
	cSQL += "AND "
	IF (cTipoPes == 'C')
		cSQL += "BTQ_CDTERM LIKE '"+cChave+"%'"
	Else
		cSQL += "BTQ_DESTER LIKE '%"+cChave+"%'"
	EndIf
EndIf

PLSQuery(cSQL,"TrbPes")
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//?Popula a grid de pesquisa...                                             ?
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
TrbPes->(DbGoTop())
While ! TrbPes->(Eof())
	TrbPes->(aadd(aBrowUsr, { BTQ_CDTERM, BTQ_DESTER }))
	TrbPes->(DbSkip())
Enddo

TrbPes->(DbCloseArea())
RestArea(aArea)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//?Testa resultado da pesquisa...                                           ?
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If Len(aBrowUsr) == 0
	MsgInfo(STR0411) //Nenhum item encontrado com o filtro ou não existe tabela vigente para a Terminologia.
   	aBrowUsr := aClone(aVetPad)
Endif
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//?Atualiza browse...                                                       ?
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oBrowUsr:nAt := 1 // Configuro nAt para um 1 pois estava ocorrendo erro de "array out of bound" qdo se fazia
                  // uma pesquisa mais abrangante e depois uma uma nova pesquisa menos abrangente
                  // Exemplo:
                  // 1a. Pesquisa: "A" - Tecle <END> para ir ao final e retorne ate a primeira linha do browse
                  // (via seta para cima ou clique na primeira linha)
                  // 2a. Pesquisa: "AV" - Ocorria o erro
oBrowUsr:SetArray(aBrowUsr)
oBrowUsr:Refresh()
oBrowUsr:SetFocus()
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//?Fim da Rotina...                                                         ?
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Return(.T.)
*/
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ?PLSAHASVIN ?Autor ?Bruno Iserhardt    ?Data ?08.07.13 ³±?
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ?Funçao que atualiza o banco indicando se o termo tem      ³±?
±±?         ?vinculo com algum item do protheus na BTU.				   ³±?
±±?         ?ATENÇAO: FUNÇAO TAMBEM UTILIZADA NO FONTE PLSA444.PRW	   ³±?
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
/*
Function CABAHASVIN(cCodTab, cCodTerm, cAlias, nCount)
Local lHasVin := "0" //indica se o termo j?tem vinculo com a tabela de de/para
Default nCount := 0

BTU->(dbSelectArea("BTU"))
BTU->(dbSetOrder(3)) //BTU_FILIAL+BTU_CODTAB+BTU_ALIAS+BTU_CDTERM

//verifica se o código enviado tem registro na tabela de de/para
lHasVin := If(BTU->(MsSeek(xFilial("BTU")+cCodTab+cAlias+cCodTerm)), "1", "0")

BTQ->(dbSelectArea("BTQ"))
BTQ->(dbSetOrder(1)) //BTQ_FILIAL+BTQ_CODTAB+BTQ_CDTERM

//posiciona no registro que sera alterado
IF (BTQ->(MsSeek(xFilial("BTQ")+cCodTab+cCodTerm)))
	If (nCount > 0 .AND. nCount == HS_CountTB("BTU", "BTU_FILIAL='"+xFilial('BTU')+"' AND BTU_CODTAB='"+cCodTab+"' AND BTU_CDTERM='"+cCodTerm+"' AND BTU_ALIAS='"+cAlias+"'"))
		//indica que não tem vinculo
		lHasVin := "0"
	EndIf
	//realiza o update no registro informando se ja tem ou não o vinculo na tabela de de/para
	BTQ->(RecLock("BTQ",.F.))
		BTQ->BTQ_HASVIN := lHasVin
	BTQ->( MsUnlock() )
EndIf
Return .T.
*/
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ?PLSGETVINC ?Autor ?Bruno Iserhardt    ?Data ?15.06.13 ³±?
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ?Retorna a descrição ou o código do vínculo                ³±?
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Programador ?Data   ?BOPS ? Motivo da Altera‡„o                    ³±?
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
/*
Function CABGETVINC (cColuna, cAlias, lMsg, cCodTab , cVlrTiss, lPortal, aTabDup, cPadBkp )

Local cRet := ''
Local cChave := ''
Local lAchou := .T.
Local cTip := ''
Local nCT := 0
Local cAux := ''
Local cBtuVlrSis :=""
Default cVlrTiss := ""
Default lMsg := .F.
Default cCodTab := ''
Default lPortal := .F.
Default aTabDup := {}

cVlrTiss := AllTrim(cVlrTiss)
cRet := cVlrTiss

If !FWAliasInDic("BTP", .F.)
	If lPortal == .T.
		Conout(STR0422)
	Return(cRet)
	Else
		MsgAlert(STR0422) //"Para esta funcionalidade ?necessário executar os procedimentos referente ao chamado: THQGIW"
	Return(cRet)
	Endif
EndIf

//Tratamento para os campos 35 e 29 - Motivo de Encerramento do Atendimento e da internação - SADT Execucao/Guia Resumo de Internação
If cCodTab == "39" .or. lPortal
	BTU->(DbSelectArea("BTU"))
	BTU->(DbSetOrder(2)) //BTU_FILIAL+BTU_CODTAB+BTU_ALIAS+BTU_VLRSIS
	BTU->(DbSelectArea("BVL"))
	BVL->(dbSetOrder(2)) //BVL_FILIAL+BVL_ALIAS+BVL_CODTAB
	If BVL->(MsSeek(xFilial("BVL")+cAlias+cCodTab))
		cChave := cAlias+"->(xFilial('"+cAlias+"')+"+BVL->BVL_CHVTAB+")"
		If lAchou == .T. .AND. BTU->(MsSeek(xFilial("BTU")+cCodTab+cAlias+&(cChave)))
			cRet := BTU->BTU_CDTERM
			Return (cRet)
		ElseIf lAchou == .T. .AND. BTU->(MsSeek(xFilial("BTU")+ cCodTab+cAlias+(xFilial(cAlias)+cVlrTiss)))
			cRet := BTU->BTU_CDTERM
			Return (cRet)
		EndIf
	EndIf
Endif

//Se a função for chamada das guias do portal realiza função inversa, buscando código do protheus
If lPortal == .T.
	dbSelectArea("BTU")
	BTU->(dbSetOrder(3)) //BTU_FILIAL+BTU_CODTAB+BTU_ALIAS+BTU_CDTERM
	If BTU->(MsSeek(xFilial("BTU")+cCodTab+cAlias+cVlrTiss))
		cRet := BTU->BTU_VLRBUS
		Return (cRet)
	EndIf
Endif

dbSelectArea("BTP")
BTP->(dbSetOrder(2)) //BTP_FILIAL+BTP_ALIAS+BTP_CODTAB

dbSelectArea("BTU")
BTU->(dbSetOrder(2)) //BTU_FILIAL+BTU_CODTAB+BTU_ALIAS+BTU_VLRSIS

dbSelectArea("BTQ")
BTQ->(dbSetOrder(1)) //BTQ_FILIAL+BTQ_CODTAB+BTQ_CDTERM

dbSelectArea("BVL")
BVL->(dbSetOrder(2)) //BVL_FILIAL+BVL_ALIAS+BVL_CODTAB

dbSelectArea("BE2")
BE2->(dbSetOrder(1))

If	BTP->(MsSeek(xFilial("BTP")+Iif(Empty(cAlias), space(3), cAlias)+cCodTab)) .And. !Empty(cAlias)
	cChave := cAlias+"->(xFilial('"+cAlias+"')+"+BTP->BTP_CHVTAB+")"
	cTip := BTP->BTP_TIPVIN

	If Empty(cCodTab) .AND. cAlias == "BR8" // Busco a tabela
		//"0=Procedimento;1=Material;2=Medicamento;3=Taxas;4=Di¯rias;5=-rtese/Pr¥tese;6=Pacote;7=Gases Medicinais;8=Alugu+is"
		Do Case
		Case BR8->BR8_TPPROC $ "06"
			cCodTab := "22"
		Case BR8->BR8_TPPROC $ "347"
			cCodTab := "18"
		Case BR8->BR8_TPPROC $ "15"
			cCodTab := "19"
		Case BR8->BR8_TPPROC == "2"
			cCodTab := "20"
		OtherWise
			cCodTab := "22"
		EndCase
	EndIf

ElseIf BVL->(MsSeek(xFilial("BVL")+cAlias+cCodTab))
	cChave := cAlias+"->(xFilial('"+cAlias+"')+"+BVL->BVL_CHVTAB+")"
	cTip :=  BVL->BVL_TIPVIN
Else
	lAchou := .F.
EndIf

If cTip == '0' //TABELA
	If (cColuna == "BTU_CDTERM")
		If Empty(cVlrTiss)
			If lAchou == .T. .AND. BTU->(MsSeek(xFilial("BTU")+cCodTab+cAlias+&(cChave)))
				cRet := BTU->BTU_CDTERM
			Endif
		ElseIf !Empty(aTabDup)
			For nCT := 1 to Len(aTabDup)
				If lAchou == .T. .AND. BTU->(MsSeek(xFilial("BTU")+ Alltrim(aTabDup[nCT,1])+ cAlias+ (xFilial(cAlias)+cVlrTiss)))
					cRet := BTU->BTU_CDTERM
					@cPadBkp := Alltrim(aTabDup[nCT,1])
				EndIf
			Next nCT
		ElseIf lAchou == .T. .AND. BTU->(MsSeek(xFilial("BTU")+ AllTrim(cCodTab)+ cAlias+ (xFilial(cAlias)+cVlrTiss)))
			cRet := BTU->BTU_CDTERM
		EndIf
	ElseIf (cColuna == "BTQ_DESTER")
		If Empty(cVlrTiss)
			If lAchou == .T. .AND. BTU->(MsSeek(xFilial("BTU")+cCodTab+cAlias+&(cChave)))
				cVlrTiss := BTU->BTU_CDTERM
				If BTQ->(MsSeek(xFilial("BTQ")+cCodTab+cVlrTiss))
					cRet := BTQ->BTQ_DESTER
				EndIf
			EndIf
		ElseIf lAchou == .T. .AND. BTU->(MsSeek(xFilial("BTU")+ Alltrim(cCodTab)+ cAlias+ (xFilial(cAlias)+cVlrTiss+Space(TamSX3("BTU_VLRSIS")[1]-Len(cVlrTiss)))))
			cVlrTiss := BTU->BTU_CDTERM
			If BTQ->(MsSeek(xFilial("BTQ")+AllTrim(cCodTab)+cVlrTiss))
				cRet := BTQ->BTQ_DESTER
			EndIf
		ElseIF BTQ->(MsSeek(xFilial("BTQ")+AllTrim(cCodTab)+cVlrTiss))
				cRet := BTQ->BTQ_DESTER
		EndIf
	EndIf

Else //COMBO

	If (cColuna == "BTU_CDTERM")
		If !Empty(cVlrTiss)
			If BTU->(MsSeek(xFilial("BTU")+ cCodTab+ cAlias+ cVlrTiss))
				cRet := BTU->BTU_CDTERM
			EndIf
		EndIf
	EndIf

EndIf

If (Empty(cRet) .and. lMsg == .T.)
	cRet := (STR0421)
else
	cAux := decodeUTF8(cRet)
	If cAux != nil
		cRet := cAux
	EndIf
EndIf

If cRet == cVlrTiss .and. funname() == ("HSPAHM52") .AND. cCodTab == "19"
	cRet := ' '
Endif

If cRet != BTU->BTU_CDTERM .AND. cColuna == "BTU_CDTERM"
	BTU->(DbSetOrder(2))//BTU->(DbSetOrder(2)) //BTU_FILIAL+BTU_CODTAB+BTU_ALIAS+BTU_VLRSIS
		If BTU->(MsSeek(xFilial("BTU")+AllTrim(cCodTab)+cAlias+XFILIAL(CALIAS)+BE2->BE2_CODPAD+cVlrTiss))// Ex do ultimo parametro: "M SP    0143000010"(XFILIAL(CALIAS)+BE2->BE2_CODPAD+cVlrTiss)
			cRet := BTU->BTU_CDTERM
			Else
				If BTU->(MsSeek(xFilial("BTU")+cCodTab+(xFilial(cAlias)+cVlrTiss+Space(TamSX3("BTU_VLRSIS")[1]-Len(cVlrTiss)-8))+cAlias))
					cRet := BTU->BTU_CDTERM
				Else
					//BTU->(DbSetOrder(2)) //BTU_FILIAL+BTU_CODTAB+BTU_ALIAS+BTU_VLRSIS
					If BTU->(MsSeek(xFilial("BTU")+cCodtab+xFilial(cAlias)+cVlrTiss))
					cRet := BTU->BTU_CDTERM
					EndIf
				EndIf
		EndIf
EndIf

If (cColuna == "BTQ_CDTERM")
	If ! Empty(cVlrTiss)
		If lAchou == .T. .AND. BTU->(MsSeek(xFilial("BTU")+AllTrim(cCodTab)+cAlias+XFILIAL(CALIAS)+BE2->BE2_CODPAD+cVlrTiss))
			cBtuVlrSis := BTU->BTU_CDTERM
			If BTQ->(MsSeek(xFilial("BTQ")+cCodTab+cBtuVlrSis))
				cRet := BTQ->BTQ_DESTER
			EndIf
		EndIf
	EndIf
EndIf

Return (Alltrim(cRet))
*/
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ?PSRETCART  ?Autor ?Everton M. Fernandes Data ?08.07.13 ³±?
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ?Retorna o numero da carteirinha do usuario para a         ³±?
±±?         ?impressão da guia SADT padrão TISS 3.0.      			   ³±?
±±?         ?                                                     	   ³±?
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
/*
Function PSRETCART()
Local cRet
If BA1->BA1_CODINT == BA1->BA1_OPEORI .Or. empty(BA1->BA1_MATANT) // 8
	cRet := BEA->(SubStr(BEA_OPEMOV,1,1)+SubStr(BEA_OPEMOV,2,3)+"."+BEA_CODEMP+"."+BEA_MATRIC+"."+BEA_TIPREG+"-"+BEA_DIGITO)
Else
	cRet := POSICIONE("BA1",2,XFILIAL("BA1")+BEA->(BEA_OPEUSR+BEA_CODEMP+BEA_MATRIC+BEA_TIPREG),"BA1_MATANT")
EndIf

Return cRet
*/
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ?PSRETSOL   ?Autor ³Everton M. Fernandes?Data ?08.07.13 ³±?
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ?Retorna o CPF/CNPJ do solicitante.                        ³±?
±±?         ?                                             			   ³±?
±±?         ?                                                     	   ³±?
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
/*
Function PSRETSOL(nCampo)
Local cRet

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//?Salva Recnos												 ?
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local nRecBAU := BAU->(Recno())
Local nOrdBAU := BAU->(IndexOrd())
Local nRecBB0 := BB0->(Recno())
Local nOrdBB0 := BB0->(IndexOrd())
Local nRecBB8 := BB8->(Recno())
Local nOrdBB8 := BB8->(IndexOrd())

DEFAULT nCampo := 1 //nCampo -> 1-Codigo; 2-Nome; 3-Cod. CNES

BB0->(dbSetOrder(4) )
BB0->(dbSeek(xFilial("BB0")+BEA->(BEA_ESTSOL+BEA_REGSOL+BEA_SIGLA)))
If  BEA->(FieldPos("BEA_RDACON")) > 0 .and. !Empty(BEA->BEA_RDACON)


	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//?Posiciona Rede de Atendimento                                ?
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	BAU->(dbSetOrder(1))
	BAU->(dbSeek(xFilial("BAU")+BEA->BEA_RDACON))

	If nCampo == 1
		cRet := IIf(BAU->BAU_TIPPE == "F", Transform(BAU->BAU_CPFCGC, "@R 999.999.999-99"), Transform(BAU->BAU_CPFCGC, "@R 99.999.999/9999-99")) // 13
	ElseIf nCampo == 2
		cRet := BAU->BAU_NOME // 14
	ElseIf nCampo == 3
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//?Como no nosso sistema não existe local de atendimento para   ?
		//| o contratado solicitante, o CNES esta sendo enviado em branco|
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		BB8->(dbSetOrder(1))
		BB8->(dbSeek(xFilial("BB8")+BAU->BAU_CODIGO+BEA->(BEA_OPEMOV+BEA_CODLOC)))
		aAdd(aDados, Transform('', cPicCNES)) // 15
	EndIf

Else
	If nCampo == 1
		cRet := IIf(Len(AllTrim(BB0->BB0_CGC)) == 11, Transform(BB0->BB0_CGC, "@R 999.999.999-99"), Transform(BB0->BB0_CGC, "@R 99.999.999/9999-99")) // 13
	ElseIf nCampo == 2
		cRet := BB0->BB0_NOME // 14
	ElseIf nCampo == 3
		BB8->(dbSetOrder(1))
		BB8->(dbSeek(xFilial("BB8")+BAU->BAU_CODIGO+BEA->(BEA_OPEMOV+BEA_CODLOC)))
		cRet := Transform(BB8->BB8_CNES, cPicCNES) // 15
	EndIf
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//?Posiciona registros											 ?
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
BAU->(DbSetOrder(nOrdBAU))
BAU->(DbGoTo(nRecBAU))
BB0->(DbSetOrder(nOrdBB0))
BB0->(DbGoTo(nRecBB0))
BB8->(DbSetOrder(nOrdBB8))
BB8->(DbGoTo(nRecBB8))

Return cRet
*/
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ?PSRETSOL  ?Autor ?Everton M. Fernandes Data ?08.07.13 ³±?
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ?Retorna o CPF/CNPJ do solicitante.                        ³±?
±±?         ?                                             			   ³±?
±±?         ?                                                     	   ³±?
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
/*
Function PSRETTAB(cVlrSis,lCodTab)
Local cRet

DbSelectArea("BTU")
BTU->(DbSetOrder(4))

Return cRet
*/
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ?PSRETINT  ?Autor ?Everton M. Fernandes Data ?08.07.13 ³±?
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ?Retorna o tipo de internação                              ³±?
±±?         ?                                             			   ³±?
±±?         ?                                                     	   ³±?
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
/*
Function PSRETINT(cGrupInt, cTipInt)
Local cRet

	Do Case
	Case cGrupInt == "1" .And. cTipInt == "01"
		cRet := "1" // Internacao Clinica
	Case cGrupInt == "1" .And. cTipInt == "02"
		cRet := "6" // Pediatrica
	Case cGrupInt == "1" .And. cTipInt == "03"
		cRet := "7" // Psiquiatrica
	Case cGrupInt == "1" .And. cTipInt == "05"
		cRet := "3" // Internacao Obstetrica
	Case cGrupInt == "1" .And. cTipInt == "06"
		cRet := "4" // Hospital Dia
	Case cGrupInt == "1" .And. cTipInt == "07"
		cRet := "5" // Domiciliar
	Case cGrupInt == "2" .And. cTipInt == "01"
		cRet := "2" // Internacao Cirurgica
	Case cGrupInt == "2" .And. cTipInt == "03"
		cRet := "3" // Internacao Obstetrica
	Otherwise
		cRet := cGrupInt + "." + cTipInt
	EndCase
Return cRet
*/
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ?PSCGCRDA  ?Autor ?Everton M. Fernandes Data ?08.07.13 ³±?
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ?Retorna o CGC/CPF da RDA                                  ³±?
±±?         ?                                             			   ³±?
±±?         ?                                                     	   ³±?
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*//*
Function PSCGCRDA()
Local cRet

cRet := IIf(Len(AllTrim(BAU->BAU_CPFCGC)) == 11,;
													 Transform(Posicione('BAU',1,xFilial("BAU")+B0D->B0D_CODRDA,'BAU_CPFCGC'), "@R 999.999.999-99"),;
													 Transform(Posicione('BAU',1,xFilial("BAU")+B0D->B0D_CODRDA,'BAU_CPFCGC'), "@R 99.999.999/9999-99"))

Return cRet
*/
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ?PLSLOADB7B ?Autor ?Everton M. Fernandes Data ?08.07.13 ³±?
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ?Carrega o array da tabela do load                         ³±?
±±?         ?                                             			   ³±?
±±?         ?                                                     	   ³±?
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
/*
Function CABLOADB7A(aB7A)
Aadd(aB7A,{{"B7A_FILIAL","  "},{"B7A_TIPGUI","01"},{"B7A_ALIAS","BEA"},{"B7A_INDICE","1"},{"B7A_TIPO","0"},{"B7A_DADPES","XFILIAL('BEA')+BEA->(BEA_OPEMOV+BEA_ANOAUT+BEA_MESAUT+BEA_NUMAUT+DTOS(BEA_DATPRO)+BEA_HORPRO)                           "},{"B7A_ALIPAI","   "},{"B7A_CONDIC","                                                                                                                                                      "},{"B7A_TISVER","3.00.01"}})
Aadd(aB7A,{{"B7A_FILIAL","  "},{"B7A_TIPGUI","01"},{"B7A_ALIAS","BTS"},{"B7A_INDICE","1"},{"B7A_TIPO","0"},{"B7A_DADPES","XFILIAL('BTS')+(BA1->BA1_MATVID)                                                                                        "},{"B7A_ALIPAI","BA1"},{"B7A_CONDIC","                                                                                                                                                      "},{"B7A_TISVER","3.00.01"}})
Aadd(aB7A,{{"B7A_FILIAL","  "},{"B7A_TIPGUI","01"},{"B7A_ALIAS","BA3"},{"B7A_INDICE","1"},{"B7A_TIPO","0"},{"B7A_DADPES","XFILIAL('BA3')+BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC)                                                                  "},{"B7A_ALIPAI","BA1"},{"B7A_CONDIC","                                                                                                                                                      "},{"B7A_TISVER","3.00.01"}})
Aadd(aB7A,{{"B7A_FILIAL","  "},{"B7A_TIPGUI","01"},{"B7A_ALIAS","BI3"},{"B7A_INDICE","1"},{"B7A_TIPO","0"},{"B7A_DADPES","XFILIAL('BI3')+BA3->(BA3_CODINT+BA3_CODPLA+BA3_VERSAO)                                                                  "},{"B7A_ALIPAI","BA3"},{"B7A_CONDIC","                                                                                                                                                      "},{"B7A_TISVER","3.00.01"}})
Aadd(aB7A,{{"B7A_FILIAL","  "},{"B7A_TIPGUI","01"},{"B7A_ALIAS","BB8"},{"B7A_INDICE","1"},{"B7A_TIPO","0"},{"B7A_DADPES","XFILIAL('BB8')+BAU->BAU_CODIGO+BEA->(BEA_OPEMOV+BEA_CODLOC)                                                             "},{"B7A_ALIPAI","BAU"},{"B7A_CONDIC","                                                                                                                                                      "},{"B7A_TISVER","3.00.01"}})
Aadd(aB7A,{{"B7A_FILIAL","  "},{"B7A_TIPGUI","01"},{"B7A_ALIAS","BB0"},{"B7A_INDICE","1"},{"B7A_TIPO","0"},{"B7A_DADPES","XFILIAL('BB0')+BAU->BAU_CODBB0                                                                                          "},{"B7A_ALIPAI","BAU"},{"B7A_CONDIC","EMPTY(BEA->BEA_REGEXE)                                                                                                                                "},{"B7A_TISVER","3.00.01"}})
Aadd(aB7A,{{"B7A_FILIAL","  "},{"B7A_TIPGUI","01"},{"B7A_ALIAS","BE2"},{"B7A_INDICE","1"},{"B7A_TIPO","0"},{"B7A_DADPES","XFILIAL('BE2')+BEA->(BEA_OPEMOV+BEA_ANOAUT+BEA_MESAUT+BEA_NUMAUT )                                                      "},{"B7A_ALIPAI","BD5"},{"B7A_CONDIC","                                                                                                                                                      "},{"B7A_TISVER","3.00.01"}})
Aadd(aB7A,{{"B7A_FILIAL","  "},{"B7A_TIPGUI","01"},{"B7A_ALIAS","BR8"},{"B7A_INDICE","1"},{"B7A_TIPO","0"},{"B7A_DADPES","XFILIAL('BR8')+BD6->(BD6_CODPAD+BD6_CODPRO)                                                                             "},{"B7A_ALIPAI","BD6"},{"B7A_CONDIC","                                                                                                                                                      "},{"B7A_TISVER","3.00.01"}})
Aadd(aB7A,{{"B7A_FILIAL","  "},{"B7A_TIPGUI","01"},{"B7A_ALIAS","BD6"},{"B7A_INDICE","1"},{"B7A_TIPO","0"},{"B7A_DADPES","XFILIAL('BD6')+BD5->(BD5_CODOPE+BD5_CODLDP+BD5_CODPEG+BD5_NUMERO+BD5_ORIMOV)+BE2->(BE2_SEQUEN+BE2_CODPAD+BE2_CODPRO)    "},{"B7A_ALIPAI","BE2"},{"B7A_CONDIC","                                                                                                                                                      "},{"B7A_TISVER","3.00.01"}})
Aadd(aB7A,{{"B7A_FILIAL","  "},{"B7A_TIPGUI","01"},{"B7A_ALIAS","BA0"},{"B7A_INDICE","1"},{"B7A_TIPO","0"},{"B7A_DADPES","XFILIAL('BA0')+BEA->(BEA_OPEUSR)                                                                                        "},{"B7A_ALIPAI","BEA"},{"B7A_CONDIC","                                                                                                                                                      "},{"B7A_TISVER","3.00.01"}})
Aadd(aB7A,{{"B7A_FILIAL","  "},{"B7A_TIPGUI","01"},{"B7A_ALIAS","BA1"},{"B7A_INDICE","2"},{"B7A_TIPO","0"},{"B7A_DADPES","XFILIAL('BA1')+BEA->(BEA_OPEUSR+BEA_CODEMP+BEA_MATRIC+BEA_TIPREG)                                                       "},{"B7A_ALIPAI","BEA"},{"B7A_CONDIC","                                                                                                                                                      "},{"B7A_TISVER","3.00.01"}})
Aadd(aB7A,{{"B7A_FILIAL","  "},{"B7A_TIPGUI","01"},{"B7A_ALIAS","BAU"},{"B7A_INDICE","1"},{"B7A_TIPO","0"},{"B7A_DADPES","XFILIAL('BAU')+BEA->BEA_CODRDA                                                                                          "},{"B7A_ALIPAI","BEA"},{"B7A_CONDIC","                                                                                                                                                      "},{"B7A_TISVER","3.00.01"}})
Aadd(aB7A,{{"B7A_FILIAL","  "},{"B7A_TIPGUI","01"},{"B7A_ALIAS","BD5"},{"B7A_INDICE","1"},{"B7A_TIPO","0"},{"B7A_DADPES","XFILIAL('BD5')+BEA->(BEA_OPEMOV+BEA_CODLDP+BEA_CODPEG+BEA_NUMGUI)                                                       "},{"B7A_ALIPAI","BEA"},{"B7A_CONDIC","                                                                                                                                                      "},{"B7A_TISVER","3.00.01"}})
Aadd(aB7A,{{"B7A_FILIAL","  "},{"B7A_TIPGUI","01"},{"B7A_ALIAS","BB0"},{"B7A_INDICE","4"},{"B7A_TIPO","0"},{"B7A_DADPES","XFILIAL('BB0')+BEA->(BEA_ESTEXE+BEA_REGEXE+BEA_SIGEXE)                                                                  "},{"B7A_ALIPAI","BEA"},{"B7A_CONDIC","! EMPTY(BEA->BEA_REGEXE)                                                                                                                              "},{"B7A_TISVER","3.00.01"}})
Aadd(aB7A,{{"B7A_FILIAL","  "},{"B7A_TIPGUI","01"},{"B7A_ALIAS","BAQ"},{"B7A_INDICE","1"},{"B7A_TIPO","0"},{"B7A_DADPES","XFILIAL('BAQ')+BEA->(BEA_OPEMOV+BEA_CODESP)                                                                             "},{"B7A_ALIPAI","BEA"},{"B7A_CONDIC","                                                                                                                                                      "},{"B7A_TISVER","3.00.01"}})

Aadd(aB7A,{{"B7A_FILIAL","  "},{"B7A_TIPGUI","01"},{"B7A_ALIAS","BR4"},{"B7A_INDICE","1"},{"B7A_TIPO","0"},{"B7A_DADPES","XFILIAL('BR4')+BR8->BR8_CODPAD                                                                                          "},{"B7A_ALIPAI","BR8"},{"B7A_CONDIC","                                                                                                                                                      "},{"B7A_TISVER","3.00.01"}})
Aadd(aB7A,{{"B7A_FILIAL","  "},{"B7A_TIPGUI","02"},{"B7A_ALIAS","BEA"},{"B7A_INDICE","1"},{"B7A_TIPO","0"},{"B7A_DADPES","XFILIAL('BEA')+BEA->(BEA_OPEMOV+BEA_ANOAUT+BEA_MESAUT+BEA_NUMAUT+DTOS(BEA_DATPRO)+BEA_HORPRO)                           "},{"B7A_ALIPAI","   "},{"B7A_CONDIC","                                                                                                                                                      "},{"B7A_TISVER","3.00.01"}})
Aadd(aB7A,{{"B7A_FILIAL","  "},{"B7A_TIPGUI","02"},{"B7A_ALIAS","BTS"},{"B7A_INDICE","1"},{"B7A_TIPO","0"},{"B7A_DADPES","XFILIAL('BTS')+(BA1->BA1_MATVID)                                                                                        "},{"B7A_ALIPAI","BA1"},{"B7A_CONDIC","                                                                                                                                                      "},{"B7A_TISVER","3.00.01"}})
Aadd(aB7A,{{"B7A_FILIAL","  "},{"B7A_TIPGUI","02"},{"B7A_ALIAS","BI3"},{"B7A_INDICE","1"},{"B7A_TIPO","0"},{"B7A_DADPES","XFILIAL('BI3')+BA1->(BA1_CODINT+BA1_CODPLA+BA1_VERSAO)                                                                  "},{"B7A_ALIPAI","BA1"},{"B7A_CONDIC","!EMPTY(BA1->BA1_CODPLA)                                                                                                                               "},{"B7A_TISVER","3.00.01"}})
Aadd(aB7A,{{"B7A_FILIAL","  "},{"B7A_TIPGUI","02"},{"B7A_ALIAS","BA3"},{"B7A_INDICE","1"},{"B7A_TIPO","0"},{"B7A_DADPES","XFILIAL('BA3')+BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC)                                                                  "},{"B7A_ALIPAI","BA3"},{"B7A_CONDIC","                                                                                                                                                      "},{"B7A_TISVER","3.00.01"}})
Aadd(aB7A,{{"B7A_FILIAL","  "},{"B7A_TIPGUI","02"},{"B7A_ALIAS","BI3"},{"B7A_INDICE","1"},{"B7A_TIPO","0"},{"B7A_DADPES","XFILIAL('BI3')+BA3->(BA3_CODINT+BA3_CODPLA+BA3_VERSAO)                                                                  "},{"B7A_ALIPAI","BA3"},{"B7A_CONDIC","!EMPTY(BA1->BA3_CODPLA)                                                                                                                               "},{"B7A_TISVER","3.00.01"}})
Aadd(aB7A,{{"B7A_FILIAL","  "},{"B7A_TIPGUI","02"},{"B7A_ALIAS","BB8"},{"B7A_INDICE","1"},{"B7A_TIPO","0"},{"B7A_DADPES","XFILIAL('BB8')+BAU->BAU_CODIGO+BEA->(BEA_OPEMOV+BEA_CODLOC)                                                             "},{"B7A_ALIPAI","BAU"},{"B7A_CONDIC","                                                                                                                                                      "},{"B7A_TISVER","3.00.01"}})
Aadd(aB7A,{{"B7A_FILIAL","  "},{"B7A_TIPGUI","02"},{"B7A_ALIAS","BD6"},{"B7A_INDICE","1"},{"B7A_TIPO","1"},{"B7A_DADPES","XFILIAL('BD6')+BD5->(BD5_CODOPE+BD5_CODLDP+BD5_CODPEG+BD5_NUMERO+BD5_ORIMOV)+BE2->(BE2_SEQUEN+BE2_CODPAD+BE2_CODPRO)    "},{"B7A_ALIPAI","BD5"},{"B7A_CONDIC","                                                                                                                                                      "},{"B7A_TISVER","3.00.01"}})
Aadd(aB7A,{{"B7A_FILIAL","  "},{"B7A_TIPGUI","02"},{"B7A_ALIAS","BAQ"},{"B7A_INDICE","1"},{"B7A_TIPO","1"},{"B7A_DADPES","XFILIAL('BAQ')+BD6->(BD6_OPEEXE+BD6_CODESP)                                                                             "},{"B7A_ALIPAI","BD6"},{"B7A_CONDIC","                                                                                                                                                      "},{"B7A_TISVER","3.00.01"}})
Aadd(aB7A,{{"B7A_FILIAL","  "},{"B7A_TIPGUI","02"},{"B7A_ALIAS","BB0"},{"B7A_INDICE","4"},{"B7A_TIPO","1"},{"B7A_DADPES","XFILIAL('BB0')+BD6->(BD6_ESTEXE+BD6_REGEXE+BD6_SIGEXE)                                                                  "},{"B7A_ALIPAI","BD6"},{"B7A_CONDIC","                                                                                                                                                      "},{"B7A_TISVER","3.00.01"}})
Aadd(aB7A,{{"B7A_FILIAL","  "},{"B7A_TIPGUI","02"},{"B7A_ALIAS","BR8"},{"B7A_INDICE","1"},{"B7A_TIPO","1"},{"B7A_DADPES","XFILIAL('BR8')+BD6->(BD6_CODPAD+BD6_CODPRO)                                                                             "},{"B7A_ALIPAI","BD6"},{"B7A_CONDIC","                                                                                                                                                      "},{"B7A_TISVER","3.00.01"}})
Aadd(aB7A,{{"B7A_FILIAL","  "},{"B7A_TIPGUI","02"},{"B7A_ALIAS","BD7"},{"B7A_INDICE","1"},{"B7A_TIPO","1"},{"B7A_DADPES","XFILIAL('BD7')+BD6->(BD6_CODOPE+BD6_CODLDP+BD6_CODPEG+BD6_NUMERO+BD6_ORIMOV+BD6_SEQUEN)                                 "},{"B7A_ALIPAI","BD6"},{"B7A_CONDIC","                                                                                                                                                      "},{"B7A_TISVER","3.00.01"}})
Aadd(aB7A,{{"B7A_FILIAL","  "},{"B7A_TIPGUI","02"},{"B7A_ALIAS","BWT"},{"B7A_INDICE","1"},{"B7A_TIPO","1"},{"B7A_DADPES","XFILIAL('BWT')+BD7->(BD7_CODOPE+BD7_CODTPA)                                                                             "},{"B7A_ALIPAI","BD7"},{"B7A_CONDIC","                                                                                                                                                      "},{"B7A_TISVER","3.00.01"}})
Aadd(aB7A,{{"B7A_FILIAL","  "},{"B7A_TIPGUI","02"},{"B7A_ALIAS","BD5"},{"B7A_INDICE","1"},{"B7A_TIPO","0"},{"B7A_DADPES","XFILIAL('BD5')+BEA->(BEA_OPEMOV+BEA_CODLDP+BEA_CODPEG+BEA_NUMGUI)                                                       "},{"B7A_ALIPAI","BE2"},{"B7A_CONDIC","                                                                                                                                                      "},{"B7A_TISVER","3.00.01"}})
Aadd(aB7A,{{"B7A_FILIAL","  "},{"B7A_TIPGUI","02"},{"B7A_ALIAS","BGR"},{"B7A_INDICE","1"},{"B7A_TIPO","1"},{"B7A_DADPES","XFILIAL('BGR')+BE2->(BE2_OPEMOV+BE2_VIA)                                                                                "},{"B7A_ALIPAI","BE2"},{"B7A_CONDIC","                                                                                                                                                      "},{"B7A_TISVER","3.00.01"}})
Aadd(aB7A,{{"B7A_FILIAL","  "},{"B7A_TIPGUI","02"},{"B7A_ALIAS","BA0"},{"B7A_INDICE","1"},{"B7A_TIPO","0"},{"B7A_DADPES","XFILIAL('BA0')+BEA->(BEA_OPEUSR)                                                                                        "},{"B7A_ALIPAI","BEA"},{"B7A_CONDIC","                                                                                                                                                      "},{"B7A_TISVER","3.00.01"}})
Aadd(aB7A,{{"B7A_FILIAL","  "},{"B7A_TIPGUI","02"},{"B7A_ALIAS","BA1"},{"B7A_INDICE","2"},{"B7A_TIPO","0"},{"B7A_DADPES","XFILIAL('BA1')+BEA->(BEA_OPEUSR+BEA_CODEMP+BEA_MATRIC+BEA_TIPREG)                                                       "},{"B7A_ALIPAI","BEA"},{"B7A_CONDIC","                                                                                                                                                      "},{"B7A_TISVER","3.00.01"}})
Aadd(aB7A,{{"B7A_FILIAL","  "},{"B7A_TIPGUI","02"},{"B7A_ALIAS","BAU"},{"B7A_INDICE","1"},{"B7A_TIPO","0"},{"B7A_DADPES","XFILIAL('BAU')+BEA->BEA_CODRDA                                                                                          "},{"B7A_ALIPAI","BEA"},{"B7A_CONDIC","                                                                                                                                                      "},{"B7A_TISVER","3.00.01"}})
Aadd(aB7A,{{"B7A_FILIAL","  "},{"B7A_TIPGUI","02"},{"B7A_ALIAS","BE2"},{"B7A_INDICE","1"},{"B7A_TIPO","1"},{"B7A_DADPES","XFILIAL('BE2')+BEA->(BEA_OPEMOV+BEA_ANOAUT+BEA_MESAUT+BEA_NUMAUT )                                                      "},{"B7A_ALIPAI","BEA"},{"B7A_CONDIC","                                                                                                                                                      "},{"B7A_TISVER","3.00.01"}})
Aadd(aB7A,{{"B7A_FILIAL","  "},{"B7A_TIPGUI","02"},{"B7A_ALIAS","BDR"},{"B7A_INDICE","1"},{"B7A_TIPO","0"},{"B7A_DADPES","XFILIAL('BDR')+BEA->(BEA_OPEMOV+BEA_TIPADM)                                                                             "},{"B7A_ALIPAI","BEA"},{"B7A_CONDIC","                                                                                                                                                      "},{"B7A_TISVER","3.00.01"}})
Aadd(aB7A,{{"B7A_FILIAL","  "},{"B7A_TIPGUI","02"},{"B7A_ALIAS","BR4"},{"B7A_INDICE","1"},{"B7A_TIPO","0"},{"B7A_DADPES","XFILIAL('BR4')+BR8->BR8_CODPAD                                                                                          "},{"B7A_ALIPAI","BR8"},{"B7A_CONDIC","                                                                                                                                                      "},{"B7A_TISVER","3.00.01"}})
Aadd(aB7A,{{"B7A_FILIAL","  "},{"B7A_TIPGUI","03"},{"B7A_ALIAS","BE4"},{"B7A_INDICE","2"},{"B7A_TIPO","0"},{"B7A_DADPES","XFILIAL('BE4')+BE4->(BE4_CODOPE+BE4_ANOINT+BE4_MESINT+BE4_NUMINT)                                                       "},{"B7A_ALIPAI","   "},{"B7A_CONDIC","                                                                                                                                                      "},{"B7A_TISVER","3.00.01"}})
Aadd(aB7A,{{"B7A_FILIAL","  "},{"B7A_TIPGUI","03"},{"B7A_ALIAS","BA3"},{"B7A_INDICE","1"},{"B7A_TIPO","0"},{"B7A_DADPES","XFILIAL('BA3')+BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC)                                                                  "},{"B7A_ALIPAI","BA1"},{"B7A_CONDIC","                                                                                                                                                      "},{"B7A_TISVER","3.00.01"}})
Aadd(aB7A,{{"B7A_FILIAL","  "},{"B7A_TIPGUI","03"},{"B7A_ALIAS","BG9"},{"B7A_INDICE","1"},{"B7A_TIPO","0"},{"B7A_DADPES","XFILIAL('BG9')+BA1->(BA1_CODINT+BA1_CODEMP)                                                                             "},{"B7A_ALIPAI","BA1"},{"B7A_CONDIC","                                                                                                                                                      "},{"B7A_TISVER","3.00.01"}})
Aadd(aB7A,{{"B7A_FILIAL","  "},{"B7A_TIPGUI","03"},{"B7A_ALIAS","BI3"},{"B7A_INDICE","1"},{"B7A_TIPO","0"},{"B7A_DADPES","XFILIAL('BI3')+BA1->(BA1_CODINT+BA1_CODPLA+BA1_VERSAO)                                                                  "},{"B7A_ALIPAI","BA1"},{"B7A_CONDIC","!EMPTY(BA1->BA1_CODPLA)                                                                                                                               "},{"B7A_TISVER","3.00.01"}})
Aadd(aB7A,{{"B7A_FILIAL","  "},{"B7A_TIPGUI","03"},{"B7A_ALIAS","BTS"},{"B7A_INDICE","1"},{"B7A_TIPO","0"},{"B7A_DADPES","XFILIAL('BTS')+BA1->BA1_MATVID                                                                                          "},{"B7A_ALIPAI","BA1"},{"B7A_CONDIC","                                                                                                                                                      "},{"B7A_TISVER","3.00.01"}})
Aadd(aB7A,{{"B7A_FILIAL","  "},{"B7A_TIPGUI","03"},{"B7A_ALIAS","BI3"},{"B7A_INDICE","1"},{"B7A_TIPO","0"},{"B7A_DADPES","XFILIAL('BI3')+BA3->(BA3_CODINT+BA3_CODPLA+BA3_VERSAO)                                                                  "},{"B7A_ALIPAI","BA3"},{"B7A_CONDIC","EMPTY(BA1->BA1_CODPLA)                                                                                                                                "},{"B7A_TISVER","3.00.01"}})
Aadd(aB7A,{{"B7A_FILIAL","  "},{"B7A_TIPGUI","03"},{"B7A_ALIAS","BA0"},{"B7A_INDICE","1"},{"B7A_TIPO","0"},{"B7A_DADPES","XFILIAL('BA0')+ BE4->(BE4_OPEUSR)                                                                                       "},{"B7A_ALIPAI","BE4"},{"B7A_CONDIC","                                                                                                                                                      "},{"B7A_TISVER","3.00.01"}})
Aadd(aB7A,{{"B7A_FILIAL","  "},{"B7A_TIPGUI","03"},{"B7A_ALIAS","BI4"},{"B7A_INDICE","1"},{"B7A_TIPO","0"},{"B7A_DADPES","XFILIAL('BI4')+BE4->BE4_PADINT                                                                                          "},{"B7A_ALIPAI","BE4"},{"B7A_CONDIC","                                                                                                                                                      "},{"B7A_TISVER","3.00.01"}})
Aadd(aB7A,{{"B7A_FILIAL","  "},{"B7A_TIPGUI","03"},{"B7A_ALIAS","BA1"},{"B7A_INDICE","2"},{"B7A_TIPO","0"},{"B7A_DADPES","XFILIAL('BA1')+BE4->(BE4_OPEUSR+BE4_CODEMP+BE4_MATRIC+BE4_TIPREG)                                                       "},{"B7A_ALIPAI","BE4"},{"B7A_CONDIC","                                                                                                                                                      "},{"B7A_TISVER","3.00.01"}})
Aadd(aB7A,{{"B7A_FILIAL","  "},{"B7A_TIPGUI","03"},{"B7A_ALIAS","BAU"},{"B7A_INDICE","1"},{"B7A_TIPO","0"},{"B7A_DADPES","XFILIAL('BAU')+BE4->BE4_CODRDA                                                                                          "},{"B7A_ALIPAI","BE4"},{"B7A_CONDIC","                                                                                                                                                      "},{"B7A_TISVER","3.00.01"}})
Aadd(aB7A,{{"B7A_FILIAL","  "},{"B7A_TIPGUI","03"},{"B7A_ALIAS","BAQ"},{"B7A_INDICE","1"},{"B7A_TIPO","0"},{"B7A_DADPES","XFILIAL('BAQ')+BE4->(BE4_CODOPE+BE4_CODESP)                                                                             "},{"B7A_ALIPAI","BE4"},{"B7A_CONDIC","                                                                                                                                                      "},{"B7A_TISVER","3.00.01"}})
Aadd(aB7A,{{"B7A_FILIAL","  "},{"B7A_TIPGUI","03"},{"B7A_ALIAS","BB0"},{"B7A_INDICE","4"},{"B7A_TIPO","0"},{"B7A_DADPES","XFILIAL('BB0')+BE4->(BE4_ESTSOL+BE4_REGSOL+BE4_SIGLA)                                                                   "},{"B7A_ALIPAI","BE4"},{"B7A_CONDIC","                                                                                                                                                      "},{"B7A_TISVER","3.00.01"}})
Aadd(aB7A,{{"B7A_FILIAL","  "},{"B7A_TIPGUI","03"},{"B7A_ALIAS","BDR"},{"B7A_INDICE","1"},{"B7A_TIPO","0"},{"B7A_DADPES","XFILIAL('BDR')+BE4->(BE4_CODOPE+BE4_TIPADM)                                                                             "},{"B7A_ALIPAI","BE4"},{"B7A_CONDIC","                                                                                                                                                      "},{"B7A_TISVER","3.00.01"}})
Aadd(aB7A,{{"B7A_FILIAL","  "},{"B7A_TIPGUI","03"},{"B7A_ALIAS","BEJ"},{"B7A_INDICE","1"},{"B7A_TIPO","1"},{"B7A_DADPES","XFILIAL('BEJ')+BE4->(BE4_CODOPE+BE4_ANOINT+BE4_MESINT+BE4_NUMINT)                                                       "},{"B7A_ALIPAI","BE4"},{"B7A_CONDIC","                                                                                                                                                      "},{"B7A_TISVER","3.00.01"}})
Aadd(aB7A,{{"B7A_FILIAL","  "},{"B7A_TIPGUI","03"},{"B7A_ALIAS","BR8"},{"B7A_INDICE","1"},{"B7A_TIPO","1"},{"B7A_DADPES","XFILIAL('BR8')+BEJ->(BEJ_CODPAD+BEJ_CODPRO)                                                                             "},{"B7A_ALIPAI","BE4"},{"B7A_CONDIC","                                                                                                                                                      "},{"B7A_TISVER","3.00.01"}})
Aadd(aB7A,{{"B7A_FILIAL","  "},{"B7A_TIPGUI","03"},{"B7A_ALIAS","BD6"},{"B7A_INDICE","1"},{"B7A_TIPO","1"},{"B7A_DADPES","XFILIAL('BD6')+BE4->(BE4_CODOPE+BE4_CODLDP+BE4_CODPEG+BE4_NUMERO+BE4_ORIMOV)+BEJ->(BEJ_SEQUEN+BEJ_CODPAD+BEJ_CODPRO)    "},{"B7A_ALIPAI","BR8"},{"B7A_CONDIC","                                                                                                                                                      "},{"B7A_TISVER","3.00.01"}})
Aadd(aB7A,{{"B7A_FILIAL","  "},{"B7A_TIPGUI","03"},{"B7A_ALIAS","BQV"},{"B7A_INDICE","1"},{"B7A_TIPO","1"},{"B7A_DADPES","XFILIAL('BQV') + BE4->(BE4_CODOPE + BE4->BE4_ANOINT + BE4->BE4_MESINT + BE4->BE4_NUMINT)                                "},{"B7A_ALIPAI","BR8"},{"B7A_CONDIC","                                                                                                                                                      "},{"B7A_TISVER","3.00.01"}})
Aadd(aB7A,{{"B7A_FILIAL","  "},{"B7A_TIPGUI","03"},{"B7A_ALIAS","BN5"},{"B7A_INDICE","1"},{"B7A_TIPO","0"},{"B7A_DADPES","XFILIAL('BN5')+BQV->(BQV_OPEUSR+BQV_PADCON)                                                                             "},{"B7A_ALIPAI","BR8"},{"B7A_CONDIC","                                                                                                                                                      "},{"B7A_TISVER","3.00.01"}})
Aadd(aB7A,{{"B7A_FILIAL","  "},{"B7A_TIPGUI","03"},{"B7A_ALIAS","BR4"},{"B7A_INDICE","1"},{"B7A_TIPO","0"},{"B7A_DADPES","XFILIAL('BR4')+BR8->BR8_CODPAD                                                                                          "},{"B7A_ALIPAI","BR8"},{"B7A_CONDIC","                                                                                                                                                      "},{"B7A_TISVER","3.00.01"}})
Aadd(aB7A,{{"B7A_FILIAL","  "},{"B7A_TIPGUI","05"},{"B7A_ALIAS","BE4"},{"B7A_INDICE","2"},{"B7A_TIPO","0"},{"B7A_DADPES","XFILIAL('BE4')+BE4->(BE4_CODOPE+BE4_ANOINT+BE4_MESINT+BE4_NUMINT)                                                       "},{"B7A_ALIPAI","   "},{"B7A_CONDIC","                                                                                                                                                      "},{"B7A_TISVER","3.00.01"}})
Aadd(aB7A,{{"B7A_FILIAL","  "},{"B7A_TIPGUI","05"},{"B7A_ALIAS","BA3"},{"B7A_INDICE","1"},{"B7A_TIPO","0"},{"B7A_DADPES","XFILIAL('BA3')+BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC)                                                                  "},{"B7A_ALIPAI","BA1"},{"B7A_CONDIC","                                                                                                                                                      "},{"B7A_TISVER","3.00.01"}})
Aadd(aB7A,{{"B7A_FILIAL","  "},{"B7A_TIPGUI","05"},{"B7A_ALIAS","BG9"},{"B7A_INDICE","1"},{"B7A_TIPO","0"},{"B7A_DADPES","XFILIAL('BG9')+BA1->(BA1_CODINT+BA1_CODEMP)                                                                             "},{"B7A_ALIPAI","BA1"},{"B7A_CONDIC","                                                                                                                                                      "},{"B7A_TISVER","3.00.01"}})
Aadd(aB7A,{{"B7A_FILIAL","  "},{"B7A_TIPGUI","05"},{"B7A_ALIAS","BI3"},{"B7A_INDICE","1"},{"B7A_TIPO","0"},{"B7A_DADPES","XFILIAL('BI3')+BA1->(BA1_CODINT+BA1_CODPLA+BA1_VERSAO)                                                                  "},{"B7A_ALIPAI","BA1"},{"B7A_CONDIC","!EMPTY(BA1->BA1_CODPLA)                                                                                                                               "},{"B7A_TISVER","3.00.01"}})
Aadd(aB7A,{{"B7A_FILIAL","  "},{"B7A_TIPGUI","05"},{"B7A_ALIAS","BTS"},{"B7A_INDICE","1"},{"B7A_TIPO","0"},{"B7A_DADPES","XFILIAL('BTS')+BA1->BA1_MATVID                                                                                          "},{"B7A_ALIPAI","BA1"},{"B7A_CONDIC","                                                                                                                                                      "},{"B7A_TISVER","3.00.01"}})
Aadd(aB7A,{{"B7A_FILIAL","  "},{"B7A_TIPGUI","05"},{"B7A_ALIAS","BI3"},{"B7A_INDICE","1"},{"B7A_TIPO","0"},{"B7A_DADPES","XFILIAL('BI3')+BA3->(BA3_CODINT+BA3_CODPLA+BA3_VERSAO)                                                                  "},{"B7A_ALIPAI","BA3"},{"B7A_CONDIC","EMPTY(BA1->BA1_CODPLA)                                                                                                                                "},{"B7A_TISVER","3.00.01"}})
Aadd(aB7A,{{"B7A_FILIAL","  "},{"B7A_TIPGUI","05"},{"B7A_ALIAS","BD7"},{"B7A_INDICE","1"},{"B7A_TIPO","1"},{"B7A_DADPES","XFILIAL('BD7')+BD6->(BD6_CODOPE+BD6_CODLDP+BD6_CODPEG+BD6_NUMERO+BD6_ORIMOV+BD6_SEQUEN)                                 "},{"B7A_ALIPAI","BD6"},{"B7A_CONDIC","                                                                                                                                                      "},{"B7A_TISVER","3.00.01"}})
Aadd(aB7A,{{"B7A_FILIAL","  "},{"B7A_TIPGUI","05"},{"B7A_ALIAS","BWT"},{"B7A_INDICE","1"},{"B7A_TIPO","1"},{"B7A_DADPES","XFILIAL('BWT')+BD7->(BD7_CODOPE+BD7_CODTPA)                                                                             "},{"B7A_ALIPAI","BD7"},{"B7A_CONDIC","                                                                                                                                                      "},{"B7A_TISVER","3.00.01"}})
Aadd(aB7A,{{"B7A_FILIAL","  "},{"B7A_TIPGUI","05"},{"B7A_ALIAS","BB8"},{"B7A_INDICE","1"},{"B7A_TIPO","0"},{"B7A_DADPES","XFILIAL('BB8')+BE4->(BE4_CODRDA+BE4_CODOPE+BE4_CODLOC)                                                                  "},{"B7A_ALIPAI","BE4"},{"B7A_CONDIC","                                                                                                                                                      "},{"B7A_TISVER","3.00.01"}})
Aadd(aB7A,{{"B7A_FILIAL","  "},{"B7A_TIPGUI","05"},{"B7A_ALIAS","BA0"},{"B7A_INDICE","1"},{"B7A_TIPO","0"},{"B7A_DADPES","XFILIAL('BA0')+ BE4->(BE4_OPEUSR)                                                                                       "},{"B7A_ALIPAI","BE4"},{"B7A_CONDIC","                                                                                                                                                      "},{"B7A_TISVER","3.00.01"}})
Aadd(aB7A,{{"B7A_FILIAL","  "},{"B7A_TIPGUI","05"},{"B7A_ALIAS","BI4"},{"B7A_INDICE","1"},{"B7A_TIPO","0"},{"B7A_DADPES","XFILIAL('BI4')+BE4->BE4_PADINT                                                                                          "},{"B7A_ALIPAI","BE4"},{"B7A_CONDIC","                                                                                                                                                      "},{"B7A_TISVER","3.00.01"}})
Aadd(aB7A,{{"B7A_FILIAL","  "},{"B7A_TIPGUI","05"},{"B7A_ALIAS","BA1"},{"B7A_INDICE","2"},{"B7A_TIPO","0"},{"B7A_DADPES","XFILIAL('BA1')+BE4->(BE4_OPEUSR+BE4_CODEMP+BE4_MATRIC+BE4_TIPREG)                                                       "},{"B7A_ALIPAI","BE4"},{"B7A_CONDIC","                                                                                                                                                      "},{"B7A_TISVER","3.00.01"}})
Aadd(aB7A,{{"B7A_FILIAL","  "},{"B7A_TIPGUI","05"},{"B7A_ALIAS","BAU"},{"B7A_INDICE","1"},{"B7A_TIPO","0"},{"B7A_DADPES","XFILIAL('BAU')+BE4->BE4_CODRDA                                                                                          "},{"B7A_ALIPAI","BE4"},{"B7A_CONDIC","                                                                                                                                                      "},{"B7A_TISVER","3.00.01"}})
Aadd(aB7A,{{"B7A_FILIAL","  "},{"B7A_TIPGUI","05"},{"B7A_ALIAS","BAQ"},{"B7A_INDICE","1"},{"B7A_TIPO","1"},{"B7A_DADPES","XFILIAL('BAQ')+BE4->(BE4_CODOPE+BE4_CODESP)                                                                             "},{"B7A_ALIPAI","BE4"},{"B7A_CONDIC","                                                                                                                                                      "},{"B7A_TISVER","3.00.01"}})
Aadd(aB7A,{{"B7A_FILIAL","  "},{"B7A_TIPGUI","05"},{"B7A_ALIAS","BB0"},{"B7A_INDICE","4"},{"B7A_TIPO","0"},{"B7A_DADPES","XFILIAL('BB0')+BE4->(BE4_ESTSOL+BE4_REGSOL+BE4_SIGLA)                                                                   "},{"B7A_ALIPAI","BE4"},{"B7A_CONDIC","                                                                                                                                                      "},{"B7A_TISVER","3.00.01"}})
Aadd(aB7A,{{"B7A_FILIAL","  "},{"B7A_TIPGUI","05"},{"B7A_ALIAS","BDR"},{"B7A_INDICE","1"},{"B7A_TIPO","0"},{"B7A_DADPES","XFILIAL('BDR')+BE4->(BE4_CODOPE+BE4_TIPADM)                                                                             "},{"B7A_ALIPAI","BE4"},{"B7A_CONDIC","                                                                                                                                                      "},{"B7A_TISVER","3.00.01"}})
Aadd(aB7A,{{"B7A_FILIAL","  "},{"B7A_TIPGUI","05"},{"B7A_ALIAS","BEJ"},{"B7A_INDICE","1"},{"B7A_TIPO","1"},{"B7A_DADPES","XFILIAL('BEJ')+BE4->(BE4_CODOPE+BE4_ANOINT+BE4_MESINT+BE4_NUMINT)                                                       "},{"B7A_ALIPAI","BE4"},{"B7A_CONDIC","                                                                                                                                                      "},{"B7A_TISVER","3.00.01"}})
Aadd(aB7A,{{"B7A_FILIAL","  "},{"B7A_TIPGUI","05"},{"B7A_ALIAS","BR8"},{"B7A_INDICE","1"},{"B7A_TIPO","1"},{"B7A_DADPES","XFILIAL('BR8')+BEJ->(BEJ_CODPAD+BEJ_CODPRO)                                                                             "},{"B7A_ALIPAI","BE4"},{"B7A_CONDIC","                                                                                                                                                      "},{"B7A_TISVER","3.00.01"}})
//Aadd(aB7A,{{"B7A_FILIAL","  "},{"B7A_TIPGUI","05"},{"B7A_ALIAS","BB8"},{"B7A_INDICE","1"},{"B7A_TIPO","0"},{"B7A_DADPES","XFILIAL('BB8')+BE4->(BE4_CODRDA+BE4_CODOPE+BE4_CODLOC)                                                                  "},{"B7A_ALIPAI","BE4"},{"B7A_CONDIC","                                                                                                                                                      "},{"B7A_TISVER","3.00.01"}})- Registro duplicado
Aadd(aB7A,{{"B7A_FILIAL","  "},{"B7A_TIPGUI","05"},{"B7A_ALIAS","BIY"},{"B7A_INDICE","1"},{"B7A_TIPO","0"},{"B7A_DADPES","XFILIAL('BIY')+BE4->(BE4_CODOPE+BE4_TIPALT)                                                                             "},{"B7A_ALIPAI","BE4"},{"B7A_CONDIC","                                                                                                                                                      "},{"B7A_TISVER","3.00.01"}})
Aadd(aB7A,{{"B7A_FILIAL","  "},{"B7A_TIPGUI","05"},{"B7A_ALIAS","BGR"},{"B7A_INDICE","1"},{"B7A_TIPO","1"},{"B7A_DADPES","XFILIAL('BGR')+BEJ->(BEJ_CODOPE+BEJ_VIA)                                                                                "},{"B7A_ALIPAI","BEJ"},{"B7A_CONDIC","                                                                                                                                                      "},{"B7A_TISVER","3.00.01"}})
Aadd(aB7A,{{"B7A_FILIAL","  "},{"B7A_TIPGUI","05"},{"B7A_ALIAS","BD6"},{"B7A_INDICE","1"},{"B7A_TIPO","1"},{"B7A_DADPES","XFILIAL('BD6')+BE4->(BE4_CODOPE+BE4_CODLDP+BE4_CODPEG+BE4_NUMERO+BE4_ORIMOV)+BEJ->(BEJ_SEQUEN+BEJ_CODPAD+BEJ_CODPRO)    "},{"B7A_ALIPAI","BR8"},{"B7A_CONDIC","                                                                                                                                                      "},{"B7A_TISVER","3.00.01"}})
Aadd(aB7A,{{"B7A_FILIAL","  "},{"B7A_TIPGUI","05"},{"B7A_ALIAS","BQV"},{"B7A_INDICE","1"},{"B7A_TIPO","1"},{"B7A_DADPES","XFILIAL('BQV') + BE4->(BE4_CODOPE + BE4->BE4_ANOINT + BE4->BE4_MESINT + BE4->BE4_NUMINT)                                "},{"B7A_ALIPAI","BR8"},{"B7A_CONDIC","                                                                                                                                                      "},{"B7A_TISVER","3.00.01"}})
Aadd(aB7A,{{"B7A_FILIAL","  "},{"B7A_TIPGUI","05"},{"B7A_ALIAS","BN5"},{"B7A_INDICE","1"},{"B7A_TIPO","0"},{"B7A_DADPES","XFILIAL('BN5')+BQV->(BQV_OPEUSR+BQV_PADCON)                                                                             "},{"B7A_ALIPAI","BR8"},{"B7A_CONDIC","                                                                                                                                                      "},{"B7A_TISVER","3.00.01"}})
Aadd(aB7A,{{"B7A_FILIAL","  "},{"B7A_TIPGUI","05"},{"B7A_ALIAS","BR4"},{"B7A_INDICE","1"},{"B7A_TIPO","0"},{"B7A_DADPES","XFILIAL('BR4')+BR8->BR8_CODPAD                                                                                          "},{"B7A_ALIPAI","BR8"},{"B7A_CONDIC","                                                                                                                                                      "},{"B7A_TISVER","3.00.01"}})
Aadd(aB7A,{{"B7A_FILIAL","  "},{"B7A_TIPGUI","06"},{"B7A_ALIAS","B0D"},{"B7A_INDICE","1"},{"B7A_TIPO","0"},{"B7A_DADPES","XFILIAL('B0D')+B0D->(B0D_OPEMOV+B0D_ANOAUT+B0D_MESAUT+B0D_NUMAUT)                                                       "},{"B7A_ALIPAI","   "},{"B7A_CONDIC","                                                                                                                                                      "},{"B7A_TISVER","3.00.01"}})
Aadd(aB7A,{{"B7A_FILIAL","  "},{"B7A_TIPGUI","06"},{"B7A_ALIAS","BE4"},{"B7A_INDICE","2"},{"B7A_TIPO","0"},{"B7A_DADPES","XFILIAL('BE4')+B0D->B0D_NUMINT                                                                                          "},{"B7A_ALIPAI","B0D"},{"B7A_CONDIC","                                                                                                                                                      "},{"B7A_TISVER","3.00.01"}})
Aadd(aB7A,{{"B7A_FILIAL","  "},{"B7A_TIPGUI","06"},{"B7A_ALIAS","BAU"},{"B7A_INDICE","1"},{"B7A_TIPO","0"},{"B7A_DADPES","XFILIAL('BAU')+B0D->B0D_RDACON                                                                                          "},{"B7A_ALIPAI","B0D"},{"B7A_CONDIC","                                                                                                                                                      "},{"B7A_TISVER","3.00.01"}})
Aadd(aB7A,{{"B7A_FILIAL","  "},{"B7A_TIPGUI","06"},{"B7A_ALIAS","B0E"},{"B7A_INDICE","2"},{"B7A_TIPO","1"},{"B7A_DADPES","XFILIAL('B0E')+B0D->(B0D_OPEMOV+B0D_ANOAUT+B0D_MESAUT+B0D_NUMAUT)                                                       "},{"B7A_ALIPAI","B0D"},{"B7A_CONDIC","                                                                                                                                                      "},{"B7A_TISVER","3.00.01"}})
Aadd(aB7A,{{"B7A_FILIAL","  "},{"B7A_TIPGUI","06"},{"B7A_ALIAS","BWT"},{"B7A_INDICE","1"},{"B7A_TIPO","1"},{"B7A_DADPES","XFILIAL('BWT')+PLSINTPAD()+B0D->B0D_GRAPAR                                                                              "},{"B7A_ALIPAI","B0E"},{"B7A_CONDIC","                                                                                                                                                      "},{"B7A_TISVER","3.00.01"}})
Aadd(aB7A,{{"B7A_FILIAL","  "},{"B7A_TIPGUI","06"},{"B7A_ALIAS","BR8"},{"B7A_INDICE","1"},{"B7A_TIPO","1"},{"B7A_DADPES","XFILIAL('BR8')+B0E->(B0E_CODPAD+B0E_CODPRO)                                                                             "},{"B7A_ALIPAI","B0E"},{"B7A_CONDIC","                                                                                                                                                      "},{"B7A_TISVER","3.00.01"}})
Aadd(aB7A,{{"B7A_FILIAL","  "},{"B7A_TIPGUI","06"},{"B7A_ALIAS","BI4"},{"B7A_INDICE","1"},{"B7A_TIPO","0"},{"B7A_DADPES","XFILIAL('BI4')+B0D->B0D_TIPACO                                                                                          "},{"B7A_ALIPAI","BAU"},{"B7A_CONDIC","                                                                                                                                                      "},{"B7A_TISVER","3.00.01"}})
Aadd(aB7A,{{"B7A_FILIAL","  "},{"B7A_TIPGUI","06"},{"B7A_ALIAS","BB8"},{"B7A_INDICE","1"},{"B7A_TIPO","0"},{"B7A_DADPES","XFILIAL('BB8')+BAU->BAU_CODIGO+B0D->(B0D_OPEMOV+B0D_CODLDP)                                                             "},{"B7A_ALIPAI","BAU"},{"B7A_CONDIC","                                                                                                                                                      "},{"B7A_TISVER","3.00.01"}})
Aadd(aB7A,{{"B7A_FILIAL","  "},{"B7A_TIPGUI","06"},{"B7A_ALIAS","BR4"},{"B7A_INDICE","1"},{"B7A_TIPO","0"},{"B7A_DADPES","XFILIAL('BR4')+BR8->BR8_CODPAD                                                                                          "},{"B7A_ALIPAI","BR8"},{"B7A_CONDIC","                                                                                                                                                      "},{"B7A_TISVER","3.00.01"}})
Return*/
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ?PLSLOADB7B ?Autor ?Everton M. Fernandes Data ?08.07.13 ³±?
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ?Carrega o array da tabela do load                         ³±?
±±?         ?                                             			   ³±?
±±?         ?                                                     	   ³±?
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*//*
Function CABLOADB7B(aB7B)
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","01"},{"B7B_ORDEM",         3},{"B7B_DESCRI","NUM GUIA OPERADORA  "},{"B7B_DADPAD","' '                 "},{"B7B_ALIAS","   "},{"B7B_TABTIS","  "},{"B7B_CAMPO","                                                                                                                                                                                                        "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","01"},{"B7B_ORDEM",         1},{"B7B_DESCRI","REGISTRO ANS        "},{"B7B_DADPAD","                    "},{"B7B_ALIAS","BA0"},{"B7B_TABTIS","  "},{"B7B_CAMPO","BA0->BA0_SUSEP                                                                                                                                                                                          "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","01"},{"B7B_ORDEM",         5},{"B7B_DESCRI","VALID CARTEIRINHA   "},{"B7B_DADPAD","                    "},{"B7B_ALIAS","BA1"},{"B7B_TABTIS","  "},{"B7B_CAMPO","BA1->BA1_DTVLCR                                                                                                                                                                                         "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","01"},{"B7B_ORDEM",         7},{"B7B_DESCRI","NOME BENEFICIARIO   "},{"B7B_DADPAD","                    "},{"B7B_ALIAS","BA1"},{"B7B_TABTIS","  "},{"B7B_CAMPO","BA1->BA1_NOMUSR                                                                                                                                                                                         "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","01"},{"B7B_ORDEM",        16},{"B7B_DESCRI","COD CBOS            "},{"B7B_DADPAD","                    "},{"B7B_ALIAS","BAQ"},{"B7B_TABTIS","  "},{"B7B_CAMPO","BAQ->BAQ_CBOS                                                                                                                                                                                           "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","01"},{"B7B_ORDEM",         9},{"B7B_DESCRI","CODIGO CONTRATADO   "},{"B7B_DADPAD","                    "},{"B7B_ALIAS","BAU"},{"B7B_TABTIS","  "},{"B7B_CAMPO","IIF(LEN(ALLTRIM(BAU->BAU_CPFCGC)) == 11, TRANSFORM(BAU->BAU_CPFCGC, '@R 999.999.999-99'), TRANSFORM(BAU->BAU_CPFCGC, '@R 99.999.999/9999-99'))                                                          "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","01"},{"B7B_ORDEM",        10},{"B7B_DESCRI","NOME CONTRATADO     "},{"B7B_DADPAD","                    "},{"B7B_ALIAS","BAU"},{"B7B_TABTIS","  "},{"B7B_CAMPO","BAU->BAU_NOME                                                                                                                                                                                           "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","01"},{"B7B_ORDEM",        12},{"B7B_DESCRI","NOME EXECUTANTE     "},{"B7B_DADPAD","                    "},{"B7B_ALIAS","BB0"},{"B7B_TABTIS","  "},{"B7B_CAMPO","BB0->BB0_NOME                                                                                                                                                                                           "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","01"},{"B7B_ORDEM",        13},{"B7B_DESCRI","CONSELHO PROFISSIONA"},{"B7B_DADPAD","                    "},{"B7B_ALIAS","BB0"},{"B7B_TABTIS","  "},{"B7B_CAMPO","BB0->BB0_CODSIG                                                                                                                                                                                         "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","01"},{"B7B_ORDEM",        14},{"B7B_DESCRI","NUM CONSELHO        "},{"B7B_DADPAD","                    "},{"B7B_ALIAS","BB0"},{"B7B_TABTIS","  "},{"B7B_CAMPO","BB0->BB0_NUMCR                                                                                                                                                                                          "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","01"},{"B7B_ORDEM",        15},{"B7B_DESCRI","UF                  "},{"B7B_DADPAD","                    "},{"B7B_ALIAS","BB0"},{"B7B_TABTIS","  "},{"B7B_CAMPO","BB0->BB0_ESTADO                                                                                                                                                                                         "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","01"},{"B7B_ORDEM",        11},{"B7B_DESCRI","CODIGO CNES         "},{"B7B_DADPAD","                    "},{"B7B_ALIAS","BB8"},{"B7B_TABTIS","  "},{"B7B_CAMPO","TRANSFORM(BB8->BB8_CNES,PESQPICT('BB8','BB8_CNES'))                                                                                                                                                     "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","01"},{"B7B_ORDEM",        18},{"B7B_DESCRI","DATA ATENDIMENTO    "},{"B7B_DADPAD","                    "},{"B7B_ALIAS","BD6"},{"B7B_TABTIS","  "},{"B7B_CAMPO","BD6->BD6_DATPRO                                                                                                                                                                                         "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","01"},{"B7B_ORDEM",        19},{"B7B_DESCRI","TIPO CONSULTA       "},{"B7B_DADPAD","                    "},{"B7B_ALIAS","BD6"},{"B7B_TABTIS","  "},{"B7B_CAMPO","BD6->BD6_TIPCON                                                                                                                                                                                         "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","01"},{"B7B_ORDEM",        22},{"B7B_DESCRI","VALOR UNITARIO PROC "},{"B7B_DADPAD","                    "},{"B7B_ALIAS","BD6"},{"B7B_TABTIS","  "},{"B7B_CAMPO","ROUND(BD6->BD6_VLRPAG / BD6->BD6_QTDPRO, 2)                                                                                                                                                             "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","01"},{"B7B_ORDEM",         2},{"B7B_DESCRI","NUMERO GUIA PRESTADO"},{"B7B_DADPAD","                    "},{"B7B_ALIAS","BEA"},{"B7B_TABTIS","  "},{"B7B_CAMPO","BEA->(BEA_OPEMOV+'.'+BEA_ANOAUT+'.'+BEA_MESAUT+'-'+BEA_NUMAUT)                                                                                                                                          "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","01"},{"B7B_ORDEM",         4},{"B7B_DESCRI","NUMERO DA CARTEIRA  "},{"B7B_DADPAD","                    "},{"B7B_ALIAS","BEA"},{"B7B_TABTIS","  "},{"B7B_CAMPO","PSRETCART()                                                                                                                                                                                             "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","01"},{"B7B_ORDEM",         6},{"B7B_DESCRI","ATEND RECEM NASCIDO "},{"B7B_DADPAD","                    "},{"B7B_ALIAS","BEA"},{"B7B_TABTIS","  "},{"B7B_CAMPO","IIF(BEA->BEA_ATERNA=='1','S','N')                                                                                                                                                                       "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","01"},{"B7B_ORDEM",        17},{"B7B_DESCRI","INDICA ACIDENTE     "},{"B7B_DADPAD","                    "},{"B7B_ALIAS","BEA"},{"B7B_TABTIS","  "},{"B7B_CAMPO","BEA->BEA_INDACI                                                                                                                                                                                         "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","01"},{"B7B_ORDEM",        23},{"B7B_DESCRI","OBSERVACAO          "},{"B7B_DADPAD","                    "},{"B7B_ALIAS","BEA"},{"B7B_TABTIS","  "},{"B7B_CAMPO"," ALLTRIM(BEA->BEA_MSG01) + ' ' + ALLTRIM(BEA->BEA_MSG02)                                                                                                                                                "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","01"},{"B7B_ORDEM",        24},{"B7B_DESCRI","DATA/ASS MEDICO     "},{"B7B_DADPAD","                    "},{"B7B_ALIAS","BEA"},{"B7B_TABTIS","  "},{"B7B_CAMPO","DDATABASE                                                                                                                                                                                               "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","01"},{"B7B_ORDEM",        25},{"B7B_DESCRI","DATA/ASS BENEFICIARI"},{"B7B_DADPAD","                    "},{"B7B_ALIAS","BEA"},{"B7B_TABTIS","  "},{"B7B_CAMPO","DDATABASE                                                                                                                                                                                               "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","01"},{"B7B_ORDEM",        20},{"B7B_DESCRI","CODIGO TABELA       "},{"B7B_DADPAD","                    "},{"B7B_ALIAS","BR4"},{"B7B_TABTIS","  "},{"B7B_CAMPO","BR4->BR4_CODPAD                                                                                                                                                                                         "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","01"},{"B7B_ORDEM",        21},{"B7B_DESCRI","CODIGO PROCEDIMENTO "},{"B7B_DADPAD","                    "},{"B7B_ALIAS","BR8"},{"B7B_TABTIS","  "},{"B7B_CAMPO","BR8->(BR8_CODPAD+BR8_CODPSA)                                                                                                                                                                            "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","01"},{"B7B_ORDEM",         8},{"B7B_DESCRI","CARTAO NASCIONAL SAU"},{"B7B_DADPAD","                    "},{"B7B_ALIAS","BTS"},{"B7B_TABTIS","  "},{"B7B_CAMPO","BTS->BTS_NRCRNA                                                                                                                                                                                         "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","02"},{"B7B_ORDEM",         7},{"B7B_DESCRI","NUM GUIA OPERADORA  "},{"B7B_DADPAD","' '                 "},{"B7B_ALIAS","   "},{"B7B_TABTIS","  "},{"B7B_CAMPO","                                                                                                                                                                                                        "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","02"},{"B7B_ORDEM",        20},{"B7B_DESCRI","ASSINATURA SOLICITAN"},{"B7B_DADPAD","' '                 "},{"B7B_ALIAS","   "},{"B7B_TABTIS","  "},{"B7B_CAMPO","                                                                                                                                                                                                        "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","02"},{"B7B_ORDEM",        56},{"B7B_DESCRI","DATA PROC SERIE     "},{"B7B_DADPAD","Array(10,1)         "},{"B7B_ALIAS","   "},{"B7B_TABTIS","00"},{"B7B_CAMPO","                                                                                                                                                                                                        "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","02"},{"B7B_ORDEM",        57},{"B7B_DESCRI","ASSINATURA BENEFICIA"},{"B7B_DADPAD","' '                 "},{"B7B_ALIAS","   "},{"B7B_TABTIS","  "},{"B7B_CAMPO","                                                                                                                                                                                                        "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","02"},{"B7B_ORDEM",        58},{"B7B_DESCRI","OBSERVACAO          "},{"B7B_DADPAD","' '                 "},{"B7B_ALIAS","   "},{"B7B_TABTIS","  "},{"B7B_CAMPO","                                                                                                                                                                                                        "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","02"},{"B7B_ORDEM",        66},{"B7B_DESCRI","ASSIN RESP AUTORIZAC"},{"B7B_DADPAD","'  '                "},{"B7B_ALIAS","   "},{"B7B_TABTIS","  "},{"B7B_CAMPO","                                                                                                                                                                                                        "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","02"},{"B7B_ORDEM",        67},{"B7B_DESCRI","ASSIN BENEFICIARIO  "},{"B7B_DADPAD","'  '                "},{"B7B_ALIAS","   "},{"B7B_TABTIS","  "},{"B7B_CAMPO","                                                                                                                                                                                                        "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","02"},{"B7B_ORDEM",        68},{"B7B_DESCRI","ASSIN CONTRATADO    "},{"B7B_DADPAD","'  '                "},{"B7B_ALIAS","   "},{"B7B_TABTIS","  "},{"B7B_CAMPO","                                                                                                                                                                                                        "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","02"},{"B7B_ORDEM",         1},{"B7B_DESCRI","REGISTRO ANS        "},{"B7B_DADPAD","                    "},{"B7B_ALIAS","BA0"},{"B7B_TABTIS","  "},{"B7B_CAMPO","BA0->BA0_SUSEP                                                                                                                                                                                          "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","02"},{"B7B_ORDEM",         6},{"B7B_DESCRI","DATA VALID SENHA    "},{"B7B_DADPAD","                    "},{"B7B_ALIAS","BA1"},{"B7B_TABTIS","  "},{"B7B_CAMPO","BA1->BA1_DTVLCR                                                                                                                                                                                         "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","02"},{"B7B_ORDEM",         9},{"B7B_DESCRI","VALID CARTEIRINHA   "},{"B7B_DADPAD","                    "},{"B7B_ALIAS","BA1"},{"B7B_TABTIS","  "},{"B7B_CAMPO","BA1->BA1_DTVLCR                                                                                                                                                                                         "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","02"},{"B7B_ORDEM",        10},{"B7B_DESCRI","NOME BENEFICIARIO   "},{"B7B_DADPAD","                    "},{"B7B_ALIAS","BA1"},{"B7B_TABTIS","  "},{"B7B_CAMPO","BA1->BA1_NOMUSR                                                                                                                                                                                         "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","02"},{"B7B_ORDEM",        55},{"B7B_DESCRI","COD CBOS            "},{"B7B_DADPAD","                    "},{"B7B_ALIAS","BAQ"},{"B7B_TABTIS","  "},{"B7B_CAMPO","BAQ->BAQ_CBOS                                                                                                                                                                                           "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","!EMPTY(BE2->BE2_REGEXE)                                                                                                                                                                                 "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","02"},{"B7B_ORDEM",        29},{"B7B_DESCRI","CODIGO EXECUTANTE   "},{"B7B_DADPAD","                    "},{"B7B_ALIAS","BAU"},{"B7B_TABTIS","  "},{"B7B_CAMPO","IIF(LEN(ALLTRIM(BAU->BAU_CPFCGC)) == 11, TRANSFORM(BAU->BAU_CPFCGC, '@R 999.999.999-99'), TRANSFORM(BAU->BAU_CPFCGC, '@R 99.999.999/9999-99'))                                                          "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","02"},{"B7B_ORDEM",        30},{"B7B_DESCRI","NOME EXECUTANTE     "},{"B7B_DADPAD","                    "},{"B7B_ALIAS","BAU"},{"B7B_TABTIS","  "},{"B7B_CAMPO","BAU->BAU_NOME                                                                                                                                                                                           "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","02"},{"B7B_ORDEM",        50},{"B7B_DESCRI","CPF EXECUTANTE      "},{"B7B_DADPAD","                    "},{"B7B_ALIAS","BB0"},{"B7B_TABTIS","  "},{"B7B_CAMPO","IIF(LEN(ALLTRIM(BB0->BB0_CGC)) == 11, TRANSFORM(BB0->BB0_CGC, '@R 999.999.999-99'), TRANSFORM(BB0->BB0_CGC, '@R 99.999.999/9999-99'))                                                                   "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","02"},{"B7B_ORDEM",        51},{"B7B_DESCRI","NOME EXECUTANTE     "},{"B7B_DADPAD","                    "},{"B7B_ALIAS","BB0"},{"B7B_TABTIS","  "},{"B7B_CAMPO","BB0->BB0_NOME                                                                                                                                                                                           "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","02"},{"B7B_ORDEM",        52},{"B7B_DESCRI","CONSELHO PROFISSIONA"},{"B7B_DADPAD","                    "},{"B7B_ALIAS","BB0"},{"B7B_TABTIS","  "},{"B7B_CAMPO","BB0->BB0_CODSIG                                                                                                                                                                                         "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","02"},{"B7B_ORDEM",        53},{"B7B_DESCRI","NUM CONSELHO        "},{"B7B_DADPAD","                    "},{"B7B_ALIAS","BB0"},{"B7B_TABTIS","  "},{"B7B_CAMPO","BB0->BB0_NUMCR                                                                                                                                                                                          "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","02"},{"B7B_ORDEM",        54},{"B7B_DESCRI","UF                  "},{"B7B_DADPAD","                    "},{"B7B_ALIAS","BB0"},{"B7B_TABTIS","  "},{"B7B_CAMPO","BB0->BB0_ESTADO                                                                                                                                                                                         "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","02"},{"B7B_ORDEM",        31},{"B7B_DESCRI","CODIGO CNES         "},{"B7B_DADPAD","                    "},{"B7B_ALIAS","BB8"},{"B7B_TABTIS","  "},{"B7B_CAMPO","TRANSFORM(BB8->BB8_CNES,PESQPICT('BB8','BB8_CNES'))                                                                                                                                                     "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","02"},{"B7B_ORDEM",        36},{"B7B_DESCRI","DATA ATENDIMENTO    "},{"B7B_DADPAD","                    "},{"B7B_ALIAS","BD6"},{"B7B_TABTIS","  "},{"B7B_CAMPO","BD6->BD6_DATPRO                                                                                                                                                                                         "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","02"},{"B7B_ORDEM",        37},{"B7B_DESCRI","HORA ATENDIMENTO    "},{"B7B_DADPAD","                    "},{"B7B_ALIAS","BD6"},{"B7B_TABTIS","  "},{"B7B_CAMPO","BD6->BD6_HORPRO                                                                                                                                                                                         "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","02"},{"B7B_ORDEM",        38},{"B7B_DESCRI","HORA FINAL          "},{"B7B_DADPAD","                    "},{"B7B_ALIAS","BD6"},{"B7B_TABTIS","  "},{"B7B_CAMPO","BD6->BD6_HORFIM                                                                                                                                                                                         "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","02"},{"B7B_ORDEM",        45},{"B7B_DESCRI","FATOR RED / ACRESC  "},{"B7B_DADPAD","                    "},{"B7B_ALIAS","BD6"},{"B7B_TABTIS","  "},{"B7B_CAMPO","BD6->BD6_PERC1                                                                                                                                                                                          "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","02"},{"B7B_ORDEM",        46},{"B7B_DESCRI","VALOR UNITARIO      "},{"B7B_DADPAD","                    "},{"B7B_ALIAS","BD6"},{"B7B_TABTIS","  "},{"B7B_CAMPO","ROUND(BD6->BD6_VLRPAG / BD6->BD6_QTDPRO, 2)                                                                                                                                                             "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","02"},{"B7B_ORDEM",        47},{"B7B_DESCRI","VALOR PAGO          "},{"B7B_DADPAD","                    "},{"B7B_ALIAS","BD6"},{"B7B_TABTIS","  "},{"B7B_CAMPO","BD6->BD6_VLRPAG                                                                                                                                                                                         "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","02"},{"B7B_ORDEM",        48},{"B7B_DESCRI","SEQUENCIA           "},{"B7B_DADPAD","                    "},{"B7B_ALIAS","BD6"},{"B7B_TABTIS","  "},{"B7B_CAMPO","BD6->BD6_SEQUEN                                                                                                                                                                                         "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","02"},{"B7B_ORDEM",        59},{"B7B_DESCRI","TOTAL PROCEDIMENTOS "},{"B7B_DADPAD","                    "},{"B7B_ALIAS","BD6"},{"B7B_TABTIS","  "},{"B7B_CAMPO","BD6->BD6_VLRPAG                                                                                                                                                                                         "},{"B7B_TOTALI",.T.},{"B7B_CONDIC","BE2->BE2_QTDPRO > 0 .AND. BR8->BR8_TPPROC == '0'                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","02"},{"B7B_ORDEM",        60},{"B7B_DESCRI","TOTAL TAXAS         "},{"B7B_DADPAD","                    "},{"B7B_ALIAS","BD6"},{"B7B_TABTIS","  "},{"B7B_CAMPO","BD6->BD6_VLRPAG                                                                                                                                                                                         "},{"B7B_TOTALI",.T.},{"B7B_CONDIC","BE2->BE2_QTDPRO > 0 .AND. BR8->BR8_TPPROC == '3'                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","02"},{"B7B_ORDEM",        61},{"B7B_DESCRI","TOTAL DE MATERIAIS  "},{"B7B_DADPAD","                    "},{"B7B_ALIAS","BD6"},{"B7B_TABTIS","  "},{"B7B_CAMPO","BD6->BD6_VLRPAG                                                                                                                                                                                         "},{"B7B_TOTALI",.T.},{"B7B_CONDIC","BE2->BE2_QTDPRO > 0 .AND. BR8->BR8_TPPROC == '1'                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","02"},{"B7B_ORDEM",        62},{"B7B_DESCRI","TOTAL DE OPME       "},{"B7B_DADPAD","                    "},{"B7B_ALIAS","BD6"},{"B7B_TABTIS","  "},{"B7B_CAMPO","BD6->BD6_VLRPAG                                                                                                                                                                                         "},{"B7B_TOTALI",.T.},{"B7B_CONDIC","BE2->BE2_QTDPRO > 0 .AND. BR8->BR8_TPPROC == '5'                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","02"},{"B7B_ORDEM",        63},{"B7B_DESCRI","TOTAL DE MEDICAMENTO"},{"B7B_DADPAD","                    "},{"B7B_ALIAS","BD6"},{"B7B_TABTIS","  "},{"B7B_CAMPO","BD6->BD6_VLRPAG                                                                                                                                                                                         "},{"B7B_TOTALI",.T.},{"B7B_CONDIC","BE2->BE2_QTDPRO > 0 .AND. BR8->BR8_TPPROC == '2'                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","02"},{"B7B_ORDEM",        64},{"B7B_DESCRI","TOTAL GASES MEDIC   "},{"B7B_DADPAD","                    "},{"B7B_ALIAS","BD6"},{"B7B_TABTIS","  "},{"B7B_CAMPO","BD6->BD6_VLRPAG                                                                                                                                                                                         "},{"B7B_TOTALI",.T.},{"B7B_CONDIC","BE2->BE2_QTDPRO > 0 .AND. BR8->BR8_TPPROC == '7'                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","02"},{"B7B_ORDEM",        65},{"B7B_DESCRI","TOTAL GERAL         "},{"B7B_DADPAD","                    "},{"B7B_ALIAS","BD6"},{"B7B_TABTIS","  "},{"B7B_CAMPO","BD6->BD6_VLRPAG                                                                                                                                                                                         "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","02"},{"B7B_ORDEM",        21},{"B7B_DESCRI","CARATER ATENDIMENTO "},{"B7B_DADPAD","                    "},{"B7B_ALIAS","BDR"},{"B7B_TABTIS","  "},{"B7B_CAMPO","BDR->BDR_CARINT                                                                                                                                                                                         "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","02"},{"B7B_ORDEM",        27},{"B7B_DESCRI","QTD SOLICITADA      "},{"B7B_DADPAD","                    "},{"B7B_ALIAS","BE2"},{"B7B_TABTIS","  "},{"B7B_CAMPO","BE2->BE2_QTDSOL                                                                                                                                                                                         "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","02"},{"B7B_ORDEM",        28},{"B7B_DESCRI","QTD AUTORIZADA      "},{"B7B_DADPAD","                    "},{"B7B_ALIAS","BE2"},{"B7B_TABTIS","  "},{"B7B_CAMPO","BE2->(BE2_QTDPRO)                                                                                                                                                                                       "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","02"},{"B7B_ORDEM",        42},{"B7B_DESCRI","QTD AUTORIZADA      "},{"B7B_DADPAD","                    "},{"B7B_ALIAS","BE2"},{"B7B_TABTIS","  "},{"B7B_CAMPO","BE2->(BE2_QTDPRO)                                                                                                                                                                                       "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","02"},{"B7B_ORDEM",        44},{"B7B_DESCRI","TECNICA UTILIZADA   "},{"B7B_DADPAD","                    "},{"B7B_ALIAS","BE2"},{"B7B_TABTIS","  "},{"B7B_CAMPO","BE2->BE2_TECUTI                                                                                                                                                                                         "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","02"},{"B7B_ORDEM",         2},{"B7B_DESCRI","NUMERO GUIA PRESTADO"},{"B7B_DADPAD","                    "},{"B7B_ALIAS","BEA"},{"B7B_TABTIS","  "},{"B7B_CAMPO","BEA->(BEA_OPEMOV+'.'+BEA_ANOAUT+'.'+BEA_MESAUT+'-'+BEA_NUMAUT)                                                                                                                                          "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","02"},{"B7B_ORDEM",         3},{"B7B_DESCRI","NUMERO GUIA INTERNAC"},{"B7B_DADPAD","                    "},{"B7B_ALIAS","BEA"},{"B7B_TABTIS","  "},{"B7B_CAMPO","IIF(!EMPTY(BEA->BEA_GUIPRI),BEA->BEA_GUIPRI,POSICIONE('BD5',1,XFILIAL('BD5')+BEA->(BEA_OPEMOV+BEA_CODLDP+BEA_CODPEG+BEA_NUMGUI),'BD5_GUIPRI'))                                                          "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","02"},{"B7B_ORDEM",         4},{"B7B_DESCRI","DATA DA AUTORIZACAO "},{"B7B_DADPAD","                    "},{"B7B_ALIAS","BEA"},{"B7B_TABTIS","  "},{"B7B_CAMPO","BEA->BEA_DTDIGI                                                                                                                                                                                         "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","02"},{"B7B_ORDEM",         5},{"B7B_DESCRI","SENHA               "},{"B7B_DADPAD","                    "},{"B7B_ALIAS","BEA"},{"B7B_TABTIS","  "},{"B7B_CAMPO","BEA->BEA_SENHA                                                                                                                                                                                          "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","02"},{"B7B_ORDEM",         8},{"B7B_DESCRI","NUMERO CARTEIRINHA  "},{"B7B_DADPAD","                    "},{"B7B_ALIAS","BEA"},{"B7B_TABTIS","  "},{"B7B_CAMPO","PSRETCART()                                                                                                                                                                                             "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","02"},{"B7B_ORDEM",        12},{"B7B_DESCRI","RECEM NASCIDO       "},{"B7B_DADPAD","                    "},{"B7B_ALIAS","BEA"},{"B7B_TABTIS","  "},{"B7B_CAMPO","IIF(BEA->BEA_ATERNA=='1','S','N')                                                                                                                                                                       "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","02"},{"B7B_ORDEM",        13},{"B7B_DESCRI","CODIGO SOLICITANTE  "},{"B7B_DADPAD","                    "},{"B7B_ALIAS","BEA"},{"B7B_TABTIS","  "},{"B7B_CAMPO","PSRETSOL(1)                                                                                                                                                                                             "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","02"},{"B7B_ORDEM",        14},{"B7B_DESCRI","NOME SOLICITANTE    "},{"B7B_DADPAD","                    "},{"B7B_ALIAS","BEA"},{"B7B_TABTIS","  "},{"B7B_CAMPO","PSRETSOL(2)                                                                                                                                                                                             "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","02"},{"B7B_ORDEM",        15},{"B7B_DESCRI","NOME SOL. P. JURIDIC"},{"B7B_DADPAD","                    "},{"B7B_ALIAS","BEA"},{"B7B_TABTIS","  "},{"B7B_CAMPO","BEA->BEA_NOMSOL                                                                                                                                                                                         "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","02"},{"B7B_ORDEM",        16},{"B7B_DESCRI","REG. SOLICITANTE    "},{"B7B_DADPAD","                    "},{"B7B_ALIAS","BEA"},{"B7B_TABTIS","  "},{"B7B_CAMPO","BEA->BEA_SIGLA                                                                                                                                                                                          "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","02"},{"B7B_ORDEM",        17},{"B7B_DESCRI","NUM, CON, REG.      "},{"B7B_DADPAD","                    "},{"B7B_ALIAS","BEA"},{"B7B_TABTIS","  "},{"B7B_CAMPO","BEA->BEA_REGSOL                                                                                                                                                                                         "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","02"},{"B7B_ORDEM",        18},{"B7B_DESCRI","EST. CON. REG       "},{"B7B_DADPAD","                    "},{"B7B_ALIAS","BEA"},{"B7B_TABTIS","  "},{"B7B_CAMPO","BEA->BEA_ESTSOL                                                                                                                                                                                         "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","02"},{"B7B_ORDEM",        19},{"B7B_DESCRI","CBO                 "},{"B7B_DADPAD","                    "},{"B7B_ALIAS","BEA"},{"B7B_TABTIS","  "},{"B7B_CAMPO","POSICIONE('BAQ',1,XFILIAL('BAQ')+BEA->(BEA_OPEMOV+BEA_CODESP),'BAQ_CBOS')                                                                                                                               "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","02"},{"B7B_ORDEM",        22},{"B7B_DESCRI","DATA SOLICITACAO    "},{"B7B_DADPAD","                    "},{"B7B_ALIAS","BEA"},{"B7B_TABTIS","  "},{"B7B_CAMPO","BEA->BEA_DATSOL                                                                                                                                                                                         "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","02"},{"B7B_ORDEM",        23},{"B7B_DESCRI","INDICACAO CLINICA   "},{"B7B_DADPAD","                    "},{"B7B_ALIAS","BEA"},{"B7B_TABTIS","  "},{"B7B_CAMPO","ALLTRIM(BEA->BEA_INDCLI)+' '+ALLTRIM(BEA->BEA_INDCL2)                                                                                                                                                   "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","02"},{"B7B_ORDEM",        32},{"B7B_DESCRI","TIPO ATENDIMENTO    "},{"B7B_DADPAD","                    "},{"B7B_ALIAS","BEA"},{"B7B_TABTIS","  "},{"B7B_CAMPO","BEA->BEA_TIPATE                                                                                                                                                                                         "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","02"},{"B7B_ORDEM",        33},{"B7B_DESCRI","INDICACAO ACIDENTE  "},{"B7B_DADPAD","                    "},{"B7B_ALIAS","BEA"},{"B7B_TABTIS","  "},{"B7B_CAMPO","BEA->BEA_INDACI                                                                                                                                                                                         "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","02"},{"B7B_ORDEM",        34},{"B7B_DESCRI","TIPO CONSULTA       "},{"B7B_DADPAD","                    "},{"B7B_ALIAS","BEA"},{"B7B_TABTIS","  "},{"B7B_CAMPO","BEA->BEA_TIPCON                                                                                                                                                                                         "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","02"},{"B7B_ORDEM",        35},{"B7B_DESCRI","MOTIVO ENCERRAMENTO "},{"B7B_DADPAD","                    "},{"B7B_ALIAS","BEA"},{"B7B_TABTIS","  "},{"B7B_CAMPO","BEA->BEA_TIPSAI                                                                                                                                                                                         "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","02"},{"B7B_ORDEM",        43},{"B7B_DESCRI","VIA ACESSO          "},{"B7B_DADPAD","                    "},{"B7B_ALIAS","BGR"},{"B7B_TABTIS","  "},{"B7B_CAMPO","BGR->BGR_VIATIS                                                                                                                                                                                         "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","02"},{"B7B_ORDEM",        24},{"B7B_DESCRI","TABELA PROCEDIMENTO "},{"B7B_DADPAD","                    "},{"B7B_ALIAS","BR4"},{"B7B_TABTIS","00"},{"B7B_CAMPO","BR4->BR4_CODPAD                                                                                                                                                                                         "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","02"},{"B7B_ORDEM",        39},{"B7B_DESCRI","TABELA PROCEDIMENTO "},{"B7B_DADPAD","                    "},{"B7B_ALIAS","BR4"},{"B7B_TABTIS","00"},{"B7B_CAMPO","BR4->BR4_CODPAD                                                                                                                                                                                         "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","02"},{"B7B_ORDEM",        25},{"B7B_DESCRI","CODIGO PROCEDIMENTO "},{"B7B_DADPAD","                    "},{"B7B_ALIAS","BR8"},{"B7B_TABTIS","00"},{"B7B_CAMPO","BR8->(BR8_CODPAD+BR8_CODPSA)                                                                                                                                                                            "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","02"},{"B7B_ORDEM",        26},{"B7B_DESCRI","DESCRICAO PROC      "},{"B7B_DADPAD","                    "},{"B7B_ALIAS","BR8"},{"B7B_TABTIS","  "},{"B7B_CAMPO","BR8->(BR8_DESCRI)                                                                                                                                                                                       "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","02"},{"B7B_ORDEM",        40},{"B7B_DESCRI","CODIGO PROCEDIMENTO "},{"B7B_DADPAD","                    "},{"B7B_ALIAS","BR8"},{"B7B_TABTIS","00"},{"B7B_CAMPO","BR8->(BR8_CODPAD+BR8_CODPSA)                                                                                                                                                                            "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","02"},{"B7B_ORDEM",        41},{"B7B_DESCRI","DESCRICAO PROC      "},{"B7B_DADPAD","                    "},{"B7B_ALIAS","BR8"},{"B7B_TABTIS","  "},{"B7B_CAMPO","BR8->(BR8_DESCRI)                                                                                                                                                                                       "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","02"},{"B7B_ORDEM",        11},{"B7B_DESCRI","CARTAO NACIONAL SAUD"},{"B7B_DADPAD","                    "},{"B7B_ALIAS","BTS"},{"B7B_TABTIS","  "},{"B7B_CAMPO","BTS->BTS_NRCRNA                                                                                                                                                                                         "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","02"},{"B7B_ORDEM",        49},{"B7B_DESCRI","GRAU PARTICIPACAO   "},{"B7B_DADPAD","                    "},{"B7B_ALIAS","BWT"},{"B7B_TABTIS","  "},{"B7B_CAMPO","' '                                                                                                                                                                                                     "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","03"},{"B7B_ORDEM",         3},{"B7B_DESCRI","NUM GUIA OPERADORA  "},{"B7B_DADPAD","' '                 "},{"B7B_ALIAS","   "},{"B7B_TABTIS","  "},{"B7B_CAMPO","                                                                                                                                                                                                        "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","03"},{"B7B_ORDEM",        47},{"B7B_DESCRI","ASS. SOLICITANTE    "},{"B7B_DADPAD","' '                 "},{"B7B_ALIAS","   "},{"B7B_TABTIS","  "},{"B7B_CAMPO","                                                                                                                                                                                                        "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","03"},{"B7B_ORDEM",        48},{"B7B_DESCRI","ASS. BENEFICIARIO   "},{"B7B_DADPAD","' '                 "},{"B7B_ALIAS","   "},{"B7B_TABTIS","  "},{"B7B_CAMPO","                                                                                                                                                                                                        "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","03"},{"B7B_ORDEM",        49},{"B7B_DESCRI","ASS. RESP AUTORIZACA"},{"B7B_DADPAD","' '                 "},{"B7B_ALIAS","   "},{"B7B_TABTIS","  "},{"B7B_CAMPO","                                                                                                                                                                                                        "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","03"},{"B7B_ORDEM",         1},{"B7B_DESCRI","REGISTRO ANS        "},{"B7B_DADPAD","                    "},{"B7B_ALIAS","BA0"},{"B7B_TABTIS","  "},{"B7B_CAMPO","BA0->BA0_SUSEP                                                                                                                                                                                          "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","03"},{"B7B_ORDEM",         7},{"B7B_DESCRI","NUMERO CARTEIRINHA  "},{"B7B_DADPAD","                    "},{"B7B_ALIAS","BA1"},{"B7B_TABTIS","  "},{"B7B_CAMPO","PSRETCART()                                                                                                                                                                                             "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","03"},{"B7B_ORDEM",         8},{"B7B_DESCRI","VALID CARTEIRINHA   "},{"B7B_DADPAD","                    "},{"B7B_ALIAS","BA1"},{"B7B_TABTIS","  "},{"B7B_CAMPO","BA1->BA1_DTVLCR                                                                                                                                                                                         "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","03"},{"B7B_ORDEM",        10},{"B7B_DESCRI","NOME BENEFICIARIO   "},{"B7B_DADPAD","                    "},{"B7B_ALIAS","BA1"},{"B7B_TABTIS","  "},{"B7B_CAMPO","BA1->BA1_NOMUSR                                                                                                                                                                                         "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","03"},{"B7B_ORDEM",        18},{"B7B_DESCRI","CODIGO CBO          "},{"B7B_DADPAD","                    "},{"B7B_ALIAS","BAQ"},{"B7B_TABTIS","  "},{"B7B_CAMPO","BAQ->BAQ_CBOS                                                                                                                                                                                           "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","03"},{"B7B_ORDEM",        19},{"B7B_DESCRI","COD SOLIC. NA OPERAD"},{"B7B_DADPAD","                    "},{"B7B_ALIAS","BAU"},{"B7B_TABTIS","  "},{"B7B_CAMPO","IIF(LEN(ALLTRIM(BAU->BAU_CPFCGC)) == 11, TRANSFORM(BAU->BAU_CPFCGC, '@R 999.999.999-99'), TRANSFORM(BAU->BAU_CPFCGC, '@R 99.999.999/9999-99'))                                                          "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","03"},{"B7B_ORDEM",        12},{"B7B_DESCRI","CODIGO CONTRATADO   "},{"B7B_DADPAD","                    "},{"B7B_ALIAS","BB0"},{"B7B_TABTIS","  "},{"B7B_CAMPO","IIF(LEN(ALLTRIM(BB0->BB0_CGC)) == 11, TRANSFORM(BB0->BB0_CGC, '@R 999.999.999-99'), TRANSFORM(BB0->BB0_CGC, '@R 99.999.999/9999-99'))                                                                   "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","03"},{"B7B_ORDEM",        13},{"B7B_DESCRI","NOME CONTRATADO     "},{"B7B_DADPAD","                    "},{"B7B_ALIAS","BB0"},{"B7B_TABTIS","  "},{"B7B_CAMPO","BB0->BB0_NOME                                                                                                                                                                                           "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","03"},{"B7B_ORDEM",        43},{"B7B_DESCRI","LOCAL EXECUCAO      "},{"B7B_DADPAD","                    "},{"B7B_ALIAS","BB8"},{"B7B_TABTIS","  "},{"B7B_CAMPO","BB8->BB8_DESLOC                                                                                                                                                                                         "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","03"},{"B7B_ORDEM",        44},{"B7B_DESCRI","CODIGO CNES         "},{"B7B_DADPAD","                    "},{"B7B_ALIAS","BB8"},{"B7B_TABTIS","  "},{"B7B_CAMPO","TRANSFORM(BB8->BB8_CNES, PESQPICT('BB8','BB8_CNES'))                                                                                                                                                    "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","03"},{"B7B_ORDEM",        22},{"B7B_DESCRI","CARATER INTERNACAO  "},{"B7B_DADPAD","                    "},{"B7B_ALIAS","BDR"},{"B7B_TABTIS","  "},{"B7B_CAMPO","BDR->BDR_CARINT                                                                                                                                                                                         "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","03"},{"B7B_ORDEM",         2},{"B7B_DESCRI","NUMERO GUIA PRESTADO"},{"B7B_DADPAD","                    "},{"B7B_ALIAS","BE4"},{"B7B_TABTIS","  "},{"B7B_CAMPO","BE4->(BE4_CODOPE+'.'+BE4_ANOINT+'.'+BE4_MESINT+'-'+BE4_NUMINT)                                                                                                                                          "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","03"},{"B7B_ORDEM",         4},{"B7B_DESCRI","DATA AUTORIZACAO    "},{"B7B_DADPAD","                    "},{"B7B_ALIAS","BE4"},{"B7B_TABTIS","  "},{"B7B_CAMPO","BE4->BE4_DATPRO                                                                                                                                                                                         "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","03"},{"B7B_ORDEM",         5},{"B7B_DESCRI","SENHA               "},{"B7B_DADPAD","                    "},{"B7B_ALIAS","BE4"},{"B7B_TABTIS","  "},{"B7B_CAMPO","BE4->BE4_SENHA                                                                                                                                                                                          "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","03"},{"B7B_ORDEM",         6},{"B7B_DESCRI","DATA VALID SENHA    "},{"B7B_DADPAD","                    "},{"B7B_ALIAS","BE4"},{"B7B_TABTIS","  "},{"B7B_CAMPO","BE4->BE4_DATVAL                                                                                                                                                                                         "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","03"},{"B7B_ORDEM",         9},{"B7B_DESCRI","ATEND RECEM NASCIDO "},{"B7B_DADPAD","                    "},{"B7B_ALIAS","BE4"},{"B7B_TABTIS","  "},{"B7B_CAMPO","IIF(BE4->BE4_ATERNA=='1','S','N')                                                                                                                                                                       "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","03"},{"B7B_ORDEM",        14},{"B7B_DESCRI","NOME SOLICITANTE    "},{"B7B_DADPAD","                    "},{"B7B_ALIAS","BE4"},{"B7B_TABTIS","  "},{"B7B_CAMPO","BE4->BE4_NOMSOL                                                                                                                                                                                         "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","03"},{"B7B_ORDEM",        15},{"B7B_DESCRI","CONSELHO SOLICITANTE"},{"B7B_DADPAD","                    "},{"B7B_ALIAS","BE4"},{"B7B_TABTIS","  "},{"B7B_CAMPO","BE4->BE4_SIGLA                                                                                                                                                                                          "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","03"},{"B7B_ORDEM",        16},{"B7B_DESCRI","REGISTRO CONSELHO   "},{"B7B_DADPAD","                    "},{"B7B_ALIAS","BE4"},{"B7B_TABTIS","  "},{"B7B_CAMPO","BE4->BE4_REGSOL                                                                                                                                                                                         "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","03"},{"B7B_ORDEM",        17},{"B7B_DESCRI","UF CONSELHO         "},{"B7B_DADPAD","                    "},{"B7B_ALIAS","BE4"},{"B7B_TABTIS","  "},{"B7B_CAMPO","BE4->BE4_ESTSOL                                                                                                                                                                                         "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","03"},{"B7B_ORDEM",        20},{"B7B_DESCRI","NOME HOSP. / LOCAL  "},{"B7B_DADPAD","                    "},{"B7B_ALIAS","BE4"},{"B7B_TABTIS","  "},{"B7B_CAMPO","POSICIONE('BB8',1,XFILIAL('BB8')+BE4->(BE4_CODRDA+BE4_OPERDA+BE4_CODLOC),'BB8_DESLOC')                                                                                                                  "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","03"},{"B7B_ORDEM",        21},{"B7B_DESCRI","DATA SUGERIDA INTERN"},{"B7B_DADPAD","                    "},{"B7B_ALIAS","BE4"},{"B7B_TABTIS","  "},{"B7B_CAMPO","BE4->BE4_PRVINT                                                                                                                                                                                         "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","03"},{"B7B_ORDEM",        23},{"B7B_DESCRI","TIPO INTERNACAO     "},{"B7B_DADPAD","                    "},{"B7B_ALIAS","BE4"},{"B7B_TABTIS","  "},{"B7B_CAMPO","PSRETINT(BE4->BE4_GRPINT, BE4->BE4_TIPINT )                                                                                                                                                             "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","03"},{"B7B_ORDEM",        24},{"B7B_DESCRI","REGIME INTERNACAO   "},{"B7B_DADPAD","                    "},{"B7B_ALIAS","BE4"},{"B7B_TABTIS","  "},{"B7B_CAMPO","BE4->BE4_REGINT                                                                                                                                                                                         "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","03"},{"B7B_ORDEM",        25},{"B7B_DESCRI","QTD DIARIAS SOLICITA"},{"B7B_DADPAD","                    "},{"B7B_ALIAS","BE4"},{"B7B_TABTIS","  "},{"B7B_CAMPO","BE4->BE4_DIASSO                                                                                                                                                                                         "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","03"},{"B7B_ORDEM",        26},{"B7B_DESCRI","PREVISAO DE OPME    "},{"B7B_DADPAD","                    "},{"B7B_ALIAS","BE4"},{"B7B_TABTIS","  "},{"B7B_CAMPO","IIF(BE4->BE4_PREOPE=='0','S','N')                                                                                                                                                                       "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","03"},{"B7B_ORDEM",        27},{"B7B_DESCRI","PREVISAO QUIMEOTERAP"},{"B7B_DADPAD","                    "},{"B7B_ALIAS","BE4"},{"B7B_TABTIS","  "},{"B7B_CAMPO","IIF(BE4->BE4_PREQUI=='0','S','N')                                                                                                                                                                       "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","03"},{"B7B_ORDEM",        28},{"B7B_DESCRI","INDICACAO CLINICA   "},{"B7B_DADPAD","                    "},{"B7B_ALIAS","BE4"},{"B7B_TABTIS","  "},{"B7B_CAMPO","ALLTRIM(BE4->BE4_INDCLI)+' '+ALLTRIM(BE4->BE4_INDCL2)                                                                                                                                                   "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","03"},{"B7B_ORDEM",        29},{"B7B_DESCRI","CID 10 PRINCIPAL    "},{"B7B_DADPAD","                    "},{"B7B_ALIAS","BE4"},{"B7B_TABTIS","  "},{"B7B_CAMPO","BE4->BE4_CID                                                                                                                                                                                            "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","GETMV( 'MV_PLSICID' ,, .T. )                                                                                                                                                                            "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","03"},{"B7B_ORDEM",        30},{"B7B_DESCRI","CID 2               "},{"B7B_DADPAD","                    "},{"B7B_ALIAS","BE4"},{"B7B_TABTIS","  "},{"B7B_CAMPO","BE4->BE4_CIDSEC                                                                                                                                                                                         "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","GETMV( 'MV_PLSICID' ,, .T. )                                                                                                                                                                            "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","03"},{"B7B_ORDEM",        31},{"B7B_DESCRI","CID 3               "},{"B7B_DADPAD","                    "},{"B7B_ALIAS","BE4"},{"B7B_TABTIS","  "},{"B7B_CAMPO","BE4->BE4_CID3                                                                                                                                                                                           "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","GETMV( 'MV_PLSICID' ,, .T. )                                                                                                                                                                            "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","03"},{"B7B_ORDEM",        32},{"B7B_DESCRI","CID 4               "},{"B7B_DADPAD","                    "},{"B7B_ALIAS","BE4"},{"B7B_TABTIS","  "},{"B7B_CAMPO","BE4->BE4_CID4                                                                                                                                                                                           "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","GETMV( 'MV_PLSICID' ,, .T. )                                                                                                                                                                            "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","03"},{"B7B_ORDEM",        33},{"B7B_DESCRI","INDICACAO ACIDENTE  "},{"B7B_DADPAD","                    "},{"B7B_ALIAS","BE4"},{"B7B_TABTIS","  "},{"B7B_CAMPO","BE4->BE4_INDACI                                                                                                                                                                                         "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","03"},{"B7B_ORDEM",        39},{"B7B_DESCRI","DATA ADM HOSPITAL   "},{"B7B_DADPAD","                    "},{"B7B_ALIAS","BE4"},{"B7B_TABTIS","  "},{"B7B_CAMPO","BE4->BE4_PRVINT                                                                                                                                                                                         "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","03"},{"B7B_ORDEM",        40},{"B7B_DESCRI","QTD DIARIAS         "},{"B7B_DADPAD","                    "},{"B7B_ALIAS","BE4"},{"B7B_TABTIS","  "},{"B7B_CAMPO","BE4->BE4_DIASIN                                                                                                                                                                                         "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","03"},{"B7B_ORDEM",        45},{"B7B_DESCRI","OBS / JUSTIFICATIVA "},{"B7B_DADPAD","                    "},{"B7B_ALIAS","BE4"},{"B7B_TABTIS","  "},{"B7B_CAMPO","ALLTRIM(BE4->BE4_MSG01) + ' ' + ALLTRIM(BE4->BE4_MSG02)                                                                                                                                                 "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","03"},{"B7B_ORDEM",        46},{"B7B_DESCRI","DATA SOLICITACAO    "},{"B7B_DADPAD","                    "},{"B7B_ALIAS","BE4"},{"B7B_TABTIS","  "},{"B7B_CAMPO","BE4->BE4_DTDIGI                                                                                                                                                                                         "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","03"},{"B7B_ORDEM",        37},{"B7B_DESCRI","QTD SOLICITADA      "},{"B7B_DADPAD","                    "},{"B7B_ALIAS","BEJ"},{"B7B_TABTIS","  "},{"B7B_CAMPO","BEJ->BEJ_QTDSOL                                                                                                                                                                                         "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","03"},{"B7B_ORDEM",        38},{"B7B_DESCRI","QTD AUTORIZADA      "},{"B7B_DADPAD","                    "},{"B7B_ALIAS","BEJ"},{"B7B_TABTIS","  "},{"B7B_CAMPO","IIF(BE4->BE4_STATUS == '3' .OR. BEJ->BEJ_STATUS == '0',0,BEJ->BEJ_QTDPRO)                                                                                                                               "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","03"},{"B7B_ORDEM",        41},{"B7B_DESCRI","TIPO ACOMODACAO     "},{"B7B_DADPAD","                    "},{"B7B_ALIAS","BN5"},{"B7B_TABTIS","  "},{"B7B_CAMPO","BN5->BN5_CODEDI                                                                                                                                                                                         "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","03"},{"B7B_ORDEM",        42},{"B7B_DESCRI","CODIGO EXECUTANTE   "},{"B7B_DADPAD","                    "},{"B7B_ALIAS","BN5"},{"B7B_TABTIS","  "},{"B7B_CAMPO","BN5->BN5_NOMEDI                                                                                                                                                                                         "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","03"},{"B7B_ORDEM",        34},{"B7B_DESCRI","TABELA              "},{"B7B_DADPAD","                    "},{"B7B_ALIAS","BR4"},{"B7B_TABTIS","  "},{"B7B_CAMPO","BR4->BR4_CODPAD                                                                                                                                                                                         "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","(GETNEWPAR('MV_PLNAUT',0) == 0, .F., .T.) .OR. BEJ->BEJ_STATUS <> '0'                                                                                                                                   "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","03"},{"B7B_ORDEM",        35},{"B7B_DESCRI","CODIGO PROCEDIMENTO "},{"B7B_DADPAD","                    "},{"B7B_ALIAS","BR8"},{"B7B_TABTIS","  "},{"B7B_CAMPO","BR8->(BR8_CODPAD+BR8_CODPSA)                                                                                                                                                                            "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","(GETNEWPAR('MV_PLNAUT',0) == 0, .F., .T.) .OR. BEJ->BEJ_STATUS <> '0'                                                                                                                                   "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","03"},{"B7B_ORDEM",        36},{"B7B_DESCRI","DESC PROCEDIMENTO   "},{"B7B_DADPAD","                    "},{"B7B_ALIAS","BR8"},{"B7B_TABTIS","  "},{"B7B_CAMPO","BR8->BR8_DESCRI                                                                                                                                                                                         "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","(GETNEWPAR('MV_PLNAUT',0) == 0, .F., .T.) .OR. BEJ->BEJ_STATUS <> '0'                                                                                                                                   "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","03"},{"B7B_ORDEM",        11},{"B7B_DESCRI","CARTAO NACIONAL SAUD"},{"B7B_DADPAD","                    "},{"B7B_ALIAS","BTS"},{"B7B_TABTIS","  "},{"B7B_CAMPO","BTS->BTS_NRCRNA                                                                                                                                                                                         "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","05"},{"B7B_ORDEM",         7},{"B7B_DESCRI","NUMERO GUIA OPERADOR"},{"B7B_DADPAD","' '                 "},{"B7B_ALIAS","   "},{"B7B_TABTIS","  "},{"B7B_CAMPO","                                                                                                                                                                                                        "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","05"},{"B7B_ORDEM",        62},{"B7B_DESCRI","DATA ASS CONTRATO   "},{"B7B_DADPAD","stod('')            "},{"B7B_ALIAS","   "},{"B7B_TABTIS","  "},{"B7B_CAMPO","                                                                                                                                                                                                        "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","05"},{"B7B_ORDEM",        63},{"B7B_DESCRI","ASS CONTRATO        "},{"B7B_DADPAD","' '                 "},{"B7B_ALIAS","   "},{"B7B_TABTIS","  "},{"B7B_CAMPO","                                                                                                                                                                                                        "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","05"},{"B7B_ORDEM",        64},{"B7B_DESCRI","ASS AUDIT OPERADORA "},{"B7B_DADPAD","' '                 "},{"B7B_ALIAS","   "},{"B7B_TABTIS","  "},{"B7B_CAMPO","                                                                                                                                                                                                        "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","05"},{"B7B_ORDEM",         1},{"B7B_DESCRI","REGISTRO ANS        "},{"B7B_DADPAD","                    "},{"B7B_ALIAS","BA0"},{"B7B_TABTIS","  "},{"B7B_CAMPO","BA0->BA0_SUSEP                                                                                                                                                                                          "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","05"},{"B7B_ORDEM",         8},{"B7B_DESCRI","NUMERO CARTEIRINHA  "},{"B7B_DADPAD","                    "},{"B7B_ALIAS","BA1"},{"B7B_TABTIS","  "},{"B7B_CAMPO","PSRETCART()                                                                                                                                                                                             "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","05"},{"B7B_ORDEM",         9},{"B7B_DESCRI","VALID CARTEIRINHA   "},{"B7B_DADPAD","                    "},{"B7B_ALIAS","BA1"},{"B7B_TABTIS","  "},{"B7B_CAMPO","BA1->BA1_DTVLCR                                                                                                                                                                                         "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","05"},{"B7B_ORDEM",        10},{"B7B_DESCRI","NOME BENEFICIARIO   "},{"B7B_DADPAD","                    "},{"B7B_ALIAS","BA1"},{"B7B_TABTIS","  "},{"B7B_CAMPO","BA1->BA1_NOMUSR                                                                                                                                                                                         "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","05"},{"B7B_ORDEM",        53},{"B7B_DESCRI","CODIGO CBO          "},{"B7B_DADPAD","                    "},{"B7B_ALIAS","BAQ"},{"B7B_TABTIS","  "},{"B7B_CAMPO","BAQ->BAQ_CBOS                                                                                                                                                                                           "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","05"},{"B7B_ORDEM",        13},{"B7B_DESCRI","CODIGO CONTRATADO   "},{"B7B_DADPAD","                    "},{"B7B_ALIAS","BAU"},{"B7B_TABTIS","  "},{"B7B_CAMPO","IIF(LEN(ALLTRIM(BAU->BAU_CPFCGC)) == 11, TRANSFORM(BAU->BAU_CPFCGC, '@R 999.999.999-99'), TRANSFORM(BAU->BAU_CPFCGC, '@R 99.999.999/9999-99'))                                                          "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","05"},{"B7B_ORDEM",        14},{"B7B_DESCRI","NOME CONTRATADO     "},{"B7B_DADPAD","                    "},{"B7B_ALIAS","BAU"},{"B7B_TABTIS","  "},{"B7B_CAMPO","BAU->BAU_NOME                                                                                                                                                                                           "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","05"},{"B7B_ORDEM",        15},{"B7B_DESCRI","CODIGO CNES         "},{"B7B_DADPAD","                    "},{"B7B_ALIAS","BB8"},{"B7B_TABTIS","  "},{"B7B_CAMPO","TRANSFORM(BB8->BB8_CNES, PESQPICT('BB8','BB8_CNES'))                                                                                                                                                    "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","05"},{"B7B_ORDEM",        40},{"B7B_DESCRI","QTD AUTORIZADA      "},{"B7B_DADPAD","                    "},{"B7B_ALIAS","BD6"},{"B7B_TABTIS","  "},{"B7B_CAMPO","BD6->BD6_QTDPRO                                                                                                                                                                                         "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","05"},{"B7B_ORDEM",        34},{"B7B_DESCRI","DATA ATENDIMENTO    "},{"B7B_DADPAD","                    "},{"B7B_ALIAS","BD6"},{"B7B_TABTIS","  "},{"B7B_CAMPO","BD6->BD6_DATPRO                                                                                                                                                                                         "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","05"},{"B7B_ORDEM",        35},{"B7B_DESCRI","HORA INICIAL PROCED "},{"B7B_DADPAD","                    "},{"B7B_ALIAS","BD6"},{"B7B_TABTIS","  "},{"B7B_CAMPO","BD6->BD6_HORPRO                                                                                                                                                                                         "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","05"},{"B7B_ORDEM",        36},{"B7B_DESCRI","HORA FINAL PROCED   "},{"B7B_DADPAD","                    "},{"B7B_ALIAS","BD6"},{"B7B_TABTIS","  "},{"B7B_CAMPO","BD6->BD6_HORFIM                                                                                                                                                                                         "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","05"},{"B7B_ORDEM",        42},{"B7B_DESCRI","TECNICA UTILIZADA   "},{"B7B_DADPAD","                    "},{"B7B_ALIAS","BD6"},{"B7B_TABTIS","  "},{"B7B_CAMPO","BD6->BD6_TECUTI                                                                                                                                                                                         "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","05"},{"B7B_ORDEM",        43},{"B7B_DESCRI","FATOR REDUC / ACRESC"},{"B7B_DADPAD","                    "},{"B7B_ALIAS","BD6"},{"B7B_TABTIS","  "},{"B7B_CAMPO","BD6->BD6_PERC1                                                                                                                                                                                          "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","05"},{"B7B_ORDEM",        44},{"B7B_DESCRI","VALOR UNITARIO PROC "},{"B7B_DADPAD","                    "},{"B7B_ALIAS","BD6"},{"B7B_TABTIS","  "},{"B7B_CAMPO","ROUND(BD6->BD6_VLRPAG / BD6->BD6_QTDPRO, 2)                                                                                                                                                             "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","05"},{"B7B_ORDEM",        45},{"B7B_DESCRI","VALOR TOTAL PROC    "},{"B7B_DADPAD","                    "},{"B7B_ALIAS","BD6"},{"B7B_TABTIS","  "},{"B7B_CAMPO","ROUND(BD6->BD6_VLRPAG, 2)                                                                                                                                                                               "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","05"},{"B7B_ORDEM",        55},{"B7B_DESCRI","TOTAL DIARIAS       "},{"B7B_DADPAD","                    "},{"B7B_ALIAS","BD6"},{"B7B_TABTIS","  "},{"B7B_CAMPO","BD6->BD6_VLRPAG                                                                                                                                                                                         "},{"B7B_TOTALI",.T.},{"B7B_CONDIC","BR8->BR8_TPPROC == '4'                                                                                                                                                                                  "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","05"},{"B7B_ORDEM",        54},{"B7B_DESCRI","TOTAL PROCEDIMENTOS "},{"B7B_DADPAD","                    "},{"B7B_ALIAS","BD6"},{"B7B_TABTIS","  "},{"B7B_CAMPO","BD6->BD6_VLRPAG                                                                                                                                                                                         "},{"B7B_TOTALI",.T.},{"B7B_CONDIC","BR8->BR8_TPPROC == '0'                                                                                                                                                                                  "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","05"},{"B7B_ORDEM",        56},{"B7B_DESCRI","TOTAL TAXAS         "},{"B7B_DADPAD","                    "},{"B7B_ALIAS","BD6"},{"B7B_TABTIS","  "},{"B7B_CAMPO","BD6->BD6_VLRPAG                                                                                                                                                                                         "},{"B7B_TOTALI",.T.},{"B7B_CONDIC","BR8->BR8_TPPROC == '3'                                                                                                                                                                                  "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","05"},{"B7B_ORDEM",        57},{"B7B_DESCRI","TOTAL DE MATERIAIS  "},{"B7B_DADPAD","                    "},{"B7B_ALIAS","BD6"},{"B7B_TABTIS","  "},{"B7B_CAMPO","BD6->BD6_VLRPAG                                                                                                                                                                                         "},{"B7B_TOTALI",.T.},{"B7B_CONDIC","BR8->BR8_TPPROC == '1'                                                                                                                                                                                  "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","05"},{"B7B_ORDEM",        58},{"B7B_DESCRI","TOTAL DE OPME       "},{"B7B_DADPAD","                    "},{"B7B_ALIAS","BD6"},{"B7B_TABTIS","  "},{"B7B_CAMPO","BD6->BD6_VLRPAG                                                                                                                                                                                         "},{"B7B_TOTALI",.T.},{"B7B_CONDIC","BR8->BR8_TPPROC == '5'                                                                                                                                                                                  "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","05"},{"B7B_ORDEM",        59},{"B7B_DESCRI","TOTAL DE MEDICAMENTO"},{"B7B_DADPAD","                    "},{"B7B_ALIAS","BD6"},{"B7B_TABTIS","  "},{"B7B_CAMPO","BD6->BD6_VLRPAG                                                                                                                                                                                         "},{"B7B_TOTALI",.T.},{"B7B_CONDIC","BR8->BR8_TPPROC == '2'                                                                                                                                                                                  "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","05"},{"B7B_ORDEM",        60},{"B7B_DESCRI","TOTAL GASES MEDIC   "},{"B7B_DADPAD","                    "},{"B7B_ALIAS","BD6"},{"B7B_TABTIS","  "},{"B7B_CAMPO","BD6->BD6_VLRPAG                                                                                                                                                                                         "},{"B7B_TOTALI",.T.},{"B7B_CONDIC","BR8->BR8_TPPROC == '7'                                                                                                                                                                                  "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","05"},{"B7B_ORDEM",        61},{"B7B_DESCRI","TOTAL GERAL         "},{"B7B_DADPAD","                    "},{"B7B_ALIAS","BD6"},{"B7B_TABTIS","  "},{"B7B_CAMPO","BD6->BD6_VLRPAG                                                                                                                                                                                         "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","05"},{"B7B_ORDEM",        48},{"B7B_DESCRI","CODIGO EXECUTANTE   "},{"B7B_DADPAD","                    "},{"B7B_ALIAS","BD7"},{"B7B_TABTIS","  "},{"B7B_CAMPO","BD7->BD7_CODRDA                                                                                                                                                                                         "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","05"},{"B7B_ORDEM",        46},{"B7B_DESCRI","SEQ. REF.           "},{"B7B_DADPAD","                    "},{"B7B_ALIAS","BD7"},{"B7B_TABTIS","  "},{"B7B_CAMPO","STRZERO(VAL(BD7->BD7_SEQUEN), 2, 0)                                                                                                                                                                     "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","05"},{"B7B_ORDEM",        49},{"B7B_DESCRI","NOME EXECUTANTE     "},{"B7B_DADPAD","                    "},{"B7B_ALIAS","BD7"},{"B7B_TABTIS","  "},{"B7B_CAMPO","POSICIONE('BAU',1,XFILIAL('BAU')+BD7->BD7_CODRDA,'BAU_NOME')                                                                                                                                            "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","05"},{"B7B_ORDEM",        50},{"B7B_DESCRI","CR EXECUTANTE       "},{"B7B_DADPAD","                    "},{"B7B_ALIAS","BD7"},{"B7B_TABTIS","  "},{"B7B_CAMPO","POSICIONE('BAU',1,XFILIAL('BAU')+BD7->BD7_CODRDA,'BAU_SIGLCR')                                                                                                                                          "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","05"},{"B7B_ORDEM",        51},{"B7B_DESCRI","NUM CR EXECUTANTE   "},{"B7B_DADPAD","                    "},{"B7B_ALIAS","BD7"},{"B7B_TABTIS","  "},{"B7B_CAMPO","POSICIONE('BAU',1,XFILIAL('BAU')+BD7->BD7_CODRDA,'BAU_CONREG')                                                                                                                                          "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","05"},{"B7B_ORDEM",        52},{"B7B_DESCRI","UF CR EXECUTANTE    "},{"B7B_DADPAD","                    "},{"B7B_ALIAS","BD7"},{"B7B_TABTIS","  "},{"B7B_CAMPO","POSICIONE('BAU',1,XFILIAL('BAU')+BD7->BD7_CODRDA,'BAU_ESTCR')                                                                                                                                           "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","05"},{"B7B_ORDEM",        16},{"B7B_DESCRI","CARATER INTERNACAO  "},{"B7B_DADPAD","                    "},{"B7B_ALIAS","BDR"},{"B7B_TABTIS","  "},{"B7B_CAMPO","BDR->BDR_CARINT                                                                                                                                                                                         "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","05"},{"B7B_ORDEM",         2},{"B7B_DESCRI","NUMERO GUIA PRESTADO"},{"B7B_DADPAD","                    "},{"B7B_ALIAS","BE4"},{"B7B_TABTIS","  "},{"B7B_CAMPO","BE4->(BE4_CODOPE+'.'+BE4_ANOINT+'.'+BE4_MESINT+'-'+BE4_NUMINT)                                                                                                                                          "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","05"},{"B7B_ORDEM",         3},{"B7B_DESCRI","NUMERO GUIA SOLICITA"},{"B7B_DADPAD","                    "},{"B7B_ALIAS","BE4"},{"B7B_TABTIS","  "},{"B7B_CAMPO","BE4->(BE4_CODOPE+'.'+BE4_CODLDP+'.'+BE4_CODPEG+'-'+BE4_NUMERO)                                                                                                                                          "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","05"},{"B7B_ORDEM",         4},{"B7B_DESCRI","DATA AUTORIZACAO    "},{"B7B_DADPAD","                    "},{"B7B_ALIAS","BE4"},{"B7B_TABTIS","  "},{"B7B_CAMPO","BE4->BE4_DATPRO                                                                                                                                                                                         "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","05"},{"B7B_ORDEM",         5},{"B7B_DESCRI","SENHA               "},{"B7B_DADPAD","                    "},{"B7B_ALIAS","BE4"},{"B7B_TABTIS","  "},{"B7B_CAMPO","BE4->BE4_SENHA                                                                                                                                                                                          "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","05"},{"B7B_ORDEM",         6},{"B7B_DESCRI","DATA VALID SENHA    "},{"B7B_DADPAD","                    "},{"B7B_ALIAS","BE4"},{"B7B_TABTIS","  "},{"B7B_CAMPO","BE4->BE4_DATVAL                                                                                                                                                                                         "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","05"},{"B7B_ORDEM",        12},{"B7B_DESCRI","ATEND RECEM NASCIDO "},{"B7B_DADPAD","                    "},{"B7B_ALIAS","BE4"},{"B7B_TABTIS","  "},{"B7B_CAMPO","IIF(BE4->BE4_ATERNA=='1','S','N')                                                                                                                                                                       "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","05"},{"B7B_ORDEM",        22},{"B7B_DESCRI","TIPO INTERNACAO     "},{"B7B_DADPAD","                    "},{"B7B_ALIAS","BE4"},{"B7B_TABTIS","  "},{"B7B_CAMPO","PSRETINT(BE4->BE4_GRPINT, BE4->BE4_TIPINT )                                                                                                                                                             "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","05"},{"B7B_ORDEM",        23},{"B7B_DESCRI","REGIME INTERNACAO   "},{"B7B_DADPAD","                    "},{"B7B_ALIAS","BE4"},{"B7B_TABTIS","  "},{"B7B_CAMPO","BE4->BE4_REGINT                                                                                                                                                                                         "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","05"},{"B7B_ORDEM",        24},{"B7B_DESCRI","CID 10 PRINCIPAL    "},{"B7B_DADPAD","                    "},{"B7B_ALIAS","BE4"},{"B7B_TABTIS","  "},{"B7B_CAMPO","BE4->BE4_CID                                                                                                                                                                                            "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","GETMV( 'MV_PLSICID' ,, .T. )                                                                                                                                                                            "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","05"},{"B7B_ORDEM",        25},{"B7B_DESCRI","CID 2               "},{"B7B_DADPAD","                    "},{"B7B_ALIAS","BE4"},{"B7B_TABTIS","  "},{"B7B_CAMPO","BE4->BE4_CIDSEC                                                                                                                                                                                         "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","GETMV( 'MV_PLSICID' ,, .T. )                                                                                                                                                                            "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","05"},{"B7B_ORDEM",        26},{"B7B_DESCRI","CID 3               "},{"B7B_DADPAD","                    "},{"B7B_ALIAS","BE4"},{"B7B_TABTIS","  "},{"B7B_CAMPO","BE4->BE4_CID3                                                                                                                                                                                           "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","GETMV( 'MV_PLSICID' ,, .T. )                                                                                                                                                                            "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","05"},{"B7B_ORDEM",        27},{"B7B_DESCRI","CID 4               "},{"B7B_DADPAD","                    "},{"B7B_ALIAS","BE4"},{"B7B_TABTIS","  "},{"B7B_CAMPO","BE4->BE4_CID4                                                                                                                                                                                           "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","GETMV( 'MV_PLSICID' ,, .T. )                                                                                                                                                                            "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","05"},{"B7B_ORDEM",        28},{"B7B_DESCRI","INDICACAO ACIDENTE  "},{"B7B_DADPAD","                    "},{"B7B_ALIAS","BE4"},{"B7B_TABTIS","  "},{"B7B_CAMPO","BE4->BE4_INDACI                                                                                                                                                                                         "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","05"},{"B7B_ORDEM",        65},{"B7B_DESCRI","OBS / JUSTIFICATIVA "},{"B7B_DADPAD","                    "},{"B7B_ALIAS","BE4"},{"B7B_TABTIS","  "},{"B7B_CAMPO","ALLTRIM(BE4->BE4_MSG01) + ' ' + ALLTRIM(BE4->BE4_MSG02)                                                                                                                                                 "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","05"},{"B7B_ORDEM",        17},{"B7B_DESCRI","TIPO DE FATURAMENTO "},{"B7B_DADPAD","                    "},{"B7B_ALIAS","BE4"},{"B7B_TABTIS","  "},{"B7B_CAMPO","BE4->BE4_TIPFAT                                                                                                                                                                                         "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","05"},{"B7B_ORDEM",        18},{"B7B_DESCRI","DATA INICIO FATURAME"},{"B7B_DADPAD","                    "},{"B7B_ALIAS","BE4"},{"B7B_TABTIS","  "},{"B7B_CAMPO","BE4->BE4_DTINIF                                                                                                                                                                                         "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","05"},{"B7B_ORDEM",        19},{"B7B_DESCRI","HORA INICIO FATURAME"},{"B7B_DADPAD","                    "},{"B7B_ALIAS","BE4"},{"B7B_TABTIS","  "},{"B7B_CAMPO","BE4->BE4_HRINIF                                                                                                                                                                                         "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","05"},{"B7B_ORDEM",        20},{"B7B_DESCRI","DATA FIM FATURAMENTO"},{"B7B_DADPAD","                    "},{"B7B_ALIAS","BE4"},{"B7B_TABTIS","  "},{"B7B_CAMPO","BE4->BE4_DTFIMF                                                                                                                                                                                         "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","05"},{"B7B_ORDEM",        21},{"B7B_DESCRI","HORA FIM FATURAMENTO"},{"B7B_DADPAD","                    "},{"B7B_ALIAS","BE4"},{"B7B_TABTIS","  "},{"B7B_CAMPO","BE4->BE4_HRFIMF                                                                                                                                                                                         "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","05"},{"B7B_ORDEM",        30},{"B7B_DESCRI","NUM DECLA NASC VIVO "},{"B7B_DADPAD","                    "},{"B7B_ALIAS","BE4"},{"B7B_TABTIS","  "},{"B7B_CAMPO","BE4->BE4_NRDCNV                                                                                                                                                                                         "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","05"},{"B7B_ORDEM",        31},{"B7B_DESCRI","CID 10 OBITO        "},{"B7B_DADPAD","                    "},{"B7B_ALIAS","BE4"},{"B7B_TABTIS","  "},{"B7B_CAMPO","BE4->BE4_CIDOBT                                                                                                                                                                                         "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","05"},{"B7B_ORDEM",        32},{"B7B_DESCRI","NUMERO DECLA OBITO  "},{"B7B_DADPAD","                    "},{"B7B_ALIAS","BE4"},{"B7B_TABTIS","  "},{"B7B_CAMPO","BE4->BE4_NRDCOB                                                                                                                                                                                         "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","05"},{"B7B_ORDEM",        33},{"B7B_DESCRI","INDICADOR DO DE RN  "},{"B7B_DADPAD","                    "},{"B7B_ALIAS","BE4"},{"B7B_TABTIS","  "},{"B7B_CAMPO","IIF(BE4->BE4_OBTPRE > 0 .OR. BE4->BE4_OBTTAR > 0,'S','N')                                                                                                                                               "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","05"},{"B7B_ORDEM",        41},{"B7B_DESCRI","VIA ACESSO          "},{"B7B_DADPAD","                    "},{"B7B_ALIAS","BGR"},{"B7B_TABTIS","  "},{"B7B_CAMPO","BGR->BGR_VIATIS                                                                                                                                                                                         "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","05"},{"B7B_ORDEM",        29},{"B7B_DESCRI","MOTIVO ENCERRAMENTO "},{"B7B_DADPAD","                    "},{"B7B_ALIAS","BIY"},{"B7B_TABTIS","  "},{"B7B_CAMPO","BIY->BIY_MOTSAI                                                                                                                                                                                         "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","05"},{"B7B_ORDEM",        37},{"B7B_DESCRI","TABELA              "},{"B7B_DADPAD","                    "},{"B7B_ALIAS","BR4"},{"B7B_TABTIS","  "},{"B7B_CAMPO","BR4->BR4_CODPAD                                                                                                                                                                                         "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","(GETNEWPAR('MV_PLNAUT',0) == 0, .F., .T.) .OR. BEJ->BEJ_STATUS <> '0'                                                                                                                                   "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","05"},{"B7B_ORDEM",        38},{"B7B_DESCRI","CODIGO PROCEDIMENTO "},{"B7B_DADPAD","                    "},{"B7B_ALIAS","BR8"},{"B7B_TABTIS","  "},{"B7B_CAMPO","BR8->(BR8_CODPAD+BR8_CODPSA)                                                                                                                                                                            "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","(GETNEWPAR('MV_PLNAUT',0) == 0, .F., .T.) .OR. BEJ->BEJ_STATUS <> '0'                                                                                                                                   "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","05"},{"B7B_ORDEM",        39},{"B7B_DESCRI","DESC PROCEDIMENTO   "},{"B7B_DADPAD","                    "},{"B7B_ALIAS","BR8"},{"B7B_TABTIS","  "},{"B7B_CAMPO","BR8->BR8_DESCRI                                                                                                                                                                                         "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","(GETNEWPAR('MV_PLNAUT',0) == 0, .F., .T.) .OR. BEJ->BEJ_STATUS <> '0'                                                                                                                                   "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","05"},{"B7B_ORDEM",        11},{"B7B_DESCRI","CARTAO NACIONAL SAUD"},{"B7B_DADPAD","                    "},{"B7B_ALIAS","BTS"},{"B7B_TABTIS","  "},{"B7B_CAMPO","BTS->BTS_NRCRNA                                                                                                                                                                                         "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","05"},{"B7B_ORDEM",        47},{"B7B_DESCRI","GRAU PARTICIPACAO   "},{"B7B_DADPAD","                    "},{"B7B_ALIAS","BWT"},{"B7B_TABTIS","  "},{"B7B_CAMPO","BWT->BWT_CODEDI                                                                                                                                                                                         "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","06"},{"B7B_ORDEM",         5},{"B7B_DESCRI","NUM GUIA OPERADORA  "},{"B7B_DADPAD","' '                 "},{"B7B_ALIAS","   "},{"B7B_TABTIS","  "},{"B7B_CAMPO","                                                                                                                                                                                                        "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","06"},{"B7B_ORDEM",        38},{"B7B_DESCRI","ASS EXECUTANTE      "},{"B7B_DADPAD","' '                 "},{"B7B_ALIAS","   "},{"B7B_TABTIS","  "},{"B7B_CAMPO","                                                                                                                                                                                                        "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","06"},{"B7B_ORDEM",         1},{"B7B_DESCRI","REGISTRO ANS        "},{"B7B_DADPAD","                    "},{"B7B_ALIAS","B0D"},{"B7B_TABTIS","  "},{"B7B_CAMPO","B0D->B0D_REGANS                                                                                                                                                                                         "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","06"},{"B7B_ORDEM",         2},{"B7B_DESCRI","NUMERO GUIA PRESTADO"},{"B7B_DADPAD","                    "},{"B7B_ALIAS","B0D"},{"B7B_TABTIS","  "},{"B7B_CAMPO","B0D->(B0D_CODOPE+'.'+B0D_ANOAUT+'.'+B0D_MESAUT+'.'+B0D_NUMAUT)                                                                                                                                          "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","06"},{"B7B_ORDEM",         6},{"B7B_DESCRI","NUMERO CARTEIRINHA  "},{"B7B_DADPAD","                    "},{"B7B_ALIAS","B0D"},{"B7B_TABTIS","  "},{"B7B_CAMPO","B0D->B0D_NUMCAR                                                                                                                                                                                         "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","06"},{"B7B_ORDEM",         7},{"B7B_DESCRI","NOME                "},{"B7B_DADPAD","                    "},{"B7B_ALIAS","B0D"},{"B7B_TABTIS","  "},{"B7B_CAMPO","B0D->B0D_NOME                                                                                                                                                                                           "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","06"},{"B7B_ORDEM",        11},{"B7B_DESCRI","CODIGO CNES         "},{"B7B_DADPAD","                    "},{"B7B_ALIAS","B0D"},{"B7B_TABTIS","  "},{"B7B_CAMPO","TRANSFORM(B0D->B0D_CNES, PESQPICT('BB8','BB8_CNES'))                                                                                                                                                    "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","06"},{"B7B_ORDEM",        13},{"B7B_DESCRI","NOME CONTRATADO     "},{"B7B_DADPAD","                    "},{"B7B_ALIAS","B0D"},{"B7B_TABTIS","  "},{"B7B_CAMPO","B0D->B0D_NRDAEX                                                                                                                                                                                         "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","06"},{"B7B_ORDEM",        14},{"B7B_DESCRI","CNES PRESTADOR      "},{"B7B_DADPAD","                    "},{"B7B_ALIAS","B0D"},{"B7B_TABTIS","  "},{"B7B_CAMPO","TRANSFORM(B0D->B0D_CNESEX, PESQPICT('BB8','BB8_CNES'))                                                                                                                                                  "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","06"},{"B7B_ORDEM",        15},{"B7B_DESCRI","NOME EXECUTANTE     "},{"B7B_DADPAD","                    "},{"B7B_ALIAS","B0D"},{"B7B_TABTIS","  "},{"B7B_CAMPO","B0D->B0D_NOMEXE                                                                                                                                                                                         "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","06"},{"B7B_ORDEM",        16},{"B7B_DESCRI","CON REGIONAL        "},{"B7B_DADPAD","                    "},{"B7B_ALIAS","B0D"},{"B7B_TABTIS","  "},{"B7B_CAMPO","B0D->B0D_SICONS                                                                                                                                                                                         "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","06"},{"B7B_ORDEM",        17},{"B7B_DESCRI","NUMERO CR           "},{"B7B_DADPAD","                    "},{"B7B_ALIAS","B0D"},{"B7B_TABTIS","  "},{"B7B_CAMPO","B0D->B0D_NUCONS                                                                                                                                                                                         "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","06"},{"B7B_ORDEM",        18},{"B7B_DESCRI","UF                  "},{"B7B_DADPAD","                    "},{"B7B_ALIAS","B0D"},{"B7B_TABTIS","  "},{"B7B_CAMPO","B0D->B0D_UFCONS                                                                                                                                                                                         "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","06"},{"B7B_ORDEM",        35},{"B7B_DESCRI","OBS/JUSTIFICATIVA   "},{"B7B_DADPAD","                    "},{"B7B_ALIAS","B0D"},{"B7B_TABTIS","  "},{"B7B_CAMPO","B0D->B0D_OBSERV                                                                                                                                                                                         "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","06"},{"B7B_ORDEM",        37},{"B7B_DESCRI","DATA EMISSAO        "},{"B7B_DADPAD","                    "},{"B7B_ALIAS","B0D"},{"B7B_TABTIS","  "},{"B7B_CAMPO","B0D->B0D_DATGUI                                                                                                                                                                                         "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","06"},{"B7B_ORDEM",        23},{"B7B_DESCRI","DATA PROCEDIMENTO   "},{"B7B_DADPAD","                    "},{"B7B_ALIAS","B0E"},{"B7B_TABTIS","  "},{"B7B_CAMPO","B0E->B0E_DATPRO                                                                                                                                                                                         "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","06"},{"B7B_ORDEM",        24},{"B7B_DESCRI","HORA INICIAL        "},{"B7B_DADPAD","                    "},{"B7B_ALIAS","B0E"},{"B7B_TABTIS","  "},{"B7B_CAMPO","B0E->B0E_HORINI                                                                                                                                                                                         "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","06"},{"B7B_ORDEM",        25},{"B7B_DESCRI","HORA FINAL          "},{"B7B_DADPAD","                    "},{"B7B_ALIAS","B0E"},{"B7B_TABTIS","  "},{"B7B_CAMPO","B0E->B0E_HORFIM                                                                                                                                                                                         "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","06"},{"B7B_ORDEM",        29},{"B7B_DESCRI","QTDE                "},{"B7B_DADPAD","                    "},{"B7B_ALIAS","B0E"},{"B7B_TABTIS","  "},{"B7B_CAMPO","B0E->B0E_QTDPRO                                                                                                                                                                                         "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","06"},{"B7B_ORDEM",        30},{"B7B_DESCRI","VIA DE ACESSO       "},{"B7B_DADPAD","                    "},{"B7B_ALIAS","B0E"},{"B7B_TABTIS","  "},{"B7B_CAMPO","B0E->B0E_VIACES                                                                                                                                                                                         "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","06"},{"B7B_ORDEM",        31},{"B7B_DESCRI","TECNICA UTILIZADA   "},{"B7B_DADPAD","                    "},{"B7B_ALIAS","B0E"},{"B7B_TABTIS","  "},{"B7B_CAMPO","B0E->B0E_TECUTI                                                                                                                                                                                         "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","06"},{"B7B_ORDEM",        32},{"B7B_DESCRI","FATOR RED/ACRESC    "},{"B7B_DADPAD","                    "},{"B7B_ALIAS","B0E"},{"B7B_TABTIS","  "},{"B7B_CAMPO","B0E->B0E_REDACR                                                                                                                                                                                         "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","06"},{"B7B_ORDEM",        22},{"B7B_DESCRI","GRAU PART           "},{"B7B_DADPAD","                    "},{"B7B_ALIAS","B0E"},{"B7B_TABTIS","  "},{"B7B_CAMPO","BWT->BWT_CODEDI                                                                                                                                                                                         "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","06"},{"B7B_ORDEM",        33},{"B7B_DESCRI","VALOR UNITARIO      "},{"B7B_DADPAD","                    "},{"B7B_ALIAS","B0E"},{"B7B_TABTIS","  "},{"B7B_CAMPO","ROUND(B0E->B0E_VALOR, 2)                                                                                                                                                                                "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","06"},{"B7B_ORDEM",        34},{"B7B_DESCRI","VALOR TOTAL         "},{"B7B_DADPAD","                    "},{"B7B_ALIAS","B0E"},{"B7B_TABTIS","  "},{"B7B_CAMPO","ROUND(B0E->B0E_VALTOT, 2)                                                                                                                                                                               "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","06"},{"B7B_ORDEM",        36},{"B7B_DESCRI","VALOR TOTAL HONORARI"},{"B7B_DADPAD","                    "},{"B7B_ALIAS","B0E"},{"B7B_TABTIS","  "},{"B7B_CAMPO","ROUND(B0E->B0E_VALTOT, 2)                                                                                                                                                                               "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","06"},{"B7B_ORDEM",        12},{"B7B_DESCRI","CODIGO CONTRATADO   "},{"B7B_DADPAD","                    "},{"B7B_ALIAS","BAU"},{"B7B_TABTIS","  "},{"B7B_CAMPO","PSCGCRDA()                                                                                                                                                                                              "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","06"},{"B7B_ORDEM",         9},{"B7B_DESCRI","CODIGO NA OPERADORA "},{"B7B_DADPAD","                    "},{"B7B_ALIAS","BB8"},{"B7B_TABTIS","  "},{"B7B_CAMPO","BB8->BB8_CODLOC                                                                                                                                                                                         "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","06"},{"B7B_ORDEM",        10},{"B7B_DESCRI","NOME LOCAL ATEND    "},{"B7B_DADPAD","                    "},{"B7B_ALIAS","BB8"},{"B7B_TABTIS","  "},{"B7B_CAMPO","BB8->BB8_DESLOC                                                                                                                                                                                         "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","06"},{"B7B_ORDEM",         3},{"B7B_DESCRI","NUMERO GUIA INTERNAC"},{"B7B_DADPAD","                    "},{"B7B_ALIAS","BE4"},{"B7B_TABTIS","  "},{"B7B_CAMPO","BE4->(BE4_CODOPE+'.'+BE4_ANOINT+'.'+BE4_MESINT+'.'+BE4_NUMINT)                                                                                                                                          "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","06"},{"B7B_ORDEM",         4},{"B7B_DESCRI","SENHA               "},{"B7B_DADPAD","                    "},{"B7B_ALIAS","BE4"},{"B7B_TABTIS","  "},{"B7B_CAMPO","BE4->BE4_SENHA                                                                                                                                                                                          "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","06"},{"B7B_ORDEM",         8},{"B7B_DESCRI","ATENDIMENTO RN      "},{"B7B_DADPAD","                    "},{"B7B_ALIAS","BE4"},{"B7B_TABTIS","  "},{"B7B_CAMPO","IIF(BE4->BE4_ATERNA=='1','S','N')                                                                                                                                                                       "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","06"},{"B7B_ORDEM",        19},{"B7B_DESCRI","CODIGO CBO          "},{"B7B_DADPAD","                    "},{"B7B_ALIAS","BE4"},{"B7B_TABTIS","  "},{"B7B_CAMPO","POSICIONE('BAQ',1,XFILIAL('BAQ')+BE4->(BE4_OPEMOV+BE4_CODESP),'BAQ_CBOS')                                                                                                                               "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","06"},{"B7B_ORDEM",        20},{"B7B_DESCRI","DATA INICIO FATURAME"},{"B7B_DADPAD","                    "},{"B7B_ALIAS","BE4"},{"B7B_TABTIS","  "},{"B7B_CAMPO","BE4->BE4_DTINIF                                                                                                                                                                                         "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","06"},{"B7B_ORDEM",        21},{"B7B_DESCRI","DATA FIM FATURAMENTO"},{"B7B_DADPAD","                    "},{"B7B_ALIAS","BE4"},{"B7B_TABTIS","  "},{"B7B_CAMPO","BE4->BE4_DTFIMF                                                                                                                                                                                         "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","06"},{"B7B_ORDEM",        26},{"B7B_DESCRI","TABELA              "},{"B7B_DADPAD","                    "},{"B7B_ALIAS","BR4"},{"B7B_TABTIS","  "},{"B7B_CAMPO","BR4->BR4_CODPAD                                                                                                                                                                                         "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","06"},{"B7B_ORDEM",        27},{"B7B_DESCRI","COD PROCEDIMENTO    "},{"B7B_DADPAD","                    "},{"B7B_ALIAS","BR8"},{"B7B_TABTIS","  "},{"B7B_CAMPO","BR8->BR8_CODPSA                                                                                                                                                                                         "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Aadd(aB7B,{{"B7B_FILIAL","  "},{"B7B_TIPGUI","06"},{"B7B_ORDEM",        28},{"B7B_DESCRI","DESC PROCEDIMENTO   "},{"B7B_DADPAD","                    "},{"B7B_ALIAS","BR8"},{"B7B_TABTIS","  "},{"B7B_CAMPO","BR8->BR8_DESCRI                                                                                                                                                                                         "},{"B7B_TOTALI",.F.},{"B7B_CONDIC","                                                                                                                                                                                                        "},{"B7B_TISVER","3.00.01"}})
Return
*/
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ?PLSPESTIS2 ?Autor ?Bruno Iserhardt    ?Data ?15.06.13 ³±?
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ?Pesquisa generica de itens das tabelas de dominio TISS    ³±?
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Programador ?Data   ?BOPS ? Motivo da Altera‡„o                    ³±?
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*//*
Function CABPESTIS2(cCodVinc, cCodTab, cTerminolo)
LOCAL lRet       := .T.

cChv445 := PLSPESTISS(cCodVinc, cCodTab, cTerminolo)
lRet := !Empty(cChv445)

Return(lRet)
*/
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ?PFileReady ?Autor ?Rogério Tabosa     ?Data ?31.10.13 ³±?
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ?Realiza as verificaçoes necessarias para geraçao de       ³±?
±±?         ?PDF pelo portal ou demais rotinas via JOB                 ³±?
±±?         ?(Necessário para que nenhum objeto, sintaxe ou instruçao  ³±?
±±?         ?que espera o arquivo pronto para utilização seja pra envio³±?
±±?         ?de e-mail ou impressao no portal etc, para garantir que o ³±?
±±?         ?arquivo estara terminado e criado na pasta.               ³±?
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Programador ?Data   ?       ? Motivo da Altera‡„o                    ³±?
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros?cPath - caminho do arquivo (folder)                       ³±?
±±?         ?cFile - nome do arquivo com extensao                	   ³±?
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*//*
Function PFileReady(cPath, cFile)
Local nHIn := 0
Local nJ := 0
Local lInFolder := .F.
Local lKeepLoop := .T.
Local nTamAtu := 0
Local nTamRet := 0
Local nTentat := 100

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//?Primeiro o tratamento se o arquivo ja existe na pasta                    ?
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
nHIn := -1
nJ   := 1
While nHIn <=0 .and. nJ < 1000
	nHIn := fopen(cPath+cFile,FO_EXCLUSIVE) //somente abre quando puder abrir exclusivo
	If nHIn <> -1
		fClose(nHIn)
		lInFolder := .T. // Sei que o arquivo ja esta na pasta
		EXIT
	Endif
	sleep(100)
	nJ++
enddo
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//?Tratamento para verificar se o arquivo esta pronto e terminou a criaçao  ?
// de acordo com o tamanho															?
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
nJ   := 1
If lInFolder // Agora eu verifico se o arquivo j?esta pronto comparando o tamanho dele apos o Sleep
	While lKeepLoop
		If nJ == nTentat
			lKeepLoop := .F. // sai fora na enezima tentativa
		ElseIf nJ < nTentat .and. (nTamAtu == 0 .and. nTamRet == 0) // Continua verificando o arquivo se o tamaho esta zerado ainda
			Sleep(300) // aguarda montagem do arquivo
			nTamAtu := nTamRet
			nTamRet := PSetTamFile(cPath, cFile)
		ElseIf nTamRet > 0 .and. (nTamAtu <> nTamRet) // Continua verificando o arquivo se o tamanho anterior esta diferente do tamanho recente
			Sleep(300) // aguarda montagem do arquivo
			nTamAtu := nTamRet
			nTamRet := PSetTamFile(cPath, cFile)
		ElseIf nTamAtu > 0 .and. (nTamAtu == nTamRet)
			lKeepLoop := .F. // o arquivo esta pronto
		EndIf
		nJ++
	EndDo
EndIf

Return()
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//?Verifico os tamanhos com a funçao Directory                              ?
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Static Function PSetTamFile(cPath, cFile)
Local aFilesDir 	:= Directory(PLSMUDSIS(cPath+cFile))
Local nRet 		:= 0

If Len(aFilesDir) > 0
	nRet := aFilesDir[1,2]
EndIf
Return(nRet)

//ajuste provisorio do path do objeto - solucao de contorno ate sair o path do frame
Static Function AjusPath(oPrint)
oPrint:cFilePrint := StrTran(oPrint:cFilePrint,"\","/",1)
oPrint:cPathPrint := StrTran(oPrint:cPathPrint,"\","/",1)
oPrint:cFilePrint := StrTran(oPrint:cFilePrint,"//","/",1)
oPrint:cPathPrint := StrTran(oPrint:cPathPrint,"//","/",1)
Return*/
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡ao    ?PLSDACMB  ?Autor ?Bruno Iserhardt       ?Data ?09.12.13 ³±?
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡ao ?Dados Relatório TISS (Guia Demonst. Análise Contas Médicas )³±?
±±?         ?TISS 3                                                      ³±?
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±?Uso      ?SigaPLS                                                     ³±?
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros?cCodRda - Código da RDA a ser processado o Relatório        ³±?
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*//*
Function CABDACMB(cCodOpe, cRdaDe, cRdaAte, cAno, cMes, cClaPre, cLocRda , cNFSSDe, cNFSSAte,cNmTitPg,cPEGDe, cPEGAte)
Local aCpo02,aCpo05,aCpo06,aCpo07,aCpo08,aCpo09,aCpo10, aCpo11, aCpo12, aCpo13, aCpo14, aCpo15
local aCpo16, aCpo17, aCpo18, aCpo19, aCpo20, aCpo21, aCpo22, aCpo23, aCpo24, aCpo25, aCpo26
local aCpo27, aCpo28, aCpo29, aCpo30, aCpo31, aCpo32, aCpo33, aCpo46

Local nInd1, nInd2,nInd3 := 0
Local aDados :={}
Local cSQL
LOCAL lAchouUm := .F.
local nInfGui  := 0
Local nProcGui := 0
LOCAL nLibGui  := 0
LOCAL nGloGui  := 0
LOCAL nInfFat  := 0
LOCAL nProcFat := 0
LOCAL nLibFat  := 0
LOCAL nGloFat  := 0
LOCAL nInfGer  := 0
LOCAL nProcGer := 0
LOCAL nLibGer  := 0
LOCAL nGloGer  := 0
LOCAL lFlag	   := .F.
LOCAL cNmLotPg		:= ""
LOCAL cRdaLote		:= ""
Local cDescri  := ""
Local cCodPro  := ""
Local cCodTab  := ""
Local lBCI_CODGLO := BCI->(FieldPos("BCI_CODGLO")) > 0
Local cChGuia1 := ""
Local lInter   := .F.

DEFAULT cLocRda 	:= ""
DEFAULT cNFSSDe 	:= ""
DEFAULT cNFSSAte 	:= ""
DEFAULT cNmTitPg 	:= ""
DEFAULT cPEGDe		:= " "
DEFAULT cPEGAte		:= Replicate("Z",Len(BD7->BD7_CODPEG))
DEFAULT cAno		:= ""
DEFAULT cMes		:= "" //No caso da solicitação vir de WebService TISS, não temos no xml a informação de data da solicitação de mes e ano


// Peg Final não pode ser em branco.
If Empty(cPEGAte)
	cPEGAte		:= Replicate("Z",Len(BD7->BD7_CODPEG))
Endif

DBSELECTAREA("SE2")
// Variaveis para buscar o BMR pelo numero do titulo.
If !Empty(cNmTitPg)
	SE2->(dbSetorder(01))
	If SE2->(dbSeek(xFilial("SE2")+cNmTitPg))
		cCodOpe  := SE2->E2_PLOPELT
		cNmLotPg := SE2->E2_PLLOTE
		cRdaLote := SE2->E2_CODRDA
		cAno 	 := SE2->E2_ANOBASE
		cMes	 := SE2->E2_MESBASE
	Endif
Endif

cSQL := "SELECT BD7_CODEMP, BD7_CODLDP, BD7_CODOPE, BD7_CODPAD, BD7_CODPEG, BD7_CODPRO, BD7_CODRDA, BD7_CODTPA, BD7_DATPRO, BD7_MATRIC, BD7_NOMRDA, BD7_NOMUSR, BD7_NUMERO, BD7_NUMLOT, BD7_OPELOT, BD7_ORIMOV, BD7_SEQUEN, BD7_TIPREG, BD7_MOTBLO, BD7_VLRMAN, BD7_VLRPAG, BD7_VLRAPR, BD7_VLRGLO, BD7_ANOPAG, BD7_MESPAG, BD7_TIPGUI, R_E_C_N_O_ AS RECNO "
cSQL += "  FROM " + RetSqlName("BD7")
cSQL += " WHERE BD7_FILIAL = '" + xFilial("BD7") + "' AND "
cSQL += " BD7_OPELOT = '"+cCodOpe+"' AND "

cSQL += "( BD7_CODPEG >= '" + cPEGDe    + "' AND BD7_CODPEG <= '" + cPEGAte + "' ) AND "
If !Empty(cNmLotPg)
	cSQL += "BD7_CODRDA = '"+ cRdaLote +"' AND "
	cSQL += "BD7_NUMLOT = '"+ cNmLotPg +"' AND "

Else
	If Len(AllTrim(cAno+cMes)) == 6
		cSQL += "( BD7_CODRDA >= '" + cRdaDe    + "' AND BD7_CODRDA <= '" + cRdaAte    + "' ) AND "
		cSQL += " BD7_NUMLOT LIKE '"+cAno+cMes+"%' AND "
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
		//?Somente pega as guias de um mesma NFSS							  ?
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?

	Else
		If BD7->(FieldPos("BD7_SEQNFS")) > 0
			If !Empty(cNFSSAte)
				cSQL += "( BD7_SEQNFS >= '"+cNFSSDe+"' AND BD7_SEQNFS <= '"+cNFSSAte+"' ) AND "
				cSQL += "( BD7_CODRDA >= '" + cRdaDe    + "' AND BD7_CODRDA <= '" + cRdaAte    + "' ) AND "
				cSQL += "BD7_FASE IN ('3','4') AND "
			EndIf
		Endif
	EndIf
Endif

cSql += RetSQLName("BD7")+".D_E_L_E_T_ = ' '"
cSQL += " ORDER BY BD7_NUMLOT, BD7_CODRDA, BD7_CODLDP, BD7_CODPEG, BD7_NUMERO, BD7_SEQUEN "
PlsQuery(cSQL,"TrbBD7")

// BA0 - Operadoras de Saude
BA0->(dbSetOrder(1))
BA0->(msSeek(xFilial("BA0")+TrbBD7->(BD7_CODOPE)))

Do While ! TrbBD7->(Eof())

	aCpo02 := {}
	aCpo05 := {}
	aCpo06 := {}
	aCpo07 := {}
	aCpo08 := {}
	aCpo09 := {}
	aCpo10 := {}
	aCpo11 := {}
	aCpo12 := {}
	aCpo13 := {}
	aCpo14 := {}
	aCpo15 := {}
	aCpo16 := {}
	aCpo17 := {}
	aCpo18 := {}
	aCpo19 := {}
	aCpo20 := {}
	aCpo21 := {}
	aCpo22 := {}
	aCpo23 := {}
	aCpo24 := {}
	aCpo25 := {}
	aCpo26 := {}
	aCpo27 := {}
	aCpo28 := {}
	aCpo29 := {}
	aCpo30 := {}
	aCpo31 := {}
	aCpo32 := {}
	aCpo33 := {}
	aCpo34 := {}
	aCpo35 := {}
	aCpo46 := {}

	aAdd(aDados, BA0->BA0_SUSEP) // 1-Registro ANS

	Do While ! TrbBD7->(Eof())

		lInter := .F.

		// BAU - Redes de Atendimento
		BAU->(dbSetOrder(1))
		BAU->(msSeek(xFilial("BAU")+TrbBD7->BD7_CODRDA))

		// BAF - Lotes de Pagamentos RDA
		BAF->(dbSetOrder(1))
		BAF->(msSeek(xFilial("BAF")+TrbBD7->(BD7_OPELOT+BD7_NUMLOT)))

		BCL->( DbSetOrder(1) )
		BCL->(MsSeek(xFilial("BCL")+TrbBD7->(BD7_CODOPE+BD7_TIPGUI)))
		_cAlias:= Alltrim(BCL->BCL_ALIAS)

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//?Posiciona Contas Medicas                                     ?
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If _cAlias == "BE4"
			BE4->(DbSetOrder(1)) //BE4_FILIAL+BE4_CODOPE+BE4_CODLDP+BE4_CODPEG+BE4_NUMERO+BE4_SITUAC+BE4_FASE
			BE4->(MsSeek(xFilial('BE4')+TrbBD7->(BD7_CODOPE+BD7_CODLDP+BD7_CODPEG+BD7_NUMERO)))
			cCodLoc := BE4->BE4_CODLOC
			lInter := .T.
		Else
		BD5->(dbSetOrder(1)) //BD5_FILIAL, BD5_CODOPE, BD5_CODLDP, BD5_CODPEG, BD5_NUMERO, BD5_SITUAC, BD5_FASE, BD5_DATPRO, BD5_OPERDA, BD5_CODRDA, R_E_C_N_O_, D_E_L_E_T_
		BD5->(MsSeek(xFilial("BD5")+TrbBD7->(BD7_CODOPE+BD7_CODLDP+BD7_CODPEG+BD7_NUMERO)))
			cCodLoc := BD5->BD5_CODLOC
		Endif

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//?Na Web o relatorio e por local de atendimento				 ?
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If Len(AllTrim(cAno+cMes)) == 6
			//If !Empty(cLocRda) .And. !BD5->BD5_LOCAL == cLocRda //
			If !Empty(cLocRda) .And. !cCodLoc == cLocRda
				TrbBD7->( dbSkip() )
				Loop
			Endif
		EndIf

		lAchouUm := .T.
		nInfGer  :=0
		nProcGer :=0
		nLibGer  :=0
		nGloGer  :=0

		If Empty(cNmTitPg) .and. Empty(cNmLotPg)
			cSQL := " SELECT R_E_C_N_O_  AS E2_RECNO "
			cSQL += "  FROM " + RetSQLName("SE2")
			cSQL += "  WHERE E2_FILIAL = '" + xFilial("SE2") + "' "
			cSQL += "    AND E2_PLOPELT = '" + TrbBD7->BD7_OPELOT + "'"
			cSQL += "    AND E2_PLLOTE = '" + TrbBD7->BD7_NUMLOT + "'"
			cSQL += "    AND E2_CODRDA = '" + TrbBD7->BD7_CODRDA + "'"
			cSQL += "    AND D_E_L_E_T_ = ' ' "

			PlsQuery(cSQL,"TrbSE2")

			If ! TrbSE2->(Eof())
				SE2->(dbGoTo(TrbSE2->(E2_RECNO)))
			EndIf

			TrbSE2->(DbCloseArea())
		Endif

		aAdd(aCpo02, BAF->(BAF_ANOLOT+BAF_MESLOT+BAF_NUMLOT)) // 2-Numero do Demonstrativo

		aAdd(aCpo05, BAF->BAF_DTDIGI) // 5-Data de Emissao
		aAdd(aCpo06, IIf(BAU->BAU_TIPPE == "F", Transform(BAU->BAU_CPFCGC, "@R 999.999.999-99"), Transform(BAU->BAU_CPFCGC, "@R 99.999.999/9999-99"))) // 6-Codigo da Operadora
		aAdd(aCpo07, BAU->BAU_NOME) // 7-Nome do Contratado

		BB8->(dbSetOrder(1))
		BB8->(dbSeek(xFilial("BB8")+TrbBD7->(BD7_CODRDA+BD7_CODOPE)+cCodLoc))
		//CNES Obrigatório. Caso o prestador ainda não possua o código do CNES preencher o campo com 9999999.
		aAdd(aCpo08, IIF(!EMPTY(BB8->BB8_CNES), Transform(BB8->BB8_CNES, cPicCNES), "9999999")) // 8-Codigo CNES

		aAdd(aCpo09,{})
		aAdd(aCpo10,{})
		aAdd(aCpo11,{})
		aAdd(aCpo12,{})
		aAdd(aCpo13,{})
		aAdd(aCpo14,{})
		aAdd(aCpo15,{})
		aAdd(aCpo16,{})
		aAdd(aCpo17,{})
		aAdd(aCpo18,{})
		aAdd(aCpo19,{})
		aAdd(aCpo20,{})
		aAdd(aCpo21,{})
		aAdd(aCpo22,{})
		aAdd(aCpo23,{})
		aAdd(aCpo24,{})
		aAdd(aCpo25,{})
		aAdd(aCpo26,{})
		aAdd(aCpo27,{})
		aAdd(aCpo28,{})
		aAdd(aCpo29,{})
		aAdd(aCpo30,{})
		aAdd(aCpo31,{})
		aAdd(aCpo32,{})
		aAdd(aCpo33,{})
		aAdd(aCpo34,{})
		aAdd(aCpo35,{})
		nInd1 := Len(aCpo02)

		cChRDA := TrbBD7->(BD7_NUMLOT+BD7_CODRDA)
		Do While ! TrbBD7->(Eof()) .And. TrbBD7->(BD7_NUMLOT+BD7_CODRDA) ==  cChRDA

			// BCI - PEGS ??????????
			BCI->(dbSetOrder(5))
			BCI->(msSeek(xFilial("BCI")+TrbBD7->(BD7_CODOPE+BD7_CODRDA+BD7_CODOPE+BD7_CODLDP+BD7_CODPEG)))

			aAdd(aCpo09[nInd1], TrbBD7->(BD7_CODLDP+BD7_CODPEG)) // 09-Numero do Lote
			aAdd(aCpo10[nInd1], BCI->BCI_CODPEG) // 10-Numero do Protocolo
			aAdd(aCpo11[nInd1], BCI->BCI_DATREC) // 11-Data do Protocolo
			aAdd(aCpo12[nInd1], PLSIMPVINC('BCT', '38', Iif(lBCI_CODGLO,BCI->BCI_CODGLO,""))) // 12-Codigo da Glosa do Protocolo
			aAdd(aCpo13[nInd1], PLSIMPVINC('BCT', '47', BCI->BCI_FASE)) // 13 - Código da Situação do Protocolo

			nInfGer +=TrbBD7->BD7_VLRAPR
			nProcGer+=TrbBD7->BD7_VLRPAG
			nLibGer +=TrbBD7->BD7_VLRPAG
			nGloGer +=TrbBD7->BD7_VLRGLO

			aAdd(aCpo14[nInd1], {})
			aAdd(aCpo15[nInd1], {})
			aAdd(aCpo16[nInd1], {})
			aAdd(aCpo17[nInd1], {})
			aAdd(aCpo18[nInd1], {})
			aAdd(aCpo19[nInd1], {})
			aAdd(aCpo20[nInd1], {})
			aAdd(aCpo21[nInd1], {})
			aAdd(aCpo22[nInd1], {})
			aAdd(aCpo23[nInd1], {})
			aAdd(aCpo24[nInd1], {})
			aAdd(aCpo25[nInd1], {})
			aAdd(aCpo26[nInd1], {})
			aAdd(aCpo27[nInd1], {})
			aAdd(aCpo28[nInd1], {})
			aAdd(aCpo29[nInd1], {})
			aAdd(aCpo30[nInd1], {})
			aAdd(aCpo31[nInd1], {})
			aAdd(aCpo32[nInd1], {})
			aAdd(aCpo33[nInd1], {})
			aAdd(aCpo34[nInd1], {})
			aAdd(aCpo35[nInd1], {})

			nInd2 := Len(aCpo09[nInd1])

			nInfFat :=0
			nProcFat:=0
			nLibFat :=0
			nGloFat :=0
			cChFat := TrbBD7->(BD7_NUMLOT+BD7_CODRDA+BD7_CODLDP+BD7_CODPEG)
			Do While ! TrbBD7->(Eof()) .And. TrbBD7->(BD7_NUMLOT+BD7_CODRDA+BD7_CODLDP+BD7_CODPEG) ==  cChFat

				BA1->(dbSetOrder(2))
				BA1->(msSeek(xFilial("BA1")+TrbBD7->(BD7_CODOPE+BD7_CODEMP+BD7_MATRIC+BD7_TIPREG)))

				aAdd(aCpo14[nInd1, nInd2], TrbBD7->BD7_NUMERO) // 14-Numero da Guia no Prestador
				aAdd(aCpo15[nInd1, nInd2], TrbBD7->BD7_NUMERO) // 15-Numero da Guia Atribuido pela Operadora
				aAdd(aCpo16[nInd1, nInd2], TrbBD7->BD7_NUMERO) // 16-Senha
				aAdd(aCpo17[nInd1, nInd2], TrbBD7->BD7_NOMUSR) // 17-Nome do Beneficiario
				If BA1->BA1_CODINT == BA1->BA1_OPEORI .Or. empty(BA1->BA1_MATANT)
					aAdd(aCpo18[nInd1, nInd2], BA1->(BA1_CODINT+"."+BA1_CODEMP+"."+BA1_MATRIC+"."+BA1_TIPREG+"-"+BA1_DIGITO)	) // 18-Numero da Carteira
				Else
					aAdd(aCpo18[nInd1, nInd2], BA1->BA1_MATANT) // 18-Numero da Carteira
				EndIf

				aAdd(aCpo19[nInd1, nInd2], IIF(lInter,BE4->(BE4_DTINIF),CTOD(""))) // 19-Data do Inicio do Faturamento
				aAdd(aCpo20[nInd1, nInd2], IIF(lInter,BE4->(BE4_HRINIF),"")) // 20-Hora do Inicio do Faturamento
				aAdd(aCpo21[nInd1, nInd2], IIF(lInter,BE4->(BE4_DTFIMF),CTOD(""))) // 21-Data do Fim do Faturamento
				aAdd(aCpo22[nInd1, nInd2], IIF(lInter,BE4->(BE4_HRFIMF),"")) // 22-Hora do Fim do Faturamento
				aAdd(aCpo23[nInd1, nInd2], PLSIMPVINC('BCT', '38', IIF(lInter,BE4->(BE4_CODGLO),BD5->(BD5_CODGLO)))) // 23-Codigo da Glosa da Guia

				nInfFat +=TrbBD7->BD7_VLRAPR
				nProcFat+=TrbBD7->BD7_VLRPAG
				nLibFat +=TrbBD7->BD7_VLRPAG
				nGloFat +=TrbBD7->BD7_VLRGLO

				aAdd(aCpo24[nInd1, nInd2], PLSIMPVINC('BCT', '47', IIF(lInter,BE4->(BE4_FASE),BD5->(BD5_FASE))))
				aAdd(aCpo25[nInd1, nInd2], {})
				aAdd(aCpo26[nInd1, nInd2], {})
				aAdd(aCpo27[nInd1, nInd2], {})
				aAdd(aCpo28[nInd1, nInd2], {})
				aAdd(aCpo29[nInd1, nInd2], {})
				aAdd(aCpo30[nInd1, nInd2], {})
				aAdd(aCpo31[nInd1, nInd2], {})
				aAdd(aCpo32[nInd1, nInd2], {})
				aAdd(aCpo33[nInd1, nInd2], {})
				aAdd(aCpo34[nInd1, nInd2], {})
				aAdd(aCpo35[nInd1, nInd2], {})
				cChGuia := TrbBD7->(BD7_NUMLOT+BD7_CODRDA+BD7_CODLDP+BD7_CODPEG+BD7_NUMERO)*/
				/*if SUBSTR(cChGuia1,21,8) <> SUBSTR(cChGuia,21,8)
					nInd3 := 1 //:= Len(aCpo13[nInd1, nInd2])
				else
					nInd3++
				Endif
				*/
/*				nInd3 	:= Len(aCpo14[nInd1, nInd2])
				nInfGui:=0
				nProcGui:=0
				nLibGui :=0
				nGloGui :=0
				dCmp25 := ""
				cCmp26 := ""
				cCmp27 := ""
				cCmp28 := ""
				cCmp29 := ""
				nCmp30 := 0
				nCmp31 := 0
				nCmp32 := 0
				nCmp33 := 0
				nCmp34 := 0
				cCmp35 := ""
				nCmp46 := 0
				cChvAux := TrbBD7->(BD7_CODLDP+BD7_CODPEG+BD7_NUMERO+BD7_CODPAD+BD7_CODPRO)
				cChGuia := TrbBD7->(BD7_NUMLOT+BD7_CODRDA+BD7_CODLDP+BD7_CODPEG+BD7_NUMERO)
				Do While ! TrbBD7->(Eof()) .And. TrbBD7->(BD7_NUMLOT+BD7_CODRDA+BD7_CODLDP+BD7_CODPEG+BD7_NUMERO) ==  cChGuia

					BD6->(dbSetOrder(1))
					BD6->(msSeek(xFilial("BD6")+TrbBD7->(BD7_CODOPE+BD7_CODLDP+BD7_CODPEG+BD7_NUMERO+BD7_ORIMOV+BD7_SEQUEN+BD7_CODPAD+BD7_CODPRO)))
					cSlvPad := Posicione("BF8", 2, xFilial("BF8")+BD6->(BD6_CODPAD+BD6_CODOPE+BD6_CODTAB), "BF8_CODPAD")

					// BWT - Tipo de Participacao
					BWT->(dbSetOrder(1))
					BWT->(msSeek(xFilial("BWT")+TrbBD7->(BD7_CODOPE+BD7_CODTPA)))
					//aAdd(aCpo25[nInd1, nInd2, nInd3], TrbBD7->BD7_DATPRO) //25-Dada de Realizacao
					If Empty(dCmp25)
						dCmp25 := TrbBD7->BD7_DATPRO
					EndIf

					// BR8 - Tabela Padrao
					BR8->(dbSetOrder(1))
					BR8->(msSeek(xFilial("BR8")+BD6->(BD6_CODPAD+BD6_CODPRO)))

					cCodPad := PLSGETVINC("BTU_CDTERM", "BR4",.F., "87", BD6->BD6_CODPAD)
					cCodPro := PLSGETVINC("BTU_CDTERM", "BR8",.F., cCodPad)
					cDescri := PLSGETVINC("BTQ_DESTER", "BR8",.F., cCodPad, cCodPro)

					//aAdd(aCpo26[nInd1, nInd2, nInd3], cCodPad ) //26-Tabela
					If Empty(cCmp26)
						cCmp26 := cCodPad
					EndIf
					//aAdd(aCpo27[nInd1, nInd2, nInd3], cCodPro )    //27-Codigo do Prodecimento/Item assistencial
					If Empty(cCmp27)
						cCmp27 := cCodPro
					EndIf
					//aAdd(aCpo28[nInd1, nInd2, nInd3], cDescri)  //28-Descricao
					If Empty(cCmp28)
						cCmp28 := cDescri
					EndIf

					BWT->(dbSetOrder(1))
					BWT->(MsSeek(xFilial("BWT")+TrbBD7->(BD7_CODOPE+BWT->BWT_CODPAR)))
					//aAdd(aCpo29[nInd1, nInd2, nInd3], BWT->BWT_CODEDI) //29-Grau de Participacao
					If Empty(cCmp29)
						cCmp29 := BWT->BWT_CODEDI
					EndIf

					//aAdd(aCpo30[nInd1, nInd2, nInd3], Iif (!Empty(TrbBD7->BD7_VLRAPR),TrbBD7->BD7_VLRAPR,BD6->BD6_VLRAPR)) 	// 30-Valor Informado
					nCmp30 +=  Iif (!Empty(TrbBD7->BD7_VLRAPR),TrbBD7->BD7_VLRAPR,BD6->BD6_VLRAPR)
					nInfGui+=Iif (!Empty(TrbBD7->BD7_VLRAPR),TrbBD7->BD7_VLRAPR,BD6->BD6_VLRAPR)

					//aAdd(aCpo31[nInd1, nInd2, nInd3], BD6->BD6_QTDPRO) 	// 31-Quantidade Executada
					If nCmp31 == 0
						nCmp31 := BD6->BD6_QTDPRO
					EndIf

					//aAdd(aCpo32[nInd1, nInd2, nInd3], Iif (!Empty(TrbBD7->BD7_VLRPAG),TrbBD7->BD7_VLRPAG,0) + Iif (!Empty(TrbBD7->BD7_VLRGLO),TrbBD7->BD7_VLRGLO,0)) //32-Valor Processado
					nCmp32 += Iif (!Empty(TrbBD7->BD7_VLRPAG),TrbBD7->BD7_VLRPAG,0) + Iif (!Empty(TrbBD7->BD7_VLRGLO),TrbBD7->BD7_VLRGLO,0)
					nProcGui+=Iif (!Empty(TrbBD7->BD7_VLRPAG),TrbBD7->BD7_VLRPAG,0) + Iif (!Empty(TrbBD7->BD7_VLRGLO),TrbBD7->BD7_VLRGLO,0)
					//aAdd(aCpo33[nInd1, nInd2, nInd3], Iif (!Empty(TrbBD7->BD7_VLRPAG),TrbBD7->BD7_VLRPAG,0)) //33-Valor Liberado
					nCmp33 += Iif (!Empty(TrbBD7->BD7_VLRPAG),TrbBD7->BD7_VLRPAG,0)
					nLibGui+=TrbBD7->BD7_VLRPAG
					//aAdd(aCpo34[nInd1, nInd2, nInd3], Iif (!Empty(TrbBD7->BD7_VLRGLO),TrbBD7->BD7_VLRGLO,0)) //34-Valor Glosa
					nCmp34 += Iif (!Empty(TrbBD7->BD7_VLRGLO),TrbBD7->BD7_VLRGLO,0)
					nGloGui+=TrbBD7->BD7_VLRGLO

					// BDX - Glosas das Movimentacoes
					cCpo35 := ""
					lFlag  := .F.
					BDX->(dbSetOrder(1))
					If  BDX->(msSeek(xFilial("BDX")+TrbBD7->(BD7_CODOPE+BD7_CODLDP+BD7_CODPEG+BD7_NUMERO+BD7_ORIMOV+BD7_CODPAD+BD7_CODPRO+BD7_SEQUEN)))
						Do While ! BDX->(eof()) .And. BDX->(BDX_FILIAL+BDX_CODOPE+BDX_CODLDP+BDX_CODPEG+BDX_NUMERO+BDX_ORIMOV+BDX_CODPAD+BDX_CODPRO+BDX_SEQUEN) == ;
							xFilial("BDX")+TrbBD7->(BD7_CODOPE+BD7_CODLDP+BD7_CODPEG+BD7_NUMERO+BD7_ORIMOV+BD7_CODPAD+BD7_CODPRO+BD7_SEQUEN)

							BCT->(dbSetOrder(1))
							If BCT->(msSeek(xFilial("BCT")+BDX->(BDX_CODOPE+BDX_CODGLO))) .And.;
								At(BCT->BCT_GLTISS,cCpo35)==0

								If BDX->BDX_TIPREG == "1" .Or. (BDX->BDX_CODGLO==__aCdCri049[1] .And. !lFlag)
									cCpo35 += IIf(Empty(cCpo35), "", ", ") + AllTrim(BCT->BCT_GLTISS)
								Endif

							EndIf

							If BDX->BDX_CODGLO == __aCdCri049[1]
								lFlag := .T.
							EndIf

							BDX->(dbSkip())
						EndDo
					EndIf
					//aAdd(aCpo35[nInd1, nInd2, nInd3], cCpo35) //35-Codigo da Glosa
					If Empty(cCmp35)
						cCmp35 := cCpo35
					EndIf
					//aAdd(aCpo46,TrbBD7->RECNO)
					If nCmp46 == 0
						nCmp46 := TrbBD7->RECNO
					EndIf
					TrbBD7->(dbSkip())
					If cChvAux != TrbBD7->(BD7_CODLDP+BD7_CODPEG+BD7_NUMERO+BD7_CODPAD+BD7_CODPRO) .Or. TrbBD7->(Eof())
						aAdd(aCpo25[nInd1, nInd2, nInd3],dCmp25)
						aAdd(aCpo26[nInd1, nInd2, nInd3],cCmp26)
						aAdd(aCpo27[nInd1, nInd2, nInd3],cCmp27)
						aAdd(aCpo28[nInd1, nInd2, nInd3],cCmp28)
						aAdd(aCpo29[nInd1, nInd2, nInd3],cCmp29)
						aAdd(aCpo30[nInd1, nInd2, nInd3],nCmp30)
						aAdd(aCpo31[nInd1, nInd2, nInd3],nCmp31)
						aAdd(aCpo32[nInd1, nInd2, nInd3],nCmp32)
						aAdd(aCpo33[nInd1, nInd2, nInd3],nCmp33)
						aAdd(aCpo34[nInd1, nInd2, nInd3],nCmp34)
						aAdd(aCpo35[nInd1, nInd2, nInd3],cCmp35)
						aAdd(aCpo46,nCmp46)
						dCmp25 := ""
						cCmp26 := ""
						cCmp27 := ""
						cCmp28 := ""
						cCmp29 := ""
						nCmp30 := 0
						nCmp31 := 0
						nCmp32 := 0
						nCmp33 := 0
						nCmp34 := 0
						cCmp35 := ""
						nCmp46 := 0
					EndIf
					cChGuia1 := cChGuia
					cChvAux := TrbBD7->(BD7_CODLDP+BD7_CODPEG+BD7_NUMERO+BD7_CODPAD+BD7_CODPRO)
				EndDo//Do While ! TrbBD7->(Eof()) .And. TrbBD7->(BD7_NUMLOT+BD7_CODRDA+BD7_CODLDP+BD7_CODPEG+BD7_NUMERO) ==  cChGuia
			Enddo//Do While ! TrbBD7->(Eof()) .And. TrbBD7->(BD7_NUMLOT+BD7_CODRDA+BD7_CODLDP+BD7_CODPEG) ==  cChFat
		EndDo//Do While ! TrbBD7->(Eof()) .And. TrbBD7->(BD7_NUMLOT+BD7_CODRDA) ==  cChRDA
	EndDo//Do While ! TrbBD7->(Eof())
	aAdd(aDados, aCpo02)
	aAdd(aDados, BA0->BA0_NOMINT) // 3-Nome da Operadora
	aAdd(aDados, Transform(BA0->BA0_CGC, "@R 99.999.999/9999-99")) // 4-CNPJ da Operadora
	aAdd(aDados, aCpo05)
	aAdd(aDados, aCpo06)
	aAdd(aDados, aCpo07)
	aAdd(aDados, aCpo08)
	aAdd(aDados, aCpo09)
	aAdd(aDados, aCpo10)
	aAdd(aDados, aCpo11)
	aAdd(aDados, aCpo12)
	aAdd(aDados, aCpo13)
	aAdd(aDados, aCpo14)
	aAdd(aDados, aCpo15)
	aAdd(aDados, aCpo16)
	aAdd(aDados, aCpo17)
	aAdd(aDados, aCpo18)
	aAdd(aDados, aCpo19)
	aAdd(aDados, aCpo20)
	aAdd(aDados, aCpo21)
	aAdd(aDados, aCpo22)
	aAdd(aDados, aCpo23)
	aAdd(aDados, aCpo24)
	aAdd(aDados, aCpo25)
	aAdd(aDados, aCpo26)
	aAdd(aDados, aCpo27)
	aAdd(aDados, aCpo28)
	aAdd(aDados, aCpo29)
	aAdd(aDados, aCpo30)
	aAdd(aDados, aCpo31)
	aAdd(aDados, aCpo32)
	aAdd(aDados, aCpo33)
	aAdd(aDados, aCpo34)
	aAdd(aDados, aCpo35)
	aAdd(aDados, nInfGui)	//36-Valor Informado da Guia
	aAdd(aDados, nProcGui)	//37-Valor Processado da Guia
	aAdd(aDados, nLibGui)	//38-Valor Liberado da Guia
	aAdd(aDados, nGloGui)	//39-Valor Glosa da Guia
	aAdd(aDados, nInfFat)	//40-Valor Informado do Protocolo
	aAdd(aDados, nProcFat)	//41-Valor Processado do Protocolo
	aAdd(aDados, nLibFat)	//42-Valor Liberado do Protocolo
	aAdd(aDados, nGloFat)	//43-Valor Glosa Protocolo
	aAdd(aDados, nInfGer)	//44-Valor informado Fatura
	aAdd(aDados, nProcGer)	//45-Valor Processado Fatura
	aAdd(aDados, nLibGer)	//46-Valor Liberado Fatura
	aAdd(aDados, nGloGer)	//47-Valor Glosa Fatura
	aAdd(aDados, aCpo46) 	//48-recnos

	If !lAchouUm
		aDados := {}
	EndIf
Enddo//Do While ! TrbBD7->(Eof())
TrbBD7->(DbCloseArea())

Return aDados*/

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡ao    ?AddTBrush ?Autor ?Bruno Iserhardt       ?Data ?03.10.13 ³±?
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡ao ?Cria um retângulo se a chave estiver habilitada             ³±?
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*//*
Function AddTBrush(oPrint, nLinIni, nColIni, nLinFim, nColFim, clrColor)
Default clrColor := CLR_GRAY
If (GETMV("MV_PLFCTIS") == .T.)
	oPrint:FillRect( {nLinIni, nColIni, nLinFim, nColFim}, TBrush():New( , clrColor ) )
EndIF
Return*/

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡ao    ?PLSDPGTODB?Autor ?Bruno Iserhardt       ?Data ?11.12.13 ³±?
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡ao ?Dados Relatório TISS (Guia Odontológica - Demon. Pagamento )³±?
±±?         ?TISS 3                                                      ³±?
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±?Uso      ?SigaPLS                                                     ³±?
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros?cCodOpe - Código da Operadora                               ³±?
±±?         ?cRdaDe  - Código da RDA a ser processada (de)               ³±?
±±?         ?cRdaAte - Código da RDA a ser processada (At?              ³±?
±±?         ?cAno    - Informe o Ano a ser processado                    ³±?
±±?         ?cMes    - Informe o Mês a ser processado                    ³±?
±±?         ?cClaPre - Classe RDA                                        ³±?
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
/*
Function CABDPGTODB(cCodOpe, cRdaDe, cRdaAte, cAno, cMes, cClaPre, cNmTitPg, cDataPag)

Local aCpo08,aCpo09,aCpo10,aCpo11,aCpo12,aCpo13,aCpo14,aCpo15,aCpo16,aCpo17,aCpo18,aCpo19,aCpo20,aCpo21,aCpo22,aCpo23,aCpo30,aCpo38,aCpo39,aCpo40
Local aCpo02,aCpo03,aCpo04,aCpo05,aCpo06,aCpo07,aCpo24,aCpo25,aCpo26,aCpo27,aCpo28,aCpo29,aCpo31,aCpo32,aCpo33,aCpo34,aCpo35,aCpo36,aCpo37,aCpo41
Local aCpo42,aCpo43,aCpo44,aCpo45,aCpo46,aCpo47,aCpo48,aCpo49,aCpo50,aCpo51,aCpo52,aCpo53,aCpo54,aCpo55,aCpo56,aCpo57,aCpo58,aCpo59,aCpo60,aCpo61
Local aCpo62
Local nInd1, nInd2 , nInd3
Local nCont:=0
Local nValorDC 	:= 0
Local aDados
Local cSQL, cSQL1
Local nDeb,nCred,nDebNT,nCredNT
Local nProcGui,nGloGui,nLibGui
Local nProcLot,nGloLot,nLibLot
Local nProcGer,nGloGer,nLibGer
Local cChRDA,cChLot,cChGuia
LOCAL cNmLotPg		:= ""
LOCAL cRdaLote		:= ""
Local lRecGlo	:= .F.
DEFAULT cNmTitPg := ""
Default cDataPag := ""

aDados := {}
DBSELECTAREA("SE2")
// Variaveis para buscar o BMR pelo numero do titulo.
If !Empty(cNmTitPg)
	SE2->(dbSetorder(01))
	If SE2->(dbSeek(xFilial("SE2")+cNmTitPg))
		cCodOpe  := SE2->E2_PLOPELT
		cNmLotPg := substr(SE2->E2_PLLOTE,7,4) //SE2->E2_PLLOTE
		cRdaLote := SE2->E2_CODRDA
		cAno	 := SE2->E2_ANOBASE
		cMes	 := SE2->E2_MESBASE

		// SA2 - Cadastro de Fornecedores
		SA2->(dbSetOrder(1))
		SA2->(msSeek(xFilial("SA2")+SE2->E2_FORNECE+SE2->E2_LOJA))
	Endif
Endif

cSQL := "SELECT BMR_ANOLOT, BMR_CODLAN, BMR_CODRDA, BMR_DEBCRE, BMR_FILIAL, BMR_MESLOT, BMR_NUMLOT, BMR_OPELOT, BMR_OPERDA, BMR_VLRPAG"
cSQL += "  FROM " + RetSqlName("BMR")
If !Empty(cDataPag)
	cSQL += "INNER JOIN " + RetSqlName("BAF") + " BAF ON "
	cSQL += "BMR_ANOLOT = BAF_ANOLOT AND BMR_MESLOT = BAF_MESLOT AND BMR_NUMLOT = BAF_NUMLOT AND BAF_DTDIGI = '" + cDataPag + "' AND BAF.D_E_L_E_T_ = '' "
Endif
cSQL += " WHERE BMR_FILIAL = '" + xFilial("BMR") + "' AND "
cSQL += " BMR_OPELOT = '" + cCodOpe + "' AND "

If !Empty(cNmLotPg)
	cSQL += " BMR_CODRDA = '" + cRdaLote + "' AND "
	cSQL += " BMR_NUMLOT = '" + cNmLotPg + "' AND "

Else
	cSQL += " ( BMR_CODRDA >= '" + cRdaDe    + "' AND BMR_CODRDA <= '" + cRdaAte    + "' ) AND "

Endif
cSQL += " BMR_ANOLOT = '" + cAno + "' AND "
cSQL += " BMR_MESLOT = '" + cMes + "' AND "

cSql += RetSQLName("BMR")+".D_E_L_E_T_ = ' '"
cSQL += " ORDER BY BMR_FILIAL, BMR_OPELOT, BMR_ANOLOT, BMR_MESLOT, BMR_NUMLOT, BMR_OPERDA, BMR_CODRDA, BMR_CODLAN "

PlsQuery(cSQL,"TrbBMR")

// BA0 - Operadoras de Saude
BA0->(dbSetOrder(1))
BA0->(msSeek(xFilial("BA0")+TrbBMR->(BMR_OPERDA)))

Do While ! TrbBMR->(Eof())
	nValorDC := 0

	nCont+=1
	// BAU - Redes de Atendimento
	BAU->(dbSetOrder(1))
	BAU->(msSeek(xFilial("BAU")+TrbBMR->BMR_CODRDA))

	// BAF - Lotes de Pagamentos RDA
	BAF->(dbSetOrder(1))
	BAF->(msSeek(xFilial("BAF")+TrbBMR->(BMR_OPERDA+BMR_ANOLOT+BMR_MESLOT+BMR_NUMLOT)))
	If Empty(cNmTitPg) .and. Empty(cNmLotPg)
		cSQL := " SELECT R_E_C_N_O_ E2_RECNO,E2_VENCTO, E2_VALOR "
		cSQL += "  FROM " + RetSQLName("SE2")
		cSQL += "  WHERE E2_FILIAL = '" + xFilial("SE2") + "' "
		cSQL += "    AND E2_PLOPELT = '" + TrbBMR->BMR_OPELOT + "'"
		cSQL += "    AND E2_PLLOTE = '" + TrbBMR->(BMR_ANOLOT+BMR_MESLOT+BMR_NUMLOT) + "'"
		cSQL += "    AND E2_CODRDA = '" + TrbBMR->BMR_CODRDA + "'"
		cSQL += "    AND D_E_L_E_T_ = ' ' "
		PlsQuery(cSQL,"TrbSE2")

		If ! TrbSE2->(Eof())
			SE2->(dbGoTo(TrbSE2->(E2_RECNO)))

			// SA2 - Cadastro de Fornecedores
			SA2->(dbSetOrder(1))
			SA2->(msSeek(xFilial("SA2")+SE2->E2_FORNECE+SE2->E2_LOJA))
		EndIf

		TrbSE2->(DbCloseArea())
	Endif

	cSQL := "SELECT BD7_CODEMP, BD7_CODLDP, BD7_CODOPE, BD7_CODPAD, BD7_CODPEG, BD7_CODPRO, BD7_CODRDA, BD7_CODTPA, BD7_DATPRO, BD7_MATRIC, "
	cSql += "BD7_NOMRDA,BD7_NOMUSR, BD7_NUMERO, BD7_NUMLOT, BD7_OPELOT, BD7_ORIMOV, BD7_SEQUEN, BD7_TIPREG, BD7_MOTBLO, BD7_VLRGLO, BD7_VLRPAG, "
	cSql += "BD7_ANOPAG, BD7_MESPAG, BD7_ESTPRE, BD7_REGPRE, BD7_SIGLA "
	cSQL += "  FROM " + RetSqlName("BD7")
	cSQL += " WHERE BD7_FILIAL = '" + xFilial("BD7") + "'"
	cSQL += "   AND BD7_NUMLOT = '" + TrbBMR->(BMR_ANOLOT+BMR_MESLOT+BMR_NUMLOT) + "'"
	cSQL += "   AND BD7_CODRDA = '" + TrbBMR->(BMR_CODRDA)+ "'"
	cSQL += "   AND D_E_L_E_T_ = ' '"
	cSQL += " ORDER BY BD7_CODLDP, BD7_CODPEG"
	PlsQuery(cSQL,"TrbBD7")

	If nCont == 1

		aCpo02 := {}
		aCpo03 := {}
		aCpo04 := {}
		aCpo05 := {}
		aCpo06 := {}
		aCpo07 := {}
		aCpo08 := {}
		aCpo09 := {}
		aCpo10 := {}
		aCpo11 := {}
		aCpo12 := {}
		aCpo13 := {}
		aCpo14 := {}
		aCpo15 := {}
		aCpo16 := {}
		aCpo17 := {}
		aCpo18 := {}
		aCpo19 := {}
		aCpo20 := {}
		aCpo21 := {}
		aCpo22 := {}
		aCpo23 := {}
		aCpo24 := {}
		aCpo25 := {}
		aCpo26 := {}
		aCpo27 := {}
		aCpo28 := {}
		aCpo29 := {}
		aCpo30 := {}
		aCpo31 := {}
		aCpo32 := {}
		aCpo33 := {}
		aCpo34 := {}
		aCpo35 := {}
		aCpo36 := {}
		aCpo37 := {}
		aCpo38 := {}
		aCpo39 := {}
		aCpo40 := {}
		aCpo41 := {}
		aCpo42 := {}
		aCpo43 := {}
		aCpo44 := {}
		aCpo45 := {}
		aCpo46 := {}
		aCpo47 := {}
		aCpo48 := {}
		aCpo49 := {}
		aCpo50 := {}
		aCpo51 := {}
		aCpo52 := {}
		aCpo53 := {}
		aCpo54 := {}
		aCpo55 := {}
		aCpo56 := {}
		aCpo57 := {}
		aCpo58 := {}
		aCpo59 := {}
		aCpo60 := {}
		aCpo61 := {}
		aCpo62 := {}
	Endif

	nProcGer:=0
	nLibGer :=0
	nGloGer :=0

	// BDT - Calendário de Pagamento
	BDT->(dbSetOrder(1))
	BDT->(msSeek(xFilial("BDT")+TrbBD7->(BD7_CODOPE+BD7_ANOPAG+BD7_MESPAG)))

	If nCont == 1
		aAdd(aDados, BA0->BA0_SUSEP) //1 - Registro ANS
	EndIf

	aAdd(aCpo02, BAF->(BAF_ANOLOT+BAF_MESLOT+BAF_NUMLOT)) //2- N?
	aAdd(aCpo03, BA0->BA0_NOMINT) //3 - Nome da Operadora
	aAdd(aCpo04, Transform(BA0->BA0_CGC, "@R 99.999.999/9999-99")) //4 - CNPJ Operadora
	aAdd(aCpo05, BDT->BDT_DATINI) //5 - Data de Início do Processamento
	aAdd(aCpo06, BDT->BDT_DATFIN) //6 - Data de Fim do Processamento
	aAdd(aCpo07, BAU->(BAU_CODIGO)) //7 - Código na Operadora
	aAdd(aCpo08, BAU->BAU_NOME) //8- Nome do Contratado
	aAdd(aCpo09, IIf(BAU->BAU_TIPPE == "F", Transform(BAU->BAU_CPFCGC, "@R 999.999.999-99"), Transform(BAU->BAU_CPFCGC, "@R 99.999.999/9999-99"))) //9 - CPF / CNPJ Contratado
	aAdd(aCpo10,{})
	aAdd(aCpo11,{})
	aAdd(aCpo12,{})
	aAdd(aCpo13,{})
	aAdd(aCpo14,{})
	aAdd(aCpo15,{})
	aAdd(aCpo16,{})
	aAdd(aCpo17,{})
	aAdd(aCpo18,{})
	aAdd(aCpo19,{})
	aAdd(aCpo20,{})
	aAdd(aCpo21,{})
	aAdd(aCpo22,{})
	aAdd(aCpo23,{})
	aAdd(aCpo24,{})
	aAdd(aCpo25,{})
	aAdd(aCpo26,{})
	aAdd(aCpo27,{})
	aAdd(aCpo28,{})
	aAdd(aCpo29,{})
	aAdd(aCpo30,{})
	aAdd(aCpo31,{})
	aAdd(aCpo32,{})
	aAdd(aCpo33,{})
	aAdd(aCpo34,{})
	aAdd(aCpo35,{})
	aAdd(aCpo36,{})
	aAdd(aCpo37,{})
	aAdd(aCpo38,{})
	aAdd(aCpo39,{})
	aAdd(aCpo40,{})
	aAdd(aCpo41,{})
	aAdd(aCpo42,{})
	aAdd(aCpo43,{})
	aAdd(aCpo44,{})
	aAdd(aCpo45,{})
	aAdd(aCpo46,{})
	aAdd(aCpo47,{})
	aAdd(aCpo48,{})
	aAdd(aCpo49,{})
	aAdd(aCpo50,{})
	aAdd(aCpo51,{})
	aAdd(aCpo52,{})
	aAdd(aCpo53,{})
	aAdd(aCpo54,{})
	aAdd(aCpo60,{})
	aAdd(aCpo61,{})
	aAdd(aCpo62,{})
	nInd1 := Len(aCpo02)

	nProcLot:=0
	nLibLot :=0
	nGloLot :=0
	nProcGer:=0
	nLibGer :=0
	nGloGer :=0

	cChRDA  := TrbBD7->(BD7_NUMLOT+BD7_CODRDA)
	Do While ! TrbBD7->(Eof()) .And. TrbBD7->(BD7_NUMLOT+BD7_CODRDA) ==  cChRDA
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//?Tabela Padrão                                    			 ?
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		BR8->(dbSetOrder(1))
		BR8->(msSeek(xFilial("BR8")+TrbBD7->(BD7_CODPAD+BD7_CODPRO)))

		If BR8->BR8_ODONTO == "1"

			aAdd(aCpo10[nInd1],{})
			aAdd(aCpo11[nInd1],{})
			aAdd(aCpo12[nInd1],{})
			aAdd(aCpo13[nInd1],{})
			aAdd(aCpo14[nInd1],{})
			aAdd(aCpo15[nInd1],{})
			aAdd(aCpo16[nInd1],{})
			aAdd(aCpo17[nInd1],{})
			aAdd(aCpo18[nInd1],{})
			aAdd(aCpo19[nInd1],{})
			aAdd(aCpo20[nInd1],{})
			aAdd(aCpo21[nInd1],{})
			aAdd(aCpo22[nInd1],{})
			aAdd(aCpo23[nInd1],{})
			aAdd(aCpo24[nInd1],{})
			aAdd(aCpo25[nInd1],{})
			aAdd(aCpo26[nInd1],{})
			aAdd(aCpo27[nInd1],{})
			aAdd(aCpo28[nInd1],{})
			aAdd(aCpo29[nInd1],{})
			aAdd(aCpo30[nInd1],{})
			aAdd(aCpo31[nInd1],{})
			aAdd(aCpo32[nInd1],{})
			aAdd(aCpo33[nInd1],{})
			aAdd(aCpo34[nInd1],{})
			aAdd(aCpo35[nInd1],{})
			aAdd(aCpo36[nInd1],{})
			aAdd(aCpo37[nInd1],{})
			aAdd(aCpo60[nInd1],{})
			aAdd(aCpo61[nInd1],{})
			aAdd(aCpo62[nInd1],{})
			nInd2 := Len(aCpo10[nInd1])

			nProcLot:=0
			nLibLot :=0
			nGloLot :=0
			cChLot := TrbBD7->(BD7_NUMLOT+BD7_CODRDA+BD7_CODLDP+BD7_CODPEG)

			Do While ! TrbBD7->(Eof()) .And. TrbBD7->(BD7_NUMLOT+BD7_CODRDA+BD7_CODLDP+BD7_CODPEG) ==  cChLot
				BA1->(dbSetOrder(2))
				BA1->(msSeek(xFilial("BA1")+TrbBD7->(BD7_CODOPE+BD7_CODEMP+BD7_MATRIC+BD7_TIPREG)))

				BCI->(dbSetOrder(5))
				BCI->(msSeek(xFilial("BCI")+TrbBD7->(BD7_CODOPE+BD7_CODRDA+BD7_CODOPE+BD7_CODLDP+BD7_CODPEG)))

				BD5->(DbSetOrder(1))
				BD5->(DbSeek(xFilial("BD5")+TrbBD7->(BD7_CODOPE+BD7_CODLDP+BD7_CODPEG+BD7_NUMERO)))

				BVO->(DbSetOrder(2))//BVO_FILIAL+BVO_CODOPE+BVO_CODLDP+BVO_CODPEG+BVO_NUMERO+BVO_ORIMOV+BVO_SEQUEN+BVO_CODPAD+BVO_CODPRO+BVO_SEQREC
				If BVO->(DbSeek(xFilial("BVO")+TrbBD7->(BD7_CODOPE+BD7_CODLDP+BD7_CODPEG+BD7_NUMERO+BD7_ORIMOV+BD7_SEQUEN+BD7_CODPAD+BD7_CODPRO)))
					lRecGlo := .T.
				Else
					lRecGlo := .F.
				EndIf

				aAdd(aCpo10[nInd1,nInd2], SE2->E2_VENCTO) //10 - Data do Pagamento
				aAdd(aCpo11[nInd1,nInd2], SA2->A2_BANCO) //11 - Banco
				aAdd(aCpo12[nInd1,nInd2], SA2->A2_AGENCIA) //12 - Agência
				aAdd(aCpo13[nInd1,nInd2], SA2->A2_NUMCON) //13 - Conta
				aAdd(aCpo14[nInd1,nInd2], TrbBD7->(BD7_CODLDP+BD7_CODPEG)) //14 - Número do lote
				aAdd(aCpo15[nInd1,nInd2], BCI->BCI_CODPEG) //15-Número do Protocolo
				aAdd(aCpo16[nInd1,nInd2], BD5->BD5_CODOPE+BD5->BD5_ANOAUT) //16-Número da guia no prestador
				aAdd(aCpo60[nInd1,nInd2], TrbBD7->BD7_NUMERO) //17-Número da guia atribuído pela operadora
				aAdd(aCpo61[nInd1,nInd2], Iif(lRecGlo,"S","N")) //18-Recurso
				aAdd(aCpo62[nInd1,nInd2], Posicione("BB0",4,xFilial("BB0")+TrbBD7->(BD7_ESTPRE+BD7_REGPRE+BD7_SIGLA),"BB0_NOME")) //19-Nome do Profissional Executante
				If BA1->BA1_CODINT == BA1->BA1_OPEORI .Or. empty(BA1->BA1_MATANT)
					aAdd(aCpo17[nInd1,nInd2], BA1->(BA1_CODINT+"."+BA1_CODEMP+"."+BA1_MATRIC+"."+BA1_TIPREG+"-"+BA1_DIGITO)	) //20 - Número da Carteira
				Else
					aAdd(aCpo17[nInd1,nInd2], BA1->BA1_MATANT) //20 - Número da Carteira
				EndIf
				aAdd(aCpo18[nInd1,nInd2], TrbBD7->BD7_NOMUSR) //21 -Nome do Beneficiário

				aAdd(aCpo19[nInd1, nInd2], {})
				aAdd(aCpo20[nInd1, nInd2], {})
				aAdd(aCpo21[nInd1, nInd2], {})
				aAdd(aCpo22[nInd1, nInd2], {})
				aAdd(aCpo23[nInd1, nInd2], {})
				aAdd(aCpo24[nInd1, nInd2], {})
				aAdd(aCpo25[nInd1, nInd2], {})
				aAdd(aCpo26[nInd1, nInd2], {})
				aAdd(aCpo27[nInd1, nInd2], {})
				aAdd(aCpo28[nInd1, nInd2], {})
				aAdd(aCpo29[nInd1, nInd2], {})
				aAdd(aCpo30[nInd1, nInd2], {})
				aAdd(aCpo31[nInd1, nInd2], {})
				nInd3 := Len(aCpo10[nInd1, nInd2])

				nProcGui:=0
				nLibGui :=0
				nGloGui :=0
				cChGuia := TrbBD7->(BD7_NUMLOT+BD7_CODRDA+BD7_CODLDP+BD7_CODPEG+BD7_NUMERO)
				Do While ! TrbBD7->(Eof()) .And. TrbBD7->(BD7_NUMLOT+BD7_CODRDA+BD7_CODLDP+BD7_CODPEG+BD7_NUMERO) ==  cChGuia
					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//?Tipo de Participação                             			 ?
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					BWT->(dbSetOrder(1))
					BWT->(msSeek(xFilial("BWT")+TrbBD7->(BD7_CODOPE+BD7_CODTPA)))
					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//?Tabela Padrão                                    			 ?
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					BR8->(dbSetOrder(1))
					BR8->(msSeek(xFilial("BR8")+TrbBD7->(BD7_CODPAD+BD7_CODPRO)))

					If BR8->BR8_ODONTO == "1"

						BD6->(dbSetOrder(1))
						BD6->(msSeek(xFilial("BD6")+TrbBD7->(BD7_CODOPE+BD7_CODLDP+BD7_CODPEG+BD7_NUMERO+BD7_ORIMOV+BD7_SEQUEN+BD7_CODPAD+BD7_CODPRO)))

						aAdd(aCpo19[nInd1, nInd2, nInd3], Posicione("BF8", 2, xFilial("BF8")+BD6->(BD6_CODPAD+BD6_CODOPE+BD6_CODTAB), "BF8_TABTIS")) //19-Tabela
						aAdd(aCpo20[nInd1, nInd2, nInd3], TrbBD7->BD7_CODPRO) //20- Código do Procedimento
						aAdd(aCpo21[nInd1, nInd2, nInd3], BR8->BR8_DESCRI) //21 - Descrição
						//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
						//?Posiciona Dente/Região                             			 ?
						//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
						BYT->(dbSetOrder(1))
						BYT->(dbSeek(xFilial("BYT")+TrbBD7->(BD7_CODOPE+BD7_CODLDP+BD7_CODPEG+BD7_NUMERO+BD7_SEQUEN)))
						aAdd(aCpo22[nInd1, nInd2, nInd3], BYT->BYT_CODIGO) //22-Dente/Região

						cSQL1 := " SELECT BE2_ANOAUT,BE2_MESAUT,BE2_NUMAUT "
						cSQL1 += "  FROM " + RetSQLName("BE2")
						cSQL1 += "  WHERE BE2_FILIAL = '" + xFilial("BE2") + "' "
						cSQL1 += "    AND BE2_OPEMOV = '" + TrbBD7->BD7_CODOPE + "'"
						cSQL1 += "    AND BE2_ANOAUT = '" + TrbBD7->BD7_ANOPAG + "'"
						cSQL1 += "    AND BE2_MESAUT = '" + TrbBD7->BD7_MESPAG + "'"
						cSQL1 += "    AND BE2_NUMERO = '" + TrbBD7->BD7_NUMERO + "'"
						cSQL1 += "    AND BE2_CODLDP = '" + TrbBD7->BD7_CODLDP + "'"
						cSQL1 += "    AND BE2_CODPEG = '" + TrbBD7->BD7_CODPEG + "'"
						cSQL1 += "    AND BE2_SEQUEN = '" + TrbBD7->BD7_SEQUEN + "'"
						cSQL1 += "    AND BE2_CODPAD = '" + TrbBD7->BD7_CODPAD + "'"
						cSQL1 += "    AND BE2_CODPRO = '" + TrbBD7->BD7_CODPRO + "'"
						cSQL1 += "    AND D_E_L_E_T_ = ' ' "

						PlsQuery(cSQL1,"TrbBE2")

						//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
						//?Posiciona Face		                             			 ?
						//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
						BYS->(dbSetOrder(1))
						BYS->(dbSeek(xFilial("BYS")+BYT->BYT_CODOPE+TrbBD7->(BD7_ANOPAG+BD7_MESPAG+BD7_NUMERO)+BYT->(BYT_SEQUEN+BYT_CODIGO)))

						TrbBE2->(dbCloseArea())

						If !Empty(BYS->BYS_FACES)
							aAdd(aCpo23[nInd1, nInd2, nInd3],BYS->BYS_FACES) //23-Face
						Else
							dbSelectArea("BYT")
							BYT->(dbSetOrder(1))
							BYT->(dbSeek((xFilial("BYT")+TrbBD7->BD7_CODOPE+TrbBD7->BD7_CODLDP+TrbBD7->BD7_CODPEG+TrbBD7->BD7_NUMERO+TrbBD7->BD7_SEQUEN)))
							aAdd(aCpo23[nInd1, nInd2, nInd3],BYT->BYT_FACES) //23-Face
						EndIf

						aAdd(aCpo24[nInd1, nInd2, nInd3], TrbBD7->BD7_DATPRO) //24-Data de Realização
						aAdd(aCpo25[nInd1, nInd2, nInd3], BD6->BD6_QTDPRO) //25-Qtde
						aAdd(aCpo26[nInd1, nInd2, nInd3], 0) //26-Valor Informado(R$)
						aAdd(aCpo27[nInd1, nInd2, nInd3], TrbBD7->BD7_VLRPAG + TrbBD7->BD7_VLRGLO) //27-Valor Processado (R$)
						nProcGui+=TrbBD7->BD7_VLRPAG + TrbBD7->BD7_VLRGLO
						aAdd(aCpo28[nInd1, nInd2, nInd3], TrbBD7->BD7_VLRGLO) //28-Valor Glosa/Estorno (R$)
						aAdd(aCpo29[nInd1, nInd2, nInd3], 0) //29- Valor Franquia( R$)
						nGloGui+=TrbBD7->BD7_VLRGLO
						aAdd(aCpo30[nInd1, nInd2, nInd3], TrbBD7->BD7_VLRPAG) //30-Valor Liberado (R$)
						nLibGui+=TrbBD7->BD7_VLRPAG

						// BCT - Motivos de Glosas
						cCpo31 := ""
						BDX->(dbSetOrder(1))
						If BDX->(msSeek(xFilial("BDX")+TrbBD7->(BD7_CODOPE+BD7_CODLDP+BD7_CODPEG+BD7_NUMERO+BD7_ORIMOV+BD7_CODPAD+BD7_CODPRO+BD7_SEQUEN)))
							Do While ! BDX->(eof()) .And. BDX->(BDX_FILIAL+BDX_CODOPE+BDX_CODLDP+BDX_CODPEG+BDX_NUMERO+BDX_ORIMOV+BDX_CODPAD+BDX_CODPRO+BDX_SEQUEN) == ;
								xFilial("BDX")+TrbBD7->(BD7_CODOPE+BD7_CODLDP+BD7_CODPEG+BD7_NUMERO+BD7_ORIMOV+BD7_CODPAD+BD7_CODPRO+BD7_SEQUEN)
								// BDX - Glosas das Movimentacoes
								BCT->(dbSetOrder(1))
								If BCT->(msSeek(xFilial("BCT")+BDX->(BDX_CODOPE+BDX_CODGLO)))
									If At(BCT->BCT_GLTISS, cCpo23) == 0
										cCpo31 += IIf(Empty(cCpo23), "", ",") + BCT->BCT_GLTISS
									EndIf
								EndIf
								BDX->(dbSkip())
							EndDo
						EndIf
					Endif
					aAdd(aCpo31[nInd1, nInd2, nInd3], cCpo31) //31-Código da Glosa
					TrbBD7->(dbSkip())
				EndDo

				aAdd(aCpo32[nInd1, nInd2], "") //32-Observação / Justificativa

				aAdd(aCpo33[nInd1, nInd2],0) //33- Valor Total Informado Guia (R$)
				aAdd(aCpo34[nInd1, nInd2],nProcGui) //34 - Valor Total Processado Guia (R$)
				nProcLot+=nProcGui
				aAdd(aCpo35[nInd1, nInd2],nGloGui) //35 - Valor Total Glosa Guia (R$)
				aAdd(aCpo36[nInd1, nInd2],0) //36 - Valor Total Franquia Guia (R$)
				nGloLot+=nGloGui
				aAdd(aCpo37[nInd1, nInd2],(nProcGui-nGloGui)) //37 - Valor Total Liberado Guia (R$)
				nLibLot+=(nProcGui-nGloGui)
			EndDo

			aAdd(aCpo38[nInd1],0) //38 - Valor Total Informado Protocolo (R$)
			aAdd(aCpo39[nInd1],nProcLot) //39 - Valor Total Processado Protocolo (R$)
			nProcGer+=nProcLot
			aAdd(aCpo40[nInd1],nGloLot) //40 - Valor Total Glosa Protocolo (R$)
			nGloGer+=nGloLot
			aAdd(aCpo41[nInd1],0) //41 - Valor Total Franquia Protocolo (R$)
			aAdd(aCpo42[nInd1],(nProcLot-nGloLot)) //42 - Valor Total Liberado Protocolo (R$)
			nLibGer+=(nProcLot-nGloLot)

		Endif
		TrbBD7->(dbSkip())
	EndDo

	TrbBD7->(DbCloseArea())

	aAdd(aDados, aCpo02)
	aAdd(aDados, aCpo03)
	aAdd(aDados, aCpo04)
	aAdd(aDados, aCpo05)
	aAdd(aDados, aCpo06)
	aAdd(aDados, aCpo07)
	aAdd(aDados, aCpo08)
	aAdd(aDados, aCpo09)
	aAdd(aDados, aCpo10)
	aAdd(aDados, aCpo11)
	aAdd(aDados, aCpo12)
	aAdd(aDados, aCpo13)
	aAdd(aDados, aCpo14)
	aAdd(aDados, aCpo15)
	aAdd(aDados, aCpo16)
	aAdd(aDados, aCpo17)
	aAdd(aDados, aCpo18)
	aAdd(aDados, aCpo19)
	aAdd(aDados, aCpo20)
	aAdd(aDados, aCpo21)
	aAdd(aDados, aCpo22)
	aAdd(aDados, aCpo23)
	aAdd(aDados, aCpo24)
	aAdd(aDados, aCpo25)
	aAdd(aDados, aCpo26)
	aAdd(aDados, aCpo27)
	aAdd(aDados, aCpo28)
	aAdd(aDados, aCpo29)
	aAdd(aDados, aCpo30)
	aAdd(aDados, aCpo31)
	aAdd(aDados, aCpo32)
	aAdd(aDados, aCpo33)
	aAdd(aDados, aCpo34)
	aAdd(aDados, aCpo35)
	aAdd(aDados, aCpo36)
	aAdd(aDados, aCpo37)
	aAdd(aDados, aCpo38)
	aAdd(aDados, aCpo39)
	aAdd(aDados, aCpo40)
	aAdd(aDados, aCpo41)
	aAdd(aDados, aCpo42)

	nDeb 	:= 0
	nDebNT 	:= 0
	nCred	:= 0
	nCredNT	:= 0
	nValorDC:= 0

	BGQ->(dbSetOrder(4))//BGQ_FILIAL+BGQ_CODOPE+BGQ_CODIGO+BGQ_ANO+BGQ_MES+BGQ_CODLAN+BGQ_OPELOT+BGQ_NUMLOT
	cChBMR := TrbBMR->(BMR_FILIAL+BMR_OPELOT+BMR_ANOLOT+BMR_MESLOT+BMR_NUMLOT+BMR_OPERDA+BMR_CODRDA)
	Do While ! TrbBMR->(Eof()) .And. TrbBMR->(BMR_FILIAL+BMR_OPELOT+BMR_ANOLOT+BMR_MESLOT+BMR_NUMLOT+BMR_OPERDA+BMR_CODRDA) == cChBMR

		If TrbBMR->BMR_CODLAN $ "102,103,104,105" // Debitos/Creditos Fixos e Variaveis
			BMS->(dbSetOrder(1))
			BMS->(msSeek(TrbBMR->(BMR_FILIAL+BMR_OPERDA+BMR_CODRDA+BMR_OPELOT+BMR_ANOLOT+BMR_MESLOT+BMR_NUMLOT+BMR_CODLAN)))
			Do While ! BMS->(Eof()) .And. ;
				BMS->(BMS_FILIAL+BMS_OPERDA+BMS_CODRDA+BMS_OPELOT+BMS_ANOLOT+BMS_MESLOT+BMS_NUMLOT+BMS_CODLAN) == ;
				TrbBMR->(BMR_FILIAL+BMR_OPERDA+BMR_CODRDA+BMR_OPELOT+BMR_ANOLOT+BMR_MESLOT+BMR_NUMLOT+BMR_CODLAN)

				If Len(CalcImp(BMS->BMS_VLRPAG)) > 0
					aTmpCpo35 := CalcImp(BMS->BMS_VLRPAG)
					aAdd(aCpo51[nInd1], TrbBMR->BMR_DEBCRE) //51-Indicação
					aAdd(aCpo52[nInd1], TrbBMR->BMR_CODLAN) //52-Código do débito/crédito
					aAdd(aCpo53[nInd1], aTmpCpo35[1,1]) //53-Descrição do débito/crédito
					aAdd(aCpo54[nInd1], aTmpCpo35[1,2]) //54-Valor
					nValorDC += BMS->BMS_VLRPAG
				Else
					If BGQ->(MsSeek(xFilial("BGQ")+ BMS->(BMS_OPERDA + BMS_CODRDA + BMS_ANOLOT + BMS_MESLOT + BMS_CODSER + BMS_OPELOT + BMS_ANOLOT + BMS_MESLOT + BMS_NUMLOT )))
						If BGQ->BGQ_INCIR  == "1" .Or. BGQ->BGQ_INCINS == "1" .Or. BGQ->BGQ_INCPIS == "1" .Or.;
							BGQ->BGQ_INCCOF == "1" .Or. BGQ->BGQ_INCCSL == "1"
							aAdd(aCpo43[nInd1], TrbBMR->BMR_DEBCRE) //43-Indicação
							aAdd(aCpo44[nInd1], TrbBMR->BMR_CODLAN) //44-Código do débito/crédito
							aAdd(aCpo45[nInd1], Posicione("BBB", 1, xFilial("BBB")+BMS->BMS_CODSER, "BBB_DESCRI")) //45-Descrição do débito/crédito
							aAdd(aCpo46[nInd1], BMS->BMS_VLRPAG) //46-Valor
							If BMS->BMS_DEBCRE == "1"
								nDeb += BMS->BMS_VLRPAG
							else
								nCred += BMS->BMS_VLRPAG
							Endif
						Else
							aAdd(aCpo47[nInd1], TrbBMR->BMR_DEBCRE) //47-Indicação
							aAdd(aCpo48[nInd1], TrbBMR->BMR_CODLAN) //48-Código do débito/crédito
							aAdd(aCpo49[nInd1], Posicione("BBB", 1, xFilial("BBB")+BMS->BMS_CODSER, "BBB_DESCRI")) //49-Descrição do débito/crédito
							aAdd(aCpo50[nInd1], BMS->BMS_VLRPAG) //50-Valor
							If BMS->BMS_DEBCRE == "1"
								nDebNT += BMS->BMS_VLRPAG
							else
								nCredNT += BMS->BMS_VLRPAG
							Endif
						EndIf
					EndIf
				EndIf

				BMS->(dbSkip())

			EndDo
		ElseIf TrbBMR->BMR_CODLAN <> "101" .And. TrbBMR->BMR_DEBCRE <> "3"

			If Len(CalcImp(TrbBMR->BMR_VLRPAG)) > 0
				//aAdd(aCpo35[nInd1], {IIf(TrbBMR->BMR_DEBCRE == "1", "(-) ", "(+) ") + TrbBMR->BMR_CODLAN + " - " + Posicione("BLR", 1, xFilial("BLR")+TrbBMR->(BMR_OPELOT+BMR_CODLAN),"BLR_DESCRI"),   TrbBMR->BMR_VLRPAG })
				aTmpCpo35 := CalcImp(TrbBMR->BMR_VLRPAG)
				aAdd(aCpo51[nInd1], TrbBMR->BMR_DEBCRE) //51-Indicação
				aAdd(aCpo52[nInd1], TrbBMR->BMR_CODLAN) //52-Código do débito/crédito
				aAdd(aCpo53[nInd1], aTmpCpo35[1,1]) //53-Descrição do débito/crédito
				aAdd(aCpo54[nInd1], aTmpCpo35[1,2]) //54-Valor
				nValorDC += TrbBMR->BMR_VLRPAG
			Else
				If TrbBMR->BMR_CODLAN < "170"
					aAdd(aCpo47[nInd1], TrbBMR->BMR_DEBCRE) //47-Indicação
					aAdd(aCpo48[nInd1], TrbBMR->BMR_CODLAN) //48-Código do débito/crédito
					aAdd(aCpo49[nInd1], Posicione("BLR", 1, xFilial("BLR")+TrbBMR->(BMR_OPELOT+BMR_CODLAN),"BLR_DESCRI")) //49-Descrição do débito/crédito
					aAdd(aCpo50[nInd1], TrbBMR->BMR_VLRPAG) //50-Valor

					If BMS->BMS_DEBCRE == "1"
						nDebNT += TrbBMR->BMR_VLRPAG
					else
						nCredNT += TrbBMR->BMR_VLRPAG
					Endif
				Else
					aAdd(aCpo43[nInd1], TrbBMR->BMR_DEBCRE) //43-Indicação //
					aAdd(aCpo44[nInd1], TrbBMR->BMR_CODLAN) //44-Código do débito/crédito
					aAdd(aCpo45[nInd1], Posicione("BLR", 1, xFilial("BLR")+TrbBMR->(BMR_OPELOT+BMR_CODLAN),"BLR_DESCRI")) //45-Descrição do débito/crédito
					aAdd(aCpo46[nInd1], TrbBMR->BMR_VLRPAG) //46-Valor
					If TrbBMR->BMR_DEBCRE == "1"
						nDeb += TrbBMR->BMR_VLRPAG
					else
						nCred += TrbBMR->BMR_VLRPAG
					Endif
				EndIf
			EndIf
		EndIf
		TrbBMR->(dbSkip())
	EndDo

	//Demais débitos / créditos
	aAdd(aDados, aCpo43) //43-Indicação
	aAdd(aDados, aCpo44) //44-Código do débito/crédito
	aAdd(aDados, aCpo45) //45-Descrição do débito/crédito
	aAdd(aDados, aCpo46) //46-Valor

	//Demais débitos / créditos não tributáveis
	aAdd(aDados, aCpo47) //47-Indicação
	aAdd(aDados, aCpo48) //48-Código do débito/crédito
	aAdd(aDados, aCpo49) //49-Descrição do débito/crédito
	aAdd(aDados, aCpo50) //50-Valor

	//Impostos
	aAdd(aDados, aCpo51) //51-Indicação
	aAdd(aDados, aCpo52) //52-Código do débito/crédito
	aAdd(aDados, aCpo53) //53-Descrição do débito/crédito
	aAdd(aDados, aCpo54) //54-Valor

	//Totais
	aAdd(aCpo55, nCred-nDeb)
	aAdd(aDados, aCpo55) //55 - Valor Total Tributável (R$)
	aAdd(aCpo56, nValorDC)
	aAdd(aDados, aCpo56) //56- Valor Total Impostos Retidos (R$)
	aAdd(aCpo57, nCredNT-nDebNT)
	aAdd(aDados, aCpo57) //57 - Valor Total Não Tributável (R$)
	aAdd(aCpo58, ((nCred-nDeb)+(nCredNT-nDebNT)))
	aAdd(aDados, aCpo58) //58 - Valor Final a Receber (R$)

	aAdd(aCpo59, "")
	aAdd(aDados, aCpo59) //59 - Observação

	//numeroGuiaOperadora, recurso e nome do profissional executante
	aAdd(aDados, aCpo60)
	aAdd(aDados, aCpo61)
	aAdd(aDados, aCpo62)

EndDo
TrbBMR->(DbCloseArea())

Return aDados
*/
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡ao    ?RetProTiss?Autor ?Totvs                 ?Data ?13.05.15 ³±?
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡ao ?Retorna Procedimento DEPARA  							   ³±?
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±?Uso      ?SigaPLS                                                     ³±?
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros?cCodPad - Código da Tabela Padrao                             ³±?
±±?         ?cCodPro  - Código do Procedimento			               ³±?
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*//*
Function RetProTiss(cCodPad,cCodPro)
Local cTabPro := GetNewPar("MV_PLTABPR","00,90,98") // Tabelas Proprias.
Local lAchou  := .F.

BR8->(dbSetOrder(1))
BR8->(dbSeek(xFilial("BR8")+cCodPad+cCodPro))

cCodPad := Alltrim(BR8->BR8_CODPAD)
cCodPro := Alltrim(BR8->BR8_CODPSA)

SIX->(DbSetOrder(1))
If SIX->(MsSeek("BTU7"))
	// Para otimizar ja vou direto BTU
	BTU->(dbSetOrder(7))//BTU_FILIAL+BTU_ALIAS+BTU_VLRSIS+BTU_CODTAB
	If BTU->(dbSeek(xFilial("BTU")+"BR8"+BR8->(BR8_FILIAL+BR8_CODPAD+BR8_CODPSA)))
		cCodPad := Alltrim(BTU->BTU_CODTAB)
		cCodPro := Alltrim(BTU->BTU_CDTERM)
		lAchou := .T.
	Endif
Endif
If !lAchou
	BTU->(dbSetOrder(2))//BTU_FILIAL, BTU_CODTAB, BTU_ALIAS, BTU_VLRSIS
	If BTU->(dbSeek(xFilial("BTU")+"87"+"BR4"+BR8->(BR8_FILIAL+BR8_CODPAD)))
		While !BTU->(Eof()) .And. BTU->(BTU_FILIAL+BTU_CODTAB+BTU_ALIAS+BTU_VLRSIS);
			= xFilial("BTU")+"87"+"BR4"+BR8->(BR8_FILIAL+BR8_CODPAD)

			cCodPad := Alltrim(BTU->BTU_CDTERM)
			// se for tabela Propria nao tem BTQ
			If cCodPad $ cTabPro
				lAchou := .T.
			Else
				//verifica se encontra procedimento no cadastro de Itens e portanto nao necessita Depara
				BTQ->(dbSetOrder(1))//BTQ_FILIAL, BTQ_CODTAB, BTQ_CDTERM
				If BTQ->(dbSeek(xFilial("BTQ")+cCodPad+Alltrim(BR8->BR8_CODPSA)))
					lAchou := .T.
				Endif
			Endif
			// Se encontrou Sai Loop
			If lAchou
				Exit
			Endif
		 	BTU->(dbSkip())
		End
	Endif
Endif

Return({lAchou,cCodPad,cCodPro})*/
