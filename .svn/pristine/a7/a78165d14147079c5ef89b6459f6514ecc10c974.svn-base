#Include 'RWMAKE.CH'
#Include 'PLSMGER.CH'
#Include 'COLORS.CH'
#Include 'TOPCONN.CH'

///*/
//ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
//±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
//±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
//±±ºPrograma  ³GERAADUINT º Autor ³ Lzio Tavares       º Data ³  30/04/2008 º±±
//±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
//±±ºDescricao ³ Gera arquivo texto dos usuarios que possuem atendimento     º±±
//±±º          ³ domiciliar. Conforme parametros                             º±±
//±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
//±±ºUso       ³ AP6 IDE                                                     º±±
//±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
//±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
//ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
///*/                                                       .

User Function GERAADUINT()
                                              
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracao de Variaveis                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Private oGeraTxt
Private cPerg       := "PLSREO"
Private cString     := "BA1"
Private nlinha      := 0
Private nlinha1     := 0
Private nTamLin, cLin, cCpo
Private lAbortPrint := .F.
private xUsu        := {}
private aPlano      := {}
private aCarGer     := {}
private aVDS        := {}
Private cBF4Name    := RetSQLName("BF4")
Private cBA1Name    := RetSQLName("BA1")
Private cBI3Name    := RetSQLName("BI3")
Private cBT3Name    := RetSQLName("BT3")
Private cBG9Name    := RetSQLName("BG9")
Private lRet        := .T.
Private nTamLin     := 15
Private cLin        := Space(nTamLin) // Variavel para criacao da linha do registros para gravacao
Private nValor      := 0
Private nTusu       := 0
Private cTipo       := ""
Private _cgc        := ""
Private cNomeProg   := "GERAREM"
Private nCaracter   := 15
Private Tamanho     := "P"
Private cTitulo     := "Quantidade de Usuarios que possuem opcional ADU."
Private cDesc1      := "Emite relatorio com a quantidade de ususarios por"
Private cDesc2      := "produto que possuem direito ao ADU."
Private cDesc3      := ""
Private cCabec1     := "Produtos com ADU"
Private cCabec2     := ""
Private cAlias      := "BA1"
Private wnRel       := "GERAADU"
Private Li          := 99
Private m_pag       := 1
Private aReturn     := {"Zebrado", 1,"Administracao", 1, 1, 1, "",1 }
Private lAbortPrint := .F.
Private aOrdens     := ""
Private lDicion     := .F.
Private lCompres    := .F.
Private lCrystal    := .F.
Private lFiltro     := .T.
Private Limite      := 80
Private cCodEmp     := GETNEWPAR("MV_YCODADU","311")
Private nVlADU      := GETNEWPAR("MV_YVLADU",2.09)
Private nVlVDS      := GETNEWPAR("MV_YVLVDS",60.00)
Private nVlCGER     := GETNEWPAR("MV_YVLCGER",15.40)
Private cRDASP      := GETNEWPAR("MV_YRDASP","106445")
Private cRDARJ      := GETNEWPAR("MV_YRDARJ","126004")

// Criar campo na tabela BT3 (produtos relacionados) para indicar qual será o codigo do lancamento de debito/credito
// a ser incluido no cadastro de debito/credito pela rotina automatica.
// Nome do Campo := BT3_YCDDBCR
// Tipo := C
// Tamanho := 3
// Descricao := Cod. Deb/Cre
// usar a mesma consulta do cadastro de Debito/Credito do campo BGQ_CODLAN (Lancamento)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas selecionadas                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
AjustaSX1(cPerg)

dbSelectArea("BA1")
dbSetOrder(1)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Montagem da tela de processamento.                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

@ 200,1 TO 390,430 DIALOG oGeraTxt TITLE OemToAnsi("Gera‡„o de Arquivo Texto")
@ 02,10 TO 90,200 //faz as bordas internas
@ 10,018 Say " Este programa ira gerar um arquivo texto, conforme os parame- "
@ 18,018 Say " tros definidos  pelo usuario,  com os registros do arquivo de "
@ 26,018 Say " BA1                                                           "

@ 60,108 BMPBUTTON TYPE 01 ACTION OkGeraTxt()
@ 60,138 BMPBUTTON TYPE 02 ACTION Close(oGeraTxt)
@ 60,168 BMPBUTTON TYPE 05 ACTION Pergunte(cPerg,.T.)

Activate Dialog oGeraTxt Centered

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFun‡„o    ³ OKGERATXTº Autor ³ AP5 IDE            º Data ³  19/05/04   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescri‡„o ³ Funcao chamada pelo botao OK na tela inicial de processamenº±±
±±º          ³ to. Executa a geracao do arquivo texto.                    º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Programa principal                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function OkGeraTxt

Local cDirGrava := GetNewPar("MV_PLSDIRC","C:\")
Local cDirPls := ""
Private nHdl    := 0   //Local
Private cArquivo := space(0)
Private cEOL    := "CHR(13)+CHR(10)"
If Empty(cEOL)
	cEOL := CHR(13)+CHR(10)
Else
	cEOL := Trim(cEOL)
	cEOL := &cEOL
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Cria o arquivo texto                                                ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If Empty(mv_par01) .or. Empty(mv_par02) .or. Empty(mv_par04) ;   //.or. Empty(mv_par03)
	.or. Empty(mv_par05) .or. Empty(mv_par06) .or. Empty(mv_par07) .or. Empty(mv_par08)
	MsgAlert("Informe os parametros .....")
	Close(oGeraTxt)
	Return
Endif

If mv_par04 = 1
	cTipo := "S"
ElseIf mv_par04 = 2
	cTipo := "P"
ElseIf mv_par04 = 3
	cTipo := "F"
ElseIf mv_par04 = 4
	cTipo := "A"
EndIf

_data := (substr(Dtoc(dDataBase),1,2)+ substr(Dtoc(dDataBase),4,2)+ substr(Dtoc(dDataBase),7,2))

cDirPls := alltrim(MV_PAR03)
If !Empty(cDirPls)
	cDirGrava := alltrim(cDirPls)
Endif
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Se nao informou a barra												³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If SubStr(cDirGrava,Len(cDirGrava),1) <> "\"
	cDirGrava += "\"
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Cria o arquivo texto layout de Informacoes Cadastrais               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Private cArquivo := cDirGrava + "T"+ Alltrim(cCodEmp) + "0001.TXT"   //+Alltrim(mv_par03) + cTipo +_data  + "." + "TXT"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica se e possivel criar o arquivo						³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
nHdl := fCreate(cArquivo)

If nHdl == -1
	MsgAlert("O arquivo de nome "+cArquivo+" nao pode ser executado! Verifique os parametros.","Atencao!")
	Return
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Inicializa a regua de processamento                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

MsAguarde({|| Processa() }, "Processando...", "", .T.)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFun‡„o    ³ PROCESSA º Autor ³ Luzio Tavares      º Data ³  09/04/03   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescri‡„o ³ Funcao auxiliar chamada pela PROCESSA.  A funcao PROCESSA  º±±
±±º          ³ monta a janela com a regua de processamento.               º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Programa principal                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function Processa()

Local i := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

Local dDatIni     := CtoD("  /  /    ")
Local dDtInicial  := CtoD("  /  /    ")
Local aCriticas   := {}
Private nContador := 0
Private nIdade

//MsgRun("Selecionando Registros...",,{|| BuscaRegs(),CLR_HBLUE})
MsgRun("Selecionando Registros...",,{|| ,CLR_HBLUE})

cSQL := " SELECT BA3.BA3_CODPLA, BA3.BA3_VERSAO, BG9.BG9_DESCRI, BG9.BG9_TIPO, BTS.BTS_DRGUSR, BTS.BTS_CPFUSR, BA1.* "
cSQL += " FROM " + RetSQLName("BA1") +" BA1, "+ RetSQLName("BG9") + " BG9, " + RetSQLName("BTS") + " BTS, "+RetSQLName("BA3") + " BA3 "
cSQL += " WHERE BA1_FILIAL = '"+xFilial("BA1")+"'  AND "
cSQL += " BG9_FILIAL = '"+xFilial("BG9")+"'  AND "
cSQL += " BA3_FILIAL = '"+xFilial("BA3")+"'  AND "
cSQL += " BA1.D_E_L_E_T_ = ' '  AND "
cSQL += " BA3.D_E_L_E_T_ = ' '  AND "
cSQL += " BG9.D_E_L_E_T_ = ' '  AND "
cSQL += " BA1_CODPLA = '0045' AND " 
cSQL += " BA1_DATINC <= '"+dtos(Mv_Par02)+"' AND " 
cSQL += " BA3_CODINT = BA1_CODINT AND "
cSQL += " BA3_CODEMP = BA1_CODEMP AND "
cSQL += " BA3_MATRIC = BA1_MATRIC AND "
//cSQL += " BA1_DATBLO = '      ' AND "
//cSQL += " BA1_MOTBLO = '  ' AND "
cSQL += " ((BA1_DATBLO = '      ' AND BA1_MOTBLO = '  ') OR BA1_DATBLO >= '"+DtoS(mv_par02)+"') AND  "
cSQL += " BG9_CODIGO = BA1_CODEMP AND "
cSQL += " BTS_MATVID = BA1_MATVID AND "
//If MV_PAR11 = 1
	cSQL += " BA1_ESTADO = 'RJ' "
//Else
//	cSQL += " BA1_ESTADO = 'SP' AND "
//	cSQL += " BA1_CODMUN IN ('3304557','3303302','3304904','3300456','3301702','3302270','3303203','3303500','3304144','3305109','421954') "
//EndIf
cSQL += " Order by BA1_CODEMP, BA1_MATRIC, BA1_TIPREG, BA1_DIGITO"

memowrit("C:\GERAADU_1.SQL",cSQL)

PLSQuery(cSQL,"TF4")

cCodRDA := cRDARJ
DbSelectArea("TF4")
TF4->(Dbgotop())

nTotal := 0
While !TF4->(Eof())
	
	MsProcTxt("Processando Usuario..."+ TF4->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG+BA1_DIGITO))
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifica o cancelamento pelo usuario...                             ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If lAbortPrint
		Exit
	Endif
	
	//	verifcar no parametro qual o tipo de arquivo vou gerar
	// mv_par05 = 1 todos os usuarios validos
	// mv_par05 = 2 somente titular se houver dependente valido
	// mv_par05 = 3 todosos titulares
	If mv_par05 = 1
		//			If TF4->BA1_TIPREG <> "00"
		//				nIdade :=Calc_Idade(mv_par02,TF4->BA1_DATNAS)
		//				If nIdade > TF4->BA1_YIDMPE
		//					TF4->(DbSkip())
		//					Loop
		//				Endif
		//				If TF4->BA1_YVAIPE = "0"
		//					TF4->(DbSkip())
		//					Loop
		//				Endif
		//			Endif
	ElseIf mv_par05 = 2
		If TF4->BA1_TIPREG = "00"
			nIdade :=Calc_Idade(mv_par02,TF4->BA1_DATNAS)
			cSql1 := "SELECT COUNT(BA1_MATRIC) AS Total FROM "+ cBA1Name
			cSql1 += " WHERE BA1_FILIAL = '"+xFilial("BA1")+"' AND "
			cSql1 += " BA1_CODINT = '"+TF4->BA1_CODINT+"' AND "
			cSql1 += " BA1_CODEMP = '"+TF4->BA1_CODEMP+"' AND "
			cSql1 += " BA1_CONEMP=  '"+TF4->BA1_CONEMP+"' AND "
			cSql1 += " BA1_VERCON = '"+TF4->BA1_VERCON+"' AND "
			cSql1 += " BA1_SUBCON = '"+TF4->BA1_SUBCON+"' AND "
			cSql1 += " BA1_VERSUB = '"+TF4->BA1_VERSUB+"' AND "
			cSql1 += " BA1_MATRIC = '"+TF4->BA1_MATRIC+"' AND "
			//				cSql1 += " BA1_YVAIPE = '1' AND "
			cSql1 += cBA1Name+".D_E_L_E_T_ = ' '"
			PLSQuery(cSQL1,"TBA1")
			DbSelectArea("TBA1")
			If TBA1->Total <= 1
				TBA1->(DbCloseArea("TBA1"))
				TF4->(DbSkip())
				Loop
			Else
				TBA1->(DbCloseArea("TBA1"))
			Endif
		Else
			TF4->(DbSkip())
			Loop
		Endif
	Else
		If TF4->BA1_TIPREG <> "00"
			TF4->(DbSkip())
			Loop
		Endif
	EndIf
	
	If !Empty(TF4->BA1_CODPLA)
		cCodPla := TF4->(BA1_CODPLA+BA1_VERSAO)
	Else
		cCodPla := TF4->(BA3_CODPLA+BA3_VERSAO)
	EndIf
	
	cDesPla := "Produto nao Identificado"
	BI3->(DbSetOrder(1))
	If BI3->(DbSeek(xFilial("BI3")+TF4->BA1_CODINT+cCodPla))
		cDesPla := BI3->BI3_DESCRI   //BI3->BI3_NREDUZ
	EndIf
	
	If MV_PAR08 == 1
		cUsu :=(TF4->BA1_CODINT+TF4->BA1_CODEMP+TF4->BA1_MATRIC+TF4->BA1_TIPREG+TF4->BA1_DIGITO)
		
		nPos := aScan(xUsu, {|x| substr(x[1],9,17) == cUsu})
		
		If nPos = 0
		   	Aadd(xUsu,{"00000000"+;
		   	     Padr(cUsu,20)+;
      		     Padr(substr(cCodPla,1,4),10)+;     //PADR(alltrim(TF4->BA1_CODPLA),10)+;
                 SPACE(10)+;
			   	  PADR(cDesPla,20)+;   //Descricao do Produto
    			     SPACE(10)+;                                     
			   	  Iif(!Empty(TF4->BA1_DATINC),DtoS(TF4->BA1_DATINC),DtoS(TF4->BA1_DATINC))+;   //Data Inicio Opcional
			   	  Space(08)+;
                 Iif(TF4->BA1_TIPREG == "00","T","D")+;
			   	  Padr(Alltrim(TF4->BA1_NOMUSR),50)+;
			   	  DtoS(TF4->BA1_DATNAS)+;
			   	  Iif(TF4->BA1_SEXO == "1","M","F")+;
			   	  Space(01)+;
			   	  Padr(alltrim(TF4->BTS_DRGUSR),15)+;
			   	  Padr(Alltrim(TF4->BTS_CPFUSR),14)+;
			   	  Space(20)+;
			   	  Padr(alltrim(TF4->BA1_MUNICI),30)+;
    			     Padr(Alltrim(TF4->BA1_ESTADO),2)+;
			   	  Iif(TF4->BG9_TIPO="1","0","1")+;              //Iif(TF4->BG9_TIPO="1","F","J")+;
                  DtoS(TF4->BA1_DATBLO)+;   //Iif(TF4->BA1_DATBLO > TF4->BA1_YDTLIM, DtoS(TF4->BA1_DATBLO), DtoS(TF4->BA1_YDTLIM))+; // Somente se a data limite for superior a data do parametro  //DtoS(TF4->BA1_YDTLIM)+;                       // Data Limite
			   	  "0023"+;                                      // Codigo de Grupo de Produtos BEM
			   	  Space(04)+;
			   	  Space(04)+;
			   	  Space(04)+;
			   	  Space(04)+;
			   	  Space(04)+;
			   	  Space(10)+;    //Pessoa Juridica //			   	Space(40)+;    //Iif(MV_PAR09=1,Padr(Alltrim(TF4->BG9_DESCRI),40))+;   //Nome Empresa
			   	  Padr(Alltrim(TF4->BG9_DESCRI),50)+;   //Iif(MV_PAR09=1,Padr(Alltrim(TF4->BG9_DESCRI),50),Space(50))+;   //Nome Empresa   Padr(Alltrim(TF4->BA1_ENDERE),50)+;
                 Space(50)+;    //
			   	  "I"})
		Endif
	EndIf

	cCodADU := Space(03)
	//Pesquisa opcional no nivel do usuario
	DbSelectArea("BT3")
	BT3->(DbSetOrder(1))
	If !BT3->(DbSeek(xFilial("BT3")+TF4->BA1_CODINT+cCodPla+"0023"))
//Opcional no produto sem o codigo de lancamento
   	aadd(aCriticas,{"BT3","Produto ADU sem codigo de Lancamento de Debito/Credito a nivel de produto ["+SubStr(cCodPla,1,4)+"]"})
	ElseIf Empty(BT3_YCDADU)
   	aadd(aCriticas,{"BT3","Produto ADU sem codigo de Lancamento de Debito/Credito a nivel de produto ["+SubStr(cCodPla,1,4)+"]"})
	Else
	   cCodADU := BT3->BT3_YCDADU
	EndIf

	nPos := aScan(aPlano, {|x| x[1] == substr(cCodPla,1,4)})  //TF4->BA1_CODPLA})
	
	If nPos = 0
		//	   	Aadd(aPlano,{TF4->BA1_CODPLA,cDesPla,1})
		Aadd(aPlano,{substr(cCodPla,1,4),cDesPla,1,cCodADU})
	Else
		aPlano[nPos,3] := aPlano[nPos,3]+1
	EndIf
	
	TF4->(DbSkip())
Enddo
TF4->(DbCloseArea("TF4"))

If MV_PAR08 == 1
	nLinha := 0
	For I:= 1 to len(xUsu)
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Inicio da Gravação do Arquivo Texto                                      ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		nlinha ++
		nTamLin := 120
		cLin    := space(Len(xUsu[I,1]))   //Space(nTamLin) // Variavel para criacao da linha do registros para gravacao
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Substitui nas respectivas posicioes na variavel cLin pelo conteudo  ³
		//³ dos campos segundo o Lay-Out. Utiliza a funcao STUFF insere uma     ³
		//³ string dentro de outra string. DETALHE                              ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			
		//	cCpo := PADR('"'+xUsu[I,1]+'"',03)
		//	cCpo := PADR(",973,",05)
		//	cLin := Stuff(cLin,04,05,cCpo)
		//	cCpo := PADR(xUsu[I,2]+",",22)
		//	cLin := Stuff(cLin,09,22,cCpo)
		cCpo := xUsu[I,1]+strzero(nLinha,8)
		cLin := cCpo + cEOL
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Gravacao no arquivo texto. Testa por erros durante a gravacao da    ³
		//³ linha montada.                                                      ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			
		If fWrite(nHdl,cLin,Len(cLin)) != Len(cLin)
			If !MsgAlert("Ocorreu um erro na gravacao do arquivo. Continua?","Atencao!")
				Exit
			Endif
		Endif
	Next
	fClose(nHdl)
	Close(oGeraTxt)
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Gera lancamento no cadastro de Debito/Credito                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If MV_PAR10 = 1  //2
	If Len(aCriticas) > 0
   	MsgAlert( "Ocorreram criticas no processamento que nao permite gerar lancamentos automaticamente. Corrija e processe novamente!" ) //"Tabela BQL nao existente no SX2, favor cria-la."
	   PLSCRIGEN(aCriticas,{ {"Tabela","@C",20} , {"Descricao","@C",400 } },"Criticas")
	Else   
		u_gerdebcre(cCODRDA,aPlano,aCARGER,aVDS,MV_PAR06,MV_PAR07,nVlADU,nVlVDS,nVlCGER)
	Endif
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Emite relat¢rio                                                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
RptStatus({|lEnd| Imprime_Log() }, "Imprimindo relatorio de ocorrencias ...", "", .T.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ O arquivo texto deve ser fechado, bem como o dialogo criado na fun- ³
//³ cao anterior.                                                       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Fim do programa                                                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ Imprime_Log ³ Autor ³ Nelson / Angelo    ³ Data ³ 22/01/04 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Imprime relatorio de criticas                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ Imprime_Log()                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ nenhum                                                     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function Imprime_Log()

dbSelectArea(cAlias)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Chama SetPrint                                                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
wnRel := SetPrint(cAlias,wnRel,"",@cTitulo,cDesc1,cDesc2,cDesc3,lDicion,,lCompres,Tamanho,{},lFiltro,lCrystal)

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
RptStatus({|lEnd| Impr_Log() }, "Imprimindo relatorio totalizador ...", "", .T.)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Fim do programa                                                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ Impr_Log ³ Autor ³ Nelson / Angelo       ³ Data ³ 22/01/04 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Imprime relatorio de criticas                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ Impr_Log()                                                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ nenhum                                                     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function Impr_Log()

Local i := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define variaveis...                                                      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local nQtdLin  := 58
Local nColuna  := 00
Local nOrdSel  := aReturn[8]
Local	nVlTot   := 0
Local nTvalor  := 0

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Lista criticas                                                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If len(aPlano) > 0
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Inicializa variaveis                                                     ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//	cTitulo := "Produtos com ADU - " + Iif(MV_PAR11 = 1," RIO DE JANEIRO"," SAO PAULO"
	cTitulo := "Produtos com ADU"
	cCabec1 := "Ativos ate: "+Dtoc(Mv_Par02)+"   Nome do Arquivo: "+cArquivo
	cCabec2 := "Produto                                  Quant.  Vlr.Unit       Valor"  //"Produto                                            Quant."
	Li := 99
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Monta regua                                                              ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	SetRegua(len(aPlano))
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Processa vetor com log de criticas                                       ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	For i := 1 to len(aPlano)
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Verifica se foi cancelada a impressao                                 ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If  Interrupcao(lAbortPrint)
			Li ++
			@ Li, nColuna pSay PLSTR0002
			Exit
		Endif
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Movimenta regua                                                       ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		IncRegua()
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Imprime cabecalho                                                 ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If  Li > nQtdLin
			Li := Cabec(cTitulo,cCabec1,cCabec2,wnrel,Tamanho,IIF(aReturn[4]==1,GetMv("MV_COMP"),GetMv("MV_NORM")))
			Li := 9
		Endif
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Imprime linha de detalhe                                          ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		@ Li, 000 pSay aPlano[I,4]
		@ Li, 006 pSay aPlano[I,1] +"-" + aPlano[I,2]
		@ Li, 047 pSay aPlano[I,3] Picture "@R 999999"
		@ Li, 055 pSay nVlADU Picture "@R 999.99"
		@ Li, 063 pSay aPlano[I,3]*nVlADU Picture "@R 9,999,999.99"
		Li ++
		nTusu := nTusu + aPlano[I,3]
		nVlTot += (aPlano[I,3]*nVlADU)
	Next
	
	//Produto                                  Quant.  Vlr.Unit       Valor
	//0....+....1....+....2....+....3....+....4....+....5....+....6....+....7....+....8....9....+....0....+....1....+....2
	//XXXX-XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX  999999  999,99  9.999.999,99
	
	@ Li,  0 pSay Replicate("-",Limite)
	Li ++
	@ Li, 000 pSay "Total ADU"
	@ Li, 041 pSay nTusu Picture "@R 99999"
	@ Li, 057 pSay nVlTot Picture "@R 9,999,999.99"
	nTValor += nVlTot

/*	
	Li ++
	@ Li,  0 pSay Replicate("-",Limite)
	Li ++
	Li ++
	@ Li, 000 pSay "CARTEIRA GERENCIADA"
	Li ++
	Li ++
	
	nTusu := 0
	nVlTot := 0
	For i := 1 to len(aCARGER)
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Verifica se foi cancelada a impressao                                 ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If  Interrupcao(lAbortPrint)
			Li ++
			@ Li, nColuna pSay PLSTR0002
			Exit
		Endif
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Movimenta regua                                                       ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		IncRegua()
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Imprime cabecalho                                                 ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If  Li > nQtdLin
			Li := Cabec(cTitulo,cCabec1,cCabec2,wnrel,Tamanho,IIF(aReturn[4]==1,GetMv("MV_COMP"),GetMv("MV_NORM")))
			Li := 9
		Endif
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Imprime linha de detalhe                                          ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		@ Li, 000 pSay aCARGER[I,1] +"-" + aCARGER[I,2]
		@ Li, 041 pSay aCARGER[I,3] Picture "@R 999999"
		@ Li, 049 pSay nVlCGER Picture "@E 999.99"
		@ Li, 057 pSay aCARGER[I,3]*nVlCGER Picture "@E 9,999,999.99"
		Li ++
		nTusu := nTusu + aCARGER[I,3]
		nVlTot += (aCARGER[I,3]*nVlCGER)
	Next
	@ Li,  0 pSay Replicate("-",Limite)
	Li ++
	@ Li, 000 pSay "Total CARTEIRA GERENCIADA"
	@ Li, 041 pSay nTusu Picture "@R 99999"
	@ Li, 057 pSay nVlTot Picture "@E 9,999,999.99"
	nTValor += nVlTot
	
	Li ++
	@ Li,  0 pSay Replicate("-",Limite)
	Li ++
	Li ++
	
	@ Li, 000 pSay "VIGILANCIA - VDS"
	Li ++
	Li ++
	nTusu := 0
	nVlTot := 0
	For i := 1 to len(aVDS)
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Verifica se foi cancelada a impressao                                 ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If  Interrupcao(lAbortPrint)
			Li ++
			@ Li, nColuna pSay PLSTR0002
			Exit
		Endif
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Movimenta regua                                                       ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		IncRegua()
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Imprime cabecalho                                                 ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If  Li > nQtdLin
			Li := Cabec(cTitulo,cCabec1,cCabec2,wnrel,Tamanho,IIF(aReturn[4]==1,GetMv("MV_COMP"),GetMv("MV_NORM")))
			Li := 9
		Endif
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Imprime linha de detalhe                                          ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		@ Li, 000 pSay aVDS[I,1] +"-" + aVDS[I,2]
		@ Li, 041 pSay aVDS[I,3] Picture "@R 999999"
		@ Li, 049 pSay nVlVDS Picture "@E 999.99"
		@ Li, 057 pSay aVDS[I,3]*nVlVDS Picture "@E 9,999,999.99"
		Li ++
		nTusu := nTusu + aVDS[I,3]
		nVlTot += (aVDS[I,3]*nVlVDS)
	Next
	@ Li,  0 pSay Replicate("-",Limite)
	Li ++
	@ Li, 000 pSay "Total VDS"
	@ Li, 041 pSay nTusu Picture "@R 99999"
	@ Li, 057 pSay nVlTot Picture "@E 9,999,999.99"
	nTValor += nVlTot
*/

	Li ++
	@ Li,  0 pSay Replicate("-",Limite)
	Li ++
	Li ++
	@ Li, 041 pSay "TOTAL GERAL"
	@ Li, 057 pSay nTValor Picture "@E 9,999,999.99"
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Imprime rodape do relatorio...                                       ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	Roda(0,space(10),Tamanho)
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Libera impressao                                                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If  aReturn[5] == 1
	Set Printer To
	Ourspool(wnRel)
Endif
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Fim da funcao                                                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Return

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
±±±±±±±±±±±admin	±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function AjustaSX1(cPerg)

Local aRegs		:= {}

Aadd(aRegs,{cPerg,"01","Data Inicial?              ","","","MV_CH1","D",08,0,0,"G","           ","Mv_Par01","   ","","","","","   ","","","","","","","","","","","","","","","","","","","",""})
Aadd(aRegs,{cPerg,"02","Data Final?                ","","","MV_CH2","D",08,0,0,"G","           ","Mv_Par02","   ","","","","","   ","","","","","","","","","","","","","","","","","","","",""})
Aadd(aRegs,{cPerg,"03","Diretorio do Arquivo?      ","","","MV_CH3","C",60,0,0,"G","           ","Mv_Par03","   ","","","","","   ","","","","","","","","","","","","","","","","","","",IIf(PlsGetVersao() >= 8,"BB3PLS","BB3"),""}) //Local de Gravacao
Aadd(aRegs,{cPerg,"04","Tipos de Arquivo?          ","","","MV_CH4","N",01,0,0,"C","           ","Mv_Par04","Atendimento Domiciliar","","","","","Todos Produtos","","","","","","","","","","","","","","","","","","","",""})
Aadd(aRegs,{cPerg,"05","Tipos de Usuarios?         ","","","MV_CH5","N",01,0,0,"C","           ","Mv_Par05","Envia todos","","","","","Env.Tit.C/Dep","","","","","Envia so Titular","","","","","","","","","","","","","","",""})
Aadd(aRegs,{cPerg,"06","Ano Competencia?           ","","","MV_CH6","C",04,0,0,"G","           ","Mv_Par06","   ","","","","","   ","","","","","","","","","","","","","","","","","","","",""})
Aadd(aRegs,{cPerg,"07","Mes Competencia?           ","","","MV_CH7","C",02,0,0,"G","PlsVldMes()","Mv_Par07","   ","","","","","   ","","","","","","","","","","","","","","","","","","","",""})
Aadd(aRegs,{cPerg,"08","Gera o Arquivo?            ","","","MV_CH8","N",01,0,0,"C","           ","Mv_Par08","Sim","","","","","Nao","","","","","","","","","","","","","","","","","","","",""})
Aadd(aRegs,{cPerg,"09","Informa Grupo Empresa?     ","","","MV_CH9","N",01,0,0,"C","           ","Mv_Par09","Sim","","","","","Nao","","","","","","","","","","","","","","","","","","","",""})
Aadd(aRegs,{cPerg,"10","Gera Lanc. Debito/Credito? ","","","MV_CHA","N",01,0,0,"C","           ","Mv_Par10","Sim","","","","","Nao","","","","","","","","","","","","","","","","","","","",""})
//Aadd(aRegs,{cPerg,"11","Qual a Localidade?         ","","","MV_CHB","N",01,0,0,"C","           ","Mv_Par11","Rio de Janeiro","","","","","São Paulo","","","","","","","","","","","","","","","","","","","",""})

PlsVldPerg( aRegs )

Return(.T.)