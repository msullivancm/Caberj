#include "PROTHEUS.CH"
#include "PLSMGER.CH"
#include "COLORS.CH"
#include "RWMAKE.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ RelRecGlo ºAutor  ³Thiago Machado Correa º Data ³ 14/09/08 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Relatorio de Recursos de Glosa							  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Caberj			                                          º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function RelRecGlo()

Private cPerg := "YRECGL"
Private oLeTxt

DbSelectArea("BD7") 
DbSetOrder(1)

//Cria Perguntas                       
CriaSX1(cPerg)

@ 200,1 TO 380,380 DIALOG oLeTxt TITLE OemToAnsi("Relatório de Recursos de Glosa") 
@ 02,10 TO 65,180
@ 10,018 Say " Este programa tem como objetivo imprimir os recursos de glosa "
@ 18,018 Say " cadastrados no sistema, conforme parâmetros informados. "
@ 26,018 Say " "

@ 70,098 BMPBUTTON TYPE 05 ACTION Pergunte(cPerg,.T.)
@ 70,128 BMPBUTTON TYPE 01 ACTION Processa({|| Processa1(cPerg)},"Preparando Ambiente...")
@ 70,158 BMPBUTTON TYPE 02 ACTION Close(oLeTxt)

Activate Dialog oLeTxt Centered

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ Processa1 ºAutor  ³Thiago Machado Correa º Data ³ 14/09/08 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Monta arquivos temporarios 								  º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function Processa1(cPerg)

Local cCodOpe := ""
Local cCodLdp := ""
Local cCodPeg := ""
Local cNumero := ""
Local cOriMov := ""
Local cCodRda := ""
Local cGuiOri := ""
Local cRemOri := ""                                                         
Local cCmpOri := ""
Local cDesPro := ""
Local nNumImp := ""
Local cRisco  := ""
Local cSQL    := ""           
Local dDatRev := StoD("")
Local aTotRda := {}
Local nPosReg := 0
Local nTotReg := 0
Local nVlrRec := 0
Local nVlrTpf := 0
Local cTabBCI := RetSQLName("BCI") 
Local cTabBD7 := RetSQLName("BD7")

//Ordena Arquivos
BCI->(DbSetOrder(1))
BE4->(DbSetOrder(1))
BD5->(DbSetOrder(1))
BD6->(DbSetOrder(1))
BD7->(DbSetOrder(1))
BAU->(DbSetOrder(1))

//Alimenta Perguntas
Pergunte(cPerg,.F.)

//Variaveis do pergunte
Private cCodOpe := mv_par01
Private cRdaIni := mv_par02
Private cRdaFim := mv_par03
Private cCpRIni := mv_par04
Private cCpRFim := mv_par05
Private cCpOIni := mv_par06
Private cCpOFim := mv_par07
Private cProRem := mv_par08
Private nTipRel := mv_par09
Private nFase   := mv_par10
Private nImprim := mv_par11
Private nImpBlo := mv_par12
Private nSomGCb := mv_par13
Private dDatIni := mv_par14
Private dDatFim := mv_par15
Private cLdpIni := mv_par16
Private cLdpFim := mv_par17
Private cPegIni := mv_par18
Private cPegFim := mv_par19
Private cNumIni := mv_par20
Private cNumFim := mv_par21
Private cEmpIni := mv_par22
Private cEmpFim := mv_par23
Private cConIni := mv_par24
Private cConFim := mv_par25
Private cSubIni := mv_par26
Private cSubFim := mv_par27
Private cPlaIni := mv_par28
Private cPlaFim := mv_par29
Private cProIni := mv_par30
Private cProFim := mv_par31
Private nImpCop := mv_par32
Private cGPgIni := mv_par33
Private cGPgFim := mv_par34

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta query principal...									 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cSQL := " SELECT BD7_CODOPE, BD7_CODLDP, BD7_CODPEG, BD7_NUMERO, BD7_ORIMOV, BD7_SEQUEN, BD7_CODPAD, BD7_CODPRO, BD7_CODUNM, BD7_NLANC, BD7_CODRDA, BD7_NOMRDA, BD7_PERCEN, BD7_ANOPAG, BD7_MESPAG, BD7_TIPGUI, BD7_VLRPAG, BD7_VLRGLO, BD7_VLRTPF "
cSQL += " FROM " + IIF(Empty(cProRem),(cTabBD7),(cTabBCI + ", " + cTabBD7))
cSQL += " WHERE "
If ! Empty(cProRem)
	cSQL += " BCI_FILIAL='"+xFilial("BCI")+"' AND "
	cSQL += " BCI_YPTREM = '"+cProRem+"' AND "
Endif
cSQL += " BD7_FILIAL='"+xFilial("BD7")+"' "
cSQL += " AND BD7_CODOPE = '"+cCodOpe+"' "
cSQL += " AND BD7_CODLDP >= '"+cLdpIni+"' AND BD7_CODLDP <= '"+cLdpFim+"'"
cSQL += " AND BD7_CODPEG >= '"+cPegIni+"' AND BD7_CODPEG <= '"+cPegFim+"'"
cSQL += " AND BD7_NUMERO >= '"+cNumIni+"' AND BD7_NUMERO <= '"+cNumFim+"'"
cSQL += " AND BD7_CODRDA >= '"+cRdaIni+"' AND BD7_CODRDA <= '"+cRdaFim+"'"
cSQL += " AND BD7_ANOPAG+BD7_MESPAG>='"+cCpRIni+"' AND BD7_ANOPAG+BD7_MESPAG<='"+cCpRFim+"'"
cSQL += " AND BD7_DATPRO >= '"+DtoS(dDatIni)+"' AND BD7_DATPRO <= '"+DtoS(dDatFim)+"'" 
cSQL += " AND BD7_CODEMP >='" +cEmpIni+"' AND BD7_CODEMP<='"+cEmpFim+"'"
cSQL += " AND BD7_CODPLA >='" +cPlaIni+"' AND BD7_CODPLA<='"+cPlaFim+"'"
cSQL += " AND BD7_CODPRO >='" +cProIni+"' AND BD7_CODPRO<='"+cProFim+"'"
cSQL += " AND BD7_BLOPAG <> '1' AND BD7_VLRPAG > 0 "

Do Case
	Case nFase == 1
		cSQL += " AND BD7_FASE = '3'" 
	Case nFase == 2
		cSQL += " AND BD7_FASE = '4'" 
	Case nFase == 3
		cSQL += " AND BD7_FASE = '2'" 
EndCase

Do Case
	Case nImpBlo == 1
		cSQL += " AND BD7_SITUAC = '3'"
	Case nImpBlo == 2
		cSQL += " AND BD7_SITUAC <> '3'"
EndCase

If nSomGCb == 1
	cSQL += " AND BD7_VLRTPF > 0"
Endif

If ! Empty(cProRem)
	cSQL += " AND BCI_FILIAL=BD7_FILIAL AND BCI_CODOPE=BD7_CODOPE AND BCI_CODLDP=BD7_CODLDP AND BCI_CODPEG=BD7_CODPEG "
	cSQL += " AND " + cTabBCI + ".D_E_L_E_T_ = ' '"
Endif

cSQL += " AND " + cTabBD7 + ".D_E_L_E_T_ = ' '"
cSQL += " ORDER BY BD7_CODRDA, BD7_CODOPE, BD7_CODLDP, BD7_CODPEG, BD7_NUMERO, BD7_ORIMOV"

PLSQuery(cSQL,"Trb")

//Conta Registros para Regua
While ! Trb->(Eof())
	nTotReg++
	Trb->(DbSkip())
EndDo

ProcRegua(nTotReg)

Trb->(DbGoTop())

While ! Trb->(Eof())

	//Inicializa variaveis
	cCodRda := Trb->BD7_CODRDA
    
	//Posiciona Rda
	BAU->(MsSeek(xFilial("BAU")+Trb->BD7_CODRDA))

	If (BAU->BAU_GRPPAG < cGPgIni) .or. (BAU->BAU_GRPPAG > cGPgFim)
		Trb->(DbSkip())
		Loop
	Endif

	While Trb->BD7_CODRDA == cCodRda .and. ! Trb->(Eof())
        
        cGuiOri := ""
        cRemOri := Space(8)
        cCmpOri := Space(6)
        
		//Busca Guia Origem
		If Trb->BD7_TIPGUI == "03"
			BE4->(MsSeek(xFilial("BE4")+Trb->(BD7_CODOPE+BD7_CODLDP+BD7_CODPEG+BD7_NUMERO)))
			cGuiOri := BE4->BE4_YGUIOR
		Else
			BD5->(MsSeek(xFilial("BD5")+Trb->(BD7_CODOPE+BD7_CODLDP+BD7_CODPEG+BD7_NUMERO)))
			cGuiOri := BD5->BD5_YGUIOR
		Endif

		//Busca Peg Origem
		If BCI->(MsSeek(xFilial("BCI")+Substr(cGuiOri,1,16)))
			cRemOri := BCI->BCI_YPTREM
		Endif

		//Valida Competencia Guia Origem
		If Substr(cGuiOri,25,1) == "1"
			If BD5->(MsSeek(xFilial("BD5")+Substr(cGuiOri,1,24)))
				cCmpOri := BD5->(BD5_ANOPAG+BD5_MESPAG)
				If (cCmpOri < cCpOIni) .or. (cCmpOri > cCpOFim)
					Trb->(DbSkip())
					Loop
				Endif
			Endif
		Else
			If BE4->(MsSeek(xFilial("BE4")+Substr(cGuiOri,1,24)))
				cCmpOri := BE4->(BE4_ANOPAG+BE4_MESPAG)
				If (cCmpOri < cCpOIni) .or. (cCmpOri > cCpOFim)
					Trb->(DbSkip())
					Loop
				Endif
			Endif
		Endif

		cCodOpe := Trb->BD7_CODOPE
		cCodLdp := Trb->BD7_CODLDP
		cCodPeg := Trb->BD7_CODPEG
		cNumero := Trb->BD7_NUMERO
		cOriMov := Trb->BD7_ORIMOV
	
		While Trb->BD7_CODRDA == cCodRda .and. Trb->BD7_CODOPE == cCodOpe .and. Trb->BD7_CODLDP == cCodLdp .and. Trb->BD7_CODPEG == cCodPeg .and. Trb->BD7_NUMERO == cNumero .and. Trb->BD7_ORIMOV == cOriMov .and. ! Trb->(Eof())

			IncProc( "Processando registro: "+Alltrim(Str(Trb->(Recno())))+"/"+Alltrim(Str(nTotReg)) )

			//Posiciona Evento Atual
			BD6->(DbSetOrder(1))
			
			If BD6->(MsSeek(xFilial("BD6")+Trb->(BD7_CODOPE+BD7_CODLDP+BD7_CODPEG+BD7_NUMERO+BD7_ORIMOV+BD7_SEQUEN)))

				//Valida Contrato
				If BD6->BD6_CONEMP < cConIni .or. BD6->BD6_CONEMP > cConFim
					Trb->(DbSkip())
					Loop
				Endif
			
				//Valida Sub-Contrato
				If BD6->BD6_SUBCON < cSubIni .or. BD6->BD6_SUBCON > cSubFim
					Trb->(DbSkip())
					Loop
				Endif
                                
				dDatRev := BD6->BD6_DTDIGI
				cDespro := BD6->BD6_DESPRO
				cNumImp := BD6->BD6_NUMIMP
				nVlrRec := Trb->BD7_VLRPAG
				nVlrTpf := Trb->BD7_VLRTPF
				nVlrApr := 0
				nVlrPag := 0
				nVlrGlo := 0   
				cRisco  := ""
	
				//Posiciona Evento Original        
				BD6->(DbSetOrder(6))
				If BD6->(MsSeek(xFilial("BD6")+cGuiOri+Trb->(BD7_CODPAD+BD7_CODPRO)))
	                 
					//Posiciona Composicao do Evento Original        
					If BD7->(MsSeek(xFilial("BD7")+BD6->(BD6_CODOPE+BD6_CODLDP+BD6_CODPEG+BD6_NUMERO+BD6_ORIMOV+BD6_SEQUEN)+Trb->(BD7_CODUNM+BD7_NLANC)))
					
						//Valida codigo da Rda na Guia Original
						If BD7->BD7_CODRDA == cCodRda
							//nVlrApr := ((BD6->BD6_QTDAPR*BD6->BD6_VLRAPR)*(BD7->BD7_PERCEN/100))
							nVlrApr := ((BD6->BD6_QTDPRO*BD6->BD6_VLRAPR)*(BD7->BD7_PERCEN/100))
							nVlrPag := IIF(BD7->BD7_BLOPAG=="1",0,BD7->BD7_VLRPAG)
							nVlrGlo := IIF(BD7->BD7_BLOPAG=="1",BD7->BD7_VLRPAG,BD7->BD7_VLRGLO)
						Endif                                           
					Endif

					//Identifica se guia de origem eh Grande Risco ou Pequeno Risco
					If BD6->BD6_TIPGUI == "03"
						cRisco := "GR"
					Else
						If PLSUSRINTE(BD6->(BD6_OPEUSR+BD6_CODEMP+BD6_MATRIC+BD6_TIPREG+BD6_DIGITO),BD6->BD6_DATPRO,BD6->BD6_HORPRO,.F.,.F.,"BD5")
							cRisco := "GR"
						Else
							cRisco := "PR"
						Endif
					Endif
						
				Endif
				
				//Alimenta array principal
				nPosReg := Ascan(aTotRda, { |x| x[1]==Trb->(BD7_CODOPE+BD7_CODLDP+BD7_CODPEG+BD7_NUMERO+BD7_ORIMOV) .and. x[2]==Trb->BD7_CODPAD .and. x[3]==Trb->BD7_CODPRO .and. x[7]==Trb->BD7_CODRDA})
				
 				If nPosReg == 0
					aAdd(aTotRda,{Trb->(BD7_CODOPE+BD7_CODLDP+BD7_CODPEG+BD7_NUMERO+BD7_ORIMOV),Trb->BD7_CODPAD,Trb->BD7_CODPRO,cDesPro,Trb->BD7_SEQUEN,cGuiOri,Trb->BD7_CODRDA,Trb->BD7_NOMRDA,BAU->BAU_TIPPE,cRemOri,cCmpOri,nVlrApr,nVlrPag,nVlrGlo,dDatRev,nVlrRec,cRisco,Trb->(BD7_ANOPAG+BD7_MESPAG),BAU->BAU_GRPPAG,nVlrTpf,cNumImp})
				Else
					aTotRda[nPosReg][12] += nVlrApr
					aTotRda[nPosReg][13] += nVlrPag
					aTotRda[nPosReg][14] += nVlrGlo
					aTotRda[nPosReg][16] += nVlrRec
					aTotRda[nPosReg][20] += nVlrTpf
				Endif				
		    
			Endif
			
        	Trb->(DbSkip())
    	EndDo
	EndDo	
	
EndDo

Trb->(DbCloseArea())

If Len(aTotRda) > 0
	Processa({|| Processa2(aTotRda)},"Imprime Relatorio...")
Else 
	MsgAlert("Nenhum registro selecionado. Verifique os parametros informados!")
Endif

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ Processa2 ºAutor  ³Thiago Machado Correa º Data ³ 14/09/08 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Imprime relatorio                                          º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function Processa2(aTotRda)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local wnrel
Local cDesc1  := "Este programa tem como objetivo imprimir os recursos de glosas"
Local cDesc2  := "conforme parâmetros informados."
Local cDesc3  := ""
Local cString := "BD7"
Local aOrd    := {"Rda + Competência + Mês/Ano Origem","Rda","Competência + Mês/Ano Origem"} 
Local nOrdSel := 1

Private cTitulo  := "Recursos de Glosas"
Private cabec1	 := "Conta Médica Recurso           Conta Médica Origem            Remessa   Tp  Revisão      " + IIF(nImprim<>1,"Nro Impresso","")
Private cabec2	 := "Seq Procedimento        Descrição                                        Vlr Apresentado      Vlr Pago     Vlr Glosa %Glosa    Recuperado %Recup Glosa Mantida   %G. M.  " + IIF(nImpCop==1,"Vlr Co-Part.","")
Private aReturn  := { "Zebrado", 1,"Administracao", 2, 2, 1, "", 1 }
Private cPerg    := "YRECGL"
Private nomeprog := "RELRECGLO" 
Private Tamanho  := "G"
Private cChavAnt := ""
Private nLastKey := 0
Private nTipo    := 0
Private nPerINSS := 0
Private nQtdLin  := 73

If nTipRel <> 1
	cabec1 := "Codigo Descrição da Rda                         Tp G.P.  Remessa Cmp Ori Cmp Rec Revisão  Vlr Apresentado      Vlr Pago     Vlr Glosa %Glosa    Recuperado %Recup Glosa Mantida   %G. M. " + IIF(nImpCop==1,"  Vlr Co-Part ","") + "Risco"
	cabec2 := ""
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Envia controle para a funcao SETPRINT                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
wnrel := "RELRECGLO"
wnrel := SetPrint(cString,wnrel,cPerg,@cTitulo,cDesc1,cDesc2,cDesc3,.F.,aOrd,,Tamanho,,.F.)

If nLastKey == 27
   Return
EndIf

SetDefault(aReturn,cString)

If nLastKey == 27
   Return
EndIf
              
nOrdSel := aReturn[8]

//Fixa Ordem 1 quando impressao sintetica
If nTipRel == 2
	nOrdSel := 1
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Funcao principal											 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Do Case
	Case nOrdSel = 1
		aSort(aTotRda,,, { |x, y| x[7]+x[18]+x[11]+x[1]+x[2]+x[3]+x[5] < y[7]+y[18]+y[11]+y[1]+y[2]+y[3]+y[5] })
		RptStatus({|lEnd| ImpRel01(aTotRda)},cTitulo)
	Case nOrdSel = 2
		aSort(aTotRda,,, { |x, y| x[7]+x[1]+x[2]+x[3]+x[5] < y[7]+y[1]+y[2]+y[3]+y[5] })
		RptStatus({|lEnd| ImpRel02(aTotRda)},cTitulo)
	Case nOrdSel = 3
		aSort(aTotRda,,, { |x, y| x[18]+x[11]+x[1]+x[2]+x[3]+x[5] < y[18]+y[11]+y[1]+y[2]+y[3]+y[5] })
		RptStatus({|lEnd| ImpRel03(aTotRda)},cTitulo)
	Otherwise
		aSort(aTotRda,,, { |x, y| x[7]+x[18]+x[11]+x[1]+x[2]+x[3]+x[5] < y[7]+y[18]+y[11]+y[1]+y[2]+y[3]+y[5] })
		RptStatus({|lEnd| ImpRel01(aTotRda)},cTitulo)
EndCase
	
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Finaliza a execucao do relatorio...                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
SET DEVICE TO SCREEN

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Se impressao em disco, chama o gerenciador de impressao...          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If aReturn[5]==1
	dbCommitAll()
	SET PRINTER TO
	OurSpool(wnrel)
Endif

MS_FLUSH()

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFun‡…o    ³ ImpRel01  ºAutor  ³Thiago Machado Correa º Data ³ 15/09/08 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Imprime relatorio ordem 01                          		  º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ImpRel01(aTotRda)

Local nPos       := 1
Local cCodRda    := "" 
Local cCmpOri    := ""
Local cCompet    := ""
Local cChaGui    := ""
Local cRemOri    := ""
Local cRisco     := ""
Local dDatRev    := StoD("")
Local nTotAprGui := 0
Local nTotPagGui := 0
Local nTotGloGui := 0
Local nTotRecGui := 0
Local nTotTpfGui := 0
Local nTotAprCmp := 0
Local nTotPagCmp := 0
Local nTotGloCmp := 0
Local nTotRecCmp := 0
Local nTotTpfCmp := 0
Local nTotAprRda := 0
Local nTotPagRda := 0
Local nTotGloRda := 0
Local nTotRecRda := 0
Local nTotTpfRda := 0
Local nTotAprGer := 0
Local nTotPagGer := 0
Local nTotGloGer := 0
Local nTotRecGer := 0
Local nTotTpfGer := 0

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para Impressao do Cabecalho e Rodape    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
li    := 80
m_pag := 1
nTipo := GetMv("MV_COMP")

SetRegua(Len(aTotRda))

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Imprime relatorio...										 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
While nPos <= Len(aTotRda)
    
	cCodRda := aTotRda[nPos][7]
	nTotAprRda := 0
	nTotPagRda := 0
	nTotGloRda := 0
	nTotRecRda := 0
	nTotTpfRda := 0

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Imprime cabecalho...                                               ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If Li > nQtdLin
		Cabec(cTitulo,cabec1,cabec2,nomeprog,tamanho,nTipo)
	Endif

	If nTipRel == 1
		@ Li,000 PSay "Rda: " + aTotRda[nPos][7] + "-" + Alltrim(aTotRda[nPos][8]) + " - " + "Tipo: " + IIF(aTotRda[nPos][9]=="F","PF","PJ") + " - " + "Grupo de Pagamento: " + aTotRda[nPos][19]
		Li++
    Endif
    
	While nPos<=Len(aTotRda) .and. aTotRda[nPos][7]==cCodRda

		cCompet := aTotRda[nPos][18]
		nTotAprCmp := 0
		nTotPagCmp := 0
		nTotGloCmp := 0
		nTotRecCmp := 0
		nTotTpfCmp := 0

		While nPos<=Len(aTotRda) .and. aTotRda[nPos][7]==cCodRda .and. aTotRda[nPos][18]==cCompet

			cCmpOri := aTotRda[nPos][11]
	
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Imprime cabecalho...                                               ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If Li > nQtdLin
				Cabec(cTitulo,cabec1,cabec2,nomeprog,tamanho,nTipo)
			Endif
	        
			If nTipRel == 1
				Li++
				@ Li,000 PSay "Competência do Recurso: " + substr(cCompet,5,2) + "/" + substr(cCompet,1,4) + " - " + "Mês/Ano Origem: " + substr(cCmpOri,5,2) + "/" + substr(cCmpOri,1,4)
				Li++
			Endif
						
			While nPos<=Len(aTotRda) .and. aTotRda[nPos][7]==cCodRda .and. aTotRda[nPos][18]==cCompet .and. aTotRda[nPos][11]==cCmpOri
	            
				cChaGui    := aTotRda[nPos][1]
				cRemOri    := aTotRda[nPos][10]
				cRisco     := aTotRda[nPos][17]
				dDatRev    := aTotRda[nPos][15]
				nTotAprGui := 0
				nTotPagGui := 0
				nTotGloGui := 0
				nTotRecGui := 0
				nTotTpfGui := 0
			
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Imprime cabecalho...                                               ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				If Li > nQtdLin
					Cabec(cTitulo,cabec1,cabec2,nomeprog,tamanho,nTipo)
				Endif
	
				If nTipRel == 1
					Li++
					@ Li,000 PSay Transform(aTotRda[nPos][1],"@R 9999.9999.99999999.99999999.9") + "  " + Transform(aTotRda[nPos][6],"@R 9999.9999.99999999.99999999.9") + "  " + IIF(Empty(cRemOri),space(8),cRemOri) + "  " + IIF(Empty(cRisco),space(2),cRisco) + "  " + DtoC(dDatRev) + "   " + IIF(nImprim<>1,aTotRda[nPos][21],"")
					Li++
				Endif
			
				While nPos<=Len(aTotRda) .and. aTotRda[nPos][7]==cCodRda .and. aTotRda[nPos][11]==cCmpOri .and. aTotRda[nPos][18]==cCompet .and. aTotRda[nPos][1]==cChaGui
	
					nGlosa  := ((aTotRda[nPos][14]*100)/aTotRda[nPos][13])
					nRecup  := ((aTotRda[nPos][16]*100)/aTotRda[nPos][14])
					nGloMan := IIF(aTotRda[nPos][14]=0,0,(aTotRda[nPos][14]-aTotRda[nPos][16]))
					nPerGlo := ((nGloMan*100)/aTotRda[nPos][14])
					
					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³ Incrementa Regua...                                                ³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					IncRegua()
					
					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³ Imprime cabecalho...                                               ³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					If Li > nQtdLin
						Cabec(cTitulo,cabec1,cabec2,nomeprog,tamanho,nTipo)
					Endif
					
					If nTipRel == 1
						@ Li,000 PSay aTotRda[nPos][5] + " " + aTotRda[nPos][2] + "." + aTotRda[nPos][3] + " " + aTotRda[nPos][4] + " " + Transform(aTotRda[nPos][12],"@E 99,999,999.99") + " " + Transform(aTotRda[nPos][13],"@E 99,999,999.99") + " " + Transform(aTotRda[nPos][14],"@E 99,999,999.99") + " " + Transform(nGlosa,"@E 999.99") + " " + Transform(aTotRda[nPos][16],"@E 99,999,999.99") + " " + Transform(nRecup,"@E 999.99") + " " + Transform(nGloMan,"@E 99,999,999.99") + " " + Transform(nPerGlo,"@E 9,999.99") + " " + IIF(nImpCop==1,Transform(aTotRda[nPos][20],"@E 99,999,999.99"),"")
						Li++
					Endif
				
					nTotAprGui += aTotRda[nPos][12]
					nTotPagGui += aTotRda[nPos][13]
					nTotGloGui += aTotRda[nPos][14]
					nTotRecGui += aTotRda[nPos][16]
					nTotTpfGui += aTotRda[nPos][20]
							    
					nPos++
				EndDo
				
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Imprime cabecalho...                                               ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				If Li > nQtdLin
					Cabec(cTitulo,cabec1,cabec2,nomeprog,tamanho,nTipo)
				Endif
				
				nGlosa  := ((nTotGloGui*100)/nTotPagGui)
				nRecup  := ((nTotRecGui*100)/nTotGloGui)
				nGloMan := IIF(nTotGloGui=0,0,(nTotGloGui-nTotRecGui))
				nPerGlo := ((nGloMan*100)/nTotGloGui)
			
				If nTipRel == 1
					@ Li,000 PSay Space(59) + "Total da Conta: " + Transform(nTotAprGui,"@E 99,999,999.99") + " " + Transform(nTotPagGui,"@E 99,999,999.99") + " " + Transform(nTotGloGui,"@E 99,999,999.99") + " " + Transform(nGlosa,"@E 999.99") + " " + Transform(nTotRecGui,"@E 99,999,999.99") + " " + Transform(nRecup,"@E 999.99") + " " + Transform(nGloMan,"@E 99,999,999.99") + " " + Transform(nPerGlo,"@E 9,999.99") + " " + IIF(nImpCop==1,Transform(nTotTpfGui,"@E 99,999,999.99"),"")
					Li++
				Endif
			
				nTotAprCmp += nTotAprGui
				nTotPagCmp += nTotPagGui
				nTotGloCmp += nTotGloGui
				nTotRecCmp += nTotRecGui
				nTotTpfCmp += nTotTpfGui
					
			EndDo             
			
		EndDo

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Imprime cabecalho...                                               ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If Li > nQtdLin
			Cabec(cTitulo,cabec1,cabec2,nomeprog,tamanho,nTipo)
		Endif
		
		nGlosa  := ((nTotGloCmp*100)/nTotPagCmp)
		nRecup  := ((nTotRecCmp*100)/nTotGloCmp)
		nGloMan := IIF(nTotGloCmp=0,0,(nTotGloCmp-nTotRecCmp))
		nPerGlo := ((nGloMan*100)/nTotGloCmp)
	
		If nTipRel == 1
			@ Li,000 PSay Space(53) + "Total da Competência: " + Transform(nTotAprCmp,"@E 99,999,999.99") + " " + Transform(nTotPagCmp,"@E 99,999,999.99") + " " + Transform(nTotGloCmp,"@E 99,999,999.99") + " " + Transform(nGlosa,"@E 999.99") + " " + Transform(nTotRecCmp,"@E 99,999,999.99") + " " + Transform(nRecup,"@E 999.99") + " " + Transform(nGloMan,"@E 99,999,999.99") + " " + Transform(nPerGlo,"@E 9,999.99") + " " + IIF(nImpCop==1,Transform(nTotTpfCmp,"@E 99,999,999.99"),"")
			Li++                     
        Else
			@ Li,000 PSay aTotRda[nPos-1][7] + " " + aTotRda[nPos-1][8] + " " + IIF(aTotRda[nPos-1][9]=="F","PF","PJ") + " " + aTotRda[nPos-1][19] + " " + cRemOri + " " + substr(cCmpOri,5,2) + "/" + substr(cCmpOri,1,4) + " " + substr(cCompet,5,2) + "/" + substr(cCompet,1,4) + " " + DtoC(dDatRev) + " " + Transform(nTotAprCmp,"@E 99,999,999.99") + " " + Transform(nTotPagCmp,"@E 99,999,999.99") + " " + Transform(nTotGloCmp,"@E 99,999,999.99") + " " + Transform(nGlosa,"@E 999.99") + " " + Transform(nTotRecCmp,"@E 99,999,999.99") + " " + Transform(nRecup,"@E 999.99") + " " + Transform(nGloMan,"@E 99,999,999.99") + " " + Transform(nPerGlo,"@E 9,999.99") + IIF(nImpCop==1," ","") + IIF(nImpCop==1,Transform(nTotTpfCmp,"@E 99,999,999.99"),"") + " " + cRisco
			Li++                     
        Endif
        
		nTotAprRda += nTotAprCmp
		nTotPagRda += nTotPagCmp
		nTotGloRda += nTotGloCmp
		nTotRecRda += nTotRecCmp
		nTotTpfRda += nTotTpfCmp
			
	EndDo

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Imprime cabecalho...                                               ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If Li > nQtdLin
		Cabec(cTitulo,cabec1,cabec2,nomeprog,tamanho,nTipo)
	Endif
	
	nGlosa  := ((nTotGloRda*100)/nTotPagRda)
	nRecup  := ((nTotRecRda*100)/nTotGloRda)
	nGloMan := IIF(nTotGloRda=0,0,(nTotGloRda-nTotRecRda))
	nPerGlo := ((nGloMan*100)/nTotGloRda)

	If nTipRel == 1
		@ Li,000 PSay Space(61) + "Total da Rda: " + Transform(nTotAprRda,"@E 99,999,999.99") + " " + Transform(nTotPagRda,"@E 99,999,999.99") + " " + Transform(nTotGloRda,"@E 99,999,999.99") + " " + Transform(nGlosa,"@E 999.99") + " " + Transform(nTotRecRda,"@E 99,999,999.99") + " " + Transform(nRecup,"@E 999.99") + " " + Transform(nGloMan,"@E 99,999,999.99") + " " + Transform(nPerGlo,"@E 9,999.99") + " " + IIF(nImpCop==1,Transform(nTotTpfRda,"@E 99,999,999.99"),"")
		Li++                     
		Li++                     
    Endif
    
	nTotAprGer += nTotAprRda
	nTotPagGer += nTotPagRda
	nTotGloGer += nTotGloRda
	nTotRecGer += nTotRecRda
	nTotTpfGer += nTotTpfRda
		
EndDo

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Imprime cabecalho...                                               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If Li > nQtdLin
	Cabec(cTitulo,cabec1,cabec2,nomeprog,tamanho,nTipo)
Endif

nGlosa  := ((nTotGloGer*100)/nTotPagGer)
nRecup  := ((nTotRecGer*100)/nTotGloGer)
nGloMan := IIF(nTotGloGer=0,0,(nTotGloGer-nTotRecGer))
nPerGlo := ((nGloMan*100)/nTotGloGer)

@ Li,000 PSay Space(62) + IIF(nTipRel==1,"",space(17)) + "Total Geral: " + Transform(nTotAprGer,"@E 99,999,999.99") + " " + Transform(nTotPagGer,"@E 99,999,999.99") + " " + Transform(nTotGloGer,"@E 99,999,999.99") + " " + Transform(nGlosa,"@E 999.99") + " " + Transform(nTotRecGer,"@E 99,999,999.99") + " " + Transform(nRecup,"@E 999.99") + " " + Transform(nGloMan,"@E 99,999,999.99") + " " + Transform(nPerGlo,"@E 9,999.99") + " " + IIF(nImpCop==1,Transform(nTotTpfGer,"@E 99,999,999.99"),"")
Li++                     

Return                            

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFun‡…o    ³ ImpRel02  ºAutor  ³Thiago Machado Correa º Data ³ 15/09/08 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Imprime relatorio ordem 02                          		  º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ImpRel02(aTotRda)

Local nPos       := 1
Local cCodRda    := "" 
Local cCmpOri    := ""
Local cCompet    := ""
Local cChaGui    := ""
Local cRemOri    := ""
Local cRisco     := ""
Local dDatRev    := StoD("")
Local nTotAprGui := 0
Local nTotPagGui := 0
Local nTotGloGui := 0
Local nTotRecGui := 0
Local nTotTpfGui := 0
Local nTotAprCmp := 0
Local nTotPagCmp := 0
Local nTotGloCmp := 0
Local nTotRecCmp := 0
Local nTotTpfCmp := 0
Local nTotAprRda := 0
Local nTotPagRda := 0
Local nTotGloRda := 0
Local nTotRecRda := 0
Local nTotTpfRda := 0
Local nTotAprGer := 0
Local nTotPagGer := 0
Local nTotGloGer := 0
Local nTotRecGer := 0
Local nTotTpfGer := 0

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para Impressao do Cabecalho e Rodape    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
li    := 80
m_pag := 1
nTipo := GetMv("MV_COMP")

SetRegua(Len(aTotRda))

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Imprime relatorio...										 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
While nPos <= Len(aTotRda)
    
	cCodRda := aTotRda[nPos][7]
	nTotAprRda := 0
	nTotPagRda := 0
	nTotGloRda := 0
	nTotRecRda := 0
	nTotTpfRda := 0

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Imprime cabecalho...                                               ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If Li > nQtdLin
		Cabec(cTitulo,cabec1,cabec2,nomeprog,tamanho,nTipo)
	Endif

	If nTipRel == 1
		@ Li,000 PSay "Rda: " + aTotRda[nPos][7] + "-" + Alltrim(aTotRda[nPos][8]) + " - " + "Tipo: " + IIF(aTotRda[nPos][9]=="F","PF","PJ") + " - " + "Grupo de Pagamento: " + aTotRda[nPos][19]
		Li++
    Endif
    
	While nPos<=Len(aTotRda) .and. aTotRda[nPos][7]==cCodRda

		cChaGui    := aTotRda[nPos][1]
		cRemOri    := aTotRda[nPos][10]
		cRisco     := aTotRda[nPos][17]
		dDatRev    := aTotRda[nPos][15]
		nTotAprGui := 0
		nTotPagGui := 0
		nTotGloGui := 0
		nTotRecGui := 0
		nTotTpfGui := 0
	
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Imprime cabecalho...                                               ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If Li > nQtdLin
			Cabec(cTitulo,cabec1,cabec2,nomeprog,tamanho,nTipo)
		Endif

		If nTipRel == 1
			Li++
			@ Li,000 PSay Transform(aTotRda[nPos][1],"@R 9999.9999.99999999.99999999.9") + "  " + Transform(aTotRda[nPos][6],"@R 9999.9999.99999999.99999999.9") + "  " + IIF(Empty(cRemOri),space(8),cRemOri) + "  " + IIF(Empty(cRisco),space(2),cRisco) + "  " + DtoC(dDatRev) + "   " + IIF(nImprim<>1,aTotRda[nPos][21],"")
			Li++
		Endif
	
		While nPos<=Len(aTotRda) .and. aTotRda[nPos][7]==cCodRda .and. aTotRda[nPos][1]==cChaGui

			nGlosa  := ((aTotRda[nPos][14]*100)/aTotRda[nPos][13])
			nRecup  := ((aTotRda[nPos][16]*100)/aTotRda[nPos][14])
			nGloMan := IIF(aTotRda[nPos][14]=0,0,(aTotRda[nPos][14]-aTotRda[nPos][16]))
			nPerGlo := ((nGloMan*100)/aTotRda[nPos][14])
			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Incrementa Regua...                                                ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			IncRegua()
			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Imprime cabecalho...                                               ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If Li > nQtdLin
				Cabec(cTitulo,cabec1,cabec2,nomeprog,tamanho,nTipo)
			Endif
			
			If nTipRel == 1
				@ Li,000 PSay aTotRda[nPos][5] + " " + aTotRda[nPos][2] + "." + aTotRda[nPos][3] + " " + aTotRda[nPos][4] + " " + Transform(aTotRda[nPos][12],"@E 99,999,999.99") + " " + Transform(aTotRda[nPos][13],"@E 99,999,999.99") + " " + Transform(aTotRda[nPos][14],"@E 99,999,999.99") + " " + Transform(nGlosa,"@E 999.99") + " " + Transform(aTotRda[nPos][16],"@E 99,999,999.99") + " " + Transform(nRecup,"@E 999.99") + " " + Transform(nGloMan,"@E 99,999,999.99") + " " + Transform(nPerGlo,"@E 9,999.99") + " " + IIF(nImpCop==1,Transform(aTotRda[nPos][20],"@E 99,999,999.99"),"")
				Li++
			Endif
		
			nTotAprGui += aTotRda[nPos][12]
			nTotPagGui += aTotRda[nPos][13]
			nTotGloGui += aTotRda[nPos][14]
			nTotRecGui += aTotRda[nPos][16]
			nTotTpfGui += aTotRda[nPos][20]
					    
			nPos++
		EndDo
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Imprime cabecalho...                                               ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If Li > nQtdLin
			Cabec(cTitulo,cabec1,cabec2,nomeprog,tamanho,nTipo)
		Endif
		
		nGlosa  := ((nTotGloGui*100)/nTotPagGui)
		nRecup  := ((nTotRecGui*100)/nTotGloGui)
		nGloMan := IIF(nTotGloGui=0,0,(nTotGloGui-nTotRecGui))
		nPerGlo := ((nGloMan*100)/nTotGloGui)
	
		If nTipRel == 1
			@ Li,000 PSay Space(59) + "Total da Conta: " + Transform(nTotAprGui,"@E 99,999,999.99") + " " + Transform(nTotPagGui,"@E 99,999,999.99") + " " + Transform(nTotGloGui,"@E 99,999,999.99") + " " + Transform(nGlosa,"@E 999.99") + " " + Transform(nTotRecGui,"@E 99,999,999.99") + " " + Transform(nRecup,"@E 999.99") + " " + Transform(nGloMan,"@E 99,999,999.99") + " " + Transform(nPerGlo,"@E 9,999.99") + " " + IIF(nImpCop==1,Transform(nTotTpfGui,"@E 99,999,999.99"),"")
			Li++
		Endif
	
		nTotAprRda += nTotAprGui
		nTotPagRda += nTotPagGui
		nTotGloRda += nTotGloGui
		nTotRecRda += nTotRecGui
		nTotTpfRda += nTotTpfGui
					
	EndDo             
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Imprime cabecalho...                                               ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If Li > nQtdLin
		Cabec(cTitulo,cabec1,cabec2,nomeprog,tamanho,nTipo)
	Endif
	
	nGlosa  := ((nTotGloRda*100)/nTotPagRda)
	nRecup  := ((nTotRecRda*100)/nTotGloRda)
	nGloMan := IIF(nTotGloRda=0,0,(nTotGloRda-nTotRecRda))
	nPerGlo := ((nGloMan*100)/nTotGloRda)

	If nTipRel == 1
		@ Li,000 PSay Space(61) + "Total da Rda: " + Transform(nTotAprRda,"@E 99,999,999.99") + " " + Transform(nTotPagRda,"@E 99,999,999.99") + " " + Transform(nTotGloRda,"@E 99,999,999.99") + " " + Transform(nGlosa,"@E 999.99") + " " + Transform(nTotRecRda,"@E 99,999,999.99") + " " + Transform(nRecup,"@E 999.99") + " " + Transform(nGloMan,"@E 99,999,999.99") + " " + Transform(nPerGlo,"@E 9,999.99") + " " + IIF(nImpCop==1,Transform(nTotTpfRda,"@E 99,999,999.99"),"")
		Li++                     
		Li++                     
    Endif
    
	nTotAprGer += nTotAprRda
	nTotPagGer += nTotPagRda
	nTotGloGer += nTotGloRda
	nTotRecGer += nTotRecRda
	nTotTpfGer += nTotTpfRda
		
EndDo

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Imprime cabecalho...                                               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If Li > nQtdLin
	Cabec(cTitulo,cabec1,cabec2,nomeprog,tamanho,nTipo)
Endif

nGlosa  := ((nTotGloGer*100)/nTotPagGer)
nRecup  := ((nTotRecGer*100)/nTotGloGer)
nGloMan := IIF(nTotGloGer=0,0,(nTotGloGer-nTotRecGer))
nPerGlo := ((nGloMan*100)/nTotGloGer)

@ Li,000 PSay Space(62) + IIF(nTipRel==1,"",space(17)) + "Total Geral: " + Transform(nTotAprGer,"@E 99,999,999.99") + " " + Transform(nTotPagGer,"@E 99,999,999.99") + " " + Transform(nTotGloGer,"@E 99,999,999.99") + " " + Transform(nGlosa,"@E 999.99") + " " + Transform(nTotRecGer,"@E 99,999,999.99") + " " + Transform(nRecup,"@E 999.99") + " " + Transform(nGloMan,"@E 99,999,999.99") + " " + Transform(nPerGlo,"@E 9,999.99") + " " + IIF(nImpCop==1,Transform(nTotTpfGer,"@E 99,999,999.99"),"")
Li++                     

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFun‡…o    ³ ImpRel03  ºAutor  ³Thiago Machado Correa º Data ³ 15/09/08 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Imprime relatorio ordem 03                          		  º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ImpRel03(aTotRda)

Local nPos       := 1
Local cCodRda    := "" 
Local cCmpOri    := ""
Local cCompet    := ""
Local cChaGui    := ""
Local cRemOri    := ""
Local cRisco     := ""
Local dDatRev    := StoD("")
Local nTotAprGui := 0
Local nTotPagGui := 0
Local nTotGloGui := 0
Local nTotRecGui := 0
Local nTotTpfGui := 0
Local nTotAprCmp := 0
Local nTotPagCmp := 0
Local nTotGloCmp := 0
Local nTotRecCmp := 0
Local nTotTpfCmp := 0
Local nTotAprRda := 0
Local nTotPagRda := 0
Local nTotGloRda := 0
Local nTotRecRda := 0
Local nTotTpfRda := 0
Local nTotAprGer := 0
Local nTotPagGer := 0
Local nTotGloGer := 0
Local nTotRecGer := 0
Local nTotTpfGer := 0

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para Impressao do Cabecalho e Rodape    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
li    := 80
m_pag := 1
nTipo := GetMv("MV_COMP")

SetRegua(Len(aTotRda))

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Imprime relatorio...										 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
While nPos <= Len(aTotRda)
    
	cCompet := aTotRda[nPos][18]
	nTotAprCmp := 0
	nTotPagCmp := 0
	nTotGloCmp := 0
	nTotRecCmp := 0
	nTotTpfCmp := 0

	While nPos<=Len(aTotRda) .and. aTotRda[nPos][18]==cCompet

		cCmpOri := aTotRda[nPos][11]

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Imprime cabecalho...                                               ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If Li > nQtdLin
			Cabec(cTitulo,cabec1,cabec2,nomeprog,tamanho,nTipo)
		Endif
        
		If nTipRel == 1
			Li++
			@ Li,000 PSay "Competência do Recurso: " + substr(cCompet,5,2) + "/" + substr(cCompet,1,4) + " - " + "Mês/Ano Origem: " + substr(cCmpOri,5,2) + "/" + substr(cCmpOri,1,4)
			Li++
		Endif
					
		While nPos<=Len(aTotRda) .and. aTotRda[nPos][18]==cCompet .and. aTotRda[nPos][11]==cCmpOri
            
			cChaGui    := aTotRda[nPos][1]
			cRemOri    := aTotRda[nPos][10]
			cRisco     := aTotRda[nPos][17]
			dDatRev    := aTotRda[nPos][15]
			nTotAprGui := 0
			nTotPagGui := 0
			nTotGloGui := 0
			nTotRecGui := 0
			nTotTpfGui := 0
		
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Imprime cabecalho...                                               ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If Li > nQtdLin
				Cabec(cTitulo,cabec1,cabec2,nomeprog,tamanho,nTipo)
			Endif

			If nTipRel == 1
				Li++
				@ Li,000 PSay Transform(aTotRda[nPos][1],"@R 9999.9999.99999999.99999999.9") + "  " + Transform(aTotRda[nPos][6],"@R 9999.9999.99999999.99999999.9") + "  " + IIF(Empty(cRemOri),space(8),cRemOri) + "  " + IIF(Empty(cRisco),space(2),cRisco) + "  " + DtoC(dDatRev) + "   " + IIF(nImprim<>1,aTotRda[nPos][21],"")
				Li++
			Endif
		
			While nPos<=Len(aTotRda) .and. aTotRda[nPos][11]==cCmpOri .and. aTotRda[nPos][18]==cCompet .and. aTotRda[nPos][1]==cChaGui

				nGlosa  := ((aTotRda[nPos][14]*100)/aTotRda[nPos][13])
				nRecup  := ((aTotRda[nPos][16]*100)/aTotRda[nPos][14])
				nGloMan := IIF(aTotRda[nPos][14]=0,0,(aTotRda[nPos][14]-aTotRda[nPos][16]))
				nPerGlo := ((nGloMan*100)/aTotRda[nPos][14])
				
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Incrementa Regua...                                                ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				IncRegua()
				
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Imprime cabecalho...                                               ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				If Li > nQtdLin
					Cabec(cTitulo,cabec1,cabec2,nomeprog,tamanho,nTipo)
				Endif
				
				If nTipRel == 1
					@ Li,000 PSay aTotRda[nPos][5] + " " + aTotRda[nPos][2] + "." + aTotRda[nPos][3] + " " + aTotRda[nPos][4] + " " + Transform(aTotRda[nPos][12],"@E 99,999,999.99") + " " + Transform(aTotRda[nPos][13],"@E 99,999,999.99") + " " + Transform(aTotRda[nPos][14],"@E 99,999,999.99") + " " + Transform(nGlosa,"@E 999.99") + " " + Transform(aTotRda[nPos][16],"@E 99,999,999.99") + " " + Transform(nRecup,"@E 999.99") + " " + Transform(nGloMan,"@E 99,999,999.99") + " " + Transform(nPerGlo,"@E 9,999.99") + " " + IIF(nImpCop==1,Transform(aTotRda[nPos][20],"@E 99,999,999.99"),"")
					Li++
				Endif
			
				nTotAprGui += aTotRda[nPos][12]
				nTotPagGui += aTotRda[nPos][13]
				nTotGloGui += aTotRda[nPos][14]
				nTotRecGui += aTotRda[nPos][16]
				nTotTpfGui += aTotRda[nPos][20]
						    
				nPos++
			EndDo
			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Imprime cabecalho...                                               ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If Li > nQtdLin
				Cabec(cTitulo,cabec1,cabec2,nomeprog,tamanho,nTipo)
			Endif
			
			nGlosa  := ((nTotGloGui*100)/nTotPagGui)
			nRecup  := ((nTotRecGui*100)/nTotGloGui)
			nGloMan := IIF(nTotGloGui=0,0,(nTotGloGui-nTotRecGui))
			nPerGlo := ((nGloMan*100)/nTotGloGui)
		
			If nTipRel == 1
				@ Li,000 PSay Space(59) + "Total da Conta: " + Transform(nTotAprGui,"@E 99,999,999.99") + " " + Transform(nTotPagGui,"@E 99,999,999.99") + " " + Transform(nTotGloGui,"@E 99,999,999.99") + " " + Transform(nGlosa,"@E 999.99") + " " + Transform(nTotRecGui,"@E 99,999,999.99") + " " + Transform(nRecup,"@E 999.99") + " " + Transform(nGloMan,"@E 99,999,999.99") + " " + Transform(nPerGlo,"@E 9,999.99") + " " + IIF(nImpCop==1,Transform(nTotTpfGui,"@E 99,999,999.99"),"")
				Li++
			Endif
		
			nTotAprCmp += nTotAprGui
			nTotPagCmp += nTotPagGui
			nTotGloCmp += nTotGloGui
			nTotRecCmp += nTotRecGui
			nTotTpfCmp += nTotTpfGui
				
		EndDo             
		
	EndDo

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Imprime cabecalho...                                               ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If Li > nQtdLin
		Cabec(cTitulo,cabec1,cabec2,nomeprog,tamanho,nTipo)
	Endif
	
	nGlosa  := ((nTotGloCmp*100)/nTotPagCmp)
	nRecup  := ((nTotRecCmp*100)/nTotGloCmp)
	nGloMan := IIF(nTotGloCmp=0,0,(nTotGloCmp-nTotRecCmp))
	nPerGlo := ((nGloMan*100)/nTotGloCmp)

	If nTipRel == 1
		@ Li,000 PSay Space(53) + "Total da Competência: " + Transform(nTotAprCmp,"@E 99,999,999.99") + " " + Transform(nTotPagCmp,"@E 99,999,999.99") + " " + Transform(nTotGloCmp,"@E 99,999,999.99") + " " + Transform(nGlosa,"@E 999.99") + " " + Transform(nTotRecCmp,"@E 99,999,999.99") + " " + Transform(nRecup,"@E 999.99") + " " + Transform(nGloMan,"@E 99,999,999.99") + " " + Transform(nPerGlo,"@E 9,999.99") + " " + IIF(nImpCop==1,Transform(nTotTpfCmp,"@E 99,999,999.99"),"")
		Li++                     
    Else
		@ Li,000 PSay aTotRda[nPos-1][7] + " " + aTotRda[nPos-1][8] + " " + IIF(aTotRda[nPos-1][9]=="F","PF","PJ") + " " + aTotRda[nPos-1][19] + " " + cRemOri + " " + substr(cCmpOri,5,2) + "/" + substr(cCmpOri,1,4) + " " + substr(cCompet,5,2) + "/" + substr(cCompet,1,4) + " " + DtoC(dDatRev) + " " + Transform(nTotAprCmp,"@E 99,999,999.99") + " " + Transform(nTotPagCmp,"@E 99,999,999.99") + " " + Transform(nTotGloCmp,"@E 99,999,999.99") + " " + Transform(nGlosa,"@E 999.99") + " " + Transform(nTotRecCmp,"@E 99,999,999.99") + " " + Transform(nRecup,"@E 999.99") + " " + Transform(nGloMan,"@E 99,999,999.99") + " " + Transform(nPerGlo,"@E 9,999.99") + IIF(nImpCop==1," ","") + IIF(nImpCop==1,Transform(nTotTpfCmp,"@E 99,999,999.99"),"") + " " + cRisco
		Li++                     
    Endif
        
	nTotAprGer += nTotAprCmp
	nTotPagGer += nTotPagCmp
	nTotGloGer += nTotGloCmp
	nTotRecGer += nTotRecCmp
	nTotTpfGer += nTotTpfCmp
		
EndDo

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Imprime cabecalho...                                               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If Li > nQtdLin
	Cabec(cTitulo,cabec1,cabec2,nomeprog,tamanho,nTipo)
Endif

nGlosa  := ((nTotGloGer*100)/nTotPagGer)
nRecup  := ((nTotRecGer*100)/nTotGloGer)
nGloMan := IIF(nTotGloGer=0,0,(nTotGloGer-nTotRecGer))
nPerGlo := ((nGloMan*100)/nTotGloGer)

@ Li,000 PSay Space(62) + IIF(nTipRel==1,"",space(17)) + "Total Geral: " + Transform(nTotAprGer,"@E 99,999,999.99") + " " + Transform(nTotPagGer,"@E 99,999,999.99") + " " + Transform(nTotGloGer,"@E 99,999,999.99") + " " + Transform(nGlosa,"@E 999.99") + " " + Transform(nTotRecGer,"@E 99,999,999.99") + " " + Transform(nRecup,"@E 999.99") + " " + Transform(nGloMan,"@E 99,999,999.99") + " " + Transform(nPerGlo,"@E 9,999.99") + " " + IIF(nImpCop==1,Transform(nTotTpfGer,"@E 99,999,999.99"),"")
Li++                     

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ CriaSX1    ºAutor ³Thiago Machado Correa º Data ³ 14/09/08 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Cria pergunta no SX1 caso necessario						  º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function CriaSX1(cPerg)

PutSx1(cPerg,"01",OemToAnsi("Operadora")              ,"","","mv_ch1","C",04,0,0,"G","","B89","","","mv_par01",""           ,"","","",""                ,"","",""               ,"","","","","","","","",{},{},{})
PutSx1(cPerg,"02",OemToAnsi("RDA De")                 ,"","","mv_ch2","C",06,0,0,"G","","BA0","","","mv_par02",""           ,"","","",""                ,"","",""               ,"","","","","","","","",{},{},{})
PutSx1(cPerg,"03",OemToAnsi("RDA Ate")                ,"","","mv_ch3","C",06,0,0,"G","","BA0","","","mv_par03",""           ,"","","",""                ,"","",""               ,"","","","","","","","",{},{},{})
PutSx1(cPerg,"04",OemToAnsi("Ano/Mes Recurso De")     ,"","","mv_ch4","C",06,0,0,"G","",""   ,"","","mv_par04",""           ,"","","",""                ,"","",""               ,"","","","","","","","",{},{},{})
PutSx1(cPerg,"05",OemToAnsi("Ano/Mes Recurso Ate")    ,"","","mv_ch5","C",06,0,0,"G","",""   ,"","","mv_par05",""           ,"","","",""                ,"","",""               ,"","","","","","","","",{},{},{})
PutSx1(cPerg,"06",OemToAnsi("Ano/Mes Origem De")      ,"","","mv_ch6","C",06,0,0,"G","",""   ,"","","mv_par06",""           ,"","","",""                ,"","",""               ,"","","","","","","","",{},{},{})
PutSx1(cPerg,"07",OemToAnsi("Ano/Mes Origem Ate")     ,"","","mv_ch7","C",06,0,0,"G","",""   ,"","","mv_par07",""           ,"","","",""                ,"","",""               ,"","","","","","","","",{},{},{})
PutSx1(cPerg,"08",OemToAnsi("Protocolo de Remessa")   ,"","","mv_ch8","C",08,0,0,"G","",""   ,"","","mv_par08",""           ,"","","",""                ,"","",""               ,"","","","","","","","",{},{},{})
PutSx1(cPerg,"09",OemToAnsi("Tipo Relatório")         ,"","","mv_ch9","N",01,0,0,"C","",""   ,"","","mv_par09","Analitico"  ,"","","","Sintetico"       ,"","",""               ,"","","","","","","","",{},{},{})
PutSx1(cPerg,"10",OemToAnsi("Fase")                   ,"","","mv_cha","N",01,0,0,"C","",""   ,"","","mv_par10","Pronta"     ,"","","","Faturada"        ,"","","Conferência"    ,"","","","","","","","",{},{},{})
PutSx1(cPerg,"11",OemToAnsi("Imprimir Numero")        ,"","","mv_chb","N",01,0,0,"C","",""   ,"","","mv_par11","Guia"       ,"","","","Impresso"        ,"","",""               ,"","","","","","","","",{},{},{})
PutSx1(cPerg,"12",OemToAnsi("Imprimir Bloqueadas")    ,"","","mv_chc","N",01,0,0,"C","",""   ,"","","mv_par12","Sim"        ,"","","","Nao"             ,"","","Todas"          ,"","","","","","","","",{},{},{})
PutSx1(cPerg,"13",OemToAnsi("Somente Guias Cobradas") ,"","","mv_chd","N",01,0,0,"C","",""   ,"","","mv_par13","Sim"        ,"","","","Nao"             ,"","",""               ,"","","","","","","","",{},{},{})
PutSx1(cPerg,"14",OemToAnsi("Data Procedimento De")   ,"","","mv_che","D",08,0,0,"G","",""   ,"","","mv_par14",""           ,"","","",""                ,"","",""               ,"","","","","","","","",{},{},{})
PutSx1(cPerg,"15",OemToAnsi("Data Procedimento Ate")  ,"","","mv_chf","D",08,0,0,"G","",""   ,"","","mv_par15",""           ,"","","",""                ,"","",""               ,"","","","","","","","",{},{},{})
PutSx1(cPerg,"16",OemToAnsi("LDP De")                 ,"","","mv_chg","C",04,0,0,"G","",""   ,"","","mv_par16",""           ,"","","",""                ,"","",""               ,"","","","","","","","",{},{},{})
PutSx1(cPerg,"17",OemToAnsi("LDP Ate")                ,"","","mv_chh","C",04,0,0,"G","",""   ,"","","mv_par17",""           ,"","","",""                ,"","",""               ,"","","","","","","","",{},{},{})
PutSx1(cPerg,"18",OemToAnsi("PEG De")                 ,"","","mv_chi","C",08,0,0,"G","",""   ,"","","mv_par18",""           ,"","","",""                ,"","",""               ,"","","","","","","","",{},{},{})
PutSx1(cPerg,"19",OemToAnsi("PEG Ate")                ,"","","mv_chj","C",08,0,0,"G","",""   ,"","","mv_par19",""           ,"","","",""                ,"","",""               ,"","","","","","","","",{},{},{})
PutSx1(cPerg,"20",OemToAnsi("Numero De")              ,"","","mv_chk","C",08,0,0,"G","",""   ,"","","mv_par20",""           ,"","","",""                ,"","",""               ,"","","","","","","","",{},{},{})
PutSx1(cPerg,"21",OemToAnsi("Numero Ate")             ,"","","mv_chl","C",08,0,0,"G","",""   ,"","","mv_par21",""           ,"","","",""                ,"","",""               ,"","","","","","","","",{},{},{})
PutSx1(cPerg,"22",OemToAnsi("Empresa De")             ,"","","mv_chm","C",04,0,0,"G","",""   ,"","","mv_par22",""           ,"","","",""                ,"","",""               ,"","","","","","","","",{},{},{})
PutSx1(cPerg,"23",OemToAnsi("Empresa Ate")            ,"","","mv_chn","C",04,0,0,"G","",""   ,"","","mv_par23",""           ,"","","",""                ,"","",""               ,"","","","","","","","",{},{},{})
PutSx1(cPerg,"24",OemToAnsi("Contrato De")            ,"","","mv_cho","C",12,0,0,"G","",""   ,"","","mv_par24",""           ,"","","",""                ,"","",""               ,"","","","","","","","",{},{},{})
PutSx1(cPerg,"25",OemToAnsi("Contrato Ate")           ,"","","mv_chp","C",12,0,0,"G","",""   ,"","","mv_par25",""           ,"","","",""                ,"","",""               ,"","","","","","","","",{},{},{})
PutSx1(cPerg,"26",OemToAnsi("Sub-Contrato De")        ,"","","mv_chq","C",09,0,0,"G","",""   ,"","","mv_par26",""           ,"","","",""                ,"","",""               ,"","","","","","","","",{},{},{})
PutSx1(cPerg,"27",OemToAnsi("Sub-Contrato Ate")       ,"","","mv_chr","C",09,0,0,"G","",""   ,"","","mv_par27",""           ,"","","",""                ,"","",""               ,"","","","","","","","",{},{},{})
PutSx1(cPerg,"28",OemToAnsi("Plano De")               ,"","","mv_chs","C",04,0,0,"G","",""   ,"","","mv_par28",""           ,"","","",""                ,"","",""               ,"","","","","","","","",{},{},{})
PutSx1(cPerg,"29",OemToAnsi("Plano Ate")              ,"","","mv_cht","C",04,0,0,"G","",""   ,"","","mv_par29",""           ,"","","",""                ,"","",""               ,"","","","","","","","",{},{},{})
PutSx1(cPerg,"30",OemToAnsi("Procedimento De")        ,"","","mv_chu","C",16,0,0,"G","",""   ,"","","mv_par30",""           ,"","","",""                ,"","",""               ,"","","","","","","","",{},{},{})
PutSx1(cPerg,"31",OemToAnsi("Procedimento Ate")       ,"","","mv_chv","C",16,0,0,"G","",""   ,"","","mv_par31",""           ,"","","",""                ,"","",""               ,"","","","","","","","",{},{},{})
PutSx1(cPerg,"32",OemToAnsi("Imprime Co-Participação"),"","","mv_chx","N",01,0,0,"C","",""   ,"","","mv_par32","Sim"        ,"","","","Nao"             ,"","",""               ,"","","","","","","","",{},{},{})
PutSx1(cPerg,"33",OemToAnsi("Grupo de Pagamento De")  ,"","","mv_chy","C",04,0,0,"G","",""   ,"","","mv_par33",""           ,"","","",""                ,"","",""               ,"","","","","","","","",{},{},{})
PutSx1(cPerg,"34",OemToAnsi("Grupo de Pagamento Ate") ,"","","mv_chz","C",04,0,0,"G","",""   ,"","","mv_par34",""           ,"","","",""                ,"","",""               ,"","","","","","","","",{},{},{})

Return