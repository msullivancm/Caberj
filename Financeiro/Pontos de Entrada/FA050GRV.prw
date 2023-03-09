#INCLUDE "RWMAKE.CH"
#include "PLSMGER.CH"
#include "COLORS.CH"
#include "TOPCONN.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³FA050GRV  ºMotta  ³Caberj              º Data ³  04/11/08   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³  Ponto de Entrada para gravacao do campo E2_CCD (Centro    º±±
±±º          ³  de Custo) baseado em regra do Financeiro                  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß 
//
//	Alteracao:	31/01/13	- Vitor Sbano	- Gravacao de Campo de Data Liberacao (E2_DATALIB) para registros não originados no PLS
//
//
*/

User Function FA050GRV()

Local cAmb    := GetArea()
Local lGrvCod := .F.



If     cEmpAnt == "01" // Caberj
	If SE2->E2_NATUREZ  $ ("PIS|NDF|ISS|IRF|INSS|CSLL|COFINS")
		If Empty(SE2->E2_CCD)
			RecLock("SE2",.F.)
			SE2->E2_CCD := "998"
			MsUnlock()
		Endif
	Endif
Elseif cEmpAnt == "02" // Integral
	If SE2->E2_PREFIXO = "COM"
		If Empty(SE2->E2_CCD)
			RecLock("SE2",.F.)
			SE2->E2_CCD := "99999"
			MsUnlock()
		Endif
	Endif
Endif
//   
DbSelectArea("SE2")                     &&
RecLock("SE2",.F.)						&&
//                                      &&    
SE2->E2_DATALIB:=Iif (Trim(M->e2_prefixo) + Trim(M->e2_tipo) + Trim(M->e2_origem) $ ('AEDFTPLSMPAG/CLIFTPLSMPAG/CONFTPLSMPAG/HOSFTPLSMPAG/INTFTPLSMPAG/LABFTPLSMPAG/MEDFTPLSMPAG/NFENFMATA100/NUPFTPLSMPAG/ODNFTPLSMPAG/OPEFTPLSMPAG/REMFTPLSMPAG/SVDFTPLSMPAG/UINNFMATA100'), Stod(""), dDataBase)

//SE2->E2_DATALIB	:=	dDATABASE			&& Inclusao 31/01/13 - Vitor Sbano - Implementacao de Bloqueio - Financeiro (fase 3 1/2)
//                                      &&
MsUnlock()                              &&
//										&&
//
RestArea(cAmb)

Return 
