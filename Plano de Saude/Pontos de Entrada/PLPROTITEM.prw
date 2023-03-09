#include "protheus.ch"
#include "rwmake.ch"
#include "topconn.ch"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ PLPROTITEM º Autor ³ Frederico O. C. Jr  º Data ³ 31/01/12 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ 	* O Ponto de entrada para levar dados do protocolo de     º±±
±±º          ³ 	Reembolso para a autorização de reembolso				  º±±
±±º          ³ 															  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Protheus                                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function PLPROTITEM()

Local aArea			:= GetArea()

Local aColsB45		:= PARAMIXB[1]
Local aCabB45		:= PARAMIXB[2]
Local nPosFtR		:= PLRETPOS("B45_YFTREE", aCabB45)
Local nPosCdPad		:= PLRETPOS("B45_CODPAD", aCabB45)
Local nPosCdPro		:= PLRETPOS("B45_CODPRO", aCabB45)
Local nPosVlEve		:= PLRETPOS("B45_VLRAPR", aCabB45)
Local nPosVlFor		:= PLRETPOS("B45_YVLFOR", aCabB45)
Local i				:= 0
Local aDadUser		:= PLSDADUSR(BOW->BOW_USUARI, "1", .T., dDatabase)
Local aTbReem		:= {}
Local lProtComp		:= .F.

M->B44_YCDPTC	:= BOW->BOW_YCDPTC
M->B44_DATREC	:= BOW->BOW_DTDIGI
M->B44_DTDIGI	:= dDataBase
M->B44_DATPRO	:= BOW->BOW_XDTEVE
M->B44_NOMUSR	:= BOW->BOW_NOMUSR
M->B44_YCDPRO	:= BOW->BOW_XCDPLA
M->B44_YDSPRO	:= Posicione("BI3",1,xFilial("BI3")+PlsIntPad()+BOW->BOW_XCDPLA,"BI3_DESCRI")
M->B44_PADINT	:= BOW->BOW_PADINT
M->B44_DESPAD	:= Posicione("BI4",1,xFilial("BI4")+BOW->BOW_PADINT,"BI4_DESCRI")
M->B44_XBANCO	:= BOW->BOW_NROBCO
M->B44_XAGENC	:= BOW->BOW_NROAGE
M->B44_XCONTA	:= BOW->BOW_NROCTA
M->B44_XDGCON	:= BOW->BOW_XDGCON
M->B44_DATPAG	:= BOW->BOW_DATPAG
M->B44_OPEEXE	:= BOW->BOW_OPEEXE
M->B44_SIGEXE	:= BOW->BOW_SIGLA
M->B44_ESTEXE	:= BOW->BOW_ESTEXE
M->B44_REGEXE	:= BOW->BOW_REGEXE
M->B44_NOMEXE	:= BOW->BOW_NOMEXE
M->B44_CDPFRE	:= BOW->BOW_CDPFRE
M->B44_SENHA	:= BOW->BOW_SENHA
M->B44_XCBOS	:= BOW->BOW_XCBOS
M->B44_XDSCBO	:= Posicione("B0X",1,xFilial("B0X")+BOW->BOW_XCBOS,"B0X_DESCBO")
M->B44_FORPAG	:= "1"
M->B44_YSENHA	:= BOW->BOW_XSENHA
M->B44_CPFEXE	:= Posicione("ZZQ",1,xFilial("ZZQ")+BOW->BOW_YCDPTC,"ZZQ_CPFEXE")

ZZQ->(DbSetOrder(1))	// ZZQ_FILIAL+ZZQ_SEQUEN
if ZZQ->(DbSeek( xFilial("ZZQ") + BOW->BOW_YCDPTC ))
	if !empty(ZZQ->ZZQ_PROORI)
		lProtComp	:= .T.
	endif
endif

for i := 1 to len(aColsB45)

	// BUSCAR PARAMETRIZAÇÃO DE REEMBOLSO (PDC -> B7T)
	if len(aDadUser) > 0

		aTbReem		:= U_RtTbReem(aDadUser, "", aColsB45[i][nPosCdPad], aColsB45[i][nPosCdPro], BOW->BOW_XTPEVE, BOW->BOW_PADINT, BOW->BOW_XDTEVE)

		if aTbReem[1] <> 0
			if aTbReem[2][2] <> 0
				aColsB45[i][nPosFtR]	:= aTbReem[2][2]
			endif
		endif
	
	endif

	// Tratar valor forçado
	if lProtComp
		aColsB45[i][nPosVlFor]	:= aColsB45[i][nPosVlEve]
	endif

next

RestArea(aArea)

return aColsB45
