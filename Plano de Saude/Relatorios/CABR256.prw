
#INCLUDE "PROTHEUS.CH"
#INCLUDE "PLSMGER.CH"
#INCLUDE "TOPCONN.CH"
#INCLUDE "TBICONN.CH"
#INCLUDE "fileio.ch"
//#INCLUDE "plstiss.ch"

#DEFINE	cLogoGH	GetNewPar("MV_PLSRELO","")
#DEFINE	 IMP_PDF 6
#DEFINE	 TAM_CUSTOM 0 		//Tamanho customizavel pelo usuario, informado em nHeight/nWidth. Aplicavel apenas em impressoes do tipo PDF. oficio 2 216 x 330
#DEFINE	 TAM_CARTA 1 		//Letter   	216mm x 279mm  637 x 823
#DEFINE	 TAM_TABLOID 3 		//Tabloid  	279mm x 432mm  823 x 1275
#DEFINE	 TAM_EXECUTIVE 7	//Executive 184mm x 267mm  543 x 788
#DEFINE	 TAM_A3 8			//A3     	297mm x 420mm  876 x 1240
#DEFINE	 TAM_A4 9			//A4     	210mm x 297mm  620 x 876
#DEFINE pMoeda1 "@E 999,999.99"
#DEFINE pMoeda2 "@E 999,999,999.99"
#Define __NTAM1  10
#Define __NTAM2  25
#Define __NTAM3  40
#Define __NTAM4  10
#Define __NTAM5  20
#Define __NTAM6  10
#Define __NTAM7  5
#Define __NTAM8  15
#Define __NTAM9  15
#Define __NTAM10 15
#define lSrvUnix IsSrvUnix()

#define __aCdCri049 {"020","O valor contratato e diferente do valor informado/apresentado."}

//-------------------------------------------------------------------
/*/{Protheus.doc} CABR256
Estatistica de parto 

@author  Mateus Medeiros
@version P11
@since   05.06.2018
/*/
//-------------------------------------------------------------------
User function CABR256(cCodOpe, cCodRdaHC, cCodRdaM, lWeb, cPathSrv)

local cFileLogo	:= GetNewPar("MV_PLSRELO","")
local cFileName	:= ''
local cMsg		:= ''
local cRel      := "estpart"
local lContinua	:= .t.
local oFont01	:= nil
local oFont02n	:= nil
local oFont03n	:= nil
local oFont04	:= nil
local oFont05n	:= nil
local oPrint	:= nil
local nLinMax	:= 0
local nColMax	:= 0
local nLinIni	:= 0		// Linha Lateral (inicial) Esquerda
local nColIni	:= 0		// Coluna Lateral (inicial) Esquerda
local nColA4    := 0
local nWeb		:= 0
local nTweb		:= 1
local nLweb		:= 0
local nLwebC	:= 0
local aDados  	:= {} 
local cPerg 	:= "PLSREPA"
default cCodOpe		:= ''
default cCodRdaHC	:= ''
default cCodRdaM	:= ''	
default lWeb		:= .f.	
default cPathSrv 	:= getMV("MV_RELT")		 

cTitulo	 :=  "Estatística de Partos"

if !lWeb
	//Tratamento no SX1
	CriaSX1(cPerg)
	//Acessa parametros do relatorio...
	if !pergunte(cPerg,.T.)
		return
	endIf

	cCodOpe		:= mv_par01
	cCodRdaHC	:= mv_par02
	cCodRdaM	:= mv_par03
endIf
					 
//processa requisicao
if !lWeb					 
	msAguarde( {|| aadd(aDados, U_CABR256A(cCodOpe, cCodRdaHC, cCodRdaM) ) }, cTitulo, "Aguarde...", .t.)
else
	aadd(aDados, U_CABR256A(cCodOpe, cCodRdaHC, cCodRdaM) )
endIf

//exemplo do relatorio
/*aDados := { {	"123456",; //1 - Protocolo
				dtoc(date()) + ' às ' + time(),; //2 - Data e hora
				'2015',; //3 - Ano
				{"Nome da Operadora",10,10},; //4 - nome da opradora-parto nomal-parto cesarea
				{"Nome do estabelecimento",10,10},; //5 - nome do estabelecimento-parto nomal-parto cesarea
				{"Nome do Medico",10,10} } } //6 - nome do medico-parto nomal-parto cesarea
*/

if len(aDados[1]) == 0
	if !lWeb
		msgAlert("Não foi encontrado registro ou não informado os eventos de parto e cesárea")
	else
		cMsg := "Não foi encontrado registro ou não informado os eventos de parto e cesárea"
	endIf
	lContinua := .f.
endIf

if lContinua
	//preparando para impressao	 
	nLinMax	:=	2275
	nColMax	:=	3270
	
	oFont01 := TFont():New("Arial",  6,  6, , .F., , , , .T., .F.) // Normal
	oFont02n:= TFont():New("Arial", 11, 11, , .T., , , , .T., .F.) // Negrito
	oFont03n:= TFont():New("Arial", 13, 13, , .T., , , , .T., .F.) // Negrito
	oFont04	:= TFont():New("Arial", 12, 12, , .F., , , , .T., .F.) // Normal
	oFont05n:= TFont():New("Arial", 20, 20, , .T., , , , .T., .F.) // Negrito
	
	//Nao permite acionar a impressao quando for na web.
	if lWeb
		cFileName := cRel+lower(CriaTrab(NIL,.F.))+".pdf"
	else
		cFileName := cRel+CriaTrab(NIL,.F.)
	endIf
	
	//New ( < cFilePrintert >, [ nDevice], [ lAdjustToLegacy], [ cPathInServer], [ lDisabeSetup ], [ lTReport], [ @oPrintSetup], [ cPrinter], [ lServer], [ lPDFAsPNG], [ lRaw], [ lViewPDF] )
	nH := PLSAbreSem("PPLSESTPAR.SMF")
	if lWeb
		oPrint := FWMSPrinter():New( cFileName,,.f.,cPathSrv,.t.,,@oPrint,,,.f.,.f.)
	else	
		oPrint := FWMSPrinter():New( cFileName,,.f.,cPathSrv,.t.,,,,,.f.,,)
	endIf
	PLSFechaSem(nH,"PPLSESTPAR.SMF")
	                                                                 	
	oPrint:lServer 	:= lWeb
	oPrint:cPathPDF	:= cPathSrv
	if lSrvUnix
		ajusPath(@oPrint)
	endIf
	
	nTweb	:= 3.9
	nLweb	:= 10
	nLwebC	:= -3
	nWeb	:= 25
	nColMax := iIf(lWeb,2980,3100)
	
	oPrint:setLandscape()// Modo paisagem
	oPrint:setPaperSize(9)// Papél A4
	
	//Device
	if lWeb
		oPrint:setDevice(IMP_PDF)
	else
		oPrint:Setup()
		if !(oPrint:nModalResult == 1)// Botao cancelar da janela de config. de impressoras.
			return
		endif
	endif
	
	nLinIni := 080
	nColIni := 080
	nColA4  := 000
	
	//Inicia uma nova pagina	
	oPrint:startPage()		
	
	//Box Principal                                                 
	oPrint:box((nLinIni + 0000)/nTweb, (nColIni + 0000)/nTweb, (nLinIni + nLinMax)/nTweb, (nColIni + nColMax)/nTweb)
	
	//Carrega e Imprime Logotipo da Empresa                      
	fLogoEmp(@cFileLogo)
	
	if file(cFilelogo)
		oPrint:SayBitmap((nLinIni + 0050)/nTweb, (nColIni + 0020)/nTweb, cFileLogo, (400)/nTweb, (090)/nTweb) 		// Tem que estar abaixo do RootPath
	endIf
				
	nColA4 := -0335
	
	oPrint:Say((nLinIni + 0080)/nTweb, ((nColIni + nColMax)*0.39)/nTweb, OemToAnsi("Informação sobre Partos"), oFont05n,,,, 2) //"Informação sobre Partos"
	
	fSomaLin(nLinMax, nColMax, @nLinIni, nColIni, 80, 80)
	
	oPrint:Say((nLinIni + 0070)/nTweb, (nColMax - 689)/nTweb, "Protocolo", oFont03n) //"Protocolo"
	oPrint:Say((nLinIni + 0070)/nTweb, (nColMax - 480)/nTweb, aDados[1,1], oFont04)

	fSomaLin(nLinMax, nColMax, @nLinIni, nColIni, 50, 80)
	
	oPrint:Say((nLinIni + 0070)/nTweb, (nColMax - 722)/nTweb, "Data e Hora:", oFont03n) //"Data e Hora:"
	oPrint:Say((nLinIni + 0070)/nTweb, (nColMax - 480)/nTweb, aDados[1,2], oFont04)
	
	fSomaLin(nLinMax, nColMax, @nLinIni, nColIni, 50, 80)
				
	oPrint:Say((nLinIni + 0070)/nTweb, (nColMax - 820)/nTweb, "Referente ao ano:", oFont03n)// "Referente ao ano:"
	oPrint:Say((nLinIni + 0070)/nTweb, (nColMax - 480)/nTweb, aDados[1,3], oFont04)
				
	fSomaLin(nLinMax, nColMax, @nLinIni, nColIni, 30, 80)
	
//	oPrint:Say((nLinIni + 197)/nTweb, (nColIni + 0020)/nTweb, space(50) + OemToAnsi("Descrição") + space(80) + OemToAnsi("Partos Normais") + space(80) + OemToAnsi("Cirurgias Cesá reas"), oFont04)//"Descrição" + space(10) + "Partos Normais" + space(10) + "Cirurgias Cesáreas"
	oPrint:Say((nLinIni + 197)/nTweb, (nColIni + 200)/nTweb, OemToAnsi(space(50))  +"Descrição" 		, oFont04)//"Descrição" + space(10) + "Partos Normais" + space(10) + "Cirurgias Cesáreas"
	oPrint:Say((nLinIni + 197)/nTweb, (nColIni + 970)/nTweb, OemToAnsi(space(50))  +"Partos Normais"  	, oFont04)//"Descrição" + space(10) + "Partos Normais" + space(10) + "Cirurgias Cesáreas"
	oPrint:Say((nLinIni + 197)/nTweb, (nColIni + 2050)/nTweb, OemToAnsi(space(50)) +"Cirurgias Cesáreas", oFont04)//"Descrição" + space(10) + "Partos Normais" + space(10) + "Cirurgias Cesáreas"
	
	//AddTBrush(oPrint, (nLinIni + 215)/nTweb, (nColIni + 0010)/nTweb, (nLinIni + 216)/nTweb, (nColIni + nColMax)/nTweb)
	
	fSomaLin(nLinMax, nColMax, @nLinIni, nColIni, 40, 80)
				
	oPrint:Say((nLinIni + 235)/nTweb, (nColIni + 0020)/nTweb, "Operadora", oFont03n) //"Operadora"
	oPrint:Say((nLinIni + 235)/nTweb, (nColIni + 500)/nTweb, aDados[1,4,1], oFont04)
	oPrint:Say((nLinIni + 235)/nTweb, (nColIni + 1550)/nTweb, transform(aDados[1,4,2], "@E 999.99") + " %", oFont04)
	oPrint:Say((nLinIni + 235)/nTweb, (nColIni + 2700)/nTweb, transform(aDados[1,4,3], "@E 999.99") + " %", oFont04)
				
	fSomaLin(nLinMax, nColMax, @nLinIni, nColIni, 100, 80)
	
	oPrint:Say((nLinIni + 235)/nTweb, (nColIni + 0020)/nTweb, "Hospital:", oFont03n)//"Hospital:"
	oPrint:Say((nLinIni + 235)/nTweb, (nColIni + 500)/nTweb, aDados[1,5,1], oFont04)
	oPrint:Say((nLinIni + 235)/nTweb, (nColIni + 1550)/nTweb, transform(aDados[1,5,2], "@E 999.99") + " %", oFont04)
	oPrint:Say((nLinIni + 235)/nTweb, (nColIni + 2700)/nTweb, transform(aDados[1,5,3], "@E 999.99") + " %", oFont04)
	
	fSomaLin(nLinMax, nColMax, @nLinIni, nColIni, 100, 80)
				
	oPrint:Say((nLinIni + 235)/nTweb, (nColIni + 0020)/nTweb, OemToAnsi("Médico:"), oFont03n) //"Médico:"
	oPrint:Say((nLinIni + 235)/nTweb, (nColIni + 500)/nTweb, aDados[1,6,1], oFont04)
	oPrint:Say((nLinIni + 235)/nTweb, (nColIni + 1550)/nTweb, transform(aDados[1,6,2], "@E 999.99") + " %", oFont04)
	oPrint:Say((nLinIni + 235)/nTweb, (nColIni + 2700)/nTweb, transform(aDados[1,6,3], "@E 999.99") + " %", oFont04)
				
	fSomaLin(nLinMax, nColMax, @nLinIni, nColIni,300, 80)
	
	oPrint:say((nLinIni + 195)/nTweb, (nColIni + 0020)/nTweb, OemToAnsi("Informações referem-se ao dados vinculados apenas aos partos efetuados pela Operadora acima."), oFont03n) //"Informações referem-se ao dados vinculados apenas aos partos efetuados pela Operadora acima."
	
	oPrint:endPage() //Finaliza a pagina
	
	if lWeb
		oPrint:Print()
	else	
		oPrint:Preview()
	endIf	
endIf

return( { cFileName, cMsg } )
                                  
Static Function AjusPath(oPrint)      
oPrint:cPathPDF := StrTran(oPrint:cPathPDF,"\","/",1)
oPrint:cFilePrint := StrTran(oPrint:cFilePrint,"\","/",1)
oPrint:cPathPrint := StrTran(oPrint:cPathPrint,"\","/",1)
oPrint:cFilePrint := StrTran(oPrint:cFilePrint,"//","/",1)
oPrint:cPathPrint := StrTran(oPrint:cPathPrint,"//","/",1)
oPrint:cPathPDF := StrTran(oPrint:cPathPDF,"//","/",1)
Return

//-------------------------------------------------------------------
/*/{Protheus.doc} U_CABR256A
Estatistica de partos

@author  Mateus Medeiros
@version P11
@since   05.06.18
/*/
//-------------------------------------------------------------------
User function CABR256A(cCodOpe, cCodRdaHC, cCodRdaM)
local nI	  := 0
local aDados  := {}
local aCpo01  := {}
local aCpo02  := {}
local aCpo03  := {}
local cAno	  := cValToChar(iif(month(dDataBase) > 3,(year(dDataBase)-1),(year(dDataBase)-2)))//maior que marco pega o ano anterior menor dois anos
local cQuery  := ''
local cCodPro := ''
local cCodProP:= ''
local cCodProC:= ''
local cRegPre := ''
local cCodTPA := 'H'
local nTotOpeP:= 0
local nTotOpeC:= 0
local nTotHosP:= 0
local nTotHosC:= 0
local nTotMedP:= 0
local nTotMedC:= 0
local lField  := BR8->(fieldPos("BR8_PARTNC"))>0

if !lField
	QOut('Campo [BR8_PARTNC] não existe no dicionario de dados!')
	return aDados
endIf

cQuery := " SELECT BR8_CODPSA,BR8_PARTNC "
cQuery += " FROM " + retSqlName("BR8")
cQuery += " WHERE BR8_FILIAL = '" + xFilial('BR8') + "' " 
cQuery += "   AND BR8_PARTNC <> '' "
cQuery += "   AND D_E_L_E_T_ <> '*' "

dbUseArea(.T., "TOPCONN", TCGenQry( , , changeQuery(cQuery)), "RN368", .F., .T.)

 while !RN368->(eof())
 	
 	if RN368->BR8_PARTNC == '0'
		cCodProP += "'" + allTrim(RN368->BR8_CODPSA) + "',"
	else
		cCodProC += "'" + allTrim(RN368->BR8_CODPSA) + "',"
 	endIf	
 
 RN368->(dbSkip())
 endDo

RN368->(dbCloseArea())

//se nao exister nenhuma parametrizacao de evento na br8 retorna
if empty(cCodProP) .and. empty(cCodProC)
	return aDados
endIf

//1 = parto, 2 = cesaria
for nI := 1 to 2

	//parto
	if nI == 1
		cCodPro := left(cCodProP,len(cCodProP)-1) 
	//cesaria
	else
		cCodPro := left(cCodProC,len(cCodProC)-1)
	endIf

	if empty(cCodPro)
		return aDados
	endIf
	
	cQuery := " SELECT COUNT(DISTINCT BD6_OPEUSR||BD6_CODEMP||BD6_MATRIC||BD6_TIPREG ) AS COUNT "
	cQuery += " FROM " + retSqlName("BD6")
	cQuery += " WHERE BD6_FILIAL = '" + xFilial('BD6') + "' " 
	cQuery += "   AND BD6_FASE 	= '4' "
	cQuery += "   AND BD6_ANOPAG = '" + cAno +  "' "
	
	if at(',',cCodPro) > 0
		cQuery += "  AND BD6_CODPRO in(" + cCodPro + ") "
	else
		cQuery += "  AND BD6_CODPRO = " + cCodPro
	endIf	
	cQuery += "  AND D_E_L_E_T_ <> '*' "
	cQuery += "  AND BD6_CODOPE = '" + cCodOpe + "' "
	
	dbUseArea(.T., "TOPCONN", TCGenQry( , , changeQuery(cQuery)), "RN368", .F., .T.)
	
	if !RN368->(eof()) .and. RN368->COUNT > 0
		if nI == 1
			nTotOpeP := RN368->COUNT
		else
			nTotOpeC := RN368->COUNT
		endIf	
		RN368->(dbCloseArea())
	
		//hospital
		if !empty(cCodRdaHC) 
			cQuery += "  AND BD6_CODRDA = '" + cCodRdaHC + "' "
			
			dbUseArea(.T., "TOPCONN", TCGenQry( , , changeQuery(cQuery)), "RN368", .F., .T.)
		
			if !RN368->(eof())
				if nI == 1
					nTotHosP := RN368->COUNT
				else
					nTotHosC := RN368->COUNT
				endIf	
			endIf
			RN368->(dbCloseArea())
		endIf
		
		//medico olho no BD7
		if !empty(cCodRdaM) 
			
			cRegPre := allTrim(posicione("BAU",1,xFilial("BAU")+cCodRdaM,"BAU_CONREG"))
			
			cQuery := " SELECT COUNT(DISTINCT BD7_OPEUSR||BD7_CODEMP||BD7_MATRIC||BD7_TIPREG ) AS COUNT "
			cQuery += " FROM " + retSqlName("BD7")
			cQuery += " WHERE BD7_FILIAL = '" + xFilial('BD7') + "' " 
			cQuery += "   AND BD7_FASE 	= '4' "
			cQuery += "   AND BD7_ANOPAG = '" + cAno +  "' "
			
			if at(',',cCodPro) > 0
				cQuery += "  AND BD7_CODPRO in(" + cCodPro + ") "
			else
				cQuery += "  AND BD7_CODPRO = " + cCodPro
			endIf	
			
			cQuery += "  AND D_E_L_E_T_ <> '*' "
			cQuery += "  AND BD7_CODOPE = '" + cCodOpe + "' "
			cQuery += "  AND BD7_CODRDA = '" + cCodRdaM + "' "
			cQuery += "  AND BD7_CODTPA = '" + cCodTPA 	+ "' "
	
			dbUseArea(.T., "TOPCONN", TCGenQry( , , changeQuery(cQuery)), "RN368", .F., .T.)
		
			if !RN368->(eof())
				if nI == 1
					nTotMedP := RN368->COUNT
				else
					nTotMedC := RN368->COUNT
				endIf	
			endIf
			RN368->(dbCloseArea())
		endIf
	else
		RN368->(dbCloseArea())	
	endIf
next	

if nTotOpeP > 0 .or. nTotOpeC > 0
	aAdd(aDados, strZero(randomize( 0, 10000000 ),8) )
	aAdd(aDados, dtoc(date()) + ' às ' + time())
	aAdd(aDados, cAno)
	
	aAdd(aCpo01, posicione("BA0",1,xFilial("BA0")+cCodOpe,"BA0_NOMINT"))
	aAdd(aCpo01, (nTotOpeP/(nTotOpeP+nTotOpeC))*100 )
	aAdd(aCpo01, (nTotOpeC/(nTotOpeC+nTotOpeP))*100 )
	
	aAdd(aCpo02, iif( empty(cCodRdaHC),replicate('*',20),posicione("BAU",1,xFilial("BAU")+cCodRdaHC,"BAU_NOME") ) )
	aAdd(aCpo02,(nTotHosP/(nTotHosP+nTotHosC))*100)
	aAdd(aCpo02, (nTotHosC/(nTotHosC+nTotHosP))*100 )
	
	aAdd(aCpo03, iif( empty(cCodRdaM),replicate('*',20),posicione("BAU",1,xFilial("BAU")+cCodRdaM,"BAU_NOME") ) )
	aAdd(aCpo03, (nTotMedP/(nTotMedP+nTotMedC))*100 )
	aAdd(aCpo03, (nTotMedC/(nTotMedC+nTotMedP))*100 )
	
	aAdd(aDados,aCpo01) 	
	aAdd(aDados,aCpo02) 	
	aAdd(aDados,aCpo03)
endIf	


return aDados


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa   ³ CriaSX1   ³ Autor ³ Totvs			     ³ Data ³ 22.03.07 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao  ³ Atualiza SX1                                               ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
/*/
static function CriaSX1(cPerg)
LOCAL aRegs	:=	{}

SX1->(dbSetOrder(1))
if !SX1->( msSeek(cPerg) )
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
	//³Tratamento para possivel ajuste no sx1
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
    do case
    	case cPerg == "PLSRELDPM"
			aadd(aRegs,{cPerg,"01","Operadora ?"             ,"","","mv_ch1","C", 4,0,0,"G","","mv_par01",""        ,"","","","",""        ,"","","","",""           ,"","","","","","","","","","","","","",IIf(PlsGetVersao() >= 8,"B89PLS","B89"),""})
			aadd(aRegs,{cPerg,"02","RDA De ?"                ,"","","mv_ch2","C", 6,0,0,"G","","mv_par02",""        ,"","","","",""        ,"","","","",""           ,"","","","","","","","","","","","","",IIf(PlsGetVersao() >= 8,"BAUPLS","BAU"),""})
			aadd(aRegs,{cPerg,"03","RDA Até ?"               ,"","","mv_ch3","C", 6,0,0,"G","","mv_par03",""        ,"","","","",""        ,"","","","",""           ,"","","","","","","","","","","","","",IIf(PlsGetVersao() >= 8,"BAUPLS","BAU"),""})
			aadd(aRegs,{cPerg,"04","Ano Base ?"              ,"","","mv_ch4","C", 4,0,0,"G","","mv_par04",""        ,"","","","",""        ,"","","","",""           ,"","","","","","","","","","","","","",""                                      ,""})
			aadd(aRegs,{cPerg,"05","Mês Base ?"              ,"","","mv_ch5","C", 2,0,0,"G","","mv_par05",""        ,"","","","",""        ,"","","","",""           ,"","","","","","","","","","","","","",""                                      ,""})
    	case cPerg == "PLSRELDAC"
			aadd(aRegs,{cPerg,"01","Operadora ?"             ,"","","mv_ch1","C", 4,0,0,"G","","mv_par01",""        ,"","","","",""        ,"","","","",""           ,"","","","","","","","","","","","","",IIf(PlsGetVersao() >= 8,"B89PLS","B89"),""})
			aadd(aRegs,{cPerg,"02","RDA De ?"                ,"","","mv_ch2","C", 6,0,0,"G","","mv_par02",""        ,"","","","",""        ,"","","","",""           ,"","","","","","","","","","","","","",IIf(PlsGetVersao() >= 8,"BAUPLS","BAU"),""})
			aadd(aRegs,{cPerg,"03","RDA Até ?"               ,"","","mv_ch3","C", 6,0,0,"G","","mv_par03",""        ,"","","","",""        ,"","","","",""           ,"","","","","","","","","","","","","",IIf(PlsGetVersao() >= 8,"BAUPLS","BAU"),""})
			aadd(aRegs,{cPerg,"04","Ano Base ?"              ,"","","mv_ch4","C", 4,0,0,"G","","mv_par04",""        ,"","","","",""        ,"","","","",""           ,"","","","","","","","","","","","","",""                                      ,""})
			aadd(aRegs,{cPerg,"05","Mês Base ?"              ,"","","mv_ch5","C", 2,0,0,"G","","mv_par05",""        ,"","","","",""        ,"","","","",""           ,"","","","","","","","","","","","","",""                                      ,""})
    	case cPerg == "PLSRELDPO"
			aadd(aRegs,{cPerg,"01","Operadora ?"             ,"","","mv_ch1","C", 4,0,0,"G","","mv_par01",""        ,"","","","",""        ,"","","","",""           ,"","","","","","","","","","","","","",IIf(PlsGetVersao() >= 8,"B89PLS","B89"),""})
			aadd(aRegs,{cPerg,"02","RDA De ?"                ,"","","mv_ch2","C", 6,0,0,"G","","mv_par02",""        ,"","","","",""        ,"","","","",""           ,"","","","","","","","","","","","","",IIf(PlsGetVersao() >= 8,"BAUPLS","BAU"),""})
			aadd(aRegs,{cPerg,"03","RDA Até ?"               ,"","","mv_ch3","C", 6,0,0,"G","","mv_par03",""        ,"","","","",""        ,"","","","",""           ,"","","","","","","","","","","","","",IIf(PlsGetVersao() >= 8,"BAUPLS","BAU"),""})
			aadd(aRegs,{cPerg,"04","Ano Base ?"              ,"","","mv_ch4","C", 4,0,0,"G","","mv_par04",""        ,"","","","",""        ,"","","","",""           ,"","","","","","","","","","","","","",""                                      ,""})
			aadd(aRegs,{cPerg,"05","Mês Base ?"              ,"","","mv_ch5","C", 2,0,0,"G","","mv_par05",""        ,"","","","",""        ,"","","","",""           ,"","","","","","","","","","","","","",""                                      ,""})
    	case cPerg == "PLSRELEPM"
			aadd(aRegs,{cPerg,"01","Operadora ?"             ,"","","mv_ch1","C", 4,0,0,"G","","mv_par01",""        ,"","","","",""        ,"","","","",""           ,"","","","","","","","","","","","","",IIf(PlsGetVersao() >= 8,"B89PLS","B89"),""})
			aadd(aRegs,{cPerg,"02","RDA?"                    ,"","","mv_ch2","C", 6,0,0,"G","","mv_par02",""        ,"","","","",""        ,"","","","",""           ,"","","","","","","","","","","","","",IIf(PlsGetVersao() >= 8,"BAUPLS","BAU"),""})
			aadd(aRegs,{cPerg,"04","Ano Base ?"              ,"","","mv_ch3","C", 4,0,0,"G","","mv_par03",""        ,"","","","",""        ,"","","","",""           ,"","","","","","","","","","","","","",""                                      ,""})
			aadd(aRegs,{cPerg,"05","Mês Base ?"              ,"","","mv_ch4","C", 2,0,0,"G","","mv_par04",""        ,"","","","",""        ,"","","","",""           ,"","","","","","","","","","","","","",""                                      ,""})
		case cPerg == "PLSREPA"
			aadd(aRegs,{cPerg,"01","Operadora:","","","mv_ch1" ,"C", 4,0,0,"G","NaoVazio() .and. ExistCPO('BA0')","mv_par01","","","","","","","","","","","","","","","","","","","","","","","","","B89PLS",""})//"Operadora:"
			aadd(aRegs,{cPerg,"02","Hospitals:","","","mv_ch2" ,"C", 6,0,0,"G","vazio() .or. ExistCpo('BAU')","mv_par02","","","","","","","","","","","","","","","","","","","","","","","","","BVLPL2",""})//"Hospitals:"
			aadd(aRegs,{cPerg,"03","Médico:","","","mv_ch3" ,"C", 6,0,0,"G","vazio() .or. ExistCpo('BAU')","mv_par03","","","","","","","","","","","","","","","","","","","","","","","","","BVLPLS",""})//"Médico:"
					
     endCase
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
	//³atualiza
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
	PlsVldPerg(aRegs)
endIf
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
//³Fim da Rotina
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
return
