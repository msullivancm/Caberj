#Include "rwmake.ch"
#Include "plsmger.ch"
#Include "plsmlib.ch"
#Include "colors.ch"
#Include "topconn.ch"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออออหออออออัอออออออออออปฑฑ
ฑฑบPrograma  ณ ENCINTAU บ Autor ณ Jean Schulz          บ Data ณ 04/09/08  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออออสออออออฯอออออออออออนฑฑ
ฑฑบDescricao ณ Rotina para inserir data de alta automaticamente conforme  บฑฑ
ฑฑบ          ณ regras estabelecidas pela Caberj.                          บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
User Function ENCINTAU

Private oLeTxt
Private lAbortPrint :=.F.

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Declaracao de Variaveis                                             ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
PRIVATE cNomeProg   := "ENCINTAU"
PRIVATE cPerg       := "ECINAU"
PRIVATE nQtdLin     := 58
PRIVATE nLimite     := 132
PRIVATE cControle   := 15
PRIVATE cAlias      := "BE4"
PRIVATE cTamanho    := "G"
PRIVATE cTitulo     := "Encerra interna็๕es automaticamente"
PRIVATE cDesc1      := ""
PRIVATE cDesc2      := ""
PRIVATE cDesc3      := ""
PRIVATE nRel        := "ENCINTAU"
PRIVATE nlin        := 100
PRIVATE nOrdSel     := 1
PRIVATE m_pag       := 1
PRIVATE lCompres    := .F.
PRIVATE lDicion     := .F.
PRIVATE lFiltro     := .T.
PRIVATE lCrystal    := .F.
PRIVATE aOrdens     := {} 
PRIVATE aReturn     := { "", 1,"", 1, 1, 1, "",1 }
PRIVATE lAbortPrint := .F.
PRIVATE cCabec1     := "Interna็๕es que nใo possuem data de alta e preenchem os requisitos para fechamento automแtico"
PRIVATE cCabec2     := "C๓digo Beneficiแrio   Nome Beneficiแrio                        Senha       Dados RDA                        Regime Inform.   CID                                Dt.Int.  Dt.Bloq. Mot.Bloqueio        Dt.Obt.  Dt.Sugerida  "
PRIVATE nColuna     := 00
PRIVATE nOrdSel     := 0
PRIVATE nHdl
PRIVATE nTipo		:= GetMv("MV_COMP")


@ 200,1 TO 380,380 DIALOG oLeTxt TITLE OemToAnsi("Data de alta automแtica")
@ 02,10 TO 65,180
@ 10,018 Say " Este programa irแ inserir uma data de alta em interna็๕es   "
@ 18,018 Say " abertas, conforme padr๕es estabelecidos pela Caberj.        "
@ 70,098 BMPBUTTON TYPE 05 ACTION AjustaSX1(cPerg)
@ 70,128 BMPBUTTON TYPE 01 ACTION OkLeTxt()
@ 70,158 BMPBUTTON TYPE 02 ACTION Close(oLeTxt)

Activate Dialog oLeTxt Centered                      

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFuno    ณ OKLETXT  บ Autor ณ                    บ Data ณ  09/04/03   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescrio ณ Funcao chamada pelo botao OK na tela inicial de processamenบฑฑ
ฑฑบ          ณ to. Executa a leitura do arquivo texto.                    บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Programa principal                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
Static Function OkLeTxt
Private cCodOpe	:= ""
Private cEmpDe		:= ""
Private cEmpAte	:= ""
Private cMatDe		:= ""
Private cMatAte	:= ""
Private nAcao		:= 0
Private dDatBas	:= CtoD("")
Private nSomDtS	:= 0

Pergunte(cPerg,.F.) 

cCodOpe	:= mv_par01
cEmpDe	:= mv_par02
cEmpAte	:= mv_par03
cMatDe	:= mv_par04
cMatAte	:= mv_par05
nAcao		:= mv_par06
dDatBas	:= mv_par07
nSomDtS	:= mv_par08

WnRel   := SetPrint(cAlias,nRel,cPerg,cTitulo,cDesc1,cDesc2,cDesc3,lDicion,aOrdens,lCompres,cTamanho,{},lFiltro,lCrystal)

If nLastKey == 27
	Return
Endif              

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Seleciona tabelas...                                                     ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
BA1->(DbSetOrder(2))
BE4->(DbSetOrder(1))
BA9->(DbSetOrder(1))
BG3->(DbSetOrder(1))
BG1->(DbSetOrder(1))
BCA->(DbSetOrder(1)) //BCA_FILIAL + BCA_MATRIC + BCA_TIPREG + DTOS(BCA_DATA) + BCA_TIPO


//Manda imprimir...
SetDefault(aReturn,"BE4")

//MsAguarde({|| Processa1() }, cTitulo, "", .T.)
Processa({||Processa1(),cTitulo})

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Libera impressao                                                         ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
If  aReturn[5] == 1
	Set Printer To
	Ourspool(nRel)
End

MS_FLUSH()

Return                 


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFuno    ณ PROCESSA1บ Autor ณ Jean Schulz        บ Data ณ  28/03/07   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescrio ณ Funcao auxiliar chamada pela PROCESSA.  A funcao PROCESSA  บฑฑ
ฑฑบ          ณ monta a janela com a regua de processamento.               บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Programa principal                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
Static Function Processa1()

Local nTotRec	:= 0
Local nCont		:= 0
Local aUsrBlo	:= {}
Local aDadUsr	:= {}
Local aRet		:= {} 
Local dDtSuger	:= CtoD("")
Local cDesBlo	:= ""
Local cCodANS	:= ""
Local _nTotRCB	:= 0
Local _aVetRCB := {}
Local _aArea	:= {}

Private lAmbos  := .t.

nTotRec := BuscaRegs()

ProcRegua(nTotRec)
TRB->(DbGoTop())

nLin := 999

While !TRB->(Eof())
	
	nCont++
	IncProc("Processando Registro " + strzero(nCont,8)+" / "+StrZero(nTotRec,8))
	
	If nLin > nQtdLin
		nLin := Cabec(cTitulo,cCabec1,cCabec2,cNomeProg,cTamanho,nTipo)
		nLin+=2
	Endif
	
	//BCA_FILIAL + BCA_MATRIC + BCA_TIPREG + DTOS(BCA_DATA) + BCA_TIPO
	BCA->(MsSeek(xFilial("BCA")+TRB->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG+DtoS(BA1_DATBLO)+"0")))

	cDesBlo := ""
	cCodANS := ""
	
	Do Case
		Case BCA->BCA_NIVBLQ == "U"
			If BG3->(MsSeek(xFilial("BG3")+BCA->BCA_MOTBLO))
				cDesBlo := BG3->BG3_DESBLO
				cCodANS := BG3->BG3_BLQANS
			Endif
		Case BCA->BCA_NIVBLQ == "F"
			If BG1->(MsSeek(xFilial("BG1")+BCA->BCA_MOTBLO))
				cDesBlo := BG1->BG1_DESBLO
				cCodANS := BG1->BG1_BLQANS
			Endif
		OtherWise
			If BQU->(MsSeek(xFilial("BQU")+BCA->BCA_MOTBLO))
				cDesBlo := BQU->BQU_DESBLO
				cCodANS := BQU->BQU_BLQANS
			Endif
	Endcase
		
	dDtSuger := fDatAltSug(TRB->BE4_DATPRO, TRB->BE4_REGINT, TRB->BA1_DATBLO, TRB->BCA_DTOBIT, cCodANS)
		
	If nSomDtS == 1 .Or. (nSomDtS > 1 .And. !Empty(dDtSuger))
		@ nLin,000 PSay Transform(TRB->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG+BA1_DIGITO),"@R 9999.9999.999999.99-9")+" "+;
							 Substr(TRB->BA1_NOMUSR,1,40)+" "+;
							 Substr(TRB->BE4_SENHA,1,11)+" "+;
							 TRB->BE4_CODRDA+" "+;
							 Substr(TRB->BAU_NOME,1,25)+" "+;
							 TRB->BE4_REGINT+"-"+x3combo("BE4_REGINT",TRB->BE4_REGINT)+Space(15-Len(x3combo("BE4_REGINT",TRB->BE4_REGINT)))+;
							 TRB->BE4_CID+" "+Substr(Posicione("BA9",1,xFilial("BA9")+TRB->BE4_CID,"BA9_DOENCA"),1,25)+" "+;
							 DtoC(TRB->BE4_DATPRO)+" "+;
							 DtoC(TRB->BA1_DATBLO)+" "+;
							 Iif(Empty(BCA->BCA_MOTBLO),Space(19),BCA->BCA_MOTBLO+" "+Substr(cDesBlo,1,15))+" "+;
							 DtoC(StoD(TRB->BCA_DTOBIT))+" "+;
							 DtoC(dDtSuger)+Iif(nAcao > 1 .And. !Empty(dDtSuger),"*","")
		nLin++
	Endif
	
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Caso seja para atualizar, marca a data de alta com a data sugerida.		  ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู	
	If nAcao	> 1 .And. !Empty(dDtSuger)
	
		_aArea := GetArea()
	
		BE4->(DbGoTo(TRB->REGBE4))
		BE4->(RecLock("BE4",.F.))
		BE4->BE4_DTALTA := dDtSuger
		BE4->(MsUnlock())            
		
		If !Empty(dDtSuger)

			//BD6_FILIAL+BD6_OPEUSR+BD6_CODEMP+BD6_MATRIC+BD6_TIPREG+BD6_DIGITO+DTOS(BD6_DATPRO)+BD6_CODPAD+BD6_CODPRO+BD6_FASE+BD6_SITUAC+BD6_HORPRO                         
			_cSQL := " SELECT BD5.R_E_C_N_O_  AS REGBD5 "
			_cSQL += " FROM "+RetSQLName("BD5")+ " BD5 "
			_cSQL += " WHERE BD5_FILIAL = '"+xFilial("BD5")+"' "
			_cSQL += " AND BD5_OPEUSR = '"+BE4->BE4_OPEUSR+"' "
			_cSQL += " AND BD5_CODEMP  = '"+BE4->BE4_CODEMP+"' "
			_cSQL += " AND BD5_MATRIC  = '"+BE4->BE4_MATRIC+"' "
			_cSQL += " AND BD5_TIPREG  = '"+BE4->BE4_TIPREG+"' "
			_cSQL += " AND BD5_DIGITO  = '"+BE4->BE4_DIGITO+"' "
			_cSQL += " AND BD5_SITUAC = '1' "
			_cSQL += " AND BD5_FASE >= '3' "
			_cSQL += " AND BD5_NUMSE1 = ' ' "
			_cSQL += " AND BD5_DATPRO >= '"+DtoS(dDtSuger)+"' "
			_cSQL += " AND BD5_ORIMOV = '1' "
			_cSQL += " AND BD5.D_E_L_E_T_ = ' ' "
			
			PLSQuery(_cSQL,"TRB500GR")
			
			While !(TRB500GR->(EOF()))	
				aadd(_aVetRCB,TRB500GR->(REGBD5))	
				TRB500GR->(DbSkip())
			Enddo				
			TRB500GR->(DbCloseArea())   						
			
			Processa({|| ProcRCB(_nTotRCB,_aVetRCB,BE4->(BE4_OPEUSR+BE4_CODEMP+BE4_MATRIC+BE4_TIPREG+BE4_DIGITO)) }, "Aguarde", "Revalorizando cobran็a de guias ambulatoriais...", .T.)
			
			RestArea(_aArea)
			
			BDH->(DbCloseArea())
		
		Endif		
		
	Endif
	
	TRB->(DbSkip())

Enddo

TRB->(DbCloseArea())
Close(oLeTxt)

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณBuscaRegs บAutor  ณMicrosiga           บ Data ณ  03/28/07   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function BuscaRegs()
Local nQtdReg := 0
Local cSQL := ""  
Local nCont := 0

For nCont := 1 to 2
	If nCont == 1
		cSQL := " SELECT COUNT(BE4.R_E_C_N_O_) AS TOTAL "
	Else
		cSQL := " SELECT BA1_CODINT, BA1_CODEMP, BA1_MATRIC, BA1_TIPREG, BA1_DIGITO, BA1_NOMUSR, BA1_DATBLO, BE4_SENHA, BE4_CODRDA, BAU_NOME, BE4_DATPRO, BE4_REGINT, BE4_DTALTA, BE4_CID, BA1_MOTBLO, "		
		cSQL += " (SELECT Max(BCA_YDTBLO)  FROM BCA010 WHERE BCA_FILIAL = '"+xFilial("BCA")+"' AND BCA_MATRIC||BCA_TIPREG = BE4_OPEUSR||BE4_CODEMP||BE4_MATRIC||BCA_TIPREG AND BCA_DATA = BA1_DATBLO AND D_E_L_E_T_ = ' ' AND BCA_TIPO = '0' AND BCA_YDTBLO <> ' ') AS BCA_DTOBIT, "
		cSQL += " BE4.R_E_C_N_O_ AS REGBE4 "
	Endif

	cSQL += " FROM BE4010 BE4, BA1010 BA1, BAU010 BAU "
	cSQL += " WHERE BE4_FILIAL = '"+xFilial("BE4")+"' "
	cSQL += " AND BE4_FASE = '1' "
	cSQL += " AND BE4_SITUAC = '1' "
	cSQL += " AND BE4_DTALTA = ' ' "
	cSQL += " AND BE4_OPEUSR = '"+cCodOpe+"' "
	cSQL += " AND BE4_CODEMP BETWEEN '"+cEmpDe+"' AND '"+cEmpAte+"' "
	cSQL += " AND BE4_MATRIC BETWEEN '"+cMatDe+"' AND '"+cMatAte+"' "
	cSQL += " AND BE4_DATPRO BETWEEN '19700101' AND '"+DtoS(dDatBas)+"' "

	cSQL += " AND BA1_FILIAL = '"+xFilial("BA1")+"' "
	cSQL += " AND BA1_CODINT = BE4_OPEUSR "
	cSQL += " AND BA1_CODEMP = BE4_CODEMP "
	cSQL += " AND BA1_MATRIC = BE4_MATRIC "
	cSQL += " AND BA1_TIPREG = BE4_TIPREG "

	cSQL += " AND BAU_FILIAL = '"+xFilial("BAU")+"' "
	cSQL += " AND BAU_CODIGO = BE4_CODRDA "

	cSQL += " AND ( BE4_REGINT = '2' OR BA1_DATBLO <> ' ' ) "
	cSQL += " AND BE4.D_E_L_E_T_ = ' ' "
	cSQL += " AND BA1.D_E_L_E_T_ = ' ' "
	cSQL += " AND BAU.D_E_L_E_T_ = ' ' "
			
	If nCont == 1
		PLSQuery(cSQL,"TRB")
		nQtdReg := TRB->(TOTAL)
		TRB->(DbCloseArea())
	Else
		cSQL += " ORDER BY BE4_DATPRO, BA1_CODINT, BA1_CODEMP, BA1_MATRIC, BA1_TIPREG, BA1_DIGITO "
		PLSQuery(cSQL,"TRB")
	Endif
Next

Return nQtdReg


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณfDatAltSugบAutor  ณMicrosiga           บ Data ณ  04/09/08   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณDevolve a data para alta automatica.                        บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function fDatAltSug(dDatPro, cRegInt, dDatBlo, dDatObt, cCodBloANS)
Local dDatSuger := CtoD("")

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Hospital-Dia: sempre finalizar a internacao na data de entrada.		ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
If cRegInt == "2"
	dDatSuger := dDatPro
Endif

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Obito do beneficiario: finalizar com data do obito.            		ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
If !Empty(dDatObt) .And. !Empty(dDatBlo)
	dDatSuger := StoD(dDatObt)
Endif  

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Caso beneficiario bloqueado, finalizar as internacoes...       		ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
If !Empty(dDatBlo) .And. Empty(dDatSuger)
	dDatSuger := dDatBlo
Endif

Return dDatSuger

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณAjustaSX1 บAutor  ณ Jean Schulz        บ Data ณ  28/03/06   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Ajusta os parametros                                       บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function AjustaSX1(cPerg)
Local aHelpPor := {}

PutSx1(cPerg,"01",OemToAnsi("Operadora")			,"","","mv_ch1","C",04,0,0,"G","","B89","","","mv_par01","","","","","","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"02",OemToAnsi("Empresa De")			,"","","mv_ch2","C",04,0,0,"G","","BG9","","","mv_par02","","","","","","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"03",OemToAnsi("Empresa Ate")		,"","","mv_ch3","C",04,0,0,"G","","BG9","","","mv_par03","","","","","","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"04",OemToAnsi("Matrํcula De")		,"","","mv_ch4","C",06,0,0,"G","","","","","mv_par04","","","","","","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"05",OemToAnsi("Matrํcula Ate")		,"","","mv_ch5","C",06,0,0,"G","","","","","mv_par05","","","","","","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"06",OemToAnsi("A็ใo")					,"","","mv_ch6","C",01,0,1,"C","","","","","mv_par06","Analisar","","","","Anl./Encerra","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"07",OemToAnsi("Data Base")			,"","","mv_ch7","D",08,0,0,"G","","","","","mv_par07","","","","","","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"08",OemToAnsi("Som.Dt.Sugerida?")	,"","","mv_ch8","C",01,0,1,"C","","","","","mv_par08","Nใo","","","","Sim","","","","","","","","","","","",{},{},{})

Pergunte(cPerg,.T.) 

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณProcRCB   บAutor  ณMicrosiga           บ Data ณ  08/13/08   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function ProcRCB(_nTotRCB,_aVetRCB,cMatricUsr)
Local _nCt1 := 0
Local _uVar := {}
Local _aArBD5 := BD5->(GetArea())

_nTotRCB := Len(_aVetRCB)

ProcRegua(_nTotRCB)

If _nTotRCB > 0		
	
	For _nCt1 := 1 to _nTotRCB	                                              
	                              	
	 	BD5->(DbGoTo(_aVetRCB[_nCt1]))
	 	RecLock("BD5",.F.)        
	 	
		_uVar := PLSUSRINTE(cMatricUsr,BD5->BD5_DATPRO,BD5->BD5_HORPRO,.T.,.F.,"BD5")
		
		If BD5->(FieldPos("BD5_YGIINT")) > 0
			BD5->BD5_YRGANT := BD5->BD5_REGATE
			BD5->BD5_YGIINT := BD5->BD5_GUIINT
		Endif		
	                                          
		If Len(_uVar) > 0
			BD5->BD5_REGATE := iif(_uVar[1],"1","2")   		
			If BD5->BD5_REGATE == "1"
				BD5->BD5_GUIINT := _uVar[2]+_uVar[3]+_uVar[4]+_uVar[5]
			Endif
		Else
			BD5->BD5_REGATE := "2" 
			BD5->BD5_GUIINT := ""
		Endif
		   
		MsUnlock()
		
		IncProc("Revalorizando: "+StrZero(_nCt1,6)+" de "+StrZero(_nTotRCB,6))	
		PLSA500RCB("BD5",_aVetRCB[_nCt1],Nil,Nil,.F.)		
		
	Next				
	
Endif

RestArea(_aArBD5)

Return Nil