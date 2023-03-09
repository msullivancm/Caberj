#INCLUDE "rwmake.ch"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "topconn.ch"
#INCLUDE "FONT.CH"
#include "PLSMGER.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณPL500F12  บAutor  ณ Jean Schulz        บ Data ณ  04/08/07   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณChamada de analise de glosas...                             บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Caberj.                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/                    
User Function PL500F12
Local aRet := {nil,nil,"Rotina de glosas Caberj",nil,nil}
Local cTipo		:= paramixb[1]
Local cAlias	:= paramixb[2]
Local nReg		:= paramixb[3]
Local nOpc		:= paramixb[4]
Private cTitulo := "Anแlise de contas m้dicas - Caberj"

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ //Executar rotina somente caso seja tipo 2 = dentro do PEG...		  ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู	 			
If cTipo == "2"
	MsAguarde({|| AbreItens(cAlias,nReg) }, cTitulo, "", .T.)
	
Endif

Return aRet    

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณAbreItens บ Autor ณ Jean Schulz        บ Data ณ  04/08/07   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Rotina de envio para conferencia personalizada.            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ MP8                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
Static Function AbreItens(cAlias,nReg)

Local aArFas35	
Local cQryLibPag 
Local cAlFas35
Local lOkFas35	:= .T.
Local cChave	:= &(cAlias + "->(" + cAlias + "_CODOPE+" + cAlias + "_CODLDP+" + cAlias + "_CODPEG)")

o_DLG := Nil

Define FONT oFont1 	NAME "Arial" SIZE 0,20 OF o_Dlg Bold
Define FONT oFont2 	NAME "Arial" SIZE 0,15 OF o_Dlg Bold

Private oCond
Private oVlTotTit
Private oValParc
Private o_DataNeg
Private oSay
Private o_Dlg				// Dialog Principal
Private oLBx1
Private oLBx2
Private oOk          	 := LoadBitmap( GetResources(), "LBOK" )
Private oNo       		 := LoadBitmap( GetResources(), "LBNO" )

Private aListBox1   := {}
Private aListBox2 	:= {}

Private aVetGlo		:= {}

Private aSize		:= MsAdvSize()
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

Private _nTipGlo 	:= 0
Private _nVlrPag	:= 0
Private _cTipGlo 	:= ""
Private _nVlrApr	:= 0

Private lMark     := .F.

Private _cCodLDP	:= cAlias+"->"+cAlias+"_CODLDP"
Private _cCodPEG	:= cAlias+"->"+cAlias+"_CODPEG"
Private _cNumero	:= cAlias+"->"+cAlias+"_NUMERO"

//Private cCondOk := cAlias+"->"+cAlias+"_SITUAC $ '1,3' .And. "+cAlias+"->"+cAlias+"_FASE == '3' .And. Empty("+cAlias+"->"+cAlias+"_NUMSE1) " 
Private cCondOk := cAlias+"->"+cAlias+"_SITUAC $ '1,3' .And. "+cAlias+"->"+cAlias+"_FASE == '3' .And. Empty("+cAlias+"->"+cAlias+"_PREFIX  +  "+cAlias+"->"+cAlias+"_NUMTIT  +"+cAlias+"->"+cAlias+"_PARCEL  +"+cAlias+"->"+cAlias+"_TIPTIT ) "
Private cStatusTiss := ALLTRIM(POSICIONE( "BCI", 1, xFilial("BCI")+cChave, "BCI_STTISS" ))         

If !(&cCondOk) .OR. cStatusTiss $ '3|4|6'
	Alert("Guia nใo pode ser modificada. Verifique a fase, situa็ใo ou se a mesma jแ foi paga ou cobrada!")
	Return
	
//Leonardo Portella - 12/02/16 - Inicio - Nใo permitir que guias jแ conferidas na fase 3.5 sejam alvo desta rotina de glosas
	
Else

	aArFas35	:= GetArea()
	cQryLibPag 	:= ""
	cAlFas35 	:= GetNextAlias()
	
	cQryLibPag 	:= "SELECT 1" 											+ CRLF
	cQryLibPag 	+= "FROM " + RetSqlName("BD7") + " BD7" 				+ CRLF
	cQryLibPag 	+= "INNER JOIN "+RetSqlName('BCI')+ " BCI ON (BCI.D_E_L_E_T_ = ' ' AND BCI_CODPEG = BD7_CODPEG)  " + CRLF
	cQryLibPag 	+=" WHERE BD7_FILIAL = '" + xFilial("BD7") + "'" 		+ CRLF
	cQryLibPag	+= "  AND BD7_CODOPE = '" + PLSINTPAD() + "'" 			+ CRLF
	cQryLibPag 	+= "  AND BD7_CODLDP = '" + &_cCodLDP + "'" 			+ CRLF
	cQryLibPag 	+= "  AND BD7_CODPEG = '" + &_cCodPEG + "'" 			+ CRLF
	cQryLibPag 	+= "  AND BD7_NUMERO = '" + &_cNumero + "'" 			+ CRLF
	cQryLibPag 	+= "  AND ( BCI_STTISS = '3' OR BD7_LOTBLO <> ' ' )"	+ CRLF
	cQryLibPag 	+= "  AND BD7.D_E_L_E_T_ =  ' '" 						+ CRLF
	cQryLibPag 	+= "  AND ROWNUM = 1" 									+ CRLF
	
	TcQuery cQryLibPag New Alias cAlFas35
	
	lOkFas35 := cAlFas35->(EOF())
	
	cAlFas35->(DbCloseArea())
	
	RestArea(aArFas35)
	
	If !lOkFas35
	
		MsgStop("Guia encontra-se liberada para pagamento e nใo poderแ ser alterada!",AllTrim(SM0->M0_NOMECOM))
		Return
		
	EndIf  

//Leonardo Portella - 12/02/16 - Fim 
		
Endif

cSQL :=" SELECT * FROM " 
cSQL += RetSQLName("BD6")+" BD6 "
cSQL +=" WHERE BD6_FILIAL = '"+xFilial("BD6")+"' "
cSQL += " AND BD6_CODOPE = '"+PLSINTPAD()+"' "
cSQL += " AND BD6_CODLDP = '"+&_cCodLDP+"' "
cSQL += " AND BD6_CODPEG = '"+&_cCodPEG+"' "
cSQL += " AND BD6_NUMERO = '"+&_cNumero+"' "
cSQL += " AND BD6.D_E_L_E_T_ =  ' ' "

PlsQuery(cSQL ,"TRB")
BD7->(DbSetOrder(1))
While !TRB->(Eof())
	_nVlrApr := TRB->(BD6_VLRAPR*BD6_QTDPRO)
	
	If _nVlrApr == 0
		BD7->(MsSeek(xFilial("BD7")+TRB->(BD6_CODOPE+BD6_CODLDP+BD6_CODPEG+BD6_NUMERO+BD6_ORIMOV+BD6_SEQUEN)))
		While !BD7->(Eof()) .And. TRB->(BD6_CODOPE+BD6_CODLDP+BD6_CODPEG+BD6_NUMERO+BD6_ORIMOV+BD6_SEQUEN)== BD7->(BD7_CODOPE+BD7_CODLDP+BD7_CODPEG+BD7_NUMERO+BD7_ORIMOV+BD7_SEQUEN)
			If BD7->BD7_BLOPAG <> '1'
				_nVlrApr += BD7->BD7_VLRAPR
			Endif
			BD7->(DbSkip())
		Enddo
		_nVlrApr := _nVlrApr*TRB->BD6_QTDPRO	
	Endif

	//Se ainda for valor zerado, utilizar valor PAGO para glosa...	
	If _nVlrApr == 0
		//_nVlrApr := TRB->BD6_VLRBPR
		_nVlrApr := TRB->BD6_VLRPAG
	Endif
	
	aAdd(aVetGlo,{ lMark , TRB->BD6_SITUAC,TRB->BD6_FASE,TRB->BD6_CODPRO,TRB->BD6_DESPRO,TRB->BD6_SEQUEN,TRB->BD6_QTDPRO,_nVlrApr,TRB->BD6_VLRPAG,TRB->BD6_VLRTPF, 0,"",TRB->BD6_CODPAD,TRB->BD6_VLRBPR,"0",TRB->BD6_TIPGUI,TRB->BD6_DATPRO,0})	
	TRB->(DbSkip())
Enddo

If len(aVetGlo)  = 0
	Alert("Nใo existem itens para a guia selecionada!")
	Return
Endif

AAdd( aObjects, { 100, 010 , .T., .F. } )
AAdd( aObjects, { 100, 100 , .T., .F. } )

aInfo := { aSize[ 1 ], aSize[ 2 ], aSize[ 3 ], aSize[ 4 ], 3, 3 }
aPosObj := MsObjSize( aInfo, aObjects )

DEFINE MSDIALOG O_DLG TITLE "Selecione os itens a serem glosados/reconsiderados..." FROM aSize[7],0 to aSize[6]+30,aSize[5]*.8 PIXEL

@ 017,007 Say "Itens da guia - CodLDP: "+&_cCodLDP+" CodPEG: "+&_cCodPEG+" Numero: "+&_cNumero Size 450,010 FONT oFont1 COLOR CLR_HBLUE PIXEL OF o_Dlg
@ 030,007 LISTBOX oLbx1 FIELDS HEADER " ",;
                                      "Sit.",;
                                      "Fase",;
                                      "C๓d.Proc.",;
                                      "Descr.Proc.",;
                                      "Sequen.",;
                                      "Qtd.Pro",;
                                      "Vlr.Apr.Tot.",;
                                      "Vlr.Pago. ";
                                      ,"Vlr.Tot.PF",;
                                      "Vlr.Acerto",;
                                      "Mot.Glosa",;
                                      "Vlr.Ctr." SIZE aInfo[3]*.75 + 22, aInfo[4]*.8 OF o_Dlg ;
PIXEL ON dblClick(EditaVlr(oLbx1,oLbx1:nAt),oLbx1:Refresh())

@ aInfo[4]*.95,007 Say "[Enter/F4]: Envia para confer๊ncia [F5]: Cancela Edi็ใo" Size 200,010 FONT oFont2 COLOR CLR_HBLUE PIXEL OF o_Dlg

oLbx1:SetArray(aVetGlo)
//aAdd(aVetGlo,{ lMark,;
//TRB->BD6_SITUAC,;
//TRB->BD6_FASE,;
//TRB->BD6_CODPRO,;
//TRB->BD6_DESPRO,;
//TRB->BD6_SEQUEN,;
//TRB->BD6_QTDPRO,;
//_nVlrApr,;
//TRB->BD6_VLRPAG,;
//TRB->BD6_VLRTPF,;
// 0,;
//"",;
//TRB->BD6_CODPAD,;
//TRB->BD6_VLRBPR,;
//"0",;
//TRB->BD6_TIPGUI,;
//TRB->BD6_DATPRO,
//0})	

oLbx1:bLine:={|| {Iif(	aVetGlo[oLbx1:nAt,1],oOk,oNo),; //Ativo/Desligado
						aVetGlo[oLbx1:nAt,2],;//TRB->BD6_SITUAC
						aVetGlo[oLbx1:nAt,3],;//TRB->BD6_FASE
						aVetGlo[oLbx1:nAt,4],;//TRB->BD6_CODPRO
						aVetGlo[oLbx1:nAt,5],;//TRB->BD6_DESPRO
						aVetGlo[oLbx1:nAt,6],;//TRB->BD6_SEQUEN
						Trim(Transform(aVetGlo[oLbx1:nAt,7],"@E 999,999,999.99")),;//TRB->BD6_QTDPRO,;
						Trim(Transform(aVetGlo[oLbx1:nAt,8],"@E 999,999,999.99")),;//_nVlrApr,;
						Trim(Transform(aVetGlo[oLbx1:nAt,9],"@E 999,999,999.99")),;//TRB->BD6_VLRPAG,;
						Trim(Transform(aVetGlo[oLbx1:nAt,10],"@E 999,999,999.99")),;//TRB->BD6_VLRTPF,;
						Trim(Transform(aVetGlo[oLbx1:nAt,11],"@E 999,999,999.99")),;// VLR. ACERTO
						aVetGlo[oLbx1:nAt,12],;//MOTIVO DA GLOSA,;
						Trim(Transform(aVetGlo[oLbx1:nAt,14],"@E 999,999,999.99"))}}
						

SetKey(VK_F4 ,{||EditaVlr(oLbx1,oLbx1:nAt)})
SetKey(VK_F5 ,{||CancEdt(oLbx1,oLbx1:nAt)})

//@ aInfo[4]*.96,aInfo[4]*.98 Button "Efetiva A็๕es" Size 050,012 Action Processa( {|| Efetiva(aVetGlo,cAlias) }, "Efetiva altera็๕es na guia.","",.T.) PIXEL OF o_Dlg
@ aInfo[4]*.92,aInfo[4]*.98 Button "Efetiva A็๕es" Size 100,020 Action Processa( {|| Efetiva(aVetGlo,cAlias) }, "Efetiva altera็๕es na guia.","",.T.) PIXEL OF o_Dlg

ACTIVATE MSDIALOG O_DLG CENTERED ON INIT EnchoiceBar(o_Dlg,{||o_Dlg:End()},{||o_Dlg:End()})

TRB->(DbCloseArea())

SetKey( VK_F4,Nil )
SetKey( VK_F5,Nil )

Return Nil

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณEditaVlr  บAutor  ณ Jean Schulz        บ Data ณ  18/05/07   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function EditaVlr(oObj,nPos)
LOCAL nCnt

ExibeEdt(oObj,nPos,BD6->BD6_VLRPAG)

Return(.T.)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCancEdt   บAutor  ณ Jean Schulz        บ Data ณ  18/05/07   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function CancEdt(oObj,nPos)
LOCAL nCnt
                           
oObj:aArray[nPos,1]	 := .F.
oObj:aArray[nPos,11]	 := 0
oObj:aArray[nPos,12]	 := ""
oObj:Refresh()

Return(.T.)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณExibeEdt  บAutor  ณ Jean Schulz        บ Data ณ  17/10/06   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณTela para edicao de valores pagos na guia...                บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function ExibeEdt(oObj,nPos,_nVlrPag)
Private _cPerg := "YGLOSA"

CriaSX1()
If !Pergunte( _cPerg, .T. )
	oObj:aArray[nPos,1]	 := .F.
	oObj:Refresh()
	Return
Endif


_nTipGlo := mv_par01
_nVlrPag := mv_par02
_cTipGlo := mv_par03

oObj:aArray[nPos,1]	 := .T.
oObj:Refresh()

MudaVlrPag(oObj, nPos, _nTipGlo,_nVlrPag,_cTipGlo)


Return

                    

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCriaSX1   บAutor  ณJean Schulz         บ Data ณ  06/08/07   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณCria parametros para analise de glosas CABERJ.              บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function CriaSX1()

PutSx1(_cPerg,"01","Glosa/Reconsidera?"		,"","","mv_ch1","C",01,0,0,"C","",""		,"","","mv_par01","Glosa"	,"","","","Reconsidera"	,"","","","","","","","","","","",{},{},{})
PutSx1(_cPerg,"02","Valor de pagamento?"	,"","","mv_ch2","N",17,2,0,"G","",""		,"","","mv_par02",""		,"","","",""			,"","","","","","","","","","","",{},{},{})
PutSx1(_cPerg,"03","Motivo de glosa?"		,"","","mv_ch3","C",03,0,0,"C","","BCTPLS"	,"","","mv_par03",""		,"","","",""			,"","","","","","","","","","","",{},{},{})
	
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณMudaVlrPagบAutor  ณMicrosiga           บ Data ณ  08/04/07   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function MudaVlrPag(oObj, nPos, nTipGlo,nVlrPag,cTipGlo)

/*
Leonardo Portella - 19/03/15 - Inicio - Por solicitacao da Superintendencia a opcao  
Reconsiderar nao sera mais utilizada e a opcao Glosar deve glosar o valor que o analista  
colocar, ao inves de glosar tudo conforme era feito antes.
 
nVlrPag := Iif(nTipGlo == 1,0,nVlrPag)

Leonardo Portella - 19/03/15 - Fim
*/

oObj:aArray[nPos,11]	 := nVlrPag
oObj:aArray[nPos,12]	 := cTipGlo
oObj:aArray[nPos,15]	 := StrZero(nTipGlo,1)

Return Nil

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณFechaPrin บAutor  ณ Jean Schulz        บ Data ณ  19/10/06   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณFecha tela principal, sem gerar adicional...                บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function FechaEdt(oObj,nPos)

Close(_oDialog)          

Return Nil


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณEfetiva   บAutor  ณ Jean Schulz        บ Data ณ  06/08/07   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณConsiste avaliacoes do usuario e aplica alteracoes, caso    บฑฑ
ฑฑบ          ณtodas ok.                                                   บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function Efetiva(aArray,_cAlias)
Local aVetCri		:= {}
Local aOk			:= {}
Local nVlrGlo		:= 0
Local cChBDX		:= ""
Local _cTipGui		:= ""
Local nRegVet
Local _aRecBDX		:= {}
Local _nQtdBDX		:= 0
Local _aItensGlo	:= {}
Local _aPar			:= {}
Local lHouveCri		:= .F.
Local _cMsgGloCB := "Bloq. em funcao de glosa pagto"    
Local aAreaBD6	:= BD6->(GetArea())
Local aAreaBD5	:= BD5->(GetArea())
Local nRecBD5
Local nCont	:= 0
Local c_CodRDA	:= &(_cAlias+"->"+_cAlias+"_CODRDA")

//BIANCHINI - 09/05/2019 - P12 - RETIRADO DO PLSA720 PARA COMPOR NOVA ESTRUTURA DE ARRAY
local lBDX_VLRGTX	:= BDX->( fieldPos("BDX_VLRGTX") ) > 0
local lBDX_VLTXPG 	:= BDX->( fieldPos("BDX_VLTXPG") ) > 0
local lGloAut		:= .f.

Local aRetDOP		:= {}

Private _cCodOpe	:= &(_cAlias+"->"+_cAlias+"_CODOPE")
Private _cCodLDP	:= &(_cAlias+"->"+_cAlias+"_CODLDP")
Private _cCodPeg	:= &(_cAlias+"->"+_cAlias+"_CODPEG")
Private _cNumero	:= &(_cAlias+"->"+_cAlias+"_NUMERO")
Private _cOriMov	:= &(_cAlias+"->"+_cAlias+"_ORIMOV")

BCT->(DbSetOrder(1))
BD6->(DbSetOrder(1))

For nCont := 1 To Len(aArray)
	If aArray[nCont,1]
		//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
		//ณ Criticar caso o valor apresentado seja maior que o valor de pago... ณ
		//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู	 					
		
		//Se pode reconsiderar o valor de ajuste pode ser maior que o valor pago.
		If ( mv_par01 <> 2 ) .and. ( aArray[nCont,11] > aArray[nCont,9] )
		//If aArray[nCont,11] > aArray[nCont,9]
			aadd(aVetCri,{aArray[nCont,4],aArray[nCont,6],"Valor da ajuste superior ao vlr. pago! Vlr. Pago: "+Transform(aArray[nCont,9],"@E 9,999,999.99")+" Vlr.Ajuste: "+Transform(aArray[nCont,11],"@E 9,999,999.99")})
			lHouveCri := .T.
		Endif
		
		//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
		//ณ Criticar caso o valor apresentado seja maior que o valor de ajuste... ณ
		//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู	 					
		If aArray[nCont,11] > aArray[nCont,8]
			aadd(aVetCri,{aArray[nCont,4],aArray[nCont,6],"Valor da ajuste superior ao vlr.apresentado! Vlr.Apr.: "+Transform(aArray[nCont,8],"@E 9,999,999.99")+" Vlr.Ajuste: "+Transform(aArray[nCont,11],"@E 9,999,999.99")})
			lHouveCri := .T.
		Endif
		
		//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
		//ณ Criticar caso o valor de ajuste seja menor que zero...                ณ
		//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู	 					
		If aArray[nCont,11] < 0
			aadd(aVetCri,{aArray[nCont,4],aArray[nCont,6],"Valor da ajuste inferior a zero! Vlr.Apr.: "+Transform(aArray[nCont,8],"@E 9,999,999.99")+" Vlr.Ajuste: "+Transform(aArray[nCont,11],"@E 9,999,999.99")})
			lHouveCri := .T.
		Endif		

		//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
		//ณ Criticar caso o tipo de glosa nao seja encontrado...                  ณ
		//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู	 							
		If ! BCT->(MsSeek(xFilial("BCT")+PLSINTPAD()+aArray[nCont,12]))
			aadd(aVetCri,{aArray[nCont,4],aArray[nCont,6],"Motivo de glosa inexistente: C๓digo: "+aArray[nCont,12]})
			lHouveCri := .T.			
		Endif

		//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
		//ณ Criticar caso o motivo de glosa esteja em branco...                   ณ
		//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู	 							
		If Empty(Alltrim(aArray[nCont,12]))
			aadd(aVetCri,{aArray[nCont,4],aArray[nCont,6],"Motivo de glosa em branco! "+aArray[nCont,12]})
			lHouveCri := .T.			
		Endif
		
		If !lHouveCri
			aadd(aOk,nCont)
		Endif
	
	Endif	
Next

If Len(aVetCri) > 0
	PLSCRIGEN(aVetCri,{ {"Cod.Proc","@C",30},{"Sequen.","@C",30},{"Inconsist๊ncia","@C",200}},"Procedimentos criticados...",.T.)
Else

	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ //Executar rotina somente caso seja tipo 2 = dentro do PEG...		  ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	BDX->(DbSetOrder(1))
	Begin Transaction
		                  
		For nCont := 1 to Len(aOk)
		    
			nRegVet := aOk[nCont]
			_cTipGui := aArray[nRegVet,16]
						
			//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
			//ณ Cria BDX.                                                    		  ณ
			//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
			
			//aAdd(aVetGlo,{ lMark , TRB->BD6_SITUAC,TRB->BD6_FASE,TRB->BD6_CODPRO,TRB->BD6_DESPRO,TRB->BD6_SEQUEN,TRB->BD6_QTDPRO,_nVlrApr,TRB->BD6_VLRPAG,TRB->BD6_VLRTPF, 0,"",TRB->BD6_CODPAD,TRB->BD6_VLRBPR,"0",TRB->BD6_TIPGUI,TRB->BD6_DATPRO,0})				
			
			//Leonardo Portella - 30/04/15 - Inicio - Erro array out of bounds no calculo do percentual (Patricia)
			
			nVlrGlo := aArray[nRegVet,8] - aArray[nRegVet,11]			
			
			If ( _nTipGlo == 1 )//Glosa
				nPerGlo := ( ( aArray[nRegVet,8] - nVlrGlo ) / aArray[nRegVet,8] ) * 100
				nPerGlo := NoRound(nPerGlo,2)
				nPerGlo := 100 - nPerGlo
			ElseIf ( _nTipGlo == 2 )//Reconsidera: Valor de glosa eh valor pago menos o valor a ser reconsiderado
				nVlrGlo := aArray[nRegVet,8] - aArray[nRegVet,11]
				nPerGlo := ( ( aArray[nRegVet,8] - nVlrGlo ) / aArray[nRegVet,8] ) * 100
				nPerGlo := NoRound(nPerGlo,2)
			EndIf
			
			//Leonardo Portella - 30/04/15 - Fim
			
			//BDX_FILIAL+BDX_CODOPE+BDX_CODLDP+BDX_CODPEG+BDX_NUMERO+BDX_ORIMOV+BDX_CODPAD+BDX_CODPRO+BDX_SEQUEN+BDX_CODGLO 
			cChBDX := _cCodOpe+_cCodLDP+_cCodPeg+_cNumero+_cOriMov+aArray[nRegVet,13]+aArray[nRegVet,04]+aArray[nRegVet,06]
			    BDX->(RecLock("BDX",.T.))
				BDX->BDX_FILIAL := xFilial("BDX")
				BDX->BDX_IMGSTA := "BR_VERMELHO"
				BDX->BDX_CODOPE := _cCodOpe
				BDX->BDX_CODLDP := _cCodLDP
				BDX->BDX_CODPEG := _cCodPeg
				BDX->BDX_NUMERO := _cNumero
				BDX->BDX_NIVEL  := "1"
				BDX->BDX_CODPAD := aArray[nRegVet,13]
				BDX->BDX_CODPRO := aArray[nRegVet,04]
				BDX->BDX_DESPRO := aArray[nRegVet,05]
				BDX->BDX_SEQUEN := aArray[nRegVet,06]
				BDX->BDX_CODGLO := aArray[nRegVet,12]
				BDX->BDX_GLOSIS := aArray[nRegVet,12]
				BDX->BDX_DESGLO := Posicione("BCT",1,xFilial("BCT")+PLSINTPAD()+AllTrim(aArray[nRegVet,12]),"BCT_DESCRI")
				BDX->BDX_INFGLO := ""
				BDX->BDX_TIPGLO := "1"           
				BDX->BDX_ORIMOV := _cOriMov
				BDX->BDX_PERGLO := nPerGlo//(aArray[nRegVet,09]*100)/aArray[nRegVet,08] //Leonardo Portella - 30/04/15
				BDX->BDX_VLRGLO := nVlrGlo
				BDX->BDX_RESPAL := ""
				BDX->BDX_TIPREG := "1"
				BDX->BDX_ACAO   := aArray[nRegVet,15]
				BDX->BDX_VLRPAG := aArray[nRegVet,11]
				BDX->BDX_VLRAPR := aArray[nRegVet,08]
				BDX->BDX_VLRMAN := aArray[nRegVet,14]
				BDX->BDX_VLRBPR := aArray[nRegVet,14]
			    BDX->( MsUnLock() )
/*
				aadd(_aItensGlo,{BDX->BDX_SEQUEN,;
								BDX->BDX_VLRPAG,;
								BDX->BDX_VLRGLO,;
								"0",;
								0,;
								BDX->BDX_VLRMAN,;						
								BDX->BDX_ACAO})			
*/
				//BIANCHINI - Mudan็a P12 - Aumento do Array
				lGloAut :=  BDX->BDX_TIPGLO == '3'
				aadd(_aItensGlo,{BDX->BDX_SEQUEN,;												//01
								BDX->BDX_VLRPAG,;	//BDX->BDX_VLRMAN - Valor Contratado(TDE)	//02
								BDX->BDX_VLRGLO,;												//03
								BDX->BDX_ACAOTX,;						 						//04
								iIf(lBDX_VLRGTX, BDX->BDX_VLRGTX, 0),; 							//05
								BDX->BDX_TIPGLO,;												//06
								iIf(empty(BDX->BDX_ACAO), BDX->BDX_GLACAO, BDX->BDX_ACAO),;		//07
								iIf(empty(BDX->BDX_ACAO), "2", "1"),;							//08 
								BDX->BDX_CODTPA,; 												//09
								BDX->BDX_QTDGLO,; 	   											//10
								BDX->BDX_TIPREG,;												//11
								BDX->BDX_CODGLO,;												//12
								BDX->BDX_VLRPAG,;												//13
								BDX->BDX_PERGLO,;												//14
								iIf(lBDX_VLTXPG,BDX->BDX_VLTXPG,0),;							//15							
								lGloAut})								

			If BDX->BDX_PERGLO < 100 .And. GetNewPar("MV_PLSGCGP","0") == "1" .And. aArray[nRegVet,15] <> "1"
				If BD6->(MsSeek(xFilial("BD6")+_cCodOpe+_cCodLDP+_cCodPEG+_cNumero+_cOriMov+aArray[nRegVet,06]))					
					If BD6->BD6_BLOCPA == "1"				        
							If MsgYesNo("Procedimento "+BD6->BD6_CODPRO+" com cobran็a bloqueada. Deseja liberar a cobran็a de co-participa็ใo?") 
								BD6->(RecLock("BD6",.F.))	
								BD6->BD6_BLOCPA := "0"
								BD6->BD6_DESBPF := ""
								BD6->(MsUnLock())							
							Endif						
					Endif
				Endif
				
			Endif
	
		Next
	End Transaction
	Close(o_dlg)
	
	//PLSMCTMD.PRW
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Obter parametros para re-valorizacao. Trecho extraido de PLSMCTMD.PRW ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู	
	BCL->(DbSetOrder(1))
	BCL->(MsSeek(xFilial("BCL")+BCI->(BCI_CODOPE+BCI_TIPGUI)))	

		_aPar   := {_cAlias,;  //aPar[1]
					"3",; // 1-Movimento simples / 2=PEG / 3-Revalorizacao  //cTipo //aPar[2]
					PLSINTPAD(),; //cCodOpe //aPar[3]
					_cTipGui,;//aArray[nCont,16],; //BD6_TIPGUI  //aPar[4]
					&(_cAlias+"->"+_cAlias+"_FASE"),; //cCpoFase  //aPar[5]
					BCI->BCI_CODLDP,; //CodLDP  //aPar[6]
					BCI->BCI_CODPEG,; //CODPEG  //aPar[7]
					BCL->BCL_GUIREL,; //BCL_GUIREL  //aPar[8]
					.F.,; //lAutori  //aPar[9]
					Nil,;//aArray[nCont,17],; //BD6_DATPRO  //aPar[10]
					.T.,; //lHelp  //aPar[11]
					"3",; //cNextFase //aPar[12]
					Nil,;//aArray[nCont,09],; //nVlrPag //aPar[13]
					Nil,;//aArray[nCont,8]-aArray[nCont,11],; //nVlrGlo   //aPar[14]
					.T.,; //lHelp   //aPar[15]
					BCL->BCL_ALIAS,; //BCL_ALIAS   //aPar[16]
					_aItensGlo,; //Itens Glosados   //aPar[17]
					Nil,;  //aFiltro   //aPar[18]
					Nil,;  //lReanaliza   //aPar[19]
					Nil,;  //lIntEnv    //aPar[20]
					Nil,;  //oBrwIte    //aPar[21]
					.F.,;  //lProcRev  //aPar[22]
					0}   //nIndRecBD6   //aPar[23]
					
    PLSA720MF(_aPar)
	
	//BIANCHINI - 26/01/2021 - Chamado ao PE de ajuste taxa - Somente Conv๊nios
	If cEmpAnt == '01' .and. &(_cAlias+"->"+_cAlias+"_CODEMP") $ '0004|0009'  
		BD6->(DbSetOrder(1))
		If BD6->(DbSeek(xFilial("BD6")+_cCodOpe+_cCodLDP+_cCodPEG+_cNumero))
			While !BD6->(EOF()) .AND. xFilial("BD6")+BD6->(BD6_CODOPE+BD6_CODLDP+BD6_CODPEG+BD6_NUMERO) == xFilial("BD6")+_cCodOpe+_cCodLDP+_cCodPEG+_cNumero
				//Condi็ใo copiada do PLS720FUN.PRW
				if existBlock("PLS720DOP")
					aRetDOP := execBlock("PLS720DOP",.f.,.f.,{.T.,BD6->BD6_VLRTPF,BD6->BD6_VLRTAD,BD6->BD6_VLRBPF})
				endIf
				BD6->(DbSkip())
			Enddo
		Endif
	Endif

    MsgAlert("Itens revalorizados com sucesso!")

Endif

//RestArea(aAreaBD5)
RestArea(aAreaBD6)
//RestArea(aAreaBD7)

Return Nil

****************************************************************************************************************

//Leonardo Portella - 06/03/15 - Nao e mais permitido reconsiderar a glosa por solicitacao do superintendente 
//Dr. Giordano. Vide PE PLS720G1

User Function lReconsid(n_Opca)

Local lRet 		:= .T.
Local c_Alias	:= BCL->BCL_ALIAS
Local cMacro	:= c_Alias + '->' + c_Alias + '_CODRDA' 
Local c_CodRDA	:= ( &cMacro )
Local lRecons	:= .F.
Local aArea		:= GetArea()
Local aAreaBAU	:= BAU->(GetArea())

If ( n_Opca == 2 )//Reconsidera
/*
	BAU->(DbSetOrder(1))
	
	If BAU->(DbSeek(xFilial('BAU') + c_CodRDA))

		Do Case
		
			Case ( cEmpAnt == '02' ) .and. ( BAU->BAU_CODIGO == '999997' ) 
				lRecons := .T.
				
			Case ( BAU->BAU_CODOPE $ GetNewPar("MV_YOPAVLC","") )
				lRecons := .T.
			
			//Leonardo Portella - 07/04/15 - Chamado - ID: 16584 - RDAs que podem reconsiderar. Solicitado por Nilton 
			//e Max (Giordano de ferias). Rede D'or
			Case u_lRDAPodeRec(c_CodRDA)	
				lRecons := .T.
				
			Otherwise
				lRecons := .F.
				
		End Case
		
	EndIf
	
	If !lRecons
		
		MsgStop('Por solicita็ใo da superintend๊ncia nใo ้ mais permitido reconsiderar glosas.', AllTrim(SM0->M0_NOMECOM))
		lRet 	:= .F.
		
	EndIf
*/
EndIf

BAU->(RestArea(aAreaBAU))
RestArea(aArea)

Return lRet
