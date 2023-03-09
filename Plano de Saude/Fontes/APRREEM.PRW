#INCLUDE "rwmake.ch"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "topconn.ch"
#INCLUDE "FONT.CH"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณAPRREEM   บ Autor ณ Jean Schulz        บ Data ณ  18/05/07   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Aprovacao de titulos de reembolso.                         บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ MP8                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/

user function APRREEM()

private cPerg   := "APRREE"
private cTitulo := "Aprova็ใo de reembolso"
private cLibera := GetNewPar("MV_YAPRREE","000051,000583,000024,000433,000367")

begin sequence
	// Testa se usuario esta habilitado a acessar esta rotina.
	// 000051 - judy
	// 000583 - sonia.bandeira
	// 000024 - carlos
	// 000433 - eloiza.couto
	// 000367 - betyc
	// em 14/12/2012 por OSP
	if !( __cUserID $ AllTrim(cLibera) )
	   MsgAlert("Acesso permitido somente aos usuarios habilitados a executar esta rotina!"+CHR(13)+CHR(13)+;
	            "SOLUCAO: Incluir ID do usuario no parametro MV_YAPRREE."+CHR(13)+CHR(13)+;
	            "Verifique com sua gerencia.", "AVISO" )
	   break
	endif

	ParSX1()
	if !Pergunte(cPerg,.T.) ; break ; endif
	MsAguarde({|| Aprova() }, cTitulo, "", .T.)
end sequence

return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณAprova    บAutor  ณMicrosiga           บ Data ณ  18/05/07   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณGera tela de aprovacao.                                     บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function Aprova()

oDlg := Nil

Define FONT oFont1 	NAME "Arial" SIZE 0,20 OF oDlg Bold
Define FONT oFont2 	NAME "Arial" SIZE 0,15 OF oDlg Bold

Private oCond
Private oVlTotTit
Private oValParc
Private o_DataNeg
Private oSay
Private oDlg				// Dialog Principal
Private oLBx1
Private oLBx2
Private oOk          	 := LoadBitmap( GetResources(), "LBOK" )
Private oNo       		 := LoadBitmap( GetResources(), "LBNO" )

Private aListBox1   := {}
Private aListBox2 	:= {}

Private aVetRee		:= {}

Private aAdvSize	:= {}
Private aObjects	:= {}
Private aInfo
Private aPosObj		:= {}
Private a_Vetor		:= {}

Private a_VetParc   := {}
Private c_CLiente    := ""
Private c_Loja		 := ""
Private n_SomaValJM  			:= 0    // Somat๓rio do valor da Parcela + Juro + Multa
Private c_Cond	     := Space(25)
Private c_say
Private n_VlTotTit	 := 0
Private n_ValParc	 := 0
Private d_DataNeg  := CtoD("  /  /  ")

Private lMark     := .F.
Private lMark2    := .F.

Private dDatIni := mv_par01
Private dDatFin := mv_par02
Private nTipDat := mv_par03 //1-Digitacao,2=Vencimento
Private nTipRee := mv_par04
Private _cEmpAPR := ""

_cEmpAPR := iif(Substr(cNumEmp,1,2)=="01","C","I")

cSQL := " SELECT B44_SENHA, B44_YCDPTC, B44_OPEUSR, B44_CODEMP, B44_MATRIC, B44_TIPREG, B44_DIGITO, BA1_NOMUSR, B44_DTDIGI, B44_DATPAG, B44_VLRPAG,"
cSQL +=		   " B44_PREFIX||B44_NUM||B44_PARCEL||B44_TIPO AS B44_CHVSE1,"
cSQL +=		   " RETORNA_PLANO_USU_MS('"+_cEmpAPR+"', B44_OPEUSR, B44_CODEMP, B44_MATRIC, B44_TIPREG,'C') AS CODPLANO"
cSQL += " FROM " + RetSQLName("B44") + " B44"
cSQL +=	  " INNER JOIN " + RetSQLName("BA1") + " BA1"
cSQL +=		" ON (    BA1_FILIAL = B44_FILIAL"
cSQL +=			" AND BA1_CODINT = B44_OPEUSR"
cSQL +=			" AND BA1_CODEMP = B44_CODEMP"
cSQL +=			" AND BA1_MATRIC = B44_MATRIC"
cSQL +=			" AND BA1_TIPREG = B44_TIPREG"
cSQL +=			" AND BA1_DIGITO = B44_DIGITO)"
cSQL += " WHERE B44.D_E_L_E_T_ = ' ' AND BA1.D_E_L_E_T_ =  ' '" 
cSQL +=	  " AND B44_FILIAL = '" + xFilial("B44") + "'"
cSQL +=	  " AND B44_YSITUA <= '1'"

if nTipDat == 1
	cSQL += " AND B44_DTDIGI BETWEEN '" + DtoS(dDatIni) + "' AND '" + DtoS(dDatFin) + "'"
else
	cSQL += " AND B44_DATPAG BETWEEN '" + DtoS(dDatIni) + "' AND '" + DtoS(dDatFin) + "'"
endif

cSQL += " AND " + iif(nTipRee == 1,"","NOT") + " EXISTS (SELECT ZZQ_FILIAL"
cSQL +=												   " FROM " + RetSQLName("ZZQ") + " ZZQ"
cSQL +=												   " WHERE ZZQ.D_E_L_E_T_ = ' '"
cSQL +=													 " AND ZZQ_FILIAL = B44_FILIAL"
cSQL +=													 " AND ZZQ_SEQUEN = B44_YCDPTC"
cSQL +=													 " AND ZZQ_TPSOL  = '1'"
cSQL +=													 " AND ZZQ_TIPPRO = '4')"

//cSQL +=" AND B44_ZZZCOD "+Iif(nTipRee == 1," "," NOT ")+" IN "+FormatIn(GetNewPar("MV_YTPAFUN","14"),",")

cSQL +=" ORDER BY CODPLANO, B44_YCDPTC "

PlsQuery(cSQL ,"TRB")

MemoWrite("C:\MICROSIGA\APRREEM.TXT",cSQL)

While !TRB->(Eof())
	aAdd(aVetRee,{ lMark , lMark2, TRB->B44_SENHA, TRB->(B44_OPEUSR+B44_CODEMP+B44_MATRIC+B44_TIPREG+B44_DIGITO),TRB->BA1_NOMUSR,TRB->B44_DTDIGI,TRB->B44_DATPAG,TRB->B44_VLRPAG,TRB->B44_CHVSE1, TRB->B44_YCDPTC  })
	TRB->(DbSkip())
Enddo

If select("TRB") > 0
	dbselectarea("TRB")
	dbclosearea()
EndIf

If len(aVetRee)  = 0
	Alert("Nenhum reembolso encontrado para os parโmetros informados!")
	Return
Endif
// Mateus - 29/05/2018
/*AAdd( aObjects, { 100, 010 , .T., .F. } )
AAdd( aObjects, { 100, 100 , .T., .F. } )

aInfo := { aSize[ 1 ], aSize[ 2 ], aSize[ 3 ], aSize[ 4 ], 3, 3 }
aPosObj := MsObjSize( aInfo, aObjects )*/

// MONTA AS DIMENSOES DOS OBJETOS
aAdvSize		:= MsAdvSize()
aInfo	:= { aAdvSize[1] , aAdvSize[2] , aAdvSize[3] , aAdvSize[4] , 10 , 5 }
aAdd( aObjects , { 000 , 035 , .T. , .F. } )
aAdd( aObjects , { 000 , 000 , .T. , .T. } )
aAdd( aObjects , { 000 , 020 , .T. , .F. } )
aAdd( aObjects , { 000 , 025 , .T. , .F. } )
aPosObj		:= MsObjSize( aInfo , aObjects )

DEFINE MSDIALOG oDlg TITLE OemToAnsi("Selecione os reembolsos a serem aprovados" ) FROM aAdvSize[7],0 TO aAdvSize[6],aAdvSize[5] OF oMainWnd PIXEL	//"Consulta Lancamentos"

@ aPosObj[1][2]+7,aPosObj[1][1]+2 Say "Reembolsos em Aguardo" Size 150,010 FONT oFont1 COLOR CLR_HBLUE PIXEL OF oDlg
//@ 030,007 LISTBOX oLbx1 FIELDS HEADER "A","N","Cd. Protoc.","Senha Reem.","Matric.Usr.","Nome Usr.","Dt.Dig.","Dt.Vencto.","Vlr.Reemb. ","Chave Titulo" SIZE 490  , 240 OF oDlg ;
@ aPosObj[1][2]+20,aPosObj[1][1]+2 LISTBOX oLbx1 FIELDS HEADER "A","N","Cd. Protoc.","Senha Reem.","Matric.Usr.","Nome Usr.","Dt.Dig.","Dt.Vencto.","Vlr.Reemb. ","Chave Titulo" SIZE aPosObj[4][4],( aPosObj[4][3] )-50 OF oDlg ;
PIXEL ON dblClick(AprovRee(oLbx1,oLbx1:nAt),oLbx1:Refresh())

@ ( aPosObj[4][3] )+100,aPosObj[1][1]+2 Say "[Enter/F4]: Aprova / [F5]:Nใo Aprova / [F11]: Aprova(Todos) / [F12]: Nใo Aprova(Todos)" Size 300,010 FONT oFont2 COLOR CLR_HBLUE PIXEL OF oDlg

oLbx1:SetArray(aVetRee)
oLbx1:bLine:={|| {Iif(aVetRee[oLbx1:nAt,1],oOk,oNo),Iif(aVetRee[oLbx1:nAt,2],oOk,oNo),aVetRee[oLbx1:nAt,10], aVetRee[oLbx1:nAt,3],aVetRee[oLbx1:nAt,4],aVetRee[oLbx1:nAt,5],aVetRee[oLbx1:nAt,6],aVetRee[oLbx1:nAt,7],Trim(Transform(aVetRee[oLbx1:nAt,8],"@E 999,999,999.99")),aVetRee[oLbx1:nAt,9]}}

SetKey(VK_F4 ,{||AprovRee(oLbx1,oLbx1:nAt)})
SetKey(VK_F5 ,{||CancRee(oLbx1,oLbx1:nAt)})
SetKey(VK_F11 ,{||Processa( {|| AprovaTudo(oLbx1) }, "Atualizando, aguarde...","",.T.)})
SetKey(VK_F12 ,{||Processa( {|| NegaTudo(oLbx1) }, "Atualizando, aguarde...","",.T.)})

//@ 280,325 Button "Efetiva A็๕es" 	 Size 050,012 Action Processa( {|| Efetiva(aVetRee) }, "Atualiza status do reembolso","",.T.) PIXEL OF oDlg
@ ( aPosObj[4][3] )-15,aPosObj[4][4]-50 Button "Efetiva A็๕es" 	 Size 050,012 Action Processa( {|| Efetiva(aVetRee) }, "Atualiza status do reembolso","",.T.) PIXEL OF oDlg

ACTIVATE MSDIALOG oDlg CENTERED ON INIT EnchoiceBar(oDlg,{||oDlg:End()},{||oDlg:End()})

Return Nil


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณAprovRee  บAutor  ณ Jean Schulz        บ Data ณ  18/05/07   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function AprovRee(oObj,nPos)
LOCAL nCnt

oObj:aArray[nPos,1]	 := !oObj:aArray[nPos,1]
If oObj:aArray[nPos,2] .And. oObj:aArray[nPos,1]
	oObj:aArray[nPos,2] := .F.
Endif

oObj:Refresh()

Return(.T.)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCancRee   บAutor  ณJean Schulz         บ Data ณ  18/05/07   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function CancRee(oObj,nPos)
LOCAL nCnt

oObj:aArray[nPos,2]	 := !oObj:aArray[nPos,2]
If oObj:aArray[nPos,2] .And. oObj:aArray[nPos,1]
	oObj:aArray[nPos,1] := .F.
Endif

oObj:Refresh()

Return(.T.)


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณAprovaTudoบAutor  ณJean Schulz         บ Data ณ  18/05/07   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function AprovaTudo(oObj)
LOCAL nCnt := 0
Local nTotal := Len(oObj:aArray)

ProcRegua( nTotal )

For nCnt := 1 to Len(oObj:aArray)
	IncProc("Atualizando: "+StrZero(nCnt,4))
	AprovRee(oObj,nCnt)
Next

oObj:Refresh()

Return(.T.)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNegaTudo  บAutor  ณJean Schulz         บ Data ณ  18/05/07   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function NegaTudo(oObj)
LOCAL nCnt := 0
Local nTotal := Len(oObj:aArray)

ProcRegua( nTotal )

For nCnt := 1 to Len(oObj:aArray)
	IncProc("Atualizando: "+StrZero(nCnt,4))
	CancRee(oObj,nCnt)
Next

oObj:Refresh()

Return(.T.)



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณEfetiva   บAutor  ณMicrosiga           บ Data ณ  18/05/07   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function Efetiva(aArray)
Local nCont		:= 0
Local aAreaB44	:= B44->(GetArea())
Local nTotal	:= Len(aArray)
Local nTotApr	:= 0
Local nTotNeg	:= 0

Local _cPref	:= ""
Local _cNum		:= ""
Local _cParc	:= ""
Local _cTipo	:= ""

B44->(DbSetOrder(3))

Begin Transaction

ProcRegua( nTotal )

For nCont := 1 To Len(aArray)

	IncProc("Atualizando Status do Reembolso: "+StrZero(nCont,4))

	If aArray[nCont,1]

		//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
		//ณ Aprova o reembolso digitado, e mantem o titulo no SE1.            	  ณ
		//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
		If B44->(MsSeek(xFilial("B44")+aArray[nCont,9]))
			B44->(RecLock("B44",.F.))
			B44->B44_YSITUA := "2"
			B44->(MsUnlock())
			nTotApr++
		Endif
	Else
		//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
		//ณ Nega o reembolso, e baixa por cancelamento o titulo emitido em SE1.   ณ
		//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
		If aArray[nCont,2]
			If B44->(MsSeek(xFilial("B44")+aArray[nCont,9]))
				B44->(RecLock("B44",.F.))
				B44->B44_YSITUA := "3"
				B44->(MsUnlock())
				nTotNeg++

				BaixaTitulo("CAN",B44->B44_PREFIX,B44->B44_NUM,B44->B44_PARCEL,B44->B44_TIPO)

			Endif
		Endif
	Endif

Next

End Transaction

MsgAlert("Total Processado: "+StrZero(nTotal,4)+" Total Aprovado: "+StrZero(nTotApr,4)+" Total Negado: "+StrZero(nTotNeg,4))

RestArea(aAreaB44)

Close(oDlg)

Return Nil


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออออออหอออออออัออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ ParSX1       บAutor  ณJean Schulz     บ Data ณ  18/05/07   บฑฑ
ฑฑฬออออออออออุออออออออออออออสอออออออฯออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณCria parametros para rotina.                                บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function ParSX1()

PutSx1(cPerg,"01",OemToAnsi("Data Reemb. Inicial") 			,"","","mv_ch1","D",08,0,0,"G","","","","","mv_par01","","","","","","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"02",OemToAnsi("Data Reemb. Final") 			,"","","mv_ch2","D",08,0,0,"G","","","","","mv_par02","","","","","","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"03",OemToAnsi("Considerar Data")				,"","","mv_ch3","C",01,0,1,"C","","","","","mv_par03","Digita็ใo","","","","Vencimento","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"04",OemToAnsi("Tipo do Reembolso")			,"","","mv_ch4","C",01,0,1,"C","","","","","mv_par04","Aux. Funeral","","","","Demais Reemb.","","","","","","","","","","","",{},{},{})

Return


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัอออออออออออหอออออออัอออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFuncao    ณBaixaTituloบ Autor ณ Jean Schulz       บ Data ณ  31/05/07   บฑฑ
ฑฑฬออออออออออุอออออออออออสอออออออฯอออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescrio ณ Baixa de titulo financeiro, conforme parametros...         บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ                                                            บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
Static Function BaixaTitulo(cMotBx,cPrefixo,cNumero,cParcela,cTipo)
Local lRet := .F.
Local dDtBaixa := CtoD("")
Local cHisBaixa := "CANC.AUT.NEG.REEMB."
Local nVlrBaixa := 0

Private lmsErroAuto := .f.
Private lmsHelpAuto := .t. // para mostrar os erros na tela

If SE1->(MsSeek(xFilial("SE1")+cPrefixo+cNumero+cParcela+cTipo))

	If SE1->E1_SALDO > 0

		dDtBaixa := dDataBase
		nVlrBaixa := SE1->E1_SALDO

		aCamposSE5 := {}
		aAdd(aCamposSE5, {"E1_FILIAL"	, xFilial("SE1") 	, Nil})
		aAdd(aCamposSE5, {"E1_PREFIXO"	, cPrefixo			, Nil})
		aAdd(aCamposSE5, {"E1_NUM"		, cNumero			, Nil})
		aAdd(aCamposSE5, {"E1_PARCELA"	, cParcela			, Nil})
		aAdd(aCamposSE5, {"E1_TIPO"		, cTipo				, Nil})
		aAdd(aCamposSE5, {"AUTMOTBX"	, cMotBx			, Nil})
		aAdd(aCamposSE5, {"AUTDTBAIXA"	, dDtBaixa			, Nil})
		//aAdd(aCamposSE5, {"AUTDTCREDITO" , dDtBaixa	     , Nil})
		aAdd(aCamposSE5, {"AUTHIST"		, cHisBaixa			, Nil})
		aAdd(aCamposSE5, {"AUTVALREC"	, nVlrBaixa			, Nil})

		msExecAuto({|x,y| Fina070(x,y)}, aCamposSE5, 3)
		If lmsErroAuto
			// Se ocorreu algum erro
			lRet := .f.
			MostraErro()
		Else
			lRet := .t.
		EndIf

	Endif

Endif

Return lRet
