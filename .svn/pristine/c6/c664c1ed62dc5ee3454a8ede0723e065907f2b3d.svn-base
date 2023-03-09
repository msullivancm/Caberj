#INCLUDE "protheus.ch"

#DEFINE X3_NAOUSADO	 	'€€€€€€€€€€€€€€€'
#DEFINE X3_USADO 		'€€€€€€€€€€€€€€ '
#DEFINE X3_RESERV 	 	'Ã'
#DEFINE X3_NAORESERV	'þÀ'
#DEFINE X3_OBRIGAT 'ƒ€'
#DEFINE X3_NAOOBRIGAT 'þÀ'

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡ao    ³ UPDFEF09()³ Autor ³ Microsiga             ³ Data ³ 20.02.11 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡ao ³ Atualizacao das tabelas - Prontuario Social		           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ Nenhum                                                      ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function UPDGLOSA()
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Inicializa variaveis                                                       |
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local nOpca       := 0
Local aSays       := {}, aButtons := {}
Local aRecnoSM0   := {}
Local lOpen       := .F.
Private nModulo   := 33 // modulo SIGAHSP
Private cMessage  := ""
Private aArqUpd	  := {}
Private aREOPEN	  := {}
Private oMainWnd  := NIL
Private cCadastro := "Compatibilizador de Dicionários x Banco de dados"
Private cCompat   := "UPDGLOSA"
Private cFnc      := ""
Private cRef      := "Recurso de Glosas"
Set Dele On
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta texto para janela de processamento                                   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
aadd(aSays,"Esta rotina irá efetuar a compatibilização dos dicionários e banco de dados,") //"Esta rotina irá efetuar a compatibilização dos dicionários e banco de dados,"
aadd(aSays,"e demais ajustes referentes a rotina de Recuperação de Glosa:")  //"e demais ajustes referentes a FNC abaixo:"
//aadd(aSays,"   FNC: " + cFnc) //"   FNC: "
//aadd(aSays,"   Referência: " + cRef) //"   Referência: "
aadd(aSays," ")
aadd(aSays, "Atenção: efetuar backup dos dicionários e do banco de dados previamente ") //"Atenção: efetuar backup dos dicionários e do banco de dados previamente "
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta botoes para janela de processamento                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
aadd(aButtons, { 1,.T.,{|| nOpca := 1, FechaBatch() }} )
aadd(aButtons, { 2,.T.,{|| nOpca := 0, FechaBatch() }} )
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Exibe janela de processamento                                              ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
FormBatch( cCadastro, aSays, aButtons,, 230 )
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Processa calculo                                                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If  nOpca == 1
	If  Aviso("Compatibilizador", "Deseja confirmar o processamento do compatibilizador ?", {"Sim","Não"}) == 1 //"Compatibilizador"###"Deseja confirmar o processamento do compatibilizador ?"###"Sim"###
		Processa({||UpdEmp(aRecnoSM0,lOpen)},"Processando","Aguarde , processando preparação dos arquivos",.F.) //"Processando"###"Aguarde , processando preparação dos arquivos"
	Endif
Endif
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Fim do programa                                                            |
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Return()
/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ProcATU   ³ Autor ³                       ³ Data ³  /  /    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Funcao de processamento da gravacao dos arquivos           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Baseado na funcao criada por Eduardo Riera em 01/02/2002   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function ProcATU(lEnd,aRecnoSM0,lOpen)
Local cTexto    	:= ""
Local cFile     	:= ""
Local cMask     	:= "Arquivos Texto (*.TXT) |*.txt|"
Local nRecno    	:= 0
Local nI        	:= 0
Local nX        	:= 0
Local cCodigo		:= ""


ProcRegua(1)
IncProc("Verificando integridade dos dicionários....") //"Verificando integridade dos dicionários...."

If lOpen
	
	lSel:=.F.
	For nI := 1 To Len(aRecnoSM0)
		DbSelectArea("SM0")
		DbGotop()
		SM0->(dbGoto(aRecnoSM0[nI,9]))
		
		If !aRecnoSM0[nI,1] .OR. SM0->M0_CODIGO == cCodigo   // Se for o mesmo Grupo Empresa nao e necessario rodar novamente
			loop
		Endif
		lSel:=.T.
		
		RpcSetType(2)
		RpcSetEnv(  SM0->M0_CODIGO, FWGETCODFILIAL)
		cCodigo := SM0->M0_CODIGO
		nModulo := 33 // modulo Plano de Saude
		lMsFinalAuto := .F.
		cTexto += Replicate("-",128)+CHR(13)+CHR(10)
		cTexto += "Empresa: " + aRecnoSM0[nI][2]+CHR(13)+CHR(10) // //
		
		ProcRegua(8)
		
		Begin Transaction
		
		IncProc("Atualizando dicionário de tabelas...")
		cTexto += PlsAtuSX2()
		
		IncProc("Atualizando dicionário de tabelas...")
		cTexto += PlsAtuSIX()
		
		IncProc("Atualizando dicionário de campos...")
		cTexto += PlsAtuSX3()
		
		IncProc("Atualizando dicionário de campos...")
		cTexto += PLSAtuSX7()

		IncProc("Atualizando dicionário de campos...")
		cTexto += PLSAtuSXB()		

	    IncProc("Atualizando dicionário de folderes...")
	    cTexto += PLSAtuSXA()

		End Transaction
		
		__SetX31Mode(.F.)
		For nX := 1 To Len(aArqUpd)
			IncProc("Atualização concluída." +"["+aArqUpd[nx]+"]")
			If Select(aArqUpd[nx])>0
				dbSelecTArea(aArqUpd[nx])
				dbCloseArea()
			EndIf
			X31UpdTable(aArqUpd[nx])
			If __GetX31Error()
				Alert(__GetX31Trace())
				Aviso("Atencao!","Ocorreu um erro desconhecido durante a atualizacao da tabela : " + aArqUpd[nx] + ". Verifique a integridade do dicionario e da tabela." ,{"Continuar"},2)  //"Atencao!"###"Ocorreu um erro desconhecido durante a atualizacao da tabela : "###". Verifique a integridade do dicionario e da tabela."###"Continuar"
				cTexto += "Ocorreu um erro desconhecido durante a atualizacao da estrutura da tabela : " +aArqUpd[nx] +CHR(13)+CHR(10) //"Ocorreu um erro desconhecido durante a atualizacao da estrutura da tabela : "
			EndIf
			dbSelectArea(aArqUpd[nx])
		Next nX
		
		RpcClearEnv()
		If !( lOpen := MyOpenSm0Ex() )
			Exit
		EndIf
	Next nI
	
	If lOpen
		
		cTexto := "Log da atualizacao " + CHR(13) + CHR(10) + cTexto // //"Log da atualizacao "
		
		If !lSel
			cTexto+= "Não foram selecionadas nenhuma empresa para Atualização"
		Endif
		__cFileLog := MemoWrite(Criatrab(,.f.) + ".LOG", cTexto)
		
		DEFINE FONT oFont NAME "Mono AS" SIZE 5,12
		DEFINE MSDIALOG oDlg TITLE " Recuperação de glosa "  From 3,0 to 340,417 PIXEL // //"   FNC: "###"   Referência: "
		@ 5,5 GET oMemo  VAR cTexto MEMO SIZE 200,145 OF oDlg PIXEL
		oMemo:bRClicked := {||AllwaysTrue()}
		oMemo:oFont:=oFont
		DEFINE SBUTTON  FROM 153,175 TYPE 1 ACTION oDlg:End() ENABLE OF oDlg PIXEL //Apaga
		DEFINE SBUTTON  FROM 153,145 TYPE 13 ACTION (cFile:=cGetFile(cMask,""),If(cFile="",.t.,MemoWrite(cFile,cTexto))) ENABLE OF oDlg PIXEL //Salva e Apaga //"Salvar Como..."
		ACTIVATE MSDIALOG oDlg CENTER
		
	EndIf
	
EndIf


Return(Nil)


/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³MyOpenSM0Ex³ Autor ³Sergio Silveira       ³ Data ³07/01/2003³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Efetua a abertura do SM0 exclusivo                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Atualizacao FIS                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function MyOpenSM0Ex()

Local lOpen := .F.
Local nLoop := 0

For nLoop := 1 To 20
	dbUseArea( .T.,, "SIGAMAT.EMP", "SM0", .F., .F. )
	If !Empty( Select( "SM0" ) )
		lOpen := .T.
		dbSetIndex("SIGAMAT.IND")
		Exit
	EndIf
	Sleep( 500 )
Next nLoop

If !lOpen
	Aviso( "Compatibilizador de Dicionários x Banco de dados", "Atenção: Não foi possível abrir o arquivo de empresas!", { "Ok" }, 2 ) //"Compatibilizador de Dicionários x Banco de dados"###"Atenção: Não foi possível abrir o arquivo de empresas!"###"Ok"
EndIf

Return( lOpen )

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ UpdEmp   ³ Autor ³ Luciano Aparecido     ³ Data ³ 15.05.07 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Trata Empresa. Verifica as Empresas para Atualizar         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Atualizacao PLS                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

static function  UpdEmp(aRecnoSM0,lOpen)

Local cVar     := Nil
Local oDlg     := Nil
Local cTitulo  := "Escolha a(s) Empresa(s) que será(ão) Atualizada(s)"
Local lMark    := .F.
Local oOk      := LoadBitmap( GetResources(), "CHECKED" )   //CHECKED    //LBOK  //LBTIK
Local oNo      := LoadBitmap( GetResources(), "UNCHECKED" ) //UNCHECKED  //LBNO
Local oChk     := Nil
Local bCode := {||oDlg:End(),Processa({|lEnd| ProcATU(@lEnd,aRecnoSM0,lOpen)},"Atualizando estruturas. Aguarde... ","Atenção!",.F.)}  //"Atualizando estruturas. Aguarde... [" //"Atenção!"
Local nI :=0
Local aRecSM0 :={}

Private lChk     := .F.
Private oLbx := Nil


If ( lOpen := MyOpenSm0Ex() )
	dbSelectArea("SM0")
	
	/////////////////////////////////////////
	//| Carrega o vetor conforme a condicao |/
	//////////////////////////////////////////
	dbGotop()
	
	aRecSM0:=FWLoadSM0()
	
	
	For nI := 1 to  len(aRecSM0)
		Aadd(aRecnoSM0,{lMark,aRecSM0[nI][1],aRecSM0[nI][6],aRecSM0[nI][2],aRecSM0[nI][3],aRecSM0[nI][4],aRecSM0[nI][5],aRecSM0[nI][7],aRecSM0[nI][12]})
	Next nI
	
	///////////////////////////////////////////////////
	//| Monta a tela para usuario visualizar consulta |
	///////////////////////////////////////////////////
	If Len( aRecnoSM0 ) == 0
		Aviso( cTitulo, "Não existe bancos a consultar", {"Ok"} ) // //"Não existe bancos a consultar"
		Return
	Endif
	
	DEFINE MSDIALOG oDlg TITLE cTitulo FROM 0,0 TO 240,700 PIXEL
	
	@ 10,10 LISTBOX oLbx VAR cVar FIELDS HEADER ;
	" ","Grupo Emp","Descrição","Código","Empresa","Unidade","Filial","Descrição","Recno" ; //"Grupo Emp"###"Descrição"###"Código"###"Empresa"###"Unidade"###"Filial"###"Descrição"###"Recno"
	SIZE 430,095 OF oDlg PIXEL ON dblClick(aRecnoSM0[oLbx:nAt,1] := !aRecnoSM0[oLbx:nAt,1],oLbx:Refresh())
	
	oLbx:SetArray( aRecnoSM0)
	oLbx:bLine := {|| {Iif(aRecnoSM0[oLbx:nAt,1],oOk,oNo),;
	aRecnoSM0[oLbx:nAt,2],;
	aRecnoSM0[oLbx:nAt,3],;
	aRecnoSM0[oLbx:nAt,4],;
	aRecnoSM0[oLbx:nAt,5],;
	aRecnoSM0[oLbx:nAt,6],;
	aRecnoSM0[oLbx:nAt,7],;
	aRecnoSM0[oLbx:nAt,8],;
	Alltrim(Str(aRecnoSM0[oLbx:nAt,9]))}}
	
	////////////////////////////////////////////////////////////////////
	//| Para marcar e desmarcar todos existem duas opçoes, acompanhe...
	////////////////////////////////////////////////////////////////////
	
	
	@ 110,10 CHECKBOX oChk VAR lChk PROMPT  "Marca/Desmarca" SIZE 60,007 PIXEL OF oDlg ; //"Marca/Desmarca"
	ON CLICK(aEval(aRecnoSM0,{|x| x[1]:=lChk}),oLbx:Refresh())
	
	DEFINE SBUTTON FROM 107,213 TYPE 1 ACTION Eval(bCode) ENABLE OF oDlg
	ACTIVATE MSDIALOG oDlg CENTER
Endif

Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³PlsAtuSX3 ºAutor  ³Microsiga           º Data ³  08/04/10   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function PlsAtuSX3()
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Inicializa variaveis                                                       |
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local aSX3           := {}
Local i              := 0
Local j              := 0
Local lSX3	         := .F.
Local cTexto         := "SX3 - Dicionário de Campos" + CHR(13) + CHR(10) + " " + CHR(13) + CHR(10)  //"SX3 - Dicionário de Campos"
Local cAlias         := ""

				
    
aEstrut:= { 	"X3_ARQUIVO","X3_ORDEM"  ,"X3_CAMPO"  ,"X3_TIPO"   ,"X3_TAMANHO","X3_DECIMAL","X3_TITULO" ,"X3_TITSPA" ,"X3_TITENG" ,;
				"X3_DESCRIC","X3_DESCSPA","X3_DESCENG","X3_PICTURE","X3_VALID"  ,"X3_USADO"  ,"X3_RELACAO","X3_F3"     ,"X3_NIVEL"  ,;
				"X3_RESERV" ,"X3_CHECK"  ,"X3_TRIGGER","X3_PROPRI" ,"X3_BROWSE" ,"X3_VISUAL" ,"X3_CONTEXT","X3_OBRIGAT","X3_VLDUSER",;
				"X3_CBOX"   ,"X3_CBOXSPA","X3_CBOXENG","X3_PICTVAR","X3_WHEN"   ,"X3_INIBRW" ,"X3_GRPSXG" ,"X3_FOLDER"	, "X3_PYME", "X3_HELP"}

cSeqZA1 := ('01')			
cSeqZA1 := soma1(cSeqZA1)
aAdd(aSX3,{	  "XA1",; //X3_ARQUIVO
      		  cSeqZA1,; //X3_ORDEM
      		  'XA1_FILIAL',; //X3_CAMPO
      		  'C',; //X3_TIPO
      		  2,; //X3_TAMANHO
		      0,; //X3_DECIMAL
		      'Filial',; //X3_TITULO
		      '',; //X3_TITSPA
		      '',; //X3_TITENG
		      'Filial',; //X3_DESCRIC
		      '',; //X3_DESCSPA
		      '',; //X3_DESCENG
		      '@!',; //X3_PICTURE
		      '',; //X3_VALID
		      X3_NAOUSADO,; //X3_USADO
		      '',; //X3_RELACAO
		      '',; //X3_F3
		      0,; //X3_NIVEL
		      X3_RESERV,; //X3_RESERV
		      '',; //X3_CHECK
		      '',; //X3_TRIGGER
		      'S',; //X3_PROPRI
		      '',; //X3_BROWSE
		      '',; //X3_VISUAL
		      '',; //X3_CONTEXT
		      '',; //X3_OBRIGAT
		      '',; //X3_VLDUSER
		      '',; //X3_CBOX
		      '',; //X3_CBOXSPA
		      '',; //X3_CBOXENG
		      '',; //X3_PICTVAR
		      '',; //X3_WHEN
		      '',; //X3_INIBRW
		      '',; //X3_GRPSXG
		      '1',; //X3_FOLDER
		      ' ',;
		      {"Filial de uma contestação."}}) //X3_PYME    
              

cSeqZA1 := soma1(cSeqZA1)
aAdd(aSX3,{	  "XA1",; //X3_ARQUIVO
		      cSeqZA1,; //X3_ORDEM
		      'XA1_OPECRE',; //X3_CAMPO
		      'C',; //X3_TIPO
		      4,; //X3_TAMANHO
		      0,; //X3_DECIMAL
		      'Operadora',; //X3_TITULO
		      '',; //X3_TITSPA
		      '',; //X3_TITENG
		      'Operadora',; //X3_DESCRIC
		      '',; //X3_DESCSPA
		      '',; //X3_DESCENG
		      '@!',; //X3_PICTURE
		      'U_PL003VLT()',; //X3_VALID
		      X3_USADO,; //X3_USADO
		      'PLSINTPAD()',; //X3_RELACAO
		      'B89PLS',; //X3_F3
		      1,; //X3_NIVEL
		      X3_OBRIGAT,; //X3_RESERV
		      '',; //X3_CHECK
		      '',; //X3_TRIGGER
		      '',; //X3_PROPRI
		      'S',; //X3_BROWSE
		      '',; //X3_VISUAL
		      '',; //X3_CONTEXT
		      '',; //X3_OBRIGAT
		      '',; //X3_VLDUSER
		      '',; //X3_CBOX
		      '',; //X3_CBOXSPA
		      '',; //X3_CBOXENG
		      '',; //X3_PICTVAR
		      'lIncluir',; //X3_WHEN
		      '',; //X3_INIBRW
		      '',; //X3_GRPSXG
		      '1',; //X3_FOLDER
		      'S',;
		      {"Código da operadora do prestador",""}}) //X3_PYME

cSeqZA1 := soma1(cSeqZA1)
aAdd(aSX3,{	  "XA1",; //X3_ARQUIVO
		      cSeqZA1,; //X3_ORDEM
		      'XA1_DESCRE',; //X3_CAMPO
		      'C',; //X3_TIPO
		      60,; //X3_TAMANHO
		      0,; //X3_DECIMAL
		      'Descrição',; //X3_TITULO
		      '',; //X3_TITSPA
		      '',; //X3_TITENG
		      'Descrição',; //X3_DESCRIC
		      '',; //X3_DESCSPA
		      '',; //X3_DESCENG
		      '@!',; //X3_PICTURE
		      '',; //X3_VALID
		      X3_USADO,; //X3_USADO
		      'Posicione("BA0",1,xFilial("BA0")+M->XA1_OPECRE,"BA0_NOMINT")',; //X3_RELACAO
		      '',; //X3_F3
		      1,; //X3_NIVEL
		      X3_NAOOBRIGAT,; //X3_RESERV
		      '',; //X3_CHECK
		      '',; //X3_TRIGGER
		      '',; //X3_PROPRI
		      'N',; //X3_BROWSE
		      'V',; //X3_VISUAL
		      '',; //X3_CONTEXT
		      '',; //X3_OBRIGAT
		      '',; //X3_VLDUSER
		      '',; //X3_CBOX
		      '',; //X3_CBOXSPA
		      '',; //X3_CBOXENG
		      '',; //X3_PICTVAR
		      '',; //X3_WHEN
		      '',; //X3_INIBRW
		      '',; //X3_GRPSXG
		      '1',; //X3_FOLDER
		      'S'}) //X3_PYME

cSeqZA1 := soma1(cSeqZA1)
aAdd(aSX3,{	  "XA1",; //X3_ARQUIVO
      		  cSeqZA1,; //X3_ORDEM
      		  'XA1_CODRDA',; //X3_CAMPO
      		  'C',; //X3_TIPO
      		  6,; //X3_TAMANHO
		      0,; //X3_DECIMAL
		      'Cod. RDA',; //X3_TITULO
		      '',; //X3_TITSPA
		      '',; //X3_TITENG
		      'Cod. RDA',; //X3_DESCRIC
		      '',; //X3_DESCSPA
		      '',; //X3_DESCENG
		      '@!',; //X3_PICTURE
		      'U_PL003VLT()',; //X3_VALID
		      X3_USADO,; //X3_USADO
		      '',; //X3_RELACAO
		      'BASPLS',; //X3_F3
		      0,; //X3_NIVEL
		      X3_RESERV,; //X3_RESERV
		      '',; //X3_CHECK
		      '',; //X3_TRIGGER
		      'S',; //X3_PROPRI
		      'S',; //X3_BROWSE
		      'A',; //X3_VISUAL
		      'R',; //X3_CONTEXT
		      '',; //X3_OBRIGAT
		      '',; //X3_VLDUSER
		      '',; //X3_CBOX
		      '',; //X3_CBOXSPA
		      '',; //X3_CBOXENG
		      '',; //X3_PICTVAR
		      '',; //X3_WHEN
		      '',; //X3_INIBRW
		      '',; //X3_GRPSXG
		      '1',; //X3_FOLDER
		      ' ',;//X3_PYME    
		      {"Rede de Atendimento"}}) 

cSeqZA1 := soma1(cSeqZA1)
aAdd(aSX3,{	  "XA1",; //X3_ARQUIVO
		      cSeqZA1,; //X3_ORDEM
		      'XA1_DESRDA',; //X3_CAMPO
		      'C',; //X3_TIPO
		      60,; //X3_TAMANHO
		      0,; //X3_DECIMAL
		      'Descrição',; //X3_TITULO
		      '',; //X3_TITSPA
		      '',; //X3_TITENG
		      'Descrição',; //X3_DESCRIC
		      '',; //X3_DESCSPA
		      '',; //X3_DESCENG
		      '@!',; //X3_PICTURE
		      '',; //X3_VALID
		      X3_USADO,; //X3_USADO
		      'Posicione("BAU",1,xFilial("BAU")+M->XA1_CODRDA,"BAU_NOME")',; //X3_RELACAO
		      '',; //X3_F3
		      1,; //X3_NIVEL
		      X3_NAOOBRIGAT,; //X3_RESERV
		      '',; //X3_CHECK
		      '',; //X3_TRIGGER
		      '',; //X3_PROPRI
		      'S',; //X3_BROWSE
		      'V',; //X3_VISUAL
		      '',; //X3_CONTEXT
		      '',; //X3_OBRIGAT
		      '',; //X3_VLDUSER
		      '',; //X3_CBOX
		      '',; //X3_CBOXSPA
		      '',; //X3_CBOXENG
		      '',; //X3_PICTVAR
		      '',; //X3_WHEN
		      '',; //X3_INIBRW
		      '',; //X3_GRPSXG
		      '1',; //X3_FOLDER
		      'S'}) //X3_PYME

cSeqZA1 := soma1(cSeqZA1)
aAdd(aSX3,{	  "XA1",; //X3_ARQUIVO
      		  cSeqZA1,; //X3_ORDEM
      		  'XA1_CODQUE',; //X3_CAMPO
      		  'C',; //X3_TIPO
      		  8,; //X3_TAMANHO
		      0,; //X3_DECIMAL
		      'Codigo Recurso',; //X3_TITULO
		      '',; //X3_TITSPA
		      '',; //X3_TITENG
		      'Codigo Recurso',; //X3_DESCRIC
		      '',; //X3_DESCSPA
		      '',; //X3_DESCENG
		      '@!',; //X3_PICTURE
		      'U_PL003VLT()',; //X3_VALID
		      X3_USADO,; //X3_USADO
		      '"AUTO"',; //X3_RELACAO
		      '',; //X3_F3
		      1,; //X3_NIVEL
		      X3_OBRIGAT,; //X3_RESERV
		      '',; //X3_CHECK
		      '',; //X3_TRIGGER
		      'S',; //X3_PROPRI
		      'S',; //X3_BROWSE
		      'V',; //X3_VISUAL
		      'R',; //X3_CONTEXT
		      'S',; //X3_OBRIGAT
		      '',; //X3_VLDUSER
		      '',; //X3_CBOX
		      '',; //X3_CBOXSPA
		      '',; //X3_CBOXENG
		      '',; //X3_PICTVAR
		      '',; //X3_WHEN
		      '',; //X3_INIBRW
		      '',; //X3_GRPSXG
		      '2',; //X3_FOLDER
		      ' ',;//X3_PYME    
		      {"Sequencial do Recurso"}}) 


cSeqZA1 := soma1(cSeqZA1)
aAdd(aSX3,{	  "XA1",; //X3_ARQUIVO
      		  cSeqZA1,; //X3_ORDEM
      		  'XA1_STATUS',; //X3_CAMPO
      		  'C',; //X3_TIPO
      		  1,; //X3_TAMANHO
		      0,; //X3_DECIMAL
		      'Status',; //X3_TITULO
		      '',; //X3_TITSPA
		      '',; //X3_TITENG
		      'Status',; //X3_DESCRIC
		      '',; //X3_DESCSPA
		      '',; //X3_DESCENG
		      '@!',; //X3_PICTURE
		      '',; //X3_VALID
		      X3_USADO,; //X3_USADO
		      '"2"',; //X3_RELACAO
		      '',; //X3_F3
		      0,; //X3_NIVEL
		      X3_OBRIGAT,; //X3_RESERV
		      '',; //X3_CHECK
		      '',; //X3_TRIGGER
		      'S',; //X3_PROPRI
		      'N',; //X3_BROWSE
		      'V',; //X3_VISUAL
		      'R',; //X3_CONTEXT
		      'S',; //X3_OBRIGAT
		      '',; //X3_VLDUSER
		      '1=Recurso encerrado;2=Recurso em aberto',; //X3_CBOX
		      '',; //X3_CBOXSPA
		      '',; //X3_CBOXENG
		      '',; //X3_PICTVAR
		      '',; //X3_WHEN
		      '',; //X3_INIBRW
		      '',; //X3_GRPSXG
		      '1',; //X3_FOLDER
		      ' ',;//X3_PYME
		      {"Define o status do recurso"} } ) 


cSeqZA1 := soma1(cSeqZA1)
aAdd(aSX3,{	  "XA1",; //X3_ARQUIVO
      		  cSeqZA1,; //X3_ORDEM
      		  'XA1_DTENVI',; //X3_CAMPO
      		  'D',; //X3_TIPO
      		  8,; //X3_TAMANHO
		      0,; //X3_DECIMAL
		      'Dt.Inclusao',; //X3_TITULO
		      '',; //X3_TITSPA
		      '',; //X3_TITENG
		      'Dt.Inclusao',; //X3_DESCRIC
		      '',; //X3_DESCSPA
		      '',; //X3_DESCENG
		      '@!',; //X3_PICTURE
		      '',; //X3_VALID
		      X3_USADO,; //X3_USADO
		      'dDataBase',; //X3_RELACAO
		      '',; //X3_F3
		      0,; //X3_NIVEL
		      X3_OBRIGAT,; //X3_RESERV
		      '',; //X3_CHECK
		      '',; //X3_TRIGGER
		      'S',; //X3_PROPRI
		      'N',; //X3_BROWSE
		      'A',; //X3_VISUAL
		      'R',; //X3_CONTEXT
		      'S',; //X3_OBRIGAT
		      '',; //X3_VLDUSER
		      '',; //X3_CBOX
		      '',; //X3_CBOXSPA
		      '',; //X3_CBOXENG
		      '',; //X3_PICTVAR
		      '',; //X3_WHEN
		      '',; //X3_INIBRW
		      '',; //X3_GRPSXG
		      '1',; //X3_FOLDER
		      ' ',;//X3_PYME
		      {"Data de inclusao recurso",""} } ) 


		      
cSeqZA1 := soma1(cSeqZA1)
aAdd(aSX3,{	  "XA1",; //X3_ARQUIVO
      		  cSeqZA1,; //X3_ORDEM
      		  'XA1_TIPINC',; //X3_CAMPO
      		  'C',; //X3_TIPO
      		  1,; //X3_TAMANHO
		      0,; //X3_DECIMAL
		      'Tipo Incl.',; //X3_TITULO
		      '',; //X3_TITSPA
		      '',; //X3_TITENG
		      'Tipo Incl.',; //X3_DESCRIC
		      '',; //X3_DESCSPA
		      '',; //X3_DESCENG
		      '@!',; //X3_PICTURE
		      '',; //X3_VALID
		      X3_USADO,; //X3_USADO
		      '"1"',; //X3_RELACAO
		      '',; //X3_F3
		      0,; //X3_NIVEL
		      X3_RESERV,; //X3_RESERV
		      '',; //X3_CHECK
		      '',; //X3_TRIGGER
		      'S',; //X3_PROPRI
		      'S',; //X3_BROWSE
		      'V',; //X3_VISUAL
		      'R',; //X3_CONTEXT
		      '',; //X3_OBRIGAT
		      '',; //X3_VLDUSER
		      '1=Manual;2=Automatica',; //X3_CBOX
		      '',; //X3_CBOXSPA
		      '',; //X3_CBOXENG
		      '',; //X3_PICTVAR
		      '',; //X3_WHEN
		      '',; //X3_INIBRW
		      '',; //X3_GRPSXG
		      '2',; //X3_FOLDER
		      ' ',;//X3_PYME    
		      {"Tipo Inclusão do registro"}}) 

cSeqXA2 := '01'
cSeqXA2 := soma1(cSeqXA2)
aAdd(aSX3,{	  "XA2",; //X3_ARQUIVO
      		  cSeqXA2,; //X3_ORDEM
      		  'XA2_FILIAL',; //X3_CAMPO
      		  'C',; //X3_TIPO
      		  2,; //X3_TAMANHO
		      0,; //X3_DECIMAL
		      'Filial',; //X3_TITULO
		      '',; //X3_TITSPA
		      '',; //X3_TITENG
		      'Filial',; //X3_DESCRIC
		      '',; //X3_DESCSPA
		      '',; //X3_DESCENG
		      '@!',; //X3_PICTURE
		      '',; //X3_VALID
		      X3_NAOUSADO,; //X3_USADO
		      '',; //X3_RELACAO
		      '',; //X3_F3
		      0,; //X3_NIVEL
		      X3_RESERV,; //X3_RESERV
		      '',; //X3_CHECK
		      '',; //X3_TRIGGER
		      'S',; //X3_PROPRI
		      '',; //X3_BROWSE
		      '',; //X3_VISUAL
		      '',; //X3_CONTEXT
		      '',; //X3_OBRIGAT
		      '',; //X3_VLDUSER
		      '',; //X3_CBOX
		      '',; //X3_CBOXSPA
		      '',; //X3_CBOXENG
		      '',; //X3_PICTVAR
		      '',; //X3_WHEN
		      '',; //X3_INIBRW
		      '',; //X3_GRPSXG
		      '1',; //X3_FOLDER
		      ' ',;
		      {"Filial de uma contestação."}}) //X3_PYME    

cSeqZA1 := soma1(cSeqZA1)
aAdd(aSX3,{	  "XA2",; //X3_ARQUIVO
		      cSeqZA1,; //X3_ORDEM
		      'XA2_OPECRE',; //X3_CAMPO
		      'C',; //X3_TIPO
		      4,; //X3_TAMANHO
		      0,; //X3_DECIMAL
		      'Operadora',; //X3_TITULO
		      '',; //X3_TITSPA
		      '',; //X3_TITENG
		      'Dt.Inclusao',; //X3_DESCRIC
		      '',; //X3_DESCSPA
		      '',; //X3_DESCENG
		      '@!',; //X3_PICTURE
		      'U_PL003VLT()',; //X3_VALID
		      X3_NAOUSADO,; //X3_USADO
		      'XA1->XA1_OPECRE',; //X3_RELACAO
		      'B89PLS',; //X3_F3
		      1,; //X3_NIVEL
		      X3_OBRIGAT,; //X3_RESERV
		      '',; //X3_CHECK
		      '',; //X3_TRIGGER
		      '',; //X3_PROPRI
		      '',; //X3_BROWSE
		      '',; //X3_VISUAL
		      '',; //X3_CONTEXT
		      '',; //X3_OBRIGAT
		      '',; //X3_VLDUSER
		      '',; //X3_CBOX
		      '',; //X3_CBOXSPA
		      '',; //X3_CBOXENG
		      '',; //X3_PICTVAR
		      '',; //X3_WHEN
		      '',; //X3_INIBRW
		      '',; //X3_GRPSXG
		      '1',; //X3_FOLDER
		      'S',;
		      {"Código da operadora que originou","a contestação."}}) //X3_PYME

cSeqXA2 := soma1(cSeqXA2)
aAdd(aSX3,{	  "XA2",; //X3_ARQUIVO
      		  cSeqXA2,; //X3_ORDEM
      		  'XA2_CODQUE',; //X3_CAMPO
      		  'C',; //X3_TIPO
      		  8,; //X3_TAMANHO
		      0,; //X3_DECIMAL
		      'Codigo Recurso',; //X3_TITULO
		      '',; //X3_TITSPA
		      '',; //X3_TITENG
		      'Codigo Recurso',; //X3_DESCRIC
		      '',; //X3_DESCSPA
		      '',; //X3_DESCENG
		      '@!',; //X3_PICTURE
		      '',; //X3_VALID
		      X3_NAOUSADO,; //X3_USADO
		      'XA1->XA1_CODQUE',; //X3_RELACAO
		      '',; //X3_F3
		      0,; //X3_NIVEL
		      X3_OBRIGAT,; //X3_RESERV
		      '',; //X3_CHECK
		      '',; //X3_TRIGGER
		      'S',; //X3_PROPRI
		      'N',; //X3_BROWSE
		      'V',; //X3_VISUAL
		      'R',; //X3_CONTEXT
		      'S',; //X3_OBRIGAT
		      '',; //X3_VLDUSER
		      '',; //X3_CBOX
		      '',; //X3_CBOXSPA
		      '',; //X3_CBOXENG
		      '',; //X3_PICTVAR
		      '',; //X3_WHEN
		      '',; //X3_INIBRW
		      '',; //X3_GRPSXG
		      '1',; //X3_FOLDER
		      ' ',;//X3_PYME    
		      {"Sequencial de recurso."}}) 

cSeqXA2 := soma1(cSeqXA2)
aAdd(aSX3,{	  "XA2",; //X3_ARQUIVO
      		  cSeqXA2,; //X3_ORDEM
      		  'XA2_SEQQUE',; //X3_CAMPO
      		  'C',; //X3_TIPO
      		  3,; //X3_TAMANHO
		      0,; //X3_DECIMAL
		      'Sequencial',; //X3_TITULO
		      '',; //X3_TITSPA
		      '',; //X3_TITENG
		      'Sequecial',; //X3_DESCRIC
		      '',; //X3_DESCSPA
		      '',; //X3_DESCENG
		      '@!',; //X3_PICTURE
		      'U_PL003VLT()',; //X3_VALID
		      X3_USADO,; //X3_USADO
		      '"AUTO"',; //X3_RELACAO
		      '',; //X3_F3
		      0,; //X3_NIVEL
		      X3_OBRIGAT,; //X3_RESERV
		      '',; //X3_CHECK
		      '',; //X3_TRIGGER
		      'S',; //X3_PROPRI
		      'S',; //X3_BROWSE
		      'V',; //X3_VISUAL
		      'R',; //X3_CONTEXT
		      'S',; //X3_OBRIGAT
		      '',; //X3_VLDUSER
		      '',; //X3_CBOX
		      '',; //X3_CBOXSPA
		      '',; //X3_CBOXENG
		      '',; //X3_PICTVAR
		      '',; //X3_WHEN
		      '',; //X3_INIBRW
		      '',; //X3_GRPSXG
		      '2',; //X3_FOLDER
		      ' ',;//X3_PYME    
		      {"Sequencial",;
		       ""}}) 

cSeqXA2 := soma1(cSeqXA2)
aAdd(aSX3,{	  "XA2",; //X3_ARQUIVO
		      cSeqXA2,; //X3_ORDEM
		      'XA2_CODOPE',; //X3_CAMPO
		      'C',; //X3_TIPO
		      4,; //X3_TAMANHO
		      0,; //X3_DECIMAL
		      'Oper. Movto.',; //X3_TITULO
		      '',; //X3_TITSPA
		      '',; //X3_TITENG
		      'Operadora Movimento',; //X3_DESCRIC
		      '',; //X3_DESCSPA
		      '',; //X3_DESCENG
		      '@!',; //X3_PICTURE
		      '',; //X3_VALID
		      X3_USADO,; //X3_USADO
		      '',; //X3_RELACAO
		      '',; //X3_F3
		      1,; //X3_NIVEL
		      X3_NAOOBRIGAT,; //X3_RESERV
		      '',; //X3_CHECK
		      '',; //X3_TRIGGER
		      '',; //X3_PROPRI
		      'S',; //X3_BROWSE
		      'V',; //X3_VISUAL
		      '',; //X3_CONTEXT
		      '',; //X3_OBRIGAT
		      '',; //X3_VLDUSER
		      '',; //X3_CBOX
		      '',; //X3_CBOXSPA
		      '',; //X3_CBOXENG
		      '',; //X3_PICTVAR
		      '',; //X3_WHEN
		      '',; //X3_INIBRW
		      '',; //X3_GRPSXG
		      '2',; //X3_FOLDER
		      'S'}) //X3_PYME
		
cSeqXA2 := soma1(cSeqXA2)
aAdd(aSX3,{	  "XA2",; //X3_ARQUIVO
		      cSeqXA2,; //X3_ORDEM
		      'XA2_CODLDP',; //X3_CAMPO
		      'C',; //X3_TIPO
		      4,; //X3_TAMANHO
		      0,; //X3_DECIMAL
		      'Cd.Local Dig',; //X3_TITULO
		      '',; //X3_TITSPA
		      '',; //X3_TITENG
		      'Código Local Digitação',; //X3_DESCRIC
		      '',; //X3_DESCSPA
		      '',; //X3_DESCENG
		      '@!',; //X3_PICTURE
		      '',; //X3_VALID
		      X3_USADO,; //X3_USADO
		      '',; //X3_RELACAO
		      '',; //X3_F3
		      1,; //X3_NIVEL
		      X3_NAOOBRIGAT,; //X3_RESERV
		      '',; //X3_CHECK
		      '',; //X3_TRIGGER
		      '',; //X3_PROPRI
		      'S',; //X3_BROWSE
		      'V',; //X3_VISUAL
		      '',; //X3_CONTEXT
		      '',; //X3_OBRIGAT
		      '',; //X3_VLDUSER
		      '',; //X3_CBOX
		      '',; //X3_CBOXSPA
		      '',; //X3_CBOXENG
		      '',; //X3_PICTVAR
		      '',; //X3_WHEN
		      '',; //X3_INIBRW
		      '',; //X3_GRPSXG
		      '2',; //X3_FOLDER
		      'S'}) //X3_PYME
		
cSeqXA2 := soma1(cSeqXA2)
aAdd(aSX3,{	  "XA2",; //X3_ARQUIVO
		      cSeqXA2,; //X3_ORDEM
		      'XA2_CODPEG',; //X3_CAMPO
		      'C',; //X3_TIPO
		      8,; //X3_TAMANHO
		      0,; //X3_DECIMAL
		      'Código PEG',; //X3_TITULO
		      '',; //X3_TITSPA
		      '',; //X3_TITENG
		      'Codigo PEG',; //X3_DESCRIC
		      '',; //X3_DESCSPA
		      '',; //X3_DESCENG
		      '@!',; //X3_PICTURE
		      '',; //X3_VALID
		      X3_USADO,; //X3_USADO
		      '',; //X3_RELACAO
		      '',; //X3_F3
		      1,; //X3_NIVEL
		      X3_NAOOBRIGAT,; //X3_RESERV
		      '',; //X3_CHECK
		      '',; //X3_TRIGGER
		      '',; //X3_PROPRI
		      'S',; //X3_BROWSE
		      'V',; //X3_VISUAL
		      '',; //X3_CONTEXT
		      '',; //X3_OBRIGAT
		      '',; //X3_VLDUSER
		      '',; //X3_CBOX
		      '',; //X3_CBOXSPA
		      '',; //X3_CBOXENG
		      '',; //X3_PICTVAR
		      '',; //X3_WHEN
		      '',; //X3_INIBRW
		      '',; //X3_GRPSXG
		      '2',; //X3_FOLDER
		      'S'}) //X3_PYME
		
cSeqXA2 := soma1(cSeqXA2)
aAdd(aSX3,{	  "XA2",; //X3_ARQUIVO
		      cSeqXA2,; //X3_ORDEM
		      'XA2_NUMERO',; //X3_CAMPO
		      'C',; //X3_TIPO
		      8,; //X3_TAMANHO
		      0,; //X3_DECIMAL
		      'Número',; //X3_TITULO
		      'Numero',; //X3_TITSPA
		      'Number',; //X3_TITENG
		      'Numero da Movimentacao',; //X3_DESCRIC
		      'Numero del Movimiento',; //X3_DESCSPA
		      'Movement number',; //X3_DESCENG
		      '@!',; //X3_PICTURE
		      '',; //X3_VALID
		      X3_USADO,; //X3_USADO
		      '',; //X3_RELACAO
		      '',; //X3_F3
		      1,; //X3_NIVEL
		      X3_NAOOBRIGAT,; //X3_RESERV
		      '',; //X3_CHECK
		      '',; //X3_TRIGGER
		      '',; //X3_PROPRI
		      'S',; //X3_BROWSE
		      'V',; //X3_VISUAL
		      '',; //X3_CONTEXT
		      '',; //X3_OBRIGAT
		      '',; //X3_VLDUSER
		      '',; //X3_CBOX
		      '',; //X3_CBOXSPA
		      '',; //X3_CBOXENG
		      '',; //X3_PICTVAR
		      '',; //X3_WHEN
		      '',; //X3_INIBRW
		      '',; //X3_GRPSXG
		      '2',; //X3_FOLDER
		      'S'}) //X3_PYME
		
cSeqXA2 := soma1(cSeqXA2)
aAdd(aSX3,{	  "XA2",; //X3_ARQUIVO
		      cSeqXA2,; //X3_ORDEM
		      'XA2_ORIMOV',; //X3_CAMPO
		      'C',; //X3_TIPO
		      1,; //X3_TAMANHO
		      0,; //X3_DECIMAL
		      'Origem Movto',; //X3_TITULO
		      '',; //X3_TITSPA
		      '',; //X3_TITENG
		      'Origem do Movimento',; //X3_DESCRIC
		      '',; //X3_DESCSPA
		      '',; //X3_DESCENG
		      '@!',; //X3_PICTURE
		      '',; //X3_VALID
		      X3_USADO,; //X3_USADO
		      '',; //X3_RELACAO
		      '',; //X3_F3
		      1,; //X3_NIVEL
		      X3_NAOOBRIGAT,; //X3_RESERV
		      '',; //X3_CHECK
		      '',; //X3_TRIGGER
		      '',; //X3_PROPRI
		      'N',; //X3_BROWSE
		      'V',; //X3_VISUAL
		      '',; //X3_CONTEXT
		      '',; //X3_OBRIGAT
		      '',; //X3_VLDUSER
		      '1=Guias de Consultas/Servicos;2=Guia de Internacao;3=Outros;4=Autorizacao Odontologica',; //X3_CBOX
		      '',; //X3_CBOXSPA
		      '',; //X3_CBOXENG
		      '',; //X3_PICTVAR
		      '',; //X3_WHEN
		      '',; //X3_INIBRW
		      '',; //X3_GRPSXG
		      '2',; //X3_FOLDER
		      'S'}) //X3_PYME
		
cSeqXA2 := soma1(cSeqXA2)
aAdd(aSX3,{	  "XA2",; //X3_ARQUIVO
		      cSeqXA2,; //X3_ORDEM
		      'XA2_SEQUEN',; //X3_CAMPO
		      'C',; //X3_TIPO
		      3,; //X3_TAMANHO
		      0,; //X3_DECIMAL
		      'Sequencial',; //X3_TITULO
		      '',; //X3_TITSPA
		      '',; //X3_TITENG
		      'Evento',; //X3_DESCRIC
		      '',; //X3_DESCSPA
		      '',; //X3_DESCENG
		      '@!',; //X3_PICTURE
		      '',; //X3_VALID
		      X3_USADO,; //X3_USADO
		      '',; //X3_RELACAO
		      '',; //X3_F3
		      1,; //X3_NIVEL
		      X3_NAOOBRIGAT,; //X3_RESERV
		      '',; //X3_CHECK
		      '',; //X3_TRIGGER
		      '',; //X3_PROPRI
		      'S',; //X3_BROWSE
		      'V',; //X3_VISUAL
		      '',; //X3_CONTEXT
		      '',; //X3_OBRIGAT
		      '',; //X3_VLDUSER
		      '',; //X3_CBOX
		      '',; //X3_CBOXSPA
		      '',; //X3_CBOXENG
		      '',; //X3_PICTVAR
		      '',; //X3_WHEN
		      '',; //X3_INIBRW
		      '',; //X3_GRPSXG
		      '2',; //X3_FOLDER
		      'S'}) //X3_PYME

cSeqXA2 := soma1(cSeqXA2)
aAdd(aSX3,{	  "XA2",; //X3_ARQUIVO
		      cSeqXA2,; //X3_ORDEM
		      'XA2_NUMIMP',; //X3_CAMPO
		      'C',; //X3_TIPO
		      20,; //X3_TAMANHO
		      0,; //X3_DECIMAL
		      'Num Imp.',; //X3_TITULO
		      '',; //X3_TITSPA
		      '',; //X3_TITENG
		      'Num Imp.',; //X3_DESCRIC
		      '',; //X3_DESCSPA
		      '',; //X3_DESCENG
		      '@!',; //X3_PICTURE
		      '',; //X3_VALID
		      X3_USADO,; //X3_USADO
		      '',; //X3_RELACAO
		      '',; //X3_F3
		      1,; //X3_NIVEL
		      X3_NAOOBRIGAT,; //X3_RESERV
		      '',; //X3_CHECK
		      '',; //X3_TRIGGER
		      '',; //X3_PROPRI
		      'S',; //X3_BROWSE
		      'V',; //X3_VISUAL
		      '',; //X3_CONTEXT
		      '',; //X3_OBRIGAT
		      '',; //X3_VLDUSER
		      '',; //X3_CBOX
		      '',; //X3_CBOXSPA
		      '',; //X3_CBOXENG
		      '',; //X3_PICTVAR
		      '',; //X3_WHEN
		      '',; //X3_INIBRW
		      '',; //X3_GRPSXG
		      '2',; //X3_FOLDER
		      'S'}) //X3_PYME

cSeqXA2 := soma1(cSeqXA2)
aAdd(aSX3,{	  "XA2",; //X3_ARQUIVO
		      cSeqXA2,; //X3_ORDEM
		      'XA2_CODGUI',; //X3_CAMPO
		      'C',; //X3_TIPO
		      24,; //X3_TAMANHO
		      0,; //X3_DECIMAL
		      'Cod. Guia',; //X3_TITULO
		      '',; //X3_TITSPA
		      '',; //X3_TITENG
		      'Cod. Guia',; //X3_DESCRIC
		      '',; //X3_DESCSPA
		      '',; //X3_DESCENG
		      '@!',; //X3_PICTURE
		      '',; //X3_VALID
		      X3_USADO,; //X3_USADO
		      '',; //X3_RELACAO
		      '',; //X3_F3
		      1,; //X3_NIVEL
		      X3_NAOOBRIGAT,; //X3_RESERV
		      '',; //X3_CHECK
		      '',; //X3_TRIGGER
		      '',; //X3_PROPRI
		      'S',; //X3_BROWSE
		      'V',; //X3_VISUAL
		      '',; //X3_CONTEXT
		      '',; //X3_OBRIGAT
		      '',; //X3_VLDUSER
		      '',; //X3_CBOX
		      '',; //X3_CBOXSPA
		      '',; //X3_CBOXENG
		      '',; //X3_PICTVAR
		      '',; //X3_WHEN
		      '',; //X3_INIBRW
		      '',; //X3_GRPSXG
		      '2',; //X3_FOLDER
		      'S'}) //X3_PYME
		
cSeqXA2 := soma1(cSeqXA2)
aAdd(aSX3,{	  "XA2",; //X3_ARQUIVO
		      cSeqXA2,; //X3_ORDEM
		      'XA2_CODPAD',; //X3_CAMPO
		      'C',; //X3_TIPO
		      2,; //X3_TAMANHO
		      0,; //X3_DECIMAL
		      'Cod. Tab. Pd',; //X3_TITULO
		      '',; //X3_TITSPA
		      '',; //X3_TITENG
		      'Cod. Tab. Pd',; //X3_DESCRIC
		      '',; //X3_DESCSPA
		      '',; //X3_DESCENG
		      '@!',; //X3_PICTURE
		      'U_PL003VLT()',; //X3_VALID
		      X3_USADO,; //X3_USADO
		      'GETMV("MV_PLSTBPD")',; //X3_RELACAO
		      'B41PLS',; //X3_F3
		      1,; //X3_NIVEL
		      X3_OBRIGAT,; //X3_RESERV
		      '',; //X3_CHECK
		      '',; //X3_TRIGGER
		      '',; //X3_PROPRI
		      'S',; //X3_BROWSE
		      'V',; //X3_VISUAL
		      '',; //X3_CONTEXT
		      '',; //X3_OBRIGAT
		      '',; //X3_VLDUSER
		      '',; //X3_CBOX
		      '',; //X3_CBOXSPA
		      '',; //X3_CBOXENG
		      '',; //X3_PICTVAR
		      '',; //X3_WHEN
		      '',; //X3_INIBRW
		      '',; //X3_GRPSXG
		      '1',; //X3_FOLDER
		      'S',;
		      {"Código do tipo de tabela."}}) //X3_PYME

cSeqXA2 := soma1(cSeqXA2)
aAdd(aSX3,{	  "XA2",; //X3_ARQUIVO
		      cSeqXA2,; //X3_ORDEM
		      'XA2_CODPRO',; //X3_CAMPO
		      'C',; //X3_TIPO
		      16,; //X3_TAMANHO
		      0,; //X3_DECIMAL
		      'Cod. Proc.',; //X3_TITULO
		      '',; //X3_TITSPA
		      '',; //X3_TITENG
		      'Cod Proc.',; //X3_DESCRIC
		      '',; //X3_DESCSPA
		      '',; //X3_DESCENG
		      '@!',; //X3_PICTURE
		      'U_PL003VLT()',; //X3_VALID
		      X3_USADO,; //X3_USADO
		      '',; //X3_RELACAO
		      'XA1FF1',; //X3_F3
		      1,; //X3_NIVEL
		      X3_OBRIGAT,; //X3_RESERV
		      '',; //X3_CHECK
		      '',; //X3_TRIGGER
		      '',; //X3_PROPRI
		      'S',; //X3_BROWSE
		      'V',; //X3_VISUAL
		      '',; //X3_CONTEXT
		      '',; //X3_OBRIGAT
		      '',; //X3_VLDUSER
		      '',; //X3_CBOX
		      '',; //X3_CBOXSPA
		      '',; //X3_CBOXENG
		      '',; //X3_PICTVAR
		      '',; //X3_WHEN
		      '',; //X3_INIBRW
		      '',; //X3_GRPSXG
		      '1',; //X3_FOLDER
		      'S',;
		      {"Código do procedimento"}}) //X3_PYME
		
cSeqXA2 := soma1(cSeqXA2)
aAdd(aSX3,{	  "XA2",; //X3_ARQUIVO
		      cSeqXA2,; //X3_ORDEM
		      'XA2_DESPRO',; //X3_CAMPO
		      'C',; //X3_TIPO
		      50,; //X3_TAMANHO
		      0,; //X3_DECIMAL
		      'Descrição',; //X3_TITULO
		      '',; //X3_TITSPA
		      '',; //X3_TITENG
		      'Descrição Procedimento',; //X3_DESCRIC
		      '',; //X3_DESCSPA
		      '',; //X3_DESCENG
		      '@!',; //X3_PICTURE
		      '',; //X3_VALID
		      X3_USADO,; //X3_USADO
		      '',; //X3_RELACAO
		      '',; //X3_F3
		      1,; //X3_NIVEL
		      X3_NAOOBRIGAT,; //X3_RESERV
		      '',; //X3_CHECK
		      '',; //X3_TRIGGER
		      '',; //X3_PROPRI
		      'S',; //X3_BROWSE
		      'V',; //X3_VISUAL
		      '',; //X3_CONTEXT
		      '',; //X3_OBRIGAT
		      '',; //X3_VLDUSER
		      '',; //X3_CBOX
		      '',; //X3_CBOXSPA
		      '',; //X3_CBOXENG
		      '',; //X3_PICTVAR
		      '',; //X3_WHEN
		      '',; //X3_INIBRW
		      '',; //X3_GRPSXG
		      '1',; //X3_FOLDER
		      'S'}) //X3_PYME


cSeqXA2 := soma1(cSeqXA2)
aAdd(aSX3,{	  "XA2",; //X3_ARQUIVO
		      cSeqXA2,; //X3_ORDEM
		      'XA2_DESQUE',; //X3_CAMPO
		      'C',; //X3_TIPO
		      60,; //X3_TAMANHO
		      0,; //X3_DECIMAL
		      'Motivo',; //X3_TITULO
		      '',; //X3_TITSPA
		      '',; //X3_TITENG
		      '',; //X3_DESCRIC
		      '',; //X3_DESCSPA
		      '',; //X3_DESCENG
		      '@!',; //X3_PICTURE
		      '',; //X3_VALID
		      X3_USADO,; //X3_USADO
		      '',; //X3_RELACAO
		      '',; //X3_F3
		      1,; //X3_NIVEL
		      X3_OBRIGAT,; //X3_RESERV
		      '',; //X3_CHECK
		      '',; //X3_TRIGGER
		      '',; //X3_PROPRI
		      'S',; //X3_BROWSE
		      'A',; //X3_VISUAL
		      'R',; //X3_CONTEXT
		      '',; //X3_OBRIGAT
		      '',; //X3_VLDUSER
		      '',; //X3_CBOX
		      '',; //X3_CBOXSPA
		      '',; //X3_CBOXENG
		      '',; //X3_PICTVAR
		      '',; //X3_WHEN
		      '',; //X3_INIBRW
		      '',; //X3_GRPSXG
		      '1',; //X3_FOLDER
		      'S',;//X3_PYME
		      {"Descrição do motivo do questionamento"}}) 

cSeqXA2 := soma1(cSeqXA2)
aAdd(aSX3,{	  "XA2",; //X3_ARQUIVO
      		  cSeqXA2,; //X3_ORDEM
      		  'XA2_STATUS',; //X3_CAMPO
      		  'C',; //X3_TIPO
      		  1,; //X3_TAMANHO
		      0,; //X3_DECIMAL
		      'Status',; //X3_TITULO
		      '',; //X3_TITSPA
		      '',; //X3_TITENG
		      'Status',; //X3_DESCRIC
		      '',; //X3_DESCSPA
		      '',; //X3_DESCENG
		      '@!',; //X3_PICTURE
		      '',; //X3_VALID
		      X3_USADO,; //X3_USADO
		      '"1"',; //X3_RELACAO
		      '',; //X3_F3
		      0,; //X3_NIVEL
		      X3_OBRIGAT,; //X3_RESERV
		      '',; //X3_CHECK
		      '',; //X3_TRIGGER
		      'S',; //X3_PROPRI
		      'N',; //X3_BROWSE
		      'A',; //X3_VISUAL
		      'R',; //X3_CONTEXT
		      'S',; //X3_OBRIGAT
		      '',; //X3_VLDUSER     
		      '1=Recurso em Negoc.;'+;
		      '2=Recurso Aceito;'+;
			  '3=Recurso Negado',;
		      '',; //X3_CBOXSPA
		      '',; //X3_CBOXENG
		      '',; //X3_PICTVAR
		      '',; //X3_WHEN
		      '',; //X3_INIBRW
		      '',; //X3_GRPSXG
		      '1',; //X3_FOLDER
		      'S',;
		      {"Status da negociação"}} ) 


cSeqXA2 := soma1(cSeqXA2)
aAdd(aSX3,{	  "XA2",; //X3_ARQUIVO
		      cSeqXA2,; //X3_ORDEM
		      'XA2_DESNEG',; //X3_CAMPO
		      'C',; //X3_TIPO
		      60,; //X3_TAMANHO
		      0,; //X3_DECIMAL
		      'Parecer',; //X3_TITULO
		      '',; //X3_TITSPA
		      '',; //X3_TITENG
		      '',; //X3_DESCRIC
		      '',; //X3_DESCSPA
		      '',; //X3_DESCENG
		      '@!',; //X3_PICTURE
		      '',; //X3_VALID
		      X3_USADO,; //X3_USADO
		      '',; //X3_RELACAO
		      '',; //X3_F3
		      1,; //X3_NIVEL
		      X3_NAOOBRIGAT,; //X3_RESERV
		      '',; //X3_CHECK
		      '',; //X3_TRIGGER
		      '',; //X3_PROPRI
		      'S',; //X3_BROWSE
		      'A',; //X3_VISUAL
		      'R',; //X3_CONTEXT
		      '',; //X3_OBRIGAT
		      '',; //X3_VLDUSER
		      '',; //X3_CBOX
		      '',; //X3_CBOXSPA
		      '',; //X3_CBOXENG
		      '',; //X3_PICTVAR
		      'M->XA2_STATUS <> "1"',; //X3_WHEN
		      '',; //X3_INIBRW
		      '',; //X3_GRPSXG
		      '1',; //X3_FOLDER
		      'S',;//X3_PYME
		      {"Motivo da recusa."}}) 


cSeqXA2 := soma1(cSeqXA2)
aAdd(aSX3,{	  "XA2",; //X3_ARQUIVO
      		  cSeqXA2,; //X3_ORDEM
      		  'XA2_DATACO',; //X3_CAMPO
      		  'D',; //X3_TIPO
      		  8,; //X3_TAMANHO
		      0,; //X3_DECIMAL
		      'Data Parec.',; //X3_TITULO
		      '',; //X3_TITSPA
		      '',; //X3_TITENG
		      'Data do Parecer',; //X3_DESCRIC
		      '',; //X3_DESCSPA
		      '',; //X3_DESCENG
		      '@!',; //X3_PICTURE
		      '',; //X3_VALID
		      X3_USADO,; //X3_USADO
		      'dDataBase',; //X3_RELACAO
		      '',; //X3_F3
		      0,; //X3_NIVEL
		      X3_OBRIGAT,; //X3_RESERV
		      '',; //X3_CHECK
		      '',; //X3_TRIGGER
		      'S',; //X3_PROPRI
		      'S',; //X3_BROWSE
		      'A',; //X3_VISUAL
		      'R',; //X3_CONTEXT
		      'S',; //X3_OBRIGAT
		      '',; //X3_VLDUSER
		      '',; //X3_CBOX
		      '',; //X3_CBOXSPA
		      '',; //X3_CBOXENG
		      '',; //X3_PICTVAR
		      '',; //X3_WHEN
		      '',; //X3_INIBRW
		      '',; //X3_GRPSXG
		      '1',; //X3_FOLDER
		      'S',;//X3_PYME
		      {"Data Acordo"}} ) 

cSeqXA2 := soma1(cSeqXA2)
aAdd(aSX3,{	  "XA2",; //X3_ARQUIVO
		      cSeqXA2,; //X3_ORDEM
		      'XA2_QTDPRO',; //X3_CAMPO
		      'N',; //X3_TIPO
		      17,; //X3_TAMANHO
		      2,; //X3_DECIMAL
		      'Qtd.Cobr.',; //X3_TITULO
		      '',; //X3_TITSPA
		      '',; //X3_TITENG
		      'Qtd Cobrado',; //X3_DESCRIC
		      '',; //X3_DESCSPA
		      '',; //X3_DESCENG
		      '@E 999,999,999.99',; //X3_PICTURE
		      '',; //X3_VALID
		      X3_USADO,; //X3_USADO
		      '',; //X3_RELACAO
		      '',; //X3_F3
		      1,; //X3_NIVEL
		      X3_NAOOBRIGAT,; //X3_RESERV
		      '',; //X3_CHECK
		      '',; //X3_TRIGGER
		      '',; //X3_PROPRI
		      'S',; //X3_BROWSE
		      'V',; //X3_VISUAL
		      '',; //X3_CONTEXT
		      '',; //X3_OBRIGAT
		      '',; //X3_VLDUSER
		      '',; //X3_CBOX
		      '',; //X3_CBOXSPA
		      '',; //X3_CBOXENG
		      '',; //X3_PICTVAR
		      '',; //X3_WHEN
		      '',; //X3_INIBRW
		      '',; //X3_GRPSXG
		      '1',; //X3_FOLDER
		      'S',;//X3_PYME
		      {"Qtd cobrado pela operadora destino."}}) 


cSeqXA2 := soma1(cSeqXA2)
aAdd(aSX3,{	  "XA2",; //X3_ARQUIVO
		      cSeqXA2,; //X3_ORDEM
		      'XA2_VLRCOB',; //X3_CAMPO
		      'N',; //X3_TIPO
		      17,; //X3_TAMANHO
		      2,; //X3_DECIMAL
		      'Vlr.Glo.',; //X3_TITULO
		      '',; //X3_TITSPA
		      '',; //X3_TITENG
		      'Valor Glosado',; //X3_DESCRIC
		      '',; //X3_DESCSPA
		      '',; //X3_DESCENG
		      '@E 999,999,999.99',; //X3_PICTURE
		      '',; //X3_VALID
		      X3_USADO,; //X3_USADO
		      '',; //X3_RELACAO
		      '',; //X3_F3
		      1,; //X3_NIVEL
		      X3_NAOOBRIGAT,; //X3_RESERV
		      '',; //X3_CHECK
		      '',; //X3_TRIGGER
		      '',; //X3_PROPRI
		      'S',; //X3_BROWSE
		      'V',; //X3_VISUAL
		      '',; //X3_CONTEXT
		      '',; //X3_OBRIGAT
		      '',; //X3_VLDUSER
		      '',; //X3_CBOX
		      '',; //X3_CBOXSPA
		      '',; //X3_CBOXENG
		      '',; //X3_PICTVAR
		      '',; //X3_WHEN
		      '',; //X3_INIBRW
		      '',; //X3_GRPSXG
		      '1',; //X3_FOLDER
		      'S',;//X3_PYME
		      {"Valor glosado pela operadora destino."}}) 

cSeqXA2 := soma1(cSeqXA2)
aAdd(aSX3,{	  "XA2",; //X3_ARQUIVO
		      cSeqXA2,; //X3_ORDEM
		      'XA2_VLRREC',; //X3_CAMPO
		      'N',; //X3_TIPO
		      17,; //X3_TAMANHO
		      2,; //X3_DECIMAL
		      'Vlr.Reco.',; //X3_TITULO
		      '',; //X3_TITSPA
		      '',; //X3_TITENG
		      'Valor Reconhecido',; //X3_DESCRIC
		      '',; //X3_DESCSPA
		      '',; //X3_DESCENG
		      '@E 999,999,999.99',; //X3_PICTURE
		      '',; //X3_VALID
		      X3_USADO,; //X3_USADO
		      '',; //X3_RELACAO
		      '',; //X3_F3
		      1,; //X3_NIVEL
		      X3_NAOOBRIGAT,; //X3_RESERV
		      '',; //X3_CHECK
		      '',; //X3_TRIGGER
		      '',; //X3_PROPRI
		      'S',; //X3_BROWSE
		      '',; //X3_VISUAL
		      '',; //X3_CONTEXT
		      '',; //X3_OBRIGAT
		      '',; //X3_VLDUSER
		      '',; //X3_CBOX
		      '',; //X3_CBOXSPA
		      '',; //X3_CBOXENG
		      '',; //X3_PICTVAR
		      '',; //X3_WHEN
		      '',; //X3_INIBRW
		      '',; //X3_GRPSXG
		      '1',; //X3_FOLDER
		      'S',;//X3_PYME
		      {"Valor pago pela operadora origem."}})    

cSeqXA2 := soma1(cSeqXA2)
aAdd(aSX3,{	  "XA2",; //X3_ARQUIVO
		      cSeqXA2,; //X3_ORDEM
		      'XA2_SALDO',; //X3_CAMPO
		      'N',; //X3_TIPO
		      17,; //X3_TAMANHO
		      2,; //X3_DECIMAL
		      'Saldo.',; //X3_TITULO
		      '',; //X3_TITSPA
		      '',; //X3_TITENG
		      'Saldo',; //X3_DESCRIC
		      '',; //X3_DESCSPA
		      '',; //X3_DESCENG
		      '@E 999,999,999.99',; //X3_PICTURE
		      '',; //X3_VALID
		      X3_USADO,; //X3_USADO
		      '',; //X3_RELACAO
		      '',; //X3_F3
		      1,; //X3_NIVEL
		      X3_NAOOBRIGAT,; //X3_RESERV
		      '',; //X3_CHECK
		      '',; //X3_TRIGGER
		      '',; //X3_PROPRI
		      'S',; //X3_BROWSE
		      'V',; //X3_VISUAL
		      '',; //X3_CONTEXT
		      '',; //X3_OBRIGAT
		      '',; //X3_VLDUSER
		      '',; //X3_CBOX
		      '',; //X3_CBOXSPA
		      '',; //X3_CBOXENG
		      '',; //X3_PICTVAR
		      '',; //X3_WHEN
		      '',; //X3_INIBRW
		      '',; //X3_GRPSXG
		      '1',; //X3_FOLDER
		      'S',;//X3_PYME
		      {"Saldo do Item."}}) 		      

cSeqBGQ := '30'
aAdd(aSX3,{	  "BGQ",; //X3_ARQUIVO
		      cSeqBGQ,; //X3_ORDEM
		      'BGQ_YRECGL',; //X3_CAMPO
		      'C',; //X3_TIPO
		      12,; //X3_TAMANHO
		      0,; //X3_DECIMAL
		      'Seq. Rec.',; //X3_TITULO
		      '',; //X3_TITSPA
		      '',; //X3_TITENG
		      'Seq. Rec.',; //X3_DESCRIC
		      '',; //X3_DESCSPA
		      '',; //X3_DESCENG
		      '@!',; //X3_PICTURE
		      '',; //X3_VALID
		      X3_NAOUSADO,; //X3_USADO
		      '',; //X3_RELACAO
		      '',; //X3_F3
		      1,; //X3_NIVEL
		      X3_NAOOBRIGAT,; //X3_RESERV
		      '',; //X3_CHECK
		      '',; //X3_TRIGGER
		      '',; //X3_PROPRI
		      'N',; //X3_BROWSE
		      'V',; //X3_VISUAL
		      '',; //X3_CONTEXT
		      '',; //X3_OBRIGAT
		      '',; //X3_VLDUSER
		      '',; //X3_CBOX
		      '',; //X3_CBOXSPA
		      '',; //X3_CBOXENG
		      '',; //X3_PICTVAR
		      '',; //X3_WHEN
		      '',; //X3_INIBRW
		      '',; //X3_GRPSXG
		      '',; //X3_FOLDER
		      'S'}) //X3_PYME
		
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Atualiza SX3                                                               |
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
ProcRegua( Len(aSX3) )

ProcRegua(Len(aSX3))
SX3->(DbSetOrder(2))	
dBSelectArea("SX3")	 

For i:= 1 To Len(aSX3)
		
	If !Empty(aSX3[i][1])
		If !dbSeek(aSX3[i,3])
			If Len(aSX3[i]) >= 37 .and. aSX3[i][Len(aSX3[i])] = NIL .And. aSX3[i][Len(aSX3[i])] == .T.
				loop
			Endif
			RecLock("SX3",.T.)
		Else
			RecLock("SX3",.F.)
		EndIf
		If !(aSX3[i,1]$cAlias)
			cAlias += CHR(13)+CHR(10)+aSX3[i,1]+CHR(13)+CHR(10)
			aAdd(aArqUpd,aSX3[i,1])
		EndIf
		For j:=1 To Len(aSX3[i])
			If j <= 36
				If FieldPos(aEstrut[j])>0 .And. aSX3[i,j] != NIL
					FieldPut(FieldPos(aEstrut[j]),aSX3[i,j])
				EndIf              
				If aEstrut[j] == "L_DELETED"
				     If Len(aSX3[i]) == j .and. aSX3[i,j] != NIL .and. aSX3[i,j] == .T.
				          DbDelete()
				     Endif
				Endif
			Else	
				If aSX3[i,j] != NIL
					// Grava Help
					cHelp1 := Iif(Len(aSX3[i])>36,aSX3[i,37],"")
					cHelp2 := Iif(Len(aSX3[i])>37,aSX3[i,38],"")
					cHelp3 := Iif(Len(aSX3[i])>38,aSX3[i,39],"")
					cHelp4 := Iif(Len(aSX3[i])>39,aSX3[i,40],"")
					cHelp5 := Iif(Len(aSX3[i])>40,aSX3[i,41],"")
					cHelp6 := Iif(Len(aSX3[i])>41,aSX3[i,42],"")  
					cCampo := aSX3[i,3]
					
					PutHelp("P"+aSX3[i,3],	{cHelp1,cHelp2,cHelp3,cHelp4,cHelp5,cHelp6},;
											{cHelp1,cHelp2,cHelp3,cHelp4,cHelp5,cHelp6},;
											{cHelp1,cHelp2,cHelp3,cHelp4,cHelp5,cHelp6},.T.)	
				Endif
			Endif			
		Next j
		dbCommit()
		MsUnLock()
		IncProc("Atualizando Dicionário de Dados...")
	EndIf
next i

If lSX3
	cTexto := "Foram alteradas as estruturas das seguintes tabelas : "+CHR(13)+CHR(10)+cAlias+CHR(13)+CHR(10)  //
	cTexto += "Sendo criados/alterados os seguintes campos: "+ CHR(13)+CHR(10)+cCampos+CHR(13)+CHR(10)  //
EndIf

Return(cTexto)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³PLSAtuSX2 ³ Autor ³ Daher				    ³ Data ³ 11/11/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ 															  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Atualizacao FIS                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function PLSAtuSX2()
LOCAL cPath
LOCAL aSX2           := {}
LOCAL aEstrut        := {}
LOCAL i              := 0
LOCAL j              := 0
LOCAL lSX2	         := .F.
LOCAL cTexto         := ''
LOCAL cAlias         := ''

aEstrut:= { "X2_CHAVE","X2_PATH","X2_ARQUIVO","X2_NOME","X2_NOMESPA","X2_NOMEENG","X2_ROTINA","X2_MODO","X2_DELET","X2_TTS","X2_UNICO","X2_PYME"}

DbSelectarea("SX2")                                                                                    
SX2->( DbSetOrder(1) )     
SX2->( MsSeek("BAU") )
cPath := SX2->X2_PATH

If !SX2->( MsSeek("XA1") )
	aAdd(aSX2,{	"XA1",;								// Chave
				cPath,;								// Path
				"XA1"+Substr(RetSqlName("BA1"),4),;// Arquivo
				"Cabeçalho Recurso",;	// Nome
				"",;								// Nome Espanhol
				"",;								// nome ingles
				"",;								// Rotina
				"C",;								// Modo
				0,;									// Delet
				"",;								// TTS
				"",;								// Unico
				"N"})								// PYME
EndIf

If !SX2->( MsSeek("XA2") )
	aAdd(aSX2,{	"XA2",;								// Chave
				cPath,;								// Path
				"XA2"+Substr(RetSqlName("BA1"),4),;// Arquivo
				"Itens Recurso",;	// Nome
				"",;								// Nome Espanhol
				"",;								// nome ingles
				"",;								// Rotina
				"C",;								// Modo
				0,;									// Delet
				"",;								// TTS
				"",;								// Unico
				"N"})								// PYME
EndIf


ProcRegua(Len(aSX2))

SX2->(DbSetOrder(1))
For i:= 1 To Len(aSX2)
	If !Empty(aSX2[i][1])
		If !MsSeek(aSX2[i,1])
			RecLock("SX2",.T.)
		Else
			RecLock("SX2",.F.)
		EndIf
		lSX2	:= .T.
		If !(aSX2[i,1]$cAlias)
			cAlias += aSX2[i,1]+CHR(13)+CHR(10)
			aAdd(aArqUpd,aSX2[i,1])
		EndIf
		For j:=1 To Len(aSX2[i])
			If FieldPos(aEstrut[j])>0 .And. aSX2[i,j] != NIL
				FieldPut(FieldPos(aEstrut[j]),aSX2[i,j])
			EndIf
		Next j
		dbCommit()
		MsUnLock()
		IncProc("Atualizando Dicionário de Dados...("+aSX2[i,1]+")")
		ProcessMessage()
	EndIf
Next i

If lSX2
	cTexto := 'As seguintes tabelas foram criadas/alteradas no SX2 : '+CHR(13)+CHR(10)+cAlias+CHR(13)+CHR(10)
EndIf

Return cTexto

Static Function PlsAtuSIX()

Local cTexto    := ''
Local lSix      := .F.
Local aSix      := {}
Local aEstrut   := {}
Local i         := 0
Local j         := 0
Local cAlias    := ''
Local lDelInd   := .F.

aEstrut:= {"INDICE","ORDEM","CHAVE","DESCRICAO","DESCSPA","DESCENG","PROPRI","F3","NICKNAME","SHOWPESQ"}

aAdd(aSIX,{	"XA1",; //INDICE
      '1',; //ORDEM
      'XA1_FILIAL + XA1_OPECRE + XA1_CODQUE ',; //CHAVE
      'Operadora+Código Recurso',; //DESCRICAO
      '',; //DESCSPA
      '',; //DESCENG
      'S',; //PROPRI
      '',; //F3
      '',; //NICKNAME
      'S'}) //SHOWPESQ

aAdd(aSIX,{	"XA1",; //INDICE
      '2',; //ORDEM
      'XA1_FILIAL + XA1_OPECRE + XA1_CODRDA ',; //CHAVE
      'Operadora+Código RDA',; //DESCRICAO
      '',; //DESCSPA
      '',; //DESCENG
      'S',; //PROPRI
      '',; //F3
      '',; //NICKNAME
      'S'}) //SHOWPESQ

aAdd(aSIX,{	"XA2",; //INDICE
      '1',; //ORDEM
      'XA2_FILIAL + XA2_OPECRE + XA2_CODQUE + XA2_SEQQUE',; //CHAVE
      'Operadora+Código Recurso+Sequencial',; //DESCRICAO
      '',; //DESCSPA
      '',; //DESCENG
      'S',; //PROPRI
      '',; //F3
      '',; //NICKNAME
      'S'}) //SHOWPESQ

aAdd(aSIX,{	"XA2",; //INDICE
      '2',; //ORDEM
      'XA2_FILIAL + XA2_CODOPE + XA2_CODLDP + XA2_CODPEG + XA2_NUMERO + XA2_ORIMOV + XA2_SEQUEN',; //CHAVE
      'Operadora+Local+PEG+Número+Origem+Sequencial',; //DESCRICAO
      '',; //DESCSPA
      '',; //DESCENG
      'S',; //PROPRI
      '',; //F3
      '',; //NICKNAME
      'S'}) //SHOWPESQ

aAdd(aSIX,{	"XA2",; //INDICE
      '3',; //ORDEM
      'XA2_FILIAL + XA2_CODOPE + XA2_CODQUE + XA2_STATUS',; //CHAVE
      'Operadora+Codigo Recurso+Sequencial',; //DESCRICAO
      '',; //DESCSPA
      '',; //DESCENG
      'S',; //PROPRI
      '',; //F3
      '',; //NICKNAME
      'S'}) //SHOWPESQ


aAdd(aSIX,{	"BGQ",; //INDICE
      'B',; //ORDEM
      'BGQ_FILIAL + BGQ_YRECGL ',; //CHAVE
      'Operadora+Codigo Recurso',; //DESCRICAO
      '',; //DESCSPA
      '',; //DESCENG
      'S',; //PROPRI
      '',; //F3
      'GLOSA',; //NICKNAME
      'S'}) //SHOWPESQ
	
ProcRegua(Len(aSIX))

dbSelectArea("SIX")
SIX->(DbSetOrder(1))	                                           

For i:= 1 To Len(aSIX)
	If !Empty(aSIX[i,1])
		If !MsSeek(aSIX[i,1]+aSIX[i,2])
			RecLock("SIX",.T.)
			lDelInd := .F.
		Else
			RecLock("SIX",.F.)
			lDelInd := .T. //Se for alteracao precisa apagar o indice do banco
		EndIf
		
		If PadR(UPPER(AllTrim(CHAVE)),160) != PadR(UPPER(Alltrim(aSIX[i,3])),160)
			aAdd(aArqUpd,aSIX[i,1])
			lSix := .T.
			If !(aSIX[i,1]$cAlias)
				cAlias += aSIX[i,1]+CHR(13)+CHR(10)
			EndIf
			For j:=1 To Len(aSIX[i])
				If FieldPos(aEstrut[j])>0
					FieldPut(FieldPos(aEstrut[j]),aSIX[i,j])
				EndIf
			Next j
			dbCommit()        
			MsUnLock()
			cTexto  += ("Índice " + aSix[i][2] + ": " + aSix[i][1] + " - " + aSix[i][3] + Chr(13) + Chr(10))
			If lDelInd
				TcInternal(60,RetSqlName(aSix[i,1]) + "|" + RetSqlName(aSix[i,1]) + aSix[i,2]) //Exclui sem precisar baixar o TOP
			Endif	
		Else
			MsUnLock()
		Endif
		IncProc("Atualizando índices...")
	EndIf
Next i

If lSix
	cTexto += "Índices atualizados  : "+CHR(13)+CHR(10)+cAlias+CHR(13)+CHR(10)
EndIf

Return(cTexto)


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³PLSAtuSX7 ³ Autor ³ Daher				    ³ Data ³ 11/11/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ 															  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Atualizacao FIS                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function PLSAtuSX7()

Local aSX7   	:= {}
Local aEstrut	:= {"X7_CAMPO","X7_SEQUENC","X7_REGRA","X7_CDOMIN","X7_TIPO","X7_SEEK","X7_ALIAS","X7_ORDEM","X7_CHAVE","X7_PROPRI","X7_CONDIC"}
Local i      	:= 0
Local j      	:= 0
Local cRet		:= ""

aAdd( aSX7, { ;
	'XA2_VLRREC'															, ; //X7_CAMPO
	'001'																	, ; //X7_SEQUENC
	'U_SLDGLOSA(M->XA2_CODOPE,M->XA2_CODLDP,M->XA2_CODPEG,M->XA2_NUMERO,M->XA2_SEQUEN,XA1->XA1_CODRDA)' 														, ; //X7_REGRA
	'XA2_SALDO'															, ; //X7_CDOMIN
	'P'																		, ; //X7_TIPO
	'N'																		, ; //X7_SEEK
	''																	, ; //X7_ALIAS
	0																		, ; //X7_ORDEM
	''							, ; //X7_CHAVE
	'U'																		, ; //X7_PROPRI
	''																		} ) //X7_CONDIC							

aAdd( aSX7, { ;
	'XA2_VLRREC'															, ; //X7_CAMPO
	'002'																	, ; //X7_SEQUENC
	'M->XA2_SALDO-M->XA2_VLRREC' 											, ; //X7_REGRA
	'XA2_SALDO'															, ; //X7_CDOMIN
	'P'																		, ; //X7_TIPO
	'N'																		, ; //X7_SEEK
	''																	, ; //X7_ALIAS
	0																		, ; //X7_ORDEM
	''							, ; //X7_CHAVE
	'U'																		, ; //X7_PROPRI
	'M->XA2_SALDO <> -1'				} ) //X7_CONDIC	
      		                                            
aAdd( aSX7, { ;
	'XA2_VLRREC'															, ; //X7_CAMPO
	'003'																	, ; //X7_SEQUENC
	'M->XA2_VLRCOB-M->XA2_VLRREC' 											, ; //X7_REGRA
	'XA2_SALDO'															, ; //X7_CDOMIN
	'P'																		, ; //X7_TIPO
	'N'																		, ; //X7_SEEK
	''																	, ; //X7_ALIAS
	0																		, ; //X7_ORDEM
	''							, ; //X7_CHAVE
	'U'																		, ; //X7_PROPRI
	'M->XA2_SALDO == -1'				} ) //X7_CONDIC	
      		
DbSelectarea("SX7")   
ProcRegua(Len(aSX7))

SX7->(DbSetOrder(1))
For i:= 1 To Len(aSX7)
	If !Empty(aSX7[i][1])
	
		iF Len(aSX7[i,1]) < 10
			aSX7[i,1]	:= PadR(aSX7[i,1],10)
		EndIf
		If !Msseek(aSX7[i,1]+aSX7[i,2])
			RecLock("SX7",.T.)
		Else
			RecLock("SX7",.F.)
		Endif
		cRet += aSX7[i,1]+'['+aSX7[i,2]+']'+CHR(13)+CHR(10)
		For j:=1 To Len(aSX7[i])
			If !Empty(FieldName(FieldPos(aEstrut[j]))) .And. aSX7[i,j] != NIL
				FieldPut(FieldPos(aEstrut[j]),aSX7[i,j])
			EndIf
		Next j
		dbCommit()
		MsUnLock()
		IncProc("Atualizando Gatilhos...("+aSX7[i,1]+")")
		ProcessMessage()
	EndIf
Next i
cRet := 'Foram alterados/criados os seguintes gatilhos : '+CHR(13)+CHR(10)+cRet+CHR(13)+CHR(10)

Return(cRet) 


/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³AjustaSXB ºAutor  ³PLS-Team            º Data ³ 18/01/2011  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Ajusta no grupo consulta padrao.                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       |PLSR249                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß 
*/
Static Function PlsAtuSXB()
	Local aEstrut 	:= {}
	Local aSXB    	:= {}
	Local i       	:= 0
	Local j       	:= 0
	Local cTexto	:= ""
	    

	aEstrut := {"XB_ALIAS","XB_TIPO","XB_SEQ","XB_COLUNA","XB_DESCRI","XB_DESCSPA","XB_DESCENG","XB_CONTEM",'XB_WCONTEM'}	

	aAdd(aSXB,{	"ZA1PLS",; //XB_ALIAS
	      '1',; //XB_TIPO
	      '01',; //XB_SEQ         
	      'DB',; //XB_COLUNA
	      'Contestação',; //XB_DESCRI
	      '',; //XB_DESCSPA
	      '',; //XB_DESCENG
	      'ZA1',; //XB_CONTEM
	      ''}) //XB_WCONTEM
	

	aAdd(aSXB,{	"ZA1PLS",; //XB_ALIAS
	      '2',; //XB_TIPO
	      '01',; //XB_SEQ
	      '01',; //XB_COLUNA
	      'Cód.Quest.',; //XB_DESCRI
	      '',; //XB_DESCSPA
	      '',; //XB_DESCENG
	      '',; //XB_CONTEM
	      ''}) //XB_WCONTEM
		
	aAdd(aSXB,{	"ZA1PLS",; //XB_ALIAS
	      '4',; //XB_TIPO
	      '01',; //XB_SEQ
	      '01',; //XB_COLUNA
	      'Ope. Credora',; //XB_DESCRI
	      '',; //XB_DESCSPA
	      '',; //XB_DESCENG
	      'ZA1->XA1_OPECRE',; //XB_CONTEM
	      ''}) //XB_WCONTEM    
    
    aAdd(aSXB,{	"ZA1PLS",; //XB_ALIAS
	      '4',; //XB_TIPO
	      '01',; //XB_SEQ
	      '02',; //XB_COLUNA
	      'Questionamento',; //XB_DESCRI
	      '',; //XB_DESCSPA
	      '',; //XB_DESCENG
	      'ZA1->XA1_CODQUE',; //XB_CONTEM
	      ''}) //XB_WCONTEM    


	aAdd(aSXB,{	"ZA1PLS",; //XB_ALIAS
	      '5',; //XB_TIPO
	      '01',; //XB_SEQ
	      '',; //XB_COLUNA
	      '',; //XB_DESCRI
	      '',; //XB_DESCSPA
	      '',; //XB_DESCENG
	      'ZA1->(XA1_OPECRE+XA1_CODQUE)',; //XB_CONTEM
	      ''}) //XB_WCONTEM

	

	aAdd(aSXB,{	"XA1FF1",; //XB_ALIAS
	      '1',; //XB_TIPO
	      '01',; //XB_SEQ         
	      'RE',; //XB_COLUNA
	      '',; //XB_DESCRI
	      '',; //XB_DESCSPA
	      '',; //XB_DESCENG
	      'BR8',; //XB_CONTEM
	      ''}) //XB_WCONTEM

	aAdd(aSXB,{	"XA1FF1",; //XB_ALIAS
	      '2',; //XB_TIPO
	      '01',; //XB_SEQ         
	      '01',; //XB_COLUNA
	      '',; //XB_DESCRI
	      '',; //XB_DESCSPA
	      '',; //XB_DESCENG
	      'PLSPESPROC(M->XA2_CODPAD,.F.)',; //XB_CONTEM
	      ''}) //XB_WCONTEM

	aAdd(aSXB,{	"XA1FF1",; //XB_ALIAS
	      '5',; //XB_TIPO
	      '01',; //XB_SEQ         
	      '01',; //XB_COLUNA
	      '',; //XB_DESCRI
	      '',; //XB_DESCSPA
	      '',; //XB_DESCENG
	      'BR8_CODPSA',; //XB_CONTEM
	      ''}) //XB_WCONTEM


	aAdd(aSXB,{	"BCMPLS",; //XB_ALIAS
	      '1',; //XB_TIPO
	      '01',; //XB_SEQ         
	      'DB',; //XB_COLUNA
	      '',; //XB_DESCRI
	      '',; //XB_DESCSPA
	      '',; //XB_DESCENG
	      'BCI',; //XB_CONTEM
	      ''}) //XB_WCONTEM

	aAdd(aSXB,{	"BCMPLS",; //XB_ALIAS
	      '2',; //XB_TIPO
	      '01',; //XB_SEQ         
	      '01',; //XB_COLUNA
	      'Código',; //XB_DESCRI
	      '',; //XB_DESCSPA
	      '',; //XB_DESCENG
	      '',; //XB_CONTEM
	      ''}) //XB_WCONTEM


	aAdd(aSXB,{	"BCMPLS",; //XB_ALIAS
	      '4',; //XB_TIPO
	      '01',; //XB_SEQ         
	      '01',; //XB_COLUNA
	      'Operadora',; //XB_DESCRI
	      '',; //XB_DESCSPA
	      '',; //XB_DESCENG
	      'BCI_CODOPE',; //XB_CONTEM
	      ''}) //XB_WCONTEM
	      
	      
	aAdd(aSXB,{	"BCMPLS",; //XB_ALIAS
	      '4',; //XB_TIPO
	      '01',; //XB_SEQ         
	      '02',; //XB_COLUNA
	      'Local',; //XB_DESCRI
	      '',; //XB_DESCSPA
	      '',; //XB_DESCENG
	      'BCI_CODLDP',; //XB_CONTEM
	      ''}) //XB_WCONTEM
	
	aAdd(aSXB,{	"BCMPLS",; //XB_ALIAS
	      '4',; //XB_TIPO
	      '01',; //XB_SEQ         
	      '03',; //XB_COLUNA
	      'Cod.PEG',; //XB_DESCRI
	      '',; //XB_DESCSPA
	      '',; //XB_DESCENG
	      'BCI_CODPEG',; //XB_CONTEM
	      ''}) //XB_WCONTEM  

	aAdd(aSXB,{	"BCMPLS",; //XB_ALIAS
	      '4',; //XB_TIPO
	      '01',; //XB_SEQ         
	      '04',; //XB_COLUNA
	      'Nome',; //XB_DESCRI
	      '',; //XB_DESCSPA
	      '',; //XB_DESCENG
	      'BCI_NOMRDA',; //XB_CONTEM
	      ''}) //XB_WCONTEM  
	       
	aAdd(aSXB,{	"BCMPLS",; //XB_ALIAS
	      '5',; //XB_TIPO
	      '01',; //XB_SEQ         
	      '01',; //XB_COLUNA
	      '',; //XB_DESCRI
	      '',; //XB_DESCSPA
	      '',; //XB_DESCENG
	      'BCI_CODPEG',; //XB_CONTEM
	      ''}) //XB_WCONTEM

	aAdd(aSXB,{	"BCMPLS",; //XB_ALIAS
	      '6',; //XB_TIPO
	      '01',; //XB_SEQ         
	      '01',; //XB_COLUNA
	      '',; //XB_DESCRI
	      '',; //XB_DESCSPA
	      '',; //XB_DESCENG
	      'BCI->BCI_CODOPE == MV_PAR01 .AND. BCI->BCI_CODLDP == MV_PAR02',; //XB_CONTEM
	      ''}) //XB_WCONTEM

	SXB->(dbSetOrder(1))
	For i:= 1 To Len(aSXB)
		If ! dbSeek(Padr(aSXB[i,1], Len(SXB->XB_ALIAS))+aSXB[i,2]+aSXB[i,3]+aSXB[i,4])
			RecLock("SXB",.T.)

            If aSXB[i][2] =="1"
				cTexto	+= aSXB[i][1]+CHR(13)+CHR(10)
			EndIf
			
			For j:=1 To Len(aSXB[i])
				If !Empty(FieldName(FieldPos(aEstrut[j])))
					FieldPut(FieldPos(aEstrut[j]),aSXB[i,j])
				EndIf
			Next j
			SXB->(dbCommit())
			SXB->(MsUnLock())
		EndIf
	Next i                                                                                     
Return(cTexto) 


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³PLSAtuSXA ³ Autor ³ Daher				    ³ Data ³ 11/11/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ 															  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Atualizacao FIS                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function PLSAtuSXA()
LOCAL aSXA           := {}
LOCAL aEstrut        := {}
LOCAL i              := 0
LOCAL j              := 0
LOCAL lSXA	         := .F.
LOCAL cTexto         := ''
LOCAL cAlias         := ''

aEstrut:= { "XA_ALIAS","XA_ORDEM","XA_DESCRIC","XA_DESCSPA","XA_DESCENG","XA_PROPRI"} 

aAdd(aSXA,{	"XA1",; //XA_ALIAS
      '1',; //XA_ORDEM
      'Principal',; //XA_DESCRIC
      '',; //XA_DESCSPA
      '',; //XA_DESCENG
      ''}) //XA_PROPRI

aAdd(aSXA,{	"XA1",; //XA_ALIAS
      '2',; //XA_ORDEM
      'Outros',; //XA_DESCRIC
      '',; //XA_DESCSPA
      '',; //XA_DESCENG
      ''}) //XA_PROPRI


aAdd(aSXA,{	"XA2",; //XA_ALIAS
      '1',; //XA_ORDEM
      'Principal',; //XA_DESCRIC
      '',; //XA_DESCSPA
      '',; //XA_DESCENG
      ''}) //XA_PROPRI

aAdd(aSXA,{	"XA2",; //XA_ALIAS
      '2',; //XA_ORDEM
      'Outros',; //XA_DESCRIC
      '',; //XA_DESCSPA
      '',; //XA_DESCENG
      ''}) //XA_PROPRI
      
DBSELECTAREA("SXA")             
ProcRegua(Len(aSXA))

SXA->(DbSetOrder(1))
For i:= 1 To Len(aSXA)
	If !Empty(aSXA[i][1]+aSXA[i][2])
		If !MsSeek(aSXA[i][1]+aSXA[i][2])
			RecLock("SXA",.T.)
		Else
			RecLock("SXA",.F.)
		EndIf
		lSXA	:= .T.
		If !(aSXA[i,1]$cAlias)
			cAlias += aSXA[i,1]+CHR(13)+CHR(10)
			aAdd(aArqUpd,aSXA[i,1])
		EndIf
		For j:=1 To Len(aSXA[i])
			If FieldPos(aEstrut[j])>0 .And. aSXA[i,j] != NIL
				FieldPut(FieldPos(aEstrut[j]),aSXA[i,j])
			EndIf
		Next j
		dbCommit()
		MsUnLock()
		IncProc("Atualizando Dicionário de Dados...("+aSXA[i,1]+")")
		ProcessMessage()
	EndIf
Next i

If lSXA
	cTexto := 'As seguintes tabelas foram criadas/alteradas no SXA : '+CHR(13)+CHR(10)+cAlias+CHR(13)+CHR(10)
EndIf

Return cTexto
