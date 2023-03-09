#INCLUDE "RWMAKE.CH"
#include "PLSMGER.CH"
#include "COLORS.CH"
#include "TOPCONN.CH"
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³PLS987CLI ºAutor  ³Microsiga           º Data ³  09/28/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Ponto de entrada para alterar o cliente relativo ao reem-   º±±
±±º          ³bolso.                                                      º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function PLS987CLI()
LOCAL cCodCli	:= paramixb[1]  //Codigo do cliente padrao
LOCAL cLoja		:= paramixb[2]  //Loja Cliente padrao
LOCAL cNat		:= paramixb[3]  //Natureza Cliente
LOCAL cPrefixo	:= paramixb[4]  //Prefixo titulo
LOCAL cNumTit	:= paramixb[5]  //Numero do titulo
LOCAL cTipTit	:= paramixb[6]  //Tipo do titulo
LOCAL dVencto	:= paramixb[7]  //Dia do vencimento
LOCAL bRetorno  := { || {cCodCli,cLoja,cNat,cPrefixo,cNumTit,cTipTit,dVencto} }
Local aCodTab1	:= {}
Local aCompo1	:= {}
Local aAreaBKE	:= BKE->(GetArea())
Local aAreaBB8	:= BB8->(GetArea())
Local aAreaBAX	:= BAX->(GetArea())
Local cRDARee	:= GetNewPar("MV_YRDAREE","999998")
Local aSA1      := SA1->(GetArea())  
Local cCodLoc	:= ""
Local cCodEsp	:= ""
Local cSubEsp	:= ""
LOCAL aDadUsr	:= PLSGETUSR()
Local nCont		:= 0
Local aVetCom	:= {}
Local cStr		:= ""
Local cStr2		:= ""

SA1->(DbSetOrder(1))
BB8->(DbSetOrder(1))
BAX->(DbSetOrder(1))

BB8->(MsSeek(xFilial("BB8")+cRDARee+PLSINTPAD()))
BAX->(MsSeek(xFilial("BAX")+cRDARee+PLSINTPAD()+BB8->BB8_CODLOC))

cCodLoc := BB8->BB8_LOCAL
cCodEsp := BAX->BAX_CODESP
cSubEsp	:= BAX->BAX_CODSUB

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Mudar o cliente para geracao do titulo NCC.                                     |
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ		
If !Empty(M->BKD_YCDCLI)
	If SA1->(MsSeek(xFilial("SA1")+M->(BKD_YCDCLI+BKD_YLJCLI)))
		cCodCli	:= SA1->A1_COD
		cLoja	:= SA1->A1_LOJA
		cNat	:= Iif(!Empty(SA1->A1_NATUREZ),SA1->A1_NATUREZ,cNat)
	Endif
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Gravar composicao de pagamento dos codigos digitados no reembolso.              |
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If BKE->(MsSeek(xFilial("BKE")+M->BKD_CODRBS))

	While !BKE->(Eof()) .And. BKE->BKE_CODRBS == BKD->BKD_CODRBS
	
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Buscar composicao de pagamento do procedimento digitado...                      |
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ		
		aCodTab1 := PLSRETTAB(BKE->BKE_CODTAB,BKE->BKE_CODPRO,BKE->BKE_YDTPRO,;
		                            PLSINTPAD(),cRDARee,cCodEsp,Nil,BB8->(BB8_CODLOC+BB8_LOCAL),; //Nil1: Especialidade, Nil2: Subespecialidade, Nil3:BD6->(BD6_CODLOC+BD6_LOCAL)
		                            BKE->BKE_YDTPRO,"1",PLSINTPAD(),aDadUsr[11],"1","1") 
		                            
		aCompo1	:= PLSCOMEVE(aCodTab1[3],BKE->BKE_CODTAB,BKE->BKE_CODPRO,PLSINTPAD(),BKE->BKE_YDTPRO)	
		
		cStr := Alltrim(BKE->BKE_YCPPAG)
		cStr2 := ""
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Obter composicoes bloqueadas...                                                 |
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ		
		For nCont := 1 to Len(cStr)
			
			If Substr(cStr,nCont,1) == ","
				aadd(aVetCom,cStr2)
				cStr2 := ""
			Else
				cStr2 += Substr(cStr,nCont,1)
			Endif
			
		Next
		
		If !Empty(cStr2)
			aadd(aVetCom,cStr2)
		Endif

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Comparar composicoes bloqueadas, e gravar somente as que nao foram...           |
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ				
		For nCont := 1 to Len(aCompo1)
			If Substr(aCompo1[nCont,1],1,3) == "AUX"
				aCompo1[nCont,1] := aCompo1[nCont,1]+StrZero(aCompo1[nCont,3],2)
			Endif
		Next
		
		For nCont := 1 to Len(aCompo1)
		
			If ascan(aVetCom,Alltrim(aCompo1[nCont,1])) == 0
				ZZR->(RecLock("ZZR",.T.))  
				ZZR->ZZR_FILIAL := xFilial("ZZR") 
				ZZR->ZZR_CODRBS := BKE->BKE_CODRBS
				ZZR->ZZR_CODPRO := BKE->BKE_CODPRO
				ZZR->ZZR_CODCOM := Substr(aCompo1[nCont,1],1,3)
				ZZR->ZZR_ITECOM := Iif(Substr(aCompo1[nCont,1],1,3)=="AUX",StrZero(aCompo1[nCont,3],2),"")
				ZZR->(MsUnlock())
			Endif
			
		Next
						
		BKE->(DbSkip())
	
	Enddo

Endif

RestArea(aAreaBKE)
RestArea(aSA1) 

Return(Eval(bRetorno)) 