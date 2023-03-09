#include "PLSMGER.CH"
#include "PROTHEUS.CH"
#include "PLSMCCR.CH"                                               
#include "TOPCONN.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ ZZQSE1	  ³ Autor ³ *****				³ Data ³ 18.03.07 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Cria o titulo do reembolso - BACALHA						  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
 ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
 
User Function ZZQSE1

cSQL := "select B44_YCDPTC "
cSQL += "     , B44_DATVEN "
cSQL += "     , B44_CODCLI " 
cSQL += "     , B44_LOJA   "
cSQL += "     , B44_VLRPAG "
cSQL += "     , B44_OPEUSR "
cSQL += "     , B44_CODEMP "
cSQL += "     , B44_MATRIC "
cSQL += "     , B44_TIPREG "
cSQL += "     , B44_CONEMP "
cSQL += "     , B44_VERCON "
cSQL += "     , B44_SUBCON "
cSQL += "     , B44_VERSUB " 
if cEmpAnt == '01'
	cSQL += "  from B44010     "
else
	cSQL += "  from B44020     "
endif
cSQL += "     , ZZQBKP 	   "
cSQL += " WHERE B44_FILIAL = ' ' "
cSQL += "   AND B44_YCDPTC = PROTOCOLO   "
if cEmpAnt == '01'
	cSQL += "   AND OPERADORA = 'CABERJ' "
else
	cSQL += "   AND OPERADORA = 'INTEGRAL' "
endif
cSQL += "   AND B44_DATVEN >= '20131101' "
cSQL += "   AND B44_YCDPTC not in ('00081713','00081707') "
cSQL += "   AND D_E_L_E_T_ = ' ' "

PlsQuery(cSQL, "B44ZZQ")

DO While (B44ZZQ->(!EOF()))   

	cNat     := GetNewPar("MV_PLSNTRE",'"PLS"')
	cNat     := Eval({|| &cNat })
	cTipTit  := GetNewPar("MV_PLSNCRE","NCC")
	cPrefixo := GetNewPar("MV_PLSPFRE",'"RLE"')
	cPrefixo := Eval({|| &cPrefixo })                                                                          
	cNumTit  := PLSE1NUM(cPrefixo)   

	dVencto  := B44ZZQ->B44_DATVEN
	cCodCli  := B44ZZQ->B44_CODCLI
	cLoja    := B44ZZQ->B44_LOJA
	nVlrPag  := B44ZZQ->B44_VLRPAG
	cCodInt  := B44ZZQ->B44_OPEUSR
	cCodEmp  := B44ZZQ->B44_CODEMP
	cMatric  := B44ZZQ->B44_MATRIC
	cTipReg  := B44ZZQ->B44_TIPREG
	cConEmp  := B44ZZQ->B44_CONEMP
	cVerCon  := B44ZZQ->B44_VERCON
	cSubCon  := B44ZZQ->B44_SUBCON
	cVerSub  := B44ZZQ->B44_VERSUB   

	u_PLSGRVREMx(cPrefixo,cNumTit,cCodCli,cLoja,cTipTit,dVencto,cCodInt,cCodEmp,cMatric,'3'/*nOpc*/,nVlrPag,cConEmp,cVerCon,;
                 cSubCon,cVerSub,cTipReg,cNat,{})
	
	
	dbseek(xFilial("B44")+B44ZZQ->B44_YCDPTC)  
	
	B44->(Reclock("B44",.F.)) 
	
	B44->B44_PREFIX := cPrefixo
	B44->B44_NUM    := cNumTit 
	B44->B44_TIPO := cTipTit
	
	B44->(MsUnLock())
	
	B44ZZQ->(DBSKIP())	
	                                                                                                                                            

Enddo 

ALERT ("CONCLUIDO")	                

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ PLSGRVREMx ³ Autor ³ *****				³ Data ³ 18.03.07 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Cria o titulo do reembolso - BACALHA						  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
 ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function PLSGRVREMx(cPrefixo,cNumero,cCodCli,cLoja,cTipTit,dVencto,cCodInt,cCodEmp,cMatric,nOpc,nValor,cConEmp,cVerCon,;
                   cSubCon,cVerSub,cTipReg,cNat,aBanco)

LOCAL cCodEve      := "108"//reembolso livre escolha
LOCAL __cCodigo    := ""
LOCAL __cNumBDC    := ""
LOCAL cSeq	       := ""
LOCAL aCliente     := {}
DEFAULT nValor 	   := 0  
DEFAULT aBanco     := {} // {Cod,Agencia,Numero Conta}

//If nOpc == K_Incluir
	SA1->(DbSetOrder(1))
	SA1->(MsSeek(xFilial("SA1")+cCodCli+cLoja))
	BA1->(DbSetOrder(2))
	BA1->(MsSeek(xFilial("BA1")+cCodInt+cCodEmp+cMatric+cTipReg))
	BA3->(DbSetOrder(1))
	BA3->(MsSeek(xFilial("BA3")+cCodInt+cCodEmp+cMatric))
	BFQ->(DbSetOrder(1))
	BFQ->(MsSeek(xFilial("BGQ")+cCodInt+cCodEve))
    
	aCliente := PLS770NIV(BA3->BA3_CODINT,BA3->BA3_CODEMP,;
						  BA3->BA3_MATRIC,If(BA3->BA3_TIPOUS=="1","F","J"),;
						  BA3->BA3_CONEMP,BA3->BA3_VERCON,BA3->BA3_SUBCON,;
						  BA3->BA3_VERSUB,1)
    

	DbSelectArea("BDC")
	__cNumBDC:=PLSA625Num()
	BDC->(RecLock("BDC",.T.))
		BDC->BDC_FILIAL := xFilial("BDC")
		BDC->BDC_CODOPE := cCodInt
		BDC->BDC_NUMERO := __cNumBDC
    	BDC->BDC_DATGER := dDataBase
		BDC->BDC_USUOPE := PLRETOPE()                                                                                                                      
		BDC->BDC_HORA  := TIME() 	
		BDC->BDC_HORAF := TIME()	
		BDC->BDC_ANOINI:= subs(dtos(dDataBase),1,4)
		BDC->BDC_MESINI := subs(dtos(dDataBase),5,2)
		BDC->BDC_ANOFIM:= subs(dtos(dDataBase),1,4)
		BDC->BDC_MESFIM := subs(dtos(dDataBase),5,2)
	   	BDC->BDC_DTEMIS := dDataBase
		BDC->BDC_VALOR := nValor
		BDC->BDC_MODPAG := BA3->BA3_MODPAG
		BDC->BDC_REEMB  := "1"
	
		BDC->( ConfirmSx8() )
	BDC->(MsUnlock())

	
	// Grava o arquivo BBT, complemento do SE1 com informacoes do Plano de Saude.
	DbSelectArea("BBT")
	__cCodigo := GetSx8Num("BBT","BBT_CODIGO")
	BBT->( ConfirmSx8() )
	
	BBT->(RecLock("BBT",.T.))
	BBT->BBT_FILIAL := xFilial("BBT")
	BBT->BBT_CODIGO := __cCodigo
	BBT->BBT_CODOPE := cCodInt
	BBT->BBT_CODEMP := cCodEmp

	BBT->BBT_CONEMP := cConEmp
	BBT->BBT_VERCON := cVerCon	
	BBT->BBT_SUBCON := cSubCon
	BBT->BBT_VERSUB := cVerSub
	BBT->BBT_MATRIC := cMatric
	BBT->BBT_TIPREG := cTipReg
	If Len(aCliente) > 0 
		BBT->BBT_NIVEL  := aCliente[1][18]
    Endif
	BBT->BBT_CLIFOR := cCodCli
	BBT->BBT_LOJA   := cLoja
	BBT->BBT_VALOR  := nValor
	
	BBT->BBT_ANOTIT := subs(dtos(dDataBase),1,4)
	BBT->BBT_MESTIT := subs(dtos(dDataBase),5,2)
	
	BBT->BBT_PREFIX := cPrefixo
	BBT->BBT_NUMTIT := cNumero
	BBT->BBT_TIPTIT := cTipTit
	BBT->BBT_RECPAG := "0"
	If !Empty(BA1->BA1_CODPLA)
		BBT->BBT_CODPLA := BA1->BA1_CODPLA
		BBT->BBT_VERSAO := BA1->BA1_VERSAO
	Else
		BBT->BBT_CODPLA := BA3->BA3_CODPLA
		BBT->BBT_VERSAO := BA3->BA3_VERSAO
	Endif	
	BBT->BBT_INTERC := '0'
	BBT->BBT_MODPAG := BA3->BA3_MODPAG       
	BBT->BBT_NUMCOB := cCodInt+__cNumBDC       

	BBT->(MsUnlock())
	
	// Grava o titulo a receber...	
	SE1->(RecLock("SE1",.T.))
	SE1->E1_FILIAL   := xFilial("SE1")
	SE1->E1_TIPO     := cTipTit
	SE1->E1_CLIENTE  := cCodCli
	SE1->E1_LOJA     := cLoja          
	If !Empty(SA1->A1_NATUREZ)
		SE1->E1_NATUREZ  := SA1->A1_NATUREZ
	Else
		SE1->E1_NATUREZ  := cNat
	Endif
	SE1->E1_EMISSAO  := dDataBase
	SE1->E1_EMIS1    := dDataBase
	SE1->E1_SITUACA  := "0"
	SE1->E1_MOEDA    := 1
	SE1->E1_OCORREN  := "01"
	SE1->E1_FLUXO    := "S"
	SE1->E1_STATUS   := "A"
	SE1->E1_PROJPMS  := "2"
	SE1->E1_VENCORI  := dVencto
	SE1->E1_VENCTO   := IIF(dVencto<dDataBase, dDataBase, dVencto)
	SE1->E1_PREFIXO  := cPrefixo
	SE1->E1_NUM      := cNumero
	SE1->E1_VENCREA  := DataValida(SE1->E1_VENCTO)
	SE1->E1_VLCRUZ   := nValor
	SE1->E1_IRRF	    := 0
	SE1->E1_VALOR    := nValor
	SE1->E1_NOMCLI   := SA1->A1_NOME
	SE1->E1_SALDO    := SE1->E1_VALOR
	SE1->E1_DECRESC  := 0
	SE1->E1_SDDECRE  := 0
	SE1->E1_ACRESC   := 0
	SE1->E1_SDACRES  := 0
	SE1->E1_VALLIQ   := 0
	If Len(aBanco) > 0 
		SE1->E1_BCOCLI   := aBanco[1]
		SE1->E1_AGECLI   := aBanco[2]
		SE1->E1_CTACLI   := aBanco[3]
	Endif
	SE1->E1_NUMBCO   := ""
	SE1->E1_PLNUCOB  := ""
	SE1->E1_VALJUR   := 0
	SE1->E1_PORCJUR  := 0
	SE1->E1_CODINT   := cCodInt
	SE1->E1_CODEMP   := cCodEmp
	SE1->E1_MATRIC 	 := cMatric
	SE1->E1_CONEMP   := cConEmp
	SE1->E1_VERCON   := cVerCon
	SE1->E1_SUBCON   := cSubCon
	SE1->E1_VERSUB   := cVerSub
	SE1->E1_MESBASE  := subs(dtos(dDataBase),5,2)
	SE1->E1_ANOBASE  := subs(dtos(dDataBase),1,4)
	SE1->E1_MULTNAT  := "2"
	SE1->E1_NUMCON   := BA3->BA3_NUMCON
	SE1->E1_TIPREG   := BA1->BA1_TIPREG
	SE1->E1_ORIGEM   := 'PLSA001'
	SE1->(MsUnLock())
	
	If ExistBlock("PLSGE001")
		Execblock("PLSGE001",.F.,.F.,{})
	Endif
		
	cSeq    := PLSA625Cd("BM1_SEQ","BM1",1,"BM1->(BM1_CODINT+BM1_CODEMP+BM1_MATRIC+BM1_ANO+BM1_MES+BM1_TIPREG)",;
                         cCodInt+cCodEmp+BA3->BA3_MATRIC+subs(dtos(dDataBase),1,4)+subs(dtos(dDataBase),5,2)+cTipReg)
                         	
	BM1->(RecLock("BM1",.T.))
	BM1->BM1_FILIAL := xFilial("BM1")
	BM1->BM1_CODINT := cCodInt
	BM1->BM1_CODEMP := cCodEmp
	BM1->BM1_MATRIC := BA3->BA3_MATRIC
	BM1->BM1_TIPREG := cTipReg
	BM1->BM1_DIGITO := BA1->BA1_DIGITO
	BM1->BM1_NOMUSR := PLNOMUSR(BM1->BM1_CODINT+BM1->BM1_CODEMP+BM1->BM1_MATRIC+BM1->BM1_TIPREG)
	BM1->BM1_SEQ    := cSeq
	BM1->BM1_CONEMP := BA1->BA1_CONEMP
	BM1->BM1_VERCON := BA1->BA1_VERCON
	BM1->BM1_SUBCON := BA1->BA1_SUBCON
	BM1->BM1_VERSUB := BA1->BA1_VERSUB
	BM1->BM1_ANO    := IIF(Type("M->B44_ANOPAG")<>"U",M->B44_ANOPAG,subs(dtos(dDataBase),1,4))
	BM1->BM1_MES    := IIF(Type("M->B44_MESPAG")<>"U",M->B44_MESPAG,subs(dtos(dDataBase),5,2))
	BM1->BM1_TIPO   := BFQ->BFQ_DEBCRE
	BM1->BM1_VALOR  := nValor
	BM1->BM1_CODTIP := BFQ->(BFQ_PROPRI+BFQ_CODLAN)
	BM1->BM1_DESTIP := BFQ->BFQ_DESCRI
	BM1->BM1_CODEVE := ""
	BM1->BM1_DESEVE := ""
	BM1->BM1_ALIAS  := ""
	BM1->BM1_ORIGEM := ""
	BM1->BM1_BASEIR := 0
	BM1->BM1_MATUSU := BM1->BM1_CODINT+BM1->BM1_CODEMP+BM1->BM1_MATRIC+BM1->BM1_TIPREG
	BM1->BM1_PLNUCO := ""
	BM1->BM1_LTOTAL := "1"
	BM1->BM1_SEXO   := BA1->BA1_SEXO
	BM1->BM1_GRAUPA := BA1->BA1_GRAUPA
	BM1->BM1_CODFAI := ""
	BM1->BM1_NIVFAI := ""
	BM1->BM1_TIPUSU := BA3->BA3_TIPOUS
	BM1->BM1_CARGO  := '1'//STR0063 //"REEMBOLSO GERADO NO ATO"
	BM1->BM1_PREFIX := cPrefixo
	BM1->BM1_NUMTIT := cNumero
	BM1->BM1_TIPTIT := cTipTit                                      
	If Len(aCliente) > 0 
		BM1->BM1_NIVCOB := aCliente[1][18]
    Endif
	BM1->BM1_INTERC := "0"
	BM1->(MsUnLock())
	
//Endif

Return
