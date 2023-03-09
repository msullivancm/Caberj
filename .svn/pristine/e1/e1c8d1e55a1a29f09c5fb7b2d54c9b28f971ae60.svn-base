#INCLUDE "rwmake.ch"
#include "Msole.CH"
#include "TopCOnn.CH"

#define DMPAPER_LETTER 1 // Letter 8 1/2 x 11 in
#define DMPAPER_LETTERSMALL 2 // Letter Small 8 1/2 x 11 in
#define DMPAPER_TABLOID 3 // Tabloid 11 x 17 in
#define DMPAPER_LEDGER 4 // Ledger 17 x 11 in
#define DMPAPER_LEGAL 5 // Legal 8 1/2 x 14 in
#define DMPAPER_EXECUTIVE 7 // Executive 7 1/4 x 10 1/2 in
#define DMPAPER_A3 8 // A3 297 x 420 mm
#define DMPAPER_A4 9 // A4 210 x 297 mm
#define DMPAPER_A4SMALL 10 // A4 Small 210 x 297 mm
#define DMPAPER_A5 11 // A5 148 x 210 mm
#define DMPAPER_B4 12 // B4 250 x 354
#define DMPAPER_B5 13 // B5 182 x 257 mm
#define DMPAPER_FOLIO 14 // Folio 8 1/2 x 13 in
#define DMPAPER_NOTE 18 // Note 8 1/2 x 11 in
#define DMPAPER_ENV_10 20 // Envelope #10 4 1/8 x 9 1/2

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABR003   º Autor ³ Luzio Tavares      º Data ³  28/02/08   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Gera relatorio com usuarios que perderao o direito ao planoº±±
±±º          ³ por completarem maior idade ou 24 anos na data passada comoº±±
±±º          ³ parametro.                                                 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ PLANO DE SAUDE                                             º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

User Function CABR003()

Local cAnoMes := ''
Local cDatAtual := SubStr(DtoS(dDataBase),1,6)

Local cEndCob := ""
Local cBaiCob := ""
Local cCidCob := ""
Local cUFCob  := ""
Local cCepCob := ""
Local cCodCli := ""
Local cLojCli := ""
Local cCodPla := "" 
Local cVerPla := ""
Local nIdade  := 0
Local cImp24  := ""

Local cCodPlaPos := ""
Local cVerPlaPos := ""
Local cDesPlaPos := ""
Local cCodDesEmp := ""
Local cConDesEmp := ""
Local cVerConDEm := ""
Local cSubDesEmp := ""
Local cVerSubDEm := ""		

Private cName  := RetSQLName("BG9")
Private cName1 := RetSQLName("BA1")
Private cPerg  := "CABR03"
Private nTusu  := 0
Private xUsu   := {}

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Ajusta perguntas                                                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
ValidPerg(cPerg)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Acessa parametros do relatorio...                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If !Pergunte(cPerg,.T.)
	Return
Endif

If Empty(MV_PAR02) .or. Empty(MV_PAR03)
	Return
EndIf

If !(MV_PAR14 >= 1 .and. MV_PAR14 <= 3)
	MsgStop("Número de colunas deve ser entre 1 e 3")
	Return
Endif

//cAnoMes := alltrim(str(val(substr(DtoS(MV_PAR03),1,4))-24))+substr(DtoS(MV_PAR03),5,2)
cAnoMes := substr(DtoS(MV_PAR03),1,6)

cSQL := "SELECT BA1.* "
cSQL += " FROM "+RetSQLName("BA1") + " BA1 "
cSQL += " WHERE BA1.BA1_FILIAL = '" + xFilial("BA1") + "' AND "
cSQL += " BA1.BA1_CODINT = '" + MV_PAR01 + "' AND "
cSQL += " BA1.BA1_CODEMP >= '"+ MV_PAR04 + "' AND BA1.BA1_CODEMP <= '"+ MV_PAR05 +"' AND "
cSQL += " BA1.BA1_CONEMP >= '"+ MV_PAR06 + "' AND BA1.BA1_CONEMP <= '"+ MV_PAR07 +"' AND "
cSQL += " BA1.BA1_SUBCON >= '"+ MV_PAR08 + "' AND BA1.BA1_SUBCON <= '"+ MV_PAR09 +"' AND "
cSQL += " BA1.BA1_CODPLA >= '"+ MV_PAR10 + "' AND BA1.BA1_CODPLA <= '"+ MV_PAR11 +"' AND "
cSQL += " BA1_OPEORI = '"+PlsIntPad()+"' AND "
//cSQL += " BA1_MOTBLO = '   ' AND "
cSQL += " (SUBSTR(BA1_DATBLO,1,6) >= '" + cDatAtual + "' OR BA1_DATBLO = '       ') AND "
//cSQL += " BA1_TIPREG <> '00' AND "
//cSQL += " SUBSTR(BA1_DATNAS,1,6) = '" + cAnoMes + "' AND "
cSQL += " SUBSTR(BA1_YDTLIM,1,6) = '" + cAnoMes + "' AND "
cSQL += " BA1.D_E_L_E_T_ <> '*' "
cSQL += " ORDER BY BA1_CODPLA, BA1_VERSAO, BA1_CODEMP, BA1_MATRIC, BA1_TIPREG, BA1_DIGITO"

memowrit("C:\CABR003.SQL",cSQL)

PLSQuery(cSQL,"CABR003")
DbSelectArea("CABR003")
CABR003->(DbGotop())
BA1->(DbSetOrder(2))

BA3->(DbSetOrder(1))
SA1->(DbSetOrder(1))


While !CABR003->(Eof())

	BA1->(DbSeek(xFilial("BA1")+CABR003->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC)+"00"))
	aInc := Year(CABR003->BA1_DATINC)
	aAtu := Year(MV_PAR02)
	
	BA3->(DbSeek(xFilial("BA1")+CABR003->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC)))	
	
	If BA3->BA3_COBNIV == "1"
	
		SA1->(MsSeek(xFilial("SA1")+BA3->(BA3_CODCLI+BA3_LOJA)))
	
		cEndCob	:= SA1->A1_END
		cBaiCob	:= SA1->A1_BAIRRO
		cCidCob	:= SA1->A1_MUN
		cUFCob	:= SA1->A1_EST
		cCepCob	:= SA1->A1_CEP
		cCodCli	:= SA1->A1_COD
		cLojCli	:= SA1->A1_LOJA
	Else	
		cEndCob	:= ""
		cBaiCob	:= ""
		cCidCob	:= ""
		cUFCob	:= ""
		cCepCob	:= ""
		cCodCli	:= ""
		cLojCli	:= ""			
	Endif
	
	nIdade := 0
	cImp24 := "2"
	If BRP->(MsSeek(xFilial("BRP")+CABR003->BA1_GRAUPA))
		If BRP->BRP_CODIGO $ GetNewPar("MV_YGRPAFI","05,06,12,13,23,24,25") .And. Calc_Idade(MV_PAR03,CABR003->BA1_DATNAS) == 24
			cImp24 := "1"
		Endif
	Endif
	
	If Empty(CABR003->BA1_CODPLA)
		cCodPla := BA3->BA3_CODPLA
		cVerPla := BA3->BA3_VERSAO		
	Else
		cCodPla := CABR003->BA1_CODPLA
		cVerPla := CABR003->BA1_VERSAO
	Endif
	
	BI3->(MsSeek(xFilial("BI3")+PLSINTPAD()+cCodPla+cVerPla))
	
	If BI3->(FieldPos("BI3_YPRPOS"))>0	
			
		nRegBI3 := BI3->(Recno())
		cCodPlaPos := BI3->BI3_YPRPOS
		cVerPlaPos := BI3->BI3_YVRPOS           
		cCodDesEmp := BI3->BI3_YCDEMP
		cConDesEmp := BI3->BI3_YCNEMP
		cVerConDEm := Alltrim(BI3->BI3_YVCNEM) //Devido ao erro na criacao do campo (tamanho 4 ao inves de 3)
		cSubDesEmp := BI3->BI3_YSBEMP
		cVerSubDEm := BI3->BI3_YVSBEM		
		cDesPlaPos := Posicione("BI3",1,xFilial("BI3")+PLSINTPAD()+cCodPlaPos+cVerPlaPos,"BI3_NREDUZ")		
		
		BI3->(DbGoTo(nRegBI3))		
		
	Else
		cCodPlaPos := "9999"
		cVerPlaPos := "999"
		cDesPlaPos := "CRIAR CAMPOS BI3_YPRPOS E BI3_YVRPOS"
	    cCodDesEmp := ""
	    cConDesEmp := ""
	    cVerConDEm := ""
	    cSubDesEmp := ""
	    cVerSubDEm := ""				
	Endif
	
	
	nPos := aScan(xUsu, {|x| x[2] == CABR003->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG+BA1_DIGITO)})
	
	If nPos = 0
		Aadd(xUsu,{BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG+BA1_DIGITO),;
		BA1->BA1_NOMUSR,;
		CABR003->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG+BA1_DIGITO),;
		CABR003->BA1_NOMUSR,;
		substr(BI3->BI3_NREDUZ,1,20),;
		substr(BRP->BRP_DESCRI,1,20),;
		CABR003->BA1_DATNAS,;
		DtoC(CABR003->BA1_YDTLIM),;
		CABR003->BA1_DATBLO,;
		cEndCob,;
		cBaiCob,;
		cCidCob,;
		cUFCob,;
		cCepCob,;
		cCodCli,;
		cLojCli,;
		cCodPlaPos,;
		cVerPlaPos,;
		cDesPlaPos,;
		cCodDesEmp,;
		cConDesEmp,;
		cVerConDEm,;
		cSubDesEmp,;
		cVerSubDEm,;
		cImp24 })
	Endif
		
	CABR003->(dbSkip())
	
EndDo

aSort(xUsu,,, { |x,y| x[25]+x[1]+x[3] < y[25]+y[1]+y[3] })

CABR003->(DbCloseArea())

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Emite relat¢rio                                                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
RptStatus({|lEnd| CABR003RPT() }, "Imprimindo relatorio de ocorrencias ...", "", .T.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Fim do programa                                                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Return()

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ CABR003RPT  ³ Autor ³ Luzio tavares      ³ Data ³ 28/02/08 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Imprime relatorio com os clientes                          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ CABR003RPT()                                               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ nenhum                                                     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function CABR003RPT()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define variaveis padroes para todos os relatorios...                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define variaveis...                                                      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Private nQtdLin     := 58
Private nColuna     := 00
Private nLimite     := 132
Private cNomeProg   := "CABR003"
//Private nCaracter   := 15
Private cControle   := 15
Private cTamanho    := "G"
Private cTitulo     := "Relatorio de Conferencia de Data Limite"
Private cDesc1      := "Emite relatorio com os clientes que completaram a   "
Private cDesc2      := "idade maxima permitida e com data limite.           "
Private cDesc3      := ""
Private cCabec1     := "Periodo de: " + Dtoc(MV_PAR02) + " Ate " + dtoc(MV_PAR03)
Private cCabec2     := ""
Private cAlias      := "BCI"
Private wnRel       := "CABR003"
Private nLi         := 99
Private m_pag       := 1
//Private aReturn     := {"Zebrado", 1,"Administracao", 1, 1, 1, "",1 }
Private aReturn     := { "Zebrado", 1, "Administracao", 2, 2, 1, "", 1}
Private lAbortPrint := .F.
Private aOrdens     := ""
Private lDicion     := .F.
Private lCompres    := .F.
Private lCrystal    := .F.
Private lFiltro     := .T.
PRIVATE nTipo		  := GetMv("MV_COMP")

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Chama SetPrint                                                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
wnRel := SetPrint(cAlias,wnRel,"",@cTitulo,cDesc1,cDesc2,cDesc3,lDicion,aOrdens,lCompres,cTamanho,{},lFiltro,lCrystal)

nTipo := IIF(aReturn[4]==1,15,18)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica se foi cancelada a operacao                                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If  nLastKey  == 27
	Return
Endif
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Configura impressora                                                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
SetDefault(aReturn,cAlias)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Emite relat¢rio                                                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
RptStatus({|lEnd| CABR003IMP() }, "Imprimindo relatorio de ocorrencias ...", "", .T.)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Fim do programa                                                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Return()

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ CABR003IMP ³ Autor ³ Luzio Tavares       ³ Data ³ 28/02/08 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Imprime relatorio de criticas                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ CABR003IMP()                                               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ nenhum                                                     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function CABR003IMP()

Local i := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

Local nOrdSel  := aReturn[8]
Local lPrima 	:= .T.

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Lista criticas                                                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If  len(xUsu) > 0
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Inicializa variaveis                                                     ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	cTitulo := "Relatorio de Conferencia de Data Limite"
	cCabec2 := "Contratante/Titular                                        Dependente/Agregado                                        Plano                Parentesco           Nascimento Dt.Limite  Dt.Exclusao"
	nLi := 99
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Monta regua                                                              ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	SetRegua(len(xUsu))
	
	lPrima := .T.	
	cQuebra := ""
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Processa vetor com log de criticas                                       ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	For i := 1 to len(xUsu)


		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Verifica se foi cancelada a impressao                                 ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If  Interrupcao(lAbortPrint)
			nLi ++
			@ nLi, nColuna pSay PLSTR0002
			Exit
		Endif
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Movimenta regua                                                       ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		IncRegua()
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Imprime cabecalho                                                 ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		
		If cQuebra <> xUsu[i,25]		
	
			If xUsu[i,25] == "1"
			
				nLi := Cabec(cTitulo,cCabec1,cCabec2,wnRel,cTamanho,nTipo)
				nLi++
			
				@ nLi,1 pSay "DEPENDENTES COM DATA LIMITE - 24 ANOS"				
			Else
				nLi++
				@ nLi,  0 pSay "Total de Usuarios " + Str(nTusu)
				
				nLi := Cabec(cTitulo,cCabec1,cCabec2,wnRel,cTamanho,nTipo)
				nLi++
				
				nTusu := 0
				@ nLi,1 pSay "DEMAIS USUÁRIOS COM DATA LIMITE"
			Endif
			cQuebra := xUsu[i,25]
			nLi ++
			@ nLi,1 pSay "-------------------------------------"	
			nLi += 2
						
		Endif
		
		If  nLi > nQtdLin
			nLi := Cabec(cTitulo,cCabec1,cCabec2,wnRel,cTamanho,nTipo)
			nLi++
		Endif
		
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Imprime linha de detalhe                                          ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		//Contratante/Titular                                        Dependente/Agregado                                        Plano                Parentesco           Nascimento Dt.Limite  Dt.Exclusao
		//0....+....1....+....2....+....3....+....4....+....5....+....6....+....7....+....8....+....9....+....0....+....1....+....2....+....3....+....4....+....5....+....6....+....7....+....8....+....9....+
		//12345678901234567 1234567890123456789012345678901234567890 12345678901234567 1234567890123456789012345678901234567890 12345678901234567890 12345678901234567890 99/99/9999 99/99/9999 99/99/9999
		@ nLi,000 pSay xUsu[i,1]
		@ nLi,018 pSay substr(xUsu[i,2],1,40)
		@ nLi,059 pSay xUsu[i,3]
		@ nLi,077 pSay substr(xUsu[i,4],1,40)
		@ nLi,118 pSay xUsu[i,5]                     		//Produto Saude
		@ nLi,139 pSay xUsu[i,6]                     		//Parentesco
		@ nLi,160 pSay xUsu[i,7]							//Data nascimento
		@ nLi,171 pSay xUsu[i,8]							//Data aniversario
		If !Empty(xUsu[i,9])
			@ nLi,182 pSay xUsu[i,9]						//Data bloqueio
		EndIf	
		nLi ++
		nTusu ++
	Next
Endif
nLi ++
@ nLi,  0 pSay "Total de Usuarios " + Str(nTusu)  
nTusu := 0

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Imprime rodape do relatorio...                                       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Roda(0,space(10),cTamanho)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Libera impressao                                                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If  aReturn[5] == 1
	Set Printer To
	Ourspool(wnRel)
Endif

If MV_PAR13 = 2    // "Imprime cartas de convocacao e demais documentos" 
	U_IMPETICAR(xUsu,MV_PAR14) //Imprime relatorio de etiquetas - Modo texto
	CABR003DOC(xUsu)  //Imprime cartas - Modo grafico
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Fim da funcao                                                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Return()

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABR003DOCºAutor  ³Luzio Tavares       º Data ³  19/03/08   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Impressao das cartas de aviso da exclusao do plano         º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CABERJ                                                     º±± 
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABR003DOCºAutor  ³Microsiga           º Data ³  04/17/08   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function CABR003DOC(aUsu)
Local d_DataExt   := STRZERO(Day(dDataBase),2)+" de "+MesExtenso(dDataBase)+" de "+StrZero(Year(dDataBase),4)
Local nCt := 0
Local aTmp	:= {}

Private aArea      := GetArea()
Private cNome      := ""
Private cIdent     := ""
Private cMatPlan   := ""
Private dDataIni
Private dDataFim
Private cMatric
Private cNomPlan

oPrn 	:= tAvPrinter():New( "Protheus" )            
oPrn	:Setup()

For nCt := 1 to Len(aUsu)

	aTmp := {}
	aadd(aTmp,aUsu[nCt])

	U_CARMAIOR(aTmp) //Imprime informativo de maioridade.
	U_CARPROP(aTmp) //Imprime proposta de adesao
	//U_CARTEAD(aTmp) //Imprime termo aditivo  // Desabilitado em 17.04.2014 por OSP chamado 11187
	
Next

oPrn:Preview()

RestArea(aArea)

Return


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa   ³ ValidPerg ³ Autor ³ Luzio Tavares        ³ Data ³ 08.02.08 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao  ³ Atualiza SX1                                               ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
/*/

Static Function ValidPerg()

LOCAL aRegs	:= {}

aadd(aRegs,{cPerg,"01","Operadora:                ","","","mv_ch1","C", 4,0,2,"G","","mv_par01","","","","","","","","","","","","","","","","","","","","","","","","","","B89PLS"})
aadd(aRegs,{cPerg,"02","Periodo De:               ","","","mv_ch2","D", 8,0,2,"G","","mv_par02","","","","","","","","","","","","","","","","","","","","","","","","","",""})
aadd(aRegs,{cPerg,"03","Periodo Ate:              ","","","mv_ch3","D", 8,0,2,"G","","mv_par03","","","","","","","","","","","","","","","","","","","","","","","","","",""})
aadd(aRegs,{cPerg,"04","Grupo/Empresa De:         ","","","mv_ch4","C", 4,0,2,"G","","mv_par04","","","","","","","","","","","","","","","","","","","","","","","","","","B7APLS"})
aadd(aRegs,{cPerg,"05","Grupo/Empresa Ate:        ","","","mv_ch5","C", 4,0,2,"G","","mv_par05","","","","","","","","","","","","","","","","","","","","","","","","","","B7APLS"})
aadd(aRegs,{cPerg,"06","Contrato De:              ","","","mv_ch6","C",12,0,2,"G","","mv_par06","","","","","","","","","","","","","","","","","","","","","","","","","","B7BPLS"})
aadd(aRegs,{cPerg,"07","Contrato Ate:             ","","","mv_ch7","C",12,0,2,"G","","mv_par07","","","","","","","","","","","","","","","","","","","","","","","","","","B7BPLS"})
aadd(aRegs,{cPerg,"08","Subcontrato De:           ","","","mv_ch8","C", 9,0,2,"G","","mv_par08","","","","","","","","","","","","","","","","","","","","","","","","","","B7CPLS"})
aadd(aRegs,{cPerg,"09","Subcontrato Ate:          ","","","mv_ch9","C", 9,0,2,"G","","mv_par09","","","","","","","","","","","","","","","","","","","","","","","","","","B7CPLS"})
aadd(aRegs,{cPerg,"10","Produto De:               ","","","mv_cha","C", 4,0,2,"G","","mv_par10","","","","","","","","","","","","","","","","","","","","","","","","","","BI3"})
aadd(aRegs,{cPerg,"11","Produto Ate:              ","","","mv_chb","C", 4,0,2,"G","","mv_par11","","","","","","","","","","","","","","","","","","","","","","","","","","BI3"})
aadd(aRegs,{cPerg,"12","Tipo de Contrato          ","","","mv_chc","N", 1,0,2,"C","","mv_par12","Fisica","","","","","Juridica","","","","","Todas","","","","","","","","","","","","","","",""})
aadd(aRegs,{cPerg,"13","Imprime Cartas ?          ","","","mv_chd","N", 1,0,2,"C","","mv_par13","Nao","","","","","Sim","","","","","","","","","","","","","","","","","","","",""})
aadd(aRegs,{cPerg,"14","Número de colunas?        ","","","mv_chd","N", 1,0,2,"G","","mv_par14","","","","","","","","","","","","","","","","","","","","","","","","","",""})

PlsVldPerg( aRegs )

Return
