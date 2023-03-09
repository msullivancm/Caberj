#INCLUDE "RWMAKE.CH"
#include "PLSMGER.CH"
#include "COLORS.CH"
#include "TOPCONN.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³PLSAUT03  ºAutor  ³Microsiga           º Data ³  04/06/07   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Ponto de entrada para calcular co-participacao do reembolso º±±
±±º          ³conforme regras Caberj.                                     º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function NivAutRee()
Local aRetorno	:= paramixb[1]
Local aDadUsr	:= paramixb[19]
Local _aVetCop	:= {}
Local cRDARee	:= GetNewPar("MV_YRDAREE","999998")
Local _aAreaBB8	:= BB8->(GetArea())
Local _aAreaBAX	:= BAX->(GetArea())
Local _aAreaBAU	:= BAU->(GetArea())
Local cCodLoc	:= ""
Local cCodMun	:= ""
Local cCodEsp	:= ""
Local cSubEsp	:= ""
Local dDatPro	:= CtoD("")
Local cHorPro	:= ""

If FunName() == "PLSA987"

	BB8->(DbSetOrder(1))
	BAX->(DbSetOrder(1))
	BAU->(DbSetOrder(1))
	
	BAU->(MsSeek(xFilial("BAU")+cRDARee))
	BB8->(MsSeek(xFilial("BB8")+cRDARee+PLSINTPAD()))
	BAX->(MsSeek(xFilial("BAX")+cRDARee+PLSINTPAD()+BB8->BB8_CODLOC))
	
	cCodLoc := BB8->BB8_LOCAL
	cCodMun	:= BB8->BB8_CODMUN
	cCodEsp := BAX->BAX_CODESP
	cSubEsp	:= BAX->BAX_CODSUB
	
	If Empty(dDatPro)
		dDatPro := dDataBase
		M->BKD_DATA := dDataBase
	Endif
	
	If !Empty(M->BKE_YDTPRO)
		dDatPro := M->BKE_YDTPRO
	Endif
	
	If !Empty(M->BKE_YHRPRO)
		cHorPro := M->BKE_YHRPRO
	Endif
	
	_aVetCop    := PLSTABCOP(M->BKE_CODTAB,M->BKE_CODPRO,PLSINTPAD(),cRDARee,cCodEsp,cSubEsp,cCodLoc,;
						"",Substr(aDadUsr[38],1,4),aDadUsr[9],aDadUsr[39],aDadUsr[41],aDadUsr[42],aDadUsr[11],;
						aDadUsr[45],aDadUsr[12],"",BAU->BAU_TIPPRE,cCodMun,.T.,.F.,;
						Substr(aDadUsr[2],9,6),Substr(aDadUsr[2],15,2),dDatPro,aDadUsr[48],.F.,aRetorno[3],aRetorno[4],; //cNivAut, cChaveAut
						NIL,Substr(DtoS(dDatPro),5,2),Substr(DtoS(dDatPro),1,4),dDatPro,cHorPro,"2","",0,M->BKE_QTDPRO,{},{},0)
	
	If M->BKE_VLRPAG > 0
		//M->BKE_VLRRBS := IF(M->BKE_VLRPAG<M->BKE_VLRCST-((M->BKE_VLRCST*M->BKE_PERREM)/100),M->BKE_VLRPAG,M->BKE_VLRCST-((M->BKE_VLRCST*M->BKE_PERREM)/100))
		
		If _aVetCop[2] > 0
		
			If M->BKE_VLRRBS == M->BKE_VLRPAG
				M->BKE_PREPAG := Iif(_aVetCop[2]<100,100-_aVetCop[2],100)  
			Else
				M->BKE_PERREM := Iif(_aVetCop[2]<100,100-_aVetCop[2],100)  
			Endif
			
		Endif
		
		If M->BKE_VLRPAG > 0
			If M->BKE_PERREM > 0 
				If M->BKE_VLRCST <= M->BKE_VLRRBS
					M->BKE_VLRRBS := M->BKE_VLRCST*(M->BKE_PERREM/100)
				Endif
			Endif
			If M->BKE_PREPAG > 0
				If M->BKE_VLRPAG <= M->BKE_VLRRBS
					M->BKE_VLRRBS := M->BKE_VLRPAG*(M->BKE_PREPAG/100)
				Endif
			Endif
		Endif
		
		RestArea(_aAreaBAX)
		RestArea(_aAreaBB8)
		RestArea(_aAreaBAU)	
		
	Endif

Endif	

lRefresh := .T.
oEnchoice:Refresh()
	
Return aRetorno