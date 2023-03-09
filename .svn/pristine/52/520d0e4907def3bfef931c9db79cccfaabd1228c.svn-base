#Include 'RWMAKE.CH'
#Include 'PLSMGER.CH'
#Include 'COLORS.CH'
#Include 'TOPCONN.CH'
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³IMPARQLAB 		  º Autor ³ Leandro Marques º Data ³  11/01/07   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Importa os arquivos dos laboratorios conforme layout Caberj       º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CABERJ                                                            º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

User Function IMPARQLAB()

Private cCadastro	:= "Importa arquivos do laboratórios"
Private cPerg		:= "IMPLAB"
Private aSays 		:= {}
Private aButtons 	:= {}

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Parametros para relatorio...                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Private cNomeProg   := "IMPARQLAB"
Private nQtdLin     := 68
Private nLimite     := 132
Private nControle   := 15
Private cAlias      := "BD5"
Private cTamanho    := "M"
Private cTitulo     := "Importacao arquivo dos laboratorios"
Private cDesc1      := ""
Private cDesc2      := ""
Private cDesc3      := ""
Private nRel        := "IMPARQLAB"
Private nLin        := 100
Private nOrdSel     := 1
Private m_pag       := 1
Private lCompres    := .F.
Private lDicion     := .F.
Private lFiltro     := .T.
Private lCrystal    := .F.
Private aOrdens     := {} 
Private aReturn     := { "", 1,"", 1, 1, 1, "",1 }
Private lAbortPrint := .F.
Private cCabec1     := PADC("Relatorio geral de importação do arquivos Laboratorio ",nLimite)
Private cCabec2     := ""
Private nColuna     := 00
Private nOrdSel     := 0
Private nRdaExec    := 0

Private nQTDSAD     := 0
Private nVLRSAD     := 0
Private nQTDTOT     := 0
Private nVLRTOT     := 0
   

Private oLeTxt

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Abertura de arquivos                                                ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
BCI->(DbSetOrder(1)) // PEGS
BD5->(DbSetOrder(1)) // CABECALHO DAS CTMS
BD6->(DbSetOrder(1)) // ITENS DAS CTMS
BD7->(DbSetOrder(1)) // COMPOSICAO DO PAGAMENTO DOS ITENS DAS CTMS
BA8->(DbSetOrder(4)) // PROCEDIMENTOS
ZZP->(DbSetOrder(1)) //Protocolo de Remessas Criado para Controle do custo de entrada.
BCT->(DbSetOrder(1)) // BCT_FILIAL + BCT_CODOPE + BCT_PROPRI + BCT_CODGLO

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Ajusta perguntas...                                                      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
AjustaSX1(cPerg)

Pergunte(cPerg,.F.)       


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta texto para janela de processamento                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
@ 200,1 TO 380,380 DIALOG oLeTxt TITLE OemToAnsi("Importacao arq. Laboratorio")
@ 02,10 TO 65,180
@ 10,018 Say " Este programa irá fazer a leitura do arquivo texto enviado pela"
@ 18,018 Say " RDA, importando as guias e criando as PEGs necessarias.    "
@ 70,098 BMPBUTTON TYPE 05 ACTION AjustaSX1(cPerg)
@ 70,128 BMPBUTTON TYPE 01 ACTION BtnOk()
@ 70,158 BMPBUTTON TYPE 02 ACTION Close(oLeTxt)

Activate Dialog oLeTxt Centered 

Return


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³BtnOk      º Autor ³ Caberj            º Data ³  11/01/07   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Chama a importacao das guias...                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CABERJ                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function BtnOk()

Pergunte(cPerg,.F.) 
Processa({|| Importa() }, "Validando o movimento ...", "", .T.)

Return


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³Importa    º Autor ³ Caberj            º Data ³  11/01/07   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Executa a importacao das guias...                          º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CABERJ                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function Importa

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Definicao de variaveis para uso geral...                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local cTipo			:= ""
Local cTipReg		:= ""
Local cChGuiAnt		:= ""
Local nRegs			:= 0
Local aStruc		:= {}
Local nTotRegC		:= 0
Local cRDAArq       := "" //---> Armazena a informacao da RDA que eniou o arquivo. Leandro 17/01/2007

Local cMatUsrTmp := ""
Local cMatAntTmp := ""

Local aRetCod		:= {}

Private lHouveErr	:= .F.
Private aErr		:= {}
Private nQtdItem	:= 0
Private nVlrTotP	:= 0
Private aGuiImp		:= {}

Private cLinha		:= ""

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis para o uso / HEADER...                                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Private cHCodCre := ""
Private nHQtdGui := 0
Private nHVlrGui := 0


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis para o uso / Guias (BD5 ou BE4)	                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Private cGTipGui	:= ""
Private cGNroImp	:= ""
Private cGCid		:= ""
Private dGDtAtend	:= CtoD("")
Private dDatSol  	:= CtoD("")
Private cGMatAnt	:= ""
Private cGCodSol	:= ""
Private cGCodExe	:= ""
Private cRDATmp		:= ""
Private dGDtAlta	:= CtoD("")
Private cGMatAtu	:= ""
Private cGSenha		:= ""
//Private cDtTmp		:= ""
Private cGHorPro	:= ""
Private cGHorAlt	:= ""
Private cGTipAlt	:= ""
Private cGTipNas	:= ""
Private cMatUsa		:= ""
Private cGEstSol	:= ""
Private cGCRSol	:= ""
Private cGPSaude	:= ""
Private cGHorAte	:= ""
Private cGHorSai	:= ""
Private cGTipAlt	:= ""
Private cGTipAco	:= ""
Private cGGrpInt	:= ""
Private cGTipInt	:= ""
Private cGTipPar	:= ""
Private cGTipNas	:= ""
Private cGTipPac	:= ""
Private cGAteNRN	:= ""
Private cChaveAnt	:= ""
Private cChaveGuia	:= space(15)
Private lGravaGuia	:= .F.

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis para o uso / Itens das guias (BD6)	                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Private cINroImp	:= ""
Private cICodProc	:= ""
Private dIDatProc	:= StoD("")
Private cIHorProc	:= ""
Private nIQtdProc	:= 0
Private nIVlrUni	:= 0
Private nIVlrApr	:= 0
Private cIViaProc	:= ""
Private nIPerProc	:= 0


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis obtidas nos parametros de sistema...	                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Private cCodRdaInf := mv_par01
Private cCompInf   := mv_par02
Private cMes	:= ""
Private cAno	:= ""
Private cProt   := ""
Private cCodRda := ""
//-----> Leandro 23/01/2007
Private nVlrGui := 0
Private nQtdEve := 0
//-----<     
Private cNumGuiaArq := ""


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis privadas de uso da rotina de importacao.                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Private _cPeg   := ""
Private cCodLdp := ""
Private cNumero := ""
Private cOriMov := ""
Private cNumDoc := ""

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Selecao de arquivo para importacao...                               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//cTipo    := "Txt     (*.Txt)            | *.Txt | "
cTipo    := "Texto     (*.*)            | *.* | "
cNomeArq := AllTrim(cGetFile(cTipo,"Selecione o Arquivo Texto para importar"))
//cNomeArq := "M:\AP_DATA"+cNomeArq

If !File(cNomeArq)
	MsgStop("Arquivo invalido. Programa encerrado.")
	Close(oLeTxt)
	Return
End

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Estrutura do arquivo temporario...                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
aStruc := {	{"NUMREG","C",  006,0},{"CODREG","C", 002,0},{"TIPREG","C",  002,0},{"CAMPO","C", 182,0}}

cTRB := CriaTrab(aStruc,.T.)
If Select("TRB") <> 0
	TRB->(DbCloseArea())
End
DbUseArea(.T.,,cTRB,"TRB",.T.)
IndRegua("TRB",cTRB,"NUMREG",,,"Ordenando Registros...")

MsgRun("Atualizando Arquivo...",,{|| U_PLSAppendTmp(cNomeArq),CLR_HBLUE})

DbSelectArea("TRB")

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica se o arquivo esta vazio...                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
TRB->(DbGoTop())
If TRB->(EOF())
	MsgStop("Arquivo vazio! Importação cancelada!")
	TRB->(DBCLoseArea())
	Close(oLeTxt)
	Return
End

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Analise e importacao das guias...                                   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
nTotRegC := TRB->(Reccount())
ProcRegua(nTotRegC)
nRegs := 0

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Controle de transacao para garantir a gravacao dos dados            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Begin Transaction

While ! TRB->(Eof())

	//cTipReg	:= Substr(cLinha,1,1)
	lGravaGuia := .F.
	nRegs++
	
	cLinha := TRB->(NUMREG+CODREG+TIPREG+CAMPO)
		
	//Criticas do registro de cabecalho
	while Substr(cLinha,009,002) == "01" 
	   cRDAArq := Substr(cLinha,011,006)
	   cRdaExec := cRDAArq
	   
      //Testa se a RDA informada no arquivo existe no cadastro da tabela BAU (RDAs)
      if !Empty(cRDAArq)
	     BAU->(DbSetOrder(1))				
	     if Empty(BAU->(MsSeek(xFilial("BAU")+cRDAArq)))
           	MsgStop("RDA não encontrada no cadastro ! Importação cancelada!")
     	    TRB->(DBCLoseArea())
	        Close(oLeTxt)
	        Return
	     else
	        // Testa se a RDA informada pelo usuario e igual a RDA da linha de cabecalho do arquivo
	        if cCodRdaInf <> cRDAArq 
	           MsgStop("RDA informada no arquivo e diferente da RDA informada pelo usuario na importacao ! Importacao cancelada !")
               TRB->(DBCLoseArea())
	           Close(oLeTxt)
	           Return
	        end if  
	     end if
      end if            
      cMes := Substr(cLinha,047,002)
      cAno := Substr(cLinha,049,004)
      cProt:= Substr(cLinha,053,007)
      
      // Testa se a competencia informada no registro de cabecalho e a mesma da competencia atual do pagamento.
      If CtoD("01/"+cMes+"/"+cAno) <> CtoD("01/"+cCompInf)
         MsgStop("Competencia informada no arquivo e diferente da competencia informada pelo usuario ! Importacao sera cancelada !")
         TRB->(DBCLoseArea())
         Close(oLeTxt)
         Return
      EndIf
      //nRegs++
      TRB->(DbSkip())
      cLinha := TRB->(NUMREG+CODREG+TIPREG+CAMPO)
	End do
	
	//-----> Obtem os totais do Protocolo -> Leandro 23/01/2007
	If Substr(cLinha,009,002) == "90" 
       nQtdEve := Val(Substr(cLinha,026,005))
  	   nVlrGui := Val(Substr(cLinha,031,010))
  	   nVlrGui := nVlrGui/100
	Endif;
	//-----<
	
	cTipReg := "2"
	cGTipGui := "0"+cTipReg 
	cGMatAnt	:= Substr(cLinha,038,011)
    cNumGuiaArq := Substr(cLinha,011,007) //Leandro 31/08/2007

	//cGMatAtu	:= "0"+Substr(cLinha,086,015)+Modulo11("0"+Substr(cLinha,086,015))	
	
	IncProc("Processando "+StrZero(nRegs,6)+" de "+StrZero(nTotRegC,6))
	
	If TRB->(NUMREG) <> cChaveAnt
	
		If BD5->(MsSeek(xFilial("BD5")+PLSINTPAD()+cChaveGuia))
			BD5->(RecLock("BD5",.F.))
			BD5->BD5_QTDEVE	:= nQtdItem
			BD5->BD5_VLRPAG	:= nVlrTotP
			BD5->(MsUnlock())
		Endif
		
		nQtdItem := 0
		nVlrTotP := 0
		cChaveGuia := space(15)
	
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Cabecalho das guias de consultas, servicos ou internacao            ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ		
   		cGNroImp	:= Substr(cLinha,011,007)
		cDtTmp		:= Substr(cLinha,020,008)
		cDtTmpSol   := Substr(cLinha,049,008)
		dGDtAtend	:= StoD(Substr(cDtTmp,005,004)+Substr(cDtTmp,003,002)+Substr(cDtTmp,001,002))
		dDatSol	   := StoD(Substr(cDtTmpSol,005,004)+Substr(cDtTmpSol,003,002)+Substr(cDtTmpSol,001,002))
      cGCid       := "Z00" //Cid Investigacao diagnostica
		cGCRSol		:= Substr(cLinha,028,010)
		//---> Localizar o estado do CRM do Solicitante informado no arquivo. Leandro 17/01/2007
		BB0->(DbSetOrder(7))
		If BB0->(MsSeek(xFilial("BB0")+cGCRSol))
		   cGEstSol := BB0->BB0_ESTADO
		Else
		   cGEstSol := 'RJ'
		End if
		
		cGNomUsr	:= ""
		dGDatNas	:= CtoD("")
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Buscar dados do usuario (matricula antiga)                          ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If !Empty(Val(AllTrim(cGMatAnt)))
			BA1->(DbSetOrder(5)) //Matricula anterior
			//If BA1->(MsSeek(xFilial("BA1")+Val(AllTrim(cGMatAnt)))) // Leandro Alterei pois estava dando erro retornava NIL
			cGMatAnt := Str(Val(AllTrim(cGMatAnt)))			
			If BA1->(MsSeek(xFilial("BA1")+Alltrim(cGMatAnt)))
				cGNomUsr := BA1->BA1_NOMUSR
				dGDatNas := BA1->BA1_DATNAS
				cGMatAtu := BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG+BA1_DIGITO)
				cMatUsa := "2"
			Else
				BA1->(DbSetOrder(10)) //Matricula antiga do sistema antigo
				cGMatAnt := Str(Val(AllTrim(cGMatAnt)))
				If BA1->(MsSeek(xFilial("BA1")+AllTrim(cGMatAnt)))
					cGNomUsr := BA1->BA1_NOMUSR
					dGDatNas := BA1->BA1_DATNAS
					cGMatAtu := BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG+BA1_DIGITO)
					cMatUsa := "2"
				Else
                    //aadd(aErr,{"Usuário não encontrado. Mat. arquivo: "+cGMatAnt,TRB->(NUMREG)})
                    //TRB->(DbSkip())
                    //Loop
                    //Conforme combinado com Marcia / Lucilio e Jean -> Informaremos uma matricula generica 
                    //cadastrada no sistema para receber os registros com matriculas inexistentes
                    BA1->(DbSetOrder(3)) //Usuario Generico
                    If BA1->(MsSeek(xFilial("BA1")+AllTrim("USUARIO GENERICO - IMPORT. ARQ LAB")))
  					  cGNomUsr := BA1->BA1_NOMUSR
					  dGDatNas := BA1->BA1_DATNAS
					  cGMatAtu := BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG+BA1_DIGITO)
					  cMatUsa := "2"
					EndIf
				Endif
			Endif
		Else
           //Conforme combinado com Marcia / Lucilio e Jean -> Informaremos uma matricula generica 
           //cadastrada no sistema para receber os registros com matriculas inexistentes
           BA1->(DbSetOrder(3)) //Usuario Generico
           If BA1->(MsSeek(xFilial("BA1")+AllTrim("USUARIO GENERICO - IMPORT. ARQ LAB")))
  			  cGNomUsr := BA1->BA1_NOMUSR
			  dGDatNas := BA1->BA1_DATNAS
			  cGMatAtu := BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG+BA1_DIGITO)
			  cMatUsa := "2"
		   Endif
		Endif

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Validar se a familia existe no sistema...                           ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ		
		If BA1->(Found())
			BA3->(DbSetOrder(1))
			If !BA3->(MsSeek(xFilial("BA3")+BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC)))	
				aadd(aErr,{"Usuário sem família cadastrada! Código: "+BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC),TRB->(NUMREC)})
				TRB->(DbSkip())
				Loop
			Endif
		Endif

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Buscar codigo de RDA solicitante atraves profissional de saude...	³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		
		BB0->(DbSetOrder(4))			
		If BB0->(MsSeek(xFilial("BB0")+cGEstSol+cGCRSol))
		   cGPSaude := BB0->BB0_CODIGO	
		Else
			BB0->(DbSetOrder(4))			
            If BB0->(MsSeek(xFilial("BB0")+"RJ"+"0055000000"))
			   cGPSaude := BB0->BB0_CODIGO	
     		   cGEstSol := "RJ"
     		   cGCRSol := "0055000000"
			Endif
		Endif
		
		
		BAU->(DbSetOrder(5))				
		If BAU->(MsSeek(xFilial("BAU")+cGPSaude))          
			While BAU->BAU_CODBB0 == cGPSaude .And. !BAU->(Eof())
				If BAU->BAU_ESTCR == cGEstSol
					cGCodSol := BAU->BAU_CODIGO
					Exit
				Endif  
				BAU->(DbSkip())			
			Enddo
		else
		  cGCodSol := "155555"	//RDA Generica para importacao de Historico de Reembolso e CTMS
		Endif
        
		BAU->(DbSetOrder(1))
		
		//cGHorAte := Iif(Empty(Substr(cLinha,078,004)),"0800",Substr(cLinha,078,004))
		//cRDATmp	:= Substr(cLinha,017,006)
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Buscar codigo de RDA executante atraves do local de atendimento...	³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ	   				
	   	BB8->(DbSetOrder(1)) //Buscar por matricula atual da RDA
		If BB8->(MsSeek(xFilial("BB8")+cRDAArq))
			cGCodExe := BB8->BB8_CODIGO	
		Else
			aadd(aErr,{"Executante nao encontrado/Sem local de atendimento. Codigo: "+cRDAArq,TRB->(NUMREG)})
			TRB->(DbSkip())
			Loop
		Endif
		
		dGDtAlta := CtoD("")		
    	cGSenha	 := Substr(cLinha,063,006)    	

		If !Empty(cGCid)   	    	
	    	If BA9->(MsSeek(xFilial("BA9")+AllTrim(cGCid)))
		    	cGCid := BA9->BA9_CODDOE
	    	Endif
	 	Endif

		lGravaGuia := .T.					
		
	Endif
	
	
	cChaveAnt	:= TRB->(NUMREG)

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Inserir itens da guia...                                            ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ	    	   	
	cICodProc	:= Substr(cLinha,069,008)
	nIQtdProc	:= Val(Substr(cLinha,077,002))
	nIVlrApr	:= Val(Substr(cLinha,087,010))/100
	nIVlrUni	:= nIVlrApr/nIQtdProc
	//dIDatProc	:= StoD(Substr(cLinha,020,008))
	dIDatProc	:= dGDtAtend
	//cIHorProc	:= Substr(cLinha,189,008)
	//cIViaProc	:= Substr(cLinha,230,001)
	//nIPerProc	:= Posicione("BGR",1,PLSINTPAD()+cIViaProc,"BGR_PERC")
	
	BR8->(DbSetOrder(3))
	If !BR8->(MsSeek(xFilial("BR8")+cICodProc))
	
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Realizar a troca de codigo antigo por codigo novo, caso exista...   ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		aRetCod := TrCdAnt(cICodProc)
		cICodProc := aRetCod[2]
		If !aRetCod[1] .Or. !BR8->(MsSeek(xFilial("BR8")+cICodProc))
			//aadd(aErr,{"Código não encontrado na tabela padrão. Código: "+cICodProc,TRB->(NUMREG)})
			//TRB->(DbSkip())
			//Loop
	     	//-----> Leandro 25/01/2007
	     	cICodProc := "99999994"
    	    BR8->(DbSetOrder(2))	
	        IF BR8->(MsSeek(xFilial("BR8")+ALLTRIM("PROCEDIMENTO GENERICO P/ IMPORT. ARQUIVO LAB")))
	          cICodProc := BR8->BR8_CODPSA 
	          //TRB->(DbSkip())
	          //Loop
	        End If
	        //-----<   
		Endif                 
	EndIf
	
	nQtdItem += nIQtdProc
	nVlrTotP += nIVlrUni
	
    	If lGravaGuia .And. Substr(cLinha,009,002) <> "90" 
   	    	Grava_Peg("I",cGTipGui,cGNroImp,cGSenha,cGCodExe)				
    	    cChaveGuia := Grava_Guia(cGTipGui,BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG+BA1_DIGITO),cGSenha,dGDtAtend,BA1->BA1_NOMUSR)			
		    aadd(aGuiImp,{cGTipGui,cGSenha,dGDtAtend,BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG+BA1_DIGITO),Substr(BA1->BA1_NOMUSR,1,25),cChaveGuia})		
        else
  			BCI->(DbSetOrder(1))
			if BCI->(MsSeek(xFilial("BCI")+BD5->(BD5_CODOPE+BD5_CODLDP+BD5_CODPEG))) 
              BCI->BCI_QTDEVE := BCI->BCI_QTDEVE + nQtdEve
              BCI->BCI_QTDEVD := BCI->BCI_QTDEVD + nQtdEve 
              BCI->BCI_VLRGUI := BCI->BCI_VLRGUI + nVlrGui
            end if  
           
     	Endif
	
   	    if Substr(cLinha,009,002) <> "90" 
   	       Grava_Item()	
   	    end if   
	
  TRB->(DbSkip())
Enddo


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Atualizar a quant. de eventos na ultima guia...                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ	    	   	
If nQtdItem > 0 .And. !Empty(Alltrim(cChaveGuia))
	If BD5->(MsSeek(xFilial("BD5")+PLSINTPAD()+cChaveGuia))
		BD5->(RecLock("BD5",.F.))
		BD5->BD5_QTDEVE := nQtdItem
		BD5->BD5_VLRPAG	:= nVlrTotP
		BD5->(MsUnlock())
	Endif
	nQtdItem := 0
	nVlrTotP := 0
	cChaveGuia := space(15)
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Fecha o arquivo temporario, e finaliza o ctr. de transacao...            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
TRB->(DbCLoseArea("TRB"))
End Transaction

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Impressao do relatorio de inconsistencias / importacao.                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
WnRel   := SetPrint(cAlias,nRel,cPerg,cTitulo,cDesc1,cDesc2,cDesc3,lDicion,aOrdens,lCompres,cTamanho,{},lFiltro,lCrystal)

If nLastKey == 27
	Set Printer To
	Ourspool(nRel)
	MS_FLUSH()
	Return
Endif              

SetDefault(aReturn,"BD5")

MsAguarde({|| Imprime() }, cTitulo, "", .T.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Libera impressao                                                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If  aReturn[5] == 1
	Set Printer To
	Ourspool(nRel)
End
MS_FLUSH()

Return




/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ Grava_Peg³ Autor ³ Jean Schulz           ³ Data ³ 08/04/05 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Grava BCI - PEG									          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ nenhum                                                     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function Grava_Peg(cOpcao,cTipGui,cNroImp,cSenha,cCodRDA)

Local cChaBCI := ""
Local cLdpPad := GetNewPar("MV_YHISLDP","0004")
Local lTemBCI := .F.
Local lAchou  := .F.
Local nLock   := PLSAbreSem("IMPCTSMED.SMF")
Local cPegCod := ""
Local lCriPeg := .F.

cOriMov := ""
cNumero	:= ""

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Grava BCI-PEG                                                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If cOpcao == "I"

	If cTipGui == "03"

		lAchou := .F.
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Posiciona cfme senha SIGA liberacao (Valida usuario)					 ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		/*If Val(cSenha) > 0
			BE4->(DbSetOrder(7))
			If BE4->(MsSeek(xFilial("BE4")+cSenha))		
			
				While BE4->BE4_SENHA == cSenha .And. !BE4->(Eof())
				
					If BE4->(BE4_OPEUSR+BE4_CODEMP+BE4_MATRIC+BE4_TIPREG) == BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG)
						If BE4->BE4_SITUAC <> "2" //Cancelada
							lAchou := .T.
							Exit
						Endif
						
					Endif		
					
					BE4->(DbSkip())
				Enddo
				
			Endif
		Endif
		*/
		
		If !lAchou	
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Posiciona cfme nro impresso (sistema antigo Caberj - valida usuario)	 ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			BE4->(DbSetOrder(6))
			If BE4->(MsSeek(xFilial("BE4")+cNroImp))		
				
				While Alltrim(BE4->BE4_NUMIMP) == cNroImp .And. !BE4->(Eof())
				
					If BE4->(BE4_OPEUSR+BE4_CODEMP+BE4_MATRIC+BE4_TIPREG) == BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG)
						lAchou := .T.
						Exit
					Endif					
					
					BE4->(DbSkip())
					
				Enddo
				
			Endif		
		Endif
		
		If lAchou		
			/*_cPeg   	:= BE4->BE4_CODPEG
			cCodLdp 	:= BE4->BE4_CODLDP
			cNumero 	:= BE4->BE4_NUMERO
			cOriMov		:= BE4->BE4_ORIMOV
			cGNroImp	:= BE4->BE4_NUMIMP
			BCI->(DbSetOrder(1))
			BCI->(MsSeek(xFilial("BCI")+BE4->(BE4_CODOPE+BE4_CODLDP+BE4_CODPEG)))
			

			BD6->(DbsetOrder(6))
			BD6->(MsSeek(xFilial("BD6")+BE4->(BE4_CODOPE+BE4_CODLDP+BE4_CODPEG+BE4_NUMERO+BE4_ORIMOV)))
			*/
	
		Else
			lCriPeg := .T.
		Endif	
	Else
		
		lAchou := .F.
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Verifica Senha + Usuario...											³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If Val(cSenha) > 0	

			BD5->(DbSetOrder(7))
			BD5->(MsSeek(xFilial("BD5")+cSenha))
	
			While BD5->(BD5_FILIAL+BD5_SENHA)==(xFilial("BD5")+cSenha) .and. ! BD5->(Eof())
	
				If BD5->BD5_SITUAC <> "2" //Cancelada
					If BD5->(BD5_OPEUSR+BD5_CODEMP+BD5_MATRIC+BD5_TIPREG) == BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG)
						lAchou := .T.
						Exit
					EndIf
		        Endif
	        
				BD5->(DbSkip())     
				
			EndDo
		    
		Endif
		
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Posiciona cfme nro impresso (sistema antigo Caberj - valida usuario)	 ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If !lAchou
			
			BD5->(DbSetOrder(6))
			BD5->(MsSeek(xFilial("BD5")+cNroImp))
		
			While Alltrim(BD5->BD5_NUMIMP) == Alltrim(cNroImp) .And. ! BD5->(Eof())
				
				If BD5->BD5_SITUAC <> "2" //Cancelada
					If BD5->(BD5_OPEUSR+BD5_CODEMP+BD5_MATRIC+BD5_TIPREG) == BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG)
						lAchou := .T.
						Exit
					EndIf
				Endif
				
				BD5->(DbSkip())
			EndDo
        Endif
       
		
		If lAchou

			_cPeg   := BD5->BD5_CODPEG
			cCodLdp := BD5->BD5_CODLDP
			cNumero := BD5->BD5_NUMERO
			cOriMov := BD5->BD5_ORIMOV
			cGNroImp := BD5->BD5_NUMIMP
			
			BCI->(DbSetOrder(1))
			BCI->(MsSeek(xFilial("BCI")+BD5->(BD5_CODOPE+BD5_CODLDP+BD5_CODPEG)))
			//-----> LEandro 25/01/2007
            BCI->BCI_QTDEVE := BCI->BCI_QTDEVE + nQtdEve
            BCI->BCI_QTDEVD := BCI->BCI_QTDEVD + nQtdEve 
            BCI->BCI_VLRGUI := BCI->BCI_VLRGUI + nVlrGui
            //-----<
            
            nQTDSAD := BCI->BCI_QTDEVE + nQtdEve
            nVLRSAD := BCI->BCI_VLRGUI + nVlrGui
            nQTDTOT := BCI->BCI_QTDEVE + nQtdEve
            nVLRTOT := BCI->BCI_VLRGUI + nVlrGui
            
           /* 
            ZZP->(DbSetOrder(1))
            ZZP->(MsSeek(xFilial("ZZP")+BCI->(BCI_CODRDA+BCI_MES+BCI_ANO)))
        	ZZP->(RecLock("ZZP",.F.))
            ZZP->ZZP_QTDSAD := nQtdSad
            ZZP->ZZP_VLRSAD := nVlrSad
       	    ZZP->ZZP_QTDTOT := nQtdSad
            ZZP->ZZP_VLRTOT := nVlrSad
           	ZZP->(MsUnlock("ZZP",.F.))
            */


			BD6->(DbsetOrder(6))
			BD6->(MsSeek(xFilial("BD6")+BD5->(BD5_CODOPE+BD5_CODLDP+BD5_CODPEG+BD5_NUMERO+BD5_ORIMOV)))

		Else       
			lCriPeg := .T.
		Endif

	EndIf
	
Else
	BCI->(RecLock("BCI",.F.))
	//BCI->BCI_QTDEVE := BCI->BCI_QTDEVE + nQtdGrv
	//BCI->BCI_QTDEVD := BCI->BCI_QTDEVE + nQtdGrv
	//BCI->BCI_VLRGUI := nVlrGui
    BCI->BCI_QTDEVE := BCI->BCI_QTDEVE + nQtdEve
    BCI->BCI_QTDEVD := BCI->BCI_QTDEVD + nQtdEve 
    BCI->BCI_VLRGUI := BCI->BCI_VLRGUI + nVlrGui
	BCI->(MsUnlock())
	/*
	ZZP->(RecLock("ZZP",.F.))
    ZZP->ZZP_QTDSAD := BCI->BCI_QTDEVD
    ZZP->ZZP_VLRSAD := BCI->BCI_VLRGUI
    ZZP->ZZP_QTDTOT := BCI->BCI_QTDEVD
    ZZP->ZZP_VLRTOT := BCI->BCI_VLRGUI
  	ZZP->(MsUnlock())
    */
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Cria PEG...             							      			  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If lCriPeg

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifica se cria PEG...             							      ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ	
	//cChaBCI := cCodOpe+cCodRda+cAno+cMes+"2" //Incluido eletronicamente via importacao
	cCodOpe := PLSINTPAD()
	cChaBCI := cCodOpe+cCodRda+cAno+cMes+"2" //Incluido eletronicamente via importacao
	
	
	BCI->(DbSetOrder(4))
	BCI->(MsSeek(xFilial("BCI")+cChaBCI))
	
	While BCI->(BCI_OPERDA+BCI_CODRDA+BCI_ANO+BCI_MES+BCI_TIPO)==cChaBCI .and. ! BCI->(Eof())
		
		If BCI->BCI_TIPGUI == cTipGui .and. BCI->BCI_CODLDP == cLdpPad .and. BCI->BCI_SITUAC == "1" .and. BCI->BCI_FASE <= "4"
			lTemBCI := .T.
			Exit
		Endif
		
		BCI->(DbSkip())
	EndDo
	
	If lTemBCI
		
		If BCI->BCI_FASE == "3"
			BCI->(RecLock("BCI",.F.))
			BCI->BCI_FASE := "4"
			BCI->(MsUnlock())
		Endif
		
	Else
		   
		cPegCod := PLSA175COD(PLSINTPAD(),cLdpPad)

		BCI->(RecLock("BCI",.T.))
		BCI->BCI_FILIAL := xFilial("BCI")
		BCI->BCI_CODOPE := PLSINTPAD()
		BCI->BCI_CODLDP := cLdpPad
		BCI->BCI_CODPEG := cPegCod
		BCI->BCI_OPERDA := PLSINTPAD()
		BCI->BCI_CODRDA := cCodRDA
		BCI->BCI_NOMRDA := Posicione("BAU",1,xFilial("BAU")+cCodRDA,"BAU_NOME")
		BCI->BCI_MES    := cMes
		BCI->BCI_ANO    := cAno
		BCI->BCI_TIPGUI := cTipGui
		BCI->BCI_CODCOR := Posicione("BCL",1,xFilial("BCL")+PLSINTPAD()+cTipGui,"BCL_CODCOR")
		BCI->BCI_TIPSER := GetNewPar("MV_PLSTPSP","01")
		BCI->BCI_DATREC := dDataBase
		BCI->BCI_DTDIGI := dDataBase
		BCI->BCI_STATUS := "1"
		BCI->BCI_FASE   := "1"
		BCI->BCI_SITUAC := "1"
		BCI->BCI_TIPO   := "2"
		BCI->BCI_ARQUIV := cNomeArq
		BCI->BCI_PROTOC := cProt
        BCI->BCI_QTDEVE := BCI->BCI_QTDEVE + nQtdEve
        BCI->BCI_QTDEVD := BCI->BCI_QTDEVD + nQtdEve 
        BCI->BCI_VLRGUI := BCI->BCI_VLRGUI + nVlrGui
		BCI->(MsUnlock())
		
		//Tabela que guarda o custo de entrada - Protocolo de Remessas(Customizacao) - Leandro 04/07/2007
	   /*	ZZP->(RecLock("ZZP",.T.))
		ZZP->ZZP_FILIAL := xFilial("ZZP")
	   	ZZP->ZZP_CODOPE := PLSINTPAD()
	    ZZP->ZZP_CODRDA := cCodRDA

	    BAU->(DbSetOrder(1))				
	    If !Empty(BAU->(MsSeek(xFilial("BAU")+cCodRDA)))
	       ZZP->ZZP_NOMRDA := BAU->BAU_NOME
	    EndIf
	    
	    ZZP->ZZP_MESPAG := cMes
	    ZZP->ZZP_ANOPAG := cAno
	    ZZP->ZZP_QTDSAD := BCI->BCI_QTDEVE
	    ZZP->ZZP_VLRSAD := BCI->BCI_VLRGUI
	    ZZP->ZZP_NUMLOT := 1
	    ZZP->ZZP_QTDTOT := BCI->BCI_QTDEVE
	    ZZP->ZZP_VLRTOT := BCI->BCI_VLRGUI
	    ZZP->ZZP_TIPREM := "1"
	    ZZP->ZZP_NUMREM := Val(cProt)
	    */
	EndIf
	
	_cPeg   := BCI->BCI_CODPEG
	cCodLdp := BCI->BCI_CODLDP
	If cTipGui == "03"
		cOriMov := "2"
		cNumero := ProxBE4(BCI->BCI_CODOPE,BCI->BCI_CODLDP,BCI->BCI_CODPEG)
	Else
		cOriMov := "1"
		cNumero := ProxBD5(BCI->BCI_CODOPE,BCI->BCI_CODLDP,BCI->BCI_CODPEG)
	Endif
Endif

PLSFechaSem(nLock,"IMPARQLAB.SMF")
TcRefresh("BCI")

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Fim da funcao                                                       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Return 


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ Grava_Guia ³ Autor ³ Jean Schulz           ³ Data ³ 27/04/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Grava Guia - BE4 (Internacao) ou BD5 (Consultas/Servicos)    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ nenhum                                                       ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function Grava_Guia(cTipGui,cCodUsr,cSenha,dDatEmi,cNomUsr)

Local cCodLdp := GetNewPar("MV_YHISLDP","0004")
Local cCC     := PLSUSRCC(cCodUsr)
Local cCodPad := ""
Local cCodPro := ""
Local cChave  := ""
Local cTipPar := ""
Local cVia    := ""
Local cCodPre := ""
Local cTipAdm := GetNewPar("MV_PLSTPAD","6")
Local cGrpInt := "1"
Local cTipInt := "01"
Local nDiaInt := 1
Local nPosCir := 0
Local nTemp   := 1
Local nTmp    := 0
Local nTmpAnt := 0
Local nClaHos := 0
Local aProCir := {}
Local aTotPro := {}
Local aVetRet := {}
Local aPorte  := {}
Local aTaxObs := {}
Local aVldPrt := {}    
Local nQtdDia := 0
Local cSigla  := ""
Local cRegSol := ""
Local cNomSol := ""
Local cEstSol := ""
Local cChaveGui := ""
Local cNumImpresso := ""  //Leandro 31/08/2007
Local cSenhaLiberada := "" //Leandro 31/08/2007 
                                      
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Posicionar tabelas para uso da funcao...                    		³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
BAU->(DbSetOrder(1))
BAU->(MsSeek(xFilial("BAU")+cGCodExe))

BB8->(DbSetOrder(1))
BB8->(MsSeek(xFilial("BB8")+BAU->BAU_CODIGO+PLSINTPAD()))

BAX->(DbSetOrder(1))
BAX->(MsSeek(xFilial("BAX")+BAU->BAU_CODIGO+PLSINTPAD()+BB8->BB8_CODLOC))

//-----> VERIFICACAO SE A GUIA JA FOI LIBERADA PELO CALLCENTER -> LEANDRO 31/08/2007
BD5->(DbSetOrder(6))
If BD5->(MsSeek(xFilial("BD5")+cNumGuiaArq))
  cNumImpresso := BD5->BD5_NUMIMP
EndIf

BD5->(DbSetOrder(7))
If BD5->(MsSeek(xFilial("BD5")+cNumGuiaArq))
  cSenhaLiberada := BD5->BD5_SENHA
EndIf
//-----<

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Grava Cabecalho da Guia somente para as guias importadas...			³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
if Substr(cLinha,009,002) == "03" //-----> nao gravar o registro de trailler
If BCI->BCI_CODLDP == cCodLdp
		BD5->(DbSetOrder(1))
		If ! BD5->(MsSeek(xFilial("BD5")+PLSINTPAD()+BCI->(BCI_CODLDP+BCI_CODPEG)+cNumero))
		
			BAX->(DbSetOrder(1))
			If BAX->(MsSeek(xFilial("BAX")+cGCodExe+PLSINTPAD()))
			
				BAU->(DbSetOrder(1))
				If BAU->(MsSeek(xFilial("BAU")+cGCodExe))
				
		            //If nTipImp > 1
						BD5->(RecLock("BD5",.T.))
						BD5->BD5_FILIAL := xFilial("BD5")
						BD5->BD5_CODOPE := PLSINTPAD()
						BD5->BD5_TIPPAC := "1"
						BD5->BD5_CODLDP := cCodLdp
						BD5->BD5_CODPEG := _cPeg
						BD5->BD5_NUMERO := cNumero	   
						BD5->BD5_SITUAC := "1"
                        
                        //Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS
                        BD5->BD5_MOTBLO := " "//BD5->BD5_MOTBLO == " "  						
                        
						/*
						IF (AllTrim(cNumImpresso) == cNumGuiaArq) .OR. (AllTrim(cSenhaLiberada) == cNumGuiaArq)						
							BD5->BD5_SITUAC := "3"
							BD5->BD5_MOTBLO := "008"
						EndIf
						*/
					
						BD5->BD5_NUMIMP := cGNroImp
						//BD5->BD5_DATPRO := dDatEmi
						BD5->BD5_DATSOL := dDatSol
						BD5->BD5_DATPRO := dGDtAtend
						BD5->BD5_HORPRO := Iif(Empty(Alltrim(cGHorPro)),"0800",cGHorPro)
						BD5->BD5_MATANT := BA1->BA1_MATANT
						BD5->BD5_NOMUSR := BA1->BA1_NOMUSR
						BD5->BD5_CODRDA := cGCodExe
						BD5->BD5_OPERDA := PLSINTPAD()
						BD5->BD5_TIPRDA := BAU->BAU_TIPPE
						BD5->BD5_NOMRDA := BAU->BAU_NOME
						BD5->BD5_DESLOC := BB8->BB8_DESLOC
						BD5->BD5_ENDLOC := BB8->BB8_END
						BD5->BD5_CODESP := BAX->BAX_CODESP
						BD5->BD5_CID    := cGCid

                        BB0->(DBSetOrder(1))
						If BB0->(MsSeek(xFilial("BB0")+cGPSaude))
						   sSigla  := BB0->BB0_CODSIG
						   cGcRol  := BB0->BB0_NUMCR
						   cNomSol := BB0->BB0_NOME
						   cGEstSol:= BB0->BB0_ESTADO
						End If
						
						BD5->BD5_ESTSOL := cGEstSol
						BD5->BD5_OPESOL := PLSINTPAD()
     					BD5->BD5_SIGLA  := sSigla
						BD5->BD5_REGSOL := cGcRSol
						BD5->BD5_NOMSOL := cNomSol
						BD5->BD5_TIPCON := "1"
						BD5->BD5_TIPGUI := cTipGui
						BD5->BD5_ATEAMB := "1"
						BD5->BD5_CDPFSO := Iif(Empty(cGCodSol),cGPSaude,cGCodSol)
						BD5->BD5_OPEUSR := BA1->BA1_CODINT
						BD5->BD5_CODEMP := BA1->BA1_CODEMP
						BD5->BD5_MATRIC := BA1->BA1_MATRIC
						BD5->BD5_TIPREG := BA1->BA1_TIPREG
						BD5->BD5_CPFUSR := BA1->BA1_CPFUSR
						BD5->BD5_IDUSR  := BA1->BA1_DRGUSR
						BD5->BD5_DATNAS := BA1->BA1_DATNAS
						BD5->BD5_CPFRDA := BAU->BAU_CPFCGC
						BD5->BD5_FASE   := "1" //---> Fase de digitacao
						
						/*
						IF (cGMatAtu == "00010003036750009") .OR. (cICodProc == "99999994") .OR. (cGcRSol = "0055000000")
						  If ALLTRIM(BD5->BD5_MOTBLO) == ""  
								IF (cGMatAtu == "00010003036750009") //MATRICULA GENERICA
								  BD5->BD5_SITUAC := "3"
								  BD5->BD5_MOTBLO := "005"
								ENDIF
								
								IF (cGcRSol = "0055000000" .AND. cGMatAtu <> "00010003036750009")  //RDA GENERICA
								  BD5->BD5_SITUAC := "3"
								  BD5->BD5_MOTBLO := "006"
								ENDIF
								
								IF (cICodProc == "99999994") .AND. (cGcRSol <> "0055000000" .AND. cGMatAtu <> "00010003036750009")//PROCEDIMENTO GENERICO
								  BD5->BD5_SITUAC := "3"
								  BD5->BD5_MOTBLO := "007"
								ENDIF
						  EndIf	
						EndIf	
						*/
		
						BD5->BD5_DIGITO := BA1->BA1_DIGITO
						BD5->BD5_CONEMP := BA1->BA1_CONEMP
						BD5->BD5_VERCON := BA1->BA1_VERCON
						BD5->BD5_SUBCON := BA1->BA1_SUBCON
						BD5->BD5_VERSUB := BA1->BA1_VERSUB
						BD5->BD5_LOCAL  := BB8->BB8_LOCAL
						BD5->BD5_CODLOC := BB8->BB8_CODLOC
						BD5->BD5_MATVID := BA1->BA1_MATVID
						BD5->BD5_DTDIGI := dDataBase
						BD5->BD5_MATUSA := cMatUsa
						BD5->BD5_QTDEVE := 0
						BD5->BD5_REGEXE := BAU->BAU_CONREG
						BD5->BD5_CDPFRE := BAU->BAU_CODBB0
						BD5->BD5_ESTEXE := BAU->BAU_ESTCR
						BD5->BD5_SIGEXE := BAU->BAU_SIGLCR
						BD5->BD5_ESTEXE := GetNewPar("MV_PLSESPD","RJ")

						BD5->BD5_ORIMOV := IIF(cTipGui ="03","2","1")
						BD5->BD5_MESPAG := cMes
						BD5->BD5_ANOPAG := cAno
						BD5->BD5_GUIACO := "0"
	 					BD5->BD5_NUMFAT := ""
						BD5->BD5_SEQPF	:= ""						
						BD5->BD5_TIPSAI := "5"
						BD5->BD5_TIPATE := "05"

						BD5->(MsUnlock())
						cChaveGui := BD5->(BD5_CODLDP+BD5_CODPEG+BD5_NUMERO)
					//EndIf
				Endif
			Else
				Aadd(aErr,{"Especialidade para RDA "+cGCodExe+" nao encontrada! N. Guia:"+cINroImp,TRB->(NUMREG)})
			Endif
		Else
            //If nTipImp > 1
				BD5->(RecLock("BD5",.F.))
				//BD5->BD5_DATPRO := dDatEmi
				BD5->BD5_DATPRO := dGDtAtend
				BD5->BD5_DATSOL := dDatSol
				BD5->(MsUnlock())
				cChaveGui := BD5->(BD5_CODLDP+BD5_CODPEG+BD5_NUMERO)
			//EndIf
		EndIf             
		
	//Endif
	
Else
		BD5->(DbSetOrder(1))
		If BD5->(MsSeek(xFilial("BD5")+PLSINTPAD()+BCI->(BCI_CODLDP+BCI_CODPEG)+cNumero))
            //If nTipImp > 1
				BD5->(RecLock("BD5",.F.))
				//BD5->BD5_DATPRO := dDatEmi
				BD5->BD5_DATPRO := dGDtAtend
				BD5->BD5_DATSOL := dDatSol				
				BD5->(MsUnlock())
				cChaveGui := BD5->(BD5_CODLDP+BD5_CODPEG+BD5_NUMERO)
			//EndIf
		Endif

EndIf
	BCI->(RecLock("BCI",.F.))
	BCI->BCI_STATUS := "1"
	BCI->BCI_FASE   := "1" //---> Fase de Digitacao
	BCI->BCI_SITUAC := "1"
	//-----> LEandro 25/01/2007
    BCI->BCI_QTDEVE := BCI->BCI_QTDEVE + nQtdEve
    BCI->BCI_QTDEVD := BCI->BCI_QTDEVD + nQtdEve 
    BCI->BCI_VLRGUI := BCI->BCI_VLRGUI + nVlrGui
	BCI->(MsUnlock())
	
EndIf

Return cChaveGui



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³Grava_ItemºAutor  ³ Jean Schulz        º Data ³  27/04/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Grava item da guia e composicao de cobranca/pagamento.      º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function Grava_Item

Local cSeq		:= ""
Local cTabTde	:= ""
Local aCodTab	:= {}
Local lGravaItem:= .F.

BR8->(DbSetOrder(3))

If BR8->(MsSeek(xFilial("BR8")+cICodProc))
   
	cGCid  := "Z00" //Cid Investigacao diagnostica
	BD6->(DbSetOrder(6))//BD6_FILIAL + BD6_CODOPE + BD6_CODLDP + BD6_CODPEG + BD6_NUMERO + BD6_ORIMOV+ + BD6_CODPAD + BD6_CODPRO
	BD6->(MsSeek(xFilial("BD6")+PLSINTPAD()+cCodLdp+_cPeg+cNumero+cOriMov+BR8->(BR8_CODPAD+BR8_CODPSA)))
	
	//If ! BD6->(Found()) .Or. (BD6->(Found()) .And. BD6->BD6_SITUAC == "2") 
	
	lGravaItem := .F.
	
	If ! BD6->(Found())
		lGravaItem := .T.
	Else
		While !BD6->(Eof()) .And. BD6->(BD6_CODOPE+BD6_CODLDP+BD6_CODPEG+BD6_NUMERO+BD6_ORIMOV+BD6_CODPAD+BD6_CODPRO) == PLSINTPAD()+cCodLdp+_cPeg+cNumero+cOriMov+BR8->(BR8_CODPAD+BR8_CODPSA)
		
			If BD6->BD6_DATPRO < Iif(Empty(dIDatProc),dGDtAtend,dIDatProc)
				lGravaItem := .T.
				Exit						
			Endif
			
			BD6->(DbSkip())
			
		Enddo
	Endif
	
	If lGravaItem .And. Substr(cLinha,009,002) == "03"
	
        //If nTipImp > 1
			cSeq := ProxSeq(PLSINTPAD(), cCodLdp, _cPeg, cNumero, cOriMov)						
		
			BD6->(Reclock("BD6",.T.))
			BD6->BD6_FILIAL := xFilial("BD6")
			BD6->BD6_CODOPE := PLSINTPAD()
			BD6->BD6_CODLDP := cCodLdp
			BD6->BD6_CODPEG := _cPeg
			BD6->BD6_NUMERO := cNumero
			BD6->BD6_SEQUEN := cSeq
			BD6->BD6_NUMIMP := cGNroImp
			BD6->BD6_CODPAD := BR8->BR8_CODPAD
			BD6->BD6_CODPRO := BR8->BR8_CODPSA
			BD6->BD6_QTDPRO := nIQtdProc
			//BD6->BD6_QTDAPR := nIQtdProc      //DESCONTINUADO P12
			/*
			BD6->BD6_VLRAPR := nIVlrApr
			BD6->BD6_VLRPAG := nIVlrUni
			BD6->BD6_YVLTAP := (nIVlrApr/nIQtdProc)
			*/
			BD6->BD6_VLRAPR := nIVlrUni  
			//BD6->BD6_VLRPAG := nIVlrUni   // valor p/ procedimento
			BD6->BD6_YVLTAP := nIVlrApr   // Valor total apresentado
			
			BD6->BD6_DESPRO := BR8->BR8_DESCRI
			BD6->BD6_LOCAL  := BB8->BB8_LOCAL
			BD6->BD6_CODESP := BAX->BAX_CODESP
			BD6->BD6_OPEUSR := BA1->BA1_CODINT
			BD6->BD6_CODEMP := BA1->BA1_CODEMP
			BD6->BD6_MATRIC := BA1->BA1_MATRIC
			BD6->BD6_TIPREG := BA1->BA1_TIPREG
			BD6->BD6_CONEMP := BA1->BA1_CONEMP
			BD6->BD6_MATVID := BA1->BA1_MATVID
			BD6->BD6_FASE   := "1"
			BD6->BD6_SITUAC := "1"

			//BCT_FILIAL + BCT_CODOPE + BCT_PROPRI + BCT_CODGLO			
			IF (AllTrim(cGMatAtu) == "00010003036750009") //MATRICULA GENERICA
				//BD6->BD6_SITUAC := "3"
				BD6->BD6_BLOPAG := "1"
				BD6->BD6_MOTBPG := "709"
				BD6->BD6_DESBPG := Posicione("BCT",1,PLSINTPAD()+"709","BCT_DESCRI") 
				BD6->BD6_ENVCON := "1"
			ENDIF
			
		/*	IF (AllTrim(cGCodSol) == "155555")  //RDA GENERICA
			  //BD6->BD6_SITUAC := "3"
				BD6->BD6_BLOPAG := "1"
				BD6->BD6_MOTBPG := "710"
				BD6->BD6_DESBPG := Posicione("BCT",1,PLSINTPAD()+"710","BCT_DESCRI")
				BD6->BD6_ENVCON := "1"
			ENDIF
		*/
			
			IF (AllTrim(cGCRSol) == "0055000000")  //RDA GENERICA
				//BD6->BD6_SITUAC := "3"
				BD6->BD6_BLOPAG := "1"
				BD6->BD6_MOTBPG := "710"
				BD6->BD6_DESBPG := Posicione("BCT",1,PLSINTPAD()+"710","BCT_DESCRI")
				BD6->BD6_ENVCON := "1"
			ENDIF
			
			
        	If !BR8->(MsSeek(xFilial("BR8")+AllTrim(cICodProc)))
        	   cICodProc := "99999994"
        	EndIf   

			IF (AllTrim(cICodProc) == "99999994") //PROCEDIMENTO GENERICO
				//BD6->BD6_SITUAC := "3"
				BD6->BD6_BLOPAG := "1"
				BD6->BD6_MOTBPG := "711"
				BD6->BD6_DESBPG := Posicione("BCT",1,PLSINTPAD()+"711","BCT_DESCRI")  
				BD6->BD6_ENVCON := "1"			  
			ENDIF

			BD6->BD6_TIPSAI := "5"
			BD6->BD6_TIPATE := "05"
			BD6->BD6_DATSOL := BD5->BD5_DATSOL
			
			If cCodLdp == "0004"
			  BD5->(DbSetOrder(1))   		
			  If BD5->(MsSeek(xFilial("BD5")+PLSINTPAD()+cCodLdp+_cPeg+cNumero))
				BD6->BD6_MESPAG := BD5->BD5_MESPAG
				BD6->BD6_ANOPAG := BD5->BD5_ANOPAG
			  Else
				BD6->BD6_MESPAG := cMes
				BD6->BD6_ANOPAG := cAno
			  Endif
			Else
				BD6->BD6_MESPAG := cMes
				BD6->BD6_ANOPAG := cAno
			Endif
			BD6->BD6_OPERDA := PLSINTPAD()
			//BD6->BD6_CODRDA := cGCodSol
			BD6->BD6_CODRDA := cRDAExec
			BD6->BD6_DATPRO := Iif(Empty(dIDatProc),dGDtAtend,dIDatProc)
			cGHorPro := Iif(Empty(cGHorPro),"0800",cGHorPro)
			BD6->BD6_HORPRO := Iif(Empty(Alltrim(cIHorProc)),cGHorPro,cIHorProc)
			BD6->BD6_DTDIGI := dDataBase
			BD6->BD6_TPGRV  := "4"
			BD6->BD6_STATUS := "1"
			BD6->BD6_SIGLA  := Posicione("BB0",1,xFilial("BB0")+Iif(Empty(cGCodSol),cGPSaude,cGCodSol),"BB0_CODSIG")
			BD6->BD6_ESTSOL := Posicione("BB0",1,xFilial("BB0")+Iif(Empty(cGCodSol),cGPSaude,cGCodSol),"BB0_ESTADO")
			BD6->BD6_NOMSOL := Posicione("BB0",1,xFilial("BB0")+Iif(Empty(cGCodSol),cGPSaude,cGCodSol),"BB0_NOME")
			BD6->BD6_REGSOL := Posicione("BB0",1,xFilial("BB0")+Iif(Empty(cGCodSol),cGPSaude,cGCodSol),"BB0_NUMCR")
			BD6->BD6_CODLOC := BB8->BB8_CODLOC
			BD6->BD6_CDPFSO := cGCodSol
			
			BD6->BD6_DIGITO := BA1->BA1_DIGITO
			BD6->BD6_ATEAMB := IIF(cGTipGui=="03","0","1")
			If ! Empty(cGCid)
				BD6->BD6_CID := cGCid
			Endif
			BD6->BD6_CPFRDA := BAU->BAU_CPFCGC
			BD6->BD6_DATNAS := BA1->BA1_DATNAS
			BD6->BD6_DESLOC := BB8->BB8_DESLOC
			BD6->BD6_ENDLOC := BB8->BB8_END
			BD6->BD6_IDUSR  := BA1->BA1_DRGUSR
			BD6->BD6_NOMRDA := BAU->BAU_NOME
			BD6->BD6_NOMUSR := BA1->BA1_NOMUSR
			BD6->BD6_TIPGUI := cGTipGui
			BD6->BD6_TIPRDA := BAU->BAU_TIPPE
			BD6->BD6_MATUSA := cMatUsa
			BD6->BD6_MATANT := BA1->BA1_MATANT
			BD6->BD6_CODPLA := Iif(Empty(BA1->BA1_CODPLA),BA3->BA3_CODPLA,BA1->BA1_CODPLA)
			BD6->BD6_GUIORI := cGNroImp
			BD6->BD6_REGEXE := BAU->BAU_CONREG
			BD6->BD6_CDPFRE := BAU->BAU_CODBB0
			BD6->BD6_ESTEXE := BAU->BAU_ESTCR
			BD6->BD6_SIGEXE := BAU->BAU_SIGLCR
			BD6->BD6_ORIMOV := IIF(cgTipGui ="03","2","1")
			BD6->BD6_GUIACO := "0"
			BD6->BD6_NIVEL  := BR8->BR8_NIVEL
			BD6->BD6_TIPUSR := BA3->BA3_TIPOUS
			BD6->BD6_MODCOB := BA3->BA3_MODPAG
			BD6->BD6_INTERC := IIF(BA1->BA1_CODEMP == GetNewPar("MV_PLSGEIN","9999"),"1","0")
			BD6->BD6_TIPINT := IIF(BD6->BD6_INTERC=="1","1","")
			BD6->BD6_PROCCI := IIF(BR8->BR8_TIPEVE=="2","1","0")
			If BR8->BR8_CTREQU=="1"
				BD6->BD6_VIA    := cIViaProc
				BD6->BD6_PERVIA := nIPerProc
			Endif
			BD6->BD6_CDPDRC := BR8->BR8_CODPAD
			M->BD6_CDNV01   := ""
			M->BD6_CDNV02   := ""
			M->BD6_CDNV03   := ""
			M->BD6_CDNV04   := ""
			PLSGatNiv(BR8->BR8_CODPAD,BR8->BR8_CODPSA,"BD6")
			BD6->BD6_CDNV01 := M->BD6_CDNV01
			BD6->BD6_CDNV02 := M->BD6_CDNV02
			BD6->BD6_CDNV03 := M->BD6_CDNV03
			BD6->BD6_CDNV04 := M->BD6_CDNV04
			aCodTab := PLSRETTAB(BD6->BD6_CODPAD,BD6->BD6_CODPRO,BD6->BD6_DATPRO,;
			BD6->BD6_CODOPE,BD6->BD6_CODRDA,BD6->BD6_CODESP,BD6->BD6_SUBESP,BD6->(BD6_CODLOC+BD6_LOCAL))
			/*
			If aCodTab[1]
				BD6->BD6_ALIATB := aCodTab[4]
			EndIf
			*/
			cTabTde := Posicione("BA8",4,xFilial("BA8")+BR8->BR8_CODPSA,"BA8_CODTAB")
			BD6->BD6_CODTAB := substr(cTabTde,5,3)
			BD6->BD6_CONEMP := BA1->BA1_CONEMP
			BD6->BD6_VERCON := BA1->BA1_VERCON
			BD6->BD6_SUBCON := BA1->BA1_SUBCON
			BD6->BD6_VERSUB := BA1->BA1_VERSUB
			BD6->BD6_OPEORI := BA1->BA1_OPEORI
			/*
			If BD6->BD6_QTD1 = 0
				BD6->BD6_QTD1  := 1
				BD6->BD6_PERC1 := 100
			EndIf
			*/
			BD6->(MsUnlock())
	   
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Grava BD7                                                           ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			cRda := BD6->BD6_CODRDA
			cCrm := BAU->BAU_CONREG
			cBB0 := BAU->BAU_CODBB0
	
			PLS720IBD7("0",BD6->BD6_VLPGMA,BR8->BR8_CODPAD,BR8->BR8_CODPSA,substr(cTabTde,5,3),;
			PLSINTPAD(),cGCodExe,BAU->BAU_CONREG,BAU->BAU_SIGLCR,;
			BAU->BAU_ESTCR,BAU->BAU_CODBB0,BAX->BAX_CODESP,BB8->BB8_CODLOC,;
			"1",cSeq,IIF(cGTipGui ="03","2","1"),cGTipGui)
	
		//EndIf
		
	Endif
	
Endif

Return
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ ProxBE4  ³ Autor ³ Thiago Machado Correa ³ Data ³ 20/10/05 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Retorna o proximo numero disponivel                        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ Unimed Tubarao		                                      ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ProxBE4(cCodOpe,cCodLdp,cCodPeg)

Local cRet := ""

BE4->(DbSetOrder(1))
BE4->(MsSeek(xFilial("BE4")+cCodOpe+cCodLDP+cCodPeg+"99999999",.T.))
BE4->(DbSkip(-1))

If BE4->(BE4_FILIAL+BE4_CODOPE+BE4_CODLDP+BE4_CODPEG) == (xFilial("BE4")+cCodOpe+cCodLdp+cCodPeg)
	cRet := Strzero(Val(BE4->BE4_NUMERO)+1,8)
Else
	cRet := StrZero(1,8)
Endif

Return cRet


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ ProxBD5  ³ Autor ³ Thiago Machado Correa ³ Data ³ 08/04/05 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Retorna o proximo numero disponivel                        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ Unimed Tubarao		                                      ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ProxBD5(cCodOpe,cCodLdp,cCodPeg)

Local cRet := ""

BD5->(DbSetOrder(1))
BD5->(DbSeek(xFilial("BD5")+cCodOpe+cCodLDP+cCodPeg+"99999999",.T.))
BD5->(DbSkip(-1))

If BD5->(BD5_FILIAL+BD5_CODOPE+BD5_CODLDP+BD5_CODPEG) == (xFilial("BD5")+cCodOpe+cCodLdp+cCodPeg)
	cRet := Strzero(Val(BD5->BD5_NUMERO)+1,8)
Else
	cRet := StrZero(1,8)
Endif

Return cRet

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ ProxSeq  ³ Autor ³ Thiago Machado Correa ³ Data ³ 08/04/05 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Retorna o proximo numero disponivel                        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ Unimed Tubarao		                                      ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ProxSeq(cCodOpe, cCodLdp, cCodPeg, cNumero, cOriMov)

Local cRet := ""

BD6->(DbSetOrder(1))
BD6->(DbSeek(xFilial("BD6")+cCodOpe+cCodLdp+cCodPeg+cNumero+cOriMov+"999",.T.))
BD6->(DbSkip(-1))

If BD6->(BD6_FILIAL+BD6_CODOPE+BD6_CODLDP+BD6_CODPEG+BD6_NUMERO+BD6_ORIMOV) == (xFilial("BD6")+cCodOpe+cCodLdp+cCodPeg+cNumero+cOriMov)
	cRet := Strzero(Val(BD6->BD6_SEQUEN)+1,3)
Else
	cRet := StrZero(1,3)
Endif

Return cRet


Return lGravou



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³Imprime   ºAutor  ³                    º Data ³             º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Imprime relatorio cfme solicitado pela rotina.              º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³                                                            º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function Imprime
Local nCont		:= 0
Local nTotImp	:= 0

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Impressao de erros e inconsistencias encontradas...                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cCabec2 := PADC("Relatório de inconsistências",nLimite) 
Cabec(cTitulo,cCabec1,cCabec2,cNomeProg,cTamanho,nControle)  
nLin := 9

For nCont := 1 to Len(aErr)

	If nLin > nQtdLin
		Cabec(cTitulo,cCabec1,cCabec2,cNomeProg,cTamanho,nControle)  
		nLin := 9
	Endif 
	
	@ nLin, 000 PSay aErr[nCont,1]+Iif(Val(aErr[nCont,2])>0," Linha: "+aErr[nCont,2],"")
	nLin++

Next

@ nLin, 000 PSay Replicate("-",nLimite)
nLin++
@ nLin, 000 PSay "Total de inconsistências: "+Transform(Len(aErr),"@E 999,999.99")
nLin++                                                          


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Impressao de guias importadas corretamente.... 		                ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
nTotImp := 0

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Impressao de guias importadas...                                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cCabec2 := PADC("Relatório de guias importadas",nLimite) 
Cabec(cTitulo,cCabec1,cCabec2,cNomeProg,cTamanho,nControle)  
nLin := 9

For nCont := 1 to Len(aGuiImp)
	
	If nLin > nQtdLin
		Cabec(cTitulo,cCabec1,cCabec2,cNomeProg,cTamanho,nControle)
		nLin := 9
	Endif 
	
	@ nLin, 000 PSay "Senha: "+aGuiImp[nCont,2]+" Dt.Atend: "+DtoC(aGuiImp[nCont,3])+ " Cod.Usr: "+aGuiImp[nCont,4]+" Nome Usr: "+aGuiImp[nCont,5]+" Chave: "+aGuiImp[nCont,6]
	nLin++	
	
	nTotImp++		
	
Next	
@ nLin, 000 PSay Replicate("-",nLimite)
nLin++
@ nLin, 000 PSay "Total de guias importadas: "+Transform(nTotImp,"@E 999,999.99")
nLin++

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³VeTipGui  ºAutor  ³Microsiga           º Data ³  19/08/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Retorna o tipo de guia que devera ser importado o documento.º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
/*Static Function VeTipGui(cLote, cDoc, cLinha)
Local cTipGui	:= ""
Local nRecno	:= 0

nRecno := TRB->(RECNO())

If Substr(cLinha,53,1) == "I" //Internacao
	cTipGui := "3"
Else
	If Substr(cLinha,248,8) $ ("00010014,00010073,10101012,10101039")
		cTipGui := "1"
		TRB->(DbSkip())
		cLinha := TRB->(NUMREG+DtoS(DATENV)+CODRDA+LOTE+DOC+CAMPO)
		
		If cLote+cDoc==Substr(cLinha,26,14)
			cTipGui := "2"
		Endif
		
		TRB->(DbSkip(-1))
	Else
		cTipGui := "2"
	Endif

Endif

TRB->(DbGoto(nRecno))

Return cTipGui
*/

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³AjustaSX1 ºAutor  ³ Caberj               º Data ³ 17/01/06  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Cria / ajusta as perguntas da rotina                       º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function AjustaSX1(cPerg)

Local aHelpPor := {}
Local aHelpEng := {}
Local aHelpSpa := {}
Local aTam

aHelpPor := {}
aAdd( aHelpPor, "Informe a RDA do Arquivo XXXXXXX.               " )
aAdd( aHelpPor, "Utilize F3 para pesquisar.              " )
aAdd( aHelpPor, "                                        " )
aTam := {06,00}
PutSx1(cPerg,"01","Codigo da RDA"           ,"","","mv_ch1","C",aTam[1],aTam[2],0,"G","","BAUPLS","","","mv_par01","","","","","","","","","","","","","","","","",aHelpPor,{},{})

aHelpPor := {}
aAdd( aHelpPor, "Informe a competencia de pagamento      " )

aAdd( aHelpPor, "                                        " )
aTam := {07,00}
PutSx1(cPerg,"02","Competencia de Pgto"     ,"","","mv_ch2","C",aTam[1],aTam[2],0,"G","","","","","mv_par02","","","","","","","","","","","","","","","","",aHelpPor,{},{})

Pergunte(cPerg,.T.)

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³TrCdAnt   ºAutor  ³Microsiga           º Data ³  25/10/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Troca codigo antigo pelo novo, conforme cadastro em BA8.    º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Microsiga.                                                 º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function TrCdAnt(cCodAnt)
Local aRet		:= {.F.,cCodAnt}
Local cSQL		:= ""

cSQL := " SELECT BA8_CODPAD, BA8_CODPRO FROM "+RetSQLName("BA8")
cSQL += " WHERE BA8_CODANT = '"+cCodAnt+"' "
cSQL += " AND D_E_L_E_T_ = ' ' "
PlsQuery(cSQL,"TRB1")

If !Empty(TRB1->BA8_CODPRO)
	aRet[1] := .T.
	aRet[2] := TRB1->BA8_CODPRO
Endif

TRB1->(DbCloseArea())

Return aRet
