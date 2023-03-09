#INCLUDE "PROTHEUS.CH"
#INCLUDE "JPEG.CH"
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ATUCFGIMP ³ Autor ³ Roger Cangianeli      ³ Data ³06/12/2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Locacao   ³ PLS              ³Contato ³ rogerc@microsiga.com.br        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Atualiza configuracao de impostos sobre comissoes.         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Aplicacao ³ Contabilizacao de comissoes do modulo PLS                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ Unimed e cooperativas                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function ATUCFGIMP()
//Variaveis Locais da Funcao
Local oEdit1
Local oEdit2
Local oEdit3
Local oEdit4
Local oEdit5
Local oEdit6
Local oEdit7
Local oEdit8
Local oEdit9
Local oEditA
Local oEditB
Local oEditC
Local _oDlg

// Variaveis da Funcao de Controle
Local _aArea   		:= GetArea()

// Variaveis de edicao dos parametros
Local nINSS		:= GetNewPar('MV_YINSS',  26.80 )
Local nFGTS		:= GetNewPar('MV_YFGTS',   8.50 )
Local nPIS		:= GetNewPar('MV_YPIS',    1.00 )
Local n13SAL	:= GetNewPar('MV_Y13SAL',  8.33 )
Local nFerias	:= GetNewPar('MV_YFERIAS', 8.33 )
Local nFer13	:= GetNewPar('MV_YFER13',  2.78 )
Local nINSS13	:= GetNewPar('MV_YINSS13', 2.23 )
Local nFGTS13	:= GetNewPar('MV_YFGTS13', 0.71 )
Local nPIS13	:= GetNewPar('MV_YPIS13',  0.08 )
Local nINSSFe	:= GetNewPar('MV_YINSSFE', 2.98 )
Local nFGTSFe	:= GetNewPar('MV_YFGTSFE', 0.94 )
Local nPISFe	:= GetNewPar('MV_YPISFE',  0.11 )
Local bOk		:= {|| _oDlg:End(),RunProc(nINSS, nFGTS, nPIS, n13SAL, nFerias, nFer13, nINSS13, nFGTS13, nPIS13, nINSSFe, nFGTSFe, nPISFe)}

DEFINE MSDIALOG _oDlg TITLE OemtoAnsi("Configuração de Encargos s/Comissões") FROM C(150),C(270) TO C(480),C(500) PIXEL

// Cria Componentes Padroes do Sistema
//@ C(003),C(020) Say OemToAnsi("Preencha abaixo o percentual.") Size C(142),C(027) COLOR CLR_BLACK PIXEL OF _oDlg

@ C(011),C(020) Say OemToAnsi("INSS .............") Size C(050),C(009) COLOR CLR_BLACK PIXEL OF _oDlg
@ C(008),C(060) MsGet oEdit1 Var nINSS PICTURE '@E 999.9999' Size C(025),C(008) COLOR CLR_BLACK PIXEL OF _oDlg
@ C(011),C(097) Say OemToAnsi("%") Size C(006),C(008) COLOR CLR_BLACK PIXEL OF _oDlg

@ C(022),C(020) Say OemToAnsi("FGTS .............") Size C(050),C(009) COLOR CLR_BLACK PIXEL OF _oDlg
@ C(019),C(060) MsGet oEdit2 Var nFGTS PICTURE '@E 999.9999' Size C(025),C(008) COLOR CLR_BLACK PIXEL OF _oDlg
@ C(022),C(097) Say OemToAnsi("%") Size C(006),C(008) COLOR CLR_BLACK PIXEL OF _oDlg

@ C(033),C(020) Say OemToAnsi("PIS ..............") Size C(051),C(009) COLOR CLR_BLACK PIXEL OF _oDlg
@ C(030),C(060) MsGet oEdit3 Var nPIS  PICTURE '@E 999.9999' Size C(025),C(008) COLOR CLR_BLACK PIXEL OF _oDlg
@ C(033),C(097) Say OemToAnsi("%") Size C(006),C(008) COLOR CLR_BLACK PIXEL OF _oDlg

@ C(044),C(020) Say OemToAnsi("13.o Salário .....") Size C(050),C(009) COLOR CLR_BLACK PIXEL OF _oDlg
@ C(041),C(060) MsGet oEdit4 Var n13SAL PICTURE '@E 999.9999' Size C(025),C(008) COLOR CLR_BLACK PIXEL OF _oDlg
@ C(044),C(097) Say OemToAnsi("%") Size C(006),C(008) COLOR CLR_BLACK PIXEL OF _oDlg

@ C(055),C(020) Say OemToAnsi("Férias ...........") Size C(050),C(009) COLOR CLR_BLACK PIXEL OF _oDlg
@ C(052),C(060) MsGet oEdit5 Var nFERIAS PICTURE '@E 999.9999'  Size C(025),C(008) COLOR CLR_BLACK PIXEL OF _oDlg
@ C(055),C(097) Say OemToAnsi("%") Size C(006),C(008) COLOR CLR_BLACK PIXEL OF _oDlg

@ C(066),C(020) Say OemToAnsi("1/3 s/Férias .....") Size C(050),C(009) COLOR CLR_BLACK PIXEL OF _oDlg
@ C(063),C(060) MsGet oEdit6 Var nFER13 PICTURE '@E 999.9999' Size C(025),C(008) COLOR CLR_BLACK PIXEL OF _oDlg
@ C(066),C(097) Say OemToAnsi("%") Size C(006),C(008) COLOR CLR_BLACK PIXEL OF _oDlg

@ C(077),C(020) Say OemToAnsi("INSS s/13.o ......") Size C(050),C(009) COLOR CLR_BLACK PIXEL OF _oDlg
@ C(074),C(060) MsGet oEdit7 Var nINSS13 PICTURE '@E 999.9999' Size C(025),C(008) COLOR CLR_BLACK PIXEL OF _oDlg
@ C(077),C(097) Say OemToAnsi("%") Size C(006),C(008) COLOR CLR_BLACK PIXEL OF _oDlg

@ C(088),C(020) Say OemToAnsi("FGTS s/13.o ......") Size C(050),C(009) COLOR CLR_BLACK PIXEL OF _oDlg
@ C(085),C(060) MsGet oEdit8 Var nFGTS13 PICTURE '@E 999.9999' Size C(025),C(008) COLOR CLR_BLACK PIXEL OF _oDlg
@ C(088),C(097) Say OemToAnsi("%") Size C(006),C(008) COLOR CLR_BLACK PIXEL OF _oDlg

@ C(099),C(020) Say OemToAnsi("PIS s/13.o ...........") Size C(050),C(009) COLOR CLR_BLACK PIXEL OF _oDlg
@ C(096),C(060) MsGet oEdit9 Var nPIS13 PICTURE '@E 999.9999' Size C(025),C(008) COLOR CLR_BLACK PIXEL OF _oDlg
@ C(099),C(097) Say OemToAnsi("%") Size C(006),C(008) COLOR CLR_BLACK PIXEL OF _oDlg

@ C(110),C(020) Say OemToAnsi("INSS s/Férias .....") Size C(050),C(009) COLOR CLR_BLACK PIXEL OF _oDlg
@ C(107),C(060) MsGet oEditA Var nINSSFe PICTURE '@E 999.9999' Size C(025),C(008) COLOR CLR_BLACK PIXEL OF _oDlg
@ C(110),C(097) Say OemToAnsi("%") Size C(006),C(008) COLOR CLR_BLACK PIXEL OF _oDlg

@ C(121),C(020) Say OemToAnsi("FGTS s/Férias ....") Size C(050),C(009) COLOR CLR_BLACK PIXEL OF _oDlg
@ C(118),C(060) MsGet oEditB Var nFGTSFe PICTURE '@E 999.9999' Size C(025),C(008) COLOR CLR_BLACK PIXEL OF _oDlg
@ C(121),C(097) Say OemToAnsi("%") Size C(006),C(008) COLOR CLR_BLACK PIXEL OF _oDlg

@ C(132),C(020) Say OemToAnsi("PIS s/Férias ........") Size C(050),C(009) COLOR CLR_BLACK PIXEL OF _oDlg
@ C(129),C(060) MsGet oEditC Var nPISFe PICTURE '@E 999.9999' Size C(025),C(008) COLOR CLR_BLACK PIXEL OF _oDlg
@ C(132),C(097) Say OemToAnsi("%") Size C(006),C(008) COLOR CLR_BLACK PIXEL OF _oDlg

DEFINE SBUTTON FROM C(144),C(020) TYPE 13 ENABLE OF _oDlg ACTION Eval(bOk)
DEFINE SBUTTON FROM C(144),C(073) TYPE 02 ENABLE OF _oDlg ACTION _oDlg:End()

ACTIVATE MSDIALOG _oDlg CENTERED

RestArea(_aArea)

Return()



//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Funcao estática para atualização dos parâmetros.³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Static Function RunProc(nINSS, nFGTS, nPIS, n13SAL, nFerias, nFer13, nINSS13, nFGTS13, nPIS13, nINSSFe, nFGTSFe, nPISFe)

dbSelectArea('SX6')
dbSetOrder(1)
If !dbSeek('  '+'MV_YINSS',.F.)
	RecLock('SX6',.t.)
	SX6->X6_VAR		:= 'MV_YINSS'
	SX6->X6_TIPO	:= 'N'
	SX6->X6_DESCRIC	:= 'Percentual do INSS a aplicar sobre comissoes.'
	SX6->X6_CONTEUD	:= AllTrim(Str(nINSS))
	SX6->X6_PROPRI	:= 'U'
	msUnlock()
Else
	RecLock('SX6',.f.)
	SX6->X6_CONTEUD	:= AllTrim(Str(nINSS))
	msUnlock()
EndIf


If !dbSeek('  '+'MV_YFGTS',.F.)
	RecLock('SX6',.t.)
	SX6->X6_VAR		:= 'MV_YFGTS'
	SX6->X6_TIPO	:= 'N'
	SX6->X6_DESCRIC	:= 'Percentual do FGTS a aplicar sobre comissoes.'
	SX6->X6_CONTEUD	:= AllTrim(Str(nFGTS))
	SX6->X6_PROPRI	:= 'U'
	msUnlock()
Else
	RecLock('SX6',.f.)
	SX6->X6_CONTEUD	:= AllTrim(Str(nFGTS))
	msUnlock()
EndIf


If !dbSeek('  '+'MV_YPIS',.F.)
	RecLock('SX6',.t.)
	SX6->X6_VAR		:= 'MV_YPIS'
	SX6->X6_TIPO	:= 'N'
	SX6->X6_DESCRIC	:= 'Percentual do PIS a aplicar sobre comissoes.'
	SX6->X6_CONTEUD	:= AllTrim(Str(nPIS))
	SX6->X6_PROPRI	:= 'U'
	msUnlock()
Else
	RecLock('SX6',.f.)
	SX6->X6_CONTEUD	:= AllTrim(Str(nPIS))
	msUnlock()
EndIf


If !dbSeek('  '+'MV_Y13SAL',.F.)
	RecLock('SX6',.t.)
	SX6->X6_VAR		:= 'MV_Y13SAL'
	SX6->X6_TIPO	:= 'N'
	SX6->X6_DESCRIC	:= 'Percentual do 13.o Salario a aplicar sobre comissoes.'
	SX6->X6_CONTEUD	:= AllTrim(Str(n13Sal))
	SX6->X6_PROPRI	:= 'U'
	msUnlock()
Else
	RecLock('SX6',.f.)
	SX6->X6_CONTEUD	:= AllTrim(Str(n13Sal))
	msUnlock()
EndIf


If !dbSeek('  '+'MV_YFERIAS',.F.)
	RecLock('SX6',.t.)
	SX6->X6_VAR		:= 'MV_YFERIAS'
	SX6->X6_TIPO	:= 'N'
	SX6->X6_DESCRIC	:= 'Percentual de Ferias a aplicar sobre comissoes.'
	SX6->X6_CONTEUD	:= AllTrim(Str(nFERIAS))
	SX6->X6_PROPRI	:= 'U'
	msUnlock()
Else
	RecLock('SX6',.f.)
	SX6->X6_CONTEUD	:= AllTrim(Str(nFERIAS))
	msUnlock()
EndIf


If !dbSeek('  '+'MV_YFER13',.F.)
	RecLock('SX6',.t.)
	SX6->X6_VAR		:= 'MV_YFER13'
	SX6->X6_TIPO	:= 'N'
	SX6->X6_DESCRIC	:= 'Percentual de 1/3 s/Ferias a aplicar sobre comissoes.'
	SX6->X6_CONTEUD	:= AllTrim(Str(nFER13))
	SX6->X6_PROPRI	:= 'U'
	msUnlock()
Else
	RecLock('SX6',.f.)
	SX6->X6_CONTEUD	:= AllTrim(Str(nFER13))
	msUnlock()
EndIf


If !dbSeek('  '+'MV_YINSS13',.F.)
	RecLock('SX6',.t.)
	SX6->X6_VAR		:= 'MV_YINSS13'
	SX6->X6_TIPO	:= 'N'
	SX6->X6_DESCRIC	:= 'Percentual do INSS s/13.o a aplicar sobre comissoes.'
	SX6->X6_CONTEUD	:= AllTrim(Str(nINSS13))
	SX6->X6_PROPRI	:= 'U'
	msUnlock()
Else
	RecLock('SX6',.f.)
	SX6->X6_CONTEUD	:= AllTrim(Str(nINSS13))
	msUnlock()
EndIf


If !dbSeek('  '+'MV_YFGTS13',.F.)
	RecLock('SX6',.t.)
	SX6->X6_VAR		:= 'MV_YFGTS13'
	SX6->X6_TIPO	:= 'N'
	SX6->X6_DESCRIC	:= 'Percentual do FGTS s/13.o a aplicar sobre comissoes.'
	SX6->X6_CONTEUD	:= AllTrim(Str(nFGTS13))
	SX6->X6_PROPRI	:= 'U'
	msUnlock()
Else
	RecLock('SX6',.f.)
	SX6->X6_CONTEUD	:= AllTrim(Str(nFGTS13))
	msUnlock()
EndIf


If !dbSeek('  '+'MV_YPIS13',.F.)
	RecLock('SX6',.t.)
	SX6->X6_VAR		:= 'MV_YPIS13'
	SX6->X6_TIPO	:= 'N'
	SX6->X6_DESCRIC	:= 'Percentual do PIS s/13.o a aplicar sobre comissoes.'
	SX6->X6_CONTEUD	:= AllTrim(Str(nPIS13))
	SX6->X6_PROPRI	:= 'U'
	msUnlock()
Else
	RecLock('SX6',.f.)
	SX6->X6_CONTEUD	:= AllTrim(Str(nPIS13))
	msUnlock()
EndIf


If !dbSeek('  '+'MV_YINSSFE',.F.)
	RecLock('SX6',.t.)
	SX6->X6_VAR		:= 'MV_YINSSFE'
	SX6->X6_TIPO	:= 'N'
	SX6->X6_DESCRIC	:= 'Percentual do INSS s/Ferias a aplicar sobre comissoes.'
	SX6->X6_CONTEUD	:= AllTrim(Str(nINSSFE))
	SX6->X6_PROPRI	:= 'U'
	msUnlock()
Else
	RecLock('SX6',.f.)
	SX6->X6_CONTEUD	:= AllTrim(Str(nINSSFE))
	msUnlock()
EndIf


If !dbSeek('  '+'MV_YFGTSFE',.F.)
	RecLock('SX6',.t.)
	SX6->X6_VAR		:= 'MV_YFGTSFE'
	SX6->X6_TIPO	:= 'N'
	SX6->X6_DESCRIC	:= 'Percentual do FGTS s/Ferias a aplicar sobre comissoes.'
	SX6->X6_CONTEUD	:= AllTrim(Str(nFGTSFE))
	SX6->X6_PROPRI	:= 'U'
	msUnlock()
Else
	RecLock('SX6',.f.)
	SX6->X6_CONTEUD	:= AllTrim(Str(nFGTSFE))
	msUnlock()
EndIf


If !dbSeek('  '+'MV_YPISFE',.F.)
	RecLock('SX6',.t.)
	SX6->X6_VAR		:= 'MV_YPISFE'
	SX6->X6_TIPO	:= 'N'
	SX6->X6_DESCRIC	:= 'Percentual do PIS s/Ferias a aplicar sobre comissoes.'
	SX6->X6_CONTEUD	:= AllTrim(Str(nPISFE))
	SX6->X6_PROPRI	:= 'U'
	msUnlock()
Else
	RecLock('SX6',.f.)
	SX6->X6_CONTEUD	:= AllTrim(Str(nPISFE))
	msUnlock()
EndIf


Aviso('Atenção','Parâmetros Atualizados!',{'Ok'},1,'')

Return




/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa   ³   C()      ³ Autor ³ Norbert Waage Junior  ³ Data ³10/05/2005³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao  ³ Funcao responsavel por manter o Layout independente da       ³±±
±±³           ³ resolução horizontal do Monitor do Usuario.                  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function C(nTam)
Local nHRes	:=	oMainWnd:nClientWidth	//Resolucao horizontal do monitor
Do Case
	Case nHRes == 640	//Resolucao 640x480
		nTam *= 0.8
	Case nHRes == 800	//Resolucao 800x600
		nTam *= 1
	OtherWise			//Resolucao 1024x768 e acima
		nTam *= 1.28
EndCase
If "MP8" $ oApp:cVersion
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Tratamento para tema "Flat"³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If (Alltrim(GetTheme()) == "FLAT").Or. SetMdiChild()
		nTam *= 0.90
	EndIf
EndIf
Return Int(nTam)


