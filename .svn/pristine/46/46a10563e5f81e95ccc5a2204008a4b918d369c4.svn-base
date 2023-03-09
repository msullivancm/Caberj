#INCLUDE "PROTHEUS.CH"
#INCLUDE "TOPCONN.CH"
#INCLUDE "UTILIDADES.CH"
#INCLUDE "RPTDEF.CH"
#INCLUDE "FWPrintSetup.ch"
#INCLUDE "FILEIO.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ CABA594  ³ Autor ³ Leonardo Portella     ³ Data ³27/07/2016³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Informações para a Carta de reajuste para empresas.        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ CABERJ                                                     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function CABA594

Local cVldAlt 	:= ".T."
Local cVldExc 	:= ".T."
Local aRotAdic 	:= {{ "Carta Reaj.","U_CABR218", 0 , 6 },{"Anexar arquivo","U_lAnexArq594", 0 , 6 }}
Local bNoTTS  	:= {||U_CB594WEB()}
 
DbSelectArea("ZRH")
DbSetOrder(1)

AxCadastro('ZRH',"Índice Médico - Renovação de Contrato",cVldExc,cVldAlt,aRotAdic,,,,bNoTTS)

Return

*****************************************************************************************************************************

User Function CB594WEB

Local lDisponib := ZRH->ZRH_DISWEB

If !lDisponib
	lDisponib := MsgYesNo('Relatório marcado como não disponibilizar WEB. Deseja disponibilizar?',AllTrim(SM0->M0_NOMECOM))
EndIf

ZRH->(Reclock('ZRH',.F.))

ZRH->ZRH_DISWEB := lDisponib
ZRH->ZRH_PATHAR	:= '' //Vai ser gerado um novo e o CABR218 vai gravar o caminho do PDF

ZRH->(MsUnlock())

If lDisponib 
	If U_CABR218()
		MsgAlert('Relatório será disponibilizado na WEB.',AllTrim(SM0->M0_NOMECOM))
	Else
		MsgStop('Erro: Relatório [ NÃO ] será disponibilizado na WEB.',AllTrim(SM0->M0_NOMECOM))
	EndIf
EndIf

Return

*****************************************************************************************************************************

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ CABR218  ³ Autor ³ Leonardo Portella     ³ Data ³27/07/2016³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Carta de reajuste para empresas.                           ³±±
±±³          ³ Relatorio junto com o CABA594 pois sua chamada será vincu- ³±±
±±³          ³ lada a execução do CABA594.                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ CABERJ                                                     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

#XTRANSLATE LINHA++ 	=> nLin += nTamLin
#XTRANSLATE PARAGRAFO++ => nLin += nTamPar

User Function CABR218

Local lAdjustToLegacy 	:= .F. 
Local lDisableSetup  	:= .T.
Local nI				:= 0
Local cPath				:= "C:\Temp\"//If(cEmpAnt == '01','Q:\','P:\') //GetTempPath() 
Local cPathBmp			:= GetSrvProfString("Startpath","")
Local cNomeArq			:= ''
Local cArquivoPDF		:= ''
Local cCHRMarc			:= CHR(1210) + ' '
Local lOk 				:= .T.

Private nLin 			:= 0
Private nTamLin 		:= 10
Private nLinCab			:= 3
Private nLinMax			:= 760
Private nTamPar 		:= 8
Private nTamTab 		:= 5
Private nColMax			:= 95 //Caracteres
Private nColIni 		:= 60 //Pixel

Private oPrinter

cPathBmp 	:= AjuBarPath(cPathBmp)
cPath		:= AjuBarPath(cPath)

cNomeArq	:= ZRH->ZRH_CODEMP + '_' + ZRH->ZRH_ANO + ZRH->ZRH_MES + '_' + DtoS(Date()) + '_' + Replace(Time(),':','')  

//oPrinter := FwMsPrinter():New(cNomeArq, IMP_PDF, lAdjustToLegacy, cPath, lDisableSetup)// Ordem obrigátoria de configuração do relatório
oPrinter := FWMSPrinter():New(cNomeArq, IMP_PDF, lAdjustToLegacy,cPath, lDisableSetup,/*lTReport*/,/*oPrintSetup*/,/*cPrinter*/,.T.,/*lPDFAsPNG*/,.F.,.F. )

oPrinter:SetResolution(72)
oPrinter:SetPortrait()
oPrinter:SetPaperSize(DMPAPER_A4) 

oPrinter:cPathPDF := cPath

oFont01 	:= TFont():New("Courier New",,11,,.F.) 
oFont01N 	:= TFont():New("Courier New",,11,,.T.)
oFontBox 	:= TFont():New("Courier New",,9,,.F.)

oPrinter:StartPage()

For nI := 1 to 3
	LINHA++
Next

oPrinter:SayBitMap(nLin, nColIni, cPathBmp + If(cEmpAnt == '01',"lgrl01.bmp","lgrl02.bmp"),50,50) 

For nI := 1 to 8
	LINHA++
Next

ImprLinha( cAlinDir("Rio de Janeiro, " + cValtoChar(Day(Date())) + " de " + MesExtenso(Month(Date())) + " de " + cValToChar(Year(Date()))), oFont01) 
ImprLinha( 'A', oFont01) 
ImprLinha( AllTrim(ZRH->ZRH_DESEMP), oFont01N) 
ImprLinha( 'A/C.: DIRETORIA', oFont01) 
LINHA++
ImprLinha( 'Ref.: ÍNDICE MÉDICO - HOSPITALAR/RENOVAÇÃO DE CONTRATO.', oFont01N) 
LINHA++
ImprLinha( Space(nTamTab) + 'Prezados Senhores,', oFont01) 
PARAGRAFO++
ImprLinha( Space(nTamTab) + 'No mês de ' + Lower(MesExtenso(Val(ZRH->ZRH_MES))) + '/' + AllTrim(ZRH->ZRH_ANO) + ', o contrato celebrado entre a ' + AllTrim(ZRH->ZRH_DESEMP) + ' e a ' + AllTrim(ZRH->ZRH_DESOPE) + ' completará mais um ano de vigência.', oFont01) 
PARAGRAFO++
ImprLinha( Space(nTamTab) + 'De acordo com a CLÁUSULA XX - REAJUSTE, no item 3.2.1, o desequilíbrio é constatado quando o nível de sinistralidade da carteira ultrapassar o índice de ' + Alltrim(Transform(ZRH->ZRH_SINMET,PesqPict('ZRH','ZRH_SINMET'))) + '% (' + cExtenPer(ZRH->ZRH_SINMET) + ' Por Cento) = (Sm), cuja base é a proporção entre as despesas assistenciais pagas no período e as receitas das contraprestações mensais diretas do plano, apuradas no período de 12 meses consecutivos, anteriores à data base de aniversário.', oFont01)
LINHA++
ImprLinha( '3.2.2 Neste caso, para o cálculo do percentual de reajuste será aplicada a seguinte fórmula:', oFont01) 
PARAGRAFO++
ImprLinha( 'R = ( S / Sm ) - 1', oFont01)
PARAGRAFO++
ImprLinha( 'Onde: S - Sinistralidade apurada no período', oFont01)
PARAGRAFO++
ImprLinha( 'Sm - Meta de Sinistralidade expressa em contrato', oFont01)
PARAGRAFO++

ImprLinha( 'Desta forma, teremos:', oFont01)
PARAGRAFO++
ImprLinha( Space(nTamTab) + cCHRMarc + 'Período de apuração: (' + DtoC(ZRH->ZRH_VIGINI) + ' a ' + DtoC(ZRH->ZRH_VIGFIM) + ')', oFont01)
PARAGRAFO++
ImprLinha( Space(nTamTab) + cCHRMarc + 'Inflação médica apurada pela operadora de saúde para o período: ' + '19,3' + '% (VCMH)', oFont01)
PARAGRAFO++
ImprLinha( Space(nTamTab) + cCHRMarc + 'Meta de sinistralidade para o contrato ("break even"): ' + Alltrim(Transform(ZRH->ZRH_SINMET,PesqPict('ZRH','ZRH_SINMET'))) + '%', oFont01)
PARAGRAFO++
ImprLinha( Space(nTamTab) + cCHRMarc + 'Total do sinistro no período: ' + Alltrim(Transform(ZRH->ZRH_SINTOT,PesqPict('ZRH','ZRH_SINTOT'))), oFont01)
PARAGRAFO++
ImprLinha( Space(nTamTab) + cCHRMarc + 'Receita no período: ' + Alltrim(Transform(ZRH->ZRH_RECEIT,PesqPict('ZRH','ZRH_RECEIT'))), oFont01)
PARAGRAFO++
ImprLinha( Space(nTamTab) + cCHRMarc + 'Sinistralidade apurada: ' + Alltrim(Transform(ZRH->ZRH_SINAPU,PesqPict('ZRH','ZRH_SINAPU'))), oFont01)
PARAGRAFO++
ImprLinha( Space(nTamTab) + 'Aplicando-se a fórmula de sinistro x receita no período temos:', oFont01)
PARAGRAFO++
LINHA++

nTamH1box 		:= 235
nTamH2Box		:= 209
nTamHSepBox 	:= 40
 
oPrinter:Box(nLin		,nColIni								,nLin + 50	,nColIni + nTamH1box	)
oPrinter:Box(nLin		,nColIni + nTamH1box	+ nTamHSepBox	,nLin + 50	,nColIni + nTamH1box	+ nTamHSepBox + nTamH2Box	)

oPrinter:Say(nLin + 13	,nColIni + 65	, 'Total Sinistro no período'	, oFontBox)
oPrinter:Say(nLin + 20	,nColIni + 3	, 'Reaj. Sinis = '				, oFontBox)
oPrinter:Say(nLin + 30	,nColIni + 65	, 'Receita do período x 0,7 '	, oFontBox)
oPrinter:Say(nLin + 20	,nColIni + 176	, '= Reaj. Sinis'				, oFontBox)

oPrinter:Line(nLin + 21, nColIni + 60, nLin + 21, nColIni + 173)

oPrinter:Say(nLin + 20	,nColIni + nTamH1box + 17	, '->'	, oFontBox)

oPrinter:Say(nLin + 13	,nColIni + nTamH1box	+ nTamHSepBox + 40		, Alltrim(Transform(ZRH->ZRH_SINTOT,PesqPict('ZRH','ZRH_SINTOT')))				, oFontBox)
oPrinter:Say(nLin + 20	,nColIni + nTamH1box	+ nTamHSepBox + 3		, 'Reaj. = '																	, oFontBox)
oPrinter:Say(nLin + 30	,nColIni + nTamH1box	+ nTamHSepBox + 40		, Alltrim(Transform(ZRH->ZRH_RECEIT,PesqPict('ZRH','ZRH_RECEIT'))) + ' x 0,7 '	, oFontBox)

//Conforme informado pela Márcia, não é para fazer cálculo. Deve ser exatamente o que for informado no cadastro.
oPrinter:Say(nLin + 20	,nColIni + nTamH1box	+ nTamHSepBox + 128		, '= ' + Alltrim(Transform(ZRH->ZRH_REASIN,PesqPict('ZRH','ZRH_REASIN'))) + '% Reaj.'	, oFontBox)

oPrinter:Line(nLin + 21, nColIni + nTamH1box	+ nTamHSepBox + 35, nLin + 21, nColIni + 275 + 127)

nLin += 40
PARAGRAFO++
LINHA++

If ( ZRH->ZRH_SINAPU >= ZRH->ZRH_SINMET )
	ImprLinha( Space(nTamTab) + 'Após as considerações acima e, mediante a sinistralidade apresentada, necessitariamos de um reajuste na ordem de ' + Alltrim(Transform(ZRH->(ZRH_REASIN + ZRH_INFMED),PesqPict('ZRH','ZRH_REASIN'))) + '%, ou seja: ' + Alltrim(Transform(ZRH->ZRH_REASIN,PesqPict('ZRH','ZRH_REASIN'))) + ' pela sinistralidade + ' + Alltrim(Transform(ZRH->ZRH_INFMED,PesqPict('ZRH','ZRH_INFMED'))) + '% pela inflação médica do período (VCMH), para que o equilíbrio técnico e financeiro do contrato seja restaurado.', oFont01)
Else
	ImprLinha( Space(nTamTab) + 'Como a sinistralidade ficou em ' + Alltrim(Transform(ZRH->ZRH_SINAPU,PesqPict('ZRH','ZRH_SINAPU'))) + '% , ou seja, abaixo da meta de ' + Alltrim(Transform(ZRH->ZRH_SINMET,PesqPict('ZRH','ZRH_SINMET'))) + '% definida para a carteira ' + AllTrim(ZRH->ZRH_DESEMP) + ', desta forma, será devido o reajuste financeiro de ' + Alltrim(Transform(ZRH->ZRH_INFMED,PesqPict('ZRH','ZRH_INFMED'))) + '%(VCMH).', oFont01)
EndIf	

PARAGRAFO++

If ( ZRH->ZRH_REAJAP > 0 ) 
	ImprLinha( Space(nTamTab) + 'Entretanto, considerando a parceria existente entre nossas empresas, aplicaremos um reajuste da ordem de ' + Alltrim(Transform(ZRH->ZRH_REAJAP,PesqPict('ZRH','ZRH_REAJAP'))) + '% (' + cExtenPer(ZRH->ZRH_REAJAP) + ' Por Cento) para o novo período, que representa apenas o repasse do VCMH acumulado nos últimos meses.', oFont01)
	PARAGRAFO++
EndIf

ImprLinha( Space(nTamTab) + 'Reiteramos nossos votos da mais elevada estima e consideração, colocando-nos a disposição para os esclarecimentos adicionais que se fizerem necessários.', oFont01)
PARAGRAFO++
ImprLinha( 'Atenciosamente,', oFont01)
PARAGRAFO++

oPrinter:SayBitMap(nLin, nColIni, cPathBmp + "Assinatura_Armando.bmp",80,80)

cArquivoPDF	:= oPrinter:cPathPDF + cNomeArq + '.PDF'

oPrinter:EndPage()	

oPrinter:Preview()

FreeObj(oPrinter)

ZRH->(Reclock('ZRH',.F.))
	
If File(cArquivoPDF)

	If ZRH->ZRH_DISWEB
		ZRH->ZRH_PATHAR := cArquivoPDF
	EndIf

Else

	MsgStop('Arquivo [ ' + cArquivoPDF + ' ] não foi localizado. Verifique!',AllTrim(SM0->M0_NOMECOM) )
	
	ZRH->ZRH_DISWEB := .F.
	ZRH->ZRH_PATHAR	:= ''
	lOk := .F.
	
EndIf

ZRH->(MsUnlock())
	 
Return lOk

****************************************************************************************************************************************

Static Function ImprLinha( cTexto, o_Font )

Local aMsg 	:= aQuebraTxt(cTexto, nColMax)
Local nK	:= 0
Local nZ	:= 0

nCont := len(aMsg)
 
For nK := 1 to nCont
	
	LINHA++

	If nLin > nLinMax
		oPrinter:EndPage()
		oPrinter:StartPage()
		nLin := 0
	EndIf
	
	If nLin == 0
		For nZ := 1 to nLinCab
			LINHA++
		Next
	EndIf

	oPrinter:Say(nLin, nColIni, aMsg[nK], o_Font)

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
Local nI		:= 1
Local lInicio	:= .T.

If empty(cTexto)
	lContinua 	:= .F.
	cRet		:= Space(nLimite)
EndIf

While lContinua
	
	nTamAnt := len(cTexto)
	
	For nI := 1 to len(cTexto)
		
		If ( len(cTexto) > nLimite )
			Exit
		EndIf 
		
		If lInicio .and. ( Substr(cTexto,nI,1) <> ' ' )
			lInicio := .F.
		EndIf
		
		If !lInicio .and. ( Substr(cTexto,nI,1) == ' ' ) 
			cTexto := Stuff(cTexto, nI, 1, Space(2))
			nI++
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

cMsg := Space(nColMax - len(cMsg) - 1) + cMsg

Return cMsg

******************************************************************************************************

Static Function cExtenPer(nVlr)

Local nInteiro	:= 0
Local nDecimais	:= 0
Local cDescr 	:= ''
Local nCasas 	:= RAt('.',cValToChar(nVlr)) - 1

nCasas 		:= If(nCasas < 0,0,nCasas)
 
nDecimais	:= nVlr - NoRound(nVlr,0)
nInteiro 	:= nVlr - nDecimais

cDescr 		:= Capital(Lower(AllTrim(Extenso(nInteiro,.T.,,,"1",.T.))))

If nDecimais > 0
	cDescr += ' vírgula ' + Capital(Lower(AllTrim(Extenso(nDecimais * ( 10 ^ nCasas),.T.,,,"1",.T.))))
EndIf

Return cDescr

******************************************************************************************************

User Function lAnexArq594

Local lOk 			:= .F.
Local aArea			:= GetArea()
Local cArqAnexo		:= ''
Local cArqDes		:= If(cEmpAnt == '01','Q:\','P:\')

cArqAnexo := cGetFile( "Arquivo PDF|*.pdf","Selecione arquivo de anexo...",,,.T.,GETF_LOCALHARD+GETF_NETWORKDRIVE)

cArqAnexo := AllTrim(cArqAnexo)

If !empty(ZRH->ZRH_ANEXO) .and. !MsgYesno('Já existe um anexo para esta carta. Deseja substituir?',AllTrim(SM0->M0_NOMECOM))
	MsgStop('Operação cancelada pelo usuário!',AllTrim(SM0->M0_NOMECOM))
ElseIf empty(cArqAnexo) .or. ( len(cArqAnexo) < 4 )
	MsgStop('Arquivo [ ' + cArqAnexo + ' ] inválido!',AllTrim(SM0->M0_NOMECOM))
ElseIf !File(cArqAnexo)
	MsgStop('Arquivo [ ' + cArqAnexo + ' ] não foi localizado!',AllTrim(SM0->M0_NOMECOM))
Else
	cArqDes += ZRH->ZRH_CODEMP + '_' + ZRH->ZRH_ANO + ZRH->ZRH_MES + '_' + DtoS(Date()) + '_' + Replace(Time(),':','') + '_anexo' + Right(cArqAnexo,Len(cArqAnexo) - Rat('.',cArqAnexo) + 1)  
	
	If !MoveFile(cArqAnexo,cArqDes,.F.)
		MsgStop('Não foi possível copiar o arquivo [ ' + cArqAnexo + ' ] para [ ' + cArqDes + ' ]',AllTrim(SM0->M0_NOMECOM))
	Else
		lOk := .T.
		
		ZRH->(Reclock('ZRH',.F.))
		
		ZRH->ZRH_ANEXO := cArqDes
		
		ZRH->(Msunlock())
		
		MsgInfo('Arquivo [ ' + cArqAnexo + ' ] anexado com sucesso!',AllTrim(SM0->M0_NOMECOM))
	EndIf
EndIf

RestArea(aArea)

Return lOk