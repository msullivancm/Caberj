
#Include "protheus.ch"
#Include "rwmake.ch"
#Include "topconn.ch"
#INCLUDE "plsmcon.ch"
#include "TCBROWSE.CH"
#include "PLSMGER.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³FuncCTB     ºAutor  ³ Jean Schulz      º Data ³  11/12/08   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Funcoes genericas destinadas a contabilizacao do PLS.       º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Caberj                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function P01_001VLR
Return IIF(BFQ->BFQ_YCTBPR=="1",IIF(BM1->(BM1_YVLACP+BM1_YVLACA+BM1_YVLANC) == 0 .and. U_CTBPLS06(.F.,'I')$'2/3' .And. Empty(BM1->BM1_AGFTFU),BM1->BM1_VALOR,0),0)

User Function P01_002VLR
Return IIF(BFQ->BFQ_YCTBPR=="1",IIF(BM1->(BM1_YVLACP+BM1_YVLACA+BM1_YVLANC) == 0.and.U_CTBPLS06(.F.,'I')=='6'.AND.BM1->BM1_TIPO=='2'.AND. Empty(BM1->BM1_AGFTFU),BM1->BM1_VALOR,0),0)

User Function P01_003VLR
Return IIF(BFQ->BFQ_YCTBPR=="1",IIF(BM1->(BM1_YVLACP+BM1_YVLACA+BM1_YVLANC) == 0 .and. U_CTBPLS06(.F.,'I')=='6'.AND.BM1->BM1_TIPO=='1'.And. Empty(BM1->BM1_AGFTFU),BM1->BM1_VALOR,0),0)

User Function P01_004VLR
Return IIF(BFQ->BFQ_YCTBPR=="1",IIF(BM1->BM1_YVLACP > 0 .and. U_CTBPLS06(.F.,'I')$'2/3' .And. Empty(BM1->BM1_AGFTFU),BM1->BM1_YVLACP,0),0)

User Function P01_005VLR
Return IIF(BFQ->BFQ_YCTBPR=="1",IIF(BM1->BM1_YVLACP > 0 .and. U_CTBPLS06(.F.,'I')=='6'.AND.BM1->BM1_TIPO=='2',BM1->BM1_YVLACP,0),0)                                                                            

User Function P01_006VLR
Return IIF(BFQ->BFQ_YCTBPR=="1",IIF(BM1->BM1_YVLACP > 0 .and. U_CTBPLS06(.F.,'I')=='6'.AND.BM1->BM1_TIPO=='1' .And. Empty(BM1->BM1_AGFTFU) ,BM1->BM1_YVLACP,0),0)

User Function P01_007VLR
Return IIF(BFQ->BFQ_YCTBPR=="1",IIF(BM1->BM1_YVLACA > 0 .and. U_CTBPLS06(.F.,'I')$'2/3' .And. Empty(BM1->BM1_AGFTFU),BM1->BM1_YVLACA,0),0)

User Function P01_008VLR
Return IIF(BFQ->BFQ_YCTBPR=="1",IIF(BM1->BM1_YVLACA > 0 .and. U_CTBPLS06(.F.,'I')=='6'.AND.BM1->BM1_TIPO=='2' .And. Empty(BM1->BM1_AGFTFU),BM1->BM1_YVLACA,0),0)

User Function P01_009VLR
Return IIF(BFQ->BFQ_YCTBPR=="1",IIF(BM1->BM1_YVLACA > 0 .and. U_CTBPLS06(.F.,'I')=='6'.AND.BM1->BM1_TIPO=='1' .And. Empty(BM1->BM1_AGFTFU),BM1->BM1_YVLACA,0),0)

User Function P01_010VLR
Return IIF(BFQ->BFQ_YCTBPR=="1",IIF(BM1->BM1_YVLANC > 0 .and. U_CTBPLS06(.F.,'I')$'2/3' .And. Empty(BM1->BM1_AGFTFU),BM1->BM1_YVLANC,0),0)

User Function P01_011VLR
Return IIF(BFQ->BFQ_YCTBPR=="1",IIF(BM1->BM1_YVLANC > 0 .and. U_CTBPLS06(.F.,'I')=='6'.AND.BM1->BM1_TIPO=='2' .And. Empty(BM1->BM1_AGFTFU),BM1->BM1_YVLANC,0),0)

User Function P01_012VLR
Return IIF(BFQ->BFQ_YCTBPR=="1",IIF(BM1->BM1_YVLANC > 0 .and. U_CTBPLS06(.F.,'I')=='6'.AND.BM1->BM1_TIPO=='1' .And. Empty(BM1->BM1_AGFTFU),BM1->BM1_YVLANC,0),0)


User Function P02_001VLR
Return IIF(Empty(BMN->BMN_LAPRO) .and. BMN->(BMN_YVLACP+BMN_YVLACA+BMN_YVLANC) == 0 .and. U_CTBPLS06(.F.,'P')$'2/3' .And. Empty(BMN->BMN_AGFTFU),BMN->BMN_VALOR,0)	                                                                         

User Function P02_002VLR
Return IIF(Empty(BMN->BMN_LAPRO) .and. BMN->(BMN_YVLACP+BMN_YVLACA+BMN_YVLANC) == 0 .and. U_CTBPLS06(.F.,'P')=='6'.AND.BMN->BMN_TIPO=='2' .And. Empty(BMN->BMN_AGFTFU),BMN->BMN_VALOR,0)	                                                   

User Function P02_003VLR
Return IIF(Empty(BMN->BMN_LAPRO) .and. BMN->(BMN_YVLACP+BMN_YVLACA+BMN_YVLANC) == 0 .and. U_CTBPLS06(.F.,'P')=='6'.AND.BMN->BMN_TIPO=='1' .And. Empty(BMN->BMN_AGFTFU),BMN->BMN_VALOR,0)	                                                   

User Function P02_004VLR
Return IIF(Empty(BMN->BMN_LAPRO) .and. BMN->BMN_YVLACP > 0 .and. U_CTBPLS06(.F.,'P')$'2/3' .And. Empty(BMN->BMN_AGFTFU),BMN->BMN_YVLACP,0)

User Function P02_005VLR
Return IIF(Empty(BMN->BMN_LAPRO) .and. BMN->BMN_YVLACP > 0 .and. U_CTBPLS06(.F.,'P')=='6'.AND.BMN->BMN_TIPO=='2' .And. Empty(BMN->BMN_AGFTFU),BMN->BMN_YVLACP,0)

User Function P02_006VLR
Return IIF(Empty(BMN->BMN_LAPRO) .and. BMN->BMN_YVLACP > 0 .and. U_CTBPLS06(.F.,'P')=='6'.AND.BMN->BMN_TIPO=='1' .And. Empty(BMN->BMN_AGFTFU),BMN->BMN_YVLACP,0)

User Function P02_007VLR
Return IIF(Empty(BMN->BMN_LAPRO) .and. BMN->BMN_YVLACA > 0 .and. U_CTBPLS06(.F.,'P')$'2/3' .And. Empty(BMN->BMN_AGFTFU),BMN->BMN_YVLACA,0)

User Function P02_008VLR
Return IIF(Empty(BMN->BMN_LAPRO) .and. BMN->BMN_YVLACA > 0 .and. U_CTBPLS06(.F.,'P')=='6'.AND.BMN->BMN_TIPO=='2' .And. Empty(BMN->BMN_AGFTFU),BMN->BMN_YVLACA,0)

User Function P02_009VLR
Return IIF(Empty(BMN->BMN_LAPRO) .and. BMN->BMN_YVLACA > 0 .and. U_CTBPLS06(.F.,'P')=='6'.AND.BMN->BMN_TIPO=='1' .And. Empty(BMN->BMN_AGFTFU),BMN->BMN_YVLACA,0)

User Function P02_010VLR
Return IIF(Empty(BMN->BMN_LAPRO) .and. BMN->BMN_YVLANC > 0 .and. U_CTBPLS06(.F.,'P')$'2/3' .And. Empty(BMN->BMN_AGFTFU),BMN->BMN_YVLANC,0)

User Function P02_011VLR
Return IIF(Empty(BMN->BMN_LAPRO) .and. BMN->BMN_YVLANC > 0 .and. U_CTBPLS06(.F.,'P')=='6'.AND.BMN->BMN_TIPO=='2' .And. Empty(BMN->BMN_AGFTFU),BMN->BMN_YVLANC,0)

User Function P02_012VLR
Return IIF(Empty(BMN->BMN_LAPRO) .and. BMN->BMN_YVLANC > 0 .and. U_CTBPLS06(.F.,'P')=='6'.AND.BMN->BMN_TIPO=='1' .And. Empty(BMN->BMN_AGFTFU),BMN->BMN_YVLANC,0)



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³DesconSD1 ºAutor  ³Microsiga           º Data ³  26/10/10   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Busca o valor do desconto rateado pelo item da nota fiscal º±±
±±º          ³ nos casos de OPME lancados via NF.                         º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function DesconSD1(cChaveGuia)
Local cSQL := ""
Local nVlrDesc := 0

cSQL := " SELECT D1_VALDESC "
cSQL += " FROM "+RetSQLName("B19")+" B19, "+RetSQLName("SD1")+" SD1 "
cSQL += " WHERE D1_FILIAL = '"+xFilial("SD1")+"' "
cSQL += " AND B19_GUIA = '"+cChaveGuia+"' "
cSQL += " AND D1_DOC = B19_DOC "
cSQL += " AND D1_SERIE = B19_SERIE "
cSQL += " AND D1_FORNECE = B19_FORNEC "
cSQL += " AND D1_LOJA = B19_LOJA "
cSQL += " AND D1_ITEM = B19_ITEM "
cSQL += " AND B19.D_E_L_E_T_ = ' ' "
cSQL += " AND SD1.D_E_L_E_T_ = ' ' "  

TCQUERY cSQL NEW Alias "TRBSD1"

While !TRBSD1->(Eof())

	nVlrDesc += TRBSD1->D1_VALDESC                      
	TRBSD1->(DbSkip())           
	
Enddo

TRBSD1->(DbCloseArea())

Return nVlrDesc



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  |RetHisAgl ºAutor  ³Microsiga           º Data ³  10/26/10   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function RetHisAgl
Local cRet := ""
Local aAreaBFQ := BFQ->(GetArea())
Local aAreaBI3 := BI3->(GetArea())


RestArea(aAreaBFQ)
RestArea(aAreaBI3)

Return cRet